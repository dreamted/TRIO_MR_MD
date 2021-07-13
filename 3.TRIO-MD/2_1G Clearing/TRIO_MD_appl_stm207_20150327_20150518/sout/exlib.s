///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    30/Aug/2012  21:29:29 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\exlib.c      /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\exlib.c -D   /
//                    OS_INCLUDED -D APPL_SRC -lcN                            /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -lB         /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -o          /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\             /
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
//                    -Oh --use_c++_inline --require_prototypes               /
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\exlib.s      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME exlib

        #define SHT_PROGBITS 0x1

        EXTERN ExpioSem
        EXTERN GPIOPortInit
        EXTERN OSSemPend
        EXTERN OSSemPost

        PUBLIC ByteToWord
        PUBLIC EXPIOrawData
        PUBLIC ExpioBitRead
        PUBLIC ExpioBitRst
        PUBLIC ExpioBitSet
        PUBLIC ExpioCS
        PUBLIC ExpioModeChanege
        PUBLIC ExpioReadData
        PUBLIC ExpioWriteData
        PUBLIC SearchWord

// D:\Work\Project\2012\NL_INBUILD\FW\MU\code\exlib.c
//    1 
//    2 /******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
//    3 * File Name          : exlib.c
//    4 * Author             : Yoon Byong-Gyu(bgyoon@naver.com)
//    5 * Date First Issued  : 02/01/2008
//    6 * Description        : This file provides all the port/input/update firmware functions.
//    7 * $Revision: 0.1 $
//    8 * $Revision date: 2008.01.__
//    9 ********************************************************************************/
//   10 
//   11 #define EXLIB_C
//   12 
//   13 #include "../include/main.h"

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute unsigned short EXPIOrawData[(enum <unnamed>)20U]
EXPIOrawData:
        DS8 40
//   14 
//   15 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   16 void ExpioModeChanege(INT8U tmode)
//   17 {
ExpioModeChanege:
        PUSH     {R3-R5,LR}
//   18 	if(tmode == 0)
        LDR.N    R4,??DataTable5  ;; 0x40021000
        LDR.N    R5,??DataTable5_1  ;; 0x40020c00
        CBNZ.N   R0,??ExpioModeChanege_0
//   19 	{
//   20 		__PD14_PP_PP();
        MOVS     R3,#+14
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   21 		__PD15_PP_PP();
        MOVS     R3,#+15
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   22 		__PD0_PP_PP();
        MOVS     R3,#+0
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   23 		__PD1_PP_PP();
        MOVS     R3,#+1
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   24 		__PE7_PP_PP();
        MOVS     R3,#+7
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   25 		__PE8_PP_PP();
        MOVS     R3,#+8
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   26 		__PE9_PP_PP();
        MOVS     R3,#+9
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   27 		__PE10_PP_PP();
        MOVS     R3,#+10
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        B.N      ??ExpioModeChanege_1
//   28 	}
//   29 	else
//   30 	{
//   31 		__PD14_IN_FL();
??ExpioModeChanege_0:
        MOVS     R3,#+14
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       GPIOPortInit
//   32 		__PD15_IN_FL();
        MOVS     R3,#+15
        MOV      R2,R5
        MOVS     R1,#+0
        MOV      R0,R1
        BL       GPIOPortInit
//   33 		__PD0_IN_FL();
        MOVS     R3,#+0
        MOV      R2,R5
        MOV      R1,R3
        MOV      R0,R1
        BL       GPIOPortInit
//   34 		__PD1_IN_FL();
        MOVS     R3,#+1
        MOV      R2,R5
        MOVS     R1,#+0
        MOV      R0,R1
        BL       GPIOPortInit
//   35 		__PE7_IN_FL();
        MOVS     R3,#+7
        MOV      R2,R4
        MOVS     R1,#+0
        MOV      R0,R1
        BL       GPIOPortInit
//   36 		__PE8_IN_FL();
        MOVS     R3,#+8
        MOV      R2,R4
        MOVS     R1,#+0
        MOV      R0,R1
        BL       GPIOPortInit
//   37 		__PE9_IN_FL();
        MOVS     R3,#+9
        MOV      R2,R4
        MOVS     R1,#+0
        MOV      R0,R1
        BL       GPIOPortInit
//   38 		__PE10_IN_FL();
        MOVS     R3,#+10
        MOV      R2,R4
        MOVS     R1,#+0
        MOV      R0,R1
??ExpioModeChanege_1:
        ADD      SP,SP,#+4
        POP      {R4,R5,LR}
        B.W      GPIOPortInit
//   39 	}
//   40 /*
//   41 #ifdef STM32FRxT6_USED
//   42 	GPIOC->CNF.B6 = tmode;
//   43 	GPIOC->CNF.B7 = tmode;
//   44 	GPIOC->CNF.B8 = tmode;
//   45 	GPIOC->CNF.B9 = tmode;
//   46 	GPIOC->CNF.B10 = tmode;
//   47 	GPIOC->CNF.B11 = tmode;
//   48 	GPIOC->CNF.B12 = tmode;
//   49 	GPIOD->CNF.B2 = tmode;
//   50 #else
//   51 	GPIOD->CNF.B14 = tmode;
//   52 	GPIOD->CNF.B15 = tmode;
//   53 	GPIOD->CNF.B0 = tmode;
//   54 	GPIOD->CNF.B1 = tmode;
//   55 	GPIOE->CNF.B7 = tmode;
//   56 	GPIOE->CNF.B8 = tmode;
//   57 	GPIOE->CNF.B9 = tmode;
//   58 	GPIOE->CNF.B10 = tmode;
//   59 #endif
//   60 */
//   61 }
//   62 
//   63 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   64 void ExpioWriteData(INT8U SEL, INT16U Data)
//   65 {
ExpioWriteData:
        PUSH     {R3-R7,LR}
        MOV      R6,R0
        MOV      R5,R1
//   66 	INT8U err;
//   67 	
//   68  	OSSemPend(ExpioSem, 0, &err);
        LDR.N    R4,??DataTable5_2
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+0]
        BL       OSSemPend
//   69 	EXPIOrawData[SEL] = Data;
        LDR.N    R0,??DataTable5_3
        STRH     R5,[R0, R6, LSL #+1]
        ADR.W    R0,ExpioCS
        LDR      R0,[R0, R6, LSL #+2]
        LSRS     R6,R0,#+4
//   70 
//   71 	#ifdef __FSMC_SRAM_H
//   72 		*(vu8 *)(EXPIOptr + SEL*EXPIOsize) = Data;
//   73 	#else
//   74 	{
//   75 	
//   76 		INT32U Addr = ExpioCS[SEL]/16;
//   77 		INT32U BitAddr = ExpioCS[SEL]%16;
        AND      R7,R0,#0xF
//   78 
//   79 		ExpioModeChanege(0);
        MOVS     R0,#+0
        BL       ExpioModeChanege
//   80 
//   81 #ifdef STM32FRxT6_USED
//   82 		GPIOC->ODR.B6  = (Data >> 0) & 0x01;
//   83 		GPIOC->ODR.B7  = (Data >> 1) & 0x01;
//   84 		GPIOC->ODR.B8  = (Data >> 2) & 0x01;
//   85 		GPIOC->ODR.B9  = (Data >> 3) & 0x01;
//   86 		GPIOC->ODR.B10 = (Data >> 4) & 0x01;
//   87 		GPIOC->ODR.B11 = (Data >> 5) & 0x01;
//   88 		GPIOC->ODR.B12 = (Data >> 6) & 0x01;
//   89 		GPIOD->ODR.B2  = (Data >> 7) & 0x01;
//   90 #else
//   91 		GPIOD->__B.ODR.B14	= (Data >> 0) & 0x01;
        LDR.N    R0,??DataTable5_4  ;; 0x40020c14
        LDR      R1,[R0, #+0]
        BFI      R1,R5,#+14,#+1
        STR      R1,[R0, #+0]
//   92 		GPIOD->__B.ODR.B15	= (Data >> 1) & 0x01;
        LSLS     R1,R5,#+24
        LSRS     R1,R1,#+25
        LDR      R2,[R0, #+0]
        BFI      R2,R1,#+15,#+1
        STR      R2,[R0, #+0]
//   93 		GPIOD->__B.ODR.B0	= (Data >> 2) & 0x01;
        LSLS     R1,R5,#+24
        LSRS     R1,R1,#+26
        LDR      R2,[R0, #+0]
        BFI      R2,R1,#+0,#+1
        STR      R2,[R0, #+0]
//   94 		GPIOD->__B.ODR.B1	= (Data >> 3) & 0x01;
        LSLS     R1,R5,#+24
        LSRS     R1,R1,#+27
        LDR      R2,[R0, #+0]
        BFI      R2,R1,#+1,#+1
        STR      R2,[R0, #+0]
//   95 		GPIOE->__B.ODR.B7	= (Data >> 4) & 0x01;
        LDR.N    R0,??DataTable5_5  ;; 0x40021014
        LSLS     R1,R5,#+24
        LSRS     R1,R1,#+28
        LDR      R2,[R0, #+0]
        BFI      R2,R1,#+7,#+1
        STR      R2,[R0, #+0]
//   96 		GPIOE->__B.ODR.B8	= (Data >> 5) & 0x01;
        LSLS     R1,R5,#+24
        LSRS     R1,R1,#+29
        LDR      R2,[R0, #+0]
        BFI      R2,R1,#+8,#+1
        STR      R2,[R0, #+0]
//   97 		GPIOE->__B.ODR.B9	= (Data >> 6) & 0x01;
        LSLS     R1,R5,#+24
        LSRS     R1,R1,#+30
        LDR      R2,[R0, #+0]
        BFI      R2,R1,#+9,#+1
        STR      R2,[R0, #+0]
//   98 		GPIOE->__B.ODR.B10	= (Data >> 7) & 0x01;
        LSLS     R5,R5,#+24
        LSRS     R1,R5,#+31
        LDR      R2,[R0, #+0]
        BFI      R2,R1,#+10,#+1
        STR      R2,[R0, #+0]
//   99 #endif
//  100 
//  101 		// low
//  102 		*(volatile INT32U *)(AHB1PERIPH_BASE + Addr + 0x0C) &=  ~(1 << BitAddr);
        MOVS     R0,#+1
        LSLS     R0,R0,R7
        LDR.N    R1,??DataTable5_6  ;; 0x4002000c
        LDR      R2,[R1, R6]
        BICS     R2,R2,R0
        STR      R2,[R1, R6]
//  103 		// high
//  104 		*(volatile INT32U *)(AHB1PERIPH_BASE + Addr + 0x0C) |=   (1 << BitAddr);
        LDR      R2,[R1, R6]
        ORRS     R0,R0,R2
        STR      R0,[R1, R6]
//  105 
//  106 		ExpioModeChanege(1);
        MOVS     R0,#+1
        BL       ExpioModeChanege
//  107 	}
//  108 	#endif
//  109 	
//  110 	OSSemPost(ExpioSem);
        LDR      R0,[R4, #+0]
        BL       OSSemPost
//  111 
//  112 }
        POP      {R0,R4-R7,PC}    ;; return
//  113 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  114 INT16U ExpioReadData(INT8U SEL)
//  115 {
ExpioReadData:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R8,R0
//  116 	INT16U ret = 0;
//  117 	INT8U err;
//  118 	
//  119  	OSSemPend(ExpioSem, 0, &err);
        LDR.N    R4,??DataTable5_2
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+0]
        BL       OSSemPend
//  120 
//  121 	#ifdef __FSMC_SRAM_H
//  122 		ret = EXPIOrawData[SEL] = *(vu8 *)(EXPIOptr + SEL*EXPIOsize);
//  123 	#else
//  124 	{
//  125 		INT32U Addr = ExpioCS[SEL]/16;
        ADR.W    R0,ExpioCS
        LDR      R0,[R0, R8, LSL #+2]
        LSRS     R1,R0,#+4
//  126 		INT32U BitAddr = ExpioCS[SEL]%16;
        AND      R0,R0,#0xF
//  127 
//  128 		*(volatile INT32U *)(AHB1PERIPH_BASE + Addr + 0x0C) &=  ~(1 << BitAddr);
        MOVS     R2,#+1
        LSL      R6,R2,R0
        LDR.N    R0,??DataTable5_6  ;; 0x4002000c
        ADDS     R7,R0,R1
        LDR      R0,[R7, #+0]
        BICS     R0,R0,R6
        STR      R0,[R7, #+0]
//  129 		ExpioModeChanege(1);
        MOVS     R0,#+1
        BL       ExpioModeChanege
//  130 
//  131 		// low
//  132 #ifdef STM32FRxT6_USED
//  133 
//  134 		ret = (ret << 1) | (GPIOD->IDR.B2);
//  135 		ret = (ret << 1) | (GPIOC->IDR.B12);
//  136 		ret = (ret << 1) | (GPIOC->IDR.B11);
//  137 		ret = (ret << 1) | (GPIOC->IDR.B10);
//  138 		ret = (ret << 1) | (GPIOC->IDR.B9);
//  139 		ret = (ret << 1) | (GPIOC->IDR.B8);
//  140 		ret = (ret << 1) | (GPIOC->IDR.B7);
//  141 		ret = (ret << 1) | (GPIOC->IDR.B6);
//  142 #else
//  143 		ret = (ret << 1) | (GPIOE->__B.IDR.B10);
        LDR.N    R0,??DataTable5_7  ;; 0x40021010
        LDR      R1,[R0, #+0]
        UBFX     R1,R1,#+10,#+1
//  144 		ret = (ret << 1) | (GPIOE->__B.IDR.B9);
        LDR      R2,[R0, #+0]
        UBFX     R2,R2,#+9,#+1
        ORR      R1,R2,R1, LSL #+1
//  145 		ret = (ret << 1) | (GPIOE->__B.IDR.B8);
        LDR      R2,[R0, #+0]
        UBFX     R2,R2,#+8,#+1
        ORR      R1,R2,R1, LSL #+1
//  146 		ret = (ret << 1) | (GPIOE->__B.IDR.B7);
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+7,#+1
        ORR      R0,R0,R1, LSL #+1
//  147 		ret = (ret << 1) | (GPIOD->__B.IDR.B1);
        LDR.N    R1,??DataTable5_8  ;; 0x40020c10
        LDR      R2,[R1, #+0]
        UBFX     R2,R2,#+1,#+1
        ORR      R0,R2,R0, LSL #+1
//  148 		ret = (ret << 1) | (GPIOD->__B.IDR.B0);
        LDR      R2,[R1, #+0]
        LSRS     R2,R2,#+1
        ADCS     R0,R0,R0
        UXTH     R0,R0
//  149 		ret = (ret << 1) | (GPIOD->__B.IDR.B15);
        LDR      R2,[R1, #+0]
        UBFX     R2,R2,#+15,#+1
        ORR      R0,R2,R0, LSL #+1
        UXTH     R0,R0
//  150 		ret = (ret << 1) | (GPIOD->__B.IDR.B14);
        LDR      R1,[R1, #+0]
        UBFX     R1,R1,#+14,#+1
        ORR      R0,R1,R0, LSL #+1
        UXTH     R5,R0
//  151 #endif
//  152 		// SEL
//  153 		// high
//  154 		*(volatile INT32U *)(AHB1PERIPH_BASE + Addr + 0x0C) |=   (1 << BitAddr);
        LDR      R0,[R7, #+0]
        ORRS     R0,R6,R0
        STR      R0,[R7, #+0]
//  155 
//  156 		EXPIOrawData[SEL] = ret;
        LDR.N    R0,??DataTable5_3
        STRH     R5,[R0, R8, LSL #+1]
//  157 	}
//  158 	#endif
//  159 	OSSemPost(ExpioSem);
        LDR      R0,[R4, #+0]
        BL       OSSemPost
//  160 
//  161     return ret;
        MOV      R0,R5
        POP      {R1,R2,R4-R8,PC}  ;; return
//  162 }
//  163 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  164 unsigned short int ExpioBitRead (unsigned short int Bitaddr)
//  165 {
ExpioBitRead:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//  166 	INT16U	ExselNo;
//  167 	INT16U	BitNumber;
//  168 
//  169 	ExselNo = (Bitaddr/16);
        LSRS     R5,R4,#+4
//  170 	BitNumber = (Bitaddr % 16);
//  171 
//  172 	ExpioReadData(ExselNo);
        UXTB     R0,R5
        BL       ExpioReadData
//  173 	return BitRead(EXPIOrawData[ExselNo], BitNumber);	
        LDR.N    R0,??DataTable5_3
        LDRH     R0,[R0, R5, LSL #+1]
        AND      R1,R4,#0xF
        LSRS     R0,R0,R1
        AND      R0,R0,#0x1
        POP      {R1,R4,R5,PC}    ;; return
//  174 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  175 void ExpioBitSet (unsigned short int Bitaddr)
//  176 {
ExpioBitSet:
        PUSH     {R3,R4}
//  177 	INT16U	ExselNo;
//  178 	INT16U	BitNumber;
//  179 
//  180 	ExselNo = (Bitaddr/16);
        LSRS     R2,R0,#+4
//  181 	BitNumber = (Bitaddr % 16);
//  182  	EXPIOrawData[ExselNo] = ( EXPIOrawData[ExselNo] |(1 << BitNumber) );
        LDR.N    R3,??DataTable5_3
        LDRH     R1,[R3, R2, LSL #+1]
        MOVS     R4,#+1
        AND      R0,R0,#0xF
        LSL      R0,R4,R0
        ORRS     R1,R0,R1
        STRH     R1,[R3, R2, LSL #+1]
//  183 	ExpioWriteData(ExselNo, EXPIOrawData[ExselNo]);
        UXTH     R1,R1
        B.N      ?Subroutine0
//  184 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     0x40020c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     ExpioSem

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     EXPIOrawData

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     0x40020c14

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     0x40021014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     0x4002000c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0x40021010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     0x40020c10
//  185 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  186 void ExpioBitRst(unsigned short int Bitaddr)
//  187 {
ExpioBitRst:
        PUSH     {R3,R4}
//  188 	INT16U	ExselNo;
//  189 	INT16U	BitNumber;
//  190 
//  191 	ExselNo = (Bitaddr/16);
        LSRS     R2,R0,#+4
//  192 	BitNumber = (Bitaddr % 16);
//  193 	EXPIOrawData[ExselNo] = ( EXPIOrawData[ExselNo] & ~(1 << BitNumber) );
        LDR.N    R3,??ExpioBitRst_0
        B.N      ??ExpioBitRst_1
        DATA
??ExpioBitRst_0:
        DC32     EXPIOrawData
        THUMB
??ExpioBitRst_1:
        LDRH     R1,[R3, R2, LSL #+1]
        MOVS     R4,#+1
        AND      R0,R0,#0xF
        LSL      R0,R4,R0
        BICS     R1,R1,R0
        STRH     R1,[R3, R2, LSL #+1]
//  194 	ExpioWriteData(ExselNo, EXPIOrawData[ExselNo]);
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  195 	
//  196 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        UXTB     R0,R2
        POP      {R2,R4}
        B.N      ExpioWriteData
//  197 /*
//  198 INT8U atoh (INT8U value )
//  199 {
//  200 	INT16U	num;
//  201 
//  202 	// isdigit() 는 입력값이 '0' ~ '9' 일경우 True
//  203 	if( isdigit(value) ) num = value - '0';
//  204 	else if( (value >= 'a') && (value <= 'f') ) num = 10 + value - 'a';
//  205 	else if( (value >= 'A') && (value <= 'F') ) num = 10 + value - 'A';
//  206 	else										num = 0x0100;
//  207 
//  208 	return (INT8U)num;
//  209 }
//  210 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  211 INT16U ByteToWord(INT8U HighByte, INT8U LowByte)
//  212 {
//  213 	INT16U WordByte = 0;
//  214 	
//  215 	WordByte = (INT16U)HighByte;
//  216 	WordByte = (WordByte << 8)& 0xff00;
//  217 	WordByte = WordByte |(INT16U)LowByte;
//  218 	return(WordByte);
ByteToWord:
        ORR      R0,R1,R0, LSL #+8
        BX       LR               ;; return
//  219 }
//  220 
//  221 /*******************************************************************************
//  222 * Table에서 Search한다.
//  223 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 INT8U SearchWord(INT8U IsDec,INT8U nLen, INT16U SearchVal, INT16U *Buff)
//  225 {
SearchWord:
        PUSH     {R4-R7}
        MOV      R4,R0
        SUBS     R0,R1,#+1
        UXTB     R0,R0
        MOVW     R5,#+4095
        CBZ.N    R4,??SearchWord_0
//  226     unsigned char Max = nLen - 1 ,Mid , Min = 0;
//  227 
//  228 	if(IsDec)///1
//  229 	{ /* 정렬이 내림 차순으로 된경우.  RSSI */
//  230 		Max = nLen-1;
//  231 		Min = 0;
        MOVS     R1,#+0
//  232 	    if((Buff[Max] & 0x0FFF) >= SearchVal)    return(Max);
        LDRH     R4,[R3, R0, LSL #+1]
        ANDS     R4,R5,R4
        CMP      R4,R2
        BLT.N    ??SearchWord_1
??SearchWord_2:
        POP      {R4-R7}
        BX       LR               ;; return
//  233 	    if((Buff[Min] & 0x0FFF) <= SearchVal)    return(Min);
??SearchWord_1:
        LDRH     R4,[R3, #+0]
        ANDS     R4,R5,R4
        CMP      R2,R4
        BLT.N    ??SearchWord_3
??SearchWord_4:
        MOVS     R0,#+0
        B.N      ??SearchWord_2
//  234 
//  235 	    while(1)
//  236 		{
//  237 		    if((Min+1) == Max)
??SearchWord_3:
        ADDS     R4,R1,#+1
        CMP      R4,R0
        BNE.N    ??SearchWord_5
//  238 			{
//  239 			    if((Buff[Min] & 0x0FFF)- SearchVal > SearchVal - (Buff[Max] & 0x0FFF))return(Max);
        LDRH     R4,[R3, R0, LSL #+1]
        ANDS     R4,R5,R4
        SUBS     R4,R2,R4
        LDRH     R3,[R3, R1, LSL #+1]
        ANDS     R3,R5,R3
        SUBS     R2,R3,R2
??SearchWord_6:
        CMP      R4,R2
        BLT.N    ??SearchWord_2
//  240 				else return(Min);
        MOV      R0,R1
        B.N      ??SearchWord_2
//  241 			}
//  242 
//  243 			Mid = Min + (Max - Min)/2;
??SearchWord_5:
        SUBS     R4,R0,R1
        ADD      R4,R4,R4, LSR #+31
        ADDS     R4,R1,R4, ASR #+1
//  244 			if((Buff[Mid] & 0x0FFF) == SearchVal)  	return(Mid);
        UXTB     R4,R4
        MOV      R6,R4
        LDRH     R7,[R3, R6, LSL #+1]
        ANDS     R7,R5,R7
        CMP      R7,R2
        BNE.N    ??SearchWord_7
??SearchWord_8:
        MOV      R0,R4
        B.N      ??SearchWord_2
//  245 			else if((Buff[Mid] & 0x0FFF) > SearchVal) 	Min = Mid;
??SearchWord_7:
        LDRH     R6,[R3, R6, LSL #+1]
        ANDS     R6,R5,R6
        CMP      R2,R6
        ITE      GE 
        MOVGE    R0,R4
        MOVLT    R1,R4
//  246 			else										Max = Mid;
        B.N      ??SearchWord_3
//  247 		}
//  248 	}
//  249 	else
//  250 	{      /* 정렬이 오름 차순으로 된 경우. PM */
//  251 
//  252 		Max = nLen - 1;
//  253 		Min = 0;
??SearchWord_0:
        MOVS     R1,#+0
//  254 
//  255 	    if((Buff[Max] & 0x0FFF) <= SearchVal)	return(Max);
        LDRH     R4,[R3, R0, LSL #+1]
        ANDS     R4,R5,R4
        CMP      R2,R4
        BGE.N    ??SearchWord_2
//  256 	    if((Buff[Min] & 0x0FFF) >= SearchVal)   return(Min);
        LDRH     R4,[R3, #+0]
        ANDS     R4,R5,R4
        CMP      R4,R2
        BGE.N    ??SearchWord_4
//  257 
//  258 	    while(1)
//  259 		{
//  260 		    if((Min + 1) == Max)
??SearchWord_9:
        ADDS     R4,R1,#+1
        CMP      R4,R0
        BNE.N    ??SearchWord_10
//  261 			{
//  262 			    if((Buff[Min] & 0x0FFF) - SearchVal < SearchVal - (Buff[Max] & 0x0FFF))	return(Max);
        LDRH     R4,[R3, R1, LSL #+1]
        ANDS     R4,R5,R4
        SUBS     R4,R4,R2
        LDRH     R3,[R3, R0, LSL #+1]
        ANDS     R3,R5,R3
        SUBS     R2,R2,R3
        B.N      ??SearchWord_6
//  263 				else																	return(Min);
//  264 			}
//  265 
//  266 			Mid = Min + (Max - Min)/2;
??SearchWord_10:
        SUBS     R4,R0,R1
        ADD      R4,R4,R4, LSR #+31
        ADDS     R4,R1,R4, ASR #+1
//  267 			     if((Buff[Mid] & 0x0FFF) == SearchVal)	return(Mid);
        UXTB     R4,R4
        MOV      R6,R4
        LDRH     R7,[R3, R6, LSL #+1]
        ANDS     R7,R5,R7
        CMP      R7,R2
        BEQ.N    ??SearchWord_8
//  268 			else if((Buff[Mid] & 0x0FFF) < SearchVal) 	Min = Mid;
        LDRH     R6,[R3, R6, LSL #+1]
        ANDS     R6,R5,R6
        CMP      R6,R2
        ITE      GE 
        MOVGE    R0,R4
        MOVLT    R1,R4
//  269 			else										Max = Mid;
        B.N      ??SearchWord_9
//  270 		}
//  271 	}
//  272 
//  273 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
// __absolute unsigned long const ExpioCS[(enum <unnamed>)20U]
ExpioCS:
        DC32 32774, 65546, 16393, 16396, 16397, 16398, 16399, 32782, 32783, 11
        DC32 12, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  274 
//  275 ///////////////////////////////////////////////////////////////////////////////
//  276 // End of Source File
//  277 ////////////////////////
//  278 
// 
//  40 bytes in section .bss
// 958 bytes in section .text
// 
// 958 bytes of CODE memory
//  40 bytes of DATA memory
//
//Errors: none
//Warnings: none
