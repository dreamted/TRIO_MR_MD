///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    30/Aug/2012  21:29:29 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_serial1.c /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_serial1.c /
//                     -D OS_INCLUDED -D APPL_SRC -lcN                        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -lB         /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -o          /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\             /
//                    --endian=little --cpu=Cortex-M3 -e --fpu=None           /
//                    --dlib_config "C:\Programming\IAR Systems\Embedded      /
//                    Workbench 6.0\arm\INC\c\DLib_Config_Normal.h" -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\include\ -I       /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\..\..\STM32F2xx_S /
//                    tdPeriph_Driver\ -I D:\Work\Project\2012\NL_INBUILD\FW\ /
//                    MU\..\..\STM32F2xx_StdPeriph_Driver\inc\ -I             /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-CPU\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-LIB\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Ports\    /
//                    -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Source /
//                    \ -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-Probe\    /
//                    -Oh --use_c++_inline --require_prototypes               /
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\aa_serial1.s /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_serial1

        #define SHT_PROGBITS 0x1

        EXTERN Crc16Calc
        EXTERN DownLoadBootingJump
        EXTERN DownloadFlagSet
        EXTERN FLASHpAPBK_Check_Erase
        EXTERN Initialize
        EXTERN OSSemCreate
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN SerPtr
        EXTERN SetDnrCtrlData
        EXTERN TestInit
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN UpLoadData
        EXTERN __aeabi_memcpy
        EXTERN __aeabi_memset
        EXTERN pUSART1
        EXTERN tTestFlag

        PUBLIC APEraseFlag
        PUBLIC Booting
        PUBLIC DataCount
        PUBLIC DnReceiveData
        PUBLIC DownLoadGiveupTimerChk
        PUBLIC DownLoadGiveupTimerRst
        PUBLIC DownLoadGiveupTimerSet
        PUBLIC DownloadFunc
        PUBLIC FlashEraseChk
        PUBLIC FrameCnt
        PUBLIC FrameCounter
        PUBLIC FrameCounterOld
        PUBLIC HuStatus
        PUBLIC HuStatusB
        PUBLIC MuStatus
        PUBLIC MuStatusB
        PUBLIC PcSer
        PUBLIC PcSerB
        PUBLIC ProtocolCheck
        PUBLIC ProtocolComCheck
        PUBLIC Rsio
        PUBLIC RuStatus
        PUBLIC RuStatusB
        PUBLIC Ser1Init
        PUBLIC Ser1Task
        PUBLIC Ser1TaskStk
        PUBLIC SioDataAckTx
        PUBLIC Ssio
        PUBLIC Swcrc16
        PUBLIC TotFrame
        PUBLIC downloadFlag
        PUBLIC iDebugCnt
        PUBLIC iResetCase
        PUBLIC iUser_Value2
        PUBLIC scriptIndex

// D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_serial1.c
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
//   11 #define SER1INT_C
//   12 
//   13 #include "../include/main.h"

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute OS_STK Ser1TaskStk[300]
Ser1TaskStk:
        DS8 1200

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute __ProtocolPtr PcSerB
PcSerB:
        DS8 48

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
// __absolute INT8U FlashEraseChk
FlashEraseChk:
        DS8 1

        SECTION `.data`:DATA:REORDER:NOROOT(2)
// __absolute INT8U iDebugCnt
iDebugCnt:
        DATA
        DC8 0
// __absolute INT8U iUser_Value2
iUser_Value2:
        DC8 0
        DC8 0, 0
// __absolute __ProtocolPtr *PcSer
PcSer:
        DC32 PcSerB
// __absolute __MU_STS *MuStatus
MuStatus:
        DC32 MuStatusB
// __absolute __HU_STS *HuStatus
HuStatus:
        DC32 HuStatusB
// __absolute __RU_STS *RuStatus
RuStatus:
        DC32 RuStatusB
// __absolute INT32U downloadFlag
downloadFlag:
        DC32 0
// __absolute __MU_STS MuStatusB
MuStatusB:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
// __absolute __HU_STS HuStatusB
HuStatusB:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __absolute __RU_STS RuStatusB
RuStatusB:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
// __absolute SIO Ssio
Ssio:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __absolute SIO Rsio
Rsio:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
// __absolute INT8U iResetCase
iResetCase:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
// __absolute INT8U Booting[2]
Booting:
        DS8 2
//   14 #include "download.c"

        SECTION `.data`:DATA:REORDER:NOROOT(1)
// __absolute INT16U FrameCounterOld
FrameCounterOld:
        DATA
        DC16 65535

        SECTION `.data`:DATA:REORDER:NOROOT(1)
// __absolute INT16U FrameCounter
FrameCounter:
        DATA
        DC16 65535

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
// __absolute INT8U scriptIndex
scriptIndex:
        DS8 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __interwork __softfp INT32U DownLoadGiveupTimerSet(INT32U)
DownLoadGiveupTimerSet:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable10
        CBZ.N    R0,??DownLoadGiveupTimerSet_0
        STR      R0,[R4, #+20]
        MOVW     R1,#+20000
        MOVS     R0,#+4
        BL       TimerRegist
??DownLoadGiveupTimerSet_0:
        LDR      R0,[R4, #+20]
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __interwork __softfp void DownLoadGiveupTimerRst(void)
DownLoadGiveupTimerRst:
        LDR.W    R0,??DataTable10
        MOVS     R1,#+0
        STR      R1,[R0, #+20]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __interwork __softfp BOOL DownLoadGiveupTimerChk(__ProtocolPtr *)
DownLoadGiveupTimerChk:
        PUSH     {R4,LR}
        LDR.W    R4,??DataTable10
        LDR      R1,[R4, #+4]
        CMP      R0,R1
        BNE.N    ??DownLoadGiveupTimerChk_0
        MOVS     R0,#+4
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??DownLoadGiveupTimerChk_0
        MOVS     R0,#+0
        STR      R0,[R4, #+20]
        MOVS     R0,#+1
        POP      {R4,PC}
??DownLoadGiveupTimerChk_0:
        MOVS     R0,#+0
        POP      {R4,PC}          ;; return

        SECTION `.data`:DATA:REORDER:NOROOT(2)
// __absolute INT16U FrameCnt
FrameCnt:
        DATA
        DC16 65535
// __absolute INT16U TotFrame
TotFrame:
        DC16 65535
// __absolute INT16U Swcrc16
Swcrc16:
        DC16 0
        DC8 0, 0
// __absolute INT32S DataCount
DataCount:
        DC32 -1
// __absolute int APEraseFlag
APEraseFlag:
        DC32 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __interwork __softfp INT8U DownloadFunc(__ProtocolPtr *)
DownloadFunc:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+32
        MOV      R8,R0
        ADD      R0,SP,#+8
        MOVS     R1,#+0
        MOVS     R2,#+0
        MOV      R3,R1
        STM      R0!,{R1-R3}
        MOV      R6,R1
        MOV      R4,R1
        MOV      R7,R1
        LDR      R5,[R8, #+36]
        LDRB     R0,[R5, #+10]
        CMP      R0,#+16
        BEQ.N    ??DownloadFunc_0
        BCC.N    ??DownloadFunc_1
        CMP      R0,#+18
        BEQ.N    ??DownloadFunc_2
        BCC.N    ??DownloadFunc_3
        B.N      ??DownloadFunc_1
??DownloadFunc_0:
        LDRB     R0,[R5, #+13]
        STRB     R0,[SP, #+8]
        ADD      R6,SP,#+8
        LDRB     R0,[R5, #+14]
        STRB     R0,[R6, #+1]
        LDRB     R0,[R5, #+15]
        STRB     R0,[R6, #+2]
        LDRB     R0,[R5, #+16]
        STRB     R0,[R6, #+3]
        LDRB     R0,[R5, #+17]
        STRB     R0,[R6, #+4]
        LDRB     R0,[R5, #+18]
        STRB     R0,[R6, #+5]
        LDRB     R0,[R5, #+18]
        LDRB     R1,[R5, #+17]
        ORR      R0,R1,R0, LSL #+8
        LDR.W    R1,??DataTable10_1
        STRH     R0,[R1, #+2]
        BL       OS_CPU_SR_Save
        MOV      R7,R0
        BL       FLASHpAPBK_Check_Erase
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
        STRB     R0,[R6, #+6]
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
        MOVS     R0,#+128
        STRB     R0,[R6, #+7]
        MOVS     R6,#+8
        MOVS     R4,#+144
        B.N      ??DownloadFunc_1
??DownloadFunc_3:
        MOV      R0,R8
        BL       DnReceiveData
        CBZ.N    R0,??DownloadFunc_4
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+12]
        CBZ.N    R0,??DownloadFunc_4
        MOVS     R7,#+1
??DownloadFunc_4:
        LDRB     R0,[R5, #+13]
        STRB     R0,[SP, #+8]
        ADD      R6,SP,#+8
        LDRB     R0,[R5, #+14]
        STRB     R0,[R6, #+1]
        LDRB     R0,[R5, #+15]
        STRB     R0,[R6, #+2]
        LDRB     R0,[R5, #+16]
        STRB     R0,[R6, #+3]
        STRB     R7,[R6, #+4]
        MOVS     R6,#+5
        MOVS     R4,#+145
        B.N      ??DownloadFunc_1
??DownloadFunc_2:
        LDRB     R0,[R5, #+13]
        STRB     R0,[SP, #+8]
        ADD      R6,SP,#+8
        LDRB     R0,[R5, #+14]
        STRB     R0,[R6, #+1]
        LDRB     R0,[R5, #+20]
        LDRB     R1,[R5, #+19]
        ORR      R0,R1,R0, LSL #+8
        LDR.W    R1,??DataTable10_1
        LDRH     R2,[R1, #+4]
        STRB     R2,[R6, #+2]
        LSRS     R3,R2,#+8
        STRB     R3,[R6, #+3]
        CMP      R2,R0
        BNE.N    ??DownloadFunc_5
        LDRH     R0,[R1, #+2]
        LDRH     R1,[R1, #+0]
        ADDS     R1,R1,#+1
        CMP      R0,R1
        ITT      EQ 
        MOVEQ    R0,#+1
        STRBEQ   R0,[R6, #+4]
        BEQ.N    ??DownloadFunc_6
??DownloadFunc_5:
        STRB     R7,[R6, #+4]
??DownloadFunc_6:
        MOVS     R0,#+128
        STRB     R0,[R6, #+5]
        STRB     R0,[R6, #+6]
        STRB     R0,[R6, #+7]
        MOVS     R6,#+8
        MOVS     R4,#+146
??DownloadFunc_1:
        ADD      R0,SP,#+24
        ADDS     R1,R5,#+4
        MOVS     R2,#+3
        BL       __aeabi_memcpy
        ADD      R0,SP,#+20
        ADDS     R1,R5,#+7
        MOVS     R2,#+3
        BL       __aeabi_memcpy
        STR      R8,[SP, #+4]
        STR      R4,[SP, #+0]
        MOV      R3,R6
        ADD      R2,SP,#+8
        LDR      R1,[SP, #+24]
        LDR      R0,[SP, #+20]
        BL       SioDataAckTx
        LDRB     R0,[R5, #+10]
        CMP      R0,#+18
        BNE.N    ??DownloadFunc_7
        LDRB     R0,[SP, #+12]
        CMP      R0,#+1
        BNE.N    ??DownloadFunc_7
        MOVS     R0,#+10
        BL       OSTimeDly
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+8]
        BL       DownloadFlagSet
        BL       DownLoadBootingJump
??DownloadFunc_7:
        MOVS     R0,#+1
        ADD      SP,SP,#+32
        POP      {R4-R8,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __interwork __softfp BOOL DnReceiveData(__ProtocolPtr *)
DnReceiveData:
        PUSH     {R4-R8,LR}
        LDR      R4,[R0, #+36]
        LDRB     R0,[R4, #+16]
        LDRB     R1,[R4, #+15]
        ORRS     R5,R1,R0, LSL #+8
        LDR.N    R6,??DataTable10_1
        BNE.N    ??DnReceiveData_0
        MOVS     R0,#+0
        STR      R0,[R6, #+8]
        STRH     R0,[R6, #+4]
??DnReceiveData_1:
        LDRH     R0,[R4, #+1517]
        SUBS     R7,R0,#+4
        LDR      R3,[R6, #+8]
        UXTH     R2,R7
        ADD      R1,R4,#+17
        LDR.N    R0,??DataTable10_2  ;; 0x8020000
        BL       UpLoadData
        MOV      R8,R0
        STR      R8,[R6, #+8]
        LDRH     R2,[R6, #+4]
        MOV      R1,R7
        ADD      R0,R4,#+17
        BL       Crc16Calc
        STRH     R0,[R6, #+4]
        STRH     R5,[R6, #+0]
        CMN      R8,#+1
        BNE.N    ??DnReceiveData_2
??DnReceiveData_3:
        MOVS     R0,#+0
        B.N      ??DnReceiveData_4
??DnReceiveData_0:
        LDRH     R0,[R6, #+0]
        ADDS     R1,R0,#+1
        CMP      R5,R1
        BNE.N    ??DnReceiveData_3
        CMP      R5,R0
        BNE.N    ??DnReceiveData_1
??DnReceiveData_2:
        MOVS     R0,#+1
??DnReceiveData_4:
        POP      {R4-R8,PC}       ;; return
//   15 
//   16 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   17 void Ser1Init(void)
//   18 {
Ser1Init:
        PUSH     {R4,LR}
//   19  	PcSer->CheckByte = pUSART1.CheckByte;
        LDR.N    R4,??DataTable10
        LDR      R0,[R4, #+4]
        LDR.N    R1,??DataTable10_3
        LDR      R2,[R1, #+4]
        STR      R2,[R0, #+0]
//   20 	PcSer->RxGetByte = pUSART1.RxGetByte;
        LDR      R2,[R1, #+8]
        STR      R2,[R0, #+4]
//   21 	PcSer->PutStr = pUSART1.PutStr;
        LDR      R2,[R1, #+12]
        STR      R2,[R0, #+8]
//   22 	PcSer->TxCheckByte = pUSART1.TxCheckByte;
        LDR      R2,[R1, #+28]
        STR      R2,[R0, #+16]
//   23 	PcSer->BuffClear = pUSART1.BuffClear;
        LDR      R1,[R1, #+32]
        STR      R1,[R0, #+20]
//   24 
//   25 	PcSer->TimerRx = TimerSioRx;
        MOVS     R1,#+2
        STRH     R1,[R0, #+24]
//   26 
//   27 	PcSer->Recv = &Rsio;
        ADD      R1,R4,#+4096
        ADDS     R1,R1,#+48
        STR      R1,[R0, #+36]
//   28 	PcSer->Send = &Ssio;
        ADDW     R1,R4,#+2620
        STR      R1,[R0, #+40]
//   29 
//   30 	PcSer->OSSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+4]
        STR      R0,[R1, #+32]
//   31 
//   32 	MuStatus = &MuStatusB;
        ADD      R0,R4,#+24
        STR      R0,[R4, #+8]
//   33 	HuStatus = &HuStatusB;
        ADDW     R0,R4,#+992
        STR      R0,[R4, #+12]
//   34 	RuStatus = &RuStatusB;
        ADDW     R0,R4,#+1760
        STR      R0,[R4, #+16]
//   35 
//   36 	Initialize();
        BL       Initialize
//   37 	
//   38 	OSTaskCreate(Ser1Task, (void *)PcSer, (OS_STK *)&Ser1TaskStk[SER1_STK_SIZE - 1], SER1TASK_PRIO);
        MOVS     R3,#+3
        LDR.N    R2,??DataTable10_4
        LDR      R1,[R4, #+4]
        LDR.N    R0,??DataTable10_5
        POP      {R4,LR}
        B.W      OSTaskCreate
//   39 }
//   40 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 void Ser1Task(void *pdata)
//   42 {
Ser1Task:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   43 	__ProtocolPtr *nPtr = (__ProtocolPtr *)pdata;
//   44 
//   45     nPtr = nPtr;
//   46 	pdata = pdata;
//   47 	OSTimeDly(100*SER1TASK_PRIO);
        MOV      R0,#+300
        BL       OSTimeDly
        LDR.N    R5,??DataTable10_6
//   48 
//   49 	while(1)
//   50 	{
//   51 		if(!tTestFlag)
??Ser1Task_0:
        LDRB     R0,[R5, #+0]
        CBNZ.N   R0,??Ser1Task_1
//   52 		{
//   53 			if(ProtocolCheck(nPtr))
        MOV      R0,R4
        BL       ProtocolCheck
        CBZ.N    R0,??Ser1Task_1
//   54 			{
//   55 				ProtocolComCheck(nPtr);
        MOV      R0,R4
        BL       ProtocolComCheck
//   56 			}
//   57 		}
//   58 		DownLoadGiveupTimerChk(nPtr);
??Ser1Task_1:
        MOV      R0,R4
        BL       DownLoadGiveupTimerChk
//   59 		OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
        B.N      ??Ser1Task_0
//   60 	}
//   61 }
//   62 
//   63 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   64 INT32U ProtocolCheck(__ProtocolPtr *nPtr)
//   65 {
ProtocolCheck:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
//   66 	INT16U nCnt;
//   67 	INT16U i = 0, n = 0;
        MOVS     R5,#+0
//   68 	INT32U RetVal;
//   69 	INT8U Data;
//   70 	
//   71 	SIO *Recv = nPtr->Recv;
        LDR      R6,[R4, #+36]
//   72 
//   73 	TimerRegist(nPtr->TimerRx, Time1Sec*2L);
        MOV      R1,#+2000
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimerRegist
//   74 	Recv->Command = NULLcomm;	// RX Command Clear
        MOVS     R0,#+224
        STRB     R0,[R6, #+10]
//   75 
//   76 	//====================//
//   77 	// Sync Check 4 bytes //
//   78 	//======================================================================//
//   79 	n = 4;
//   80 	
//   81 	RetVal = FALSE;
        LDR.W    R10,??DataTable10_6
        LDR.W    R8,??DataTable10_7
        ADR.W    R9,`?<Constant "\\n H/W Test Mode...\\n">`
        LDR.N    R7,??DataTable10
        B.N      ??ProtocolCheck_0
//   82 	while (RetVal == FALSE)
//   83 	{
//   84 		if(TimeOverCheck(nPtr->TimerRx)) return FALSE;
//   85 
//   86 		if(nPtr->CheckByte(1, &nCnt))
//   87 		{
//   88 			Data = nPtr->RxGetByte();
//   89 			
//   90 			if(STX == Data/*nPtr->RxGetByte()*/)
//   91 			{
//   92 				if(nPtr->CheckByte(1, &nCnt))
//   93 				{
//   94 					if(STX == nPtr->RxGetByte())
//   95 					{
//   96 						if(nPtr->CheckByte(1, &nCnt))
//   97 						{
//   98 							if(STX == nPtr->RxGetByte())
//   99 							{
//  100 								if(nPtr->CheckByte(1, &nCnt))
//  101 								{
//  102 									if(STX == nPtr->RxGetByte())
//  103 									{
//  104 										Recv->Sync[0] = STX;
//  105 										Recv->Sync[1] = STX;
//  106 										Recv->Sync[2] = STX;
//  107 										Recv->Sync[3] = STX;
//  108 
//  109 										RetVal = TRUE;
//  110 									}
//  111 								}
//  112 								else OSTimeDly(100L);
//  113 							}
//  114 						}
//  115 						else OSTimeDly(100L);
//  116 					}
//  117 				} 
//  118 				else OSTimeDly(100L);
//  119 			}
//  120 			////////////////////////////////////////////////////////////////////
//  121 			else
//  122 			{
//  123 				if((nPtr == PcSer) && (downloadFlag == 0))
??ProtocolCheck_1:
        LDR      R1,[R7, #+4]
        CMP      R4,R1
        BNE.N    ??ProtocolCheck_0
        LDR      R1,[R7, #+20]
        CBNZ.N   R1,??ProtocolCheck_0
//  124 				{
//  125 					if((Data == 'x')||(Data == 'X'))
        CMP      R0,#+120
        BEQ.N    ??ProtocolCheck_2
        CMP      R0,#+88
        BNE.N    ??ProtocolCheck_0
//  126 					{
//  127 						iDebugCnt++;
??ProtocolCheck_2:
        LDRB     R0,[R7, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R7, #+0]
//  128 						
//  129 						if(iDebugCnt > 20)
        UXTB     R0,R0
        CMP      R0,#+21
        BCC.N    ??ProtocolCheck_0
//  130 						{
//  131 							nPtr->BuffClear();
        LDR      R0,[R4, #+20]
        BLX      R0
//  132 							
//  133 							SerPtr->printf("\n H/W Test Mode...\n");
        MOV      R0,R9
        LDR      R1,[R8, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  134 							iUser_Value2 = __ChangeDebug;
        MOVS     R0,#+13
        STRB     R0,[R7, #+1]
//  135 							TestInit();
        BL       TestInit
//  136 							tTestFlag = TRUE;
        MOVS     R0,#+1
        STRB     R0,[R10, #+0]
//  137 						}
//  138 					}
//  139 					else
//  140 					{
//  141 						//KeyProc(Data, SPICommand);
//  142 					}
//  143 				}
//  144 			}
??ProtocolCheck_0:
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ.N    R0,??ProtocolCheck_3
??ProtocolCheck_4:
        MOVS     R0,#+0
        B.N      ??ProtocolCheck_5
??ProtocolCheck_3:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ.N    R0,??ProtocolCheck_6
        LDR      R0,[R4, #+4]
        BLX      R0
        UXTB     R0,R0
        CMP      R0,#+22
        BNE.N    ??ProtocolCheck_1
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ.N    R0,??ProtocolCheck_6
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??ProtocolCheck_0
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ.N    R0,??ProtocolCheck_6
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??ProtocolCheck_0
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        BLX      R2
        CBZ.N    R0,??ProtocolCheck_6
        LDR      R0,[R4, #+4]
        BLX      R0
        CMP      R0,#+22
        BNE.N    ??ProtocolCheck_0
        STRB     R0,[R6, #+0]
        STRB     R0,[R6, #+1]
        STRB     R0,[R6, #+2]
        STRB     R0,[R6, #+3]
        MOV      R10,#+1
//  145 		} else OSTimeDly(100L);
//  146 	}
//  147 	
//  148 	TimerRegist(nPtr->TimerRx, Time1Sec);
        MOV      R1,#+1000
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimerRegist
//  149 
//  150 	//======================//
//  151 	// Header Check 5 bytes //
//  152 	//======================================================================//
//  153 	n = 6;
        B.N      ??ProtocolCheck_7
??ProtocolCheck_6:
        MOVS     R0,#+100
        BL       OSTimeDly
        B.N      ??ProtocolCheck_0
//  154 	while ( !nPtr->CheckByte(n, &nCnt) )
//  155 	{
//  156 		if (TRUE == TimeOverCheck(nPtr->TimerRx) ) return(FALSE);
??ProtocolCheck_8:
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+1
        BEQ.N    ??ProtocolCheck_4
//  157 		OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
//  158 	}
??ProtocolCheck_7:
        ADD      R1,SP,#+0
        MOVS     R0,#+6
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_8
//  159 	Recv->SrcID.MuID	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+4]
//  160 	Recv->SrcID.HuID	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+5]
//  161 	Recv->SrcID.RuID	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+6]
//  162 	Recv->DstID.MuID	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+7]
//  163 	Recv->DstID.HuID	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+8]
//  164 	Recv->DstID.RuID	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+9]
//  165 	Recv->Command	 	= nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+10]
//  166 	Recv->DataLength[0]   = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+11]
//  167 	Recv->DataLength[1]   = nPtr->RxGetByte();
        LDR      R0,[R4, #+4]
        BLX      R0
        STRB     R0,[R6, #+12]
//  168 	Recv->SubDataLength = (((INT16U)Recv->DataLength[0])<<8) + (((INT16U)Recv->DataLength[1])&0xff);
        LDRB     R0,[R6, #+11]
        LDRB     R1,[R6, #+12]
        ADD      R0,R1,R0, LSL #+8
        STRH     R0,[R6, #+1517]
//  169 	n = Recv->SubDataLength;
        LDRH     R7,[R6, #+1517]
//  170 	
//  171 //	if ( Recv->Command == DownLoadData ) n = 514;
//  172 
//  173 	//====================//
//  174 	// Data Check n bytes //
//  175 	//======================================================================//
//  176 	if ( n > BODYSIZEMAX ) return(FALSE);
        MOVW     R0,#+1501
        CMP      R7,R0
        BLT.N    ??ProtocolCheck_9
        B.N      ??ProtocolCheck_4
//  177 	while ( !nPtr->CheckByte(n + 2, &nCnt) )
//  178 	{
//  179 		if(TimeOverCheck(nPtr->TimerRx)) return(FALSE);
??ProtocolCheck_10:
        LDRH     R0,[R4, #+24]
        UXTB     R0,R0
        BL       TimeOverCheck
        CMP      R0,#+0
        BNE.N    ??ProtocolCheck_4
//  180 		OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
//  181 	}
??ProtocolCheck_9:
        ADD      R1,SP,#+0
        ADDS     R0,R7,#+2
        UXTH     R0,R0
        LDR      R2,[R4, #+0]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??ProtocolCheck_10
//  182 	for(i = 0; i < n+2; i++ )	Recv->Data[i] = nPtr->RxGetByte();
        ADD      R9,R7,#+2
        CMP      R9,#+1
        BLT.N    ??ProtocolCheck_11
??ProtocolCheck_12:
        LDR      R0,[R4, #+4]
        BLX      R0
        ADDS     R1,R5,R6
        STRB     R0,[R1, #+13]
        ADDS     R5,R5,#+1
        UXTH     R5,R5
        CMP      R5,R9
        BLT.N    ??ProtocolCheck_12
//  183 
//  184 	//===========//
//  185 	// CRC Check //
//  186 	//======================================================================//
//  187 	Recv->Crc = Crc16Calc( &Recv->SrcID.MuID, n + 9, NULL);
??ProtocolCheck_11:
        MOVS     R2,#+0
        ADD      R1,R7,#+9
        ADDS     R0,R6,#+4
        BL       Crc16Calc
        STRH     R0,[R6, #+1515]
//  188 	if ( (INT8U)(Recv->Crc>>8)	!= Recv->Data[n+0] ) RetVal = FALSE;
        ADDS     R0,R7,R6
        LDRH     R1,[R6, #+1515]
        LSRS     R1,R1,#+8
        LDRB     R2,[R0, #+13]
        CMP      R1,R2
        IT       NE 
        MOVNE    R10,#+0
//  189 	if ( (INT8U)(Recv->Crc) 	!= Recv->Data[n+1] ) RetVal = FALSE;
        LDRH     R1,[R6, #+1515]
        LDRB     R0,[R0, #+14]
        UXTB     R1,R1
        CMP      R1,R0
        BNE.W    ??ProtocolCheck_4
//  190 	//======================================================================//
//  191 	if ( RetVal == FALSE )
        CMP      R10,#+0
        BEQ.W    ??ProtocolCheck_4
//  192 	{
//  193 		return FALSE;
//  194 	}
//  195 	return TRUE;
        MOVS     R0,#+1
??ProtocolCheck_5:
        POP      {R1,R2,R4-R10,PC}  ;; return
//  196 }
//  197 
//  198 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  199 void ProtocolComCheck (__ProtocolPtr *nPtr)
//  200 {
ProtocolComCheck:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+20
        MOV      R4,R0
//  201 	SIO *Recv = nPtr->Recv;
        LDR      R5,[R4, #+36]
//  202 //	SIO *Send = nPtr->Send;
//  203 	
//  204 	switch(Recv->Command) //command üũ
        LDRB     R0,[R5, #+10]
        SUBS     R0,R0,#+16
        CMP      R0,#+2
        BLS.N    ??ProtocolComCheck_0
        SUBS     R0,R0,#+16
        BEQ.N    ??ProtocolComCheck_1
        SUBS     R0,R0,#+1
        BEQ.N    ??ProtocolComCheck_2
        B.N      ??ProtocolComCheck_3
??ProtocolComCheck_1:
        ADD      R0,SP,#+12
        ADDS     R1,R5,#+4
        MOVS     R2,#+3
        BL       __aeabi_memcpy
        ADD      R0,SP,#+8
        ADDS     R1,R5,#+7
        MOVS     R2,#+3
        BL       __aeabi_memcpy
//  205 	{
//  206 		//-----------------------------------------------------------------------//
//  207 		case StatusRQST:
//  208 			SioDataAckTx(Recv->DstID, Recv->SrcID, (INT8U*)MuStatus, sizeof(__MU_STS), StatusRSPS, nPtr);
        STR      R4,[SP, #+4]
        MOVS     R0,#+160
??ProtocolComCheck_4:
        STR      R0,[SP, #+0]
        MOVW     R3,#+966
        LDR.N    R0,??DataTable10
        LDR      R2,[R0, #+8]
        LDR      R1,[SP, #+12]
        LDR      R0,[SP, #+8]
        BL       SioDataAckTx
//  209 		break;
        B.N      ??ProtocolComCheck_3
//  210 
//  211 		case ControlRQST:
//  212 			if(Recv->SubDataLength != sizeof(__MU_CTRL)) break;
??ProtocolComCheck_2:
        LDRH     R0,[R5, #+1517]
        MOV      R1,#+324
        CMP      R0,R1
        BNE.N    ??ProtocolComCheck_3
//  213 
//  214 			SetDnrCtrlData((__MU_CTRL*)Recv->Data);
        ADD      R0,R5,#+13
        BL       SetDnrCtrlData
        ADD      R0,SP,#+12
        ADDS     R1,R5,#+4
        MOVS     R2,#+3
        BL       __aeabi_memcpy
        ADD      R0,SP,#+8
        ADDS     R1,R5,#+7
        MOVS     R2,#+3
        BL       __aeabi_memcpy
//  215 			SioDataAckTx(Recv->DstID, Recv->SrcID, (INT8U*)MuStatus, sizeof(__MU_STS), ControlRSPS, nPtr);
        STR      R4,[SP, #+4]
        MOVS     R0,#+161
        B.N      ??ProtocolComCheck_4
//  216 		break;
//  217 		
//  218 
//  219 /*		
//  220 		//-----------------------------------------------------------------------//
//  221 		case ResetCMD :
//  222 			SioDataAckTx(Recv->SUBID1, Recv->SUBID2, (INT8U *)"", 0, ResetCMD, nPtr);
//  223 			OSTimeDly(10L);
//  224 			//ResetCaseBackup(1);
//  225 			DownLoadBootingJump();
//  226 		break;
//  227 */
//  228 		//-----------------------------------------------------------------------//
//  229 		//	The End User Protocol..... Start DownLoad(Firmware)
//  230 		//	Down Load Protocol
//  231 		//-----------------------------------------------------------------------//
//  232 		case DownloadRQST:
//  233 		case DownDataRQST:
//  234 		case DownConfirmRQST:
//  235 			DownLoadGiveupTimerSet((INT32U)nPtr);
??ProtocolComCheck_0:
        MOV      R0,R4
        BL       DownLoadGiveupTimerSet
//  236 			DownloadFunc(nPtr);
        MOV      R0,R4
        BL       DownloadFunc
//  237 		break;
//  238 		
//  239 		//-----------------------------------------------------------------------//
//  240 	}
//  241 }
??ProtocolComCheck_3:
        ADD      SP,SP,#+20
        POP      {R4,R5,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     iDebugCnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     FrameCnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     0x8020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     pUSART1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     Ser1TaskStk+0x4AC

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     Ser1Task

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     tTestFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     SerPtr
//  242 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  243 void SioDataAckTx(SubIDStr SrcID, SubIDStr DstID, INT8U *Data, INT16U nCnt, INT8U Comm, __ProtocolPtr *toPtr)
//  244 {
SioDataAckTx:
        PUSH     {R0,R1,R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R8,R2
        MOV      R7,R3
        LDR      R4,[SP, #+40]
        LDR      R5,[SP, #+44]
//  245 	INT8U	err = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  246 	INT16U	i = 0;
//  247 	
//  248 	SIO *Send = toPtr->Send;
        LDR      R6,[R5, #+40]
//  249 	
//  250 	OSSemPend(toPtr->OSSem, 0, &err );
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R5, #+32]
        BL       OSSemPend
//  251 
//  252 	if( nCnt > BODYSIZEMAX ) {
        MOVW     R0,#+1501
        UXTH     R7,R7
        CMP      R7,R0
        BCS.N    ??SioDataAckTx_0
//  253 		OSSemPost(toPtr->OSSem);
//  254 		return;
//  255 	}
//  256 
//  257 	for(i=0; i<4; i++)
//  258 		Send->Sync[i]	= STX;
        MOVS     R2,#+22
        MOVS     R1,#+4
        MOV      R0,R6
        BL       __aeabi_memset
//  259 	Send->SrcID.MuID	= SrcID.MuID;
        LDRB     R0,[SP, #+8]
        STRB     R0,[R6, #+4]
//  260 	Send->SrcID.HuID	= SrcID.HuID;
        LDRB     R0,[SP, #+9]
        STRB     R0,[R6, #+5]
//  261 	Send->SrcID.RuID	= SrcID.RuID;
        LDRB     R0,[SP, #+10]
        STRB     R0,[R6, #+6]
//  262 	Send->DstID.MuID	= DstID.MuID;
        LDRB     R0,[SP, #+12]
        STRB     R0,[R6, #+7]
//  263 	Send->DstID.HuID	= DstID.HuID;
        LDRB     R0,[SP, #+13]
        STRB     R0,[R6, #+8]
//  264 	Send->DstID.RuID	= DstID.RuID;
        LDRB     R0,[SP, #+14]
        STRB     R0,[R6, #+9]
//  265 	Send->Command		= Comm;
        STRB     R4,[R6, #+10]
//  266 	Send->SubDataLength = nCnt;
        STRH     R7,[R6, #+1517]
//  267 	Send->DataLength[0] = (INT8U)(Send->SubDataLength>>8);
        LSRS     R0,R7,#+8
        STRB     R0,[R6, #+11]
//  268 	Send->DataLength[1] = (INT8U)(Send->SubDataLength&0xff);
        LDRH     R0,[R6, #+1517]
        STRB     R0,[R6, #+12]
//  269 
//  270 	for(i=0; i<nCnt && i < BODYSIZEMAX; i++)
        MOVS     R4,#+0
        MOV      R0,R6
        MOVW     R1,#+1500
        B.N      ??SioDataAckTx_1
//  271 		Send->Data[i]	= *((INT8U *)Data + i);
??SioDataAckTx_2:
        LDRB     R2,[R8], #+1
        STRB     R2,[R0, #+13]
        ADDS     R4,R4,#+1
        ADDS     R0,R0,#+1
??SioDataAckTx_1:
        CMP      R4,R7
        IT       LT 
        CMPLT    R4,R1
        BLT.N    ??SioDataAckTx_2
//  272 	
//  273 	Send->Crc = Crc16Calc((INT8U*)&Send->SrcID.MuID, i+9, NULL);
        MOVS     R2,#+0
        ADD      R1,R4,#+9
        ADDS     R0,R6,#+4
        BL       Crc16Calc
        STRH     R0,[R6, #+1515]
//  274 	Send->Data[i++] = (INT8U)(Send->Crc>>8);
        ADDS     R0,R4,R6
        LDRH     R1,[R6, #+1515]
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+13]
        ADDS     R0,R4,#+1
        UXTH     R0,R0
//  275 	Send->Data[i++] = (INT8U)(Send->Crc);  
        ADDS     R1,R0,R6
        LDRH     R2,[R6, #+1515]
        STRB     R2,[R1, #+13]
//  276 
//  277 	toPtr->PutStr((INT8U *)Send, i+13, ENABLE);
        MOVS     R2,#+1
        ADD      R1,R0,#+14
        UXTH     R1,R1
        MOV      R0,R6
        LDR      R3,[R5, #+8]
        BLX      R3
//  278 
//  279 	
//  280 	OSSemPost(toPtr->OSSem);
??SioDataAckTx_0:
        LDR      R0,[R5, #+32]
        BL       OSSemPost
//  281 }
        ADD      SP,SP,#+16
        POP      {R4-R8,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n H/W Test Mode...\\n">`:
        DC8 "\012 H/W Test Mode...\012"

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant {0}>`:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        END
//  282 
//  283 
//  284 
//  285 
//  286 
//  287 ////////////////////////////////////////////////////////////////////////////////
//  288 // End of Source File
//  289 /////////////////////
//  290 
// 
//    53 bytes in section .bss
// 5 688 bytes in section .data
//    12 bytes in section .rodata
// 1 448 bytes in section .text
// 1 200 bytes in section iram
// 
// 1 448 bytes of CODE  memory
//    12 bytes of CONST memory
// 6 941 bytes of DATA  memory
//
//Errors: none
//Warnings: 2
