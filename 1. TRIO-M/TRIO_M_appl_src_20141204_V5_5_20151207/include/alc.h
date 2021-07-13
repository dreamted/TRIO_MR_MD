
/*********************************************
* File Name          : alc.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/


////////////////////////////////////////////////////////////////////////////////
#ifdef ALC_C
	#define _USR_EXT_ALC
#else
	#define _USR_EXT_ALC	extern
#endif

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
	PATH_3G,
	PATH_LTE_A1,
	PATH_LTE_A2,
	PATH_LTE_1,
	PATH_LTE_A1_1,
	PATH_LTE_A2_1,

	SysPathMax,
};

enum {

	SD_FI_2G = 0,
	SD_FI_LTE,
	SD_FI_3G,
	SD_FI_LTE_A1,
	SD_FI_LTE_A2,
	SD_FI_LTE_1,
	SD_FI_LTE_A1_1,
	SD_FI_LTE_A2_1,

	SD_FO_2G,
	SD_FO_LTE,
	SD_FO_3G,
	SD_FO_LTE_A1,
	SD_FO_LTE_A2,
	SD_FO_LTE_1,
	SD_FO_LTE_A1_1,
	SD_FO_LTE_A2_1,

	SD_RO_2G,
	SD_RO_LTE,
	SD_RO_3G,
	SD_RO_LTE_A1,
	SD_RO_LTE_A2,

	SD_RO_LTE_1,
	SD_RO_LTE_A1_1,
	SD_RO_LTE_A2_1,

	SD_SysMax,
};


#define	_Enable				0x00
#define	_Disable			0x01

#define	__SET				0x01
#define	__RESET				0x00

#ifdef ALC_C

	#define ADC_START_STK_SIZE		128

	static OS_STK AdcTaskStk[ADC_START_STK_SIZE];
	
	OS_EVENT *AlcSem = NULL;
	
	INT8S tempIndexHys = 0;

/////////////////////////////////
	INT8U iAGCOnOff = 0;
	INT8U iAGCAttnMAX = 0;
	INT16S iAGClimit = 0;
	INT16S iAGCPwr = 0;
//////////////////////////////////////////////
	INT8U FlagAmpOnOff_2G = 0;
	INT8U FlagAmpOnOff_3G = 0;
	INT8U FlagAmpOnOff_LTE = 0;
	INT8U FlagAmpOnOff_LTE_A1 = 0;
	INT8U FlagAmpOnOff_LTE_A2 = 0;

	INT8U FlagAmp1OnOff_LTE = 0;
	INT8U FlagAmp1OnOff_LTE_A1 = 0;
	INT8U FlagAmp1OnOff_LTE_A2 = 0;

	INT8U	Sd_Step[SD_SysMax] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	INT8U	Sd_Cnt[SD_SysMax] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	INT8U	Sd_Path[SysPathMax] = {0,0,0,0,0,0,0,0};
	INT8U	Sd_BuffClear[SysPathMax] = {0,0,0,0,0,0,0,0};
	INT8U	Amp_Step[SysPathMax] = {10,10,10,10,10,10,10,10};

	INT8U	Ac_Sd_Flag = 0;
	INT16U	LimitAlarmCnt[SysPathMax] = {0,0,0,0,0,0,0,0};

	INT16U   dBmTomW[35] = {	501,447,398,355,316,282,251,224,200,178,
							158,141,126,112,100,89,79,71,63,56,
							50, 45, 40, 35, 32, 28,25, 22, 20, 18, 
							16, 14, 13, 11, 10};

	INT16U   mWTodBm[35] = { 270,265,260,255,250,245,240,235,230,225,
							220,215,210,205,200,195,190,185,180,175,
							170,165,160,155,150,145,140,135,130,125,
							120,115,110,105,100};  ///Start 27dBm


	INT8U tAGC10_ATTENMAX_3G = 0;
	INT8U tAGC_ATTENMAX_2G = 0;
	INT8U tAGC_ATTENMAX_LTE = 0;
	INT8U tAGC_ATTENMAX_LTE_1 = 0;
	INT8U tAGC_ATTENMAX_LTE_A1 = 0;
	INT8U tAGC_ATTENMAX_LTE_A2 = 0;
	INT8U tALC_ATTENMAX_2G = 0;


	INT8U	AlarmLEDSts[SysPathMax][SysPathMax] = {0,0,0,0,0,0,0,0};
	INT16U SleepModeCnt[SysPathMax] = {0,};
	INT8U chkSleepMode[SysPathMax] = {0,};

	INT8U InitSleepMode[SysPathMax] = {0,};


#else
	extern OS_EVENT *AlcSem;

	extern INT8U FlagAmpOnOff_2G;
	extern INT8U FlagAmpOnOff_3G;
	extern INT8U FlagAmpOnOff_LTE;
	extern INT8U FlagAmpOnOff_LTE_A1;
	extern INT8U FlagAmp1OnOff_LTE;
	extern INT8U FlagAmp1OnOff_LTE_A1;
	//////////////////////////////////////
	extern	INT8U	Sd_Step[SD_SysMax];
	extern	INT8U	Sd_Cnt[SD_SysMax];
	extern	INT8U	Sd_Path[SysPathMax];
	extern	INT8U	Amp_Step[SysPathMax];

	extern INT16U	LimitAlarmCnt[SysPathMax];
	extern INT16U SleepModeCnt[SysPathMax];
	extern INT8U chkSleepMode[SysPathMax];
	extern INT8U InitSleepMode[SysPathMax];

#endif


_USR_EXT_ALC  INT8S tmpRvsALCLvl_2G;
_USR_EXT_ALC  INT8S tmpRvsALCLvl_LTE;
_USR_EXT_ALC  INT8S tmpRvsALCLvl_LTE_A1;
_USR_EXT_ALC  INT8S tmpRvsALCLvl_LTE_A2;
_USR_EXT_ALC  INT8S tmpRvsALCLvl_3G;
_USR_EXT_ALC  INT8S tmpRvs1ALCLvl_LTE;
_USR_EXT_ALC  INT8S tmpRvs1ALCLvl_LTE_A1;
_USR_EXT_ALC  INT8S tmpRvs1ALCLvl_LTE_A2;

_USR_EXT_ALC  INT8S tmpRvsAttn1_2G;


_USR_EXT_ALC  INT8S CurrAgcAttn_3G;
_USR_EXT_ALC  INT8S CurrAgcAttn_2G;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_A1;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_A2;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_1;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_A1_1;
_USR_EXT_ALC  INT8S CurrAgcAttn_LTE_A2_1;
_USR_EXT_ALC  INT8S CurrRvsAgcAttn_3G;
_USR_EXT_ALC  INT8S CurrRvsAgcAttn_2G;
_USR_EXT_ALC  INT8S CurrRvsAgcAttn_LTE;
_USR_EXT_ALC  INT8S CurrRvsAgcAttn_LTE_A1;
_USR_EXT_ALC  INT8S CurrRvsAgcAttn_LTE_A2;

_USR_EXT_ALC  INT8S CurrRvsAgcAttn_LTE_1;
_USR_EXT_ALC  INT8S CurrRvsAgcAttn_LTE_A1_1;
_USR_EXT_ALC  INT8S CurrRvsAgcAttn_LTE_A2_1;


void ADC_Init(void);
void ADC_Task(void * pdata);

void ReadAdcValue_TRIO (void);;

INT8S PwrTableOffset(INT8S Temp,INT8U tIndex);

INT16S ReadPwrTableDnr(INT32U AdcValue, INT8U TblID, INT8U roundingoff, INT8U *isminval, INT16S Offset);
INT16S Dnr0_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation);
INT16S Dnr1_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation);
INT16S Svr0_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation);
INT16S Svr1_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation);


INT8S Table_Operation(INT8S Pwr,INT8S tGain,INT8S tAttn,INT8S tOffset);

INT8S OneOutPwrConv(INT8S *Vaule);
void TwoOutPwrConv(INT8S *dptr, INT8S Vaule);
void TwoOutPwrConvINT(INT8S *dptr, INT16S Vaule);

INT16S GainAttnCalculation(INT16S cGain, INT16S cGainMax,INT8S cAttMin);
INT8U TemptoIndex(INT8S temp);
INT8S AGCCheck(INT32S tmpx10,INT32S tlimitLow,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax, INT8U AttMin,INT8S AmpOnOff, INT8U Mode);

void AGCCheckFunction(void);

void FwdAGCCheck_CDMALTE_15M(void);
void FwdAGCCheck_CDMALTE(void);
void FwdAGCCheck_LTE_A_0(void);
void FwdAGCCheck_WCDMA(void);
void FwdAGCCheck_LTE_1(void);
void FwdAGCCheck_LTE_A_1(void);



void AlcInit(void);

void ReadAdcValue(void);
 

void ShutdownFunc(INT8U SysPath, INT8U Path);
void AmpBitReason(INT8U SysPath, INT8U EnSts, INT8U Reason, INT8U AmpSts);


void TwoOutPwrConv_INT(INT8S *dptr, INT16S Vaule);
void ULTwoOutPwrConvINT(INT8S *dptr, INT16S Vaule);
void RvsOSCAlarmCountFunc(INT8U SysPath, INT8U Path);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

