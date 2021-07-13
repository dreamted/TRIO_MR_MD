///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jun/2011  18:42:12 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1. /
//                    0\code\aa_rcs.c                                         /
//    Command line =  "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1 /
//                    .0\code\aa_rcs.c" -lcN "C:\user\project\HFR             /
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
//                    0\sout\aa_rcs.s                                         /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_rcs

        EXTERN ALLResetFlag
        EXTERN Crc16Calc
        EXTERN DataCount
        EXTERN DnrSer0
        EXTERN DnrSts
        EXTERN DownLoadBootingJump
        EXTERN DownloadFlagSetExtSRAM
        EXTERN FrameCnt
        EXTERN GenModuleAutoInformSts
        EXTERN IORUSer
        EXTERN IsItRtnMySysIDtoVAL
        EXTERN MyDnrID
        EXTERN MyPortID
        EXTERN MyRstCase
        EXTERN MySts
        EXTERN OSSemCreate
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ResetCaseBackup
        EXTERN RoadBackuptobuffer
        EXTERN SerPtr
        EXTERN ServAlmSndCnt
        EXTERN ServRstAlmFlag
        EXTERN SetDnrCtrlData
        EXTERN Swcrc16
        EXTERN SystemTypeInfo
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN TotFrame
        EXTERN UpLoadExtSRAM
        EXTERN WRCS_DownLoadGiveupTimerSet
        EXTERN Wrcs1
        EXTERN WriteBuffertoBackup
        EXTERN convinfo
        EXTERN memcmp
        EXTERN pBodyFrameTx
        EXTERN pUSART4
        EXTERN rambackup
        EXTERN strlen
        EXTERN tTestFlag

        PUBLIC RCSAnalyzeAidData
        PUBLIC RCSComCheck
        PUBLIC RCSDataAckTx
        PUBLIC RCSDownloadFunc
        PUBLIC RCSGenAidSts
        PUBLIC RCSProtocolCheck
        PUBLIC RCSReceiveData
        PUBLIC RCSSerInit
        PUBLIC RCSStsCheckConnectionRst
        PUBLIC RCSStsCheckConnectionSet
        PUBLIC RCSTask
        PUBLIC RcsPadOnFlag
        PUBLIC RcsSer
        PUBLIC RcsSerB
        PUBLIC Rwrcs
        PUBLIC Swrcs
        PUBLIC WhatRxRCS

// C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1.0\code\aa_rcs.c
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
//   15  * $Revision date: 2006.03.__
//   16  *
//   17  ******************************************************************************/
//   18 #define RCS_C
//   19 //#define RCS_DEBUG
//   20 
//   21 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// __SKProtocolPtr __data RcsSerB
RcsSerB:
        DS8 48

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data RcsPadOnFlag
RcsPadOnFlag:
        DATA
        DC8 0
        DC8 0, 0, 0
// __SKProtocolPtr *__data RcsSer
RcsSer:
        DC32 RcsSerB
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __SKProtocolSIO __data Swrcs
Swrcs:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __SKProtocolSIO __data Rwrcs
Rwrcs:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   22 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   23 void RCSSerInit(void)
//   24 {
RCSSerInit:
        PUSH     {R4,LR}
//   25 	RcsSer->CheckByte = pUSART4.CheckByte;
        LDR.W    R4,??DataTable30  ;; RcsPadOnFlag
        LDR      R0,[R4, #+4]
        LDR.N    R1,??RCSSerInit_0  ;; pUSART4
        LDR      R2,[R1, #+4]
        STR      R2,[R0, #+0]
//   26 	RcsSer->RxGetByte = pUSART4.RxGetByte;
        LDR      R2,[R1, #+8]
        STR      R2,[R0, #+4]
//   27 	RcsSer->PutStr = pUSART4.PutStr;
        LDR      R2,[R1, #+12]
        STR      R2,[R0, #+8]
//   28 	RcsSer->TxClear = pUSART4.TxClear;
        LDR      R2,[R1, #+36]
        STR      R2,[R0, #+12]
//   29 	RcsSer->TxCheckByte = pUSART4.TxCheckByte;
        LDR      R2,[R1, #+28]
        STR      R2,[R0, #+16]
//   30 	RcsSer->printf = pUSART4.printf;
        LDR      R2,[R1, #+16]
        STR      R2,[R0, #+20]
//   31 	RcsSer->BuffClear = pUSART4.BuffClear;
        LDR      R1,[R1, #+32]
        STR      R1,[R0, #+24]
//   32 
//   33 	RcsSer->TimerRx = TimerRcsRx;
        MOVS     R1,#+17
        STRH     R1,[R0, #+28]
//   34 	RcsSer->TimerEndWait = TimerRcsEndWait;
        MOVS     R1,#+18
        STRH     R1,[R0, #+30]
//   35 	RcsSer->ctrlsrc = NULL;			//
        MOVS     R1,#+0
        STR      R1,[R0, #+32]
//   36 		
//   37 	RcsSer->Recv = &Rwrcs;
        ADD      R1,R4,#+1304
        STR      R1,[R0, #+36]
//   38 	RcsSer->Send = &Swrcs;
        ADD      R1,R4,#+1032
        STR      R1,[R0, #+40]
//   39 	RcsSer->Sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+4]
        STR      R0,[R1, #+44]
//   40 	RcsSer->printf("RCS PORT INIT: 19200bpS \n");
        LDR.N    R0,??RCSSerInit_0+0x4  ;; `?<Constant "RCS PORT INIT: 19200b...">`
        LDR      R1,[R1, #+20]
        BLX      R1
//   41 
//   42 	OSTaskCreate(RCSTask, (void *)0, (OS_STK *)&RcsTaskStk[RCS_START_STK_SIZE - 1], RCS_START_PRIO);
        MOVS     R3,#+3
        ADDW     R2,R4,#+1028
        MOVS     R1,#+0
        LDR.N    R0,??RCSSerInit_0+0x8  ;; RCSTask
        POP      {R4,LR}
        B.W      OSTaskCreate
        DATA
??RCSSerInit_0:
        DC32     pUSART4
        DC32     `?<Constant "RCS PORT INIT: 19200b...">`
        DC32     RCSTask
//   43 
//   44 }
//   45 
//   46 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   47 void RCSTask(void *p_arg)
//   48 {
RCSTask:
        PUSH     {R3-R5,LR}
//   49 	p_arg = p_arg;
//   50 
//   51 	__SKProtocolPtr *nPtr = (__SKProtocolPtr *)RcsSer;
        LDR.W    R0,??DataTable30  ;; RcsPadOnFlag
        LDR      R4,[R0, #+4]
//   52 
//   53 	OSTimeDly(RCS_START_PRIO*100L);
        MOV      R0,#+300
        BL       OSTimeDly
        LDR.N    R5,??RCSTask_0   ;; tTestFlag
//   54 	
//   55 	while(1)
//   56 	{
//   57 		if(!tTestFlag)
??RCSTask_1:
        LDRB     R0,[R5, #+0]
        CBNZ     R0,??RCSTask_2
//   58 		{
//   59 #ifdef 	RCS_DEBUG
//   60 			INT16U nCnt;
//   61 
//   62 			while(nPtr->CheckByte(1, &nCnt))
//   63 			{
//   64 				INT8U tmp = nPtr->RxGetByte();
//   65 				nPtr->PutStr(&tmp, 1, TRUE);
//   66 			}
//   67 #else
//   68 			RCSStsCheckConnectionRst(nPtr);
        MOV      R0,R4
        BL       RCSStsCheckConnectionRst
//   69 
//   70 			if(RCSProtocolCheck(nPtr))
        MOV      R0,R4
        BL       RCSProtocolCheck
        CBZ      R0,??RCSTask_2
//   71 			{			
//   72 				RCSStsCheckConnectionSet(nPtr);
        MOV      R0,R4
        BL       RCSStsCheckConnectionSet
//   73 				RCSComCheck(nPtr);
        MOV      R0,R4
        BL       RCSComCheck
//   74 			}
//   75 #endif		
//   76 	    }
//   77 		OSTimeDly(200L);
??RCSTask_2:
        MOVS     R0,#+200
        BL       OSTimeDly
        B.N      ??RCSTask_1
        DATA
??RCSTask_0:
        DC32     tTestFlag
//   78 	}
//   79 }
//   80 
//   81 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   82 INT8U WhatRxRCS(__SKProtocolPtr *nPtr)
//   83 {
//   84 	INT16U RetVal = 0;
//   85 
//   86 	//SIOⅴ BODY is ONLY ONE(1)
//   87 	if(nPtr->Recv->BODYFRAME.CrcOK)	// CRC OK
WhatRxRCS:
        LDR      R0,[R0, #+36]
        LDRB     R1,[R0, #+268]
        CMP      R1,#+0
        BEQ.N    ??WhatRxRCS_0
//   88 	{
//   89 		RetVal = nPtr->Recv->BODYFRAME.Command;
        LDRB     R0,[R0, #+6]
        BX       LR
//   90 	}
//   91 	else //NO ERROR
//   92 	{
//   93 		//ERROR CASE
//   94 		RetVal = crcERROR;
??WhatRxRCS_0:
        MOVS     R0,#+239
//   95 	}
//   96     return (RetVal);	
        BX       LR               ;; return
//   97 }
//   98 
//   99 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  100 void RCSComCheck (__SKProtocolPtr *nPtr)
//  101 {
RCSComCheck:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+12
        MOV      R10,R0
//  102 	INT8U tcnt = 0;
        MOV      R8,#+0
//  103 
//  104 	__SKProtocolSIO *Recv = nPtr->Recv;
//  105 	__SKProtocolSIO *Send = nPtr->Send;
        LDR      R0,[R10, #+40]
//  106 
//  107 	__RCSBODYFRAME *rBody = &Recv->BODYFRAME;
        LDR      R1,[R10, #+36]
        ADDS     R4,R1,#+4
//  108 	__RCSBODYFRAME *sBody = &Send->BODYFRAME;
        ADDS     R0,R0,#+4
        STR      R0,[SP, #+4]
//  109 
//  110 	INT8U id0 = rBody->SubID[0];
        LDRB     R5,[R4, #+5]
//  111 	INT8U id1 = rBody->SubID[1];
        LDRB     R11,[R4, #+6]
//  112 	INT8U id2 = 0xff;
//  113 
//  114 	INT8U Comm = WhatRxRCS(nPtr);
        MOV      R0,R10
        BL       WhatRxRCS
        MOV      R7,R0
//  115 	INT8U RSPSComm;
//  116 	
//  117 	INT8U tmpDnr = 0;
        STRH     R8,[SP, #+0]
//  118 	INT8U tmpRmt = 0;
//  119 
//  120 	INT8U IsItMyID = IsItRtnMySysIDtoVAL(id0, id1, id2, &tmpDnr, &tmpRmt);
        ADD      R0,SP,#+1
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+255
        MOV      R1,R11
        MOV      R0,R5
        BL       IsItRtnMySysIDtoVAL
        ADD      SP,SP,#+8
        MOV      R9,R0
        LDR.W    R0,??Subroutine0_0  ;; MyPortID
        LDRB     R0,[R0, #+0]
        LDRB     R1,[R4, #+0]
        CMP      R0,R1
        BEQ.N    ??RCSComCheck_0
//  121 	INT32U sptr = 0;
//  122 
//  123 
//  124 	if(MyPortID != rBody->PortID)
//  125 	{
//  126 		INT32U cpu_sr;
//  127 		EE_BACK1 *tptr;
//  128 		
//  129 		tmpDnr = id1%DnrMaxID;
        LSR      R1,R11,#+1
        SUB      R0,R11,R1, LSL #+1
        STRB     R0,[SP, #+0]
//  130 
//  131 		OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        STR      R0,[SP, #+8]
        LDR.W    R0,??DataTable24  ;; 0x8006000
//  132 		
//  133 		tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);	// Load 1st Area	
        BL       RoadBackuptobuffer
//  134 		
//  135 		tptr->BackUp.PortID = rBody->PortID;
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+26]
//  136 
//  137 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+80
        LDR.W    R0,??DataTable24  ;; 0x8006000
        BL       WriteBuffertoBackup
//  138 
//  139 		OS_EXIT_CRITICAL();
        LDR      R0,[SP, #+8]
        BL       OS_CPU_SR_Restore
//  140 
//  141 		MyPortID = rBody->PortID;
        LDR.W    R0,??Subroutine0_0+0x4  ;; MyPortID
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+0]
//  142 		SerPtr->printf("PORTID CHANGED %02x\n", rBody->PortID);
        LDRB     R1,[R4, #+0]
        LDR.W    R0,??Subroutine0_0+0x8  ;; `?<Constant "PORTID CHANGED %02x\\n">`
        LDR.W    R2,??DataTable15  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
??RCSComCheck_0:
        MOVS     R0,R7
        BEQ.N    ??RCSComCheck_1
        CMP      R7,#+1
        BEQ.N    ??RCSComCheck_2
        CMP      R7,#+2
        BEQ.W    ??RCSComCheck_3
        CMP      R7,#+3
        BEQ.N    ??RCSComCheck_2
        CMP      R7,#+4
        BEQ.W    ??RCSComCheck_4
        CMP      R7,#+32
        BEQ.W    ??RCSComCheck_5
        CMP      R7,#+96
        BEQ.W    ??RCSComCheck_6
        B.N      ??RCSComCheck_7
//  143 	}
//  144 
//  145 	#ifdef RCS_DBG
//  146 	PcSer->PutStr((INT8U *)Recv, 4 + 7 + (rBody->SubLen - 3) + 2, ENABLE);
//  147 	#endif
//  148 	
//  149 	switch(Comm)	//command 眉农
//  150 	{	
//  151 		case RCSStatusRQST:
//  152 			
//  153 			tcnt = RCSGenAidSts(sBody->SubData, &DnrSts[tmpDnr][tmpRmt]);  
??RCSComCheck_1:
        LDRB     R0,[SP, #+1]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+0]
        MOVW     R3,#+538
        LDR.W    R4,??DataTable25  ;; DnrSts
        MLA      R2,R2,R3,R4
        MLA      R1,R0,R1,R2
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+7
        BL       RCSGenAidSts
        MOV      R2,R0
//  154 			RCSDataAckTx(id0, id1, (INT8U *)sBody->SubData, tcnt, MyPortID, RCSStatusRSPS);
        MOVS     R1,#+128
??RCSComCheck_8:
        LDR.W    R0,??Subroutine0_0+0xC  ;; MyPortID
        LDRB     R0,[R0, #+0]
        PUSH     {R0,R1}
        UXTB     R3,R2
??RCSComCheck_9:
        LDR      R0,[SP, #+12]
        ADDS     R2,R0,#+7
        B.N      ??RCSComCheck_10
//  155 		break;
//  156 
//  157 		case RCSControlRQST:
//  158 		case RCSAlarmMaskSetRQST:
//  159 
//  160 			sptr = WRCS_DownLoadGiveupTimerSet(NULL);
??RCSComCheck_2:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
//  161 
//  162 			if(sptr) { if(sptr != (INT32U)nPtr) return; }
        CBZ      R0,??RCSComCheck_11
        CMP      R0,R10
        BNE.W    ??RCSComCheck_12
//  163 			
//  164 			if(SystemTypeInfo < 2) {
??RCSComCheck_11:
        LDR.N    R0,??Subroutine0_0+0x10  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.W    ??RCSComCheck_13
//  165 				if(IsItMyID){
        CMP      R9,#+0
        BEQ.N    ??RCSComCheck_14
//  166 					switch(Comm)
        CMP      R7,#+1
        BEQ.N    ??RCSComCheck_15
??RCSComCheck_16:
        CMP      R7,#+3
        BEQ.N    ??RCSComCheck_17
        B.N      ??RCSComCheck_18
//  167 					{
//  168 						case RCSControlRQST:
//  169 							
//  170 							RCSAnalyzeAidData(nPtr, TRUE, tmpDnr, tmpRmt);
??RCSComCheck_15:
        LDRB     R3,[SP, #+1]
        LDRB     R2,[SP, #+0]
        MOVS     R1,#+1
        MOV      R0,R10
        BL       RCSAnalyzeAidData
//  171 							if(!ALLResetFlag)
        LDR.N    R0,??Subroutine0_0+0x14  ;; ALLResetFlag
        LDRB     R0,[R0, #+0]
        CBNZ     R0,??RCSComCheck_19
//  172 							{
//  173 								tcnt = RCSGenAidSts(sBody->SubData, &DnrSts[tmpDnr][tmpRmt]);
        LDRB     R0,[SP, #+1]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+0]
        MOVW     R3,#+538
        LDR.W    R4,??DataTable25  ;; DnrSts
        MLA      R2,R2,R3,R4
        MLA      R1,R0,R1,R2
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+7
        BL       RCSGenAidSts
        MOV      R8,R0
//  174 								RSPSComm = RCSControlRSPS;
        MOVS     R6,#+129
        B.N      ??RCSComCheck_18
//  175 							}
//  176 							else
//  177 							{
//  178 								RSPSComm = ControlQue;
//  179 								pBodyFrameTx(id0, id1, 0xff, (INT8U *)rBody->SubData, (rBody->SubLen - 3), RSPSComm, IORUSer, (__ProtocolPtr *)nPtr);
??RCSComCheck_19:
        MOV      R1,R10
        LDR.N    R0,??Subroutine0_0+0x18  ;; IORUSer
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        MOVS     R1,#+1
        LDRB     R0,[R4, #+3]
        SUBS     R0,R0,#+3
        UXTH     R0,R0
??RCSComCheck_20:
        PUSH     {R0,R1}
        ADDS     R3,R4,#+7
        B.N      ??RCSComCheck_21
//  180 								return;
//  181 							}
//  182 						break;
//  183 						case RCSAlarmMaskSetRQST:
//  184 						{
//  185 							INT32U cpu_sr;
//  186 							EE_BACK1 *tptr;
//  187 							
//  188 							OS_ENTER_CRITICAL();
??RCSComCheck_17:
        BL       OS_CPU_SR_Save
        MOV      R7,R0
        LDR.W    R0,??DataTable24  ;; 0x8006000
//  189 							
//  190 							tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);	// Load 1st Area	
        BL       RoadBackuptobuffer
//  191 							
//  192 							DnrSts[tmpDnr][tmpRmt].AlarmMask = rBody->SubData[0] & 0x01;
        MOVW     R1,#+269
        MOVW     R2,#+538
        LDR.W    R3,??DataTable25  ;; DnrSts
        LDRB     R12,[SP, #+1]
        LDRB     LR,[SP, #+0]
        MLA      LR,LR,R2,R3
        MLA      R12,R12,R1,LR
        LDRB     R6,[R4, #+7]
        AND      R6,R6,#0x1
        STRB     R6,[R12, #+190]
//  193 							tptr->BackUp.AlarmMask = rBody->SubData[0] & 0x01;
        LDRB     R4,[R4, #+7]
        AND      R4,R4,#0x1
        STRB     R4,[R0, #+5]
//  194 							sBody->SubData[0] = DnrSts[tmpDnr][tmpRmt].AlarmMask;
        LDRB     R0,[SP, #+1]
        LDRB     R4,[SP, #+0]
        MLA      R2,R4,R2,R3
        MLA      R0,R0,R1,R2
        LDRB     R0,[R0, #+190]
        LDR      R1,[SP, #+4]
        STRB     R0,[R1, #+7]
//  195 							tcnt = 1;
        MOV      R8,#+1
//  196 							
//  197 							WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+80
        LDR.W    R0,??DataTable24  ;; 0x8006000
        BL       WriteBuffertoBackup
//  198 					
//  199 							OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  200 							RSPSComm = RCSAlarmMaskSetRSPS;
        MOVS     R6,#+131
//  201 						}
//  202 						break;
//  203 					}
//  204 					RCSDataAckTx(id0, id1, (INT8U *)sBody->SubData, tcnt, MyPortID, RSPSComm);
??RCSComCheck_18:
        LDR.N    R0,??Subroutine0_0+0x1C  ;; MyPortID
        LDRB     R0,[R0, #+0]
        UXTB     R1,R6
        PUSH     {R0,R1}
        UXTB     R3,R8
        B.N      ??RCSComCheck_9
//  205 				}
//  206 				else 
//  207 				{
//  208 						 if(Comm == RCSControlRQST)			RSPSComm = ControlQue;
??RCSComCheck_14:
        CMP      R7,#+1
        BNE.N    ??RCSComCheck_22
        MOVS     R6,#+1
        B.N      ??RCSComCheck_23
//  209 					else if(Comm == RCSAlarmMaskSetRQST)	RSPSComm = AlarmMaskSetQue;
??RCSComCheck_22:
        CMP      R7,#+3
        BNE.N    ??RCSComCheck_23
        MOVS     R6,#+3
//  210 				
//  211 					if(tmpDnr == MyDnrID && tmpRmt) 
??RCSComCheck_23:
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??Subroutine0_0+0x20  ;; MyDnrID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??RCSComCheck_24
        LDRB     R0,[SP, #+1]
        CBZ      R0,??RCSComCheck_24
//  212 					{
//  213 						//		to WRCS1
//  214 						//		SEND MY_Donor Remote !!
//  215 						//		SerPtr->printf("SEND Remote \n");
//  216 						pBodyFrameTx(id0, id1, 0xff, (INT8U *)rBody->SubData, (rBody->SubLen - 3), RSPSComm, Wrcs1, (__ProtocolPtr *)nPtr);
??RCSComCheck_25:
        MOV      R1,R10
        LDR.N    R0,??Subroutine0_0+0x24  ;; Wrcs1
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        LDRB     R0,[R4, #+3]
        SUBS     R0,R0,#+3
        UXTH     R0,R0
        UXTB     R1,R6
        B.N      ??RCSComCheck_20
//  217 					}
//  218 					else // to Another DONOR Send
//  219 					{
//  220 						pBodyFrameTx(id0, id1, 0xff, (INT8U *)rBody->SubData, (rBody->SubLen - 3), RSPSComm, DnrSer0, (__ProtocolPtr *)nPtr);
??RCSComCheck_24:
        MOV      R1,R10
        LDR.N    R0,??Subroutine0_0+0x28  ;; DnrSer0
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        LDRB     R0,[R4, #+3]
        SUBS     R0,R0,#+3
        UXTH     R0,R0
        UXTB     R1,R6
        PUSH     {R0,R1}
        ADDS     R3,R4,#+7
??RCSComCheck_21:
        MOVS     R2,#+255
        MOV      R1,R11
        MOV      R0,R5
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  221 					}
//  222 				}
//  223 			}
        B.N      ?Subroutine0
//  224 			else
//  225 			{						// REMOTE CASE !!
//  226 				if(IsItMyID){
??RCSComCheck_13:
        CMP      R9,#+0
        BEQ.N    ??RCSComCheck_26
//  227 					switch(Comm)
        CMP      R7,#+1
        BNE.W    ??RCSComCheck_16
//  228 					{
//  229 						case RCSControlRQST:
//  230 							RCSAnalyzeAidData(nPtr, TRUE, tmpDnr, tmpRmt);
        LDRB     R3,[SP, #+1]
        LDRB     R2,[SP, #+0]
        MOVS     R1,#+1
        MOV      R0,R10
        BL       RCSAnalyzeAidData
//  231 
//  232 							RSPSComm = ControlQue;
//  233 							pBodyFrameTx(id0, id1, 0xff, (INT8U *)rBody->SubData, (rBody->SubLen - 3), RSPSComm, IORUSer, (__ProtocolPtr *)nPtr);
        B.N      ??RCSComCheck_19
//  234 						return;
//  235 
//  236 						case RCSAlarmMaskSetRQST:
//  237 						{
//  238 							INT32U cpu_sr;
//  239 							EE_BACK1 *tptr;
//  240 							
//  241 							OS_ENTER_CRITICAL();
//  242 							
//  243 							tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);	// Load 1st Area	
//  244 							
//  245 							DnrSts[tmpDnr][tmpRmt].AlarmMask = rBody->SubData[0] & 0x01;
//  246 							tptr->BackUp.AlarmMask = rBody->SubData[0] & 0x01;
//  247 							sBody->SubData[0] = DnrSts[tmpDnr][tmpRmt].AlarmMask;
//  248 							tcnt = 1;
//  249 							
//  250 							WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
//  251 					
//  252 							OS_EXIT_CRITICAL();
//  253 							RSPSComm = RCSAlarmMaskSetRSPS;
//  254 						}
//  255 						break;
//  256 					}
//  257 					RCSDataAckTx(id0, id1, (INT8U *)sBody->SubData, tcnt, MyPortID, RSPSComm);
//  258 				}
//  259 				else{
//  260 				
//  261 					     if(Comm == RCSControlRQST)			RSPSComm = RvsControlRQST;
??RCSComCheck_26:
        CMP      R7,#+1
        BNE.N    ??RCSComCheck_27
        MOVS     R6,#+129
        B.N      ??RCSComCheck_25
//  262 					else if(Comm == RCSAlarmMaskSetRQST)	RSPSComm = RvsAlarmMaskSetRQST;
??RCSComCheck_27:
        CMP      R7,#+3
        BNE.N    ??RCSComCheck_25
        MOVS     R6,#+131
        B.N      ??RCSComCheck_25
//  263 
//  264 					pBodyFrameTx(id0, id1, 0xff, (INT8U *)rBody->SubData, (rBody->SubLen - 3), RSPSComm, Wrcs1, (__ProtocolPtr *)nPtr); // Send to Request
//  265 				}
//  266 			}
//  267 		break;
//  268 
//  269 		case RCSAlarmSCODERSPS:
//  270 			if(ServRstAlmFlag[tmpDnr][tmpRmt])	MyRstCase.SERVERRstCase[tmpDnr][tmpRmt] = 0x00;
??RCSComCheck_3:
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??Subroutine0_0+0x2C  ;; ServRstAlmFlag
        ADD      R1,R1,R0, LSL #+1
        LDRB     R2,[SP, #+1]
        LDRB     R3,[R2, R1]
        CMP      R3,#+0
        BEQ.N    ??RCSComCheck_28
        LDR.N    R3,??Subroutine0_0+0x30  ;; MyRstCase
        ADD      R3,R3,R0, LSL #+1
        MOVS     R4,#+0
        STRB     R4,[R2, R3]
//  271 			ServAlmSndCnt[tmpDnr][tmpRmt] = 0;
??RCSComCheck_28:
        LDR.N    R3,??Subroutine0_0+0x34  ;; ServAlmSndCnt
        ADD      R0,R3,R0, LSL #+1
        MOVS     R3,#+0
        STRB     R3,[R2, R0]
//  272 			ServRstAlmFlag[tmpDnr][tmpRmt]= 0;
        STRB     R3,[R2, R1]
        B.N      ?Subroutine0
//  273 		break;
//  274 
//  275 		case ModuleInformStsQue:
//  276 
//  277 			tcnt = GenModuleAutoInformSts(&sBody->SubData[1], tmpDnr, tmpRmt) + 1;
??RCSComCheck_6:
        LDRB     R2,[SP, #+1]
        LDRB     R1,[SP, #+0]
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+8
        BL       GenModuleAutoInformSts
        ADDS     R2,R0,#+1
//  278 			sBody->SubData[0] = 0x30;
        LDR      R0,[SP, #+4]
        MOVS     R1,#+48
        STRB     R1,[R0, #+7]
//  279 			RCSDataAckTx(id0, id1, (INT8U *)sBody->SubData, tcnt, MyPortID, ModuleInformStsQue);
        MOVS     R1,#+96
        B.N      ??RCSComCheck_8
//  280 
//  281 		break;
//  282 		
//  283 		case RCSAlarmMaskRQST:
//  284 			RCSDataAckTx(id0, id1, (INT8U *)&DnrSts[tmpDnr][tmpRmt].AlarmMask, 1, MyPortID, RCSAlarmMaskRSPS);
??RCSComCheck_4:
        MOVS     R1,#+132
        LDR.N    R0,??Subroutine0_0+0x38  ;; MyPortID
        LDRB     R0,[R0, #+0]
        PUSH     {R0,R1}
        MOVS     R3,#+1
        LDRB     R0,[SP, #+9]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+8]
        MOVW     R4,#+538
        LDR.W    R7,??DataTable25  ;; DnrSts
        MLA      R2,R2,R4,R7
        MLA      R0,R0,R1,R2
        ADD      R2,R0,#+190
??RCSComCheck_10:
        MOV      R1,R11
        MOV      R0,R5
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
        B.N      ?Subroutine0
//  285 		break;
//  286 
//  287 
//  288 		case RcsDownloadRQST:
//  289 			sptr = WRCS_DownLoadGiveupTimerSet(NULL);
??RCSComCheck_5:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
//  290 
//  291 			if(sptr) { if(sptr != (INT32U)nPtr) return; }
        CBZ      R0,??RCSComCheck_29
        CMP      R0,R10
        BNE.W    ??RCSComCheck_12
//  292 
//  293 			WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
??RCSComCheck_29:
        MOV      R0,R10
        BL       WRCS_DownLoadGiveupTimerSet
//  294 
//  295 			
//  296 			if(id0 == 0xff && id1 == 0xff)
        CMP      R5,#+255
        BNE.N    ??RCSComCheck_30
        CMP      R11,#+255
        BNE.N    ??RCSComCheck_30
//  297 			{
//  298 				WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
        MOV      R0,R10
        BL       WRCS_DownLoadGiveupTimerSet
//  299 				RCSDownloadFunc(nPtr);
??RCSComCheck_31:
        MOV      R0,R10
        BL       RCSDownloadFunc
//  300 			}
        B.N      ?Subroutine0
//  301 			else
//  302 			{
//  303 				if(SystemTypeInfo < 2) {	// DONOR CASE !!
??RCSComCheck_30:
        LDR.N    R0,??Subroutine0_0+0x3C  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        MOV      R0,R10
        BCS.N    ??RCSComCheck_32
//  304 					WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
        BL       WRCS_DownLoadGiveupTimerSet
//  305 
//  306 					if(IsItMyID)
        CMP      R9,#+0
        BEQ.N    ??RCSComCheck_33
//  307 					{					
//  308 						if(id0 == RCUID) RCSDownloadFunc(nPtr);
        CMP      R5,#+255
        BNE.N    ??RCSComCheck_34
        MOV      R0,R10
        BL       RCSDownloadFunc
        B.N      ??RCSComCheck_35
//  309 						else
//  310 							switch(rBody->SubData[0])
??RCSComCheck_34:
        LDRB     R0,[R4, #+7]
        CBZ      R0,??RCSComCheck_36
        CMP      R0,#+2
        BEQ.N    ??RCSComCheck_37
        BCC.N    ??RCSComCheck_38
        CMP      R0,#+3
        BEQ.N    ??RCSComCheck_39
        B.N      ??RCSComCheck_35
//  311 							{
//  312 								case RCSDownloadCMD:			Comm = DownloadCMD; 		break;
??RCSComCheck_36:
        MOVS     R7,#+11
        B.N      ??RCSComCheck_35
//  313 								case RCSDownloadCMDConfirm: 	Comm = DownloadCMDConfirm;	break;
//  314 								case RCSDownLoadData:			Comm = DownLoadData;		break;
??RCSComCheck_38:
        MOVS     R7,#+13
        B.N      ??RCSComCheck_35
//  315 								case RCSDownLoadDataConfirm:	Comm = DownLoadDataConfirm; break;
??RCSComCheck_37:
        MOVS     R7,#+14
//  316 							}	
//  317 						{
//  318 							pBodyFrameTx(id0, id1, 0xff, (INT8U *)&rBody->SubData[1], (rBody->SubLen - 4), Comm, IORUSer, (__ProtocolPtr *)nPtr);
??RCSComCheck_35:
        MOV      R1,R10
        LDR.N    R0,??Subroutine0_0+0x40  ;; IORUSer
??RCSComCheck_40:
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        MOV      R1,R7
        LDRB     R0,[R4, #+3]
        SUBS     R0,R0,#+4
        UXTH     R0,R0
        PUSH     {R0,R1}
        ADD      R3,R4,#+8
        B.N      ??RCSComCheck_21
//  319 						}
//  320 					}
//  321 					else
//  322 					{						
//  323 						switch(rBody->SubData[0])
??RCSComCheck_33:
        LDRB     R0,[R4, #+7]
        CBZ      R0,??RCSComCheck_41
        CMP      R0,#+2
        BEQ.N    ??RCSComCheck_42
        BCC.N    ??RCSComCheck_43
        CMP      R0,#+3
        BEQ.N    ??RCSComCheck_44
        B.N      ??RCSComCheck_45
//  324 						{
//  325 							case RCSDownloadCMD:			Comm = DownloadCMD; 		break;
??RCSComCheck_41:
        MOVS     R7,#+11
        B.N      ??RCSComCheck_45
//  326 							case RCSDownloadCMDConfirm: 	Comm = DownloadCMDConfirm;	break;
??RCSComCheck_44:
        MOVS     R7,#+12
        B.N      ??RCSComCheck_45
//  327 							case RCSDownLoadData:			Comm = DownLoadData;		break;
??RCSComCheck_43:
        MOVS     R7,#+13
        B.N      ??RCSComCheck_45
//  328 							case RCSDownLoadDataConfirm:	Comm = DownLoadDataConfirm; break;
??RCSComCheck_42:
        MOVS     R7,#+14
//  329 						}
//  330 						
//  331 						if(tmpDnr == MyDnrID && tmpRmt)
??RCSComCheck_45:
        LDRB     R0,[SP, #+0]
        LDR.N    R1,??Subroutine0_0+0x44  ;; MyDnrID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??RCSComCheck_46
        LDRB     R0,[SP, #+1]
        CBZ      R0,??RCSComCheck_46
//  332 						{
//  333 							//		to WRCS1
//  334 							//		SEND MY_Donor Remote !!
//  335 							//		SerPtr->printf("SEND Remote \n");
//  336 							pBodyFrameTx(id0, id1, 0xff, (INT8U *)&rBody->SubData[1], (rBody->SubLen - 4), Comm, Wrcs1, (__ProtocolPtr *)nPtr);
??RCSComCheck_47:
        MOV      R1,R10
        LDR.N    R0,??Subroutine0_0+0x48  ;; Wrcs1
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        MOV      R1,R7
        LDRB     R0,[R4, #+3]
        SUBS     R0,R0,#+4
        UXTH     R0,R0
        PUSH     {R0,R1}
        ADD      R3,R4,#+8
        B.N      ??RCSComCheck_21
//  337 						}
//  338 						else // to Another DONOR Send
//  339 						{
//  340 							pBodyFrameTx(id0, id1, 0xff, (INT8U *)&rBody->SubData[1], (rBody->SubLen - 4), Comm, DnrSer0, (__ProtocolPtr *)nPtr);
??RCSComCheck_46:
        MOV      R1,R10
        LDR.N    R0,??Subroutine0_0+0x4C  ;; DnrSer0
        B.N      ??RCSComCheck_40
//  341 						}
//  342 					}
//  343 				}			
//  344 				else {						// REMOTE CASE !!
//  345 					WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
??RCSComCheck_32:
        BL       WRCS_DownLoadGiveupTimerSet
//  346 
//  347 					if(IsItMyID){
        CMP      R9,#+0
        BEQ.N    ??RCSComCheck_48
//  348 						if(id0 == RCUID) RCSDownloadFunc(nPtr);
        CMP      R5,#+255
        BEQ.N    ??RCSComCheck_31
//  349 						else
//  350 						{
//  351 							switch(rBody->SubData[0])
        LDRB     R0,[R4, #+7]
        CMP      R0,#+0
        BEQ.N    ??RCSComCheck_36
        CMP      R0,#+2
        BEQ.N    ??RCSComCheck_37
        BCC.N    ??RCSComCheck_38
        CMP      R0,#+3
        BNE.N    ??RCSComCheck_35
//  352 							{
//  353 								case RCSDownloadCMD:			Comm = DownloadCMD; 		break;
//  354 								case RCSDownloadCMDConfirm: 	Comm = DownloadCMDConfirm;	break;
//  355 								case RCSDownLoadData:			Comm = DownLoadData;		break;
//  356 								case RCSDownLoadDataConfirm:	Comm = DownLoadDataConfirm; break;
//  357 							}	
//  358 							pBodyFrameTx(id0, id1, 0xff, (INT8U *)&rBody->SubData[1], (rBody->SubLen - 4), Comm, IORUSer, (__ProtocolPtr *)nPtr);
//  359 						}
//  360 					}
??RCSComCheck_39:
        MOVS     R7,#+12
        B.N      ??RCSComCheck_35
//  361 					else{
//  362 						switch(rBody->SubData[0])
??RCSComCheck_48:
        LDRB     R0,[R4, #+7]
        CBZ      R0,??RCSComCheck_49
        CMP      R0,#+2
        BEQ.N    ??RCSComCheck_50
        BCC.N    ??RCSComCheck_51
        CMP      R0,#+3
        BEQ.N    ??RCSComCheck_52
        B.N      ??RCSComCheck_47
//  363 						{
//  364 							case RCSDownloadCMD:			Comm = RvsDownloadCMDRQST; 			break;
??RCSComCheck_49:
        MOVS     R7,#+139
        B.N      ??RCSComCheck_47
//  365 							case RCSDownloadCMDConfirm: 	Comm = RvsDownloadCMDConfirmRQST;	break;
??RCSComCheck_52:
        MOVS     R7,#+140
        B.N      ??RCSComCheck_47
//  366 							case RCSDownLoadData:			Comm = RvsDownLoadDataRQST;			break;
??RCSComCheck_51:
        MOVS     R7,#+141
        B.N      ??RCSComCheck_47
//  367 							case RCSDownLoadDataConfirm:	Comm = RvsDownLoadDataConfirmRQST; 	break;
??RCSComCheck_50:
        MOVS     R7,#+142
        B.N      ??RCSComCheck_47
//  368 						}	
//  369 						pBodyFrameTx(id0, id1, 0xff, (INT8U *)&rBody->SubData[1], (rBody->SubLen - 4), Comm, Wrcs1, (__ProtocolPtr *)nPtr);
//  370 					}
//  371 				}
//  372 			}
//  373 	break;
//  374 
//  375 	default:
//  376 		SerPtr->printf("id0 = %02x, id1 = %02x Comm = %02x\n", id0, id1, Comm);
??RCSComCheck_7:
        MOV      R3,R7
        MOV      R2,R11
        MOV      R1,R5
        LDR.N    R0,??Subroutine0_0+0x50  ;; `?<Constant "PORTID CHANGED %02x\\n">` + 24
        LDR.N    R4,??DataTable15  ;; SerPtr
        LDR      R4,[R4, #+0]
        LDR      R4,[R4, #+16]
        BLX      R4
??RCSComCheck_12:
        Nop      
//  377 	break;
//  378 	}
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  379 	
//  380 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine0:
        ADD      SP,SP,#+12
        POP      {R4-R11,PC}      ;; return
        Nop      
        DATA
??Subroutine0_0:
        DC32     MyPortID
        DC32     MyPortID
        DC32     `?<Constant "PORTID CHANGED %02x\\n">`
        DC32     MyPortID
        DC32     SystemTypeInfo
        DC32     ALLResetFlag
        DC32     IORUSer
        DC32     MyPortID
        DC32     MyDnrID
        DC32     Wrcs1
        DC32     DnrSer0
        DC32     ServRstAlmFlag
        DC32     MyRstCase
        DC32     ServAlmSndCnt
        DC32     MyPortID
        DC32     SystemTypeInfo
        DC32     IORUSer
        DC32     MyDnrID
        DC32     Wrcs1
        DC32     DnrSer0
        DC32     `?<Constant "PORTID CHANGED %02x\\n">` + 24
//  381 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  382 INT8U RCSDownloadFunc (__SKProtocolPtr *nPtr)
//  383 {
RCSDownloadFunc:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+16
//  384 
//  385 	__SKProtocolSIO *Recv = nPtr->Recv;
//  386 	__RCSBODYFRAME *rBody = &Recv->BODYFRAME;
        LDR      R1,[R0, #+36]
        ADDS     R4,R1,#+4
//  387 
//  388 	INT8U tmpData[10] = {0,};
        LDR.N    R5,??RCSDownloadFunc_0  ;; `?<Constant {0}>`
        ADD      R1,SP,#+0
        LDM      R5!,{R2,R3,R6}
        STM      R1!,{R2,R3,R6}
        SUBS     R5,R5,#+12
//  389 	INT8U tmpLen = 0;
//  390 
//  391 	INT8U id0 = rBody->SubID[0];
        LDRB     R6,[R4, #+5]
//  392 	INT8U id1 = rBody->SubID[1];
        LDRB     R7,[R4, #+6]
//  393 
//  394 	tmpData[tmpLen++] = rBody->SubData[0];
        LDRB     R1,[R4, #+7]
        STRB     R1,[SP, #+0]
        MOV      R8,#+1
//  395 	
//  396 	switch(rBody->SubData[0])
        LDRB     R1,[R4, #+7]
        CBZ      R1,??RCSDownloadFunc_1
        CMP      R1,#+2
        BEQ.N    ??RCSDownloadFunc_2
        BCC.N    ??RCSDownloadFunc_3
        CMP      R1,#+3
        BEQ.N    ??RCSDownloadFunc_4
        B.N      ??RCSDownloadFunc_5
//  397 	{
//  398 		case RCSDownloadCMD:
//  399 			tmpData[tmpLen++] = RCSACK;
??RCSDownloadFunc_1:
        ADD      R1,SP,#+0
        MOVS     R0,#+0
        STRB     R0,[R1, #+1]
//  400 			tmpData[tmpLen++] = rBody->SubData[1];	// version
        LDRB     R0,[R4, #+8]
        STRB     R0,[R1, #+2]
//  401 			tmpData[tmpLen++] = rBody->SubData[2];	// 1st frame high
        LDRB     R0,[R4, #+9]
        STRB     R0,[R1, #+3]
//  402 			tmpData[tmpLen++] = rBody->SubData[3];	// 2nd fram low
        LDRB     R0,[R4, #+10]
        STRB     R0,[R1, #+4]
        MOV      R8,#+5
//  403 			TotFrame = ((rBody->SubData[2] << 8) | rBody->SubData[3]);
        LDRB     R0,[R4, #+9]
        LDRB     R1,[R4, #+10]
        ORR      R0,R1,R0, LSL #+8
        LDR.N    R1,??RCSDownloadFunc_0+0x4  ;; TotFrame
        STRH     R0,[R1, #+0]
        B.N      ??RCSDownloadFunc_5
//  404 		break;
//  405 		
//  406 		case RCSDownloadCMDConfirm:
//  407 			{
//  408 				INT32U cpu_sr;
//  409 				OS_ENTER_CRITICAL();
??RCSDownloadFunc_4:
        BL       OS_CPU_SR_Save
//  410 				#ifdef __EXT_RAM_USED
//  411 					tmpData[tmpLen++] = RCSACK;
        MOVS     R1,#+0
        STRB     R1,[SP, #+1]
        MOV      R8,#+2
//  412 				#else
//  413 					if(!FLASHpAPBK_Check_Erase())
//  414 					{
//  415 						tmpData[tmpLen++] = RCSNACK;
//  416 					}
//  417 					else
//  418 						tmpData[tmpLen++] = RCSACK;
//  419 				#endif
//  420 
//  421 				OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
        B.N      ??RCSDownloadFunc_5
//  422 			}
//  423 		break;
//  424 		
//  425 		case RCSDownLoadData:
//  426 			if(RCSReceiveData(nPtr))
??RCSDownloadFunc_3:
        ADD      R8,SP,#+0
        BL       RCSReceiveData
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        LSRS     R0,R0,#+31
        STRB     R0,[R8, #+1]
        LDR.N    R0,??DataTable17  ;; FrameCnt
        LDRH     R0,[R0, #+0]
        LSRS     R1,R0,#+8
        STRB     R1,[R8, #+2]
//  427 			{
//  428 				tmpData[tmpLen++] = RCSACK;
//  429 			}
//  430 			else
//  431 			{
//  432 				tmpData[tmpLen++] = RCSNACK;
//  433 			}
//  434 			tmpData[tmpLen++] = (INT8U)((FrameCnt >> 8) & 0xff);
//  435 			tmpData[tmpLen++] = (INT8U)((FrameCnt     ) & 0xff);
        STRB     R0,[R8, #+3]
        MOV      R8,#+4
        B.N      ??RCSDownloadFunc_5
//  436 
//  437 		break;
//  438 		
//  439 		case RCSDownLoadDataConfirm:
//  440 			{
//  441 				INT16U tmpCRC;
//  442 				tmpCRC = (INT16U)((rBody->SubData[3] << 8) | rBody->SubData[4]);
//  443 				if((Swcrc16 == tmpCRC) && (TotFrame == FrameCnt + 1))	tmpData[tmpLen++] = RCSACK;
??RCSDownloadFunc_2:
        LDR.N    R0,??DataTable21  ;; Swcrc16
        LDRH     R0,[R0, #+0]
        LDRB     R1,[R4, #+10]
        LDRB     R2,[R4, #+11]
        ORR      R1,R2,R1, LSL #+8
        CMP      R0,R1
        BNE.N    ??RCSDownloadFunc_6
        LDR.N    R1,??RCSDownloadFunc_0+0x4  ;; TotFrame
        LDRH     R1,[R1, #+0]
        LDR.N    R2,??DataTable17  ;; FrameCnt
        LDRH     R2,[R2, #+0]
        ADDS     R2,R2,#+1
        CMP      R1,R2
        BNE.N    ??RCSDownloadFunc_6
        MOVS     R1,#+0
        STRB     R1,[SP, #+1]
        B.N      ??RCSDownloadFunc_7
//  444 				else													tmpData[tmpLen++] = RCSNACK;
??RCSDownloadFunc_6:
        STRB     R8,[SP, #+1]
??RCSDownloadFunc_7:
        LDR.N    R1,??RCSDownloadFunc_0+0x4  ;; TotFrame
        LDRH     R1,[R1, #+0]
        ADD      R3,SP,#+0
        LSRS     R2,R1,#+8
        STRB     R2,[R3, #+2]
//  445 			}
//  446 			tmpData[tmpLen++] = (INT8U)(TotFrame >> 8);
//  447 			tmpData[tmpLen++] = (INT8U)(TotFrame     );
        STRB     R1,[R3, #+3]
//  448 			tmpData[tmpLen++] = (INT8U)(Swcrc16 >> 8 );
        LSRS     R1,R0,#+8
        STRB     R1,[R3, #+4]
//  449 			tmpData[tmpLen++] = (INT8U)(Swcrc16      );
        STRB     R0,[R3, #+5]
        MOV      R8,#+6
//  450 		break;
//  451 	}
//  452 
//  453 	RCSDataAckTx(id0, id1, (INT8U *)tmpData, tmpLen, rBody->PortID, RcsDownloadRSPS);
??RCSDownloadFunc_5:
        MOVS     R1,#+160
        LDRB     R0,[R4, #+0]
        PUSH     {R0,R1}
        MOV      R3,R8
        ADD      R2,SP,#+8
        MOV      R1,R7
        MOV      R0,R6
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
//  454 
//  455 	// Jump the boot.
//  456 	////////////////////////////////////////////////////////////////////////////
//  457 	// Download OpeSocketInforating
//  458 	///////////////////////////////
//  459 	// Down Load Ending
//  460 	switch(rBody->SubData[0])
        LDRB     R0,[R4, #+7]
        CMP      R0,#+2
        BNE.N    ??RCSDownloadFunc_8
//  461 	{
//  462 		case RCSDownLoadDataConfirm:
//  463 			if(tmpData[1] == RCSACK)
        LDRB     R0,[SP, #+1]
        CMP      R0,#+0
        BNE.N    ??RCSDownloadFunc_8
//  464 			{
//  465 				INT32U t = *((INT32U *)(__pAPBKAddr + 40));	// jump base addr + selfaddinfo address
//  466 				INT32U s = *((INT32U *)(__pAPBKAddr + 36));	// jump base addr!!
//  467 
//  468 				selfinfo *p = (selfinfo *)(__pAPBKAddr + (t-s));
        LDR.N    R0,??RCSDownloadFunc_0+0x8  ;; 0x1ffff7e0
        LDRH     R1,[R0, #+0]
        SUBS     R1,R1,#+28
        LDRH     R2,[R0, #+0]
        SUBS     R2,R2,#+28
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R1,R1,R1, LSR #+31
        ASRS     R1,R1,#+1
        LDR.N    R3,??RCSDownloadFunc_0+0xC  ;; 0x8007000
        ADD      R1,R3,R1, LSL #+10
        ADD      R2,R2,R2, LSR #+31
        ASRS     R2,R2,#+1
        LSLS     R2,R2,#+10
        LDR.N    R3,??RCSDownloadFunc_0+0x10  ;; 0x8007028
        LDR      R2,[R3, R2]
        ADDS     R1,R2,R1
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LSLS     R0,R0,#+10
        LDR.N    R2,??RCSDownloadFunc_0+0x14  ;; 0x8007024
        LDR      R0,[R2, R0]
        SUBS     R6,R1,R0
//  469 
//  470 				if(!memcmp(p->infor[0], convinfo.infor[0], strlen(convinfo.infor[0])))
        LDR.N    R4,??RCSDownloadFunc_0+0x18  ;; convinfo
        MOV      R0,R4
        BL       strlen
        MOV      R2,R0
        MOV      R1,R4
        MOV      R0,R6
        BL       memcmp
        CBNZ     R0,??RCSDownloadFunc_8
//  471 				{
//  472 				
//  473 #ifdef __PWR_BACKUP_USED
//  474 					BKP_WriteBackupRegister(BKP_DR1, 0x02);
//  475 					PWR_BackupAccessCmd(ENABLE);
//  476 					SerPtr->printf("BKP_DR1 = %d\n", BKP_ReadBackupRegister(BKP_DR1));
//  477 #endif
//  478 					ResetCaseBackup(0x02);
        MOVS     R0,#+2
        BL       ResetCaseBackup
//  479 					SerPtr->printf("rambackup = %d\n", rambackup[0]);
        LDR.N    R0,??RCSDownloadFunc_0+0x1C  ;; rambackup
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+0]
        ADD      R0,R5,#+12
        LDR.N    R2,??DataTable15  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  480 
//  481 					//WriteEEprom(ResetCaseBp, );
//  482 					OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
//  483 					#ifdef __EXT_RAM_USED
//  484 						DownloadFlagSetExtSRAM(DataCount);
        LDR.N    R0,??DataTable20  ;; DataCount
        LDR      R0,[R0, #+0]
        BL       DownloadFlagSetExtSRAM
//  485 					#else
//  486 						DownloadFlagSet(DataCount);
//  487 					#endif
//  488 					DownLoadBootingJump();
        BL       DownLoadBootingJump
//  489 				}
//  490 			}
//  491 		break;
//  492 	}
//  493   
//  494 	return TRUE;
??RCSDownloadFunc_8:
        MOVS     R0,#+1
        ADD      SP,SP,#+16
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??RCSDownloadFunc_0:
        DC32     `?<Constant {0}>`
        DC32     TotFrame
        DC32     0x1ffff7e0
        DC32     0x8007000
        DC32     0x8007028
        DC32     0x8007024
        DC32     convinfo
        DC32     rambackup
//  495 
//  496 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable15:
        DC32     SerPtr
//  497 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  498 BOOL RCSReceiveData(__SKProtocolPtr *nPtr)
//  499 {
RCSReceiveData:
        PUSH     {R3-R9,LR}
//  500 	__SKProtocolSIO *Recv = nPtr->Recv;
//  501 	__RCSBODYFRAME *rBody = &Recv->BODYFRAME;
        LDR      R0,[R0, #+36]
        ADDS     R4,R0,#+4
//  502 		
//  503 	INT16U	tmpFrameCnt = 0;
//  504 	INT32U	tmpLength = 0;
//  505 	INT32S	err = 0;
//  506 
//  507 	// get the download Frame number
//  508 
//  509 
//  510 	tmpFrameCnt = rBody->SubData[1];
//  511 	tmpFrameCnt = (tmpFrameCnt << 8) | rBody->SubData[2];		// Frame Number
        LDRB     R0,[R4, #+8]
        LDRB     R1,[R4, #+9]
        ORRS     R8,R1,R0, LSL #+8
//  512 
//  513 	if ( tmpFrameCnt == 0 )
        LDR.W    R9,??DataTable17  ;; FrameCnt
        BNE.N    ??RCSReceiveData_0
//  514 	{
//  515 		// counter initialize when tmpFramecnt == 0.
//  516 		DataCount = 0;
        LDR.N    R0,??DataTable20  ;; DataCount
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  517 		Swcrc16 = 0;
        LDR.N    R0,??DataTable21  ;; Swcrc16
        STRH     R1,[R0, #+0]
//  518 	}
//  519 	else
//  520 	{	// frame Number Check old != current
//  521 		if((tmpFrameCnt != (FrameCnt + 1))) return FALSE;
//  522 		else
//  523 		{
//  524 			if(tmpFrameCnt == FrameCnt) return TRUE;
//  525 		}
//  526 	}
//  527 
//  528 	// Download Data Length : length - 2(frame number 2byte)
//  529 	tmpLength = rBody->SubLen - 6;
??RCSReceiveData_1:
        LDRB     R0,[R4, #+3]
        SUBS     R6,R0,#+6
//  530 	#ifdef __EXT_RAM_USED
//  531 		err = DataCount = UpLoadExtSRAM((INT8U *)&rBody->SubData[3], tmpLength, DataCount);
        LDR.N    R7,??DataTable20  ;; DataCount
        LDR      R2,[R7, #+0]
        UXTH     R1,R6
        ADD      R0,R4,#+10
        BL       UpLoadExtSRAM
        STR      R0,[R7, #+0]
        MOV      R7,R0
//  532 	#else
//  533 		err = DataCount = UpLoadData((INT8U *)&rBody->SubData[3], tmpLength, DataCount);
//  534 	#endif
//  535 	Swcrc16 = Crc16Calc((INT8U*)&rBody->SubData[3], tmpLength, Swcrc16);
        LDR.N    R5,??DataTable21  ;; Swcrc16
        LDRH     R2,[R5, #+0]
        MOV      R1,R6
        ADD      R0,R4,#+10
        BL       Crc16Calc
        STRH     R0,[R5, #+0]
//  536 	FrameCnt = tmpFrameCnt;
        STRH     R8,[R9, #+0]
//  537 
//  538 	if(err == -1) return FALSE;
        MOV      R0,#-1
        CMP      R7,R0
        BNE.N    ??RCSReceiveData_2
??RCSReceiveData_3:
        MOVS     R0,#+0
        POP      {R1,R4-R9,PC}
??RCSReceiveData_0:
        LDRH     R0,[R9, #+0]
        ADDS     R2,R0,#+1
        CMP      R8,R2
        BNE.N    ??RCSReceiveData_3
        CMP      R8,R0
        BNE.N    ??RCSReceiveData_1
//  539 	return TRUE;
??RCSReceiveData_2:
        MOVS     R0,#+1
        POP      {R1,R4-R9,PC}    ;; return
//  540 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     FrameCnt

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable20:
        DC32     DataCount

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     Swcrc16
//  541 
//  542 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  543 INT8U RCSAnalyzeAidData(__SKProtocolPtr *nPtr, INT8U Ctrl, INT8U tmpDnr, INT8U tmpRmt)
//  544 {
RCSAnalyzeAidData:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+60
        MOV      R4,R1
        MOV      R11,R2
        MOV      R10,R3
//  545 	INT8U i = 0;
//  546 	INT8U A_ID[2];
//  547 	INT8U rAID_Value[50];
//  548 	INT8U Length;
//  549 
//  550 	INT16U Cnt = 0;
        MOVS     R6,#+0
//  551 	INT16U AID_Command;
//  552 	INT32S cpu_sr;
//  553 	
//  554 	__SKProtocolSIO *Recv = nPtr->Recv;
//  555 	__RCSBODYFRAME *BodyFrame = &Recv->BODYFRAME;
        LDR      R0,[R0, #+36]
        ADDS     R7,R0,#+4
//  556 	
//  557 	EE_BACK1 *tptr;
//  558 	
//  559 	INT8U rval = FALSE;
        MOVS     R5,#+0
//  560 
//  561 	if(BodyFrame->SubLen < 3) return FALSE;
        LDRB     R0,[R7, #+3]
        CMP      R0,#+3
        BCS.N    ??RCSAnalyzeAidData_0
        MOVS     R0,#+0
        B.N      ?Subroutine1
//  562 /////////////////////////////////////////////////////////////////////////////////////////////////////////
//  563 	if(Ctrl) {
??RCSAnalyzeAidData_0:
        CBZ      R4,??RCSAnalyzeAidData_1
//  564 		OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  565 		tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area	
        LDR.N    R0,??DataTable24  ;; 0x8006000
        BL       RoadBackuptobuffer
        MOV      R9,R0
        B.N      ??RCSAnalyzeAidData_2
//  566 	}
//  567     else
//  568     {
//  569         DnrSts[tmpDnr][tmpRmt].DnrExtraRecvCnt = 0;
??RCSAnalyzeAidData_1:
        MOVW     R0,#+269
        MOVW     R1,#+538
        LDR.N    R2,??DataTable25  ;; DnrSts
        MLA      R1,R11,R1,R2
        MLA      R0,R10,R0,R1
        STRB     R6,[R0, #+188]
//  570     }
//  571     
//  572 	while(BodyFrame->SubLen - 3 > Cnt)
??RCSAnalyzeAidData_2:
        LDRB     R1,[R7, #+3]
        SUBS     R1,R1,#+3
        CMP      R6,R1
        BGE.N    ??RCSAnalyzeAidData_3
//  573 	{
//  574 		A_ID[0] = (INT8U)(BodyFrame->SubData[Cnt++]);
        ADDS     R0,R6,R7
        LDRB     R0,[R0, #+7]
        STRB     R0,[SP, #+0]
        ADDS     R0,R6,#+1
        UXTH     R0,R0
//  575 		A_ID[1] = (INT8U)(BodyFrame->SubData[Cnt++]);
        ADDS     R1,R0,R7
        LDRB     R1,[R1, #+7]
        STRB     R1,[SP, #+1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  576 
//  577 		AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
        LDRB     R2,[SP, #+0]
        ORR      R12,R1,R2, LSL #+8
//  578 		Length = BodyFrame->SubData[Cnt++];
        ADDS     R1,R0,R7
        LDRB     R2,[R1, #+7]
        ADDS     R6,R0,#+1
        UXTH     R6,R6
//  579 		if( Length >= sizeof(rAID_Value)) break;
        CMP      R2,#+50
        BCS.N    ??RCSAnalyzeAidData_3
//  580 		for (i = 0; i < Length; i++) rAID_Value[i] = (INT8U)(BodyFrame->SubData[Cnt++]);
        MOVS     R0,R2
        BEQ.N    ??RCSAnalyzeAidData_4
        ADD      R0,SP,#+4
        MOV      R1,R2
??RCSAnalyzeAidData_5:
        ADDS     R3,R6,R7
        LDRB     R3,[R3, #+7]
        STRB     R3,[R0], #+1
        ADDS     R6,R6,#+1
        UXTH     R6,R6
        SUBS     R1,R1,#+1
        BNE.N    ??RCSAnalyzeAidData_5
//  581 
//  582 
//  583 		rval += SetDnrCtrlData(AID_Command, rAID_Value, Length, Ctrl, tmpDnr, tmpRmt, tptr);
??RCSAnalyzeAidData_4:
        PUSH     {R9,LR}
        MOV      R1,R10
        MOV      R0,R11
        PUSH     {R0,R1}
        MOV      R3,R4
        ADD      R1,SP,#+20
        MOV      R0,R12
        BL       SetDnrCtrlData
        ADD      SP,SP,#+16
        ADDS     R0,R0,R5
        UXTB     R5,R0
//  584 		if(Cnt >= (BodyFrame->SubLen - 3)) break;
        LDRB     R1,[R7, #+3]
        SUBS     R1,R1,#+3
        CMP      R6,R1
        BLT.N    ??RCSAnalyzeAidData_2
//  585 	}
//  586 
//  587 	if(rval)
??RCSAnalyzeAidData_3:
        CMP      R5,#+0
        BEQ.N    ??RCSAnalyzeAidData_6
//  588 	{
//  589 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+80
        LDR.N    R0,??DataTable24  ;; 0x8006000
        BL       WriteBuffertoBackup
//  590 	}
//  591 	if(Ctrl) OS_EXIT_CRITICAL();
??RCSAnalyzeAidData_6:
        CMP      R4,#+0
        BEQ.N    ??RCSAnalyzeAidData_7
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  592 	
//  593 	return rval;
??RCSAnalyzeAidData_7:
        MOV      R0,R5
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  594 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        ADD      SP,SP,#+60
        POP      {R4-R11,PC}      ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable24:
        DC32     0x8006000
//  595 
//  596 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  597 INT16U 	RCSGenAidSts(INT8U *dptr, __DnrStsStr *Sts)
//  598 {
RCSGenAidSts:
        PUSH     {R4-R8,LR}
//  599 	INT8U i = 0;
//  600 	INT8U rlen = 0;
        MOVS     R2,#+0
//  601 
//  602 	for(i = 0; i < sizeof(__DnrAlmStr); i++)
        MOV      R3,R1
        MOV      R4,R0
        MOVS     R5,#+8
//  603 	{
//  604 		dptr[rlen++] = *((INT8U *)(&Sts->tmpAlm) + i);
??RCSGenAidSts_0:
        LDRB     R6,[R3, #+8]
        STRB     R6,[R4], #+1
        ADDS     R2,R2,#+1
        UXTB     R2,R2
//  605 	}
        ADDS     R3,R3,#+1
        SUBS     R5,R5,#+1
        BNE.N    ??RCSGenAidSts_0
//  606 
//  607 	dptr[rlen++] = Sts->Manufacture;
        LDRB     R4,[R1, #+16]
        STRB     R4,[R2, R0]
        ADDS     R2,R2,#+1
        UXTB     R2,R2
//  608 	dptr[rlen++] = Sts->Supplier;
        LDRB     R4,[R1, #+17]
        STRB     R4,[R2, R0]
        ADDS     R2,R2,#+1
        UXTB     R2,R2
//  609 	dptr[rlen++] = Sts->RepeaterType[0];
        LDRB     R4,[R1, #+18]
        STRB     R4,[R2, R0]
        ADDS     R2,R2,#+1
        UXTB     R2,R2
//  610 	dptr[rlen++] = Sts->RepeaterType[1];
        LDRB     R4,[R1, #+19]
        STRB     R4,[R2, R0]
        ADDS     R2,R2,#+1
        UXTB     R2,R2
//  611 	dptr[rlen++] = Sts->SWVer;
        LDRB     R4,[R1, #+20]
        STRB     R4,[R2, R0]
        ADDS     R3,R2,#+1
        UXTB     R3,R3
//  612 
//  613 	if(Sts == &DnrSts[0][0] || Sts == &DnrSts[1][0])
        LDR.N    R2,??DataTable25  ;; DnrSts
        CMP      R1,R2
        BEQ.N    ??RCSGenAidSts_1
        ADDW     R4,R2,#+538
        CMP      R1,R4
        BNE.N    ??RCSGenAidSts_2
//  614 	{
//  615 		dptr[rlen++] = Sts->MCUManufacture;
??RCSGenAidSts_1:
        LDRB     R5,[R1, #+24]
        STRB     R5,[R3, R0]
        ADDS     R3,R3,#+1
        UXTB     R3,R3
//  616 		dptr[rlen++] = Sts->MCUSupplier;
        LDRB     R5,[R1, #+25]
        STRB     R5,[R3, R0]
        ADDS     R3,R3,#+1
        UXTB     R3,R3
//  617 		dptr[rlen++] = Sts->MCUSwVer;
        LDRB     R5,[R1, #+26]
        STRB     R5,[R3, R0]
        ADDS     R3,R3,#+1
        UXTB     R3,R3
//  618 	}
//  619 	dptr[rlen++] = Sts->CurrentTemp;
??RCSGenAidSts_2:
        LDRB     R5,[R1, #+21]
        STRB     R5,[R3, R0]
        ADDS     R3,R3,#+1
        UXTB     R3,R3
//  620 	dptr[rlen++] = Sts->TempUpperLmt;
        LDRB     R5,[R1, #+22]
        STRB     R5,[R3, R0]
        ADDS     R3,R3,#+1
        UXTB     R3,R3
//  621 	dptr[rlen++] = Sts->NMSType;
        LDRB     R5,[R1, #+23]
        STRB     R5,[R3, R0]
        ADDS     R4,R3,#+1
        UXTB     R4,R4
//  622 	
//  623 
//  624 	//dptr[rlen++] = Sts->RingType;
//  625 	dptr[rlen++] = MySts->RingType;
        LDR.N    R3,??DataTable28  ;; MySts
        LDR      R6,[R3, #+0]
        LDRB     R6,[R6, #+27]
        STRB     R6,[R4, R0]
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  626 
//  627 	dptr[rlen++] = Sts->SFPService.Data[0];
        LDRB     R6,[R1, #+28]
        STRB     R6,[R4, R0]
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  628 	dptr[rlen++] = Sts->SFPService.Data[1];
        LDRB     R6,[R1, #+29]
        STRB     R6,[R4, R0]
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  629 
//  630 	dptr[rlen++] = Sts->SFPInstall.Data[0];
        LDRB     R6,[R1, #+30]
        STRB     R6,[R4, R0]
        ADDS     R4,R4,#+1
        UXTB     R4,R4
//  631 	dptr[rlen++] = Sts->SFPInstall.Data[1];
        LDRB     R6,[R1, #+31]
        STRB     R6,[R4, R0]
        ADDS     R5,R4,#+1
        UXTB     R5,R5
//  632 
//  633 	if(Sts == &DnrSts[0][1] || Sts == &DnrSts[1][1])
        ADDW     R4,R2,#+269
        CMP      R1,R4
        BEQ.N    ??RCSGenAidSts_3
        ADDW     R6,R2,#+807
        CMP      R1,R6
        BNE.N    ??RCSGenAidSts_4
//  634 	{
//  635 		dptr[rlen++] = Sts->EastPathLossPwr[0];
??RCSGenAidSts_3:
        LDRB     R7,[R1, #+32]
        STRB     R7,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  636 		dptr[rlen++] = Sts->EastPathLossPwr[1];
        LDRB     R7,[R1, #+33]
        STRB     R7,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  637 
//  638 		dptr[rlen++] = Sts->WestPathLossPwr[0];
        LDRB     R7,[R1, #+34]
        STRB     R7,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  639 		dptr[rlen++] = Sts->WestPathLossPwr[1];
        LDRB     R7,[R1, #+35]
        STRB     R7,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  640 	}
//  641 
//  642 	for(i = 0; i < 12; i++)
??RCSGenAidSts_4:
        MOV      R6,R1
        MOVS     R7,#+12
//  643 	{
//  644 		dptr[rlen++] = (Sts->SFPPDPwr[i]);
??RCSGenAidSts_5:
        LDRB     LR,[R6, #+36]
        STRB     LR,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  645 	}
        ADDS     R6,R6,#+1
        SUBS     R7,R7,#+1
        BNE.N    ??RCSGenAidSts_5
//  646 
//  647 	if(Sts == &DnrSts[0][1] || Sts == &DnrSts[1][1])
        CMP      R1,R4
        BEQ.N    ??RCSGenAidSts_6
        ADDW     R6,R2,#+807
        CMP      R1,R6
        BNE.N    ??RCSGenAidSts_7
//  648 	{
//  649 		dptr[rlen++] = Sts->SwMode;
??RCSGenAidSts_6:
        LDRB     R7,[R1, #+48]
        STRB     R7,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  650 	}
//  651 	dptr[rlen++] = Sts->SwDiretion;
??RCSGenAidSts_7:
        ADD      R6,R1,#+48
        LDRB     R7,[R6, #+1]
        STRB     R7,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  652 
//  653 	for(i = 0; i < 12; i++)
        MOV      R7,R1
        MOV      R12,#+12
//  654 	{
//  655 		dptr[rlen++] = (Sts->SFPPDPwrLowerLmt[i]);
??RCSGenAidSts_8:
        LDRB     R8,[R7, #+50]
        STRB     R8,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  656 	}
        ADDS     R7,R7,#+1
        SUBS     R12,R12,#+1
        BNE.N    ??RCSGenAidSts_8
//  657 	
//  658 	if(Sts == &DnrSts[0][1] || Sts == &DnrSts[1][1])
        CMP      R1,R4
        BEQ.N    ??RCSGenAidSts_9
        ADDW     R7,R2,#+807
        CMP      R1,R7
        BNE.N    ??RCSGenAidSts_10
//  659 	{
//  660 		dptr[rlen++] = Sts->DCPMaindBLvl;
??RCSGenAidSts_9:
        LDRB     R6,[R6, #+14]
        STRB     R6,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  661 	}
//  662 
//  663 	for(i = 0; i < 12; i++)
??RCSGenAidSts_10:
        MOV      R6,R1
        MOVS     R7,#+12
//  664 	{
//  665 		dptr[rlen++] = (Sts->SFPLDPwr[i]);
??RCSGenAidSts_11:
        LDRB     LR,[R6, #+63]
        STRB     LR,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  666 	}
        ADDS     R6,R6,#+1
        SUBS     R7,R7,#+1
        BNE.N    ??RCSGenAidSts_11
//  667 
//  668 
//  669 	for(i = 0; i < 24; i++)
        MOV      R6,R1
        MOVS     R7,#+24
//  670 	{
//  671 		dptr[rlen++] = (Sts->SFPLDInfo[i]);
??RCSGenAidSts_12:
        LDRB     LR,[R6, #+75]
        STRB     LR,[R5, R0]
        ADDS     R5,R5,#+1
        UXTB     R5,R5
//  672 	}
        ADDS     R6,R6,#+1
        SUBS     R7,R7,#+1
        BNE.N    ??RCSGenAidSts_12
//  673 	
//  674 	if(Sts == &DnrSts[0][1] || Sts == &DnrSts[1][1])
        CMP      R1,R4
        BEQ.N    ??RCSGenAidSts_13
        ADDW     R2,R2,#+807
        CMP      R1,R2
        BNE.N    ??RCSGenAidSts_14
//  675 	{
//  676 		dptr[rlen++] = Sts->DCPCurrdBLvl;
??RCSGenAidSts_13:
        LDRB     R4,[R1, #+99]
        STRB     R4,[R5, R0]
        ADDS     R2,R5,#+1
        UXTB     R2,R2
//  677 		dptr[rlen++] = Sts->OTUWaveCnt;
        ADDS     R1,R1,#+99
        LDRB     R1,[R1, #+1]
        STRB     R1,[R2, R0]
        ADDS     R5,R2,#+1
        UXTB     R5,R5
//  678 	}
//  679 	dptr[rlen++] = MySts->IsItLocalCtrl;
??RCSGenAidSts_14:
        LDR      R2,[R3, #+0]
        LDRB     R2,[R2, #+192]
        STRB     R2,[R5, R0]
//  680 	
//  681 	return rlen;
        ADDS     R0,R5,#+1
        UXTB     R0,R0
        POP      {R4-R8,PC}       ;; return
//  682 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable25:
        DC32     DnrSts
//  683 
//  684 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  685 INT32U RCSProtocolCheck(__SKProtocolPtr *nPtr)
//  686 {
RCSProtocolCheck:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R5,R0
//  687 	INT16U nInitCnt, nCnt;
//  688 	__SKProtocolSIO *Recv = nPtr->Recv;
        LDR      R4,[R5, #+36]
//  689 	////////////////////////////////////////////////////////////////
//  690 	
//  691 	//------------------------------------------------------------//
//  692 	TimerRegist(nPtr->TimerRx, Time1Sec*3);
        MOVW     R1,#+3000
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimerRegist
        B.N      ??RCSProtocolCheck_0
//  693 	
//  694 
//  695 	while(1)
//  696 	{
//  697 		if(TimeOverCheck(nPtr->TimerRx)) return FALSE;
//  698 		if(nPtr->CheckByte(4, &nCnt))
//  699 		{
//  700 		///////////////////////////////////////////////
//  701 			if(STX == nPtr->RxGetByte())
//  702 			{
//  703 				if(STX == nPtr->RxGetByte())
//  704 				{
//  705 					if(STX == nPtr->RxGetByte())
//  706 					{
//  707 						if(STX == nPtr->RxGetByte())
//  708 						{
//  709 							Recv->SERBASE.Sync[0] = STX;
//  710 							Recv->SERBASE.Sync[1] = STX;
//  711 							Recv->SERBASE.Sync[2] = STX;
//  712 							Recv->SERBASE.Sync[3] = STX;
//  713 							break;
//  714 						}
//  715 					}
//  716 				}
//  717 			}	
//  718 			else OSTimeDly(200L);
??RCSProtocolCheck_1:
        MOVS     R0,#+200
        BL       OSTimeDly
??RCSProtocolCheck_0:
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??RCSProtocolCheck_2
??RCSProtocolCheck_3:
        MOVS     R0,#+0
        POP      {R1,R2,R4-R6,PC}
??RCSProtocolCheck_2:
        ADD      R1,SP,#+0
        MOVS     R0,#+4
        LDR      R2,[R5, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??RCSProtocolCheck_1
        LDR      R0,[R5, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??RCSProtocolCheck_1
        LDR      R0,[R5, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??RCSProtocolCheck_0
        LDR      R0,[R5, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??RCSProtocolCheck_0
        LDR      R0,[R5, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??RCSProtocolCheck_0
        STRB     R0,[R4, #+0]
        STRB     R0,[R4, #+1]
        STRB     R0,[R4, #+2]
        STRB     R0,[R4, #+3]
//  719 		}
//  720 		else OSTimeDly(200L);
//  721 	}
//  722 	//------------------------------------------------------------//
//  723 
//  724 		
//  725 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimerRegist
//  726 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R5, #+0]
        BLX      R2
        B.N      ??RCSProtocolCheck_4
//  727 	while(!nPtr->CheckByte(7, &nCnt))
//  728 	{
//  729 		if(TimeOverCheck(nPtr->TimerRx))
??RCSProtocolCheck_5:
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??RCSProtocolCheck_6
//  730 		{
//  731 			if(nCnt > nInitCnt)
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.N    ??RCSProtocolCheck_3
//  732 			{
//  733 				nInitCnt = nCnt;
        STRH     R1,[SP, #+2]
//  734 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimerRegist
//  735 			}
//  736 			else return FALSE;
//  737 		}
//  738 		OSTimeDly(100L);
??RCSProtocolCheck_6:
        MOVS     R0,#+100
        BL       OSTimeDly
//  739 	}
??RCSProtocolCheck_4:
        ADD      R1,SP,#+0
        MOVS     R0,#+7
        LDR      R2,[R5, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??RCSProtocolCheck_5
//  740 
//  741 	Recv->BODYFRAME.PortID		= nPtr->RxGetByte();
        LDR      R0,[R5, #+4]
        BLX      R0
        STRB     R0,[R4, #+4]
//  742 	Recv->BODYFRAME.Scode		= nPtr->RxGetByte();
        LDR      R0,[R5, #+4]
        BLX      R0
        STRB     R0,[R4, #+5]
//  743 	Recv->BODYFRAME.Command		= nPtr->RxGetByte();
        LDR      R0,[R5, #+4]
        BLX      R0
        STRB     R0,[R4, #+6]
//  744 	Recv->BODYFRAME.SubLen 		= nPtr->RxGetByte();
        LDR      R0,[R5, #+4]
        BLX      R0
        STRB     R0,[R4, #+7]
//  745 	Recv->BODYFRAME.Rcode 		= nPtr->RxGetByte();
        LDR      R0,[R5, #+4]
        BLX      R0
        STRB     R0,[R4, #+8]
//  746 	Recv->BODYFRAME.SubID[0] 	= nPtr->RxGetByte();
        LDR      R0,[R5, #+4]
        BLX      R0
        STRB     R0,[R4, #+9]
//  747 	Recv->BODYFRAME.SubID[1] 	= nPtr->RxGetByte();
        LDR      R0,[R5, #+4]
        BLX      R0
        STRB     R0,[R4, #+10]
//  748 	
//  749 	//if((Recv->BODYFRAME.SubLen < 3) || (Recv->BODYFRAME.SubLen > 93))return FALSE; 	//3~93
//  750 
//  751 	if(Recv->BODYFRAME.SubLen < 3) return FALSE;//|| (Recv->BODYFRAME.SubLen > 0xff))return FALSE; 	//3~93
        LDRB     R0,[R4, #+7]
        CMP      R0,#+3
        BCC.N    ??RCSProtocolCheck_3
//  752 
//  753 
//  754 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimerRegist
//  755 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R5, #+0]
        BLX      R2
        MOVW     R6,#+65535
        B.N      ??RCSProtocolCheck_7
//  756 
//  757 	while(!nPtr->CheckByte((Recv->BODYFRAME.SubLen-1 ), &nCnt))// -1 = -(Rcode + SubId[2]) + Crc[2] 
//  758 	{
//  759 		if(TimeOverCheck(nPtr->TimerRx))
??RCSProtocolCheck_8:
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??RCSProtocolCheck_9
//  760 		{
//  761 			if(nCnt > nInitCnt)
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.N    ??RCSProtocolCheck_3
//  762 			{
//  763 				nInitCnt = nCnt;
        STRH     R1,[SP, #+2]
//  764 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R5, #+28]
        UXTB     R0,R0
        BL       TimerRegist
//  765 			}
//  766 			else return FALSE;
//  767 		}
//  768 		OSTimeDly(100L);
??RCSProtocolCheck_9:
        MOVS     R0,#+100
        BL       OSTimeDly
//  769 	}
??RCSProtocolCheck_7:
        ADD      R1,SP,#+0
        LDRB     R0,[R4, #+7]
        ADDS     R0,R6,R0
        UXTH     R0,R0
        LDR      R2,[R5, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??RCSProtocolCheck_8
//  770 
//  771 	{
//  772 		INT16U i;
//  773 		for(i = 0; i < Recv->BODYFRAME.SubLen-1 ; i++)
        MOVS     R6,#+0
        LDRB     R0,[R4, #+7]
        SUBS     R0,R0,#+1
        CMP      R0,#+1
        BLT.N    ??RCSProtocolCheck_10
//  774 		{
//  775 			*((INT8U *)Recv->BODYFRAME.SubData+ i) = nPtr->RxGetByte();
??RCSProtocolCheck_11:
        LDR      R0,[R5, #+4]
        BLX      R0
        ADDS     R1,R6,R4
        STRB     R0,[R1, #+11]
//  776 		}
        ADDS     R6,R6,#+1
        UXTH     R6,R6
        LDRB     R1,[R4, #+7]
        SUBS     R1,R1,#+1
        CMP      R6,R1
        BLT.N    ??RCSProtocolCheck_11
//  777 	}
//  778 
//  779 	Recv->BODYFRAME.Crc = Crc16Calc((INT8U *)&(Recv->BODYFRAME.PortID), Recv->BODYFRAME.SubLen + 4, 0); 
??RCSProtocolCheck_10:
        MOVS     R2,#+0
        LDRB     R0,[R4, #+7]
        ADDS     R1,R0,#+4
        ADDS     R0,R4,#+4
        BL       Crc16Calc
        ADD      R1,R4,#+266
        STRH     R0,[R1, #+0]
//  780 	Recv->BODYFRAME.CrcOK = TRUE;	
        ADD      R0,R4,#+266
        MOVS     R1,#+1
        STRB     R1,[R0, #+2]
//  781 
//  782 	
//  783 	if( (INT8U)(Recv->BODYFRAME.Crc >> 8)   != Recv->BODYFRAME.SubData[Recv->BODYFRAME.SubLen-3] )
        ADD      R1,R4,#+266
        LDRH     R1,[R1, #+0]
        LSRS     R1,R1,#+8
        LDRB     R2,[R4, #+7]
        ADDS     R2,R2,R4
        LDRB     R2,[R2, #+8]
        CMP      R1,R2
        BEQ.N    ??RCSProtocolCheck_12
//  784 				Recv->BODYFRAME.CrcOK = FALSE;
        MOVS     R1,#+0
        STRB     R1,[R0, #+2]
//  785 	if( (INT8U)(Recv->BODYFRAME.Crc)		  != Recv->BODYFRAME.SubData[Recv->BODYFRAME.SubLen-2] )
??RCSProtocolCheck_12:
        ADD      R1,R4,#+266
        LDRH     R1,[R1, #+0]
        LDRB     R2,[R4, #+7]
        ADDS     R2,R2,R4
        LDRB     R2,[R2, #+9]
        UXTB     R1,R1
        CMP      R1,R2
        BEQ.N    ??RCSProtocolCheck_13
//  786 				Recv->BODYFRAME.CrcOK = FALSE;
        MOVS     R1,#+0
        STRB     R1,[R0, #+2]
//  787 
//  788 	return TRUE;
??RCSProtocolCheck_13:
        MOVS     R0,#+1
        POP      {R1,R2,R4-R6,PC}  ;; return
//  789 }
//  790 
//  791 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  792 void RCSStsCheckConnectionSet(__SKProtocolPtr *nPtr)
//  793 {
RCSStsCheckConnectionSet:
        PUSH     {R4,LR}
//  794 	if(nPtr == RcsSer)
        LDR.N    R1,??DataTable30  ;; RcsPadOnFlag
        LDR      R2,[R1, #+4]
        CMP      R0,R2
        BNE.N    ??RCSStsCheckConnectionSet_0
//  795 	{
//  796 		RcsPadOnFlag = 1;
        MOVS     R0,#+1
        STRB     R0,[R1, #+0]
//  797 		MySts->ServerPadFlag = 1;
        LDR.N    R0,??DataTable28  ;; MySts
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+267]
//  798 		TimerRegist(TimerRcsCheck, 60*Time1Sec);
        MOVW     R4,#+60000
        MOV      R1,R4
        MOVS     R0,#+10
        BL       TimerRegist
//  799 		TimerRegist(TimerServerPadFlag, ServerPadTime);
        MOV      R1,R4
        MOVS     R0,#+26
        BL       TimerRegist
//  800 	}
//  801 }
??RCSStsCheckConnectionSet_0:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable28:
        DC32     MySts
//  802 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  803 void RCSStsCheckConnectionRst(__SKProtocolPtr *nPtr)
//  804 {
RCSStsCheckConnectionRst:
        PUSH     {R4,LR}
//  805 	if(nPtr == RcsSer && TimeOverCheck(TimerRcsCheck)) 		RcsPadOnFlag = 0;
        LDR.N    R4,??DataTable30  ;; RcsPadOnFlag
        LDR      R1,[R4, #+4]
        CMP      R0,R1
        BNE.N    ??RCSStsCheckConnectionRst_0
        MOVS     R0,#+10
        BL       TimeOverCheck
        CBZ      R0,??RCSStsCheckConnectionRst_0
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  806 }
??RCSStsCheckConnectionRst_0:
        POP      {R4,PC}          ;; return
//  807 
//  808 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  809 void RCSDataAckTx (INT8U id0, INT8U id1,  INT8U *Data, INT8U nCnt, INT8U PortID, INT8U Comm)
//  810 {
RCSDataAckTx:
        PUSH     {R3-R11,LR}
        MOV      R11,R0
        MOV      R10,R1
        MOV      R9,R2
        MOV      R8,R3
        LDR      R5,[SP, #+40]
        LDR      R6,[SP, #+44]
//  811 
//  812 	INT8U err = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  813 	INT32U i;	
//  814 
//  815 	__SKProtocolSIO *Send = RcsSer->Send;
        LDR.N    R7,??DataTable30  ;; RcsPadOnFlag
        LDR      R0,[R7, #+4]
        LDR      R4,[R0, #+40]
//  816 
//  817 	OSSemPend(RcsSer->Sem, 10, &err);
        ADD      R2,SP,#+0
        MOVS     R1,#+10
        LDR      R0,[R0, #+44]
        BL       OSSemPend
//  818 	if(err != OS_NO_ERR ) return ;//err;
        LDRB     R0,[SP, #+0]
        CMP      R0,#+0
        BNE.N    ??RCSDataAckTx_0
//  819 
//  820 	Send->SERBASE.Sync[0] = STX;
        MOVS     R0,#+22
        STRB     R0,[R4, #+0]
//  821 	Send->SERBASE.Sync[1] = STX;
        STRB     R0,[R4, #+1]
//  822 	Send->SERBASE.Sync[2] = STX;
        STRB     R0,[R4, #+2]
//  823 	Send->SERBASE.Sync[3] = STX;
        STRB     R0,[R4, #+3]
//  824 
//  825 	Send->BODYFRAME.PortID 	= PortID;
        STRB     R5,[R4, #+4]
//  826 	Send->BODYFRAME.Scode 	= CCUSocde;
        MOVS     R0,#+255
        STRB     R0,[R4, #+5]
//  827 	Send->BODYFRAME.Command = Comm;
        STRB     R6,[R4, #+6]
//  828 	Send->BODYFRAME.SubLen 	= nCnt + 3;  // Rcode+SubId[2]
        ADD      R0,R8,#+3
        STRB     R0,[R4, #+7]
//  829 	Send->BODYFRAME.Rcode 	= __RCS_R_SCAN_RM; 
        MOVS     R0,#+11
        STRB     R0,[R4, #+8]
//  830 
//  831 	Send->BODYFRAME.SubID[0] = id0;	//贸府秦具窃
        STRB     R11,[R4, #+9]
//  832 	Send->BODYFRAME.SubID[1] = id1;	//贸府秦具窃
        STRB     R10,[R4, #+10]
//  833 
//  834 	//for(i = 0 ; i < nCnt && i < 90; i++)	//Data Length 3~93
//  835 	for(i = 0 ; i < nCnt && i < 200; i++)	//Data Length 3~93
        MOVS     R5,#+0
        MOV      R0,R4
        B.N      ??RCSDataAckTx_1
//  836 	{
//  837 		Send->BODYFRAME.SubData[i] = Data[i];
??RCSDataAckTx_2:
        LDRB     R1,[R9], #+1
        STRB     R1,[R0, #+11]
//  838 	}
        ADDS     R5,R5,#+1
        ADDS     R0,R0,#+1
??RCSDataAckTx_1:
        CMP      R5,R8
        BCS.N    ??RCSDataAckTx_3
        CMP      R5,#+200
        BCC.N    ??RCSDataAckTx_2
//  839 	///////////// CRC //
//  840 	{
//  841     	Send->BODYFRAME.Crc = Crc16Calc ((INT8U *)&(Send->BODYFRAME.PortID), 7 + i, 0);
??RCSDataAckTx_3:
        MOVS     R2,#+0
        ADDS     R1,R5,#+7
        ADDS     R0,R4,#+4
        BL       Crc16Calc
        ADD      R1,R4,#+266
        STRH     R0,[R1, #+0]
//  842 		Send->BODYFRAME.SubData[i++] = (INT8U)(Send->BODYFRAME.Crc >> 8);
        ADDS     R0,R5,R4
        LDRH     R1,[R1, #+0]
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+11]
        ADDS     R0,R5,#+1
//  843 		Send->BODYFRAME.SubData[i++] = (INT8U)(Send->BODYFRAME.Crc     );
        ADDS     R1,R0,R4
        ADD      R2,R4,#+266
        LDRH     R2,[R2, #+0]
        STRB     R2,[R1, #+11]
//  844 	}
//  845 	
//  846 	RcsSer->PutStr((INT8U *)Send, 4 + 7 + i, ENABLE);
        MOVS     R2,#+1
        ADD      R1,R0,#+12
        UXTH     R1,R1
        MOV      R0,R4
        LDR      R3,[R7, #+4]
        LDR      R3,[R3, #+8]
        BLX      R3
//  847 
//  848 	#ifdef RCS_DBG
//  849 	//debug
//  850 	PcSer->PutStr((INT8U *)Send, 4 + 7 + i, ENABLE);
//  851                                //4: stx 4 byte
//  852                                //7: PortID ~ SubID[2]
//  853 
//  854 	#endif
//  855 	OSSemPost(RcsSer->Sem);
        LDR      R0,[R7, #+4]
        LDR      R0,[R0, #+44]
        BL       OSSemPost
//  856 }
??RCSDataAckTx_0:
        POP      {R0,R4-R11,PC}   ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable30:
        DC32     RcsPadOnFlag

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "RCS PORT INIT: 19200b...">`:
        DATA
        DC8 "RCS PORT INIT: 19200bpS \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "PORTID CHANGED %02x\\n">`:
        DATA
        DC8 "PORTID CHANGED %02x\012"
        DC8 0, 0, 0
        DC8 "id0 = %02x, id1 = %02x Comm = %02x\012"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant {0}>`:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "rambackup = %d\012"

        END
//  857 
//  858 //////////////////////////////////////////////////////////////////////////////
//  859 // End of Source File
//  860 ////////////////////////
//  861 
// 
//    48 bytes in section .bss
// 1 576 bytes in section .data
//   116 bytes in section .rodata
// 3 136 bytes in section .text
// 
// 3 136 bytes of CODE  memory
//   116 bytes of CONST memory
// 1 624 bytes of DATA  memory
//
//Errors: none
//Warnings: none
