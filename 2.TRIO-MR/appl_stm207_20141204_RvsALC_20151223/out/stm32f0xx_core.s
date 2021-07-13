///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:00 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f0xx_core.c                                /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f0xx_core.c -D OS_INCLUDED -D APPL_SRC     /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f0xx_cor /
//                    e.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f0xx_core

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN CheckSoftTimer
        EXTERN __aeabi_uldivmod

        PUBLIC InitSysTick
        PUBLIC SysTickIntHandler
        PUBLIC __LDREXB
        PUBLIC __LDREXH
        PUBLIC __LDREXW
        PUBLIC __RBIT
        PUBLIC __REV16
        PUBLIC __STREXB
        PUBLIC __STREXH
        PUBLIC __STREXW
        PUBLIC __get_MSP
        PUBLIC __get_PSP
        PUBLIC __set_MSP
        PUBLIC __set_PSP
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f0xx_core.c
//    1 /**************************************************************************//**
//    2  * @file     core_cm3.c
//    3  * @brief    CMSIS Cortex-M3 Core Peripheral Access Layer Source File
//    4  * @version  V1.30
//    5  * @date     30. October 2009
//    6  *
//    7  * @note
//    8  * Copyright (C) 2009 ARM Limited. All rights reserved.
//    9  *
//   10  * @par
//   11  * ARM Limited (ARM) is supplying this software for use with Cortex-M 
//   12  * processor based microcontrollers.  This file can be freely distributed 
//   13  * within development tools that are supporting such ARM based processors. 
//   14  *
//   15  * @par
//   16  * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
//   17  * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
//   18  * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
//   19  * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
//   20  * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
//   21  *
//   22  ******************************************************************************/
//   23 
//   24 #include "stm32f2xx_1208.h"
//   25 
//   26 /* define compiler specific symbols */
//   27 //#define __ASM           __asm                                       /*!< asm keyword for IAR Compiler          */
//   28 //#define __INLINE        inline                                      /*!< inline keyword for IAR Compiler. Only avaiable in High optimization mode! */
//   29 
//   30 
//   31 /* ###################  Compiler specific Intrinsics  ########################### */
//   32 // ICC ARM
//   33 /*!*****************************************************************************
//   34  * @brief  InitSysTick (32 bit)
//   35  * @param  ms  interval value(ms)
//   36  * @return none
//   37  ******************************************************************************/
//   38 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function InitSysTick
        THUMB
//   39 void InitSysTick(u32 ms)
//   40 {
InitSysTick:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//   41   	// Configure HCLK clock as SysTick clock source
//   42  	SysTick->__B.CTRL.CLKSOURCE = __EXTSRC;
        LDR.N    R4,??DataTable0  ;; 0xe000e010
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x4
        STR      R1,[R4, #+0]
//   43   	// SysTick end of count event each 100us with input clock equal to 9MHz (HCLK/8, default)
//   44 	SysTick->LOAD = ((unsigned long long )ms * (SYSCLK))/(8L * 1000L);
        LDR.N    R1,??DataTable0_1  ;; 0x7270e00
        UMULL    R0,R1,R1,R0
        MOV      R2,#+8000
        MOVS     R3,#+0
        BL       __aeabi_uldivmod
        STR      R0,[R4, #+4]
//   45 	SysTick->__B.CTRL.TICKINT = __PENDINT;	// tick interrupt enable
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x2
        STR      R0,[R4, #+0]
//   46 
//   47 	// Enable the SysTick Counter	
//   48 	SysTick->__B.CTRL.ENABLE = ENABLE;	// systick count enable
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R4, #+0]
//   49 }
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0xe000e010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     0x7270e00
//   50 
//   51 /*!*****************************************************************************
//   52 * @brief  SysTickHandler (32 bit)
//   53 * @parma  none
//   54 * @return none
//   55 *******************************************************************************/
//   56 extern void CheckSoftTimer(void);
//   57 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function SysTickIntHandler
        THUMB
//   58 void SysTickIntHandler(void)
//   59 {
//   60 	CheckSoftTimer();
SysTickIntHandler:
        B.W      CheckSoftTimer
        CFI EndBlock cfiBlock1
//   61 }
//   62 
//   63 
//   64 
//   65 ////////////////////////////////////////////////////////////////////////////////
//   66 /* IAR iccarm specific functions */
//   67 #pragma diag_suppress=Pe940
//   68 
//   69 /**
//   70  * @brief  Return the Process Stack Pointer
//   71  *
//   72  * @return ProcessStackPointer
//   73  *
//   74  * Return the actual process stack pointer
//   75  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function __get_PSP
        THUMB
//   76 uint32_t __get_PSP(void)
//   77 {
//   78 	__ASM("mrs r0, psp");
__get_PSP:
        mrs r0, psp      
//   79 	__ASM("bx lr");
        bx lr            
//   80 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//   81 
//   82 /**
//   83  * @brief  Set the Process Stack Pointer
//   84  *
//   85  * @param  topOfProcStack  Process Stack Pointer
//   86  *
//   87  * Assign the value ProcessStackPointer to the MSP 
//   88  * (process stack pointer) Cortex processor register
//   89  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function __set_PSP
        THUMB
//   90 void __set_PSP(uint32_t topOfProcStack)
//   91 {
//   92 	__ASM("msr psp, r0");
__set_PSP:
        msr psp, r0      
//   93 	__ASM("bx lr");
        bx lr            
//   94 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//   95 
//   96 /**
//   97  * @brief  Return the Main Stack Pointer
//   98  *
//   99  * @return Main Stack Pointer
//  100  *
//  101  * Return the current value of the MSP (main stack pointer)
//  102  * Cortex processor register
//  103  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function __get_MSP
        THUMB
//  104 uint32_t __get_MSP(void)
//  105 {
//  106   __ASM("mrs r0, msp");
__get_MSP:
        mrs r0, msp      
//  107   __ASM("bx lr");
        bx lr            
//  108 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  109 
//  110 /*******************************************************************************
//  111  * @brief  Set the Main Stack Pointer
//  112  *
//  113  * @param  topOfMainStack  Main Stack Pointer
//  114  *
//  115  * Assign the value mainStackPointer to the MSP 
//  116  * (main stack pointer) Cortex processor register
//  117  ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function __set_MSP
        THUMB
//  118 void __set_MSP(uint32_t topOfMainStack)
//  119 {
//  120 	__ASM("msr msp, r0");
__set_MSP:
        msr msp, r0      
//  121 	__ASM("bx lr");
        bx lr            
//  122 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  123 
//  124 /**
//  125  * @brief  Reverse byte order in unsigned short value
//  126  *
//  127  * @param  value  value to reverse
//  128  * @return        reversed value
//  129  *
//  130  * Reverse byte order in unsigned short value
//  131  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function __REV16
        THUMB
//  132 uint32_t __REV16(uint16_t value)
//  133 {
//  134   __ASM("rev16 r0, r0");
__REV16:
        rev16 r0, r0     
//  135   __ASM("bx lr");
        bx lr            
//  136 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  137 
//  138 /**
//  139  * @brief  Reverse bit order of value
//  140  *
//  141  * @param  value  value to reverse
//  142  * @return        reversed value
//  143  *
//  144  * Reverse bit order of value
//  145  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function __RBIT
        THUMB
//  146 uint32_t __RBIT(uint32_t value)
//  147 {
//  148   __ASM("rbit r0, r0");
__RBIT:
        rbit r0, r0      
//  149   __ASM("bx lr");
        bx lr            
//  150 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  151 
//  152 /**
//  153  * @brief  LDR Exclusive (8 bit)
//  154  *
//  155  * @param  *addr  address pointer
//  156  * @return        value of (*address)
//  157  *
//  158  * Exclusive LDR command for 8 bit values)
//  159  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function __LDREXB
        THUMB
//  160 uint8_t __LDREXB(uint8_t *addr)
//  161 {
//  162   __ASM("ldrexb r0, [r0]");
__LDREXB:
        ldrexb r0, [r0]  
//  163   __ASM("bx lr"); 
        bx lr            
//  164 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  165 
//  166 /**
//  167  * @brief  LDR Exclusive (16 bit)
//  168  *
//  169  * @param  *addr  address pointer
//  170  * @return        value of (*address)
//  171  *
//  172  * Exclusive LDR command for 16 bit values
//  173  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function __LDREXH
        THUMB
//  174 uint16_t __LDREXH(uint16_t *addr)
//  175 {
//  176   __ASM("ldrexh r0, [r0]");
__LDREXH:
        ldrexh r0, [r0]  
//  177   __ASM("bx lr");
        bx lr            
//  178 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  179 
//  180 /**
//  181  * @brief  LDR Exclusive (32 bit)
//  182  *
//  183  * @param  *addr  address pointer
//  184  * @return        value of (*address)
//  185  *
//  186  * Exclusive LDR command for 32 bit values
//  187  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function __LDREXW
        THUMB
//  188 uint32_t __LDREXW(uint32_t *addr)
//  189 {
//  190   __ASM("ldrex r0, [r0]");
__LDREXW:
        ldrex r0, [r0]   
//  191   __ASM("bx lr");
        bx lr            
//  192 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  193 
//  194 /**
//  195  * @brief  STR Exclusive (8 bit)
//  196  *
//  197  * @param  value  value to store
//  198  * @param  *addr  address pointer
//  199  * @return        successful / failed
//  200  *
//  201  * Exclusive STR command for 8 bit values
//  202  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function __STREXB
        THUMB
//  203 uint32_t __STREXB(uint8_t value, uint8_t *addr)
//  204 {
//  205   __ASM("strexb r0, r0, [r1]");
__STREXB:
        strexb r0, r0, [r1] 
//  206   __ASM("bx lr");
        bx lr            
//  207 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  208 
//  209 /**
//  210  * @brief  STR Exclusive (16 bit)
//  211  *
//  212  * @param  value  value to store
//  213  * @param  *addr  address pointer
//  214  * @return        successful / failed
//  215  *
//  216  * Exclusive STR command for 16 bit values
//  217  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function __STREXH
        THUMB
//  218 uint32_t __STREXH(uint16_t value, uint16_t *addr)
//  219 {
//  220   __ASM("strexh r0, r0, [r1]");
__STREXH:
        strexh r0, r0, [r1] 
//  221   __ASM("bx lr");
        bx lr            
//  222 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  223 
//  224 /**
//  225  * @brief  STR Exclusive (32 bit)
//  226  *
//  227  * @param  value  value to store
//  228  * @param  *addr  address pointer
//  229  * @return        successful / failed
//  230  *
//  231  * Exclusive STR command for 32 bit values
//  232  */

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function __STREXW
        THUMB
//  233 uint32_t __STREXW(uint32_t value, uint32_t *addr)
//  234 {
//  235   __ASM("strex r0, r0, [r1]");
__STREXW:
        strex r0, r0, [r1] 
//  236   __ASM("bx lr");
        bx lr            
//  237 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock13

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  238 
//  239 #pragma diag_default=Pe940
//  240 
//  241 
// 
// 154 bytes in section .text
// 
// 154 bytes of CODE memory
//
//Errors: none
//Warnings: none
