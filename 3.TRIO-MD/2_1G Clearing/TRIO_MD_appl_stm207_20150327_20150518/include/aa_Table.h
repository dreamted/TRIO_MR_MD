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
	type32 totalSize;
	type32 totalCRC;		 
	type16 DnFlag; 	 
} __sFlashDownArea;


typedef struct {
	union{
		INT8U	Data[700];

		struct {
			INT8U	IsDataFlag;
			INT8U	IsFirstFlag;
			INT8U	TransceiveMaker;
//////////////////////////////////////////////////////////////////////////20131004
			INT8U DCOffSet[2];						// 0xD01C
			INT8U VccDet_Lmt[2]; 					// 0xA02B

			type16 DTUPeakOffset[DTU_Power_MAX];	// 0xA8D7
			type16 DTUAverOffset[DTU_Power_MAX];	// 0xA8D8
			type16 ISOOffset[DTU_ISO_MAX];			// 0xA8E2
			type32 SampleOffsetA;					// 0xA8E8
			type16 SampleOffsetB;					// 0xA8E8
			INT8U SpEn0[100];			

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
			INT8U Rvs0GainSet_2G;				// 0x060F	Reverse Gain(설정값)
			INT8U Rvs0GainSet_LTE;				// 0x0669	Reverse Gain(설정값)
			INT8U Rvs0GainSet_LTE_A2;			// 0x1C0B	Reverse Gain(설정값)
		
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
			INT8S FwdInPwrOffset_2G;			// 0xA101
			INT8S FwdInPwrOffset_3G;			// 0xA102
			INT8S Rvs0OutPwrOffset_2G;			// 0xA109
			INT8S Rvs0OutPwrOffset_3G;			// 0xA10B
			INT8S FwdOutPwrOffset_2G;			// 0xA158
			INT8S FwdOutPwrOffset_3G;			// 0xA159
		
			INT8S FwdInPwrOffset_LTE;			// 0xA1C3
			INT8S FwdOutPwrOffset_LTE;			// 0xA1C4
			INT8S RvsOutPwrOffset_LTE;			// 0xA1CD
		
			INT8S FwdGainOffset_3G; 			// 0xA36A
			INT8S RvsGainOffset_3G; 			// 0xA36B
			INT8S FwdGainOffset_2G; 			// 0xA36C
			INT8S RvsGainOffset_2G; 			// 0xA36D
		
	        INT8S FwdGainOffset_LTE;			// 0xA822
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
			INT8U FwdAmpOnOff_LTE_21;			// 0x1F36
		///////////////////////////////////////////////////////////////
			INT8U MasterPNH;					//
			INT8U MasterPNL;

			INT8S FwdOutUpperLmt_LTE_21[2]; 	// 0x2266  (Range: 7 ~ 17dBm)
			INT8S FwdOutLowerLmt_LTE_21[2]; 	// 0x2267
			INT8U FwdGainSet_LTE_21;			// 0x226A  Forward Gain(설정값) 38~83dB

			INT8U RvsGainSet_LTE_21;			// 0x2828	Reverse Gain(설정값)
			INT8U LTE_21Use;					// 0x1E10
			INT8U AGCOnOff_WCDMALTE_21;			// 0x2329
			INT8U AGCMode_LTE_21;				// 0x2328

			INT8U Band_Select_CDMALTE[3];		// 0x232D
			INT8U Band_Select_LTE_A[3]; 		// 0x232E
			INT8U Band_Select_WCDMALTE_21[3];	// 0x232F

			INT8S FwdInPwrOffset_LTE_21;		// 0xAF00
			INT8S RvsOutPwrOffset_LTE_21;		// 0xAF01
			INT8S FwdOutPwrOffset_LTE_21;		// 0xAF02
			
			INT8U FwdGainOffset_LTE_21; 		// 0xAF07
			INT8U RvsGainOffset_LTE_21; 		// 0xAF08
			INT8U RvsGainBalance_CDMALTE;			// 0x1C2E	Reverse Gain Balance
			INT8U RvsGainBalance_LTE_A; 			// 0x1C2F	Reverse Gain Balance
			INT8U RvsGainBalance_WCDMALTE_21;		// 0x2829	Reverse Gain Balance

			__AGC_OnOff SmartAGCDLOnOff;			// 0xA8DD
			__AGC_OnOff SmartAGCULOnOff;			// 0xA8DE
			INT8U DTU_DLAGCLevel[SvrPATH_MAX][2];	// 0xA8DF
			INT8U DTU_ULAGCLevel[SvrPATH_MAX][2];	// 0xA8E0
			INT16U ISOLmt[DTU_ISO_MAX];			// 0xA8E3

         	__DET DetOffset;				    // 0xA802

			INT8S Sp[3];

			INT8U ULGainPriod;					// 0x282A
			INT8U ULGainMode;					// 0x282B
		  
			INT8S RvsALCLvl_2G;				  // 0xA85D
			INT8S RvsALCLvl_LTE;			  // 0xA85E
			INT8S RvsALCLvl_LTE_A2;			  // 0xA893
			INT8S RvsALCLvl_3G;				  // 0xA860
			INT8S RvsALCLvl_LTE_21;			  // 0xAF19

			INT8S ULGainOutLmt[3];
			INT8S RvsInPwrOffset[PATH_MAX]; 	// 0xD02C
			INT8S PLLOffset[SvrPATH_MAX];
			type16 DLISOOffset[PATH_MAX];		// 0xD02E
			type16 ULISOOffset[PATH_MAX];		// 0xD02F

			INT8U FilterStart;
			__DTUFilterSts DTUFilterSts;

			INT8U FilterUSE[DTU_FilterDN_MAX];

			INT8U FTP_IP[4];
			INT8U FTP_Port;
			INT8U FTP_ID[20];
			INT8U FTP_ID_len;
			
			INT8U FTP_PW[20];
			INT8U FTP_PW_len;
			
			INT8U FTP_DnFilePath[20];
			INT8U FTP_DnFilePath_len;
			
			INT8U FTP_DnFileName[20];
			INT8U FTP_DnFileName_len;
			INT8U FTP_DnHours[6];


  			INT8U FPGADownLoadFlag1;
			INT8U FPGADownLoadFlag2;
////////////////////////////////////////

			INT32U totalSize;
			INT16U totalCRC;

			__sFlashDownArea sFlashDownArea;
			__sFlashDownArea sFlashApplArea;

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
//	Index_FwdOutAvgPwr_2G		= 0x00,

	Index_FwdOutAvgPwr_CDMALTE 	= 8, 
	Index_RvsOutPwr_CDMALTE 	= 11, 

	Index_FwdOutAvgPwr_LTE_A 	= 15, 
	Index_RvsOutPwr_LTE_A 		= 17, 
 	
	Index_FwdOutAvgPwr_3G    	= 25, 
	Index_RvsOutPwr_3G     		= 28, 			/////28

	Index_FwdAttn1_CDMALTE 		= 46,	
	Index_RvsAttn1_CDMALTE		= 49,	
	Index_RvsAttn2_CDMALTE		= 50,	
	Index_RvsAttn3_CDMALTE		= 51,	
	Index_FwdAttn1_LTE_A		= 65,
	Index_RvsAttn1_LTE_A		= 68,
	Index_RvsAttn2_LTE_A		= 69,
	Index_RvsAttn3_LTE_A		= 70,

	Index_FwdAttn1_3G			= 72,	
	Index_RvsAttn1_3G			= 76,	
	Index_RvsAttn2_3G			= 77,	
	Index_RvsAttn3_3G			= 78,	

	Index_FwdTempAttn_2G		= 81,	
	Index_RvsTempAttn_2G		= 82,	
	Index_FwdTempAttn_LTE_A 	= 87,
	Index_RvsTempAttn_LTE_A 	= 88,
	Index_FwdTempAttn_3G		= 89,	
	Index_RvsTempAttn_3G		= 90,
};


enum {
	_FwdOutPwr_Location = 0x00,
	_FwdInPwr_Location,
	_RvsOutPwr_Location,
	_RvsInPwr_Location,
	
};

enum {
	Local_FwdOutAvgPwr_CDMALTE = 0x00,
	Local_RvsOutPwr_CDMALTE, 
	
	Local_FwdOutAvgPwr_LTE_A, 	
	Local_RvsOutPwr_LTE_A,    
	Local_FwdOutAvgPwr_3G, 
	Local_RvsOutPwr_3G, 		


	Local_PwrSts_Max,
};


enum {
//////
	Local_FwdAttn1_CDMALTE = 0x00,	
	Local_RvsAttn1_CDMALTE,	 ///10
	Local_RvsAttn2_CDMALTE,	 ///10
	Local_RvsAttn3_CDMALTE,	 ///10

	
	Local_FwdAttn1_LTE_A, 
	Local_RvsAttn1_LTE_A, 
	Local_RvsAttn2_LTE_A, 
	Local_RvsAttn3_LTE_A, 

	Local_FwdAttn1_WCDMALTE_21,	
	Local_RvsAttn1_WCDMALTE_21,	
	Local_RvsAttn2_WCDMALTE_21,	
	Local_RvsAttn3_WCDMALTE_21,	
	
	Local_AttnSts_Max,
};


enum {
	Local_FwdTempAttn_2G = 0x00,	
	Local_RvsTempAttn_2G,	
	Local_FwdTempAttn_LTE_A,
	Local_RvsTempAttn_LTE_A,
	Local_FwdTempAttn_WCDMALTE_21,	
	Local_RvsTempAttn_WCDMALTE_21,

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
	__OutputTblStr FwdOutAvgPwr_CDMALTE;
	__OutputTblStr RvsOutPwr_CDMALTE; 
	__OutputTblStr FwdOutAvgPwr_LTE_A;
	__OutputTblStr RvsOutPwr_LTE_A;
	__OutputTblStr FwdOutAvgPwr_WCDMALTE_21; 
	__OutputTblStr RvsOutPwr_WCDMALTE_21;
} __OutputTable;


typedef struct {
	__AttnOffsetTblStr FwdAttn1_CDMALTE;
	__AttnOffsetTblStr RvsAttn1_CDMALTE;
	__AttnOffsetTblStr RvsAttn2_CDMALTE;
	__AttnOffsetTblStr RvsAttn3_CDMALTE;


	__AttnOffsetTblStr FwdAttn1_LTE_A;
	__AttnOffsetTblStr RvsAttn1_LTE_A;
	__AttnOffsetTblStr RvsAttn2_LTE_A;
	__AttnOffsetTblStr RvsAttn3_LTE_A;


	__AttnOffsetTblStr FwdAttn1_WCDMALTE_21;
	__AttnOffsetTblStr RvsAttn1_WCDMALTE_21;
	__AttnOffsetTblStr RvsAttn2_WCDMALTE_21;
	__AttnOffsetTblStr RvsAttn3_WCDMALTE_21;
} __AttnOffsetTable;





typedef struct {
	__AttnTempTblStr FwdTemp_CDMALTE;	
	__AttnTempTblStr RvsTemp_CDMALTE;	
	__AttnTempTblStr FwdTempAttn_LTE_A;
	__AttnTempTblStr RvsTempAttn_LTE_A;
	__AttnTempTblStr FwdTemp_WCDMALTE_21;
	__AttnTempTblStr RvsTemp_WCDMALTE_21;

} __AttnTempTable;


#define Filter1_Max 200
typedef struct {
	INT8U Flag;
	INT8U Filter_Cnt;

	INT8U Path;
	INT8U DLFreg_Sel;
	INT8U DLFreg_Data[4];

	INT8U ULFreg_Sel;
	INT8U ULFreg_Data[4];
	INT8U Filter_Data[Filter1_Max];

} __FilterTblStr;



typedef struct {
	__FilterTblStr Filter_800M_L;	
	__FilterTblStr Filter_800M_R;	
	__FilterTblStr Filter_1800M_L;	
	__FilterTblStr Filter_1800M_R;	
	__FilterTblStr Filter_2100M_L;	
	__FilterTblStr Filter_2100M_R;	
} __FilterTable;






//////////////////////



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

	FilterBp 		= 3*1024,
	
//	FilterBpEnd		= FilterBp + sizeof(__FilterTable),
	
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

//////////////////////////////////////////////////////////
	const signed char FwdOutPwrTemp_CDMA[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,-1,-2,-2,-2,-2,-2,
		-2,-2,
	};

	const signed char RvsOutPwrTemp_CDMA[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};
	
	const signed char FwdOutPwrTemp_LTE[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,-1,-2,-2,-2,-2,-2,
		-2,-2,
	};

	const signed char RvsOutPwrTemp_LTE[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char FwdOutPwrTemp_WCDMA[]= {
		1,1,1,1,1,1,1,0,0,0,
		0,0,-1,-2,-3,-4,-4,-4,-4,-4,
		-4,-4,
	};

	const signed char RvsOutPwrTemp_WCDMA[]= {
		3,3,3,3,3,2,1,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char FwdOutPwrTemp_LTE_21[]= {
		4,4,4,4,4,3,2,1,0,0,
		0,0,-1,-2,-3,-4,-4,-4,-4,-4,
		-4,-4,
	};

	const signed char RvsOutPwrTemp_LTE_21[]= {
		1,1,1,1,1,1,0,0,0,0,
		0,0,0,-1,-2,-2,-2,-2,-2,-2,
		-2,-2,
	};

	const signed char FwdOutPwrTemp_LTE_A2[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};

	const signed char RvsOutPwrTemp_LTE_A2[]= {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,
	};
////////////////////////////////////////////////////



	
#endif

#else
	extern const signed char FwdOutPwrTemp_LTE_A2[];
	extern const signed char RvsOutPwrTemp_LTE_A2[];


	extern const signed char FwdOutPwrTemp_CDMA[];
	extern const signed char RvsOutPwrTemp_CDMA[];
	extern const signed char FwdOutPwrTemp_LTE[];
	extern const signed char RvsOutPwrTemp_LTE[];
	extern const signed char FwdOutPwrTemp_WCDMA[];
	extern const signed char RvsOutPwrTemp_WCDMA[];
	extern const signed char FwdOutPwrTemp_LTE_21[];
	extern const signed char RvsOutPwrTemp_LTE_21[];
	extern const signed char FwdOutPwrTemp_LTE_A2[];
	extern const signed char RvsOutPwrTemp_LTE_A2[];


#endif

#pragma pack()

void LoadTable(void);

void Response_Table(__ProtocolPtr *nPtr);
void TableIndexBackup(INT16U EEADDR, INT32U sptr, INT32U len);

INT16U SearchOffsetEeprom(INT32U offsetptrAddr);


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#ifdef TABLE_C
//////////////////////////////
	OS_EVENT *pBackupSem = NULL;

	EE_BACK1 gEE_BACK1;
	INT8U tmplimit = 0;

	__FilterTblStr gFilterTblStr;

////////////////////////////////////////////////////////////////////////////////
#else
///////////////////////////////
	extern OS_EVENT *pBackupSem;

	extern EE_BACK1	 gEE_BACK1;
	extern __FilterTblStr gFilterTblStr;

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


void TableIndexBackup_1(INT16U EEADDR, INT32U sptr, INT32U len);
void TableBackup(INT16U EEADDR, INT8U *sptr, INT32U len);


INT16U SearchOffsetEeprom1(INT32U offsetptrAddr);

////////////////////////////////////////////////////////////////////////////////
// End of Header file
///////////////////////

