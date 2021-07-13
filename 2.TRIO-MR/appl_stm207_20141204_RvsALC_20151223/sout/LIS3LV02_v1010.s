///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      14/Nov/2010  14:44:17 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\dev\LIS3LV /
//                    02\LIS3LV02_v1010.c                                     /
//    Command line =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\dev\LIS3LV /
//                    02\LIS3LV02_v1010.c -lcN C:\user\project\HK-DEI\fw\appl /
//                    _rcub_20101101\sout\ -lB C:\user\project\HK-DEI\fw\appl /
//                    _rcub_20101101\sout\ -o C:\user\project\HK-DEI\fw\appl_ /
//                    rcub_20101101\sout\ --endian=little --cpu=Cortex-M3 -e  /
//                    --require_prototypes --fpu=None --dlib_config           /
//                    "C:\compiler\EWARM 5.20\ARM\INC\DLib_Config_Normal.h"   /
//                    -I C:\user\project\HK-DEI\fw\appl_rcub_20101101\include /
//                    \ -I C:\user\project\HK-DEI\fw\appl_rcub_20101101\lib_s /
//                    tm32\inc\ -I C:\user\project\HK-DEI\fw\appl_rcub_201011 /
//                    01\lib_stm32\src\ -I C:\user\project\HK-DEI\fw\appl_rcu /
//                    b_20101101\uC-CPU\ -I C:\user\project\HK-DEI\fw\appl_rc /
//                    ub_20101101\uC-LIB\ -I C:\user\project\HK-DEI\fw\appl_r /
//                    cub_20101101\uCOS-II\Ports\ -I                          /
//                    C:\user\project\HK-DEI\fw\appl_rcub_20101101\uCOS-II\So /
//                    urce\ -I C:\user\project\HK-DEI\fw\appl_rcub_20101101\u /
//                    C-Probe\ -I "C:\compiler\EWARM 5.20\ARM\INC\" -Oh       /
//    List file    =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\sout\LIS3L /
//                    V02_v1010.s                                             /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME LIS3LV02_v1010

        EXTERN SPI1Init
        EXTERN SPI_I2S_GetFlagStatus
        EXTERN SPI_I2S_ReceiveData
        EXTERN SPI_I2S_SendData
        EXTERN __aeabi_d2f
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_ddiv
        EXTERN __aeabi_f2d
        EXTERN __aeabi_fmul
        EXTERN __aeabi_i2d
        EXTERN acosf
        EXTERN asinf

        PUBLIC DevName
        PUBLIC Lis03lv02init
        PUBLIC ReadLSICtrl
        PUBLIC ReadLSIData
        PUBLIC SetLSICommand
        PUBLIC SlopeConvert
        PUBLIC WriteLSI

// C:\user\project\HK-DEI\fw\appl_rcub_20101101\dev\LIS3LV02\LIS3LV02_v1010.c
//    1 /*******************************************************************************
//    2  *
//    3  * This module contains the function STM32F103xxx original source file, a function
//    4  * whole things  initializations - global, include function and so on
//    5  *
//    6  *
//    7  * Note that this function is called before the data segments are
//    8  * initialized, this means that this function cannot rely on the
//    9  * values of global or static variables.
//   10  *
//   11  *
//   12  * Copyright 2008 - bizistyle(bgyoon@naver.com), All rights reserved.
//   13  *
//   14  * $Revision: 0.1 $
//   15  * $Revision date: 2008.07.
//   16 * v1010: APPEND + LIS33DL 
//   17  ******************************************************************************/
//   18 #define LIS03LV02_C
//   19 //#define LIS03LV02_DBG
//   20 
//   21 #include <math.h>
//   22 #include "../include/main.h"
//   23 

        SECTION `.bss`:DATA:NOROOT(0)
//   24 INT8U DevName;
DevName:
        DS8 1
//   25 
//   26 #if defined(USE_SPI1)
//   27 	#define LIS_CS_SET()	GPIOA->ODR.B4 = 1
//   28 	#define LIS_CS_RST()	GPIOA->ODR.B4 = 0
//   29 	#define LIS_BASE		SPI1
//   30 #elif defined(USE_SPI2)
//   31 	#define LIS_CS_SET()	GPIOB->ODR.B12 = 1
//   32 	#define LIS_CS_RST()	GPIOB->ODR.B12 = 0
//   33 	#define LIS_BASE		SPI2
//   34 #else
//   35 	#define LIS_CS_SET()
//   36 	#define LIS_CS_RST()
//   37 	#define LIS_BASE
//   38 #endif
//   39 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   40 void Lis03lv02init(void)
//   41 {
Lis03lv02init:
        PUSH     {R7,LR}
//   42 //int i;
//   43 	#ifdef USE_SPI1
//   44 		//////////////////////////////////
//   45 		// Port
//   46 		GPIOA->CNF.B4 = __PA4_OU_PP;
        LDR.N    R0,??Lis03lv02init_0  ;; 0x40010800
        LDR      R1,[R0, #+0]
        MVN      R2,#+983040
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x30000
        STR      R1,[SP, #+0]
        LDR      R1,[SP, #+0]
        STR      R1,[R0, #+0]
//   47 		GPIOA->CNF.B5 = __SPI1_SCK;
        LDR      R1,[R0, #+0]
        MVN      R2,#+15728640
        ANDS     R1,R2,R1
        ORR      R1,R1,#0xB00000
        STR      R1,[SP, #+0]
        LDR      R1,[SP, #+0]
        STR      R1,[R0, #+0]
//   48 		GPIOA->CNF.B7 = __SPI1_MOSI;
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
        ORR      R1,R1,#0xB0000000
        STR      R1,[SP, #+0]
        LDR      R1,[SP, #+0]
        STR      R1,[R0, #+0]
//   49 		GPIOA->CNF.B6 = __SPI1_MISO;
        LDR      R1,[R0, #+0]
        MVN      R2,#+251658240
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x4000000
        STR      R1,[SP, #+0]
        LDR      R1,[SP, #+0]
        STR      R1,[R0, #+0]
//   50 
//   51 		SPI1Init();		
        BL       SPI1Init
//   52 	#elif defined(USE_SPI2)
//   53 		GPIOB->CNF.B12 = __PB12_OU_PP;
//   54 		GPIOB->CNF.B13 = __SPI2_SCK;
//   55 		GPIOB->CNF.B15 = __SPI2_MOSI;
//   56 		GPIOB->CNF.B14 = __SPI2_MISO;
//   57 		SPI2Init();
//   58 	#endif
//   59 	LIS_CS_SET();
        LDR.N    R0,??Lis03lv02init_0  ;; 0x40010800
        LDR      R0,[R0, #+12]
        ORR      R0,R0,#0x10
        LDR.N    R1,??Lis03lv02init_0  ;; 0x40010800
        STR      R0,[R1, #+12]
//   60     DevName = ReadLSIData(WHO_AM_I);
        MOVS     R0,#+15
        BL       ReadLSIData
        LDR.N    R1,??Lis03lv02init_0+0x4  ;; DevName
        STRB     R0,[R1, #+0]
//   61 #ifdef LIS03LV02_DBG	
//   62 	USART1Printf("CTRL REG:0x%02xh\n", ReadLSIData(CTRL_REG1));
//   63 	USART1Printf("WHO AM I:0x%02xh\n", DevName);
//   64 #endif
//   65 
//   66 	{
//   67 		LIS_CTRLReg Ctrl;
//   68 
//   69 		Ctrl.Data = 0;
//   70 		Ctrl.Xen = 1;
//   71 		Ctrl.Yen = 1;
//   72 		Ctrl.Zen = 1;
//   73 		Ctrl.PD = DEON;
//   74 		
//   75 		WriteLSI(CTRL_REG1, Ctrl.Data);		//myAccel3LV02 √ ±‚»≠ 1000.0111 Power on, enable all axis, self test off     
        MOVS     R1,#+199
        MOVS     R0,#+32
        POP      {R2,LR}
        B.N      WriteLSI
        Nop      
        DATA
??Lis03lv02init_0:
        DC32     0x40010800
        DC32     DevName
//   76 	}
//   77 }
//   78 
//   79 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   80 INT8S SlopeConvert(TITLSTR *rval)
//   81 {
SlopeConvert:
        PUSH     {R0,R4-R11,LR}
//   82 	double dval;
//   83 	
//   84 	INT16S	TempX = 0;
//   85 	INT16S	TempY = 0;
//   86 	INT16S	TempZ = 0;
//   87 		
//   88 	TempX  |= (ReadLSIData(OUTX_L) & 0xff) << 0;
        MOVS     R0,#+40
        BL       ReadLSIData
        UXTB     R4,R0
//   89 	TempX  |= (ReadLSIData(OUTX_H) & 0xff) << 8;
        MOVS     R0,#+41
        BL       ReadLSIData
        SXTH     R0,R0
        ORR      R10,R4,R0, LSL #+8
        SXTH     R10,R10
//   90 	
//   91 	TempY  |= (ReadLSIData(OUTY_L) & 0xff) << 0;
        MOVS     R0,#+42
        BL       ReadLSIData
        UXTB     R4,R0
//   92 	TempY  |= (ReadLSIData(OUTY_H) & 0xff) << 8;
        MOVS     R0,#+43
        BL       ReadLSIData
        SXTH     R0,R0
        ORR      R5,R4,R0, LSL #+8
        SXTH     R5,R5
//   93 
//   94 	TempZ  |= (ReadLSIData(OUTZ_L) & 0xff) << 0;
        MOVS     R0,#+44
        BL       ReadLSIData
        UXTB     R4,R0
//   95 	TempZ  |= (ReadLSIData(OUTZ_H) & 0xff) << 8;
        MOVS     R0,#+45
        BL       ReadLSIData
        SXTH     R0,R0
        ORR      R4,R4,R0, LSL #+8
        SXTH     R4,R4
//   96 
//   97 #ifdef LIS03LV02_DBG
//   98 	USART1Printf("TempX:%03d\n",    TempX);
//   99 	USART1Printf("TempY:%03d\n",    TempY);
//  100 	USART1Printf("TempZ:%03d\n\n",TempZ);
//  101 #endif
//  102 	dval = (double)TempX/1024.0;
//  103 	rval->xradian = (INT16S)((asinf(dval)*1800)/3.14);
        LDR.W    R8,??SlopeConvert_0  ;; 0x51eb851f
        LDR.W    R9,??SlopeConvert_0+0x4  ;; 0x40091eb8
        LDR.W    R11,??SlopeConvert_0+0x8  ;; 0x44e10000
        MOVS     R6,#+0
        LDR.N    R7,??SlopeConvert_0+0xC  ;; 0x40900000
        MOV      R0,R10
        BL       __aeabi_i2d
        MOVS     R2,#+0
        MOVS     R3,R7
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        BL       asinf
        MOV      R1,R11
        BL       __aeabi_fmul
        BL       __aeabi_f2d
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2iz
        LDR      R1,[SP, #+0]
        STRH     R0,[R1, #+0]
//  104 #ifdef LIS03LV02_DBG
//  105 	USART1Printf("x-val:%d\n", rval->xradian/10);
//  106 #endif
//  107 
//  108 	dval = (double)TempY/1024.0;
//  109 	rval->yradian = (INT16S)((asinf(dval)*1800)/3.14);
        MOVS     R0,R5
        BL       __aeabi_i2d
        MOV      R2,R6
        MOVS     R3,R7
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        BL       asinf
        MOV      R1,R11
        BL       __aeabi_fmul
        BL       __aeabi_f2d
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2iz
        LDR      R1,[SP, #+0]
        STRH     R0,[R1, #+2]
//  110 #ifdef LIS03LV02_DBG
//  111 	USART1Printf("y-val:%d\n", rval->yradian/10);
//  112 #endif
//  113 
//  114 	dval = (double)TempZ/1024.0;
//  115 	rval->zradian = (INT16S)((acosf(dval)*1800)/3.14);
        MOVS     R0,R4
        BL       __aeabi_i2d
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_ddiv
        BL       __aeabi_d2f
        BL       acosf
        MOV      R1,R11
        BL       __aeabi_fmul
        BL       __aeabi_f2d
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_ddiv
        BL       __aeabi_d2iz
        LDR      R1,[SP, #+0]
        STRH     R0,[R1, #+4]
//  116 #ifdef LIS03LV02_DBG
//  117 	USART1Printf("z-val:%d\n", rval->zradian/10);
//  118 #endif
//  119     
//  120 	return TRUE;
        MOVS     R0,#+1
        POP      {R1,R4-R11,PC}   ;; return
        Nop      
        DATA
??SlopeConvert_0:
        DC32     0x51eb851f
        DC32     0x40091eb8
        DC32     0x44e10000
        DC32     0x40900000
//  121 }
//  122 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  123 INT16U SetLSICommand(INT16U Comm)
//  124 {
SetLSICommand:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        LDR.N    R5,??SetLSICommand_0  ;; 0x40013000
//  125 	//INT8U rtry = 0xff;
//  126 	
//  127 	//while(rtry-- && SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_TXE) == RESET);
//  128 	while(SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_TXE) == RESET);
??SetLSICommand_1:
        MOVS     R1,#+2
        MOVS     R0,R5
        BL       SPI_I2S_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??SetLSICommand_1
//  129 	// Send SPI2 data
//  130 	SPI_I2S_SendData(LIS_BASE, Comm);
        MOVS     R1,R4
        MOVS     R0,R5
        BL       SPI_I2S_SendData
//  131 	// Wait to receive a byte
//  132   	while(SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_RXNE) == RESET);
??SetLSICommand_2:
        MOVS     R1,#+1
        MOVS     R0,R5
        BL       SPI_I2S_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??SetLSICommand_2
//  133 	//while(rtry-- && SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_RXNE) == RESET);
//  134 	// Return the byte read from the SPI bus
//  135 	return SPI_I2S_ReceiveData(LIS_BASE);
        MOVS     R0,R5
        POP      {R1,R4,R5,LR}
        B.W      SPI_I2S_ReceiveData
        DATA
??SetLSICommand_0:
        DC32     0x40013000
//  136 }
//  137 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  138 void WriteLSI(INT16U Comm, INT8U DATA)
//  139 {
WriteLSI:
        PUSH     {R3-R5,LR}
        MOVS     R4,R1
//  140 	LIS_CS_RST();
        LDR.N    R5,??DataTable2  ;; 0x4001080c
        LDR      R1,[R5, #+0]
        MOVS     R2,#+16
        BICS     R1,R1,R2
        STR      R1,[R5, #+0]
//  141 
//  142 	SetLSICommand(MA3_ADDR_WR(Comm));
        MOVW     R1,#+65343
        ANDS     R0,R1,R0
        BL       SetLSICommand
//  143 	SetLSICommand(DATA);
        MOVS     R0,R4
        BL       SetLSICommand
//  144 
//  145 	LIS_CS_SET();
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x10
        STR      R0,[R5, #+0]
//  146 }
        POP      {R0,R4,R5,PC}    ;; return
//  147 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  148 INT8U ReadLSICtrl(INT8U Comm)
//  149 {
ReadLSICtrl:
        PUSH     {R4,LR}
//  150 	INT8U rval;
//  151 	LIS_CS_RST();
        LDR.N    R4,??DataTable2  ;; 0x4001080c
        LDR      R1,[R4, #+0]
        MOVS     R2,#+16
        BICS     R1,R1,R2
        STR      R1,[R4, #+0]
//  152 
//  153 		
//  154 	SetLSICommand(Comm);
        BL       SetLSICommand
//  155 	rval = SetLSICommand(NULL);
        MOVS     R0,#+0
        BL       SetLSICommand
        UXTB     R0,R0
//  156 
//  157 	LIS_CS_SET();
        LDR      R1,[R4, #+0]
        ORR      R1,R1,#0x10
        STR      R1,[R4, #+0]
//  158 
//  159 	return rval;
        POP      {R4,PC}          ;; return
//  160 }
//  161 
//  162 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  163 INT16U ReadLSIData(INT16U Comm)
//  164 {
ReadLSIData:
        PUSH     {R4,LR}
//  165 	INT16U rval;
//  166 	LIS_CS_RST();
        LDR.N    R4,??DataTable2  ;; 0x4001080c
        LDR      R1,[R4, #+0]
        MOVS     R2,#+16
        BICS     R1,R1,R2
        STR      R1,[R4, #+0]
//  167 
//  168 	SetLSICommand(MA3_ADDR_RD(Comm));
        MOVW     R1,#+65471
        ANDS     R0,R1,R0
        ORR      R0,R0,#0x80
        BL       SetLSICommand
//  169 	rval = SetLSICommand(NULL);
        MOVS     R0,#+0
        BL       SetLSICommand
//  170 	
//  171 	LIS_CS_SET();
        LDR      R1,[R4, #+0]
        ORR      R1,R1,#0x10
        STR      R1,[R4, #+0]
//  172 	return (rval);
        POP      {R4,PC}          ;; return
//  173 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     0x4001080c

        END
//  174 
//  175 ////////////////////////////////////////////////////////////////////////////////
//  176 // End of Source File
//  177 /////////////////////
//  178 
// 
//   1 byte  in section .bss
// 548 bytes in section .text
// 
// 548 bytes of CODE memory
//   1 byte  of DATA memory
//
//Errors: none
//Warnings: none
