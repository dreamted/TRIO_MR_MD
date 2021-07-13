
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
//	INT8U i;
	(void)p_arg;

	TimerRegist(Timer_AttnOut, Time1Sec*10L);
	TimerRegist(TimerAlmReport, Time1Sec*10L);	
	TimerRegist(Timer_Period, Time1Sec*5L);
	TimerRegist(Timer_ModemReset, Time1Day*1L);

	{
		_PCA9555Init();
		pPCA9555Port_Init(0);
		pPCASetPortData(Attn_CS0, (0),pPCA9555Str,0);
		pPCASetPortData(Attn_CS1, (0),pPCA9555Str,0);
	}
	
	DL_AmpOnOff_CDMALTE		= 0;
	UL_AmpOnOff_CDMALTE		= 0;
	DL_AmpOnOff_LTEA		= 0;
	UL_AmpOnOff_LTEA		= 0;
	DL_AmpOnOff_WCDMA		= 0;
	UL_AmpOnOff_WCDMA		= 0;
	
	SMS_PWR = 0;
	
	_DTU_CS0 			= SET;
	_DTU_CS1 			= SET;
	_nFPGA_CONF_PROG 	= SET;

	Pll411xInit(RefFreq, FreqStep, 0);
	Pll411xInit(RefFreq, FreqStep, 1);
	Pll411xInit(RefFreq, FreqStep, 2);
	Pll411xInit(RefFreq, FreqStep, 3);
	Pll411xInit(RefFreq, FreqStep, 4);
	
	ADC_Select(0);

	OSTimeDly(200*EXPIO_START_PRIO);

	ULGainPeriod = AutoTimeChk(tDnrSts->ULGainPriod);
	
	Auto_ResetCheckInit();


	TimerRegist(TimerULGainPriod, (Time1Min * 1L));
	TimerRegist(TimerAGC_3G, Time100mSec*5L);

 	while(1)
	{
		while((DownLoadGiveupTimerSet(NULL)))
		{
			OSTimeDly(1000L);
		}
		
		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
		{
			OSSemPend(ExpSem, 0, &err );

			ReadAdcValue_TRIO();
			Period_Check();

			if( IsItDTUInited == TRUE)
			{
				if(ChkAttChange == RESET) OperatingFunc();

				StatusUpdate();
				StatustoIO();
			}
			if(TimeOverCheck(TimerAlmReport))
			{
				chkReport = SET;
			}

			OSSemPost(ExpSem);
			OSTimeDly(100L);  /// 시간조절시ALC 동작 확인 필요  
//			OSTimeDly(50L);  
		}
		OSTimeDly(500L);
	}
}

void Period_Check(void)
{
	if(!TimeOverCheck(Timer_Period)) return;
	TimerRegist(Timer_Period, Time100mSec*5L);

	ULGainLowCheack();

#ifdef DTU_TEST

#else
	if( IsItDTUInited == TRUE)
	{
		AlarmCheck();
	}
#endif

//	if(_RF_Module_Insert == __RESET)
	{
//		AlarmCheck();
	}


//	if((tDnrSts->ModuleAlarm.Main.DCFail == Normal)&&(PwrAlarm.ACFail == Normal))
	{
		TRIO_AlarmCheck();
	}
	
	if(chkReport)
	{
		AlarmStatusUpdate();
		PeriodReportCheck();
	}

	TimerRelatedOperation();

	if(tDnrSts->ISOMode == 0x00)
	{
		IsolationCheck();
	}

	if(++PeriodCnt >= 2)
	{
 		PeriodCnt = 0;
		ShutDownCheck();	
		
		if((PresentDay == 0)&&(PresentMonth == 0))
		{
			if( iSecCnt++ > 60 ) 
			{
				iPresentMinCnt ++;
				iSecCnt = 0;
			}
			if( iPresentMinCnt > 24 ) iPresentHourCnt ++;
		}
	
		if(AutoResetCnt++ > tPeriod )
		{
			AutoResetCnt = 0;	
			AutoResetFlg = SET;
		}
		CheckTime(tDnrSts->ResetPeriodCountSts,AutoResetCnt,0);
	}

	if(tDnrSts->RepeatResetPriod != 0x7f)
	{
		if(AutoResetFlg)
		{
			ResetCaseBackup(PeriodReset);

			OSTimeDly(1000L);
			tDnrSts->ResetCase = rambackup[0];

			BcMRtryNo = MaxTryNo;
			FirstFlag = 0;
			SmsInit();
		}
	}

}

void OperatingFunc(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT8U CurrAttn_Common = 0;

	if((ChkAttChange == RESET)||(ChkAgcChange == RESET))
	{
		AGCCheckFunction();
		ALCCheckFunction();
	}

//	if(Sts->AGCOnOff_CDMALTE == Disable)
	{
	//800M FWD AGC	
		{
			mAttnStr[_PATH_800M].AgcAttn_Path0  = Sts->FwdAgcAttn_2G;
			mAttnStr[_PATH_800M].AgcAttn_Path1 	= Sts->FwdAgcAttn_LTE;
			mAttnStr[_PATH_800M].AttnMax 		= AGC25_ATTENMAX;

			mAttnStr[_PATH_800M].InputAgcAttn	= Sts->FwdInAlcAttn_CDMALTE;

			OperatingFunc_DLAttn(_PATH_800M);

			Sts->FwdAttn1_2G 		= mAttnStr[_PATH_800M].nAttn1_Path0;
			Sts->FwdAttn1_LTE		= mAttnStr[_PATH_800M].nAttn1_Path1;
			Sts->FwdAttn1_CDMALTE	= mAttnStr[_PATH_800M].nAttn1_Common;

			Sts->FwdAttn1_2G  		= MinMaxAttnCheck(Sts->FwdAttn1_2G, DIGATTENMAX,ATTENMIN);
			Sts->FwdAttn1_LTE  		= MinMaxAttnCheck(Sts->FwdAttn1_LTE, DIGATTENMAX,ATTENMIN);
			Sts->FwdAttn1_CDMALTE  	= MinMaxAttnCheck(Sts->FwdAttn1_CDMALTE, DIGATTENMAX,ATTENMIN);

			Sts->FwdAttn2_2G 		= 0;
			Sts->FwdAttn2_LTE		= 0;
		}
//		Ser3Ptr->printf("FwdInAlcAttn_CDMALTE[%d][%d][%d]/[%d][%d][%d]\n",Sts->FwdInAlcAttn_CDMALTE,Sts->FwdAgcAttn_2G,Sts->FwdAgcAttn_LTE,mAttnStr[_PATH_800M].nAttn1_Path0,mAttnStr[_PATH_800M].nAttn1_Path1,mAttnStr[_PATH_800M].nAttn1_Common);
	//////////////////////////////////////////
	//800M Rvs AGC	
		CurrAgcAttn_2G = Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_2G;
		CurrAgcAttn_LTE = Sts->FwdAttn1_CDMALTE + Sts->FwdAttn1_LTE;

		if(Sts->AGCOnOff_CDMALTE == Enable)
		{
			Sts->RvsGainAttn_2G   = CurrAgcAttn_2G - Sts->RvsAlcAttn_2G;
			Sts->RvsGainAttn_LTE  = CurrAgcAttn_LTE - Sts->RvsAlcAttn_LTE;
		
			CurrRvsAlcAttn_2G = Sts->RvsGainAttn_2G;
			CurrRvsAlcAttn_LTE= Sts->RvsGainAttn_LTE;
		}
		else
		{
			CurrRvsAlcAttn_2G = Sts->RvsGainAttn_2G - Sts->RvsAlcAttn_2G;
			CurrRvsAlcAttn_LTE = Sts->RvsGainAttn_LTE- Sts->RvsAlcAttn_LTE;
		}
		
		CurrRvsAlcAttn_2G = MinMaxAttnCheck(CurrRvsAlcAttn_2G,AGCATTMAX_800M,ATTENMIN);
		CurrRvsAlcAttn_LTE = MinMaxAttnCheck(CurrRvsAlcAttn_LTE,AGCATTMAX_800M,ATTENMIN);

		{
			mAttnStr[_PATH_800M].AgcAttn_Path0	= CurrRvsAlcAttn_2G;
			mAttnStr[_PATH_800M].AgcAttn_Path1	= CurrRvsAlcAttn_LTE;
			mAttnStr[_PATH_800M].AttnMax		= AGC15_ATTENMAX;
			mAttnStr[_PATH_800M].InputAgcAttn	= 0;
			
			OperatingFunc_DLAttn(_PATH_800M);
		/////////////////////////////////////////////////////////////////////////
			Sts->RvsAttn2_2G		= mAttnStr[_PATH_800M].nAttn1_Path0;
			Sts->RvsAttn2_LTE		= mAttnStr[_PATH_800M].nAttn1_Path1;
			CurrAttn_Common			= mAttnStr[_PATH_800M].nAttn1_Common;
			if(CurrAttn_Common >= AGC10_ATTENMAX)
			{
				Sts->RvsAttn2_CDMALTE = AGC10_ATTENMAX;
				Sts->RvsAttn3_CDMALTE = CurrAttn_Common - AGC10_ATTENMAX;
			}
			else
			{
				Sts->RvsAttn2_CDMALTE = CurrAttn_Common;
				Sts->RvsAttn3_CDMALTE = 0;
			}
			Sts->RvsAttn2_CDMALTE = Sts->RvsAttn2_CDMALTE + Sts->RvsGainBalance_CDMALTE * 2;;
			Sts->RvsAttn3_CDMALTE = Sts->RvsAttn3_CDMALTE;

			Sts->RvsAttn3_CDMALTE = MinMaxAttnCheck(Sts->RvsAttn3_CDMALTE, DIGATTENMAX,ATTENMIN);
		}

	//800M Rvs ALC
		{
			INT8S CurrAttnMaxPath0;
			INT8S CurrAttnMaxPath1;
		
			mAttnStr[_PATH_800M].AgcAttn_Path0 		= Sts->RvsAlcAttn_2G;
			mAttnStr[_PATH_800M].AgcAttn_Path1 		= Sts->RvsAlcAttn_LTE;
			mAttnStr[_PATH_800M].AttnMax 			= AGC25_ATTENMAX;
			mAttnStr[_PATH_800M].InputAgcAttn		= Sts->RvsInAlcAttn_CDMALTE;
			mAttnStr[_PATH_800M].nInitGain_Path0	= Sts->InitRvsGainOffset_2G;
			mAttnStr[_PATH_800M].nInitGain_Path1	= Sts->InitRvsGainOffset_LTE;
			CurrAttnMaxPath0 = Sts->InitRvsGainOffset_2G  + ULALCATTENMAX;
			CurrAttnMaxPath1 = Sts->InitRvsGainOffset_LTE + ULALCATTENMAX;

			OperatingFunc_ULAttn(_PATH_800M);

			Sts->RvsAttn1_2G 		= mAttnStr[_PATH_800M].nAttn1_Path0;
			Sts->RvsAttn1_LTE		= mAttnStr[_PATH_800M].nAttn1_Path1;
			Sts->RvsAttn1_CDMALTE	= mAttnStr[_PATH_800M].nAttn1_Common + Sts->RvsInAlcAttn_CDMALTE;

			Sts->RvsGainOffset_2G	= mAttnStr[_PATH_800M].nGain_Path0;
			Sts->RvsGainOffset_LTE	= mAttnStr[_PATH_800M].nGain_Path1;
			Sts->RvsAttn1_CDMALTE = MinMaxAttnCheck(Sts->RvsAttn1_CDMALTE, RVSALC18_ATTENMAX,ATTENMIN);


			Sts->RvsGainOffset_2G  	= MinMaxAttnCheck(Sts->RvsGainOffset_2G	, CurrAttnMaxPath0,ULALCATTENMIN);
			Sts->RvsGainOffset_LTE	= MinMaxAttnCheck(Sts->RvsGainOffset_LTE, CurrAttnMaxPath1,ULALCATTENMIN);
		}
	}

#if 1
//	if(Sts->AGCOnOff_LTE_A_0== Disable)
	{
	//1800M FWD AGC	

		{
			mAttnStr[_PATH_1800M].AgcAttn_Path0	= Sts->FwdAgcAttn_LTE_A1;
			mAttnStr[_PATH_1800M].AgcAttn_Path1	= Sts->FwdAgcAttn_LTE_A2;
			mAttnStr[_PATH_1800M].AttnMax		= AGC25_ATTENMAX;
			mAttnStr[_PATH_1800M].InputAgcAttn	= Sts->FwdInAlcAttn_LTE_A;
			
			OperatingFunc_DLAttn(_PATH_1800M);


			Sts->FwdAttn1_LTE_A1	= mAttnStr[_PATH_1800M].nAttn1_Path0;
			Sts->FwdAttn1_LTE_A2	= mAttnStr[_PATH_1800M].nAttn1_Path1;
			Sts->FwdAttn1_LTE_A 	= mAttnStr[_PATH_1800M].nAttn1_Common;
			Sts->FwdAttn1_LTE_A  	= MinMaxAttnCheck(Sts->FwdAttn1_LTE_A	, DIGATTENMAX,ATTENMIN);

			Sts->FwdAttn2_LTE_A1 		= 0;
			Sts->FwdAttn2_LTE_A2		= 0;
		}
	//	Ser3Ptr->printf("Attn[%d][%d]>[%d][%d][%d]\n",Sts->FwdAgcAttn_2G,Sts->FwdAgcAttn_LTE,Sts->FwdAttn1_2G,Sts->FwdAttn1_LTE,Sts->FwdAttn1_CDMALTE);
	//////////////////////////////////////////
	//1800M Rvs AGC	
	CurrAgcAttn_LTE_A1 = Sts->FwdAttn1_LTE_A + Sts->FwdAttn1_LTE_A1;
	CurrAgcAttn_LTE_A2 = Sts->FwdAttn1_LTE_A + Sts->FwdAttn1_LTE_A2;
	
	if(Sts->AGCOnOff_LTE_A_0 == Enable)
	{
		Sts->RvsGainAttn_LTE_A1 = CurrAgcAttn_LTE_A1 - Sts->RvsAlcAttn_LTE_A1;
		Sts->RvsGainAttn_LTE_A2  = CurrAgcAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2;
	
		CurrRvsAlcAttn_LTE_A1 = Sts->RvsGainAttn_LTE_A1;
		CurrRvsAlcAttn_LTE_A2 = Sts->RvsGainAttn_LTE_A2;
	}
	else
	{
		CurrRvsAlcAttn_LTE_A1 = Sts->RvsGainAttn_LTE_A1 - Sts->RvsAlcAttn_LTE_A1;
		CurrRvsAlcAttn_LTE_A2 = Sts->RvsGainAttn_LTE_A2 - Sts->RvsAlcAttn_LTE_A2;
	}
	
	CurrRvsAlcAttn_LTE_A1 = MinMaxAttnCheck(CurrRvsAlcAttn_LTE_A1,AGCATTMAX_1800M,ATTENMIN);
	CurrRvsAlcAttn_LTE_A2 = MinMaxAttnCheck(CurrRvsAlcAttn_LTE_A2,AGCATTMAX_1800M,ATTENMIN);


	{
			mAttnStr[_PATH_1800M].AgcAttn_Path0	= CurrRvsAlcAttn_LTE_A1;
			mAttnStr[_PATH_1800M].AgcAttn_Path1	= CurrRvsAlcAttn_LTE_A2;
			mAttnStr[_PATH_1800M].AttnMax		= AGC15_ATTENMAX;
			mAttnStr[_PATH_1800M].InputAgcAttn	= 0;

			OperatingFunc_DLAttn(_PATH_1800M);
		/////////////////////////////////////////////////////////////////////////
			Sts->RvsAttn2_LTE_A1	= mAttnStr[_PATH_1800M].nAttn1_Path0;
			Sts->RvsAttn2_LTE_A2	= mAttnStr[_PATH_1800M].nAttn1_Path1;
			CurrAttn_Common 		= mAttnStr[_PATH_1800M].nAttn1_Common;

//			Ser3Ptr->printf("Attn[%d][%d]>[%d][%d][%d]\n",Sts->FwdAgcAttn_2G,Sts->FwdAgcAttn_LTE,Sts->FwdAttn1_2G,Sts->FwdAttn1_LTE,Sts->FwdAttn1_CDMALTE);

			if(CurrAttn_Common >= AGC10_ATTENMAX)
			{
				Sts->RvsAttn2_LTE_A = AGC10_ATTENMAX;
				Sts->RvsAttn3_LTE_A = CurrAttn_Common - AGC10_ATTENMAX;
			}
			else
			{
				Sts->RvsAttn2_LTE_A = CurrAttn_Common;
				Sts->RvsAttn3_LTE_A = 0;
			}
			
			Sts->RvsAttn2_LTE_A = Sts->RvsAttn2_LTE_A + Sts->RvsGainBalance_LTE_A * 2;;
			Sts->RvsAttn3_LTE_A = Sts->RvsAttn3_LTE_A;

			Sts->RvsAttn3_LTE_A  = MinMaxAttnCheck(Sts->RvsAttn3_LTE_A	, DIGATTENMAX,ATTENMIN);
		}

	//1800M Rvs ALC
		#if 1
		{
			INT8S CurrAttnMaxPath0;
			INT8S CurrAttnMaxPath1;
			Sts->InitRvsGainOffset_LTE_A1 	= 0;
			Sts->RvsAlcAttn_LTE_A1 			= 0;
			
			mAttnStr[_PATH_1800M].AgcAttn_Path0 	= Sts->RvsAlcAttn_LTE_A1;
			mAttnStr[_PATH_1800M].AgcAttn_Path1 	= Sts->RvsAlcAttn_LTE_A2;
			mAttnStr[_PATH_1800M].AttnMax			= AGC25_ATTENMAX;
			mAttnStr[_PATH_1800M].InputAgcAttn		= Sts->RvsInAlcAttn_LTE_A;
			mAttnStr[_PATH_1800M].nInitGain_Path0	= Sts->InitRvsGainOffset_LTE_A1;
			mAttnStr[_PATH_1800M].nInitGain_Path1	= Sts->InitRvsGainOffset_LTE_A2;
			CurrAttnMaxPath0 = Sts->InitRvsGainOffset_LTE_A1 + ULALCATTENMAX;
			CurrAttnMaxPath1 = Sts->InitRvsGainOffset_LTE_A2 + ULALCATTENMAX;

			OperatingFunc_ULAttn(_PATH_1800M);

			Sts->RvsAttn1_LTE_A1	= mAttnStr[_PATH_1800M].nAttn1_Path0;
			Sts->RvsAttn1_LTE_A2	= mAttnStr[_PATH_1800M].nAttn1_Path1;
			Sts->RvsAttn1_LTE_A		= mAttnStr[_PATH_1800M].nAttn1_Common + Sts->RvsInAlcAttn_LTE_A;

			Sts->RvsGainOffset_LTE_A1	= mAttnStr[_PATH_1800M].nGain_Path0;
			Sts->RvsGainOffset_LTE_A2	= mAttnStr[_PATH_1800M].nGain_Path1;

			Sts->RvsAttn1_LTE_A = MinMaxAttnCheck(Sts->RvsAttn1_LTE_A, RVSALC23_ATTENMAX,ATTENMIN);
			
			Sts->RvsGainOffset_LTE_A1	= MinMaxAttnCheck(Sts->RvsGainOffset_LTE_A1, CurrAttnMaxPath0,ULALCATTENMIN);
			Sts->RvsGainOffset_LTE_A2	= MinMaxAttnCheck(Sts->RvsGainOffset_LTE_A2, CurrAttnMaxPath1,ULALCATTENMIN);
		}
		#endif
	}
#endif

//	if(Sts->AGCOnOff_WCDMALTE_21 == Disable)
	{
	//2100M FWD AGC	
		{
			mAttnStr[_PATH_2100M].AgcAttn_Path0 = Sts->FwdAgcAttn_3G;
			mAttnStr[_PATH_2100M].AgcAttn_Path1 = Sts->FwdAgcAttn_LTE_21;
			mAttnStr[_PATH_2100M].AttnMax 		= AGC25_ATTENMAX;
			mAttnStr[_PATH_2100M].InputAgcAttn	= Sts->FwdInAlcAttn_WCDMALTE_21;
			OperatingFunc_DLAttn(_PATH_2100M);

			Sts->FwdAttn1_3G 			= mAttnStr[_PATH_2100M].nAttn1_Path0;
			Sts->FwdAttn1_LTE_21		= mAttnStr[_PATH_2100M].nAttn1_Path1;
			Sts->FwdAttn1_WCDMALTE_21	= mAttnStr[_PATH_2100M].nAttn1_Common;
			Sts->FwdAttn1_WCDMALTE_21 	= MinMaxAttnCheck(Sts->FwdAttn1_WCDMALTE_21	, DIGATTENMAX,ATTENMIN);
			
			Sts->FwdAttn2_3G 			= 0;
			Sts->FwdAttn2_LTE_21		= 0;
		}
	//////////////////////////////////////////
	//2100M Rvs AGC	
		CurrAgcAttn_3G     = Sts->FwdAttn1_WCDMALTE_21 + Sts->FwdAttn1_3G;
		CurrAgcAttn_LTE_21 = Sts->FwdAttn1_WCDMALTE_21 + Sts->FwdAttn1_LTE_21;

		if(Sts->AGCOnOff_WCDMALTE_21 == Enable)
		{
			Sts->RvsGainAttn_3G     = CurrAgcAttn_3G - Sts->RvsAlcAttn_3G;
			Sts->RvsGainAttn_LTE_21 = CurrAgcAttn_LTE_21 - Sts->RvsAlcAttn_LTE_21;
		
			CurrRvsAlcAttn_3G 	  = Sts->RvsGainAttn_3G;
			CurrRvsAlcAttn_LTE_21 = Sts->RvsGainAttn_LTE_21;
		}
		else
		{
			CurrRvsAlcAttn_3G     = Sts->RvsGainAttn_3G - Sts->RvsAlcAttn_3G;
			CurrRvsAlcAttn_LTE_21 = Sts->RvsGainAttn_LTE_21 - Sts->RvsAlcAttn_LTE_21;
		}
		
		CurrRvsAlcAttn_3G     = MinMaxAttnCheck(CurrRvsAlcAttn_3G,AGCATTMAX_2100M,ATTENMIN);
		CurrRvsAlcAttn_LTE_21 = MinMaxAttnCheck(CurrRvsAlcAttn_LTE_21,AGCATTMAX_2100M,ATTENMIN);

		{
			mAttnStr[_PATH_2100M].AgcAttn_Path0	= CurrRvsAlcAttn_3G;
			mAttnStr[_PATH_2100M].AgcAttn_Path1	= CurrRvsAlcAttn_LTE_21;
			mAttnStr[_PATH_2100M].AttnMax		= AGC15_ATTENMAX;
			mAttnStr[_PATH_2100M].InputAgcAttn	= 0;

			OperatingFunc_DLAttn(_PATH_2100M);
		/////////////////////////////////////////////////////////////////////////
			Sts->RvsAttn2_3G		= mAttnStr[_PATH_2100M].nAttn1_Path0;
			Sts->RvsAttn2_LTE_21	= mAttnStr[_PATH_2100M].nAttn1_Path1;
			CurrAttn_Common			= mAttnStr[_PATH_2100M].nAttn1_Common;

			if(CurrAttn_Common >= AGC10_ATTENMAX)
			{
				Sts->RvsAttn2_WCDMALTE_21 = AGC10_ATTENMAX;
				Sts->RvsAttn3_WCDMALTE_21 = CurrAttn_Common - AGC10_ATTENMAX;
			}
			else
			{
				Sts->RvsAttn2_WCDMALTE_21 = CurrAttn_Common;
				Sts->RvsAttn3_WCDMALTE_21 = 0;
			}
			
			Sts->RvsAttn2_WCDMALTE_21 = Sts->RvsAttn2_WCDMALTE_21 + Sts->RvsGainBalance_WCDMALTE_21* 2;;
			Sts->RvsAttn3_WCDMALTE_21 = Sts->RvsAttn3_WCDMALTE_21;
			Sts->RvsAttn3_WCDMALTE_21  = MinMaxAttnCheck(Sts->RvsAttn3_WCDMALTE_21	, DIGATTENMAX,ULALCATTENMIN);
		}

	//2100M Rvs ALC	
		{
			INT8S CurrAttnMaxPath0;
			INT8S CurrAttnMaxPath1;
		
			mAttnStr[_PATH_2100M].AgcAttn_Path0 	= Sts->RvsAlcAttn_3G;
			mAttnStr[_PATH_2100M].AgcAttn_Path1 	= Sts->RvsAlcAttn_LTE_21;
			mAttnStr[_PATH_2100M].AttnMax			= AGC25_ATTENMAX;
			mAttnStr[_PATH_2100M].InputAgcAttn		= Sts->RvsInAlcAttn_WCDMALTE_21;
			mAttnStr[_PATH_2100M].nInitGain_Path0	= Sts->InitRvsGainOffset_3G;
			mAttnStr[_PATH_2100M].nInitGain_Path1	= Sts->InitRvsGainOffset_LTE_21;
			CurrAttnMaxPath0 = Sts->InitRvsGainOffset_3G 	 + ULALCATTENMAX;
			CurrAttnMaxPath1 = Sts->InitRvsGainOffset_LTE_21 + ULALCATTENMAX;

			OperatingFunc_ULAttn(_PATH_2100M);

			Sts->RvsAttn1_3G			= mAttnStr[_PATH_2100M].nAttn1_Path0;
			Sts->RvsAttn1_LTE_21		= mAttnStr[_PATH_2100M].nAttn1_Path1;
			Sts->RvsAttn1_WCDMALTE_21	= mAttnStr[_PATH_2100M].nAttn1_Common + Sts->RvsInAlcAttn_WCDMALTE_21;

			Sts->RvsGainOffset_3G		= mAttnStr[_PATH_2100M].nGain_Path0;

			Sts->RvsGainOffset_LTE_21	= mAttnStr[_PATH_2100M].nGain_Path1;

			Sts->RvsAttn1_WCDMALTE_21 	= MinMaxAttnCheck(Sts->RvsAttn1_WCDMALTE_21, RVSALC24_ATTENMAX,ATTENMIN);

			Sts->RvsGainOffset_3G		= MinMaxAttnCheck(Sts->RvsGainOffset_3G , CurrAttnMaxPath0,ULALCATTENMIN);
			Sts->RvsGainOffset_LTE_21	= MinMaxAttnCheck(Sts->RvsGainOffset_LTE_21, CurrAttnMaxPath1,ULALCATTENMIN);
		}
	}
}


void OperatingFunc_DLAttn(INT8U IsItPath)
{
	INT8S tAgcAttn_Path0 = 0; 
	INT8S tAgcAttn_Path1 = 0; 
	INT8S tInputAgcAttn = 0; 

	INT8S CurrAttn1 = 0;
	INT8S CurrAttn2 = 0;

	INT8S CurrAttnMAX = 0;

	CurrAttnMAX 	= mAttnStr[IsItPath].AttnMax;
	tAgcAttn_Path0 	= mAttnStr[IsItPath].AgcAttn_Path0;
	tAgcAttn_Path1 	= mAttnStr[IsItPath].AgcAttn_Path1;
	tInputAgcAttn 	= mAttnStr[IsItPath].InputAgcAttn;

	if((tAgcAttn_Path0 >= CurrAttnMAX)||(tAgcAttn_Path1>= CurrAttnMAX))
	{
		CurrAttn1 = tAgcAttn_Path0  - CurrAttnMAX;
		CurrAttn2 = tAgcAttn_Path1  - CurrAttnMAX;

		if(tAgcAttn_Path0 >= tAgcAttn_Path1)
		{
			mAttnStr[IsItPath].nAttn1_Path0		= CurrAttnMAX;
			mAttnStr[IsItPath].nAttn1_Common	= CurrAttn1;
			mAttnStr[IsItPath].nAttn1_Path1 	= tAgcAttn_Path1 - CurrAttn1;
		}
		else
		{
			mAttnStr[IsItPath].nAttn1_Path1		= CurrAttnMAX;
			mAttnStr[IsItPath].nAttn1_Common	= CurrAttn2;
			mAttnStr[IsItPath].nAttn1_Path0		= tAgcAttn_Path0 - CurrAttn2;
		}
	}
	else
	{
		mAttnStr[IsItPath].nAttn1_Path0 	= mAttnStr[IsItPath].AgcAttn_Path0;
		mAttnStr[IsItPath].nAttn1_Path1		= mAttnStr[IsItPath].AgcAttn_Path1;
		mAttnStr[IsItPath].nAttn1_Common 	= 0;
	}
	
	mAttnStr[IsItPath].nAttn1_Common = mAttnStr[IsItPath].nAttn1_Common + tInputAgcAttn;
	mAttnStr[IsItPath].nAttn1_Path0  = mAttnStr[IsItPath].nAttn1_Path0 - tInputAgcAttn;
	mAttnStr[IsItPath].nAttn1_Path1  = mAttnStr[IsItPath].nAttn1_Path1 - tInputAgcAttn;

	mAttnStr[IsItPath].nAttn1_Path0	 = MinMaxAttnCheck(mAttnStr[IsItPath].nAttn1_Path0	, DIGATTENMAX,ATTENMIN);
	mAttnStr[IsItPath].nAttn1_Path1	 = MinMaxAttnCheck(mAttnStr[IsItPath].nAttn1_Path1	, DIGATTENMAX,ATTENMIN);
}

void OperatingFunc_ULAttn(INT8U IsItPath)
{
	INT8S tAgcAttn_Path0 = 0; 
	INT8S tAgcAttn_Path1 = 0; 

	INT8S CurrAttn1 = 0;
	INT8S CurrAttn2 = 0;

	INT8S CurrAttnMAX = 0;
	INT8S tOffset_Path0 = 0; 
	INT8S tOffset_Path1 = 0; 

	CurrAttnMAX 	= mAttnStr[IsItPath].AttnMax;
	tAgcAttn_Path0 	= mAttnStr[IsItPath].AgcAttn_Path0;
	tAgcAttn_Path1 	= mAttnStr[IsItPath].AgcAttn_Path1;
	tOffset_Path0 	= mAttnStr[IsItPath].nInitGain_Path0;
	tOffset_Path1 	= mAttnStr[IsItPath].nInitGain_Path1;
//	Ser3Ptr->printf("0: RvsAlcAttn_2G[%d][%d]\n",mAttnStr[IsItPath].AgcAttn_Path0,mAttnStr[IsItPath].AgcAttn_Path1);


	if((tAgcAttn_Path0 >= CurrAttnMAX)||(tAgcAttn_Path1>= CurrAttnMAX))
	{
	///38 39     13 14				
		CurrAttn1 = tAgcAttn_Path0  - CurrAttnMAX;  /// 13
		CurrAttn2 = tAgcAttn_Path1  - CurrAttnMAX;  /// 14

//		Ser3Ptr->printf("1: RvsAlcAttn_2G[%d][%d]:[%d][%d]\n",CurrAttn1,CurrAttn2,tAgcAttn_Path0,tAgcAttn_Path1);

		if(tAgcAttn_Path0 >= tAgcAttn_Path1)
		{
			mAttnStr[IsItPath].nAttn1_Path0		= CurrAttnMAX; 	/// 25
			mAttnStr[IsItPath].nAttn1_Common	= CurrAttn1;   	///13
			mAttnStr[IsItPath].nAttn1_Path1 	= tAgcAttn_Path1 - CurrAttn1;
//			Ser3Ptr->printf("2: nAttn1_Path1[%d]\n",mAttnStr[IsItPath].nAttn1_Path1);
			
			if(mAttnStr[IsItPath].nAttn1_Path1 < 0)
			{
				mAttnStr[IsItPath].nGain_Path1 = tOffset_Path1 - mAttnStr[IsItPath].nAttn1_Path1;
			}
			else mAttnStr[IsItPath].nGain_Path1 = tOffset_Path1;
			
			mAttnStr[IsItPath].nGain_Path0 = tOffset_Path0;

			
//			Ser3Ptr->printf("3: nAttn1_Path1[%d][%d]\n",mAttnStr[IsItPath].nAttn1_Path1,mAttnStr[IsItPath].nGain_Path1);
		}
		else
		{
			mAttnStr[IsItPath].nAttn1_Path1		= CurrAttnMAX;	//25
			mAttnStr[IsItPath].nAttn1_Common	= CurrAttn2;	//14
			mAttnStr[IsItPath].nAttn1_Path0		= tAgcAttn_Path0 - CurrAttn2; //24

			if(mAttnStr[IsItPath].nAttn1_Path0 < 0)
			{
				mAttnStr[IsItPath].nGain_Path0 = tOffset_Path0 - mAttnStr[IsItPath].nAttn1_Path0;
			}
			else mAttnStr[IsItPath].nGain_Path0 = tOffset_Path0;
			
			mAttnStr[IsItPath].nGain_Path1 = tOffset_Path1;
		}
	}
	else
	{
		mAttnStr[IsItPath].nAttn1_Path0 	= mAttnStr[IsItPath].AgcAttn_Path0;
		mAttnStr[IsItPath].nAttn1_Path1		= mAttnStr[IsItPath].AgcAttn_Path1;
		mAttnStr[IsItPath].nAttn1_Common 	= 0;
		
		mAttnStr[IsItPath].nGain_Path0 = tOffset_Path0;
		mAttnStr[IsItPath].nGain_Path1 = tOffset_Path1;
	}

	mAttnStr[IsItPath].nAttn1_Path0	 = MinMaxAttnCheck(mAttnStr[IsItPath].nAttn1_Path0	, DIGATTENMAX,ATTENMIN);
	mAttnStr[IsItPath].nAttn1_Path1	 = MinMaxAttnCheck(mAttnStr[IsItPath].nAttn1_Path1	, DIGATTENMAX,ATTENMIN);
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
		Sts->FwdTemp_CDMALTE 		= AttnTempTable->FwdTemp_CDMALTE.Data[tindex];
		Sts->RvsTemp_CDMALTE 		= AttnTempTable->RvsTemp_CDMALTE.Data[tindex];
		Sts->FwdTemp_LTE_A 			= AttnTempTable->FwdTempAttn_LTE_A.Data[tindex];
		Sts->RvsTemp_LTE_A 			= AttnTempTable->RvsTempAttn_LTE_A.Data[tindex];
		Sts->FwdTemp_WCDMALTE_21	= AttnTempTable->FwdTemp_WCDMALTE_21.Data[tindex];
		Sts->RvsTemp_WCDMALTE_21	= AttnTempTable->RvsTemp_WCDMALTE_21.Data[tindex];


		Sts->FwdOutPwrTemp_CDMA 	= FwdOutPwrTemp_CDMA[tindex];
		Sts->RvsOutPwrTemp_CDMA 	= RvsOutPwrTemp_CDMA[tindex];
		Sts->FwdOutPwrTemp_LTE		= FwdOutPwrTemp_LTE[tindex];
		Sts->RvsOutPwrTemp_LTE		= RvsOutPwrTemp_LTE[tindex];
		Sts->FwdOutPwrTemp_WCDMA	= FwdOutPwrTemp_WCDMA[tindex];
		Sts->RvsOutPwrTemp_WCDMA	= RvsOutPwrTemp_WCDMA[tindex];
		Sts->FwdOutPwrTemp_LTE_21	= FwdOutPwrTemp_LTE_21[tindex];
		Sts->RvsOutPwrTemp_LTE_21	= RvsOutPwrTemp_LTE_21[tindex];
		Sts->FwdOutPwrTemp_LTE_A2	= FwdOutPwrTemp_LTE_A2[tindex];
		Sts->RvsOutPwrTemp_LTE_A2	= RvsOutPwrTemp_LTE_A2[tindex];
	}
	else
	{
		Sts->FwdTemp_CDMALTE 		= 0;
		Sts->RvsTemp_CDMALTE 		= 0;
		Sts->FwdTemp_LTE_A 			= 0;
		Sts->RvsTemp_LTE_A 			= 0;
		Sts->FwdTemp_WCDMALTE_21 	= 0;
		Sts->RvsTemp_WCDMALTE_21 	= 0;

		Sts->FwdOutPwrTemp_CDMA		= 0;
		Sts->RvsOutPwrTemp_CDMA		= 0;
		Sts->FwdOutPwrTemp_LTE		= 0;
		Sts->RvsOutPwrTemp_LTE		= 0;
		Sts->FwdOutPwrTemp_WCDMA	= 0;
		Sts->RvsOutPwrTemp_WCDMA	= 0;
		Sts->FwdOutPwrTemp_LTE_21	= 0;
		Sts->RvsOutPwrTemp_LTE_21	= 0;
		Sts->FwdOutPwrTemp_LTE_A2	= 0;
		Sts->RvsOutPwrTemp_LTE_A2	= 0;
	}
}

void AmpPathOnOff(INT8U Path,INT8U OnOff )
{
	__Dnr_Sts  *Sts = tDnrSts;

	switch(Path)
	{
		case __CDMA:
			if(OnOff == Enable)
			{
				Sts->PathOnOff_800M.DL_Left = _On;
				Sts->PathOnOff_800M.UL_Left = _On;
			}
			else
			{
				Sts->PathOnOff_800M.DL_Left = _Off;
				Sts->PathOnOff_800M.UL_Left = _Off;
			}

			DTU_WriteData(CS0SEL, DTU_PATHOnOff_800M, Sts->PathOnOff_800M.Data);
		break;

		case __LTE:
			if(OnOff == Enable)
			{
				Sts->PathOnOff_800M.DL_Right = _On;
				Sts->PathOnOff_800M.UL_Right = _On;
			}
			else
			{
				Sts->PathOnOff_800M.DL_Right = _Off;
				Sts->PathOnOff_800M.UL_Right = _Off;
			}
			DTU_WriteData(CS0SEL, DTU_PATHOnOff_800M, Sts->PathOnOff_800M.Data);
		break;

		case __LTE_A2:
			if(OnOff == Enable)
			{
				Sts->PathOnOff_1800M.DL_Left = _On;
				Sts->PathOnOff_1800M.UL_Left = _On;
				
				DL_AmpOnOff_LTEA = 1;
				UL_AmpOnOff_LTEA = 1;
			}
			else
			{
				Sts->PathOnOff_1800M.DL_Left = _Off;
				Sts->PathOnOff_1800M.UL_Left = _Off;
				
				DL_AmpOnOff_LTEA = 0;
				UL_AmpOnOff_LTEA = 0;
			}

			DTU_WriteData(CS0SEL, DTU_PATHOnOff_1800M, Sts->PathOnOff_1800M.Data);
		break;

		case __LTE_A1:
			if(OnOff == Enable)
			{
				Sts->PathOnOff_1800M.DL_Right = _On;
				Sts->PathOnOff_1800M.UL_Right = _On;
			}
			else
			{
				Sts->PathOnOff_1800M.DL_Right = _Off;
				Sts->PathOnOff_1800M.UL_Right = _Off;
			}
			DTU_WriteData(CS0SEL, DTU_PATHOnOff_1800M, Sts->PathOnOff_1800M.Data);
		break;

		case __WCDMA:
			if(OnOff == Enable)
			{
				Sts->PathOnOff_2100M.DL_Right = _On;
				Sts->PathOnOff_2100M.UL_Right = _On;
			}
			else
			{
				Sts->PathOnOff_2100M.DL_Right = _Off;
				Sts->PathOnOff_2100M.UL_Right = _Off;
			}

			DTU_WriteData(CS0SEL, DTU_PATHOnOff_2100M, Sts->PathOnOff_2100M.Data);
		break;

		case __LTE_21:
			if(OnOff == Enable)
			{
				Sts->PathOnOff_2100M.DL_Left = _On;
				Sts->PathOnOff_2100M.UL_Left = _On;
			}
			else
			{
				Sts->PathOnOff_2100M.DL_Left = _Off;
				Sts->PathOnOff_2100M.UL_Left = _Off;
			}
			DTU_WriteData(CS0SEL, DTU_PATHOnOff_2100M, Sts->PathOnOff_2100M.Data);
		break;
			
		case __CDMALTE:
			if(OnOff == Enable)
			{
				DL_AmpOnOff_CDMALTE = 1;
				UL_AmpOnOff_CDMALTE = 1;
			}
			else
			{
				DL_AmpOnOff_CDMALTE = 0;
				UL_AmpOnOff_CDMALTE = 0;
			}
		break;

		case __LTEA1_LTEA2:
			if(OnOff == Enable)
			{
				DL_AmpOnOff_LTEA = 1;
				UL_AmpOnOff_LTEA = 1;
			}
			else
			{
				DL_AmpOnOff_LTEA = 0;
				UL_AmpOnOff_LTEA = 0;
			}
			break;

		case __WCDMALTE_21:
			if(OnOff == Enable)
			{
				DL_AmpOnOff_WCDMA = 1;
				UL_AmpOnOff_WCDMA = 1;
			}
			else
			{
				DL_AmpOnOff_WCDMA = 0;
				UL_AmpOnOff_WCDMA = 0;
			}
			
			break;
		default :
		break;

	}

	if((Sts->AlmSts.FwdAmpOnOff_2G == Disable)&&(Sts->AlmSts.FwdAmpOnOff_LTE == Disable))
	{
		DL_AmpOnOff_CDMALTE = 0;
		UL_AmpOnOff_CDMALTE = 0;
	}
	else
	{
		DL_AmpOnOff_CDMALTE = 1;
		UL_AmpOnOff_CDMALTE = 1;
	}

	if((Sts->AlmSts.FwdAmpOnOff_3G == Disable)&&(Sts->AlmSts.FwdAmpOnOff_LTE_21 == Disable))
	{
		DL_AmpOnOff_WCDMA = 0;
		UL_AmpOnOff_WCDMA = 0;
	}
	else
	{
		DL_AmpOnOff_WCDMA = 1;
		UL_AmpOnOff_WCDMA = 1;
	}
}



void StatustoIO(void)
{
    INT16S AttnTemp0 = 0;
	INT16S AttnTemp1 = 0;

	__Dnr_Sts  *Sts = tDnrSts;


	//////////////////////////////////////////////////////////////////////////////////////////
	AttnTemp0 = Sts->FwdAttn1_CDMALTE;
	AttnTemp1 = AttnOffsetTable->FwdAttn1_CDMALTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.FwdAttn1_CDMALTE= Sts->CurrFwdAttn1_CDMALTE = AttnTemp0;
	if(CurrFwdAttn1_CDMALTE != Sts->CurrFwdAttn1_CDMALTE)
	{
		CurrFwdAttn1_CDMALTE = Sts->CurrFwdAttn1_CDMALTE;
		AttnDataOutput(_FwdAttn1_CDMALTE_SEL, Sts->CurrFwdAttn1_CDMALTE);
	}


	AttnTemp0 = Sts->RvsAttn1_CDMALTE;
	AttnTemp1 = AttnOffsetTable->RvsAttn1_CDMALTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn1_CDMALTE= Sts->CurrRvsAttn1_CDMALTE = AttnTemp0;
	if(CurrRvsAttn1_CDMALTE != Sts->CurrRvsAttn1_CDMALTE)
	{
		CurrRvsAttn1_CDMALTE = Sts->CurrRvsAttn1_CDMALTE;
		AttnDataOutput(_RvsAttn1_CDMALTE_SEL, Sts->CurrRvsAttn1_CDMALTE);
	}

	AttnTemp0 = Sts->RvsAttn2_CDMALTE;
	AttnTemp1 = AttnOffsetTable->RvsAttn2_CDMALTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn2_CDMALTE= Sts->CurrRvsAttn2_CDMALTE = AttnTemp0;
	if(CurrRvsAttn2_CDMALTE != Sts->CurrRvsAttn2_CDMALTE)
	{
		CurrRvsAttn2_CDMALTE = Sts->CurrRvsAttn2_CDMALTE;
		AttnDataOutput(_RvsAttn2_CDMALTE_SEL, Sts->CurrRvsAttn2_CDMALTE);
	}

	AttnTemp0 = Sts->RvsAttn3_CDMALTE;
	AttnTemp1 = AttnOffsetTable->RvsAttn3_CDMALTE.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn3_CDMALTE= Sts->CurrRvsAttn3_CDMALTE = AttnTemp0;
	if(CurrRvsAttn3_CDMALTE != Sts->CurrRvsAttn3_CDMALTE)
	{
		CurrRvsAttn3_CDMALTE = Sts->CurrRvsAttn3_CDMALTE;
		AttnDataOutput(_RvsAttn3_CDMALTE_SEL, Sts->CurrRvsAttn3_CDMALTE);
	}

/////////xxxxxxxxxxxxxxxxxxxxx
	AttnTemp0 = Sts->FwdAttn1_LTE_A;
	AttnTemp1 = AttnOffsetTable->FwdAttn1_LTE_A.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	Sts->AttValue.FwdAttn1_LTE_A = Sts->CurrFwdAttn1_LTE_A = AttnTemp0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	if(CurrFwdAttn1_LTEA != Sts->CurrFwdAttn1_LTE_A)
	{
		CurrFwdAttn1_LTEA = Sts->CurrFwdAttn1_LTE_A;
		AttnDataOutput(_FwdAttn1_LTEA_SEL, Sts->CurrFwdAttn1_LTE_A);
	}

	AttnTemp0 = Sts->RvsAttn1_LTE_A;
	AttnTemp1 = AttnOffsetTable->RvsAttn1_LTE_A.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	Sts->AttValue.RvsAttn1_LTE_A = Sts->CurrRvsAttn1_LTE_A= AttnTemp0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	if(CurrRvsAttn1_LTEA != Sts->CurrRvsAttn1_LTE_A)
	{
		CurrRvsAttn1_LTEA = Sts->CurrRvsAttn1_LTE_A;
		AttnDataOutput(_RvsAttn1_LTEA_SEL, Sts->CurrRvsAttn1_LTE_A);
	}

	AttnTemp0 = Sts->RvsAttn2_LTE_A;
	AttnTemp1 = AttnOffsetTable->RvsAttn2_LTE_A.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn2_LTE_A = Sts->CurrRvsAttn2_LTE_A = AttnTemp0;
	if(CurrRvsAttn2_LTEA != Sts->CurrRvsAttn2_LTE_A)
	{
		CurrRvsAttn2_LTEA = Sts->CurrRvsAttn2_LTE_A;
		AttnDataOutput(_RvsAttn2_LTEA_SEL, Sts->CurrRvsAttn2_LTE_A);
	}

	AttnTemp0 = Sts->RvsAttn3_LTE_A;
	AttnTemp1 = AttnOffsetTable->RvsAttn3_LTE_A.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn3_LTE_A = Sts->CurrRvsAttn3_LTE_A = AttnTemp0;
	if(CurrRvsAttn3_LTEA != Sts->CurrRvsAttn3_LTE_A)
	{
		CurrRvsAttn3_LTEA = Sts->CurrRvsAttn3_LTE_A;
		AttnDataOutput(_RvsAttn3_LTEA_SEL, Sts->CurrRvsAttn3_LTE_A);
	}


/////////
	AttnTemp0 = Sts->FwdAttn1_WCDMALTE_21;
	AttnTemp1 = AttnOffsetTable->FwdAttn1_WCDMALTE_21.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.FwdAttn1_WCDMALTE_21 = Sts->CurrFwdAttn1_WCDMALTE_21 = AttnTemp0;
	if(CurrFwdAttn1_WCDMALTE_21 != Sts->CurrFwdAttn1_WCDMALTE_21)
	{
		CurrFwdAttn1_WCDMALTE_21 = Sts->CurrFwdAttn1_WCDMALTE_21;
		AttnDataOutput(_FwdAttn1_WCDMALTE_21_SEL, Sts->CurrFwdAttn1_WCDMALTE_21);
	}

	AttnTemp0 = Sts->RvsAttn1_WCDMALTE_21;
	AttnTemp1 = AttnOffsetTable->RvsAttn1_WCDMALTE_21.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn1_WCDMALTE_21 = Sts->CurrRvsAttn1_WCDMALTE_21= AttnTemp0;
	if(CurrRvsAttn1_WCDMALTE_21 != Sts->CurrRvsAttn1_WCDMALTE_21)
	{
		CurrRvsAttn1_WCDMALTE_21 = Sts->CurrRvsAttn1_WCDMALTE_21;
		AttnDataOutput(_RvsAttn1_WCDMALTE_21_SEL, Sts->CurrRvsAttn1_WCDMALTE_21);
	}

	AttnTemp0 = Sts->RvsAttn2_WCDMALTE_21;
	AttnTemp1 = AttnOffsetTable->RvsAttn2_WCDMALTE_21.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn2_WCDMALTE_21 = Sts->CurrRvsAttn2_WCDMALTE_21 = AttnTemp0;
	if(CurrRvsAttn2_WCDMALTE_21 != Sts->CurrRvsAttn2_WCDMALTE_21)
	{
		CurrRvsAttn2_WCDMALTE_21 = Sts->CurrRvsAttn2_WCDMALTE_21;
		AttnDataOutput(_RvsAttn2_WCDMALTE_21_SEL, Sts->CurrRvsAttn2_WCDMALTE_21);
	}

	AttnTemp0 = Sts->RvsAttn3_WCDMALTE_21;
	AttnTemp1 = AttnOffsetTable->RvsAttn3_WCDMALTE_21.Data[AttMaxLimit- AttnTemp0];	
	if(tAttAccu == 1) AttnTemp1 = 0;
	AttnTemp0 = AttnTemp0 + AttnTemp1;
	AttnTemp0 = MinMaxAttnCheck(AttnTemp0, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn3_WCDMALTE_21 = Sts->CurrRvsAttn3_WCDMALTE_21 = AttnTemp0;
	if(CurrRvsAttn3_WCDMALTE_21 != Sts->CurrRvsAttn3_WCDMALTE_21)
	{
		CurrRvsAttn3_WCDMALTE_21 = Sts->CurrRvsAttn3_WCDMALTE_21;
		AttnDataOutput(_RvsAttn3_WCDMALTE_21_SEL, Sts->CurrRvsAttn3_WCDMALTE_21);
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
		if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail)||(PwrAlarm.DigitalAlarm))
		{
			INT8U i;

			for(i = 0; i < DTU_Power_MAX; i++)
			{
				tDnrSts->DTUPeakPower[i].sD16	= DTUPwrNoSignal;
				tDnrSts->DTUAverPower[i].sD16	= DTUPwrNoSignal;
			}

			if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
			{
				AmpBitReason(PATH_3G, _Disable, __DCAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_2G, _Disable, __DCAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_LTE, _Disable, __DCAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_LTE_A2, _Disable, __DCAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_LTE_21, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			}
			else
			{
				AmpBitReason(PATH_3G, _Disable, __DigitlaBdAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_2G, _Disable, __DigitlaBdAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_LTE, _Disable, __DigitlaBdAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_LTE_A2, _Disable, __DigitlaBdAlarm, SD_AMP_OFF_INF);
				AmpBitReason(PATH_LTE_21, _Disable, __DigitlaBdAlarm, SD_AMP_OFF_INF);
			}

			for(i = 0; i < __PathMax; i++)
			{
				AmpPathOnOff(i,Disable);
			}
		}
		else
		{
			if(Sts->AlmSts.FwdAmpOnOff_2G == Enable)
			{
				AmpPathOnOff(__CDMA,Enable);
			}
			else
			{
				AmpPathOnOff(__CDMA,Disable);
			}

			if(Sts->AlmSts.FwdAmpOnOff_LTE== Enable)		
			{
				AmpPathOnOff(__LTE,Enable);
			}
			else
			{
				AmpPathOnOff(__LTE,Disable);
			}

			if((Sts->AlmSts.FwdAmpOnOff_2G == Disable)&&(Sts->AlmSts.FwdAmpOnOff_LTE == Disable))
			{
				AmpPathOnOff(__CDMALTE,Disable);
			}
			else
			{
				AmpPathOnOff(__CDMALTE,Enable);
			}


			if(Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Enable)
			{
				AmpPathOnOff(__LTE_A2,Enable);
			}
			else
			{
				AmpPathOnOff(__LTE_A2,Disable);
			}
 
			if(Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Disable)
			{
				AmpPathOnOff(__LTEA1_LTEA2,Disable);
			}
			else
			{
				AmpPathOnOff(__LTEA1_LTEA2,Enable);
			}


			if(Sts->AlmSts.FwdAmpOnOff_3G == Enable)		
			{
				AmpPathOnOff(__WCDMA,Enable);
			}
			else
			{
				AmpPathOnOff(__WCDMA,Disable);
			}

			if(Sts->AlmSts.FwdAmpOnOff_LTE_21 == Enable)		
			{
				AmpPathOnOff(__LTE_21,Enable);
			}
			else
			{
				AmpPathOnOff(__LTE_21,Disable);
			}

			if((Sts->AlmSts.FwdAmpOnOff_3G == Disable)&&(Sts->AlmSts.FwdAmpOnOff_LTE_21 == Disable))
			{
				AmpPathOnOff(__WCDMALTE_21,Disable);
			}
			else
			{
				AmpPathOnOff(__WCDMALTE_21,Enable);
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

	if(ChkBandSelet_CDMALTE)
	{
		INT32U tLocal = 0;
		INT16U WordByte = 0;

		WordByte = Sts->Band_Select_CDMALTE[1]*128 + Sts->Band_Select_CDMALTE[2];
	
		tLocal =  DL_FREQ_800M - DL_VCO_800M + WordByte*50 + Sts->PLLOffset[0]*50;
		Pll411x_Output(tLocal*1000, 0);

		OSTimeDly(50);

		tLocal =  DL_FREQ_800M - UL_VCO_800M + WordByte*50 + Sts->PLLOffset[0]*50;
			
		Pll411x_Output(tLocal*1000, 1);  ////1
		
		ChkBandSelet_CDMALTE = RESET;
	}

	if(ChkBandSelet_LTE_A)
	{
		INT32U tLocal = 0;

		INT16U WordByte = 0;

		WordByte = Sts->Band_Select_LTE_A[1]*128 + Sts->Band_Select_LTE_A[2];
	
		if(Sts->Band_Select_LTE_A[0] == 1)
		{
			tLocal =  DL_FREQ_1800M - DL_VCO_1800M_Mode1 + WordByte*50 + Sts->PLLOffset[1]*50;
		}
		else
		{
			tLocal =  DL_FREQ_1800M - DL_VCO_1800M_Mode0 + WordByte*50 + Sts->PLLOffset[1]*50;
		}
		Pll411x_Output(tLocal*1000, 2);   ///2 port
		ChkBandSelet_LTE_A = RESET;

//		Ser3Ptr->printf("ChkBandSelet_LTE_A [%d]\n",tLocal);
		
	}

	if(ChkBandSelet_WCDMALTE_21)
	{
		INT32U tLocal = 0;
		INT16U WordByte = 0;

		WordByte = Sts->Band_Select_WCDMALTE_21[1]*128 + Sts->Band_Select_WCDMALTE_21[2];
	
		tLocal =  DL_FREQ_2100M - DL_VCO_2100M + WordByte*50 + Sts->PLLOffset[2]*50;
		Pll411x_Output(tLocal *1000, 3);
		
		OSTimeDly(50);

#ifdef PLL_TEST_2_1G
		tLocal =  DL_FREQ_2100M - UL_VCO_2100M_Test+ WordByte*50 + Sts->PLLOffset[2]*50;
#else
		tLocal =  DL_FREQ_2100M - UL_VCO_2100M + WordByte*50 + Sts->PLLOffset[2]*50;
#endif
		Pll411x_Output(tLocal *1000, 4);
		ChkBandSelet_WCDMALTE_21 = RESET;
	}

	DTUStatustoIO();
}

void DTUStatustoIO(void)
{
    INT16S AttnTemp0 = 0;
	INT16S CurrGain = 0;
	
	__Dnr_Sts  *Sts = tDnrSts;


	if(IsItDTUInited != TRUE) return;
	
	{
		if(CurrFwdAttn1_2G != Sts->FwdAttn1_2G)
		{
			CurrFwdAttn1_2G = Sts->FwdAttn1_2G;
			DTU_WriteData(CS0SEL, DTU_DLLAGCGain_800M, DTU_INIT_GAIN - Sts->FwdAttn1_2G);
		}

		if(CurrFwdAttn1_LTE != Sts->FwdAttn1_LTE)
		{
			CurrFwdAttn1_LTE = Sts->FwdAttn1_LTE;
			DTU_WriteData(CS0SEL, DTU_DLRAGCGain_800M, DTU_INIT_GAIN - Sts->FwdAttn1_LTE);
		}

		if(CurrFwdAttn1_LTE_A1 != Sts->FwdAttn1_LTE_A1)
		{
			CurrFwdAttn1_LTE_A1 = Sts->FwdAttn1_LTE_A1;
			DTU_WriteData(CS0SEL, DTU_DLRAGCGain_1800M, DTU_INIT_GAIN - Sts->FwdAttn1_LTE_A1);
		}

		if(CurrFwdAttn1_LTE_A2 != Sts->FwdAttn1_LTE_A2)
		{
			CurrFwdAttn1_LTE_A2 = Sts->FwdAttn1_LTE_A2;
			DTU_WriteData(CS0SEL, DTU_DLLAGCGain_1800M, DTU_INIT_GAIN - Sts->FwdAttn1_LTE_A2);
		}

		if(CurrFwdAttn1_3G != Sts->FwdAttn1_3G)
		{
			CurrFwdAttn1_3G = Sts->FwdAttn1_3G;
			DTU_WriteData(CS0SEL, DTU_DLRAGCGain_2100M, DTU_INIT_GAIN - Sts->FwdAttn1_3G);
		}

		if(CurrFwdAttn1_LTE_21 != Sts->FwdAttn1_LTE_21)
		{
			CurrFwdAttn1_LTE_21 = Sts->FwdAttn1_LTE_21;
			DTU_WriteData(CS0SEL, DTU_DLLAGCGain_2100M, DTU_INIT_GAIN - Sts->FwdAttn1_LTE_21);
		}
	}

	{
		if(CurrRvsAttn1_2G != Sts->RvsAttn1_2G)
		{
			CurrRvsAttn1_2G = Sts->RvsAttn1_2G;
			DTU_WriteData(CS0SEL, DTU_ULLAGCGain_800M, DTU_INIT_GAIN - Sts->RvsAttn1_2G);
		}

		if(CurrRvsAttn1_LTE != Sts->RvsAttn1_LTE)
		{
			CurrRvsAttn1_LTE = Sts->RvsAttn1_LTE;
			DTU_WriteData(CS0SEL, DTU_ULRAGCGain_800M, DTU_INIT_GAIN - Sts->RvsAttn1_LTE);
		}

		if(CurrRvsAttn1_LTE_A1 != Sts->RvsAttn1_LTE_A1)
		{
			CurrRvsAttn1_LTE_A1 = Sts->RvsAttn1_LTE_A1;
			DTU_WriteData(CS0SEL, DTU_ULRAGCGain_1800M, DTU_INIT_GAIN - Sts->RvsAttn1_LTE_A1);
		}

		if(CurrRvsAttn1_LTE_A2 != Sts->RvsAttn1_LTE_A2)
		{
			CurrRvsAttn1_LTE_A2 = Sts->RvsAttn1_LTE_A2;
			DTU_WriteData(CS0SEL, DTU_ULLAGCGain_1800M, DTU_INIT_GAIN - Sts->RvsAttn1_LTE_A2);
		}

		if(CurrRvsAttn1_3G != Sts->RvsAttn1_3G)
		{
			CurrRvsAttn1_3G = Sts->RvsAttn1_3G;
			DTU_WriteData(CS0SEL, DTU_ULRAGCGain_2100M, DTU_INIT_GAIN - Sts->RvsAttn1_3G);
		}


		if(CurrRvsAttn1_LTE_21 != Sts->RvsAttn1_LTE_21)
		{
			CurrRvsAttn1_LTE_21 = Sts->RvsAttn1_LTE_21;
			DTU_WriteData(CS0SEL, DTU_ULLAGCGain_2100M, DTU_INIT_GAIN - Sts->RvsAttn1_LTE_21);
		}
	}
	
	{
		AttnTemp0 = Sts->FwdAttn2_2G;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->FwdGainOffset_2G + Sts->FwdTemp_CDMALTE;
		Sts->CurrFwdAttn2_2G = CurrGain - AttnTemp0;
		if(CurrFwdAttn2_2G != Sts->CurrFwdAttn2_2G)
		{
			CurrFwdAttn2_2G = Sts->CurrFwdAttn2_2G;
			DTU_WriteData(CS0SEL, DTU_DLLALCGain_800M, Sts->CurrFwdAttn2_2G);
		}

		AttnTemp0 = Sts->FwdAttn2_LTE;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->FwdGainOffset_LTE + Sts->FwdTemp_CDMALTE;
		Sts->CurrFwdAttn2_LTE = CurrGain - AttnTemp0;
		
		if(CurrFwdAttn2_LTE != Sts->CurrFwdAttn2_LTE)
		{
			CurrFwdAttn2_LTE = Sts->CurrFwdAttn2_LTE;
			DTU_WriteData(CS0SEL, DTU_DLRALCGain_800M, Sts->CurrFwdAttn2_LTE);
		}

		AttnTemp0 = Sts->FwdAttn2_LTE_A1;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->FwdGainOffset_LTE_A1 + Sts->FwdTemp_LTE_A;
		Sts->CurrFwdAttn2_LTE_A1 = CurrGain - AttnTemp0;
		if(CurrFwdAttn2_LTE_A1 != Sts->CurrFwdAttn2_LTE_A1)
		{
			CurrFwdAttn2_LTE_A1 = Sts->CurrFwdAttn2_LTE_A1;
			DTU_WriteData(CS0SEL, DTU_DLRALCGain_1800M, Sts->CurrFwdAttn2_LTE_A1);
		}

		AttnTemp0 = Sts->FwdAttn2_LTE_A2;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->FwdGainOffset_LTE_A2 + Sts->FwdTemp_LTE_A;
		Sts->CurrFwdAttn2_LTE_A2 = CurrGain - AttnTemp0;
		if(CurrFwdAttn2_LTE_A2 != Sts->CurrFwdAttn2_LTE_A2)
		{
			CurrFwdAttn2_LTE_A2 = Sts->CurrFwdAttn2_LTE_A2;
			DTU_WriteData(CS0SEL, DTU_DLLALCGain_1800M, Sts->CurrFwdAttn2_LTE_A2);
		}

		AttnTemp0 = Sts->FwdAttn2_3G;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->FwdGainOffset_3G + Sts->FwdTemp_WCDMALTE_21;
		Sts->CurrFwdAttn2_3G = CurrGain - AttnTemp0;
		if(CurrFwdAttn2_3G != Sts->CurrFwdAttn2_3G)
		{
			CurrFwdAttn2_3G = Sts->CurrFwdAttn2_3G;
			DTU_WriteData(CS0SEL, DTU_DLRALCGain_2100M, Sts->CurrFwdAttn2_3G);
		}

		AttnTemp0 = Sts->FwdAttn2_LTE_21;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->FwdGainOffset_LTE_21 + Sts->FwdTemp_WCDMALTE_21;
		Sts->CurrFwdAttn2_LTE_21 = CurrGain - AttnTemp0;

		if(CurrFwdAttn2_LTE_21 != Sts->CurrFwdAttn2_LTE_21)
		{
			CurrFwdAttn2_LTE_21 = Sts->CurrFwdAttn2_LTE_21;
			DTU_WriteData(CS0SEL, DTU_DLLALCGain_2100M, Sts->CurrFwdAttn2_LTE_21);
		}
	}

	{
		AttnTemp0 = Sts->RvsAttn2_2G;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->RvsGainOffset_2G + Sts->RvsTemp_CDMALTE;
		Sts->CurrRvsAttn2_2G = CurrGain- AttnTemp0;

		if(CurrRvsAttn2_2G != Sts->CurrRvsAttn2_2G)
		{
			CurrRvsAttn2_2G = Sts->CurrRvsAttn2_2G;
			DTU_WriteData(CS0SEL, DTU_ULLALCGain_800M, Sts->CurrRvsAttn2_2G);

		}

		AttnTemp0 = Sts->RvsAttn2_LTE;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->RvsGainOffset_LTE + Sts->RvsTemp_CDMALTE;
		Sts->CurrRvsAttn2_LTE = CurrGain- AttnTemp0;
		if(CurrRvsAttn2_LTE != Sts->CurrRvsAttn2_LTE)
		{
			CurrRvsAttn2_LTE = Sts->CurrRvsAttn2_LTE;
			DTU_WriteData(CS0SEL, DTU_ULRALCGain_800M, Sts->CurrRvsAttn2_LTE);
		}

		AttnTemp0 = Sts->RvsAttn2_LTE_A1;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->RvsGainOffset_LTE_A1 + Sts->RvsTemp_LTE_A;
		Sts->CurrRvsAttn2_LTE_A1 = CurrGain- AttnTemp0;
		if(CurrRvsAttn2_LTE_A1 != Sts->CurrRvsAttn2_LTE_A1)
		{
			CurrRvsAttn2_LTE_A1 = Sts->CurrRvsAttn2_LTE_A1;
			DTU_WriteData(CS0SEL, DTU_ULRALCGain_1800M, Sts->CurrRvsAttn2_LTE_A1);
		}

		AttnTemp0 = Sts->RvsAttn2_LTE_A2;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->RvsGainOffset_LTE_A2 + Sts->RvsTemp_LTE_A;
		Sts->CurrRvsAttn2_LTE_A2 = CurrGain- AttnTemp0;
		if(CurrRvsAttn2_LTE_A2 != Sts->CurrRvsAttn2_LTE_A2)
		{
			CurrRvsAttn2_LTE_A2 = Sts->CurrRvsAttn2_LTE_A2;
			DTU_WriteData(CS0SEL, DTU_ULLALCGain_1800M, Sts->CurrRvsAttn2_LTE_A2);
		}

		AttnTemp0 = Sts->RvsAttn2_3G;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->RvsGainOffset_3G + Sts->RvsTemp_WCDMALTE_21;
		Sts->CurrRvsAttn2_3G = CurrGain- AttnTemp0;
		
		if(CurrRvsAttn2_3G != Sts->CurrRvsAttn2_3G)
		{
			CurrRvsAttn2_3G = Sts->CurrRvsAttn2_3G;
			DTU_WriteData(CS0SEL, DTU_ULRALCGain_2100M, Sts->CurrRvsAttn2_3G);
		}

		AttnTemp0 = Sts->RvsAttn2_LTE_21;
		CurrGain = DTU_ATT2INIT_GAIN + Sts->RvsGainOffset_LTE_21 + Sts->RvsTemp_WCDMALTE_21;
		Sts->CurrRvsAttn2_LTE_21 = CurrGain- AttnTemp0;
		if(CurrRvsAttn2_LTE_21 != Sts->CurrRvsAttn2_LTE_21)
		{
			CurrRvsAttn2_LTE_21 = Sts->CurrRvsAttn2_LTE_21;
			DTU_WriteData(CS0SEL, DTU_ULLALCGain_2100M, Sts->CurrRvsAttn2_LTE_21);
		}
	}
}

void AttnBufferInit(void)
{
	CurrModemOnOff			= 0xFF;
	
	ChkBandSelet_CDMALTE		= SET;
	ChkBandSelet_LTE_A			= SET;
	ChkBandSelet_LTE_A			= SET;

	CurrFwdAttn1_2G 			= 0xff;
	CurrFwdAttn2_2G 			= 0xff;
	CurrRvsAttn1_2G 			= 0xff;
	CurrRvsAttn2_2G 			= 0xff;
	CurrFwdAttn1_LTE 			= 0xff;
	CurrFwdAttn2_LTE 			= 0xff;
	CurrRvsAttn1_LTE 			= 0xff;
	CurrRvsAttn2_LTE 			= 0xff;
	CurrFwdAttn1_CDMALTE 		= 0xff;	
	CurrRvsAttn1_CDMALTE 		= 0xff;	
	CurrRvsAttn2_CDMALTE 		= 0xff;	
	CurrRvsAttn3_CDMALTE 		= 0xff;	
	CurrFwdAttn1_LTE_A1			= 0xff; 
	CurrFwdAttn2_LTE_A1			= 0xff; 
	CurrRvsAttn1_LTE_A1			= 0xff; 
	CurrRvsAttn2_LTE_A1			= 0xff; 
	CurrFwdAttn1_LTE_A2 		= 0xff; 
	CurrFwdAttn2_LTE_A2 		= 0xff; 
	CurrRvsAttn1_LTE_A2 		= 0xff; 
	CurrRvsAttn2_LTE_A2 		= 0xff; 
	CurrFwdAttn1_LTEA			= 0xff; 
	CurrRvsAttn1_LTEA			= 0xff; 
	CurrRvsAttn2_LTEA			= 0xff; 
	CurrRvsAttn3_LTEA			= 0xff; 
	CurrFwdAttn1_3G 			= 0xff;	
	CurrFwdAttn2_3G 			= 0xff;	
	CurrRvsAttn1_3G 			= 0xff;	
	CurrRvsAttn2_3G 			= 0xff;	
	CurrFwdAttn1_LTE_21 		= 0xff; 
	CurrFwdAttn2_LTE_21 		= 0xff; 
	CurrRvsAttn1_LTE_21 		= 0xff; 
	CurrRvsAttn2_LTE_21 		= 0xff; 
	CurrFwdAttn1_WCDMALTE_21 	= 0xff;	
	CurrRvsAttn1_WCDMALTE_21 	= 0xff;	
	CurrRvsAttn2_WCDMALTE_21 	= 0xff;	
	CurrRvsAttn3_WCDMALTE_21 	= 0xff;	
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
			case _FwdAttn1_CDMALTE_SEL:			
				PCA9555BitSet(Fwd_Att1_CDMALTE,&AttnCS0Val); 
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_CDMALTE,&AttnCS0Val); 		
			break;

			case _RvsAttn1_CDMALTE_SEL:			
				PCA9555BitSet(Rvs_Att1_CDMALTE,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_CDMALTE,&AttnCS0Val); 		
			break;
			
			case _RvsAttn2_CDMALTE_SEL:			
				PCA9555BitSet(Rvs_Att2_CDMALTE,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_CDMALTE,&AttnCS0Val);		
			break;
			
			case _RvsAttn3_CDMALTE_SEL:			
				PCA9555BitSet(Rvs_Att3_CDMALTE,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_CDMALTE,&AttnCS0Val); 
			break;
////			
			case _FwdAttn1_LTEA_SEL: 		
				PCA9555BitSet(Fwd_Att1_LTEA,&AttnCS0Val); 
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTEA,&AttnCS0Val);		
			break;

			case _RvsAttn1_LTEA_SEL: 		
				PCA9555BitSet(Rvs_Att1_LTEA,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTEA,&AttnCS0Val);		
			break;
			
			case _RvsAttn2_LTEA_SEL: 		
				PCA9555BitSet(Rvs_Att2_LTEA,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTEA,&AttnCS0Val);		
			break;
			
			case _RvsAttn3_LTEA_SEL: 		
				PCA9555BitSet(Rvs_Att3_LTEA,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTEA,&AttnCS0Val); 
			break;
////
////			
			case _FwdAttn1_WCDMALTE_21_SEL:		
				PCA9555BitSet(Fwd_Att1_WCDMA,&AttnCS0Val); 
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_WCDMA,&AttnCS0Val);		
			break;

			case _RvsAttn1_WCDMALTE_21_SEL:		
				PCA9555BitSet(Rvs_Att1_WCDMA,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_WCDMA,&AttnCS0Val);		
			break;
			
			case _RvsAttn2_WCDMALTE_21_SEL:		
				PCA9555BitSet(Rvs_Att2_WCDMA,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_WCDMA,&AttnCS0Val);		
			break;
			
			case _RvsAttn3_WCDMALTE_21_SEL:		
				PCA9555BitSet(Rvs_Att3_WCDMA,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_WCDMA,&AttnCS0Val); 
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



INT16S MinMaxAttnCheck(INT16S cAttn, INT16S tMax, INT16S tMin)
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


INT16S RetPower(INT8S *tmp)
{
	INT16S rval;

	rval		= tmp[0]*2;
	if(tmp[1] >= 5)rval++;


	return (rval/1);
}

///////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////
