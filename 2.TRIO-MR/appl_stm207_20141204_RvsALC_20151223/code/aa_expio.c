
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : exlib.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define EXPIO_C

#include "../include/main.h"

#include <stdlib.h>

void ExpioInit(void)
{
	ExpioPortInit();
	OSTaskCreate(ExpioTask, (void *)NULL, (OS_STK *)&ExpioTaskStk[EXPIO_START_STK_SIZE - 1], EXPIO_START_PRIO);

}
void ExpioPortInit(void)
{
	#ifndef __FSMC_SRAM_H
		////////////////////////////////////////////////////////////////////////////
		// 반드시 gpio init 에서 --> outputmode로 변경해야 한다...
		// select 한핀은 반드시 모두다 high로 만들어줘야 한다.
		//GPIOC->ODR.Bit.ODR6 = 1;	// CS0
		//GPIOE->ODR.Bit.ODR10 = 1; // CS1
		/***
		GPIOB->ODR.Bit.ODR9 = 1;	// CS2
		GPIOB->ODR.Bit.ODR12 = 1;	// CS3
		GPIOB->ODR.Bit.ODR13 = 1;	// CS4
		GPIOB->ODR.Bit.ODR14 = 1;	// CS5
		GPIOB->ODR.Bit.ODR15 = 1;	// CS6
		GPIOC->ODR.Bit.ODR14 = 1;	// CS7
		GPIOC->ODR.Bit.ODR15 = 1;	// CS8
		GPIOA->ODR.Bit.ODR11 = 1;	// CS9
		GPIOA->ODR.Bit.ODR12 = 1;	// CS10
	***/
	#endif //__FSMC_SRAM_H
	ExpioSem = OSSemCreate(1);
}


void ExpioTask(void *p_arg)
{
	INT8U err = 0;
	
	(void)p_arg;

//	OSTimeDly(200*EXPIO_START_PRIO);

	TimerRegist(Timer_AttnOut, Time1Sec*10L);
	TimerRegist(TimerAlmReport, Time1Sec*10L);	
	TimerRegist(Timer_Period, Time1Sec*10L);

//	TimerRegist(Timer_Period, Time1Sec*2L);
	TimerRegist(Timer_ModemReset, Time1Day*1L);
	TimerRegist(Timer_AGC, (Time1Sec));
	TimerRegist(Timer_ALC, (Time1Sec));

	TimerRegist(TimerBalance_2G, (Time1Sec));
	TimerRegist(TimerBalance_LTE, (Time1Sec));
	TimerRegist(TimerBalance_LTEA, (Time1Sec));
	TimerRegist(TimerBalance_3G, (Time1Sec));
	TimerRegist(Timer_RvsOSCAlarmCount, Time1Day*1L);

	{
		_PCA9555Init();
		pPCA9555Port_Init(0);
		pPCASetPortData(Attn_CS0, (0),pPCA9555Str);
		pPCASetPortData(Attn_CS1, (0),pPCA9555Str);
	}
	
	AmpOnOff_CDMA = 0;
	AmpOnOff_WCDMA = 0;
	AmpOnOff_LTE_0 = 0;
	AmpOnOff_LTE_A2_0 = 0;
	SMS_PWR = 0;

	Pll411xInit(RefFreq, FreqStep, 0);
	Pll411xInit(RefFreq, FreqStep, 1);
	ADC_Select(0);

	OSTimeDly(200*EXPIO_START_PRIO);
 	while(1)
	{
		while((DownLoadGiveupTimerSet(NULL)))
		{
//			FrontLEDDisplay();
			OSTimeDly(1000L);
		}
		
		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
		{
			OSSemPend(ExpSem, 0, &err );

			if(ChkAttChange == RESET) OperatingFunc();
			Period_Check();
			StatusUpdate();
			StatustoIO();

			if(TimeOverCheck(TimerAlmReport))
			{
				chkReport = SET;
			}

			OSSemPost(ExpSem);
			OSTimeDly(150L);  /// 시간조절시ALC 동작 확인 필요	

//			OSTimeDly(200L);  /// 시간조절시ALC 동작 확인 필요	
//			OSTimeDly(100L);  /// 시간조절시ALC 동작 확인 필요  기존 
		}
		OSTimeDly(250L);
	}
}

void Period_Check(void)
{
	if(!TimeOverCheck(Timer_Period)) return;
	TimerRegist(Timer_Period, Time100mSec*5L);
	AlarmCheck();

	if((tDnrSts->ModuleAlarm.Main.DCFail == Normal)&&(PwrAlarm.ACFail == Normal))
	{
		TRIO_AlarmCheck();
	}

	ShutDownCheck();	
	
	if(chkReport)
	{
		AlarmStatusUpdate();
		PeriodReportCheck();
	}

	TimerRelatedOperation();
	
	if(++PeriodCnt >= 2)
	{
 		PeriodCnt = 0;
//		ShutDownCheck();	
		
		if((PresentDay == 0)&&(PresentMonth == 0))
		{
			iSecCnt ++;
			if( iSecCnt > 60 ) 
			{
				iPresentMinCnt ++;
				iSecCnt = 0;
			}
			if( iPresentMinCnt > 24 ) iPresentHourCnt ++;
		}
	}
	
	if(TimeOverCheck(Timer_ModemReset))
	{
#if 0
//		Chk_Reset = SET;
		ResetCaseBackup(EtcReset);
		OSTimeDly(1000L);
		DownLoadBootingJump();
#endif		
	}

	if(TimeOverCheck(Timer_RvsOSCAlarmCount))
	{
		Chk_RvsOSCAlarmCount = SET;
		
		tDnrSts->RvsOSCAlarmCount_3G		= tDnrSts->CurrRvsOSCAlarmCount_3G;		
		tDnrSts->RvsOSCAlarmCount_2G		= tDnrSts->CurrRvsOSCAlarmCount_2G;		
		tDnrSts->RvsOSCAlarmCount_LTE		= tDnrSts->CurrRvsOSCAlarmCount_LTE; 	
		tDnrSts->RvsOSCAlarmCount_LTE_A1	= tDnrSts->CurrRvsOSCAlarmCount_LTE_A1;	
		tDnrSts->RvsOSCAlarmCount_LTE_A2	= tDnrSts->CurrRvsOSCAlarmCount_LTE_A2;	
		tDnrSts->Rvs1OSCAlarmCount_LTE		= tDnrSts->CurrRvs1OSCAlarmCount_LTE;	
		tDnrSts->Rvs1OSCAlarmCount_LTE_A1	= tDnrSts->CurrRvs1OSCAlarmCount_LTE_A1;	
		tDnrSts->Rvs1OSCAlarmCount_LTE_A2	= tDnrSts->CurrRvs1OSCAlarmCount_LTE_A2;
	}
}



void OperatingFunc(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	if(ChkAttChange == RESET)	
	{
		AGCCheckFunction();
		ALCCheckFunction();
	}

///WCDMA
	{
		INT8S tmpAgcAttn_3G; 
		INT8S tAgcAttn_3G; 
		INT8S tRvsAGCMAX_3G; 

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
			tAGC10_ATTENMAX_3G	= AGC10_ATTENMAX_3G + Sts->RvsGainBalance_3G*2;
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
			Sts->RvsAttn4_3G = MinMaxAttnCheck(Sts->RvsAttn4_3G,ATTENMAX,ATTENMIN);
		
			CurrRvsAlcAttn_3G = Sts->RvsAttn3_3G +Sts->RvsAttn4_3G;
		
			if(Sts->RvsAlcAttn_3G <= RVSALC20_ATTENMAX_3G) 
			{
				Sts->RvsAttn1_3G = 0;
				Sts->RvsAttn2_3G = Sts->RvsAlcAttn_3G;
			}
			else
			{
				Sts->RvsAttn1_3G = Sts->RvsAlcAttn_3G - RVSALC20_ATTENMAX_3G;
				Sts->RvsAttn2_3G = RVSALC20_ATTENMAX_3G;
			}
		}
	}

	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		INT8S tAgcAttn_2G = 0; 
		INT8S tAgcAttn_LTE = 0; 
		INT8S CurrAttn = 0;
		INT8S tRvsAGCMAX_2G; 
		INT8S tRvsAGCMAX_LTE; 


		tAgcAttn_2G = Sts->FwdAgcAttn_2G;
		tAgcAttn_LTE = Sts->FwdAgcAttn_LTE;
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

		if( Sts->cFwdAttn_LTE >	Sts->cFwdAttn_CDMA)	
		{
			Sts->FwdAttn1_CDMALTE = Sts->cFwdAttn_LTE + Sts->FwdInAlcAttn_CDMALTE;
		}
		else											
		{
			Sts->FwdAttn1_CDMALTE = Sts->cFwdAttn_CDMA + Sts->FwdInAlcAttn_CDMALTE;
		}


		Sts->FwdAttn1_CDMALTE = MinMaxAttnCheck(Sts->FwdAttn1_CDMALTE, DIGATTENMAX_2G,ATTENMIN);

		if(tAgcAttn_2G <= AGC25_ATTENMAX_2G)
		{
			CurrAttn = Sts->cFwdAttn_LTE - Sts->cFwdAttn_CDMA;
			if( Sts->cFwdAttn_LTE >=  Sts->cFwdAttn_CDMA)
			{
				if(tAgcAttn_2G > CurrAttn)
				{
					Sts->AttOffset.FwdAttn1_2G = tAgcAttn_2G - CurrAttn;
				}
				else
				{
					Sts->AttOffset.FwdAttn1_2G = 0;
				}
			}
		}
		else
		{
			CurrAttn = Sts->cFwdAttn_LTE - Sts->cFwdAttn_CDMA;
			if( Sts->cFwdAttn_LTE <=  Sts->cFwdAttn_CDMA)	
			{
				Sts->AttOffset.FwdAttn1_2G	= AGC25_ATTENMAX_2G;
			}
			else
			{
				Sts->AttOffset.FwdAttn1_2G	= AGC25_ATTENMAX_2G - CurrAttn;
			}
		}

		Sts->FwdAttn1_2G  = Sts->AttOffset.FwdAttn1_2G;

		if(tAgcAttn_LTE <= AGC25_ATTENMAX_2G)
		{
			CurrAttn = Sts->cFwdAttn_CDMA - Sts->cFwdAttn_LTE;

			if( Sts->cFwdAttn_LTE <=  Sts->cFwdAttn_CDMA)
			{
				if(tAgcAttn_LTE > CurrAttn)
				{
					Sts->AttOffset.FwdAttn1_LTE = tAgcAttn_LTE - CurrAttn;
				}
				else
				{
					Sts->AttOffset.FwdAttn1_LTE = 0;
				}
			}
		}
		else
		{
			CurrAttn = Sts->cFwdAttn_CDMA - Sts->cFwdAttn_LTE;

			if( Sts->cFwdAttn_LTE >=  Sts->cFwdAttn_CDMA)	
			{
				Sts->AttOffset.FwdAttn1_LTE = AGC25_ATTENMAX_2G;
			}
			else
			{
				Sts->AttOffset.FwdAttn1_LTE = AGC25_ATTENMAX_2G- CurrAttn;
			}
		}

		Sts->FwdAttn1_LTE  = Sts->AttOffset.FwdAttn1_LTE;
		
		tRvsAGCMAX_2G  = AGCMAX_2G  + Sts->RvsGainBalance_2G *2;
		tRvsAGCMAX_LTE = AGCMAX_LTE + Sts->RvsGainBalance_LTE *2;

		CurrAgcAttn_2G = Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_2G;

		if(Sts->AGCOnOff_CDMALTE == Enable)
		{
			Sts->RvsGainAttn_2G = CurrAgcAttn_2G - Sts->RvsAlcAttn_2G + Sts->RvsGainBalance_2G*2;
			Sts->RvsGainAttn_2G = MinMaxAttnCheck(Sts->RvsGainAttn_2G,tRvsAGCMAX_2G,ATTENMIN);
			CurrRvsAlcAttn_2G = Sts->RvsGainAttn_2G;
		}
		else
		{
			CurrRvsAlcAttn_2G = Sts->RvsGainAttn_2G - Sts->RvsAlcAttn_2G + Sts->RvsGainBalance_2G *2;
			CurrRvsAlcAttn_2G = MinMaxAttnCheck(CurrRvsAlcAttn_2G,tRvsAGCMAX_2G,ATTENMIN);
		}

		if(Sts->AlmSts.FwdAmpOnOff_2G == Disable)
		{
			CurrRvsAlcAttn_2G = tRvsAGCMAX_2G;
		}

		CurrAgcAttn_LTE = Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_LTE;
		
		if(Sts->AGCOnOff_CDMALTE == Enable)
		{
			Sts->RvsGainAttn_LTE = CurrAgcAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
			Sts->RvsGainAttn_LTE = MinMaxAttnCheck(Sts->RvsGainAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
			CurrRvsAlcAttn_LTE = Sts->RvsGainAttn_LTE;
		}
		else
		{
			CurrRvsAlcAttn_LTE = Sts->RvsGainAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
			CurrRvsAlcAttn_LTE = MinMaxAttnCheck(CurrRvsAlcAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
		}

		if(Sts->AlmSts.FwdAmpOnOff_LTE == Disable)
		{
			CurrRvsAlcAttn_LTE = tRvsAGCMAX_LTE;
		}
		
		tAGC_ATTENMAX_2G = RVSAGC20_ATTENMAX_2G + Sts->RvsGainBalance_2G*2;
		if(CurrRvsAlcAttn_2G < tAGC_ATTENMAX_2G)
		{
			Sts->RvsAttn2_2G = CurrRvsAlcAttn_2G;
			Sts->RvsAttn3_2G = 0;
		}
		else
		{
			Sts->RvsAttn2_2G = tAGC_ATTENMAX_2G;
			Sts->RvsAttn3_2G = CurrRvsAlcAttn_2G - tAGC_ATTENMAX_2G;
		}

		tAGC_ATTENMAX_LTE = RVSAGC20_ATTENMAX_2G + Sts->RvsGainBalance_LTE*2;
		if(CurrRvsAlcAttn_LTE < tAGC_ATTENMAX_LTE) 
		{
			Sts->RvsAttn2_LTE = CurrRvsAlcAttn_LTE;
			Sts->RvsAttn3_LTE = 0;
		}
		else
		{
			Sts->RvsAttn2_LTE = tAGC_ATTENMAX_LTE;
			Sts->RvsAttn3_LTE = CurrRvsAlcAttn_LTE - tAGC_ATTENMAX_LTE;
		}	

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
	else
	{
	//	INT8S tmpAgcAttn_LTE; 
		INT8S tAgcAttn_LTE; 
		INT8S tRvsAGCMAX_LTE; 

		tRvsAGCMAX_LTE = AGCMAX_LTE + Sts->RvsGainBalance_LTE*2;
		if( Sts->FwdAgcAttn_LTE > Sts->FwdInAlcAttn_CDMALTE)
		{
			tAgcAttn_LTE = Sts->FwdAgcAttn_LTE - Sts->FwdInAlcAttn_CDMALTE; 
		}
		else tAgcAttn_LTE = Sts->FwdAgcAttn_LTE;
		
		
		if(tAgcAttn_LTE >= AGC25_ATTENMAX_LTE)
		{
			Sts->FwdAttn1_LTE = tAgcAttn_LTE - AGC25_ATTENMAX_LTE;
			Sts->FwdAttn1_CDMALTE = AGC25_ATTENMAX_LTE;
		}
		else
		{
			Sts->FwdAttn1_LTE = 0;
			Sts->FwdAttn1_CDMALTE = tAgcAttn_LTE;
		}
		
		Sts->FwdAttn1_LTE = Sts->FwdAttn1_LTE + Sts->FwdInAlcAttn_CDMALTE;
		
		CurrAgcAttn_LTE = Sts->FwdAttn1_LTE + Sts->FwdAttn1_CDMALTE;
		
		if(Sts->AGCOnOff_CDMALTE == Enable)
		{
			Sts->RvsGainAttn_LTE = CurrAgcAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
			Sts->RvsGainAttn_LTE = MinMaxAttnCheck(Sts->RvsGainAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
//			tmpAgcAttn_LTE = Sts->RvsGainAttn_LTE;
			CurrRvsAlcAttn_LTE = Sts->RvsGainAttn_LTE;
		}
		else
		{
//			tmpAgcAttn_LTE = Sts->RvsGainAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
//			tmpAgcAttn_LTE = MinMaxAttnCheck(tmpAgcAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);

			CurrRvsAlcAttn_LTE = Sts->RvsGainAttn_LTE - Sts->RvsAlcAttn_LTE + Sts->RvsGainBalance_LTE*2;
			CurrRvsAlcAttn_LTE = MinMaxAttnCheck(CurrRvsAlcAttn_LTE,tRvsAGCMAX_LTE,ATTENMIN);
		}
		
		if(Sts->AlmSts.FwdAmpOnOff_LTE == Disable)
		{
//			tmpAgcAttn_LTE = AGCMAX_LTE;
			CurrRvsAlcAttn_LTE = AGCMAX_LTE;
		}
		
		{
			tAGC_ATTENMAX_LTE	= RVSAGC20_ATTENMAX_LTE + Sts->RvsGainBalance_LTE*2;
			#if 0
			if(tmpAgcAttn_LTE <= tAGC_ATTENMAX_LTE) 
			{
				Sts->RvsAttn2_LTE = tmpAgcAttn_LTE;
				Sts->RvsAttn3_LTE = 0;
			}
			else
			{
				Sts->RvsAttn2_LTE = tAGC_ATTENMAX_LTE;
				Sts->RvsAttn3_LTE = tmpAgcAttn_LTE - tAGC_ATTENMAX_LTE;
			}
			#endif

#if 1
			if(CurrRvsAlcAttn_LTE <= tAGC_ATTENMAX_LTE) 
			{
				Sts->RvsAttn2_LTE = CurrRvsAlcAttn_LTE;
				Sts->RvsAttn3_LTE = 0;
			}
			else
			{
				Sts->RvsAttn2_LTE = tAGC_ATTENMAX_LTE;
				Sts->RvsAttn3_LTE = CurrRvsAlcAttn_LTE - tAGC_ATTENMAX_LTE;
			}
#endif

			
			Sts->RvsAttn3_LTE = MinMaxAttnCheck(Sts->RvsAttn3_LTE,ATTENMAX,ATTENMIN);
		
	//		CurrRvsAlcAttn_3G = Sts->RvsAttn2_LTE +Sts->RvsAttn3_LTE;
#if 0		
			if(Sts->RvsAlcAttn_LTE <= RVSALC25_ATTENMAX_LTE) 
			{
				Sts->RvsAttn1_LTE = Sts->RvsAlcAttn_LTE;
				Sts->RvsAttn1_CDMALTE = 0;
			}
			else
			{
				Sts->RvsAttn1_LTE = RVSALC25_ATTENMAX_LTE;
				Sts->RvsAttn1_CDMALTE = Sts->RvsAlcAttn_LTE - RVSALC25_ATTENMAX_LTE;
			}
#endif	
#if 1		
			if(Sts->RvsAlcAttn_LTE <= RVSALC25_ATTENMAX_LTE) 
			{
				Sts->RvsAttn1_CDMALTE = Sts->RvsAlcAttn_LTE;
				Sts->RvsAttn1_LTE = 0;
				
			}
			else
			{
				Sts->RvsAttn1_CDMALTE = RVSALC25_ATTENMAX_LTE;
				Sts->RvsAttn1_LTE = Sts->RvsAlcAttn_LTE - RVSALC25_ATTENMAX_LTE;
			}
#endif			

		}
		
		Sts->FwdAttn1_2G  = Sts->FwdAttn1_LTE;
		Sts->RvsAttn1_2G = Sts->RvsAttn1_LTE;
		Sts->RvsAttn2_2G = Sts->RvsAttn2_LTE;
		Sts->RvsAttn3_2G = Sts->RvsAttn3_LTE;
	}

	////LTE-A
	{
		INT8S tmpAgcAttn_LTEA; 
		INT8S tAgcAttn_LTEA; 
		INT8S tRvsAGCMAX_LTEA; 

		tRvsAGCMAX_LTEA = AGCMAX_LTE_A1 + Sts->RvsGainBalance_LTE_A2*2;
		if( Sts->FwdAgcAttn_LTE_A2 > Sts->FwdInAlcAttn_LTE_A_0)
		{
			tAgcAttn_LTEA = Sts->FwdAgcAttn_LTE_A2 - Sts->FwdInAlcAttn_LTE_A_0; 
		}
		else tAgcAttn_LTEA = Sts->FwdAgcAttn_LTE_A2;
		
		
		if(tAgcAttn_LTEA >= AGC20_ATTENMAX_LTEA)
		{
			Sts->FwdAttn1_LTE_A2 = tAgcAttn_LTEA - AGC20_ATTENMAX_LTEA;
			Sts->FwdAttn2_LTE_A2= AGC20_ATTENMAX_LTEA;
		}
		else
		{
			Sts->FwdAttn1_LTE_A2 = 0;
			Sts->FwdAttn2_LTE_A2 = tAgcAttn_LTEA;
		}
		
		Sts->FwdAttn1_LTE_A2 = Sts->FwdAttn1_LTE_A2 + Sts->FwdInAlcAttn_LTE_A_0;
		CurrAgcAttn_LTE_A2 = Sts->FwdAttn1_LTE_A2 + Sts->FwdAttn2_LTE_A2;
		
		if(Sts->AGCOnOff_LTE_A_0 == Enable)
		{
			Sts->RvsGainAttn_LTE_A2 = CurrAgcAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2 + Sts->RvsGainBalance_LTE_A2*2;
			Sts->RvsGainAttn_LTE_A2 = MinMaxAttnCheck(Sts->RvsGainAttn_LTE_A2,tRvsAGCMAX_LTEA,ATTENMIN);
			tmpAgcAttn_LTEA = Sts->RvsGainAttn_LTE_A2;
		}
		else
		{
			tmpAgcAttn_LTEA = Sts->RvsGainAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2 + Sts->RvsGainBalance_LTE_A2*2;
			tmpAgcAttn_LTEA = MinMaxAttnCheck(tmpAgcAttn_LTEA,tRvsAGCMAX_LTEA,ATTENMIN);
		}
		
		if(Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Disable)
		{
			tmpAgcAttn_LTEA = AGCMAX_LTE_A1;
		}
		
		{
			tAGC_ATTENMAX_LTE_A2	= RVSAGC15_ATTENMAX_LTE_A2 + Sts->RvsGainBalance_LTE_A2*2;
			if(tmpAgcAttn_LTEA <= tAGC_ATTENMAX_LTE_A2) 
			{
				Sts->RvsAttn3_LTE_A2 = tmpAgcAttn_LTEA;
				Sts->RvsAttn4_LTE_A2 = 0;
			}
			else
			{
				Sts->RvsAttn3_LTE_A2 = tAGC_ATTENMAX_LTE_A2;
				Sts->RvsAttn4_LTE_A2 = tmpAgcAttn_LTEA - tAGC_ATTENMAX_LTE_A2;
			}
			Sts->RvsAttn4_LTE_A2 = MinMaxAttnCheck(Sts->RvsAttn4_LTE_A2,ATTENMAX,ATTENMIN);
		
			CurrRvsAlcAttn_LTE_A2 = Sts->RvsAttn3_LTE_A2 +Sts->RvsAttn4_LTE_A2;

			if(Sts->RvsAlcAttn_LTE_A2 <= RVSALC20_ATTENMAX_LTE_A2) 
			{
				Sts->RvsAttn1_LTE_A2 = 0;
				Sts->RvsAttn2_LTE_A2 = Sts->RvsAlcAttn_LTE_A2;
			}
			else
			{
				Sts->RvsAttn1_LTE_A2 = Sts->RvsAlcAttn_LTE_A2 - RVSALC20_ATTENMAX_LTE_A2;
				Sts->RvsAttn2_LTE_A2 = RVSALC20_ATTENMAX_LTE_A2;
			}
		}
	}
}


void AlarmCheck(void)
{
	INT16S cval;
	INT16S tlimit;
	INT16U RecoveryAlarm;

//	INT8U FwdLowMask;

	__Dnr_Sts *Sts = tDnrSts;
	

	if(ChkTableAlarm)
	{
		Table_Alarm();
		ChkTableAlarm = RESET;
	}

	{
		if(AC_Alarm)
		{
			ACFailCnt = ACFailCnt + 1;
//			if(ACFailCnt >= 4)
			if(ACFailCnt >= 2)
			{
				Sts->AlmSts.ACFail	= __SET;
				Pre_AC_Sts = Sts->AlmSts.ACFail;
			}
		}
		else
		{
			Sts->AlmSts.ACFail	= __RESET;
			ACFailCnt = 0;
			if(Pre_AC_Sts == __SET)
			{
				SetAcRecovery = SET;
				Chk_Reset = SET;
			}
			Pre_AC_Sts = Sts->AlmSts.ACFail;
		}
	}

///////////////////////////

	{
		// DC Alarm
		cval = Sts->DetVolt.PSUDCVolt.Data;
		tlimit = ByteToWord(Sts->VccDet_Lmt[0],Sts->VccDet_Lmt[1]);
		RecoveryAlarm  = tlimit + 200;
		if(cval <= tlimit)				PwrAlarm.DCFail = Alarm;
		else if(cval >= RecoveryAlarm)	PwrAlarm.DCFail = Normal;
	}	

	if(PwrAlarm.DCFail)	    Sts->ModuleAlarm.Main.DCFail = Alarm;
	else					Sts->ModuleAlarm.Main.DCFail = Normal;

#ifdef RvsSD_Debug
	if(PLLAlarm_WCDMA)		Sts->AlmSts.LocalFail_3G			= Normal;
	else					Sts->AlmSts.LocalFail_3G			= Alarm;
	
	if(PLLAlarm_CDMALTE)	Sts->AlmSts.LocalFail_CDMALTE		= Normal;
	else					Sts->AlmSts.LocalFail_CDMALTE		= Alarm;
	
	if(PLLAlarm_LTE_A2_0) 	Sts->AlmSts.LocalFail_LTE_A2 		= Normal;
	else					Sts->AlmSts.LocalFail_LTE_A2 		= Alarm;
#endif
	//////////////////CDMA


	if(Sts->LTE15MUse == __NOTUSE)
	{
		AlarmCheck_2G = SET;
	}
	else
	{
		AlarmCheck_2G = RESET;
	}

	if(Sts->FemtocellUseOnOff.LTE == __NOTUSE)
	{
		AlarmCheck_LTE = SET;
	}
	else
	{
		AlarmCheck_LTE = RESET;
	}


	if((Sts->Band_Select_LTE_A2[0]  == __NOTUSE)||(Sts->FemtocellUseOnOff.LTE_A2 == __USE))
	{
		AlarmCheck_LTE_A2 = RESET;
	}
	else
	{
		AlarmCheck_LTE_A2 = SET;
	}
	//  FWD OUT High
	{
		INT8U i = 0;

		mFwdHighAlm[PATH_2G].Level			= RetPower(Sts->FwdOutPwr_2G);
		mFwdHighAlm[PATH_2G].AlarmLevel 	= RetPower(Sts->FwdOutHighLmt_2G);
		mFwdHighAlm[PATH_2G].AlarmRecovery	= mFwdHighAlm[PATH_2G].AlarmLevel - 2;

		mFwdHighAlm[PATH_LTE].Level			= RetPower(Sts->FwdOutPwr_LTE);
		mFwdHighAlm[PATH_LTE].AlarmLevel 	= RetPower(Sts->FwdOutHighLmt_LTE);
		mFwdHighAlm[PATH_LTE].AlarmRecovery	= mFwdHighAlm[PATH_LTE].AlarmLevel - 2;


		mFwdHighAlm[PATH_LTEA].Level		 = RetPower(Sts->FwdOutPwr_LTE_A2);
		mFwdHighAlm[PATH_LTEA].AlarmLevel 	 = RetPower(Sts->FwdOutHighLmt_LTE_A2);
		mFwdHighAlm[PATH_LTEA].AlarmRecovery = mFwdHighAlm[PATH_LTEA].AlarmLevel - 2;

		mFwdHighAlm[PATH_3G].Level			= RetPower(Sts->FwdOutPwr_3G);
		mFwdHighAlm[PATH_3G].AlarmLevel 	= RetPower(Sts->FwdOutHighLmt_3G);
		mFwdHighAlm[PATH_3G].AlarmRecovery	= mFwdHighAlm[PATH_3G].AlarmLevel - 2;


		for(i = 0; i < SysPathMax; i++)
		{
			INT8S DetLvl 		= mFwdHighAlm[i].Level;
			INT8S LimitLvl 		= mFwdHighAlm[i].AlarmLevel;
			INT8S RecoveryLvl 	= mFwdHighAlm[i].AlarmRecovery;

			mFwdHighAlm[i].cAlarm	= HighLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}

		Sts->AlmSts.FwdOutUpperLmtFail_2G = Normal;
		if(mFwdHighAlm[PATH_2G].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_2G = Alarm;
		if(Sd_Step[SD_FO_2G] != 0)					Sts->AlmSts.FwdOutUpperLmtFail_2G = Alarm;

		Sts->AlmSts.FwdOutUpperLmtFail_LTE = Normal;
		if(mFwdHighAlm[PATH_LTE].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_LTE = Alarm;
		if(Sd_Step[SD_FO_LTE] != 0)					Sts->AlmSts.FwdOutUpperLmtFail_LTE = Alarm;


		Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2 = Normal;
		if(mFwdHighAlm[PATH_LTEA].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2 = Alarm;
		if(Sd_Step[SD_FO_LTE_A2] != 0) 				Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2 = Alarm;


		Sts->AlmSts.FwdOutUpperLmtFail_3G = Normal;
		if(mFwdHighAlm[PATH_3G].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_3G = Alarm;
		if(Sd_Step[SD_FO_3G] != 0)					Sts->AlmSts.FwdOutUpperLmtFail_3G = Alarm;

	}
	// FWD OUT Low
	{
		INT8U i = 0;

		mFwdLowAlm[PATH_2G].Level			= RetPower(Sts->FwdOutPwr_2G);
		mFwdLowAlm[PATH_2G].AlarmLevel 		= RetPower(Sts->FwdOutLowerLmt_2G);
		mFwdLowAlm[PATH_2G].AlarmRecovery	= mFwdLowAlm[PATH_2G].AlarmLevel + 2;

		mFwdLowAlm[PATH_LTE].Level			= RetPower(Sts->FwdOutPwrPeak_LTE);
		mFwdLowAlm[PATH_LTE].AlarmLevel 	= RetPower(Sts->FwdOutLowerLmt_LTE);
		mFwdLowAlm[PATH_LTE].AlarmRecovery	= mFwdLowAlm[PATH_LTE].AlarmLevel + 2;


		mFwdLowAlm[PATH_LTEA].Level		 	= RetPower(Sts->FwdOutPwrPeak_LTE_A2);
		mFwdLowAlm[PATH_LTEA].AlarmLevel 	= RetPower(Sts->FwdOutLowerLmt_LTE_A2);
		mFwdLowAlm[PATH_LTEA].AlarmRecovery = mFwdLowAlm[PATH_LTEA].AlarmLevel + 2;

		mFwdLowAlm[PATH_3G].Level			= RetPower(Sts->FwdOutPwr_3G);
		mFwdLowAlm[PATH_3G].AlarmLevel 		= RetPower(Sts->FwdOutLowerLmt_3G);
		mFwdLowAlm[PATH_3G].AlarmRecovery	= mFwdLowAlm[PATH_3G].AlarmLevel + 2;


		for(i = 0; i < SysPathMax; i++)
		{
			INT8S DetLvl 		= mFwdLowAlm[i].Level;
			INT8S LimitLvl 		= mFwdLowAlm[i].AlarmLevel;
			INT8S RecoveryLvl 	= mFwdLowAlm[i].AlarmRecovery;
			mFwdLowAlm[i].cAlarm	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}

	}
//////////////////////
	if (((tDnrSts->FwdAmpOnOff_2G == Disable)&&(tDnrSts->AmpOffCase_2G == __UsrCtrl))
		||(Sd_Step[SD_FO_2G] > 1))
	{
		mFwdLowAlm[PATH_2G].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_2G].FwdLowMask = SET;


	if (((tDnrSts->FwdAmpOnOff_LTE == Disable)&&(tDnrSts->AmpOffCase_LTE== __UsrCtrl))
		||(Sd_Step[SD_FO_LTE] > 1))
	{
		mFwdLowAlm[PATH_LTE].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_LTE].FwdLowMask = SET;

	if (((tDnrSts->FwdAmpOnOff_LTE_A2 == Disable)&&(tDnrSts->AmpOffCase_LTE_A2 == __UsrCtrl))
		||(Sd_Step[SD_FO_LTE_A2 ] > 1))
	{
		mFwdLowAlm[PATH_LTEA].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_LTEA].FwdLowMask = SET;
	
	if (((tDnrSts->FwdAmpOnOff_3G == Disable)&&(tDnrSts->AmpOffCase_3G == __UsrCtrl))
		||(Sd_Step[SD_FO_3G] > 1))
	{
		mFwdLowAlm[PATH_3G].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_3G].FwdLowMask = SET;

	{
		INT8U i;
		
		for(i = 0; i < SysPathMax; i++)
		{
			if(mFwdLowAlm[i].FwdLowMask)
			{
				if( mFwdLowAlm[i].cAlarm == Alarm)
				{
					if(++mFwdLowAlm[i].AlarmCnt >= AlarmCheckTime)
					{
						mFwdLowAlm[i].IsItAlarm = SET;
						mFwdLowAlm[i].AlarmCnt = AlarmCheckTime;
					}	
				}
				else
				{
					mFwdLowAlm[i].IsItAlarm = RESET;
					mFwdLowAlm[i].AlarmCnt = 0;
				}
			}
			else
			{
				mFwdLowAlm[i].IsItAlarm = RESET;
				mFwdLowAlm[i].AlarmCnt = 0;
			}
		}
	}
	Sts->AlmSts.FwdOutLowerLmtFail_2G = Normal;
	if(mFwdLowAlm[PATH_2G].cAlarm == Alarm) Sts->AlmSts.FwdOutLowerLmtFail_2G = Alarm;
	PwrAlarm.FwdOutLowerLmtFail_2G = mFwdLowAlm[PATH_2G].IsItAlarm;

	Sts->AlmSts.FwdOutLowerLmtFail_LTE = Normal;
	if(mFwdLowAlm[PATH_LTE].cAlarm == Alarm)	Sts->AlmSts.FwdOutLowerLmtFail_LTE= Alarm;
	PwrAlarm.FwdOutLowerLmtFail_LTE = mFwdLowAlm[PATH_LTE].IsItAlarm;

	Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2 = Normal;
	if(mFwdLowAlm[PATH_LTEA].cAlarm == Alarm)	Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2 = Alarm;
	PwrAlarm.FwdOutLowerLmtFail_LTE_A2 = mFwdLowAlm[PATH_LTEA].IsItAlarm;

	Sts->AlmSts.FwdOutLowerLmtFail_3G = Normal;
	if(mFwdLowAlm[PATH_3G].cAlarm == Alarm)	Sts->AlmSts.FwdOutLowerLmtFail_3G = Alarm;
	PwrAlarm.FwdOutLowerLmtFail_3G = mFwdLowAlm[PATH_3G].IsItAlarm;
////////////////
	// Rvs Upper Limit
	{
		INT8U i = 0;

		mRvsHighAlm[PATH_2G].Level			= RetPower(Sts->RvsOutPwr_2G);
		mRvsHighAlm[PATH_2G].AlarmLevel 	= RetPower(Sts->RvsOutUpperLmt_2G);
		mRvsHighAlm[PATH_2G].AlarmRecovery	= mRvsHighAlm[PATH_2G].AlarmLevel - 2;

		mRvsHighAlm[PATH_LTE].Level 		= RetPower(Sts->RvsOutPwr_LTE);
		mRvsHighAlm[PATH_LTE].AlarmLevel	= RetPower(Sts->RvsOutUpperLmt_LTE);
		mRvsHighAlm[PATH_LTE].AlarmRecovery = mRvsHighAlm[PATH_LTE].AlarmLevel - 2;

		mRvsHighAlm[PATH_LTEA].Level		 = RetPower(Sts->RvsOutPwr_LTE_A2);
		mRvsHighAlm[PATH_LTEA].AlarmLevel	 = RetPower(Sts->RvsOutUpperLmt_LTE_A2);
		mRvsHighAlm[PATH_LTEA].AlarmRecovery = mRvsHighAlm[PATH_LTEA].AlarmLevel - 2;

		mRvsHighAlm[PATH_3G].Level			= RetPower(Sts->RvsOutPwr_3G);
		mRvsHighAlm[PATH_3G].AlarmLevel 	= RetPower(Sts->RvsOutUpperLmt_3G);
		mRvsHighAlm[PATH_3G].AlarmRecovery	= mRvsHighAlm[PATH_3G].AlarmLevel - 2;


		for(i = 0; i < SysPathMax; i++)
		{
			INT8S DetLvl		= mRvsHighAlm[i].Level;
			INT8S LimitLvl		= mRvsHighAlm[i].AlarmLevel;
			INT8S RecoveryLvl	= mRvsHighAlm[i].AlarmRecovery;

			mRvsHighAlm[i].cAlarm	= HighLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}

		Sts->AlmSts.RvsOutUpperLmtFail_2G = Normal;
		if(mRvsHighAlm[PATH_2G].cAlarm == Alarm)	Sts->AlmSts.RvsOutUpperLmtFail_2G = Alarm;
		if(Sd_Step[SD_RO_2G] != 0)					Sts->AlmSts.RvsOutUpperLmtFail_2G = Alarm;

		Sts->AlmSts.RvsOutUpperLmtFail_LTE = Normal;
		if(mRvsHighAlm[PATH_LTE].cAlarm == Alarm)	Sts->AlmSts.RvsOutUpperLmtFail_LTE= Alarm;
		if(Sd_Step[SD_RO_LTE] != 0) 				Sts->AlmSts.RvsOutUpperLmtFail_LTE = Alarm;


		Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2 = Normal;
		if(mRvsHighAlm[PATH_LTEA].cAlarm == Alarm)	Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2= Alarm;
		if(Sd_Step[SD_RO_LTE_A2] != 0)				Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2 = Alarm;


		Sts->AlmSts.RvsOutUpperLmtFail_3G = Normal;
		if(mRvsHighAlm[PATH_3G].cAlarm == Alarm)	Sts->AlmSts.RvsOutUpperLmtFail_3G = Alarm;
		if(Sd_Step[SD_RO_3G] != 0)					Sts->AlmSts.RvsOutUpperLmtFail_3G = Alarm;
	}

	// Over In Alarm 
	{
		INT8U i = 0;

		mFwdInHighAlm[PATH_2G].Level			= -(Sts->FwdInPwr_2G*1);
		mFwdInHighAlm[PATH_2G].AlarmLevel 		= FwdOverInAlmLmt_2G;		// 과입력 Alarm  '-24±2dBm~-11±2dBm
		mFwdInHighAlm[PATH_2G].AlarmRecovery	= mFwdInHighAlm[PATH_2G].AlarmLevel - 2;

		mFwdInHighAlm[PATH_LTE].Level			= -(Sts->FwdInPwr_LTE*1);
		if(tDnrSts->LTE15MUse == __NOTUSE)
		{
//			mFwdInHighAlm[PATH_LTEA].Level	= FwdOverInAlmLmt_LTE;			// 과입력 Alarm  -21±2dBm~-8±2dBm
			mFwdInHighAlm[PATH_LTE].AlarmLevel	= FwdOverInAlmLmt_LTE;		// 과입력 Alarm  -21±2dBm~-8±2dBm
		}
		else
		{
//			mFwdInHighAlm[PATH_LTEA].Level	= FwdOverInAlmLmt_LTE15M;		// 과입력 Alarm  -19±2dBm~-8±2dBm
			mFwdInHighAlm[PATH_LTE].AlarmLevel	= FwdOverInAlmLmt_LTE15M;	// 과입력 Alarm  -19±2dBm~-8±2dBm
		}
		mFwdInHighAlm[PATH_LTE].AlarmRecovery	= mFwdInHighAlm[PATH_LTE].AlarmLevel - 2;


		mFwdInHighAlm[PATH_LTEA].Level			= -(Sts->FwdInPwr_LTE_A2*1);
		mFwdInHighAlm[PATH_LTEA].AlarmLevel		= Sts->OverInAlarmLmt_LTE_A2/2;	//	-15
		mFwdInHighAlm[PATH_LTEA].AlarmRecovery	= mFwdInHighAlm[PATH_LTEA].AlarmLevel - 2;

		mFwdInHighAlm[PATH_3G].Level			= -(Sts->FwdInPwr_3G*1);
		mFwdInHighAlm[PATH_3G].AlarmLevel 		= Sts->OverInAlarmLmt_3G/2; //-36*2  //	-19
		mFwdInHighAlm[PATH_3G].AlarmRecovery	= mFwdInHighAlm[PATH_3G].AlarmLevel - 2;


		for(i = 0; i < SysPathMax; i++)
		{
			INT8S DetLvl		= mFwdInHighAlm[i].Level;
			INT8S LimitLvl		= mFwdInHighAlm[i].AlarmLevel;
			INT8S RecoveryLvl	= mFwdInHighAlm[i].AlarmRecovery;
//			mFwdInHighAlm[i].cAlarm = 0;
#if 1
			if(i == PATH_LTE)
			{
//				if(FSKDebug)USART1Printf("0 : mFwdInHighAlm[%d][%d][%d]\n",DetLvl,LimitLvl,RecoveryLvl);
			}
#endif

			mFwdInHighAlm[i].cAlarm	= HighLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			if(i == PATH_LTE)
			{
//				if(FSKDebug)USART1Printf("1 : mFwdInHighAlm[%d][%d][%d][%d]\n",DetLvl,LimitLvl,RecoveryLvl,mFwdInHighAlm[i].cAlarm);
			}

		}

		Sts->AlmSts.FwdInUpperLmtFail_2G = Normal;
		if(mFwdInHighAlm[PATH_2G].cAlarm == Alarm)	Sts->AlmSts.FwdInUpperLmtFail_2G = Alarm;
		if(Sd_Step[SD_FI_2G] != 0)					Sts->AlmSts.FwdInUpperLmtFail_2G = Alarm;

		Sts->AlmSts.FwdInUpperLmtFail_LTE = Normal;
		if(mFwdInHighAlm[PATH_LTE].cAlarm == Alarm)	Sts->AlmSts.FwdInUpperLmtFail_LTE= Alarm;
		if(Sd_Step[SD_FI_LTE] != 0) 				Sts->AlmSts.FwdInUpperLmtFail_LTE = Alarm;


		Sts->AlmSts.FwdInUpperLmtFail_LTE_A2 = Normal;
		if(mFwdInHighAlm[PATH_LTEA].cAlarm == Alarm)	Sts->AlmSts.FwdInUpperLmtFail_LTE_A2= Alarm;
		if(Sd_Step[SD_FI_LTE_A2] != 0)					Sts->AlmSts.FwdInUpperLmtFail_LTE_A2 = Alarm;
//		if(Sd_Step[SD_FI_LTE] != 0)						Sts->AlmSts.FwdInUpperLmtFail_LTE_A2 = Alarm; /// 오류 

		Sts->AlmSts.FwdInUpperLmtFail_3G = Normal;
		if(mFwdInHighAlm[PATH_3G].cAlarm == Alarm)	Sts->AlmSts.FwdInUpperLmtFail_3G = Alarm;
		if(Sd_Step[SD_FI_3G] != 0)					Sts->AlmSts.FwdInUpperLmtFail_3G = Alarm;
	}

	if(AlarmCheck_2G != SET)
	{
		Sts->AlmSts.FwdOutUpperLmtFail_2G	= Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_2G	= Normal;
		Sts->AlmSts.FwdInUpperLmtFail_2G	= Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_2G	= Normal;

	}

	if(AlarmCheck_LTE != SET)
	{
		Sts->AlmSts.FwdOutUpperLmtFail_LTE = Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_LTE = Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_LTE = Normal;
		Sts->AlmSts.FwdInUpperLmtFail_LTE = Normal;
	}

	if(AlarmCheck_LTE_A2 != SET)
	{
		Sts->AlmSts.LocalFail_LTE_A2			= Normal;
		Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.FwdInUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2	= Normal;
	}



	//////////////////CDMA LTE
	
//	if(Sts->LTE15MUse == __NOTUSE)
	{
		// CDMA 타사 Over InAlarm 
		if(AlarmCheck_2G == SET)
		{
			INT8S DetLvl 		= Sts->DetPwr.FwdInPwr_CDMALTE + 25;
			INT8S LimitLvl 		= Sts->FwdInPwr_2G;
			INT8S RecoveryLvl 	= LimitLvl + 1;

//			if((Sts->AlmSts.FwdAmpOnOff_2G == Enable)&&( Sts->DetPwr.FwdOutAvgPwr_2G  > 0))
			if((Sts->AlmSts.FwdAmpOnOff_2G == Enable)&&( Sts->FwdOutPwr_2G[0] > Sts->FwdOutLowerLmt_2G[0]))
			{
				CurrAlarm.OverInAlarm_CDMALTE_1	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			}
		}
		else
		{
			CurrAlarm.OverInAlarm_CDMALTE_1 = Normal;
		}
			
		
		if(AlarmCheck_LTE == SET)
		{
			INT8S DetLvl 		= Sts->DetPwr.FwdInPwr_CDMALTE + 25;
			INT8S LimitLvl 		= Sts->FwdInPwr_LTE;
			INT8S RecoveryLvl 	= LimitLvl + 1;

//			if((Sts->AlmSts.FwdAmpOnOff_LTE == Enable)&&( Sts->DetPwr.FwdOutAvgPwr_LTE > 0))
			if((Sts->AlmSts.FwdAmpOnOff_LTE == Enable)&&( Sts->FwdOutPwr_LTE[0] > Sts->FwdOutLowerLmt_LTE[0]))
			{
				CurrAlarm.OverInAlarm_CDMALTE_2	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			}
			else
			{
				CurrAlarm.OverInAlarm_CDMALTE_2 = Normal;
			}
		}
		else
		{
			CurrAlarm.OverInAlarm_CDMALTE_2 = Normal;
		}

		if((AlarmCheck_2G == SET)&&(AlarmCheck_LTE == SET))
		{
			#if 0
			INT8S DetLvl = Sts->DetPwr.FwdInPwr_CDMALTE + 4;
			INT8S LimitLvl;
			INT8S RecoveryLvl;

			if(Sts->FwdInPwr_2G >= Sts->FwdInPwr_LTE)		LimitLvl = Sts->FwdInPwr_LTE;
			else if(Sts->FwdInPwr_2G < Sts->FwdInPwr_LTE)	LimitLvl = Sts->FwdInPwr_2G;
			RecoveryLvl = LimitLvl + 1;
			CurrAlarm.OverInAlarm_CDMALTE_3 = LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			#endif

			INT8S LimitLvl;
			INT8S DetLvl;
			
			if(Sts->FwdInPwr_2G >= Sts->FwdInPwr_LTE)		
			{
				LimitLvl = Sts->FwdInPwr_LTE;
				DetLvl	 = Sts->FwdInPwr_2G - 25;

//				SerPtr->printf("0: LimitLvl,DetLvl[%d][%d]\n", LimitLvl,DetLvl);
			}
			else if(Sts->FwdInPwr_2G < Sts->FwdInPwr_LTE)	
			{
				LimitLvl = Sts->FwdInPwr_2G;
				DetLvl	 = Sts->FwdInPwr_LTE - 25;
				
//				SerPtr->printf("1: LimitLvl,DetLvl[%d][%d]\n", LimitLvl,DetLvl);
			}
			CurrAlarm.OverInAlarm_CDMALTE_3 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_CDMALTE_3);	//2dB 
		}

		#if 0
		if(Sts->LTE15MUse == __NOTUSE)
		{
			if((CurrAlarm.OverInAlarm_CDMALTE_1)||(CurrAlarm.OverInAlarm_CDMALTE_2))
			{
				Sts->AlmSts.OverInAlarm_CDMALTE = Alarm;
			}
			else Sts->AlmSts.OverInAlarm_CDMALTE = Normal;
		}
		else
		{
			Sts->AlmSts.OverInAlarm_CDMALTE = CurrAlarm.OverInAlarm_CDMALTE_2;
		}
		#endif

		if(Sts->LTE15MUse == __NOTUSE)
		{
			if((CurrAlarm.OverInAlarm_CDMALTE_1)||(CurrAlarm.OverInAlarm_CDMALTE_2))
			{
				if(CurrAlarm.OverInAlarm_CDMALTE_3)
				{
					Sts->AlmSts.OverInAlarm_CDMALTE = Alarm;
				}
				else Sts->AlmSts.OverInAlarm_CDMALTE = Normal;
			}
			else Sts->AlmSts.OverInAlarm_CDMALTE = Normal;
			
		}
		else
		{
			Sts->AlmSts.OverInAlarm_CDMALTE = CurrAlarm.OverInAlarm_CDMALTE_2;
		}		
	}

	{
		// LTE_A1 타사 Over InAlarm 
		if(AlarmCheck_LTE_A2 == SET)
		{
			INT8S DetLvl 		= Sts->DetPwr.FwdInPwr_LTE_A + 25;
			INT8S LimitLvl 		= Sts->FwdInPwr_LTE_A2;
			INT8S RecoveryLvl 	= LimitLvl + 1;

			if((Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Enable)&&( Sts->DetPwr.FwdOutPeakPwr_LTE_A2 > 0))
			{
				Sts->AlmSts.OverInAlarm_LTE_A = LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			}
			else
			{
				Sts->AlmSts.OverInAlarm_LTE_A = Normal;
			}
		}
		else	Sts->AlmSts.OverInAlarm_LTE_A = Normal;

	}
	
	{
		// WCDMA 타사 Over InAlarm 
		INT8S DetLvl		= Sts->DetPwr.FwdInPwr_3G + 25;
		INT8S LimitLvl		= Sts->FwdInPwr_3G;
		INT8S RecoveryLvl	= LimitLvl + 1;

		DetLvl		= Sts->DetPwr.FwdInPwr_3G + 25;
		LimitLvl	= Sts->FwdInPwr_3G;
		if((Sts->AlmSts.FwdAmpOnOff_3G == Enable)&&( Sts->DetPwr.FwdOutAvgPwr_3G  > 0))
		{
			Sts->AlmSts.OverInAlarm_3G = LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}
		else  Sts->AlmSts.OverInAlarm_3G = Normal;
	}
	
	
	#if 1
	if(Sts->AlmSts.FwdAmpOnOff_LTE == Enable)
	{
		if((Sts->CurrRvsInPwr_LTE <= 33)&&(Sts->RvsOutPwr_LTE[0] > 0))
		{
			Sts->ModuleAlarm.Main.RvsOverInAlarm = Alarm;
 		}
		else							
		{
			Sts->ModuleAlarm.Main.RvsOverInAlarm = Normal;
			ChkRvsOverInAlarm = SET;
			RvsOverInAlarmCnt = 0;
		}

		if ( Sts->DetPwr.RvsInPwr_CDMALTE <= 33)
		{
			// CDMA Over InAlarm 

			INT32S gap;
			gap = Sts->DetPwr.RvsInPwr_CDMALTE - Sts->CurrRvsInPwr_LTE;

//			if(FSKDebug)SerPtr->printf("0: tmppwr[%d][%d]>[%d]:[%d][%d]:[%d][%d]\n", Sts->DetPwr.RvsInPwr_CDMALTE,Sts->CurrRvsInPwr_LTE,gap,Sts->ModuleAlarm.Main.RvsOverInAlarm,Sts->ModuleAlarm.Main.RvsOtherOverInAlarm,Sts->RvsOverInAlarmCount,Sts->RvsOtherOverInAlarmCount);

			if(Sts->DetPwr.RvsInPwr_CDMALTE <= Sts->CurrRvsInPwr_LTE )
			{
				if(abs(gap) <= 3)
				{
					Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
					ChkRvsOtherOverInAlarm = SET;
					RvsOtherOverInAlarmCnt = 0;
				}
				else
				{
					Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Alarm;
				}
			}
			else
			{
				Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Alarm;
			}
		}
		else if( Sts->DetPwr.RvsInPwr_CDMALTE >= 34)
		{
			Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
			ChkRvsOtherOverInAlarm = SET;
			RvsOtherOverInAlarmCnt = 0;
		}
		else
		{
		}
	}
	else 
	{
		Sts->ModuleAlarm.Main.RvsOverInAlarm = Normal;
		Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
	}
	#endif

	#if 1
	if(Sts->AlmSts.FwdAmpOnOff_LTE == Enable)
	{
		///LTE800 Uplink 자/타사 과입력 Alarm Count
		{
			if((Sts->CurrRvsInPwr_LTE < 35))
			{
				if(Sts->CurrRvsInPwr_LTE >= Sts->DetPwr.RvsInPwr_CDMALTE + 25)		
				{
					Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Alarm; ///타사 
				}
				else
				{
					if((Sts->CurrRvsInPwr_LTE <= 33)&&(Sts->RvsOutPwr_LTE[0] > 0))
					{
						Sts->ModuleAlarm.Main.RvsOverInAlarm = Alarm;  ///자사 
					}
					else							
					{
						Sts->ModuleAlarm.Main.RvsOverInAlarm = Normal;
						ChkRvsOverInAlarm = SET;
						RvsOverInAlarmCnt = 0;
					}
				}
			}
		}

		if ( Sts->DetPwr.RvsInPwr_CDMALTE <= 33)
		{
			// CDMA Over InAlarm 

			INT32S gap;
			gap = Sts->DetPwr.RvsInPwr_CDMALTE - Sts->CurrRvsInPwr_LTE;
			if(Sts->DetPwr.RvsInPwr_CDMALTE < Sts->CurrRvsInPwr_LTE )
			{
				if(abs(gap) <= 3)
				{
					Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
					Sts->ModuleAlarm.Main.RvsOverInAlarm = Alarm;
				}
				else
				{
					Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Alarm; ///타사 
				}
			}
			else							
			{
				Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Alarm;
			}
		}
		else
		{
			Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
			ChkRvsOtherOverInAlarm = SET;
			RvsOtherOverInAlarmCnt = 0;
		}
	}
	else 
	{
		Sts->ModuleAlarm.Main.RvsOverInAlarm = Normal;
		Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
	}
	#endif

	if (Sts->ModuleAlarm.Main.RvsOverInAlarm ) RvsOverInAlarmCnt = RvsOverInAlarmCnt + 1;

	if((RvsOverInAlarmCnt > 6) && ( ChkRvsOverInAlarm)) ////4
	{
		Sts->RvsOverInAlarmCount = Sts->RvsOverInAlarmCount + 1 ;
		ChkRvsOverInAlarm = RESET;
	}
	if( Sts->RvsOverInAlarmCount > 127) Sts->RvsOverInAlarmCount = 1;

	if (Sts->ModuleAlarm.Main.RvsOtherOverInAlarm ) RvsOtherOverInAlarmCnt = RvsOtherOverInAlarmCnt + 1;

	if((RvsOtherOverInAlarmCnt > 8) && ( ChkRvsOtherOverInAlarm)) ////6
	{
		Sts->RvsOtherOverInAlarmCount  = Sts->RvsOtherOverInAlarmCount  + 1 ;
		ChkRvsOtherOverInAlarm = RESET;
	}
	if( Sts->RvsOtherOverInAlarmCount > 127) Sts->RvsOtherOverInAlarmCount = 1;


	if((Sts->AlmSts.FwdOutUpperLmtFail_3G )||(Sts->AlmSts.FwdInUpperLmtFail_3G))
	{
		Sts->LedAlarm._LED_3G.OverInAlarm = Alarm;
	}
	else
	{
		Sts->LedAlarm._LED_3G.OverInAlarm = Normal;
	}

	Sts->LedAlarm._LED_3G.RvsOscAlarm 		= Sts->AlmSts.RvsOutUpperLmtFail_3G;
	Sts->LedAlarm._LED_3G.LowInputAlarm 	= Sts->AlmSts.FwdOutLowerLmtFail_3G;
	Sts->LedAlarm._LED_3G.PllUnlock 		= Sts->AlmSts.LocalFail_3G;
	Sts->LedAlarm._LED_3G.ShutDown 			= Sts->AlmSts.FwdAmpOnOff_3G;

	if(AlarmCheck_2G == SET)
	{
		if((Sts->AlmSts.FwdOutUpperLmtFail_2G)||(Sts->AlmSts.FwdInUpperLmtFail_2G))
		{
			Sts->LedAlarm._LED_2G.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_2G.OverInAlarm = Normal;
		}
		
		Sts->LedAlarm._LED_2G.RvsOscAlarm		= Sts->AlmSts.RvsOutUpperLmtFail_2G;
		Sts->LedAlarm._LED_2G.LowInputAlarm 	= Sts->AlmSts.FwdOutLowerLmtFail_2G;
		Sts->LedAlarm._LED_2G.PllUnlock 		= Sts->AlmSts.LocalFail_CDMALTE;
		Sts->LedAlarm._LED_2G.ShutDown			= Sts->AlmSts.FwdAmpOnOff_2G;
	}


	if(AlarmCheck_LTE == SET)
	{
		if((Sts->AlmSts.FwdOutUpperLmtFail_LTE)||(Sts->AlmSts.FwdInUpperLmtFail_LTE))
		{
			Sts->LedAlarm._LED_LTE.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_LTE.OverInAlarm = Normal;
		}
		
		Sts->LedAlarm._LED_LTE.RvsOscAlarm		= Sts->AlmSts.RvsOutUpperLmtFail_LTE;
		Sts->LedAlarm._LED_LTE.LowInputAlarm	= Sts->AlmSts.FwdOutLowerLmtFail_LTE;
		Sts->LedAlarm._LED_LTE.PllUnlock		= Sts->AlmSts.LocalFail_CDMALTE;
		Sts->LedAlarm._LED_LTE.ShutDown 		= Sts->AlmSts.FwdAmpOnOff_LTE;
	}


	if(AlarmCheck_LTE_A2 == SET)
	{
		if((Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2)||(Sts->AlmSts.FwdInUpperLmtFail_LTE_A2))
		{
			Sts->LedAlarm._LED_LTE_A2.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_LTE_A2.OverInAlarm = Normal;
		}
		
		Sts->LedAlarm._LED_LTE_A2.RvsOscAlarm	= Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2;
		Sts->LedAlarm._LED_LTE_A2.LowInputAlarm = Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2;
		Sts->LedAlarm._LED_LTE_A2.PllUnlock 	= Sts->AlmSts.LocalFail_LTE_A2;
		Sts->LedAlarm._LED_LTE_A2.ShutDown		= Sts->AlmSts.FwdAmpOnOff_LTE_A2;
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
				AttnBufferInit();
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
				AttnBufferInit();
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
				AttnBufferInit();
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
				AttnBufferInit();
			}
		}
	}	
}

void StatusUpdate(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	if(!Sts->TPTL_OnOff)
	{
		INT8S tindex = 0;
		// Hysterisys !!
			 if(Sts->CurrentTemp >= tempIndexHys)		tempIndexHys = Sts->CurrentTemp;
		else if(Sts->CurrentTemp < (tempIndexHys - 1))	tempIndexHys = Sts->CurrentTemp;

		tindex = TemptoIndex(tempIndexHys);
		Sts->FwdTemp_2G 	= AttnTempTable->FwdTempAttn_2G.Data[tindex];
		Sts->RvsTemp_2G 	= AttnTempTable->RvsTempAttn_2G.Data[tindex];
		Sts->FwdTemp_LTE	= AttnTempTable->FwdTempAttn_LTE.Data[tindex];
		Sts->RvsTemp_LTE	= AttnTempTable->RvsTempAttn_LTE.Data[tindex];
		Sts->FwdTemp_LTE_A2 = AttnTempTable->FwdTempAttn_LTE_A2.Data[tindex];
		Sts->RvsTemp_LTE_A2 = AttnTempTable->RvsTempAttn_LTE_A2.Data[tindex];
		Sts->FwdTemp_3G 	= AttnTempTable->FwdTempAttn_3G.Data[tindex];
		Sts->RvsTemp_3G 	= AttnTempTable->RvsTempAttn_3G.Data[tindex];
	}
	else
	{
		Sts->FwdTemp_2G 		= 0;
		Sts->RvsTemp_2G 		= 0;
		Sts->FwdTemp_3G 		= 0;
		Sts->RvsTemp_3G 		= 0;
		Sts->FwdTemp_LTE		= 0;
		Sts->RvsTemp_LTE		= 0;
		Sts->FwdTemp_LTE_A2 	= 0;
		Sts->RvsTemp_LTE_A2 	= 0;
	}


}


void AlarmStatusUpdate(void)
{
	__Dnr_Sts *Sts = tDnrSts;


	PwrAlarm.ACFail						= Sts->AlmSts.ACFail;

	if(AlarmCheck_2G == SET)
	{
		PwrAlarm.FwdInUpperLmtFail_2G	= Sts->AlmSts.FwdInUpperLmtFail_2G;	
		if(Sd_Step[SD_FO_2G] >= 3) 	PwrAlarm.FwdOutUpperLmtFail_2G	= Sts->AlmSts.FwdOutUpperLmtFail_2G;
		else						PwrAlarm.FwdOutUpperLmtFail_2G  = 0;
		if(Sd_Step[SD_RO_2G] >= 3)  PwrAlarm.RvsOutUpperLmtFail_2G	= Sts->AlmSts.RvsOutUpperLmtFail_2G;	
		else						PwrAlarm.RvsOutUpperLmtFail_2G  = 0;
	}
	
	if(AlarmCheck_LTE == SET)
	{
		PwrAlarm.FwdInUpperLmtFail_LTE		= Sts->AlmSts.FwdInUpperLmtFail_LTE;	
		if(Sd_Step[SD_FO_LTE] >= 3)	PwrAlarm.FwdOutUpperLmtFail_LTE	 = Sts->AlmSts.FwdOutUpperLmtFail_LTE;		
		else						PwrAlarm.FwdOutUpperLmtFail_LTE  = 0;

		if(Sd_Step[SD_RO_LTE] >= 3)	PwrAlarm.RvsOutUpperLmtFail_LTE	 = Sts->AlmSts.RvsOutUpperLmtFail_LTE;		
		else						PwrAlarm.RvsOutUpperLmtFail_LTE  = 0;
		PwrAlarm.LocalFail_CDMALTE			= Sts->AlmSts.LocalFail_CDMALTE;
	}

	if((AlarmCheck_2G == SET)||(AlarmCheck_LTE == SET))
	{
		PwrAlarm.OverInAlarm_CDMALTE		= Sts->AlmSts.OverInAlarm_CDMALTE;		
	}
	
	if(Sd_Step[SD_FI_3G] >= 3)	PwrAlarm.FwdInUpperLmtFail_3G  = Sts->AlmSts.FwdInUpperLmtFail_3G;	
	else						PwrAlarm.FwdInUpperLmtFail_3G  = 0;	
	
	if(Sd_Step[SD_FO_3G] >= 3)	PwrAlarm.FwdOutUpperLmtFail_3G	= Sts->AlmSts.FwdOutUpperLmtFail_3G;
	else						PwrAlarm.FwdOutUpperLmtFail_3G  = 0;

	if(Sd_Step[SD_RO_3G] >= 3)	PwrAlarm.RvsOutUpperLmtFail_3G	= Sts->AlmSts.RvsOutUpperLmtFail_3G;
	else						PwrAlarm.RvsOutUpperLmtFail_3G  = 0;


	PwrAlarm.OverInAlarm_3G				= Sts->AlmSts.OverInAlarm_3G;	
	PwrAlarm.LocalFail_3G				= Sts->AlmSts.LocalFail_3G;		

	if(AlarmCheck_LTE_A2 == SET)
	{
		if(Sd_Step[SD_FI_LTE_A2] >= 3) 	PwrAlarm.FwdInUpperLmtFail_LTE_A2	= Sts->AlmSts.FwdInUpperLmtFail_LTE_A2;
		else							PwrAlarm.FwdInUpperLmtFail_LTE_A2	= 0;

		if(Sd_Step[SD_FO_LTE_A2] >= 3) 	PwrAlarm.FwdOutUpperLmtFail_LTE_A2	= Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2;	
		else							PwrAlarm.FwdOutUpperLmtFail_LTE_A2	= 0;

		if(Sd_Step[SD_RO_LTE_A2] >= 3)	PwrAlarm.RvsOutUpperLmtFail_LTE_A2	= Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2;
		else							PwrAlarm.RvsOutUpperLmtFail_LTE_A2	= 0;

		PwrAlarm.LocalFail_LTE_A2			= Sts->AlmSts.LocalFail_LTE_A2;

//		if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
#if 0
		if((PwrAlarm.ACFail))
		{
		
		}
		else
		{
			PwrAlarm.FwdAmpOnOff_LTE_A2 	= Sts->AlmSts.FwdAmpOnOff_LTE_A2;
		}		
#endif		
	}
	
	if((AlarmCheck_LTE_A2 == SET))
	{
		PwrAlarm.OverInAlarm_LTE_A1			= Sts->AlmSts.OverInAlarm_LTE_A;
	}
		
//	if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
	if((PwrAlarm.ACFail))
	{

	}
	else
	{
#if 0
		PwrAlarm.FwdAmpOnOff_3G 		= Sts->AlmSts.FwdAmpOnOff_3G;
		PwrAlarm.FwdAmpOnOff_2G 		= Sts->AlmSts.FwdAmpOnOff_2G;
		PwrAlarm.FwdAmpOnOff_LTE		= Sts->AlmSts.FwdAmpOnOff_LTE;
		PwrAlarm.FwdAmpOnOff_LTE_A2		= Sts->AlmSts.FwdAmpOnOff_LTE_A2;
#endif

#if 1  ///20170519 Adder

		PwrAlarm.FwdAmpOnOff_3G 		= Sts->AlmSts.FwdAmpOnOff_3G;
		if(AlarmCheck_2G == SET)		PwrAlarm.FwdAmpOnOff_2G 		= Sts->AlmSts.FwdAmpOnOff_2G;
		if(AlarmCheck_LTE == SET)		PwrAlarm.FwdAmpOnOff_LTE		= Sts->AlmSts.FwdAmpOnOff_LTE;
		if(AlarmCheck_LTE_A2 == SET)	PwrAlarm.FwdAmpOnOff_LTE_A2 	= Sts->AlmSts.FwdAmpOnOff_LTE_A2;
#endif
		
	}
}


void StatustoIO(void)
{
    INT16S AttnTemp0 = 0;
	INT16S AttnTemp1 = 0;

	__Dnr_Sts  *Sts = tDnrSts;


	AttnTemp0 = Sts->FwdAttn1_2G + Sts->FwdGainOffset_2G + Sts->FwdTemp_2G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->FwdAttn1_2G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.FwdAttn1_2G = Sts->CurrFwdAttn1_2G = AttnTemp0 + AttnTemp1;
	
	if(CurrFwdAttn1_2G != Sts->CurrFwdAttn1_2G)
	{
		CurrFwdAttn1_2G = Sts->CurrFwdAttn1_2G;
		AttnDataOutput(_FwdAttn1_2G_SEL, Sts->CurrFwdAttn1_2G);

//		SerPtr->printf("CurrFwdAttn1_2G[%d]:[%d][%d]\n", CurrFwdAttn1_2G,AttnTemp0,AttnTemp1);

	}

	AttnTemp0 = Sts->RvsAttn1_2G + Sts->RvsTemp_2G + Sts->RvsGainOffset_2G + Sts->AttOffset.RvsAttn1_2G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn1_2G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn1_2G = Sts->CurrRvsAttn1_2G = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn1_2G != Sts->CurrRvsAttn1_2G)
	{
		CurrRvsAttn1_2G = Sts->CurrRvsAttn1_2G;
		AttnDataOutput(_RvsAttn1_2G_SEL, Sts->CurrRvsAttn1_2G);
//		SerPtr->printf("CurrRvsAttn1_2G[%d]\n", CurrRvsAttn1_2G);
	}


	AttnTemp0 = Sts->RvsAttn2_2G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn2_2G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn2_2G = Sts->CurrRvsAttn2_2G = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn2_2G != Sts->CurrRvsAttn2_2G)
	{
		CurrRvsAttn2_2G = Sts->CurrRvsAttn2_2G;
		AttnDataOutput(_RvsAttn2_2G_SEL, Sts->CurrRvsAttn2_2G);
	}


	AttnTemp0 = Sts->RvsAttn3_2G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn3_2G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn3_2G = Sts->CurrRvsAttn3_2G = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn3_2G != Sts->CurrRvsAttn3_2G)
	{
		CurrRvsAttn3_2G = Sts->CurrRvsAttn3_2G;
		AttnDataOutput(_RvsAttn3_2G_SEL, Sts->CurrRvsAttn3_2G);
	}

/////////////////////////////////////////////////////////// LTE Fwd
	AttnTemp0 = Sts->FwdAttn1_LTE + Sts->FwdGainOffset_LTE + Sts->FwdTemp_LTE;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->FwdAttn1_LTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.FwdAttn1_LTE = Sts->CurrFwdAttn1_LTE = AttnTemp0 + AttnTemp1;
	if(CurrFwdAttn1_LTE!= Sts->CurrFwdAttn1_LTE)
	{
		CurrFwdAttn1_LTE= Sts->CurrFwdAttn1_LTE;
		AttnDataOutput(_FwdAttn1_LTE_SEL, Sts->CurrFwdAttn1_LTE);
	}


	AttnTemp0 = Sts->RvsAttn1_LTE + Sts->RvsTemp_LTE + Sts->RvsGainOffset_LTE;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn1_LTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn1_LTE = Sts->CurrRvsAttn1_LTE = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn1_LTE != Sts->CurrRvsAttn1_LTE)
	{
		CurrRvsAttn1_LTE = Sts->CurrRvsAttn1_LTE;
		AttnDataOutput(_RvsAttn1_LTE_SEL, Sts->CurrRvsAttn1_LTE);
	}

	AttnTemp0 = Sts->RvsAttn2_LTE; 
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn2_LTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn2_LTE = Sts->CurrRvsAttn2_LTE = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn2_LTE != Sts->CurrRvsAttn2_LTE)
	{
		CurrRvsAttn2_LTE = Sts->CurrRvsAttn2_LTE;
		AttnDataOutput(_RvsAttn2_LTE_SEL, Sts->CurrRvsAttn2_LTE);
	}
	AttnTemp0 = Sts->RvsAttn3_LTE;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn3_LTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn3_LTE = Sts->CurrRvsAttn3_LTE = AttnTemp0 + AttnTemp1;
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;

	if(CurrRvsAttn3_LTE != Sts->CurrRvsAttn3_LTE)
	{
		CurrRvsAttn3_LTE = Sts->CurrRvsAttn3_LTE;
		AttnDataOutput(_RvsAttn3_LTE_SEL, Sts->CurrRvsAttn3_LTE);
	}

/////////////////////////////////////////////////////////// CDMA/LTE
	AttnTemp0 = Sts->FwdAttn1_CDMALTE;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX_2G,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->FwdAttn1_CDMALTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	AttnTemp1 = MinMaxAttnCheck(AttnTemp1, DIGATTENMAX_2G,ATTENMIN);

	Sts->AttValue.FwdAttn1_CDMALTE = Sts->CurrFwdAttn1_CDMALTE = AttnTemp0 + AttnTemp1;
	if(CurrFwdAttn1_CDMALTE!= Sts->CurrFwdAttn1_CDMALTE)
	{
		CurrFwdAttn1_CDMALTE = Sts->CurrFwdAttn1_CDMALTE;
		AttnDataOutput(_FwdAttn1_Common_SEL, Sts->CurrFwdAttn1_CDMALTE);
	}
	
	AttnTemp0 = Sts->RvsAttn1_CDMALTE;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn1_CDMALTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn1_CDMALTE = Sts->CurrRvsAttn1_CDMALTE = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn1_CDMALTE!= Sts->CurrRvsAttn1_CDMALTE)
	{
		CurrRvsAttn1_CDMALTE = Sts->CurrRvsAttn1_CDMALTE;
		AttnDataOutput(_RvsAttn1_Common_SEL, Sts->CurrRvsAttn1_CDMALTE);
	}

/////////////////////////////////////////////////////////// LTE-A2
	AttnTemp0 = Sts->FwdAttn1_LTE_A2;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->FwdAttn1_LTE_A2.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.FwdAttn1_LTE_A2 = Sts->CurrFwdAttn1_LTE_A2 = AttnTemp0 + AttnTemp1;
	if(CurrFwdAttn1_LTE_A2!= Sts->CurrFwdAttn1_LTE_A2)
	{
		CurrFwdAttn1_LTE_A2 = Sts->CurrFwdAttn1_LTE_A2;
		AttnDataOutput(_FwdAttn1_LTE_A2_SEL, Sts->CurrFwdAttn1_LTE_A2);
	}

	AttnTemp0 = Sts->FwdAttn2_LTE_A2 + Sts->FwdGainOffset_LTE_A2 + Sts->FwdTemp_LTE_A2;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->FwdAttn2_LTE_A2.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.FwdAttn2_LTE_A2 = Sts->CurrFwdAttn2_LTE_A2 = AttnTemp0 + AttnTemp1;
	if(CurrFwdAttn2_LTE_A2 != Sts->CurrFwdAttn2_LTE_A2)
	{
		CurrFwdAttn2_LTE_A2 = Sts->CurrFwdAttn2_LTE_A2;
		AttnDataOutput(_FwdAttn2_LTE_A2_SEL, Sts->CurrFwdAttn2_LTE_A2);
	}
	

	AttnTemp0 = Sts->RvsAttn1_LTE_A2;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn1_LTE_A2.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn1_LTE_A2 = Sts->CurrRvsAttn1_LTE_A2 = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn1_LTE_A2 != Sts->CurrRvsAttn1_LTE_A2)
	{
		CurrRvsAttn1_LTE_A2 = Sts->CurrRvsAttn1_LTE_A2;
		AttnDataOutput(_RvsAttn1_LTE_A2_SEL, Sts->CurrRvsAttn1_LTE_A2);
	}

	AttnTemp0 = Sts->RvsAttn2_LTE_A2 + Sts->RvsGainOffset_LTE_A2 + Sts->RvsTemp_LTE_A2;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn2_LTE_A2.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn2_LTE_A2 = Sts->CurrRvsAttn2_LTE_A2 = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn2_LTE_A2 != Sts->CurrRvsAttn2_LTE_A2)
	{
		CurrRvsAttn2_LTE_A2 = Sts->CurrRvsAttn2_LTE_A2;
		AttnDataOutput(_RvsAttn2_LTE_A2_SEL, Sts->CurrRvsAttn2_LTE_A2);
	}
	AttnTemp0 = Sts->RvsAttn3_LTE_A2;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn3_LTE_A2.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn3_LTE_A2 = Sts->CurrRvsAttn3_LTE_A2 = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn3_LTE_A2 != Sts->CurrRvsAttn3_LTE_A2)
	{
		CurrRvsAttn3_LTE_A2 = Sts->CurrRvsAttn3_LTE_A2;
		AttnDataOutput(_RvsAttn3_LTE_A2_SEL, Sts->CurrRvsAttn3_LTE_A2);
	}
	AttnTemp0 = Sts->RvsAttn4_LTE_A2;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn4_LTE_A2.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn4_LTE_A2 = Sts->CurrRvsAttn4_LTE_A2 = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn4_LTE_A2 != Sts->CurrRvsAttn4_LTE_A2)
	{
		CurrRvsAttn4_LTE_A2 = Sts->CurrRvsAttn4_LTE_A2;
		AttnDataOutput(_RvsAttn4_LTE_A2_SEL, Sts->CurrRvsAttn4_LTE_A2);
	}

	/////////////////////////////////////////////////////////// 3G
	AttnTemp0 = Sts->FwdAttn1_3G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->FwdAttn1_3G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.FwdAttn1_3G = Sts->CurrFwdAttn1_3G = AttnTemp0 + AttnTemp1;
	if(CurrFwdAttn1_3G!= Sts->CurrFwdAttn1_3G)
	{
		CurrFwdAttn1_3G = Sts->CurrFwdAttn1_3G;
		AttnDataOutput(_FwdAttn1_3G_SEL, Sts->CurrFwdAttn1_3G);
	}

	AttnTemp0 = Sts->FwdAttn2_3G + Sts->FwdGainOffset_3G + Sts->FwdTemp_3G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->FwdAttn2_3G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.FwdAttn2_3G = Sts->CurrFwdAttn2_3G = AttnTemp0 + AttnTemp1;
	if(CurrFwdAttn2_3G != Sts->CurrFwdAttn2_3G)
	{
		CurrFwdAttn2_3G = Sts->CurrFwdAttn2_3G;
		AttnDataOutput(_FwdAttn2_3G_SEL, Sts->CurrFwdAttn2_3G);
	}

	AttnTemp0 = Sts->RvsAttn1_3G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn1_3G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn1_3G = Sts->CurrRvsAttn1_3G = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn1_3G != Sts->CurrRvsAttn1_3G)
	{
		CurrRvsAttn1_3G = Sts->CurrRvsAttn1_3G;
		AttnDataOutput(_RvsAttn1_3G_SEL, Sts->CurrRvsAttn1_3G);
	}

	AttnTemp0 = Sts->RvsAttn2_3G + Sts->RvsGainOffset_3G + Sts->RvsTemp_3G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn2_3G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn2_3G = Sts->CurrRvsAttn2_3G = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn2_3G != Sts->CurrRvsAttn2_3G)
	{
		CurrRvsAttn2_3G = Sts->CurrRvsAttn2_3G;
		AttnDataOutput(_RvsAttn2_3G_SEL, Sts->CurrRvsAttn2_3G);
	}
	
	AttnTemp0 = Sts->RvsAttn3_3G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn3_3G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn3_3G = Sts->CurrRvsAttn3_3G = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn3_3G != Sts->CurrRvsAttn3_3G)
	{
		CurrRvsAttn3_3G = Sts->CurrRvsAttn3_3G;
		AttnDataOutput(_RvsAttn3_3G_SEL, Sts->CurrRvsAttn3_3G);
	}
	
	AttnTemp0 = Sts->RvsAttn4_3G;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	AttnTemp1 = AttnOffsetTable->RvsAttn4_3G.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = AttnTemp0;
	Sts->AttValue.RvsAttn4_3G = Sts->CurrRvsAttn4_3G = AttnTemp0 + AttnTemp1;
	if(CurrRvsAttn4_3G != Sts->CurrRvsAttn4_3G)
	{
		CurrRvsAttn4_3G = Sts->CurrRvsAttn4_3G;
		AttnDataOutput(_RvsAttn4_3G_SEL, Sts->CurrRvsAttn4_3G);
	}
////
	if(Chk_Reset)
	{
		ResetCaseBackup(UserReset);
		OSTimeDly(1000L);
		DownLoadBootingJump();
		Chk_Reset = RESET;
	}

	{
		if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
		{
			AmpOnOff_LTE_0 = 0;
			AmpOnOff_CDMA = 0;
			AmpOnOff_LTE_A2_0 = 0;
			AmpOnOff_WCDMA = 0;

			AmpBitReason(PATH_3G, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_2G, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTE, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTEA, _Disable, __DCAlarm, SD_AMP_OFF_INF);
		}
		else
		{
			if(Sts->LTE15MUse == __USE)
			{
				if(AlarmCheck_LTE == SET)
				{
					if(Sts->AlmSts.FwdAmpOnOff_LTE== Enable)
					{
						AmpOnOff_LTE_0 = 1;
						AmpOnOff_CDMA = 1;
					}
					else
					{
						AmpOnOff_LTE_0 = 0;
						AmpOnOff_CDMA = 0;
					}
				}
				else
				{
//					Sts->FwdAmpOnOff_LTE = Disable;
//					Sts->FwdAmpOnOff_2G = Disable;
					AmpOnOff_LTE_0 = 0;
					AmpOnOff_CDMA = 0;
				}
				
			}
			else
			{
				if(Sts->AlmSts.FwdAmpOnOff_2G == Enable)		
				{
					AmpOnOff_CDMA = 1;
				}
				else
				{
					AmpOnOff_CDMA = 0;
				}

				if(Sts->AlmSts.FwdAmpOnOff_LTE== Enable)		
				{
					AmpOnOff_LTE_0 = 1;
				}
				else
				{
					AmpOnOff_LTE_0 = 0;
				}
			}

			if(Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Enable)
			{
				AmpOnOff_LTE_A2_0 = 1;
			}
			else
			{
				AmpOnOff_LTE_A2_0 = 0;
			}
 

			if(Sts->AlmSts.FwdAmpOnOff_3G == Enable)		
			{
				AmpOnOff_WCDMA = 1;
			}
			else
			{
				AmpOnOff_WCDMA = 0;
			}
		}
	}

	if( CurrModemOnOff != Sts->ModemOnOff)
	{
		if(Sts->ModemOnOff == Enable)	
		{
			SMS_PWR = 0;
		}
		else
		{
			if(SetSMS_PWR == RESET)
			{
				SMS_PWR = 1;
			}
		}
	}
	
	if(ChkBandSelet)
	{
		INT32U tLocal = 0;

		if(Sts->Band_Select_LTE_A2[0] == __USE)
		{
			INT16U WordByte = 0;

			WordByte = Sts->Band_Select_LTE_A2[1]*128 + Sts->Band_Select_LTE_A2[2];
			tLocal = 1814000 + WordByte*25;

			iBand_Freq = tLocal - 240000;
			
			Pll411x_Output(iBand_Freq*1000, 0);
			OSTimeDly(50);
			Pll411x_Output(iBand_Freq*1000, 1);

			
//			SerPtr->printf("iBand_Freq[%d]\n", iBand_Freq);
		}

		ChkBandSelet = RESET;

		if(CurrLOFREQ_LTE != iBand_Freq )
		{
			CurrLOFREQ_LTE = iBand_Freq;
		}
	}

}

void AttnBufferInit(void)
{

//	CurrLOFREQ_4G = 0xffffffff;

	CurrLTE15MUse 			= 0xFF;
	CurrModemOnOff			= 0xFF;
	ChkBandSelet			= SET;

	CurrFwdAttn1_3G 		= 0xFF; 
	CurrFwdAttn2_3G 		= 0xFF; 
	CurrRvsAttn1_3G 		= 0xFF; 
	CurrRvsAttn2_3G 		= 0xFF; 
	CurrRvsAttn3_3G 		= 0xFF; 
	CurrRvsAttn4_3G 		= 0xFF; 

	CurrFwdAttn1_2G 		= 0xFF; 
	CurrRvsAttn1_2G 		= 0xFF; 
	CurrRvsAttn2_2G 		= 0xFF; 
	CurrRvsAttn3_2G 		= 0xFF; 

	CurrFwdAttn1_LTE		= 0xFF; 
	CurrRvsAttn1_LTE		= 0xFF; 
	CurrRvsAttn2_LTE		= 0xFF; 
	CurrRvsAttn3_LTE		= 0xFF; 

	CurrFwdAttn1_CDMALTE 	= 0xFF;
	CurrRvsAttn1_CDMALTE 	= 0xFF;
	
	CurrFwdAttn1_LTE_A2		= 0xFF; 
	CurrFwdAttn2_LTE_A2		= 0xFF; 
	CurrRvsAttn1_LTE_A2		= 0xFF; 
	CurrRvsAttn2_LTE_A2		= 0xFF; 
	CurrRvsAttn3_LTE_A2		= 0xFF; 
	CurrRvsAttn4_LTE_A2		= 0xFF; 

}

INT8U MaxAttnCheck(INT16S cAttn, INT16S tMax)
{
	INT8U retval = cAttn;
	
	if(cAttn > tMax)
	{
		retval = tMax;
	}
	else if(cAttn < 0)
	{
		retval = 0;
	}

	return retval;
}


INT8U OffsetMaxMinCheck(INT16S cAttn, INT16S tMax)
{
	INT8U retval = cAttn;
	
	if(cAttn > tMax)
	{
		retval = tMax;
	}
	else if(cAttn < 0)
	{
		retval = 0;
	}

	return retval;
}





void AttnDataOutput(unsigned short int Sel, unsigned char Data)
{
	INT8U i = 0;

	Data = (~Data )& 0x3f;  //HMC624
//	Data = Data & 0x3f;		//PE4302

	_ATTN_DATA = 0;
	_ATTN_CLK = 0;
	
	for(i = 0; i < 6; i++)
	{
		if (Data & 0x20)		_ATTN_DATA = 1;
		else					_ATTN_DATA = 0;
		
		Data = Data << 1;
		ForDelay(100L);

		_ATTN_CLK = 1;
		ForDelay(100L);
		_ATTN_CLK = 0;
	}

 	{
		switch(Sel)
		{
			case _FwdAttn1_2G_SEL:			
				PCA9555BitSet(Fwd_Att1_CDMA,&AttnCS1Val); 
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_CDMA,&AttnCS1Val); 		
			break;

			case _RvsAttn1_2G_SEL:			
				PCA9555BitSet(Rvs_Att1_CDMA,&AttnCS1Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_CDMA,&AttnCS1Val); 		
			break;
			
			case _RvsAttn2_2G_SEL:			
				PCA9555BitSet(Rvs_Att2_CDMA,&AttnCS1Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_CDMA,&AttnCS1Val);		
			break;
			
			case _RvsAttn3_2G_SEL:			
				PCA9555BitSet(Rvs_Att3_CDMA,&AttnCS1Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_CDMA,&AttnCS1Val); 
			break;
			
			case _FwdAttn1_LTE_SEL: 		
				PCA9555BitSet(Fwd_Att1_LTE_0,&AttnCS1Val);		
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_0,&AttnCS1Val);	
			break;

			case _RvsAttn1_LTE_SEL: 		
				PCA9555BitSet(Rvs_Att1_LTE_0,&AttnCS1Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_0,&AttnCS1Val);		
			break;
			
			case _RvsAttn2_LTE_SEL: 		
				PCA9555BitSet(Rvs_Att2_LTE_0,&AttnCS1Val);
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_0,&AttnCS1Val); 	
			break;
			
			case _RvsAttn3_LTE_SEL: 		
				PCA9555BitSet(Rvs_Att3_LTE_0,&AttnCS1Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_0,&AttnCS1Val); 
			break;

			case _FwdAttn1_Common_SEL:		
				PCA9555BitSet(Fwd_Att1_CDMALTE,&AttnCS1Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_CDMALTE,&AttnCS1Val); 	
			break;
			
			case _RvsAttn1_Common_SEL:		
				PCA9555BitSet(Rvs_Att1_CDMALTE,&AttnCS1Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_CDMALTE,&AttnCS1Val); 				
			break;

			case _FwdAttn1_LTE_A2_SEL:		
				PCA9555BitSet(Fwd_Att1_LTE_A2_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_A2_0,&AttnCS0Val);
			break;

			case _FwdAttn2_LTE_A2_SEL:		
				PCA9555BitSet(Fwd_Att2_LTE_A2_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_LTE_A2_0,&AttnCS0Val); 	
			break;
	
			case _RvsAttn1_LTE_A2_SEL:		
				PCA9555BitSet(Rvs_Att1_LTE_A2_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_A2_0,&AttnCS0Val); 	
			break;
			
			case _RvsAttn2_LTE_A2_SEL:		
				PCA9555BitSet(Rvs_Att2_LTE_A2_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_A2_0,&AttnCS0Val); 	
			break;
			
			case _RvsAttn3_LTE_A2_SEL:		
				PCA9555BitSet(Rvs_Att3_LTE_A2_0,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_A2_0,&AttnCS0Val);	
			break;

			case _RvsAttn4_LTE_A2_SEL:		
				PCA9555BitSet(Rvs_Att4_LTE_A2_0,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att4_LTE_A2_0,&AttnCS0Val);	
			break;

			case _FwdAttn1_3G_SEL:			
				PCA9555BitSet(Fwd_Att1_WCDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_WCDMA,&AttnCS0Val); 		
			break;
			
			case _FwdAttn2_3G_SEL:			
				PCA9555BitSet(Fwd_Att2_WCDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_WCDMA,&AttnCS0Val); 		
			break;
			
			case _RvsAttn1_3G_SEL:			
				PCA9555BitSet(Rvs_Att1_WCDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_WCDMA,&AttnCS0Val); 		
			break;
			
			case _RvsAttn2_3G_SEL:			
				PCA9555BitSet(Rvs_Att2_WCDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_WCDMA,&AttnCS0Val); 		
			break;
			
			case _RvsAttn3_3G_SEL:			
				PCA9555BitSet(Rvs_Att3_WCDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_WCDMA,&AttnCS0Val); 		
			break;
			
			case _RvsAttn4_3G_SEL:			
				PCA9555BitSet(Rvs_Att4_WCDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att4_WCDMA,&AttnCS0Val); 
			break;

			case _RvsBalanceAtt_2G_SEL:			
				PCA9555BitSet(Rvs_BalanceAtt_CDMALTE,&AttnCS1Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_BalanceAtt_CDMALTE,&AttnCS1Val); 
			break;
			
			case _RvsBalanceAtt_3G_SEL: 		
				PCA9555BitSet(Rvs_BalanceAtt_WCDMA,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_BalanceAtt_WCDMA,&AttnCS0Val); 
			break;

			case _RvsBalanceAtt_LTEA_SEL: 		
				PCA9555BitSet(Rvs_BalanceAtt_LTE_A2,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_BalanceAtt_LTE_A2,&AttnCS0Val); 
			break;
		}
	}
}

void ResetStart(INT32U tms)
{
	TimerRegist(TimerReset, tms);
}

BOOL AlarmCntFunc(INT8U *Cnt, INT8U Num)
{
    BOOL    RetVal = TRUE;
    INT8U   Temp = 0;

    Temp = *Cnt;
    
    if(Temp >= Num)
    {
        Temp = Num;
        RetVal = TRUE;
    }
    else
    {
        Temp++;
        RetVal = FALSE;
    }
    *Cnt = Temp;

    return  RetVal;
}



INT8S MinMaxAttnCheck(INT16S cAttn, INT16S tMax, INT16S tMin)
{
	INT8S retval = cAttn;
	
	if(cAttn > tMax)
	{
		retval = tMax;
	}
	else if(cAttn < tMin)
	{
		retval = tMin;
	}
	
	return retval;
}


INT16S GainAttnCalculation(INT16S cGain, INT16S cGainMax,INT8S cAttMin)
{
	INT16S AttTemp = 0;

	AttTemp = cGainMax - cGain;
	AttTemp = MinMaxAttnCheck(AttTemp, GainATTENMAX,ATTENMIN);

	return AttTemp;
}



void ADC_Select(INT8U Index)
{
	switch(Index)
	{
		case 0 :
			ADC_Sel0	= 0;
			ADC_Sel1	= 0;
		break;

		case 1 :
			ADC_Sel0	= 1;
			ADC_Sel1	= 0;
		break;
		
		case 2 :
			ADC_Sel0	= 0;
			ADC_Sel1	= 1;
		break;

		case 3 :
			ADC_Sel0	= 1;
			ADC_Sel1	= 1;
		break;
	}
}


void pPCA9555Port_Init(INT8U tIndex)
{
	_PCA9555Reg Reg;
	Reg.Data = tIndex;	// Output  0

	PCASetConfiguration(Attn_CS0,Reg);
	PCASetConfiguration(Attn_CS1,Reg);
}

void TimerRelatedOperation(void)
{
	if(TimeOverCheck(Timer_AttnOut))
	{
//		AttnBufferInit();
		TimerRegist(Timer_AttnOut, Time1Sec*5L); // 500msec 뒤에 다시 Attn!!
		iDebugCnt = 0; 
	}
}


INT8S RetPower(INT8S *tmp)
{
	INT8S rval;

	rval		= tmp[0]*2;
	if(tmp[1] >= 5)rval++;


	return (rval/1);
}

///////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////
