///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:19 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\eeprom /
//                    \eep_24c64_v1104.c                                      /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\eeprom /
//                    \eep_24c64_v1104.c -D _MIMO_Type -lcN                   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120106\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120106\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120106\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\eep_2 /
//                    4c64_v1104.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME eep_24c64_v1104

        EXTERN ForDelay
        EXTERN OSTimeDly
        EXTERN USART1Printf

        PUBLIC ACKAT24C64
        PUBLIC AT24C64Init
        PUBLIC DisableWriteAT24C64
        PUBLIC EnableWriteAT24C64
        PUBLIC NACKAT24C64
        PUBLIC ReadAT24C64
        PUBLIC ReadAT24C64Data
        PUBLIC ReadAT24C64SDA
        PUBLIC Read_AT24C64_16Addr_8Data
        PUBLIC RstAT24C64SCL
        PUBLIC RstAT24C64SDA
        PUBLIC SetAT24C64SCL
        PUBLIC SetAT24C64SDA
        PUBLIC SetAT24C64SDAInMode
        PUBLIC SetAT24C64SDAOutMode
        PUBLIC StartAT24C64
        PUBLIC StopAT24C64
        PUBLIC WriteAT24C64
        PUBLIC WriteAT24C64Data
        PUBLIC Write_AT24C64_16Addr_8Data
        PUBLIC eprintf

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\eeprom\eep_24c64_v1104.c
//    1 /*******************************************************************************
//    2  *
//    3  * This module contains the function HMS39C7092 EEPROM(AT24C64) related, a function
//    4  * that is called before the 'main' function of the program.  Normally
//    5  * timer initializations - such as setting the prefered timer interrupt
//    6  * level or setting the watchdog - can be performed here.
//    7  *
//    8  * Note that this function is called before the data segments are
//    9  * initialized, this means that this function cannot rely on the
//   10  * values of global or static variables.
//   11  *
//   12  *
//   13  * Copyright 2008- bizistyle(bgyoon@naver.com), All rights reserved.
//   14  *
//   15  * $Revision: 0.1 $
//   16  * $Revision date: 2008.06
//   17  ******************************************************************************/
//   18 
//   19 #include "stm32f10x_conf.h"
//   20 #include "eep_24c64_v1104.h"
//   21 
//   22 //#define EEp_debug
//   23 //unsigned long int USART3Printf( const char *format, ... );
//   24 

        SECTION `.data`:DATA:NOROOT(2)
//   25 unsigned long int (*eprintf)( const char *format, ... ) = USART1Printf;
eprintf:
        DATA
        DC32 USART1Printf
//   26 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   27 void AT24C64Init(void)
//   28 {
AT24C64Init:
        PUSH     {R4,LR}
//   29 #if 1
//   30 	GPIOB->CNF.B8 = __PB8_OU_OD; //__I2C1_SCL;			// AT24C00 SCL
        LDR.N    R4,??AT24C64Init_0  ;; 0x40010c00
        LDR      R0,[R4, #+4]
        MOVS     R1,#+15
        BICS     R0,R0,R1
        ORR      R0,R0,#0x7
        STR      R0,[R4, #+4]
//   31 	// SDA
//   32 	GPIOB->CNF.B13 = __PB13_IN_FL; //__I2C1_SDA;		// AT24C00 SDA
        MVN      R0,#+15728640
        LDR      R1,[R4, #+4]
        ANDS     R1,R0,R1
        ORR      R1,R1,#0x400000
        STR      R1,[R4, #+4]
//   33 	//WP
//   34 	GPIOB->CNF.B5 = __PB5_OU_PP; //__I2C1_WP;			// AT24C00 WP
        LDR      R1,[R4, #+0]
        ANDS     R0,R0,R1
        ORR      R0,R0,#0x300000
        STR      R0,[R4, #+0]
//   35 	RstAT24C64SCL();
        BL       RstAT24C64SCL
//   36 	DisableWriteAT24C64();
        LDR      R0,[R4, #+12]
        ORR      R0,R0,#0x20
        STR      R0,[R4, #+12]
//   37 #endif
//   38 
//   39 #if 0
//   40 	// SCL
//   41 	GPIOB->CNF.B4 = __PB4_OU_PP; //__I2C1_SCL;			// AT24C64 SCL
//   42 	// SDA
//   43 	GPIOE->CNF.B2 = __PE2_IN_FL; //__I2C1_SDA;			// AT24C64 SDA
//   44 
//   45 	RstAT24C64SCL();
//   46 #endif
//   47 }
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??AT24C64Init_0:
        DC32     0x40010c00
//   48 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 INT16S WriteAT24C64(INT16U ADDR, INT8U Data)
//   50 {
WriteAT24C64:
        PUSH     {R3-R7,LR}
        MOV      R5,R0
        MOV      R4,R1
//   51 	INT8U cnt = AT24C64WrTry;
        MOVS     R6,#+7
//   52 	INT8U rVal = 0;
//   53 	INT16S pVal = (Data & 0xff);
//   54 	// 0: Write Fail
//   55 	// 1: Write Success
//   56 	EnableWriteAT24C64();
        LDR.N    R7,??DataTable8  ;; 0x40010c0c
        LDR      R0,[R7, #+0]
        BIC      R0,R0,#0x20
        STR      R0,[R7, #+0]
//   57 	rVal = Write_AT24C64_16Addr_8Data(AT24C64DevID, ADDR, Data);
        MOV      R2,R4
        MOV      R1,R5
        MOVS     R0,#+160
        BL       Write_AT24C64_16Addr_8Data
//   58 	DisableWriteAT24C64();
        LDR      R1,[R7, #+0]
        ORR      R1,R1,#0x20
        STR      R1,[R7, #+0]
//   59 
//   60 	if(!rVal) return -1;
        CMP      R0,#+0
        BNE.N    ??WriteAT24C64_0
        MOV      R0,#-1
        POP      {R1,R4-R7,PC}    ;; return
??WriteAT24C64_0:
        SUBS     R6,R6,#+1
        UXTB     R6,R6
//   61 
//   62 	// Confirm Data
//   63 	while(cnt--)
//   64 	{
//   65 		OSTimeDly(1);
        MOVS     R0,#+1
        BL       OSTimeDly
//   66 		if(Read_AT24C64_16Addr_8Data(AT24C64DevID, ADDR) == pVal) return pVal;
        MOV      R1,R5
        MOVS     R0,#+160
        BL       Read_AT24C64_16Addr_8Data
        CMP      R0,R4
        BEQ.N    ??WriteAT24C64_1
//   67 	}
        MOVS     R0,R6
        BNE.N    ??WriteAT24C64_0
//   68 	return Data;
??WriteAT24C64_1:
        MOV      R0,R4
        POP      {R1,R4-R7,PC}    ;; return
//   69 }
//   70 
//   71 
//   72 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   73 INT8U ReadAT24C64(INT16U ADDR)
//   74 {
ReadAT24C64:
        PUSH     {R7,LR}
//   75 	return Read_AT24C64_16Addr_8Data(AT24C64DevID, ADDR);
        MOV      R1,R0
        MOVS     R0,#+160
        BL       Read_AT24C64_16Addr_8Data
        UXTB     R0,R0
        POP      {R1,PC}          ;; return
//   76 }
//   77 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   78 INT8U Write_AT24C64_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data)
//   79 {
Write_AT24C64_16Addr_8Data:
        PUSH     {R4-R8,LR}
        MOV      R4,R1
        MOV      R5,R2
//   80 	INT8U cnt = AT24C64WrTry;
        MOVS     R6,#+7
        LSRS     R7,R4,#+8
        AND      R8,R0,#0xFE
//   81 	// Start Condition
//   82 	// Write Protection Disable, Allows normal write operation
//   83 	//
//   84 	// output 1(SDATA)
//   85 	// START Conditon making
//   86 	while(cnt--)
??Write_AT24C64_16Addr_8Data_0:
        MOVS     R0,R6
        BEQ.N    ??Write_AT24C64_16Addr_8Data_1
        SUBS     R6,R6,#+1
        UXTB     R6,R6
//   87 	{
//   88 		StartAT24C64();
        BL       StartAT24C64
//   89 		WriteAT24C64Data(DevAddr & (~0x01));
        MOV      R0,R8
        BL       WriteAT24C64Data
//   90 		#ifndef EEp_debug
//   91 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Write_AT24C64_16Addr_8Data_0
//   92 		#else
//   93 		{
//   94 			INT8U _Ack = ACKAT24C64();
//   95 			eprintf("ACK((0): %d \n", _Ack);
//   96 			if(_Ack) continue;
//   97 		}
//   98 		#endif
//   99 		WriteAT24C64Data((INT8U)(Addr >> 8));
        MOV      R0,R7
        BL       WriteAT24C64Data
//  100 		#ifndef EEp_debug
//  101 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Write_AT24C64_16Addr_8Data_0
//  102 		#else
//  103 		{
//  104 			INT8U _Ack = ACKAT24C64();
//  105 			eprintf("ACK(1): %d \n", _Ack);
//  106 			if(_Ack) continue;
//  107 		}
//  108 		#endif
//  109 		WriteAT24C64Data((INT8U)(Addr     ));
        UXTB     R0,R4
        BL       WriteAT24C64Data
//  110 		#ifndef EEp_debug
//  111 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Write_AT24C64_16Addr_8Data_0
//  112 		#else
//  113 		{
//  114 			INT8U _Ack = ACKAT24C64();
//  115 			eprintf("ACK(2): %d \n", _Ack);
//  116 			if(_Ack) continue;
//  117 		}
//  118 		#endif
//  119 		WriteAT24C64Data(Data);
        MOV      R0,R5
        BL       WriteAT24C64Data
//  120 		#ifndef EEp_debug
//  121 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Write_AT24C64_16Addr_8Data_0
//  122 		#else
//  123 		{
//  124 			INT8U _Ack = ACKAT24C64();
//  125 			eprintf("ACK(3): %d \n", _Ack);
//  126 			if(_Ack) continue;
//  127 		}
//  128 		#endif
//  129 		StopAT24C64();
        BL       StopAT24C64
//  130 
//  131 		return TRUE;
        MOVS     R0,#+1
        POP      {R4-R8,PC}
//  132 	}
//  133 	return FALSE;
??Write_AT24C64_16Addr_8Data_1:
        MOVS     R0,#+0
        POP      {R4-R8,PC}       ;; return
//  134 }
//  135 
//  136 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  137 INT16S Read_AT24C64_16Addr_8Data(INT8U DevAddr, INT16U Addr)
//  138 {
Read_AT24C64_16Addr_8Data:
        PUSH     {R4-R8,LR}
        MOV      R4,R1
//  139 	INT8U cnt = AT24C64WrTry;
        MOVS     R5,#+7
//  140 	INT8U rVal = 0;
        LSRS     R6,R4,#+8
        ORR      R7,R0,#0x1
        AND      R8,R0,#0xFE
//  141 
//  142 	// Device Address Writing
//  143 	while(cnt--)
??Read_AT24C64_16Addr_8Data_0:
        MOVS     R0,R5
        BEQ.N    ??Read_AT24C64_16Addr_8Data_1
        SUBS     R5,R5,#+1
        UXTB     R5,R5
//  144 	{
//  145 
//  146 		StartAT24C64();
        BL       StartAT24C64
//  147 		WriteAT24C64Data(DevAddr & (~0x01));
        MOV      R0,R8
        BL       WriteAT24C64Data
//  148 		#ifndef EEp_debug
//  149 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Read_AT24C64_16Addr_8Data_0
//  150 		#else
//  151 		{
//  152 			INT8U _Ack = ACKAT24C64();
//  153 			eprintf("ACK(0): %d \n", _Ack);
//  154 			if(_Ack) continue;
//  155 		}
//  156 		#endif
//  157 		WriteAT24C64Data((INT8U)(Addr >> 8));
        MOV      R0,R6
        BL       WriteAT24C64Data
//  158 		#ifndef EEp_debug
//  159 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Read_AT24C64_16Addr_8Data_0
//  160 		#else
//  161 		{
//  162 			INT8U _Ack = ACKAT24C64();
//  163 			eprintf("ACK(1): %d \n", _Ack);
//  164 			if(_Ack) continue;
//  165 		}
//  166 		#endif
//  167 		WriteAT24C64Data((INT8U)(Addr     ));
        UXTB     R0,R4
        BL       WriteAT24C64Data
//  168 		#ifndef EEp_debug
//  169 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Read_AT24C64_16Addr_8Data_0
//  170 		#else
//  171 		{
//  172 			INT8U _Ack = ACKAT24C64();
//  173 			eprintf("ACK(2): %d \n", _Ack);
//  174 			if(_Ack) continue;
//  175 		}
//  176 		#endif
//  177 		StartAT24C64();
        BL       StartAT24C64
//  178 		WriteAT24C64Data(DevAddr | 0x01);
        MOV      R0,R7
        BL       WriteAT24C64Data
//  179 		#ifndef EEp_debug
//  180 			if(ACKAT24C64()) continue;
        BL       ACKAT24C64
        CMP      R0,#+0
        BNE.N    ??Read_AT24C64_16Addr_8Data_0
//  181 		#else
//  182 		{
//  183 			INT8U _Ack = ACKAT24C64();
//  184 			eprintf("ACK(3): %d \n", _Ack);
//  185 			if(_Ack) continue;
//  186 		}
//  187 		#endif
//  188 		rVal = ReadAT24C64Data();
        BL       ReadAT24C64Data
        MOV      R4,R0
//  189 
//  190 		NACKAT24C64();
        BL       NACKAT24C64
//  191 	 	StopAT24C64();
        BL       StopAT24C64
//  192 
//  193 		return (rVal & 0xff);
        MOV      R0,R4
        POP      {R4-R8,PC}
//  194 	}
//  195 	return -1;
??Read_AT24C64_16Addr_8Data_1:
        MOV      R0,#-1
        POP      {R4-R8,PC}       ;; return
//  196 }
//  197 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  198 INT8U ACKAT24C64(void)
//  199 {
ACKAT24C64:
        PUSH     {R4,LR}
//  200 	INT8U Data;
//  201 
//  202  	SetAT24C64SDAInMode();
        BL       SetAT24C64SDAInMode
//  203 	// ACK Check
//  204 	SetAT24C64SCL();
        BL       SetAT24C64SCL
//  205 	Data = ReadAT24C64SDA();
        BL       ReadAT24C64SDA
        MOV      R4,R0
//  206 	RstAT24C64SCL();
        BL       RstAT24C64SCL
//  207 	return Data;
        MOV      R0,R4
        POP      {R4,PC}          ;; return
//  208 }
//  209 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  210 void NACKAT24C64(void)
//  211 {
NACKAT24C64:
        PUSH     {R7,LR}
//  212 	// NACK
//  213  	SetAT24C64SDAOutMode();
        BL       SetAT24C64SDAOutMode
//  214 
//  215 	SetAT24C64SDA();
        BL       SetAT24C64SDA
//  216 	SetAT24C64SCL();
        BL       SetAT24C64SCL
        Nop      
//  217 	RstAT24C64SCL();
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  218 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        POP      {R0,LR}
        B.N      RstAT24C64SCL
//  219 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  220 void WriteAT24C64Data(INT8U Data)
//  221 {
WriteAT24C64Data:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//  222 	INT8U i = 0;
//  223 
//  224  	SetAT24C64SDAOutMode();
        BL       SetAT24C64SDAOutMode
//  225 
//  226 	RstAT24C64SCL();
        BL       RstAT24C64SCL
//  227 	for(i = 0; i < 8; i++)
        MOVS     R5,#+8
//  228 	{
//  229 		if((Data & 0x80)) 	SetAT24C64SDA();
??WriteAT24C64Data_0:
        TST      R4,#0x80
        BEQ.N    ??WriteAT24C64Data_1
        BL       SetAT24C64SDA
        B.N      ??WriteAT24C64Data_2
//  230 		else				RstAT24C64SDA();
??WriteAT24C64Data_1:
        BL       RstAT24C64SDA
//  231 		SetAT24C64SCL();
??WriteAT24C64Data_2:
        BL       SetAT24C64SCL
//  232 		RstAT24C64SCL();
        BL       RstAT24C64SCL
//  233 		Data <<= 1;
        LSLS     R4,R4,#+1
//  234 	}
        SUBS     R5,R5,#+1
        BNE.N    ??WriteAT24C64Data_0
//  235 }
        POP      {R0,R4,R5,PC}    ;; return
//  236 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  237 INT8U ReadAT24C64Data(void)
//  238 {
ReadAT24C64Data:
        PUSH     {R3-R5,LR}
//  239 	INT8U Data = 0, i = 0;
        MOVS     R4,#+0
//  240 
//  241 	SetAT24C64SDAInMode();
        BL       SetAT24C64SDAInMode
//  242 
//  243 	for(i = 0; i < 8; i++)
        MOVS     R5,#+8
//  244 	{
//  245         Data = (Data << 1);
??ReadAT24C64Data_0:
        LSLS     R4,R4,#+25
        LSRS     R4,R4,#+24
//  246         SetAT24C64SCL();
        BL       SetAT24C64SCL
//  247         if(ReadAT24C64SDA())	Data |= 0x01;
        BL       ReadAT24C64SDA
        CBZ      R0,??ReadAT24C64Data_1
        ORR      R4,R4,#0x1
//  248         RstAT24C64SCL();
??ReadAT24C64Data_1:
        BL       RstAT24C64SCL
//  249 	}
        SUBS     R5,R5,#+1
        BNE.N    ??ReadAT24C64Data_0
//  250 	return Data;
        MOV      R0,R4
        POP      {R1,R4,R5,PC}    ;; return
//  251 }
//  252 
//  253 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  254 void StartAT24C64(void)
//  255 {
StartAT24C64:
        PUSH     {R7,LR}
//  256 	// START Conditon making
//  257 	SetAT24C64SDAOutMode();
        BL       SetAT24C64SDAOutMode
//  258 
//  259 	SetAT24C64SDA();
        BL       SetAT24C64SDA
//  260 
//  261 	SetAT24C64SCL();
        BL       SetAT24C64SCL
//  262 	RstAT24C64SDA();
        BL       RstAT24C64SDA
//  263 	RstAT24C64SCL();
        B.N      ?Subroutine0
//  264 
//  265 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  266 void StopAT24C64(void)
//  267 {
StopAT24C64:
        PUSH     {R7,LR}
//  268 	// STOP
//  269 	SetAT24C64SDAOutMode();
        BL       SetAT24C64SDAOutMode
//  270 	RstAT24C64SDA();
        BL       RstAT24C64SDA
//  271 	SetAT24C64SCL();
        BL       SetAT24C64SCL
//  272 	SetAT24C64SDA();
        BL       SetAT24C64SDA
//  273 	RstAT24C64SCL();
        B.N      ?Subroutine0
//  274 }
//  275 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  276 void SetAT24C64SDAInMode(void)
//  277 {
//  278 #if 1
//  279 	GPIOB->CNF.B13 = __PB13_IN_FL; //__I2C1_SDA;			// AT24C64 SDA
SetAT24C64SDAInMode:
        LDR.N    R0,??DataTable2  ;; 0x40010c04
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF00000
        ORR      R1,R1,#0x400000
        STR      R1,[R0, #+0]
//  280 #endif
//  281 #if 0
//  282 	GPIOE->ODR.B2 = __PE2_IN_FL; //__I2C1_SDA;			// AT24C64 SDA
//  283 #endif
//  284 }
        BX       LR               ;; return
//  285 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  286 void SetAT24C64SDAOutMode(void)
//  287 {
//  288 #if 1
//  289 //	GPIOB->CNF.B13 = __PB13_OU_OD; //__I2C1_SDA;			// AT24C64 SDA
//  290 	GPIOB->CNF.B13 = __PB13_OU_PP; //__I2C1_SDA;			// AT24C64 SDA
SetAT24C64SDAOutMode:
        LDR.N    R0,??DataTable2  ;; 0x40010c04
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF00000
        ORR      R1,R1,#0x300000
        STR      R1,[R0, #+0]
//  291 #endif
//  292 #if 0
//  293 	GPIOE->ODR.B2 = __PE2_OU_PP; //__I2C1_SDA;			// AT24C64 SDA
//  294 #endif
//  295 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     0x40010c04
//  296 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  297 void SetAT24C64SCL(void)
//  298 {
//  299 #if 1
//  300 	GPIOB->ODR.B8 = SET;
SetAT24C64SCL:
        LDR.N    R0,??DataTable8  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x100
        B.N      ?Subroutine1
//  301 	CLK24C64DELAY;
//  302 #endif
//  303 #if 0
//  304 	GPIOB->ODR.B4 = 1;
//  305 	CLK24C64DELAY;
//  306 #endif	
//  307 }
//  308 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  309 void RstAT24C64SCL(void)
//  310 {
//  311 #if 1
//  312 	GPIOB->ODR.B8 = RESET;
RstAT24C64SCL:
        LDR.N    R0,??DataTable8  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x100
        B.N      ?Subroutine1
//  313 	CLK24C64DELAY;
//  314 #endif
//  315 #if 0
//  316 	GPIOB->ODR.B4 = 0;
//  317 	CLK24C64DELAY;
//  318 #endif	
//  319 }
//  320 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  321 void SetAT24C64SDA(void)
//  322 {
//  323 #if 1
//  324 	GPIOB->ODR.B13 = SET;
SetAT24C64SDA:
        LDR.N    R0,??DataTable8  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x2000
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  325 	CLK24C64DELAY;
//  326 #endif
//  327 
//  328 #if 0
//  329 	GPIOE->ODR.B2 = 1;	
//  330 	CLK24C64DELAY;
//  331 #endif	
//  332 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        STR      R1,[R0, #+0]
        MOVS     R0,#+5
        B.W      ForDelay
//  333 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  334 void RstAT24C64SDA(void)
//  335 {
//  336 #if 1
//  337 	GPIOB->ODR.B13 = RESET;
RstAT24C64SDA:
        LDR.N    R0,??DataTable8  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x2000
        B.N      ?Subroutine1
//  338 	CLK24C64DELAY;
//  339 #endif
//  340 
//  341 #if 0
//  342 	GPIOE->ODR.B2 = 0;
//  343 	CLK24C64DELAY;
//  344 #endif	
//  345 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  346 INT8U ReadAT24C64SDA(void)
//  347 {
ReadAT24C64SDA:
        PUSH     {R7,LR}
//  348 /////////////////////////////////////////	
//  349 #if 1
//  350 	CLK24C64DELAY;
        MOVS     R0,#+5
        BL       ForDelay
//  351 	return(GPIOB->IDR.B13);
        LDR.N    R0,??ReadAT24C64SDA_0  ;; 0x40010c08
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x2000
        LSRS     R0,R0,#+13
        POP      {R1,PC}          ;; return
        DATA
??ReadAT24C64SDA_0:
        DC32     0x40010c08
//  352 #endif	
//  353 #if 0
//  354 	return(GPIOE->IDR.B2);
//  355 #endif
//  356 }
//  357 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  358 void EnableWriteAT24C64(void)
//  359 {
//  360 	GPIOB->ODR.B5 = RESET;
EnableWriteAT24C64:
        LDR.N    R0,??DataTable8  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x20
        STR      R1,[R0, #+0]
//  361 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  362 void DisableWriteAT24C64(void)
//  363 {
//  364 	GPIOB->ODR.B5 = SET;
DisableWriteAT24C64:
        LDR.N    R0,??DataTable8  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x20
        STR      R1,[R0, #+0]
//  365 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     0x40010c0c

        END
//  366 
//  367 ////////////////////////////////////////////////////////////////////////////////
//  368 // End of Source File
//  369 /////////////////////
//  370 
// 
//   4 bytes in section .data
// 674 bytes in section .text
// 
// 674 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
