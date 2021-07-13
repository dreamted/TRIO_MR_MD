
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

////////////////////////////////////////////////////////////////////////////////
#ifdef ALC_C
	#define _USR_EXT_ALC
#else
	#define _USR_EXT_ALC	extern
#endif

#define __AvgMAXGARBAGE	5
#define __AvgMINGARBAGE	80

#define __PeakMAXGARBAGE	20
#define __PeakMINGARBAGE	10

////////////////////////////////////////////////////////////////////////////////
/******************
#define __KXP74_SDI			GPIOB->ODR.Bit.ODR15	// PB15
*******************/
////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

enum {
	LEDNorON,
	LEDNorONOFF,
	LEDAlmON,
	LEDAlmONOFF,
	LEDNorAlmON,
	LEDNorAlmONOFF,
	LEDAllOFF,
	
	LED_SelMax
};


typedef struct {

	INT8U ISO_ALM_BIT;
	INT8U ISO_RALM_BIT;
	INT8U ISO_WAITING;
	
	INT8S PowerPre;
	INT8U ISOStep;
	INT8U ISOAttn;
	INT8U ISOFail;
	INT8U ISONoofCnt;
	INT8U iIsolationLevel;
} __IsoStr;

typedef struct {

	INT8U OSCAlarm;

	INT8U OSCTimeCnt;
	INT16S OSCPowerRef;
	INT8U OSCCnt;
	INT8U OSCRetry;
	INT8U OSCStep;
	INT8U IsItOSC;

	//INT8U OSCIncNumber;

} __OscStr;

typedef struct {
	INT16S DetValue;
	INT16S LmtValue;
	INT8U AmpOnOff;


	INT8U RvsSDStep;
	INT8U FwdSDStep;
	INT8U IsItSHD;
} __ShutDnStr; 


typedef struct {
	
	INT8U FwdLowMask;
	INT8U IsItAlarm;
	INT16U AlarmCnt;

	INT8U Alarm_ALM_BIT;
	INT8U Alarm_RALM_BIT;

	INT16S cAlarm;
	INT16S Level;
	INT16S AlarmLevel;
	INT16S AlarmRecovery;

} __AlarmStr;


typedef struct {

	INT8S FwdAttn1_0;		
	INT8S FwdAttn2_0;		
	INT8S RvsAttn1_0;		
	INT8S RvsAttn2_0;		

	INT8S FwdAttn1_1;		
	INT8S FwdAttn2_1;		
	INT8S RvsAttn1_1;		
	INT8S RvsAttn2_1;		
	INT8S RvsAttn3_1;	


 	INT8U FwdAttn1_Common;
	INT8U RvsAttn1_Common;
	INT8U RvsAttn2_Common;
	INT8U RvsAttn3_Common;
	INT8U FwdAttnMax;

	INT8U FwdAttn1Max;
	
 	INT8S FwdAgcAttn_0;
 	INT8S FwdAgcAttn_1;
//////////////////////
	INT8S nAttn1_Path0;	
	INT8S nAttn1_Path1;	
	INT8S nAttn2_Path0;	
	INT8S nAttn2_Path1;	

	INT8U nAttn1_Common;
	INT8U AttnMax;
	INT8U AgcAttn_Path0;
	INT8U AgcAttn_Path1;

	INT8U InputAgcAttn;
	INT8U InputAlcAttn;

	INT8S nInitGain_Path0;	
	INT8S nInitGain_Path1;	
	INT8S nGain_Path0;	
	INT8S nGain_Path1;	
} __AttnStr;


typedef struct {
	INT16S	InPath_Det;
	INT16S	InLmtValue;
	INT16S	OutPath_Det;
	INT16S	OutLmtValue;
	
	INT16U AlarmStep;
	INT16U AlarmCnt;
	
	INT16U ULLowAlarmCnt;
	INT16U ULAlarm;
	INT16U AlarmCheck;
	INT16U ULGainAlarmCheck;

	INT16U AlarmTimer;

	INT8U PathOnOff;

} __ULGainMode1;



typedef struct {
	INT8U	Path0_SumAttn;
	INT8U	Path1_SumAttn;

	INT8U	AttLmtValue;

////////////////////////////////////////////
	INT16S	OutPath0_Det;
	INT16S	OutPath1_Det;

	INT16S	OutLmtValue;

	INT16U AlarmStep;
	INT16U AlarmCnt;
	
	INT16U ULLowAlarmCnt;
	INT16U ULAlarm;
	INT16U AlarmCheck;
	INT16U ULGainAlarmCheck;

	INT16U AlarmTimer;

	INT16U ULOutCheckCnt;

	INT16U ULPwrCheckCnt;
	INT16U ULAttCheckCnt;


	INT8U PathOnOff;

} __ULGainMode2;


////////////////////////////////////////
//=====================================================================//
// Amp Reason
#define CASE_User				0x00		// 사용자에 의함.
#define CASE_DeviceAutoSD		0x01		// Device Auto Shutdown
#define CASE_RvsFail			0x02		// 역방향 장애
#define CASE_TempHigh			0x03		// 온도 상한
#define CASE_OverPwr			0x04		// Over Power
#define CASE_PSU_SWOFF			0x05		// 전원 Switch OFF
#define CASE_AmpLinkFail		0x06		// AMP Link Fail
#define CASE_VSWRFail			0x07		// VSWR Fail
#define CASE_LoopFail			0x08		// Loop Fail
#define CASE_DCFail				0x09		// DC Fail
#define CASE_SubPSU_SWOFF		0x0A		// SUB 전원 Switch OFF
#define CASE_SwitchingFail		0x0B		// Switching 이상
#define CASE_PLL_UNLOCK			0x0C		// PLL UNLOCK 이상
#define CASE_PwrFail			0x0D		// 전원이상 
#define CASE_DgBdErr			0x0E		// Digital Board 이상 
#define CASE_Unknown			0x0F		// Unknow   
#define CASE_PDFail				0x10		// PD Fail
#define CASE_OverInPwr			0x14		// Over Power


// SD OFF Status
#define	SD_AMP_ON				0x00
#define	SD_AMP_OFF_5S			0x01
#define	SD_AMP_OFF_30M			0x02
#define	SD_AMP_OFF_INF			0x03



enum {

	SD_FI_2G = 0,
	SD_FI_LTE,
	SD_FI_3G,
	SD_FI_LTE_A2,
	SD_FI_LTE_21,

	
	SD_FO_2G,
	SD_FO_LTE,
	SD_FO_3G,
	SD_FO_LTE_A2,
	SD_FO_LTE_21,
 
	SD_RO_2G,
	SD_RO_LTE,
	SD_RO_3G,
	SD_RO_LTE_A2,
	SD_RO_LTE_21,
  
	SD_SysMax,
};




#ifdef ALC_C
////////////////////
	#define ALC_START_STK_SIZE		256
	
	static OS_STK AlcTaskStk[ALC_START_STK_SIZE] @ "iram";;
	OS_EVENT *AlcSem = NULL;
	
	INT8U AdcStep0 = 1;
	INT8U AdcStep1 = 1;
	INT8U AdcFlag = 0;
	INT8U AdcCheck = 0;

	__IsoStr mISOCheck[2];
	__OscStr mOSCCheck[2];
	__ShutDnStr	mSDCheck[2];
	__AlarmStr mFwdHighAlm[PATH_MAX];
	__AlarmStr mFwdLowAlm[PATH_MAX];
	__AlarmStr mRvsHighAlm[PATH_MAX];
	__AlarmStr mFwdInHighAlm[PATH_MAX];

	__AlarmStr mFwdOutLowAlm[SvrPATH_MAX]; /////Adder 20150428


	__AttnStr mAttnStr[SvrPATH_MAX];
	__ULGainMode1 mULGainMode1[SvrPATH_MAX];
	__ULGainMode2 mULGainMode2[SvrPATH_MAX];

	INT8U InitLedDisplay = 0;
	INT8U InitLedStep = 0;
	
	INT8U LEDStatus[LED_SelMax] = {0,};
	INT8U BlinkFlag = FALSE;
	
	INT8U MinAttn[2] = {0,0};
	INT32U tmpSleepTimeOn[2] = {0,0};

	INT8U FlagAmpOnOff_2G = 0;
	INT8U FlagAmpOnOff_3G = 0;
	INT8U FlagAmpOnOff_LTE = 0;
	INT8U FlagAmpOnOff_LTE_A2 = 0;
	INT8U FlagAmpOnOff_LTE_21 = 0;

	INT8U	Sd_Step[SD_SysMax] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	INT8U	Sd_Cnt[SD_SysMax] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	INT8U	Sd_Path[PATH_MAX] = {0,0,0,0,0,0};
	INT8U	Sd_BuffClear[PATH_MAX] = {0,0,0,0,0,0};
	INT8U	Amp_Step[PATH_MAX] = {10,10,10,10,10,10};

	INT8U	Ac_Sd_Flag = 0;

	INT8U	AlarmLEDSts[PATH_MAX][PATH_MAX] = {0,0,0,0,0,0,0,0,0,0,0,0};

	long ULGainPeriod = 0;
	long ULGainTimeElapse = 0;

	INT8U ULGainStart = 0;

	__BitStr BitStr;

	INT8U iISO_Debug_Mode = 0;

	INT8U ChkISO = 0;
	INT8U ChkISOSet = 0;
	INT8U ISOOnOffStart = 0;
	INT8U ISOOnOffMode = 0;

	INT8U ISOConversion = 0;

	
	INT8U tISOSelect = 0;

	INT8U TimerAGCMode_3G = 0;
#else
	extern OS_EVENT *AlcSem;
	extern INT8U MinAttn[2];
	extern __ShutDnStr	mSDCheck[4];

	extern __AlarmStr mFwdHighAlm[PATH_MAX];
	extern __AlarmStr mFwdLowAlm[PATH_MAX];
	extern __AlarmStr mRvsHighAlm[PATH_MAX];
	extern __AlarmStr mFwdInHighAlm[PATH_MAX];
	extern __AttnStr mAttnStr[SvrPATH_MAX];

	extern __AlarmStr mFwdOutLowAlm[SvrPATH_MAX]; /////Adder 20150428

	extern __ULGainMode1 mULGainMode1[SvrPATH_MAX];
	extern __ULGainMode2 mULGainMode2[SvrPATH_MAX];

/////////////////////////////////////
	extern INT8U FlagAmpOnOff_2G;
	extern INT8U FlagAmpOnOff_3G;
	extern INT8U FlagAmpOnOff_LTE;
	
	extern INT8U FlagAmpOnOff_LTE_A2;
	extern INT8U FlagAmpOnOff_LTE_21;

	//////////////////////////////////////
	extern	INT8U	Sd_Step[SD_SysMax];
	extern	INT8U	Sd_Cnt[SD_SysMax];
	extern	INT8U	Sd_Path[PATH_MAX];
	extern	INT8U	Amp_Step[PATH_MAX];


	extern INT16U ULAlarmStep[3];
	extern INT16U ULAlarmCnt[3];


	extern INT16U	LimitAlarmCnt[PATH_MAX];
	extern INT8U LEDStatus[LED_SelMax];

	///////////////////////////////////

	extern INT8U Ac_Sd_Flag;
	extern long	ULGainPeriod;
	
	extern long ULGainTimeElapse;
	extern __BitStr BitStr;

	extern INT8U iISO_Debug_Mode;


	extern INT8U ChkISO;
	extern INT8U ChkISOSet;
	extern INT8U ISOOnOffStart;
	extern INT8U ISOOnOffMode;
	extern INT8U tISOSelect;


	extern INT8U TimerAGCMode_3G;

	
	
////////////////////////////////////////////////////////////////////////////////
#endif

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////
_USR_EXT_ALC  INT8S tmpRvsALCLvl_3G;
_USR_EXT_ALC  INT8S CurrAgcAttn_3G;
_USR_EXT_ALC  INT8S CurrAgcAttn_2G;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_A1;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_A2;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_21;

_USR_EXT_ALC  INT8S CurrRvsAlcAttn_3G;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_2G;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_LTE;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_LTE_A1;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_LTE_A2;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_LTE_21;


void AlcInit(void);
void AlcTask(void *p_arg);

void ReadAdcValue(void);

void ReadAdcValue_TRIO (void);;

void ResetCaseBackup(INT8U Cause);
void ChangeLvltoValue(INT16S CurLvl, INT16S *PreLvl, INT16S *Cnt, INT16S *Value, INT8S MaxCnt);

INT8U TemptoIndex(INT8S temp);
INT8S AgcLimitOperation(INT8S gap, INT8U tmpAlcAttn, INT8U AttMax, INT8U AttMin, INT8U Mode);
INT8U LimitAlarmUpdate( INT8U CurrAlarm, INT8U PreAlarm, INT16U AlarmIndex);

INT32S ConvLevelOneByte(INT8S *lvl);

void FrontLEDSet(INT8U tindex, INT8U tstatus);
void FrontLEDDisplay(void);
void FrontLEDStausUpdate(void);

INT8S RetFWDPower(INT16S tmp);
INT8S RetRVSPower(INT16S tmp);


INT8S OneOutPwrConv(INT8S *Vaule);
void TwoOutPwrConv(INT8S *dptr, INT8S Vaule);
void TwoOutPwrConvINT(INT8S *dptr, INT16S Vaule);
void TwoOutPwrConv_INT(INT8S *dptr, INT16S Vaule);
void ULTwoOutPwrConvINT(INT8S *dptr, INT16S Vaule);



INT16S Dnr0_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation);
INT16S ReadPwrTableDnr(INT32U AdcValue, INT8U TblID, INT8U roundingoff, INT8U *isminval, INT16S Offset);
void AmpBitReason(INT8U SysPath, INT8U EnSts, INT8U Reason, INT8U AmpSts);
INT8S PwrTableOffset(INT8S Temp,INT8U tIndex);
INT8S AGCCheck(INT32S tmpx10,INT32S tlimitLow,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax,INT8S AmpOnOff, INT8U Mode);
void AGCCheckFunction(void);
void ALCCheckFunction(void);
void AlarmInitialize(void);
void AmpSd_Clear(INT8U SysPath);

void ULGainLowCheack(void);

void ULGainLowAlarm_mode1(INT8U Path);
void ULGainLowAlarm_mode2(INT8U Path);

INT16S Power_Sum(INT8S *dptr,INT8S *sptr);
INT16S Power_Sum_Test(INT8S *dptr,INT8S *sptr);

u16 dBmTomW(s16 dBm);
INT16S mWTodBm(s16 mW);


void ULGainLowInit(void);
void IsolationCheck(void);

void IsolationPathSelect(INT8U Path);

//INT16S mWTodBm(double Value);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

