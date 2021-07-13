
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
	INT8U FwdOutUpperLmtFail_2G;
	INT8U FwdInUpperLmtFail_2G;	
	INT8U FwdOutUpperLmtFail_LTE;
	INT8U FwdInUpperLmtFail_LTE;
	INT8U OverInAlarm_CDMALTE;
	INT8U FwdOutUpperLmtFail_LTE_A1;	
	INT8U FwdInUpperLmtFail_LTE_A1;
	INT8U FwdOutUpperLmtFail_LTE_A2;	
	INT8U FwdInUpperLmtFail_LTE_A2;
	INT8U FwdOutUpperLmtFail_3G;	
									/////1
	INT8U FwdInUpperLmtFail_3G;	
	INT8U OverInAlarm_3G;	
	INT8U Fwd1OutUpperLmtFail_LTE;
	INT8U Fwd1InUpperLmtFail_LTE;
	INT8U Fwd1OutUpperLmtFail_LTE_A1;
	INT8U Fwd1InUpperLmtFail_LTE_A1;
	INT8U OverInAlarm_LTE_A;	
	INT8U Fwd1OutUpperLmtFail_LTE_A2;
	INT8U Fwd1InUpperLmtFail_LTE_A2;
	INT8U OverInAlarm_LTE_A1;
									////2
	INT8U RvsOutUpperLmtFail_2G;
	INT8U RvsOutUpperLmtFail_LTE;
	INT8U RvsOutUpperLmtFail_LTE_A1;
	INT8U RvsOutUpperLmtFail_LTE_A2;
	INT8U Rvs1OutUpperLmtFail_LTE;
	INT8U Rvs1OutUpperLmtFail_LTE_A1;
	INT8U Rvs1OutUpperLmtFail_LTE_A2;
	INT8U RvsOutUpperLmtFail_3G;	
	INT8U FwdAmpOnOff_2G;		
	INT8U FwdAmpOnOff_LTE;	
									/////3
	INT8U FwdAmpOnOff_LTE_A1;		
	INT8U FwdAmpOnOff_LTE_A2;
	INT8U FwdAmpOnOff_3G;			
	INT8U FwdAmp1OnOff_LTE;
	INT8U FwdAmp1OnOff_LTE_A1;		
	INT8U FwdAmp1OnOff_LTE_A2;

 
	INT8U LocalFail_CDMALTE;
	INT8U LocalFail_LTE_A1;
									////4
	INT8U LocalFail_LTE_A2;
	INT8U LocalFail_3G;
	INT8U LocalFail_LTE_1;
	INT8U LocalFail_LTE_A1_1;	
	INT8U LocalFail_LTE_A2_1;
	INT8U ACFail;
	INT8U DCFail;				////7

	
	INT8U FwdOutLowerLmtFail_2G;	
	INT8U FwdOutLowerLmtFail_LTE;
	INT8U FwdOutLowerLmtFail_3G;
	INT8U FwdOutLowerLmtFail_LTE_A1;
	INT8U FwdOutLowerLmtFail_LTE_A2;
	INT8U Fwd1OutLowerLmtFail_LTE;	
	INT8U Fwd1OutLowerLmtFail_LTE_A1;
	INT8U Fwd1OutLowerLmtFail_LTE_A2; ////8
} __PwrAlmStr;

typedef struct {
	INT8U OverInAlarm_CDMALTE_1;
	INT8U OverInAlarm_CDMALTE_2;

	INT8U OverInAlarm_LTE_A1; 
	INT8U OverInAlarm_LTE_A2; 

	INT8U OverInAlarm_LTE_1;

	INT8U OverInAlarm_LTE_A1_1;
	INT8U OverInAlarm_LTE_A2_1;
////////////////////
	INT8U OverInAlarm_CDMALTE_3;
	INT8U OverInAlarm_LTE_A; 
	INT8U OverInAlarm_LTE_A_1; 

	INT8U RvsOverInAlarm;
} __CurrAlmStr;

#ifdef ALARM_C
	INT8U *rambackup = (INT8U *)(SRAM_BASE + (48*1024)-100);

	INT8U tAttAccu = 0;

	__CurrAlmStr CurrAlarm;

	__PwrAlmStr PwrAlarm = {0,};
	__PwrAlmStr PwrAlarmPre = {0,};	
	__PwrAlmStr PwrAlarmChange = {0,};		
	__PwrAlmStr PwrAlarmTimer= { 
		8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 
      	8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 
		8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 

		14L, 14L, 14L, 14L, 14L, 14L, 14L, 14L, 

		8L, 8L, 8L, 8L,8L, 8L, 8L, 3L, 1L, 

		1L,1L,1L,1L,1L, 1L,1L, 1L};
		
	__PwrAlmStr PwrAlarmCnt = { 
		8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 
      	8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 
		8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 

		14L, 14L, 14L, 14L, 14L, 14L, 14L, 14L, 

		8L, 8L, 8L, 8L,8L, 8L, 8L, 3L, 1L, 

		1L,1L,1L,1L,1L, 1L,1L, 1L};

	

	INT8U FirstPNCheckFlag = FALSE;

	INT8U ChkTableAlarm = 0;
	INT8U DnrAttnTblAlarm[Local_DnrAttn_Max]= {0,};
	INT8U SvrAttnTblAlarm[Local_Svr0Attn_Max]= {0,};

	INT32U TimePeriodElased = 0;
	INT8U FirstCheckFlag = FALSE;

	INT8U RvsOverInAlarmCnt = 0;
	INT8U RvsOtherOverInAlarmCnt = 0;

	INT8U ChkRvsOverInAlarm = 0;
	INT8U ChkRvsOtherOverInAlarm = 0;


	INT8U AlarmCheck_2G = 0;
	INT8U AlarmCheck_LTE = 0;
	INT8U AlarmCheck_LTE_A1 = 0;
	INT8U AlarmCheck_LTE_A2 = 0;

	INT8U AlarmCheck_LTE_1 = 0;
	INT8U AlarmCheck_LTE_A1_1 = 0;
	INT8U AlarmCheck_LTE_A2_1 = 0;

	INT8U ACFailCnt = 0;

#else

	extern INT8U *rambackup;

	extern INT8U tAttAccu;

	extern __CurrAlmStr CurrAlarm;

	extern __PwrAlmStr PwrAlarm;
	extern __PwrAlmStr PwrAlarmPre;
	extern __PwrAlmStr PwrAlarmChange;
	extern __PwrAlmStr PwrAlarmTimer;
	extern __PwrAlmStr PwrAlarmCnt;


	extern INT8U FirstPNCheckFlag;
	extern INT8U ChkTableAlarm;
	extern INT8U DnrAttnTblAlarm[Local_DnrAttn_Max];
	extern INT8U SvrAttnTblAlarm[Local_Svr0Attn_Max];


	extern INT8U AlarmCheck_2G;
	extern INT8U AlarmCheck_LTE;
	extern INT8U AlarmCheck_LTE_A1;
	extern INT8U AlarmCheck_LTE_A2;

	extern INT8U AlarmCheck_LTE_1;
	extern INT8U AlarmCheck_LTE_A1_1;
	extern INT8U AlarmCheck_LTE_A2_1;
	
	extern INT8U ACFailCnt;

#endif


#define AlarmCheckTime	600L	// 500 -> about 15Sec
#define StartAlarmCheckTime	10L	// 500 -> about 15Sec


#define SleepAlarmCheckTime	60L	


void AlarmInitialize(void);
void AlarmCheck(void);
void AlarmStatusUpdate(void);
void ResetCaseBackup(INT8U Cause);
INT8U UPdateAlarm(INT8U *CurSts, INT8U *PreSts, INT8U *ChangeFlag, INT8U *AlarmTimer, INT8U *AlarmCnt);
void PeriodReportCheck(void);
void SmsDnrAlarm_Check(void);
INT32U DnrAlarmCheckUpdate(INT8U TotMask);
INT8U OutPutTable_Alarm_check(INT8U TblID);
INT8U AttTable_Alarm_check(INT8U TblID);

void Table_Alarm(void);

/////////////////////////////////////////
INT16S TableOffset(INT16S Temp, INT16S Temp10x, INT16S Offset, INT16S *Ret10x);

INT8U LimitAlarmUpdate( INT8U CurrAlarm, INT8U PreAlarm, INT16U AlarmIndex);

INT8U HighLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm);
INT8U LowLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm);
INT8S RetSMStoNormalData(INT8U Data);
INT8U RetNormaltoSMSData(INT8S Data);
INT8U RetSmsOffVal(INT8U OnOff);


INT8U RvsSleepMode(void);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

