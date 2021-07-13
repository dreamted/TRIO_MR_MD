///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    23/Aug/2012  00:33:38 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_iAP /
//                    D.c                                                     /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_iAP /
//                    D.c -lcN C:\user\project\FR-SSR\fw\appl_ssr_20120717\so /
//                    ut\ -lB C:\user\project\FR-SSR\fw\appl_ssr_20120717\sou /
//                    t\ -o C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\ /
//                     --endian=little --cpu=Cortex-M3 -e                     /
//                    --require_prototypes --fpu=None --dlib_config           /
//                    "C:\compiler\ewarm 5.5\arm\INC\DLib_Config_Normal.h"    /
//                    -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\include\ /
//                     -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\lib_stm /
//                    32\inc\ -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\ /
//                    lib_stm32\src\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uC-CPU\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uC-LIB\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uCOS-II\Ports\ -I C:\user\project\FR-SSR\fw\appl /
//                    _ssr_20120717\uCOS-II\Source\ -I                        /
//                    C:\user\project\FR-SSR\fw\appl_ssr_20120717\uC-Probe\   /
//                    -I "C:\compiler\ewarm 5.5\arm\INC\" -Oh                 /
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\aa_iAP /
//                    D.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_iAPD

        EXTERN AD8362BPPLLWrite
        EXTERN AD9362InitSet
        EXTERN AD9362RxEnable
        EXTERN AD9362Tx12AllSel
        EXTERN AD9362Tx1AttnSet
        EXTERN AD9362TxAttnUpdateEn
        EXTERN AD9362TxEnable
        EXTERN AD9362TxOn
        EXTERN DownLoadGiveupTimerSet
        EXTERN MainStatus
        EXTERN OSSemCreate
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN SPI1Init
        EXTERN SPI2Init
        EXTERN SPI3Init
        EXTERN SPI_I2S_GetFlagStatus
        EXTERN SPI_I2S_ReceiveData
        EXTERN SPI_I2S_SendData

        PUBLIC FPGACfgFinish
        PUBLIC IsItiFPGAInit
        PUBLIC ReadFPGAs
        PUBLIC SetSPIxCommand
        PUBLIC WriteFPGAs
        PUBLIC iAD9352BPPLLSet
        PUBLIC iAD9362ResetOper
        PUBLIC iAPDInit
        PUBLIC iAPDTask
        PUBLIC iDev_SPIxInit
        PUBLIC iDev_SPIx_BASE
        PUBLIC iDev_SPIx_CS_RST
        PUBLIC iDev_SPIx_CS_SET
        PUBLIC iFPAGResetOper
        PUBLIC iFPGAEnableOper
        PUBLIC iFPGAGetStatus
        PUBLIC iFPGAInitialize
        PUBLIC iFPGASpi
        PUBLIC iFPGA_GetRegister
        PUBLIC iFPGA_INIT
        PUBLIC iFPGA_SetRegister
        PUBLIC iSPIxInit

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_iAPD.c
//    1 /*!
//    2 *********************************************************************************************************
//    3 *              	- iAPD CODE
//    4 *
//    5 *              	-(c) Copyright 2007-2012;
//    6 *
//    7 *              	-All rights reserved.  Protected by international copyright laws.
//    8 *              	-Knowledge of the source code may NOT be used to develop a similar product.
//    9 *              	-Please help us continue to provide the Embedded community with the finest
//   10 *              	-software available.  Your honesty is greatly appreciated.
//   11 *
//   12 * 				-file 		: iapd.c
//   13 * 				-author		: Yoon Byong-Gyu, bgyoon@naver.com
//   14 * 				-date		: 2012.05.
//   15 *********************************************************************************************************
//   16 */
//   17 
//   18 #define APD_C
//   19 //#define APD_DEBUG
//   20 
//   21 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute DevSPIxStr iFPGASpi
iFPGASpi:
        DS8 8

        SECTION iram:DATA:NOROOT(2)
// static __absolute OS_STK APD0TaskStk[256]
APD0TaskStk:
        DS8 1024

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U FPGACfgFinish
FPGACfgFinish:
        DS8 1
//   22 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   23 void iAPDInit(void)
//   24 {
iAPDInit:
        PUSH     {R4,LR}
//   25 	iFPGA_CS0_Init();		// SPI2
        LDR.W    R4,??DataTable14
        MOVS     R0,#+1
        BL       OSSemCreate
        STR      R0,[R4, #+3]
        MOVS     R0,#+0
        STRH     R0,[R4, #+0]
        MOV      R0,R4
        BL       iSPIxInit
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
        MOV      R0,R4
        BL       iSPIxInit
        MOVS     R0,#+2
        STRB     R0,[R4, #+0]
        MOV      R0,R4
        BL       iSPIxInit
        MOVS     R0,#+3
        STRB     R0,[R4, #+0]
        MOV      R0,R4
        BL       iSPIxInit
        MOVS     R0,#+4
        STRB     R0,[R4, #+0]
        MOV      R0,R4
        BL       iSPIxInit
//   26 	
//   27 	OSTaskCreate(iAPDTask, (void *)NULL, (OS_STK *)&APD0TaskStk[APD_START_STK_SIZE - 1], APD0_TASK_PRIO);
        MOVS     R3,#+6
        LDR.W    R2,??DataTable14_1
        MOVS     R1,#+0
        LDR.W    R0,??DataTable14_2
        POP      {R4,LR}
        B.W      OSTaskCreate
//   28 
//   29 }
//   30 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   31 void iAPDTask(void * pdata)
//   32 {
iAPDTask:
        PUSH     {R4,LR}
//   33 	OSTimeDly(100*APD0_TASK_PRIO);
        MOV      R0,#+600
        BL       OSTimeDly
        LDR.W    R4,??DataTable14_3
        B.N      ??iAPDTask_0
//   34 	
//   35 	while(1)
//   36 	{
//   37 		while(!DownLoadGiveupTimerSet(NULL))
//   38 		{
//   39 			if(!IsItiFPGAInit())
??iAPDTask_1:
        LDRB     R0,[R4, #+0]
        CBNZ.N   R0,??iAPDTask_2
//   40 			{
//   41 				iFPGA_INIT();
        BL       iFPGA_INIT
//   42 			}
//   43 			iFPGAGetStatus();
??iAPDTask_2:
        BL       iFPGAGetStatus
//   44 			//else			Install_StatusUpdate();
//   45 			//tmpSwFlag ^= TRUE;
//   46 			
//   47 			OSTimeDly(500L);
??iAPDTask_3:
        MOV      R0,#+500
        BL       OSTimeDly
//   48 		}
??iAPDTask_0:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CMP      R0,#+0
        BEQ.N    ??iAPDTask_1
//   49 		OSTimeDly(500L);
        B.N      ??iAPDTask_3
//   50 	}
//   51 }
//   52 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   53 void iFPGA_INIT(void)
//   54 {
iFPGA_INIT:
        PUSH     {R3-R5,LR}
//   55 	INT8U tmpData[2];
//   56 	
//   57 	int i = 0, j = 0;
//   58 
//   59 	iFPAGResetOper();
        BL       iFPAGResetOper
//   60 
//   61 	for(i = 0; i < 4; i++)
//   62 	{
//   63 		iAD9362ResetOper(i);
        MOVS     R0,#+0
        BL       iAD9362ResetOper
        MOVS     R0,#+1
        BL       iAD9362ResetOper
        MOVS     R0,#+2
        BL       iAD9362ResetOper
        MOVS     R0,#+3
        BL       iAD9362ResetOper
//   64 	}
//   65 
//   66 	OSTimeDly(500L);
        MOV      R0,#+500
        BL       OSTimeDly
//   67 	AD9362InitSet(SPI_3G_TX_CH, LTE_20MHz);
        MOVS     R1,#+2
        MOVS     R0,#+0
        BL       AD9362InitSet
//   68 	AD9362InitSet(SPI_3G_RX_CH, LTE_20MHz);
        MOVS     R1,#+2
        MOVS     R0,#+1
        BL       AD9362InitSet
//   69 	AD9362InitSet(SPI_4G_TX_CH, MainStatus->TypeSel_4G%3);
        LDR.W    R4,??DataTable14_4
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+113]
        MOVS     R5,#+3
        SDIV     R1,R0,R5
        MLS      R1,R5,R1,R0
        UXTB     R1,R1
        MOVS     R0,#+2
        BL       AD9362InitSet
//   70 	AD9362InitSet(SPI_4G_RX_CH, MainStatus->TypeSel_4G%3);
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+113]
        SDIV     R1,R0,R5
        MLS      R1,R5,R1,R0
        UXTB     R1,R1
        MOVS     R0,#+3
        BL       AD9362InitSet
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+103]
        AND      R2,R0,#0x1
        AND      R0,R0,#0x1
        EOR      R1,R0,#0x1
        MOVS     R0,#+0
//   71 
//   72 	// InitSet!!
//   73 
//   74 	// SPI_3G_TX_CH((Tx) In --> (Rx) Out)
//   75 	AD9362RxEnable(SPI_3G_TX_CH, !(MainStatus->RFPathSelTx_3G & 0x01), (MainStatus->RFPathSelTx_3G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362RxEnable
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+103]
        AND      R1,R0,#0x1
        EOR      R2,R1,#0x1
        MOVS     R0,#+1
//   76 	AD9362TxEnable(SPI_3G_RX_CH, (MainStatus->RFPathSelTx_3G & 0x01), !(MainStatus->RFPathSelTx_3G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362TxEnable
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+104]
        AND      R2,R0,#0x1
        AND      R0,R0,#0x1
        EOR      R1,R0,#0x1
        MOVS     R0,#+1
//   77 
//   78 	// SPI_3G_RX_CH((Rx) In --> (Tx) Out)
//   79 	AD9362RxEnable(SPI_3G_RX_CH, !(MainStatus->RFPathSelRx_3G & 0x01), (MainStatus->RFPathSelRx_3G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362RxEnable
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+104]
        AND      R1,R0,#0x1
        EOR      R2,R1,#0x1
        MOVS     R0,#+0
//   80 	AD9362TxEnable(SPI_3G_TX_CH, (MainStatus->RFPathSelRx_3G & 0x01), !(MainStatus->RFPathSelRx_3G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362TxEnable
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+101]
        AND      R2,R0,#0x1
        AND      R0,R0,#0x1
        EOR      R1,R0,#0x1
        MOVS     R0,#+2
//   81 
//   82 	// SPI_4G_TX_CH((Tx) In --> (Rx) Out)
//   83 	AD9362RxEnable(SPI_4G_TX_CH, !(MainStatus->RFPathSelTx_4G & 0x01), (MainStatus->RFPathSelTx_4G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362RxEnable
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+101]
        AND      R1,R0,#0x1
        EOR      R2,R1,#0x1
        MOV      R0,R5
//   84 	AD9362TxEnable(SPI_4G_RX_CH, (MainStatus->RFPathSelTx_4G & 0x01), !(MainStatus->RFPathSelTx_4G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362TxEnable
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+102]
        AND      R2,R0,#0x1
        AND      R0,R0,#0x1
        EOR      R1,R0,#0x1
        MOV      R0,R5
//   85 
//   86 	// SPI_4G_RX_CH((Rx) In --> (Tx) Out)
//   87 	AD9362RxEnable(SPI_4G_RX_CH, !(MainStatus->RFPathSelRx_4G & 0x01), (MainStatus->RFPathSelRx_4G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362RxEnable
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+102]
        AND      R1,R0,#0x1
        EOR      R2,R1,#0x1
        MOVS     R0,#+2
//   88 	AD9362TxEnable(SPI_4G_TX_CH, (MainStatus->RFPathSelRx_4G & 0x01), !(MainStatus->RFPathSelRx_4G & 0x01));	// 0: Main, 1: Sub
        BL       AD9362TxEnable
//   89 
//   90 	
//   91 	for(i = 0; i < 4; i++)
//   92 	{
//   93 		AD9362TxOn(i, SET);
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       AD9362TxOn
//   94 
//   95 		// Tx ATTN (Tx Power Init)
//   96 		AD9362Tx12AllSel(i, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       AD9362Tx12AllSel
//   97 		AD9362TxAttnUpdateEn(i, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       AD9362TxAttnUpdateEn
//   98 		AD9362Tx1AttnSet(i, AD9362_GAIN_TXMAX*4);
        MOVS     R1,#+12
        MOVS     R0,#+0
        BL       AD9362Tx1AttnSet
        MOVS     R1,#+1
        MOV      R0,R1
        BL       AD9362TxOn
        MOVS     R1,#+1
        MOV      R0,R1
        BL       AD9362Tx12AllSel
        MOVS     R1,#+1
        MOV      R0,R1
        BL       AD9362TxAttnUpdateEn
        MOVS     R1,#+12
        MOVS     R0,#+1
        BL       AD9362Tx1AttnSet
        MOVS     R1,#+1
        MOVS     R0,#+2
        BL       AD9362TxOn
        MOVS     R1,#+1
        MOVS     R0,#+2
        BL       AD9362Tx12AllSel
        MOVS     R1,#+1
        MOVS     R0,#+2
        BL       AD9362TxAttnUpdateEn
        MOVS     R1,#+12
        MOVS     R0,#+2
        BL       AD9362Tx1AttnSet
        MOVS     R1,#+1
        MOV      R0,R5
        BL       AD9362TxOn
        MOVS     R1,#+1
        MOV      R0,R5
        BL       AD9362Tx12AllSel
        MOVS     R1,#+1
        MOV      R0,R5
        BL       AD9362TxAttnUpdateEn
        MOVS     R1,#+12
        MOV      R0,R5
        BL       AD9362Tx1AttnSet
//   99 
//  100 	}
//  101 
//  102 	OSTimeDly(1000L);
        MOV      R0,#+1000
        BL       OSTimeDly
//  103 	
//  104 	FPGACfgFinish = TRUE;
        LDR.W    R0,??DataTable14_3
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  105 }
        POP      {R0,R4,R5,PC}    ;; return
//  106 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  107 INT8U IsItiFPGAInit(void)
//  108 {
//  109 	return(FPGACfgFinish);
IsItiFPGAInit:
        LDR.W    R0,??DataTable14_3
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//  110 }
//  111 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  112 void iFPGAInitialize(void)
//  113 {
//  114 	FPGACfgFinish = FALSE;
iFPGAInitialize:
        LDR.W    R0,??DataTable14_3
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  115 }
        BX       LR               ;; return
//  116 
//  117 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  118 void iFPAGResetOper(void)
//  119 {
iFPAGResetOper:
        PUSH     {R2-R4,LR}
//  120 	INT8U tmpData;
//  121 
//  122 	tmpData = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+4]
//  123 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_RESET, &tmpData, 1);
        LDR.W    R4,??DataTable14
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,#+33024
        MOVS     R1,#+4
        MOV      R0,R4
        BL       iFPGA_SetRegister
//  124 	OSTimeDly(1000);
        MOV      R0,#+1000
        BL       OSTimeDly
//  125 	tmpData = 1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+4]
//  126 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_RESET, &tmpData, 1);
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,#+33024
        MOVS     R1,#+4
        MOV      R0,R4
        BL       iFPGA_SetRegister
//  127 	OSTimeDly(1000);
        MOV      R0,#+1000
        BL       OSTimeDly
//  128 }
        POP      {R0,R1,R4,PC}    ;; return
//  129 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  130 void iAD9362ResetOper(INT8U ch)
//  131 {
iAD9362ResetOper:
        PUSH     {R2-R6,LR}
        MOV      R5,R0
//  132 	INT8U tmpData[2];
//  133 
//  134 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_RESET, tmpData, 2);
        LDR.W    R4,??DataTable14
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVS     R2,#+16
        MOVS     R1,#+4
        MOV      R0,R4
        BL       iFPGA_GetRegister
//  135 
//  136 	     if(ch == SPI_3G_TX_CH) BitRst(tmpData[0], 4);
        CBNZ.N   R5,??iAD9362ResetOper_0
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xEF
??iAD9362ResetOper_1:
        STRB     R0,[SP, #+4]
        B.N      ??iAD9362ResetOper_2
//  137 	else if(ch == SPI_3G_RX_CH) BitRst(tmpData[0], 0);
??iAD9362ResetOper_0:
        CMP      R5,#+1
        ITT      EQ 
        LDRBEQ   R0,[SP, #+4]
        ANDEQ    R0,R0,#0xFE
        BEQ.N    ??iAD9362ResetOper_1
//  138 	else if(ch == SPI_4G_TX_CH) BitRst(tmpData[1], 4);
        CMP      R5,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ANDEQ    R1,R1,#0xEF
        BEQ.N    ??iAD9362ResetOper_3
//  139 	else if(ch == SPI_4G_RX_CH) BitRst(tmpData[1], 0);
        CMP      R5,#+3
        BNE.N    ??iAD9362ResetOper_2
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        AND      R1,R1,#0xFE
??iAD9362ResetOper_3:
        STRB     R1,[R0, #+1]
//  140 
//  141 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_RESET, tmpData, 2);
??iAD9362ResetOper_2:
        MOVW     R6,#+32784
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,R6
        MOVS     R1,#+4
        MOV      R0,R4
        BL       iFPGA_SetRegister
//  142 	
//  143 	OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
//  144 
//  145 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_RESET, tmpData, 2);
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVS     R2,#+16
        MOVS     R1,#+4
        MOV      R0,R4
        BL       iFPGA_GetRegister
//  146 
//  147 	     if(ch == SPI_3G_TX_CH) BitSet(tmpData[0], 4);
        CBNZ.N   R5,??iAD9362ResetOper_4
        LDRB     R0,[SP, #+4]
        ORR      R0,R0,#0x10
??iAD9362ResetOper_5:
        STRB     R0,[SP, #+4]
        B.N      ??iAD9362ResetOper_6
//  148 	else if(ch == SPI_3G_RX_CH) BitSet(tmpData[0], 0);
??iAD9362ResetOper_4:
        CMP      R5,#+1
        ITT      EQ 
        LDRBEQ   R0,[SP, #+4]
        ORREQ    R0,R0,#0x1
        BEQ.N    ??iAD9362ResetOper_5
//  149 	else if(ch == SPI_4G_TX_CH) BitSet(tmpData[1], 4);
        CMP      R5,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ORREQ    R1,R1,#0x10
        BEQ.N    ??iAD9362ResetOper_7
//  150 	else if(ch == SPI_4G_RX_CH) BitSet(tmpData[1], 0);
        CMP      R5,#+3
        BNE.N    ??iAD9362ResetOper_6
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x1
??iAD9362ResetOper_7:
        STRB     R1,[R0, #+1]
//  151 
//  152 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_RESET, tmpData, 2);
??iAD9362ResetOper_6:
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,R6
        MOVS     R1,#+4
        MOV      R0,R4
        B.N      ?Subroutine0
//  153 }
//  154 
//  155 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  156 void iFPGAEnableOper(INT8U ch, INT8U IsEn)
//  157 {
iFPGAEnableOper:
        PUSH     {R2-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
//  158 	INT8U tmpData[2];
//  159 
//  160 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_EN, tmpData, 2);
        LDR.W    R6,??DataTable14
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVS     R2,#+24
        MOVS     R1,#+4
        MOV      R0,R6
        BL       iFPGA_GetRegister
//  161 
//  162 	if(!IsEn)
        CBNZ.N   R5,??iFPGAEnableOper_0
//  163 	{
//  164 		     if(ch == SPI_3G_TX_CH) BitRst(tmpData[0], 4);
        CBNZ.N   R4,??iFPGAEnableOper_1
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xEF
??iFPGAEnableOper_2:
        STRB     R0,[SP, #+4]
        B.N      ??iFPGAEnableOper_3
//  165 		else if(ch == SPI_3G_RX_CH) BitRst(tmpData[0], 0);
??iFPGAEnableOper_1:
        CMP      R4,#+1
        ITT      EQ 
        LDRBEQ   R0,[SP, #+4]
        ANDEQ    R0,R0,#0xFE
        BEQ.N    ??iFPGAEnableOper_2
//  166 		else if(ch == SPI_4G_TX_CH) BitRst(tmpData[1], 4);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ANDEQ    R1,R1,#0xEF
        BEQ.N    ??iFPGAEnableOper_4
//  167 		else if(ch == SPI_4G_RX_CH) BitRst(tmpData[1], 0);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_3
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        AND      R1,R1,#0xFE
        B.N      ??iFPGAEnableOper_4
//  168 	}
//  169 	else{
//  170 			 if(ch == SPI_3G_TX_CH) BitSet(tmpData[0], 4);
??iFPGAEnableOper_0:
        CBNZ.N   R4,??iFPGAEnableOper_5
        LDRB     R0,[SP, #+4]
        ORR      R0,R0,#0x10
        B.N      ??iFPGAEnableOper_2
//  171 		else if(ch == SPI_3G_RX_CH) BitSet(tmpData[0], 0);
??iFPGAEnableOper_5:
        CMP      R4,#+1
        ITTT     EQ 
        LDRBEQ   R0,[SP, #+4]
        ORREQ    R0,R0,#0x1
        STRBEQ   R0,[SP, #+4]
        BEQ.N    ??iFPGAEnableOper_3
//  172 		else if(ch == SPI_4G_TX_CH) BitSet(tmpData[1], 4);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ORREQ    R1,R1,#0x10
        BEQ.N    ??iFPGAEnableOper_4
//  173 		else if(ch == SPI_4G_RX_CH) BitSet(tmpData[1], 0);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_3
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x1
??iFPGAEnableOper_4:
        STRB     R1,[R0, #+1]
//  174 	}
//  175 
//  176 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_EN, tmpData, 2);
??iFPGAEnableOper_3:
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVW     R2,#+32792
        MOVS     R1,#+4
        MOV      R0,R6
        BL       iFPGA_SetRegister
//  177 
//  178 
//  179 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_TXRX, tmpData, 2);
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVS     R2,#+20
        MOVS     R1,#+4
        MOV      R0,R6
        BL       iFPGA_GetRegister
//  180 
//  181 	if(!IsEn)
        CBNZ.N   R5,??iFPGAEnableOper_6
//  182 	{
//  183 			 if(ch == SPI_3G_TX_CH) BitRst(tmpData[0], 4);
        CBNZ.N   R4,??iFPGAEnableOper_7
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xEF
??iFPGAEnableOper_8:
        STRB     R0,[SP, #+4]
        B.N      ??iFPGAEnableOper_9
//  184 		else if(ch == SPI_3G_RX_CH) BitRst(tmpData[0], 0);
??iFPGAEnableOper_7:
        CMP      R4,#+1
        ITT      EQ 
        LDRBEQ   R0,[SP, #+4]
        ANDEQ    R0,R0,#0xFE
        BEQ.N    ??iFPGAEnableOper_8
//  185 		else if(ch == SPI_4G_TX_CH) BitRst(tmpData[1], 4);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ANDEQ    R1,R1,#0xEF
        BEQ.N    ??iFPGAEnableOper_10
//  186 		else if(ch == SPI_4G_RX_CH) BitRst(tmpData[1], 0);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_9
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        AND      R1,R1,#0xFE
        B.N      ??iFPGAEnableOper_10
//  187 	}
//  188 	else{
//  189 			 if(ch == SPI_3G_TX_CH) BitSet(tmpData[0], 4);
??iFPGAEnableOper_6:
        CBNZ.N   R4,??iFPGAEnableOper_11
        LDRB     R0,[SP, #+4]
        ORR      R0,R0,#0x10
        B.N      ??iFPGAEnableOper_8
//  190 		else if(ch == SPI_3G_RX_CH) BitSet(tmpData[0], 0);
??iFPGAEnableOper_11:
        CMP      R4,#+1
        ITTT     EQ 
        LDRBEQ   R0,[SP, #+4]
        ORREQ    R0,R0,#0x1
        STRBEQ   R0,[SP, #+4]
        BEQ.N    ??iFPGAEnableOper_9
//  191 		else if(ch == SPI_4G_TX_CH) BitSet(tmpData[1], 4);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ORREQ    R1,R1,#0x10
        BEQ.N    ??iFPGAEnableOper_10
//  192 		else if(ch == SPI_4G_RX_CH) BitSet(tmpData[1], 0);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_9
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x1
??iFPGAEnableOper_10:
        STRB     R1,[R0, #+1]
//  193 	}
//  194 
//  195 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_AD9362_TXRX, tmpData, 2);
??iFPGAEnableOper_9:
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVW     R2,#+32788
        MOVS     R1,#+4
        MOV      R0,R6
        BL       iFPGA_SetRegister
//  196 
//  197 
//  198 
//  199 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_TXEN, tmpData, 2);
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,#+272
        MOVS     R1,#+4
        MOV      R0,R6
        BL       iFPGA_GetRegister
//  200 
//  201 	if(!IsEn)
        CBNZ.N   R5,??iFPGAEnableOper_12
//  202 	{
//  203 		     if(ch == SPI_3G_TX_CH) BitRst(tmpData[0], 0);
        CBNZ.N   R4,??iFPGAEnableOper_13
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xFE
??iFPGAEnableOper_14:
        STRB     R0,[SP, #+4]
        B.N      ??iFPGAEnableOper_15
//  204 		else if(ch == SPI_3G_RX_CH) BitRst(tmpData[0], 4);
??iFPGAEnableOper_13:
        CMP      R4,#+1
        ITT      EQ 
        LDRBEQ   R0,[SP, #+4]
        ANDEQ    R0,R0,#0xEF
        BEQ.N    ??iFPGAEnableOper_14
//  205 		else if(ch == SPI_4G_TX_CH) BitRst(tmpData[1], 0);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ANDEQ    R1,R1,#0xFE
        BEQ.N    ??iFPGAEnableOper_16
//  206 		else if(ch == SPI_4G_RX_CH) BitRst(tmpData[1], 4);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_15
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        AND      R1,R1,#0xEF
        B.N      ??iFPGAEnableOper_16
//  207 	}
//  208 	else{
//  209 			 if(ch == SPI_3G_TX_CH) BitSet(tmpData[0], 0);
??iFPGAEnableOper_12:
        CBNZ.N   R4,??iFPGAEnableOper_17
        LDRB     R0,[SP, #+4]
        ORR      R0,R0,#0x1
        B.N      ??iFPGAEnableOper_14
//  210 		else if(ch == SPI_3G_RX_CH) BitSet(tmpData[0], 4);
??iFPGAEnableOper_17:
        CMP      R4,#+1
        ITTT     EQ 
        LDRBEQ   R0,[SP, #+4]
        ORREQ    R0,R0,#0x10
        STRBEQ   R0,[SP, #+4]
        BEQ.N    ??iFPGAEnableOper_15
//  211 		else if(ch == SPI_4G_TX_CH) BitSet(tmpData[1], 0);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ORREQ    R1,R1,#0x1
        BEQ.N    ??iFPGAEnableOper_16
//  212 		else if(ch == SPI_4G_RX_CH) BitSet(tmpData[1], 4);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_15
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x10
??iFPGAEnableOper_16:
        STRB     R1,[R0, #+1]
//  213 	}
//  214 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_TXEN, tmpData, 2);
??iFPGAEnableOper_15:
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVW     R2,#+33040
        MOVS     R1,#+4
        MOV      R0,R6
        BL       iFPGA_SetRegister
//  215 
//  216 
//  217 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_RXEN, tmpData, 2);
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,#+276
        MOVS     R1,#+4
        MOV      R0,R6
        BL       iFPGA_GetRegister
//  218 
//  219 	if(!IsEn)
        CBNZ.N   R5,??iFPGAEnableOper_18
//  220 	{
//  221 		     if(ch == SPI_3G_TX_CH) BitRst(tmpData[0], 4);
        CBNZ.N   R4,??iFPGAEnableOper_19
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xEF
??iFPGAEnableOper_20:
        STRB     R0,[SP, #+4]
        B.N      ??iFPGAEnableOper_21
//  222 		else if(ch == SPI_3G_RX_CH) BitRst(tmpData[0], 0);
??iFPGAEnableOper_19:
        CMP      R4,#+1
        ITT      EQ 
        LDRBEQ   R0,[SP, #+4]
        ANDEQ    R0,R0,#0xFE
        BEQ.N    ??iFPGAEnableOper_20
//  223 		else if(ch == SPI_4G_TX_CH) BitRst(tmpData[1], 4);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ANDEQ    R1,R1,#0xEF
        BEQ.N    ??iFPGAEnableOper_22
//  224 		else if(ch == SPI_4G_RX_CH) BitRst(tmpData[1], 0);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_21
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        AND      R1,R1,#0xFE
        B.N      ??iFPGAEnableOper_22
//  225 	}
//  226 	else{
//  227 			 if(ch == SPI_3G_TX_CH) BitSet(tmpData[0], 4);
??iFPGAEnableOper_18:
        CBNZ.N   R4,??iFPGAEnableOper_23
        LDRB     R0,[SP, #+4]
        ORR      R0,R0,#0x10
        B.N      ??iFPGAEnableOper_20
//  228 		else if(ch == SPI_3G_RX_CH) BitSet(tmpData[0], 0);
??iFPGAEnableOper_23:
        CMP      R4,#+1
        ITTT     EQ 
        LDRBEQ   R0,[SP, #+4]
        ORREQ    R0,R0,#0x1
        STRBEQ   R0,[SP, #+4]
        BEQ.N    ??iFPGAEnableOper_21
//  229 		else if(ch == SPI_4G_TX_CH) BitSet(tmpData[1], 4);
        CMP      R4,#+2
        ITTT     EQ 
        ADDEQ    R0,SP,#+4
        LDRBEQ   R1,[R0, #+1]
        ORREQ    R1,R1,#0x10
        BEQ.N    ??iFPGAEnableOper_22
//  230 		else if(ch == SPI_4G_RX_CH) BitSet(tmpData[1], 0);
        CMP      R4,#+3
        BNE.N    ??iFPGAEnableOper_21
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x1
??iFPGAEnableOper_22:
        STRB     R1,[R0, #+1]
//  231 	}
//  232 
//  233 	WriteFPGAs(SPI_FPGA_CH, F_ADDR_RXEN, tmpData, 2);
??iFPGAEnableOper_21:
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVW     R2,#+33044
        MOVS     R1,#+4
        MOV      R0,R6
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  234 
//  235 
//  236 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        BL       iFPGA_SetRegister
        POP      {R0,R1,R4-R6,PC}  ;; return
//  237 
//  238 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  239 void iFPGAGetStatus(void)
//  240 {
iFPGAGetStatus:
        PUSH     {R2-R6,LR}
//  241 	INT8U tmpData[4];
//  242 	
//  243 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_CODE_VER, tmpData, 2);
        LDR.N    R4,??DataTable14
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVS     R2,#+4
        MOVS     R1,#+4
        MOV      R0,R4
        BL       iFPGA_GetRegister
//  244 
//  245 	MainStatus->FPGA_Ver[0] = tmpData[0];
        LDR.N    R5,??DataTable14_4
        LDR      R0,[R5, #+0]
        LDRB     R1,[SP, #+4]
        STRB     R1,[R0, #+114]
//  246 	MainStatus->FPGA_Ver[1] = tmpData[1];
        ADD      R6,SP,#+4
        LDR      R0,[R5, #+0]
        LDRB     R1,[R6, #+1]
        STRB     R1,[R0, #+115]
//  247 	
//  248 	ReadFPGAs(SPI_FPGA_CH, F_ADDR_DATE, tmpData, 4);
        MOVS     R0,#+4
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOVS     R2,#+8
        MOV      R1,R0
        MOV      R0,R4
        BL       iFPGA_GetRegister
//  249 
//  250 	MainStatus->FPGA_Date[0] = tmpData[0];
        LDR      R0,[R5, #+0]
        LDRB     R1,[SP, #+4]
        STRB     R1,[R0, #+116]
//  251 	MainStatus->FPGA_Date[1] = tmpData[1];
        LDR      R0,[R5, #+0]
        LDRB     R1,[R6, #+1]
        STRB     R1,[R0, #+117]
//  252 	MainStatus->FPGA_Date[2] = tmpData[2];
        LDR      R0,[R5, #+0]
        LDRB     R1,[R6, #+2]
        STRB     R1,[R0, #+118]
//  253 	MainStatus->FPGA_Date[3] = tmpData[3];
        LDR      R0,[R5, #+0]
        LDRB     R1,[SP, #+7]
        STRB     R1,[R0, #+119]
//  254 
//  255 }
        POP      {R0,R1,R4-R6,PC}  ;; return
//  256 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  257 INT8U iAD9352BPPLLSet(INT8U ch, INT8U type)
//  258 {
//  259 
//  260 	INT32U fLo = 983040000L;
iAD9352BPPLLSet:
        LDR.N    R2,??DataTable14_5  ;; 0x3a980000
//  261 	INT8U ADCDiv = 0;
//  262 	INT8U DACDiv2En = FALSE;
//  263 
//  264 	if(type == LTE_10MHz)
        CBZ.N    R1,??iAD9352BPPLLSet_0
//  265 	{
//  266 		ADCDiv = ADCDivd4;
//  267 		DACDiv2En = FALSE;
//  268 	}
//  269 	else if(type == LTE_15MHz)
        CMP      R1,#+1
        IT       EQ 
        LDREQ.N  R2,??DataTable14_6  ;; 0x2bf20000
//  270 	{
//  271 		fLo = 737280000L;
//  272 		ADCDiv = ADCDivd2;
//  273 		DACDiv2En = TRUE;
//  274 	}
//  275 	else if(type == LTE_20MHz)
//  276 	{
//  277 		ADCDiv = ADCDivd2;
//  278 		DACDiv2En = TRUE;
//  279 	}
//  280 	else// if(type == UMTS4x)
//  281 	{
//  282 		ADCDiv = ADCDivd8;
//  283 		DACDiv2En = FALSE;
//  284 	}
//  285 
//  286 	return AD8362BPPLLWrite(ch, fLo);
??iAD9352BPPLLSet_0:
        MOV      R1,R2
        B.W      AD8362BPPLLWrite
//  287 
//  288 /**
//  289 
//  290 	
//  291 	AD9362BPPLLCtrl(ch, ADCDiv, DACDiv2En);
//  292 	
//  293 	AD9362DCXOSet(ch, 8, 4096);
//  294 	
//  295 	{
//  296 		INT8U THB3En;
//  297 		INT8U THB2En;
//  298 		INT8U THB1En;
//  299 		INT8U FIREn;
//  300 
//  301 		if(type == LTE_10MHz)
//  302 		{
//  303 			THB3En = THB3x2Enable;
//  304 			THB2En = ENABLE;
//  305 			THB1En = ENABLE;
//  306 			FIREn = FIRx2Enable;
//  307 		}
//  308 		else if(type == LTE_15MHz)
//  309 		{
//  310 			THB3En = THB3x1Bypass;
//  311 			THB2En = ENABLE;
//  312 			THB1En = ENABLE;
//  313 			FIREn = FIRx2Enable;
//  314 		}
//  315 		else if(type == LTE_20MHz)
//  316 		{
//  317 			THB3En = THB3x2Enable;
//  318 			THB2En = ENABLE;
//  319 			THB1En = ENABLE;
//  320 			FIREn = FIRx1Enable;
//  321 		}
//  322 		else// if(type == UMTS4x)
//  323 		{
//  324 			THB3En = THB3x2Enable;
//  325 			THB2En = ENABLE;
//  326 			THB1En = ENABLE;
//  327 			FIREn = FIRx1Enable;
//  328 		}
//  329 		AD9362TxFilterSet(ch, THB3En, THB2En, THB1En, FIREn);
//  330 	}
//  331 	AD9362TxFilterConf(ch, 0x07, 0);
//  332 
//  333 	{
//  334 		INT8U RHB3En;
//  335 		INT8U RHB2En;
//  336 		INT8U RHB1En;
//  337 		INT8U FIREn;
//  338 
//  339 		if(type == LTE_10MHz)
//  340 		{
//  341 			RHB3En = THB3x2Enable;
//  342 			RHB2En = ENABLE;
//  343 			RHB1En = ENABLE;
//  344 			FIREn = FIRx2Enable;
//  345 		}
//  346 		else if(type == LTE_15MHz)
//  347 		{
//  348 			RHB3En = THB3x2Enable;
//  349 			RHB2En = ENABLE;
//  350 			RHB1En = ENABLE;
//  351 			FIREn = FIRx2Enable;
//  352 		}
//  353 		else if(type == LTE_20MHz)
//  354 		{
//  355 			RHB3En = THB3x2Enable;
//  356 			RHB2En = ENABLE;
//  357 			RHB1En = ENABLE;
//  358 			FIREn = FIRx2Enable;
//  359 		}
//  360 		else// if(type == UMTS4x)
//  361 		{
//  362 			RHB3En = THB3x2Enable;
//  363 			RHB2En = ENABLE;
//  364 			RHB1En = ENABLE;
//  365 			FIREn = FIRx1Enable;
//  366 		}
//  367 		AD9362RxFilterSet(ch, RHB3En, RHB2En, RHB1En, FIREn);
//  368 	}
//  369 	AD9362RxFilterConf(ch, 0x07);
//  370 	AD9362RxFilterGain(ch, 0x02);
//  371 
//  372 	**/
//  373 }
//  374 
//  375 //TypeSel_4G
//  376 
//  377 
//  378 /*!******************************************************************************
//  379 * @fn		INT32U ReadFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
//  380 * @brief	to read spi datas for each channel	
//  381 * @return	length of Read
//  382 * @param	OPCODE : ndev channel no
//  383 * @param	ADDR   : spi Address
//  384 * @param	DATA   : data point read
//  385 * @param	nlen   : length read
//  386 * @remarks	prototype is declared in ther iapd.h
//  387 ********************************************************************************/
//  388 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  389 INT32U ReadFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
//  390 {
ReadFPGAs:
        PUSH     {R7,LR}
//  391 	return (iFPGA_GetRegister(&iFPGASpi, OPCODE, (ADDR & 0x7fff), DATA, nlen));
        STR      R3,[SP, #+0]
        MOV      R3,R2
        LSLS     R2,R1,#+17
        LSRS     R2,R2,#+17
        MOV      R1,R0
        LDR.N    R0,??DataTable14
        BL       iFPGA_GetRegister
        POP      {R1,PC}          ;; return
//  392 }
//  393 
//  394 /*!******************************************************************************
//  395 * @fn		void WriteFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
//  396 * @brief	to write spi datas for each channel	
//  397 * @return	none
//  398 * @param	OPCODE : ndev channel no
//  399 * @param	ADDR   : spi Address
//  400 * @param	DATA   : data point write
//  401 * @param	nlen   : length of writing
//  402 * @remarks	prototype is declared in ther iapd.h
//  403 ********************************************************************************/
//  404 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  405 void WriteFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
//  406 {
WriteFPGAs:
        PUSH     {R7,LR}
//  407 	iFPGA_SetRegister(&iFPGASpi, OPCODE, (ADDR | 0x8000), DATA, nlen);
        STR      R3,[SP, #+0]
        MOV      R3,R2
        ORR      R2,R1,#0x8000
        MOV      R1,R0
        LDR.N    R0,??DataTable14
        BL       iFPGA_SetRegister
//  408 }
        POP      {R0,PC}          ;; return
//  409 
//  410 /*!******************************************************************************
//  411 * @fn		INT32S sFLASH_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
//  412 * @brief	to read/write spi datas for each channel	
//  413 * @return	length of Read/writed
//  414 * @param	Devptr : spi pointer
//  415 * @param	OPCODE : ndev channel no
//  416 * @param	ADDR   : spi Address
//  417 * @param	DATA   : data point returned or write
//  418 * @param	nlen   : length returned or write
//  419 * @remarks	prototype is declared in ther iapd.h
//  420 ********************************************************************************/
//  421 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  422 INT32S iFPGA_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
//  423 {
iFPGA_SetRegister:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R5,R1
        MOV      R7,R2
        MOV      R8,R3
        LDR      R6,[SP, #+32]
//  424 	INT32U i = 0;
//  425 	INT8U err = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  426 
//  427 	OSSemPend(Devptr->OSSem, 0, &err);
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+3]
        BL       OSSemPend
//  428 
//  429 	Devptr->nDevNo = OPCODE;
        STRB     R5,[R4, #+0]
//  430 
//  431 	ADDR |= ((nlen - 1) & 0x07) << 12;
        SUBS     R0,R6,#+1
        AND      R0,R0,#0x7
        ORR      R7,R7,R0, LSL #+12
//  432 
//  433 	iDev_SPIx_CS_RST(Devptr->nDevNo);
        MOV      R0,R5
        BL       iDev_SPIx_CS_RST
//  434 		
//  435 	SetSPIxCommand(Devptr->SPIx, (ADDR >>  8) & 0xFF);
        UBFX     R1,R7,#+8,#+8
        LDRB     R0,[R4, #+1]
        BL       SetSPIxCommand
//  436 	SetSPIxCommand(Devptr->SPIx, (ADDR >>  0) & 0xFF);
        UXTB     R1,R7
        LDRB     R0,[R4, #+1]
        BL       SetSPIxCommand
//  437 
//  438 	for(i = 0; i < nlen && i < 4; i++)
        MOVS     R7,#+0
        B.N      ??iFPGA_SetRegister_0
//  439 	{
//  440 		SetSPIxCommand(Devptr->SPIx, DATA[i]);
??iFPGA_SetRegister_1:
        LDRB     R1,[R8], #+1
        LDRB     R0,[R4, #+1]
        BL       SetSPIxCommand
//  441 	}
        ADDS     R7,R7,#+1
??iFPGA_SetRegister_0:
        CMP      R7,R6
        IT       CC 
        CMPCC    R7,#+4
        BCC.N    ??iFPGA_SetRegister_1
//  442 
//  443 	iDev_SPIx_CS_SET(Devptr->nDevNo);
        B.N      ?Subroutine1
//  444 
//  445 	OSSemPost(Devptr->OSSem);
//  446 	return i;
//  447 }
//  448 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  449 INT32S iFPGA_GetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
//  450 {
iFPGA_GetRegister:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R8,R1
        MOV      R7,R2
        MOV      R5,R3
        LDR      R6,[SP, #+32]
//  451 	INT32U i = 0;
//  452 	INT8U err = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  453 
//  454 	OSSemPend(Devptr->OSSem, 0, &err);
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+3]
        BL       OSSemPend
//  455 
//  456 	Devptr->nDevNo = OPCODE;
        STRB     R8,[R4, #+0]
//  457 
//  458 	ADDR |= ((nlen - 1) & 0x07) << 12;
        SUBS     R0,R6,#+1
        AND      R0,R0,#0x7
        ORR      R7,R7,R0, LSL #+12
//  459 
//  460 	iDev_SPIx_CS_RST(Devptr->nDevNo);
        MOV      R0,R8
        BL       iDev_SPIx_CS_RST
//  461 		
//  462 	SetSPIxCommand(Devptr->SPIx, (ADDR >>  8) & 0xFF);
        UBFX     R1,R7,#+8,#+8
        LDRB     R0,[R4, #+1]
        BL       SetSPIxCommand
//  463 	SetSPIxCommand(Devptr->SPIx, (ADDR >>  0) & 0xFF);
        UXTB     R1,R7
        LDRB     R0,[R4, #+1]
        BL       SetSPIxCommand
//  464 
//  465 	for(i = 0; i < nlen && i < 4; i++)
        MOVS     R7,#+0
        B.N      ??iFPGA_GetRegister_0
//  466 	{
//  467 		DATA[i] = SetSPIxCommand(Devptr->SPIx, DATA[i]);
??iFPGA_GetRegister_1:
        LDRB     R1,[R5, #+0]
        LDRB     R0,[R4, #+1]
        BL       SetSPIxCommand
        STRB     R0,[R5], #+1
//  468 	}
        ADDS     R7,R7,#+1
??iFPGA_GetRegister_0:
        CMP      R7,R6
        IT       CC 
        CMPCC    R7,#+4
        BCC.N    ??iFPGA_GetRegister_1
//  469 
//  470 	iDev_SPIx_CS_SET(Devptr->nDevNo);
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  471 
//  472 	OSSemPost(Devptr->OSSem);
//  473 	return i;
//  474 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        LDRB     R0,[R4, #+0]
        BL       iDev_SPIx_CS_SET
        LDR      R0,[R4, #+3]
        BL       OSSemPost
        MOV      R0,R7
        POP      {R1,R2,R4-R8,PC}  ;; return
//  475 
//  476 
//  477 /////////////////////////////////////////////////////////////////////////////////

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  478 void iSPIxInit(DevSPIxStr *Devptr)
//  479 {
iSPIxInit:
        PUSH     {R4,LR}
        MOV      R4,R0
//  480 	iDev_SPIxInit(Devptr->SPIx);
        LDRB     R0,[R4, #+1]
        BL       iDev_SPIxInit
//  481 	iDev_SPIx_CS_SET(Devptr->nDevNo);
        LDRB     R0,[R4, #+0]
        POP      {R4,LR}
        REQUIRE iDev_SPIx_CS_SET
        ;; // Fall through to label iDev_SPIx_CS_SET
//  482 }
//  483 
//  484 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  485 void  iDev_SPIx_CS_SET(INT8U nDev)
//  486 {
//  487          if(nDev == SPI_3G_TX_CH) 	_3G_SPI_TX_nCS = 1;
iDev_SPIx_CS_SET:
        CBNZ.N   R0,??iDev_SPIx_CS_SET_0
        LDR.N    R0,??DataTable14_7  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x20
        B.N      ??iDev_SPIx_CS_SET_1
//  488 	else if(nDev == SPI_3G_RX_CH) 	_3G_SPI_RX_nCS = 1;
??iDev_SPIx_CS_SET_0:
        CMP      R0,#+1
        ITTT     EQ 
        LDREQ.N  R0,??DataTable14_7  ;; 0x40010c0c
        LDREQ    R1,[R0, #+0]
        ORREQ    R1,R1,#0x40
        BEQ.N    ??iDev_SPIx_CS_SET_1
//  489 	else if(nDev == SPI_4G_TX_CH) 	_4G_SPI_TX_nCS = 1;
        CMP      R0,#+2
        BNE.N    ??iDev_SPIx_CS_SET_2
        LDR.N    R0,??DataTable14_7  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        MOV      R2,#+256
??iDev_SPIx_CS_SET_3:
        ORRS     R1,R2,R1
        B.N      ??iDev_SPIx_CS_SET_1
//  490 	else if(nDev == SPI_4G_RX_CH) 	_4G_SPI_RX_nCS = 1;
??iDev_SPIx_CS_SET_2:
        CMP      R0,#+3
        BNE.N    ??iDev_SPIx_CS_SET_4
        LDR.N    R0,??DataTable14_7  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        MOV      R2,#+512
        B.N      ??iDev_SPIx_CS_SET_3
//  491 	else if(nDev == SPI_FPGA_CH) 	_FPGA_SPI_RX_nCS = 1;
??iDev_SPIx_CS_SET_4:
        CMP      R0,#+4
        BNE.N    ??iDev_SPIx_CS_SET_5
        LDR.N    R0,??DataTable14_7  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1000
??iDev_SPIx_CS_SET_1:
        STR      R1,[R0, #+0]
//  492 
//  493 }
??iDev_SPIx_CS_SET_5:
        BX       LR               ;; return
//  494 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  495 void iDev_SPIx_CS_RST(INT8U nDev)
//  496 {
//  497          if(nDev == SPI_3G_TX_CH) 	_3G_SPI_TX_nCS = 0;
iDev_SPIx_CS_RST:
        CBNZ.N   R0,??iDev_SPIx_CS_RST_0
        LDR.N    R0,??DataTable14_7  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x20
        B.N      ??iDev_SPIx_CS_RST_1
//  498 	else if(nDev == SPI_3G_RX_CH) 	_3G_SPI_RX_nCS = 0;
??iDev_SPIx_CS_RST_0:
        CMP      R0,#+1
        ITTT     EQ 
        LDREQ.N  R0,??DataTable14_7  ;; 0x40010c0c
        LDREQ    R1,[R0, #+0]
        BICEQ    R1,R1,#0x40
        BEQ.N    ??iDev_SPIx_CS_RST_1
//  499 	else if(nDev == SPI_4G_TX_CH) 	_4G_SPI_TX_nCS = 0;
        CMP      R0,#+2
        ITTT     EQ 
        LDREQ.N  R0,??DataTable14_7  ;; 0x40010c0c
        LDREQ    R1,[R0, #+0]
        BICEQ    R1,R1,#0x100
        BEQ.N    ??iDev_SPIx_CS_RST_1
//  500 	else if(nDev == SPI_4G_RX_CH) 	_4G_SPI_RX_nCS = 0;
        CMP      R0,#+3
        ITTT     EQ 
        LDREQ.N  R0,??DataTable14_7  ;; 0x40010c0c
        LDREQ    R1,[R0, #+0]
        BICEQ    R1,R1,#0x200
        BEQ.N    ??iDev_SPIx_CS_RST_1
//  501 	else if(nDev == SPI_FPGA_CH) 	_FPGA_SPI_RX_nCS = 0;
        CMP      R0,#+4
        BNE.N    ??iDev_SPIx_CS_RST_2
        LDR.N    R0,??DataTable14_7  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x1000
??iDev_SPIx_CS_RST_1:
        STR      R1,[R0, #+0]
//  502 }
??iDev_SPIx_CS_RST_2:
        BX       LR               ;; return
//  503 
//  504 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  505 SPI_TypeDef *iDev_SPIx_BASE(INT8U SPIx)
//  506 {
//  507 	SPI_TypeDef *nBASE;
//  508 	
//  509 	     if(SPIx == USE_SPI2) 	nBASE = SPI2;
iDev_SPIx_BASE:
        CMP      R0,#+0
        BNE.N    ??iDev_SPIx_BASE_0
        LDR.N    R0,??DataTable14_8  ;; 0x40003800
        BX       LR
//  510 	else if(SPIx == USE_SPI1) 	nBASE = SPI1;
??iDev_SPIx_BASE_0:
        CMP      R0,#+1
        ITE      EQ 
        LDREQ.N  R0,??DataTable14_9  ;; 0x40013000
        LDRNE.N  R0,??DataTable14_10  ;; 0x40003c00
        BX       LR
//  511 	else 						nBASE = SPI3;
//  512 
//  513 	return nBASE;
//  514 }
//  515 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  516 void iDev_SPIxInit(INT8U SPIx)
//  517 {
iDev_SPIxInit:
        PUSH     {R7,LR}
//  518 	if(SPIx == USE_SPI1) {
        CMP      R0,#+1
        BNE.N    ??iDev_SPIxInit_0
//  519 		GPIOA->CNF.B5 = __SPI1_SCK;
        LDR.N    R0,??DataTable14_11  ;; 0x40010800
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF00000
        ORR      R1,R1,#0xB00000
        STR      R1,[R0, #+0]
//  520 		GPIOA->CNF.B7 = __SPI1_MOSI;
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
        ORR      R1,R1,#0xB0000000
        STR      R1,[R0, #+0]
//  521 		GPIOA->CNF.B6 = __SPI1_MISO;
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF000000
        ORR      R1,R1,#0x4000000
        STR      R1,[R0, #+0]
//  522 		SPI1Init();
        POP      {R0,LR}
        B.W      SPI1Init
//  523 	}
//  524 	else if(SPIx == USE_SPI2) {
??iDev_SPIxInit_0:
        CBNZ.N   R0,??iDev_SPIxInit_1
//  525 		GPIOB->CNF.B13 = __SPI2_SCK; 
        LDR.N    R0,??DataTable14_12  ;; 0x40010c00
        LDR      R1,[R0, #+4]
        BIC      R1,R1,#0xF00000
        ORR      R1,R1,#0xB00000
        STR      R1,[R0, #+4]
//  526 		GPIOB->CNF.B15 = __SPI2_MOSI; 
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
        ORR      R1,R1,#0xB0000000
        STR      R1,[R0, #+4]
//  527 		GPIOB->CNF.B14 = __SPI2_MISO; 
        LDR      R1,[R0, #+4]
        BIC      R1,R1,#0xF000000
        ORR      R1,R1,#0x4000000
        STR      R1,[R0, #+4]
//  528 		SPI2Init();
        POP      {R0,LR}
        B.W      SPI2Init
//  529 	}
//  530 	else if(SPIx == USE_SPI3) {
??iDev_SPIxInit_1:
        CMP      R0,#+2
        BNE.N    ??iDev_SPIxInit_2
//  531 		GPIOB->CNF.B3 = __SPI3_SCK; 
        LDR.N    R0,??DataTable14_12  ;; 0x40010c00
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF000
        ORR      R1,R1,#0xB000
        STR      R1,[R0, #+0]
//  532 		GPIOB->CNF.B5 = __SPI3_MOSI; 
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF00000
        ORR      R1,R1,#0xB00000
        STR      R1,[R0, #+0]
//  533 		GPIOB->CNF.B4 = __SPI3_MISO; 
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF0000
        ORR      R1,R1,#0x40000
        STR      R1,[R0, #+0]
//  534 		SPI3Init();
        BL       SPI3Init
//  535 	}
//  536 }
??iDev_SPIxInit_2:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14:
        DC32     iFPGASpi

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_1:
        DC32     APD0TaskStk+0x3FC

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_2:
        DC32     iAPDTask

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_3:
        DC32     FPGACfgFinish

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_4:
        DC32     MainStatus

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_5:
        DC32     0x3a980000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_6:
        DC32     0x2bf20000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_7:
        DC32     0x40010c0c

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_8:
        DC32     0x40003800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_9:
        DC32     0x40013000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_10:
        DC32     0x40003c00

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_11:
        DC32     0x40010800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_12:
        DC32     0x40010c00
//  537 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  538 INT16U SetSPIxCommand(INT8U SPIx, INT16U Comm)
//  539 {
SetSPIxCommand:
        PUSH     {R3-R5,LR}
        MOV      R4,R1
//  540 	SPI_TypeDef *nBASE = iDev_SPIx_BASE(SPIx);
        BL       iDev_SPIx_BASE
        MOV      R5,R0
//  541 	
//  542 	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_TXE) == RESET); 	// Wait to Transfer a byte
??SetSPIxCommand_0:
        MOVS     R1,#+2
        MOV      R0,R5
        BL       SPI_I2S_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??SetSPIxCommand_0
//  543 	SPI_I2S_SendData(nBASE, Comm);                                     	// Send SPI2 data
        MOV      R1,R4
        MOV      R0,R5
        BL       SPI_I2S_SendData
//  544 	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_RXNE) == RESET);    // Wait to receive a byte
??SetSPIxCommand_1:
        MOVS     R1,#+1
        MOV      R0,R5
        BL       SPI_I2S_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??SetSPIxCommand_1
//  545 	return SPI_I2S_ReceiveData(nBASE);                                 	// Return the byte read from the SPI bus
        MOV      R0,R5
        POP      {R1,R4,R5,LR}
        B.W      SPI_I2S_ReceiveData
//  546 }

        END
//  547 
//  548 
//  549 
//  550 
//  551 
//  552 ////////////////////////////////////////////////////////////////////////////////
//  553 
//  554 ////////////////////////////////////////////////////////////////////////////////
//  555 // End of Source File
//  556 /////////////////////
//  557 
// 
//     9 bytes in section .bss
// 2 262 bytes in section .text
// 1 024 bytes in section iram
// 
// 2 262 bytes of CODE memory
// 1 033 bytes of DATA memory
//
//Errors: none
//Warnings: 4
