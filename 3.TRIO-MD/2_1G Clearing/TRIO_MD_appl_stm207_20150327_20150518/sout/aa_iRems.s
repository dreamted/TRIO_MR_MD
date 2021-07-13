///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    23/Aug/2012  00:33:34 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_iRe /
//                    ms.c                                                    /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_iRe /
//                    ms.c -lcN C:\user\project\FR-SSR\fw\appl_ssr_20120717\s /
//                    out\ -lB C:\user\project\FR-SSR\fw\appl_ssr_20120717\so /
//                    ut\ -o C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout /
//                    \ --endian=little --cpu=Cortex-M3 -e                    /
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
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\aa_iRe /
//                    ms.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_iRems

        EXTERN Booting
        EXTERN Crc16Calc
        EXTERN DownLoadBootingJump
        EXTERN DownLoadGiveupTimerSet
        EXTERN DownloadFlagSet
        EXTERN FLASHpAPBK_Check_Erase
        EXTERN MainStatus
        EXTERN MinAttn3G
        EXTERN MinAttn4G
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ResetCaseBackup
        EXTERN ResetStart
        EXTERN RoadBackuptobuffer
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN UpLoadData
        EXTERN WriteBuffertoBackup
        EXTERN convinfo
        EXTERN memcmp
        EXTERN pUSART2
        EXTERN pUSART3
        EXTERN strlen
        EXTERN strncmp
        EXTERN tTestFlag

        PUBLIC Ascii2Hex
        PUBLIC DataBuff
        PUBLIC DataBuffLength
        PUBLIC DownRstFlag
        PUBLIC FileName
        PUBLIC FileSize
        PUBLIC FrameRequest
        PUBLIC Hex2Ascii
        PUBLIC IRemsTask
        PUBLIC JMatrixConversion
        PUBLIC MControlRSPS_Flag
        PUBLIC MStatusRSPS_Flag
        PUBLIC MTxBuff
        PUBLIC ModemCommand
        PUBLIC ModemCtrlFlag
        PUBLIC ModemReset
        PUBLIC ModemRstCnt
        PUBLIC ModemTime
        PUBLIC RMS_RESET_FLAG
        PUBLIC Rem_ResetStep
        PUBLIC Rrms
        PUBLIC Srms
        PUBLIC iRemsComCheck
        PUBLIC iRemsDataAck
        PUBLIC iRemsDataAckTx
        PUBLIC iRemsDataCount
        PUBLIC iRemsDownloadFunc
        PUBLIC iRemsFrameCount
        PUBLIC iRemsFrameIndex
        PUBLIC iRemsFrameLastC
        PUBLIC iRemsFrameRetry
        PUBLIC iRemsFunction
        PUBLIC iRemsInit
        PUBLIC iRemsReceiveCheck
        PUBLIC iRemsRecieveACK
        PUBLIC iRemsRecieveNMS
        PUBLIC iRemsReset
        PUBLIC iRemsResetFunc
        PUBLIC iRemsSer
        PUBLIC iRemsSerB
        PUBLIC iRemsSetDataCopy
        PUBLIC iRemsStatus
        PUBLIC iRemsStatusB
        PUBLIC iRemsStatusUpdate
        PUBLIC iRemsSwcrc16
        PUBLIC iRemsTotalCrc

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_iRems.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_bkp.c
//    3 * Author             : MCD Application Team
//    4 * Date First Issued  : 09/29/2006
//    5 * Description        : This file provides all the BKP firmware functions.
//    6 ********************************************************************************/
//    7 
//    8 #define IREMS_C
//    9 
//   10 #include "../include/main.h"

        SECTION iram:DATA:NOROOT(2)
// static __absolute OS_STK iRemsTaskStk[2][256]
iRemsTaskStk:
        DS8 2048

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __IRemsPtr iRemsSerB[2]
iRemsSerB:
        DS8 104
// __absolute struct <unnamed> *__data iRemsSer[2]
iRemsSer:
        DS8 8
// __absolute IREMSSTATUS *__data iRemsStatus
iRemsStatus:
        DS8 4
// __absolute RMS Srms[2]
Srms:
        DS8 532
// __absolute RMS Rrms[2]
Rrms:
        DS8 532
// __absolute IREMSSTATUS iRemsStatusB
iRemsStatusB:
        DS8 32

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U RMS_RESET_FLAG
RMS_RESET_FLAG:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U MStatusRSPS_Flag
MStatusRSPS_Flag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U MControlRSPS_Flag
MControlRSPS_Flag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// __absolute INT8U ModemRstCnt[2]
ModemRstCnt:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(1)
// __absolute INT8U Rem_ResetStep[2]
Rem_ResetStep:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U ModemCtrlFlag
ModemCtrlFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT8U DataBuff[520]
DataBuff:
        DS8 520

        SECTION `.bss`:DATA:NOROOT(1)
// __absolute INT16U DataBuffLength
DataBuffLength:
        DS8 2

        SECTION `.data`:DATA:NOROOT(2)
// __absolute INT8U iRemsFrameRetry
iRemsFrameRetry:
        DATA
        DC8 0
        DC8 0
// __absolute INT8U DownRstFlag[2]
DownRstFlag:
        DC8 0, 0
// __absolute char FileName[9]
FileName:
        DC8 "030100XX"
        DC8 0, 0, 0
// __absolute INT16U iRemsTotalCrc
iRemsTotalCrc:
        DC8 0, 0
// __absolute INT16U iRemsFrameCount
iRemsFrameCount:
        DC8 0, 0
// __absolute INT16U iRemsFrameLastC
iRemsFrameLastC:
        DC8 0, 0
// __absolute INT16U iRemsFrameIndex
iRemsFrameIndex:
        DC16 0
// __absolute INT16U iRemsSwcrc16
iRemsSwcrc16:
        DC16 0
        DC8 0, 0
// __absolute INT32U FileSize
FileSize:
        DC32 0
// __absolute INT32S iRemsDataCount
iRemsDataCount:
        DC32 0
//   11 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   12 void iRemsInit(void)
//   13 {
iRemsInit:
        PUSH     {R4-R6,LR}
//   14 
//   15 	iRemsSer[0] = &iRemsSerB[0];
        LDR.W    R5,??DataTable13
        ADDW     R4,R5,#+100
        STR      R5,[R4, #+4]
//   16  	iRemsSer[0]->CheckByte = pUSART2.CheckByte;
        LDR.W    R0,??DataTable13_1
        LDR      R1,[R0, #+4]
        STR      R1,[R5, #+0]
//   17 	iRemsSer[0]->RxGetByte = pUSART2.RxGetByte;
        LDR      R1,[R0, #+8]
        STR      R1,[R5, #+4]
//   18 	iRemsSer[0]->PutStr = pUSART2.PutStr;
        LDR      R1,[R0, #+12]
        STR      R1,[R5, #+8]
//   19 	iRemsSer[0]->TxCheckByte = pUSART2.TxCheckByte;
        LDR      R1,[R0, #+28]
        STR      R1,[R5, #+20]
//   20 	iRemsSer[0]->TxClear = pUSART2.TxClear;
        LDR      R1,[R0, #+36]
        STR      R1,[R5, #+12]
//   21 	iRemsSer[0]->printf = pUSART2.printf;
        LDR      R0,[R0, #+16]
        STR      R0,[R5, #+16]
//   22 	
//   23 	iRemsSer[0]->TimerRx = TimeriRemsRx0;
        MOVS     R0,#+15
        STRH     R0,[R5, #+24]
//   24 	iRemsSer[0]->TimerTx = TimeriRemsTx0;
        MOVS     R0,#+17
        STRH     R0,[R5, #+28]
//   25 	iRemsSer[0]->TimerEndWait = TimeriRemsRx0;
        MOVS     R0,#+15
        STRH     R0,[R5, #+26]
//   26 	
//   27 	iRemsSer[0]->chan = L_PATH;
        MOVS     R0,#+0
        STRB     R0,[R5, #+48]
//   28 	iRemsSer[0]->Send = &Srms[0];
        ADDW     R0,R5,#+116
        STR      R0,[R5, #+44]
//   29 	iRemsSer[0]->Recv = &Rrms[0];
        ADDW     R0,R5,#+648
        STR      R0,[R5, #+40]
//   30 	iRemsSer[0]->OSSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+4]
        STR      R0,[R1, #+36]
//   31 
//   32 	iRemsSer[1] = &iRemsSerB[1];
        ADDW     R0,R5,#+52
        STR      R0,[R4, #+8]
//   33  	iRemsSer[1]->CheckByte = pUSART3.CheckByte;
        ADDW     R0,R5,#+48
        LDR.W    R1,??DataTable13_2
        LDR      R2,[R1, #+4]
        STR      R2,[R0, #+4]
//   34 	iRemsSer[1]->RxGetByte = pUSART3.RxGetByte;
        LDR      R2,[R1, #+8]
        STR      R2,[R0, #+8]
//   35 	iRemsSer[1]->PutStr = pUSART3.PutStr;
        LDR      R2,[R1, #+12]
        STR      R2,[R0, #+12]
//   36 	iRemsSer[1]->TxCheckByte = pUSART3.TxCheckByte;
        LDR      R2,[R1, #+28]
        STR      R2,[R0, #+24]
//   37 	iRemsSer[1]->TxClear = pUSART3.TxClear;
        LDR      R2,[R1, #+36]
        STR      R2,[R0, #+16]
//   38 	iRemsSer[1]->printf = pUSART3.printf;
        LDR      R1,[R1, #+16]
        STR      R1,[R0, #+20]
//   39 	
//   40 	iRemsSer[1]->TimerRx = TimeriRemsRx1;
        MOVS     R1,#+16
        STRH     R1,[R0, #+28]
//   41 	iRemsSer[1]->TimerTx = TimeriRemsTx1;
        MOVS     R1,#+18
        STRH     R1,[R0, #+32]
//   42 	iRemsSer[1]->TimerEndWait = TimeriRemsRx1;
        MOVS     R1,#+16
        STRH     R1,[R0, #+30]
//   43 	
//   44 	iRemsSer[1]->chan = W_PATH;
        MOVS     R1,#+1
        STRB     R1,[R5, #+100]
//   45 	iRemsSer[1]->Send = &Srms[1];
        ADDW     R1,R5,#+381
        STR      R1,[R0, #+48]
//   46 	iRemsSer[1]->Recv = &Rrms[1];
        ADDW     R1,R5,#+913
        STR      R1,[R0, #+44]
//   47 	iRemsSer[1]->OSSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+8]
        STR      R0,[R1, #+36]
//   48 
//   49 	
//   50 	iRemsStatus = &iRemsStatusB;
        ADDW     R0,R5,#+1180
        STR      R0,[R4, #+12]
//   51 
//   52 	OSTaskCreate(IRemsTask, (void *)iRemsSer[0], (OS_STK *)&iRemsTaskStk[0][IREMS_START_STK_SIZE - 1], IREMS_TASK_PRIO_0);
        LDR.W    R5,??DataTable13_3
        LDR.W    R6,??DataTable13_4
        MOVS     R3,#+4
        ADDW     R2,R6,#+1020
        LDR      R1,[R4, #+4]
        MOV      R0,R5
        BL       OSTaskCreate
//   53 	OSTaskCreate(IRemsTask, (void *)iRemsSer[1], (OS_STK *)&iRemsTaskStk[1][IREMS_START_STK_SIZE - 1], IREMS_TASK_PRIO_1);
        MOVS     R3,#+5
        ADDW     R2,R6,#+2044
        LDR      R1,[R4, #+8]
        MOV      R0,R5
        POP      {R4-R6,LR}
        B.W      OSTaskCreate
//   54 }
//   55 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 void IRemsTask(void * pdata)
//   57 {
IRemsTask:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   58     __IRemsPtr *nPtr = (__IRemsPtr *)pdata;
//   59 
//   60 	OSTimeDly(100*(IREMS_TASK_PRIO_0 + nPtr->chan));
        LDRB     R0,[R4, #+48]
        ADDS     R0,R0,#+4
        MOVS     R1,#+100
        MULS     R0,R1,R0
        UXTH     R0,R0
        BL       OSTimeDly
        LDR.W    R5,??DataTable13_5
        B.N      ??IRemsTask_0
//   61 
//   62 	//SerPtr->printf("iRems PATH[%d] Start!!\n", nPtr->chan);
//   63 
//   64 	while(1)
//   65 	{
//   66 		while(!tTestFlag)
//   67 		{
//   68 			iRemsFunction(nPtr);
??IRemsTask_1:
        MOV      R0,R4
        BL       iRemsFunction
//   69 			iRemsResetFunc(nPtr);
        MOV      R0,R4
        BL       iRemsResetFunc
//   70 			
//   71 			OSTimeDly(200L);
        MOVS     R0,#+200
??IRemsTask_2:
        BL       OSTimeDly
//   72 		}
??IRemsTask_0:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BEQ.N    ??IRemsTask_1
//   73 		OSTimeDly(500L);
        MOV      R0,#+500
        B.N      ??IRemsTask_2
//   74 	}
//   75 
//   76 }
//   77 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   78 void iRemsReset(__IRemsPtr *nPtr)
//   79 {
iRemsReset:
        PUSH     {R3-R5,LR}
        MOV      R5,R0
//   80 	
//   81 	if(nPtr->chan == L_PATH) 	_4G_REMS_EN = 1;	// off
        LDR.W    R4,??DataTable13_6  ;; 0x4001140c
        LDRB     R0,[R5, #+48]
        CMP      R0,#+0
        LDR      R0,[R4, #+0]
        ITE      EQ 
        ORREQ    R0,R0,#0x40
        ORRNE    R0,R0,#0x8
//   82 	else 						_3G_REMS_EN = 1;
        STR      R0,[R4, #+0]
//   83 
//   84 	OSTimeDly(3000L);
        MOVW     R0,#+3000
        BL       OSTimeDly
//   85 
//   86 	if(nPtr->chan == L_PATH)	_4G_REMS_EN = 0;	// on
        LDRB     R0,[R5, #+48]
        CMP      R0,#+0
        LDR      R0,[R4, #+0]
        ITE      EQ 
        BICEQ    R0,R0,#0x40
        BICNE    R0,R0,#0x8
//   87 	else						_3G_REMS_EN = 0;
        STR      R0,[R4, #+0]
//   88 }
        POP      {R0,R4,R5,PC}    ;; return
//   89 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   90 void iRemsFunction(__IRemsPtr *nPtr)
//   91 {
iRemsFunction:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
//   92 	//===================//
//   93 	// Modem Reset Check //
//   94 	//========================================================================//
//   95 	if(!DownLoadGiveupTimerSet(NULL)){
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBNZ.N   R0,??iRemsFunction_0
//   96 		if(TimeOverCheck(nPtr->TimerTx))
        LDRH     R0,[R4, #+28]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ.N    R0,??iRemsFunction_0
//   97 		{
//   98 			if ( ModemRstCnt[nPtr->chan] >= 4 )
        ADDW     R6,R4,#+28
        LDRB     R0,[R6, #+20]
        LDR.W    R5,??DataTable13_7
        LDRB     R1,[R0, R5]
        CMP      R1,#+4
        ITTT     CS 
        LDRCS.W  R1,??DataTable13_8
        MOVCS    R2,#+255
        STRBCS   R2,[R0, R1]
//   99 			{
//  100 				Booting[nPtr->chan] = 0xff;
        BCS.N    ??iRemsFunction_0
//  101 			}
//  102 			else if(ModemTime(nPtr))
        MOV      R0,R4
        BL       ModemTime
        CMP      R0,#+0
        LDRB     R0,[R6, #+20]
        BEQ.N    ??iRemsFunction_1
//  103 			{
//  104 				ModemRstCnt[nPtr->chan] = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, R5]
//  105 #ifdef IREMS_TEST
//  106 				TimerRegist( nPtr->TimerTx, Time1Sec*20);		// normally 3hours waiting...
//  107 #else
//  108 				TimerRegist( nPtr->TimerTx, Time1Sec*60*60*3);		// normally 3hours waiting...
        LDR.W    R1,??DataTable13_9  ;; 0xa4cb80
        LDRH     R0,[R4, #+28]
        B.N      ??iRemsFunction_2
//  109 #endif
//  110 			}
??iRemsFunction_1:
        LDRB     R1,[R0, R5]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, R5]
        LDRH     R0,[R4, #+28]
        LDRB     R1,[R6, #+20]
        LDRB     R1,[R1, R5]
        CMP      R1,#+4
        ITE      CS 
        MOVWCS   R1,#+60000
        LDRCC.W  R1,??DataTable13_10  ;; 0x1b7740
//  111 			else
//  112 			{
//  113 
//  114 #ifdef IREMS_TEST
//  115 				if ( ++ModemRstCnt[nPtr->chan] >= 4 )
//  116 					 TimerRegist( nPtr->TimerTx, Time1Sec*60);		// reset 1min waiting...
//  117 				else TimerRegist( nPtr->TimerTx, Time1Sec*60);		// retry 30min waiting...
//  118 #else
//  119 				if ( ++ModemRstCnt[nPtr->chan] >= 4 )
//  120 					 TimerRegist( nPtr->TimerTx, Time1Sec*60);		// reset 1min waiting...
//  121 				else TimerRegist( nPtr->TimerTx, Time1Sec*60*30);	// retry 30min waiting...
??iRemsFunction_2:
        UXTB     R0,R0
        BL       TimerRegist
//  122 #endif
//  123 			}
//  124 		}
//  125 	}
//  126 	//========================================================================//
//  127 	switch ( iRemsReceiveCheck(nPtr))
??iRemsFunction_0:
        MOV      R0,R4
        BL       iRemsReceiveCheck
        CMP      R0,#+1
        BEQ.N    ??iRemsFunction_3
        CMP      R0,#+2
        BEQ.N    ??iRemsFunction_4
        POP      {R4-R6,PC}
//  128 	{
//  129 		case 1:
//  130 			if(iRemsRecieveNMS(nPtr))
??iRemsFunction_3:
        MOV      R0,R4
        BL       iRemsRecieveNMS
        CMP      R0,#+0
        BEQ.N    ??iRemsFunction_5
//  131 			{
//  132 				iRemsComCheck(nPtr);
        MOV      R0,R4
        POP      {R4-R6,LR}
        B.N      iRemsComCheck
//  133 			}
//  134 		break;
//  135 		
//  136 		case 2:
//  137 			if(iRemsRecieveACK(nPtr)) 	iRemsDownloadFunc(nPtr);
??iRemsFunction_4:
        MOV      R0,R4
        BL       iRemsRecieveACK
        CMP      R0,#+0
        ITT      NE 
        MOVNE    R0,R4
        BLNE     iRemsDownloadFunc
//  138 		break;
//  139 
//  140 		case 3:
//  141 		break;
//  142 	}
//  143 	//========================================================================//
//  144 }
??iRemsFunction_5:
        POP      {R4-R6,PC}       ;; return
//  145 
//  146 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  147 void iRemsResetFunc(__IRemsPtr *nPtr)
//  148 {
iRemsResetFunc:
        PUSH     {R4-R6,LR}
        MOV      R5,R0
//  149 	//=============//
//  150 	// Modem Reset //
//  151 	//========================================================================//
//  152 	if(Booting[nPtr->chan] == 0xff )
        ADDW     R6,R5,#+28
        LDR.W    R4,??DataTable13_8
        LDRB     R0,[R6, #+20]
        LDRB     R0,[R0, R4]
        CMP      R0,#+255
        BNE.N    ??iRemsResetFunc_0
//  153 	{
//  154 		ModemCommand("AT$KTFRESET", nPtr);
        MOV      R1,R5
        LDR.W    R0,??DataTable13_11
        BL       ModemCommand
//  155 
//  156 		iRemsReset(nPtr);
        MOV      R0,R5
        BL       iRemsReset
//  157 
//  158 		TimerRegist( nPtr->TimerTx, Time1Sec*60);
        MOVW     R1,#+60000
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimerRegist
//  159 		ModemRstCnt[nPtr->chan] = 0;
        LDRB     R0,[R6, #+20]
        LDR.W    R1,??DataTable13_7
        MOVS     R2,#+0
        STRB     R2,[R0, R1]
//  160 		Booting[nPtr->chan] = 0;
        LDRB     R0,[R6, #+20]
        STRB     R2,[R0, R4]
//  161 	}
//  162 }
??iRemsResetFunc_0:
        POP      {R4-R6,PC}       ;; return
//  163 
//  164 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  165 INT8U ModemReset(__IRemsPtr *nPtr)
//  166 {
ModemReset:
        PUSH     {R7,LR}
//  167 	ModemCommand("AT$KTFRESET", nPtr);
        MOV      R1,R0
        LDR.W    R0,??DataTable13_11
        BL       ModemCommand
//  168 	return(TRUE);
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  169 }
//  170 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  171 INT8S iRemsReceiveCheck(__IRemsPtr *nPtr)
//  172 {
iRemsReceiveCheck:
        PUSH     {R2-R6,LR}
        MOV      R4,R0
//  173 	INT16U	n, nCnt;
//  174 	INT8U 	RetVal;
//  175 
//  176 	n = 3;
//  177 	if(!nPtr->CheckByte(n, &nCnt)) return(-1);		// 2005-09-01 6:10오후
        ADD      R1,SP,#+4
        MOVS     R0,#+3
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BNE.N    ??iRemsReceiveCheck_0
        MOV      R0,#-1
        POP      {R1,R2,R4-R6,PC}
//  178 
//  179 	//======================//
//  180 	// "$16" or "$FW" check //
//  181 	//=======================================================================//
//  182 	TimerRegist(nPtr->TimerRx, Time1Sec);
??iRemsReceiveCheck_0:
        MOV      R1,#+1000
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimerRegist
//  183 	RetVal = FALSE;
        ADD      R5,SP,#+0
        B.N      ??iRemsReceiveCheck_1
//  184 	
//  185 	while (RetVal == FALSE)
//  186 	{
//  187 		if (TRUE == TimeOverCheck(nPtr->TimerRx))
//  188 		{
//  189 			return FALSE;
//  190 		}
//  191 
//  192 		if (nPtr->CheckByte(n, &nCnt))
//  193 		{
//  194 			INT8U Data[3];
//  195 
//  196 			if( (Data[0] = nPtr->RxGetByte()) == '$')
//  197 			{
//  198 				Data[1] = nPtr->RxGetByte();
//  199 	
//  200 				if(Data[1] == '1' || Data[1] == 'F')
//  201 				{
//  202 					Data[2] = nPtr->RxGetByte();
//  203 
//  204 					     if(Data[1] == '1' && Data[2] == '6') return 1;
//  205 					else if(Data[1] == 'F' && Data[2] == 'W') return 2;
//  206 				}
//  207 			}
//  208 		}
//  209 		else OSTimeDly(100);
??iRemsReceiveCheck_2:
        MOVS     R0,#+100
        BL       OSTimeDly
??iRemsReceiveCheck_1:
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+1
        BNE.N    ??iRemsReceiveCheck_3
        MOVS     R0,#+0
        POP      {R1,R2,R4-R6,PC}
??iRemsReceiveCheck_3:
        ADD      R1,SP,#+4
        MOVS     R0,#+3
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??iRemsReceiveCheck_2
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[SP, #+0]
        LDRB     R0,[SP, #+0]
        CMP      R0,#+36
        BNE.N    ??iRemsReceiveCheck_1
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+1]
        LDRB     R6,[R5, #+1]
        CMP      R6,#+49
        BEQ.N    ??iRemsReceiveCheck_4
        CMP      R6,#+70
        BNE.N    ??iRemsReceiveCheck_1
??iRemsReceiveCheck_4:
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+2]
        CMP      R6,#+49
        BNE.N    ??iRemsReceiveCheck_5
        LDRB     R0,[R5, #+2]
        CMP      R0,#+54
        BNE.N    ??iRemsReceiveCheck_1
        MOVS     R0,#+1
        POP      {R1,R2,R4-R6,PC}
??iRemsReceiveCheck_5:
        CMP      R6,#+70
        BNE.N    ??iRemsReceiveCheck_1
        LDRB     R0,[R5, #+2]
        CMP      R0,#+87
        BNE.N    ??iRemsReceiveCheck_1
        MOVS     R0,#+2
        POP      {R1,R2,R4-R6,PC}  ;; return
//  210 	}
//  211 	return(-1);
//  212 
//  213 }
//  214 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  215 INT8U iRemsRecieveNMS(__IRemsPtr *nPtr)
//  216 {
iRemsRecieveNMS:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
//  217 	INT16U	i = 0, n = 0, nCnt = 0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//  218 	INT8U BuffH, BuffL;
//  219 
//  220 	RMS *Recv = nPtr->Recv;
        LDR      R5,[R4, #+40]
//  221 
//  222 	Recv->Command = NODATA;		/* RX Command Clear */
        MOVS     R0,#+205
        STRB     R0,[R5, #+2]
//  223 
//  224 	//====================//
//  225 	// Sync Check 2 bytes //
//  226 	//======================================================================//
//  227 	n = 2;
//  228 
//  229 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimerRegist
        B.N      ??iRemsRecieveNMS_0
//  230 	
//  231 	while(!nPtr->CheckByte(n, &nCnt))
//  232 	{
//  233 		if (TRUE == TimeOverCheck(nPtr->TimerRx) ) return(FALSE);
//  234 		OSTimeDly(100L);
??iRemsRecieveNMS_1:
        MOVS     R0,#+100
        BL       OSTimeDly
??iRemsRecieveNMS_0:
        ADD      R1,SP,#+0
        MOVS     R0,#+2
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ.N   R0,??iRemsRecieveNMS_2
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+1
        BNE.N    ??iRemsRecieveNMS_1
??iRemsRecieveNMS_3:
        MOVS     R0,#+0
        B.N      ??iRemsRecieveNMS_4
//  235 	}
//  236 	
//  237 	if ( !(('1' == nPtr->RxGetByte())&&('6' == nPtr->RxGetByte())) ) return FALSE;
??iRemsRecieveNMS_2:
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+49
        BNE.N    ??iRemsRecieveNMS_3
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+54
        BNE.N    ??iRemsRecieveNMS_3
//  238 	
//  239 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimerRegist
//  240 
//  241 	//======================//
//  242 	// Header Check 6 bytes //
//  243 	//======================================================================//
//  244 	n = 6;
        B.N      ??iRemsRecieveNMS_5
//  245 	while (!nPtr->CheckByte(n, &nCnt))
//  246 	{
//  247 		if (TRUE == TimeOverCheck(nPtr->TimerRx) ) return(FALSE);
//  248 		OSTimeDly(100L);
??iRemsRecieveNMS_6:
        MOVS     R0,#+100
        BL       OSTimeDly
??iRemsRecieveNMS_5:
        ADD      R1,SP,#+0
        MOVS     R0,#+6
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ.N   R0,??iRemsRecieveNMS_7
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+1
        BNE.N    ??iRemsRecieveNMS_6
??iRemsRecieveNMS_8:
        B.N      ??iRemsRecieveNMS_3
//  249 	}
//  250 
//  251 	BuffH = nPtr->RxGetByte();
??iRemsRecieveNMS_7:
        LDR      R0,[R4, #+4]
        BLX      R0
        MOV      R6,R0
//  252 	BuffL = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
//  253 	Recv->Command = Ascii2Hex(BuffL, BuffH);
        UXTB     R1,R6
        UXTB     R0,R0
        BL       Ascii2Hex
        STRB     R0,[R5, #+2]
//  254 	BuffH = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        MOV      R7,R0
//  255 	BuffL = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
//  256 	Recv->RCode = Ascii2Hex(BuffL, BuffH);
        ADDS     R6,R5,#+2
        UXTB     R1,R7
        UXTB     R0,R0
        BL       Ascii2Hex
        STRB     R0,[R6, #+1]
//  257 	BuffH = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        MOV      R7,R0
//  258 	BuffL = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
//  259 	Recv->DataLength = Ascii2Hex(BuffL, BuffH);
        UXTB     R1,R7
        UXTB     R0,R0
        BL       Ascii2Hex
        STRB     R0,[R6, #+2]
//  260 
//  261 	//====================//
//  262 	// Data Check n bytes //
//  263 	//======================================================================//
//  264 	n =  2 * Recv->DataLength;
        LSLS     R7,R0,#+1
//  265 	
//  266 	if ( n > RMSrxdNO ) return(FALSE);
        CMP      R7,#+255
        BLE.N    ??iRemsRecieveNMS_9
        B.N      ??iRemsRecieveNMS_3
//  267 	while ( !nPtr->CheckByte( n+4, &nCnt) )
//  268 	{
//  269 		if (TRUE == TimeOverCheck(nPtr->TimerRx) ) return(FALSE);
//  270 		OSTimeDly(100L);
??iRemsRecieveNMS_10:
        MOVS     R0,#+100
        BL       OSTimeDly
??iRemsRecieveNMS_9:
        ADD      R1,SP,#+0
        ADDS     R0,R7,#+4
        UXTH     R0,R0
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ.N   R0,??iRemsRecieveNMS_11
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+1
        BNE.N    ??iRemsRecieveNMS_10
        B.N      ??iRemsRecieveNMS_3
//  271 	}
//  272 	n = Recv->DataLength;
??iRemsRecieveNMS_11:
        LDRB     R7,[R6, #+2]
//  273 
//  274 	for(i = 0; i < n+2; i++ )
        MOV      R8,#+0
        ADD      R9,R7,#+2
//  275 	{
//  276 		BuffH = nPtr->RxGetByte();
??iRemsRecieveNMS_12:
        LDR      R0,[R4, #+4]
        BLX      R0
        MOV      R10,R0
//  277 		BuffL = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
//  278 		Recv->Data[i] = Ascii2Hex(BuffL,BuffH);
        UXTB     R1,R10
        UXTB     R0,R0
        BL       Ascii2Hex
        ADD      R1,R8,R5
        STRB     R0,[R1, #+5]
//  279 	}
        ADD      R0,R8,#+1
        UXTH     R8,R0
        CMP      R8,R9
        BLT.N    ??iRemsRecieveNMS_12
//  280 
//  281 	//===========//
//  282 	// CRC Check //
//  283 	{
//  284 		//======================================================================//
//  285 		INT8U CrcHigh = Recv->Data[n+0];
        ADDS     R0,R7,R5
        LDRB     R4,[R0, #+5]
//  286 		INT8U CrcLow = Recv->Data[n+1];
        LDRB     R8,[R0, #+6]
//  287 		Recv->Crc = Crc16Calc ( &(Recv->Command), n + 3 , NULL);
        MOVS     R2,#+0
        ADDS     R1,R7,#+3
        MOV      R0,R6
        BL       Crc16Calc
        STRH     R0,[R5, #+262]
//  288 
//  289 		Recv->CrcErr	= TRUE;
        ADDW     R0,R5,#+262
        MOVS     R1,#+1
        STRB     R1,[R0, #+2]
//  290 		if ( (INT8U)(Recv->Crc >> 8 & 0xff)	!= CrcHigh ) Recv->CrcErr = FALSE;
        LDRH     R1,[R5, #+262]
        LSRS     R1,R1,#+8
        CMP      R1,R4
        ITT      NE 
        MOVNE    R1,#+0
        STRBNE   R1,[R0, #+2]
//  291 		if ( (INT8U)(Recv->Crc >> 0 & 0xff)	!= CrcLow  ) Recv->CrcErr = FALSE;
        LDRB     R1,[R5, #+262]
        CMP      R1,R8
        ITT      NE 
        MOVNE    R1,#+0
        STRBNE   R1,[R0, #+2]
//  292 		if ( Recv->CrcErr == FALSE )
        LDRB     R1,[R0, #+2]
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  293 		{
//  294 			return FALSE;
??iRemsRecieveNMS_4:
        POP      {R1,R2,R4-R10,PC}  ;; return
//  295 		}
//  296 	}
//  297 	
//  298 	return TRUE;
//  299 
//  300 }
//  301 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  302 void iRemsComCheck(__IRemsPtr *nPtr)
//  303 {
iRemsComCheck:
        PUSH     {R4,LR}
        MOV      R4,R0
//  304 	RMS *Recv = nPtr->Recv;
        LDR      R0,[R4, #+40]
//  305 
//  306 	switch(Recv->Command)
        LDRB     R1,[R0, #+2]
        CBZ.N    R1,??iRemsComCheck_0
        CMP      R1,#+2
        BEQ.N    ??iRemsComCheck_1
        BCC.N    ??iRemsComCheck_2
        POP      {R4,PC}
//  307 	{
//  308 		case MStatusRQST:
//  309 			iRemsStatusUpdate();
??iRemsComCheck_0:
        BL       iRemsStatusUpdate
//  310 			iRemsDataAckTx((INT8U*)iRemsStatus, sizeof(IREMSSTATUS), MStatusRSPS, nPtr);
        MOV      R3,R4
        MOVS     R2,#+112
??iRemsComCheck_3:
        MOVS     R1,#+30
        LDR.W    R0,??DataTable13
        LDR      R0,[R0, #+112]
        POP      {R4,LR}
        B.N      iRemsDataAckTx
//  311 		break;
//  312 
//  313 		case MControlRQST:
//  314 			
//  315 			iRemsSetDataCopy((IREMSCONTROL *)Recv->Data);
??iRemsComCheck_2:
        ADDS     R0,R0,#+5
        BL       iRemsSetDataCopy
//  316 			iRemsDataAckTx((INT8U*)iRemsStatus, sizeof(IREMSSTATUS), MControlRSPS, nPtr);
        MOV      R3,R4
        MOVS     R2,#+113
        B.N      ??iRemsComCheck_3
//  317 		break;
//  318 
//  319 		case MResetRQST:
//  320 			iRemsDataAckTx((INT8U*)"", NULL, MControlRSPS, nPtr);
??iRemsComCheck_1:
        MOV      R3,R4
        MOVS     R2,#+113
        MOVS     R1,#+0
        ADR.N    R0,??DataTable7  ;; ""
        BL       iRemsDataAckTx
//  321 		
//  322 			OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
//  323 			ResetCaseBackup(1);
        MOVS     R0,#+1
        BL       ResetCaseBackup
//  324 			DownLoadBootingJump();
        POP      {R4,LR}
        B.W      DownLoadBootingJump
//  325 		break;
//  326 	}
//  327 }
//  328 
//  329 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  330 INT8U iRemsRecieveACK(__IRemsPtr *nPtr)
//  331 {
iRemsRecieveACK:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
//  332 	INT16U DataCnt=0;
        MOVS     R5,#+0
//  333     INT16U nCnt = 0;
        STRH     R5,[SP, #+0]
//  334     
//  335 	TimerRegist(nPtr->TimerRx, Time1Sec*2);
        MOV      R1,#+2000
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimerRegist
        LDR.W    R6,??DataTable14
        B.N      ??iRemsRecieveACK_0
//  336 
//  337 	while(1)
//  338     {
//  339 		while(!nPtr->CheckByte(1, &nCnt))
//  340 		{
//  341 			if(TimeOverCheck(nPtr->TimerRx)) return FALSE;
//  342 			OSTimeDly(100L);
??iRemsRecieveACK_1:
        MOVS     R0,#+100
        BL       OSTimeDly
??iRemsRecieveACK_0:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ.N   R0,??iRemsRecieveACK_2
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??iRemsRecieveACK_1
??iRemsRecieveACK_3:
        MOVS     R0,#+0
        POP      {R1,R2,R4-R6,PC}  ;; return
//  343 	    }
//  344 		
//  345 		DataBuff[DataCnt] = nPtr->RxGetByte();
??iRemsRecieveACK_2:
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, R6]
//  346 
//  347 		if((DataCnt == 0) && ( (DataBuff[DataCnt] == 0x0d) || ( DataBuff[DataCnt] == 0x0a)) ) continue;
        CBNZ.N   R5,??iRemsRecieveACK_4
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BEQ.N    ??iRemsRecieveACK_0
        CMP      R0,#+10
        BEQ.N    ??iRemsRecieveACK_0
//  348 
//  349 		if(DataBuff[DataCnt++] == 0x0d )
??iRemsRecieveACK_4:
        MOV      R0,R5
        ADDS     R5,R0,#+1
        UXTH     R5,R5
        LDRB     R0,[R0, R6]
        CMP      R0,#+13
        BNE.N    ??iRemsRecieveACK_5
//  350 		{
//  351 			DataBuff[DataCnt++] = 0x0a;
        MOVS     R0,#+10
        STRB     R0,[R5, R6]
//  352 			DataBuffLength = DataCnt;
        ADDS     R0,R5,#+1
        LDR.W    R1,??DataTable14_1
        STRH     R0,[R1, #+0]
//  353 
//  354 			return TRUE;
        MOVS     R0,#+1
        POP      {R1,R2,R4-R6,PC}
//  355 		}
//  356 		if ( DataCnt >= DataBuff_MAX ) break;
??iRemsRecieveACK_5:
        MOV      R0,#+520
        CMP      R5,R0
        BLT.N    ??iRemsRecieveACK_0
        B.N      ??iRemsRecieveACK_3
//  357     }
//  358 	
//  359 	return(FALSE);
//  360 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC8      "",0x0,0x0,0x0
//  361 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  362 void iRemsDownloadFunc(__IRemsPtr *nPtr)
//  363 {
iRemsDownloadFunc:
        PUSH     {R3-R11,LR}
        MOV      R8,R0
//  364 	INT16U i = 0, cnt = 0, TempIndex = 0;
//  365 	INT8U BuffH, BuffL;
//  366 	RMS *Recv = nPtr->Recv;
        LDR      R9,[R8, #+40]
//  367 
//  368 	DownLoadGiveupTimerSet((INT32U)nPtr);
        BL       DownLoadGiveupTimerSet
//  369 
//  370 	//======================================================================//
//  371 	// Command Check														//
//  372 	//======================================================================//
//  373 	if(!strncmp("DLOAD",(char *)DataBuff, 5))
        LDR.W    R10,??DataTable14_2
        LDR.W    R7,??DataTable14
        MOVS     R2,#+5
        MOV      R1,R7
        ADD      R0,R10,#+128
        BL       strncmp
        CBNZ.N   R0,??iRemsDownloadFunc_0
//  374 	{
//  375 		if(FLASHpAPBK_Check_Erase()){
        BL       FLASHpAPBK_Check_Erase
        CMP      R0,#+0
        BEQ.W    ??iRemsDownloadFunc_1
//  376 			OSTimeDly(10);
        MOVS     R0,#+10
        BL       OSTimeDly
//  377 			ModemCommand("AT$FWINFO?", nPtr);
        MOV      R1,R8
        MOV      R0,R10
        BL       ModemCommand
        B.N      ??iRemsDownloadFunc_1
//  378 		}
//  379 	}
//  380 	else if( !strncmp("INFO:",(char *)DataBuff,5))
??iRemsDownloadFunc_0:
        MOVS     R2,#+5
        MOV      R1,R7
        ADD      R0,R10,#+120
        BL       strncmp
        CMP      R0,#+0
        BNE.W    ??iRemsDownloadFunc_2
//  381 	{
//  382 		// Receive File Infomation //
//  383 		//=====================================================//
//  384 		cnt = 5;
        MOVS     R0,#+5
//  385 		for(i = 0; i < 8; i++) FileName[i] = DataBuff[cnt++];
        LDR.W    R4,??DataTable14_3
        ADDS     R1,R4,#+4
        ADDW     R2,R7,#+5
        MOVS     R3,#+2
??iRemsDownloadFunc_3:
        LDRB     R5,[R2], #+1
        STRB     R5,[R1], #+1
        LDRB     R5,[R2], #+1
        STRB     R5,[R1], #+1
        LDRB     R5,[R2], #+1
        STRB     R5,[R1], #+1
        LDRB     R5,[R2], #+1
        STRB     R5,[R1], #+1
        ADDS     R0,R0,#+4
        UXTH     R0,R0
        SUBS     R3,R3,#+1
        BNE.N    ??iRemsDownloadFunc_3
//  386 
//  387 		DataBuff[cnt++];							// ','
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  388 
//  389 		FileSize  = (DataBuff[cnt++]&0x0f)*100000L;
        LDRB     R1,[R0, R7]
        AND      R1,R1,#0xF
        LDR.W    R2,??DataTable14_4  ;; 0x186a0
        MULS     R1,R2,R1
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  390 		FileSize += (DataBuff[cnt++]&0x0f)*10000L;
        LDRB     R2,[R0, R7]
        AND      R2,R2,#0xF
        MOVW     R3,#+10000
        MLA      R1,R3,R2,R1
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  391 		FileSize += (DataBuff[cnt++]&0x0f)*1000L;
        LDRB     R2,[R0, R7]
        AND      R2,R2,#0xF
        MOV      R3,#+1000
        MLA      R1,R3,R2,R1
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  392 		FileSize += (DataBuff[cnt++]&0x0f)*100L;
        LDRB     R2,[R0, R7]
        AND      R2,R2,#0xF
        MOVS     R3,#+100
        MLA      R1,R3,R2,R1
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     R2,[R0, R7]
        AND      R2,R2,#0xF
        ADD      R3,R2,R2, LSL #+2
        ADD      R1,R1,R3, LSL #+1
        STR      R1,[R4, #+28]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  393 		FileSize += (DataBuff[cnt++]&0x0f)*10L;
//  394 		FileSize += (DataBuff[cnt++]&0x0f)*1L;
        LDRB     R2,[R0, R7]
        AND      R2,R2,#0xF
        ADD      R9,R2,R1
        STR      R9,[R4, #+28]
//  395 
//  396 		DataBuff[cnt++];							// ','
        ADDS     R0,R0,#+2
        UXTH     R0,R0
//  397 
//  398 		BuffH = DataBuff[cnt++];
        LDRB     R1,[R0, R7]
        ADDS     R2,R0,#+1
        UXTH     R2,R2
//  399 		BuffL = DataBuff[cnt++];
        LDRB     R0,[R2, R7]
        ADDS     R2,R2,#+1
        UXTH     R5,R2
//  400 
//  401 		iRemsTotalCrc = Ascii2Hex(BuffL, BuffH);
        BL       Ascii2Hex
        STRH     R0,[R4, #+16]
//  402 
//  403 		BuffH = DataBuff[cnt++];
//  404 		BuffL = DataBuff[cnt++];
//  405 
//  406 		iRemsTotalCrc = (iRemsTotalCrc << 8) + Ascii2Hex(BuffL,BuffH);
        MOV      R6,R0
        LDRB     R1,[R5, R7]
        ADDS     R0,R5,#+1
        UXTH     R0,R0
        LDRB     R0,[R0, R7]
        BL       Ascii2Hex
        ADD      R0,R0,R6, LSL #+8
        STRH     R0,[R4, #+16]
//  407 		iRemsFrameCount = FileSize/248;
        MOVS     R0,#+248
        UDIV     R1,R9,R0
        MOV      R2,R1
//  408 		iRemsFrameLastC = FileSize%248;
        MLS      R0,R0,R1,R9
        STRH     R0,[R4, #+20]
//  409 		if(iRemsFrameLastC) iRemsFrameCount++;
        LDRH     R0,[R4, #+20]
        CBZ.N    R0,??iRemsDownloadFunc_4
        ADDS     R2,R2,#+1
??iRemsDownloadFunc_4:
        STRH     R2,[R4, #+18]
//  410 
//  411 		// Long Firmware
//  412 		//=====================================================//
//  413 		if(FileSize >= 102400L)		// 100K UNDER.
        CMP      R9,#+102400
        BCC.N    ??iRemsDownloadFunc_5
//  414 		{
//  415 			ModemCommand("AT$FWEND=7", nPtr);
??iRemsDownloadFunc_6:
        MOV      R1,R8
        ADD      R0,R10,#+12
        B.N      ??iRemsDownloadFunc_7
//  416 			ResetStart(Time1Min);
//  417 			return;
//  418 		}
//  419 
//  420 		// File Name Check //
//  421 		//=====================================================//
//  422 		{
//  423 			char *ptr;
//  424 			if(MainStatus->TransceiveMaker == ACE) ptr = JMAtrixACE;
??iRemsDownloadFunc_5:
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??iRemsDownloadFunc_8
        ADD      R1,R10,#+24
        B.N      ??iRemsDownloadFunc_9
//  425 			if(MainStatus->TransceiveMaker == DONGWON) ptr = JMAtrixDONGWON;
??iRemsDownloadFunc_8:
        CMP      R0,#+3
        IT       EQ 
        ADDWEQ   R1,R10,#+36
        BEQ.N    ??iRemsDownloadFunc_9
//  426 			if(MainStatus->TransceiveMaker == FRTEK) ptr = JMAtrixFRTEK;
        CMP      R0,#+4
        IT       EQ 
        ADDWEQ   R1,R10,#+48
        BEQ.N    ??iRemsDownloadFunc_9
//  427 			if(MainStatus->TransceiveMaker == GTNT) ptr = JMAtrixGTNT;
        CMP      R0,#+5
        BEQ.N    ??iRemsDownloadFunc_10
//  428 			if(MainStatus->TransceiveMaker == YOUNGWOO) ptr = JMAtrixGTNT;
        CMP      R0,#+7
        BNE.N    ??iRemsDownloadFunc_9
??iRemsDownloadFunc_10:
        ADDW     R1,R10,#+60
//  429 
//  430 			if ( strncmp(FileName, ptr, 4))
??iRemsDownloadFunc_9:
        MOVS     R2,#+4
        ADDS     R0,R4,#+4
        BL       strncmp
        CBZ.N    R0,??iRemsDownloadFunc_11
//  431 			{
//  432 				ModemCommand("AT$FWEND=2", nPtr);
        MOV      R1,R8
        ADD      R0,R10,#+72
        BL       ModemCommand
//  433 				DownRstFlag[nPtr->chan] = 0;
        ADD      R0,R8,#+40
        LDRB     R0,[R0, #+8]
        ADDS     R0,R0,R4
        MOVS     R1,#+0
        STRB     R1,[R0, #+2]
//  434 				ResetStart(Time1Min);
        B.N      ??iRemsDownloadFunc_12
//  435 				return;
//  436 			}
//  437 		}
//  438 		// Data Request //
//  439 		//=====================================================//
//  440 		iRemsFrameIndex = 0;
??iRemsDownloadFunc_11:
        STRH     R0,[R4, #+22]
//  441 		iRemsFrameRetry = 0;
        STRB     R0,[R4, #+0]
//  442 		iRemsSwcrc16 = 0x0000;
        STRH     R0,[R4, #+24]
//  443 		iRemsDataCount = 0;
        STR      R0,[R4, #+32]
//  444 		FrameRequest(iRemsFrameIndex, nPtr);
        MOV      R1,R8
??iRemsDownloadFunc_13:
        BL       FrameRequest
        B.N      ??iRemsDownloadFunc_1
//  445 	}
//  446 	else if ( !strncmp("RD:",(char *)DataBuff,3) )
??iRemsDownloadFunc_2:
        MOVS     R2,#+3
        MOV      R1,R7
        ADR.N    R0,??DataTable9  ;; "RD:"
        BL       strncmp
        CMP      R0,#+0
        BNE.W    ??iRemsDownloadFunc_1
//  447 	{
//  448 		// Receive Data //
//  449 		//=====================================================//
//  450 		cnt = 3;
//  451 		TempIndex  = (DataBuff[cnt++]&0x0f)*1000L;
//  452 		TempIndex += (DataBuff[cnt++]&0x0f)*100L;
//  453 		TempIndex += (DataBuff[cnt++]&0x0f)*10L;
//  454 		TempIndex += (DataBuff[cnt++]&0x0f)*1L;
        LDRB     R0,[R7, #+3]
        AND      R0,R0,#0xF
        MOV      R1,#+1000
        LDRB     R2,[R7, #+4]
        AND      R2,R2,#0xF
        MOVS     R3,#+100
        MULS     R2,R3,R2
        MLA      R0,R1,R0,R2
        LDRB     R1,[R7, #+5]
        AND      R1,R1,#0xF
        ADD      R2,R1,R1, LSL #+2
        ADD      R0,R0,R2, LSL #+1
        LDRB     R1,[R7, #+6]
        AND      R1,R1,#0xF
        ADDS     R0,R1,R0
        UXTH     R0,R0
        MOVS     R5,#+7
//  455 
//  456 		if(TempIndex != iRemsFrameIndex)
        LDR.W    R4,??DataTable14_3
        LDRH     R1,[R4, #+22]
        CMP      R0,R1
        BEQ.N    ??iRemsDownloadFunc_14
//  457 		{
//  458 			iRemsFrameRetry++;
        LDRB     R0,[R4, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+0]
//  459 		}
//  460 		else
//  461 		{
//  462 			if(TempIndex == 0) // first frame
//  463 			{
//  464 				for(i = 0; i < 248; i++ )
//  465 				{
//  466 					BuffH = DataBuff[cnt++];
//  467 					BuffL = DataBuff[cnt++];
//  468 					Recv->Data[i] = Ascii2Hex(BuffL, BuffH);
//  469 				}
//  470 				
//  471 				// String Check Load //
//  472 				{
//  473 					INT32U *tmp = (INT32U *)Recv->Data;
//  474 
//  475 					if(tmp[7] != (INT32U)_pilog)
//  476 					{
//  477 						ModemCommand("AT$FWEND=7", nPtr);
//  478 						ResetStart(Time1Min);
//  479 						return;
//  480 					}
//  481 				}
//  482 			}
//  483 			else if(TempIndex < iRemsFrameCount - 1)				// middle frame
//  484 			{
//  485 				for(i = 0; i < 248; i++ )
//  486 				{
//  487 					BuffH = DataBuff[cnt++];
//  488 					BuffL = DataBuff[cnt++];
//  489 					Recv->Data[i] = Ascii2Hex(BuffL,BuffH);
//  490 				}
//  491 			}
//  492 			else										// final frame
//  493 			{
//  494 				for(i = 0; i < iRemsFrameLastC; i++ )
//  495 				{
//  496 					BuffH = DataBuff[cnt++];
//  497 					BuffL = DataBuff[cnt++];
//  498 					Recv->Data[i] = Ascii2Hex(BuffL,BuffH);
//  499 				}
//  500 			}
//  501 			// CRC Check //
//  502 			//====================================================================//
//  503 			BuffH = DataBuff[cnt++];
//  504 			BuffL = DataBuff[cnt++];
//  505 	 		Recv->Data[i++] = Ascii2Hex(BuffL,BuffH);
//  506 			BuffH = DataBuff[cnt++];
//  507 			BuffL = DataBuff[cnt++];
//  508 	 		Recv->Data[i++] = Ascii2Hex(BuffL,BuffH);
//  509 			Recv->Crc = Crc16Calc (Recv->Data, i-2, NULL);
//  510 			Recv->CrcErr = TRUE;
//  511 
//  512 			if( (INT8U)((Recv->Crc >> 8) & 0xff) != Recv->Data[i-2] ) Recv->CrcErr = FALSE;
//  513 			if( (INT8U)((Recv->Crc >> 0) & 0xff) != Recv->Data[i-1] ) Recv->CrcErr = FALSE;
//  514 
//  515 			if ( Recv->CrcErr == TRUE ) iRemsFrameRetry = 0;
//  516 			else 						iRemsFrameRetry++;
//  517 
//  518 			// Data Store //
//  519 			//====================================================================//
//  520 			if(iRemsFrameRetry == 0 )
//  521 			{
//  522 				INT32S err = iRemsDataCount = UpLoadData(__pAPBKAddr, (INT8U *)&Recv->Data[0], i-2, iRemsDataCount);
//  523 
//  524 				iRemsSwcrc16 = Crc16Calc((INT8U*)&Recv->Data[0], i-2, iRemsSwcrc16);
//  525 				
//  526 				if(err == -1) iRemsFrameRetry = 10;			
//  527 			}
//  528 		}
//  529 
//  530 		{
//  531 			if(iRemsFrameRetry == 0)					// Next Frame Send
??iRemsDownloadFunc_15:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BNE.W    ??iRemsDownloadFunc_16
//  532 			{
//  533 				if(iRemsFrameIndex < iRemsFrameCount -1)
        LDRH     R0,[R4, #+22]
        LDRH     R1,[R4, #+18]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BGE.W    ??iRemsDownloadFunc_17
//  534 				{
//  535 					FrameRequest(++iRemsFrameIndex, nPtr);
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+22]
        MOV      R1,R8
        UXTH     R0,R0
        B.N      ??iRemsDownloadFunc_13
//  536 				}
??iRemsDownloadFunc_14:
        CBNZ.N   R0,??iRemsDownloadFunc_18
        MOVS     R6,#+0
        STR      R9,[SP, #+0]
        ADDW     R11,R7,#+7
??iRemsDownloadFunc_19:
        ADDS     R0,R5,#+2
        UXTH     R5,R0
        LDRB     R1,[R11, #+0]
        LDRB     R0,[R11, #+1]
        BL       Ascii2Hex
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+5]
        ADDS     R6,R6,#+1
        ADD      R11,R11,#+2
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
        CMP      R6,#+248
        BLT.N    ??iRemsDownloadFunc_19
        LDR      R0,[R9, #+33]
        LDR.W    R1,??DataTable14_6  ;; 0x4c4f5049
        CMP      R0,R1
        BNE.W    ??iRemsDownloadFunc_6
        B.N      ??iRemsDownloadFunc_20
??iRemsDownloadFunc_18:
        LDRH     R1,[R4, #+18]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BGE.N    ??iRemsDownloadFunc_21
        MOVS     R6,#+0
        STR      R9,[SP, #+0]
        ADDW     R11,R7,#+7
??iRemsDownloadFunc_22:
        ADDS     R0,R5,#+2
        UXTH     R5,R0
        LDRB     R1,[R11, #+0]
        LDRB     R0,[R11, #+1]
        BL       Ascii2Hex
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+5]
        ADDS     R6,R6,#+1
        ADD      R11,R11,#+2
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
        CMP      R6,#+248
        BLT.N    ??iRemsDownloadFunc_22
        B.N      ??iRemsDownloadFunc_20
??iRemsDownloadFunc_21:
        MOVS     R6,#+0
        STR      R9,[SP, #+0]
        ADDW     R11,R7,#+7
        LDRH     R0,[R4, #+20]
        CMP      R0,#+1
        BLT.N    ??iRemsDownloadFunc_20
??iRemsDownloadFunc_23:
        ADDS     R0,R5,#+2
        UXTH     R5,R0
        LDRB     R1,[R11, #+0]
        LDRB     R0,[R11, #+1]
        BL       Ascii2Hex
        LDR      R1,[SP, #+0]
        STRB     R0,[R1, #+5]
        ADDS     R0,R6,#+1
        UXTH     R6,R0
        ADD      R11,R11,#+2
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
        LDRH     R0,[R4, #+20]
        CMP      R6,R0
        BLT.N    ??iRemsDownloadFunc_23
??iRemsDownloadFunc_20:
        LDRB     R1,[R5, R7]
        ADDS     R2,R5,#+1
        UXTH     R2,R2
        LDRB     R0,[R2, R7]
        ADDS     R2,R2,#+1
        UXTH     R5,R2
        BL       Ascii2Hex
        ADD      R1,R6,R9
        STRB     R0,[R1, #+5]
        ADDS     R0,R6,#+1
        UXTH     R6,R0
        LDRB     R1,[R5, R7]
        ADDS     R0,R5,#+1
        UXTH     R0,R0
        LDRB     R0,[R0, R7]
        BL       Ascii2Hex
        ADD      R1,R6,R9
        STRB     R0,[R1, #+5]
        ADDS     R0,R6,#+1
        UXTH     R6,R0
        SUBS     R7,R6,#+2
        MOVS     R2,#+0
        MOV      R1,R7
        ADD      R0,R9,#+5
        BL       Crc16Calc
        STRH     R0,[R9, #+262]
        ADDW     R0,R9,#+262
        MOVS     R1,#+1
        STRB     R1,[R0, #+2]
        ADD      R1,R6,R9
        LDRH     R2,[R9, #+262]
        LSRS     R2,R2,#+8
        LDRB     R3,[R1, #+3]
        CMP      R2,R3
        ITT      NE 
        MOVNE    R2,#+0
        STRBNE   R2,[R0, #+2]
        LDRH     R2,[R9, #+262]
        LDRB     R1,[R1, #+4]
        UXTB     R2,R2
        CMP      R2,R1
        ITT      NE 
        MOVNE    R1,#+0
        STRBNE   R1,[R0, #+2]
        LDRB     R0,[R0, #+2]
        CMP      R0,#+1
        ITT      EQ 
        MOVEQ    R0,#+0
        STRBEQ   R0,[R4, #+0]
        BEQ.N    ??iRemsDownloadFunc_24
        LDRB     R0,[R4, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+0]
        UXTB     R0,R0
        CMP      R0,#+0
        BNE.W    ??iRemsDownloadFunc_15
??iRemsDownloadFunc_24:
        LDR.W    R0,??DataTable14_7  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        LDR      R3,[R4, #+32]
        SUBS     R2,R6,#+2
        UXTH     R2,R2
        ADD      R1,R9,#+5
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R5,??DataTable14_8  ;; 0x8007000
        ADD      R0,R5,R0, LSL #+10
        BL       UpLoadData
        MOV      R5,R0
        STR      R5,[R4, #+32]
        LDRH     R2,[R4, #+24]
        MOV      R1,R7
        ADD      R0,R9,#+5
        BL       Crc16Calc
        STRH     R0,[R4, #+24]
        CMN      R5,#+1
        BNE.W    ??iRemsDownloadFunc_15
        MOVS     R0,#+10
        STRB     R0,[R4, #+0]
//  537 				else								// Last Frame Received
//  538 				{				
//  539 					if(iRemsSwcrc16 != iRemsTotalCrc)
//  540 					{
//  541 						ModemCommand("AT$FWEND=3", nPtr);
//  542 						ResetStart(Time1Min);
//  543 						return;
//  544 					}
//  545 					else
//  546 					{
//  547 						{
//  548 #ifdef __EXT_RAM_USED
//  549 							INT32U t = *((INT32U *)(__pAPBK_SRAMAddr + 40));	// jump base addr + selfaddinfo address
//  550 							INT32U s = *((INT32U *)(__pAPBK_SRAMAddr + 36));	// jump base addr!!
//  551 							selfinfo *p = (selfinfo *)(__pAPBK_SRAMAddr + (t-s));
//  552 #else
//  553 							INT32U t = *((INT32U *)(__pAPBKAddr + 40)); // jump base addr + selfaddinfo address
//  554 							INT32U s = *((INT32U *)(__pAPBKAddr + 36)); // jump base addr!!
//  555 							selfinfo *p = (selfinfo *)(__pAPBKAddr + (t-s));
//  556 #endif
//  557 						
//  558 						
//  559 							if(!memcmp(p->infor[0], convinfo.infor[0], strlen(convinfo.infor[0])))
//  560 							{
//  561 							
//  562 								ModemCommand("AT$FWEND=0", nPtr);
//  563 								for(i = 0; i < 20; i++) OSTimeDly(1000L);
//  564 #ifdef __EXT_RAM_USED
//  565 								DownloadFlagSetExtSRAM(iRemsDataCount);
//  566 #else
//  567 								DownloadFlagSet(iRemsDataCount);
//  568 #endif
//  569 								
//  570 								Booting[nPtr->chan] = 0xff;
//  571 								iRemsResetFunc(nPtr);
//  572 								DownLoadBootingJump();
//  573 							}
//  574 							else
//  575 							{
//  576 								ModemCommand("AT$FWEND=7", nPtr);
//  577 
//  578 								ResetStart(Time1Min);
//  579 								return;
//  580 							}
//  581 						}
//  582 					}
//  583 				}
//  584 			}
//  585 			else if(iRemsFrameRetry <= 3)
//  586 			{
//  587 				FrameRequest(iRemsFrameIndex, nPtr);
//  588 			}
//  589 			else
//  590 			{
//  591 				ModemCommand("AT$FWEND=6", nPtr);
??iRemsDownloadFunc_25:
        MOV      R1,R8
        ADD      R0,R10,#+108
??iRemsDownloadFunc_7:
        BL       ModemCommand
//  592 				ResetStart(Time1Min);
??iRemsDownloadFunc_12:
        MOVW     R0,#+60000
        BL       ResetStart
//  593 				return;
??iRemsDownloadFunc_1:
        POP      {R0,R4-R11,PC}   ;; return
//  594 			}
??iRemsDownloadFunc_17:
        LDRH     R0,[R4, #+24]
        LDRH     R1,[R4, #+16]
        CMP      R0,R1
        BEQ.N    ??iRemsDownloadFunc_26
        MOV      R1,R8
        ADD      R0,R10,#+84
        B.N      ??iRemsDownloadFunc_7
??iRemsDownloadFunc_26:
        LDR.W    R0,??DataTable14_7  ;; 0x1ffff7e0
        LDRH     R1,[R0, #+0]
        SUBS     R1,R1,#+28
        LDRH     R2,[R0, #+0]
        SUBS     R2,R2,#+28
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R1,R1,R1, LSR #+31
        ASRS     R1,R1,#+1
        LDR.W    R3,??DataTable14_8  ;; 0x8007000
        ADD      R1,R3,R1, LSL #+10
        ADD      R2,R2,R2, LSR #+31
        ASRS     R2,R2,#+1
        LSLS     R2,R2,#+10
        LDR.W    R3,??DataTable14_9  ;; 0x8007028
        LDR      R2,[R3, R2]
        ADDS     R1,R2,R1
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LSLS     R0,R0,#+10
        LDR.W    R2,??DataTable14_10  ;; 0x8007024
        LDR      R0,[R2, R0]
        SUBS     R6,R1,R0
        LDR.W    R7,??DataTable14_11
        MOV      R0,R7
        BL       strlen
        MOV      R2,R0
        MOV      R1,R7
        MOV      R0,R6
        BL       memcmp
        CMP      R0,#+0
        BNE.W    ??iRemsDownloadFunc_6
        MOV      R1,R8
        ADD      R0,R10,#+96
        BL       ModemCommand
        MOV      R9,#+20
??iRemsDownloadFunc_27:
        MOV      R0,#+1000
        BL       OSTimeDly
        SUBS     R9,R9,#+1
        BNE.N    ??iRemsDownloadFunc_27
        LDR      R0,[R4, #+32]
        BL       DownloadFlagSet
        ADD      R0,R8,#+40
        LDRB     R0,[R0, #+8]
        LDR.W    R1,??DataTable13_8
        MOVS     R2,#+255
        STRB     R2,[R0, R1]
        MOV      R0,R8
        BL       iRemsResetFunc
        BL       DownLoadBootingJump
        B.N      ??iRemsDownloadFunc_1
??iRemsDownloadFunc_16:
        CMP      R0,#+4
        BCS.N    ??iRemsDownloadFunc_25
        MOV      R1,R8
        LDRH     R0,[R4, #+22]
        B.N      ??iRemsDownloadFunc_13
//  595 		}
//  596 	}
//  597 }
//  598 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  599 void FrameRequest(INT16U TempIndex, __IRemsPtr *nPtr)
//  600 {
FrameRequest:
        PUSH     {R4-R7,LR}
        SUB      SP,SP,#+20
//  601 	char  Command[] = "AT$FWRD=1234";
        ADD      R2,SP,#+0
        LDR.W    R3,??DataTable14_12
        LDM      R3!,{R4-R7}
        STM      R2!,{R4-R7}
//  602 
//  603 	Command[8]  = '0' + TempIndex/1000;	TempIndex %= 1000;
        MOV      R2,#+1000
        SDIV     R3,R0,R2
        ADD      R4,R3,#+48
        STRB     R4,[SP, #+8]
        MLS      R0,R2,R3,R0
//  604 	Command[9]  = '0' + TempIndex/100;	TempIndex %= 100;
        UXTH     R0,R0
        MOVS     R2,#+100
        SDIV     R3,R0,R2
        ADD      R4,R3,#+48
        STRB     R4,[SP, #+9]
        MLS      R0,R2,R3,R0
//  605 	Command[10] = '0' + TempIndex/10;	TempIndex %= 10;
        UXTH     R0,R0
        MOVS     R2,#+10
        SDIV     R3,R0,R2
        ADD      R4,R3,#+48
        STRB     R4,[SP, #+10]
//  606 	Command[11] = '0' + TempIndex;
        MLS      R0,R2,R3,R0
        ADDS     R0,R0,#+48
        STRB     R0,[SP, #+11]
//  607 
//  608 	ModemCommand(Command, nPtr);
        ADD      R0,SP,#+0
        BL       ModemCommand
//  609 }
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC8      "RD:"
//  610 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  611 void ModemCommand(char *ptr, __IRemsPtr *nPtr)
//  612 {
ModemCommand:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+56
        MOV      R5,R0
        MOV      R4,R1
//  613 	INT8U i;
//  614 	INT8S Command[50];
//  615 
//  616 	for(i = 0; i < strlen(ptr); i++)
        MOVS     R6,#+0
        ADD      R7,SP,#+0
        MOV      R8,R5
        B.N      ??ModemCommand_0
??ModemCommand_1:
        ADDS     R6,R6,#+1
        UXTB     R6,R6
??ModemCommand_0:
        MOV      R0,R5
        BL       strlen
        CMP      R6,R0
        BCS.N    ??ModemCommand_2
//  617 	{
//  618 		Command[i] = *(ptr+i);
        LDRSB    R0,[R8], #+1
        STRB     R0,[R7], #+1
//  619 		if ( i >= (50-2) ) break;
        CMP      R6,#+48
        BLT.N    ??ModemCommand_1
//  620 	}
//  621 	Command[i++] = 0x0d;
??ModemCommand_2:
        ADD      R0,SP,#+0
        MOVS     R1,#+13
        STRB     R1,[R6, R0]
        ADDS     R1,R6,#+1
        UXTB     R1,R1
//  622 	Command[i++] = 0x0a;
        MOVS     R2,#+10
        STRB     R2,[R1, R0]
//  623 
//  624 	nPtr->PutStr( (INT8U *)Command, i, TRUE);
        MOVS     R2,#+1
        ADDS     R1,R1,#+1
        UXTB     R1,R1
        LDR      R3,[R4, #+8]
        BLX      R3
//  625 }
        ADD      SP,SP,#+56
        POP      {R4-R8,PC}       ;; return
//  626 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  627 INT8U ModemTime(__IRemsPtr *nPtr)
//  628 {
ModemTime:
        PUSH     {R4,LR}
        MOV      R4,R0
//  629 	nPtr->TxClear();
        LDR      R0,[R4, #+12]
        BLX      R0
//  630 	ModemCommand("AT$KTFTIME?", nPtr);
        MOV      R1,R4
        LDR.W    R0,??DataTable14_13
        BL       ModemCommand
//  631 
//  632 	if ( !iRemsRecieveACK(nPtr) ) return(FALSE);
        MOV      R0,R4
        BL       iRemsRecieveACK
        CMP      R0,#+0
        BNE.N    ??ModemTime_0
??ModemTime_1:
        MOVS     R0,#+0
        POP      {R4,PC}
//  633 	if ( !iRemsRecieveACK(nPtr) ) return(FALSE);
??ModemTime_0:
        MOV      R0,R4
        BL       iRemsRecieveACK
        CMP      R0,#+0
        BEQ.N    ??ModemTime_1
//  634 	if ( (DataBuff[0] == 'O')&&(DataBuff[1] == 'K') ) return(TRUE);
        LDR.W    R0,??DataTable14
        LDRB     R1,[R0, #+0]
        CMP      R1,#+79
        BNE.N    ??ModemTime_1
        LDRB     R0,[R0, #+1]
        CMP      R0,#+75
        BNE.N    ??ModemTime_1
        MOVS     R0,#+1
        POP      {R4,PC}          ;; return
//  635 	return(FALSE);
//  636 }
//  637 
//  638 
//  639 

        SECTION `.bss`:DATA:NOROOT(2)
//  640 INT8U MTxBuff[1024];
MTxBuff:
        DS8 1024
//  641 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  642 void iRemsDataAckTx(INT8U *Status, INT8U Count, INT8U Comm, __IRemsPtr *nPtr)
//  643 {
iRemsDataAckTx:
        PUSH     {R3-R9,LR}
        MOV      R8,R1
        MOV      R4,R3
//  644 	INT16U i = 0, cnt = 0;
//  645     
//  646     RMS *Send = nPtr->Send;    
        LDR      R6,[R4, #+44]
//  647 
//  648 	iRemsDataAck(Status, Count, Comm, nPtr);
        BL       iRemsDataAck
//  649 
//  650 	MTxBuff[cnt++] = 'A';
        LDR.W    R5,??DataTable14_14
        MOVS     R0,#+65
        STRB     R0,[R5, #+0]
//  651 	MTxBuff[cnt++] = 'T';
        MOVS     R0,#+84
        STRB     R0,[R5, #+1]
//  652 	MTxBuff[cnt++] = '$';
        MOVS     R0,#+36
        STRB     R0,[R5, #+2]
//  653 	MTxBuff[cnt++] = 'K';
        MOVS     R0,#+75
        STRB     R0,[R5, #+3]
//  654 	MTxBuff[cnt++] = 'T';
        MOVS     R0,#+84
        STRB     R0,[R5, #+4]
//  655 	MTxBuff[cnt++] = 'F';
        MOVS     R0,#+70
        STRB     R0,[R5, #+5]
//  656 	MTxBuff[cnt++] = '=';
        MOVS     R0,#+61
        STRB     R0,[R5, #+6]
//  657 	MTxBuff[cnt++] = '\"';
        MOVS     R0,#+34
        STRB     R0,[R5, #+7]
        MOVS     R7,#+8
//  658 
//  659 	//for(i = 0; i < 5; i++)
//  660 	//{
//  661 	//	MTxBuff[cnt++] = Hex2Ascii( HIGH, *((INT8U *)Send + i) );
//  662 	//	MTxBuff[cnt++] = Hex2Ascii( LOW , *((INT8U *)Send + i) );
//  663 	//}
//  664 	
//  665 	//for(     ; i < Count+5; i++)  MTxBuff[cnt++] = *((INT8U *)Send + i);
//  666 
//  667 	for(i = 0; i < Count+7; i++)
        ADD      R9,R5,#+8
        ADD      R8,R8,#+7
//  668 	{
//  669 		MTxBuff[cnt++] = Hex2Ascii( HIGH, *((INT8U *)Send + i) );
??iRemsDataAckTx_0:
        LDRB     R1,[R6, #+0]
        MOVS     R0,#+1
        BL       Hex2Ascii
        STRB     R0,[R9], #+1
//  670 		MTxBuff[cnt++] = Hex2Ascii( LOW , *((INT8U *)Send + i) );
        LDRB     R1,[R6], #+1
        MOVS     R0,#+2
        BL       Hex2Ascii
        STRB     R0,[R9], #+1
        ADDS     R0,R7,#+2
        UXTH     R7,R0
//  671 	}
        SUBS     R8,R8,#+1
        BNE.N    ??iRemsDataAckTx_0
//  672     
//  673 	MTxBuff[cnt++] = '\"';
        MOVS     R0,#+34
        STRB     R0,[R7, R5]
        ADDS     R0,R7,#+1
        UXTH     R0,R0
//  674 	MTxBuff[cnt++] = 0x0d;
        MOVS     R1,#+13
        STRB     R1,[R0, R5]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  675 	MTxBuff[cnt++] = 0x0a;
        MOVS     R1,#+10
        STRB     R1,[R0, R5]
//  676 
//  677 	nPtr->PutStr((INT8U *)MTxBuff, cnt, TRUE);
        MOVS     R2,#+1
        ADDS     R1,R0,#+1
        UXTH     R1,R1
        MOV      R0,R5
        LDR      R3,[R4, #+8]
        ADD      SP,SP,#+4
        POP      {R4-R9,LR}
        BX       R3
//  678 }
//  679 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  680 void iRemsDataAck(INT8U *Status, INT8U Count, INT8U Comm, __IRemsPtr *nPtr)
//  681 {
iRemsDataAck:
        PUSH     {R3-R5,LR}
        MOV      R5,R1
//  682 	INT16U	i;//, cnt=0;
//  683 
//  684 	RMS *Send = nPtr->Send;
        LDR      R4,[R3, #+44]
//  685 
//  686 	Send->Sync[0]		= STX;
        MOVS     R1,#+22
        STRB     R1,[R4, #+0]
//  687 	Send->Sync[1] 		= STX;
        STRB     R1,[R4, #+1]
//  688 	Send->Command		= Comm;
        STRB     R2,[R4, #+2]
//  689 	if(MainStatus->TransceiveType == SMALL) Send->RCode = 0x02;
        LDR.W    R1,??DataTable14_5
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+5]
        CMP      R1,#+83
        ITE      EQ 
        MOVEQ    R1,#+2
        MOVNE    R1,#+1
//  690 	else									Send->RCode = 0x01;
        STRB     R1,[R4, #+3]
//  691 	
//  692 	Send->DataLength	= Count;
        STRB     R5,[R4, #+4]
//  693 
//  694 	for( i = 0; i < Count; i++ )
        CBZ.N    R5,??iRemsDataAck_0
        MOV      R1,R4
        MOV      R2,R5
//  695 	{
//  696 		Send->Data[i] = *(Status + i);
??iRemsDataAck_1:
        LDRB     R3,[R0], #+1
        STRB     R3,[R1, #+5]
//  697 	}
        ADDS     R1,R1,#+1
        SUBS     R2,R2,#+1
        BNE.N    ??iRemsDataAck_1
//  698 	Send->Crc = Crc16Calc(&Send->Command, Count + 3, NULL);
??iRemsDataAck_0:
        MOVS     R2,#+0
        ADDS     R1,R5,#+3
        ADDS     R0,R4,#+2
        BL       Crc16Calc
        STRH     R0,[R4, #+262]
//  699 	
//  700 	Send->Data[Count] 	= (INT8U)(((Send->Crc) >> 8) & 0xff);
        ADDS     R0,R5,R4
        LDRH     R1,[R4, #+262]
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+5]
//  701 	Send->Data[Count+1] = (INT8U)(((Send->Crc) >> 0) & 0xff);	/* SIO CRC HIGH */
        LDRH     R1,[R4, #+262]
        STRB     R1,[R0, #+6]
//  702 }
        POP      {R0,R4,R5,PC}    ;; return
//  703 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  704 void iRemsStatusUpdate(void)
//  705 {
iRemsStatusUpdate:
        PUSH     {R4}
//  706     iRemsStatus->Manufacture = iRemsFRTEK;
        LDR.N    R0,??DataTable13
        LDR      R1,[R0, #+112]
        MOVS     R2,#+4
        STRB     R2,[R1, #+0]
//  707 	iRemsStatus->SystemVersion	= SystemVer;
        LDR      R1,[R0, #+112]
        MOVS     R2,#+16
        STRB     R2,[R1, #+1]
//  708 
//  709 	//----------------------------------------------------------------------//
//  710 	// State1 & Alarm
//  711 	if(MainStatus->IsolationLevel1 < ISO_MAX_GAIN)	BitSet(iRemsStatus->AlarmStatus, 7);// 0x80;
        LDR      R2,[R0, #+112]
        LDR.W    R1,??DataTable14_5
        LDR      R3,[R1, #+0]
        LDRSB    R3,[R3, #+31]
        CMP      R3,#+102
        LDRB     R3,[R2, #+2]
        ITE      LT 
        ORRLT    R3,R3,#0x80
        ANDGE    R3,R3,#0x7F
//  712 	else											BitRst(iRemsStatus->AlarmStatus, 7);// ~0x80;
        STRB     R3,[R2, #+2]
//  713 	
//  714 	if(MainStatus->IsolationLevel2 < ISO_MAX_GAIN)	BitSet(iRemsStatus->AlarmStatus, 6);// 0x40;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRSB    R3,[R3, #+32]
        CMP      R3,#+102
        LDRB     R3,[R2, #+2]
        ITE      LT 
        ORRLT    R3,R3,#0x40
        ANDGE    R3,R3,#0xBF
//  715 	else											BitRst(iRemsStatus->AlarmStatus, 6);// ~0x40;
        STRB     R3,[R2, #+2]
//  716 		
//  717 	if(MainStatus->SleepMode2 & 0x01) BitSet(iRemsStatus->AlarmStatus, 5);							// 0x20;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+77]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+2]
        ITE      MI 
        ORRMI    R3,R3,#0x20
        ANDPL    R3,R3,#0xDF
//  718 	else							  BitRst(iRemsStatus->AlarmStatus, 5);							// ~0x20;
        STRB     R3,[R2, #+2]
//  719 	
//  720 	if(MainStatus->SleepMode & 0x01)  BitSet(iRemsStatus->AlarmStatus, 4);							// 0x10;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+48]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+2]
        ITE      MI 
        ORRMI    R3,R3,#0x10
        ANDPL    R3,R3,#0xEF
//  721 	else							  BitRst(iRemsStatus->AlarmStatus, 4);							// ~0x10;
        STRB     R3,[R2, #+2]
//  722 	
//  723 	if(MainStatus->AlarmFlag.PCSOSCAlarm)	BitSet(iRemsStatus->AlarmStatus, 3);					// 0x08;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+68]
        LSLS     R3,R3,#+30
        LDRB     R3,[R2, #+2]
        ITE      MI 
        ORRMI    R3,R3,#0x8
        ANDPL    R3,R3,#0xF7
//  724 	else									BitRst(iRemsStatus->AlarmStatus, 3);					// ~0x08;
        STRB     R3,[R2, #+2]
//  725 	
//  726 	if(MainStatus->AlarmFlag.WCDMAOSCAlarm)	BitSet(iRemsStatus->AlarmStatus, 2);					// 0x04;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+68]
        LSLS     R3,R3,#+29
        LDRB     R3,[R2, #+2]
        ITE      MI 
        ORRMI    R3,R3,#0x4
        ANDPL    R3,R3,#0xFB
//  727 	else									BitRst(iRemsStatus->AlarmStatus, 2);					// ~0x04; 
        STRB     R3,[R2, #+2]
//  728 
//  729 	iRemsStatus->AlarmStatus &= ~ 0x02;
        LDR      R2,[R0, #+112]
        LDRB     R3,[R2, #+2]
        AND      R3,R3,#0xFD
        STRB     R3,[R2, #+2]
//  730 	iRemsStatus->AlarmStatus &= ~ 0x01;
        LDR      R2,[R0, #+112]
        LDRB     R3,[R2, #+2]
        AND      R3,R3,#0xFE
        STRB     R3,[R2, #+2]
//  731 
//  732 	iRemsStatus->PCSFwdPower = MainStatus->PCSFwdPower/5;
        MOVS     R2,#+5
        LDR      R3,[R1, #+0]
        LDRSB    R3,[R3, #+24]
        SDIV     R3,R3,R2
        LDR      R4,[R0, #+112]
        STRB     R3,[R4, #+7]
//  733 	iRemsStatus->WCDMAFwdPower = MainStatus->WCDMAFwdPower/5;
        LDR      R3,[R1, #+0]
        LDRSB    R3,[R3, #+28]
        SDIV     R2,R3,R2
        LDR      R3,[R0, #+112]
        STRB     R2,[R3, #+8]
//  734 	iRemsStatus->PCSRvsPower = MainStatus->PCSRvsPower;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+25]
        STRB     R3,[R2, #+9]
//  735 	iRemsStatus->WCDMARvsPower = MainStatus->WCDMARvsPower;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+29]
        STRB     R3,[R2, #+10]
//  736 	iRemsStatus->CurrentTemp = MainStatus->ENVTemp;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+30]
        STRB     R3,[R2, #+11]
//  737 
//  738 	iRemsStatus->FwdGain2G = SYSTEM_GAIN -(MainStatus->FwdAttn_4G);
        LDR      R2,[R1, #+0]
        LDRSB    R2,[R2, #+2]
        RSB      R2,R2,#+75
        LDR      R3,[R0, #+112]
        STRB     R2,[R3, #+12]
//  739 	iRemsStatus->FwdGain3G = SYSTEM_GAIN -(MainStatus->FwdAttn_3G);
        LDR      R2,[R1, #+0]
        LDRSB    R2,[R2, #+3]
        RSB      R2,R2,#+75
        LDR      R3,[R0, #+112]
        STRB     R2,[R3, #+13]
//  740 	iRemsStatus->RvsGain2G = SYSTEM_GAIN -(MainStatus->RvsAttn_4G);
        LDR      R2,[R1, #+0]
        LDRSB    R2,[R2, #+6]
        RSB      R2,R2,#+75
        LDR      R3,[R0, #+112]
        STRB     R2,[R3, #+14]
//  741 	iRemsStatus->RvsGain3G = SYSTEM_GAIN -(MainStatus->RvsAttn_3G);
        LDR      R2,[R1, #+0]
        LDRSB    R2,[R2, #+8]
        RSB      R2,R2,#+75
        LDR      R3,[R0, #+112]
        STRB     R2,[R3, #+15]
//  742 		
//  743 	//----------------------------------------------------------------------//
//  744 	iRemsStatus->FwdRssi2G = iRemsStatus->PCSFwdPower - iRemsStatus->FwdGain2G; 	//0x80;	// Sleep Mode사용으로 Fwd 입력 사용하지 않음.
        LDR      R2,[R0, #+112]
        LDRB     R3,[R2, #+7]
        LDRSB    R4,[R2, #+12]
        SUBS     R3,R3,R4
        STRB     R3,[R2, #+3]
//  745 	iRemsStatus->FwdRssi3G = iRemsStatus->WCDMAFwdPower - iRemsStatus->FwdGain3G; 	//0x80;	// Sleep Mode사용으로 Fwd 입력 사용하지 않음.
        LDR      R2,[R0, #+112]
        LDRB     R3,[R2, #+8]
        LDRSB    R4,[R2, #+13]
        SUBS     R3,R3,R4
        STRB     R3,[R2, #+4]
//  746 
//  747 	iRemsStatus->RvsRssi2G	= MainStatus->NoSleepTime1;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRSB    R3,[R3, #+79]
        STRB     R3,[R2, #+5]
//  748 	iRemsStatus->RvsRssi3G	= MainStatus->NoSleepTime2;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRSB    R3,[R3, #+80]
        STRB     R3,[R2, #+6]
//  749 
//  750 	//----------------------------------------------------------------------//
//  751 	if(MainStatus->AGCOnOff & 0x01)		BitSet(iRemsStatus->AGC_OnOff, 7);	// 0x80;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+40]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+16]
        ITE      MI 
        ORRMI    R3,R3,#0x80
        ANDPL    R3,R3,#0x7F
//  752 	else								BitRst(iRemsStatus->AGC_OnOff, 7);	// ~0x80;
        STRB     R3,[R2, #+16]
//  753 
//  754 	BitRst(iRemsStatus->AGC_OnOff, 6);										// ~0x40;
        LDR      R2,[R0, #+112]
        LDRB     R3,[R2, #+16]
        AND      R3,R3,#0xBF
        STRB     R3,[R2, #+16]
//  755 
//  756 
//  757 	if(MainStatus->ALCOnOff & 0x01)		BitSet(iRemsStatus->AGC_OnOff, 5);	// 0x20;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+72]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+16]
        ITE      MI 
        ORRMI    R3,R3,#0x20
        ANDPL    R3,R3,#0xDF
//  758 	else								BitRst(iRemsStatus->AGC_OnOff, 5);	// ~0x20;
        STRB     R3,[R2, #+16]
//  759 
//  760 	BitRst(iRemsStatus->AGC_OnOff, 4);										// ~0x10;
        LDR      R2,[R0, #+112]
        LDRB     R3,[R2, #+16]
        AND      R3,R3,#0xEF
        STRB     R3,[R2, #+16]
//  761 
//  762 	if(MainStatus->TxSWOnOff_4G & 0x01)		BitSet(iRemsStatus->AGC_OnOff, 3);	// 0x08;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+33]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+16]
        ITE      MI 
        ORRMI    R3,R3,#0x8
        ANDPL    R3,R3,#0xF7
//  763 	else								BitRst(iRemsStatus->AGC_OnOff, 3);	// ~0x08;
        STRB     R3,[R2, #+16]
//  764 
//  765 	if(MainStatus->TxSWOnOff_3G & 0x01)		BitSet(iRemsStatus->AGC_OnOff, 2);	// 0x04;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+81]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+16]
        ITE      MI 
        ORRMI    R3,R3,#0x4
        ANDPL    R3,R3,#0xFB
//  766 	else									BitRst(iRemsStatus->AGC_OnOff, 2);	// ~0x04;
        STRB     R3,[R2, #+16]
//  767 	
//  768 	if(MainStatus->RxSWOnOff_4G & 0x01)		BitSet(iRemsStatus->AGC_OnOff, 1);	// 0x02;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+34]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+16]
        ITE      MI 
        ORRMI    R3,R3,#0x2
        ANDPL    R3,R3,#0xFD
//  769 	else								BitRst(iRemsStatus->AGC_OnOff, 1);	// ~0x02;
        STRB     R3,[R2, #+16]
//  770 
//  771 	if(MainStatus->RxSWOnOff_3G & 0x01)		BitSet(iRemsStatus->AGC_OnOff, 0);	// 0x01;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+82]
        LSLS     R3,R3,#+31
        LDRB     R3,[R2, #+16]
        ITE      MI 
        ORRMI    R3,R3,#0x1
        ANDPL    R3,R3,#0xFE
//  772 	else									BitRst(iRemsStatus->AGC_OnOff, 0);	// ~0x01;
        STRB     R3,[R2, #+16]
//  773 
//  774 	//----------------------------------------------------------------------//
//  775 	iRemsStatus->AgcLevel2GFwd = MainStatus->AGCLimit1;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+55]
        STRB     R3,[R2, #+17]
//  776 	iRemsStatus->AgcLevel3GFwd = MainStatus->AGCLimit3;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+57]
        STRB     R3,[R2, #+18]
//  777 	
//  778 	iRemsStatus->AgcLevel2GRvs_Offset = MainStatus->AGCLimit2;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+56]
        STRB     R3,[R2, #+19]
//  779 	iRemsStatus->AgcLevel3GRvs_Offset = MainStatus->AGCLimit4;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+58]
        STRB     R3,[R2, #+20]
//  780 	
//  781 	//----------------------------------------------------------------------//
//  782 	iRemsStatus->AgcTime2G[0] = MainStatus->AGCTimeLower1;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+63]
        STRB     R3,[R2, #+21]
//  783 	iRemsStatus->AgcTime2G[1] = MainStatus->AGCTimeUpper1;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+64]
        STRB     R3,[R2, #+22]
//  784 	iRemsStatus->AgcTime3G[0] = MainStatus->AGCTimeLower2;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+65]
        STRB     R3,[R2, #+23]
//  785 	iRemsStatus->AgcTime3G[1] = MainStatus->AGCTimeUpper2;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+66]
        STRB     R3,[R2, #+24]
//  786 
//  787 	//----------------------------------------------------------------------//
//  788 	iRemsStatus->Reserved = 0;
        LDR      R2,[R0, #+112]
        MOVS     R3,#+0
        STRB     R3,[R2, #+25]
//  789 	
//  790 	iRemsStatus->AlcLevel2GHigh = MainStatus->ALC_Phigh;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+73]
        STRB     R3,[R2, #+26]
//  791 	iRemsStatus->AlcLevel3GHigh = MainStatus->ALC_Whigh;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+74]
        STRB     R3,[R2, #+27]
//  792 	iRemsStatus->AlcLevel2GLow_Offset = MainStatus->ALC_Plow;
        LDR      R2,[R0, #+112]
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+75]
        STRB     R3,[R2, #+28]
//  793 	iRemsStatus->AlcLevel3GLow_Offset = MainStatus->ALC_Wlow;
        LDR      R0,[R0, #+112]
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+76]
        STRB     R1,[R0, #+29]
//  794 	
//  795 }
        POP      {R4}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13:
        DC32     iRemsSerB

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_1:
        DC32     pUSART2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_2:
        DC32     pUSART3

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_3:
        DC32     IRemsTask

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_4:
        DC32     iRemsTaskStk

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_5:
        DC32     tTestFlag

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_6:
        DC32     0x4001140c

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_7:
        DC32     ModemRstCnt

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_8:
        DC32     Booting

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_9:
        DC32     0xa4cb80

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_10:
        DC32     0x1b7740

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_11:
        DC32     `?<Constant "AT$KTFRESET">`
//  796 
//  797 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  798 void iRemsSetDataCopy(IREMSCONTROL *ptr)
//  799 {
iRemsSetDataCopy:
        PUSH     {R3-R7,LR}
        MOV      R4,R0
//  800 	EE_BACK1 *tptr;
//  801 	INT32U cpu_sr;
//  802 
//  803 	INT8U i = 0; 
//  804 	INT8U rval = 0;
        LDR.W    R5,??DataTable14_15
//  805 
//  806 	while( ModemCtrlFlag == 0x01 )	OSTimeDly(100L);
        LDRB     R0,[R5, #+0]
        CMP      R0,#+1
        BNE.N    ??iRemsSetDataCopy_0
??iRemsSetDataCopy_1:
        MOVS     R0,#+100
        BL       OSTimeDly
        LDRB     R0,[R5, #+0]
        CMP      R0,#+1
        BEQ.N    ??iRemsSetDataCopy_1
//  807 	
//  808 	ModemCtrlFlag = 0x01;
??iRemsSetDataCopy_0:
        MOVS     R0,#+1
        STRB     R0,[R5, #+0]
//  809 
//  810 	for(i = 0; i < sizeof(ptr->ControlSet.Data); i++) rval |= ptr->ControlSet.Data[i];
        LDRB     R0,[R4, #+0]
        LDRB     R1,[R4, #+1]
        ORRS     R0,R1,R0
        LDRB     R1,[R4, #+2]
        ORRS     R0,R1,R0
        LDRB     R1,[R4, #+3]
        ORRS     R0,R1,R0
//  811 
//  812 	if(ptr->TxRx_OnOff >> 4)	rval++;
        LDRB     R1,[R4, #+22]
        LSRS     R1,R1,#+4
        ITT      NE 
        ADDNE    R0,R0,#+1
        UXTBNE   R0,R0
//  813 
//  814 	if(rval != 0)
        CMP      R0,#+0
        BEQ.W    ??iRemsSetDataCopy_2
//  815 	{
//  816 		OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R6,R0
//  817 
//  818 		tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area	
        LDR.W    R7,??DataTable14_16  ;; 0x8006000
        MOV      R0,R7
        BL       RoadBackuptobuffer
//  819 
//  820 		//==================================================
//  821 		// ControlSet 1 : GainSetFlag
//  822 		if(ptr->ControlSet.FGain2GFlag)
        LDRB     R1,[R4, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??iRemsSetDataCopy_3
//  823 		{
//  824 			MainStatus->FwdAttn_4G = (SYSTEM_GAIN - ptr->FwdGain2G);
        LDR.N    R1,??DataTable14_5
        LDRSB    R2,[R4, #+4]
        RSB      R2,R2,#+75
        LDR      R3,[R1, #+0]
        STRB     R2,[R3, #+2]
//  825 			
//  826 			if( MainStatus->FwdAttn_4G <= MinAttn4G) MainStatus->FwdAttn_4G = MinAttn4G;
        LDR      R2,[R1, #+0]
        LDR.N    R3,??DataTable14_17
        LDRB     R3,[R3, #+0]
        LDRSB    LR,[R2, #+2]
        CMP      R3,LR
        IT       GE 
        STRBGE   R3,[R2, #+2]
//  827 			tptr->BackUp.FwdAttn_4G = MainStatus->FwdAttn_4G;
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+2]
        STRB     R1,[R0, #+4]
//  828 		}
//  829 
//  830 		if(ptr->ControlSet.FGain3GFlag)
??iRemsSetDataCopy_3:
        LDRB     R1,[R4, #+0]
        LSLS     R1,R1,#+25
        BPL.N    ??iRemsSetDataCopy_4
//  831 		{
//  832 			MainStatus->FwdAttn_3G = (SYSTEM_GAIN - ptr->FwdGain3G);
        LDR.N    R1,??DataTable14_5
        LDRSB    R2,[R4, #+5]
        RSB      R2,R2,#+75
        LDR      R3,[R1, #+0]
        STRB     R2,[R3, #+3]
//  833 
//  834 			if(MainStatus->FwdAttn_3G <= MinAttn3G) MainStatus->FwdAttn_3G = MinAttn3G;
        LDR      R2,[R1, #+0]
        LDR.N    R3,??DataTable14_18
        LDRB     R3,[R3, #+0]
        LDRSB    LR,[R2, #+3]
        CMP      R3,LR
        IT       GE 
        STRBGE   R3,[R2, #+3]
//  835 			tptr->BackUp.FwdAttn_3G = MainStatus->FwdAttn_3G;
        ADDS     R2,R0,#+4
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+3]
        STRB     R1,[R2, #+1]
//  836 		}
//  837 
//  838 		if(ptr->ControlSet.RGain2GFlag)
??iRemsSetDataCopy_4:
        LDRB     R1,[R4, #+0]
        LSLS     R1,R1,#+26
        BPL.N    ??iRemsSetDataCopy_5
//  839 		{
//  840 			MainStatus->RvsAttn_4G = (SYSTEM_GAIN - ptr->RvsGain2G);
        LDR.N    R1,??DataTable14_5
        LDRSB    R2,[R4, #+6]
        RSB      R2,R2,#+75
        LDR      R3,[R1, #+0]
        STRB     R2,[R3, #+6]
//  841 
//  842 			if(MainStatus->RvsAttn_4G <= MinAttn4G) MainStatus->RvsAttn_4G = MinAttn4G;
        LDR      R2,[R1, #+0]
        LDR.N    R3,??DataTable14_17
        LDRB     R3,[R3, #+0]
        LDRSB    LR,[R2, #+6]
        CMP      R3,LR
        IT       GE 
        STRBGE   R3,[R2, #+6]
//  843 			tptr->BackUp.RvsAttn_4G = MainStatus->RvsAttn_4G;
        ADDS     R2,R0,#+4
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+6]
        STRB     R1,[R2, #+2]
//  844 		}
//  845 
//  846 		if(ptr->ControlSet.RGain3GFlag)
??iRemsSetDataCopy_5:
        LDRB     R1,[R4, #+0]
        LSLS     R1,R1,#+27
        BPL.N    ??iRemsSetDataCopy_6
//  847 		{
//  848 			MainStatus->RvsAttn_3G = (SYSTEM_GAIN - ptr->RvsGain3G);
        LDR.N    R1,??DataTable14_5
        LDRSB    R2,[R4, #+7]
        RSB      R2,R2,#+75
        LDR      R3,[R1, #+0]
        STRB     R2,[R3, #+8]
//  849 
//  850 			if(MainStatus->RvsAttn_3G <= MinAttn3G) MainStatus->RvsAttn_3G = MinAttn3G;
        LDR      R2,[R1, #+0]
        LDR.N    R3,??DataTable14_18
        LDRB     R3,[R3, #+0]
        LDRSB    LR,[R2, #+8]
        CMP      R3,LR
        IT       GE 
        STRBGE   R3,[R2, #+8]
//  851 			tptr->BackUp.RvsAttn_3G = MainStatus->RvsAttn_3G;
        ADDS     R2,R0,#+4
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+8]
        STRB     R1,[R2, #+4]
//  852 		}
//  853 		//==================================================
//  854 		// ControlSet 3 : AgcAlcSetFlag
//  855 		if(ptr->ControlSet.AgcLevel2GFFlag)
??iRemsSetDataCopy_6:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+24
        BPL.N    ??iRemsSetDataCopy_7
//  856 		{
//  857 			MainStatus->AGCLimit1 = ptr->AgcLevel2GFwd;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+9]
        STRB     R3,[R2, #+55]
//  858 			tptr->BackUp.AGCLimit1 = MainStatus->AGCLimit1;
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+55]
        STRB     R1,[R0, #+40]
//  859 		}
//  860 
//  861 		if(ptr->ControlSet.AgcLevel3GFFlag)
??iRemsSetDataCopy_7:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+25
        BPL.N    ??iRemsSetDataCopy_8
//  862 		{
//  863 			MainStatus->AGCLimit3 = ptr->AgcLevel3GFwd;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+10]
        STRB     R3,[R2, #+57]
//  864 			tptr->BackUp.AGCLimit3 = MainStatus->AGCLimit3;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+57]
        STRB     R1,[R2, #+2]
//  865 		}
//  866 
//  867 		if(ptr->ControlSet.AgcLevel2GrFlag)
??iRemsSetDataCopy_8:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+26
        BPL.N    ??iRemsSetDataCopy_9
//  868 		{
//  869 			MainStatus->AGCLimit2 = ptr->AgcLevel2GRvs_Offset;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+11]
        STRB     R3,[R2, #+56]
//  870 			tptr->BackUp.AGCLimit2 = MainStatus->AGCLimit2;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+56]
        STRB     R1,[R2, #+1]
//  871 		}
//  872 
//  873 		if(ptr->ControlSet.AgcLevel3GrFlag)
??iRemsSetDataCopy_9:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+27
        BPL.N    ??iRemsSetDataCopy_10
//  874 		{
//  875 			MainStatus->AGCLimit4 = ptr->AgcLevel3GRvs_Offset;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+12]
        STRB     R3,[R2, #+58]
//  876 			tptr->BackUp.AGCLimit4 = MainStatus->AGCLimit4;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+58]
        STRB     R1,[R2, #+3]
//  877 		}
//  878 ////////////////////////////////////////////////////////////////////////////////
//  879 		if(ptr->ControlSet.AlcLevel2GhFlag)
??iRemsSetDataCopy_10:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+28
        BPL.N    ??iRemsSetDataCopy_11
//  880 		{
//  881 			MainStatus->ALC_Phigh = ptr->AlcLevel2GHigh;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+18]
        STRB     R3,[R2, #+73]
//  882 			tptr->BackUp.ALC_Phigh = MainStatus->ALC_Phigh;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+73]
        STRB     R1,[R2, #+14]
//  883 		}
//  884 
//  885 		if(ptr->ControlSet.AlcLevel3GhFlag)
??iRemsSetDataCopy_11:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+29
        BPL.N    ??iRemsSetDataCopy_12
//  886 		{
//  887 			MainStatus->ALC_Whigh = ptr->AlcLevel3GHigh;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+19]
        STRB     R3,[R2, #+74]
//  888 			tptr->BackUp.ALC_Whigh = MainStatus->ALC_Whigh;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+74]
        STRB     R1,[R2, #+15]
//  889 		}
//  890 
//  891 		if(ptr->ControlSet.AlcLevel2GlFlag)
??iRemsSetDataCopy_12:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+30
        BPL.N    ??iRemsSetDataCopy_13
//  892 		{
//  893 			MainStatus->ALC_Plow = ptr->AlcLevel2GLow_Offset;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+20]
        STRB     R3,[R2, #+75]
//  894 			tptr->BackUp.ALC_Plow = MainStatus->ALC_Plow;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+75]
        STRB     R1,[R2, #+16]
//  895 		}
//  896 
//  897 		if(ptr->ControlSet.AlcLevel3GlFlag)
??iRemsSetDataCopy_13:
        LDRB     R1,[R4, #+2]
        LSLS     R1,R1,#+31
        BPL.N    ??iRemsSetDataCopy_14
//  898 		{
//  899 			MainStatus->ALC_Wlow = ptr->AlcLevel3GLow_Offset;
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+21]
        STRB     R3,[R2, #+76]
//  900 			tptr->BackUp.ALC_Wlow = MainStatus->ALC_Wlow;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+76]
        STRB     R1,[R2, #+17]
//  901 		}
//  902 
//  903 		//==================================================
//  904 		// ControlSet 4 : AgcTimeSetFlag
//  905 		if(ptr->ControlSet.AgcTime2Flag)
??iRemsSetDataCopy_14:
        LDRB     R1,[R4, #+3]
        LSLS     R1,R1,#+24
        BPL.N    ??iRemsSetDataCopy_15
//  906 		{
//  907 			MainStatus->AGCTimeLower1 = ptr->AgcTime2G[0];
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+13]
        STRB     R3,[R2, #+63]
//  908 			MainStatus->AGCTimeUpper1 = ptr->AgcTime2G[1];
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+14]
        STRB     R3,[R2, #+64]
//  909 			tptr->BackUp.AGCTimeLower1 = MainStatus->AGCTimeLower1;
        ADDW     R2,R0,#+40
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+63]
        STRB     R3,[R2, #+6]
//  910 			tptr->BackUp.AGCTimeUpper1 = MainStatus->AGCTimeUpper1;
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+64]
        STRB     R1,[R2, #+7]
//  911 		}
//  912 
//  913 		if(ptr->ControlSet.AgcTime3Flag)
??iRemsSetDataCopy_15:
        LDRB     R1,[R4, #+3]
        LSLS     R1,R1,#+25
        BPL.N    ??iRemsSetDataCopy_16
//  914 		{
//  915 			MainStatus->AGCTimeLower2 = ptr->AgcTime3G[0];
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+15]
        STRB     R3,[R2, #+65]
//  916 			MainStatus->AGCTimeUpper2 = ptr->AgcTime3G[1];
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+16]
        STRB     R3,[R2, #+66]
//  917 			tptr->BackUp.AGCTimeLower2 = MainStatus->AGCTimeLower2;
        ADDW     R2,R0,#+40
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+65]
        STRB     R3,[R2, #+8]
//  918 			tptr->BackUp.AGCTimeUpper2 = MainStatus->AGCTimeUpper2;
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+66]
        STRB     R1,[R2, #+9]
//  919 		}
//  920 
//  921 		//==================================================
//  922 		// ControlSet 2 : AgcAlcEnableFlag
//  923 		if(ptr->ControlSet.AGC_EnFlag)
??iRemsSetDataCopy_16:
        LDRB     R1,[R4, #+1]
        LSLS     R1,R1,#+24
        BPL.N    ??iRemsSetDataCopy_17
//  924 		{
//  925 			if(ptr->AGC_OnOff & 0x01) 	MainStatus->AGCOnOff = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+8]
        LSLS     R3,R3,#+31
        ITE      MI 
        MOVMI    R3,#+49
        MOVPL    R3,#+48
//  926 			else 						MainStatus->AGCOnOff = '0';
        STRB     R3,[R2, #+40]
//  927 
//  928 			tptr->BackUp.AGCOnOff = MainStatus->AGCOnOff;
        ADDS     R2,R0,#+4
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+40]
        STRB     R3,[R2, #+24]
//  929 			
//  930 			if(MainStatus->AGCOnOff & 0x01)
        LDR      R3,[R1, #+0]
        LDRB     R12,[R3, #+40]
        LSLS     R12,R12,#+31
        BPL.N    ??iRemsSetDataCopy_17
//  931 			{
//  932 				MainStatus->ALCOnOff = '0';
        MOV      R12,#+48
        STRB     R12,[R3, #+72]
//  933 				tptr->BackUp.ALCOnOff = MainStatus->ALCOnOff;
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+72]
        STRB     R1,[R2, #+25]
//  934 			}
//  935 		}
//  936 
//  937 		if(ptr->ControlSet.ALC_EnFlag)
??iRemsSetDataCopy_17:
        LDRB     R1,[R4, #+1]
        LSLS     R1,R1,#+25
        BPL.N    ??iRemsSetDataCopy_18
//  938 		{
//  939 			if(ptr->ALC_OnOff & 0x01) 	MainStatus->ALCOnOff = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+17]
        LSLS     R3,R3,#+31
        ITE      MI 
        MOVMI    R3,#+49
        MOVPL    R3,#+48
//  940 			else 						MainStatus->ALCOnOff = '0';
        STRB     R3,[R2, #+72]
//  941 			
//  942 			tptr->BackUp.ALCOnOff = MainStatus->ALCOnOff;
        ADDS     R2,R0,#+4
        LDR      R3,[R1, #+0]
        LDRB     R3,[R3, #+72]
        STRB     R3,[R2, #+25]
//  943 
//  944 			if(MainStatus->ALCOnOff & 0x01)
        LDR      R3,[R1, #+0]
        LDRB     R12,[R3, #+72]
        LSLS     R12,R12,#+31
        BPL.N    ??iRemsSetDataCopy_18
//  945 			{
//  946 				MainStatus->AGCOnOff = '0';
        MOV      R12,#+48
        STRB     R12,[R3, #+40]
//  947 				tptr->BackUp.AGCOnOff = MainStatus->AGCOnOff;
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+40]
        STRB     R1,[R2, #+24]
//  948 			}
//  949 		}
//  950 
//  951 		if(ptr->ControlSet.SleepOnOff2GFlag)
??iRemsSetDataCopy_18:
        LDRB     R1,[R4, #+1]
        LSLS     R1,R1,#+26
        BPL.N    ??iRemsSetDataCopy_19
//  952 		{
//  953 			if(ptr->ControlSet.SleepOnOff2G & 0x01)	MainStatus->SleepMode = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+0]
        LSLS     R3,R3,#+28
        ITE      MI 
        MOVMI    R3,#+49
        MOVPL    R3,#+48
//  954 			else									MainStatus->SleepMode = '0';
        STRB     R3,[R2, #+48]
//  955 			
//  956 			tptr->BackUp.SleepMode = MainStatus->SleepMode;
        ADDS     R2,R0,#+4
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+48]
        STRB     R1,[R2, #+26]
//  957 		}
//  958 
//  959 		if(ptr->ControlSet.SleepOnOff3GFlag)
??iRemsSetDataCopy_19:
        LDRB     R1,[R4, #+1]
        LSLS     R1,R1,#+27
        BPL.N    ??iRemsSetDataCopy_20
//  960 		{
//  961 			if(ptr->ControlSet.SleepOnOff3G & 0x01)	MainStatus->SleepMode2 = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R2,[R1, #+0]
        LDRB     R3,[R4, #+0]
        LSLS     R3,R3,#+29
        ITE      MI 
        MOVMI    R3,#+49
        MOVPL    R3,#+48
//  962 			else									MainStatus->SleepMode2 = '0';
        STRB     R3,[R2, #+77]
//  963 			
//  964 			tptr->BackUp.SleepMode = MainStatus->SleepMode;
        ADDS     R2,R0,#+4
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+48]
        STRB     R1,[R2, #+26]
//  965 		}
//  966 
//  967 		//==================================================
//  968 		// TxRx_OnOff
//  969 		if(BitRead(ptr->TxRx_OnOff, mPwr_tx_2G_Flag))
??iRemsSetDataCopy_20:
        LDRB     R2,[R4, #+22]
        LSLS     R1,R2,#+24
        BPL.N    ??iRemsSetDataCopy_21
//  970 		{
//  971 			if(BitRead(ptr->TxRx_OnOff, mPwr_tx_2G_Bit))	MainStatus->TxSWOnOff_4G = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R3,[R1, #+0]
        LSLS     R2,R2,#+28
        ITE      MI 
        MOVMI    R2,#+49
        MOVPL    R2,#+48
//  972 			else											MainStatus->TxSWOnOff_4G = '0';
        STRB     R2,[R3, #+33]
//  973 			
//  974 			tptr->BackUp.SWOnOff1 = MainStatus->TxSWOnOff_4G;
        ADDS     R2,R0,#+4
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+33]
        STRB     R1,[R2, #+17]
//  975 		}
//  976 
//  977 		if(BitRead(ptr->TxRx_OnOff, mPwr_tx_3G_Flag))
??iRemsSetDataCopy_21:
        LDRB     R2,[R4, #+22]
        LSLS     R1,R2,#+25
        BPL.N    ??iRemsSetDataCopy_22
//  978 		{
//  979 			if(BitRead(ptr->TxRx_OnOff, mPwr_tx_3G_Bit))	MainStatus->TxSWOnOff_3G = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R3,[R1, #+0]
        LSLS     R2,R2,#+29
        ITE      MI 
        MOVMI    R2,#+49
        MOVPL    R2,#+48
//  980 			else											MainStatus->TxSWOnOff_3G = '0';
        STRB     R2,[R3, #+81]
//  981 			tptr->BackUp.TxSWOnOff_3G = MainStatus->TxSWOnOff_3G;
        ADD      R2,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+81]
        STRB     R1,[R2, #+22]
//  982 		}
//  983 
//  984 		if(BitRead(ptr->TxRx_OnOff, mPwr_rx_2G_Flag))
??iRemsSetDataCopy_22:
        LDRB     R2,[R4, #+22]
        LSLS     R1,R2,#+26
        BPL.N    ??iRemsSetDataCopy_23
//  985 		{
//  986 			if(BitRead(ptr->TxRx_OnOff, mPwr_rx_2G_Bit))	MainStatus->RxSWOnOff_4G = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R3,[R1, #+0]
        LSLS     R2,R2,#+30
        ITE      MI 
        MOVMI    R2,#+49
        MOVPL    R2,#+48
//  987 			else											MainStatus->RxSWOnOff_4G = '0';
        STRB     R2,[R3, #+34]
//  988 			tptr->BackUp.SWOnOff2 = MainStatus->RxSWOnOff_4G;
        ADDS     R2,R0,#+4
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+34]
        STRB     R1,[R2, #+18]
//  989 		}
//  990 
//  991 		if(BitRead(ptr->TxRx_OnOff, mPwr_rx_3G_Flag))
??iRemsSetDataCopy_23:
        LDRB     R2,[R4, #+22]
        LSLS     R1,R2,#+27
        BPL.N    ??iRemsSetDataCopy_24
//  992 		{
//  993 			if(BitRead(ptr->TxRx_OnOff, mPwr_rx_3G_Bit))	MainStatus->RxSWOnOff_3G = '1';
        LDR.N    R1,??DataTable14_5
        LDR      R3,[R1, #+0]
        LSLS     R2,R2,#+31
        ITE      MI 
        MOVMI    R2,#+49
        MOVPL    R2,#+48
//  994 			else											MainStatus->RxSWOnOff_3G = '0';
        STRB     R2,[R3, #+82]
//  995 			tptr->BackUp.RxSWOnOff_3G = MainStatus->RxSWOnOff_3G;
        ADDS     R0,R0,#+40
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+82]
        STRB     R1,[R0, #+23]
//  996 		}	
//  997 		
//  998 		//==================================================
//  999 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));	
??iRemsSetDataCopy_24:
        MOV      R1,#+340
        MOV      R0,R7
        BL       WriteBuffertoBackup
// 1000 		OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
// 1001 	}
// 1002 
// 1003 	iRemsStatusUpdate();
??iRemsSetDataCopy_2:
        BL       iRemsStatusUpdate
// 1004 
// 1005 	ModemCtrlFlag = 0x00;
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
// 1006 }
        POP      {R0,R4-R7,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14:
        DC32     DataBuff

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_1:
        DC32     DataBuffLength

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_2:
        DC32     `?<Constant "AT$FWINFO?">`

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_3:
        DC32     iRemsFrameRetry

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_4:
        DC32     0x186a0

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_5:
        DC32     MainStatus

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_6:
        DC32     0x4c4f5049

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_7:
        DC32     0x1ffff7e0

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_8:
        DC32     0x8007000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_9:
        DC32     0x8007028

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_10:
        DC32     0x8007024

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_11:
        DC32     convinfo

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_12:
        DC32     `?<Constant "AT$FWRD=1234">`

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_13:
        DC32     `?<Constant "AT$KTFTIME?">`

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_14:
        DC32     MTxBuff

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_15:
        DC32     ModemCtrlFlag

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_16:
        DC32     0x8006000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_17:
        DC32     MinAttn4G

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14_18:
        DC32     MinAttn3G
// 1007 
// 1008 
// 1009 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1010 INT8U JMatrixConversion ( void *tmpptr )
// 1011 {
// 1012 	//INT8U	i;
// 1013     INT8U RetVal = 0;
// 1014 	//INT8S	sTempCopy;
// 1015 
// 1016 	//if ( tmpptr == &CCTVStatus->ID[0] )
// 1017 	//{
// 1018 	//	for ( i=0; i<10; i++ )
// 1019 	//	{	if ( (CCTVStatus->ID[i] < '0')||(CCTVStatus->ID[i] > 'Z') )
// 1020 	//			break;
// 1021 	//		iRemsStatus->R_RepeaterID[i]	= CCTVStatus->ID[i];
// 1022 	//	}
// 1023 	//	for ( ; i<10; i++ ) iRemsStatus->R_RepeaterID[i]	= JM_NAC;
// 1024 	//	RetVal = iRemsStatus->R_RepeaterID[0];
// 1025 	//	return RetVal;
// 1026 	//}
// 1027 	
// 1028 	//else if ( (tmpptr == &CCTVStatus->PCSALCLimit)||(tmpptr == &CCTVStatus->WCDMAALCLimit) )
// 1029 	//{
// 1030 	//	sTempCopy = *(INT8S *)tmpptr/2;
// 1031 
// 1032 	//	if		( sTempCopy >= 60 ) RetVal = JM_STR;
// 1033 	//	else if ( sTempCopy <=-29 ) RetVal = JM_END-2;
// 1034 	//	else						RetVal = JM_STR + (-1)*(sTempCopy) + 60;
// 1035 	//}
// 1036 	//else if ( (tmpptr == &CCTVStatus->Fwd_2G_MainAttn)||(tmpptr == &CCTVStatus->Fwd_3G_MainAttn)||
// 1037 	//		  (tmpptr == &CCTVStatus->Rvs_2G_MainAttn)||(tmpptr == &CCTVStatus->Rvs_3G_MainAttn) )
// 1038 	//{
// 1039 	//	sTempCopy = *(INT8S *)tmpptr/2; 	// 2007-04-25 4:44오후
// 1040 	//	if		( sTempCopy >= 89 ) RetVal = JM_END-2;
// 1041 	//	else						RetVal = JM_STR + sTempCopy;
// 1042 	//}
// 1043     
// 1044 	//else if ( (tmpptr == &CCTVStatus->PCSALCOffsetLimit)||(tmpptr == &CCTVStatus->WCDMAALCOffsetLimit) )
// 1045 	//{
// 1046 	//	sTempCopy = *(INT8S *)tmpptr/2;
// 1047 	//	RetVal = JM_STR + (-1)*sTempCopy;
// 1048 	//}
// 1049     
// 1050 	//else if ( (tmpptr == &CCTVStatus->PCSSDNFwdLimit)||(tmpptr == &CCTVStatus->WCDMASDNFwdLimit) )
// 1051 	//{
// 1052 	//	sTempCopy = *(INT8S *)tmpptr/2;
// 1053 	//	if		( sTempCopy >= 50 ) RetVal = JM_STR;
// 1054 	//	else if ( sTempCopy <=-39 ) RetVal = JM_END-2;
// 1055 	//	else						RetVal = JM_STR + (-1)*(sTempCopy) + 50;
// 1056 	//}
// 1057 	//else if ( (tmpptr == &CCTVStatus->PCSSDNRvsLimit)||(tmpptr == &CCTVStatus->WCDMASDNRvsLimit) )
// 1058 	//{
// 1059 	//	sTempCopy = *(INT8S *)tmpptr/2;
// 1060         
// 1061 	//	if		( sTempCopy >= 30 ) RetVal = JM_STR;
// 1062 	//	else if ( sTempCopy <=-59 ) RetVal = JM_END-2;
// 1063 	//	else						RetVal = JM_STR + (-1)*(sTempCopy) + 30;
// 1064 	//}
// 1065 	//else if ( tmpptr == &CCTVStatus->ENVTemp )
// 1066 	//{
// 1067 	//	sTempCopy = *(INT8S *)tmpptr;
// 1068 	//	if		( sTempCopy >= 127) RetVal = JM_STR;
// 1069 	//	else if ( sTempCopy <=-47 ) RetVal = JM_END-2;
// 1070 	//	else						RetVal = JM_STR + ((-1)*(sTempCopy) + 130)/2;
// 1071 	//}
// 1072 	//else if ( (tmpptr == &CCTVStatus->PCSFwdPower)||(tmpptr == &CCTVStatus->WCDMAFwdPower) )
// 1073 	//{
// 1074 	//	sTempCopy = *((INT16S *)tmpptr)/2;
// 1075 
// 1076 	//	if		( sTempCopy >= 50 ) RetVal = JM_STR;
// 1077 	//	else if ( sTempCopy <=-39 ) RetVal = JM_END-2;
// 1078 	//	else						RetVal = JM_STR + (-1)*(sTempCopy) + 50;
// 1079 	//}
// 1080 	//else if ( (tmpptr == &CCTVStatus->PCSRvsPower) || (tmpptr == &CCTVStatus->WCDMARvsPower))
// 1081 	//{
// 1082 	//	sTempCopy = *((INT16S *)tmpptr)/2;
// 1083 
// 1084 	//	if		( sTempCopy >= 30 ) RetVal = JM_STR;
// 1085 	//	else if ( sTempCopy <=-59 ) RetVal = JM_END-2;
// 1086 	//	else						RetVal = JM_STR + (-1)*(sTempCopy) + 30;
// 1087 	//}
// 1088 	//else
// 1089 	//{
// 1090 	//	RetVal = JM_NAC;
// 1091 	//}
// 1092 
// 1093 	//if		( RetVal >= JM_ESC ) RetVal = RetVal+1;
// 1094 	//if		( RetVal <	JM_STR ) RetVal = JM_NAC;
// 1095 	//else if ( RetVal >	JM_END ) RetVal = JM_NAC;
// 1096 	return RetVal;
JMatrixConversion:
        MOVS     R0,#+0
        BX       LR               ;; return
// 1097 }
// 1098 
// 1099 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1100 INT8U Hex2Ascii(INT8U HighLow, INT8U Value )
// 1101 {
// 1102 	INT8U Digit10;
// 1103 	INT8U Digit1;
// 1104 
// 1105 	Digit1 = (Value & 0x0f) + 0x30;
Hex2Ascii:
        AND      R2,R1,#0xF
        ADDS     R2,R2,#+48
        UXTB     R2,R2
// 1106 	Digit10 = ((Value >> 4) & 0x0f) + 0x30;
        LSRS     R1,R1,#+4
        ADDS     R1,R1,#+48
        UXTB     R1,R1
// 1107 
// 1108     if(Digit1 >= 0x3a) Digit1 += 0x07;
        CMP      R2,#+58
        ITT      GE 
        ADDGE    R2,R2,#+7
        UXTBGE   R2,R2
// 1109     if(Digit10 >= 0x3a) Digit10 += 0x07;
        CMP      R1,#+58
        ITT      GE 
        ADDGE    R1,R1,#+7
        UXTBGE   R1,R1
// 1110 
// 1111     if(HighLow == HIGH) return( Digit10 );
        CMP      R0,#+1
        BNE.N    ??Hex2Ascii_0
        MOV      R0,R1
        BX       LR
// 1112     if(HighLow == LOW) return( Digit1 );
??Hex2Ascii_0:
        CMP      R0,#+2
        BNE.N    ??Hex2Ascii_1
        MOV      R0,R2
        BX       LR
// 1113 	return(0);
??Hex2Ascii_1:
        MOVS     R0,#+0
        BX       LR               ;; return
// 1114 }
// 1115 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1116 INT8U Ascii2Hex(INT8U Lower, INT8U Upper)
// 1117 {
// 1118 	if ( Upper >= 'A' ) Upper = (Upper+9)&0x0f;
Ascii2Hex:
        CMP      R1,#+65
        IT       CS 
        ADDCS    R1,R1,#+9
// 1119 	else Upper = Upper&0x0f;
        AND      R1,R1,#0xF
// 1120 
// 1121 	if ( Lower >= 'A' ) Lower = (Lower+9)&0x0f;
        CMP      R0,#+65
        IT       CS 
        ADDCS    R0,R0,#+9
// 1122 	else Lower = Lower&0x0f;
        AND      R0,R0,#0xF
// 1123 
// 1124 	return ( (Upper<<4)|Lower );
        ORR      R0,R0,R1, LSL #+4
        BX       LR               ;; return
// 1125 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT$KTFRESET">`:
        DATA
        DC8 "AT$KTFRESET"

        SECTION `.rodata`:CONST:NOROOT(0)
        DATA
        DC8 ""

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT$FWINFO?">`:
        DATA
        DC8 "AT$FWINFO?"
        DC8 0
        DC8 "AT$FWEND=7"
        DC8 0
        DC8 "0124CCVV"
        DC8 0, 0, 0
        DC8 "022334VV"
        DC8 0, 0, 0
        DC8 "0126CCVV"
        DC8 0, 0, 0
        DC8 "022534VV"
        DC8 0, 0, 0
        DC8 "AT$FWEND=2"
        DC8 0
        DC8 "AT$FWEND=3"
        DC8 0
        DC8 "AT$FWEND=0"
        DC8 0
        DC8 "AT$FWEND=6"
        DC8 0
        DC8 "INFO:"
        DC8 0, 0
        DC8 "DLOAD"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "RD:"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT$FWRD=1234">`:
        DATA
        DC8 "AT$FWRD=1234"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT$KTFTIME?">`:
        DATA
        DC8 "AT$KTFTIME?"

        END
// 1126 
// 1127 ////////////////////////////////////////////////////////////////////////////////
// 1128 // End of Source File
// 1129 /////////////////////////
// 1130 
// 
// 2 766 bytes in section .bss
//    36 bytes in section .data
//   181 bytes in section .rodata
// 4 536 bytes in section .text
// 2 048 bytes in section iram
// 
// 4 536 bytes of CODE  memory
//   181 bytes of CONST memory
// 4 850 bytes of DATA  memory
//
//Errors: none
//Warnings: none
