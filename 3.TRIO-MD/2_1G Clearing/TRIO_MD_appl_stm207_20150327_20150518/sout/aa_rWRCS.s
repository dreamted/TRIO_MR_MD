///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jun/2011  18:42:11 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1. /
//                    0\code\aa_rWRCS.c                                       /
//    Command line =  "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1 /
//                    .0\code\aa_rWRCS.c" -lcN "C:\user\project\HFR           /
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
//                    0\sout\aa_rWRCS.s                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_rWRCS

        EXTERN AnalyzeAidData
        EXTERN AnalyzeAidDataptr
        EXTERN Crc16Calc
        EXTERN DnrLinkFailCheck
        EXTERN DnrSer0
        EXTERN DnrSer1
        EXTERN DnrSts
        EXTERN DownLoadBootingJump
        EXTERN DownloadFlagSetExtSRAM
        EXTERN GenDnrAidSts
        EXTERN GenDnrRstSts
        EXTERN GenModuleAutoInformSts
        EXTERN GenModuleInformSts
        EXTERN IORULinkFailCheck
        EXTERN IORUSer
        EXTERN IORUTxLED
        EXTERN IPAddrInfo
        EXTERN Inform_CtrlDataCopy
        EXTERN Initialize
        EXTERN IsItGetIOURInform
        EXTERN IsItLocalCtrlRSPS
        EXTERN LocalIPCtrlData
        EXTERN LocalMacCtrlData
        EXTERN MacAddrInfo
        EXTERN MyDnrID
        EXTERN MyPortID
        EXTERN MyRCode
        EXTERN MyRmtID
        EXTERN MyRstCase
        EXTERN MySts
        EXTERN OSSemCreate
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN RCSDataAckTx
        EXTERN RCSGenAidSts
        EXTERN RcsSer
        EXTERN ResetCaseBackup
        EXTERN ResetStart
        EXTERN RmtAlarmSndCnt
        EXTERN RmtLinkFailCheck
        EXTERN RoadBackuptobuffer
        EXTERN SerPtr
        EXTERN ServAlmSndCnt
        EXTERN ServRstAlmFlag
        EXTERN ServerCtrlStart
        EXTERN SystemTypeInfo
        EXTERN TimeOverCheck
        EXTERN TimerCancel
        EXTERN TimerRegist
        EXTERN UdpPadOnFlag
        EXTERN UpLoadExtSRAM
        EXTERN Wrcs0
        EXTERN Wrcs1
        EXTERN WriteBuffertoBackup
        EXTERN __aeabi_memcpy
        EXTERN convinfo
        EXTERN memcmp
        EXTERN pUSART1
        EXTERN rambackup
        EXTERN strlen
        EXTERN tTestFlag

        PUBLIC ALLResetFlag
        PUBLIC DataCount
        PUBLIC Digital_StsData
        PUBLIC DnLoad_Cnt
        PUBLIC DnLoad_Data
        PUBLIC DownloadID
        PUBLIC FrameCnt
        PUBLIC FrameCounter
        PUBLIC FrameCounterOld
        PUBLIC GenAidData
        PUBLIC GenBodyFrame
        PUBLIC GenBodyFrameTx
        PUBLIC IsItMySysValtoID
        PUBLIC IsItRtnMySysIDtoVAL
        PUBLIC IsItRtnMyVALtoSysID
        PUBLIC IsitRmtSelfDn
        PUBLIC MyProtocolComCheck
        PUBLIC PcSer
        PUBLIC PcSerB
        PUBLIC ProtocolComCheck
        PUBLIC ProtocolRvsComCheck
        PUBLIC RPcsksio
        PUBLIC ReturnDnrRmtID
        PUBLIC ReturnPollingID
        PUBLIC RmtDnConFirmSend
        PUBLIC RmtDnDataSend
        PUBLIC RmtDnEndSend
        PUBLIC RmtDnFrameStart
        PUBLIC RmtDownStart
        PUBLIC RmtRecvDownLoadFunc
        PUBLIC RmtSelfDnErrClr
        PUBLIC RmtSelfErrCnt
        PUBLIC RmtSelfId2
        PUBLIC RmtSelfSrc
        PUBLIC RmtSelfStep
        PUBLIC RmtSendDownLoadFunc
        PUBLIC SPcsksio
        PUBLIC SelfSer
        PUBLIC Ser1TaskStk
        PUBLIC SerialPadOnFlag
        PUBLIC StsCheckConnectionRst
        PUBLIC StsCheckConnectionSet
        PUBLIC Swcrc16
        PUBLIC TotFrame
        PUBLIC WRCSTask
        PUBLIC WRCS_DownLoadGiveupTimerChk
        PUBLIC WRCS_DownLoadGiveupTimerRst
        PUBLIC WRCS_DownLoadGiveupTimerSet
        PUBLIC WRCS_DownloadFunc
        PUBLIC WRCS_ProDataAckTx
        PUBLIC WRCS_ProtocolCheck
        PUBLIC WRCS_ReceiveData
        PUBLIC WRCS_SerInit
        PUBLIC WRCS_WhatRxComm
        PUBLIC downloadFlag
        PUBLIC iDebugCnt
        PUBLIC iResetCase
        PUBLIC iUser_Value2
        PUBLIC pBodyFrameTx
        PUBLIC pCtrlComm

// C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1.0\code\aa_rWRCS.c
//    1 
//    2 /******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
//    3 * File Name          : usart1_vx.x.c
//    4 * Author             : Yoon Byong-Gyu(bgyoon@naver.com)
//    5 * Date First Issued  : 01/17/2008
//    6 * Description        : This file provides all the USART0 firmware functions.
//    7 * $Revision: 0.1 $
//    8 * $Revision date: 2008.01.__
//    9 ********************************************************************************/
//   10 
//   11 #define SER0INT_C
//   12 
//   13 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// __ProtocolPtr __data PcSerB
PcSerB:
        DS8 48

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data Digital_StsData[100]
Digital_StsData:
        DS8 100

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data DnLoad_Data[200]
DnLoad_Data:
        DS8 200

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DnLoad_Cnt
DnLoad_Cnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data DownloadID
DownloadID:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iResetCase
iResetCase:
        DS8 1
//   14 #include "download.c"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork INT32U WRCS_DownLoadGiveupTimerSet(INT32U)
WRCS_DownLoadGiveupTimerSet:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        CBZ      R0,??WRCS_DownLoadGiveupTimerSet_0
        STR      R0,[R4, #+24]
        MOVW     R1,#+20000
        MOVS     R0,#+6
        BL       TimerRegist
??WRCS_DownLoadGiveupTimerSet_0:
        LDR      R0,[R4, #+24]
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void WRCS_DownLoadGiveupTimerRst(void)
WRCS_DownLoadGiveupTimerRst:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        MOVS     R1,#+0
        STR      R1,[R0, #+24]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork BOOL WRCS_DownLoadGiveupTimerChk(__ProtocolPtr *)
WRCS_DownLoadGiveupTimerChk:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDR      R1,[R4, #+16]
        CMP      R0,R1
        BNE.N    ??WRCS_DownLoadGiveupTimerChk_0
        MOVS     R0,#+6
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??WRCS_DownLoadGiveupTimerChk_0
        MOVS     R0,#+0
        STR      R0,[R4, #+24]
        MOVS     R0,#+1
        POP      {R4,PC}
??WRCS_DownLoadGiveupTimerChk_0:
        MOVS     R0,#+0
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork INT8U WRCS_DownloadFunc(__ProtocolPtr *)
WRCS_DownloadFunc:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+16
        MOV      R8,R0
        LDR      R0,[R8, #+32]
        LDRB     R1,[R0, #+1047]
        MOVW     R2,#+1036
        MLA      R0,R1,R2,R0
        ADD      R5,R0,#+8
        LDR.N    R6,??WRCS_DownloadFunc_0  ;; `?<Constant {0}>`
        ADD      R0,SP,#+0
        LDM      R6!,{R1-R3}
        STM      R0!,{R1-R3}
        SUBS     R6,R6,#+12
        MOVS     R7,#+0
        LDRB     R10,[R5, #+0]
        LDRB     R9,[R5, #+1]
        LDRB     R4,[R5, #+2]
        LDRB     R0,[R5, #+3]
        CMP      R0,#+11
        BEQ.N    ??WRCS_DownloadFunc_1
        CMP      R0,#+12
        BEQ.N    ??WRCS_DownloadFunc_2
        CMP      R0,#+13
        BEQ.N    ??WRCS_DownloadFunc_3
        CMP      R0,#+14
        BEQ.N    ??WRCS_DownloadFunc_4
        CMP      R0,#+139
        BEQ.N    ??WRCS_DownloadFunc_5
        CMP      R0,#+140
        BEQ.N    ??WRCS_DownloadFunc_6
        CMP      R0,#+141
        BEQ.N    ??WRCS_DownloadFunc_7
        CMP      R0,#+142
        BEQ.N    ??WRCS_DownloadFunc_8
        B.N      ??WRCS_DownloadFunc_9
??WRCS_DownloadFunc_5:
        MOVS     R0,#+155
        STRB     R0,[R5, #+3]
??WRCS_DownloadFunc_1:
        STRB     R7,[SP, #+0]
        ADD      R1,SP,#+0
        LDRB     R0,[R5, #+7]
        STRB     R0,[R1, #+1]
        LDRB     R0,[R5, #+8]
        STRB     R0,[R1, #+2]
        LDRB     R0,[R5, #+9]
        STRB     R0,[R1, #+3]
        MOVS     R7,#+4
        LDRB     R0,[R5, #+8]
        LDRB     R1,[R5, #+9]
        ORR      R0,R1,R0, LSL #+8
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        STRH     R0,[R1, #+10]
        B.N      ??WRCS_DownloadFunc_9
??WRCS_DownloadFunc_6:
        MOVS     R0,#+156
        STRB     R0,[R5, #+3]
??WRCS_DownloadFunc_2:
        BL       OS_CPU_SR_Save
        STRB     R7,[SP, #+0]
        MOVS     R7,#+1
        BL       OS_CPU_SR_Restore
        B.N      ??WRCS_DownloadFunc_9
??WRCS_DownloadFunc_7:
        MOVS     R0,#+157
        STRB     R0,[R5, #+3]
??WRCS_DownloadFunc_3:
        MOV      R0,R8
        BL       WRCS_ReceiveData
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        LSRS     R0,R0,#+31
        STRB     R0,[SP, #+0]
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        LDRH     R0,[R1, #+8]
        ADD      R1,SP,#+0
        LSRS     R2,R0,#+8
        STRB     R2,[R1, #+1]
        STRB     R0,[R1, #+2]
        MOVS     R7,#+3
        B.N      ??WRCS_DownloadFunc_9
??WRCS_DownloadFunc_8:
        MOVS     R0,#+158
        STRB     R0,[R5, #+3]
??WRCS_DownloadFunc_4:
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        LDRH     R0,[R1, #+12]
        LDRB     R2,[R5, #+9]
        LDRB     R3,[R5, #+10]
        ORR      R2,R3,R2, LSL #+8
        CMP      R0,R2
        BNE.N    ??WRCS_DownloadFunc_10
        LDRH     R2,[R1, #+10]
        LDRH     R3,[R1, #+8]
        ADDS     R3,R3,#+1
        CMP      R2,R3
        BNE.N    ??WRCS_DownloadFunc_10
        STRB     R7,[SP, #+0]
        B.N      ??WRCS_DownloadFunc_11
??WRCS_DownloadFunc_10:
        MOVS     R2,#+1
        STRB     R2,[SP, #+0]
??WRCS_DownloadFunc_11:
        LDRH     R2,[R1, #+10]
        ADD      R1,SP,#+0
        LSRS     R3,R2,#+8
        STRB     R3,[R1, #+1]
        STRB     R2,[R1, #+2]
        LSRS     R2,R0,#+8
        STRB     R2,[R1, #+3]
        STRB     R0,[R1, #+4]
        MOVS     R7,#+5
??WRCS_DownloadFunc_9:
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        LDRB     R1,[R5, #+3]
        MOV      R0,R7
        PUSH     {R0,R1}
        ADD      R3,SP,#+16
        MOV      R2,R4
        MOV      R1,R9
        MOV      R0,R10
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
        LDRB     R0,[R5, #+3]
        CMP      R0,#+14
        BEQ.N    ??WRCS_DownloadFunc_12
        CMP      R0,#+158
        BNE.N    ??WRCS_DownloadFunc_13
??WRCS_DownloadFunc_12:
        LDRB     R0,[SP, #+0]
        CBNZ     R0,??WRCS_DownloadFunc_13
        LDR.N    R0,??DataTable17  ;; 0x1ffff7e0
        LDRH     R1,[R0, #+0]
        RSBS     R2,R1,#+0
        RSBS     R3,R1,#+0
        LSLS     R1,R3,#+10
        LDR.N    R3,??WRCS_DownloadFunc_0+0x4  ;; 0x60807028
        LDR      R1,[R3, R1]
        ADD      R1,R1,R2, LSL #+10
        LDR.N    R2,??WRCS_DownloadFunc_0+0x8  ;; 0x60807000
        ADDS     R1,R2,R1
        LDRH     R0,[R0, #+0]
        RSBS     R2,R0,#+0
        LSLS     R0,R2,#+10
        LDR.N    R2,??WRCS_DownloadFunc_0+0xC  ;; 0x60807024
        LDR      R0,[R2, R0]
        SUBS     R5,R1,R0
        LDR.N    R4,??WRCS_DownloadFunc_0+0x10  ;; convinfo
        MOV      R0,R4
        BL       strlen
        MOV      R2,R0
        MOV      R1,R4
        MOV      R0,R5
        BL       memcmp
        CBNZ     R0,??WRCS_DownloadFunc_13
        MOVS     R0,#+2
        BL       ResetCaseBackup
        LDR.N    R0,??WRCS_DownloadFunc_0+0x14  ;; rambackup
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+0]
        ADD      R0,R6,#+12
        LDR.W    R2,??DataTable31  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        MOVS     R0,#+10
        BL       OSTimeDly
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+28]
        BL       DownloadFlagSetExtSRAM
        BL       DownLoadBootingJump
??WRCS_DownloadFunc_13:
        MOVS     R0,#+1
        ADD      SP,SP,#+16
        POP      {R4-R10,PC}      ;; return
        DATA
??WRCS_DownloadFunc_0:
        DC32     `?<Constant {0}>`
        DC32     0x60807028
        DC32     0x60807000
        DC32     0x60807024
        DC32     convinfo
        DC32     rambackup

        SECTION `.data`:DATA:NOROOT(2)
// BOOL __data SerialPadOnFlag
SerialPadOnFlag:
        DATA
        DC8 0
// INT8U __data ALLResetFlag
ALLResetFlag:
        DC8 0
// INT8U __data pCtrlComm
pCtrlComm:
        DC8 0
// INT8U __data iDebugCnt
iDebugCnt:
        DC8 0
// INT8U __data iUser_Value2
iUser_Value2:
        DC8 0
// INT8U __data RmtSelfErrCnt
RmtSelfErrCnt:
        DC8 0
// INT8U __data RmtSelfStep
RmtSelfStep:
        DC8 0
// INT8U __data RmtSelfId2
RmtSelfId2:
        DC8 0
// INT16U __data FrameCnt
FrameCnt:
        DC16 65535
// INT16U __data TotFrame
TotFrame:
        DC16 65535
// INT16U __data Swcrc16
Swcrc16:
        DC16 0
        DC8 0, 0
// __ProtocolPtr *__data PcSer
PcSer:
        DC32 PcSerB
// __ProtocolPtr *__data SelfSer
SelfSer:
        DC32 64000000H
// INT32U __data downloadFlag
downloadFlag:
        DC32 0
// INT32S __data DataCount
DataCount:
        DC32 -1
// __ProtocolPtr *__data RmtSelfSrc
RmtSelfSrc:
        DC32 0H
// OS_STK __data Ser1TaskStk[256]
Ser1TaskStk:
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
// __WRCSSIO __data SPcsksio
SPcsksio:
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
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0
// __WRCSSIO __data RPcsksio
RPcsksio:
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
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.data`:DATA:NOROOT(1)
// INT16U __data FrameCounterOld
FrameCounterOld:
        DATA
        DC16 65535

        SECTION `.data`:DATA:NOROOT(1)
// INT16U __data FrameCounter
FrameCounter:
        DATA
        DC16 65535

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork INT8U IsitRmtSelfDn(void)
IsitRmtSelfDn:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDRB     R0,[R0, #+5]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void RmtSelfDnErrClr(void)
RmtSelfDnErrClr:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        MOVS     R1,#+0
        STRB     R1,[R0, #+5]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void RmtDownStart(__ProtocolPtr *, INT8U)
RmtDownStart:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
        LDR.W    R6,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R6, #+28]
        MOV      R1,#+500
        SDIV     R2,R0,R1
        MOV      R3,R2
        MLS      R0,R2,R1,R0
        CBZ      R0,??RmtDownStart_0
        ADDS     R3,R3,#+1
??RmtDownStart_0:
        STRH     R3,[R6, #+10]
        MOVS     R0,#+0
        STRH     R0,[R6, #+8]
        STRB     R0,[R6, #+6]
        MOV      R1,#+2000
        MOVS     R0,#+30
        BL       TimerRegist
        MOVS     R0,#+0
        STRB     R0,[R6, #+5]
        STR      R4,[R6, #+32]
        MOV      R0,R4
        BL       WRCS_DownLoadGiveupTimerSet
        STRB     R5,[R6, #+7]
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void RmtSendDownLoadFunc(void)
RmtSendDownLoadFunc:
        PUSH     {R4,LR}
        MOVS     R0,#+30
        BL       TimeOverCheck
        CBZ      R0,??RmtSendDownLoadFunc_0
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDRB     R0,[R4, #+5]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+5]
        UXTB     R0,R0
        CMP      R0,#+3
        BCS.N    ??RmtSendDownLoadFunc_0
        MOV      R1,#+2000
        MOVS     R0,#+30
        BL       TimerRegist
        LDRB     R0,[R4, #+6]
        CMP      R0,#+3
        BNE.N    ??RmtSendDownLoadFunc_0
        BL       RmtDnDataSend
??RmtSendDownLoadFunc_0:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void RmtRecvDownLoadFunc(__ProtocolPtr *)
RmtRecvDownLoadFunc:
        PUSH     {R4,LR}
        LDR      R0,[R0, #+32]
        ADDS     R0,R0,#+8
        LDRB     R1,[R0, #+3]
        CMP      R1,#+11
        BEQ.N    ??RmtRecvDownLoadFunc_0
        CMP      R1,#+12
        BEQ.N    ??RmtRecvDownLoadFunc_1
        CMP      R1,#+13
        BEQ.N    ??RmtRecvDownLoadFunc_2
        CMP      R1,#+14
        BEQ.N    ??RmtRecvDownLoadFunc_3
        POP      {R4,PC}
??RmtRecvDownLoadFunc_0:
        LDRB     R1,[R0, #+7]
        CMP      R1,#+0
        BNE.N    ??RmtRecvDownLoadFunc_4
        LDRB     R1,[R0, #+9]
        LDRB     R0,[R0, #+10]
        ORR      R0,R0,R1, LSL #+8
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        LDRH     R1,[R1, #+10]
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_4
??RmtRecvDownLoadFunc_5:
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
??RmtRecvDownLoadFunc_6:
        LDRB     R0,[R4, #+6]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+6]
??RmtRecvDownLoadFunc_7:
        MOVS     R0,#+0
        STRB     R0,[R4, #+5]
        MOVS     R1,#+10
        MOVS     R0,#+30
        POP      {R4,LR}
        B.W      TimerRegist
??RmtRecvDownLoadFunc_1:
        LDRB     R0,[R0, #+7]
        CMP      R0,#+0
        BNE.N    ??RmtRecvDownLoadFunc_4
        B.N      ??RmtRecvDownLoadFunc_5
??RmtRecvDownLoadFunc_2:
        LDRB     R1,[R0, #+7]
        CMP      R1,#+0
        BNE.N    ??RmtRecvDownLoadFunc_4
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDRH     R1,[R4, #+8]
        LDRB     R2,[R0, #+8]
        LDRB     R0,[R0, #+9]
        ORR      R0,R0,R2, LSL #+8
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_4
        ADDS     R0,R1,#+1
        STRH     R0,[R4, #+8]
        LDRH     R1,[R4, #+10]
        UXTH     R0,R0
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_7
        B.N      ??RmtRecvDownLoadFunc_6
??RmtRecvDownLoadFunc_3:
        LDRB     R1,[R0, #+7]
        CMP      R1,#+0
        BNE.N    ??RmtRecvDownLoadFunc_4
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDRB     R1,[R0, #+8]
        LDRB     R0,[R0, #+9]
        ORR      R0,R0,R1, LSL #+8
        LDRH     R1,[R4, #+10]
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_4
        MOVS     R0,#+30
        BL       TimerCancel
        MOVS     R0,#+0
        STR      R0,[R4, #+24]
??RmtRecvDownLoadFunc_4:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void RmtDnFrameStart(void)
RmtDnFrameStart:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void RmtDnConFirmSend(void)
RmtDnConFirmSend:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtDnDataSend(void)
RmtDnDataSend:
        PUSH     {R4-R7}
        LDR.N    R0,??DataTable17  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.N    R1,??RmtDnDataSend_0  ;; 0x8007000
        ADD      R1,R1,R0, LSL #+10
        LDR.W    R2,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R2, #+32]
        LDR      R3,[R0, #+36]
        ADD      R5,R3,#+8
        MOV      R3,#+500
        MOV      R4,R3
        LDRH     R6,[R2, #+8]
        LSRS     R6,R6,#+8
        STRB     R6,[R5, #+7]
        LDRH     R6,[R2, #+8]
        STRB     R6,[R5, #+8]
        LDRH     R6,[R2, #+10]
        LDRH     R7,[R2, #+8]
        ADDS     R7,R7,#+1
        CMP      R6,R7
        BNE.N    ??RmtDnDataSend_1
        LDR      R6,[R2, #+28]
        SDIV     R7,R6,R3
        MLS      R6,R7,R3,R6
        CBZ      R6,??RmtDnDataSend_1
        MOV      R4,R6
??RmtDnDataSend_1:
        MOVS     R6,#+0
        UXTH     R4,R4
        CBZ      R4,??RmtDnDataSend_2
        ADDS     R5,R5,#+2
??RmtDnDataSend_3:
        LDRH     R7,[R2, #+8]
        MLA      R7,R7,R3,R6
        LDRB     R7,[R7, R1]
        STRB     R7,[R5, #+7]
        ADDS     R6,R6,#+1
        ADDS     R5,R5,#+1
        UXTH     R7,R6
        CMP      R7,R4
        BCC.N    ??RmtDnDataSend_3
??RmtDnDataSend_2:
        POP      {R4-R7}
        B.N      WRCS_DownLoadGiveupTimerSet
        DATA
??RmtDnDataSend_0:
        DC32     0x8007000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     0x1ffff7e0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void RmtDnEndSend(void)
RmtDnEndSend:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork BOOL WRCS_ReceiveData(__ProtocolPtr *)
WRCS_ReceiveData:
        PUSH     {R4-R8,LR}
        LDR      R0,[R0, #+32]
        LDRB     R1,[R0, #+1047]
        MOVW     R2,#+1036
        MLA      R0,R1,R2,R0
        ADD      R4,R0,#+8
        LDRB     R0,[R4, #+7]
        ADDS     R1,R4,#+7
        LDRB     R1,[R1, #+1]
        ORRS     R5,R1,R0, LSL #+8
        LDR.W    R6,??DataTable29  ;; SerialPadOnFlag
        BNE.N    ??WRCS_ReceiveData_0
        MOVS     R0,#+0
        STR      R0,[R6, #+28]
        STRH     R0,[R6, #+12]
??WRCS_ReceiveData_1:
        LDRH     R0,[R4, #+1031]
        SUBS     R7,R0,#+2
        LDR      R2,[R6, #+28]
        UXTH     R1,R7
        ADD      R0,R4,#+9
        BL       UpLoadExtSRAM
        MOV      R8,R0
        STR      R8,[R6, #+28]
        LDRH     R2,[R6, #+12]
        MOV      R1,R7
        ADD      R0,R4,#+9
        BL       Crc16Calc
        STRH     R0,[R6, #+12]
        STRH     R5,[R6, #+8]
        MOV      R0,#-1
        CMP      R8,R0
        BNE.N    ??WRCS_ReceiveData_2
??WRCS_ReceiveData_3:
        MOVS     R0,#+0
        POP      {R4-R8,PC}
??WRCS_ReceiveData_0:
        LDRH     R0,[R6, #+8]
        ADDS     R2,R0,#+1
        CMP      R5,R2
        BNE.N    ??WRCS_ReceiveData_3
        CMP      R5,R0
        BNE.N    ??WRCS_ReceiveData_1
??WRCS_ReceiveData_2:
        MOVS     R0,#+1
        POP      {R4-R8,PC}       ;; return
//   15 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   16 void WRCS_SerInit(void)
//   17 {
WRCS_SerInit:
        PUSH     {R4,LR}
//   18  	PcSer->CheckByte = pUSART1.CheckByte;
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R4, #+16]
        LDR.N    R1,??WRCS_SerInit_0  ;; pUSART1
        LDR      R2,[R1, #+4]
        STR      R2,[R0, #+0]
//   19 	PcSer->RxGetByte = pUSART1.RxGetByte;
        LDR      R2,[R1, #+8]
        STR      R2,[R0, #+4]
//   20 	PcSer->PutStr = pUSART1.PutStr;
        LDR      R2,[R1, #+12]
        STR      R2,[R0, #+8]
//   21 	PcSer->TxCheckByte = pUSART1.TxCheckByte;
        LDR      R1,[R1, #+28]
        STR      R1,[R0, #+16]
//   22 
//   23 	PcSer->TimerRx = TimerSioRx;
        MOVS     R1,#+2
        STRH     R1,[R0, #+20]
//   24 	PcSer->WRCSRecv = &RPcsksio;
        ADDW     R1,R4,#+2108
        STR      R1,[R0, #+32]
//   25 	PcSer->WRCSSend = &SPcsksio;
        ADDW     R1,R4,#+1060
        STR      R1,[R0, #+36]
//   26 	PcSer->OSSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+16]
        STR      R0,[R1, #+28]
//   27 
//   28 	Initialize();
        BL       Initialize
//   29 
//   30 	OSTaskCreate(WRCSTask, (void *)PcSer, (OS_STK *)&Ser1TaskStk[SER1_STK_SIZE - 1], SER0TASK_PRIO);
        MOVS     R3,#+1
        ADD      R2,R4,#+1056
        LDR      R1,[R4, #+16]
        LDR.N    R0,??WRCS_SerInit_0+0x4  ;; WRCSTask
        POP      {R4,LR}
        B.W      OSTaskCreate
        Nop      
        DATA
??WRCS_SerInit_0:
        DC32     pUSART1
        DC32     WRCSTask
//   31 
//   32  }
//   33 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   34 void WRCSTask(void *pdata)
//   35 {
WRCSTask:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   36 	__ProtocolPtr *nPtr = (__ProtocolPtr *)pdata;
//   37 
//   38     nPtr = nPtr;
//   39 	pdata = pdata;
//   40 	OSTimeDly(100*SER0TASK_PRIO);
        MOVS     R0,#+100
        BL       OSTimeDly
        LDR.N    R5,??WRCSTask_0  ;; tTestFlag
//   41 
//   42 	while(1)
//   43 	{
//   44 		nPtr->WRCSRecv->cBody = 0;
??WRCSTask_1:
        LDR      R0,[R4, #+32]
        MOVS     R1,#+0
        STRB     R1,[R0, #+1047]
//   45 		StsCheckConnectionRst(nPtr);
        MOV      R0,R4
        BL       StsCheckConnectionRst
//   46 	
//   47 		if(!tTestFlag)
        LDRB     R0,[R5, #+0]
        CBNZ     R0,??WRCSTask_2
//   48 		{
//   49 			if(WRCS_ProtocolCheck(nPtr))
        MOV      R0,R4
        BL       WRCS_ProtocolCheck
        CBZ      R0,??WRCSTask_2
//   50 			{
//   51 			#if TWO_BODY >= 2
//   52 				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   53 				{
//   54 			#endif
//   55 					ProtocolComCheck(nPtr);
        MOV      R0,R4
        BL       ProtocolComCheck
//   56 			#if TWO_BODY >= 2
//   57 					nPtr->WRCSRecv->cBody++;
//   58 				}
//   59 			#endif
//   60 			}			
//   61 		}
//   62 		WRCS_DownLoadGiveupTimerChk(nPtr);
??WRCSTask_2:
        MOV      R0,R4
        BL       WRCS_DownLoadGiveupTimerChk
//   63 		OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
        B.N      ??WRCSTask_1
        Nop      
        DATA
??WRCSTask_0:
        DC32     tTestFlag
//   64 	}
//   65 }
//   66 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 void StsCheckConnectionSet(__ProtocolPtr *nPtr)
//   68 {
StsCheckConnectionSet:
        PUSH     {R4,LR}
//   69 	if(nPtr == PcSer)
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        LDR      R2,[R1, #+16]
        CMP      R0,R2
        BNE.N    ??StsCheckConnectionSet_0
//   70 	{
//   71 		SerialPadOnFlag = 1;
        MOVS     R0,#+1
        STRB     R0,[R1, #+0]
//   72 		TimerRegist(TimerSerCheck, 60*Time1Sec);
        MOVW     R1,#+60000
        MOVS     R0,#+9
        B.N      ??StsCheckConnectionSet_1
//   73 	}
//   74 	else if(nPtr == Wrcs0)
??StsCheckConnectionSet_0:
        LDR.N    R1,??DataTable26  ;; Wrcs0
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??StsCheckConnectionSet_2
//   75 	{
//   76 		UdpPadOnFlag = 1;
        LDR.N    R0,??DataTable27  ;; UdpPadOnFlag
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//   77 		TimerRegist(TimerUdp0Check, 60*Time1Sec);
        MOVW     R4,#+60000
        MOV      R1,R4
        MOVS     R0,#+7
        BL       TimerRegist
//   78 		MySts->ServerPadFlag = 1;
        LDR.N    R0,??DataTable28  ;; MySts
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+267]
//   79 		TimerRegist(TimerServerPadFlag, ServerPadTime);
        MOV      R1,R4
        MOVS     R0,#+26
??StsCheckConnectionSet_1:
        BL       TimerRegist
//   80 	}
//   81 }
??StsCheckConnectionSet_2:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   82 void StsCheckConnectionRst(__ProtocolPtr *nPtr)
//   83 {
StsCheckConnectionRst:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   84 	if(nPtr == PcSer && TimeOverCheck(TimerSerCheck)) 		SerialPadOnFlag = 0;
        LDR.W    R5,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R5, #+16]
        CMP      R4,R0
        BNE.N    ??StsCheckConnectionRst_0
        MOVS     R0,#+9
        BL       TimeOverCheck
        CBZ      R0,??StsCheckConnectionRst_0
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//   85 	if(nPtr == Wrcs0 && TimeOverCheck(TimerUdp0Check))  	UdpPadOnFlag = 0;
??StsCheckConnectionRst_0:
        LDR.N    R5,??DataTable26  ;; Wrcs0
        LDR      R0,[R5, #+0]
        CMP      R4,R0
        BNE.N    ??StsCheckConnectionRst_1
        MOVS     R0,#+7
        BL       TimeOverCheck
        CBZ      R0,??StsCheckConnectionRst_1
        LDR.N    R0,??DataTable27  ;; UdpPadOnFlag
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   86 	if(nPtr == Wrcs0 && TimeOverCheck(TimerServerPadFlag))  MySts->ServerPadFlag = 0;
??StsCheckConnectionRst_1:
        LDR      R0,[R5, #+0]
        CMP      R4,R0
        BNE.N    ??StsCheckConnectionRst_2
        MOVS     R0,#+26
        BL       TimeOverCheck
        CBZ      R0,??StsCheckConnectionRst_2
        LDR.N    R0,??DataTable28  ;; MySts
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+267]
//   87 
//   88 }
??StsCheckConnectionRst_2:
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable26:
        DC32     Wrcs0

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable27:
        DC32     UdpPadOnFlag

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable28:
        DC32     MySts
//   89 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   90 INT32U WRCS_ProtocolCheck(__ProtocolPtr *nPtr)
//   91 {
WRCS_ProtocolCheck:
        PUSH     {R3-R9,LR}
        MOV      R4,R0
//   92 	INT16U nInitCnt, nCnt;
//   93 	INT16U i = 0;
//   94 	INT16U Data;
//   95 
//   96 	__WRCSSIO *Recv = nPtr->WRCSRecv;
        LDR      R5,[R4, #+32]
//   97 
//   98 	TimerRegist(nPtr->TimerRx, Time1Sec*2L);
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
        LDR.N    R6,??WRCS_ProtocolCheck_0  ;; 0x1b7740
        B.N      ??WRCS_ProtocolCheck_1
//   99 
//  100 	while(1)
//  101 	{
//  102 		if(TimeOverCheck(nPtr->TimerRx)) return FALSE;	
//  103 
//  104 		if(nPtr->CheckByte(1, &nCnt))
//  105 		{
//  106 			Data = nPtr->RxGetByte();
//  107 			
//  108 			if(STX == Data/*nPtr->RxGetByte()*/)
//  109 			{
//  110 				if(nPtr->CheckByte(1, &nCnt))
//  111 				{
//  112     				if(STX == nPtr->RxGetByte())
//  113 					{
//  114 						if(nPtr->CheckByte(1, &nCnt))
//  115 						{
//  116 							if(STX == nPtr->RxGetByte())
//  117 							{
//  118 								if(nPtr->CheckByte(1, &nCnt))
//  119 								{
//  120 									if(STX == nPtr->RxGetByte())
//  121 									{
//  122 											Recv->Sync[0] = STX;
//  123 											Recv->Sync[1] = STX;
//  124 											Recv->Sync[2] = STX;
//  125 											Recv->Sync[3] = STX;
//  126 											Recv->BodyNo = 0; // Default: 1EA
//  127 											
//  128 											break;
//  129 									}
//  130 								}
//  131 								else OSTimeDly(100L);
//  132 							}
//  133 						}
//  134 						else OSTimeDly(100L);
//  135 					}
//  136 				} 
//  137 				else OSTimeDly(100L);
//  138 			}
//  139 			////////////////////////////////////////////////////////////////////
//  140 			{
//  141 				if((nPtr == PcSer)&&(downloadFlag == 0))
//  142 				{
//  143 					if((Data == 'x')||(Data == 'X'))
//  144 					{
//  145 						iDebugCnt++;
//  146 						
//  147 						if(iDebugCnt > 20)
//  148 						{
//  149 							iUser_Value2 = __ChangeDebug;
//  150 							iDebugCnt = 0; 
//  151 							TimerRegist(Timer_DebugCnt, Time1Min*30L);
//  152 						}
//  153 					}
//  154 				}
//  155 			}
//  156  		} else OSTimeDly(100L);
??WRCS_ProtocolCheck_2:
        MOVS     R0,#+100
        BL       OSTimeDly
??WRCS_ProtocolCheck_1:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_3
??WRCS_ProtocolCheck_4:
        B.N      ?Subroutine1
??WRCS_ProtocolCheck_3:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_2
        LDR      R0,[R4, #+4]
        BLX      R0
        UXTH     R7,R0
        CMP      R7,#+22
        BNE.N    ??WRCS_ProtocolCheck_5
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ      R0,??WRCS_ProtocolCheck_6
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??WRCS_ProtocolCheck_5
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ      R0,??WRCS_ProtocolCheck_6
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??WRCS_ProtocolCheck_5
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ      R0,??WRCS_ProtocolCheck_6
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??WRCS_ProtocolCheck_5
        STRB     R0,[R5, #+0]
        STRB     R0,[R5, #+1]
        STRB     R0,[R5, #+2]
        STRB     R0,[R5, #+3]
        ADDW     R6,R5,#+1044
        MOVS     R0,#+0
        STRB     R0,[R6, #+2]
//  157 	}	
//  158 
//  159 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  160 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_7
??WRCS_ProtocolCheck_6:
        MOVS     R0,#+100
        BL       OSTimeDly
??WRCS_ProtocolCheck_5:
        LDR.N    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R1,[R0, #+16]
        CMP      R4,R1
        BNE.N    ??WRCS_ProtocolCheck_1
        LDR      R1,[R0, #+24]
        CMP      R1,#+0
        BNE.N    ??WRCS_ProtocolCheck_1
        CMP      R7,#+120
        BEQ.N    ??WRCS_ProtocolCheck_8
        CMP      R7,#+88
        BNE.N    ??WRCS_ProtocolCheck_1
??WRCS_ProtocolCheck_8:
        LDRB     R1,[R0, #+3]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+3]
        UXTB     R1,R1
        CMP      R1,#+21
        BCC.N    ??WRCS_ProtocolCheck_1
        MOVS     R1,#+13
        STRB     R1,[R0, #+4]
        MOVS     R1,#+0
        STRB     R1,[R0, #+3]
        MOV      R1,R6
        MOVS     R0,#+31
        BL       TimerRegist
        B.N      ??WRCS_ProtocolCheck_1
//  161 	while(!nPtr->CheckByte(4, &nCnt))
//  162 	{
//  163 		if(TimeOverCheck(nPtr->TimerRx))
//  164 		{
//  165 			if(nCnt > nInitCnt)
//  166 			{
//  167 				nInitCnt = nCnt;
??WRCS_ProtocolCheck_9:
        STRH     R1,[SP, #+2]
//  168 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  169 			}
//  170 			else return FALSE;
//  171 		}
//  172 		OSTimeDly(100L);
??WRCS_ProtocolCheck_10:
        MOVS     R0,#+100
        BL       OSTimeDly
??WRCS_ProtocolCheck_7:
        ADD      R1,SP,#+0
        MOVS     R0,#+4
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ     R0,??WRCS_ProtocolCheck_11
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_10
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCC.N    ??WRCS_ProtocolCheck_9
        B.N      ??WRCS_ProtocolCheck_4
//  173 	}
//  174 	
//  175 	Recv->TryNo 		= nPtr->RxGetByte();
??WRCS_ProtocolCheck_11:
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+4]
//  176 	Recv->BodyLen[0]	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+5]
//  177 	Recv->BodyLen[1]	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+6]
//  178 	Recv->CheckSum		= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+7]
//  179 
//  180 	Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);
        LDRB     R0,[R5, #+5]
        LDRB     R1,[R5, #+6]
        ADD      R0,R1,R0, LSL #+8
        STRH     R0,[R5, #+1044]
//  181 
//  182 	if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
//  183 		|| (Recv->BodyLength >= (TWO_BODY*BODYSIZEMAX))
//  184 	)
        LDRB     R0,[R5, #+7]
        LDRB     R1,[R5, #+4]
        LDRB     R2,[R5, #+5]
        ADDS     R1,R2,R1
        LDRB     R2,[R5, #+6]
        ADDS     R1,R2,R1
        UXTB     R1,R1
        CMP      R0,R1
        BNE.N    ??WRCS_ProtocolCheck_12
        LDRH     R0,[R5, #+1044]
        MOV      R1,#+1024
        CMP      R0,R1
        BCC.N    ??WRCS_ProtocolCheck_13
//  185 	{
//  186 			return FALSE;
??WRCS_ProtocolCheck_12:
        B.N      ?Subroutine1
//  187 	}
//  188     
//  189 #if TWO_BODY >= 2
//  190 BODYRE:
//  191 #endif
//  192 	TimerRegist(nPtr->TimerRx, Time1Sec*2);
??WRCS_ProtocolCheck_13:
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  193 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_14
//  194 	while(1)
//  195 	{
//  196 		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
//  197 		{
//  198 			if(nCnt > nInitCnt)
//  199 			{
//  200 				nInitCnt = nCnt;
//  201 				TimerRegist(nPtr->TimerRx, Time100mSec);
//  202 			}
//  203 			else
//  204 			{
//  205 				return FALSE;
//  206 			}
//  207 		}
//  208 		if(nPtr->CheckByte(7, &nCnt))
//  209 		{
//  210 			break;// include 0x03
//  211 		}
//  212 		OSTimeDly(100L);
??WRCS_ProtocolCheck_15:
        MOVS     R0,#+100
        BL       OSTimeDly
??WRCS_ProtocolCheck_14:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??WRCS_ProtocolCheck_16
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.N    ??WRCS_ProtocolCheck_12
        STRH     R1,[SP, #+2]
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
??WRCS_ProtocolCheck_16:
        ADD      R1,SP,#+0
        MOVS     R0,#+7
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_15
//  213 	}
//  214 	
//  215 	for(i = 0; i < 7 ; i++)
        MOVS     R7,#+0
        MOVW     R8,#+1036
//  216 	{
//  217 		*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubID + i) = nPtr->RxGetByte();
??WRCS_ProtocolCheck_17:
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        ADD      R9,R7,R0
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R9, #+8]
//  218 	}
        ADDS     R7,R7,#+1
        UXTH     R0,R7
        CMP      R0,#+7
        BCC.N    ??WRCS_ProtocolCheck_17
//  219 	
//  220 
//  221 
//  222 	Recv->BodyFrame[Recv->BodyNo].SubLength
//  223 		=	 ((Recv->BodyFrame[Recv->BodyNo].SubLen[0] << 8)& 0xff00)
//  224 		  +  ((Recv->BodyFrame[Recv->BodyNo].SubLen[1] << 0)& 0x00ff);
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R8,R5
        LDRB     R1,[R1, #+13]
        LDRB     R2,[R6, #+2]
        MLA      R2,R2,R8,R5
        LDRB     R2,[R2, #+14]
        ADD      R1,R2,R1, LSL #+8
        STRH     R1,[R0, #+1039]
//  225 
//  226 	if(Recv->BodyFrame[Recv->BodyNo].SubLength >= BODYSIZEMAX)
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        LDRH     R0,[R0, #+1039]
        MOV      R1,#+1024
        CMP      R0,R1
        BCS.W    ??WRCS_ProtocolCheck_4
//  227 	{
//  228 		//SerPtr->printf("SubLength error = %d", Recv->BodyFrame[Recv->BodyNo].SubLength); 
//  229 		return FALSE;
//  230 	}
//  231 
//  232 
//  233 	TimerRegist(nPtr->TimerRx, Time1Sec*2);
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  234 
//  235 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_18
//  236 	while(1)
//  237 	{
//  238 		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
//  239 		{
//  240 			if(nCnt > nInitCnt)
//  241 			{
//  242 				nInitCnt = nCnt;
//  243 				TimerRegist(nPtr->TimerRx, Time100mSec);
//  244 			}
//  245 			else
//  246 			{
//  247 				return FALSE;
//  248 			}
//  249 		}
//  250 		if(nPtr->CheckByte((INT16U)(Recv->BodyFrame[Recv->BodyNo].SubLength + 2), &nCnt))
//  251 		{
//  252 			break;// include 0x03
//  253 		}
//  254 		OSTimeDly(100L);
??WRCS_ProtocolCheck_19:
        MOVS     R0,#+100
        BL       OSTimeDly
??WRCS_ProtocolCheck_18:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??WRCS_ProtocolCheck_20
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.W    ??WRCS_ProtocolCheck_4
        STRH     R1,[SP, #+2]
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
??WRCS_ProtocolCheck_20:
        ADD      R1,SP,#+0
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        LDRH     R0,[R0, #+1039]
        ADDS     R0,R0,#+2
        UXTH     R0,R0
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_19
//  255 	}
//  256 	for(i = 0; i < Recv->BodyFrame[Recv->BodyNo].SubLength + 2; i++)
        MOVS     R7,#+0
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        LDRH     R0,[R0, #+1039]
        ADDS     R0,R0,#+2
        CMP      R0,#+1
        BLT.N    ??WRCS_ProtocolCheck_21
//  257 	{
//  258 	    *((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubData + i) = nPtr->RxGetByte();
??WRCS_ProtocolCheck_22:
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R8,R5
        ADD      R9,R7,R1
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R9, #+15]
//  259 	}
        ADDS     R0,R7,#+1
        UXTH     R7,R0
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R8,R5
        LDRH     R1,[R1, #+1039]
        ADDS     R1,R1,#+2
        CMP      R7,R1
        BLT.N    ??WRCS_ProtocolCheck_22
//  260 
//  261 	Recv->BodyFrame[Recv->BodyNo].Crc= Crc16Calc ( &(Recv->BodyFrame[Recv->BodyNo].SubID[0])
//  262 						                            , Recv->BodyFrame[Recv->BodyNo].SubLength + 5 + 2, NULL);
??WRCS_ProtocolCheck_21:
        LDRB     R0,[R6, #+2]
        MLA      R7,R0,R8,R5
        MOVS     R2,#+0
        MLA      R0,R0,R8,R5
        LDRH     R0,[R0, #+1039]
        ADDS     R1,R0,#+7
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        ADDS     R0,R0,#+8
        BL       Crc16Calc
        STRH     R0,[R7, #+1041]
//  263 	Recv->BodyFrame[Recv->BodyNo].CrcOK = TRUE;
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        MOVS     R1,#+1
        STRB     R1,[R0, #+1043]
//  264 
//  265 	Data = Recv->BodyFrame[Recv->BodyNo].SubLength;
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        LDRH     R2,[R0, #+1039]
//  266 
//  267 	if (   ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc >> 8)!= Recv->BodyFrame[Recv->BodyNo].SubData[Data  ] )
//  268 		|| ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc     )!= Recv->BodyFrame[Recv->BodyNo].SubData[Data+1] )  )
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        LDRH     R0,[R0, #+1041]
        LSRS     R0,R0,#+8
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R8,R5
        ADD      R1,R2,R1
        LDRB     R1,[R1, #+15]
        CMP      R0,R1
        BNE.N    ??WRCS_ProtocolCheck_23
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        LDRH     R0,[R0, #+1041]
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R8,R5
        ADD      R1,R2,R1
        LDRB     R1,[R1, #+16]
        UXTB     R0,R0
        CMP      R0,R1
        BEQ.N    ??WRCS_ProtocolCheck_24
//  269 	{
//  270 		//CRC ERROR!!
//  271 		{
//  272 			//if(nPtr != IORUSer[0] && nPtr != IORUSer[1])
//  273 			//{
//  274 				Recv->BodyFrame[Recv->BodyNo].CrcOK = FALSE;
??WRCS_ProtocolCheck_23:
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R8,R5
        MOVS     R1,#+0
        STRB     R1,[R0, #+1043]
//  275 				SerPtr->printf("CRC Error\n");
        LDR.N    R0,??WRCS_ProtocolCheck_0+0x4  ;; `?<Constant "CRC Error\\n">`
        LDR.N    R1,??DataTable31  ;; SerPtr
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  276 				return TRUE;
        B.N      ??WRCS_ProtocolCheck_25
//  277 			//}
//  278 		}
//  279 	}
//  280 
//  281 #if TWO_BODY >= 2
//  282 	if(!Recv->BodyNo)
//  283 	{
//  284 		if(Recv->BodyLength != (Recv->BodyFrame[Recv->BodyNo].SubLength
//  285 															  + 5 + 2 + 2))
//  286 		{
//  287 			Recv->BodyNo++;
//  288 			goto BODYRE;
//  289 		}
//  290 	}
//  291 #endif	
//  292 ////////////////////////////////////////////////////////////////////////////////
//  293 
//  294 	TimerRegist(nPtr->TimerRx, Time1Sec);
??WRCS_ProtocolCheck_24:
        MOV      R1,#+1000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  295 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_26
//  296 	while(!nPtr->CheckByte(1, &nCnt))
//  297 	{
//  298 		if(TimeOverCheck(nPtr->TimerRx))
//  299 		{
//  300 			if(nCnt > nInitCnt)
//  301 			{
//  302 				nInitCnt = nCnt;
??WRCS_ProtocolCheck_27:
        STRH     R1,[SP, #+2]
//  303 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  304 			}
//  305 			else
//  306 			{
//  307 				return FALSE;
//  308 			}
//  309 		}
//  310 		OSTimeDly(100L);
??WRCS_ProtocolCheck_28:
        MOVS     R0,#+100
        BL       OSTimeDly
??WRCS_ProtocolCheck_26:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ     R0,??WRCS_ProtocolCheck_29
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_28
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCC.N    ??WRCS_ProtocolCheck_27
        B.N      ??WRCS_ProtocolCheck_12
//  311 	}
//  312 	Data = nPtr->RxGetByte();
??WRCS_ProtocolCheck_29:
        LDR      R0,[R4, #+4]
        BLX      R0
        UXTH     R2,R0
//  313 	//if(nPtr != PcSer)
//  314 	//SerPtr->PutToBuffer(Data);
//  315 
//  316 	if(Data != ETX)
        CMP      R2,#+3
        BEQ.N    ??WRCS_ProtocolCheck_25
//  317 	{
//  318 		SerPtr->printf("ETX error = %d", Data); 
        MOV      R1,R2
        LDR.N    R0,??WRCS_ProtocolCheck_0+0x8  ;; `?<Constant "CRC Error\\n">` + 12
        LDR.N    R2,??DataTable31  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  319 		return FALSE;
        B.N      ??WRCS_ProtocolCheck_4
//  320 	}
//  321 	return TRUE;
??WRCS_ProtocolCheck_25:
        MOVS     R0,#+1
        POP      {R1,R4-R9,PC}    ;; return
        DATA
??WRCS_ProtocolCheck_0:
        DC32     0x1b7740
        DC32     `?<Constant "CRC Error\\n">`
        DC32     `?<Constant "CRC Error\\n">` + 12
//  322 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable29:
        DC32     SerialPadOnFlag

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable31:
        DC32     SerPtr

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        MOVS     R0,#+0
        POP      {R1,R4-R9,PC}
//  323 
//  324 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  325 INT16U WRCS_WhatRxComm(__ProtocolPtr *nPtr)
//  326 {
//  327 	INT16U RetVal = 0;
//  328 	INT8U cBody = nPtr->WRCSRecv->cBody;
WRCS_WhatRxComm:
        LDR      R0,[R0, #+32]
        LDRB     R1,[R0, #+1047]
//  329 	
//  330 	if(nPtr->WRCSRecv->BodyFrame[cBody].CrcOK)
        MOVW     R2,#+1036
        MLA      R0,R1,R2,R0
        LDRB     R1,[R0, #+1043]
        CMP      R1,#+0
        BEQ.N    ??WRCS_WhatRxComm_0
//  331 	{
//  332 		RetVal = nPtr->WRCSRecv->BodyFrame[cBody].Command;
        LDRB     R0,[R0, #+11]
        BX       LR
//  333 	}
//  334 	else //NO ERROR
//  335 	{
//  336 		//ERROR CASE
//  337 		RetVal = 0xff;
??WRCS_WhatRxComm_0:
        MOVS     R0,#+255
//  338 	}
//  339     return (RetVal);
        BX       LR               ;; return
//  340 }
//  341 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  342 void ProtocolComCheck (__ProtocolPtr *nPtr)
//  343 {
ProtocolComCheck:
        PUSH     {R3-R11,LR}
        MOV      R4,R0
//  344 	INT16U tcnt = 0;
//  345 	INT8U Comm = WRCS_WhatRxComm(nPtr);
        BL       WRCS_WhatRxComm
        STRB     R0,[SP, #+0]
//  346 	
//  347 	__WRCSSIO *Recv = nPtr->WRCSRecv;
//  348 	__WRCSSIO *Send = nPtr->WRCSSend;
//  349     __BODYFRAME *rBody = &Recv->BodyFrame[0];
        LDR      R0,[R4, #+32]
        ADD      R5,R0,#+8
//  350     __BODYFRAME *sBody = &Send->BodyFrame[0];
        LDR      R0,[R4, #+36]
        ADD      R11,R0,#+8
//  351 
//  352 	INT8U id0 = rBody->SubID[0];
        LDRB     R9,[R5, #+0]
//  353 	INT8U id1 = rBody->SubID[1];
        LDRB     R10,[R5, #+1]
//  354 	INT8U id2 = rBody->SubID[2];
        LDRB     R8,[R5, #+2]
//  355 	INT8U tmpDnr = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  356 	INT8U tmpRmt = 0;
        STRB     R0,[SP, #+2]
//  357 	
//  358 	INT8U IsItMyID = IsItRtnMySysIDtoVAL(id0, id1, id2, &tmpDnr, &tmpRmt);
        ADD      R0,SP,#+2
        PUSH     {R0,LR}
        ADD      R3,SP,#+9
        MOV      R2,R8
        MOV      R1,R10
        MOV      R0,R9
        BL       IsItRtnMySysIDtoVAL
        ADD      SP,SP,#+8
        MOV      R6,R0
//  359 	INT32U sptr = 0;
//  360 
//  361 	//SerPtr->printf("r: id1 = %02x, id2 = %02x, tmpDnr = %02x, tmpRmt = %02x \n", id1, id2, tmpDnr, tmpRmt);
//  362 	// DEBUG
//  363 	#ifdef WRCS_DBG
//  364 	if(nPtr == Wrcs0)
//  365 	{
//  366 		pBodyFrameTx(id0, id1, id2, rBody->SubData, rBody->SubLength, Comm, PcSer, NULL);
//  367 	}
//  368 	#endif
//  369 	
//  370 	if(Comm != AlarmSCODE) StsCheckConnectionSet(nPtr);
        LDRB     R0,[SP, #+0]
        CMP      R0,#+2
        BEQ.N    ??ProtocolComCheck_0
        MOV      R0,R4
        BL       StsCheckConnectionSet
//  371 	if(nPtr == SelfSer) return;
??ProtocolComCheck_0:
        LDR.W    R7,??ProtocolComCheck_1  ;; SerialPadOnFlag
        LDR      R1,[R7, #+20]
        CMP      R4,R1
        BEQ.W    ??ProtocolComCheck_2
//  372 
//  373 	switch(Comm)
        LDRB     R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.W    ??ProtocolComCheck_3
        SUBS     R0,R0,#+1
        BEQ.W    ??ProtocolComCheck_4
        SUBS     R0,R0,#+1
        BEQ.N    ??ProtocolComCheck_5
        SUBS     R0,R0,#+1
        BEQ.W    ??ProtocolComCheck_4
        SUBS     R0,R0,#+8
        CMP      R0,#+3
        BLS.W    ??ProtocolComCheck_6
        SUBS     R0,R0,#+26
        CMP      R0,#+5
        BLS.W    ??ProtocolComCheck_7
        SUBS     R0,R0,#+6
        BEQ.N    ??ProtocolComCheck_8
        SUBS     R0,R0,#+1
        BEQ.W    ??ProtocolComCheck_9
        SUBS     R0,R0,#+52
        BEQ.N    ??ProtocolComCheck_10
        SUBS     R0,R0,#+1
        BEQ.W    ??ProtocolComCheck_2
        SUBS     R0,R0,#+31
        BEQ.W    ??ProtocolComCheck_11
        SUBS     R0,R0,#+2
        BEQ.W    ??ProtocolComCheck_11
        SUBS     R0,R0,#+14
        BEQ.W    ??ProtocolComCheck_12
        SUBS     R0,R0,#+2
        BEQ.W    ??ProtocolComCheck_13
        SUBS     R0,R0,#+84
        BEQ.W    ??ProtocolComCheck_4
        B.N      ??ProtocolComCheck_14
//  374 	{
//  375 		case SystemRCUTypeSetQue:
//  376 		case SystemRCUTypeStsQue:
//  377 		case LocalMacAddrSetQue:
//  378 		case LocalMacAddrStsQue:
//  379 		case LocalIPAddrSetQue:
//  380 		case LocalIPAddrStsQue:
//  381 			MyProtocolComCheck(nPtr);
//  382 		break;
//  383 		
//  384 		case AlarmSCODE:
//  385 		{
//  386   			if(nPtr == PcSer || nPtr == Wrcs0)
??ProtocolComCheck_5:
        LDR      R0,[R7, #+16]
        CMP      R4,R0
        BEQ.N    ??ProtocolComCheck_15
        LDR.W    R0,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.W    ??ProtocolComCheck_2
//  387   			{
//  388 				if(ServRstAlmFlag[tmpDnr][tmpRmt])	MyRstCase.SERVERRstCase[tmpDnr][tmpRmt] = 0x00;
??ProtocolComCheck_15:
        LDRB     R1,[SP, #+1]
        LDR.W    R0,??ProtocolComCheck_1+0x8  ;; ServRstAlmFlag
        ADD      R2,R0,R1, LSL #+1
        LDRB     R0,[SP, #+2]
        LDRB     R3,[R0, R2]
        CMP      R3,#+0
        BEQ.N    ??ProtocolComCheck_16
        LDR.W    R3,??ProtocolComCheck_1+0xC  ;; MyRstCase
        ADD      R3,R3,R1, LSL #+1
        MOVS     R4,#+0
        STRB     R4,[R0, R3]
//  389 				ServAlmSndCnt[tmpDnr][tmpRmt] = 0;
??ProtocolComCheck_16:
        LDR.W    R3,??ProtocolComCheck_1+0x10  ;; ServAlmSndCnt
        ADD      R1,R3,R1, LSL #+1
        MOVS     R3,#+0
        STRB     R3,[R0, R1]
//  390 				ServRstAlmFlag[tmpDnr][tmpRmt]= 0;
        STRB     R3,[R0, R2]
        POP      {R0,R4-R11,PC}
//  391 			}
//  392 		}
//  393 		break;
//  394 
//  395 		case ModuleInformStsQue:
//  396 			if(nPtr == PcSer || nPtr == Wrcs0)
??ProtocolComCheck_10:
        LDR      R0,[R7, #+16]
        CMP      R4,R0
        BEQ.N    ??ProtocolComCheck_17
        LDR.W    R0,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_18
//  397 			{
//  398 				tcnt = GenModuleAutoInformSts(sBody->SubData, tmpDnr, tmpRmt);
??ProtocolComCheck_17:
        LDRB     R2,[SP, #+2]
        LDRB     R1,[SP, #+1]
        ADD      R0,R11,#+7
        BL       GenModuleAutoInformSts
        MOV      R3,R0
//  399 				pBodyFrameTx(id0, id1, id2, sBody->SubData, tcnt, Comm, nPtr, NULL);
        MOVS     R1,#+0
        MOV      R0,R4
??ProtocolComCheck_19:
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        MOV      R0,R3
        PUSH     {R0,R1}
        ADD      R3,R11,#+7
??ProtocolComCheck_20:
        B.N      ??ProtocolComCheck_21
//  400 			}
//  401 			else if(nPtr == IORUSer)
??ProtocolComCheck_18:
        LDR.W    R0,??ProtocolComCheck_1+0x14  ;; IORUSer
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.W    ??ProtocolComCheck_2
//  402 			{
//  403 				if(IsItMyID)
        CMP      R6,#+0
        BEQ.W    ??ProtocolComCheck_2
//  404 				{
//  405 					IsItGetIOURInform = TRUE;
        LDR.W    R0,??ProtocolComCheck_1+0x18  ;; IsItGetIOURInform
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  406 					DnrSts[tmpDnr][tmpRmt].IOURInform.IsitLink = TRUE;
        LDRB     R0,[SP, #+2]
        MOVW     R1,#+269
        MUL      R2,R0,R1
        LDRB     R1,[SP, #+1]
        MOVW     R3,#+538
        LDR.W    R4,??ProtocolComCheck_1+0x1C  ;; DnrSts
        MLA      R0,R1,R3,R4
        ADD      R0,R2,R0
        MOVS     R1,#+1
        STRB     R1,[R0, #+226]
//  407 					DnrSts[tmpDnr][tmpRmt].IOURInform.minform =  *(__ModuleInform *)rBody->SubData;
        ADDS     R0,R0,#+227
        ADDS     R1,R5,#+7
        MOVS     R2,#+32
        BL       __aeabi_memcpy
        POP      {R0,R4-R11,PC}
//  408 				}
//  409 			}
//  410 		break;
//  411 
//  412 		case AutoModuleInformQue:
//  413 			
//  414 		break;
//  415 
//  416 		case IsItLocalCtrlSetRQST:
//  417 			if(IsItMyID) MyProtocolComCheck(nPtr);
??ProtocolComCheck_8:
        CMP      R6,#+0
        BNE.W    ??ProtocolComCheck_7
//  418 			else
//  419 			{
//  420 				if(SystemTypeInfo < 2) {
        LDR.W    R0,??ProtocolComCheck_1+0x20  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.W    ??ProtocolComCheck_2
//  421 					if(nPtr == DnrSer1 &&    (tmpDnr == MyDnrID)) 	
        LDR.W    R0,??ProtocolComCheck_1+0x24  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_22
        LDRB     R0,[SP, #+1]
        LDR.W    R1,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??ProtocolComCheck_22
//  422 						pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, Wrcs1, nPtr);
??ProtocolComCheck_23:
        MOV      R1,R4
        LDR.W    R0,??ProtocolComCheck_1+0x2C  ;; Wrcs1
??ProtocolComCheck_24:
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        LDRH     R0,[R5, #+1031]
??ProtocolComCheck_25:
        PUSH     {R0,R1}
        ADDS     R3,R5,#+7
        B.N      ??ProtocolComCheck_21
//  423 					else if(nPtr == Wrcs1 && (tmpDnr != MyDnrID))
??ProtocolComCheck_22:
        LDR.W    R0,??ProtocolComCheck_1+0x2C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.W    ??ProtocolComCheck_2
        LDRB     R0,[SP, #+1]
        LDR.W    R1,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BEQ.W    ??ProtocolComCheck_2
//  424 						pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, DnrSer0, nPtr);
??ProtocolComCheck_26:
        MOV      R1,R4
        LDR.W    R0,??ProtocolComCheck_1+0x30  ;; DnrSer0
        B.N      ??ProtocolComCheck_24
//  425 				}
//  426 				else
//  427 				{
//  428 					if(nPtr == Wrcs1){
//  429 
//  430 					}
//  431 				}
//  432 			}
//  433 		break;
//  434 
//  435 		case IsItLocalCtrlSetRSPS:
//  436 			{
//  437 				__ProtocolPtr *dptr = (__ProtocolPtr *)nPtr->ctrlsrc;
??ProtocolComCheck_9:
        LDR      R0,[R4, #+24]
//  438 				if(dptr == NULL) break;
        CMP      R0,#+0
        BEQ.W    ??ProtocolComCheck_2
//  439 				if(dptr == PcSer || dptr == Wrcs0) break;
        LDR      R2,[R7, #+16]
        CMP      R0,R2
        BEQ.W    ??ProtocolComCheck_2
        LDR.W    R2,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R2,[R2, #+0]
        CMP      R0,R2
        BEQ.W    ??ProtocolComCheck_2
//  440 				if(dptr == SelfSer) {
        CMP      R0,R1
        BNE.N    ??ProtocolComCheck_27
//  441 					IsItLocalCtrlRSPS = TRUE;
        LDR.W    R0,??ProtocolComCheck_1+0x34  ;; IsItLocalCtrlRSPS
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
        POP      {R0,R4-R11,PC}
//  442 				}
//  443 				else
//  444 				{
//  445 					pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, dptr, NULL);
??ProtocolComCheck_27:
        MOVS     R1,#+0
??ProtocolComCheck_28:
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        LDRH     R0,[R5, #+1031]
        PUSH     {R0,R1}
        ADDS     R3,R5,#+7
        B.N      ??ProtocolComCheck_21
//  446 				}
//  447 			}
//  448 		break;
//  449 		
//  450 
//  451 		case ControlQue:
//  452 		case AlarmMaskSetQue:
//  453 		case ModuleInformSetQue:
//  454 
//  455 			if(WRCS_DownLoadGiveupTimerSet(NULL))
??ProtocolComCheck_4:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CBZ      R0,??ProtocolComCheck_29
//  456 			{
//  457 				if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CMP      R0,R4
        BNE.W    ??ProtocolComCheck_2
//  458 			}
//  459 
//  460 			if(nPtr != IORUSer)
??ProtocolComCheck_29:
        LDR.W    R0,??ProtocolComCheck_1+0x14  ;; IORUSer
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BEQ.W    ??ProtocolComCheck_30
//  461 			{
//  462 				if(SystemTypeInfo < 2) {
        LDR.W    R0,??ProtocolComCheck_1+0x20  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.N    ??ProtocolComCheck_31
//  463 
//  464 					if(nPtr == PcSer || nPtr == Wrcs0)
        LDR      R0,[R7, #+16]
        CMP      R4,R0
        BEQ.N    ??ProtocolComCheck_32
        LDR.W    R1,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R1,[R1, #+0]
        CMP      R4,R1
        BNE.N    ??ProtocolComCheck_33
//  465 					{
//  466 						if(IsItMyID) MyProtocolComCheck(nPtr);
??ProtocolComCheck_32:
        CMP      R6,#+0
        BNE.N    ??ProtocolComCheck_7
//  467 						else 
//  468 						{
//  469 							if(nPtr == PcSer && MySts->IsItLocalCtrl && Comm == ControlQue) {
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_34
        LDR.W    R0,??ProtocolComCheck_1+0x38  ;; MySts
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+192]
        CMP      R0,#+0
        BEQ.N    ??ProtocolComCheck_34
        LDRB     R0,[SP, #+0]
        CMP      R0,#+1
        BNE.N    ??ProtocolComCheck_35
//  470 								tcnt = GenDnrAidSts((INT8U *)rBody->SubData, &DnrSts[MyDnrID][MyRmtID], nPtr);
??ProtocolComCheck_36:
        MOV      R2,R4
        LDR.W    R0,??ProtocolComCheck_1+0x3C  ;; MyRmtID
        LDRB     R0,[R0, #+0]
        MOVW     R1,#+269
        LDR.W    R3,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R3,[R3, #+0]
        MOVW     R6,#+538
        LDR.W    R7,??ProtocolComCheck_1+0x1C  ;; DnrSts
        MLA      R3,R3,R6,R7
        MLA      R1,R0,R1,R3
        ADDS     R0,R5,#+7
        BL       GenDnrAidSts
        MOV      R3,R0
//  471 								pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, tcnt, Comm, nPtr, NULL);	// Response
        MOVS     R1,#+0
        MOV      R0,R4
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        MOV      R0,R3
        B.N      ??ProtocolComCheck_25
//  472 								return;
//  473 							}
??ProtocolComCheck_35:
        CMP      R0,#+3
        BNE.N    ??ProtocolComCheck_34
//  474 							else if(nPtr == PcSer && MySts->IsItLocalCtrl && Comm == AlarmMaskSetQue)
//  475 							{
//  476 								pBodyFrameTx(id0, id1, id2, (INT8U *)DnrSts[tmpDnr][tmpRmt].AlarmMask, 1, Comm, nPtr, NULL);	// Response
??ProtocolComCheck_37:
        MOVS     R1,#+0
        MOV      R0,R4
        PUSH     {R0,R1}
        MOVS     R1,#+3
        MOVS     R0,#+1
        PUSH     {R0,R1}
        LDRB     R0,[SP, #+18]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+17]
        MOVW     R3,#+538
        LDR.W    R4,??ProtocolComCheck_1+0x1C  ;; DnrSts
        MLA      R2,R2,R3,R4
        MLA      R0,R0,R1,R2
        LDRB     R3,[R0, #+190]
??ProtocolComCheck_21:
        MOV      R2,R8
        MOV      R1,R10
        MOV      R0,R9
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  477 								return;
        POP      {R0,R4-R11,PC}
//  478 							}
//  479 						
//  480 							if(tmpDnr == MyDnrID && tmpRmt)	
??ProtocolComCheck_34:
        LDRB     R0,[SP, #+1]
        LDR.W    R1,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.W    ??ProtocolComCheck_26
        LDRB     R0,[SP, #+2]
        CMP      R0,#+0
        BNE.W    ??ProtocolComCheck_23
        B.N      ??ProtocolComCheck_26
//  481 							{
//  482 								//		to WRCS1
//  483 								//		SEND MY_Donor Remote !!
//  484 								//		SerPtr->printf("SEND Remote \n");
//  485 								pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, Wrcs1, nPtr);
//  486 							}
//  487 							else // to Another DONOR Send
//  488 							{
//  489 								pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, DnrSer0, nPtr);
//  490 							}
//  491 						}
//  492 					}
//  493 					else if(nPtr == DnrSer1)
??ProtocolComCheck_33:
        LDR.W    R0,??ProtocolComCheck_1+0x24  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_30
//  494 					{
//  495 						//SerPtr->printf("DATA Recevied %02x\n", IsItMyID);
//  496 						if(IsItMyID){
        CMP      R6,#+0
        BEQ.W    ??ProtocolComCheck_23
//  497 							MyProtocolComCheck(nPtr);		//WRCS_DownloadFunc(nPtr);
        B.N      ??ProtocolComCheck_7
//  498 						}
//  499 						else
//  500 						{
//  501 							//		from Another Donor to Remote
//  502 							//		SEND MY_Donor Remote !!
//  503 							//		SerPtr->printf("SEND Remote \n");
//  504 							pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, Wrcs1, nPtr);
//  505 							
//  506 						}
//  507 					}
//  508 					else //if(nPtr == DnrSer0 || nPtr == WRCS1)
//  509 					{	// response
//  510 						goto CTRLRSPS;
//  511 					}
//  512 				}
//  513 				else
//  514 				{						// REMOTE CASE !!
//  515 					if(IsItMyID) MyProtocolComCheck(nPtr);
??ProtocolComCheck_31:
        CBZ      R6,??ProtocolComCheck_38
??ProtocolComCheck_7:
        MOV      R0,R4
        BL       MyProtocolComCheck
        POP      {R0,R4-R11,PC}
//  516 					else
//  517 					{
//  518 						if(nPtr == PcSer && MySts->IsItLocalCtrl && Comm == ControlQue){
??ProtocolComCheck_38:
        LDR      R0,[R7, #+16]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_39
        LDR.W    R1,??ProtocolComCheck_1+0x38  ;; MySts
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+192]
        CBZ      R1,??ProtocolComCheck_39
        LDRB     R1,[SP, #+0]
        CMP      R1,#+1
        BEQ.N    ??ProtocolComCheck_36
        CMP      R1,#+3
        BEQ.N    ??ProtocolComCheck_37
//  519 							tcnt = GenDnrAidSts((INT8U *)rBody->SubData, &DnrSts[MyDnrID][MyRmtID], nPtr);
//  520 							pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, tcnt, Comm, nPtr, NULL);	// Response
//  521 							return;
//  522 						}
//  523 						else if(nPtr == PcSer && MySts->IsItLocalCtrl && Comm == AlarmMaskSetQue)
//  524 						{
//  525 							pBodyFrameTx(id0, id1, id2, (INT8U *)DnrSts[tmpDnr][tmpRmt].AlarmMask, 1, Comm, nPtr, NULL);	// Response
//  526 							return;
//  527 						}
//  528 						if(nPtr == Wrcs0 || nPtr == PcSer)
??ProtocolComCheck_39:
        LDR.W    R1,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R1,[R1, #+0]
        CMP      R4,R1
        BEQ.W    ??ProtocolComCheck_40
        CMP      R4,R0
        BNE.W    ??ProtocolComCheck_2
        B.N      ??ProtocolComCheck_40
//  529 						{
//  530 							goto RVSCTRLRQST;
//  531 						}
//  532 					}
//  533 				}
//  534 			}
//  535 			else
//  536 			{
//  537 CTRLRSPS:			
//  538 				{
//  539 					__ProtocolPtr *dptr = (__ProtocolPtr *)nPtr->ctrlsrc;
??ProtocolComCheck_30:
        LDR      R6,[R4, #+24]
//  540 					if(dptr == SelfSer) break;
        LDR      R0,[R7, #+20]
        CMP      R6,R0
        BEQ.W    ??ProtocolComCheck_2
//  541 					if(dptr == NULL) break;
        CMP      R6,#+0
        BEQ.W    ??ProtocolComCheck_2
//  542 					
//  543 					if((__SKProtocolPtr *)dptr == RcsSer)
        LDRB     R0,[SP, #+0]
        LDR.W    R1,??ProtocolComCheck_1+0x40  ;; RcsSer
        LDR      R1,[R1, #+0]
        CMP      R6,R1
        BNE.N    ??ProtocolComCheck_41
//  544 					{
//  545 						switch(Comm)
        CMP      R0,#+1
        BEQ.N    ??ProtocolComCheck_42
        CMP      R0,#+145
        BNE.W    ??ProtocolComCheck_2
//  546 						{
//  547 							case ControlQue:
//  548 							case RvsControlRSPS:
//  549 								
//  550 								Comm = RCSControlRSPS;
??ProtocolComCheck_42:
        MOVS     R0,#+129
        STRB     R0,[SP, #+0]
//  551 
//  552 								AnalyzeAidData(nPtr, FALSE, tmpDnr, tmpRmt);
        LDRB     R3,[SP, #+2]
        LDRB     R2,[SP, #+1]
        MOVS     R1,#+0
        MOV      R0,R4
        BL       AnalyzeAidData
//  553 								tcnt = RCSGenAidSts(sBody->SubData, &DnrSts[tmpDnr][tmpRmt]);
        LDRB     R0,[SP, #+2]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+1]
        MOVW     R3,#+538
        LDR.W    R4,??ProtocolComCheck_1+0x1C  ;; DnrSts
        MLA      R2,R2,R3,R4
        MLA      R1,R0,R1,R2
        ADD      R0,R11,#+7
        BL       RCSGenAidSts
        MOV      R3,R0
//  554 								RCSDataAckTx(id0, id1, (INT8U *)sBody->SubData, tcnt, MyPortID, Comm);
        LDRB     R1,[SP, #+0]
        LDR.W    R0,??ProtocolComCheck_1+0x44  ;; MyPortID
        LDRB     R0,[R0, #+0]
        PUSH     {R0,R1}
        UXTB     R3,R3
        ADD      R2,R11,#+7
        MOV      R1,R10
        MOV      R0,R9
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
        POP      {R0,R4-R11,PC}
//  555 							break;
//  556 
//  557 						}
//  558 
//  559 					}
//  560 					else
//  561 					{
//  562 						switch(Comm)
??ProtocolComCheck_41:
        CMP      R0,#+3
        BEQ.N    ??ProtocolComCheck_43
        CMP      R0,#+230
        LDRB     R0,[R7, #+2]
        BNE.N    ??ProtocolComCheck_44
//  563 						{
//  564 							case ModuleInformSetQue:
//  565 								if(pCtrlComm == RvsModuleInformSetRQST){
        CMP      R0,#+134
        BNE.N    ??ProtocolComCheck_45
//  566 									Comm = RvsModuleInformSetRSPS;
        MOVS     R0,#+150
        STRB     R0,[SP, #+0]
//  567 									pCtrlComm = NULL;
        MOVS     R0,#+0
        STRB     R0,[R7, #+2]
//  568 								}
//  569 
//  570 								IsItGetIOURInform = NULL;
??ProtocolComCheck_45:
        LDR.W    R0,??ProtocolComCheck_1+0x18  ;; IsItGetIOURInform
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  571 								pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, dptr, NULL);
        MOV      R0,R6
        B.N      ??ProtocolComCheck_28
//  572 							break;
//  573 							
//  574 							case AlarmMaskSetQue:
//  575 								pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, dptr, NULL);
??ProtocolComCheck_43:
        MOVS     R1,#+0
        MOV      R0,R6
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        LDRH     R0,[R5, #+1031]
        PUSH     {R0,R1}
        ADDS     R3,R5,#+7
        B.N      ??ProtocolComCheck_21
//  576 							break;
//  577 
//  578 							default:
//  579 								if(pCtrlComm == RvsControlRQST) {
??ProtocolComCheck_44:
        CMP      R0,#+129
        BNE.N    ??ProtocolComCheck_46
//  580 									Comm = RvsControlRSPS;
        MOVS     R0,#+145
        STRB     R0,[SP, #+0]
//  581 									pCtrlComm = NULL;
        MOVS     R0,#+0
        STRB     R0,[R7, #+2]
//  582 								}
//  583 
//  584 								AnalyzeAidData(nPtr, FALSE, tmpDnr, tmpRmt);
??ProtocolComCheck_46:
        LDRB     R3,[SP, #+2]
        LDRB     R2,[SP, #+1]
        MOVS     R1,#+0
        MOV      R0,R4
        BL       AnalyzeAidData
//  585 								tcnt = GenDnrAidSts((INT8U *)sBody->SubData, &DnrSts[tmpDnr][tmpRmt], dptr);
        MOV      R2,R6
        LDRB     R0,[SP, #+2]
        MOVW     R1,#+269
        LDRB     R3,[SP, #+1]
        MOVW     R4,#+538
        LDR.W    R5,??ProtocolComCheck_1+0x1C  ;; DnrSts
        MLA      R3,R3,R4,R5
        MLA      R1,R0,R1,R3
        ADD      R0,R11,#+7
        BL       GenDnrAidSts
        MOV      R3,R0
//  586 								pBodyFrameTx(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, dptr, NULL);
        MOVS     R1,#+0
        MOV      R0,R6
        B.N      ??ProtocolComCheck_19
//  587 							break;
//  588 						}
//  589 					}
//  590 				}
//  591 			}
//  592 		break;
//  593 		
//  594 		case StatusRQST:
//  595 		case AlarmRQST:
//  596 			////////////////////////////////////////////////////////////////////////////////
//  597 			if(IsItMyID){
??ProtocolComCheck_11:
        CMP      R6,#+0
        BEQ.W    ??ProtocolComCheck_2
//  598 				MyProtocolComCheck(nPtr);
        B.N      ??ProtocolComCheck_7
//  599 			}
//  600 			else
//  601 			{
//  602 
//  603 
//  604 			}
//  605 		break;
//  606 
//  607 		case AlarmRSPS:
//  608 			RmtAlarmSndCnt[tmpDnr][tmpRmt] = 0;
??ProtocolComCheck_13:
        LDRB     R0,[SP, #+2]
        LDRB     R1,[SP, #+1]
        LDR.W    R2,??ProtocolComCheck_1+0x48  ;; RmtAlarmSndCnt
        ADD      R2,R2,R1, LSL #+1
        MOVS     R3,#+0
        STRB     R3,[R0, R2]
//  609 			MyRstCase.VERTICALRstCase[tmpDnr][tmpRmt] = 0;
        LDR.W    R2,??ProtocolComCheck_1+0xC  ;; MyRstCase
        ADD      R1,R2,R1, LSL #+1
        ADDS     R0,R0,R1
        STRB     R3,[R0, #+8]
        POP      {R0,R4-R11,PC}
//  610 		break;
//  611 		
//  612 		case StatusRSPS:
//  613 			if(nPtr == Wrcs1)
??ProtocolComCheck_12:
        LDR.W    R0,??ProtocolComCheck_1+0x2C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.W    ??ProtocolComCheck_2
//  614 			{
//  615 				AnalyzeAidData(nPtr, FALSE, tmpDnr, tmpRmt);	// response
??ProtocolComCheck_47:
        LDRB     R3,[SP, #+2]
        LDRB     R2,[SP, #+1]
        MOVS     R1,#+0
        MOV      R0,R4
        BL       AnalyzeAidData
        POP      {R0,R4-R11,PC}
//  616 			}
//  617 		break;
//  618 		
//  619 		case StatusQue:
//  620 		{
//  621 			if(nPtr == PcSer || nPtr == Wrcs0 || nPtr == DnrSer1)
??ProtocolComCheck_3:
        LDR      R0,[R7, #+16]
        CMP      R4,R0
        BEQ.N    ??ProtocolComCheck_48
        LDR.N    R0,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BEQ.N    ??ProtocolComCheck_48
        LDR.N    R0,??ProtocolComCheck_1+0x24  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_49
//  622 			{
//  623 				if(nPtr == DnrSer1)
??ProtocolComCheck_48:
        LDRB     R0,[SP, #+2]
        MOVW     R1,#+269
        MUL      R5,R0,R1
        MOVW     R6,#+538
        LDR.N    R7,??ProtocolComCheck_1+0x1C  ;; DnrSts
        LDR.N    R0,??ProtocolComCheck_1+0x24  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_50
//  624 				{
//  625 					tmpDnr = MyDnrID;
        LDR.N    R0,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R0,[R0, #+0]
        STRB     R0,[SP, #+1]
//  626 					tcnt = GenDnrRstSts((INT8U *)sBody->SubData, &DnrSts[tmpDnr][tmpRmt], tmpDnr, tmpRmt, &Comm, nPtr);
        MOV      R1,R4
        ADD      R0,SP,#+0
        PUSH     {R0,R1}
        LDRB     R3,[SP, #+10]
        LDRB     R2,[SP, #+9]
        MOV      R0,R2
        MLA      R0,R0,R6,R7
        ADDS     R1,R5,R0
        ADD      R0,R11,#+7
        BL       GenDnrRstSts
        ADD      SP,SP,#+8
        B.N      ??ProtocolComCheck_51
//  627 				}
//  628 				else{
//  629 					tcnt = GenDnrAidSts((INT8U *)sBody->SubData, &DnrSts[tmpDnr][tmpRmt], nPtr);
??ProtocolComCheck_50:
        MOV      R2,R4
        LDRB     R0,[SP, #+1]
        MLA      R0,R0,R6,R7
        ADDS     R1,R5,R0
        ADD      R0,R11,#+7
        BL       GenDnrAidSts
??ProtocolComCheck_51:
        MOV      R3,R0
//  630 				}
//  631 				pBodyFrameTx(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, NULL);
        MOVS     R1,#+0
        MOV      R0,R4
        B.N      ??ProtocolComCheck_19
//  632 			}
//  633 			else if(nPtr == Wrcs1)
??ProtocolComCheck_49:
        LDR.N    R0,??ProtocolComCheck_1+0x2C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BEQ.W    ??ProtocolComCheck_2
        LDR.N    R0,??ProtocolComCheck_1+0x30  ;; DnrSer0
        LDR      R0,[R0, #+0]
        LDR.N    R1,??ProtocolComCheck_1+0x14  ;; IORUSer
        LDR      R1,[R1, #+0]
        CMP      R4,R1
        BEQ.N    ??ProtocolComCheck_52
        CMP      R4,R0
        BNE.W    ??ProtocolComCheck_2
//  634 			{
//  635 
//  636 
//  637 			}
//  638 			else if(nPtr == IORUSer || nPtr == DnrSer0)	// OTRUSer
//  639 			{
//  640 				if(nPtr == DnrSer0) tmpDnr = MyDnrID ^ 1;
??ProtocolComCheck_52:
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_47
        LDR.N    R0,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R0,[R0, #+0]
        EOR      R0,R0,#0x1
        STRB     R0,[SP, #+1]
        B.N      ??ProtocolComCheck_47
//  641 
//  642 				AnalyzeAidData(nPtr, FALSE, tmpDnr, tmpRmt);	// response				
//  643 			}
//  644 		}
//  645 		break;
//  646 
//  647 		case DownloadCMD:
//  648 		case DownloadCMDConfirm:
//  649 		case DownLoadData:
//  650 		case DownLoadDataConfirm:  
//  651 			{
//  652                 sptr = WRCS_DownLoadGiveupTimerSet(NULL);
??ProtocolComCheck_6:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
//  653 
//  654 				if(id0 == 0xff && id1 == 0xff && id2 == 0xff) {	WRCS_DownloadFunc(nPtr); break;}
        CMP      R9,#+255
        BNE.N    ??ProtocolComCheck_53
        CMP      R10,#+255
        BNE.N    ??ProtocolComCheck_53
        MOV      R1,R8
        CMP      R1,#+255
        BNE.N    ??ProtocolComCheck_53
        MOV      R0,R4
        BL       WRCS_DownloadFunc
        POP      {R0,R4-R11,PC}
//  655 				
//  656 				if(nPtr != IORUSer)
??ProtocolComCheck_53:
        LDR.N    R1,??ProtocolComCheck_1+0x14  ;; IORUSer
        LDR      R1,[R1, #+0]
        CMP      R4,R1
        BEQ.W    ??ProtocolComCheck_54
//  657 				{
//  658 					if(SystemTypeInfo < 2) {	// DONOR CASE !!
        LDR.N    R1,??ProtocolComCheck_1+0x20  ;; SystemTypeInfo
        LDRB     R1,[R1, #+0]
        CMP      R1,#+2
        BCS.N    ??ProtocolComCheck_55
//  659 						if(sptr && (nPtr == PcSer || nPtr == Wrcs0 || nPtr == DnrSer1)) if(sptr != (INT32U)nPtr) return;
        LDR      R1,[R7, #+16]
        CBZ      R0,??ProtocolComCheck_56
        CMP      R4,R1
        BEQ.N    ??ProtocolComCheck_57
        LDR.N    R2,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R2,[R2, #+0]
        CMP      R4,R2
        BEQ.N    ??ProtocolComCheck_57
        LDR.N    R2,??ProtocolComCheck_1+0x24  ;; DnrSer1
        LDR      R2,[R2, #+0]
        CMP      R4,R2
        BNE.N    ??ProtocolComCheck_58
??ProtocolComCheck_57:
        CMP      R0,R4
        BNE.W    ??ProtocolComCheck_2
//  660 
//  661 						if(nPtr == PcSer || nPtr == Wrcs0)				//Requset!!
??ProtocolComCheck_56:
        CMP      R4,R1
        BEQ.N    ??ProtocolComCheck_59
        LDR.N    R0,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_58
//  662 						{
//  663 							if(IsItMyID) MyProtocolComCheck(nPtr);		//WRCS_DownloadFunc(nPtr);
??ProtocolComCheck_59:
        CBZ      R6,??ProtocolComCheck_60
??ProtocolComCheck_61:
        MOV      R0,R4
        BL       MyProtocolComCheck
        B.N      ??ProtocolComCheck_14
//  664 							else {
//  665 								
//  666 								WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
??ProtocolComCheck_60:
        MOV      R0,R4
        BL       WRCS_DownLoadGiveupTimerSet
//  667 
//  668 								if(tmpDnr == MyDnrID && tmpRmt)
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??ProtocolComCheck_62
        LDRB     R0,[SP, #+2]
        CBZ      R0,??ProtocolComCheck_62
//  669 								{
//  670 									//		to WRCS1
//  671 									//		SEND MY_Donor Remote !!
//  672 									//		SerPtr->printf("SEND Remote \n");
//  673 									pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, Wrcs1, nPtr);
??ProtocolComCheck_63:
        MOV      R1,R4
        LDR.N    R0,??ProtocolComCheck_1+0x2C  ;; Wrcs1
??ProtocolComCheck_64:
        LDR      R0,[R0, #+0]
        B.N      ??ProtocolComCheck_65
//  674 								}
//  675 								else // to Another DONOR Send
//  676 								{
//  677 									pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, DnrSer0, nPtr);
??ProtocolComCheck_62:
        MOV      R1,R4
        LDR.N    R0,??ProtocolComCheck_1+0x30  ;; DnrSer0
        B.N      ??ProtocolComCheck_64
//  678 								}
//  679 								
//  680 							}
//  681 						}
//  682 						else if(nPtr == DnrSer1)	// DownLoad Reqeuset
??ProtocolComCheck_58:
        LDR.N    R0,??ProtocolComCheck_1+0x24  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_54
//  683 						{
//  684 
//  685 							if(IsItMyID) MyProtocolComCheck(nPtr);		//WRCS_DownloadFunc(nPtr);
        CMP      R6,#+0
        BNE.N    ??ProtocolComCheck_61
//  686 							else if(tmpDnr == MyDnrID && tmpRmt)
        LDRB     R0,[SP, #+1]
        LDR.N    R1,??ProtocolComCheck_1+0x28  ;; MyDnrID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.W    ??ProtocolComCheck_14
        LDRB     R0,[SP, #+2]
        CMP      R0,#+0
        BEQ.W    ??ProtocolComCheck_14
//  687 							{
//  688 								//		to WRCS1
//  689 								//		SEND MY_Donor Remote !!
//  690 								//		SerPtr->printf("SEND Remote \n");
//  691 								//		DO not Sent Another Donor!!
//  692 								WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
        MOV      R0,R4
        BL       WRCS_DownLoadGiveupTimerSet
//  693 								pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, Wrcs1, nPtr);
        MOV      R1,R4
        LDR.N    R0,??ProtocolComCheck_1+0x2C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        B.N      ??ProtocolComCheck_65
//  694 
//  695 							}
//  696 						}
//  697 						else //if(nPtr == DnrSer0 || nPtr == WRCS1)
//  698 						{
//  699 							goto DOWNRSPS;
//  700 						}
//  701 					}
//  702 					else {						// REMOTE CASE !!
//  703 						if(sptr && (nPtr == PcSer || nPtr == Wrcs0 || nPtr == Wrcs1)) if(sptr != (INT32U)nPtr) return;
??ProtocolComCheck_55:
        CBZ      R0,??ProtocolComCheck_66
        LDR      R1,[R7, #+16]
        CMP      R4,R1
        BEQ.N    ??ProtocolComCheck_67
        LDR.N    R1,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R1,[R1, #+0]
        CMP      R4,R1
        BEQ.N    ??ProtocolComCheck_67
        LDR.N    R1,??ProtocolComCheck_1+0x2C  ;; Wrcs1
        LDR      R1,[R1, #+0]
        CMP      R4,R1
        BNE.N    ??ProtocolComCheck_66
??ProtocolComCheck_67:
        CMP      R0,R4
        BNE.W    ??ProtocolComCheck_2
//  704 
//  705 						if(IsItMyID) MyProtocolComCheck(nPtr);
??ProtocolComCheck_66:
        CMP      R6,#+0
        BNE.N    ??ProtocolComCheck_61
//  706 						else if(nPtr == PcSer || nPtr == Wrcs0)
        LDR      R0,[R7, #+16]
        CMP      R4,R0
        BEQ.N    ??ProtocolComCheck_68
        LDR.N    R0,??ProtocolComCheck_1+0x4  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.W    ??ProtocolComCheck_14
//  707 						{
//  708 								WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
??ProtocolComCheck_68:
        MOV      R0,R4
        BL       WRCS_DownLoadGiveupTimerSet
//  709 RVSCTRLRQST:								
//  710 								
//  711 								// to SEND Remote
//  712 									 if(Comm == DownloadCMD)			Comm = RvsDownloadCMDRQST;
??ProtocolComCheck_40:
        LDRB     R0,[SP, #+0]
        CMP      R0,#+11
        BNE.N    ??ProtocolComCheck_69
        MOVS     R0,#+139
??ProtocolComCheck_70:
        STRB     R0,[SP, #+0]
        B.N      ??ProtocolComCheck_63
//  713 								else if(Comm == DownloadCMDConfirm) 	Comm = RvsDownloadCMDConfirmRQST;
??ProtocolComCheck_69:
        CMP      R0,#+12
        BNE.N    ??ProtocolComCheck_71
        MOVS     R0,#+140
        B.N      ??ProtocolComCheck_70
//  714 								else if(Comm == DownLoadData)			Comm = RvsDownLoadDataRQST;
??ProtocolComCheck_71:
        CMP      R0,#+13
        BNE.N    ??ProtocolComCheck_72
        MOVS     R0,#+141
??ProtocolComCheck_73:
        B.N      ??ProtocolComCheck_70
//  715 								else if(Comm == DownLoadDataConfirm)	Comm = RvsDownLoadDataConfirmRQST;
??ProtocolComCheck_72:
        CMP      R0,#+14
        BNE.N    ??ProtocolComCheck_74
        MOVS     R0,#+142
        B.N      ??ProtocolComCheck_70
//  716 								else if(Comm == ControlQue)				Comm = RvsControlRQST;
??ProtocolComCheck_74:
        CMP      R0,#+1
        BNE.N    ??ProtocolComCheck_75
        MOVS     R0,#+129
        B.N      ??ProtocolComCheck_70
//  717 								else if(Comm == AlarmMaskSetQue)		Comm = RvsAlarmMaskSetRQST;
??ProtocolComCheck_75:
        CMP      R0,#+3
        BNE.N    ??ProtocolComCheck_76
        MOVS     R0,#+131
        B.N      ??ProtocolComCheck_70
//  718 								else if(Comm == ModuleInformSetQue)		Comm = RvsModuleInformSetRQST;
??ProtocolComCheck_76:
        CMP      R0,#+230
        BNE.N    ??ProtocolComCheck_63
        MOVS     R0,#+134
        B.N      ??ProtocolComCheck_70
//  719 								
//  720 								pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, Wrcs1, nPtr);
//  721 						}
//  722 					}
//  723 				}
//  724 				else
//  725 				{
//  726 DOWNRSPS:
//  727 	                 {
//  728 						__ProtocolPtr *dptr = (__ProtocolPtr *)nPtr->ctrlsrc;
??ProtocolComCheck_54:
        LDR      R0,[R4, #+24]
//  729 						if(dptr == NULL) break;
        CMP      R0,#+0
        BEQ.W    ??ProtocolComCheck_2
//  730 						if(dptr == SelfSer) break;
        LDR      R1,[R7, #+20]
        CMP      R0,R1
        BEQ.W    ??ProtocolComCheck_2
//  731 						
//  732 
//  733 						if((__SKProtocolPtr *)dptr == RcsSer)
        LDR.N    R2,??ProtocolComCheck_1+0x40  ;; RcsSer
        LDR      R1,[R2, #+0]
        CMP      R0,R1
        BNE.N    ??ProtocolComCheck_77
//  734 						{
//  735 							INT16U i = 0;
//  736 							
//  737 							switch(Comm)
        LDRB     R0,[SP, #+0]
        CMP      R0,#+11
        BEQ.N    ??ProtocolComCheck_78
        CMP      R0,#+12
        BEQ.N    ??ProtocolComCheck_79
        CMP      R0,#+13
        BEQ.N    ??ProtocolComCheck_80
        CMP      R0,#+14
        BEQ.N    ??ProtocolComCheck_81
        B.N      ??ProtocolComCheck_82
//  738 							{
//  739 								case DownloadCMD:				Comm = RCSDownloadCMD;			break;
??ProtocolComCheck_78:
        MOVS     R0,#+0
        B.N      ??ProtocolComCheck_83
//  740 								case DownloadCMDConfirm:		Comm = RCSDownloadCMDConfirm;	break;
??ProtocolComCheck_79:
        MOVS     R0,#+3
        B.N      ??ProtocolComCheck_83
//  741 								case DownLoadData:				Comm = RCSDownLoadData; 		break;
??ProtocolComCheck_80:
        MOVS     R0,#+1
        B.N      ??ProtocolComCheck_83
//  742 								case DownLoadDataConfirm:		Comm = RCSDownLoadDataConfirm;	break;
??ProtocolComCheck_81:
        MOVS     R0,#+2
??ProtocolComCheck_83:
        STRB     R0,[SP, #+0]
//  743 							}
//  744 							RcsSer->Send->BODYFRAME.SubData[0] = Comm;
??ProtocolComCheck_82:
        LDR      R0,[R1, #+40]
        LDRB     R1,[SP, #+0]
        STRB     R1,[R0, #+11]
//  745 
//  746 							for(i = 0; i < rBody->SubLength; i++)
        MOVS     R0,#+0
        LDRH     R1,[R5, #+1031]
        CBZ      R1,??ProtocolComCheck_84
//  747 							{
//  748 								RcsSer->Send->BODYFRAME.SubData[1+i] = rBody->SubData[i];
??ProtocolComCheck_85:
        LDR      R3,[R2, #+0]
        LDR      R3,[R3, #+40]
        ADDS     R3,R0,R3
        ADDS     R1,R0,R5
        LDRB     R1,[R1, #+7]
        STRB     R1,[R3, #+12]
//  749 							}
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRH     R3,[R5, #+1031]
        CMP      R0,R3
        BCC.N    ??ProtocolComCheck_85
//  750 							RCSDataAckTx(id0, id1, (INT8U *)RcsSer->Send->BODYFRAME.SubData, rBody->SubLength + 1, MyPortID, RcsDownloadRSPS);
??ProtocolComCheck_84:
        MOVS     R1,#+160
        LDR.N    R0,??ProtocolComCheck_1+0x44  ;; MyPortID
        LDRB     R0,[R0, #+0]
        PUSH     {R0,R1}
        LDRH     R0,[R5, #+1031]
        ADDS     R3,R0,#+1
        UXTB     R3,R3
        LDR      R0,[R2, #+0]
        LDR      R0,[R0, #+40]
        ADD      R2,R0,#+11
        MOV      R1,R10
        MOV      R0,R9
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
        B.N      ??ProtocolComCheck_14
//  751 						}
//  752 						else
//  753 						{
//  754 							     if(pCtrlComm == RvsDownloadCMDRQST){			Comm = RvsDownloadCMDRSPS;			pCtrlComm = NULL; }
??ProtocolComCheck_77:
        LDRB     R1,[R7, #+2]
        CMP      R1,#+139
        BNE.N    ??ProtocolComCheck_86
        MOVS     R1,#+155
        B.N      ??ProtocolComCheck_87
//  755 							else if(pCtrlComm == RvsDownloadCMDConfirmRQST){	Comm = RvsDownloadCMDConfirmRSPS;	pCtrlComm = NULL; }
??ProtocolComCheck_86:
        CMP      R1,#+140
        BNE.N    ??ProtocolComCheck_88
        MOVS     R1,#+156
        B.N      ??ProtocolComCheck_87
//  756 							else if(pCtrlComm == RvsDownLoadDataRQST){			Comm = RvsDownLoadDataRSPS;			pCtrlComm = NULL; }
??ProtocolComCheck_88:
        CMP      R1,#+141
        BNE.N    ??ProtocolComCheck_89
        MOVS     R1,#+157
        B.N      ??ProtocolComCheck_87
//  757 							else if(pCtrlComm == RvsDownLoadDataConfirmRQST){	Comm = RvsDownLoadDataConfirmRSPS;	pCtrlComm = NULL; }
??ProtocolComCheck_89:
        CMP      R1,#+142
        BNE.N    ??ProtocolComCheck_90
        MOVS     R1,#+158
??ProtocolComCheck_87:
        STRB     R1,[SP, #+0]
        MOVS     R1,#+0
        STRB     R1,[R7, #+2]
//  758 							pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, dptr, NULL);
??ProtocolComCheck_90:
        MOVS     R1,#+0
??ProtocolComCheck_65:
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        LDRH     R0,[R5, #+1031]
        PUSH     {R0,R1}
        ADDS     R3,R5,#+7
        MOV      R2,R8
        MOV      R1,R10
        MOV      R0,R9
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  759 						}
//  760 					}
//  761 				}
//  762 			}
//  763 		default:
//  764 			ProtocolRvsComCheck(nPtr);
??ProtocolComCheck_14:
        MOV      R0,R4
        BL       ProtocolRvsComCheck
//  765 
//  766 			if(nPtr == IORUSer)
        LDR.N    R0,??ProtocolComCheck_1+0x14  ;; IORUSer
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_2
//  767 			{
//  768 				SerPtr->printf(" id0 = %02x \n", rBody->SubID[0]);
        LDR.N    R4,??DataTable32  ;; SerPtr
        LDR.N    R6,??ProtocolComCheck_1+0x4C  ;; `?<Constant " id0 = %02x \\n">`
        LDRB     R1,[R5, #+0]
        MOV      R0,R6
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  769 				SerPtr->printf(" id1 = %02x \n", rBody->SubID[1]);
        LDRB     R1,[R5, #+1]
        ADD      R0,R6,#+16
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  770 				SerPtr->printf(" id2 = %02x \n", rBody->SubID[2]);
        LDRB     R1,[R5, #+2]
        ADD      R0,R6,#+32
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  771 				SerPtr->printf(" Comm = %02x \n", Comm);
        LDRB     R1,[SP, #+0]
        ADD      R0,R6,#+48
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
??ProtocolComCheck_2:
        POP      {R0,R4-R11,PC}   ;; return
        Nop      
        DATA
??ProtocolComCheck_1:
        DC32     SerialPadOnFlag
        DC32     Wrcs0
        DC32     ServRstAlmFlag
        DC32     MyRstCase
        DC32     ServAlmSndCnt
        DC32     IORUSer
        DC32     IsItGetIOURInform
        DC32     DnrSts
        DC32     SystemTypeInfo
        DC32     DnrSer1
        DC32     MyDnrID
        DC32     Wrcs1
        DC32     DnrSer0
        DC32     IsItLocalCtrlRSPS
        DC32     MySts
        DC32     MyRmtID
        DC32     RcsSer
        DC32     MyPortID
        DC32     RmtAlarmSndCnt
        DC32     `?<Constant " id0 = %02x \\n">`
//  772 			}
//  773 		break;
//  774 	}
//  775 	
//  776 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable32:
        DC32     SerPtr
//  777 
//  778 
//  779 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  780 void MyProtocolComCheck(__ProtocolPtr *nPtr)
//  781 {
MyProtocolComCheck:
        PUSH     {R2-R10,LR}
        MOV      R8,R0
//  782 	INT16U tcnt = 0;
//  783 	INT8U Comm = WRCS_WhatRxComm(nPtr);
        BL       WRCS_WhatRxComm
        STRB     R0,[SP, #+0]
//  784 	
//  785 	__WRCSSIO *Recv = nPtr->WRCSRecv;
//  786 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R0,[R8, #+36]
//  787     __BODYFRAME *rBody = &Recv->BodyFrame[0];
        LDR      R1,[R8, #+32]
        ADD      R5,R1,#+8
//  788     __BODYFRAME *sBody = &Send->BodyFrame[0];
        ADD      R9,R0,#+8
//  789 
//  790 	INT8U id0 = rBody->SubID[0];
        LDRB     R0,[R5, #+0]
        STRB     R0,[SP, #+1]
//  791 	INT8U id1 = rBody->SubID[1];
        LDRB     R0,[R5, #+1]
        STRB     R0,[SP, #+3]
//  792 	INT8U id2 = rBody->SubID[2];
        LDRB     R0,[R5, #+2]
        STRB     R0,[SP, #+2]
//  793 	INT8U tmpDnr = MyDnrID;
        LDR.W    R4,??MyProtocolComCheck_0  ;; MyDnrID
        LDRB     R0,[R4, #+0]
        STRB     R0,[SP, #+5]
//  794 	INT8U tmpRmt = MyRmtID;
        LDR.W    R6,??MyProtocolComCheck_0+0x4  ;; MyRmtID
        LDRB     R0,[R6, #+0]
        STRB     R0,[SP, #+4]
//  795 
//  796 	switch(Comm)
        LDRB     R0,[SP, #+0]
        SUBS     R0,R0,#+1
        BEQ.W    ??MyProtocolComCheck_1
        SUBS     R0,R0,#+2
        BEQ.W    ??MyProtocolComCheck_2
        SUBS     R0,R0,#+8
        CMP      R0,#+3
        BLS.W    ??MyProtocolComCheck_3
        SUBS     R0,R0,#+26
        CMP      R0,#+1
        BLS.N    ??MyProtocolComCheck_4
        SUBS     R0,R0,#+2
        CMP      R0,#+1
        BLS.N    ??MyProtocolComCheck_5
        SUBS     R0,R0,#+2
        CMP      R0,#+1
        BLS.N    ??MyProtocolComCheck_6
        SUBS     R0,R0,#+2
        BEQ.W    ??MyProtocolComCheck_7
        SUBS     R0,R0,#+85
        BEQ.N    ??MyProtocolComCheck_8
        SUBS     R0,R0,#+1
        BEQ.W    ??MyProtocolComCheck_1
        SUBS     R0,R0,#+1
        BEQ.N    ??MyProtocolComCheck_8
        SUBS     R0,R0,#+1
        BEQ.W    ??MyProtocolComCheck_2
        SUBS     R0,R0,#+3
        BEQ.W    ??MyProtocolComCheck_9
        SUBS     R0,R0,#+5
        CMP      R0,#+3
        BLS.W    ??MyProtocolComCheck_10
        SUBS     R0,R0,#+91
        BEQ.W    ??MyProtocolComCheck_9
        POP      {R0,R1,R4-R10,PC}
//  797 	{
//  798 		case SystemRCUTypeSetQue:
//  799 		case SystemRCUTypeStsQue:
//  800 			
//  801 			if(nPtr == PcSer)
??MyProtocolComCheck_4:
        LDR.W    R0,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDR      R0,[R0, #+16]
        CMP      R8,R0
        BNE.N    ??MyProtocolComCheck_11
//  802 			{
//  803 				if(Comm == SystemRCUTypeSetQue)
        LDR.W    R6,??MyProtocolComCheck_0+0xC  ;; SystemTypeInfo
        LDRB     R0,[SP, #+0]
        CMP      R0,#+37
        BNE.N    ??MyProtocolComCheck_12
//  804 				{
//  805 					INT32U cpu_sr;
//  806 					EE_BACK1 *tptr;
//  807 			
//  808 					OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R4,R0
//  809 					
//  810 					tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);	// Load 1st Area	
        LDR.W    R7,??MyProtocolComCheck_0+0x10  ;; 0x8006000
        MOV      R0,R7
        BL       RoadBackuptobuffer
//  811 					
//  812 					SystemTypeInfo = rBody->SubData[0]%4;
        LDRB     R1,[R5, #+7]
        LSRS     R2,R1,#+2
        SUB      R1,R1,R2, LSL #+2
        STRB     R1,[R6, #+0]
//  813 					tptr->BackUp.SystemTypeSet = rBody->SubData[0]%4;
        LDRB     R1,[R5, #+7]
        LSRS     R2,R1,#+2
        SUB      R1,R1,R2, LSL #+2
        STRB     R1,[R0, #+39]
//  814 			
//  815 					WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+80
        MOV      R0,R7
        BL       WriteBuffertoBackup
//  816 					OS_EXIT_CRITICAL();
        MOV      R0,R4
        BL       OS_CPU_SR_Restore
//  817 			
//  818 					ResetStart();
        BL       ResetStart
//  819 				}
//  820 				pBodyFrameTx(id0, id1, id2, (INT8U *)&SystemTypeInfo, 1, Comm, nPtr, NULL);
??MyProtocolComCheck_12:
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        MOVS     R0,#+1
        PUSH     {R0,R1}
        MOV      R3,R6
??MyProtocolComCheck_13:
        LDRB     R2,[SP, #+18]
        LDRB     R1,[SP, #+19]
        LDRB     R0,[SP, #+17]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  821 			}
//  822 		break;
//  823 
//  824 		case LocalMacAddrSetQue:
//  825 		case LocalMacAddrStsQue:
//  826 			if(nPtr == PcSer)
//  827 			{
//  828 				if(Comm == LocalMacAddrSetQue)
//  829 				{
//  830 					LocalMacCtrlData(rBody->SubData);
//  831 					ResetStart();
//  832 				}
//  833 				pBodyFrameTx(id0, id1, id2, (INT8U *)MacAddrInfo.MacAddr[ETH0_CHANNEL], 6, Comm, nPtr, NULL);
//  834 			}
//  835 		break;
//  836 		
//  837 		case LocalIPAddrSetQue:
//  838 		case LocalIPAddrStsQue:
//  839 			if(nPtr == PcSer)
//  840 			{
//  841 				if(Comm == LocalIPAddrSetQue)
//  842 				{
//  843 					LocalIPCtrlData((__IPAddrStr *)rBody->SubData);
//  844 					ResetStart();
//  845 				}
//  846 				pBodyFrameTx(id0, id1, id2, (INT8U *)&IPAddrInfo, sizeof(__IPAddrStr)/2, Comm, nPtr, NULL);
//  847 			}
//  848 		break;
//  849 
//  850     	case AlarmRQST:
//  851 		case StatusRQST:
//  852 			if(nPtr == Wrcs1)
//  853 			{
//  854 				IsItRtnMySysIDtoVAL(rBody->SubData[0], rBody->SubData[1], rBody->SubData[2], &tmpDnr, &tmpRmt);
//  855 				AnalyzeAidDataptr(&rBody->SubData[3], rBody->SubLength - 3, FALSE, tmpDnr, tmpRmt);	// response
//  856 				/////////////////////////////////
//  857 				// Generation BodyFrame
//  858 				tcnt = GenDnrRstSts((INT8U *)sBody->SubData, &DnrSts[MyDnrID][MyRmtID], MyDnrID, MyRmtID, &Comm, nPtr);
//  859 				IsItRtnMyVALtoSysID(&id0, &id1, &id2, MyDnrID, MyRmtID);
//  860 
//  861 					 if(Comm == AlarmRQST) 	Comm = AlarmRSPS;
//  862 				else if(Comm == StatusRQST)	Comm = StatusRSPS;
//  863 				
//  864 				pBodyFrameTx(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, StatusRSPS, Wrcs1, NULL);
//  865 			}
//  866 		break;
//  867 
//  868         case IsItLocalCtrlSetRQST:
//  869 			ServerCtrlStart(rBody->SubData[0]);
//  870 			pBodyFrameTx(id0, id1, id2, (INT8U *)&MySts->IsitServerCtrl, 1, IsItLocalCtrlSetRSPS, nPtr, NULL);
//  871 		break;
//  872 		
//  873 		case ControlQue:
//  874 		case RvsControlRQST:
//  875 			{
//  876 				INT8U rval = FALSE;
//  877 				
//  878 				pCtrlComm = Comm;
//  879 				
//  880 				if(Comm == ControlQue)
//  881 				{
//  882 					if(nPtr == DnrSer1 || nPtr == PcSer || nPtr == Wrcs0 || (nPtr == Wrcs1 && SystemTypeInfo >= 2)) rval = TRUE;	// Remote CASE
//  883 				}
//  884 				else if(Comm == RvsControlRQST)
//  885 				{
//  886 					if(nPtr == DnrSer1 || nPtr == Wrcs1 ) rval = TRUE;	// Remote CASE
//  887 				}
//  888 				if(rval)
//  889 				{
//  890 					AnalyzeAidData(nPtr, TRUE, tmpDnr, tmpRmt);
//  891 
//  892 					if(nPtr == PcSer && MySts->IsItLocalCtrl){
//  893 						tcnt = GenDnrAidSts((INT8U *)rBody->SubData, &DnrSts[MyDnrID][MyRmtID], nPtr);
//  894 						pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, tcnt, Comm, nPtr, NULL);	// Response
//  895 						break;
//  896 					}
//  897 					
//  898 					if(SystemTypeInfo < 2){
//  899 						if(Comm == RvsControlRQST) Comm = RvsControlRSPS;
//  900 
//  901 						if(!ALLResetFlag)
//  902 						{
//  903 							tcnt = GenDnrAidSts((INT8U *)rBody->SubData, &DnrSts[MyDnrID][MyRmtID], nPtr);
//  904 							pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, tcnt, Comm, nPtr, NULL);	// Response
//  905 						}
//  906 						else {
//  907 							pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, ControlQue, IORUSer, nPtr); // Send to Request
//  908 						}
//  909 					}
//  910 					else
//  911 					{
//  912 						pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, ControlQue, IORUSer, nPtr); // Send to Request
//  913 						//SerPtr->printf("Recv and send to IORU = %02x, %02x, %02x", id0, id1, id2);
//  914 					}
//  915 				}
//  916 			}
//  917 		break;
//  918 
//  919 		case AlarmMaskSetQue:
//  920 		case RvsAlarmMaskSetRQST:
//  921 		{
//  922 			INT8U rval = FALSE;
//  923 			
//  924 			if(Comm == AlarmMaskSetQue)
//  925 			{
//  926 				if(nPtr == DnrSer1 || nPtr == PcSer || nPtr == Wrcs0 || (nPtr == Wrcs1 && SystemTypeInfo >= 2)) rval = TRUE;	// Remote CASE
//  927 			}
//  928 			else if(Comm == RvsAlarmMaskSetRQST)
//  929 			{
//  930 				if(nPtr == DnrSer1 || nPtr == Wrcs1 ) rval = TRUE;	// Remote CASE
//  931 			}
//  932 			
//  933 			if(rval)
//  934 			{
//  935 				if( !(nPtr == PcSer && MySts->IsItLocalCtrl) )
//  936 				{
//  937 					INT32U cpu_sr;
//  938 					EE_BACK1 *tptr;
//  939 
//  940 					OS_ENTER_CRITICAL();
//  941 					
//  942 					tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);	// Load 1st Area	
//  943 					
//  944 					DnrSts[tmpDnr][tmpRmt].AlarmMask = rBody->SubData[0] & 0x01;
//  945 					tptr->BackUp.AlarmMask = rBody->SubData[0] & 0x01;
//  946 
//  947 					WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
//  948 
//  949 					OS_EXIT_CRITICAL();
//  950 				}
//  951 
//  952 				if(Comm == RvsAlarmMaskSetRQST) Comm = RvsAlarmMaskSetRSPS;
//  953 				pBodyFrameTx(id0, id1, id2, (INT8U *)&DnrSts[tmpDnr][tmpRmt].AlarmMask, 1, Comm, nPtr, NULL);	// Response 
//  954 
//  955 			}
//  956 		}
//  957 		break;
//  958 
//  959 		case ModuleInformSetQue:
//  960 		case RvsModuleInformSetRQST:
//  961 			{
//  962 				INT8U rval = FALSE;
//  963 				
//  964 				pCtrlComm = Comm;
//  965 				
//  966 				if(Comm == ModuleInformSetQue)
//  967 				{
//  968 					if(nPtr == DnrSer1 || nPtr == PcSer || nPtr == Wrcs0 || (nPtr == Wrcs1 && SystemTypeInfo >= 2)) rval = TRUE;	// Remote CASE
//  969 				}
//  970 				else if(Comm == RvsModuleInformSetRQST)
//  971 				{
//  972 					if(nPtr == DnrSer1 || nPtr == Wrcs1 ) rval = TRUE;	// Remote CASE
//  973 				}
//  974 
//  975 				if(rval)
//  976 				{
//  977 					if(id0 == RCUID)
//  978 					{
//  979 						if(rBody->SubLength == 36)
//  980 						{
//  981 							Inform_CtrlDataCopy(&(DnrSts[tmpDnr][tmpRmt].RCUInform.minform), (__ModuleInformCtrl *)&rBody->SubData[2]);
//  982 						}
//  983 						else
//  984 						{
//  985 							Inform_CtrlDataCopy(&(DnrSts[tmpDnr][tmpRmt].RCUInform.minform), (__ModuleInformCtrl *)&rBody->SubData[0]);
//  986 						}
//  987 
//  988 						if(Comm == RvsModuleInformSetRQST) Comm = RvsModuleInformSetRSPS;
//  989 						tcnt = GenModuleInformSts(sBody->SubData, &(DnrSts[tmpDnr][tmpRmt].RCUInform.minform));
//  990 						
//  991 						pBodyFrameTx(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, NULL);	// Response 
//  992 					}
//  993 					else
//  994 					{
//  995 						pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, ModuleInformSetQue, IORUSer, nPtr);
//  996 					}
//  997 				}
//  998 			}
//  999 		break;
// 1000 		
// 1001 		case DownloadCMD:
// 1002 		case DownloadCMDConfirm:
// 1003 		case DownLoadData:
// 1004 		case DownLoadDataConfirm: 
// 1005 
// 1006 			pCtrlComm = Comm;
// 1007 
// 1008 			if(nPtr == PcSer || nPtr == Wrcs0 || (nPtr == Wrcs1 && SystemTypeInfo >= 2) || nPtr == DnrSer1)	// Remote CASE
// 1009 			{
// 1010 
// 1011 				WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
// 1012 
// 1013 				if(id0 == RCUID) WRCS_DownloadFunc(nPtr);		//WRCS_DownloadFunc(nPtr);
// 1014 				else
// 1015 				{
// 1016 					pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, IORUSer, nPtr);
// 1017 				}
// 1018 			}
// 1019 		break;
// 1020 
// 1021 		case RvsDownloadCMDRQST:
// 1022 		case RvsDownloadCMDConfirmRQST:
// 1023         case RvsDownLoadDataRQST:
// 1024        	case RvsDownLoadDataConfirmRQST:
// 1025 
// 1026 			pCtrlComm = Comm;
// 1027 
// 1028 			if(nPtr == DnrSer1 || nPtr == Wrcs1)
// 1029 			{
// 1030 				WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
// 1031 				if(id0 == RCUID) WRCS_DownloadFunc(nPtr);
// 1032 				else
// 1033 				{
// 1034 						 if(Comm == RvsDownloadCMDRQST) 			Comm = DownloadCMD;
// 1035 					else if(Comm == RvsDownloadCMDConfirmRQST)		Comm = DownloadCMDConfirm;
// 1036 					else if(Comm == RvsDownLoadDataConfirmRQST) 	Comm = DownLoadDataConfirm;
// 1037 					else if(Comm == RvsDownLoadDataRQST) 			Comm = DownLoadData;
// 1038 					pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, IORUSer, nPtr);
// 1039 				}
// 1040 			}
// 1041 		break;
// 1042 	}
// 1043 }
??MyProtocolComCheck_11:
        POP      {R0,R1,R4-R10,PC}  ;; return
??MyProtocolComCheck_5:
        LDR.W    R0,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDR      R0,[R0, #+16]
        CMP      R8,R0
        BNE.N    ??MyProtocolComCheck_11
        LDRB     R0,[SP, #+0]
        CMP      R0,#+40
        BNE.N    ??MyProtocolComCheck_14
        ADDS     R0,R5,#+7
        BL       LocalMacCtrlData
        BL       ResetStart
??MyProtocolComCheck_14:
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        MOVS     R0,#+6
        PUSH     {R0,R1}
        LDR.W    R3,??MyProtocolComCheck_0+0x14  ;; MacAddrInfo + 6
        B.N      ??MyProtocolComCheck_13
??MyProtocolComCheck_6:
        LDR.W    R0,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDR      R0,[R0, #+16]
        CMP      R8,R0
        BNE.N    ??MyProtocolComCheck_11
        LDRB     R0,[SP, #+0]
        CMP      R0,#+42
        BNE.N    ??MyProtocolComCheck_15
        ADDS     R0,R5,#+7
        BL       LocalIPCtrlData
        BL       ResetStart
??MyProtocolComCheck_15:
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        MOVS     R0,#+14
        PUSH     {R0,R1}
        LDR.W    R3,??MyProtocolComCheck_0+0x18  ;; IPAddrInfo
        B.N      ??MyProtocolComCheck_13
??MyProtocolComCheck_8:
        LDR.W    R10,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R10, #+0]
        CMP      R8,R0
        BNE.N    ??MyProtocolComCheck_11
        ADD      R0,SP,#+4
        PUSH     {R0,LR}
        ADD      R3,SP,#+13
        LDRB     R2,[R5, #+9]
        LDRB     R1,[R5, #+8]
        LDRB     R0,[R5, #+7]
        BL       IsItRtnMySysIDtoVAL
        ADD      SP,SP,#+8
        LDRB     R0,[SP, #+4]
        PUSH     {R0,LR}
        LDRB     R3,[SP, #+13]
        MOVS     R2,#+0
        LDRH     R0,[R5, #+1031]
        SUBS     R1,R0,#+3
        UXTH     R1,R1
        ADD      R0,R5,#+10
        BL       AnalyzeAidDataptr
        ADD      SP,SP,#+8
        LDRB     R5,[R4, #+0]
        LDRB     R3,[R6, #+0]
        MOV      R1,R8
        ADD      R0,SP,#+0
        PUSH     {R0,R1}
        MOV      R2,R5
        MOVW     R1,#+269
        MOVW     R8,#+538
        LDR.W    R7,??MyProtocolComCheck_0+0x20  ;; DnrSts
        MLA      R8,R5,R8,R7
        MLA      R1,R3,R1,R8
        ADD      R0,R9,#+7
        BL       GenDnrRstSts
        ADD      SP,SP,#+8
        MOV      R7,R0
        LDRB     R0,[R6, #+0]
        PUSH     {R0,LR}
        LDRB     R3,[R4, #+0]
        ADD      R2,SP,#+10
        ADD      R1,SP,#+11
        ADD      R0,SP,#+9
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
        LDRB     R0,[SP, #+0]
        CMP      R0,#+130
        BNE.N    ??MyProtocolComCheck_16
        MOVS     R0,#+146
        B.N      ??MyProtocolComCheck_17
??MyProtocolComCheck_16:
        CMP      R0,#+128
        BNE.N    ??MyProtocolComCheck_18
        MOVS     R0,#+144
??MyProtocolComCheck_17:
        STRB     R0,[SP, #+0]
??MyProtocolComCheck_18:
        MOVS     R1,#+0
        LDR      R0,[R10, #+0]
        PUSH     {R0,R1}
        MOVS     R1,#+144
??MyProtocolComCheck_19:
        MOV      R0,R7
        PUSH     {R0,R1}
        ADD      R3,R9,#+7
        B.N      ??MyProtocolComCheck_13
??MyProtocolComCheck_7:
        LDRB     R0,[R5, #+7]
        BL       ServerCtrlStart
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        MOVS     R1,#+44
        MOVS     R0,#+1
        PUSH     {R0,R1}
        LDR.W    R0,??MyProtocolComCheck_0+0x24  ;; MySts
        LDR      R0,[R0, #+0]
        ADD      R3,R0,#+268
        B.N      ??MyProtocolComCheck_13
??MyProtocolComCheck_1:
        LDR.W    R7,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDRB     R0,[SP, #+0]
        STRB     R0,[R7, #+2]
        LDRB     R0,[SP, #+0]
        CMP      R0,#+1
        BNE.N    ??MyProtocolComCheck_20
        LDR.W    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_21
        LDR      R0,[R7, #+16]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_21
        LDR.W    R0,??MyProtocolComCheck_0+0x2C  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_21
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
        LDR.N    R0,??MyProtocolComCheck_0+0xC  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCC.W    ??MyProtocolComCheck_11
??MyProtocolComCheck_21:
        LDRB     R3,[SP, #+4]
        LDRB     R2,[SP, #+5]
        MOVS     R1,#+1
        MOV      R0,R8
        BL       AnalyzeAidData
        LDR      R0,[R7, #+16]
        CMP      R8,R0
        BNE.N    ??MyProtocolComCheck_22
        LDR.N    R0,??MyProtocolComCheck_0+0x24  ;; MySts
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+192]
        CBZ      R0,??MyProtocolComCheck_22
??MyProtocolComCheck_23:
        MOV      R2,R8
        LDRB     R0,[R6, #+0]
        MOVW     R1,#+269
        LDRB     R3,[R4, #+0]
        MOVW     R6,#+538
        LDR.N    R7,??MyProtocolComCheck_0+0x20  ;; DnrSts
        MLA      R3,R3,R6,R7
        MLA      R1,R0,R1,R3
        ADDS     R0,R5,#+7
        BL       GenDnrAidSts
        MOV      R7,R0
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        MOV      R0,R7
??MyProtocolComCheck_24:
        PUSH     {R0,R1}
        ADDS     R3,R5,#+7
        B.N      ??MyProtocolComCheck_13
??MyProtocolComCheck_20:
        CMP      R0,#+129
        BNE.W    ??MyProtocolComCheck_11
        LDR.N    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_21
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
        B.N      ??MyProtocolComCheck_21
??MyProtocolComCheck_22:
        LDR.N    R0,??MyProtocolComCheck_0+0xC  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.N    ??MyProtocolComCheck_25
        LDRB     R0,[SP, #+0]
        CMP      R0,#+129
        BNE.N    ??MyProtocolComCheck_26
        MOVS     R0,#+145
        STRB     R0,[SP, #+0]
??MyProtocolComCheck_26:
        LDRB     R0,[R7, #+1]
        CMP      R0,#+0
        BEQ.N    ??MyProtocolComCheck_23
??MyProtocolComCheck_25:
        MOV      R1,R8
        LDR.N    R0,??MyProtocolComCheck_0+0x30  ;; IORUSer
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        MOVS     R1,#+1
        LDRH     R0,[R5, #+1031]
        B.N      ??MyProtocolComCheck_24
??MyProtocolComCheck_2:
        LDRB     R0,[SP, #+0]
        CMP      R0,#+3
        BNE.N    ??MyProtocolComCheck_27
        LDR.N    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_28
        LDR.N    R0,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDR      R0,[R0, #+16]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_28
        LDR.N    R0,??MyProtocolComCheck_0+0x2C  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_28
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
        LDR.N    R0,??MyProtocolComCheck_0+0xC  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCC.W    ??MyProtocolComCheck_11
        B.N      ??MyProtocolComCheck_29
??MyProtocolComCheck_27:
        CMP      R0,#+131
        BNE.W    ??MyProtocolComCheck_11
        LDR.N    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_28
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
??MyProtocolComCheck_28:
        LDR.N    R0,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDR      R0,[R0, #+16]
        CMP      R8,R0
        BNE.N    ??MyProtocolComCheck_29
        LDR.N    R0,??MyProtocolComCheck_0+0x24  ;; MySts
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+192]
        CBNZ     R0,??MyProtocolComCheck_30
??MyProtocolComCheck_29:
        BL       OS_CPU_SR_Save
        MOV      R6,R0
        LDR.N    R7,??MyProtocolComCheck_0+0x10  ;; 0x8006000
        MOV      R0,R7
        BL       RoadBackuptobuffer
        LDRB     R1,[SP, #+4]
        MOVW     R2,#+269
        LDRB     R3,[SP, #+5]
        MOVW     R4,#+538
        LDR.W    LR,??MyProtocolComCheck_0+0x20  ;; DnrSts
        MLA      R3,R3,R4,LR
        MLA      R1,R1,R2,R3
        LDRB     R2,[R5, #+7]
        AND      R2,R2,#0x1
        STRB     R2,[R1, #+190]
        LDRB     R1,[R5, #+7]
        AND      R1,R1,#0x1
        STRB     R1,[R0, #+5]
        MOVS     R1,#+80
        MOV      R0,R7
        BL       WriteBuffertoBackup
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
??MyProtocolComCheck_30:
        LDRB     R0,[SP, #+0]
        CMP      R0,#+131
        BNE.N    ??MyProtocolComCheck_31
        MOVS     R0,#+148
        STRB     R0,[SP, #+0]
??MyProtocolComCheck_31:
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        MOVS     R0,#+1
        PUSH     {R0,R1}
        LDRB     R0,[SP, #+20]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+21]
        MOVW     R3,#+538
        LDR.N    R4,??MyProtocolComCheck_0+0x20  ;; DnrSts
        MLA      R2,R2,R3,R4
        MLA      R0,R0,R1,R2
        ADD      R3,R0,#+190
        B.N      ??MyProtocolComCheck_13
??MyProtocolComCheck_9:
        LDR.N    R7,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDRB     R0,[SP, #+0]
        STRB     R0,[R7, #+2]
        LDRB     R0,[SP, #+0]
        CMP      R0,#+230
        BNE.N    ??MyProtocolComCheck_32
        LDR.N    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_33
        LDR      R0,[R7, #+16]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_33
        LDR.N    R0,??MyProtocolComCheck_0+0x2C  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_33
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
        LDR.N    R0,??MyProtocolComCheck_0+0xC  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCC.W    ??MyProtocolComCheck_11
??MyProtocolComCheck_33:
        LDRH     R2,[R5, #+1031]
        LDRB     R0,[SP, #+1]
        CMP      R0,#+255
        BNE.N    ??MyProtocolComCheck_34
        MOVW     R6,#+269
        MOVW     R7,#+538
        LDR.N    R4,??MyProtocolComCheck_0+0x20  ;; DnrSts
        LDRB     R0,[SP, #+4]
        LDRB     R1,[SP, #+5]
        MLA      R1,R1,R7,R4
        MLA      R0,R0,R6,R1
        ADDS     R0,R0,#+194
        CMP      R2,#+36
        BNE.N    ??MyProtocolComCheck_35
        ADD      R1,R5,#+9
        B.N      ??MyProtocolComCheck_36
??MyProtocolComCheck_32:
        CMP      R0,#+134
        BNE.W    ??MyProtocolComCheck_11
        LDR.N    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_33
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
        B.N      ??MyProtocolComCheck_33
??MyProtocolComCheck_35:
        ADDS     R1,R5,#+7
??MyProtocolComCheck_36:
        BL       Inform_CtrlDataCopy
        LDRB     R0,[SP, #+0]
        CMP      R0,#+134
        BNE.N    ??MyProtocolComCheck_37
        MOVS     R0,#+150
        STRB     R0,[SP, #+0]
??MyProtocolComCheck_37:
        LDRB     R0,[SP, #+4]
        LDRB     R1,[SP, #+5]
        MLA      R1,R1,R7,R4
        MLA      R0,R0,R6,R1
        ADD      R1,R0,#+194
        ADD      R0,R9,#+7
        BL       GenModuleInformSts
        MOV      R7,R0
        MOVS     R1,#+0
        MOV      R0,R8
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        B.N      ??MyProtocolComCheck_19
??MyProtocolComCheck_34:
        MOV      R1,R8
        LDR.N    R0,??MyProtocolComCheck_0+0x30  ;; IORUSer
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        MOVS     R1,#+230
        MOV      R0,R2
        B.N      ??MyProtocolComCheck_24
??MyProtocolComCheck_3:
        LDR.N    R7,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDRB     R0,[SP, #+0]
        STRB     R0,[R7, #+2]
        LDR      R0,[R7, #+16]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_38
        LDR.N    R0,??MyProtocolComCheck_0+0x2C  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_38
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.N    ??MyProtocolComCheck_39
        LDR.N    R0,??MyProtocolComCheck_0+0xC  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.N    ??MyProtocolComCheck_38
??MyProtocolComCheck_39:
        LDR.N    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
??MyProtocolComCheck_38:
        MOV      R0,R8
        BL       WRCS_DownLoadGiveupTimerSet
        LDRB     R0,[SP, #+1]
        CMP      R0,#+255
        BNE.N    ??MyProtocolComCheck_40
??MyProtocolComCheck_41:
        MOV      R0,R8
        BL       WRCS_DownloadFunc
        POP      {R0,R1,R4-R10,PC}
??MyProtocolComCheck_10:
        LDR.N    R0,??MyProtocolComCheck_0+0x8  ;; SerialPadOnFlag
        LDRB     R1,[SP, #+0]
        STRB     R1,[R0, #+2]
        LDR.N    R0,??MyProtocolComCheck_0+0x28  ;; DnrSer1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BEQ.N    ??MyProtocolComCheck_42
        LDR.N    R0,??MyProtocolComCheck_0+0x1C  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R8,R0
        BNE.W    ??MyProtocolComCheck_11
??MyProtocolComCheck_42:
        MOV      R0,R8
        BL       WRCS_DownLoadGiveupTimerSet
        LDRB     R0,[SP, #+1]
        CMP      R0,#+255
        BEQ.N    ??MyProtocolComCheck_41
        LDRB     R0,[SP, #+0]
        CMP      R0,#+139
        BNE.N    ??MyProtocolComCheck_43
        MOVS     R0,#+11
??MyProtocolComCheck_44:
        STRB     R0,[SP, #+0]
??MyProtocolComCheck_40:
        MOV      R1,R8
        LDR.N    R0,??MyProtocolComCheck_0+0x30  ;; IORUSer
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        LDRB     R1,[SP, #+8]
        LDRH     R0,[R5, #+1031]
        PUSH     {R0,R1}
        ADDS     R3,R5,#+7
        B.N      ??MyProtocolComCheck_13
??MyProtocolComCheck_43:
        CMP      R0,#+140
        BNE.N    ??MyProtocolComCheck_45
        MOVS     R0,#+12
        B.N      ??MyProtocolComCheck_44
??MyProtocolComCheck_45:
        CMP      R0,#+142
        BNE.N    ??MyProtocolComCheck_46
        MOVS     R0,#+14
        B.N      ??MyProtocolComCheck_44
??MyProtocolComCheck_46:
        CMP      R0,#+141
        BNE.N    ??MyProtocolComCheck_40
        MOVS     R0,#+13
        B.N      ??MyProtocolComCheck_44
        Nop      
        DATA
??MyProtocolComCheck_0:
        DC32     MyDnrID
        DC32     MyRmtID
        DC32     SerialPadOnFlag
        DC32     SystemTypeInfo
        DC32     0x8006000
        DC32     MacAddrInfo + 6
        DC32     IPAddrInfo
        DC32     Wrcs1
        DC32     DnrSts
        DC32     MySts
        DC32     DnrSer1
        DC32     Wrcs0
        DC32     IORUSer
// 1044 
// 1045 
// 1046 
// 1047 
// 1048 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1049 INT8U ProtocolRvsComCheck(__ProtocolPtr *nPtr)
// 1050 {
ProtocolRvsComCheck:
        PUSH     {R4-R9,R11,LR}
        SUB      SP,SP,#+16
        MOV      R9,R0
// 1051 	INT16U tcnt = 0;
// 1052 	INT16U Comm = WRCS_WhatRxComm(nPtr);
        BL       WRCS_WhatRxComm
        MOV      R6,R0
// 1053 	INT16U RSPSComm;
// 1054 	
// 1055 	__WRCSSIO *Recv = nPtr->WRCSRecv;
// 1056 	__WRCSSIO *Send = nPtr->WRCSSend;
// 1057     __BODYFRAME *rBody = &Recv->BodyFrame[0];
        LDR      R0,[R9, #+32]
        ADD      R7,R0,#+8
// 1058     __BODYFRAME *sBody = &Send->BodyFrame[0];
        LDR      R0,[R9, #+36]
        ADDS     R0,R0,#+8
        STR      R0,[SP, #+8]
// 1059 
// 1060 	INT8U id0 = rBody->SubID[0];
        LDRB     R11,[R7, #+0]
// 1061 	INT8U id1 = rBody->SubID[1];
        LDRB     R8,[R7, #+1]
// 1062 	INT8U id2 = rBody->SubID[2];
        LDRB     R0,[R7, #+2]
        STR      R0,[SP, #+4]
// 1063 	INT8U tmpDnr = 0;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
// 1064 	INT8U tmpRmt = 0;
// 1065 	INT8U IsItMyID = IsItRtnMySysIDtoVAL(id0, id1, id2, &tmpDnr, &tmpRmt);
        ADD      R0,SP,#+1
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        LDR      R2,[SP, #+12]
        UXTB     R2,R2
        MOV      R1,R8
        MOV      R0,R11
        BL       IsItRtnMySysIDtoVAL
        ADD      SP,SP,#+8
        MOV      R4,R0
// 1066 
// 1067 
// 1068 	switch(Comm)
        MOV      R0,R6
        SUBS     R0,R0,#+129
        BEQ.N    ??ProtocolRvsComCheck_0
        SUBS     R0,R0,#+2
        BEQ.N    ??ProtocolRvsComCheck_0
        SUBS     R0,R0,#+3
        BEQ.N    ??ProtocolRvsComCheck_0
        SUBS     R0,R0,#+5
        CMP      R0,#+3
        BLS.N    ??ProtocolRvsComCheck_0
        SUBS     R0,R0,#+6
        BEQ.N    ??ProtocolRvsComCheck_1
        SUBS     R0,R0,#+3
        BEQ.N    ??ProtocolRvsComCheck_1
        SUBS     R0,R0,#+2
        BEQ.N    ??ProtocolRvsComCheck_1
        SUBS     R0,R0,#+5
        CMP      R0,#+3
        BLS.N    ??ProtocolRvsComCheck_1
        B.N      ??ProtocolRvsComCheck_2
// 1069 	{
// 1070 		case RvsDownloadCMDRQST:
// 1071 		case RvsDownloadCMDConfirmRQST:
// 1072         case RvsDownLoadDataRQST:
// 1073        	case RvsDownLoadDataConfirmRQST:
// 1074 		case RvsControlRQST:
// 1075 		case RvsAlarmMaskSetRQST:	
// 1076 		case RvsModuleInformSetRQST:
// 1077 
// 1078 			{
// 1079 				INT32U sptr = WRCS_DownLoadGiveupTimerSet(NULL);
??ProtocolRvsComCheck_0:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
// 1080 
// 1081 				if(SystemTypeInfo < 2)
        LDR.N    R1,??ProtocolRvsComCheck_3  ;; SystemTypeInfo
        LDRB     R1,[R1, #+0]
        CMP      R1,#+2
        BCS.N    ??ProtocolRvsComCheck_4
// 1082 				{	// DONOR CASE
// 1083 					if(sptr && (nPtr == Wrcs1 || nPtr == DnrSer1)) if(sptr != (INT32U)nPtr) return TRUE;
        CBZ      R0,??ProtocolRvsComCheck_5
        LDR.N    R1,??ProtocolRvsComCheck_3+0x4  ;; Wrcs1
        LDR      R1,[R1, #+0]
        CMP      R9,R1
        BEQ.N    ??ProtocolRvsComCheck_6
        LDR.N    R1,??ProtocolRvsComCheck_3+0x8  ;; DnrSer1
        LDR      R1,[R1, #+0]
        CMP      R9,R1
        BNE.N    ??ProtocolRvsComCheck_5
??ProtocolRvsComCheck_6:
        CMP      R0,R9
        BEQ.N    ??ProtocolRvsComCheck_5
??ProtocolRvsComCheck_2:
        MOVS     R0,#+1
        ADD      SP,SP,#+16
        POP      {R4-R9,R11,PC}   ;; return
// 1084 
// 1085 					if(IsItMyID) MyProtocolComCheck(nPtr);
??ProtocolRvsComCheck_5:
        CBZ      R4,??ProtocolRvsComCheck_7
??ProtocolRvsComCheck_8:
        MOV      R0,R9
        BL       MyProtocolComCheck
        B.N      ??ProtocolRvsComCheck_2
// 1086 					else 
// 1087 					{
// 1088 						switch(Comm)
??ProtocolRvsComCheck_7:
        CMP      R6,#+129
        BEQ.N    ??ProtocolRvsComCheck_9
        CMP      R6,#+131
        BEQ.N    ??ProtocolRvsComCheck_9
        CMP      R6,#+134
        BEQ.N    ??ProtocolRvsComCheck_9
// 1089 						{
// 1090 							case RvsControlRQST:
// 1091 							case RvsAlarmMaskSetRQST:
// 1092 							case RvsModuleInformSetRQST:
// 1093 								
// 1094 							break;
// 1095 							
// 1096 							default:
// 1097 								WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
        MOV      R0,R9
        BL       WRCS_DownLoadGiveupTimerSet
??ProtocolRvsComCheck_9:
        LDR.N    R0,??ProtocolRvsComCheck_3+0x4  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R9,R0
        BNE.N    ??ProtocolRvsComCheck_10
        LDRB     R1,[SP, #+0]
        LDR.N    R2,??ProtocolRvsComCheck_3+0xC  ;; MyDnrID
        LDRB     R2,[R2, #+0]
        CMP      R1,R2
        BEQ.N    ??ProtocolRvsComCheck_10
// 1098 							break;
// 1099 						}
// 1100 						if(nPtr == Wrcs1 && (tmpDnr != MyDnrID)) // to Another DONOR Send
// 1101 						{
// 1102 							pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, DnrSer0, nPtr);
        MOV      R1,R9
        LDR.N    R0,??ProtocolRvsComCheck_3+0x10  ;; DnrSer0
        LDR      R0,[R0, #+0]
??ProtocolRvsComCheck_11:
        PUSH     {R0,R1}
        LDRH     R0,[R7, #+1031]
        UXTB     R1,R6
        PUSH     {R0,R1}
        ADDS     R3,R7,#+7
        LDR      R2,[SP, #+20]
        UXTB     R2,R2
        MOV      R1,R8
        MOV      R0,R11
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
        B.N      ??ProtocolRvsComCheck_2
// 1103 						}
// 1104 						else if(nPtr == DnrSer1 && (tmpDnr == MyDnrID && tmpRmt)) // to Remote Send
??ProtocolRvsComCheck_10:
        LDR.N    R1,??ProtocolRvsComCheck_3+0x8  ;; DnrSer1
        LDR      R1,[R1, #+0]
        CMP      R9,R1
        BNE.N    ??ProtocolRvsComCheck_2
        LDRB     R1,[SP, #+0]
        LDR.N    R2,??ProtocolRvsComCheck_3+0xC  ;; MyDnrID
        LDRB     R2,[R2, #+0]
        CMP      R1,R2
        BNE.N    ??ProtocolRvsComCheck_2
        LDRB     R1,[SP, #+1]
        CMP      R1,#+0
        BEQ.N    ??ProtocolRvsComCheck_2
// 1105 						{
// 1106 							pBodyFrameTx(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, Wrcs1, nPtr);
        MOV      R1,R9
        B.N      ??ProtocolRvsComCheck_11
// 1107 						}
// 1108 					}
// 1109 				}
// 1110 				else {
// 1111 					if(IsItMyID) MyProtocolComCheck(nPtr);
??ProtocolRvsComCheck_4:
        CMP      R4,#+0
        BEQ.N    ??ProtocolRvsComCheck_2
        B.N      ??ProtocolRvsComCheck_8
// 1112 					else {
// 1113 						//WRCS_DownloadFunc(nPtr);
// 1114 					}
// 1115 				}
// 1116        		}
// 1117 		break;
// 1118 
// 1119 		case RvsDownloadCMDRSPS:
// 1120 		case RvsDownloadCMDConfirmRSPS:
// 1121         case RvsDownLoadDataRSPS:
// 1122        	case RvsDownLoadDataConfirmRSPS:
// 1123 		case RvsControlRSPS:
// 1124 		case RvsAlarmMaskSetRSPS:
// 1125 		case RvsModuleInformSetRSPS:
// 1126 			{
// 1127 				__ProtocolPtr *dptr = (__ProtocolPtr *)nPtr->ctrlsrc;
??ProtocolRvsComCheck_1:
        LDR      R4,[R9, #+24]
// 1128 				if(dptr == NULL) break;
        CMP      R4,#+0
        BEQ.N    ??ProtocolRvsComCheck_2
// 1129 				if(dptr == SelfSer) break;
        LDR.N    R0,??ProtocolRvsComCheck_3+0x14  ;; SerialPadOnFlag
        LDR      R1,[R0, #+20]
        CMP      R4,R1
        BEQ.N    ??ProtocolRvsComCheck_2
// 1130 
// 1131 				if((__SKProtocolPtr *)dptr == RcsSer)
        LDR.N    R2,??ProtocolRvsComCheck_3+0x18  ;; RcsSer
        LDR      R1,[R2, #+0]
        CMP      R4,R1
        BNE.N    ??ProtocolRvsComCheck_12
// 1132 				{
// 1133 					INT16U i = 0;
// 1134 					
// 1135 					switch(Comm)
        CMP      R6,#+145
        BEQ.N    ??ProtocolRvsComCheck_13
        CMP      R6,#+148
        BEQ.N    ??ProtocolRvsComCheck_14
        CMP      R6,#+155
        BEQ.N    ??ProtocolRvsComCheck_15
        CMP      R6,#+156
        BEQ.N    ??ProtocolRvsComCheck_16
        CMP      R6,#+157
        BEQ.N    ??ProtocolRvsComCheck_17
        CMP      R6,#+158
        BEQ.N    ??ProtocolRvsComCheck_18
        B.N      ??ProtocolRvsComCheck_19
// 1136 					{
// 1137 						case RvsDownloadCMDRSPS:			RSPSComm = RCSDownloadCMD;			break;
??ProtocolRvsComCheck_15:
        MOVS     R5,#+0
        B.N      ??ProtocolRvsComCheck_19
// 1138 						case RvsDownloadCMDConfirmRSPS:		RSPSComm = RCSDownloadCMDConfirm;	break;
??ProtocolRvsComCheck_16:
        MOVS     R5,#+3
        B.N      ??ProtocolRvsComCheck_19
// 1139 						case RvsDownLoadDataRSPS:			RSPSComm = RCSDownLoadData; 		break;
??ProtocolRvsComCheck_17:
        MOVS     R5,#+1
        B.N      ??ProtocolRvsComCheck_19
// 1140 						case RvsDownLoadDataConfirmRSPS:	RSPSComm = RCSDownLoadDataConfirm;	break;
??ProtocolRvsComCheck_18:
        MOVS     R5,#+2
        B.N      ??ProtocolRvsComCheck_19
// 1141 						case RvsControlRSPS:				RSPSComm = RCSControlRSPS;			break;
??ProtocolRvsComCheck_13:
        MOVS     R5,#+129
        B.N      ??ProtocolRvsComCheck_19
// 1142 						case RvsAlarmMaskSetRSPS:			RSPSComm = RCSAlarmMaskSetRSPS;		break;
??ProtocolRvsComCheck_14:
        MOVS     R5,#+131
// 1143 					}
// 1144 
// 1145 					switch(Comm)
??ProtocolRvsComCheck_19:
        SUBS     R0,R6,#+145
        BEQ.N    ??ProtocolRvsComCheck_20
        SUBS     R0,R0,#+10
        CMP      R0,#+3
        BHI.N    ??ProtocolRvsComCheck_21
// 1146 					{
// 1147 						case RvsDownloadCMDRSPS:	
// 1148 						case RvsDownloadCMDConfirmRSPS:
// 1149 						case RvsDownLoadDataRSPS:	
// 1150 						case RvsDownLoadDataConfirmRSPS:
// 1151 							RcsSer->Send->BODYFRAME.SubData[0] = RSPSComm;
        LDR      R0,[R1, #+40]
        STRB     R5,[R0, #+11]
// 1152 
// 1153 							for(i = 0; i < rBody->SubLength; i++)
        MOVS     R0,#+0
        LDRH     R1,[R7, #+1031]
        CBZ      R1,??ProtocolRvsComCheck_22
// 1154 							{
// 1155 								RcsSer->Send->BODYFRAME.SubData[1+i] = rBody->SubData[i];
??ProtocolRvsComCheck_23:
        LDR      R3,[R2, #+0]
        LDR      R3,[R3, #+40]
        ADDS     R3,R0,R3
        ADDS     R1,R0,R7
        LDRB     R1,[R1, #+7]
        STRB     R1,[R3, #+12]
// 1156 							}
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRH     R3,[R7, #+1031]
        CMP      R0,R3
        BCC.N    ??ProtocolRvsComCheck_23
// 1157 							RCSDataAckTx(id0, id1, (INT8U *)RcsSer->Send->BODYFRAME.SubData, rBody->SubLength + 1, MyPortID, RcsDownloadRSPS);
??ProtocolRvsComCheck_22:
        MOVS     R1,#+160
        LDR.N    R0,??ProtocolRvsComCheck_3+0x1C  ;; MyPortID
        LDRB     R0,[R0, #+0]
        PUSH     {R0,R1}
        LDRH     R0,[R7, #+1031]
        ADDS     R3,R0,#+1
        UXTB     R3,R3
        LDR      R0,[R2, #+0]
        LDR      R0,[R0, #+40]
        ADD      R2,R0,#+11
??ProtocolRvsComCheck_24:
        MOV      R1,R8
        MOV      R0,R11
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
        B.N      ??ProtocolRvsComCheck_2
// 1158 						break;
// 1159 
// 1160 						case RvsControlRSPS:
// 1161 
// 1162 							AnalyzeAidData(nPtr, FALSE, tmpDnr, tmpRmt);
??ProtocolRvsComCheck_20:
        LDRB     R3,[SP, #+1]
        LDRB     R2,[SP, #+0]
        MOVS     R1,#+0
        MOV      R0,R9
        BL       AnalyzeAidData
// 1163 							tcnt = RCSGenAidSts(sBody->SubData, &DnrSts[tmpDnr][tmpRmt]);
        LDRB     R0,[SP, #+1]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+0]
        MOVW     R3,#+538
        LDR.N    R4,??ProtocolRvsComCheck_3+0x20  ;; DnrSts
        MLA      R2,R2,R3,R4
        MLA      R1,R0,R1,R2
        LDR      R0,[SP, #+8]
        ADDS     R0,R0,#+7
        BL       RCSGenAidSts
        MOV      R3,R0
// 1164 							RCSDataAckTx(id0, id1, (INT8U *)sBody->SubData, tcnt, MyPortID, RSPSComm);
        LDR.N    R0,??ProtocolRvsComCheck_3+0x1C  ;; MyPortID
        LDRB     R0,[R0, #+0]
        UXTB     R1,R5
        PUSH     {R0,R1}
        UXTB     R3,R3
        LDR      R0,[SP, #+16]
        ADDS     R2,R0,#+7
        B.N      ??ProtocolRvsComCheck_24
// 1165 						break;
// 1166 
// 1167 						default:
// 1168 							RCSDataAckTx(id0, id1, (INT8U *)rBody->SubData, rBody->SubLength, MyPortID, RSPSComm);
??ProtocolRvsComCheck_21:
        LDR.N    R0,??ProtocolRvsComCheck_3+0x1C  ;; MyPortID
        LDRB     R0,[R0, #+0]
        UXTB     R1,R5
        PUSH     {R0,R1}
        LDRH     R3,[R7, #+1031]
        UXTB     R3,R3
        ADDS     R2,R7,#+7
        B.N      ??ProtocolRvsComCheck_24
// 1169 						break;
// 1170 					}
// 1171 				}
// 1172 				else
// 1173 				{
// 1174 					if(dptr == PcSer || dptr == Wrcs0)
??ProtocolRvsComCheck_12:
        LDR      R0,[R0, #+16]
        CMP      R4,R0
        BEQ.N    ??ProtocolRvsComCheck_25
        LDR.N    R0,??ProtocolRvsComCheck_3+0x24  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??ProtocolRvsComCheck_26
// 1175 					{
// 1176 						switch(Comm)
??ProtocolRvsComCheck_25:
        CMP      R6,#+145
        BEQ.N    ??ProtocolRvsComCheck_27
        CMP      R6,#+148
        BEQ.N    ??ProtocolRvsComCheck_28
        CMP      R6,#+150
        BEQ.N    ??ProtocolRvsComCheck_29
        CMP      R6,#+155
        BEQ.N    ??ProtocolRvsComCheck_30
        CMP      R6,#+156
        BEQ.N    ??ProtocolRvsComCheck_31
        CMP      R6,#+157
        BEQ.N    ??ProtocolRvsComCheck_32
        CMP      R6,#+158
        BEQ.N    ??ProtocolRvsComCheck_33
        B.N      ??ProtocolRvsComCheck_34
// 1177 						{
// 1178 							case RvsDownloadCMDRSPS:			Comm = DownloadCMD;				break;
??ProtocolRvsComCheck_30:
        MOVS     R6,#+11
        B.N      ??ProtocolRvsComCheck_34
// 1179 							case RvsDownloadCMDConfirmRSPS: 	Comm = DownloadCMDConfirm;		break;
??ProtocolRvsComCheck_31:
        MOVS     R6,#+12
        B.N      ??ProtocolRvsComCheck_34
// 1180 							case RvsDownLoadDataRSPS:			Comm = DownLoadData;	 		break;
??ProtocolRvsComCheck_32:
        MOVS     R6,#+13
        B.N      ??ProtocolRvsComCheck_34
// 1181 							case RvsDownLoadDataConfirmRSPS:	Comm = DownLoadDataConfirm;		break;
??ProtocolRvsComCheck_33:
        MOVS     R6,#+14
        B.N      ??ProtocolRvsComCheck_34
// 1182 							case RvsControlRSPS:
// 1183 								Comm = ControlQue;				
??ProtocolRvsComCheck_27:
        MOVS     R6,#+1
// 1184 								AnalyzeAidData(nPtr, FALSE, tmpDnr, tmpRmt);
??ProtocolRvsComCheck_35:
        LDRB     R3,[SP, #+1]
        LDRB     R2,[SP, #+0]
        MOVS     R1,#+0
        MOV      R0,R9
        BL       AnalyzeAidData
        B.N      ??ProtocolRvsComCheck_34
// 1185 							break;
// 1186 							case RvsAlarmMaskSetRSPS:
// 1187 								Comm = AlarmMaskSetQue;
??ProtocolRvsComCheck_28:
        MOVS     R6,#+3
// 1188 								DnrSts[tmpDnr][tmpRmt].AlarmMask = rBody->SubData[0];
        B.N      ??ProtocolRvsComCheck_36
// 1189 							break;
// 1190 
// 1191 							case RvsModuleInformSetRSPS:
// 1192 								Comm = ModuleInformSetQue;
??ProtocolRvsComCheck_29:
        MOVS     R6,#+230
        B.N      ??ProtocolRvsComCheck_34
// 1193 							break;
// 1194 						}
// 1195 					}
// 1196 					else
// 1197 					{
// 1198 						switch(Comm)
??ProtocolRvsComCheck_26:
        CMP      R6,#+145
        BEQ.N    ??ProtocolRvsComCheck_35
        CMP      R6,#+148
        BNE.N    ??ProtocolRvsComCheck_34
// 1199 						{
// 1200 							case RvsControlRSPS:
// 1201 								AnalyzeAidData(nPtr, FALSE, tmpDnr, tmpRmt);
// 1202 							break;
// 1203 							case RvsAlarmMaskSetRSPS:
// 1204 								DnrSts[tmpDnr][tmpRmt].AlarmMask = rBody->SubData[0];
??ProtocolRvsComCheck_36:
        LDRB     R0,[SP, #+1]
        MOVW     R1,#+269
        LDRB     R2,[SP, #+0]
        MOVW     R3,#+538
        LDR.N    R5,??ProtocolRvsComCheck_3+0x20  ;; DnrSts
        MLA      R2,R2,R3,R5
        MLA      R0,R0,R1,R2
        LDRB     R1,[R7, #+7]
        STRB     R1,[R0, #+190]
// 1205 							break;
// 1206 							
// 1207 							case RvsModuleInformSetRSPS:								
// 1208 							break;
// 1209 						}
// 1210 					}
// 1211 					pBodyFrameTx(id0, id1, id2, rBody->SubData, rBody->SubLength, Comm, dptr, NULL);
??ProtocolRvsComCheck_34:
        MOVS     R1,#+0
        MOV      R0,R4
        B.N      ??ProtocolRvsComCheck_11
        DATA
??ProtocolRvsComCheck_3:
        DC32     SystemTypeInfo
        DC32     Wrcs1
        DC32     DnrSer1
        DC32     MyDnrID
        DC32     DnrSer0
        DC32     SerialPadOnFlag
        DC32     RcsSer
        DC32     MyPortID
        DC32     DnrSts
        DC32     Wrcs0
// 1212 				}
// 1213 			}
// 1214 		default:
// 1215 		break;
// 1216 	}
// 1217     return TRUE;
// 1218 }
// 1219 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1220 void pBodyFrameTx(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U nCnt, INT8U Comm,
// 1221 											__ProtocolPtr *toPtr,  __ProtocolPtr *fromPtr)
// 1222 {
pBodyFrameTx:
        PUSH     {R3-R11,LR}
        MOV      R10,R0
        MOV      R9,R1
        MOV      R8,R2
        MOV      R11,R3
        LDR      R4,[SP, #+40]
        LDR      R5,[SP, #+44]
        LDR      R7,[SP, #+48]
        LDR      R6,[SP, #+52]
// 1223 	//sPtr: from source ptr,
// 1224 	//nPtr: where to!!
// 1225 	INT8U err = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
// 1226 		
// 1227 	OSSemPend(toPtr->OSSem, 0, &err);
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R7, #+28]
        BL       OSSemPend
// 1228 	
// 1229 	if(fromPtr) toPtr->ctrlsrc = (INT32U)fromPtr;
        CBZ      R6,??pBodyFrameTx_0
        STR      R6,[R7, #+24]
// 1230 
// 1231 	GenBodyFrameTx(id0, id1, id2, Data, nCnt, MyRCode, Comm, toPtr);
??pBodyFrameTx_0:
        MOVS     R0,#+0
        PUSH     {R0,LR}
        MOV      R1,R7
        MOV      R0,R5
        PUSH     {R0,R1}
        LDR.N    R0,??pBodyFrameTx_1  ;; MyRCode
        LDRB     R1,[R0, #+0]
        UXTH     R0,R4
        PUSH     {R0,R1}
        MOV      R3,R11
        MOV      R2,R8
        MOV      R1,R9
        MOV      R0,R10
        BL       GenBodyFrame
        ADD      SP,SP,#+24
        MOV      R0,R7
        BL       WRCS_ProDataAckTx
// 1232 
// 1233 	OSSemPost(toPtr->OSSem);
        LDR      R0,[R7, #+28]
        BL       OSSemPost
// 1234 
// 1235 	if     (toPtr == Wrcs1 && (SystemTypeInfo < 2)) 	RmtLinkFailCheck();
        LDR.N    R0,??pBodyFrameTx_1+0x4  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R7,R0
        BNE.N    ??pBodyFrameTx_2
        LDR.N    R0,??pBodyFrameTx_1+0x8  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.N    ??pBodyFrameTx_2
        BL       RmtLinkFailCheck
        POP      {R0,R4-R11,PC}
// 1236 	else if(toPtr == IORUSer){
??pBodyFrameTx_2:
        LDR.N    R0,??pBodyFrameTx_1+0xC  ;; IORUSer
        LDR      R0,[R0, #+0]
        CMP      R7,R0
        BNE.N    ??pBodyFrameTx_3
// 1237 		IORULinkFailCheck();
        BL       IORULinkFailCheck
// 1238 		IORUTxLED(SET);
        MOVS     R0,#+1
        BL       IORUTxLED
        POP      {R0,R4-R11,PC}
// 1239 	}
// 1240 	else if(toPtr == DnrSer0)	DnrLinkFailCheck();
??pBodyFrameTx_3:
        LDR.N    R0,??pBodyFrameTx_1+0x10  ;; DnrSer0
        LDR      R0,[R0, #+0]
        CMP      R7,R0
        BNE.N    ??pBodyFrameTx_4
        BL       DnrLinkFailCheck
// 1241 		
// 1242 }
??pBodyFrameTx_4:
        POP      {R0,R4-R11,PC}   ;; return
        Nop      
        DATA
??pBodyFrameTx_1:
        DC32     MyRCode
        DC32     Wrcs1
        DC32     SystemTypeInfo
        DC32     IORUSer
        DC32     DnrSer0
// 1243 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1244 void GenBodyFrameTx(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U nCnt, INT8U RCode,
// 1245 					INT8U Comm, __ProtocolPtr *nPtr)
// 1246 {
GenBodyFrameTx:
        PUSH     {R3-R7,LR}
        MOV      R7,R0
        MOV      R12,R1
        LDR      R5,[SP, #+24]
        LDR      R4,[SP, #+28]
        LDR      R0,[SP, #+32]
        LDR      R6,[SP, #+36]
// 1247 
// 1248 	GenBodyFrame(id0, id1, id2, Data, nCnt, RCode, Comm, nPtr, 0);
        MOVS     R1,#+0
        PUSH     {R1,LR}
        MOV      R1,R6
        PUSH     {R0,R1}
        MOV      R1,R4
        UXTH     R0,R5
        PUSH     {R0,R1}
        MOV      R1,R12
        MOV      R0,R7
        BL       GenBodyFrame
        ADD      SP,SP,#+24
// 1249 	WRCS_ProDataAckTx(nPtr);
        MOV      R0,R6
        POP      {R1,R4-R7,LR}
        B.N      WRCS_ProDataAckTx
// 1250 }
// 1251 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1252 void GenBodyFrame(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U nCnt, INT8U RCode,
// 1253 					INT8U Comm, __ProtocolPtr *nPtr, INT8U BodyNo)
// 1254 {
GenBodyFrame:
        PUSH     {R3-R7,LR}
        LDR      R6,[SP, #+24]
        LDR      R12,[SP, #+28]
        LDR      R7,[SP, #+32]
        LDR      R5,[SP, #+36]
// 1255 	int i = 0;
// 1256 	int DataCnt = 0;
        MOVS     R4,#+0
// 1257 	
// 1258 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      LR,[R5, #+36]
// 1259 	
// 1260 #if TWO_BODY >= 2
// 1261 	__BODYFRAME *BodyFrame = &(Send->BodyFrame[BodyNo]);
// 1262 #else
// 1263 	__BODYFRAME *BodyFrame = &(Send->BodyFrame[0]);
        ADD      R5,LR,#+8
// 1264 	BodyNo = 0;
// 1265 #endif
// 1266 
// 1267 	Send->BodyNo = BodyNo;
        STRB     R4,[LR, #+1046]
// 1268 
// 1269 	BodyFrame->SubID[0] = id0;
        STRB     R0,[R5, #+0]
// 1270 	BodyFrame->SubID[1] = id1;
        STRB     R1,[R5, #+1]
// 1271 	BodyFrame->SubID[2] = id2;
        STRB     R2,[R5, #+2]
// 1272 
// 1273 	BodyFrame->Command = Comm;
        STRB     R7,[R5, #+3]
// 1274 	BodyFrame->RCode = RCode;
        STRB     R12,[R5, #+4]
// 1275 
// 1276 	BodyFrame->SubLength = nCnt;
        STRH     R6,[R5, #+1031]
// 1277 	BodyFrame->SubLen[0] = (INT8U)((nCnt) >> 8);
        UXTH     R6,R6
        LSRS     R0,R6,#+8
        STRB     R0,[R5, #+5]
// 1278 	BodyFrame->SubLen[1] = (INT8U)((nCnt) >> 0);
        STRB     R6,[R5, #+6]
// 1279 
// 1280 	for(i = 0 ; i < nCnt && i < BODYSIZEMAX; i++)
        MOVS     R0,#+0
        MOV      R1,R5
        B.N      ??GenBodyFrame_0
// 1281 	{
// 1282 		BodyFrame->SubData[DataCnt++] = Data[i];
??GenBodyFrame_1:
        LDRB     R2,[R3], #+1
        STRB     R2,[R1, #+7]
        ADDS     R4,R4,#+1
// 1283 	}
        ADDS     R0,R0,#+1
        ADDS     R1,R1,#+1
??GenBodyFrame_0:
        CMP      R0,R6
        BGE.N    ??GenBodyFrame_2
        CMP      R0,#+1024
        BLT.N    ??GenBodyFrame_1
// 1284 
// 1285 	///////////// CRC //
// 1286 	{
// 1287 		BodyFrame->Crc = Crc16Calc ((INT8U *)BodyFrame->SubID, 7 + i, NULL);
??GenBodyFrame_2:
        ADDW     R6,R5,#+1031
        MOVS     R2,#+0
        ADDS     R1,R0,#+7
        MOV      R0,R5
        BL       Crc16Calc
        STRH     R0,[R6, #+2]
// 1288 		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc >> 8);
        ADDS     R0,R4,R5
        LDRH     R1,[R6, #+2]
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+7]
        ADDS     R0,R4,#+1
// 1289 		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc		);
        ADDS     R1,R0,R5
        LDRH     R2,[R6, #+2]
        STRB     R2,[R1, #+7]
// 1290 	}
// 1291 	BodyFrame->SubData[DataCnt++] = ETX;
        ADDS     R0,R0,R5
        MOVS     R1,#+3
        STRB     R1,[R0, #+8]
// 1292 }
        POP      {R0,R4-R7,PC}    ;; return
// 1293 
// 1294 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1295 void WRCS_ProDataAckTx(__ProtocolPtr *nPtr)
// 1296 {
WRCS_ProDataAckTx:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
// 1297 	INT16U i, Len = 0;
// 1298 
// 1299 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R5,[R4, #+36]
// 1300 #if TWO_BODY >= 2
// 1301 	INT8U BodyNo = Send->BodyNo;
// 1302 #else
// 1303 	INT8U BodyNo = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
// 1304 #endif
// 1305 	Send->Sync[0] = STX;
        MOVS     R0,#+22
        STRB     R0,[R5, #+0]
// 1306 	Send->Sync[1] = STX;
        STRB     R0,[R5, #+1]
// 1307 	Send->Sync[2] = STX;
        STRB     R0,[R5, #+2]
// 1308 	Send->Sync[3] = STX;
        STRB     R0,[R5, #+3]
// 1309 
// 1310 	Send->TryNo= '0';
        MOVS     R0,#+48
        STRB     R0,[R5, #+4]
// 1311 
// 1312 	Send->BodyLength = 0;
        MOVS     R0,#+0
        STRH     R0,[R5, #+1044]
// 1313 
// 1314 
// 1315 	for(i = 0; i <= BodyNo; i++)
        MOV      R0,R5
        LDRB     R1,[SP, #+0]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
// 1316 	{
// 1317 		Len = ((Send->BodyFrame[i].SubLen[0] << 8) | Send->BodyFrame[i].SubLen[1]) + 5 + 2 + 2;
// 1318 		Send->BodyLength += Len;
??WRCS_ProDataAckTx_0:
        LDRH     R2,[R5, #+1044]
        LDRB     R3,[R0, #+13]
        LDRB     R6,[R0, #+14]
        ORR      R3,R6,R3, LSL #+8
        ADDS     R3,R3,#+9
        ADDS     R2,R3,R2
        STRH     R2,[R5, #+1044]
// 1319 	}
        ADDW     R0,R0,#+1036
        SUBS     R1,R1,#+1
        BNE.N    ??WRCS_ProDataAckTx_0
// 1320 	Send->BodyLen[0] = (INT8U)(Send->BodyLength >> 8);
        LDRH     R0,[R5, #+1044]
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+5]
// 1321 	Send->BodyLen[1] = (INT8U)(Send->BodyLength >> 0);
        LDRH     R0,[R5, #+1044]
        STRB     R0,[R5, #+6]
// 1322 
// 1323 	Send->CheckSum = Send->TryNo + Send->BodyLen[0] + Send->BodyLen[1];
        LDRB     R0,[R5, #+4]
        LDRB     R1,[R5, #+5]
        ADDS     R0,R1,R0
        LDRB     R1,[R5, #+6]
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+7]
// 1324 
// 1325 
// 1326 	if(nPtr == Wrcs0 || nPtr == Wrcs1)
        LDR.N    R0,??WRCS_ProDataAckTx_1  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BEQ.N    ??WRCS_ProDataAckTx_2
        LDR.N    R0,??WRCS_ProDataAckTx_1+0x4  ;; Wrcs1
        LDR      R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??WRCS_ProDataAckTx_3
// 1327 	{
// 1328 		nPtr->PutStr((INT8U *)Send, (4 + 1 + 2 + 1) + Send->BodyFrame[0].SubLength + 7 + 2 + 1, FALSE);
??WRCS_ProDataAckTx_2:
        MOVS     R2,#+0
        LDRH     R0,[R5, #+1039]
        ADD      R1,R0,#+18
        UXTH     R1,R1
        MOV      R0,R5
        LDR      R3,[R4, #+8]
        BLX      R3
        POP      {R0,R1,R4-R6,PC}
// 1329 
// 1330 		// DEBUG
// 1331 		#ifdef WRCS_DBG
// 1332 		if(nPtr == Wrcs0)
// 1333 		{
// 1334 			PcSer->PutStr((INT8U *)Send, (4 + 1 + 2 + 1) + Send->BodyFrame[0].SubLength + 7 + 2 + 1, TRUE);
// 1335 		}
// 1336 		#endif
// 1337 	}
// 1338 	else
// 1339 	{
// 1340 	
// 1341 		nPtr->PutStr((INT8U *)Send, 4 + 1 + 2 + 1, FALSE);
??WRCS_ProDataAckTx_3:
        MOVS     R2,#+0
        MOVS     R1,#+8
        MOV      R0,R5
        LDR      R3,[R4, #+8]
        BLX      R3
// 1342 
// 1343 		for(i = 0; i <= BodyNo; i++)
        MOVS     R6,#+0
        B.N      ??WRCS_ProDataAckTx_4
// 1344 		{
// 1345 			nPtr->PutStr((INT8U *)&Send->BodyFrame[i], Send->BodyFrame[i].SubLength + 7 + 2, FALSE);
??WRCS_ProDataAckTx_5:
        MOV      R0,R6
        MOVW     R1,#+1036
        MLA      R0,R0,R1,R5
        MOVS     R2,#+0
        LDRH     R1,[R0, #+1039]
        ADDS     R1,R1,#+9
        UXTH     R1,R1
        ADDS     R0,R0,#+8
        LDR      R3,[R4, #+8]
        BLX      R3
// 1346 		}		
        ADDS     R6,R6,#+1
        UXTH     R6,R6
??WRCS_ProDataAckTx_4:
        LDRB     R0,[SP, #+0]
        CMP      R0,R6
        BCS.N    ??WRCS_ProDataAckTx_5
// 1347 
// 1348 		BodyNo = ETX;
        MOVS     R0,#+3
        STRB     R0,[SP, #+0]
// 1349 		nPtr->PutStr((INT8U *)&BodyNo, 1, TRUE);		
        MOVS     R2,#+1
        MOVS     R1,#+1
        ADD      R0,SP,#+0
        LDR      R3,[R4, #+8]
        BLX      R3
// 1350 	}
// 1351 }
        POP      {R0,R1,R4-R6,PC}  ;; return
        DATA
??WRCS_ProDataAckTx_1:
        DC32     Wrcs0
        DC32     Wrcs1
// 1352 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1353 INT16U GenAidData(INT16U Aid, INT8U *dptr, INT8U *sptr, INT16U len)
// 1354 {
GenAidData:
        PUSH     {R4,R5}
// 1355 	INT8U i = 0;
// 1356 	INT8U rval = 0;
// 1357 
// 1358 	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
        LSRS     R4,R0,#+8
        STRB     R4,[R1, #+0]
// 1359 	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
        STRB     R0,[R1, #+1]
// 1360 	dptr[rval++] = len;
        STRB     R3,[R1, #+2]
        MOVS     R0,#+3
// 1361 	for(i = 0; i < len; i++) dptr[rval++] = sptr[i];
        MOVS     R4,#+0
        ADDS     R1,R1,#+3
        B.N      ??GenAidData_0
??GenAidData_1:
        LDRB     R5,[R4, R2]
        STRB     R5,[R1], #+1
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R4,R4,#+1
        UXTB     R4,R4
??GenAidData_0:
        CMP      R4,R3
        BCC.N    ??GenAidData_1
// 1362 
// 1363 	return rval;
        POP      {R4,R5}
        BX       LR               ;; return
// 1364 }
// 1365 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1366 INT8U IsItRtnMySysIDtoVAL(INT8U id0, INT8U id1, INT8U id2, INT8U *tmpDnr, INT8U *tmpRmt)
// 1367 {
IsItRtnMySysIDtoVAL:
        LDR      R0,[SP, #+0]
// 1368 
// 1369 
// 1370 	// COT 1
// 1371 	     if(/*id0 == 0x00 && */id1 == 0x0f && id2 == 0xff){*tmpDnr = 0x00; *tmpRmt = 0x00;}
        CMP      R1,#+15
        BNE.N    ??IsItRtnMySysIDtoVAL_0
        CMP      R2,#+255
        BNE.N    ??IsItRtnMySysIDtoVAL_1
        MOVS     R1,#+0
        B.N      ??IsItRtnMySysIDtoVAL_2
// 1372 	else if(/*id0 == 0x00 && */id1 == 0x00 && id2 == 0xff){*tmpDnr = 0x00; *tmpRmt = 0x01;}
??IsItRtnMySysIDtoVAL_0:
        CBNZ     R1,??IsItRtnMySysIDtoVAL_3
        CMP      R2,#+255
        BNE.N    ??IsItRtnMySysIDtoVAL_1
        MOVS     R2,#+1
        B.N      ??IsItRtnMySysIDtoVAL_4
// 1373 	else if(/*id0 == 0x00 && */id1 == 0x1f && id2 == 0xff){*tmpDnr = 0x01; *tmpRmt = 0x00;}
??IsItRtnMySysIDtoVAL_3:
        CMP      R1,#+31
        BNE.N    ??IsItRtnMySysIDtoVAL_1
        CMP      R2,#+255
        BNE.N    ??IsItRtnMySysIDtoVAL_1
        MOVS     R1,#+1
        MOVS     R2,#+0
        B.N      ??IsItRtnMySysIDtoVAL_4
// 1374 	else// if(id0 == 0x00 && id1 == 0x10 && id2 == 0xff)
// 1375 		{*tmpDnr = 0x01; *tmpRmt = 0x01;}
??IsItRtnMySysIDtoVAL_1:
        MOVS     R1,#+1
??IsItRtnMySysIDtoVAL_2:
        MOV      R2,R1
??IsItRtnMySysIDtoVAL_4:
        STRB     R1,[R3, #+0]
        STRB     R2,[R0, #+0]
// 1376 	
// 1377 	if( *tmpDnr == MyDnrID && *tmpRmt == MyRmtID) return TRUE;
        LDRB     R1,[R3, #+0]
        LDR.N    R2,??IsItRtnMySysIDtoVAL_5  ;; MyDnrID
        LDRB     R2,[R2, #+0]
        CMP      R1,R2
        BNE.N    ??IsItRtnMySysIDtoVAL_6
        LDRB     R0,[R0, #+0]
        LDR.N    R1,??IsItRtnMySysIDtoVAL_5+0x4  ;; MyRmtID
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??IsItRtnMySysIDtoVAL_6
        MOVS     R0,#+1
        BX       LR
// 1378 		
// 1379 	return FALSE;
??IsItRtnMySysIDtoVAL_6:
        MOVS     R0,#+0
        BX       LR               ;; return
        Nop      
        DATA
??IsItRtnMySysIDtoVAL_5:
        DC32     MyDnrID
        DC32     MyRmtID
// 1380 }
// 1381 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1382 INT8U IsItRtnMyVALtoSysID(INT8U *id0, INT8U *id1, INT8U *id2, INT8U tmpDnr, INT8U tmpRmt)
// 1383 {
IsItRtnMyVALtoSysID:
        PUSH     {R4,R5}
        MOV      R4,R3
        LDR      R3,[SP, #+8]
// 1384 	     if(tmpDnr == 0x00 && tmpRmt == 0x00) {*id0 = 0x00; *id1 = 0x0f; *id2 = 0xff;}
        ORRS     R5,R3,R4
        BNE.N    ??IsItRtnMyVALtoSysID_0
        MOVS     R5,#+0
        STRB     R5,[R0, #+0]
        MOVS     R0,#+15
        B.N      ??IsItRtnMyVALtoSysID_1
// 1385 	else if(tmpDnr == 0x00 && tmpRmt == 0x01) {*id0 = 0x00; *id1 = 0x00; *id2 = 0xff;}
??IsItRtnMyVALtoSysID_0:
        CBNZ     R4,??IsItRtnMyVALtoSysID_2
        CMP      R3,#+1
        BNE.N    ??IsItRtnMyVALtoSysID_3
        MOVS     R5,#+0
        STRB     R5,[R0, #+0]
        MOVS     R0,#+0
        B.N      ??IsItRtnMyVALtoSysID_1
// 1386 	else if(tmpDnr == 0x01 && tmpRmt == 0x00) {*id0 = 0x00; *id1 = 0x1f; *id2 = 0xff;}
??IsItRtnMyVALtoSysID_2:
        CMP      R4,#+1
        BNE.N    ??IsItRtnMyVALtoSysID_3
        CBNZ     R3,??IsItRtnMyVALtoSysID_3
        MOVS     R5,#+0
        STRB     R5,[R0, #+0]
        MOVS     R0,#+31
        B.N      ??IsItRtnMyVALtoSysID_1
// 1387 	else// if(tmpDnr == 0x01 && tmpRmt == 0x01)
// 1388 		{*id0 = 0x00; *id1 = 0x10; *id2 = 0xff;}
??IsItRtnMyVALtoSysID_3:
        MOVS     R5,#+0
        STRB     R5,[R0, #+0]
        MOVS     R0,#+16
??IsItRtnMyVALtoSysID_1:
        STRB     R0,[R1, #+0]
        MOVS     R0,#+255
        STRB     R0,[R2, #+0]
// 1389 
// 1390 	if( tmpDnr == MyDnrID && tmpRmt == MyRmtID) return TRUE;
        LDR.N    R0,??IsItRtnMyVALtoSysID_4  ;; MyDnrID
        LDRB     R0,[R0, #+0]
        CMP      R4,R0
        BNE.N    ??IsItRtnMyVALtoSysID_5
        LDR.N    R0,??IsItRtnMyVALtoSysID_4+0x4  ;; MyRmtID
        LDRB     R0,[R0, #+0]
        CMP      R3,R0
        BNE.N    ??IsItRtnMyVALtoSysID_5
        MOVS     R0,#+1
        POP      {R4,R5}
        BX       LR
// 1391 
// 1392 	return FALSE;
??IsItRtnMyVALtoSysID_5:
        MOVS     R0,#+0
        POP      {R4,R5}
        BX       LR               ;; return
        DATA
??IsItRtnMyVALtoSysID_4:
        DC32     MyDnrID
        DC32     MyRmtID
// 1393 }
// 1394 
// 1395 
// 1396 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1397 INT8U IsItMySysValtoID(INT8U tmpDnr, INT8U tmpRmt)
// 1398 {
// 1399 	if((tmpRmt*2 + tmpDnr) == SystemTypeInfo) return TRUE;  
IsItMySysValtoID:
        ADD      R0,R0,R1, LSL #+1
        LDR.N    R1,??IsItMySysValtoID_0  ;; SystemTypeInfo
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??IsItMySysValtoID_1
        MOVS     R0,#+1
        BX       LR
// 1400 	
// 1401 	return FALSE;
??IsItMySysValtoID_1:
        MOVS     R0,#+0
        BX       LR               ;; return
        DATA
??IsItMySysValtoID_0:
        DC32     SystemTypeInfo
// 1402 }
// 1403 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1404 INT8U ReturnDnrRmtID(INT8U SysID, INT8U *tmpDnr, INT8U *tmpRmt)
// 1405 {
// 1406 	*tmpDnr = SysID%2;
ReturnDnrRmtID:
        LSRS     R3,R0,#+1
        SUB      R0,R0,R3, LSL #+1
        STRB     R0,[R1, #+0]
// 1407 	*tmpRmt = (SysID/2) & 0x01;
        AND      R0,R3,#0x1
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
// 1408   
// 1409     return 0;
// 1410 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        STRB     R0,[R2, #+0]
        MOVS     R0,#+0
        BX       LR               ;; return
// 1411 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1412 INT8U ReturnPollingID(INT8U SysID, INT8U *tmpDnr, INT8U *tmpRmt)
// 1413 {
// 1414 	*tmpDnr = SysID%2;
ReturnPollingID:
        LSRS     R3,R0,#+1
        SUB      R3,R0,R3, LSL #+1
        STRB     R3,[R1, #+0]
// 1415 	*tmpRmt = (SysID/2) & 0x01;
// 1416 
// 1417 	if(!(*tmpRmt))  *tmpRmt = 0xFF;
        TST      R0,#0x2
        ITE      EQ 
        MOVEQ    R0,#+255
        MOVNE    R0,#+0
// 1418 	else		    *tmpRmt = 0x00;
        B.N      ?Subroutine0
// 1419   
// 1420     return 0;
// 1421 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant {0}>`:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "rambackup = %d\012"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "CRC Error\\n">`:
        DATA
        DC8 "CRC Error\012"
        DC8 0
        DC8 "ETX error = %d"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant " id0 = %02x \\n">`:
        DATA
        DC8 " id0 = %02x \012"
        DC8 0, 0
        DC8 " id1 = %02x \012"
        DC8 0, 0
        DC8 " id2 = %02x \012"
        DC8 0, 0
        DC8 " Comm = %02x \012"
        DC8 0

        END
// 1422 
// 1423 
// 1424 ////////////////////////////////////////////////////////////////////////////////
// 1425 // End of Source File
// 1426 /////////////////////
// 1427 
// 
//   351 bytes in section .bss
// 3 160 bytes in section .data
//   120 bytes in section .rodata
// 7 288 bytes in section .text
// 
// 7 288 bytes of CODE  memory
//   120 bytes of CONST memory
// 3 511 bytes of DATA  memory
//
//Errors: none
//Warnings: none
