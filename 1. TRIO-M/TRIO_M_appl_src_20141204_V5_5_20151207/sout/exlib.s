///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:41 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\exlib /
//                    .c                                                      /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\exlib /
//                    .c -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_appl_s /
//                    rc_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl_s /
//                    rc_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\sout\ --endian=little --cpu=Cortex-M3 -e     /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\exlib /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME exlib

        EXTERN ExpioSem
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
        PUBLIC atoh

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\exlib.c
//    1 
//    2 /*********************************************
//    3 * File Name          : exlib.c
//    4 * Author             :
//    5 * Date First Issued  : 02/01/2008
//    6 * Description        : This file provides all the port/input/update firmware functions.
//    7 * $Revision: 0.1 $
//    8 * $Revision date: 2008.01.__
//    9 ********************************************************************************/
//   10 
//   11 #define EXLIB_C
//   12 
//   13 #include "../include/main.h"

        SECTION `.rodata`:CONST:NOROOT(2)
// unsigned long const __data ExpioCS[(enum <unnamed>)20U]
ExpioCS:
        DATA
        DC32 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.bss`:DATA:NOROOT(2)
// unsigned short __data EXPIOrawData[(enum <unnamed>)20U]
EXPIOrawData:
        DS8 40
//   14 
//   15 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   16 void ExpioModeChanege(INT8U tmode)
//   17 {
ExpioModeChanege:
        PUSH     {R4,R5}
//   18 #ifdef STM32FRxT6_USED
//   19 	GPIOC->CNF.B6 = tmode;
//   20 	GPIOC->CNF.B7 = tmode;
//   21 	GPIOC->CNF.B8 = tmode;
//   22 	GPIOC->CNF.B9 = tmode;
//   23 	GPIOC->CNF.B10 = tmode;
//   24 	GPIOC->CNF.B11 = tmode;
//   25 	GPIOC->CNF.B12 = tmode;
//   26 	GPIOD->CNF.B2 = tmode;
//   27 #else
//   28 	GPIOD->CNF.B14 = tmode;
        LDR.N    R1,??ExpioModeChanege_0  ;; 0x40011400
        LDR      R2,[R1, #+4]
        BIC      R2,R2,#0xF000000
        LSLS     R3,R0,#+24
        AND      R3,R3,#0xF000000
        ORRS     R2,R3,R2
        STR      R2,[R1, #+4]
//   29 	GPIOD->CNF.B15 = tmode;
        LSLS     R2,R0,#+28
        LDR      R3,[R1, #+4]
        LSLS     R3,R3,#+4
        LSRS     R3,R3,#+4
        ORRS     R3,R2,R3
        STR      R3,[R1, #+4]
//   30 	GPIOD->CNF.B0 = tmode;
        AND      R3,R0,#0xF
        LDR      R4,[R1, #+0]
        MOVS     R5,#+15
        BICS     R4,R4,R5
        ORRS     R4,R3,R4
        STR      R4,[R1, #+0]
//   31 	GPIOD->CNF.B1 = tmode;
        LSLS     R4,R0,#+4
        AND      R4,R4,#0xF0
        LDR      R5,[R1, #+0]
        BIC      R5,R5,#0xF0
        ORRS     R5,R4,R5
        STR      R5,[R1, #+0]
//   32 	GPIOE->CNF.B7 = tmode;
        LDR.N    R1,??ExpioModeChanege_0+0x4  ;; 0x40011800
        LDR      R5,[R1, #+0]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORRS     R2,R2,R5
        STR      R2,[R1, #+0]
//   33 	GPIOE->CNF.B8 = tmode;
        LDR      R2,[R1, #+4]
        MOVS     R5,#+15
        BICS     R2,R2,R5
        ORRS     R2,R3,R2
        STR      R2,[R1, #+4]
//   34 	GPIOE->CNF.B9 = tmode;
        LDR      R2,[R1, #+4]
        BIC      R2,R2,#0xF0
        ORRS     R2,R4,R2
        STR      R2,[R1, #+4]
//   35 	GPIOE->CNF.B10 = tmode;
        LDR      R2,[R1, #+4]
        BIC      R2,R2,#0xF00
        LSLS     R0,R0,#+8
        AND      R0,R0,#0xF00
        ORRS     R0,R0,R2
        STR      R0,[R1, #+4]
//   36 #endif
//   37 }
        POP      {R4,R5}
        BX       LR               ;; return
        Nop      
        DATA
??ExpioModeChanege_0:
        DC32     0x40011400
        DC32     0x40011800
//   38 
//   39 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   40 void ExpioWriteData(INT8U SEL, INT16U Data)
//   41 {
ExpioWriteData:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R6,R0
        MOV      R4,R1
//   42 	INT8U err;
//   43 	
//   44 	OSSemPend(ExpioSem, 0, &err);
        LDR.N    R5,??DataTable2  ;; ExpioSem
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R5, #+0]
        BL       OSSemPend
//   45 	EXPIOrawData[SEL] = Data;
        LDR.N    R0,??DataTable6  ;; EXPIOrawData
        STRH     R4,[R0, R6, LSL #+1]
//   46 
//   47 #ifdef __FSMC_SRAM_H
//   48 		*(vu8 *)(EXPIOptr + SEL*EXPIOsize) = Data;
        LSLS     R0,R6,#+19
        ADD      R0,R0,#+1610612736
        STRB     R4,[R0, #+0]
//   49 #else
//   50 	{
//   51 	
//   52 		INT32U Addr = ExpioCS[SEL]/16;
//   53 		INT32U BitAddr = ExpioCS[SEL]%16;
//   54 
//   55 		ExpioModeChanege(__PC6_OU_PP);
//   56 
//   57 #ifdef STM32FRxT6_USED
//   58 		GPIOC->ODR.B6  = (Data >> 0) & 0x01;
//   59 		GPIOC->ODR.B7  = (Data >> 1) & 0x01;
//   60 		GPIOC->ODR.B8  = (Data >> 2) & 0x01;
//   61 		GPIOC->ODR.B9  = (Data >> 3) & 0x01;
//   62 		GPIOC->ODR.B10 = (Data >> 4) & 0x01;
//   63 		GPIOC->ODR.B11 = (Data >> 5) & 0x01;
//   64 		GPIOC->ODR.B12 = (Data >> 6) & 0x01;
//   65 		GPIOD->ODR.B2  = (Data >> 7) & 0x01;
//   66 #else
//   67 		GPIOD->ODR.B14	= (Data >> 0) & 0x01;
//   68 		GPIOD->ODR.B15	= (Data >> 1) & 0x01;
//   69 		GPIOD->ODR.B0	= (Data >> 2) & 0x01;
//   70 		GPIOD->ODR.B1	= (Data >> 3) & 0x01;
//   71 		GPIOE->ODR.B7	= (Data >> 4) & 0x01;
//   72 		GPIOE->ODR.B8	= (Data >> 5) & 0x01;
//   73 		GPIOE->ODR.B9	= (Data >> 6) & 0x01;
//   74 		GPIOE->ODR.B10	= (Data >> 7) & 0x01;
//   75 #endif
//   76 
//   77 		// low
//   78 		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) &=	~(1 << BitAddr);
//   79 		// high
//   80 		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) |=	 (1 << BitAddr);
//   81 
//   82 		ExpioModeChanege(__PC6_IN_FL);
//   83 	}
//   84 #endif
//   85 	
//   86 	OSSemPost(ExpioSem);
        LDR      R0,[R5, #+0]
        BL       OSSemPost
//   87 
//   88 }
        POP      {R0,R1,R4-R6,PC}  ;; return
//   89 
//   90 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   91 INT16U ExpioReadData(INT8U SEL)
//   92 {
ExpioReadData:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R5,R0
//   93 	INT16U ret = 0;
//   94 	INT8U err;
//   95 	
//   96 	OSSemPend(ExpioSem, 0, &err);
        LDR.N    R4,??DataTable2  ;; ExpioSem
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+0]
        BL       OSSemPend
//   97 
//   98 #ifdef __FSMC_SRAM_H
//   99 		ret = EXPIOrawData[SEL] = *(vu8 *)(EXPIOptr + SEL*EXPIOsize);
        LSLS     R0,R5,#+19
        ADD      R0,R0,#+1610612736
        LDRB     R6,[R0, #+0]
        LDR.N    R0,??DataTable6  ;; EXPIOrawData
        STRH     R6,[R0, R5, LSL #+1]
//  100 #else
//  101 	{
//  102 		INT32U Addr = ExpioCS[SEL]/16;
//  103 		INT32U BitAddr = ExpioCS[SEL]%16;
//  104 
//  105 		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) &=	~(1 << BitAddr);
//  106 		ExpioModeChanege(__PC6_IN_FL);
//  107 
//  108 		// low
//  109 #ifdef STM32FRxT6_USED
//  110 
//  111 		ret = (ret << 1) | (GPIOD->IDR.B2);
//  112 		ret = (ret << 1) | (GPIOC->IDR.B12);
//  113 		ret = (ret << 1) | (GPIOC->IDR.B11);
//  114 		ret = (ret << 1) | (GPIOC->IDR.B10);
//  115 		ret = (ret << 1) | (GPIOC->IDR.B9);
//  116 		ret = (ret << 1) | (GPIOC->IDR.B8);
//  117 		ret = (ret << 1) | (GPIOC->IDR.B7);
//  118 		ret = (ret << 1) | (GPIOC->IDR.B6);
//  119 #else
//  120 		ret = (ret << 1) | (GPIOE->IDR.B10);
//  121 		ret = (ret << 1) | (GPIOE->IDR.B9);
//  122 		ret = (ret << 1) | (GPIOE->IDR.B8);
//  123 		ret = (ret << 1) | (GPIOE->IDR.B7);
//  124 		ret = (ret << 1) | (GPIOD->IDR.B1);
//  125 		ret = (ret << 1) | (GPIOD->IDR.B0);
//  126 		ret = (ret << 1) | (GPIOD->IDR.B15);
//  127 		ret = (ret << 1) | (GPIOD->IDR.B14);
//  128 #endif
//  129 		// SEL
//  130 		// high
//  131 		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) |=	 (1 << BitAddr);
//  132 
//  133 		EXPIOrawData[SEL] = ret;
//  134 	}
//  135 #endif
//  136 	OSSemPost(ExpioSem);
        LDR      R0,[R4, #+0]
        BL       OSSemPost
//  137 
//  138 	return ret;
        MOV      R0,R6
        POP      {R1,R2,R4-R6,PC}  ;; return
//  139 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     ExpioSem
//  140 
//  141 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  142 unsigned short int ExpioBitRead (unsigned short int Bitaddr)
//  143 {
ExpioBitRead:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//  144 	INT16U	ExselNo;
//  145 	INT16U	BitNumber;
//  146 
//  147 	ExselNo = (Bitaddr/16);
        LSRS     R5,R4,#+4
//  148 	BitNumber = (Bitaddr % 16);
//  149 
//  150 	ExpioReadData(ExselNo);
        UXTB     R0,R5
        BL       ExpioReadData
//  151 	return BitRead(EXPIOrawData[ExselNo], BitNumber);	
        MOV      R0,R5
        LDR.N    R1,??DataTable6  ;; EXPIOrawData
        LDRH     R0,[R1, R0, LSL #+1]
        SUB      R1,R4,R5, LSL #+4
        ASRS     R0,R0,R1
        AND      R0,R0,#0x1
        POP      {R1,R4,R5,PC}    ;; return
//  152 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  153 void ExpioBitSet (unsigned short int Bitaddr)
//  154 {
ExpioBitSet:
        PUSH     {R3-R6}
//  155 	INT16U	ExselNo;
//  156 	INT16U	BitNumber;
//  157 
//  158 	ExselNo = (Bitaddr/16);
        LSRS     R1,R0,#+4
        MOV      R2,R1
//  159 	BitNumber = (Bitaddr % 16);
//  160  	EXPIOrawData[ExselNo] = ( EXPIOrawData[ExselNo] |(1 << BitNumber) );
        MOV      R3,R2
        LDR.N    R4,??DataTable6  ;; EXPIOrawData
        LDRH     R5,[R4, R3, LSL #+1]
        MOVS     R6,#+1
        SUB      R0,R0,R1, LSL #+4
        LSL      R0,R6,R0
        ORR      R1,R0,R5
        STRH     R1,[R4, R3, LSL #+1]
//  161 	ExpioWriteData(ExselNo, EXPIOrawData[ExselNo]);
        UXTH     R1,R1
        Nop      
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  162 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        UXTB     R0,R2
        POP      {R2,R4-R6}
        B.N      ExpioWriteData
//  163 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  164 void ExpioBitRst(unsigned short int Bitaddr)
//  165 {
ExpioBitRst:
        PUSH     {R3-R6}
//  166 	INT16U	ExselNo;
//  167 	INT16U	BitNumber;
//  168 
//  169 	ExselNo = (Bitaddr/16);
        LSRS     R1,R0,#+4
        MOV      R2,R1
//  170 	BitNumber = (Bitaddr % 16);
//  171 	EXPIOrawData[ExselNo] = ( EXPIOrawData[ExselNo] & ~(1 << BitNumber) );
        MOV      R3,R2
        LDR.N    R4,??DataTable6  ;; EXPIOrawData
        LDRH     R5,[R4, R3, LSL #+1]
        MOVS     R6,#+1
        SUB      R0,R0,R1, LSL #+4
        LSL      R0,R6,R0
        MVNS     R0,R0
        AND      R1,R0,R5
        STRH     R1,[R4, R3, LSL #+1]
//  172 	ExpioWriteData(ExselNo, EXPIOrawData[ExselNo]);
        B.N      ?Subroutine0
//  173 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     EXPIOrawData
//  174 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  175 INT8U atoh (INT8U value )
//  176 {
//  177 	INT16U	num;
//  178 
//  179 	// isdigit() 는 입력값이 '0' ~ '9' 일경우 True
//  180 	if( isdigit(value) ) num = value - '0';
atoh:
        CMP      R0,#+48
        BLT.N    ??atoh_0
        CMP      R0,#+58
        BGE.N    ??atoh_0
        SUBS     R0,R0,#+48
        B.N      ??atoh_1
//  181 	else if( (value >= 'a') && (value <= 'f') ) num = 10 + value - 'a';
??atoh_0:
        CMP      R0,#+97
        BCC.N    ??atoh_2
        CMP      R0,#+103
        BCS.N    ??atoh_3
        SUBS     R0,R0,#+87
        B.N      ??atoh_1
//  182 	else if( (value >= 'A') && (value <= 'F') ) num = 10 + value - 'A';
??atoh_2:
        CMP      R0,#+65
        BCC.N    ??atoh_3
        CMP      R0,#+71
        BCS.N    ??atoh_3
        SUBS     R0,R0,#+55
        B.N      ??atoh_1
//  183 	else										num = 0x0100;
??atoh_3:
        MOV      R0,#+256
//  184 
//  185 	return (INT8U)num;
??atoh_1:
        UXTB     R0,R0
        BX       LR               ;; return
//  186 }
//  187 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  188 INT16U ByteToWord(INT8U HighByte, INT8U LowByte)
//  189 {
//  190 	INT16U WordByte = 0;
//  191 	
//  192 	WordByte = (INT16U)HighByte;
//  193 	WordByte = (WordByte << 8)& 0xff00;
//  194 	WordByte = WordByte |(INT16U)LowByte;
//  195 	return(WordByte);
ByteToWord:
        ORR      R0,R1,R0, LSL #+8
        BX       LR               ;; return
//  196 }

        END
//  197 
//  198 ///////////////////////////////////////////////////////////////////////////////
//  199 // End of Source File
//  200 ////////////////////////
//  201 
// 
//  40 bytes in section .bss
//  80 bytes in section .rodata
// 376 bytes in section .text
// 
// 376 bytes of CODE  memory
//  80 bytes of CONST memory
//  40 bytes of DATA  memory
//
//Errors: none
//Warnings: none
