///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:26 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\dev\extint /
//                    \extInt_vect_v0903.c                                    /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\dev\extint /
//                    \extInt_vect_v0903.c -D _MIMO_Type -lcN                 /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120109\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120109\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\extIn /
//                    t_vect_v0903.s                                          /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME extInt_vect_v0903

        SECTION CSTACK:DATA:NOROOT(0)

        EXTERN ADC_IRQHandler
        EXTERN EXTI0_IRQHandler
        EXTERN EXTI15_10_IRQHandler
        EXTERN EXTI1_IRQHandler
        EXTERN EXTI2_IRQHandler
        EXTERN EXTI3_IRQHandler
        EXTERN EXTI4_IRQHandler
        EXTERN EXTI9_5_IRQHandler
        EXTERN OS_CPU_PendSVHandler
        EXTERN Tmr_TickISR_Handler
        EXTERN USART1_IRQHandler
        EXTERN USART4_IRQHandler
        EXTERN __iar_program_start
        EXTERN convinfo

        PUBLIC AppVectTbl
        PUBLIC App_Fault_ISR
        PUBLIC App_NMI_ISR
        PUBLIC App_Spurious_ISR

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\dev\extint\extInt_vect_v0903.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                              EXAMPLE CODE
//    4 *
//    5 *                          (c) Copyright 2003-2007; Micrium, Inc.; Weston, FL
//    6 *
//    7 *               All rights reserved.  Protected by international copyright laws.
//    8 *               Knowledge of the source code may NOT be used to develop a similar product.
//    9 *               Please help us continue to provide the Embedded community with the finest
//   10 *               software available.  Your honesty is greatly appreciated.
//   11 *********************************************************************************************************
//   12 */
//   13 
//   14 /*
//   15 *********************************************************************************************************
//   16 *
//   17 *                                         EXCEPTION VECTORS
//   18 *
//   19 *                                     ST Microelectronics STM32
//   20 *                                              with the
//   21 *                                   IAR STM32-SK Evaluation Board
//   22 *
//   23 * Filename      : app_vect.c
//   24 * Version       : V1.00
//   25 * Programmer(s) : Brian Nagel
//   26 *********************************************************************************************************
//   27 */
//   28 #include <../../include/main.h>
//   29 
//   30 
//   31 #pragma language=extended
//   32 
//   33 /*
//   34 *********************************************************************************************************
//   35 *                                              PROTOTYPES
//   36 *********************************************************************************************************
//   37 */
//   38 void OS_CPU_PendSVHandler(void);
//   39 void  Tmr_TickISR_Handler (void);
//   40 void __iar_program_start(void);
//   41 extern const selfinfo convinfo;
//   42 
//   43 void  App_Spurious_ISR(void);
//   44 void  App_NMI_ISR(void);
//   45 void  App_Fault_ISR(void);
//   46 
//   47 /*
//   48 *********************************************************************************************************
//   49 *                                  Exception / Interrupt Vector Table
//   50 *********************************************************************************************************
//   51 */
//   52 
//   53 #pragma segment = "CSTACK"
//   54 
//   55 #pragma location = ".intvec"
//   56 

        SECTION `.intvec`:CONST:ROOT(2)
//   57 __root  const  INTVECT_ELEM  AppVectTbl[] = {
AppVectTbl:
        DATA
        DC32 SFE(CSTACK), __iar_program_start, App_NMI_ISR, App_Fault_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR, 4C4F5049H
        DC32 0H, 8007000H, convinfo, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, OS_CPU_PendSVHandler, Tmr_TickISR_Handler
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 EXTI0_IRQHandler, EXTI1_IRQHandler, EXTI2_IRQHandler
        DC32 EXTI3_IRQHandler, EXTI4_IRQHandler, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 ADC_IRQHandler, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, EXTI9_5_IRQHandler
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, USART1_IRQHandler, App_Spurious_ISR
        DC32 App_Spurious_ISR, EXTI15_10_IRQHandler, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, USART4_IRQHandler, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
        DC32 App_Spurious_ISR, App_Spurious_ISR, App_Spurious_ISR
//   58     { .__ptr = __sfe("CSTACK")},        /*  0, SP start value.                                         */
//   59     __iar_program_start,                /*  1, PC start value.                                         */
//   60     App_NMI_ISR,                        /*  2, NMI                                                     */
//   61     App_Fault_ISR,                      /*  3, Hard Fault                                              */
//   62     App_Spurious_ISR,                   /*  4, Memory Management                                       */
//   63     App_Spurious_ISR,                   /*  5, Bus Fault                                               */
//   64     App_Spurious_ISR,                   /*  6, Usage Fault                                             */
//   65     (intfunc)_pilog,                    /*  7, Reserved                                                */
//   66     0,                                  /*  8, Reserved                                                */
//   67     (intfunc)__pAPPLAddr,               /*  9, Reserved                                                */
//   68     (intfunc)&convinfo,                 /* 10, Reserved                                                */
//   69     App_Spurious_ISR,                   /* 11, SVCall                                                  */
//   70     App_Spurious_ISR,                   /* 12, Debug Monitor                                           */
//   71     App_Spurious_ISR,                   /* 13, Reserved                                                */
//   72     OS_CPU_PendSVHandler,               /* 14, PendSV Handler                                          */
//   73 	Tmr_TickISR_Handler,                /* 15, uC/OS-II Tick ISR Handler                               */
//   74     App_Spurious_ISR,                   /* 16, INTISR[  0], Window Watchdog                            */
//   75     App_Spurious_ISR,                   /* 17, INTISR[  1]  PVD through EXTI Line Detection            */
//   76     App_Spurious_ISR,                   /* 18, INTISR[  2]  Tamper Interrupt                           */
//   77     App_Spurious_ISR,                   /* 19, INTISR[  3]  RTC Global Interrupt                       */
//   78     App_Spurious_ISR,                   /* 20, INTISR[  4]  FLASH Global Interrupt                     */
//   79     App_Spurious_ISR,                   /* 21, INTISR[  5]  RCC Global Interrupt                       */
//   80 	#ifdef _EXTI
//   81 		EXTI0_IRQHandler,
//   82 	#else
//   83 		App_Spurious_ISR,				/* 22, INTISR[  6]  EXTI Line0 Interrupt                       */
//   84 	#endif
//   85 
//   86 	#ifdef _EXTI
//   87 		EXTI1_IRQHandler,
//   88 	#else
//   89 		App_Spurious_ISR,				/* 23, INTISR[  7]  EXTI Line1 Interrupt                       */
//   90 	#endif
//   91 	#ifdef _EXTI
//   92 		EXTI2_IRQHandler,
//   93 	#else
//   94 		App_Spurious_ISR,				/* 24, INTISR[  8]  EXTI Line2 Interrupt                       */
//   95 	#endif
//   96 	#ifdef _EXTI
//   97 		EXTI3_IRQHandler,
//   98 	#else
//   99 		App_Spurious_ISR,				/* 25, INTISR[  9]  EXTI Line3 Interrupt                       */
//  100 	#endif
//  101 
//  102 	#ifdef _EXTI
//  103 		EXTI4_IRQHandler,
//  104 	#else
//  105 		App_Spurious_ISR,				/* 26, INTISR[ 10]  EXTI Line4 Interrupt                       */
//  106 	#endif
//  107 
//  108 	App_Spurious_ISR,                   /* 27, INTISR[ 11]  DMA Channel1 Global Interrupt              */
//  109     App_Spurious_ISR,                   /* 28, INTISR[ 12]  DMA Channel2 Global Interrupt              */
//  110     App_Spurious_ISR,                   /* 29, INTISR[ 13]  DMA Channel3 Global Interrupt              */
//  111     App_Spurious_ISR,                   /* 30, INTISR[ 14]  DMA Channel4 Global Interrupt              */
//  112     App_Spurious_ISR,                   /* 31, INTISR[ 15]  DMA Channel5 Global Interrupt              */
//  113     App_Spurious_ISR,                   /* 32, INTISR[ 16]  DMA Channel6 Global Interrupt              */
//  114     App_Spurious_ISR,                   /* 33, INTISR[ 17]  DMA Channel7 Global Interrupt              */
//  115 	#ifdef _ADC
//  116 		ADC_IRQHandler,
//  117 	#else
//  118     	App_Spurious_ISR,               /* 34, INTISR[ 18]  ADC Global Interrupt                       */
//  119     #endif
//  120     App_Spurious_ISR,                   /* 35, INTISR[ 19]  USB High Priority / CAN TX  Interrupts     */
//  121     App_Spurious_ISR,                   /* 36, INTISR[ 20]  USB Low  Priority / CAN RX0 Interrupts     */
//  122     App_Spurious_ISR,                   /* 37, INTISR[ 21]  CAN RX1 Interrupt                          */
//  123     App_Spurious_ISR,                   /* 38, INTISR[ 22]  CAN SCE Interrupt                          */
//  124 	#ifdef _EXTI
//  125 		EXTI9_5_IRQHandler,
//  126 	#else
//  127     	App_Spurious_ISR,				/* 39, INTISR[ 23]  EXTI Line[9:5] Interrupt                   */
//  128 	#endif
//  129 	App_Spurious_ISR,                   /* 40, INTISR[ 24]  TIM1 Break  Interrupt                      */
//  130     App_Spurious_ISR,                   /* 41, INTISR[ 25]  TIM1 Update Interrupt                      */
//  131     App_Spurious_ISR,                   /* 42, INTISR[ 26]  TIM1 Trigger & Commutation Interrupts      */
//  132     App_Spurious_ISR,					/* 43, INTISR[ 27]	TIM1 Capture Compare Interrupt			   */
//  133     App_Spurious_ISR,                   /* 44, INTISR[ 28]  TIM2 Global Interrupt                      */
//  134     App_Spurious_ISR,                   /* 45, INTISR[ 29]  TIM3 Global Interrupt                      */
//  135     App_Spurious_ISR,                   /* 46, INTISR[ 30]  TIM4 Global Interrupt                      */
//  136     App_Spurious_ISR,                   /* 47, INTISR[ 31]  I2C1 Event  Interrupt                      */
//  137     App_Spurious_ISR,                   /* 48, INTISR[ 32]  I2C1 Error  Interrupt                      */
//  138     App_Spurious_ISR,                   /* 49, INTISR[ 33]  I2C2 Event  Interrupt                      */
//  139     App_Spurious_ISR,                   /* 50, INTISR[ 34]  I2C2 Error  Interrupt                      */
//  140     App_Spurious_ISR,                   /* 51, INTISR[ 35]  SPI1 Global Interrupt                      */
//  141     App_Spurious_ISR,                   /* 52, INTISR[ 36]  SPI2 Global Interrupt                      */
//  142 	#ifdef _USART1
//  143 		USART1_IRQHandler,
//  144 	#else
//  145     	App_Spurious_ISR,               /* 53, INTISR[ 37]  USART1 Global Interrupt                    */
//  146 	#endif
//  147 	#ifdef _USART2
//  148 		USART2_IRQHandler,
//  149 	#else
//  150 		App_Spurious_ISR,//ProbeRS232_RxTxISRHandler,          /* 54, INTISR[ 38]  USART2 Global Interrupt                    */
//  151 	#endif
//  152 	#ifdef _USART3
//  153 		USART3_IRQHandler,
//  154 	#else
//  155 		App_Spurious_ISR,//ProbeRS232_RxTxISRHandler,          /* 55, INTISR[ 39]  USART3 Global Interrupt                    */
//  156 	#endif
//  157 	#ifdef _EXTI
//  158 		EXTI15_10_IRQHandler,
//  159 	#else
//  160 		App_Spurious_ISR,				/* 56, INTISR[ 40]  EXTI Line [15:10] Interrupts               */
//  161 	#endif
//  162 	App_Spurious_ISR,                   /* 57, INTISR[ 41]  RTC Alarm through EXT Line Interrupt       */
//  163     App_Spurious_ISR,                   /* 58, INTISR[ 42]  USB Wakeup from Suspend through EXTI Int.  */
//  164     
//  165 	App_Spurious_ISR,					/* 59, INTISR[ 43]  TIM8_BRK_IRQHandler */
//  166 	App_Spurious_ISR,					/* 60, INTISR[ 44]  TIM8_UP_IRQHandler */
//  167 	App_Spurious_ISR,					/* 61, INTISR[ 45]  TIM8_TRG_COM_IRQHandler */
//  168 	App_Spurious_ISR,					/* 62, INTISR[ 46]  TIM8_CC_IRQHandler */
//  169 	App_Spurious_ISR,					/* 63, INTISR[ 47]  ADC3_IRQHandler */
//  170 	App_Spurious_ISR,					/* 64, INTISR[ 48]  FSMC_IRQHandler */
//  171 	App_Spurious_ISR,					/* 65, INTISR[ 49]  SDIO_IRQHandler */
//  172 	App_Spurious_ISR,					/* 66, INTISR[ 50]  TIM5_IRQHandler */
//  173 	App_Spurious_ISR,					/* 67, INTISR[ 51]  SPI3_IRQHandler */
//  174 	#ifdef _USART4
//  175 		USART4_IRQHandler,
//  176 	#else
//  177 		App_Spurious_ISR,				/* 68, INTISR[ 52]  UART4_IRQHandler */
//  178 	#endif
//  179 	#ifdef _USART5
//  180 		USART5_IRQHandler,
//  181 	#else
//  182 		App_Spurious_ISR,				/* 69, INTISR[ 53]  UART5_IRQHandler */
//  183 	#endif
//  184 	App_Spurious_ISR,					/* 70, INTISR[ 54]  TIM6_IRQHandler */
//  185 	App_Spurious_ISR,					/* 71, INTISR[ 55]  TIM7_IRQHandler */
//  186 	App_Spurious_ISR,					/* 72, INTISR[ 56]  DMA2_Channel1_IRQHandler */
//  187 	App_Spurious_ISR,					/* 73, INTISR[ 57]  DMA2_Channel2_IRQHandler */
//  188 	App_Spurious_ISR,					/* 74, INTISR[ 58]  DMA2_Channel3_IRQHandler */
//  189 	App_Spurious_ISR,					/* 75, INTISR[ 59]  DMA2_Channel4_5_IRQHandler */
//  190 };
//  191 
//  192 /*
//  193 *********************************************************************************************************
//  194 *                                      Spurious Interrupt Handler
//  195 *********************************************************************************************************
//  196 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  197 void  App_Spurious_ISR (void)
//  198 {
//  199 	while(0)
//  200 	{
//  201 		//USART1PutChar('S');
//  202     }
//  203 }
App_Spurious_ISR:
        BX       LR               ;; return
//  204 
//  205 /*
//  206 *********************************************************************************************************
//  207 *                                        NMI Exception Handler
//  208 *********************************************************************************************************
//  209 */
//  210 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  211 void  App_NMI_ISR (void)
//  212 {
//  213 	while(0)
//  214 	{
//  215 		//USART1PutChar('N');
//  216 	}
//  217 }
App_NMI_ISR:
        BX       LR               ;; return
//  218 
//  219 
//  220 /*
//  221 *********************************************************************************************************
//  222 *                                       FAULT Exception Handler
//  223 *********************************************************************************************************
//  224 */
//  225 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  226 void  App_Fault_ISR (void)
//  227 {
//  228 	while(0)
//  229 	{
//  230 		//USART1PutChar('I');
//  231 	}
//  232 }
App_Fault_ISR:
        BX       LR               ;; return

        SECTION CSTACK:DATA:NOROOT(0)

        END
//  233 
//  234 
//  235 
// 
// 304 bytes in section .intvec
//   6 bytes in section .text
// 
//   6 bytes of CODE  memory
// 304 bytes of CONST memory
//
//Errors: none
//Warnings: none
