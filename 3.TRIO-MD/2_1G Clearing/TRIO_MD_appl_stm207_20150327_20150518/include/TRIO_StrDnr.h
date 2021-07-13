/*********************************************
* File Name          : TRIO_StrDnr.h
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/

#pragma pack(1)

typedef union  {
	INT8U Data[8];
	// 알람 발생

	struct {

		INT8U OverInAlarm_WCDMALTE_21	:1; 	/// 타사   FwdOtherOverInAlarm
		INT8U FwdOutLowerLmtFail_LTE_21	:1;
		INT8U FwdOutUpperLmtFail_LTE_21	:1;
		INT8U FwdInUpperLmtFail_LTE_21	:1;
		INT8U FwdOutLowerLmtFail_3G 	:1;
		INT8U FwdOutUpperLmtFail_3G 	:1;
		INT8U FwdInUpperLmtFail_3G		:1;
		INT8U							:1; 	//7

		INT8U OverInAlarm_CDMALTE		:1;    /// 타사 
		INT8U FwdOutLowerLmtFail_LTE	:1;
		INT8U FwdOutUpperLmtFail_LTE	:1;
		INT8U FwdInUpperLmtFail_LTE 	:1;
		INT8U FwdOutLowerLmtFail_2G		:1;
		INT8U FwdOutUpperLmtFail_2G		:1;
		INT8U FwdInUpperLmtFail_2G		:1;
		INT8U							:1; 	//7

		INT8U 							:3; 	
		INT8U OverInAlarm_LTE_A			:1;    /// 타사 
		INT8U FwdOutLowerLmtFail_LTE_A2	:1;
		INT8U FwdOutUpperLmtFail_LTE_A2	:1;
		INT8U FwdInUpperLmtFail_LTE_A2	:1;
		INT8U							:1; 	

	
		INT8U 							:4; 	
		INT8U LocalFail_LTE_A 			:1;
		INT8U LocalFail_CDMALTE			:1;
		INT8U LocalFail_WCDMALTE_21		:1;
		INT8U							:1; 	//7

		INT8U 							:2; 	
		INT8U RvsOutUpperLmtFail_LTE_21 :1;
		INT8U RvsOutUpperLmtFail_LTE_A2 :1;
		INT8U RvsOutUpperLmtFail_LTE	:1;
		INT8U RvsOutUpperLmtFail_2G 	:1;
		INT8U RvsOutUpperLmtFail_3G 	:1;
		INT8U							:1; 	//7

		INT8U 							:2; 	
		INT8U FwdAmpOnOff_LTE_21		:1;
		INT8U FwdAmpOnOff_LTE_A2		:1;
		INT8U FwdAmpOnOff_LTE			:1;
		INT8U FwdAmpOnOff_2G			:1;
		INT8U FwdAmpOnOff_3G			:1;
		INT8U							:1; 	//7


		INT8U 								:1;
		INT8U ULGainLowAlarm_LTEA			:1;
		INT8U ULGainLowAlarm_CDMALTE		:1;
		INT8U ULGainLowAlarm_WCDMALTE_21	:1;
//		INT8U ISOAlarm_LTEA					:1;
//		INT8U ISOAlarm_CDMALTE				:1;
//		INT8U ISOAlarm_WCDMALTE_21			:1;
		INT8U 								:4;	

		INT8U 								:5;
		INT8U DigitalAlarm					:1;	
		INT8U ACFail						:1;  	///중계기 전원 Off
		INT8U								:1; 	//7
	};
} __DnrAlarmDataStr;

typedef struct  {
	// 알람 발생
	union {
		INT8U Data;
		struct {
			INT8U  						:1;
			INT8U  						:1;
			INT8U 						:1;
			INT8U ShutDown				:1;
			INT8U PllUnlock				:1;
			INT8U LowInputAlarm			:1;
			INT8U OverInAlarm			:1;
			INT8U RvsOscAlarm			:1;		//7
		};
	} _LED_3G;

	union {
		INT8U Data;
		struct {
			INT8U  						:1;
			INT8U  						:1;
			INT8U 						:1;
			INT8U ShutDown				:1;
			INT8U PllUnlock				:1;
			INT8U LowInputAlarm			:1;
			INT8U OverInAlarm			:1;
			INT8U RvsOscAlarm			:1;		//7
		};
	} _LED_2G;

	union {
		INT8U Data;
		struct {
			INT8U  						:1;
			INT8U  						:1;
			INT8U 						:1;
			INT8U ShutDown				:1;
			INT8U PllUnlock				:1;
			INT8U LowInputAlarm			:1;
			INT8U OverInAlarm			:1;
			INT8U RvsOscAlarm			:1;		//7
		};
	} _LED_LTE;

	union {
		INT8U Data;
		struct {
			INT8U  						:1;
			INT8U  						:1;
			INT8U 						:1;
			INT8U ShutDown				:1;
			INT8U PllUnlock				:1;
			INT8U LowInputAlarm			:1;
			INT8U OverInAlarm			:1;
			INT8U RvsOscAlarm			:1;		//7
		};
	} _LED_LTE_A2;	

	union {
		INT8U Data;
		struct {
			INT8U						:1;
			INT8U						:1;
			INT8U						:1;
			INT8U ShutDown				:1;
			INT8U PllUnlock				:1;
			INT8U LowInputAlarm			:1;
			INT8U OverInAlarm			:1;
			INT8U RvsOscAlarm			:1;		//7
		};
	} _LED_LTE_21;	
}__Led_Alarm;


typedef struct {
	__TBL16 FwdOutAvgVolt_CDMALTE; 
	__TBL16 RvsOutVolt_CDMALTE; 
	__TBL16 FwdOutAvgVolt_LTE_A; 
	__TBL16 RvsOutVolt_LTE_A; 
//	__TBL16 FwdOutAvgVolt_3G; 
//	__TBL16 RvsOutVolt_3G; 				/////32
	__TBL16 FwdOutAvgVolt_WCDMALTE_21;
	__TBL16 RvsOutVolt_WCDMALTE_21; 
	__TBL16 PSUDCVolt; 
 } __DETVOLT;

 typedef struct {
	INT8S FwdOutPwr_CDMALTE; 
	INT8S RvsOutPwr_CDMALTE; 
	INT8S FwdOutPwr_LTE_A; 
	INT8S RvsOutPwr_LTE_A; 
	INT8S FwdOutPwr_WCDMALTE_21; 
	INT8S RvsOutPwr_WCDMALTE_21; 

	INT8S DTU_FwdOutPwr_CDMALTE; 
	INT8S DTU_RvsOutPwr_CDMALTE; 
	INT8S DTU_FwdOutPwr_LTE_A; 
	INT8S DTU_RvsOutPwr_LTE_A; 
	INT8S DTU_FwdOutPwr_WCDMALTE_21; 
	INT8S DTU_RvsOutPwr_WCDMALTE_21; 
	
	INT8S FwdOutPwrPeak_2G;
	INT8S FwdOutPwrPeak_LTE;
	INT8S FwdOutPwrPeak_LTE_A2;
	INT8S FwdOutPwrPeak_LTE_21;
	INT8S FwdOutPwrPeak_3G;
#if 1
	INT8S FwdInPwr_CDMALTE;
	INT8S RvsInPwr_CDMALTE;
	INT8S FwdInPwr_LTE_A;
	INT8S RvsInPwr_LTE_A;
	INT8S FwdInPwr_WCDMALTE_21; 
	INT8S RvsInPwr_WCDMALTE_21; 
#endif

} __DET;

typedef struct {
	INT8S InPwr_800M[2];
	INT8S InPwr_2100M[2];		 
	INT8S InPwr_1800M[2]; 	 
} __DTUInPwr;

typedef struct {
	INT8S OutPwr_2G[2];
	INT8S OutPwr_LTE[2];			
	INT8S OutPwr_LTE_A2[2];		
	INT8S OutPwr_LTE_A1[2];		
	INT8S OutPwr_3G[2];			
	INT8S OutPwr_WCDMALTE_21[2];	
} __DTUOutPwr;


typedef struct {
	INT8S InPwr_800M;
	INT8S InPwr_2100M;		 
	INT8S InPwr_1800M; 	 
} __DTUInPwrOffset;

typedef struct {
	INT8S OutPwr_2G;
	INT8S OutPwr_LTE;			
	INT8S OutPwr_LTE_A2;		
	INT8S OutPwr_LTE_A1;		
	INT8S OutPwr_3G;			
	INT8S OutPwr_WCDMALTE_21;	
} __DTUOutPwrOffset;


typedef struct {
	INT8U FwdAttn1_2G;	
	INT8U FwdAttn2_2G;	
	INT8S RvsAttn1_2G;	
	INT8U RvsAttn2_2G;	

	INT8U FwdAttn1_LTE; 
	INT8U FwdAttn2_LTE; 

	INT8U RvsAttn1_LTE;	
	INT8U RvsAttn2_LTE;	

	INT8U FwdAttn1_CDMALTE; 
	INT8U RvsAttn1_CDMALTE;	
	INT8U RvsAttn2_CDMALTE;	
	INT8U RvsAttn3_CDMALTE;	

	INT8U FwdAttn1_LTE_A1; 
	INT8U FwdAttn2_LTE_A1; 
	INT8U RvsAttn1_LTE_A1; 
	INT8U RvsAttn2_LTE_A1; 

	INT8U FwdAttn1_LTE_A2; 
	INT8U FwdAttn2_LTE_A2; 
	INT8U RvsAttn1_LTE_A2; 
	INT8U RvsAttn2_LTE_A2; 

	INT8U FwdAttn1_LTE_A; 
//	INT8U FwdAttn2_LTE_A; ///XXXXX

	INT8U RvsAttn1_LTE_A; 
	INT8U RvsAttn2_LTE_A; 
	INT8U RvsAttn3_LTE_A; 

	INT8U FwdAttn1_3G;	
	INT8U FwdAttn2_3G;	
	INT8U RvsAttn1_3G;	
	INT8U RvsAttn2_3G;	


	INT8U FwdAttn1_LTE_21;	
	INT8U FwdAttn2_LTE_21;	
	INT8U RvsAttn1_LTE_21;	
	INT8U RvsAttn2_LTE_21;	

	INT8U FwdAttn1_WCDMALTE_21; 
	INT8U RvsAttn1_WCDMALTE_21; 
	INT8U RvsAttn2_WCDMALTE_21; 
	INT8U RvsAttn3_WCDMALTE_21; 
	
//	INT8U RvsAttn3_2G;	/////////////XXXXX
//	INT8U RvsAttn3_3G;	/////////////XXXXX
//	INT8U RvsAttn3_LTE_A2; /////////////////////XXXXX
} __AttOffset;


typedef union {
	INT8U Data;
	struct {
		INT8U _Tx			:1; 	
		INT8U _Rx			:1;
		INT8U 				:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1;		//7
	};
} __Comm_Debug_Mode;


typedef union {
	INT8U Data;
	struct {
		INT8U OnOff			:1; 	
		INT8U Time			:6;
		INT8U 				:1;		//7
	};
}__BalanceModeOnOff;


typedef struct {
	INT8U LTE_0RB; 
	INT8U LTE_A1_0RB; 
	INT8U LTE_A2_0RB; 
	
	INT8U LTE_1_0RB; 
	INT8U LTE_A1_1_0RB; 
	INT8U LTE_A2_1_0RB; 
	
} __RBSts;



typedef struct {
	// 알람 발생
	union {
		INT8U Data[5];
		struct {

			INT8U 						:5;
			INT8U DCFail				:1;
			INT8U RvsOtherOverInAlarm 	:1; 
			INT8U RvsOverInAlarm 		:1; 	//7

			INT8U _10MPLL_LOCK			:1; 	
			INT8U _ClockIC_LOCK 		:1;
			INT8U _200MPLL_LOCK 		:1;
			INT8U _DTU_Staus			:1; 
			INT8U						:4; 	//7

			INT8U 							:2;
			INT8U LowGainMode2_2100M 	:1;
			INT8U LowGainMode2_1800M 	:1;
			INT8U LowGainMode2_800M		:1;
			INT8U LowGainMode1_2100M	:1;
			INT8U LowGainMode1_1800M	:1; 
			INT8U LowGainMode1_800M		:1; 	//7
			
     		INT8U 						:8;
     		INT8U 						:8;
		};
	} Main;

} __TRIO_AlmStr;


typedef union {
	INT8U Data;
	struct {
		INT8U LTE			:1; 	
		INT8U LTE_A1		:1;
		INT8U LTE_A2		:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1; 
		INT8U LTE_21		:1;
		INT8U 				:1;		//7
	};
} __FemtocellUseOnOff;

typedef struct {
	INT8U SleepMode_OnOff;
	__TBL16 SleepModeOnVolt;
	__TBL16 SleepModeOffVolt; 
}__SleepMode;

////////////////////////////////////////////////////////////////////////////////////
typedef   struct {
	// 알람 발생
	union {
		INT8U Data;
		struct {
				INT8U Sp2					:1;
				INT8U 						:2;

				INT8U TxLowLimitAlarm		:1;
				INT8U TxHiLimitAlarm		:1;
				INT8U RxLowLimitAlarm		:1;
				INT8U RxHiLimitAlarm		:1;
				INT8U Sp1					:1;
		};
	} RxTxAlarm;

	union {
		INT8U Data;
		struct {
			INT8U Sp2					:1;
			INT8U EcIo_6th				:1;
			INT8U EcIo_5th				:1;
			INT8U EcIo_4th				:1;
			INT8U EcIo_3th				:1;
			INT8U EcIo_2nd				:1;
			INT8U EcIo_1st				:1;
			INT8U Sp1					:1;
		};
	} EcIo;
} _RadioAlarm;



typedef struct {	
	INT8U RxMaxVal[2];				// 0x0C03
	INT8U RxMinVal[2];				// 0x0C04
	INT8U TxMaxVal[2];				// 0x0C05
	INT8U TxMinVal[2];				// 0x0C06
	INT8U EcIo;						// 0x0C09
	INT8U AR_Mode[2];				// 0x0C11
	INT8U Radio_ReportTime[2];		// 0x0C12
	INT8U Radio_ReportPeriod[2];	// 0x0C13
	INT8U TestStn[11];				// 0x0C14
}_WaveCtrl;




typedef struct {	
//	INT8U FAAdjVal[2];				// 0x0C0B
	INT8U FAFerVal;					// 0x0C0C
}_WaveNormalStatus;

typedef struct {
	INT8U SMS_TxRetry;				// 0x0C00
	INT8U ActChannel[2];			// 0x0C01
	INT8U OneFAStatus;				// 0x0C02
	INT8U FARxVal[2];				// 0x0C0A
	INT8U PN_Val[12];				// 0x0C0D
	INT8U EcIo_Val[6];				// 0x0C0E
//	INT8U Tx_Val[2];				// 0x0C17

///////////////////////WCDMA
	INT8U TxVal[2];					// 0x0C17
	INT8U WcdmaChannel[3]; 			// 0x0C18

////////////////////////////////
	_WaveNormalStatus		WaveNormalStatus;
	INT8U PresentHour;				// 0x092E
	INT8U PresentMin;				// 0x092E
} _WaveSts;

/////////////////////////////////////////////////////////////////////////////////////////////////////




enum {
	_PATH_800M	= 0x00,
	_PATH_1800M, 
	_PATH_2100M, 

	SvrPATH_MAX,
};

enum SYSPATH_NUM{
	PATH_2G = 0,
	PATH_LTE,
	PATH_LTE_A2,
	PATH_LTE_A1,
	PATH_LTE_21, /////
	PATH_3G,
	PATH_MAX,

};


typedef union {
	INT8U Data;
	struct {
		INT8U DL_Left		:1; 	
		INT8U DL_Right		:1;
		INT8U UL_Left		:1;
		INT8U UL_Right		:1; 
		INT8U 				:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1;		//7
	};
} __DTU_PathOnOff;


typedef union {
	INT8U Data;
	struct {
		INT8U _10MPLL_LOCK	:1; 	
		INT8U _ClockIC_LOCK	:1;
		INT8U _200MPLL_LOCK	:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1;		//7
	};
} __DTU_PLL_STS;


typedef union {
	INT8U Data;
	struct {
		INT8U _5M_10M		:1; 	
		INT8U _15M			:1;
		INT8U 				:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1;		//7
	};
} __BandSel_800M;

typedef union {
	INT8U Data;
	struct {
		INT8U _10M_20M_LW	:1; 	
		INT8U _30M			:1;
		INT8U _20M_10M_WL	:1;
		INT8U _20M_10M_LW	:1; 
		INT8U _10M_20M_WL	:1;
		INT8U 				:1; 
		INT8U 				:1;
		INT8U 				:1;		//7
	};
} __BandSel_2100M;




enum {
	DTU_DLBPower_800M = 0x00,
	DTU_DLAPower_800M_L,
	DTU_DLAPower_800M_R,
	DTU_ULBPower_800M,
	DTU_ULAPower_800M_L,  ///2G
	DTU_ULAPower_800M_R,  ////LTE


	DTU_DLBPower_1800M,
	DTU_DLAPower_1800M_L,
	DTU_DLAPower_1800M_R,
	DTU_ULBPower_1800M,
	DTU_ULAPower_1800M_L, /////LTE_A2
	DTU_ULAPower_1800M_R,

	DTU_DLBPower_2100M,
	DTU_DLAPower_2100M_L,  //13
	DTU_DLAPower_2100M_R,  //14
	DTU_ULBPower_2100M,
	DTU_ULAPower_2100M_L,  //LTE-21
	DTU_ULAPower_2100M_R,

	DTU_Power_MAX,
};


enum {
	DTU_DLISOPower_800M = 0x00,
	DTU_DLISOPower_1800M,
	DTU_DLISOPower_2100M,
	DTU_ULISOPower_800M,
	DTU_ULISOPower_1800M,
	DTU_ULISOPower_2100M,


	DTU_ISO_MAX,
};


enum {
	DTU_DLBFilter_800M = 0x00,
	DTU_DLAFilter_800M,
	DTU_DLBFilter_1800M,
	DTU_DLAFilter_1800M,
	DTU_DLBFilter_2100M,
	DTU_DLAFilter_2100M,

	DTU_ULBFilter_800M,
	DTU_ULAFilter_800M,
	DTU_ULBFilter_1800M,
	DTU_ULAFilter_1800M,
	DTU_ULBFilter_2100M,
	DTU_ULAFilter_2100M,

	DTU_Filter_MAX,
};


typedef union {
	INT8U Data;
	struct {
		INT8U _800M_L		:1; 	
		INT8U _800M_R		:1;
		INT8U _1800M_L		:1; 	
		INT8U _1800M_R		:1;
		INT8U _2100M_L		:1; 	
		INT8U _2100M_R		:1;
		INT8U 				:1;
		INT8U 				:1;		//7
	};
} __AGC_OnOff;





typedef struct {
	// 알람 발생
	union {
		INT8U Data;
		struct {

			INT8U _10MPLL_LOCK			:1;
			INT8U _200MPLL_LOCK			:1;
			INT8U _ClockIC_LOCK			:1;
			INT8U 						:1;
			INT8U 						:1;
			INT8U 						:1;
			INT8U  						:1; 
			INT8U  						:1; 	//7
		};
	} Main;

} __DTU_AlmStr;

typedef union {
	INT8U Data;
	struct {
		INT8U Bit0			:1; 	
		INT8U Bit1			:1;
		INT8U Bit2			:1; 	
		INT8U Bit3			:1;
		INT8U Bit4			:1; 	
		INT8U Bit5			:1;
		INT8U Bit6			:1; 	
		INT8U Bit7			:1;
	};
} __BitStr;

typedef union {
	INT8U Data;
	struct {
		INT8U wea			:1; 	
		INT8U LoadEnable	:1; 	
		INT8U Write			:1; 	
		INT8U 				:5;		//7
	};
}__Coeff_Ctrl;

#define Filter_Max 200
typedef struct {
	INT8U Flag;
	INT8U Filter_Cnt;

	INT8U Path;
	INT8U DLFreg_Sel;
	INT8U DLFreg_Data[4];

	INT8U ULFreg_Sel;
	INT8U ULFreg_Data[4];
	INT8U Filter_Data[Filter_Max];

} __DTUFilterDn;



enum {
	DTU_Filter_800M_L = 0x01,
	DTU_Filter_800M_R,

	DTU_Filter_1800M_L,
	DTU_Filter_1800M_R,

	DTU_Filter_2100M_L,
	DTU_Filter_2100M_R,

	DTU_FilterDN_MAX,
};


typedef union {
	INT8U Data[2];
	struct {
		INT8U Filter_800M_L		:1; 	
		INT8U Filter_800M_R		:1;
		INT8U Filter_1800M_DL	:1; 	
		INT8U Filter_1800M_UL	:1;
		INT8U Filter_2100M_L	:1; 	
		INT8U Filter_2100M_R	:1;
		INT8U 					:1;
		INT8U 					:1;		//7
	}Use;

	struct {
		INT8U Filter_800M_L		:1; 	
		INT8U Filter_800M_R		:1;
		INT8U Filter_1800M_L	:1; 	
		INT8U Filter_1800M_R	:1;
		INT8U Filter_2100M_L	:1; 	
		INT8U Filter_2100M_R	:1;
		INT8U 					:1;
		INT8U 					:1;		//7
	}Sts;	
} __DTUFilterSts;




typedef union {
	INT8U Data;
	struct {
		INT8U Filter_800M		:1; 	
		INT8U Filter_1800M		:1; 	
		INT8U Filter_2100M		:1; 	
		INT8U 					:5;		//7
	};
} __DTUFilterInfor;


typedef struct {
	INT8U Filter_USE;
	INT8U Filter_Infor;
	INT8U Filter_Sts;
} __FilterSts;


/*

'0x01 : 800MHz_L
0x02 : 800MHz_R
0x03 : 1800MHz_DL
0x04 : 1800MHz_UL
0x05 : 2100MHz_L
0x06 : 2100MHz_R

*/

typedef struct {	
	__DnrAlarmDataStr Flag;				// 0x0001
	__DnrAlarmDataStr AlmSts;			// 0x0001

	INT8U Manufacture;					// 0x0100
	INT8U Supplier;						// 0x0101
	INT8U RepeaterType[2];				// 0x0102
	INT8U SWVer;						// 0x0103
	INT8U MobileManufacture;			// 0x0104
	INT8U MobileModel;					// 0x0105
	INT8U MobileVer[2];					// 0x0106
	INT8U ICCIDChecksum[2];				// 0x0116
	INT8U FPGAVer[2];					// 0x011F

	INT8S FwdInPwr_3G;					// 0x0500
	INT8S FwdOutPwr_3G[2];				// 0x0503
	INT8S rFwdOutPwr_3G[2];				// 0x0503
	INT8S FwdOutPwrPeak_3G[2];			// 0x0503
	INT8S rFwdOutPwrPeak_3G[2];			// 0x0503
	INT8S FwdOutUpperLmt_3G[2]; 		// 0x0504 (Range: 13 ~ 21dBm)
	INT8S FwdOutLowerLmt_3G[2]; 		// 0x0505
	INT8U FwdGainSet_3G;				// 0x0529  Forward Gain(설정값)  43~83dB
	INT8U FwdGain_3G;					// 0x052a  Forward Gain(현재값)

	INT8S FwdInPwr_2G;					// 0x0510
	INT8S FwdOutPwr_2G[2];				// 0x0514
	INT8S rFwdOutPwr_2G[2];				// 0x0514

	INT8S FwdOutPwrPeak_2G[2];			// 0x0514
	INT8S rFwdOutPwrPeak_2G[2];			// 0x0514

	INT8S FwdOutUpperLmt_2G[2]; 		// 0x0515   (Range: 1 ~ 9dBm)
	INT8S FwdOutLowerLmt_2G[2]; 		// 0x0516
	INT8U FwdGainSet_2G;				// 0x0542  Forward Gain(설정값)  23~73dB
	INT8U FwdGain_2G;					// 0x0543  Forward Gain(현재값)

	INT8S FwdInPwr_LTE;					// 0x0552
	INT8S FwdOutPwr_LTE[2];				// 0x0556
	INT8S rFwdOutPwr_LTE[2];				// 0x0556

	INT8S FwdOutPwrPeak_LTE[2];			// 0x0556
	INT8S rFwdOutPwrPeak_LTE[2];			// 0x0556

	INT8S FwdOutUpperLmt_LTE[2]; 		// 0x0557 (Range: 2 ~ 12dBm)
	INT8S FwdOutLowerLmt_LTE[2]; 		// 0x0558
	INT8U FwdGainSet_LTE;				// 0x0569  Forward Gain(설정값)
	INT8U FwdGain_LTE;					// 0x056A  Forward Gain(현재값)  23~73dB

	INT8S FwdInPwr_LTE_21;				// 0x2228
	INT8S FwdOutPwr_LTE_21[2];			// 0x2260
	INT8S rFwdOutPwr_LTE_21[2];			// 0x2260
	INT8S FwdOutPwrPeak_LTE_21[2];		// 0x2260
	INT8S rFwdOutPwrPeak_LTE_21[2];		// 0x2260
	INT8S FwdOutUpperLmt_LTE_21[2]; 	// 0x2266  (Range: 7 ~ 17dBm)
	INT8S FwdOutLowerLmt_LTE_21[2]; 	// 0x2267
	INT8U FwdGainSet_LTE_21;			// 0x2269  Forward Gain(설정값) 38~83dB
	INT8U FwdGain_LTE_21;				// 0x226A  Forward Gain(현재값)

	INT8S FwdInPwr_LTE_A2;				// 0x1B14
	INT8S FwdOutPwr_LTE_A2[2];			// 0x1B15
	INT8S rFwdOutPwr_LTE_A2[2];			// 0x1B15

	INT8S FwdOutPwrPeak_LTE_A2[2];		// 0x1B15
	INT8S rFwdOutPwrPeak_LTE_A2[2];		// 0x1B15
	
	INT8S FwdOutUpperLmt_LTE_A2[2]; 	// 0x1B16  (Range: 7 ~ 17dBm)
	INT8S FwdOutLowerLmt_LTE_A2[2]; 	// 0x1B17
	INT8U FwdGainSet_LTE_A2;			// 0x1B1A  Forward Gain(설정값) 38~83dB
	INT8U FwdGain_LTE_A2;				// 0x1B1B  Forward Gain(현재값)

//////////////////////
	INT8U Rvs0GainSet_3G;				// 0x0604	Reverse Gain(설정값)
	INT8U RvsGainSts_3G;				// 0x062E	Reverse Gain(현재값)

	INT8U Rvs0GainSet_2G;				// 0x060F	Reverse Gain(설정값)
	INT8U RvsGainSts_2G;				// 0x0640	Reverse Gain(현재값)

	INT8U Rvs0GainSet_LTE;				// 0x0674	Reverse Gain(설정값)
	INT8U RvsGainSts_LTE;				// 0x0677	Reverse Gain(현재값)

	INT8U RvsGainBalance_CDMALTE;		// 0x1C2E	Reverse Gain Balance
	INT8U RvsGainBalance_LTE_A;			// 0x1C2F	Reverse Gain Balance
	INT8U RvsGainBalance_WCDMALTE_21;	// 0x281D	Reverse Gain Balance

	INT8U Rvs0GainSet_LTE_A2;			// 0x1C0B	Reverse Gain(설정값)
	INT8U RvsGainSts_LTE_A2;			// 0x1C0D	Reverse Gain(현재값)

	INT8U RvsGainSet_LTE_21;			// 0x2828	Reverse Gain(설정값)
	INT8U RvsGainSts_LTE_21;			// 0x2818	Reverse Gain(현재값)

///////////////////////////
	INT8U AmpOffCase_3G;				// 0x070f
	INT8U AmpOffCase_2G;				// 0x0718
	INT8U AmpOffCase_LTE;				// 0x0754
	INT8U AmpOffCase_LTE_A2;			// 0x075B
	INT8U AmpOffCase_LTE_21;			// 0x1F35

	INT8U FwdAmpOnOff_3G;				// 0x0706
	INT8U FwdAmpOnOff_2G;				// 0x0715
	INT8U FwdAmpOnOff_LTE;				// 0x074F
	INT8U FwdAmpOnOff_LTE_A2;			// 0x0759
	INT8U FwdAmpOnOff_LTE_21;			// 0x1F36

	INT8U AGCOnOff_CDMALTE;				// 0x1068
	INT8U AGCOnOff_LTE_A_0;				// 0x1069
	INT8U AGCOnOff_WCDMALTE_21;			// 0x2338

	INT8U AGCMode_3G;					// 0x105B
	INT8U AGCMode_2G;					// 0x105C
	INT8U AGCMode_LTE;					// 0x105D
	INT8U AGCMode_LTE_A2;				// 0x1067
	INT8U AGCMode_LTE_21;				// 0x2337

	INT8U Band_Select_CDMALTE[3];		// 0x2339
	INT8U Band_Select_LTE_A[3];			// 0x233A
	INT8U Band_Select_WCDMALTE_21[3];	// 0x233B

	INT8U ISOPriod;						// 0x2330
	INT8U ISOValue_WCDMALTE_21;			// 0x233C
	INT8U ISOValue_CDMALTE;				// 0x233D
	INT8U ISOValue_LTE_A;				// 0x233E
#if 0
	INT8U ISOGain_WCDMALTE_21;			//
	INT8U ISOGain_CDMALTE;				//
	INT8U ISOGain_LTE_A;				//
#endif

	INT8U ISOValueLevel_WCDMALTE_21;	// 0x233F
	INT8U ISOValueLevel_CDMALTE;		// 0x2340
	INT8U ISOValueLevel_LTE_A;			// 0x2341

	INT8U ISOAlarm_WCDMALTE_21;			// 0x2337
	INT8U ISOAlarm_CDMALTE;				// 0x2338
	INT8U ISOAlarm_LTE_A;				// 0x2339

	INT8U ULGainPriod;					// 0x2829
	INT8U ULGainMode;					// 0x282A

	INT8U RepeatResetPriod;				// 0x102A
	INT8U HostNumber[11];				// 0x0920
	
	INT8U AutoReportPriod;				// 0x0922
	INT8U AutoReportBasePer[2];			// 0x0923
	INT8U ReportHours[2];				// 0x092E

	__FemtocellUseOnOff FemtocellUseOnOff; // 0x1062

	INT8U RvsOverInAlarmCount;			// 0x106B
	INT8U RvsOtherOverInAlarmCount;		// 0x106C

	INT8U LTE_21Use;					// 0x1E10

	////////////////////////////////////////////////////Internel A_ID

	INT8U TPTL_OnOff;					// 0xA000
	INT8S TempOffset;					// 0xA001
	INT8U RCUAddVer;					// 0xA006
	INT8U AlarmMask;					// 0xA00D
	__Led_Alarm LedAlarm;				// 0xA00E

	
	INT8U MinNumber[11];				// 0xA00F
	INT8U EsnNumber[19];				// 0xA010
	INT8U ModemOnOff;					// 0xA011
	__TRIO_AlmStr ModuleAlarm;			// 0xA012
	INT8S CurrentTemp;					// 0xA013
	INT8U TableStatus;					// 0xA014
	INT8U InitialSet;					// 0xA01F
	INT8U DefaultSet;					// 0xA021
	INT8U LockOrderSts;					// 0xA02A   ///

	////////////기존 0x00 : 정상 0x01 : Lock Order
	///////////0x00 : Lock Order 0x01 : 정상
	
	INT8U VccDet_Lmt[2];				// 0xA02B
	INT8U GUI_ID[11];					// 0xA086
	INT8U GUI_Password[11];				// 0xA087

	INT8S FwdInPwrOffset_2G;			// 0xA101
	INT8S FwdInPwrOffset_3G;			// 0xA102
	INT8S Rvs0OutPwrOffset_2G;			// 0xA109
	INT8S Rvs0OutPwrOffset_3G;			// 0xA10B
	INT8S FwdOutPwrOffset_2G;			// 0xA158
	INT8S FwdOutPwrOffset_3G;			// 0xA159

	INT8S FwdAttn1_2G;					// 0xA15E  AGC 0~25dB
	INT8S FwdAttn2_2G;					// 0xA15f  toggle 25~0dB

	INT8S FwdAttn1_3G;					// 0xA162  AGC 26~40dB
	INT8S FwdAttn2_3G;					// 0xA163  AGC 0~25dB

	INT8S RvsAttn1_2G;					// 0xA166  ALC 0~25dB
	INT8U RvsAttn2_2G;					// 0xA167  AGC 31 ~ 40dB G/B 0~10dB toggle 10~0dB
	INT8U RvsAttn3_2G;					// 0xA168  AGC 0~30dB  xxxxxxxxxxxxxxx

	INT8U RvsAttn1_3G;					// 0xA16A  ALC 26~ 45dB
	INT8U RvsAttn2_3G;					// 0xA16B  ALC 0~25dB
	INT8U ResetPeriodCountSts[3];		// 0xA1BD
	INT8U ResetPeriodCountSet[3];		// 0xA1BE
	INT8S FwdInPwrOffset_LTE;			// 0xA1C3
	INT8S FwdOutPwrOffset_LTE;			// 0xA1C4
	INT8S RvsOutPwrOffset_LTE;			// 0xA1CD
	
	INT8S RvsOutPwr_3G[2]; 				// 0xA34A
	INT8S RvsOutPwr_2G[2];				// 0xA34B
	INT8U ShutDownOnOff_3G;				// 0xA34C
	INT8U ShutDownOnOff_2G;				// 0xA34D
	INT8S RvsOutUpperLmt_3G[2]; 		// 0xA367
	INT8S RvsOutUpperLmt_2G[2]; 		// 0xA369
	
	INT8S FwdGainOffset_3G;				// 0xA36A
	INT8S RvsGainOffset_3G;				// 0xA36B
	INT8S FwdGainOffset_2G;				// 0xA36C
	INT8S RvsGainOffset_2G;				// 0xA36D

	INT8S FwdOutHighLmt_3G[2];			// 0xA373
	INT8S FwdOutHighLmt_2G[2];			// 0xA374
	INT8U DebugOnOff;					// 0xA391
	INT8U RadioMeasureOnOff;			// 0xA392

	INT8U SD_Status_2G;					// 0xA605		// S
	INT8U SD_Status_3G;					// 0xA606		// S

	__DETVOLT DetVolt;					// 0xA800
	__DET DetPwr;						// 0xA801
	__DET DetOffset;					// 0xA802

	__AttOffset AttValue;				// 0xA803
	__AttOffset AttOffset;				// 0xA804

 	INT8S FwdAttn1_CDMALTE;				// 0xA808   AGC 26 ~ 40dB     ALC 0~10dB
	INT8S RvsAttn1_CDMALTE;				// 0xA80B   ALC 26~ 35dB
	INT8S RvsAttn2_CDMALTE;				// 0xA80C   
	INT8S RvsAttn3_CDMALTE;				// 0xA80D   

	INT8S FwdAttn1_LTE;					// 0xA810	AGC 0 ~ 25dB     ALC 0~10dB
	INT8S FwdAttn2_LTE;					// 0xA811	toggle 25~0dB

 	INT8S FwdAttn1_LTE_A1; 				// 0xA814   AGC 26~45dB
	INT8S FwdAttn2_LTE_A1; 				// 0xA815	AGC 0~25dB

 	INT8S RvsAttn1_LTE;					// 0xA818   ALC 26~ 35dB    
	INT8U RvsAttn2_LTE;					// 0xA819   ALC 0~25dB    
	INT8U RvsAttn3_LTE;					// 0xA81A   AGC 31~40dB   G/B 0~10 dB   

 	INT8U RvsAttn1_LTE_A1; 				// 0xA81D   ALC 26~ 45dB   
	INT8U RvsAttn2_LTE_A1; 				// 0xA81E   ALC 0~25dB    
	INT8S RvsAttn3_LTE_A1; 				// 0xA81F	AGC 31~45dB	 G/B 0~10dB

 	INT8S FwdGainOffset_LTE; 			// 0xA822
	INT8S RvsGainOffset_LTE; 			// 0xA823
	INT8S FwdGainOffset_LTE_A1; 		// 0xA824
	INT8S RvsGainOffset_LTE_A1; 		// 0xA825
 	INT8S FwdAgcAttn_2G; 				// 0xA826
	INT8S FwdAgcAttn_LTE; 				// 0xA827
	INT8S FwdAgcAttn_LTE_A1; 			// 0xA828
	INT8S FwdAgcAttn_3G; 				// 0xA829
 	INT8S RvsAlcAttn_2G;				// 0xA82A
	INT8S RvsAlcAttn_LTE;				// 0xA82B
	INT8S RvsAlcAttn_LTE_A1; 			// 0xA82C
	INT8S RvsAlcAttn_3G;				// 0xA82D
 	INT8U RvsAlcOnOff_2G;				// 0xA82E
	INT8U RvsAlcOnOff_LTE;				// 0xA82F
	
	INT8U RvsAlcOnOff_LTE_A1; 			// 0xA830
	INT8U RvsAlcOnOff_3G;				// 0xA831

	
 	INT8S RvsOutPwr_LTE[2]; 			// 0xA844
	INT8S RvsOutPwr_LTE_A1[2]; 			// 0xA845
 	INT8S RvsInPwr_2G[2]; 				// 0xA846
	INT8S RvsInPwr_LTE[2]; 				// 0xA847
	INT8S RvsInPwr_LTE_A1[2]; 			// 0xA848
	INT8S RvsInPwr_3G[2]; 				// 0xA849
	INT8U ShutDownOnOff_LTE; 			// 0xA84A
 	INT8S RvsOutUpperLmt_LTE[2]; 		// 0xA84C

	INT8S FwdOutHighLmt_LTE[2];			// 0xA852
	INT8S OverInAlarmLmt_2G;			// 0xA854
	INT8S OverInAlarmLmt_LTE;			// 0xA855
	INT8S OverInAlarmLmt_3G;			// 0xA857

 	INT8S RvsALCLvl_2G;					// 0xA85D
 	INT8S RvsALCLvl_3G;					// 0xA85E
	INT8S RvsALCLvl_LTE;				// 0xA85F
	INT8S RvsALCLvl_LTE_A1; 			// 0xA860
	INT8U ShunDownTime;					// 0xA862
	
	INT8U SD_Status_LTE;				// 0xA86B		// S

	INT8S FwdInPwrOffset_LTE_A2;		// 0xA870
	INT8S RvsOutPwrOffset_LTE_A2;		// 0xA871
	INT8S FwdOutPwrOffset_LTE_A2;		// 0xA872
	INT8S FwdAttn1_LTE_A2;				// 0xA873	AGC 26~45dB
	INT8S FwdAttn2_LTE_A2;				// 0xA874	AGC 0~25dB

	INT8U RvsAttn1_LTE_A2;				// 0xA877	ALC 26~ 45dB   
	INT8U RvsAttn2_LTE_A2;				// 0xA878	ALC 0~25dB	  

	INT8U FwdGainOffset_LTE_A2; 		// 0xA87C
	INT8S RvsGainOffset_LTE_A2; 		// 0xA87D
	INT8S FwdAgcAttn_LTE_A2;			// 0xA87E
	INT8S RvsAlcAttn_LTE_A2;			// 0xA87F
	
	INT8U RvsAlcOnOff_LTE_A2;			// 0xA880
	INT8S RvsOutPwr_LTE_A2[2];			// 0xA88A
	INT8S RvsInPwr_LTE_A2[2];			// 0xA88B
	INT8U ShutDownOnOff_LTE_A2; 		// 0xA88C
	
	INT8S RvsOutUpperLmt_LTE_A2[2]; 	// 0xA88D
	INT8S FwdOutHighLmt_LTE_A2[2];		// 0xA890
	INT8S OverInAlarmLmt_LTE_A2;		// 0xA891
	INT8S RvsALCLvl_LTE_A2; 			// 0xA893
	INT8U SD_Status_LTE_A2; 			// 0xA895		// S
	
	INT8S FwdAttn1_LTE_A;				// 0xA896	AGC 26~45dB
	INT8S RvsAttn1_LTE_A;				// 0xA899	ALC 26~ 45dB   
	INT8S RvsAttn2_LTE_A;				// 0xA89A	ALC 26~ 45dB   
	INT8S RvsAttn3_LTE_A;				// 0xA89B	ALC 26~ 45dB   

	INT8S PllFregOffset_LTE;			// 0xA8AD	

	INT8S FwdTemp_CDMALTE;				// 0xA8B0
	INT8S RvsTemp_CDMALTE;				// 0xA8B1
	INT8S FwdTemp_LTE_A;				// 0xA8B2
	INT8S RvsTemp_LTE_A;				// 0xA8B3

	INT8U FwdAmpOnOff_LTEA; 			// 0xA8BA
	INT8U RvsAmpOnOff_LTEA; 			// 0xA8BB

/////////////////////////////////////////////////////////////////////////////
	INT8U DTU_STATUS;
	__DTU_PLL_STS DTU_PLL_STS;
	__BandSel_800M BandSel_800M;
	INT8U BandSel_1800M;
	__BandSel_2100M BandSel_2100M;

	__DTU_PathOnOff PathOnOff_800M;			// 0xA8E9
	__DTU_PathOnOff PathOnOff_1800M;   		// 0xA8EA
	__DTU_PathOnOff PathOnOff_2100M;		// 0xA8EB

	type16 DTUPeakPower[DTU_Power_MAX]; 	// 0xA8D5
	type16 DTUAverPower[DTU_Power_MAX]; 	// 0xA8D6
	type16 DTUPeakOffset[DTU_Power_MAX]; 	// 0xA8D7
	type16 DTUAverOffset[DTU_Power_MAX]; 	// 0xA8D8
	INT8U DLAGCAttn[SvrPATH_MAX][2];		// 0xA8D9
	INT8U ULAGCAttn[SvrPATH_MAX][2];		// 0xA8DA
	INT8U DLALCAttn[SvrPATH_MAX][2];		// 0xA8DB
	INT8U ULALCAttn[SvrPATH_MAX][2];		// 0xA8DC
	__AGC_OnOff SmartAGCDLOnOff;			// 0xA8DD
	__AGC_OnOff SmartAGCULOnOff;			// 0xA8DE
	INT8S DTU_DLAGCLevel[SvrPATH_MAX][2];	// 0xA8DF
	INT8S DTU_ULAGCLevel[SvrPATH_MAX][2];	// 0xA8E0

	type16 ISO[DTU_ISO_MAX];				// 0xA8E1
	type16 ISOOffset[DTU_ISO_MAX];			// 0xA8E2
	INT16U ISOLmt[DTU_ISO_MAX];				// 0xA8E3

	INT8U  ISOOnOff;						// 0xA8E4
	INT8U  ISOSelect;						// 0xA8E4
	INT8U  ISOMode;							// 0xA8E4
	INT8U  ISOStartCnt;						// 0xA8E4
	INT8U  ISOSampleAvg;					// 0xA8E4

	INT8U VendorID;
	INT8U UnitID;
	INT8U DtuSts_Alarm;


	INT8S ULGainOutLmt[3];
	INT8S PLLOffset[SvrPATH_MAX];
	
/////////////////////////////////////////////////////////////////////////////
	INT8U SamplePathSel[2];					// 0xA8E5
	INT16U SampleAddr;						// 0xA8E6
	INT32U SampleData;						// 0xA8E7
	INT8U SampleDataOffset[2];				// 0xA8E8

	type32 SampleOffsetA;					// 0xA8E8
	type16 SampleOffsetB;					// 0xA8E8
////////////////////////////////////////xxxxxxxxxxxxx
	INT8S FwdInPwrOffset_LTE_21;		// 0xAF00
	INT8S RvsOutPwrOffset_LTE_21;		// 0xAF01
	INT8S FwdOutPwrOffset_LTE_21;		// 0xAF02
	INT8S FwdAttn1_LTE_21;				// 0xAF03	
	INT8S FwdAttn2_LTE_21;				// 0xAF22    ///// 추가 고려 	

	INT8S RvsAttn1_LTE_21;				// 0xAF04	
	INT8S RvsAttn2_LTE_21;				// 0xAF05	
	INT8S RvsAttn3_LTE_21;				// 0xAF06
	INT8S FwdGainOffset_LTE_21; 		// 0xAF07
	INT8S RvsGainOffset_LTE_21; 		// 0xAF08
	INT8S FwdAgcAttn_LTE_21; 			// 0xAF09
	INT8S RvsAlcAttn_LTE_21; 			// 0xAF0A
	INT8U RvsAlcOnOff_LTE_21; 			// 0xAF0B

	INT8S RvsOutPwr_LTE_21[2];			// 0xAF10
	INT8S RvsInPwr_LTE_21[2];			// 0xAF11
	INT8U ShutDownOnOff_LTE_21; 		// 0xAF12
	INT8S RvsOutUpperLmt_LTE_21[2]; 	// 0xAF13


	INT8S FwdOutHighLmt_LTE_21[2];		// 0xAF16
	INT8S OverInAlarmLmt_LTE_21;		// 0xAF17
	INT8S RvsALCLvl_LTE_21; 			// 0xAF19
	INT8U SD_Status_LTE_21;				// 0xA81A		


	INT8S FwdAttn1_WCDMALTE_21;			// 0xAF1B	
	INT8S RvsAttn1_WCDMALTE_21;			// 0xAF1C	
	INT8S RvsAttn2_WCDMALTE_21;			// 0xAF1D	
	INT8S RvsAttn3_WCDMALTE_21;			// 0xAF1E
	INT8S FwdTemp_WCDMALTE_21;			// 0xAF20
	INT8S RvsTemp_WCDMALTE_21;			// 0xAF21


	INT8S InitRvsGainOffset_2G; 
	INT8S InitRvsGainOffset_LTE; 
	INT8S InitRvsGainOffset_LTE_A1; 
	INT8S InitRvsGainOffset_LTE_A2; 
	INT8S InitRvsGainOffset_3G; 
	INT8S InitRvsGainOffset_LTE_21; 


//////////////////////////////////////////////////////////////////////////////Wave
	INT8U TestStn[11];					// 0x0C14

	_WaveSts 	WaveSts;
	_WaveCtrl 	WaveCtrl;

	_RadioAlarm 	RFAlarm;			// 0xE503  // 전파알람 비트.
	INT8U System_Time[6];				// 0xE504
	INT8U Backup_Time[6];				// 0xE505
	INT8U Last_AutoReport[6];			// 0xE506	// 마지막 최근의 자동보고(중계기 혹은 전파(or idle))시간

	INT16U Auto_Remain_Time;			// 0xE507
	INT16U AR2_Remain_Time;				// 0xE508
	INT16U AR3_Remain_Time;				// 0xE509

	INT8S ResetCase;					// 0x0914
	
	INT8U Text_Debug_Mode;
	__Comm_Debug_Mode Comm_Debug_Mode;
	INT8U TestMode; 					// 0xD001

	INT8U Comm_Debug_Port;
	INT8U ModeValue;

	INT8U OverInputAGCOnOff;			// 0xD018
	INT8U DCOffSet[2];					// 0xD01C

	INT8U TestHostNumber[11];			// 0xD02A

	INT8S RvsInPwrOffset[PATH_MAX];		// 0xD02C
	type16 DLISOOffset[PATH_MAX]; 		// 0xD02E
	type16 ULISOOffset[PATH_MAX]; 		// 0xD02F


	__Coeff_Ctrl Coeff_Ctrl;

#if 1
	INT8U CurrFwdAttn2_2G;		
	INT8U CurrRvsAttn2_2G;		
	INT8U CurrFwdAttn2_LTE;		
	INT8U CurrRvsAttn2_LTE;

 	INT8U CurrFwdAttn1_CDMALTE;
	INT8U CurrRvsAttn1_CDMALTE;
	INT8U CurrRvsAttn2_CDMALTE;
	INT8U CurrRvsAttn3_CDMALTE;

	INT8U CurrFwdAttn2_LTE_A1; 	
	INT8U CurrRvsAttn2_LTE_A1;

	INT8U CurrFwdAttn2_LTE_A2; 	
	INT8U CurrRvsAttn2_LTE_A2;
	
 	INT8U CurrFwdAttn1_LTE_A;
	INT8U CurrRvsAttn1_LTE_A;
	INT8U CurrRvsAttn2_LTE_A;
	INT8U CurrRvsAttn3_LTE_A;

	INT8U CurrFwdAttn2_3G;
	INT8U CurrRvsAttn2_3G;

	INT8U CurrFwdAttn2_LTE_21; 
	INT8U CurrRvsAttn2_LTE_21; 
	INT8U CurrRvsAttn3_LTE_21; 

	INT8U CurrFwdAttn1_WCDMALTE_21; 
	INT8U CurrRvsAttn1_WCDMALTE_21; 
	INT8U CurrRvsAttn2_WCDMALTE_21; 
	INT8U CurrRvsAttn3_WCDMALTE_21; 
#endif

	INT8S RvsGainAttn_2G;
	INT8S RvsGainAttn_LTE;
	INT8S RvsGainAttn_LTE_A1;
	INT8S RvsGainAttn_LTE_A2;
	INT8S RvsGainAttn_3G;
	INT8S RvsGainAttn_LTE_21;

	INT8S FwdInAlcAttn_CDMALTE;
	INT8S FwdInAlcAttn_LTE_A;
	INT8S FwdInAlcAttn_WCDMALTE_21;

	INT8S RvsInAlcAttn_CDMALTE;
	INT8S RvsInAlcAttn_LTE_A;
	INT8S RvsInAlcAttn_WCDMALTE_21;


	INT8S CurrRvsAlcAttn_2G;
	INT8S CurrRvsAlcAttn_LTE;
	INT8S CurrRvsAlcAttn_LTE_A;
	INT8S CurrRvsAlcAttn_3G;
	INT8S CurrRvsAlcAttn_LTE_21;



	INT8U BandFilterInfo;
	INT8U FilterStart;
	__DTUFilterSts DTUFilterSts;

	INT8U FilterUSE[DTU_FilterDN_MAX-1];


	INT8U FPGAAddVer;
	__DTUFilterInfor FPGAAdd;		


	INT8U FTPOnOff;
	INT8U FTPIndex;
	type16 FTPFileStep;

	type32 FTPFileSize;

	type16 FTPFrameCnt;
	type16 FTPTotFrame;
	INT8U FTPMode;

	INT8U IP_Address[4];


	INT8U Download_Status;

	INT8S FwdOutPwrTemp_CDMA;	
	INT8S RvsOutPwrTemp_CDMA;	
	INT8S FwdOutPwrTemp_LTE;
	INT8S RvsOutPwrTemp_LTE;
	INT8S FwdOutPwrTemp_WCDMA;
	INT8S RvsOutPwrTemp_WCDMA;
	INT8S FwdOutPwrTemp_LTE_21;
	INT8S RvsOutPwrTemp_LTE_21;
	INT8S FwdOutPwrTemp_LTE_A2;
	INT8S RvsOutPwrTemp_LTE_A2;


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

#if 0
0x00 : Download 진행 중
0x01 : Download 완료
0x02 : Update 대기 중
0x03 : Update 진행 중
0x04 : Update 완료
#endif

//Download Status

} __Dnr_Sts;

typedef struct {
	char cServerIP[16];
	INT32U iServerPort;
	int iServerUse;
	int iConnectID;
	BOOL m_bTcpConnect;
	BOOL m_bTcpConnecting;
}TCPINFO;


typedef struct
{
	INT8U AID[2];
	INT8U len;
	INT8U data[64];
} AIDSTR;


#pragma pack()
////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

