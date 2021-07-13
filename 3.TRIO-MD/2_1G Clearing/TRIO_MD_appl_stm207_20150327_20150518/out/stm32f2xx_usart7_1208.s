///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:00 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart7_1208.c                         /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart7_1208.c -D OS_INCLUDED -D       /
//                    APPL_SRC -lA D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ /
//                     -o D:\Work\Project\2012\NL_INBUILD\FW\MU\out\          /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_usa /
//                    rt7_1208.s                                              /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_usart7_1208

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        RTMODEL "__iar_require _Printf", "unknown"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN OSSemCreate
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OSTimeDly
        EXTERN vsprintf

        PUBLIC Rx7Buff
        PUBLIC Rx7RdCnt
        PUBLIC Rx7WrCnt
        PUBLIC Tx7Buff
        PUBLIC Tx7RdCnt
        PUBLIC Tx7WrCnt
        PUBLIC UART7_base
        PUBLIC USART7BuffClear
        PUBLIC USART7CheckByte
        PUBLIC USART7Handler
        PUBLIC USART7Init
        PUBLIC USART7Printf
        PUBLIC USART7PutChar
        PUBLIC USART7PutStr
        PUBLIC USART7PutToBuffer
        PUBLIC USART7RxGetByte
        PUBLIC USART7TxCheckByte
        PUBLIC USART7TxClear
        PUBLIC USART7TxGetByte
        PUBLIC pUSART7
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_usart7_1208.c
//    1 /*******************************************************************************
//    2  *
//    3  * This module contains the function `7092 original header file, a function
//    4  * whole things  initializations - global, include function and so on
//    5  *
//    6  *
//    7  * Note that this function is called before the data segments are
//    8  * initialized, this means that this function cannot rely on the
//    9  * values of global or static variables.
//   10  *
//   11  *
//   12  * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
//   13  *
//   14  * $Revision: 0.1 $
//   15  * $Revision date: 2007.04.__
//   16  * $Revision: 0.2 $
//   17  * $Revision date: 2007.10.__
//   18  *               : to check insert read register -> return value
//   19  * $Revision: 0.3 $
//   20  * $Revision date: 2008.03.07
//   21  *               : Ser5PutStrOpt Append
//   22  ******************************************************************************/
//   23 
//   24 
//   25 #include "stm32f2xx_usart7_1208.h"

        SECTION iram:DATA:REORDER:NOROOT(2)
//   26 
//   27 #if !defined (OS_INCLUDED) 
//   28 	INT8U Rx7Buff[Rx7BuffLen];
//   29 	INT8U Tx7Buff[Tx7BuffLen];
//   30 
//   31 	INT16U	Rx7RdCnt = 0, Rx7WrCnt = 0;
//   32 	INT16U	Tx7RdCnt = 0, Tx7WrCnt = 0;
//   33 #else
//   34 	INT8U Rx7Buff[Rx7BuffLen] @ "iram";
//   35 	INT8U Tx7Buff[Tx7BuffLen] @ "iram";
//   36 
//   37 	INT16U	Rx7RdCnt @ "iram"= 0, Rx7WrCnt @ "iram" = 0;
Rx7RdCnt:
        DATA
        DC16 0
Rx7WrCnt:
        DC16 0
//   38 	INT16U	Tx7RdCnt @ "iram"= 0, Tx7WrCnt @ "iram" = 0;
Tx7RdCnt:
        DC16 0
Tx7WrCnt:
        DC16 0
//   39 #endif
//   40 
//   41 #if !defined (OS_INCLUDED) 
//   42 __SerStrPtr pUSART7 = {
//   43 
//   44 #else
//   45 __SerStrPtr pUSART7 @ "iram" = {
pUSART7:
        DC32 0H, USART7CheckByte, USART7RxGetByte, USART7PutStr, USART7Printf
        DC32 USART7PutChar, USART7PutToBuffer, USART7TxCheckByte
        DC32 USART7BuffClear, USART7TxClear
        DC8 0, 0, 0, 0
// __absolute unsigned long UART7_base
UART7_base:
        DC32 0

        SECTION iram:DATA:REORDER:NOROOT(2)
Rx7Buff:
        DS8 2048

        SECTION iram:DATA:REORDER:NOROOT(2)
Tx7Buff:
        DS8 2048
//   46 #endif
//   47 	NULL,
//   48 	USART7CheckByte,
//   49 	USART7RxGetByte,
//   50 	USART7PutStr,
//   51 	USART7Printf,
//   52 	USART7PutChar,
//   53 	USART7PutToBuffer,
//   54 	USART7TxCheckByte,
//   55 	USART7BuffClear,
//   56 	USART7TxClear
//   57 };
//   58 
//   59 unsigned long int USART1Printf( const char *format, ...);
//   60 unsigned char USART1PutChar(unsigned char Data);
//   61 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function USART7Init
        THUMB
//   62 unsigned char USART7Init(unsigned long int nBps, unsigned char _LCR, unsigned long int bAddr)
//   63 {
USART7Init:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
//   64 	INT8U ch = 0;
//   65 	INT8U rval = TRUE;
        MOVS     R4,#+1
//   66     // CLK: 49.7664 Mhz
//   67 	UART7_base = bAddr;
        LDR.N    R5,??DataTable8
        STR      R2,[R5, #+52]
//   68 
//   69 	U7LCR = 0x80;			// Baud rate select mode
        ADD      R2,R2,#+196608
        MOVS     R3,#+128
        STRB     R3,[R2, #+0]
//   70 	U7DLL = ch = (INT8U)(UART_CLOCK/(16L*nBps));
        LDR.N    R2,??DataTable8_1  ;; 0x7a1200
        LSLS     R0,R0,#+4
        UDIV     R0,R2,R0
        LDR      R2,[R5, #+52]
        STRB     R0,[R2, #+0]
//   71 	
//   72 //	USART1Printf("U7LCR: %02x \n", U7LCR);
//   73 //	USART1Printf("U7DLL: %02x \n", U7DLL);
//   74 
//   75 	if(U7DLL != ch) rval = FALSE;
        LDR      R0,[R5, #+52]
//   76 	U7DLM = 0x00;			//
        ADD      R0,R0,#+65536
        MOVS     R2,#+0
        STRB     R2,[R0, #+0]
//   77 	U7LCR = _LCR;			// Normal mode register
        LDR      R0,[R5, #+52]
        ADD      R0,R0,#+196608
        STRB     R1,[R0, #+0]
//   78 	if(U7LCR != _LCR) rval = FALSE;
        LDR      R0,[R5, #+52]
        ADD      R2,R0,#+196608
        LDRB     R2,[R2, #+0]
        CMP      R2,R1
        IT       NE 
        MOVNE    R4,#+0
//   79 	U7MCR = 0x0B;			// Here, Reserved
        ADD      R0,R0,#+262144
        MOVS     R1,#+11
        STRB     R1,[R0, #+0]
//   80 	U7FCR = 0x07;			// Reset FIFO, Tx Fifo Reset, Rx Fifo Reset
        LDR      R0,[R5, #+52]
        ADD      R0,R0,#+131072
        MOVS     R1,#+7
        STRB     R1,[R0, #+0]
//   81 	U7FCR = 0x01;			// Fifo
        LDR      R0,[R5, #+52]
        ADD      R0,R0,#+131072
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//   82 
//   83 	U7IER = 0x05;			// Rx Interrupt Enable
        LDR      R0,[R5, #+52]
        ADD      R0,R0,#+65536
        MOVS     R1,#+5
        STRB     R1,[R0, #+0]
//   84 //	USART1Printf("U7IER: %02x \n", U7IER);
//   85 
//   86 	ch = U7MSR;
//   87 	ch = ch | 0x20 ;
//   88 	U7MSR = ch;
        LDR      R0,[R5, #+52]
        ADD      R0,R0,#+393216
        LDRB     R1,[R0, #+0]
        ORR      R1,R1,#0x20
        STRB     R1,[R0, #+0]
//   89 	ch = U7MCR;
//   90 	ch = ch | 0x01 ;		// DTR 1 set
        LDR      R0,[R5, #+52]
        ADD      R0,R0,#+262144
        LDRB     R1,[R0, #+0]
        ORR      R1,R1,#0x1
//   91 	U7MCR = ch;
        STRB     R1,[R0, #+0]
//   92 	if(U7MCR != ch) rval = FALSE;
        LDR      R0,[R5, #+52]
        ADD      R0,R0,#+262144
        LDRB     R0,[R0, #+0]
        CMP      R0,R1
        IT       NE 
        MOVNE    R4,#+0
//   93 
//   94 	////////////////////////////////////////////////////////////////
//   95 #if defined (OS_INCLUDED) 
//   96 		pUSART7.sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        STR      R0,[R5, #+48]
//   97 #endif
//   98 
//   99 
//  100 	return rval;
        MOV      R0,R4
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock0
//  101 }
//  102 
//  103 ////////////////////////////////////////////////////////////////////

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function USART7Handler
        THUMB
//  104 void USART7Handler(void)
//  105 {
USART7Handler:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  106 	INT16S Reg = U7FCR & 0x0f;
        LDR.N    R1,??DataTable8
        LDR      R4,[R1, #+52]
        ADD      R2,R4,#+131072
        LDRB     R0,[R2, #+0]
        AND      R0,R0,#0xF
//  107 
//  108 	if(Reg == 0x04)
        CMP      R0,#+4
        BNE.N    ??USART7Handler_0
//  109 	{
//  110 		Rx7Buff[Rx7WrCnt] = U7RBR;		// When the receive register is read, the RDR bit is automatically cleared.
        LDRH     R0,[R1, #+2]
        LDR.N    R2,??DataTable8_2
        LDRB     R3,[R4, #+0]
        STRB     R3,[R0, R2]
//  111 		if(++Rx7WrCnt >= Rx7BuffLen) Rx7WrCnt = 0;
        ADDS     R0,R0,#+1
        STRH     R0,[R1, #+2]
        UXTH     R0,R0
        CMP      R0,#+2048
        BCC.N    ??USART7Handler_1
        MOVS     R0,#+0
        STRH     R0,[R1, #+2]
        POP      {R4,PC}
//  112 	}
//  113 	else if(Reg == 0x02)
??USART7Handler_0:
        CMP      R0,#+2
        BNE.N    ??USART7Handler_2
//  114 	{
//  115 		while(1)
//  116 		{
//  117 			Reg = U7LSR & 0x60;
//  118 			//USART1PutChar(Reg);
//  119 			if(Reg != 0) break;
??USART7Handler_3:
        ADD      R0,R4,#+327680
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+96
        TST      R0,R1
        BEQ.N    ??USART7Handler_3
//  120 		}
//  121 
//  122 		Reg = USART7TxGetByte();
        BL       USART7TxGetByte
//  123 		//USART1PutChar((INT8U)(Reg >> 8));
//  124 		//USART1PutChar((INT8U)(Reg >> 0));
//  125 		if(Reg != -1)
        CMN      R0,#+1
        BEQ.N    ??USART7Handler_4
//  126 		{
//  127 			U7THR = (INT8U)Reg;
        STRB     R0,[R4, #+0]
        POP      {R4,PC}
//  128 			//USART1PutChar((INT8U)(Reg >> 0));
//  129 			//U7IER |= (IER_TIE | IER_RIE);	// TXIE set
//  130 			//USART1PutChar((INT8U)U7IER);
//  131 		}
//  132 		else
//  133 		{
//  134 			///USART1PutChar('E');
//  135 			U7IER = 0x01;
??USART7Handler_4:
        ADD      R0,R4,#+65536
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
        POP      {R4,PC}
//  136 		}
//  137 	}
//  138 	else
//  139 	{
//  140 		Reg  = U7LSR;
//  141 		Reg  = U7RBR;		// dummy하게 RD값을 읽는다(무시)
//  142 		Reg  = U7MSR;
//  143 		U7FCR = 0x07;		// fifo clear
??USART7Handler_2:
        MOVS     R0,#+7
        STRB     R0,[R2, #+0]
//  144 	}
//  145 }
??USART7Handler_1:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock1
//  146 
//  147 ////////////////////////////////////////////////////////////////////////////////

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function USART7PutToBuffer
        THUMB
//  148 unsigned char USART7PutToBuffer(unsigned char Data)
//  149 {
USART7PutToBuffer:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R5,R0
//  150 #ifdef OS_INCLUDED
//  151 		INT8U err;
//  152 		//////////////////////////////////////////////////
//  153 	
//  154 		OSSemPend(pUSART7.sem, 0, &err);
        LDR.N    R4,??DataTable8
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  155 #endif /* OS_INCLUDED */
//  156 
//  157 	Tx7Buff[Tx7WrCnt] = Data;
        LDRH     R0,[R4, #+6]
        LDR.N    R1,??DataTable8_3
        STRB     R5,[R0, R1]
//  158 	if(++Tx7WrCnt >= Tx7BuffLen) Tx7WrCnt = 0;
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        CMP      R0,#+2048
        IT       CS 
        MOVCS    R0,#+0
        STRH     R0,[R4, #+6]
//  159 	U7IER |= IER_TIE;	// TXIE set
        LDR      R0,[R4, #+52]
        ADD      R0,R0,#+65536
        LDRB     R1,[R0, #+0]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+0]
//  160 ///////////////////////////////////////////////////
//  161 #ifdef OS_INCLUDED
//  162 		OSSemPost(pUSART7.sem);
        LDR      R0,[R4, #+48]
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock2
//  163 #endif /* OS_INCLUDED */
//  164 
//  165 	return OS_NO_ERR;
//  166 }
//  167 
//  168 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function USART7PutChar
        THUMB
//  169 unsigned char USART7PutChar(unsigned char Data)
//  170 {
USART7PutChar:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R4,R0
//  171 #ifdef OS_INCLUDED
//  172 		INT8U err;
//  173 		//////////////////////////////////////////////////
//  174 	
//  175 		OSSemPend(pUSART7.sem, 0, &err);
        LDR.N    R5,??DataTable8
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R5, #+48]
        BL       OSSemPend
        LDR      R0,[R5, #+52]
        ADD      R1,R0,#+327680
//  176 #endif /* OS_INCLUDED */
//  177 
//  178 //	if(err != OS_NO_ERR ) return err;
//  179 
//  180 /////////////////////////////////////////////////////////////////////
//  181 	while((U7LSR & LSR_THRE) == 0);
??USART7PutChar_0:
        LDRB     R2,[R1, #+0]
        LSLS     R2,R2,#+26
        BPL.N    ??USART7PutChar_0
//  182 	U7THR = Data;
        STRB     R4,[R0, #+0]
//  183 /////////////////////////////////////////////////////////////////////
//  184 	#ifdef OS_INCLUDED
//  185 		OSSemPost(pUSART7.sem);
        LDR      R0,[R5, #+48]
        CFI EndBlock cfiBlock3
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  186 	#endif /* OS_INCLUDED */
//  187 	return OS_NO_ERR;
//  188 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI NoFunction
        CFI CFA R13+16
        CFI R4 Frame(CFA, -12)
        CFI R5 Frame(CFA, -8)
        CFI R14 Frame(CFA, -4)
        THUMB
?Subroutine0:
        BL       OSSemPost
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock4
//  189 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function USART7Printf
        THUMB
//  190 unsigned long int USART7Printf( const char *format, ... )
//  191 {
USART7Printf:
        PUSH     {R1-R3}
        CFI CFA R13+12
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        SUB      SP,SP,#+256
        CFI CFA R13+280
//  192 	unsigned long int i, cnt;
//  193 	char buf[256];
//  194 	va_list argptr;
//  195 
//  196 	va_start(argptr, format);
        ADD      R2,SP,#+268
//  197 	cnt = vsprintf(buf, format, argptr);
        MOV      R1,R0
        ADD      R0,SP,#+0
        BL       vsprintf
        MOV      R4,R0
//  198 	va_end( argptr );
//  199 
//  200 	for(i = 0;;i++)
        ADD      R5,SP,#+0
        B.N      ??USART7Printf_0
//  201 	{
//  202 		if(buf[i] == 0) break;
//  203 		if(buf[i] == '\n') USART7PutToBuffer('\r');
??USART7Printf_1:
        CMP      R0,#+10
        ITT      EQ 
        MOVEQ    R0,#+13
        BLEQ     USART7PutToBuffer
//  204 		USART7PutToBuffer(buf[i]);
        LDRB     R0,[R5], #+1
        BL       USART7PutToBuffer
??USART7Printf_0:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??USART7Printf_1
//  205 	}
//  206 	while(!USART7TxCheckByte())
??USART7Printf_2:
        BL       USART7TxCheckByte
        CBNZ.N   R0,??USART7Printf_3
//  207 	{
//  208 #ifdef OS_INCLUDED
//  209 	OSTimeDly(1);
        MOVS     R0,#+1
        BL       OSTimeDly
        B.N      ??USART7Printf_2
//  210 #endif /* OS_INCLUDED */
//  211 	}
//  212 	return cnt;
??USART7Printf_3:
        MOV      R0,R4
        ADD      SP,SP,#+256
        CFI CFA R13+24
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+16
        LDR      PC,[SP], #+16    ;; return
        CFI EndBlock cfiBlock5
//  213 }
//  214 
//  215 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function USART7PutStr
        THUMB
//  216 void USART7PutStr(unsigned char *Str, unsigned short int Length, int iEn)
//  217 {
USART7PutStr:
        PUSH     {R3-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+24
        MOV      R6,R0
        MOV      R7,R1
        MOV      R5,R2
//  218 	unsigned long int i;
//  219 
//  220 	USART7BuffClear();
        BL       USART7BuffClear
//  221 
//  222 #ifdef OS_INCLUDED
//  223 		INT8U err;
//  224 		OSSemPend(pUSART7.sem, 0, &err);
        LDR.N    R4,??DataTable8
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  225 #endif /* OS_INCLUDED */
//  226 
//  227 	for(i = 0; i < Length; i++)
        LDRH     R0,[R4, #+6]
        CBZ.N    R7,??USART7PutStr_0
        MOVW     R1,#+2047
        LDR.N    R2,??DataTable8_3
//  228 	{
//  229 		Tx7Buff[Tx7WrCnt++] = Str[i];
??USART7PutStr_1:
        LDRB     R3,[R6], #+1
        STRB     R3,[R0, R2]
//  230 		Tx7WrCnt %= Tx7BuffLen;
        ADDS     R0,R0,#+1
        ANDS     R0,R1,R0
//  231 	}
        SUBS     R7,R7,#+1
        BNE.N    ??USART7PutStr_1
??USART7PutStr_0:
        STRH     R0,[R4, #+6]
//  232 ///////////////////////////////////////////////////
//  233 	if(iEn)
        CBZ.N    R5,??USART7PutStr_2
//  234 	{
//  235 		U7IER |= IER_TIE;	// TXIE set
        LDR      R0,[R4, #+52]
        ADD      R0,R0,#+65536
        LDRB     R1,[R0, #+0]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+0]
//  236 	}	
//  237 #ifdef OS_INCLUDED
//  238 			OSSemPost(pUSART7.sem);
??USART7PutStr_2:
        LDR      R0,[R4, #+48]
        BL       OSSemPost
//  239 #endif /* OS_INCLUDED */
//  240 
//  241 }
        POP      {R0,R4-R7,PC}    ;; return
        CFI EndBlock cfiBlock6
//  242 
//  243 
//  244 
//  245 
//  246 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function USART7RxGetByte
        THUMB
//  247 signed short int USART7RxGetByte(void)
//  248 {
//  249     INT16S RetVal = 0;
//  250 
//  251     if(Rx7RdCnt == Rx7WrCnt) return -1;
USART7RxGetByte:
        LDR.N    R1,??DataTable8
        LDRH     R2,[R1, #+0]
        LDRH     R0,[R1, #+2]
        CMP      R2,R0
        BNE.N    ??USART7RxGetByte_0
        B.N      ?Subroutine2
//  252 	RetVal = Rx7Buff[Rx7RdCnt];
??USART7RxGetByte_0:
        LDR.N    R0,??DataTable8_2
        LDRB     R0,[R2, R0]
//  253 	if(++Rx7RdCnt >= Rx7BuffLen ) Rx7RdCnt = 0;
        ADDS     R2,R2,#+1
        STRH     R2,[R1, #+0]
        UXTH     R2,R2
        CMP      R2,#+2048
        BCC.N    ??USART7RxGetByte_1
        MOVS     R2,#+0
        STRH     R2,[R1, #+0]
//  254 
//  255 	return (RetVal & 0xff);
??USART7RxGetByte_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  256 }
//  257 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function USART7TxGetByte
        THUMB
//  258 signed short int USART7TxGetByte(void)
//  259 {
//  260 	INT16S RetVal = 0;
//  261 
//  262 	if(Tx7RdCnt == Tx7WrCnt) return -1;
USART7TxGetByte:
        LDR.N    R1,??DataTable8
        LDRH     R2,[R1, #+4]
        LDRH     R0,[R1, #+6]
        CMP      R2,R0
        BNE.N    ??USART7TxGetByte_0
        B.N      ?Subroutine2
//  263 
//  264 	RetVal = Tx7Buff[Tx7RdCnt];
??USART7TxGetByte_0:
        LDR.N    R0,??DataTable8_3
        LDRB     R0,[R2, R0]
//  265 	if(++Tx7RdCnt >= Tx7BuffLen ) Tx7RdCnt = 0;
        ADDS     R2,R2,#+1
        STRH     R2,[R1, #+4]
        UXTH     R2,R2
        CMP      R2,#+2048
        BCC.N    ??USART7TxGetByte_1
        MOVS     R2,#+0
        STRH     R2,[R1, #+4]
//  266 	return (RetVal & 0xff);
??USART7TxGetByte_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  267 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine2:
        MOV      R0,#-1
        BX       LR
        CFI EndBlock cfiBlock9
//  268 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function USART7CheckByte
        THUMB
//  269 unsigned char USART7CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
//  270 {
USART7CheckByte:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  271 	INT32U	i = 0, j = 0;
//  272 	BOOL	RetVal = TRUE;
        MOVS     R2,#+1
//  273 
//  274 	*Recv = 0;
        MOVS     R3,#+0
        STRH     R3,[R1, #+0]
//  275 	i = (INT32U) Rx7RdCnt;
        LDR.N    R3,??DataTable8
        LDRH     R4,[R3, #+0]
//  276 	j = (INT32U) Rx7WrCnt;
        LDRH     R3,[R3, #+2]
//  277 
//  278 	if		(i == j) RetVal = FALSE;
        CMP      R4,R3
        BEQ.N    ??USART7CheckByte_0
//  279 	else if (i < j)
        ADDS     R0,R0,R4
        CMP      R4,R3
        BCS.N    ??USART7CheckByte_1
//  280 	{
//  281 		*Recv = j - i;
        SUBS     R4,R3,R4
        STRH     R4,[R1, #+0]
//  282 		i = i + ByteCnt;
//  283 		if(i > j)   RetVal = FALSE;
        CMP      R3,R0
        BCS.N    ??USART7CheckByte_2
        B.N      ??USART7CheckByte_0
//  284 	}
//  285 	else if (i > j)
//  286 	{
//  287 		*Recv = (Rx7BuffLen + j) - i;
??USART7CheckByte_1:
        ADD      R5,R3,#+2048
        SUBS     R4,R5,R4
        STRH     R4,[R1, #+0]
//  288 		i = i + ByteCnt;
//  289 		j = j + Rx7BuffLen;
//  290 		if(i > j)   RetVal = FALSE;
        ADD      R1,R3,#+2048
        CMP      R1,R0
        BCS.N    ??USART7CheckByte_2
??USART7CheckByte_0:
        MOVS     R2,#+0
//  291 	}
//  292 	return(RetVal);
??USART7CheckByte_2:
        MOV      R0,R2
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  293 }
//  294 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function USART7BuffClear
        THUMB
//  295 void USART7BuffClear( void )
//  296 {
//  297 	Rx7RdCnt = 0;
USART7BuffClear:
        LDR.N    R0,??DataTable8
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  298 	Rx7WrCnt = 0;
        STRH     R1,[R0, #+2]
//  299 	Tx7RdCnt = 0;
        B.N      ?Subroutine1
        CFI EndBlock cfiBlock11
//  300 	Tx7WrCnt = 0;
//  301 }
//  302 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function USART7TxClear
        THUMB
//  303 void USART7TxClear( void )
//  304 {
//  305 	Tx7RdCnt = 0;
USART7TxClear:
        LDR.N    R0,??DataTable8
        MOVS     R1,#+0
        CFI EndBlock cfiBlock12
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  306 	Tx7WrCnt = 0;
//  307 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine1:
        STRH     R1,[R0, #+4]
        STRH     R1,[R0, #+6]
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  308 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function USART7TxCheckByte
        THUMB
//  309 signed short int USART7TxCheckByte(void)
//  310 {
//  311 	if(Tx7RdCnt == Tx7WrCnt) return TRUE;
USART7TxCheckByte:
        LDR.N    R0,??DataTable8
        LDRH     R1,[R0, #+4]
        LDRH     R0,[R0, #+6]
        CMP      R1,R0
        BNE.N    ??USART7TxCheckByte_0
        MOVS     R0,#+1
        BX       LR
//  312 	else					 return FALSE;
??USART7TxCheckByte_0:
        MOVS     R0,#+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  313 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8:
        DC32     Rx7RdCnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_1:
        DC32     0x7a1200

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_2:
        DC32     Rx7Buff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_3:
        DC32     Tx7Buff

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  314 
//  315 ////////////////////////////////////////////////////////////////////////////////
//  316 // End of Source File
//  317 /////////////////////
//  318 
// 
//   668 bytes in section .text
// 4 152 bytes in section iram
// 
//   668 bytes of CODE memory
// 4 152 bytes of DATA memory
//
//Errors: none
//Warnings: none
