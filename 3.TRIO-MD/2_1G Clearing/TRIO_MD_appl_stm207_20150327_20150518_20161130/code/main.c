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
	SystemInit_ExtMemCtl();
	SystemInit_PSRAM0Ctl();

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
	__PE2_PP_PP();				// ATT CLK
	__PE6_PP_PP();				// ATT DATA

	__PC14_PP_PP();				// F_PROG
	__PC15_IN_FL();				// F_DONE

	
	__PF6_PP_PP();
	__PF7_PP_PP();
	__PF8_PP_PP();
	__PF9_PP_PP();
	__PF10_PP_PP();

	__ADC_IN0();
	__ADC_IN1();

	__ADC_IN3();


///////////////////////////////////////////////
	__PB2_PP_PP();				// RUN LED
	__PF11_PP_PP();

	__PB14_PP_PP(); 			// ADC_CS0
	__PB15_PP_PP(); 			// ADC_CS1

	__PG6_IN_PU();				// AC FAIL
	__PG7_PP_PP();				// SMS VCC ON/OFF


	__PC6_IN_PU();				// PLL LD
	__PC7_IN_PU(); 				// PLL LD
	__PC8_IN_PU();				// PLL LD

	__PC9_PP_PP();				// I2C_DATA
	__PA8_PP_PP();				// I2C_CLK


	__PA9_U1_TX();				// USART1_TX
	__PA10_U1_RX(); 			// USART1_RX

	__PA12_IN_PU(); 			// DTU Insert

	__PA13_PP_PP(); 			// MBD_RST

	__PA14_PP_PP(); 			// SCK
	__PA15_PP_PP(); 			// PLL CLK

	__PA2_IN_FL();

	__PC10_U4_TX(); 			// USART4_TX
	__PC11_U4_RX(); 			// USART4_RX


	__PG11_PP_PP();				// DTU_CS0
	__PG13_PP_PP();				// DTU_RW
	__PG14_PP_PP(); 			// DTU_ALE


	__PG12_IN_PU(); 			// RF Module Insert
	__PG15_IN_PU(); 			// Ext Module Insert
	

	__PB3_PP_PP();				// PLL DATA
	__PB4_PP_PP();				// SEL0
	__PB5_PP_PP();				// SEL1
	__PB6_PP_PP(); 	
	__PB8_IN_FL();				// DTU_CS1 Insert


	__PC0_PP_PP();				//PD0
	__PC1_PP_PP();				//PD1
	__PC4_PP_PP();				//PD2
	__PC5_PP_PP();				//PD3
	__PB0_PP_PP();				//PD4
	__PB1_PP_PP();				//PD5
	__PG8_PP_PP();				//PD6
	__PA11_PP_PP();				//PD7


	__PB10_U3_TX(); 			// USART3_TX
	__PB11_U3_RX(); 			// USART3_RX

///102
//////////////////////////

	__PA4_PP_PP();			// SPI1_NSS
	__PA5_IN_PU(); 			// SPI1_SCK
	__PA6_IN_PU(); 			// SPI1_MISO
	__PA7_IN_PU(); 			// SPI1_MOSI
	

	__PB12_PP_PP(); 		// SPI2_NSS
	__PB13_IN_PU(); 		// SPI2_SCK
	__PC2_IN_PU(); 			// SPI2_MISO
	__PC3_IN_PU(); 			// SPI2_MOSI
	
}


void PheripheralInit(void)
{
	TimerInit();
	WatchdogInit();
//	WatchdogClear();
	SerPtr = &pUSART1;
	SerPtr->init(115200L, (_DATA8BIT | _1_STOP | _NONPARITY));
//	SerPtr->init(230400L, (_DATA8BIT | _1_STOP | _NONPARITY));

	Ser3Ptr = &pUSART3; 										
	Ser3Ptr->init(115200L, (_DATA8BIT | _1_STOP | _NONPARITY));

	Ser4Ptr = &pUSART4; 										
	Ser4Ptr->init(115200L, (_DATA8BIT | _1_STOP | _NONPARITY));
	EEpromInit();

	/////////////////////////////////////////////////////////
	// Function Task recursion
	Ser1Init();
#if 1
	ExpioInit();
	AlcInit();
	DtuInit();
	iAPDInit();

	SmsInit();	

	TestInit();
	ADCInit(TRUE);
#endif	
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
		}
		OSTimeDly(2L);
    }
}
// 8982051008140861537

#if 0
GUI Table Auto Table Load 시 3분 50초 


보드 에서 동작 시 17초 
#endif
