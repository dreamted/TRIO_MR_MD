///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:51:59 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_main.c                                /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_main.c -D OS_INCLUDED -D APPL_SRC     /
//                    -lA D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ -o       /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_mai /
//                    n.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_main

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN OSInit
        EXTERN OSStart
        EXTERN OSTaskCreate
        EXTERN mainTask

        PUBLIC MainTaskStk
        PUBLIC main
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_main.c
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
//   13 #define __STM32F10x_EXT_MAIN
//   14 
//   15 #if defined (OS_INCLUDED)
//   16 	#include <includes.h>
//   17 #endif	/* OS_INCLUDED */
//   18 #include "stm32f2xx_main.h"

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute OS_STK MainTaskStk[128]
MainTaskStk:
        DS8 512
//   19 
//   20 
//   21 /*******************************************************************************
//   22 *                                                main()
//   23 *
//   24 * Description : This is the standard entry point for C code.  It is assumed that your code will call
//   25 *               main() once you have performed all necessary initialization.
//   26 *
//   27 * Arguments   : none
//   28 *
//   29 * Returns     : none
//   30 ********************************************************************************/
//   31 void __RESETPRIMASK(void);
//   32 

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function main
        THUMB
//   33 int  main (void)
//   34 {
main:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//   35 //    CPU_IntDis();	// Disable all interrupts until we are ready to accept them
//   36 #ifndef OS_INCLUDED
//   37 	mainTask(NULL);
//   38 #else	
//   39     OSInit();			// Initialize "uC/OS-II, The Real-Time Kernel"
        BL       OSInit
//   40 	OSTaskCreate(mainTask, (void *)NULL, (OS_STK *)&MainTaskStk[OS_TASK_STK_SIZE - 1], MAIN_START_PRIO);
        MOVS     R3,#+0
        LDR.N    R2,??main_0
        MOVS     R1,#+0
        LDR.N    R0,??main_0+0x4
        BL       OSTaskCreate
//   41     OSStart();			// Start multitasking (i.e. give control to uC/OS-II)
        BL       OSStart
//   42 #endif	/* OS_INCLUDED */
//   43 
//   44 }
        MOVS     R0,#+0
        POP      {R1,PC}          ;; return
        Nop      
        DATA
??main_0:
        DC32     MainTaskStk+0x1FC
        DC32     mainTask
        CFI EndBlock cfiBlock0

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//   45 
//   46 /*
//   47 *********************************************************************************************************
//   48 *                                   APPLICATION-DEFINED HOOKS
//   49 *
//   50 * Description: These functions are called by the hooks in os_cpu_c.c.
//   51 *
//   52 * Returns    : none
//   53 *********************************************************************************************************
//   54 */
//   55 #if defined(OS_INCLUDED)
//   56 
//   57 
//   58 #if (OS_APP_HOOKS_EN > 0)
//   59 void  App_TaskCreateHook (OS_TCB *ptcb)
//   60 {
//   61 #if (uC_PROBE_OS_PLUGIN > 0) && (OS_PROBE_HOOKS_EN > 0)
//   62     OSProbe_TaskCreateHook(ptcb);
//   63 #endif
//   64 }
//   65 
//   66 
//   67 void  App_TaskDelHook (OS_TCB *ptcb)
//   68 {
//   69     (void)ptcb;
//   70 }
//   71 
//   72 #if OS_VERSION >= 251
//   73 void  App_TaskIdleHook (void)
//   74 {
//   75 }
//   76 #endif
//   77 
//   78 
//   79 void  App_TaskStatHook (void)
//   80 {
//   81 }
//   82 
//   83 
//   84 #if OS_TASK_SW_HOOK_EN > 0
//   85 void  App_TaskSwHook (void)
//   86 {
//   87 #if (uC_PROBE_OS_PLUGIN > 0) && (OS_PROBE_HOOKS_EN > 0)
//   88     OSProbe_TaskSwHook();
//   89 #endif
//   90 }
//   91 #endif
//   92 
//   93 
//   94 #if OS_VERSION >= 204
//   95 void  App_TCBInitHook (OS_TCB *ptcb)
//   96 {
//   97     (void)ptcb;
//   98 }
//   99 #endif
//  100 
//  101 
//  102 #if OS_TIME_TICK_HOOK_EN > 0
//  103 void  App_TimeTickHook (void)
//  104 {
//  105 #if (uC_PROBE_OS_PLUGIN > 0) && (OS_PROBE_HOOKS_EN > 0)
//  106     OSProbe_TickHook();
//  107 #endif
//  108 }
//  109 #endif
//  110 #endif
//  111 
//  112 #endif /* OS_INCLUDED */
//  113 
//  114 ////////////////////////////////////////////////////////////////////////////////
//  115 // End of Sourece File
//  116 
// 
//  36 bytes in section .text
// 512 bytes in section iram
// 
//  36 bytes of CODE memory
// 512 bytes of DATA memory
//
//Errors: none
//Warnings: none
