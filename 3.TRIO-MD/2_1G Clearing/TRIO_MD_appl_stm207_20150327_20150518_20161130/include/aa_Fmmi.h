
/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * Values of global or static variables.
 *
 *
 * Copyright 2007 - bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2007.08.__
 *
 ******************************************************************************/
#ifdef FMMI_C
	#define _USR_EXTFMMI
#else
	#define _USR_EXTFMMI	extern
#endif

//#define TimeVfdEscTime		Time1Sec*10L
//#define TimerVfd1stOffTime	(Time1Sec*30L)
//#define TimerVfd2stOnTime	(Time1Sec*60L)*3

#define TimeVfdEscTime		Time1Sec*60L
#define TimerVfd1stOffTime	(Time1Sec*60L)*30L
#define TimerVfd2stOnTime	(Time1Sec*60L)*60L*24L

#define LcdArrow		0x10//0x7e
#define UpDownArrow		0xff

#define ArrowActive			1
#define ArrowPassive		0


typedef struct
{
	INT8U LPtr[16];
} LineLcd;

_USR_EXTFMMI	INT8U IntINCKey;
_USR_EXTFMMI	INT8U IntDECKey;
_USR_EXTFMMI	INT8U IntMNUKey;
_USR_EXTFMMI	INT8U IntESCKey;
_USR_EXTFMMI	INT8U IntENTKey;

_USR_EXTFMMI	INT8U VfdDisplayStep;
_USR_EXTFMMI 	INT8U AlamLogDisplayData[20];  


// **************************************************************************************
// Vriables
// **************************************************************************************
#ifdef FMMI_C
//////////////
	#define FMMI_START_STK_SIZE		256
	static OS_STK FmmiTaskStk[FMMI_START_STK_SIZE];
	

	INT8U FirstPrintf = FALSE;
	BOOL KeyPadOnFlag = 0;

		
////////////////////////////////////////////////////////////////////////////////
#else
/////
	extern BOOL KeyPadOnFlag;
	extern INT8U FirstPrintf ;

////////////////////////////////////////////////////////////////////////////////
#endif
/////


#ifdef FMMI_C
	const char *HUBDefaultMsg = " DE-INDOOR  V1.0"\
								"  SK Telecom !  "\
								" DE-OUTDOOR V1.0"\
								"  SK Telecom    ";
	
	const char *IndoorMsg	= "INDOOR ";
	const char *OutdoorMsg	= "OUTDOOR";

	///////////// System Select Menu ///////////////////
	enum
	{
		MenuForward = 0,
		MenuReverse,
		MenuAmp,
		MenuFA,
		MenuEnviroment,
		//MenuNetwork,
	};

	char const *MenuFwdMSG			= 	" Forward Status ";

	char const *MenuRvsMSG			= 	" Reverse Status ";

	char const *MenuAmpMSG			= 	" AMP Status     ";

	char const *MenuOpticMSG 		= 	" Optic Module   ";

	char const *MenuFAMSG			= 	" FA SELECT      ";

	char const *MenuEnvironMSG	 	= 	" Environment    ";

	char const *MenuNetworkMSG		= 	" NETWORK        ";


	
	///////////// Forward Select Menu ///////////////////
	
	enum
	{
		MenuNODEBFwd = 0,
		MenuRepFwd,
		
	};
	
	char const	*MenuNODEBFwdMSG	=	" NODE-B FWD     ";
	char const	*MenuRepFwdMSG		=	" Repeater FWD   ";

	char const	*MenuCdmaFwdSubMSG	=	"CDMA FWD STS    ";
	char const	*MenuWcdmaFwdSubMSG	=	"WCDMA FWD STS   ";

	///////////// Forward Menu ///////////////////

	enum
	{
		MenuFwdInPwr = 0,
		MenuFwdInPwrHigh,
		MenuFwdInPwrLow,
		MenuFwdOutPwr,
		MenuFwdOutPwrHigh,
		MenuFwdOutPwrLow,
		MenuFwdREPOutPwr,
		MenuFwdREPOutPwrHigh,
		MenuFwdREPOutPwrLow,
		MenuFwdInAttn,
		MenuFwdOutAttn,
		MenuFwdREPOutAttn,
		MenuFwdOutSWTime,

	};

	char const *MenuInPwrMSG 		= 	"INPWR        dBm";
	char const *MenuInPwrHighMSG 	= 	"INHIGH  [NORMAL]";
	char const *MenuInPwrLowMSG 	= 	"INLOW   [NORMAL]";


	char const *MenuFwdOutPwrMSG 	= 	"N OUTPWR     dBm";
	char const *MenuFwdOutPwrHighMSG 	= 	"N HIGH  [NORMAL]";
	char const *MenuFwdOutPwrLowMSG 	= 	"N LOW   [NORMAL]";

	char const *MenuREPOutPwrMSG 	= 	"R OUTPWR     dBm";
	char const *MenuREPOutPwrHighMSG= 	"R HIGH  [NORMAL]";
	char const *MenuREPOutPwrLowMSG = 	"R LOW   [NORMAL]";
	
	char const *MenuInAttnMSG 		= 	"IN ATT       dB>";
	char const *MenuOutAttnMSG 		= 	"NODE ATT     dB>";
	char const *MenuREPOutAttnMSG 	= 	"REP ATT      dB>";
	char const *MenuFwdOutSWTimeMSG =	"SW TIME      ms>";
	char const *MenuInAlarmMSG 		= 	"INPUT   [NORMAL]";
	char const *MenuCableLossMSG 	= 	"OK        [SET]>";

	char const *MenuCableLossCMSG 	= 	"PathLoss Status ";
	char const *MenuCWMSG 			= 	"CW Status       ";
	char const *MenuRvsOscMSG		=	"OSC.    [NORMAL]";
	///////////// Reverse Select Menu ///////////////////
	
	enum
	{
		MenuCdmaRvs = 0,
		MenuWcdmaRvs
		
	};	
	
	char const *MenuRvsOutPwrMSG 	= 	"OUTPWR       dBm";
	char const *MenuOutPwrHighMSG 	= 	"HIGH    [NORMAL]";
	char const *MenuOutPwrLowMSG 	= 	"LOW     [NORMAL]";
	char const *MenuAttnMSG 		= 	" ATT         dB>";

	///////////// Reverse Menu ///////////////////

	enum
	{
		MenuRvsInPwr,
		MenuRvsInPwrHigh,
		MenuRvsInPwrLow,
		MenuRvsOutPwr,
		MenuRvsOutPwrHigh,
		MenuRvsOutPwrLow,
		MenuRvsAttn,
		MenuRvsCWOnOff,
		MenuRvsPathLoss,
		MenuRvsOsc,
	};


	char const *MenuRvsCWOnOffMSG 	= 	"ON        [OFF]>";
	
	///////////// Amp Select Menu ///////////////////
		
	char const	*MenuWcdmaAmpSubMSG	=	"AMP STS         ";
	///////////// Amp Menu ///////////////////

	enum
	{
		MenuAmpVendor = 0,
		MenuAmpOnOff,
		MenuAmpOverPwr,
		MenuAmpOverTemp,
		MenuAmpVswr,
		MenuAmpDc,
	
	};


	char const *MenuAmpVendorMSG	=	"             W  ";
	char const *MenuAmpOnOffMSG		=	"AMP       [OFF]>";
	char const *MenuAmpOverPwrMSG	=	"OVERPWR [FAIL !]";
	char const *MenuAmpOverTempMSG	=	"HI.TEMP [FAIL !]";
	char const *MenuAmpVswrMSG		=	"VSWR    [FAIL !]";
	char const *MenuAmpDcMSG		=	"DC      [FAIL !]";

	char const *MenuAmpVendorWMSG 	= 	"HPA Vendor      ";


	///////////// FA Menu ///////////////////
	char const	*MenuFASelectMSG	=	"FA SELECT       ";

	enum
	{
		MenuFASts = 0,
		MenuFAIn,
		MenuFAOut1,
		MenuFAOut2,
	};

	char const	*MenuFAStsMSG 	=	"FA           FA ";
	char const	*MenuFAInMSG  	=	"FA IN          >";
	char const	*MenuFAOut1MSG	=	"FA OUT1        >";
	char const	*MenuFAOut2MSG	=	"FA OUT2        >";

	//char *OffMSG 	= "OFF";
	char const *p_1FAMSG	= "1FA";
	char const *p_2FAMSG	= "2FA";
	char const *p_3FAMSG	= "3FA";
	char const *p_4FAMSG	= "4FA";
	char const *p_7FAMSG	= "7FA";
	char const *p_8FAMSG	= "8FA";
	
	///////////// Environment Menu ///////////////////

	enum
	{
		MenuMaker,
		MenuType,
		MenuDoor,
		MenuTemp,
		MenuBattery,
		MenuAc,
		MenuDc,
		MenuBatteryLow,
		MenuPwrSupply,
		MenuLocal,
	};

	char const *MenuMakerMSG		=   "MAKER           ";
	char const *MenuTypeMSG			=	"TYPE            ";
	char const *MenuDoorMSG			=	"DOOR     [     ]";
	char const *MenuTempMSG			=	"TEMP.         C ";
	char const *MenuBatteryMSG		=	"Batt.    Not Use";
	char const *MenuAcMSG			=	"AC      [NORMAL]";
	char const *MenuPwrSupplyMSG	=	"SUPPLY  [NORMAL]";
	char const *MenuDcMSG			=	"DC      [FAIL !]";
	char const *MenuBatteryLowMSG	=	"Batt.Low[FAIL !]";
	char const *MenuLocalMSG		=	"Local   [NORMAL]";

	

	char const *DownloadMSG		= "RCU Downloading ";
	
	///////////// Setup Menu ///////////////////
	char const *FirstAlarmMSG		= "      ALARM     ";
	char const *FirstBlinkMSG		= "                ";

	char const *UpDnEntMSG	= " [UP/DN] [ENTER]";
	
	char const *OnMSG		= "ON ";
	char const *OffMSG 		= "OFF";

	char const *AutoMSG		= "  AUTO";
	char const *ManualMSG 	= "MANUAL";

	char const *NormalMSG 	= "NORMAL";
	char const *AlarmMSG 	= "ALARM ";
	char const *FailMSG 	= "FAIL !";
	char const *OpenMSG   	= "OPEN ";
	char const *CloseMSG 	= "CLOSE";
	char const *BlinkMSG	= "                ";
	char const *RemoveMSG	= "REMOVE";
	char const *SetMSG		= "SET";
	char const *ResetMSG	= "RESET";

	char const *NotUseMSG	= "Not Use";
	char const *_extMSG		= "ext 27V";
	char const *_intMSG		= "Int 29V";
	char const *UseMSG 		= "    Use";
	
	char const *UnlockMSG 	= "UNLOCK";
	char const *LockMSG 	= "  LOCK";

	char const *EnableMSG	= " ENABLE";
	char const *DisableMSG	= "DISABLE";

	char const *HighMSG		= "HIGH";
	char const *LowMSG		= " LOW";

	char const *OkMSG		= "OK       ";
	char const *MaxAttnMSG	= "Max ATT  ";
	char const *MinAttnMSG	= "Min ATT  ";
	char const *CommFailMSG	= "Comm Fail";
	char const *NoSignalMSG	= "No Signal";
	char const *NoDeviceMSG	= "No Device";
	char const *NoCNTLMSG	= "No CNTL  ";
	char const *IngMSG		= "ing...   ";
	char const *EtcMSG		= "Etc      ";
	
	char const *RSVMSG		= "     ";
	char const *GSIMSG		= "GSI  ";
	char const *RMMSG		= "RM   ";
	char const *SWMSG		= "SW   ";
	
	char const *TSMSG		= "TS   ";
	char const *WEMSG		= "WE   ";
	char const *COMSG		= "CO   ";
	char const *RHMSG		= "RH   ";
	char const *HSMSG		= "HS   ";	
	char const *RFHICMSG	= "RFHIC";
	char const *EDMSG		= "ED   ";
	char const *PWMSG		= "PW   ";
	char const *STMSG		= "ST   ";
	char const *SUNMSG		= "SUN  ";
	char const *NCLMSG		= "NCL  ";
	char const *GTMSG		= "GT&T ";

	char const *COPYINMSG	= "COPY IN  ";
	char const *COPYOUTMSG	= "COPY OUT ";
	char const *GENINMSG	= "GEN IN   ";
	char const *GENOUTMSG	= "GEN OUT  ";
	char const *COPYRACKMSG	= "COPY RACK";
	char const *GENRACKMSG	= "GEN RACK ";

//////////

#else
#endif


// **************************************************************************************
// Function
// **************************************************************************************
void FmmiInit(void);
void FmmiTask(void * pdata);

INT8U DoorVfdCheck(void);

void KeyPushBuffSet(void);


INT8U KeyVaried(INT8U INC, INT8U DEC, INT8U MNU, INT8U ESC, INT8U ENT);
void InitKeyVal(void);
void SelectDonorTypeMenuDisplay(void);
void NetworkDisplay(void);

void SelectMenuDisplay(void);

INT8U FwdSelectMenuDisplay(void);
void RvsSelectMenuDisplay(void);
void AmpSelectMenuDisplay(void);
INT8U FwdStsMenuDisplay(void);
INT8U RvsStsMenuDisplay(void);
INT8U AmpStsMenuDisplay(void);
INT8U EnvStsMenuDisplay(void);
INT8U FAStsMenuDisplay(void);


void ReplaceString (char * FwdMsg, char * BwdMsg, INT16U Addr, INT16U Cnt);
void AlmNrmDisplay(INT8U value, INT8U DisPtr);
void FailNrmDisplay(INT8U value, INT8U DisPtr);

void OnOffDisplay(INT8U value, INT8U Blink, INT8U DisPtr);
void SetDisplay(INT8U value, INT8U Blink, INT8U DisPtr);
void VauleDisplay(INT32S value,INT8U Blink, INT8U EndPtr);
void DoubleDisplay(INT32S value, INT8U Blink, INT8U EndPtr);
void BatteryDisplay(INT8U value, INT8U Blink, INT8U DisPtr);
void TempValueDisplay(INT16S value,INT8U Blink,INT8U EndPtr);
void AttnDisplay(INT32S value,INT8U Blink,INT8U EndPtr);
void PowerDisplay(INT16S value,INT8U Blink,INT8U EndPtr);
void RemoveDisplay(void);
void LcdLineDisplay(LineLcd *Ptr, INT8U	SecondLine);
void OutPwrDisplay(INT8S *vaule, INT8U Blink, INT8U EndPtr);
void UnlockDisplay(INT8U value, INT8U DisPtr);

void ManufactureDisplay(INT8U value);
void PauMakerDisplay(INT16S value);
void RepeaterType(INT16S value);
void FADisplay(INT16S value, INT8U Blink);
void PathLossDisplay(INT16S value);


////////////////////////////////////////////////////////////////////////////////
// End of Headerfile
/////////////////////

