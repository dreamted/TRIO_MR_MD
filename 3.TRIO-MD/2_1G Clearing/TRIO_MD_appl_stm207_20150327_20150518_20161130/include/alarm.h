
/*********************************************
* File Name          : alarm.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/


////////////////////////////////////////////////////////////////////////////////
#ifdef ALARM_C
	#define _USR_EXT_ALARM
#else
	#define _USR_EXT_ALARM	extern
#endif



typedef struct {
	INT8U OverInAlarm_WCDMALTE_21	; 
	INT8U FwdOutLowerLmtFail_LTE_21 ;
	INT8U FwdOutUpperLmtFail_LTE_21 ;
	INT8U FwdInUpperLmtFail_LTE_21	;
	INT8U FwdOutLowerLmtFail_3G 	;
	INT8U FwdOutUpperLmtFail_3G 	;
	INT8U FwdInUpperLmtFail_3G		;

	INT8U OverInAlarm_CDMALTE		; 
	INT8U FwdOutLowerLmtFail_LTE	;
	INT8U FwdOutUpperLmtFail_LTE	;
	INT8U FwdInUpperLmtFail_LTE 	;
	INT8U FwdOutLowerLmtFail_2G 	;
	INT8U FwdOutUpperLmtFail_2G 	;
	INT8U FwdInUpperLmtFail_2G		;

	INT8U OverInAlarm_LTE_A 		; 
	INT8U FwdOutLowerLmtFail_LTE_A2 ;
	INT8U FwdOutUpperLmtFail_LTE_A2 ;
	INT8U FwdInUpperLmtFail_LTE_A2	;

	INT8U LocalFail_LTE_A			;
	INT8U LocalFail_CDMALTE 		;
	INT8U LocalFail_WCDMALTE_21 	;

	INT8U RvsOutUpperLmtFail_LTE_21 ;
	INT8U RvsOutUpperLmtFail_LTE_A2 ;
	INT8U RvsOutUpperLmtFail_LTE	;
	INT8U RvsOutUpperLmtFail_2G 	;
	INT8U RvsOutUpperLmtFail_3G 	;

	INT8U FwdAmpOnOff_LTE_21		;
	INT8U FwdAmpOnOff_LTE_A2		;
	INT8U FwdAmpOnOff_LTE			;
	INT8U FwdAmpOnOff_2G			;
	INT8U FwdAmpOnOff_3G			;


	INT8U ULGainLowAlarm_LTEA			;
	INT8U ULGainLowAlarm_CDMALTE		;
	INT8U ULGainLowAlarm_WCDMALTE_21	;

	INT8U DigitalAlarm					; 
	INT8U ACFail						; 	
	INT8U DCFail;		
} __PwrAlmStr;

typedef struct {
	INT8U OverInAlarm_CDMALTE_1;
	INT8U OverInAlarm_CDMALTE_2;
	INT8U OverInAlarm_CDMALTE_3;

	INT8U OverInAlarm_WCDMALTE_21_1;
	INT8U OverInAlarm_WCDMALTE_21_2;
	INT8U OverInAlarm_WCDMALTE_21_3;



	INT8U ULGainAlarm_CDMALTE;
	INT8U ULGainAlarm_LTE_A;
	INT8U ULGainAlarm_WCDMALTE_21;	
 } __CurrAlmStr;



#ifdef ALARM_C
	INT8U tAttAccu = 0;

	__CurrAlmStr CurrAlarm;

	__PwrAlmStr PwrAlarm = {0,};
	__PwrAlmStr PwrAlarmPre = {0,};	
	__PwrAlmStr PwrAlarmChange = {0,};		
	__PwrAlmStr PwrAlarmTimer= { 
		10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 
		10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 
		10L, 10L, 10L, 10L, 10L, 10L, 12L, 12L, 12L, 12L, 
		12L, 10L, 10L, 10L,  1L, 1L, 1L
		};
		
	__PwrAlmStr PwrAlarmCnt = { 
		10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 
		10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 
		10L, 10L, 10L, 10L, 10L, 10L, 12L, 12L, 12L, 12L, 
		12L, 10L, 10L, 10L,  1L, 1L, 1L
		};

	INT8U tTblAlmInit = 0;

	__FastNotify FastDown;
	__FastNotify FastDownCPLT;


	INT8U ChkRvsOverInAlarm = 0;
	INT8U RvsOverInAlarmCnt = 0;
	INT8U RvsOtherOverInAlarmCnt = 0;

	INT8U ChkRvsOtherOverInAlarm = 0;



	INT8U AlarmChange_2G = 0;
	INT8U AlarmChange_LTE = 0;
	INT8U AlarmChange_LTE_21 = 0;
	INT8U AlarmChange_LTE_A = 0;
	INT8U AlarmChange_3G = 0;	

	INT8U AlarmChangeOff_2G = 0;
	INT8U AlarmChangeOff_LTE = 0;
	INT8U AlarmChangeOff_LTE_21 = 0;
	INT8U AlarmChangeOff_LTE_A = 0;
	INT8U AlarmChangeOff_3G = 0;	


#else


	extern INT8U tAttAccu;

	extern __CurrAlmStr CurrAlarm;

	extern __PwrAlmStr PwrAlarm;
	extern __PwrAlmStr PwrAlarmPre;
	extern __PwrAlmStr PwrAlarmChange;
	extern __PwrAlmStr PwrAlarmTimer;
	extern __PwrAlmStr PwrAlarmCnt;


	extern INT8U tTblAlmInit;
	extern  __FastNotify FastDown;
	extern  __FastNotify FastDownCPLT;

	

	extern INT8U AlarmChange_2G;
	extern INT8U AlarmChange_LTE;
	extern INT8U AlarmChange_LTE_21;
	extern INT8U AlarmChange_LTE_A;
	extern INT8U AlarmChange_3G;	

	extern INT8U AlarmChangeOff_2G;
	extern INT8U AlarmChangeOff_LTE;
	extern INT8U AlarmChangeOff_LTE_21;
	extern INT8U AlarmChangeOff_LTE_A;
	extern INT8U AlarmChangeOff_3G;	


#endif


#define AlarmCheckTime	600L	// 500 -> about 15Sec
#define StartAlarmCheckTime	10L	// 500 -> about 15Sec
#define SleepAlarmCheckTime	60L	

#define AlarmCheckTimeTest	50L	// 500 -> about 15Sec

INT8U UPdateAlarm(INT8U *CurSts, INT8U *PreSts, INT8U *ChangeFlag, INT8U *AlarmTimer, INT8U *AlarmCnt);
void PeriodReportCheck(void);
void SmsDnrAlarm_Check(void);
INT32U DnrAlarmCheckUpdate(INT8U TotMask);
INT8U OutPutTable_Alarm_check(INT8U tIndex);
INT8U AttTable_Alarm_check(INT8U tIndex);

void Table_Alarm(void);

/////////////////////////////////////////
INT16S TableOffset(INT16S Temp, INT16S Temp10x, INT16S Offset, INT16S *Ret10x);

INT8U LimitAlarmUpdate( INT8U CurrAlarm, INT8U PreAlarm, INT16U AlarmIndex);

INT8U HighLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm);
INT8U LowLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm);
INT8S RetSMStoNormalData(INT8U Data);
INT8U RetNormaltoSMSData(INT8S Data);
INT8U RetSmsOffVal(INT8U OnOff);

INT8U OffsetLmtCheck(INT8S Value,INT8S Offset);

INT8U TblLmtCheck(INT8S tlimit,INT8S tTblLimit);

INT8U HighLimitCheck1(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl);
INT8U LowLimitCheck1(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl);



void AlarmCheck(void);
void TRIO_AlarmCheck(void);
void AlarmStatusUpdate(void);
void ShutDownCheck(void);
void ShutdownFunc(INT8U SysPath, INT8U Path);


INT8U HighLimitCheck1_Test(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

