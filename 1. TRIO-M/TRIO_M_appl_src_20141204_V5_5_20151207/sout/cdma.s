///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:36 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\cdma. /
//                    c                                                       /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\cdma. /
//                    c -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120109\sout\ --endian=little --cpu=Cortex-M3 -e      /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\cdma. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME cdma

        EXTERN BcMRtryNo
        EXTERN BcMdemDebug
        EXTERN BcMdemInit
        EXTERN BcMdemRecv
        EXTERN BcMdemTcpExit
        EXTERN DownLoadGiveupTimerSet
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN Ser4Ptr
        EXTERN SerPtr
        EXTERN TimerRegist
        EXTERN USART1Printf
        EXTERN USART4BuffClear
        EXTERN pUSART4
        EXTERN tTestFlag

        PUBLIC AlarmMBuff
        PUBLIC AlarmMask
        PUBLIC B1_HostStation
        PUBLIC B1_TestStation
        PUBLIC BootAlarmFlag
        PUBLIC BootReason
        PUBLIC CdmaFirstFlag
        PUBLIC CdmaFuncselect
        PUBLIC CdmaReportRmtID
        PUBLIC DnrAlarmBuff
        PUBLIC DnrAlarmSndCnt
        PUBLIC DnrSmsTask
        PUBLIC DnrVerString
        PUBLIC EcIoFlag
        PUBLIC EcIoNew
        PUBLIC EcIoOld
        PUBLIC FirstFlag
        PUBLIC HostStation
        PUBLIC ModemStation
        PUBLIC ModemTimeRqstCnt
        PUBLIC NmsCtrlBdRstFlag
        PUBLIC NmsRspsFlag
        PUBLIC OneDayResetCnt
        PUBLIC PastHour
        PUBLIC PastMin
        PUBLIC PcFreqStsRqstFlag
        PUBLIC PeriodStart
        PUBLIC PhoneVersion_H
        PUBLIC PhoneVersion_L
        PUBLIC Pilot_Sts
        PUBLIC PnAlarm
        PUBLIC PnAlarmFlag
        PUBLIC PnAlarmNew
        PUBLIC PnAlarmOld
        PUBLIC PnChangeCnt
        PUBLIC PresentHour
        PUBLIC PresentMin
        PUBLIC RauAlarmBuff
        PUBLIC ResetPeriodSet
        PUBLIC Rf_sts
        PUBLIC RmtAlarmBuff
        PUBLIC RmtResetReason
        PUBLIC RmtVerString
        PUBLIC Rtcpsms
        PUBLIC Rwrcssms
        PUBLIC RxTxAlarmFlag
        PUBLIC RxTxAlarmNew
        PUBLIC RxTxAlarmOld
        PUBLIC SMSRecv
        PUBLIC SMSSend
        PUBLIC SmsInfo
        PUBLIC SmsInfoB
        PUBLIC SmsInit
        PUBLIC SmsResetPeriodFlag
        PUBLIC SmsSer
        PUBLIC SmsSerB
        PUBLIC SmsTx
        PUBLIC SmsTxFailFlag
        PUBLIC Stcpsms
        PUBLIC Swrcssms
        PUBLIC TcpDnLoadFlag
        PUBLIC TestStation
        PUBLIC TimeElapse
        PUBLIC TimeStart
        PUBLIC WOnePastHour
        PUBLIC WOnePastMin
        PUBLIC WOnePeriodStart
        PUBLIC WOneTimeElapse
        PUBLIC WOneTimeStart
        PUBLIC WThreePastHour
        PUBLIC WThreePastMin
        PUBLIC WThreePeriodStart
        PUBLIC WThreeTimeElapse
        PUBLIC WThreeTimeStart
        PUBLIC WTwoPastHour
        PUBLIC WTwoPastMin
        PUBLIC WTwoPeriodStart
        PUBLIC WTwoTimeElapse
        PUBLIC WTwoTimeStart
        PUBLIC WaveAlarm
        PUBLIC WaveAlarmB
        PUBLIC WaveCtrl
        PUBLIC WaveCtrlB
        PUBLIC WaveSts
        PUBLIC WaveStsB
        PUBLIC chkDnrAlarmReport
        PUBLIC chkHostStation
        PUBLIC chkReport
        PUBLIC chkRmtTemp
        PUBLIC iARTime_H
        PUBLIC iARTime_M
        PUBLIC iAutoReportPriod
        PUBLIC iDnrAlarmReport
        PUBLIC iDnrAlarmnRet
        PUBLIC iMasterPNH
        PUBLIC iMasterPNL
        PUBLIC iMaster_PN_Value
        PUBLIC iMobileESN
        PUBLIC iMobileManufacture
        PUBLIC iMobileModel
        PUBLIC iPNVal_Old
        PUBLIC iReportTime
        PUBLIC iRmtAlarmnRet
        PUBLIC iRmtTemp
        PUBLIC iSMS_Debug_Mode
        PUBLIC iSmsFalseCnt
        PUBLIC iTxVal
        PUBLIC iTxValH
        PUBLIC iTxValL
        PUBLIC iTx_Time_Value
        PUBLIC iWARHour
        PUBLIC iWARMinute
        PUBLIC iWARMode2
        PUBLIC iWARMode3
        PUBLIC iWARPriod2
        PUBLIC iWARPriod3
        PUBLIC iWReportHours
        PUBLIC iWReportTime
        PUBLIC iWave_Measure
        PUBLIC sentTel
        PUBLIC sms_buff
        PUBLIC sms_len
        PUBLIC sms_time
        PUBLIC t1SndData
        PUBLIC tcp_buff
        PUBLIC tcp_len
        PUBLIC tcp_port

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\cdma.c
//    1 /*******************************************************************************
//    2  *
//    3  * This module contains the function 7092 original header file, a function
//    4  * whole things  initializations - global, include function and so on
//    5  *
//    6  *
//    7  * Note that this function is called before the data segments are
//    8  * initialized, this means that this function cannot rely on the
//    9  * values of global or static variables.
//   10  *
//   11  *
//   12  * $Revision: 0.1 $
//   13  * $Revision date: 2006.03.__
//   14  *
//   15  ******************************************************************************/
//   16 #define SMS_C
//   17 
//   18 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// __ProtocolPtr __data SmsSerB
SmsSerB:
        DS8 48
// __ProtocolPtr *__data SmsSer
SmsSer:
        DS8 4
// __BODYFRAME __data Swrcssms
Swrcssms:
        DS8 1712
// __BODYFRAME __data Rwrcssms
Rwrcssms:
        DS8 1712
// __WRCSSIO __data Stcpsms
Stcpsms:
        DS8 1724
// __WRCSSIO __data Rtcpsms
Rtcpsms:
        DS8 1724
        DS8 4092

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PresentHour
PresentHour:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PresentMin
PresentMin:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PastHour
PastHour:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PastMin
PastMin:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PhoneVersion_H
PhoneVersion_H:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PhoneVersion_L
PhoneVersion_L:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data ModemStation[13]
ModemStation:
        DS8 16

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data HostStation[13]
HostStation:
        DS8 16

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data TestStation[13]
TestStation:
        DS8 16

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data B1_HostStation[13]
B1_HostStation:
        DS8 16

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data B1_TestStation[13]
B1_TestStation:
        DS8 16

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data TimeStart
TimeStart:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// long __data TimeElapse
TimeElapse:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data tcp_buff[1024]
tcp_buff:
        DS8 1024

        SECTION `.bss`:DATA:NOROOT(2)
// __BODYFRAME __data SMSRecv
SMSRecv:
        DS8 1712

        SECTION `.bss`:DATA:NOROOT(2)
// __BODYFRAME __data SMSSend
SMSSend:
        DS8 1712

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PnAlarm
PnAlarm:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RxTxAlarmOld
RxTxAlarmOld:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data EcIoOld
EcIoOld:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PnAlarmOld
PnAlarmOld:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RxTxAlarmNew
RxTxAlarmNew:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data EcIoNew
EcIoNew:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PnAlarmNew
PnAlarmNew:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RxTxAlarmFlag
RxTxAlarmFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data EcIoFlag
EcIoFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PnChangeCnt
PnChangeCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PnAlarmFlag
PnAlarmFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WOnePastHour
WOnePastHour:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WOnePastMin
WOnePastMin:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WOneTimeStart
WOneTimeStart:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// long __data WOneTimeElapse
WOneTimeElapse:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WTwoPastHour
WTwoPastHour:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WTwoPastMin
WTwoPastMin:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WTwoTimeStart
WTwoTimeStart:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// long __data WTwoTimeElapse
WTwoTimeElapse:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WThreePastHour
WThreePastHour:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WThreePastMin
WThreePastMin:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data WThreeTimeStart
WThreeTimeStart:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// long __data WThreeTimeElapse
WThreeTimeElapse:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data iPNVal_Old[12]
iPNVal_Old:
        DS8 12

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data CdmaReportRmtID
CdmaReportRmtID:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data CdmaFirstFlag
CdmaFirstFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iSmsFalseCnt
iSmsFalseCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkHostStation
chkHostStation:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// _WaveAlarm __data WaveAlarmB
WaveAlarmB:
        DS8 20

        SECTION `.bss`:DATA:NOROOT(2)
// _WaveSts __data WaveStsB
WaveStsB:
        DS8 32

        SECTION `.bss`:DATA:NOROOT(2)
// _WaveCtrl __data WaveCtrlB
WaveCtrlB:
        DS8 32

        SECTION `.bss`:DATA:NOROOT(2)
// _SmsInfo __data SmsInfoB
SmsInfoB:
        DS8 88

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data AlarmMask
AlarmMask:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkDnrAlarmReport
chkDnrAlarmReport:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DnrAlarmSndCnt
DnrAlarmSndCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data AlarmMBuff[100]
AlarmMBuff:
        DS8 100

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data SmsTx
SmsTx:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkReport
chkReport:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data NmsCtrlBdRstFlag
NmsCtrlBdRstFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data NmsRspsFlag
NmsRspsFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data BootReason
BootReason:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RmtResetReason
RmtResetReason:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iMobileModel
iMobileModel:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iMobileManufacture
iMobileManufacture:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data iMobileESN
iMobileESN:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iAutoReportPriod
iAutoReportPriod:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data iReportTime
iReportTime:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iARTime_H
iARTime_H:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iARTime_M
iARTime_M:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iMasterPNH
iMasterPNH:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iMasterPNL
iMasterPNL:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iTx_Time_Value
iTx_Time_Value:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iMaster_PN_Value
iMaster_PN_Value:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iTxValH
iTxValH:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iTxValL
iTxValL:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data iTxVal
iTxVal:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iWARPriod2
iWARPriod2:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iWARPriod3
iWARPriod3:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data iWReportTime
iWReportTime:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data iWReportHours
iWReportHours:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iWARHour
iWARHour:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iWARMinute
iWARMinute:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iWARMode2
iWARMode2:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iWARMode3
iWARMode3:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data iRmtTemp
iRmtTemp:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data chkRmtTemp
chkRmtTemp:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data t1SndData[512]
t1SndData:
        DS8 512

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data iWave_Measure
iWave_Measure:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iDnrAlarmReport
iDnrAlarmReport:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data iDnrAlarmnRet[3]
iDnrAlarmnRet:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data iRmtAlarmnRet[3]
iRmtAlarmnRet:
        DS8 4
//   19 
//   20 #if 1

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   21 void SmsInit(void)			// insert in (void PeripheralsInit(void))
//   22 {
SmsInit:
        PUSH     {R4,LR}
//   23 	SmsSer = &SmsSerB;
        LDR.N    R4,??SmsInit_0   ;; SmsSerB
        STR      R4,[R4, #+48]
//   24 
//   25  	SmsSer->CheckByte 	= pUSART4.CheckByte;
        LDR.N    R0,??SmsInit_0+0x4  ;; pUSART4
        LDR      R1,[R0, #+4]
        STR      R1,[R4, #+0]
//   26 	SmsSer->RxGetByte 	= pUSART4.RxGetByte;
        LDR      R1,[R0, #+8]
        STR      R1,[R4, #+4]
//   27 	SmsSer->PutStr 		= pUSART4.PutStr;
        LDR      R1,[R0, #+12]
        STR      R1,[R4, #+8]
//   28 	SmsSer->TxCheckByte = pUSART4.TxCheckByte;
        LDR      R0,[R0, #+28]
        STR      R0,[R4, #+16]
//   29 
//   30 	SmsSer->TimerRx 		= TimerSmsRx;
        MOVS     R0,#+12
        STRH     R0,[R4, #+20]
//   31 	SmsSer->TimerEndWait 	= TimerSmsEndWait;
        MOVS     R0,#+13
        STRH     R0,[R4, #+22]
//   32 
//   33 	SmsSer->WRCSRecv = &Rtcpsms;
        MOVW     R0,#+5200
        ADDS     R0,R0,R4
        STR      R0,[R4, #+28]
//   34 	SmsSer->WRCSSend = &Stcpsms;
        ADDW     R0,R4,#+3476
        STR      R0,[R4, #+32]
//   35 
//   36 	SmsSer->SmsRecv = &Rwrcssms;
        ADDW     R0,R4,#+1764
        STR      R0,[R4, #+36]
//   37 	SmsSer->SmsSend = &Swrcssms;	
        ADD      R0,R4,#+52
        STR      R0,[R4, #+40]
//   38 
//   39 	
//   40 	SmsSer->Sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+48]
        STR      R0,[R1, #+44]
//   41 
//   42 	OSTaskCreate(DnrSmsTask, (void *)NULL, (OS_STK *)&CDMATaskStk[CDMA_START_STK_SIZE-1], SMSTASK_PRIO);
        MOVS     R3,#+6
        MOVW     R0,#+11012
        ADDS     R2,R0,R4
        MOVS     R1,#+0
        LDR.N    R0,??SmsInit_0+0x8  ;; DnrSmsTask
        POP      {R4,LR}
        B.W      OSTaskCreate
        DATA
??SmsInit_0:
        DC32     SmsSerB
        DC32     pUSART4
        DC32     DnrSmsTask
//   43 }
//   44 
//   45 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   46 void ResetPeriodSet(void)
//   47 {
ResetPeriodSet:
        PUSH     {R7,LR}
//   48 	TimerRegist(TimerSmsFirstTx, Time1Sec*540L); // 9min
        LDR.N    R1,??ResetPeriodSet_0  ;; 0x83d60
        MOVS     R0,#+20
        BL       TimerRegist
//   49 	OSTimeDly(1000L);
        MOV      R0,#+1000
        BL       OSTimeDly
//   50 	
//   51 	SmsResetPeriodFlag = FALSE; //Reset 주기 체크 한다.
        LDR.N    R0,??DataTable2  ;; PeriodStart
        MOVS     R1,#+0
        STRB     R1,[R0, #+5]
//   52 }
        POP      {R0,PC}          ;; return
        Nop      
        DATA
??ResetPeriodSet_0:
        DC32     0x83d60
//   53 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   54 INT32S CdmaFuncselect(void)
//   55 {
//   56 	// Modem Status Check.
//   57 ////////////////////////////////////////////////////////////////////////////////////////	
//   58 	// error Case
//   59 	if(BcMRtryNo >= MaxTryNo)
CdmaFuncselect:
        LDR.N    R0,??DataTable3  ;; BcMRtryNo
        LDRB     R1,[R0, #+0]
        CMP      R1,#+3
        BCC.N    ??CdmaFuncselect_0
//   60 	{	
//   61 		BcMRtryNo = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   62 		return  MAX_TRY;
        MVN      R0,#+1
        BX       LR
//   63 	}
//   64 	
//   65 	return SELF_RECV;
??CdmaFuncselect_0:
        MOVS     R0,#+3
        BX       LR               ;; return
//   66 	
//   67 }

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data PeriodStart
PeriodStart:
        DATA
        DC8 1
// INT8U __data iSMS_Debug_Mode
iSMS_Debug_Mode:
        DC8 0
// INT8U __data BootAlarmFlag
BootAlarmFlag:
        DC8 0
// INT8U __data FirstFlag
FirstFlag:
        DC8 0
// INT8U __data TcpDnLoadFlag
TcpDnLoadFlag:
        DC8 0
// INT8U __data SmsResetPeriodFlag
SmsResetPeriodFlag:
        DC8 0
// INT8U __data SmsTxFailFlag
SmsTxFailFlag:
        DC8 0
// INT8U __data ModemTimeRqstCnt
ModemTimeRqstCnt:
        DC8 0
// INT8U __data PcFreqStsRqstFlag
PcFreqStsRqstFlag:
        DC8 0
        DC8 0, 0, 0
// INT32U __data OneDayResetCnt
OneDayResetCnt:
        DC8 0, 0, 0, 0
//   68 
//   69 
//   70 
//   71 #if 1
//   72 INT8U sms_buff[256];
//   73 INT8U sentTel[TelNo];
//   74 INT32S sms_len;
sms_len:
        DC8 0, 0, 0, 0
sms_buff:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
sentTel:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   75 BcMTimeStr sms_time;
sms_time:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data WOnePeriodStart
WOnePeriodStart:
        DATA
        DC8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data WTwoPeriodStart
WTwoPeriodStart:
        DATA
        DC8 1

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data WThreePeriodStart
WThreePeriodStart:
        DATA
        DC8 1

        SECTION `.data`:DATA:NOROOT(2)
// char *__data DnrVerString
DnrVerString:
        DATA
        DC32 `?<Constant "Ver0.4:Dnr Center TES...">`

        SECTION `.data`:DATA:NOROOT(2)
// char *__data RmtVerString
RmtVerString:
        DATA
        DC32 `?<Constant "Ver0.5:Rmt Center TES...">`

        SECTION `.data`:DATA:NOROOT(2)
// _WaveAlarm *__data WaveAlarm
WaveAlarm:
        DATA
        DC32 WaveAlarmB

        SECTION `.data`:DATA:NOROOT(2)
// _WaveSts *__data WaveSts
WaveSts:
        DATA
        DC32 WaveStsB

        SECTION `.data`:DATA:NOROOT(2)
// _WaveCtrl *__data WaveCtrl
WaveCtrl:
        DATA
        DC32 WaveCtrlB

        SECTION `.data`:DATA:NOROOT(2)
// _SmsInfo *__data SmsInfo
SmsInfo:
        DATA
        DC32 SmsInfoB

        SECTION `.data`:DATA:NOROOT(2)
// INT8U *__data DnrAlarmBuff
DnrAlarmBuff:
        DATA
        DC32 AlarmMBuff

        SECTION `.data`:DATA:NOROOT(2)
// INT8U *__data RmtAlarmBuff
RmtAlarmBuff:
        DATA
        DC32 AlarmMBuff

        SECTION `.data`:DATA:NOROOT(2)
// INT8U *__data RauAlarmBuff
RauAlarmBuff:
        DATA
        DC32 AlarmMBuff

        SECTION `.bss`:DATA:NOROOT(2)
//   76 BcMRfStsStr Rf_sts;
Rf_sts:
        DS8 52

        SECTION `.bss`:DATA:NOROOT(2)
//   77 BcMPilotStsStr Pilot_Sts;
Pilot_Sts:
        DS8 16

        SECTION `.bss`:DATA:NOROOT(2)
//   78 INT32S tcp_port;
tcp_port:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
//   79 INT32S tcp_len;
tcp_len:
        DS8 4
//   80 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   81 void DnrSmsTask(void * pdata)
//   82 {
DnrSmsTask:
        PUSH     {R3-R11,LR}
//   83 
//   84 	INT16U InitCnt = 0;
        MOVS     R6,#+0
//   85     //INT16U i = 0;
//   86 	INT8S s = 0 ;
//   87 		
//   88     //INT16U Cnt = 0;
//   89 	//INT16U nRet = 0;
//   90 //	__ProtocolPtr *nPtr = SmsSer;
//   91 
//   92 	pdata = pdata;
//   93 
//   94 	iSMS_Debug_Mode = SET;//SET;//RESET;
        LDR.N    R4,??DataTable2  ;; PeriodStart
        MOVS     R0,#+1
        STRB     R0,[R4, #+1]
//   95 	
//   96 	TcpDnLoadFlag = RESET;
        MOVS     R0,#+0
        STRB     R0,[R4, #+4]
//   97 	OneDayResetCnt = RESET;
        STR      R0,[R4, #+12]
//   98 
//   99 	// SmsResetPeriodFlag : TRUE 이면 Reset허용
//  100 	// SmsResetPeriodFlag : FALSE 이면 Reset불가
//  101 	
//  102 	SmsResetPeriodFlag = TRUE; //Reset 주기 체크 한다.
        MOVS     R0,#+1
        STRB     R0,[R4, #+5]
//  103 	SmsTxFailFlag = FALSE;
        STRB     R6,[R4, #+6]
//  104 	
//  105 	USART4BuffClear();
        BL       USART4BuffClear
//  106 
//  107 	SMS_PWR = 0;
        LDR.N    R5,??DnrSmsTask_0  ;; 0x4001180c
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0x800
        STR      R0,[R5, #+0]
//  108 	OSTimeDly(1000L*5L);
        MOVW     R10,#+5000
        MOV      R0,R10
        BL       OSTimeDly
//  109 	SMS_PWR = 1;
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x800
        STR      R0,[R5, #+0]
//  110 	
//  111 	BcMdemTcpExit();
        BL       BcMdemTcpExit
//  112 		
//  113 	OSTimeDly(1000L*5L);
        MOV      R0,R10
        BL       OSTimeDly
//  114 	
//  115 	PeriodStart = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
//  116 
//  117 	BcMdemDebug(iSMS_Debug_Mode, (INT32S *)SerPtr);
        LDR.W    R11,??DnrSmsTask_0+0x4  ;; SerPtr
        LDR      R1,[R11, #+0]
        LDRB     R0,[R4, #+1]
        BL       BcMdemDebug
//  118 	BootAlarmFlag = TRUE;		
        MOVS     R0,#+1
        STRB     R0,[R4, #+2]
//  119 	goto RETRY_START;
        LDR.W    R9,??DataTable3  ;; BcMRtryNo
        LDR.N    R7,??DnrSmsTask_0+0x8  ;; tTestFlag
        LDR.W    R8,??DnrSmsTask_0+0xC  ;; `?<Constant "PW Reset \\n">`
        B.N      ??DnrSmsTask_1
//  120 
//  121 SWRST_START:
//  122 	BcMdemTcpExit();
//  123 	SmsResetPeriodFlag = TRUE;
//  124 	
//  125 	//LEWD if(iSMS_Debug_Mode) USART1Printf("SW Reset \n");
//  126 		
//  127 	//if(BcMdemSwReset() == TRUE)	goto RETRY_START;
//  128 		
//  129 PWRST_START:
//  130 		
//  131 		InitCnt = 0;
//  132 
//  133 		//LEWD if(iSMS_Debug_Mode) USART1Printf("PW Reset \n");
//  134 
//  135 		SMS_PWR = 0;
//  136 		OSTimeDly(1000L*5L);
//  137 		SMS_PWR = 1;
//  138 
//  139 		BootAlarmFlag = TRUE;
//  140 		OneDayResetCnt = NULL;
//  141 		TcpDnLoadFlag = RESET;
//  142 					
//  143 		OSTimeDly(1000L*5L);
//  144 		USART1Printf("PW Reset \n");
//  145 RETRY_START:
//  146 	
//  147 		if( BcMdemInit(Ser4Ptr, TimerSmsRx) <= 0)
//  148 		{
//  149 			//DnrSts->ETC_ALM1.Bit.ModemLinkFail = Alarm;
//  150 
//  151 			while(tTestFlag)
??DnrSmsTask_2:
        LDRB     R0,[R7, #+0]
        CBZ      R0,??DnrSmsTask_3
//  152 			{
//  153 				OSTimeDly(100L);
??DnrSmsTask_4:
        MOVS     R0,#+100
        BL       OSTimeDly
        LDRB     R0,[R7, #+0]
        CMP      R0,#+0
        BNE.N    ??DnrSmsTask_4
//  154 			}	
//  155 				
//  156 			if(++InitCnt > MaxTryNo)
??DnrSmsTask_3:
        ADDS     R0,R6,#+1
        UXTH     R6,R0
        CMP      R6,#+4
        BCC.N    ??DnrSmsTask_1
//  157 			{	
//  158 				InitCnt = 0;
        MOVS     R6,#+0
//  159 				
//  160 				if(SmsResetPeriodFlag)
        LDRB     R0,[R4, #+5]
        CBZ      R0,??DnrSmsTask_1
//  161 				{					
//  162 					 ResetPeriodSet();
        BL       ResetPeriodSet
//  163 					 SmsTxFailFlag = FALSE;
        MOVS     R0,#+0
??DnrSmsTask_5:
        STRB     R0,[R4, #+6]
//  164 					 
//  165 					 goto PWRST_START;
//  166 				}
//  167 				else goto RETRY_START;
//  168 				
//  169 			}
//  170 			else goto RETRY_START;
//  171 		}
??DnrSmsTask_6:
        MOVS     R6,#+0
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0x800
        STR      R0,[R5, #+0]
        MOV      R0,R10
        BL       OSTimeDly
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x800
        STR      R0,[R5, #+0]
        MOVS     R0,#+1
        STRB     R0,[R4, #+2]
        MOVS     R0,#+0
        STR      R0,[R4, #+12]
        STRB     R0,[R4, #+4]
        MOV      R0,R10
        BL       OSTimeDly
        MOV      R0,R8
        BL       USART1Printf
??DnrSmsTask_1:
        MOVS     R1,#+12
        LDR.N    R0,??DnrSmsTask_0+0x10  ;; Ser4Ptr
        LDR      R0,[R0, #+0]
        BL       BcMdemInit
        CMP      R0,#+1
        BLT.N    ??DnrSmsTask_2
//  172 		else
//  173 		{
//  174 			InitCnt = 0;
//  175 			//DnrSts->ETC_ALM1.Bit.ModemLinkFail = Normal;
//  176 		}	
//  177 		USART1Printf("1: PW Reset \n");
        ADD      R0,R8,#+12
        BL       USART1Printf
//  178 //		ModemEsnCheck();
//  179 	
//  180 		TimerRegist(TimerSmsTx, Time1Sec*10L);
        MOVW     R1,#+10000
        MOVS     R0,#+18
        BL       TimerRegist
//  181 		TimerRegist(TimerSmsTxControl, Time1Sec*1L);
        MOV      R1,#+1000
        MOVS     R0,#+19
        BL       TimerRegist
        B.N      ??DnrSmsTask_7
//  182 			
//  183 		while(1)
//  184 		{
//  185 			
//  186 			if(!tTestFlag)
//  187 			{
//  188 				if(!DownLoadGiveupTimerSet(NULL))
//  189 				{
//  190 					BcMdemDebug(iSMS_Debug_Mode, (INT32S *)SerPtr);
//  191 								
//  192 //					AutoResetCheck();
//  193 				
//  194 					if(SmsTxFailFlag)
//  195 					{
//  196 						if(SmsResetPeriodFlag)
//  197 						{
//  198 							//LEW SmsDataAckTx(Dnr_ID,Dnr_ID, (INT8U *)SmsDnrSts, sizeof(_SmsDnrStatus)-2, StatusQue,SmsSer);
//  199 //							SmsDataAckTx(Rmt_ID,Dnr_ID, (INT8U *)SmsDnrSts, sizeof(_SmsDnrStatus)-2, StatusQue,SmsSer);
//  200 
//  201 							SmsTxFailFlag = FALSE;
//  202 						}	
//  203 					}
//  204 					
//  205 					if(TcpDnLoadFlag)goto SWRST_START;
//  206 												
//  207 //LEW				if(DnrSts->Rx0AgsOnOff == __AscOff)
//  208 					{
//  209 						s = CdmaFuncselect();
??DnrSmsTask_8:
        BL       CdmaFuncselect
        SXTB     R6,R0
//  210 
//  211 						USART1Printf("BcMRtryNo : [%d],s : [%d]\n",BcMRtryNo,s);
        MOV      R2,R6
        LDRB     R1,[R9, #+0]
        ADD      R0,R8,#+28
        BL       USART1Printf
//  212 
//  213 						//StsConFlag = 0x02;
//  214 						//LEWD if(iSMS_Debug_Mode) USART1Printf("BcMRtryNo : [%d],s : [%d]\n",BcMRtryNo,s);
//  215 
//  216 						switch(s)
        CMP      R6,#+3
        BEQ.N    ??DnrSmsTask_9
        MVN      R0,#+1
        CMP      R6,R0
        BEQ.N    ??DnrSmsTask_10
        B.N      ??DnrSmsTask_11
//  217 						{
//  218 					
//  219 							case SELF_RECV:
//  220 								if( (sms_len = BcMdemRecv(sms_buff, sentTel, &sms_time)) > 0)
??DnrSmsTask_9:
        ADD      R2,R4,#+292
        ADD      R1,R4,#+276
        ADD      R0,R4,#+20
        BL       BcMdemRecv
        STR      R0,[R4, #+16]
//  221 								{
//  222 									if(0)
//  223 									{
//  224 										USART1PutStr(sms_buff, sms_len, ENABLE);
//  225 										USART1Printf("\n");
//  226 										USART1Printf("SendTel: %s \n", sentTel);
//  227 										USART1Printf("sms_len: %d \n", sms_len);
//  228 									
//  229 										USART1Printf("Arrive Time: %s %s %s %s %s %s %s\n",
//  230 									
//  231 										sms_time.Year,
//  232 										sms_time.Month,
//  233 										sms_time.Day,
//  234 										sms_time.Hour,
//  235 										sms_time.Min,
//  236 										sms_time.Sec,
//  237 										sms_time.Week);
//  238 									}
//  239 #if 0
//  240 									if(Sms1_Protocol_Check(nPtr)) //Ser0ComCheck();
//  241 									{			
//  242 										SmsComCheck (nPtr);
//  243 										
//  244 										if(TcpDnLoadFlag)goto TCP_DNLOAD;
//  245 									}
//  246 #endif								
//  247 								}
//  248 
//  249 								if(PcFreqStsRqstFlag)
        LDRB     R0,[R4, #+8]
        CBZ      R0,??DnrSmsTask_12
//  250 								{
//  251 //									SpecFreqState_RspFunc(Dnr_ID,Dnr_ID,RadioAutoReport,2,NormalMode,nPtr);
//  252 
//  253 									PcFreqStsRqstFlag = FALSE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+8]
//  254 								}	
//  255 
//  256 							///////// SEND ///////////
//  257 							if(BcMRtryNo < MaxTryNo)
??DnrSmsTask_12:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+3
        BCS.N    ??DnrSmsTask_11
//  258 							{
//  259 								OSTimeDly(1000L);
        MOV      R0,#+1000
        BL       OSTimeDly
//  260 								
//  261 								if(!FirstFlag)
        LDRB     R0,[R4, #+3]
        CBNZ     R0,??DnrSmsTask_13
//  262 								{	
//  263 									INT8U i= 0;
//  264 									i= i;
//  265 //									WhatTime();
//  266 
//  267 //									for(i = 0; i < 11; i++)SmsInfo->SmsCtrl.MinNumber[i] = BcMSrcTel[i];
//  268 //									for(i = 0; i < 8;  i++)SmsInfo->SmsCtrl.EsnNumber[i] = BcMEsnNum[i];
//  269 
//  270 									//Sts->Modem_SW_Verion[0] 		= atoh(UcMVerNum[0]);
//  271 									//Sts->Modem_SW_Verion[1] 		= atoh(UcMVerNum[1])*0x10 + atoh(UcMVerNum[2]);
//  272 
//  273 									
//  274 //									ResetAlarmRptFunc(Dnr_ID, nPtr); // ID Modify
//  275 
//  276 									if (BootAlarmFlag)
        LDRB     R0,[R4, #+2]
        CBZ      R0,??DnrSmsTask_14
//  277 									{
//  278 //										BootAlarmRptFunc(Dnr_ID, nPtr); 
//  279 										BootAlarmFlag = FALSE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+2]
//  280 									}
//  281 									
//  282 									//SpecFreqState_RspFunc(NULL, 0xFF, RadioAutoReport,2,NormalMode,nPtr);	// ID Modify
//  283 
//  284 									FirstFlag = 1;
??DnrSmsTask_14:
        MOVS     R0,#+1
        STRB     R0,[R4, #+3]
//  285 								}
//  286 
//  287 #if 0 	//LEW	 							
//  288 								if(RmtBootReportCheckFlag)
//  289 								{
//  290 									BootAlarmRptFunc(Rmt_ID, nPtr); // ID Modify
//  291 									RmtBootReportCheckFlag = RESET;
//  292 								}
//  293 #endif														
//  294 //								SmsAlarm();
//  295 
//  296 								ModemTimeRqstCnt++;
??DnrSmsTask_13:
        LDRB     R0,[R4, #+7]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+7]
//  297 								if(ModemTimeRqstCnt > 2)
        UXTB     R0,R0
        CMP      R0,#+3
        BCC.N    ??DnrSmsTask_11
//  298 								{
//  299 //									SmsAutoReportCheck(nPtr);
//  300 									ModemTimeRqstCnt = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+7]
//  301 								}	
//  302 							}
//  303 							
//  304 							break;
//  305 				
//  306 							case MAX_TRY:
//  307 								//LEWD if(iSMS_Debug_Mode)	USART1Printf("MAX_TRY \n");
//  308 								// reset routine!!
//  309 
//  310 								if(SmsResetPeriodFlag)
//  311 								{	
//  312 									 SmsTxFailFlag = TRUE;
//  313 //									 ResetPeriodSet();
//  314 
//  315 									 goto PWRST_START;
//  316 								}
//  317 												
//  318 								//goto PWRST_START;
//  319 				
//  320 							default:					
//  321 							break;
//  322 						}
//  323 					}	
//  324 				OSTimeDly(1000L);
??DnrSmsTask_11:
        MOV      R0,#+1000
??DnrSmsTask_15:
        BL       OSTimeDly
??DnrSmsTask_7:
        LDRB     R0,[R7, #+0]
        CBNZ     R0,??DnrSmsTask_16
        BL       DownLoadGiveupTimerSet
        CBNZ     R0,??DnrSmsTask_16
        LDR      R1,[R11, #+0]
        LDRB     R0,[R4, #+1]
        BL       BcMdemDebug
        LDRB     R0,[R4, #+6]
        CBZ      R0,??DnrSmsTask_17
        LDRB     R0,[R4, #+5]
        CBZ      R0,??DnrSmsTask_17
        MOVS     R0,#+0
        STRB     R0,[R4, #+6]
??DnrSmsTask_17:
        LDRB     R0,[R4, #+4]
        CMP      R0,#+0
        BEQ.N    ??DnrSmsTask_8
        BL       BcMdemTcpExit
        MOVS     R0,#+1
        STRB     R0,[R4, #+5]
        B.N      ??DnrSmsTask_6
??DnrSmsTask_10:
        LDRB     R0,[R4, #+5]
        CMP      R0,#+0
        BEQ.N    ??DnrSmsTask_11
        MOVS     R0,#+1
        B.N      ??DnrSmsTask_5
//  325 			}
//  326 			else 
//  327 			{
//  328 #if 0              
//  329 				if(BcMdemTCPRxCheck(tcp_buff))
//  330 				{	
//  331 TCP_DNLOAD:					
//  332 					OSTimeDly(50);
//  333 					
//  334 					if(TCPProtocolCheck(nPtr)) TCPComCheck(nPtr);
//  335                    
//  336 				}
//  337 #endif
//  338 				OSTimeDly(500);
??DnrSmsTask_16:
        MOV      R0,#+500
        B.N      ??DnrSmsTask_15
        DATA
??DnrSmsTask_0:
        DC32     0x4001180c
        DC32     SerPtr
        DC32     tTestFlag
        DC32     `?<Constant "PW Reset \\n">`
        DC32     Ser4Ptr
//  339 			}
//  340 		}	
//  341 	else OSTimeDly(500);	
//  342 	}
//  343 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     PeriodStart

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     BcMRtryNo

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Ver0.4:Dnr Center TES...">`:
        DATA
        DC8 "Ver0.4:Dnr Center TEST     "

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Ver0.5:Rmt Center TES...">`:
        DATA
        DC8 "Ver0.5:Rmt Center TEST     "

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "PW Reset \\n">`:
        DATA
        DC8 "PW Reset \012"
        DC8 0
        DC8 "1: PW Reset \012"
        DC8 0, 0
        DC8 "BcMRtryNo : [%d],s : [%d]\012"
        DC8 0

        END
//  344 
//  345 
//  346 #endif
//  347 
//  348 #if 0
//  349 INT8U sms_buff[256];
//  350 INT8U sentTel[TelNo];
//  351 INT32S sms_len;
//  352 BcMTimeStr sms_time;
//  353 BcMRfStsStr Rf_sts;
//  354 BcMPilotStsStr Pilot_Sts;
//  355 INT32S tcp_port;
//  356 INT32S tcp_len;
//  357 
//  358 INT8U SerialOnFlag = TRUE;
//  359 
//  360 
//  361 
//  362 void DnrSmsTask(void * pdata)
//  363 {
//  364 	INT32S s = 0;
//  365 	INT16U InitCnt = 0;
//  366 	INT16U nRet = 0;
//  367 
//  368 	(void)pdata;
//  369     s = s;
//  370 	__ProtocolPtr *nPtr = SmsSer;
//  371 
//  372 	BcMdemDebug(TRUE, (INT32S *)NULL);
//  373 
//  374 	SWRST_START:
//  375 		SerPtr->printf("\n\nSTART SMS TASK\n\n");
//  376 		
//  377 		SMS_PWR = 0;
//  378 		
//  379 		OSTimeDly(5000L);
//  380 
//  381 //		ModemEsnCheck();
//  382 //		if( (nRet = BcMdemInit(ModemALL)) == 0)
//  383 		if( (nRet = BcMdemInit(VersionCmd)) == 0)
//  384 
//  385 		{
//  386 			if(++InitCnt > MaxTryNo) goto SWRST_START;
//  387 			TimerRegist(TimerSMSRx, 1000*2L);
//  388 			goto RETRY_START;
//  389 		}
//  390 		
//  391 		nRet = nRet;
//  392 	RETRY_START:
//  393 		
//  394 #if 0
//  395 	SMS_PWR = 0;
//  396 	// SMS PWR ON
//  397 	BcMdemDebug(TRUE, (INT32S *)NULL);
//  398 //	BcMdemDebug(FALSE, (INT32S *)NULL);
//  399 	BcMdemPtrInit(&pUSART4, TimerSMSRx);
//  400 	SerPtr->printf("DnrSmsTask %s %s\n", __DATE__, __TIME__);
//  401 
//  402 //	pPrintf("DnrSmsTask %s %s\n", __DATE__, __TIME__);
//  403 	OSTimeDly(100L*10L);
//  404 
//  405 SWRST_START:
//  406 	InitCnt = 0;
//  407 //	if(!SerialOnFlag) pPrintf("\r\n 1.SMS SW RST START \r\n");
//  408 	SerPtr->printf("\r\n 1.SMS SW RST START \r\n");
//  409 
//  410 //	if(BcMdemSwReset() == TRUE) ;//goto RETRY_START;
//  411 //	NVIC_Init(UART4_IRQChannel, DISABLE); 
//  412 	if(!SerialOnFlag) pPrintf("\r\n 2.SMS SW RST FAIL -->HW RST START\r\n");//iCdmaResetCase);
//  413 	SerPtr->printf("\r\n 2.SMS SW RST FAIL -->HW RST START\r\n");
//  414 
//  415 	SMS_PWR = 1;
//  416 	OSTimeDly(5000L);
//  417 	SMS_PWR = 0;
//  418 	OSTimeDly(500L);
//  419 //	NVIC_Init(UART4_IRQChannel, ENABLE); 
//  420 	pPrintf("\r\n 3.SMS HW(PWR] RST END\r\n");
//  421 
//  422 	SerPtr->printf("\r\n 3.SMS HW(PWR] RST END\r\n");
//  423 
//  424     InitCnt = InitCnt;
//  425 RETRY_START:
//  426 
//  427 	if( (nRet = BcMdemInit(ModemALL)) == 0)
//  428 	{
//  429 		if(++InitCnt > MaxTryNo) goto SWRST_START;
//  430 		TimerRegist(TimerSMSRx, 1000*2L);
//  431 		goto RETRY_START;
//  432 	}
//  433 	else InitCnt = 0;
//  434 
//  435  	OSTimeDly(1000*10L);
//  436 	if(!SerialOnFlag) pPrintf("BcMdemTcpExit = ");
//  437 	
//  438 	SerPtr->printf("BcMdemTcpExit = ");
//  439 	nRet = BcMdemTcpExit();
//  440 	if(!SerialOnFlag) pPrintf("%d\r\n", nRet);
//  441 	nRet = nRet;
//  442 
//  443 	ModemEsnCheck();
//  444 	
//  445 	TimerRegist(TimerSMSTx, Time1Sec*20L);
//  446 
//  447  	if( iSMS_Debug_Mode == 0)	TimerRegist(TimerSMSRst, Time1Min*5L);
//  448 	else						TimerRegist(TimerSMSRst, Time1Day*1L); 
//  449 	
//  450 	if(!SerialOnFlag)  pPrintf("\n\nSTART SMS TASK\n\n");
//  451 	SerPtr->printf("\n\nSTART SMS TASK\n\n");
//  452 
//  453 	HostStation_Init();
//  454  	DecSmsSendCnt();
//  455 #endif
//  456 	while(1)
//  457 	{
//  458 		while(!DownLoadGiveupTimerSet(NULL))
//  459 		{
//  460 			s = BcMdemFuncselect();
//  461 			SerPtr->printf("\n\r  s[%d] \n\n",s);
//  462 
//  463 			switch(s)
//  464 			{
//  465 				case SELF_SEND:
//  466 					// if you want send ... please insert this area..
//  467 					if(!CdmaFirstFlag)
//  468 					{	
//  469 						WhatTime();
//  470 						if(chkHostStation == Install)
//  471 						{
//  472 							BootAlarmRptFunc(nPtr);
//  473 						}
//  474 						CdmaFirstFlag = 1;
//  475 						break;
//  476 					}
//  477 					if(chkHostStation == Install)
//  478 					{
//  479 						SmsAutoReportCheck(nPtr);
//  480 						SmsAlarm();
//  481  					}
//  482 
//  483 					if(IsItSmsSend())
//  484 					{
//  485 #if 0
//  486 						__WRCSSIO *rauSend = SmsSer->WRCSSend;
//  487 						__BODYFRAME *rauBody = &rauSend->BodyFrame[1];
//  488 
//  489 						GenFrameOneDataTx(0xff, rauBody->SubID[1], rauBody->SubID[2], rauBody->SubData, rauBody->SubLength, rauBody->Command,SmsSer, NULL);
//  490 						DecSmsSendCnt();
//  491 #endif						
//  492 					}
//  493 					
//  494 					// if you want send ... please insert this area..
//  495 					//WhatTime();
//  496 
//  497 					{
//  498 						//if ((Rx0AgsStep == EightStep)&&(chkRvsAGS == RESET) && (chkSmsRvsAGS == SET))
//  499 						//{
//  500 						//	OSTimeDly(1000*5L);
//  501 						//	SmsDataAckTx(iRx0_TagetID,Dnr_ID, (INT8U *)DnrSmsSts[iRx0_TagetID], sizeof(DnrSMS_SFW15Str)-2, ControlQue,nPtr);
//  502 						//	Rx0AgsStep = 0;
//  503 						//	chkSmsRvsAGS =0;
//  504 						//}
//  505 						
//  506 						//if ((Rx1AgsStep == EightStep)&&(chkRvsAGS == RESET)&& (chkSmsRvsAGS == SET))
//  507 						//{
//  508 						//	OSTimeDly(1000*5L);
//  509 						//	SmsDataAckTx(iRx1_TagetID,Dnr_ID, (INT8U *)DnrSmsSts[iRx1_TagetID], sizeof(DnrSMS_SFW15Str)-2, ControlQue,nPtr);
//  510 						//	Rx1AgsStep = 0;
//  511 						//	chkSmsRvsAGS =0;						
//  512 						//}
//  513 					}
//  514 
//  515 					if(iSmsFalseCnt >= 9)	goto SWRST_START;	
//  516 						
//  517 					if(TimeOverCheck(TimerSMSRst))
//  518 					{
//  519 						if((iAutoReportPriod == 0x7f)||(chkHostStation == Uninstall))
//  520 						{
//  521 							iSmsFalseCnt = 15;
//  522 							goto SWRST_START;
//  523 						}
//  524 					}
//  525 				break;
//  526 				
//  527 				case SELF_TIME:
//  528 				break;
//  529 		
//  530 				case SELF_RECV:
//  531 					if((sms_len = BcMdemRecv(sms_buff, sentTel, &sms_time)) > 0)
//  532 					{
//  533 						//if(iDebug_Mode)
//  534 						#if 0
//  535 						{
//  536 							SerPtr->PutStr(sms_buff, sms_len, TRUE);
//  537 							SerPtr->printf("\n");
//  538 							SerPtr->printf("SendTel: %s \n", sentTel);
//  539 							SerPtr->printf("sms_len: %d \n", sms_len);
//  540 						
//  541 							SerPtr->printf("Arrive Time: %s %s %s %s %s %s %s\n",
//  542 						
//  543 							sms_time.Year,
//  544 							sms_time.Month,
//  545 							sms_time.Day,
//  546 							sms_time.Hour,
//  547 							sms_time.Min,
//  548 							sms_time.Sec,
//  549 							sms_time.Week);
//  550 						}
//  551 						#endif
//  552 						if(SmsProtocolCheck(nPtr))
//  553 						{			
//  554 							SmsComCheck(nPtr);
//  555 						}
//  556 					
//  557 					}	
//  558 				break;
//  559 
//  560 				case MAX_TRY:
//  561 					goto SWRST_START;
//  562 				default:					
//  563 				break;
//  564 			}
//  565 			OSTimeDly(1000L);
//  566 		}
//  567 		while(DownLoadGiveupTimerSet(NULL))
//  568 		{
//  569 			INT16U i = 0;
//  570 
//  571 			tcp_len = BcMdemTCPRxCheck(tcp_buff);
//  572 
//  573 			if(iDebug_Mode) USART1Printf("TCP RCV DATA0  [%d][%d]\n",tcp_len);
//  574 
//  575 			if(tcp_len > 0)
//  576 			{
//  577 				if(iDebug_Mode)
//  578 				{
//  579 					USART1Printf("TCP RCV DATA [%d]\n",tcp_len);
//  580 
//  581 					for(i = 0; i < tcp_len; i++)
//  582 					{
//  583 						 USART1Printf("[%02x]",tcp_buff[i]);
//  584 					}
//  585 					 USART1Printf("\n");
//  586 				}
//  587 				if(TCPProtocolCheck(SmsSer)) TCPComCheck(SmsSer);
//  588 				DownLoadGiveupTimerSet(Ser2DownLoading);
//  589 				OSTimeDly(10);
//  590 			}
//  591 			OSTimeDly(100L);
//  592 		}
//  593 		OSTimeDly(500L);	
//  594 		while(tTestFlag) OSTimeDly(1000L);
//  595 	}
//  596 
//  597 }
//  598 
//  599 
//  600 void DecSmsSendCnt(void)
//  601 {
//  602 	SmsTx = 0;
//  603 }
//  604 
//  605 void IncSmsSendCnt(void)
//  606 {
//  607 	SmsTx++;
//  608 }
//  609 
//  610 INT8U IsItSmsSend(void)
//  611 {
//  612 	return SmsTx;
//  613 }
//  614 
//  615 
//  616 void WhatTime(void)
//  617 {
//  618 	BcdemTimeGet(&sms_time);
//  619 	{
//  620 		PresentHour = TwoAsciDeciNum2OneHex(sms_time.Hour[0],sms_time.Hour[1]);
//  621 		PresentMin  = TwoAsciDeciNum2OneHex(sms_time.Min[0],sms_time.Min[1]);
//  622 
//  623 		WaveSts->PresentHour = PresentHour;
//  624 		WaveSts->PresentMin = PresentMin;
//  625 	}
//  626 }
//  627 
//  628 void BootAlarmRptFunc(__ProtocolPtr *nPtr)
//  629 {
//  630     INT8U CHKSUM = 0, DataCnt = 0, i = 0;
//  631 
//  632 	__BODYFRAME  *Send = &SMSSend;
//  633 
//  634 	// Frame Header //
//  635 	Send->SubID[0]		= 0x00;
//  636 	Send->SubID[1]		= 0xff;
//  637 	Send->SubID[2]		= 0xff;
//  638 	Send->RCode			= __DUO_LIF;
//  639 	Send->Command		= AlarmSCODE;
//  640 
//  641 	Send->SubData[DataCnt++] = hibyte(Aid_Boot_Alarm); 		// A_ID
//  642 	Send->SubData[DataCnt++] = lobyte(Aid_Boot_Alarm);
//  643 	Send->SubData[DataCnt++] = 0x01;						// 발생
//  644 	Send->SubData[DataCnt++] = 0x00;						// Lenght
//  645 
//  646 	Send->SubLen[0]	= 0;
//  647 	Send->SubLen[1]	= DataCnt;
//  648 		
//  649 	// Frame CHKSUM //
//  650 	for(i = 0; i < (DataCnt + 7); i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
//  651 	
//  652 	Send->SubData[DataCnt++] = DataConv(HIGH, CHKSUM);
//  653 	Send->SubData[DataCnt++] = DataConv(LOW, CHKSUM);
//  654 	Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);
//  655 	
//  656 	Sms_DataAckTx(nPtr);
//  657 }
//  658 
//  659 void Sms_DataAckTx(__ProtocolPtr *nPtr)
//  660 {
//  661 	INT8U i = 0;
//  662 	INT32S ret = 0;
//  663 
//  664 	__BODYFRAME  *Send = &SMSSend;
//  665 
//  666 	if(Send->Command == DnrSwHistorySCODE)
//  667 	{
//  668 		for ( i=0; i< (7 + 2); i++ )
//  669 		{
//  670 			*((INT8U *)Send->SubID + i) = *((INT8U *)Send->SubID + i) | 0x80;
//  671 		}
//  672 	}
//  673 	else
//  674 	{
//  675 		for(i = 0; i < Send->SubLength + 7 + 2; i++ )
//  676 		{
//  677 			*((INT8U *)Send->SubID + i) = *((INT8U *)Send->SubID + i) | 0x80;
//  678 		}
//  679 	}
//  680 
//  681 	HostStation_Init();
//  682 	
//  683 	
//  684 
//  685 	for(i = 0;i < 2; i++)
//  686 	{
//  687 		if( (ret = BcMdemMSGTx((char *)HostStation, (char *)Send, (Send->SubLength + 7 + 2) )) > 2)
//  688 		{
//  689 			iSmsFalseCnt = 0;
//  690 //			if(!SerialOnFlag) USART1Printf("Tx True: nRet: %d,iSmsFalseCnt :%d\n", ret,iSmsFalseCnt);
//  691 //			USART1Printf("Tx True: nRet: %d,iSmsFalseCnt :%d\n", ret,iSmsFalseCnt);
//  692 
//  693 			SmsInfo->SMS_TxD[0]	= Send->SubID[0]&= 0x7f;
//  694 			SmsInfo->SMS_TxD[1]	= Send->SubID[1]&= 0x7f;
//  695 			SmsInfo->SMS_TxD[2]	= Send->Command&= 0x7f;
//  696 			SmsInfo->SMS_TxD[3]	= PresentHour;
//  697 			SmsInfo->SMS_TxD[4]	= PresentMin;
//  698 			break;
//  699 		}
//  700 		else
//  701 		{
//  702 			iSmsFalseCnt++;
//  703 			if(!SerialOnFlag) USART1Printf("Tx FALSE: nRet: %d,iSmsFalseCnt :%d\n",ret,iSmsFalseCnt);			
//  704 		}
//  705 		OSTimeDly(1000*20L);
//  706 	}
//  707 	OSTimeDly(1000*5L);
//  708 }
//  709 
//  710 void SmsDataAckTx(INT8U* tid,INT8U *Data,INT16U nCnt,INT8U Comm,__ProtocolPtr *nPtr)
//  711 {
//  712 	INT16U i;
//  713 	INT8U CHKSUM = 0;
//  714 	__BODYFRAME  *Send = &SMSSend;
//  715 	
//  716 	Send->SubID[0] = tid[0];
//  717 	Send->SubID[1] = tid[1];
//  718 	Send->SubID[2] = tid[2];
//  719 
//  720 	Send->Command = Comm;
//  721 	Send->RCode = __DUO_LIF;
//  722 	Send->SubLength = nCnt;
//  723 
//  724 	Send->SubLen[0]	= (INT8U)(Send->SubLength >> 8);
//  725 	Send->SubLen[1]	= (INT8U)(Send->SubLength >> 0);
//  726 
//  727 	for(i = 0; i < nCnt && i < SMS_BODYSIZEMAX; i++)
//  728 	{
//  729 		Send->SubData[i] =  Data[i];
//  730 	}
//  731 
//  732 	for(i = 0; i < nCnt+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
//  733 		
//  734 	Send->SubData[nCnt++] = DataConv(HIGH, CHKSUM);
//  735 	Send->SubData[nCnt++] = DataConv(LOW, CHKSUM);
//  736 	Sms_DataAckTx(nPtr);
//  737 }
//  738 
//  739 INT32U SmsProtocolCheck(__ProtocolPtr *nPtr)
//  740 {
//  741 	INT8U CHKSUM = 0;
//  742 	INT16U i = 0;
//  743 	INT16U DataCnt = 0;
//  744 
//  745 	__BODYFRAME *Recv = &SMSRecv;
//  746 	
//  747     INT8U tid[3] = {Recv->SubID[0], Recv->SubID[1], Recv->SubID[2]};
//  748 
//  749 	{
//  750 		if( (Recv->SubID[0] = sms_buff[DataCnt++]) != 0xff) Recv->SubID[0] &= 0x7f;
//  751 		if( (Recv->SubID[1] = sms_buff[DataCnt++]) != 0xff) Recv->SubID[1] &= 0x7f;
//  752 		if( (Recv->SubID[2] = sms_buff[DataCnt++]) != 0xff) Recv->SubID[2] &= 0x7f;
//  753 
//  754 		Recv->Command = sms_buff[DataCnt++] & 0x7f;
//  755 		Recv->RCode = sms_buff[DataCnt++] & 0x7f;
//  756 		Recv->SubLen[0] = sms_buff[DataCnt++] & 0x7f;
//  757 		Recv->SubLen[1] = sms_buff[DataCnt++]& 0x7f;
//  758 		Recv->SubLength = (Recv->SubLen[0] << 8) | (Recv->SubLen[1]);
//  759 	}
//  760 
//  761     {
//  762 		INT8U *dptr = (INT8U *)Recv->SubData;
//  763 
//  764 		for(i = 0; i < (Recv->SubLength + 2); i++) *dptr++ = sms_buff[DataCnt++] & 0x7f;
//  765 
//  766 		// Frame CHKSUM //
//  767 		for(i = 0; i < Recv->SubLen[1] + 7; i++) CHKSUM = CHKSUM + *((INT8U *)Recv->SubID+ i);
//  768 
//  769 		Recv->CrcOK = TRUE;
//  770 	
//  771 		if(Recv->SubData[Recv->SubLen[1]] != DataConv(HIGH, CHKSUM))
//  772 		{
//  773 			ErrRspFunc(tid, CrcErr,nPtr);
//  774 			Recv->CrcOK = FALSE;
//  775 			return FALSE;
//  776 		}
//  777 		if(Recv->SubData[Recv->SubLen[1] + 1] != DataConv(LOW, CHKSUM))
//  778 		{
//  779 			ErrRspFunc(tid, CrcErr,nPtr);
//  780 			Recv->CrcOK = FALSE;
//  781 			return FALSE;
//  782 		}
//  783 	}
//  784 	return 2;
//  785 }
//  786 
//  787 void SmsComCheck(__ProtocolPtr *nPtr)
//  788 {
//  789 	INT16U tcnt = 0;
//  790 	INT8U Comm;
//  791 
//  792 	__BODYFRAME *Recv = &SMSRecv;
//  793 	__BODYFRAME *Send = &SMSSend;
//  794 
//  795 	Send->SubID[0] = Recv->SubID[0];
//  796 
//  797     INT8U tid[3] = {Recv->SubID[0], Recv->SubID[1], Recv->SubID[2]};
//  798 
//  799  	Comm = WhatRxSms(Recv);
//  800 	{
//  801 		SmsInfo->SMS_RxD[0]	= Recv->SubID[0];
//  802 		SmsInfo->SMS_RxD[1]	= Recv->SubID[1];
//  803 		SmsInfo->SMS_RxD[2]	= Recv->Command;
//  804 		SmsInfo->SMS_RxD[3]	= PresentHour;
//  805 		SmsInfo->SMS_RxD[4]	= PresentMin;
//  806 	}
//  807 	//if(!SerialOnFlag)
//  808 	//USART1Printf("ID[%x][%x][%x],Comm[%d]RCode[%d]\n",id0,id1,id2 ,Comm,Recv->RCode);
//  809 	pPrintf("ID[%x][%x][%x],Comm[%d]RCode[%d]\n",tid[0],tid[1],tid[2] ,Comm,Recv->RCode);
//  810 	switch(Comm)	//command 체크
//  811 	{
//  812 		case StatusQue:	
//  813 			{
//  814 				tcnt = GenSmsDnrAidSts((INT8U *)Send->SubData,tDnrSts);
//  815 				SmsDataAckTx(tid,(INT8U *)Send->SubData,tcnt,Comm,nPtr);
//  816 			}
//  817 		break;
//  818 		
//  819 		case ControlQue:
//  820 			Ser2_Response_Control(tid, Comm, SmsSer);
//  821 		break;
//  822 		
//  823 		case AlarmMaskSetSCODE:
//  824 			AlarmMask = Recv->SubData[0];
//  825 			//WriteEEprom(AlarmMaskBp, AlarmMask);
//  826 			SmsDataAckTx(tid,(INT8U *)Send->SubData, 1, Comm,nPtr);
//  827 		break;
//  828 
//  829 		case SpecFreqStateSCODE:
//  830 			SpecFreqState_RspFunc(tid,Comm,0x01,NormalMode,nPtr);	
//  831 		break;
//  832 		
//  833 		case DnrSwHistorySCODE:
//  834 			SwHistroyRspFunc(tid,Comm,SmsSer);
//  835 		break;
//  836 		
//  837 		case RadioSetRQST:
//  838 			Wave_Response_Control(tid,TRUE,nPtr);
//  839 			tcnt = GenWaveCtrlAidSts((INT8U *)Send->SubData,WaveCtrl);
//  840 			SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,nPtr);
//  841 		break;
//  842 		
//  843 		case FreqConfigValSCODE :
//  844 			tcnt = GenWaveCtrlAidSts((INT8U *)Send->SubData,WaveCtrl);
//  845 			SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,nPtr);
//  846 		break;
//  847 		
//  848 		case DnrIpAddressSCODE:
//  849 			DnrIpAddressAck(tid, Comm, SmsSer);
//  850 			DnrPacketReadyFunc(SmsSer);
//  851 		break;
//  852 
//  853 		default:
//  854 		break;
//  855 	}
//  856 }
//  857 
//  858 
//  859 INT8U WhatRxSms(__BODYFRAME *Recv)
//  860 {
//  861 	INT16U RetVal = 0;
//  862 
//  863 	//SIO´ BODY is ONLY ONE(1)
//  864 	if(Recv->CrcOK)	// CRC OK
//  865 	{
//  866 		RetVal = Recv->Command;
//  867 	}
//  868 	else //NO ERROR
//  869 	{
//  870 		//ERROR CASE
//  871 		RetVal = crcERROR;
//  872 	}
//  873     return (RetVal);	
//  874 }
//  875 
//  876 void Ser2_Response_Control(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr)
//  877 {
//  878 	INT8U  Len = 0,   Length = 0;
//  879 	INT16U  AID_Command;
//  880 	INT8U  A_ID[2];
//  881 	INT8U i=0;
//  882 	INT8U AID_Value[40];
//  883 	INT8U tcnt;
//  884 	
//  885 	__BODYFRAME *Recv = &SMSRecv;
//  886 	__BODYFRAME *Send = &SMSSend;
//  887 
//  888 	while(Recv->SubLen[1] >  Len)
//  889 	{
//  890 		A_ID[0] = (INT8U)(Recv->SubData[Len++]);
//  891 		A_ID[1] = (INT8U)(Recv->SubData[Len++]);
//  892 		AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
//  893 		Length = Recv->SubData[Len++];
//  894 
//  895 		for (i = 0 ; i < Length && i < 40; i++) AID_Value[i] = (INT8U)(Recv->SubData[Len++]);
//  896 
//  897 		if(AID_Command == Aid_EsnChecksum)
//  898 		{
//  899 			if((EsnChecksumH !=AID_Value[0]) ||(EsnChecksumL !=AID_Value[1]))
//  900 		   {
//  901 				ErrRspFunc(tid,EsnMismatch,nPtr);
//  902 				iMobileESN=NACK;
//  903 				return;
//  904 		   }
//  905 		}
//  906 
//  907  		CtrlData(AID_Command, AID_Value, Length, TRUE,nPtr);
//  908 
//  909 		if(Len >= Recv->SubLen[1])break;
//  910 	}			
//  911 	
//  912 
//  913 	OSTimeDly(1000*3L);
//  914 	if(Recv->Command == ControlQue)
//  915 	{
//  916 		tcnt = GenSmsDnrAidSts((INT8U *)Send->SubData,tDnrSts);
//  917 		SmsDataAckTx(tid,(INT8U *)Send->SubData,tcnt,Comm,nPtr);
//  918 	}
//  919 	else SmsDataAckTx(tid, (INT8U *)WaveCtrl, sizeof(_WaveCtrl), Comm,nPtr);
//  920 }
//  921 
//  922 void SwHistroyRspFunc (INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr)
//  923 {
//  924     INT8U	CHKSUM=0, DataCnt=0, i,j;
//  925 
//  926 
//  927 	__BODYFRAME *Send = &SMSSend;
//  928 
//  929 	// Frame Header //
//  930 
//  931 	Send ->SubID[0]		= tid[0];
//  932 	Send ->SubID[1]		= tid[1];
//  933 	Send ->SubID[2]		= tid[2];	
//  934 	Send->Command		= Comm;
//  935 	Send->RCode			= __DUO_LIF;
//  936 	
//  937 	Send->SubLen[0]		= 0;
//  938 	Send->SubLen[1]		= LineLengh+1+1; // more + line lenght + line data
//  939 	
//  940 	for(j = 0; j < VersionNum; j++)
//  941 	{
//  942 		DataCnt = 0, CHKSUM = 0;
//  943 		
//  944 		if(j == VersionNum - 1)	Send->SubData[DataCnt++] = 0x00;		// more 추가 정보
//  945 		else					Send->SubData[DataCnt++] = 0x01;		// more 추가 정보
//  946 		
//  947 		Send->SubData[DataCnt++] = LineLengh;	// LineLengh
//  948 		for(i = 0; i < LineLengh; i++)
//  949 		{
//  950 		   Send->SubData[DataCnt++] = *(DnrVerString+ (i +(j*LineLengh)));	// LineLengh
//  951 	    }
//  952 	    /*********************/		
//  953 		// Frame CHKSUM //
//  954 		for(i = 0; i < DataCnt+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
//  955 
//  956 		Send->SubData[DataCnt++] = DataConv(HIGH,CHKSUM);
//  957 		Send->SubData[DataCnt++] = DataConv(LOW,CHKSUM);
//  958 		Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1]	)& 0x00ff);
//  959 
//  960 		Sms_DataAckTx(nPtr);
//  961 	}
//  962 }
//  963 
//  964 
//  965 void ErrRspFunc(INT8U* tid,INT8U Code,__ProtocolPtr *nPtr )
//  966 {
//  967 	INT8U CHKSUM = 0, Count = 0, i;
//  968 	__BODYFRAME  *Send = &SMSSend;
//  969 
//  970 	// Frame Header //
//  971 	Send ->SubID[0]		= tid[0];
//  972 	Send ->SubID[1]		= tid[1];
//  973 	Send ->SubID[2]		= tid[2];
//  974 	Send ->RCode		= __DUO_LIF;
//  975 	Send ->Command		= 0xFF;
//  976 	Send ->SubData[Count++] = Code;
//  977 	
//  978 	Send ->SubLen[0]	= 0;
//  979 	Send ->SubLen[1]	= Count;
//  980 
//  981 	// Frame CHKSUM //
//  982 	for(i = 0; i < Count+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
//  983 	Send->SubData[Count++] = DataConv(HIGH, CHKSUM);
//  984 	Send->SubData[Count++] = DataConv(LOW, CHKSUM);
//  985 	Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);
//  986 
//  987 	Sms_DataAckTx(nPtr);
//  988 }
//  989 
//  990 void SmsAutoReportCheck(__ProtocolPtr *nPtr)
//  991 {
//  992 	INT16U tcnt;
//  993 	
//  994 	__BODYFRAME *Send = &SMSSend;
//  995 
//  996 	if(TimeOverCheck(TimerSMSTx))
//  997 	{
//  998 		if(AutoRptChk())
//  999 		{
// 1000 			INT8U tid[3] = {0xff, 0xff,0xff};
// 1001 			tcnt = GenSmsDnrAidSts((INT8U *)Send->SubData,tDnrSts);
// 1002 			SmsDataAckTx(tid,(INT8U *)Send->SubData,tcnt,AutoReportSCODE,nPtr);
// 1003 		}
// 1004 
// 1005 		if(WavTwoAutoRptChk()|| (iWave_Measure == SET))
// 1006 		{
// 1007 			INT8U tid[3] = {0, 0xff,0xff};
// 1008 
// 1009 			if ( iWARMode2 == 0x03 ) return;
// 1010 			SpecFreqState_RspFunc(tid,RadioAutoReport,iWARMode2,NormalMode,nPtr);	
// 1011 			iWave_Measure = RESET;
// 1012 		}
// 1013 
// 1014 		if(WavThrAutoRptChk())
// 1015 		{
// 1016 			INT8U tid[3] = {0, 0xff,0xff};
// 1017 			if ( iWARMode3 == 0x03 ) return;
// 1018 			SpecFreqState_RspFunc(tid,IdleStatusReport,iWARMode3,IdleMode,nPtr); 
// 1019 		}
// 1020 		TimerRegist(TimerSMSTx, 1000*5L);
// 1021 	}
// 1022 }
// 1023 
// 1024 BOOL AutoRptChk ( void )
// 1025 {
// 1026 	INT8U 	Temp=0;
// 1027 	long	Period, Present, Base=0;//, Past;
// 1028 	
// 1029 	Temp 	= iAutoReportPriod;
// 1030 	Present = 60*PresentHour + PresentMin;
// 1031 	Base 	= 60*iARTime_H + iARTime_M;
// 1032 
// 1033 	/* Period 기호 -> 분 */
// 1034 	if 		( Temp == 0x01 )	Period = 5;
// 1035 	else if ( Temp == 0x02 )	Period = 10;
// 1036 	else if ( Temp == 0x03 )	Period = 20;
// 1037 	else if ( Temp == 0x04 )	Period = 30;
// 1038 	else if ( Temp == 0x05 )	Period = 1*60;
// 1039 	else if ( Temp == 0x06 )	Period = 2*60;
// 1040 	else if ( Temp == 0x07 )	Period = 4*60;
// 1041 	else if ( Temp == 0x08 )	Period = 6*60;
// 1042 	else if ( Temp == 0x09 )	Period = 12*60;	
// 1043 	else if ( Temp == 0x10 )	Period = 1*24*60;
// 1044 	else if ( Temp == 0x11 )	Period = 2*24*60;	
// 1045 	else if ( Temp == 0x12 )	Period = 3*24*60;
// 1046 	else if ( Temp == 0x13 )	Period = 7*24*60;
// 1047 	else if ( Temp == 0x7f )	return(FALSE);
// 1048 	else return(FALSE);
// 1049 	
// 1050 	if 		( PastMin < WaveSts->PresentMin ) TimeElapse += (WaveSts->PresentMin-PastMin);
// 1051 	else if ( PastMin > WaveSts->PresentMin ) TimeElapse += (60+WaveSts->PresentMin-PastMin);
// 1052 
// 1053 	PastHour = PresentHour;
// 1054 	PastMin  = PresentMin;
// 1055 
// 1056 	/*  제어설정후 기준시각 체크  */
// 1057 	if ( TimeStart )
// 1058 	{
// 1059 		if ( Present >= Base )
// 1060 		{
// 1061 			TimeStart = 0;
// 1062 			TimeElapse = 0;
// 1063 			return(TRUE);
// 1064 		}
// 1065 		return(FALSE);
// 1066 	}
// 1067 
// 1068 	// New Period Check //
// 1069 	if ( PeriodStart )
// 1070 	{
// 1071 		PeriodStart = 0;
// 1072 		if ( Present >= Base )	TimeElapse = (Present-Base)%Period;
// 1073 		else					TimeElapse = (24*60+Present-Base)%Period;
// 1074 		return(FALSE);
// 1075 	}
// 1076 
// 1077 	if ( TimeElapse >= Period )
// 1078 	{
// 1079 		TimeElapse = (TimeElapse%Period);
// 1080 		return(TRUE);
// 1081 	}
// 1082 	return (FALSE);
// 1083 }
// 1084 
// 1085 BOOL WavThrAutoRptChk ( void )
// 1086 {
// 1087 	INT8U 	Temp;
// 1088 	long	Period, Present, Base;//, Past;
// 1089 
// 1090 	Temp   = iWARPriod3;
// 1091 	Present = 60*PresentHour + PresentMin;
// 1092 	Base 	= 60*(((iWARHour )>>4)*10+(iWARHour &0x0f))
// 1093 				+((iWARMinute>>4)*10+(iWARMinute&0x0f));
// 1094 
// 1095 	if 		( Temp == 0x01 )	Period = 5;
// 1096 	else if ( Temp == 0x02 )	Period = 10;
// 1097 	else if ( Temp == 0x03 )	Period = 20;
// 1098 	else if ( Temp == 0x04 )	Period = 30;
// 1099 	else if ( Temp == 0x05 )	Period = 1*60;
// 1100 	else if ( Temp == 0x06 )	Period = 2*60;
// 1101 	else if ( Temp == 0x07 )	Period = 4*60;
// 1102 	else if ( Temp == 0x08 )	Period = 6*60;
// 1103 	else if ( Temp == 0x09 )	Period = 12*60;	
// 1104 	else if ( Temp == 0x10 )	Period = 1*24*60;
// 1105 	else if ( Temp == 0x11 )	Period = 2*24*60;	
// 1106 	else if ( Temp == 0x12 )	Period = 3*24*60;
// 1107 	else if ( Temp == 0x13 )	Period = 7*24*60;
// 1108 	else if ( Temp == 0x7f )	return(FALSE);
// 1109 	else return(FALSE);
// 1110 
// 1111 	if 		( WThreePastMin < PresentMin ) WThreeTimeElapse = WThreeTimeElapse + (PresentMin-WThreePastMin);
// 1112 	else if ( WThreePastMin > PresentMin ) WThreeTimeElapse = WThreeTimeElapse + (60+PresentMin-WThreePastMin);
// 1113 
// 1114 	WThreePastHour = PresentHour;
// 1115 	WThreePastMin  = PresentMin;
// 1116 
// 1117 	// New Base Time Check //
// 1118 	if ( WThreeTimeStart )
// 1119 	{ 	if ( Present>=Base )
// 1120 		{
// 1121 			WThreeTimeStart = 0;
// 1122 			WThreeTimeElapse = 0;
// 1123 			return(TRUE);
// 1124 		}
// 1125 		return(FALSE);
// 1126 	}
// 1127 
// 1128 	// New Period Check //
// 1129 	if ( WThreePeriodStart )
// 1130 	{	WThreePeriodStart = 0;
// 1131 		if ( Present >= Base )	WThreeTimeElapse = (Present-Base)%Period;
// 1132 		else					WThreeTimeElapse = (24*60+Present-Base)%Period;
// 1133 		return(FALSE);
// 1134 	}
// 1135 
// 1136 	// Elapsed Time Over Check //
// 1137 	if ( WThreeTimeElapse >= Period )
// 1138 	{	WThreeTimeElapse = (WThreeTimeElapse%Period);
// 1139 		return(TRUE);
// 1140 	}
// 1141 	return (FALSE);
// 1142 }
// 1143 
// 1144 BOOL WavTwoAutoRptChk ( void )
// 1145 {
// 1146 	INT8U 	Temp;
// 1147 	long	Period, Present, Base;
// 1148 	
// 1149 
// 1150 	Temp   = iWARPriod2;
// 1151 	Present = 60*PresentHour + PresentMin;
// 1152 	Base 	= 60*(((iWARHour  )>>4)*10+(iWARHour &0x0f))
// 1153 				+(((iWARMinute)>>4)*10+(iWARMinute&0x0f));
// 1154 
// 1155 	/* Period 기호 -> 분 */
// 1156 	     if ( Temp == 0x01 )	Period = 5;
// 1157 	else if ( Temp == 0x02 )	Period = 10;
// 1158 	else if ( Temp == 0x03 )	Period = 20;
// 1159 	else if ( Temp == 0x04 )	Period = 30;
// 1160 	else if ( Temp == 0x05 )	Period = 1*60;
// 1161 	else if ( Temp == 0x06 )	Period = 2*60;
// 1162 	else if ( Temp == 0x07 )	Period = 4*60;
// 1163 	else if ( Temp == 0x08 )	Period = 6*60;
// 1164 	else if ( Temp == 0x09 )	Period = 12*60;	
// 1165 	else if ( Temp == 0x10 )	Period = 1*24*60;
// 1166 	else if ( Temp == 0x11 )	Period = 2*24*60;	
// 1167 	else if ( Temp == 0x12 )	Period = 3*24*60;
// 1168 	else if ( Temp == 0x13 )	Period = 7*24*60;
// 1169 	else if ( Temp == 0x7f )	return(FALSE);
// 1170 	else return(FALSE);
// 1171 
// 1172 	/**********************************************************************
// 1173 	Period = (Temp>>4)*10 + (Temp&0x0f);
// 1174 	if ( Period <= 0 )	return(FALSE);
// 1175 	***********************************************************************/
// 1176 
// 1177 	if 		( WTwoPastMin < PresentMin ) WTwoTimeElapse = WTwoTimeElapse + (PresentMin-WTwoPastMin);
// 1178 	else if ( WTwoPastMin > PresentMin ) WTwoTimeElapse = WTwoTimeElapse + (60+PresentMin-WTwoPastMin);
// 1179 
// 1180 	WTwoPastHour = PresentHour;
// 1181 	WTwoPastMin  = PresentMin;
// 1182 
// 1183 	// New Base Time Check //
// 1184 	if ( WTwoTimeStart )
// 1185 	{ 	if ( Present>=Base )
// 1186 		{	WTwoTimeStart = 0;
// 1187 			WTwoTimeElapse = 0;
// 1188 			return(TRUE);
// 1189 		}
// 1190 		return(FALSE);
// 1191 	}
// 1192 
// 1193 	// New Period Check //
// 1194 	if ( WTwoPeriodStart )
// 1195 	{	WTwoPeriodStart = 0;
// 1196 		if ( Present >= Base )	WTwoTimeElapse = (Present-Base)%Period;
// 1197 		else					WTwoTimeElapse = (24*60+Present-Base)%Period;
// 1198 		return(FALSE);
// 1199 	}
// 1200 
// 1201 	// Elapsed Time Over Check //
// 1202 	if ( WTwoTimeElapse >= Period )
// 1203 	{	WTwoTimeElapse = (WTwoTimeElapse%Period);
// 1204 		return(TRUE);
// 1205 	}
// 1206 	return (FALSE);
// 1207 }
// 1208 
// 1209 INT8U Wave_Response_Control(INT8U* tid, INT8U Ctrl,__ProtocolPtr *nPtr)
// 1210 {
// 1211 	INT8U	i = 0;
// 1212 	INT16U	Cnt = 0;
// 1213 	INT16U AID_Command;
// 1214 	INT8U A_ID[2];
// 1215 	INT8U AID_Value[40];
// 1216 	INT8U Length;
// 1217 
// 1218 	INT8U rval = 0;
// 1219 
// 1220 	__BODYFRAME *Recv = &SMSRecv;
// 1221 
// 1222 	while(Recv->SubLen[1] > Cnt)
// 1223 	{
// 1224 		A_ID[0] = (INT8U)(Recv->SubData[Cnt++]);
// 1225 		A_ID[1] = (INT8U)(Recv->SubData[Cnt++]);
// 1226 
// 1227 		AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
// 1228 		Length = Recv->SubData[Cnt++];
// 1229 		if( Length > 30) break;
// 1230 		for (i = 0; i < Length && i < 30 ; i++) AID_Value[i] = (INT8U)(Recv->SubData[Cnt++]);
// 1231 
// 1232 		rval = LIFWave_CtrlData(AID_Command, AID_Value, Length, Ctrl,nPtr);
// 1233 
// 1234 		if(Cnt >= Recv->SubLength) break;
// 1235 	}
// 1236 	return rval;
// 1237 }
// 1238 
// 1239   
// 1240 INT8U LIFWave_CtrlData(INT16U AID_Command, INT8U *AID_Value, INT8U Length, INT8U Ctrl,__ProtocolPtr *nPtr)
// 1241 {
// 1242 //	INT8U rval = 0;
// 1243 	INT8U i;
// 1244 
// 1245     INT8U tid[3] = {0x00,0xff,0xff};
// 1246 
// 1247 	ModemEsnCheck();
// 1248 
// 1249 //	_WaveCtrl *Sts = WaveCtrl;
// 1250 //	USART1Printf("AID_Command[%x][%d][%d]\n",AID_Command,Length,AID_Value[0]);
// 1251 
// 1252 	switch(AID_Command)
// 1253 	{
// 1254 		case	Aid_EsnChecksum:
// 1255 		  if( (EsnChecksumH !=AID_Value[0]) ||(EsnChecksumL != AID_Value[1]))
// 1256 		  {
// 1257 			  ErrRspFunc(tid,0x10,nPtr);
// 1258 			  iMobileESN=NACK;
// 1259 			  break;
// 1260 		  }
// 1261 		 iMobileESN=ACK;
// 1262 		break;												
// 1263 
// 1264 		case	Aid_RxMaxVal  :
// 1265 		  WaveCtrl->RxMaxVal[0] = AID_Value[0];
// 1266 		  WaveCtrl->RxMaxVal[1] = AID_Value[1];
// 1267 #if 0		  
// 1268 		  WriteEEprom(RxMaxValH, WaveCtrl->RxMaxVal[0]);
// 1269 		  WriteEEprom(RxMaxValL, WaveCtrl->RxMaxVal[1]);
// 1270 #endif		  
// 1271 		break;		
// 1272 
// 1273 		case	Aid_RxMinVal  :
// 1274 		  WaveCtrl->RxMinVal[0] = AID_Value[0];
// 1275 		  WaveCtrl->RxMinVal[1] = AID_Value[1];
// 1276 #if 0		  
// 1277 		  WriteEEprom(RxMinValH, WaveCtrl->RxMinVal[0]);
// 1278 		  WriteEEprom(RxMinValL, WaveCtrl->RxMinVal[1]);
// 1279 #endif		  
// 1280 		break;			
// 1281 
// 1282 		case	Aid_TxMaxVal  :
// 1283 		  WaveCtrl->TxMaxVal[0] = AID_Value[0];
// 1284 		  WaveCtrl->TxMaxVal[1] = AID_Value[1];
// 1285 #if 0
// 1286 		  WriteEEprom(TxMaxValH, WaveCtrl->TxMaxVal[0]);
// 1287 		  WriteEEprom(TxMaxValL, WaveCtrl->TxMaxVal[1]);
// 1288 #endif		  
// 1289 		break;		
// 1290 
// 1291 		case	Aid_TxMinVal  :
// 1292 		  WaveCtrl->TxMinVal[0] = AID_Value[0];
// 1293 		  WaveCtrl->TxMinVal[1] = AID_Value[1];
// 1294 #if 0		  
// 1295 		  WriteEEprom(TxMinValH, WaveCtrl->TxMinVal[0]);
// 1296 		  WriteEEprom(TxMinValL, WaveCtrl->TxMinVal[1]);
// 1297 #endif		  
// 1298 		break;			
// 1299 
// 1300 		case	Aid_AdjMaxVal :
// 1301 		  WaveCtrl->AdjMaxVal[0] = AID_Value[0];
// 1302 		  WaveCtrl->AdjMaxVal[1] = AID_Value[1];
// 1303 #if 0
// 1304 		  WriteEEprom(AdjMaxValH, WaveCtrl->AdjMaxVal[0]);
// 1305 		  WriteEEprom(AdjMaxValL, WaveCtrl->AdjMaxVal[1]);
// 1306 #endif		  
// 1307 		break;			
// 1308 
// 1309 		case	Aid_AdjMinVal :
// 1310 		  WaveCtrl->AdjMinVal[0] = AID_Value[0];
// 1311 		  WaveCtrl->AdjMinVal[1] = AID_Value[1];
// 1312 #if 0
// 1313 		  WriteEEprom(AdjMinValH, WaveCtrl->AdjMinVal[0]);
// 1314 		  WriteEEprom(AdjMinValL, WaveCtrl->AdjMinVal[1]);
// 1315 #endif		  
// 1316 		break;			
// 1317 
// 1318 		case	Aid_EcIo:
// 1319 		  WaveCtrl->EcIo = AID_Value[0];
// 1320 //		  WriteEEprom(EcioVal, WaveCtrl->EcIo);
// 1321 		break;			
// 1322 
// 1323 		case	Aid_AR_Mode:
// 1324 		  WaveCtrl->AR_Mode[0] = AID_Value[0];
// 1325 		  WaveCtrl->AR_Mode[1] = AID_Value[1];
// 1326 
// 1327 		  iWARMode2 = WaveCtrl->AR_Mode[0];
// 1328 		  iWARMode3 = WaveCtrl->AR_Mode[1];
// 1329 #if 0
// 1330 		  WriteEEprom(WARMode2, WaveCtrl->AR_Mode[0]);
// 1331 		  WriteEEprom(WARMode3, WaveCtrl->AR_Mode[1]);
// 1332 #endif		  
// 1333 		break;			
// 1334 
// 1335 		case	Aid_Radio_ReportTime  :
// 1336 		  WaveCtrl->Radio_ReportTime[0] = AID_Value[0];
// 1337 		  WaveCtrl->Radio_ReportTime[1] = AID_Value[1];
// 1338 
// 1339 		  iWARHour = WaveCtrl->Radio_ReportTime[0];
// 1340 		  iWARMinute = WaveCtrl->Radio_ReportTime[1];
// 1341 
// 1342 #if 0
// 1343 		  WriteEEprom(WARHour, WaveCtrl->Radio_ReportTime[0]);
// 1344 		  WriteEEprom(WARMinute, WaveCtrl->Radio_ReportTime[1]);
// 1345 #endif		  
// 1346 		break;			
// 1347 
// 1348 		case	Aid_Radio_ReportPeriod	  :
// 1349 		  WaveCtrl->Radio_ReportPeriod[0] = AID_Value[0];
// 1350 		  WaveCtrl->Radio_ReportPeriod[1] = AID_Value[1];
// 1351 
// 1352 		  iWARPriod2 = WaveCtrl->Radio_ReportPeriod[0];
// 1353 		  iWARPriod3 = WaveCtrl->Radio_ReportPeriod[1];
// 1354 #if 0
// 1355 		  WriteEEprom(WAutoReportPriod2, WaveCtrl->Radio_ReportPeriod[0]);
// 1356 		  WriteEEprom(WAutoReportPriod3, WaveCtrl->Radio_ReportPeriod[1]);
// 1357 #endif		  
// 1358 		break;			
// 1359 
// 1360 		case Aid_TestStn :
// 1361 			for(i=0;i<11;i++)
// 1362 			{
// 1363 				TestStation[i] = AID_Value[i];
// 1364 				WaveCtrl->TestStn[i]=TestStation[i];
// 1365 				if ((TestStation[i]<'0')||(TestStation[i]>'9') )TestStation[i] = 0x00;
// 1366 //				WriteEEprom(TestStationBp + i, TestStation[i]);
// 1367 			}
// 1368 		break;
// 1369 
// 1370 		default :
// 1371 		break;
// 1372 	}
// 1373 
// 1374 	return TRUE ;
// 1375 }
// 1376 
// 1377 
// 1378 void DnrIpAddressAck(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr)
// 1379 {
// 1380 	INT16U i;
// 1381 	INT8U	CHKSUM = 0;
// 1382 
// 1383 	__BODYFRAME *Recv = &SMSRecv;
// 1384 	__BODYFRAME *Send = &SMSSend;
// 1385 
// 1386 
// 1387 	Send->SubID[0] = tid[0];
// 1388 	Send->SubID[1] = tid[1];
// 1389 	Send->SubID[2] = tid[2];
// 1390 
// 1391 	Send->Command = Comm;
// 1392 	Send->RCode = Recv->RCode;
// 1393 
// 1394 	Send->SubLength = Recv->SubLength ;
// 1395 
// 1396 	Send->SubLen[0]	= (INT8U)(Send->SubLength >> 8);
// 1397 	Send->SubLen[1]	= (INT8U)(Send->SubLength);
// 1398 
// 1399 	for(i = 0; i < Send->SubLength && i < SMS_BODYSIZEMAX; i++)
// 1400 	{
// 1401 		Send->SubData[i] =  Recv->SubData[i];;
// 1402 	}
// 1403 
// 1404 	for(i = 0; i < Send->SubLength+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
// 1405 	Send->SubData[Send->SubLength++] = DataConv(HIGH,CHKSUM);
// 1406 	Send->SubData[Send->SubLength++] = DataConv(LOW,CHKSUM);
// 1407 
// 1408 	Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);
// 1409 
// 1410 	Sms_DataAckTx(nPtr);
// 1411 
// 1412 }
// 1413 
// 1414 
// 1415 void DnrPacketReadyFunc(__ProtocolPtr *nPtr)
// 1416 {
// 1417 	INT16U i;
// 1418 	INT32S ret = 0;
// 1419 	
// 1420 	__BODYFRAME *Recv = &SMSRecv;
// 1421 	
// 1422 	tcp_port = 8081;
// 1423 	for(i = 0; i < 5; i++)
// 1424 	{
// 1425  		if( (ret = BcMdemTcpConnect(Recv->SubData,Recv->SubLen[1],tcp_port)) == 1)
// 1426 		{
// 1427 			if(!SerialOnFlag)pPrintf("IP Connect[%d] \r\n",ret);
// 1428 			DownLoadGiveupTimerSet(Ser4DownLoading);
// 1429 			break;
// 1430 		}
// 1431 		else
// 1432 		{
// 1433 			if(!SerialOnFlag)pPrintf("IP Not Connect \r\n");
// 1434 		}
// 1435 		OSTimeDly(1000*5L);
// 1436 	}
// 1437 	if(i > 4)TcpExit();
// 1438 }
// 1439 
// 1440 INT8U TcpExit(void)
// 1441 {
// 1442 	INT8U nRet = TRUE;
// 1443 	INT16U i;
// 1444 
// 1445 	for(i = 0; i < 5; i++)
// 1446 	{
// 1447 		if( nRet = BcMdemTcpExit() > 3)
// 1448 		{
// 1449 			if(!SerialOnFlag) pPrintf("BcMdemTcpExit[%d]\r\n",nRet);
// 1450 			return TRUE;
// 1451 		}
// 1452 		else
// 1453 		{
// 1454 			nRet = FALSE;
// 1455 			if(!SerialOnFlag) pPrintf("Tx FALSE: BcMdemTcpExit[%d]\r\n",nRet);
// 1456 		}
// 1457 		OSTimeDly(1000*10L);
// 1458 	}
// 1459 	return nRet;
// 1460 }
// 1461 
// 1462 void SpecFreqState_RspFunc (INT8U* tid,INT8U Comm, INT8U Auto, INT8U Idle,__ProtocolPtr *nPtr)
// 1463 {
// 1464 	INT8U CHKSUM=0,Count=0,i;
// 1465 
// 1466 	__BODYFRAME *Send = &SMSSend;
// 1467 
// 1468 	if (Idle == NormalMode)
// 1469 	{
// 1470 		for(i = 0 ; i<3; i++)
// 1471 		{
// 1472 		if(BcMdemCalling((char *)TestStation) == TRUE) break;
// 1473 		OSTimeDly(1000 * 5L);
// 1474 		}
// 1475 
// 1476 		if(TrafficCheck() == TRUE)	
// 1477 		{
// 1478 			WaveSts->OneFAStatus = 0x03;	// Call OK!
// 1479 			if(iSmsFalseCnt > 0)iSmsFalseCnt = iSmsFalseCnt - 1;
// 1480 //			if(!SerialOnFlag)USART1Printf("CdmaModemTrafficCheck : iSmsFalseCnt : %d\n",iSmsFalseCnt);
// 1481 		}
// 1482 		else						
// 1483 		{
// 1484 			WaveSts->OneFAStatus = 0x04;	// Call OK!
// 1485 			iSmsFalseCnt = iSmsFalseCnt+ 1;
// 1486 //			 if(!SerialOnFlag) USART1Printf("CdmaModemTrafficCheck1 iSmsFalseCnt : %d \n", iSmsFalseCnt);		 
// 1487 		}
// 1488 	}
// 1489 	else WaveSts->OneFAStatus = 0x03;				// Call OK!
// 1490 	 
// 1491 	SpecFreqStateUpdate();
// 1492 
// 1493  	for ( i = 0; i <3; i++ ) 
// 1494 	{
// 1495 		INT32S ret = TrafficCheck();
// 1496 
// 1497 		if(ret == TRUE)	CdmaModemHangUp();
// 1498 		else  			break;	// Hang Up //
// 1499 		OSTimeDly(1000*5L);
// 1500 	}
// 1501 
// 1502 
// 1503 	FreqAlarmCheckRpt(tid,nPtr);
// 1504 	{
// 1505 	// Frame Header //
// 1506 	Send->SubID[0] 	 = tid[0];
// 1507 	Send->SubID[1] 	 = tid[1];
// 1508 	Send->SubID[2] 	 = tid[2];
// 1509 
// 1510 	Send->Command = Comm;
// 1511 	Send->RCode = __DUO_LIF;
// 1512 
// 1513 	Send->SubData[Count++]= 0x00;
// 1514 	Send->SubData[Count++]= 0x01;
// 1515 	Send->SubData[Count++]= 0x04;
// 1516 
// 1517 	// 알람 체크 Flag 설정
// 1518 	Send->SubData[Count++]= 0x7e;
// 1519 	Send->SubData[Count++]= 0x7e;
// 1520 	Send->SubData[Count++]= WaveAlarm->RxTxAlarm.Data;
// 1521 	Send->SubData[Count++]= WaveAlarm->EcIo.Data;
// 1522 
// 1523 	if(Auto == 0x01)
// 1524 	{
// 1525 		Send->SubData[Count++] = hibyte(Aid_SMS_TxRetry); // A_ID
// 1526 		Send->SubData[Count++] = lobyte(Aid_SMS_TxRetry);
// 1527 		Send->SubData[Count++] = 0x01;
// 1528 		Send->SubData[Count++] = WaveSts->SMS_TxRetry;
// 1529 
// 1530 		Send->SubData[Count++] = hibyte(Aid_ActChannel); // A_ID
// 1531 		Send->SubData[Count++] = lobyte(Aid_ActChannel);
// 1532 		Send->SubData[Count++] = 0x02;
// 1533 		Send->SubData[Count++] = WaveSts->ActChannel[0];
// 1534 		Send->SubData[Count++] = WaveSts->ActChannel[1];
// 1535 
// 1536 		Send->SubData[Count++] = hibyte(Aid_OneFAStatus); // A_ID
// 1537 		Send->SubData[Count++] = lobyte(Aid_OneFAStatus);
// 1538 		Send->SubData[Count++] = 0x01;
// 1539 		Send->SubData[Count++] = WaveSts->OneFAStatus;
// 1540 
// 1541 		Send->SubData[Count++] = hibyte(Aid_FARxValue); // A_ID
// 1542 		Send->SubData[Count++] = lobyte(Aid_FARxValue);
// 1543 		Send->SubData[Count++] = 0x02;
// 1544 		Send->SubData[Count++] = WaveSts->FARxVal[0];
// 1545 		Send->SubData[Count++] = WaveSts->FARxVal[1];
// 1546 		if (Idle == NormalMode)
// 1547 		{
// 1548 			Send->SubData[Count++] = hibyte(Aid_FAAdjValue); // A_ID
// 1549 			Send->SubData[Count++] = lobyte(Aid_FAAdjValue);
// 1550 			Send->SubData[Count++] = 0x02;
// 1551 			Send->SubData[Count++] = WaveSts->WaveNormalStatus.FAAdjVal[0];
// 1552 			Send->SubData[Count++] = WaveSts->WaveNormalStatus.FAAdjVal[1];
// 1553 
// 1554 			Send->SubData[Count++] = hibyte(Aid_FAFerValue); // A_ID
// 1555 			Send->SubData[Count++] = lobyte(Aid_FAFerValue);
// 1556 			Send->SubData[Count++] = 0x01;
// 1557 			Send->SubData[Count++] = WaveSts->WaveNormalStatus.FAFerVal;
// 1558 		}
// 1559 		Send->SubData[Count++] = hibyte(Aid_PN_Val); // A_ID
// 1560 		Send->SubData[Count++] = lobyte(Aid_PN_Val);
// 1561 		Send->SubData[Count++] = 0x0c;
// 1562 		Send->SubData[Count++] = WaveSts->PN_Val[0];
// 1563 		Send->SubData[Count++] = WaveSts->PN_Val[1];
// 1564 		Send->SubData[Count++] = WaveSts->PN_Val[2];
// 1565 		Send->SubData[Count++] = WaveSts->PN_Val[3];
// 1566 		Send->SubData[Count++] = WaveSts->PN_Val[4];
// 1567 		Send->SubData[Count++] = WaveSts->PN_Val[5];
// 1568 		Send->SubData[Count++] = WaveSts->PN_Val[6];
// 1569 		Send->SubData[Count++] = WaveSts->PN_Val[7];
// 1570 		Send->SubData[Count++] = WaveSts->PN_Val[8];
// 1571 		Send->SubData[Count++] = WaveSts->PN_Val[9];
// 1572 		Send->SubData[Count++] = WaveSts->PN_Val[10];
// 1573 		Send->SubData[Count++] = WaveSts->PN_Val[11];
// 1574 
// 1575 		Send->SubData[Count++] = hibyte(Aid_EcIo_Val); // A_ID
// 1576 		Send->SubData[Count++] = lobyte(Aid_EcIo_Val);
// 1577 		Send->SubData[Count++] = 0x06;
// 1578 		Send->SubData[Count++] = WaveSts->EcIo_Val[0];
// 1579 		Send->SubData[Count++] = WaveSts->EcIo_Val[1];
// 1580 		Send->SubData[Count++] = WaveSts->EcIo_Val[2];
// 1581 		Send->SubData[Count++] = WaveSts->EcIo_Val[3];
// 1582 		Send->SubData[Count++] = WaveSts->EcIo_Val[4];
// 1583 		Send->SubData[Count++] = WaveSts->EcIo_Val[5];
// 1584 
// 1585 		if ((Comm == RadioAutoReport)||(Comm == IdleStatusReport))
// 1586 		{
// 1587 			Send->SubData[Count++] = hibyte(Aid_ReportHours); // A_ID
// 1588 			Send->SubData[Count++] = lobyte(Aid_ReportHours);
// 1589 			Send->SubData[Count++] = 0x02;
// 1590 			Send->SubData[Count++] = PresentHour;
// 1591 			Send->SubData[Count++] = PresentMin;
// 1592 		}
// 1593 	}
// 1594 
// 1595 	Send->SubLen[0] = 0;
// 1596 	Send->SubLen[1] = Count;
// 1597 	
// 1598 	// Frame CHKSUM //
// 1599 	for(i = 0; i < Count+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
// 1600 	Send->SubData[Count++] = DataConv(HIGH,CHKSUM);
// 1601 	Send->SubData[Count++] = DataConv(LOW,CHKSUM);
// 1602 	Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);
// 1603 
// 1604 	Sms_DataAckTx(nPtr);
// 1605 	}
// 1606 }
// 1607 
// 1608 INT8U TrafficCheck(void)
// 1609 {
// 1610 	INT8U j;
// 1611 	INT8U nRet = TRUE;
// 1612 
// 1613 	for(j = 0 ; j < 3; j++)
// 1614 	{
// 1615 		INT32S ret = 0;
// 1616 		if( ret= CdmaModemTrafficCheck() == '3')
// 1617 		{
// 1618 			if(!SerialOnFlag) USART1Printf("CdmaModemTrafficCheck : nRet: %d  \n", ret);
// 1619 			break;
// 1620 		}
// 1621 		else				
// 1622 		{
// 1623 			if(!SerialOnFlag)USART1Printf("CdmaModemTrafficCheck1 : nRet: %d  \n", ret);
// 1624 			nRet = FALSE;
// 1625 		}
// 1626 		OSTimeDly(500);
// 1627 	}
// 1628 	
// 1629 	return nRet;
// 1630 }
// 1631 
// 1632 void SpecFreqStateUpdate ( void )
// 1633 {
// 1634 	 int	 i = 0, TempThreshold = 0;
// 1635 	 int	 NumTry = 0,j = 0;
// 1636 	 INT8U	 TempCopy;
// 1637 
// 1638 	 INT16S CurrFer=0;
// 1639 	 INT16S CurrRx=0;
// 1640 	 INT16S CurrAdj=0;
// 1641 	 INT16S CurrTx =0;
// 1642 
// 1643  //=======================//
// 1644  // Rx, Tx, Adj Averaging //
// 1645  //=========================================================================//
// 1646 	 for ( i=0; i<3; i++)
// 1647 	 {	 
// 1648 		 if ( BcdemRfStsGet(&Rf_sts) != FALSE) break;
// 1649 	 }
// 1650 
// 1651 	 CurrFer = Rf_sts.FerValue;
// 1652 	 CurrRx  = Rf_sts.RxValue;
// 1653 	 CurrAdj = Rf_sts.AdjValue;
// 1654 	 
// 1655 	 OSTimeDly(1000*2L);
// 1656  
// 1657 	 NumTry = 5;
// 1658 	 for ( j=0; j<( NumTry - 1 ) ; j++ )
// 1659 	 {
// 1660 		 for ( i=0; i<3; i++)
// 1661 		 {	 
// 1662 			 if ( BcdemRfStsGet(&Rf_sts) != FALSE) break;
// 1663 		 }
// 1664 		 CurrFer = (CurrFer + Rf_sts.FerValue)/2;
// 1665 		 CurrRx  = (CurrRx + Rf_sts.RxValue)/2;
// 1666 		 CurrAdj = (CurrAdj + Rf_sts.AdjValue)/2;
// 1667 
// 1668 		 OSTimeDly(1000*3L);
// 1669 	 }
// 1670 /*
// 1671 	if(!SerialOnFlag) USART1Printf("CurrFer1 :[%d]\n", CurrFer);
// 1672 	if(!SerialOnFlag) USART1Printf("CurrRx1 :[%d] \n",CurrRx);
// 1673 	if(!SerialOnFlag) USART1Printf("CurrAdj1:[%d][%d]\n",CurrAdj);
// 1674 
// 1675 	if(!SerialOnFlag) USART1Printf("ActPN : %d	\n", Rf_sts.ActPN);
// 1676 	if(!SerialOnFlag) USART1Printf("NumberOfChannel : %d  \n", Rf_sts.NumberOfChannel);
// 1677 */
// 1678 
// 1679 	WaveSts->FARxVal[0] = DataConv(HIGH,CurrRx);
// 1680 	WaveSts->FARxVal[1] = DataConv(LOW,CurrRx);
// 1681 
// 1682 	WaveSts->WaveNormalStatus.FAFerVal = lobyte(CurrFer);
// 1683 
// 1684 	WaveSts->WaveNormalStatus.FAAdjVal[0] = DataConv(HIGH,CurrAdj);
// 1685 	WaveSts->WaveNormalStatus.FAAdjVal[1] = DataConv(LOW,CurrAdj);
// 1686 
// 1687 	WaveSts->ActChannel[0] = (Rf_sts.ActChannel >> 6) & 0x3f;
// 1688 	WaveSts->ActChannel[1] = (Rf_sts.ActChannel	   ) & 0x3f;
// 1689 
// 1690 	{
// 1691 
// 1692 	//===================//
// 1693 	// Rx, Tx, Adj Alarm //
// 1694 	//=========================================================================//
// 1695 	CurrTx = - CurrRx + CurrAdj - 73;
// 1696 
// 1697 	}
// 1698  
// 1699 	BcdemPilotGet(&Pilot_Sts);
// 1700 
// 1701 	WaveSts->PN_Val[0] = (Rf_sts.PN_Vaule[0]>>6)&0x3f;
// 1702 	WaveSts->PN_Val[1] = (Rf_sts.PN_Vaule[0])&0x3f;;
// 1703 	WaveSts->EcIo_Val[0] = abs(Rf_sts.EcIo[0]);
// 1704 
// 1705 	for(i = 0; i < 4; i++)
// 1706 	{
// 1707 		WaveSts->PN_Val[i*2 ] = (Pilot_Sts.PN_Vaule[i]>>6) & 0x3f;
// 1708 		WaveSts->PN_Val[i*2 + 1] = (Pilot_Sts.PN_Vaule[i]) & 0x3f;
// 1709 		WaveSts->EcIo_Val[i]= abs(Pilot_Sts.EcIo[i]);
// 1710 	}
// 1711 
// 1712 	TempCopy = 0;
// 1713 
// 1714 	if(CurrRx > TwoAsciNum2OneHex(WaveCtrl->RxMaxVal[0], WaveCtrl->RxMaxVal[1])) 	 BitSet(TempCopy, 6);
// 1715 	if(CurrRx < TwoAsciNum2OneHex(WaveCtrl->RxMinVal[0], WaveCtrl->RxMinVal[1])) 	 BitSet(TempCopy, 5);
// 1716 
// 1717 	if(CurrTx > TwoAsciNum2OneHex(WaveCtrl->TxMaxVal[0], WaveCtrl->TxMaxVal[1])) 	 BitSet(TempCopy, 4);
// 1718 	if(CurrTx < TwoAsciNum2OneHex(WaveCtrl->TxMinVal[0], WaveCtrl->TxMinVal[1])) 	 BitSet(TempCopy, 3);
// 1719 	if(CurrAdj > TwoAsciNum2OneHex(WaveCtrl->AdjMaxVal[0], WaveCtrl->AdjMaxVal[1]))	 BitSet(TempCopy, 2);
// 1720 	if(CurrAdj < TwoAsciNum2OneHex(WaveCtrl->AdjMinVal[0], WaveCtrl->AdjMinVal[1]))	 BitSet(TempCopy, 1);
// 1721 
// 1722 
// 1723 	WaveAlarm->RxTxAlarm.Data = TempCopy;
// 1724 	//=======================================//
// 1725 	// Each PN Ecio Threshold Check -> Alarm //
// 1726 	//=========================================================================//
// 1727 	TempThreshold = ((WaveCtrl->EcIo>>4)*10) + (WaveCtrl->EcIo&0x0f);
// 1728 
// 1729 	TempCopy = 0;
// 1730 	for ( i=0; i<6; i++ )
// 1731 	{
// 1732 	 if((WaveSts->EcIo_Val[i]> TempThreshold)&& (WaveSts->EcIo_Val[i]!= 0)) BitSet(TempCopy, 6-i);
// 1733 	}
// 1734 	WaveAlarm->EcIo.Data = TempCopy;
// 1735 
// 1736 	//=================================//
// 1737 	// Master Pn Update Check & Report //
// 1738 	//=========================================================================//
// 1739 	for ( i=0; i<6; i++ )	
// 1740 	{	
// 1741 		iPNVal_Old[i*2] = WaveSts->PN_Val[i*2];
// 1742 		iPNVal_Old[i*2+1] = WaveSts->PN_Val[i*2+1];
// 1743 	}
// 1744 	for(i=0;i<6;i++)
// 1745 	{
// 1746 	iPNVal_Old[i]=WaveSts->EcIo_Val[i];
// 1747 	}
// 1748 
// 1749 
// 1750 	if ((iMasterPNH == WaveSts->PN_Val[0])&&(iMasterPNL == WaveSts->PN_Val[1] ))
// 1751 	  PnChangeCnt = 0;
// 1752 	else PnChangeCnt++;
// 1753 
// 1754 
// 1755 	if ( PnChangeCnt >= 2 )
// 1756 	{
// 1757 	 iMasterPNH  = WaveSts->PN_Val[0];
// 1758 	 iMasterPNL  = WaveSts->PN_Val[1];
// 1759 #if 0
// 1760 	 WriteEEprom(MasterPNH,iMasterPNH);
// 1761 	 WriteEEprom(MasterPNL,iMasterPNL);
// 1762 #endif	 
// 1763 	 PnAlarm=Alarm;
// 1764 	 PnChangeCnt = 0;
// 1765 	}
// 1766 
// 1767 }
// 1768 
// 1769 
// 1770 void FreqAlarmCheckRpt (INT8U* tid,__ProtocolPtr *nPtr)
// 1771 {
// 1772  //=========================//
// 1773  // Rx, Tx, Adj, EcIo Check //
// 1774  //=========================================================================//
// 1775 	
// 1776 //	if(DnrMask[0] == 0x01)	 return;
// 1777 	if(AlarmMask == 0x01)	 return;
// 1778 
// 1779 	RxTxAlarmNew = WaveAlarm->RxTxAlarm.Data;
// 1780 	RxTxAlarmFlag = RxTxAlarmNew ^ RxTxAlarmOld;
// 1781 	RxTxAlarmOld = RxTxAlarmNew;
// 1782 
// 1783 
// 1784 	EcIoNew = WaveAlarm->EcIo.Data;
// 1785 	EcIoFlag = EcIoNew ^EcIoOld;
// 1786 	EcIoOld = EcIoNew;
// 1787 
// 1788 	PnAlarmNew = PnAlarm;
// 1789 	PnAlarmFlag = PnAlarmNew ^PnAlarmOld;
// 1790 	PnAlarmOld = PnAlarmNew;
// 1791 
// 1792 
// 1793 	if ((RxTxAlarmFlag ) ||(EcIoFlag ) ||(PnAlarmFlag ))
// 1794 	{
// 1795 		FreqAlarmRptFunc(tid,nPtr);
// 1796 	}
// 1797 
// 1798 }
// 1799 
// 1800 void FreqAlarmRptFunc (INT8U* tid,__ProtocolPtr *nPtr)
// 1801 {
// 1802 	INT8U CHKSUM=0,Count=0,i;
// 1803 
// 1804 	__BODYFRAME *Send = &SMSSend;
// 1805 
// 1806 	// Frame Header //
// 1807 	Send->SubID[0] = tid[0];
// 1808 	Send->SubID[1] = tid[1];
// 1809 	Send->SubID[2] = tid[2];
// 1810 	
// 1811 	Send->RCode		 = __DUO_LIF;
// 1812 	Send->Command	 = RadioAlarmReport;
// 1813 
// 1814 	if(BitRead(RxTxAlarmFlag, 6))
// 1815 	{
// 1816 		Send->SubData[Count++] = hibyte(Aid_RxMaxVal); // A_ID
// 1817 		Send->SubData[Count++] = lobyte(Aid_RxMaxVal);
// 1818 
// 1819 		if(BitRead(RxTxAlarmOld, 6))	 Send->SubData[Count++] = 0x01;	 // 발생
// 1820 		else							 Send->SubData[Count++] = 0x00;	 // 해제
// 1821 
// 1822 		Send->SubData[Count++] = 0x02;							 // Lenght
// 1823 
// 1824 		Send->SubData[Count++] = WaveSts->FARxVal[0];						
// 1825 		Send->SubData[Count++] = WaveSts->FARxVal[1];		
// 1826 	}
// 1827 
// 1828 	if(BitRead(RxTxAlarmFlag, 5))
// 1829 	{
// 1830 		Send->SubData[Count++] = hibyte(Aid_RxMinVal); // A_ID
// 1831 		Send->SubData[Count++] = lobyte(Aid_RxMinVal);
// 1832 
// 1833 		if(BitRead(RxTxAlarmOld, 5))	 Send->SubData[Count++] = 0x01;	 // 발생
// 1834 		else							 Send->SubData[Count++] = 0x00;	 // 해제
// 1835 
// 1836 		Send->SubData[Count++] = 0x02;												 // Lenght
// 1837 
// 1838 		Send->SubData[Count++] = WaveSts->FARxVal[0];						
// 1839 		Send->SubData[Count++] = WaveSts->FARxVal[1];					
// 1840 	}
// 1841 
// 1842 	if(BitRead(RxTxAlarmFlag, 4))
// 1843 	{
// 1844 		Send->SubData[Count++] = hibyte(Aid_TxMaxVal);				 // A_ID
// 1845 		Send->SubData[Count++] = lobyte(Aid_TxMaxVal);
// 1846 
// 1847 		if(BitRead(RxTxAlarmOld, 4))	 Send->SubData[Count++] = 0x01;		 // 발생
// 1848 		else							 Send->SubData[Count++] = 0x00;		 // 해제
// 1849 
// 1850 		Send->SubData[Count++] = 0x02;												 // Lenght
// 1851 		Send->SubData[Count++] = iTxValH;						
// 1852 		Send->SubData[Count++] = iTxValL;						
// 1853 	}
// 1854 
// 1855 	if(BitRead(RxTxAlarmFlag, 3))
// 1856 	{
// 1857 		Send->SubData[Count++] = hibyte(Aid_TxMinVal);				 // A_ID
// 1858 		Send->SubData[Count++] = lobyte(Aid_TxMinVal);
// 1859 
// 1860 		if(BitRead(RxTxAlarmOld, 3))	 Send->SubData[Count++] = 0x01;	 // 발생
// 1861 		else							 Send->SubData[Count++] = 0x00;	 // 해제
// 1862 		Send->SubData[Count++] = 0x02;												 // Lenght
// 1863 
// 1864 		Send->SubData[Count++] = iTxValH;						
// 1865 		Send->SubData[Count++] = iTxValL;
// 1866 	}
// 1867 
// 1868 	if(BitRead(RxTxAlarmFlag, 2))
// 1869 	{
// 1870 		Send->SubData[Count++] = hibyte(Aid_AdjMaxVal);				 // A_ID
// 1871 		Send->SubData[Count++] = lobyte(Aid_AdjMaxVal);
// 1872 
// 1873 		if(BitRead(RxTxAlarmOld, 2))	Send->SubData[Count++] = 0x01;	 // 발생
// 1874 		else							Send->SubData[Count++] = 0x00;	 // 해제
// 1875 		Send->SubData[Count++] = 0x02;												 // Lenght
// 1876 
// 1877 		Send->SubData[Count++] = WaveSts->WaveNormalStatus.FAAdjVal[0];							
// 1878 		Send->SubData[Count++] = WaveSts->WaveNormalStatus.FAAdjVal[1];							
// 1879 	}
// 1880 
// 1881 	if(BitRead(RxTxAlarmFlag, 1))
// 1882 	{
// 1883 		Send->SubData[Count++] = hibyte(Aid_AdjMinVal);				 // A_ID
// 1884 		Send->SubData[Count++] = lobyte(Aid_AdjMinVal);
// 1885 
// 1886 		if(BitRead(RxTxAlarmOld, 1))	 Send->SubData[Count++] = 0x01;	 // 발생
// 1887 		else							 Send->SubData[Count++] = 0x00;	 // 해제
// 1888 
// 1889 		Send->SubData[Count++] = 0x02;												 // Lenght
// 1890 		Send->SubData[Count++] = WaveSts->WaveNormalStatus.FAAdjVal[0];							
// 1891 		Send->SubData[Count++] = WaveSts->WaveNormalStatus.FAAdjVal[1];							
// 1892 	}
// 1893 
// 1894 	if(EcIoFlag != 0)		
// 1895 	{
// 1896 		Send->SubData[Count++] = hibyte(Aid_EcIo);				 // A_ID
// 1897 		Send->SubData[Count++] = lobyte(Aid_EcIo);
// 1898 
// 1899 		if(EcIoOld!=0) 	 	Send->SubData[Count++] = 0x01;			 // 발생
// 1900 		else				Send->SubData[Count++] = 0x00;			 // 해제
// 1901 
// 1902 		Send->SubData[Count++] = 0x01;											 // Lenght
// 1903 		Send->SubData[Count++] = WaveSts->EcIo_Val[0];				
// 1904 	}
// 1905 
// 1906 	if(PnAlarmFlag)
// 1907 	{
// 1908 		Send->SubData[Count++] = hibyte(Aid_PN_Update);				 // A_ID
// 1909 		Send->SubData[Count++] = lobyte(Aid_PN_Update);
// 1910 
// 1911 		if(PnAlarm)	 Send->SubData[Count++] = 0x01;				 // 발생
// 1912 		else			 Send->SubData[Count++] = 0x00;				 // 해제
// 1913 
// 1914 		Send->SubData[Count++] = 0x02;								 // Lenght
// 1915 		Send->SubData[Count++] = iMasterPNH; 						
// 1916 		Send->SubData[Count++] = iMasterPNL; 						
// 1917 	}
// 1918 
// 1919 	/***************************************/
// 1920 	Send->SubLen[0] = 0;
// 1921 	Send->SubLen[1] = Count;
// 1922 
// 1923 	// Frame CHKSUM //
// 1924 	for(i = 0; i < Count+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
// 1925 	Send->SubData[Count++] = DataConv(HIGH,CHKSUM);
// 1926 	Send->SubData[Count++] = DataConv(LOW,CHKSUM);
// 1927 
// 1928 	Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);
// 1929 
// 1930 	Sms_DataAckTx(nPtr);
// 1931 }
// 1932 
// 1933 
// 1934 INT8U WhatRxTCP(__ProtocolPtr *nPtr)
// 1935 {
// 1936 	INT16U RetVal = 0;
// 1937 
// 1938 	INT8U cBody = nPtr->WRCSRecv->cBody;
// 1939 	
// 1940 	//SIO´ BODY is ONLY ONE(1)
// 1941 	if(nPtr->WRCSRecv->BodyFrame[cBody].CrcOK)	// CRC OK
// 1942 	{
// 1943 		RetVal = nPtr->WRCSRecv->BodyFrame[cBody].Command;
// 1944 	}
// 1945 	else //NO ERROR
// 1946 	{
// 1947 		//ERROR CASE
// 1948 		RetVal = crcERROR;
// 1949 	}
// 1950     return (RetVal);	
// 1951 }
// 1952 
// 1953 
// 1954 void TCPComCheck (__ProtocolPtr *nPtr)
// 1955 {
// 1956 	INT8U BoardID = 0;
// 1957 	INT16U Comm = WhatRxTCP(nPtr);
// 1958 	
// 1959 
// 1960 	__WRCSSIO *Recv = nPtr->WRCSRecv;
// 1961 //	__WRCSSIO *Send = nPtr->WRCSSend;
// 1962     __BODYFRAME *rBody = &Recv->BodyFrame[0];
// 1963 //    __BODYFRAME *sBody = &Send->BodyFrame[0];
// 1964 
// 1965 
// 1966 
// 1967 
// 1968   
// 1969 	BoardID = rBody->SubID[1];
// 1970 
// 1971 	Comm = WhatRxTCP(nPtr);
// 1972 //	SerPtr->printf("Comm[%x]\n",Comm);
// 1973 
// 1974 	switch(Comm)	//command 체크
// 1975 	{
// 1976 		case DownloadMinNumCMD:
// 1977 			DownLoadGiveupTimerSet(Ser4DownLoading);
// 1978 			WRCS_DownloadFunc(nPtr);
// 1979 		break;
// 1980 
// 1981 
// 1982 		case DownloadCMD:
// 1983 		case DownloadCMDConfirm:
// 1984 		case DownLoadData:
// 1985 		case DownLoadDataConfirm:
// 1986 			DownLoadGiveupTimerSet(Ser4DownLoading);
// 1987 			if(BoardID == Dnr_ID)	
// 1988 			{
// 1989 				WRCS_DownloadFunc(nPtr);
// 1990 
// 1991 				if(Comm == DownLoadDataConfirm )
// 1992 				{
// 1993 					TcpExit();
// 1994 					DownLoadBootingJump();
// 1995 				}
// 1996 			}
// 1997 		break;
// 1998 
// 1999 		default:
// 2000 		break;
// 2001 	}
// 2002 }	
// 2003 
// 2004 
// 2005 
// 2006 INT32U TCPProtocolCheck(__ProtocolPtr *nPtr)
// 2007 {
// 2008 	INT16U Data;
// 2009 	INT16U DataCnt = 0;
// 2010 
// 2011 	__WRCSSIO *Recv = nPtr->WRCSRecv;
// 2012  
// 2013 	while(1)
// 2014 	{
// 2015 
// 2016 		if (  (STX == tcp_buff[DataCnt++])
// 2017 			&&(STX == tcp_buff[DataCnt++])
// 2018 			&&(STX == tcp_buff[DataCnt++])
// 2019 			&&(STX == tcp_buff[DataCnt++])	 )
// 2020 		{
// 2021 			Recv->Sync[0] = STX;
// 2022 			Recv->Sync[1] = STX;
// 2023 			Recv->Sync[2] = STX;
// 2024 			Recv->Sync[3] = STX;
// 2025 			
// 2026 			Recv->BodyNo = 0; // Default: 1EA
// 2027 			break;
// 2028 		}
// 2029 		 OSTimeDly(1L);
// 2030 	}
// 2031 
// 2032 	Recv->TryNo 		= tcp_buff[DataCnt++];
// 2033 	Recv->BodyLen[0]	= tcp_buff[DataCnt++];
// 2034 	Recv->BodyLen[1]	= tcp_buff[DataCnt++];
// 2035 	Recv->CheckSum		= tcp_buff[DataCnt++];
// 2036 
// 2037 	Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);
// 2038 
// 2039 	if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
// 2040 		|| (Recv->BodyLength >= SMS_BODYSIZEMAX) 
// 2041 	)
// 2042 	{								
// 2043 		return FALSE;
// 2044 	}
// 2045 	
// 2046 	{
// 2047 		INT16U i;
// 2048 		for(i = 0; i < 7 ; i++)
// 2049 		{
// 2050 			*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubID + i) = tcp_buff[DataCnt++];
// 2051 
// 2052 		}
// 2053 	}
// 2054 
// 2055 	Recv->BodyFrame[Recv->BodyNo].SubLength
// 2056 		=	 ((Recv->BodyFrame[Recv->BodyNo].SubLen[0] << 8)& 0xff00)
// 2057 		  +  ((Recv->BodyFrame[Recv->BodyNo].SubLen[1]	 )& 0x00ff) ;
// 2058 	{
// 2059 		INT16U i;
// 2060 		for(i = 0; i < Recv->BodyFrame[Recv->BodyNo].SubLength + 2 ; i++)
// 2061 		{
// 2062 		*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubData+ i) = tcp_buff[DataCnt++];
// 2063 		}
// 2064 	}
// 2065 
// 2066 	Recv->BodyFrame[Recv->BodyNo].Crc= Crc16Calc ( &(Recv->BodyFrame[Recv->BodyNo].SubID[0])
// 2067 						, Recv->BodyFrame[Recv->BodyNo].SubLength + 5 + 2, NULL);
// 2068 	Recv->BodyFrame[Recv->BodyNo].CrcOK = TRUE;
// 2069 
// 2070 	Data = Recv->BodyFrame[Recv->BodyNo].SubLength;
// 2071 
// 2072 	if (   ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc >> 8)!= Recv->BodyFrame[Recv->BodyNo].SubData[Data  ] )
// 2073 		|| ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc     )!= Recv->BodyFrame[Recv->BodyNo].SubData[Data+1] )  )
// 2074 	{
// 2075 		//CRC ERROR!!
// 2076 		Recv->BodyFrame[Recv->BodyNo].CrcOK = FALSE;
// 2077 		return TRUE;
// 2078 	}
// 2079 
// 2080 	Data = tcp_buff[DataCnt++];
// 2081 
// 2082 	if(Data != ETX)
// 2083 	{
// 2084 		return FALSE;
// 2085 	}
// 2086 	return TRUE;
// 2087 }
// 2088 
// 2089 
// 2090 
// 2091 unsigned char TCPProDataAckTx(INT8U* tid, INT8U *Data, INT16U nCnt,
// 2092 					INT8U Comm, __ProtocolPtr *nPtr)
// 2093 {
// 2094 	INT32U i;
// 2095 	INT32U DataCnt = 0;
// 2096 
// 2097 	__WRCSSIO *Send = nPtr->WRCSSend;
// 2098 
// 2099 #if TWO_BODY >= 2
// 2100 		INT8U BodyNo = Send->BodyNo;
// 2101 #else
// 2102 		INT8U BodyNo = 0;
// 2103 #endif
// 2104 
// 2105 
// 2106 	Send->Sync[0] = STX;
// 2107 	Send->Sync[1] = STX;
// 2108 	Send->Sync[2] = STX;
// 2109 	Send->Sync[3] = STX;
// 2110 
// 2111 	Send->TryNo= '0';
// 2112 
// 2113 	Send->BodyLen[0] = (INT8U)((nCnt + 9) >> 8);
// 2114 	Send->BodyLen[1] = (INT8U)(nCnt + 9 );
// 2115 
// 2116 	Send->CheckSum = 0;
// 2117 	Send->CheckSum = Send->TryNo + Send->BodyLen[0] + Send->BodyLen[1];
// 2118 	
// 2119 	Send->BodyFrame[BodyNo].SubID[0] = tid[0];
// 2120 	Send->BodyFrame[BodyNo].SubID[1] = tid[1];
// 2121 	Send->BodyFrame[BodyNo].SubID[2] = tid[2];
// 2122 	
// 2123 	Send->BodyFrame[BodyNo].Command = Comm;
// 2124 
// 2125 	Send->BodyFrame[BodyNo].RCode = __DUO_LIF;
// 2126 
// 2127 
// 2128 	Send->BodyFrame[BodyNo].SubLen[0] = (INT8U)((nCnt) >> 8);
// 2129 	Send->BodyFrame[BodyNo].SubLen[1] = (INT8U)((nCnt) >> 0);
// 2130 
// 2131 	for(i = 0 ; i < nCnt && i < SMS_BODYSIZEMAX; i++)
// 2132 	{
// 2133 		Send->BodyFrame[BodyNo].SubData[DataCnt++] = Data[i];
// 2134 	}
// 2135 	///////////// CRC //
// 2136 	{ 
// 2137 		Send->BodyFrame[BodyNo].Crc = Crc16Calc ((INT8U *)Send->BodyFrame[BodyNo].SubID, 7 + i, NULL);
// 2138 		Send->BodyFrame[BodyNo].SubData[DataCnt++] = (INT8U)(Send->BodyFrame[BodyNo].Crc >> 8);
// 2139 		Send->BodyFrame[BodyNo].SubData[DataCnt++] = (INT8U)(Send->BodyFrame[BodyNo].Crc 	);
// 2140 	}
// 2141 	Send->BodyFrame[BodyNo].SubData[DataCnt++] = 0x03;
// 2142 
// 2143 
// 2144 	BcMdemTCPTx((char *)Send, 8 + 7 + DataCnt);
// 2145 
// 2146 	return TRUE;
// 2147 }
// 2148 
// 2149 
// 2150 INT32U DnrAlarmCheckUpdate(INT8U TotMask)
// 2151 {
// 2152 #if 0
// 2153     INT8U	i = 0, j = 0;
// 2154 	INT8U *CurSts = (INT8U *)DnrAlarm;
// 2155 	INT8U *PreSts = (INT8U *)DnrPreAlm;
// 2156 	INT8U *ChangeFlag = (INT8U *)DnrAlmChange;
// 2157 	INT8U *AlarmTimer = (INT8U *)DnrAlmTimer;
// 2158 
// 2159 	INT32U  tCnt = 0;
// 2160 
// 2161 	if(TotMask)
// 2162 	{
// 2163 	//	 for(i = 0; i < sizeof(_DnrAlarm); i++) *PreSts++ = *CurSts++;
// 2164 	 return FALSE;	 // Mask 이면 check 하지 않는다.
// 2165 	}
// 2166 #if 0
// 2167 	for(i = 0; i < sizeof(__LIF_DnrAlarmDataStr); i++)
// 2168 	{
// 2169 		for(j = 0; j < 8; j++)
// 2170 		{
// 2171 			tCnt += UPdateAlarm( CurSts + i,PreSts + i, j
// 2172 							, ChangeFlag + i, NULL
// 2173 							, AlarmTimer + i*8 + j);
// 2174 		}
// 2175 	}
// 2176 #endif	
// 2177 	if(tCnt != 0) return TRUE;
// 2178 #endif    
// 2179 	return FALSE;
// 2180 }
// 2181 
// 2182 #if 0
// 2183 INT8U UPdateAlarm(INT8U *CurSts, INT8U *PreSts, INT8U Bit, INT8U *ChangeFlag, INT8U Mask, INT8U *AlarmTimer)
// 2184 {
// 2185 
// 2186  BitRst(*ChangeFlag, Bit);
// 2187 
// 2188  if( BitRead(*CurSts, Bit) ==  BitRead(*PreSts, Bit))
// 2189  {
// 2190 	 *AlarmTimer = AlmTimerCnt;
// 2191  }
// 2192  else
// 2193  {
// 2194 	 if(*AlarmTimer == 0)
// 2195 	 {
// 2196 		
// 2197 		 if(BitRead(*CurSts, Bit))	 BitSet(*PreSts, Bit);
// 2198 		 else						 BitRst(*PreSts, Bit);
// 2199 		 BitSet(*ChangeFlag, Bit);
// 2200 		 return TRUE;
// 2201 	 }
// 2202 	 else *AlarmTimer = *AlarmTimer - 1;
// 2203  }
// 2204 
// 2205  return FALSE;
// 2206 }
// 2207 #endif
// 2208 
// 2209 
// 2210 void Sms_DnrAlarm_Check(void)
// 2211 {
// 2212 	if(chkDnrAlarmReport == SET)return;
// 2213 	
// 2214 	if(DnrAlarmCheckUpdate(AlarmMask)) chkDnrAlarmReport = SET;
// 2215 }
// 2216  
// 2217 
// 2218 void DonorAlarmUpdate(void)
// 2219 {
// 2220 #if 0
// 2221 	__LIF_DnrAlarmDataStr *DAlarm	= &LIF_DnrSts->Data;
// 2222 	__LIF_DnrAlarmDataStr *CurAlarm = DnrAlarm;
// 2223 	__Dnr_Sts *DSts = tDnrSts;
// 2224 
// 2225 	CurAlarm->Forward.OverInAlarm_3G = DAlarm->Forward.OverInAlarm_3G ;
// 2226 	CurAlarm->Forward.OverInAlarm_2G = DAlarm->Forward.OverInAlarm_2G ;
// 2227 	CurAlarm->Forward.LowInputAlarm_2G = DAlarm->Forward.LowInputAlarm_2G ;
// 2228 	CurAlarm->Forward.LowInputAlarm_3G = DAlarm->Forward.LowInputAlarm_3G ;
// 2229 	CurAlarm->Forward.FwdPllAlarm_2G = DAlarm->Forward.FwdPllAlarm_2G ;
// 2230 	CurAlarm->Forward.FwdPllAlarm_3G = DAlarm->Forward.FwdPllAlarm_3G ;
// 2231 
// 2232 	CurAlarm->Reverse.RvsOscAlarm_3G = DAlarm->Reverse.RvsOscAlarm_3G ;
// 2233 	CurAlarm->Reverse.RvsOscAlarm_2G = DAlarm->Reverse.RvsOscAlarm_2G ;
// 2234 	CurAlarm->Reverse.RvsPllAlarm_3G = DAlarm->Reverse.RvsPllAlarm_3G ;
// 2235 	CurAlarm->Reverse.RvsPllAlarm_2G = DAlarm->Reverse.RvsPllAlarm_2G ;
// 2236 
// 2237 	CurAlarm->PowerAmp.FwdAmpOff_3G = DAlarm->PowerAmp.FwdAmpOff_3G ;
// 2238 	CurAlarm->PowerAmp.FwdAmpOff_Common = DAlarm->PowerAmp.FwdAmpOff_2G ;
// 2239 
// 2240 	CurAlarm->PowerAmp.RvsAmpOnOff_3G = DAlarm->PowerAmp.RvsAmpOnOff_3G ;
// 2241 	CurAlarm->PowerAmp.RvsAmpOnOff_2G = DAlarm->PowerAmp.RvsAmpOnOff_2G ;
// 2242 
// 2243 
// 2244 	CurAlarm->Etc.GPS_Status = DAlarm->Etc.GPS_Status ;
// 2245 	CurAlarm->Etc.GPS_LinkFail = DAlarm->Etc.GPS_LinkFail ;
// 2246 	CurAlarm->Etc.BandSelect_3G = DAlarm->Etc.BandSelect_3G ;
// 2247 	CurAlarm->Etc.BandSelect_2G = DAlarm->Etc.BandSelect_2G ;
// 2248 	CurAlarm->Etc.ModemLinkFail = DAlarm->Etc.ModemLinkFail ;
// 2249 #endif	
// 2250 }
// 2251  
// 2252 
// 2253 
// 2254 void SmsAlarm(void)
// 2255 {
// 2256 	INT8U nRet ;
// 2257     INT8U tid[3] = {0xff, 0xff, 0xff};
// 2258 
// 2259 	if(chkDnrAlarmReport == SET)
// 2260 	{
// 2261 		nRet = DnrAlarmReport(SmsSer);
// 2262 		if(nRet > 0)
// 2263 		{
// 2264 			SmsDataAckTx(tid, (INT8U *)DnrAlarmBuff, nRet, AlarmSCODE,SmsSer);
// 2265 		}
// 2266 		chkDnrAlarmReport = RESET;
// 2267 		DnrAlarmSndCnt = 0;
// 2268 	}
// 2269 }
// 2270 
// 2271 INT8U DnrAlarmReport(__ProtocolPtr *nPtr )
// 2272 {
// 2273 
// 2274     INT8U DataCnt = 0;
// 2275 #if 0
// 2276 	__DnrAlarmDataStr *CurAlarm = DnrAlarm;
// 2277 	__Dnr_Sts  *Sts = tDnrSts;	
// 2278 
// 2279 
// 2280 	if(DnrAlmChange->FwdInUpperLmtFail_3G)
// 2281 	{
// 2282 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_OverIn_3G);
// 2283 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_OverIn_3G);
// 2284 
// 2285 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdInUpperLmtFail_3G;
// 2286 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2287 	}
// 2288 
// 2289 	
// 2290 	if(DnrAlmChange->FwdOutUpperLmtFail_3G)
// 2291 	{
// 2292 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_3G);
// 2293 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_3G);
// 2294 
// 2295 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutUpperLmtFail_3G;
// 2296 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2297 	}
// 2298 
// 2299 	if(DnrAlmChange->FwdOutLowerLmtFail_3G)
// 2300 	{
// 2301 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_3G);
// 2302 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_3G);
// 2303 
// 2304 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutLowerLmtFail_3G;
// 2305 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2306 	}
// 2307 
// 2308 	if(DnrAlmChange->OverInAlarm_3G)
// 2309 	{
// 2310 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOtherOverIn_3G);
// 2311 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOtherOverIn_3G);
// 2312 
// 2313 		DnrAlarmBuff[DataCnt++] = CurAlarm->OverInAlarm_3G;
// 2314 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2315 	}
// 2316 
// 2317 	///////////////////////////// Fwd 2G
// 2318 	if(DnrAlmChange->FwdInUpperLmtFail_2G)
// 2319 	{
// 2320 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_OverIn_2G);
// 2321 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_OverIn_2G);
// 2322 
// 2323 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdInUpperLmtFail_2G;
// 2324 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2325 	}
// 2326 
// 2327 
// 2328 	if(DnrAlmChange->FwdOutUpperLmtFail_2G)
// 2329 	{
// 2330 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_2G);
// 2331 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_2G);
// 2332 
// 2333 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutUpperLmtFail_2G;
// 2334 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2335 	}
// 2336 
// 2337 	if(DnrAlmChange->FwdOutLowerLmtFail_2G)
// 2338 	{
// 2339 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_2G);
// 2340 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_2G);
// 2341 
// 2342 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutLowerLmtFail_2G;
// 2343 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2344 	}
// 2345 
// 2346 ///////////////////////////////////LTE
// 2347 	if(DnrAlmChange->FwdInUpperLmtFail_LTE)
// 2348 	{
// 2349 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_OverIn_LTE);
// 2350 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_OverIn_LTE);
// 2351 
// 2352 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdInUpperLmtFail_LTE;
// 2353 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2354 	}
// 2355 
// 2356 
// 2357 	if(DnrAlmChange->FwdOutUpperLmtFail_LTE)
// 2358 	{
// 2359 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE);
// 2360 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE);
// 2361 
// 2362 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutUpperLmtFail_LTE;
// 2363 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2364 	}
// 2365 
// 2366 	if(DnrAlmChange->FwdOutLowerLmtFail_LTE)
// 2367 	{
// 2368 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE);
// 2369 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE);
// 2370 
// 2371 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutLowerLmtFail_LTE;
// 2372 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2373 	}
// 2374 
// 2375 	if(DnrAlmChange->OverInAlarm_Common)
// 2376 	{
// 2377 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOtherOverIn_Common);
// 2378 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOtherOverIn_Common);
// 2379 
// 2380 		DnrAlarmBuff[DataCnt++] = CurAlarm->OverInAlarm_Common;
// 2381 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2382 	}
// 2383 
// 2384 ///////////////////////////////////LTE_A
// 2385 	if(DnrAlmChange->FwdInUpperLmtFail_LTE_A)
// 2386 	{
// 2387 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_OverIn_LTE_A);
// 2388 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_OverIn_LTE_A);
// 2389 
// 2390 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdInUpperLmtFail_LTE_A;
// 2391 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2392 	}
// 2393 
// 2394 
// 2395 	if(DnrAlmChange->FwdOutUpperLmtFail_LTE_A)
// 2396 	{
// 2397 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE_A);
// 2398 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE_A);
// 2399 
// 2400 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutUpperLmtFail_LTE_A;
// 2401 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2402 	}
// 2403 
// 2404 	if(DnrAlmChange->FwdOutLowerLmtFail_LTE_A)
// 2405 	{
// 2406 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE_A);
// 2407 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE_A);
// 2408 
// 2409 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutLowerLmtFail_LTE_A;
// 2410 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2411 	}
// 2412 
// 2413 	if(DnrAlmChange->OverInAlarm_LTE_A)
// 2414 	{
// 2415 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdOtherOverIn_LTE_A);
// 2416 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdOtherOverIn_LTE_A);
// 2417 
// 2418 		DnrAlarmBuff[DataCnt++] = CurAlarm->OverInAlarm_LTE_A;
// 2419 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2420 	}
// 2421 
// 2422 	////////////
// 2423 	if(DnrAlmChange->FwdPllFail_3G)
// 2424 	{
// 2425 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdPllAlarm_3G);
// 2426 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdPllAlarm_3G);
// 2427 
// 2428 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdPllFail_3G;
// 2429 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2430 	}
// 2431 
// 2432 	if(DnrAlmChange->FwdPllFail_Common)
// 2433 	{
// 2434 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdPllAlarm_Common);
// 2435 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdPllAlarm_Common);
// 2436 
// 2437 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdPllFail_Common;
// 2438 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2439 	}
// 2440 
// 2441 
// 2442 	if(DnrAlmChange->FwdPllFail_LTE_A)
// 2443 	{
// 2444 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdPllAlarm_LTE_A);
// 2445 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdPllAlarm_LTE_A);
// 2446 
// 2447 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdPllFail_LTE_A;
// 2448 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2449 	}
// 2450 
// 2451 	if(DnrAlmChange->Fwd1PllFail_LTE)
// 2452 	{
// 2453 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Fwd1PllAlarm_LTE);
// 2454 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Fwd1PllAlarm_LTE);
// 2455 
// 2456 		DnrAlarmBuff[DataCnt++] = CurAlarm->Fwd1PllFail_LTE;
// 2457 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2458 	}
// 2459 
// 2460 
// 2461 	if(DnrAlmChange->Fwd1PllFail_LTE_A)
// 2462 	{
// 2463 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Fwd1PllAlarm_LTE_A);
// 2464 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Fwd1PllAlarm_LTE_A);
// 2465 
// 2466 		DnrAlarmBuff[DataCnt++] = CurAlarm->Fwd1PllFail_LTE_A;
// 2467 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2468 	}
// 2469 
// 2470 ///////////////////////////////////////
// 2471 	if(DnrAlmChange->RvsPllFail_3G)
// 2472 	{
// 2473 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_RvsPllAlarm_3G);
// 2474 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_RvsPllAlarm_3G);
// 2475 
// 2476 		DnrAlarmBuff[DataCnt++] = CurAlarm->RvsPllFail_3G;
// 2477 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2478 	}
// 2479 
// 2480 	if(DnrAlmChange->RvsPllFail_Common)
// 2481 	{
// 2482 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_RvsPllAlarm_Common);
// 2483 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_RvsPllAlarm_Common);
// 2484 
// 2485 		DnrAlarmBuff[DataCnt++] = CurAlarm->RvsPllFail_Common;
// 2486 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2487 	}
// 2488 
// 2489 
// 2490 	if(DnrAlmChange->RvsPllFail_LTE_A)
// 2491 	{
// 2492 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_RvsPllAlarm_LTE_A);
// 2493 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_RvsPllAlarm_LTE_A);
// 2494 
// 2495 		DnrAlarmBuff[DataCnt++] = CurAlarm->RvsPllFail_LTE_A;
// 2496 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2497 	}
// 2498 
// 2499 	if(DnrAlmChange->Rvs1PllFail_LTE)
// 2500 	{
// 2501 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Rvs1PllAlarm_LTE);
// 2502 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Rvs1PllAlarm_LTE);
// 2503 
// 2504 		DnrAlarmBuff[DataCnt++] = CurAlarm->Rvs1PllFail_LTE;
// 2505 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2506 	}
// 2507 
// 2508 
// 2509 	if(DnrAlmChange->Rvs1PllFail_LTE_A)
// 2510 	{
// 2511 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Rvs1PllAlarm_LTE_A);
// 2512 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Rvs1PllAlarm_LTE_A);
// 2513 
// 2514 		DnrAlarmBuff[DataCnt++] = CurAlarm->Rvs1PllFail_LTE_A;
// 2515 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2516 	}
// 2517 ////////////////////////////////////// RVS
// 2518 
// 2519 	if(DnrAlmChange->RvsOutUpperLmtFail_3G)
// 2520 	{
// 2521 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_RvsOscilation_3G);
// 2522 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_RvsOscilation_3G);
// 2523 
// 2524 		DnrAlarmBuff[DataCnt++] = CurAlarm->RvsOutUpperLmtFail_3G;
// 2525 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2526 	}
// 2527 
// 2528 	if(DnrAlmChange->RvsOutUpperLmtFail_2G)
// 2529 	{
// 2530 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_RvsOscilation_2G);
// 2531 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_RvsOscilation_2G);
// 2532 
// 2533 		DnrAlarmBuff[DataCnt++] = CurAlarm->RvsOutUpperLmtFail_2G;
// 2534 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2535 	}
// 2536 
// 2537 	if(DnrAlmChange->RvsOutUpperLmtFail_LTE)
// 2538 	{
// 2539 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_RvsOscilation_LTE);
// 2540 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_RvsOscilation_LTE);
// 2541 
// 2542 		DnrAlarmBuff[DataCnt++] = CurAlarm->RvsOutUpperLmtFail_LTE;
// 2543 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2544 	}
// 2545 
// 2546 	if(DnrAlmChange->RvsOutUpperLmtFail_LTE_A)
// 2547 	{
// 2548 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_RvsOscilation_LTE_A);
// 2549 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_RvsOscilation_LTE_A);
// 2550 
// 2551 		DnrAlarmBuff[DataCnt++] = CurAlarm->RvsOutUpperLmtFail_LTE_A;
// 2552 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2553 	}
// 2554 
// 2555 	if(DnrAlmChange->Rvs1OutUpperLmtFail_LTE)
// 2556 	{
// 2557 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Rvs1Oscilation_LTE);
// 2558 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Rvs1Oscilation_LTE);
// 2559 
// 2560 		DnrAlarmBuff[DataCnt++] = CurAlarm->Rvs1OutUpperLmtFail_LTE;
// 2561 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2562 	}
// 2563 
// 2564 	if(DnrAlmChange->Rvs1OutUpperLmtFail_LTE_A)
// 2565 	{
// 2566 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Rvs1Oscilation_LTE_A);
// 2567 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Rvs1Oscilation_LTE_A);
// 2568 
// 2569 		DnrAlarmBuff[DataCnt++] = CurAlarm->Rvs1OutUpperLmtFail_LTE_A;
// 2570 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2571 	}
// 2572 
// 2573 //////
// 2574 
// 2575 	if(DnrAlmChange->FwdAmpOff_3G)	
// 2576 	{
// 2577 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdAmpOnOff_3G);
// 2578 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdAmpOnOff_3G);
// 2579 		if(CurAlarm->FwdAmpOff_3G)	DnrAlarmBuff[DataCnt++] = 0x01;
// 2580 		else						DnrAlarmBuff[DataCnt++] = 0x00;
// 2581 
// 2582 		DnrAlarmBuff[DataCnt++] = 0x01; 									// Lenght
// 2583 		DnrAlarmBuff[DataCnt++] = Sts->AmpOffCase_3G;
// 2584 	}	
// 2585 
// 2586 
// 2587 	if(DnrAlmChange->FwdAmpOff_Common)	
// 2588 	{
// 2589 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdAmpOnOff_Common);
// 2590 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdAmpOnOff_Common);
// 2591 		if(CurAlarm->FwdAmpOff_Common)	DnrAlarmBuff[DataCnt++] = 0x01;
// 2592 		else						DnrAlarmBuff[DataCnt++] = 0x00;
// 2593 
// 2594 		DnrAlarmBuff[DataCnt++] = 0x01; 									// Lenght
// 2595 		DnrAlarmBuff[DataCnt++] = Sts->AmpOffCase_Common;
// 2596 	}	
// 2597 
// 2598 	if(DnrAlmChange->FwdAmpOff_LTE_A)	
// 2599 	{
// 2600 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdAmpOnOff_LTE_A);
// 2601 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdAmpOnOff_LTE_A);
// 2602 		if(CurAlarm->FwdAmpOff_LTE_A)	DnrAlarmBuff[DataCnt++] = 0x01;
// 2603 		else						DnrAlarmBuff[DataCnt++] = 0x00;
// 2604 
// 2605 		DnrAlarmBuff[DataCnt++] = 0x01; 									// Lenght
// 2606 		DnrAlarmBuff[DataCnt++] = Sts->AmpOffCase_LTE_A;
// 2607 	}	
// 2608 
// 2609 
// 2610 
// 2611 	if(DnrAlmChange->Fwd1AmpOff_LTE)	
// 2612 	{
// 2613 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdAmp1OnOff_LTE);
// 2614 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdAmp1OnOff_LTE);
// 2615 		if(CurAlarm->Fwd1AmpOff_LTE)	DnrAlarmBuff[DataCnt++] = 0x01;
// 2616 		else							DnrAlarmBuff[DataCnt++] = 0x00;
// 2617 
// 2618 		DnrAlarmBuff[DataCnt++] = 0x01; 									// Lenght
// 2619 		DnrAlarmBuff[DataCnt++] = Sts->Amp1OffCase_LTE;
// 2620 	}	
// 2621 
// 2622 	if(DnrAlmChange->Fwd1AmpOff_LTE_A)	
// 2623 	{
// 2624 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_FwdAmp1OnOff_LTE_A);
// 2625 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_FwdAmp1OnOff_LTE_A);
// 2626 		if(CurAlarm->Fwd1AmpOff_LTE_A)	DnrAlarmBuff[DataCnt++] = 0x01;
// 2627 		else						DnrAlarmBuff[DataCnt++] = 0x00;
// 2628 
// 2629 		DnrAlarmBuff[DataCnt++] = 0x01; 									// Lenght
// 2630 		DnrAlarmBuff[DataCnt++] = Sts->Amp1OffCase_LTE_A;
// 2631 	}	
// 2632 ////////////////////////////
// 2633 
// 2634 	if(DnrAlmChange->ACFail)	
// 2635 	{
// 2636 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_ACFail);
// 2637 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_ACFail);
// 2638 		if(CurAlarm->ACFail)	DnrAlarmBuff[DataCnt++] = 0x01;
// 2639 		else					DnrAlarmBuff[DataCnt++] = 0x00;
// 2640 
// 2641 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2642 	}	
// 2643 
// 2644 ///////////////////////////////////LTE
// 2645 	if(DnrAlmChange->Fwd1InUpperLmtFail_LTE)
// 2646 	{
// 2647 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_OverIn_LTE);
// 2648 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_OverIn_LTE);
// 2649 
// 2650 		DnrAlarmBuff[DataCnt++] = CurAlarm->Fwd1InUpperLmtFail_LTE;
// 2651 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2652 	}
// 2653 
// 2654 
// 2655 	if(DnrAlmChange->Fwd1OutUpperLmtFail_LTE)
// 2656 	{
// 2657 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Fwd1OutUpperLmt_LTE);
// 2658 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Fwd1OutUpperLmt_LTE);
// 2659 
// 2660 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutUpperLmtFail_LTE;
// 2661 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2662 	}
// 2663 
// 2664 	if(DnrAlmChange->Fwd1OutLowerLmtFail_LTE)
// 2665 	{
// 2666 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Fwd1OutLowerLmt_LTE);
// 2667 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Fwd1OutLowerLmt_LTE);
// 2668 
// 2669 		DnrAlarmBuff[DataCnt++] = CurAlarm->Fwd1OutLowerLmtFail_LTE;
// 2670 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2671 	}
// 2672 	
// 2673 	///////////////////////////////////LTE
// 2674 	if(DnrAlmChange->Fwd1InUpperLmtFail_LTE_A)
// 2675 	{
// 2676 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_OverIn_LTE);
// 2677 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_OverIn_LTE);
// 2678 
// 2679 		DnrAlarmBuff[DataCnt++] = CurAlarm->Fwd1InUpperLmtFail_LTE_A;
// 2680 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2681 	}
// 2682 
// 2683 
// 2684 	if(DnrAlmChange->Fwd1OutUpperLmtFail_LTE_A)
// 2685 	{
// 2686 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Fwd1OutUpperLmt_LTE_A);
// 2687 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Fwd1OutUpperLmt_LTE_A);
// 2688 
// 2689 		DnrAlarmBuff[DataCnt++] = CurAlarm->FwdOutUpperLmtFail_LTE_A;
// 2690 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2691 	}
// 2692 
// 2693 	if(DnrAlmChange->Fwd1OutLowerLmtFail_LTE_A)
// 2694 	{
// 2695 		DnrAlarmBuff[DataCnt++] = hibyte(Aid_Fwd1OutLowerLmt_LTE_A);
// 2696 		DnrAlarmBuff[DataCnt++] = lobyte(Aid_Fwd1OutLowerLmt_LTE_A);
// 2697 
// 2698 		DnrAlarmBuff[DataCnt++] = CurAlarm->Fwd1OutLowerLmtFail_LTE_A;
// 2699 		DnrAlarmBuff[DataCnt++] = 0x00;
// 2700 	}
// 2701 	/////////////////// 필수 항목 /////////////////////////////////////
// 2702 #if 1
// 2703 	if(DataCnt)
// 2704 	{
// 2705 		DnrAlarmBuff[DataCnt++] = 0xff;					// A_ID
// 2706 		DnrAlarmBuff[DataCnt++] = 0xff;
// 2707 		DnrAlarmBuff[DataCnt++] = 0x04; 					// len
// 2708 		
// 2709 
// 2710 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[0]);
// 2711 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[1]);
// 2712 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[0]);
// 2713 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[1]);
// 2714 
// 2715 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[0]);
// 2716 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[1]);
// 2717 
// 2718 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A[0]);
// 2719 		DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A[1]);
// 2720 
// 2721 		if(iRepeaterType == _TRIO_MM)
// 2722 		{
// 2723 			DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE[0]);
// 2724 			DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE[1]);
// 2725 
// 2726 			DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A[0]);
// 2727 			DnrAlarmBuff[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A[1]);
// 2728 		}
// 2729 	}
// 2730 #endif	
// 2731 #endif    
// 2732 	return(DataCnt);
// 2733 }
// 2734  
// 2735 
// 2736 void SmsInform(void)
// 2737 {
// 2738 	__Dnr_Sts *Sts = tDnrSts;
// 2739 
// 2740  	Sts->MobileManufacture = __SAT;
// 2741 	Sts->MobileModel = SMCM_S801C;
// 2742 
// 2743  	Sts->PhoneVersion_H = atoh(BcMVerNum[0]);
// 2744 	Sts->PhoneVersion_L = atoh(BcMVerNum[1])*10 + atoh(BcMVerNum[2]);
// 2745 }
// 2746 
// 2747 
// 2748 
// 2749 INT16U GenSmsDnrAidSts(INT8U *dptr, __Dnr_Sts *Sts)
// 2750 {
// 2751 	INT16U rlen = 0;
// 2752 	INT16U i = 0;
// 2753 	
// 2754 #if 1
// 2755 	dptr[rlen++] = Sts->Alm.Data[0];
// 2756 	dptr[rlen++] = Sts->Alm.Data[1];
// 2757 	dptr[rlen++] = Sts->Alm.Data[2];
// 2758 	dptr[rlen++] = Sts->Alm.Data[3];
// 2759 	dptr[rlen++] = Sts->Alm.Data[4];
// 2760 	dptr[rlen++] = Sts->Alm.Data[5];
// 2761 	dptr[rlen++] = Sts->Alm.Data[6];
// 2762 	dptr[rlen++] = Sts->Alm.Data[7];
// 2763 	dptr[rlen++] = Sts->Alm.Data[8];
// 2764 
// 2765 	dptr[rlen++] = Sts->Manufacture;
// 2766 	dptr[rlen++] = Sts->Supplier;
// 2767 	dptr[rlen++] = Sts->RepeaterType[0];
// 2768 	dptr[rlen++] = Sts->RepeaterType[1];
// 2769 	dptr[rlen++] = Sts->SWVer;
// 2770 	dptr[rlen++] = Sts->MobileManufacture;
// 2771 	dptr[rlen++] = Sts->MobileModel;
// 2772 	dptr[rlen++] = Sts->PhoneVersion_H;
// 2773 	dptr[rlen++] = Sts->PhoneVersion_L;
// 2774 	
// 2775 	dptr[rlen++] = Sts->FwdOutPwr_3G[0];
// 2776 	dptr[rlen++] = Sts->FwdOutPwr_3G[1];
// 2777 	dptr[rlen++] = Sts->FwdOutUpperLmt_3G[0];
// 2778 	dptr[rlen++] = Sts->FwdOutUpperLmt_3G[1];
// 2779 	dptr[rlen++] = Sts->FwdOutLowerLmt_3G[0];
// 2780 	dptr[rlen++] = Sts->FwdOutLowerLmt_3G[1];	
// 2781 	dptr[rlen++] = Sts->FwdGainSet_3G;
// 2782 	dptr[rlen++] = Sts->FwdGain_3G;
// 2783 	dptr[rlen++] = Sts->FwdOutPwr_2G[0];
// 2784 	dptr[rlen++] = Sts->FwdOutPwr_2G[1];
// 2785 	dptr[rlen++] = Sts->FwdOutUpperLmt_2G[0];
// 2786 	dptr[rlen++] = Sts->FwdOutUpperLmt_2G[1];
// 2787 	dptr[rlen++] = Sts->FwdOutLowerLmt_2G[0];
// 2788 	dptr[rlen++] = Sts->FwdOutLowerLmt_2G[1];
// 2789 	dptr[rlen++] = Sts->FwdGainSet_2G;
// 2790 	dptr[rlen++] = Sts->FwdGain_2G;
// 2791 
// 2792 
// 2793 	dptr[rlen++] = Sts->Rvs0GainSet_3G;
// 2794 	dptr[rlen++] = Sts->RvsGainSts_3G;
// 2795 	dptr[rlen++] = Sts->RvsGainBalance_3G;
// 2796 	dptr[rlen++] = Sts->Rvs0GainSet_2G;
// 2797 	dptr[rlen++] = Sts->RvsGainSts_2G;
// 2798 	dptr[rlen++] = Sts->RvsGainBalance_2G;
// 2799 
// 2800 	dptr[rlen++] = Sts->AGCOnOff_3G;
// 2801 	dptr[rlen++] = Sts->AGCOnOff_2G;
// 2802 
// 2803 	dptr[rlen++] = 0;
// 2804 	dptr[rlen++] = 0;
// 2805 	dptr[rlen++] = Sts->AGCMode_3G;
// 2806 	dptr[rlen++] = Sts->AGCMode_2G;
// 2807 	
// 2808 	dptr[rlen++] = Sts->AmpOffCase_3G;
// 2809 	dptr[rlen++] = Sts->AmpOffCase_Common;
// 2810 	dptr[rlen++] = Sts->AmpOffCase_LTE_A;
// 2811 	dptr[rlen++] = Sts->BandSelect_15M;
// 2812 	dptr[rlen++] = Sts->Repeat_Reset;
// 2813 
// 2814 	if(iRepeaterType == _TRIO_M)
// 2815 	{
// 2816 		for(i = 0; i < 14; i++)
// 2817 		{
// 2818 			dptr[rlen++] = 0;
// 2819 		}
// 2820 	}
// 2821 	else
// 2822 	{
// 2823 		dptr[rlen++] = 0;
// 2824 		dptr[rlen++] = 0;
// 2825 		dptr[rlen++] = 0;
// 2826 		dptr[rlen++] = 0;
// 2827 
// 2828 #ifdef _MIMO_Type         
// 2829 		dptr[rlen++] = Sts->Fwd1OutPwr_LTE[0];
// 2830 		dptr[rlen++] = Sts->Fwd1OutPwr_LTE[1];
// 2831 		dptr[rlen++] = Sts->Fwd1OutUpperLmt_LTE[0];
// 2832 		dptr[rlen++] = Sts->Fwd1OutUpperLmt_LTE[1];
// 2833 		dptr[rlen++] = Sts->FwdGainSet_LTE;
// 2834 		dptr[rlen++] = Sts->FwdGain_LTE;
// 2835 		dptr[rlen++] = Sts->Rvs0GainSet_LTE;
// 2836 		dptr[rlen++] = Sts->RvsGainSts_LTE;
// 2837 		dptr[rlen++] = Sts->RvsGainBalance_LTE;
// 2838 		dptr[rlen++] = Sts->Amp1OffCase_LTE_A;
// 2839 #endif        
// 2840 	}
// 2841 
// 2842 	dptr[rlen++] = Sts->AutoReportPriod;
// 2843 	dptr[rlen++] = Sts->AutoReportTime_H;
// 2844 	dptr[rlen++] = Sts->AutoReportTime_M;
// 2845 	dptr[rlen++] = Sts->PresentHour;
// 2846 	dptr[rlen++] = Sts->PresentMin;
// 2847 
// 2848 #endif	
// 2849  	return rlen;
// 2850 }
// 2851 
// 2852 
// 2853 INT16U GenSmsDnrAid_Sts(INT8U *dptr, __Dnr_Sts *Sts)
// 2854 {
// 2855 	INT16U rlen = 0;
// 2856 	INT16U i = 0;
// 2857 	
// 2858 #if 1
// 2859 	dptr[rlen++] = Sts->Alm.Data[0];
// 2860 	dptr[rlen++] = Sts->Alm.Data[1];
// 2861 	dptr[rlen++] = Sts->Alm.Data[2];
// 2862 	dptr[rlen++] = Sts->Alm.Data[3];
// 2863 	dptr[rlen++] = Sts->Alm.Data[4];
// 2864 	dptr[rlen++] = Sts->Alm.Data[5];
// 2865 	dptr[rlen++] = Sts->Alm.Data[6];
// 2866 	dptr[rlen++] = Sts->Alm.Data[7];
// 2867 	dptr[rlen++] = Sts->Alm.Data[8];
// 2868 
// 2869 	dptr[rlen++] = Sts->Manufacture;
// 2870 	dptr[rlen++] = Sts->Supplier;
// 2871 	dptr[rlen++] = Sts->RepeaterType[0];
// 2872 	dptr[rlen++] = Sts->RepeaterType[1];
// 2873 	dptr[rlen++] = Sts->SWVer;
// 2874 	dptr[rlen++] = Sts->MobileManufacture;
// 2875 	dptr[rlen++] = Sts->MobileModel;
// 2876 	dptr[rlen++] = Sts->PhoneVersion_H;
// 2877 	dptr[rlen++] = Sts->PhoneVersion_L;
// 2878 	
// 2879 	dptr[rlen++] = Sts->FwdOutPwr_LTE[0];
// 2880 	dptr[rlen++] = Sts->FwdOutPwr_LTE[1];
// 2881 	dptr[rlen++] = Sts->FwdOutUpperLmt_LTE[0];
// 2882 	dptr[rlen++] = Sts->FwdOutUpperLmt_LTE[1];
// 2883 	dptr[rlen++] = Sts->FwdOutLowerLmt_LTE[0];
// 2884 	dptr[rlen++] = Sts->FwdOutLowerLmt_LTE[1];	
// 2885 	dptr[rlen++] = Sts->FwdGainSet_LTE;
// 2886 	dptr[rlen++] = Sts->FwdGain_LTE;
// 2887 	dptr[rlen++] = Sts->FwdOutPwr_LTE_A[0];
// 2888 	dptr[rlen++] = Sts->FwdOutPwr_LTE_A[1];
// 2889 	dptr[rlen++] = Sts->FwdOutUpperLmt_LTE_A[0];
// 2890 	dptr[rlen++] = Sts->FwdOutUpperLmt_LTE_A[1];
// 2891 	dptr[rlen++] = Sts->FwdOutLowerLmt_LTE_A[0];
// 2892 	dptr[rlen++] = Sts->FwdOutLowerLmt_LTE_A[1];
// 2893 	dptr[rlen++] = Sts->FwdGainSet_LTE_A;
// 2894 	dptr[rlen++] = Sts->FwdGain_LTE_A;
// 2895 
// 2896 
// 2897 	dptr[rlen++] = Sts->Rvs0GainSet_LTE;
// 2898 	dptr[rlen++] = Sts->RvsGainSts_LTE;
// 2899 	dptr[rlen++] = Sts->RvsGainBalance_LTE;
// 2900 	dptr[rlen++] = Sts->Rvs0GainSet_LTE_A;
// 2901 	dptr[rlen++] = Sts->RvsGainSts_LTE_A;
// 2902 	dptr[rlen++] = Sts->RvsGainBalance_LTE_A;
// 2903 
// 2904 	dptr[rlen++] = Sts->AGCOnOff_LTE;
// 2905 	dptr[rlen++] = Sts->AGCOnOff_LTE_A;
// 2906 
// 2907 	dptr[rlen++] = 0;
// 2908 	dptr[rlen++] = 0;
// 2909 	dptr[rlen++] = Sts->AGCMode_LTE;
// 2910 	dptr[rlen++] = Sts->AGCMode_LTE_A;
// 2911 	
// 2912 	dptr[rlen++] = Sts->AmpOffCase_3G;
// 2913 	dptr[rlen++] = Sts->AmpOffCase_Common;
// 2914 	dptr[rlen++] = Sts->AmpOffCase_LTE_A;
// 2915 	dptr[rlen++] = Sts->BandSelect_15M;
// 2916 	dptr[rlen++] = Sts->Repeat_Reset;
// 2917 
// 2918 	if(iRepeaterType == _TRIO_M)
// 2919 	{
// 2920 		for(i = 0; i < 14; i++)
// 2921 		{
// 2922 			dptr[rlen++] = 0;
// 2923 		}
// 2924 	}
// 2925 	else
// 2926 	{
// 2927 		dptr[rlen++] = 0;
// 2928 		dptr[rlen++] = 0;
// 2929 		dptr[rlen++] = 0;
// 2930 		dptr[rlen++] = 0;
// 2931 
// 2932 #ifdef _MIMO_Type         
// 2933 		dptr[rlen++] = Sts->Fwd1OutPwr_LTE_A[0];
// 2934 		dptr[rlen++] = Sts->Fwd1OutPwr_LTE_A[1];
// 2935 		dptr[rlen++] = Sts->Fwd1OutUpperLmt_LTE_A[0];
// 2936 		dptr[rlen++] = Sts->Fwd1OutUpperLmt_LTE_A[1];
// 2937 		dptr[rlen++] = Sts->Fwd1GainSet_LTE_A;
// 2938 		dptr[rlen++] = Sts->Fwd1Gain_LTE_A;
// 2939 		dptr[rlen++] = Sts->Rvs1GainSet_LTE_A;
// 2940 		dptr[rlen++] = Sts->Rvs1GainSts_LTE_A;
// 2941 		dptr[rlen++] = Sts->Rvs1GainBalance_LTE_A;
// 2942 		dptr[rlen++] = Sts->Amp1OffCase_LTE_A;
// 2943 #endif        
// 2944 	}
// 2945 
// 2946 
// 2947 	dptr[rlen++] = Sts->AutoReportPriod;
// 2948 	dptr[rlen++] = Sts->AutoReportTime_H;
// 2949 	dptr[rlen++] = Sts->AutoReportTime_M;
// 2950 	dptr[rlen++] = Sts->PresentHour;
// 2951 	dptr[rlen++] = Sts->PresentMin;
// 2952 
// 2953 #endif	
// 2954  	return rlen;
// 2955 }
// 2956 
// 2957 
// 2958 INT8U RetNormaltoSMSData(INT8S Data)
// 2959 {
// 2960 	INT8S rVal = 0;
// 2961 
// 2962 	if(Data < 0)
// 2963 	{
// 2964 		rVal = -Data;
// 2965 		BitSet(rVal, 6);
// 2966 	}
// 2967 	else rVal = Data;
// 2968 	
// 2969 	return rVal;
// 2970 }
// 2971 
// 2972 unsigned long int pPrintf( const char *format, ...)
// 2973 {
// 2974     INT8U tid[3] = {0x00, 0xff, 0xff};
// 2975 
// 2976 	va_list argptr;	
// 2977 	va_start(argptr, format);
// 2978 	vsprintf((char *)TxCdmaData, format, argptr);
// 2979 	va_end( argptr );
// 2980 
// 2981 	SmsDataAckTx(tid, (INT8U *)TxCdmaData, strlen((const char *)TxCdmaData), 0x88,SmsSer);
// 2982 
// 2983   	return FALSE;
// 2984 }
// 2985 
// 2986 	
// 2987 INT16U GenWaveCtrlAidSts(INT8U *dptr, _WaveCtrl *Sts)
// 2988 {
// 2989 	INT16U rlen = 0;
// 2990 //	INT16U i = 0;
// 2991 //	__Dnr_Sts *Sts = tDnrSts;
// 2992 
// 2993 //	INT16U i = 0;
// 2994 
// 2995 	rlen += GenAidData(Aid_RxMaxVal,			(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->RxMaxVal, sizeof(WaveCtrl->RxMaxVal));
// 2996 	rlen += GenAidData(Aid_RxMinVal,			(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->RxMinVal, sizeof(WaveCtrl->RxMinVal));
// 2997 	rlen += GenAidData(Aid_TxMaxVal,			(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->TxMaxVal, sizeof(WaveCtrl->TxMaxVal));
// 2998 	rlen += GenAidData(Aid_TxMinVal,			(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->TxMinVal, sizeof(WaveCtrl->TxMinVal));
// 2999 	rlen += GenAidData(Aid_AdjMaxVal,			(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->AdjMaxVal, sizeof(WaveCtrl->AdjMaxVal));
// 3000 	rlen += GenAidData(Aid_AdjMinVal,			(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->AdjMinVal, sizeof(WaveCtrl->AdjMinVal));
// 3001 	rlen += GenAidData(Aid_EcIo,				(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->EcIo, sizeof(WaveCtrl->EcIo));
// 3002 	rlen += GenAidData(Aid_AR_Mode,				(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->AR_Mode, sizeof(WaveCtrl->AR_Mode));
// 3003 	rlen += GenAidData(Aid_Radio_ReportTime,	(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->Radio_ReportTime, sizeof(WaveCtrl->Radio_ReportTime));
// 3004 	rlen += GenAidData(Aid_Radio_ReportPeriod,	(INT8U *)&dptr[rlen], (INT8U *)&WaveCtrl->Radio_ReportPeriod, sizeof(WaveCtrl->Radio_ReportPeriod));
// 3005 
// 3006 
// 3007 #if 0
// 3008 	// TestStation
// 3009 	dptr[rlen++] = (Aid_TestStn >> 8) & 0xff;
// 3010 	dptr[rlen++] = (Aid_TestStn >> 0) & 0xff;
// 3011 	dptr[rlen++] = sizeof(Sts->TestStation);
// 3012 	for(i = 0; i < sizeof(Sts->TestStation); i++)
// 3013 		dptr[rlen++] = Sts->TestStation[i];
// 3014 #endif	
// 3015 
// 3016 /*
// 3017 	dptr[rlen++] = (Aid_Tx_Val >> 8) & 0xff;
// 3018 	dptr[rlen++] = (Aid_Tx_Val >> 0) & 0xff;
// 3019 	dptr[rlen++] = 1;
// 3020 	dptr[rlen++] = WaveCtrl->Tx_Val[0];
// 3021 	dptr[rlen++] = WaveCtrl->Tx_Val[1];
// 3022 		
// 3023 */		
// 3024 	return rlen;
// 3025 }
// 3026 
// 3027 
// 3028 
// 3029 
// 3030 #if 0
// 3031 void SendDebug(char *form, ...)
// 3032 {
// 3033     if( Debug_Sms_Mode )
// 3034     {
// 3035         va_list argptr;
// 3036         va_start(argptr, form);
// 3037         m_Tx_Com.Len = vsprintf((char*)m_Tx_Com.data, form, argptr);
// 3038         
// 3039         m_Tx_Com.Type = 0x88;
// 3040         txSettingHeader( &m_Tx_Com, rsTMLPort);
// 3041 
// 3042 		
// 3043 		sprintf((char *)Ptr, "%02x", dataPtr[i]);
// 3044     }    
// 3045 }
// 3046 #endif
// 3047 
// 3048 
// 3049 #endif
// 3050 
// 3051 
// 3052 #endif
// 3053 
// 3054 #if 0
// 3055 unsigned long int pPrintf( const char *format, ...)
// 3056 {
// 3057     INT8U tid[3] = {0x00, 0xff, 0xff};
// 3058 
// 3059 	va_list argptr;	
// 3060 	va_start(argptr, format);
// 3061 	vsprintf((char *)TxCdmaData, format, argptr);
// 3062 	va_end( argptr );
// 3063 
// 3064 	SmsDataAckTx(tid, (INT8U *)TxCdmaData, strlen((const char *)TxCdmaData), 0x88,SmsSer);
// 3065 
// 3066   	return FALSE;
// 3067 }
// 3068 #endif
// 
// 16 512 bytes in section .bss
//    351 bytes in section .data
//    112 bytes in section .rodata
//    590 bytes in section .text
// 
//    590 bytes of CODE  memory
//    112 bytes of CONST memory
// 16 863 bytes of DATA  memory
//
//Errors: none
//Warnings: none
