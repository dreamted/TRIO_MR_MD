
#ifdef Protocol_C
	#define	_USER_Protocol
#else
	#define _USER_Protocol		extern
#endif

#define Enable 				0
#define Disable 			1

#define Normal				0
#define Alarm				1

#define Install				1
#define Uninstall			0

#define _Off				0
#define _On 				1

#define _Manual 			0
#define _Auto 				1

#define _Normal 			0
#define _Bypass 			1


#define _AGC_Mode 			0
#define _ALC_Mode 			1


#define DIGATTENMAX				63		//31.5dB
#define ATTENMAX				60		//30.0dB
#define ATTENMIN				0

#define DIGATTENMAX_2G			25*2

#define GainATTENMAX			50*2		//31.5dB


#define AGC25_ATTENMAX_2G		25*2
#define AGC25_ATTENMAX_LTE		25*2
#define AGC20_ATTENMAX_LTEA		20*2

#define RVSAGC20_ATTENMAX_2G	20*2
#define RVSALC20_ATTENMAX_2G	20*2

#define RVSAGC20_ATTENMAX_LTE	20*2
#define RVSALC25_ATTENMAX_LTE	25*2

#define AGC10_ATTENMAX_3G		10*2
#define AGC20_ATTENMAX_3G		20*2
#define RVSALC20_ATTENMAX_3G		20*2

#define RVSAGC15_ATTENMAX_LTE_A2	15*2
#define RVSALC20_ATTENMAX_LTE_A2	20*2

/////////////////////////////////////////////////

#define Gain_2G					81*2
#define Gain_LTE				81*2
#define Gain_3G					83*2
#define Gain_LTE_A				86*2


#define DefaultGain_2G			31*2
#define DefaultGain_LTE			31*2
#define DefaultGain_3G			43*2
#define DefaultGain_LTE_A		41*2



#define DefaultGainBalance		5
#define ToggleRvsAttn_2G		5*2


#define AGCMAX_2G				50*2
#define tRvsALCMAX_2G			45*2

#define AGCMAX_LTE				50*2
#define tRvsALCMAX_LTE			47*2

#define AGCMAX_3G				43*2
#define tRvsALCMAX_3G			45*2

#define AGCMAX_LTE_A1			45*2
#define tRvsALCMAX_LTE_A1		50*2



#define FwdMinGain_2G			31*2
#define FwdMinGain_LTE			31*2
#define FwdMinGain_LTE_A		41*2
#define FwdMinGain_3G			43*2

#define RvsMinGain_2G			18*2
#define RvsMinGain_LTE			18*2
#define RvsMinGain_LTE_A		33*2
#define RvsMinGain_3G			38*2

#define tGain_2G				73
#define tGain_LTE				73
#define tGain_3G				83
#define tGain_LTE_A				83

#define LowPwrLmt				-60*2
#define LowOutPwrLmt			0*2;
#define DLLowPwrLmt				-90*2

#define NoSignal				90
#define RvsNoSignal				105

#define PwrNoSignal				0xFFFF
//#define ULLowPwrLmt				-90*2
#define ULLowPwrLmt				-105*2


#define OtherFwdOverInLmt_CDMALTE		-36*2 	//// -35dBm에서 동작 
#define OtherFwdOverInLmt_LTE_A			-38*2 	///// -37dBm에서 동작 
#define OtherFwdOverInLmt_3G			-37*2 	//// -36dBm에서 동작 

///////////////


// CDMA SB#1   LTE SB#2  LTE 15M SB#3  LTE-A1 SB#4  LTE-A2 SB#5 WCDMA SB#6
#define FwdOverInAlmLmt_2G			-24
#define FwdOverInSDAlmLmt_2G		-11

#define FwdOverInAlmLmt_LTE			-21
#define FwdOverInSDAlmLmt_LTE		-8
#define FwdOverInSDAlmLmt_LTE15M	-6
#define FwdOverInAlmLmt_LTE15M		-19


#define FwdOverInSDAlmLmt_LTE_A2	-15
#define FwdOverInSDAlmLmt_3G		-19


///////////////////////////////////////////////
#define FwdOverInAlmLmt_LTE_A		-15
#define FwdOverInAlmLmt_3G			-18
///////////////////////////////////////////////

#define FwdHighLmt_2G			17
#define FwdHighLmt_LTE			20
#define FwdHighLmt_LTE15M		22


#define FwdHighLmt_LTE_A2		23
#define FwdHighLmt_3G			21

#define RvsHighLmt_2G			21
#define RvsHighLmt_LTE			21
#define RvsHighLmt_LTE_A		21
#define RvsHighLmt_3G			21
///////////////////////////////////////////////////


#define FwdOutAvgPwr_2G_TblLmt		22*2 	
#define FwdOutAvgPwr_2G_TblSize		26

#define RvsOutPwr_2G_TblLmt			26*2 	
#define RvsOutPwr_2G_TblSize		50 	

#define FwdOutAvgPwr_LTE_TblLmt		25*2 	
#define FwdOutAvgPwr_LTE_TblSize	26 	

#define RvsOutPwr_LTE_TblLmt		26*2 	
#define RvsOutPwr_LTE_TblSize		47 	

#define FwdInPwr_CDMALTE_TblLmt		-4*2 	
#define FwdInPwr_CDMALTE_TblSize	47

#define FwdOutAvgPwr_CDMALTE_TblLmt		27*2 	
#define FwdOutAvgPwr_CDMALTE_TblSize	21 	

#define RvsInPwr_CDMALTE_TblLmt		-12*2 	
#define RvsInPwr_CDMALTE_TblSize	31 	

#define FwdOutAvgPwr_LTE_A2_TblLmt		28*2 	
#define FwdOutAvgPwr_LTE_A2_TblSize		26	

#define RvsOutPwr_LTE_A2_TblLmt		26*2 	
#define RvsOutPwr_LTE_A2_TblSize	38 	

#define RvsInPwr_3G_TblLmt			-12*2 	
#define RvsInPwr_3G_TblSize			31 	

#define RvsOutPwr_3G_TblLmt			26*2 	
#define RvsOutPwr_3G_TblSize		40 	

#define FwdInPwr_LTE_A_TblLmt		-15*2 	
#define FwdInPwr_LTE_A_TblSize		32	

#define RvsInPwr_LTE_A_TblLmt		-12*2 	
#define RvsInPwr_LTE_A_TblSize		39 	

#define RvsOutPwr_LTE_A_TblLmt		26*2 	
#define RvsOutPwr_LTE_A_TblSize		38 	

#define RvsOutPwr_CDMALTE_TblLmt	26*2 	
#define RvsOutPwr_CDMALTE_TblSize	21 	

#define FwdInPwr_3G_TblLmt			-17*2 	
#define FwdInPwr_3G_TblSize			34 	



#define FwdOutAvgPwr_3G_TblLmt		28*2 	
#define FwdOutAvgPwr_3G_TblSize		21 	





///////////////////////////////////////////
#define __Alarm				0x01
#define __Normal			0x00

#define __ON				0x01
#define __OFF				0x00

#define __USE				0x01
#define __NOTUSE			0x00
///////////////////////////////
// Download

#define NODownLoading			0
#define Ser0DownLoading			1
#define Ser1DownLoading			2
#define EtherDowning			3

#define Ser2DownLoading			4
#define Ser3DownLoading			5
#define Ser4DownLoading			6

#if 0
#define STX						0x16			// Start code
#endif
#define ETX						0x03			// End code

////////////////////////////////////////////////////////////////////////////////
// Repeater Type
//
//0x01 44 : DDR-W 
//0x01 45 : DDR-Duo(CDMA, WCDMA)
//0x01 46 : DDR-TM(WCDMA, CDMA, WIBR)
//0x01 47 : DDR-WIM(WCDMA, WIBRO)
//0x01 48 : DDR-I(WIBRMO)
//0x01 49 : DDR-IM(WIBRO MIMO)

#define DDR_DUOType	0x0144		// (DUO )
#define DDR_TMType	0x0145		// (TM )
#define DDR_WType	0x0160		// (WCDMA 단독형)


#define TRIO_RCODE			0x34	 

#define TRIO_M_TYPE			0x025A
#define TRIO_MM_TYPE		0x025C

#define UserReset			0x01
#define FWDownReset			0x02
#define PowerReset			0x03
#define EtcReset			0x04

////////////////////////////////////////////////////////////////////////////////
// command
#define	NODATA						0xCD

//===============//
// SCODE command //
//=============================================================================//

#define EtcInforStsQue				0x77
#define Etc1InforStsQue				0x78


#define StatusQue					0x00
#define ControlQue					0x01

#define InforStsQue					0x66

#define FuncControlQue				0xA2

#define AlarmSCODE					0x02
#define	TableStsRQST				0x50
#define VoltDetect					0xA1
#define ErrorSCODE					0x7f

#define DDRTableSetQue				0x75
#define DDRTableStsQue				0x76

#define DefaultQue					0x8E


#define ModuleTableSetQue			0xA0
#define ModuleTableStsQue			0xA1

#define AlarmSCODE					0x02
#define AlarmMaskSetSCODE			0x03
#define RestartSCODE				0x04
#define AutoReportSCODE				0x05
#define ResetQue					0x05
#define SwHistorySCODE		 		0x0a

#define	OffsetStsSCODE				0x2F
#define SpecFreqStateSCODE			0x20
#define RadioAutoReport				0x21
#define IdleStatusReport			0x22
#define FreqConfigValSCODE			0x23

#define RadioSetRQST				0x24
#define RadioAlarmReport			0x25

#define RadioStsRQST				0x26
#define SetDebugMode				0x2A

#define WaveDebugMode				0x88

#define SDRDebugMode				0x99

#define VoltageStsRQST				0xA1

#define DnrIpAddressSCODE			0x14
#define ErrorSCODE					0x7f
#define ErrorCODE					0xff
#if 0
#define	DownloadCMD					0x0b
#define	DownloadCMDConfirm  		0x0c
#define	DownLoadData				0x0d
#define	DownLoadDataConfirm			0x0e
#endif
#define	Wcdma_DownloadCMD			0x10
#define	Wcdma_DownloadCMDConfirm	0x11
#define	Wcdma_DownLoadData			0x12
#define	Wcdma_DownLoadDataConfirm	0x13

#define	Cdma_DownloadCMD			0x20
#define	Cdma_DownloadCMDConfirm		0x21
#define	Cdma_DownLoadData			0x22
#define	Cdma_DownLoadDataConfirm	0x23

#define	Wibro_DownloadCMD			0x30
#define	Wibro_DownloadCMDConfirm	0x31
#define	Wibro_DownLoadData			0x32
#define	Wibro_DownLoadDataConfirm	0x33

#define AmpStatusQue				0xA0
#define AmpControlQue				0xA2
#define MakeStatusQue				0xA0



#define	Module_DownloadCMD			0xE0
#define	Module_DownloadCMDConfirm	0xE1
#define	Module_DownLoadData			0xE2
#define	Module_DownLoadDataConfirm	0xE3



//---------- Download
#define	AmpDownloadCMD				0x70
#define	AmpDownloadCMDConfirm		0x71
#define	AmpDownLoadData				0x72
#define	AmpDownLoadDataConfirm		0x73

#define PAUStatusRQST				0x50
#define PAUStatusRSPS				0x50

#define MWEnableRQST				0x51
#define MWDisableRQST				0x52
#define MWFreqSetRQST				0x53
#define MWCableLossRQST				0x54

#define CdmaAmpEnableRQST			0x51
#define CdmaAmpDisableRQST			0x52

#define WcdmaAmpEnableRQST			0x53
#define WcdmaAmpDisableRQST			0x54

#define CdmaAttRQST					0x55
#define WcdmaAttRQST				0x56

#define ModuleInformStsQue			0x60
#define ModuleInformSetQue			0xE6
#define AutoModuleInformQue			0x61


#define WaveStatusRQST				0x63


/////////////////////////////////////////////
//#define crcERROR	        	0xC1//0xEF		// Crc Error
#define LengthERROR	        	0x04
#define ErrorChk_CMD			0xEE	

#define	RCS_StatusRQST			0xA0
#define	RCS_ControlRQST			0xA1


#define	AMPRCS_StatusRQST		0x50
#define AMP0EnableRQST			0x51
#define AMP0DisableRQST			0x52
#define AMP1EnableRQST			0x53
#define AMP1DisableRQST			0x54
#define AMP0AttnCtrlRQST		0x55
#define AMP1AttnCtrlRQST		0x56
#define AmpInformRQST			0x57
#define AmpInformCtrlRQST		0x58



#define	TrackInitRQST			0x02
#define RCS_TableStsRQST		0x03
#define RCS_TableCtrlRQST		0x04

#define RCS_TableAttnStsRQST	0x83
#define TableAttnStsRSPS		0x93
#define RCS_TableAttnCtrlRQST	0x84
#define TableAttnCtrlRSPS		0x94


#define RCS_TableVoltRQST		0x05
#define TableVoltRSPS			0x05


#define	ModemStsRQST			0x02
#define ModemStsRSPS			0x12
#define	ModemCtrlRQST			0x03
#define ModemCtrlRSPS			0x13

#define	ModemFreqStsRQST		0x04
#define	ModemFreqStsRSPS		0x14

#define	AttnStsRQST				0x05
#define	AttnCtrlRQST			0x06


#define	AMPDNSTART_CMD			0x70	
#define	AMPDNCONFIRM_CMD		0x71	
#define	AMPDNDATA_CMD			0x72	
#define	AMPDNEND_CMD			0x73
#define AMPDNENDWAIT_CMD		0x74

#define DnrSwHistorySCODE		0x0A

//---------- Download
#define AmpEnableRQST				0x51
#define AmpDisableRQST				0x52

#define CdmaAmpEnableRQST			0x51
#define CdmaAmpDisableRQST			0x52

#define WcdmaAmpEnableRQST			0x53
#define WcdmaAmpDisableRQST			0x54

#define CdmaAttRQST					0x55
#define WcdmaAttRQST				0x56

////////////////////////////////////////////
// ERROR CODE
///////////

enum ErrorEnum
{
	CrcErr = 1,
	NullFrmErr,
	IDExcessErr,
	NoEquipment,
	DnrBootRom,
	RmtLnkErr,
	RmtBootRom,
	DnrDLing,
	RmtDling,
	EsnMismatch,
	LPADLing,
	EndErrorcode,
	Endcode,
};


// RCODE
enum {
	__WAFMC,
	__WDFMC,
	__WINS,
	__OPTICDIS,
	__WRFMC,
	__WRR_L,
	__DUO_L,
	__WINSPLUS,
	__KTFSUBWAY,
	__WIBROOPT,
	__MW,
	__WICS,
	__DUO_LIF,
	__DUO_METRO,
	__TOS,
	__IBS,
	__WIRR_M,
	__DUO_MN,
	__DUO_SN,
	__KT_WIBRO,
	__MPR_W2,
	__EXT_MODEM,
	__RM,
	__SM_DUO,
};

// Type
enum {
	__Basic_W,
	__AType,
	__BType,
	__SF_W20,
	__SF_W60,
	__SRFC_1,
	__SRFC_20,
	__SF_DUO6020,
	__C_20,
	__C_60,
	__W_20,
	__W_40,
	__SF_I10,
	__MW_DUO,
	__SF_I30,
	__SF_W20SLIM,
	__SF_W15,
	__TOS_W15,
	__SRF_W15,
	__SF_T421,
	__SRF_W15MRD,
	__CMW_DUO,
	__ICS_WN20,
	__RMW_DUO,
	__OMW_DUO,
	__MPR_W2_Type,
	__ICS_W5,
	__SF_I_MIMO,
	__SF_T_MIMO,
	__OFS_DUO,
	__OFS_W,
	__MW_WIM,
	__MW_IM,
	__MPR_DUO,
	__ICS_DUO,
	__ICS_WN5,
	__LR_DUO,
	__SF_TMN,
	__SF_IMN,	
	__SF_T423,	
	__SF_T223,	
	__SF_T221,	
	__SF_T023,	
	__SF_T443,
	__SF_T243,
	__SF_T241,
	__SF_T043,
	__SF_TM423,
	__SF_TM023,
	__SF_TM043,
	__SF_TM443,
	__SF_TM421,
	__SF_TM021,
	__SF_TM041,
	__SF_TM441,
	__SF_TM223,
	__SF_TM243,
	__SF_TM221,
	__SF_TM241,
	__SF_DUO2020,
	__SF_DUO6040,
	__SF_DUO2040,
	__SF_W40,
	__SF_WIM21,
	__SF_WIM23,
	__SF_WIM41,
	__SF_WIM43,
	__SF_IM10,
	__SF_IM30,
	__I_METRO,
	__TTA_W20,
	__SF_TMN423,
	__SF_TMN023,
	__SF_TMN043,
	__SF_TMN443,
	__SF_TMN4215,
	__SF_TMN0215,
	__SF_TMN0415,
	__SF_TMN4415,
	__SF_TMN223,
	__SF_TMN243,
	__SF_TMN2215,
	__SF_TMN2415,
	__SF_IMN15,
	__SF_IMN30,
};

enum {
	__SF_C60,
	__SF_C20,
	__Pub_BPlus,
	__Pub_B,
	__Ext_B,
	__Pub_A8Plus,
	__A8Plus,
};


// MobileManufacture
enum {
	__BellWave,
	__YISO,
	__Kisantel,
	__AirTec,
	__SAT,
};

// MobileModel
enum {
	BSM_850,
	BSM_860,
	BSM_856,
	E802S,
	SXB_2080,
	ATS_IM800,
	SMCM_S801C,
	SXC_2080,
	ATS_EM800,
	SMCM_S802C,
};


enum {
	_TypeDUOMSG,
	_Type2G3GMSG,
	_Type3GMSG,
};

/////// GetManuFacture //////////// 
enum
{
	Kisan = 0,
	Seohwa,
	Solid,
	Atel,
	Actipass,
	Etronics,
	Hioncop,
	Fine,
	Hykw,
	Hutec,
	Cns,
	Gst,
	Telesys,
	Git,
	Airpoint,
	Rfwin,
	Hfr,
	Gtnt,
};

// Remote Port Type
enum
{
	__8_Way = 1,
	__4_Way,
	__2_Way,
	__1_Way,
	__16_Way,
	__3_Way,
	__2G_Simplex,
	__2G_Duplex,

};
enum 
{
	__CDMA,
	__WCDMA,
};

enum {
	__MHU = 1,
	__OMHU,
	__RHU5W,
	__RHU20W,
	__RAU,
};


// AmpManufacture
enum
{
	AmpNul = 0,
	AmpGSI,
	AmpRM,
	AmpSW,
	AmpRev,
	AmpTS,
	AmpWEC,
	AmpCO,
	AmpRH,
	AmpHIC,
	AmpED,
	AmpPowerWave,

	AmpManufactureMax
};


enum {
	__UsrCtrl = 0,
	__DevAutoShutDn,
	__RvsFail,
	__TmpOvr,
	__OvrPwr,
	__DCPwrSWOff,
	__AmpLnkFail,
	__VSWRFail,
	__LoopFail,
	__DCFail,
	__SubDCPwrSWOff,
	__SwitchingFail,
	__PllFail,
	__DCAlarm,
	__DigitlaBdAlarm,
	__UnKnown0,
	__PDAlarm,
	__TrainMode,
	__OffMode,
	__Sleep_Mode,
	__OverInputAlarm,
	__TDDSyncAlarm,
	__UnKnown,
	__SyncFaiil,
	__OffCauseEnumNo
};

enum
{
	DnOtruImage = 1,
	DnOtruFpgaAppImage,		///2
	DnOtruFpgaImage,		///3
	DnRmtImage,				///4
	DnRmtFpgaAppImage,		///5
	DnRmtFpgaImage,			///6
	DnEtcImage,				///7

	DnloadImageMax
};


enum
{
	Debug_AGC = 1,			///1
	Debug_ALC,				///2
 	Debug_Download, 		///3

 	
	Debug_Alarm1,			///4
	Debug_Alarm2,			///5
	
	Debug_Max
};


enum
{
	Test_LocalFail_CDMALTE = 1,			///1
	Test_LocalFail_3G,					///2
	Test_LocalFail_LTE_A1,				///3
	Test_LocalFail_LTE_A2,				///4
	Test_LocalFail_LTE_1,				///5
	Test_LocalFail_LTE_A1_1,			///6
	Test_LocalFail_LTE_A2_1,			///7

	Test_AC_Alarm,						///8


	Test_Mode1,							///9
	Test_Mode2, 						///10
	Test_Mode3, 						///11
	Test_Mode4, 						///12
	Test_Mode5, 						///13
	Test_Mode6, 						///14
	Test_Mode7, 						///15
	Test_Mode8, 						///16

	Test_Max
};


enum {
	_TRIO_M = 0,
	_TRIO_MM,		
};

enum {
	_AGCAvgMode = 0,
	_AGCPeakMode,		
};

enum {
	_ALCMode = 0,
	_AGCMode,
	_InputALCMode,
};


enum {
	_SvrMode_2G = 0,
	_SvrMode_3G,
	_SvrMode_LTE,	
	_SvrMode_LTE_A1,
	_SvrMode_LTE_A2,
	_SvrMode_LTE1,
	_SvrMode_LTE_A1_1,
	_SvrMode_LTE_A2_1,	

	_SvrMode_CDMALTE,
	_SvrMode_LTE_A,	
	_SvrMode_Max,
	
};

#if 0
// ********************************************************
#define TWO_BODY		1

#define BODYSIZEMAX			2048			// Body data Max 11K
#define SMSBODYSIZEMAX		1024			// Body data Max 11K

// ********************************************************
// Struct of Frame
#pragma pack(1)

typedef struct {
	
	INT8U	SubID[3];		// 0: Dest					   
	INT8U	Command;		// Command
	INT8U	RCode;			// Repeater Code
	INT8U	SubLen[2];		// SUB_DATA filed length
	INT8U	SubData[BODYSIZEMAX];
	//////////////////////////////////////////////////
	INT16U	SubLength;

	INT16U	Crc;			// SIO CRC
	BOOL    CrcOK;
} __BODYFRAME;


typedef struct {

	INT8U	Sync[4];
	INT8U  	TryNo;
	INT8U	BodyLen[2];	
	INT8U	CheckSum;

	__BODYFRAME BodyFrame[TWO_BODY];
	//INT8U  	SubID[3];

	//INT8U	Command;
	//INT8U	Rcode;
	//INT8U	SubLen[2];
	//INT8U	SubData[BODYSIZEMAX];
	//INT16U	Crc;
	//------------------------------//	Tail
	//------------------------------//	Etc.. (상위프로그램과 연관 없음)
	INT16U	BodyLength;
	INT8U	BodyNo;			// received body cnt!!
	INT8U   cBody;			// current body cnt!!
	
	//INT16U	SubLength;
	//INT8U	CrcErr;
	//BOOL	CrcOK;
	//INT8U 	OrgDstID;
	//INT8U	OrgSrcID;
} __WRCSSIO;



typedef struct {
	
	INT8U	SubID[3];		// 0: Dest					   
	INT8U	Command;		// Command
	INT8U	RCode;			// Repeater Code
	INT8U	SubLen[2];		// SUB_DATA filed length
	INT8U	SubData[SMSBODYSIZEMAX];
	//////////////////////////////////////////////////
	INT16U	SubLength;

	INT16U	Crc;			// SIO CRC
	BOOL    CrcOK;
} __SMSBODYFRAME;


typedef struct {

	INT8U	Sync[4];
	INT8U  	TryNo;
	INT8U	BodyLen[2];	
	INT8U	CheckSum;

	__SMSBODYFRAME BodyFrame[TWO_BODY];
	//INT8U  	SubID[3];

	//INT8U	Command;
	//INT8U	Rcode;
	//INT8U	SubLen[2];
	//INT8U	SubData[BODYSIZEMAX];
	//INT16U	Crc;
	//------------------------------//	Tail
	//------------------------------//	Etc.. (상위프로그램과 연관 없음)
	INT16U	BodyLength;
	INT8U	BodyNo;			// received body cnt!!
	INT8U   cBody;			// current body cnt!!
	
	//INT16U	SubLength;
	//INT8U	CrcErr;
	//BOOL	CrcOK;
	//INT8U 	OrgDstID;
	//INT8U	OrgSrcID;
} __SMSWRCSSIO;
#endif
#if 0
typedef union{
    INT16U Data;
    struct {
	    INT16U Low  	:8;
	    INT16U High 	:8;
	} Byte;
} __TBL16;
#endif
#pragma pack()

typedef struct {
	unsigned char (*CheckByte)(unsigned short int, unsigned short int *);
	signed short int (*RxGetByte)(void);
	void (*PutStr)(unsigned char *, unsigned short int, int);
	void (*TxClear)(void);

	signed short int (*TxCheckByte)(void);
	void (*BuffClear)(void);

	INT16U TimerRx;
	INT16U TimerEndWait;
	INT32U ctrlsrc;			//

	OS_EVENT *OSSem;
		
	__WRCSSIO *WRCSRecv;
	__WRCSSIO *WRCSSend;

	__BODYFRAME *SmsRecv;	//
	__BODYFRAME *SmsSend;	//

	
	
	OS_EVENT *Sem;
} __ProtocolPtr1;

typedef struct {
	INT16U	Adc_TxDet;				//0,1
} _ADCBODY;


////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

////////////////////////////////////////////////////////
// End of Headerfile
///////////////////////

