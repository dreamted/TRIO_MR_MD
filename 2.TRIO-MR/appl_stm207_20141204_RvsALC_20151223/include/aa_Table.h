/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : fsmc_sram.h
* Author             : MCD Application Team
* Version            : V2.0.2
* Date               : 07/11/2008
* Description        : Header for fsmc_sram.c file.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/
#ifdef TABLE_C
	#define _USR_EXTTABLE
#else
	#define _USR_EXTTABLE	extern
#endif

#define TableMAX62				62
#if 0
typedef union{
	INT8U uD8[2];
	
    INT16U uD16;
	INT16S sD16;

} type16;
#endif
enum
{
 	TRIO_M_TBL= 0x01,
	TRIO_MM_TBL,
	Default_TBL = 0x7F,

};



#pragma pack(2)



////////////////////////////////////////////////////////////////////////////////
// Internal FLASH CASE
////////////////////////////////////////////////////////////////////////////////
// BACKUP 1st ADDRESS AREA(DON'T OVER 1024 Bytes
typedef struct {
	union{
		INT8U	Data[500];

		struct {
			INT8U	IsDataFlag;
			INT8U	IsFirstFlag;
			INT8U	TransceiveMaker;
//////////////////////////////////////////////////////////////////////////20131004
			INT8S FwdOutUpperLmt_3G[2]; 		// 0x0504
			INT8S FwdOutLowerLmt_3G[2]; 		// 0x0505
			INT8U FwdGainSet_3G;				// 0x0529  Forward Gain(설정값)
			INT8S FwdOutUpperLmt_2G[2]; 		// 0x0515
			INT8S FwdOutLowerLmt_2G[2]; 		// 0x0516
			INT8U FwdGainSet_2G;				// 0x0542  Forward Gain(설정값)
		
			INT8S FwdOutUpperLmt_LTE[2];		// 0x0557	
			INT8S FwdOutLowerLmt_LTE[2];		// 0x0558
			INT8U FwdGainSet_LTE;				// 0x056E  Forward Gain(설정값)
		
			INT8S FwdOutPwr_LTE_A2[2];			// 0x1B14
			INT8S FwdOutUpperLmt_LTE_A2[2]; 	// 0x1B15  (Range: 7 ~ 17dBm)
			INT8S FwdOutLowerLmt_LTE_A2[2]; 	// 0x1B16
		
			INT8U FwdGainSet_LTE_A2;			// 0x1B1A  Forward Gain(설정값) 38~83dB
		
			INT8U Rvs0GainSet_3G;				// 0x0604	Reverse Gain(설정값)
			INT8U RvsGainBalance_3G;			// 0x062D	Reverse Gain Balance
		
			INT8U Rvs0GainSet_2G;				// 0x060F	Reverse Gain(설정값)
			INT8U RvsGainBalance_2G;			// 0x063F	Reverse Gain Balance
		
			INT8U Rvs0GainSet_LTE;				// 0x0669	Reverse Gain(설정값)
			INT8U RvsGainBalance_LTE;			// 0x0676	Reverse Gain Balance
		
			INT8U Rvs0GainSet_LTE_A2;			// 0x1C0B	Reverse Gain(설정값)
			INT8U RvsGainBalance_LTE_A2;		// 0x1C0C	Reverse Gain Balance
		
			INT8U LTE15MUse;					// 0x1059
			INT8U Band_Select_LTE_A2[3];		// 0x1066
			INT8U FemtocellUseOnOff;			// 0x1062
			INT8U RepeatResetPriod; 			// 0x102A
			INT8U HostNumber[11];				// 0x0920
			INT8U AutoReportPriod;				// 0x0922
			INT8U AutoReportBasePer[2]; 		// 0x0923
		
			INT8U AGCOnOff_3G;					// 0x090A
			INT8U AGCOnOff_CDMALTE; 			// 0x1068
			INT8U AGCOnOff_LTE_A_0; 			// 0x1069
			INT8U AGCMode_3G;					// 0x105B
			INT8U AGCMode_2G;					// 0x105C
			INT8U AGCMode_LTE;					// 0x105D
			INT8U AGCMode_LTE_A2;				// 0x1067
			INT8U TPTL_OnOff;					// 0xA000					
			INT8S TempOffset;					// 0xA001
			INT8U AlarmMask;					// 0xA00D
			INT8U VccDet_Lmt[2]; 				// 0xA02B
			INT8S FwdInPwrOffset_2G;			// 0xA101
			INT8S FwdInPwrOffset_3G;			// 0xA102
			INT8S Rvs0OutPwrOffset_2G;			// 0xA109
			INT8S Rvs0OutPwrOffset_3G;			// 0xA10B
			INT8S FwdOutPwrOffset_2G;			// 0xA158
			INT8S FwdOutPwrOffset_3G;			// 0xA159
		
			INT8S FwdInPwrOffset_LTE;			// 0xA1C3
			INT8S FwdOutPwrOffset_LTE;			// 0xA1C4
			INT8S RvsOutPwrOffset_LTE;			// 0xA1CD
		
			INT8U FwdGainOffset_3G; 			// 0xA36A
			INT8U RvsGainOffset_3G; 			// 0xA36B
			INT8U FwdGainOffset_2G; 			// 0xA36C
			INT8U RvsGainOffset_2G; 			// 0xA36D
		
			__DETOffset DetOffset;				// 0xA802
			INT8U FwdGainOffset_LTE;			// 0xA822
			INT8U RvsGainOffset_LTE;			// 0xA823
			INT8S FwdInPwrOffset_LTE_A2;		// 0xA870
			INT8S FwdOutPwrOffset_LTE_A2;		// 0xA871
			INT8S RvsOutPwrOffset_LTE_A2;		// 0xA872
			INT8U FwdGainOffset_LTE_A2; 		// 0xA87C
			INT8U RvsGainOffset_LTE_A2; 		// 0xA87D
			//////////////////////////////////////////////////////////////////////////////Wave
		
			INT8U RxMaxVal[2];					// 0x0C03
			INT8U RxMinVal[2];					// 0x0C04
			INT8U TxMaxVal[2];					// 0x0C05
			INT8U TxMinVal[2];					// 0x0C06
			INT8U EcIo; 						// 0x0C09
			INT8U AR_Mode[2];					// 0x0C11
			INT8U Radio_ReportTime[2];			// 0x0C12
			INT8U Radio_ReportPeriod[2];		// 0x0C13
			INT8U TestStn[11];					// 0x0C14
		////////////////
			INT8U FwdAmpOnOff_3G;				// 0x0706
			INT8U FwdAmpOnOff_2G;				// 0x0715
			INT8U FwdAmpOnOff_LTE;				// 0x074F
			INT8U FwdAmpOnOff_LTE_A2;			// 0x0759
		///////////////////////////////////////////////////////////////
		
			INT8S RvsALCLvl_2G; 				// 0xA85D
			INT8S RvsALCLvl_LTE;				// 0xA85E
			INT8S RvsALCLvl_LTE_A2; 			// 0xA893
			INT8S RvsALCLvl_3G; 				// 0xA860
		///////////////////////////////////////////////////////////
			INT8U MasterPNH;					//
			INT8U MasterPNL;
			INT8U RB_StsOnOff;					// 0xD019
			INT8U DCOffSet[2];					// 0xD01C
			INT8U PllFregOffset_LTE;			// 0xA8AD	
		
			__SleepMode  SleepMode_2G;
			__SleepMode  SleepMode_LTE;
			__SleepMode  SleepMode_LTE_A1;
			__SleepMode  SleepMode_LTE_A2;


			///////////////////////////////////
			INT8U BalanceModeOnOff; 		// 0x082A
			INT8S BalanceModeDetOffset[4];					// 0xAD09
			
			INT8U AvgMAXGARBAGE_Tx[4];
			INT8U AvgMINGARBAGE_Tx[4];
			INT8U PeakMAXGARBAGE_Tx[4];
			INT8U PeakMINGARBAGE_Tx[4];
			
			INT8U PeakMAXGARBAGE_Rx[4];
			INT8U PeakMINGARBAGE_Rx[4];
			
//			__BalanceModeDET		BalanceModeDetOffset;	// 0xAD09
		};
	} BackUp;
} EE_BACK1;

#if 1

#define AttTBL_Size 				61
#define TempTBL_Size				22

#define AttMaxLimit 				60
#define TempMaxlimit				80

#define OutputTBL_Size				60


enum {
	Index_FwdOutAvgPwr_2G	= 0x00,
	Index_FwdOutPeakPwr_2G, 
	Index_RvsOutPwr_2G, 

	Index_FwdOutAvgPwr_LTE, 
	Index_FwdOutPeakPwr_LTE, 
	Index_RvsInPwr_LTE, 
	Index_RvsOutPwr_LTE, 

	Index_FwdInPwr_CDMALTE,
	Index_FwdOutAvgPwr_CDMALTE, 
	Index_FwdOutPeakPwr_CDMALTE, 
	Index_RvsInPwr_CDMALTE, 		 ///10
	Index_RvsOutPwr_CDMALTE, 
	
	Index_FwdOutAvgPwr_LTE_A1, 
	Index_FwdOutPeakPwr_LTE_A1, 
	Index_RvsOutPwr_LTE_A1, 

	Index_FwdOutAvgPwr_LTE_A2, 
	Index_FwdOutPeakPwr_LTE_A2, 
	Index_RvsOutPwr_LTE_A2, 

	Index_FwdInPwr_LTE_A,
	Index_FwdOutAvgPwr_LTE_A, 
	Index_FwdOutPeakPwr_LTE_A, 
	Index_RvsInPwr_LTE_A,
	Index_RvsOutPwr_LTE_A, 
 	Index_Rvs1InPwr_LTE_A,
 	
	Index_FwdInPwr_3G, 
	Index_FwdOutAvgPwr_3G, 
	Index_FwdOutPeakPwr_3G, 
	Index_RvsInPwr_3G, 
	Index_RvsOutPwr_3G, 			/////28

	Index_FwdRmtOut_CDMALTE, 		/////
	Index_FwdRmtOut_WCDMA, 			/////
	Index_FwdRmtOut_LTE_A,			/////	
//////
	Index_FwdAttn1_2G,	
	Index_FwdAttn2_2G,	
	Index_RvsAttn1_2G,	
	Index_RvsAttn2_2G,	
	Index_RvsAttn3_2G,	
	Index_RvsAttn4_2G,	
	Index_RvsAttn5_2G,	
	
	Index_FwdAttn1_LTE,	
	Index_FwdAttn2_LTE,	
	Index_RvsAttn1_LTE,	
	Index_RvsAttn2_LTE,	
	Index_RvsAttn3_LTE,	
	Index_RvsAttn4_LTE,	
	Index_RvsAttn5_LTE, 
	
	Index_FwdAttn1_CDMALTE,	
	Index_FwdAttn2_CDMALTE,	
	Index_FwdAttn3_CDMALTE,	
	Index_RvsAttn1_CDMALTE,	
	Index_RvsAttn2_CDMALTE,	
	Index_RvsAttn3_CDMALTE,	
	Index_RvsAttn4_CDMALTE,	
	
	Index_FwdAttn1_LTE_A1, 
	Index_FwdAttn2_LTE_A1, 
	Index_RvsAttn1_LTE_A1, 
	Index_RvsAttn2_LTE_A1, 
	Index_RvsAttn3_LTE_A1, 
	Index_RvsAttn4_LTE_A1, 

	Index_FwdAttn1_LTE_A2, 
	Index_FwdAttn2_LTE_A2, 
	Index_RvsAttn1_LTE_A2, 
	Index_RvsAttn2_LTE_A2, 
	Index_RvsAttn3_LTE_A2, 
	Index_RvsAttn4_LTE_A2, 

	Index_FwdAttn1_LTE_A, 
	Index_FwdAttn2_LTE_A, 
	Index_FwdAttn3_LTE_A, 
	Index_RvsAttn1_LTE_A, 
	Index_RvsAttn2_LTE_A, 
	Index_RvsAttn3_LTE_A, 
	Index_RvsAttn4_LTE_A, 

	Index_FwdAttn1_3G,	
	Index_FwdAttn2_3G,	
	Index_FwdAttn3_3G,	
	Index_FwdAttn4_3G,	
	Index_RvsAttn1_3G,	
	Index_RvsAttn2_3G,	
	Index_RvsAttn3_3G,	
	Index_RvsAttn4_3G,	
	Index_RvsAttn5_3G,	

	Index_FwdTempAttn_2G,	
	Index_RvsTempAttn_2G,	
	Index_FwdTempAttn_LTE,	
	Index_RvsTempAttn_LTE,	
	Index_FwdTempAttn_LTE_A1,
	Index_RvsTempAttn_LTE_A1,
	Index_FwdTempAttn_LTE_A2,
	Index_RvsTempAttn_LTE_A2,
	Index_FwdTempAttn_3G,	
	Index_RvsTempAttn_3G,

	Index_RvsInPwr_2G, 		 
	Index_RvsInPwr_LTE_A1,		
	Index_RvsInPwr_LTE_A2,		

#if 0
	Index_BalancePwr_CDMA = 112, 
	Index_BalancePwr_LTE,
	Index_BalancePwr_LTE_A,
	Index_BalancePwr_WCDMA,	
#endif
};


enum {
	_FwdOutPwr_Location = 0x00,
	_FwdInPwr_Location,
	_RvsOutPwr_Location,
	_RvsInPwr_Location,
	
};

enum {
	Local_FwdOutAvgPwr_2G	= 0x00,
	Local_RvsOutPwr_2G, 
	Local_FwdOutAvgPwr_LTE, 
	Local_RvsInPwr_LTE, 
	Local_RvsOutPwr_LTE, 
	Local_FwdInPwr_CDMALTE,
	Local_FwdOutAvgPwr_CDMALTE, 
	Local_RvsInPwr_CDMALTE, 		
	Local_RvsOutPwr_CDMALTE, 
	Local_FwdOutAvgPwr_LTE_A2,
	
	Local_RvsOutPwr_LTE_A2, 	///10
	Local_FwdInPwr_LTE_A,
	Local_FwdOutAvgPwr_LTE_A, 	///x
	Local_RvsInPwr_LTE_A,		///
	Local_RvsOutPwr_LTE_A,      ///xx 14
 	Local_Rvs1InPwr_LTE_A,		///x
 	Local_FwdInPwr_3G, 
	Local_FwdOutAvgPwr_3G, 
	Local_RvsInPwr_3G, 
	Local_RvsOutPwr_3G, 			/////20

#if 0
	Local_BalancePwr_CDMA, 
	Local_BalancePwr_LTE,
	Local_BalancePwr_LTE_A,
	Local_BalancePwr_WCDMA, 
#endif	

	Local_PwrSts_Max,
};


enum {
//////
	Local_FwdAttn1_2G = 0x00,
	Local_RvsAttn1_2G,	
	Local_RvsAttn2_2G,	
	Local_RvsAttn3_2G,	
	
	Local_FwdAttn1_LTE,	
	Local_RvsAttn1_LTE,	
	Local_RvsAttn2_LTE,	
	Local_RvsAttn3_LTE,	
	
	Local_FwdAttn1_CDMALTE,	
	Local_RvsAttn1_CDMALTE,	 ///10
	
	Local_FwdAttn1_LTE_A2, 
	Local_FwdAttn2_LTE_A2, 
	Local_RvsAttn1_LTE_A2, 
	Local_RvsAttn2_LTE_A2, 
	Local_RvsAttn3_LTE_A2, 
	Local_RvsAttn4_LTE_A2, 

	Local_FwdAttn1_3G,	
	Local_FwdAttn2_3G,	
	Local_RvsAttn1_3G,	
	Local_RvsAttn2_3G,	
	Local_RvsAttn3_3G,	
	Local_RvsAttn4_3G,	
	
	Local_AttnSts_Max,
};


enum {
	Local_FwdTempAttn_2G = 0x00,	
	Local_RvsTempAttn_2G,	
	Local_FwdTempAttn_LTE,	
	Local_RvsTempAttn_LTE,	
	Local_FwdTempAttn_LTE_A2,
	Local_RvsTempAttn_LTE_A2,
	Local_FwdTempAttn_3G,	
	Local_RvsTempAttn_3G,

	Local_TempAttnSts_Max,
};
#endif

#pragma pack(2)

typedef struct {
	INT8S limit;
	INT8U nsize;
	INT16U Data[OutputTBL_Size];
} __OutputTblStr;

typedef struct {
	INT8S limit;
	INT8U nsize;
	INT8S Data[AttTBL_Size];
} __AttnOffsetTblStr;


typedef struct {
	INT8S limit;
	INT8U nsize;
	INT8S Data[TempTBL_Size];
} __AttnTempTblStr;



typedef struct {
	__OutputTblStr FwdOutAvgPwr_2G;
	__OutputTblStr RvsOutPwr_2G; 
	__OutputTblStr FwdOutAvgPwr_LTE; 
	__OutputTblStr RvsInPwr_LTE;
	__OutputTblStr RvsOutPwr_LTE;
	__OutputTblStr FwdInPwr_CDMALTE;
	__OutputTblStr FwdOutAvgPwr_CDMALTE;
	__OutputTblStr RvsInPwr_CDMALTE;
	__OutputTblStr RvsOutPwr_CDMALTE; 
	__OutputTblStr FwdOutAvgPwr_LTE_A2; 
	__OutputTblStr RvsOutPwr_LTE_A2; 
	__OutputTblStr FwdInPwr_LTE_A;
	__OutputTblStr FwdOutAvgPwr_LTE_A;
	__OutputTblStr RvsInPwr_LTE_A;
	__OutputTblStr RvsOutPwr_LTE_A; 
	__OutputTblStr Rvs1InPwr_LTE_A;
	__OutputTblStr FwdInPwr_3G;
	__OutputTblStr FwdOutAvgPwr_3G; 
	__OutputTblStr RvsInPwr_3G;
	__OutputTblStr RvsOutPwr_3G;

} __OutputTable;


typedef struct {
	__AttnOffsetTblStr FwdAttn1_2G;
	__AttnOffsetTblStr RvsAttn1_2G;	
	__AttnOffsetTblStr RvsAttn2_2G;	
	__AttnOffsetTblStr RvsAttn3_2G;	
	__AttnOffsetTblStr FwdAttn1_LTE;	
	__AttnOffsetTblStr RvsAttn1_LTE;	
	__AttnOffsetTblStr RvsAttn2_LTE;	
	__AttnOffsetTblStr RvsAttn3_LTE;	
	__AttnOffsetTblStr FwdAttn1_CDMALTE;
	__AttnOffsetTblStr RvsAttn1_CDMALTE;
	__AttnOffsetTblStr FwdAttn1_LTE_A2; 
	__AttnOffsetTblStr FwdAttn2_LTE_A2; 
	__AttnOffsetTblStr RvsAttn1_LTE_A2; 
	__AttnOffsetTblStr RvsAttn2_LTE_A2; 
	__AttnOffsetTblStr RvsAttn3_LTE_A2; 
	__AttnOffsetTblStr RvsAttn4_LTE_A2; 
	__AttnOffsetTblStr FwdAttn1_3G;	
	__AttnOffsetTblStr FwdAttn2_3G;	
	__AttnOffsetTblStr RvsAttn1_3G;	
	__AttnOffsetTblStr RvsAttn2_3G;	
	__AttnOffsetTblStr RvsAttn3_3G;	
	__AttnOffsetTblStr RvsAttn4_3G;	

} __AttnOffsetTable;





typedef struct {
	__AttnTempTblStr FwdTempAttn_2G;	
	__AttnTempTblStr RvsTempAttn_2G;	
	__AttnTempTblStr FwdTempAttn_LTE;	
	__AttnTempTblStr RvsTempAttn_LTE;
	__AttnTempTblStr FwdTempAttn_LTE_A2;
	__AttnTempTblStr RvsTempAttn_LTE_A2;
	__AttnTempTblStr FwdTempAttn_3G;
	__AttnTempTblStr RvsTempAttn_3G;

} __AttnTempTable;



#pragma pack(1)

////////////////////////////////////////////////////////////////////////////////
// AT24C64 CASE!!
//////////////////////////////////////////
// EEprom Data Backup Register Address
enum {
	bStartAddr = BackupBp,
	///////////////////////////////////
//////////////////////
	ResetCaseBp,


	vEE_BACK1Addr,
	vEE_BACK1EndAddr = vEE_BACK1Addr + sizeof(EE_BACK1),

	TableBp 		= 1*1024,
	
	AttnTableBp 	= 5*1024,
	AttnTptlTableBp = 7*1024,
	
//	vEE_TABLEAddr = 8*1024,
//	vEE_TABLEEndAddr = vEE_TABLEAddr + sizeof(EE_TABLE),



//	vEE_TABLE1Addr = 6000,
//	vEE_TABLE1EndAddr = vEE_TABLE1Addr + sizeof(EE_TABLE1),
	
	BackupEnd = (8*1024)		// 8k, 8192

};

// TABLE INDEX



#pragma pack(2)
////////////////////////////////////////////////////////////////////////////////
#ifdef TABLE_C
//////////////////
#if 1
	const signed char FwdTempAtt_CDMA_TBL[]= {
		2,2,2,2,2,2,1,0,0,0,
		0,0,0,0,-1,-3,-4,-4,-4,-4,
		-4,-4,
	};

	const signed char RvsTempAtt_CDMA_TBL[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char FwdTempAtt_LTE_TBL[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char RvsTempAtt_LTE_TBL[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,-2,-4,-6,-6,-6,-6,
		-6,-6,
	};

	const signed char FwdTempAtt_LTE_A2_TBL[]= {
		-2,-2,-2,-2,-2,-2,-1,-1,0,0,
		0,0,0,1,1,1,2,2,2,2,
		2,2,
	};

	const signed char RvsTempAtt_LTE_A2_TBL[]= {
		-1,-1,-1,-1,-1,-1,-1,0,0,0,
		0,0,0,0,0,-1,-1,-1,-1,-1,
		-1,-1,
	};

	const signed char FwdTempAtt_WCDMA_TBL[]= {
		-2,-2,-2,-2,-1,-1,-1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char RvsTempAtt_WCDMA_TBL[]= {
		-1,-1,-1,-1,-1,-1,-1,-1,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char FwdOutPwrTemp_LTE_A2[]= {
		-1,-1,-1,-1,-1,-1,-1,-1,0,0,
		0,0,0,1,1,1,1,1,1,1,
		1,1,
	};

	const signed char RvsOutPwrTemp_LTE_A2[]= {
		-3,-3,-3,-3,-2,-1,-1,0,0,0,
		0,0,0,0,0,1,2,3,3,3,
		3,3,
	};

	 const signed char FwdAttn1_2G_TBL[] = {
		2,2,2,2,2,2,2,2,2,2,
		2,2,2,2,2,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0
	};





	const signed char FwdAttn2_2G_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn1_2G_TBL[] = {
		2,2,2,2,2,1,1,1,1,1,
		1,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn2_2G_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};




	const signed char RvsAttn3_2G_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char FwdAttn1_LTE_TBL[] = {
		3,3,3,3,3,3,3,3,3,3,
		3,3,3,2,2,2,2,2,2,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};


	const signed char FwdAttn2_LTE_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn1_LTE_TBL[] = {
		2,2,2,2,2,2,2,2,2,2,
		2,2,2,2,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	


	const signed char RvsAttn2_LTE_TBL[] = {
		2,2,2,2,2,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};



	const signed char RvsAttn3_LTE_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};
	

	const signed char FwdAttn1_CDMALTE_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};
 
	const signed char RvsAttn1_CDMALTE_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};



	const signed char FwdAttn1_LTE_A2_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char FwdAttn2_LTE_A2_TBL[] = {
		-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,
		-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,
		-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};


	const signed char RvsAttn1_LTE_A2_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn2_LTE_A2_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn3_LTE_A2_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn4_LTE_A2_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};



	const signed char FwdAttn1_WCDMA_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char FwdAttn2_WCDMA_TBL[] = {
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn1_WCDMA_TBL[] = {
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};


	const signed char RvsAttn2_WCDMA_TBL[] = {
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn3_WCDMA_TBL[] = {
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn4_WCDMA_TBL[] = {
		-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,
		-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,
		-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,
		-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,
		-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,
		-1,-1,0,0,0,0,0,0,0,0,
		0,

	};

	const signed char TRIO_M_FwdAttn1_LTE_A[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char TRIO_M_RvsAttn1_LTE_A[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};


	const unsigned short int  FwdOutPwr_CDMA_TBL[] = {
		2860,2805,2750,2696,2641,2586,2528,2469,2411,2352,
		2294,2238,2182,2125,2069,2013,1967,1922,1876,1831,
		1785
	};  
	
	const unsigned short int  RvsOutPwr_CDMA_TBL[] = {
		2144,2106,2068,2031,1993,1955,1919,1883,1847,1811,
		1775,1738,1701,1665,1628,1591,1554,1518,1481,1445,
		1408,1375,1342,1308,1275,1242,1209,1175,1142,1108,
		1075,1040,1004,969,933,898,869,840,812,783,
		754,735,715,696,676,657,650,641,633,621,
	};

	const unsigned short int  FwdOutPwr_LTE_TBL[] = {
		2960,2901,2841,2782,2722,2663,2613,2563,2512,2462,
		2412,2365,2318,2272,2225,2178,2136,2094,2052,2009,
		1968,
	};

	const unsigned short int  RvsOutPwr_LTE_TBL[] = {
		2239,2196,2154,2111,2069,2025,1992,1958,1924,1890,
		1856,1819,1783,1746,1710,1673,1643,1612,1582,1551,
		1521,1490,1460,1429,1399,1368,1333,1297,1262,1226,
		1191,1157,1124,1090,1057,1022,992,961,930,899,
		868,851,834,818,801,784,775,
 	};

	const unsigned short int  FwdInPwr_CDMALTE_TBL[] = {
		2416,2385,2355,2324,2294,2263,2231,2199,2167,2135,
		2103,2065,2025,1988,1949,1911,1868,1826,1783,1741,
		1698,1665,1632,1598,1565,1532,1498,1464,1430,1396,
		1362,1323,1284,1245,1206,1167,1138,1094,
 	};

	const unsigned short int  FwdOutPwr_CDMALTE_TBL[] = {
 		2073,2039,2005,1972,1938,1904,1869,1833,1798,1762,
		1727,1692,1658,1623,1589,1554,1520,1486,1453,1419,
		1385,
 	};


	const unsigned short int  RvsInPwr_CDMALTE_TBL[] = {
		3101,3036,2970,2905,2839,2774,2724,2674,2624,2574,
		2524,2474,2425,2375,2326,2276,2223,2170,2116,2063,
		2009,1955,1900,1844,1789,1734,1678,1622,1567,1511,
		1455,
	};

	const unsigned short int  RvsOutPwr_CDMALTE_TBL[] = {
		3128,2842,2556,2270,1984,1788,1591,1395,1199,1073,
		948,822,696,622,549,476,402,355,308,261,
		214,
 	};

	const unsigned short int  FwdOutPwr_LTE_A2_TBL[] = {
		2139,2118,2097,2076,2055,2033,1993,1952,1911,1870,
		1829,1791,1752,1714,1675,1637,1601,1565,1529,1493,
		1457,
	};

	const unsigned short int  RvsOutPwr_LTE_A2_TBL[] = {
		2068,2021,1975,1929,1882,1836,1800,1764,1729,1693,
		1657,1624,1591,1557,1524,1491,1462,1433,1403,1374,
		1345,1308,1270,1233,1195,1158,1126,1095,1063,1032,
		1000,984,968,952,936,920,910,901,
	};

	const unsigned short int  FwdInPwr_LTE_A_TBL[] = {
		1808,1766,1724,1683,1641,1599,1564,1530,1495,1461,
		1426,1395,1364,1332,1301,1270,1234,1198,1162,1126,
		1090,1056,1020,987,952,918,898,

	};

	const unsigned short int  RvsInPwr_LTE_A_TBL[] = {
		3156,3085,3013,2941,2870,2798,2724,2650,2576,2532,
		2489,2445,2396,2347,2298,2245,2191,2138,2088,2039,
		1989,1935,1882,1828,1774,1719,1665,1604,1543,1482,
		1425,1367,1310,1251,1192,1133,1085,1036,988,
	};

	const unsigned short int  FwdInPwr_WCDMA_TBL[] = {
		1674,1644,1615,1585,1556,1526,1487,1448,1408,1369,
		1330,1295,1260,1226,1191,1156,1120,1083,1047,1010,
		974,935,897,858,820,781,
	};

	const unsigned short int  FwdOutPwr_WCDMA_TBL[] = {
		2094,2053,2012,1972,1931,1890,1853,1815,1778,1740,
		1703,1665,1627,1589,1551,1513,1481,1449,1417,1385,
	};

	const unsigned short int  RvsInPwr_WCDMA_TBL[] = {
		3050,2988,2927,2865,2804,2743,2682,2632,2582,2532,
		2479,2426,2373,2320,2268,2215,2165,2116,2066,2005,
		1946,1886,1827,1768,1709,1648,1586,1525,1465,1404,
		1344,

	};

	const unsigned short int  RvsOutPwr_WCDMA_TBL[] = {
		2036,1991,1946,1901,1856,1811,1776,1740,1705,1669,
		1634,1594,1554,1514,1474,1434,1401,1368,1334,1301,
		1268,1238,1208,1179,1149,1119,1084,1049,1014,980,
		945,917,889,861,833,805,788,771,755,738,
		721,
	};

	const unsigned short int  TRIO_M_FwdOutPwr_LTE_A[] = {
		3303,3275,3247,3219,3191,3163,3110,3058,3005,2948,
		2890,2833,2770,2706,2643,2584,2526,2467,2406,2345,
		2284,

	};

	const unsigned short int  TRIO_M_RvsOutPwr_LTE_A[] = {
		3315,3307,3299,3291,3283,3275,3238,3200,3163,3108,
		3052,2997,2929,2862,2794,2726,2659,2591,2537,2483,
		2429,
	};
#endif

#if 0	
	const signed char FwdTempAtt_CDMA_TBL[]= {
		2,2,2,2,2,2,1,0,0,0,
		0,0,0,0,-1,-3,-4,-4,-4,-4,
		-4,-4,
	};

	const signed char RvsTempAtt_CDMA_TBL[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char FwdTempAtt_LTE_TBL[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char RvsTempAtt_LTE_TBL[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,-2,-4,-6,-6,-6,-6,
		-6,-6,
	};

	const signed char FwdTempAtt_LTE_A2_TBL[]= {
		-2,-2,-2,-2,-2,-2,-1,-1,0,0,
		0,0,0,1,1,1,2,2,2,2,
		2,2,
	};

	const signed char RvsTempAtt_LTE_A2_TBL[]= {
		-1,-1,-1,-1,-1,-1,-1,0,0,0,
		0,0,0,0,0,-1,-1,-1,-1,-1,
		-1,-1,
	};

	const signed char FwdTempAtt_WCDMA_TBL[]= {
		-2,-2,-2,-2,-1,-1,-1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char RvsTempAtt_WCDMA_TBL[]= {
		-1,-1,-1,-1,-1,-1,-1,-1,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char FwdOutPwrTemp_LTE_A2[]= {
		-1,-1,-1,-1,-1,-1,-1,-1,0,0,
		0,0,0,1,1,1,1,1,1,1,
		1,1,
	};

	const signed char RvsOutPwrTemp_LTE_A2[]= {
		-3,-3,-3,-3,-2,-1,-1,0,0,0,
		0,0,0,0,0,1,2,3,3,3,
		3,3,
	};

	 const unsigned char FwdAttn1_2G_TBL[] = {
		2,2,2,2,2,2,2,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

2,
2,
2,
2,
2,
2,
2,
2,
2,
2,

2,
2,
2,
2,
2,
1,
1,
1,
1,
1,

1,
1,
1,
1,
1,
1,
1,
1,
1,
1,

1,
1,
1,
0,
0,
0,
0,
0,
0,
0,

0,
0,
0,
0,
0,
0,
0,
0,
0,
0,

0,
0,
0,
0,
0,
0,
0,
0,
0,
0,

0





	const unsigned char FwdAttn2_2G_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn1_2G_TBL[] = {
		3,3,3,3,3,3,3,3,3,3,
		3,3,3,3,3,2,2,2,2,2,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn2_2G_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn3_2G_TBL[] = {
		2,2,2,2,2,2,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char FwdAttn1_LTE_TBL[] = {
		3,3,3,3,3,2,2,2,2,2,
		2,2,2,2,2,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char FwdAttn2_LTE_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn1_LTE_TBL[] = {
		3,3,3,3,3,3,2,2,2,2,
		2,2,2,2,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn2_LTE_TBL[] = {
		2,2,2,2,2,2,2,2,2,2,
		2,2,2,2,2,2,2,2,2,2,
		2,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn3_LTE_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char FwdAttn1_CDMALTE_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn1_CDMALTE_TBL[] = {
		2,2,2,2,2,2,2,2,2,2,
		2,2,2,2,2,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char FwdAttn1_LTE_A2_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char FwdAttn2_LTE_A2_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn1_LTE_A2_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn2_LTE_A2_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn3_LTE_A2_TBL[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,
		
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const signed char RvsAttn4_LTE_A2_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char FwdAttn1_WCDMA_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char FwdAttn2_WCDMA_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};


	const unsigned char RvsAttn1_WCDMA_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};


	const unsigned char RvsAttn2_WCDMA_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn3_WCDMA_TBL[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char RvsAttn4_WCDMA_TBL[] = {
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
		-1,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char TRIO_M_FwdAttn1_LTE_A[] = {
		1,1,1,1,1,1,1,1,1,1,
		1,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};

	const unsigned char TRIO_M_RvsAttn1_LTE_A[] = {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,
	};


	const unsigned short int  FwdOutPwr_CDMA_TBL[] = {
		2860,2805,2750,2696,2641,2586,2528,2469,2411,2352,
		2294,2238,2182,2125,2069,2013,1967,1922,1876,1831,
		1785
	};  
	
	const unsigned short int  RvsOutPwr_CDMA_TBL[] = {
		2144,2106,2068,2031,1993,1955,1919,1883,1847,1811,
		1775,1738,1701,1665,1628,1591,1554,1518,1481,1445,
		1408,1375,1342,1308,1275,1242,1209,1175,1142,1108,
		1075,1040,1004,969,933,898,869,840,812,783,

		754,735,715,696,676,657,650,641,633,621,
	};

	const unsigned short int  FwdOutPwr_LTE_TBL[] = {
		2960,2901,2841,2782,2722,2663,2613,2563,2512,2462,
		2412,2365,2318,2272,2225,2178,2136,2094,2052,2009,
		1968,
	};

	const unsigned short int  RvsOutPwr_LTE_TBL[] = {
		2239,2196,2154,2111,2069,2025,1992,1958,1924,1890,
		1856,1819,1783,1746,1710,1673,1643,1612,1582,1551,
		1521,1490,1460,1429,1399,1368,1333,1297,1262,1226,
		1191,1157,1124,1090,1057,1022,992,961,930,899,
		868,851,834,818,801,784,775,
 	};

	const unsigned short int  FwdInPwr_CDMALTE_TBL[] = {
		2416,2385,2355,2324,2294,2263,2231,2199,2167,2135,
		2103,2065,2025,1988,1949,1911,1868,1826,1783,1741,
		1698,1665,1632,1598,1565,1532,1498,1464,1430,1396,
		1362,1323,1284,1245,1206,1167,1138,1094,
 	};

	const unsigned short int  FwdOutPwr_CDMALTE_TBL[] = {
 		2073,2039,2005,1972,1938,1904,1869,1833,1798,1762,
		1727,1692,1658,1623,1589,1554,1520,1486,1453,1419,
		1385,
 	};


	const unsigned short int  RvsInPwr_CDMALTE_TBL[] = {
		3101,3036,2970,2905,2839,2774,2724,2674,2624,2574,
		2524,2474,2425,2375,2326,2276,2223,2170,2116,2063,
		2009,1955,1900,1844,1789,1734,1678,1622,1567,1511,
		1455,
	};

	const unsigned short int  RvsOutPwr_CDMALTE_TBL[] = {
		3128,2842,2556,2270,1984,1788,1591,1395,1199,1073,
		948,822,696,622,549,476,402,355,308,261,
		214,
 	};

	const unsigned short int  FwdOutPwr_LTE_A2_TBL[] = {
		2139,2118,2097,2076,2055,2033,1993,1952,1911,1870,
		1829,1791,1752,1714,1675,1637,1601,1565,1529,1493,
		1457,
	};

	const unsigned short int  RvsOutPwr_LTE_A2_TBL[] = {
		2068,2021,1975,1929,1882,1836,1800,1764,1729,1693,
		1657,1624,1591,1557,1524,1491,1462,1433,1403,1374,
		1345,1308,1270,1233,1195,1158,1126,1095,1063,1032,
		1000,984,968,952,936,920,910,901,
	};

	const unsigned short int  FwdInPwr_LTE_A_TBL[] = {
		1808,1766,1724,1683,1641,1599,1564,1530,1495,1461,
		1426,1395,1364,1332,1301,1270,1234,1198,1162,1126,
		1090,1056,1020,987,952,918,898,

	};

	const unsigned short int  RvsInPwr_LTE_A_TBL[] = {
		3156,3085,3013,2941,2870,2798,2724,2650,2576,2532,
		2489,2445,2396,2347,2298,2245,2191,2138,2088,2039,
		1989,1935,1882,1828,1774,1719,1665,1604,1543,1482,
		1425,1367,1310,1251,1192,1133,1085,1036,988,
	};

	const unsigned short int  FwdInPwr_WCDMA_TBL[] = {
		1674,1644,1615,1585,1556,1526,1487,1448,1408,1369,
		1330,1295,1260,1226,1191,1156,1120,1083,1047,1010,
		974,935,897,858,820,781,
	};

	const unsigned short int  FwdOutPwr_WCDMA_TBL[] = {
		2094,2053,2012,1972,1931,1890,1853,1815,1778,1740,
		1703,1665,1627,1589,1551,1513,1481,1449,1417,1385,
	};

	const unsigned short int  RvsInPwr_WCDMA_TBL[] = {
		3050,2988,2927,2865,2804,2743,2682,2632,2582,2532,
		2479,2426,2373,2320,2268,2215,2165,2116,2066,2005,
		1946,1886,1827,1768,1709,1648,1586,1525,1465,1404,
		1344,

	};

	const unsigned short int  RvsOutPwr_WCDMA_TBL[] = {
		2036,1991,1946,1901,1856,1811,1776,1740,1705,1669,
		1634,1594,1554,1514,1474,1434,1401,1368,1334,1301,
		1268,1238,1208,1179,1149,1119,1084,1049,1014,980,
		945,917,889,861,833,805,788,771,755,738,
		721,
	};

	const unsigned short int  TRIO_M_FwdOutPwr_LTE_A[] = {
		3303,3275,3247,3219,3191,3163,3110,3058,3005,2948,
		2890,2833,2770,2706,2643,2584,2526,2467,2406,2345,
		2284,

	};

	const unsigned short int  TRIO_M_RvsOutPwr_LTE_A[] = {
		3315,3307,3299,3291,3283,3275,3238,3200,3163,3108,
		3052,2997,2929,2862,2794,2726,2659,2591,2537,2483,
		2429,
	};
#endif
#else
	extern const signed char FwdOutPwrTemp_LTE_A2[];
	extern const signed char RvsOutPwrTemp_LTE_A2[];

#endif

#pragma pack()

void LoadTable(void);

void Response_Table(__ProtocolPtr *nPtr);
void TableIndexBackup(INT16U EEADDR, INT32U sptr, INT32U len);

INT16U SearchOffsetEeprom(INT32U offsetptrAddr);

INT32S ReadPwrTableAscending(INT32U AdcValue, INT8S tIndex, INT8U roundingoff, INT8U *isminval);//, INT8S limit, INT16U nsize);


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#ifdef TABLE_C
//////////////////////////////
	OS_EVENT *pBackupSem = NULL;

	EE_BACK1 gEE_BACK1;

	INT8U tmplimit = 0;

////////////////////////////////////////////////////////////////////////////////
#else
///////////////////////////////
	extern OS_EVENT *pBackupSem;

	extern EE_BACK1	 gEE_BACK1;

///////////////////////////////
#endif

INT8S TableIndex(INT8U TblID);
void DefaultValueSet(void);
void DefaultTableSet(void);
void DefaultTableInit(void);

INT8S PwrTableLocation(INT8U TblID);
void DefaultValueSet_Test(INT8U Value);


void DefaultTable(void);
	
INT8S PwrTablelimitLocation(INT8U tIndex,INT8U Mode);

////////////////////////////////////////////////////////////////////////////////
// End of Header file
///////////////////////

