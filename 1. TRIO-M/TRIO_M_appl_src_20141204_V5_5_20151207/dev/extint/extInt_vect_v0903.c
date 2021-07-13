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

/*
*********************************************************************************************************
*
*                                         EXCEPTION VECTORS
*
*                                     ST Microelectronics STM32
*                                              with the
*                                   IAR STM32-SK Evaluation Board
*
* Filename      : app_vect.c
* Version       : V1.00
* Programmer(s) : Brian Nagel
*********************************************************************************************************
*/
#include <../../include/main.h>


#pragma language=extended

/*
*********************************************************************************************************
*                                              PROTOTYPES
*********************************************************************************************************
*/
void OS_CPU_PendSVHandler(void);
void  Tmr_TickISR_Handler (void);
void __iar_program_start(void);
extern const selfinfo convinfo;

void  App_Spurious_ISR(void);
void  App_NMI_ISR(void);
void  App_Fault_ISR(void);

/*
*********************************************************************************************************
*                                  Exception / Interrupt Vector Table
*********************************************************************************************************
*/

#pragma segment = "CSTACK"

#pragma location = ".intvec"

__root  const  INTVECT_ELEM  AppVectTbl[] = {
    { .__ptr = __sfe("CSTACK")},        /*  0, SP start value.                                         */
    __iar_program_start,                /*  1, PC start value.                                         */
    App_NMI_ISR,                        /*  2, NMI                                                     */
    App_Fault_ISR,                      /*  3, Hard Fault                                              */
    App_Spurious_ISR,                   /*  4, Memory Management                                       */
    App_Spurious_ISR,                   /*  5, Bus Fault                                               */
    App_Spurious_ISR,                   /*  6, Usage Fault                                             */
    (intfunc)_pilog,                    /*  7, Reserved                                                */
    0,                                  /*  8, Reserved                                                */
    (intfunc)__pAPPLAddr,               /*  9, Reserved                                                */
    (intfunc)&convinfo,                 /* 10, Reserved                                                */
    App_Spurious_ISR,                   /* 11, SVCall                                                  */
    App_Spurious_ISR,                   /* 12, Debug Monitor                                           */
    App_Spurious_ISR,                   /* 13, Reserved                                                */
    OS_CPU_PendSVHandler,               /* 14, PendSV Handler                                          */
	Tmr_TickISR_Handler,                /* 15, uC/OS-II Tick ISR Handler                               */
    App_Spurious_ISR,                   /* 16, INTISR[  0], Window Watchdog                            */
    App_Spurious_ISR,                   /* 17, INTISR[  1]  PVD through EXTI Line Detection            */
    App_Spurious_ISR,                   /* 18, INTISR[  2]  Tamper Interrupt                           */
    App_Spurious_ISR,                   /* 19, INTISR[  3]  RTC Global Interrupt                       */
    App_Spurious_ISR,                   /* 20, INTISR[  4]  FLASH Global Interrupt                     */
    App_Spurious_ISR,                   /* 21, INTISR[  5]  RCC Global Interrupt                       */
	#ifdef _EXTI
		EXTI0_IRQHandler,
	#else
		App_Spurious_ISR,				/* 22, INTISR[  6]  EXTI Line0 Interrupt                       */
	#endif

	#ifdef _EXTI
		EXTI1_IRQHandler,
	#else
		App_Spurious_ISR,				/* 23, INTISR[  7]  EXTI Line1 Interrupt                       */
	#endif
	#ifdef _EXTI
		EXTI2_IRQHandler,
	#else
		App_Spurious_ISR,				/* 24, INTISR[  8]  EXTI Line2 Interrupt                       */
	#endif
	#ifdef _EXTI
		EXTI3_IRQHandler,
	#else
		App_Spurious_ISR,				/* 25, INTISR[  9]  EXTI Line3 Interrupt                       */
	#endif

	#ifdef _EXTI
		EXTI4_IRQHandler,
	#else
		App_Spurious_ISR,				/* 26, INTISR[ 10]  EXTI Line4 Interrupt                       */
	#endif

	App_Spurious_ISR,                   /* 27, INTISR[ 11]  DMA Channel1 Global Interrupt              */
    App_Spurious_ISR,                   /* 28, INTISR[ 12]  DMA Channel2 Global Interrupt              */
    App_Spurious_ISR,                   /* 29, INTISR[ 13]  DMA Channel3 Global Interrupt              */
    App_Spurious_ISR,                   /* 30, INTISR[ 14]  DMA Channel4 Global Interrupt              */
    App_Spurious_ISR,                   /* 31, INTISR[ 15]  DMA Channel5 Global Interrupt              */
    App_Spurious_ISR,                   /* 32, INTISR[ 16]  DMA Channel6 Global Interrupt              */
    App_Spurious_ISR,                   /* 33, INTISR[ 17]  DMA Channel7 Global Interrupt              */
	#ifdef _ADC
		ADC_IRQHandler,
	#else
    	App_Spurious_ISR,               /* 34, INTISR[ 18]  ADC Global Interrupt                       */
    #endif
    App_Spurious_ISR,                   /* 35, INTISR[ 19]  USB High Priority / CAN TX  Interrupts     */
    App_Spurious_ISR,                   /* 36, INTISR[ 20]  USB Low  Priority / CAN RX0 Interrupts     */
    App_Spurious_ISR,                   /* 37, INTISR[ 21]  CAN RX1 Interrupt                          */
    App_Spurious_ISR,                   /* 38, INTISR[ 22]  CAN SCE Interrupt                          */
	#ifdef _EXTI
		EXTI9_5_IRQHandler,
	#else
    	App_Spurious_ISR,				/* 39, INTISR[ 23]  EXTI Line[9:5] Interrupt                   */
	#endif
	App_Spurious_ISR,                   /* 40, INTISR[ 24]  TIM1 Break  Interrupt                      */
    App_Spurious_ISR,                   /* 41, INTISR[ 25]  TIM1 Update Interrupt                      */
    App_Spurious_ISR,                   /* 42, INTISR[ 26]  TIM1 Trigger & Commutation Interrupts      */
    App_Spurious_ISR,					/* 43, INTISR[ 27]	TIM1 Capture Compare Interrupt			   */
    App_Spurious_ISR,                   /* 44, INTISR[ 28]  TIM2 Global Interrupt                      */
    App_Spurious_ISR,                   /* 45, INTISR[ 29]  TIM3 Global Interrupt                      */
    App_Spurious_ISR,                   /* 46, INTISR[ 30]  TIM4 Global Interrupt                      */
    App_Spurious_ISR,                   /* 47, INTISR[ 31]  I2C1 Event  Interrupt                      */
    App_Spurious_ISR,                   /* 48, INTISR[ 32]  I2C1 Error  Interrupt                      */
    App_Spurious_ISR,                   /* 49, INTISR[ 33]  I2C2 Event  Interrupt                      */
    App_Spurious_ISR,                   /* 50, INTISR[ 34]  I2C2 Error  Interrupt                      */
    App_Spurious_ISR,                   /* 51, INTISR[ 35]  SPI1 Global Interrupt                      */
    App_Spurious_ISR,                   /* 52, INTISR[ 36]  SPI2 Global Interrupt                      */
	#ifdef _USART1
		USART1_IRQHandler,
	#else
    	App_Spurious_ISR,               /* 53, INTISR[ 37]  USART1 Global Interrupt                    */
	#endif
	#ifdef _USART2
		USART2_IRQHandler,
	#else
		App_Spurious_ISR,//ProbeRS232_RxTxISRHandler,          /* 54, INTISR[ 38]  USART2 Global Interrupt                    */
	#endif
	#ifdef _USART3
		USART3_IRQHandler,
	#else
		App_Spurious_ISR,//ProbeRS232_RxTxISRHandler,          /* 55, INTISR[ 39]  USART3 Global Interrupt                    */
	#endif
	#ifdef _EXTI
		EXTI15_10_IRQHandler,
	#else
		App_Spurious_ISR,				/* 56, INTISR[ 40]  EXTI Line [15:10] Interrupts               */
	#endif
	App_Spurious_ISR,                   /* 57, INTISR[ 41]  RTC Alarm through EXT Line Interrupt       */
    App_Spurious_ISR,                   /* 58, INTISR[ 42]  USB Wakeup from Suspend through EXTI Int.  */
    
	App_Spurious_ISR,					/* 59, INTISR[ 43]  TIM8_BRK_IRQHandler */
	App_Spurious_ISR,					/* 60, INTISR[ 44]  TIM8_UP_IRQHandler */
	App_Spurious_ISR,					/* 61, INTISR[ 45]  TIM8_TRG_COM_IRQHandler */
	App_Spurious_ISR,					/* 62, INTISR[ 46]  TIM8_CC_IRQHandler */
	App_Spurious_ISR,					/* 63, INTISR[ 47]  ADC3_IRQHandler */
	App_Spurious_ISR,					/* 64, INTISR[ 48]  FSMC_IRQHandler */
	App_Spurious_ISR,					/* 65, INTISR[ 49]  SDIO_IRQHandler */
	App_Spurious_ISR,					/* 66, INTISR[ 50]  TIM5_IRQHandler */
	App_Spurious_ISR,					/* 67, INTISR[ 51]  SPI3_IRQHandler */
	#ifdef _USART4
		USART4_IRQHandler,
	#else
		App_Spurious_ISR,				/* 68, INTISR[ 52]  UART4_IRQHandler */
	#endif
	#ifdef _USART5
		USART5_IRQHandler,
	#else
		App_Spurious_ISR,				/* 69, INTISR[ 53]  UART5_IRQHandler */
	#endif
	App_Spurious_ISR,					/* 70, INTISR[ 54]  TIM6_IRQHandler */
	App_Spurious_ISR,					/* 71, INTISR[ 55]  TIM7_IRQHandler */
	App_Spurious_ISR,					/* 72, INTISR[ 56]  DMA2_Channel1_IRQHandler */
	App_Spurious_ISR,					/* 73, INTISR[ 57]  DMA2_Channel2_IRQHandler */
	App_Spurious_ISR,					/* 74, INTISR[ 58]  DMA2_Channel3_IRQHandler */
	App_Spurious_ISR,					/* 75, INTISR[ 59]  DMA2_Channel4_5_IRQHandler */
};

/*
*********************************************************************************************************
*                                      Spurious Interrupt Handler
*********************************************************************************************************
*/
void  App_Spurious_ISR (void)
{
	while(0)
	{
		//USART1PutChar('S');
    }
}

/*
*********************************************************************************************************
*                                        NMI Exception Handler
*********************************************************************************************************
*/

void  App_NMI_ISR (void)
{
	while(0)
	{
		//USART1PutChar('N');
	}
}


/*
*********************************************************************************************************
*                                       FAULT Exception Handler
*********************************************************************************************************
*/

void  App_Fault_ISR (void)
{
	while(0)
	{
		//USART1PutChar('I');
	}
}



