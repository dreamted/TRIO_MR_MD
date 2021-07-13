///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    02/Jan/2012  21:08:25 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\code\DIG_S /
//                    ER.c                                                    /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\code\DIG_S /
//                    ER.c -lcN D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\ /
//                    sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\ /
//                    sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\s /
//                    out\ --endian=little --cpu=Cortex-M3 -e                 /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120102\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120102\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120102\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\sout\DIG_S /
//                    ER.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME DIG_SER

        EXTERN ASK_ReturnOnOff
        EXTERN ASK_Test
        EXTERN ChkDigCtrl
        EXTERN DelayChk
        EXTERN DownLoadGiveupTimerSet
        EXTERN ExpioBitRst
        EXTERN ExpioBitSet
        EXTERN GenBodyFrame
        EXTERN GenMCUtoDigSts
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN ProtocolCheck
        EXTERN ProtocolComCheck
        EXTERN SerPtr
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN WRCS_ProDataAckTx
        EXTERN __aeabi_memclr4
        EXTERN pUSART3
        EXTERN tRmtSts
        EXTERN tTestFlag

        PUBLIC CFRInit
        PUBLIC DecDigSendCnt
        PUBLIC DigControl
        PUBLIC DigDataAckTx
        PUBLIC DigInit
        PUBLIC DigLinkFailCheck
        PUBLIC DigLinkFailCnt
        PUBLIC DigLinkFailRst
        PUBLIC DigSer
        PUBLIC DigSerB
        PUBLIC DigTask
        PUBLIC DigTaskStk
        PUBLIC DigTransmitData
        PUBLIC DigTx
        PUBLIC Dig_BandSelect
        PUBLIC IncDigSendCnt
        PUBLIC IsItDigSent
        PUBLIC ODU_Reset_Ctrl
        PUBLIC RDigSio
        PUBLIC SDigSio

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\code\DIG_SER.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_bkp.c
//    3 * Author             : MCD Application Team
//    4 * Date First Issued  : 09/29/2006
//    5 * Description        : This file provides all the BKP firmware functions.
//    6 ********************************************************************************/
//    7 
//    8 #define DIG_C
//    9 
//   10 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data DigLinkFailCnt
DigLinkFailCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// __ProtocolPtr __data DigSerB
DigSerB:
        DS8 40

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data DigTx
DigTx:
        DATA
        DC8 0
// INT8U __data CFRInit
CFRInit:
        DC8 1
        DC8 0, 0
// __ProtocolPtr *__data DigSer
DigSer:
        DC32 DigSerB
// OS_STK __data DigTaskStk[256]
DigTaskStk:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __WRCSSIO __data SDigSio
SDigSio:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
// __WRCSSIO __data RDigSio
RDigSio:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
//   11 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   12 void DigInit(void)
//   13 {
DigInit:
        PUSH     {R4,LR}
//   14   	DigSer->CheckByte 	= pUSART3.CheckByte;
        LDR.W    R4,??DataTable18  ;; DigTx
        LDR      R0,[R4, #+4]
        LDR.N    R1,??DigInit_0   ;; pUSART3
        LDR      R2,[R1, #+4]
        STR      R2,[R0, #+0]
//   15 	DigSer->RxGetByte 	= pUSART3.RxGetByte;
        LDR      R2,[R1, #+8]
        STR      R2,[R0, #+4]
//   16 	DigSer->PutStr 		= pUSART3.PutStr;
        LDR      R2,[R1, #+12]
        STR      R2,[R0, #+8]
//   17 	DigSer->TxCheckByte = pUSART3.TxCheckByte;
        LDR      R1,[R1, #+28]
        STR      R1,[R0, #+16]
//   18 	
//   19 	DigSer->TimerRx 	= TimerDigRx;
        MOVS     R1,#+10
        STRH     R1,[R0, #+20]
//   20 	DigSer->TimerEndWait = TimerDigEndWait;
        MOVS     R1,#+11
        STRH     R1,[R0, #+22]
//   21 	DigSer->WRCSRecv 	= &RDigSio;
        ADD      R1,R4,#+2080
        STR      R1,[R0, #+28]
//   22 	DigSer->WRCSSend 	= &SDigSio;
        ADD      R1,R4,#+1032
        STR      R1,[R0, #+32]
//   23 	
//   24 	DigSer->Sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+4]
        STR      R0,[R1, #+36]
//   25 	OSTaskCreate(DigTask, (void *)NULL, (OS_STK *)&DigTaskStk[Dig_START_STK_SIZE - 1], DigTASK_PRIO);
        MOVS     R3,#+3
        ADDW     R2,R4,#+1028
        MOVS     R1,#+0
        LDR.N    R0,??DigInit_0+0x4  ;; DigTask
        POP      {R4,LR}
        B.W      OSTaskCreate
        Nop      
        DATA
??DigInit_0:
        DC32     pUSART3
        DC32     DigTask
//   26  }
//   27 
//   28 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   29 void DigTask(void * pdata)
//   30 {
DigTask:
        PUSH     {R3-R9,LR}
//   31 	INT8U DigPollwait = 0;
        MOVS     R7,#+0
//   32     INT8U DigID = 0;
//   33 	__ProtocolPtr *nPtr = (__ProtocolPtr *)DigSer;
        LDR.N    R4,??DataTable18  ;; DigTx
        LDR      R5,[R4, #+4]
//   34 
//   35 	ExpioBitSet(Dig_Reset);
        MOVS     R0,#+4
        BL       ExpioBitSet
//   36 	ExpioBitSet(FSK_EN);
        MOVS     R0,#+5
        BL       ExpioBitSet
//   37 
//   38  	//USART1Printf("DigTask %s %s\n", __DATE__, __TIME__);
//   39 	OSTimeDly(1000L*5L);
        MOVW     R0,#+5000
        BL       OSTimeDly
        LDR.W    R9,??DigTask_0   ;; DelayChk
        LDR.N    R6,??DigTask_0+0x4  ;; ASK_Test
        LDR.W    R8,??DigTask_0+0x8  ;; tTestFlag
        B.N      ??DigTask_1
//   40 
//   41 	while(1)
//   42 	{
//   43 		// Only Downloading
//   44 		while((DownLoadGiveupTimerSet(NULL)))
//   45 		{
//   46 			nPtr->WRCSRecv->cBody = 0;
//   47 			
//   48 			if(ProtocolCheck(nPtr))
//   49 			{
//   50 			#if TWO_BODY >= 2
//   51 				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   52 				{
//   53 			#endif
//   54 					ProtocolComCheck(nPtr);
//   55 			#if TWO_BODY >= 2
//   56 					nPtr->WRCSRecv->cBody++;
//   57 				}
//   58 			#endif
//   59 				DigLinkFailRst(DigID);
//   60  			}
//   61 			DecDigSendCnt();
//   62 			OSTimeDly(200L);
//   63 		}
//   64 		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
//   65 		{
//   66 			nPtr->WRCSRecv->cBody = 0;
//   67 
//   68 			if(!IsItDigSent() && (++DigPollwait >= DigInt))
//   69 			{
//   70 				INT8U *dptr = nPtr->WRCSSend->BodyFrame[0].SubData;
//   71 				if((tRmtSts->CommCnt.Dig_RxCnt.Data > 1)&& CFRInit)
//   72 				{
//   73 					INT16S len = GenMCUtoDigSts(dptr, tRmtSts,0);
//   74 					DigTransmitData(0xFF, 0xFF, CFRModule , (INT8U *)dptr, len, ModuleInformStsQue, nPtr);
//   75 				}
//   76 				else
//   77 				{
//   78 					if(ASK_Test)	
//   79 					{
//   80 						ASK_ReturnOnOff();
//   81 						TimerRegist(Timer_ASK, Time100mSec*10L);
//   82 						DelayChk = SET;
//   83 					}
//   84 					else
//   85 					{
//   86 						INT16S len = GenMCUtoDigSts(dptr, tRmtSts,0);
//   87 						DigTransmitData(0xFF, 0xFF, CFRModule , (INT8U *)dptr, len, StatusQue, nPtr);
//   88 					}
//   89 				}
//   90 
//   91 				DigPollwait = 0;
//   92 			}
//   93 			if(IsItDigSent() && ProtocolCheck(nPtr))
//   94 			{
//   95 				DecDigSendCnt();
//   96 			#if TWO_BODY >= 2
//   97 				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   98 				{
//   99 			#endif
//  100 					ProtocolComCheck(nPtr);
//  101 			#if TWO_BODY >= 2
//  102 					nPtr->WRCSRecv->cBody++;
//  103 				}
//  104 			#endif
//  105 				DigLinkFailRst(DigID);
//  106  			}
//  107 			else DecDigSendCnt();
//  108 			
//  109 			OSTimeDly(200L);
//  110 		}
//  111 		DecDigSendCnt();
??DigTask_2:
        BL       DecDigSendCnt
//  112 		OSTimeDly(100L);
        MOVS     R0,#+100
??DigTask_3:
        BL       OSTimeDly
??DigTask_1:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBZ      R0,??DigTask_4
        LDR      R0,[R5, #+28]
        MOVS     R1,#+0
        STRB     R1,[R0, #+1047]
        MOV      R0,R5
        BL       ProtocolCheck
        CBZ      R0,??DigTask_5
        MOV      R0,R5
        BL       ProtocolComCheck
        MOVS     R0,#+0
        BL       DigLinkFailRst
??DigTask_5:
        BL       DecDigSendCnt
        MOVS     R0,#+200
        B.N      ??DigTask_3
??DigTask_6:
        BL       DecDigSendCnt
??DigTask_7:
        MOVS     R0,#+200
        BL       OSTimeDly
??DigTask_4:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CMP      R0,#+0
        BNE.N    ??DigTask_2
        LDRB     R0,[R8, #+0]
        CMP      R0,#+0
        BNE.N    ??DigTask_2
        LDR      R0,[R5, #+28]
        MOVS     R1,#+0
        STRB     R1,[R0, #+1047]
        LDRB     R0,[R4, #+0]
        CBNZ     R0,??DigTask_8
        ADDS     R0,R7,#+1
        UXTB     R7,R0
        CMP      R7,#+3
        BCC.N    ??DigTask_6
        LDR      R0,[R5, #+32]
        ADD      R7,R0,#+15
        LDR.N    R0,??DataTable13  ;; tRmtSts
        LDR      R1,[R0, #+0]
        LDRH     R0,[R1, #+36]
        CMP      R0,#+2
        BCC.N    ??DigTask_9
        LDRB     R0,[R4, #+1]
        CBZ      R0,??DigTask_9
        MOVS     R2,#+0
        MOV      R0,R7
        BL       GenMCUtoDigSts
        PUSH     {R5,LR}
        MOVS     R1,#+96
        B.N      ??DigTask_10
??DigTask_9:
        LDRB     R0,[R6, #+0]
        CBZ      R0,??DigTask_11
        BL       ASK_ReturnOnOff
        MOV      R1,#+1000
        MOVS     R0,#+17
        BL       TimerRegist
        MOVS     R0,#+1
        STRB     R0,[R9, #+0]
        B.N      ??DigTask_12
??DigTask_11:
        MOVS     R2,#+0
        MOV      R0,R7
        BL       GenMCUtoDigSts
        PUSH     {R5,LR}
        MOVS     R1,#+0
??DigTask_10:
        PUSH     {R0,R1}
        MOV      R3,R7
        MOVS     R2,#+36
        MOVS     R1,#+255
        MOVS     R0,#+255
        BL       DigTransmitData
        ADD      SP,SP,#+16
??DigTask_12:
        MOVS     R7,#+0
??DigTask_8:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??DigTask_6
        MOV      R0,R5
        BL       ProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??DigTask_6
        BL       DecDigSendCnt
        MOV      R0,R5
        BL       ProtocolComCheck
        MOVS     R0,#+0
        BL       DigLinkFailRst
        B.N      ??DigTask_7
        DATA
??DigTask_0:
        DC32     DelayChk
        DC32     ASK_Test
        DC32     tTestFlag
//  113 	}
//  114 }
//  115 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  116 void DigTransmitData(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U Count, INT8U Comm, __ProtocolPtr *nPtr)
//  117 {
DigTransmitData:
        PUSH     {R3-R11,LR}
        MOV      R10,R0
        MOV      R9,R1
        MOV      R8,R2
        MOV      R11,R3
        LDR      R4,[SP, #+40]
        LDR      R5,[SP, #+44]
        LDR      R7,[SP, #+48]
//  118 
//  119 	TimerRegist(DigSer->TimerEndWait, Time1Sec*3L);
        LDR.N    R6,??DataTable18  ;; DigTx
        MOVW     R1,#+3000
        LDR      R0,[R6, #+4]
        LDRH     R0,[R0, #+22]
        UXTB     R0,R0
        BL       TimerRegist
        B.N      ??DigTransmitData_0
//  120 	while(IsItDigSent()) // waiting until finish current job
//  121 	{
//  122 		if(TimeOverCheck(DigSer->TimerEndWait)) return;
??DigTransmitData_1:
        LDR      R0,[R6, #+4]
        LDRH     R0,[R0, #+22]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBNZ     R0,??DigTransmitData_2
//  123 		OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
//  124 	}
??DigTransmitData_0:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+0
        BNE.N    ??DigTransmitData_1
//  125 
//  126 	if(Comm == ControlQue)
        CMP      R5,#+1
        BNE.N    ??DigTransmitData_3
//  127 	{
//  128 		DigSer->ctrlsrc = (INT32U)nPtr;
        MOV      R2,R7
        LDR      R0,[R6, #+4]
        STR      R2,[R0, #+24]
//  129 		if(tRmtSts->TestMode== Debug_Test8)SerPtr->printf("3 : DigSer Comm[%d][%d]\n",Comm,DigSer->ctrlsrc);
        LDR.N    R0,??DataTable13  ;; tRmtSts
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+324]
        CMP      R0,#+16
        BNE.N    ??DigTransmitData_3
        MOVS     R1,#+1
        LDR.N    R0,??DigTransmitData_4  ;; `?<Constant "3 : DigSer Comm[%d][%d]\\n">`
        LDR.N    R3,??DigTransmitData_4+0x4  ;; SerPtr
        LDR      R3,[R3, #+0]
        LDR      R3,[R3, #+16]
        BLX      R3
//  130 	}
//  131 	DigDataAckTx(id0, id1, id2, Data, Count, Comm, DigSer);
??DigTransmitData_3:
        LDR      R7,[R6, #+4]
        MOVS     R1,#+0
        MOV      R0,R7
        PUSH     {R0,R1}
        MOV      R1,R5
        UXTH     R0,R4
        PUSH     {R0,R1}
        MOV      R3,R11
        MOV      R2,R8
        MOV      R1,R9
        MOV      R0,R10
        BL       GenBodyFrame
        ADD      SP,SP,#+16
        MOV      R0,R7
        BL       WRCS_ProDataAckTx
        LDRB     R0,[R6, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+0]
        MOV      R0,R8
        BL       DigLinkFailCheck
//  132 
//  133 	if(ChkDigCtrl)ChkDigCtrl = RESET;
        LDR.N    R0,??DataTable16  ;; ChkDigCtrl
        LDRB     R1,[R0, #+0]
        CBZ      R1,??DigTransmitData_2
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
??DigTransmitData_2:
        POP      {R0,R4-R11,PC}   ;; return
        Nop      
        DATA
??DigTransmitData_4:
        DC32     `?<Constant "3 : DigSer Comm[%d][%d]\\n">`
        DC32     SerPtr
//  134 }
//  135 
//  136 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  137 void DigDataAckTx(INT8U id0, INT8U id1, INT8U id2, INT8U *Data, INT16U nCnt,
//  138 					INT8U Comm, __ProtocolPtr *nPtr)
//  139 {
DigDataAckTx:
        PUSH     {R3-R7,LR}
        MOV      R7,R0
        MOV      R12,R1
        MOV      R4,R2
        LDR      R5,[SP, #+24]
        LDR      R2,[SP, #+28]
        LDR      R6,[SP, #+32]
//  140 	GenBodyFrame(id0, id1, id2, (INT8U *)Data, nCnt, Comm, nPtr, 0);
        MOVS     R1,#+0
        MOV      R0,R6
        PUSH     {R0,R1}
        MOV      R1,R2
        UXTH     R0,R5
        PUSH     {R0,R1}
        MOV      R2,R4
        MOV      R1,R12
        MOV      R0,R7
        BL       GenBodyFrame
        ADD      SP,SP,#+16
//  141 	WRCS_ProDataAckTx(nPtr);
        MOV      R0,R6
        BL       WRCS_ProDataAckTx
//  142  
//  143 	IncDigSendCnt();
        LDR.N    R0,??DataTable18  ;; DigTx
        LDRB     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+0]
//  144 	DigLinkFailCheck(id2);
        MOV      R0,R4
        POP      {R1,R4-R7,LR}
        B.N      DigLinkFailCheck
//  145 }
//  146 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  147 INT8U IsItDigSent(void)
//  148 {
//  149 	return DigTx;
IsItDigSent:
        LDR.N    R0,??DataTable18  ;; DigTx
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//  150 }
//  151 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  152 void IncDigSendCnt(void)
//  153 {
//  154 	DigTx++;
IncDigSendCnt:
        LDR.N    R0,??DataTable18  ;; DigTx
        LDRB     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+0]
//  155 }
        BX       LR               ;; return
//  156 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  157 void DecDigSendCnt(void)
//  158 {
//  159 	if(DigTx) DigTx--;
DecDigSendCnt:
        LDR.N    R0,??DataTable18  ;; DigTx
        LDRB     R1,[R0, #+0]
        CBZ      R1,??DecDigSendCnt_0
        SUBS     R1,R1,#+1
        STRB     R1,[R0, #+0]
//  160 }
??DecDigSendCnt_0:
        BX       LR               ;; return
//  161 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  162 void DigLinkFailCheck(INT8U DigID)
//  163 {
//  164 	if((++DigLinkFailCnt > 10))
DigLinkFailCheck:
        LDR.N    R0,??DataTable12  ;; DigLinkFailCnt
        LDRB     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+0]
        SXTB     R1,R1
        CMP      R1,#+11
        BLT.N    ??DigLinkFailCheck_0
//  165 	{
//  166 		DigLinkFailCnt = 11;
        MOVS     R1,#+11
        STRB     R1,[R0, #+0]
//  167 		tRmtSts->DEI_DnrAlm.Etc.DigLnkFail = 1;
        LDR.N    R0,??DataTable13  ;; tRmtSts
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+11]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #+11]
//  168    	}
//  169 }
??DigLinkFailCheck_0:
        BX       LR               ;; return
//  170 
//  171 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  172 void DigLinkFailRst(INT8U DigID)
//  173 {
//  174  	DigLinkFailCnt--;
//  175  	DigLinkFailCnt--;
DigLinkFailRst:
        LDR.N    R0,??DataTable12  ;; DigLinkFailCnt
        LDRB     R1,[R0, #+0]
        SUBS     R1,R1,#+2
//  176 	if(DigLinkFailCnt < 0) DigLinkFailCnt = 0;
        SXTB     R1,R1
        CMP      R1,#+0
        BPL.N    ??DigLinkFailRst_0
        MOVS     R1,#+0
??DigLinkFailRst_0:
        STRB     R1,[R0, #+0]
//  177 	if(DigLinkFailCnt < 5) tRmtSts->DEI_DnrAlm.Etc.DigLnkFail = 0;
        LDRSB    R0,[R0, #+0]
        CMP      R0,#+5
        BGE.N    ??DigLinkFailRst_1
        LDR.N    R0,??DataTable13  ;; tRmtSts
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+11]
        AND      R1,R1,#0xFE
        STRB     R1,[R0, #+11]
//  178 }
??DigLinkFailRst_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     DigLinkFailCnt

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13:
        DC32     tRmtSts
//  179 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  180 void Dig_BandSelect(INT8U Val)
//  181 {
Dig_BandSelect:
        PUSH     {R4,LR}
        SUB      SP,SP,#+32
        MOV      R4,R0
//  182 	INT8U tmpData[30] = {0,};
        ADD      R0,SP,#+0
        MOVS     R1,#+32
        BL       __aeabi_memclr4
//  183 	INT8U tmpLen = 0;
//  184 
//  185 	tmpData[tmpLen++] = (Aid_BandSelect_LTE >> 8) & 0xff;
        MOVS     R0,#+16
        STRB     R0,[SP, #+0]
//  186 	tmpData[tmpLen++] = (Aid_BandSelect_LTE >> 0) & 0xff;
        MOVS     R0,#+66
        STRB     R0,[SP, #+1]
//  187 	tmpData[tmpLen++] = 1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+2]
//  188 	tmpData[tmpLen++] = Val;
        STRB     R4,[SP, #+3]
//  189 
//  190 	ChkDigCtrl = SET;
        LDR.N    R0,??DataTable16  ;; ChkDigCtrl
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  191 	DigTransmitData(0xFF, 0xFF, CFRModule , (INT8U *)tmpData, tmpLen, ControlQue, DigSer);
        LDR.N    R0,??DataTable18  ;; DigTx
        LDR      R0,[R0, #+4]
        PUSH     {R0,LR}
        MOVS     R0,#+4
        PUSH     {R0,R1}
        ADD      R3,SP,#+16
        MOVS     R2,#+36
        MOVS     R1,#+255
        MOVS     R0,#+255
        BL       DigTransmitData
        ADD      SP,SP,#+16
//  192 }
        ADD      SP,SP,#+32
        POP      {R4,PC}          ;; return
//  193 
//  194 
//  195 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  196 void ODU_Reset_Ctrl(void)
//  197 {
ODU_Reset_Ctrl:
        PUSH     {LR}
        SUB      SP,SP,#+12
//  198 	INT8U tmpData[10] = {0,};
        ADD      R0,SP,#+0
        MOVS     R1,#+12
        BL       __aeabi_memclr4
//  199 	INT8U tmpLen = 0;
//  200 
//  201 	tmpData[tmpLen++] = (Aid_OptReset >> 8) & 0xff;
        MOVS     R0,#+165
        STRB     R0,[SP, #+0]
//  202 	tmpData[tmpLen++] = (Aid_OptReset >> 0) & 0xff;
        MOVS     R0,#+0
        STRB     R0,[SP, #+1]
//  203 	tmpData[tmpLen++] = 1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+2]
//  204 	tmpData[tmpLen++] = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+3]
//  205 	ChkDigCtrl = SET;
        LDR.N    R0,??DataTable16  ;; ChkDigCtrl
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  206 
//  207 	DigTransmitData(0xFF, 0xFF, CFRModule , (INT8U *)tmpData, tmpLen, ControlQue, DigSer);
        LDR.N    R0,??DataTable18  ;; DigTx
        LDR      R0,[R0, #+4]
        PUSH     {R0,LR}
        MOVS     R0,#+4
        PUSH     {R0,R1}
        ADD      R3,SP,#+16
        MOVS     R2,#+36
        MOVS     R1,#+255
        MOVS     R0,#+255
        BL       DigTransmitData
        ADD      SP,SP,#+16
//  208  
//  209 	ExpioBitRst(Dig_Reset);
        MOVS     R0,#+4
        BL       ExpioBitRst
//  210 	OSTimeDly(400);
        MOV      R0,#+400
        BL       OSTimeDly
//  211 	ExpioBitSet(Dig_Reset);
        MOVS     R0,#+4
        BL       ExpioBitSet
//  212  }
        ADD      SP,SP,#+12
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable16:
        DC32     ChkDigCtrl
//  213 
//  214 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  215 void DigControl(INT16U AID_Command,INT8U Index)
//  216 {
DigControl:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+20
        MOV      R4,R0
        MOV      R5,R1
//  217  	INT8U tmpData[20] = {0,};
        ADD      R0,SP,#+0
        MOVS     R1,#+20
        BL       __aeabi_memclr4
//  218 	INT8U tmpLen = 0;
//  219 
//  220 	tmpData[tmpLen++] = (AID_Command >> 8) & 0xff;
        LSRS     R0,R4,#+8
        STRB     R0,[SP, #+0]
//  221 	tmpData[tmpLen++] = (AID_Command >> 0) & 0xff;
        STRB     R4,[SP, #+1]
//  222 	tmpData[tmpLen++] = 1;
        MOVS     R0,#+1
        STRB     R0,[SP, #+2]
//  223 	tmpData[tmpLen++] = Index;
        STRB     R5,[SP, #+3]
//  224 
//  225 	DigTransmitData(0xFF, 0xFF, CFRModule , (INT8U *)tmpData, tmpLen, ControlQue, DigSer);
        LDR.N    R0,??DataTable18  ;; DigTx
        LDR      R0,[R0, #+4]
        PUSH     {R0,LR}
        MOVS     R1,#+1
        MOVS     R0,#+4
        PUSH     {R0,R1}
        ADD      R3,SP,#+16
        MOVS     R2,#+36
        MOVS     R1,#+255
        MOVS     R0,#+255
        BL       DigTransmitData
        ADD      SP,SP,#+16
//  226  }
        ADD      SP,SP,#+20
        POP      {R4,R5,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable18:
        DC32     DigTx

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "3 : DigSer Comm[%d][%d]\\n">`:
        DATA
        DC8 "3 : DigSer Comm[%d][%d]\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        END
//  227 
//  228 
//  229 ////////////////////////////////////////////////////////////////////////////////
//  230 // End of Source File
//  231 /////////////////////////
//  232 
// 
//    41 bytes in section .bss
// 3 128 bytes in section .data
//    92 bytes in section .rodata
//   928 bytes in section .text
// 
//   928 bytes of CODE  memory
//    92 bytes of CONST memory
// 3 169 bytes of DATA  memory
//
//Errors: none
//Warnings: none
