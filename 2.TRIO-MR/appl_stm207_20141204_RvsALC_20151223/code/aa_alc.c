
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
 
	while(1)
	{
		if(!tTestFlag) FrontLEDDisplay();
	
		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
		{
			OSSemPend(AlcSem, 0, &err );
			ReadAdcValue();
			ReadAdcValue_TRIO();
			FrontLEDStausUpdate(); 	//
			FrontLEDDisplay();
			BalanceMode();	
			OSSemPost(AlcSem);
			OSTimeDly(40*1L);
//			OSTimeDly(35*1L);
//			OSTimeDly(20*1L);
		}
		OSTimeDly(250);
	}
}


INT16U TestTable[] = {
		19,14,18,13,17,12,16,11,15,10,
	};

void ReadAdcValue(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT8U AvgMAX;
	INT8U AvgMIN;
	INT8U PeakMAX;
	INT8U PeakMIN;
	INT16U AdcLen;

	INT16U Avg, Peak;
	INT16S tmpDect;
	
/////////////////////////////// CDMA
	if(ADC_CheckFinish(DET0_CH123)) 
	{
//		RUNLEDSEL ^= 1;
		AvgMAX  = Sts->AvgMAXGARBAGE_Tx[PATH_2G];
		AvgMIN  = Sts->AvgMINGARBAGE_Tx[PATH_2G];
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_2G];	////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_2G];  ///50
		AdcLen  = __ADCAVR;

		SortSelect(ADC_AVR[DET0_CH123],0,AdcLen);
		Avg = Average_Sum(ADC_AVR[DET0_CH123],AvgMAX,AvgMIN,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET0_CH123],PeakMAX,PeakMIN,AdcLen);

		ADC_DATA1[FwdOutAvgVolt_2G] = (ADC_DATA1[FwdOutAvgVolt_2G]*1L + Avg)/2L;
		ADC_DATA1[FwdOutPeakVolt_2G] = (ADC_DATA1[FwdOutPeakVolt_2G]*1L + Peak)/2L;
		Sts->DetVolt.FwdOutAvgVolt_2G.Data	= AdctoVolt33V(ADC_DATA1[FwdOutAvgVolt_2G]);
		Sts->DetVolt.FwdOutPeakVolt_2G.Data = AdctoVolt33V(ADC_DATA1[FwdOutPeakVolt_2G]);
		ADC_ChannelEnable(DET0_CH123);
	}
	
	if(ADC_CheckFinish(DET5_CH12)) 
	{
		PeakMAX = Sts->PeakMAXGARBAGE_Rx[PATH_2G];	////10
		PeakMIN = Sts->PeakMINGARBAGE_Rx[PATH_2G];	///50
		AdcLen	= __ADCAVR;
		Peak = Average_Sum(ADC_AVR[DET5_CH12],PeakMAX,PeakMIN,AdcLen);
		
//		AdcLen	= __RvsADCAVR;
//		Peak =  SelectAverage(ADC_AVR[DET5_CH12], AdcLen);
		ADC_DATA1[RvsOutVolt_2G] = Peak;
		Sts->DetVolt.RvsOutVolt_2G.Data 				= AdctoVolt33V(ADC_DATA1[RvsOutVolt_2G]);
		Sts->BalanceModeDetVolt.BalanceVolt_CDMA.Data	= Sts->DetVolt.RvsOutVolt_2G.Data;
		ADC_ChannelEnable(DET5_CH12);
	}
/////////////////////////////// LTE
	if(ADC_CheckFinish(DET1_CH123)) 
	{
		AvgMAX	= Sts->AvgMAXGARBAGE_Tx[PATH_LTE];
		AvgMIN	= Sts->AvgMINGARBAGE_Tx[PATH_LTE];
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_LTE];	////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_LTE];	///50
		AdcLen	= __ADCAVR;
		SortSelect(ADC_AVR[DET1_CH123],0,AdcLen);
		Avg = Average_Sum(ADC_AVR[DET1_CH123],AvgMAX,AvgMIN,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET1_CH123],PeakMAX,PeakMIN,AdcLen);

		ADC_DATA1[FwdOutAvgVolt_LTE] = (ADC_DATA1[FwdOutAvgVolt_LTE]*1L + Avg)/2L;
		ADC_DATA1[FwdOutPeakVolt_LTE] = (ADC_DATA1[FwdOutPeakVolt_LTE]*1L + Peak)/2L;

		Sts->DetVolt.FwdOutAvgVolt_LTE.Data 		= AdctoVolt33V(ADC_DATA1[FwdOutAvgVolt_LTE]);
		Sts->DetVolt.FwdOutPeakVolt_LTE.Data		= AdctoVolt33V(ADC_DATA1[FwdOutPeakVolt_LTE]);
		ADC_ChannelEnable(DET1_CH123);
	}

	if(ADC_CheckFinish(DET6_CH12)) 
	{
		PeakMAX = Sts->PeakMAXGARBAGE_Rx[PATH_LTE];	////10
		PeakMIN = Sts->PeakMINGARBAGE_Rx[PATH_LTE];	///50
		AdcLen	= __ADCAVR;

		Peak = Average_Sum(ADC_AVR[DET6_CH12],PeakMAX,PeakMIN,AdcLen);
//		AdcLen	= __RvsADCAVR;
//		Peak =	SelectAverage(ADC_AVR[DET6_CH12], AdcLen);

		ADC_DATA1[RvsOutVolt_LTE] = Peak;
		Sts->DetVolt.RvsOutVolt_LTE.Data			= AdctoVolt33V(ADC_DATA1[RvsOutVolt_LTE]);
		
		Sts->BalanceModeDetVolt.BalanceVolt_LTE.Data	= Sts->DetVolt.RvsOutVolt_LTE.Data;
		ADC_ChannelEnable(DET6_CH12);
	}
	
	if(ADC_CheckFinish(DET9_CH12)) 
	{
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_LTE];	////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_LTE];	///50
		AdcLen	= __ADCAVR;

		SortSelect(ADC_AVR[DET9_CH12],0,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET9_CH12],PeakMAX,PeakMIN,AdcLen);

 //			ADC_DATA1[FwdInVolt_CDMALTE] = Peak;
#if 1	////20140204 추가 
		ADC_DATA1[FwdInVolt_CDMALTE] = (ADC_DATA1[FwdInVolt_CDMALTE]*3L + Peak)/4L;
#endif		////			

		Sts->DetVolt.FwdInVolt_CDMALTE.Data = AdctoVolt33V(ADC_DATA1[FwdInVolt_CDMALTE]);
		ADC_ChannelEnable(DET9_CH12);
	}

//////////CDMA LTE
	if(ADC_CheckFinish(DET2_CH123)) 
	{
		AvgMAX	= Sts->AvgMAXGARBAGE_Tx[PATH_LTE];
		AvgMIN	= Sts->AvgMINGARBAGE_Tx[PATH_LTE];
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_LTE]; ////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_LTE]; ///50
		AdcLen	= __ADCAVR;
		SortSelect(ADC_AVR[DET2_CH123],0,AdcLen);
		Avg = Average_Sum(ADC_AVR[DET2_CH123],AvgMAX,AvgMIN,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET2_CH123],PeakMAX,PeakMIN,AdcLen);

		ADC_DATA1[FwdOutAvgVolt_CDMALTE] = (ADC_DATA1[FwdOutAvgVolt_CDMALTE]*1L + Avg)/2L;
		ADC_DATA1[FwdOutPeakVolt_CDMALTE] = (ADC_DATA1[FwdOutPeakVolt_CDMALTE]*1L + Peak)/2L;

		Sts->DetVolt.FwdOutAvgVolt_CDMALTE.Data 	= AdctoVolt33V(ADC_DATA1[FwdOutAvgVolt_CDMALTE]);
		Sts->DetVolt.FwdOutPeakVolt_CDMALTE.Data	= AdctoVolt33V(ADC_DATA1[FwdOutPeakVolt_CDMALTE]);
		ADC_ChannelEnable(DET2_CH123);
	}
	
/////////////////////////////// 3G
	if(ADC_CheckFinish(DET3_CH123)) 
	{
		AvgMAX	= Sts->AvgMAXGARBAGE_Tx[PATH_3G];
		AvgMIN	= Sts->AvgMINGARBAGE_Tx[PATH_3G];
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_3G]; ////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_3G]; ///50
		AdcLen	= __ADCAVR;
		SortSelect(ADC_AVR[DET3_CH123],0,AdcLen);
		Avg = Average_Sum(ADC_AVR[DET3_CH123],AvgMAX,AvgMIN,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET3_CH123],PeakMAX,PeakMIN,AdcLen);

		ADC_DATA1[FwdOutAvgVolt_3G] 	= Avg;
		ADC_DATA1[FwdOutPeakVolt_3G]	= Peak;

		Sts->DetVolt.FwdOutAvgVolt_3G.Data			= AdctoVolt33V(ADC_DATA1[FwdOutAvgVolt_3G]);
		Sts->DetVolt.FwdOutPeakVolt_3G.Data 		= AdctoVolt33V(ADC_DATA1[FwdOutPeakVolt_3G]);
		ADC_ChannelEnable(DET3_CH123);
	}

	if(ADC_CheckFinish(DET7_CH12)) 
	{
		PeakMAX = Sts->PeakMAXGARBAGE_Rx[PATH_3G];	////10
		PeakMIN = Sts->PeakMINGARBAGE_Rx[PATH_3G];	///50
		AdcLen	= __ADCAVR;

		Peak = Average_Sum(ADC_AVR[DET7_CH12],PeakMAX,PeakMIN,AdcLen);

//		AdcLen	= __RvsADCAVR;
//		Peak =	SelectAverage(ADC_AVR[DET7_CH12], AdcLen);
		ADC_DATA1[RvsOutVolt_3G] = Peak;
		Sts->DetVolt.RvsOutVolt_3G.Data 						= AdctoVolt33V(ADC_DATA1[RvsOutVolt_3G]);
		Sts->BalanceModeDetVolt.BalanceVolt_WCDMA.Data			= Sts->DetVolt.RvsOutVolt_3G.Data;
		ADC_ChannelEnable(DET7_CH12);
	}

	if(ADC_CheckFinish(DET10_CH123)) 
	{
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_3G]; ////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_3G]; ///50
		AdcLen	= __ADCAVR;
		SortSelect(ADC_AVR[DET10_CH123],0,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET10_CH123],PeakMAX,PeakMIN,AdcLen);

		ADC_DATA1[FwdInVolt_3G] = Peak;
		Sts->DetVolt.FwdInVolt_3G.Data	= AdctoVolt33V(ADC_DATA1[FwdInVolt_3G]);
		ADC_ChannelEnable(DET10_CH123);
	}

	/////////////////////////////// LTEA
	if(ADC_CheckFinish(DET4_CH12)) 
	{
		AvgMAX	= Sts->AvgMAXGARBAGE_Tx[PATH_LTEA];
		AvgMIN	= Sts->AvgMINGARBAGE_Tx[PATH_LTEA];
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_LTEA]; ////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_LTEA]; ///50
		AdcLen	= __ADCAVR;

		SortSelect(ADC_AVR[DET4_CH12],0,AdcLen);
		Avg = Average_Sum(ADC_AVR[DET4_CH12],AvgMAX,AvgMIN,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET4_CH12],PeakMAX,PeakMIN,AdcLen);

		ADC_DATA1[FwdOutAvgVolt_LTE_A2]  = (ADC_DATA1[FwdOutAvgVolt_LTE_A2]*1L + Avg)/2L;
		ADC_DATA1[FwdOutPeakVolt_LTE_A2] = (ADC_DATA1[FwdOutPeakVolt_LTE_A2]*1L + Peak)/2L;
		
		Sts->DetVolt.FwdOutAvgVolt_LTE_A2.Data		= AdctoVolt33V(ADC_DATA1[FwdOutAvgVolt_LTE_A2]);
		Sts->DetVolt.FwdOutPeakVolt_LTE_A2.Data 	= AdctoVolt33V(ADC_DATA1[FwdOutPeakVolt_LTE_A2]);
		ADC_ChannelEnable(DET4_CH12);
	}

	if(ADC_CheckFinish(DET8_CH12)) 
	{
		PeakMAX = Sts->PeakMAXGARBAGE_Rx[PATH_LTEA];	////10
		PeakMIN = Sts->PeakMINGARBAGE_Rx[PATH_LTEA];	///50
		AdcLen	= __ADCAVR;

		Peak = Average_Sum(ADC_AVR[DET8_CH12],PeakMAX,PeakMIN,AdcLen);

//		AdcLen	= __RvsADCAVR;
//		Peak =	SelectAverage(ADC_AVR[DET8_CH12], AdcLen);

		ADC_DATA1[RvsOutVolt_LTE_A2] = Peak;
		Sts->DetVolt.RvsOutVolt_LTE_A2.Data 		= AdctoVolt33V(ADC_DATA1[RvsOutVolt_LTE_A2]);
		Sts->BalanceModeDetVolt.BalanceVolt_LTE_A.Data	= Sts->DetVolt.RvsOutVolt_LTE_A2.Data;
		ADC_ChannelEnable(DET8_CH12);
	}

	if(ADC_CheckFinish(DET11_CH123)) 
	{
		PeakMAX = Sts->PeakMAXGARBAGE_Tx[PATH_LTEA]; ////10
		PeakMIN = Sts->PeakMINGARBAGE_Tx[PATH_LTEA]; ///50
		AdcLen	= __ADCAVR;

		SortSelect(ADC_AVR[DET11_CH123],0,AdcLen);
		Peak = Average_Sum(ADC_AVR[DET11_CH123],PeakMAX,PeakMIN,AdcLen);

		ADC_DATA1[FwdInVolt_LTE_A] = Peak;
		Sts->DetVolt.FwdInVolt_LTE_A.Data = AdctoVolt33V(ADC_DATA1[FwdInVolt_LTE_A]);
		ADC_ChannelEnable(DET11_CH123);
	}
#if 0	
	SerPtr->printf("AdcStep :%0d,%0d,%0d\n", AdcStep0, AdcStep1,iAdcIndex);

	if((AdcStep0 == 1)&&(AdcStep1 == 1))
	{
		if( AdcCheck == 0)
		{
			AdcCheck = 1;
			AdcStep0 = 0;
			AdcStep1 = 0;
			if( ++iAdcIndex > 2) iAdcIndex = 0;
			
			ADC_Select(iAdcIndex);
		}
		else if( AdcCheck == 1)
		{
			ADC_ChannelEnable(ADC_Channel_12);
			AdcCheck = 2;
		}
		else if( AdcCheck == 2)
		{
			ADC_ChannelEnable(ADC_Channel_13);
 			AdcCheck = 0;
		}
		else
		{
			AdcCheck = 0;
		}
 	}
#endif

	{
//		SerPtr->printf("AdcStep :%0d,%0d,%0d\n", AdcStep0, AdcStep1,iAdcIndex);

		AdcLen	= __RvsADCAVR;
		if(iAdcIndex == 0)
		{
			if(ADC_CheckFinish(DET12_CH123) && (AdcStep0 == 0)) 
			{
				Peak =	SelectAverage(ADC_AVR[DET12_CH123], AdcLen);
				ADC_DATA1[RvsInVolt_CDMALTE] = Peak;
				Sts->DetVolt.RvsInVolt_CDMALTE.Data = AdctoVolt33V(ADC_DATA1[RvsInVolt_CDMALTE]);
				AdcStep0 = 1;
			}

			if(ADC_CheckFinish(DET13_CH123) && (AdcStep1 == 0)) 
			{
				Peak =	SelectAverage(ADC_AVR[DET13_CH123], AdcLen);
				ADC_DATA1[RvsOutVolt_CDMALTE] = Peak;
				Sts->DetVolt.RvsOutVolt_CDMALTE.Data = AdctoVolt33V(ADC_DATA1[RvsOutVolt_CDMALTE]);
				AdcStep1 = 1;
			}	
			
//			SerPtr->printf("Adc[%0d],%0d,%0d\n",iAdcIndex, ADC_DATA1[RvsInVolt_CDMALTE], ADC_DATA1[RvsOutVolt_CDMALTE]);
 		}
		else if(iAdcIndex == 1)
		{
#if 1//// 사용하지 않음
			if(ADC_CheckFinish(DET12_CH123) && (AdcStep0 == 0)) 
			{
				Peak =	SelectAverage(ADC_AVR[DET12_CH123], AdcLen);
				ADC_DATA1[RvsInVolt_3G] = Peak;
				Sts->DetVolt.RvsInVolt_3G.Data	= AdctoVolt33V(ADC_DATA1[RvsInVolt_3G]);
				AdcStep0 = 1;
			}
#endif			
			if(ADC_CheckFinish(DET13_CH123) && (AdcStep1 == 0)) 
			{
				Peak =	SelectAverage(ADC_AVR[DET13_CH123], AdcLen);
				ADC_DATA1[RvsOutVolt_LTE_A1] = Peak;
				Sts->DetVolt.RvsOutVolt_LTE_A1.Data = AdctoVolt33V(ADC_DATA1[RvsOutVolt_LTE_A1]);
				AdcStep1 = 1;
			}
			
//			SerPtr->printf("Adc[%0d],%0d,%0d\n",iAdcIndex, ADC_DATA1[RvsInVolt_3G], ADC_DATA1[RvsOutVolt_LTE_A1]);
 		}
		else if(iAdcIndex == 2)
		{
#if 1//// 사용하지 않음
 			if(ADC_CheckFinish(DET12_CH123) && (AdcStep0 == 0)) 
			{
				Peak =	SelectAverage(ADC_AVR[DET12_CH123], AdcLen);
				ADC_DATA1[RvsInVolt_LTE_A] = Peak;
				Sts->DetVolt.RvsInVolt_LTE_A.Data = AdctoVolt33V(ADC_DATA1[RvsInVolt_LTE_A]);
				AdcStep0 = 1;
			}
#endif
			if(ADC_CheckFinish(DET13_CH123) && (AdcStep1 == 0)) 
			{
				Peak =	SelectAverage(ADC_AVR[DET13_CH123], AdcLen);
				ADC_DATA1[RvsOutVolt_LTE_A] = Peak;
				Sts->DetVolt.RvsOutVolt_LTE_A.Data	= AdctoVolt33V(ADC_DATA1[RvsOutVolt_LTE_A]);
				AdcStep1 = 1;
			}
			
//			SerPtr->printf("Adc[%0d],%0d,%0d\n",iAdcIndex, ADC_DATA1[RvsInVolt_LTE_A], ADC_DATA1[RvsOutVolt_LTE_A]);
		}

#if 1
	
		if((AdcStep0 == 1)&&(AdcStep1 == 1))
		{
			if( ++iAdcIndex > 2) iAdcIndex = 0;
			ADC_Select(iAdcIndex);
			OSTimeDly(1);
			ADC_ChannelEnable(ADC_Channel_12);
			ADC_ChannelEnable(ADC_Channel_13);

			
			AdcStep0 = 0;
			AdcStep1 = 0;

			#if 0
			if( AdcCheck == 0)
			{
				AdcCheck = 1;
				AdcStep0 = 0;
				AdcStep1 = 0;
				if( ++iAdcIndex > 2) iAdcIndex = 0;
				ADC_Select(iAdcIndex);
			}
			else if( AdcCheck == 1)
			{
				ADC_ChannelEnable(ADC_Channel_12);
				AdcCheck = 2;
			}
			else if( AdcCheck == 2)
			{
				ADC_ChannelEnable(ADC_Channel_13);
				AdcCheck = 0;
			}
			else
			{
				AdcCheck = 0;
			}
			#endif
		}
//		SerPtr->printf("-------\n");
#endif

		
	}

	if(TimeOverCheck(TimerEnvTemp))
	{
		AdcLen	= __EtcADCAVR;

		if(ADC_CheckFinish(adcEnvTemp)){
			
			tmpDect =  SelectAverage(ADC_AVR[DET15_CH12], AdcLen);
			ADC_DATA1[Curr_Temp] = (ADC_DATA1[Curr_Temp]*3L + tmpDect)/4L;
			ADC_ChannelEnable(DET15_CH12);
		}

		if(ADC_CheckFinish(DET14_CH12)) 
		{
			INT16U CurrDCOffSet;
			AdcLen	= __EtcADCAVR;

			tmpDect =  SelectAverage(ADC_AVR[DET14_CH12], AdcLen);
			ADC_DATA1[PSUDCVolt] = (ADC_DATA1[PSUDCVolt]*2L + tmpDect)/3L;
			CurrDCOffSet = ByteToWord(Sts->DCOffSet[0],Sts->DCOffSet[1]);
	
			Sts->DetVolt.PSUDCVolt.Data 	= AdctoVolt33V(ADC_DATA1[PSUDCVolt]);
			Sts->DetVolt.PSUDCVolt.Data 	= (INT16U)(Sts->DetVolt.PSUDCVolt.Data * CurrDCOffSet/1000);
			ADC_ChannelEnable(DET14_CH12);
		}
		TimerRegist(TimerEnvTemp, Time1Sec);
	}
	
	Sts->CurrentTemp = ReadEnvTempTable(ADC_DATA1[Curr_Temp])/10+ Sts->TempOffset;
}

void ReadAdcValue_TRIO(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT16S tmpx10 = 0;

	INT8U isminval = 0;
	INT16S tmppwrin = 0;
	INT16S tmppwrout = 0;

	 // CDMA LTE
	{
		Sts->DetPwr.FwdInPwr_CDMALTE 		= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_CDMALTE.Data ,Index_FwdInPwr_CDMALTE,FALSE,&isminval, Sts->DetOffset.FwdInPwr_CDMALTE); 
		Sts->DetPwr.FwdOutAvgPwr_CDMALTE 	= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_CDMALTE.Data ,Index_FwdOutAvgPwr_CDMALTE,FALSE,&isminval, Sts->DetOffset.FwdOutAvgPwr_CDMALTE); 
		Sts->DetPwr.FwdOutPeakPwr_CDMALTE 	= ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_CDMALTE.Data ,Index_FwdOutAvgPwr_CDMALTE,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_CDMALTE); 
		Sts->DetPwr.RvsInPwr_CDMALTE 		= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_CDMALTE.Data ,Index_RvsInPwr_CDMALTE,FALSE,&isminval, Sts->DetOffset.RvsInPwr_CDMALTE); 
		Sts->DetPwr.RvsOutPwr_CDMALTE 		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_CDMALTE.Data ,Index_RvsOutPwr_CDMALTE,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_CDMALTE); 
	}

	// CDMA
 	{

		Sts->DetPwr.FwdOutAvgPwr_2G = ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_2G.Data ,Index_FwdOutAvgPwr_2G,FALSE,&isminval, Sts->FwdOutPwrOffset_2G);	
		Sts->DetPwr.FwdOutPeakPwr_2G = ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_2G.Data ,Index_FwdOutAvgPwr_2G,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_2G); 

		if(Sts->LTE15MUse == __NOTUSE)
		{
			Sts->DetPwr.RvsOutPwr_2G = ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_2G.Data ,Index_RvsOutPwr_2G,FALSE,&isminval, Sts->Rvs0OutPwrOffset_2G);
		}
		else
		{
			Sts->DetPwr.RvsOutPwr_2G = ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_2G.Data ,Index_RvsOutPwr_2G,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_2G);
		}

		// 	 출력=DET2  CDMA Fwd 출력 Avg Det
		tmppwrout = Sts->DetPwr.FwdOutAvgPwr_2G;
		TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwr_2G[0] = dptr[0];
		Sts->FwdOutPwr_2G[1] = dptr[1];
		
		tmpx10 = Sts->DetPwr.FwdOutPeakPwr_2G;
		TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
		Sts->FwdOutPwrPeak_2G[0] = dptr[0];
		Sts->FwdOutPwrPeak_2G[1] = dptr[1];

		// 	입력=DET2-81+ATT1+ATT2
		if( Sts->DetPwr.FwdOutAvgPwr_2G == 0)
		{
			Sts->FwdInPwr_2G = NoSignal;
		}
		else
		{
			tmppwrin= tmppwrout - Gain_2G + Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_2G ;
			Sts->FwdInPwr_2G = abs(tmppwrin/2) - Sts->FwdInPwrOffset_2G/2;
		}

		///GAIN= 81-ATT1-ATT2	
		Sts->FwdGain_2G = Gain_2G - Sts->FwdAttn1_CDMALTE - Sts->FwdAttn1_2G ;
		Sts->FwdGain_2G = MinMaxAttnCheck(Sts->FwdGain_2G, Gain_2G,FwdMinGain_2G);


		if(tDnrSts->LTE15MUse == __NOTUSE)
		{

			// RVS 출력= DET10-RVS AGC ATT
			tmppwrout = Sts->DetPwr.RvsOutPwr_2G - CurrRvsAlcAttn_2G;
			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			Sts->RvsOutPwr_2G[0] = dptr[0];
			Sts->RvsOutPwr_2G[1] = dptr[1];

			// RVS 입력= DET10-81+RVS ALC ATT
			tmppwrin = Sts->DetPwr.RvsOutPwr_2G - Gain_2G + Sts->RvsAlcAttn_2G;
			Sts->RealRvsInPwr_2G = tmppwrin;

 			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_2G[0] = dptr[0];
			Sts->RvsInPwr_2G[1] = dptr[1];
		}

		// GAIN = 81 - RVS AGC ATT - RVS ALC ATT
		Sts->RvsGainSts_2G = Gain_2G - CurrRvsAlcAttn_2G - Sts->RvsAlcAttn_2G ;
		Sts->RvsGainSts_2G = MinMaxAttnCheck(Sts->RvsGainSts_2G, Gain_2G,RvsMinGain_2G);
		if(Sts->AlmSts.FwdAmpOnOff_2G == Disable) 	Sts->FwdInPwr_2G = NoSignal;
	}

	// LTE
	{
		Sts->DetPwr.FwdOutAvgPwr_LTE = ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_LTE.Data ,Index_FwdOutAvgPwr_LTE,FALSE,&isminval, Sts->FwdOutPwrOffset_LTE);
		Sts->DetPwr.FwdOutPeakPwr_LTE = ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_LTE.Data ,Index_FwdOutAvgPwr_LTE,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_LTE); 

		if(Sts->LTE15MUse == __NOTUSE)
		{
			Sts->DetPwr.RvsOutPwr_LTE = ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE.Data ,Index_RvsOutPwr_LTE,FALSE,&isminval, Sts->RvsOutPwrOffset_LTE);
		}
		else
		{
			Sts->DetPwr.RvsOutPwr_LTE = ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE.Data ,Index_RvsOutPwr_LTE,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_LTE);
		}

		{
			if(Sts->LTE15MUse == __NOTUSE)
			{
		//		출력=DET3 LTE#0 Fwd 출력 Avg Det
				tmppwrout = Sts->DetPwr.FwdOutAvgPwr_LTE;

				TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
				Sts->FwdOutPwr_LTE[0] = dptr[0];
				Sts->FwdOutPwr_LTE[1] = dptr[1];

				tmpx10 = Sts->DetPwr.FwdOutPeakPwr_LTE;
				TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
				Sts->FwdOutPwrPeak_LTE[0] = dptr[0];
				Sts->FwdOutPwrPeak_LTE[1] = dptr[1];
			}
			else
			{
		//		 출력=DET4 CDMA&LTE#0 공통부 Fwd 출력 Avg Det
				tmppwrout = Sts->DetPwr.FwdOutAvgPwr_CDMALTE;
				TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
				Sts->FwdOutPwr_LTE[0] = dptr[0];
				Sts->FwdOutPwr_LTE[1] = dptr[1];
	
				tmpx10 = Sts->DetPwr.FwdOutPeakPwr_CDMALTE;
				TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
				Sts->FwdOutPwrPeak_LTE[0] = dptr[0];
				Sts->FwdOutPwrPeak_LTE[1] = dptr[1];
			}

			if( Sts->DetPwr.FwdOutAvgPwr_LTE == 0)
			{
				Sts->FwdInPwr_LTE = NoSignal;
			}
			else
			{
				// 입력= DET4-81+ATT1+ATT3
				tmppwrin = tmppwrout - Gain_LTE + Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_LTE;
				Sts->FwdInPwr_LTE = abs(tmppwrin/2)- Sts->FwdInPwrOffset_LTE/2;
			}
			
			//	GAIN= 81-ATT1-ATT3 
			Sts->FwdGain_LTE = Gain_LTE - Sts->FwdAttn1_CDMALTE - Sts->FwdAttn1_LTE;
			Sts->FwdGain_LTE = MinMaxAttnCheck(Sts->FwdGain_LTE, Gain_LTE,FwdMinGain_LTE);

			if(tDnrSts->LTE15MUse == __NOTUSE)
			{
				/// "RVS 출력= DET11-RVS AGC ATT
				tmppwrout = Sts->DetPwr.RvsOutPwr_LTE - CurrRvsAlcAttn_LTE;
				TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
				Sts->RvsOutPwr_LTE[0] = dptr[0];
				Sts->RvsOutPwr_LTE[1] = dptr[1];

				/// "RVS 입력= DET11-81+RVS ALC ATT"
				tmpx10 = Sts->DetPwr.RvsOutPwr_LTE - Gain_LTE + Sts->RvsAlcAttn_LTE;
				Sts->RealRvsInPwr_LTE = tmpx10;
				Sts->CurrRvsInPwr_LTE =abs(tmpx10/2);
				tmppwrin = tmpx10;
				
				ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
				Sts->RvsInPwr_LTE[0] = dptr[0];
				Sts->RvsInPwr_LTE[1] = dptr[1];
			}
			else
			{
				INT8U CurrPwr;
				INT16U Sum_2G;
				INT16U Sum_LTE;
				INT16U Sum;
				INT16U i;
				INT16S tmppwr = 0;

				if( Sts->DetPwr.RvsOutPwr_2G > 10)
				{
					CurrPwr = 27*2 - Sts->DetPwr.RvsOutPwr_2G;
					if( CurrPwr > 35)CurrPwr = 35;
					Sum_2G = dBmTomW[CurrPwr];
				}
				else Sum_2G = 0;
				
				if( Sts->DetPwr.RvsOutPwr_LTE > 10)
				{
					CurrPwr = 27*2 - Sts->DetPwr.RvsOutPwr_LTE;
					if( CurrPwr > 35)CurrPwr = 35;
					Sum_LTE = dBmTomW[CurrPwr];
				}
				else Sum_LTE = 0;	
				
				Sum = Sum_2G + Sum_LTE;
				
				for(i = 0; i < sizeof(dBmTomW); i++)
				{
					if(Sum >= dBmTomW[i]) break;
				}

				tmppwr = 27*2 - i;
				
				if(Sts->DetPwr.RvsOutPwr_LTE <= -60)
				{
					tmppwr = LowPwrLmt;
				}

				
				tmppwr = tmppwr + Sts->RvsOutPwrOffset_LTE;
				
				Sts->DetPwr.FwdOutPeakPwr_LTE_A  = tmppwr;
				
				{
					///  RVS 출력= DET10+DET11-RVS AGC ATT
					tmppwrout = tmppwr - CurrRvsAlcAttn_LTE;
					TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
					Sts->RvsOutPwr_LTE[0] = dptr[0];
					Sts->RvsOutPwr_LTE[1] = dptr[1];
				
					///  RVS 입력= DET10+DET11-81+RVS ALC ATT"
					tmpx10 = tmppwr - Gain_LTE + Sts->RvsAlcAttn_LTE;
					Sts->RealRvsInPwr_LTE = tmpx10;
					Sts->CurrRvsInPwr_LTE =abs(tmpx10/2);
					tmppwrin = tmpx10;
						
					ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
					Sts->RvsInPwr_LTE[0] = dptr[0];
					Sts->RvsInPwr_LTE[1] = dptr[1];
				}
//				if(FSKDebug)SerPtr->printf("tmppwr[%d]CurrRvsAlcAttn_LTE[%d]\n", tmppwr,CurrRvsAlcAttn_LTE);

			}
			/// "GAIN=81 - RVS AGC ATT - RVS ALC ATT"
			Sts->RvsGainSts_LTE = Gain_LTE - CurrRvsAlcAttn_LTE - Sts->RvsAlcAttn_LTE;
			Sts->RvsGainSts_LTE = MinMaxAttnCheck(Sts->RvsGainSts_LTE, Gain_LTE,RvsMinGain_LTE);
		}
		if(Sts->AlmSts.FwdAmpOnOff_LTE 	== Disable) 	Sts->FwdInPwr_LTE		= NoSignal;
	}


 	// LTE-A2
	{
		Sts->DetPwr.FwdOutAvgPwr_LTE_A2		= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_LTE_A2.Data ,Index_FwdOutAvgPwr_LTE_A2,FALSE,&isminval, Sts->FwdOutPwrOffset_LTE_A2); 
		Sts->DetPwr.FwdOutPeakPwr_LTE_A2	= ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_LTE_A2.Data ,Index_FwdOutAvgPwr_LTE_A2,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_LTE_A2);
		Sts->DetPwr.RvsOutPwr_LTE_A2		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE_A2.Data ,Index_RvsOutPwr_LTE_A2,FALSE,&isminval, Sts->RvsOutPwrOffset_LTE_A2);

		{
			Sts->DetPwr.FwdOutAvgPwr_LTE_A2 = Sts->DetPwr.FwdOutAvgPwr_LTE_A2;
			Sts->DetPwr.FwdOutPeakPwr_LTE_A2 = Sts->DetPwr.FwdOutPeakPwr_LTE_A2;

			Sts->DetPwr.RvsOutPwr_LTE_A2 = Sts->DetPwr.RvsOutPwr_LTE_A2;
		}

	
		{
			/// 출력=DET6 LTE-A2#0 Tx 출력 RMS DET
			tmppwrout = Sts->DetPwr.FwdOutAvgPwr_LTE_A2;
			TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
			Sts->FwdOutPwr_LTE_A2[0] = dptr[0];
			Sts->FwdOutPwr_LTE_A2[1] = dptr[1];

			tmpx10 = Sts->DetPwr.FwdOutPeakPwr_LTE_A2;
			TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
			Sts->FwdOutPwrPeak_LTE_A2[0] = dptr[0];
			Sts->FwdOutPwrPeak_LTE_A2[1] = dptr[1];
			
			//입력=DET6-86+ATT4+ATT5
			if( Sts->DetPwr.FwdOutAvgPwr_LTE_A2 == 0)
			{
				Sts->FwdInPwr_LTE_A2 = NoSignal;
			}
			else
			{
				tmppwrin = tmppwrout - Gain_LTE_A + Sts->FwdAttn1_LTE_A2 + Sts->FwdAttn2_LTE_A2;
				Sts->FwdInPwr_LTE_A2 = abs(tmppwrin/2)- Sts->FwdInPwrOffset_LTE_A2/2;	
			}

			//5. GAIN= 86-ATT4-ATT5
			Sts->FwdGain_LTE_A2 = Gain_LTE_A - Sts->FwdAttn1_LTE_A2 - Sts->FwdAttn2_LTE_A2;
			Sts->FwdGain_LTE_A2 = MinMaxAttnCheck(Sts->FwdGain_LTE_A2, Gain_LTE_A,FwdMinGain_LTE_A);

		//	RVS 출력= DET14-RVS AGC ATT
			tmppwrout = Sts->DetPwr.RvsOutPwr_LTE_A2 - CurrRvsAlcAttn_LTE_A2;
			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			Sts->RvsOutPwr_LTE_A2[0] = dptr[0];
			Sts->RvsOutPwr_LTE_A2[1] = dptr[1];

		//	RVS 입력= DET14-86+RVS ALC ATT
			tmppwrin = Sts->DetPwr.RvsOutPwr_LTE_A2 - Gain_LTE_A + Sts->RvsAlcAttn_LTE_A2;
			Sts->RealRvsInPwr_LTEA = tmppwrin;

			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_LTE_A2[0] = dptr[0];
			Sts->RvsInPwr_LTE_A2[1] = dptr[1];
			
		//	GAIN=86 - RVS AGC ATT - RVS ALC ATT
			Sts->RvsGainSts_LTE_A2 = Gain_LTE_A - CurrRvsAlcAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2;
			Sts->RvsGainSts_LTE_A2 = MinMaxAttnCheck(Sts->RvsGainSts_LTE_A2, Gain_LTE_A,RvsMinGain_LTE_A);
		}
		
		if(Sts->AlmSts.FwdAmpOnOff_LTE_A2	== Disable) 	Sts->FwdInPwr_LTE_A2	= NoSignal;
	}

 	Sts->DetPwr.FwdInPwr_LTE_A			= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_LTE_A.Data ,Index_FwdInPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdInPwr_LTE_A); 
	Sts->DetPwr.RvsInPwr_LTE_A			= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_LTE_A.Data ,Index_RvsInPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.RvsInPwr_LTE_A); 
 
#if 0
 	// LTE-A1 LTE-A2
	{
		Sts->DetPwr.FwdInPwr_LTE_A			= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_LTE_A.Data ,Index_FwdInPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdInPwr_LTE_A); 
		Sts->DetPwr.FwdOutAvgPwr_LTE_A		= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_LTE_A.Data ,Index_FwdOutAvgPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdOutAvgPwr_LTE_A); 
		Sts->DetPwr.RvsInPwr_LTE_A			= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_LTE_A.Data ,Index_RvsInPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.RvsInPwr_LTE_A); 
		Sts->DetPwr.RvsOutPwr_LTE_A 		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE_A.Data ,Index_RvsOutPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_LTE_A); 

	}
#endif	
 	// WCDMA
	{
		Sts->DetPwr.FwdInPwr_3G			= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_3G.Data ,Index_FwdInPwr_3G,FALSE,&isminval, Sts->DetOffset.FwdInPwr_3G); 
		Sts->DetPwr.FwdOutAvgPwr_3G 	= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_3G.Data ,Index_FwdOutAvgPwr_3G,FALSE,&isminval, Sts->FwdOutPwrOffset_3G);
		Sts->DetPwr.FwdOutPeakPwr_3G	= ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_3G.Data ,Index_FwdOutAvgPwr_3G,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_3G); 
		Sts->DetPwr.RvsInPwr_3G 		= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_3G.Data ,Index_RvsInPwr_3G,FALSE,&isminval, Sts->DetOffset.RvsInPwr_3G); 
		Sts->DetPwr.RvsOutPwr_3G		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_3G.Data ,Index_RvsOutPwr_3G,FALSE,&isminval, Sts->Rvs0OutPwrOffset_3G);


		{
			// 출력=DET8
			tmppwrout = Sts->DetPwr.FwdOutAvgPwr_3G;
			TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
			Sts->FwdOutPwr_3G[0] = dptr[0];
			Sts->FwdOutPwr_3G[1] = dptr[1];
			
			tmpx10 = Sts->DetPwr.FwdOutPeakPwr_3G;
			TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
			Sts->FwdOutPwrPeak_3G[0] = dptr[0];
			Sts->FwdOutPwrPeak_3G[1] = dptr[1];

			//	입력= DET8-83+ATT18+ATT19
			if( Sts->DetPwr.FwdOutAvgPwr_3G == 0)
			{
				Sts->FwdInPwr_3G = NoSignal;
			}
			else
			{
				tmppwrin = tmppwrout - Gain_3G + Sts->FwdAttn1_3G + Sts->FwdAttn2_3G;
				Sts->FwdInPwr_3G = abs(tmppwrin/2)- Sts->FwdInPwrOffset_3G/2;	
			}
			// GAIN= 83-ATT18-ATT19
			Sts->FwdGain_3G = Gain_3G - Sts->FwdAttn1_3G - Sts->FwdAttn2_3G;;
			Sts->FwdGain_3G = MinMaxAttnCheck(Sts->FwdGain_3G, Gain_3G,FwdMinGain_3G);


	
			/// RVS 출력= DET17  WCDMA RVS 출력

//			tmppwrout = Sts->DetPwr.RvsOutPwr_3G;
			tmppwrout = Sts->DetPwr.RvsOutPwr_3G - CurrRvsAlcAttn_3G;

			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			Sts->RvsOutPwr_3G[0] = dptr[0];
			Sts->RvsOutPwr_3G[1] = dptr[1];
	
			/// RVS 입력= DET17-83+RVS ALC ATT
			tmppwrin = Sts->DetPwr.RvsOutPwr_3G - Gain_3G + Sts->RvsAlcAttn_3G;
			Sts->RealRvsInPwr_3G = tmppwrin;

			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_3G[0] = dptr[0];
			Sts->RvsInPwr_3G[1] = dptr[1];
	
			///	GAIN=83-RVS AGC ATT- RVS ALC ATT
			Sts->RvsGainSts_3G = Gain_3G - CurrRvsAlcAttn_3G - Sts->RvsAlcAttn_3G;
			Sts->RvsGainSts_3G = MinMaxAttnCheck(Sts->RvsGainSts_3G, Gain_3G,RvsMinGain_3G);
		}
		if(Sts->AlmSts.FwdAmpOnOff_3G == Disable) 	Sts->FwdInPwr_3G		= NoSignal;
	}
#if 0
	if(Sts->RealRvsInPwr_2G <= ULLowPwrLmt)	Sts->BalanceModePwr[PATH_2G] = ULLowPwrLmt/2;
	else 									Sts->BalanceModePwr[PATH_2G] = (Sts->RealRvsInPwr_2G + Sts->BalanceModeDetOffset[PATH_2G])/2;

	if(Sts->RealRvsInPwr_LTE <= ULLowPwrLmt) Sts->BalanceModePwr[PATH_LTE] = ULLowPwrLmt/2;
	else 									 Sts->BalanceModePwr[PATH_LTE] = (Sts->RealRvsInPwr_LTE + Sts->BalanceModeDetOffset[PATH_LTE])/2;

	if(Sts->RealRvsInPwr_LTEA <= ULLowPwrLmt) Sts->BalanceModePwr[PATH_LTEA] = ULLowPwrLmt/2;
	else 									  Sts->BalanceModePwr[PATH_LTEA] = (Sts->RealRvsInPwr_LTEA + Sts->BalanceModeDetOffset[PATH_LTEA])/2;

	if(Sts->RealRvsInPwr_3G <= ULLowPwrLmt)	Sts->BalanceModePwr[PATH_3G] = ULLowPwrLmt/2;
	else 									Sts->BalanceModePwr[PATH_3G] = (Sts->RealRvsInPwr_3G + Sts->BalanceModeDetOffset[PATH_3G])/2;
#endif
#if 1
	if(Sts->RealRvsInPwr_2G <= ULLowPwrLmt)	Sts->BalanceModePwr[PATH_2G] = ULLowPwrLmt/2;
	else 									Sts->BalanceModePwr[PATH_2G] = (Sts->RealRvsInPwr_2G)/2;

	if(Sts->RealRvsInPwr_LTE <= ULLowPwrLmt) Sts->BalanceModePwr[PATH_LTE] = ULLowPwrLmt/2;
	else 									 Sts->BalanceModePwr[PATH_LTE] = (Sts->RealRvsInPwr_LTE)/2;

	if(Sts->RealRvsInPwr_LTEA <= ULLowPwrLmt) Sts->BalanceModePwr[PATH_LTEA] = ULLowPwrLmt/2;
	else 									  Sts->BalanceModePwr[PATH_LTEA] = (Sts->RealRvsInPwr_LTEA)/2;

	if(Sts->RealRvsInPwr_3G <= ULLowPwrLmt)	Sts->BalanceModePwr[PATH_3G] = ULLowPwrLmt/2;
	else 									Sts->BalanceModePwr[PATH_3G] = (Sts->RealRvsInPwr_3G)/2;
#endif

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
#if 1
	INT8U AmpOnOff = 0;
	INT8U AGCOnOff = 0;
	INT8U AttnMAX = 0;
	INT8S AgcAttnVal = 0;
	INT16S	DetValue, LmtValue;
	
	__Dnr_Sts  *Sts = tDnrSts; 


//	if(!TimeOverCheck(Timer_AGC)) return;
//	TimerRegist(Timer_AGC, Time100mSec*5L);

 	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		if( Sts->AGCMode_2G == _AGCAvgMode)
		{
			DetValue = Sts->DetPwr.FwdOutAvgPwr_2G;
		}
		else
		{
			DetValue = Sts->DetPwr.FwdOutPeakPwr_2G;
		}	

		LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_2G);
		AmpOnOff = Sts->FwdAmpOnOff_2G;
		AGCOnOff = Sts->AGCOnOff_CDMALTE;
		AttnMAX = AGCMAX_2G;
		AgcAttnVal = Sts->FwdAgcAttn_2G;

		AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_AGCMode);
		Sts->FwdAgcAttn_2G = AgcAttnVal; 
	}

//	SerPtr->printf("Sts->FwdAgcAttn_2G[%d]\n", Sts->FwdAgcAttn_2G);
	
//////
 	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		if( Sts->AGCMode_LTE == _AGCAvgMode)
		{
			DetValue = Sts->DetPwr.FwdOutAvgPwr_LTE;
		}
		else
		{
			DetValue = Sts->DetPwr.FwdOutPeakPwr_LTE;
		}	
	}
	else
	{
		if( Sts->AGCMode_LTE == _AGCAvgMode)
		{
			DetValue = Sts->DetPwr.FwdOutAvgPwr_CDMALTE;
		}
		else
		{
			DetValue = Sts->DetPwr.FwdOutPeakPwr_CDMALTE;
		}
	}

//	INT8S FwdOutAvgPwr_CDMALTE; 
//	INT8S FwdOutPeakPwr_CDMALTE; 


	LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE);
	AmpOnOff = Sts->FwdAmpOnOff_LTE;
	AGCOnOff = Sts->AGCOnOff_CDMALTE;

//	SerPtr->printf("Sts->FwdAgcAttn_2G[%d]\n", Sts->FwdAgcAttn_2G);
	
	AttnMAX = AGCMAX_LTE;
	AgcAttnVal = Sts->FwdAgcAttn_LTE;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_AGCMode);
	Sts->FwdAgcAttn_LTE = AgcAttnVal; 

 /////////////3G

	if( Sts->AGCMode_3G == _AGCAvgMode)
	{
		DetValue = Sts->DetPwr.FwdOutAvgPwr_3G;
	}
	else
	{
		DetValue = Sts->DetPwr.FwdOutPeakPwr_3G;
	}	

	LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_3G);
	AmpOnOff = Sts->FwdAmpOnOff_3G;
	AGCOnOff = Sts->AGCOnOff_3G;
	AttnMAX = AGCMAX_3G;
	AgcAttnVal = Sts->FwdAgcAttn_3G;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_AGCMode);
	Sts->FwdAgcAttn_3G = AgcAttnVal; 

///// LTEA
	
	if( Sts->AGCMode_LTE_A2 == _AGCAvgMode)
	{
		DetValue = Sts->DetPwr.FwdOutAvgPwr_LTE_A2;
	}
	else
	{
		DetValue = Sts->DetPwr.FwdOutPeakPwr_LTE_A2;
	}	
	
	LmtValue = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE_A2);
	AmpOnOff = Sts->FwdAmpOnOff_LTE_A2;
	AGCOnOff = Sts->AGCOnOff_LTE_A_0;
	AttnMAX = AGCMAX_LTE_A1;
	AgcAttnVal = Sts->FwdAgcAttn_LTE_A2;
	
	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_AGCMode);
	Sts->FwdAgcAttn_LTE_A2 = AgcAttnVal; 

#endif
/////////////////////////

	DetValue = -Sts->DetPwr.FwdInPwr_CDMALTE*2;
	LmtValue = OtherFwdOverInLmt_CDMALTE;
	AmpOnOff = Sts->FwdAmpOnOff_LTE;
	AGCOnOff = Enable;
	AttnMAX =  25*2;
	AgcAttnVal = Sts->FwdInAlcAttn_CDMALTE;
	if((Sts->FwdAmpOnOff_2G)||(Sts->FwdAmpOnOff_LTE))	 AmpOnOff = Disable;
	else												 AmpOnOff = Enable;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_InputALCMode);
	Sts->FwdInAlcAttn_CDMALTE = AgcAttnVal;


	DetValue = -Sts->DetPwr.FwdInPwr_3G*2;
	LmtValue = OtherFwdOverInLmt_3G;
	AmpOnOff = Sts->FwdAmpOnOff_3G;
	AGCOnOff = Enable;
	AttnMAX =  25*2;
	AgcAttnVal = Sts->FwdInAlcAttn_3G;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_InputALCMode);
	Sts->FwdInAlcAttn_3G = AgcAttnVal;


	DetValue = -Sts->DetPwr.FwdInPwr_LTE_A*2;
	LmtValue = OtherFwdOverInLmt_LTE_A;
	AmpOnOff = Sts->FwdAmpOnOff_LTE_A2;
	AGCOnOff = Enable;
	AttnMAX =  25*2;
	AgcAttnVal = Sts->FwdInAlcAttn_LTE_A_0;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_InputALCMode);
	Sts->FwdInAlcAttn_LTE_A_0 = AgcAttnVal;
}

//INT8U AlcOperation(INT8U IsIt3G, INT8U IsItOSC)

void ALCCheckFunction(void)
{
	INT8U AmpOnOff = 0;
	INT8U AGCOnOff = 0;
	INT8U AttnMAX = 0;
	INT8S AgcAttnVal = 0;
	INT16S	DetValue, LmtValue;

	__Dnr_Sts  *Sts = tDnrSts; 

	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		DetValue = Sts->DetPwr.RvsOutPwr_2G;
		LmtValue = Sts->RvsALCLvl_2G*2;
		AmpOnOff = Sts->FwdAmpOnOff_2G;
		AGCOnOff = Sts->RvsAlcOnOff_2G;
		AttnMAX = tRvsALCMAX_2G;
		AgcAttnVal = Sts->RvsAlcAttn_2G;
		AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_ALCMode);
		Sts->RvsAlcAttn_2G = AgcAttnVal; 
	}
	
	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		DetValue = Sts->DetPwr.RvsOutPwr_LTE;
	}
	else
	{
 		DetValue = Sts->DetPwr.FwdOutPeakPwr_LTE_A;
	}
	
 	LmtValue = Sts->RvsALCLvl_LTE*2;
	AmpOnOff = Sts->FwdAmpOnOff_LTE;
	AGCOnOff = Sts->RvsAlcOnOff_LTE;
	AttnMAX = tRvsALCMAX_LTE;
	AgcAttnVal = Sts->RvsAlcAttn_LTE;
	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_ALCMode);
	Sts->RvsAlcAttn_LTE = AgcAttnVal; 
////

	DetValue = Sts->DetPwr.RvsOutPwr_3G;
	AmpOnOff = Sts->FwdAmpOnOff_3G;
	AGCOnOff = Sts->RvsAlcOnOff_3G;
	AttnMAX = tRvsALCMAX_3G;
	AgcAttnVal = Sts->RvsAlcAttn_3G;
	LmtValue = (tmpRvsALCLvl_3G)*2 ;

#if 0	
	if((Sts->AlmSts.FwdAmpOnOff_3G == Disable)||( Sts->DetPwr.FwdOutAvgPwr_3G <= 0)||(Sts->AGCOnOff_3G == Disable))
	{
		LmtValue = (tmpRvsALCLvl_3G)*2 ;
	}
	else
	{
		LmtValue = (tmpRvsALCLvl_3G*2 - Sts->RvsGainAttn_3G);
	}
#endif


	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_ALCMode);
	Sts->RvsAlcAttn_3G = AgcAttnVal; 
/////////////////LTE-A
	DetValue = Sts->DetPwr.RvsOutPwr_LTE_A2;
	LmtValue = Sts->RvsALCLvl_LTE_A2*2;
	AmpOnOff = Sts->FwdAmpOnOff_LTE_A2;
	AGCOnOff = Sts->RvsAlcOnOff_LTE_A2;
	AttnMAX = tRvsALCMAX_LTE_A1;
	AgcAttnVal = Sts->RvsAlcAttn_LTE_A2;

	AGCCheck(DetValue, LmtValue,AGCOnOff, &AgcAttnVal, AttnMAX, AmpOnOff,_ALCMode);
	Sts->RvsAlcAttn_LTE_A2= AgcAttnVal; 
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
			  if(gap >=  2L)	gap = gap;
			else				gap = 1L;
		}
		else
		{
			if(gap <= -2L)			gap = -2L;
			else					gap = -1L;
		}
		
		tmpTotAttn	+= gap;
	}
	
	if(Mode ==_ALCMode)
	{
		if(gap > 0)
		{
//			if(gap >=  4L)			gap = 4L;
			if(gap >=  4L)			gap = gap;
			else if(gap >=  2L)		gap = gap;
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
		tmpTotAttn  = gap;
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
#if 1
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
						GreenLED_CDMA = 1;
						RedLED_CDMA = 0;
					break;

					case PATH_LTE:
						GreenLED_LTE = 1;
						RedLED_LTE = 0;
					break;

					
                  	case PATH_3G:
						GreenLED_WCDMA= 1;
						RedLED_WCDMA = 0;
					break;

					case PATH_LTEA:
						GreenLED_LTE_A2_0 = 1;
						RedLED_LTE_A2_0 = 0;
					break;
				}
			break;

			case LEDNorONOFF:
				switch(i)
				{
					case PATH_2G:
						GreenLED_CDMA = BlinkFlag;
						RedLED_CDMA = 0;
					break;

					case PATH_LTE:
						GreenLED_LTE = BlinkFlag;
						RedLED_LTE = 0;
					break;

					case PATH_3G:
						GreenLED_WCDMA = BlinkFlag;
						RedLED_WCDMA = 0;
					break;

					case PATH_LTEA:
						GreenLED_LTE_A2_0 = BlinkFlag;
						RedLED_LTE_A2_0 = 0;
					break;	
				}
			break;
			
			case LEDAlmON:
				switch(i)
				{
					case PATH_2G:
						GreenLED_CDMA = 0;
						RedLED_CDMA = 1;
					break;

					case PATH_LTE:
						GreenLED_LTE = 0;
						RedLED_LTE = 1;
					break;

					case PATH_3G:
						GreenLED_WCDMA = 0;
						RedLED_WCDMA = 1;
					break;

					case PATH_LTEA:
						GreenLED_LTE_A2_0 = 0;
						RedLED_LTE_A2_0 = 1;
					break;	
				}
			break;

			case LEDAlmONOFF:
				switch(i)
				{
					case PATH_2G:
						GreenLED_CDMA = 0;
						RedLED_CDMA = BlinkFlag;
					break;

					case PATH_LTE:
						GreenLED_LTE = 0;
						RedLED_LTE = BlinkFlag;
					break;

					case PATH_3G:
						GreenLED_WCDMA = 0;
						RedLED_WCDMA = BlinkFlag;
					break;

					case PATH_LTEA:
						GreenLED_LTE_A2_0= 0;
						RedLED_LTE_A2_0 = BlinkFlag;
					break;
				}
			break;

			case LEDNorAlmON:
				switch(i)
				{
					case PATH_2G:
						GreenLED_CDMA = 1;
						RedLED_CDMA = 1;
					break;

					case PATH_LTE:
						GreenLED_LTE = 1;
						RedLED_LTE = 1;
					break;
					
					case PATH_3G:
						GreenLED_WCDMA = 1;
						RedLED_WCDMA = 1;
					break;

					case PATH_LTEA:
						GreenLED_LTE_A2_0 = 1;
						RedLED_LTE_A2_0 = 1;
					break;
				}
			break;

			
			case LEDNorAlmONOFF:
				switch(i)
				{
					case PATH_2G:
						GreenLED_CDMA = BlinkFlag;
						RedLED_CDMA = BlinkFlag;
					break;

					case PATH_LTE:
						GreenLED_LTE = BlinkFlag;
						RedLED_LTE = BlinkFlag;
					break;
					
					case PATH_3G:
						GreenLED_WCDMA = BlinkFlag;
						RedLED_WCDMA = BlinkFlag;
					break;

					case PATH_LTEA:
						GreenLED_LTE_A2_0 = BlinkFlag;
						RedLED_LTE_A2_0 = BlinkFlag;
					break;
				}
			break;

			case LEDAllOFF:
			switch(i)
			{
				case PATH_2G:
					GreenLED_CDMA = 0;
					RedLED_CDMA = 0;
				break;

				case PATH_LTE:
					GreenLED_LTE = 0;
					RedLED_LTE = 0;
				break;
				
				case PATH_3G:
					GreenLED_WCDMA = 0;
					RedLED_WCDMA = 0;
				break;

				case PATH_LTEA:
					GreenLED_LTE_A2_0 = 0;
					RedLED_LTE_A2_0 = 0;
				break;

			}
		break;		
		}
	}
#endif
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
			FrontLEDSet(PATH_2G, 		LEDAllOFF);
			FrontLEDSet(PATH_LTE, 	LEDAllOFF);
			FrontLEDSet(PATH_3G, 		LEDAllOFF);
			FrontLEDSet(PATH_LTEA, 	LEDAllOFF);
		}
		else
		{
//////CDMA
			if(tDnrSts->LTE15MUse == __NOTUSE)
			{
				if(((Sd_Step[SD_FI_2G]>= 1)&&(Sd_Step[SD_FI_2G]< 30))
					||((Sd_Step[SD_FO_2G]>= 1)&&(Sd_Step[SD_FO_2G]< 30))
					||((Sd_Step[SD_RO_2G]>= 1)&&(Sd_Step[SD_RO_2G]< 30)))
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
						||((tDnrSts->AlmSts.OverInAlarm_CDMALTE == Alarm)&&(CurrAlarm.OverInAlarm_CDMALTE_1 == Alarm))

						||(tDnrSts->AlmSts.FwdInUpperLmtFail_2G == Alarm))
					{
						FrontLEDSet(PATH_2G, LEDNorAlmON);
					}
					else if((mSleep[PATH_2G].IsItSLP == SET)&&(mSleep[PATH_LTE].IsItSLP == SET))
					{
						FrontLEDSet(PATH_2G, LEDNorONOFF);
					}
					else
					{
						FrontLEDSet(PATH_2G, LEDNorON);
					}
				}
			}
			else
			{
				FrontLEDSet(PATH_2G, LEDAllOFF);
			}		

/////////////LTE
			if(Sts->FemtocellUseOnOff.LTE == __NOTUSE)
			{
				if(((Sd_Step[SD_FI_LTE]>= 1)&&(Sd_Step[SD_FI_LTE]< 30))
					||((Sd_Step[SD_FO_LTE]>= 1)&&(Sd_Step[SD_FO_LTE]< 30))
					||((Sd_Step[SD_RO_LTE]>= 1)&&(Sd_Step[SD_RO_LTE]< 30)))
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
						||((tDnrSts->AlmSts.OverInAlarm_CDMALTE == Alarm)&&(CurrAlarm.OverInAlarm_CDMALTE_2 == Alarm))
						||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE == Alarm))
					{
						FrontLEDSet(PATH_LTE, LEDNorAlmON);
					}
					else if((mSleep[PATH_2G].IsItSLP == SET)&&(mSleep[PATH_LTE].IsItSLP == SET))
					{
						FrontLEDSet(PATH_LTE, LEDNorONOFF);
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
			if(tDnrSts->Band_Select_LTE_A2[0] == __NOTUSE)
			{
				FrontLEDSet(PATH_LTEA, LEDAllOFF);
			}
			else if((Sts->FemtocellUseOnOff.LTE_A2 == __NOTUSE))
			{
				if(((Sd_Step[SD_FI_LTE_A2]>= 1)&&(Sd_Step[SD_FI_LTE_A2]< 30))
					||((Sd_Step[SD_FO_LTE_A2]>= 1)&&(Sd_Step[SD_FO_LTE_A2]< 30))
					||((Sd_Step[SD_RO_LTE_A2]>= 1)&&(Sd_Step[SD_RO_LTE_A2]< 30)))
				{
					FrontLEDSet(PATH_LTEA, LEDAlmONOFF);

				}
				else if(((Sd_Step[SD_FI_LTE_A2]== 30)||(Sd_Step[SD_FO_LTE_A2]== 30)||(Sd_Step[SD_RO_LTE_A2]== 30))
					||(tDnrSts->AlmSts.FwdAmpOnOff_LTE_A2== Disable))
				{
					FrontLEDSet(PATH_LTEA, LEDAlmON);
				}
				else
				{
					if((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A2 == Alarm) &&(mFwdLowAlm[PATH_LTEA].AlarmCnt< AlarmCheckTime)
					&&(mFwdLowAlm[PATH_LTEA].AlarmCnt> StartAlarmCheckTime))
					{
						FrontLEDSet(PATH_LTEA, LEDNorAlmONOFF);
					}
					else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A2 == Alarm) &&(mFwdLowAlm[PATH_LTEA].AlarmCnt== AlarmCheckTime))
						||((tDnrSts->AlmSts.OverInAlarm_LTE_A == Alarm))
						||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE_A2 == Alarm))
					{
						FrontLEDSet(PATH_LTEA, LEDNorAlmON);
					}
					else if(mSleep[PATH_LTEA].IsItSLP == SET)
					{
						FrontLEDSet(PATH_LTEA, LEDNorONOFF);
					}
					else
					{
						FrontLEDSet(PATH_LTEA, LEDNorON);
					}
				}
			}
			else
			{
				FrontLEDSet(PATH_LTEA, LEDAllOFF);
			}		

	///////////////  WCDMA
			{
				if(((Sd_Step[SD_FI_3G]>= 1)&&(Sd_Step[SD_FI_3G]< 30))
					||((Sd_Step[SD_FO_3G]>= 1)&&(Sd_Step[SD_FO_3G]< 30))
					||((Sd_Step[SD_RO_3G]>= 1)&&(Sd_Step[SD_RO_3G]< 30)))
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
						||(tDnrSts->AlmSts.OverInAlarm_3G		== Alarm)
						||(tDnrSts->AlmSts.FwdInUpperLmtFail_3G == Alarm))
					{
						FrontLEDSet(PATH_3G, LEDNorAlmON);
					}
					else if(mSleep[PATH_3G].IsItSLP == SET)
					{
						FrontLEDSet(PATH_3G, LEDNorONOFF);
					}
					else
					{
						FrontLEDSet(PATH_3G, LEDNorON);
					}
				}
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

void ShutdownFunc(INT8U SysPath, INT8U Path)
{
	INT8U	OffReason, OffTime;
	INT16U	SdTimer;
	INT16S	DetValue, LmtValue;
	
	INT8U	AlarmChk = 0;
	
	INT8U	*AmpOnOff;
	
	__Dnr_Sts  *Sts = tDnrSts; 


	if(Ac_Sd_Flag == 1)	return;
	//---------------------------------------------------------------------//

	switch(Path)
	{
		//---------------------------------------------------------------------//
		// 2G
		case SD_FI_2G:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_2G;
			DetValue = -tDnrSts->FwdInPwr_2G;
			LmtValue = tDnrSts->OverInAlarmLmt_2G/2;	//과입력 Shutdown -11±2dBm
			AmpOnOff = &Sts->FwdAmpOnOff_2G;

			#ifdef RvsSD_Debug
			
 			AlarmChk = SET;

			#if 0
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_2G == AGCMAX_2G))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_CDMALTE == Disable)
			{
				AlarmChk = SET;
			}	
			#endif
			#endif
			break;

		case SD_FO_2G:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_2G;
			DetValue = Sts->FwdOutPwr_2G[0]*10 + Sts->FwdOutPwr_2G[1];
			LmtValue = Sts->FwdOutHighLmt_2G[0]*10 + Sts->FwdOutHighLmt_2G[1];

			AmpOnOff = &Sts->FwdAmpOnOff_2G;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_2G == AGCMAX_2G))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_CDMALTE == Disable)
			{
				AlarmChk = SET;
			}			
			#endif
			break;

		case SD_RO_2G:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_2G;
			DetValue = Sts->RvsOutPwr_2G[0]*10 + Sts->RvsOutPwr_2G[1];
			LmtValue = Sts->RvsOutUpperLmt_2G[0]*10 + Sts->RvsOutUpperLmt_2G[1];

			AmpOnOff = &Sts->FwdAmpOnOff_2G;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->RvsAlcAttn_2G == tRvsALCMAX_2G))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_CDMALTE == Disable)
			{
				AlarmChk = SET;
			}
			#endif
			break;
		//---------------------------------------------------------------------//
		// LTE
		case SD_FI_LTE:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE;
			DetValue = -tDnrSts->FwdInPwr_LTE;
			LmtValue = tDnrSts->OverInAlarmLmt_LTE/2;	 //과입력 Shutdown -8dBm
			AmpOnOff = &Sts->FwdAmpOnOff_LTE;
			#ifdef RvsSD_Debug
			#if 0
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_LTE == AGCMAX_LTE))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_CDMALTE == Disable)
			{
				AlarmChk = SET;
			}	
			#endif
				AlarmChk = SET;

			#endif			
			break;

		case SD_FO_LTE:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE;
			DetValue = Sts->FwdOutPwr_LTE[0]*10 + Sts->FwdOutPwr_LTE[1];
			LmtValue = Sts->FwdOutHighLmt_LTE[0]*10 + Sts->FwdOutHighLmt_LTE[1];
			AmpOnOff = &Sts->FwdAmpOnOff_LTE;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_LTE == AGCMAX_LTE))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_CDMALTE == Disable)
			{
				AlarmChk = SET;
			}			
			#endif
			break;

		case SD_RO_LTE:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE;
			DetValue = Sts->RvsOutPwr_LTE[0]*10 + Sts->RvsOutPwr_LTE[1];
			LmtValue = Sts->RvsOutUpperLmt_LTE[0]*10 + Sts->RvsOutUpperLmt_LTE[1];
			AmpOnOff = &Sts->FwdAmpOnOff_LTE;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->RvsAlcAttn_LTE == tRvsALCMAX_LTE))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_CDMALTE == Disable)
			{
				AlarmChk = SET;
			}			
			#endif			
			break;

		//---------------------------------------------------------------------//
		// 3G
		case SD_FI_3G:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_3G;
			DetValue = - tDnrSts->FwdInPwr_3G;
			LmtValue = tDnrSts->OverInAlarmLmt_3G/2;	//과입력 Shutdown  -19dBm
			AmpOnOff = &Sts->FwdAmpOnOff_3G;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_3G == Enable)&&(Sts->FwdAgcAttn_3G == AGCMAX_3G))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_3G == Disable)
			{
				AlarmChk = SET;
			}			
			#endif			
			break;

		case SD_FO_3G:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_3G;
			DetValue = Sts->FwdOutPwr_3G[0]*10 + Sts->FwdOutPwr_3G[1];
			LmtValue = Sts->FwdOutHighLmt_3G[0]*10 + Sts->FwdOutHighLmt_3G[1];
			AmpOnOff = &Sts->FwdAmpOnOff_3G;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_3G == Enable)&&(Sts->FwdAgcAttn_3G == AGCMAX_3G))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_3G == Disable)
			{
				AlarmChk = SET;
			}				
			#endif					
			break;

		case SD_RO_3G:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_3G;
			DetValue = Sts->RvsOutPwr_3G[0]*10 + Sts->RvsOutPwr_3G[1];
			LmtValue = Sts->RvsOutUpperLmt_3G[0]*10 + Sts->RvsOutUpperLmt_3G[1];
			AmpOnOff = &Sts->FwdAmpOnOff_3G;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_3G == Enable)&&(Sts->RvsAlcAttn_3G == tRvsALCMAX_3G))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_3G == Disable)
			{
				AlarmChk = SET;
			}				
			#endif		
			break;

		//---------------------------------------------------------------------//
		// LTE-A2
		case SD_FI_LTE_A2:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE_A2;
			DetValue = -tDnrSts->FwdInPwr_LTE_A2;
			LmtValue = tDnrSts->OverInAlarmLmt_LTE_A2/2;	// 과입력 Shutdown -15dBm
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A2;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->FwdAgcAttn_LTE_A2 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				AlarmChk = SET;
			}				
			#endif				
			break;

		case SD_FO_LTE_A2:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE_A2;
			DetValue = Sts->FwdOutPwr_LTE_A2[0]*10 + Sts->FwdOutPwr_LTE_A2[1];
			LmtValue = Sts->FwdOutHighLmt_LTE_A2[0]*10 + Sts->FwdOutHighLmt_LTE_A2[1];
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A2;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->FwdAgcAttn_LTE_A2 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				AlarmChk = SET;
			}				
			#endif					
			break;

		case SD_RO_LTE_A2:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE_A2;
			DetValue = Sts->RvsOutPwr_LTE_A2[0]*10 + Sts->RvsOutPwr_LTE_A2[1];
			LmtValue = (Sts->RvsOutUpperLmt_LTE_A2[0]*10 + Sts->RvsOutUpperLmt_LTE_A2[1]);
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A2;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->RvsAlcAttn_LTE_A2 == tRvsALCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				AlarmChk = SET;
			}				
			#endif					
			break;
 	}

	//---------------------------------------------------------------------//
	switch(Sd_Step[Path])
	{
		case 0:
			Sd_Step[Path] = 0;
			Sd_Cnt[Path] = 0;

			if((DetValue >= LmtValue)&& (AlarmChk == SET))
			{
				if((Sd_Path[SysPath] == 0)&&(*AmpOnOff == _Enable))
				{
					TimerRegist(SdTimer, Time1Sec*5);
					Sd_Step[Path] = 1;
					Sd_Path[SysPath] = 1;
				}
			}
			break;

		case 1:	// Amp Off Check
			if(DetValue < (LmtValue))	// 정상...
			{
				Sd_Step[Path] = 0;
				Sd_Path[SysPath] = 0;
				break;
			}
			
			if(!TimeOverCheck(SdTimer)) return;
			*AmpOnOff = _Disable;
			if(Sd_Cnt[Path] == 2)	OffTime = SD_AMP_OFF_30M;
			else					OffTime = SD_AMP_OFF_5S;
			AmpBitReason(SysPath, _Disable, OffReason, OffTime);
			TimerRegist(SdTimer, Time1Sec*5);		// 5Sec
			Sd_Step[Path] = 2;
			#ifdef __RvsCount
				RvsOSCAlarmCountFunc(SysPath, Path);  //////
			#endif
			break;
			
		case 2:  // Amp On Check = After 5sec
			if(!TimeOverCheck(SdTimer))	return;

			Sd_Cnt[Path]++; // Off Count
			if(Sd_Cnt[Path] >= 3)
			{
				if(tDnrSts->ShunDownTime == 0)		TimerRegist(SdTimer, Time1Sec*60L*30L);	
				else								TimerRegist(SdTimer, Time1Sec*40L);	
				Sd_Step[Path] = 3;
			}
			else
			{  
				*AmpOnOff = _Enable;
				AmpBitReason(SysPath, _Enable, 127, SD_AMP_ON);
				TimerRegist(SdTimer, Time1Sec*1);
				Sd_Step[Path] = 10; 
			}
			break;

		case 3:	// Amp On Check - After 30min
			if(!TimeOverCheck(SdTimer))	return;
			*AmpOnOff = _Enable;
			AmpBitReason(SysPath, _Enable, 127, SD_AMP_ON);
			
			TimerRegist(SdTimer, Time1Sec*1);

			Sd_Step[Path] = 20;
			break;

		case 4:	// Amp Off Check
			if(!TimeOverCheck(SdTimer))
			{   // Timer  동안 유지 Check
#if 0
				if(DetValue<LmtValue)	Sd_Step[Path] = 0;
				break;
#endif				
				if(DetValue < (LmtValue))	// 정상...
				{
					Sd_Step[Path] = 0;
					Sd_Path[SysPath] = 0;
					break;
				}
			}


			

			*AmpOnOff = _Disable;
			AmpBitReason(SysPath, _Disable, OffReason, SD_AMP_OFF_INF);

			Sd_Step[Path] = 30;	// 완전 Shutdown
			break;

		//---------------------------------------------------------------------//
		case 10:	// Amp On 시간 Total 5sec 유지...(5Sec Off시)
			if(!TimeOverCheck(SdTimer))	return;
			
			*AmpOnOff = _Enable;
			AmpBitReason(SysPath, _Enable, 127, SD_AMP_ON);
			
			TimerRegist(SdTimer, Time1Sec*4);

			Sd_Step[Path] = 1; 
			
			break;

		//---------------------------------------------------------------------//
		case 20:	// Amp On 시간 Total 5sec 유지...(30Min Off시)
			if(!TimeOverCheck(SdTimer))	return;

			*AmpOnOff = _Enable;
			AmpBitReason(SysPath, _Enable, 127, SD_AMP_ON);
			TimerRegist(SdTimer, Time1Sec*4);
			Sd_Step[Path] = 4; 
			break;

		//---------------------------------------------------------------------//
		case 30:	// 완전 Shutdown 상태...
 			break;

		//---------------------------------------------------------------------//
		default :
			Sd_Step[Path] = 0;
			Sd_Path[SysPath] = 0;
		break;
	}
}

void ShutDownCheck(void)
{
	if((tDnrSts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
	{

	}
	else
	{
		if(tDnrSts->ShutDownOnOff_2G == _Enable)
		{
			if(tDnrSts->LTE15MUse == __NOTUSE)
			{
				ShutdownFunc(PATH_2G, SD_FI_2G);
				ShutdownFunc(PATH_2G, SD_FO_2G);
				ShutdownFunc(PATH_2G, SD_RO_2G);
			}
		}
		if(tDnrSts->ShutDownOnOff_LTE == _Enable)
		{
			ShutdownFunc(PATH_LTE, SD_FI_LTE);
			ShutdownFunc(PATH_LTE, SD_FO_LTE);
			ShutdownFunc(PATH_LTE, SD_RO_LTE);
		}

		if(tDnrSts->ShutDownOnOff_3G == _Enable)
		{
			ShutdownFunc(PATH_3G, SD_FI_3G);
			ShutdownFunc(PATH_3G, SD_FO_3G);
			ShutdownFunc(PATH_3G, SD_RO_3G);
		}

		if((tDnrSts->ShutDownOnOff_LTE_A2 == _Enable)&&(tDnrSts->Band_Select_LTE_A2[0] == __USE))
		{
			ShutdownFunc(PATH_LTEA, SD_FI_LTE_A2);
			ShutdownFunc(PATH_LTEA, SD_FO_LTE_A2);
			ShutdownFunc(PATH_LTEA, SD_RO_LTE_A2);
		}
	}
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
	if(Vaule <= LowPwrLmt)
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


		if(tIndex == Local_FwdOutAvgPwr_2G)
		{
			dptr = OutputTable->FwdOutAvgPwr_2G.Data;
			limit = OutputTable->FwdOutAvgPwr_2G.limit;
			nsize = OutputTable->FwdOutAvgPwr_2G.nsize;
			rvalx10 = (limit/2)*10L;
		}
		else if(tIndex == Local_RvsOutPwr_2G)
		{
			dptr = OutputTable->RvsOutPwr_2G.Data;
			limit = OutputTable->RvsOutPwr_2G.limit;
			nsize = OutputTable->RvsOutPwr_2G.nsize;
			rvalx10 = (limit/2)*10L;
		}
		else if(tIndex == Local_FwdOutAvgPwr_LTE)
		{
			dptr = OutputTable->FwdOutAvgPwr_LTE.Data;
			limit = OutputTable->FwdOutAvgPwr_LTE.limit;
			nsize = OutputTable->FwdOutAvgPwr_LTE.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_RvsInPwr_LTE)
		{
			dptr = OutputTable->RvsInPwr_LTE.Data;
			limit = OutputTable->RvsInPwr_LTE.limit;
			nsize = OutputTable->RvsInPwr_LTE.nsize;
			rvalx10 = (limit/2)*10L;
		}	

		else if(tIndex == Local_RvsOutPwr_LTE)
		{
			dptr = OutputTable->RvsOutPwr_LTE.Data;
			limit = OutputTable->RvsOutPwr_LTE.limit;
			nsize = OutputTable->RvsOutPwr_LTE.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_FwdInPwr_CDMALTE)
		{
			dptr = OutputTable->FwdInPwr_CDMALTE.Data;
			limit = OutputTable->FwdInPwr_CDMALTE.limit;
			nsize = OutputTable->FwdInPwr_CDMALTE.nsize;
			rvalx10 = (limit/2)*10L;
		}	
 		else if(tIndex == Local_FwdOutAvgPwr_CDMALTE)
		{
			dptr = OutputTable->FwdOutAvgPwr_CDMALTE.Data;
			limit = OutputTable->FwdOutAvgPwr_CDMALTE.limit;
			nsize = OutputTable->FwdOutAvgPwr_CDMALTE.nsize;
			rvalx10 = (limit/2)*10L;
		}
		else if(tIndex == Local_RvsInPwr_CDMALTE)
		{
			dptr = OutputTable->RvsInPwr_CDMALTE.Data;
			limit = OutputTable->RvsInPwr_CDMALTE.limit;
			nsize = OutputTable->RvsInPwr_CDMALTE.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_RvsOutPwr_CDMALTE)
		{
			dptr = OutputTable->RvsOutPwr_CDMALTE.Data;
			limit = OutputTable->RvsOutPwr_CDMALTE.limit;
			nsize = OutputTable->RvsOutPwr_CDMALTE.nsize;
			rvalx10 = (limit/2)*10L;
		}	

		else if(tIndex == Local_FwdOutAvgPwr_LTE_A2)
		{
			dptr = OutputTable->FwdOutAvgPwr_LTE_A2.Data;
			limit = OutputTable->FwdOutAvgPwr_LTE_A2.limit;
			nsize = OutputTable->FwdOutAvgPwr_LTE_A2.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_RvsOutPwr_LTE_A2)
		{
			dptr = OutputTable->RvsOutPwr_LTE_A2.Data;
			limit = OutputTable->RvsOutPwr_LTE_A2.limit;
			nsize = OutputTable->RvsOutPwr_LTE_A2.nsize;
			rvalx10 = (limit/2)*10L;
		}
 		else if(tIndex == Local_FwdInPwr_LTE_A)
		{
			dptr = OutputTable->FwdInPwr_LTE_A.Data;
			limit = OutputTable->FwdInPwr_LTE_A.limit;
			nsize = OutputTable->FwdInPwr_LTE_A.nsize;
			rvalx10 = (limit/2)*10L;
		}
#if 0
		else if(tIndex == Local_FwdOutAvgPwr_LTE_A)
		{
			dptr = OutputTable->FwdOutAvgPwr_LTE_A.Data;
			limit = OutputTable->FwdOutAvgPwr_LTE_A.limit;
			nsize = OutputTable->FwdOutAvgPwr_LTE_A.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_RvsInPwr_LTE_A)
		{
			dptr = OutputTable->RvsInPwr_LTE_A.Data;
			limit = OutputTable->RvsInPwr_LTE_A.limit;
			nsize = OutputTable->RvsInPwr_LTE_A.nsize;
			rvalx10 = (limit/2)*10L;
		}	
#endif
		
		else if(tIndex == Local_RvsOutPwr_LTE_A)
		{
			dptr = OutputTable->RvsOutPwr_LTE_A.Data;
			limit = OutputTable->RvsOutPwr_LTE_A.limit;
			nsize = OutputTable->RvsOutPwr_LTE_A.nsize;
			rvalx10 = (limit/2)*10L;
		}	
#if 0		
		else if(tIndex == Local_Rvs1InPwr_LTE_A)
		{
			dptr = OutputTable->Rvs1InPwr_LTE_A.Data;
			limit = OutputTable->Rvs1InPwr_LTE_A.limit;
			nsize = OutputTable->Rvs1InPwr_LTE_A.nsize;
			rvalx10 = (limit/2)*10L;
		} 
#endif
		else if(tIndex == Local_FwdInPwr_3G)
		{
			dptr = OutputTable->FwdInPwr_3G.Data;
			limit = OutputTable->FwdInPwr_3G.limit;
			nsize = OutputTable->FwdInPwr_3G.nsize;
			rvalx10 = (limit/2)*10L;
		}
		else if(tIndex == Local_FwdOutAvgPwr_3G)
		{
			dptr = OutputTable->FwdOutAvgPwr_3G.Data;
			limit = OutputTable->FwdOutAvgPwr_3G.limit;
			nsize = OutputTable->FwdOutAvgPwr_3G.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_RvsInPwr_LTE_A)
		{
			dptr = OutputTable->RvsInPwr_3G.Data;
			limit = OutputTable->RvsInPwr_3G.limit;
			nsize = OutputTable->RvsInPwr_3G.nsize;
			rvalx10 = (limit/2)*10L;
		}	
		else if(tIndex == Local_RvsOutPwr_3G)
		{
			dptr = OutputTable->RvsOutPwr_3G.Data;
			limit = OutputTable->RvsOutPwr_3G.limit;
			nsize = OutputTable->RvsOutPwr_3G.nsize;
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
#if 1
void AmpBitReason(INT8U SysPath, INT8U EnSts, INT8U Reason, INT8U AmpSts)
{
	__Dnr_Sts  *Sts = tDnrSts;
	
	switch(SysPath)
	{
		case PATH_2G:
		case PATH_LTE:
			
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_2G = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_2G = __RESET;
			Sts->AmpOffCase_2G = Reason;
			Sts->SD_Status_2G = AmpSts;
			
//			PwrAlarmTimer.FwdAmpOnOff_2G = 14;

			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE = __RESET;
			Sts->AmpOffCase_LTE = Reason;
			Sts->SD_Status_LTE = AmpSts;
			
//			PwrAlarmTimer.FwdAmpOnOff_LTE = 14;

			if( SysPath == PATH_2G)		Sts->FwdAmpOnOff_LTE = Sts->FwdAmpOnOff_2G;
			if( SysPath == PATH_LTE)	Sts->FwdAmpOnOff_2G  = Sts->FwdAmpOnOff_LTE;
			
			break;

			
		case PATH_3G:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_3G = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_3G = __RESET;
			Sts->AmpOffCase_3G = Reason;
			Sts->SD_Status_3G = AmpSts;
//			PwrAlarmTimer.FwdAmpOnOff_3G = 14;
			
			break;


			
		case PATH_LTEA:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __RESET;
			Sts->AmpOffCase_LTE_A2 = Reason;
			Sts->SD_Status_LTE_A2 = AmpSts;
			
//			PwrAlarmTimer.FwdAmpOnOff_LTE_A2 = 14;
			break;
	}
	
}
#endif


#if 0
void AmpBitReason(INT8U SysPath, INT8U EnSts, INT8U Reason, INT8U AmpSts)
{
	__Dnr_Sts  *Sts = tDnrSts;
	
	switch(SysPath)
	{
		case PATH_2G:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_2G = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_2G = __RESET;
			Sts->AmpOffCase_2G = Reason;
			Sts->SD_Status_2G = AmpSts;
			
			PwrAlarmTimer.FwdAmpOnOff_2G = 25;
			break;
		case PATH_3G:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_3G = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_3G = __RESET;
			Sts->AmpOffCase_3G = Reason;
			Sts->SD_Status_3G = AmpSts;
			PwrAlarmTimer.FwdAmpOnOff_3G = 25;
			
			break;

		case PATH_LTE:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE = __RESET;
			Sts->AmpOffCase_LTE = Reason;
			Sts->SD_Status_LTE = AmpSts;
			
			PwrAlarmTimer.FwdAmpOnOff_LTE = 25;
			break;
			
		case PATH_LTEA:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __RESET;
			Sts->AmpOffCase_LTE_A2 = Reason;
			Sts->SD_Status_LTE_A2 = AmpSts;
			
			PwrAlarmTimer.FwdAmpOnOff_LTE_A2 = 25;
			break;
	}
	
}
#endif

INT8U BalanceModeFunc(INT8U IsItPath)
{
	INT8U rVal = 0;
	INT8S LimitLvl;
	INT8S DetLvl;
	INT8S RecoveryLvl;
	INT16U tmpTimer = TimerBalance_2G + IsItPath;

	__Dnr_Sts *Sts = tDnrSts;

	__SleepStr *Sleep = &mSleep[IsItPath]; 


	if( Sts->BalanceModeOnOff.OnOff == Enable)
	{
		DetLvl = Sts->BalanceModePwr[IsItPath];
		LimitLvl = mSleep[IsItPath].SleepStep + Sts->BalanceModeDetOffset[IsItPath];
		RecoveryLvl= mSleep[IsItPath].SleepRecovery;

		if(mSleep[IsItPath].IsItSLP == RESET)
		{
			if( DetLvl <= LimitLvl)
			{
				Sts->BalanceTurnOnOff[IsItPath] = Alarm;
		
				if(TimeOverCheck(tmpTimer))
				{
					TimerRegist(tmpTimer, Time100mSec*5L);
					Sleep->SleepCnt++;
					if(Sleep->SleepCnt >= Sts->BalanceModeOnOff.Time*2L)
					{
						mSleep[IsItPath].IsItSLP = 1;
						Sleep->SleepCnt = SleepAlarmCheckTime *2L;
					}
				}
			}
			else
			{
				Sts->BalanceTurnOnOff[IsItPath] = Normal;;
				Sleep->SleepCnt = 0;
				TimerRegist(tmpTimer, Time100mSec*5L);
			}
		}

		if (( DetLvl >= RecoveryLvl)&&(mSleep[IsItPath].IsItSLP == SET))
		{
			Sts->BalanceTurnOnOff[PATH_2G] = Normal;;
			Sleep->SleepCnt = 0;
			Sleep->IsItSLP = 0;
			TimerRegist(tmpTimer, Time100mSec*5L);
		}
	}
	else
	{
		Sts->BalanceTurnOnOff[IsItPath] = Normal;
		mSleep[IsItPath].IsItSLP = 0;
		mSleep[IsItPath].SleepCnt = 0;
		mSleep[IsItPath].IsItSLP = Normal;
	}
	return rVal;
}

void BalanceMode(void)
{
	INT8U i = 0;
	__Dnr_Sts *Sts = tDnrSts;

	for(i = 0; i < SysPathMax; i++)
	{
		BalanceModeFunc(i);
	}

	if( Sts->BalanceModeOnOff.OnOff == Enable)
	{
		if((mSleep[PATH_2G].IsItSLP == SET)&&(mSleep[PATH_LTE].IsItSLP == SET))
		{
			Sts->BalanceModeAttn[PATH_2G] = DIGATTENMAX;
			Sts->BalanceModeAttn[PATH_LTE] = DIGATTENMAX;
		}
		else
		{
			Sts->BalanceModeAttn[PATH_2G] = 0;
			Sts->BalanceModeAttn[PATH_LTE] = 0;
		}


		if((mSleep[PATH_LTEA].IsItSLP == SET))
		{
			Sts->BalanceModeAttn[PATH_LTEA] = DIGATTENMAX;
		}
		else
		{
			Sts->BalanceModeAttn[PATH_LTEA] = 0;
		}

		if((mSleep[PATH_3G].IsItSLP == SET))
		{
			Sts->BalanceModeAttn[PATH_3G] = DIGATTENMAX;
		}
		else
		{
			Sts->BalanceModeAttn[PATH_3G] = 0;
		}
	}
	else
	{
		Sts->BalanceModeAttn[PATH_2G] = 0;
		Sts->BalanceModeAttn[PATH_LTE] = 0;
		Sts->BalanceModeAttn[PATH_LTEA] = 0;
		Sts->BalanceModeAttn[PATH_3G] = 0;
	}
	
	Sts->CurrBalanceAtt_CDMA = Sts->BalanceModeAttn[PATH_2G];
	if(CurrRvsBalanceAtt_2G != Sts->CurrBalanceAtt_CDMA)
	{
		CurrRvsBalanceAtt_2G = Sts->CurrBalanceAtt_CDMA;
		AttnDataOutput(_RvsBalanceAtt_2G_SEL, Sts->CurrBalanceAtt_CDMA);
		
//		SerPtr->printf("CurrRvsBalanceAtt_2G[%d]\n", CurrRvsBalanceAtt_2G);
	}
	
	Sts->CurrBalanceAtt_WCDMA = Sts->BalanceModeAttn[PATH_3G];
	if(CurrRvsBalanceAtt_3G != Sts->CurrBalanceAtt_WCDMA)
	{
		CurrRvsBalanceAtt_3G = Sts->CurrBalanceAtt_WCDMA;
		AttnDataOutput(_RvsBalanceAtt_3G_SEL, Sts->CurrBalanceAtt_WCDMA);
	}
	
	Sts->CurrBalanceAtt_LTE_A = Sts->BalanceModeAttn[PATH_LTEA];
	if(CurrRvsBalanceAtt_LTEA != Sts->CurrBalanceAtt_LTE_A)
	{
		CurrRvsBalanceAtt_LTEA = Sts->CurrBalanceAtt_LTE_A;
		AttnDataOutput(_RvsBalanceAtt_LTEA_SEL, Sts->CurrBalanceAtt_LTE_A);
	}


	Sts->ModuleAlarm.Main.Data[0] = 0x00;

	if(Sts->BalanceTurnOnOff[PATH_2G] == Alarm) 	Sts->ModuleAlarm.Main.SleepMode_2G = Alarm;
	if(Sts->BalanceTurnOnOff[PATH_LTE] == Alarm) 	Sts->ModuleAlarm.Main.SleepMode_LTE = Alarm;
	if(Sts->BalanceTurnOnOff[PATH_LTEA] == Alarm) 	Sts->ModuleAlarm.Main.SleepMode_LTE_A2 = Alarm;
	if(Sts->BalanceTurnOnOff[PATH_3G] == Alarm) 	Sts->ModuleAlarm.Main.SleepMode_3G = Alarm;
}


void AlarmInitialize(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	Sts->Flag.FwdOutLowerLmtFail_2G		= SET;
	Sts->Flag.FwdOutUpperLmtFail_2G		= SET;
	Sts->Flag.FwdInUpperLmtFail_2G		= SET;
	Sts->Flag.OverInAlarm_3G			= SET;
	Sts->Flag.FwdOutLowerLmtFail_3G 	= SET;
	Sts->Flag.FwdOutUpperLmtFail_3G 	= SET;
	Sts->Flag.FwdInUpperLmtFail_3G		= SET;

	Sts->Flag.FwdOutLowerLmtFail_LTE_A1	= SET;
	Sts->Flag.FwdOutUpperLmtFail_LTE_A1	= SET;
	Sts->Flag.FwdInUpperLmtFail_LTE_A1	= SET;
	Sts->Flag.OverInAlarm_CDMALTE		= SET;
	Sts->Flag.FwdOutLowerLmtFail_LTE	= SET;
	Sts->Flag.FwdOutUpperLmtFail_LTE	= SET;
	Sts->Flag.FwdInUpperLmtFail_LTE 	= SET;

	Sts->Flag.Fwd1OutLowerLmtFail_LTE	= SET;
	Sts->Flag.Fwd1OutUpperLmtFail_LTE	= SET;
	Sts->Flag.Fwd1InUpperLmtFail_LTE	= SET;
	Sts->Flag.FwdOutLowerLmtFail_LTE_A2	= SET;
	Sts->Flag.FwdOutUpperLmtFail_LTE_A2	= SET;
	Sts->Flag.FwdInUpperLmtFail_LTE_A2	= SET;
	Sts->Flag.OverInAlarm_LTE_A			= SET;

	Sts->Flag.Fwd1OutLowerLmtFail_LTE_A2= SET;
	Sts->Flag.Fwd1OutUpperLmtFail_LTE_A2= SET;
	Sts->Flag.Fwd1InUpperLmtFail_LTE_A2 = SET;
	Sts->Flag.Fwd1OutLowerLmtFail_LTE_A1= SET;
	Sts->Flag.Fwd1OutUpperLmtFail_LTE_A1= SET;
	Sts->Flag.Fwd1InUpperLmtFail_LTE_A1 = SET;

	Sts->Flag.LocalFail_LTE_A2_1		= SET;
	Sts->Flag.LocalFail_LTE_A1_1		= SET;
	Sts->Flag.LocalFail_LTE_1			= SET;
	Sts->Flag.LocalFail_LTE_A2 			= SET;
	Sts->Flag.LocalFail_LTE_A1 			= SET;
	Sts->Flag.LocalFail_CDMALTE 		= SET;
	Sts->Flag.LocalFail_3G 				= SET;

	Sts->Flag.Rvs1OutUpperLmtFail_LTE_A1= SET;
	Sts->Flag.Rvs1OutUpperLmtFail_LTE	= SET;
	Sts->Flag.RvsOutUpperLmtFail_LTE_A2 = SET;
	Sts->Flag.RvsOutUpperLmtFail_LTE_A1 = SET;
	Sts->Flag.RvsOutUpperLmtFail_LTE	= SET;
	Sts->Flag.RvsOutUpperLmtFail_2G 	= SET;
	Sts->Flag.RvsOutUpperLmtFail_3G 	= SET;

	Sts->Flag.FwdAmp1OnOff_LTE_A1			= SET;
	Sts->Flag.FwdAmp1OnOff_LTE 				= SET;
	Sts->Flag.FwdAmpOnOff_LTE_A2			= SET;
	Sts->Flag.FwdAmpOnOff_LTE_A1			= SET;
	Sts->Flag.FwdAmpOnOff_2G				= SET;
	Sts->Flag.FwdAmpOnOff_LTE				= SET;
	Sts->Flag.FwdAmpOnOff_3G				= SET;

	Sts->Flag.FwdAmp1OnOff_LTE_A2			= SET;
	Sts->Flag.Rvs1OutUpperLmtFail_LTE_A2	= SET;
	Sts->Flag.ACFail						= SET;
}




void RvsOSCAlarmCountFunc(INT8U SysPath, INT8U Path)
{
//	ShutdownFunc(PATH_2G, SD_FI_2G);
	__Dnr_Sts  *Sts = tDnrSts;

	switch(Path)
	{
		case SD_RO_2G:
			if(Sts->CurrRvsOSCAlarmCount_2G++ >= 127) Sts->CurrRvsOSCAlarmCount_2G = 127;

		break;

		case SD_RO_LTE:
			if(Sts->CurrRvsOSCAlarmCount_LTE++ >= 127) Sts->CurrRvsOSCAlarmCount_LTE = 127;

		break;

		case SD_RO_3G:
			if(Sts->CurrRvsOSCAlarmCount_3G++ >= 127) Sts->CurrRvsOSCAlarmCount_3G = 127;

		break;

		case SD_RO_LTE_A2:
			if(Sts->CurrRvsOSCAlarmCount_LTE_A2++ >= 127) Sts->CurrRvsOSCAlarmCount_LTE_A2 = 127;

		break;

	
		default :
			
		break;
	}
}


//=======================================================================//
// End of Source File
//=======================================================================//

