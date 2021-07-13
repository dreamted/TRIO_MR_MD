///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:31 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\ALC.C /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\ALC.C /
//                     -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120109\sout\ --endian=little --cpu=Cortex-M3 -e       /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\ALC.s /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME ALC

        EXTERN ADC_DATA1
        EXTERN AdctoVolt33V
        EXTERN DownLoadGiveupTimerSet
        EXTERN MinMaxAttnCheck
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN PwrAlarm
        EXTERN ReadEnvTempTable
        EXTERN SerPtr
        EXTERN TableIndex
        EXTERN TableLocation
        EXTERN USART1Printf
        EXTERN dptr
        EXTERN tDnrSts
        EXTERN tTestFlag

        PUBLIC ADC_Init
        PUBLIC ADC_Task
        PUBLIC AGCCheck
        PUBLIC AGC_Check
        PUBLIC ALCCheck
        PUBLIC Amp1Off_LTE
        PUBLIC Amp1Off_LTE_A
        PUBLIC AmpOff_3G
        PUBLIC AmpOff_All
        PUBLIC AmpOff_Common
        PUBLIC AmpOff_LTE_A
        PUBLIC AttnCalculation
        PUBLIC ChkNorAlarmVal_2G
        PUBLIC ChkNorAlarmVal_3G
        PUBLIC ChkNorAlarmVal_LTE1
        PUBLIC ChkNorAlarmVal_LTE_A
        PUBLIC ChkNorAlarmVal_LTE_A1
        PUBLIC ChkNorAlarm_2G
        PUBLIC ChkNorAlarm_3G
        PUBLIC ChkNorAlarm_LTE1
        PUBLIC ChkNorAlarm_LTE_A
        PUBLIC ChkNorAlarm_LTE_A1
        PUBLIC DE_ReadAdcValue
        PUBLIC FwdAGCCheckFunction
        PUBLIC FwdALCCheckFunction
        PUBLIC GainAttnCalculation
        PUBLIC Local_ChkNorAlarmVal_2G
        PUBLIC Local_ChkNorAlarmVal_3G
        PUBLIC Local_ChkNorAlarmVal_LTE1
        PUBLIC Local_ChkNorAlarmVal_LTE_A1
        PUBLIC Local_ChkNorAlarm_2G
        PUBLIC Local_ChkNorAlarm_3G
        PUBLIC Local_ChkNorAlarm_LTE1
        PUBLIC Local_ChkNorAlarm_LTE_A1
        PUBLIC Local_SdBuffClear_2G
        PUBLIC Local_SdBuffClear_3G
        PUBLIC Local_SdBuffClear_LTE
        PUBLIC Local_SdBuffClear_LTE1
        PUBLIC Local_SdBuffClear_LTE_A
        PUBLIC Local_SdBuffClear_LTE_A1
        PUBLIC Local_SdStep2G
        PUBLIC Local_SdStep3G
        PUBLIC Local_SdStepLTE
        PUBLIC Local_SdStepLTE1
        PUBLIC Local_SdStepLTE_A
        PUBLIC Local_SdStepLTE_A1
        PUBLIC Local_ShutDownCheck_3G
        PUBLIC Local_ShutDownCheck_Common
        PUBLIC Local_ShutDownCheck_LTE1
        PUBLIC Local_ShutDownCheck_LTE_A1
        PUBLIC OneOutPwrConv
        PUBLIC ReadPwrTableDnr
        PUBLIC RvsALCCheckCommon
        PUBLIC RvsALCCheckFunction
        PUBLIC RvsNFGain
        PUBLIC SdBuffClear_2G
        PUBLIC SdBuffClear_3G
        PUBLIC SdBuffClear_LTE1
        PUBLIC SdBuffClear_LTE_A
        PUBLIC SdBuffClear_LTE_A1
        PUBLIC SdChekcTime_2G
        PUBLIC SdChekcTime_3G
        PUBLIC SdChekcTime_LTE1
        PUBLIC SdChekcTime_LTE_A
        PUBLIC SdChekcTime_LTE_A1
        PUBLIC SdNormalCnt_2G
        PUBLIC SdNormalCnt_3G
        PUBLIC SdNormalCnt_LTE1
        PUBLIC SdNormalCnt_LTE_A
        PUBLIC SdNormalCnt_LTE_A1
        PUBLIC SdStep_2G
        PUBLIC SdStep_3G
        PUBLIC SdStep_LTE1
        PUBLIC SdStep_LTE_A
        PUBLIC SdStep_LTE_A1
        PUBLIC ShutDownCheck
        PUBLIC ShutDownCheck_3G
        PUBLIC ShutDownCheck_Common
        PUBLIC ShutDownCheck_LTE1
        PUBLIC ShutDownCheck_LTE_A
        PUBLIC ShutDownCheck_LTE_A1
        PUBLIC Table_Operation
        PUBLIC TemptoIndex
        PUBLIC TwoOutPwrConv
        PUBLIC __1st_ReadPwrTable
        PUBLIC __2st_ReadPwrTable
        PUBLIC chkALCAtt
        PUBLIC tempIndexHys

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\ALC.C
//    1 
//    2 /*********************************************
//    3 * File Name          : alc.c
//    4 * Author             :
//    5 * Date First Issued  : 10/20/2010
//    6 * Description        : This file provides all the port/input/update firmware functions.
//    7 * $Revision: 0.1 $
//    8 * $Revision date: 2010.10.__
//    9 ********************************************************************************/
//   10 
//   11 #define ALC_C
//   12 
//   13 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// static OS_STK __data AdcTaskStk[256]
AdcTaskStk:
        DS8 1024

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data tempIndexHys
tempIndexHys:
        DS8 1

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data ChkNorAlarm_2G
ChkNorAlarm_2G:
        DATA
        DC8 0
// INT8U __data ChkNorAlarmVal_2G
ChkNorAlarmVal_2G:
        DC8 0
// INT8U __data SdStep_2G
SdStep_2G:
        DC8 0
// INT8U __data SdBuffClear_2G
SdBuffClear_2G:
        DC8 1
// INT8U __data SdNormalCnt_2G
SdNormalCnt_2G:
        DC8 0
        DC8 0, 0, 0
// INT32U __data SdChekcTime_2G
SdChekcTime_2G:
        DC32 0

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data ChkNorAlarm_3G
ChkNorAlarm_3G:
        DATA
        DC8 0
// INT8U __data ChkNorAlarmVal_3G
ChkNorAlarmVal_3G:
        DC8 0
// INT8U __data SdStep_3G
SdStep_3G:
        DC8 0
// INT8U __data SdBuffClear_3G
SdBuffClear_3G:
        DC8 1
// INT8U __data SdNormalCnt_3G
SdNormalCnt_3G:
        DC8 0
        DC8 0, 0, 0
// INT32U __data SdChekcTime_3G
SdChekcTime_3G:
        DC32 0

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data ChkNorAlarm_LTE_A
ChkNorAlarm_LTE_A:
        DATA
        DC8 0
// INT8U __data ChkNorAlarmVal_LTE_A
ChkNorAlarmVal_LTE_A:
        DC8 0
// INT8U __data SdStep_LTE_A
SdStep_LTE_A:
        DC8 0
// INT8U __data SdBuffClear_LTE_A
SdBuffClear_LTE_A:
        DC8 1
// INT8U __data SdNormalCnt_LTE_A
SdNormalCnt_LTE_A:
        DC8 0
        DC8 0, 0, 0
// INT32U __data SdChekcTime_LTE_A
SdChekcTime_LTE_A:
        DC32 0

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data ChkNorAlarm_LTE1
ChkNorAlarm_LTE1:
        DATA
        DC8 0
// INT8U __data ChkNorAlarmVal_LTE1
ChkNorAlarmVal_LTE1:
        DC8 0
// INT8U __data SdStep_LTE1
SdStep_LTE1:
        DC8 0
// INT8U __data SdBuffClear_LTE1
SdBuffClear_LTE1:
        DC8 1
// INT8U __data SdNormalCnt_LTE1
SdNormalCnt_LTE1:
        DC8 0
        DC8 0, 0, 0
// INT32U __data SdChekcTime_LTE1
SdChekcTime_LTE1:
        DC32 0

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data ChkNorAlarm_LTE_A1
ChkNorAlarm_LTE_A1:
        DATA
        DC8 0
// INT8U __data ChkNorAlarmVal_LTE_A1
ChkNorAlarmVal_LTE_A1:
        DC8 0
// INT8U __data SdStep_LTE_A1
SdStep_LTE_A1:
        DC8 0
// INT8U __data SdBuffClear_LTE_A1
SdBuffClear_LTE_A1:
        DC8 1
// INT8U __data SdNormalCnt_LTE_A1
SdNormalCnt_LTE_A1:
        DC8 0
        DC8 0, 0, 0
// INT32U __data SdChekcTime_LTE_A1
SdChekcTime_LTE_A1:
        DC32 0

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkALCAtt
chkALCAtt:
        DS8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data Local_ChkNorAlarm_2G
Local_ChkNorAlarm_2G:
        DATA
        DC8 0
// INT8U __data Local_ChkNorAlarmVal_2G
Local_ChkNorAlarmVal_2G:
        DC8 0
// INT8U __data Local_SdStep2G
Local_SdStep2G:
        DC8 0
// INT8U __data Local_SdBuffClear_2G
Local_SdBuffClear_2G:
        DC8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data Local_ChkNorAlarm_3G
Local_ChkNorAlarm_3G:
        DATA
        DC8 0
// INT8U __data Local_ChkNorAlarmVal_3G
Local_ChkNorAlarmVal_3G:
        DC8 0
// INT8U __data Local_SdStep3G
Local_SdStep3G:
        DC8 0
// INT8U __data Local_SdBuffClear_3G
Local_SdBuffClear_3G:
        DC8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data Local_SdStepLTE
Local_SdStepLTE:
        DS8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data Local_SdBuffClear_LTE
Local_SdBuffClear_LTE:
        DATA
        DC8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data Local_SdStepLTE_A
Local_SdStepLTE_A:
        DS8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data Local_SdBuffClear_LTE_A
Local_SdBuffClear_LTE_A:
        DATA
        DC8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data Local_ChkNorAlarm_LTE1
Local_ChkNorAlarm_LTE1:
        DATA
        DC8 0
// INT8U __data Local_ChkNorAlarmVal_LTE1
Local_ChkNorAlarmVal_LTE1:
        DC8 0
// INT8U __data Local_SdStepLTE1
Local_SdStepLTE1:
        DC8 0
// INT8U __data Local_SdBuffClear_LTE1
Local_SdBuffClear_LTE1:
        DC8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data Local_ChkNorAlarm_LTE_A1
Local_ChkNorAlarm_LTE_A1:
        DATA
        DC8 0
// INT8U __data Local_ChkNorAlarmVal_LTE_A1
Local_ChkNorAlarmVal_LTE_A1:
        DC8 0
// INT8U __data Local_SdStepLTE_A1
Local_SdStepLTE_A1:
        DC8 0
// INT8U __data Local_SdBuffClear_LTE_A1
Local_SdBuffClear_LTE_A1:
        DC8 1
//   14 
//   15 #include <stdlib.h>
//   16 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   17 void ADC_Init(void)
//   18 {
//   19 	OSTaskCreate(ADC_Task, (void *)0, (OS_STK *)&AdcTaskStk[ADC_START_STK_SIZE - 1],ADC_START_PRIO);
ADC_Init:
        MOVS     R3,#+4
        LDR.N    R2,??ADC_Init_0  ;; AdcTaskStk + 1020
        MOVS     R1,#+0
        LDR.N    R0,??ADC_Init_0+0x4  ;; ADC_Task
        B.W      OSTaskCreate
        DATA
??ADC_Init_0:
        DC32     AdcTaskStk + 1020
        DC32     ADC_Task
//   20 }
//   21 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   22 void ADC_Task(void * pdata)
//   23 {
ADC_Task:
        PUSH     {R4,LR}
//   24 	pdata = pdata;
//   25 
//   26 	OSTimeDly(1000L*1L);
        MOV      R0,#+1000
        BL       OSTimeDly
        LDR.N    R4,??ADC_Task_0  ;; tTestFlag
        B.N      ??ADC_Task_1
//   27 	while(1)
//   28 	{
//   29 		while((DownLoadGiveupTimerSet(NULL)))
//   30 		{
//   31 			OSTimeDly(1000L);
??ADC_Task_2:
        MOV      R0,#+1000
        BL       OSTimeDly
//   32 		}
??ADC_Task_1:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CMP      R0,#+0
        BNE.N    ??ADC_Task_2
//   33 
//   34 		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
??ADC_Task_3:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CMP      R0,#+0
        BNE.N    ??ADC_Task_2
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BNE.N    ??ADC_Task_2
//   35 		{
//   36 #if 0
//   37 			if(chkADCStart)
//   38 			{
//   39 				ADC_Select(iAdcIndex);
//   40 				chkADCStart = 0;
//   41 				OSTimeDly(1L*1L);
//   42 			}
//   43 #endif			
//   44 
//   45 
//   46 			DE_ReadAdcValue();
        BL       DE_ReadAdcValue
//   47 			OSTimeDly(100L*20L);
        MOV      R0,#+2000
        BL       OSTimeDly
        B.N      ??ADC_Task_3
        Nop      
        DATA
??ADC_Task_0:
        DC32     tTestFlag
//   48 		}
//   49 
//   50 //		OSTimeDly(5L*1L);
//   51 		OSTimeDly(1000L*1L);
//   52 	}
//   53 }
//   54 
//   55 
//   56 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   57 INT8S OneOutPwrConv(INT8S *Vaule) 
//   58 {
//   59 	INT8S dval;
//   60 	dval  = Vaule[0]*2;
OneOutPwrConv:
        LDRSB    R1,[R0, #+0]
        LSLS     R2,R1,#+1
        SXTB     R2,R2
//   61 	if(Vaule[0] < 0)
        LDRSB    R0,[R0, #+1]
        MOVS     R3,#+5
        CMP      R1,#+0
        BPL.N    ??OneOutPwrConv_0
//   62 	{
//   63 		dval -= abs(Vaule[1])/5;
        CMP      R0,#+0
        BPL.N    ??OneOutPwrConv_1
        RSBS     R0,R0,#+0
//   64 	}
??OneOutPwrConv_1:
        SDIV     R0,R0,R3
        SUBS     R0,R2,R0
        B.N      ??OneOutPwrConv_2
//   65 	else
//   66 	{
//   67 		dval += Vaule[1]/5;
??OneOutPwrConv_0:
        SDIV     R0,R0,R3
        ADDS     R0,R0,R2
??OneOutPwrConv_2:
        SXTB     R0,R0
//   68 	}
//   69 
//   70 	return dval;
        BX       LR               ;; return
//   71 }
//   72 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   73 void TwoOutPwrConv(INT8S *dptr, INT8S Vaule)
//   74 {
//   75 	dptr[0]	= (Vaule   )/2L ;
TwoOutPwrConv:
        ADD      R2,R1,R1, LSR #+31
        ASRS     R2,R2,#+1
        STRB     R2,[R0, #+0]
//   76 	dptr[1] = ((Vaule%2L)*5L) ;
        SUB      R2,R1,R2, LSL #+1
        MOVS     R3,#+5
        MULS     R2,R2,R3
        STRB     R2,[R0, #+1]
//   77 }
        BX       LR               ;; return
//   78 
//   79 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   80 INT8S Table_Operation(INT8S Pwr,INT8S tGain,INT8S tAttn,INT8S tOffset)
//   81 {
Table_Operation:
        PUSH     {R3,R4}
        MOV      R4,R0
//   82 	INT8S retval;
//   83 	if(Pwr != (-60*2))
        MVN      R0,#+119
        CMP      R4,R0
        BEQ.N    ??Table_Operation_0
//   84 	{
//   85 		retval = Pwr + (tGain - tAttn) + tOffset;
        ADDS     R0,R1,R4
        SUBS     R0,R0,R2
        ADDS     R0,R3,R0
//   86 	}
//   87 	else retval = (-60*2);
//   88 
//   89 	return retval;
??Table_Operation_0:
        SXTB     R0,R0
        POP      {R1,R4}
        BX       LR               ;; return
//   90 }
//   91 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   92 void DE_ReadAdcValue(void)
//   93 {
DE_ReadAdcValue:
        PUSH     {R3-R11,LR}
//   94 	__Dnr_Sts *Sts = tDnrSts;
        LDR.W    R0,??DataTable1  ;; tDnrSts
        LDR      R8,[R0, #+0]
//   95 //	INT32S tmpx10;
//   96 	INT8S tmppwr = 0;
//   97 	INT8U isminval = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//   98 
//   99     tmppwr = tmppwr;
//  100 //	Sts->CurrentTemp = ReadEnvTempTable(ADC_Channel_15)/10+ Sts->TempOffset;
//  101 	Sts->CurrentTemp = ReadEnvTempTable(Curr_Temp)/10+ Sts->TempOffset;
        MOVS     R0,#+17
        BL       ReadEnvTempTable
        MOVS     R1,#+10
        SDIV     R0,R0,R1
        ADD      R1,R8,#+73
        LDRB     R1,[R1, #+31]
        ADDS     R0,R1,R0
        STRB     R0,[R8, #+149]
//  102 
//  103 	Sts->DetVolt.PAU27VVolt.Data			= AdctoVolt33V(ADC_DATA1[Curr_Temp]);
        ADD      R7,R8,#+227
        LDR.W    R5,??DE_ReadAdcValue_0  ;; ADC_DATA1
        LDRH     R0,[R5, #+34]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+58]
//  104 
//  105 #if 1
//  106 
//  107 
//  108 	Sts->DetVolt.FwdAgcAvgVolt_2G.Data		= AdctoVolt33V(ADC_DATA1[FwdAgcAvgVolt_2G]);
        LDRH     R0,[R5, #+0]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+4]
//  109 	Sts->DetVolt.FwdAgcPeakVolt_2G.Data 	= AdctoVolt33V(ADC_DATA1[FwdAgcPeakVolt_2G]);
        LDRH     R0,[R5, #+2]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+6]
//  110 	Sts->DetVolt.FwdAgcAvgVolt_LTE.Data 	= AdctoVolt33V(ADC_DATA1[FwdAgcAvgVolt_LTE]);
        LDRH     R0,[R5, #+4]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+28]
//  111 	Sts->DetVolt.FwdAgcPeakVolt_LTE.Data	= AdctoVolt33V(ADC_DATA1[FwdAgcPeakVolt_LTE]);
        LDRH     R0,[R5, #+6]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+30]
//  112 	Sts->DetVolt.FwdOutAvgVolt_Common.Data	= AdctoVolt33V(ADC_DATA1[FwdOutAvgVolt_Common]);
        LDRH     R0,[R5, #+8]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+10]
//  113 	Sts->DetVolt.FwdAgcAvgVolt_LTE_A.Data	= AdctoVolt33V(ADC_DATA1[FwdAgcAvgVolt_LTE_A]);
        LDRH     R0,[R5, #+10]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+42]
//  114 	Sts->DetVolt.FwdAgcPeakVolt_LTE_A.Data	= AdctoVolt33V(ADC_DATA1[FwdAgcPeakVolt_LTE_A]);
        LDRH     R0,[R5, #+12]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+44]
//  115 	Sts->DetVolt.FwdOutAvgVolt_3G.Data		= AdctoVolt33V(ADC_DATA1[FwdOutAvgVolt_3G]);
        LDRH     R0,[R5, #+20]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+48]
//  116 	Sts->DetVolt.FwdOutPeakVolt_3G.Data 	= AdctoVolt33V(ADC_DATA1[FwdOutPeakVolt_3G]);
        LDRH     R0,[R5, #+22]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+50]
//  117 	Sts->DetVolt.RvsInVolt_2G.Data			= AdctoVolt33V(ADC_DATA1[RvsInVolt_2G]);
        LDRH     R0,[R5, #+26]
        BL       AdctoVolt33V
        STRH     R0,[R8, #+227]
//  118 	Sts->DetVolt.RvsInVolt_3G.Data			= AdctoVolt33V(ADC_DATA1[RvsInVolt_3G]);
        LDRH     R0,[R5, #+28]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+52]
//  119 	Sts->DetVolt.RvsInVolt_LTE_A.Data		= AdctoVolt33V(ADC_DATA1[RvsInVolt_LTE_A]);
        LDRH     R0,[R5, #+38]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+38]
//  120 	Sts->DetVolt.RvsOutVolt_Common.Data 	= AdctoVolt33V(ADC_DATA1[RvsOutVolt_Common]);
        LDRH     R0,[R5, #+40]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+16]
//  121 	Sts->DetVolt.FwdInVolt_LTE_A.Data		= AdctoVolt33V(ADC_DATA1[FwdInVolt_LTE_A]);
        LDRH     R0,[R5, #+44]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+32]
//  122 	Sts->DetVolt.PSUDCVolt.Data 			= AdctoVolt33V(ADC_DATA1[PSUDCVolt]);
        LDRH     R0,[R5, #+46]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+56]
//  123 	Sts->DetVolt.RvsOutVolt_LTE_A.Data		= AdctoVolt33V(ADC_DATA1[RvsOutVolt_LTE_A]);
        LDRH     R0,[R5, #+50]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+40]
//  124 	Sts->DetVolt.RvsInVolt_LTE.Data 		= AdctoVolt33V(ADC_DATA1[RvsInVolt_LTE]);
        LDRH     R0,[R5, #+52]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+24]
//  125 	Sts->DetVolt.FwdInVolt_3G.Data			= AdctoVolt33V(ADC_DATA1[FwdInVolt_3G]);
        LDRH     R0,[R5, #+56]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+46]
//  126 	Sts->DetVolt.DCOutVolt.Data 			= AdctoVolt33V(ADC_DATA1[DCOutVolt]);
        LDRH     R0,[R5, #+58]
        BL       AdctoVolt33V
        STRH     R0,[R8, #+295]
//  127 	Sts->DetVolt.RvsInVolt_Common.Data		= AdctoVolt33V(ADC_DATA1[RvsInVolt_Common]);
        LDRH     R0,[R5, #+60]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+14]
//  128 	Sts->DetVolt.RvsOutVolt_3G.Data 		= AdctoVolt33V(ADC_DATA1[RvsOutVolt_3G]);
        LDRH     R0,[R5, #+64]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+54]
//  129 	Sts->DetVolt.FwdInVolt_Common.Data		= AdctoVolt33V(ADC_DATA1[FwdInVolt_Common]);
        LDRH     R0,[R5, #+32]
        BL       AdctoVolt33V
        STRH     R0,[R7, #+8]
//  130 
//  131 
//  132 	Sts->Det1Volt.Fwd1AgcAvgVolt_LTE.Data		= AdctoVolt33V(ADC_DATA1[Fwd1AgcAvgVolt_LTE]);
        ADDW     R10,R8,#+655
        LDRH     R0,[R5, #+14]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+36]
//  133 	Sts->Det1Volt.Fwd1AgcPeakVolt_LTE.Data		= AdctoVolt33V(ADC_DATA1[Fwd1AgcPeakVolt_LTE]);
        LDRH     R0,[R5, #+16]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+38]
//  134 	Sts->Det1Volt.Rvs1InVolt_LTE.Data			= AdctoVolt33V(ADC_DATA1[Rvs1InVolt_LTE]);
        LDRH     R0,[R5, #+30]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+32]
//  135 	Sts->Det1Volt.Fwd1InVolt_LTE.Data			= AdctoVolt33V(ADC_DATA1[Fwd1InVolt_LTE]);
        LDRH     R0,[R5, #+36]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+26]
//  136 	Sts->Det1Volt.Rvs1OutVolt_LTE.Data			= AdctoVolt33V(ADC_DATA1[Rvs1OutVolt_LTE]);
        LDRH     R0,[R5, #+54]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+34]
//  137 
//  138 	Sts->Det1Volt.Fwd1AgcAvgVolt_LTE_A.Data 	= AdctoVolt33V(ADC_DATA1[Fwd1AgcAvgVolt_LTE_A]);
        LDRH     R0,[R5, #+18]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+46]
//  139 	Sts->Det1Volt.Fwd1AgcPeakVolt_LTE_A.Data	= AdctoVolt33V(ADC_DATA1[Fwd1AgcPeakVolt_LTE_A]);
        LDRH     R0,[R5, #+24]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+48]
//  140 	Sts->Det1Volt.Rvs1InVolt_LTE_A.Data 		= AdctoVolt33V(ADC_DATA1[Rvs1InVolt_LTE_A]);
        LDRH     R0,[R5, #+42]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+50]
//  141 	Sts->Det1Volt.Fwd1InVolt_LTE_A.Data 		= AdctoVolt33V(ADC_DATA1[Fwd1InVolt_LTE_A]);
        LDRH     R0,[R5, #+48]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+40]
//  142 	Sts->Det1Volt.Rvs1OutVolt_LTE_A.Data		= AdctoVolt33V(ADC_DATA1[Rvs1OutVolt_LTE_A]);
        ADD      R0,R5,#+64
        LDRH     R0,[R0, #+2]
        BL       AdctoVolt33V
        STRH     R0,[R10, #+52]
//  143 
//  144 
//  145 	Sts->DetPwr.FwdAgcAvg_2G	 = ReadPwrTableDnr(Sts->DetVolt.FwdAgcAvgVolt_2G.Data ,Index_FwdAgcAvgPwr_2G,FALSE,&isminval, Sts->DetOffset.FwdAgcAvg_2G); 
        ADDW     R5,R8,#+295
        LDRSB    R0,[R5, #+26]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+6
        LDRH     R0,[R7, #+4]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+4]
//  146 	Sts->DetPwr.FwdAgcPeak_2G	 = ReadPwrTableDnr(Sts->DetVolt.FwdAgcPeakVolt_2G.Data ,Index_FwdAgcPeakPwr_2G,FALSE,&isminval, Sts->DetOffset.FwdAgcPeak_2G); 
        LDRSB    R0,[R5, #+27]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+7
        LDRH     R0,[R7, #+6]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+5]
//  147 	Sts->DetPwr.FwdAgcAvg_LTE	 = ReadPwrTableDnr(Sts->DetVolt.FwdAgcAvgVolt_LTE.Data ,Index_FwdAgcAvgPwr_LTE,FALSE,&isminval, Sts->DetOffset.FwdAgcAvg_LTE); 
        LDRSB    R0,[R5, #+35]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+20
        LDRH     R0,[R7, #+28]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+13]
//  148 	Sts->DetPwr.FwdAgcPeak_LTE	 = ReadPwrTableDnr(Sts->DetVolt.FwdAgcPeakVolt_LTE.Data ,Index_FwdAgcPeakPwr_LTE,FALSE,&isminval, Sts->DetOffset.FwdAgcPeak_LTE); 
        LDRSB    R0,[R5, #+36]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+21
        LDRH     R0,[R7, #+30]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+14]
//  149 	Sts->DetPwr.FwdAgcAvg_LTE_A  = ReadPwrTableDnr(Sts->DetVolt.FwdAgcAvgVolt_LTE_A.Data ,Index_FwdAgcAvgPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdAgcAvg_LTE_A); 
        LDRSB    R0,[R5, #+39]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+27
        LDRH     R0,[R7, #+42]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+17]
//  150 	Sts->DetPwr.FwdAgcPeak_LTE_A = ReadPwrTableDnr(Sts->DetVolt.FwdAgcPeakVolt_LTE_A.Data ,Index_FwdAgcPeakPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdAgcPeak_LTE_A); 
        LDRSB    R0,[R5, #+40]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+28
        LDRH     R0,[R7, #+44]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+18]
//  151 	Sts->DetPwr.FwdOutAvg_3G	 = ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_3G.Data ,Index_FwdOutAvgPwr_3G,FALSE,&isminval, Sts->DetOffset.FwdOutAvg_3G); 
        LDRSB    R0,[R5, #+41]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+30
        LDRH     R0,[R7, #+48]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+19]
//  152 	Sts->DetPwr.FwdOutPeak_3G	 = ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_3G.Data ,Index_FwdOutPeakPwr_3G,FALSE,&isminval, Sts->DetOffset.FwdOutPeak_3G); 
        LDRSB    R0,[R5, #+42]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+31
        LDRH     R0,[R7, #+50]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+20]
        ADDW     R0,R8,#+711
        LDRSB    R0,[R0, #+8]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+106
        LDRH     R0,[R10, #+36]
//  153 
//  154 	Sts->Det1Pwr.Fwd1AgcAvg_LTE  = ReadPwrTableDnr(Sts->Det1Volt.Fwd1AgcAvgVolt_LTE.Data ,Index_Fwd1AgcAvgPwr_LTE,FALSE,&isminval, Sts->Det1Offset.Fwd1AgcAvg_LTE); 
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R8, #+711]
//  155 	Sts->Det1Pwr.Fwd1AgcPeak_LTE = ReadPwrTableDnr(Sts->Det1Volt.Fwd1AgcPeakVolt_LTE.Data ,Index_Fwd1AgcPeakPwr_LTE,FALSE,&isminval, Sts->Det1Offset.Fwd1AgcPeak_LTE); 
        ADDW     R0,R8,#+711
        LDRSB    R0,[R0, #+9]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+107
        LDRH     R0,[R10, #+38]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        ADDW     R1,R8,#+711
        STRB     R0,[R1, #+1]
//  156 
//  157 	Sts->Det1Pwr.Fwd1AgcAvg_LTE_A  = ReadPwrTableDnr(Sts->Det1Volt.Fwd1AgcAvgVolt_LTE_A.Data ,Index_Fwd1AgcAvgPwr_LTE_A,FALSE,&isminval, Sts->Det1Offset.Fwd1AgcAvg_LTE_A); 
        ADDW     R0,R8,#+711
        LDRSB    R0,[R0, #+12]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+113
        LDRH     R0,[R10, #+46]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        ADDW     R1,R8,#+711
        STRB     R0,[R1, #+4]
//  158 	Sts->Det1Pwr.Fwd1AgcPeak_LTE_A = ReadPwrTableDnr(Sts->Det1Volt.Fwd1AgcPeakVolt_LTE_A.Data ,Index_Fwd1AgcPeakPwr_LTE_A,FALSE,&isminval, Sts->Det1Offset.Fwd1AgcPeak_LTE_A); 
        ADDW     R0,R8,#+711
        LDRSB    R0,[R0, #+13]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+114
        LDRH     R0,[R10, #+48]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        ADDW     R1,R8,#+711
        STRB     R0,[R1, #+5]
//  159 
//  160 
//  161 	Sts->DetPwr.FwdIn_Common			= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_Common.Data ,Index_FwdInPwr_Common,FALSE,&isminval, Sts->DetOffset.FwdIn_Common); 
        LDRSB    R0,[R5, #+28]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+8
        LDRH     R0,[R7, #+8]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+6]
//  162 	Sts->DetPwr.FwdOutAvg_Common		= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_Common.Data ,Index_FwdOutAvgPwr_Common,FALSE,&isminval, Sts->DetOffset.FwdOutAvg_LTE); 
        LDRSB    R0,[R5, #+33]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+9
        LDRH     R0,[R7, #+10]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+7]
//  163 	Sts->DetPwr.RvsIn_Common			= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_Common.Data ,Index_RvsInPwr_Common,FALSE,&isminval, Sts->DetOffset.RvsIn_Common); 
        LDRSB    R0,[R5, #+31]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+11
        LDRH     R0,[R7, #+14]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+9]
//  164 	Sts->DetPwr.RvsOut_Common			= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_Common.Data ,Index_RvsOutPwr_Common,FALSE,&isminval, Sts->DetOffset.RvsOut_Common); 
        LDRSB    R0,[R5, #+32]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+12
        LDRH     R0,[R7, #+16]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R5, #+10]
//  165 
//  166 	Sts->Det2Pwr.DetFwdInPwr_3G 		= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_3G.Data ,Index_FwdInPwr_3G,FALSE,&isminval, Sts->Det2Offset.DetFwdInPwr_3G); 
        ADDW     R6,R8,#+533
        LDRSB    R0,[R6, #+25]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+29
        LDRH     R0,[R7, #+46]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+9]
//  167 	Sts->Det2Pwr.DetFwdInPwr_LTE_A 		= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_LTE_A.Data ,Index_FwdInPwr_LTE_A,FALSE,&isminval, Sts->Det2Offset.DetFwdInPwr_LTE_A); 
        LDRSB    R0,[R6, #+24]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+22
        LDRH     R0,[R7, #+32]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+8]
//  168 	Sts->Det2Pwr.DetFwd1InPwr_LTE		= ReadPwrTableDnr(Sts->Det1Volt.Fwd1InVolt_LTE.Data ,Index_Fwd1InPwr_LTE,FALSE,&isminval, Sts->Det2Offset.DetFwd1InPwr_LTE); 
        LDRSB    R0,[R6, #+26]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+101
        LDRH     R0,[R10, #+26]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+10]
//  169 	Sts->Det2Pwr.DetFwd1InPwr_LTE_A 	= ReadPwrTableDnr(Sts->Det1Volt.Fwd1InVolt_LTE_A.Data ,Index_Fwd1InPwr_LTE_A,FALSE,&isminval, Sts->Det2Offset.DetFwd1InPwr_LTE_A); 
        LDRSB    R0,[R6, #+27]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+108
        LDRH     R0,[R10, #+40]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+11]
//  170 
//  171 	Sts->Det2Pwr.DetRvsInPwr_3G 		= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_3G.Data ,Index_RvsInPwr_3G,FALSE,&isminval, Sts->Det2Offset.DetRvsInPwr_3G); 
        LDRSB    R0,[R6, #+30]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+32
        LDRH     R0,[R7, #+52]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+14]
//  172 	Sts->Det2Pwr.DetRvsInPwr_LTE_A		= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_LTE_A.Data ,Index_RvsInPwr_LTE_A,FALSE,&isminval, Sts->Det2Offset.DetRvsInPwr_LTE_A); 
        LDRSB    R0,[R6, #+29]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+25
        LDRH     R0,[R7, #+38]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+13]
//  173 	Sts->Det2Pwr.DetRvs1InPwr_LTE		= ReadPwrTableDnr(Sts->Det1Volt.Rvs1InVolt_LTE.Data ,Index_Rvs1InPwr_LTE,FALSE,&isminval, Sts->Det2Offset.DetRvs1InPwr_LTE); 
        LDRSB    R0,[R6, #+31]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+104
        LDRH     R0,[R10, #+32]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+15]
//  174 	Sts->Det2Pwr.DetRvs1InPwr_LTE_A 	= ReadPwrTableDnr(Sts->Det1Volt.Rvs1InVolt_LTE_A.Data ,Index_Rvs1InPwr_LTE_A,FALSE,&isminval, Sts->Det2Offset.DetRvs1InPwr_LTE_A); 
        LDRSB    R0,[R6, #+32]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+111
        LDRH     R0,[R10, #+50]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+16]
//  175 
//  176 	Sts->Det2Pwr.RvsAlcInPwr_2G			= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_2G.Data ,Index_RvsOutPwr_2G,FALSE,&isminval, Sts->Det2Offset.RvsAlcInPwr_2G); 
        LDRSB    R0,[R6, #+33]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+5
        LDRH     R0,[R7, #+2]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+17]
//  177 	Sts->Det2Pwr.RvsAlcInPwr_LTE		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE.Data ,Index_RvsOutPwr_LTE,FALSE,&isminval, Sts->Det2Offset.RvsAlcInPwr_LTE); 
        LDRSB    R0,[R6, #+34]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+17
        LDRH     R0,[R7, #+26]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+18]
//  178 	Sts->Det2Pwr.RvsAlcInPwr_LTE_A 		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE_A.Data ,Index_RvsOutPwr_LTE_A,FALSE,&isminval, Sts->Det2Offset.RvsAlcInPwr_LTE_A); 
        LDRSB    R0,[R6, #+35]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+26
        LDRH     R0,[R7, #+40]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+19]
//  179 	Sts->Det2Pwr.RvsAlcInPwr_3G			= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_3G.Data ,Index_RvsOutPwr_3G,FALSE,&isminval, Sts->Det2Offset.RvsAlcInPwr_3G); 
        LDRSB    R0,[R6, #+36]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+33
        LDRH     R0,[R7, #+54]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+20]
//  180 	Sts->Det2Pwr.Rvs1AlcInPwr_LTE		= ReadPwrTableDnr(Sts->Det1Volt.Rvs1OutVolt_LTE.Data ,Index_Rvs1OutPwr_LTE,FALSE,&isminval, Sts->Det2Offset.Rvs1AlcInPwr_LTE); 
        LDRSB    R0,[R6, #+37]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+105
        LDRH     R0,[R10, #+34]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+21]
//  181 	Sts->Det2Pwr.Rvs1AlcInPwr_LTE_A 	= ReadPwrTableDnr(Sts->Det1Volt.Rvs1OutVolt_LTE_A.Data ,Index_Rvs1OutPwr_LTE_A,FALSE,&isminval, Sts->Det2Offset.Rvs1AlcInPwr_LTE_A); 
        LDRSB    R0,[R6, #+38]
        PUSH     {R0,LR}
        ADD      R3,SP,#+8
        MOVS     R2,#+0
        MOVS     R1,#+112
        LDRH     R0,[R10, #+52]
        BL       ReadPwrTableDnr
        ADD      SP,SP,#+8
        STRB     R0,[R6, #+22]
//  182 
//  183 
//  184 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_2G;
//  185 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDR.N    R7,??DE_ReadAdcValue_0+0x4  ;; dptr
        LDRSB    R1,[R6, #+17]
        MOV      R0,R7
        BL       TwoOutPwrConv
        ADD      R0,R8,#+194
        LDRB     R1,[R7, #+0]
        STRB     R1,[R0, #+4]
//  186 	Sts->RvsOutPwr_2G[0] = dptr[0];
//  187 	Sts->RvsOutPwr_2G[1] = dptr[1];
        LDRB     R1,[R7, #+1]
        STRB     R1,[R0, #+5]
//  188 
//  189 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_2G - Gain_2G + Sts->RvsAlcAttn_2G;
        ADD      R4,R8,#+464
        LDRB     R0,[R6, #+17]
        LDRB     R1,[R4, #+4]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+110
        SXTB     R9,R0
//  190 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        MOV      R1,R9
        MOV      R0,R7
        BL       TwoOutPwrConv
//  191 	Sts->RvsInPwr_2G[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+19]
//  192 	Sts->RvsInPwr_2G[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+20]
//  193 	Sts->CurrRvsInPwr_2G = tmppwr;
        STRB     R9,[R4, #+21]
//  194 
//  195 
//  196 	//// 'CDMA Rx 입력: DET -73+ALC ATT+타사 과입력 ALC ATT
//  197 	//// CDMA Rx 출력 : DET -AGC ATT-G/B ATT-타사 과입력 ALC ATT
//  198 
//  199 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_LTE;
//  200 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRSB    R1,[R6, #+18]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  201 	Sts->RvsOutPwr_LTE[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+14]
//  202 	Sts->RvsOutPwr_LTE[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+15]
//  203 
//  204 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_LTE- Gain_2G + Sts->RvsAlcAttn_LTE;
        LDRB     R0,[R6, #+18]
        LDRB     R1,[R4, #+5]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+110
        SXTB     R9,R0
//  205 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        MOV      R1,R9
        MOV      R0,R7
        BL       TwoOutPwrConv
//  206 	Sts->RvsInPwr_LTE[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+22]
//  207 	Sts->RvsInPwr_LTE[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+23]
//  208 	Sts->CurrRvsInPwr_LTE = tmppwr;
        STRB     R9,[R4, #+24]
//  209 
//  210 
//  211 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_LTE_A;
//  212 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRSB    R1,[R6, #+19]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  213 	Sts->RvsOutPwr_LTE_A[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+17]
//  214 	Sts->RvsOutPwr_LTE_A[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+18]
//  215 
//  216 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_LTE_A - Gain_LTE + Sts->RvsAlcAttn_LTE_A;
//  217 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRB     R0,[R6, #+19]
        LDRB     R1,[R4, #+6]
        ADDS     R0,R1,R0
        ADD      R1,R0,#+110
        SXTB     R1,R1
        MOV      R0,R7
        BL       TwoOutPwrConv
//  218 	Sts->RvsInPwr_LTE_A[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+25]
//  219 	Sts->RvsInPwr_LTE_A[1]	= dptr[1];	
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+26]
//  220 
//  221 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_3G;
//  222 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRSB    R1,[R6, #+20]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  223 	Sts->RvsOutPwr_3G[0] = dptr[0];
        ADD      R0,R8,#+194
        LDRB     R1,[R7, #+0]
        STRB     R1,[R0, #+2]
//  224 	Sts->RvsOutPwr_3G[1] = dptr[1];
        LDRB     R1,[R7, #+1]
        STRB     R1,[R0, #+3]
//  225 
//  226 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_3G - Gain_3G + Sts->RvsAlcAttn_3G;
//  227 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRB     R0,[R6, #+20]
        LDRB     R1,[R4, #+7]
        ADDS     R0,R1,R0
        ADD      R1,R0,#+90
        SXTB     R1,R1
        MOV      R0,R7
        BL       TwoOutPwrConv
//  228 	Sts->RvsInPwr_3G[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+28]
//  229 	Sts->RvsInPwr_3G[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+29]
//  230 
//  231 
//  232 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_2G;
//  233 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRSB    R1,[R6, #+17]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  234 	Sts->RvsOutPwr_2G[0]	= dptr[0];
        ADD      R0,R8,#+194
        LDRB     R1,[R7, #+0]
        STRB     R1,[R0, #+4]
//  235 	Sts->RvsOutPwr_2G[1]	= dptr[1];
        LDRB     R1,[R7, #+1]
        STRB     R1,[R0, #+5]
//  236 
//  237 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_2G - Sts->FwdAgcAttn_2G - Sts->RvsGainBalance_2G - Sts->OtherFwdAlcAttn_2G;
//  238 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        ADDW     R9,R8,#+501
        LDRB     R0,[R6, #+17]
        LDRB     R1,[R8, #+464]
        SUBS     R0,R0,R1
        LDRSB    R1,[R8, #+73]
        SUBS     R0,R0,R1
        LDRSB    R1,[R9, #+27]
        SUBS     R1,R0,R1
        SXTB     R1,R1
        MOV      R0,R7
        BL       TwoOutPwrConv
//  239 	Sts->RvsInPwr_2G[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+19]
//  240 	Sts->RvsInPwr_2G[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+20]
//  241 
//  242 
//  243 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_LTE_A;
//  244 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRSB    R1,[R6, #+19]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  245 	Sts->RvsOutPwr_LTE_A[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+17]
//  246 	Sts->RvsOutPwr_LTE_A[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+18]
//  247 
//  248 
//  249 	tmppwr = Sts->Det2Pwr.RvsAlcInPwr_LTE_A - Sts->FwdAgcAttn_LTE_A - Sts->RvsGainBalance_LTE_A - Sts->OtherFwdAlcAttn_LTE_A;
//  250 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRB     R0,[R6, #+19]
        LDRB     R1,[R4, #+2]
        SUBS     R0,R0,R1
        ADD      R1,R8,#+73
        LDRSB    R1,[R1, #+6]
        SUBS     R0,R0,R1
        LDRSB    R1,[R9, #+29]
        SUBS     R1,R0,R1
        SXTB     R1,R1
        MOV      R0,R7
        BL       TwoOutPwrConv
//  251 	Sts->RvsOutPwr_LTE_A[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R4, #+17]
//  252 	Sts->RvsOutPwr_LTE_A[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R4, #+18]
//  253 
//  254 
//  255 	tmppwr = Sts->Det2Pwr.Rvs1AlcInPwr_LTE;
//  256 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRSB    R1,[R6, #+21]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  257 	Sts->Rvs1OutPwr_LTE[0] = dptr[0];
        ADDW     R11,R8,#+793
        LDRB     R0,[R7, #+0]
        STRB     R0,[R11, #+8]
//  258 	Sts->Rvs1OutPwr_LTE[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R11, #+9]
//  259 
//  260 
//  261 	tmppwr = Sts->Det2Pwr.Rvs1AlcInPwr_LTE - Sts->Fwd1AgcAttn_LTE - Sts->Rvs1GainBalance_LTE - Sts->OtherFwd1AlcAttn_LTE;
//  262 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRB     R0,[R6, #+21]
        LDRSB    R1,[R8, #+793]
        SUBS     R0,R0,R1
        LDRSB    R1,[R10, #+18]
        SUBS     R0,R0,R1
        LDRSB    R1,[R9, #+31]
        SUBS     R1,R0,R1
        SXTB     R1,R1
        MOV      R0,R7
        BL       TwoOutPwrConv
//  263 	Sts->Rvs1OutPwr_LTE[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R11, #+8]
//  264 	Sts->Rvs1OutPwr_LTE[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R11, #+9]
//  265 
//  266 
//  267 	tmppwr = Sts->Det2Pwr.Rvs1AlcInPwr_LTE_A;
//  268 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRSB    R1,[R6, #+22]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  269 	Sts->Rvs1OutPwr_LTE_A[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R11, #+10]
//  270 	Sts->Rvs1OutPwr_LTE_A[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R11, #+11]
//  271 
//  272 
//  273 	tmppwr = Sts->Det2Pwr.Rvs1AlcInPwr_LTE_A - Sts->Fwd1AgcAttn_LTE_A - Sts->Rvs1GainBalance_LTE_A - Sts->OtherFwd1AlcAttn_LTE_A;
//  274 	TwoOutPwrConv((INT8S *)&dptr[0],tmppwr);
        LDRB     R0,[R6, #+22]
        LDRSB    R1,[R11, #+1]
        SUBS     R0,R0,R1
        LDRSB    R1,[R10, #+21]
        SUBS     R0,R0,R1
        LDRSB    R1,[R8, #+533]
        SUBS     R1,R0,R1
        SXTB     R1,R1
        MOV      R0,R7
        BL       TwoOutPwrConv
//  275 	Sts->Rvs1OutPwr_LTE_A[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R11, #+10]
//  276 	Sts->Rvs1OutPwr_LTE_A[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R11, #+11]
//  277 
//  278 
//  279 
//  280 	///'CDMA Tx 입력: DET -73+AGC ATT+ALC ATT+타사과입력 ALC ATT
//  281 	TwoOutPwrConv((INT8S *)&dptr[0],Sts->DetPwr.FwdAgcAvg_2G);
        LDRSB    R1,[R5, #+4]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  282 	Sts->FwdOutPwr_2G[0]	= dptr[0];
        ADD      R6,R8,#+36
        LDRB     R0,[R7, #+0]
        STRB     R0,[R6, #+8]
//  283 	Sts->FwdOutPwr_2G[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R6, #+9]
//  284 	Sts->SmsFwdInPwr_2G = Sts->DetPwr.FwdAgcAvg_2G - Gain_2G + Sts->FwdAgcAttn_2G + Sts->FwdAlcAttn_2G + Sts->OtherFwdAlcAttn_2G;
        LDRB     R0,[R5, #+4]
        LDRB     R1,[R8, #+464]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+21]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+27]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+110
        ADD      R1,R8,#+194
        STRB     R0,[R1, #+1]
//  285 
//  286 	TwoOutPwrConv((INT8S *)&dptr[0],Sts->DetPwr.FwdAgcAvg_LTE);
        LDRSB    R1,[R5, #+13]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  287 	Sts->FwdOutPwr_LTE[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R6, #+16]
//  288 	Sts->FwdOutPwr_LTE[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R6, #+17]
//  289 	Sts->SmsFwdInPwr_LTE = Sts->DetPwr.FwdAgcAvg_LTE - Gain_2G + Sts->FwdAgcAttn_LTE + Sts->FwdAlcAttn_LTE + Sts->OtherFwdAlcAttn_LTE;
        LDRB     R0,[R5, #+13]
        LDRB     R1,[R4, #+1]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+22]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+28]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+110
        STRB     R0,[R4, #+12]
//  290 
//  291 	TwoOutPwrConv((INT8S *)&dptr[0],Sts->DetPwr.FwdAgcAvg_LTE_A);
        LDRSB    R1,[R5, #+17]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  292 	Sts->FwdOutPwr_LTE_A[0] = dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R6, #+24]
//  293 	Sts->FwdOutPwr_LTE_A[1] = dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R6, #+25]
//  294 	Sts->SmsFwdInPwr_LTE_A = Sts->DetPwr.FwdAgcAvg_LTE_A - Gain_LTE + Sts->FwdAgcAttn_LTE + Sts->FwdAlcAttn_LTE_A + Sts->OtherFwdAlcAttn_LTE_A;
        LDRB     R0,[R5, #+17]
        LDRB     R1,[R4, #+1]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+23]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+29]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+110
        STRB     R0,[R4, #+13]
//  295 
//  296 
//  297 	TwoOutPwrConv((INT8S *)&dptr[0],Sts->DetPwr.FwdOutAvg_3G);
        LDRSB    R1,[R5, #+19]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  298 	Sts->FwdOutPwr_3G[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R8, #+36]
//  299 	Sts->FwdOutPwr_3G[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R6, #+1]
//  300 	Sts->SmsFwdInPwr_3G = Sts->DetPwr.FwdOutAvg_3G - Gain_3G + Sts->FwdAgcAttn_3G + Sts->FwdAlcAttn_3G + Sts->OtherFwdAlcAttn_3G;
        LDRB     R0,[R5, #+19]
        LDRB     R1,[R4, #+3]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+24]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+30]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+90
        STRB     R0,[R8, #+194]
//  301 
//  302 
//  303 	TwoOutPwrConv((INT8S *)&dptr[0],Sts->Det1Pwr.Fwd1AgcAvg_LTE);
        LDRSB    R1,[R8, #+711]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  304 	Sts->Fwd1OutPwr_LTE[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R8, #+655]
//  305 	Sts->Fwd1OutPwr_LTE[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R10, #+1]
//  306 	Sts->SmsFwdInPwr_LTE = Sts->Det1Pwr.Fwd1AgcAvg_LTE - Gain_3G + Sts->FwdAgcAttn_LTE + Sts->Fwd1AlcAttn_LTE + Sts->OtherFwd1AlcAttn_LTE;
        LDRB     R0,[R8, #+711]
        LDRB     R1,[R4, #+1]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+25]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+31]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+90
        STRB     R0,[R4, #+12]
//  307 
//  308 
//  309 	TwoOutPwrConv((INT8S *)&dptr[0],Sts->Det1Pwr.Fwd1AgcAvg_LTE_A);
        ADDW     R0,R8,#+711
        LDRSB    R1,[R0, #+4]
        MOV      R0,R7
        BL       TwoOutPwrConv
//  310 	Sts->Fwd1OutPwr_LTE_A[0]	= dptr[0];
        LDRB     R0,[R7, #+0]
        STRB     R0,[R10, #+8]
//  311 	Sts->Fwd1OutPwr_LTE_A[1]	= dptr[1];
        LDRB     R0,[R7, #+1]
        STRB     R0,[R10, #+9]
//  312 	Sts->SmsFwd1InPwr_LTE_A = Sts->Det1Pwr.Fwd1AgcAvg_LTE_A - Gain_3G + Sts->Fwd1AgcAttn_LTE + Sts->Fwd1AlcAttn_LTE_A + Sts->OtherFwd1AlcAttn_LTE_A;
        ADDW     R0,R8,#+711
        LDRB     R0,[R0, #+4]
        LDRSB    R1,[R8, #+793]
        ADDS     R0,R1,R0
        LDRSB    R1,[R9, #+26]
        ADDS     R0,R1,R0
        LDRSB    R1,[R8, #+533]
        ADDS     R0,R1,R0
        ADDS     R0,R0,#+90
        STRB     R0,[R11, #+7]
//  313 
//  314 
//  315 #endif
//  316 	if(!Sts->TPTL_OnOff)
        ADD      R0,R8,#+73
        LDRB     R0,[R0, #+30]
        CMP      R0,#+0
        BNE.N    ??DE_ReadAdcValue_1
//  317 	{
//  318 		INT8S tindex = 0;
//  319 		// Hysterisys !!
//  320 			 if(Sts->CurrentTemp >= tempIndexHys)		tempIndexHys = Sts->CurrentTemp;
        LDRSB    R0,[R8, #+149]
        LDR.N    R1,??DE_ReadAdcValue_0+0x8  ;; tempIndexHys
        LDRSB    R2,[R1, #+0]
        CMP      R0,R2
        BGE.N    ??DE_ReadAdcValue_2
//  321 		else if(Sts->CurrentTemp < (tempIndexHys - 1))	tempIndexHys = Sts->CurrentTemp;
        SUBS     R2,R2,#+1
        CMP      R0,R2
        BGE.N    ??DE_ReadAdcValue_3
??DE_ReadAdcValue_2:
        STRB     R0,[R1, #+0]
//  322 
//  323 		tindex = TemptoIndex(tempIndexHys);
??DE_ReadAdcValue_3:
        LDRSB    R0,[R1, #+0]
        BL       TemptoIndex
        SXTB     R0,R0
//  324         tindex = tindex;
//  325 
//  326 		Sts->FwdTemp_2G 	= vEE_TABLE1->_TptlAttnTbl[Local_FwdTempAttn_2G].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0xC  ;; 0x800680c
        LDRSB    R1,[R0, R1]
        ADD      R2,R8,#+194
        STRB     R1,[R2, #+19]
//  327 		Sts->RvsTemp_2G 	= vEE_TABLE1->_TptlAttnTbl[Local_RvsTempAttn_2G].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x10  ;; 0x8006828
        LDRSB    R1,[R0, R1]
        STRB     R1,[R2, #+20]
//  328 
//  329 		Sts->FwdTemp_3G 	= vEE_TABLE1->_TptlAttnTbl[Local_FwdTempAttn_3G].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x14  ;; 0x80068b4
        LDRSB    R1,[R0, R1]
        STRB     R1,[R2, #+17]
//  330 		Sts->RvsTemp_3G 	= vEE_TABLE1->_TptlAttnTbl[Local_RvsTempAttn_3G].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x18  ;; 0x80068d0
        LDRSB    R1,[R0, R1]
        STRB     R1,[R2, #+18]
//  331 
//  332 		Sts->FwdTemp_LTE 	= vEE_TABLE1->_TptlAttnTbl[Local_FwdTempAttn_LTE].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x1C  ;; 0x8006844
        LDRSB    R1,[R0, R1]
        STRB     R1,[R8, #+501]
//  333 		Sts->RvsTemp_LTE 	= vEE_TABLE1->_TptlAttnTbl[Local_RvsTempAttn_LTE].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x20  ;; 0x8006860
        LDRSB    R1,[R0, R1]
        STRB     R1,[R9, #+1]
//  334 		
//  335 		Sts->FwdTemp_LTE_A 	= vEE_TABLE1->_TptlAttnTbl[Local_FwdTempAttn_LTE_A].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x24  ;; 0x800687c
        LDRSB    R1,[R0, R1]
        STRB     R1,[R9, #+2]
//  336 		Sts->RvsTemp_LTE_A 	= vEE_TABLE1->_TptlAttnTbl[Local_RvsTempAttn_LTE_A].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x28  ;; 0x8006898
        LDRSB    R1,[R0, R1]
        STRB     R1,[R9, #+3]
//  337 		
//  338 		Sts->Fwd1Temp_LTE 	= vEE_TABLE1->_TptlAttnTbl[Local_Fwd1TempAttn_LTE].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x2C  ;; 0x80068ec
        LDRSB    R1,[R0, R1]
        STRB     R1,[R11, #+22]
//  339 		Sts->Rvs1Temp_LTE 	= vEE_TABLE1->_TptlAttnTbl[Local_Rvs1TempAttn_LTE].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x30  ;; 0x8006908
        LDRSB    R1,[R0, R1]
        STRB     R1,[R11, #+23]
//  340 		Sts->Fwd1Temp_LTE_A = vEE_TABLE1->_TptlAttnTbl[Local_Fwd1TempAttn_LTE_A].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x34  ;; 0x8006924
        LDRSB    R1,[R0, R1]
        STRB     R1,[R11, #+24]
//  341 		Sts->Rvs1Temp_LTE_A = vEE_TABLE1->_TptlAttnTbl[Local_Rvs1TempAttn_LTE_A].Data[tindex];
        LDR.N    R1,??DE_ReadAdcValue_0+0x38  ;; 0x8006940
        LDRSB    R0,[R0, R1]
        B.N      ??DE_ReadAdcValue_4
//  342 
//  343 //		SerPtr->printf(" TPTL_OnOff:[%d][%d][%d]\n",Sts->CurrentTemp,tindex,Sts->FwdTemp_2G);
//  344 		
//  345 	}
//  346 	else
//  347 	{
//  348 		Sts->FwdTemp_2G 	= 0;
??DE_ReadAdcValue_1:
        ADD      R0,R8,#+194
        MOVS     R1,#+0
        STRB     R1,[R0, #+19]
//  349 		Sts->RvsTemp_2G  	= 0;
        STRB     R1,[R0, #+20]
//  350 		Sts->FwdTemp_3G  	= 0;
        STRB     R1,[R0, #+17]
//  351 		Sts->RvsTemp_3G 	= 0;
        STRB     R1,[R0, #+18]
//  352 		Sts->FwdTemp_LTE 	= 0;
        MOVS     R0,#+0
        STRB     R0,[R8, #+501]
//  353 		Sts->RvsTemp_LTE 	= 0;
        STRB     R0,[R9, #+1]
//  354 		Sts->FwdTemp_LTE_A	= 0;
        STRB     R0,[R9, #+2]
//  355 		Sts->RvsTemp_LTE_A 	= 0;
        STRB     R0,[R9, #+3]
//  356 		Sts->Fwd1Temp_LTE 	= 0;
        STRB     R0,[R11, #+22]
//  357 		Sts->Rvs1Temp_LTE 	= 0;
        STRB     R0,[R11, #+23]
//  358 		Sts->Fwd1Temp_LTE_A	= 0;
        STRB     R0,[R11, #+24]
//  359 		Sts->Rvs1Temp_LTE_A = 0;
??DE_ReadAdcValue_4:
        STRB     R0,[R11, #+25]
//  360 	}
//  361 }
        POP      {R0,R4-R11,PC}   ;; return
        Nop      
        DATA
??DE_ReadAdcValue_0:
        DC32     ADC_DATA1
        DC32     dptr
        DC32     tempIndexHys
        DC32     0x800680c
        DC32     0x8006828
        DC32     0x80068b4
        DC32     0x80068d0
        DC32     0x8006844
        DC32     0x8006860
        DC32     0x800687c
        DC32     0x8006898
        DC32     0x80068ec
        DC32     0x8006908
        DC32     0x8006924
        DC32     0x8006940
//  362 
//  363 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  364 INT32S ReadPwrTableDnr(INT32U AdcValue, INT8U TblID, INT8U roundingoff, INT8U *isminval, INT16S Offset)
//  365 {
ReadPwrTableDnr:
        PUSH     {R3-R9,LR}
        MOV      R7,R0
        MOV      R8,R1
        MOV      R4,R2
        MOV      R5,R3
        LDRSH    R9,[SP, #+32]
//  366 	INT8S tIndex = 0;
//  367 	INT8S tLocation = 0;
//  368 
//  369 	tIndex = TableIndex(TblID);
        MOV      R0,R8
        BL       TableIndex
        MOV      R6,R0
//  370 	tLocation = TableLocation(TblID);
//  371 	if(tLocation == _1ST_Location)
        MOV      R0,R8
        BL       TableLocation
        CMP      R0,#+0
        PUSH     {R9,LR}
        MOV      R3,R5
        MOV      R2,R4
        UXTB     R1,R6
        MOV      R0,R7
        BNE.N    ??ReadPwrTableDnr_0
//  372 	{
//  373 		return (__1st_ReadPwrTable(AdcValue, tIndex, roundingoff, isminval,Offset));
        BL       __1st_ReadPwrTable
        B.N      ??ReadPwrTableDnr_1
//  374 
//  375 	}
//  376 	else
//  377 	{
//  378 		return (__2st_ReadPwrTable(AdcValue, tIndex, roundingoff, isminval,Offset));
??ReadPwrTableDnr_0:
        BL       __2st_ReadPwrTable
??ReadPwrTableDnr_1:
        ADD      SP,SP,#+8
        POP      {R1,R4-R9,PC}    ;; return
//  379 
//  380 	}
//  381 }
//  382 
//  383 
//  384 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  385 INT32S __1st_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset)
//  386 {
__1st_ReadPwrTable:
        PUSH     {R3-R9,LR}
        LDRSH    R4,[SP, #+32]
//  387 //	INT8U isminval = FALSE;
//  388 
//  389 	*isminval = FALSE;
        MOVS     R5,#+0
        STRB     R5,[R3, #+0]
//  390 
//  391 //	INT8U __1dBStep = FALSE;
//  392 	INT8U __1dBStep = TRUE;
//  393 
//  394 	{
//  395 		#ifdef __1stType
//  396 			__OutputTblStr *table =(__OutputTblStr *)&vEE_TABLE->OutputTbl[tIndex];
        MOVS     R5,#+72
        LDR.N    R6,??Subroutine0_0  ;; 0x8005802
        MLA      R6,R1,R5,R6
//  397 
//  398 		    INT32S i = 0;
//  399 	        INT32S j = 0;
        MOVS     R1,#+0
//  400 
//  401 			INT16U *dptr = table->Data;
        ADDS     R5,R6,#+2
//  402 			INT32S limit = table->limit;
//  403 			INT32S nsize = table->nsize;
        LDRB     R12,[R6, #+1]
//  404 			INT32S rvalx10 = (limit/2)*10L;
        LDRSB    R7,[R6, R1]
        MOVS     R6,#+10
        ADD      R7,R7,R7, LSR #+31
        ASRS     R7,R7,#+1
        MUL      LR,R7,R6
//  405 
//  406 		#else
//  407 			INT32S i = 0;
//  408 			INT32S j = 0;
//  409 			INT16U *dptr;
//  410 			INT32S limit;
//  411 			INT32S nsize;
//  412 			INT32S rvalx10;
//  413 
//  414 			if(tIndex == Local_FwdAgcAvgPwr_2G)
//  415 			{
//  416 				dptr = OutputTable->FwdOutAvgPwr_2G.Data;
//  417 				limit = OutputTable->FwdOutAvgPwr_2G.limit;
//  418 				nsize = OutputTable->FwdOutAvgPwr_2G.nsize;
//  419 				rvalx10 = (limit/2)*10L;
//  420 			}
//  421 			else if(tIndex == Local_FwdAgcPeakPwr_2G)
//  422 			{
//  423 				dptr = OutputTable->FwdOutPeakPwr_2G.Data;
//  424 				limit = OutputTable->FwdOutPeakPwr_2G.limit;
//  425 				nsize = OutputTable->FwdOutPeakPwr_2G.nsize;
//  426 				rvalx10 = (limit/2)*10L;
//  427 			}
//  428 		#endif
//  429 
//  430 
//  431 
//  432 		INT16S CurrPwr;
//  433 
//  434 		for(i = 0; i < nsize && i < OutputTBL_Size; i++)
        MOVS     R7,#+0
        MOV      R8,R5
        B.N      ??__1st_ReadPwrTable_0
??__1st_ReadPwrTable_1:
        CMP      R7,#+35
        BGE.N    ??__1st_ReadPwrTable_2
//  435 		{
//  436 			if(AdcValue >= dptr[i]) break;
        LDRH     R9,[R8], #+2
        CMP      R0,R9
        BCS.N    ??__1st_ReadPwrTable_3
//  437 		}
        ADDS     R7,R7,#+1
??__1st_ReadPwrTable_0:
        CMP      R7,R12
        BLT.N    ??__1st_ReadPwrTable_1
//  438 
//  439 		if(i == nsize || i == OutputTBL_Size)
        BEQ.N    ??__1st_ReadPwrTable_4
??__1st_ReadPwrTable_2:
        CMP      R7,#+35
        BNE.N    ??__1st_ReadPwrTable_3
//  440 		{
//  441 			if(nsize != 0) i--;
??__1st_ReadPwrTable_4:
        CMP      R12,#+0
        BEQ.N    ??__1st_ReadPwrTable_5
        SUBS     R7,R7,#+1
//  442 			*isminval = TRUE;
??__1st_ReadPwrTable_5:
        MOV      R12,#+1
        STRB     R12,[R3, #+0]
//  443 		}
//  444 
//  445 		if(__1dBStep)
//  446 		{
//  447 			rvalx10 = rvalx10 - (i*10L);
??__1st_ReadPwrTable_3:
        MLS      R12,R7,R6,LR
//  448 		}
//  449 		else
//  450 		{
//  451 			rvalx10 = rvalx10 - (i*5L);
//  452 		}
//  453 //		SerPtr->printf(" rvalx10:[%d][%d][%d]\n",AdcValue,i,rvalx10);
//  454 
//  455 		if(i != 0 && *isminval == FALSE && __1dBStep == TRUE )
        LDRB     R3,[R3, #+0]
        CBZ      R7,??__1st_ReadPwrTable_6
        CBNZ     R3,??__1st_ReadPwrTable_6
//  456 		{
//  457 			INT32U stepx10 = ((dptr[i-1] - dptr[i])*10L)/10L;
        ADD      LR,R5,R7, LSL #+1
        LDRH     LR,[LR, #-2]
        LDRH     R8,[R5, R7, LSL #+1]
        SUB      LR,LR,R8
        MUL      LR,LR,R6
        SDIV     LR,LR,R6
//  458 			INT32U tmp;
//  459 			
//  460 			for(j = 0; j < 10; j++)
        MULS     R0,R0,R6
//  461 			{
//  462 				tmp = (dptr[i]*10 + j*stepx10);
//  463 				if(tmp >= (AdcValue*10L)) break;			
??__1st_ReadPwrTable_7:
        LDRH     R8,[R5, R7, LSL #+1]
        MUL      R9,R1,LR
        MLA      R8,R8,R6,R9
        CMP      R8,R0
        BCS.N    ??__1st_ReadPwrTable_8
//  464 			}		
        ADDS     R1,R1,#+1
        CMP      R1,#+10
        BLT.N    ??__1st_ReadPwrTable_7
//  465 			if(roundingoff == TRUE)// 반올림..
??__1st_ReadPwrTable_8:
        CMP      R2,#+1
        BNE.N    ??__1st_ReadPwrTable_6
//  466 			{
//  467 				     if(j >= 8)  j = 10;
        CMP      R1,#+8
        BLT.N    ??__1st_ReadPwrTable_9
        MOVS     R1,#+10
        B.N      ??__1st_ReadPwrTable_6
//  468 				else if(j >= 3)  j = 5;
??__1st_ReadPwrTable_9:
        CMP      R1,#+3
        ITE      GE 
        MOVGE    R1,#+5
        MOVLT    R1,#+0
//  469 				else			 j = 0;
//  470 			}		
//  471 		}
//  472 		
//  473 		CurrPwr = (rvalx10 + j)*2L;
??__1st_ReadPwrTable_6:
        ADD      R0,R1,R12
        LSLS     R0,R0,#+17
//  474 		if(!*isminval)
        CMP      R3,#+0
        ITTTE    EQ 
        ASREQ    R0,R0,#+16
        SDIVEQ   R0,R0,R6
        ADDEQ    R0,R4,R0
        MVNNE    R0,#+119
//  475 		{
//  476 			CurrPwr = CurrPwr/10L +  Offset;
//  477 		}
//  478 		else
//  479 		{
//  480 			CurrPwr =  -60*2L;
//  481 		}
//  482 
//  483 //		SerPtr->printf(" CurrPwr:[%d]\n",CurrPwr);
//  484 
//  485 		return CurrPwr;
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  486 	}
//  487 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine0:
        SXTH     R0,R0
        POP      {R1,R4-R9,PC}    ;; return
        Nop      
        DATA
??Subroutine0_0:
        DC32     0x8005802
//  488 
//  489 
//  490 
//  491 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  492 INT32S __2st_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset)
//  493 {
__2st_ReadPwrTable:
        PUSH     {R3-R9,LR}
        LDRSH    R4,[SP, #+32]
//  494 //	INT8U isminval = FALSE;
//  495 
//  496 	*isminval = FALSE;
        MOVS     R5,#+0
        STRB     R5,[R3, #+0]
//  497 
//  498 //	INT8U __1dBStep = FALSE;
//  499 	INT8U __1dBStep = TRUE;
//  500 
//  501 	{
//  502 		#ifdef __1stType
//  503 			__OutputTblStr *table =(__OutputTblStr *)&vEE_BACK1->OutputTbl[tIndex];
        MOVS     R5,#+126
        LDR.N    R6,??__2st_ReadPwrTable_0  ;; 0x80060e2
        MLA      R6,R1,R5,R6
//  504 
//  505 		    INT32S i = 0;
//  506 	        INT32S j = 0;
        MOVS     R1,#+0
//  507 
//  508 			INT16U *dptr = table->Data;
        ADDS     R5,R6,#+2
//  509 			INT32S limit = table->limit;
//  510 			INT32S nsize = table->nsize;
        LDRB     R12,[R6, #+1]
//  511 			INT32S rvalx10 = (limit/2)*10L;
        LDRSB    R7,[R6, R1]
        MOVS     R6,#+10
        ADD      R7,R7,R7, LSR #+31
        ASRS     R7,R7,#+1
        MUL      LR,R7,R6
//  512 
//  513 		#else
//  514 			INT32S i = 0;
//  515 			INT32S j = 0;
//  516 			INT16U *dptr;
//  517 			INT32S limit;
//  518 			INT32S nsize;
//  519 			INT32S rvalx10;
//  520 
//  521 			if(tIndex == Local_FwdAgcAvgPwr_2G)
//  522 			{
//  523 				dptr = OutputTable->FwdOutAvgPwr_2G.Data;
//  524 				limit = OutputTable->FwdOutAvgPwr_2G.limit;
//  525 				nsize = OutputTable->FwdOutAvgPwr_2G.nsize;
//  526 				rvalx10 = (limit/2)*10L;
//  527 			}
//  528 			else if(tIndex == Local_FwdAgcPeakPwr_2G)
//  529 			{
//  530 				dptr = OutputTable->FwdOutPeakPwr_2G.Data;
//  531 				limit = OutputTable->FwdOutPeakPwr_2G.limit;
//  532 				nsize = OutputTable->FwdOutPeakPwr_2G.nsize;
//  533 				rvalx10 = (limit/2)*10L;
//  534 			}
//  535 		#endif
//  536 
//  537 
//  538 
//  539 		INT16S CurrPwr;
//  540 
//  541 		for(i = 0; i < nsize && i < OutputTBL_Size; i++)
        MOVS     R7,#+0
        MOV      R8,R5
        B.N      ??__2st_ReadPwrTable_1
??__2st_ReadPwrTable_2:
        CMP      R7,#+35
        BGE.N    ??__2st_ReadPwrTable_3
//  542 		{
//  543 			if(AdcValue >= dptr[i]) break;
        LDRH     R9,[R8], #+2
        CMP      R0,R9
        BCS.N    ??__2st_ReadPwrTable_4
//  544 		}
        ADDS     R7,R7,#+1
??__2st_ReadPwrTable_1:
        CMP      R7,R12
        BLT.N    ??__2st_ReadPwrTable_2
//  545 
//  546 		if(i == nsize || i == OutputTBL_Size)
        BEQ.N    ??__2st_ReadPwrTable_5
??__2st_ReadPwrTable_3:
        CMP      R7,#+35
        BNE.N    ??__2st_ReadPwrTable_4
//  547 		{
//  548 			if(nsize != 0) i--;
??__2st_ReadPwrTable_5:
        CMP      R12,#+0
        BEQ.N    ??__2st_ReadPwrTable_6
        SUBS     R7,R7,#+1
//  549 			*isminval = TRUE;
??__2st_ReadPwrTable_6:
        MOV      R12,#+1
        STRB     R12,[R3, #+0]
//  550 		}
//  551 
//  552 		if(__1dBStep)
//  553 		{
//  554 			rvalx10 = rvalx10 - (i*10L);
??__2st_ReadPwrTable_4:
        MLS      R12,R7,R6,LR
//  555 		}
//  556 		else
//  557 		{
//  558 			rvalx10 = rvalx10 - (i*5L);
//  559 		}
//  560 //		SerPtr->printf(" rvalx10:[%d][%d][%d]\n",AdcValue,i,rvalx10);
//  561 
//  562 
//  563 		if(i != 0 && *isminval == FALSE && __1dBStep == TRUE )
        LDRB     R3,[R3, #+0]
        CBZ      R7,??__2st_ReadPwrTable_7
        CBNZ     R3,??__2st_ReadPwrTable_7
//  564 		{
//  565 			INT32U stepx10 = ((dptr[i-1] - dptr[i])*10L)/10L;
        ADD      LR,R5,R7, LSL #+1
        LDRH     LR,[LR, #-2]
        LDRH     R8,[R5, R7, LSL #+1]
        SUB      LR,LR,R8
        MUL      LR,LR,R6
        SDIV     LR,LR,R6
//  566 			INT32U tmp;
//  567 			
//  568 			for(j = 0; j < 10; j++)
        MULS     R0,R0,R6
//  569 			{
//  570 				tmp = (dptr[i]*10 + j*stepx10);
//  571 				if(tmp >= (AdcValue*10L)) break;			
??__2st_ReadPwrTable_8:
        LDRH     R8,[R5, R7, LSL #+1]
        MUL      R9,R1,LR
        MLA      R8,R8,R6,R9
        CMP      R8,R0
        BCS.N    ??__2st_ReadPwrTable_9
//  572 			}		
        ADDS     R1,R1,#+1
        CMP      R1,#+10
        BLT.N    ??__2st_ReadPwrTable_8
//  573 			if(roundingoff == TRUE)// 반올림..
??__2st_ReadPwrTable_9:
        CMP      R2,#+1
        BNE.N    ??__2st_ReadPwrTable_7
//  574 			{
//  575 				     if(j >= 8)  j = 10;
        CMP      R1,#+8
        BLT.N    ??__2st_ReadPwrTable_10
        MOVS     R1,#+10
        B.N      ??__2st_ReadPwrTable_7
//  576 				else if(j >= 3)  j = 5;
??__2st_ReadPwrTable_10:
        CMP      R1,#+3
        ITE      GE 
        MOVGE    R1,#+5
        MOVLT    R1,#+0
//  577 				else			 j = 0;
//  578 			}		
//  579 		}
//  580 		
//  581 		CurrPwr = (rvalx10 + j)*2L;
??__2st_ReadPwrTable_7:
        ADD      R0,R1,R12
        LSLS     R0,R0,#+17
//  582 		if(!*isminval)
        CMP      R3,#+0
        ITTTE    EQ 
        ASREQ    R0,R0,#+16
        SDIVEQ   R0,R0,R6
        ADDEQ    R0,R4,R0
        MVNNE    R0,#+119
//  583 		{
//  584 			CurrPwr = CurrPwr/10L +  Offset;
//  585 		}
//  586 		else
//  587 		{
//  588 			CurrPwr =  -60*2L;
//  589 		}
//  590 
//  591 //		SerPtr->printf(" CurrPwr:[%d]\n",CurrPwr);
//  592 
//  593 
//  594 		return CurrPwr;
        B.N      ?Subroutine0
        Nop      
        DATA
??__2st_ReadPwrTable_0:
        DC32     0x80060e2
//  595 	}
//  596 }
//  597 
//  598 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  599 INT8S AttnCalculation(INT8S cAttn, INT8S cAttMax)
//  600 {
AttnCalculation:
        MOV      R3,R1
//  601 	INT8S AttTemp = cAttn;
//  602 
//  603 	AttTemp = cAttMax - cAttn;
//  604 	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
//  605 
//  606 	return AttTemp;
        MOVS     R2,#+0
        MOVS     R1,#+63
        SUBS     R0,R3,R0
        SXTB     R0,R0
        B.W      MinMaxAttnCheck
//  607 }
//  608 
//  609 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  610 INT16S GainAttnCalculation(INT16S cGain, INT16S cGainMax,INT8S cAttMin)
//  611 {
GainAttnCalculation:
        MOV      R3,R1
//  612 	INT16S AttTemp = cGain;
//  613 
//  614 	AttTemp = cGainMax - cGain;
//  615 //	AttTemp = MinMaxAttnCheck(AttTemp, (cAttMax + (5*2)),ATTENMIN);
//  616 	AttTemp = MinMaxAttnCheck(AttTemp, GainATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+90
        SUBS     R0,R3,R0
        SXTH     R0,R0
        B.W      MinMaxAttnCheck
//  617 
//  618 	return AttTemp;
//  619 }
//  620 
//  621 
//  622 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  623 INT8S RvsNFGain(INT8U Gain,INT8S cGainMax,INT8S cAttMax)
//  624 {
RvsNFGain:
        PUSH     {R3,R4}
        MOV      R3,R1
        MOV      R4,R2
//  625 	INT8S AttTemp = Gain;
//  626 
//  627 	AttTemp = cAttMax - (cGainMax - Gain);
//  628 
//  629 	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
//  630 
//  631 	return AttTemp;
        MOVS     R2,#+0
        MOVS     R1,#+63
        SUBS     R3,R4,R3
        ADDS     R0,R0,R3
        SXTB     R0,R0
        POP      {R3,R4}
        B.W      MinMaxAttnCheck
//  632 }
//  633 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  634 void ShutDownCheck(void)
//  635 {
ShutDownCheck:
        PUSH     {R7,LR}
//  636 	ShutDownCheck_Common();
        BL       ShutDownCheck_Common
//  637 	ShutDownCheck_3G();
        BL       ShutDownCheck_3G
//  638 	ShutDownCheck_LTE_A();
        BL       ShutDownCheck_LTE_A
//  639 	ShutDownCheck_LTE1();
        BL       ShutDownCheck_LTE1
//  640 	ShutDownCheck_LTE_A1();
        BL       ShutDownCheck_LTE_A1
//  641 
//  642 	Local_ShutDownCheck_Common();
        BL       Local_ShutDownCheck_Common
//  643 	Local_ShutDownCheck_3G();
        BL       Local_ShutDownCheck_3G
//  644 	Local_ShutDownCheck_LTE1();
        BL       Local_ShutDownCheck_LTE1
//  645 	Local_ShutDownCheck_LTE_A1();
        POP      {R0,LR}
        B.W      Local_ShutDownCheck_LTE_A1
//  646 }
//  647 
//  648 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  649 void ShutDownCheck_Common(void)
//  650 {
ShutDownCheck_Common:
        PUSH     {R4-R6,LR}
//  651   INT8U tmpAlarm;
//  652 
//  653   __Dnr_Sts *Sts = tDnrSts;
        LDR.N    R0,??DataTable1  ;; tDnrSts
        LDR      R5,[R0, #+0]
//  654 
//  655   Sts->ShunDown_Step_2G = SdStep_2G;
        LDR.N    R6,??ShutDownCheck_Common_1  ;; ChkNorAlarm_2G
        LDRB     R1,[R6, #+2]
        STRB     R1,[R5, #+864]
//  656   if(Sts->ShutDownOnOff_2G == Disable) return;
        LDRB     R1,[R5, #+202]
        CMP      R1,#+1
        BEQ.W    ??ShutDownCheck_Common_2
//  657 
//  658   if(ChkNorAlarm_2G == 0)
        LDRB     R1,[R6, #+0]
        CBNZ     R1,??ShutDownCheck_Common_3
//  659   {
//  660 	  if (PwrAlarm.RvsOutUpperLmtFail_2G) 			 	 ChkNorAlarmVal_2G = 1;
        LDR.N    R1,??DataTable8  ;; PwrAlarm
        LDRB     R2,[R1, #+23]
        CBZ      R2,??ShutDownCheck_Common_4
        MOVS     R1,#+1
        B.N      ??ShutDownCheck_Common_5
//  661 	  else if (PwrAlarm.FwdOutUpperLmtFail_2G) 			 ChkNorAlarmVal_2G = 2;
??ShutDownCheck_Common_4:
        LDRB     R2,[R1, #+5]
        CBZ      R2,??ShutDownCheck_Common_6
        MOVS     R1,#+2
        B.N      ??ShutDownCheck_Common_5
//  662 	  else if (PwrAlarm.FwdInUpperLmtFail_2G) 			 ChkNorAlarmVal_2G = 3;
??ShutDownCheck_Common_6:
        LDRB     R2,[R1, #+6]
        CBZ      R2,??ShutDownCheck_Common_7
        MOVS     R1,#+3
        B.N      ??ShutDownCheck_Common_5
//  663 	  
//  664 	  else if (PwrAlarm.RvsOutUpperLmtFail_LTE) 		 ChkNorAlarmVal_2G = 4;
??ShutDownCheck_Common_7:
        LDRB     R2,[R1, #+22]
        CBZ      R2,??ShutDownCheck_Common_8
        MOVS     R1,#+4
        B.N      ??ShutDownCheck_Common_5
//  665 	  else if (PwrAlarm.FwdOutUpperLmtFail_LTE) 		 ChkNorAlarmVal_2G = 5;
??ShutDownCheck_Common_8:
        LDRB     R2,[R1, #+16]
        CBZ      R2,??ShutDownCheck_Common_9
        MOVS     R1,#+5
        B.N      ??ShutDownCheck_Common_5
//  666 	  else if (PwrAlarm.FwdInUpperLmtFail_LTE) 			 ChkNorAlarmVal_2G = 6;
??ShutDownCheck_Common_9:
        LDRB     R1,[R1, #+17]
        CBZ      R1,??ShutDownCheck_Common_10
        MOVS     R1,#+6
??ShutDownCheck_Common_5:
        STRB     R1,[R6, #+1]
//  667 	  
//  668 	  SdChekcTime_2G = AlarmDelay2Time;	  ///100Sec
??ShutDownCheck_Common_10:
        MOVS     R1,#+9
        STR      R1,[R6, #+8]
//  669 	  if(ChkNorAlarmVal_2G) ChkNorAlarm_2G = Alarm;
        LDRB     R1,[R6, #+1]
        CBZ      R1,??ShutDownCheck_Common_11
        MOVS     R1,#+1
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_Common_11
//  670   }
//  671   
//  672   else if(ChkNorAlarm_2G)
//  673   {
//  674 	  if(ChkNorAlarmVal_2G == 1)
??ShutDownCheck_Common_3:
        LDRB     R1,[R6, #+1]
        CMP      R1,#+1
        BNE.N    ??ShutDownCheck_Common_12
//  675 	  {
//  676 		  if  ((PwrAlarm.RvsOutUpperLmtFail_2G))	  	tmpAlarm = Alarm;
        LDR.N    R1,??DataTable8  ;; PwrAlarm
        LDRB     R1,[R1, #+23]
        B.N      ??ShutDownCheck_Common_13
//  677 		  else											tmpAlarm = Normal;
//  678 	  }
//  679 	  else if(ChkNorAlarmVal_2G == 2)
??ShutDownCheck_Common_12:
        CMP      R1,#+2
        BNE.N    ??ShutDownCheck_Common_14
//  680 	  {
//  681 		  if  ((PwrAlarm.FwdOutUpperLmtFail_2G))	  	tmpAlarm = Alarm;
        LDR.N    R1,??DataTable8  ;; PwrAlarm
        LDRB     R1,[R1, #+5]
        B.N      ??ShutDownCheck_Common_13
//  682 		  else											tmpAlarm = Normal;
//  683 	  }	  
//  684 	  else if(ChkNorAlarmVal_2G == 3)
??ShutDownCheck_Common_14:
        CMP      R1,#+3
        BNE.N    ??ShutDownCheck_Common_15
//  685 	  {
//  686 		  if  ((PwrAlarm.FwdInUpperLmtFail_2G))	  		tmpAlarm = Alarm;
        LDR.N    R1,??DataTable8  ;; PwrAlarm
        LDRB     R1,[R1, #+6]
        B.N      ??ShutDownCheck_Common_13
//  687 		  else											tmpAlarm = Normal;
//  688 	  }	  
//  689 	  else if(ChkNorAlarmVal_2G == 4)
??ShutDownCheck_Common_15:
        CMP      R1,#+4
        BNE.N    ??ShutDownCheck_Common_16
//  690 	  {
//  691 		  if  ((PwrAlarm.RvsOutUpperLmtFail_LTE))	  	tmpAlarm = Alarm;
        LDR.N    R1,??DataTable8  ;; PwrAlarm
        LDRB     R1,[R1, #+22]
        B.N      ??ShutDownCheck_Common_13
//  692 		  else											tmpAlarm = Normal;
//  693 	  }	  
//  694 	  
//  695 	  else if(ChkNorAlarmVal_2G == 5)
??ShutDownCheck_Common_16:
        CMP      R1,#+5
        BNE.N    ??ShutDownCheck_Common_17
//  696 	  {
//  697 		  if  ((PwrAlarm.FwdOutUpperLmtFail_LTE)) 		tmpAlarm = Alarm;
        LDR.N    R1,??DataTable8  ;; PwrAlarm
        LDRB     R1,[R1, #+16]
        B.N      ??ShutDownCheck_Common_13
//  698 		  else											tmpAlarm = Normal;
//  699 	  }   
//  700 	  else if(ChkNorAlarmVal_2G == 6)
??ShutDownCheck_Common_17:
        CMP      R1,#+6
        BNE.N    ??ShutDownCheck_Common_11
//  701 	  {
//  702 		  if  ((PwrAlarm.FwdInUpperLmtFail_LTE)) 		tmpAlarm = Alarm;
        LDR.N    R1,??DataTable8  ;; PwrAlarm
        LDRB     R1,[R1, #+17]
??ShutDownCheck_Common_13:
        SUBS     R4,R1,#+1
        SBCS     R4,R4,R4
        MVNS     R4,R4
        LSRS     R4,R4,#+31
//  703 		  else											tmpAlarm = Normal;
//  704 	  }   
//  705   }
//  706 
//  707   if(SdBuffClear_2G)
??ShutDownCheck_Common_11:
        LDRB     R1,[R6, #+3]
        CBZ      R1,??ShutDownCheck_Common_18
//  708   {
//  709 	  SdStep_2G = _AlarmCheckStart;
        MOVS     R1,#+0
        STRB     R1,[R6, #+2]
//  710 	  SdBuffClear_2G = FALSE;
        STRB     R1,[R6, #+3]
//  711 
//  712 	  SdChekcTime_2G = Recovery4Time;
        MOVS     R1,#+4
        STR      R1,[R6, #+8]
//  713 
//  714 	  ChkNorAlarmVal_2G = 0;
        MOVS     R1,#+0
        STRB     R1,[R6, #+1]
//  715 	  ChkNorAlarm_2G = 0;
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_Common_19
//  716   }   
//  717 
//  718   if(SdChekcTime_2G > 0)SdChekcTime_2G--;
??ShutDownCheck_Common_18:
        LDR      R1,[R6, #+8]
        CBZ      R1,??ShutDownCheck_Common_20
??ShutDownCheck_Common_19:
        LDR      R1,[R6, #+8]
        SUBS     R1,R1,#+1
        STR      R1,[R6, #+8]
//  719 
//  720   if(tDnrSts->TestMode == Debug_Rvs0SD)USART1Printf("0: SdStep_2G[%d]SdChekcTime_2G[%d]:[%d][%d]:[%d]\n", SdStep_2G,SdChekcTime_2G,tmpAlarm,Sts->AmpOnOff_Common,ChkNorAlarmVal_2G);
??ShutDownCheck_Common_20:
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+5
        BNE.N    ??ShutDownCheck_Common_21
        LDRB     R1,[R6, #+1]
        LDRB     R0,[R5, #+84]
        PUSH     {R0,R1}
        UXTB     R4,R4
        MOV      R3,R4
        LDR      R2,[R6, #+8]
        LDRB     R1,[R6, #+2]
        LDR.N    R0,??ShutDownCheck_Common_1+0x4  ;; `?<Constant "0: SdStep_2G[%d]SdChe...">`
        BL       USART1Printf
        ADD      SP,SP,#+8
//  721   
//  722   switch(SdStep_2G)
??ShutDownCheck_Common_21:
        LDRB     R0,[R6, #+2]
        CMP      R0,#+8
        BHI.N    ??ShutDownCheck_Common_2
        TBB      [PC, R0]
        DATA
??ShutDownCheck_Common_0:
        DC8      +5,+16,+39,+48
        DC8      +59,+68,+84,+93
        DC8      +101,+0
        THUMB
//  723   {
//  724 	  case 0:
//  725 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_22:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_Common_2
//  726 		  {
//  727 			  if(tmpAlarm == Alarm)
        UXTB     R4,R4
        CMP      R4,#+1
        BNE.N    ??ShutDownCheck_Common_23
//  728 			  {
//  729 				  SdStep_2G = 1;
        MOVS     R0,#+1
??ShutDownCheck_Common_24:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
//  730 			  }
//  731 			  else
//  732 			  {
//  733 				  SdBuffClear_2G = SET;
??ShutDownCheck_Common_23:
        B.W      ?Subroutine3
//  734 			  }
//  735 		  }
//  736 	  break;
//  737 	  
//  738 	  case 1:  //5 1번 amp off	 1
//  739 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_25:
        LDR      R0,[R6, #+8]
        CBNZ     R0,??ShutDownCheck_Common_26
//  740 		  {
//  741 			  AmpOff_Common(Disable);			  ///1
        MOVS     R0,#+1
        BL       AmpOff_Common
//  742 			  SdChekcTime_2G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  743 			  SdStep_2G = 2;
        MOVS     R0,#+2
        B.N      ??ShutDownCheck_Common_24
//  744 		  }
//  745 		  else if(tmpAlarm == Normal)
??ShutDownCheck_Common_26:
        UXTB     R4,R4
        CMP      R4,#+0
        BNE.N    ??ShutDownCheck_Common_2
//  746 		  {
//  747 			  SdNormalCnt_2G++;
        LDRB     R0,[R6, #+4]
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+4]
//  748 			  if(SdNormalCnt_2G > 2)
        UXTB     R0,R0
        CMP      R0,#+3
        BCC.N    ??ShutDownCheck_Common_2
//  749 			  {
//  750 				  AmpOff_Common(Enable);
        MOVS     R0,#+0
        BL       AmpOff_Common
//  751 				  SdBuffClear_2G = SET;
        B.W      ?Subroutine1
//  752 				  SdNormalCnt_2G = 0;
//  753 			  }
//  754 		  }   
//  755 	  break;
//  756 	  
//  757 	  case 2: //5 1번 amp on  2   
//  758 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_27:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_Common_2
//  759 		  {
//  760 			  AmpOff_Common(Enable);
        BL       AmpOff_Common
//  761 			  SdChekcTime_2G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  762 			  SdStep_2G = 3;
        MOVS     R0,#+3
        B.N      ??ShutDownCheck_Common_24
//  763 		  } 		  
//  764 	  break;
//  765 	  
//  766 	  case 3: ////5 2번 amp off   3
//  767 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_28:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_Common_26
//  768 		  {
//  769 			  AmpOff_Common(Disable);		  ///2
        MOVS     R0,#+1
        BL       AmpOff_Common
//  770 			  SdChekcTime_2G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  771 
//  772 			  SdStep_2G = 4;
        MOVS     R0,#+4
??ShutDownCheck_Common_29:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
//  773 		  }
//  774 		  else if(tmpAlarm == Normal)
//  775 		  {
//  776 			  SdNormalCnt_2G++;
//  777 			  if(SdNormalCnt_2G > 2)
//  778 			  {
//  779 				  AmpOff_Common(Enable);
//  780 				  SdBuffClear_2G = SET;
//  781 				  SdNormalCnt_2G = 0;
//  782 			  }
//  783 		  }
//  784 	  break;  
//  785 
//  786 	  case 4: //5 2번 amp on   4
//  787 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_30:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_Common_2
//  788 		  {
//  789 			  AmpOff_Common(Enable);
        BL       AmpOff_Common
//  790 			  SdChekcTime_2G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  791 			  SdStep_2G = 5;
        MOVS     R0,#+5
        B.N      ??ShutDownCheck_Common_24
//  792 		  }
//  793 	  break;  
//  794 
//  795 	  case 5: //5 //5 3번 amp off  5
//  796 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_31:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_Common_26
//  797 		  {
//  798 			  AmpOff_Common(Disable);		  ///3
        MOVS     R0,#+1
        BL       AmpOff_Common
//  799 			  if( Sts->ShunDown_Value == 0)   SdChekcTime_2G = Recovery3Time;
        LDRB     R0,[R5, #+828]
        CMP      R0,#+0
        ITE      EQ 
        MOVEQ    R0,#+3600
        MOVNE    R0,#+18
//  800 			  else							  SdChekcTime_2G = Recovery1Time;
        STR      R0,[R6, #+8]
//  801 
//  802 			  SdStep_2G = 6;
        MOVS     R0,#+6
        B.N      ??ShutDownCheck_Common_29
//  803 		  }
//  804 		  else if(tmpAlarm == Normal)
//  805 		  {
//  806 			  SdNormalCnt_2G++;
//  807 			  if(SdNormalCnt_2G > 2)
//  808 			  {
//  809 				  AmpOff_Common(Enable);
//  810 				  SdBuffClear_2G = SET;
//  811 				  SdNormalCnt_2G = 0;
//  812 			  }
//  813 		  }
//  814 	  break;  
//  815 
//  816 	  case 6: //5	 6
//  817 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_32:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_Common_26
//  818 		  {
//  819 			  AmpOff_Common(Enable);
        BL       AmpOff_Common
//  820 			  SdChekcTime_2G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  821 			  
//  822 			  SdStep_2G = 7;
        MOVS     R0,#+7
        B.N      ??ShutDownCheck_Common_24
//  823 		  } 	  
//  824 		  else if(tmpAlarm == Normal)
//  825 		  {
//  826 			  SdNormalCnt_2G++;
//  827 			  if(SdNormalCnt_2G > 2)
//  828 			  {
//  829 				  AmpOff_Common(Enable);
//  830 				  SdBuffClear_2G = SET;
//  831 				  SdNormalCnt_2G = 0;
//  832 			  }
//  833 		  }
//  834 	  break;  
//  835 
//  836 	  case 7: //5  7
//  837 		  if(!SdChekcTime_2G)
??ShutDownCheck_Common_33:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_Common_26
//  838 		  {
//  839 			  AmpOff_Common(Disable);
        MOVS     R0,#+1
        BL       AmpOff_Common
//  840 			  SdStep_2G = 8;
        B.W      ?Subroutine2
//  841 		  }
//  842 		  else if(tmpAlarm == Normal)
//  843 		  {
//  844 			  SdNormalCnt_2G++;
//  845 			  if(SdNormalCnt_2G > 2)
//  846 			  {
//  847 				  AmpOff_Common(Enable);
//  848 				  SdBuffClear_2G = SET;
//  849 				  SdNormalCnt_2G = 0;
//  850 			  }
//  851 		  }
//  852 	  break;  
//  853 
//  854 	  case 8: //5
//  855 		  AmpOff_Common(Disable);
??ShutDownCheck_Common_34:
        MOVS     R0,#+1
        BL       AmpOff_Common
??ShutDownCheck_Common_2:
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??ShutDownCheck_Common_1:
        DC32     ChkNorAlarm_2G
        DC32     `?<Constant "0: SdStep_2G[%d]SdChe...">`
//  856 	  break;  
//  857   }
//  858 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable1:
        DC32     tDnrSts

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     PwrAlarm
//  859 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  860 void ShutDownCheck_3G(void)
//  861 {
ShutDownCheck_3G:
        PUSH     {R4-R6,LR}
//  862 	INT8U tmpAlarm;
//  863 
//  864 	__Dnr_Sts *Sts = tDnrSts;
        LDR.N    R0,??ShutDownCheck_3G_1  ;; tDnrSts
        LDR      R5,[R0, #+0]
//  865 
//  866 	Sts->ShunDown_Step_3G = SdStep_3G;
        LDR.N    R6,??ShutDownCheck_3G_1+0x4  ;; ChkNorAlarm_3G
        LDRB     R1,[R6, #+2]
        STRB     R1,[R5, #+865]
//  867 	if(Sts->ShutDownOnOff_3G == Disable) return;
        LDRB     R1,[R5, #+201]
        CMP      R1,#+1
        BEQ.W    ??ShutDownCheck_3G_2
//  868 
//  869 	if(ChkNorAlarm_3G == 0)
        LDRB     R1,[R6, #+0]
        CBNZ     R1,??ShutDownCheck_3G_3
//  870 	{
//  871 	  if (PwrAlarm.RvsOutUpperLmtFail_3G) 			 	 ChkNorAlarmVal_3G = 1;
        LDR.N    R1,??ShutDownCheck_3G_1+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+24]
        CBZ      R2,??ShutDownCheck_3G_4
        MOVS     R1,#+1
        B.N      ??ShutDownCheck_3G_5
//  872 	  else if (PwrAlarm.FwdOutUpperLmtFail_3G) 			 ChkNorAlarmVal_3G = 2;
??ShutDownCheck_3G_4:
        LDRB     R2,[R1, #+9]
        CBZ      R2,??ShutDownCheck_3G_6
        MOVS     R1,#+2
        B.N      ??ShutDownCheck_3G_5
//  873 	  else if (PwrAlarm.FwdInUpperLmtFail_3G) 			 ChkNorAlarmVal_3G = 3;
??ShutDownCheck_3G_6:
        LDRB     R1,[R1, #+10]
        CBZ      R1,??ShutDownCheck_3G_7
        MOVS     R1,#+3
??ShutDownCheck_3G_5:
        STRB     R1,[R6, #+1]
//  874 
//  875 	  SdChekcTime_3G = AlarmDelay2Time;	  ///100Sec
??ShutDownCheck_3G_7:
        MOVS     R1,#+9
        STR      R1,[R6, #+8]
//  876 
//  877 	  if(ChkNorAlarmVal_3G) ChkNorAlarm_3G = Alarm;
        LDRB     R1,[R6, #+1]
        CBZ      R1,??ShutDownCheck_3G_8
        MOVS     R1,#+1
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_3G_8
//  878 	}
//  879 
//  880 	else if(ChkNorAlarm_3G)
//  881 	{
//  882 	  if(ChkNorAlarmVal_3G == 1)
??ShutDownCheck_3G_3:
        LDRB     R1,[R6, #+1]
        CMP      R1,#+1
        BNE.N    ??ShutDownCheck_3G_9
//  883 	  {
//  884 		  if  ((PwrAlarm.RvsOutUpperLmtFail_3G))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_3G_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+24]
        B.N      ??ShutDownCheck_3G_10
//  885 		  else											tmpAlarm = Normal;
//  886 	  }
//  887 	  else if(ChkNorAlarmVal_3G == 2)
??ShutDownCheck_3G_9:
        CMP      R1,#+2
        BNE.N    ??ShutDownCheck_3G_11
//  888 	  {
//  889 		  if  ((PwrAlarm.FwdOutUpperLmtFail_3G))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_3G_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+9]
        B.N      ??ShutDownCheck_3G_10
//  890 		  else											tmpAlarm = Normal;
//  891 	  }	  
//  892 	  else if(ChkNorAlarmVal_3G == 3)
??ShutDownCheck_3G_11:
        CMP      R1,#+3
        BNE.N    ??ShutDownCheck_3G_8
//  893 	  {
//  894 		  if  ((PwrAlarm.FwdInUpperLmtFail_3G))	  		tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_3G_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+10]
??ShutDownCheck_3G_10:
        SUBS     R4,R1,#+1
        SBCS     R4,R4,R4
        MVNS     R4,R4
        LSRS     R4,R4,#+31
//  895 		  else											tmpAlarm = Normal;
//  896 	  }	  
//  897 	}
//  898 
//  899 	if(SdBuffClear_3G)
??ShutDownCheck_3G_8:
        LDRB     R1,[R6, #+3]
        CBZ      R1,??ShutDownCheck_3G_12
//  900 	{
//  901 	  SdStep_3G = _AlarmCheckStart;
        MOVS     R1,#+0
        STRB     R1,[R6, #+2]
//  902 	  SdBuffClear_3G = FALSE;
        STRB     R1,[R6, #+3]
//  903 
//  904 	  SdChekcTime_3G = Recovery4Time;
        MOVS     R1,#+4
        STR      R1,[R6, #+8]
//  905 
//  906 	  ChkNorAlarmVal_3G = 0;
        MOVS     R1,#+0
        STRB     R1,[R6, #+1]
//  907 	  ChkNorAlarm_3G = 0;
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_3G_13
//  908 	}   
//  909 
//  910 	if(SdChekcTime_3G > 0)SdChekcTime_3G--;
??ShutDownCheck_3G_12:
        LDR      R1,[R6, #+8]
        CBZ      R1,??ShutDownCheck_3G_14
??ShutDownCheck_3G_13:
        LDR      R1,[R6, #+8]
        SUBS     R1,R1,#+1
        STR      R1,[R6, #+8]
//  911 
//  912 	if(tDnrSts->TestMode == Debug_Rvs1SD)USART1Printf("0: SdStep_3G[%d]SdChekcTime_3G[%d]:[%d][%d]:[%d]\n", SdStep_3G,SdChekcTime_3G,tmpAlarm,Sts->AmpOnOff_3G,ChkNorAlarmVal_3G);
??ShutDownCheck_3G_14:
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+6
        BNE.N    ??ShutDownCheck_3G_15
        LDRB     R1,[R6, #+1]
        LDRB     R0,[R5, #+83]
        PUSH     {R0,R1}
        UXTB     R3,R4
        LDR      R2,[R6, #+8]
        LDRB     R1,[R6, #+2]
        LDR.N    R0,??ShutDownCheck_3G_1+0xC  ;; `?<Constant "0: SdStep_3G[%d]SdChe...">`
        BL       USART1Printf
        ADD      SP,SP,#+8
//  913 
//  914 	switch(SdStep_3G)
??ShutDownCheck_3G_15:
        LDRB     R0,[R6, #+2]
        CMP      R0,#+8
        BHI.N    ??ShutDownCheck_3G_2
        TBB      [PC, R0]
        DATA
??ShutDownCheck_3G_0:
        DC8      +5,+16,+39,+48
        DC8      +59,+68,+84,+93
        DC8      +100,+0
        THUMB
//  915 	{
//  916 		case 0:
//  917 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_16:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_3G_2
//  918 		  {
//  919 			  if(tmpAlarm == Alarm)
        UXTB     R4,R4
        CMP      R4,#+1
        BNE.N    ??ShutDownCheck_3G_17
//  920 			  {
//  921 				  SdStep_3G = 1;
        MOVS     R0,#+1
??ShutDownCheck_3G_18:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
//  922 			  }
//  923 			  else
//  924 			  {
//  925 				  SdBuffClear_3G = SET;
??ShutDownCheck_3G_17:
        B.W      ?Subroutine3
//  926 			  }
//  927 		  }
//  928 		break;
//  929 
//  930 		case 1:  //5 1번 amp off	 1
//  931 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_19:
        LDR      R0,[R6, #+8]
        CBNZ     R0,??ShutDownCheck_3G_20
//  932 		  {
//  933 			  AmpOff_3G(Disable);			  ///1
        MOVS     R0,#+1
        BL       AmpOff_3G
//  934 			  SdChekcTime_3G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  935 			  SdStep_3G = 2;
        MOVS     R0,#+2
        B.N      ??ShutDownCheck_3G_18
//  936 		  }
//  937 		  else if(tmpAlarm == Normal)
??ShutDownCheck_3G_20:
        UXTB     R4,R4
        CMP      R4,#+0
        BNE.N    ??ShutDownCheck_3G_2
//  938 		  {
//  939 			  SdNormalCnt_3G++;
        LDRB     R0,[R6, #+4]
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+4]
//  940 			  if(SdNormalCnt_3G > 2)
        UXTB     R0,R0
        CMP      R0,#+3
        BCC.N    ??ShutDownCheck_3G_2
//  941 			  {
//  942 				  AmpOff_3G(Enable);
        MOVS     R0,#+0
        BL       AmpOff_3G
//  943 				  SdBuffClear_3G = SET;
        B.W      ?Subroutine1
//  944 				  SdNormalCnt_3G = 0;
//  945 			  }
//  946 		  }   
//  947 		break;
//  948 
//  949 		case 2: //5 1번 amp on  2   
//  950 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_21:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_3G_2
//  951 		  {
//  952 			  AmpOff_3G(Enable);
        BL       AmpOff_3G
//  953 			  SdChekcTime_3G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  954 			  SdStep_3G = 3;
        MOVS     R0,#+3
        B.N      ??ShutDownCheck_3G_18
//  955 		  } 		  
//  956 		break;
//  957 
//  958 		case 3: ////5 2번 amp off   3
//  959 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_22:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_3G_20
//  960 		  {
//  961 			  AmpOff_3G(Disable);		  ///2
        MOVS     R0,#+1
        BL       AmpOff_3G
//  962 			  SdChekcTime_3G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  963 
//  964 			  SdStep_3G = 4;
        MOVS     R0,#+4
??ShutDownCheck_3G_23:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
//  965 		  }
//  966 		  else if(tmpAlarm == Normal)
//  967 		  {
//  968 			  SdNormalCnt_3G++;
//  969 			  if(SdNormalCnt_3G > 2)
//  970 			  {
//  971 				  AmpOff_3G(Enable);
//  972 				  SdBuffClear_3G = SET;
//  973 				  SdNormalCnt_3G = 0;
//  974 			  }
//  975 		  }
//  976 		break;  
//  977 
//  978 		case 4: //5 2번 amp on   4
//  979 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_24:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_3G_2
//  980 		  {
//  981 			  AmpOff_3G(Enable);
        BL       AmpOff_3G
//  982 			  SdChekcTime_3G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
//  983 			  SdStep_3G = 5;
        MOVS     R0,#+5
        B.N      ??ShutDownCheck_3G_18
//  984 		  }
//  985 		break;  
//  986 
//  987 		case 5: //5 //5 3번 amp off  5
//  988 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_25:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_3G_20
//  989 		  {
//  990 			  AmpOff_3G(Disable);		  ///3
        MOVS     R0,#+1
        BL       AmpOff_3G
//  991 			  if( Sts->ShunDown_Value == 0)   SdChekcTime_3G = Recovery3Time;
        LDRB     R0,[R5, #+828]
        CMP      R0,#+0
        ITE      EQ 
        MOVEQ    R0,#+3600
        MOVNE    R0,#+18
//  992 			  else							  SdChekcTime_3G = Recovery1Time;
        STR      R0,[R6, #+8]
//  993 
//  994 			  SdStep_3G = 6;
        MOVS     R0,#+6
        B.N      ??ShutDownCheck_3G_23
//  995 		  }
//  996 		  else if(tmpAlarm == Normal)
//  997 		  {
//  998 			  SdNormalCnt_3G++;
//  999 			  if(SdNormalCnt_3G > 2)
// 1000 			  {
// 1001 				  AmpOff_3G(Enable);
// 1002 				  SdBuffClear_3G = SET;
// 1003 				  SdNormalCnt_3G = 0;
// 1004 			  }
// 1005 		  }
// 1006 		break;  
// 1007 
// 1008 		case 6: //5	 6
// 1009 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_26:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_3G_20
// 1010 		  {
// 1011 			  AmpOff_3G(Enable);
        BL       AmpOff_3G
// 1012 			  SdChekcTime_3G = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1013 			  
// 1014 			  SdStep_3G = 7;
        MOVS     R0,#+7
        B.N      ??ShutDownCheck_3G_18
// 1015 		  } 	  
// 1016 		  else if(tmpAlarm == Normal)
// 1017 		  {
// 1018 			  SdNormalCnt_3G++;
// 1019 			  if(SdNormalCnt_3G > 2)
// 1020 			  {
// 1021 				  AmpOff_3G(Enable);
// 1022 				  SdBuffClear_3G = SET;
// 1023 				  SdNormalCnt_3G = 0;
// 1024 			  }
// 1025 		  }
// 1026 		break;  
// 1027 
// 1028 		case 7: //5  7
// 1029 		  if(!SdChekcTime_3G)
??ShutDownCheck_3G_27:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_3G_20
// 1030 		  {
// 1031 			  AmpOff_3G(Disable);
        MOVS     R0,#+1
        BL       AmpOff_3G
// 1032 			  SdStep_3G = 8;
        B.N      ?Subroutine2
// 1033 		  }
// 1034 		  else if(tmpAlarm == Normal)
// 1035 		  {
// 1036 			  SdNormalCnt_3G++;
// 1037 			  if(SdNormalCnt_3G > 2)
// 1038 			  {
// 1039 				  AmpOff_3G(Enable);
// 1040 				  SdBuffClear_3G = SET;
// 1041 				  SdNormalCnt_3G = 0;
// 1042 			  }
// 1043 		  }
// 1044 		break;  
// 1045 
// 1046 		case 8: //5
// 1047 		  AmpOff_3G(Disable);
??ShutDownCheck_3G_28:
        MOVS     R0,#+1
        BL       AmpOff_3G
??ShutDownCheck_3G_2:
        POP      {R4-R6,PC}       ;; return
        DATA
??ShutDownCheck_3G_1:
        DC32     tDnrSts
        DC32     ChkNorAlarm_3G
        DC32     PwrAlarm
        DC32     `?<Constant "0: SdStep_3G[%d]SdChe...">`
// 1048 		break;  
// 1049 	}
// 1050 }
// 1051 
// 1052 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1053 void AmpOff_Common(INT8U Index)
// 1054 {
// 1055 	tDnrSts->AmpOnOff_Common = Index;
AmpOff_Common:
        LDR.N    R1,??AmpOff_Common_0  ;; tDnrSts
        LDR      R2,[R1, #+0]
        STRB     R0,[R2, #+84]
// 1056 	PwrAlarm.AmpOnOff_Common = tDnrSts->AmpOnOff_Common;
        LDR      R0,[R1, #+0]
        LDRB     R0,[R0, #+84]
        LDR.N    R1,??AmpOff_Common_0+0x4  ;; PwrAlarm
        STRB     R0,[R1, #+28]
// 1057 }
        BX       LR               ;; return
        DATA
??AmpOff_Common_0:
        DC32     tDnrSts
        DC32     PwrAlarm
// 1058 
// 1059 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1060 void AmpOff_3G(INT8U Index)
// 1061 {
// 1062 	tDnrSts->AmpOnOff_3G = Index;
AmpOff_3G:
        LDR.N    R1,??AmpOff_3G_0  ;; tDnrSts
        LDR      R2,[R1, #+0]
        STRB     R0,[R2, #+83]
// 1063 	PwrAlarm.AmpOnOff_3G = tDnrSts->AmpOnOff_3G;
        LDR      R0,[R1, #+0]
        LDRB     R0,[R0, #+83]
        LDR.N    R1,??AmpOff_3G_0+0x4  ;; PwrAlarm
        STRB     R0,[R1, #+29]
// 1064 }
        BX       LR               ;; return
        DATA
??AmpOff_3G_0:
        DC32     tDnrSts
        DC32     PwrAlarm
// 1065 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1066 void AmpOff_LTE_A(INT8U Index)
// 1067 {
// 1068 	tDnrSts->AmpOnOff_LTE_A = Index;
AmpOff_LTE_A:
        LDR.N    R1,??AmpOff_LTE_A_0  ;; tDnrSts
        LDR      R2,[R1, #+0]
        STRB     R0,[R2, #+85]
// 1069 	PwrAlarm.AmpOnOff_LTE_A = tDnrSts->AmpOnOff_LTE_A;
        LDR      R0,[R1, #+0]
        LDRB     R0,[R0, #+85]
        LDR.N    R1,??AmpOff_LTE_A_0+0x4  ;; PwrAlarm
        STRB     R0,[R1, #+27]
// 1070 }
        BX       LR               ;; return
        DATA
??AmpOff_LTE_A_0:
        DC32     tDnrSts
        DC32     PwrAlarm
// 1071 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1072 void Amp1Off_LTE(INT8U Index)
// 1073 {
// 1074 	tDnrSts->Amp1OnOff_LTE = Index;
Amp1Off_LTE:
        LDR.N    R1,??Amp1Off_LTE_0  ;; tDnrSts
        LDR      R2,[R1, #+0]
        STRB     R0,[R2, #+678]
// 1075 	PwrAlarm.Amp1OnOff_LTE = tDnrSts->Amp1OnOff_LTE;
        LDR      R0,[R1, #+0]
        LDRB     R0,[R0, #+678]
        LDR.N    R1,??Amp1Off_LTE_0+0x4  ;; PwrAlarm
        STRB     R0,[R1, #+26]
// 1076 }
        BX       LR               ;; return
        DATA
??Amp1Off_LTE_0:
        DC32     tDnrSts
        DC32     PwrAlarm
// 1077 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1078 void Amp1Off_LTE_A(INT8U Index)
// 1079 {
// 1080 	tDnrSts->Amp1OnOff_LTE_A = Index;
Amp1Off_LTE_A:
        LDR.N    R1,??Amp1Off_LTE_A_0  ;; tDnrSts
        LDR      R2,[R1, #+0]
        STRB     R0,[R2, #+677]
// 1081 	PwrAlarm.Amp1OnOff_LTE_A = tDnrSts->Amp1OnOff_LTE_A;
        LDR      R0,[R1, #+0]
        LDRB     R0,[R0, #+677]
        LDR.N    R1,??Amp1Off_LTE_A_0+0x4  ;; PwrAlarm
        STRB     R0,[R1, #+25]
// 1082 }
        BX       LR               ;; return
        DATA
??Amp1Off_LTE_A_0:
        DC32     tDnrSts
        DC32     PwrAlarm
// 1083 
// 1084 
// 1085 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1086 void AmpOff_All(INT8U Index)
// 1087 {
AmpOff_All:
        PUSH     {R3,R4}
// 1088 	tDnrSts->AmpOnOff_Common = Index;
        LDR.N    R1,??AmpOff_All_0  ;; tDnrSts
        LDR      R2,[R1, #+0]
        STRB     R0,[R2, #+84]
// 1089 	PwrAlarm.AmpOnOff_Common = tDnrSts->AmpOnOff_Common;
        LDR      R3,[R1, #+0]
        LDR.N    R2,??AmpOff_All_0+0x4  ;; PwrAlarm
        ADD      R4,R3,#+83
        LDRB     R4,[R4, #+1]
        STRB     R4,[R2, #+28]
// 1090 
// 1091 	tDnrSts->AmpOnOff_3G = Index;
        STRB     R0,[R3, #+83]
// 1092 	PwrAlarm.AmpOnOff_3G = tDnrSts->AmpOnOff_3G;
        LDR      R3,[R1, #+0]
        LDRB     R4,[R3, #+83]
        STRB     R4,[R2, #+29]
// 1093 
// 1094 	tDnrSts->AmpOnOff_LTE_A = Index;
        ADDS     R3,R3,#+83
        STRB     R0,[R3, #+2]
// 1095 	PwrAlarm.AmpOnOff_LTE_A = tDnrSts->AmpOnOff_LTE_A;
        LDR      R3,[R1, #+0]
        LDRB     R4,[R3, #+85]
        STRB     R4,[R2, #+27]
// 1096 
// 1097 	tDnrSts->Amp1OnOff_LTE = Index;
        STRB     R0,[R3, #+678]
// 1098 	PwrAlarm.Amp1OnOff_LTE = tDnrSts->Amp1OnOff_LTE;	
        LDR      R3,[R1, #+0]
        ADDW     R4,R3,#+677
        LDRB     R4,[R4, #+1]
        STRB     R4,[R2, #+26]
// 1099 
// 1100 	tDnrSts->Amp1OnOff_LTE_A = Index;
        STRB     R0,[R3, #+677]
// 1101 	PwrAlarm.Amp1OnOff_LTE_A = tDnrSts->Amp1OnOff_LTE_A;		
        LDR      R0,[R1, #+0]
        LDRB     R0,[R0, #+677]
        STRB     R0,[R2, #+25]
// 1102 }
        POP      {R0,R4}
        BX       LR               ;; return
        DATA
??AmpOff_All_0:
        DC32     tDnrSts
        DC32     PwrAlarm
// 1103 
// 1104 
// 1105 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1106 INT8S ALCCheck(INT32S tmpx10,INT32S tlimitLow,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax, INT8U AttMin, INT8U Mode)
// 1107 {
ALCCheck:
        PUSH     {R4-R7}
        MOV      R7,R0
        LDR      R6,[SP, #+16]
        LDR      R5,[SP, #+20]
        LDR      R4,[SP, #+24]
// 1108 	INT32S gap;
// 1109 	INT32S tmpTotAttn;
// 1110 
// 1111 	tmpTotAttn = *tmpALCAttn;
        LDRSB    R0,[R3, #+0]
// 1112 
// 1113 	if(tmpOnOff != Enable) return FALSE;
        CMP      R2,#+0
        BEQ.N    ??ALCCheck_0
??ALCCheck_1:
        MOVS     R0,#+0
        POP      {R4-R7}
        BX       LR
// 1114 	gap = tmpx10 - tlimitLow;
??ALCCheck_0:
        SUBS     R1,R7,R1
// 1115 	if(abs(gap) == 1) return FALSE;
        MOVS     R2,R1
        BPL.N    ??ALCCheck_2
        RSBS     R2,R2,#+0
??ALCCheck_2:
        CMP      R2,#+1
        BEQ.N    ??ALCCheck_1
// 1116 
// 1117 	if( Mode == TRUE)
        CMP      R4,#+1
        BNE.N    ??ALCCheck_3
// 1118 	{
// 1119 		if(gap >  10L) gap = 10L;
        CMP      R1,#+11
        BLT.N    ??ALCCheck_4
        MOVS     R1,#+10
        B.N      ??ALCCheck_5
// 1120 		if(gap < -4L) gap = -4L;
??ALCCheck_4:
        MVN      R2,#+3
        CMP      R1,R2
        BGE.N    ??ALCCheck_5
        MOV      R1,R2
        B.N      ??ALCCheck_5
// 1121 	}
// 1122 	else
// 1123 	{
// 1124 		if(gap > 0)
??ALCCheck_3:
        CMP      R1,#+1
        BLT.N    ??ALCCheck_6
// 1125 		{
// 1126 //			if(gap >  10L) gap = 10L;
// 1127 			if(gap >  4L) gap = 4L;
        CMP      R1,#+5
        BLT.N    ??ALCCheck_5
        MOVS     R1,#+4
        B.N      ??ALCCheck_5
// 1128 		}
// 1129 		else gap = 0;
??ALCCheck_6:
        MOVS     R1,#+0
// 1130 	}
// 1131 
// 1132 	tmpTotAttn  += gap;
??ALCCheck_5:
        ADDS     R0,R1,R0
// 1133 	if(tmpTotAttn  > AttMax ) 	tmpTotAttn  = AttMax;
        CMP      R6,R0
        BGE.N    ??ALCCheck_7
        MOV      R0,R6
// 1134 	if(tmpTotAttn  < AttMin ) 	tmpTotAttn  = AttMin;
??ALCCheck_7:
        CMP      R0,R5
        BGE.N    ??ALCCheck_8
        MOV      R0,R5
// 1135 
// 1136 	*tmpALCAttn = tmpTotAttn;
??ALCCheck_8:
        STRB     R0,[R3, #+0]
// 1137 
// 1138 
// 1139   	return tmpTotAttn;    
        SXTB     R0,R0
        POP      {R4-R7}
        BX       LR               ;; return
// 1140 }
// 1141 
// 1142 
// 1143 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1144 INT8U TemptoIndex(INT8S temp)
// 1145 {
TemptoIndex:
        MOV      R1,R0
// 1146 	INT32U i = 0;
// 1147 //	INT8S toffset = (80 - 5);
// 1148 	INT8S toffset = (Temp_limit - 5);
        MOVS     R2,#+85
// 1149 
// 1150 	for(i = 0; toffset < Temp_limit; i++, toffset -= 5)
        MOVS     R0,#+0
        B.N      ??TemptoIndex_0
??TemptoIndex_1:
        ADDS     R0,R0,#+1
        SUBS     R2,R2,#+5
        SXTB     R2,R2
        CMP      R2,#+90
        BGE.N    ??TemptoIndex_2
// 1151 	{
// 1152 		if(temp >= toffset) return i;
??TemptoIndex_0:
        CMP      R1,R2
        BLT.N    ??TemptoIndex_1
??TemptoIndex_2:
        UXTB     R0,R0
        BX       LR               ;; return
// 1153 	}
// 1154 	
// 1155 	return (i--);
// 1156 }
// 1157 
// 1158 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1159 void FwdAGCCheckFunction(void)
// 1160 {
FwdAGCCheckFunction:
        PUSH     {R3-R9,LR}
// 1161 //	INT32S tmpPwr;
// 1162 //	INT32S tlimit;
// 1163 	INT8S tmpPwr;
// 1164 	INT8S tlimit;
// 1165 
// 1166 	__Dnr_Sts  *Sts = tDnrSts; 
        LDR.N    R0,??DataTable12  ;; tDnrSts
        LDR      R4,[R0, #+0]
// 1167 	#if 0
// 1168 	if(Sts->AGCOnOff_3G == Disable ) return;
// 1169 
// 1170 	tmpPwr = Sts->FwdOutPwr_3G[0]*10L + Sts->FwdOutPwr_3G[1];
// 1171 	tlimit = Sts->FwdOutUpperLmt_3G[0]*10L + Sts->FwdOutUpperLmt_3G[1];
// 1172 
// 1173 	Sts->AGCAttnMAX_2G = 40*2;
// 1174 
// 1175 	AGCCheck(tmpPwr, tlimit,Sts->AGCOnOff_3G, &Sts->FwdAGCAttnInit_3G,Sts->AGCAttnMAX_2G,ATTENMIN);
// 1176 	Sts->FwdAgcAttn_3G	=  Sts->FwdAGCAttnInit_3G;
// 1177 	if(Sts->FwdAgcAttn_3G  < ATTENMIN ) 	Sts->FwdAgcAttn_3G  = ATTENMIN;
// 1178 	#endif
// 1179 
// 1180 	if( Sts->AGCMode_3G == _AGCAvgMode)
        ADDW     R8,R4,#+297
        ADD      R6,R4,#+93
        LDRB     R0,[R6, #+2]
        CMP      R0,#+0
        ITE      EQ 
        LDRSBEQ  R5,[R8, #+17]
        LDRSBNE  R5,[R8, #+18]
// 1181 	{
// 1182  		tmpPwr = Sts->DetPwr.FwdOutAvg_3G;
// 1183   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_3G);
// 1184  	}
// 1185 	else
// 1186 	{
// 1187 		tmpPwr = Sts->DetPwr.FwdOutPeak_3G;
// 1188   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_3G);
        ADD      R0,R4,#+38
        BL       OneOutPwrConv
        MOV      R12,R0
// 1189  	}
// 1190  	Sts->AGCAttnMAX_3G = 40*2;
        ADDW     R7,R4,#+831
        MOVS     R0,#+80
        STRB     R0,[R7, #+1]
// 1191  	AGCCheck(tmpPwr, tlimit,Sts->AGCOnOff_3G, &Sts->FwdAGCAttnInit_3G, Sts->AGCAttnMAX_3G, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+838
        LDRSB    R2,[R4, #+93]
        MOV      R1,R12
        MOV      R0,R5
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1192 	Sts->FwdAgcAttn_3G	=  Sts->FwdAGCAttnInit_3G;
        ADD      R5,R4,#+464
        LDRB     R0,[R7, #+7]
        STRB     R0,[R5, #+3]
// 1193 
// 1194 
// 1195 	if( Sts->AGCMode_2G == _AGCAvgMode)
        LDRB     R0,[R6, #+3]
        CMP      R0,#+0
        ITE      EQ 
        LDRSBEQ  R9,[R4, #+297]
        LDRSBNE  R9,[R8, #+1]
// 1196 	{
// 1197  		tmpPwr = Sts->DetPwr.FwdOutAvg_2G;
// 1198   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_2G);
// 1199  	}
// 1200 	else
// 1201 	{
// 1202 		tmpPwr = Sts->DetPwr.FwdOutPeak_2G;
// 1203   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_2G);
        ADD      R0,R4,#+46
        BL       OneOutPwrConv
        MOV      R12,R0
// 1204  	}
// 1205  	Sts->AGCAttnMAX_2G = 25*2;
        MOVS     R0,#+50
        STRB     R0,[R4, #+831]
// 1206  	AGCCheck(tmpPwr, tlimit,Sts->AGCOnOff_2G, &Sts->FwdAGCAttnInit_2G, Sts->AGCAttnMAX_2G, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+837
        LDRSB    R2,[R6, #+1]
        MOV      R1,R12
        MOV      R0,R9
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1207 	Sts->FwdAgcAttn_2G	=  Sts->FwdAGCAttnInit_2G;
        LDRB     R0,[R7, #+6]
        STRB     R0,[R4, #+464]
// 1208 
// 1209 
// 1210 	if( Sts->AGCMode_LTE == _AGCAvgMode)
        LDRB     R0,[R6, #+6]
        CMP      R0,#+0
        ITE      EQ 
        LDRSBEQ  R9,[R8, #+9]
        LDRSBNE  R9,[R8, #+10]
// 1211 	{
// 1212  		tmpPwr = Sts->DetPwr.FwdOutAvg_LTE;
// 1213   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE);
// 1214  	}
// 1215 	else
// 1216 	{
// 1217 		tmpPwr = Sts->DetPwr.FwdOutPeak_LTE;
// 1218   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE);
        ADD      R0,R4,#+54
        BL       OneOutPwrConv
        MOV      R12,R0
// 1219  	}
// 1220  	Sts->AGCAttnMAX_LTE = 25*2;
        MOVS     R0,#+50
        STRB     R0,[R7, #+2]
// 1221  	AGCCheck(tmpPwr, tlimit,Sts->AGCOnOff_LTE, &Sts->FwdAGCAttnInit_LTE, Sts->AGCAttnMAX_LTE, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+839
        LDRSB    R2,[R6, #+4]
        MOV      R1,R12
        MOV      R0,R9
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1222 	Sts->FwdAgcAttn_LTE	=  Sts->FwdAGCAttnInit_LTE;
        LDRB     R0,[R7, #+8]
        STRB     R0,[R5, #+1]
// 1223 
// 1224 
// 1225 
// 1226 	if( Sts->AGCMode_LTE_A == _AGCAvgMode)
        LDRB     R0,[R6, #+7]
        CMP      R0,#+0
        ITE      EQ 
        LDRSBEQ  R8,[R8, #+13]
        LDRSBNE  R8,[R8, #+14]
// 1227 	{
// 1228  		tmpPwr = Sts->DetPwr.FwdOutAvg_LTE_A;
// 1229   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE_A);
// 1230  	}
// 1231 	else
// 1232 	{
// 1233 		tmpPwr = Sts->DetPwr.FwdOutPeak_LTE_A;
// 1234   		tlimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE_A);
        ADD      R0,R4,#+62
        BL       OneOutPwrConv
        MOV      R12,R0
// 1235  	}
// 1236  	Sts->AGCAttnMAX_LTE_A= 25*2;
        MOVS     R0,#+50
        STRB     R0,[R7, #+3]
// 1237  	AGCCheck(tmpPwr, tlimit,Sts->AGCOnOff_LTE_A, &Sts->FwdAGCAttnInit_LTE_A, Sts->AGCAttnMAX_LTE_A, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADD      R3,R4,#+840
        LDRSB    R2,[R6, #+5]
        MOV      R1,R12
        MOV      R0,R8
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1238 	Sts->FwdAgcAttn_LTE_A = Sts->FwdAGCAttnInit_LTE_A;
        LDRB     R0,[R7, #+9]
        STRB     R0,[R5, #+2]
// 1239 
// 1240 
// 1241 	if( Sts->AGCMode_LTE == _AGCAvgMode)
        ADDW     R8,R4,#+709
        ADDW     R0,R4,#+657
        LDRB     R1,[R6, #+6]
        CMP      R1,#+0
        ITE      EQ 
        LDRSBEQ  R5,[R4, #+709]
        LDRSBNE  R5,[R8, #+1]
// 1242 	{
// 1243  		tmpPwr = Sts->Det1Pwr.Fwd1OutAvg_LTE;
// 1244   		tlimit = OneOutPwrConv(Sts->Fwd1OutUpperLmt_LTE);
// 1245  	}
// 1246 	else
// 1247 	{
// 1248 		tmpPwr = Sts->Det1Pwr.Fwd1OutPeak_LTE;
// 1249   		tlimit = OneOutPwrConv(Sts->Fwd1OutUpperLmt_LTE);
        BL       OneOutPwrConv
        MOV      R12,R0
// 1250  	}
// 1251  	Sts->AGC1AttnMAX_LTE = 40*2;
        MOVS     R0,#+80
        STRB     R0,[R7, #+4]
// 1252  	AGCCheck(tmpPwr, tlimit,Sts->AGC1OnOff_LTE, &Sts->Fwd1AGCAttnInit_LTE, Sts->AGC1AttnMAX_LTE, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+841
        LDRSB    R2,[R6, #+8]
        MOV      R1,R12
        MOV      R0,R5
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1253 	Sts->Fwd1AgcAttn_LTE	=  Sts->Fwd1AGCAttnInit_LTE;
        LDRB     R0,[R7, #+10]
        STRB     R0,[R4, #+793]
// 1254 
// 1255 	if( Sts->AGCMode_LTE == _AGCAvgMode)
        ADDW     R0,R4,#+665
        LDRB     R1,[R6, #+6]
        CMP      R1,#+0
        ITE      EQ 
        LDRSBEQ  R8,[R8, #+4]
        LDRSBNE  R8,[R8, #+5]
// 1256 	{
// 1257  		tmpPwr = Sts->Det1Pwr.Fwd1OutAvg_LTE_A;
// 1258   		tlimit = OneOutPwrConv(Sts->Fwd1OutUpperLmt_LTE_A);
// 1259  	}
// 1260 	else
// 1261 	{
// 1262 		tmpPwr = Sts->Det1Pwr.Fwd1OutPeak_LTE_A;
// 1263   		tlimit = OneOutPwrConv(Sts->Fwd1OutUpperLmt_LTE_A);
        BL       OneOutPwrConv
        MOV      R5,R0
// 1264  	}
// 1265  	Sts->AGC1AttnMAX_LTE_A = 45*2;
        MOVS     R0,#+90
        STRB     R0,[R7, #+5]
// 1266  	AGCCheck(tmpPwr, tlimit,Sts->AGC1OnOff_LTE_A, &Sts->Fwd1AGCAttnInit_LTE_A, Sts->AGC1AttnMAX_LTE_A, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+842
        LDRSB    R2,[R6, #+9]
        MOV      R1,R5
        MOV      R0,R8
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1267 	Sts->Fwd1AgcAttn_LTE_A = Sts->Fwd1AGCAttnInit_LTE_A;
        ADDW     R0,R4,#+793
        LDRB     R1,[R7, #+11]
        STRB     R1,[R0, #+1]
// 1268 
// 1269 	FwdALCCheckFunction();
        POP      {R0,R4-R9,LR}
        Nop      
        REQUIRE FwdALCCheckFunction
        ;; // Fall through to label FwdALCCheckFunction
// 1270 }
// 1271 /*
// 1272 1. DET2에 의한ㅣ CDMA AGC/ALC  ATT-25dBㅣ
// 1273 2. DET4에 의한ㅣ LTE AGC/ALC  ATT-25dBㅣ
// 1274 
// 1275 3. 타사 과입력 ALC ATT= ㅣ(DET1-CDMA Tx입력 Display)-25dBㅣ          
// 1276 4. 타사 과입력 ALC ATT= ㅣ(DET1-LTE Tx입력 Display)-25dBㅣ         
// 1277 
// 1278 *ATT1 = 1번 & 2번 값 중 큰값 + 3번 & 4번 중 큰값
// 1279 
// 1280 
// 1281 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1282 void FwdALCCheckFunction(void)
// 1283 {
FwdALCCheckFunction:
        PUSH     {R3-R5,LR}
// 1284 //	INT8S tmpPwr;
// 1285 //	INT8S tlimit;
// 1286 
// 1287 	INT8S tmpAtt_2G;
// 1288 	INT8S tmpAtt_LTE;
// 1289 
// 1290 
// 1291 	__Dnr_Sts  *Sts = tDnrSts; 
        LDR.N    R0,??DataTable12  ;; tDnrSts
        LDR      R4,[R0, #+0]
// 1292 
// 1293 
// 1294 	tmpAtt_2G  = (Sts->DetPwr.FwdIn_Common -  Sts->SmsFwdInPwr_2G) - 25*2;
// 1295 	tmpAtt_2G  = MinMaxAttnCheck(tmpAtt_2G, DIGFwdALCATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+20
        ADD      R0,R4,#+195
        LDRB     R0,[R0, #+106]
        LDRB     R3,[R4, #+195]
        SUBS     R0,R0,R3
        SUBS     R0,R0,#+50
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        MOV      R5,R0
// 1296 	
// 1297 	tmpAtt_LTE = (Sts->DetPwr.FwdIn_Common -  Sts->SmsFwdInPwr_LTE) - 25*2;
// 1298 	tmpAtt_LTE = MinMaxAttnCheck(tmpAtt_2G, DIGFwdALCATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+20
        BL       MinMaxAttnCheck
// 1299 
// 1300 
// 1301 	if(tmpAtt_2G > tmpAtt_LTE)
        CMP      R0,R5
        BLT.N    ??FwdALCCheckFunction_0
// 1302 	{
// 1303 		Sts->FwdAttn2_Common = tmpAtt_2G;
// 1304 	}
// 1305 	else
// 1306 	{
// 1307 		Sts->FwdAttn2_Common = tmpAtt_LTE;
        MOV      R5,R0
??FwdALCCheckFunction_0:
        ADD      R0,R4,#+434
        STRB     R5,[R0, #+0]
// 1308 	}
// 1309 
// 1310 }
        POP      {R0,R4,R5,PC}    ;; return
// 1311 
// 1312 
// 1313 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1314 void RvsALCCheckFunction(void)
// 1315 {
RvsALCCheckFunction:
        PUSH     {R3-R7,LR}
// 1316 #if 0
// 1317 	INT32S tmpPwr;
// 1318 	INT32S tlimit;
// 1319 	INT32S tAttnMax;
// 1320 	INT8U tOnOff;
// 1321 	INT8S tAttnInit;
// 1322 #endif
// 1323 	INT8S tmpPwr;
// 1324 	INT8S tlimit;
// 1325 
// 1326 	__Dnr_Sts  *Sts = tDnrSts; 
        LDR.N    R0,??DataTable12  ;; tDnrSts
        LDR      R4,[R0, #+0]
// 1327 
// 1328 	tmpPwr = Sts->Det2Pwr.RvsAlcInPwr_3G;
        ADDW     R5,R4,#+517
        LDRSB    R12,[R5, #+36]
// 1329 	tlimit = Sts->RvsALCLvl_3G;
        LDRSB    LR,[R5, #+3]
// 1330 	Sts->AlcAttnMAX_3G = 40*2;
        ADDW     R6,R4,#+843
        MOVS     R0,#+80
        STRB     R0,[R6, #+1]
// 1331 	AGCCheck(tmpPwr, tlimit,Sts->RvsAlcOnOff_3G, &Sts->RvsAlcAttnInit_3G, Sts->AlcAttnMAX_3G, ATTENMIN);
        ADD      R7,R4,#+468
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+850
        LDRSB    R2,[R7, #+7]
        MOV      R1,LR
        MOV      R0,R12
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1332 	Sts->RvsAlcAttn_3G	=  Sts->RvsAlcAttnInit_3G;
        LDRB     R0,[R6, #+7]
        STRB     R0,[R7, #+3]
// 1333 
// 1334 	
// 1335 	tmpPwr = Sts->Det2Pwr.RvsAlcInPwr_2G;
        LDRSB    R12,[R5, #+33]
// 1336 	tlimit = Sts->RvsALCLvl_2G;
        LDRSB    LR,[R4, #+517]
// 1337 	Sts->AlcAttnMAX_2G = 40*2;
        MOVS     R0,#+80
        STRB     R0,[R4, #+843]
// 1338  	AGCCheck(tmpPwr, tlimit,Sts->RvsAlcOnOff_2G, &Sts->RvsAlcAttnInit_2G, Sts->AlcAttnMAX_2G, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+849
        LDRSB    R2,[R7, #+4]
        MOV      R1,LR
        MOV      R0,R12
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1339 	Sts->RvsAlcAttn_2G	=  Sts->RvsAlcAttnInit_2G;
        LDRB     R0,[R6, #+6]
        STRB     R0,[R4, #+468]
// 1340 
// 1341 	tmpPwr = Sts->Det2Pwr.RvsAlcInPwr_LTE;
        LDRSB    R12,[R5, #+34]
// 1342 	tlimit = Sts->RvsALCLvl_LTE;
        LDRSB    LR,[R5, #+1]
// 1343 	Sts->AlcAttnMAX_LTE = 40*2;
        MOVS     R0,#+80
        STRB     R0,[R6, #+2]
// 1344  	AGCCheck(tmpPwr, tlimit,Sts->RvsAlcOnOff_LTE, &Sts->RvsAlcAttnInit_LTE, Sts->AlcAttnMAX_LTE, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+851
        LDRSB    R2,[R7, #+5]
        MOV      R1,LR
        MOV      R0,R12
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1345 	Sts->RvsAlcAttn_LTE=  Sts->RvsAlcAttnInit_LTE;
        LDRB     R0,[R6, #+8]
        STRB     R0,[R7, #+1]
// 1346 
// 1347 
// 1348 	tmpPwr = Sts->Det2Pwr.RvsAlcInPwr_LTE_A;
        LDRSB    R12,[R5, #+35]
// 1349 	tlimit = Sts->RvsALCLvl_LTE_A;
        LDRSB    LR,[R5, #+2]
// 1350 	Sts->AlcAttnMAX_LTE_A = 40*2;
        MOVS     R0,#+80
        STRB     R0,[R6, #+3]
// 1351  	AGCCheck(tmpPwr, tlimit,Sts->RvsAlcOnOff_LTE_A, &Sts->RvsAlcAttnInit_LTE_A, Sts->AlcAttnMAX_LTE_A, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADD      R3,R4,#+852
        LDRSB    R2,[R7, #+6]
        MOV      R1,LR
        MOV      R0,R12
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1352 	Sts->RvsAlcAttn_LTE_A =  Sts->RvsAlcAttnInit_LTE_A;
        LDRB     R0,[R6, #+9]
        STRB     R0,[R7, #+2]
// 1353 
// 1354 
// 1355 	tmpPwr = Sts->Det2Pwr.Rvs1AlcInPwr_LTE;
        LDRSB    R12,[R5, #+37]
// 1356 	tlimit = Sts->Rvs1ALCLvl_LTE;
        ADDW     R7,R4,#+795
        LDRSB    LR,[R7, #+28]
// 1357 	Sts->Alc1AttnMAX_LTE = 40*2;
        MOVS     R0,#+80
        STRB     R0,[R6, #+4]
// 1358  	AGCCheck(tmpPwr, tlimit,Sts->Rvs1AlcOnOff_LTE, &Sts->Rvs1AlcAttnInit_LTE, Sts->Alc1AttnMAX_LTE, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+853
        LDRSB    R2,[R7, #+2]
        MOV      R1,LR
        MOV      R0,R12
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1359 	Sts->Rvs1AlcAttn_LTE=  Sts->Rvs1AlcAttnInit_LTE;
        LDRB     R0,[R6, #+10]
        STRB     R0,[R4, #+795]
// 1360 
// 1361 
// 1362 	tmpPwr = Sts->Det2Pwr.Rvs1AlcInPwr_LTE_A;
        LDRSB    R5,[R5, #+38]
// 1363 	tlimit = Sts->Rvs1ALCLvl_LTE_A;
        LDRSB    R12,[R7, #+29]
// 1364 	Sts->Alc1AttnMAX_LTE_A = 40*2;
        MOVS     R0,#+80
        STRB     R0,[R6, #+5]
// 1365  	AGCCheck(tmpPwr, tlimit,Sts->Rvs1AlcOnOff_LTE_A, &Sts->Rvs1AlcAttnInit_LTE_A, Sts->Alc1AttnMAX_LTE_A, ATTENMIN);
        MOVS     R1,#+0
        PUSH     {R0,R1}
        ADDW     R3,R4,#+854
        LDRSB    R2,[R7, #+3]
        MOV      R1,R12
        MOV      R0,R5
        BL       AGCCheck
        ADD      SP,SP,#+8
// 1366 	Sts->Rvs1AlcAttn_LTE_A =  Sts->Rvs1AlcAttnInit_LTE_A;
        LDRB     R0,[R6, #+11]
        STRB     R0,[R7, #+1]
// 1367 
// 1368 
// 1369 	RvsALCCheckCommon();
        POP      {R0,R4-R7,LR}
        REQUIRE RvsALCCheckCommon
        ;; // Fall through to label RvsALCCheckCommon
// 1370 
// 1371 }
// 1372 
// 1373 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1374 void RvsALCCheckCommon(void)
// 1375 {
RvsALCCheckCommon:
        PUSH     {R4-R6,LR}
// 1376 	INT8S tmpAtt_2G;
// 1377 	INT8S tmpAtt_LTE;
// 1378 
// 1379 	INT8S tmp1Att_2G;
// 1380 	INT8S tmp1Att_LTE;
// 1381 
// 1382 
// 1383 	__Dnr_Sts  *Sts = tDnrSts; 
        LDR.N    R0,??DataTable12  ;; tDnrSts
        LDR      R4,[R0, #+0]
// 1384 
// 1385 
// 1386 	tmpAtt_2G  = (Sts->DetPwr.RvsIn_Common -  Sts->CurrRvsInPwr_2G) - 25*2;
// 1387 	tmpAtt_2G  = MinMaxAttnCheck(tmpAtt_2G, DIGFwdALCATTENMAX,ATTENMIN);
        ADDW     R5,R4,#+431
        MOVS     R2,#+0
        MOVS     R1,#+20
        LDRB     R0,[R4, #+304]
        LDRB     R3,[R5, #+54]
        SUBS     R0,R0,R3
        SUBS     R0,R0,#+50
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        MOV      R6,R0
// 1388 	
// 1389 	tmpAtt_LTE = (Sts->DetPwr.FwdIn_Common -  Sts->CurrRvsInPwr_LTE) - 25*2;
// 1390 	tmpAtt_LTE = MinMaxAttnCheck(tmpAtt_2G, DIGFwdALCATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+20
        BL       MinMaxAttnCheck
// 1391 
// 1392 
// 1393 	if(tmpAtt_2G > tmpAtt_LTE)
        CMP      R0,R6
        BLT.N    ??RvsALCCheckCommon_0
// 1394 	{
// 1395 		Sts->RvsAttn2_Common = tmpAtt_2G;
// 1396 	}
// 1397 	else
// 1398 	{
// 1399 		Sts->RvsAttn2_Common = tmpAtt_LTE;
        MOV      R6,R0
??RvsALCCheckCommon_0:
        STRB     R6,[R5, #+4]
// 1400 	}
// 1401 
// 1402 	tmp1Att_2G = Sts->RvsAlcAttn_2G - 25*2;
// 1403 	tmp1Att_2G  = MinMaxAttnCheck(tmp1Att_2G, DIGFwdALCATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+20
        LDRB     R0,[R5, #+37]
        SUBS     R0,R0,#+50
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        MOV      R6,R0
// 1404 
// 1405 	tmp1Att_LTE = Sts->RvsAlcAttn_LTE - 25*2;
// 1406 	tmp1Att_LTE = MinMaxAttnCheck(tmp1Att_LTE, DIGFwdALCATTENMAX,ATTENMIN);	
        MOVS     R2,#+0
        MOVS     R1,#+20
        LDRB     R0,[R5, #+38]
        SUBS     R0,R0,#+50
        SXTB     R0,R0
        BL       MinMaxAttnCheck
// 1407 
// 1408 	if(tmp1Att_2G > tmp1Att_LTE)
        CMP      R0,R6
        BLT.N    ??RvsALCCheckCommon_1
// 1409 	{
// 1410 		Sts->RvsAttn3_Common = tmp1Att_2G;
// 1411 	}
// 1412 	else
// 1413 	{
// 1414 		Sts->RvsAttn3_Common = tmp1Att_LTE;
        MOV      R6,R0
??RvsALCCheckCommon_1:
        STRB     R6,[R5, #+6]
// 1415 	}
// 1416 
// 1417 	if(Sts->RvsAttn2_Common > Sts->RvsAttn3_Common)
        LDRB     R0,[R5, #+6]
        LDRB     R1,[R5, #+4]
        CMP      R0,R1
        BCS.N    ??RvsALCCheckCommon_2
        MOV      R0,R1
??RvsALCCheckCommon_2:
        STRB     R0,[R4, #+431]
// 1418 	{
// 1419 		Sts->RvsAttn1_Common = Sts->RvsAttn2_Common;
// 1420 	}
// 1421 	else
// 1422 	{
// 1423 		Sts->RvsAttn1_Common = Sts->RvsAttn3_Common;
// 1424 	}	
// 1425 
// 1426 }
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     tDnrSts
// 1427 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1428 INT8S AGCCheck(INT32S tmpx10,INT32S tlimitLow,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax, INT8U AttMin)
// 1429 {
AGCCheck:
        PUSH     {R4-R6,LR}
        LDR      R4,[SP, #+16]
// 1430 	INT32S gap;
// 1431 	INT32S tmpTotAttn;
// 1432 
// 1433  
// 1434 	tmpTotAttn = *tmpALCAttn;
        LDRSB    R5,[R3, #+0]
// 1435 
// 1436 	if(tmpOnOff != Enable) return FALSE;
        CMP      R2,#+0
        BEQ.N    ??AGCCheck_0
??AGCCheck_1:
        MOVS     R0,#+0
        POP      {R4-R6,PC}
// 1437 	gap = tmpx10 - tlimitLow;
// 1438 
// 1439 	gap = gap/5;
??AGCCheck_0:
        SUBS     R2,R0,R1
        MOVS     R6,#+5
        SDIV     R2,R2,R6
// 1440 
// 1441 	if(tmpTotAttn > 0)
        CMP      R5,#+1
        BLT.N    ??AGCCheck_2
// 1442 	{
// 1443 		if ((gap <= 2)&&(gap >= -1))		return FALSE;  //1dB
        CMP      R2,#+3
        BGE.N    ??AGCCheck_3
        MOV      R6,#-1
        CMP      R2,R6
        BLT.N    ??AGCCheck_3
        B.N      ??AGCCheck_1
// 1444 	}
// 1445 	else
// 1446 	{
// 1447 		if(abs(gap) <= 1) return FALSE;  //+/- 0.5dB
??AGCCheck_2:
        MOVS     R6,R2
        BPL.N    ??AGCCheck_4
        RSBS     R6,R6,#+0
// 1448 	}
??AGCCheck_4:
        CMP      R6,#+2
        BLT.N    ??AGCCheck_1
// 1449 
// 1450 
// 1451 	if(gap > 0)
??AGCCheck_3:
        CMP      R2,#+1
        BLT.N    ??AGCCheck_5
// 1452 	{
// 1453 		if(gap >  20L)		gap = 20L;
        CMP      R2,#+21
        BLT.N    ??AGCCheck_6
        MOVS     R2,#+20
        B.N      ??AGCCheck_7
// 1454 		else if(gap >  4L)	gap = 4L;
??AGCCheck_6:
        CMP      R2,#+5
        BLT.N    ??AGCCheck_7
        MOVS     R2,#+4
        B.N      ??AGCCheck_7
// 1455 	}
// 1456 	else
// 1457 	{
// 1458 		if(gap < -4L)	gap = -4L;
??AGCCheck_5:
        MVN      R6,#+3
        CMP      R2,R6
        BLT.N    ??AGCCheck_8
// 1459 		else if(gap < -2L)	gap = -2L;
        MVN      R6,#+1
        CMP      R2,R6
        BGE.N    ??AGCCheck_7
??AGCCheck_8:
        MOV      R2,R6
// 1460 	}
// 1461 	
// 1462 	tmpTotAttn  += gap;
??AGCCheck_7:
        ADDS     R5,R2,R5
// 1463 	if(tmpTotAttn  > AttMax ) 	tmpTotAttn  = AttMax;
        CMP      R4,R5
        BGE.N    ??AGCCheck_9
        MOV      R5,R4
// 1464 //	if(tmpTotAttn  < AttMin ) 	tmpTotAttn  = AttMin;
// 1465 
// 1466 	*tmpALCAttn = tmpTotAttn;
??AGCCheck_9:
        STRB     R5,[R3, #+0]
// 1467 
// 1468 	if(tDnrSts->Test_Mode == Debug_ALC)SerPtr->printf("2: tmpx10[%d]tlimitLow[%d]gap[%d]tmpTotAttn[%d]\n",tmpx10,tlimitLow,gap,tmpTotAttn);
        LDR.N    R3,??AGCCheck_10  ;; tDnrSts
        LDR      R3,[R3, #+0]
        LDRB     R3,[R3, #+826]
        CMP      R3,#+8
        BNE.N    ??AGCCheck_11
        PUSH     {R5,LR}
        MOV      R3,R2
        MOV      R2,R1
        MOV      R1,R0
        LDR.N    R0,??AGCCheck_10+0x4  ;; `?<Constant "2: tmpx10[%d]tlimitLo...">`
        LDR.N    R4,??AGCCheck_10+0x8  ;; SerPtr
        LDR      R4,[R4, #+0]
        LDR      R4,[R4, #+16]
        BLX      R4
        ADD      SP,SP,#+8
// 1469 
// 1470   	return tmpTotAttn;    
??AGCCheck_11:
        SXTB     R0,R5
        POP      {R4-R6,PC}       ;; return
        DATA
??AGCCheck_10:
        DC32     tDnrSts
        DC32     `?<Constant "2: tmpx10[%d]tlimitLo...">`
        DC32     SerPtr
// 1471 }
// 1472 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1473 INT8S AGC_Check(INT8U *tValue,INT8U *tlimit,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax, INT8U AttMin)
// 1474 {
AGC_Check:
        PUSH     {R4-R6,LR}
        LDR      R5,[SP, #+16]
// 1475 	INT32S gap;
// 1476 	INT32S tmpTotAttn;
// 1477 
// 1478 	INT32S tmpx10;
// 1479 	INT32S tlimitLow;
// 1480 
// 1481 	tmpx10 = tValue[0]*10L + tValue[1];
        MOVS     R4,#+10
        LDRB     R6,[R0, #+0]
        LDRB     R0,[R0, #+1]
        MLA      R0,R6,R4,R0
// 1482 	tlimitLow = tlimit[0]*10L + tlimit[1];
        LDRB     R6,[R1, #+0]
        LDRB     R1,[R1, #+1]
        MLA      R1,R6,R4,R1
// 1483 
// 1484 	tmpTotAttn = *tmpALCAttn;
        LDRSB    R4,[R3, #+0]
// 1485 
// 1486 	if(tmpOnOff != Enable) return FALSE;
        CMP      R2,#+0
        BEQ.N    ??AGC_Check_0
??AGC_Check_1:
        MOVS     R0,#+0
        POP      {R4-R6,PC}
// 1487 	gap = tmpx10 - tlimitLow;
// 1488 
// 1489 	gap = gap/5;
??AGC_Check_0:
        SUBS     R2,R0,R1
        MOVS     R6,#+5
        SDIV     R2,R2,R6
// 1490 
// 1491 	if(tmpTotAttn > 0)
        CMP      R4,#+1
        BLT.N    ??AGC_Check_2
// 1492 	{
// 1493 		if ((gap <= 2)&&(gap >= -1))		return FALSE;  //1dB
        CMP      R2,#+3
        BGE.N    ??AGC_Check_3
        MOV      R6,#-1
        CMP      R2,R6
        BLT.N    ??AGC_Check_3
        B.N      ??AGC_Check_1
// 1494 	}
// 1495 	else
// 1496 	{
// 1497 		if(abs(gap) <= 1) return FALSE;  //+/- 0.5dB
??AGC_Check_2:
        MOVS     R6,R2
        BPL.N    ??AGC_Check_4
        RSBS     R6,R6,#+0
// 1498 	}
??AGC_Check_4:
        CMP      R6,#+2
        BLT.N    ??AGC_Check_1
// 1499 
// 1500 
// 1501 	if(gap > 0)
??AGC_Check_3:
        CMP      R2,#+1
        BLT.N    ??AGC_Check_5
// 1502 	{
// 1503 		if(gap >  20L)		gap = 20L;
        CMP      R2,#+21
        BLT.N    ??AGC_Check_6
        MOVS     R2,#+20
        B.N      ??AGC_Check_7
// 1504 		else if(gap >  4L)	gap = 4L;
??AGC_Check_6:
        CMP      R2,#+5
        BLT.N    ??AGC_Check_7
        MOVS     R2,#+4
        B.N      ??AGC_Check_7
// 1505 	}
// 1506 	else
// 1507 	{
// 1508 		if(gap < -4L)	gap = -4L;
??AGC_Check_5:
        MVN      R6,#+3
        CMP      R2,R6
        BLT.N    ??AGC_Check_8
// 1509 		else if(gap < -2L)	gap = -2L;
        MVN      R6,#+1
        CMP      R2,R6
        BGE.N    ??AGC_Check_7
??AGC_Check_8:
        MOV      R2,R6
// 1510 	}
// 1511 	
// 1512 	tmpTotAttn  += gap;
??AGC_Check_7:
        ADDS     R4,R2,R4
// 1513 	if(tmpTotAttn  > AttMax ) 	tmpTotAttn  = AttMax;
        CMP      R5,R4
        BGE.N    ??AGC_Check_9
        MOV      R4,R5
// 1514 //	if(tmpTotAttn  < AttMin ) 	tmpTotAttn  = AttMin;
// 1515 
// 1516 	*tmpALCAttn = tmpTotAttn;
??AGC_Check_9:
        STRB     R4,[R3, #+0]
// 1517 
// 1518 	if(tDnrSts->Test_Mode == Debug_ALC)SerPtr->printf("2: tmpx10[%d]tlimitLow[%d]gap[%d]tmpTotAttn[%d]\n",tmpx10,tlimitLow,gap,tmpTotAttn);
        LDR.N    R3,??AGC_Check_10  ;; tDnrSts
        LDR      R3,[R3, #+0]
        LDRB     R3,[R3, #+826]
        CMP      R3,#+8
        BNE.N    ??AGC_Check_11
        PUSH     {R4,LR}
        MOV      R3,R2
        MOV      R2,R1
        MOV      R1,R0
        LDR.N    R0,??AGC_Check_10+0x4  ;; `?<Constant "2: tmpx10[%d]tlimitLo...">`
        LDR.N    R5,??AGC_Check_10+0x8  ;; SerPtr
        LDR      R5,[R5, #+0]
        LDR      R5,[R5, #+16]
        BLX      R5
        ADD      SP,SP,#+8
// 1519 
// 1520   	return tmpTotAttn;    
??AGC_Check_11:
        SXTB     R0,R4
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??AGC_Check_10:
        DC32     tDnrSts
        DC32     `?<Constant "2: tmpx10[%d]tlimitLo...">`
        DC32     SerPtr
// 1521 }
// 1522 
// 1523 
// 1524 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1525 void ShutDownCheck_LTE_A(void)
// 1526 {
ShutDownCheck_LTE_A:
        PUSH     {R4-R6,LR}
// 1527   INT8U tmpAlarm;
// 1528 
// 1529   __Dnr_Sts *Sts = tDnrSts;
        LDR.N    R0,??ShutDownCheck_LTE_A_1  ;; tDnrSts
        LDR      R5,[R0, #+0]
// 1530 
// 1531   Sts->ShunDown_Step_LTE_A = SdStep_LTE_A;
        LDR.N    R6,??ShutDownCheck_LTE_A_1+0x4  ;; ChkNorAlarm_LTE_A
        LDRB     R1,[R6, #+2]
        STRB     R1,[R5, #+867]
// 1532   if(Sts->ShutDownOnOff_LTE_A == Disable) return;
        LDRB     R1,[R5, #+496]
        CMP      R1,#+1
        BEQ.W    ??ShutDownCheck_LTE_A_2
// 1533 
// 1534   if(ChkNorAlarm_LTE_A == 0)
        LDRB     R1,[R6, #+0]
        CBNZ     R1,??ShutDownCheck_LTE_A_3
// 1535   {
// 1536 	  if (PwrAlarm.RvsOutUpperLmtFail_LTE_A) 			 	 ChkNorAlarmVal_LTE_A= 1;
        LDR.N    R1,??ShutDownCheck_LTE_A_1+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+21]
        CBZ      R2,??ShutDownCheck_LTE_A_4
        MOVS     R1,#+1
        B.N      ??ShutDownCheck_LTE_A_5
// 1537 	  else if (PwrAlarm.FwdOutUpperLmtFail_LTE_A) 			 ChkNorAlarmVal_LTE_A= 2;
??ShutDownCheck_LTE_A_4:
        LDRB     R2,[R1, #+12]
        CBZ      R2,??ShutDownCheck_LTE_A_6
        MOVS     R1,#+2
        B.N      ??ShutDownCheck_LTE_A_5
// 1538 	  else if (PwrAlarm.FwdInUpperLmtFail_LTE_A) 			 ChkNorAlarmVal_LTE_A= 3;
??ShutDownCheck_LTE_A_6:
        LDRB     R1,[R1, #+13]
        CBZ      R1,??ShutDownCheck_LTE_A_7
        MOVS     R1,#+3
??ShutDownCheck_LTE_A_5:
        STRB     R1,[R6, #+1]
// 1539 
// 1540 	  SdChekcTime_LTE_A = AlarmDelay2Time;	  ///100Sec
??ShutDownCheck_LTE_A_7:
        MOVS     R1,#+9
        STR      R1,[R6, #+8]
// 1541 
// 1542 	  if(ChkNorAlarmVal_LTE_A) ChkNorAlarm_LTE_A = Alarm;
        LDRB     R1,[R6, #+1]
        CBZ      R1,??ShutDownCheck_LTE_A_8
        MOVS     R1,#+1
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_LTE_A_8
// 1543   }
// 1544   
// 1545   else if(ChkNorAlarm_LTE_A)
// 1546   {
// 1547 	  if(ChkNorAlarmVal_LTE_A == 1)
??ShutDownCheck_LTE_A_3:
        LDRB     R1,[R6, #+1]
        CMP      R1,#+1
        BNE.N    ??ShutDownCheck_LTE_A_9
// 1548 	  {
// 1549 		  if  ((PwrAlarm.RvsOutUpperLmtFail_LTE_A))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE_A_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+21]
        B.N      ??ShutDownCheck_LTE_A_10
// 1550 		  else											tmpAlarm = Normal;
// 1551 	  }
// 1552 	  else if(ChkNorAlarmVal_LTE_A == 2)
??ShutDownCheck_LTE_A_9:
        CMP      R1,#+2
        BNE.N    ??ShutDownCheck_LTE_A_11
// 1553 	  {
// 1554 		  if  ((PwrAlarm.FwdOutUpperLmtFail_LTE_A))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE_A_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+12]
        B.N      ??ShutDownCheck_LTE_A_10
// 1555 		  else											tmpAlarm = Normal;
// 1556 	  }	  
// 1557 	  else if(ChkNorAlarmVal_LTE_A == 3)
??ShutDownCheck_LTE_A_11:
        CMP      R1,#+3
        BNE.N    ??ShutDownCheck_LTE_A_8
// 1558 	  {
// 1559 		  if  ((PwrAlarm.FwdInUpperLmtFail_LTE_A))	  		tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE_A_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+13]
??ShutDownCheck_LTE_A_10:
        SUBS     R4,R1,#+1
        SBCS     R4,R4,R4
        MVNS     R4,R4
        LSRS     R4,R4,#+31
// 1560 		  else											tmpAlarm = Normal;
// 1561 	  }	  
// 1562   }
// 1563 
// 1564   if(SdBuffClear_LTE_A)
??ShutDownCheck_LTE_A_8:
        LDRB     R1,[R6, #+3]
        CBZ      R1,??ShutDownCheck_LTE_A_12
// 1565   {
// 1566 	  SdStep_LTE_A = _AlarmCheckStart;
        MOVS     R1,#+0
        STRB     R1,[R6, #+2]
// 1567 	  SdBuffClear_LTE_A = FALSE;
        STRB     R1,[R6, #+3]
// 1568 
// 1569 	  SdChekcTime_LTE_A = Recovery4Time;
        MOVS     R1,#+4
        STR      R1,[R6, #+8]
// 1570 
// 1571 	  ChkNorAlarmVal_LTE_A = 0;
        MOVS     R1,#+0
        STRB     R1,[R6, #+1]
// 1572 	  ChkNorAlarm_LTE_A = 0;
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_LTE_A_13
// 1573   }   
// 1574 
// 1575   if(SdChekcTime_LTE_A > 0)SdChekcTime_LTE_A--;
??ShutDownCheck_LTE_A_12:
        LDR      R1,[R6, #+8]
        CBZ      R1,??ShutDownCheck_LTE_A_14
??ShutDownCheck_LTE_A_13:
        LDR      R1,[R6, #+8]
        SUBS     R1,R1,#+1
        STR      R1,[R6, #+8]
// 1576 
// 1577   if(tDnrSts->TestMode == Debug_Rvs1SD)USART1Printf("0: SdStep_LTE_A[%d]SdChekcTime_LTE_A[%d]:[%d][%d]:[%d]\n", SdStep_LTE_A,SdChekcTime_LTE_A,tmpAlarm,Sts->AmpOnOff_LTE_A,ChkNorAlarmVal_LTE_A);
??ShutDownCheck_LTE_A_14:
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+6
        BNE.N    ??ShutDownCheck_LTE_A_15
        LDRB     R1,[R6, #+1]
        LDRB     R0,[R5, #+85]
        PUSH     {R0,R1}
        UXTB     R3,R4
        LDR      R2,[R6, #+8]
        LDRB     R1,[R6, #+2]
        LDR.N    R0,??ShutDownCheck_LTE_A_1+0xC  ;; `?<Constant "0: SdStep_LTE_A[%d]Sd...">`
        BL       USART1Printf
        ADD      SP,SP,#+8
// 1578   
// 1579   switch(SdStep_LTE_A)
??ShutDownCheck_LTE_A_15:
        LDRB     R0,[R6, #+2]
        CMP      R0,#+8
        BHI.N    ??ShutDownCheck_LTE_A_2
        TBB      [PC, R0]
        DATA
??ShutDownCheck_LTE_A_0:
        DC8      +5,+15,+37,+46
        DC8      +57,+66,+82,+91
        DC8      +98,+0
        THUMB
// 1580   {
// 1581 	  case 0:
// 1582 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_16:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A_2
// 1583 		  {
// 1584 			  if(tmpAlarm == Alarm)
        UXTB     R4,R4
        CMP      R4,#+1
        BNE.N    ??ShutDownCheck_LTE_A_17
// 1585 			  {
// 1586 				  SdStep_LTE_A = 1;
        MOVS     R0,#+1
??ShutDownCheck_LTE_A_18:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
// 1587 			  }
// 1588 			  else
// 1589 			  {
// 1590 				  SdBuffClear_LTE_A = SET;
??ShutDownCheck_LTE_A_17:
        B.N      ?Subroutine3
// 1591 			  }
// 1592 		  }
// 1593 	  break;
// 1594 	  
// 1595 	  case 1:  //5 1번 amp off	 1
// 1596 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_19:
        LDR      R0,[R6, #+8]
        CBNZ     R0,??ShutDownCheck_LTE_A_20
// 1597 		  {
// 1598 			  AmpOff_LTE_A(Disable);			  ///1
        MOVS     R0,#+1
        BL       AmpOff_LTE_A
// 1599 			  SdChekcTime_LTE_A = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1600 			  SdStep_LTE_A = 2;
        MOVS     R0,#+2
        B.N      ??ShutDownCheck_LTE_A_18
// 1601 		  }
// 1602 		  else if(tmpAlarm == Normal)
??ShutDownCheck_LTE_A_20:
        UXTB     R4,R4
        CMP      R4,#+0
        BNE.N    ??ShutDownCheck_LTE_A_2
// 1603 		  {
// 1604 			  SdNormalCnt_LTE_A++;
        LDRB     R0,[R6, #+4]
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+4]
// 1605 			  if(SdNormalCnt_LTE_A > 2)
        UXTB     R0,R0
        CMP      R0,#+3
        BCC.N    ??ShutDownCheck_LTE_A_2
// 1606 			  {
// 1607 				  AmpOff_LTE_A(Enable);
        MOVS     R0,#+0
        BL       AmpOff_LTE_A
// 1608 				  SdBuffClear_LTE_A = SET;
        B.N      ?Subroutine1
// 1609 				  SdNormalCnt_LTE_A = 0;
// 1610 			  }
// 1611 		  }   
// 1612 	  break;
// 1613 	  
// 1614 	  case 2: //5 1번 amp on  2   
// 1615 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_21:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A_2
// 1616 		  {
// 1617 			  AmpOff_LTE_A(Enable);
        BL       AmpOff_LTE_A
// 1618 			  SdChekcTime_LTE_A = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1619 			  SdStep_LTE_A = 3;
        MOVS     R0,#+3
        B.N      ??ShutDownCheck_LTE_A_18
// 1620 		  } 		  
// 1621 	  break;
// 1622 	  
// 1623 	  case 3: ////5 2번 amp off   3
// 1624 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_22:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A_20
// 1625 		  {
// 1626 			  AmpOff_LTE_A(Disable);		  ///2
        MOVS     R0,#+1
        BL       AmpOff_LTE_A
// 1627 			  SdChekcTime_LTE_A = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1628 
// 1629 			  SdStep_LTE_A = 4;
        MOVS     R0,#+4
??ShutDownCheck_LTE_A_23:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
// 1630 		  }
// 1631 		  else if(tmpAlarm == Normal)
// 1632 		  {
// 1633 			  SdNormalCnt_LTE_A++;
// 1634 			  if(SdNormalCnt_LTE_A > 2)
// 1635 			  {
// 1636 				  AmpOff_LTE_A(Enable);
// 1637 				  SdBuffClear_LTE_A = SET;
// 1638 				  SdNormalCnt_LTE_A = 0;
// 1639 			  }
// 1640 		  }
// 1641 	  break;  
// 1642 
// 1643 	  case 4: //5 2번 amp on   4
// 1644 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_24:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A_2
// 1645 		  {
// 1646 			  AmpOff_LTE_A(Enable);
        BL       AmpOff_LTE_A
// 1647 			  SdChekcTime_LTE_A = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1648 			  SdStep_LTE_A = 5;
        MOVS     R0,#+5
        B.N      ??ShutDownCheck_LTE_A_18
// 1649 		  }
// 1650 	  break;  
// 1651 
// 1652 	  case 5: //5 //5 3번 amp off  5
// 1653 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_25:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A_20
// 1654 		  {
// 1655 			  AmpOff_LTE_A(Disable);		  ///3
        MOVS     R0,#+1
        BL       AmpOff_LTE_A
// 1656 			  if( Sts->ShunDown_Value == 0)   SdChekcTime_LTE_A = Recovery3Time;
        LDRB     R0,[R5, #+828]
        CMP      R0,#+0
        ITE      EQ 
        MOVEQ    R0,#+3600
        MOVNE    R0,#+18
// 1657 			  else							  SdChekcTime_LTE_A = Recovery1Time;
        STR      R0,[R6, #+8]
// 1658 
// 1659 			  SdStep_LTE_A = 6;
        MOVS     R0,#+6
        B.N      ??ShutDownCheck_LTE_A_23
// 1660 		  }
// 1661 		  else if(tmpAlarm == Normal)
// 1662 		  {
// 1663 			  SdNormalCnt_LTE_A++;
// 1664 			  if(SdNormalCnt_LTE_A > 2)
// 1665 			  {
// 1666 				  AmpOff_LTE_A(Enable);
// 1667 				  SdBuffClear_LTE_A = SET;
// 1668 				  SdNormalCnt_LTE_A = 0;
// 1669 			  }
// 1670 		  }
// 1671 	  break;  
// 1672 
// 1673 	  case 6: //5	 6
// 1674 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_26:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A_20
// 1675 		  {
// 1676 			  AmpOff_LTE_A(Enable);
        BL       AmpOff_LTE_A
// 1677 			  SdChekcTime_LTE_A = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1678 			  
// 1679 			  SdStep_LTE_A = 7;
        MOVS     R0,#+7
        B.N      ??ShutDownCheck_LTE_A_18
// 1680 		  } 	  
// 1681 		  else if(tmpAlarm == Normal)
// 1682 		  {
// 1683 			  SdNormalCnt_LTE_A++;
// 1684 			  if(SdNormalCnt_LTE_A > 2)
// 1685 			  {
// 1686 				  AmpOff_LTE_A(Enable);
// 1687 				  SdBuffClear_LTE_A = SET;
// 1688 				  SdNormalCnt_LTE_A = 0;
// 1689 			  }
// 1690 		  }
// 1691 	  break;  
// 1692 
// 1693 	  case 7: //5  7
// 1694 		  if(!SdChekcTime_LTE_A)
??ShutDownCheck_LTE_A_27:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A_20
// 1695 		  {
// 1696 			  AmpOff_LTE_A(Disable);
        MOVS     R0,#+1
        BL       AmpOff_LTE_A
// 1697 			  SdStep_LTE_A = 8;
        B.N      ?Subroutine2
// 1698 		  }
// 1699 		  else if(tmpAlarm == Normal)
// 1700 		  {
// 1701 			  SdNormalCnt_LTE_A++;
// 1702 			  if(SdNormalCnt_LTE_A > 2)
// 1703 			  {
// 1704 				  AmpOff_LTE_A(Enable);
// 1705 				  SdBuffClear_LTE_A = SET;
// 1706 				  SdNormalCnt_LTE_A = 0;
// 1707 			  }
// 1708 		  }
// 1709 	  break;  
// 1710 
// 1711 	  case 8: //5
// 1712 		  AmpOff_LTE_A(Disable);
??ShutDownCheck_LTE_A_28:
        MOVS     R0,#+1
        BL       AmpOff_LTE_A
??ShutDownCheck_LTE_A_2:
        POP      {R4-R6,PC}       ;; return
        DATA
??ShutDownCheck_LTE_A_1:
        DC32     tDnrSts
        DC32     ChkNorAlarm_LTE_A
        DC32     PwrAlarm
        DC32     `?<Constant "0: SdStep_LTE_A[%d]Sd...">`
// 1713 	  break;  
// 1714   }
// 1715 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine3:
        MOVS     R0,#+1
        STRB     R0,[R6, #+3]
        POP      {R4-R6,PC}

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine2:
        MOVS     R0,#+8
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        MOVS     R0,#+1
        STRB     R0,[R6, #+3]
        MOVS     R0,#+0
        STRB     R0,[R6, #+4]
        POP      {R4-R6,PC}
// 1716 
// 1717 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1718 void ShutDownCheck_LTE_A1(void)
// 1719 {
ShutDownCheck_LTE_A1:
        PUSH     {R4-R6,LR}
// 1720   INT8U tmpAlarm;
// 1721 
// 1722   __Dnr_Sts *Sts = tDnrSts;
        LDR.N    R0,??ShutDownCheck_LTE_A1_1  ;; tDnrSts
        LDR      R5,[R0, #+0]
// 1723 
// 1724   Sts->ShunDown_Step_LTE_A1 = SdStep_LTE_A1;
        LDR.N    R6,??ShutDownCheck_LTE_A1_1+0x4  ;; ChkNorAlarm_LTE_A1
        LDRB     R1,[R6, #+2]
        STRB     R1,[R5, #+869]
// 1725   if(Sts->ShutDownOnOff_LTE_A == Disable) return;
        LDRB     R1,[R5, #+496]
        CMP      R1,#+1
        BEQ.W    ??ShutDownCheck_LTE_A1_2
// 1726 
// 1727   if(ChkNorAlarm_LTE_A1 == 0)
        LDRB     R1,[R6, #+0]
        CBNZ     R1,??ShutDownCheck_LTE_A1_3
// 1728   {
// 1729 	  if (PwrAlarm.Rvs1OutUpperLmtFail_LTE_A) 			 	 ChkNorAlarmVal_LTE_A1= 1;
        LDR.N    R1,??ShutDownCheck_LTE_A1_1+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+19]
        CBZ      R2,??ShutDownCheck_LTE_A1_4
        MOVS     R1,#+1
        B.N      ??ShutDownCheck_LTE_A1_5
// 1730 	  else if (PwrAlarm.Fwd1OutUpperLmtFail_LTE_A) 			 ChkNorAlarmVal_LTE_A1= 2;
??ShutDownCheck_LTE_A1_4:
        LDRB     R2,[R1, #+31]
        CBZ      R2,??ShutDownCheck_LTE_A1_6
        MOVS     R1,#+2
        B.N      ??ShutDownCheck_LTE_A1_5
// 1731 	  else if (PwrAlarm.Fwd1InUpperLmtFail_LTE_A) 			 ChkNorAlarmVal_LTE_A1= 3;
??ShutDownCheck_LTE_A1_6:
        LDRB     R1,[R1, #+32]
        CBZ      R1,??ShutDownCheck_LTE_A1_7
        MOVS     R1,#+3
??ShutDownCheck_LTE_A1_5:
        STRB     R1,[R6, #+1]
// 1732 
// 1733 	  SdChekcTime_LTE_A1 = AlarmDelay2Time;	  ///100Sec
??ShutDownCheck_LTE_A1_7:
        MOVS     R1,#+9
        STR      R1,[R6, #+8]
// 1734 
// 1735 	  if(ChkNorAlarmVal_LTE_A1) ChkNorAlarm_LTE_A1 = Alarm;
        LDRB     R1,[R6, #+1]
        CBZ      R1,??ShutDownCheck_LTE_A1_8
        MOVS     R1,#+1
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_LTE_A1_8
// 1736   }
// 1737   
// 1738   else if(ChkNorAlarm_LTE_A1)
// 1739   {
// 1740 	  if(ChkNorAlarmVal_LTE_A1 == 1)
??ShutDownCheck_LTE_A1_3:
        LDRB     R1,[R6, #+1]
        CMP      R1,#+1
        BNE.N    ??ShutDownCheck_LTE_A1_9
// 1741 	  {
// 1742 		  if  ((PwrAlarm.Rvs1OutUpperLmtFail_LTE_A))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE_A1_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+19]
        B.N      ??ShutDownCheck_LTE_A1_10
// 1743 		  else											tmpAlarm = Normal;
// 1744 	  }
// 1745 	  else if(ChkNorAlarmVal_LTE_A1 == 2)
??ShutDownCheck_LTE_A1_9:
        CMP      R1,#+2
        BNE.N    ??ShutDownCheck_LTE_A1_11
// 1746 	  {
// 1747 		  if  ((PwrAlarm.Fwd1OutUpperLmtFail_LTE_A))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE_A1_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+31]
        B.N      ??ShutDownCheck_LTE_A1_10
// 1748 		  else											tmpAlarm = Normal;
// 1749 	  }	  
// 1750 	  else if(ChkNorAlarmVal_LTE_A1 == 3)
??ShutDownCheck_LTE_A1_11:
        CMP      R1,#+3
        BNE.N    ??ShutDownCheck_LTE_A1_8
// 1751 	  {
// 1752 		  if  ((PwrAlarm.Fwd1InUpperLmtFail_LTE_A))	  		tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE_A1_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+32]
??ShutDownCheck_LTE_A1_10:
        SUBS     R4,R1,#+1
        SBCS     R4,R4,R4
        MVNS     R4,R4
        LSRS     R4,R4,#+31
// 1753 		  else											tmpAlarm = Normal;
// 1754 	  }	  
// 1755   }
// 1756 
// 1757   if(SdBuffClear_LTE_A1)
??ShutDownCheck_LTE_A1_8:
        LDRB     R1,[R6, #+3]
        CBZ      R1,??ShutDownCheck_LTE_A1_12
// 1758   {
// 1759 	  SdStep_LTE_A1 = _AlarmCheckStart;
        MOVS     R1,#+0
        STRB     R1,[R6, #+2]
// 1760 	  SdBuffClear_LTE_A1 = FALSE;
        STRB     R1,[R6, #+3]
// 1761 
// 1762 	  SdChekcTime_LTE_A1 = Recovery4Time;
        MOVS     R1,#+4
        STR      R1,[R6, #+8]
// 1763 
// 1764 	  ChkNorAlarmVal_LTE_A1 = 0;
        MOVS     R1,#+0
        STRB     R1,[R6, #+1]
// 1765 	  ChkNorAlarm_LTE_A1 = 0;
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_LTE_A1_13
// 1766   }   
// 1767 
// 1768   if(SdChekcTime_LTE_A1 > 0)SdChekcTime_LTE_A1--;
??ShutDownCheck_LTE_A1_12:
        LDR      R1,[R6, #+8]
        CBZ      R1,??ShutDownCheck_LTE_A1_14
??ShutDownCheck_LTE_A1_13:
        LDR      R1,[R6, #+8]
        SUBS     R1,R1,#+1
        STR      R1,[R6, #+8]
// 1769 
// 1770   if(tDnrSts->TestMode == Debug_Rvs1SD)USART1Printf("0: SdStep_LTE_A1[%d]SdChekcTime_LTE_A1[%d]:[%d][%d]:[%d]\n", SdStep_LTE_A1,SdChekcTime_LTE_A1,tmpAlarm,Sts->Amp1OnOff_LTE_A,ChkNorAlarmVal_LTE_A1);
??ShutDownCheck_LTE_A1_14:
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+6
        BNE.N    ??ShutDownCheck_LTE_A1_15
        LDRB     R1,[R6, #+1]
        LDRB     R0,[R5, #+677]
        PUSH     {R0,R1}
        UXTB     R3,R4
        LDR      R2,[R6, #+8]
        LDRB     R1,[R6, #+2]
        LDR.N    R0,??ShutDownCheck_LTE_A1_1+0xC  ;; `?<Constant "0: SdStep_LTE_A1[%d]S...">`
        BL       USART1Printf
        ADD      SP,SP,#+8
// 1771   
// 1772   switch(SdStep_LTE_A1)
??ShutDownCheck_LTE_A1_15:
        LDRB     R0,[R6, #+2]
        CMP      R0,#+8
        BHI.N    ??ShutDownCheck_LTE_A1_2
        TBB      [PC, R0]
        DATA
??ShutDownCheck_LTE_A1_0:
        DC8      +5,+15,+37,+46
        DC8      +57,+66,+82,+91
        DC8      +98,+0
        THUMB
// 1773   {
// 1774 	  case 0:
// 1775 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_16:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_2
// 1776 		  {
// 1777 			  if(tmpAlarm == Alarm)
        UXTB     R4,R4
        CMP      R4,#+1
        BNE.N    ??ShutDownCheck_LTE_A1_17
// 1778 			  {
// 1779 				  SdStep_LTE_A1 = 1;
        MOVS     R0,#+1
??ShutDownCheck_LTE_A1_18:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
// 1780 			  }
// 1781 			  else
// 1782 			  {
// 1783 				  SdBuffClear_LTE_A1 = SET;
??ShutDownCheck_LTE_A1_17:
        B.N      ?Subroutine3
// 1784 			  }
// 1785 		  }
// 1786 	  break;
// 1787 	  
// 1788 	  case 1:  //5 1번 amp off	 1
// 1789 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_19:
        LDR      R0,[R6, #+8]
        CBNZ     R0,??ShutDownCheck_LTE_A1_20
// 1790 		  {
// 1791 			  Amp1Off_LTE_A(Disable);			  ///1
        MOVS     R0,#+1
        BL       Amp1Off_LTE_A
// 1792 			  SdChekcTime_LTE_A1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1793 			  SdStep_LTE_A1 = 2;
        MOVS     R0,#+2
        B.N      ??ShutDownCheck_LTE_A1_18
// 1794 		  }
// 1795 		  else if(tmpAlarm == Normal)
??ShutDownCheck_LTE_A1_20:
        UXTB     R4,R4
        CMP      R4,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_2
// 1796 		  {
// 1797 			  SdNormalCnt_LTE_A1++;
        LDRB     R0,[R6, #+4]
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+4]
// 1798 			  if(SdNormalCnt_LTE_A1 > 2)
        UXTB     R0,R0
        CMP      R0,#+3
        BCC.N    ??ShutDownCheck_LTE_A1_2
// 1799 			  {
// 1800 				  Amp1Off_LTE_A(Enable);
        MOVS     R0,#+0
        BL       Amp1Off_LTE_A
// 1801 				  SdBuffClear_LTE_A1 = SET;
        B.N      ?Subroutine1
// 1802 				  SdNormalCnt_LTE_A1 = 0;
// 1803 			  }
// 1804 		  }   
// 1805 	  break;
// 1806 	  
// 1807 	  case 2: //5 1번 amp on  2   
// 1808 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_21:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_2
// 1809 		  {
// 1810 			  Amp1Off_LTE_A(Enable);
        BL       Amp1Off_LTE_A
// 1811 			  SdChekcTime_LTE_A1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1812 			  SdStep_LTE_A1 = 3;
        MOVS     R0,#+3
        B.N      ??ShutDownCheck_LTE_A1_18
// 1813 		  } 		  
// 1814 	  break;
// 1815 	  
// 1816 	  case 3: ////5 2번 amp off   3
// 1817 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_22:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_20
// 1818 		  {
// 1819 			  Amp1Off_LTE_A(Disable);		  ///2
        MOVS     R0,#+1
        BL       Amp1Off_LTE_A
// 1820 			  SdChekcTime_LTE_A1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1821 
// 1822 			  SdStep_LTE_A1 = 4;
        MOVS     R0,#+4
??ShutDownCheck_LTE_A1_23:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
// 1823 		  }
// 1824 		  else if(tmpAlarm == Normal)
// 1825 		  {
// 1826 			  SdNormalCnt_LTE_A1++;
// 1827 			  if(SdNormalCnt_LTE_A1 > 2)
// 1828 			  {
// 1829 				  Amp1Off_LTE_A(Enable);
// 1830 				  SdBuffClear_LTE_A1 = SET;
// 1831 				  SdNormalCnt_LTE_A1 = 0;
// 1832 			  }
// 1833 		  }
// 1834 	  break;  
// 1835 
// 1836 	  case 4: //5 2번 amp on   4
// 1837 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_24:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_2
// 1838 		  {
// 1839 			  Amp1Off_LTE_A(Enable);
        BL       Amp1Off_LTE_A
// 1840 			  SdChekcTime_LTE_A1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1841 			  SdStep_LTE_A1 = 5;
        MOVS     R0,#+5
        B.N      ??ShutDownCheck_LTE_A1_18
// 1842 		  }
// 1843 	  break;  
// 1844 
// 1845 	  case 5: //5 //5 3번 amp off  5
// 1846 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_25:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_20
// 1847 		  {
// 1848 			  Amp1Off_LTE_A(Disable);		  ///3
        MOVS     R0,#+1
        BL       Amp1Off_LTE_A
// 1849 			  if( Sts->ShunDown_Value == 0)   SdChekcTime_LTE_A1 = Recovery3Time;
        LDRB     R0,[R5, #+828]
        CMP      R0,#+0
        ITE      EQ 
        MOVEQ    R0,#+3600
        MOVNE    R0,#+18
// 1850 			  else							  SdChekcTime_LTE_A1 = Recovery1Time;
        STR      R0,[R6, #+8]
// 1851 
// 1852 			  SdStep_LTE_A1 = 6;
        MOVS     R0,#+6
        B.N      ??ShutDownCheck_LTE_A1_23
// 1853 		  }
// 1854 		  else if(tmpAlarm == Normal)
// 1855 		  {
// 1856 			  SdNormalCnt_LTE_A1++;
// 1857 			  if(SdNormalCnt_LTE_A1 > 2)
// 1858 			  {
// 1859 				  Amp1Off_LTE_A(Enable);
// 1860 				  SdBuffClear_LTE_A1 = SET;
// 1861 				  SdNormalCnt_LTE_A1 = 0;
// 1862 			  }
// 1863 		  }
// 1864 	  break;  
// 1865 
// 1866 	  case 6: //5	 6
// 1867 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_26:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_20
// 1868 		  {
// 1869 			  Amp1Off_LTE_A(Enable);
        BL       Amp1Off_LTE_A
// 1870 			  SdChekcTime_LTE_A1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1871 			  
// 1872 			  SdStep_LTE_A1 = 7;
        MOVS     R0,#+7
        B.N      ??ShutDownCheck_LTE_A1_18
// 1873 		  } 	  
// 1874 		  else if(tmpAlarm == Normal)
// 1875 		  {
// 1876 			  SdNormalCnt_LTE_A1++;
// 1877 			  if(SdNormalCnt_LTE_A1 > 2)
// 1878 			  {
// 1879 				  Amp1Off_LTE_A(Enable);
// 1880 				  SdBuffClear_LTE_A1 = SET;
// 1881 				  SdNormalCnt_LTE_A1 = 0;
// 1882 			  }
// 1883 		  }
// 1884 	  break;  
// 1885 
// 1886 	  case 7: //5  7
// 1887 		  if(!SdChekcTime_LTE_A1)
??ShutDownCheck_LTE_A1_27:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE_A1_20
// 1888 		  {
// 1889 			  Amp1Off_LTE_A(Disable);
        MOVS     R0,#+1
        BL       Amp1Off_LTE_A
// 1890 			  SdStep_LTE_A1 = 8;
        B.N      ?Subroutine2
// 1891 		  }
// 1892 		  else if(tmpAlarm == Normal)
// 1893 		  {
// 1894 			  SdNormalCnt_LTE_A1++;
// 1895 			  if(SdNormalCnt_LTE_A1 > 2)
// 1896 			  {
// 1897 				  Amp1Off_LTE_A(Enable);
// 1898 				  SdBuffClear_LTE_A1 = SET;
// 1899 				  SdNormalCnt_LTE_A1 = 0;
// 1900 			  }
// 1901 		  }
// 1902 	  break;  
// 1903 
// 1904 	  case 8: //5
// 1905 		  Amp1Off_LTE_A(Disable);
??ShutDownCheck_LTE_A1_28:
        MOVS     R0,#+1
        BL       Amp1Off_LTE_A
??ShutDownCheck_LTE_A1_2:
        POP      {R4-R6,PC}       ;; return
        DATA
??ShutDownCheck_LTE_A1_1:
        DC32     tDnrSts
        DC32     ChkNorAlarm_LTE_A1
        DC32     PwrAlarm
        DC32     `?<Constant "0: SdStep_LTE_A1[%d]S...">`
// 1906 	  break;  
// 1907   }
// 1908 }
// 1909 
// 1910 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1911 void ShutDownCheck_LTE1(void)
// 1912 {
ShutDownCheck_LTE1:
        PUSH     {R4-R6,LR}
// 1913   INT8U tmpAlarm;
// 1914 
// 1915   __Dnr_Sts *Sts = tDnrSts;
        LDR.N    R0,??ShutDownCheck_LTE1_1  ;; tDnrSts
        LDR      R5,[R0, #+0]
// 1916 
// 1917   Sts->ShunDown_Step_LTE1 = SdStep_LTE1;
        LDR.N    R6,??ShutDownCheck_LTE1_1+0x4  ;; ChkNorAlarm_LTE1
        LDRB     R1,[R6, #+2]
        STRB     R1,[R5, #+868]
// 1918   if(Sts->ShutDownOnOff_LTE_A == Disable) return;
        LDRB     R1,[R5, #+496]
        CMP      R1,#+1
        BEQ.W    ??ShutDownCheck_LTE1_2
// 1919 
// 1920   if(ChkNorAlarm_LTE1 == 0)
        LDRB     R1,[R6, #+0]
        CBNZ     R1,??ShutDownCheck_LTE1_3
// 1921   {
// 1922 	  if (PwrAlarm.Rvs1OutUpperLmtFail_LTE_A) 			 	 ChkNorAlarmVal_LTE1= 1;
        LDR.N    R1,??ShutDownCheck_LTE1_1+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+19]
        CBZ      R2,??ShutDownCheck_LTE1_4
        MOVS     R1,#+1
        B.N      ??ShutDownCheck_LTE1_5
// 1923 	  else if (PwrAlarm.Fwd1OutUpperLmtFail_LTE_A) 			 ChkNorAlarmVal_LTE1= 2;
??ShutDownCheck_LTE1_4:
        LDRB     R2,[R1, #+31]
        CBZ      R2,??ShutDownCheck_LTE1_6
        MOVS     R1,#+2
        B.N      ??ShutDownCheck_LTE1_5
// 1924 	  else if (PwrAlarm.Fwd1InUpperLmtFail_LTE_A) 			 ChkNorAlarmVal_LTE1= 3;
??ShutDownCheck_LTE1_6:
        LDRB     R1,[R1, #+32]
        CBZ      R1,??ShutDownCheck_LTE1_7
        MOVS     R1,#+3
??ShutDownCheck_LTE1_5:
        STRB     R1,[R6, #+1]
// 1925 
// 1926 	  SdChekcTime_LTE1 = AlarmDelay2Time;	  ///100Sec
??ShutDownCheck_LTE1_7:
        MOVS     R1,#+9
        STR      R1,[R6, #+8]
// 1927 
// 1928 	  if(ChkNorAlarmVal_LTE1) ChkNorAlarm_LTE1 = Alarm;
        LDRB     R1,[R6, #+1]
        CBZ      R1,??ShutDownCheck_LTE1_8
        MOVS     R1,#+1
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_LTE1_8
// 1929   }
// 1930   
// 1931   else if(ChkNorAlarm_LTE1)
// 1932   {
// 1933 	  if(ChkNorAlarmVal_LTE1 == 1)
??ShutDownCheck_LTE1_3:
        LDRB     R1,[R6, #+1]
        CMP      R1,#+1
        BNE.N    ??ShutDownCheck_LTE1_9
// 1934 	  {
// 1935 		  if  ((PwrAlarm.Rvs1OutUpperLmtFail_LTE_A))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE1_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+19]
        B.N      ??ShutDownCheck_LTE1_10
// 1936 		  else											tmpAlarm = Normal;
// 1937 	  }
// 1938 	  else if(ChkNorAlarmVal_LTE1 == 2)
??ShutDownCheck_LTE1_9:
        CMP      R1,#+2
        BNE.N    ??ShutDownCheck_LTE1_11
// 1939 	  {
// 1940 		  if  ((PwrAlarm.Fwd1OutUpperLmtFail_LTE_A))	  	tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE1_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+31]
        B.N      ??ShutDownCheck_LTE1_10
// 1941 		  else											tmpAlarm = Normal;
// 1942 	  }	  
// 1943 	  else if(ChkNorAlarmVal_LTE1 == 3)
??ShutDownCheck_LTE1_11:
        CMP      R1,#+3
        BNE.N    ??ShutDownCheck_LTE1_8
// 1944 	  {
// 1945 		  if  ((PwrAlarm.Fwd1InUpperLmtFail_LTE_A))	  		tmpAlarm = Alarm;
        LDR.N    R1,??ShutDownCheck_LTE1_1+0x8  ;; PwrAlarm
        LDRB     R1,[R1, #+32]
??ShutDownCheck_LTE1_10:
        SUBS     R4,R1,#+1
        SBCS     R4,R4,R4
        MVNS     R4,R4
        LSRS     R4,R4,#+31
// 1946 		  else											tmpAlarm = Normal;
// 1947 	  }	  
// 1948   }
// 1949 
// 1950   if(SdBuffClear_LTE1)
??ShutDownCheck_LTE1_8:
        LDRB     R1,[R6, #+3]
        CBZ      R1,??ShutDownCheck_LTE1_12
// 1951   {
// 1952 	  SdStep_LTE1 = _AlarmCheckStart;
        MOVS     R1,#+0
        STRB     R1,[R6, #+2]
// 1953 	  SdBuffClear_LTE1 = FALSE;
        STRB     R1,[R6, #+3]
// 1954 
// 1955 	  SdChekcTime_LTE1 = Recovery4Time;
        MOVS     R1,#+4
        STR      R1,[R6, #+8]
// 1956 
// 1957 	  ChkNorAlarmVal_LTE1 = 0;
        MOVS     R1,#+0
        STRB     R1,[R6, #+1]
// 1958 	  ChkNorAlarm_LTE1 = 0;
        STRB     R1,[R6, #+0]
        B.N      ??ShutDownCheck_LTE1_13
// 1959   }   
// 1960 
// 1961   if(SdChekcTime_LTE1 > 0)SdChekcTime_LTE1--;
??ShutDownCheck_LTE1_12:
        LDR      R1,[R6, #+8]
        CBZ      R1,??ShutDownCheck_LTE1_14
??ShutDownCheck_LTE1_13:
        LDR      R1,[R6, #+8]
        SUBS     R1,R1,#+1
        STR      R1,[R6, #+8]
// 1962 
// 1963   if(tDnrSts->TestMode == Debug_Rvs1SD)USART1Printf("0: SdStep_LTE1[%d]SdChekcTime_LTE1[%d]:[%d][%d]:[%d]\n", SdStep_LTE1,SdChekcTime_LTE1,tmpAlarm,Sts->Amp1OnOff_LTE,ChkNorAlarmVal_LTE1);
??ShutDownCheck_LTE1_14:
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+6
        BNE.N    ??ShutDownCheck_LTE1_15
        LDRB     R1,[R6, #+1]
        LDRB     R0,[R5, #+678]
        PUSH     {R0,R1}
        UXTB     R3,R4
        LDR      R2,[R6, #+8]
        LDRB     R1,[R6, #+2]
        LDR.N    R0,??ShutDownCheck_LTE1_1+0xC  ;; `?<Constant "0: SdStep_LTE1[%d]SdC...">`
        BL       USART1Printf
        ADD      SP,SP,#+8
// 1964   
// 1965   switch(SdStep_LTE1)
??ShutDownCheck_LTE1_15:
        LDRB     R0,[R6, #+2]
        CMP      R0,#+8
        BHI.N    ??ShutDownCheck_LTE1_2
        TBB      [PC, R0]
        DATA
??ShutDownCheck_LTE1_0:
        DC8      +5,+15,+37,+46
        DC8      +57,+66,+82,+91
        DC8      +98,+0
        THUMB
// 1966   {
// 1967 	  case 0:
// 1968 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_16:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE1_2
// 1969 		  {
// 1970 			  if(tmpAlarm == Alarm)
        UXTB     R4,R4
        CMP      R4,#+1
        BNE.N    ??ShutDownCheck_LTE1_17
// 1971 			  {
// 1972 				  SdStep_LTE1 = 1;
        MOVS     R0,#+1
??ShutDownCheck_LTE1_18:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
// 1973 			  }
// 1974 			  else
// 1975 			  {
// 1976 				  SdBuffClear_LTE1 = SET;
??ShutDownCheck_LTE1_17:
        B.N      ?Subroutine3
// 1977 			  }
// 1978 		  }
// 1979 	  break;
// 1980 	  
// 1981 	  case 1:  //5 1번 amp off	 1
// 1982 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_19:
        LDR      R0,[R6, #+8]
        CBNZ     R0,??ShutDownCheck_LTE1_20
// 1983 		  {
// 1984 			  Amp1Off_LTE(Disable);			  ///1
        MOVS     R0,#+1
        BL       Amp1Off_LTE
// 1985 			  SdChekcTime_LTE1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 1986 			  SdStep_LTE1 = 2;
        MOVS     R0,#+2
        B.N      ??ShutDownCheck_LTE1_18
// 1987 		  }
// 1988 		  else if(tmpAlarm == Normal)
??ShutDownCheck_LTE1_20:
        UXTB     R4,R4
        CMP      R4,#+0
        BNE.N    ??ShutDownCheck_LTE1_2
// 1989 		  {
// 1990 			  SdNormalCnt_LTE1++;
        LDRB     R0,[R6, #+4]
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+4]
// 1991 			  if(SdNormalCnt_LTE1 > 2)
        UXTB     R0,R0
        CMP      R0,#+3
        BCC.N    ??ShutDownCheck_LTE1_2
// 1992 			  {
// 1993 				  Amp1Off_LTE(Enable);
        MOVS     R0,#+0
        BL       Amp1Off_LTE
// 1994 				  SdBuffClear_LTE1 = SET;
        B.N      ?Subroutine1
// 1995 				  SdNormalCnt_LTE1 = 0;
// 1996 			  }
// 1997 		  }   
// 1998 	  break;
// 1999 	  
// 2000 	  case 2: //5 1번 amp on  2   
// 2001 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_21:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE1_2
// 2002 		  {
// 2003 			  Amp1Off_LTE(Enable);
        BL       Amp1Off_LTE
// 2004 			  SdChekcTime_LTE1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 2005 			  SdStep_LTE1 = 3;
        MOVS     R0,#+3
        B.N      ??ShutDownCheck_LTE1_18
// 2006 		  } 		  
// 2007 	  break;
// 2008 	  
// 2009 	  case 3: ////5 2번 amp off   3
// 2010 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_22:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE1_20
// 2011 		  {
// 2012 			  Amp1Off_LTE(Disable);		  ///2
        MOVS     R0,#+1
        BL       Amp1Off_LTE
// 2013 			  SdChekcTime_LTE1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 2014 
// 2015 			  SdStep_LTE1 = 4;
        MOVS     R0,#+4
??ShutDownCheck_LTE1_23:
        STRB     R0,[R6, #+2]
        POP      {R4-R6,PC}
// 2016 		  }
// 2017 		  else if(tmpAlarm == Normal)
// 2018 		  {
// 2019 			  SdNormalCnt_LTE1++;
// 2020 			  if(SdNormalCnt_LTE1 > 2)
// 2021 			  {
// 2022 				  Amp1Off_LTE(Enable);
// 2023 				  SdBuffClear_LTE1 = SET;
// 2024 				  SdNormalCnt_LTE1 = 0;
// 2025 			  }
// 2026 		  }
// 2027 	  break;  
// 2028 
// 2029 	  case 4: //5 2번 amp on   4
// 2030 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_24:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE1_2
// 2031 		  {
// 2032 			  Amp1Off_LTE(Enable);
        BL       Amp1Off_LTE
// 2033 			  SdChekcTime_LTE1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 2034 			  SdStep_LTE1 = 5;
        MOVS     R0,#+5
        B.N      ??ShutDownCheck_LTE1_18
// 2035 		  }
// 2036 	  break;  
// 2037 
// 2038 	  case 5: //5 //5 3번 amp off  5
// 2039 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_25:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE1_20
// 2040 		  {
// 2041 			  Amp1Off_LTE(Disable);		  ///3
        MOVS     R0,#+1
        BL       Amp1Off_LTE
// 2042 			  if( Sts->ShunDown_Value == 0)   SdChekcTime_LTE1 = Recovery3Time;
        LDRB     R0,[R5, #+828]
        CMP      R0,#+0
        ITE      EQ 
        MOVEQ    R0,#+3600
        MOVNE    R0,#+18
// 2043 			  else							  SdChekcTime_LTE1 = Recovery1Time;
        STR      R0,[R6, #+8]
// 2044 
// 2045 			  SdStep_LTE1 = 6;
        MOVS     R0,#+6
        B.N      ??ShutDownCheck_LTE1_23
// 2046 		  }
// 2047 		  else if(tmpAlarm == Normal)
// 2048 		  {
// 2049 			  SdNormalCnt_LTE1++;
// 2050 			  if(SdNormalCnt_LTE1 > 2)
// 2051 			  {
// 2052 				  Amp1Off_LTE(Enable);
// 2053 				  SdBuffClear_LTE1 = SET;
// 2054 				  SdNormalCnt_LTE1 = 0;
// 2055 			  }
// 2056 		  }
// 2057 	  break;  
// 2058 
// 2059 	  case 6: //5	 6
// 2060 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_26:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE1_20
// 2061 		  {
// 2062 			  Amp1Off_LTE(Enable);
        BL       Amp1Off_LTE
// 2063 			  SdChekcTime_LTE1 = Recovery1Time;
        MOVS     R0,#+18
        STR      R0,[R6, #+8]
// 2064 			  
// 2065 			  SdStep_LTE1 = 7;
        MOVS     R0,#+7
        B.N      ??ShutDownCheck_LTE1_18
// 2066 		  } 	  
// 2067 		  else if(tmpAlarm == Normal)
// 2068 		  {
// 2069 			  SdNormalCnt_LTE1++;
// 2070 			  if(SdNormalCnt_LTE1 > 2)
// 2071 			  {
// 2072 				  Amp1Off_LTE(Enable);
// 2073 				  SdBuffClear_LTE1 = SET;
// 2074 				  SdNormalCnt_LTE1 = 0;
// 2075 			  }
// 2076 		  }
// 2077 	  break;  
// 2078 
// 2079 	  case 7: //5  7
// 2080 		  if(!SdChekcTime_LTE1)
??ShutDownCheck_LTE1_27:
        LDR      R0,[R6, #+8]
        CMP      R0,#+0
        BNE.N    ??ShutDownCheck_LTE1_20
// 2081 		  {
// 2082 			  Amp1Off_LTE(Disable);
        MOVS     R0,#+1
        BL       Amp1Off_LTE
// 2083 			  SdStep_LTE1 = 8;
        B.N      ?Subroutine2
// 2084 		  }
// 2085 		  else if(tmpAlarm == Normal)
// 2086 		  {
// 2087 			  SdNormalCnt_LTE1++;
// 2088 			  if(SdNormalCnt_LTE1 > 2)
// 2089 			  {
// 2090 				  Amp1Off_LTE(Enable);
// 2091 				  SdBuffClear_LTE1 = SET;
// 2092 				  SdNormalCnt_LTE1 = 0;
// 2093 			  }
// 2094 		  }
// 2095 	  break;  
// 2096 
// 2097 	  case 8: //5
// 2098 		  Amp1Off_LTE(Disable);
??ShutDownCheck_LTE1_28:
        MOVS     R0,#+1
        BL       Amp1Off_LTE
??ShutDownCheck_LTE1_2:
        POP      {R4-R6,PC}       ;; return
        DATA
??ShutDownCheck_LTE1_1:
        DC32     tDnrSts
        DC32     ChkNorAlarm_LTE1
        DC32     PwrAlarm
        DC32     `?<Constant "0: SdStep_LTE1[%d]SdC...">`
// 2099 	  break;  
// 2100   }
// 2101 }
// 2102 
// 2103 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2104 void Local_ShutDownCheck_Common(void)
// 2105 {
Local_ShutDownCheck_Common:
        PUSH     {R3-R7,LR}
// 2106 	INT8U tmpAlarm = 0;
        MOVS     R4,#+0
// 2107 
// 2108 	__Dnr_Sts *Sts = tDnrSts;
        LDR.N    R6,??Local_ShutDownCheck_Common_0  ;; tDnrSts
        LDR      R0,[R6, #+0]
        MOV      R7,R0
// 2109 
// 2110     if(Sts->ShutDownOnOff_2G == Disable) return;
        LDRB     R1,[R7, #+202]
        CMP      R1,#+1
        BEQ.N    ??Local_ShutDownCheck_Common_1
// 2111 
// 2112 	if(Local_ChkNorAlarm_2G == 0)
        LDR.N    R5,??Local_ShutDownCheck_Common_0+0x4  ;; Local_ChkNorAlarm_2G
        LDRB     R1,[R5, #+0]
        CBNZ     R1,??Local_ShutDownCheck_Common_2
// 2113 	{
// 2114 		if 		(PwrAlarm.PLL_Fail_Common)			Local_ChkNorAlarmVal_2G	= 1;
        LDR.N    R1,??Local_ShutDownCheck_Common_0+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+0]
        CBZ      R2,??Local_ShutDownCheck_Common_3
        MOVS     R2,#+1
        B.N      ??Local_ShutDownCheck_Common_4
// 2115 		else if (PwrAlarm.DCFail)					Local_ChkNorAlarmVal_2G	= 2;
??Local_ShutDownCheck_Common_3:
        ADD      R2,R1,#+36
        LDRB     R2,[R2, #+1]
        CBZ      R2,??Local_ShutDownCheck_Common_5
        MOVS     R2,#+2
        B.N      ??Local_ShutDownCheck_Common_4
// 2116 		else if (PwrAlarm.ACFail)					Local_ChkNorAlarmVal_2G	= 3;
??Local_ShutDownCheck_Common_5:
        LDRB     R2,[R1, #+36]
        CBZ      R2,??Local_ShutDownCheck_Common_6
        MOVS     R2,#+3
??Local_ShutDownCheck_Common_4:
        STRB     R2,[R5, #+1]
// 2117 
// 2118 
// 2119 		if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_Common_6:
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_Common_7
// 2120 		USART1Printf("PwrAlarm[%d][%d]\n", PwrAlarm.PLL_Fail_Common,Local_ChkNorAlarmVal_2G);
        LDRB     R2,[R5, #+1]
        LDRB     R1,[R1, #+0]
        LDR.N    R0,??Local_ShutDownCheck_Common_0+0xC  ;; `?<Constant "PwrAlarm[%d][%d]\\n">`
        BL       USART1Printf
        B.N      ??Local_ShutDownCheck_Common_7
// 2121 	}
// 2122 	else if(Local_ChkNorAlarm_2G)
// 2123 	{
// 2124 		if(Local_ChkNorAlarmVal_2G == 1)
??Local_ShutDownCheck_Common_2:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+1
        BNE.N    ??Local_ShutDownCheck_Common_8
// 2125 		{
// 2126 			if	(PwrAlarm.PLL_Fail_Common)		tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_Common_0+0x8  ;; PwrAlarm
        LDRB     R0,[R0, #+0]
        B.N      ??Local_ShutDownCheck_Common_9
// 2127 			else								tmpAlarm = Normal;
// 2128  		}
// 2129 		else if(Local_ChkNorAlarmVal_2G == 2)
??Local_ShutDownCheck_Common_8:
        CMP      R0,#+2
        BNE.N    ??Local_ShutDownCheck_Common_10
// 2130 		{
// 2131 			if	(PwrAlarm.DCFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_Common_0+0x10  ;; PwrAlarm + 36
        LDRB     R0,[R0, #+1]
        B.N      ??Local_ShutDownCheck_Common_9
// 2132 			else								tmpAlarm = Normal;
// 2133  		}
// 2134 		else if(Local_ChkNorAlarmVal_2G == 3)
??Local_ShutDownCheck_Common_10:
        CMP      R0,#+3
        BNE.N    ??Local_ShutDownCheck_Common_7
// 2135 		{
// 2136 			if	(PwrAlarm.ACFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_Common_0+0x8  ;; PwrAlarm
        LDRB     R0,[R0, #+36]
??Local_ShutDownCheck_Common_9:
        CBZ      R0,??Local_ShutDownCheck_Common_7
        MOVS     R4,#+1
// 2137 			else								tmpAlarm = Normal;
// 2138  		}
// 2139  	}
// 2140 
// 2141 	if(Local_SdBuffClear_2G)
??Local_ShutDownCheck_Common_7:
        LDRB     R0,[R5, #+3]
        CBZ      R0,??Local_ShutDownCheck_Common_11
// 2142 	{
// 2143 		Local_SdStep2G = _AlarmCheckStart;
        MOVS     R0,#+0
        STRB     R0,[R5, #+2]
// 2144 		Local_SdBuffClear_2G = FALSE;
        STRB     R0,[R5, #+3]
// 2145  
// 2146 	}	
// 2147 
// 2148 	if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_Common_11:
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_Common_12
// 2149 	USART1Printf("0:SdStep[%d][%d][%d]:[%d][%d]\n", Local_SdStep2G,tmpAlarm,Sts->AmpOnOff_Common,Local_ChkNorAlarm_2G,Local_ChkNorAlarmVal_2G);
        LDRB     R1,[R5, #+1]
        LDRB     R0,[R5, #+0]
        PUSH     {R0,R1}
        LDRB     R3,[R7, #+84]
        MOV      R2,R4
        LDRB     R1,[R5, #+2]
        LDR.N    R0,??Local_ShutDownCheck_Common_0+0x14  ;; `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
        BL       USART1Printf
        ADD      SP,SP,#+8
// 2150 	switch(Local_SdStep2G)
??Local_ShutDownCheck_Common_12:
        LDRB     R0,[R5, #+2]
        CBZ      R0,??Local_ShutDownCheck_Common_13
        CMP      R0,#+2
        BEQ.N    ??Local_ShutDownCheck_Common_14
        BCC.N    ??Local_ShutDownCheck_Common_15
        B.N      ??Local_ShutDownCheck_Common_16
// 2151 	{
// 2152 		case 0:
// 2153 			if(Local_ChkNorAlarm_2G)
??Local_ShutDownCheck_Common_13:
        LDRB     R0,[R5, #+0]
        CBZ      R0,??Local_ShutDownCheck_Common_17
// 2154 			{
// 2155 				if(tmpAlarm == Alarm)
        CMP      R4,#+1
        ITE      NE 
        MOVNE    R0,#+2
        MOVEQ    R0,#+1
// 2156 				{
// 2157 					Local_SdStep2G = 1;
??Local_ShutDownCheck_Common_18:
        STRB     R0,[R5, #+2]
??Local_ShutDownCheck_Common_1:
        POP      {R0,R4-R7,PC}    ;; return
// 2158 				}
// 2159 				else
// 2160 				{
// 2161 					Local_SdStep2G = 2;
// 2162 				}
// 2163 			}
// 2164 			else
// 2165 			{
// 2166 				if(tmpAlarm == Normal)
??Local_ShutDownCheck_Common_17:
        CBNZ     R4,??Local_ShutDownCheck_Common_16
// 2167 				{
// 2168 					AmpOff_Common(Enable);
??Local_ShutDownCheck_Common_19:
        BL       AmpOff_Common
// 2169 				}
// 2170 				Local_SdStep2G = 0;
??Local_ShutDownCheck_Common_16:
        MOVS     R0,#+0
        B.N      ??Local_ShutDownCheck_Common_18
// 2171 			}
// 2172 		break;
// 2173 
// 2174 		case 1:
// 2175 			if(tmpAlarm == Alarm)
??Local_ShutDownCheck_Common_15:
        CMP      R4,#+1
        BNE.N    ??Local_ShutDownCheck_Common_16
// 2176 			{
// 2177 				AmpOff_Common(Disable);
        MOVS     R0,#+1
        B.N      ??Local_ShutDownCheck_Common_19
// 2178 			}
// 2179 			Local_SdStep2G = 0;
// 2180 		break;
// 2181 
// 2182 		case 2:
// 2183 			if(tmpAlarm == Normal)
??Local_ShutDownCheck_Common_14:
        CMP      R4,#+0
        BNE.N    ??Local_ShutDownCheck_Common_16
// 2184 			{
// 2185 				AmpOff_Common(Enable);
        MOVS     R0,#+0
        B.N      ??Local_ShutDownCheck_Common_19
        DATA
??Local_ShutDownCheck_Common_0:
        DC32     tDnrSts
        DC32     Local_ChkNorAlarm_2G
        DC32     PwrAlarm
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">`
        DC32     PwrAlarm + 36
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
// 2186 			}
// 2187 			Local_SdStep2G = 0;
// 2188 		break;
// 2189 
// 2190 		default:
// 2191 			Local_SdStep2G = 0;
// 2192 		break;
// 2193 	}
// 2194 }
// 2195 
// 2196 
// 2197 
// 2198 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2199 void Local_ShutDownCheck_3G(void)
// 2200 {
Local_ShutDownCheck_3G:
        PUSH     {R3-R7,LR}
// 2201 	INT8U tmpAlarm = 0;
        MOVS     R4,#+0
// 2202 
// 2203 	__Dnr_Sts *Sts = tDnrSts;
        LDR.N    R6,??Local_ShutDownCheck_3G_0  ;; tDnrSts
        LDR      R0,[R6, #+0]
        MOV      R7,R0
// 2204 
// 2205     if(Sts->ShutDownOnOff_3G == Disable) return;
        LDRB     R1,[R7, #+201]
        CMP      R1,#+1
        BEQ.N    ??Local_ShutDownCheck_3G_1
// 2206 
// 2207 	if(Local_ChkNorAlarm_3G == 0)
        LDR.N    R5,??Local_ShutDownCheck_3G_0+0x4  ;; Local_ChkNorAlarm_3G
        LDRB     R1,[R5, #+0]
        CBNZ     R1,??Local_ShutDownCheck_3G_2
// 2208 	{
// 2209 		if 		(PwrAlarm.PLL_Fail_Common1)			Local_ChkNorAlarmVal_3G	= 1;
        LDR.N    R1,??Local_ShutDownCheck_3G_0+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+1]
        CBZ      R2,??Local_ShutDownCheck_3G_3
        MOVS     R2,#+1
??Local_ShutDownCheck_3G_4:
        STRB     R2,[R5, #+1]
        B.N      ??Local_ShutDownCheck_3G_5
// 2210 		else if (PwrAlarm.DCFail)					Local_ChkNorAlarmVal_3G	= 2;
??Local_ShutDownCheck_3G_3:
        ADD      R2,R1,#+36
        LDRB     R2,[R2, #+1]
        CBZ      R2,??Local_ShutDownCheck_3G_6
        MOVS     R2,#+2
        B.N      ??Local_ShutDownCheck_3G_4
// 2211 		else if (PwrAlarm.ACFail)					Local_ChkNorAlarmVal_3G	= 3;
??Local_ShutDownCheck_3G_6:
        LDRB     R2,[R1, #+36]
        CBZ      R2,??Local_ShutDownCheck_3G_7
        MOVS     R2,#+3
        B.N      ??Local_ShutDownCheck_3G_4
// 2212 
// 2213 		if(Local_ChkNorAlarmVal_3G) Local_ChkNorAlarm_3G = Alarm;
??Local_ShutDownCheck_3G_7:
        LDRB     R2,[R5, #+1]
        CBZ      R2,??Local_ShutDownCheck_3G_8
??Local_ShutDownCheck_3G_5:
        MOVS     R2,#+1
        STRB     R2,[R5, #+0]
// 2214 
// 2215 		if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_3G_8:
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_3G_9
// 2216 		USART1Printf("PwrAlarm[%d][%d]\n", PwrAlarm.PLL_Fail_Common1,Local_ChkNorAlarmVal_3G);
        LDRB     R2,[R5, #+1]
        LDRB     R1,[R1, #+1]
        LDR.N    R0,??Local_ShutDownCheck_3G_0+0xC  ;; `?<Constant "PwrAlarm[%d][%d]\\n">`
        BL       USART1Printf
        B.N      ??Local_ShutDownCheck_3G_9
// 2217 	}
// 2218 	else if(Local_ChkNorAlarm_3G)
// 2219 	{
// 2220 		if(Local_ChkNorAlarmVal_3G == 1)
??Local_ShutDownCheck_3G_2:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+1
        BNE.N    ??Local_ShutDownCheck_3G_10
// 2221 		{
// 2222 			if	(PwrAlarm.PLL_Fail_Common1)		tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_3G_0+0x8  ;; PwrAlarm
??Local_ShutDownCheck_3G_11:
        LDRB     R0,[R0, #+1]
        B.N      ??Local_ShutDownCheck_3G_12
// 2223 			else								tmpAlarm = Normal;
// 2224  		}
// 2225 		else if(Local_ChkNorAlarmVal_3G == 2)
??Local_ShutDownCheck_3G_10:
        CMP      R0,#+2
        BNE.N    ??Local_ShutDownCheck_3G_13
// 2226 		{
// 2227 			if	(PwrAlarm.DCFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_3G_0+0x10  ;; PwrAlarm + 36
        B.N      ??Local_ShutDownCheck_3G_11
// 2228 			else								tmpAlarm = Normal;
// 2229  		}
// 2230 		else if(Local_ChkNorAlarmVal_3G == 3)
??Local_ShutDownCheck_3G_13:
        CMP      R0,#+3
        BNE.N    ??Local_ShutDownCheck_3G_9
// 2231 		{
// 2232 			if	(PwrAlarm.ACFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_3G_0+0x8  ;; PwrAlarm
        LDRB     R0,[R0, #+36]
??Local_ShutDownCheck_3G_12:
        CBZ      R0,??Local_ShutDownCheck_3G_9
        MOVS     R4,#+1
// 2233 			else								tmpAlarm = Normal;
// 2234  		}
// 2235  	}
// 2236 
// 2237 	if(Local_SdBuffClear_3G)
??Local_ShutDownCheck_3G_9:
        LDRB     R0,[R5, #+3]
        CBZ      R0,??Local_ShutDownCheck_3G_14
// 2238 	{
// 2239 		Local_SdStep3G = _AlarmCheckStart;
        MOVS     R0,#+0
        STRB     R0,[R5, #+2]
// 2240 		Local_SdBuffClear_3G = FALSE;
        STRB     R0,[R5, #+3]
// 2241  
// 2242 	}	
// 2243 
// 2244 	if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_3G_14:
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_3G_15
// 2245 	USART1Printf("0:SdStep[%d][%d][%d]:[%d][%d]\n", Local_SdStep3G,tmpAlarm,Sts->AmpOnOff_3G,Local_ChkNorAlarm_3G,Local_ChkNorAlarmVal_3G);
        LDRB     R1,[R5, #+1]
        LDRB     R0,[R5, #+0]
        PUSH     {R0,R1}
        LDRB     R3,[R7, #+83]
        MOV      R2,R4
        LDRB     R1,[R5, #+2]
        LDR.N    R0,??Local_ShutDownCheck_3G_0+0x14  ;; `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
        BL       USART1Printf
        ADD      SP,SP,#+8
// 2246 	switch(Local_SdStep3G)
??Local_ShutDownCheck_3G_15:
        LDRB     R0,[R5, #+2]
        CBZ      R0,??Local_ShutDownCheck_3G_16
        CMP      R0,#+2
        BEQ.N    ??Local_ShutDownCheck_3G_17
        BCC.N    ??Local_ShutDownCheck_3G_18
        B.N      ??Local_ShutDownCheck_3G_19
// 2247 	{
// 2248 		case 0:
// 2249 			if(Local_ChkNorAlarm_3G)
??Local_ShutDownCheck_3G_16:
        LDRB     R0,[R5, #+0]
        CBZ      R0,??Local_ShutDownCheck_3G_17
// 2250 			{
// 2251 				if(tmpAlarm == Alarm)
        CMP      R4,#+1
        ITE      NE 
        MOVNE    R0,#+2
        MOVEQ    R0,#+1
// 2252 				{
// 2253 					Local_SdStep3G = 1;
??Local_ShutDownCheck_3G_20:
        STRB     R0,[R5, #+2]
??Local_ShutDownCheck_3G_1:
        POP      {R0,R4-R7,PC}    ;; return
// 2254 				}
// 2255 				else
// 2256 				{
// 2257 					Local_SdStep3G = 2;
// 2258 				}
// 2259 			}
// 2260 			else
// 2261 			{
// 2262 				if(tmpAlarm == Normal)
??Local_ShutDownCheck_3G_17:
        CBNZ     R4,??Local_ShutDownCheck_3G_19
// 2263 				{
// 2264 					AmpOff_LTE_A(Enable);
        MOVS     R0,#+0
        BL       AmpOff_LTE_A
// 2265 					AmpOff_3G(Enable);
        MOVS     R0,#+0
??Local_ShutDownCheck_3G_21:
        BL       AmpOff_3G
// 2266 				}
// 2267 				Local_SdStep3G = 0;
??Local_ShutDownCheck_3G_19:
        MOVS     R0,#+0
        B.N      ??Local_ShutDownCheck_3G_20
// 2268 			}
// 2269 		break;
// 2270 
// 2271 		case 1:
// 2272 			if(tmpAlarm == Alarm)
??Local_ShutDownCheck_3G_18:
        CMP      R4,#+1
        BNE.N    ??Local_ShutDownCheck_3G_19
// 2273 			{
// 2274 				AmpOff_LTE_A(Disable);
        MOVS     R0,#+1
        BL       AmpOff_LTE_A
// 2275 				AmpOff_3G(Disable);
        MOVS     R0,#+1
        B.N      ??Local_ShutDownCheck_3G_21
        Nop      
        DATA
??Local_ShutDownCheck_3G_0:
        DC32     tDnrSts
        DC32     Local_ChkNorAlarm_3G
        DC32     PwrAlarm
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">`
        DC32     PwrAlarm + 36
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
// 2276 			}
// 2277 			Local_SdStep3G = 0;
// 2278 		break;
// 2279 
// 2280 		case 2:
// 2281 			if(tmpAlarm == Normal)
// 2282 			{
// 2283 				AmpOff_LTE_A(Enable);
// 2284 				AmpOff_3G(Enable);
// 2285 
// 2286 			}
// 2287 			Local_SdStep3G = 0;
// 2288 		break;
// 2289 
// 2290 		default:
// 2291 			Local_SdStep3G = 0;
// 2292 		break;
// 2293 	}
// 2294 }
// 2295 
// 2296 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2297 void Local_ShutDownCheck_LTE1(void)
// 2298 {
Local_ShutDownCheck_LTE1:
        PUSH     {R3-R7,LR}
// 2299 	INT8U tmpAlarm = 0;
        MOVS     R4,#+0
// 2300 
// 2301 	__Dnr_Sts *Sts = tDnrSts;
        LDR.N    R6,??Local_ShutDownCheck_LTE1_0  ;; tDnrSts
        LDR      R0,[R6, #+0]
        MOV      R7,R0
// 2302 
// 2303     if(Sts->ShutDownOnOff_LTE1 == Disable) return;
        LDRB     R1,[R7, #+809]
        CMP      R1,#+1
        BEQ.N    ??Local_ShutDownCheck_LTE1_1
// 2304 
// 2305 	if(Local_ChkNorAlarm_LTE1 == 0)
        LDR.N    R5,??Local_ShutDownCheck_LTE1_0+0x4  ;; Local_ChkNorAlarm_LTE1
        LDRB     R1,[R5, #+0]
        CBNZ     R1,??Local_ShutDownCheck_LTE1_2
// 2306 	{
// 2307 		if 		(PwrAlarm.PLL_Fail_LTE1)			Local_ChkNorAlarmVal_LTE1	= 1;
        LDR.N    R1,??Local_ShutDownCheck_LTE1_0+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+2]
        CBZ      R2,??Local_ShutDownCheck_LTE1_3
        MOVS     R2,#+1
        B.N      ??Local_ShutDownCheck_LTE1_4
// 2308 		else if (PwrAlarm.DCFail)					Local_ChkNorAlarmVal_LTE1	= 2;
??Local_ShutDownCheck_LTE1_3:
        ADD      R2,R1,#+36
        LDRB     R2,[R2, #+1]
        CBZ      R2,??Local_ShutDownCheck_LTE1_5
        MOVS     R2,#+2
        B.N      ??Local_ShutDownCheck_LTE1_4
// 2309 		else if (PwrAlarm.ACFail)					Local_ChkNorAlarmVal_LTE1	= 3;
??Local_ShutDownCheck_LTE1_5:
        LDRB     R2,[R1, #+36]
        CBZ      R2,??Local_ShutDownCheck_LTE1_6
        MOVS     R2,#+3
??Local_ShutDownCheck_LTE1_4:
        STRB     R2,[R5, #+1]
// 2310 
// 2311 
// 2312 		if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_LTE1_6:
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_LTE1_7
// 2313 		USART1Printf("PwrAlarm[%d][%d]\n", PwrAlarm.PLL_Fail_LTE1,Local_ChkNorAlarmVal_LTE1);
        LDRB     R2,[R5, #+1]
        LDRB     R1,[R1, #+2]
        LDR.N    R0,??Local_ShutDownCheck_LTE1_0+0xC  ;; `?<Constant "PwrAlarm[%d][%d]\\n">`
        BL       USART1Printf
        B.N      ??Local_ShutDownCheck_LTE1_7
// 2314 	}
// 2315 	else if(Local_ChkNorAlarm_LTE1)
// 2316 	{
// 2317 		if(Local_ChkNorAlarmVal_LTE1 == 1)
??Local_ShutDownCheck_LTE1_2:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+1
        BNE.N    ??Local_ShutDownCheck_LTE1_8
// 2318 		{
// 2319 			if	(PwrAlarm.PLL_Fail_LTE1)		tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_LTE1_0+0x8  ;; PwrAlarm
        LDRB     R0,[R0, #+2]
        B.N      ??Local_ShutDownCheck_LTE1_9
// 2320 			else								tmpAlarm = Normal;
// 2321  		}
// 2322 		else if(Local_ChkNorAlarmVal_LTE1 == 2)
??Local_ShutDownCheck_LTE1_8:
        CMP      R0,#+2
        BNE.N    ??Local_ShutDownCheck_LTE1_10
// 2323 		{
// 2324 			if	(PwrAlarm.DCFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_LTE1_0+0x10  ;; PwrAlarm + 36
        LDRB     R0,[R0, #+1]
        B.N      ??Local_ShutDownCheck_LTE1_9
// 2325 			else								tmpAlarm = Normal;
// 2326  		}
// 2327 		else if(Local_ChkNorAlarmVal_LTE1 == 3)
??Local_ShutDownCheck_LTE1_10:
        CMP      R0,#+3
        BNE.N    ??Local_ShutDownCheck_LTE1_7
// 2328 		{
// 2329 			if	(PwrAlarm.ACFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_LTE1_0+0x8  ;; PwrAlarm
        LDRB     R0,[R0, #+36]
??Local_ShutDownCheck_LTE1_9:
        CBZ      R0,??Local_ShutDownCheck_LTE1_7
        MOVS     R4,#+1
// 2330 			else								tmpAlarm = Normal;
// 2331  		}
// 2332  	}
// 2333 
// 2334 	if(Local_SdBuffClear_LTE1)
??Local_ShutDownCheck_LTE1_7:
        LDRB     R0,[R5, #+3]
        CBZ      R0,??Local_ShutDownCheck_LTE1_11
// 2335 	{
// 2336 		Local_SdStepLTE1 = _AlarmCheckStart;
        MOVS     R0,#+0
        STRB     R0,[R5, #+2]
// 2337 		Local_SdBuffClear_LTE1 = FALSE;
        STRB     R0,[R5, #+3]
// 2338  
// 2339 	}	
// 2340 
// 2341 	if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_LTE1_11:
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_LTE1_12
// 2342 	USART1Printf("0:SdStep[%d][%d][%d]:[%d][%d]\n", Local_SdStepLTE1,tmpAlarm,Sts->Amp1OnOff_LTE,Local_ChkNorAlarm_LTE1,Local_ChkNorAlarmVal_LTE1);
        LDRB     R1,[R5, #+1]
        LDRB     R0,[R5, #+0]
        PUSH     {R0,R1}
        LDRB     R3,[R7, #+678]
        MOV      R2,R4
        LDRB     R1,[R5, #+2]
        LDR.N    R0,??Local_ShutDownCheck_LTE1_0+0x14  ;; `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
        BL       USART1Printf
        ADD      SP,SP,#+8
// 2343 	switch(Local_SdStepLTE1)
??Local_ShutDownCheck_LTE1_12:
        LDRB     R0,[R5, #+2]
        CBZ      R0,??Local_ShutDownCheck_LTE1_13
        CMP      R0,#+2
        BEQ.N    ??Local_ShutDownCheck_LTE1_14
        BCC.N    ??Local_ShutDownCheck_LTE1_15
        B.N      ??Local_ShutDownCheck_LTE1_16
// 2344 	{
// 2345 		case 0:
// 2346 			if(Local_ChkNorAlarm_LTE1)
??Local_ShutDownCheck_LTE1_13:
        LDRB     R0,[R5, #+0]
        CBZ      R0,??Local_ShutDownCheck_LTE1_17
// 2347 			{
// 2348 				if(tmpAlarm == Alarm)
        CMP      R4,#+1
        ITE      NE 
        MOVNE    R0,#+2
        MOVEQ    R0,#+1
// 2349 				{
// 2350 					Local_SdStepLTE1 = 1;
??Local_ShutDownCheck_LTE1_18:
        STRB     R0,[R5, #+2]
??Local_ShutDownCheck_LTE1_1:
        POP      {R0,R4-R7,PC}    ;; return
// 2351 				}
// 2352 				else
// 2353 				{
// 2354 					Local_SdStepLTE1 = 2;
// 2355 				}
// 2356 			}
// 2357 			else
// 2358 			{
// 2359 				if(tmpAlarm == Normal)
??Local_ShutDownCheck_LTE1_17:
        CBNZ     R4,??Local_ShutDownCheck_LTE1_16
// 2360 				{
// 2361 					Amp1Off_LTE(Enable);
??Local_ShutDownCheck_LTE1_19:
        BL       Amp1Off_LTE
// 2362 				}
// 2363 				Local_SdStepLTE1 = 0;
??Local_ShutDownCheck_LTE1_16:
        MOVS     R0,#+0
        B.N      ??Local_ShutDownCheck_LTE1_18
// 2364 			}
// 2365 		break;
// 2366 
// 2367 		case 1:
// 2368 			if(tmpAlarm == Alarm)
??Local_ShutDownCheck_LTE1_15:
        CMP      R4,#+1
        BNE.N    ??Local_ShutDownCheck_LTE1_16
// 2369 			{
// 2370 				Amp1Off_LTE(Disable);
        MOVS     R0,#+1
        B.N      ??Local_ShutDownCheck_LTE1_19
// 2371 			}
// 2372 			Local_SdStepLTE1 = 0;
// 2373 		break;
// 2374 
// 2375 		case 2:
// 2376 			if(tmpAlarm == Normal)
??Local_ShutDownCheck_LTE1_14:
        CMP      R4,#+0
        BNE.N    ??Local_ShutDownCheck_LTE1_16
// 2377 			{
// 2378 				Amp1Off_LTE(Enable);
        MOVS     R0,#+0
        B.N      ??Local_ShutDownCheck_LTE1_19
        DATA
??Local_ShutDownCheck_LTE1_0:
        DC32     tDnrSts
        DC32     Local_ChkNorAlarm_LTE1
        DC32     PwrAlarm
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">`
        DC32     PwrAlarm + 36
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
// 2379 
// 2380 			}
// 2381 			Local_SdStepLTE1 = 0;
// 2382 		break;
// 2383 
// 2384 		default:
// 2385 			Local_SdStepLTE1 = 0;
// 2386 		break;
// 2387 	}
// 2388 }
// 2389 
// 2390 
// 2391 
// 2392 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2393 void Local_ShutDownCheck_LTE_A1(void)
// 2394 {
Local_ShutDownCheck_LTE_A1:
        PUSH     {R3-R7,LR}
// 2395 	INT8U tmpAlarm = 0;
        MOVS     R4,#+0
// 2396 
// 2397 	__Dnr_Sts *Sts = tDnrSts;
        LDR.N    R6,??Local_ShutDownCheck_LTE_A1_0  ;; tDnrSts
        LDR      R0,[R6, #+0]
        MOV      R7,R0
// 2398 
// 2399     if(Sts->ShutDownOnOff_LTE_A1 == Disable) return;
        LDRB     R1,[R7, #+810]
        CMP      R1,#+1
        BEQ.N    ??Local_ShutDownCheck_LTE_A1_1
// 2400 
// 2401 	if(Local_ChkNorAlarm_LTE_A1 == 0)
        LDR.N    R5,??Local_ShutDownCheck_LTE_A1_0+0x4  ;; Local_ChkNorAlarm_LTE_A1
        LDRB     R1,[R5, #+0]
        CBNZ     R1,??Local_ShutDownCheck_LTE_A1_2
// 2402 	{
// 2403 		if 		(PwrAlarm.PLL_Fail_LTE_A1)			Local_ChkNorAlarmVal_LTE_A1	= 1;
        LDR.N    R1,??Local_ShutDownCheck_LTE_A1_0+0x8  ;; PwrAlarm
        LDRB     R2,[R1, #+3]
        CBZ      R2,??Local_ShutDownCheck_LTE_A1_3
        MOVS     R2,#+1
        B.N      ??Local_ShutDownCheck_LTE_A1_4
// 2404 		else if (PwrAlarm.DCFail)					Local_ChkNorAlarmVal_LTE_A1	= 2;
??Local_ShutDownCheck_LTE_A1_3:
        ADD      R2,R1,#+36
        LDRB     R2,[R2, #+1]
        CBZ      R2,??Local_ShutDownCheck_LTE_A1_5
        MOVS     R2,#+2
        B.N      ??Local_ShutDownCheck_LTE_A1_4
// 2405 		else if (PwrAlarm.ACFail)					Local_ChkNorAlarmVal_LTE_A1	= 3;
??Local_ShutDownCheck_LTE_A1_5:
        LDRB     R2,[R1, #+36]
        CBZ      R2,??Local_ShutDownCheck_LTE_A1_6
        MOVS     R2,#+3
??Local_ShutDownCheck_LTE_A1_4:
        STRB     R2,[R5, #+1]
// 2406 
// 2407 
// 2408 		if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_LTE_A1_6:
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_LTE_A1_7
// 2409 		USART1Printf("PwrAlarm[%d][%d]\n", PwrAlarm.PLL_Fail_LTE_A1,Local_ChkNorAlarmVal_LTE_A1);
        LDRB     R2,[R5, #+1]
        LDRB     R1,[R1, #+3]
        LDR.N    R0,??Local_ShutDownCheck_LTE_A1_0+0xC  ;; `?<Constant "PwrAlarm[%d][%d]\\n">`
        BL       USART1Printf
        B.N      ??Local_ShutDownCheck_LTE_A1_7
// 2410 	}
// 2411 	else if(Local_ChkNorAlarm_LTE_A1)
// 2412 	{
// 2413 		if(Local_ChkNorAlarmVal_LTE_A1 == 1)
??Local_ShutDownCheck_LTE_A1_2:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+1
        BNE.N    ??Local_ShutDownCheck_LTE_A1_8
// 2414 		{
// 2415 			if	(PwrAlarm.PLL_Fail_LTE_A1)		tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_LTE_A1_0+0x8  ;; PwrAlarm
        LDRB     R0,[R0, #+3]
        B.N      ??Local_ShutDownCheck_LTE_A1_9
// 2416 			else								tmpAlarm = Normal;
// 2417  		}
// 2418 		else if(Local_ChkNorAlarmVal_LTE_A1 == 2)
??Local_ShutDownCheck_LTE_A1_8:
        CMP      R0,#+2
        BNE.N    ??Local_ShutDownCheck_LTE_A1_10
// 2419 		{
// 2420 			if	(PwrAlarm.DCFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_LTE_A1_0+0x10  ;; PwrAlarm + 36
        LDRB     R0,[R0, #+1]
        B.N      ??Local_ShutDownCheck_LTE_A1_9
// 2421 			else								tmpAlarm = Normal;
// 2422  		}
// 2423 		else if(Local_ChkNorAlarmVal_LTE_A1 == 3)
??Local_ShutDownCheck_LTE_A1_10:
        CMP      R0,#+3
        BNE.N    ??Local_ShutDownCheck_LTE_A1_7
// 2424 		{
// 2425 			if	(PwrAlarm.ACFail)				tmpAlarm = Alarm;
        LDR.N    R0,??Local_ShutDownCheck_LTE_A1_0+0x8  ;; PwrAlarm
        LDRB     R0,[R0, #+36]
??Local_ShutDownCheck_LTE_A1_9:
        CBZ      R0,??Local_ShutDownCheck_LTE_A1_7
        MOVS     R4,#+1
// 2426 			else								tmpAlarm = Normal;
// 2427  		}
// 2428  	}
// 2429 
// 2430 	if(Local_SdBuffClear_LTE_A1)
??Local_ShutDownCheck_LTE_A1_7:
        LDRB     R0,[R5, #+3]
        CBZ      R0,??Local_ShutDownCheck_LTE_A1_11
// 2431 	{
// 2432 		Local_SdStepLTE_A1 = _AlarmCheckStart;
        MOVS     R0,#+0
        STRB     R0,[R5, #+2]
// 2433 		Local_SdBuffClear_LTE_A1 = FALSE;
        STRB     R0,[R5, #+3]
// 2434  
// 2435 	}	
// 2436 
// 2437 	if(tDnrSts->TestMode == Debug_LocalSD)
??Local_ShutDownCheck_LTE_A1_11:
        LDR      R0,[R6, #+0]
        LDRB     R0,[R0, #+861]
        CMP      R0,#+7
        BNE.N    ??Local_ShutDownCheck_LTE_A1_12
// 2438 	USART1Printf("0:SdStep[%d][%d][%d]:[%d][%d]\n", Local_SdStepLTE_A1,tmpAlarm,Sts->Amp1OnOff_LTE_A,Local_ChkNorAlarm_LTE_A1,Local_ChkNorAlarmVal_LTE_A1);
        LDRB     R1,[R5, #+1]
        LDRB     R0,[R5, #+0]
        PUSH     {R0,R1}
        LDRB     R3,[R7, #+677]
        MOV      R2,R4
        LDRB     R1,[R5, #+2]
        LDR.N    R0,??Local_ShutDownCheck_LTE_A1_0+0x14  ;; `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
        BL       USART1Printf
        ADD      SP,SP,#+8
// 2439 	switch(Local_SdStepLTE_A1)
??Local_ShutDownCheck_LTE_A1_12:
        LDRB     R0,[R5, #+2]
        CBZ      R0,??Local_ShutDownCheck_LTE_A1_13
        CMP      R0,#+2
        BEQ.N    ??Local_ShutDownCheck_LTE_A1_14
        BCC.N    ??Local_ShutDownCheck_LTE_A1_15
        B.N      ??Local_ShutDownCheck_LTE_A1_16
// 2440 	{
// 2441 		case 0:
// 2442 			if(Local_ChkNorAlarm_LTE_A1)
??Local_ShutDownCheck_LTE_A1_13:
        LDRB     R0,[R5, #+0]
        CBZ      R0,??Local_ShutDownCheck_LTE_A1_17
// 2443 			{
// 2444 				if(tmpAlarm == Alarm)
        CMP      R4,#+1
        ITE      NE 
        MOVNE    R0,#+2
        MOVEQ    R0,#+1
// 2445 				{
// 2446 					Local_SdStepLTE_A1 = 1;
??Local_ShutDownCheck_LTE_A1_18:
        STRB     R0,[R5, #+2]
??Local_ShutDownCheck_LTE_A1_1:
        POP      {R0,R4-R7,PC}    ;; return
// 2447 				}
// 2448 				else
// 2449 				{
// 2450 					Local_SdStepLTE_A1 = 2;
// 2451 				}
// 2452 			}
// 2453 			else
// 2454 			{
// 2455 				if(tmpAlarm == Normal)
??Local_ShutDownCheck_LTE_A1_17:
        CBNZ     R4,??Local_ShutDownCheck_LTE_A1_16
// 2456 				{
// 2457 					Amp1Off_LTE_A(Enable);
??Local_ShutDownCheck_LTE_A1_19:
        BL       Amp1Off_LTE_A
// 2458 				}
// 2459 				Local_SdStepLTE_A1 = 0;
??Local_ShutDownCheck_LTE_A1_16:
        MOVS     R0,#+0
        B.N      ??Local_ShutDownCheck_LTE_A1_18
// 2460 			}
// 2461 		break;
// 2462 
// 2463 		case 1:
// 2464 			if(tmpAlarm == Alarm)
??Local_ShutDownCheck_LTE_A1_15:
        CMP      R4,#+1
        BNE.N    ??Local_ShutDownCheck_LTE_A1_16
// 2465 			{
// 2466 				Amp1Off_LTE_A(Disable);
        MOVS     R0,#+1
        B.N      ??Local_ShutDownCheck_LTE_A1_19
// 2467 			}
// 2468 			Local_SdStepLTE_A1 = 0;
// 2469 		break;
// 2470 
// 2471 		case 2:
// 2472 			if(tmpAlarm == Normal)
??Local_ShutDownCheck_LTE_A1_14:
        CMP      R4,#+0
        BNE.N    ??Local_ShutDownCheck_LTE_A1_16
// 2473 			{
// 2474 				Amp1Off_LTE_A(Enable);
        MOVS     R0,#+0
        B.N      ??Local_ShutDownCheck_LTE_A1_19
        DATA
??Local_ShutDownCheck_LTE_A1_0:
        DC32     tDnrSts
        DC32     Local_ChkNorAlarm_LTE_A1
        DC32     PwrAlarm
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">`
        DC32     PwrAlarm + 36
        DC32     `?<Constant "PwrAlarm[%d][%d]\\n">` + 20
// 2475 
// 2476 			}
// 2477 			Local_SdStepLTE_A1 = 0;
// 2478 		break;
// 2479 
// 2480 		default:
// 2481 			Local_SdStepLTE_A1 = 0;
// 2482 		break;
// 2483 	}
// 2484 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0: SdStep_2G[%d]SdChe...">`:
        DATA
        DC8 "0: SdStep_2G[%d]SdChekcTime_2G[%d]:[%d][%d]:[%d]\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0: SdStep_3G[%d]SdChe...">`:
        DATA
        DC8 "0: SdStep_3G[%d]SdChekcTime_3G[%d]:[%d][%d]:[%d]\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "2: tmpx10[%d]tlimitLo...">`:
        DATA
        DC8 "2: tmpx10[%d]tlimitLow[%d]gap[%d]tmpTotAttn[%d]\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0: SdStep_LTE_A[%d]Sd...">`:
        DATA
        DC8 30H, 3AH, 20H, 53H, 64H, 53H, 74H, 65H
        DC8 70H, 5FH, 4CH, 54H, 45H, 5FH, 41H, 5BH
        DC8 25H, 64H, 5DH, 53H, 64H, 43H, 68H, 65H
        DC8 6BH, 63H, 54H, 69H, 6DH, 65H, 5FH, 4CH
        DC8 54H, 45H, 5FH, 41H, 5BH, 25H, 64H, 5DH
        DC8 3AH, 5BH, 25H, 64H, 5DH, 5BH, 25H, 64H
        DC8 5DH, 3AH, 5BH, 25H, 64H, 5DH, 0AH, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0: SdStep_LTE_A1[%d]S...">`:
        DATA
        DC8 30H, 3AH, 20H, 53H, 64H, 53H, 74H, 65H
        DC8 70H, 5FH, 4CH, 54H, 45H, 5FH, 41H, 31H
        DC8 5BH, 25H, 64H, 5DH, 53H, 64H, 43H, 68H
        DC8 65H, 6BH, 63H, 54H, 69H, 6DH, 65H, 5FH
        DC8 4CH, 54H, 45H, 5FH, 41H, 31H, 5BH, 25H
        DC8 64H, 5DH, 3AH, 5BH, 25H, 64H, 5DH, 5BH
        DC8 25H, 64H, 5DH, 3AH, 5BH, 25H, 64H, 5DH
        DC8 0AH, 0
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "0: SdStep_LTE1[%d]SdC...">`:
        DATA
        DC8 30H, 3AH, 20H, 53H, 64H, 53H, 74H, 65H
        DC8 70H, 5FH, 4CH, 54H, 45H, 31H, 5BH, 25H
        DC8 64H, 5DH, 53H, 64H, 43H, 68H, 65H, 6BH
        DC8 63H, 54H, 69H, 6DH, 65H, 5FH, 4CH, 54H
        DC8 45H, 31H, 5BH, 25H, 64H, 5DH, 3AH, 5BH
        DC8 25H, 64H, 5DH, 5BH, 25H, 64H, 5DH, 3AH
        DC8 5BH, 25H, 64H, 5DH, 0AH, 0
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "PwrAlarm[%d][%d]\\n">`:
        DATA
        DC8 "PwrAlarm[%d][%d]\012"
        DC8 0, 0
        DC8 "0:SdStep[%d][%d][%d]:[%d][%d]\012"
        DC8 0

        END
// 2485 
// 2486 
// 2487 ////////////////////////
// 
// 1 028 bytes in section .bss
//    78 bytes in section .data
//   380 bytes in section .rodata
// 7 260 bytes in section .text
// 
// 7 260 bytes of CODE  memory
//   380 bytes of CONST memory
// 1 106 bytes of DATA  memory
//
//Errors: none
//Warnings: none
