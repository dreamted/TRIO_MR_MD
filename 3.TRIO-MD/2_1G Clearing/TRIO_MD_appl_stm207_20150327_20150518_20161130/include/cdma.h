/*******************************************************************************
 *
 * This module contains the function 7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 *
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
#ifdef SMS_C
	#define _USR_EXTSMS
#else
	#define _USR_EXTSMS	extern
#endif
////////////////////////////////////////////////////////////////////////////////

typedef struct
{
	
	INT8U	HostNumber[11];
	INT8U	MinNumber[11];
	INT8U	EsnNumber[19];		
	INT8U 	RxMaxVal[2];
	INT8U 	RxMinVal[2];
	INT8U 	TxMaxVal[2];
	INT8U 	TxMinVal[2];	
	INT8U 	AdjMaxVal[2];
	INT8U 	AdjMinVal[2];
	INT8U 	EcIo;
	INT8U 	AR_Mode[2];
	INT8U 	Radio_ReportTime[2];
	INT8U 	Radio_ReportPeriod[2];
	INT8U 	TestStn[11];
	INT8U	AlarmMask;
	
	INT8U	AutoReportPer;
	INT8U	AutoReportBasePer[2]; // 0x0a -> 10시 , 0x10 -> 16분 표시
}_SmsInfoCtrl;

typedef struct
{
	INT8U SMS_Alarm[2];
	INT8U SMS_TxRetry;
	INT8U ActChannel[3];
	INT8U OneFAStatus;
	INT8U FARxVal[2];
	INT8U TxVal[2];
	INT8U PN_Val[12];
	INT8U EcIo_Val[6];
	INT8U FAAdjVal[2];
	INT8U FAFerVal;
	INT8U PresentHour;
	INT8U PresentMin;
	
}_SmsInfo;



////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

#define IdleMode				0
#define NormalMode				1

#define LineLengh 				30
#define VersionNum 				1

#define DnrVersionNum 			1
#define RmtVersionNum 			1


_USR_EXTSMS __ProtocolPtr 	*SmsSer, SmsSerB;
_USR_EXTSMS __ProtocolPtr 	*ModemSer, ModemSerB;


_USR_EXTSMS __BODYFRAME 	Swrcssms, Rwrcssms;

_USR_EXTSMS __WRCSSIO 		Stcpsms, Rtcpsms;

_USR_EXTSMS __WRCSSIO 		STcpBuff, RTcpBuff;


#define DownloadMinNumCMD		0x09

//#define SMS_BODYSIZEMAX		1024	
//#define SMS_BODYSIZEMAX		700	
#define SMS_BODYSIZEMAX		2048	

/////////////////////////////////////////////////////

#define  STN_SIZE	(11)	// Host STN, Test Min Size

typedef __packed struct
{
	INT8U	Arm[2];
	/*
	Arm[0] : bit765432차례로 rx, tx, adj 하한/상한 알람.
	Arm[1] : ecio limit alarm
	*/
	INT8U	modem_maker;
	INT8U	modem_model;
	INT8U	modem_ver[2];

	INT8U   RepArTime[2];     
	INT8U   RfArTime[2];     
	INT8U   ArMode[2]; // 각각 전파 및 Idle 전파, 자동보고 모드 : 측정및보고(1), 측정후알람보고(2), 보고안함(3)
	INT8U   ArPeriod[3];	// [상태/전파1/전파2]
	/*
	// 자동보고주기
	0x01 - 5분 주기
	0x02 - 10분 주기
	0x03 - 20분 주기
	0x04 - 30분 주기
	0x05 - 1 시간 주기
	0x06 - 2 시간 주기
	0x07 - 4 시간 주기
	0x08 - 6 시간 주기
	0x09 - 12 시간 주기
	*/

	INT8U   HostID[STN_SIZE];     
	INT8U   TestMin[STN_SIZE];
	INT8S	RxLmt[2];
	INT8S	TxLmt[2];
	INT8S	AdjLmt[2];
	INT8S	EcIoLmt;

	INT8U   SysTime[6];	// 현재 시스템 시간, 모뎀에서 얻은 시간, [3/4/5] ==> 시/분/초
	INT16U  ArRemain[3]; // 자동보고 남은 시간
	INT8U   LastSMSTime[6];
	INT8U   LastARTime[6];
	INT8U   Min[STN_SIZE];     
	INT8U   Esn[19]; // 2G일때는 8, 3G일때는 19 사용한다.    
//	INT8U   RfAlarm[2];     
	INT8U   sms_tx_co;     
	INT16U	channel;     
	INT8U   fa_st;    
	/*
	0x01: Not-Allocated FA -> 미사용
	0x02: Candidate FA -> 미사용
	0x03: Current FA
	0x04: 측정실패(Call Setup Fail)
	0x05 : Call Drop
	*/

	INT8S	rx;     
	INT8S	tx;     
	INT8S	adj;     
	INT8S	fer;     
	INT16U	pn[6];     
	INT8S   ecio[6];    
	INT8U   IMSI[19];    
	INT8U   Modem_On_Off;
	INT8U	ESN_CheckSUM[2];
	INT8U   SMS_Debug_Mode;
	INT8U   SMS_Debug_Mode_co; // PHONE
	INT8U   Modem_Type; // 모뎀이 2G모뎀인지, 3G모뎀인지..., 값은 2G('C') or 3G('W'), Default 2G
}SMS_ST_STR;


//////////////////////////////////////////////////

enum
{
	Index_ResetAlarm = 1,			///1
	Index_BootAlarm,
	Index_ACAlarm,
	Index_ErrRsp,
};

#define	DNMAX				2048
#define	ALARM_LEN			8

#define SMSdata				1
#define TCPdata				2



enum
{
	Index_FTPFileSize = 2,			///1
	Index_FTPFileErase = 3,
	Index_FTPGet = 6,
	Index_FTPOnen = 8,
	Index_ModemBaudRate = 9,

};


////////////////////////////////////////////////////////////////////////////////
#if defined( SMS_C )
////////////////////
	#define CDMA_START_STK_SIZE 	256

	static OS_STK CDMATaskStk[CDMA_START_STK_SIZE];
	OS_EVENT *CdmaSem = NULL;

	INT8U HostStation[13];
	INT8U TestStation[13];

	INT8S iPNVal_Old[12];

	INT8U BootAlarmFlag = FALSE;
	INT8U ACAlarmFlag = 0;

	
	INT8U TimeStart=0;
	long  TimeElapse=0;
	INT8U iSMS_Debug_Mode = 0;
	INT8U PeriodStart=1;

	INT8U PnChangeCnt;
	INT8U PnAlarm;
	INT8U PnAlarmOld = 0;
	INT8U PnAlarmNew=0;
	INT8U PnAlarmFlag = 0;

	INT8U RxTxAlarmNew=0;
	INT8U RxTxAlarmFlag = 0;
	INT8U RxTxAlarmOld = 0;
	INT8U EcIoNew=0;
	INT8U EcIoFlag = 0;
	INT8U EcIoOld = 0;

	INT8U EsnChecksumH = 0;
	INT8U EsnChecksumL = 0;
	char *DnrVerString = "Ver0.4:Dnr Center TEST	 ";

	INT8U PresentDay;
	INT8U PresentHour;
	INT8U PresentMin;
	INT8U PresentSec;
	INT8U PresentMonth;


	INT16U PastHour;
	INT16U PastMin;

	INT16U WTwoPastHour;
	INT16U WTwoPastMin;

	INT8U WTwoTimeStart=0;
	long  WTwoTimeElapse=0;
	INT8U WTwoPeriodStart=1;

	INT16U WThreePastHour;
	INT16U WThreePastMin;

	INT8U WThreeTimeStart=0;
	long  WThreeTimeElapse=0;
	INT8U WThreePeriodStart=1;

	INT8U	chkDnrAlarmReport = 0;

	INT8U	chkPwrAlarmReport = 0;
	INT8U	PwrAlarmFlag = 0;

	INT8U	InitPwrAlarm = 1;

	INT8U	chkAlarmMaskReport = 0;

//	INT8U SetTime[6];
//	INT8U InitTime[6];

	INT16U cur_10s_time = 0xFFFF;

	INT8U SET_ULAlarmCnt = 0;

	INT16U LockOrderCnt = 0;
	INT16U chkLockOrder = 0;

//	INT8U WcdmaRtryNo = 0;
	INT32U AutoResetCnt = 0;
	INT8U AutoResetFlg = 0;


	long  tTimeElapse=0;

	INT8U RptReset = 0;

	#if 1  ////SMS
	INT8U RxDataBuff[DNMAX]	= {0,};
	INT8U RxDataBuff1[DNMAX]	= {0,};

	INT8U  	DataBuff[DNMAX]	= {0,};

	INT8U	Booting = 0xff;
	INT8U	BootFlag = 0;
	INT8U	g_ubModemPwrOff=0;

	INT16U	AlarmTimer[50]={0,};
	INT8U   AlarmBuffer[ALARM_LEN]={0,};
	INT8U   AlarmData[ALARM_LEN]={0,};
	INT8U   AlarmFlag[ALARM_LEN]={0,};

	INT8U	f_UserWaveCheckData_REQ=0;

	INT8U	Past30Sec = 0;

	INT8U	NmsTimeHour, NmsTimeMin;
	INT8U	StableCheckFlag=0;
    INT8U	StableCheckFlag_c=0;

	INT8U	ComFailCnt = 0;
	BOOL	NmsDownErrFlag = FALSE;
	INT8U   DataMode = SMSdata;

	INT8U	f_NmsSystemResetReq = 0;
	INT8U	ResetActFlag=0;
	INT8U	*SAlarmData[2], SAlarmDataB[2];		// Dummy

	INT8U  	PhoneNumber[12]={0,};
	INT8U	Send3Buf[Tx2BUF_LEN];
	INT8U	Send2Buf1[Tx2BUF_LEN];

	INT8U 	PresentYear[4];
	INT8U	PresentMonth1[2];
	INT8U	PresentDay;
	INT8U	PresentHour;
	INT8U	PresentMin;
	INT8U	PastDay;
	INT8U	PastHour1;
	INT8U	PastMin1;
	INT8U   PresentSec1;
	
	INT8U	TimeStart1=0;
	INT16U	TimeElapse1=0;
	INT8U	PeriodStart1=1;

	INT8U   IpCnt;
	INT8U   GmsIpAddr[15];
    INT8U   GmsPort[4]; 

	INT8S	PnFixMode = '0';

	INT8U	AutoRReportBuff[100]={0,};
 	INT8U	AutoRReportBuffLen = 0;

	int		CurrFer=0, CurrRx=0, CurrAdj=0, CurrTx=0;
	int		TempFer=0, TempRx=0, TempAdj=0;

	#endif


	INT8U TcpCnt = 10;


	INT8U TcpStop = 0;
	INT8U TcpData = 0;

//	INT8U AutoRptChk = 0;

//AutoRptChk
	INT16U FTPFrameCnt = 0;
	INT16U FTPTotFrame = 0;
	INT32U FTPFileSize = 0;

	INT8U FTPMode = 0;
	INT8U TrsnsferMode = 0;

	INT16U Frame_Cnt = 0;
	INT8U DNMode = 0;

	INT32U DNModeCnt = 0;
	INT32U DNModeMaxCnt = 0;

#else

	extern OS_EVENT *CdmaSem;

	extern INT8U TestStation[13];
	extern INT8U HostStation[13];
	
	extern INT8U iSMS_Debug_Mode;

	extern INT8U chkDnrAlarmReport;

	extern INT8U chk_1StStsReport;

	extern INT8U ACAlarmFlag;

	extern INT8U TimeStart;
	extern long  TimeElapse;
	extern INT8U PeriodStart;

	extern INT8U PresentDay;
	extern INT8U PresentHour;
	extern INT8U PresentMin;
	extern INT8U PresentMonth;

	extern INT8U HostStation[13];
	extern INT8U TestStation[13];
	extern INT8U ModemStation[13];

	extern INT8U EsnChecksumH;
	extern INT8U EsnChecksumL;

	extern INT8U WTwoTimeStart;
	extern INT8U WTwoPeriodStart;
	extern INT16U cur_10s_time;

	
	extern INT8U SET_ULAlarmCnt;

	
	extern INT16U LockOrderCnt;
//	extern INT8U WcdmaRtryNo;
	extern INT32U AutoResetCnt;
	extern INT8U AutoResetFlg ;

	extern INT8U RptReset;
	#if 1

	extern	INT8U	Booting;

	extern INT8U TcpStop;
	extern INT8U TcpData;
	extern INT8U ISOOnOffMode;
	extern INT16U FTPFrameCnt;
	extern INT16U FTPTotFrame;
	extern INT32U FTPFileSize;
	extern INT8U FTPMode;
	extern INT8U TrsnsferMode;

	extern INT16U Frame_Cnt;

	extern INT8U RxDataBuff[DNMAX];
	extern INT8U DNMode;
	extern INT32U DNModeCnt;
	extern INT32U DNModeMaxCnt;

	#endif

#endif

_USR_EXTSMS __BODYFRAME2 	*Snms, SnmsB;
_USR_EXTSMS __BODYFRAME2 	*Rnms, RnmsB;

_USR_EXTSMS SMS_ST_STR	m_sms;

//////////////////////////////
_USR_EXTSMS INT8U SmsResetPeriodFlag;
_USR_EXTSMS INT8U TcpDnLoadFlag;
_USR_EXTSMS INT32U OneDayResetCnt;

_USR_EXTSMS INT32U OneDayPeriod;
_USR_EXTSMS INT32U tPeriod;

_USR_EXTSMS INT8U PcFreqStsRqstFlag;
_USR_EXTSMS INT8U SmsTxFailFlag;


_USR_EXTSMS INT8U FirstFlag;
_USR_EXTSMS INT16U iMobileESN;

_USR_EXTSMS INT8U iMasterPNH;
_USR_EXTSMS INT8U iMasterPNL;


_USR_EXTSMS INT8U iTxValH;
_USR_EXTSMS INT8U iTxValL;
_USR_EXTSMS INT8U t1SndData[512];

_USR_EXTSMS INT8U chkReport;

_USR_EXTSMS INT8U	iPresentHourCnt;
_USR_EXTSMS INT8U	iPresentMinCnt;
_USR_EXTSMS INT8U	iSecCnt;

//------------------------------------------//
//	AutoRptPeriod							//
//------------------------------------------//
	#define Rpt_5Min				0x01 // 5분 주기
	#define Rpt_10Min				0x02 // 10분 주기
	#define Rpt_20Min				0x03 // 20분 주기
	#define Rpt_30Min				0x04 // 30분 주기
	#define Rpt_1Hour				0x05 // 1 시간 주기
	#define Rpt_2Hour				0x06 // 2 시간 주기
	#define Rpt_4Hour				0x07 // 4 시간 주기
	#define Rpt_6Hour				0x08 // 6 시간 주기
	#define Rpt_12Hour				0x09 // 12 시간 주기
	#define Rpt_1Day				0x10 // 1일 주기
	#define Rpt_2Day				0x11 // 2일 주기
	#define Rpt_3Day				0x12 // 3일 주기
	#define Rpt_7Day				0x13 // 7일 주기
	#define Rpt_Not 				0x7F // 자동보고 안함



////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////


#define HIGH            1
#define LOW             2

////////////////////////////
void SmsInit(void);
void DnrSmsTask(void * pdata);

INT32U CheckTime(INT8U *tCount,INT32U tTime,INT8U Mode);

void ResetPeriodSet(void);
INT32S CdmaFuncselect(void);
void AutoResetCheck(void);
void SmsAlarm(void);
void SmsAutoReportCheck(__ProtocolPtr *nPtr);

INT32U Sms1_Protocol_Check(__ProtocolPtr *nPtr);
INT8U WhatRxSms(__ProtocolPtr *nPtr);

void SmsComCheck (__ProtocolPtr *nPtr);
void SmsStsTransmitData(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr);

INT8U Sms_Response_Control(__ProtocolPtr *nPtr, INT8U Ctrl);

void DnrSMS2Data(void);


void SmsDataAckTx (INT8U* tid, INT8U *Data, INT16U nCnt,  INT8U Comm,__ProtocolPtr *nPtr);
void Sms_DataAckTx(INT8U Comm,__ProtocolPtr *nPtr);

BOOL AutoRptChk ( void );
BOOL WavTwoAutoRptChk ( void );
BOOL WavThrAutoRptChk ( void );

void ModemEsnCheck ( void );
void WhatTime(void);
void SwHistroyRspFunc (INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr);
void DnrIpAddressAck(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr);
void DnrPacketReadyFunc(__ProtocolPtr *nPtr);
INT8U TcpExit(void);


void SpecFreqState_RspFunc (INT8U* tid,INT8U Comm, INT8U Auto, INT8U Idle,__ProtocolPtr *nPtr );

INT8U TrafficCheck(void);
void SpecFreqStateUpdate ( void );
void FreqAlarmCheckRpt (INT8U* tid,__ProtocolPtr *nPtr);
void FreqAlarmRptFunc(INT8U* tid,__ProtocolPtr *nPtr);

INT32U TCPRxProtocolCheck(__ProtocolPtr *nPtr);

INT8U WhatRxTCP(__ProtocolPtr *nPtr);
void TCPComCheck (__ProtocolPtr *nPtr);
unsigned char TCPProDataAckTx (INT8U* tid, INT8U *Data, INT16U nCnt,  INT8U Comm,__ProtocolPtr *nPtr);


INT8U DataConv ( INT8U HighLow, INT8U Value );
INT8S TwoAsciNum2OneHex( INT8U Upper, INT8U Lower );
INT8U TwoAsciDeciNum2OneHex( INT8U Upper, INT8U Lower );


INT8U htod (INT8U value );
INT8U dtoh (INT8U value );

INT16U GenSmsStsAidSts_1St(INT8U *dptr, __Dnr_Sts *Sts);
INT16U GenSmsStsAidSts_2St(INT8U *dptr, __Dnr_Sts *Sts);

INT16U GenWaveStsAid(INT8U *dptr, __Dnr_Sts *Sts);

INT16U DnrAlarmReport(INT8U *dptr, __ProtocolPtr *nPtr );

void SmsAlarmRptFunc(INT8U Index, INT8U Comm ,INT8U Code, __ProtocolPtr *nPtr);

void Auto_ResetCheckInit(void);

INT16U GetPeriod( INT8U idx );
INT8U CheckARTime( INT8U idx );
void CalcARTime( INT8U idx );
INT8U CheckARTime( INT8U idx );
INT16S Rfatoi( INT8U *str, INT8U Len );


INT32U AutoTimeChk ( INT8U ReportPriod );

void SmsEtcTransmitData(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr);
INT16U GenEtc1StsAid(INT8U *dptr, __Dnr_Sts *Sts);

INT8U atoh (INT8U value );

INT8U Ascii2Hex ( INT8U Upper,INT8U Lower );
INT8U AHex2Dig( INT8U *d );

unsigned protocol_frame_to_buffer(unsigned char* frame, int frame_size, unsigned char* buffer, int* buffer_size);
INT32U FTPRxProtocolCheck(__ProtocolPtr *nPtr,INT8U *rbuf,INT16U Len,INT16U Cnt,INT16U FrameCnt);


extern INT16U	FrameCnt;

void FTPSts(INT8U *dptr,INT16U Len);
INT16U FTPDownloadheck(__ProtocolPtr *nPtr);
INT32U FTP_Mode(INT8U Mode,__ProtocolPtr *nPtr);


