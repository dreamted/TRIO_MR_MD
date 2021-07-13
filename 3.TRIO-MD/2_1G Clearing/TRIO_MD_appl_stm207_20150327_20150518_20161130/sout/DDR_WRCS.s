///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Nov/2010  11:19:06 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\WRCS\ /
//                    DDR_WRCS.c                                              /
//    Command line =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\WRCS\ /
//                    DDR_WRCS.c -lcN C:\user\project\HK-DEI\fw\appl_rcub_201 /
//                    01101\sout\ -lB C:\user\project\HK-DEI\fw\appl_rcub_201 /
//                    01101\sout\ -o C:\user\project\HK-DEI\fw\appl_rcub_2010 /
//                    1101\sout\ --endian=little --cpu=Cortex-M3 -e           /
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
//    List file    =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\sout\DDR_W /
//                    RCS.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME DDR_WRCS

        EXTERN AnalyzeAidData
        EXTERN Crc16Calc
        EXTERN DownLoadBootingJump
        EXTERN DownloadFlagSetExtSRAM
        EXTERN GenModuleAutoInformSts
        EXTERN GenModuleInformSts
        EXTERN GenRepAidSts
        EXTERN Inform_CtrlDataCopy
        EXTERN Initialize
        EXTERN LoadBackupData
        EXTERN LocalIPCtrlData
        EXTERN LocalMacCtrlData
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ResetCaseBackup
        EXTERN ResetStart
        EXTERN Response_Table
        EXTERN RoadBackuptobuffer
        EXTERN SerPtr
        EXTERN TimeOverCheck
        EXTERN TimerCancel
        EXTERN TimerRegist
        EXTERN UpLoadExtSRAM
        EXTERN WriteBuffertoBackup
        EXTERN pUSART1
        EXTERN rambackup
        EXTERN tTestFlag

        PUBLIC BeaconSts
        PUBLIC BeaconStsB
        PUBLIC CurrFWDATTENMAX_3G
        PUBLIC DataCount
        PUBLIC Digital_StsData
        PUBLIC DnLoad_Cnt
        PUBLIC DnLoad_Data
        PUBLIC DnSubID0
        PUBLIC DnSubID1
        PUBLIC DnSubID2
        PUBLIC FlagRefSignalType
        PUBLIC FrameCnt
        PUBLIC FrameCounter
        PUBLIC FrameCounterOld
        PUBLIC GenAidData
        PUBLIC GenBodyFrame
        PUBLIC GenFrameOneDataTx
        PUBLIC IsitRmtSelfDn
        PUBLIC ModuleInform
        PUBLIC ModuleInformB
        PUBLIC PcSer
        PUBLIC PcSerB
        PUBLIC ProtocolComCheck
        PUBLIC RPcsksio
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
        PUBLIC chkRefSignalType
        PUBLIC downloadFlag
        PUBLIC iDebugCnt
        PUBLIC iResetCase
        PUBLIC iUser_Value2

// C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\WRCS\DDR_WRCS.c
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
        DS8 44

        SECTION `.bss`:DATA:NOROOT(2)
// __BeaconStsStr __data BeaconStsB
BeaconStsB:
        DS8 184

        SECTION `.bss`:DATA:NOROOT(2)
// __ModuleInform __data ModuleInformB
ModuleInformB:
        DS8 32

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
// INT8U __data iDebugCnt
iDebugCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iUser_Value2
iUser_Value2:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DnSubID0
DnSubID0:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DnSubID1
DnSubID1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DnSubID2
DnSubID2:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkRefSignalType
chkRefSignalType:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data FlagRefSignalType
FlagRefSignalType:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data CurrFWDATTENMAX_3G
CurrFWDATTENMAX_3G:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iResetCase
iResetCase:
        DS8 1
//   14 #include "download.c"

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork INT32U WRCS_DownLoadGiveupTimerSet(INT32U)
WRCS_DownLoadGiveupTimerSet:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        CBZ      R0,??WRCS_DownLoadGiveupTimerSet_0
        STR      R0,[R4, #+16]
        MOVW     R1,#+5000
        MOVS     R0,#+5
        BL       TimerRegist
??WRCS_DownLoadGiveupTimerSet_0:
        LDR      R0,[R4, #+16]
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void WRCS_DownLoadGiveupTimerRst(void)
WRCS_DownLoadGiveupTimerRst:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        MOVS     R1,#+0
        STR      R1,[R0, #+16]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork BOOL WRCS_DownLoadGiveupTimerChk(__ProtocolPtr *)
WRCS_DownLoadGiveupTimerChk:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDR      R1,[R4, #+12]
        CMP      R0,R1
        BNE.N    ??WRCS_DownLoadGiveupTimerChk_0
        MOVS     R0,#+5
        BL       TimeOverCheck
        CBZ      R0,??WRCS_DownLoadGiveupTimerChk_0
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
        MOVS     R0,#+1
        POP      {R4,PC}
??WRCS_DownLoadGiveupTimerChk_0:
        MOVS     R0,#+0
??WRCS_DownLoadGiveupTimerChk_1:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork INT8U WRCS_DownloadFunc(__ProtocolPtr *)
WRCS_DownloadFunc:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+16
        MOVS     R4,R0
        LDR      R0,[R4, #+28]
        LDRB     R1,[R0, #+1047]
        MOVW     R2,#+1036
        MLA      R0,R1,R2,R0
        ADD      R5,R0,#+8
        LDR.N    R6,??WRCS_DownloadFunc_0  ;; `?<Constant {0}>`
        ADD      R0,SP,#+0
        LDM      R6!,{R1-R3}
        STM      R0!,{R1-R3}
        SUBS     R6,R6,#+12
        MOV      R9,#+0
        LDRB     R10,[R5, #+0]
        LDRB     R7,[R5, #+1]
        LDRB     R8,[R5, #+2]
        LDRB     R0,[R5, #+3]
        CMP      R0,#+11
        BEQ.N    ??WRCS_DownloadFunc_1
        CMP      R0,#+12
        BEQ.N    ??WRCS_DownloadFunc_2
        CMP      R0,#+13
        BEQ.N    ??WRCS_DownloadFunc_3
        CMP      R0,#+14
        BEQ.N    ??WRCS_DownloadFunc_4
        B.N      ??WRCS_DownloadFunc_5
??WRCS_DownloadFunc_1:
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
        ADD      R1,SP,#+0
        LDRB     R0,[R5, #+7]
        STRB     R0,[R1, #+1]
        LDRB     R0,[R5, #+8]
        STRB     R0,[R1, #+2]
        LDRB     R0,[R5, #+9]
        STRB     R0,[R1, #+3]
        MOV      R9,#+4
        LDRB     R0,[R5, #+8]
        LDRB     R1,[R5, #+9]
        ORR      R0,R1,R0, LSL #+8
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        STRH     R0,[R1, #+6]
        B.N      ??WRCS_DownloadFunc_5
??WRCS_DownloadFunc_2:
        BL       OS_CPU_SR_Save
        MOVS     R1,#+0
        STRB     R1,[SP, #+0]
        MOV      R9,#+1
        BL       OS_CPU_SR_Restore
        B.N      ??WRCS_DownloadFunc_5
??WRCS_DownloadFunc_3:
        MOVS     R0,R4
        BL       WRCS_ReceiveData
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        LSRS     R0,R0,#+31
        STRB     R0,[SP, #+0]
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        LDRH     R0,[R1, #+4]
        ADD      R1,SP,#+0
        LSRS     R2,R0,#+8
        STRB     R2,[R1, #+1]
        STRB     R0,[R1, #+2]
        MOV      R9,#+3
        B.N      ??WRCS_DownloadFunc_5
??WRCS_DownloadFunc_4:
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        LDRH     R0,[R1, #+8]
        LDRB     R2,[R5, #+9]
        LDRB     R3,[R5, #+10]
        ORR      R2,R3,R2, LSL #+8
        CMP      R0,R2
        BNE.N    ??WRCS_DownloadFunc_6
        LDRH     R2,[R1, #+6]
        LDRH     R3,[R1, #+4]
        ADDS     R3,R3,#+1
        CMP      R2,R3
        BNE.N    ??WRCS_DownloadFunc_6
        MOVS     R2,#+0
        STRB     R2,[SP, #+0]
        B.N      ??WRCS_DownloadFunc_7
??WRCS_DownloadFunc_6:
        MOVS     R2,#+1
        STRB     R2,[SP, #+0]
??WRCS_DownloadFunc_7:
        LDRH     R2,[R1, #+6]
        ADD      R1,SP,#+0
        LSRS     R3,R2,#+8
        STRB     R3,[R1, #+1]
        STRB     R2,[R1, #+2]
        LSRS     R2,R0,#+8
        STRB     R2,[R1, #+3]
        STRB     R0,[R1, #+4]
        MOV      R9,#+5
??WRCS_DownloadFunc_5:
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        LDRB     R1,[R5, #+3]
        MOV      R0,R9
        PUSH     {R0,R1}
        ADD      R3,SP,#+16
        MOV      R2,R8
        MOVS     R1,R7
        MOV      R0,R10
        BL       GenBodyFrame
        ADD      SP,SP,#+16
        MOVS     R0,R4
        BL       WRCS_ProDataAckTx
        LDRB     R0,[R5, #+3]
        CMP      R0,#+14
        BNE.N    ??WRCS_DownloadFunc_8
        LDRB     R0,[SP, #+0]
        CBNZ     R0,??WRCS_DownloadFunc_8
        MOVS     R0,#+2
        BL       ResetCaseBackup
        LDR.N    R0,??WRCS_DownloadFunc_0+0x4  ;; rambackup
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+0]
        ADD      R0,R6,#+12
        LDR.N    R2,??WRCS_DownloadFunc_0+0x8  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        MOVS     R0,#+10
        BL       OSTimeDly
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+24]
        BL       DownloadFlagSetExtSRAM
        BL       DownLoadBootingJump
??WRCS_DownloadFunc_8:
        MOVS     R0,#+1
        ADD      SP,SP,#+16
        POP      {R4-R10,PC}      ;; return
        DATA
??WRCS_DownloadFunc_0:
        DC32     `?<Constant {0}>`
        DC32     rambackup
        DC32     SerPtr

        SECTION `.data`:DATA:NOROOT(2)
// BOOL __data SerialPadOnFlag
SerialPadOnFlag:
        DATA
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
// INT32U __data downloadFlag
downloadFlag:
        DC32 0
// __BeaconStsStr *__data BeaconSts
BeaconSts:
        DC32 BeaconStsB
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

        SECTION `.data`:DATA:NOROOT(2)
// __ModuleInform *__data ModuleInform
ModuleInform:
        DATA
        DC32 ModuleInformB

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

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork INT8U IsitRmtSelfDn(void)
IsitRmtSelfDn:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDRB     R0,[R0, #+1]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtSelfDnErrClr(void)
RmtSelfDnErrClr:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtDownStart(__ProtocolPtr *, INT8U)
RmtDownStart:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R6,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R6, #+24]
        MOV      R1,#+500
        SDIV     R2,R0,R1
        MOVS     R3,R2
        MLS      R0,R2,R1,R0
        CBZ      R0,??RmtDownStart_0
        ADDS     R3,R3,#+1
??RmtDownStart_0:
        STRH     R3,[R6, #+6]
        MOVS     R0,#+0
        STRH     R0,[R6, #+4]
        STRB     R0,[R6, #+2]
        MOV      R1,#+2000
        MOVS     R0,#+16
        BL       TimerRegist
        MOVS     R0,#+0
        STRB     R0,[R6, #+1]
        STR      R4,[R6, #+28]
        MOVS     R0,R4
        BL       WRCS_DownLoadGiveupTimerSet
        STRB     R5,[R6, #+3]
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtSendDownLoadFunc(void)
RmtSendDownLoadFunc:
        PUSH     {R4,LR}
        MOVS     R0,#+16
        BL       TimeOverCheck
        CBZ      R0,??RmtSendDownLoadFunc_0
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDRB     R0,[R4, #+1]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+1]
        UXTB     R0,R0
        CMP      R0,#+3
        BCS.N    ??RmtSendDownLoadFunc_0
        MOV      R1,#+2000
        MOVS     R0,#+16
        BL       TimerRegist
        LDRB     R0,[R4, #+2]
        CMP      R0,#+2
        BLS.N    ??RmtSendDownLoadFunc_1
        SUBS     R0,R0,#+3
        BEQ.N    ??RmtSendDownLoadFunc_2
        SUBS     R0,R0,#+1
        BNE.N    ??RmtSendDownLoadFunc_0
??RmtSendDownLoadFunc_1:
        LDR      R0,[R4, #+28]
        BL       WRCS_DownLoadGiveupTimerSet
        POP      {R4,PC}
??RmtSendDownLoadFunc_2:
        BL       RmtDnDataSend
??RmtSendDownLoadFunc_0:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtRecvDownLoadFunc(__ProtocolPtr *)
RmtRecvDownLoadFunc:
        PUSH     {R4,LR}
        LDR      R0,[R0, #+28]
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
        LDRH     R1,[R1, #+6]
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_4
??RmtRecvDownLoadFunc_5:
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDRB     R0,[R4, #+2]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+2]
??RmtRecvDownLoadFunc_6:
        MOVS     R0,#+0
        STRB     R0,[R4, #+1]
        MOVS     R1,#+10
        MOVS     R0,#+16
        BL       TimerRegist
        POP      {R4,PC}
??RmtRecvDownLoadFunc_1:
        LDRB     R0,[R0, #+7]
        CBNZ     R0,??RmtRecvDownLoadFunc_4
        B.N      ??RmtRecvDownLoadFunc_5
??RmtRecvDownLoadFunc_2:
        LDRB     R1,[R0, #+7]
        CBNZ     R1,??RmtRecvDownLoadFunc_4
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDRH     R1,[R4, #+4]
        LDRB     R2,[R0, #+8]
        LDRB     R0,[R0, #+9]
        ORR      R0,R0,R2, LSL #+8
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_4
        ADDS     R0,R1,#+1
        STRH     R0,[R4, #+4]
        LDRH     R1,[R4, #+6]
        UXTH     R0,R0
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_6
        LDRB     R0,[R4, #+2]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+2]
??RmtRecvDownLoadFunc_7:
        B.N      ??RmtRecvDownLoadFunc_6
??RmtRecvDownLoadFunc_3:
        LDRB     R1,[R0, #+7]
        CBNZ     R1,??RmtRecvDownLoadFunc_4
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDRB     R1,[R0, #+8]
        LDRB     R0,[R0, #+9]
        ORR      R0,R0,R1, LSL #+8
        LDRH     R1,[R4, #+6]
        CMP      R0,R1
        BNE.N    ??RmtRecvDownLoadFunc_4
        MOVS     R0,#+16
        BL       TimerCancel
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
??RmtRecvDownLoadFunc_4:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtDnFrameStart(void)
RmtDnFrameStart:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+28]
        B.N      WRCS_DownLoadGiveupTimerSet

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtDnConFirmSend(void)
RmtDnConFirmSend:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+28]
        B.N      WRCS_DownLoadGiveupTimerSet

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtDnDataSend(void)
RmtDnDataSend:
        PUSH     {R4-R6,LR}
        LDR.N    R0,??RmtDnDataSend_0  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.N    R1,??RmtDnDataSend_0+0x4  ;; 0x8007000
        ADD      R2,R1,R0, LSL #+10
        LDR.W    R3,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R3, #+28]
        LDR      R1,[R0, #+32]
        ADD      R12,R1,#+8
        MOV      R1,#+500
        LDRH     LR,[R3, #+4]
        LSR      R4,LR,#+8
        STRB     R4,[R12, #+7]
        STRB     LR,[R12, #+8]
        MOV      R4,R1
        LDRH     R5,[R3, #+6]
        ADD      R6,LR,#+1
        CMP      R5,R6
        BNE.N    ??RmtDnDataSend_1
        LDR      R3,[R3, #+24]
        SDIV     R5,R3,R4
        MLS      R3,R5,R4,R3
        CBZ      R3,??RmtDnDataSend_1
        UXTH     R1,R3
        CBZ      R1,??RmtDnDataSend_2
??RmtDnDataSend_1:
        MLA      R2,LR,R4,R2
        ADD      R3,R12,#+9
??RmtDnDataSend_3:
        LDRB     R12,[R2], #+1
        STRB     R12,[R3], #+1
        SUBS     R1,R1,#+1
        BNE.N    ??RmtDnDataSend_3
??RmtDnDataSend_2:
        POP      {R4-R6,LR}
        B.N      WRCS_DownLoadGiveupTimerSet
        Nop      
        DATA
??RmtDnDataSend_0:
        DC32     0x1ffff7e0
        DC32     0x8007000

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork void RmtDnEndSend(void)
RmtDnEndSend:
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+28]
        B.N      WRCS_DownLoadGiveupTimerSet

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// __??Code16?? __code __interwork BOOL WRCS_ReceiveData(__ProtocolPtr *)
WRCS_ReceiveData:
        PUSH     {R4-R8,LR}
        LDR      R0,[R0, #+28]
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
        STR      R0,[R6, #+24]
        STRH     R0,[R6, #+8]
??WRCS_ReceiveData_1:
        LDRH     R0,[R4, #+1031]
        SUB      R8,R0,#+2
        LDR      R2,[R6, #+24]
        UXTH     R1,R8
        ADD      R0,R4,#+9
        BL       UpLoadExtSRAM
        MOVS     R7,R0
        STR      R7,[R6, #+24]
        LDRH     R2,[R6, #+8]
        MOV      R1,R8
        ADD      R0,R4,#+9
        BL       Crc16Calc
        STRH     R0,[R6, #+8]
        STRH     R5,[R6, #+4]
        MOV      R0,#-1
        CMP      R7,R0
        BNE.N    ??WRCS_ReceiveData_2
??WRCS_ReceiveData_3:
        MOVS     R0,#+0
        B.N      ??WRCS_ReceiveData_4
??WRCS_ReceiveData_0:
        LDRH     R0,[R6, #+4]
        ADDS     R2,R0,#+1
        CMP      R5,R2
        BNE.N    ??WRCS_ReceiveData_3
??WRCS_ReceiveData_5:
        CMP      R5,R0
        BNE.N    ??WRCS_ReceiveData_1
??WRCS_ReceiveData_2:
        MOVS     R0,#+1
??WRCS_ReceiveData_4:
        POP      {R4-R8,PC}       ;; return
//   15 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   16 void WRCS_SerInit(void)
//   17 {
WRCS_SerInit:
        PUSH     {R7,LR}
//   18  	PcSer->CheckByte = pUSART1.CheckByte;
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R1,[R0, #+12]
        LDR.N    R2,??WRCS_SerInit_0  ;; pUSART1
        LDR      R3,[R2, #+4]
        STR      R3,[R1, #+0]
//   19 	PcSer->RxGetByte = pUSART1.RxGetByte;
        LDR      R3,[R2, #+8]
        STR      R3,[R1, #+4]
//   20 	PcSer->PutStr = pUSART1.PutStr;
        LDR      R3,[R2, #+12]
        STR      R3,[R1, #+8]
//   21 	PcSer->TxCheckByte = pUSART1.TxCheckByte;
        LDR      R2,[R2, #+28]
        STR      R2,[R1, #+16]
//   22 
//   23 	PcSer->TimerRx = TimerSioRx;
        MOVS     R2,#+2
        STRH     R2,[R1, #+20]
//   24 	PcSer->WRCSRecv = &RPcsksio;
        ADDW     R2,R0,#+2104
        STR      R2,[R1, #+28]
//   25 	PcSer->WRCSSend = &SPcsksio;
        ADD      R2,R0,#+1056
        STR      R2,[R1, #+32]
//   26 	
//   27 	OSTaskCreate(WRCSTask, (void *)NULL, (OS_STK *)&Ser1TaskStk[SER1_STK_SIZE - 1], SER0TASK_PRIO);
        MOVS     R3,#+1
        ADDW     R2,R0,#+1052
        MOVS     R1,#+0
        LDR.N    R0,??WRCS_SerInit_0+0x4  ;; WRCSTask
        BL       OSTaskCreate
//   28 
//   29  	//LoadTable();		// eeprom을 사용하지 않으면 필요없다.
//   30 	LoadBackupData();	// default setting!!
        BL       LoadBackupData
//   31 	Initialize();
        POP      {R0,LR}
        B.W      Initialize
        DATA
??WRCS_SerInit_0:
        DC32     pUSART1
        DC32     WRCSTask
//   32  }
//   33 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   34 void WRCSTask(void *pdata)
//   35 {
WRCSTask:
        PUSH     {R3-R5,LR}
//   36 	__ProtocolPtr *nPtr = (__ProtocolPtr *)PcSer;
//   37 
//   38     nPtr = nPtr;
        LDR.W    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R4,[R0, #+12]
//   39 	pdata = pdata;
//   40 	OSTimeDly(500L);
        MOV      R0,#+500
        BL       OSTimeDly
        LDR.N    R5,??WRCSTask_0  ;; tTestFlag
//   41 
//   42 	while(1)
//   43 	{
//   44 		nPtr->WRCSRecv->cBody = 0;
??WRCSTask_1:
        LDR      R0,[R4, #+28]
        MOVS     R1,#+0
        STRB     R1,[R0, #+1047]
//   45 		StsCheckConnectionRst(nPtr);
        MOVS     R0,R4
        BL       StsCheckConnectionRst
//   46 	
//   47 		if(!tTestFlag)
        LDRB     R0,[R5, #+0]
        CBNZ     R0,??WRCSTask_2
//   48 		{
//   49 			if(WRCS_ProtocolCheck(nPtr))
        MOVS     R0,R4
        BL       WRCS_ProtocolCheck
        CBZ      R0,??WRCSTask_2
//   50 			{
//   51 				StsCheckConnectionSet(nPtr);
        MOVS     R0,R4
        BL       StsCheckConnectionSet
//   52 			#if TWO_BODY >= 2
//   53 				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   54 				{
//   55 			#endif
//   56 					ProtocolComCheck(nPtr);
        MOVS     R0,R4
        BL       ProtocolComCheck
//   57 			#if TWO_BODY >= 2
//   58 					nPtr->WRCSRecv->cBody++;
//   59 				}
//   60 			#endif
//   61 			}			
//   62 		}
//   63 		WRCS_DownLoadGiveupTimerChk(nPtr);
??WRCSTask_2:
        MOVS     R0,R4
        BL       WRCS_DownLoadGiveupTimerChk
//   64 		OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
        B.N      ??WRCSTask_1
        Nop      
        DATA
??WRCSTask_0:
        DC32     tTestFlag
//   65 	}
//   66 }
//   67 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   68 void StsCheckConnectionSet(__ProtocolPtr *nPtr)
//   69 {
StsCheckConnectionSet:
        PUSH     {R7,LR}
//   70 	if(nPtr == PcSer)
        LDR.W    R1,??DataTable29  ;; SerialPadOnFlag
        LDR      R2,[R1, #+12]
        CMP      R0,R2
        BNE.N    ??StsCheckConnectionSet_0
//   71 	{
//   72 		SerialPadOnFlag = 1;
        MOVS     R0,#+1
        STRB     R0,[R1, #+0]
//   73 		TimerRegist(TimerStsCheck, 60*Time1Sec);
        MOVW     R1,#+60000
        MOVS     R0,#+6
        BL       TimerRegist
//   74 	}
//   75 }
??StsCheckConnectionSet_0:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   76 void StsCheckConnectionRst(__ProtocolPtr *nPtr)
//   77 {
StsCheckConnectionRst:
        PUSH     {R4,LR}
//   78 	if(nPtr == PcSer && TimeOverCheck(TimerStsCheck)) 
        LDR.W    R4,??DataTable29  ;; SerialPadOnFlag
        LDR      R1,[R4, #+12]
        CMP      R0,R1
        BNE.N    ??StsCheckConnectionRst_0
        MOVS     R0,#+6
        BL       TimeOverCheck
        CBZ      R0,??StsCheckConnectionRst_0
//   79 
//   80 	SerialPadOnFlag = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//   81 }
??StsCheckConnectionRst_0:
        POP      {R4,PC}          ;; return
//   82 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   83 INT32U WRCS_ProtocolCheck(__ProtocolPtr *nPtr)
//   84 {
WRCS_ProtocolCheck:
        PUSH     {R3-R9,LR}
        MOVS     R4,R0
//   85 	INT16U nInitCnt, nCnt;
//   86 	INT16U i = 0;
//   87 	INT16U Data;
//   88 
//   89 	__WRCSSIO *Recv = nPtr->WRCSRecv;
        LDR      R5,[R4, #+28]
//   90 
//   91 	TimerRegist(nPtr->TimerRx, Time1Sec*2L);
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
        B.N      ??WRCS_ProtocolCheck_0
//   92 
//   93 	while(1)
//   94 	{
//   95 		if(TimeOverCheck(nPtr->TimerRx)) return FALSE;	
//   96 
//   97 		if(nPtr->CheckByte(1, &nCnt))
//   98 		{
//   99 			if(STX == nPtr->RxGetByte())
//  100 			{
//  101 				if(nPtr->CheckByte(1, &nCnt))
//  102 				{
//  103     				if(STX == nPtr->RxGetByte())
//  104 					{
//  105 						if(nPtr->CheckByte(1, &nCnt))
//  106 						{
//  107 							if(STX == nPtr->RxGetByte())
//  108 							{
//  109 								if(nPtr->CheckByte(1, &nCnt))
//  110 								{
//  111 									if(STX == nPtr->RxGetByte())
//  112 									{
//  113 											Recv->Sync[0] = STX;
//  114 											Recv->Sync[1] = STX;
//  115 											Recv->Sync[2] = STX;
//  116 											Recv->Sync[3] = STX;
//  117 											Recv->BodyNo = 0; // Default: 1EA
//  118 											break;
//  119 									}
//  120 								}
//  121 								else OSTimeDly(100);
??WRCS_ProtocolCheck_1:
        MOVS     R0,#+100
        BL       OSTimeDly
??WRCS_ProtocolCheck_0:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??WRCS_ProtocolCheck_2
??WRCS_ProtocolCheck_3:
        MOVS     R0,#+0
        B.N      ??WRCS_ProtocolCheck_4
??WRCS_ProtocolCheck_2:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_1
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??WRCS_ProtocolCheck_0
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_1
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??WRCS_ProtocolCheck_0
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_1
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??WRCS_ProtocolCheck_0
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_1
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??WRCS_ProtocolCheck_0
        STRB     R0,[R5, #+0]
        STRB     R0,[R5, #+1]
        STRB     R0,[R5, #+2]
        STRB     R0,[R5, #+3]
        ADDW     R6,R5,#+1044
        MOVS     R0,#+0
        STRB     R0,[R6, #+2]
//  122 							}
//  123 						}
//  124 						else OSTimeDly(100);
//  125 					}
//  126 				} 
//  127 				else OSTimeDly(100);
//  128 			}
//  129  		} else OSTimeDly(100L);
//  130 	}	
//  131 
//  132 
//  133 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  134 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_5
//  135 	while(!nPtr->CheckByte(4, &nCnt))
//  136 	{
//  137 		if(TimeOverCheck(nPtr->TimerRx))
//  138 		{
//  139 			if(nCnt > nInitCnt)
//  140 			{
//  141 				nInitCnt = nCnt;
??WRCS_ProtocolCheck_6:
        MOV      R0,R1
        STRH     R0,[SP, #+2]
//  142 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  143 			}
//  144 			else return FALSE;
//  145 		}
//  146 		OSTimeDly(10L);
??WRCS_ProtocolCheck_7:
        MOVS     R0,#+10
        BL       OSTimeDly
??WRCS_ProtocolCheck_5:
        ADD      R1,SP,#+0
        MOVS     R0,#+4
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ     R0,??WRCS_ProtocolCheck_8
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_7
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCC.N    ??WRCS_ProtocolCheck_6
        B.N      ??WRCS_ProtocolCheck_3
//  147 	}
//  148 	
//  149 	Recv->TryNo 		= nPtr->RxGetByte();
??WRCS_ProtocolCheck_8:
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+4]
//  150 	Recv->BodyLen[0]	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+5]
//  151 	Recv->BodyLen[1]	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+6]
//  152 	Recv->CheckSum		= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+7]
//  153 
//  154 	Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);
        LDRB     R0,[R5, #+5]
        LDRB     R1,[R5, #+6]
        ADD      R0,R1,R0, LSL #+8
        STRH     R0,[R5, #+1044]
//  155 
//  156 	if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
//  157 		|| (Recv->BodyLength >= (TWO_BODY*BODYSIZEMAX))
//  158 	)
        LDRB     R0,[R5, #+7]
        LDRB     R1,[R5, #+4]
        LDRB     R2,[R5, #+5]
        ADDS     R1,R2,R1
        LDRB     R2,[R5, #+6]
        ADDS     R1,R2,R1
        UXTB     R1,R1
        CMP      R0,R1
        BNE.N    ??WRCS_ProtocolCheck_9
        LDRH     R0,[R5, #+1044]
        MOV      R1,#+1024
        CMP      R0,R1
        BCC.N    ??WRCS_ProtocolCheck_10
//  159 	{								
//  160 		return FALSE;
??WRCS_ProtocolCheck_9:
        MOVS     R0,#+0
        B.N      ??WRCS_ProtocolCheck_4
//  161 	}
//  162     
//  163 #if TWO_BODY >= 2
//  164 BODYRE:
//  165 #endif
//  166 	TimerRegist(nPtr->TimerRx, Time1Sec*2);
??WRCS_ProtocolCheck_10:
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  167 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_11
//  168 	while(1)
//  169 	{
//  170 		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
//  171 		{
//  172 			if(nCnt > nInitCnt)
//  173 			{
//  174 				nInitCnt = nCnt;
//  175 				TimerRegist(nPtr->TimerRx, Time100mSec);
//  176 			}
//  177 			else
//  178 			{
//  179 				return FALSE;
//  180 			}
//  181 		}
//  182 		if(nPtr->CheckByte(7, &nCnt))
//  183 		{
//  184 			break;// include 0x03
//  185 		}
//  186 		OSTimeDly(20L);
??WRCS_ProtocolCheck_12:
        MOVS     R0,#+20
        BL       OSTimeDly
??WRCS_ProtocolCheck_11:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??WRCS_ProtocolCheck_13
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.N    ??WRCS_ProtocolCheck_9
        MOV      R0,R1
        STRH     R0,[SP, #+2]
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
??WRCS_ProtocolCheck_13:
        ADD      R1,SP,#+0
        MOVS     R0,#+7
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_12
//  187 	}
//  188 	
//  189 	for(i = 0; i < 7 ; i++)
        MOV      R8,#+0
        MOVW     R7,#+1036
//  190 	{
//  191 		*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubID + i) = nPtr->RxGetByte();
??WRCS_ProtocolCheck_14:
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        ADD      R9,R8,R0
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R9, #+8]
//  192 	}
        ADD      R8,R8,#+1
        UXTH     R0,R8
        CMP      R0,#+7
        BCC.N    ??WRCS_ProtocolCheck_14
//  193 
//  194 	Recv->BodyFrame[Recv->BodyNo].SubLength
//  195 		=	 ((Recv->BodyFrame[Recv->BodyNo].SubLen[0] << 8)& 0xff00)
//  196 		  +  ((Recv->BodyFrame[Recv->BodyNo].SubLen[1] << 0)& 0x00ff);
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R7,R5
        LDRB     R1,[R1, #+13]
        LDRB     R2,[R6, #+2]
        MLA      R2,R2,R7,R5
        LDRB     R2,[R2, #+14]
        ADD      R1,R2,R1, LSL #+8
        STRH     R1,[R0, #+1039]
//  197 
//  198 	if(Recv->BodyFrame[Recv->BodyNo].SubLength >= BODYSIZEMAX)	return FALSE;	
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        LDRH     R0,[R0, #+1039]
        MOV      R1,#+1024
        CMP      R0,R1
        BCS.W    ??WRCS_ProtocolCheck_3
//  199 
//  200 
//  201 	TimerRegist(nPtr->TimerRx, Time1Sec*2);
??WRCS_ProtocolCheck_15:
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  202 
//  203 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_16
//  204 	while(1)
//  205 	{
//  206 		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
//  207 		{
//  208 			if(nCnt > nInitCnt)
//  209 			{
//  210 				nInitCnt = nCnt;
//  211 				TimerRegist(nPtr->TimerRx, Time100mSec);
//  212 			}
//  213 			else
//  214 			{
//  215 				return FALSE;
//  216 			}
//  217 		}
//  218 		if(nPtr->CheckByte((INT16U)(Recv->BodyFrame[Recv->BodyNo].SubLength + 2), &nCnt))
//  219 		{
//  220 			break;// include 0x03
//  221 		}
//  222 		OSTimeDly(20L);
??WRCS_ProtocolCheck_17:
        MOVS     R0,#+20
        BL       OSTimeDly
??WRCS_ProtocolCheck_16:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??WRCS_ProtocolCheck_18
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.W    ??WRCS_ProtocolCheck_3
        MOV      R0,R1
        STRH     R0,[SP, #+2]
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
??WRCS_ProtocolCheck_18:
        ADD      R1,SP,#+0
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        LDRH     R0,[R0, #+1039]
        ADDS     R0,R0,#+2
        UXTH     R0,R0
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_17
//  223 	}
//  224 	for(i = 0; i < Recv->BodyFrame[Recv->BodyNo].SubLength + 2; i++)
        MOV      R8,#+0
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        LDRH     R0,[R0, #+1039]
        ADDS     R0,R0,#+2
        CMP      R0,#+1
        BLT.N    ??WRCS_ProtocolCheck_19
//  225 	{
//  226 	    *((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubData + i) = nPtr->RxGetByte();
??WRCS_ProtocolCheck_20:
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        ADD      R9,R8,R0
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R9, #+15]
//  227 	}
        ADD      R8,R8,#+1
        UXTH     R8,R8
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        LDRH     R0,[R0, #+1039]
        ADDS     R0,R0,#+2
        CMP      R8,R0
        BLT.N    ??WRCS_ProtocolCheck_20
//  228 
//  229 
//  230 	Recv->BodyFrame[Recv->BodyNo].Crc= Crc16Calc ( &(Recv->BodyFrame[Recv->BodyNo].SubID[0])
//  231 						                            , Recv->BodyFrame[Recv->BodyNo].SubLength + 5 + 2, NULL);
??WRCS_ProtocolCheck_19:
        LDRB     R0,[R6, #+2]
        MLA      R8,R0,R7,R5
        MOVS     R2,#+0
        MLA      R0,R0,R7,R5
        LDRH     R0,[R0, #+1039]
        ADDS     R1,R0,#+7
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        ADDS     R0,R0,#+8
        BL       Crc16Calc
        STRH     R0,[R8, #+1041]
//  232 	Recv->BodyFrame[Recv->BodyNo].CrcOK = TRUE;
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        MOVS     R1,#+1
        STRB     R1,[R0, #+1043]
//  233 
//  234 	Data = Recv->BodyFrame[Recv->BodyNo].SubLength;
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        LDRH     R0,[R0, #+1039]
//  235 
//  236 	if (   ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc >> 8)!= Recv->BodyFrame[Recv->BodyNo].SubData[Data  ] )
//  237 		|| ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc     )!= Recv->BodyFrame[Recv->BodyNo].SubData[Data+1] )  )
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R7,R5
        LDRH     R1,[R1, #+1041]
        LSRS     R1,R1,#+8
        LDRB     R2,[R6, #+2]
        MLA      R2,R2,R7,R5
        ADDS     R2,R0,R2
        LDRB     R2,[R2, #+15]
        CMP      R1,R2
        BNE.N    ??WRCS_ProtocolCheck_21
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R7,R5
        LDRH     R1,[R1, #+1041]
        LDRB     R2,[R6, #+2]
        MLA      R2,R2,R7,R5
        ADDS     R0,R0,R2
        LDRB     R0,[R0, #+16]
        UXTB     R1,R1
        CMP      R1,R0
        BEQ.N    ??WRCS_ProtocolCheck_22
//  238 	{
//  239 		//CRC ERROR!!
//  240 		Recv->BodyFrame[Recv->BodyNo].CrcOK = FALSE;
??WRCS_ProtocolCheck_21:
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R7,R5
        MOVS     R1,#+0
        STRB     R1,[R0, #+1043]
//  241 		return TRUE;
        B.N      ??WRCS_ProtocolCheck_23
//  242 	}
//  243 
//  244 #if TWO_BODY >= 2
//  245 	if(!Recv->BodyNo)
//  246 	{
//  247 		if(Recv->BodyLength != (Recv->BodyFrame[Recv->BodyNo].SubLength
//  248 															  + 5 + 2 + 2))
//  249 		{
//  250 			Recv->BodyNo++;
//  251 			goto BODYRE;
//  252 		}
//  253 	}
//  254 #endif	
//  255 ////////////////////////////////////////////////////////////////////////////////
//  256 
//  257 	TimerRegist(nPtr->TimerRx, Time1Sec);
??WRCS_ProtocolCheck_22:
        MOV      R1,#+1000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  258 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??WRCS_ProtocolCheck_24
//  259 	while(!nPtr->CheckByte(1, &nCnt))
//  260 	{
//  261 		if(TimeOverCheck(nPtr->TimerRx))
//  262 		{
//  263 			if(nCnt > nInitCnt)
//  264 			{
//  265 				nInitCnt = nCnt;
??WRCS_ProtocolCheck_25:
        MOV      R0,R1
        STRH     R0,[SP, #+2]
//  266 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  267 			}
//  268 			else
//  269 			{
//  270 				return FALSE;
//  271 			}
//  272 		}
//  273 		OSTimeDly(10L);
??WRCS_ProtocolCheck_26:
        MOVS     R0,#+10
        BL       OSTimeDly
??WRCS_ProtocolCheck_24:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ     R0,??WRCS_ProtocolCheck_27
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??WRCS_ProtocolCheck_26
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCC.N    ??WRCS_ProtocolCheck_25
        B.N      ??WRCS_ProtocolCheck_9
//  274 	}
//  275 	Data = nPtr->RxGetByte();
??WRCS_ProtocolCheck_27:
        LDR      R0,[R4, #+4]
        BLX      R0
        UXTH     R0,R0
//  276 
//  277 	if(Data != ETX)
        CMP      R0,#+3
        BNE.W    ??WRCS_ProtocolCheck_3
//  278 	{
//  279 		return FALSE;
//  280 	}
//  281 	return TRUE;
??WRCS_ProtocolCheck_23:
        MOVS     R0,#+1
??WRCS_ProtocolCheck_4:
        POP      {R1,R4-R9,PC}    ;; return
//  282 }
//  283 
//  284 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  285 INT16U WRCS_WhatRxComm(__ProtocolPtr *nPtr)
//  286 {
//  287 	INT16U RetVal = 0;
//  288 	INT8U cBody = nPtr->WRCSRecv->cBody;
WRCS_WhatRxComm:
        LDR      R0,[R0, #+28]
        LDRB     R1,[R0, #+1047]
//  289 	
//  290 	if(nPtr->WRCSRecv->BodyFrame[cBody].CrcOK)
        MOVW     R2,#+1036
        MLA      R0,R1,R2,R0
        LDRB     R1,[R0, #+1043]
        CBZ      R1,??WRCS_WhatRxComm_0
//  291 	{
//  292 		RetVal = nPtr->WRCSRecv->BodyFrame[cBody].Command;
        LDRB     R0,[R0, #+11]
        BX       LR
//  293 	}
//  294 	else //NO ERROR
//  295 	{
//  296 		//ERROR CASE
//  297 		RetVal = AlarmSCODE;
??WRCS_WhatRxComm_0:
        MOVS     R0,#+2
//  298 	}
//  299     return (RetVal);
??WRCS_WhatRxComm_1:
        BX       LR               ;; return
//  300 }
//  301 
//  302 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  303 void ProtocolComCheck (__ProtocolPtr *nPtr)
//  304 {
ProtocolComCheck:
        PUSH     {R3-R11,LR}
        MOVS     R4,R0
//  305 	INT16U tcnt = 0;
//  306 	INT16U Comm = WRCS_WhatRxComm(nPtr);
        BL       WRCS_WhatRxComm
        MOV      R8,R0
//  307 	
//  308 	__WRCSSIO *Recv = nPtr->WRCSRecv;
//  309 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R0,[R4, #+32]
//  310     __BODYFRAME *rBody = &Recv->BodyFrame[0];
        LDR      R1,[R4, #+28]
        ADD      R9,R1,#+8
//  311     __BODYFRAME *sBody = &Send->BodyFrame[0];
        ADD      R10,R0,#+8
//  312 
//  313 	INT8U id0 = rBody->SubID[0];
        LDRB     R5,[R9, #+0]
//  314 	INT8U id1 = rBody->SubID[1];
        LDRB     R6,[R9, #+1]
//  315 	INT8U id2 = rBody->SubID[2];
        LDRB     R7,[R9, #+2]
//  316 
//  317 	OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
//  318 	
//  319 	switch(Comm)
        MOV      R0,R8
        CMP      R0,#+0
        BEQ.W    ??ProtocolComCheck_0
        SUBS     R0,R0,#+1
        BEQ.W    ??ProtocolComCheck_1
        SUBS     R0,R0,#+2
        BEQ.N    ??ProtocolComCheck_2
        SUBS     R0,R0,#+1
        BEQ.N    ??ProtocolComCheck_3
        SUBS     R0,R0,#+7
        CMP      R0,#+3
        BLS.W    ??ProtocolComCheck_4
        SUBS     R0,R0,#+28
        CMP      R0,#+1
        BLS.N    ??ProtocolComCheck_5
        SUBS     R0,R0,#+2
        CMP      R0,#+1
        BLS.W    ??ProtocolComCheck_6
        SUBS     R0,R0,#+55
        BEQ.N    ??ProtocolComCheck_7
        SUBS     R0,R0,#+1
        BEQ.N    ??ProtocolComCheck_8
        SUBS     R0,R0,#+20
        CMP      R0,#+1
        BLS.W    ??ProtocolComCheck_9
        SUBS     R0,R0,#+113
        BEQ.N    ??ProtocolComCheck_10
        B.N      ??ProtocolComCheck_11
//  320 	{
//  321 		case AlarmMaskSetSCODE:
//  322 		{
//  323 			INT32U cpu_sr;
//  324 			OS_ENTER_CRITICAL();
??ProtocolComCheck_2:
        BL       OS_CPU_SR_Save
        MOV      R10,R0
//  325 			{
//  326 				EE_BACK1 *ptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.W    R11,??ProtocolComCheck_12  ;; 0x8006000
        MOV      R0,R11
        BL       RoadBackuptobuffer
//  327 							
//  328 				ptr->BackUp.AlarmMask = rBody->SubData[0];
        LDRB     R1,[R9, #+7]
        STRB     R1,[R0, #+121]
//  329 				BeaconSts->AlarmMask = rBody->SubData[0];
        LDR.N    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+20]
        LDRB     R1,[R9, #+7]
        STRB     R1,[R0, #+174]
//  330 				WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+128
        MOV      R0,R11
        BL       WriteBuffertoBackup
//  331 			}
//  332 			OS_EXIT_CRITICAL();
        MOV      R0,R10
        BL       OS_CPU_SR_Restore
//  333 			
//  334 			GenBodyFrame(id0, id1, id2, (INT8U *)rBody->SubData, rBody->SubLength, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        LDRH     R0,[R9, #+1031]
        UXTB     R1,R8
        PUSH     {R0,R1}
        ADD      R3,R9,#+7
??ProtocolComCheck_13:
        MOVS     R2,R7
        MOVS     R1,R6
        MOVS     R0,R5
        BL       GenBodyFrame
        ADD      SP,SP,#+16
//  335 			WRCS_ProDataAckTx(nPtr);
        MOVS     R0,R4
        BL       WRCS_ProDataAckTx
        B.N      ??ProtocolComCheck_11
//  336 		}
//  337 		break;
//  338 
//  339 		case RestartSCODE:
//  340 			ResetCaseBackup(0x01);
??ProtocolComCheck_3:
        MOVS     R0,#+1
        BL       ResetCaseBackup
//  341 			ResetStart();
        BL       ResetStart
        B.N      ??ProtocolComCheck_11
//  342 		break;
//  343 		
//  344 		case ModuleInformStsQue:
//  345 			tcnt = GenModuleInformSts(sBody->SubData);
//  346 
//  347 			GenBodyFrame(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
//  348 			WRCS_ProDataAckTx(nPtr);
//  349 		break;
//  350 
//  351 		case AutoModuleInformQue:
//  352 			tcnt = GenModuleAutoInformSts(sBody->SubData);
??ProtocolComCheck_8:
        ADD      R0,R10,#+7
        BL       GenModuleAutoInformSts
        MOVS     R2,R0
//  353 			GenBodyFrame(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        MOVS     R0,R2
        UXTB     R1,R8
        PUSH     {R0,R1}
        ADD      R3,R10,#+7
        B.N      ??ProtocolComCheck_13
//  354 			WRCS_ProDataAckTx(nPtr);
//  355 		break;
//  356 
//  357 		case ModuleInformSetQue:
//  358 			if(rBody->SubLength == 36)
??ProtocolComCheck_10:
        LDRH     R0,[R9, #+1031]
        CMP      R0,#+36
        BNE.N    ??ProtocolComCheck_14
//  359 			{
//  360 				Inform_CtrlDataCopy((__ModuleInformCtrl *)&rBody->SubData[2]);
        ADD      R0,R9,#+9
??ProtocolComCheck_15:
        BL       Inform_CtrlDataCopy
//  361 			}
??ProtocolComCheck_7:
        ADD      R0,R10,#+7
        BL       GenModuleInformSts
        MOVS     R2,R0
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        MOVS     R0,R2
        UXTB     R1,R8
        PUSH     {R0,R1}
        ADD      R3,R10,#+7
??ProtocolComCheck_16:
        MOVS     R2,R7
        MOVS     R1,R6
        MOVS     R0,R5
        BL       GenBodyFrame
        ADD      SP,SP,#+16
        MOVS     R0,R4
        BL       WRCS_ProDataAckTx
        B.N      ??ProtocolComCheck_11
//  362 			else
//  363 			{
//  364 				Inform_CtrlDataCopy((__ModuleInformCtrl *)rBody->SubData);
??ProtocolComCheck_14:
        ADD      R0,R9,#+7
        B.N      ??ProtocolComCheck_15
//  365 			}
//  366 			tcnt = GenModuleInformSts(sBody->SubData);
//  367 			GenBodyFrame(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
//  368 			WRCS_ProDataAckTx(nPtr);
//  369 		break;
//  370         
//  371 		case LocalMacAddrSetQue:
//  372 		case LocalMacAddrStsQue:
//  373 			if(nPtr == PcSer)
??ProtocolComCheck_5:
        LDR.N    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+12]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_11
//  374 			{
//  375 				if(Comm == LocalMacAddrSetQue)
        MOV      R0,R8
        CMP      R0,#+40
        BNE.N    ??ProtocolComCheck_17
//  376 				{
//  377 					LocalMacCtrlData((__MacAddrStr *)rBody->SubData);
        ADD      R0,R9,#+7
        BL       LocalMacCtrlData
//  378 					ResetStart();
        BL       ResetStart
//  379 				}
//  380 				{
//  381 					EE_BACK1 *tptr = vEE_BACK1;
//  382 
//  383 					GenBodyFrame(id0, id1, id2, (INT8U *)tptr->BackUp.MacAddr, sizeof(__MacAddrStr), Comm, nPtr, 0);
??ProtocolComCheck_17:
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        MOVS     R0,#+6
        UXTB     R1,R8
        PUSH     {R0,R1}
        LDR.N    R0,??ProtocolComCheck_12+0x4  ;; 0x8006040
        ADD      R3,R0,#+12
        B.N      ??ProtocolComCheck_13
//  384 					WRCS_ProDataAckTx(nPtr);
//  385 				}
//  386 			}
//  387 		break;
//  388 		
//  389 		case LocalIPAddrSetQue:
//  390 		case LocalIPAddrStsQue:
//  391 			if(nPtr == PcSer)
??ProtocolComCheck_6:
        LDR.N    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+12]
        CMP      R4,R0
        BNE.N    ??ProtocolComCheck_11
//  392 			{
//  393 				if(Comm == LocalIPAddrSetQue)
        MOV      R0,R8
        CMP      R0,#+42
        BNE.N    ??ProtocolComCheck_18
//  394 				{
//  395 					LocalIPCtrlData((__IPAddrStr *)rBody->SubData);
        ADD      R0,R9,#+7
        BL       LocalIPCtrlData
//  396 					ResetStart();
        BL       ResetStart
//  397 				}
//  398 				{
//  399 					EE_BACK1 *tptr = vEE_BACK1;
//  400 		
//  401 					GenBodyFrame(id0, id1, id2, (INT8U *)tptr->BackUp.IpAddr, sizeof(__IPAddrStr), Comm, nPtr, 0);
??ProtocolComCheck_18:
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        MOVS     R0,#+12
        UXTB     R1,R8
        PUSH     {R0,R1}
        LDR.N    R3,??ProtocolComCheck_12+0x4  ;; 0x8006040
        B.N      ??ProtocolComCheck_13
//  402 					WRCS_ProDataAckTx(nPtr);
//  403 				}
//  404 			}
//  405 		break;
//  406 		
//  407 		case TableSetQue:
//  408 		case TableStsQue:
//  409 				if(WRCS_DownLoadGiveupTimerSet(NULL))
??ProtocolComCheck_9:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CBZ      R0,??ProtocolComCheck_19
//  410 				{
//  411 					if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CMP      R0,R4
        BNE.N    ??ProtocolComCheck_11
//  412 				}
//  413 
//  414 #ifdef __SUNWAVE
//  415 		
//  416 #else
//  417 
//  418 #endif
//  419 			Response_Table(nPtr);
??ProtocolComCheck_19:
        MOVS     R0,R4
        BL       Response_Table
        B.N      ??ProtocolComCheck_11
//  420 		break;
//  421 			
//  422 		case ControlQue:
//  423 			if(WRCS_DownLoadGiveupTimerSet(NULL))
??ProtocolComCheck_1:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CBZ      R0,??ProtocolComCheck_20
//  424 			{
//  425 				if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CMP      R0,R4
        BNE.N    ??ProtocolComCheck_11
//  426 			}
//  427 
//  428 			AnalyzeAidData(nPtr, TRUE);
??ProtocolComCheck_20:
        MOVS     R1,#+1
        MOVS     R0,R4
        BL       AnalyzeAidData
//  429 
//  430 #ifdef __SUNWAVE
//  431 			while(TXCUCtrlSendCheck())
//  432 			{						
//  433 				TimerRegist(TimerRmtCtrl, Time100mSec*50L);
//  434 				while(TXCUSendCnt != TXCURecvCnt)
//  435 				{
//  436 					if(TimeOverCheck(TimerRmtCtrl))
//  437 					{
//  438 						break;
//  439 					}
//  440 					OSTimeDly(50L);
//  441 				}
//  442 			}
//  443 			while(SGCUCtrlSendCheck())
//  444 			{						
//  445 				TimerRegist(TimerRmtCtrl, Time100mSec*50L);
//  446 				while(SGCUSendCnt != SGCURecvCnt)
//  447 				{
//  448 					if(TimeOverCheck(TimerRmtCtrl))
//  449 					{
//  450 						break;
//  451 					}
//  452 					OSTimeDly(50L);
//  453 				}
//  454 				}					
//  455 
//  456 			while(PauCtrlSendCheck())
//  457 			{						
//  458 				TimerRegist(TimerRmtCtrl, Time100mSec*50L);
//  459 				while(PAUSendCnt != PAURecvCnt)
//  460 				{
//  461 					if(TimeOverCheck(TimerRmtCtrl))
//  462 					{
//  463 						break;
//  464 					}
//  465 					OSTimeDly(50L);
//  466 				}
//  467 			}
//  468 			#if 0
//  469 			{
//  470 				char tmplcd[36];
//  471 				sprintf(tmplcd, "wr = %02d, rd = %02d", SGCUSendCnt, SGCURecvCnt);
//  472 				cLcd->Replace(tmplcd, 0 * LCDlineSIZE,  strlen(tmplcd));
//  473 				}
//  474 			#endif
//  475 #endif
//  476 			tcnt = GenRepAidSts((INT8U *)sBody->SubData, BeaconSts, nPtr);
        MOVS     R2,R4
        LDR.N    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R1,[R0, #+20]
        ADD      R0,R10,#+7
        BL       GenRepAidSts
        MOVS     R2,R0
//  477 			GenBodyFrame(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        MOVS     R0,R2
        UXTB     R1,R8
        PUSH     {R0,R1}
        ADD      R3,R10,#+7
        B.N      ??ProtocolComCheck_13
//  478 			WRCS_ProDataAckTx(nPtr);
//  479 		break;
//  480 		case StatusQue:
//  481 			//AnalyzeAidData(nPtr, TRUE);
//  482 			tcnt = GenRepAidSts((INT8U *)sBody->SubData, BeaconSts, nPtr);
??ProtocolComCheck_0:
        MOVS     R2,R4
        LDR.N    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R1,[R0, #+20]
        ADD      R0,R10,#+7
        BL       GenRepAidSts
        MOVS     R2,R0
//  483 			GenBodyFrame(id0, id1, id2, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        PUSH     {R0,R1}
        MOVS     R0,R2
        UXTB     R1,R8
        PUSH     {R0,R1}
        ADD      R3,R10,#+7
        B.N      ??ProtocolComCheck_16
//  484 			WRCS_ProDataAckTx(nPtr);
//  485 		break;
//  486 		
//  487 		case DownloadCMD:
//  488 		case DownloadCMDConfirm:
//  489 		case DownLoadData:
//  490 		case DownLoadDataConfirm:		  
//  491 		  if(WRCS_DownLoadGiveupTimerSet(NULL))
??ProtocolComCheck_4:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CBZ      R0,??ProtocolComCheck_21
//  492 		  {
//  493 			  if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CMP      R0,R4
        BNE.N    ??ProtocolComCheck_11
//  494 		  }
//  495 		  WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
??ProtocolComCheck_21:
        MOVS     R0,R4
        BL       WRCS_DownLoadGiveupTimerSet
//  496 		  WRCS_DownloadFunc(nPtr);
        MOVS     R0,R4
        BL       WRCS_DownloadFunc
??ProtocolComCheck_11:
        POP      {R0,R4-R11,PC}   ;; return
        DATA
??ProtocolComCheck_12:
        DC32     0x8006000
        DC32     0x8006040
//  497 		break;
//  498 
//  499 #ifdef __SUNWAVE
//  500 		case Module_DownloadCMD:
//  501 		case Module_DownloadCMDConfirm:
//  502 		case Module_DownLoadData:
//  503 		case Module_DownLoadDataConfirm:
//  504 			if(WRCS_DownLoadGiveupTimerSet(NULL))
//  505 			{
//  506 				if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
//  507 			}
//  508 			WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
//  509 			
//  510 			DnSubID0 = id0;
//  511 			DnSubID1 = id1;
//  512 			DnSubID2 = id2;
//  513 			if(rBody->SubData[2] == TXCUID) {
//  514 				TXCUTransmitData(TXCUID, NULL, (INT8U *)&rBody->SubData[3], (rBody->SubLength - 3), Comm - 0x60, nPtr);
//  515 			}
//  516 			else if(rBody->SubData[2] == SGCUID){
//  517 				SGCUTransmitData(SGCUID, NULL, (INT8U *)&rBody->SubData[3], (rBody->SubLength - 3), Comm - 0x60, nPtr);
//  518 			}
//  519 		break;
//  520 
//  521 		case PAUDownloadCMD:
//  522 		case PAUDownloadCMDConfirm:
//  523 		case PAUDownLoadData:
//  524 		case PAUDownLoadDataConfirm:
//  525 			if(WRCS_DownLoadGiveupTimerSet(NULL))
//  526 			{
//  527 				if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
//  528 			}
//  529 			WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);
//  530 			DnSubID0 = id0;
//  531 			DnSubID1 = id1;
//  532 			DnSubID2 = id2;
//  533 			PauTransmitData(PAU_DstID, NULL, (INT8U *)rBody->SubData, (rBody->SubLength), Comm + 0x60, nPtr);
//  534 		break;
//  535 #endif		
//  536 		default:
//  537 		break;
//  538 	}
//  539 	
//  540 }
//  541 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  542 void GenFrameOneDataTx(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U len, INT8U Comm, __ProtocolPtr *dPtr, __ProtocolPtr *sPtr)
//  543 {
//  544 //	INT8U tid0[3] = {id0, id1, id2};
//  545 	// dptr: destination  ptr
//  546     // sptr: soucre       ptr
//  547 //	     if(dPtr == FskSer) RmtTransmitData(tid0, Data, len, Comm, 
//  548 //									   NULL, NULL, NULL, NULL, sPtr, 0);
//  549 /***
//  550         if(dPtr == Udc1Ser)Udc1TransmitData(id0, id1, id2, Data, len, Comm, sPtr);
//  551 	else if(dPtr == Udc2Ser)Udc2TransmitData(id0, id1, id2, Data, len, Comm, sPtr);
//  552 	else
//  553 	{
//  554 		GenBodyFrame(id0, id1, id2, Data, len, Comm, dPtr, 0);
//  555 		WRCS_ProDataAckTx(dPtr);
//  556 	}
//  557 ****/
//  558 }
GenFrameOneDataTx:
        BX       LR               ;; return
//  559 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  560 void GenBodyFrame(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U nCnt,
//  561 					INT8U Comm, __ProtocolPtr *nPtr, INT8U BodyNo)
//  562 {
GenBodyFrame:
        PUSH     {R3-R7,LR}
        LDRH     R12,[SP, #+24]
        LDRB     LR,[SP, #+28]
        LDR      R5,[SP, #+32]
//  563 	int i = 0;
//  564 	int DataCnt = 0;
        MOVS     R4,#+0
//  565 	
//  566 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R6,[R5, #+32]
//  567 	
//  568 #if TWO_BODY >= 2
//  569 	__BODYFRAME *BodyFrame = &(Send->BodyFrame[BodyNo]);
//  570 #else
//  571 	__BODYFRAME *BodyFrame = &(Send->BodyFrame[0]);
        ADD      R5,R6,#+8
//  572 	BodyNo = 0;
//  573 #endif
//  574 
//  575 	Send->BodyNo = BodyNo;
        MOVS     R7,#+0
        STRB     R7,[R6, #+1046]
//  576 
//  577 	BodyFrame->SubID[0] = id0;
        STRB     R0,[R5, #+0]
//  578 	BodyFrame->SubID[1] = id1;
        STRB     R1,[R5, #+1]
//  579 	BodyFrame->SubID[2] = id2;
        STRB     R2,[R5, #+2]
//  580 
//  581 	BodyFrame->Command = Comm;
        STRB     LR,[R5, #+3]
//  582 	BodyFrame->RCode = 0x2A;
        MOVS     R0,#+42
        STRB     R0,[R5, #+4]
//  583 
//  584 	BodyFrame->SubLength = nCnt;
        STRH     R12,[R5, #+1031]
//  585 	BodyFrame->SubLen[0] = (INT8U)((nCnt) >> 8);
        LSR      R0,R12,#+8
        STRB     R0,[R5, #+5]
//  586 	BodyFrame->SubLen[1] = (INT8U)((nCnt) >> 0);
        STRB     R12,[R5, #+6]
//  587 
//  588 	for(i = 0 ; i < nCnt && i < BODYSIZEMAX; i++)
        MOV      R0,R4
        ADDS     R1,R5,#+7
        B.N      ??GenBodyFrame_0
//  589 	{
//  590 		BodyFrame->SubData[DataCnt++] = Data[i];
??GenBodyFrame_1:
        LDRB     R2,[R3], #+1
        STRB     R2,[R1], #+1
        ADDS     R4,R4,#+1
//  591 	}
        ADDS     R0,R0,#+1
??GenBodyFrame_0:
        CMP      R0,R12
        BGE.N    ??GenBodyFrame_2
        CMP      R0,#+1024
        BLT.N    ??GenBodyFrame_1
//  592 
//  593 	///////////// CRC //
//  594 	{
//  595 		BodyFrame->Crc = Crc16Calc ((INT8U *)BodyFrame->SubID, 7 + i, NULL);
??GenBodyFrame_2:
        ADDW     R6,R5,#+1031
        MOVS     R2,#+0
        ADDS     R1,R0,#+7
        MOVS     R0,R5
        BL       Crc16Calc
        STRH     R0,[R6, #+2]
//  596 		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc >> 8);
        ADDS     R0,R4,R5
        LDRH     R1,[R6, #+2]
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+7]
        ADDS     R0,R4,#+1
//  597 		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc		);
        ADDS     R1,R0,R5
        LDRH     R2,[R6, #+2]
        STRB     R2,[R1, #+7]
//  598 	}
//  599 	BodyFrame->SubData[DataCnt++] = ETX;
        ADDS     R0,R0,R5
        MOVS     R1,#+3
        STRB     R1,[R0, #+8]
//  600 }
        POP      {R0,R4-R7,PC}    ;; return
//  601 
//  602 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  603 void WRCS_ProDataAckTx(__ProtocolPtr *nPtr)
//  604 {
WRCS_ProDataAckTx:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//  605 	INT16U i, Len = 0;
//  606 
//  607 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R5,[R4, #+32]
//  608 #if TWO_BODY >= 2
//  609 	INT8U BodyNo = Send->BodyNo;
//  610 #else
//  611 	INT8U BodyNo = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  612 #endif
//  613 	Send->Sync[0] = STX;
        MOVS     R0,#+22
        STRB     R0,[R5, #+0]
//  614 	Send->Sync[1] = STX;
        STRB     R0,[R5, #+1]
//  615 	Send->Sync[2] = STX;
        STRB     R0,[R5, #+2]
//  616 	Send->Sync[3] = STX;
        STRB     R0,[R5, #+3]
//  617 
//  618 	Send->TryNo= '0';
        MOVS     R0,#+48
        STRB     R0,[R5, #+4]
//  619 
//  620 	Send->BodyLength = 0;
        MOVS     R0,#+0
        STRH     R0,[R5, #+1044]
//  621 
//  622 
//  623 	for(i = 0; i <= BodyNo; i++)
        ADD      R0,R5,#+13
        LDRB     R1,[SP, #+0]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  624 	{
//  625 		Len = ((Send->BodyFrame[i].SubLen[0] << 8) | Send->BodyFrame[i].SubLen[1]) + 5 + 2 + 2;
//  626 		Send->BodyLength += Len;
??WRCS_ProDataAckTx_0:
        LDRH     R2,[R5, #+1044]
        LDRB     R3,[R0, #+0]
        LDRB     R12,[R0, #+1]
        ORR      R3,R12,R3, LSL #+8
        ADDS     R3,R3,#+9
        ADDS     R2,R3,R2
        STRH     R2,[R5, #+1044]
//  627 	}
        ADDW     R0,R0,#+1036
        SUBS     R1,R1,#+1
        BNE.N    ??WRCS_ProDataAckTx_0
//  628 	Send->BodyLen[0] = (INT8U)(Send->BodyLength >> 8);
        LDRH     R0,[R5, #+1044]
        LSRS     R1,R0,#+8
        STRB     R1,[R5, #+5]
//  629 	Send->BodyLen[1] = (INT8U)(Send->BodyLength >> 0);
        STRB     R0,[R5, #+6]
//  630 
//  631 	Send->CheckSum = Send->TryNo + Send->BodyLen[0] + Send->BodyLen[1];
        LDRB     R0,[R5, #+4]
        LDRB     R1,[R5, #+5]
        ADDS     R0,R1,R0
        LDRB     R1,[R5, #+6]
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+7]
//  632 
//  633 
//  634 	if(nPtr == PcSer)
        LDR      R3,[R4, #+8]
        LDR.N    R0,??DataTable29  ;; SerialPadOnFlag
        LDR      R0,[R0, #+12]
        CMP      R4,R0
        BNE.N    ??WRCS_ProDataAckTx_1
//  635 	{
//  636 		nPtr->PutStr((INT8U *)Send, 4 + 1 + 2 + 1, FALSE);
        MOVS     R2,#+0
        MOVS     R1,#+8
        MOVS     R0,R5
        BLX      R3
//  637 
//  638 		for(i = 0; i <= BodyNo; i++)
        MOVS     R6,#+0
        ADDW     R5,R5,#+1039
        B.N      ??WRCS_ProDataAckTx_2
//  639 		{
//  640 			nPtr->PutStr((INT8U *)&Send->BodyFrame[i], Send->BodyFrame[i].SubLength + 7 + 2, FALSE);
??WRCS_ProDataAckTx_3:
        MOVS     R2,#+0
        LDRH     R0,[R5, #+0]
        ADD      R1,R0,#+9
        UXTH     R1,R1
        SUBW     R0,R5,#+1031
        LDR      R3,[R4, #+8]
        BLX      R3
//  641 		}
        ADDS     R6,R6,#+1
        UXTH     R6,R6
        ADDW     R5,R5,#+1036
??WRCS_ProDataAckTx_2:
        LDRB     R0,[SP, #+0]
        CMP      R0,R6
        BCS.N    ??WRCS_ProDataAckTx_3
//  642 
//  643 		BodyNo = ETX;
        MOVS     R0,#+3
        STRB     R0,[SP, #+0]
//  644 		nPtr->PutStr((INT8U *)&BodyNo, 1, TRUE);
        MOVS     R2,#+1
        MOVS     R1,#+1
        ADD      R0,SP,#+0
        LDR      R3,[R4, #+8]
        B.N      ??WRCS_ProDataAckTx_4
//  645 	}
//  646 	else
//  647 	{
//  648 		nPtr->PutStr((INT8U *)Send, (4 + 1 + 2 + 1) + Send->BodyFrame[0].SubLength + 7 + 2 + 1, FALSE);
??WRCS_ProDataAckTx_1:
        MOVS     R2,#+0
        LDRH     R0,[R5, #+1039]
        ADD      R1,R0,#+18
        UXTH     R1,R1
        MOVS     R0,R5
??WRCS_ProDataAckTx_4:
        BLX      R3
//  649 	}
//  650 }
        POP      {R0,R1,R4-R6,PC}  ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable29:
        DC32     SerialPadOnFlag
//  651 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  652 INT16U GenAidData(INT16U Aid, INT8U *dptr, INT8U *sptr, INT16U len)
//  653 {
GenAidData:
        PUSH     {R7,LR}
//  654 	INT8U i = 0;
//  655 	INT8U rval = 0;
//  656 
//  657 	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
        LSR      R12,R0,#+8
        STRB     R12,[R1, #+0]
//  658 	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
        STRB     R0,[R1, #+1]
//  659 	dptr[rval++] = len;
        STRB     R3,[R1, #+2]
        MOVS     R0,#+3
//  660 	for(i = 0; i < len; i++) dptr[rval++] = sptr[i];
        MOV      R12,#+0
        ADDS     R1,R1,#+3
        B.N      ??GenAidData_0
??GenAidData_1:
        LDRB     LR,[R12, R2]
        STRB     LR,[R1], #+1
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADD      R12,R12,#+1
        UXTB     R12,R12
??GenAidData_0:
        CMP      R12,R3
        BCC.N    ??GenAidData_1
//  661 
//  662 	return rval;
        POP      {R1,PC}          ;; return
//  663 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant {0}>`:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "rambackup = %d\012"

        END
//  664 
//  665 
//  666 
//  667 ////////////////////////////////////////////////////////////////////////////////
//  668 // End of Source File
//  669 /////////////////////
//  670 
// 
//   570 bytes in section .bss
// 3 160 bytes in section .data
//    28 bytes in section .rodata
// 2 968 bytes in section .text
// 
// 2 968 bytes of CODE  memory
//    28 bytes of CONST memory
// 3 730 bytes of DATA  memory
//
//Errors: none
//Warnings: none
