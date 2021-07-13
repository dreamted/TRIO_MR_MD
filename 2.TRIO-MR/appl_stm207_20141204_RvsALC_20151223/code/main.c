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
#define MAIN_C		// m: Macro

#include "main.h"


/*******************************************************************************
* Function Name  : InitStm32f103
* Description    : Initializes the stm32_x application.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

//extern	void SRAM_Init(void);

void InitStm32f103(void)
{
	InitAFIO();
	InitGPIO();
	//#ifdef __FSMC_SRAM_H
	//SRAM_Init();
	//#endif
	// Set the Vector Table base location at 0x08000000
	InitSysTick(1L);	// timer init!!(1: 1ms)
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
	// AHB1 BUS RELATED
	// GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF, GPIOG, GPIOH
	// TIM1, SPI1, USART1, ADC
    RCC->__B.AHB1ENR.IOPAEN = ENABLE;
    RCC->__B.AHB1ENR.IOPBEN = ENABLE;
	RCC->__B.AHB1ENR.IOPCEN = ENABLE;
	RCC->__B.AHB1ENR.IOPDEN = ENABLE;
    RCC->__B.AHB1ENR.IOPEEN = ENABLE;
	RCC->__B.AHB1ENR.IOPFEN = ENABLE;
    RCC->__B.AHB1ENR.IOPGEN = ENABLE;

	RCC->__B.APB2ENR.ADC1EN = ENABLE;
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
	//--------------------------------------------------------------//
	// CPU - LEFT
	__PE2_PP_PP();
	__PE3_IN_PU();
	__PE4_PP_PP();				// INSERT_21
	__PE5_PP_PP();				// INSERT_900
//	__PE6_PP_PP();				// EX1_CTRL
	__PE6_IN_PU(); 			// 

	__PF0_PP_PP();
	__PF1_PP_PP();
	__PF2_PP_PP();
	__PF3_PP_PP();
	__PF4_PP_PP();
	
	__PF5_PP_PP();
	__PF6_PP_PP();
	__PF7_PP_PP();
	__PF8_PP_PP();
	__PF9_PP_PP();

	__PF10_PP_PP();
	__ADC_IN10();
	__ADC_IN11();
	__ADC_IN12();
	__ADC_IN13();
	
	__ADC_IN0();
	__ADC_IN1();
	__ADC_IN2();
	__ADC_IN3();
	__ADC_IN4();

	__ADC_IN5();
	__ADC_IN6();
	__ADC_IN7();
	__ADC_IN14();
	__ADC_IN15();

	__ADC_IN8();
	__ADC_IN9();
	
	__PF11_PP_PP();
	__PF12_PP_PP();
	__PF13_PP_PP();

	__PF14_PP_PP();
	__PF15_PP_PP();
	__PG0_PP_PP();


	__PE7_PP_PP();
	__PE8_PP_PP();
	__PE9_IN_PU();
	__PE10_IN_PU();


	__PE11_PP_PP();
	__PE12_PP_PP();

	__PE13_PP_PP(); 			// ATTN_CLK
	__PE14_PP_PP(); 			// PLL_TX_25
	__PE15_PP_PP();
	__PB10_U3_TX(); 			// USART3_TX
	__PB11_U3_RX(); 			// USART3_RX

	__PB12_IN_PU(); 			// PLL_RX_21
	__PB13_IN_PU(); 			// PLL_TX_21
	__PB14_IN_PU(); 			// PLL_RX_900
	__PB15_PP_PP(); 			// PLL_TX_900
	//__PD8_IN_PD();				// PLL_RX_25
	__PD8_PP_PP();
	
	//--------------------------------------------------------------//
	// CPU - RIGHT
	__PD9_PP_PP();				// nLINKLED
	__PD10_PP_PP(); 			// W3150RST
	__PD11_PP_PP();
	__PD12_PP_PP();
	__PD13_PP_PP();

	__PD14_PP_PP();
	__PD15_IN_PU();
	__PG2_PP_PP();

	__PG5_PP_PP();				// FAN1_ALM
	__PG6_PP_PP();				// FAN1_ALM
	//__PG7_IN_PU();				// DC_IN_FAIL
	__PG8_PP_PP();				// DC_OUT_FAIL
	__PC6_PP_PP();				// USART6_TX

	__PC7_IN_PU(); 				// USART6_RX
	__PC8_IN_PU();				// PWR_ON_21G
	__PC9_PP_PP();				// PWR_ON_900M
	__PA8_IN_PU();				// PWR_ON_25G
		
	__PA9_U1_TX();				// USART1_TX
	__PA10_U1_RX(); 			// USART1_RX
	__PA11_PP_PP();		 		// DC_FAIL_21
	__PA12_IN_PU();		 		// DC_FAIL_900
	__PA13_PP_PP();		 		// DC_FAIL_25

	__PA14_PP_PP(); 			// SCK
	__PA15_PP_PP(); 			// W3150_nSS
	__PC10_U4_TX(); 			// USART4_TX
	__PC11_U4_RX(); 			// USART4_RX
	//__PC12_U5_TX(); 			// USART5_TX

	__PD0_PP_PP();
	__PD1_PP_PP();
	//__PD2_U5_RX();			// USART5_RX
	__PD3_PP_PP();				// DTU_RESET
	__PD4_PP_PP();
	
	__PD5_PP_PP();
	__PD6_PP_PP();
	__PD7_PP_PP();

	//__PG10_IN_PU(); 			// DTU_BD

	//__PG11_PP_PP(); 			// DCC_SEL01
	//__PG12_PP_PP(); 			// DCC_SEL23
	//__PG13_PP_PP(); 			// DCC_SEL45
	__PG14_IN_PU(); 			// DCC_SEL67
	__PG15_IN_PU(); 			// EXT1_ALM

	__PB3_PP_PP();
	__PB4_PP_PP();
	__PB5_PP_PP();
	__PB6_PP_PP();
	__PB7_PP_PP();				// EXT2

	__PB8_PP_PP();				// EXT1
	__PE0_PP_PP();				// EXT1
	__PE1_PP_PP();				// EXT1

//	__PA15_NSS();				// W3150 NSS
//	__PB3_SPI_SCK();			// W3150 SCK
//	__PB4_SPI_MISO();			// W3150 MISO
//	__PB5_SPI_MOSI();			// W3150 MOSI

	__PB2_PP_PP();				// RUN LED

}


void PheripheralInit(void)
{
	TimerInit();
	WatchdogInit();
//	WatchdogClear();
	
	SerPtr = &pUSART1;
	SerPtr->init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));

	Ser4Ptr = &pUSART4;											
	Ser4Ptr->init(115200L, (_DATA8BIT | _1_STOP | _NONPARITY));

	EEpromInit();
	/////////////////////////////////////////////////////////
	// Function Task recursion
	Ser1Init();
//	_PCA9555Init();
	ExpioInit();
	AlcInit();

	SmsInit();	

	TestInit();
	ADCInit(TRUE);
	//EXTI0_Init();
	//EXTI12_Init();
}

void LedDisplay(void)
{
	if(TimeOverCheck(TimerLed))
	{
		TimerRegist(TimerLed, Time100mSec*5L);
		RUNLEDSEL ^= 1;
        WatchdogClear();
	}
}

void  mainTask (void *p_arg)
{
    (void)p_arg;

	InitStm32f103();
	PheripheralInit();

	TimerRegist(TimerLed, Time100mSec);

    while(1)
	{
		CheckSoftTimer();
		if(!m_writing)
		{
			ADC1_SWStart();
//			ADC3_SWStart();
		}
//		ReadAdcValue();
		OSTimeDly(2L);
//		OSTimeDly(1L);
    }
}
// 8982051008140861537

#if 0
GUI Table Auto Table Load 시 3분 50초 


보드 에서 동작 시 17초 
#endif
