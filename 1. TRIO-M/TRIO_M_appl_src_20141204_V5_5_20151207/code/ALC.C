 
/*********************************************
* File Name          : alc.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/

#define ALC_C

#include "../include/main.h"

#include <stdlib.h>

  
void ADC_Init(void)
{
	OSTaskCreate(ADC_Task, (void *)0, (OS_STK *)&AdcTaskStk[ADC_START_STK_SIZE - 1],ADC_START_PRIO);
}

void ADC_Task(void * pdata)
{
	pdata = pdata;

	while(1)
	{
		while((WRCS_DownLoadGiveupTimerSet(NULL)))
		{
			OSTimeDly(1000L);
		}

		while(!WRCS_DownLoadGiveupTimerSet(NULL))
		{
			ReadAdcValue();
			OSTimeDly(20L*1L);
		}

		OSTimeDly(1000L*1L);
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


INT8S Table_Operation(INT8S Pwr,INT8S tGain,INT8S tAttn,INT8S tOffset)
{
	INT8S retval;
	if(Pwr != (-60*2))
	{
		retval = Pwr + (tGain - tAttn) + tOffset;
	}
	else retval = (-60*2);

	return retval;
}


#define __AvgMAXGARBAGE	5
#define __AvgMINGARBAGE	80

#define __PeakMAXGARBAGE	20
#define __PeakMINGARBAGE	10

void ReadAdcValue(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT16U i;
	INT16U SUM = 0;
	INT16U min, max;
	INT16U tSUM = 16;

	for(i = 0 ; i <= (__ADCMAX-2); i++)
	{
		SUM += ADC_CheckFinish(i);
	}

	if( SUM == tSUM)
	{
		if( iAdcIndex == 0)
		{
			SelectSort_1(ADC_AVR[ADC_Channel_6],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdInVolt_CDMALTE] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_7],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_CDMALTE] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_8],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsInVolt_3G] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_9],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdOutAvgVolt_LTE_A2]  = (ADC_DATA[FwdOutAvgVolt_LTE_A2]*1L + max)/2L;
			ADC_DATA[FwdOutPeakVolt_LTE_A2] = (ADC_DATA[FwdOutPeakVolt_LTE_A2]*1L + min)/2L;

			SelectSort_1(ADC_AVR[ADC_Channel_10],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdInVolt_LTE_A] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_11],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Fwd1InVolt_LTE] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_12],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Rvs1OutVolt_LTE] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_13],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Fwd1OutAvgVolt_LTE_A2] = (ADC_DATA[Fwd1OutAvgVolt_LTE_A2]*1L + max)/2L;
			ADC_DATA[Fwd1OutPeakVolt_LTE_A2] = (ADC_DATA[Fwd1OutPeakVolt_LTE_A2]*1L + min)/2L;

			SelectSort_1(ADC_AVR[ADC_Channel_14],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Rvs1OutVolt_LTE_A2] = max;

			ADC_DATA[Curr_Temp] = ADC_AVR[ADC_Channel_15][0];
			Sts->CurrentTemp = ReadEnvTempTable(ADC_Channel_15)/10+ Sts->TempOffset;
	
		}
		else if( iAdcIndex == 1)
		{
			SelectSort_1(ADC_AVR[ADC_Channel_6],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdOutAvgVolt_CDMALTE] = (ADC_DATA[FwdOutAvgVolt_CDMALTE]*1L + max)/2L;
			ADC_DATA[FwdOutPeakVolt_CDMALTE] = (ADC_DATA[FwdOutPeakVolt_CDMALTE]*1L + min)/2L;

			SelectSort_1(ADC_AVR[ADC_Channel_7],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdInVolt_3G] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_8],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_3G] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_10],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdOutAvgVolt_LTE_A] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_11],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Fwd1OutAvgVolt_LTE] = (ADC_DATA[Fwd1OutAvgVolt_LTE]*1L + max)/2L;
			ADC_DATA[Fwd1OutPeakVolt_LTE] = (ADC_DATA[Fwd1OutPeakVolt_LTE]*1L + min)/2L;

			SelectSort_1(ADC_AVR[ADC_Channel_12],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdInVolt_LTE_A_1] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_14],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsInVolt_LTE_A_1] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_15],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[PSUDCVolt] = max;
 		}

 		else if( iAdcIndex == 2)
		{
			SelectSort_1(ADC_AVR[ADC_Channel_7],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdOutAvgVolt_3G] 	= min;
			ADC_DATA[FwdOutPeakVolt_3G]	= max;
 
			SelectSort_1(ADC_AVR[ADC_Channel_8],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdOutAvgVolt_LTE_A1] = (ADC_DATA[FwdOutAvgVolt_LTE_A1]*1L + max)/2L;
			ADC_DATA[FwdOutPeakVolt_LTE_A1] = (ADC_DATA[FwdOutPeakVolt_LTE_A1]*1L + min)/2L;

			SelectSort_1(ADC_AVR[ADC_Channel_9],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_LTE_A1] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_10],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsInVolt_LTE_A] = max;

 			SelectSort_1(ADC_AVR[ADC_Channel_12],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Fwd1OutAvgVolt_LTE_A1] = (ADC_DATA[Fwd1OutAvgVolt_LTE_A1]*1L + max)/2L;
			ADC_DATA[Fwd1OutPeakVolt_LTE_A1] = (ADC_DATA[Fwd1OutPeakVolt_LTE_A1]*1L + min)/2L;
			
			SelectSort_1(ADC_AVR[ADC_Channel_13],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdOutAvgVolt_LTE_A_1] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_14],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_LTE_A_1] = max;
			
			ADC_DATA[DCOutVolt] =  ADC_AVR[ADC_Channel_15][0];;
 		}
  		else if( iAdcIndex == 3)
		{
			SelectSort_1(ADC_AVR[ADC_Channel_0],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, 10, 50, __ADCAVR);

			ADC_DATA[FwdOutAvgVolt_2G] = (ADC_DATA[FwdOutAvgVolt_2G]*1L + max)/2L;
			ADC_DATA[FwdOutPeakVolt_2G] = (ADC_DATA[FwdOutPeakVolt_2G]*1L + min)/2L;

			SelectSort_1(ADC_AVR[ADC_Channel_2],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_2G] = max;
			
			SelectSort_1(ADC_AVR[ADC_Channel_3],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[FwdOutAvgVolt_LTE] = (ADC_DATA[FwdOutAvgVolt_LTE]*1L + max)/2L;
			ADC_DATA[FwdOutPeakVolt_LTE] = (ADC_DATA[FwdOutPeakVolt_LTE]*1L + min)/2L;
 
			SelectSort_1(ADC_AVR[ADC_Channel_5],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_LTE] = max;
			
			SelectSort_1(ADC_AVR[ADC_Channel_6],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsInVolt_CDMALTE] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_9],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_LTE_A2] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_10],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[RvsOutVolt_LTE_A] = max;

			SelectSort_1(ADC_AVR[ADC_Channel_11],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Rvs1InVolt_LTE] = max;
			
			SelectSort_1(ADC_AVR[ADC_Channel_13],&min, &max, __AvgMAXGARBAGE, __AvgMINGARBAGE, __PeakMAXGARBAGE, __PeakMINGARBAGE, __ADCAVR);
			ADC_DATA[Rvs1OutVolt_LTE_A1] = max;

 		}

 		Sts->DetVolt.FwdOutAvgVolt_2G.Data			= (ADC_DATA[FwdOutAvgVolt_2G]);
		Sts->DetVolt.FwdOutPeakVolt_2G.Data 		= (ADC_DATA[FwdOutPeakVolt_2G]);
		Sts->DetVolt.RvsOutVolt_2G.Data 			= (ADC_DATA[RvsOutVolt_2G]);
		
		Sts->DetVolt.FwdOutAvgVolt_LTE.Data 		= (ADC_DATA[FwdOutAvgVolt_LTE]);
		Sts->DetVolt.FwdOutPeakVolt_LTE.Data		= (ADC_DATA[FwdOutPeakVolt_LTE]);
		Sts->DetVolt.RvsOutVolt_LTE.Data			= (ADC_DATA[RvsOutVolt_LTE]);
		
		Sts->DetVolt.FwdInVolt_CDMALTE.Data 		= (ADC_DATA[FwdInVolt_CDMALTE]);
		Sts->DetVolt.FwdOutAvgVolt_CDMALTE.Data 	= (ADC_DATA[FwdOutAvgVolt_CDMALTE]);
		Sts->DetVolt.FwdOutPeakVolt_CDMALTE.Data	= (ADC_DATA[FwdOutPeakVolt_CDMALTE]);
		Sts->DetVolt.RvsInVolt_CDMALTE.Data 		= (ADC_DATA[RvsInVolt_CDMALTE]);
		Sts->DetVolt.RvsOutVolt_CDMALTE.Data		= (ADC_DATA[RvsOutVolt_CDMALTE]);
		
		Sts->DetVolt.FwdOutAvgVolt_LTE_A1.Data		= (ADC_DATA[FwdOutAvgVolt_LTE_A1]);
		Sts->DetVolt.FwdOutPeakVolt_LTE_A1.Data 	= (ADC_DATA[FwdOutPeakVolt_LTE_A1]);
		Sts->DetVolt.RvsOutVolt_LTE_A1.Data 		= (ADC_DATA[RvsOutVolt_LTE_A1]);
		
		Sts->DetVolt.FwdOutAvgVolt_LTE_A2.Data		= (ADC_DATA[FwdOutAvgVolt_LTE_A2]);
		Sts->DetVolt.FwdOutPeakVolt_LTE_A2.Data 	= (ADC_DATA[FwdOutPeakVolt_LTE_A2]);
		Sts->DetVolt.RvsOutVolt_LTE_A2.Data 		= (ADC_DATA[RvsOutVolt_LTE_A2]);
		
		Sts->DetVolt.FwdInVolt_LTE_A.Data			= (ADC_DATA[FwdInVolt_LTE_A]);
		Sts->DetVolt.FwdOutAvgVolt_LTE_A.Data		= (ADC_DATA[FwdOutAvgVolt_LTE_A]);
		Sts->DetVolt.RvsInVolt_LTE_A.Data			= (ADC_DATA[RvsInVolt_LTE_A]);
		Sts->DetVolt.RvsOutVolt_LTE_A.Data			= (ADC_DATA[RvsOutVolt_LTE_A]);
		
		Sts->DetVolt.FwdInVolt_3G.Data				= (ADC_DATA[FwdInVolt_3G]);
		Sts->DetVolt.FwdOutAvgVolt_3G.Data			= (ADC_DATA[FwdOutAvgVolt_3G]);
		Sts->DetVolt.FwdOutPeakVolt_3G.Data 		= (ADC_DATA[FwdOutPeakVolt_3G]);
		Sts->DetVolt.RvsInVolt_3G.Data				= (ADC_DATA[RvsInVolt_3G]);
		Sts->DetVolt.RvsOutVolt_3G.Data 			= (ADC_DATA[RvsOutVolt_3G]);
		
		Sts->DetVolt.PSUDCVolt.Data 				= (ADC_DATA[PSUDCVolt]);
		Sts->DetVolt.PSUDCVolt.Data 				= (INT16U)(Sts->DetVolt.PSUDCVolt.Data * Sts->DCOffSet/1000);

		Sts->Det1Volt.Fwd1InVolt_LTE.Data			= (ADC_DATA[Fwd1InVolt_LTE]);
		Sts->Det1Volt.Fwd1OutAvgVolt_LTE.Data		= (ADC_DATA[Fwd1OutAvgVolt_LTE]);
		Sts->Det1Volt.Fwd1OutPeakVolt_LTE.Data		= (ADC_DATA[Fwd1OutPeakVolt_LTE]);
		Sts->Det1Volt.Rvs1InVolt_LTE.Data			= (ADC_DATA[Rvs1InVolt_LTE]);
		Sts->Det1Volt.Rvs1OutVolt_LTE.Data			= (ADC_DATA[Rvs1OutVolt_LTE]);
		
		Sts->Det1Volt.Fwd1OutAvgVolt_LTE_A1.Data	= (ADC_DATA[Fwd1OutAvgVolt_LTE_A1]);
		Sts->Det1Volt.Fwd1OutPeakVolt_LTE_A1.Data	= (ADC_DATA[Fwd1OutPeakVolt_LTE_A1]);
		Sts->Det1Volt.Rvs1OutVolt_LTE_A1.Data		= (ADC_DATA[Rvs1OutVolt_LTE_A1]);
		
		Sts->Det1Volt.Fwd1OutAvgVolt_LTE_A2.Data	= (ADC_DATA[Fwd1OutAvgVolt_LTE_A2]);
		Sts->Det1Volt.Fwd1OutPeakVolt_LTE_A2.Data	= (ADC_DATA[Fwd1OutPeakVolt_LTE_A2]);
		Sts->Det1Volt.Rvs1OutVolt_LTE_A2.Data		= (ADC_DATA[Rvs1OutVolt_LTE_A2]);
		
		Sts->Det1Volt.FwdInVolt_LTE_A_1.Data		= (ADC_DATA[FwdInVolt_LTE_A_1]);
		Sts->Det1Volt.FwdOutAvgVolt_LTE_A_1.Data	= (ADC_DATA[FwdOutAvgVolt_LTE_A_1]);
		Sts->Det1Volt.RvsInVolt_LTE_A_1.Data		= (ADC_DATA[RvsInVolt_LTE_A_1]);
		Sts->Det1Volt.RvsOutVolt_LTE_A_1.Data		= (ADC_DATA[RvsOutVolt_LTE_A_1]);

	}
	
	if( SUM >= tSUM)
	{
		if( ++iAdcIndex > 3) iAdcIndex = 0;
		ADC_Select(iAdcIndex);
		if(iAdcIndex == 0)
		{
			ADC_ChannelEnable(ADC_Channel_6);
			ADC_ChannelEnable(ADC_Channel_7);
			ADC_ChannelEnable(ADC_Channel_8);
			ADC_ChannelEnable(ADC_Channel_9);
			ADC_ChannelEnable(ADC_Channel_10);
			ADC_ChannelEnable(ADC_Channel_11);
			ADC_ChannelEnable(ADC_Channel_12);
			ADC_ChannelEnable(ADC_Channel_13);
			ADC_ChannelEnable(ADC_Channel_14);	
			ADC_ChannelEnable(ADC_Channel_15);
		}
		else if(iAdcIndex == 1)
		{
			ADC_ChannelEnable(ADC_Channel_6);
			ADC_ChannelEnable(ADC_Channel_7);
			ADC_ChannelEnable(ADC_Channel_8);
			ADC_ChannelEnable(ADC_Channel_10);
			ADC_ChannelEnable(ADC_Channel_11);
			ADC_ChannelEnable(ADC_Channel_12);
			ADC_ChannelEnable(ADC_Channel_14);	
			ADC_ChannelEnable(ADC_Channel_15);
		}
		else if(iAdcIndex == 2)
		{
			ADC_ChannelEnable(ADC_Channel_7);
			ADC_ChannelEnable(ADC_Channel_8);
			ADC_ChannelEnable(ADC_Channel_9);
			ADC_ChannelEnable(ADC_Channel_10);
			ADC_ChannelEnable(ADC_Channel_12);
			ADC_ChannelEnable(ADC_Channel_13);
			ADC_ChannelEnable(ADC_Channel_14);	
			ADC_ChannelEnable(ADC_Channel_15);
		}
		else if(iAdcIndex == 3)
		{
			ADC_ChannelEnable(ADC_Channel_0);
			ADC_ChannelEnable(ADC_Channel_2);
			ADC_ChannelEnable(ADC_Channel_3);
			ADC_ChannelEnable(ADC_Channel_5);

			ADC_ChannelEnable(ADC_Channel_6);
			ADC_ChannelEnable(ADC_Channel_9);
			ADC_ChannelEnable(ADC_Channel_10);
			ADC_ChannelEnable(ADC_Channel_11);
			ADC_ChannelEnable(ADC_Channel_13);
		}
	}
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

		// 	 '4. 출력=CDMA Fwd 출력 Avg Det+(15- CDMA FWD ATT 2)
		tmppwrout = Sts->DetPwr.FwdOutAvgPwr_2G;
		TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
		Sts->FwdOutPwr_2G[0] = dptr[0];
		Sts->FwdOutPwr_2G[1] = dptr[1];
		
		tmpx10 = Sts->DetPwr.FwdOutPeakPwr_2G;
		TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
		Sts->FwdOutPwrPeak_2G[0] = dptr[0];
		Sts->FwdOutPwrPeak_2G[1] = dptr[1];

		// 	 '4. 입력=CDMA Fwd 출력 Avg Det-81+CDMA&LTE#0 공통부 FWD ATT+CDMA FWD ATT 1-(15- CDMA FWD ATT 2)
		//5. 입력=DET4-81+ATT1+ATT4+(15-ATT5)
		if( Sts->DetPwr.FwdOutAvgPwr_2G == 0)
		{
			Sts->FwdInPwr_2G = NoSignal;
		}
		else
		{
			tmppwrin= tmppwrout - Gain_2G + Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_2G ;
			Sts->FwdInPwr_2G = abs(tmppwrin/2) - Sts->FwdInPwrOffset_2G/2;
		}

		///5. GAIN= 81-ATT1-ATT2+(15-ATT3)		
		Sts->FwdGain_2G = Gain_2G - Sts->FwdAttn1_CDMALTE - Sts->FwdAttn1_2G ;
		Sts->FwdGain_2G = MinMaxAttnCheck(Sts->FwdGain_2G, Gain_2G,FwdMinGain_2G);


		if(tDnrSts->LTE15MUse == __NOTUSE)
		{
			tmppwrout = Sts->DetPwr.RvsOutPwr_2G - CurrRvsAgcAttn_2G;
			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			Sts->RvsOutPwr_2G[0] = dptr[0];
			Sts->RvsOutPwr_2G[1] = dptr[1];

	
			tmppwrin = Sts->DetPwr.RvsOutPwr_2G - Gain_2G + Sts->RvsAlcAttn_2G;
			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_2G[0] = dptr[0];
			Sts->RvsInPwr_2G[1] = dptr[1];
		}


		Sts->RvsGainSts_2G = Gain_2G - CurrRvsAgcAttn_2G - Sts->RvsAlcAttn_2G ;
		Sts->RvsGainSts_2G = MinMaxAttnCheck(Sts->RvsGainSts_2G, Gain_2G,RvsMinGain_2G);
		if(Sts->AlmSts.FwdAmpOnOff_2G == Disable) 	Sts->FwdInPwr_2G		= NoSignal;
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
		//		'4. 출력=LTE Fwd 출력 Avg Det+(15- LTE FWD ATT 2)
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
		//		'4. 출력=LTE Fwd 출력 Avg Det+(15- LTE FWD ATT 2)
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
				tmppwrin = tmppwrout - Gain_LTE + Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_LTE;
				Sts->FwdInPwr_LTE = abs(tmppwrin/2)- Sts->FwdInPwrOffset_LTE/2;
			}
			
	//		GAIN = 출력-입력
			Sts->FwdGain_LTE = Gain_LTE - Sts->FwdAttn1_CDMALTE - Sts->FwdAttn1_LTE;
			Sts->FwdGain_LTE = MinMaxAttnCheck(Sts->FwdGain_LTE, Gain_LTE,FwdMinGain_LTE);

			if(tDnrSts->LTE15MUse == __NOTUSE)
			{
				tmppwrout = Sts->DetPwr.RvsOutPwr_LTE - CurrRvsAgcAttn_LTE;
				TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
				Sts->RvsOutPwr_LTE[0] = dptr[0];
				Sts->RvsOutPwr_LTE[1] = dptr[1];
		
		//		5. 입력=LTE RVS 출력 DET-81+CDMA&LTE#0 공통부 RVS ATT + LTE RVS ATT 1	
				tmpx10 = Sts->DetPwr.RvsOutPwr_LTE - Gain_LTE + Sts->RvsAlcAttn_LTE;
				Sts->CurrRvsInPwr_LTE =abs(tmpx10/2);
				tmppwrin = tmpx10;
				ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
				Sts->RvsInPwr_LTE[0] = dptr[0];
				Sts->RvsInPwr_LTE[1] = dptr[1];
			}

			Sts->RvsGainSts_LTE = Gain_LTE - CurrRvsAgcAttn_LTE - Sts->RvsAlcAttn_LTE;
			Sts->RvsGainSts_LTE = MinMaxAttnCheck(Sts->RvsGainSts_LTE, Gain_LTE,RvsMinGain_LTE);
		}
		if(Sts->AlmSts.FwdAmpOnOff_LTE 	== Disable) 	Sts->FwdInPwr_LTE		= NoSignal;
	}

 	// LTE-A1
 	if(AlarmCheck_LTE_A1 == SET)
	{
		Sts->DetPwr.FwdOutAvgPwr_LTE_A1 	= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_LTE_A1.Data ,Index_FwdOutAvgPwr_LTE_A1,FALSE,&isminval, Sts->FwdOutPwrOffset_LTE_A1); 
		Sts->DetPwr.FwdOutPeakPwr_LTE_A1	= ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_LTE_A1.Data ,Index_FwdOutAvgPwr_LTE_A1,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_LTE_A1);   
		Sts->DetPwr.RvsOutPwr_LTE_A1		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE_A1.Data ,Index_RvsOutPwr_LTE_A1,FALSE,&isminval, Sts->RvsOutPwrOffset_LTE_A1);


		if(iRepeaterType == _TRIO_M)
		{
			INT8S TempOffset = 0;

			TempOffset = PwrTableOffset(Sts->DetPwr.FwdOutAvgPwr_LTE_A1,Index_FwdOutAvgPwr_LTE_A1);
			if( Sts->DetPwr.FwdOutAvgPwr_LTE_A1 == 0) TempOffset = 0;////20121120 Adder
			Sts->DetPwr.FwdOutAvgPwr_LTE_A1 = Sts->DetPwr.FwdOutAvgPwr_LTE_A1 + TempOffset;
			Sts->DetPwr.FwdOutPeakPwr_LTE_A1 = Sts->DetPwr.FwdOutPeakPwr_LTE_A1 + TempOffset;

			
			TempOffset = PwrTableOffset(Sts->DetPwr.RvsOutPwr_LTE_A1,Index_RvsOutPwr_LTE_A1);
			if( Sts->DetPwr.RvsOutPwr_LTE_A1 == LowPwrLmt) TempOffset = 0;////20121120 Adder
			Sts->DetPwr.RvsOutPwr_LTE_A1 = Sts->DetPwr.RvsOutPwr_LTE_A1 + TempOffset;
		}
		

		{
	//		'4.  출력=LTE-A1#0 Fwd 출력 Avg DET+(20-LTE-A1#0 FWD ATT 2)
			tmppwrout = Sts->DetPwr.FwdOutAvgPwr_LTE_A1;
			TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
			Sts->FwdOutPwr_LTE_A1[0] = dptr[0];
			Sts->FwdOutPwr_LTE_A1[1] = dptr[1];


			tmpx10 = Sts->DetPwr.FwdOutPeakPwr_LTE_A1;
			TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
			Sts->FwdOutPwrPeak_LTE_A1[0] = dptr[0];
			Sts->FwdOutPwrPeak_LTE_A1[1] = dptr[1];

			if( Sts->DetPwr.FwdOutAvgPwr_LTE_A1 == 0)
			{
				Sts->FwdInPwr_LTE_A1 = NoSignal;
			}
			else
			{
				tmppwrin = tmppwrout - Gain_LTE_A + Sts->FwdAttn1_LTE_A + Sts->FwdAttn1_LTE_A1 -(ToggleFwdAttn_LTE_A1 - Sts->FwdAttn2_LTE_A1);
				Sts->FwdInPwr_LTE_A1 = abs(tmppwrin/2)- Sts->FwdInPwrOffset_LTE_A1/2;	
			}


	//	5. GAIN= 86-ATT8-ATT9+(20-ATT10)
			Sts->FwdGain_LTE_A1 = Gain_LTE_A - Sts->FwdAttn1_LTE_A - Sts->FwdAttn1_LTE_A1 + (ToggleFwdAttn_LTE_A1 - Sts->FwdAttn2_LTE_A1);
			Sts->FwdGain_LTE_A1 = MinMaxAttnCheck(Sts->FwdGain_LTE_A1, Gain_LTE_A,FwdMinGain_LTE_A);
	
	//		'4. 출력=LTE-A1 RVS 출력-LTE-A1#0 AGC ATT2-LTE-A1#0 AGC ATT3
			tmppwrout = Sts->DetPwr.RvsOutPwr_LTE_A1 - CurrRvsAgcAttn_LTE_A1;
			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			Sts->RvsOutPwr_LTE_A1[0] = dptr[0];
			Sts->RvsOutPwr_LTE_A1[1] = dptr[1];
			
	
	//		5. 입력=LTE-A1 RVS 출력-86+LTE-A1#0&LTE-A2#0 RVS ATT  +LTE-A1#0 ALC ATT1
			tmppwrin = Sts->DetPwr.RvsOutPwr_LTE_A1 - Gain_LTE_A + Sts->RvsAlcAttn_LTE_A1;
			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_LTE_A1[0] = dptr[0];
			Sts->RvsInPwr_LTE_A1[1] = dptr[1];
			
	//		6.GAIN= 출력-입력
			//	5. GAIN= 86-ATT8-ATT9+(20-ATT10)
			Sts->RvsGainSts_LTE_A1 = Gain_LTE_A - CurrRvsAgcAttn_LTE_A1 - Sts->RvsAlcAttn_LTE_A1;
			Sts->RvsGainSts_LTE_A1 = MinMaxAttnCheck(Sts->RvsGainSts_LTE_A1, Gain_LTE_A,RvsMinGain_LTE_A);
		}
		if(Sts->AlmSts.FwdAmpOnOff_LTE_A1	== Disable)		Sts->FwdInPwr_LTE_A1	= NoSignal;
	}

 	// LTE-A2
	{
		Sts->DetPwr.FwdOutAvgPwr_LTE_A2		= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_LTE_A2.Data ,Index_FwdOutAvgPwr_LTE_A2,FALSE,&isminval, Sts->FwdOutPwrOffset_LTE_A2); 
		Sts->DetPwr.FwdOutPeakPwr_LTE_A2	= ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_LTE_A2.Data ,Index_FwdOutAvgPwr_LTE_A2,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_LTE_A2);
		Sts->DetPwr.RvsOutPwr_LTE_A2		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE_A2.Data ,Index_RvsOutPwr_LTE_A2,FALSE,&isminval, Sts->RvsOutPwrOffset_LTE_A2);

		if(iRepeaterType == _TRIO_M)
		{
			INT8S TempOffset = 0;

			TempOffset = PwrTableOffset(Sts->DetPwr.FwdOutAvgPwr_LTE_A2,Index_FwdOutAvgPwr_LTE_A2);
			if( Sts->DetPwr.FwdOutAvgPwr_LTE_A2 == 0) TempOffset = 0; ////20121120 Adder
			Sts->DetPwr.FwdOutAvgPwr_LTE_A2 = Sts->DetPwr.FwdOutAvgPwr_LTE_A2 + TempOffset;
			Sts->DetPwr.FwdOutPeakPwr_LTE_A2 = Sts->DetPwr.FwdOutPeakPwr_LTE_A2 + TempOffset;


			TempOffset = PwrTableOffset(Sts->DetPwr.RvsOutPwr_LTE_A2,Index_RvsOutPwr_LTE_A2);
			if( Sts->DetPwr.RvsOutPwr_LTE_A2 == LowPwrLmt) TempOffset = 0;////20121120 Adder
			Sts->DetPwr.RvsOutPwr_LTE_A2 = Sts->DetPwr.RvsOutPwr_LTE_A2 + TempOffset;
		}

	
		{
	//		'4.  출력=LTE-A2#0 Fwd 출력 Avg DET+(20-LTE-A2#0 FWD ATT 2)
			tmppwrout = Sts->DetPwr.FwdOutAvgPwr_LTE_A2;
			TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
			Sts->FwdOutPwr_LTE_A2[0] = dptr[0];
			Sts->FwdOutPwr_LTE_A2[1] = dptr[1];

			tmpx10 = Sts->DetPwr.FwdOutPeakPwr_LTE_A2;
			TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
			Sts->FwdOutPwrPeak_LTE_A2[0] = dptr[0];
			Sts->FwdOutPwrPeak_LTE_A2[1] = dptr[1];
			
	
	//		5. 입력=LTE-A2#0 Fwd 출력 Avg DET-86+LTE-A1#0&LTE-A2#0 공통부 FWD ATT+LTE-A2#0 FWD ATT 1-(20-LTE-A2#0 FWD ATT 2)
			if( Sts->DetPwr.FwdOutAvgPwr_LTE_A2 == 0)
			{
				Sts->FwdInPwr_LTE_A2 = NoSignal;
			}
			else
			{
				tmppwrin = tmppwrout - Gain_LTE_A + Sts->FwdAttn1_LTE_A + Sts->FwdAttn1_LTE_A2 -(ToggleFwdAttn_LTE_A2 - Sts->FwdAttn2_LTE_A2);
				Sts->FwdInPwr_LTE_A2 = abs(tmppwrin/2)- Sts->FwdInPwrOffset_LTE_A2/2;	
			}

		//	5. GAIN= 86-ATT8-ATT11+(20-ATT12)
			Sts->FwdGain_LTE_A2 = Gain_LTE_A - Sts->FwdAttn1_LTE_A - Sts->FwdAttn1_LTE_A2 + (ToggleFwdAttn_LTE_A2 - Sts->FwdAttn2_LTE_A2);
			Sts->FwdGain_LTE_A2 = MinMaxAttnCheck(Sts->FwdGain_LTE_A2, Gain_LTE_A,FwdMinGain_LTE_A);
	
	//		'4. 출력=LTE-A2 RVS 출력-LTE-A1#0 AGC ATT2-LTE-A2#0 AGC ATT3
			tmppwrout = Sts->DetPwr.RvsOutPwr_LTE_A2 - CurrRvsAgcAttn_LTE_A2;
			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			Sts->RvsOutPwr_LTE_A2[0] = dptr[0];
			Sts->RvsOutPwr_LTE_A2[1] = dptr[1];

	//		5. 입력=LTE-A1 RVS 출력-86+LTE-A1#0&LTE-A2#0 RVS ATT  +LTE-A1#0 ALC ATT1
			tmppwrin = Sts->DetPwr.RvsOutPwr_LTE_A2 - Gain_LTE_A + Sts->RvsAlcAttn_LTE_A2;
			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_LTE_A2[0] = dptr[0];
			Sts->RvsInPwr_LTE_A2[1] = dptr[1];
			
	//		6.GAIN= 출력-입력
//			Sts->RvsGainSts_LTE_A2 = tmppwrout - tmppwrin;
			Sts->RvsGainSts_LTE_A2 = Gain_LTE_A - CurrRvsAgcAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2;
			Sts->RvsGainSts_LTE_A2 = MinMaxAttnCheck(Sts->RvsGainSts_LTE_A2, Gain_LTE_A,RvsMinGain_LTE_A);
		}
		
		if(Sts->AlmSts.FwdAmpOnOff_LTE_A2	== Disable) 	Sts->FwdInPwr_LTE_A2	= NoSignal;
	}

 	// LTE-A1 LTE-A2
	{
		Sts->DetPwr.FwdInPwr_LTE_A			= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_LTE_A.Data ,Index_FwdInPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdInPwr_LTE_A); 
		Sts->DetPwr.FwdOutAvgPwr_LTE_A		= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_LTE_A.Data ,Index_FwdOutAvgPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.FwdOutAvgPwr_LTE_A); 
		Sts->DetPwr.RvsInPwr_LTE_A			= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_LTE_A.Data ,Index_RvsInPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.RvsInPwr_LTE_A); 
		Sts->DetPwr.RvsOutPwr_LTE_A 		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_LTE_A.Data ,Index_RvsOutPwr_LTE_A,FALSE,&isminval, Sts->DetOffset.RvsOutPwr_LTE_A); 

	}
	
 	// WCDMA
	{
		Sts->DetPwr.FwdInPwr_3G			= ReadPwrTableDnr(Sts->DetVolt.FwdInVolt_3G.Data ,Index_FwdInPwr_3G,FALSE,&isminval, Sts->DetOffset.FwdInPwr_3G); 
		Sts->DetPwr.FwdOutAvgPwr_3G 	= ReadPwrTableDnr(Sts->DetVolt.FwdOutAvgVolt_3G.Data ,Index_FwdOutAvgPwr_3G,FALSE,&isminval, Sts->FwdOutPwrOffset_3G);
		Sts->DetPwr.FwdOutPeakPwr_3G	= ReadPwrTableDnr(Sts->DetVolt.FwdOutPeakVolt_3G.Data ,Index_FwdOutAvgPwr_3G,FALSE,&isminval, Sts->DetOffset.FwdOutPeakPwr_3G); 
		Sts->DetPwr.RvsInPwr_3G 		= ReadPwrTableDnr(Sts->DetVolt.RvsInVolt_3G.Data ,Index_RvsInPwr_3G,FALSE,&isminval, Sts->DetOffset.RvsInPwr_3G); 
		Sts->DetPwr.RvsOutPwr_3G		= ReadPwrTableDnr(Sts->DetVolt.RvsOutVolt_3G.Data ,Index_RvsOutPwr_3G,FALSE,&isminval, Sts->Rvs0OutPwrOffset_3G);


		{
			tmppwrout = Sts->DetPwr.FwdOutAvgPwr_3G;
			TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
			Sts->FwdOutPwr_3G[0] = dptr[0];
			Sts->FwdOutPwr_3G[1] = dptr[1];
			
			tmpx10 = Sts->DetPwr.FwdOutPeakPwr_3G;
			TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
			Sts->FwdOutPwrPeak_3G[0] = dptr[0];
			Sts->FwdOutPwrPeak_3G[1] = dptr[1];

	
	//		5. 입력=DET24-83+ATT18+ATT19
			if( Sts->DetPwr.FwdOutAvgPwr_3G == 0)
			{
				Sts->FwdInPwr_3G = NoSignal;
			}
			else
			{
				tmppwrin = tmppwrout - Gain_3G + Sts->FwdAttn1_3G + Sts->FwdAttn2_3G;
				Sts->FwdInPwr_3G = abs(tmppwrin/2)- Sts->FwdInPwrOffset_3G/2;	
			}
			Sts->FwdGain_3G = Gain_3G - Sts->FwdAttn1_3G - Sts->FwdAttn2_3G;;
			Sts->FwdGain_3G = MinMaxAttnCheck(Sts->FwdGain_3G, Gain_3G,FwdMinGain_3G);


	//		출력=WCDMA RVS 출력-WCDMA RVS ATT 3-WCDMA RVS ATT 4
			tmppwrout = Sts->DetPwr.RvsOutPwr_3G;

			TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
			Sts->RvsOutPwr_3G[0] = dptr[0];
			Sts->RvsOutPwr_3G[1] = dptr[1];
	
	//		입력=WCDMA RVS 출력+WCDMA RVS ATT 1+WCDMA RVS ATT 2
#if 0
			tmppwrin = Sts->DetPwr.RvsOutPwr_3G - Gain_3G + Sts->RvsAttn1_3G + Sts->RvsAttn2_3G;
#endif
	
			tmppwrin = Sts->DetPwr.RvsOutPwr_3G - Gain_3G + Sts->RvsAttn1_3G + Sts->RvsAttn2_3G
			+ Sts->RvsGainBalance_3G*2;


			ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
			Sts->RvsInPwr_3G[0] = dptr[0];
			Sts->RvsInPwr_3G[1] = dptr[1];
	
			Sts->RvsGainSts_3G = Gain_3G - CurrRvsAgcAttn_3G - Sts->RvsAlcAttn_3G;
			Sts->RvsGainSts_3G = MinMaxAttnCheck(Sts->RvsGainSts_3G, Gain_3G,RvsMinGain_3G);
		}
		if(Sts->AlmSts.FwdAmpOnOff_3G == Disable) 	Sts->FwdInPwr_3G		= NoSignal;
	}

	if(iRepeaterType == _TRIO_MM)
	{
		{
			Sts->Det1Pwr.Fwd1InPwr_LTE			= ReadPwrTableDnr(Sts->Det1Volt.Fwd1InVolt_LTE.Data ,Index_Fwd1InPwr_LTE,FALSE,&isminval, Sts->Det1Offset.Fwd1InPwr_LTE); 
			Sts->Det1Pwr.Fwd1OutAvgPwr_LTE		= ReadPwrTableDnr(Sts->Det1Volt.Fwd1OutAvgVolt_LTE.Data ,Index_Fwd1OutAvgPwr_LTE,FALSE,&isminval, Sts->Fwd1OutPwrOffset_LTE);
			Sts->Det1Pwr.Fwd1OutPeakPwr_LTE 	= ReadPwrTableDnr(Sts->Det1Volt.Fwd1OutPeakVolt_LTE.Data ,Index_Fwd1OutAvgPwr_LTE,FALSE,&isminval, Sts->Det1Offset.Fwd1OutPeakPwr_LTE); 
			Sts->Det1Pwr.Rvs1InPwr_LTE			= ReadPwrTableDnr(Sts->Det1Volt.Rvs1InVolt_LTE.Data ,Index_Rvs1InPwr_LTE,FALSE,&isminval, Sts->Det1Offset.Rvs1InPwr_LTE); 
			Sts->Det1Pwr.Rvs1OutPwr_LTE 		= ReadPwrTableDnr(Sts->Det1Volt.Rvs1OutVolt_LTE.Data ,Index_Rvs1OutPwr_LTE,FALSE,&isminval, Sts->Rvs1OutPwrOffset_LTE);
			{
		//		'4. 출력=LTE#1 Fwd 출력 Avg Det
				tmppwrout = Sts->Det1Pwr.Fwd1OutAvgPwr_LTE;
				TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
				Sts->Fwd1OutPwr_LTE[0] = dptr[0];
				Sts->Fwd1OutPwr_LTE[1] = dptr[1];

				tmpx10 = Sts->Det1Pwr.Fwd1OutPeakPwr_LTE;
				TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
				Sts->Fwd1OutPwrPeak_LTE[0] = dptr[0];
				Sts->Fwd1OutPwrPeak_LTE[1] = dptr[1];

		
		//		5. 입력=LTE#1 Fwd 출력 Avg Det-81+LTE#1 FWD ATT1+LTE#1 FWD ATT2
//				if( Sts->Det1Pwr.Fwd1InPwr_LTE == 0)
				if( Sts->Det1Pwr.Fwd1OutAvgPwr_LTE == 0)
				
				{
					Sts->Fwd1InPwr_LTE = NoSignal;
				}
				else
				{
					tmppwrin = tmppwrout - Gain_LTE + Sts->Fwd1Attn1_LTE + Sts->Fwd1Attn2_LTE;
					Sts->Fwd1InPwr_LTE= abs(tmppwrin/2)- Sts->Fwd1InPwrOffset_LTE/2;	
				}
		
		//		GAIN= 출력-입력
				Sts->Fwd1Gain_LTE = Gain_LTE - Sts->Fwd1Attn1_LTE - Sts->Fwd1Attn2_LTE;
				Sts->Fwd1Gain_LTE = MinMaxAttnCheck(Sts->Fwd1Gain_LTE, Gain_LTE,FwdMinGain_LTE);

		
		//		'4. 출력=LTE#1 RVS 출력 DET-LTE#1 RVS ATT3-LTE#1 RVS ATT4
				tmppwrout = Sts->Det1Pwr.Rvs1OutPwr_LTE;
				TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
				Sts->Rvs1OutPwr_LTE[0] = dptr[0];
				Sts->Rvs1OutPwr_LTE[1] = dptr[1];
		
		//		5. 입력=LTE#1 RVS 출력 DET-81+LTE#1 RVS ATT1+LTE#1 RVS ATT2
				tmppwrin = Sts->Det1Pwr.Rvs1OutPwr_LTE - Gain_LTE +Sts->Rvs1Attn1_LTE+ Sts->Rvs1Attn2_LTE;
				ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
				Sts->Rvs1InPwr_LTE[0] = dptr[0];
				Sts->Rvs1InPwr_LTE[1] = dptr[1];
		
		//		GAIN = 출력-입력
				Sts->Rvs1GainSts_LTE = Gain_LTE - CurrRvsAgcAttn_LTE_1 - Sts->Rvs1AlcAttn_LTE;

				Sts->Rvs1GainSts_LTE = MinMaxAttnCheck(Sts->Rvs1GainSts_LTE, Gain_LTE,RvsMinGain_LTE);
			}
			if(Sts->AlmSts.FwdAmp1OnOff_LTE	== Disable) 	Sts->Fwd1InPwr_LTE		= NoSignal;
		}

		 // LTE-A1 #1
		if(AlarmCheck_LTE_A1_1 == SET)
		{
			Sts->Det1Pwr.Fwd1OutAvgPwr_LTE_A1	= ReadPwrTableDnr(Sts->Det1Volt.Fwd1OutAvgVolt_LTE_A1.Data ,Index_Fwd1OutAvgPwr_LTE_A1,FALSE,&isminval, Sts->Fwd1OutPwrOffset_LTE_A1);
			Sts->Det1Pwr.Fwd1OutPeakPwr_LTE_A1	= ReadPwrTableDnr(Sts->Det1Volt.Fwd1OutPeakVolt_LTE_A1.Data ,Index_Fwd1OutAvgPwr_LTE_A1,FALSE,&isminval, Sts->Det1Offset.Fwd1OutPeakPwr_LTE_A1); 
			Sts->Det1Pwr.Rvs1OutPwr_LTE_A1		= ReadPwrTableDnr(Sts->Det1Volt.Rvs1OutVolt_LTE_A1.Data ,Index_Rvs1OutPwr_LTE_A1,FALSE,&isminval, Sts->Rvs1OutPwrOffset_LTE_A1);
			{
		//		'4.  출력=LTE-A1#0 Fwd 출력 Avg DET+(20-LTE-A1#0 FWD ATT 2)
				tmppwrout = Sts->Det1Pwr.Fwd1OutAvgPwr_LTE_A1;
				TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
				Sts->Fwd1OutPwr_LTE_A1[0] = dptr[0];
				Sts->Fwd1OutPwr_LTE_A1[1] = dptr[1];

				tmpx10 = Sts->Det1Pwr.Fwd1OutPeakPwr_LTE_A1;
				TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
				Sts->Fwd1OutPwrPeak_LTE_A1[0] = dptr[0];
				Sts->Fwd1OutPwrPeak_LTE_A1[1] = dptr[1];


		
		//		5. 입력=LTE-A1#0 Fwd 출력 Avg DET-86+LTE-A1#0&LTE-A2#0 공통부 FWD ATT+LTE-A1#0 FWD ATT 1-(20-LTE-A1#0 FWD ATT 2)

				if( Sts->Det1Pwr.Fwd1OutAvgPwr_LTE_A1 == 0)
				{
					Sts->Fwd1InPwr_LTE_A1 = NoSignal;
				}
				else
				{
					tmppwrin = tmppwrout - Gain_LTE_A + Sts->Fwd1Attn1_LTE_A + Sts->Fwd1Attn1_LTE_A1 -(ToggleFwdAttn_LTE_A1_1 - Sts->Fwd1Attn2_LTE_A1);
					Sts->Fwd1InPwr_LTE_A1 = abs(tmppwrin/2)- Sts->Fwd1InPwrOffset_LTE_A1/2; 
				}

		
		//		GAIN = 출력-입력
				Sts->Fwd1Gain_LTE_A1 = Gain_LTE_A - Sts->Fwd1Attn1_LTE_A - Sts->Fwd1Attn1_LTE_A1 + (ToggleFwdAttn_LTE_A1_1- Sts->Fwd1Attn2_LTE_A1);
				Sts->Fwd1Gain_LTE_A1 = MinMaxAttnCheck(Sts->Fwd1Gain_LTE_A1, Gain_LTE_A,FwdMinGain_LTE_A);
		
		//		'4. 출력=LTE-A1 RVS 출력-LTE-A1#0 AGC ATT2-LTE-A1#0 AGC ATT3
				tmppwrout = Sts->Det1Pwr.Rvs1OutPwr_LTE_A1 - CurrRvsAgcAttn_LTE_A1_1;
				TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
				Sts->Rvs1OutPwr_LTE_A1[0] = dptr[0];
				Sts->Rvs1OutPwr_LTE_A1[1] = dptr[1];
		
		//		5. 입력=LTE-A1 RVS 출력-86+LTE-A1#0&LTE-A2#0 RVS ATT  +LTE-A1#0 ALC ATT1
				tmppwrin = Sts->Det1Pwr.Rvs1OutPwr_LTE_A1 - Gain_LTE_A + Sts->RvsAlcAttn_LTE_A1;
				ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
				Sts->Rvs1InPwr_LTE_A1[0] = dptr[0];
				Sts->Rvs1InPwr_LTE_A1[1] = dptr[1];
				
		/// 	6.GAIN=81-LTE RVS ATT 2-LTE RVS ATT 3-CDMA&LTE#0 공통부 RVS ATT - LTE RVS ATT 1
				Sts->Rvs1GainSts_LTE_A1 = Gain_LTE_A - CurrRvsAgcAttn_LTE_A1_1 - Sts->Rvs1AlcAttn_LTE_A1;

				Sts->Rvs1GainSts_LTE_A1 = MinMaxAttnCheck(Sts->Rvs1GainSts_LTE_A1, Gain_LTE_A,RvsMinGain_LTE_A);
			}
			if(Sts->AlmSts.FwdAmp1OnOff_LTE_A1	== Disable)		Sts->Fwd1InPwr_LTE_A1	= NoSignal;
		}

		// LTE-A2 #1
		{
			Sts->Det1Pwr.Fwd1OutAvgPwr_LTE_A2	= ReadPwrTableDnr(Sts->Det1Volt.Fwd1OutAvgVolt_LTE_A2.Data ,Index_Fwd1OutAvgPwr_LTE_A2,FALSE,&isminval, Sts->Fwd1OutPwrOffset_LTE_A2);
			Sts->Det1Pwr.Fwd1OutPeakPwr_LTE_A2	= ReadPwrTableDnr(Sts->Det1Volt.Fwd1OutPeakVolt_LTE_A2.Data ,Index_Fwd1OutAvgPwr_LTE_A2,FALSE,&isminval, Sts->Det1Offset.Fwd1OutPeakPwr_LTE_A2); 
			Sts->Det1Pwr.Rvs1OutPwr_LTE_A2		= ReadPwrTableDnr(Sts->Det1Volt.Rvs1OutVolt_LTE_A2.Data ,Index_Rvs1OutPwr_LTE_A2,FALSE,&isminval, Sts->Rvs1OutPwrOffset_LTE_A2);

			{
		//		'4.  출력=LTE-A2#0 Fwd 출력 Avg DET+(20-LTE-A2#0 FWD ATT 2)
				tmppwrout = Sts->Det1Pwr.Fwd1OutAvgPwr_LTE_A2;

				TwoOutPwrConv((INT8S *)&dptr[0],tmppwrout);
				Sts->Fwd1OutPwr_LTE_A2[0] = dptr[0];
				Sts->Fwd1OutPwr_LTE_A2[1] = dptr[1];

				tmpx10 = Sts->Det1Pwr.Fwd1OutPeakPwr_LTE_A2;
				TwoOutPwrConv((INT8S *)&dptr[0],tmpx10);
				Sts->Fwd1OutPwrPeak_LTE_A2[0] = dptr[0];
				Sts->Fwd1OutPwrPeak_LTE_A2[1] = dptr[1];

		
		//		5. 입력=LTE-A2#0 Fwd 출력 Avg DET-86+LTE-A1#0&LTE-A2#0 공통부 FWD ATT+LTE-A2#0 FWD ATT 1-(20-LTE-A2#0 FWD ATT 2)
				if( Sts->Det1Pwr.Fwd1OutAvgPwr_LTE_A2 == 0)
				{
					Sts->Fwd1InPwr_LTE_A2 = NoSignal;
				}
				else
				{

					tmppwrin = tmppwrout - Gain_LTE_A + Sts->Fwd1Attn1_LTE_A + Sts->Fwd1Attn1_LTE_A2 -(ToggleFwdAttn_LTE_A2_1 - Sts->Fwd1Attn2_LTE_A1);
					Sts->Fwd1InPwr_LTE_A2 = abs(tmppwrin/2)- Sts->Fwd1InPwrOffset_LTE_A2/2;  
				}

		
		//		GAIN = 출력-입력
				Sts->Fwd1Gain_LTE_A2 = Gain_LTE_A - Sts->Fwd1Attn1_LTE_A - Sts->Fwd1Attn1_LTE_A2 + (ToggleFwdAttn_LTE_A2_1- Sts->Fwd1Attn2_LTE_A2);
		
				Sts->Fwd1Gain_LTE_A2 = MinMaxAttnCheck(Sts->Fwd1Gain_LTE_A2, Gain_LTE_A,FwdMinGain_LTE_A);
		
		//		'4. 출력=LTE-A2 RVS 출력-LTE-A1#0 AGC ATT2-LTE-A2#0 AGC ATT3
				tmppwrout = Sts->Det1Pwr.Rvs1OutPwr_LTE_A2 - CurrRvsAgcAttn_LTE_A2_1;
				TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
				Sts->Rvs1OutPwr_LTE_A2[0] = dptr[0];
				Sts->Rvs1OutPwr_LTE_A2[1] = dptr[1];
		
		//		5. 입력=LTE-A1 RVS 출력-86+LTE-A1#0&LTE-A2#0 RVS ATT  +LTE-A1#0 ALC ATT1
				tmppwrin = Sts->Det1Pwr.Rvs1OutPwr_LTE_A2 - Gain_LTE_A + Sts->RvsAlcAttn_LTE_A2;
				ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
				Sts->Rvs1InPwr_LTE_A2[0] = dptr[0];
				Sts->Rvs1InPwr_LTE_A2[1] = dptr[1];
				
		//		6.GAIN= 출력-입력
				Sts->Rvs1GainSts_LTE_A2 = Gain_LTE_A - CurrRvsAgcAttn_LTE_A2_1- Sts->Rvs1AlcAttn_LTE_A2;

				Sts->Rvs1GainSts_LTE_A2 = MinMaxAttnCheck(Sts->Rvs1GainSts_LTE_A2, Gain_LTE_A,RvsMinGain_LTE_A);
			}
			if(Sts->AlmSts.FwdAmp1OnOff_LTE_A2 == Disable) 	Sts->Fwd1InPwr_LTE_A2	= NoSignal;
		}
		// LTE-A1 LTE-A2 #2
		{
			Sts->Det1Pwr.FwdInPwr_LTE_A_1		= ReadPwrTableDnr(Sts->Det1Volt.FwdInVolt_LTE_A_1.Data ,Index_FwdInPwr_LTE_A_1,FALSE,&isminval, Sts->Det1Offset.FwdInPwr_LTE_A_1); 
			Sts->Det1Pwr.FwdOutAvgPwr_LTE_A_1	= ReadPwrTableDnr(Sts->Det1Volt.FwdOutAvgVolt_LTE_A_1.Data ,Index_FwdOutAvgPwr_LTE_A_1,FALSE,&isminval, Sts->Det1Offset.FwdOutAvgPwr_LTE_A_1); 
			Sts->Det1Pwr.RvsInPwr_LTE_A_1		= ReadPwrTableDnr(Sts->Det1Volt.RvsInVolt_LTE_A_1.Data ,Index_RvsInPwr_LTE_A_1,FALSE,&isminval, Sts->Det1Offset.RvsInPwr_LTE_A_1); 
			Sts->Det1Pwr.RvsOutPwr_LTE_A_1		= ReadPwrTableDnr(Sts->Det1Volt.RvsOutVolt_LTE_A_1.Data ,Index_RvsOutPwr_LTE_A_1,FALSE,&isminval, Sts->Det1Offset.RvsOutPwr_LTE_A_1); 
		}
	}
	
 	if(!Sts->TPTL_OnOff)
	{
		INT8S tindex = 0;
		// Hysterisys !!
			 if(Sts->CurrentTemp >= tempIndexHys)		tempIndexHys = Sts->CurrentTemp;
		else if(Sts->CurrentTemp < (tempIndexHys - 1))	tempIndexHys = Sts->CurrentTemp;

		tindex = TemptoIndex(tempIndexHys);
		Sts->FwdTemp_2G 	= vSYS_TABLE->AttnTempTbl[Local_FwdTempAttn_2G].Data[tindex];
		Sts->RvsTemp_2G 	= vSYS_TABLE->AttnTempTbl[Local_RvsTempAttn_2G].Data[tindex];

		Sts->FwdTemp_3G 	= vSYS_TABLE->AttnTempTbl[Local_FwdTempAttn_3G].Data[tindex];
		Sts->RvsTemp_3G 	= vSYS_TABLE->AttnTempTbl[Local_RvsTempAttn_3G].Data[tindex];

		Sts->FwdTemp_LTE	= vSYS_TABLE->AttnTempTbl[Local_FwdTempAttn_LTE].Data[tindex];
		Sts->RvsTemp_LTE	= vSYS_TABLE->AttnTempTbl[Local_RvsTempAttn_LTE].Data[tindex];
		
		Sts->FwdTemp_LTE_A1 = vSYS_TABLE->AttnTempTbl[Local_FwdTempAttn_LTE_A1].Data[tindex];
		Sts->RvsTemp_LTE_A1 = vSYS_TABLE->AttnTempTbl[Local_RvsTempAttn_LTE_A1].Data[tindex];
		Sts->FwdTemp_LTE_A2 = vSYS_TABLE->AttnTempTbl[Local_FwdTempAttn_LTE_A2].Data[tindex];
		Sts->RvsTemp_LTE_A2 = vSYS_TABLE->AttnTempTbl[Local_RvsTempAttn_LTE_A2].Data[tindex];
		
		Sts->Fwd1Temp_LTE	= vSYS_TABLE->AttnTempTbl[Local_Fwd1TempAttn_LTE].Data[tindex];
		Sts->Rvs1Temp_LTE	= vSYS_TABLE->AttnTempTbl[Local_Rvs1TempAttn_LTE].Data[tindex];
		Sts->Fwd1Temp_LTE_A1 = vSYS_TABLE->AttnTempTbl[Local_Fwd1TempAttn_LTE_A1].Data[tindex];
		Sts->Rvs1Temp_LTE_A1 = vSYS_TABLE->AttnTempTbl[Local_Rvs1TempAttn_LTE_A1].Data[tindex];
		Sts->Fwd1Temp_LTE_A2 = vSYS_TABLE->AttnTempTbl[Local_Fwd1TempAttn_LTE_A2].Data[tindex];
		Sts->Rvs1Temp_LTE_A2 = vSYS_TABLE->AttnTempTbl[Local_Rvs1TempAttn_LTE_A2].Data[tindex];
	}
	else
	{
		Sts->FwdTemp_2G 		= 0;
		Sts->RvsTemp_2G  		= 0;
		Sts->FwdTemp_3G  		= 0;
		Sts->RvsTemp_3G 		= 0;
		Sts->FwdTemp_LTE 		= 0;
		Sts->RvsTemp_LTE 		= 0;
		Sts->FwdTemp_LTE_A1		= 0;
		Sts->RvsTemp_LTE_A1 	= 0;
		Sts->FwdTemp_LTE_A2		= 0;
		Sts->RvsTemp_LTE_A2 	= 0;
		Sts->Fwd1Temp_LTE 		= 0;
		Sts->Rvs1Temp_LTE 		= 0;
		Sts->Fwd1Temp_LTE_A1	= 0;
		Sts->Rvs1Temp_LTE_A1 	= 0;
		Sts->Fwd1Temp_LTE_A2	= 0;
		Sts->Rvs1Temp_LTE_A2 	= 0;
	}
}



INT8S PwrTableOffset(INT8S Temp,INT8U tIndex)
{
	INT8S DectVal = 0;

	__Dnr_Sts *Sts = tDnrSts;
////////////////////////////////////////////////
 	if(!Sts->TPTL_OnOff)
	{
		INT8S tindex = 0;
		// Hysterisys !!
			 if(Sts->CurrentTemp >= tempIndexHys)		tempIndexHys = Sts->CurrentTemp;
		else if(Sts->CurrentTemp < (tempIndexHys - 1))	tempIndexHys = Sts->CurrentTemp;

		tindex = TemptoIndex(tempIndexHys);

		if(tIndex == Index_FwdOutAvgPwr_LTE_A1)
		{
			DectVal = FwdOutPwrTemp_LTE_A1[tindex];
		}
		else if(tIndex == Index_RvsOutPwr_LTE_A1)
		{
			DectVal = RvsOutPwrTemp_LTE_A1[tindex];

		}
		else if(tIndex == Index_FwdOutAvgPwr_LTE_A2)
		{
			DectVal = FwdOutPwrTemp_LTE_A2[tindex];

		}
		else if(tIndex == Index_RvsOutPwr_LTE_A2)
		{
			DectVal = RvsOutPwrTemp_LTE_A2[tindex];
		}
	}
	else
	{
		DectVal 		= 0;
	}
	
	return (DectVal);
}



INT16S ReadPwrTableDnr(INT32U AdcValue, INT8U TblID, INT8U roundingoff, INT8U *isminval, INT16S Offset)
{
	INT8S tIndex = 0;
	INT8S tLocation = 0;
	INT8S tPwrLocation = 0;

	tIndex = TableIndex(TblID);
	tLocation = TableLocation(TblID);
	tPwrLocation = PwrTableLocation(TblID);

	if(tLocation == _DnrPwr0_Location)
	{
		return (Dnr0_ReadPwrTable(AdcValue, tIndex, roundingoff, isminval,Offset,tPwrLocation));
	}
	else if(tLocation == _DnrPwr1_Location)
	{
		return (Dnr1_ReadPwrTable(AdcValue, tIndex, roundingoff, isminval,Offset,tPwrLocation));
	}
	else if(tLocation == _SvrPwr0_Location)
	{
		return (Svr0_ReadPwrTable(AdcValue, tIndex, roundingoff, isminval,Offset,tPwrLocation));
	}
	else
	{
		return (Svr1_ReadPwrTable(AdcValue, tIndex, roundingoff, isminval,Offset,tPwrLocation));
	}
}


INT16S Dnr0_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation)
{
	*isminval = FALSE;

	INT8U __1dBStep = TRUE;
	INT16S CurrPwr;

	{
		INT32S i = 0;
		INT32S j = 0;

		__Dnr0OutputTblStr *table =(__Dnr0OutputTblStr *)&vEE_TABLE1->Dnr0OutputTbl[tIndex];

		INT16U *dptr = table->Data;
		INT32S limit = table->limit;
		INT32S nsize = table->nsize;
		INT32S rvalx10 = (limit/2)*10L;


		for(i = 0; i < nsize && i < Dnr0OutputTBL_Size; i++)
		{
			if(AdcValue >= dptr[i]) break;
		}

		if(i == nsize || i == Dnr0OutputTBL_Size)
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
				CurrPwr =  NoSignal;
			}
		}

		return CurrPwr;
	}
}

INT16S Dnr1_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation)
{
	*isminval = FALSE;

	INT8U __1dBStep = TRUE;
	INT16S CurrPwr;

	{
		INT32S i = 0;
		INT32S j = 0;

		__Dnr1OutputTblStr *table =(__Dnr1OutputTblStr *)&vEE_TABLE1->Dnr1OutputTbl[tIndex];

		INT16U *dptr = table->Data;
		INT32S limit = table->limit;
		INT32S nsize = table->nsize;
		INT32S rvalx10 = (limit/2)*10L;

		for(i = 0; i < nsize && i < Dnr1OutputTBL_Size; i++)
		{
			if(AdcValue >= dptr[i]) break;
		}

		if(i == nsize || i == Dnr1OutputTBL_Size)
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
				CurrPwr =  NoSignal;
			}
		}

		return CurrPwr;
	}
}

INT16S Svr0_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation)
{

	*isminval = FALSE;

	INT8U __1dBStep = TRUE;
	INT16S CurrPwr;

	{
	    INT32S i = 0;
        INT32S j = 0;
		
		__Svr0OutputTblStr *table =(__Svr0OutputTblStr *)&vEE_TABLE->Svr0OutputTbl[tIndex];

		INT16U *dptr = table->Data;
		INT32S limit = table->limit;
		INT32S nsize = table->nsize;
		INT32S rvalx10 = (limit/2)*10L;



		for(i = 0; i < nsize && i < Svr0OutputTBL_Size; i++)
		{
			if(AdcValue >= dptr[i]) break;
		}

		if(i == nsize || i == Svr0OutputTBL_Size)
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
				CurrPwr =  NoSignal;
			}
		}


		return CurrPwr;
	}
}

INT16S Svr1_ReadPwrTable(INT32U AdcValue, INT8U tIndex, INT8U roundingoff, INT8U *isminval, INT16S Offset, INT16S tPwrLocation)
{
	*isminval = FALSE;

//	INT8U __1dBStep = FALSE;
	INT8U __1dBStep = TRUE;
	INT16S CurrPwr;

	{
		INT32S i = 0;
		INT32S j = 0;
		
		__Svr1OutputTblStr *table =(__Svr1OutputTblStr *)&vEE_TABLE->Svr1OutputTbl[tIndex];

		INT16U *dptr = table->Data;
		INT32S limit = table->limit;
		INT32S nsize = table->nsize;
		INT32S rvalx10 = (limit/2)*10L;


		for(i = 0; i < nsize && i < Svr1OutputTBL_Size; i++)
		{
			if(AdcValue >= dptr[i]) break;
		}

		if(i == nsize || i == Svr1OutputTBL_Size)
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
				CurrPwr =  NoSignal;
			}
		}

		return CurrPwr;
	}
}


INT16S GainAttnCalculation(INT16S cGain, INT16S cGainMax,INT8S cAttMin)
{
	INT16S AttTemp = 0;

	AttTemp = cGainMax - cGain;
	AttTemp = MinMaxAttnCheck(AttTemp, GainATTENMAX,ATTENMIN);

	return AttTemp;
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

INT8S AGCCheck(INT32S tmpx10,INT32S tlimitLow,INT8S tmpOnOff, INT8S *tmpALCAttn, INT8U AttMax, INT8U AttMin,INT8S AmpOnOff, INT8U Mode)
{
	INT32S gap;
	INT16S tmpTotAttn;

	tmpTotAttn = *tmpALCAttn;


	if(AmpOnOff == Disable) return tmpTotAttn;
	if(tmpOnOff != Enable) return FALSE;
	
	gap = tmpx10 - tlimitLow;

	if(abs(gap) <= 1) return FALSE;  //+/- 0.5dB

	if(Mode ==_AGCMode)
	{
		if(gap > 0)
		{
//			if(gap >=  12L)		gap = 20L;
			  if(gap >=  2L)	gap = gap;
			else				gap = 1L;
		}
		else
		{
//				  if(gap <= -10L)	gap = -10L;
//			else if (gap <= -4L) 	gap = -4L;
//			if (gap <= -4L) 	gap = -4L;
//			else if(gap <= -2L)		gap = -2L;
			if(gap <= -2L)			gap = -2L;
			else					gap = -1L;
		}
		
		tmpTotAttn	+= gap;
	}
	
	if(Mode ==_ALCMode)
	{
		if(gap > 0)
		{
//			if(gap >=  6L)			gap = 10L;
			if(gap >=  8L)			gap = 20L;
			else if(gap >=  2L)		gap = gap;
			else					gap = 1L;
		}
		else
		{
				  if(gap <= -10L)	gap = -10L;
			else if (gap <= -4L) 	gap = -4L;
			else if(gap <= -2L)		gap = -2L;
			else					gap = -1L;
		}
		
		tmpTotAttn	+= gap;
	}

	if(Mode ==_InputALCMode)
	{
		tmpTotAttn  = gap;
	}
	
	if(tmpTotAttn  > AttMax ) 	tmpTotAttn  = AttMax;
	if(tmpTotAttn  < AttMin ) 	tmpTotAttn  = AttMin;

	*tmpALCAttn = tmpTotAttn;

  	return tmpTotAttn;    
}

void AGCCheckFunction(void)
{
	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		FwdAGCCheck_CDMALTE();
	}
	else
	{
		FwdAGCCheck_CDMALTE_15M();
	}
	FwdAGCCheck_WCDMA();
	FwdAGCCheck_LTE_A_0();

	if(iRepeaterType == _TRIO_MM)
	{
		FwdAGCCheck_LTE_1();
		FwdAGCCheck_LTE_A_1();
	}
}


void FwdAGCCheck_CDMALTE_15M(void)
{
	INT8U CurrPwr_2G;
	INT8U CurrPwr_LTE;
	INT16U Sum_2G;
	INT16U Sum_LTE;
	INT16U Sum;
	INT16U i;
	INT16S tmppwrin = 0;
	INT16S tmppwrout = 0;
	INT16S tmppwr = 0;
	INT16S tmpx10 = 0;
	INT8S tRvsAGCMAX_LTE; 
	INT8S tAgcAttn_LTE; 


	__Dnr_Sts  *Sts = tDnrSts; 

	if( Sts->DetPwr.RvsOutPwr_2G > 10)
	{
		CurrPwr_2G = 27*2 - Sts->DetPwr.RvsOutPwr_2G;
		Sum_2G = dBmTomW[CurrPwr_2G];
	}
	else Sum_2G = 0;
	
	if( Sts->DetPwr.RvsOutPwr_LTE > 10)
	{
		CurrPwr_LTE = 27*2 - Sts->DetPwr.RvsOutPwr_LTE;
 		Sum_LTE = dBmTomW[CurrPwr_LTE];
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
		tmppwrout = tmppwr - CurrRvsAgcAttn_LTE;
		TwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrout);
		Sts->RvsOutPwr_LTE[0] = dptr[0];
		Sts->RvsOutPwr_LTE[1] = dptr[1];

		tmpx10 = tmppwr - Gain_LTE + Sts->RvsAlcAttn_LTE;
		Sts->CurrRvsInPwr_LTE =abs(tmpx10/2);
		tmppwrin = tmpx10;
			
		ULTwoOutPwrConvINT((INT8S *)&dptr[0],tmppwrin);
		Sts->RvsInPwr_LTE[0] = dptr[0];
		Sts->RvsInPwr_LTE[1] = dptr[1];
	}

	
	{
		iAGCOnOff= Sts->AGCOnOff_CDMALTE;
		iAGClimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE);

		if( Sts->AGCMode_LTE == _AGCAvgMode)
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwr_LTE);
		}
		else
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwrPeak_LTE);
		}				

		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdAgcAttn_LTE, AGCMAX_LTE, ATTENMIN,Sts->FwdAmpOnOff_LTE,_AGCMode);
	}

	{
		iAGCOnOff= Sts->RvsAlcOnOff_LTE;
		iAGClimit = Sts->RvsALCLvl_LTE*2;
		iAGCPwr = tmppwr;
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->RvsAlcAttn_LTE, tRvsALCMAX_LTE, ATTENMIN,Sts->FwdAmpOnOff_LTE, _ALCMode);
	}

	{
		iAGCOnOff  = Enable;
		iAGCAttnMAX = 25*2;
		iAGClimit = OtherFwdOverInLmt_CDMALTE ; 		// -35*2dBm
		iAGCPwr = -Sts->DetPwr.FwdInPwr_CDMALTE*2;
	
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdInAlcAttn_CDMALTE, iAGCAttnMAX, ATTENMIN, Sts->FwdAmpOnOff_LTE, _InputALCMode);	
	}

	tRvsAGCMAX_LTE = AGCMAX_LTE + Sts->RvsGainBalance_LTE*2;

	if( Sts->FwdAgcAttn_LTE > Sts->FwdInAlcAttn_CDMALTE)
	{
		tAgcAttn_LTE = Sts->FwdAgcAttn_LTE - Sts->FwdInAlcAttn_CDMALTE; 
	}
	else tAgcAttn_LTE = Sts->FwdAgcAttn_LTE;


	if(tAgcAttn_LTE >= AGC25_ATTENMAX_LTE)
	{
		Sts->FwdAttn1_CDMALTE = tAgcAttn_LTE - AGC25_ATTENMAX_LTE;
		Sts->FwdAttn1_LTE = AGC25_ATTENMAX_LTE;
	}
	else
	{
		Sts->FwdAttn1_CDMALTE = 0;
		Sts->FwdAttn1_LTE= tAgcAttn_LTE;
	}

	Sts->FwdAttn1_CDMALTE = Sts->FwdAttn1_CDMALTE + Sts->FwdInAlcAttn_CDMALTE;

	CurrAgcAttn_LTE = Sts->FwdAttn1_LTE + Sts->FwdInAlcAttn_CDMALTE;

	if(Sts->AGCOnOff_CDMALTE == Enable)
	{
		Sts->RvsGainAttn_LTE = CurrAgcAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
		Sts->RvsGainAttn_LTE = MinMaxAttnCheck(Sts->RvsGainAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
		CurrRvsAgcAttn_LTE = Sts->RvsGainAttn_LTE;
	}
	else
	{
		CurrRvsAgcAttn_LTE = Sts->RvsGainAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
		CurrRvsAgcAttn_LTE = MinMaxAttnCheck(CurrRvsAgcAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmpOnOff_LTE == Disable)
	{
		CurrRvsAgcAttn_LTE = tRvsAGCMAX_LTE;
	}
	

	tAGC_ATTENMAX_LTE = RVSAGC20_ATTENMAX_2G + Sts->RvsGainBalance_LTE*2;
	if(CurrRvsAgcAttn_LTE < tAGC_ATTENMAX_LTE) 
	{
		Sts->RvsAttn2_LTE = CurrRvsAgcAttn_LTE;
		Sts->RvsAttn3_LTE = 0;
	}
	else
	{
		Sts->RvsAttn2_LTE = tAGC_ATTENMAX_LTE;
		Sts->RvsAttn3_LTE = CurrRvsAgcAttn_LTE - tAGC_ATTENMAX_LTE;
	}	

	if(Sts->RvsAlcAttn_LTE < RVSALC25_ATTENMAX_LTE)
	{
		Sts->RvsAttn1_CDMALTE = Sts->RvsAlcAttn_LTE;
		Sts->RvsAttn1_LTE  = 0;
	}
	else
	{
		Sts->RvsAttn1_CDMALTE = RVSALC25_ATTENMAX_LTE;
		Sts->RvsAttn1_LTE  = Sts->RvsAlcAttn_LTE - RVSALC25_ATTENMAX_LTE;
	}
	
	Sts->FwdAttn1_2G  = Sts->FwdAttn1_LTE;
	Sts->FwdAttn2_2G  = Sts->FwdAttn2_LTE;

	Sts->RvsAttn1_2G = Sts->RvsAttn1_LTE;
	Sts->RvsAttn2_2G = Sts->RvsAttn2_LTE;
	Sts->RvsAttn3_2G = Sts->RvsAttn3_LTE;
}


void FwdAGCCheck_CDMALTE(void)
{
	INT8S CurrAttn = 0;
	INT8U tAmpOnOff = 0;

	INT8S tAgcAttn_2G; 
	INT8S tAgcAttn_LTE; 
	
	INT8S tRvsAGCMAX_2G; 
	INT8S tRvsAGCMAX_LTE; 

	__Dnr_Sts  *Sts = tDnrSts; 

	{
		{
			iAGCOnOff= Sts->AGCOnOff_CDMALTE;
			iAGClimit = OneOutPwrConv(Sts->FwdOutUpperLmt_2G);
			if( Sts->AGCMode_2G == _AGCAvgMode)
			{
				iAGCPwr = OneOutPwrConv(Sts->FwdOutPwr_2G);
			}
			else
			{
				iAGCPwr = OneOutPwrConv(Sts->FwdOutPwrPeak_2G);
			}	

			AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdAgcAttn_2G, AGCMAX_2G, ATTENMIN,Sts->FwdAmpOnOff_2G,_AGCMode);
		}

		{
			iAGCOnOff= Sts->RvsAlcOnOff_2G;
			iAGClimit = Sts->RvsALCLvl_2G*2;
			iAGCPwr = Sts->DetPwr.RvsOutPwr_2G;

			AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->RvsAlcAttn_2G, tRvsALCMAX_2G, ATTENMIN,Enable, _ALCMode);
		}

		{
			iAGCOnOff= Sts->AGCOnOff_CDMALTE;
			iAGClimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE);

			if( Sts->AGCMode_LTE == _AGCAvgMode)
			{
				iAGCPwr = OneOutPwrConv(Sts->FwdOutPwr_LTE);
			}
			else
			{
				iAGCPwr = OneOutPwrConv(Sts->FwdOutPwrPeak_LTE);
			}	
			
			AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdAgcAttn_LTE, AGCMAX_LTE, ATTENMIN,Sts->FwdAmpOnOff_LTE,_AGCMode);
		}

		{
			iAGCOnOff= Sts->RvsAlcOnOff_LTE;
			iAGClimit = Sts->RvsALCLvl_LTE*2;
			iAGCPwr = Sts->DetPwr.RvsOutPwr_LTE;
			AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->RvsAlcAttn_LTE, tRvsALCMAX_LTE, ATTENMIN,Sts->FwdAmpOnOff_LTE, _ALCMode);
		}
			

		{
			iAGCOnOff  = Enable;
			iAGCAttnMAX = 25*2;
			iAGClimit = OtherFwdOverInLmt_CDMALTE ; 		// -35*2dBm
			iAGCPwr = -Sts->DetPwr.FwdInPwr_CDMALTE*2;
			if((Sts->FwdAmpOnOff_2G)||(Sts->FwdAmpOnOff_LTE))	tAmpOnOff = Disable;
			else												tAmpOnOff = Enable;

			AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdInAlcAttn_CDMALTE, iAGCAttnMAX, ATTENMIN, tAmpOnOff, _InputALCMode);	
		}
	}

	if( Sts->FwdAgcAttn_2G > Sts->FwdInAlcAttn_CDMALTE)
	{
		tAgcAttn_2G = Sts->FwdAgcAttn_2G - Sts->FwdInAlcAttn_CDMALTE; 
	}
	else tAgcAttn_2G = Sts->FwdAgcAttn_2G;

	if( Sts->FwdAgcAttn_LTE > Sts->FwdInAlcAttn_CDMALTE)
	{
		tAgcAttn_LTE = Sts->FwdAgcAttn_LTE - Sts->FwdInAlcAttn_CDMALTE;
	}
	else tAgcAttn_LTE = Sts->FwdAgcAttn_LTE;


	if((Sts->AlmSts.FwdAmpOnOff_2G == Disable)&&(Sts->AlmSts.FwdAmpOnOff_LTE == Enable))
	{
		tAgcAttn_2G = DIGATTENMAX_2G;
	}

	if((Sts->AlmSts.FwdAmpOnOff_LTE == Disable)&&(Sts->AlmSts.FwdAmpOnOff_2G == Enable))
	{
		tAgcAttn_LTE = DIGATTENMAX_2G;
	}

	if(tAgcAttn_2G >= AGC25_ATTENMAX_2G)
	{
		Sts->cFwdAttn_CDMA = tAgcAttn_2G - AGC25_ATTENMAX_2G;
	}
	else
	{
		Sts->cFwdAttn_CDMA = 0;
	}

	if(tAgcAttn_LTE >= AGC25_ATTENMAX_2G)
	{
		Sts->cFwdAttn_LTE = tAgcAttn_LTE - AGC25_ATTENMAX_2G;
	}
	else
	{
		Sts->cFwdAttn_LTE = 0;
	}

	if( Sts->cFwdAttn_LTE >  Sts->cFwdAttn_CDMA)	
	{
		Sts->FwdAttn1_CDMALTE = Sts->cFwdAttn_LTE;
	}
	else											
	{
		Sts->FwdAttn1_CDMALTE = Sts->cFwdAttn_CDMA;
	}

	Sts->FwdAttn1_CDMALTE = Sts->FwdAttn1_CDMALTE + Sts->FwdInAlcAttn_CDMALTE;
	Sts->FwdAttn1_CDMALTE = MinMaxAttnCheck(Sts->FwdAttn1_CDMALTE ,AGC25_ATTENMAX_2G,ATTENMIN);


	if(tAgcAttn_2G <= AGC25_ATTENMAX_2G)
	{
		CurrAttn = Sts->cFwdAttn_LTE - Sts->cFwdAttn_CDMA;

		if( Sts->cFwdAttn_LTE >=  Sts->cFwdAttn_CDMA)
		{
			if(tAgcAttn_2G > CurrAttn)
			{
				Sts->AttOffset.FwdAttn1_2G  = tAgcAttn_2G - CurrAttn;
				Sts->FwdAttn2_2G = ToggleFwdAttn_2G;
			}
			else
			{
				Sts->AttOffset.FwdAttn1_2G = 0;

				if((Sts->AlmSts.FwdAmpOnOff_2G == Disable)||( Sts->DetPwr.FwdOutAvgPwr_2G <= 0))
				{
					Sts->FwdAttn2_2G = ToggleFwdAttn_2G;
				}
				else
				{
					Sts->FwdAttn2_2G  = ToggleFwdAttn_2G - ( CurrAttn - tAgcAttn_2G) ;
				}
			}
			Sts->FwdAttn2_2G = MinMaxAttnCheck(Sts->FwdAttn2_2G ,ATTENMAX,ATTENMIN);
		}
	}
	else
	{
		CurrAttn = Sts->cFwdAttn_LTE - Sts->cFwdAttn_CDMA;

		if( Sts->cFwdAttn_LTE <=  Sts->cFwdAttn_CDMA)	
		{
			Sts->AttOffset.FwdAttn1_2G  = AGC25_ATTENMAX_2G;
		}
		else
		{
			Sts->AttOffset.FwdAttn1_2G  = AGC25_ATTENMAX_2G - CurrAttn;
		}
		
		Sts->FwdAttn2_2G	= ToggleFwdAttn_2G;
	}
	
	Sts->FwdAttn1_2G  = Sts->AttOffset.FwdAttn1_2G;
	
////////////////////////
	if(tAgcAttn_LTE <= AGC25_ATTENMAX_2G)
	{
		CurrAttn = Sts->cFwdAttn_CDMA - Sts->cFwdAttn_LTE;

		if( Sts->cFwdAttn_LTE <=  Sts->cFwdAttn_CDMA)
		{
			if(tAgcAttn_LTE > CurrAttn)
			{
				Sts->AttOffset.FwdAttn1_LTE = tAgcAttn_LTE- CurrAttn;
				Sts->FwdAttn2_LTE = ToggleFwdAttn_LTE;
			}
			else
			{
				Sts->AttOffset.FwdAttn1_LTE = 0;

				if((Sts->AlmSts.FwdAmpOnOff_LTE == Disable)||( Sts->DetPwr.FwdOutAvgPwr_LTE <= 0))
				{
					Sts->FwdAttn2_LTE = ToggleFwdAttn_LTE;
				}
				else
				{
					Sts->FwdAttn2_LTE = ToggleFwdAttn_LTE - ( CurrAttn - tAgcAttn_LTE) ;
				}
			}
			
			Sts->FwdAttn2_LTE = MinMaxAttnCheck(Sts->FwdAttn2_LTE ,ATTENMAX,ATTENMIN);
		}
	}
	else
	{
		CurrAttn = Sts->cFwdAttn_CDMA - Sts->cFwdAttn_LTE;

		if( Sts->cFwdAttn_LTE >=  Sts->cFwdAttn_CDMA)	
		{
			Sts->AttOffset.FwdAttn1_LTE = AGC25_ATTENMAX_LTE;
		}
		else
		{
			Sts->AttOffset.FwdAttn1_LTE = AGC25_ATTENMAX_LTE- CurrAttn;
		}
		Sts->FwdAttn2_LTE = ToggleFwdAttn_LTE;
	}
	
	Sts->FwdAttn1_LTE = Sts->AttOffset.FwdAttn1_LTE;

	
	tRvsAGCMAX_2G  = AGCMAX_2G  + Sts->RvsGainBalance_2G *2;
	tRvsAGCMAX_LTE = AGCMAX_LTE + Sts->RvsGainBalance_LTE *2;

	CurrAgcAttn_2G = Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_2G;

	if(Sts->AGCOnOff_CDMALTE == Enable)
	{
		Sts->RvsGainAttn_2G = CurrAgcAttn_2G - Sts->RvsAlcAttn_2G + Sts->RvsGainBalance_2G*2;
		Sts->RvsGainAttn_2G = MinMaxAttnCheck(Sts->RvsGainAttn_2G,tRvsAGCMAX_2G,ATTENMIN);
		CurrRvsAgcAttn_2G = Sts->RvsGainAttn_2G;
	}
	else
	{
		CurrRvsAgcAttn_2G = Sts->RvsGainAttn_2G - Sts->RvsAlcAttn_2G + Sts->RvsGainBalance_2G *2;
		CurrRvsAgcAttn_2G = MinMaxAttnCheck(CurrRvsAgcAttn_2G,tRvsAGCMAX_2G,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmpOnOff_2G == Disable)
	{
		CurrRvsAgcAttn_2G = tRvsAGCMAX_2G;
	}

	CurrAgcAttn_LTE = Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_LTE;
	
	if(Sts->AGCOnOff_CDMALTE == Enable)
	{
		Sts->RvsGainAttn_LTE = CurrAgcAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
		Sts->RvsGainAttn_LTE = MinMaxAttnCheck(Sts->RvsGainAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
		CurrRvsAgcAttn_LTE = Sts->RvsGainAttn_LTE;
	}
	else
	{
		CurrRvsAgcAttn_LTE = Sts->RvsGainAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
		CurrRvsAgcAttn_LTE = MinMaxAttnCheck(CurrRvsAgcAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmpOnOff_LTE == Disable)
	{
		CurrRvsAgcAttn_LTE = tRvsAGCMAX_LTE;
	}
	
	///////////////////////////////////////////////2013.03.19
	if(chkSleepMode[PATH_2G] == SET)
	{
//		Sts->Rvs0GainSet_2G =  FwdMinGain_2G;

		Sts->RvsGainAttn_2G = GainATTENMAX;
		CurrRvsAgcAttn_2G = Sts->RvsGainAttn_2G;

		Sts->RvsAttn2_2G = ATTENMAX;
		Sts->RvsAttn3_2G = ATTENMAX;
	}
	else
	{
		tAGC_ATTENMAX_2G = RVSAGC20_ATTENMAX_2G + Sts->RvsGainBalance_2G*2;
		if(CurrRvsAgcAttn_2G < tAGC_ATTENMAX_2G)
		{
			Sts->RvsAttn2_2G = CurrRvsAgcAttn_2G;
			Sts->RvsAttn3_2G = 0;
		}
		else
		{
			Sts->RvsAttn2_2G = tAGC_ATTENMAX_2G;
			Sts->RvsAttn3_2G = CurrRvsAgcAttn_2G - tAGC_ATTENMAX_2G;
		}
	}


	if(chkSleepMode[PATH_LTE] == SET)
	{
		Sts->RvsGainAttn_LTE = GainATTENMAX;
		CurrRvsAgcAttn_LTE = Sts->RvsGainAttn_LTE;
		Sts->RvsAttn2_LTE = ATTENMAX;
		Sts->RvsAttn3_LTE = ATTENMAX;
	}
	else
	{
		tAGC_ATTENMAX_LTE = RVSAGC20_ATTENMAX_2G + Sts->RvsGainBalance_LTE*2;
		if(CurrRvsAgcAttn_LTE < tAGC_ATTENMAX_LTE) 
		{
			Sts->RvsAttn2_LTE = CurrRvsAgcAttn_LTE;
			Sts->RvsAttn3_LTE = 0;
		}
		else
		{
			Sts->RvsAttn2_LTE = tAGC_ATTENMAX_LTE;
			Sts->RvsAttn3_LTE = CurrRvsAgcAttn_LTE - tAGC_ATTENMAX_LTE;
		}	
	}
//////////////////////////////////////////////////////////////////////////////////////////
	tALC_ATTENMAX_2G = RVSALC20_ATTENMAX_2G;

	if(Sts->RvsAlcAttn_2G > tALC_ATTENMAX_2G)
	{
		Sts->cRvsAttn_CDMA = Sts->RvsAlcAttn_2G - tALC_ATTENMAX_2G;
	}
	else Sts->cRvsAttn_CDMA = 0;
		
	if(Sts->RvsAlcAttn_LTE > RVSALC25_ATTENMAX_LTE)
	{
		Sts->cRvsAttn_LTE = Sts->RvsAlcAttn_LTE - RVSALC25_ATTENMAX_LTE;
	}
	else Sts->cRvsAttn_LTE = 0;
	
	if( Sts->cRvsAttn_LTE >  Sts->cRvsAttn_CDMA)	Sts->RvsAttn1_CDMALTE = Sts->cRvsAttn_LTE;
	else											Sts->RvsAttn1_CDMALTE = Sts->cRvsAttn_CDMA;
	if (Sts->RvsAttn1_CDMALTE >= DIGATTENMAX_2G) 	Sts->RvsAttn1_CDMALTE = DIGATTENMAX_2G;

	if(Sts->RvsAlcAttn_2G <= RVSALC20_ATTENMAX_2G)
	{
		Sts->RvsAttn1_2G  = Sts->RvsAlcAttn_2G;
		Sts->AttOffset.RvsAttn1_2G	= tmpRvsAttn1_2G;
	}
	else
	{
		Sts->RvsAttn1_2G  = RVSALC20_ATTENMAX_2G;
	}

	if(Sts->RvsAlcAttn_LTE <= RVSALC25_ATTENMAX_LTE)
	{
		Sts->RvsAttn1_LTE  = Sts->RvsAlcAttn_LTE;

		Sts->AttOffset.RvsAttn1_2G	= tmpRvsAttn1_2G;
	}
	else
	{
		Sts->RvsAttn1_LTE  = RVSALC25_ATTENMAX_LTE;

		if( Sts->cRvsAttn_LTE >= Sts->cRvsAttn_CDMA)
		{
			Sts->AttOffset.RvsAttn1_2G	= tmpRvsAttn1_2G - (Sts->cRvsAttn_LTE - Sts->cRvsAttn_CDMA);
			if(Sts->AttOffset.RvsAttn1_2G <= 0)	Sts->AttOffset.RvsAttn1_2G = 0;
		}
		else
		{
			Sts->AttOffset.RvsAttn1_2G	= tmpRvsAttn1_2G;
		}
	}
}


void FwdAGCCheck_WCDMA(void)
{
	INT8S tmpAgcAttn_3G; 
	INT8S tAgcAttn_3G; 
	INT8S tRvsAGCMAX_3G; 

	__Dnr_Sts  *Sts = tDnrSts; 

		////자사 
	{
		iAGCOnOff = Sts->AGCOnOff_3G;
		iAGClimit = OneOutPwrConv(Sts->FwdOutUpperLmt_3G);

		if( Sts->AGCMode_3G == _AGCAvgMode)
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwr_3G);
		}
		else
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwrPeak_3G);
		}	
		
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdAgcAttn_3G, AGCMAX_3G, ATTENMIN,Sts->FwdAmpOnOff_3G,_AGCMode);
	}
		
	{
		iAGCOnOff= Sts->RvsAlcOnOff_3G;
		iAGCPwr = Sts->DetPwr.RvsOutPwr_3G;

		if((Sts->AlmSts.FwdAmpOnOff_3G == Disable)||( Sts->DetPwr.FwdOutAvgPwr_3G <= 0)||(Sts->AGCOnOff_3G == Disable))
		{
			iAGClimit = (tmpRvsALCLvl_3G)*2 ;
		}
		else
		{
			iAGClimit = (tmpRvsALCLvl_3G*2 - Sts->RvsGainAttn_3G);
		}
		Sts->AttOffset.RvsAttn5_3G = iAGClimit/2;

		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->RvsAlcAttn_3G, tRvsALCMAX_3G, ATTENMIN,Sts->FwdAmpOnOff_3G, _ALCMode);
	}


	{
		iAGCOnOff  = Enable;
		iAGCAttnMAX = 25*2;
		iAGClimit = OtherFwdOverInLmt_3G ; 		// -36*2dBm
		iAGCPwr = -Sts->DetPwr.FwdInPwr_3G*2;
	
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdInAlcAttn_3G, iAGCAttnMAX, ATTENMIN, Sts->FwdAmpOnOff_3G, _InputALCMode);	
	}

	tRvsAGCMAX_3G = AGCMAX_3G + Sts->RvsGainBalance_3G*2;

	if( Sts->FwdAgcAttn_3G > Sts->FwdInAlcAttn_3G)
	{
		tAgcAttn_3G = Sts->FwdAgcAttn_3G - Sts->FwdInAlcAttn_3G; 
	}
	else tAgcAttn_3G = Sts->FwdAgcAttn_3G;


	if(tAgcAttn_3G >= AGC20_ATTENMAX_3G)
	{
		Sts->FwdAttn1_3G = tAgcAttn_3G - AGC20_ATTENMAX_3G;
		Sts->FwdAttn2_3G = AGC20_ATTENMAX_3G;
	}
	else
	{
		Sts->FwdAttn1_3G = 0;
		Sts->FwdAttn2_3G = tAgcAttn_3G;
	}

	Sts->FwdAttn1_3G = Sts->FwdAttn1_3G + Sts->FwdInAlcAttn_3G;

	CurrAgcAttn_3G = Sts->FwdAttn1_3G + Sts->FwdAttn2_3G;

	if(Sts->AGCOnOff_3G == Enable)
	{
		Sts->RvsGainAttn_3G = CurrAgcAttn_3G - Sts->RvsAlcAttn_3G + Sts->RvsGainBalance_3G*2;
		Sts->RvsGainAttn_3G = MinMaxAttnCheck(Sts->RvsGainAttn_3G,tRvsAGCMAX_3G,ATTENMIN);
		tmpAgcAttn_3G = Sts->RvsGainAttn_3G;
	}
	else
	{
		tmpAgcAttn_3G = Sts->RvsGainAttn_3G - Sts->RvsAlcAttn_3G + Sts->RvsGainBalance_3G*2;
		tmpAgcAttn_3G = MinMaxAttnCheck(tmpAgcAttn_3G,tRvsAGCMAX_3G,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmpOnOff_3G== Disable)
	{
		tmpAgcAttn_3G = AGCMAX_3G;
	}

	{
		tAGC10_ATTENMAX_3G  = AGC10_ATTENMAX_3G + Sts->RvsGainBalance_3G*2;
		if(tmpAgcAttn_3G <= tAGC10_ATTENMAX_3G)	
		{
			Sts->RvsAttn3_3G = tmpAgcAttn_3G;
			Sts->RvsAttn4_3G = 0;
		}
		else
		{
			Sts->RvsAttn3_3G = tAGC10_ATTENMAX_3G;
			Sts->RvsAttn4_3G = tmpAgcAttn_3G - tAGC10_ATTENMAX_3G;
		}
		Sts->RvsAttn4_3G = MinMaxAttnCheck(Sts->RvsAttn4_3G,AGCATTENMAX_3G,ATTENMIN);

		CurrRvsAgcAttn_3G = Sts->RvsAttn3_3G +Sts->RvsAttn4_3G;

		if(Sts->RvsAlcAttn_3G <= RVSALC25_ATTENMAX_3G) 
		{
			Sts->RvsAttn1_3G = Sts->RvsAlcAttn_3G;
			Sts->RvsAttn2_3G = 0;
		}
		else
		{
			Sts->RvsAttn1_3G = RVSALC25_ATTENMAX_3G;
			Sts->RvsAttn2_3G = Sts->RvsAlcAttn_3G - RVSALC25_ATTENMAX_3G;
		}
	}
}

void FwdAGCCheck_LTE_A_0(void)
{
	INT8S tmpAttn_LTE_A1 = 0;
	INT8S tmpAttn_LTE_A2 = 0;
	INT8S CurrAttn = 0;
	INT8U tAmpOnOff = 0;

	INT8S tAgcAttn_LTE_A1; 
	INT8S tAgcAttn_LTE_A2; 
	INT8S tRvsAGCMAX_LTE_A1; 
	INT8S tRvsAGCMAX_LTE_A2; 

	__Dnr_Sts  *Sts = tDnrSts; 

//자사 
	{
		iAGCOnOff = Sts->AGCOnOff_LTE_A_0;
		iAGClimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE_A1);
		if( Sts->AGCMode_LTE_A1 == _AGCAvgMode)
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwr_LTE_A1);
		}
		else
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwrPeak_LTE_A1);
		}	

		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdAgcAttn_LTE_A1, AGCMAX_LTE_A1, ATTENMIN,Sts->FwdAmpOnOff_LTE_A1,_AGCMode);
	}

	{
		iAGCOnOff= Sts->RvsAlcOnOff_LTE_A1;
		iAGClimit = Sts->RvsALCLvl_LTE_A1*2;
		iAGCPwr = Sts->DetPwr.RvsOutPwr_LTE_A1;
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->RvsAlcAttn_LTE_A1, tRvsALCMAX_LTE_A1, ATTENMIN,Sts->FwdAmpOnOff_LTE_A1, _ALCMode);
	}

	{
		iAGCOnOff = Sts->AGCOnOff_LTE_A_0;
		iAGClimit = OneOutPwrConv(Sts->FwdOutUpperLmt_LTE_A2);
		if( Sts->AGCMode_LTE_A2 == _AGCAvgMode)
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwr_LTE_A2);
		}
		else
		{
			iAGCPwr = OneOutPwrConv(Sts->FwdOutPwrPeak_LTE_A2);
		}	
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdAgcAttn_LTE_A2, AGCMAX_LTE_A1, ATTENMIN,Sts->FwdAmpOnOff_LTE_A2,_AGCMode);

	}
	{
		iAGCOnOff= Sts->RvsAlcOnOff_LTE_A2;
		iAGClimit = Sts->RvsALCLvl_LTE_A2*2;
		iAGCPwr = Sts->DetPwr.RvsOutPwr_LTE_A2;
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->RvsAlcAttn_LTE_A2, tRvsALCMAX_LTE_A1, ATTENMIN,Sts->FwdAmpOnOff_LTE_A2, _ALCMode);
	}


	{
		iAGCOnOff  = Enable;
		iAGCAttnMAX = 25*2;
		iAGClimit = OtherFwdOverInLmt_LTE_A ; 		// -37*2dBm
		iAGCPwr = -Sts->DetPwr.FwdInPwr_LTE_A*2;
		if((Sts->FwdAmpOnOff_LTE_A2)||(Sts->FwdAmpOnOff_LTE_A2))	tAmpOnOff = Disable;
		else 														tAmpOnOff = Enable;


		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdInAlcAttn_LTE_A_0, iAGCAttnMAX, ATTENMIN, tAmpOnOff, _InputALCMode);	
	}
	
///////////////////////////////////////////////////////////////////////////////////////////////
	if( Sts->FwdAgcAttn_LTE_A1 > Sts->FwdInAlcAttn_LTE_A_0 )
	{
		tAgcAttn_LTE_A1 = Sts->FwdAgcAttn_LTE_A1 - Sts->FwdInAlcAttn_LTE_A_0; 
	}
	else tAgcAttn_LTE_A1 = Sts->FwdAgcAttn_LTE_A1;

	if( Sts->FwdAgcAttn_LTE_A2 > Sts->FwdInAlcAttn_LTE_A_0)
	{
		tAgcAttn_LTE_A2 = Sts->FwdAgcAttn_LTE_A2 - Sts->FwdInAlcAttn_LTE_A_0;
	}
	else tAgcAttn_LTE_A2 = Sts->FwdAgcAttn_LTE_A2;


	if((Sts->AlmSts.FwdAmpOnOff_LTE_A1 == Disable)&&(Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Enable))
	{
		tAgcAttn_LTE_A1 = DIGATTENMAX_2G;
	}
	
	if((Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Disable)&&(Sts->AlmSts.FwdAmpOnOff_LTE_A1 == Enable))
	{
		tAgcAttn_LTE_A2 = DIGATTENMAX_2G;
	}



	if(tAgcAttn_LTE_A1 >= AGC25_ATTENMAX_LTE_A1)
	{
		Sts->cFwdAttn_LTE_A1 = tAgcAttn_LTE_A1 - AGC25_ATTENMAX_LTE_A1;
	}
	else
	{
		Sts->cFwdAttn_LTE_A1 = 0;
	}

	if(tAgcAttn_LTE_A2 >= AGC25_ATTENMAX_LTE_A1)
	{
		Sts->cFwdAttn_LTE_A2 = tAgcAttn_LTE_A2 - AGC25_ATTENMAX_LTE_A1;
	}
	else
	{
		Sts->cFwdAttn_LTE_A2 = 0;
	}

	if( Sts->cFwdAttn_LTE_A2 >  Sts->cFwdAttn_LTE_A1)	
	{
		Sts->FwdAttn1_LTE_A = Sts->cFwdAttn_LTE_A2 + Sts->FwdInAlcAttn_LTE_A_0;
	}
	else											
	{
		Sts->FwdAttn1_LTE_A = Sts->cFwdAttn_LTE_A1 + Sts->FwdInAlcAttn_LTE_A_0;
	}

	tmpAttn_LTE_A1 = tAgcAttn_LTE_A1 - Sts->FwdAttn1_LTE_A;
	tmpAttn_LTE_A2 = tAgcAttn_LTE_A2 - Sts->FwdAttn1_LTE_A;


	if(tAgcAttn_LTE_A1 <= AGC25_ATTENMAX_LTE_A1)
	{
		CurrAttn = Sts->cFwdAttn_LTE_A2 - Sts->cFwdAttn_LTE_A1;

		if( Sts->cFwdAttn_LTE_A2 >=  Sts->cFwdAttn_LTE_A1)
		{
			if(tAgcAttn_LTE_A1 > CurrAttn)
			{
				Sts->AttOffset.FwdAttn1_LTE_A1 = tAgcAttn_LTE_A1 - CurrAttn;
				Sts->FwdAttn2_LTE_A1  = ToggleFwdAttn_LTE_A1;
			}
			else
			{
				Sts->AttOffset.FwdAttn1_LTE_A1 = 0;

				if((Sts->AlmSts.FwdAmpOnOff_LTE_A1 == Disable)||( Sts->DetPwr.FwdOutAvgPwr_LTE_A1 <= 0))
				{
					Sts->FwdAttn2_LTE_A1  = ToggleFwdAttn_LTE_A1;
				}
				else
				{
					Sts->FwdAttn2_LTE_A1  = ToggleFwdAttn_LTE_A1 - ( CurrAttn - tAgcAttn_LTE_A1) ;
				}
			}
			
			Sts->FwdAttn2_LTE_A1 = MinMaxAttnCheck(Sts->FwdAttn2_LTE_A1 ,ATTENMAX,ATTENMIN);
		}
	}
	else
	{
 		CurrAttn = Sts->cFwdAttn_LTE_A2 - Sts->cFwdAttn_LTE_A1;

		if( Sts->cFwdAttn_LTE_A2 <=  Sts->cFwdAttn_LTE_A1)	
		{
			Sts->AttOffset.FwdAttn1_LTE_A1  = AGC25_ATTENMAX_LTE_A1;
		}
		else
		{
			Sts->AttOffset.FwdAttn1_LTE_A1  = AGC25_ATTENMAX_LTE_A1 - CurrAttn;
		}
		
		Sts->FwdAttn2_LTE_A1	= ToggleFwdAttn_LTE_A1;
	}

	Sts->FwdAttn1_LTE_A1  = Sts->AttOffset.FwdAttn1_LTE_A1;


	if(tAgcAttn_LTE_A2 <= AGC25_ATTENMAX_LTE_A1)
	{
		CurrAttn = Sts->cFwdAttn_LTE_A1 - Sts->cFwdAttn_LTE_A2;

		if( Sts->cFwdAttn_LTE_A2 <=  Sts->cFwdAttn_LTE_A1)
		{
			if(tAgcAttn_LTE_A2 > CurrAttn)
			{
				Sts->AttOffset.FwdAttn1_LTE_A2 = tAgcAttn_LTE_A2 - CurrAttn;
				Sts->FwdAttn2_LTE_A2 = ToggleFwdAttn_LTE_A2;
			}
			else
			{
				Sts->AttOffset.FwdAttn1_LTE_A2 = 0;

				if((Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Disable)||( Sts->DetPwr.FwdOutAvgPwr_LTE_A2<= 0))
				{
					Sts->FwdAttn2_LTE_A2 = ToggleFwdAttn_LTE_A2;
				}
				else
				{
					Sts->FwdAttn2_LTE_A2 = ToggleFwdAttn_LTE_A2 - ( CurrAttn - tAgcAttn_LTE_A2) ;
				}
			}
			
			Sts->FwdAttn2_LTE_A2 = MinMaxAttnCheck(Sts->FwdAttn2_LTE_A2 ,ATTENMAX,ATTENMIN);
		}
	}
	else
	{
		CurrAttn = Sts->cFwdAttn_LTE_A1 - Sts->cFwdAttn_LTE_A2;

		if( Sts->cFwdAttn_LTE_A2 >=  Sts->cFwdAttn_LTE_A1)	
		{
			Sts->AttOffset.FwdAttn1_LTE_A2 = AGC25_ATTENMAX_LTE_A1;
		}
		else
		{
			Sts->AttOffset.FwdAttn1_LTE_A2 = AGC25_ATTENMAX_LTE_A1- CurrAttn;
		}
		
		Sts->FwdAttn2_LTE_A2 = ToggleFwdAttn_LTE_A2;
	}
	
	Sts->FwdAttn1_LTE_A2  = Sts->AttOffset.FwdAttn1_LTE_A2;

	///////////////////////////////////////////////////////////////////////////////////////////////

	tRvsAGCMAX_LTE_A1 = AGCMAX_LTE_A1 + Sts->RvsGainBalance_LTE_A1*2;
	
	CurrAgcAttn_LTE_A1 = Sts->FwdAttn1_LTE_A + Sts->FwdAttn1_LTE_A1;

 	if(Sts->AGCOnOff_LTE_A_0 == Enable)
	{
		Sts->RvsGainAttn_LTE_A1 = CurrAgcAttn_LTE_A1 - Sts->RvsAlcAttn_LTE_A1 + Sts->RvsGainBalance_LTE_A1*2;
		Sts->RvsGainAttn_LTE_A1 = MinMaxAttnCheck(Sts->RvsGainAttn_LTE_A1,tRvsAGCMAX_LTE_A1,ATTENMIN);
		CurrRvsAgcAttn_LTE_A1 = Sts->RvsGainAttn_LTE_A1;

	}
	else
	{
		CurrRvsAgcAttn_LTE_A1 = Sts->RvsGainAttn_LTE_A1 - Sts->RvsAlcAttn_LTE_A1 +  Sts->RvsGainBalance_LTE_A1*2;
		CurrRvsAgcAttn_LTE_A1 = MinMaxAttnCheck(CurrRvsAgcAttn_LTE_A1, tRvsAGCMAX_LTE_A1,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmpOnOff_LTE_A1 == Disable)
	{
		CurrRvsAgcAttn_LTE_A1 = tRvsAGCMAX_LTE_A1;
	}


	tRvsAGCMAX_LTE_A2 = AGCMAX_LTE_A1 + Sts->RvsGainBalance_LTE_A2*2;
	CurrAgcAttn_LTE_A2 = Sts->FwdAttn1_LTE_A + Sts->FwdAttn1_LTE_A2;

	if(Sts->AGCOnOff_LTE_A_0 == Enable)
	{
		Sts->RvsGainAttn_LTE_A2 = Sts->FwdAgcAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2 + Sts->RvsGainBalance_LTE_A2*2;
		Sts->RvsGainAttn_LTE_A2 = MinMaxAttnCheck(Sts->RvsGainAttn_LTE_A2,tRvsAGCMAX_LTE_A2,ATTENMIN);
		CurrRvsAgcAttn_LTE_A2 = Sts->RvsGainAttn_LTE_A2;
	}
	else
	{
		CurrRvsAgcAttn_LTE_A2 = Sts->RvsGainAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2+  Sts->RvsGainBalance_LTE_A2*2;
		CurrRvsAgcAttn_LTE_A2	= MinMaxAttnCheck(CurrRvsAgcAttn_LTE_A2, tRvsAGCMAX_LTE_A2,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Disable)
	{
		CurrRvsAgcAttn_LTE_A2 = tRvsAGCMAX_LTE_A2;
	}

	if(chkSleepMode[PATH_LTE_A1] == SET)
	{
//		Sts->Rvs0GainSet_LTE_A1 =  FwdMinGain_LTE_A;

		Sts->RvsGainAttn_LTE_A1 = GainATTENMAX;
		CurrRvsAgcAttn_LTE_A1 = Sts->RvsGainAttn_LTE_A1;

		Sts->RvsAttn2_LTE_A1 = ATTENMAX;
		Sts->RvsAttn3_LTE_A1 = ATTENMAX;
	}
	else
	{
		tAGC_ATTENMAX_LTE_A1 = RVSAGC15_ATTENMAX_LTE_A1 + Sts->RvsGainBalance_LTE_A1*2;

		if(CurrRvsAgcAttn_LTE_A1 < tAGC_ATTENMAX_LTE_A1)
		{
			Sts->RvsAttn2_LTE_A1 = CurrRvsAgcAttn_LTE_A1;
			Sts->RvsAttn3_LTE_A1 = 0;
		}
		else
		{
			Sts->RvsAttn2_LTE_A1 = tAGC_ATTENMAX_LTE_A1;
			Sts->RvsAttn3_LTE_A1 = CurrRvsAgcAttn_LTE_A1 - tAGC_ATTENMAX_LTE_A1;
		}
		Sts->RvsAttn3_LTE_A1	= MinMaxAttnCheck(Sts->RvsAttn3_LTE_A1, DIGATTENMAX,ATTENMIN);
	}

	if(chkSleepMode[PATH_LTE_A2] == SET)
	{
//		Sts->Rvs0GainSet_LTE_A2 =  FwdMinGain_LTE_A;

		Sts->RvsGainAttn_LTE_A2 = GainATTENMAX;
		CurrRvsAgcAttn_LTE_A2 = Sts->RvsGainAttn_LTE_A2;

		Sts->RvsAttn2_LTE_A2 = ATTENMAX;
		Sts->RvsAttn3_LTE_A2 = ATTENMAX;
	}
	else
	{
		tAGC_ATTENMAX_LTE_A2 = RVSAGC15_ATTENMAX_LTE_A2 + Sts->RvsGainBalance_LTE_A2*2;
		if(CurrRvsAgcAttn_LTE_A2 < tAGC_ATTENMAX_LTE_A2) 
		{
			Sts->RvsAttn2_LTE_A2 = CurrRvsAgcAttn_LTE_A2;
			Sts->RvsAttn3_LTE_A2 = 0;
		}
		else
		{
			Sts->RvsAttn2_LTE_A2 = tAGC_ATTENMAX_LTE_A2;
			Sts->RvsAttn3_LTE_A2 = CurrRvsAgcAttn_LTE_A2 - tAGC_ATTENMAX_LTE_A2;
		}	
		Sts->RvsAttn3_LTE_A2	= MinMaxAttnCheck(Sts->RvsAttn3_LTE_A2, DIGATTENMAX,ATTENMIN);
	}

/////////////////////////////////////////////////////////////////////////////////
	if(Sts->RvsAlcAttn_LTE_A1 > ALCATTENMAX_LTE)
	{
		Sts->cRvsAttn_LTE_A1 = Sts->RvsAlcAttn_LTE_A1 - ALCATTENMAX_LTE;
	}
	else Sts->cRvsAttn_LTE_A1 = 0;
		
	if(Sts->RvsAlcAttn_LTE_A2 > ALCATTENMAX_LTE)
	{
		Sts->cRvsAttn_LTE_A2 = Sts->RvsAlcAttn_LTE_A2 - ALCATTENMAX_LTE;
	}
	else Sts->cRvsAttn_LTE_A2 = 0;
	
	if( Sts->cRvsAttn_LTE_A2 >  Sts->cRvsAttn_LTE_A1)	Sts->RvsAttn1_LTE_A = Sts->cRvsAttn_LTE_A2;
	else												Sts->RvsAttn1_LTE_A = Sts->cRvsAttn_LTE_A1;
	if (Sts->RvsAttn1_LTE_A >= ALCATTENMAX_LTE) 		Sts->RvsAttn1_LTE_A = ALCATTENMAX_LTE;

	tmpAttn_LTE_A1 = Sts->RvsAlcAttn_LTE_A1 - Sts->RvsAttn1_LTE_A;
	tmpAttn_LTE_A2 = Sts->RvsAlcAttn_LTE_A2 - Sts->RvsAttn1_LTE_A;

	if( Sts->RvsAlcAttn_LTE_A1 >= Sts->RvsAlcAttn_LTE_A2)
	{
		Sts->RvsAttn1_LTE_A1  = tmpAttn_LTE_A1;

		if( Sts->RvsAttn1_LTE_A < tmpAttn_LTE_A2 )
		{
			Sts->RvsAttn1_LTE_A2 = tmpAttn_LTE_A2 - Sts->RvsAttn1_LTE_A;
		}
		else
		{
			Sts->RvsAttn1_LTE_A2 = 0;
		}
		
		Sts->RvsAttn1_LTE_A2	= MinMaxAttnCheck(Sts->RvsAttn1_LTE_A2, DIGATTENMAX,ATTENMIN);
	}
	else if( Sts->RvsAlcAttn_LTE_A1 < (Sts->RvsAlcAttn_LTE_A2 ))
	{
		Sts->RvsAttn1_LTE_A2  = tmpAttn_LTE_A2;
		if( Sts->RvsAttn1_LTE_A < tmpAttn_LTE_A1)
		{
			Sts->RvsAttn1_LTE_A1  = tmpAttn_LTE_A1 - Sts->RvsAttn1_LTE_A;
		}
		else
		{
			Sts->RvsAttn1_LTE_A1 = 0;
		}
		
		Sts->RvsAttn1_LTE_A1	= MinMaxAttnCheck(Sts->RvsAttn1_LTE_A1, DIGATTENMAX,ATTENMIN);
	}
}

void FwdAGCCheck_LTE_1(void)
{
	INT8U tmpAgcAttn_LTE1; 
	INT8S tRvsAGCMAX_LTE; 
	INT8S tAgcAttn_LTE_1; 

	__Dnr_Sts  *Sts = tDnrSts; 

	{
		iAGCOnOff = Sts->AGC1OnOff_LTE;
		iAGCAttnMAX = 50*2;
		iAGClimit = OneOutPwrConv(Sts->Fwd1OutUpperLmt_LTE);

		if( Sts->AGCMode_LTE == _AGCAvgMode)
		{
			iAGCPwr = OneOutPwrConv(Sts->Fwd1OutPwr_LTE);
		}
		else
		{
			iAGCPwr = OneOutPwrConv(Sts->Fwd1OutPwrPeak_LTE);
		}	
		
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->Fwd1AgcAttn_LTE, iAGCAttnMAX, ATTENMIN,Sts->FwdAmp1OnOff_LTE,_AGCMode);
	}

	{
		iAGCOnOff= Sts->Rvs1AlcOnOff_LTE;
//		iAGCAttnMAX = 43*2;
		iAGCAttnMAX = tRvsALCMAX_LTE;
		iAGCPwr = Sts->Det1Pwr.Rvs1OutPwr_LTE;

		if((Sts->AlmSts.FwdAmp1OnOff_LTE == Disable)||( Sts->Det1Pwr.Fwd1OutAvgPwr_LTE <= 0)||(Sts->AGC1OnOff_LTE == Disable))
		{
			iAGClimit = (tmpRvs1ALCLvl_LTE*2) ;
		}
		else
		{
			iAGClimit = (tmpRvs1ALCLvl_LTE*2 - Sts->Rvs1GainAttn_LTE);
		}
		Sts->Att1Offset.Rvs1Attn4_LTE = iAGClimit/2;
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->Rvs1AlcAttn_LTE, iAGCAttnMAX, ATTENMIN,Sts->FwdAmp1OnOff_LTE, _ALCMode);
	}


	{
		iAGCOnOff  = Enable;
		iAGCAttnMAX = 25*2;
		iAGClimit = OtherFwd1OverInLmt_LTE ;		// -36*2dBm
		iAGCPwr = -Sts->Det1Pwr.Fwd1InPwr_LTE*2;

		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdInAlcAttn_LTE_1, iAGCAttnMAX, ATTENMIN, Sts->FwdAmp1OnOff_LTE, _InputALCMode);	
	}


	if( Sts->Fwd1AgcAttn_LTE > Sts->FwdInAlcAttn_LTE_1)
	{
		tAgcAttn_LTE_1 = Sts->Fwd1AgcAttn_LTE - Sts->FwdInAlcAttn_LTE_1; 
	}
	else tAgcAttn_LTE_1 = Sts->Fwd1AgcAttn_LTE;


	if(tAgcAttn_LTE_1 >= AGC25_ATTENMAX_LTE_1)
	{
		Sts->Fwd1Attn1_LTE = tAgcAttn_LTE_1 - AGC25_ATTENMAX_LTE_1;
		Sts->Fwd1Attn2_LTE = AGC25_ATTENMAX_LTE_1;
	}
	else
	{
		Sts->Fwd1Attn1_LTE = 0;
		Sts->Fwd1Attn2_LTE = tAgcAttn_LTE_1;
	}

	Sts->Fwd1Attn1_LTE = Sts->Fwd1Attn1_LTE + Sts->FwdInAlcAttn_LTE_1;

	CurrAgcAttn_LTE_1 = Sts->Fwd1Attn1_LTE + Sts->Fwd1Attn2_LTE;

	tRvsAGCMAX_LTE = AGCMAX_LTE + Sts->Rvs1GainBalance_LTE*2;
	if(Sts->AGC1OnOff_LTE == Enable)
	{
		Sts->Rvs1GainAttn_LTE = CurrAgcAttn_LTE_1  - Sts->Rvs1AlcAttn_LTE + Sts->Rvs1GainBalance_LTE*2;
		Sts->Rvs1GainAttn_LTE = MinMaxAttnCheck(Sts->Rvs1GainAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
		tmpAgcAttn_LTE1 = Sts->Rvs1GainAttn_LTE;
	}
	else
	{
		tmpAgcAttn_LTE1 = Sts->Rvs1GainAttn_LTE - Sts->Rvs1AlcAttn_LTE + Sts->Rvs1GainBalance_LTE*2;
		tmpAgcAttn_LTE1 = MinMaxAttnCheck(tmpAgcAttn_LTE1,tRvsAGCMAX_LTE,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmp1OnOff_LTE == Disable)
	{
		tmpAgcAttn_LTE1 = tRvsAGCMAX_LTE;
	}


	{
		tAGC_ATTENMAX_LTE_1  = RVSAGC20_ATTENMAX_LTE_A1 + Sts->Rvs1GainBalance_LTE*2;

		if(tmpAgcAttn_LTE1 <= tAGC_ATTENMAX_LTE_1)	
		{
			Sts->Rvs1Attn3_LTE = tmpAgcAttn_LTE1;
			Sts->Rvs1Attn4_LTE = 0;
		}
		else
		{
			Sts->Rvs1Attn3_LTE = tAGC_ATTENMAX_LTE_1;
			Sts->Rvs1Attn4_LTE = tmpAgcAttn_LTE1 - tAGC_ATTENMAX_LTE_1;
		}
		CurrRvsAgcAttn_LTE_1 = Sts->Rvs1Attn3_LTE + Sts->Rvs1Attn4_LTE;


		if(Sts->Rvs1AlcAttn_LTE <= RVSALC25_ATTENMAX_LTE) 
		{
			Sts->Rvs1Attn1_LTE = Sts->Rvs1AlcAttn_LTE;
			Sts->Rvs1Attn2_LTE = 0;
		}
		else
		{
			Sts->Rvs1Attn1_LTE = RVSALC25_ATTENMAX_LTE;
			Sts->Rvs1Attn2_LTE = Sts->Rvs1AlcAttn_LTE - RVSALC25_ATTENMAX_LTE;
		}
	}
}

void FwdAGCCheck_LTE_A_1(void)
{
	INT8U tmpAttn_LTE_A1 = 0;
	INT8U tmpAttn_LTE_A2 = 0;
	INT8S CurrAttn = 0;
	INT8U tAmpOnOff = 0;

	INT8S tAgcAttn_LTE_A1_1; 
	INT8S tAgcAttn_LTE_A2_1; 
	INT8S tRvsAGCMAX_LTE_A1; 
	INT8S tRvsAGCMAX_LTE_A2; 

	__Dnr_Sts  *Sts = tDnrSts; 

	{
		iAGCOnOff= Sts->AGCOnOff_LTE_A_1;
		iAGClimit = OneOutPwrConv(Sts->Fwd1OutUpperLmt_LTE_A1);

		if( Sts->AGCMode_LTE_A1 == _AGCAvgMode)
		{
			iAGCPwr = OneOutPwrConv(Sts->Fwd1OutPwr_LTE_A1);
		}
		else
		{
			iAGCPwr = OneOutPwrConv(Sts->Fwd1OutPwrPeak_LTE_A1);
		}

		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->Fwd1AgcAttn_LTE_A1, AGCMAX_LTE_A1, ATTENMIN,Sts->FwdAmp1OnOff_LTE_A1,_AGCMode);
	}

	{
		iAGCOnOff= Sts->Rvs1AlcOnOff_LTE_A1;
		iAGClimit = Sts->Rvs1ALCLvl_LTE_A1*2;
		iAGCPwr = Sts->Det1Pwr.Rvs1OutPwr_LTE_A1;
		
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->Rvs1AlcAttn_LTE_A1, tRvsALCMAX_LTE_A1, ATTENMIN,Sts->FwdAmp1OnOff_LTE_A1, _ALCMode);
	}
	


	{
		iAGCOnOff = Sts->AGCOnOff_LTE_A_1;
		iAGClimit = OneOutPwrConv(Sts->Fwd1OutUpperLmt_LTE_A2);
		if( Sts->AGCMode_LTE_A2 == _AGCAvgMode)
		{
			iAGCPwr = OneOutPwrConv(Sts->Fwd1OutPwr_LTE_A2);
		}
		else
		{
			iAGCPwr = OneOutPwrConv(Sts->Fwd1OutPwrPeak_LTE_A2);
		}	
		
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->Fwd1AgcAttn_LTE_A2, AGCMAX_LTE_A1, ATTENMIN,Sts->FwdAmp1OnOff_LTE_A2,_AGCMode);
	}

	{
		iAGCOnOff= Sts->Rvs1AlcOnOff_LTE_A2;
		iAGClimit = Sts->Rvs1ALCLvl_LTE_A2*2;
		iAGCPwr = Sts->Det1Pwr.Rvs1OutPwr_LTE_A2;
		
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->Rvs1AlcAttn_LTE_A2, tRvsALCMAX_LTE_A1, ATTENMIN,Sts->FwdAmp1OnOff_LTE_A2, _ALCMode);
	}

	{
		iAGCOnOff  = Enable;
		iAGCAttnMAX = 20*2;
		iAGClimit = OtherFwd1OverInLmt_LTE_A; 		// -37*2dBm
		iAGCPwr = -Sts->Det1Pwr.FwdInPwr_LTE_A_1*2;
		if((Sts->FwdAmp1OnOff_LTE_A2)||(Sts->FwdAmp1OnOff_LTE_A2))	tAmpOnOff = Disable;
		else 														tAmpOnOff = Enable;
		AGCCheck(iAGCPwr, iAGClimit,iAGCOnOff, &Sts->FwdInAlcAttn_LTE_A_1, iAGCAttnMAX, ATTENMIN,tAmpOnOff,_InputALCMode);
	}

	if( Sts->Fwd1AgcAttn_LTE_A1 > Sts->FwdInAlcAttn_LTE_A_1 )
	{
		tAgcAttn_LTE_A1_1 = Sts->Fwd1AgcAttn_LTE_A1 - Sts->FwdInAlcAttn_LTE_A_1; 
	}
	else tAgcAttn_LTE_A1_1 = Sts->Fwd1AgcAttn_LTE_A1;

	if( Sts->Fwd1AgcAttn_LTE_A2 > Sts->FwdInAlcAttn_LTE_A_1)
	{
		tAgcAttn_LTE_A2_1 = Sts->Fwd1AgcAttn_LTE_A2 - Sts->FwdInAlcAttn_LTE_A_1;
	}
	else tAgcAttn_LTE_A2_1 = Sts->Fwd1AgcAttn_LTE_A2;

	if((Sts->AlmSts.FwdAmp1OnOff_LTE_A1 == Disable)&&(Sts->AlmSts.FwdAmp1OnOff_LTE_A2 == Enable))
	{
		tAgcAttn_LTE_A1_1 = DIGATTENMAX_2G;
	}
	
	if((Sts->AlmSts.FwdAmp1OnOff_LTE_A2 == Disable)&&(Sts->AlmSts.FwdAmp1OnOff_LTE_A1 == Enable))
	{
		tAgcAttn_LTE_A2_1 = DIGATTENMAX_2G;
	}


	if(tAgcAttn_LTE_A1_1 >= AGC25_ATTENMAX_LTE_A1)
	{
		Sts->cFwdAttn_LTE_A1_1 = tAgcAttn_LTE_A1_1 - AGC25_ATTENMAX_LTE_A1;
	}
	else
	{
		Sts->cFwdAttn_LTE_A1_1 = 0;
	}

	if(tAgcAttn_LTE_A2_1 >= AGC25_ATTENMAX_LTE_A1)
	{
		Sts->cFwdAttn_LTE_A2_1 = tAgcAttn_LTE_A2_1 - AGC25_ATTENMAX_LTE_A1;
	}
	else
	{
		Sts->cFwdAttn_LTE_A2_1 = 0;
	}

	if( Sts->cFwdAttn_LTE_A2_1 >  Sts->cFwdAttn_LTE_A1_1)	
	{
		Sts->Fwd1Attn1_LTE_A = Sts->cFwdAttn_LTE_A2_1 + Sts->FwdInAlcAttn_LTE_A_1;
	}
	else											
	{
		Sts->Fwd1Attn1_LTE_A = Sts->cFwdAttn_LTE_A1_1 + Sts->FwdInAlcAttn_LTE_A_1;
	}

	tmpAttn_LTE_A1 = tAgcAttn_LTE_A1_1 - Sts->Fwd1Attn1_LTE_A;
	tmpAttn_LTE_A2 = tAgcAttn_LTE_A2_1 - Sts->Fwd1Attn1_LTE_A;


	if(tAgcAttn_LTE_A1_1 <= AGC25_ATTENMAX_LTE_A1)
	{
		CurrAttn = Sts->cFwdAttn_LTE_A2_1 - Sts->cFwdAttn_LTE_A1_1;

		if( Sts->cFwdAttn_LTE_A2_1 >=  Sts->cFwdAttn_LTE_A1_1)
		{
			if(tAgcAttn_LTE_A1_1 > CurrAttn)
			{
				Sts->Att1Offset.Fwd1Attn1_LTE_A1 = tAgcAttn_LTE_A1_1 - CurrAttn;
				Sts->Fwd1Attn2_LTE_A1  = ToggleFwdAttn_LTE_A1;
			}
			else
			{
				Sts->Att1Offset.Fwd1Attn1_LTE_A1 = 0;

				if((Sts->AlmSts.FwdAmp1OnOff_LTE_A1 == Disable)||( Sts->Det1Pwr.Fwd1OutAvgPwr_LTE_A1 <= 0))
				{
					Sts->Fwd1Attn2_LTE_A1  = ToggleFwdAttn_LTE_A1;
				}
				else
				{
					Sts->Fwd1Attn2_LTE_A1  = ToggleFwdAttn_LTE_A1 - ( CurrAttn - tAgcAttn_LTE_A1_1) ;
				}
			}
			
			Sts->Fwd1Attn2_LTE_A1 = MinMaxAttnCheck(Sts->Fwd1Attn2_LTE_A1 ,ATTENMAX,ATTENMIN);
		}
	}
	else
	{
 		CurrAttn = Sts->cFwdAttn_LTE_A2_1 - Sts->cFwdAttn_LTE_A1_1;

		if( Sts->cFwdAttn_LTE_A2_1 <=  Sts->cFwdAttn_LTE_A1_1)	
		{
			Sts->Att1Offset.Fwd1Attn1_LTE_A1  = AGC25_ATTENMAX_LTE_A1;
		}
		else
		{
			Sts->Att1Offset.Fwd1Attn1_LTE_A1  = AGC25_ATTENMAX_LTE_A1 - CurrAttn;
		}
		
		Sts->Fwd1Attn2_LTE_A1	= ToggleFwdAttn_LTE_A1;
	}

	Sts->Fwd1Attn1_LTE_A1  = Sts->Att1Offset.Fwd1Attn1_LTE_A1;

	if(tAgcAttn_LTE_A2_1 <= AGC25_ATTENMAX_LTE_A1)
	{
		CurrAttn = Sts->cFwdAttn_LTE_A1_1 - Sts->cFwdAttn_LTE_A2_1;

		if( Sts->cFwdAttn_LTE_A2_1 <=  Sts->cFwdAttn_LTE_A1_1)
		{
			if(tAgcAttn_LTE_A2_1 > CurrAttn)
			{
				Sts->Att1Offset.Fwd1Attn1_LTE_A2 = tAgcAttn_LTE_A2_1- CurrAttn;
				Sts->Fwd1Attn2_LTE_A2 = ToggleFwdAttn_LTE_A2;
			}
			else
			{
				Sts->Att1Offset.Fwd1Attn1_LTE_A2 = 0;

				if((Sts->AlmSts.FwdAmp1OnOff_LTE_A2 == Disable)||( Sts->DetPwr.FwdOutAvgPwr_LTE_A2 <= 0))
				{
					Sts->Fwd1Attn2_LTE_A2 = ToggleFwdAttn_LTE_A2;
				}
				else
				{
					Sts->Fwd1Attn2_LTE_A2 = ToggleFwdAttn_LTE_A2 - ( CurrAttn - tAgcAttn_LTE_A2_1) ;
				}
			}
			
			Sts->Fwd1Attn2_LTE_A2 = MinMaxAttnCheck(Sts->Fwd1Attn2_LTE_A2 ,ATTENMAX,ATTENMIN);
		}
	}
	else
	{
		CurrAttn = Sts->cFwdAttn_LTE_A1_1 - Sts->cFwdAttn_LTE_A2_1;

		if( Sts->cFwdAttn_LTE_A2_1 >=  Sts->cFwdAttn_LTE_A1_1)	
		{
			Sts->Att1Offset.Fwd1Attn1_LTE_A2 = AGC25_ATTENMAX_LTE_A1;
		}
		else
		{
			Sts->Att1Offset.Fwd1Attn1_LTE_A2 = AGC25_ATTENMAX_LTE_A1- CurrAttn;
		}
		
		Sts->Fwd1Attn2_LTE_A2 = ToggleFwdAttn_LTE_A2;
	}

	Sts->Fwd1Attn1_LTE_A2  = Sts->Att1Offset.Fwd1Attn1_LTE_A2;

	
	tRvsAGCMAX_LTE_A1 = AGCMAX_LTE_A1+ Sts->Rvs1GainBalance_LTE_A1*2;
	CurrAgcAttn_LTE_A1_1 = Sts->Fwd1Attn1_LTE_A + Sts->Fwd1Attn1_LTE_A1;

	
 	if(Sts->AGCOnOff_LTE_A_1 == Enable)
	{
		Sts->Rvs1GainAttn_LTE_A1 = CurrAgcAttn_LTE_A1_1 - Sts->Rvs1AlcAttn_LTE_A1 + Sts->Rvs1GainBalance_LTE_A1*2;
		Sts->Rvs1GainAttn_LTE_A1 = MinMaxAttnCheck(Sts->Rvs1GainAttn_LTE_A1,tRvsAGCMAX_LTE_A1,ATTENMIN);
		CurrRvsAgcAttn_LTE_A1_1 = Sts->Rvs1GainAttn_LTE_A1;
	}
	else
	{
		CurrRvsAgcAttn_LTE_A1_1 = Sts->Rvs1GainAttn_LTE_A1 - Sts->Rvs1AlcAttn_LTE_A1 +  Sts->Rvs1GainBalance_LTE_A1*2;
		CurrRvsAgcAttn_LTE_A1_1	= MinMaxAttnCheck(CurrRvsAgcAttn_LTE_A1_1, tRvsAGCMAX_LTE_A1,ATTENMIN);
	}

	if(Sts->AlmSts.FwdAmp1OnOff_LTE_A1 == Disable)
	{
		CurrRvsAgcAttn_LTE_A1_1 = tRvsAGCMAX_LTE_A1;
	}

	tRvsAGCMAX_LTE_A2 = AGCMAX_LTE_A1+ Sts->Rvs1GainBalance_LTE_A2*2;
	CurrAgcAttn_LTE_A2_1 = Sts->Fwd1Attn1_LTE_A + Sts->Fwd1Attn1_LTE_A2;
	if(Sts->AGCOnOff_LTE_A_1 == Enable)
	{
		Sts->Rvs1GainAttn_LTE_A2 = CurrAgcAttn_LTE_A2_1 - Sts->Rvs1AlcAttn_LTE_A2 + Sts->Rvs1GainBalance_LTE_A2*2;
		Sts->Rvs1GainAttn_LTE_A2 = MinMaxAttnCheck(Sts->Rvs1GainAttn_LTE_A2,tRvsAGCMAX_LTE_A2,ATTENMIN);
		CurrRvsAgcAttn_LTE_A2_1 = Sts->Rvs1GainAttn_LTE_A2;
	}
	else
	{
		CurrRvsAgcAttn_LTE_A2_1 = Sts->Rvs1GainAttn_LTE_A2 - Sts->Rvs1AlcAttn_LTE_A2+  Sts->Rvs1GainBalance_LTE_A2*2;
		CurrRvsAgcAttn_LTE_A2_1	= MinMaxAttnCheck(CurrRvsAgcAttn_LTE_A2_1, tRvsAGCMAX_LTE_A2,ATTENMIN);
	}


	if(Sts->AlmSts.FwdAmp1OnOff_LTE_A2 == Disable)
	{
		CurrRvsAgcAttn_LTE_A2_1 = tRvsAGCMAX_LTE_A2;
	}	

	tAGC_ATTENMAX_LTE_A1 = RVSAGC15_ATTENMAX_LTE_A1 + Sts->Rvs1GainBalance_LTE_A1*2;
	if(CurrRvsAgcAttn_LTE_A1_1 < tAGC_ATTENMAX_LTE_A1)
	{
		Sts->Rvs1Attn2_LTE_A1 = CurrRvsAgcAttn_LTE_A1_1;
		Sts->Rvs1Attn3_LTE_A1 = 0;
	}
	else
	{
		Sts->Rvs1Attn2_LTE_A1 = tAGC_ATTENMAX_LTE_A1;
		Sts->Rvs1Attn3_LTE_A1 = CurrRvsAgcAttn_LTE_A1_1 - tAGC_ATTENMAX_LTE_A1;
	}
	Sts->Rvs1Attn3_LTE_A1	= MinMaxAttnCheck(Sts->Rvs1Attn3_LTE_A1, DIGATTENMAX,ATTENMIN);
	CurrRvsAgcAttn_LTE_A1_1 = Sts->Rvs1Attn2_LTE_A1 +Sts->Rvs1Attn3_LTE_A1;


	tAGC_ATTENMAX_LTE_A2 = RVSAGC15_ATTENMAX_LTE_A2 + Sts->RvsGainBalance_LTE_A2*2;
	if(CurrRvsAgcAttn_LTE_A2_1 < tAGC_ATTENMAX_LTE_A2) 
	{
		Sts->Rvs1Attn2_LTE_A2 = CurrRvsAgcAttn_LTE_A2_1;
		Sts->Rvs1Attn3_LTE_A2 = 0;
	}
	else
	{
		Sts->Rvs1Attn2_LTE_A2 = tAGC_ATTENMAX_LTE_A2;
		Sts->Rvs1Attn3_LTE_A2 = CurrRvsAgcAttn_LTE_A2_1 - tAGC_ATTENMAX_LTE_A2;
	}	
	Sts->Rvs1Attn3_LTE_A2	= MinMaxAttnCheck(Sts->Rvs1Attn3_LTE_A2, DIGATTENMAX,ATTENMIN);

    
/////////////////////////////////////////////////////////////////////////////////
	if(Sts->Rvs1AlcAttn_LTE_A1 > ALCATTENMAX_LTE)
	{
		Sts->cRvs1Attn_LTE_A1 = Sts->Rvs1AlcAttn_LTE_A1 - ALCATTENMAX_LTE;
	}
	else Sts->cRvs1Attn_LTE_A1 = 0;
		
	if(Sts->Rvs1AlcAttn_LTE_A2 > ALCATTENMAX_LTE)
	{
		Sts->cRvs1Attn_LTE_A2 = Sts->Rvs1AlcAttn_LTE_A2 - ALCATTENMAX_LTE;
	}
	else Sts->cRvs1Attn_LTE_A2 = 0;
	
	if( Sts->cRvs1Attn_LTE_A2 >  Sts->cRvs1Attn_LTE_A1)	Sts->Rvs1Attn1_LTE_A = Sts->cRvs1Attn_LTE_A2;
	else												Sts->Rvs1Attn1_LTE_A = Sts->cRvs1Attn_LTE_A1;
	if (Sts->Rvs1Attn1_LTE_A >= ALCATTENMAX_LTE) Sts->RvsAttn1_LTE_A = ALCATTENMAX_LTE;

	tmpAttn_LTE_A1 = Sts->Rvs1AlcAttn_LTE_A1 - Sts->Rvs1Attn1_LTE_A;
	tmpAttn_LTE_A2 = Sts->Rvs1AlcAttn_LTE_A2 - Sts->Rvs1Attn1_LTE_A;

	if( Sts->Rvs1AlcAttn_LTE_A1 >= Sts->Rvs1AlcAttn_LTE_A2)
	{
		Sts->Rvs1Attn1_LTE_A1  = tmpAttn_LTE_A1;

		if( Sts->Rvs1Attn1_LTE_A < tmpAttn_LTE_A2 )
		{
			Sts->Rvs1Attn1_LTE_A2 = tmpAttn_LTE_A2 - Sts->Rvs1Attn1_LTE_A;
		}
		else
		{
			Sts->Rvs1Attn1_LTE_A2 = 0;
		}
		
		Sts->Rvs1Attn1_LTE_A2	= MinMaxAttnCheck(Sts->Rvs1Attn1_LTE_A2, DIGATTENMAX,ATTENMIN);
	}
	else if( Sts->Rvs1AlcAttn_LTE_A1 < (Sts->Rvs1AlcAttn_LTE_A2 ))
	{
		Sts->Rvs1Attn1_LTE_A2  = tmpAttn_LTE_A2;
		if( Sts->Rvs1Attn1_LTE_A < tmpAttn_LTE_A1)
		{
			Sts->Rvs1Attn1_LTE_A1  = tmpAttn_LTE_A1 - Sts->Rvs1Attn1_LTE_A;
		}
		else
		{
			Sts->Rvs1Attn1_LTE_A1 = 0;
		}
		
		Sts->Rvs1Attn1_LTE_A1	= MinMaxAttnCheck(Sts->Rvs1Attn1_LTE_A1, DIGATTENMAX,ATTENMIN);
	}
}


void TRIO_AlarmCheck(void)
{
	__Dnr_Sts  *Sts = tDnrSts; 
	INT8U AlmSts = 0;

	if(Sts->FwdAmpOnOff_3G == Disable)
	{
		Sts->AlmSts.FwdAmpOnOff_3G = Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_3G == Enable) 
		{
			AlmSts  = Sts->AlmSts.LocalFail_3G;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_3G = Disable;
			FlagAmpOnOff_3G = SET;
			if(Sts->AlmSts.LocalFail_3G)		tDnrSts->AmpOffCase_3G = __PllFail;
		}
		else
		{
			Sts->AlmSts.FwdAmpOnOff_3G = Enable;
			if(FlagAmpOnOff_3G)
			{

				tDnrSts->AmpOffCase_3G = __UsrCtrl;
				FlagAmpOnOff_3G = RESET;
				AttnOutBufferInit();
			}
		}
	}

	if(Sts->FwdAmpOnOff_2G == Disable)
	{
		Sts->AlmSts.FwdAmpOnOff_2G = Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_2G == Enable) 
		{
			AlmSts  = Sts->AlmSts.LocalFail_CDMALTE;	
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_2G = Disable;
			FlagAmpOnOff_2G = SET;
			
			if(Sts->AlmSts.LocalFail_CDMALTE)		tDnrSts->AmpOffCase_2G = __PllFail;

		}
		else
		{
			Sts->AlmSts.FwdAmpOnOff_2G = Enable;

			if(FlagAmpOnOff_2G)
			{
				tDnrSts->AmpOffCase_2G = __UsrCtrl;
				FlagAmpOnOff_2G = RESET;
				AttnOutBufferInit();
			}
		}
	}

	
	if(Sts->FwdAmpOnOff_LTE == Disable)
	{
		Sts->AlmSts.FwdAmpOnOff_LTE = Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_LTE == Enable) 
		{
			AlmSts  = Sts->AlmSts.LocalFail_CDMALTE;
			if(AlarmCheck_LTE == 0) AlmSts  += 1;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_LTE = Disable;
			FlagAmpOnOff_LTE = SET;
			if(Sts->AlmSts.LocalFail_CDMALTE)		tDnrSts->AmpOffCase_LTE = __PllFail;
		}
		else
		{
			Sts->AlmSts.FwdAmpOnOff_LTE= Enable;

			if(FlagAmpOnOff_LTE)
			{
				tDnrSts->AmpOffCase_LTE = __UsrCtrl;
				FlagAmpOnOff_LTE = RESET;
				AttnOutBufferInit();
			}
		}
	}
	

	if(Sts->FwdAmpOnOff_LTE_A1 == Disable)
	{
		Sts->AlmSts.FwdAmpOnOff_LTE_A1= Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_LTE_A1 == Enable) 
		{

			AlmSts  = Sts->AlmSts.LocalFail_LTE_A1;
			AlmSts  += Sts->AlmSts.LocalFail_LTE_A2;
			if(AlarmCheck_LTE_A1 == 0) AlmSts  += 1;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_LTE_A1 = Disable;
			FlagAmpOnOff_LTE_A1 = SET;

			if(Sts->AlmSts.LocalFail_LTE_A1)		
			{
				tDnrSts->AmpOffCase_LTE_A1 = __PllFail;
				tDnrSts->AmpOffCase_LTE_A2 = __PllFail;
			}
		}
		else
		{
			Sts->AlmSts.FwdAmpOnOff_LTE_A1= Enable;

			if(FlagAmpOnOff_LTE_A1)
			{
				tDnrSts->AmpOffCase_LTE_A1 = __UsrCtrl;
				FlagAmpOnOff_LTE_A1 = RESET;
				AttnOutBufferInit();
			}
		}
	}

	
	if(Sts->FwdAmpOnOff_LTE_A2 == Disable)
	{
		Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_LTE_A2 == Enable) 
		{
			AlmSts	= Sts->AlmSts.LocalFail_LTE_A1;
			AlmSts	+= Sts->AlmSts.LocalFail_LTE_A2;
			if(AlarmCheck_LTE_A2 == 0) AlmSts  += 1;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Disable;
			FlagAmpOnOff_LTE_A2 = SET;
			
			if(Sts->AlmSts.LocalFail_LTE_A2)		
			{
				tDnrSts->AmpOffCase_LTE_A1 = __PllFail;
				tDnrSts->AmpOffCase_LTE_A2 = __PllFail;
			}
		}
		else
		{
			Sts->AlmSts.FwdAmpOnOff_LTE_A2= Enable;

			if(FlagAmpOnOff_LTE_A2)
			{
				
				tDnrSts->AmpOffCase_LTE_A2 = __UsrCtrl;
				FlagAmpOnOff_LTE_A2 = RESET;
				AttnOutBufferInit();
			}
		}
	}	

	if(Sts->FwdAmp1OnOff_LTE == Disable)
	{
		Sts->AlmSts.FwdAmp1OnOff_LTE = Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_LTE1 == Enable) 
		{
			AlmSts	= Sts->AlmSts.LocalFail_LTE_1;
			if(AlarmCheck_LTE_1 == 0) AlmSts  += 1;
		}

		if(AlmSts)
		{
			Sts->AlmSts.FwdAmp1OnOff_LTE = Disable;
			FlagAmp1OnOff_LTE = SET;
			
			if(Sts->AlmSts.LocalFail_LTE_1)		tDnrSts->Amp1OffCase_LTE = __PllFail;
		}
		else
		{
			Sts->AlmSts.FwdAmp1OnOff_LTE= Enable;

			if(FlagAmp1OnOff_LTE)
			{
				tDnrSts->Amp1OffCase_LTE = __UsrCtrl;
				FlagAmp1OnOff_LTE = RESET;
				AttnOutBufferInit();
			}
		}
	}


	
	if(Sts->FwdAmp1OnOff_LTE_A1 == Disable)
	{
		Sts->AlmSts.FwdAmp1OnOff_LTE_A1= Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_LTE_A1_1 == Enable) 
		{
			AlmSts  = Sts->AlmSts.LocalFail_LTE_A1_1;
			AlmSts  += Sts->AlmSts.LocalFail_LTE_A2_1;
			if(AlarmCheck_LTE_A1_1 == 0) AlmSts  += 1;
			
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = Disable;
			FlagAmp1OnOff_LTE_A1 = SET;
			if(Sts->AlmSts.LocalFail_LTE_A1_1)
			{
				tDnrSts->Amp1OffCase_LTE_A1 = __PllFail;
				tDnrSts->Amp1OffCase_LTE_A2 = __PllFail;
			}
		}
		else
		{
			Sts->AlmSts.FwdAmp1OnOff_LTE_A1= Enable;

			if(FlagAmp1OnOff_LTE_A1)
			{
				tDnrSts->Amp1OffCase_LTE_A1 = __UsrCtrl;
				FlagAmp1OnOff_LTE_A1 = RESET;
				AttnOutBufferInit();
			}
		}
	}

	

	if(Sts->FwdAmp1OnOff_LTE_A2 == Disable)
	{
		Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_LTE_A2_1 == Enable) 
		{
			AlmSts  = Sts->AlmSts.LocalFail_LTE_A1_1;
			AlmSts  += Sts->AlmSts.LocalFail_LTE_A2_1;
			if(AlarmCheck_LTE_A2_1 == 0) AlmSts  += 1;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = Disable;
			FlagAmp1OnOff_LTE_A2 = SET;
			
			if(Sts->AlmSts.LocalFail_LTE_A2_1)
			{
				tDnrSts->Amp1OffCase_LTE_A1 = __PllFail;
				tDnrSts->Amp1OffCase_LTE_A2 = __PllFail;
			}
		}
		else
		{
			Sts->AlmSts.FwdAmp1OnOff_LTE_A2= Enable;

			if(FlagAmp1OnOff_LTE_A2)
			{
				tDnrSts->Amp1OffCase_LTE_A2 = __UsrCtrl;
				FlagAmp1OnOff_LTE_A2 = RESET;
				AttnOutBufferInit();
			}
		}
	}

}

void ShutdownFunc(INT8U SysPath, INT8U Path)
{
	INT8U	OffReason, OffTime;
	INT16U	SdTimer;
	INT16S	DetValue, LmtValue;
	
	INT8U	*AmpOnOff;
	INT8U	AlarmChk = 0;

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
			DetValue		= - tDnrSts->FwdInPwr_3G;
			LmtValue		= tDnrSts->OverInAlarmLmt_3G/2;	//과입력 Shutdown  -19dBm

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
		// LTE-A1
		case SD_FI_LTE_A1:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE_A1;
			DetValue		= -tDnrSts->FwdInPwr_LTE_A1;
			LmtValue		= tDnrSts->OverInAlarmLmt_LTE_A1/2;	// 과입력 Shutdown -15dBm

			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A1;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->FwdAgcAttn_LTE_A1 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				AlarmChk = SET;
			}				
			#endif	
			break;

		case SD_FO_LTE_A1:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE_A1;
			DetValue = Sts->FwdOutPwr_LTE_A1[0]*10 + Sts->FwdOutPwr_LTE_A1[1];
			LmtValue = Sts->FwdOutHighLmt_LTE_A1[0]*10 + Sts->FwdOutHighLmt_LTE_A1[1];

			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A1;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->FwdAgcAttn_LTE_A1 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				AlarmChk = SET;
			}				
			#endif	
			break;

		case SD_RO_LTE_A1:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE_A1;
			DetValue = Sts->RvsOutPwr_LTE_A1[0]*10 + Sts->RvsOutPwr_LTE_A1[1];
			LmtValue = (Sts->RvsOutUpperLmt_LTE_A1[0]*10 + Sts->RvsOutUpperLmt_LTE_A1[1]);

			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A1;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->RvsAlcAttn_LTE_A1 == tRvsALCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_0 == Disable)
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
			DetValue		= -tDnrSts->FwdInPwr_LTE_A2;
			LmtValue		= tDnrSts->OverInAlarmLmt_LTE_A2/2;	// 과입력 Shutdown -15dBm

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

		// LTE MIMO
		case SD_FI_LTE_1:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE_1;
			DetValue = -tDnrSts->Fwd1InPwr_LTE;
			LmtValue = tDnrSts->OverInAlarmLmt_LTE/2;	 //과입력 Shutdown -8dBm

			AmpOnOff = &Sts->FwdAmp1OnOff_LTE;
			#ifdef RvsSD_Debug
			if((Sts->AGC1OnOff_LTE == Enable)&&(Sts->Fwd1AgcAttn_LTE == AGCMAX_LTE))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGC1OnOff_LTE == Disable)
			{
				AlarmChk = SET;
			}				
			#endif	

			break;

		case SD_FO_LTE_1:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE_1;
			DetValue = Sts->Fwd1OutPwr_LTE[0]*10 + Sts->Fwd1OutPwr_LTE[1];
			LmtValue = Sts->Fwd1OutHighLmt_LTE[0]*10 + Sts->Fwd1OutHighLmt_LTE[1];
			AmpOnOff = &Sts->FwdAmp1OnOff_LTE;
			#ifdef RvsSD_Debug
			if((Sts->AGC1OnOff_LTE == Enable)&&(Sts->Fwd1AgcAttn_LTE == AGCMAX_LTE))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGC1OnOff_LTE == Disable)
			{
				AlarmChk = SET;
			}				
			#endif	
			
			break;

		case SD_RO_LTE_1:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE_1;
			DetValue = Sts->Rvs1OutPwr_LTE[0]*10 + Sts->Rvs1OutPwr_LTE[1];
			LmtValue = Sts->Rvs1OutUpperLmt_LTE[0]*10 + Sts->Rvs1OutUpperLmt_LTE[1];

			AmpOnOff = &Sts->FwdAmp1OnOff_LTE;
#if 1
			#ifdef RvsSD_Debug
//			if((Sts->AGC1OnOff_LTE == Enable)&&(Sts->Rvs1AlcAttn_LTE == AGCMAX_LTE))
			if((Sts->AGC1OnOff_LTE == Enable)&&(Sts->Rvs1AlcAttn_LTE == tRvsALCMAX_LTE))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGC1OnOff_LTE == Disable)
			{
				AlarmChk = SET;
			}
			#endif	
		#endif	
		//	AlarmChk = SET;

			break;

		// LTE-A1 MIMO
		case SD_FI_LTE_A1_1:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE_A1_1;
			DetValue		= -tDnrSts->Fwd1InPwr_LTE_A1;
			LmtValue		= tDnrSts->OverInAlarmLmt_LTE_A1/2;	// 과입력 Shutdown -15dBm

			AmpOnOff = &Sts->FwdAmp1OnOff_LTE_A1;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_1 == Enable)&&(Sts->Fwd1AgcAttn_LTE_A1 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				AlarmChk = SET;
			}
			#endif	

			break;

		case SD_FO_LTE_A1_1:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE_A1_1;
			DetValue = Sts->Fwd1OutPwr_LTE_A1[0]*10 + Sts->Fwd1OutPwr_LTE_A1[1];
			LmtValue = Sts->Fwd1OutHighLmt_LTE_A1[0]*10 + Sts->Fwd1OutHighLmt_LTE_A1[1];

			AmpOnOff = &Sts->FwdAmp1OnOff_LTE_A1;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_1 == Enable)&&(Sts->Fwd1AgcAttn_LTE_A1 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				AlarmChk = SET;
			}			
			#endif				
			break;

		case SD_RO_LTE_A1_1:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE_A1_1;
			DetValue = Sts->Rvs1OutPwr_LTE_A1[0]*10 + Sts->Rvs1OutPwr_LTE_A1[1];
			LmtValue = (Sts->Rvs1OutUpperLmt_LTE_A1[0]*10 + Sts->Rvs1OutUpperLmt_LTE_A1[1]);

			AmpOnOff = &Sts->FwdAmp1OnOff_LTE_A1;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_1 == Enable)&&(Sts->Rvs1AlcAttn_LTE_A1 == tRvsALCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				AlarmChk = SET;
			}			
			#endif				
			break;
			
		//---------------------------------------------------------------------//
		// LTE-A2
		case SD_FI_LTE_A2_1:
			OffReason 	= CASE_OverInPwr;
			SdTimer 	= TimerSD_LTE_A2_1;
			DetValue	= -tDnrSts->Fwd1InPwr_LTE_A2;
			LmtValue	= tDnrSts->OverInAlarmLmt_LTE_A2/2;	// 과입력 Shutdown -15dBm

			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A2;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_1 == Enable)&&(Sts->Fwd1AgcAttn_LTE_A2 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				AlarmChk = SET;
			}			
			#endif				
			break;

		case SD_FO_LTE_A2_1:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE_A2_1;
			DetValue = Sts->Fwd1OutPwr_LTE_A2[0]*10 + Sts->Fwd1OutPwr_LTE_A2[1];
			LmtValue = Sts->Fwd1OutHighLmt_LTE_A2[0]*10 + Sts->Fwd1OutHighLmt_LTE_A2[1];

			AmpOnOff = &Sts->FwdAmp1OnOff_LTE_A2;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_1 == Enable)&&(Sts->Fwd1AgcAttn_LTE_A2 == AGCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				AlarmChk = SET;
			}			
			#endif	
			break;

		case SD_RO_LTE_A2_1:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE_A2_1;
			DetValue = Sts->Rvs1OutPwr_LTE_A2[0]*10 + Sts->Rvs1OutPwr_LTE_A2[1];
			LmtValue = (Sts->Rvs1OutUpperLmt_LTE_A2[0]*10 + Sts->Rvs1OutUpperLmt_LTE_A2[1]);

			AmpOnOff = &Sts->FwdAmp1OnOff_LTE_A2;
			#ifdef RvsSD_Debug
			if((Sts->AGCOnOff_LTE_A_1 == Enable)&&(Sts->Rvs1AlcAttn_LTE_A2 == tRvsALCMAX_LTE_A1))
			{
				AlarmChk = SET;
			}
			else if(Sts->AGCOnOff_LTE_A_1 == Disable)
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
				else								TimerRegist(SdTimer, Time1Sec*20L);	
				
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
				if(DetValue < (LmtValue))	// 정상... 20141229 수정
				{
					Sd_Step[Path] = 0;
					Sd_Path[SysPath] = 0;
					break;
				}
				

			
			}

			*AmpOnOff = _Disable;
			AmpBitReason(SysPath, _Disable, OffReason, SD_AMP_OFF_INF);

			Sd_Step[Path] = 30;	// 완전 Shutdown
			
			#ifdef __RvsCount
				RvsOSCAlarmCountFunc(SysPath, Path);  //////
			#endif
			
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
#if 0
			if((SysPath == PATH_2G)&&((Path == SD_FO_2G)||(Path == SD_FI_2G)||(Path == SD_RO_2G)))
			{
				AmpBitReason(PATH_LTE, _Disable, OffReason, SD_AMP_OFF_INF);

				Sts->FwdAmpOnOff_LTE = Disable;
				
				if( Path == SD_FO_2G)	Sd_Step[SD_FO_LTE] = 30;
				if( Path == SD_FI_2G)	Sd_Step[SD_FI_LTE] = 30;
				if( Path == SD_RO_2G)	Sd_Step[SD_RO_LTE] = 30;
			}
			
			if((SysPath == PATH_LTE)&&((Path == SD_FO_LTE)||(Path == SD_FI_LTE)||(Path == SD_RO_LTE)))
			{
				AmpBitReason(PATH_2G, _Disable, OffReason, SD_AMP_OFF_INF);
				
				Sts->FwdAmpOnOff_2G = Disable;
				if( Path == SD_FO_LTE)	Sd_Step[SD_FO_2G] = 30;
				if( Path == SD_FI_LTE)	Sd_Step[SD_FI_2G] = 30;
				if( Path == SD_RO_LTE)	Sd_Step[SD_RO_2G] = 30;
			}

			if((SysPath == PATH_LTE_A1)&&((Path == SD_FO_LTE_A1)||(Path == SD_FI_LTE_A1)||(Path == SD_RO_LTE_A1)))
			{
				AmpBitReason(PATH_LTE_A2, _Disable, OffReason, SD_AMP_OFF_INF);
				Sts->FwdAmpOnOff_LTE_A2 = Disable;
				if( Path == SD_FO_LTE_A1)	Sd_Step[SD_FO_LTE_A2] = 30;
				if( Path == SD_FI_LTE_A1)	Sd_Step[SD_FI_LTE_A2] = 30;
				if( Path == SD_RO_LTE_A1)	Sd_Step[SD_RO_LTE_A2] = 30;
			}
			
			if((SysPath == PATH_LTE_A2)&&((Path == SD_FO_LTE_A2)||(Path == SD_FI_LTE_A2)||(Path == SD_RO_LTE_A2)))
			{
				AmpBitReason(PATH_LTE_A1, _Disable, OffReason, SD_AMP_OFF_INF);
				Sts->FwdAmpOnOff_LTE_A1 = Disable;
				if( Path == SD_FO_LTE_A2)	Sd_Step[SD_FO_LTE_A1] = 30;
				if( Path == SD_FI_LTE_A2)	Sd_Step[SD_FI_LTE_A1] = 30;
				if( Path == SD_RO_LTE_A2)	Sd_Step[SD_RO_LTE_A1] = 30;
			}


			if((SysPath == PATH_LTE_A1_1)&&((Path == SD_FO_LTE_A1_1)||(Path == SD_FI_LTE_A1_1)||(Path == SD_RO_LTE_A1_1)))
			{
				AmpBitReason(PATH_LTE_A2_1, _Disable, OffReason, SD_AMP_OFF_INF);
				Sts->FwdAmp1OnOff_LTE_A2 = Disable;
				if( Path == SD_FO_LTE_A1_1)	Sd_Step[SD_FO_LTE_A2_1] = 30;
				if( Path == SD_FI_LTE_A1_1)	Sd_Step[SD_FI_LTE_A2_1] = 30;
				if( Path == SD_RO_LTE_A1_1)	Sd_Step[SD_RO_LTE_A2_1] = 30;
			}

			if((SysPath == PATH_LTE_A2_1)&&((Path == SD_FO_LTE_A2_1)||(Path == SD_FI_LTE_A2_1)||(Path == SD_RO_LTE_A2_1)))
			{
				AmpBitReason(PATH_LTE_A1_1, _Disable, OffReason, SD_AMP_OFF_INF);
				Sts->FwdAmp1OnOff_LTE_A1 = Disable;
				if( Path == SD_FO_LTE_A2_1)	Sd_Step[SD_FO_LTE_A1_1] = 30;
				if( Path == SD_FI_LTE_A2_1)	Sd_Step[SD_FI_LTE_A1_1] = 30;
				if( Path == SD_RO_LTE_A2_1)	Sd_Step[SD_RO_LTE_A1_1] = 30;
			}
#endif			
			break;

		//---------------------------------------------------------------------//
		default :
			Sd_Step[Path] = 0;
			Sd_Path[SysPath] = 0;
		break;
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
			

			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE = __RESET;
			Sts->AmpOffCase_LTE = Reason;
			Sts->SD_Status_LTE = AmpSts;

			if( SysPath == PATH_2G)		Sts->FwdAmpOnOff_LTE = Sts->FwdAmpOnOff_2G;
			if( SysPath == PATH_LTE)	Sts->FwdAmpOnOff_2G  = Sts->FwdAmpOnOff_LTE;
			
			break;

		case PATH_3G:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_3G = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_3G = __RESET;
			Sts->AmpOffCase_3G = Reason;
			Sts->SD_Status_3G = AmpSts;
			
			break;

			
		case PATH_LTE_A1:
		case PATH_LTE_A2:
			
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_A1 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_A1 = __RESET;
			Sts->AmpOffCase_LTE_A1 = Reason;
			Sts->SD_Status_LTE_A1 = AmpSts;
			
			PwrAlarmTimer.FwdAmpOnOff_LTE_A1 = 12;

			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __RESET;
			Sts->AmpOffCase_LTE_A2 = Reason;
			Sts->SD_Status_LTE_A2 = AmpSts;


			if( SysPath == PATH_LTE_A1)	Sts->FwdAmpOnOff_LTE_A2  = Sts->FwdAmpOnOff_LTE_A2;
			if( SysPath == PATH_LTE_A2)	Sts->FwdAmpOnOff_LTE_A1  = Sts->FwdAmpOnOff_LTE_A2;
			
			break;

		case PATH_LTE_1:
			if(EnSts)	Sts->AlmSts.FwdAmp1OnOff_LTE = __SET;
			else		Sts->AlmSts.FwdAmp1OnOff_LTE = __RESET;
			Sts->Amp1OffCase_LTE = Reason;
			Sts->SD_Status_LTE_1= AmpSts;
			
//			PwrAlarmTimer.FwdAmp1OnOff_LTE = 15;
			break;
			
		case PATH_LTE_A1_1:
		case PATH_LTE_A2_1:
			
			if(EnSts)	Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = __SET;
			else		Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = __RESET;
			Sts->Amp1OffCase_LTE_A1 = Reason;
			Sts->SD_Status_LTE_A1_1= AmpSts;
			
			if(EnSts)	Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = __SET;
			else		Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = __RESET;
			Sts->Amp1OffCase_LTE_A2 = Reason;
			Sts->SD_Status_LTE_A2_1 = AmpSts;

			if( SysPath == PATH_LTE_A1_1)	Sts->FwdAmp1OnOff_LTE_A2  = Sts->FwdAmp1OnOff_LTE_A2;
			if( SysPath == PATH_LTE_A2_1)	Sts->FwdAmp1OnOff_LTE_A1  = Sts->FwdAmp1OnOff_LTE_A2;

			
			break;			
	}
	
}
#endif  



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

		case SD_RO_LTE_A1:
			if(Sts->CurrRvsOSCAlarmCount_LTE_A1++ >= 127) Sts->CurrRvsOSCAlarmCount_LTE_A1 = 127;

		break;

		case SD_RO_LTE_A2:
			if(Sts->CurrRvsOSCAlarmCount_LTE_A2++ >= 127) Sts->CurrRvsOSCAlarmCount_LTE_A2 = 127;

		break;


		case SD_RO_LTE_1:
			if(Sts->CurrRvs1OSCAlarmCount_LTE++ >= 127) Sts->CurrRvs1OSCAlarmCount_LTE = 127;

		break;

		case SD_RO_LTE_A1_1:
			if(Sts->CurrRvs1OSCAlarmCount_LTE_A1++ >= 127) Sts->CurrRvs1OSCAlarmCount_LTE_A1 = 127;

		break;

		case SD_RO_LTE_A2_1:
			if( Sts->CurrRvs1OSCAlarmCount_LTE_A2++ >= 127) Sts->CurrRvs1OSCAlarmCount_LTE_A2 = 127;
		break;
		
		default :
			
		break;
	}
}


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
			
		case PATH_LTE_A1:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_A1 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_A1 = __RESET;
			Sts->AmpOffCase_LTE_A1 = Reason;
			Sts->SD_Status_LTE_A1 = AmpSts;
			
			PwrAlarmTimer.FwdAmpOnOff_LTE_A1 = 25;
			break;

		case PATH_LTE_A2:
			if(EnSts)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __SET;
			else		Sts->AlmSts.FwdAmpOnOff_LTE_A2 = __RESET;
			Sts->AmpOffCase_LTE_A2 = Reason;
			Sts->SD_Status_LTE_A2 = AmpSts;
			
			PwrAlarmTimer.FwdAmpOnOff_LTE_A2 = 25;
			break;

		case PATH_LTE_1:
			if(EnSts)	Sts->AlmSts.FwdAmp1OnOff_LTE = __SET;
			else		Sts->AlmSts.FwdAmp1OnOff_LTE = __RESET;
			Sts->Amp1OffCase_LTE = Reason;
			Sts->SD_Status_LTE_1= AmpSts;
			
			PwrAlarmTimer.FwdAmp1OnOff_LTE = 25;
			break;
			
		case PATH_LTE_A1_1:
			if(EnSts)	Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = __SET;
			else		Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = __RESET;
			Sts->Amp1OffCase_LTE_A1 = Reason;
			Sts->SD_Status_LTE_A1_1= AmpSts;
			
			PwrAlarmTimer.FwdAmp1OnOff_LTE_A1 = 25;
			break;

		case PATH_LTE_A2_1:
			if(EnSts)	Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = __SET;
			else		Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = __RESET;
			Sts->Amp1OffCase_LTE_A2 = Reason;
			Sts->SD_Status_LTE_A2_1 = AmpSts;
			PwrAlarmTimer.FwdAmp1OnOff_LTE_A2 = 25;
			
			break;			
	}
	
}
#endif  
////////////////////////
