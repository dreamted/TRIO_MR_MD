
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

////////////////////////////////////////////////////////////////////////////////
#ifdef DTU_C
	#define _USR_EXT_DTU
#else
	#define _USR_EXT_DTU	extern
#endif

////////////////////////////////////////////////////////////////////////////////
// DTU Register Address
///////////////////////////////////////////////////////////////////////////////
#define DTU_MINDECT			-2000

//#define logx(x)		(INT16S)(((double)10*log10(x))*10)

#define logx(x)		(INT16S)(((double)10*log10(x))*10)

#define log2x(x)	(INT16S)(((double)20*log10(x))*10)

#define INIT_CHECK_DATA 	0x5A

#define VENDOR_ID 			0xA5
#define UNIT_ID 			0xA1

#define DTU_INIT_GAIN		110

#define DTU_ATT2INIT_GAIN	60

//#define DTU_INIT_GAIN		60


#define DTU_INIT_AGClevel	-96

#if 1
#define DTU_ISO_800M_Max	1110
#define DTU_ISO_1800M_Max	1160
#define DTU_ISO_2100M_Max	1170
#endif
#define DTU_ISO_Max	300

#define DTU_ISO_800M_Min	810
#define DTU_ISO_1800M_Min	860
#define DTU_ISO_2100M_Min	870



#pragma pack(1)

typedef struct {
	INT8U path;
	type16 AverCnt;
	INT32U logoffsetA; 
	INT16S logoffsetB;
} SpecRQST;
#pragma pack()

enum {
	DTU_VER = 0x00,
	DTU_VENDOR_ID,			//0xA5
	DTU_UNIT_ID,			//0xA1 0xE2
	DTU_RST,
	DTU_STATUS,
	DTU_PLL_STS,

	DTU_BW_SEL_B0 = 0x07,		//<! 800M    900M Band-width Select	0: 10MHz Only
	DTU_BW_SEL_B1,				//<! 1800 Band-width Select 0: 20MHz(DL/UL)	1: 20MHz+5MHz(UL)
	DTU_BW_SEL_B2,				//<! 2100 Band-width Select 0: 20MHz(WCDMA Only), 1: 10MHz(LTE) + 10MHz(WCDMA). 2: 20MHz(LTE Only)


	DTU_PATHOnOff_800M = 0x0A,
	DTU_PATHOnOff_1800M,
	DTU_PATHOnOff_2100M,

	DTU_Filter_Info		= 0x0E,

	DTU_AddVER 			= 0x0F,

	DTU_ReadSelect		= 0x10,

	DTU_PeakPower_B0	= 0x11,
	DTU_AverPower_B0 	= 0x15,


	DTU_DLBPeakPower_B0	= 0x11,
	DTU_DLBAverPower_B0 = 0x15,
/////////////////////////////////////
	DTU_DLAPeakPower_B0 = 0x18,
	DTU_DLAAverPower_B0 = 0x1C,
///////////////////////////////////	


///////////////////////////////////////////
	DTU_DLLAGCGain_800M = 0x20,		/// CDMA
	DTU_DLRAGCGain_800M,			/// LTE
	DTU_DLLAGCGain_1800M,			/// LTE-A2
	DTU_DLRAGCGain_1800M,			/// LTE-A1
	DTU_DLLAGCGain_2100M,			/// LTE-21   ///WCDMA
	DTU_DLRAGCGain_2100M,			/// WCDMA    //LTE-21
	
	DTU_ULLAGCGain_800M = 0x28,		/// CDMA
	DTU_ULRAGCGain_800M,			/// LTE
	DTU_ULLAGCGain_1800M,			/// LTE-A2
	DTU_ULRAGCGain_1800M,			/// LTE-A1
	DTU_ULLAGCGain_2100M,			/// LTE-21
	DTU_ULRAGCGain_2100M,			/// WCDMA
	
	DTU_DLLALCGain_800M = 0x30,
	DTU_DLRALCGain_800M,
	DTU_DLLALCGain_1800M,
	DTU_DLRALCGain_1800M,
	DTU_DLLALCGain_2100M,
	DTU_DLRALCGain_2100M,
	
	DTU_ULLALCGain_800M = 0x38,
	DTU_ULRALCGain_800M,
	DTU_ULLALCGain_1800M,
	DTU_ULRALCGain_1800M,
	DTU_ULLALCGain_2100M,
	DTU_ULRALCGain_2100M,

	DTU_Spec_Path = 0x40,
	DTU_Spec_Start,
	DTU_Spec_Busy,
	DTU_Spec_Addr,
	DTU_Spec_Rdn = 0x45,
	DTU_Spec_Data,

	DTU_DLAGCOnOff = 0x50,
	DTU_ULAGCOnOff = 0x51,

	DTU_DLLAGCLevel_800M = 0x52,
	DTU_DLRAGCLevel_800M,
	DTU_DLLAGCLevel_1800M,
	DTU_DLRAGCLevel_1800M,
	DTU_DLLAGCLevel_2100M,
	DTU_DLRAGCLevel_2100M,

	DTU_ULLAGCLevel_800M = 0x59,
	DTU_ULRAGCLevel_800M,
	DTU_ULLAGCLevel_1800M,
	DTU_ULRAGCLevel_1800M,
	DTU_ULLAGCLevel_2100M,
	DTU_ULRAGCLevel_2100M,

	DTU_ISOPathSel = 0x60,
	DTU_ISO_O_Power   = 0x61,

	DTU_ISO_x_Power   = 0x65,

	DTU_Coefficient_ctl   = 0x70,
	DTU_Coefficient_Addr   = 0x71,
	DTU_Coefficient_Data   = 0x72,

	DTU_Coefficient_Sel   	= 0x74,
	DTU_Coefficient_FregSel = 0x75,
	DTU_Coefficient_Freg    = 0x76,

//////////////////////////////////////////
#if 0
	DTU_DLBPeakPower_B1 = 0x30,
	DTU_DLBAverPower_B1 = 0x34,
	DTU_DLAPeakPower_B1 = 0x38,
	DTU_DLAAverPower_B1 = 0x3C,

	DTU_DLBPeakPower_B2 = 0x40,
	DTU_DLBAverPower_B2 = 0x44,
	DTU_DLLAPeakPower_B2 = 0x48,
	DTU_DLLAAverPower_B2 = 0x4C,	

	DTU_DLRAPeakPower_B2 = 0x58,
	DTU_DLRAAverPower_B2 = 0x5C,

	
	DTU_ULBPeakPower_B0 = 0x60,
	DTU_ULBAverPower_B0 = 0x64,
	DTU_ULAPeakPower_B0 = 0x68,
	DTU_ULAAverPower_B0 = 0x6C,

	DTU_ULBPeakPower_B1 = 0x80,
	DTU_ULBAverPower_B1 = 0x84,
	DTU_ULAPeakPower_B1 = 0x88,
	DTU_ULAAverPower_B1 = 0x8C,

	DTU_ULBPeakPower_B2 = 0x90,
	DTU_ULBAverPower_B2 = 0x94,
	DTU_ULLAPeakPower_B2 = 0x98,
	DTU_ULLAAverPower_B2 = 0x9C,
	
	DTU_ULRAPeakPower_B2 = 0xA8,
	DTU_ULRAAverPower_B2 = 0xAC,

	
	DTU_DLAGCGain_B0 = 0xB0,
	DTU_DLAGCGain_B1 = 0xB2,

	DTU_DLLAGCGain_B2 = 0xB4,
	DTU_DLRAGCGain_B2 = 0xB5,

	DTU_ULAGCGain_B0 = 0xB8,
	DTU_ULAGCGain_B1 = 0xBA,

	DTU_ULLAGCGain_B2 = 0xBC,
	DTU_ULRAGCGain_B2 = 0xBD,

	DTU_DLALCGain_B0 = 0xC0,
	DTU_DLALCGain_B1 = 0xC2,

	DTU_DLLALCGain_B2 = 0xC4,
	DTU_DLRALCGain_B2 = 0xC5,

	DTU_ULALCGain_B0 = 0xC8,
	DTU_ULALCGain_B1 = 0xCA,

	DTU_ULLALCGain_B2 = 0xCC,
	DTU_ULRALCGain_B2 = 0xCD,
#endif

//////////////////////////////////////
	DTU_AverCnt = 0xDA,


	DTU_ECSPathSel = 0xF0,
	DTU_ECSPower = 0xF1,
	DTU_ECSOnOff = 0xF7,
	
};

////////////////////////////////////////////////////////////////////////////////
// Export Macro  & Definition
//////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
#define CS0 		((GPIOG_OFFSET)*16 + 11)	// t-low
#define CS1 		((GPIOG_OFFSET)*16 + 8) 	// t-period

////////////////////////////////////////////////////////////////////////////////
#ifdef DTU_C
////////////////////
	#define DTU_STK_SIZE		128

	static OS_STK DtuTaskStk[DTU_STK_SIZE] @ "iram";


	INT8U IsItDTUInited = FALSE;
	INT8U DTULinkFailCnt = 0;
	INT8U cECSOnOff = 0xff;

	INT8U DTU_Flag = 0;

	INT8U Spectrum_Flag = 0;
	INT8U ISOCheckCnt = 0;


	INT16U ISOtmp[30] ={0,};
	INT8U ISOManualCnt = 0;


#if 0
	INT16S InitPeakOffset[DTU_Power_MAX]= { 
		693, 935, 935, 691, 833, 833, 
		682, 875, 755, 681, 774, 774, 
		683, 938, 936, 688, 836, 835, 
	};

	INT16S InitAverOffset[DTU_Power_MAX]= { 
		693, 835, 835, 691, 833, 833,  
		682, 773, 655, 681, 774, 774, 
		683, 835, 835, 688, 836, 835, 
	};
#endif
	
#if 1
	INT16S InitPeakOffset[DTU_Power_MAX]= { 
		688, 930, 930, 686, 828, 828, 
		677, 870, 750, 676, 769, 769, 
		678, 933, 931, 683, 831, 830, 
	};

	INT16S InitAverOffset[DTU_Power_MAX]= { 
		688, 830, 830, 686, 828, 828,  
		677, 768, 650, 676, 769, 769, 
		678, 830, 830, 683, 831, 830, 
	};
#endif
	const unsigned long ExpioCS0[EXPIOPointMAX] = {
				CS0,
				CS1,
				CS2,
				CS3,
				CS4,
				CS5,
				CS6,
				CS7,
				CS8,
				CS9,
				CS10
			};

////////////////////////////////////////////////////////////////////////////////
#else
///////////////////////////
	extern INT8U IsItDTUInited;

	extern INT8U Spectrum_Flag;

	extern INT8U ISOManualCnt;




////////////////////////////////////////////////////////////////////////////////
#endif

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

void DtuInit(void);
void DtuTask(void *p_arg);
void DtuStsUpdate(void);

INT8U DTUInitCheck(void);
INT8U RtnDTUInited(void);
INT8U DTUGetSpecData(INT8S *gptr,INT16U Path);

void DTUStatusUpdate(void);
void DTUSwResetFunc(void);

void DTU_WriteData(INT8U SEL, INT8U Addr, INT8U Data);
INT16U DTU_ReadData(INT8U SEL, INT8U Addr);

void FilterRxCheck(INT8U* Data,INT16U nCnt);
void FilterOperating(void);
void FilterCoefficientWrite(INT8U Path);


INT16U DTU_IsolationCheck(INT8U Path);


//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////


