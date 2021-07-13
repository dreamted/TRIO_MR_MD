/*
*********************************************************************************************************
*                                              EXAMPLE CODE
*
*                          (c) Copyright 2003-2007; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*               Knowledge of the source code may NOT be used to develop a similar product.
*               Please help us continue to provide the Embedded community with the finest
*               software available.  Your honesty is greatly appreciated.
*********************************************************************************************************
*/
#define MAIN_C

#include "../include/main.h"

/*******************************************************************************
* Function Name  : InitStm32f103
* Description    : Initializes the stm32_x application.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

void InitStm32f103(void)
{
	NVIC_DeInit();
	InitRCC();
	InitAFIO();
	InitGPIO();
	#ifdef __FSMC_SRAM_H
		FSMC_SRAM_Init();
	#endif
	// Set the Vector Table base location at 0x08000000
	Tmr_TickInit(1L);	// timer init!!(1: 1ms)
}

/*******************************************************************************
* Function Name  : InitRCC
* Description    : Initializes the stm32_x rcc application.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

void InitRCC(void)
{
	INT16U tmpcnt = 0xffff;
	// SYSCLK, HCLK, PCLK2 and PCLK1 configuration
	// RCC system reset(for debug purpose)
	// RCC_DeInit();
	// Enable HSE, Wait till HSE is ready

	RCC->CFGR.Data = 0;

#ifdef HSE_USED
	if(RCC_WaitForHSEStartUp(1))
#else 
	if(RCC_WaitForHSEStartUp(0))
#endif
	{
		u32 tmpreg;

		// SYSTEM BUS CLOCK SELECTION
		RCC->CFGR.HPRE = __SYSCLK1;
		RCC->CFGR.PPRE2 = __HCLK1;
		RCC->CFGR.PPRE1 = __HCLK1;

		RCC->CFGR.ADCPRE = __PCLK22;	// ADCCLK = PCLK2/2 --> 36/2: 18MHz

		// Flash 1 wait state
#if   (SYSCLK	>= (48000000L))
		FLASH->ACR.Bit.LATENCY = LATENCY2;
#elif (SYSCLK	>= (24000000L))
		FLASH->ACR.Bit.LATENCY = LATENCY1;
#else
		FLASH->ACR.Bit.LATENCY = LATENCY0;
#endif
		FLASH->ACR.Bit.PRFTBE = ENABLE;

		RCC->CR.PLLON = DISABLE; // Enable PLL
		// CLOCK SOURCE SELECTION
		// PLLCLK = 8MHZ * 9 = 72 MHz
		RCC->CFGR.PLLMUL = __PLLMUL9;
		RCC->CFGR.PLLSRC = __HSESRC;
		RCC->CFGR.PLLXTPRE = __HSESRC2; // HSE CLK(8Mhz)/2 = 4 MHZ

		RCC->CR.PLLON = ENABLE; // Enable PLL

		tmpcnt = 0xffff;
		
		// Wait till PLL is ready
		do {
			tmpreg = RCC->CR.PLLRDY;
		}
		while(!tmpreg && tmpcnt--);
		
		RCC->CFGR.SW = __SW_PLL; // Select PLL as system clock source
		// Wait till PLL is used as system clock source
		tmpcnt = 0xffff;

		do {
			tmpreg = RCC->CFGR.SWS;
		}
		while(tmpreg != __SW_PLL && tmpcnt--);

	}
	else
	{
		/* Add here some code to deal with this error */
		u32 tmpreg;

		RCC->CFGR.HPRE = __SYSCLK1;
		RCC->CFGR.PPRE2 = __HCLK1;
		RCC->CFGR.PPRE1 = __HCLK1;

		RCC->CFGR.ADCPRE = __PCLK22;	// ADCCLK = PCLK2/2 --> 36/2: 18MHz

		// Flash 1 wait state
#if	  (SYSCLK	>= (48000000L))
		FLASH->ACR.Bit.LATENCY = LATENCY2;
#elif (SYSCLK	>= (24000000L))
		FLASH->ACR.Bit.LATENCY = LATENCY1;
#else
		FLASH->ACR.Bit.LATENCY = LATENCY0;
#endif
		FLASH->ACR.Bit.PRFTBE = ENABLE;
		
		// CLOCK SOURCE SELECTION
		// CASE 101: PLLCLK = 8MHZ * 4 = 32 MHz
		////////////////////////////////////////////////////////////////////////
		// 
		RCC->CR.PLLON = DISABLE; // Enable PLL
		
#if	  (SYSCLK	>  8000000L)
		RCC->CFGR.PLLMUL = ((SYSCLK/4000000L) - 2);

		RCC->CR.PLLON = ENABLE; // Enable PLL

		// Wait till PLL is ready
		do {
			tmpreg = RCC->CR.PLLRDY;
		}
		while(!tmpreg);

		RCC->CFGR.SW = __SW_PLL; // Select PLL as system clock source
		// Wait till PLL is used as system clock source
		do {
			tmpreg = RCC->CFGR.SWS;
		}
		while(tmpreg != __SW_PLL);
#else
		RCC->CFGR.SW = __SW_HSI; // Select PLL as system clock source
		// Wait till PLL is used as system clock source
		do {
			tmpreg = RCC->CFGR.SWS;
		}
		while(tmpreg != __SW_HSI);

#if	  (SYSCLK	>  4000000L)
			RCC->CFGR.HPRE = __SYSCLK1;
#else
			RCC->CFGR.HPRE = __SYSCLK2;
#endif
#endif
	}
}


/*******************************************************************************
* Function Name  : InitRCC
* Description    : Initializes the stm32_x afio application.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void InitAFIO(void)
{
	// APB2 BUS RELATED
	// EXTI_WAKEUP, GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF, GPIOE
	// TIM1, SPI1, TIM8, USART1, ADC1,2,3
	RCC->APB2ENR.Data |= ( __IOPAEN | __IOPBEN | __IOPCEN | __IOPDEN | __IOPEEN |
						  __AFIOEN | __ADC1EN | __TIM1EN | __SPI1EN
						);
	// APB1 BUS RELATED
	// PWREN, BKPEN
	// TIM2, TIM3, TIM4, TIM5, TIM6, TIM7, 
	// USART2, USART3, SPI2
	// I2C1, I2C2, bxCAN, USB20, SRAM512B, WWDB
	RCC->APB1ENR.Data |= (__USART3EN);

	// RELATED PORT
	// 1. PB4/JNTRST
	// 2. PB3/JTDO/TRACESWO
	// 3. PA15/JTCK/SWCLK
	// 4. PA13/JTMS/SWDIO

	AFIO->MAPR.SWJ_CFG = __SWJ_RMAP_DISABLE;
	AFIO->MAPR.PD01_REMAP = 1;
	
}

/*******************************************************************************
* Function Name  : InitGPIO
* Description    : Initializes the stm32_x gpio application.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

void InitGPIO(void)
{

////////////////////////////////////////////////////////////////////////////////////
//Port A Initiallization
	GPIOA->CNF.B0 = __ADC_IN0;
#ifdef __2rd
	GPIOA->CNF.B1 = __PA1_OUT_PP;		// DIP SW ID1
	GPIOA->ODR.B1 = SET;				// PULL-UP	
#else
	GPIOA->CNF.B1 = __ADC_IN1;
#endif
	GPIOA->CNF.B2 = __ADC_IN2; 
	GPIOA->CNF.B3 = __ADC_IN3; 
	
#ifdef __2rd
	GPIOA->CNF.B4 = __PA4_IN_PU;
	GPIOA->ODR.B4 = SET;				// PULL-UP	
#else
	GPIOA->CNF.B4 = __ADC_IN4;
#endif
	GPIOA->CNF.B5 = __ADC_IN5; 
	GPIOA->CNF.B6 = __ADC_IN6;
	GPIOA->CNF.B7 = __ADC_IN7;


	GPIOA->CNF.B8 = __PA8_IN_PU;
	GPIOA->ODR.B8 = SET;				// PULL-UP	

	GPIOA->CNF.B9 = __USART1_TX;
	GPIOA->CNF.B10 = __USART1_RX;


	GPIOA->CNF.B11 = __PA11_OU_PP;
	GPIOA->ODR.B11 = SET;				// PULL-UP	

	GPIOA->CNF.B12 = __PA12_IN_PU;
	GPIOA->ODR.B12 = SET;				// PULL-UP	

	GPIOA->CNF.B13 = __PA13_OU_PP;		// DIP SW ID1
	GPIOA->ODR.B13 = SET;				// PULL-UP	

	GPIOA->CNF.B14 = __PA14_OU_PP;		// DIP SW ID2
	GPIOA->ODR.B14 = SET;				// PULL-UP

	GPIOA->CNF.B15 = __PA15_IN_PU;		// DIP SW ID0
	GPIOA->ODR.B15 = SET;				// PULL-UP

	//Port A Initialization End
	//Port B Initialization
	/////////////////////////
	GPIOB->CNF.B0 = __ADC_IN8;
	GPIOB->CNF.B1 = __ADC_IN9; 

	GPIOB->CNF.B2 = __PB2_OU_PP;

	GPIOB->CNF.B3 = __PB3_IN_PU;
	GPIOB->ODR.B3 = SET;				// PULL_UP

	GPIOB->CNF.B4 = __PB4_OU_PP;

	GPIOB->CNF.B5 = __PB5_OU_PP;
	GPIOB->ODR.B5 = SET;				// PULL_UP


	GPIOB->CNF.B6 = __PB6_OU_PP;
	GPIOB->ODR.B6 = SET;				// PULL_UP
//////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////
#ifndef __FSMC_SRAM_H
	GPIOB->CNF.B7 = __PB7_IN_FL;		// __NADV


#else
	GPIOB->CNF.B7 = __PB8_OU_PP;
	GPIOB->ODR.B7 = SET;				// PULL_UP

#endif

//	GPIOB->CNF.B8 = __PB8_IN_PU;
//	GPIOB->ODR.B8 = SET;				// PULL_UP
	
	GPIOB->CNF.B9 = __PB9_OU_PP;
	GPIOB->ODR.B9 = SET;				// PULL_UP

	GPIOB->CNF.B10 = __USART3_TX;
	GPIOB->ODR.B10 = SET;				// PULL_UP

	GPIOB->CNF.B11 = __USART3_RX;

	GPIOB->CNF.B12 = __PB12_IN_PU;
	GPIOB->ODR.B12 = SET;
	// PULL_UP
//	GPIOB->CNF.B13 = __PB13_IN_PU;
//	GPIOB->ODR.B13 = SET;				// PULL_UP

	GPIOB->CNF.B8 = __PB8_OU_PP;
	GPIOB->ODR.B8 = SET;				// PULL_UP


	GPIOB->CNF.B13 = __PB13_OU_PP;
	GPIOB->ODR.B13 = SET;				// PULL_UP
	
	GPIOB->CNF.B14 = __PB14_IN_PU;
	GPIOB->ODR.B14 = SET;				// PULL_UP

	GPIOB->CNF.B15 = __PB15_OU_PP;
	GPIOB->ODR.B15 = SET;				// PULL_UP
	

///////////////////////////////////////////
	
//Port B Initialization End

	GPIOC->CNF.B0 = __ADC_IN10;
	GPIOC->CNF.B1 = __ADC_IN11; ///////
	GPIOC->CNF.B2 = __ADC_IN12; 
	GPIOC->CNF.B3 = __ADC_IN13; 
	GPIOC->CNF.B4 = __ADC_IN14; 
	GPIOC->CNF.B5 = __ADC_IN15; 

	///
	#ifdef __2rd
		GPIOC->CNF.B6 = __PC6_OU_PP;
		GPIOC->ODR.B6 = SET;				// PULL_UP
	#else
		GPIOC->CNF.B6 = __PC6_IN_PU;
		GPIOC->ODR.B6 = SET;				// PULL_UP
	#endif

	GPIOC->CNF.B7 = __PC7_IN_PU;
	GPIOC->ODR.B7 = SET;				// PULL_UP

	GPIOC->CNF.B8 = __PC8_IN_PU;
	GPIOC->ODR.B8 = SET;				// PULL_UP

	GPIOC->CNF.B9 = __PC9_OU_PP;
	GPIOC->ODR.B9 = SET;				// PULL_UP
	
	GPIOC->CNF.B10 = __USART4_TX;
	GPIOC->CNF.B11 = __USART4_RX;

	GPIOC->CNF.B12 = __PC12_IN_PU;
	GPIOC->ODR.B12 = SET;				// PULL_UP		

	GPIOC->CNF.B13 = __PC13_IN_FL;

	GPIOC->CNF.B14 = __PC14_OU_PP;
	GPIOC->ODR.B14 = SET;				// PULL_UP
	GPIOC->CNF.B15 = __PC15_OU_PP;
	GPIOC->ODR.B15 = SET;				// PULL_UP

	//Port C Initialization End

	//Port D Initialization

#ifndef	__FSMC_SRAM_H
	GPIOD->CNF.B0 = __PD0_OU_PP;		// __FAD2
	GPIOD->CNF.B1 = __PD1_OU_PP;		// __FAD3 
#else

	GPIOD->CNF.B0 = __PD0_OU_PP;		// __FAD2
	GPIOD->CNF.B1 = __PD1_OU_PP;		// __FAD3 

	GPIOD->CNF.B0 = __PD0_IN_PU;
	GPIOD->ODR.B0 = SET;		
	GPIOD->CNF.B1 = __PD1_IN_PU;
	GPIOD->ODR.B1 = SET;		
#endif

	GPIOD->CNF.B0 = __PD0_OU_PP;		// __FAD2
	GPIOD->ODR.B0 = SET;				// PULL_UP
	
	GPIOD->CNF.B1 = __PD1_OU_PP;		// __FAD3 
	GPIOD->ODR.B1 = SET;				// PULL_UP

	GPIOD->CNF.B2 = __PD2_OU_PP;
	GPIOD->ODR.B2 = SET;				// PULL_UP

	GPIOD->CNF.B3 = __PD3_OU_PP;
	GPIOD->ODR.B3 = SET;				// PULL UP
#ifndef	__FSMC_SRAM_H
	GPIOD->CNF.B4 = __PD4_IN_FL;		// __NOE
	GPIOD->CNF.B5 = __PD5_IN_FL;		// __NWE
#else
	GPIOD->CNF.B4 = __PD4_OU_PP;
	GPIOD->ODR.B4 = SET;

	GPIOD->CNF.B5 = __PD5_OU_PP;
	GPIOD->ODR.B5 = SET;
#endif
	GPIOD->CNF.B6 = __PD6_OU_PP;
	GPIOD->ODR.B6 = SET;				// PULL UP
#ifndef __FSMC_SRAM_H
	GPIOD->CNF.B7 = __PD7_IN_FL;		// __NCE
#else
	GPIOD->CNF.B7 = __PD7_OU_PP;
	GPIOD->ODR.B7 = SET;				// PULL_UP
#endif

	GPIOD->CNF.B8 = __PD8_OU_PP;
	GPIOD->ODR.B8 = SET;				// PULL_UP


#ifndef __EXT_RAM_USED
{

#ifndef __UPPER_DATA_USED
	GPIOD->CNF.B9 = __PD9_OU_PP;
	GPIOD->ODR.B9 = SET;				// PULL_UP

	GPIOD->CNF.B10 = __PD10_OU_PP;
	GPIOD->ODR.B10 = SET;				// PULL_UP

	GPIOD->CNF.B11 = __PD11_OU_PP;
	GPIOD->ODR.B11 = SET;				// PULL_UP

	GPIOD->CNF.B12 = __PD12_OU_PP;
	GPIOD->ODR.B12 = SET;				// PULL_UP

	GPIOD->CNF.B13 = __PD13_OU_PP;
	GPIOD->ODR.B13 = SET;				// PULL_UP

	GPIOD->CNF.B14 = __PD14_OU_PP;
	GPIOD->ODR.B14 = SET;				// PULL_UP
	GPIOD->CNF.B15 = __PD15_OU_PP;
	GPIOD->ODR.B15 = SET;				// PULL_UP
#endif
	GPIOD->CNF.B11 = __PD11_OU_PP;		// __FA16
	GPIOD->CNF.B12 = __PD12_OU_PP;		// __FA17
	GPIOD->CNF.B13 = __PD13_OU_PP;		// __FA18
///////////////////////////////////////////////////////

	GPIOD->CNF.B14 = __PD14_IN_PU;
	GPIOD->ODR.B14 = SET;		

	GPIOD->CNF.B15 = __PD15_IN_PU;
	GPIOD->ODR.B15 = SET;		


#ifndef	__FSMC_SRAM_H
	GPIOD->CNF.B14 = __PD14_OU_PP;		// __FAD0
	GPIOD->CNF.B15 = __PD15_OU_PP;		// __FAD1
#endif
}
#else

#endif

	//Port D Initialization End
	//Port E Initialization
	GPIOE->CNF.B0 = __PE0_OU_PP;
	GPIOE->ODR.B0 = SET;

	GPIOE->CNF.B1 = __PE1_OU_PP;
	GPIOE->ODR.B1 = SET;
	
	GPIOE->CNF.B2 = __PE2_IN_FL;

#ifndef __EXT_RAM_USED
{
#ifndef __FSMC_SRAM_H	
	GPIOE->CNF.B3 = __PE3_OU_PP;		// __FA19
	GPIOE->CNF.B4 = __PE4_OU_PP;		// __FA20
	GPIOE->CNF.B5 = __PE5_IN_FL;		// __FA21
	GPIOE->CNF.B6 = __PE6_IN_FL;		// __FA22

	GPIOE->CNF.B7 = __PE7_OU_PP;		// __FAD4
	GPIOE->CNF.B8 = __PE8_OU_PP;		// __FAD5
	GPIOE->CNF.B9 = __PE9_OU_PP;		// __FAD6
	GPIOE->CNF.B10 = __PE10_IN_FL;		// __FAD7
#endif

#ifndef __UPPER_DATA_USED
	GPIOE->CNF.B0 = __PE0_OU_PP;
	GPIOE->ODR.B0 = SET;				// PULL_UP
	
	GPIOE->CNF.B1 = __PE1_OU_PP;
	GPIOE->ODR.B1 = SET;				// PULL_UP

	GPIOE->CNF.B2 = __PE2_OU_PP;
	GPIOE->ODR.B2 = SET;				// PULL UP

	GPIOE->CNF.B3 = __PE3_OU_PP;
	GPIOE->ODR.B3 = SET;				// PULL UP

	GPIOE->CNF.B4 = __PE4_OU_PP;
	GPIOE->ODR.B4 = SET;		

	GPIOE->CNF.B5 = __PE5_OU_PP;
	GPIOE->ODR.B5 = SET;

	GPIOE->CNF.B6 = __PE6_OU_PP;
	GPIOE->ODR.B6 = SET;

	GPIOE->CNF.B7 = __PE7_OU_PP;
	GPIOE->ODR.B7 = SET;			// PULL UP

	GPIOE->CNF.B8 = __PE8_OU_PP;
	GPIOE->ODR.B8 = SET;			// PULL UP

	GPIOE->CNF.B9 = __PE9_OU_PP;
	GPIOE->ODR.B9 = SET;				// PULL UP

	GPIOE->CNF.B10 = __PE10_OU_PP;
	GPIOE->ODR.B10 = SET;				// PULL UP

	GPIOE->CNF.B11 = __PE11_OU_PP;
	GPIOE->ODR.B11 = SET;				// PULL UP


	GPIOE->CNF.B12 = __PE12_OU_PP;
	GPIOE->ODR.B12 = SET;				// PULL UP

	GPIOE->CNF.B13 = __PE13_OU_PP;
	GPIOE->ODR.B13 = SET;				// PULL UP

	GPIOE->CNF.B14 = __PE14_OU_PP;
	GPIOE->ODR.B14 = SET;				// PULL UP

	GPIOE->CNF.B15 = __PE15_OU_PP;
	GPIOE->ODR.B15 = SET;				// PULL UP
#endif
}
#else

#endif
	//Port E Initialization End
}

void PheripheralInit(void)
{
	WatchdogInit();
	WatchdogClear();

	SerPtr = &pUSART1;
	SerPtr->init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));

	Ser4Ptr = &pUSART4;											
	Ser4Ptr->init(115200L, (_DATA8BIT | _1_STOP | _NONPARITY));

	/////////////////////////////////////////////////////////
 	// Function Task recursion
	WRCS_SerInit();
	_PCA9555Init();

	ExpioInit();
	ADCInit(TRUE);
	ADC_Init();

	SmsInit();	

	TestInit();
}

extern const  INTVECT_ELEM  AppVectTbl[];

void LedDisplay(void)
{
	if(TimeOverCheck(TimerLed))
	{
		TimerRegist(TimerLed, Time100mSec*5L);
		RUNLEDSEL ^= 1;
	}
}

extern u32 CurrINT;
void  mainTask (void *p_arg)
{
    (void)p_arg;

	InitStm32f103();
	PheripheralInit();

	TimerRegist(TimerLed, Time100mSec);
 
    while(1)
	{
		LedDisplay();
		CheckSoftTimer();
		ADC1_SWStart();

		OSTimeDly(1L);
    }
}

