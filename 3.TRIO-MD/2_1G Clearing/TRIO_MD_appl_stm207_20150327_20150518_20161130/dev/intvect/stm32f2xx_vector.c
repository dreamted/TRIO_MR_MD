/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_vector.c
* Author             : MCD Application Team
* Date First Issued  : 02/19/2007
* Description        : This file contains the vector table for STM32F10x.
*                      After Reset the Cortex-M3 processor is in Thread mode,
*                      priority is Privileged, and the Stack is set to Main.
********************************************************************************
* History:
* 05/21/2007: V0.3
* 04/02/2007: V0.2
* 02/19/2007: V0.1
********************************************************************************
* THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

#ifndef __STM32F2xx_VECTOR_H
#define __STM32F2xx_VECTOR_H
#endif
// Includes --------------------------------------------------------------------
#include "main.h"			/*!<user defined using cpu*/

/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

void  App_Spurious_ISR (void);
void  App_NMI_ISR (void);
void  App_Fault_ISR (void);

#ifdef OS_INCLUDED
	void OS_CPU_PendSVHandler(void);
	void  Tmr_TickISR_Handler (void);
#endif /* OS_INCLUDED */

#ifdef OS_INCLUDED
	extern const selfinfo convinfo;
#endif /* OS_INCLUDED */

#pragma language = extended
#pragma segment="CSTACK"

void __iar_program_start( void );

#pragma location = ".intvec"

const intvec_elem __vector_table[] =
{
	{ .__ptr = __sfe( "CSTACK" ) },	/*  0, SP start value.                                         */
#ifdef OS_INCLUDED
	SystemInit,
#else
	__iar_program_start,			/*  1, PC start value.                                         */
#endif
	NMIException,					/*  2, NMI                                                     */
	HardFaultException,				/*  3, Hard Fault                                              */
	MemManageException,				/*  4, Memory Management                                       */
	BusFaultException,				/*  5, Bus Fault                                               */
	UsageFaultException,			/*  6, Usage Fault                                             */
	(intfunc)_pilog,				/*  7, Reserved                                                */
	0,								/*  8, Reserved                                                */
	(intfunc)__pAPPLAddr,			/*  9, Reserved                                                */
#ifdef OS_INCLUDED	
    (intfunc)&convinfo,            	/* 10, Reserved                                                */
#else // boot
    (intfunc)0,
#endif /* OS_INCLUDED */
	SVCHandler,						/* 11, SVCall                                                  */
	DebugMonitor,					/* 12, Debug Monitor                                           */
	0,                      		/* 13, Reserved                                                */
#ifdef OS_INCLUDED
	OS_CPU_PendSVHandler,			/* 14, PendSV Handler                                          */
#else
	PendSVC,
#endif /* OS_INCLUDED */
	SysTickHandler,			        /* 15, uC/OS-II Tick ISR Handler                               */

	WWDG_IRQHandler,				/* 16, INTISR[  0], Window Watchdog                            */
	PVD_IRQHandler,					/* 17, INTISR[  1]  PVD through EXTI Line Detection            */
	TAMPER_IRQHandler,				/* 18, INTISR[  2]  Tamper Interrupt                           */
	RTC_IRQHandler,					/* 19, INTISR[  3]  RTC Global Interrupt                       */
	FLASH_IRQHandler,				/* 20, INTISR[  4]  FLASH Global Interrupt                     */
	RCC_IRQHandler,					/* 21, INTISR[  5]  RCC Global Interrupt                       */
	EXTI0_IRQHandler,				/* 22, INTISR[  6]  EXTI Line0 Interrupt                       */
	EXTI1_IRQHandler,				/* 23, INTISR[  7]  EXTI Line1 Interrupt                       */
	EXTI2_IRQHandler,				/* 24, INTISR[  8]  EXTI Line2 Interrupt                       */
	EXTI3_IRQHandler,				/* 25, INTISR[  9]  EXTI Line3 Interrupt                       */
	EXTI4_IRQHandler,				/* 26, INTISR[ 10]  EXTI Line4 Interrupt                       */
	DMAChannel1_IRQHandler,			/* 27, INTISR[ 11]  DMA Channel1 Global Interrupt              */
	DMAChannel2_IRQHandler,			/* 28, INTISR[ 12]  DMA Channel2 Global Interrupt              */
	DMAChannel3_IRQHandler,			/* 29, INTISR[ 13]  DMA Channel3 Global Interrupt              */
	DMAChannel4_IRQHandler,			/* 30, INTISR[ 14]  DMA Channel4 Global Interrupt              */
	DMAChannel5_IRQHandler,			/* 31, INTISR[ 15]  DMA Channel5 Global Interrupt              */
	DMAChannel6_IRQHandler,			/* 32, INTISR[ 16]  DMA Channel6 Global Interrupt              */
	DMAChannel7_IRQHandler,			/* 33, INTISR[ 17]  DMA Channel7 Global Interrupt              */
	ADC_IRQHandler,					/* 34, INTISR[ 18]  ADC Global Interrupt                       */
	USB_HP_CAN_TX_IRQHandler,		/* 35, INTISR[ 19]  USB High Priority / CAN TX  Interrupts     */
	USB_LP_CAN_RX0_IRQHandler,		/* 36, INTISR[ 20]  USB Low  Priority / CAN RX0 Interrupts     */
	CAN_RX1_IRQHandler,				/* 37, INTISR[ 21]  CAN RX1 Interrupt                          */
	CAN_SCE_IRQHandler,				/* 38, INTISR[ 22]  CAN SCE Interrupt                          */
	EXTI9_5_IRQHandler,				/* 39, INTISR[ 23]  EXTI Line[9:5] Interrupt                   */
	TIM1_BRK_IRQHandler,			/* 40, INTISR[ 24]  TIM1 Break  Interrupt                      */
	TIM1_UP_IRQHandler,				/* 41, INTISR[ 25]  TIM1 Update Interrupt                      */
	TIM1_TRG_COM_IRQHandler,		/* 42, INTISR[ 26]  TIM1 Trigger & Commutation Interrupts      */
	TIM1_CC_IRQHandler,				/* 43, INTISR[ 27]	TIM1 Capture Compare Interrupt			   */
	TIM2_IRQHandler,				/* 44, INTISR[ 28]  TIM2 Global Interrupt                      */
	TIM3_IRQHandler,				/* 45, INTISR[ 29]  TIM3 Global Interrupt                      */
	TIM4_IRQHandler,				/* 46, INTISR[ 30]  TIM4 Global Interrupt                      */
	I2C1_EV_IRQHandler,				/* 47, INTISR[ 31]  I2C1 Event  Interrupt                      */
	I2C1_ER_IRQHandler,				/* 48, INTISR[ 32]  I2C1 Error  Interrupt                      */
	I2C2_EV_IRQHandler,				/* 49, INTISR[ 33]  I2C2 Event  Interrupt                      */
	I2C2_ER_IRQHandler,				/* 50, INTISR[ 34]  I2C2 Error  Interrupt                      */
	SPI1_IRQHandler,				/* 51, INTISR[ 35]  SPI1 Global Interrupt                      */
	SPI2_IRQHandler,				/* 52, INTISR[ 36]  SPI2 Global Interrupt                      */
  	USART1_IRQHandler,				/* 53, INTISR[ 37]  USART1 Global Interrupt                    */
 	USART2_IRQHandler,				/* 54, INTISR[ 38]  USART2 Global Interrupt                    */
	USART3_IRQHandler,				/* 55, INTISR[ 39]  USART3 Global Interrupt                    */
	EXTI15_10_IRQHandler,			/* 56, INTISR[ 40]  EXTI Line [15:10] Interrupts               */
	RTCAlarm_IRQHandler,			/* 57, INTISR[ 41]  RTC Alarm through EXT Line Interrupt       */
	USBWakeUp_IRQHandler,			/* 58, INTISR[ 42]  USB Wakeup from Suspend through EXTI Int.  */
	TIM8_BRK_IRQHandler,			/* 59, INTISR[ 43]  TIM8_BRK_IRQHandler */
	TIM8_UP_IRQHandler,				/* 60, INTISR[ 44]  TIM8_UP_IRQHandler */
	TIM8_TRG_COM_IRQHandler,		/* 61, INTISR[ 45]  TIM8_TRG_COM_IRQHandler */
	TIM8_CC_IRQHandler,				/* 62, INTISR[ 46]  TIM8_CC_IRQHandler */
	ADC3_IRQHandler,				/* 63, INTISR[ 47]  ADC3_IRQHandler */
	FSMC_IRQHandler,				/* 64, INTISR[ 48]  FSMC_IRQHandler */
	SDIO_IRQHandler,				/* 65, INTISR[ 49]  SDIO_IRQHandler */
	TIM5_IRQHandler,				/* 66, INTISR[ 50]  TIM5_IRQHandler */
	SPI3_IRQHandler,				/* 67, INTISR[ 51]  SPI3_IRQHandler */
	UART4_IRQHandler,				/* 68, INTISR[ 52]  UART4_IRQHandler */
	UART5_IRQHandler,				/* 69, INTISR[ 53]  UART5_IRQHandler */
	TIM6_IRQHandler,				/* 70, INTISR[ 54]  TIM6_IRQHandler */
	TIM7_IRQHandler,				/* 71, INTISR[ 55]  TIM7_IRQHandler */
	DMA2_Stream0_IRQHandler,		/* 72, INTISR[ 56]  DMA2_Channel1_IRQHandler */
	DMA2_Stream1_IRQHandler,		/* 73, INTISR[ 57]  DMA2_Channel2_IRQHandler */
	DMA2_Stream2_IRQHandler,		/* 74, INTISR[ 58]  DMA2_Channel3_IRQHandler */
	DMA2_Stream3_IRQHandler,		/* 75, INTISR[ 59]  DMA2_Channel4_IRQHandler */
	DMA2_Stream4_IRQHandler,		/* 75, INTISR[ 59]  DMA2_Channel5_IRQHandler */
	ETH_IRQHandler,                  /* 76 Ethernet  */                                      
    ETH_WKUP_IRQHandler,             /* 77 Ethernet Wakeup through EXTI line  */
    CAN2_TX_IRQHandler,              /* 78 CAN2 TX  */
    CAN2_RX0_IRQHandler,             /* 79 CAN2 RX0 */
    CAN2_RX1_IRQHandler,             /* CAN2 RX1 */
    CAN2_SCE_IRQHandler,             /* CAN2 SCE  */
    OTG_FS_IRQHandler,               /* USB OTG FS */
    DMA2_Stream5_IRQHandler,         /* DMA2 Stream 5 */
    DMA2_Stream6_IRQHandler,         /* DMA2 Stream 6 */
    DMA2_Stream7_IRQHandler,         /* DMA2 Stream 7 */
    USART6_IRQHandler,               /* USART6 */
    I2C3_EV_IRQHandler,              /* I2C3 event */
    I2C3_ER_IRQHandler,              /* I2C3 error */
    OTG_HS_EP1_OUT_IRQHandler,       /* USB OTG HS End Point 1 Out   */
    OTG_HS_EP1_IN_IRQHandler,        /* USB OTG HS End Point 1 In  */
    OTG_HS_WKUP_IRQHandler,          /* USB OTG HS Wakeup through EXTI */
    OTG_HS_IRQHandler,               /* USB OTG HS  */
    DCMI_IRQHandler,                 /* DCMI  */
    CRYP_IRQHandler,                 /* CRYP crypto  */
    HASH_RNG_IRQHandler,             /* Hash and Rng */
};
/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/


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


