///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jun/2011  18:42:05 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1. /
//                    0\code\aa_ethernet1Dnr.c                                /
//    Command line =  "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1 /
//                    .0\code\aa_ethernet1Dnr.c" -lcN "C:\user\project\HFR    /
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
//                    0\sout\aa_ethernet1Dnr.s                                /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_ethernet1Dnr

        EXTERN DnrSts
        EXTERN EthernetInitSet
        EXTERN GenDnrRstSts
        EXTERN IsItRtnMyVALtoSysID
        EXTERN MyDnrID
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN ProtocolComCheck
        EXTERN SystemTypeInfo
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN WRCS_DownLoadGiveupTimerSet
        EXTERN WRCS_ProtocolCheck
        EXTERN eLink_Check
        EXTERN pBodyFrameTx
        EXTERN retCheckByte
        EXTERN retGetByte
        EXTERN retSelect
        EXTERN returnip
        EXTERN returnport
        EXTERN tTestFlag
        EXTERN udpPutStr
        EXTERN udpSem
        EXTERN udpSetAddr

        PUBLIC Eth1TaskStk
        PUBLIC Ethenet1Init
        PUBLIC Ethernet1DnrTask
        PUBLIC Ethernet1RmtTask
        PUBLIC RmtCheckInstalltoSend
        PUBLIC RmtLinkFailCheck
        PUBLIC RmtLinkFailCnt
        PUBLIC RmtLinkFailRst
        PUBLIC RmtRecvCnt
        PUBLIC RmtSendCnt
        PUBLIC Rwrcs1
        PUBLIC Swrcs1
        PUBLIC Wrcs1
        PUBLIC Wrcs1B
        PUBLIC Wrcs1_RtnIP
        PUBLIC ret1CheckByte
        PUBLIC ret1GetByte
        PUBLIC udp1PutStr
        PUBLIC udp1SetAddr

// C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1.0\code\aa_ethernet1Dnr.c
//    1 
//    2 /******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
//    3 * File Name          : exlib.c
//    4 * Author             : Yoon Byong-Gyu(bgyoon@naver.com)
//    5 * Date First Issued  : 02/01/2008
//    6 * Description        : This file provides all the port/input/update firmware functions.
//    7 * $Revision: 0.1 $
//    8 * $Revision date: 2008.01.__
//    9 ********************************************************************************/
//   10 
//   11 #define ETH1_C
//   12 
//   13 #include "../dev/W3150A_v1.0.6/types.h"
//   14 #include "../dev/W3150A_v1.0.6/socket.h"
//   15 #include "../dev/W3150A_v1.0.6/w3150a.h"
//   16 
//   17 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// __ProtocolPtr __data Wrcs1B
Wrcs1B:
        DS8 48

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RmtLinkFailCnt
RmtLinkFailCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RmtSendCnt
RmtSendCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RmtRecvCnt
RmtRecvCnt:
        DS8 1

        SECTION `.data`:DATA:NOROOT(2)
// __IPINFOR __data Wrcs1_RtnIP
Wrcs1_RtnIP:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __ProtocolPtr *__data Wrcs1
Wrcs1:
        DC32 Wrcs1B
// OS_STK __data Eth1TaskStk[256]
Eth1TaskStk:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __WRCSSIO __data Swrcs1
Swrcs1:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
// __WRCSSIO __data Rwrcs1
Rwrcs1:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
//   18 #include "aa_ethernet1Rmt.c"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork void Ethernet1RmtTask(void *)
Ethernet1RmtTask:
        PUSH     {R3-R9,LR}
        LDR.W    R4,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R6,[R4, #+20]
        LDRB     R5,[R6, #+47]
        MOV      R0,#+500
        BL       OSTimeDly
        MOVS     R2,#+1
        MOVS     R1,#+2
        MOV      R0,R5
        BL       EthernetInitSet
        LDRH     R1,[R4, #+18]
        ADDS     R0,R4,#+6
        BL       udp1SetAddr
        MOVW     R1,#+5000
        MOVS     R0,#+32
        BL       TimerRegist
        LDR.N    R1,??DataTable7  ;; returnip
        ADD      R9,R1,R5, LSL #+2
        LDR.N    R1,??DataTable8  ;; returnport
        ADD      R8,R1,R5, LSL #+1
        LDR.N    R7,??DataTable9  ;; tTestFlag
        B.N      ??Ethernet1RmtTask_0
??Ethernet1RmtTask_1:
        MOVS     R0,#+200
        BL       OSTimeDly
??Ethernet1RmtTask_0:
        MOV      R0,R5
        BL       eLink_Check
        CBZ      R0,??Ethernet1RmtTask_2
        LDRB     R0,[R7, #+0]
        CBNZ     R0,??Ethernet1RmtTask_2
        B.N      ??Ethernet1RmtTask_3
??Ethernet1RmtTask_4:
        BL       RmtLinkFailCheck
        MOV      R0,#+300
        BL       OSTimeDly
??Ethernet1RmtTask_3:
        MOV      R0,R5
        BL       eLink_Check
        CBZ      R0,??Ethernet1RmtTask_5
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BEQ.N    ??Ethernet1RmtTask_4
??Ethernet1RmtTask_5:
        MOVS     R2,#+0
        MOVS     R1,#+2
        MOV      R0,R5
        BL       EthernetInitSet
        MOV      R0,#+1000
        B.N      ??Ethernet1RmtTask_6
??Ethernet1RmtTask_7:
        MOV      R0,R6
        BL       WRCS_ProtocolCheck
        CBZ      R0,??Ethernet1RmtTask_8
        LDRH     R1,[R4, #+18]
        ADDS     R0,R4,#+6
        BL       udp1SetAddr
        MOV      R0,R6
        BL       ProtocolComCheck
        BL       RmtLinkFailRst
??Ethernet1RmtTask_8:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R6, #+0]
        BLX      R2
        CMP      R0,#+0
        BNE.N    ??Ethernet1RmtTask_7
??Ethernet1RmtTask_9:
        MOVS     R0,#+200
??Ethernet1RmtTask_6:
        BL       OSTimeDly
??Ethernet1RmtTask_2:
        MOV      R0,R5
        BL       eLink_Check
        CMP      R0,#+0
        BNE.N    ??Ethernet1RmtTask_1
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BNE.N    ??Ethernet1RmtTask_1
        BL       RmtLinkFailCheck
        MOV      R3,R8
        MOV      R2,R9
        MOVS     R1,#+0
        MOV      R0,R5
        BL       retSelect
        CMP      R0,#+0
        BEQ.N    ??Ethernet1RmtTask_9
        B.N      ??Ethernet1RmtTask_8
//   19 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   20 void Ethenet1Init(void)
//   21 {
Ethenet1Init:
        PUSH     {R4,LR}
//   22 	////////////////////////////////////////////////////////////////////////////////
//   23 	//
//   24 	Wrcs1->CheckByte = ret1CheckByte;
        LDR.W    R4,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R0,[R4, #+20]
        LDR.N    R1,??Ethenet1Init_0  ;; ret1CheckByte
        STR      R1,[R0, #+0]
//   25 	Wrcs1->RxGetByte = ret1GetByte;
        LDR.N    R1,??Ethenet1Init_0+0x4  ;; ret1GetByte
        STR      R1,[R0, #+4]
//   26 	Wrcs1->PutStr = udp1PutStr;
        ADDS     R1,R0,#+4
        LDR.N    R2,??Ethenet1Init_0+0x8  ;; udp1PutStr
        STR      R2,[R1, #+4]
//   27 	Wrcs1->TxCheckByte = NULL;
        MOVS     R2,#+0
        STR      R2,[R1, #+12]
//   28 
//   29 	Wrcs1->TimerRx = Timerudp1Rx;
        MOVS     R2,#+4
        STRH     R2,[R1, #+16]
//   30 	Wrcs1->WRCSRecv = &Rwrcs1;
        ADD      R2,R4,#+2096
        STR      R2,[R1, #+28]
//   31 	Wrcs1->WRCSSend = &Swrcs1;
        ADD      R2,R4,#+1048
        STR      R2,[R1, #+32]
//   32 	Wrcs1->nUSE = ETH1_CHANNEL;
        MOVS     R1,#+0
        STRB     R1,[R0, #+47]
//   33 	Wrcs1->OSSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+20]
        STR      R0,[R1, #+28]
//   34 
//   35 	udpSem[ETH1_CHANNEL] = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.N    R1,??Ethenet1Init_0+0xC  ;; udpSem
        STR      R0,[R1, #+0]
//   36 
//   37 	if(SystemTypeInfo < 2)	OSTaskCreate(Ethernet1DnrTask, (void *)NULL, (OS_STK *)&Eth1TaskStk[ETH1_START_STK_SIZE - 1], ETH1_START_PRIO);
        ADDW     R2,R4,#+1044
        LDR.N    R0,??DataTable22  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.N    ??Ethenet1Init_1
        MOVS     R3,#+5
        MOVS     R1,#+0
        LDR.N    R0,??Ethenet1Init_0+0x10  ;; Ethernet1DnrTask
        B.N      ??Ethenet1Init_2
//   38 	else					OSTaskCreate(Ethernet1RmtTask, (void *)NULL, (OS_STK *)&Eth1TaskStk[ETH1_START_STK_SIZE - 1], ETH1_START_PRIO);
??Ethenet1Init_1:
        MOVS     R3,#+5
        MOVS     R1,#+0
        LDR.N    R0,??Ethenet1Init_0+0x14  ;; Ethernet1RmtTask
??Ethenet1Init_2:
        POP      {R4,LR}
        B.W      OSTaskCreate
        Nop      
        DATA
??Ethenet1Init_0:
        DC32     ret1CheckByte
        DC32     ret1GetByte
        DC32     udp1PutStr
        DC32     udpSem
        DC32     Ethernet1DnrTask
        DC32     Ethernet1RmtTask
//   39 
//   40 }
//   41 // UDP CASE !!(SERVER)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   42 void Ethernet1DnrTask(void *p_arg)
//   43 {
Ethernet1DnrTask:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
//   44 	INT8U s = 0;
//   45 	INT8U nUSE = Wrcs1->nUSE;
        LDR.N    R4,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R7,[R4, #+20]
        LDRB     R8,[R7, #+47]
//   46 	INT8U tmpID = 0;
        MOVS     R6,#+0
//   47 
//   48 	__ProtocolPtr *nPtr = Wrcs1;
//   49 
//   50 	OSTimeDly(100L*ETH1_START_PRIO);
        MOV      R0,#+500
        BL       OSTimeDly
//   51 	EthernetInitSet(nUSE, Sn_MR_UDP, FALSE);
        MOVS     R2,#+0
        MOVS     R1,#+2
        MOV      R0,R8
        BL       EthernetInitSet
//   52 
//   53 	udp1SetAddr(Wrcs1_RtnIP.IPAddr, Wrcs1_RtnIP.nPort);
        LDRH     R1,[R4, #+18]
        ADDS     R0,R4,#+6
        BL       udp1SetAddr
        LDR.N    R1,??DataTable7  ;; returnip
        ADD      R10,R1,R8, LSL #+2
        LDR.N    R1,??DataTable8  ;; returnport
        ADD      R9,R1,R8, LSL #+1
        LDR.N    R5,??DataTable9  ;; tTestFlag
        B.N      ??Ethernet1DnrTask_0
//   54 
//   55 	//SerPtr->printf("set: ip:%d.%d.%d.%d, port: %d\n", Wrcs1_RtnIP.IPAddr[0], Wrcs1_RtnIP.IPAddr[1] ,
//   56 	//						 						  Wrcs1_RtnIP.IPAddr[2], Wrcs1_RtnIP.IPAddr[3] ,
//   57 	//											      (Wrcs1_RtnIP.nPort));
//   58 	while(1)
//   59 	{
//   60 		if(eLink_Check(nUSE) && !tTestFlag)
//   61 		{
//   62 			while(eLink_Check(nUSE) && !tTestFlag)
//   63 			{
//   64 				RmtLinkFailCheck();
//   65 				OSTimeDly(300L);
//   66 			}
//   67 			EthernetInitSet(nUSE, Sn_MR_UDP, TRUE);
//   68 			OSTimeDly(1000L);
//   69 		}
//   70 		while(!eLink_Check(nUSE) && !tTestFlag)
//   71 		{
//   72 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//   73 			if(retSelect(nUSE, s, returnip[nUSE], &returnport[nUSE]))
//   74 			{
//   75 				INT16U Recv;
//   76 
//   77 				//rPtr->printf("recv ip:%d.%d.%d.%d, port: %d\n", returnip[nUSE][0], returnip[nUSE][1] ,
//   78 				//										  returnip[nUSE][2], returnip[nUSE][3] ,
//   79 				//										  returnport[nUSE]);
//   80 				
//   81 			    while(nPtr->CheckByte(1, &Recv))
//   82 				{
//   83 					if(WRCS_ProtocolCheck(nPtr))
//   84 					{
//   85 #if TWO_BODY >= 2
//   86 						while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   87 						{
//   88 #endif
//   89 							udp1SetAddr(Wrcs1_RtnIP.IPAddr, Wrcs1_RtnIP.nPort);
//   90 							RmtLinkFailRst();
//   91 							ProtocolComCheck(nPtr);
//   92 #if TWO_BODY >= 2
//   93 							nPtr->WRCSRecv->cBody++;
//   94 						}
//   95 #endif
//   96 					}
//   97 				}
//   98 			}
//   99 			else {
//  100 				tmpID = RmtCheckInstalltoSend(nPtr, tmpID);
//  101 			}
//  102 			
//  103 			//if(!WRCS_DownLoadGiveupTimerSet(NULL))
//  104 			//{
//  105 				//SerPtr->printf("SendCnt = %d, RecvCnt = %d \n", RmtSendCnt, RmtRecvCnt);
//  106 			//}
//  107 			OSTimeDly(200L);
//  108 		}
//  109 		OSTimeDly(200L);
??Ethernet1DnrTask_1:
        MOVS     R0,#+200
        BL       OSTimeDly
??Ethernet1DnrTask_0:
        MOV      R0,R8
        BL       eLink_Check
        CBZ      R0,??Ethernet1DnrTask_2
        LDRB     R0,[R5, #+0]
        CBNZ     R0,??Ethernet1DnrTask_2
        B.N      ??Ethernet1DnrTask_3
??Ethernet1DnrTask_4:
        BL       RmtLinkFailCheck
        MOV      R0,#+300
        BL       OSTimeDly
??Ethernet1DnrTask_3:
        MOV      R0,R8
        BL       eLink_Check
        CBZ      R0,??Ethernet1DnrTask_5
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BEQ.N    ??Ethernet1DnrTask_4
??Ethernet1DnrTask_5:
        MOVS     R2,#+1
        MOVS     R1,#+2
        MOV      R0,R8
        BL       EthernetInitSet
        MOV      R0,#+1000
        B.N      ??Ethernet1DnrTask_6
??Ethernet1DnrTask_7:
        MOV      R1,R6
        MOV      R0,R7
        BL       RmtCheckInstalltoSend
        MOV      R6,R0
??Ethernet1DnrTask_8:
        MOVS     R0,#+200
??Ethernet1DnrTask_6:
        BL       OSTimeDly
??Ethernet1DnrTask_2:
        MOV      R0,R8
        BL       eLink_Check
        CMP      R0,#+0
        BNE.N    ??Ethernet1DnrTask_1
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??Ethernet1DnrTask_1
        MOV      R3,R9
        MOV      R2,R10
        MOVS     R1,#+0
        MOV      R0,R8
        BL       retSelect
        CMP      R0,#+0
        BEQ.N    ??Ethernet1DnrTask_7
??Ethernet1DnrTask_9:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R7, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??Ethernet1DnrTask_8
        MOV      R0,R7
        BL       WRCS_ProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??Ethernet1DnrTask_9
        LDRH     R1,[R4, #+18]
        ADDS     R0,R4,#+6
        BL       udp1SetAddr
        BL       RmtLinkFailRst
        MOV      R0,R7
        BL       ProtocolComCheck
        B.N      ??Ethernet1DnrTask_9
//  110 	}
//  111 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     returnip

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     returnport

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     tTestFlag
//  112 
//  113 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  114 INT8U RmtCheckInstalltoSend(__ProtocolPtr *nPtr, INT8U tmpID)
//  115 {
RmtCheckInstalltoSend:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R4,R1
//  116 	INT8U *sData = nPtr->WRCSRecv->BodyFrame[0].SubData;
        LDR      R0,[R0, #+32]
        ADD      R5,R0,#+15
//  117 	INT8U tmpDnr, tmpRmt;
//  118 	INT16U rlen = 0;
//  119 	INT8U id0, id1, id2;
//  120 	INT8U rcom;
//  121 	
//  122 	if(WRCS_DownLoadGiveupTimerSet(NULL)) return tmpID;
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CMP      R0,#+0
        BEQ.N    ??RmtCheckInstalltoSend_0
        MOV      R0,R4
        POP      {R1,R2,R4-R8,PC}
//  123 
//  124 	////////////////////////////////////////////////////////////////////////////
//  125 	if(tmpID == 0)
??RmtCheckInstalltoSend_0:
        CBNZ     R4,??RmtCheckInstalltoSend_1
//  126 	{
//  127 		// 자기 상태 내려준다..
//  128 		tmpDnr = MyDnrID;
        LDR.N    R0,??DataTable20  ;; MyDnrID
        LDRB     R6,[R0, #+0]
//  129 		tmpRmt = 0x00;
??RmtCheckInstalltoSend_2:
        MOVS     R7,#+0
        B.N      ??RmtCheckInstalltoSend_3
//  130 	}
//  131 	else if(tmpID == 1)
??RmtCheckInstalltoSend_1:
        CMP      R4,#+1
        BNE.N    ??RmtCheckInstalltoSend_4
//  132 	{
//  133 		// 다른 Donor 내려준다.
//  134 		tmpDnr = MyDnrID ^ 1;
        LDR.N    R0,??DataTable20  ;; MyDnrID
        LDRB     R0,[R0, #+0]
        EOR      R6,R0,#0x1
//  135 		tmpRmt = 0x00;
        B.N      ??RmtCheckInstalltoSend_2
//  136 	}
//  137 	else if(tmpID == 2)
??RmtCheckInstalltoSend_4:
        CMP      R4,#+2
        BNE.N    ??RmtCheckInstalltoSend_3
//  138 	{
//  139 		// 다른 Remote 내려준다....
//  140 		tmpDnr = MyDnrID ^ 1;
        LDR.N    R0,??DataTable20  ;; MyDnrID
        LDRB     R0,[R0, #+0]
        EOR      R6,R0,#0x1
//  141 		tmpRmt = 0x01;
        MOVS     R7,#+1
//  142 	}
//  143 
//  144 ////////////////////////////////////////////////////////////////////////////////
//  145 	// DATA MAKE
//  146 	// SUB ID 3 Bytes!!
//  147 	IsItRtnMyVALtoSysID(&id0, &id1, &id2, tmpDnr, tmpRmt);
??RmtCheckInstalltoSend_3:
        UXTB     R0,R7
        PUSH     {R0,LR}
        UXTB     R3,R6
        ADD      R2,SP,#+8
        ADD      R1,SP,#+9
        ADD      R0,SP,#+10
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
//  148 	sData[0] = id0;
        LDRB     R0,[SP, #+2]
        STRB     R0,[R5, #+0]
//  149 	sData[1] = id1;
        LDRB     R0,[SP, #+1]
        STRB     R0,[R5, #+1]
//  150 	sData[2] = id2;
        LDRB     R0,[SP, #+0]
        STRB     R0,[R5, #+2]
//  151 
//  152 	rlen = GenDnrRstSts(&sData[3], &DnrSts[tmpDnr][tmpRmt], tmpDnr, tmpRmt, &rcom, Wrcs1) + 3;
        LDR.W    R8,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R1,[R8, #+20]
        ADD      R0,SP,#+3
        PUSH     {R0,R1}
        UXTB     R3,R7
        UXTB     R2,R6
        UXTB     R7,R7
        MOVW     R0,#+269
        UXTB     R6,R6
        MOVW     R1,#+538
        LDR.W    R12,??DataTable21  ;; DnrSts
        MLA      R1,R6,R1,R12
        MLA      R1,R7,R0,R1
        ADDS     R0,R5,#+3
        BL       GenDnrRstSts
        ADD      SP,SP,#+8
        ADDS     R6,R0,#+3
//  153 ////////////////////////////////////////////////////////////////////////////////
//  154 	IsItRtnMyVALtoSysID(&id0, &id1, &id2, MyDnrID, 0x01);
        MOVS     R0,#+1
        PUSH     {R0,LR}
        LDR.N    R0,??DataTable20  ;; MyDnrID
        LDRB     R3,[R0, #+0]
        ADD      R2,SP,#+8
        ADD      R1,SP,#+9
        ADD      R0,SP,#+10
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
//  155 	pBodyFrameTx(id0, id1, id2, sData, rlen, StatusRQST, Wrcs1, NULL);
        MOVS     R1,#+0
        LDR      R0,[R8, #+20]
        PUSH     {R0,R1}
        MOVS     R1,#+128
        UXTH     R0,R6
        PUSH     {R0,R1}
        MOV      R3,R5
        LDRB     R2,[SP, #+16]
        LDRB     R1,[SP, #+17]
        LDRB     R0,[SP, #+18]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  156 
//  157 	//DnrInsertCheck();
//  158 	tmpID++;
//  159 	
//  160 	//if(DnrInsertCheck())tmpID++;
//  161 	//else 				tmpID = 0;
//  162 	
//  163 	OSTimeDly(500L);
        MOV      R0,#+500
        BL       OSTimeDly
//  164 	return (tmpID%3);
        ADDS     R0,R4,#+1
        UXTB     R0,R0
        MOVS     R1,#+3
        SDIV     R2,R0,R1
        MLS      R0,R2,R1,R0
        UXTB     R0,R0
        POP      {R1,R2,R4-R8,PC}  ;; return
//  165 }
//  166 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  167 void RmtLinkFailCheck(void)
//  168 {
RmtLinkFailCheck:
        PUSH     {R3-R5,LR}
//  169 	if(SystemTypeInfo < 2)
        LDR.N    R0,??DataTable22  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.N    ??RmtLinkFailCheck_0
//  170 	{
//  171 		if((++RmtLinkFailCnt > 20))
        LDR.N    R0,??DataTable23  ;; RmtLinkFailCnt
        LDRB     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+0]
        UXTB     R1,R1
        CMP      R1,#+21
        BCC.N    ??RmtLinkFailCheck_1
//  172 		{
//  173 			RmtLinkFailCnt = 30;
        MOVS     R1,#+30
        STRB     R1,[R0, #+0]
//  174 			BitSet(DnrSts[MyDnrID][1].RTInfo, mLinkFail);
        MOVW     R0,#+538
        LDR.N    R2,??DataTable20  ;; MyDnrID
        LDR.N    R1,??DataTable21  ;; DnrSts
        LDRB     R2,[R2, #+0]
        MLA      R0,R2,R0,R1
        ADD      R1,R0,#+404
        LDRB     R2,[R1, #+2]
        ORR      R2,R2,#0x1
        STRB     R2,[R1, #+2]
//  175 			BitSet(DnrSts[MyDnrID][1].COTInfo, mLinkFail);
        LDRB     R1,[R0, #+404]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #+404]
//  176 			DnrSts[MyDnrID][1].DnrAlm.LinkFail = SET;
        ADD      R1,R0,#+270
        LDRB     R1,[R1, #+0]
        ORR      R1,R1,#0x2
        ADD      R0,R0,#+270
        STRB     R1,[R0, #+0]
        POP      {R0,R4,R5,PC}
//  177 	   	}
//  178 	}
//  179 	else
//  180 	{
//  181 		if(TimeOverCheck(TimerRmtLink))
??RmtLinkFailCheck_0:
        MOVS     R0,#+32
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??RmtLinkFailCheck_1
//  182 		{
//  183 			TimerRegist(TimerRmtLink, Time1Sec*5L);
        MOVW     R1,#+5000
        MOVS     R0,#+32
        BL       TimerRegist
//  184 
//  185 			if(BitRead(DnrSts[MyDnrID ^ 1][0].COTInfo, mInstall))
        LDR.N    R2,??DataTable20  ;; MyDnrID
        LDRB     R2,[R2, #+0]
        MOVW     R0,#+538
        LDR.N    R1,??DataTable21  ;; DnrSts
        EOR      R3,R2,#0x1
        MLA      R3,R3,R0,R1
        LDRB     R4,[R3, #+135]
        TST      R4,#0x4
        BEQ.N    ??RmtLinkFailCheck_2
//  186 			{
//  187 				BitSet(DnrSts[MyDnrID ^ 1][0].COTInfo, mLinkFail);
        ORR      R4,R4,#0x1
        STRB     R4,[R3, #+135]
//  188 				BitSet(DnrSts[MyDnrID ^ 1][0].RTInfo, mLinkFail);
        ADD      R4,R3,#+135
        LDRB     R5,[R4, #+2]
        ORR      R5,R5,#0x1
        STRB     R5,[R4, #+2]
//  189 
//  190 				BitSet(DnrSts[MyDnrID ^ 1][1].COTInfo, mLinkFail);
        LDRB     R4,[R3, #+404]
        ORR      R4,R4,#0x1
        STRB     R4,[R3, #+404]
//  191 				BitSet(DnrSts[MyDnrID ^ 1][1].RTInfo, mLinkFail);
        ADD      R4,R3,#+404
        LDRB     R5,[R4, #+2]
        ORR      R5,R5,#0x1
        STRB     R5,[R4, #+2]
//  192 
//  193 				DnrSts[MyDnrID ^ 1][0].DnrAlm.LinkFail = SET;
        LDRB     R4,[R3, #+1]
        ORR      R4,R4,#0x2
        STRB     R4,[R3, #+1]
//  194 			}
//  195 
//  196 			BitSet(DnrSts[MyDnrID][0].COTInfo, mLinkFail);
??RmtLinkFailCheck_2:
        MLA      R0,R2,R0,R1
        LDRB     R1,[R0, #+135]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #+135]
//  197 			BitSet(DnrSts[MyDnrID][0].RTInfo, mLinkFail);
        ADD      R1,R0,#+135
        LDRB     R2,[R1, #+2]
        ORR      R2,R2,#0x1
        STRB     R2,[R1, #+2]
//  198 			DnrSts[MyDnrID][0].DnrAlm.LinkFail = SET;
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+1]
//  199 		}
//  200 	}
//  201 }
??RmtLinkFailCheck_1:
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable20:
        DC32     MyDnrID

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     DnrSts
//  202 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  203 void RmtLinkFailRst(void)
//  204 {
//  205 	if(SystemTypeInfo < 2)
RmtLinkFailRst:
        LDR.N    R0,??DataTable22  ;; SystemTypeInfo
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BCS.N    ??RmtLinkFailRst_0
//  206 	{
//  207 		RmtLinkFailCnt = 0;
        LDR.N    R0,??DataTable23  ;; RmtLinkFailCnt
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
        BX       LR               ;; return
//  208 		//BitRst(DnrSts[MyDnrID][1].RTInfo, mLinkFail);
//  209 		//BitRst(DnrSts[MyDnrID][1].COTInfo, mLinkFail);
//  210 		//DnrSts[MyDnrID][1].DnrAlm.LinkFail = RESET;
//  211 	}
//  212 	else
//  213 	{
//  214 		TimerRegist(TimerRmtLink, Time1Sec*5L);
??RmtLinkFailRst_0:
        MOVW     R1,#+5000
        MOVS     R0,#+32
        B.W      TimerRegist
//  215 		//BitRst(DnrSts[MyDnrID][0].COTInfo, mLinkFail);
//  216 		//BitRst(DnrSts[MyDnrID][0].RTInfo, mLinkFail);
//  217 		//DnrSts[MyDnrID][0].DnrAlm.LinkFail = RESET;
//  218 	}
//  219 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable22:
        DC32     SystemTypeInfo

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable23:
        DC32     RmtLinkFailCnt
//  220 
//  221 
//  222 
//  223 /////////////////////////////////////////////////////////////////////////////////////////////////////

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 unsigned char ret1CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
//  225 {
//  226 	return(retCheckByte(Wrcs1->nUSE, ByteCnt, Recv));
ret1CheckByte:
        MOV      R2,R1
        MOV      R1,R0
        LDR.N    R0,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R0,[R0, #+20]
        LDRB     R0,[R0, #+47]
        B.W      retCheckByte
//  227 }
//  228 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  229 signed short int ret1GetByte(void)
//  230 {
//  231 	return (retGetByte(Wrcs1->nUSE));
ret1GetByte:
        LDR.N    R0,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R0,[R0, #+20]
        LDRB     R0,[R0, #+47]
        B.W      retGetByte
//  232 }
//  233 
//  234 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  235 void udp1SetAddr(INT8U *destaddr, INT16U destport)
//  236 {	
//  237 	udpSetAddr(Wrcs1->nUSE, 0, destaddr, destport);
udp1SetAddr:
        MOV      R3,R1
        MOV      R2,R0
        MOVS     R1,#+0
        LDR.N    R0,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R0,[R0, #+20]
        LDRB     R0,[R0, #+47]
        B.W      udpSetAddr
//  238 }
//  239 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  240 void udp1PutStr(unsigned char *Str, unsigned short int Length, int iEn)
//  241 {
udp1PutStr:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
        LDR.N    R0,??DataTable27  ;; Wrcs1_RtnIP
        LDR      R0,[R0, #+20]
        ADD      R6,R0,#+40
        LDRH     R1,[R6, #+4]
        LDR      R0,[R0, #+40]
        PUSH     {R0,R1}
        MOV      R3,R2
        MOV      R2,R5
        MOV      R1,R4
        LDRB     R0,[R6, #+7]
//  242 	udpPutStr(Wrcs1->nUSE, Str, Length, iEn, Wrcs1->destaddr, Wrcs1->destport);
        BL       udpPutStr
        ADD      SP,SP,#+8
//  243 	//SerPtr->printf("ip:%d.%d.%d.%d, port: %d\n", Wrcs1->destaddr[0], Wrcs1->destaddr[1] ,
//  244 	//											 Wrcs1->destaddr[2], Wrcs1->destaddr[3] ,
//  245 	//											Wrcs1->destport);
//  246 }
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable27:
        DC32     Wrcs1_RtnIP

        END
//  247 
//  248 
//  249 //////////////////////////////////////////////////////
//  250 // End of Source File
//  251 ////////////////////////
//  252 
// 
//    51 bytes in section .bss
// 3 144 bytes in section .data
// 1 156 bytes in section .text
// 
// 1 156 bytes of CODE memory
// 3 195 bytes of DATA memory
//
//Errors: none
//Warnings: none
