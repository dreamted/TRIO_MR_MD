
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : exlib.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define ALC_C

#include "../include/main.h"

#include <stdlib.h>


void AlcInit(void)
{
	OSTaskCreate(AlcTask, (void *)NULL, (OS_STK *)&AlcTaskStk[ALC_START_STK_SIZE - 1], ALC_START_PRIO);
}


void AlcTask(void *p_arg)
{
	INT8U err = 0;
	
	(void)p_arg;

	TimerRegist(TimerLEDBlink, Time100mSec*5L);
	TimerRegist(TimerLEDInit, Time100mSec*5L);
	
	TimerRegist(TimerEnvTemp, Time1Sec);
	OSTimeDly(10L*ALC_START_PRIO);

	AlarmInitialize();

	TimerRegist(TimerULGainPriod, Time1Min);

	while(1)
	{
		if(!tTestFlag) FrontLEDDisplay();
	
		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
		{
			OSSemPend(AlcSem, 0, &err );
			ReadAdcValue();
//			ReadAdcValue_TRIO();
			FrontLEDStausUpdate(); 	//
			FrontLEDDisplay();
			OSSemPost(AlcSem);
			OSTimeDly(50*1L);
		}
		OSTimeDly(500L);
	}
}

void ReadAdcValue(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT8U AvgMAX  = 75;
	INT8U AvgMIN  = 0;
	INT16U AdcLen = __ADCAVR;

	INT16U Avg;
	INT16S tmpDect;
	
/////////////////////////////// CDMA
	{
		if(iAdcIndex == 0)
		{
			if(ADC_CheckFinish(DET0_CH123) && (AdcStep0 == 0)) 
			{
				SortSelect(ADC_AVR[DET0_CH123],0,AdcLen);
				Avg = Average_Sum(ADC_AVR[DET0_CH123],AvgMAX,AvgMIN,AdcLen);
				ADC_DATA1[_FwdOutAvgVolt_CDMALTE] = Avg;
				Sts->DetVolt.FwdOutAvgVolt_CDMALTE.Data = AdctoVolt33V(ADC_DATA1[_FwdOutAvgVolt_CDMALTE]);
				AdcStep0 = 1;
			}

			if(ADC_CheckFinish(DET1_CH123) && (AdcStep1 == 0)) 
			{
				SortSelect(ADC_AVR[DET1_CH123],0,AdcLen);
				Avg = Average_Sum(ADC_AVR[DET1_CH123],AvgMAX,AvgMIN,AdcLen);
				
				ADC_DATA1[_RvsOutVolt_CDMALTE] = Avg;
				Sts->DetVolt.RvsOutVolt_CDMALTE.Data = AdctoVolt33V(ADC_DATA1[_RvsOutVolt_CDMALTE]);
				AdcStep1 = 1;
			}	
 		}
		else if(iAdcIndex == 1)
		{
			if(ADC_CheckFinish(DET0_CH123) && (AdcStep0 == 0)) 
			{
				SortSelect(ADC_AVR[DET0_CH123],0,AdcLen);
				Avg = Average_Sum(ADC_AVR[DET0_CH123],AvgMAX,AvgMIN,AdcLen);
				
				ADC_DATA1[_FwdOutAvgVolt_LTE_A] = Avg;
				Sts->DetVolt.FwdOutAvgVolt_LTE_A.Data	= AdctoVolt33V(ADC_DATA1[_FwdOutAvgVolt_LTE_A]);
				AdcStep0 = 1;
			}
			if(ADC_CheckFinish(DET1_CH123) && (AdcStep1 == 0)) 
			{
				SortSelect(ADC_AVR[DET1_CH123],0,AdcLen);
				Avg = Average_Sum(ADC_AVR[DET1_CH123],AvgMAX,AvgMIN,AdcLen);
				
				ADC_DATA1[_RvsOutVolt_LTE_A] = Avg;
				Sts->DetVolt.RvsOutVolt_LTE_A.Data = AdctoVolt33V(ADC_DATA1[_RvsOutVolt_LTE_A]);
				AdcStep1 = 1;
			}
 		}
		else if(iAdcIndex == 2)
		{
 			if(ADC_CheckFinish(DET0_CH123) && (AdcStep0 == 0)) 
			{
				SortSelect(ADC_AVR[DET0_CH123],0,AdcLen);
				Avg = Average_Sum(ADC_AVR[DET0_CH123],AvgMAX,AvgMIN,AdcLen);
				
				ADC_DATA1[_FwdOutAvgVolt_3G] = Avg;
				Sts->DetVolt.FwdOutAvgVolt_WCDMALTE_21.Data = AdctoVolt33V(ADC_DATA1[_FwdOutAvgVolt_3G]);
				AdcStep0 = 1;
			}
			if(ADC_CheckFinish(DET1_CH123) && (AdcStep1 == 0)) 
			{
				SortSelect(ADC_AVR[DET1_CH123],0,AdcLen);
				Avg = Average_Sum(ADC_AVR[DET1_CH123],AvgMAX,AvgMIN,AdcLen);
				
				ADC_DATA1[_RvsOutVolt_3G] = Avg;
				Sts->DetVolt.RvsOutVolt_WCDMALTE_21.Data	= AdctoVolt33V(ADC_DATA1[_RvsOutVolt_3G]);
				AdcStep1 = 1;
			}
		}
		else if(iAdcIndex == 3)
		{
			if(ADC_CheckFinish(DET0_CH123) && (AdcStep0 == 0)) 
			{
				tmpDect =  SelectAverage(ADC_AVR[DET0_CH123], __EtcADCAVR);
				ADC_DATA1[Curr_Temp] = (ADC_DATA1[Curr_Temp]*3L + tmpDect)/4L;

				AdcStep0 = 1;
			}
			if(ADC_CheckFinish(DET1_CH123) && (AdcStep1 == 0)) 
			{
				INT16U CurrDCOffSet;

				tmpDect =  SelectAverage(ADC_AVR[DET1_CH123], __EtcADCAVR);
				ADC_DATA1[PSUDCVolt] = (ADC_DATA1[PSUDCVolt]*3L + tmpDect)/4L;

				CurrDCOffSet = ByteToWord(Sts->DCOffSet[0],Sts->DCOffSet[1]);

				Sts->DetVolt.PSUDCVolt.Data 	= AdctoVolt33V(ADC_DATA1[PSUDCVolt]);
				Sts->DetVolt.PSUDCVolt.Data 	= (INT16U)(Sts->DetVolt.PSUDCVolt.Data * CurrDCOffSet/1000);

				AdcStep1 = 1;
			}
		}
		if((AdcStep0 == 1)&&(AdcStep1 == 1))
		{
			if( ++iAdcIndex > 3) iAdcIndex = 0;
			ADC_Select(iAdcIndex);
			OSTimeDly(1);
			ADC_ChannelEnable(DET0_CH123);
			ADC_ChannelEnable(DET1_CH123);

			
			AdcStep0 = 0;
			AdcStep1 = 0;

		}
	}
	
	Sts->CurrentTemp = ReadEnvTempTable(ADC_DATA1[Curr_Temp])/10+ Sts->TempOffset;
}

void ReadAdcValue_TRIO(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT8U isminval = 0;
	
	INT16S tmppwrout = 0;
	INT16S tmppwrin = 0;
	INT16S CurrAttn = 0;

	Sts->DetPwr.FwdOutPwr_CDMALTE			= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_CDMALTE.Data ,Index_FwdOutAvgPwr_CDMALTE,FALSE,&isminval, Sts->DetOffset.FwdOutPwr_CDMALTE); 
	Sts->DetPwr.RvsOutPwr_CDMALTE			= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_CDMALTE.Data ,Index_RvsOutPwr_CDMALTE,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_CDMALTE); 

	Sts->DetPwr.FwdOutPwr_LTE_A				= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_LTE_A.Data ,Index_FwdOutAvgPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdOutPwr_LTE_A); 
	Sts->DetPwr.RvsOutPwr_LTE_A				= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE_A.Data ,Index_RvsOutPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_LTE_A); 

	Sts->DetPwr.FwdOutPwr_WCDMALTE_21		= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_WCDMALTE_21.Data ,Index_FwdOutAvgPwr_3G,FALSE,&isminval, Sts->DetOffset.FwdOutPwr_WCDMALTE_21); 
	Sts->DetPwr.RvsOutPwr_WCDMALTE_21 		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_WCDMALTE_21.Data ,Index_RvsOutPwr_3G,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_WCDMALTE_21); 

	{
		tmppwrout = Sts->DTUAverPower[DTU_DLAPower_800M_L].sD16/5 + DTUAGain_800M + Sts->FwdOutPwrOffset_2G;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_CDMA;

		if( tmppwrout < 0) tmppwrout = 0;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwr_2G[0] = dptr[0];
		Sts->FwdOutPwr_2G[1] = dptr[1];

		Sts->rFwdOutPwr_2G[0] = dptr[0];
		Sts->rFwdOutPwr_2G[1] = dptr[1];
		if(mFwdOutLowAlm[_PATH_800M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwr_2G[0] = 0;
			Sts->FwdOutPwr_2G[1] = 0;
		}

		tmppwrout = Sts->DTUPeakPower[DTU_DLAPower_800M_L].sD16/5 + DTUAGain_800M + Sts->FwdOutPwrOffset_2G;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_CDMA;
		if( tmppwrout < 0) tmppwrout = 0;

		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);


		Sts->rFwdOutPwrPeak_2G[0] = dptr[0];
		Sts->rFwdOutPwrPeak_2G[1] = dptr[1];
		Sts->FwdOutPwrPeak_2G[0] = dptr[0];
		Sts->FwdOutPwrPeak_2G[1] = dptr[1];
		
		if(mFwdOutLowAlm[_PATH_800M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwrPeak_2G[0] = 0;
			Sts->FwdOutPwrPeak_2G[1] = 0;
		}

		Sts->DetPwr.FwdOutPwrPeak_2G = tmppwrout;

		if((Sts->FwdOutPwr_2G[0] == 0)&&(Sts->FwdOutPwr_2G[1] == 0))
		{
			Sts->FwdInPwr_2G = NoSignal;
		}
		else
		{
			tmppwrin= Sts->DTUAverPower[DTU_DLAPower_800M_L].sD16/5 - DTUBGain_800M + Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_2G ;
			tmppwrin = tmppwrin + Sts->FwdOutPwrTemp_CDMA;
			Sts->FwdInPwr_2G = abs(tmppwrin/2) - Sts->FwdInPwrOffset_2G/2;
		}

		///GAIN= 81-ATT1-ATT2	
		Sts->FwdGain_2G = MAXGain_800M - Sts->FwdAttn1_CDMALTE - Sts->FwdAttn1_2G ;
		Sts->FwdGain_2G = MinMaxAttnCheck(Sts->FwdGain_2G, MAXGain_800M,MINGain_800M);


		{
			tmppwrout = Sts->DTUAverPower[DTU_DLAPower_800M_R].sD16/5 + DTUAGain_800M + Sts->FwdOutPwrOffset_LTE;
			tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_LTE;
			if( tmppwrout < 0) tmppwrout = 0;
			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			
			Sts->rFwdOutPwr_LTE[0] = dptr[0];
			Sts->rFwdOutPwr_LTE[1] = dptr[1];
			Sts->FwdOutPwr_LTE[0] = dptr[0];
			Sts->FwdOutPwr_LTE[1] = dptr[1];
			
			if(mFwdOutLowAlm[_PATH_800M].IsItAlarm == Alarm)
			{
				Sts->FwdOutPwr_LTE[0] = 0;
				Sts->FwdOutPwr_LTE[1] = 0;
			}

			tmppwrout = Sts->DTUPeakPower[DTU_DLAPower_800M_R].sD16/5 + DTUAGain_800M + Sts->FwdOutPwrOffset_LTE;
			tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_LTE;
			if( tmppwrout < 0) tmppwrout = 0;

			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);

			Sts->rFwdOutPwrPeak_LTE[0] = dptr[0];
			Sts->rFwdOutPwrPeak_LTE[1] = dptr[1];
			Sts->FwdOutPwrPeak_LTE[0] = dptr[0];
			Sts->FwdOutPwrPeak_LTE[1] = dptr[1];
			
			if(mFwdOutLowAlm[_PATH_800M].IsItAlarm == Alarm)
			{
				Sts->FwdOutPwrPeak_LTE[0] = 0;
				Sts->FwdOutPwrPeak_LTE[1] = 0;
			}

			Sts->DetPwr.FwdOutPwrPeak_LTE = tmppwrout;
			Sts->DetPwr.DTU_FwdOutPwr_CDMALTE = Power_Sum(Sts->rFwdOutPwr_2G,Sts->rFwdOutPwr_LTE)/5;
		}
		
		if((Sts->FwdOutPwr_LTE[0] == 0)&&(Sts->FwdOutPwr_LTE[1] == 0))
		{
			Sts->FwdInPwr_LTE = NoSignal;
		}
		else
		{
			tmppwrin= Sts->DTUAverPower[DTU_DLAPower_800M_R].sD16/5 - DTUBGain_800M + Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_LTE;
			tmppwrin = tmppwrin + Sts->FwdOutPwrTemp_LTE;
			Sts->FwdInPwr_LTE = abs(tmppwrin/2) - Sts->FwdInPwrOffset_LTE/2;
		}
		///GAIN= 81-ATT1-ATT2	
		Sts->FwdGain_LTE = MAXGain_800M - Sts->FwdAttn1_CDMALTE - Sts->FwdAttn1_LTE;
		Sts->FwdGain_LTE = MinMaxAttnCheck(Sts->FwdGain_LTE, MAXGain_800M,MINGain_800M);

 		tmppwrout			= ((Sts->DTUAverPower[DTU_DLBPower_800M].sD16/5)  - DTUBInGain_800M + Sts->FwdAttn1_CDMALTE)/2 +  Sts->DetOffset.FwdInPwr_CDMALTE;
 		Sts->DetPwr.FwdInPwr_CDMALTE 		= tmppwrout;

		tmppwrout 			= ((Sts->DTUAverPower[DTU_ULBPower_800M].sD16/5)  - DTUULBInGain_800M + Sts->RvsAttn1_CDMALTE)/2 +  Sts->DetOffset.RvsInPwr_CDMALTE;
		Sts->DetPwr.RvsInPwr_CDMALTE 		= tmppwrout;

		tmppwrout			= ((Sts->DTUAverPower[DTU_DLBPower_1800M].sD16/5) - DTUBInGain_1800M + Sts->FwdAttn1_LTE_A)/2 +  Sts->DetOffset.FwdInPwr_LTE_A;
		Sts->DetPwr.FwdInPwr_LTE_A= tmppwrout;

		tmppwrout			= ((Sts->DTUAverPower[DTU_ULBPower_1800M].sD16/5) - DTUULBInGain_1800M + Sts->FwdAttn1_LTE_A)/2 +  Sts->DetOffset.RvsInPwr_LTE_A;
		Sts->DetPwr.RvsInPwr_LTE_A = tmppwrout;

 		tmppwrout			= ((Sts->DTUAverPower[DTU_DLBPower_2100M].sD16/5) - DTUBInGain_2100M + Sts->FwdAttn1_WCDMALTE_21)/2 +  Sts->DetOffset.FwdInPwr_WCDMALTE_21;
		Sts->DetPwr.FwdInPwr_WCDMALTE_21 = tmppwrout;

		tmppwrout			= ((Sts->DTUAverPower[DTU_ULBPower_2100M].sD16/5) - DTUULBInGain_2100M + Sts->RvsAttn1_WCDMALTE_21)/2 +  Sts->DetOffset.FwdInPwr_WCDMALTE_21;
		Sts->DetPwr.RvsInPwr_WCDMALTE_21 = tmppwrout;


		tmppwrout = Sts->DTUAverPower[DTU_DLAPower_1800M_L].sD16/5 + DTUAGain_1800M + Sts->FwdOutPwrOffset_LTE_A2;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_LTE_A2;
		if( tmppwrout < 0) tmppwrout = 0;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);

		Sts->FwdOutPwr_LTE_A2[0] = dptr[0];
		Sts->FwdOutPwr_LTE_A2[1] = dptr[1];
		Sts->rFwdOutPwr_LTE_A2[0] = dptr[0];
		Sts->rFwdOutPwr_LTE_A2[1] = dptr[1];
		
		if(mFwdOutLowAlm[_PATH_1800M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwr_LTE_A2[0] = 0;
			Sts->FwdOutPwr_LTE_A2[1] = 0;
		}
		
		Sts->DetPwr.DTU_FwdOutPwr_LTE_A = tmppwrout;

		tmppwrout = Sts->DTUPeakPower[DTU_DLAPower_1800M_L].sD16/5 + DTUAGain_800M + Sts->FwdOutPwrOffset_LTE_A2;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_LTE_A2;
		if( tmppwrout < 0) tmppwrout = 0;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwrPeak_LTE_A2[0] = dptr[0];
		Sts->FwdOutPwrPeak_LTE_A2[1] = dptr[1];
		Sts->rFwdOutPwrPeak_LTE_A2[0] = dptr[0];
		Sts->rFwdOutPwrPeak_LTE_A2[1] = dptr[1];
		
		if(mFwdOutLowAlm[_PATH_1800M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwrPeak_LTE_A2[0] = 0;
			Sts->FwdOutPwrPeak_LTE_A2[1] = 0;
		}
				
		Sts->DetPwr.FwdOutPwrPeak_LTE_A2 = tmppwrout;
		
		if((Sts->FwdOutPwr_LTE_A2[0] == 0)&&(Sts->FwdOutPwr_LTE_A2[1] == 0))
		{
			Sts->FwdInPwr_LTE_A2 = NoSignal;
		}
		else
		{
			tmppwrin= Sts->DTUAverPower[DTU_DLAPower_1800M_L].sD16/5 - DTUBGain_1800M + Sts->FwdAttn1_LTE_A+ Sts->FwdAttn1_LTE_A2;
			tmppwrin = tmppwrin + Sts->FwdOutPwrTemp_LTE_A2;
			Sts->FwdInPwr_LTE_A2 = abs(tmppwrin/2) - Sts->FwdInPwrOffset_LTE_A2/2;
		}
		///GAIN= 81-ATT1-ATT2	
		Sts->FwdGain_LTE_A2 = MAXGain_1800M - Sts->FwdAttn1_LTE_A - Sts->FwdAttn1_LTE_A2;
		Sts->FwdGain_LTE_A2 = MinMaxAttnCheck(Sts->FwdGain_LTE_A2, MAXGain_1800M,MINGain_1800M);


		tmppwrout = Sts->DTUAverPower[DTU_DLAPower_2100M_L].sD16/5 + DTUAGain_2100M + Sts->FwdOutPwrOffset_LTE_21;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_LTE_21;
		if( tmppwrout < 0) tmppwrout = 0;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwr_LTE_21[0] = dptr[0];
		Sts->FwdOutPwr_LTE_21[1] = dptr[1];
		Sts->rFwdOutPwr_LTE_21[0] = dptr[0];
		Sts->rFwdOutPwr_LTE_21[1] = dptr[1];
		
		if(mFwdOutLowAlm[_PATH_2100M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwr_LTE_21[0] = 0;
			Sts->FwdOutPwr_LTE_21[1] = 0;
		}

		tmppwrout = Sts->DTUPeakPower[DTU_DLAPower_2100M_L].sD16/5 + DTUAGain_2100M + Sts->FwdOutPwrOffset_LTE_21;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_LTE_21;
		if( tmppwrout < 0) tmppwrout = 0;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwrPeak_LTE_21[0] = dptr[0];
		Sts->FwdOutPwrPeak_LTE_21[1] = dptr[1];
		Sts->rFwdOutPwrPeak_LTE_21[0] = dptr[0];
		Sts->rFwdOutPwrPeak_LTE_21[1] = dptr[1];
		
		if(mFwdOutLowAlm[_PATH_2100M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwrPeak_LTE_21[0] = 0;
			Sts->FwdOutPwrPeak_LTE_21[1] = 0;
		}		
		
		Sts->DetPwr.FwdOutPwrPeak_LTE_21 = tmppwrout;

		if((Sts->FwdOutPwr_LTE_21[0] == 0)&&(Sts->FwdOutPwr_LTE_21[1] == 0))
		{
			Sts->FwdInPwr_LTE_21 = NoSignal;
		}
		else
		{
			tmppwrin= Sts->DTUAverPower[DTU_DLAPower_2100M_L].sD16/5 - DTUBGain_1800M + Sts->FwdAttn1_WCDMALTE_21+ Sts->FwdAttn1_LTE_21;
			tmppwrin = tmppwrin + Sts->FwdOutPwrTemp_LTE_21;
			Sts->FwdInPwr_LTE_21= abs(tmppwrin/2) - Sts->FwdInPwrOffset_LTE_21/2;
		}
		Sts->FwdGain_LTE_21 = MAXGain_2100M - Sts->FwdAttn1_WCDMALTE_21 - Sts->FwdAttn1_LTE_21;
		Sts->FwdGain_LTE_21 = MinMaxAttnCheck(Sts->FwdGain_LTE_21, MAXGain_2100M,MINGain_2100M);

		tmppwrout = Sts->DTUAverPower[DTU_DLAPower_2100M_R].sD16/5 + DTUAGain_2100M + Sts->FwdOutPwrOffset_3G;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_WCDMA;
		if( tmppwrout < 0) tmppwrout = 0;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwr_3G[0] = dptr[0];
		Sts->FwdOutPwr_3G[1] = dptr[1];
		Sts->rFwdOutPwr_3G[0] = dptr[0];
		Sts->rFwdOutPwr_3G[1] = dptr[1];
		
		if(mFwdOutLowAlm[_PATH_2100M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwr_3G[0] = 0;
			Sts->FwdOutPwr_3G[1] = 0;
		}	

		tmppwrout = Sts->DTUPeakPower[DTU_DLAPower_2100M_R].sD16/5 + DTUAGain_2100M + Sts->FwdOutPwrOffset_3G;
		tmppwrout = tmppwrout + Sts->FwdOutPwrTemp_WCDMA;
		if( tmppwrout < 0) tmppwrout = 0;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwrPeak_3G[0] = dptr[0];
		Sts->FwdOutPwrPeak_3G[1] = dptr[1];
		Sts->rFwdOutPwrPeak_3G[0] = dptr[0];
		Sts->rFwdOutPwrPeak_3G[1] = dptr[1];
		
		if(mFwdOutLowAlm[_PATH_2100M].IsItAlarm == Alarm)
		{
			Sts->FwdOutPwrPeak_3G[0] = 0;
			Sts->FwdOutPwrPeak_3G[1] = 0;
		}	
		
		Sts->DetPwr.FwdOutPwrPeak_3G = tmppwrout;

		if((Sts->FwdOutPwr_3G[0] == 0)&&(Sts->FwdOutPwr_3G[1] == 0))
		{
			Sts->FwdInPwr_3G = NoSignal;
		}
		else
		{
			tmppwrin= Sts->DTUAverPower[DTU_DLAPower_2100M_R].sD16/5 - DTUBGain_1800M + Sts->FwdAttn1_WCDMALTE_21+ Sts->FwdAttn1_3G;
			tmppwrin = tmppwrin + Sts->FwdOutPwrTemp_WCDMA;
			Sts->FwdInPwr_3G = abs(tmppwrin/2) - Sts->FwdInPwrOffset_3G/2;
		}

		Sts->FwdGain_3G = MAXGain_2100M - Sts->FwdAttn1_WCDMALTE_21 - Sts->FwdAttn1_3G;
		Sts->FwdGain_3G = MinMaxAttnCheck(Sts->FwdGain_3G, MAXGain_2100M,MINGain_2100M);
		
		Sts->DetPwr.DTU_FwdOutPwr_WCDMALTE_21 = Power_Sum(Sts->rFwdOutPwr_3G,Sts->rFwdOutPwr_LTE_21)/5;
	}

	{
		tmppwrout = Sts->DTUAverPower[DTU_ULAPower_800M_L].sD16/5 + DTUULAGain + Sts->Rvs0OutPwrOffset_2G + Sts->RvsGainOffset_2G -
		(Sts->RvsAttn2_CDMALTE + Sts->RvsAttn3_CDMALTE + Sts->RvsAttn2_2G);
//		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_CDMA - (Sts->RvsGainBalance_CDMALTE * 1);
		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_CDMA;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->RvsOutPwr_2G[0] = dptr[0];
		Sts->RvsOutPwr_2G[1] = dptr[1];
		{
			tmppwrin= Sts->DTUAverPower[DTU_ULAPower_800M_L].sD16/5 - DTUBGain_800M + Sts->RvsAttn1_CDMALTE + Sts->RvsAttn1_2G +  Sts->RvsInPwrOffset[PATH_2G];
			tmppwrin = tmppwrin + Sts->RvsOutPwrTemp_CDMA;

			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_2G[0] = dptr[0];
			Sts->RvsInPwr_2G[1] = dptr[1];
		}

		CurrAttn = Sts->RvsAttn1_CDMALTE + Sts->RvsAttn2_CDMALTE + 
		Sts->RvsAttn3_CDMALTE + Sts->RvsAttn1_2G + Sts->RvsAttn2_2G;
		Sts->RvsGainSts_2G = MAXGain_800M - CurrAttn;
		Sts->RvsGainSts_2G = MinMaxAttnCheck(Sts->RvsGainSts_2G, MAXGain_800M,RvsMINGain_800M);


		tmppwrout = Sts->DTUAverPower[DTU_ULAPower_800M_R].sD16/5 + DTUULAGain + Sts->RvsOutPwrOffset_LTE + Sts->RvsGainOffset_LTE -
		(Sts->RvsAttn2_CDMALTE + Sts->RvsAttn3_CDMALTE + Sts->RvsAttn2_LTE);
//		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_LTE - (Sts->RvsGainBalance_CDMALTE * 1);
		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_LTE ;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->RvsOutPwr_LTE[0] = dptr[0];
		Sts->RvsOutPwr_LTE[1] = dptr[1];
		
		{
			tmppwrin= Sts->DTUAverPower[DTU_ULAPower_800M_R].sD16/5 - DTUBGain_800M + Sts->RvsAttn1_CDMALTE + Sts->RvsAttn1_LTE +  Sts->RvsInPwrOffset[PATH_LTE];
			tmppwrin = tmppwrin + Sts->RvsOutPwrTemp_LTE;
			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_LTE[0] = dptr[0];
			Sts->RvsInPwr_LTE[1] = dptr[1];
		}

		CurrAttn = Sts->RvsAttn1_CDMALTE + Sts->RvsAttn2_CDMALTE + 
		Sts->RvsAttn3_CDMALTE + Sts->RvsAttn1_LTE + Sts->RvsAttn2_LTE;
		Sts->RvsGainSts_LTE = MAXGain_800M - CurrAttn;
		Sts->RvsGainSts_LTE = MinMaxAttnCheck(Sts->RvsGainSts_LTE, MAXGain_800M,RvsMINGain_800M);


		tmppwrout =  (Power_Sum(Sts->RvsOutPwr_2G,Sts->RvsOutPwr_LTE)/5);
		Sts->DetPwr.DTU_RvsOutPwr_CDMALTE = tmppwrout;


		tmppwrout = Sts->DTUAverPower[DTU_ULAPower_1800M_L].sD16/5 + DTUULAGain + Sts->RvsOutPwrOffset_LTE_A2+ Sts->RvsGainOffset_LTE_A2 -
		(Sts->RvsAttn2_LTE_A + Sts->RvsAttn3_LTE_A+ Sts->RvsAttn2_LTE_A2);
//		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_LTE_A2 - (Sts->RvsGainBalance_LTE_A* 1);
		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_LTE_A2;

		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->RvsOutPwr_LTE_A2[0] = dptr[0];
		Sts->RvsOutPwr_LTE_A2[1] = dptr[1];
//		Sts->DetPwr.DTU_RvsOutPwr_LTE_A = tmppwrout;

		dptr[0] = 0;
		dptr[1] = 0;

		Sts->DetPwr.DTU_RvsOutPwr_LTE_A = Power_Sum(Sts->RvsOutPwr_LTE_A2,(INT8S *)&dptr[0])/5;

//		Ser3Ptr->printf("DTU_FwdOutPwr_CDMALTE[%d][%d]>[%d][%d]\n",Sts->RvsOutPwr_LTE_A2[0],Sts->RvsOutPwr_LTE_A2[0],Sts->DetPwr.DTU_RvsOutPwr_LTE_A,Sts->DetPwr.RvsOutPwr_LTE_A);


		
		{
			tmppwrin= Sts->DTUAverPower[DTU_ULAPower_1800M_L].sD16/5 - DTUBGain_1800M + Sts->RvsAttn1_LTE_A+ Sts->RvsAttn1_LTE_A2 + Sts->RvsInPwrOffset[PATH_LTE_A2];
			tmppwrin = tmppwrin + Sts->RvsOutPwrTemp_LTE_A2;

			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_LTE_A2[0] = dptr[0];
			Sts->RvsInPwr_LTE_A2[1] = dptr[1];
		}

		CurrAttn = Sts->RvsAttn1_LTE_A + Sts->RvsAttn2_LTE_A + 
		Sts->RvsAttn3_LTE_A + Sts->RvsAttn1_LTE_A2 + Sts->RvsAttn2_LTE_A2;
		Sts->RvsGainSts_LTE_A2 = MAXGain_1800M - CurrAttn;
		Sts->RvsGainSts_LTE_A2 = MinMaxAttnCheck(Sts->RvsGainSts_LTE_A2, MAXGain_1800M,RvsMINGain_1800M);
		
		tmppwrout = Sts->DTUAverPower[DTU_ULAPower_2100M_L].sD16/5 + DTUULAGain + Sts->RvsOutPwrOffset_LTE_21+ Sts->RvsGainOffset_LTE_21 -
		(Sts->RvsAttn2_WCDMALTE_21 + Sts->RvsAttn3_WCDMALTE_21 + Sts->RvsAttn2_LTE_21);
//		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_LTE_21 - (Sts->RvsGainBalance_WCDMALTE_21 * 1);
		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_LTE_21;

		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->RvsOutPwr_LTE_21[0] = dptr[0];
		Sts->RvsOutPwr_LTE_21[1] = dptr[1];
		{
			tmppwrin= Sts->DTUAverPower[DTU_ULAPower_2100M_L].sD16/5 - DTUBGain_2100M + Sts->RvsAttn1_WCDMALTE_21 + Sts->RvsAttn1_LTE_21 + +  Sts->RvsInPwrOffset[PATH_LTE_21];
			tmppwrin = tmppwrin + Sts->RvsOutPwrTemp_LTE_21;
			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_LTE_21[0] = dptr[0];
			Sts->RvsInPwr_LTE_21[1] = dptr[1];
		}

		CurrAttn = Sts->RvsAttn1_WCDMALTE_21 + Sts->RvsAttn2_WCDMALTE_21 + 
		Sts->RvsAttn3_WCDMALTE_21 + Sts->RvsAttn1_LTE_21 + Sts->RvsAttn2_LTE_21;
		Sts->RvsGainSts_LTE_21 = MAXGain_2100M - CurrAttn;
		Sts->RvsGainSts_LTE_21 = MinMaxAttnCheck(Sts->RvsGainSts_LTE_21, MAXGain_2100M,RvsMINGain_2100M);

		tmppwrout = Sts->DTUAverPower[DTU_ULAPower_2100M_R].sD16/5 + DTUULAGain + Sts->Rvs0OutPwrOffset_3G + Sts->RvsGainOffset_3G -
		(Sts->RvsAttn2_WCDMALTE_21 + Sts->RvsAttn3_WCDMALTE_21 + Sts->RvsAttn2_3G);
//		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_WCDMA - (Sts->RvsGainBalance_WCDMALTE_21 * 1);
		tmppwrout = tmppwrout + Sts->RvsOutPwrTemp_WCDMA;
 		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->RvsOutPwr_3G[0] = dptr[0];
		Sts->RvsOutPwr_3G[1] = dptr[1];
		{
			tmppwrin= Sts->DTUAverPower[DTU_ULAPower_2100M_R].sD16/5 - DTUBGain_2100M + Sts->RvsAttn1_WCDMALTE_21 + Sts->RvsAttn1_3G +  Sts->RvsInPwrOffset[PATH_3G];
			tmppwrin = tmppwrin + Sts->RvsOutPwrTemp_WCDMA;

			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_3G[0] = dptr[0];
			Sts->RvsInPwr_3G[1] = dptr[1];
		}
		Sts->DetPwr.DTU_RvsOutPwr_WCDMALTE_21 = Power_Sum(Sts->RvsOutPwr_3G,Sts->RvsOutPwr_LTE_21)/5;

		CurrAttn = Sts->RvsAttn1_WCDMALTE_21 + Sts->RvsAttn2_WCDMALTE_21 + 
		Sts->RvsAttn3_WCDMALTE_21 + Sts->RvsAttn1_3G + Sts->RvsAttn2_3G;
		Sts->RvsGainSts_3G = MAXGain_2100M - CurrAttn;
		Sts->RvsGainSts_3G = MinMaxAttnCheck(Sts->RvsGainSts_3G, MAXGain_2100M,RvsMINGain_2100M);
	}


/////////////////////	
//	if(Sts->ShunDownTime !=0)	Sts->FwdOutPwr_2G[0] = 22;
}

INT8S RetFWDPower(INT16S tmp)
{
	INT16S rval = (INT16S)tmp;

	tmp = rval%10;
	rval = (rval/10)*10;

	if     (tmp > 7) rval += 10;
	else if(tmp > 3) rval += 5;
	else if(tmp < -3)rval -= 5;
	else if(tmp <-7) rval -= 10;

	return (rval/5);
}

INT8S RetRVSPower(INT16S tmp)
{
	INT16S rval = (INT16S)tmp;

	tmp = rval%10;
	rval = (rval/10)*10;

	if	   (tmp > 7) rval += 10;
	else if(tmp > 3) rval += 5;
	else if(tmp < -3)rval -= 5;
	else if(tmp <-7) rval -= 10;

	return (rval/5);
}


void AGCCheckFunction(void)
{
	INT8U AmpOnOff = 0;
	INT8U AGCOnOff = 0;
	INT8U AttnMAX = 0;
	INT16S	DetValue, LmtValue;
	
	__Dnr_Sts  *Sts = tDnrSts; 

	if(Sts->AGCOnOff_CDMALTE == Enable)
	{
		if( Sts->AGCMode_2G == _AGCAvgMode)
		{
			DetValue = OneOutPwrConv(Sts->rFwdOutPwr_2G);
		}
		else
		{
			DetValue = OneOutPwrConv(Sts->rFwdOutPwrPeak_2G);
		}	

		LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_2G);
		AmpOnOff = Sts->FwdAmpOnOff_2G;
		AGCOnOff = Sts->AGCOnOff_CDMALTE;
		AttnMAX = AGCATTMAX_800M;

		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdAgcAttn_2G, AttnMAX, AmpOnOff,_AGCMode);
	}

	if(Sts->AGCOnOff_CDMALTE == Enable)
	{
		{
			if( Sts->AGCMode_LTE == _AGCAvgMode)
			{
				DetValue = OneOutPwrConv(Sts->rFwdOutPwr_LTE);
			}
			else
			{
				DetValue = OneOutPwrConv(Sts->rFwdOutPwrPeak_LTE);
			}	
		}

		LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE);
		AmpOnOff = Sts->FwdAmpOnOff_LTE;
		AGCOnOff = Sts->AGCOnOff_CDMALTE;

		
		AttnMAX = AGCATTMAX_800M;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdAgcAttn_LTE, AttnMAX, AmpOnOff,_AGCMode);
	}

#if 0
	if(TimeOverCheck(TimerAGC_3G))
	{

		TimerAGCMode_3G = SET;
		TimerRegist(TimerAGC_3G, Time100mSec*5L);
	}
#endif
	if((Sts->AGCOnOff_WCDMALTE_21 == Enable))
	{
		if( Sts->AGCMode_3G == _AGCAvgMode)
		{
			DetValue = OneOutPwrConv(Sts->rFwdOutPwr_3G);
		}
		else
		{
			DetValue = OneOutPwrConv(Sts->rFwdOutPwrPeak_3G);
		}	

		LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_3G);
		AmpOnOff = Sts->FwdAmpOnOff_3G;
		AGCOnOff = Sts->AGCOnOff_WCDMALTE_21;
		AttnMAX = AGCATTMAX_2100M;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdAgcAttn_3G, AttnMAX, AmpOnOff,_AGCMode);


	   if( Sts->AGCMode_LTE_21 == _AGCAvgMode)
	   {
		   DetValue = OneOutPwrConv(Sts->rFwdOutPwr_LTE_21);
	   }
	   else
	   {
		   DetValue = OneOutPwrConv(Sts->rFwdOutPwrPeak_LTE_21);
	   }   

	   LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE_21);
	   AmpOnOff = Sts->FwdAmpOnOff_LTE_21;
	   AGCOnOff = Sts->AGCOnOff_WCDMALTE_21;
	   AttnMAX = AGCATTMAX_2100M;
	   AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdAgcAttn_LTE_21, AttnMAX, AmpOnOff,_AGCMode);


	   TimerAGCMode_3G = RESET;
	}

	if(Sts->AGCOnOff_LTE_A_0 == Enable)
	{
		if( Sts->AGCMode_LTE_A2 == _AGCAvgMode)
		{
			DetValue = OneOutPwrConv(Sts->rFwdOutPwr_LTE_A2);
		}
		else
		{
			DetValue = OneOutPwrConv(Sts->rFwdOutPwrPeak_LTE_A2);
		}	

		LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE_A2);
		AmpOnOff = Sts->FwdAmpOnOff_LTE_A2;
		AGCOnOff = Sts->AGCOnOff_LTE_A_0;
		AttnMAX = AGCATTMAX_1800M;

		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdAgcAttn_LTE_A2, AttnMAX, AmpOnOff,_AGCMode);
	}


	DetValue = Sts->DTUAverPower[DTU_DLBPower_800M].sD16/5;
	LmtValue = OtherFwdOverInLmt_CDMALTE;
	AmpOnOff = Sts->FwdAmpOnOff_LTE;
	AGCOnOff = Sts->AGCOnOff_CDMALTE;
	AttnMAX =  25*2;
	if((Sts->FwdAmpOnOff_2G)||(Sts->FwdAmpOnOff_LTE))	 AmpOnOff = Disable;
	else												 AmpOnOff = Enable;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdInAlcAttn_CDMALTE, AttnMAX, AmpOnOff,_InputALCMode);


	DetValue = Sts->DTUAverPower[DTU_DLBPower_2100M].sD16/5;
	LmtValue = OtherFwdOverInLmt_WCDMALTE_25;
	AmpOnOff = Sts->FwdAmpOnOff_3G;
	AGCOnOff = Sts->AGCOnOff_WCDMALTE_21;
	AttnMAX =  25*2;
	if((Sts->FwdAmpOnOff_3G)||(Sts->FwdAmpOnOff_LTE_21))	 AmpOnOff = Disable;
	else													 AmpOnOff = Enable;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdInAlcAttn_WCDMALTE_21, AttnMAX, AmpOnOff,_InputALCMode);


	DetValue = Sts->DTUAverPower[DTU_DLBPower_1800M].sD16/5;
	LmtValue = OtherFwdOverInLmt_LTE_A;
	AmpOnOff = Sts->FwdAmpOnOff_LTE_A2;
	AGCOnOff = Sts->AGCOnOff_LTE_A_0;
	AttnMAX =  25*2;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->FwdInAlcAttn_LTE_A, AttnMAX, AmpOnOff,_InputALCMode);

	DetValue = Sts->DTUAverPower[DTU_ULBPower_800M].sD16/5;
	LmtValue = OtherFwdOverInLmt_CDMALTE;
	AGCOnOff = Enable;
	AttnMAX =  18*2; ///25*2
	if((Sts->FwdAmpOnOff_2G)||(Sts->FwdAmpOnOff_LTE))	 AmpOnOff = Disable;
	else												 AmpOnOff = Enable;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsInAlcAttn_CDMALTE, AttnMAX, AmpOnOff,_InputALCMode);


	DetValue = Sts->DTUAverPower[DTU_ULBPower_2100M].sD16/5;
	LmtValue = OtherFwdOverInLmt_WCDMALTE_25;
	AGCOnOff = Enable;
	AttnMAX =  24*2;
	if((Sts->FwdAmpOnOff_3G)||(Sts->FwdAmpOnOff_LTE_21))	 AmpOnOff = Disable;
	else													 AmpOnOff = Enable;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsInAlcAttn_WCDMALTE_21, AttnMAX, AmpOnOff,_InputALCMode);

	DetValue = Sts->DTUAverPower[DTU_ULBPower_1800M].sD16/5;
	LmtValue = OtherFwdOverInLmt_LTE_A;
	AmpOnOff = Sts->FwdAmpOnOff_LTE_A2;
	AGCOnOff = Enable;
	AttnMAX =  23*2;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsInAlcAttn_LTE_A, AttnMAX, AmpOnOff,_InputALCMode);
}

void ALCCheckFunction(void)
{
	INT8U AmpOnOff = 0;
	INT8U AGCOnOff = 0;
	INT8U AttnMAX = 0;
	INT16S	DetValue, LmtValue;

	__Dnr_Sts  *Sts = tDnrSts; 

	if(Sts->RvsAlcOnOff_2G == Enable)
	{
		DetValue = Sts->DTUAverPower[DTU_ULAPower_800M_L].sD16/5;
		LmtValue = Sts->RvsALCLvl_2G*2;
		AmpOnOff = Sts->FwdAmpOnOff_2G;
		AGCOnOff = Sts->RvsAlcOnOff_2G;
		AttnMAX = RVSALCATTMAX_800M;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsAlcAttn_2G, AttnMAX, AmpOnOff,_RxInputALCMode);
	}
	
	if(Sts->RvsAlcOnOff_LTE == Enable)
	{
		DetValue = Sts->DTUAverPower[DTU_ULAPower_800M_R].sD16/5;
		LmtValue = Sts->RvsALCLvl_LTE*2;
		AmpOnOff = Sts->FwdAmpOnOff_LTE;
		AGCOnOff = Sts->RvsAlcOnOff_LTE;
		AttnMAX = RVSALCATTMAX_800M;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsAlcAttn_LTE, AttnMAX, AmpOnOff,_RxInputALCMode);
	}
////
	if(Sts->RvsAlcOnOff_3G == Enable)
	{
		DetValue = Sts->DTUAverPower[DTU_ULAPower_2100M_R].sD16/5;
		LmtValue = Sts->RvsALCLvl_3G*2;
		AmpOnOff = Sts->FwdAmpOnOff_3G;
		AGCOnOff = Sts->RvsAlcOnOff_3G;
		AttnMAX = RVSALCATTMAX_2100M;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsAlcAttn_3G, AttnMAX, AmpOnOff,_RxInputALCMode);
	}

	if(Sts->RvsAlcOnOff_LTE_21 == Enable)
	{
		DetValue = Sts->DTUAverPower[DTU_ULAPower_2100M_L].sD16/5;
		LmtValue = Sts->RvsALCLvl_LTE_21*2;
		AmpOnOff = Sts->FwdAmpOnOff_LTE_21;
		AGCOnOff = Sts->RvsAlcOnOff_LTE_21;
		AttnMAX = RVSALCATTMAX_2100M;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsAlcAttn_LTE_21, AttnMAX, AmpOnOff,_RxInputALCMode);
	}

	if(Sts->RvsAlcOnOff_LTE_A2 == Enable)
	{
		DetValue = Sts->DTUAverPower[DTU_ULAPower_1800M_L].sD16/5;
		LmtValue = Sts->RvsALCLvl_LTE_A2*2;
		AmpOnOff = Sts->FwdAmpOnOff_LTE_A2;
		AGCOnOff = Sts->RvsAlcOnOff_LTE_A2;
		AttnMAX = RVSALCATTMAX_1800M;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &Sts->RvsAlcAttn_LTE_A2, AttnMAX, AmpOnOff,_RxInputALCMode);
	}
}


INT8S AGCCheck(INT32S tmpx10,INT32S tlimitLow,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax,INT8S AmpOnOff, INT8U Mode)
{
	INT32S gap;
	INT16S tmpTotAttn;
	INT8U AttMin = 0;

	tmpTotAttn = *tmpALCAttn;


	if(AmpOnOff == Disable) return tmpTotAttn;
	if(tmpOnOff != Enable) return FALSE;
	
	gap = tmpx10 - tlimitLow;

	if(abs(gap) <= 1) return FALSE;  //+/- 0.5dB

	if(Mode ==_AGCMode)
	{
		if(gap > 0)
		{
			if(gap >=  4L)			gap = gap;
			else  if(gap >=  2L)	gap = 2L;
			else					gap = 1L;
		}
		else
		{
			if	(gap < -2L)				gap = -2L;
			else						gap = -1L;
		}
		
		tmpTotAttn	+= gap;
	}

	if(Mode ==_ALCMode)
	{
		if(gap > 0)
		{
				 if(gap >=	4L) 	 gap = gap;
			else if(gap >=  2L)		gap = 2L;
			else					gap = 1L;
		}
		else
		{
			 	 if(gap <= -2L)		gap = -2L;
			else					gap = -1L;
		}
		
		tmpTotAttn	+= gap;
	}

	if(Mode ==_InputALCMode)
	{
		if(gap > 0)
		{
			  if(gap >=  2L)	gap = gap;
			else				gap = 1L;
		}
		else
		{
			if(gap <= -2L)			gap = -2L;
			else					gap = -1L;
		}
///// 20140205 추가 
//		tmpTotAttn  = gap;
		tmpTotAttn	+= gap;

	}

	if(Mode ==_RxInputALCMode)
	{
		if(gap > 0)
		{
			if(gap >=  4L)			gap = gap;
			else if(gap >=	2L) 	gap = 2L;
			else					gap = 1L;
		}
		else
		{
				 if(gap <= -2L) 	gap = -2L;
			else					gap = -1L;
		}
		
		tmpTotAttn	+= gap;
	}
	
	if(tmpTotAttn  > AttMax ) 	tmpTotAttn  = AttMax;
	if(tmpTotAttn  < AttMin ) 	tmpTotAttn  = AttMin;

	*tmpALCAttn = tmpTotAttn;

  	return tmpTotAttn;    
}


INT8U TemptoIndex(INT8S temp)
{
	INT32U i = 0;
	INT8S toffset = (TempMaxlimit - 5);

	for(i = 0; toffset < TempMaxlimit; i++, toffset -= 5)
	{
		if(temp >= toffset) return i;
	}
	
	return (i--);
}


void FrontLEDDisplay(void)
{
	INT16U i = 0;

	if(!TimeOverCheck(TimerLEDBlink)) return;
	TimerRegist(TimerLEDBlink, Time100mSec*5L);
	BlinkFlag ^= 1;

	for(i = 0; i < LED_SelMax; i++)
	{
 		switch(LEDStatus[i])
		{
        	default:
			case LEDNorON:
				switch(i)
				{
                  	case PATH_2G:
						PCA9555BitSet(GreenLED_CDMA,  &AttnCS1Val);
						PCA9555BitRst(RedLED_CDMA,  &AttnCS1Val);
					break;

					case PATH_LTE:
						PCA9555BitSet(GreenLED_LTE,  &AttnCS1Val);
						PCA9555BitRst(RedLED_LTE,  &AttnCS1Val);
					break;

                  	case PATH_3G:
						PCA9555BitSet(GreenLED_WCDMA,  &AttnCS1Val);
						PCA9555BitRst(RedLED_WCDMA,  &AttnCS1Val);
					break;

					case PATH_LTE_A2:
						PCA9555BitSet(GreenLED_LTE_A2,  &AttnCS1Val);
						PCA9555BitRst(RedLED_LTE_A2,  &AttnCS1Val);
					break;

					case PATH_LTE_21:
						PCA9555BitSet(GreenLED_LTE_21,	&AttnCS1Val);
						PCA9555BitRst(RedLED_LTE_21,  &AttnCS1Val);
					break;

				}
			break;

			case LEDNorONOFF:
				switch(i)
				{
					case PATH_2G:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_CDMA,  &AttnCS1Val);
						else 			PCA9555BitRst(GreenLED_CDMA,  &AttnCS1Val);
						PCA9555BitRst(RedLED_CDMA,  &AttnCS1Val);
					break;

					case PATH_LTE:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_LTE,  &AttnCS1Val);
						else 			PCA9555BitRst(GreenLED_LTE,  &AttnCS1Val);
						PCA9555BitRst(RedLED_LTE,  &AttnCS1Val);

					break;

					case PATH_3G:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_WCDMA,  &AttnCS1Val);
						else 			PCA9555BitRst(GreenLED_WCDMA,  &AttnCS1Val);
						PCA9555BitRst(RedLED_WCDMA,  &AttnCS1Val);
					break;

					case PATH_LTE_A2:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_LTE_A2,  &AttnCS1Val);
						else 			PCA9555BitRst(GreenLED_LTE_A2,  &AttnCS1Val);
						PCA9555BitRst(RedLED_LTE_A2,  &AttnCS1Val);
					break;	

					case PATH_LTE_21:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_LTE_21,  &AttnCS1Val);
						else 			PCA9555BitRst(GreenLED_LTE_21,  &AttnCS1Val);
						PCA9555BitRst(RedLED_LTE_21,  &AttnCS1Val);
					break;						
				}
			break;
			
			case LEDAlmON:
				switch(i)
				{
					case PATH_2G:
						PCA9555BitRst(GreenLED_CDMA,  &AttnCS1Val);
						PCA9555BitSet(RedLED_CDMA,  &AttnCS1Val);
					break;

					case PATH_LTE:
						PCA9555BitRst(GreenLED_LTE,  &AttnCS1Val);
						PCA9555BitSet(RedLED_LTE,  &AttnCS1Val);
					break;

					case PATH_3G:
						PCA9555BitRst(GreenLED_WCDMA,  &AttnCS1Val);
						PCA9555BitSet(RedLED_WCDMA,	&AttnCS1Val);
					break;

					case PATH_LTE_A2:
						PCA9555BitRst(GreenLED_LTE_A2,	&AttnCS1Val);
						PCA9555BitSet(RedLED_LTE_A2,	&AttnCS1Val);
					break;	

					case PATH_LTE_21:
						PCA9555BitRst(GreenLED_LTE_21,	&AttnCS1Val);
						PCA9555BitSet(RedLED_LTE_21,	&AttnCS1Val);
					break;
				}
			break;

			case LEDAlmONOFF:
				switch(i)
				{
					case PATH_2G:
						PCA9555BitRst(GreenLED_CDMA,  &AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_CDMA,  &AttnCS1Val);
						else 			PCA9555BitRst(RedLED_CDMA,  &AttnCS1Val);
					break;

					case PATH_LTE:
						PCA9555BitRst(GreenLED_LTE,  &AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_LTE,	&AttnCS1Val);
						else			PCA9555BitRst(RedLED_LTE,	&AttnCS1Val);
					break;

					case PATH_3G:
						PCA9555BitRst(GreenLED_WCDMA,  &AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_WCDMA,	&AttnCS1Val);
						else			PCA9555BitRst(RedLED_WCDMA,	&AttnCS1Val);
					break;

					case PATH_LTE_A2:
						PCA9555BitRst(GreenLED_LTE_A2,  &AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_LTE_A2,	&AttnCS1Val);
						else			PCA9555BitRst(RedLED_LTE_A2,	&AttnCS1Val);
					break;

					case PATH_LTE_21:
						PCA9555BitRst(GreenLED_LTE_21,  &AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_LTE_21,	&AttnCS1Val);
						else			PCA9555BitRst(RedLED_LTE_21,	&AttnCS1Val);
					break;					
				}
			break;

			case LEDNorAlmON:
				switch(i)
				{
					case PATH_2G:
						PCA9555BitSet(GreenLED_CDMA,  &AttnCS1Val);
						PCA9555BitSet(RedLED_CDMA,  &AttnCS1Val);
					break;

					case PATH_LTE:
						PCA9555BitSet(GreenLED_LTE,  &AttnCS1Val);
						PCA9555BitSet(RedLED_LTE,	&AttnCS1Val);
					break;

					case PATH_3G:
						PCA9555BitSet(GreenLED_WCDMA,	&AttnCS1Val);
						PCA9555BitSet(RedLED_WCDMA,	&AttnCS1Val);
					break;

					case PATH_LTE_A2:
						PCA9555BitSet(GreenLED_LTE_A2, &AttnCS1Val);
						PCA9555BitSet(RedLED_LTE_A2,	&AttnCS1Val);
					break;

					case PATH_LTE_21:
						PCA9555BitSet(GreenLED_LTE_21, &AttnCS1Val);
						PCA9555BitSet(RedLED_LTE_21,	&AttnCS1Val);
					break;					
				}
			break;

			
			case LEDNorAlmONOFF:
				switch(i)
				{
					case PATH_2G:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_CDMA,	&AttnCS1Val);
						else			PCA9555BitRst(GreenLED_CDMA,	&AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_CDMA,		&AttnCS1Val);
						else			PCA9555BitRst(RedLED_CDMA,		&AttnCS1Val);
					break;

					case PATH_LTE:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_LTE,	&AttnCS1Val);
						else			PCA9555BitRst(GreenLED_LTE,	&AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_LTE,	&AttnCS1Val);
						else			PCA9555BitRst(RedLED_LTE,	&AttnCS1Val);
					break;
					
					case PATH_3G:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_WCDMA,	&AttnCS1Val);
						else			PCA9555BitRst(GreenLED_WCDMA,	&AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_WCDMA,		&AttnCS1Val);
						else			PCA9555BitRst(RedLED_WCDMA,		&AttnCS1Val);
					break;

					case PATH_LTE_A2:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_LTE_A2,	&AttnCS1Val);
						else			PCA9555BitRst(GreenLED_LTE_A2,	&AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_LTE_A2,	&AttnCS1Val);
						else			PCA9555BitRst(RedLED_LTE_A2,	&AttnCS1Val);
					break;

					case PATH_LTE_21:
						if(BlinkFlag)	PCA9555BitSet(GreenLED_LTE_21,	&AttnCS1Val);
						else			PCA9555BitRst(GreenLED_LTE_21,	&AttnCS1Val);
						if(BlinkFlag)	PCA9555BitSet(RedLED_LTE_21,	&AttnCS1Val);
						else			PCA9555BitRst(RedLED_LTE_21,	&AttnCS1Val);
					break;					
				}
			break;

			case LEDAllOFF:
			switch(i)
			{
				case PATH_2G:
					PCA9555BitRst(GreenLED_CDMA,  &AttnCS1Val);
					PCA9555BitRst(RedLED_CDMA,  &AttnCS1Val);
				break;

				case PATH_LTE:
					PCA9555BitRst(GreenLED_LTE,  &AttnCS1Val);
					PCA9555BitRst(RedLED_LTE,	&AttnCS1Val);
				break;

				case PATH_3G:
					PCA9555BitRst(GreenLED_WCDMA,	&AttnCS1Val);
					PCA9555BitRst(RedLED_WCDMA,	&AttnCS1Val);
				break;

				case PATH_LTE_A2:
					PCA9555BitRst(GreenLED_LTE_A2, &AttnCS1Val);
					PCA9555BitRst(RedLED_LTE_A2,	&AttnCS1Val);
				break;	

				case PATH_LTE_21:
					PCA9555BitRst(GreenLED_LTE_21, &AttnCS1Val);
					PCA9555BitRst(RedLED_LTE_21,	&AttnCS1Val);
				break;
			}
		break;		
		}
	}
}

void FrontLEDSet(INT8U tindex, INT8U tstatus)
{
	LEDStatus[tindex%LED_SelMax] = tstatus;
}


void FrontLEDStausUpdate(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	if(!InitLedDisplay)
	{
		INT8U i;
		if(TimeOverCheck(TimerLEDInit))
		{
			InitLedStep++;
			if(InitLedStep%2) 	{for(i = 0; i < LED_SelMax; i++) FrontLEDSet(i, LEDAllOFF);}
			else 				{for(i = 0; i < LED_SelMax; i++) FrontLEDSet(i, LEDNorON);}

			if((InitLedStep >= 6)){
				InitLedDisplay = SET;
				InitLedStep = 0;
			}
			else{

			}
			TimerRegist(TimerLEDInit, Time100mSec*5L);
		}
	}
	else
	{
		if(tDnrSts->AlmSts.ACFail)
		{
			FrontLEDSet(PATH_2G, 	LEDAllOFF);
			FrontLEDSet(PATH_LTE, 	LEDAllOFF);
			FrontLEDSet(PATH_3G, 	LEDAllOFF);
			FrontLEDSet(PATH_LTE_A2, 	LEDAllOFF);
			FrontLEDSet(PATH_LTE_21, 	LEDAllOFF);

		}
		else
		{
//////CDMA
			if(((Sd_Step[SD_FI_2G]>= 2)&&(Sd_Step[SD_FI_2G]< 30))
				||((Sd_Step[SD_FO_2G]>= 2)&&(Sd_Step[SD_FO_2G]< 30))
				||((Sd_Step[SD_RO_2G]>= 2)&&(Sd_Step[SD_RO_2G]< 30)))
			{
				FrontLEDSet(PATH_2G, LEDAlmONOFF);
			}
			else if(((Sd_Step[SD_FI_2G]== 30)||(Sd_Step[SD_FO_2G]== 30)||(Sd_Step[SD_RO_2G]== 30))
				||(tDnrSts->AlmSts.FwdAmpOnOff_2G== Disable))
			{
				FrontLEDSet(PATH_2G, LEDAlmON);
			}
			else
			{

				if((tDnrSts->AlmSts.FwdOutLowerLmtFail_2G == Alarm) &&(mFwdLowAlm[PATH_2G].AlarmCnt< AlarmCheckTime)
				&&(mFwdLowAlm[PATH_2G].AlarmCnt> StartAlarmCheckTime))
				{
					FrontLEDSet(PATH_2G, LEDNorAlmONOFF);
				}
				else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_2G == Alarm) &&(mFwdLowAlm[PATH_2G].AlarmCnt == AlarmCheckTime))
					||((tDnrSts->AlmSts.OverInAlarm_CDMALTE == Alarm))
					||(tDnrSts->AlmSts.FwdInUpperLmtFail_2G == Alarm)||(tDnrSts->AlmSts.ULGainLowAlarm_CDMALTE == Alarm))
				{
					FrontLEDSet(PATH_2G, LEDNorAlmON);
				}
				else
				{
					FrontLEDSet(PATH_2G, LEDNorON);
				}
		}
/////////////LTE
			if(Sts->FemtocellUseOnOff.LTE == __NOTUSE)
			{
				if(((Sd_Step[SD_FI_LTE]>= 2)&&(Sd_Step[SD_FI_LTE]< 30))
					||((Sd_Step[SD_FO_LTE]>= 2)&&(Sd_Step[SD_FO_LTE]< 30))
					||((Sd_Step[SD_RO_LTE]>= 2)&&(Sd_Step[SD_RO_LTE]< 30)))
				{
					FrontLEDSet(PATH_LTE, LEDAlmONOFF);
				}
				else if(((Sd_Step[SD_FI_LTE]== 30)||(Sd_Step[SD_FO_LTE]== 30)||(Sd_Step[SD_RO_LTE]== 30))
					||(tDnrSts->AlmSts.FwdAmpOnOff_LTE== Disable))
				{
					FrontLEDSet(PATH_LTE, LEDAlmON);
				}
				else
				{
					if((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE == Alarm) &&(mFwdLowAlm[PATH_LTE].AlarmCnt< AlarmCheckTime)
						&&(mFwdLowAlm[PATH_LTE].AlarmCnt> StartAlarmCheckTime))
					{
						FrontLEDSet(PATH_LTE, LEDNorAlmONOFF);
					}
					else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE == Alarm) &&(mFwdLowAlm[PATH_LTE].AlarmCnt== AlarmCheckTime))
						||((tDnrSts->AlmSts.OverInAlarm_CDMALTE == Alarm))
						||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE == Alarm)||(tDnrSts->AlmSts.ULGainLowAlarm_CDMALTE == Alarm))
					{
						FrontLEDSet(PATH_LTE, LEDNorAlmON);
					}
					else
					{
						FrontLEDSet(PATH_LTE, LEDNorON);
					}
				}
			}
			else
			{
				FrontLEDSet(PATH_LTE, LEDAllOFF);
			}
	///////////////  LTE_A2
			if((Sts->FemtocellUseOnOff.LTE_A2 == __NOTUSE))
			{
				if(((Sd_Step[SD_FI_LTE_A2]>= 2)&&(Sd_Step[SD_FI_LTE_A2]< 30))
					||((Sd_Step[SD_FO_LTE_A2]>= 2)&&(Sd_Step[SD_FO_LTE_A2]< 30))
					||((Sd_Step[SD_RO_LTE_A2]>= 2)&&(Sd_Step[SD_RO_LTE_A2]< 30)))
				{
					FrontLEDSet(PATH_LTE_A2, LEDAlmONOFF);

				}
				else if(((Sd_Step[SD_FI_LTE_A2]== 30)||(Sd_Step[SD_FO_LTE_A2]== 30)||(Sd_Step[SD_RO_LTE_A2]== 30))
					||(tDnrSts->AlmSts.FwdAmpOnOff_LTE_A2== Disable))
				{
					FrontLEDSet(PATH_LTE_A2, LEDAlmON);
				}
				else
				{
					if((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A2 == Alarm) &&(mFwdLowAlm[PATH_LTE_A2].AlarmCnt< AlarmCheckTime)
					&&(mFwdLowAlm[PATH_LTE_A2].AlarmCnt> StartAlarmCheckTime))
					{
						FrontLEDSet(PATH_LTE_A2, LEDNorAlmONOFF);
					}
					else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A2 == Alarm) &&(mFwdLowAlm[PATH_LTE_A2].AlarmCnt== AlarmCheckTime))
						||((tDnrSts->AlmSts.OverInAlarm_LTE_A == Alarm))
						||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE_A2 == Alarm)||(tDnrSts->AlmSts.ULGainLowAlarm_LTEA== Alarm))
					{
						FrontLEDSet(PATH_LTE_A2, LEDNorAlmON);
					}
					else
					{
						FrontLEDSet(PATH_LTE_A2, LEDNorON);
					}
				}
			}
			else
			{
				FrontLEDSet(PATH_LTE_A2, LEDAllOFF);
			}		

	///////////////  WCDMA
			{
				if(((Sd_Step[SD_FI_3G]>= 2)&&(Sd_Step[SD_FI_3G]< 30))
					||((Sd_Step[SD_FO_3G]>= 2)&&(Sd_Step[SD_FO_3G]< 30))
					||((Sd_Step[SD_RO_3G]>= 2)&&(Sd_Step[SD_RO_3G]< 30)))
				{
					FrontLEDSet(PATH_3G, LEDAlmONOFF);
				}
				else if(((Sd_Step[SD_FI_3G]== 30)||(Sd_Step[SD_FO_3G]== 30)||(Sd_Step[SD_RO_3G]== 30))
					||(tDnrSts->AlmSts.FwdAmpOnOff_3G== Disable))
				{
					FrontLEDSet(PATH_3G, LEDAlmON);
				}
				else
				{
					if((tDnrSts->AlmSts.FwdOutLowerLmtFail_3G == Alarm) &&(mFwdLowAlm[PATH_3G].AlarmCnt< AlarmCheckTime)
					&&(mFwdLowAlm[PATH_3G].AlarmCnt> StartAlarmCheckTime))
					{
						FrontLEDSet(PATH_3G, LEDNorAlmONOFF);
					}
					else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_3G == Alarm) &&(mFwdLowAlm[PATH_3G].AlarmCnt== AlarmCheckTime))
						||(tDnrSts->AlmSts.OverInAlarm_WCDMALTE_21		== Alarm)
						||(tDnrSts->AlmSts.FwdInUpperLmtFail_3G == Alarm)||(tDnrSts->AlmSts.ULGainLowAlarm_WCDMALTE_21== Alarm))
					{
						FrontLEDSet(PATH_3G, LEDNorAlmON);
					}
					else
					{
						FrontLEDSet(PATH_3G, LEDNorON);
					}
				}
			}
	///////////////  LTE-21
			if(Sts->FemtocellUseOnOff.LTE_21 == __NOTUSE)
			{
				if(((Sd_Step[SD_FI_LTE_21]>= 2)&&(Sd_Step[SD_FI_LTE_21]< 30))
					||((Sd_Step[SD_FO_LTE_21]>= 2)&&(Sd_Step[SD_FO_LTE_21]< 30))
					||((Sd_Step[SD_RO_LTE_21]>= 2)&&(Sd_Step[SD_RO_LTE_21]< 30)))
				{
					FrontLEDSet(PATH_LTE_21, LEDAlmONOFF);
				}
				else if(((Sd_Step[SD_FI_LTE_21]== 30)||(Sd_Step[SD_FO_LTE_21]== 30)||(Sd_Step[SD_RO_LTE_21]== 30))
					||(tDnrSts->AlmSts.FwdAmpOnOff_LTE_21 == Disable))
				{
					FrontLEDSet(PATH_LTE_21, LEDAlmON);
				}
				else
				{
					if((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_21 == Alarm) &&(mFwdLowAlm[PATH_LTE_21].AlarmCnt< AlarmCheckTime)
					&&(mFwdLowAlm[PATH_LTE_21].AlarmCnt> StartAlarmCheckTime))
					{
						FrontLEDSet(PATH_LTE_21, LEDNorAlmONOFF);
					}
					else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_21 == Alarm) &&(mFwdLowAlm[PATH_LTE_21].AlarmCnt== AlarmCheckTime))
						||(tDnrSts->AlmSts.OverInAlarm_WCDMALTE_21 	== Alarm)
						||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE_21 == Alarm)||(tDnrSts->AlmSts.ULGainLowAlarm_WCDMALTE_21== Alarm))
					{
						FrontLEDSet(PATH_LTE_21, LEDNorAlmON);
					}
					else
					{
						FrontLEDSet(PATH_LTE_21, LEDNorON);
					}
				}
			}
			else
			{
				FrontLEDSet(PATH_LTE_A2, LEDAllOFF);
			}
				
		}
	}
}

void ResetCaseBackup(INT8U Cause)
{
	
	rambackup[NMS_RESET_Bp ] = Cause;
	rambackup[ResetCountBp ] = 0;
	rambackup[ResetCountBp1] = 0;
	
	rambackup[ResetOSC_Bp1] = 0;
	rambackup[ResetOSC_Bp2] = 0;

	rambackup[OSCAlarm_4GBp] = 0;
	rambackup[OSCAlarm_3GBp] = 0;
}


INT8S OneOutPwrConv(INT8S *Vaule) 
{
	INT8S dval;
	dval  = Vaule[0]*2;
	if(Vaule[0] < 0)
	{
		dval -= abs(Vaule[1])/5;
	}
	else
	{
		dval += Vaule[1]/5;
	}

	return dval;
}

void TwoOutPwrConv(INT8S *dptr, INT8S Vaule)
{
	dptr[0]	= (Vaule   )/2L ;
	dptr[1] = ((Vaule%2L)*5L) ;
}

void TwoOutPwrConvINT(INT8S *dptr, INT16S Vaule)
{
	if(Vaule <= DLLowPwrLmt)
	{
		dptr[0] = 0xFF;
		dptr[1] = 0xFF;
	}
	else
	{
		dptr[0] = (Vaule   )/2L ;
		dptr[1] = ((Vaule%2L)*5L) ;
	}
}


void ULTwoOutPwrConvINT(INT8S *dptr, INT16S Vaule)
{
	if(Vaule <= ULLowPwrLmt)
	{
		dptr[0]	= 0xFF;
		dptr[1] = 0xFF;
	}
	else
	{
		dptr[0]	= (Vaule   )/2L ;
		dptr[1] = ((Vaule%2L)*5L) ;
	}
}



void TwoOutPwrConv_INT(INT8S *dptr, INT16S Vaule)
{
	if(Vaule <= DLLowPwrLmt)
	{
		dptr[0]	= 0xFF;
		dptr[1] = 0xFF;
	}
	else
	{
		dptr[0]	= (Vaule   )/2L ;
		dptr[1] = ((Vaule%2L)*5L) ;
	}
}


void ChangeLvltoValue(INT16S CurLvl, INT16S *PreLvl, INT16S *Cnt, INT16S *Value, INT8S MaxCnt)
{
	if(*Value != CurLvl)
	{
		if(*PreLvl == CurLvl)
		{
			*Cnt = *Cnt + 1;
			if(*Cnt >= MaxCnt)
			{
				*Value = CurLvl;
				*Cnt = 0;
			}
		}
		else
		{
			*PreLvl = CurLvl;
			*Cnt = 0;
		}
	}
	else *Cnt = 0;
}

INT16S ReadPwrTableDnr(INT32U AdcValue, INT8U TblID, INT8U roundingoff, INT8U *isminval, INT16S Offset)
{
	INT8S tIndex = 0;
	INT8S tPwrLocation = 0;

	tIndex = TableIndex(TblID);
	tPwrLocation = PwrTableLocation(TblID);

	return (Dnr0_ReadPwrTable(AdcValue, tIndex, roundingoff, isminval,Offset,tPwrLocation));
}


INT16S Dnr0_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation)
{
    *isminval = FALSE;

	INT8U __1dBStep = TRUE;
	INT16S CurrPwr;

	{
		INT32S i = 0;
		INT32S j = 0;

		INT16U *dptr;
		INT32S limit;
		INT32S nsize;
		INT32S rvalx10;

 		if(tIndex == Local_FwdOutAvgPwr_CDMALTE)
		{
			dptr = OutputTable->FwdOutAvgPwr_CDMALTE.Data;
			limit = OutputTable->FwdOutAvgPwr_CDMALTE.limit;
			nsize = OutputTable->FwdOutAvgPwr_CDMALTE.nsize;
			rvalx10 = (limit/2)*10L;
		}
		else if(tIndex == Local_RvsOutPwr_CDMALTE)
		{
			dptr = OutputTable->RvsOutPwr_CDMALTE.Data;
			limit = OutputTable->RvsOutPwr_CDMALTE.limit;
			nsize = OutputTable->RvsOutPwr_CDMALTE.nsize;
			rvalx10 = (limit/2)*10L;
		}	
 		else if(tIndex == Local_FwdOutAvgPwr_LTE_A)
		{
			dptr = OutputTable->FwdOutAvgPwr_LTE_A.Data;
			limit = OutputTable->FwdOutAvgPwr_LTE_A.limit;
			nsize = OutputTable->FwdOutAvgPwr_LTE_A.nsize;
			rvalx10 = (limit/2)*10L;
		}
		else if(tIndex == Local_RvsOutPwr_LTE_A)
		{
			dptr = OutputTable->RvsOutPwr_LTE_A.Data;
			limit = OutputTable->RvsOutPwr_LTE_A.limit;
			nsize = OutputTable->RvsOutPwr_LTE_A.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_FwdOutAvgPwr_3G)
		{
			dptr = OutputTable->FwdOutAvgPwr_WCDMALTE_21.Data;
			limit = OutputTable->FwdOutAvgPwr_WCDMALTE_21.limit;
			nsize = OutputTable->FwdOutAvgPwr_WCDMALTE_21.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_RvsOutPwr_3G)
		{
			dptr = OutputTable->RvsOutPwr_WCDMALTE_21.Data;
			limit = OutputTable->RvsOutPwr_WCDMALTE_21.limit;
			nsize = OutputTable->RvsOutPwr_WCDMALTE_21.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		 


		for(i = 0; i < nsize && i < OutputTBL_Size; i++)
		{
			if(AdcValue >= dptr[i]) break;
		}

		if(i == nsize || i == OutputTBL_Size)
		{
			if(nsize != 0) i--;
			*isminval = TRUE;
		}

		if(__1dBStep)
		{
			rvalx10 = rvalx10 - (i*10L);
		}
		else
		{
			rvalx10 = rvalx10 - (i*5L);
		}

		if(i != 0 && *isminval == FALSE && __1dBStep == TRUE )
		{
			INT32U stepx10 = ((dptr[i-1] - dptr[i])*10L)/10L;
			INT32U tmp;
			
			for(j = 0; j < 10; j++)
			{
				tmp = (dptr[i]*10 + j*stepx10);
				if(tmp >= (AdcValue*10L)) break;			
			}		
			if(roundingoff == TRUE)// 반올림..
			{
				     if(j >= 8)  j = 10;
				else if(j >= 3)  j = 5;
				else			 j = 0;
			}		
		}
		
		CurrPwr = (rvalx10 + j)*2L;

		if( tPwrLocation == _FwdOutPwr_Location)		
		{
			if(!*isminval)
			{
				CurrPwr = CurrPwr/10L +  Offset;
			}
			else
			{
				CurrPwr =  LowOutPwrLmt;  // LowPwrLmt;
			}
		}
		else if( tPwrLocation == _FwdInPwr_Location)
		{
			if(!*isminval)
			{
				CurrPwr = CurrPwr/10L +  Offset;
				CurrPwr = abs(CurrPwr/2);
			}
			else
			{
				CurrPwr =  NoSignal;
			}
		}
		else if( tPwrLocation == _RvsOutPwr_Location)		
		{
			if(!*isminval)
			{
				CurrPwr = CurrPwr/10L +  Offset;
			}
			else
			{
				CurrPwr =  LowPwrLmt;
			}
		}
		else if( tPwrLocation == _RvsInPwr_Location)		
		{
			if(!*isminval)
			{
				CurrPwr = CurrPwr/10L +  Offset;
				CurrPwr = abs(CurrPwr/2);
			}
			else
			{
				CurrPwr =  RvsNoSignal;
			}
		}

		return CurrPwr;
	}
}

//=============================================================================//
// Shutdown
void AmpSd_Clear(INT8U SysPath)
{
	switch(SysPath)
	{
		case PATH_2G:
			Sd_Step[SD_FI_2G] = 0;
			Sd_Step[SD_FO_2G] = 0;
			Sd_Step[SD_RO_2G] = 0;
			Sd_Cnt[SD_FI_2G] = 0;
			Sd_Cnt[SD_FO_2G] = 0;
			Sd_Cnt[SD_RO_2G] = 0;
			Sd_Path[PATH_2G] = 0;		
		break;
		
		case PATH_3G:
			Sd_Step[SD_FI_3G] = 0;
			Sd_Step[SD_FO_3G] = 0;
			Sd_Step[SD_RO_3G] = 0;
			Sd_Cnt[SD_FI_3G] = 0;
			Sd_Cnt[SD_FO_3G] = 0;
			Sd_Cnt[SD_RO_3G] = 0;
			Sd_Path[PATH_3G] = 0;		
		break;

		case PATH_LTE:
			Sd_Step[SD_FI_LTE] = 0;
			Sd_Step[SD_FO_LTE] = 0;
			Sd_Step[SD_RO_LTE] = 0;
			Sd_Cnt[SD_FI_LTE] = 0;
			Sd_Cnt[SD_FO_LTE] = 0;
			Sd_Cnt[SD_RO_LTE] = 0;
			Sd_Path[PATH_LTE] = 0;		
		break;
			
		case PATH_LTE_A2:
			Sd_Step[SD_FI_LTE_A2] = 0;
			Sd_Step[SD_FO_LTE_A2] = 0;
			Sd_Step[SD_RO_LTE_A2] = 0;
			Sd_Cnt[SD_FI_LTE_A2] = 0;
			Sd_Cnt[SD_FO_LTE_A2] = 0;
			Sd_Cnt[SD_RO_LTE_A2] = 0;
			Sd_Path[PATH_LTE_A2] = 0;		
		break;

		case PATH_LTE_21:
			Sd_Step[SD_FI_LTE_21] = 0;
			Sd_Step[SD_FO_LTE_21] = 0;
			Sd_Step[SD_RO_LTE_21] = 0;
			Sd_Cnt[SD_FI_LTE_21] = 0;
			Sd_Cnt[SD_FO_LTE_21] = 0;
			Sd_Cnt[SD_RO_LTE_21] = 0;
			Sd_Path[PATH_LTE_21] = 0;		
		break;			
	}	
}

void AmpBitReason(INT8U SysPath, INT8U EnSts, INT8U Reason, INT8U AmpSts)
{
	__Dnr_Sts  *Sts = tDnrSts;
	
//	Ser3Ptr->printf("SysPath[%d][%d]\n", SysPath,EnSts);
	switch(SysPath)
	{
		case PATH_2G:
		case PATH_LTE:

			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_2G = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_2G = __RESET;
			Sts->AmpOffCase_2G = Reason;
			Sts->SD_Status_2G = AmpSts;
			
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE = __RESET;
			
			Sts->AmpOffCase_LTE = Reason;
			Sts->SD_Status_LTE = AmpSts;

			if( SysPath == PATH_2G)		Sts->FwdAmpOnOff_LTE = Sts->FwdAmpOnOff_2G;
			if( SysPath == PATH_LTE)	Sts->FwdAmpOnOff_2G  = Sts->FwdAmpOnOff_LTE;

			PwrAlarmTimer.FwdAmpOnOff_LTE = 25;
			PwrAlarmTimer.FwdAmpOnOff_2G = 25;
 			break;

		case PATH_3G:
		case PATH_LTE_21:
			
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_3G = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_3G = __RESET;
			Sts->AmpOffCase_3G = Reason;
			Sts->SD_Status_3G = AmpSts;

			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_21 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_21 = __RESET;
			Sts->AmpOffCase_LTE_21 = Reason;
			Sts->SD_Status_LTE_21 = AmpSts;		

			if( SysPath == PATH_3G)		Sts->FwdAmpOnOff_LTE_21 = Sts->FwdAmpOnOff_3G;
			if( SysPath == PATH_LTE_21)	Sts->FwdAmpOnOff_3G = Sts->FwdAmpOnOff_LTE_21;

			PwrAlarmTimer.FwdAmpOnOff_LTE_21 = 25;
			PwrAlarmTimer.FwdAmpOnOff_3G = 25;

	
			break;


		case PATH_LTE_A2:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __RESET;
			Sts->AmpOffCase_LTE_A2 = Reason;
			Sts->SD_Status_LTE_A2 = AmpSts;

			PwrAlarmChange.FwdAmpOnOff_LTE_A2 = 0;
			PwrAlarm.FwdAmpOnOff_LTE_A2 = 0;
 			PwrAlarmPre.FwdAmpOnOff_LTE_A2 = 0;
 			
			PwrAlarmTimer.FwdAmpOnOff_LTE_A2 = 25;
			break;
	}
}


void AlarmInitialize(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	Sts->Flag.Data[0] = 0xFF;
	Sts->Flag.Data[1] = 0xFF;
	Sts->Flag.Data[2] = 0xFF;
	Sts->Flag.Data[3] = 0xFF;
	Sts->Flag.Data[4] = 0xFF;
	Sts->Flag.Data[5] = 0xFF;
	Sts->Flag.Data[6] = 0xFF;
	Sts->Flag.Data[7] = 0xFF;
}


void ULGainLowCheack(void)
{
//	INT8U   i = 0;
	__Dnr_Sts *Sts = tDnrSts;

//	Ser3Ptr->printf("ULGainPriod[%d][%d]\n",Sts->ULGainPriod,TimeRemainCheck(TimerULGainPriod));

	if(Sts->ULGainPriod == 0x7f)
	{


	}
	else
	{
		if(TimeOverCheck(TimerULGainPriod))
		{
			ULGainPeriod = AutoTimeChk(Sts->ULGainPriod);
			TimerRegist(TimerULGainPriod, Time1Min * ULGainPeriod);
			ULGainStart = SET;
			ULGainLowInit();
		}
	}

//	Ser3Ptr->printf("ULGainStart [%d]\n",ULGainStart);
	
	if(ULGainStart)
	{
		{
			if(mULGainMode1[_PATH_800M].AlarmStep != 40)
			{
				if((Sts->FwdAmpOnOff_2G == Enable)&&(Sts->FwdAmpOnOff_LTE == Enable))
				{
					ULGainLowAlarm_mode1(_PATH_800M);
				}
			}
			else
			{
				if(mULGainMode1[_PATH_800M].ULAlarm == Alarm)
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode1_800M = Alarm;
				}
				else
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode1_800M = Normal;
				}
			}

			if(mULGainMode1[_PATH_1800M].AlarmStep != 40)
			{
				if((Sts->FwdAmpOnOff_LTEA == Enable))
				{
					ULGainLowAlarm_mode1(_PATH_1800M);
				}
			}
			else
			{
				if(mULGainMode1[_PATH_1800M].ULAlarm == Alarm)
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode1_1800M = Alarm;
				}
				else
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode1_1800M = Normal;
				}
			}	

			if(mULGainMode1[_PATH_2100M].AlarmStep != 40)
			{
				if((Sts->FwdAmpOnOff_3G == Enable)&&(Sts->FwdAmpOnOff_LTE_21 == Enable))
				{
					ULGainLowAlarm_mode1(_PATH_2100M);
				}
			}
			else
			{
				if(mULGainMode1[_PATH_2100M].ULAlarm == Alarm)
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode1_2100M = Alarm;
				}
				else
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode1_2100M = Normal;
				}
			}	
		}

		{
			if(mULGainMode2[_PATH_800M].AlarmStep != 40)
			{
				ULGainLowAlarm_mode2(_PATH_800M);
			}

			{
				if(mULGainMode2[_PATH_800M].ULAlarm == Alarm)
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode2_800M = Alarm;
				}
				else
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode2_800M = Normal;
				}
			}
			
			if(mULGainMode2[_PATH_1800M].AlarmStep != 40)
			{
				ULGainLowAlarm_mode2(_PATH_1800M);
			}

			{
				if(mULGainMode2[_PATH_1800M].ULAlarm == Alarm)
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode2_1800M = Alarm;
				}
				else
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode2_1800M = Normal;
				}
			}	

			if(mULGainMode2[_PATH_2100M].AlarmStep != 40)
			{
				ULGainLowAlarm_mode2(_PATH_2100M);
			}

			{
				if(mULGainMode2[_PATH_2100M].ULAlarm == Alarm)
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode2_2100M = Alarm;
				}
				else
				{
					tDnrSts->ModuleAlarm.Main.LowGainMode2_2100M = Normal;
				}
			}
		}
		
		if(Sts->ULGainMode == 0x00)
		{
			if((tDnrSts->ModuleAlarm.Main.LowGainMode1_800M)||(tDnrSts->ModuleAlarm.Main.LowGainMode2_800M))
			{
				Sts->AlmSts.ULGainLowAlarm_CDMALTE = Alarm;
			}
			else
			{
				Sts->AlmSts.ULGainLowAlarm_CDMALTE = Normal;
			}


			if((tDnrSts->ModuleAlarm.Main.LowGainMode1_1800M)||(tDnrSts->ModuleAlarm.Main.LowGainMode2_1800M))
			{
				Sts->AlmSts.ULGainLowAlarm_LTEA = Alarm;
			}
			else
			{
				Sts->AlmSts.ULGainLowAlarm_LTEA = Normal;
			}

			if((tDnrSts->ModuleAlarm.Main.LowGainMode1_2100M)||(tDnrSts->ModuleAlarm.Main.LowGainMode2_2100M))
			{
				Sts->AlmSts.ULGainLowAlarm_WCDMALTE_21 = Alarm;
			}
			else
			{
				Sts->AlmSts.ULGainLowAlarm_WCDMALTE_21 = Normal;
			}	
		}
		else
		{
			if((tDnrSts->ModuleAlarm.Main.LowGainMode1_800M))
			{
				Sts->AlmSts.ULGainLowAlarm_CDMALTE = Alarm;
			}
			else
			{
				Sts->AlmSts.ULGainLowAlarm_CDMALTE = Normal;
			}


			if((tDnrSts->ModuleAlarm.Main.LowGainMode1_1800M))
			{
				Sts->AlmSts.ULGainLowAlarm_LTEA = Alarm;
			}
			else
			{
				Sts->AlmSts.ULGainLowAlarm_LTEA = Normal;
			}

			if((tDnrSts->ModuleAlarm.Main.LowGainMode1_2100M))
			{
				Sts->AlmSts.ULGainLowAlarm_WCDMALTE_21 = Alarm;
			}
			else
			{
				Sts->AlmSts.ULGainLowAlarm_WCDMALTE_21 = Normal;
			}	
		}

		if((mULGainMode1[_PATH_800M].AlarmStep == 40)&&(mULGainMode1[_PATH_1800M].AlarmStep == 40)&&
			(mULGainMode1[_PATH_2100M].AlarmStep == 40)&&(mULGainMode2[_PATH_800M].AlarmStep == 40)&&
			(mULGainMode2[_PATH_1800M].AlarmStep == 40)&&(mULGainMode2[_PATH_2100M].AlarmStep == 40))
		{
			ULGainStart = RESET;
		}
	}
}


INT16S Power_Sum(INT8S *dptr,INT8S *sptr)
{
	INT16S Pwr1 = 0;
	INT16S Pwr2 = 0;
	INT16S tmp;

	if((dptr[0] == 0)&&(dptr[0] == 0)){}
	else
	{
		Pwr1 = dBmTomW(dptr[0]*10 + dptr[1]);
	}

	if((sptr[0] == 0)&&(sptr[1] == 0))
	{

	}
	else
	{
		Pwr2 = dBmTomW(sptr[0]*10 + sptr[1]);
	}


	tmp   = mWTodBm(Pwr1+ Pwr2);

	return tmp;
}



INT16S Power_Sum_Test(INT8S *dptr,INT8S *sptr)
{
	INT16S Pwr1 = 0;
	INT16S Pwr2 = 0;
	INT16S tmp;

	if((dptr[0] == 0)&&(dptr[0] == 0)){}
	else
	{
		Pwr1 = dBmTomW(dptr[0]*10 + dptr[1]);
		Ser3Ptr->printf("0 : Pwr1[%d][%d]>[%d][%d]\n",dptr[0],dptr[1],Pwr1);

	}

	if((sptr[0] == 0)&&(sptr[1] == 0))
	{

	}
	else
	{
		Pwr2 = dBmTomW(sptr[0]*10 + sptr[1]);
		
		Ser3Ptr->printf("1: Pwr2[%d][%d]>[%d][%d]\n",sptr[0],sptr[1],Pwr2);
	}

	
//	Pwr2 = dBmTomW(sptr[0]*10 + sptr[1]);

	tmp   = mWTodBm(Pwr1+ Pwr2);

	Ser3Ptr->printf("3: Pwr1[%d][%d]>[%d][%d]\n",dptr[0],dptr[1],sptr[0],sptr[1]);
	Ser3Ptr->printf("4: Pwr2[%d][%d]>[%d]\n",Pwr1,Pwr2,tmp);


	return tmp;
}



u16 dBmTomW(s16 dBm)
{
	u16 mW;

	mW = (u16)(pow(10, (float)(dBm) / 10.0 / 10.0));		// 반올림
	
//	mW = (u16)(pow(10, (float)(dBm) / 10.0 / 10.0) + 0.5);		// 반올림
//	mW = (u16)(pow(10, (float)(dBm) / 10.0 ));		// 반올림
		
	return mW;
}

INT16S mWTodBm(s16 mW)
{
	s16 dBm;

//	dBm = (s16)(log10((float)mW) * 10 * 10 + 0.5);		// 반올림
	dBm = (s16)(log10((float)mW) * 10 * 10);		// 반올림

	return dBm;
}


void ULGainLowInit(void)
{
	INT8U i;

	for(i = 0; i < 3; i++)
	{
		mULGainMode1[i].AlarmStep = 0;
		mULGainMode1[i].AlarmCnt  = 0;
		mULGainMode1[i].ULLowAlarmCnt = 0;
		mULGainMode1[i].AlarmCheck = 0;

		mULGainMode2[i].AlarmStep = 0;
		mULGainMode2[i].AlarmCnt  = 0;
		mULGainMode2[i].ULLowAlarmCnt = 0;
		mULGainMode2[i].AlarmCheck = 0;
		mULGainMode2[i].ULPwrCheckCnt = 0;
		mULGainMode2[i].ULAttCheckCnt = 0;
		mULGainMode2[i].ULGainAlarmCheck = 0;

	}
}


void ULGainLowAlarm_mode1(INT8U Path)
{
	__Dnr_Sts  *Sts = tDnrSts; 

	//---------------------------------------------------------------------//

	switch(Path)
	{
		// 2G
		case _PATH_800M:
			mULGainMode1[Path].InLmtValue 		= -95*2;

			if(Sts->DTUAverPower[DTU_ULAPower_800M_L].sD16 >= Sts->DTUAverPower[DTU_ULAPower_800M_R].sD16)
			{

				if((Sts->RvsInPwr_2G[0] == -1)&&(Sts->RvsInPwr_2G[1] == -1))
				{
					mULGainMode1[Path].InPath_Det	= ULLowPwrLmt;
				}
				else
				{
					mULGainMode1[Path].InPath_Det	= Sts->RvsInPwr_2G[0]*2;
				}
				mULGainMode1[Path].OutPath_Det = (Sts->DTUAverPower[DTU_ULAPower_800M_L].sD16/5);
			}
			else
			{
				if((Sts->RvsInPwr_LTE[0] == -1)&&(Sts->RvsInPwr_LTE[1] == -1))
				{
					mULGainMode1[Path].InPath_Det	= ULLowPwrLmt;
				}
				else
				{
					mULGainMode1[Path].InPath_Det  = Sts->RvsInPwr_LTE[0]*2;
				}

				
				mULGainMode1[Path].OutPath_Det = (Sts->DTUAverPower[DTU_ULAPower_800M_R].sD16/5);
				
			}
//			mULGainMode1[Path].OutLmtValue 	= -60*2;  					///CDMA&LTE: -60dBm 이하, LTE-A1.8: -59dBm 이하 , LTE-A2.1&WCDMA: : -59dBm 이하
			mULGainMode1[Path].OutLmtValue	= Sts->ULGainOutLmt[0]*2;  	///CDMA&LTE: -60dBm 이하, LTE-A1.8: -59dBm 이하 , LTE-A2.1&WCDMA: : -59dBm 이하
			mULGainMode1[Path].AlarmTimer 		= TimerULAlarm_800M;
			break;

		case _PATH_1800M:
			mULGainMode1[Path].InLmtValue 		= -95*2;

			if((Sts->RvsInPwr_LTE_A2[0] == -1)&&(Sts->RvsInPwr_LTE_A2[1] == -1))
			{
				mULGainMode1[Path].InPath_Det	= ULLowPwrLmt;
			}
			else
			{
				mULGainMode1[Path].InPath_Det	= Sts->RvsInPwr_LTE_A2[0]*2;
			}
			mULGainMode1[Path].OutPath_Det = (Sts->DTUAverPower[DTU_ULAPower_1800M_L].sD16/5);

//			mULGainMode1[Path].OutLmtValue 	= -58*2;  ///CDMA&LTE: -60dBm 이하, LTE-A1.8: -59dBm 이하 , LTE-A2.1&WCDMA: : -59dBm 이하
			mULGainMode1[Path].OutLmtValue	= Sts->ULGainOutLmt[1]*2;  ///CDMA&LTE: -60dBm 이하, LTE-A1.8: -59dBm 이하 , LTE-A2.1&WCDMA: : -59dBm 이하
			mULGainMode1[Path].AlarmTimer 		= TimerULAlarm_1800M;
			break;

		case _PATH_2100M:
			mULGainMode1[Path].InLmtValue 		= -95*2;

			if(Sts->DTUAverPower[DTU_ULAPower_2100M_L].sD16 >= Sts->DTUAverPower[DTU_ULAPower_2100M_R].sD16)
			{
				if((Sts->RvsInPwr_LTE_21[0] == -1)&&(Sts->RvsInPwr_LTE_21[1] == -1))
				{
					mULGainMode1[Path].InPath_Det	= ULLowPwrLmt;
				}
				else
				{
					mULGainMode1[Path].InPath_Det	= Sts->RvsInPwr_LTE_21[0]*2;
				}
				
				mULGainMode1[Path].OutPath_Det 	= (Sts->DTUAverPower[DTU_ULAPower_2100M_L].sD16/5);
				
			}
			else
			{
				if((Sts->RvsInPwr_3G[0] == -1)&&(Sts->RvsInPwr_3G[1] == -1))
				{
					mULGainMode1[Path].InPath_Det	= ULLowPwrLmt;
				}
				else
				{
					mULGainMode1[Path].InPath_Det	= Sts->RvsInPwr_3G[0]*2;
				}

				mULGainMode1[Path].OutPath_Det 	= (Sts->DTUAverPower[DTU_ULAPower_2100M_R].sD16/5);
				
			}
//			mULGainMode1[Path].OutLmtValue 	= -58*2;  ///CDMA&LTE: -60dBm 이하, LTE-A1.8: -59dBm 이하 , LTE-A2.1&WCDMA: : -59dBm 이하
			mULGainMode1[Path].OutLmtValue	= Sts->ULGainOutLmt[2]*2;  ///CDMA&LTE: -60dBm 이하, LTE-A1.8: -59dBm 이하 , LTE-A2.1&WCDMA: : -59dBm 이하
			mULGainMode1[Path].AlarmTimer 	= TimerULAlarm_2100M;
			break;
 	}
//	if( Path == _PATH_800M)	Ser3Ptr->printf("0 : Mode1 [%d]\n",mULGainMode1[Path].AlarmStep);

	switch(mULGainMode1[Path].AlarmStep)
	{
		case 0:
			mULGainMode1[Path].PathOnOff = Enable;
			mULGainMode1[Path].AlarmCnt++;
//			if( Path == _PATH_800M) Ser3Ptr->printf("0 : Step [%d][%d]>[%d]\n",mULGainMode1[Path].InPath_Det,mULGainMode1[Path].InLmtValue,mULGainMode1[Path].ULLowAlarmCnt);

			if(( mULGainMode1[Path].InPath_Det < mULGainMode1[Path].InLmtValue))
			{
				mULGainMode1[Path].ULLowAlarmCnt += 1; 
			}
			else
			{
				mULGainMode1[Path].ULLowAlarmCnt = 0; 
			}


			if((mULGainMode1[Path].AlarmCnt > 6) && mULGainMode1[Path].ULLowAlarmCnt >= 6)
			{
				mULGainMode1[Path].AlarmStep = 1;
			}
			else if(mULGainMode1[Path].AlarmCnt > 6)
			{
				TimerRegist(mULGainMode1[Path].AlarmTimer, Time1Sec*3);
				mULGainMode1[Path].AlarmStep = 10;
				if( mULGainMode1[Path].ULAlarm == Alarm)
				{
					mULGainMode1[Path].AlarmStep = 1;
				}
//				mULGainMode1[Path].AlarmStep = 1;
			}
			break;
			
		case 1:
//			if( Path == _PATH_800M) Ser3Ptr->printf("1: Step [%d][%d][%d]\n",mULGainMode1[Path].OutPath_Det,mULGainMode1[Path].OutLmtValue,mULGainMode1[Path].ULGainAlarmCheck);
			if(mULGainMode1[Path].OutPath_Det <= mULGainMode1[Path].OutLmtValue)
			{
				mULGainMode1[Path].ULGainAlarmCheck += 1;

				if(mULGainMode1[Path].ULGainAlarmCheck >= 3 )
				{
					mULGainMode1[Path].ULAlarm = Alarm; 
					mULGainMode1[Path].AlarmStep = 30;
				}
				else
				{
					mULGainMode1[Path].ULAlarm = Normal; 
					mULGainMode1[Path].AlarmStep = 10;
					TimerRegist(mULGainMode1[Path].AlarmTimer, Time1Sec*10);
				}
			}
			else
			{
				mULGainMode1[Path].ULAlarm = Normal; 
				mULGainMode1[Path].AlarmStep = 30;
			}
		break;

		case 10:
			if(!TimeOverCheck(mULGainMode1[Path].AlarmTimer)) return;

			if(++mULGainMode1[Path].AlarmCheck > 3)  // 3회 반복 후 종료 
			{
				mULGainMode1[Path].AlarmStep = 30;
			}
			else
			{
				mULGainMode1[Path].AlarmStep = 0;
			}
		break;


		case 30:	//// 종료 
			mULGainMode1[Path].PathOnOff = Disable;
			mULGainMode1[Path].AlarmStep = 40;
		break;
		
		case 40:	//// 종료 

		break;

		//---------------------------------------------------------------------//
		default :
		break;
	}
}


void ULGainLowAlarm_mode2(INT8U Path)
{
	INT16S CurrTmp = 0;
	__Dnr_Sts  *Sts = tDnrSts; 

	//---------------------------------------------------------------------//

	switch(Path)
	{
		// 2G
		case _PATH_800M:

			mULGainMode2[Path].Path0_SumAttn = Sts->RvsGainAttn_2G + Sts->RvsGainBalance_CDMALTE;
			mULGainMode2[Path].Path1_SumAttn = Sts->RvsGainAttn_LTE + Sts->RvsGainBalance_CDMALTE;
			mULGainMode2[Path].AttLmtValue = 30*2;;

			mULGainMode2[Path].OutPath0_Det	= Sts->DetPwr.DTU_RvsOutPwr_CDMALTE;
			mULGainMode2[Path].OutPath1_Det	= Sts->DetPwr.RvsOutPwr_CDMALTE;
			mULGainMode2[Path].OutLmtValue 	= 10*2;  ///CDMA&LTE: -60dBm 이하, LTE-A1.8: -59dBm 이하 , LTE-A2.1&WCDMA: : -59dBm 이하
			mULGainMode2[Path].AlarmTimer = TimerULAlarmMode2_800M;
			break;

		case _PATH_1800M:
			mULGainMode2[Path].Path0_SumAttn = Sts->RvsGainAttn_LTE_A1 + Sts->RvsGainBalance_LTE_A;
			mULGainMode2[Path].Path1_SumAttn = Sts->RvsGainAttn_LTE_A2 + Sts->RvsGainBalance_LTE_A;
			mULGainMode2[Path].AttLmtValue = 30*2;;

			mULGainMode2[Path].OutPath0_Det	= Sts->DetPwr.DTU_RvsOutPwr_LTE_A;
			mULGainMode2[Path].OutPath1_Det	= Sts->DetPwr.RvsOutPwr_LTE_A;
			mULGainMode2[Path].OutLmtValue 	= 10*2;  
			mULGainMode2[Path].AlarmTimer = TimerULAlarmMode2_1800M;
			break;

		case _PATH_2100M:
			mULGainMode2[Path].Path0_SumAttn = Sts->RvsGainAttn_3G + Sts->RvsGainBalance_WCDMALTE_21;
			mULGainMode2[Path].Path1_SumAttn = Sts->RvsGainAttn_LTE_21 + Sts->RvsGainBalance_WCDMALTE_21;
			mULGainMode2[Path].AttLmtValue = 30*2;;

			mULGainMode2[Path].OutPath0_Det	= Sts->DetPwr.DTU_RvsOutPwr_WCDMALTE_21;
			mULGainMode2[Path].OutPath1_Det	= Sts->DetPwr.RvsOutPwr_WCDMALTE_21;
			mULGainMode2[Path].OutLmtValue 	= 10*2;  
			mULGainMode2[Path].AlarmTimer = TimerULAlarmMode2_2100M;
			break;
 	}
//	SerPtr->printf("Mode2 [%d][%d]\n",Path,mULGainMode2[Path].AlarmStep);

	switch(mULGainMode2[Path].AlarmStep)
	{
		case 0:
			mULGainMode2[Path].ULAlarm = Normal;

			mULGainMode2[Path].PathOnOff = Enable;

			mULGainMode2[Path].AlarmCnt++;
			if(( mULGainMode2[Path].Path0_SumAttn < mULGainMode2[Path].AttLmtValue)&&
				( mULGainMode2[Path].Path1_SumAttn < mULGainMode2[Path].AttLmtValue))
			{
				mULGainMode2[Path].AlarmStep = 1;
			}
			else
			{
				mULGainMode2[Path].ULLowAlarmCnt = 0; 
				mULGainMode2[Path].AlarmStep = 10;

				if( ++mULGainMode2[Path].ULAttCheckCnt > 6)
				{
					mULGainMode2[Path].AlarmStep = 30;
				}				
			}
		break;

		case 1:
			if(mULGainMode2[Path].OutPath0_Det > mULGainMode2[Path].OutLmtValue)
			{
				if( ++mULGainMode2[Path].ULOutCheckCnt > 6)
				{
					mULGainMode2[Path].AlarmStep = 2;
				}
			}
			else
			{
				mULGainMode2[Path].AlarmStep = 10;
				mULGainMode2[Path].ULOutCheckCnt = 0;
				
				if( ++mULGainMode2[Path].ULPwrCheckCnt > 6)
				{
					mULGainMode2[Path].AlarmStep = 30;
				}
			}
		break;

		case 2:
			CurrTmp = mULGainMode2[Path].OutPath0_Det - mULGainMode2[Path].OutPath1_Det;

			if(abs(CurrTmp) > 15*2)
			{
				mULGainMode2[Path].AlarmStep = 10;
				mULGainMode2[Path].ULGainAlarmCheck += 1;
				
				if(mULGainMode2[Path].ULGainAlarmCheck >= 9)
				{
					mULGainMode2[Path].AlarmStep = 30;
					mULGainMode2[Path].ULAlarm = Alarm;
				}
			}
			else
			{
				mULGainMode2[Path].AlarmStep = 30;
				mULGainMode2[Path].ULGainAlarmCheck = 0;
			}
			
			if(++mULGainMode2[Path].AlarmCheck > 10)
			{
				mULGainMode2[Path].AlarmStep = 30;
			}
		break;

		case 10:
			mULGainMode2[Path].AlarmStep = 0;
		break;

		case 30:
			mULGainMode2[Path].PathOnOff = Disable;
			mULGainMode2[Path].AlarmStep = 40;
		break;

		case 40:
		break;

		default :
		break;

	}

}

void IsolationCheck(void)
{
	INT8U i;
	INT8U ISOSelect;

	if(TimeOverCheck(Timer_ISOStop))
	{
		tDnrSts->ISOOnOff = Disable;
		ChkISO = RESET;
		ISOOnOffStart = RESET;
		ISOOnOffMode = 0;
	}

	if(ChkISO)
	{
		if(ISOOnOffStart == Disable)
		{
			if(ChkISOSet == RESET)
			{
				ChkISOSet = SET;
				ISOCnt		 = 0;
				ISOStartCnt  = 0;
				ISOOnOffStart = _Disable;

				ISOSelect = tDnrSts->ISOSelect;
					 if ((tDnrSts->ISOSelect == 0x03)||(tDnrSts->ISOSelect == 0x13))	tISOSelect = 3;
				else if ((tDnrSts->ISOSelect == 0x04)||(tDnrSts->ISOSelect == 0x14))	tISOSelect = 4;
				else if ((tDnrSts->ISOSelect == 0x05)||(tDnrSts->ISOSelect == 0x15))	tISOSelect = 5;

				else																	tISOSelect = 3;

//				Ser3Ptr->printf("0 ISOSelect[%x][%d][%d]\n",tDnrSts->ISOSelect, ISOSelect,ISOOnOffMode);
				DTU_WriteData(CS0SEL, DTU_ISOPathSel, ISOSelect);
			}
			else
			{
				if( ISOCnt++ > tDnrSts->ISOStartCnt )  //// Path 절체후 대기 시간 
				{
					ISOOnOffStart = Enable;
					ISOCnt = 0;
				}
				else
				{
					ISOOnOffStart = _Disable;
				}

				if( ISOStartCnt >=	tDnrSts->ISOStartCnt )
				{
					INT16U tmp[15] ={0,};
					INT16U Avg;
//					INT8U tISOSelect;
//					INT8U Path;
//					SerPtr->printf("1 ISOCnt[%d][%d]\n",ISOCnt, ISOStartCnt);

						 if	((tDnrSts->ISOSelect == 0x03)||(tDnrSts->ISOSelect == 0x13)) 	tISOSelect = 3;
					else if	((tDnrSts->ISOSelect == 0x04)||(tDnrSts->ISOSelect == 0x14)) 	tISOSelect = 4;
					else if	((tDnrSts->ISOSelect == 0x05)||(tDnrSts->ISOSelect == 0x15)) 	tISOSelect = 5;

					else																	tISOSelect = 3;


					for(i = 0; i < tDnrSts->ISOStartCnt;i++)
					{
						tmp[i] = ISO_DATA[i].sD16;
					}


					SortSelect(tmp,0,tDnrSts->ISOStartCnt);
					Avg = Average_Sum_Test(tmp,1,9,tDnrSts->ISOStartCnt);

					ISOStartCnt = 0;

					for(i = 0; i < tDnrSts->ISOStartCnt;i++)
					{
						ISO_DATA[i].sD16  = 0;
					}

					tDnrSts->ISO[tISOSelect].sD16  = Avg;

					if((tDnrSts->AlmSts.FwdAmpOnOff_2G == Disable)&&(tDnrSts->AlmSts.FwdAmpOnOff_LTE == Disable))
					{
						tDnrSts->ISO[0].sD16 = 0;
						tDnrSts->ISO[3].sD16 = 0;
					}

					if((tDnrSts->AlmSts.FwdAmpOnOff_3G == Disable)&&(tDnrSts->AlmSts.FwdAmpOnOff_LTE_21 == Disable))
					{
						tDnrSts->ISO[2].sD16 = 0;
						tDnrSts->ISO[5].sD16 = 0;
					}

					if((tDnrSts->AlmSts.FwdAmpOnOff_LTE_A2== Disable))
					{
						tDnrSts->ISO[1].sD16 = 0;
						tDnrSts->ISO[4].sD16 = 0;
					}
					
					IsolationPathSelect(tDnrSts->ISOSelect);
					ISOConversion = SET;
					ChkISOSet = RESET;
				}
				else
				{
					ISOOnOffStart = Enable;
				}

			}

			if(ISOConversion)
			{
				tDnrSts->ISOValue_CDMALTE		= tDnrSts->ISO[3].sD16/10;
				tDnrSts->ISOValue_LTE_A 		= tDnrSts->ISO[4].sD16/10;
				tDnrSts->ISOValue_WCDMALTE_21	= tDnrSts->ISO[5].sD16/10;

				ISOConversion = RESET;

				if(ISOOnOffMode == 1)
				{
					tDnrSts->ISOOnOff = Disable;
					ChkISO = RESET;
					ISOOnOffStart = RESET;
					ISOOnOffMode = 0;
				}
			}
		}
	}
}

void IsolationPathSelect(INT8U Path)
{
	switch(Path)
	{
		case 0x03:
		case 0x13:
			if((tDnrSts->AlmSts.FwdAmpOnOff_3G == Disable)&&(tDnrSts->AlmSts.FwdAmpOnOff_LTE_21 == Disable))
			{
				if((tDnrSts->AlmSts.FwdAmpOnOff_LTE_A2== Enable))
				{
					tDnrSts->ISOSelect = 0x4;
				}
			}
			else
			{
				if(tDnrSts->AlmSts.FwdAmpOnOff_3G == Enable)
				{
					tDnrSts->ISOSelect = 0x15;
				}
				else
				{
					tDnrSts->ISOSelect = 0x05;
				}
			}
		break;

		case 0x05:
		case 0x15:
			if((tDnrSts->AlmSts.FwdAmpOnOff_LTE_A2 == Disable))
			{
				if((tDnrSts->AlmSts.FwdAmpOnOff_2G == Enable)||(tDnrSts->AlmSts.FwdAmpOnOff_LTE == Enable))
				{

					tDnrSts->ISOSelect = 0x3;
				}
			}
			else
			{
				tDnrSts->ISOSelect = 0x4;
			}
		break;

		case 0x04:
			if((tDnrSts->AlmSts.FwdAmpOnOff_2G== Disable)&&(tDnrSts->AlmSts.FwdAmpOnOff_LTE == Disable))
			{
				if((tDnrSts->AlmSts.FwdAmpOnOff_3G == Enable)||(tDnrSts->AlmSts.FwdAmpOnOff_LTE_21 == Enable))
				{
					tDnrSts->ISOSelect = 0x5;
				}
			}
			else
			{
				if(tDnrSts->AlmSts.FwdAmpOnOff_2G == Enable)
				{
					tDnrSts->ISOSelect = 0x3;
				}
				else
				{
					tDnrSts->ISOSelect = 0x13;
				}
			}
		break;

		default:
			tDnrSts->ISOSelect = 0x3;
		break;

	}
}


INT16U Average_Sum_Test(INT16U *aptr,INT16U AvgMAX, INT16U AvgMIN, INT16U nlen)
{
	INT32U sum = 0;
    int i= 0;
	for(i = AvgMIN; i < (nlen - AvgMAX); i++)
	{
		sum += aptr[i];
		Ser3Ptr->printf("1 ISO SUM [%d]:[%d][%d]\n",i,aptr[i],sum);
	}
	return sum = ((INT16U)(sum/(nlen- AvgMAX-AvgMIN)));
}


//=======================================================================//
// End of Source File
//=======================================================================//

