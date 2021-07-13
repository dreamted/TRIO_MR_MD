/*********************************************
* File Name          : SdrTable.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/

#define Dnr0OutputTBL_Size			40
#define Dnr1OutputTBL_Size			70
#define Svr0OutputTBL_Size			40
#define Svr1OutputTBL_Size			70



#define AttTBL_Size 			61
#define TempTBL_Size			22

#define AttMaxLimit 			60
#define TempMaxlimit			80


#pragma pack(2)

typedef struct {
	INT8S limit;
	INT8U nsize;
	INT16U Data[Dnr0OutputTBL_Size];
} __Dnr0OutputTblStr;


typedef struct {
	INT8S limit;
	INT8U nsize;
	INT16U Data[Dnr1OutputTBL_Size];
} __Dnr1OutputTblStr;


typedef struct {
	INT8S limit;
	INT8U nsize;
	INT16U Data[Svr0OutputTBL_Size];
} __Svr0OutputTblStr;


typedef struct {
	INT8S limit;
	INT8U nsize;
	INT16U Data[Svr1OutputTBL_Size];
} __Svr1OutputTblStr;


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
	Index_RvsInPwr_CDMALTE,  ///10
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
	Index_RvsOutPwr_3G, /////28

	
	Index_FwdRmtOut_CDMALTE, /////
	Index_FwdRmtOut_WCDMA, 		/////
	Index_FwdRmtOut_LTE_A,	 /////	
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


//	Index_OtherRvsInPwr_3G, 
//	Index_OtherRvsInPwr_LTE_A1, 


	Index_Fwd1InPwr_LTE = 111, 
	Index_Fwd1OutAvgPwr_LTE, 
	Index_Fwd1OutPeakPwr_LTE, 
	Index_Rvs1InPwr_LTE, 
	Index_Rvs1OutPwr_LTE, 
	
	Index_Fwd1OutAvgPwr_LTE_A1, 
	Index_Fwd1OutPeakPwr_LTE_A1, 
	Index_Rvs1OutPwr_LTE_A1, 

	Index_FwdInPwr_LTE_A2_1,

	Index_Fwd1OutAvgPwr_LTE_A2, 
	Index_Fwd1OutPeakPwr_LTE_A2, 
	Index_Rvs1OutPwr_LTE_A2, 

	Index_FwdInPwr_LTE_A_1,
	Index_FwdOutAvgPwr_LTE_A_1,     
	Index_FwdOutPeakPwr_LTE_A_1, 
	Index_RvsInPwr_LTE_A_1,
	Index_RvsOutPwr_LTE_A_1, 

	Index_Fwd1Attn1_LTE,	
	Index_Fwd1Attn2_LTE,	
	Index_Rvs1Attn1_LTE,	
	Index_Rvs1Attn2_LTE,	
	Index_Rvs1Attn3_LTE,	
	Index_Rvs1Attn4_LTE,	
	
	Index_Fwd1Attn1_LTE_A1 , 

	////////////////////////////////
	Index_Fwd1Attn2_LTE_A1,
	
	Index_Rvs1Attn1_LTE_A1, 
	Index_Rvs1Attn2_LTE_A1, 
	Index_Rvs1Attn3_LTE_A1, 


	Index_Fwd1Attn1_LTE_A2, 
	Index_Fwd1Attn2_LTE_A2,
	
	Index_Rvs1Attn1_LTE_A2, 
	Index_Rvs1Attn2_LTE_A2, 
	Index_Rvs1Attn3_LTE_A2, 

	Index_FwdAttn1_LTE_A_1, 
	Index_FwdAttn2_LTE_A_1, 
	Index_FwdAttn3_LTE_A_1, 
	Index_RvsAttn1_LTE_A_1, 
	Index_RvsAttn2_LTE_A_1, 
	Index_RvsAttn3_LTE_A_1, 
	Index_RvsAttn4_LTE_A_1, 


	Index_Fwd1TempAttn_LTE,	
	Index_Rvs1TempAttn_LTE,	
	Index_Fwd1TempAttn_LTE_A1,	
	Index_Rvs1TempAttn_LTE_A1,	
	Index_Fwd1TempAttn_LTE_A2,	
	Index_Rvs1TempAttn_LTE_A2,	
	Index_Rvs1Attn5_LTE,	

};


enum {
	_DnrPwr0_Location = 0x00,
	_DnrPwr1_Location,
	_SvrPwr0_Location,
	_SvrPwr1_Location,
	
	_ETC_Location,
	
};

enum {
	_DnrAttn_Location = 0x00,
	_SvrAttn_Location,
};


enum {
	_FwdOutPwr_Location = 0x00,
	_FwdInPwr_Location,
	_RvsOutPwr_Location,
	_RvsInPwr_Location,
	
};



enum {
	Local_RvsOutPwr_CDMALTE = 0, 
	Local_FwdOutAvgPwr_LTE_A1,    
	Local_RvsOutPwr_LTE_A1, 
	Local_RvsOutPwr_LTE_A2, 
	Local_FwdOutAvgPwr_LTE_A2, 
	Local_FwdInPwr_LTE_A,
	Local_RvsOutPwr_LTE_A, 
	Local_FwdInPwr_3G, 
	Local_Fwd1OutAvgPwr_LTE, 
	Local_Rvs1InPwr_LTE, 
	Local_FwdOutAvgPwr_LTE_A_1, 

	Local_DnrPwr0_Max,
};


enum {
	Local_FwdInPwr_CDMALTE = 0,			//47 EA
	Local_RvsOutPwr_3G,					//55 EA
	Local_RvsInPwr_LTE_A_1,		///17   //38 EA
	
	Local_DnrPwr1_Max,
};


enum {
	Local_FwdOutAvgPwr_2G = 0,
	Local_RvsOutPwr_2G, 
	Local_FwdOutAvgPwr_LTE, 
	Local_RvsOutPwr_LTE, 
	Local_FwdOutAvgPwr_CDMALTE, 
	Local_RvsInPwr_CDMALTE,
	Local_FwdOutAvgPwr_LTE_A, 
	Local_FwdOutAvgPwr_3G, 
	Local_RvsInPwr_3G, 
	Local_SvrPwr0_Max,
};

enum {
	Local_RvsInPwr_LTE_A= 0,			//39 EA

	Local_Fwd1InPwr_LTE , 				//46 EA
	Local_Rvs1OutPwr_LTE, 
	Local_Fwd1OutAvgPwr_LTE_A1, 
	Local_Fwd1OutAvgPwr_LTE_A2, 
	Local_Rvs1OutPwr_LTE_A1, 
	Local_Rvs1OutPwr_LTE_A2, 
	Local_FwdInPwr_LTE_A_1,
	Local_RvsOutPwr_LTE_A_1, 			//24

	Local_SvrPwr1_Max,
};



enum {

	Local_RvsAttn2_2G = 0, 
	Local_RvsAttn3_2G, 
	Local_RvsAttn2_LTE, 
	Local_RvsAttn3_LTE, 
	Local_FwdAttn1_CDMALTE, 
	Local_FwdAttn1_LTE_A1, 
	Local_FwdAttn2_LTE_A1, 
	Local_RvsAttn1_LTE_A1, 
	Local_RvsAttn2_LTE_A1, 
	Local_RvsAttn3_LTE_A1, 	
	
	Local_FwdAttn1_LTE_A2, 
	Local_FwdAttn2_LTE_A2, 
	Local_RvsAttn1_LTE_A2, 
	Local_RvsAttn2_LTE_A2, 
	Local_RvsAttn3_LTE_A2, 
	Local_FwdAttn1_LTE_A, 
	Local_FwdAttn1_3G, 
	Local_FwdAttn2_3G, 
	Local_RvsAttn3_3G, 
	Local_RvsAttn4_3G, 
	
	Local_Rvs1Attn1_LTE,	
	Local_Rvs1Attn2_LTE,
	Local_RvsAttn1_LTE_A_1, 


	Local_DnrAttn_Max,
};

enum {
	Local_FwdAttn1_2G = 0, 
	Local_FwdAttn2_2G, 
	Local_RvsAttn1_2G, 
	Local_FwdAttn1_LTE, 
	Local_FwdAttn2_LTE, 
	Local_RvsAttn1_LTE, 
	Local_RvsAttn1_CDMALTE, 
	Local_RvsAttn1_LTE_A, 
	Local_RvsAttn1_3G, 
	Local_RvsAttn2_3G, 
	Local_Fwd1Attn1_LTE,	
	
	Local_Fwd1Attn2_LTE,	
	Local_Rvs1Attn3_LTE,	
	Local_Rvs1Attn4_LTE,	
	Local_Fwd1Attn1_LTE_A1, 
	Local_Fwd1Attn2_LTE_A1,
	Local_Rvs1Attn1_LTE_A1, 
	Local_Rvs1Attn2_LTE_A1, 
	Local_Rvs1Attn3_LTE_A1, 
	Local_Fwd1Attn1_LTE_A2, 
	Local_Fwd1Attn2_LTE_A2,
	Local_Rvs1Attn1_LTE_A2, 
	Local_Rvs1Attn2_LTE_A2, 
	Local_Rvs1Attn3_LTE_A2, 
	Local_FwdAttn1_LTE_A_1, 
	
	Local_Svr0Attn_Max,
};



enum {
	Local_FwdTempAttn_2G = 0,	
	Local_RvsTempAttn_2G,	
	Local_FwdTempAttn_LTE, 
	Local_RvsTempAttn_LTE, 
	Local_FwdTempAttn_LTE_A1,
	Local_RvsTempAttn_LTE_A1,
	Local_FwdTempAttn_LTE_A2,
	Local_RvsTempAttn_LTE_A2,
	Local_FwdTempAttn_3G,	
	Local_RvsTempAttn_3G,


	Local_Fwd1TempAttn_LTE, 
	Local_Rvs1TempAttn_LTE, 
	Local_Fwd1TempAttn_LTE_A1, 
	Local_Rvs1TempAttn_LTE_A1, 
	Local_Fwd1TempAttn_LTE_A2, 
	Local_Rvs1TempAttn_LTE_A2,

	Local_TempAttn_Max,
};

#pragma pack(1)

////////////////////////////////////////////////////////////////////////////////
// Internal FLASH CASE
typedef struct {
	INT8U IsDataFlag;

	INT8S FwdOutUpperLmt_3G[2]; 		// 0x0504
	INT8S FwdOutLowerLmt_3G[2]; 		// 0x0505
	INT8U FwdGainSet_3G;				// 0x0529  Forward Gain(설정값)
	INT8S FwdOutUpperLmt_2G[2]; 		// 0x0515
	INT8S FwdOutLowerLmt_2G[2]; 		// 0x0516
	INT8U FwdGainSet_2G;				// 0x0542  Forward Gain(설정값)

	INT8S FwdOutUpperLmt_LTE[2];		// 0x0557	
	INT8S FwdOutLowerLmt_LTE[2];		// 0x0558
	INT8U FwdGainSet_LTE;				// 0x056E  Forward Gain(설정값)

	INT8S FwdOutUpperLmt_LTE_A1[2]; 	// 0x056D
	INT8S FwdOutLowerLmt_LTE_A1[2]; 	// 0x056E
	INT8U FwdGainSet_LTE_A1; 			// 0x0578  Forward Gain(설정값)

	INT8S FwdOutPwr_LTE_A2[2];			// 0x1B14
	INT8S FwdOutUpperLmt_LTE_A2[2]; 	// 0x1B15  (Range: 7 ~ 17dBm)
	INT8S FwdOutLowerLmt_LTE_A2[2]; 	// 0x1B16

	INT8U FwdGainSet_LTE_A2;			// 0x1B1A  Forward Gain(설정값) 38~83dB

//////////////////////
	INT8U Rvs0GainSet_3G;				// 0x0604	Reverse Gain(설정값)
	INT8U RvsGainBalance_3G;			// 0x062D	Reverse Gain Balance

	INT8U Rvs0GainSet_2G;				// 0x060F	Reverse Gain(설정값)
	INT8U RvsGainBalance_2G;			// 0x063F	Reverse Gain Balance

	INT8U Rvs0GainSet_LTE;				// 0x0669	Reverse Gain(설정값)
	INT8U RvsGainBalance_LTE;			// 0x0676	Reverse Gain Balance

	INT8U Rvs0GainSet_LTE_A1;			// 0x0671	Reverse Gain(설정값)
	INT8U RvsGainBalance_LTE_A1; 		// 0x067C	Reverse Gain Balance


	INT8U Rvs0GainSet_LTE_A2;			// 0x1C0B	Reverse Gain(설정값)
	INT8U RvsGainBalance_LTE_A2;		// 0x1C0C	Reverse Gain Balance

	INT8U LTE15MUse;					// 0x1059

	INT8U Band_Select_LTE_A1;			// 0x1065
	INT8U Band_Select_LTE_A2[3];		// 0x1066
	INT8U FemtocellUseOnOff;			// 0x1062

	INT8U RepeatResetPriod;				// 0x102A

	INT8U HostNumber[11];				// 0x0920
	INT8U AutoReportPriod;				// 0x0922
	INT8U AutoReportBasePer[2];			// 0x0923

	INT8U AGCOnOff_3G;					// 0x090A
	INT8U AGCOnOff_CDMALTE;				// 0x1068
	INT8U AGCOnOff_LTE_A_0;				// 0x1069
	INT8U AGC1OnOff_LTE;				// 0x105F
	INT8U AGCOnOff_LTE_A_1;				// 0x106A

	INT8U AGCMode_3G;					// 0x105B
	INT8U AGCMode_2G;					// 0x105C
	INT8U AGCMode_LTE;					// 0x105D
	INT8U AGCMode_LTE_A1;				// 0x105E
	INT8U AGCMode_LTE_A2;				// 0x1067
	////////////////////////////////////////////////////

	INT8U TPTL_OnOff;					// 0xA000					
	INT8S TempOffset;					// 0xA001
	INT8U AlarmMask;					// 0xA00D
	__TBL16 VccDet_Lmt; 				// 0xA02B

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

	INT8S FwdInPwrOffset_LTE_A1; 		// 0xA805
	INT8S FwdOutPwrOffset_LTE_A1;		// 0xA806
	INT8S RvsOutPwrOffset_LTE_A1;		// 0xA807
	INT8U FwdGainOffset_LTE;			// 0xA822
	INT8U RvsGainOffset_LTE;			// 0xA823
	INT8U FwdGainOffset_LTE_A1;			// 0xA824
	INT8U RvsGainOffset_LTE_A1;			// 0xA825

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
	INT8U EcIo;							// 0x0C09
	INT8U AR_Mode[2];					// 0x0C11
	INT8U Radio_ReportTime[2];			// 0x0C12
	INT8U Radio_ReportPeriod[2];		// 0x0C13
	INT8U TestStn[11];					// 0x0C14
	
////
	INT8S Fwd1OutUpperLmt_LTE[2];		// 0x1B01
	INT8S Fwd1OutLowerLmt_LTE[2];		// 0x1B02
	INT8U Fwd1GainSet_LTE;				// 0x1B03 Forward Gain(설정값)

	INT8S Fwd1OutUpperLmt_LTE_A1[2]; 	// 0x1B07
	INT8S Fwd1OutLowerLmt_LTE_A1[2]; 	// 0x1B08
	INT8U Fwd1GainSet_LTE_A1; 			// 0x1B09 Forward Gain(설정값)

	INT8S Fwd1OutUpperLmt_LTE_A2[2];	// 0x1B1F
	INT8S Fwd1OutLowerLmt_LTE_A2[2];	// 0x1B20
	INT8U Fwd1GainSet_LTE_A2;			// 0x1B21 Forward Gain(설정값)

	INT8U Rvs1GainSet_LTE;				// 0x1C00	Reverse Gain(설정값)
	INT8U Rvs1GainBalance_LTE;			// 0x1C02	Reverse Gain Balance
	INT8U Rvs1GainSet_LTE_A1;			// 0x1C05	Reverse Gain(설정값)
	INT8U Rvs1GainBalance_LTE_A1; 		// 0x1C07	Reverse Gain Balance
	INT8U Rvs1GainSet_LTE_A2;			// 0x1C11	Reverse Gain(설정값)

	INT8U Rvs1GainBalance_LTE_A2;		// 0x1C13	Reverse Gain Balance

	__DET1Offset Det1Offset;			// 0xA902

	INT8S Fwd1InPwrOffset_LTE;			// 0xA905
	INT8S Fwd1OutPwrOffset_LTE; 		// 0xA906
	INT8S Rvs1OutPwrOffset_LTE; 		// 0xA907
	INT8S Fwd1InPwrOffset_LTE_A1;		// 0xA908
	INT8S Fwd1OutPwrOffset_LTE_A1;		// 0xA909
	INT8S Rvs1OutPwrOffset_LTE_A1;		// 0xA90A
	INT8U Fwd1GainOffset_LTE;			// 0xA91D
	INT8U Rvs1GainOffset_LTE;			// 0xA91E
	INT8U Fwd1GainOffset_LTE_A1; 		// 0xA91F
	INT8U Rvs1GainOffset_LTE_A1; 		// 0xA920


	INT8S Fwd1InPwrOffset_LTE_A2;		// 0xA93D
	INT8S Fwd1OutPwrOffset_LTE_A2;		// 0xA93E
	INT8S Rvs1OutPwrOffset_LTE_A2;		// 0xA93F
	
	INT8U Fwd1GainOffset_LTE_A2;		// 0xA949
	INT8U Rvs1GainOffset_LTE_A2;		// 0xA94A

////////////////
	INT8U FwdAmpOnOff_3G;				// 0x0706
	INT8U FwdAmpOnOff_2G;				// 0x0715
	INT8U FwdAmpOnOff_LTE; 				// 0x074F
	INT8U FwdAmpOnOff_LTE_A1;			// 0x0750
	INT8U FwdAmpOnOff_LTE_A2;			// 0x0759
	INT8U FwdAmp1OnOff_LTE;				// 0x0754
	INT8U FwdAmp1OnOff_LTE_A1;			// 0x0755
	INT8U FwdAmp1OnOff_LTE_A2;			// 0x0759
///////////////////////////////////////////////////////////////

	INT8S RvsALCLvl_2G; 				// 0xA85D
	INT8S RvsALCLvl_LTE;				// 0xA85E
	INT8S RvsALCLvl_LTE_A1; 			// 0xA85F
	INT8S RvsALCLvl_LTE_A2; 			// 0xA893
	INT8S RvsALCLvl_3G; 				// 0xA860
	INT8U Rvs1ALCLvl_LTE;				// 0xA939
	INT8U Rvs1ALCLvl_LTE_A1;			// 0xA93A
	INT8U Rvs1ALCLvl_LTE_A2;			// 0xA957
///////////////////////////////////////////////////////////
	INT8U MasterPNH; 					//
	INT8U MasterPNL;
	INT8U RB_StsOnOff;					// 0xD019

	INT16U DCOffSet;					// 0xD01C
	INT8U PllFregOffset_LTE;			// 0xA8AD	

	
/////////////////////////////////////////////////20130319
//	INT8U Sp[37];

#if 1
	__SleepMode  SleepMode_2G;
	__SleepMode  SleepMode_LTE;
	__SleepMode  SleepMode_LTE_A1;
	__SleepMode  SleepMode_LTE_A2;
	
	INT8U Sp[17];
#endif
} __BackupStr;


enum {
	///////////////////////////////////
	BackupInitCheck,
	ResetCaseBp,
	IsDataFlag,
	HW_Ver,
	SW_Ver,

	Dnr0TableBp		= 100,
	Dnr1TableBp 	= 1*1024,

	Svr0TableBp		= 2*1024,
	Svr1TableBp 	= 3*1024,


	DnrAttnTableBp 	= 4*1024,
	Svr0AttnTableBp = 5*1024,	
	Svr1AttnTableBp = 6*1024,		
	AttnTptlTableBp = 7*1024,

	COMTestBp 		= 8*1024 - 20,
	InputTestBp,
	OutputTestBp,
	AnalogTestBp,
	
	BackupEnd = 8*1024		// 8k, 8192
};

#pragma pack()


////////////////////////////////////////////////////////////////////////////////
// BACKUP 1st ADDRESS AREA(DON'T OVER 1024 Bytes
typedef struct {
	INT16U bSize;

	__BackupStr 		BackUp;								// 총갯수 282
	__AttnOffsetTblStr 	SvrAttnTbl[Local_Svr0Attn_Max];

	INT16U				VerifyFlag;
} EE_BACK1;

typedef struct {
 	INT16U bSize;
	__Svr0OutputTblStr 	Svr0OutputTbl[Local_SvrPwr0_Max];	//11
	__Svr1OutputTblStr 	Svr1OutputTbl[Local_SvrPwr1_Max];	//11

	INT16U				VerifyFlag;
} EE_TABLE;

typedef struct {
	INT16U bSize;

	INT8U OutputTestBp;
	INT8U InputTestBp;
	INT8U COMTestBp;
	INT8U AnalogTestBp;
	INT8U eepromBp;
	__Dnr0OutputTblStr		Dnr0OutputTbl[Local_DnrPwr0_Max];	// 11
	__Dnr1OutputTblStr		Dnr1OutputTbl[Local_DnrPwr1_Max];	// 11

	INT16U VerifyFlag;
} EE_TABLE1;


typedef struct
{
	INT16U bSize;			// backup size!!
	INT8U  Data[20];
//////////////////////////////////////////
	__AttnTempTblStr	AttnTempTbl[Local_TempAttn_Max];
	__AttnOffsetTblStr 	DnrAttnTbl[Local_DnrAttn_Max];

	INT16U				VerifyFlag;
} SYS_TABLE;

#define vEE_TABLE 		((EE_TABLE *)(__pVEEPAddr + (0*1024)))	 ///vEE_TABLE: 8008000    
#define vEE_BACK1 		((EE_BACK1 *)(__pVEEPAddr + (2*1024))) 	 ///vEE_BACK1: 8008800  	
#define vEE_TABLE1 		((EE_TABLE1 *)(__pVEEPAddr + (4*1024)))	 ///vEE_BACK2: 8009000 	
#define vSYS_TABLE 		((SYS_TABLE *)(__pSYSTAddr))	 		///vEE_BACK2: 8009000 	

#define vEE_TABLEAddr	(__pVEEPAddr + (0*1024))				 ///vEE_TABLE: 8008000   					
#define vEE_BACK1Addr	(__pVEEPAddr + (2*1024))				 ///vEE_BACK1: 8008800   					
#define vEE_TABLE1Addr	(__pVEEPAddr + (4*1024))				 ///vEE_BACK2: 8009000 	
#define vSYS_TABLEAddr	(__pSYSTAddr)							 ///vEE_BACK2: 8009000 	



#define vSYS_BACK 		((SYS_BACK *)(__pSYSTAddr))	 ///vEE_BACK2: 8009000 	



////////////////////////////////////////////////////////////////////////////////
// End of Header file
///////////////////////

