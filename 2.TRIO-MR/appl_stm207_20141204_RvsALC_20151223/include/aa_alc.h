
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
#if 0
	INT16U SleepTimeCnt;
	INT8U SleepStep;
	INT8U IsItSLP;
	INT8U SleepRecovery;
#endif

	INT8U SleepCnt;
	INT8S SleepStep;
	INT8S SleepRecovery;
	INT8U IsItSLP;
	
} __SleepStr;


typedef struct {
	
	INT8U FwdLowMask;
	INT8U IsItAlarm;
	INT16U AlarmCnt;

	INT8U Alarm_ALM_BIT;
	INT8U Alarm_RALM_BIT;

	INT8S cAlarm;
	INT8S Level;
	INT8S AlarmLevel;
	INT8S AlarmRecovery;

	
	

//	INT8U ISO_WAITING;
#if 0	
	INT8S PowerPre;
	INT8U ISOStep;
	INT8U ISOAttn;
	INT8U ISOFail;
	INT8U ISONoofCnt;
	INT8U iIsolationLevel;
#endif

} __AlarmStr;

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


enum SYSPATH_NUM{
	PATH_2G = 0,
	PATH_LTE,
	PATH_LTEA,
	PATH_3G,

	SysPathMax,
};

enum {

	SD_FI_2G = 0,
	SD_FI_LTE,
	SD_FI_3G,
	SD_FI_LTE_A2,
	SD_FO_2G,
	SD_FO_LTE,
	SD_FO_3G,
	SD_FO_LTE_A2,
 
	SD_RO_2G,
	SD_RO_LTE,
	SD_RO_3G,
	SD_RO_LTE_A2,
  
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
	__SleepStr mSleep[4];
	__AlarmStr mFwdHighAlm[4];
	__AlarmStr mFwdLowAlm[4];
	__AlarmStr mRvsHighAlm[4];
	__AlarmStr mFwdInHighAlm[4];

	INT8U InitLedDisplay = 0;
	INT8U InitLedStep = 0;
	
	INT8U LEDStatus[LED_SelMax] = {0,};
	INT8U BlinkFlag = FALSE;
	
	INT8U MinAttn[2] = {0,0};
	INT32U tmpSleepTimeOn[2] = {0,0};

/////////////////////////////////
//////////////////////////////////////////////
#if 1
	INT8U FlagAmpOnOff_2G = 0;
	INT8U FlagAmpOnOff_3G = 0;
	INT8U FlagAmpOnOff_LTE = 0;
	INT8U FlagAmpOnOff_LTE_A2 = 0;
#endif

	INT8U	Sd_Step[SD_SysMax] = {0,0,0,0,0,0,0,0,0,0,0,0};
	INT8U	Sd_Cnt[SD_SysMax] = {0,0,0,0,0,0,0,0,0,0,0,0};
	INT8U	Sd_Path[SysPathMax] = {0,0,0,0};
	INT8U	Sd_BuffClear[SysPathMax] = {0,0,0,0};
	INT8U	Amp_Step[SysPathMax] = {10,10,10,10};

	INT8U	Ac_Sd_Flag = 0;
//	INT16U	LimitAlarmCnt[SysPathMax] = {0,0,0,0};

	INT16U	 dBmTomW[35] = {	501,447,398,355,316,282,251,224,200,178,
							158,141,126,112,100,89,79,71,63,56,
							50, 45, 40, 35, 32, 28,25, 22, 20, 18, 
							16, 14, 13, 11, 10};

	INT16U	 mWTodBm[35] = { 270,265,260,255,250,245,240,235,230,225,
							220,215,210,205,200,195,190,185,180,175,
							170,165,160,155,150,145,140,135,130,125,
							120,115,110,105,100};  ///Start 27dBm

	INT8U	AlarmLEDSts[SysPathMax][SysPathMax] = {0,0,0,0,0,0,0,0};
//	INT16U SleepModeCnt[SysPathMax] = {0,};
//	INT8U chkSleepMode[SysPathMax] = {0,};


////////////////////////////////////////////////////////////////////////////////
#else
///////////////////////////
	extern OS_EVENT *AlcSem;
	extern INT8U MinAttn[2];
	extern __SleepStr mSleep[4];
	extern __ShutDnStr	mSDCheck[4];

	extern __AlarmStr mFwdHighAlm[4];
	extern __AlarmStr mFwdLowAlm[4];
	extern __AlarmStr mRvsHighAlm[4];
	extern __AlarmStr mFwdInHighAlm[4];


/////////////////////////////////////
	extern INT8U FlagAmpOnOff_2G;
	extern INT8U FlagAmpOnOff_3G;
	extern INT8U FlagAmpOnOff_LTE;
	
	extern INT8U FlagAmpOnOff_LTE_A2;

	//////////////////////////////////////
	extern	INT8U	Sd_Step[SD_SysMax];
	extern	INT8U	Sd_Cnt[SD_SysMax];
	extern	INT8U	Sd_Path[SysPathMax];
	extern	INT8U	Amp_Step[SysPathMax];

	extern INT16U	LimitAlarmCnt[SysPathMax];
//	extern INT16U SleepModeCnt[SysPathMax];
//	extern INT8U chkSleepMode[SysPathMax];

	extern INT8U LEDStatus[LED_SelMax];

	/////////////////////////////////
	extern INT16U dBmTomW[35];
	extern INT16U mWTodBm[35];

	extern INT8U Ac_Sd_Flag;
	
////////////////////////////////////////////////////////////////////////////////
#endif

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////
_USR_EXT_ALC  INT8S tmpRvsALCLvl_3G;
#if 1
_USR_EXT_ALC  INT8S CurrAgcAttn_3G;
_USR_EXT_ALC  INT8S CurrAgcAttn_2G;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_A2;

_USR_EXT_ALC  INT8S CurrRvsAlcAttn_3G;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_2G;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_LTE;
_USR_EXT_ALC  INT8S CurrRvsAlcAttn_LTE_A2;
#endif

void AlcInit(void);
void AlcTask(void *p_arg);

void ReadAdcValue(void);
void ReadAdcValue_2(void);

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

void ShutDownCheck(void);


INT8S OneOutPwrConv(INT8S *Vaule);
void TwoOutPwrConv(INT8S *dptr, INT8S Vaule);
void TwoOutPwrConvINT(INT8S *dptr, INT16S Vaule);
void TwoOutPwrConv_INT(INT8S *dptr, INT16S Vaule);
void ULTwoOutPwrConvINT(INT8S *dptr, INT16S Vaule);



INT16S Dnr0_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation);
INT16S ReadPwrTableDnr(INT32U AdcValue, INT8U TblID, INT8U roundingoff, INT8U *isminval, INT16S Offset);
void ShutdownFunc(INT8U SysPath, INT8U Path);
void AmpBitReason(INT8U SysPath, INT8U EnSts, INT8U Reason, INT8U AmpSts);
INT8S PwrTableOffset(INT8S Temp,INT8U tIndex);
INT8S AGCCheck(INT32S tmpx10,INT32S tlimitLow,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax,INT8S AmpOnOff, INT8U Mode);
void AGCCheckFunction(void);
void ALCCheckFunction(void);
INT8U BalanceModeFunc(INT8U IsItPath);
void BalanceMode(void);
void AlarmInitialize(void);
void RvsOSCAlarmCountFunc(INT8U SysPath, INT8U Path);


//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

