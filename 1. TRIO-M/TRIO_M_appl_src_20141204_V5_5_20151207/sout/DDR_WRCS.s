///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:33 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DDR_W /
//                    RCS.c                                                   /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DDR_W /
//                    RCS.c -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_app /
//                    l_src_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_app /
//                    l_src_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl /
//                    _src_20120109\sout\ --endian=little --cpu=Cortex-M3 -e  /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\DDR_W /
//                    RCS.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME DDR_WRCS

        EXTERN AlarmInitialize
        EXTERN AnalyzeAidData
        EXTERN Crc16Calc
        EXTERN DownLoadBootingJump
        EXTERN DownloadFlagSet
        EXTERN FLASHpAPBK_Check_Erase
        EXTERN GenDnrAidSts
        EXTERN LoadBackupData
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ResetCaseBackup
        EXTERN Response_Table_DE
        EXTERN SaveBackupData
        EXTERN SerPtr
        EXTERN SmsSer
        EXTERN TRIO_Initialize
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN UpLoadData
        EXTERN __aeabi_memclr4
        EXTERN memcmp
        EXTERN pUSART1
        EXTERN tTestFlag

        PUBLIC Check_Data_Image
        PUBLIC CtrlSem
        PUBLIC DataCount
        PUBLIC DnImageCheck
        PUBLIC DownLoadGiveupTimerSet
        PUBLIC FrameCnt
        PUBLIC FrameCounter
        PUBLIC FrameCounterOld
        PUBLIC GenAidData
        PUBLIC GenAidData16
        PUBLIC GenBodyFrame
        PUBLIC InitStart
        PUBLIC InvenCheck_time
        PUBLIC PcSer
        PUBLIC PcSerB
        PUBLIC ProtocolCheck
        PUBLIC ProtocolComCheck
        PUBLIC RPcsksio
        PUBLIC RmtCode_Image
        PUBLIC SPcsksio
        PUBLIC Ser1TaskStk
        PUBLIC SerialPadOnFlag
        PUBLIC Swcrc16
        PUBLIC TotFrame
        PUBLIC WRCSTask
        PUBLIC WRCS_DownLoadGiveupTimerChk
        PUBLIC WRCS_DownLoadGiveupTimerRst
        PUBLIC WRCS_DownloadFunc
        PUBLIC WRCS_ProDataAckTx
        PUBLIC WRCS_ReceiveData
        PUBLIC WRCS_SerInit
        PUBLIC WhatRxComm
        PUBLIC chkDownLoad
        PUBLIC downloadFlag
        PUBLIC iDebugCnt
        PUBLIC iRepeaterType
        PUBLIC iUser_Value2
        PUBLIC tDnrSts
        PUBLIC tDnrStsB
        PUBLIC ustrcmp

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DDR_WRCS.c
//    1 
//    2 /*********************************************
//    3 * File Name          : usart1_vx.x.c
//    4 * Author             : 
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
// __Dnr_Sts __data tDnrStsB
tDnrStsB:
        DS8 884

        SECTION `.bss`:DATA:NOROOT(0)
// BOOL __data SerialPadOnFlag
SerialPadOnFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkDownLoad
chkDownLoad:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DnImageCheck
DnImageCheck:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data InvenCheck_time
InvenCheck_time:
        DS8 2

        SECTION `.data`:DATA:NOROOT(2)
// static INT8U __data ImgKind
ImgKind:
        DATA
        DC8 0
// INT8U __data iDebugCnt
iDebugCnt:
        DC8 0
// INT8U __data iUser_Value2
iUser_Value2:
        DC8 0
// INT8U __data iRepeaterType
iRepeaterType:
        DC8 0
//   14 #include "download.c"
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
// struct os_event *__data CtrlSem
CtrlSem:
        DC32 0H
// __Dnr_Sts *__data tDnrSts
tDnrSts:
        DC32 tDnrStsB
// INT32U __data downloadFlag
downloadFlag:
        DC32 0
// unsigned char const *__data RmtCode_Image
RmtCode_Image:
        DC32 `?<Constant "##GSI#DE-O#RMT#RCU#20...">`
// INT32S __data DataCount
DataCount:
        DC32 -1
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
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data InitStart
InitStart:
        DATA
        DC8 1

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
// __??Code16?? __code __interwork INT32U DownLoadGiveupTimerSet(INT32U)
DownLoadGiveupTimerSet:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable21  ;; ImgKind
        CBZ      R0,??DownLoadGiveupTimerSet_0
        STR      R0,[R4, #+24]
        MOVW     R1,#+30000
        MOVS     R0,#+4
        BL       TimerRegist
??DownLoadGiveupTimerSet_0:
        LDR      R0,[R4, #+24]
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void WRCS_DownLoadGiveupTimerRst(void)
WRCS_DownLoadGiveupTimerRst:
        LDR.W    R0,??DataTable21  ;; ImgKind
        MOVS     R1,#+0
        STR      R1,[R0, #+24]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork BOOL WRCS_DownLoadGiveupTimerChk(__ProtocolPtr *)
WRCS_DownLoadGiveupTimerChk:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable21  ;; ImgKind
        LDR      R1,[R4, #+12]
        CMP      R0,R1
        BNE.N    ??WRCS_DownLoadGiveupTimerChk_0
        MOVS     R0,#+4
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
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+12
        MOV      R4,R0
        LDR      R0,[R4, #+28]
        LDRB     R1,[R0, #+1723]
        MOV      R2,#+1712
        MLA      R0,R1,R2,R0
        ADD      R5,R0,#+8
        LDR.N    R6,??WRCS_DownloadFunc_0  ;; `?<Constant {0}>`
        ADD      R0,SP,#+0
        LDM      R6!,{R1-R3}
        STM      R0!,{R1-R3}
        SUBS     R6,R6,#+12
        MOVS     R7,#+0
        LDRB     R11,[R5, #+0]
        LDRB     R9,[R5, #+1]
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
        LDR.W    R1,??DataTable21  ;; ImgKind
        STRH     R0,[R1, #+6]
        B.N      ??WRCS_DownloadFunc_5
??WRCS_DownloadFunc_2:
        BL       OS_CPU_SR_Save
        MOV      R10,R0
        BL       FLASHpAPBK_Check_Erase
        CBNZ     R0,??WRCS_DownloadFunc_6
        MOVS     R0,#+1
        STRB     R0,[SP, #+0]
        B.N      ??WRCS_DownloadFunc_7
??WRCS_DownloadFunc_6:
        STRB     R7,[SP, #+0]
??WRCS_DownloadFunc_7:
        MOVS     R7,#+1
        MOV      R0,R10
        BL       OS_CPU_SR_Restore
        B.N      ??WRCS_DownloadFunc_5
??WRCS_DownloadFunc_3:
        MOV      R0,R4
        BL       WRCS_ReceiveData
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        LSRS     R0,R0,#+31
        STRB     R0,[SP, #+0]
        LDR.W    R7,??DataTable21  ;; ImgKind
        LDRH     R0,[R7, #+4]
        ADD      R1,SP,#+0
        LSRS     R2,R0,#+8
        STRB     R2,[R1, #+1]
        STRB     R0,[R1, #+2]
        MOVS     R7,#+3
        B.N      ??WRCS_DownloadFunc_5
??WRCS_DownloadFunc_4:
        LDR.W    R7,??DataTable21  ;; ImgKind
        LDRH     R0,[R7, #+8]
        LDRB     R1,[R5, #+9]
        LDRB     R2,[R5, #+10]
        ORR      R1,R2,R1, LSL #+8
        CMP      R0,R1
        BNE.N    ??WRCS_DownloadFunc_8
        LDRH     R1,[R7, #+6]
        LDRH     R2,[R7, #+4]
        ADDS     R2,R2,#+1
        CMP      R1,R2
        BNE.N    ??WRCS_DownloadFunc_8
        MOVS     R1,#+0
        B.N      ??WRCS_DownloadFunc_9
??WRCS_DownloadFunc_8:
        MOVS     R1,#+1
??WRCS_DownloadFunc_9:
        STRB     R1,[SP, #+0]
        LDRH     R2,[R7, #+6]
        ADD      R1,SP,#+0
        LSRS     R3,R2,#+8
        STRB     R3,[R1, #+1]
        STRB     R2,[R1, #+2]
        LSRS     R2,R0,#+8
        STRB     R2,[R1, #+3]
        STRB     R0,[R1, #+4]
        MOVS     R7,#+5
??WRCS_DownloadFunc_5:
        MOVS     R1,#+0
        MOV      R0,R4
        PUSH     {R0,R1}
        LDRB     R1,[R5, #+3]
        MOV      R0,R7
        PUSH     {R0,R1}
        ADD      R3,SP,#+16
        MOV      R2,R8
        MOV      R1,R9
        MOV      R0,R11
        BL       GenBodyFrame
        ADD      SP,SP,#+16
        MOV      R0,R4
        BL       WRCS_ProDataAckTx
        LDRB     R0,[R5, #+3]
        CMP      R0,#+14
        BNE.N    ??WRCS_DownloadFunc_10
        MOVS     R0,#+100
        BL       OSTimeDly
        LDR.W    R7,??DataTable21  ;; ImgKind
        LDR      R0,[R7, #+20]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+4
        BNE.N    ??WRCS_DownloadFunc_11
        LDRB     R1,[SP, #+0]
        LDRH     R0,[R7, #+4]
        ADDS     R0,R0,#+1
        PUSH     {R0,R1}
        LDRH     R3,[R7, #+6]
        LDRB     R0,[R5, #+9]
        LDRB     R1,[R5, #+10]
        ORR      R2,R1,R0, LSL #+8
        LDRH     R1,[R7, #+8]
        ADD      R0,R6,#+12
        LDR.W    R4,??DataTable20  ;; SerPtr
        LDR      R4,[R4, #+0]
        LDR      R4,[R4, #+16]
        BLX      R4
        ADD      SP,SP,#+8
??WRCS_DownloadFunc_11:
        LDRB     R0,[SP, #+0]
        CMP      R0,#+0
        BNE.N    ??WRCS_DownloadFunc_10
        LDR.N    R0,??WRCS_DownloadFunc_0+0x4  ;; 0x1ffff7e0
        LDRH     R1,[R0, #+0]
        SUBS     R1,R1,#+28
        LDRH     R2,[R0, #+0]
        SUBS     R2,R2,#+28
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R1,R1,R1, LSR #+31
        ASRS     R1,R1,#+1
        LDR.N    R3,??WRCS_DownloadFunc_0+0x8  ;; 0x8007000
        ADD      R1,R3,R1, LSL #+10
        ADD      R2,R2,R2, LSR #+31
        ASRS     R2,R2,#+1
        LSLS     R2,R2,#+10
        LDR.N    R3,??WRCS_DownloadFunc_0+0xC  ;; 0x8007028
        LDR      R2,[R3, R2]
        ADDS     R1,R2,R1
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LSLS     R0,R0,#+10
        LDR.N    R2,??WRCS_DownloadFunc_0+0x10  ;; 0x8007024
        LDR      R0,[R2, R0]
        SUBS     R4,R1,R0
        MOVS     R0,#+100
        BL       OSTimeDly
        LDR      R0,[R7, #+20]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+4
        BNE.N    ??WRCS_DownloadFunc_12
        ADD      R0,R4,#+30
        PUSH     {R0,LR}
        ADD      R3,R4,#+20
        ADD      R2,R4,#+10
        MOV      R1,R4
        ADD      R0,R6,#+60
        LDR.W    R5,??DataTable20  ;; SerPtr
        LDR      R5,[R5, #+0]
        LDR      R5,[R5, #+16]
        BLX      R5
        ADD      SP,SP,#+8
??WRCS_DownloadFunc_12:
        MOVS     R2,#+6
        ADD      R1,R6,#+92
        MOV      R0,R4
        BL       memcmp
        CBNZ     R0,??WRCS_DownloadFunc_10
        MOVS     R0,#+2
        BL       ResetCaseBackup
        MOVS     R0,#+100
        BL       OSTimeDly
        LDR      R0,[R7, #+32]
        BL       DownloadFlagSet
        BL       DownLoadBootingJump
??WRCS_DownloadFunc_10:
        MOVS     R0,#+1
        ADD      SP,SP,#+12
        POP      {R4-R11,PC}      ;; return
        DATA
??WRCS_DownloadFunc_0:
        DC32     `?<Constant {0}>`
        DC32     0x1ffff7e0
        DC32     0x8007000
        DC32     0x8007028
        DC32     0x8007024

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork BOOL WRCS_ReceiveData(__ProtocolPtr *)
WRCS_ReceiveData:
        PUSH     {R4-R8,LR}
        LDR      R1,[R0, #+28]
        LDRB     R2,[R1, #+1723]
        MOV      R3,#+1712
        MLA      R1,R2,R3,R1
        ADD      R4,R1,#+8
        MOVS     R1,#+0
        LDRB     R2,[R4, #+7]
        ADDS     R3,R4,#+7
        LDRB     R3,[R3, #+1]
        ORRS     R5,R3,R2, LSL #+8
        LDR.W    R6,??DataTable21  ;; ImgKind
        BNE.N    ??WRCS_ReceiveData_0
        LDRB     R2,[R6, #+0]
        CBZ      R2,??WRCS_ReceiveData_1
        MOVS     R1,#+32
??WRCS_ReceiveData_1:
        MOVS     R2,#+0
        STR      R2,[R6, #+32]
        STRH     R2,[R6, #+8]
??WRCS_ReceiveData_2:
        LDRH     R2,[R4, #+1707]
        SUBS     R7,R2,#+2
        ADDS     R3,R1,R4
        SUBS     R1,R7,R1
        LDR      R2,[R6, #+32]
        UXTH     R1,R1
        ADD      R0,R3,#+9
        B.N      ??WRCS_ReceiveData_3
??WRCS_ReceiveData_0:
        LDRH     R2,[R6, #+4]
        ADDS     R7,R2,#+1
        CMP      R5,R7
        BEQ.N    ??WRCS_ReceiveData_4
        B.N      ?Subroutine0
??WRCS_ReceiveData_4:
        CMP      R5,R2
        BNE.N    ??WRCS_ReceiveData_2
        B.N      ??WRCS_ReceiveData_5
??WRCS_ReceiveData_3:
        BL       UpLoadData
        MOV      R8,R0
        STR      R0,[R6, #+32]
        LDRH     R2,[R6, #+8]
        MOV      R1,R7
        ADD      R0,R4,#+9
        BL       Crc16Calc
        STRH     R0,[R6, #+8]
        STRH     R5,[R6, #+4]
        MOV      R0,#-1
        CMP      R8,R0
        BNE.N    ??WRCS_ReceiveData_5
        B.N      ?Subroutine0
??WRCS_ReceiveData_5:
        MOVS     R0,#+1
        POP      {R4-R8,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        MOVS     R0,#+0
        POP      {R4-R8,PC}
//   15 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   16 void WRCS_SerInit(void)
//   17 {
WRCS_SerInit:
        PUSH     {R4-R6,LR}
//   18  	PcSer->CheckByte = pUSART1.CheckByte;
        LDR.W    R4,??DataTable21  ;; ImgKind
        LDR      R0,[R4, #+12]
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
        ADD      R1,R4,#+2784
        STR      R1,[R0, #+28]
//   25 	PcSer->WRCSSend = &SPcsksio;
        ADDW     R1,R4,#+1060
        STR      R1,[R0, #+32]
//   26 	
//   27 	CtrlSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        STR      R0,[R4, #+16]
//   28  	OSTaskCreate(WRCSTask, (void *)NULL, (OS_STK *)&Ser1TaskStk[SER1_STK_SIZE - 1], SER0TASK_PRIO);
        MOVS     R3,#+2
        ADD      R2,R4,#+1056
        MOVS     R1,#+0
        LDR.N    R0,??WRCS_SerInit_0+0x4  ;; WRCSTask
        BL       OSTaskCreate
//   29 	LoadBackupData();	// default setting!!
        BL       LoadBackupData
//   30 	TRIO_Initialize();
        BL       TRIO_Initialize
//   31 	AlarmInitialize();
        BL       AlarmInitialize
//   32 		
//   33 
//   34 	SerPtr->printf(" TRIO-M VER:%d.%d.%d-->Type[%d] :[%d]\n", (SystemVer >> 4)& 0x0f, SystemVer & 0x0f,PROGRAMVER & 0x0f,iRepeaterType,sizeof(__Dnr_Sts));
        LDR.W    R5,??DataTable20  ;; SerPtr
        LDR.N    R6,??WRCS_SerInit_0+0x8  ;; `?<Constant " TRIO-M VER:%d.%d.%d-...">`
        MOV      R1,#+884
        LDRB     R0,[R4, #+3]
        PUSH     {R0,R1}
        MOVS     R3,#+1
        MOVS     R2,#+1
        MOVS     R1,#+0
        MOV      R0,R6
        LDR      R4,[R5, #+0]
        LDR      R4,[R4, #+16]
        BLX      R4
        ADD      SP,SP,#+8
//   35 //	SerPtr->printf(" sizeof:[%d]:[%d][%d]:[%d]\n", sizeof(__OutputTable),sizeof(__AttnOffsetTable),sizeof(__Attn1OffsetTable),sizeof(__AttnTempTable));
//   36 	SerPtr->printf(" sizeof:[%d][%d][%d]:[%d]\n", sizeof(EE_TABLE),sizeof(EE_BACK1),sizeof(EE_TABLE1),sizeof(__BackupStr));
        MOVS     R0,#+221
        PUSH     {R0,LR}
        MOVW     R3,#+1954
        MOVW     R2,#+2038
        MOVW     R1,#+2020
        ADD      R0,R6,#+40
        LDR      R4,[R5, #+0]
        LDR      R4,[R4, #+16]
        BLX      R4
        ADD      SP,SP,#+8
//   37 //	SerPtr->printf(" Local:[%d][%d]:[%d]:[%d][%d]\n",Local_Rvs1InPwr_LTE_A,Local_OtherRvs1InPwr_LTE_A,Local_Rvs1TempAttn_LTE_A,Local_RvsAttn1_Common,Local_Rvs1Attn4_LTE_A);
//   38 
//   39 //	SerPtr->printf(" Index_RvsOutPwr_3G:[%d]\n",Index_FwdTempAttn_2G);
//   40 
//   41 
//   42 
//   43 }
        POP      {R4-R6,PC}       ;; return
        DATA
??WRCS_SerInit_0:
        DC32     pUSART1
        DC32     WRCSTask
        DC32     `?<Constant " TRIO-M VER:%d.%d.%d-...">`
//   44 
//   45 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   46 void WRCSTask(void *pdata)
//   47 {
WRCSTask:
        PUSH     {R3-R5,LR}
//   48 	__ProtocolPtr *nPtr = (__ProtocolPtr *)PcSer;
        LDR.W    R0,??DataTable21  ;; ImgKind
        LDR      R4,[R0, #+12]
//   49 
//   50 	pdata = pdata;
        LDR.N    R5,??WRCSTask_0  ;; tTestFlag
//   51 
//   52 	while(1)
//   53 	{
//   54 		nPtr->WRCSRecv->cBody = 0;
??WRCSTask_1:
        LDR      R0,[R4, #+28]
        MOVS     R1,#+0
        STRB     R1,[R0, #+1723]
//   55 	
//   56 		if(!tTestFlag)
        LDRB     R0,[R5, #+0]
        CBNZ     R0,??WRCSTask_2
//   57 		{
//   58 			if(ProtocolCheck(nPtr))
        MOV      R0,R4
        BL       ProtocolCheck
        CBZ      R0,??WRCSTask_2
//   59 			{
//   60 			#if TWO_BODY >= 2
//   61 				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   62 				{
//   63 			#endif
//   64  					ProtocolComCheck(nPtr);
        MOV      R0,R4
        BL       ProtocolComCheck
//   65 			#if TWO_BODY >= 2
//   66 					nPtr->WRCSRecv->cBody++;
//   67 				}
//   68 			#endif
//   69 			}			
//   70 		}
//   71 		WRCS_DownLoadGiveupTimerChk(nPtr);
??WRCSTask_2:
        MOV      R0,R4
        BL       WRCS_DownLoadGiveupTimerChk
//   72 		OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
        B.N      ??WRCSTask_1
        Nop      
        DATA
??WRCSTask_0:
        DC32     tTestFlag
//   73 	}
//   74 }
//   75 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   76 INT32U ProtocolCheck(__ProtocolPtr *nPtr)
//   77 {
ProtocolCheck:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
//   78 	INT16U nInitCnt, nCnt;
//   79 	INT16U i = 0;
//   80 	INT16U Data;
//   81 	INT8U Temp;
//   82 
//   83 	__WRCSSIO *Recv = nPtr->WRCSRecv;
        LDR      R5,[R4, #+28]
//   84 
//   85 	TimerRegist(nPtr->TimerRx, Time1Sec*2L);
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
        LDR.N    R6,??ProtocolCheck_0  ;; 0x927c0
        B.N      ??ProtocolCheck_1
//   86 	while(1)
//   87 	{
//   88 		if(TimeOverCheck(nPtr->TimerRx)) return FALSE;
//   89 	
//   90 		if(nPtr->CheckByte(4, &nCnt))
//   91 		{
//   92 			Temp = nPtr->RxGetByte();
//   93 
//   94 			if (  (STX == Temp )
//   95 				&&(STX == nPtr->RxGetByte())
//   96 				&&(STX == nPtr->RxGetByte())
//   97 				&&(STX == nPtr->RxGetByte()))
//   98 			{
//   99 				Recv->Sync[0] = STX;
//  100 				Recv->Sync[1] = STX;
//  101 				Recv->Sync[2] = STX;
//  102 				Recv->Sync[3] = STX;
//  103 
//  104 				Recv->BodyNo = 0; // Default: 1EA
//  105 				break;
//  106 			}
//  107  			{
//  108 				if((nPtr == PcSer)&&(downloadFlag == 0))
//  109 				{
//  110 					if((Temp == 'x')||(Temp == 'X'))
//  111 					{
//  112 						iDebugCnt++;
//  113 						
//  114 						if(iDebugCnt > 20)
//  115 						{
//  116 							iUser_Value2 = __ChangeDebug;
//  117 							iDebugCnt = 0; 
//  118 							TimerRegist(Timer_DebugCnt, Time1Min*10L);
//  119 						}
//  120 					}
//  121 				}				
//  122 			}
//  123  		}
//  124 		else OSTimeDly(10L);
??ProtocolCheck_2:
        MOVS     R0,#+10
        BL       OSTimeDly
??ProtocolCheck_1:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_3
??ProtocolCheck_4:
        B.N      ?Subroutine1
??ProtocolCheck_3:
        ADD      R1,SP,#+0
        MOVS     R0,#+4
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_2
        LDR      R0,[R4, #+4]
        BLX      R0
        UXTB     R7,R0
        CMP      R7,#+22
        BNE.N    ??ProtocolCheck_5
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??ProtocolCheck_5
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??ProtocolCheck_5
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??ProtocolCheck_5
        STRB     R0,[R5, #+0]
        STRB     R0,[R5, #+1]
        STRB     R0,[R5, #+2]
        STRB     R0,[R5, #+3]
        ADD      R6,R5,#+1720
        MOVS     R0,#+0
        STRB     R0,[R6, #+2]
//  125 	}
//  126 
//  127 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  128 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??ProtocolCheck_6
??ProtocolCheck_5:
        LDR.W    R0,??DataTable21  ;; ImgKind
        LDR      R1,[R0, #+12]
        CMP      R4,R1
        BNE.N    ??ProtocolCheck_1
        LDR      R1,[R0, #+24]
        CMP      R1,#+0
        BNE.N    ??ProtocolCheck_1
        CMP      R7,#+120
        BEQ.N    ??ProtocolCheck_7
        CMP      R7,#+88
        BNE.N    ??ProtocolCheck_1
??ProtocolCheck_7:
        LDRB     R1,[R0, #+1]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+1]
        UXTB     R1,R1
        CMP      R1,#+21
        BCC.N    ??ProtocolCheck_1
        MOVS     R1,#+13
        STRB     R1,[R0, #+2]
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
        MOV      R1,R6
        MOVS     R0,#+8
        BL       TimerRegist
        B.N      ??ProtocolCheck_1
//  129 	while(!nPtr->CheckByte(4, &nCnt))
//  130 	{
//  131 		if(TimeOverCheck(nPtr->TimerRx))
//  132 		{
//  133 			if(nCnt > nInitCnt)
//  134 			{
//  135 				nInitCnt = nCnt;
??ProtocolCheck_8:
        STRH     R1,[SP, #+2]
//  136 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  137 			}
//  138 			else return FALSE;
//  139 		}
//  140 		OSTimeDly(10L);
??ProtocolCheck_9:
        MOVS     R0,#+10
        BL       OSTimeDly
??ProtocolCheck_6:
        ADD      R1,SP,#+0
        MOVS     R0,#+4
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ     R0,??ProtocolCheck_10
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_9
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCC.N    ??ProtocolCheck_8
        B.N      ??ProtocolCheck_4
//  141 	}
//  142 	
//  143 	Recv->TryNo 		= nPtr->RxGetByte();
??ProtocolCheck_10:
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+4]
//  144 	Recv->BodyLen[0]	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+5]
//  145 	Recv->BodyLen[1]	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+6]
//  146 	Recv->CheckSum		= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R5, #+7]
//  147 
//  148 	Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);
        LDRB     R0,[R5, #+5]
        LDRB     R1,[R5, #+6]
        ADD      R0,R1,R0, LSL #+8
        ADD      R1,R5,#+1720
        STRH     R0,[R1, #+0]
//  149 
//  150 	if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
//  151 		|| (Recv->BodyLength >= (TWO_BODY*BODYSIZEMAX))
//  152 	)
        LDRB     R0,[R5, #+7]
        LDRB     R1,[R5, #+4]
        LDRB     R2,[R5, #+5]
        ADDS     R1,R2,R1
        LDRB     R2,[R5, #+6]
        ADDS     R1,R2,R1
        UXTB     R1,R1
        CMP      R0,R1
        BNE.N    ??ProtocolCheck_11
        MOVW     R8,#+1700
        ADD      R0,R5,#+1720
        LDRH     R0,[R0, #+0]
        CMP      R0,R8
        BCC.N    ??ProtocolCheck_12
//  153 	{								
//  154 		return FALSE;
??ProtocolCheck_11:
        B.N      ?Subroutine1
//  155 	}
//  156     
//  157 #if TWO_BODY >= 2
//  158 BODYRE:
//  159 #endif
//  160 	TimerRegist(nPtr->TimerRx, Time1Sec*2);
??ProtocolCheck_12:
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  161 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??ProtocolCheck_13
//  162 	while(1)
//  163 	{
//  164 		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
//  165 		{
//  166 			if(nCnt > nInitCnt)
//  167 			{
//  168 				nInitCnt = nCnt;
//  169 				TimerRegist(nPtr->TimerRx, Time100mSec);
//  170 			}
//  171 			else
//  172 			{
//  173 				return FALSE;
//  174 			}
//  175 		}
//  176 		if(nPtr->CheckByte(7, &nCnt))
//  177 		{
//  178 			break;// include 0x03
//  179 		}
//  180 		OSTimeDly(20L);
??ProtocolCheck_14:
        MOVS     R0,#+20
        BL       OSTimeDly
??ProtocolCheck_13:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??ProtocolCheck_15
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.N    ??ProtocolCheck_11
        STRH     R1,[SP, #+2]
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
??ProtocolCheck_15:
        ADD      R1,SP,#+0
        MOVS     R0,#+7
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_14
//  181 	}
//  182 	
//  183 	for(i = 0; i < 7 ; i++)
        MOVS     R7,#+0
        MOV      R9,#+1712
//  184 	{
//  185 		*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubID + i) = nPtr->RxGetByte();
??ProtocolCheck_16:
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        ADD      R10,R7,R0
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R10, #+8]
//  186 	}
        ADDS     R7,R7,#+1
        UXTH     R0,R7
        CMP      R0,#+7
        BCC.N    ??ProtocolCheck_16
//  187 
//  188 	Recv->BodyFrame[Recv->BodyNo].SubLength
//  189 		=	 ((Recv->BodyFrame[Recv->BodyNo].SubLen[0] << 8)& 0xff00)
//  190 		  +  ((Recv->BodyFrame[Recv->BodyNo].SubLen[1] << 0)& 0x00ff);
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R9,R5
        LDRB     R1,[R1, #+13]
        LDRB     R2,[R6, #+2]
        MLA      R2,R2,R9,R5
        LDRB     R2,[R2, #+14]
        ADD      R1,R2,R1, LSL #+8
        STRH     R1,[R0, #+1715]
//  191 
//  192 	if(Recv->BodyFrame[Recv->BodyNo].SubLength >= BODYSIZEMAX)	return FALSE;	
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        LDRH     R0,[R0, #+1715]
        CMP      R0,R8
        BCS.W    ??ProtocolCheck_4
//  193 
//  194 
//  195 	TimerRegist(nPtr->TimerRx, Time1Sec*2);
        MOV      R1,#+2000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  196 
//  197 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??ProtocolCheck_17
//  198 	while(1)
//  199 	{
//  200 		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
//  201 		{
//  202 			if(nCnt > nInitCnt)
//  203 			{
//  204 				nInitCnt = nCnt;
//  205 				TimerRegist(nPtr->TimerRx, Time100mSec);
//  206 			}
//  207 			else
//  208 			{
//  209 				return FALSE;
//  210 			}
//  211 		}
//  212 		if(nPtr->CheckByte((INT16U)(Recv->BodyFrame[Recv->BodyNo].SubLength + 2), &nCnt))
//  213 		{
//  214 			break;// include 0x03
//  215 		}
//  216 		OSTimeDly(20L);
??ProtocolCheck_18:
        MOVS     R0,#+20
        BL       OSTimeDly
??ProtocolCheck_17:
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??ProtocolCheck_19
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCS.W    ??ProtocolCheck_4
        STRH     R1,[SP, #+2]
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
??ProtocolCheck_19:
        ADD      R1,SP,#+0
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        LDRH     R0,[R0, #+1715]
        ADDS     R0,R0,#+2
        UXTH     R0,R0
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_18
//  217 	}
//  218 	for(i = 0; i < Recv->BodyFrame[Recv->BodyNo].SubLength + 2; i++)
        MOVS     R7,#+0
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        LDRH     R0,[R0, #+1715]
        ADDS     R0,R0,#+2
        CMP      R0,#+1
        BLT.N    ??ProtocolCheck_20
//  219 	{
//  220 	    *((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubData + i) = nPtr->RxGetByte();
??ProtocolCheck_21:
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R9,R5
        ADD      R8,R7,R1
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R8, #+15]
//  221 	}
        ADDS     R0,R7,#+1
        UXTH     R7,R0
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R9,R5
        LDRH     R1,[R1, #+1715]
        ADDS     R1,R1,#+2
        CMP      R7,R1
        BLT.N    ??ProtocolCheck_21
//  222 
//  223 
//  224 	Recv->BodyFrame[Recv->BodyNo].Crc= Crc16Calc ( &(Recv->BodyFrame[Recv->BodyNo].SubID[0])
//  225 						                            , Recv->BodyFrame[Recv->BodyNo].SubLength + 5 + 2, NULL);
??ProtocolCheck_20:
        LDRB     R0,[R6, #+2]
        MLA      R8,R0,R9,R5
        MOVS     R2,#+0
        MLA      R0,R0,R9,R5
        LDRH     R0,[R0, #+1715]
        ADDS     R1,R0,#+7
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        ADDS     R0,R0,#+8
        BL       Crc16Calc
        STRH     R0,[R8, #+1717]
//  226 	Recv->BodyFrame[Recv->BodyNo].CrcOK = TRUE;
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        MOVS     R1,#+1
        STRB     R1,[R0, #+1719]
//  227 
//  228 	Data = Recv->BodyFrame[Recv->BodyNo].SubLength;
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        LDRH     R0,[R0, #+1715]
//  229 
//  230 	if (   ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc >> 8)!= Recv->BodyFrame[Recv->BodyNo].SubData[Data  ] )
//  231 		|| ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc     )!= Recv->BodyFrame[Recv->BodyNo].SubData[Data+1] )  )
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R9,R5
        LDRH     R1,[R1, #+1717]
        LSRS     R1,R1,#+8
        LDRB     R2,[R6, #+2]
        MLA      R2,R2,R9,R5
        ADDS     R2,R0,R2
        LDRB     R2,[R2, #+15]
        CMP      R1,R2
        BNE.N    ??ProtocolCheck_22
        LDRB     R1,[R6, #+2]
        MLA      R1,R1,R9,R5
        LDRH     R1,[R1, #+1717]
        LDRB     R2,[R6, #+2]
        MLA      R2,R2,R9,R5
        ADDS     R0,R0,R2
        LDRB     R0,[R0, #+16]
        UXTB     R1,R1
        CMP      R1,R0
        BEQ.N    ??ProtocolCheck_23
//  232 	{
//  233 		//CRC ERROR!!
//  234 		Recv->BodyFrame[Recv->BodyNo].CrcOK = FALSE;
??ProtocolCheck_22:
        LDRB     R0,[R6, #+2]
        MLA      R0,R0,R9,R5
        MOVS     R1,#+0
        STRB     R1,[R0, #+1719]
//  235 		return TRUE;
        B.N      ??ProtocolCheck_24
//  236 	}
//  237 
//  238 #if TWO_BODY >= 2
//  239 	if(!Recv->BodyNo)
//  240 	{
//  241 		if(Recv->BodyLength != (Recv->BodyFrame[Recv->BodyNo].SubLength
//  242 															  + 5 + 2 + 2))
//  243 		{
//  244 			Recv->BodyNo++;
//  245 			goto BODYRE;
//  246 		}
//  247 	}
//  248 #endif	
//  249 ////////////////////////////////////////////////////////////////////////////////
//  250 
//  251 	TimerRegist(nPtr->TimerRx, Time1Sec);
??ProtocolCheck_23:
        MOV      R1,#+1000
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  252 	nPtr->CheckByte(1, &nInitCnt);
        ADD      R1,SP,#+2
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        B.N      ??ProtocolCheck_25
//  253 	while(!nPtr->CheckByte(1, &nCnt))
//  254 	{
//  255 		if(TimeOverCheck(nPtr->TimerRx))
//  256 		{
//  257 			if(nCnt > nInitCnt)
//  258 			{
//  259 				nInitCnt = nCnt;
??ProtocolCheck_26:
        STRH     R1,[SP, #+2]
//  260 				TimerRegist(nPtr->TimerRx, Time100mSec);
        MOVS     R1,#+100
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimerRegist
//  261 			}
//  262 			else
//  263 			{
//  264 				return FALSE;
//  265 			}
//  266 		}
//  267 		OSTimeDly(10L);
??ProtocolCheck_27:
        MOVS     R0,#+10
        BL       OSTimeDly
??ProtocolCheck_25:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBNZ     R0,??ProtocolCheck_28
        LDRH     R0,[R4, #+20]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_27
        LDRH     R0,[SP, #+2]
        LDRH     R1,[SP, #+0]
        CMP      R0,R1
        BCC.N    ??ProtocolCheck_26
        B.N      ??ProtocolCheck_11
//  268 	}
//  269 	Data = nPtr->RxGetByte();
??ProtocolCheck_28:
        LDR      R0,[R4, #+4]
        BLX      R0
        UXTH     R0,R0
//  270 
//  271 	if(Data != ETX)
        CMP      R0,#+3
        BNE.W    ??ProtocolCheck_4
//  272 	{
//  273 		return FALSE;
//  274 	}
//  275 	return TRUE;
??ProtocolCheck_24:
        MOVS     R0,#+1
        POP      {R1,R2,R4-R10,PC}  ;; return
        Nop      
        DATA
??ProtocolCheck_0:
        DC32     0x927c0
//  276 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        MOVS     R0,#+0
        POP      {R1,R2,R4-R10,PC}
//  277 
//  278 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  279 INT16U WhatRxComm(__ProtocolPtr *nPtr)
//  280 {
//  281 	INT16U RetVal = 0;
//  282 	INT8U cBody = nPtr->WRCSRecv->cBody;
WhatRxComm:
        LDR      R0,[R0, #+28]
        LDRB     R1,[R0, #+1723]
//  283 	
//  284 	if(nPtr->WRCSRecv->BodyFrame[cBody].CrcOK)
        MOV      R2,#+1712
        MLA      R0,R1,R2,R0
        LDRB     R1,[R0, #+1719]
        CMP      R1,#+0
        BEQ.N    ??WhatRxComm_0
//  285 	{
//  286 		RetVal = nPtr->WRCSRecv->BodyFrame[cBody].Command;
        LDRB     R0,[R0, #+11]
        BX       LR
//  287 	}
//  288 	else //NO ERROR
//  289 	{
//  290 		//ERROR CASE
//  291 		RetVal = AlarmSCODE;
??WhatRxComm_0:
        MOVS     R0,#+2
//  292 	}
//  293     return (RetVal);
        BX       LR               ;; return
//  294 }
//  295 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  296 void GenBodyFrame(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U nCnt,
//  297 					INT8U Comm, __ProtocolPtr *nPtr, INT8U BodyNo)
//  298 {
GenBodyFrame:
        PUSH     {R3-R7,LR}
        LDR      R6,[SP, #+24]
        LDR      R7,[SP, #+28]
        LDR      R5,[SP, #+32]
//  299 	int i = 0;
//  300 	int DataCnt = 0;
        MOVS     R4,#+0
//  301 	
//  302 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R12,[R5, #+32]
//  303 	
//  304 #if TWO_BODY >= 2
//  305 	__BODYFRAME *BodyFrame = &(Send->BodyFrame[BodyNo]);
//  306 #else
//  307 	__BODYFRAME *BodyFrame = &(Send->BodyFrame[0]);
        ADD      R5,R12,#+8
//  308 	BodyNo = 0;
//  309 #endif
//  310 
//  311 	Send->BodyNo = BodyNo;
        STRB     R4,[R12, #+1722]
//  312 
//  313 	BodyFrame->SubID[0] = id0;
        STRB     R0,[R5, #+0]
//  314 	BodyFrame->SubID[1] = id1;
        STRB     R1,[R5, #+1]
//  315 	BodyFrame->SubID[2] = id2;
        STRB     R2,[R5, #+2]
//  316 
//  317 	BodyFrame->Command = Comm;
        STRB     R7,[R5, #+3]
//  318 	
//  319 	BodyFrame->RCode = TRIO_RCODE;
        MOVS     R0,#+53
        STRB     R0,[R5, #+4]
//  320 
//  321 	BodyFrame->SubLength = nCnt;
        STRH     R6,[R5, #+1707]
//  322 	BodyFrame->SubLen[0] = (INT8U)((nCnt) >> 8);
        UXTH     R6,R6
        LSRS     R0,R6,#+8
        STRB     R0,[R5, #+5]
//  323 	BodyFrame->SubLen[1] = (INT8U)((nCnt) >> 0);
        STRB     R6,[R5, #+6]
//  324 
//  325 	for(i = 0 ; i < nCnt && i < BODYSIZEMAX; i++)
        MOVS     R0,#+0
        MOV      R1,R5
        MOVW     R2,#+1700
        B.N      ??GenBodyFrame_0
//  326 	{
//  327 		BodyFrame->SubData[DataCnt++] = Data[i];
??GenBodyFrame_1:
        LDRB     R7,[R3], #+1
        STRB     R7,[R1, #+7]
        ADDS     R4,R4,#+1
//  328 	}
        ADDS     R0,R0,#+1
        ADDS     R1,R1,#+1
??GenBodyFrame_0:
        CMP      R0,R6
        BGE.N    ??GenBodyFrame_2
        CMP      R0,R2
        BLT.N    ??GenBodyFrame_1
//  329 
//  330 	///////////// CRC //
//  331 	{
//  332 		BodyFrame->Crc = Crc16Calc ((INT8U *)BodyFrame->SubID, 7 + i, NULL);
??GenBodyFrame_2:
        ADDW     R6,R5,#+1707
        MOVS     R2,#+0
        ADDS     R1,R0,#+7
        MOV      R0,R5
        BL       Crc16Calc
        STRH     R0,[R6, #+2]
//  333 		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc >> 8);
        ADDS     R0,R4,R5
        LDRH     R1,[R6, #+2]
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+7]
        ADDS     R0,R4,#+1
//  334 		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc		);
        ADDS     R1,R0,R5
        LDRH     R2,[R6, #+2]
        STRB     R2,[R1, #+7]
//  335 	}
//  336 	
//  337 	BodyFrame->SubData[DataCnt++] = ETX;
        ADDS     R0,R0,R5
        MOVS     R1,#+3
        STRB     R1,[R0, #+8]
//  338 }
        POP      {R0,R4-R7,PC}    ;; return
//  339 
//  340 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  341 void WRCS_ProDataAckTx(__ProtocolPtr *nPtr)
//  342 {
WRCS_ProDataAckTx:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
//  343 	INT16U i, Len = 0;
//  344 	
//  345 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R5,[R4, #+32]
//  346 
//  347 #if TWO_BODY >= 2
//  348 	INT8U BodyNo = Send->BodyNo;
//  349 #else
//  350 	INT8U BodyNo = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  351 #endif
//  352 
//  353 	Send->Sync[0] = STX;
        MOVS     R0,#+22
        STRB     R0,[R5, #+0]
//  354 	Send->Sync[1] = STX;
        STRB     R0,[R5, #+1]
//  355 	Send->Sync[2] = STX;
        STRB     R0,[R5, #+2]
//  356 	Send->Sync[3] = STX;
        STRB     R0,[R5, #+3]
//  357 
//  358 	Send->TryNo= '0';
        MOVS     R0,#+48
        STRB     R0,[R5, #+4]
//  359 
//  360 	Send->BodyLength = 0;
        ADD      R0,R5,#+1720
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  361 
//  362 	for(i = 0; i <= BodyNo; i++)
        MOV      R0,R5
        LDRB     R1,[SP, #+0]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  363 	{
//  364 		Len = ((Send->BodyFrame[i].SubLen[0] << 8) | Send->BodyFrame[i].SubLen[1]) + 5 + 2 + 2;
//  365 		Send->BodyLength += Len;
??WRCS_ProDataAckTx_0:
        ADD      R2,R5,#+1720
        LDRH     R2,[R2, #+0]
        LDRB     R3,[R0, #+13]
        LDRB     R6,[R0, #+14]
        ORR      R3,R6,R3, LSL #+8
        ADDS     R3,R3,#+9
        ADDS     R2,R3,R2
        ADD      R3,R5,#+1720
        STRH     R2,[R3, #+0]
//  366 	}
        ADD      R0,R0,#+1712
        SUBS     R1,R1,#+1
        BNE.N    ??WRCS_ProDataAckTx_0
//  367 	Send->BodyLen[0] = (INT8U)(Send->BodyLength >> 8);
        ADD      R0,R5,#+1720
        LDRH     R0,[R0, #+0]
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+5]
//  368 	Send->BodyLen[1] = (INT8U)(Send->BodyLength >> 0);
        ADD      R0,R5,#+1720
        LDRH     R0,[R0, #+0]
        STRB     R0,[R5, #+6]
//  369 
//  370 	Send->CheckSum = Send->TryNo + Send->BodyLen[0] + Send->BodyLen[1];
        LDRB     R0,[R5, #+4]
        LDRB     R1,[R5, #+5]
        ADDS     R0,R1,R0
        LDRB     R1,[R5, #+6]
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+7]
//  371 
//  372 	nPtr->PutStr((INT8U *)Send, 4 + 1 + 2 + 1, FALSE);
        MOVS     R2,#+0
        MOVS     R1,#+8
        MOV      R0,R5
        LDR      R3,[R4, #+8]
        BLX      R3
//  373 
//  374 	for(i = 0; i <= BodyNo; i++)
        MOVS     R6,#+0
        B.N      ??WRCS_ProDataAckTx_1
//  375 	{
//  376 		nPtr->PutStr((INT8U *)&Send->BodyFrame[i], Send->BodyFrame[i].SubLength + 7 + 2, FALSE);
??WRCS_ProDataAckTx_2:
        MOV      R0,R6
        MOV      R1,#+1712
        MLA      R0,R0,R1,R5
        MOVS     R2,#+0
        LDRH     R1,[R0, #+1715]
        ADDS     R1,R1,#+9
        UXTH     R1,R1
        ADDS     R0,R0,#+8
        LDR      R3,[R4, #+8]
        BLX      R3
//  377 	}
        ADDS     R6,R6,#+1
        UXTH     R6,R6
??WRCS_ProDataAckTx_1:
        LDRB     R0,[SP, #+0]
        CMP      R0,R6
        BCS.N    ??WRCS_ProDataAckTx_2
//  378 
//  379 	BodyNo = ETX;
        MOVS     R0,#+3
        STRB     R0,[SP, #+0]
//  380 	nPtr->PutStr((INT8U *)&BodyNo, 1, TRUE);
        MOVS     R2,#+1
        MOVS     R1,#+1
        ADD      R0,SP,#+0
        LDR      R3,[R4, #+8]
        BLX      R3
//  381 }
        POP      {R0,R1,R4-R6,PC}  ;; return
//  382 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  383 void ProtocolComCheck (__ProtocolPtr *nPtr)
//  384 {
ProtocolComCheck:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+16
        MOV      R9,R0
//  385 	INT16U tcnt = 0;
//  386 	INT16U Comm = WhatRxComm(nPtr);
        BL       WhatRxComm
        MOV      R6,R0
//  387 	
//  388 	__WRCSSIO *Recv = nPtr->WRCSRecv;
//  389 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R0,[R9, #+32]
//  390     __BODYFRAME *rBody = &Recv->BodyFrame[0];
        LDR      R1,[R9, #+28]
        ADD      R5,R1,#+8
//  391     __BODYFRAME *sBody = &Send->BodyFrame[0];
        ADD      R4,R0,#+8
//  392 
//  393     INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};
        LDRB     R0,[R5, #+0]
        STRB     R0,[SP, #+0]
        LDRB     R8,[R5, #+1]
        ADD      R0,SP,#+0
        STRB     R8,[R0, #+1]
        LDRB     R10,[R5, #+2]
        STRB     R10,[R0, #+2]
//  394 
//  395 //	SerPtr->printf(" Comm:[%x]\n",Comm);
//  396 
//  397 	
//  398 	switch(Comm)
        MOVS     R0,R6
        BEQ.W    ??ProtocolComCheck_0
        SUBS     R0,R6,#+1
        BEQ.N    ??ProtocolComCheck_1
        SUBS     R0,R0,#+2
        BEQ.N    ??ProtocolComCheck_2
        SUBS     R0,R0,#+8
        CMP      R0,#+3
        BLS.W    ??ProtocolComCheck_3
        SUBS     R0,R0,#+31
        BEQ.N    ??ProtocolComCheck_4
        SUBS     R0,R0,#+75
        CMP      R0,#+1
        BLS.N    ??ProtocolComCheck_5
        SUBS     R0,R0,#+36
        BEQ.N    ??ProtocolComCheck_4
        B.N      ?Subroutine2
//  399 	{
//  400 		case AlarmMaskSetSCODE:
//  401 		{
//  402 			INT8U tmpData[10] = {0,};
??ProtocolComCheck_2:
        ADD      R0,SP,#+4
        MOVS     R1,#+12
        BL       __aeabi_memclr4
//  403 
//  404 			tDnrSts->AlarmMask = rBody->SubData[0];
        LDR.N    R7,??DataTable21  ;; ImgKind
        LDR      R0,[R7, #+20]
        LDRB     R1,[R5, #+7]
        STRB     R1,[R0, #+106]
//  405 			tmpData[0] = tDnrSts->AlarmMask;
        LDR      R0,[R7, #+20]
        LDRB     R0,[R0, #+106]
        STRB     R0,[SP, #+4]
//  406 			
//  407 			SaveBackupData();
        BL       SaveBackupData
//  408 			GenBodyFrame(tid[0], tid[1], tid[2], (INT8U *)tmpData, 1, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOV      R0,R9
        PUSH     {R0,R1}
        MOVS     R0,#+1
        UXTB     R1,R6
        PUSH     {R0,R1}
        ADD      R3,SP,#+20
        MOV      R2,R10
        MOV      R1,R8
        LDRB     R0,[SP, #+16]
        BL       GenBodyFrame
??ProtocolComCheck_6:
        ADD      SP,SP,#+16
//  409 			WRCS_ProDataAckTx(nPtr);
        MOV      R0,R9
        BL       WRCS_ProDataAckTx
        B.N      ?Subroutine2
//  410 		}
//  411 		break;
//  412 
//  413 		case SetDebugMode:
//  414 		case SDRDebugMode:
//  415 			tDnrSts->Text_Debug_Mode 		= rBody->SubData[0];
??ProtocolComCheck_4:
        LDR.N    R7,??DataTable21  ;; ImgKind
        LDR      R0,[R7, #+20]
        LDRB     R1,[R5, #+7]
        STRB     R1,[R0, #+827]
//  416 			tDnrSts->Comm_Debug_Mode.Data 	= rBody->SubData[1];
        LDR      R0,[R7, #+20]
        LDRB     R1,[R5, #+8]
        STRB     R1,[R0, #+863]
//  417 			tDnrSts->TestMode 				= rBody->SubData[2];
        LDR      R0,[R7, #+20]
        LDRB     R1,[R5, #+9]
        STRB     R1,[R0, #+861]
//  418 			tDnrSts->Test_Mode 				= rBody->SubData[3];
        LDR      R0,[R7, #+20]
        LDRB     R1,[R5, #+10]
        STRB     R1,[R0, #+826]
//  419 
//  420  			GenBodyFrame(tid[0], tid[1], tid[2], (INT8U *)rBody->SubData, rBody->SubLength, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOV      R0,R9
        PUSH     {R0,R1}
        LDRH     R0,[R5, #+1707]
        UXTB     R1,R6
        PUSH     {R0,R1}
        ADDS     R3,R5,#+7
??ProtocolComCheck_7:
        MOV      R2,R10
        MOV      R1,R8
        LDRB     R0,[SP, #+16]
        BL       GenBodyFrame
        B.N      ??ProtocolComCheck_6
//  421 			WRCS_ProDataAckTx(nPtr);
//  422 		break;
//  423 
//  424 		case ControlQue:
//  425 			if(nPtr == PcSer || (nPtr == SmsSer))
??ProtocolComCheck_1:
        LDR.N    R7,??DataTable21  ;; ImgKind
        LDR      R0,[R7, #+12]
        CMP      R9,R0
        BEQ.N    ??ProtocolComCheck_8
        LDR.N    R0,??Subroutine2_0  ;; SmsSer
        LDR      R0,[R0, #+0]
        CMP      R9,R0
        BNE.W    ??ProtocolComCheck_9
//  426 			{
//  427 				if(DownLoadGiveupTimerSet(NULL))
??ProtocolComCheck_8:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBZ      R0,??ProtocolComCheck_10
//  428 				{
//  429 					if( DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CMP      R0,R9
        BNE.W    ??ProtocolComCheck_9
//  430 				}
//  431 
//  432 				AnalyzeAidData(nPtr, TRUE);
??ProtocolComCheck_10:
        MOVS     R1,#+1
        MOV      R0,R9
        BL       AnalyzeAidData
//  433 				{
//  434 					OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
//  435 					
//  436  					tcnt = GenDnrAidSts((INT8U *)sBody->SubData, tDnrSts,nPtr);
        MOV      R2,R9
        LDR      R1,[R7, #+20]
        ADDS     R0,R4,#+7
        BL       GenDnrAidSts
        MOV      R2,R0
//  437 					GenBodyFrame(tid[0], tid[1], tid[2], (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOV      R0,R9
        PUSH     {R0,R1}
        MOV      R0,R2
        UXTB     R1,R6
        PUSH     {R0,R1}
        ADDS     R3,R4,#+7
        B.N      ??ProtocolComCheck_7
//  438 					WRCS_ProDataAckTx(nPtr);
//  439 				}
//  440 			}
//  441 		break;
//  442 
//  443 		case DDRTableSetQue:
//  444 		case DDRTableStsQue:
//  445 			if(nPtr == PcSer || (nPtr == SmsSer))
??ProtocolComCheck_5:
        LDR.N    R0,??DataTable21  ;; ImgKind
        LDR      R0,[R0, #+12]
        CMP      R9,R0
        BEQ.N    ??ProtocolComCheck_11
        LDR.N    R0,??Subroutine2_0+0x4  ;; SmsSer
        LDR      R0,[R0, #+0]
        CMP      R9,R0
        BNE.N    ??ProtocolComCheck_9
//  446 			{
//  447 				if(DownLoadGiveupTimerSet(NULL))
??ProtocolComCheck_11:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBZ      R0,??ProtocolComCheck_12
//  448 				{
//  449 					if( DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CMP      R0,R9
        BNE.N    ??ProtocolComCheck_9
//  450 				}
//  451 
//  452 				Response_Table_DE(nPtr);
??ProtocolComCheck_12:
        MOV      R0,R9
        BL       Response_Table_DE
        B.N      ?Subroutine2
//  453 
//  454 				#if 0
//  455 				switch(rBody->SubData[0])
//  456 				{
//  457                     case Index_FwdAttn1_2G:
//  458 
//  459 					break;
//  460 
//  461 					default:
//  462 						Response_Table_DE(nPtr);
//  463 					break;
//  464 				}
//  465 				#endif
//  466 			}
//  467 
//  468 		break;
//  469 
//  470 		case StatusQue:
//  471 			if(nPtr == PcSer || (nPtr == SmsSer))
??ProtocolComCheck_0:
        LDR.N    R5,??Subroutine2_0+0x8  ;; SmsSer
        LDR.N    R7,??DataTable21  ;; ImgKind
        LDR      R0,[R7, #+12]
        CMP      R9,R0
        BEQ.N    ??ProtocolComCheck_13
        LDR      R0,[R5, #+0]
        CMP      R9,R0
        BNE.N    ??ProtocolComCheck_14
//  472 			{
//  473 				{
//  474 					tcnt = GenDnrAidSts((INT8U *)sBody->SubData, tDnrSts,nPtr);
??ProtocolComCheck_13:
        MOV      R2,R9
        LDR      R1,[R7, #+20]
        ADDS     R0,R4,#+7
        BL       GenDnrAidSts
        MOV      R2,R0
//  475 					GenBodyFrame(tid[0], tid[1], tid[2], (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOV      R0,R9
        PUSH     {R0,R1}
        MOV      R0,R2
        UXTB     R1,R6
        PUSH     {R0,R1}
        ADDS     R3,R4,#+7
        MOV      R2,R10
        MOV      R1,R8
        LDRB     R0,[SP, #+16]
        BL       GenBodyFrame
        ADD      SP,SP,#+16
//  476 					WRCS_ProDataAckTx(nPtr);
        MOV      R0,R9
        BL       WRCS_ProDataAckTx
//  477 				}
//  478 
//  479 				if((nPtr == SmsSer))
        LDR      R0,[R5, #+0]
        CMP      R9,R0
        BNE.N    ??ProtocolComCheck_9
//  480 				{
//  481 					if( tDnrSts->ResetCase != 0)
        LDR      R0,[R7, #+20]
        LDRSB    R1,[R0, #+862]
        CMP      R1,#+0
        BEQ.N    ??ProtocolComCheck_9
//  482 					{
//  483 						tDnrSts->ResetCase = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+862]
        B.N      ?Subroutine2
//  484 					}
//  485 				}
//  486 			}
//  487 			else
//  488 			{
//  489 				AnalyzeAidData(nPtr, FALSE);
??ProtocolComCheck_14:
        MOVS     R1,#+0
        MOV      R0,R9
        BL       AnalyzeAidData
        B.N      ?Subroutine2
//  490 			}
//  491 		break;
//  492 
//  493 		case DownloadCMD:
//  494 		case DownloadCMDConfirm:
//  495 		case DownLoadData:
//  496 		case DownLoadDataConfirm:
//  497 
//  498 			if(nPtr == PcSer || (nPtr == SmsSer))
??ProtocolComCheck_3:
        LDR.N    R7,??DataTable21  ;; ImgKind
        LDR      R0,[R7, #+12]
        CMP      R9,R0
        BEQ.N    ??ProtocolComCheck_15
        LDR.N    R0,??Subroutine2_0+0xC  ;; SmsSer
        LDR      R0,[R0, #+0]
        CMP      R9,R0
        BNE.N    ??ProtocolComCheck_9
//  499 			{
//  500 				if(DownLoadGiveupTimerSet(NULL))
??ProtocolComCheck_15:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBZ      R0,??ProtocolComCheck_16
//  501 				{
//  502 					if( DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CMP      R0,R9
        BNE.N    ??ProtocolComCheck_9
//  503 				}
//  504 				DownLoadGiveupTimerSet((INT32U)nPtr);
??ProtocolComCheck_16:
        MOV      R0,R9
        BL       DownLoadGiveupTimerSet
//  505 				
//  506 				if(nPtr == SmsSer)
        LDR.N    R0,??Subroutine2_0+0x10  ;; SmsSer
        LDR      R0,[R0, #+0]
        CMP      R9,R0
        BNE.N    ??ProtocolComCheck_17
//  507 				{
//  508 					if(tDnrSts->TestMode == Debug_Download)SerPtr->printf("0: ComCheck [%x]\n",Comm );
        LDR      R0,[R7, #+20]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+4
        BNE.N    ??ProtocolComCheck_17
        MOV      R1,R6
        LDR.N    R0,??Subroutine2_0+0x14  ;; `?<Constant {0}>_1` + 12
        LDR.N    R2,??DataTable20  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  509 				}
//  510 
//  511 				WRCS_DownloadFunc(nPtr);
??ProtocolComCheck_17:
        MOV      R0,R9
        BL       WRCS_DownloadFunc
??ProtocolComCheck_9:
        Nop      
//  512 				
//  513 				#if 0
//  514 				switch(tid[2])
//  515 				{
//  516 					default:
//  517 					{
//  518 						INT16U  tmpFrameCnt = 0;
//  519 						tmpFrameCnt = rBody->SubData[0];
//  520 						tmpFrameCnt = (tmpFrameCnt << 8) | rBody->SubData[1]; 	  // Frame Number
//  521 						tmpFrameCnt = tmpFrameCnt;
//  522 						
//  523 						if (( Comm == DownloadCMD)||( Comm == DownloadCMDConfirm))
//  524 						{
//  525 						  	WRCS_DownloadFunc(nPtr);
//  526 						}
//  527 						else
//  528 						{
//  529 							if (( tmpFrameCnt == 0 )||(( Comm == DownLoadData)&&( DnImageCheck == 0)))
//  530 							{
//  531 								DnImageCheck = Check_Data_Image( &rBody->SubData[2]);
//  532 							}
//  533 
//  534 							if((DnImageCheck == OTRU_IMG)||(DnImageCheck == REMOTE_IMG)||(DnImageCheck == NO_IMG))
//  535 							{
//  536 								WRCS_DownloadFunc(nPtr);
//  537 							}
//  538 						}
//  539 					}
//  540 					break;
//  541 				}
//  542 				#endif
//  543 			}
//  544 		default:
//  545 		break;
//  546 	}
        REQUIRE ?Subroutine2
        ;; // Fall through to label ?Subroutine2
//  547 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine2:
        ADD      SP,SP,#+16
        POP      {R4-R10,PC}      ;; return
        Nop      
        DATA
??Subroutine2_0:
        DC32     SmsSer
        DC32     SmsSer
        DC32     SmsSer
        DC32     SmsSer
        DC32     SmsSer
        DC32     `?<Constant {0}>_1` + 12

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable20:
        DC32     SerPtr
//  548 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  549 INT16U GenAidData(INT16U Aid, INT8U *dptr, INT8U *sptr, INT16U len)
//  550 {
GenAidData:
        PUSH     {R4,R5}
//  551 	INT8U i = 0;
//  552 	INT8U rval = 0;
//  553 
//  554 	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
        LSRS     R4,R0,#+8
        STRB     R4,[R1, #+0]
//  555 	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
        STRB     R0,[R1, #+1]
//  556 	dptr[rval++] = len;
        STRB     R3,[R1, #+2]
        MOVS     R0,#+3
//  557 	for(i = 0; i < len; i++) dptr[rval++] = sptr[i];
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
//  558 
//  559 	return rval;
        POP      {R4,R5}
        BX       LR               ;; return
//  560 }
//  561 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  562 INT16U GenAidData16(INT16U Aid, INT8U *dptr, INT16U sptr, INT16U len)
//  563 {
GenAidData16:
        PUSH     {R3,R4}
//  564 	INT8U rval = 0;
//  565 	
//  566 	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
        LSRS     R4,R0,#+8
        STRB     R4,[R1, #+0]
//  567 	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
        STRB     R0,[R1, #+1]
//  568 	dptr[rval++] = len;
        STRB     R3,[R1, #+2]
//  569 	dptr[rval++] = (INT8U)((sptr >> 8) & 0xFF);
        LSRS     R0,R2,#+8
        STRB     R0,[R1, #+3]
//  570 	dptr[rval++] = (INT8U)((sptr >> 0) & 0xFF);
        STRB     R2,[R1, #+4]
//  571 
//  572 	return rval;
        MOVS     R0,#+5
        POP      {R1,R4}
        BX       LR               ;; return
//  573 }
//  574 
//  575 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  576 unsigned char Check_Data_Image( unsigned char *_Dat )
//  577 {
Check_Data_Image:
        PUSH     {R3-R6}
//  578 	unsigned char i;
//  579 	
//  580 	INT8U Img_Sum = 0;
//  581 
//  582 	
//  583 	Img_Sum = (REMOTE_IMG + Rmt_FPGA_IMG + Rmt_FPGA_APP_IMG);
        MOVS     R1,#+112
//  584 
//  585 	for( i = 0; i < 32; i++ )
        LDR.N    R2,??DataTable21  ;; ImgKind
        LDR      R3,[R2, #+28]
        MOVS     R4,#+32
//  586 	{
//  587 		if (Img_Sum & REMOTE_IMG)
??Check_Data_Image_0:
        TST      R1,#0x10
        BEQ.N    ??Check_Data_Image_1
//  588 		{
//  589 			if( RmtCode_Image[i] != _Dat[i] ) Img_Sum &= (~REMOTE_IMG); 
        LDRB     R5,[R3, #+0]
        LDRB     R6,[R0, #+0]
        CMP      R5,R6
        BEQ.N    ??Check_Data_Image_1
        AND      R1,R1,#0xEF
//  590 		}
//  591  	}
??Check_Data_Image_1:
        ADDS     R0,R0,#+1
        ADDS     R3,R3,#+1
        SUBS     R4,R4,#+1
        BNE.N    ??Check_Data_Image_0
//  592 	
//  593 	ImgKind = Img_Sum;
        STRB     R1,[R2, #+0]
//  594 
//  595 	return ImgKind;
        LDRB     R0,[R2, #+0]
        POP      {R1,R4-R6}
        BX       LR               ;; return
//  596 
//  597 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     ImgKind
//  598 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  599 char ustrcmp(char *sbuff,char *dbuff, INT8U len)
//  600 {
//  601 #if 0
//  602     if(strlen(sbuff)!=strlen(dbuff))
//  603         return(1);
//  604     while(*sbuff){
//  605         if(toupper(*sbuff++)!=*dbuff++)
//  606             return(1);
//  607     }
//  608     return(0);
//  609 #endif	
//  610 	while(*dbuff){
ustrcmp:
??ustrcmp_0:
        LDRB     R2,[R1, #+0]
        CMP      R2,#+0
        BEQ.N    ??ustrcmp_1
//  611 		if(toupper(*sbuff++)!=*dbuff++)
        LDRB     R2,[R0, #+0]
        CMP      R2,#+97
        BLT.N    ??ustrcmp_2
        CMP      R2,#+123
        BGE.N    ??ustrcmp_2
        SUBS     R2,R2,#+32
??ustrcmp_2:
        ADDS     R0,R0,#+1
        LDRB     R3,[R1], #+1
        CMP      R2,R3
        BEQ.N    ??ustrcmp_0
//  612 			return(1);
        MOVS     R0,#+1
        BX       LR
//  613 }
//  614 return(0);
??ustrcmp_1:
        MOVS     R0,#+0
        BX       LR               ;; return
//  615 
//  616 	
//  617 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "##GSI#DE-O#RMT#RCU#20...">`:
        DATA
        DC8 "##GSI#DE-O#RMT#RCU#201011#012345"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant {0}>`:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "\012\015 DownLoadDataConfirm[%d][%d][%d][%d]:[%d]\012"
        DC8 0, 0, 0
        DC8 "\012\015 Download[%s][%s][%s][%s]\012"
        DC8 0, 0, 0
        DC8 "TRIO-M"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant " TRIO-M VER:%d.%d.%d-...">`:
        DATA
        DC8 " TRIO-M VER:%d.%d.%d-->Type[%d] :[%d]\012"
        DC8 0
        DC8 " sizeof:[%d][%d][%d]:[%d]\012"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant {0}>_1`:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 "0: ComCheck [%x]\012"
        DC8 0, 0

        END
//  618 
//  619 ////////////////////////////////////////////////////////////////////////////////
//  620 // End of Source File
//  621 /////////////////////
//  622 
// 
//   937 bytes in section .bss
// 4 513 bytes in section .data
//   236 bytes in section .rodata
// 2 782 bytes in section .text
// 
// 2 782 bytes of CODE  memory
//   236 bytes of CONST memory
// 5 450 bytes of DATA  memory
//
//Errors: none
//Warnings: none
