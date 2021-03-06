///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    22/Nov/2012  02:41:05 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\stm32f2xx_vector.c                                  /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\stm32f2xx_vector.c -D OS_INCLUDED -D APPL_SRC -lA   /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ -o           /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\out\              /
//                    --endian=little --cpu=Cortex-M3 -e --fpu=None           /
//                    --dlib_config "C:\Programming\IAR Systems\Embedded      /
//                    Workbench 6.0\arm\INC\c\DLib_Config_Normal.h" -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\include\ -I       /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\..\..\STM32F2xx_S /
//                    tdPeriph_Driver\ -I D:\Work\Project\2012\NL_INBUILD\FW\ /
//                    MU\..\..\STM32F2xx_StdPeriph_Driver\inc\ -I             /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-CPU\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-LIB\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Ports\    /
//                    -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Source /
//                    \ -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-Probe\    /
//                    -Oh --use_c++_inline                                    /
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_vec /
//                    tor.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_vector

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        SECTION CSTACK:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        EXTERN ADC3_IRQHandler
        EXTERN ADC_IRQHandler
        EXTERN BusFaultException
        EXTERN CAN2_RX0_IRQHandler
        EXTERN CAN2_RX1_IRQHandler
        EXTERN CAN2_SCE_IRQHandler
        EXTERN CAN2_TX_IRQHandler
        EXTERN CAN_RX1_IRQHandler
        EXTERN CAN_SCE_IRQHandler
        EXTERN CRYP_IRQHandler
        EXTERN DCMI_IRQHandler
        EXTERN DMA2_Stream0_IRQHandler
        EXTERN DMA2_Stream1_IRQHandler
        EXTERN DMA2_Stream2_IRQHandler
        EXTERN DMA2_Stream3_IRQHandler
        EXTERN DMA2_Stream4_IRQHandler
        EXTERN DMA2_Stream5_IRQHandler
        EXTERN DMA2_Stream6_IRQHandler
        EXTERN DMA2_Stream7_IRQHandler
        EXTERN DMAChannel1_IRQHandler
        EXTERN DMAChannel2_IRQHandler
        EXTERN DMAChannel3_IRQHandler
        EXTERN DMAChannel4_IRQHandler
        EXTERN DMAChannel5_IRQHandler
        EXTERN DMAChannel6_IRQHandler
        EXTERN DMAChannel7_IRQHandler
        EXTERN DebugMonitor
        EXTERN ETH_IRQHandler
        EXTERN ETH_WKUP_IRQHandler
        EXTERN EXTI0_IRQHandler
        EXTERN EXTI15_10_IRQHandler
        EXTERN EXTI1_IRQHandler
        EXTERN EXTI2_IRQHandler
        EXTERN EXTI3_IRQHandler
        EXTERN EXTI4_IRQHandler
        EXTERN EXTI9_5_IRQHandler
        EXTERN FLASH_IRQHandler
        EXTERN FSMC_IRQHandler
        EXTERN HASH_RNG_IRQHandler
        EXTERN HardFaultException
        EXTERN I2C1_ER_IRQHandler
        EXTERN I2C1_EV_IRQHandler
        EXTERN I2C2_ER_IRQHandler
        EXTERN I2C2_EV_IRQHandler
        EXTERN I2C3_ER_IRQHandler
        EXTERN I2C3_EV_IRQHandler
        EXTERN MemManageException
        EXTERN NMIException
        EXTERN OS_CPU_PendSVHandler
        EXTERN OTG_FS_IRQHandler
        EXTERN OTG_HS_EP1_IN_IRQHandler
        EXTERN OTG_HS_EP1_OUT_IRQHandler
        EXTERN OTG_HS_IRQHandler
        EXTERN OTG_HS_WKUP_IRQHandler
        EXTERN PVD_IRQHandler
        EXTERN RCC_IRQHandler
        EXTERN RTCAlarm_IRQHandler
        EXTERN RTC_IRQHandler
        EXTERN SDIO_IRQHandler
        EXTERN SPI1_IRQHandler
        EXTERN SPI2_IRQHandler
        EXTERN SPI3_IRQHandler
        EXTERN SVCHandler
        EXTERN SysTickHandler
        EXTERN SystemInit
        EXTERN TAMPER_IRQHandler
        EXTERN TIM1_BRK_IRQHandler
        EXTERN TIM1_CC_IRQHandler
        EXTERN TIM1_TRG_COM_IRQHandler
        EXTERN TIM1_UP_IRQHandler
        EXTERN TIM2_IRQHandler
        EXTERN TIM3_IRQHandler
        EXTERN TIM4_IRQHandler
        EXTERN TIM5_IRQHandler
        EXTERN TIM6_IRQHandler
        EXTERN TIM7_IRQHandler
        EXTERN TIM8_BRK_IRQHandler
        EXTERN TIM8_CC_IRQHandler
        EXTERN TIM8_TRG_COM_IRQHandler
        EXTERN TIM8_UP_IRQHandler
        EXTERN UART4_IRQHandler
        EXTERN UART5_IRQHandler
        EXTERN USART1_IRQHandler
        EXTERN USART2_IRQHandler
        EXTERN USART3_IRQHandler
        EXTERN USART6_IRQHandler
        EXTERN USBWakeUp_IRQHandler
        EXTERN USB_HP_CAN_TX_IRQHandler
        EXTERN USB_LP_CAN_RX0_IRQHandler
        EXTERN UsageFaultException
        EXTERN WWDG_IRQHandler
        EXTERN convinfo

        PUBLIC App_Fault_ISR
        PUBLIC App_NMI_ISR
        PUBLIC App_Spurious_ISR
        PUBLIC __vector_table
        
        CFI Names cfiNames0
        CFI StackFrame CFA R13 DATA
        CFI Resource R0:32, R1:32, R2:32, R3:32, R4:32, R5:32, R6:32, R7:32
        CFI Resource R8:32, R9:32, R10:32, R11:32, R12:32, R13:32, R14:32
        CFI EndNames cfiNames0
        
        CFI Common cfiCommon0 Using cfiNames0
        CFI CodeAlign 2
        CFI DataAlign 4
        CFI ReturnAddress R14 CODE
        CFI CFA R13+0
        CFI R0 Undefined
        CFI R1 Undefined
        CFI R2 Undefined
        CFI R3 Undefined
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R12 Undefined
        CFI R14 SameValue
        CFI EndCommon cfiCommon0
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\stm32f2xx_vector.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_vector.c
//    3 * Author             : MCD Application Team
//    4 * Date First Issued  : 02/19/2007
//    5 * Description        : This file contains the vector table for STM32F10x.
//    6 *                      After Reset the Cortex-M3 processor is in Thread mode,
//    7 *                      priority is Privileged, and the Stack is set to Main.
//    8 ********************************************************************************
//    9 * History:
//   10 * 05/21/2007: V0.3
//   11 * 04/02/2007: V0.2
//   12 * 02/19/2007: V0.1
//   13 ********************************************************************************
//   14 * THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   15 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   16 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   17 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   18 * CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   19 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   20 *******************************************************************************/
//   21 
//   22 #ifndef __STM32F2xx_VECTOR_H
//   23 #define __STM32F2xx_VECTOR_H
//   24 #endif
//   25 // Includes --------------------------------------------------------------------
//   26 #include "main.h"			/*!<user defined using cpu*/
//   27 
//   28 /* Private define ------------------------------------------------------------*/
//   29 /* Private macro -------------------------------------------------------------*/
//   30 /* Private variables ---------------------------------------------------------*/
//   31 /* Private function prototypes -----------------------------------------------*/
//   32 /* Private functions ---------------------------------------------------------*/
//   33 
//   34 void  App_Spurious_ISR (void);
//   35 void  App_NMI_ISR (void);
//   36 void  App_Fault_ISR (void);
//   37 
//   38 #ifdef OS_INCLUDED
//   39 	void OS_CPU_PendSVHandler(void);
//   40 	void  Tmr_TickISR_Handler (void);
//   41 #endif /* OS_INCLUDED */
//   42 
//   43 #ifdef APPL_SRC
//   44 	extern const selfinfo convinfo;
//   45 #endif /* APPL_SRC */
//   46 
//   47 #pragma language = extended
//   48 #pragma segment="CSTACK"
//   49 
//   50 void __iar_program_start( void );
//   51 
//   52 #pragma location = ".intvec"
//   53 

        SECTION `.intvec`:CONST:REORDER:NOROOT(2)
//   54 const intvec_elem __vector_table[] =
__vector_table:
        DATA
        DC32 SFE(CSTACK), SystemInit, NMIException, HardFaultException
        DC32 MemManageException, BusFaultException, UsageFaultException
        DC32 4C4F5049H, 0H, 4C4F5049H, convinfo, SVCHandler, DebugMonitor, 0H
        DC32 OS_CPU_PendSVHandler, SysTickHandler, WWDG_IRQHandler
        DC32 PVD_IRQHandler, TAMPER_IRQHandler, RTC_IRQHandler
        DC32 FLASH_IRQHandler, RCC_IRQHandler, EXTI0_IRQHandler
        DC32 EXTI1_IRQHandler, EXTI2_IRQHandler, EXTI3_IRQHandler
        DC32 EXTI4_IRQHandler, DMAChannel1_IRQHandler, DMAChannel2_IRQHandler
        DC32 DMAChannel3_IRQHandler, DMAChannel4_IRQHandler
        DC32 DMAChannel5_IRQHandler, DMAChannel6_IRQHandler
        DC32 DMAChannel7_IRQHandler, ADC_IRQHandler, USB_HP_CAN_TX_IRQHandler
        DC32 USB_LP_CAN_RX0_IRQHandler, CAN_RX1_IRQHandler, CAN_SCE_IRQHandler
        DC32 EXTI9_5_IRQHandler, TIM1_BRK_IRQHandler, TIM1_UP_IRQHandler
        DC32 TIM1_TRG_COM_IRQHandler, TIM1_CC_IRQHandler, TIM2_IRQHandler
        DC32 TIM3_IRQHandler, TIM4_IRQHandler, I2C1_EV_IRQHandler
        DC32 I2C1_ER_IRQHandler, I2C2_EV_IRQHandler, I2C2_ER_IRQHandler
        DC32 SPI1_IRQHandler, SPI2_IRQHandler, USART1_IRQHandler
        DC32 USART2_IRQHandler, USART3_IRQHandler, EXTI15_10_IRQHandler
        DC32 RTCAlarm_IRQHandler, USBWakeUp_IRQHandler, TIM8_BRK_IRQHandler
        DC32 TIM8_UP_IRQHandler, TIM8_TRG_COM_IRQHandler, TIM8_CC_IRQHandler
        DC32 ADC3_IRQHandler, FSMC_IRQHandler, SDIO_IRQHandler, TIM5_IRQHandler
        DC32 SPI3_IRQHandler, UART4_IRQHandler, UART5_IRQHandler
        DC32 TIM6_IRQHandler, TIM7_IRQHandler, DMA2_Stream0_IRQHandler
        DC32 DMA2_Stream1_IRQHandler, DMA2_Stream2_IRQHandler
        DC32 DMA2_Stream3_IRQHandler, DMA2_Stream4_IRQHandler, ETH_IRQHandler
        DC32 ETH_WKUP_IRQHandler, CAN2_TX_IRQHandler, CAN2_RX0_IRQHandler
        DC32 CAN2_RX1_IRQHandler, CAN2_SCE_IRQHandler, OTG_FS_IRQHandler
        DC32 DMA2_Stream5_IRQHandler, DMA2_Stream6_IRQHandler
        DC32 DMA2_Stream7_IRQHandler, USART6_IRQHandler, I2C3_EV_IRQHandler
        DC32 I2C3_ER_IRQHandler, OTG_HS_EP1_OUT_IRQHandler
        DC32 OTG_HS_EP1_IN_IRQHandler, OTG_HS_WKUP_IRQHandler
        DC32 OTG_HS_IRQHandler, DCMI_IRQHandler, CRYP_IRQHandler
        DC32 HASH_RNG_IRQHandler
//   55 {
//   56 	{ .__ptr = __sfe( "CSTACK" ) },	/*  0, SP start value.                                         */
//   57 #ifdef APPL_SRC	
//   58 	SystemInit,
//   59 #else
//   60 	__iar_program_start,			/*  1, PC start value.                                         */
//   61 #endif
//   62 	NMIException,					/*  2, NMI                                                     */
//   63 	HardFaultException,				/*  3, Hard Fault                                              */
//   64 	MemManageException,				/*  4, Memory Management                                       */
//   65 	BusFaultException,				/*  5, Bus Fault                                               */
//   66 	UsageFaultException,			/*  6, Usage Fault                                             */
//   67 	(intfunc)_pilog,				/*  7, Reserved                                                */
//   68 	0,								/*  8, Reserved                                                */
//   69 	(intfunc)_pilog,				/*  9, Reserved                                                */
//   70 #ifdef APPL_SRC	
//   71     (intfunc)&convinfo,            	/* 10, Reserved                                                */
//   72 #else // boot
//   73     (intfunc)0,
//   74 #endif /* APPL_SRC */
//   75 	SVCHandler,						/* 11, SVCall                                                  */
//   76 	DebugMonitor,					/* 12, Debug Monitor                                           */
//   77 	0,                      		/* 13, Reserved                                                */
//   78 #ifdef OS_INCLUDED
//   79 	OS_CPU_PendSVHandler,			/* 14, PendSV Handler                                          */
//   80 #else
//   81 	PendSVC,
//   82 #endif /* OS_INCLUDED */
//   83 	SysTickHandler,			        /* 15, uC/OS-II Tick ISR Handler                               */
//   84 
//   85 	WWDG_IRQHandler,				/* 16, INTISR[  0], Window Watchdog                            */
//   86 	PVD_IRQHandler,					/* 17, INTISR[  1]  PVD through EXTI Line Detection            */
//   87 	TAMPER_IRQHandler,				/* 18, INTISR[  2]  Tamper Interrupt                           */
//   88 	RTC_IRQHandler,					/* 19, INTISR[  3]  RTC Global Interrupt                       */
//   89 	FLASH_IRQHandler,				/* 20, INTISR[  4]  FLASH Global Interrupt                     */
//   90 	RCC_IRQHandler,					/* 21, INTISR[  5]  RCC Global Interrupt                       */
//   91 	EXTI0_IRQHandler,				/* 22, INTISR[  6]  EXTI Line0 Interrupt                       */
//   92 	EXTI1_IRQHandler,				/* 23, INTISR[  7]  EXTI Line1 Interrupt                       */
//   93 	EXTI2_IRQHandler,				/* 24, INTISR[  8]  EXTI Line2 Interrupt                       */
//   94 	EXTI3_IRQHandler,				/* 25, INTISR[  9]  EXTI Line3 Interrupt                       */
//   95 	EXTI4_IRQHandler,				/* 26, INTISR[ 10]  EXTI Line4 Interrupt                       */
//   96 	DMAChannel1_IRQHandler,			/* 27, INTISR[ 11]  DMA Channel1 Global Interrupt              */
//   97 	DMAChannel2_IRQHandler,			/* 28, INTISR[ 12]  DMA Channel2 Global Interrupt              */
//   98 	DMAChannel3_IRQHandler,			/* 29, INTISR[ 13]  DMA Channel3 Global Interrupt              */
//   99 	DMAChannel4_IRQHandler,			/* 30, INTISR[ 14]  DMA Channel4 Global Interrupt              */
//  100 	DMAChannel5_IRQHandler,			/* 31, INTISR[ 15]  DMA Channel5 Global Interrupt              */
//  101 	DMAChannel6_IRQHandler,			/* 32, INTISR[ 16]  DMA Channel6 Global Interrupt              */
//  102 	DMAChannel7_IRQHandler,			/* 33, INTISR[ 17]  DMA Channel7 Global Interrupt              */
//  103 	ADC_IRQHandler,					/* 34, INTISR[ 18]  ADC Global Interrupt                       */
//  104 	USB_HP_CAN_TX_IRQHandler,		/* 35, INTISR[ 19]  USB High Priority / CAN TX  Interrupts     */
//  105 	USB_LP_CAN_RX0_IRQHandler,		/* 36, INTISR[ 20]  USB Low  Priority / CAN RX0 Interrupts     */
//  106 	CAN_RX1_IRQHandler,				/* 37, INTISR[ 21]  CAN RX1 Interrupt                          */
//  107 	CAN_SCE_IRQHandler,				/* 38, INTISR[ 22]  CAN SCE Interrupt                          */
//  108 	EXTI9_5_IRQHandler,				/* 39, INTISR[ 23]  EXTI Line[9:5] Interrupt                   */
//  109 	TIM1_BRK_IRQHandler,			/* 40, INTISR[ 24]  TIM1 Break  Interrupt                      */
//  110 	TIM1_UP_IRQHandler,				/* 41, INTISR[ 25]  TIM1 Update Interrupt                      */
//  111 	TIM1_TRG_COM_IRQHandler,		/* 42, INTISR[ 26]  TIM1 Trigger & Commutation Interrupts      */
//  112 	TIM1_CC_IRQHandler,				/* 43, INTISR[ 27]	TIM1 Capture Compare Interrupt			   */
//  113 	TIM2_IRQHandler,				/* 44, INTISR[ 28]  TIM2 Global Interrupt                      */
//  114 	TIM3_IRQHandler,				/* 45, INTISR[ 29]  TIM3 Global Interrupt                      */
//  115 	TIM4_IRQHandler,				/* 46, INTISR[ 30]  TIM4 Global Interrupt                      */
//  116 	I2C1_EV_IRQHandler,				/* 47, INTISR[ 31]  I2C1 Event  Interrupt                      */
//  117 	I2C1_ER_IRQHandler,				/* 48, INTISR[ 32]  I2C1 Error  Interrupt                      */
//  118 	I2C2_EV_IRQHandler,				/* 49, INTISR[ 33]  I2C2 Event  Interrupt                      */
//  119 	I2C2_ER_IRQHandler,				/* 50, INTISR[ 34]  I2C2 Error  Interrupt                      */
//  120 	SPI1_IRQHandler,				/* 51, INTISR[ 35]  SPI1 Global Interrupt                      */
//  121 	SPI2_IRQHandler,				/* 52, INTISR[ 36]  SPI2 Global Interrupt                      */
//  122   	USART1_IRQHandler,				/* 53, INTISR[ 37]  USART1 Global Interrupt                    */
//  123  	USART2_IRQHandler,				/* 54, INTISR[ 38]  USART2 Global Interrupt                    */
//  124 	USART3_IRQHandler,				/* 55, INTISR[ 39]  USART3 Global Interrupt                    */
//  125 	EXTI15_10_IRQHandler,			/* 56, INTISR[ 40]  EXTI Line [15:10] Interrupts               */
//  126 	RTCAlarm_IRQHandler,			/* 57, INTISR[ 41]  RTC Alarm through EXT Line Interrupt       */
//  127 	USBWakeUp_IRQHandler,			/* 58, INTISR[ 42]  USB Wakeup from Suspend through EXTI Int.  */
//  128 	TIM8_BRK_IRQHandler,			/* 59, INTISR[ 43]  TIM8_BRK_IRQHandler */
//  129 	TIM8_UP_IRQHandler,				/* 60, INTISR[ 44]  TIM8_UP_IRQHandler */
//  130 	TIM8_TRG_COM_IRQHandler,		/* 61, INTISR[ 45]  TIM8_TRG_COM_IRQHandler */
//  131 	TIM8_CC_IRQHandler,				/* 62, INTISR[ 46]  TIM8_CC_IRQHandler */
//  132 	ADC3_IRQHandler,				/* 63, INTISR[ 47]  ADC3_IRQHandler */
//  133 	FSMC_IRQHandler,				/* 64, INTISR[ 48]  FSMC_IRQHandler */
//  134 	SDIO_IRQHandler,				/* 65, INTISR[ 49]  SDIO_IRQHandler */
//  135 	TIM5_IRQHandler,				/* 66, INTISR[ 50]  TIM5_IRQHandler */
//  136 	SPI3_IRQHandler,				/* 67, INTISR[ 51]  SPI3_IRQHandler */
//  137 	UART4_IRQHandler,				/* 68, INTISR[ 52]  UART4_IRQHandler */
//  138 	UART5_IRQHandler,				/* 69, INTISR[ 53]  UART5_IRQHandler */
//  139 	TIM6_IRQHandler,				/* 70, INTISR[ 54]  TIM6_IRQHandler */
//  140 	TIM7_IRQHandler,				/* 71, INTISR[ 55]  TIM7_IRQHandler */
//  141 	DMA2_Stream0_IRQHandler,		/* 72, INTISR[ 56]  DMA2_Channel1_IRQHandler */
//  142 	DMA2_Stream1_IRQHandler,		/* 73, INTISR[ 57]  DMA2_Channel2_IRQHandler */
//  143 	DMA2_Stream2_IRQHandler,		/* 74, INTISR[ 58]  DMA2_Channel3_IRQHandler */
//  144 	DMA2_Stream3_IRQHandler,		/* 75, INTISR[ 59]  DMA2_Channel4_IRQHandler */
//  145 	DMA2_Stream4_IRQHandler,		/* 75, INTISR[ 59]  DMA2_Channel5_IRQHandler */
//  146 	ETH_IRQHandler,                  /* 76 Ethernet  */                                      
//  147     ETH_WKUP_IRQHandler,             /* 77 Ethernet Wakeup through EXTI line  */
//  148     CAN2_TX_IRQHandler,              /* 78 CAN2 TX  */
//  149     CAN2_RX0_IRQHandler,             /* 79 CAN2 RX0 */
//  150     CAN2_RX1_IRQHandler,             /* CAN2 RX1 */
//  151     CAN2_SCE_IRQHandler,             /* CAN2 SCE  */
//  152     OTG_FS_IRQHandler,               /* USB OTG FS */
//  153     DMA2_Stream5_IRQHandler,         /* DMA2 Stream 5 */
//  154     DMA2_Stream6_IRQHandler,         /* DMA2 Stream 6 */
//  155     DMA2_Stream7_IRQHandler,         /* DMA2 Stream 7 */
//  156     USART6_IRQHandler,               /* USART6 */
//  157     I2C3_EV_IRQHandler,              /* I2C3 event */
//  158     I2C3_ER_IRQHandler,              /* I2C3 error */
//  159     OTG_HS_EP1_OUT_IRQHandler,       /* USB OTG HS End Point 1 Out   */
//  160     OTG_HS_EP1_IN_IRQHandler,        /* USB OTG HS End Point 1 In  */
//  161     OTG_HS_WKUP_IRQHandler,          /* USB OTG HS Wakeup through EXTI */
//  162     OTG_HS_IRQHandler,               /* USB OTG HS  */
//  163     DCMI_IRQHandler,                 /* DCMI  */
//  164     CRYP_IRQHandler,                 /* CRYP crypto  */
//  165     HASH_RNG_IRQHandler,             /* Hash and Rng */
//  166 };
//  167 /******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
//  168 
//  169 
//  170 /*
//  171 *********************************************************************************************************
//  172 *                                      Spurious Interrupt Handler
//  173 *********************************************************************************************************
//  174 */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function App_Spurious_ISR
        THUMB
//  175 void  App_Spurious_ISR (void)
//  176 {
//  177 	while(0)
//  178 	{
//  179 		//USART1PutChar('S');
//  180     }
//  181 }
App_Spurious_ISR:
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//  182 
//  183 /*
//  184 *********************************************************************************************************
//  185 *                                        NMI Exception Handler
//  186 *********************************************************************************************************
//  187 */
//  188 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function App_NMI_ISR
        THUMB
//  189 void  App_NMI_ISR (void)
//  190 {
//  191 	while(0)
//  192 	{
//  193 		//USART1PutChar('N');
//  194 	}
//  195 }
App_NMI_ISR:
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  196 
//  197 
//  198 /*
//  199 *********************************************************************************************************
//  200 *                                       FAULT Exception Handler
//  201 *********************************************************************************************************
//  202 */
//  203 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function App_Fault_ISR
        THUMB
//  204 void  App_Fault_ISR (void)
//  205 {
//  206 	while(0)
//  207 	{
//  208 		//USART1PutChar('I');
//  209 	}
//  210 }
App_Fault_ISR:
        BX       LR               ;; return
        CFI EndBlock cfiBlock2

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION CSTACK:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  211 
//  212 
// 
// 388 bytes in section .intvec
//   6 bytes in section .text
// 
//   6 bytes of CODE  memory
// 388 bytes of CONST memory
//
//Errors: none
//Warnings: none
