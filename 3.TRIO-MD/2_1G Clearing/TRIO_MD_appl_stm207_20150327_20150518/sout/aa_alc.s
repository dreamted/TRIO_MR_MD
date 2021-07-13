///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    23/Aug/2012  00:33:40 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_alc /
//                    .c                                                      /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_alc /
//                    .c -lcN C:\user\project\FR-SSR\fw\appl_ssr_20120717\sou /
//                    t\ -lB C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout /
//                    \ -o C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\  /
//                    --endian=little --cpu=Cortex-M3 -e                      /
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
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\aa_alc /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_alc

        EXTERN AD9362GetRssi
        EXTERN ADC_AVR
        EXTERN ADC_ChannelEnable
        EXTERN ADC_CheckFinish
        EXTERN ADC_DATA
        EXTERN Booting
        EXTERN DownLoadBootingJump
        EXTERN DownLoadGiveupTimerSet
        EXTERN FrontLEDStausUpdate
        EXTERN IsItiFPGAInit
        EXTERN MainStatus
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ReadEnvTempTable
        EXTERN ReadPwrTableAscending
        EXTERN RoadBackuptobuffer
        EXTERN SelectSort
        EXTERN SerPtr
        EXTERN SleepTempOffset
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN WriteBuffertoBackup
        EXTERN rambackup
        EXTERN tTestFlag

        PUBLIC AgcLimitOperation
        PUBLIC AgcOperation
        PUBLIC AlcInit
        PUBLIC AlcOperation
        PUBLIC AlcTask
        PUBLIC BlinkFlag
        PUBLIC ChangeLvltoValue
        PUBLIC ConvLevelOneByte
        PUBLIC FrontLEDDisplay
        PUBLIC FrontLEDSet
        PUBLIC ISORvsAttn1
        PUBLIC ISORvsAttn2
        PUBLIC ISORvsAttn3
        PUBLIC ISORvsAttn4
        PUBLIC InitLedDisplay
        PUBLIC InitLedStep
        PUBLIC IsolationCheckFunc
        PUBLIC LEDStatus
        PUBLIC LimitAlarmCnt
        PUBLIC LimitAlarmUpdate
        PUBLIC MinAttn3G
        PUBLIC MinAttn4G
        PUBLIC OSCCheckFunc
        PUBLIC ReadAdcValue
        PUBLIC ResetCaseBackup
        PUBLIC ResetStart
        PUBLIC RetFWDPower
        PUBLIC SDNOffFlag
        PUBLIC ShutDnCheckFunc
        PUBLIC SleepCheckFunc
        PUBLIC SleepLogFunc
        PUBLIC TemptoIndex
        PUBLIC TemptoSleepOffset
        PUBLIC UPdateAlarm
        PUBLIC mISOCheck_3G
        PUBLIC mISOCheck_4G
        PUBLIC mOSCCheck_3G
        PUBLIC mOSCCheck_4G
        PUBLIC mSDCheck_3G
        PUBLIC mSDCheck_4G
        PUBLIC mSleep_3G
        PUBLIC mSleep_4G
        PUBLIC tmpSleepTimeOn

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_alc.c
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
//   11 #define ALC_C
//   12 
//   13 #include "../include/main.h"

        SECTION iram:DATA:NOROOT(2)
// static __absolute OS_STK AlcTaskStk[256]
AlcTaskStk:
        DS8 1024

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT8U MinAttn4G
MinAttn4G:
        DS8 1
// __absolute INT8U MinAttn3G
MinAttn3G:
        DS8 1
        DS8 2
// __absolute __IsoStr mISOCheck_4G
mISOCheck_4G:
        DS8 8

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __IsoStr mISOCheck_3G
mISOCheck_3G:
        DS8 8

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __OscStr mOSCCheck_4G
mOSCCheck_4G:
        DS8 8

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __OscStr mOSCCheck_3G
mOSCCheck_3G:
        DS8 8

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __ShutDnStr mSDCheck_4G
mSDCheck_4G:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __ShutDnStr mSDCheck_3G
mSDCheck_3G:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __SleepStr mSleep_4G
mSleep_4G:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute __SleepStr mSleep_3G
mSleep_3G:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U InitLedDisplay
InitLedDisplay:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U InitLedStep
InitLedStep:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT8U BlinkFlag
BlinkFlag:
        DS8 1
        DS8 3
// __absolute INT8U LEDStatus[(enum <unnamed>)6U]
LEDStatus:
        DS8 8

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U ISORvsAttn1
ISORvsAttn1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U ISORvsAttn2
ISORvsAttn2:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U ISORvsAttn3
ISORvsAttn3:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U ISORvsAttn4
ISORvsAttn4:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U SDNOffFlag
SDNOffFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT32U tmpSleepTimeOn[2]
tmpSleepTimeOn:
        DS8 8
//   14 
//   15 #include <stdlib.h>
//   16 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   17 void AlcInit(void)
//   18 {
AlcInit:
        PUSH     {R7,LR}
//   19 	{
//   20 		INT32U *s = (INT32U *)(__pBOOTAddr + 36);
//   21 
//   22 		if(*s == _pilog){
        LDR.W    R0,??DataTable8  ;; 0x8000024
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable8_1  ;; 0x4c4f5049
        CMP      R0,R1
        BNE.N    ??AlcInit_0
//   23 			OSTaskCreate(AlcTask, (void *)NULL, (OS_STK *)&AlcTaskStk[ALC_START_STK_SIZE - 1], ALC_START_PRIO);
        MOVS     R3,#+1
        LDR.W    R2,??DataTable8_2
        MOVS     R1,#+0
        LDR.W    R0,??DataTable9
        BL       OSTaskCreate
//   24 		}
//   25 	}
//   26 }
??AlcInit_0:
        POP      {R0,PC}          ;; return
//   27 
//   28 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   29 void AlcTask(void *p_arg)
//   30 {
AlcTask:
        PUSH     {R4,LR}
//   31 	(void)p_arg;
//   32 
//   33 	TimerRegist(TimerLEDBlink, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+8
        BL       TimerRegist
//   34 	TimerRegist(TimerSleepOn, Time1Sec);
        MOV      R1,#+1000
        MOVS     R0,#+19
        BL       TimerRegist
//   35 
//   36 	OSTimeDly(10L*ALC_START_PRIO);
        MOVS     R0,#+10
        BL       OSTimeDly
        LDR.W    R4,??DataTable9_1
        B.N      ??AlcTask_0
//   37 	
//   38     while(1)
//   39 	{
//   40 		if(!tTestFlag) FrontLEDDisplay();
//   41 		
//   42 		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
//   43 		{
//   44 			while(!IsItiFPGAInit()){
//   45 				OSTimeDly(1000L);
??AlcTask_1:
        MOV      R0,#+1000
        BL       OSTimeDly
//   46 			}
??AlcTask_2:
        BL       IsItiFPGAInit
        CMP      R0,#+0
        BEQ.N    ??AlcTask_1
//   47 
//   48 			ReadAdcValue();
        BL       ReadAdcValue
//   49 			FrontLEDStausUpdate(); 	//
        BL       FrontLEDStausUpdate
//   50 			FrontLEDDisplay();
        BL       FrontLEDDisplay
//   51 			SleepLogFunc();
        BL       SleepLogFunc
//   52 			
//   53 			OSTimeDly(40L);
        MOVS     R0,#+40
        BL       OSTimeDly
//   54 		}
??AlcTask_3:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBNZ.N   R0,??AlcTask_4
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??AlcTask_2
//   55 		OSTimeDly(250L);
??AlcTask_4:
        MOVS     R0,#+250
        BL       OSTimeDly
??AlcTask_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BNE.N    ??AlcTask_3
        BL       FrontLEDDisplay
        B.N      ??AlcTask_3
//   56 	}
//   57 }
//   58 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   59 void ReadAdcValue (void)
//   60 {
ReadAdcValue:
        PUSH     {R3-R7,LR}
//   61 	INT8U isminval = FALSE;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//   62 	INT8S tmp = (ReadEnvTempTable(ADC_DATA[adcEnvTemp])/10);
        MOVS     R4,#+10
        LDR.W    R5,??DataTable8_3
        LDRH     R0,[R5, #+30]
        BL       ReadEnvTempTable
        SDIV     R7,R0,R4
        SXTB     R7,R7
//   63 
//   64 	INT16S tmpDect;
//   65 
//   66 
//   67 	if(ADC_CheckFinish(adcEnvTemp)){
        MOVS     R0,#+15
        BL       ADC_CheckFinish
        CBZ.N    R0,??ReadAdcValue_0
//   68 		
//   69 		ADC_DATA[adcEnvTemp] =  ADC_AVR[adcEnvTemp][0];
        LDR.W    R0,??DataTable8_4
        LDR      R0,[R0, #+60]
        LDRH     R0,[R0, #+0]
        STRH     R0,[R5, #+30]
//   70 		ADC_ChannelEnable(adcEnvTemp);
        MOVS     R0,#+15
        BL       ADC_ChannelEnable
//   71 	}
//   72 
//   73 	if(ADC_CheckFinish(adcFWDPWRdect1))
??ReadAdcValue_0:
        MOVS     R0,#+1
        BL       ADC_CheckFinish
        CBZ.N    R0,??ReadAdcValue_1
//   74 	{
//   75 		ADC_DATA[adcFWDPWRdect1] = SelectSort(ADC_AVR[adcFWDPWRdect1], 40, 40, __ADCAVR);
        MOVS     R3,#+150
        MOVS     R2,#+40
        MOVS     R1,#+40
        LDR.W    R0,??DataTable8_4
        LDR      R0,[R0, #+4]
        BL       SelectSort
        STRH     R0,[R5, #+2]
//   76 		ADC_ChannelEnable(adcFWDPWRdect1);
        MOVS     R0,#+1
        BL       ADC_ChannelEnable
//   77 	}
//   78 
//   79 	if(ADC_CheckFinish(adcFWDPWRdect2))
??ReadAdcValue_1:
        MOVS     R0,#+0
        BL       ADC_CheckFinish
        CBZ.N    R0,??ReadAdcValue_2
//   80 	{
//   81 		ADC_DATA[adcFWDPWRdect2] = SelectSort(ADC_AVR[adcFWDPWRdect2], 40, 40, __ADCAVR);
        MOVS     R3,#+150
        MOVS     R2,#+40
        MOVS     R1,#+40
        LDR.W    R0,??DataTable8_4
        LDR      R0,[R0, #+0]
        BL       SelectSort
        STRH     R0,[R5, #+0]
//   82 		ADC_ChannelEnable(adcFWDPWRdect2);
        MOVS     R0,#+0
        BL       ADC_ChannelEnable
//   83 	}
//   84 
//   85 	if(ADC_CheckFinish(adcRVSPWRdect1))
??ReadAdcValue_2:
        MOVS     R0,#+5
        BL       ADC_CheckFinish
        CBZ.N    R0,??ReadAdcValue_3
//   86 	{
//   87 		ADC_DATA[adcRVSPWRdect1] = SelectSort(ADC_AVR[adcRVSPWRdect1], 40, 40, __ADCAVR);
        MOVS     R3,#+150
        MOVS     R2,#+40
        MOVS     R1,#+40
        LDR.W    R0,??DataTable8_4
        LDR      R0,[R0, #+20]
        BL       SelectSort
        STRH     R0,[R5, #+10]
//   88 		ADC_ChannelEnable(adcRVSPWRdect1);
        MOVS     R0,#+5
        BL       ADC_ChannelEnable
//   89 	}
//   90 
//   91 	if(ADC_CheckFinish(adcRVSPWRdect2))
??ReadAdcValue_3:
        MOVS     R0,#+4
        BL       ADC_CheckFinish
        CBZ.N    R0,??ReadAdcValue_4
//   92 	{
//   93 		ADC_DATA[adcRVSPWRdect2] = SelectSort(ADC_AVR[adcRVSPWRdect2], 40, 40, __ADCAVR);
        MOVS     R3,#+150
        MOVS     R2,#+40
        MOVS     R1,#+40
        LDR.W    R0,??DataTable8_4
        LDR      R0,[R0, #+16]
        BL       SelectSort
        STRH     R0,[R5, #+8]
//   94 		ADC_ChannelEnable(adcRVSPWRdect2);
        MOVS     R0,#+4
        BL       ADC_ChannelEnable
//   95 	}
//   96 
//   97 	MainStatus->TxRssidBFSSts_3G = AD9362GetRssi(SPI_3G_TX_CH, (MainStatus->RFPathSelTx_3G & 0x01));
??ReadAdcValue_4:
        LDR.W    R6,??DataTable9_2
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+103]
        AND      R1,R0,#0x1
        MOVS     R0,#+0
        BL       AD9362GetRssi
        LDR      R1,[R6, #+0]
        STRB     R0,[R1, #+105]
//   98 	MainStatus->RxRssidBFSSts_3G = AD9362GetRssi(SPI_3G_RX_CH, (MainStatus->RFPathSelRx_3G & 0x01));
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+104]
        AND      R1,R0,#0x1
        MOVS     R0,#+1
        BL       AD9362GetRssi
        LDR      R1,[R6, #+0]
        STRB     R0,[R1, #+107]
//   99 
//  100 	MainStatus->TxRssidBFSSts_4G = AD9362GetRssi(SPI_4G_TX_CH, (MainStatus->RFPathSelTx_4G & 0x01));
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+101]
        AND      R1,R0,#0x1
        MOVS     R0,#+2
        BL       AD9362GetRssi
        LDR      R1,[R6, #+0]
        STRB     R0,[R1, #+109]
//  101 	MainStatus->RxRssidBFSSts_4G = AD9362GetRssi(SPI_4G_RX_CH, (MainStatus->RFPathSelRx_4G & 0x01));
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+102]
        AND      R1,R0,#0x1
        MOVS     R0,#+3
        BL       AD9362GetRssi
        LDR      R1,[R6, #+0]
        STRB     R0,[R1, #+111]
//  102 
//  103 	MainStatus->ENVTemp = tmp;
        LDR      R0,[R6, #+0]
        STRB     R7,[R0, #+30]
//  104 
//  105 	tmpDect = MainStatus->TxRssidBFSSts_3G - MainStatus->TxRssidBFSSet_3G;
//  106 	tmpDect = -35 - (tmpDect/4);
        LDR      R1,[R6, #+0]
        LDRB     R0,[R1, #+105]
        LDRB     R2,[R1, #+106]
        SUBS     R0,R0,R2
        MVN      R2,#+34
        ASRS     R3,R0,#+1
        ADD      R0,R0,R3, LSR #+30
        SUB      R2,R2,R0, ASR #+2
        SXTH     R2,R2
//  107 	if(tmpDect > -30) tmpDect = -30;
        MVN      R0,#+28
        CMP      R2,R0
        IT       GE 
        MVNGE    R2,#+29
//  108 	MainStatus->FwdRssi_3G	= tmpDect;
        STRB     R2,[R1, #+26]
//  109 
//  110 	tmpDect = MainStatus->RxRssidBFSSts_3G - MainStatus->RxRssidBFSSet_3G;
//  111 	tmpDect = -35 - (tmpDect/4);
        LDR      R1,[R6, #+0]
        LDRB     R2,[R1, #+107]
        LDRB     R3,[R1, #+108]
        SUBS     R2,R2,R3
        MVN      R3,#+34
        ASRS     R7,R2,#+1
        ADD      R2,R2,R7, LSR #+30
        SUB      R2,R3,R2, ASR #+2
        SXTH     R2,R2
//  112 	if(tmpDect > -30) tmpDect = -30;
        CMP      R2,R0
        IT       GE 
        MVNGE    R2,#+29
//  113 	MainStatus->RvsRssi_3G	= tmpDect;
        STRB     R2,[R1, #+27]
//  114 
//  115 	tmpDect = MainStatus->TxRssidBFSSts_4G - MainStatus->TxRssidBFSSet_4G;
//  116 	tmpDect = -35 - (tmpDect/4);
        LDR      R1,[R6, #+0]
        LDRB     R2,[R1, #+109]
        LDRB     R3,[R1, #+110]
        SUBS     R2,R2,R3
        MVN      R3,#+34
        ASRS     R7,R2,#+1
        ADD      R2,R2,R7, LSR #+30
        SUB      R2,R3,R2, ASR #+2
        SXTH     R2,R2
//  117 	if(tmpDect > -30) tmpDect = -30;
        CMP      R2,R0
        IT       GE 
        MVNGE    R2,#+29
//  118 	MainStatus->FwdRssi_4G	= tmpDect;
        STRB     R2,[R1, #+22]
//  119 
//  120 	tmpDect = MainStatus->RxRssidBFSSts_4G - MainStatus->RxRssidBFSSet_4G;
//  121 	tmpDect = -35 - (tmpDect/4);
        LDR      R1,[R6, #+0]
        LDRB     R2,[R1, #+111]
        LDRB     R3,[R1, #+112]
        SUBS     R2,R2,R3
        MVN      R3,#+34
        ASRS     R7,R2,#+1
        ADD      R2,R2,R7, LSR #+30
        SUB      R2,R3,R2, ASR #+2
        SXTH     R2,R2
//  122 	if(tmpDect > -30) tmpDect = -30;
        CMP      R2,R0
        IT       GE 
        MVNGE    R2,#+29
//  123 	MainStatus->RvsRssi_4G	= tmpDect;
        STRB     R2,[R1, #+23]
//  124 	
//  125 
//  126 	MainStatus->PCSRvsPower     = ReadPwrTableAscending( (ADC_DATA[adcRVSPWRdect1] >> 2), 1, TRUE, &isminval)/10L;
        ADD      R3,SP,#+0
        MOVS     R2,#+1
        MOVS     R1,#+1
        LDRH     R0,[R5, #+10]
        LSRS     R0,R0,#+2
        BL       ReadPwrTableAscending
        SDIV     R0,R0,R4
        LDR      R1,[R6, #+0]
        STRB     R0,[R1, #+25]
//  127 	MainStatus->WCDMARvsPower   = ReadPwrTableAscending( (ADC_DATA[adcRVSPWRdect2] >> 2), 3, TRUE, &isminval)/10L;
        ADD      R3,SP,#+0
        MOVS     R2,#+1
        MOVS     R1,#+3
        LDRH     R0,[R5, #+8]
        LSRS     R0,R0,#+2
        BL       ReadPwrTableAscending
        SDIV     R0,R0,R4
        LDR      R1,[R6, #+0]
        STRB     R0,[R1, #+29]
//  128 
//  129 	tmpDect 					= (ReadPwrTableAscending( (ADC_DATA[adcFWDPWRdect1] >> 2), 0, FALSE, &isminval)*5L)/10L;
        ADD      R3,SP,#+0
        MOVS     R2,#+0
        MOV      R1,R2
        LDRH     R0,[R5, #+2]
        LSRS     R0,R0,#+2
        BL       ReadPwrTableAscending
//  130 	if(isminval) 	MainStatus->PCSFwdPower = -20 * 5L;
        LDR      R1,[R6, #+0]
        LDRB     R2,[SP, #+0]
        CMP      R2,#+0
        ITEE     NE 
        MVNNE    R0,#+99
        ADDEQ    R0,R0,R0, LSL #+2
        SDIVEQ   R0,R0,R4
//  131 	else			MainStatus->PCSFwdPower = tmpDect;
        STRB     R0,[R1, #+24]
//  132 
//  133 
//  134 	tmpDect						= (ReadPwrTableAscending( (ADC_DATA[adcFWDPWRdect2] >> 2), 2, FALSE, &isminval)*5L)/10L;
        ADD      R3,SP,#+0
        MOVS     R2,#+0
        MOVS     R1,#+2
        LDRH     R0,[R5, #+0]
        LSRS     R0,R0,#+2
        BL       ReadPwrTableAscending
//  135 	if(isminval) 	MainStatus->WCDMAFwdPower = -20 * 5L;
        LDR      R1,[R6, #+0]
        LDRB     R2,[SP, #+0]
        CMP      R2,#+0
        ITEE     NE 
        MVNNE    R0,#+99
        ADDEQ    R0,R0,R0, LSL #+2
        SDIVEQ   R0,R0,R4
//  136 	else			MainStatus->WCDMAFwdPower = tmpDect;
        STRB     R0,[R1, #+28]
//  137 	
//  138 }
        POP      {R0,R4-R7,PC}    ;; return
//  139 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  140 INT8U AgcOperation(INT8U IsIt3G, INT8U IsItOSC)
//  141 {
AgcOperation:
        PUSH     {R3-R11,LR}
//  142   	INT8U rval = FALSE;
//  143 
//  144 	INT8S *iFWDAttn;
//  145 	INT8S *iRVSAttn;
//  146 	INT8S *iFwdPower;
//  147 	INT8S *iFwdLmt;
//  148 	INT8S *iRvsLmt;
//  149 	INT8U *iAGCTimeUpper;
//  150 	INT8U *iAGCTimeLower;
//  151 	INT8U *iFWDSWOnOff;
//  152 
//  153 	INT8U iMinAttn;
//  154 	INT8U iAgcTimer;
//  155 	if(!IsIt3G)
        LDR.W    R2,??DataTable9_2
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable12
        CBNZ.N   R0,??AgcOperation_0
//  156 	{
//  157 		iFWDAttn = &MainStatus->FwdAttn_4G;
        ADDS     R4,R2,#+2
//  158 		iRVSAttn = &MainStatus->RvsAttn_4G;
        ADDW     R5,R2,#+6
//  159 		iFwdPower = &MainStatus->PCSFwdPower;
        ADD      R0,R2,#+24
        STR      R0,[SP, #+0]
//  160 		iAGCTimeUpper = &MainStatus->AGCTimeUpper1;
        ADDW     R10,R2,#+64
//  161 		iAGCTimeLower = &MainStatus->AGCTimeLower1;
        ADDW     R11,R2,#+63
//  162 		iFwdLmt = &MainStatus->AGCLimit1;
        ADDW     R8,R2,#+55
//  163 		iRvsLmt = &MainStatus->AGCLimit2;
        ADDW     R9,R2,#+56
//  164 		iFWDSWOnOff = &MainStatus->TxSWOnOff_4G;
        ADDW     R0,R2,#+33
//  165 		iMinAttn = MinAttn4G;
        LDRB     R6,[R3, #+0]
//  166 		iAgcTimer = AgcChkTimer1;
        MOVS     R7,#+5
        B.N      ??AgcOperation_1
//  167 	}
//  168 	else
//  169 	{
//  170 		iFWDAttn = &MainStatus->FwdAttn_3G;
??AgcOperation_0:
        ADDW     R4,R2,#+3
//  171 		iRVSAttn = &MainStatus->RvsAttn_3G;
        ADD      R5,R2,#+8
//  172 		iFwdPower = &MainStatus->WCDMAFwdPower;
        ADDW     R0,R2,#+28
        STR      R0,[SP, #+0]
//  173 		iAGCTimeUpper = &MainStatus->AGCTimeUpper2;
        ADDW     R10,R2,#+66
//  174 		iAGCTimeLower = &MainStatus->AGCTimeLower2;
        ADDW     R11,R2,#+65
//  175 		iFwdLmt = &MainStatus->AGCLimit3;
        ADDW     R8,R2,#+57
//  176 		iRvsLmt = &MainStatus->AGCLimit4;
        ADDW     R9,R2,#+58
//  177 		iFWDSWOnOff = &MainStatus->TxSWOnOff_3G;
        ADDW     R0,R2,#+81
//  178 		iMinAttn = MinAttn3G;
        LDRB     R6,[R3, #+1]
//  179 		iAgcTimer = AgcChkTimer2;
        MOVS     R7,#+6
//  180 	}
//  181 	
//  182 	{
//  183 		INT32S gap;
//  184 		INT32S tmpAttn;
//  185 		INT16U tval;
//  186         
//  187 		if(MainStatus->ALCOnOff == '1' ) return FALSE;
??AgcOperation_1:
        LDRSB    R3,[R2, #+72]
        CMP      R3,#+49
        BNE.N    ??AgcOperation_2
??AgcOperation_3:
        MOVS     R0,#+0
        POP      {R1,R4-R11,PC}   ;; return
//  188 		if(MainStatus->AGCOnOff != '1' ) return FALSE;
??AgcOperation_2:
        LDRB     R2,[R2, #+40]
        CMP      R2,#+49
        BNE.N    ??AgcOperation_3
//  189 		if(*iFWDSWOnOff == '0') return FALSE;
        LDRB     R0,[R0, #+0]
        CMP      R0,#+48
        BEQ.N    ??AgcOperation_3
//  190 		if(IsItOSC){
        CMP      R1,#+0
        BNE.N    ??AgcOperation_3
//  191 			//tval = ((INT16U)(*iAGCTimeUpper) << 8) | ((INT16U)(*iAGCTimeLower));
//  192 			//TimerRegist(iAgcTimer, (tval*Time1Sec));
//  193 			return FALSE;
//  194 		}
//  195 //SerPtr->printf("%d, %d, %d \n", IsIt3G, *iAGCTimeUpper, *iAGCTimeLower);
//  196 		if(TimeOverCheck(iAgcTimer))
        MOV      R0,R7
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??AgcOperation_3
//  197 		{
//  198 			gap = RetFWDPower(*iFwdPower) - (*iFwdLmt);
        LDR      R0,[SP, #+0]
        LDRSB    R0,[R0, #+0]
        BL       RetFWDPower
//  199 
//  200 			//SerPtr->printf("CHECK %d,  %d, %d, gap = %d, (*iFWDAttn) %d\n", (*iFwdPower), RetFWDPower((*iFwdPower)), (*iFwdLmt), gap, (*iFWDAttn));
//  201 			{
//  202 				tmpAttn = (*iFWDAttn) + gap;
        LDRSB    R1,[R4, #+0]
        ADDS     R0,R0,R1
        LDRSB    R1,[R8, #+0]
        SUBS     R0,R0,R1
//  203 				
//  204 				if(tmpAttn > ATTN_MAX30) 	tmpAttn = ATTN_MAX30;
        CMP      R0,#+31
        IT       GE 
        MOVGE    R0,#+30
//  205 				if(tmpAttn < iMinAttn) 	    tmpAttn = iMinAttn;
        CMP      R0,R6
        IT       LT 
        MOVLT    R0,R6
//  206 
//  207 				*iFWDAttn = tmpAttn;
        STRB     R0,[R4, #+0]
//  208 
//  209 				// pcs reverse //
//  210 				tmpAttn = *iFWDAttn - (*iRvsLmt);
        LDRSB    R0,[R4, #+0]
        LDRSB    R1,[R9, #+0]
        SUBS     R0,R0,R1
//  211 				
//  212 				if(tmpAttn > ATTN_MAX30) 	tmpAttn = ATTN_MAX30;
        CMP      R0,#+31
        IT       GE 
        MOVGE    R0,#+30
//  213 				if(tmpAttn < iMinAttn) 	    tmpAttn = iMinAttn;
        CMP      R0,R6
        IT       LT 
        MOVLT    R0,R6
//  214 
//  215 				*iRVSAttn = tmpAttn;
        STRB     R0,[R5, #+0]
//  216 			}
//  217 
//  218 			//	AGC TIME CALCULATION  //
//  219 			tval = ((INT16U)(*iAGCTimeUpper) << 8) | ((INT16U)(*iAGCTimeLower));
//  220 			TimerRegist(iAgcTimer, (tval*Time1Sec));
        LDRB     R0,[R10, #+0]
        LDRB     R1,[R11, #+0]
        ORR      R0,R1,R0, LSL #+8
        MOV      R1,#+1000
        MULS     R1,R1,R0
        MOV      R0,R7
        BL       TimerRegist
        B.N      ??AgcOperation_3
//  221 		}		
//  222 	}
//  223 	return rval;
//  224 }
//  225 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  226 INT8S RetFWDPower(INT8S tmp)
//  227 {
//  228 	INT16S rval = (INT16S)tmp*2;
RetFWDPower:
        LSLS     R0,R0,#+17
        ASRS     R0,R0,#+16
//  229 
//  230 	tmp = rval%10;
        MOVS     R1,#+10
        SDIV     R2,R0,R1
        MLS      R2,R1,R2,R0
//  231 
//  232 	if     (tmp > 5) rval += 10;
        SXTB     R2,R2
        CMP      R2,#+6
        IT       GE 
        ADDGE    R0,R0,#+10
        BGE.N    ??RetFWDPower_0
//  233 	else if(tmp <-5) rval -= 10;
        MVN      R3,#+4
        CMP      R2,R3
        BGE.N    ??RetFWDPower_1
        SUBS     R0,R0,#+10
??RetFWDPower_0:
        SXTH     R0,R0
//  234 
//  235 	return (rval/10);
??RetFWDPower_1:
        SDIV     R0,R0,R1
        SXTB     R0,R0
        BX       LR               ;; return
//  236 }
//  237 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  238 INT8U AlcOperation(INT8U IsIt3G, INT8U IsItOSC)
//  239 {
AlcOperation:
        PUSH     {R4-R10,LR}
//  240 
//  241 	INT8U rval = FALSE;
//  242 	INT8S *iFWDAttn;
//  243 	INT8S *iRVSAttn;
//  244 	INT8U *iFWDSWOnOff;
//  245 	INT8S *iFwdPower;
//  246 	INT8S *iALCUpperLmt;
//  247 	INT8S *iALCOffset;
//  248 	INT8S *iRvsLmt;
//  249 
//  250 	INT8U iMinAttn;
//  251 
//  252 	if(!IsIt3G)
        LDR.W    R2,??DataTable9_2
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable13
        CBNZ.N   R0,??AlcOperation_0
//  253 	{
//  254 		iFWDAttn = &MainStatus->FwdAttn_4G;
        ADDS     R4,R2,#+2
//  255 		iRVSAttn = &MainStatus->RvsAttn_4G;
        ADDW     R5,R2,#+6
//  256 		iFWDSWOnOff = &MainStatus->TxSWOnOff_4G;
        ADDW     R12,R2,#+33
//  257 		iFwdPower = &MainStatus->PCSFwdPower;
        ADD      R0,R2,#+24
//  258 		iALCUpperLmt = &MainStatus->ALC_Phigh;
        ADDW     R9,R2,#+73
//  259 		iALCOffset = &MainStatus->ALC_Plow;
        ADDW     R10,R2,#+75
//  260 		iRvsLmt = &MainStatus->AGCLimit2;
        ADDW     R8,R2,#+56
//  261 		iMinAttn = MinAttn4G;
        LDRB     R6,[R3, #+0]
        B.N      ??AlcOperation_1
//  262 	}
//  263 	else
//  264 	{
//  265 		iFWDAttn = &MainStatus->FwdAttn_3G;
??AlcOperation_0:
        ADDW     R4,R2,#+3
//  266 		iRVSAttn = &MainStatus->RvsAttn_3G;
        ADD      R5,R2,#+8
//  267 		iFWDSWOnOff = &MainStatus->TxSWOnOff_3G;
        ADDW     R12,R2,#+81
//  268 		iFwdPower = &MainStatus->WCDMAFwdPower;
        ADDW     R0,R2,#+28
//  269 		iALCUpperLmt = &MainStatus->ALC_Whigh;
        ADDW     R9,R2,#+74
//  270 		iALCOffset = &MainStatus->ALC_Wlow;
        ADDW     R10,R2,#+76
//  271 		iRvsLmt = &MainStatus->AGCLimit4;
        ADDW     R8,R2,#+58
//  272 		iMinAttn = MinAttn3G;
        LDRB     R6,[R3, #+1]
//  273 	}
//  274 	
//  275 	{
//  276 		INT8S tmpPwr;
//  277 		INT32S	gap = 0, tmpAttn;
??AlcOperation_1:
        MOVS     R7,#+0
//  278 
//  279 		
//  280 		if(!(MainStatus->ALCOnOff & 0x01)) return FALSE;
        LDRB     R2,[R2, #+72]
        LSLS     R2,R2,#+31
        BMI.N    ??AlcOperation_2
??AlcOperation_3:
        B.N      ??AlcOperation_4
//  281 		if(!(*iFWDSWOnOff & 0x01) )	return FALSE;
??AlcOperation_2:
        LDRB     R2,[R12, #+0]
        LSLS     R2,R2,#+31
        BPL.N    ??AlcOperation_4
//  282 		if(IsItOSC) return FALSE;
        CMP      R1,#+0
        BNE.N    ??AlcOperation_4
//  283 
//  284 		tmpPwr = RetFWDPower(*iFwdPower);
        LDRSB    R0,[R0, R1]
        BL       RetFWDPower
//  285 
//  286 		if ( tmpPwr > *iALCUpperLmt )
        LDRSB    R1,[R9, #+0]
        CMP      R1,R0
        IT       LT 
        SUBLT    R7,R0,R1
//  287 		{
//  288 			gap = tmpPwr - *iALCUpperLmt;
        BLT.N    ??AlcOperation_5
//  289 
//  290 		}
//  291 		else if ( tmpPwr < (*iALCUpperLmt + *iALCOffset) )
        LDRSB    R2,[R10, #+0]
        ADDS     R3,R2,R1
        CMP      R0,R3
        ITT      LT 
        SUBLT    R0,R0,R1
        SUBLT    R7,R0,R2
//  292 		{
//  293 			gap = tmpPwr - (*iALCUpperLmt + *iALCOffset);
//  294 
//  295 		}
//  296 
//  297 		// FWD
//  298 		tmpAttn = *iFWDAttn + gap;
??AlcOperation_5:
        LDRSB    R0,[R4, #+0]
        ADDS     R0,R7,R0
//  299 		
//  300 		if(tmpAttn > ATTN_MAX30) 	tmpAttn = ATTN_MAX30;
        CMP      R0,#+31
        IT       GE 
        MOVGE    R0,#+30
//  301 		if(tmpAttn < iMinAttn) 		tmpAttn = iMinAttn;
        CMP      R0,R6
        IT       LT 
        MOVLT    R0,R6
//  302 
//  303 		*iFWDAttn = tmpAttn;
        STRB     R0,[R4, #+0]
//  304 
//  305 		// RVS
//  306 		tmpAttn = *iFWDAttn - *iRvsLmt;
        LDRSB    R0,[R4, #+0]
        LDRSB    R1,[R8, #+0]
        SUBS     R0,R0,R1
//  307 
//  308 		if(tmpAttn > ATTN_MAX30) 	tmpAttn = ATTN_MAX30;
        CMP      R0,#+31
        IT       GE 
        MOVGE    R0,#+30
//  309 		if(tmpAttn < iMinAttn) 		tmpAttn = iMinAttn;
        CMP      R0,R6
        IT       LT 
        MOVLT    R0,R6
//  310 
//  311 		*iRVSAttn = tmpAttn;
        STRB     R0,[R5, #+0]
//  312 	}
//  313 	return rval;
??AlcOperation_4:
        MOVS     R0,#+0
        POP      {R4-R10,PC}      ;; return
//  314 }
//  315 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  316 void SleepLogFunc(void)
//  317 {
SleepLogFunc:
        PUSH     {R7,LR}
//  318 	if ( !TimeOverCheck(TimerSleepOn) ) return;
        MOVS     R0,#+19
        BL       TimeOverCheck
        CBZ.N    R0,??SleepLogFunc_0
//  319 	TimerRegist(TimerSleepOn, Time1Sec);
        MOV      R1,#+1000
        MOVS     R0,#+19
        BL       TimerRegist
//  320 
//  321 	if(!MainStatus->AlarmFlag.SLP_ALM1_BIT){
        LDR.W    R0,??DataTable9_2
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+69]
        LSLS     R2,R2,#+31
        BMI.N    ??SleepLogFunc_1
//  322 		if(++tmpSleepTimeOn[0] >= 60){
        LDR.W    R2,??DataTable13_1
        LDR      R3,[R2, #+0]
        ADDS     R3,R3,#+1
        STR      R3,[R2, #+0]
        CMP      R3,#+60
        BCC.N    ??SleepLogFunc_1
//  323 			tmpSleepTimeOn[0] = 0;
        MOVS     R3,#+0
        STR      R3,[R2, #+0]
//  324 			if(MainStatus->NoSleepTime1 >= 89)  MainStatus->NoSleepTime1 = 89;
        ADDW     R1,R1,#+69
        LDRB     R2,[R1, #+10]
        CMP      R2,#+89
        ITE      CS 
        MOVCS    R2,#+89
        ADDCC    R2,R2,#+1
//  325 			else								MainStatus->NoSleepTime1++;
        STRB     R2,[R1, #+10]
//  326 		}
//  327 	}
//  328 	
//  329 	if(!MainStatus->AlarmFlag.SLP_ALM2_BIT){
??SleepLogFunc_1:
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+69]
        LSLS     R1,R1,#+30
        BMI.N    ??SleepLogFunc_0
//  330 		if(++tmpSleepTimeOn[1] >= 60){
        LDR.W    R2,??DataTable13_1
        LDR      R1,[R2, #+4]
        ADDS     R1,R1,#+1
        STR      R1,[R2, #+4]
        CMP      R1,#+60
        BCC.N    ??SleepLogFunc_0
//  331 			tmpSleepTimeOn[1] = 0;
        MOVS     R1,#+0
        STR      R1,[R2, #+4]
//  332 			if(MainStatus->NoSleepTime2 >= 89)  MainStatus->NoSleepTime2 = 89;
        ADDW     R0,R0,#+69
        LDRB     R1,[R0, #+11]
        CMP      R1,#+89
        ITE      CS 
        MOVCS    R1,#+89
        ADDCC    R1,R1,#+1
//  333 			else								MainStatus->NoSleepTime2++;
        STRB     R1,[R0, #+11]
??SleepLogFunc_0:
        POP      {R0,PC}          ;; return
//  334 		}
//  335 	}
//  336 }
//  337 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  338 void SleepCheckFunc(__SleepStr *SleepCheck, INT8U IsItOSC, INT8U IsItSD)
//  339 {
SleepCheckFunc:
        PUSH     {R4-R9,LR}
//  340 	INT8S *iRvsAttn;
//  341 	INT8U *iRvsSWOnOff;
//  342 	INT16U *iADCrawDATA;
//  343 	INT16U *iSleepTable;
//  344 	INT8U *iSleepMode;
//  345 	INT8U *iRvsSWOnOffBp;
//  346 	INT8U *iSleepTime = &MainStatus->SleepChkTime;
        LDR.W    R6,??DataTable9_2
        LDR      LR,[R6, #+0]
        ADDW     R5,LR,#+71
//  347 
//  348 	if(SleepCheck == &mSleep_4G)
        LDR.W    R4,??DataTable13_2  ;; 0x8006016
        LDR.W    R7,??DataTable8_3
        LDR.W    R3,??DataTable13_3
        CMP      R0,R3
        BNE.N    ??SleepCheckFunc_0
//  349 	{
//  350 		iRvsAttn = &MainStatus->RvsAttn_4G;
        ADDW     R8,LR,#+6
//  351 		iSleepMode = &MainStatus->SleepMode;
        ADDW     R9,LR,#+48
//  352 		iADCrawDATA = &ADC_DATA[adcRVSPWRdect1];
        ADDW     R7,R7,#+10
//  353 		iSleepTable = &vEE_TABLE->Table.SleepLimitTable1[2];
        LDR.W    R12,??DataTable13_4  ;; 0x8005f06
//  354 		iRvsSWOnOff = &MainStatus->RxSWOnOff_4G;
        ADDW     LR,LR,#+34
//  355 		iRvsSWOnOffBp = &vEE_BACK1->BackUp.SWOnOff2; 
        B.N      ??SleepCheckFunc_1
//  356 	}
//  357 	else
//  358 	{
//  359 		iRvsAttn = &MainStatus->RvsAttn_3G;
??SleepCheckFunc_0:
        ADD      R8,LR,#+8
//  360 		iSleepMode = &MainStatus->SleepMode2;
        ADDW     R9,LR,#+77
//  361 		iADCrawDATA = &ADC_DATA[adcRVSPWRdect2];
        ADDS     R7,R7,#+8
//  362 		iSleepTable = &vEE_TABLE->Table.SleepLimitTable2[2];
        LDR.W    R12,??DataTable13_5  ;; 0x8005f86
//  363 		iRvsSWOnOff = &MainStatus->RxSWOnOff_3G;
        ADDW     LR,LR,#+82
//  364 		iRvsSWOnOffBp = &vEE_BACK1->BackUp.RxSWOnOff_3G; 
        ADDW     R4,R4,#+41
//  365 	}
//  366 ////////////////////////////////////////////////////////////////////////////////
//  367 	if(IsItOSC || IsItSD ) {
??SleepCheckFunc_1:
        ORRS     R1,R2,R1
        ITT      NE 
        MOVNE    R1,#+0
        STRBNE   R1,[R0, #+1]
//  368 		SleepCheck->SleepStep = 0;
//  369 		SleepCheck->IsItSLP = FALSE;
        BNE.N    ??SleepCheckFunc_2
//  370 		
//  371 		return;
//  372 	}
//  373 
//  374 
//  375 	if(!( (*iSleepMode) & 0x01) ){
        LDRB     R1,[R9, #+0]
        LSLS     R1,R1,#+31
        BMI.N    ??SleepCheckFunc_3
//  376 
//  377 		SleepCheck->SleepStep = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
//  378 		SleepCheck->IsItSLP = FALSE;
        STRB     R1,[R0, #+2]
//  379 
//  380 		if(SleepCheck == &mSleep_4G) MainStatus->AlarmFlag.SLP_ALM1_BIT = RESET;
        LDR      R1,[R6, #+0]
        CMP      R0,R3
        LDRB     R2,[R1, #+69]
        ITE      EQ 
        ANDEQ    R2,R2,#0xFE
        ANDNE    R2,R2,#0xFD
//  381 		else						MainStatus->AlarmFlag.SLP_ALM2_BIT = RESET;
        STRB     R2,[R1, #+69]
//  382 
//  383 		if(!SleepCheck->SleepRecovery)
        LDRB     R1,[R0, #+3]
        CBNZ.N   R1,??SleepCheckFunc_4
//  384 		{
//  385 			*iRvsSWOnOff = *iRvsSWOnOffBp;
        LDRB     R1,[R4, #+0]
        STRB     R1,[LR, #+0]
//  386 		}
//  387 		SleepCheck->SleepRecovery = TRUE;
??SleepCheckFunc_4:
        MOVS     R1,#+1
        STRB     R1,[R0, #+3]
//  388 		return;
        B.N      ??SleepCheckFunc_5
//  389 	}
//  390 	SleepCheck->SleepRecovery = FALSE;
??SleepCheckFunc_3:
        MOVS     R1,#+0
        STRB     R1,[R0, #+3]
//  391 
//  392 	switch(SleepCheck->SleepStep)
        LDRB     R1,[R0, #+1]
        CBZ.N    R1,??SleepCheckFunc_6
        CMP      R1,#+2
        BEQ.N    ??SleepCheckFunc_7
        BCC.N    ??SleepCheckFunc_8
        B.N      ??SleepCheckFunc_5
//  393 	{
//  394 		case 0:
//  395 		{
//  396 			if(((*iADCrawDATA) >> 2) > (iSleepTable[ATTN_MAX30 - (*iRvsAttn)] + AWAKE_LIMIT))
??SleepCheckFunc_6:
        LDRSB    R1,[R8, R1]
        RSBS     R1,R1,#+0
        ADD      R1,R12,R1, LSL #+1
        LDRH     R1,[R1, #+60]
        ADDS     R1,R1,#+3
        LDRH     R2,[R7, #+0]
        CMP      R1,R2, LSR #+2
        BGE.N    ??SleepCheckFunc_9
//  397 			{
//  398 				SleepCheck->SleepStep = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
//  399 				SleepCheck->IsItSLP = FALSE;
        STRB     R1,[R0, #+2]
//  400 				
//  401 				if(SleepCheck == &mSleep_4G) MainStatus->AlarmFlag.SLP_ALM1_BIT = RESET;
        LDR      R1,[R6, #+0]
        CMP      R0,R3
        LDRB     R0,[R1, #+69]
        BNE.N    ??SleepCheckFunc_10
        AND      R0,R0,#0xFE
??SleepCheckFunc_11:
        STRB     R0,[R1, #+69]
        B.N      ??SleepCheckFunc_5
//  402 				else						MainStatus->AlarmFlag.SLP_ALM2_BIT = RESET;
??SleepCheckFunc_10:
        AND      R0,R0,#0xFD
        B.N      ??SleepCheckFunc_11
//  403 			}
//  404 			else
//  405 			{
//  406 				SleepCheck->SleepStep = 1;
??SleepCheckFunc_9:
        MOVS     R1,#+1
        STRB     R1,[R0, #+1]
//  407 				SleepCheck->SleepTimeCnt = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
        B.N      ??SleepCheckFunc_5
//  408 			}
//  409 		}
//  410 		break;
//  411 
//  412 		case 1:
//  413 			if( ((*iADCrawDATA) >> 2) > (iSleepTable[ATTN_MAX30 - (*iRvsAttn)]+ AWAKE_LIMIT)) SleepCheck->SleepStep = 1;
??SleepCheckFunc_8:
        LDRSB    R1,[R8, #+0]
        RSBS     R1,R1,#+0
        ADD      R1,R12,R1, LSL #+1
        LDRH     R1,[R1, #+60]
        ADDS     R1,R1,#+3
        LDRH     R2,[R7, #+0]
        CMP      R1,R2, LSR #+2
        ITT      LT 
        MOVLT    R1,#+1
        STRBLT   R1,[R0, #+1]
//  414 
//  415 			if(++SleepCheck->SleepTimeCnt >= (*iSleepTime)*2L ) SleepCheck->SleepStep = 2;
        LDRB     R1,[R0, #+0]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+0]
        UXTB     R1,R1
        LDRB     R2,[R5, #+0]
        CMP      R1,R2, LSL #+1
        BLT.N    ??SleepCheckFunc_5
        MOVS     R1,#+2
        STRB     R1,[R0, #+1]
        B.N      ??SleepCheckFunc_5
//  416 		break;
//  417 
//  418 		case 2:
//  419 			if(SleepCheck == &mSleep_4G) MainStatus->AlarmFlag.SLP_ALM1_BIT = SET;
??SleepCheckFunc_7:
        LDR      R1,[R6, #+0]
        LDRB     R2,[R1, #+69]
        CMP      R0,R3
        ITE      EQ 
        ORREQ    R2,R2,#0x1
        ORRNE    R2,R2,#0x2
//  420 			else						MainStatus->AlarmFlag.SLP_ALM2_BIT = SET;
        STRB     R2,[R1, #+69]
//  421 
//  422 			*iRvsSWOnOff = '0';
        MOVS     R1,#+48
        STRB     R1,[LR, #+0]
//  423 
//  424 			if( ((*iADCrawDATA) >> 2) > (iSleepTable[ATTN_MAX30 - (*iRvsAttn)] + AWAKE_LIMIT))
        LDRSB    R1,[R8, #+0]
        RSBS     R1,R1,#+0
        ADD      R1,R12,R1, LSL #+1
        LDRH     R1,[R1, #+60]
        ADDS     R1,R1,#+3
        LDRH     R2,[R7, #+0]
        CMP      R1,R2, LSR #+2
        BGE.N    ??SleepCheckFunc_12
//  425 			{
//  426 				SleepCheck->SleepStep = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
//  427 
//  428 				*iRvsSWOnOff = *iRvsSWOnOffBp;
        LDRB     R1,[R4, #+0]
        STRB     R1,[LR, #+0]
//  429 			}
//  430 			SleepCheck->IsItSLP = TRUE;
??SleepCheckFunc_12:
        MOVS     R1,#+1
??SleepCheckFunc_2:
        STRB     R1,[R0, #+2]
//  431 		break;
//  432 	}
//  433 }
??SleepCheckFunc_5:
        POP      {R4-R9,PC}       ;; return
//  434 
//  435 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  436 INT8U ShutDnCheckFunc(__ShutDnStr *SDCheck, INT8U IsItOSC, INT8U IsItSLP)
//  437 {
ShutDnCheckFunc:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+12
        MOV      R4,R0
//  438 	// FWD LimitOperation
//  439 	INT8U rval = 0;
//  440 
//  441 	INT8S *iALCOnOff = &MainStatus->ALCOnOff;
        LDR.W    R5,??DataTable9_2
        LDR      LR,[R5, #+0]
        ADDW     R0,LR,#+72
//  442 	INT8U *iAGCOnOff = &MainStatus->AGCOnOff;
        ADDW     R3,LR,#+40
//  443 	INT8S *iFwdAttn;
//  444 	INT8S *iRvsAttn;
//  445 	INT8S *FwdPower;
//  446 	INT8S *RvsPower;
//  447 	INT8S *FwdUpperLmt;
//  448 	INT8S *RvsUpperLmt;
//  449 	INT8U *iFwdSWOnOff;
//  450 	INT8U *iRvsSWOnOff; 
//  451 
//  452 	if(SDCheck == &mSDCheck_4G)
        LDR.W    R11,??DataTable13_6
        CMP      R4,R11
        BNE.N    ??ShutDnCheckFunc_0
//  453 	{
//  454 		iFwdAttn = &MainStatus->FwdAttn_4G;
        ADD      R7,LR,#+2
//  455 		iRvsAttn = &MainStatus->RvsAttn_4G;
        ADDW     R8,LR,#+6
        STR      R8,[SP, #+4]
//  456 		FwdPower = &MainStatus->PCSFwdPower;
        ADD      R12,LR,#+24
//  457 		RvsPower = &MainStatus->PCSRvsPower;
        ADDW     R8,LR,#+25
//  458 		FwdUpperLmt = &MainStatus->ALCLimit1;
        ADDW     R9,LR,#+51
//  459 		RvsUpperLmt = &MainStatus->ALCLimit3;
        ADDW     R10,LR,#+53
//  460 		iFwdSWOnOff = &MainStatus->TxSWOnOff_4G;
        ADDW     R6,LR,#+33
        STR      R6,[SP, #+0]
//  461 		iRvsSWOnOff = &MainStatus->RxSWOnOff_4G;
        ADDW     R6,LR,#+34
        B.N      ??ShutDnCheckFunc_1
//  462 	}
//  463 	else
//  464 	{
//  465 		iFwdAttn = &MainStatus->FwdAttn_3G;
??ShutDnCheckFunc_0:
        ADDW     R7,LR,#+3
//  466 		iRvsAttn = &MainStatus->RvsAttn_3G;
        ADD      R6,LR,#+8
        STR      R6,[SP, #+4]
//  467 		FwdPower = &MainStatus->WCDMAFwdPower;
        ADDW     R12,LR,#+28
//  468 		RvsPower = &MainStatus->WCDMARvsPower;
        ADDW     R8,LR,#+29
//  469 		FwdUpperLmt = &MainStatus->ALCLimit2;
        ADDW     R9,LR,#+52
//  470 		RvsUpperLmt = &MainStatus->ALCLimit4;
        ADDW     R10,LR,#+54
//  471 		iFwdSWOnOff = &MainStatus->TxSWOnOff_3G;
        ADDW     R6,LR,#+81
        STR      R6,[SP, #+0]
//  472 		iRvsSWOnOff = &MainStatus->RxSWOnOff_3G;
        ADDW     R6,LR,#+82
//  473 	}
//  474 ////////////////////////////////////////////////////////////////////////////////
//  475 	if(IsItOSC || IsItSLP)
??ShutDnCheckFunc_1:
        ORRS     R2,R2,R1
        BEQ.N    ??ShutDnCheckFunc_2
//  476     {
//  477     	if(IsItOSC) SDCheck->FwdSDStep = 0;
        CBZ.N    R1,??ShutDnCheckFunc_3
        MOVS     R1,#+0
        STRB     R1,[R4, #+1]
//  478 		SDCheck->RvsSDStep = 0;
??ShutDnCheckFunc_3:
        MOVS     R1,#+0
        STRB     R1,[R4, #+0]
??ShutDnCheckFunc_2:
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+43]
        LSLS     R1,R1,#+31
        BPL.W    ??ShutDnCheckFunc_4
//  479     }
//  480 
//  481 	if((MainStatus->SDNOnOff & 0x01) )	//
//  482 	{
//  483 		INT8U tmp = ((*iALCOnOff) & 0x01) | ((*iAGCOnOff) & 0x01);
//  484 
//  485 		if( (tmp && (*iFwdAttn == ATTN_MAX30)) || !tmp)
        LDRSB    R0,[R0, #+0]
        LDRB     R1,[R3, #+0]
        ORRS     R0,R1,R0
        LSLS     R0,R0,#+31
        BPL.N    ??ShutDnCheckFunc_5
        LDRSB    R0,[R7, #+0]
        CMP      R0,#+30
        BNE.N    ??ShutDnCheckFunc_6
//  486 		{
//  487 			switch(SDCheck->FwdSDStep)
??ShutDnCheckFunc_5:
        LDRB     R0,[R4, #+1]
        CBZ.N    R0,??ShutDnCheckFunc_7
        CMP      R0,#+2
        BEQ.N    ??ShutDnCheckFunc_8
        BCC.N    ??ShutDnCheckFunc_9
        B.N      ??ShutDnCheckFunc_10
//  488 			{
//  489 				case 0:
//  490 					if( RetFWDPower(*FwdPower) > *FwdUpperLmt) SDCheck->FwdSDStep = 1;
??ShutDnCheckFunc_7:
        LDRSB    R0,[R12, #+0]
        BL       RetFWDPower
        LDRSB    R1,[R9, #+0]
        CMP      R1,R0
        IT       LT 
        MOVLT    R0,#+1
        BLT.N    ??ShutDnCheckFunc_11
//  491 					else {
//  492 						if(SDCheck == &mSDCheck_4G)	MainStatus->AlarmFlag.OverPCSFwdPower = RESET;
        LDR      R0,[R5, #+0]
        ADDW     R0,R0,#+43
        CMP      R4,R11
        LDRB     R1,[R0, #+24]
        BNE.N    ??ShutDnCheckFunc_12
        AND      R1,R1,#0xFE
??ShutDnCheckFunc_13:
        STRB     R1,[R0, #+24]
        B.N      ??ShutDnCheckFunc_14
//  493 						else						MainStatus->AlarmFlag.OverWCDMAFwdPower = RESET;
??ShutDnCheckFunc_12:
        AND      R1,R1,#0xFB
        B.N      ??ShutDnCheckFunc_13
//  494 					}
//  495 				break;
//  496 
//  497 				case 1:
//  498 					if( RetFWDPower(*FwdPower) > *FwdUpperLmt) 	SDCheck->FwdSDStep = 2;
??ShutDnCheckFunc_9:
        LDRSB    R0,[R12, #+0]
        BL       RetFWDPower
        LDRSB    R1,[R9, #+0]
        CMP      R1,R0
        ITE      GE 
        MOVGE    R0,#+0
        MOVLT    R0,#+2
        B.N      ??ShutDnCheckFunc_11
//  499 					else 										SDCheck->FwdSDStep = 0;
//  500 				break;
//  501 
//  502 				case 2:
//  503 					if( RetFWDPower(*FwdPower) > *FwdUpperLmt){
??ShutDnCheckFunc_8:
        LDRSB    R0,[R12, #+0]
        BL       RetFWDPower
        LDRSB    R1,[R9, #+0]
        CMP      R1,R0
        BGE.N    ??ShutDnCheckFunc_6
//  504 
//  505 						
//  506 						*iFwdAttn = ATTN_MAX30;
        MOVS     R0,#+30
        STRB     R0,[R7, #+0]
//  507 						*iRvsAttn = ATTN_MAX30;
        LDR      R0,[SP, #+4]
        MOVS     R1,#+30
        STRB     R1,[R0, #+0]
//  508 						*iFwdSWOnOff = '0';
        LDR      R0,[SP, #+0]
        MOVS     R1,#+48
        STRB     R1,[R0, #+0]
//  509 						*iRvsSWOnOff = '0'; // LMJ110803
        STRB     R1,[R6, #+0]
//  510 						
//  511 						
//  512 						if(SDCheck == &mSDCheck_4G)	MainStatus->AlarmFlag.OverPCSFwdPower = SET;
        LDR      R0,[R5, #+0]
        LDRB     R1,[R0, #+67]
        CMP      R4,R11
        ITE      EQ 
        ORREQ    R1,R1,#0x1
        ORRNE    R1,R1,#0x4
//  513 						else						MainStatus->AlarmFlag.OverWCDMAFwdPower = SET;
        STRB     R1,[R0, #+67]
//  514 					
//  515 						SDCheck->FwdSDStep = 3;
        MOVS     R0,#+3
        B.N      ??ShutDnCheckFunc_11
//  516 					}
//  517 					else{
//  518 						SDCheck->FwdSDStep = 0;
//  519 					}
//  520 				break;
//  521 
//  522 				default:
//  523 					SDCheck->IsItSHD = TRUE;
??ShutDnCheckFunc_10:
        MOVS     R0,#+1
        STRB     R0,[R4, #+2]
        B.N      ??ShutDnCheckFunc_14
//  524 				break;
//  525 			}
//  526 		}
//  527 		else SDCheck->FwdSDStep = 0;
??ShutDnCheckFunc_6:
        MOVS     R0,#+0
??ShutDnCheckFunc_11:
        STRB     R0,[R4, #+1]
//  528 
//  529 		
//  530 		switch(SDCheck->RvsSDStep)
??ShutDnCheckFunc_14:
        LDRB     R0,[R4, #+0]
        CBZ.N    R0,??ShutDnCheckFunc_15
        CMP      R0,#+2
        BEQ.N    ??ShutDnCheckFunc_16
        BCC.N    ??ShutDnCheckFunc_17
        B.N      ??ShutDnCheckFunc_18
//  531 		{
//  532 			case 0:
//  533 				if(*RvsPower > *RvsUpperLmt) SDCheck->RvsSDStep = 1;
??ShutDnCheckFunc_15:
        LDRSB    R0,[R10, #+0]
        LDRSB    R1,[R8, #+0]
        CMP      R0,R1
        BGE.N    ??ShutDnCheckFunc_19
        MOVS     R0,#+1
??ShutDnCheckFunc_20:
        STRB     R0,[R4, #+0]
        B.N      ??ShutDnCheckFunc_21
//  534 				else{
//  535 					if(SDCheck == &mSDCheck_4G)	MainStatus->AlarmFlag.OverPCSRvsPower = RESET;
??ShutDnCheckFunc_19:
        LDR      R0,[R5, #+0]
        CMP      R4,R11
        LDRB     R1,[R0, #+67]
        BNE.N    ??ShutDnCheckFunc_22
        AND      R1,R1,#0xFD
??ShutDnCheckFunc_23:
        STRB     R1,[R0, #+67]
        B.N      ??ShutDnCheckFunc_21
//  536 					else						MainStatus->AlarmFlag.OverWCDMARvsPower = RESET;
??ShutDnCheckFunc_22:
        AND      R1,R1,#0xF7
        B.N      ??ShutDnCheckFunc_23
//  537 				}
//  538 			break;
//  539 			
//  540 			case 1:
//  541 				if(*RvsPower > *RvsUpperLmt) SDCheck->RvsSDStep = 2;
??ShutDnCheckFunc_17:
        LDRSB    R0,[R10, #+0]
        LDRSB    R1,[R8, #+0]
        CMP      R0,R1
        IT       LT 
        MOVLT    R0,#+2
        BLT.N    ??ShutDnCheckFunc_20
//  542 				else						 SDCheck->RvsSDStep = 0;
??ShutDnCheckFunc_24:
        MOVS     R0,#+0
        B.N      ??ShutDnCheckFunc_20
//  543 			break;
//  544 
//  545 			case 2:
//  546 				if(*RvsPower > *RvsUpperLmt){
??ShutDnCheckFunc_16:
        LDRSB    R0,[R10, #+0]
        LDRSB    R1,[R8, #+0]
        CMP      R0,R1
        BGE.N    ??ShutDnCheckFunc_24
//  547 			
//  548 					
//  549 					*iFwdAttn = ATTN_MAX30;
        MOVS     R0,#+30
        STRB     R0,[R7, #+0]
//  550 					*iRvsAttn = ATTN_MAX30;
        LDR      R0,[SP, #+4]
        MOVS     R1,#+30
        STRB     R1,[R0, #+0]
//  551 					*iFwdSWOnOff = '0';
        LDR      R0,[SP, #+0]
        MOVS     R1,#+48
        STRB     R1,[R0, #+0]
//  552 					*iRvsSWOnOff = '0'; // LMJ110803
        STRB     R1,[R6, #+0]
//  553 					
//  554 					
//  555 					if(SDCheck == &mSDCheck_4G)	MainStatus->AlarmFlag.OverPCSRvsPower = SET;
        LDR      R0,[R5, #+0]
        LDRB     R1,[R0, #+67]
        CMP      R4,R11
        ITE      EQ 
        ORREQ    R1,R1,#0x2
        ORRNE    R1,R1,#0x8
//  556 					else						MainStatus->AlarmFlag.OverWCDMARvsPower = SET;
        STRB     R1,[R0, #+67]
//  557 				
//  558 					SDCheck->RvsSDStep = 3;
        MOVS     R0,#+3
        B.N      ??ShutDnCheckFunc_20
//  559 				}
//  560 				else{
//  561 					SDCheck->RvsSDStep = 0;
//  562 				}
//  563 			break;
//  564 
//  565 			default:
//  566 				SDCheck->IsItSHD = TRUE;
??ShutDnCheckFunc_18:
        MOVS     R0,#+1
        B.N      ??ShutDnCheckFunc_25
//  567 			break;
//  568 		
//  569 		}
//  570 	////////////////////////////////////////////////////////////////////////////
//  571 	}
//  572 	else
//  573 	{
//  574 		SDCheck->FwdSDStep = 0;
??ShutDnCheckFunc_4:
        MOVS     R0,#+0
        STRB     R0,[R4, #+1]
//  575 		SDCheck->RvsSDStep = 0;
        STRB     R0,[R4, #+0]
//  576 ////////////////////////////////////////////////////////////////////////////////
//  577 
//  578 		if(SDCheck == &mSDCheck_4G)	MainStatus->AlarmFlag.OverPCSRvsPower = RESET;
        LDR      R0,[R5, #+0]
        CMP      R4,R11
        LDRB     R1,[R0, #+67]
        BNE.N    ??ShutDnCheckFunc_26
        AND      R1,R1,#0xFD
        STRB     R1,[R0, #+67]
//  579 		else						MainStatus->AlarmFlag.OverWCDMARvsPower = RESET;
//  580 
//  581 		if(SDCheck == &mSDCheck_4G)	MainStatus->AlarmFlag.OverPCSFwdPower = RESET;
        LDR      R0,[R5, #+0]
        LDRB     R1,[R0, #+67]
        AND      R1,R1,#0xFE
        B.N      ??ShutDnCheckFunc_27
??ShutDnCheckFunc_26:
        AND      R1,R1,#0xF7
        STRB     R1,[R0, #+67]
//  582 		else						MainStatus->AlarmFlag.OverWCDMAFwdPower = RESET;
        LDR      R0,[R5, #+0]
        LDRB     R1,[R0, #+67]
        AND      R1,R1,#0xFB
??ShutDnCheckFunc_27:
        STRB     R1,[R0, #+67]
//  583 
//  584 		SDCheck->IsItSHD = FALSE;
        MOVS     R0,#+0
??ShutDnCheckFunc_25:
        STRB     R0,[R4, #+2]
//  585 	}
//  586 	return rval;
??ShutDnCheckFunc_21:
        MOVS     R0,#+0
        ADD      SP,SP,#+12
        POP      {R4-R11,PC}      ;; return
//  587 }
//  588 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  589 INT8U IsolationCheckFunc(__IsoStr *ISOCheck)
//  590 {
IsolationCheckFunc:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+52
        MOV      R4,R0
//  591 	INT8S *iFWDAttn;
//  592 	INT8S *iRVSAttn;
//  593 	INT8S *iRvsAttnISO;
//  594 	INT8S *iIsolationLevel;
//  595 
//  596 	INT8S *iFWDAttnBp;
//  597 	INT8S *iRvsAttnBp;
//  598 	INT8S *iRvsAttnISOBp;
//  599 	INT8U *iFwdSWOnOffBp;
//  600 	INT8U *iRvsSWOnOffBp;
//  601 	
//  602 	INT8S *iRvsPower;
//  603 
//  604 	INT8S *iOSCLimit;
//  605 
//  606 	INT8U *iFwdSWOnOff;
//  607 	INT8U *iRvsSWOnOff; 
//  608 
//  609 	INT16U *iADCrawDATA;
//  610 	INT16U *iSleepTable;
//  611 	INT8U *iMinAttn;
//  612 
//  613 	INT8S *iALCOnOff;
//  614 	INT8U *iAGCOnOff;
//  615 	INT8U *iISOOnOff;
//  616 	INT8U  tmpoffset;
//  617 	INT16U tmpTimer;
//  618 
//  619 	INT8U *RstCnt;
//  620 	INT8S tmpGainOffset = 0;
//  621 	
//  622 ///////////////////////////////////////////////////////////////////////////////////////////////////////////
//  623 //	BUFFER INIT!!
//  624 	if(ISOCheck == &mISOCheck_4G)
        LDR.W    R5,??DataTable9_2
        LDR      R0,[R5, #+0]
        LDR.W    R1,??DataTable13_7  ;; 0x8006006
        LDR.W    R11,??DataTable13_8
        LDR.W    R10,??DataTable13_5  ;; 0x8005f86
        LDR.W    R9,??DataTable8_3
        LDR.W    R2,??DataTable13_9
        CMP      R4,R2
        BNE.N    ??IsolationCheckFunc_0
//  625 	{
//  626 		iFWDAttn = &MainStatus->FwdAttn_4G;
        ADDS     R2,R0,#+2
//  627 		iRVSAttn = &MainStatus->RvsAttn_4G;
        ADDW     R3,R0,#+6
//  628 		iRvsAttnISO = &MainStatus->RvsAttnISO_4G;
        ADDW     R7,R0,#+7
//  629 		iIsolationLevel = &MainStatus->IsolationLevel1;
        ADDW     R12,R0,#+31
//  630 
//  631 		iRvsPower = &MainStatus->PCSRvsPower;
        ADDW     R8,R0,#+25
        STR      R8,[SP, #+44]
//  632 		iOSCLimit = &MainStatus->OSCLimit1;
        ADDW     R8,R0,#+59
        STR      R8,[SP, #+40]
//  633 
//  634 		iFwdSWOnOff = &MainStatus->TxSWOnOff_4G;
        ADDW     LR,R0,#+33
//  635 		iRvsSWOnOff = &MainStatus->RxSWOnOff_4G; 
        ADDW     R8,R0,#+34
//  636 		iADCrawDATA = &ADC_DATA[adcRVSPWRdect1];
        ADDW     R6,R9,#+10
        STR      R6,[SP, #+8]
//  637 		iSleepTable = &vEE_TABLE->Table.SleepLimitTable1[2];
        LDR.W    R6,??DataTable13_4  ;; 0x8005f06
        STR      R6,[SP, #+4]
//  638 		iMinAttn = &MinAttn4G;
        LDR.W    R9,??DataTable12
//  639 
//  640 		iFWDAttnBp = &vEE_BACK1->BackUp.FwdAttn_4G;
        ADDW     R6,R10,#+126
        STR      R6,[SP, #+36]
//  641 		iRvsAttnBp = &vEE_BACK1->BackUp.RvsAttn_4G;
        STR      R1,[SP, #+32]
//  642 		iRvsAttnISOBp = &vEE_BACK1->BackUp.RvsAttnISO_4G;
        ADD      R10,R1,#+1
//  643 		iFwdSWOnOffBp = &vEE_BACK1->BackUp.SWOnOff1;
        ADDW     R6,R1,#+15
        STR      R6,[SP, #+28]
//  644 		iRvsSWOnOffBp = &vEE_BACK1->BackUp.SWOnOff2; 
        ADDS     R1,R1,#+16
        STR      R1,[SP, #+24]
//  645 
//  646 		iALCOnOff = &MainStatus->ALCOnOff;
        ADDW     R6,R0,#+72
        STR      R6,[SP, #+20]
//  647 		iAGCOnOff = &MainStatus->AGCOnOff;
        ADDW     R6,R0,#+40
        STR      R6,[SP, #+16]
//  648 		iISOOnOff = &MainStatus->ISOOnOff1;
        ADDW     R1,R0,#+41
        STR      R1,[SP, #+12]
//  649 
//  650 		RstCnt = &rambackup[ResetCountBp1];
        LDR      R0,[R11, #+0]
        ADDS     R1,R0,#+2
//  651 		tmpTimer = TimerISO2G;
        MOVS     R0,#+10
        STR      R0,[SP, #+0]
//  652 		tmpoffset = SleepTempOffset*4;
        LDR.W    R0,??DataTable13_10
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        B.N      ??IsolationCheckFunc_1
//  653 	}
//  654 	else // 3G
//  655 	{
//  656 		iFWDAttn = &MainStatus->FwdAttn_3G;
??IsolationCheckFunc_0:
        ADDW     R2,R0,#+3
//  657 		iRVSAttn = &MainStatus->RvsAttn_3G;
        ADD      R3,R0,#+8
//  658 		iRvsAttnISO = &MainStatus->RvsAttnISO_3G;
        ADDW     R7,R0,#+9
//  659 		iIsolationLevel = &MainStatus->IsolationLevel2;
        ADD      R12,R0,#+32
//  660 
//  661 		iRvsPower = &MainStatus->WCDMARvsPower;
        ADDW     R8,R0,#+29
        STR      R8,[SP, #+44]
//  662 		iOSCLimit = &MainStatus->OSCLimit2;
        ADDW     R8,R0,#+60
        STR      R8,[SP, #+40]
//  663 
//  664 		iFwdSWOnOff = &MainStatus->TxSWOnOff_3G;
        ADDW     LR,R0,#+81
//  665 		iRvsSWOnOff = &MainStatus->RxSWOnOff_3G; 
        ADDW     R8,R0,#+82
//  666 		iADCrawDATA = &ADC_DATA[adcRVSPWRdect2];
        ADD      R6,R9,#+8
        STR      R6,[SP, #+8]
//  667 		iSleepTable = &vEE_TABLE->Table.SleepLimitTable2[2];
        STR      R10,[SP, #+4]
//  668 		iMinAttn = &MinAttn3G;
        LDR.W    R9,??DataTable13_11
//  669 
//  670 		iFWDAttnBp = &vEE_BACK1->BackUp.FwdAttn_3G;
        ADDW     R6,R10,#+127
        STR      R6,[SP, #+36]
//  671 		iRvsAttnBp = &vEE_BACK1->BackUp.RvsAttn_3G;
        ADDS     R6,R1,#+2
        STR      R6,[SP, #+32]
//  672 		iFwdSWOnOffBp = &vEE_BACK1->BackUp.TxSWOnOff_3G;
        ADDW     R6,R1,#+56
        STR      R6,[SP, #+28]
//  673 		iRvsAttnISOBp = &vEE_BACK1->BackUp.RvsAttnISO_3G;
        ADDW     R10,R1,#+3
//  674 		iRvsSWOnOffBp = &vEE_BACK1->BackUp.RxSWOnOff_3G; 
        ADDW     R6,R1,#+57
        STR      R6,[SP, #+24]
//  675 
//  676 		iALCOnOff = &MainStatus->ALCOnOff;
        ADDW     R6,R0,#+72
        STR      R6,[SP, #+20]
//  677 		iAGCOnOff = &MainStatus->AGCOnOff;
        ADDW     R6,R0,#+40
        STR      R6,[SP, #+16]
//  678 		iISOOnOff = &MainStatus->ISOOnOff2;
        ADDW     R1,R0,#+42
        STR      R1,[SP, #+12]
//  679 
//  680 		RstCnt = &rambackup[ResetCountBp1];
        LDR      R0,[R11, #+0]
        ADDS     R1,R0,#+2
//  681 		tmpTimer = TimerISO3G;
        MOVS     R0,#+11
        STR      R0,[SP, #+0]
//  682 		tmpoffset = SleepTempOffset*2;
        LDR.W    R0,??DataTable13_10
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
//  683 	}
//  684 
//  685 	switch(ISOCheck->ISOStep)
??IsolationCheckFunc_1:
        LDRB     R6,[R4, #+4]
        CBZ.N    R6,??IsolationCheckFunc_2
        CMP      R6,#+1
        BEQ.N    ??IsolationCheckFunc_3
        CMP      R6,#+5
        BEQ.N    ??IsolationCheckFunc_4
        CMP      R6,#+10
        BEQ.N    ??IsolationCheckFunc_5
        CMP      R6,#+40
        BEQ.W    ??IsolationCheckFunc_6
        CMP      R6,#+50
        BEQ.W    ??IsolationCheckFunc_7
        CMP      R6,#+60
        BEQ.W    ??IsolationCheckFunc_8
        B.N      ??IsolationCheckFunc_9
//  686 	{
//  687 		case __ISOINIT:
//  688 			*iFWDAttn = ATTN_MAX30;
??IsolationCheckFunc_2:
        MOVS     R0,#+30
        STRB     R0,[R2, #+0]
//  689 			*iRVSAttn = ATTN_MAX30;
        STRB     R0,[R3, #+0]
//  690 			*iRvsAttnISO = *iRvsAttnISOBp;
        LDRB     R0,[R10, #+0]
        STRB     R0,[R7, #+0]
//  691 
//  692 			*iFwdSWOnOff = '0';
        MOVS     R0,#+48
        STRB     R0,[LR, #+0]
//  693 			*iRvsSWOnOff = '0';	
        STRB     R0,[R8, #+0]
//  694 
//  695 			////////////////////////////////////////////////////////////////////
//  696 			ISOCheck->ISO_ALM_BIT = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  697 			ISOCheck->ISO_RALM_BIT = 0;
        STRB     R0,[R4, #+1]
//  698 			ISOCheck->ISO_WAITING = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+2]
//  699 			ISOCheck->ISOStep++;
        LDRB     R0,[R4, #+4]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+4]
//  700 			ISOCheck->ISOFail = FALSE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+6]
//  701 			TimerRegist(tmpTimer, Time10mSec*30L);
        MOV      R1,#+300
??IsolationCheckFunc_10:
        LDR      R0,[SP, #+0]
        UXTB     R0,R0
        BL       TimerRegist
        B.N      ??IsolationCheckFunc_9
//  702 
//  703 		break;
//  704 
//  705 		case __ISOINIT + 1:
//  706 		{
//  707 			if ( ((*iADCrawDATA) >> 2) <= (iSleepTable[ATTN_MAX30 - (*iRVSAttn)] + AWAKE_LIMIT + tmpoffset))
??IsolationCheckFunc_3:
        LDRSB    R1,[R3, #+0]
        RSBS     R1,R1,#+0
        LDR      R2,[SP, #+4]
        ADD      R1,R2,R1, LSL #+1
        LDRH     R1,[R1, #+60]
        ADDS     R0,R1,R0, LSR #+24
        ADDS     R0,R0,#+3
        LDR      R1,[SP, #+8]
        LDRH     R1,[R1, #+0]
        CMP      R0,R1, LSR #+2
        BLT.W    ??IsolationCheckFunc_9
//  708 			{
//  709 				ISOCheck->ISOStep = __ISORXPWR;
        MOVS     R0,#+5
        B.N      ??IsolationCheckFunc_11
//  710 			}
//  711 		}
//  712 		break;
//  713 		//////////////////////////////////////////////////////////////////////////////////////
//  714 		case __ISORXPWR:
//  715 		{
//  716 			if ( ((*iADCrawDATA) >> 2) <= (iSleepTable[ATTN_MAX30 - (*iRVSAttn)] + AWAKE_LIMIT + tmpoffset))
??IsolationCheckFunc_4:
        LDRSB    R1,[R3, #+0]
        RSBS     R1,R1,#+0
        LDR      R6,[SP, #+4]
        ADD      R1,R6,R1, LSL #+1
        LDRH     R1,[R1, #+60]
        ADDS     R0,R1,R0, LSR #+24
        ADDS     R0,R0,#+3
        LDR      R1,[SP, #+8]
        LDRH     R1,[R1, #+0]
        CMP      R0,R1, LSR #+2
        BLT.N    ??IsolationCheckFunc_12
//  717 			// 복원해야함..
//  718 			{
//  719 				*iIsolationLevel = (ISO_START_GAIN + tmpGainOffset);
        MOVS     R0,#+69
        STRB     R0,[R12, #+0]
//  720 				*iFWDAttn = ATTN_MAX30;
        MOVS     R0,#+30
        STRB     R0,[R2, #+0]
//  721 	
//  722 				*iRVSAttn = (ISO_MAX_GAIN + tmpGainOffset)  - (ISO_START_GAIN + tmpGainOffset) - *iRvsAttnISOBp;		// 58. 48
        LDRB     R0,[R10, #+0]
        RSB      R0,R0,#+33
        STRB     R0,[R3, #+0]
//  723 				*iRvsAttnISO = *iRvsAttnISOBp;
        LDRB     R0,[R10, #+0]
        STRB     R0,[R7, #+0]
//  724 
//  725 				////////////////////////////////////////////////////////////////
//  726 
//  727 				*iFwdSWOnOff = '0';
        MOVS     R0,#+48
        STRB     R0,[LR, #+0]
//  728 				*iRvsSWOnOff = '1'; 
        MOVS     R0,#+49
        STRB     R0,[R8, #+0]
//  729 				//*iRvsSWOnOff = *iRvsSWOnOffBp;	// Rvs Path On!!
//  730 				ISOCheck->ISOStep = __ISOCHECK;
        MOVS     R0,#+10
        STRB     R0,[R4, #+4]
//  731 
//  732 				TimerRegist(tmpTimer, Time10mSec*70L);
        MOV      R1,#+700
        B.N      ??IsolationCheckFunc_10
//  733 			}
//  734 			else
//  735 			{
//  736 				ISOCheck->ISOStep = (__ISOINIT + 1);
??IsolationCheckFunc_12:
        MOVS     R0,#+1
        B.N      ??IsolationCheckFunc_11
//  737 				
//  738 			}
//  739 		}
//  740 		break;
//  741 
//  742 		case __ISOCHECK:
//  743 
//  744 			ISOCheck->PowerPre = *iRvsPower;
??IsolationCheckFunc_5:
        LDR      R0,[SP, #+44]
        LDRSB    R0,[R0, #+0]
        STRB     R0,[R4, #+3]
//  745 			if(ISOCheck->PowerPre > (*iOSCLimit) )
        LDR      R2,[SP, #+40]
        LDRSB    R2,[R2, #+0]
        CMP      R2,R0
        BGE.N    ??IsolationCheckFunc_13
//  746 			{
//  747 				if( (*iIsolationLevel) < (ISO_LMT_GAIN + tmpGainOffset) )
        LDRSB    R0,[R12, #+0]
        CMP      R0,#+70
        BGE.N    ??IsolationCheckFunc_14
//  748 				{
//  749 					// shutdown or Reset!!
//  750 					*RstCnt = *RstCnt + 1;
        LDRB     R0,[R1, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R1, #+0]
//  751 					if(*RstCnt > 3){
        UXTB     R0,R0
        CMP      R0,#+4
        BCC.N    ??IsolationCheckFunc_15
//  752 						// SHUTDOWNCASE !!(완전): FAIL!!
//  753 						*iMinAttn = ATTN_MAX30;
        MOVS     R0,#+30
        STRB     R0,[R9, #+0]
//  754 						*iIsolationLevel = (ISO_MIN_GAIN + tmpGainOffset);
        MOVS     R0,#+45
        STRB     R0,[R12, #+0]
//  755 						ISOCheck->ISO_ALM_BIT = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
//  756 						ISOCheck->ISO_RALM_BIT = 1;
        STRB     R0,[R4, #+1]
//  757 						ISOCheck->ISO_WAITING = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+2]
//  758 						
//  759 						ISOCheck->ISOFail = TRUE;
        MOVS     R0,#+1
        STRB     R0,[R4, #+6]
//  760 						ISOCheck->ISOStep = __ISOENDFAIL;
        MOVS     R0,#+40
        STRB     R0,[R4, #+4]
//  761 						*RstCnt = 3;
        MOVS     R0,#+3
        STRB     R0,[R1, #+0]
//  762 
//  763 						if(rambackup[ResetOSC] == 0x15){
        LDR      R0,[R11, #+0]
        LDRB     R1,[R0, #+3]
        CMP      R1,#+21
        BNE.W    ??IsolationCheckFunc_9
//  764 							Booting[L_PATH] = 0xff;
        LDR.W    R1,??DataTable13_12
        MOVS     R2,#+255
        STRB     R2,[R1, #+0]
//  765 							Booting[W_PATH] = 0xff;
        STRB     R2,[R1, #+1]
//  766 							rambackup[ResetOSC] = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+3]
        B.N      ??IsolationCheckFunc_9
//  767 						}
//  768 					}
//  769 					else {
//  770 						rambackup[ResetOSC] = 0x15;
??IsolationCheckFunc_15:
        LDR      R0,[R11, #+0]
        MOVS     R1,#+21
        STRB     R1,[R0, #+3]
//  771 						OSTimeDly(Time100mSec*5L);
        MOV      R0,#+500
        BL       OSTimeDly
//  772 						DownLoadBootingJump();
        BL       DownLoadBootingJump
        B.N      ??IsolationCheckFunc_9
//  773 					}
//  774 				}
//  775 				else
//  776 				{
//  777 					// Attn 1dB stop // 제한~~확보.~~~~
//  778 					////////////////////////////////////////////////////////////
//  779 					if( (*iIsolationLevel) < (ISO_MAX_GAIN + tmpGainOffset) )
//  780 					{
//  781 						ISOCheck->ISO_ALM_BIT = 0;
??IsolationCheckFunc_14:
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  782 						ISOCheck->ISO_RALM_BIT = 0;
        STRB     R0,[R4, #+1]
//  783 					}
//  784 					else	// 확보!!!!!
//  785 					{
//  786 						ISOCheck->ISO_ALM_BIT = 0;
//  787 						ISOCheck->ISO_RALM_BIT = 0;
//  788 					}
//  789 					ISOCheck->ISO_WAITING = 0;					
        STRB     R0,[R4, #+2]
//  790 					////////////////////////////////////////////////////////////
//  791 					ISOCheck->ISOStep = __ISOENDSUCC;
        MOVS     R0,#+50
        B.N      ??IsolationCheckFunc_11
//  792 				}
//  793 			}
//  794 			else 
//  795 			{
//  796 				if(*iRVSAttn > 0)
??IsolationCheckFunc_13:
        LDRSB    R0,[R3, #+0]
        CMP      R0,#+1
        BLT.N    ??IsolationCheckFunc_16
//  797 				{
//  798 					(*iRVSAttn)--;
        SUBS     R0,R0,#+1
        STRB     R0,[R3, #+0]
//  799 					(*iIsolationLevel)++;
??IsolationCheckFunc_17:
        LDRB     R0,[R12, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R12, #+0]
//  800 					ISOCheck->ISOStep = (__ISOCHECK);
        MOVS     R0,#+10
        B.N      ??IsolationCheckFunc_11
//  801 				}
//  802 				else if(*iRvsAttnISO > 0)
??IsolationCheckFunc_16:
        LDRSB    R0,[R7, #+0]
        CMP      R0,#+1
        BLT.N    ??IsolationCheckFunc_18
//  803 				{
//  804 					(*iRvsAttnISO)--;
        SUBS     R0,R0,#+1
        STRB     R0,[R7, #+0]
//  805 					(*iIsolationLevel)++;
        B.N      ??IsolationCheckFunc_17
//  806 					ISOCheck->ISOStep = (__ISOCHECK);
//  807 				}
//  808 				else
//  809 				{
//  810 					// success end!!
//  811 					*iMinAttn = 0;
??IsolationCheckFunc_18:
        MOVS     R0,#+0
        STRB     R0,[R9, #+0]
//  812 					*iIsolationLevel = (ISO_MAX_GAIN + tmpGainOffset);
        MOVS     R0,#+102
        STRB     R0,[R12, #+0]
//  813 					ISOCheck->ISO_ALM_BIT = 0;
        B.N      ??IsolationCheckFunc_14
//  814 					ISOCheck->ISO_RALM_BIT = 0;
//  815 					ISOCheck->ISO_WAITING = 0; 
//  816 					
//  817 					ISOCheck->ISOStep = __ISOENDSUCC;
//  818 				}
//  819 			}
//  820 
//  821 		break;
//  822 ////////////////////////////////////////////////////////////////////////////////////////
//  823 		case __ISOENDSUCC:
//  824 			{
//  825 				INT32U tmpAttn = 0;
//  826 				
//  827 				if( *iIsolationLevel == (ISO_MAX_GAIN + tmpGainOffset)){
??IsolationCheckFunc_7:
        LDRSB    R0,[R12, #+0]
        CMP      R0,#+102
        ITE      EQ 
        MOVEQ    R0,#+0
        RSBNE    R0,R0,#+97
//  828 					*iMinAttn = 0;
//  829 				}
//  830 				else{
//  831 					tmpAttn = *iIsolationLevel - 22;
//  832 					*iMinAttn = (SYSTEM_GAIN + tmpGainOffset) - tmpAttn;
        STRB     R0,[R9, #+0]
//  833 				}
//  834 			}
//  835 			// ATTN REPAIR !!
//  836 			if( (*iALCOnOff & 0x01) || (*iAGCOnOff & 0x01) ) {
        LDR      R0,[SP, #+20]
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BMI.N    ??IsolationCheckFunc_19
        LDR      R0,[SP, #+16]
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??IsolationCheckFunc_20
//  837 				*iFWDAttn = ATTN_MAX30;
??IsolationCheckFunc_19:
        MOVS     R0,#+30
        STRB     R0,[R2, #+0]
        B.N      ??IsolationCheckFunc_21
//  838 			}
//  839 			else {
//  840 				*iFWDAttn = *iFWDAttnBp;
??IsolationCheckFunc_20:
        LDR      R0,[SP, #+36]
        LDRSB    R0,[R0, #+0]
        STRB     R0,[R2, #+0]
//  841 				if(*iFWDAttn < *iMinAttn) *iFWDAttn = *iMinAttn;
        LDRB     R6,[R9, #+0]
        CMP      R0,R6
        IT       LT 
        STRBLT   R6,[R2, #+0]
//  842 			}
//  843 ////////////////////////////////////////////////////////////////////////////////
//  844 			*iRVSAttn = *iRvsAttnBp;
??IsolationCheckFunc_21:
        LDR      R0,[SP, #+32]
        LDRSB    R0,[R0, #+0]
        STRB     R0,[R3, #+0]
//  845 			if(*iRVSAttn < *iMinAttn) *iRVSAttn = *iMinAttn;
        LDRB     R2,[R9, #+0]
        CMP      R0,R2
        IT       LT 
        STRBLT   R2,[R3, #+0]
//  846 
//  847 			*iRvsAttnISO = *iRvsAttnISOBp;
        LDRB     R0,[R10, #+0]
        STRB     R0,[R7, #+0]
//  848 			
//  849 			*iFwdSWOnOff = *iFwdSWOnOffBp;
        LDR      R0,[SP, #+28]
        LDRB     R0,[R0, #+0]
        STRB     R0,[LR, #+0]
//  850 			*iRvsSWOnOff = *iRvsSWOnOffBp;
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+0]
        STRB     R0,[R8, #+0]
//  851 
//  852 			*RstCnt = 0;
        MOVS     R0,#+0
        STRB     R0,[R1, #+0]
//  853 			// RESET!! CLEAR
//  854 			ISOCheck->ISOStep = __ISORESULT;
??IsolationCheckFunc_22:
        MOVS     R0,#+60
        B.N      ??IsolationCheckFunc_11
//  855 		break;
//  856 
//  857 		case __ISOENDFAIL:
//  858 			*iFWDAttn = ATTN_MAX30;
??IsolationCheckFunc_6:
        MOVS     R0,#+30
        STRB     R0,[R2, #+0]
//  859 			*iRVSAttn = ATTN_MAX30;
        STRB     R0,[R3, #+0]
//  860 			*iRvsAttnISO = *iRvsAttnISOBp;
        LDRB     R0,[R10, #+0]
        STRB     R0,[R7, #+0]
//  861 
//  862 			*iFwdSWOnOff = '0';
        MOVS     R0,#+48
        STRB     R0,[LR, #+0]
//  863 			*iRvsSWOnOff = '0';
        STRB     R0,[R8, #+0]
//  864 
//  865 			ISOCheck->ISOStep = __ISORESULT;
        B.N      ??IsolationCheckFunc_22
//  866 		break;
//  867 
//  868 		case __ISORESULT:
//  869 			{
//  870              	INT32U cpu_sr;
//  871 				INT8U rval = 0;
??IsolationCheckFunc_8:
        MOVS     R7,#+0
//  872 
//  873 				// ALARM BACKUP!!
//  874 				OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R6,R0
//  875 				{
//  876 					EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr); // Load 1st Area
        LDR.W    R9,??DataTable13_13  ;; 0x8006800
        MOV      R0,R9
        BL       RoadBackuptobuffer
//  877 					
//  878 					if(ISOCheck == &mISOCheck_4G)
        LDR      R1,[R5, #+0]
        LDRB     R2,[R1, #+68]
        LDRB     R3,[R0, #+2]
        LDR.W    R12,??DataTable13_9
        CMP      R4,R12
        BNE.N    ??IsolationCheckFunc_23
//  879 					{
//  880 						if(tptr->BackUp.AlarmFlag.PCS_ISO_ALM_BIT != MainStatus->AlarmFlag.PCS_ISO_ALM_BIT) rval = 1;
        LSRS     R3,R3,#+3
        AND      R3,R3,#0x1
        LSRS     R2,R2,#+3
        AND      R2,R2,#0x1
        CMP      R3,R2
        IT       NE 
        MOVNE    R7,#+1
//  881 						tptr->BackUp.AlarmFlag.PCS_ISO_ALM_BIT = MainStatus->AlarmFlag.PCS_ISO_ALM_BIT;
        LDRB     R1,[R1, #+68]
        UBFX     R1,R1,#+3,#+1
        LSLS     R1,R1,#+3
        LSRS     R1,R1,#+3
        LDRB     R2,[R0, #+2]
        BFI      R2,R1,#+3,#+1
        STRB     R2,[R0, #+2]
//  882 
//  883 						if(!MainStatus->AlarmFlag.PCS_ISO_ALM_BIT){
        LDR      R0,[R5, #+0]
        LDRB     R1,[R0, #+68]
        LSLS     R1,R1,#+28
        BMI.N    ??IsolationCheckFunc_24
//  884 							MainStatus->AlarmFlag.PCSOSCAlarm = 0;
        LDRB     R1,[R0, #+68]
        AND      R1,R1,#0xFD
        STRB     R1,[R0, #+68]
//  885 							rambackup[OSCAlarm_2G] = 0;
        LDR      R0,[R11, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
        B.N      ??IsolationCheckFunc_24
//  886 						}
//  887 					}
//  888 					else
//  889 					{
//  890 						if(tptr->BackUp.AlarmFlag.WCDMA_ISO_ALM_BIT != MainStatus->AlarmFlag.WCDMA_ISO_ALM_BIT) rval = 1;
??IsolationCheckFunc_23:
        LSRS     R3,R3,#+4
        AND      R3,R3,#0x1
        LSRS     R2,R2,#+4
        AND      R2,R2,#0x1
        CMP      R3,R2
        IT       NE 
        MOVNE    R7,#+1
//  891 						tptr->BackUp.AlarmFlag.WCDMA_ISO_ALM_BIT = MainStatus->AlarmFlag.WCDMA_ISO_ALM_BIT;
        LDRB     R1,[R1, #+68]
        UBFX     R1,R1,#+4,#+1
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
        LDRB     R2,[R0, #+2]
        BFI      R2,R1,#+4,#+1
        STRB     R2,[R0, #+2]
//  892 
//  893 						if(!MainStatus->AlarmFlag.WCDMA_ISO_ALM_BIT){
        LDR      R0,[R5, #+0]
        LDRB     R1,[R0, #+68]
        LSLS     R1,R1,#+27
        BMI.N    ??IsolationCheckFunc_24
//  894 							MainStatus->AlarmFlag.WCDMAOSCAlarm = 0;
        LDRB     R1,[R0, #+68]
        AND      R1,R1,#0xFB
        STRB     R1,[R0, #+68]
//  895 							rambackup[OSCAlarm_3G] = 0;
        LDR      R0,[R11, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+5]
//  896 						}
//  897 					}
//  898 
//  899 					if(rval) WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
??IsolationCheckFunc_24:
        CBZ.N    R7,??IsolationCheckFunc_25
        MOVS     R1,#+25
        MOV      R0,R9
        BL       WriteBuffertoBackup
//  900 				}
//  901 				OS_EXIT_CRITICAL();
??IsolationCheckFunc_25:
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
//  902 				if(rval) SerPtr->printf("ISO ALARM BACUPED\n");
        CBZ.N    R7,??IsolationCheckFunc_26
        LDR.W    R0,??DataTable13_14
        LDR.W    R1,??DataTable13_15
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  903 		    }
//  904 			*iISOOnOff = '0';
??IsolationCheckFunc_26:
        LDR      R0,[SP, #+12]
        MOVS     R1,#+48
        STRB     R1,[R0, #+0]
//  905 			ISOCheck->ISOStep = __ISOEND;
        MOVS     R0,#+255
??IsolationCheckFunc_11:
        STRB     R0,[R4, #+4]
//  906 		break;
//  907 		
//  908 		case __ISOEND:
//  909 			
//  910 		break;
//  911 	}
//  912 
//  913 	// ALARM Backup!!
//  914 	if(ISOCheck == &mISOCheck_4G)
??IsolationCheckFunc_9:
        LDR      R0,[R5, #+0]
        LDR.W    R1,??DataTable13_9
        CMP      R4,R1
        LDRB     R1,[R4, #+0]
        UBFX     R1,R1,#+0,#+1
        LDRB     R2,[R0, #+68]
        BNE.N    ??IsolationCheckFunc_27
//  915 	{
//  916 		MainStatus->AlarmFlag.PCS_ISO_ALM_BIT = ISOCheck->ISO_ALM_BIT;
        BFI      R2,R1,#+3,#+1
        STRB     R2,[R0, #+68]
//  917 		MainStatus->AlarmFlag.PCS_ISO_RALM1_BIT = ISOCheck->ISO_RALM_BIT;
        LDR      R0,[R5, #+0]
        LDRB     R1,[R4, #+1]
        UBFX     R1,R1,#+0,#+1
        LDRB     R2,[R0, #+68]
        BFI      R2,R1,#+5,#+1
        STRB     R2,[R0, #+68]
//  918 		MainStatus->AlarmFlag.PCS_ISO_WAITING = ISOCheck->ISO_WAITING; 
        LDR      R0,[R5, #+0]
        LDRB     R1,[R4, #+2]
        UBFX     R1,R1,#+0,#+1
        LDRB     R2,[R0, #+69]
        BFI      R2,R1,#+2,#+1
        B.N      ??IsolationCheckFunc_28
//  919 	}
//  920 	else
//  921 	{
//  922 		MainStatus->AlarmFlag.WCDMA_ISO_ALM_BIT = ISOCheck->ISO_ALM_BIT;
??IsolationCheckFunc_27:
        BFI      R2,R1,#+4,#+1
        STRB     R2,[R0, #+68]
//  923 		MainStatus->AlarmFlag.WCDMA_ISO_RALM2_BIT = ISOCheck->ISO_RALM_BIT;
        LDR      R0,[R5, #+0]
        LDRB     R1,[R4, #+1]
        UBFX     R1,R1,#+0,#+1
        LDRB     R2,[R0, #+68]
        BFI      R2,R1,#+6,#+1
        STRB     R2,[R0, #+68]
//  924 		MainStatus->AlarmFlag.WCDMA_ISO_WAITING = ISOCheck->ISO_WAITING; 
        LDR      R0,[R5, #+0]
        LDRB     R1,[R4, #+2]
        UBFX     R1,R1,#+0,#+1
        LDRB     R2,[R0, #+69]
        BFI      R2,R1,#+3,#+1
??IsolationCheckFunc_28:
        STRB     R2,[R0, #+69]
//  925 	}
//  926     
//  927     return (ISOCheck->ISOFail);
        LDRB     R0,[R4, #+6]
        ADD      SP,SP,#+52
        POP      {R4-R11,PC}      ;; return
//  928 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     0x8000024

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8_1:
        DC32     0x4c4f5049

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8_2:
        DC32     AlcTaskStk+0x3FC

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8_3:
        DC32     ADC_DATA

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8_4:
        DC32     ADC_AVR
//  929 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  930 INT8U OSCCheckFunc (__OscStr *OSCCheck, INT8U IsItSHD, INT8U IsItSLP)
//  931 { 
OSCCheckFunc:
        PUSH     {R3-R9,LR}
        MOV      R4,R0
//  932 	INT8U rval = 0;
        MOVS     R0,#+0
//  933 
//  934 	INT8S *iRvsPower;
//  935 	INT8S *iOSCLimit;
//  936 	INT8U *iRstCnt;
//  937 	INT8U *iRvsSWOnOffBp; 
//  938 	INT8U *iRvsOSCAttn;
//  939 
//  940 	if(OSCCheck == &mOSCCheck_4G)
        LDR.N    R5,??DataTable9_2
        LDR      LR,[R5, #+0]
        LDR.W    R8,??DataTable13_2  ;; 0x8006016
        LDR.W    R3,??DataTable13_8
        LDR.W    R9,??DataTable13_16
        CMP      R4,R9
        ITTT     EQ 
        ADDWEQ   R12,LR,#+25
        ADDWEQ   R7,LR,#+59
        ADDWEQ   LR,LR,#+99
//  941 	{
//  942 		iRvsPower = &MainStatus->PCSRvsPower;
//  943 		iOSCLimit = &MainStatus->OSCLimit1;
//  944 		iRvsSWOnOffBp = &vEE_BACK1->BackUp.SWOnOff2; 
//  945 		iRvsOSCAttn = &MainStatus->OSCAttn_2G;
//  946 
//  947 		iRstCnt = &rambackup[ResetCountBp1];
        BEQ.N    ??OSCCheckFunc_1
//  948 	}
//  949 	else
//  950 	{
//  951 		iRvsPower = &MainStatus->WCDMARvsPower;
        ADDW     R12,LR,#+29
//  952 		iOSCLimit = &MainStatus->OSCLimit2;
        ADDW     R7,LR,#+60
//  953 		iRvsSWOnOffBp = &vEE_BACK1->BackUp.RxSWOnOff_3G; 
        ADDW     R8,R8,#+41
//  954 		iRvsOSCAttn = &MainStatus->OSCAttn_3G;
        ADDW     LR,LR,#+100
//  955 
//  956 		iRstCnt = &rambackup[ResetCountBp1];
??OSCCheckFunc_1:
        LDR      R6,[R3, #+0]
        ADDS     R6,R6,#+2
//  957 	}
//  958 
//  959 	if(IsItSHD || IsItSLP) 				OSCCheck->OSCStep = 0;
        ORRS     R1,R2,R1
        IT       NE 
        STRBNE   R0,[R4, #+5]
//  960 	if(!(MainStatus->OSCOnOff & 0x01)) 	OSCCheck->OSCStep = 0;
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+44]
        LSLS     R1,R1,#+31
        IT       PL 
        STRBPL   R0,[R4, #+5]
//  961 	if(!(*iRvsSWOnOffBp & 0x01)) 		OSCCheck->OSCStep = 0;
        LDRB     R1,[R8, #+0]
        LSLS     R1,R1,#+31
        IT       PL 
        STRBPL   R0,[R4, #+5]
        BPL.N    ??OSCCheckFunc_2
//  962 
//  963 ////////////////////////////////////////////////////////////////////////////////
//  964 	//if(OSCCheck == &mOSCCheck_4G) SerPtr->printf("step: %d\n", OSCCheck->OSCStep);
//  965 	//SerPtr->printf("STEP: %d Power: %d\n", OSCCheck->OSCStep, *iRvsPower);
//  966 
//  967 	switch (OSCCheck->OSCStep)
        LDRB     R1,[R4, #+5]
        CMP      R1,#+5
        BHI.N    ??OSCCheckFunc_3
        TBB      [PC, R1]
        DATA
??OSCCheckFunc_0:
        DC8      0x3,0x11,0x20,0x37
        DC8      0x52,0x5E
        THUMB
//  968 	{
//  969 		case 0:
//  970 			if(*iRvsPower <= *iOSCLimit){
??OSCCheckFunc_2:
        LDRSB    R1,[R7, R0]
        LDRSB    R2,[R12, #+0]
        CMP      R1,R2
        ITT      GE 
        STRBGE   R0,[R4, #+0]
        STRBGE   R0,[LR, #+0]
//  971 				OSCCheck->OSCAlarm = 0;
//  972 				*iRvsOSCAttn = 0;
//  973 				break;
        BGE.N    ??OSCCheckFunc_4
//  974 			}
//  975 			OSCCheck->OSCStep = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+5]
//  976 			OSCCheck->OSCCnt = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+3]
//  977 			rval = TRUE;
        B.N      ??OSCCheckFunc_3
//  978 		break;
//  979 
//  980 		case 1:
//  981 			////////////////////////////////////////////////////////////////////
//  982 			//if(OSCCheck == &mOSCCheck_4G) SerPtr->printf("iRvsPower: %d \n", *iRvsPower);
//  983 			if(*iRvsPower <= *iOSCLimit) {
??OSCCheckFunc_5:
        LDRSB    R1,[R12, #+0]
        LDRSB    R2,[R7, R0]
        CMP      R2,R1
        BLT.N    ??OSCCheckFunc_6
//  984 				OSCCheck->OSCAlarm = 0;
        STRB     R0,[R4, #+0]
//  985 				//OSCCheck->OSCTimeCnt++;
//  986 				//if(OSCCheck->OSCTimeCnt >= 5)
//  987 				OSCCheck->OSCStep = 0;
??OSCCheckFunc_7:
        STRB     R0,[R4, #+5]
//  988 				break;
        B.N      ??OSCCheckFunc_4
//  989 			}
//  990 			OSCCheck->OSCPowerRef = *iRvsPower;		// FirStart Lvl!!
??OSCCheckFunc_6:
        STRB     R1,[R4, #+2]
//  991 			OSCCheck->OSCStep = 2;
        MOVS     R0,#+2
        STRB     R0,[R4, #+5]
//  992 			*iRvsOSCAttn = 15*2L;
        MOVS     R0,#+30
        STRB     R0,[LR, #+0]
//  993 			rval = TRUE;
        B.N      ??OSCCheckFunc_3
//  994 		break;
//  995 
//  996 		case 2:
//  997 			{
//  998 				INT8S tmp = (OSCCheck->OSCPowerRef - *iRvsPower);
??OSCCheckFunc_8:
        LDRSB    R0,[R4, #+2]
        LDRB     R1,[R12, #+0]
        SUBS     R0,R0,R1
        SXTB     R0,R0
//  999 
// 1000 				//if(OSCCheck == &mOSCCheck_4G) SerPtr->printf("difference: %d, %d, %d\n", tmp, OSCCheck->OSCPowerRef, *iRvsPower);
// 1001 				//if(OSCCheck == &mOSCCheck_4G) SerPtr->printf("CNT: %d\n", OSCCheck->OSCCnt);
// 1002 
// 1003 				*iRvsOSCAttn = 0;
        MOVS     R1,#+0
        STRB     R1,[LR, #+0]
// 1004 				if(tmp > 17)
        CMP      R0,#+18
        BLT.N    ??OSCCheckFunc_9
// 1005 				{
// 1006 					if(++OSCCheck->OSCCnt < 3){
        LDRB     R0,[R4, #+3]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+3]
        UXTB     R0,R0
        CMP      R0,#+3
        ITE      CS 
        MOVCS    R0,#+3
        MOVCC    R0,#+1
// 1007 						OSCCheck->OSCStep = 1;	//
        B.N      ??OSCCheckFunc_10
// 1008 						//OSCCheck->OSCTimeCnt = 0;
// 1009 					}
// 1010 					else{
// 1011 						OSCCheck->OSCStep = 3;		// go to shut down~~~
// 1012 					}
// 1013 				}
// 1014 				else
// 1015 				{
// 1016 					OSCCheck->OSCStep = 4;
??OSCCheckFunc_9:
        MOVS     R0,#+4
// 1017 					OSCCheck->OSCTimeCnt = 0;
        STRB     R1,[R4, #+1]
??OSCCheckFunc_11:
        B.N      ??OSCCheckFunc_10
// 1018 				}
// 1019 				rval = TRUE;
// 1020 			}
// 1021 		break;
// 1022 
// 1023 		case 3:
// 1024 			{	// shutdown
// 1025 				if( (*iRstCnt) < 3 )
??OSCCheckFunc_12:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+3
        BCS.N    ??OSCCheckFunc_13
// 1026 				{
// 1027 					(*iRstCnt)++;
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+0]
// 1028 					OSCCheck->OSCAlarm = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
// 1029 					{
// 1030 						if(OSCCheck == &mOSCCheck_4G)
        LDR      R0,[R3, #+0]
        CMP      R4,R9
        ITTEE    EQ 
        MOVEQ    R1,#+1
        STRBEQ   R1,[R0, #+4]
        MOVNE    R1,#+1
        STRBNE   R1,[R0, #+5]
// 1031 						{
// 1032 							rambackup[OSCAlarm_2G] = OSCCheck->OSCAlarm;
// 1033 						}
// 1034 						else
// 1035 						{
// 1036 							rambackup[OSCAlarm_3G] = OSCCheck->OSCAlarm;
// 1037 						}
// 1038 					}
// 1039 					rambackup[ResetOSC] = 0x15;
        LDR      R0,[R3, #+0]
        MOVS     R1,#+21
        STRB     R1,[R0, #+3]
// 1040 					OSTimeDly(Time100mSec*5);
        MOV      R0,#+500
        BL       OSTimeDly
// 1041 					DownLoadBootingJump();
        BL       DownLoadBootingJump
        B.N      ??OSCCheckFunc_3
// 1042 				}
// 1043 				else
// 1044 				{
// 1045 					// 완전 SHUTDOWN!!!
// 1046 					*iRstCnt = 3;
??OSCCheckFunc_13:
        MOVS     R0,#+3
        STRB     R0,[R6, #+0]
// 1047 				}
// 1048 			}
// 1049 			rval = TRUE;
        B.N      ??OSCCheckFunc_3
// 1050 		break;
// 1051 
// 1052 		case 4:
// 1053 			//if(OSCCheck == &mOSCCheck_4G) SerPtr->printf("OSCTimeCnt: %d, %d\n", OSCCheck->OSCTimeCnt, *iRvsPower);
// 1054 
// 1055 			if(++OSCCheck->OSCTimeCnt < 30*2L)
??OSCCheckFunc_14:
        LDRB     R1,[R4, #+1]
        ADDS     R1,R1,#+1
        STRB     R1,[R4, #+1]
        UXTB     R1,R1
        CMP      R1,#+60
        BCS.N    ??OSCCheckFunc_7
// 1056 			{
// 1057 				if(*iRvsPower <= *iOSCLimit) {
        LDRSB    R1,[R7, R0]
        LDRSB    R2,[R12, #+0]
        CMP      R1,R2
        BLT.N    ??OSCCheckFunc_4
// 1058 					OSCCheck->OSCStep = 0;
        B.N      ??OSCCheckFunc_7
// 1059 				}
// 1060 			}
// 1061 			else
// 1062 			{
// 1063 				OSCCheck->OSCStep = 0;
// 1064 			}
// 1065 			rval = FALSE;
// 1066 		break;
// 1067 
// 1068 		case 5:
// 1069 			// BACUP ALARM!!
// 1070 			OSCCheck->OSCStep = 100;
??OSCCheckFunc_15:
        MOVS     R0,#+100
??OSCCheckFunc_10:
        STRB     R0,[R4, #+5]
// 1071 			rval = TRUE;
// 1072 		break;
// 1073 		default:
// 1074 			rval = TRUE;
??OSCCheckFunc_3:
        MOVS     R0,#+1
// 1075 		break;
// 1076 	}
// 1077 
// 1078 ///////////////////////////////////////////////////////////////////////////////
// 1079 	// Alarm copy!!
// 1080 	if(OSCCheck == &mOSCCheck_4G) 	MainStatus->AlarmFlag.PCSOSCAlarm = OSCCheck->OSCAlarm;
??OSCCheckFunc_4:
        LDR      R1,[R5, #+0]
        CMP      R4,R9
        LDRB     R2,[R4, #+0]
        UBFX     R2,R2,#+0,#+1
        LDRB     R3,[R1, #+68]
        ITE      EQ 
        BFIEQ    R3,R2,#+1,#+1
        BFINE    R3,R2,#+2,#+1
// 1081 	else							MainStatus->AlarmFlag.WCDMAOSCAlarm = OSCCheck->OSCAlarm;
        STRB     R3,[R1, #+68]
// 1082 
// 1083 	OSCCheck->IsItOSC = rval;
        STRB     R0,[R4, #+6]
// 1084 
// 1085 	return rval;	// normal
        POP      {R1,R4-R9,PC}    ;; return
// 1086 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     AlcTask

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9_1:
        DC32     tTestFlag

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9_2:
        DC32     MainStatus
// 1087 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1088 void ResetStart(INT32U tms)
// 1089 {
// 1090 	TimerRegist(TimerReset, tms);
ResetStart:
        MOV      R1,R0
        MOVS     R0,#+7
        B.W      TimerRegist
// 1091 }
// 1092 
// 1093 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1094 INT32S ConvLevelOneByte(INT8S *lvl)
// 1095 {
// 1096 	INT32S tmpPwr = lvl[1];
ConvLevelOneByte:
        LDRSB    R1,[R0, #+1]
// 1097 
// 1098 	     if(tmpPwr >  7) 	tmpPwr = 10;
        CMP      R1,#+8
        IT       GE 
        MOVGE    R1,#+10
        BGE.N    ??ConvLevelOneByte_0
// 1099 	else if(tmpPwr >  2) 	tmpPwr = 5;
        CMP      R1,#+3
        IT       GE 
        MOVGE    R1,#+5
        BGE.N    ??ConvLevelOneByte_0
// 1100 	else if(tmpPwr > -3)	tmpPwr = 0;
        CMN      R1,#+2
        IT       GE 
        MOVGE    R1,#+0
        BGE.N    ??ConvLevelOneByte_0
// 1101 	else if(tmpPwr > -8)	tmpPwr = -5;
        CMN      R1,#+7
        ITE      GE 
        MVNGE    R1,#+4
        MVNLT    R1,#+9
// 1102 	else					tmpPwr = -10;
// 1103 
// 1104 	tmpPwr = (lvl[0]*10 + tmpPwr);
// 1105 	return (INT32S)((tmpPwr*2L)/10L);
??ConvLevelOneByte_0:
        MOVS     R2,#+10
        LDRSB    R0,[R0, #+0]
        MLA      R0,R2,R0,R1
        LSLS     R0,R0,#+1
        SDIV     R0,R0,R2
        BX       LR               ;; return
// 1106 }
// 1107 
// 1108 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1109 void ChangeLvltoValue(INT16S CurLvl, INT16S *PreLvl, INT16S *Cnt, INT16S *Value, INT8S MaxCnt)
// 1110 {
ChangeLvltoValue:
        PUSH     {R4,R5}
        LDRSB    R4,[SP, #+8]
// 1111 	if(*Value != CurLvl)
        LDRSH    R5,[R3, #+0]
        CMP      R5,R0
        BEQ.N    ??ChangeLvltoValue_0
// 1112 	{
// 1113 		if(*PreLvl == CurLvl)
        LDRSH    R5,[R1, #+0]
        CMP      R5,R0
        BNE.N    ??ChangeLvltoValue_1
// 1114 		{
// 1115 			*Cnt = *Cnt + 1;
        LDRH     R1,[R2, #+0]
        ADDS     R1,R1,#+1
        STRH     R1,[R2, #+0]
// 1116 			if(*Cnt >= MaxCnt)
        SXTH     R1,R1
        CMP      R1,R4
        BLT.N    ??ChangeLvltoValue_2
// 1117 			{
// 1118 				*Value = CurLvl;
        STRH     R0,[R3, #+0]
// 1119 				*Cnt = 0;
        B.N      ??ChangeLvltoValue_0
// 1120 			}
// 1121 		}
// 1122 		else
// 1123 		{
// 1124 			*PreLvl = CurLvl;
??ChangeLvltoValue_1:
        STRH     R0,[R1, #+0]
// 1125 			*Cnt = 0;
// 1126 		}
// 1127 	}
// 1128 	else *Cnt = 0;
??ChangeLvltoValue_0:
        MOVS     R0,#+0
        STRH     R0,[R2, #+0]
// 1129 }
??ChangeLvltoValue_2:
        POP      {R4,R5}
        BX       LR               ;; return
// 1130 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1131 INT8U TemptoIndex(INT8S temp)
// 1132 {
// 1133 	INT32U i = 0;
// 1134 	INT8S toffset = (-10);
TemptoIndex:
        MVN      R2,#+9
// 1135 
// 1136 	for(i = 0; toffset <= 80; i++, toffset += 2)
        MOVS     R1,#+0
        B.N      ??TemptoIndex_0
??TemptoIndex_1:
        ADDS     R1,R1,#+1
        ADDS     R2,R2,#+2
        CMP      R2,#+81
        BGE.N    ??TemptoIndex_2
// 1137 	{
// 1138 		if(temp <= toffset) return i;
??TemptoIndex_0:
        CMP      R2,R0
        BLT.N    ??TemptoIndex_1
??TemptoIndex_2:
        UXTB     R0,R1
        BX       LR               ;; return
// 1139 	}
// 1140     return i;
// 1141 }
// 1142 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1143 INT8U TemptoSleepOffset(INT8S temp)
// 1144 {
// 1145 		INT32U i = 0;
// 1146 		INT8S toffset = 25;
TemptoSleepOffset:
        MOVS     R2,#+25
// 1147 
// 1148 		for(i = 0; toffset >= -10; i++, toffset -= 5)
        MOVS     R1,#+0
        MVN      R3,#+9
        B.N      ??TemptoSleepOffset_0
??TemptoSleepOffset_1:
        ADDS     R1,R1,#+1
        SUBS     R2,R2,#+5
        CMP      R2,R3
        BLT.N    ??TemptoSleepOffset_2
// 1149 		{
// 1150 			if(temp > toffset) return i;
??TemptoSleepOffset_0:
        CMP      R2,R0
        BGE.N    ??TemptoSleepOffset_1
??TemptoSleepOffset_2:
        UXTB     R0,R1
        BX       LR               ;; return
// 1151 		}
// 1152 		return (i);
// 1153 }
// 1154 
// 1155 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1156 INT8U UPdateAlarm(INT8U *CurSts, INT8U *PreSts, INT8U *ChangeFlag, INT8U *AlarmTimer, INT8U AlarmCnt)
// 1157 {
UPdateAlarm:
        PUSH     {R4,R5}
        LDR      R4,[SP, #+8]
// 1158 	*ChangeFlag = 0;
        MOVS     R5,#+0
        STRB     R5,[R2, #+0]
// 1159 
// 1160 	if( (*CurSts) ==  (*PreSts) )
        LDRB     R0,[R0, #+0]
        LDRB     R5,[R1, #+0]
        CMP      R0,R5
        IT       EQ 
        STRBEQ   R4,[R3, #+0]
// 1161 	{
// 1162 		*AlarmTimer = AlarmCnt;
        BEQ.N    ??UPdateAlarm_0
// 1163 	}
// 1164 	else
// 1165 	{
// 1166 		if(*AlarmTimer == 0)
        LDRB     R5,[R3, #+0]
        CBNZ.N   R5,??UPdateAlarm_1
// 1167 		{
// 1168 			*PreSts = *CurSts;
        STRB     R0,[R1, #+0]
// 1169 			*AlarmTimer = AlarmCnt;			// 2010.07.02 수정.
        STRB     R4,[R3, #+0]
// 1170 			*ChangeFlag = 1;
        MOVS     R0,#+1
        STRB     R0,[R2, #+0]
// 1171 			return TRUE;
        B.N      ??UPdateAlarm_2
// 1172 		}
// 1173 		else *AlarmTimer = *AlarmTimer - 1;
??UPdateAlarm_1:
        SUBS     R0,R5,#+1
        STRB     R0,[R3, #+0]
// 1174 	}
// 1175 	return FALSE;
??UPdateAlarm_0:
        MOVS     R0,#+0
??UPdateAlarm_2:
        POP      {R4,R5}
        BX       LR               ;; return
// 1176 }
// 1177 
// 1178 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1179 INT8S AgcLimitOperation(INT8S gap, INT8U tmpAlcAttn, INT8U AttMax, INT8U AttMin, INT8U Mode)
// 1180 {
AgcLimitOperation:
        LDR      R3,[SP, #+0]
// 1181 	INT8S tmp = 0;
        MOVS     R2,#+0
// 1182 #ifdef _ALC_Debug_2G		
// 1183  	SerPtr->printf("gap[%d]:tmpAlcAttn[%d]AttMax[%d]AttMin[%d]->[%d]\n",gap,tmpAlcAttn,AttMax,AttMin,Mode);
// 1184 #endif
// 1185 	if( Mode == _AGC_Mode )
        CBNZ.N   R3,??AgcLimitOperation_0
// 1186 	{
// 1187 		if(gap > 0)
        CMP      R0,#+1
        BLT.N    ??AgcLimitOperation_1
// 1188 		{
// 1189 			if		(gap >  10L) 	tmp =  10L;
        CMP      R0,#+11
        BLT.N    ??AgcLimitOperation_2
??AgcLimitOperation_3:
        MOVS     R2,#+10
        B.N      ??AgcLimitOperation_4
// 1190 			else if	(gap >  6L)  	tmp =  6L;
??AgcLimitOperation_2:
        CMP      R0,#+7
        BLT.N    ??AgcLimitOperation_5
??AgcLimitOperation_6:
        MOVS     R2,#+6
        B.N      ??AgcLimitOperation_4
// 1191 			else if	(gap >  4L) 	tmp =  4L;
// 1192 			else 					tmp = 1;
// 1193 		}
// 1194 		else if(gap < 0 && tmpAlcAttn != 0)
??AgcLimitOperation_1:
        CMP      R0,#+0
        BPL.N    ??AgcLimitOperation_4
        CBZ.N    R1,??AgcLimitOperation_4
// 1195 		{
// 1196 			if	(gap < -10L) tmp = -10L;
        MVN      R2,#+9
        CMP      R0,R2
        BLT.N    ??AgcLimitOperation_4
// 1197 			else			 tmp = -1;
        MOV      R2,#-1
        B.N      ??AgcLimitOperation_4
// 1198 		}
// 1199 		else tmp = 0;
// 1200 	}
// 1201 	else if ( Mode == _ALC_Mode )
??AgcLimitOperation_0:
        CMP      R3,#+1
        BNE.N    ??AgcLimitOperation_4
// 1202 	{
// 1203 		if(gap > 0)
        CMP      R0,#+1
        BLT.N    ??AgcLimitOperation_4
// 1204 		{
// 1205 			if		(gap >  10L)  	tmp =  10L;
        CMP      R0,#+11
        BGE.N    ??AgcLimitOperation_3
// 1206 			else if	(gap >  6L)  	tmp =  6L;
        CMP      R0,#+7
        BGE.N    ??AgcLimitOperation_6
// 1207 			else if	(gap >  4L)  	tmp =  4L;
??AgcLimitOperation_5:
        CMP      R0,#+5
        ITE      GE 
        MOVGE    R2,#+4
        MOVLT    R2,#+1
// 1208 			else 					tmp = 1;
// 1209 		}
// 1210 		else tmp = 0;
// 1211 	}
// 1212 	
// 1213 	return tmp;
??AgcLimitOperation_4:
        MOV      R0,R2
        BX       LR               ;; return
// 1214 }
// 1215 
// 1216 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1217 void ResetCaseBackup(INT8U Cause)
// 1218 {
// 1219 	rambackup[NMS_RESET_Bp] = Cause;
ResetCaseBackup:
        LDR.N    R1,??DataTable13_8
        LDR      R2,[R1, #+0]
        STRB     R0,[R2, #+0]
// 1220 	rambackup[ResetCountBp] = 0;
        LDR      R0,[R1, #+0]
        MOVS     R2,#+0
        STRB     R2,[R0, #+1]
// 1221 	rambackup[ResetCountBp1] = 0;
        LDR      R0,[R1, #+0]
        STRB     R2,[R0, #+2]
// 1222 	rambackup[ResetOSC] = 0;
        LDR      R0,[R1, #+0]
        STRB     R2,[R0, #+3]
// 1223 }
        BX       LR               ;; return
// 1224 
// 1225 
// 1226 #define LimitAlmMax   5

        SECTION `.bss`:DATA:NOROOT(2)
// 1227 INT8U LimitAlarmCnt[LimitAlmMax];
LimitAlarmCnt:
        DS8 8
// 1228 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1229 INT8U LimitAlarmUpdate( INT8U CurrAlarm, INT8U PreAlarm, INT16U AlarmIndex)
// 1230 {
LimitAlarmUpdate:
        PUSH     {R4}
// 1231 	#define AlarmCheckTime		40L
// 1232 	
// 1233 	if(CurrAlarm != PreAlarm)
        LDR.N    R3,??DataTable13_17
        CMP      R0,R1
        BEQ.N    ??LimitAlarmUpdate_0
// 1234 	{
// 1235 		LimitAlarmCnt[AlarmIndex]++;
        LDRB     R4,[R2, R3]
        ADDS     R4,R4,#+1
        STRB     R4,[R2, R3]
// 1236 		
// 1237 		if(LimitAlarmCnt[AlarmIndex] > AlarmCheckTime)
        UXTB     R4,R4
        CMP      R4,#+41
        BCC.N    ??LimitAlarmUpdate_1
// 1238 		{
// 1239 			LimitAlarmCnt[AlarmIndex] = 0;
        MOVS     R1,#+0
        STRB     R1,[R2, R3]
// 1240 			
// 1241 			return CurrAlarm;
        B.N      ??LimitAlarmUpdate_2
// 1242 		}
// 1243 	}
// 1244 	else LimitAlarmCnt[AlarmIndex] = 0;
??LimitAlarmUpdate_0:
        MOVS     R0,#+0
        STRB     R0,[R2, R3]
// 1245 
// 1246 	return PreAlarm;
??LimitAlarmUpdate_1:
        MOV      R0,R1
??LimitAlarmUpdate_2:
        POP      {R4}
        BX       LR               ;; return
// 1247 }
// 1248 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1249 void FrontLEDSet(INT8U tindex, INT8U tstatus)
// 1250 {
// 1251 	LEDStatus[tindex%LED_SelMax] = tstatus;
FrontLEDSet:
        MOVS     R2,#+6
        SDIV     R3,R0,R2
        MLS      R0,R2,R3,R0
        LDR.N    R2,??DataTable13_18
        ADDS     R0,R0,R2
        STRB     R1,[R0, #+4]
// 1252 
// 1253 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     MinAttn4G

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1254 void FrontLEDDisplay(void)
// 1255 {
FrontLEDDisplay:
        PUSH     {R4,LR}
// 1256 	INT16U i = 0;
// 1257 
// 1258 	if(!TimeOverCheck(TimerLEDBlink)) return;
        MOVS     R0,#+8
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??FrontLEDDisplay_0
// 1259 	TimerRegist(TimerLEDBlink, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+8
        BL       TimerRegist
// 1260 	BlinkFlag ^= 1;
        LDR.N    R1,??DataTable13_18
        LDRB     R0,[R1, #+0]
        EOR      R0,R0,#0x1
        STRB     R0,[R1], #+4
// 1261 
// 1262 	for(i = 0; i < LED_SelMax; i++)
        MOVS     R0,#+0
        LDR.N    R2,??DataTable13_19  ;; 0x4001140c
        LDR.N    R3,??DataTable13_20  ;; 0x4001180c
// 1263 	{
// 1264 		switch(LEDStatus[i])
??FrontLEDDisplay_1:
        LDRB     R4,[R1, #+0]
        CMP      R4,#+1
        BEQ.N    ??FrontLEDDisplay_2
        CMP      R4,#+2
        BEQ.N    ??FrontLEDDisplay_3
        B.N      ??FrontLEDDisplay_4
// 1265 		{
// 1266 			case LEDON:
// 1267 				switch(i)
??FrontLEDDisplay_2:
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_5
        BCC.N    ??FrontLEDDisplay_6
        CMP      R0,#+3
        BEQ.N    ??FrontLEDDisplay_7
        BCC.N    ??FrontLEDDisplay_8
        CMP      R0,#+5
        BEQ.N    ??FrontLEDDisplay_9
        BCC.N    ??FrontLEDDisplay_10
// 1268 				{
// 1269                     default:
// 1270 					case LED_2G_NorSel:
// 1271 						_4G_NORLED = 1;
??FrontLEDDisplay_6:
        LDR      R4,[R2, #+0]
        ORR      R4,R4,#0x800
??FrontLEDDisplay_11:
        STR      R4,[R2, #+0]
        B.N      ??FrontLEDDisplay_12
// 1272 					break;
// 1273 					
// 1274 					case LED_2G_SleepSel:
// 1275 						_4G_SLPLED = 1;
??FrontLEDDisplay_5:
        LDR      R4,[R2, #+0]
        ORR      R4,R4,#0x1000
        B.N      ??FrontLEDDisplay_11
// 1276 					break;
// 1277 					
// 1278 					case LED_2G_OscSel:
// 1279 						_4G_OSCLED = 1;
??FrontLEDDisplay_8:
        LDR      R4,[R2, #+0]
        ORR      R4,R4,#0x2000
??FrontLEDDisplay_13:
        B.N      ??FrontLEDDisplay_11
// 1280 					break;
// 1281 					
// 1282 					case LED_3G_NorSel:
// 1283 						_3G_NORLED = 1;
??FrontLEDDisplay_7:
        LDR      R4,[R3, #+0]
        ORR      R4,R4,#0x1000
        B.N      ??FrontLEDDisplay_14
// 1284 					break;
// 1285 					
// 1286 					case LED_3G_SleepSel:
// 1287 						_3G_SLPLED = 1;
??FrontLEDDisplay_10:
        LDR      R4,[R3, #+0]
        ORR      R4,R4,#0x2000
        B.N      ??FrontLEDDisplay_14
// 1288 					break;
// 1289 					
// 1290 					case LED_3G_OscSel:
// 1291 						_3G_OSCLED = 1;
??FrontLEDDisplay_9:
        LDR      R4,[R3, #+0]
        ORR      R4,R4,#0x4000
        B.N      ??FrontLEDDisplay_14
// 1292 					break;					
// 1293 
// 1294 				}
// 1295 			break;
// 1296 
// 1297 			case LEDONOFF:
// 1298 				switch(i)
??FrontLEDDisplay_3:
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_15
        BCC.N    ??FrontLEDDisplay_16
        CMP      R0,#+3
        BEQ.N    ??FrontLEDDisplay_17
        BCC.N    ??FrontLEDDisplay_18
        CMP      R0,#+5
        BEQ.N    ??FrontLEDDisplay_19
        BCC.N    ??FrontLEDDisplay_20
// 1299 				{
// 1300                     default:
// 1301 					case LED_2G_NorSel:
// 1302 						_4G_NORLED ^= 1;
??FrontLEDDisplay_16:
        LDR      R4,[R2, #+0]
        EOR      R4,R4,#0x800
        B.N      ??FrontLEDDisplay_11
// 1303 					break;
// 1304 					case LED_2G_SleepSel:
// 1305 						_4G_SLPLED ^= 1;
??FrontLEDDisplay_15:
        LDR      R4,[R2, #+0]
        EOR      R4,R4,#0x1000
        B.N      ??FrontLEDDisplay_11
// 1306 					break;
// 1307 					case LED_2G_OscSel:
// 1308 						_4G_OSCLED ^= 1;
??FrontLEDDisplay_18:
        LDR      R4,[R2, #+0]
        EOR      R4,R4,#0x2000
        B.N      ??FrontLEDDisplay_11
// 1309 					break;
// 1310 					case LED_3G_NorSel:
// 1311 						_3G_NORLED ^= 1;
??FrontLEDDisplay_17:
        LDR      R4,[R3, #+0]
        EOR      R4,R4,#0x1000
        B.N      ??FrontLEDDisplay_14
// 1312 					break;
// 1313 					case LED_3G_SleepSel:
// 1314 						_3G_SLPLED ^= 1;
??FrontLEDDisplay_20:
        LDR      R4,[R3, #+0]
        EOR      R4,R4,#0x2000
        B.N      ??FrontLEDDisplay_14
// 1315 					break;
// 1316 					case LED_3G_OscSel:
// 1317 						_3G_OSCLED ^= 1;
??FrontLEDDisplay_19:
        LDR      R4,[R3, #+0]
        EOR      R4,R4,#0x4000
        B.N      ??FrontLEDDisplay_14
// 1318 					break;
// 1319 				}
// 1320 			break;
// 1321 			
// 1322 		
// 1323 			default:
// 1324 			case LEDOFF:
// 1325 				switch(i)
??FrontLEDDisplay_4:
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_21
        BCC.N    ??FrontLEDDisplay_22
        CMP      R0,#+3
        BEQ.N    ??FrontLEDDisplay_23
        BCC.N    ??FrontLEDDisplay_24
        CMP      R0,#+5
        BEQ.N    ??FrontLEDDisplay_25
        BCC.N    ??FrontLEDDisplay_26
// 1326 				{
// 1327                     default:
// 1328 					case LED_2G_NorSel:
// 1329 						_4G_NORLED = 0;
??FrontLEDDisplay_22:
        LDR      R4,[R2, #+0]
        BIC      R4,R4,#0x800
        B.N      ??FrontLEDDisplay_11
// 1330 					break;
// 1331 
// 1332 					case LED_2G_SleepSel:
// 1333 						_4G_SLPLED = 0;
??FrontLEDDisplay_21:
        LDR      R4,[R2, #+0]
        BIC      R4,R4,#0x1000
        B.N      ??FrontLEDDisplay_11
// 1334 					break;
// 1335 
// 1336 					case LED_2G_OscSel:
// 1337 						_4G_OSCLED = 0;
??FrontLEDDisplay_24:
        LDR      R4,[R2, #+0]
        BIC      R4,R4,#0x2000
        B.N      ??FrontLEDDisplay_11
// 1338 					break;
// 1339 
// 1340 					case LED_3G_NorSel:
// 1341 						_3G_NORLED = 0;
??FrontLEDDisplay_23:
        LDR      R4,[R3, #+0]
        BIC      R4,R4,#0x1000
        B.N      ??FrontLEDDisplay_14
// 1342 					break;
// 1343 
// 1344 					case LED_3G_SleepSel:
// 1345 						_3G_SLPLED = 0;
??FrontLEDDisplay_26:
        LDR      R4,[R3, #+0]
        BIC      R4,R4,#0x2000
        B.N      ??FrontLEDDisplay_14
// 1346 					break;
// 1347 
// 1348 					case LED_3G_OscSel:
// 1349 						_3G_OSCLED = 0;
??FrontLEDDisplay_25:
        LDR      R4,[R3, #+0]
        BIC      R4,R4,#0x4000
??FrontLEDDisplay_14:
        STR      R4,[R3, #+0]
// 1350 					break;
// 1351 				}
// 1352 			break;
// 1353 		}
// 1354 	}
??FrontLEDDisplay_12:
        ADDS     R0,R0,#+1
        ADDS     R1,R1,#+1
        CMP      R0,#+6
        BLT.N    ??FrontLEDDisplay_1
??FrontLEDDisplay_0:
        POP      {R4,PC}          ;; return
// 1355 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13:
        DC32     MinAttn4G

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_1:
        DC32     tmpSleepTimeOn

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_2:
        DC32     0x8006016

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_3:
        DC32     mSleep_4G

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_4:
        DC32     0x8005f06

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_5:
        DC32     0x8005f86

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_6:
        DC32     mSDCheck_4G

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_7:
        DC32     0x8006006

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_8:
        DC32     rambackup

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_9:
        DC32     MinAttn4G+0x4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_10:
        DC32     SleepTempOffset

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_11:
        DC32     MinAttn4G+0x1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_12:
        DC32     Booting

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_13:
        DC32     0x8006800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_14:
        DC32     `?<Constant "ISO ALARM BACUPED\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_15:
        DC32     SerPtr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_16:
        DC32     mOSCCheck_4G

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_17:
        DC32     LimitAlarmCnt

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_18:
        DC32     BlinkFlag

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_19:
        DC32     0x4001140c

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13_20:
        DC32     0x4001180c

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "ISO ALARM BACUPED\\n">`:
        DATA
        DC8 "ISO ALARM BACUPED\012"
        DC8 0

        END
// 1356 
// 1357 ///////////////////////////////////////////////////////////////////////////////
// 1358 // End of Source File
// 1359 ////////////////////////
// 
//    87 bytes in section .bss
//    20 bytes in section .rodata
// 4 302 bytes in section .text
// 1 024 bytes in section iram
// 
// 4 302 bytes of CODE  memory
//    20 bytes of CONST memory
// 1 111 bytes of DATA  memory
//
//Errors: none
//Warnings: none
