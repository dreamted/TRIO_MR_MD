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
		INT8U FwdOutLowerLmtFail_2G		:1;
		INT8U FwdOutUpperLmtFail_2G		:1;
		INT8U FwdInUpperLmtFail_2G		:1;
		INT8U OverInAlarm_3G			:1; 	/// 타사   FwdOtherOverInAlarm
		INT8U FwdOutLowerLmtFail_3G 	:1;
		INT8U FwdOutUpperLmtFail_3G 	:1;
		INT8U FwdInUpperLmtFail_3G		:1;
		INT8U							:1; 	//7


		INT8U FwdOutLowerLmtFail_LTE_A1	:1;
		INT8U FwdOutUpperLmtFail_LTE_A1	:1;
		INT8U FwdInUpperLmtFail_LTE_A1	:1;
		INT8U OverInAlarm_CDMALTE		:1;    /// 타사 
		INT8U FwdOutLowerLmtFail_LTE	:1;
		INT8U FwdOutUpperLmtFail_LTE	:1;
		INT8U FwdInUpperLmtFail_LTE 	:1;
		INT8U							:1; 	//7

		INT8U Fwd1OutLowerLmtFail_LTE	:1;
		INT8U Fwd1OutUpperLmtFail_LTE	:1;
		INT8U Fwd1InUpperLmtFail_LTE	:1;
		INT8U FwdOutLowerLmtFail_LTE_A2	:1;
		INT8U FwdOutUpperLmtFail_LTE_A2	:1;
		INT8U FwdInUpperLmtFail_LTE_A2	:1;
		INT8U OverInAlarm_LTE_A			:1;    /// 타사 
		INT8U							:1; 	

		INT8U							:1; 	
		INT8U Fwd1OutLowerLmtFail_LTE_A2 :1;
		INT8U Fwd1OutUpperLmtFail_LTE_A2 :1;
		INT8U Fwd1InUpperLmtFail_LTE_A2  :1;
		INT8U Fwd1OutLowerLmtFail_LTE_A1 :1;
		INT8U Fwd1OutUpperLmtFail_LTE_A1 :1;
		INT8U Fwd1InUpperLmtFail_LTE_A1  :1;
		INT8U							 :1; 	

		INT8U LocalFail_LTE_A2_1		:1; 	
		INT8U LocalFail_LTE_A1_1		:1; 	
		INT8U LocalFail_LTE_1			:1; 	
		INT8U LocalFail_LTE_A2 			:1;
		INT8U LocalFail_LTE_A1 			:1;
		INT8U LocalFail_CDMALTE			:1;
		INT8U LocalFail_3G 				:1;
		INT8U							:1; 	//7

		INT8U Rvs1OutUpperLmtFail_LTE_A1 :1;	
		INT8U Rvs1OutUpperLmtFail_LTE	:1; 	
		INT8U RvsOutUpperLmtFail_LTE_A2 :1;
		INT8U RvsOutUpperLmtFail_LTE_A1 :1;
		INT8U RvsOutUpperLmtFail_LTE	:1;
		INT8U RvsOutUpperLmtFail_2G 	:1;
		INT8U RvsOutUpperLmtFail_3G 	:1;
		INT8U							:1; 	//7

		INT8U FwdAmp1OnOff_LTE_A1		:1; 	
		INT8U FwdAmp1OnOff_LTE 			:1; 	
		INT8U FwdAmpOnOff_LTE_A2		:1;
		INT8U FwdAmpOnOff_LTE_A1		:1;
		INT8U FwdAmpOnOff_LTE			:1;
		INT8U FwdAmpOnOff_2G			:1;
		INT8U FwdAmpOnOff_3G			:1;
		INT8U							:1; 	//7

		INT8U							:4 	;
		INT8U FwdAmp1OnOff_LTE_A2		:1; 	
		INT8U Rvs1OutUpperLmtFail_LTE_A2 :1;	
		INT8U ACFail					:1;
		INT8U							:1; 	//7

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
	} _LED_LTE_A1;	

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
	} _LED_LTE1;

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
	} _LED_LTE_A1_1;

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
	} _LED_LTE_A2_1;	
}__Led_Alarm;


typedef struct {
	__TBL16 FwdOutAvgVolt_2G;
	__TBL16 FwdOutPeakVolt_2G; 
	__TBL16 RvsOutVolt_2G; 
	
	__TBL16 FwdOutAvgVolt_LTE; 
	__TBL16 FwdOutPeakVolt_LTE; 
	__TBL16 RvsInVolt_LTE; 
	__TBL16 RvsOutVolt_LTE; 
	
	__TBL16 FwdInVolt_CDMALTE;
	__TBL16 FwdOutAvgVolt_CDMALTE; 
	__TBL16 FwdOutPeakVolt_CDMALTE; 
	__TBL16 RvsInVolt_CDMALTE;
	__TBL16 RvsOutVolt_CDMALTE; 
	
	__TBL16 FwdOutAvgVolt_LTE_A1; 
	__TBL16 FwdOutPeakVolt_LTE_A1; 
	__TBL16 RvsOutVolt_LTE_A1; 
	
	__TBL16 FwdOutAvgVolt_LTE_A2; 
	__TBL16 FwdOutPeakVolt_LTE_A2; 
	__TBL16 RvsOutVolt_LTE_A2; 
	
	__TBL16 FwdInVolt_LTE_A;
	__TBL16 FwdOutAvgVolt_LTE_A; 
	__TBL16 FwdOutPeakVolt_LTE_A; 
	__TBL16 RvsInVolt_LTE_A;   //////xxxxxx
	__TBL16 RvsOutVolt_LTE_A; 
	__TBL16 Rvs1InVolt_LTE_A;
	
	__TBL16 FwdInVolt_3G; 
	__TBL16 FwdOutAvgVolt_3G; 
	__TBL16 FwdOutPeakVolt_3G; 
	__TBL16 RvsInVolt_3G;       ////xxxxx
	__TBL16 RvsOutVolt_3G; /////32

	__TBL16 FwdRmtOutVolt_CDMALTE; 
	__TBL16 FwdRmtOutVolt_WCDMA; 
	__TBL16 FwdRmtOutVolt_LTE_A; 
	
	__TBL16 PSUDCVolt; 
	
	__TBL16 RvsInVolt_2G; 
	__TBL16 RvsInVolt_LTE_A1; 	
	__TBL16 RvsInVolt_LTE_A2; 		
//	__TBL16 PAU27VVolt; 
//	__TBL16 PAUOut27VVolt; 
//	__TBL16 DCOutVolt; ////
} __DETVOLT;


typedef struct {
	__TBL16 Fwd1InVolt_LTE; 
	__TBL16 Fwd1OutAvgVolt_LTE; 
	__TBL16 Fwd1OutPeakVolt_LTE; 
	__TBL16 Rvs1InVolt_LTE; 
	__TBL16 Rvs1OutVolt_LTE; 
	
	__TBL16 Fwd1OutAvgVolt_LTE_A1; 
	__TBL16 Fwd1OutPeakVolt_LTE_A1; 
	__TBL16 Rvs1OutVolt_LTE_A1; 	


	__TBL16 Fwd1OutAvgVolt_LTE_A2; 
	__TBL16 Fwd1OutPeakVolt_LTE_A2; 
	__TBL16 Rvs1OutVolt_LTE_A2; 	
	
	__TBL16 FwdInVolt_LTE_A_1;
	__TBL16 FwdOutAvgVolt_LTE_A_1; 
	__TBL16 FwdOutPeakVolt_LTE_A_1; 
	__TBL16 RvsInVolt_LTE_A_1;
	__TBL16 RvsOutVolt_LTE_A_1; 
} __DET1VOLT;


typedef struct {
	INT8S FwdOutAvgPwr_2G;
	INT8S FwdOutPeakPwr_2G; 
	INT8S RvsOutPwr_2G; 
	INT8S FwdOutAvgPwr_LTE; 
	INT8S FwdOutPeakPwr_LTE; 
	INT8S RvsInPwr_LTE; 
	INT8S RvsOutPwr_LTE; 
	INT8S FwdInPwr_CDMALTE;
	INT8S FwdOutAvgPwr_CDMALTE; 
	INT8S FwdOutPeakPwr_CDMALTE; 
	
	INT8S RvsInPwr_CDMALTE;
	INT8S RvsOutPwr_CDMALTE; 
	INT8S FwdOutAvgPwr_LTE_A1; 
	INT8S FwdOutPeakPwr_LTE_A1; 
	INT8S RvsOutPwr_LTE_A1; 
	INT8S FwdOutAvgPwr_LTE_A2; 
	INT8S FwdOutPeakPwr_LTE_A2; 
	INT8S RvsOutPwr_LTE_A2; 
	INT8S FwdInPwr_LTE_A;
	INT8S FwdOutAvgPwr_LTE_A; 
	
	INT8S FwdOutPeakPwr_LTE_A; 
	INT8S RvsInPwr_LTE_A;
	INT8S RvsOutPwr_LTE_A; 
 	INT8S Rvs1InPwr_LTE_A;
	INT8S FwdInPwr_3G; 
	INT8S FwdOutAvgPwr_3G; 
	INT8S FwdOutPeakPwr_3G; 
	INT8S RvsInPwr_3G; 
	INT8S RvsOutPwr_3G; 
	INT8S FwdRmtOut_CDMALTE; 
	
	INT8S FwdRmtOut_WCDMA; 
	INT8S FwdRmtOut_LTE_A; /////32

	INT8S RvsInPwr_2G; 
	INT8S RvsInPwr_LTE_A1; 
	INT8S RvsInPwr_LTE_A2; 
} __DET;

typedef struct {

	INT8S FwdOutAvgPwr_LTE;
	INT8S FwdOutAvgPwr_LTE_A1;
	INT8S FwdOutAvgPwr_LTE_A2;
	INT8S Fwd1OutAvgPwr_LTE;
	INT8S Fwd1OutAvgPwr_LTE_A1;
	INT8S Fwd1OutAvgPwr_LTE_A2;
}__DET2;

typedef struct {
	INT8S FwdOutAvgPwr_2G;
	INT8S FwdOutPeakPwr_2G; 
	INT8S RvsOutPwr_2G; 
	INT8S FwdOutAvgPwr_LTE; 
	INT8S FwdOutPeakPwr_LTE; 
	INT8S RvsInPwr_LTE; 
	INT8S RvsOutPwr_LTE; 
	INT8S FwdInPwr_CDMALTE;
	INT8S FwdOutAvgPwr_CDMALTE; 
	INT8S FwdOutPeakPwr_CDMALTE; 
	INT8S RvsInPwr_CDMALTE;
	INT8S RvsOutPwr_CDMALTE; 
	INT8S FwdOutAvgPwr_LTE_A1; 
	INT8S FwdOutPeakPwr_LTE_A1; 
	INT8S RvsOutPwr_LTE_A1; 
	INT8S FwdOutAvgPwr_LTE_A2; 
	INT8S FwdOutPeakPwr_LTE_A2; 
	INT8S RvsOutPwr_LTE_A2; 
	INT8S FwdInPwr_LTE_A;
	INT8S FwdOutAvgPwr_LTE_A; 
	INT8S FwdOutPeakPwr_LTE_A; 
	INT8S RvsInPwr_LTE_A;
	INT8S Rvs1InPwr_LTE_A;
	INT8S RvsOutPwr_LTE_A; 
	INT8S FwdInPwr_3G; 
	INT8S FwdOutAvgPwr_3G; 
	INT8S FwdOutPeakPwr_3G; 
	INT8S RvsInPwr_3G; 
	INT8S RvsOutPwr_3G; 
	
	INT8S FwdRmtOut_CDMALTE; 
	INT8S FwdRmtOut_WCDMA; 
	INT8S FwdRmtOut_LTE_A; /////32
	INT8S RvsInPwr_2G; 
	INT8S RvsInPwr_LTE_A1; 
	INT8S RvsInPwr_LTE_A2;
} __DETOffset;



typedef struct {	
	INT8U FwdAttn1_2G;	
	INT8U FwdAttn2_2G;	
	INT8S RvsAttn1_2G;	
	INT8U RvsAttn2_2G;	
	INT8U RvsAttn3_2G;	
	INT8U RvsAttn4_2G;	
	INT8U RvsAttn5_2G;	

	INT8U FwdAttn1_LTE;	
	INT8U FwdAttn2_LTE;	
	INT8U RvsAttn1_LTE;	
	INT8U RvsAttn2_LTE;	
	INT8U RvsAttn3_LTE;	
	INT8U RvsAttn4_LTE;	
	INT8U RvsAttn5_LTE;	

	INT8U FwdAttn1_CDMALTE;	
	INT8U FwdAttn2_CDMALTE;	
	INT8U FwdAttn3_CDMALTE;	
	INT8U RvsAttn1_CDMALTE;	
	INT8U RvsAttn2_CDMALTE;	
	INT8U RvsAttn3_CDMALTE;	
	INT8U RvsAttn4_CDMALTE;	

#if 1
	INT8U FwdAttn1_LTE_A1; 
	INT8U FwdAttn2_LTE_A1; 
	INT8U RvsAttn1_LTE_A1; 
	INT8U RvsAttn2_LTE_A1; 
	INT8U RvsAttn3_LTE_A1; 
	INT8U RvsAttn4_LTE_A1; 
#endif

	INT8U FwdAttn1_LTE_A2; 
	INT8U FwdAttn2_LTE_A2; 
	INT8U RvsAttn1_LTE_A2; 
	INT8U RvsAttn2_LTE_A2; 
	INT8U RvsAttn3_LTE_A2; 
	INT8U RvsAttn4_LTE_A2; 


	INT8U FwdAttn1_LTE_A; 
	INT8U FwdAttn2_LTE_A; 
	INT8U FwdAttn3_LTE_A; 

	INT8U RvsAttn1_LTE_A; 
	INT8U RvsAttn2_LTE_A; 
	INT8U RvsAttn3_LTE_A; 
	INT8U RvsAttn4_LTE_A; 
	
	INT8U FwdAttn1_3G;	
	INT8U FwdAttn2_3G;	
	INT8U FwdAttn3_3G;	
	INT8U FwdAttn4_3G;	
	INT8U RvsAttn1_3G;	
	INT8U RvsAttn2_3G;	
	INT8U RvsAttn3_3G;	
	INT8U RvsAttn4_3G;	
	INT8S RvsAttn5_3G;	
} __AttOffset;


typedef struct {
	INT8S Fwd1InPwr_LTE;
	INT8S Fwd1OutAvgPwr_LTE; 
	INT8S Fwd1OutPeakPwr_LTE; 
	INT8S Rvs1InPwr_LTE;
	INT8S Rvs1OutPwr_LTE;
	
	INT8S Fwd1OutAvgPwr_LTE_A1; 
	INT8S Fwd1OutPeakPwr_LTE_A1; 
	INT8S Rvs1OutPwr_LTE_A1; 

	INT8S Fwd1OutAvgPwr_LTE_A2; 
	INT8S Fwd1OutPeakPwr_LTE_A2; 
	INT8S Rvs1OutPwr_LTE_A2; 

	INT8S FwdInPwr_LTE_A_1;
	INT8S FwdOutAvgPwr_LTE_A_1; 
	INT8S FwdOutPeakPwr_LTE_A_1; 
	INT8S RvsInPwr_LTE_A_1;
	INT8S RvsOutPwr_LTE_A_1; 

} __DET1;

typedef struct {
	INT8S Fwd1InPwr_LTE;
	INT8S Fwd1OutAvgPwr_LTE; 
	INT8S Fwd1OutPeakPwr_LTE; 
	INT8S Rvs1InPwr_LTE;
	INT8S Rvs1OutPwr_LTE;
	
	INT8S Fwd1OutAvgPwr_LTE_A1; 
	INT8S Fwd1OutPeakPwr_LTE_A1; 
	INT8S Rvs1OutPwr_LTE_A1; 
	
	INT8S Fwd1OutAvgPwr_LTE_A2; 
	INT8S Fwd1OutPeakPwr_LTE_A2; 
	INT8S Rvs1OutPwr_LTE_A2; 
	
	INT8S FwdInPwr_LTE_A_1;
	INT8S FwdOutAvgPwr_LTE_A_1; 
	INT8S FwdOutPeakPwr_LTE_A_1; 
	INT8S RvsInPwr_LTE_A_1;
	INT8S Rvs1InPwr_LTE_A_1;
	INT8S RvsOutPwr_LTE_A_1; 
} __DET1Offset;


typedef struct {	
	INT8U Fwd1Attn1_LTE;
	INT8U Fwd1Attn2_LTE;
	INT8U Rvs1Attn1_LTE;
	INT8U Rvs1Attn2_LTE;
	INT8U Rvs1Attn3_LTE;
	INT8U Rvs1Attn4_LTE;

	INT8U Fwd1Attn1_LTE_A1; 
	INT8U Fwd1Attn2_LTE_A1; 

	INT8U Rvs1Attn1_LTE_A1; 
	INT8U Rvs1Attn2_LTE_A1; 
	INT8U Rvs1Attn3_LTE_A1; 

	INT8U Fwd1Attn1_LTE_A2; 
	INT8U Fwd1Attn2_LTE_A2; 
	
	INT8U Rvs1Attn1_LTE_A2; 
	INT8U Rvs1Attn2_LTE_A2; 
	INT8U Rvs1Attn3_LTE_A2; 

	INT8U Fwd1Attn1_LTE_A; 
	INT8U Fwd1Attn2_LTE_A; 
	INT8U Fwd1Attn3_LTE_A; 
	
	INT8U Rvs1Attn1_LTE_A; 
	INT8U Rvs1Attn2_LTE_A; 
	INT8U Rvs1Attn3_LTE_A; 
	INT8U Rvs1Attn4_LTE_A; 
	INT8U Rvs1Attn5_LTE;
} __Att1Offset;



typedef struct {	
	INT8U BalanceAtt_CDMA;
	INT8U BalanceAtt_LTE;
	INT8U BalanceAtt_LTE_A;
	INT8U BalanceAtt_WCDMA;
} __BalanceModeAtt;




typedef struct {
	INT8S BalancePwr_CDMA;
	INT8S BalancePwr_LTE;
	INT8S BalancePwr_LTE_A;
	INT8S BalancePwr_WCDMA;	
} __BalanceModeDET;



typedef struct {
	__TBL16 BalanceVolt_CDMA; 
	__TBL16 BalanceVolt_LTE; 
	__TBL16 BalanceVolt_LTE_A; 
	__TBL16 BalanceVolt_WCDMA; 
} __BalanceModeVOLT;



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
//			INT8U 						:5;
			INT8U 						:1;
			INT8U SleepMode_2G			:1;
			INT8U SleepMode_LTE			:1;
			INT8U SleepMode_LTE_A2		:1;
			INT8U SleepMode_3G			:1;



			INT8U DCFail				:1;
			INT8U RvsOtherOverInAlarm 	:1; 
			INT8U RvsOverInAlarm 		:1; 	//7

			
     		INT8U 						:8;
     		INT8U 						:8;
     		INT8U 						:8;
     		INT8U 						:8;
			
		};
	} Main;

	#if 0
	union {
		INT8U Data;
		struct {
     		INT8U 						:8;
		};
	} Reseverd1;		

	union {
		INT8U Data;
		struct { 
			INT8U 						:8;
		};
	} Reseverd2;		


	union {
		INT8U Data;
		struct {
			INT8U 						:8;
		};
	} Reseverd3;	


	union {
		INT8U Data;
		struct {
			INT8U 						:8;
		};
	} Reseverd4;
	#endif
} __TRIO_AlmStr;


typedef union {
	INT8U Data;
	struct {
		INT8U LTE			:1; 	
		INT8U LTE_A1		:1;
		INT8U LTE_A2		:1;
		INT8U LTE_1			:1; 
		INT8U LTE_A1_1		:1;
		INT8U LTE_A2_1		:1; 
		INT8U 				:1;
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
//				INT8U AdjLowLimitAlarm		:1;
//				INT8U AdjHiLimitAlarm		:1;
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
//	INT8U AdjMaxVal[2];				// 0x0C07
//	INT8U AdjMinVal[2];				// 0x0C08
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
#if 1
typedef union{
	INT8U uD8[2];
	
    INT16U uD16;
	INT16S sD16;

} type16;
#endif

#if 0
typedef struct {

	INT8U SleepCnt;
	INT8S SleepStep;
	INT8U IsItSLP;
	INT8S SleepRecovery;
} __SleepStr1;

#endif
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

	INT8S FwdInPwr_3G;					// 0x0500
	INT8S FwdOutPwr_3G[2];				// 0x0503
	INT8S FwdOutPwrPeak_3G[2];			// 0x0503
	INT8S FwdOutUpperLmt_3G[2]; 		// 0x0504 (Range: 13 ~ 21dBm)
	INT8S FwdOutLowerLmt_3G[2]; 		// 0x0505
	INT8U FwdGainSet_3G;				// 0x0529  Forward Gain(설정값)  43~83dB
	INT8U FwdGain_3G;					// 0x052a  Forward Gain(현재값)

	INT8S FwdInPwr_2G;					// 0x0510
	INT8S FwdOutPwr_2G[2];				// 0x0514
	INT8S FwdOutPwrPeak_2G[2];				// 0x0514
	INT8S FwdOutUpperLmt_2G[2]; 		// 0x0515   (Range: 1 ~ 9dBm)
	INT8S FwdOutLowerLmt_2G[2]; 		// 0x0516
	INT8U FwdGainSet_2G;				// 0x0542  Forward Gain(설정값)  23~73dB
	INT8U FwdGain_2G;					// 0x0543  Forward Gain(현재값)

	INT8S FwdInPwr_LTE;					// 0x0552
	INT8S FwdOutPwr_LTE[2];				// 0x0556
	INT8S FwdOutPwrPeak_LTE[2];				// 0x0556
	INT8S FwdOutUpperLmt_LTE[2]; 		// 0x0557 (Range: 2 ~ 12dBm)
	INT8S FwdOutLowerLmt_LTE[2]; 		// 0x0558
	INT8U FwdGainSet_LTE;				// 0x0569  Forward Gain(설정값)
	INT8U FwdGain_LTE;					// 0x056A  Forward Gain(현재값)  23~73dB
#if 0 
	INT8S FwdInPwr_LTE_A1;				// 0x056B
	INT8S FwdOutPwr_LTE_A1[2];			// 0x056C
	INT8S FwdOutPwrPeak_LTE_A1[2];		// 0x056C
	
	INT8S FwdOutUpperLmt_LTE_A1[2]; 	// 0x056D  (Range: 7 ~ 17dBm)
	INT8S FwdOutLowerLmt_LTE_A1[2]; 	// 0x056E
	INT8U FwdGainSet_LTE_A1;			// 0x0571  Forward Gain(설정값) 38~83dB
	INT8U FwdGain_LTE_A1;				// 0x0572  Forward Gain(현재값)
#endif
	INT8S FwdInPwr_LTE_A2;				// 0x1B14
	INT8S FwdOutPwr_LTE_A2[2];			// 0x1B15
	INT8S FwdOutPwrPeak_LTE_A2[2];		// 0x1B15
	
	INT8S FwdOutUpperLmt_LTE_A2[2]; 	// 0x1B16  (Range: 7 ~ 17dBm)
	INT8S FwdOutLowerLmt_LTE_A2[2]; 	// 0x1B17
	INT8U FwdGainSet_LTE_A2;			// 0x1B1A  Forward Gain(설정값) 38~83dB
	INT8U FwdGain_LTE_A2;				// 0x1B1B  Forward Gain(현재값)
#if 0
	INT8S Fwd1InPwr_LTE;				// 0x1B12
	INT8S Fwd1OutPwr_LTE[2];			// 0x1B00
	INT8S Fwd1OutPwrPeak_LTE[2];		// 0x1B00
	
	INT8S Fwd1OutUpperLmt_LTE[2];		// 0x1B01
	INT8S Fwd1OutLowerLmt_LTE[2];		// 0x1B02
	INT8U Fwd1GainSet_LTE;				// 0x1B03 Forward Gain(설정값)
	INT8U Fwd1Gain_LTE; 				// 0x1B04 Forward Gain(현재값)

	INT8S Fwd1InPwr_LTE_A1; 			// 0x1B13
	INT8S Fwd1OutPwr_LTE_A1[2]; 		// 0x1B06
	INT8S Fwd1OutPwrPeak_LTE_A1[2]; 	// 0x1B06
	
	INT8S Fwd1OutUpperLmt_LTE_A1[2];	// 0x1B07
	INT8S Fwd1OutLowerLmt_LTE_A1[2];	// 0x1B08
	INT8U Fwd1GainSet_LTE_A1;			// 0x1B09 Forward Gain(설정값)
	INT8U Fwd1Gain_LTE_A1;				// 0x1B10 Forward Gain(현재값)

	INT8S Fwd1InPwr_LTE_A2; 			// 0x1B1D
	INT8S Fwd1OutPwr_LTE_A2[2]; 		// 0x1B1E
	INT8S Fwd1OutPwrPeak_LTE_A2[2]; 	// 0x1B1E
	INT8S Fwd1OutUpperLmt_LTE_A2[2];	// 0x1B1F
	INT8S Fwd1OutLowerLmt_LTE_A2[2];	// 0x1B20
	INT8U Fwd1GainSet_LTE_A2;			// 0x1B21 Forward Gain(설정값)
	INT8U Fwd1Gain_LTE_A2;				// 0x1B22 Forward Gain(현재값)
#endif
//////////////////////
	INT8U Rvs0GainSet_3G;				// 0x0604	Reverse Gain(설정값)
	INT8U RvsGainSts_3G;				// 0x062E	Reverse Gain(현재값)
	INT8U RvsGainBalance_3G;			// 0x062D	Reverse Gain Balance

	INT8U Rvs0GainSet_2G;				// 0x060F	Reverse Gain(설정값)
	INT8U RvsGainSts_2G;				// 0x0640	Reverse Gain(현재값)
	INT8U RvsGainBalance_2G;			// 0x063F	Reverse Gain Balance

	INT8U Rvs0GainSet_LTE;				// 0x0674	Reverse Gain(설정값)
	INT8U RvsGainSts_LTE;				// 0x0677	Reverse Gain(현재값)
	INT8U RvsGainBalance_LTE;			// 0x0676	Reverse Gain Balance
#if 0
	INT8U Rvs0GainSet_LTE_A1;			// 0x067A	Reverse Gain(설정값)
	INT8U RvsGainSts_LTE_A1;			// 0x067D	Reverse Gain(현재값)
	INT8U RvsGainBalance_LTE_A1;		// 0x067C	Reverse Gain Balance
#endif
	INT8U Rvs0GainSet_LTE_A2;			// 0x1C0B	Reverse Gain(설정값)
	INT8U RvsGainSts_LTE_A2;			// 0x1C0D	Reverse Gain(현재값)
	INT8U RvsGainBalance_LTE_A2;		// 0x1C0C	Reverse Gain Balance

	INT8U Rvs1GainSet_LTE;				// 0x1C00	Reverse Gain(설정값)
	INT8U Rvs1GainSts_LTE;				// 0x1C03	Reverse Gain(현재값)
	INT8U Rvs1GainBalance_LTE;			// 0x1C02	Reverse Gain Balance
#if 0
	INT8U Rvs1GainSet_LTE_A1;			// 0x1C05	Reverse Gain(설정값)
	INT8U Rvs1GainSts_LTE_A1;			// 0x1C08	Reverse Gain(현재값)
	INT8U Rvs1GainBalance_LTE_A1;		// 0x1C07	Reverse Gain Balance
#endif
	INT8U Rvs1GainSet_LTE_A2;			// 0x1C11	Reverse Gain(설정값)
	INT8U Rvs1GainSts_LTE_A2; 			// 0x1C14	Reverse Gain(현재값)
	INT8U Rvs1GainBalance_LTE_A2; 		// 0x1C13	Reverse Gain Balance

///////////////////////////
	INT8U AmpOffCase_3G;				// 0x070f
	INT8U AmpOffCase_2G;				// 0x0718
	INT8U AmpOffCase_LTE;				// 0x0754
//	INT8U AmpOffCase_LTE_A1;			// 0x0752
	INT8U AmpOffCase_LTE_A2;			// 0x075B
#if 0
	INT8U Amp1OffCase_LTE;				// 0x0757
	INT8U Amp1OffCase_LTE_A1;			// 0x0758
	INT8U Amp1OffCase_LTE_A2;			// 0x075C
#endif
	INT8U FwdAmpOnOff_3G;				// 0x0706
	INT8U FwdAmpOnOff_2G;				// 0x0715
	INT8U FwdAmpOnOff_LTE;				// 0x074F
//	INT8U FwdAmpOnOff_LTE_A1;			// 0x0755
	INT8U FwdAmpOnOff_LTE_A2;			// 0x0759
#if 0
	INT8U FwdAmp1OnOff_LTE;				// 0x0753
	INT8U FwdAmp1OnOff_LTE_A1; 			// 0x0752
	INT8U FwdAmp1OnOff_LTE_A2; 			// 0x075A
#endif
	INT8U AGCOnOff_3G;					// 0x090A
	INT8U AGCOnOff_CDMALTE;				// 0x1068
	INT8U AGCOnOff_LTE_A_0;				// 0x1069
//	INT8U AGC1OnOff_LTE;				// 0x105F
//	INT8U AGCOnOff_LTE_A_1;				// 0x106A

	INT8U AGCMode_3G;					// 0x105B
	INT8U AGCMode_2G;					// 0x105C
	INT8U AGCMode_LTE;					// 0x105D
//	INT8U AGCMode_LTE_A1;				// 0x105E
	INT8U AGCMode_LTE_A2;				// 0x1067

	INT8U Band_Select_LTE_A1;			// 0x1065
	INT8U Band_Select_LTE_A2[3];		// 0x1066

	INT8U LTE15MUse;					// 0x1059
	INT8U RepeatResetPriod;				// 0x102A
	INT8U HostNumber[11];				// 0x0920
	
	INT8U AutoReportPriod;				// 0x0922
	INT8U AutoReportBasePer[2];			// 0x0923
	INT8U ReportHours[2];				// 0x092E

	__FemtocellUseOnOff FemtocellUseOnOff; // 0x1062

	INT8U RvsOverInAlarmCount;			// 0x106B
	INT8U RvsOtherOverInAlarmCount;		// 0x106C

	////////////////////////////////////////////////////

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
	
//	__TBL16 VccDet_Lmt;					// 0xA02B
	INT8U VccDet_Lmt[2];				// 0xA02B

	INT8S FwdInPwrOffset_2G;			// 0xA101
	INT8S FwdInPwrOffset_3G;			// 0xA102
	INT8S Rvs0OutPwrOffset_2G;			// 0xA109
	INT8S Rvs0OutPwrOffset_3G;			// 0xA10B
	INT8S FwdOutPwrOffset_2G;			// 0xA158
	INT8S FwdOutPwrOffset_3G;			// 0xA159


	INT8S FwdAttn1_2G;					// 0xA15E 	AGC 0~25dB
//	INT8S FwdAttn2_2G;					// 0xA15f	toggle 25~0dB

//	INT8S cFwdAttn1_2G;					// 0xA15E 	AGC 0~25dB
//	INT8S cFwdAttn2_2G;					// 0xA15f	toggle 25~0dB


	INT8S FwdAttn1_3G;					// 0xA162	AGC 26~40dB
	INT8S FwdAttn2_3G;					// 0xA163	AGC 0~25dB

// 	INT8U cFwdAttn1_3G;

	
	INT8S RvsAttn1_2G;					// 0xA166    ALC 0~25dB
	INT8U RvsAttn2_2G;					// 0xA167    AGC 31 ~ 40dB G/B 0~10dB toggle 10~0dB
//	INT8U ToggleRvsAttn2_2G;			// 0xA167	toggle 10~0dB
	INT8U RvsAttn3_2G;					// 0xA168   AGC 0~30dB

	INT8U RvsAttn1_3G;					// 0xA16A  ALC 26~ 45dB
	INT8U RvsAttn2_3G;					// 0xA16B  ALC 0~25dB
	INT8U RvsAttn3_3G;					// 0xA16C  AGC 31~40dB  G/B 0~10dB
	INT8S RvsAttn4_3G;					// 0xA16D  AGC 0~30dB

	
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
	
	INT8U FwdGainOffset_3G;				// 0xA36A
	INT8U RvsGainOffset_3G;				// 0xA36B
	INT8U FwdGainOffset_2G;				// 0xA36C
	INT8U RvsGainOffset_2G;				// 0xA36D

	INT8S FwdTemp_3G;					// 0xA36E
	INT8S RvsTemp_3G;					// 0xA36F
	INT8S FwdTemp_2G;					// 0xA370
	INT8S RvsTemp_2G;					// 0xA371
	INT8S FwdOutHighLmt_3G[2];			// 0xA373
	INT8S FwdOutHighLmt_2G[2];			// 0xA374
	INT8U DebugOnOff;					// 0xA391
	INT8U RadioMeasureOnOff;			// 0xA392

	__DETVOLT DetVolt;					// 0xA800
	__DET DetPwr;						// 0xA801
	__DET DetOffset;					// 0xA802
	__AttOffset AttValue;				// 0xA803
	__AttOffset AttOffset;				// 0xA804
	
//	INT8S FwdInPwrOffset_LTE_A1;		// 0xA805
//	INT8S RvsOutPwrOffset_LTE_A1;		// 0xA806
//	INT8S FwdOutPwrOffset_LTE_A1;		// 0xA807
 	INT8U FwdAttn1_CDMALTE;				// 0xA808   AGC 26 ~ 40dB     ALC 0~10dB
	INT8U RvsAttn1_CDMALTE;				// 0xA80B   ALC 26~ 35dB


 	INT8U cFwdAttn_CDMA;
 	INT8U cFwdAttn_LTE;
 	INT8U cRvsAttn_CDMA;
 	INT8U cRvsAttn_LTE;

	INT8S FwdAttn1_LTE;					// 0xA810	AGC 0 ~ 25dB     ALC 0~10dB
//	INT8S FwdAttn2_LTE;					// 0xA811	toggle 25~0dB
//	INT8S cFwdAttn1_LTE;				// 0xA810	AGC 0 ~ 25dB     ALC 0~10dB


// 	INT8S FwdAttn1_LTE_A1; 				// 0xA814   AGC 26~45dB
//	INT8S FwdAttn2_LTE_A1; 				// 0xA815	AGC 0~25dB

// 	INT8S cFwdAttn1_LTE_A1; 			// 0xA814   AGC 26~45dB

	
 	INT8S RvsAttn1_LTE;					// 0xA819   ALC 26~ 35dB    
	INT8U RvsAttn2_LTE;					// 0xA819   ALC 0~25dB    
	INT8U RvsAttn3_LTE;					// 0xA81A   AGC 31~40dB   G/B 0~10 dB   

// 	INT8U RvsAttn1_LTE_A1; 				// 0xA81D   ALC 26~ 45dB   
//	INT8U RvsAttn2_LTE_A1; 				// 0xA81E   ALC 0~25dB    
//	INT8S RvsAttn3_LTE_A1; 				// 0xA81F	AGC 31~45dB	 G/B 0~10dB

 	INT8U FwdGainOffset_LTE; 			// 0xA822
	INT8U RvsGainOffset_LTE; 			// 0xA823
//	INT8U FwdGainOffset_LTE_A1; 		// 0xA824
//	INT8U RvsGainOffset_LTE_A1; 		// 0xA825
 	INT8S FwdAgcAttn_2G; 				// 0xA826
	INT8S FwdAgcAttn_LTE; 				// 0xA827
//	INT8S FwdAgcAttn_LTE_A1; 			// 0xA828
	INT8S FwdAgcAttn_3G; 				// 0xA829
 	INT8S RvsAlcAttn_2G;				// 0xA82A
	INT8S RvsAlcAttn_LTE;				// 0xA82B
//	INT8S RvsAlcAttn_LTE_A1; 			// 0xA82C
	INT8S RvsAlcAttn_3G;				// 0xA82D
 	INT8U RvsAlcOnOff_2G;				// 0xA82E
	INT8U RvsAlcOnOff_LTE;				// 0xA82F
//	INT8U RvsAlcOnOff_LTE_A1; 			// 0xA830
	INT8U RvsAlcOnOff_3G;				// 0xA831
 	INT8S RvsOutPwr_LTE[2]; 			// 0xA844
//	INT8S RvsOutPwr_LTE_A1[2]; 			// 0xA845
 	INT8S RvsInPwr_2G[2]; 				// 0xA846
	INT8S RvsInPwr_LTE[2]; 				// 0xA847
//	INT8S RvsInPwr_LTE_A1[2]; 			// 0xA848
	INT8S RvsInPwr_3G[2]; 				// 0xA849

 	INT8U ShutDownOnOff_LTE; 			// 0xA84A
//	INT8U ShutDownOnOff_LTE_A1; 		// 0xA84B
 	INT8S RvsOutUpperLmt_LTE[2]; 		// 0xA84C
//	INT8S RvsOutUpperLmt_LTE_A1[2]; 	// 0xA84D
 	INT8S FwdTemp_LTE;					// 0xA84E
	INT8S RvsTemp_LTE;					// 0xA84F
//	INT8S FwdTemp_LTE_A1;				// 0xA850
//	INT8S RvsTemp_LTE_A1;				// 0xA851
	INT8S FwdOutHighLmt_LTE[2];			// 0xA852
//	INT8S FwdOutHighLmt_LTE_A1[2];		// 0xA853
	INT8S OverInAlarmLmt_2G;			// 0xA854
	INT8S OverInAlarmLmt_LTE;			// 0xA855
//	INT8S OverInAlarmLmt_LTE_A1;		// 0xA856
	INT8S OverInAlarmLmt_3G;			// 0xA857
#if 0
 	INT8S OtherOverInAlarmLmt_2G;		// 0xA858
	INT8S OtherOverInAlarmLmt_LTE;		// 0xA859
	INT8S OtherOverInAlarmLmt_LTE_A1;	// 0xA85A
	INT8S OtherOverInAlarmLmt_3G;		// 0xA85B
#endif	
 	INT8S RvsALCLvl_2G;					// 0xA85D
 	INT8S RvsALCLvl_3G;					// 0xA85E
	INT8S RvsALCLvl_LTE;				// 0xA85F
//	INT8S RvsALCLvl_LTE_A1; 			// 0xA860C
	INT8U ShunDownTime;					// 0xA862
	
	INT8S FwdInPwrOffset_LTE_A2;		// 0xA870
	
	INT8S RvsOutPwrOffset_LTE_A2;		// 0xA871
	INT8S FwdOutPwrOffset_LTE_A2;		// 0xA872
	INT8S FwdAttn1_LTE_A2;				// 0xA873	AGC 26~45dB
	INT8S FwdAttn2_LTE_A2;				// 0xA874	AGC 0~25dB
	INT8S cFwdAttn1_LTE_A2;				// 0xA873	AGC 26~45dB
	INT8S cFwdAttn2_LTE_A2;				// 0xA874	AGC 0~25dB

	INT8U RvsAttn1_LTE_A2;				// 0xA877	ALC 26~ 45dB   
	INT8U RvsAttn2_LTE_A2;				// 0xA878	ALC 0~25dB	  
	INT8S RvsAttn3_LTE_A2;				// 0xA879	AGC 31~45dB  G/B 0~10dB
	INT8U RvsAttn4_LTE_A2;				// 0xA87A	AGC 0~30dB	  

	INT8U FwdGainOffset_LTE_A2; 		// 0xA87C
	INT8U RvsGainOffset_LTE_A2; 		// 0xA87D
	INT8S FwdAgcAttn_LTE_A2;			// 0xA87E
	INT8S RvsAlcAttn_LTE_A2;			// 0xA87F
	
	INT8U RvsAlcOnOff_LTE_A2;			// 0xA880
	INT8S RvsOutPwr_LTE_A2[2];			// 0xA88A
	INT8S RvsInPwr_LTE_A2[2];			// 0xA88B
	INT8U ShutDownOnOff_LTE_A2; 		// 0xA88C
	
	INT8S RvsOutUpperLmt_LTE_A2[2]; 	// 0xA88D
	INT8S FwdTemp_LTE_A2;				// 0xA88E
	INT8S RvsTemp_LTE_A2;				// 0xA88F
	INT8S FwdOutHighLmt_LTE_A2[2];		// 0xA890
	INT8S OverInAlarmLmt_LTE_A2;		// 0xA891
	INT8S RvsALCLvl_LTE_A2; 			// 0xA893
//	INT8U FwdAttn1_LTE_A;				// 0xA896	AGC 26~45dB
//	INT8U RvsAttn1_LTE_A;				// 0xA899	ALC 26~ 45dB   

	INT8S PllFregOffset_LTE;			// 0xA8AD	

////////////////////////////////////////
	INT8S	FwdAgcAttn[4]; 				// ab --> ab		
	INT8S	RvsAlcAttn[4]; 				// ab --> ab		

	INT8S	FwdAGCLimit[4];				// ab --> ab		// fwd agc level
	INT8S	RvsALCLimit[4];				// ab --> ab		// fwd agc level

	INT8S	FwdPower[4];				// ab --> ab*10 	// 2004-05-31 2:01오후
	INT8S	RvsPower[4];				// ab --> ab

	INT8U	AmpOnOff[4];				// ON : '1', OFF : '0'
	INT8U	AGCOnOff[4];				// ON : '1', OFF : '0'
	INT8S	ALCOnOff[4];				// ON : '1', OFF : '0'
	INT8U	SDNOnOff[4];				// ON : '1', OFF : '0'

	type16	AGCTime[2]; 				// ab --> ab/1sec

	INT8U AvgMAXGARBAGE_Tx[4];
	INT8U AvgMINGARBAGE_Tx[4];
	INT8U PeakMAXGARBAGE_Tx[4];
	INT8U PeakMINGARBAGE_Tx[4];

	INT8U PeakMAXGARBAGE_Rx[4];
	INT8U PeakMINGARBAGE_Rx[4];


	INT8U ADCAVRMAX[4];


	INT16S RealRvsInPwr_2G;				// 0xA846
	INT16S RealRvsInPwr_LTE;			// 0xA846
	INT16S RealRvsInPwr_LTEA;			// 0xA846
	INT16S RealRvsInPwr_3G;				// 0xA846

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
//	unsigned short	AR_Delay[3]; 		// 10초단위의 자동보고 남은 시간, 차례로 중계기/전파/idle전파 자동보고 남은시간.

	///////////////////////////////////////////////////////  MIMO
#if 0
	__DET1VOLT 		Det1Volt;			// 0xA900
	__DET1 			Det1Pwr;			// 0xA901
	__DET1		 	Det1Offset;			// 0xA902
	__Att1Offset 	Att1Value;			// 0xA903
	__Att1Offset 	Att1Offset;			// 0xA903

	INT8S Fwd1InPwrOffset_LTE;			// 0xA905
	
	INT8S Rvs1OutPwrOffset_LTE;			// 0xA906
	INT8S Fwd1OutPwrOffset_LTE;			// 0xA907
	INT8S Fwd1InPwrOffset_LTE_A1;		// 0xA908
	
	INT8S Rvs1OutPwrOffset_LTE_A1;		// 0xA909
	INT8S Fwd1OutPwrOffset_LTE_A1;		// 0xA90A
	
	INT8U Fwd1Attn1_LTE;				// 0xA90B   AGC 26~ 40dB ALC 0~10dB
	INT8U Fwd1Attn2_LTE;				// 0xA90C	AGC 0~25dB
 	INT8U Fwd1Attn1_LTE_A1; 			// 0xA90F   AGC 26~45dB
	INT8S Fwd1Attn2_LTE_A1; 			// 0xA910	AGC 0~25dB
 	INT8U Rvs1Attn1_LTE;				// 0xA913   ALC 26~ 35dB
	INT8U Rvs1Attn2_LTE;				// 0xA914   ALC 0~25dB
	INT8U Rvs1Attn3_LTE;				// 0xA915   AGC 31~40dB G/B 0~10 dB
	INT8U Rvs1Attn4_LTE;				// 0xA916   AGC 0~30dB
 	INT8U Rvs1Attn1_LTE_A1; 			// 0xA918   ALC 26~ 45dB
	INT8U Rvs1Attn2_LTE_A1; 			// 0xA919   ALC 0~25dB
	INT8U Rvs1Attn3_LTE_A1; 			// 0xA91A   AGC 31~45dB G/B 0~10dB
	INT8U Rvs1Attn4_LTE_A1; 			// 0xA91B   AGC 0~30dB

 	INT8U Fwd1GainOffset_LTE; 			// 0xA91D
	INT8U Rvs1GainOffset_LTE; 			// 0xA91E
	INT8U Fwd1GainOffset_LTE_A1; 		// 0xA91F
	INT8U Rvs1GainOffset_LTE_A1; 		// 0xA920
	INT8S Fwd1AgcAttn_LTE; 				// 0xA921
	INT8S Fwd1AgcAttn_LTE_A1; 			// 0xA922
	INT8S Rvs1AlcAttn_LTE;				// 0xA923
	INT8S Rvs1AlcAttn_LTE_A1; 			// 0xA924
	INT8U Rvs1AlcOnOff_LTE;				// 0xA925
	INT8U Rvs1AlcOnOff_LTE_A1; 			// 0xA926
 	INT8S Rvs1OutPwr_LTE[2]; 			// 0xA92B
	INT8S Rvs1OutPwr_LTE_A1[2]; 		// 0xA92C
	INT8S Rvs1InPwr_LTE[2]; 			// 0xA92D
	INT8S Rvs1InPwr_LTE_A1[2]; 			// 0xA92E

 	INT8U ShutDownOnOff_LTE1; 			// 0xA92F
	INT8U ShutDownOnOff_LTE_A1_1; 		// 0xA930
 	INT8S Rvs1OutUpperLmt_LTE[2]; 		// 0xA931
	INT8S Rvs1OutUpperLmt_LTE_A1[2]; 	// 0xA932
 	INT8S Fwd1Temp_LTE;					// 0xA933
	INT8S Rvs1Temp_LTE;					// 0xA934
	INT8S Fwd1Temp_LTE_A1;				// 0xA935
	INT8S Rvs1Temp_LTE_A1;				// 0xA936
	INT8S Fwd1OutHighLmt_LTE[2];		// 0xA937
	INT8S Fwd1OutHighLmt_LTE_A1[2];		// 0xA938
	INT8U Rvs1ALCLvl_LTE;				// 0xA939
	INT8U Rvs1ALCLvl_LTE_A1; 			// 0xA93A


	INT8S Fwd1InPwrOffset_LTE_A2;		// 0xA93D
	INT8S Fwd1OutPwrOffset_LTE_A2;		// 0xA93F
	INT8S Rvs1OutPwrOffset_LTE_A2;		// 0xA93E

 	INT8U Fwd1Attn1_LTE_A2; 			// 0xA940   AGC 26~45dB
	INT8S Fwd1Attn2_LTE_A2; 			// 0xA941	AGC 0~25dB

 	INT8U Rvs1Attn1_LTE_A2; 			// 0xA944   ALC 26~ 45dB
	INT8U Rvs1Attn2_LTE_A2; 			// 0xA945   ALC 0~25dB
	INT8U Rvs1Attn3_LTE_A2; 			// 0xA946   AGC 31~45dB G/B 0~10dB
	INT8U Rvs1Attn4_LTE_A2; 			// 0xA947   AGC 0~30dB
	
	INT8U Fwd1GainOffset_LTE_A2;		// 0xA949
	INT8U Rvs1GainOffset_LTE_A2;		// 0xA94A
	INT8S Fwd1AgcAttn_LTE_A2;			// 0xA94B
	INT8S Rvs1AlcAttn_LTE_A2;			// 0xA94C
	
	INT8U Rvs1AlcOnOff_LTE_A2;			// 0xA94D
	
	INT8S Rvs1OutPwr_LTE_A2[2];			// 0xA950
	INT8S Rvs1InPwr_LTE_A2[2];			// 0xA951
	INT8U ShutDownOnOff_LTE_A2_1;		// 0xA952
	INT8S Rvs1OutUpperLmt_LTE_A2[2];	// 0xA953
	INT8S Fwd1Temp_LTE_A2;				// 0xA954
	INT8S Rvs1Temp_LTE_A2;				// 0xA955
	INT8S Fwd1OutHighLmt_LTE_A2[2]; 	// 0xA956
	INT8U Rvs1ALCLvl_LTE_A2;			// 0xA957
	INT8U SD_Status_LTE_A2_1; 			// 0xA958

	INT8U Fwd1Attn1_LTE_A;				// 0xA959	AGC 26~45dB
	INT8U Rvs1Attn1_LTE_A;				// 0xA95C	ALC 26~ 45dB   	


//	INT8U AutoShutDownSts_2G;			// 0xA605
//	INT8U AutoShutDownSts_3G;			// 0xA606
//	INT8U AutoShutDownSts_LTE;			// 0xA86b
//	INT8U AutoShutDownSts_LTE_A1;		// 0xA86c
	INT8U SD_Status_LTE_1; 		// 0xA93B
	INT8U SD_Status_LTE_A1_1; 	// 0xA93C
#endif


	INT8U SD_Status_2G;					// 0xA605		// S
	INT8U SD_Status_3G;					// 0xA606		// S
	INT8U SD_Status_LTE;				// 0xA86B		// S
//	INT8U SD_Status_LTE_A1;				// 0xA86C		// S
	INT8U SD_Status_LTE_A2;				// 0xA895		// S


	__BalanceModeOnOff BalanceModeOnOff;			// 0x082A

//	INT8U BalanceModeOnOff; 						// 0x082A

//	__BalanceModeAtt 		BalanceModeAttValue; 	// 0xAD05

	INT8U BalanceModeAttn[4]; 						// 0xAD05
	INT8S BalanceModePwr[4]; 						// 0xAD06
	INT8S BalanceModeDetOffset[4]; 					// 0xAD09

//	__BalanceModeDET		BalanceModePwr;			// 0xAD06
	__BalanceModeVOLT		BalanceModeDetVolt;		// 0xAD08
//	__BalanceModeDET		BalanceModeDetOffset; 	// 0xAD09

	INT8U BalanceTurnOnOff[4]; 						// 0x082A


	INT8S ResetCase;								// 0x0914\

//////////////////////// A20151223
	INT8U RvsOSCAlarmCount_3G;			// 0x2876
	INT8U RvsOSCAlarmCount_2G;			// 0x2877
	INT8U RvsOSCAlarmCount_LTE; 		// 0x2878
	INT8U RvsOSCAlarmCount_LTE_A1;		// 0x2879
	INT8U RvsOSCAlarmCount_LTE_A2;		// 0x287A
	INT8U Rvs1OSCAlarmCount_LTE;		// 0x287B
	INT8U Rvs1OSCAlarmCount_LTE_A1; 	// 0x287C
	INT8U Rvs1OSCAlarmCount_LTE_A2; 	// 0x287D



	INT8U CurrRvsOSCAlarmCount_3G;			// 0xD051
	INT8U CurrRvsOSCAlarmCount_2G;			// 0xD052
	INT8U CurrRvsOSCAlarmCount_LTE; 		// 0xD053
	INT8U CurrRvsOSCAlarmCount_LTE_A1;		// 0xD054
	INT8U CurrRvsOSCAlarmCount_LTE_A2;		// 0xD055
	INT8U CurrRvs1OSCAlarmCount_LTE;		// 0xD056
	INT8U CurrRvs1OSCAlarmCount_LTE_A1; 	// 0xD057
	INT8U CurrRvs1OSCAlarmCount_LTE_A2; 	// 0xD058
	
///////////////////////////////////////////////////3E3E////  ETC
	INT8U Text_Debug_Mode;
	__Comm_Debug_Mode Comm_Debug_Mode;
	INT8U TestMode; 							// 0xD001

	INT8U Comm_Debug_Port;
	INT8U ModeValue;


/////////////////////////////////////////////////

	INT8U CurrFwdAttn1_2G;		
//	INT8U CurrFwdAttn2_2G;		
	INT8U CurrRvsAttn1_2G;		
	INT8U CurrRvsAttn2_2G;		
	INT8U CurrRvsAttn3_2G;	

	INT8U CurrFwdAttn1_LTE;			
//	INT8U CurrFwdAttn2_LTE;		

 	INT8U CurrRvsAttn1_LTE;
	INT8U CurrRvsAttn2_LTE;
	INT8U CurrRvsAttn3_LTE;	

 	INT8U CurrFwdAttn1_CDMALTE;
	INT8U CurrRvsAttn1_CDMALTE;

#if 0	
 	INT8U CurrFwdAttn1_LTE_A1; 		
	INT8U CurrFwdAttn2_LTE_A1; 	
 	INT8U CurrRvsAttn1_LTE_A1; 		
	INT8U CurrRvsAttn2_LTE_A1; 		
	INT8U CurrRvsAttn3_LTE_A1; 		
#endif	
 	INT8U CurrFwdAttn1_LTE_A2; 		
	INT8U CurrFwdAttn2_LTE_A2; 	
 	INT8U CurrRvsAttn1_LTE_A2;
	INT8U CurrRvsAttn2_LTE_A2;
	INT8U CurrRvsAttn3_LTE_A2;
	INT8U CurrRvsAttn4_LTE_A2;
	
 //	INT8U CurrFwdAttn1_LTE_A;
//	INT8U CurrRvsAttn1_LTE_A;

	INT8U CurrFwdAttn1_3G;
	INT8U CurrFwdAttn2_3G;
	INT8U CurrRvsAttn1_3G;
	INT8U CurrRvsAttn2_3G;
	INT8U CurrRvsAttn3_3G;
	INT8U CurrRvsAttn4_3G;


	INT8U CurrBalanceAtt_CDMA;
	INT8U CurrBalanceAtt_LTE;
	INT8U CurrBalanceAtt_LTE_A;
	INT8U CurrBalanceAtt_WCDMA;

#if 0
	INT8U CurrFwd1Attn1_LTE;		
	INT8U CurrFwd1Attn2_LTE;		
	INT8U CurrRvs1Attn1_LTE;
	INT8U CurrRvs1Attn2_LTE;
	INT8U CurrRvs1Attn3_LTE;
	INT8U CurrRvs1Attn4_LTE;
	
	INT8U CurrFwd1Attn1_LTE_A1;		
	INT8U CurrFwd1Attn2_LTE_A1;	
	INT8U CurrRvs1Attn1_LTE_A1;
	INT8U CurrRvs1Attn2_LTE_A1;
	INT8U CurrRvs1Attn3_LTE_A1;
	
	INT8U CurrFwd1Attn1_LTE_A2;		
	INT8U CurrFwd1Attn2_LTE_A2;	
	INT8U CurrRvs1Attn1_LTE_A2;
	INT8U CurrRvs1Attn2_LTE_A2;
	INT8U CurrRvs1Attn3_LTE_A2;
		
 	INT8U CurrFwd1Attn1_LTE_A;
	INT8U CurrRvs1Attn1_LTE_A;
#endif	
	INT8S RvsGainAttn_2G;
	INT8S RvsGainAttn_LTE;
//	INT8S RvsGainAttn_LTE_A1;
	INT8S RvsGainAttn_LTE_A2;
	INT8S RvsGainAttn_3G;
#if 0
	INT8S Rvs1GainAttn_LTE;
	INT8S Rvs1GainAttn_LTE_A1;
	INT8S Rvs1GainAttn_LTE_A2;
#endif
//	INT8U cFwdAttn_2G;
//	INT8U cFwdAttn_LTE;


	INT8U cFwdAttn_LTE_A1;
	INT8U cFwdAttn_LTE_A2;

//	INT8U cFwdAttn_LTE_A1_1;
//	INT8U cFwdAttn_LTE_A2_1;
	
//	INT8U cFwd1Attn_LTE_A1;
//	INT8U cFwd1Attn_LTE_A2;

	INT8U cRvsAttn_LTE_A1;
	INT8U cRvsAttn_LTE_A2;
//	INT8U cRvs1Attn_LTE_A1;
//	INT8U cRvs1Attn_LTE_A2;

	INT8S FwdInAlcAttn_CDMALTE;
	INT8S FwdInAlcAttn_3G;
//	INT8S FwdInAlcAttn_LTE_1;
//	INT8S FwdInAlcAttn_LTE_A1_1;
//	INT8S FwdInAlcAttn_LTE_A2_1;
	
	INT8S FwdInAlcAttn_LTE_A_0;
	INT8S FwdInAlcAttn_LTE_A_1;


//	INT8S RvsInAlcAttn_LTE_1;
	INT8S CurrRvsInPwr_LTE;

	__RBSts RB_Value;					// 0xD016
	__RBSts RB_Sts;						// 0xD017

	INT8U OverInputAGCOnOff;			// 0xD018
	INT8U RB_StsOnOff;					// 0xD019
	
//	INT16U DCOffSet;					// 0xD01C
	INT8U DCOffSet[2];					// 0xD01C

//////////////////////////////20130319
#if 0
	__SleepMode  SleepMode_2G;
	__SleepMode  SleepMode_LTE;
	__SleepMode  SleepMode_LTE_A1;
	__SleepMode  SleepMode_LTE_A2;
#endif

	
//	INT8U Sp1[1000];	
} __Dnr_Sts;


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

