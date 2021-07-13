///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jun/2011  18:42:04 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1. /
//                    0\code\aa_ethernet0.c                                   /
//    Command line =  "C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1 /
//                    .0\code\aa_ethernet0.c" -lcN "C:\user\project\HFR       /
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
//                    0\sout\aa_ethernet0.s                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_ethernet0

        EXTERN DnrSts
        EXTERN GenModuleAutoInformSts
        EXTERN IINCHIP_READ
        EXTERN IINCHIP_WRITE
        EXTERN IPAddrInfo
        EXTERN IsItRtnMyVALtoSysID
        EXTERN MacAddrInfo
        EXTERN MyPortID
        EXTERN MyRstCase
        EXTERN OSSemCreate
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN PcSer
        EXTERN ProtocolComCheck
        EXTERN RCSDataAckTx
        EXTERN SerPtr
        EXTERN StsCheckConnectionRst
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN UPdateAlarm
        EXTERN USART1Printf
        EXTERN WRCS_DownLoadGiveupTimerSet
        EXTERN WRCS_ProtocolCheck
        EXTERN Wrcs1
        EXTERN __aeabi_memclr
        EXTERN connect
        EXTERN getGWIP
        EXTERN getSHAR
        EXTERN getSIPR
        EXTERN getSUBR
        EXTERN getSn_RX_RSR
        EXTERN listen
        EXTERN pBodyFrameTx
        EXTERN rambackup
        EXTERN recvfrom
        EXTERN sendto
        EXTERN setGAR
        EXTERN setSHAR
        EXTERN setSIPR
        EXTERN setSUBR
        EXTERN socket
        EXTERN sysinit
        EXTERN tTestFlag
        EXTERN w3150ainit

        PUBLIC AlarmRptFunc
        PUBLIC AlarmRptFuncInit
        PUBLIC AutoInformRptFunc
        PUBLIC DnrAlarmCheckUpdate
        PUBLIC DnrAlarmRptFunc
        PUBLIC Eth0TaskStk
        PUBLIC Ethenet0Init
        PUBLIC Ethernet0Task
        PUBLIC EthernetClientMode
        PUBLIC EthernetInitSet
        PUBLIC EthernetPortReset
        PUBLIC EthernetServerMode
        PUBLIC Ethernet_Debug
        PUBLIC Rwrcs0
        PUBLIC ServAlmSndCnt
        PUBLIC ServRstAlmFlag
        PUBLIC Swrcs0
        PUBLIC UdpPadOnFlag
        PUBLIC Wrcs0
        PUBLIC Wrcs0B
        PUBLIC defaultip
        PUBLIC eLink_Check
        PUBLIC init_sock
        PUBLIC pDnrAlarm
        PUBLIC pDnrAlarmChange
        PUBLIC pDnrAlarmPre
        PUBLIC pDnrAlarmTimer
        PUBLIC ret0CheckByte
        PUBLIC ret0GetByte
        PUBLIC retCheckByte
        PUBLIC retGetByte
        PUBLIC retSelect
        PUBLIC returnip
        PUBLIC returnport
        PUBLIC udp0PutStr
        PUBLIC udp0SetAddr
        PUBLIC udp0desportcmp
        PUBLIC udpPutStr
        PUBLIC udpSem
        PUBLIC udpSetAddr
        PUBLIC udp_preAddr
        PUBLIC udp_rx_buf
        PUBLIC udp_rx_len
        PUBLIC udp_rx_rcnt
        PUBLIC udpdesportcmp


        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Server\\267\\316 \\300\\374\\310\\257\\n"`:
        DATA
        DC8 "Server\267\316 \300\374\310\257\012"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Client\\267\\316 \\300\\374\\310\\257\\n"`:
        DATA
        DC8 "Client\267\316 \300\374\310\257\012"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "nUSE CHANNEL: %d\\n">`:
        DATA
        DC8 "nUSE CHANNEL: %d\012"
        DC8 0, 0
        DC8 "GatewayAddr: %d.%d.%d.%d\012"
        DC8 0, 0
        DC8 4DH, 61H, 63H, 41H, 64H, 64H, 72H, 3AH
        DC8 20H, 25H, 78H, 5BH, 25H, 78H, 5DH, 2EH
        DC8 25H, 78H, 5BH, 25H, 78H, 5DH, 2EH, 25H
        DC8 78H, 5BH, 25H, 78H, 5DH, 2EH, 25H, 78H
        DC8 5BH, 25H, 78H, 5DH, 2EH, 25H, 78H, 5BH
        DC8 25H, 78H, 5DH, 2EH, 25H, 78H, 5BH, 25H
        DC8 78H, 5DH, 0AH, 0
        DC8 "SubnetAddr: %d.%d.%d.%d\012"
        DC8 0, 0, 0
        DC8 "IPAddr: %d.%d.%d.%d\012"
        DC8 0, 0, 0
// C:\user\project\HFR OTM-L12\fw\appl_otmL12_20110505_v1.0\code\aa_ethernet0.c
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
//   11 #define ETH0_C
//   12 
//   13 #include "../dev/W3150A_v1.0.6/types.h"
//   14 #include "../dev/W3150A_v1.0.6/socket.h"
//   15 #include "../dev/W3150A_v1.0.6/w3150a.h"
//   16 
//   17 #include "../include/main.h"

        SECTION `.rodata`:CONST:NOROOT(2)
// __IPINFOR const __data defaultip
defaultip:
        DATA
        DC8 0, 26, 75, 99, 129, 129, 192, 168, 0, 23, 192, 168, 0, 1, 255, 255
        DC8 255, 0
        DC16 20000

        SECTION `.bss`:DATA:NOROOT(2)
// __ProtocolPtr __data Wrcs0B
Wrcs0B:
        DS8 48

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data UdpPadOnFlag
UdpPadOnFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data udp_rx_buf[2][2048]
udp_rx_buf:
        DS8 4096

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data ServAlmSndCnt[2][2]
ServAlmSndCnt:
        DATA
        DC8 0, 0, 0, 0
// INT8U __data ServRstAlmFlag[2][2]
ServRstAlmFlag:
        DC8 0, 0, 0, 0
// INT16U __data udp_rx_len[2]
udp_rx_len:
        DC8 0, 0, 0, 0
// INT16U __data udp_rx_rcnt[2]
udp_rx_rcnt:
        DC8 0, 0, 0, 0
// INT16U __data returnport[2]
returnport:
        DC8 0, 0, 0, 0
// struct os_event *__data udpSem[2]
udpSem:
        DC32 0H, 0H
// __ProtocolPtr *__data Wrcs0
Wrcs0:
        DC32 Wrcs0B
// OS_STK __data Eth0TaskStk[256]
Eth0TaskStk:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __WRCSSIO __data Swrcs0
Swrcs0:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
// __WRCSSIO __data Rwrcs0
Rwrcs0:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
// INT8U __data returnip[2][4]
returnip:
        DC8 0, 0, 0, 0, 0, 0, 0, 0
// INT8U __data udp_preAddr[2][4]
udp_preAddr:
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data Ethernet_Debug
Ethernet_Debug:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// __pDnrAlmStr __data pDnrAlarm[2][2]
pDnrAlarm:
        DS8 172
// __pDnrAlmStr __data pDnrAlarmPre[2][2]
pDnrAlarmPre:
        DS8 172
// __pDnrAlmStr __data pDnrAlarmChange[2][2]
pDnrAlarmChange:
        DS8 172
// __pDnrAlmStr __data pDnrAlarmTimer[2][2]
pDnrAlarmTimer:
        DS8 172
//   18 
//   19 //#define udp_debug
//   20 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   21 void Ethenet0Init(void)
//   22 {
Ethenet0Init:
        PUSH     {R4,LR}
//   23 
//   24 	Wrcs0->CheckByte = ret0CheckByte;
        LDR.W    R4,??DataTable6  ;; ServAlmSndCnt
        LDR      R0,[R4, #+28]
        LDR.N    R1,??Ethenet0Init_0  ;; ret0CheckByte
        STR      R1,[R0, #+0]
//   25 	Wrcs0->RxGetByte = ret0GetByte;
        LDR.N    R1,??Ethenet0Init_0+0x4  ;; ret0GetByte
        STR      R1,[R0, #+4]
//   26 	Wrcs0->PutStr = udp0PutStr;
        ADDS     R1,R0,#+4
        LDR.N    R2,??Ethenet0Init_0+0x8  ;; udp0PutStr
        STR      R2,[R1, #+4]
//   27 	Wrcs0->TxCheckByte = NULL;
        MOVS     R2,#+0
        STR      R2,[R1, #+12]
//   28 
//   29 	Wrcs0->TimerRx = Timerudp0Rx;
        MOVS     R2,#+3
        STRH     R2,[R1, #+16]
//   30 	Wrcs0->WRCSRecv = &Rwrcs0;
        ADDW     R2,R4,#+2104
        STR      R2,[R1, #+28]
//   31 	Wrcs0->WRCSSend = &Swrcs0;
        ADD      R2,R4,#+1056
        STR      R2,[R1, #+32]
//   32 	Wrcs0->nUSE = ETH0_CHANNEL;
        MOVS     R1,#+1
        STRB     R1,[R0, #+47]
//   33 	Wrcs0->OSSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+28]
        STR      R0,[R1, #+28]
//   34 
//   35 ////////////////////////////////////////////////////////////////////////////////
//   36 	udpSem[ETH0_CHANNEL] = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        STR      R0,[R4, #+24]
//   37 	EthernetPortReset();
        BL       EthernetPortReset
//   38 	OSTaskCreate(Ethernet0Task, (void *)NULL, (OS_STK *)&Eth0TaskStk[ETH0_START_STK_SIZE - 1], ETH0_START_PRIO);
        MOVS     R3,#+2
        ADDW     R2,R4,#+1052
        MOVS     R1,#+0
        LDR.N    R0,??Ethenet0Init_0+0xC  ;; Ethernet0Task
        BL       OSTaskCreate
//   39 	AlarmRptFuncInit();
        POP      {R4,LR}
        B.N      AlarmRptFuncInit
        Nop      
        DATA
??Ethenet0Init_0:
        DC32     ret0CheckByte
        DC32     ret0GetByte
        DC32     udp0PutStr
        DC32     Ethernet0Task
//   40 }
//   41 
//   42 
//   43 
//   44 // UDP CASE !!(SERVER)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   45 void Ethernet0Task(void *p_arg)
//   46 {
Ethernet0Task:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
//   47 	INT8U s = 0;
//   48 	INT8U nUSE = Wrcs0->nUSE;
        LDR.N    R4,??DataTable6  ;; ServAlmSndCnt
        LDR      R6,[R4, #+28]
        LDRB     R5,[R6, #+47]
//   49 	INT8U len;
//   50 	
//   51 	__ProtocolPtr *nPtr = Wrcs0;
//   52 	
//   53 	OSTimeDly(100L*ETH0_START_PRIO);
        MOVS     R0,#+200
        BL       OSTimeDly
//   54 
//   55 	EthernetInitSet(nUSE, Sn_MR_UDP, TRUE);
        MOVS     R2,#+1
        MOVS     R1,#+2
        MOV      R0,R5
        BL       EthernetInitSet
//   56 	TimerRegist(TimerAlm0, Time1Sec*10L);
        MOVW     R1,#+10000
        MOVS     R0,#+21
        BL       TimerRegist
//   57 	TimerRegist(TimerInform, Time1Sec*20L);
        MOVW     R1,#+20000
        MOVS     R0,#+22
        BL       TimerRegist
//   58 	
//   59 	udp0SetAddr(returnip[nUSE], returnport[nUSE]);
        MOV      R8,R5
        ADD      R0,R4,R8, LSL #+1
        LDRH     R1,[R0, #+16]
        ADD      R0,R4,R8, LSL #+2
        ADD      R0,R0,#+3152
        BL       udp0SetAddr
        ADD      R0,R4,#+3152
        ADD      R9,R0,R8, LSL #+2
        ADD      R0,R4,#+16
        ADD      R10,R0,R8, LSL #+1
        LDR.N    R7,??Ethernet0Task_0  ;; tTestFlag
        B.N      ??Ethernet0Task_1
//   60 
//   61 	while(1)
//   62 	{
//   63 
//   64 		if(eLink_Check(nUSE) && !tTestFlag)
//   65 		{
//   66 			while(eLink_Check(nUSE) && !tTestFlag)
//   67 			{
//   68 				StsCheckConnectionRst(nPtr);
//   69 				
//   70 				if(!WRCS_DownLoadGiveupTimerSet(NULL))
//   71 				{
//   72 					if(TimeOverCheck(TimerAlm0))
//   73 					{	
//   74 						TimerRegist(TimerAlm0, Time1Sec);
//   75 						AlarmRptFunc();
//   76 					}
//   77 					if(TimeOverCheck(TimerInform))
//   78 					{	
//   79 						AutoInformRptFunc();
//   80 					}
//   81 				}
//   82 				OSTimeDly(300L);
//   83 			}
//   84 			EthernetInitSet(nUSE, Sn_MR_UDP, FALSE);
//   85 			OSTimeDly(1000L);
//   86 		}
//   87 		while(!eLink_Check(nUSE) && !tTestFlag)
//   88 		{
//   89 			StsCheckConnectionRst(nPtr);
//   90 
//   91 			if(!WRCS_DownLoadGiveupTimerSet(NULL))
//   92 			{
//   93 				if(TimeOverCheck(TimerAlm0))
//   94 				{	
//   95 					TimerRegist(TimerAlm0, Time1Sec);
//   96 					AlarmRptFunc();
//   97 				}
//   98 				if(TimeOverCheck(TimerInform))
//   99 				{	
//  100 					AutoInformRptFunc();
//  101 				}
//  102 			}
//  103 			
//  104 			if( (len = retSelect(nUSE, s, returnip[nUSE], &returnport[nUSE])))
//  105 			{
//  106 				INT16U Recv;
//  107                 
//  108                 len = len;
//  109 
//  110 			    while(nPtr->CheckByte(1, &Recv))
//  111 				{
//  112 					if(WRCS_ProtocolCheck(nPtr))
//  113 					{
//  114 #if TWO_BODY >= 2
//  115 						while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//  116 						{
//  117 #endif
//  118 							udp0SetAddr(returnip[nUSE], returnport[nUSE]);
//  119 							ProtocolComCheck(nPtr);
//  120 #if TWO_BODY >= 2
//  121 							nPtr->WRCSRecv->cBody++;
//  122 						}
//  123 #endif
//  124 					}
//  125 				}
//  126 			
//  127 			}
//  128 			OSTimeDly(200L);
//  129 		}
//  130 		OSTimeDly(200L);
??Ethernet0Task_2:
        MOVS     R0,#+200
        BL       OSTimeDly
??Ethernet0Task_1:
        MOV      R0,R5
        BL       eLink_Check
        CMP      R0,#+0
        BEQ.N    ??Ethernet0Task_3
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BNE.N    ??Ethernet0Task_3
        B.N      ??Ethernet0Task_4
??Ethernet0Task_5:
        MOV      R0,R6
        BL       StsCheckConnectionRst
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CBNZ     R0,??Ethernet0Task_6
        MOVS     R0,#+21
        BL       TimeOverCheck
        CBZ      R0,??Ethernet0Task_7
        MOV      R1,#+1000
        MOVS     R0,#+21
        BL       TimerRegist
        BL       AlarmRptFunc
??Ethernet0Task_7:
        MOVS     R0,#+22
        BL       TimeOverCheck
        CBZ      R0,??Ethernet0Task_6
        BL       AutoInformRptFunc
??Ethernet0Task_6:
        MOV      R0,#+300
        BL       OSTimeDly
??Ethernet0Task_4:
        MOV      R0,R5
        BL       eLink_Check
        CBZ      R0,??Ethernet0Task_8
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BEQ.N    ??Ethernet0Task_5
??Ethernet0Task_8:
        MOVS     R2,#+0
        MOVS     R1,#+2
        MOV      R0,R5
        BL       EthernetInitSet
        MOV      R0,#+1000
        B.N      ??Ethernet0Task_9
??Ethernet0Task_10:
        MOV      R0,R6
        BL       WRCS_ProtocolCheck
        CBZ      R0,??Ethernet0Task_11
        ADD      R0,R4,#+16
        LDRH     R1,[R0, R8, LSL #+1]
        MOV      R0,R9
        BL       udp0SetAddr
        MOV      R0,R6
        BL       ProtocolComCheck
??Ethernet0Task_11:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R6, #+0]
        BLX      R2
        CMP      R0,#+0
        BNE.N    ??Ethernet0Task_10
??Ethernet0Task_12:
        MOVS     R0,#+200
??Ethernet0Task_9:
        BL       OSTimeDly
??Ethernet0Task_3:
        MOV      R0,R5
        BL       eLink_Check
        CMP      R0,#+0
        BNE.N    ??Ethernet0Task_2
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BNE.N    ??Ethernet0Task_2
        MOV      R0,R6
        BL       StsCheckConnectionRst
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CBNZ     R0,??Ethernet0Task_13
        MOVS     R0,#+21
        BL       TimeOverCheck
        CBZ      R0,??Ethernet0Task_14
        MOV      R1,#+1000
        MOVS     R0,#+21
        BL       TimerRegist
        BL       AlarmRptFunc
??Ethernet0Task_14:
        MOVS     R0,#+22
        BL       TimeOverCheck
        CBZ      R0,??Ethernet0Task_13
        BL       AutoInformRptFunc
??Ethernet0Task_13:
        MOV      R3,R10
        MOV      R2,R9
        MOVS     R1,#+0
        MOV      R0,R5
        BL       retSelect
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.N    ??Ethernet0Task_12
        B.N      ??Ethernet0Task_11
        Nop      
        DATA
??Ethernet0Task_0:
        DC32     tTestFlag
//  131 	}
//  132 }
//  133 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 void AlarmRptFuncInit(void)
//  135 {
AlarmRptFuncInit:
        PUSH     {R4-R8,LR}
//  136 	INT8U i = 0, j = 0;
//  137 
//  138 	for(i = 0; i < DnrMaxID; i++)
        LDR.W    R4,??DataTable8  ;; pDnrAlarm
        ADD      R5,R4,#+172
        ADD      R6,R4,#+344
        ADD      R8,R4,#+516
        MOVS     R7,#+2
//  139 	{	
//  140 		for(j = 0; j < DnrMaxID; j++)
//  141 		{
//  142 			memset((void*)&pDnrAlarm[i][j], 0, sizeof(__pDnrAlmStr));
??AlarmRptFuncInit_0:
        MOVS     R1,#+43
        MOV      R0,R4
        BL       __aeabi_memclr
//  143 			memset((void*)&pDnrAlarmPre[i][j], 0, sizeof(__pDnrAlmStr));
        MOVS     R1,#+43
        MOV      R0,R5
        BL       __aeabi_memclr
//  144 			memset((void*)&pDnrAlarmChange[i][j], 0, sizeof(__pDnrAlmStr));
        MOVS     R1,#+43
        MOV      R0,R6
        BL       __aeabi_memclr
//  145 			memset((void*)&pDnrAlarmTimer[i][j], 0, sizeof(__pDnrAlmStr));		
        MOVS     R1,#+43
        MOV      R0,R8
        BL       __aeabi_memclr
        MOVS     R1,#+43
        ADD      R0,R4,#+43
        BL       __aeabi_memclr
        MOVS     R1,#+43
        ADD      R0,R5,#+43
        BL       __aeabi_memclr
        MOVS     R1,#+43
        ADD      R0,R6,#+43
        BL       __aeabi_memclr
        MOVS     R1,#+43
        ADD      R0,R8,#+43
        BL       __aeabi_memclr
//  146 		}
//  147 	}
        ADD      R8,R8,#+86
        ADDS     R6,R6,#+86
        ADDS     R5,R5,#+86
        ADDS     R4,R4,#+86
        SUBS     R7,R7,#+1
        BNE.N    ??AlarmRptFuncInit_0
//  148 }
        POP      {R4-R8,PC}       ;; return
//  149 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  150 void AutoInformRptFunc(void)	// Module Inventory Auto
//  151 {
AutoInformRptFunc:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
//  152 	INT8U i = 0, j = 0;
//  153 	INT16U tcnt = 0;
//  154 	INT8U *dptr = Wrcs0->WRCSRecv->BodyFrame[0].SubData;
        LDR.N    R4,??DataTable6  ;; ServAlmSndCnt
        LDR      R0,[R4, #+28]
        LDR      R0,[R0, #+32]
        ADD      R5,R0,#+15
//  155 
//  156 	INT8U id0, id1, id2;
//  157 	
//  158 	for(i = 0; i < DnrMaxID; i++)
        MOVS     R6,#+0
        LDR.W    R8,??DataTable13  ;; PcSer
//  159 	{
//  160 		for(j = 0; j < DnrMaxID; j++)
//  161 		{
//  162 			tcnt = GenModuleAutoInformSts(dptr, i, j);
??AutoInformRptFunc_0:
        MOVS     R2,#+0
        UXTB     R1,R6
        MOV      R0,R5
        BL       GenModuleAutoInformSts
        MOV      R7,R0
//  163 			IsItRtnMyVALtoSysID(&id0, &id1, &id2, i, j);
        MOVS     R0,#+0
        PUSH     {R0,LR}
        UXTB     R3,R6
        ADD      R2,SP,#+10
        ADD      R1,SP,#+8
        ADD      R0,SP,#+9
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
//  164 
//  165 			pBodyFrameTx(id0, id1, id2, dptr, tcnt, AutoModuleInformQue, PcSer, NULL);
        MOVS     R1,#+0
        LDR      R0,[R8, #+0]
        PUSH     {R0,R1}
        MOVS     R1,#+97
        MOV      R0,R7
        PUSH     {R0,R1}
        MOV      R3,R5
        LDRB     R2,[SP, #+18]
        LDRB     R1,[SP, #+16]
        LDRB     R0,[SP, #+17]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  166 			pBodyFrameTx(id0, id1, id2, dptr, tcnt, AutoModuleInformQue, Wrcs0, NULL);
        MOVS     R1,#+0
        LDR      R0,[R4, #+28]
        PUSH     {R0,R1}
        MOVS     R1,#+97
        MOV      R0,R7
        PUSH     {R0,R1}
        MOV      R3,R5
        LDRB     R2,[SP, #+18]
        LDRB     R1,[SP, #+16]
        LDRB     R0,[SP, #+17]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
        MOVS     R2,#+1
        UXTB     R1,R6
        MOV      R0,R5
        BL       GenModuleAutoInformSts
        MOV      R7,R0
        MOVS     R0,#+1
        PUSH     {R0,LR}
        UXTB     R3,R6
        ADD      R2,SP,#+10
        ADD      R1,SP,#+8
        ADD      R0,SP,#+9
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
        MOVS     R1,#+0
        LDR      R0,[R8, #+0]
        PUSH     {R0,R1}
        MOVS     R1,#+97
        MOV      R0,R7
        PUSH     {R0,R1}
        MOV      R3,R5
        LDRB     R2,[SP, #+18]
        LDRB     R1,[SP, #+16]
        LDRB     R0,[SP, #+17]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
        MOVS     R1,#+0
        LDR      R0,[R4, #+28]
        PUSH     {R0,R1}
        MOVS     R1,#+97
        MOV      R0,R7
        PUSH     {R0,R1}
        MOV      R3,R5
        LDRB     R2,[SP, #+18]
        LDRB     R1,[SP, #+16]
        LDRB     R0,[SP, #+17]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  167 		}
//  168 	}
        ADDS     R6,R6,#+1
        UXTB     R0,R6
        CMP      R0,#+2
        BCC.N    ??AutoInformRptFunc_0
//  169 
//  170 	for(i = 0; i < DnrMaxID; i++)
        MOVS     R4,#+0
        LDR.W    R6,??DataTable14  ;; MyPortID
//  171 	{
//  172 		for(j = 0; j < DnrMaxID; j++)
//  173 		{
//  174 			
//  175 			dptr[0] = 0x30;
??AutoInformRptFunc_1:
        MOVS     R0,#+48
        STRB     R0,[R5, #+0]
//  176 			tcnt = GenModuleAutoInformSts(&dptr[1], i, j) + 1;
        MOVS     R2,#+0
        UXTB     R1,R4
        ADDS     R0,R5,#+1
        BL       GenModuleAutoInformSts
        ADDS     R7,R0,#+1
//  177 			IsItRtnMyVALtoSysID(&id0, &id1, &id2, i, j);
        MOVS     R0,#+0
        PUSH     {R0,LR}
        UXTB     R3,R4
        ADD      R2,SP,#+10
        ADD      R1,SP,#+8
        ADD      R0,SP,#+9
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
//  178 			RCSDataAckTx(id0, id1, dptr, tcnt, MyPortID, AutoModuleInformQue);
        MOVS     R1,#+97
        LDRB     R0,[R6, #+0]
        PUSH     {R0,R1}
        UXTB     R3,R7
        MOV      R2,R5
        LDRB     R1,[SP, #+8]
        LDRB     R0,[SP, #+9]
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
        MOVS     R0,#+48
        STRB     R0,[R5, #+0]
        MOVS     R2,#+1
        UXTB     R1,R4
        ADDS     R0,R5,#+1
        BL       GenModuleAutoInformSts
        ADDS     R7,R0,#+1
        MOVS     R0,#+1
        PUSH     {R0,LR}
        UXTB     R3,R4
        ADD      R2,SP,#+10
        ADD      R1,SP,#+8
        ADD      R0,SP,#+9
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
        MOVS     R1,#+97
        LDRB     R0,[R6, #+0]
        PUSH     {R0,R1}
        UXTB     R3,R7
        MOV      R2,R5
        LDRB     R1,[SP, #+8]
        LDRB     R0,[SP, #+9]
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
//  179 		}
//  180 	}
        ADDS     R4,R4,#+1
        UXTB     R0,R4
        CMP      R0,#+2
        BCC.N    ??AutoInformRptFunc_1
//  181 }
        POP      {R0,R1,R4-R8,PC}  ;; return
//  182 
//  183 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  184 void AlarmRptFunc(void)
//  185 {
AlarmRptFunc:
        PUSH     {R3-R9,LR}
//  186 	INT8U i = 0, j = 0;
//  187 ///////////////////////////////////////////////////////////////////////////////////////////////////////
//  188 
//  189 	for(i = 0; i < DnrMaxID; i++)
        MOVS     R4,#+0
        LDR.W    R8,??DataTable6  ;; ServAlmSndCnt
        LDR.W    R9,??DataTable11  ;; MyRstCase
//  190 	{
//  191 		for(j = 0; j < DnrMaxID; j++)
??AlarmRptFunc_0:
        MOVS     R7,#+0
        MOV      R5,R8
        MOV      R6,R9
//  192 		{
//  193 			if(ServAlmSndCnt[i][j] >= 3){
??AlarmRptFunc_1:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+3
        BCC.N    ??AlarmRptFunc_2
//  194 				ServAlmSndCnt[i][j] = 0;
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  195 				
//  196 				MyRstCase.SERVERRstCase[i][j] = 0x00;
        STRB     R0,[R6, #+0]
        B.N      ??AlarmRptFunc_3
//  197 			}
//  198 			else
//  199             {		
//  200 				if(ServAlmSndCnt[i][j])	DnrAlarmRptFunc(i, j);
??AlarmRptFunc_2:
        CBZ      R0,??AlarmRptFunc_4
??AlarmRptFunc_5:
        UXTB     R1,R7
        UXTB     R0,R4
        BL       DnrAlarmRptFunc
        B.N      ??AlarmRptFunc_3
//  201 				else {
//  202                     if(DnrAlarmCheckUpdate(i, j)) DnrAlarmRptFunc(i, j);
??AlarmRptFunc_4:
        UXTB     R1,R7
        UXTB     R0,R4
        BL       DnrAlarmCheckUpdate
        CMP      R0,#+0
        BNE.N    ??AlarmRptFunc_5
//  203 				}
//  204 			}
//  205 		}
??AlarmRptFunc_3:
        ADDS     R7,R7,#+1
        ADDS     R6,R6,#+1
        ADDS     R5,R5,#+1
        UXTB     R0,R7
        CMP      R0,#+2
        BCC.N    ??AlarmRptFunc_1
//  206 	}
        ADDS     R4,R4,#+1
        ADD      R9,R9,#+2
        ADD      R8,R8,#+2
        UXTB     R0,R4
        CMP      R0,#+2
        BCC.N    ??AlarmRptFunc_0
//  207 }
        POP      {R0,R4-R9,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     ServAlmSndCnt
//  208 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  209 INT32U DnrAlarmCheckUpdate(INT8U tmpDnr, INT8U tmpRmt)
//  210 {
DnrAlarmCheckUpdate:
        PUSH     {R3-R11,LR}
//  211 
//  212 	INT8U  i = 0;
//  213 	INT8U *CurSts = (INT8U *)&pDnrAlarm[tmpDnr][tmpRmt];
        MOV      R11,R0
        MOVS     R0,#+86
        MUL      R0,R11,R0
        LDR.N    R3,??DataTable8  ;; pDnrAlarm
        ADDS     R2,R0,R3
        MOV      R5,R1
        MOVS     R1,#+43
        MULS     R1,R5,R1
        ADDS     R4,R1,R2
//  214 	INT8U *PreSts = (INT8U *)&pDnrAlarmPre[tmpDnr][tmpRmt];
        ADDS     R0,R0,R3
        ADDS     R0,R1,R0
        ADD      R10,R0,#+172
//  215 	INT8U *ChangeFlag = (INT8U *)&pDnrAlarmChange[tmpDnr][tmpRmt];
        ADD      R9,R0,#+344
//  216 	INT8U *AlarmTimer = (INT8U *)&pDnrAlarmTimer[tmpDnr][tmpRmt];
//  217 	INT8U tCnt = 0;
        MOVS     R7,#+0
//  218 
//  219 	pDnrAlarm[tmpDnr][tmpRmt].TempUpperLmt   		= DnrSts[tmpDnr][tmpRmt].tmpAlm.TempUpperLmt 		& DnrSts[tmpDnr][tmpRmt].Flag.TempUpperLmt;
        MOVW     R3,#+269
        MOVW     R6,#+538
        LDR.W    R12,??DataTable12  ;; DnrSts
        MLA      R6,R11,R6,R12
        MLA      R3,R5,R3,R6
        LDRB     R6,[R3, #+8]
        LDRB     R12,[R3, #+259]
        AND      R6,R12,R6
        AND      R6,R6,#0x20
        LSRS     R6,R6,#+5
        STRB     R6,[R1, R2]
//  220 	pDnrAlarm[tmpDnr][tmpRmt].StsConFail       		= DnrSts[tmpDnr][tmpRmt].tmpAlm.StsConFail 			& DnrSts[tmpDnr][tmpRmt].Flag.StsConFail;
        LDRB     R1,[R3, #+8]
        LDRB     R2,[R3, #+259]
        ANDS     R1,R2,R1
        AND      R1,R1,#0x40
        LSRS     R1,R1,#+6
        STRB     R1,[R4, #+1]
//  221 	pDnrAlarm[tmpDnr][tmpRmt].WestPathLossFail 		= DnrSts[tmpDnr][tmpRmt].tmpAlm.WestPathLossFail 	& DnrSts[tmpDnr][tmpRmt].Flag.WestPathLossFail;
        ADDS     R2,R4,#+1
        ADDW     R1,R3,#+259
        ADDS     R3,R3,#+8
        LDRB     R6,[R3, #+1]
        LDRB     R12,[R1, #+1]
        AND      R6,R12,R6
        AND      R6,R6,#0x1
        STRB     R6,[R2, #+1]
//  222 	pDnrAlarm[tmpDnr][tmpRmt].LinkFail           	= DnrSts[tmpDnr][tmpRmt].tmpAlm.LinkFail 			& DnrSts[tmpDnr][tmpRmt].Flag.LinkFail;
        LDRB     R6,[R3, #+1]
        LDRB     R12,[R1, #+1]
        AND      R6,R12,R6
        AND      R6,R6,#0x2
        LSRS     R6,R6,#+1
        STRB     R6,[R2, #+2]
//  223 
//  224 	pDnrAlarm[tmpDnr][tmpRmt].EastPathLossFail    	= DnrSts[tmpDnr][tmpRmt].tmpAlm.EastPathLossFail 	& DnrSts[tmpDnr][tmpRmt].Flag.EastPathLossFail;
        LDRB     R6,[R3, #+1]
        LDRB     R12,[R1, #+1]
        AND      R6,R12,R6
        AND      R6,R6,#0x10
        LSRS     R6,R6,#+4
        STRB     R6,[R2, #+3]
//  225 	pDnrAlarm[tmpDnr][tmpRmt].WestSubPassLossFail 	= DnrSts[tmpDnr][tmpRmt].tmpAlm.WestSubPassLossFail & DnrSts[tmpDnr][tmpRmt].Flag.WestSubPassLossFail;
        LDRB     R6,[R3, #+1]
        LDRB     R12,[R1, #+1]
        AND      R6,R12,R6
        AND      R6,R6,#0x40
        LSRS     R6,R6,#+6
        STRB     R6,[R2, #+4]
//  226 	pDnrAlarm[tmpDnr][tmpRmt].EastSubPassLossFail	= DnrSts[tmpDnr][tmpRmt].tmpAlm.EastSubPassLossFail	& DnrSts[tmpDnr][tmpRmt].Flag.EastSubPassLossFail;
        LDRB     R6,[R3, #+1]
        LDRB     R12,[R1, #+1]
        AND      R6,R12,R6
        LSRS     R6,R6,#+7
        STRB     R6,[R2, #+5]
//  227 	pDnrAlarm[tmpDnr][tmpRmt].SFP7LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP7LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP7LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        AND      R6,R6,#0x1
        STRB     R6,[R2, #+6]
//  228 
//  229 	pDnrAlarm[tmpDnr][tmpRmt].SFP6LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP6LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP6LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        AND      R6,R6,#0x2
        LSRS     R6,R6,#+1
        STRB     R6,[R2, #+7]
//  230 	pDnrAlarm[tmpDnr][tmpRmt].SFP5LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP5LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP5LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        AND      R6,R6,#0x4
        LSRS     R6,R6,#+2
        STRB     R6,[R2, #+8]
//  231 	pDnrAlarm[tmpDnr][tmpRmt].SFP4LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP4LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP4LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        AND      R6,R6,#0x8
        LSRS     R6,R6,#+3
        STRB     R6,[R2, #+9]
//  232 	pDnrAlarm[tmpDnr][tmpRmt].SFP3LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP3LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP3LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        AND      R6,R6,#0x10
        LSRS     R6,R6,#+4
        STRB     R6,[R2, #+10]
//  233 
//  234 	pDnrAlarm[tmpDnr][tmpRmt].SFP2LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP2LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP2LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        AND      R6,R6,#0x20
        LSRS     R6,R6,#+5
        STRB     R6,[R2, #+11]
//  235 	pDnrAlarm[tmpDnr][tmpRmt].SFP1LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP1LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP1LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        AND      R6,R6,#0x40
        LSRS     R6,R6,#+6
        STRB     R6,[R2, #+12]
//  236 	pDnrAlarm[tmpDnr][tmpRmt].SFP0LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP0LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP0LDFail;
        LDRB     R6,[R3, #+2]
        LDRB     R12,[R1, #+2]
        AND      R6,R12,R6
        LSRS     R6,R6,#+7
        STRB     R6,[R2, #+13]
//  237 	pDnrAlarm[tmpDnr][tmpRmt].SFP11LDFail			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP11LDFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP11LDFail;
        LDRB     R6,[R3, #+3]
        LDRB     R12,[R1, #+3]
        AND      R6,R12,R6
        AND      R6,R6,#0x10
        LSRS     R6,R6,#+4
        STRB     R6,[R2, #+14]
//  238 
//  239 	pDnrAlarm[tmpDnr][tmpRmt].SFP10LDFail			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP10LDFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP10LDFail;
        LDRB     R6,[R3, #+3]
        LDRB     R12,[R1, #+3]
        AND      R6,R12,R6
        AND      R6,R6,#0x20
        LSRS     R6,R6,#+5
        STRB     R6,[R2, #+15]
//  240 	pDnrAlarm[tmpDnr][tmpRmt].SFP9LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP9LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP9LDFail;
        LDRB     R6,[R3, #+3]
        LDRB     R12,[R1, #+3]
        AND      R6,R12,R6
        AND      R6,R6,#0x40
        LSRS     R6,R6,#+6
        STRB     R6,[R2, #+16]
//  241 	pDnrAlarm[tmpDnr][tmpRmt].SFP8LDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP8LDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP8LDFail;
        LDRB     R6,[R3, #+3]
        LDRB     R12,[R1, #+3]
        AND      R6,R12,R6
        LSRS     R6,R6,#+7
        STRB     R6,[R2, #+17]
//  242 	pDnrAlarm[tmpDnr][tmpRmt].SFP7PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP7PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP7PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        AND      R6,R6,#0x1
        STRB     R6,[R2, #+18]
//  243 
//  244 	pDnrAlarm[tmpDnr][tmpRmt].SFP6PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP6PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP6PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        AND      R6,R6,#0x2
        LSRS     R6,R6,#+1
        STRB     R6,[R2, #+19]
//  245 	pDnrAlarm[tmpDnr][tmpRmt].SFP5PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP5PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP5PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        AND      R6,R6,#0x4
        LSRS     R6,R6,#+2
        STRB     R6,[R2, #+20]
//  246 	pDnrAlarm[tmpDnr][tmpRmt].SFP4PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP4PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP4PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        AND      R6,R6,#0x8
        LSRS     R6,R6,#+3
        STRB     R6,[R2, #+21]
//  247 	pDnrAlarm[tmpDnr][tmpRmt].SFP3PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP3PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP3PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        AND      R6,R6,#0x10
        LSRS     R6,R6,#+4
        STRB     R6,[R2, #+22]
//  248 	
//  249 	pDnrAlarm[tmpDnr][tmpRmt].SFP2PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP2PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP2PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        AND      R6,R6,#0x20
        LSRS     R6,R6,#+5
        STRB     R6,[R2, #+23]
//  250 	pDnrAlarm[tmpDnr][tmpRmt].SFP1PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP1PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP1PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        AND      R6,R6,#0x40
        LSRS     R6,R6,#+6
        STRB     R6,[R2, #+24]
//  251 	pDnrAlarm[tmpDnr][tmpRmt].SFP0PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP0PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP0PDFail;
        LDRB     R6,[R3, #+4]
        LDRB     R12,[R1, #+4]
        AND      R6,R12,R6
        LSRS     R6,R6,#+7
        STRB     R6,[R2, #+25]
//  252 	pDnrAlarm[tmpDnr][tmpRmt].SFP11PDFail			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP11PDFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP11PDFail;
        LDRB     R6,[R3, #+5]
        LDRB     R12,[R1, #+5]
        AND      R6,R12,R6
        AND      R6,R6,#0x10
        LSRS     R6,R6,#+4
        STRB     R6,[R2, #+26]
//  253 
//  254 	pDnrAlarm[tmpDnr][tmpRmt].SFP10PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP10PDFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP10PDFail;
        LDRB     R6,[R3, #+5]
        LDRB     R12,[R1, #+5]
        AND      R6,R12,R6
        AND      R6,R6,#0x20
        LSRS     R6,R6,#+5
        STRB     R6,[R2, #+27]
//  255 	pDnrAlarm[tmpDnr][tmpRmt].SFP9PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP9PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP9PDFail;
        LDRB     R6,[R3, #+5]
        LDRB     R12,[R1, #+5]
        AND      R6,R12,R6
        AND      R6,R6,#0x40
        LSRS     R6,R6,#+6
        STRB     R6,[R2, #+28]
//  256 	pDnrAlarm[tmpDnr][tmpRmt].SFP8PDFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP8PDFail 			& DnrSts[tmpDnr][tmpRmt].Flag.SFP8PDFail;
        LDRB     R6,[R3, #+5]
        LDRB     R12,[R1, #+5]
        AND      R6,R12,R6
        LSRS     R6,R6,#+7
        STRB     R6,[R2, #+29]
//  257 	pDnrAlarm[tmpDnr][tmpRmt].SFP7LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP7LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP7LOSFail;
        LDRB     R6,[R3, #+6]
        LDRB     R12,[R1, #+6]
        AND      R6,R12,R6
        AND      R6,R6,#0x1
        STRB     R6,[R2, #+30]
//  258 
//  259 	pDnrAlarm[tmpDnr][tmpRmt].SFP6LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP6LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP6LOSFail;
        LDRB     R6,[R3, #+6]
        LDRB     R12,[R1, #+6]
        AND      R6,R12,R6
        AND      R6,R6,#0x2
        LSRS     R6,R6,#+1
        STRB     R6,[R2, #+31]
//  260 	pDnrAlarm[tmpDnr][tmpRmt].SFP5LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP5LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP5LOSFail;
        LDRB     R2,[R3, #+6]
        LDRB     R6,[R1, #+6]
        ANDS     R2,R6,R2
        AND      R2,R2,#0x4
        LSRS     R2,R2,#+2
        STRB     R2,[R4, #+33]
//  261 	pDnrAlarm[tmpDnr][tmpRmt].SFP4LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP4LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP4LOSFail;
        ADD      R2,R4,#+33
        LDRB     R6,[R3, #+6]
        LDRB     R12,[R1, #+6]
        AND      R6,R12,R6
        AND      R6,R6,#0x8
        LSRS     R6,R6,#+3
        STRB     R6,[R2, #+1]
//  262 	pDnrAlarm[tmpDnr][tmpRmt].SFP3LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP3LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP3LOSFail;
        LDRB     R6,[R3, #+6]
        LDRB     R12,[R1, #+6]
        AND      R6,R12,R6
        AND      R6,R6,#0x10
        LSRS     R6,R6,#+4
        STRB     R6,[R2, #+2]
//  263 
//  264 	pDnrAlarm[tmpDnr][tmpRmt].SFP2LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP2LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP2LOSFail;
        LDRB     R6,[R3, #+6]
        LDRB     R12,[R1, #+6]
        AND      R6,R12,R6
        AND      R6,R6,#0x20
        LSRS     R6,R6,#+5
        STRB     R6,[R2, #+3]
//  265 	pDnrAlarm[tmpDnr][tmpRmt].SFP1LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP1LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP1LOSFail;
        LDRB     R6,[R3, #+6]
        LDRB     R12,[R1, #+6]
        AND      R6,R12,R6
        AND      R6,R6,#0x40
        LSRS     R6,R6,#+6
        STRB     R6,[R2, #+4]
//  266 	pDnrAlarm[tmpDnr][tmpRmt].SFP0LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP0LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP0LOSFail;
        LDRB     R6,[R3, #+6]
        LDRB     R12,[R1, #+6]
        AND      R6,R12,R6
        LSRS     R6,R6,#+7
        STRB     R6,[R2, #+5]
//  267 	pDnrAlarm[tmpDnr][tmpRmt].SFP11LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP11LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP11LOSFail;
        LDRB     R6,[R3, #+7]
        LDRB     R12,[R1, #+7]
        AND      R6,R12,R6
        AND      R6,R6,#0x10
        LSRS     R6,R6,#+4
        STRB     R6,[R2, #+6]
//  268 
//  269 	pDnrAlarm[tmpDnr][tmpRmt].SFP10LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP10LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP10LOSFail;
        LDRB     R6,[R3, #+7]
        LDRB     R12,[R1, #+7]
        AND      R6,R12,R6
        AND      R6,R6,#0x20
        LSRS     R6,R6,#+5
        STRB     R6,[R2, #+7]
//  270 	pDnrAlarm[tmpDnr][tmpRmt].SFP9LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP9LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP9LOSFail;
        LDRB     R6,[R3, #+7]
        LDRB     R12,[R1, #+7]
        AND      R6,R12,R6
        AND      R6,R6,#0x40
        LSRS     R6,R6,#+6
        STRB     R6,[R2, #+8]
//  271 	pDnrAlarm[tmpDnr][tmpRmt].SFP8LOSFail 			= DnrSts[tmpDnr][tmpRmt].tmpAlm.SFP8LOSFail 		& DnrSts[tmpDnr][tmpRmt].Flag.SFP8LOSFail;
        LDRB     R3,[R3, #+7]
        LDRB     R1,[R1, #+7]
        ANDS     R1,R1,R3
        LSRS     R1,R1,#+7
        STRB     R1,[R2, #+9]
//  272 
//  273 
//  274 
//  275 ////////////////////////////////////////////////////////////////////////////////
//  276 	for(i = 0; i < sizeof(__pDnrAlmStr); i++)
        MOVS     R6,#+0
        ADD      R8,R0,#+516
//  277 	{
//  278 		tCnt += UPdateAlarm(CurSts + i, PreSts + i, ChangeFlag + i, AlarmTimer + i, 10L);
??DnrAlarmCheckUpdate_0:
        UXTB     R0,R6
        MOVS     R1,#+10
        PUSH     {R1,LR}
        MOV      R3,R8
        ADD      R2,R0,R9
        ADD      R1,R0,R10
        ADDS     R0,R0,R4
        BL       UPdateAlarm
        ADD      SP,SP,#+8
        ADDS     R7,R0,R7
        UXTB     R7,R7
//  279 	}
        ADDS     R6,R6,#+1
        ADD      R8,R8,#+1
        CMP      R6,#+43
        BCC.N    ??DnrAlarmCheckUpdate_0
//  280 	tCnt += MyRstCase.SERVERRstCase[tmpDnr][tmpRmt];
//  281 
//  282 	if(tCnt != 0) return TRUE;
        LDR.W    R0,??DataTable11  ;; MyRstCase
        ADD      R0,R0,R11, LSL #+1
        LDRB     R0,[R5, R0]
        ADDS     R1,R0,R7
        UXTB     R0,R1
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  283 
//  284 	return FALSE;
        POP      {R1,R4-R11,PC}   ;; return
//  285 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     pDnrAlarm
//  286 
//  287 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  288 void DnrAlarmRptFunc(INT8U tmpDnr, INT8U tmpRmt)
//  289 {
DnrAlarmRptFunc:
        PUSH     {R3-R9,LR}
//  290 
//  291 	INT8U *dptr = Wrcs0->WRCSRecv->BodyFrame[0].SubData;
        LDR.W    R8,??DnrAlarmRptFunc_0  ;; ServAlmSndCnt
        LDR      R2,[R8, #+28]
        LDR      R2,[R2, #+32]
        ADD      R4,R2,#+15
//  292 	INT16U rlen = 0;
        MOV      R12,#+0
//  293 
//  294 	__pDnrAlmStr *cAlm = &pDnrAlarmChange[tmpDnr][tmpRmt];
        MOV      R5,R1
        MOV      R9,R0
        MOVS     R2,#+43
        MOVS     R3,#+86
        LDR.W    R7,??DnrAlarmRptFunc_0+0x4  ;; pDnrAlarm
        MLA      R3,R9,R3,R7
        MLA      R3,R5,R2,R3
        ADD      R2,R3,#+344
//  295 	__pDnrAlmStr *pAlm = &pDnrAlarmPre[tmpDnr][tmpRmt];	
        ADDS     R3,R3,#+172
//  296 
//  297 	if(cAlm->TempUpperLmt)	{
        LDRB     R7,[R2, #+0]
        CBZ      R7,??DnrAlarmRptFunc_1
//  298 		dptr[rlen++] = hibyte(Aid_TempUpperLmt);
        MOVS     R7,#+2
        STRB     R7,[R4, #+0]
//  299 		dptr[rlen++] = lobyte(Aid_TempUpperLmt);
        STRB     R7,[R4, #+1]
//  300 		dptr[rlen++] = pAlm->TempUpperLmt;
        LDRB     R7,[R3, #+0]
        STRB     R7,[R4, #+2]
//  301 		dptr[rlen++] = 0;
        MOVS     R7,#+0
        STRB     R7,[R4, #+3]
        MOV      R12,#+4
//  302 	}
//  303 	
//  304 	if(cAlm->StsConFail)	{
??DnrAlarmRptFunc_1:
        LDRB     R7,[R2, #+1]
        CBZ      R7,??DnrAlarmRptFunc_2
//  305 		dptr[rlen++] = hibyte(Aid_StsCheckCon);
        MOVS     R7,#+2
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  306 		dptr[rlen++] = lobyte(Aid_StsCheckCon);
        MOVS     R6,#+10
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  307 		dptr[rlen++] = pAlm->StsConFail;
        LDRB     R6,[R3, #+1]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  308 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  309 	}
//  310 
//  311 	if(cAlm->WestPathLossFail)	{
??DnrAlarmRptFunc_2:
        LDRB     R7,[R2, #+2]
        CBZ      R7,??DnrAlarmRptFunc_3
//  312 		dptr[rlen++] = hibyte(Aid_WestPathLossFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  313 		dptr[rlen++] = lobyte(Aid_WestPathLossFail);
        MOVS     R6,#+115
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  314 		dptr[rlen++] = pAlm->WestPathLossFail;
        LDRB     R6,[R3, #+2]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  315 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  316 	}
//  317 
//  318 	if(cAlm->LinkFail)	{
??DnrAlarmRptFunc_3:
        LDRB     R7,[R2, #+3]
        CBZ      R7,??DnrAlarmRptFunc_4
//  319 		
//  320 		dptr[rlen++] = hibyte(Aid_OWTMLinkFail);
        MOVS     R7,#+9
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  321 		dptr[rlen++] = lobyte(Aid_OWTMLinkFail);
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  322 		dptr[rlen++] = pAlm->LinkFail;
        LDRB     R6,[R3, #+3]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  323 		if(pAlm->LinkFail)
        ADDS     R6,R7,#+1
        UXTH     R12,R6
        LDRB     R6,[R3, #+3]
        CMP      R6,#+0
        BEQ.N    ??DnrAlarmRptFunc_5
//  324 		{
//  325 			dptr[rlen++] = 0x01;
        MOVS     R6,#+1
        STRB     R6,[R7, R4]
//  326 			dptr[rlen++] = 0x03;
        MOVS     R7,#+3
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R12,R7
        B.N      ??DnrAlarmRptFunc_4
//  327 		}
//  328 		else
//  329 		{
//  330 			dptr[rlen++] = 0x00;
??DnrAlarmRptFunc_5:
        STRB     R6,[R7, R4]
//  331 		}
//  332 	}
//  333 	
//  334 	if(cAlm->EastPathLossFail){
??DnrAlarmRptFunc_4:
        LDRB     R7,[R2, #+4]
        CBZ      R7,??DnrAlarmRptFunc_6
//  335 		dptr[rlen++] = hibyte(Aid_EastPathLossFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  336 		dptr[rlen++] = lobyte(Aid_EastPathLossFail);
        MOVS     R6,#+114
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  337 		dptr[rlen++] = pAlm->EastPathLossFail;
        LDRB     R6,[R3, #+4]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  338 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  339 	}
//  340 
//  341 	if(cAlm->WestSubPassLossFail){
??DnrAlarmRptFunc_6:
        LDRB     R7,[R2, #+5]
        CBZ      R7,??DnrAlarmRptFunc_7
//  342 		dptr[rlen++] = hibyte(Aid_WestSubPassLossFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  343 		dptr[rlen++] = lobyte(Aid_WestSubPassLossFail);
        MOVS     R6,#+195
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  344 		dptr[rlen++] = pAlm->WestSubPassLossFail;
        LDRB     R6,[R3, #+5]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  345 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  346 	}
//  347 
//  348 	if(cAlm->EastSubPassLossFail){
??DnrAlarmRptFunc_7:
        LDRB     R7,[R2, #+6]
        CBZ      R7,??DnrAlarmRptFunc_8
//  349 		dptr[rlen++] = hibyte(Aid_EastSubPassLossFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  350 		dptr[rlen++] = lobyte(Aid_EastSubPassLossFail);
        MOVS     R6,#+194
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  351 		dptr[rlen++] = pAlm->WestSubPassLossFail;
        LDRB     R6,[R3, #+5]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  352 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  353 	}
//  354 
//  355 	if(cAlm->SFP0LDFail){
??DnrAlarmRptFunc_8:
        LDRB     R7,[R2, #+14]
        CBZ      R7,??DnrAlarmRptFunc_9
//  356 		dptr[rlen++] = hibyte(Aid_SFP0LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  357 		dptr[rlen++] = lobyte(Aid_SFP0LDFail);
        MOVS     R6,#+118
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  358 		dptr[rlen++] = pAlm->SFP0LDFail;
        LDRB     R6,[R3, #+14]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  359 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  360 	}
//  361 
//  362 	if(cAlm->SFP1LDFail){
??DnrAlarmRptFunc_9:
        LDRB     R7,[R2, #+13]
        CBZ      R7,??DnrAlarmRptFunc_10
//  363 		dptr[rlen++] = hibyte(Aid_SFP1LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  364 		dptr[rlen++] = lobyte(Aid_SFP1LDFail);
        MOVS     R6,#+119
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  365 		dptr[rlen++] = pAlm->SFP1LDFail;
        LDRB     R6,[R3, #+13]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  366 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  367 	}
//  368 	
//  369 	if(cAlm->SFP2LDFail){
??DnrAlarmRptFunc_10:
        LDRB     R7,[R2, #+12]
        CBZ      R7,??DnrAlarmRptFunc_11
//  370 		dptr[rlen++] = hibyte(Aid_SFP2LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  371 		dptr[rlen++] = lobyte(Aid_SFP2LDFail);
        MOVS     R6,#+120
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  372 		dptr[rlen++] = pAlm->SFP2LDFail;
        LDRB     R6,[R3, #+12]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  373 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  374 	}
//  375 	
//  376 	if(cAlm->SFP3LDFail){
??DnrAlarmRptFunc_11:
        LDRB     R7,[R2, #+11]
        CBZ      R7,??DnrAlarmRptFunc_12
//  377 		dptr[rlen++] = hibyte(Aid_SFP3LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  378 		dptr[rlen++] = lobyte(Aid_SFP3LDFail);
        MOVS     R6,#+121
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  379 		dptr[rlen++] = pAlm->SFP3LDFail;
        LDRB     R6,[R3, #+11]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  380 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  381 	}
//  382 
//  383 	if(cAlm->SFP4LDFail){
??DnrAlarmRptFunc_12:
        LDRB     R7,[R2, #+10]
        CBZ      R7,??DnrAlarmRptFunc_13
//  384 		dptr[rlen++] = hibyte(Aid_SFP4LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  385 		dptr[rlen++] = lobyte(Aid_SFP4LDFail);
        MOVS     R6,#+122
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  386 		dptr[rlen++] = pAlm->SFP4LDFail;
        LDRB     R6,[R3, #+10]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  387 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  388 	}
//  389 
//  390 	if(cAlm->SFP5LDFail){
??DnrAlarmRptFunc_13:
        LDRB     R7,[R2, #+9]
        CBZ      R7,??DnrAlarmRptFunc_14
//  391 		dptr[rlen++] = hibyte(Aid_SFP5LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  392 		dptr[rlen++] = lobyte(Aid_SFP5LDFail);
        MOVS     R6,#+123
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  393 		dptr[rlen++] = pAlm->SFP5LDFail;
        LDRB     R6,[R3, #+9]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  394 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  395 	}
//  396 
//  397 	if(cAlm->SFP6LDFail){
??DnrAlarmRptFunc_14:
        LDRB     R7,[R2, #+8]
        CBZ      R7,??DnrAlarmRptFunc_15
//  398 		dptr[rlen++] = hibyte(Aid_SFP6LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  399 		dptr[rlen++] = lobyte(Aid_SFP6LDFail);
        MOVS     R6,#+124
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  400 		dptr[rlen++] = pAlm->SFP6LDFail;
        LDRB     R6,[R3, #+8]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  401 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  402 	}
//  403 
//  404 	if(cAlm->SFP7LDFail){
??DnrAlarmRptFunc_15:
        LDRB     R7,[R2, #+7]
        CBZ      R7,??DnrAlarmRptFunc_16
//  405 		dptr[rlen++] = hibyte(Aid_SFP7LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  406 		dptr[rlen++] = lobyte(Aid_SFP7LDFail);
        MOVS     R6,#+125
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  407 		dptr[rlen++] = pAlm->SFP7LDFail;
        LDRB     R6,[R3, #+7]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  408 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  409 	}
//  410 	
//  411 	if(cAlm->SFP8LDFail){
??DnrAlarmRptFunc_16:
        LDRB     R7,[R2, #+18]
        CBZ      R7,??DnrAlarmRptFunc_17
//  412 		dptr[rlen++] = hibyte(Aid_SFP8LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  413 		dptr[rlen++] = lobyte(Aid_SFP8LDFail);
        MOVS     R6,#+126
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  414 		dptr[rlen++] = pAlm->SFP8LDFail;
        LDRB     R6,[R3, #+18]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  415 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  416 	}
//  417 	
//  418 	if(cAlm->SFP9LDFail){
??DnrAlarmRptFunc_17:
        LDRB     R7,[R2, #+17]
        CBZ      R7,??DnrAlarmRptFunc_18
//  419 		dptr[rlen++] = hibyte(Aid_SFP9LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  420 		dptr[rlen++] = lobyte(Aid_SFP9LDFail);
        MOVS     R6,#+127
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  421 		dptr[rlen++] = pAlm->SFP9LDFail;
        LDRB     R6,[R3, #+17]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  422 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  423 	}
//  424 	
//  425 	if(cAlm->SFP10LDFail){
??DnrAlarmRptFunc_18:
        LDRB     R7,[R2, #+16]
        CBZ      R7,??DnrAlarmRptFunc_19
//  426 		dptr[rlen++] = hibyte(Aid_SFP10LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  427 		dptr[rlen++] = lobyte(Aid_SFP10LDFail);
        MOVS     R6,#+128
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  428 		dptr[rlen++] = pAlm->SFP10LDFail;
        LDRB     R6,[R3, #+16]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  429 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  430 	}
//  431 
//  432 	
//  433 	if(cAlm->SFP0PDFail){
??DnrAlarmRptFunc_19:
        LDRB     R7,[R2, #+26]
        CBZ      R7,??DnrAlarmRptFunc_20
//  434 		dptr[rlen++] = hibyte(Aid_SFP0PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  435 		dptr[rlen++] = lobyte(Aid_SFP0PDFail);
        MOVS     R6,#+130
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  436 		dptr[rlen++] = pAlm->SFP0PDFail;
        LDRB     R6,[R3, #+26]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  437 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  438 	}
//  439 		
//  440 	if(cAlm->SFP1PDFail){
??DnrAlarmRptFunc_20:
        LDRB     R7,[R2, #+25]
        CBZ      R7,??DnrAlarmRptFunc_21
//  441 		dptr[rlen++] = hibyte(Aid_SFP1PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  442 		dptr[rlen++] = lobyte(Aid_SFP1PDFail);
        MOVS     R6,#+131
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  443 		dptr[rlen++] = pAlm->SFP1PDFail;
        LDRB     R6,[R3, #+25]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  444 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  445 	}
//  446 
//  447 	if(cAlm->SFP2PDFail){
??DnrAlarmRptFunc_21:
        LDRB     R7,[R2, #+24]
        CBZ      R7,??DnrAlarmRptFunc_22
//  448 		dptr[rlen++] = hibyte(Aid_SFP2PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  449 		dptr[rlen++] = lobyte(Aid_SFP2PDFail);
        MOVS     R6,#+132
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  450 		dptr[rlen++] = pAlm->SFP2PDFail;
        LDRB     R6,[R3, #+24]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  451 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  452 	}
//  453 
//  454 	if(cAlm->SFP3PDFail){
??DnrAlarmRptFunc_22:
        LDRB     R7,[R2, #+23]
        CBZ      R7,??DnrAlarmRptFunc_23
//  455 		dptr[rlen++] = hibyte(Aid_SFP3PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  456 		dptr[rlen++] = lobyte(Aid_SFP3PDFail);
        MOVS     R6,#+133
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  457 		dptr[rlen++] = pAlm->SFP3PDFail;
        LDRB     R6,[R3, #+23]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  458 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  459 	}
//  460 	
//  461 	if(cAlm->SFP11LDFail){
??DnrAlarmRptFunc_23:
        LDRB     R7,[R2, #+15]
        CBZ      R7,??DnrAlarmRptFunc_24
//  462 		dptr[rlen++] = hibyte(Aid_SFP11LDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  463 		dptr[rlen++] = lobyte(Aid_SFP11LDFail);
        MOVS     R6,#+129
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  464 		dptr[rlen++] = pAlm->SFP11LDFail;
        LDRB     R6,[R3, #+15]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  465 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  466 	}
//  467 
//  468 	
//  469 	if(cAlm->SFP4PDFail){
??DnrAlarmRptFunc_24:
        LDRB     R7,[R2, #+22]
        CBZ      R7,??DnrAlarmRptFunc_25
//  470 		dptr[rlen++] = hibyte(Aid_SFP4PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  471 		dptr[rlen++] = lobyte(Aid_SFP4PDFail);
        MOVS     R6,#+134
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  472 		dptr[rlen++] = pAlm->SFP4PDFail;
        LDRB     R6,[R3, #+22]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  473 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  474 	}
//  475 	
//  476 	if(cAlm->SFP5PDFail){
??DnrAlarmRptFunc_25:
        LDRB     R7,[R2, #+21]
        CBZ      R7,??DnrAlarmRptFunc_26
//  477 		dptr[rlen++] = hibyte(Aid_SFP5PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  478 		dptr[rlen++] = lobyte(Aid_SFP5PDFail);
        MOVS     R6,#+135
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  479 		dptr[rlen++] = pAlm->SFP5PDFail;
        LDRB     R6,[R3, #+21]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  480 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  481 	}
//  482 
//  483 	if(cAlm->SFP6PDFail){
??DnrAlarmRptFunc_26:
        LDRB     R7,[R2, #+20]
        CBZ      R7,??DnrAlarmRptFunc_27
//  484 		dptr[rlen++] = hibyte(Aid_SFP6PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  485 		dptr[rlen++] = lobyte(Aid_SFP6PDFail);
        MOVS     R6,#+136
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  486 		dptr[rlen++] = pAlm->SFP6PDFail;
        LDRB     R6,[R3, #+20]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  487 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  488 	}
//  489 
//  490 	if(cAlm->SFP7PDFail){
??DnrAlarmRptFunc_27:
        LDRB     R7,[R2, #+19]
        CBZ      R7,??DnrAlarmRptFunc_28
//  491 		dptr[rlen++] = hibyte(Aid_SFP7PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  492 		dptr[rlen++] = lobyte(Aid_SFP7PDFail);
        MOVS     R6,#+137
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  493 		dptr[rlen++] = pAlm->SFP7PDFail;
        LDRB     R6,[R3, #+19]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  494 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  495 	}
//  496 
//  497 	if(cAlm->SFP8PDFail){
??DnrAlarmRptFunc_28:
        LDRB     R7,[R2, #+30]
        CBZ      R7,??DnrAlarmRptFunc_29
//  498 		dptr[rlen++] = hibyte(Aid_SFP8PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  499 		dptr[rlen++] = lobyte(Aid_SFP8PDFail);
        MOVS     R6,#+138
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  500 		dptr[rlen++] = pAlm->SFP8PDFail;
        LDRB     R6,[R3, #+30]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  501 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  502 	}
//  503 	
//  504 	if(cAlm->SFP9PDFail){
??DnrAlarmRptFunc_29:
        LDRB     R7,[R2, #+29]
        CBZ      R7,??DnrAlarmRptFunc_30
//  505 		dptr[rlen++] = hibyte(Aid_SFP9PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  506 		dptr[rlen++] = lobyte(Aid_SFP9PDFail);
        MOVS     R6,#+139
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  507 		dptr[rlen++] = pAlm->SFP9PDFail;
        LDRB     R6,[R3, #+29]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  508 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  509 	}
//  510 	
//  511 	if(cAlm->SFP10PDFail){
??DnrAlarmRptFunc_30:
        LDRB     R7,[R2, #+28]
        CBZ      R7,??DnrAlarmRptFunc_31
//  512 		dptr[rlen++] = hibyte(Aid_SFP10PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  513 		dptr[rlen++] = lobyte(Aid_SFP10PDFail);
        MOVS     R6,#+140
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  514 		dptr[rlen++] = pAlm->SFP10PDFail;
        LDRB     R6,[R3, #+28]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  515 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  516 	}
//  517 
//  518 	if(cAlm->SFP11PDFail){
??DnrAlarmRptFunc_31:
        LDRB     R7,[R2, #+27]
        CBZ      R7,??DnrAlarmRptFunc_32
//  519 		dptr[rlen++] = hibyte(Aid_SFP11PDFail);
        MOVS     R7,#+21
        STRB     R7,[R12, R4]
        ADD      R7,R12,#+1
        UXTH     R7,R7
//  520 		dptr[rlen++] = lobyte(Aid_SFP11PDFail);
        MOVS     R6,#+141
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  521 		dptr[rlen++] = pAlm->SFP11PDFail;
        LDRB     R6,[R3, #+27]
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R7,R7
//  522 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R7, R4]
        ADDS     R7,R7,#+1
        UXTH     R12,R7
//  523 	}
//  524 	////////////////////////////////////////////////
//  525 	if(cAlm->SFP0LOSFail){
??DnrAlarmRptFunc_32:
        ADD      R7,R2,#+32
        LDRB     R6,[R7, #+6]
        CMP      R6,#+0
        BEQ.N    ??DnrAlarmRptFunc_33
//  526 		dptr[rlen++] = hibyte(Aid_SFP0LOSFail);
        MOVS     R6,#+21
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  527 		dptr[rlen++] = lobyte(Aid_SFP0LOSFail);
        MOVS     R6,#+156
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  528 		dptr[rlen++] = pAlm->SFP0LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+6]
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  529 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  530 	}
//  531 	if(cAlm->SFP1LOSFail){
??DnrAlarmRptFunc_33:
        LDRB     R6,[R7, #+5]
        CMP      R6,#+0
        BEQ.N    ??DnrAlarmRptFunc_34
//  532 		dptr[rlen++] = hibyte(Aid_SFP1LOSFail);
        MOVS     R6,#+21
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  533 		dptr[rlen++] = lobyte(Aid_SFP1LOSFail);
        MOVS     R6,#+157
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  534 		dptr[rlen++] = pAlm->SFP1LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+5]
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  535 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  536 	}
//  537 	if(cAlm->SFP2LOSFail){
??DnrAlarmRptFunc_34:
        LDRB     R6,[R7, #+4]
        CMP      R6,#+0
        BEQ.N    ??DnrAlarmRptFunc_35
//  538 		dptr[rlen++] = hibyte(Aid_SFP2LOSFail);
        MOVS     R6,#+21
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  539 		dptr[rlen++] = lobyte(Aid_SFP2LOSFail);
        MOVS     R6,#+158
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  540 		dptr[rlen++] = pAlm->SFP2LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+4]
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  541 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  542 	}
//  543 	if(cAlm->SFP3LOSFail){
??DnrAlarmRptFunc_35:
        LDRB     R6,[R7, #+3]
        CMP      R6,#+0
        BEQ.N    ??DnrAlarmRptFunc_36
//  544 		dptr[rlen++] = hibyte(Aid_SFP3LOSFail);
        MOVS     R6,#+21
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  545 		dptr[rlen++] = lobyte(Aid_SFP3LOSFail);
        MOVS     R6,#+159
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  546 		dptr[rlen++] = pAlm->SFP3LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+3]
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  547 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  548 	}
//  549 
//  550 	if(cAlm->SFP4LOSFail){
??DnrAlarmRptFunc_36:
        LDRB     R6,[R7, #+2]
        CMP      R6,#+0
        BEQ.N    ??DnrAlarmRptFunc_37
//  551 		dptr[rlen++] = hibyte(Aid_SFP4LOSFail);
        MOVS     R6,#+21
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  552 		dptr[rlen++] = lobyte(Aid_SFP4LOSFail);
        MOVS     R6,#+160
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  553 		dptr[rlen++] = pAlm->SFP4LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+2]
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  554 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  555 	}
//  556 
//  557 	if(cAlm->SFP5LOSFail){
??DnrAlarmRptFunc_37:
        LDRB     R6,[R7, #+1]
        CMP      R6,#+0
        BEQ.N    ??DnrAlarmRptFunc_38
//  558 		dptr[rlen++] = hibyte(Aid_SFP5LOSFail);
        MOVS     R6,#+21
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  559 		dptr[rlen++] = lobyte(Aid_SFP5LOSFail);
        MOVS     R6,#+161
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  560 		dptr[rlen++] = pAlm->SFP5LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+1]
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  561 		dptr[rlen++] = 0;
        MOVS     R6,#+0
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  562 	}
//  563 	if(cAlm->SFP6LOSFail){
??DnrAlarmRptFunc_38:
        LDRB     LR,[R2, #+32]
        CMP      LR,#+0
        BEQ.N    ??DnrAlarmRptFunc_39
//  564 		dptr[rlen++] = hibyte(Aid_SFP6LOSFail);
        MOVS     R6,#+21
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  565 		dptr[rlen++] = lobyte(Aid_SFP6LOSFail);
        MOVS     R6,#+162
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  566 		dptr[rlen++] = pAlm->SFP6LOSFail;
        LDRB     R6,[R3, #+32]
        STRB     R6,[R12, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  567 		dptr[rlen++] = 0;
        MOV      LR,R12
        MOVS     R6,#+0
        STRB     R6,[LR, R4]
        ADD      R6,R12,#+1
        UXTH     R12,R6
//  568 	}
//  569 	if(cAlm->SFP7LOSFail){
??DnrAlarmRptFunc_39:
        LDRB     R2,[R2, #+31]
        CBZ      R2,??DnrAlarmRptFunc_40
//  570 		dptr[rlen++] = hibyte(Aid_SFP7LOSFail);
        MOVS     R2,#+21
        STRB     R2,[R12, R4]
        ADD      R2,R12,#+1
        UXTH     R2,R2
//  571 		dptr[rlen++] = lobyte(Aid_SFP7LOSFail);
        MOVS     R6,#+163
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  572 		dptr[rlen++] = pAlm->SFP7LOSFail;
        LDRB     R6,[R3, #+31]
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  573 		dptr[rlen++] = 0;
        MOV      LR,#+0
        STRB     LR,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R12,R2
//  574 	}
//  575 
//  576 	if(cAlm->SFP8LOSFail){
??DnrAlarmRptFunc_40:
        LDRB     R2,[R7, #+10]
        CBZ      R2,??DnrAlarmRptFunc_41
//  577 		dptr[rlen++] = hibyte(Aid_SFP8LOSFail);
        MOVS     R2,#+21
        STRB     R2,[R12, R4]
        ADD      R2,R12,#+1
        UXTH     R2,R2
//  578 		dptr[rlen++] = lobyte(Aid_SFP8LOSFail);
        MOVS     R6,#+164
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  579 		dptr[rlen++] = pAlm->SFP8LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+10]
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  580 		dptr[rlen++] = 0;
        MOV      LR,#+0
        STRB     LR,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R12,R2
//  581 	}
//  582 	if(cAlm->SFP9LOSFail){
??DnrAlarmRptFunc_41:
        LDRB     R2,[R7, #+9]
        CBZ      R2,??DnrAlarmRptFunc_42
//  583 		dptr[rlen++] = hibyte(Aid_SFP9LOSFail);
        MOVS     R2,#+21
        STRB     R2,[R12, R4]
        ADD      R2,R12,#+1
        UXTH     R2,R2
//  584 		dptr[rlen++] = lobyte(Aid_SFP9LOSFail);
        MOVS     R6,#+165
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  585 		dptr[rlen++] = pAlm->SFP9LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+9]
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  586 		dptr[rlen++] = 0;
        MOV      LR,#+0
        STRB     LR,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R12,R2
//  587 	}
//  588 	
//  589 	if(cAlm->SFP10LOSFail){
??DnrAlarmRptFunc_42:
        LDRB     R2,[R7, #+8]
        CBZ      R2,??DnrAlarmRptFunc_43
//  590 		dptr[rlen++] = hibyte(Aid_SFP10LOSFail);
        MOVS     R2,#+21
        STRB     R2,[R12, R4]
        ADD      R2,R12,#+1
        UXTH     R2,R2
//  591 		dptr[rlen++] = lobyte(Aid_SFP10LOSFail);
        MOVS     R6,#+166
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  592 		dptr[rlen++] = pAlm->SFP10LOSFail;
        ADD      R6,R3,#+32
        LDRB     R6,[R6, #+8]
        STRB     R6,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  593 		dptr[rlen++] = 0;
        MOV      LR,#+0
        STRB     LR,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R12,R2
//  594 	}
//  595 	
//  596 	if(cAlm->SFP11LOSFail){
??DnrAlarmRptFunc_43:
        LDRB     R2,[R7, #+7]
        CBZ      R2,??DnrAlarmRptFunc_44
//  597 		dptr[rlen++] = hibyte(Aid_SFP11LOSFail);
        MOV      R2,R12
        MOVS     R7,#+21
        STRB     R7,[R2, R4]
        ADD      R2,R12,#+1
        UXTH     R2,R2
//  598 		dptr[rlen++] = lobyte(Aid_SFP11LOSFail);
        MOVS     R7,#+167
        STRB     R7,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  599 		dptr[rlen++] = pAlm->SFP11LOSFail;
        ADDS     R3,R3,#+32
        LDRB     R3,[R3, #+7]
        STRB     R3,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  600 		dptr[rlen++] = 0;
        MOVS     R7,#+0
        STRB     R7,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R12,R2
//  601 	}
//  602 		
//  603 	
//  604 	if(MyRstCase.SERVERRstCase[tmpDnr][tmpRmt])
??DnrAlarmRptFunc_44:
        LDR.N    R2,??DataTable11  ;; MyRstCase
        ADD      R2,R2,R9, LSL #+1
        LDRB     R3,[R5, R2]
        CBZ      R3,??DnrAlarmRptFunc_45
//  605 	{
//  606 		dptr[rlen++] = hibyte(Aid_RCUReset);
        MOV      R3,R12
        MOVS     R7,#+9
        STRB     R7,[R3, R4]
        ADD      R3,R12,#+1
        UXTH     R3,R3
//  607 		dptr[rlen++] = lobyte(Aid_RCUReset);
        MOVS     R7,#+20
        STRB     R7,[R3, R4]
        ADDS     R3,R3,#+1
        UXTH     R3,R3
//  608 		dptr[rlen++] = 0x01;
        MOVS     R7,#+1
        STRB     R7,[R3, R4]
        ADDS     R3,R3,#+1
        UXTH     R3,R3
//  609 		dptr[rlen++] = 0x01;
        STRB     R7,[R3, R4]
        ADDS     R3,R3,#+1
        UXTH     R3,R3
//  610         
//  611 		dptr[rlen++] = MyRstCase.SERVERRstCase[tmpDnr][tmpRmt];
        LDRB     R2,[R5, R2]
        STRB     R2,[R3, R4]
        ADDS     R2,R3,#+1
        UXTH     R12,R2
//  612 		ServRstAlmFlag[tmpDnr][tmpRmt] = SET;
        ADD      R2,R8,R9, LSL #+1
        ADDS     R2,R5,R2
        STRB     R7,[R2, #+4]
//  613 	}
//  614 
//  615 
//  616 	// 필수 항목..
//  617 	dptr[rlen++] = 0xff;
??DnrAlarmRptFunc_45:
        MOVS     R2,#+255
        MOV      R3,R12
        STRB     R2,[R3, R4]
        ADD      R3,R12,#+1
        UXTH     R3,R3
//  618 	dptr[rlen++] = 0xff;
        STRB     R2,[R3, R4]
        ADDS     R2,R3,#+1
        UXTH     R2,R2
//  619 	dptr[rlen++] = 1;
        MOVS     R7,#+1
        STRB     R7,[R2, R4]
        ADDS     R2,R2,#+1
        UXTH     R2,R2
//  620 	dptr[rlen++] = DnrSts[tmpDnr][tmpRmt].CurrentTemp;
        MOVW     R3,#+269
        MOVW     R7,#+538
        LDR.N    R6,??DataTable12  ;; DnrSts
        MLA      R7,R9,R7,R6
        MLA      R3,R5,R3,R7
        LDRB     R7,[R3, #+21]
        STRB     R7,[R2, R4]
        ADDS     R7,R2,#+1
        UXTH     R7,R7
//  621 
//  622 	if(DnrSts[tmpDnr][tmpRmt].AlarmMask == UnMask) {
        LDRB     R2,[R3, #+190]
        CMP      R2,#+0
        BNE.N    ??DnrAlarmRptFunc_46
//  623 		INT8U id0, id1, id2;
//  624 		
//  625 		IsItRtnMyVALtoSysID(&id0, &id1, &id2, tmpDnr, tmpRmt);
        PUSH     {R1,LR}
        MOV      R3,R0
        ADD      R2,SP,#+10
        ADD      R1,SP,#+8
        ADD      R0,SP,#+9
        BL       IsItRtnMyVALtoSysID
        ADD      SP,SP,#+8
//  626 		pBodyFrameTx(id0, id1, id2, dptr, rlen, AlarmSCODE, Wrcs0, NULL);
        MOVS     R1,#+0
        LDR      R0,[R8, #+28]
        PUSH     {R0,R1}
        MOVS     R1,#+2
        MOV      R0,R7
        PUSH     {R0,R1}
        MOV      R3,R4
        LDRB     R2,[SP, #+18]
        LDRB     R1,[SP, #+16]
        LDRB     R0,[SP, #+17]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  627 		pBodyFrameTx(id0, id1, id2, dptr, rlen, AlarmSCODE, PcSer, NULL);
        MOVS     R1,#+0
        LDR.N    R0,??DataTable13  ;; PcSer
        LDR      R0,[R0, #+0]
        PUSH     {R0,R1}
        MOVS     R1,#+2
        MOV      R0,R7
        PUSH     {R0,R1}
        MOV      R3,R4
        LDRB     R2,[SP, #+18]
        LDRB     R1,[SP, #+16]
        LDRB     R0,[SP, #+17]
        BL       pBodyFrameTx
        ADD      SP,SP,#+16
//  628 		RCSDataAckTx(id0, id1,      dptr, rlen, MyPortID, RCSAlarmSCODERQST);
        MOVS     R1,#+130
        LDR.N    R0,??DataTable14  ;; MyPortID
        LDRB     R0,[R0, #+0]
        PUSH     {R0,R1}
        UXTB     R3,R7
        MOV      R2,R4
        LDRB     R1,[SP, #+8]
        LDRB     R0,[SP, #+9]
        BL       RCSDataAckTx
        ADD      SP,SP,#+8
//  629 
//  630 		ServAlmSndCnt[tmpDnr][tmpRmt]++;
        ADD      R0,R8,R9, LSL #+1
        LDRB     R1,[R5, R0]
        ADDS     R1,R1,#+1
        STRB     R1,[R5, R0]
//  631 		TimerRegist(TimerAlm0, Time1Sec*2L);
        MOV      R1,#+2000
        MOVS     R0,#+21
        BL       TimerRegist
//  632 	}
//  633 }
??DnrAlarmRptFunc_46:
        POP      {R0,R4-R9,PC}    ;; return
        DATA
??DnrAlarmRptFunc_0:
        DC32     ServAlmSndCnt
        DC32     pDnrAlarm

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable11:
        DC32     MyRstCase

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     DnrSts

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13:
        DC32     PcSer

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14:
        DC32     MyPortID
//  634 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  635 INT16U retSelect(INT32U nUSE, SOCKET s, unsigned char *addr, unsigned short int *port)
//  636 {
retSelect:
        PUSH     {R3-R9,LR}
        MOV      R5,R0
        MOV      R7,R1
//  637 	INT16U len = 0;
        MOVS     R4,#+0
//  638 	INT8U err;
//  639 	
//  640 	OSSemPend(udpSem[nUSE], 0, &err);
        LDR.W    R8,??retSelect_0  ;; ServAlmSndCnt
        ADD      R6,R8,R5, LSL #+2
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R6, #+20]
        BL       OSSemPend
//  641 	
//  642 	if ((IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_RECV )) // check interrupt register
        LSLS     R0,R7,#+8
        ADDW     R9,R0,#+1026
        MOV      R1,R9
        MOV      R0,R5
        BL       IINCHIP_READ
        TST      R0,#0x4
        BEQ.N    ??retSelect_1
//  643 	{
//  644 		// clear interrupt register
//  645 		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_RECV);
        MOVS     R2,#+4
        MOV      R1,R9
        MOV      R0,R5
        BL       IINCHIP_WRITE
//  646 
//  647 		if ((len = getSn_RX_RSR(nUSE, s)) > 0)			// check Rx data
        MOV      R1,R7
        MOV      R0,R5
        BL       getSn_RX_RSR
        MOVS     R4,R0
        BEQ.N    ??retSelect_1
//  648 		{
//  649 			if (len > TX_RX_MAX_BUF_SIZE) len = TX_RX_MAX_BUF_SIZE; 	//if Rx data size is lager than TX_RX_MAX_BUF_SIZE
        MOVW     R1,#+2049
        CMP      R0,R1
        BCC.N    ??retSelect_2
        MOV      R4,#+2048
//  650 																		//the data size to read is MAX_BUF_SIZE.
//  651 			len = recvfrom(nUSE, 0, udp_rx_buf[nUSE], len,(u_char *)returnip[nUSE], &returnport[nUSE]); //read the received data
??retSelect_2:
        ADD      R7,R8,R5, LSL #+1
        ADD      R1,R7,#+16
        ADD      R0,R6,#+3152
        PUSH     {R0,R1}
        MOV      R3,R4
        LDR.N    R0,??retSelect_0+0x4  ;; udp_rx_buf
        ADD      R2,R0,R5, LSL #+11
        MOVS     R1,#+0
        MOV      R0,R5
        BL       recvfrom
        ADD      SP,SP,#+8
        MOV      R4,R0
//  652 			udp_rx_len[nUSE] = len;
        STRH     R4,[R7, #+8]
//  653 			udp_rx_rcnt[nUSE] = 0;
        MOVS     R0,#+0
        STRH     R0,[R7, #+12]
//  654 		}
//  655 	}
//  656 	#ifdef udp_debug
//  657 	//SerPtr->printf("len: %d\n", len);
//  658 	if(len)
//  659 	{
//  660 		int i;
//  661 		for(i = 0; i < len; i++) SerPtr->printf("%02x ", udp_rx_buf[nUSE][i]);
//  662 		SerPtr->printf("\n", len);
//  663 			
//  664 	}
//  665 	#endif
//  666 	OSSemPost(udpSem[nUSE]);
??retSelect_1:
        LDR      R0,[R6, #+20]
        BL       OSSemPost
//  667 
//  668 	return len;
        MOV      R0,R4
        POP      {R1,R4-R9,PC}    ;; return
        Nop      
        DATA
??retSelect_0:
        DC32     ServAlmSndCnt
        DC32     udp_rx_buf
//  669 }
//  670 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  671 unsigned char ret0CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
//  672 {
//  673 	return (retCheckByte(Wrcs0->nUSE, ByteCnt, Recv));
ret0CheckByte:
        MOV      R2,R1
        MOV      R1,R0
        LDR.N    R0,??ret0CheckByte_0  ;; ServAlmSndCnt
        LDR      R0,[R0, #+28]
        LDRB     R0,[R0, #+47]
        B.N      retCheckByte
        Nop      
        DATA
??ret0CheckByte_0:
        DC32     ServAlmSndCnt
//  674 }
//  675 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  676 signed short int ret0GetByte(void)
//  677 {
//  678 	return (retGetByte(Wrcs0->nUSE));
ret0GetByte:
        LDR.N    R0,??ret0GetByte_0  ;; ServAlmSndCnt
        LDR      R0,[R0, #+28]
        LDRB     R0,[R0, #+47]
        B.N      retGetByte
        Nop      
        DATA
??ret0GetByte_0:
        DC32     ServAlmSndCnt
//  679 }
//  680 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  681 void udp0SetAddr(INT8U *destaddr, INT16U destport)
//  682 {
//  683 	udpSetAddr(Wrcs0->nUSE, 0, destaddr, destport);
udp0SetAddr:
        MOV      R3,R1
        MOV      R2,R0
        MOVS     R1,#+0
        LDR.N    R0,??udp0SetAddr_0  ;; ServAlmSndCnt
        LDR      R0,[R0, #+28]
        LDRB     R0,[R0, #+47]
        B.N      udpSetAddr
        DATA
??udp0SetAddr_0:
        DC32     ServAlmSndCnt
//  684 }
//  685 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  686 void udp0PutStr(unsigned char *Str, unsigned short int Length, int iEn)
//  687 {
udp0PutStr:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
        LDR.N    R0,??udp0PutStr_0  ;; ServAlmSndCnt
        LDR      R0,[R0, #+28]
        ADD      R6,R0,#+40
        LDRH     R1,[R6, #+4]
        LDR      R0,[R0, #+40]
        PUSH     {R0,R1}
        MOV      R3,R2
        MOV      R2,R5
        MOV      R1,R4
        LDRB     R0,[R6, #+7]
//  688 	udpPutStr(Wrcs0->nUSE, Str, Length, iEn, Wrcs0->destaddr, Wrcs0->destport);
        BL       udpPutStr
        ADD      SP,SP,#+8
//  689 }
        POP      {R4-R6,PC}       ;; return
        DATA
??udp0PutStr_0:
        DC32     ServAlmSndCnt
//  690 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  691 void udp0desportcmp(SOCKET s, INT8U *pddr, INT8U *addr)
//  692 {
//  693 	udpdesportcmp(Wrcs0->nUSE, s, pddr, addr);
udp0desportcmp:
        MOV      R3,R2
        MOV      R2,R1
        MOV      R1,R0
        LDR.N    R0,??udp0desportcmp_0  ;; ServAlmSndCnt
        LDR      R0,[R0, #+28]
        LDRB     R0,[R0, #+47]
        B.N      udpdesportcmp
        DATA
??udp0desportcmp_0:
        DC32     ServAlmSndCnt
//  694 }
//  695 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  696 unsigned char retCheckByte(INT32U nUSE, unsigned short int ByteCnt, unsigned short int *Recv)
//  697 {
retCheckByte:
        PUSH     {R3-R9,LR}
        MOV      R4,R0
        MOV      R9,R1
        MOV      R5,R2
//  698 
//  699 	INT16U rval = 0;
        MOVS     R6,#+0
//  700 	INT8U err;
//  701 	
//  702 	OSSemPend(udpSem[nUSE], 0, &err);
        LDR.W    R8,??retCheckByte_0  ;; ServAlmSndCnt
        ADD      R7,R8,R4, LSL #+2
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R7, #+20]
        BL       OSSemPend
//  703 
//  704 	*Recv = 0;
        STRH     R6,[R5, #+0]
//  705 	
//  706 	if(udp_rx_rcnt[nUSE] >= TX_RX_MAX_BUF_SIZE || udp_rx_rcnt[nUSE] >= udp_rx_len[nUSE]){
        ADD      R0,R8,R4, LSL #+1
        LDRH     R1,[R0, #+12]
        MOV      R2,#+2048
        CMP      R1,R2
        BCS.N    ??retCheckByte_1
        LDRH     R2,[R0, #+8]
        CMP      R1,R2
        BCC.N    ??retCheckByte_2
//  707 
//  708 		udp_rx_len[nUSE] = 0;
??retCheckByte_1:
        STRH     R6,[R0, #+8]
        B.N      ??retCheckByte_3
//  709 	}
//  710 	else
//  711 	{
//  712 		*Recv = (udp_rx_len[nUSE] - udp_rx_rcnt[nUSE]);
??retCheckByte_2:
        SUBS     R0,R2,R1
        STRH     R0,[R5, #+0]
//  713 		if(*Recv >= ByteCnt) rval = TRUE;
        UXTH     R0,R0
        CMP      R0,R9
        BCC.N    ??retCheckByte_3
        MOVS     R6,#+1
//  714 	}
//  715 
//  716 #ifdef udp_debug
//  717 	SerPtr->printf("Recv: %d, rval: %d \n", *Recv, rval);
//  718 #endif
//  719 	OSSemPost(udpSem[nUSE]);
??retCheckByte_3:
        LDR      R0,[R7, #+20]
        BL       OSSemPost
//  720 
//  721 	return rval;
        MOV      R0,R6
        POP      {R1,R4-R9,PC}    ;; return
        DATA
??retCheckByte_0:
        DC32     ServAlmSndCnt
//  722 }
//  723 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  724 signed short int retGetByte(INT32U nUSE)
//  725 {
retGetByte:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R5,R0
//  726 	INT8U rval = 0;
//  727 	INT8U err;
//  728 	
//  729 	OSSemPend(udpSem[nUSE], 0, &err);
        LDR.N    R6,??retGetByte_0  ;; ServAlmSndCnt
        ADD      R4,R6,R5, LSL #+2
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+20]
        BL       OSSemPend
//  730 
//  731 	rval = udp_rx_buf[nUSE][udp_rx_rcnt[nUSE]++];
        ADD      R0,R6,R5, LSL #+1
        LDRH     R1,[R0, #+12]
        LDR.N    R2,??retGetByte_0+0x4  ;; udp_rx_buf
        ADD      R2,R2,R5, LSL #+11
        LDRB     R5,[R1, R2]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+12]
//  732 
//  733 	OSSemPost(udpSem[nUSE]);
        LDR      R0,[R4, #+20]
        BL       OSSemPost
//  734 	
//  735 #ifdef udp_debug
//  736 	SerPtr->printf("rval: %02x \n", rval & 0xff);
//  737 #endif
//  738 
//  739 	return rval & 0xff;
        MOV      R0,R5
        POP      {R1,R2,R4-R6,PC}  ;; return
        Nop      
        DATA
??retGetByte_0:
        DC32     ServAlmSndCnt
        DC32     udp_rx_buf
//  740 }
//  741 
//  742 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  743 void udpSetAddr(INT32U nUSE, SOCKET s, INT8U *destaddr, INT16U destport)
//  744 {
udpSetAddr:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R5,R0
        MOV      R6,R2
        MOV      R4,R3
//  745 	
//  746 	INT8U err;
//  747 	OSSemPend(udpSem[nUSE], 0, &err);
        LDR.W    R8,??udpSetAddr_0  ;; ServAlmSndCnt
        ADD      R7,R8,R5, LSL #+2
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R7, #+20]
        BL       OSSemPend
//  748 
//  749 	if(nUSE == ETH0_CHANNEL)
        CMP      R5,#+1
        BNE.N    ??udpSetAddr_1
//  750 	{
//  751     	Wrcs0->destaddr = destaddr;
        LDR      R0,[R8, #+28]
        STR      R6,[R0, #+40]
//  752 		Wrcs0->destport = destport;
        STRH     R4,[R0, #+44]
//  753 
//  754 		rambackup[1] = (INT8U)(destport >> 0);
        LDR.N    R0,??udpSetAddr_0+0x4  ;; rambackup
        LDR      R1,[R0, #+0]
        STRB     R4,[R1, #+1]
//  755 		rambackup[2] = (INT8U)(destport >> 8);
        LDR      R1,[R0, #+0]
        LSRS     R2,R4,#+8
        STRB     R2,[R1, #+2]
//  756 		rambackup[3] = (INT8U)(destaddr[0]);
        LDR      R1,[R0, #+0]
        LDRB     R2,[R6, #+0]
        STRB     R2,[R1, #+3]
//  757 		rambackup[4] = (INT8U)(destaddr[1]);
        LDR      R1,[R0, #+0]
        LDRB     R2,[R6, #+1]
        STRB     R2,[R1, #+4]
//  758 		rambackup[5] = (INT8U)(destaddr[2]);
        LDR      R1,[R0, #+0]
        LDRB     R2,[R6, #+2]
        STRB     R2,[R1, #+5]
//  759 		rambackup[6] = (INT8U)(destaddr[3]);
        LDR      R0,[R0, #+0]
        LDRB     R1,[R6, #+3]
        STRB     R1,[R0, #+6]
        B.N      ??udpSetAddr_2
//  760 	}
//  761 	else
//  762 	{
//  763     	Wrcs1->destaddr = destaddr;
??udpSetAddr_1:
        LDR.N    R0,??udpSetAddr_0+0x8  ;; Wrcs1
        LDR      R0,[R0, #+0]
        STR      R6,[R0, #+40]
//  764 		Wrcs1->destport = destport;
        STRH     R4,[R0, #+44]
//  765 	}
//  766 	OSSemPost(udpSem[nUSE]);
??udpSetAddr_2:
        LDR      R0,[R7, #+20]
        BL       OSSemPost
//  767 }
        POP      {R0,R1,R4-R8,PC}  ;; return
        Nop      
        DATA
??udpSetAddr_0:
        DC32     ServAlmSndCnt
        DC32     rambackup
        DC32     Wrcs1
//  768 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  769 void udpdesportcmp(INT32U nUSE, SOCKET s, INT8U *pddr, INT8U *addr)
//  770 {
udpdesportcmp:
        PUSH     {R3-R7,LR}
        MOV      R4,R0
        MOV      R5,R1
//  771 	INT32U i = 0;
//  772 	INT16U nPort;
//  773 	INT8U IsItSame = TRUE;
        MOVS     R0,#+1
//  774 	
//  775 	for(i = 0; i < 4; i++)
        MOV      R1,R2
        MOV      R6,R3
        MOVS     R7,#+4
//  776 	{
//  777 		if(pddr[i] != addr[i]) IsItSame = FALSE;
??udpdesportcmp_0:
        LDRB     R12,[R1, #+0]
        LDRB     LR,[R6, #+0]
        CMP      R12,LR
        BEQ.N    ??udpdesportcmp_1
        MOVS     R0,#+0
//  778 	}
??udpdesportcmp_1:
        ADDS     R6,R6,#+1
        ADDS     R1,R1,#+1
        SUBS     R7,R7,#+1
        BNE.N    ??udpdesportcmp_0
//  779 
//  780 	if(IsItSame == FALSE)
        CBNZ     R0,??udpdesportcmp_2
//  781 	{		
//  782 		for(i = 0; i < 4; i++) pddr[i] = addr[i];
        LDRB     R0,[R3, #+0]
        STRB     R0,[R2, #+0]
        LDRB     R0,[R3, #+1]
        STRB     R0,[R2, #+1]
        LDRB     R0,[R3, #+2]
        STRB     R0,[R2, #+2]
        LDRB     R0,[R3, #+3]
        STRB     R0,[R2, #+3]
//  783 		if(nUSE == ETH0_CHANNEL)	nPort = (IPAddrInfo.Eth0Port[0] << 8) | (IPAddrInfo.Eth0Port[1] << 0);
        LDR.N    R0,??udpdesportcmp_3  ;; IPAddrInfo
        CMP      R4,#+1
        ITTEE    EQ 
        LDRBEQ   R1,[R0, #+12]
        LDRBEQ   R0,[R0, #+13]
        LDRBNE   R1,[R0, #+26]
        LDRBNE   R0,[R0, #+27]
//  784 		else						nPort = (IPAddrInfo.Eth1Port[0] << 8) | (IPAddrInfo.Eth1Port[1] << 0);	
        ORR      R3,R0,R1, LSL #+8
//  785 		
//  786 		init_sock(nUSE, s, Sn_MR_UDP, nPort, 0, (INT8U)NULL);
        MOVS     R1,#+0
        MOVS     R0,#+0
        PUSH     {R0,R1}
        MOVS     R2,#+2
        MOV      R1,R5
        UXTB     R0,R4
        BL       init_sock
        ADD      SP,SP,#+8
//  787 	}
//  788 }
??udpdesportcmp_2:
        POP      {R0,R4-R7,PC}    ;; return
        DATA
??udpdesportcmp_3:
        DC32     IPAddrInfo
//  789 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  790 void udpPutStr(INT32U nUSE, unsigned char *Str, unsigned short int Length, int iEn, INT8U *daddr, INT16U dport)
//  791 {
udpPutStr:
        PUSH     {R3-R9,LR}
        MOV      R5,R0
        MOV      R9,R1
        MOV      R8,R2
        LDR      R6,[SP, #+32]
        LDR      R4,[SP, #+36]
//  792 	INT8U err;
//  793 
//  794 	if(eLink_Check(nUSE)) return;
        BL       eLink_Check
        CBNZ     R0,??udpPutStr_0
//  795 	
//  796 	OSSemPend(udpSem[nUSE], 0, &err);
        LDR.N    R0,??udpPutStr_1  ;; ServAlmSndCnt
        ADD      R7,R0,R5, LSL #+2
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R7, #+20]
        BL       OSSemPend
//  797 
//  798 	#ifdef udp_debug
//  799 	SerPtr->printf("IPAddr: %d.%d.%d.%d\n", 
//  800 		daddr[0],
//  801 		daddr[1],
//  802 		daddr[2],
//  803 		daddr[3]);
//  804 
//  805 	{
//  806 		int i = 0;
//  807 		SerPtr->printf("[TX] ");
//  808 
//  809 		for(i = 0; i < Length; i++) SerPtr->printf("%02x ", Str[i]);
//  810 		SerPtr->printf("\n");
//  811 
//  812 
//  813 	}
//  814 	#endif
//  815 	
//  816 	udpdesportcmp(nUSE, 0, udp_preAddr[nUSE], daddr);
        MOV      R3,R6
        ADDW     R2,R7,#+3160
        MOVS     R1,#+0
        MOV      R0,R5
        BL       udpdesportcmp
//  817 	
//  818 	if(sendto(nUSE, 0, Str, Length,(u_char *)daddr, dport) == 0); //send the received data
        MOV      R0,R6
        UXTH     R1,R4
        PUSH     {R0,R1}
        MOV      R3,R8
        MOV      R2,R9
        MOVS     R1,#+0
        MOV      R0,R5
        BL       sendto
        ADD      SP,SP,#+8
//  819 
//  820 	OSSemPost(udpSem[nUSE]);
        LDR      R0,[R7, #+20]
        BL       OSSemPost
//  821 }
??udpPutStr_0:
        POP      {R0,R4-R9,PC}    ;; return
        DATA
??udpPutStr_1:
        DC32     ServAlmSndCnt
//  822 
//  823 
//  824 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  825 void EthernetServerMode(INT32U nUSE)
//  826 {
EthernetServerMode:
        PUSH     {R4,LR}
        MOV      R4,R0
//  827 	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0), Sn_CR_CLOSE);
        MOVS     R2,#+16
        MOVW     R1,#+1025
        BL       IINCHIP_WRITE
//  828 	OSTimeDly(2000L);
        MOV      R0,#+2000
        BL       OSTimeDly
//  829 	EthernetInitSet(nUSE, TCP_Server_Mode, FALSE);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOV      R0,R4
        BL       EthernetInitSet
//  830 	if (Ethernet_Debug) USART1Printf("Server로 전환\n");
        LDR.N    R0,??EthernetServerMode_0  ;; Ethernet_Debug
        LDRB     R0,[R0, #+0]
        CBZ      R0,??EthernetServerMode_1
        LDR.N    R0,??EthernetServerMode_0+0x4  ;; `?<Constant "Server\\267\\316 \\300\\374\\310\\257\\n"`
        BL       USART1Printf
//  831 }
??EthernetServerMode_1:
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??EthernetServerMode_0:
        DC32     Ethernet_Debug
        DC32     `?<Constant "Server\\267\\316 \\300\\374\\310\\257\\n"`
//  832 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  833 void EthernetClientMode(INT32U nUSE)
//  834 {
EthernetClientMode:
        PUSH     {R4,LR}
        MOV      R4,R0
//  835 	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0),Sn_CR_CLOSE);
        MOVS     R2,#+16
        MOVW     R1,#+1025
        BL       IINCHIP_WRITE
//  836 	OSTimeDly(2000L);
        MOV      R0,#+2000
        BL       OSTimeDly
//  837 	EthernetInitSet(nUSE, TCP_Client_Mode, FALSE);
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOV      R0,R4
        BL       EthernetInitSet
//  838 	if (Ethernet_Debug) USART1Printf("Client로 전환\n");
        LDR.N    R0,??EthernetClientMode_0  ;; Ethernet_Debug
        LDRB     R0,[R0, #+0]
        CBZ      R0,??EthernetClientMode_1
        LDR.N    R0,??EthernetClientMode_0+0x4  ;; `?<Constant "Client\\267\\316 \\300\\374\\310\\257\\n"`
        BL       USART1Printf
//  839 }
??EthernetClientMode_1:
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??EthernetClientMode_0:
        DC32     Ethernet_Debug
        DC32     `?<Constant "Client\\267\\316 \\300\\374\\310\\257\\n"`
//  840 
//  841 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  842 void EthernetPortReset(void)
//  843 {
EthernetPortReset:
        PUSH     {R4,LR}
//  844 	W3150RST = 1;
        LDR.N    R4,??EthernetPortReset_0  ;; 0x40010c0c
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R4, #+0]
//  845 	OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
//  846 	W3150RST = 0;
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        BICS     R0,R0,R1
        STR      R0,[R4, #+0]
//  847 	OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
//  848 	W3150RST = 1;
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R4, #+0]
//  849 }
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??EthernetPortReset_0:
        DC32     0x40010c0c
//  850 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  851 void EthernetInitSet(INT32U nUSE, INT8U Mode, INT8U TcpDebug)
//  852 {
EthernetInitSet:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+16
        MOV      R4,R0
        MOV      R5,R2
//  853 	INT8U tmp[6];
//  854 	INT16U nPort;
//  855 	INT8U err0 = 0;
        MOVS     R0,#+0
//  856 	INT8U err1 = 0;
        STRH     R0,[SP, #+8]
//  857 
//  858 	
//  859 	if(udpSem[0])	OSSemPend(udpSem[0], 0, &err0);
        LDR.W    R9,??EthernetInitSet_0  ;; ServAlmSndCnt
        LDR      R0,[R9, #+20]
        CBZ      R0,??EthernetInitSet_1
        ADD      R2,SP,#+9
        MOVS     R1,#+0
        BL       OSSemPend
//  860 	if(udpSem[1])	OSSemPend(udpSem[1], 0, &err1);
??EthernetInitSet_1:
        LDR      R0,[R9, #+24]
        CBZ      R0,??EthernetInitSet_2
        ADD      R2,SP,#+8
        MOVS     R1,#+0
        BL       OSSemPend
//  861 
//  862 	W3150RST = 1;
??EthernetInitSet_2:
        LDR.N    R0,??EthernetInitSet_0+0x4  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//  863 		
//  864 	w3150ainit(nUSE);
        MOV      R0,R4
        BL       w3150ainit
//  865 
//  866 	if(nUSE == ETH0_CHANNEL) 	setGAR(nUSE, IPAddrInfo.Eth0GatewayAddr);
        LDR.N    R7,??EthernetInitSet_0+0x8  ;; IPAddrInfo
        CMP      R4,#+1
        ITTEE    EQ 
        ADDEQ    R1,R7,#+4
        MOVEQ    R0,#+1
        ADDNE    R1,R7,#+18
        MOVNE    R0,R4
//  867 	else					 	setGAR(nUSE, IPAddrInfo.Eth1GatewayAddr);	
        BL       setGAR
//  868 
//  869 	getGWIP(nUSE, tmp);
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       getGWIP
//  870 	if (TcpDebug)
        CBZ      R5,??EthernetInitSet_3
//  871 	{
//  872 		SerPtr->printf("nUSE CHANNEL: %d\n", nUSE); 
        LDR.N    R6,??EthernetInitSet_0+0xC  ;; SerPtr
        LDR.W    R8,??EthernetInitSet_0+0x10  ;; `?<Constant "nUSE CHANNEL: %d\\n">`
        MOV      R1,R4
        MOV      R0,R8
        LDR      R2,[R6, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  873 		SerPtr->printf("GatewayAddr: %d.%d.%d.%d\n", 
//  874 					tmp[0],
//  875 					tmp[1],
//  876 					tmp[2],
//  877 					tmp[3]);
        ADD      R2,SP,#+0
        LDRB     R0,[R2, #+3]
        PUSH     {R0,LR}
        LDRB     R3,[R2, #+2]
        LDRB     R2,[R2, #+1]
        LDRB     R1,[SP, #+8]
        ADD      R0,R8,#+20
        LDR      R6,[R6, #+0]
        LDR      R12,[R6, #+16]
        BLX      R12
        ADD      SP,SP,#+8
//  878 	}
//  879 	
//  880 	setSHAR(nUSE, MacAddrInfo.MacAddr[nUSE]);
??EthernetInitSet_3:
        MOVS     R0,#+6
        MUL      R8,R4,R0
        LDR.W    R10,??EthernetInitSet_0+0x14  ;; MacAddrInfo
        ADD      R6,R8,R10
        MOV      R1,R6
        MOV      R0,R4
        BL       setSHAR
//  881 	getSHAR(nUSE, tmp);
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       getSHAR
//  882 	if (TcpDebug)
        CBZ      R5,??EthernetInitSet_4
//  883 	{
//  884 		SerPtr->printf("MacAddr: %x[%x].%x[%x].%x[%x].%x[%x].%x[%x].%x[%x]\n", 
//  885 					tmp[0],MacAddrInfo.MacAddr[nUSE][0],
//  886 					tmp[1],MacAddrInfo.MacAddr[nUSE][1],
//  887 					tmp[2],MacAddrInfo.MacAddr[nUSE][2],
//  888 					tmp[3],MacAddrInfo.MacAddr[nUSE][3],
//  889 					tmp[4],MacAddrInfo.MacAddr[nUSE][4],
//  890 					tmp[5],MacAddrInfo.MacAddr[nUSE][5]);
        ADD      R2,SP,#+0
        LDRB     R0,[R6, #+5]
        PUSH     {R0,LR}
        LDRB     R1,[R2, #+5]
        LDRB     R0,[R6, #+4]
        PUSH     {R0,R1}
        LDRB     R1,[R2, #+4]
        LDRB     R0,[R6, #+3]
        PUSH     {R0,R1}
        LDRB     R1,[R2, #+3]
        LDRB     R0,[R6, #+2]
        PUSH     {R0,R1}
        LDRB     R1,[R2, #+2]
        LDRB     R0,[R6, #+1]
        PUSH     {R0,R1}
        LDRB     R3,[R2, #+1]
        LDRB     R2,[R8, R10]
        LDRB     R1,[SP, #+40]
        LDR.N    R0,??EthernetInitSet_0+0x18  ;; `?<Constant "nUSE CHANNEL: %d\\n">` + 48
        LDR.N    R6,??EthernetInitSet_0+0xC  ;; SerPtr
        LDR      R6,[R6, #+0]
        LDR      R12,[R6, #+16]
        BLX      R12
        ADD      SP,SP,#+40
//  891 	}
//  892 	if(nUSE == ETH0_CHANNEL)	setSUBR(nUSE, IPAddrInfo.Eth0SubnetAddr);
??EthernetInitSet_4:
        CMP      R4,#+1
        ITTEE    EQ 
        ADDEQ    R1,R7,#+8
        MOVEQ    R0,#+1
        ADDNE    R1,R7,#+22
        MOVNE    R0,R4
//  893 	else						setSUBR(nUSE, IPAddrInfo.Eth1SubnetAddr);
        BL       setSUBR
//  894 	getSUBR(nUSE, tmp);
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       getSUBR
//  895 	if (TcpDebug)
        CBZ      R5,??EthernetInitSet_5
//  896 	{
//  897 		SerPtr->printf("SubnetAddr: %d.%d.%d.%d\n", 
//  898 			tmp[0],
//  899 			tmp[1],
//  900 			tmp[2],
//  901 			tmp[3]);
        ADD      R2,SP,#+0
        LDRB     R0,[R2, #+3]
        PUSH     {R0,LR}
        LDRB     R3,[R2, #+2]
        LDRB     R2,[R2, #+1]
        LDRB     R1,[SP, #+8]
        LDR.N    R0,??EthernetInitSet_0+0x1C  ;; `?<Constant "nUSE CHANNEL: %d\\n">` + 100
        LDR.N    R6,??EthernetInitSet_0+0xC  ;; SerPtr
        LDR      R6,[R6, #+0]
        LDR      R12,[R6, #+16]
        BLX      R12
        ADD      SP,SP,#+8
//  902 	}
//  903 	if(nUSE == ETH0_CHANNEL)	setSIPR(nUSE, IPAddrInfo.Eth0IpAddr);
??EthernetInitSet_5:
        CMP      R4,#+1
        ITTEE    EQ 
        MOVEQ    R1,R7
        MOVEQ    R0,#+1
        ADDNE    R1,R7,#+14
        MOVNE    R0,R4
//  904 	else						setSIPR(nUSE, IPAddrInfo.Eth1IpAddr);
        BL       setSIPR
//  905 	getSIPR(nUSE, tmp);
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       getSIPR
//  906 
//  907 	if (TcpDebug)
        CBZ      R5,??EthernetInitSet_6
//  908 	{
//  909 		SerPtr->printf("IPAddr: %d.%d.%d.%d\n", 
//  910 			tmp[0],
//  911 			tmp[1],
//  912 			tmp[2],
//  913 			tmp[3]);
        ADD      R2,SP,#+0
        LDRB     R0,[R2, #+3]
        PUSH     {R0,LR}
        LDRB     R3,[R2, #+2]
        LDRB     R2,[R2, #+1]
        LDRB     R1,[SP, #+8]
        LDR.N    R0,??EthernetInitSet_0+0x20  ;; `?<Constant "nUSE CHANNEL: %d\\n">` + 128
        LDR.N    R5,??EthernetInitSet_0+0xC  ;; SerPtr
        LDR      R5,[R5, #+0]
        LDR      R5,[R5, #+16]
        BLX      R5
        ADD      SP,SP,#+8
//  914 	}
//  915 	sysinit(nUSE, 0x55, 0x55);
??EthernetInitSet_6:
        MOVS     R2,#+85
        MOVS     R1,#+85
        MOV      R0,R4
        BL       sysinit
//  916 
//  917 	if(nUSE == ETH0_CHANNEL)	nPort = (IPAddrInfo.Eth0Port[0] << 8) | (IPAddrInfo.Eth0Port[1] << 0);
        CMP      R4,#+1
        ITTEE    EQ 
        LDRBEQ   R0,[R7, #+12]
        LDRBEQ   R1,[R7, #+13]
        LDRBNE   R0,[R7, #+26]
        LDRBNE   R1,[R7, #+27]
//  918 	else						nPort = (IPAddrInfo.Eth1Port[0] << 8) | (IPAddrInfo.Eth1Port[1] << 0);	
        ORR      R3,R1,R0, LSL #+8
//  919 
//  920 	init_sock(nUSE, 0, Sn_MR_UDP, nPort, 0, (INT8U)NULL);
        MOVS     R1,#+0
        MOVS     R0,#+0
        PUSH     {R0,R1}
        MOVS     R2,#+2
        UXTB     R0,R4
        BL       init_sock
        ADD      SP,SP,#+8
//  921 
//  922 	if(udpSem[0])	OSSemPost(udpSem[0]);
        LDR      R0,[R9, #+20]
        CBZ      R0,??EthernetInitSet_7
        BL       OSSemPost
//  923 	if(udpSem[1])	OSSemPost(udpSem[1]);
??EthernetInitSet_7:
        LDR      R0,[R9, #+24]
        CBZ      R0,??EthernetInitSet_8
        BL       OSSemPost
//  924 	
//  925 	OSTimeDly(1000L);
??EthernetInitSet_8:
        MOV      R0,#+1000
        BL       OSTimeDly
//  926 }
        ADD      SP,SP,#+16
        POP      {R4-R10,PC}      ;; return
        Nop      
        DATA
??EthernetInitSet_0:
        DC32     ServAlmSndCnt
        DC32     0x40010c0c
        DC32     IPAddrInfo
        DC32     SerPtr
        DC32     `?<Constant "nUSE CHANNEL: %d\\n">`
        DC32     MacAddrInfo
        DC32     `?<Constant "nUSE CHANNEL: %d\\n">` + 48
        DC32     `?<Constant "nUSE CHANNEL: %d\\n">` + 100
        DC32     `?<Constant "nUSE CHANNEL: %d\\n">` + 128
//  927 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  928 void init_sock(INT8U nUSE, SOCKET s, uint8 protocol, uint16 port, uint8 flag, uint8 *serverip) 
//  929 {
init_sock:
        PUSH     {R3-R9,LR}
        MOV      R4,R1
        MOV      R5,R2
        MOV      R8,R3
        LDR      R6,[SP, #+32]
        LDR      R7,[SP, #+36]
//  930 	// sflag: 1: clent mode, 0: server mode
//  931 	socket(nUSE, s, protocol, port, flag);	/* Create a new socket */
        MOV      R9,R0
        PUSH     {R6,LR}
        BL       socket
        ADD      SP,SP,#+8
//  932 
//  933 	if(protocol == Sn_MR_TCP)
        CMP      R5,#+1
        BNE.N    ??init_sock_0
//  934 	{
//  935 		if (serverip != NULL)
        CBZ      R7,??init_sock_1
//  936 		{
//  937 		
//  938 			if (connect(nUSE, s, serverip, port) == 0) {
        MOV      R3,R8
        MOV      R2,R7
        MOV      R1,R4
        MOV      R0,R9
        BL       connect
        CBNZ     R0,??init_sock_0
//  939 				socket(nUSE, s, Sn_MR_TCP, port, flag);	/* Create a new socket */
        PUSH     {R6,LR}
        MOV      R3,R8
        MOVS     R2,#+1
        MOV      R1,R4
        MOV      R0,R9
        BL       socket
        ADD      SP,SP,#+8
//  940 				listen(nUSE, s);           				/* Server Mode */
//  941 			}
//  942 		}
//  943 		else
//  944 		{
//  945 			listen(nUSE, s);           			/* Server Mode */
??init_sock_1:
        MOV      R1,R4
        MOV      R0,R9
        BL       listen
//  946 		}
//  947 	}
//  948 }
??init_sock_0:
        POP      {R0,R4-R9,PC}    ;; return
//  949 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  950 INT32U eLink_Check(INT32U nUSE)
//  951 {
eLink_Check:
        MOV      R1,R0
//  952 	INT32U rval = FALSE;
        MOVS     R0,#+0
//  953 
//  954          if(nUSE == ETH0_CHANNEL) 	rval = GPIOA->IDR.B1;
        CMP      R1,#+1
        BNE.N    ??eLink_Check_0
        LDR.N    R0,??eLink_Check_1  ;; 0x40010808
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x2
        LSRS     R0,R0,#+1
        BX       LR
//  955 	else if(nUSE == ETH1_CHANNEL)	rval = GPIOA->IDR.B0;
??eLink_Check_0:
        CMP      R1,#+0
        BNE.N    ??eLink_Check_2
        LDR.N    R0,??eLink_Check_1  ;; 0x40010808
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x1
//  956 	
//  957 	return rval;
??eLink_Check_2:
        BX       LR               ;; return
        Nop      
        DATA
??eLink_Check_1:
        DC32     0x40010808
//  958 
//  959 }

        END
//  960 
//  961 //////////////////////////////////////////////////////
//  962 // End of Source File
//  963 ////////////////////////
//  964 
// 
// 4 834 bytes in section .bss
// 3 168 bytes in section .data
//   204 bytes in section .rodata
// 5 664 bytes in section .text
// 
// 5 664 bytes of CODE  memory
//   204 bytes of CONST memory
// 8 002 bytes of DATA  memory
//
//Errors: none
//Warnings: none
