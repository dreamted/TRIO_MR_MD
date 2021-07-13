///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jun/2011  18:42:06 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1. /
//                    0\code\aa_ioru.c                                        /
//    Command line =  "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1 /
//                    .0\code\aa_ioru.c" -lcN "C:\user\project\HFR            /
//                    OTM-L12\fw\appl_otmL12_20110505_v1.0\sout\" -lB         /
//                    "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1 /
//                    .0\sout\" -o "C:\user\project\HFR                       /
//                    OTM-L12\fw\appl_otmL12_20110505_v1.0\sout\"             /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --fpu=None --dlib_config           /
//                    "C:\compiler\ewarm 5.3\arm\INC\DLib_Config_Normal.h"    /
//                    -I "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505 /
//                    _v1.0\include\" -I "C:\user\project\HFR                 /
//                    OTM-L12\fw\appl_otmL12_20110505_v1.0\lib_stm32\inc\"    /
//                    -I "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505 /
//                    _v1.0\lib_stm32\src\" -I "C:\user\project\HFR           /
//                    OTM-L12\fw\appl_otmL12_20110505_v1.0\uC-CPU\" -I        /
//                    "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1 /
//                    .0\uC-LIB\" -I "C:\user\project\HFR                     /
//                    OTM-L12\fw\appl_otmL12_20110505_v1.0\uCOS-II\Ports\"    /
//                    -I "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505 /
//                    _v1.0\uCOS-II\Source\" -I "C:\user\project\HFR          /
//                    OTM-L12\fw\appl_otmL12_20110505_v1.0\uC-Probe\" -I      /
//                    "C:\compiler\ewarm 5.3\arm\INC\" -Oh                    /
//    List file    =  C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1. /
//                    0\sout\aa_ioru.s                                        /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_ioru

        EXTERN GenIORUAidSts
        EXTERN IsItRtnMyVALtoSysID
        EXTERN MyDnrID
        EXTERN MyRmtID
        EXTERN MySts
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN ProtocolComCheck
        EXTERN SystemTypeInfo
        EXTERN TimerRegist
        EXTERN WRCS_DownLoadGiveupTimerSet
        EXTERN WRCS_ProtocolCheck
        EXTERN pBodyFrameTx
        EXTERN pUSART2
        EXTERN tTestFlag

        PUBLIC IORUCheckInstalltoNext
        PUBLIC IORUInit
        PUBLIC IORUInsertCheck
        PUBLIC IORULinkFailCheck
        PUBLIC IORULinkFailCnt
        PUBLIC IORULinkFailRst
        PUBLIC IORURxLED
        PUBLIC IORUSer
        PUBLIC IORUSerB
        PUBLIC IORUSndBuff
        PUBLIC IORUTask
        PUBLIC IORUTxLED
        PUBLIC IsItGetIOURInform
        PUBLIC IsItReallIORUInsert
        PUBLIC RIORUsio
        PUBLIC SIORUsio

// C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1.0\code\aa_ioru.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_bkp.c
//    3 * Author             : MCD Application Team
//    4 * Date First Issued  : 09/29/2006
//    5 * Description        : This file provides all the BKP firmware functions.
//    6 ********************************************************************************/
//    7 
//    8 #define IORU_C
//    9 
//   10 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// __ProtocolPtr __data IORUSerB
IORUSerB:
        DS8 48
// __ProtocolPtr *__data IORUSer
IORUSer:
        DS8 4
// __WRCSSIO __data SIORUsio
SIORUsio:
        DS8 1048
// __WRCSSIO __data RIORUsio
RIORUsio:
        DS8 1048
        DS8 1024

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data IORULinkFailCnt
IORULinkFailCnt:
        DATA
        DC8 0
// INT8U __data IsItGetIOURInform
IsItGetIOURInform:
        DC8 0
        DC8 0, 0
// INT8U *__data IORUSndBuff
IORUSndBuff:
        DC32 SIORUsio + 0FH
//   11 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   12 void IORUInit(void)
//   13 {
IORUInit:
        PUSH     {R4,LR}
//   14 	IORUSer = &IORUSerB;
        LDR.N    R4,??IORUInit_0  ;; IORUSerB
        STR      R4,[R4, #+48]
//   15  	IORUSer->CheckByte = pUSART2.CheckByte;
        LDR.N    R0,??IORUInit_0+0x4  ;; pUSART2
        LDR      R1,[R0, #+4]
        STR      R1,[R4, #+0]
//   16 	IORUSer->RxGetByte = pUSART2.RxGetByte;
        LDR      R1,[R0, #+8]
        STR      R1,[R4, #+4]
//   17 	IORUSer->PutStr = pUSART2.PutStr;
        LDR      R1,[R0, #+12]
        STR      R1,[R4, #+8]
//   18 	IORUSer->TxCheckByte = pUSART2.TxCheckByte;
        LDR      R0,[R0, #+28]
        STR      R0,[R4, #+16]
//   19 	
//   20 	IORUSer->TimerRx = TimerIORU0Rx;
        MOVS     R0,#+11
        STRH     R0,[R4, #+20]
//   21 	IORUSer->TimerEndWait = TimerIORU0EndWait;
        MOVS     R0,#+12
        STRH     R0,[R4, #+22]
//   22 	IORUSer->WRCSRecv = &RIORUsio;
        ADDW     R0,R4,#+1100
        STR      R0,[R4, #+32]
//   23 	IORUSer->WRCSSend = &SIORUsio;
        ADD      R0,R4,#+52
        STR      R0,[R4, #+36]
//   24 	IORUSer->PRIO = IORU0_TASK_PRIO;
        MOVS     R0,#+4
        STRB     R0,[R4, #+46]
//   25 	IORUSer->OSSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+48]
        STR      R0,[R1, #+28]
//   26 	
//   27 	OSTaskCreate(IORUTask, (void *)IORUSer, (OS_STK *)&IORU0TaskStk[IORU0_START_STK_SIZE - 1], IORU0_TASK_PRIO);
        MOVS     R3,#+4
        ADD      R2,R4,#+3168
        LDR.N    R0,??IORUInit_0+0x8  ;; IORUTask
        POP      {R4,LR}
        B.W      OSTaskCreate
        DATA
??IORUInit_0:
        DC32     IORUSerB
        DC32     pUSART2
        DC32     IORUTask
//   28 }
//   29 
//   30 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   31 void IORUTask(void * pdata)
//   32 {
IORUTask:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+12
        MOV      R4,R0
//   33     __ProtocolPtr *nPtr = (__ProtocolPtr *)pdata;
//   34 	
//   35 	INT8U tmplen = 0;
//   36 	INT8U id0, id1, id2;
//   37 	INT16U Recv;
//   38 	
//   39 /////////////////////////////////////////////		
//   40 	OSTimeDly(100*nPtr->PRIO);
        LDRB     R0,[R4, #+46]
        MOVS     R1,#+100
        MULS     R0,R0,R1
        BL       OSTimeDly
//   41 	nPtr->WRCSRecv->cBody = 0;
        LDR      R0,[R4, #+32]
        MOVS     R1,#+0
        STRB     R1,[R0, #+1047]
        LDR.W    R8,??IORUTask_0  ;; SystemTypeInfo
        LDR.N    R5,??IORUTask_0+0x4  ;; MyDnrID
        LDR.N    R6,??IORUTask_0+0x8  ;; MyRmtID
        LDR.W    R9,??IORUTask_0+0xC  ;; tTestFlag
        LDR.N    R7,??DataTable8  ;; IORULinkFailCnt
        B.N      ??IORUTask_1
//   42 
//   43 	while(1)
//   44 	{
//   45 		if(!tTestFlag)
//   46 		{
//   47 			if((nPtr->CheckByte(1, &Recv)) && WRCS_ProtocolCheck(nPtr))
//   48 			{
//   49 			#if TWO_BODY >= 2
//   50 				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   51 				{
//   52 			#endif
//   53 					ProtocolComCheck(nPtr);
//   54 			#if TWO_BODY >= 2
//   55 					nPtr->WRCSRecv->cBody++;
//   56 				}
//   57 			#endif
//   58 				IORULinkFailRst();
//   59 				IORURxLED(SET);
//   60 			}
//   61 			else if(!WRCS_DownLoadGiveupTimerSet(NULL))
//   62 			{
//   63 				if(IORUCheckInstalltoNext())
//   64 				{
//   65 
//   66 					IsItRtnMyVALtoSysID(&id0, &id1, &id2, MyDnrID, MyRmtID);
//   67 					#ifndef ALARM_TEST
//   68 					if(IsItGetIOURInform == NULL){
//   69 						pBodyFrameTx(id0, id1, id2, NULL, NULL, ModuleInformStsQue, nPtr, NULL);
//   70 					}
//   71 					else
//   72 					#endif
//   73 					{
//   74 						tmplen = 0;
??IORUTask_2:
        MOVS     R2,#+0
//   75 						if(SystemTypeInfo < 2)
        LDRB     R0,[R8, #+0]
        CMP      R0,#+2
        BCS.N    ??IORUTask_3
//   76 						{
//   77 							tmplen = (INT8U)GenIORUAidSts(IORUSndBuff);
        LDR      R0,[R7, #+4]
        BL       GenIORUAidSts
        MOV      R2,R0
//   78 						}
//   79 						pBodyFrameTx(id0, id1, id2, (INT8U *)IORUSndBuff, tmplen, StatusQue, nPtr, NULL);
??IORUTask_3:
        MOVS     R1,#+0
        MOV      R0,R4
        PUSH     {R0,R1}
        UXTB     R0,R2
        PUSH     {R0,R1}
        LDR      R3,[R7, #+4]
??IORUTask_4:
        LDRB     R2,[SP, #+16]
        LDRB     R1,[SP, #+17]
        LDRB     R0,[SP, #+18]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//   80 					}
//   81 					OSTimeDly(500L);
        MOV      R0,#+500
        BL       OSTimeDly
//   82 				}
//   83 			}
//   84 		}
//   85 		OSTimeDly(200L);
??IORUTask_5:
        MOVS     R0,#+200
        BL       OSTimeDly
??IORUTask_1:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+0
        BNE.N    ??IORUTask_5
        ADD      R1,SP,#+4
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ      R0,??IORUTask_6
        MOV      R0,R4
        BL       WRCS_ProtocolCheck
        CBZ      R0,??IORUTask_6
        MOV      R0,R4
        BL       ProtocolComCheck
        BL       IORULinkFailRst
        MOVS     R0,#+1
        BL       IORURxLED
        B.N      ??IORUTask_5
??IORUTask_6:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CMP      R0,#+0
        BNE.N    ??IORUTask_5
        BL       IORUCheckInstalltoNext
        CMP      R0,#+0
        BEQ.N    ??IORUTask_5
        LDRB     R0,[R6, #+0]
        PUSH     {R0,LR}
        LDRB     R3,[R5, #+0]
        ADD      R2,SP,#+8
        ADD      R1,SP,#+9
        ADD      R0,SP,#+10
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
        LDRB     R0,[R7, #+1]
        CMP      R0,#+0
        BNE.N    ??IORUTask_2
        MOVS     R1,#+0
        MOV      R0,R4
        PUSH     {R0,R1}
        MOVS     R1,#+96
        MOVS     R0,#+0
        PUSH     {R0,R1}
        MOVS     R3,#+0
        B.N      ??IORUTask_4
        DATA
??IORUTask_0:
        DC32     SystemTypeInfo
        DC32     MyDnrID
        DC32     MyRmtID
        DC32     tTestFlag
//   86 	}
//   87 }
//   88 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   89 INT8U IORUInsertCheck(void)
//   90 {
//   91 	return (BitRead(MySts->OTUInfo, mInstall));
IORUInsertCheck:
        LDR.N    R0,??DataTable9  ;; MySts
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+136]
        LSRS     R0,R0,#+2
        AND      R0,R0,#0x1
        BX       LR               ;; return
//   92 }
//   93 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   94 void IORUTxLED(INT8U tmpset)
//   95 {
//   96 	if(tmpset){
IORUTxLED:
        LDR.N    R1,??DataTable3  ;; 0x4001100c
        CMP      R0,#+0
        LDR      R0,[R1, #+0]
        BEQ.N    ??IORUTxLED_0
//   97 		TX0LEDON()
        ORR      R0,R0,#0x40
        STR      R0,[R1, #+0]
        LDR      R0,[R1, #+0]
        BIC      R0,R0,#0x100
        STR      R0,[R1, #+0]
//   98 		TimerRegist(TimerTx0Led, Time10mSec*25L);
        MOVS     R1,#+250
        MOVS     R0,#+19
        B.W      TimerRegist
//   99 	}
//  100 	else
//  101 		TX0LEDOFF()
??IORUTxLED_0:
        BIC      R0,R0,#0x40
        STR      R0,[R1, #+0]
        LDR      R0,[R1, #+0]
        BIC      R0,R0,#0x100
        STR      R0,[R1, #+0]
//  102 }
        BX       LR               ;; return
//  103 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  104 void IORURxLED(INT8U tmpset)
//  105 {
IORURxLED:
        PUSH     {R4,LR}
//  106 	if(tmpset){
        LDR.N    R4,??DataTable3  ;; 0x4001100c
        CBZ      R0,??IORURxLED_0
//  107 		TimerRegist(TimerRx0Led, Time10mSec*25L);
        MOVS     R1,#+250
        MOVS     R0,#+20
        BL       TimerRegist
//  108 		RX0LEDON()
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x80
        B.N      ??IORURxLED_1
//  109 	}
//  110 	else
//  111 		RX0LEDOFF()
??IORURxLED_0:
        LDR      R0,[R4, #+0]
        BIC      R0,R0,#0x80
??IORURxLED_1:
        STR      R0,[R4, #+0]
        LDR      R0,[R4, #+0]
        BIC      R0,R0,#0x200
        STR      R0,[R4, #+0]
//  112 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     0x4001100c
//  113 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  114 INT8U IORUCheckInstalltoNext(void)
//  115 {
IORUCheckInstalltoNext:
        PUSH     {R7,LR}
//  116 
//  117 	if(IORUInsertCheck())	return TRUE;
        BL       IORUInsertCheck
        CMP      R0,#+0
        BEQ.N    ??IORUCheckInstalltoNext_0
        MOVS     R0,#+1
        POP      {R1,PC}
//  118 	else{
//  119 		IORULinkFailRst();
??IORUCheckInstalltoNext_0:
        BL       IORULinkFailRst
//  120 		IsItGetIOURInform = FALSE;
        LDR.N    R0,??DataTable8  ;; IORULinkFailCnt
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
//  121 	}
//  122 	return FALSE;
        MOVS     R0,#+0
        POP      {R1,PC}          ;; return
//  123 }
//  124 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 INT8U IsItReallIORUInsert(void)
//  126 {
IsItReallIORUInsert:
        PUSH     {R7,LR}
//  127 	if(IORUInsertCheck() && !BitRead(MySts->OTUInfo, mLinkFail)) return TRUE;
        BL       IORUInsertCheck
        CBZ      R0,??IsItReallIORUInsert_0
        LDR.N    R0,??DataTable9  ;; MySts
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+136]
        TST      R0,#0x1
        BNE.N    ??IsItReallIORUInsert_0
        MOVS     R0,#+1
        POP      {R1,PC}
//  128 	return FALSE;
??IsItReallIORUInsert_0:
        MOVS     R0,#+0
        POP      {R1,PC}          ;; return
//  129 }
//  130 
//  131 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  132 void IORULinkFailCheck(void)
//  133 {
//  134 	if((++IORULinkFailCnt > 20))
IORULinkFailCheck:
        LDR.N    R0,??DataTable8  ;; IORULinkFailCnt
        LDRB     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+0]
        UXTB     R1,R1
        CMP      R1,#+21
        BCC.N    ??IORULinkFailCheck_0
//  135 	{
//  136 		IORULinkFailCnt = 30;
        MOVS     R1,#+30
        STRB     R1,[R0, #+0]
//  137 		IsItGetIOURInform = FALSE;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
//  138 		BitSet(MySts->OTUInfo, mLinkFail);
        LDR.N    R0,??DataTable9  ;; MySts
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+136]
        ORR      R2,R2,#0x1
        STRB     R2,[R1, #+136]
//  139 		BitSet(MySts->COTInfo, mLinkFail);
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+135]
        ORR      R2,R2,#0x1
        STRB     R2,[R1, #+135]
//  140 		BitSet(MySts->RTInfo, mLinkFail);
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+137]
        ORR      R2,R2,#0x1
        STRB     R2,[R1, #+137]
//  141 
//  142 		MySts->DnrAlm.LinkFail = SET;
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+1]
//  143    	}
//  144 }
??IORULinkFailCheck_0:
        BX       LR               ;; return
//  145 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  146 void IORULinkFailRst(void)
//  147 {
//  148 	IORULinkFailCnt = 0;
IORULinkFailRst:
        LDR.N    R0,??DataTable8  ;; IORULinkFailCnt
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  149 	BitRst(MySts->OTUInfo, mLinkFail);
        LDR.N    R0,??DataTable9  ;; MySts
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+136]
        AND      R2,R2,#0xFE
        STRB     R2,[R1, #+136]
//  150 	BitRst(MySts->COTInfo, mLinkFail);
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+135]
        AND      R2,R2,#0xFE
        STRB     R2,[R1, #+135]
//  151 	BitRst(MySts->RTInfo, mLinkFail);
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+137]
        AND      R2,R2,#0xFE
        STRB     R2,[R1, #+137]
//  152 	MySts->DnrAlm.LinkFail = RESET;
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+1]
        BIC      R1,R1,#0x2
        STRB     R1,[R0, #+1]
//  153 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     IORULinkFailCnt

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     MySts

        END
//  154 ////////////////////////////////////////////////////////////////////////////////
//  155 // End of Source File
//  156 /////////////////////////
//  157 
// 
// 3 172 bytes in section .bss
//     8 bytes in section .data
//   628 bytes in section .text
// 
//   628 bytes of CODE memory
// 3 180 bytes of DATA memory
//
//Errors: none
//Warnings: none
