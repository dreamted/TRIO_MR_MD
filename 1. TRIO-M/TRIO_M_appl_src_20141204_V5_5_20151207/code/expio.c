
/*********************************************
* File Name          : exlib.c
* Author             :
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

//	ExpioPortInit();
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

extern u32 CurrINT;

void ExpioTask(void *p_arg)
{
	(void)p_arg;

	pPCA9555Port_Init(0);
	ADC_Select(0);
	TypeCheck();
	
	pPCASetPortData(Attn_CS0, (0),pPCA9555Str);
	pPCASetPortData(Attn_CS1, (0),pPCA9555Str);
	pPCASetPortData(Attn_CS2, (0),pPCA9555Str);
	pPCASetPortData(Attn_CS3, (0),pPCA9555Str);
	SMS_PWR = 0;

	_FWDRVS1PllInit();
	_FWDRVS2PllInit();
	_PllInit_LTE();

 	{
		AmpOnOff_CDMA = 0;
		AmpOnOff_WCDMA = 0;
		AmpOnOff_LTE_0 = 0;
		AmpOnOff_LTE_A1_0 = 0;
		AmpOnOff_LTE_A2_0 = 0;

		AmpOnOff_LTE_1 = 0;
		AmpOnOff_LTE_A1_1 = 0;
		AmpOnOff_LTE_A2_1 = 0;
	}
	OSTimeDly(500L);
	TimerRegist(Timer_AttnOut, Time1Sec*10L);
	TimerRegist(TimerAlmReport, Time1Sec*10L);	
	TimerRegist(Timer_Period, Time1Sec*2L);

	TimerRegist(Timer_ModemReset, Time1Day*1L);
	TimerRegist(Timer_RvsOSCAlarmCount, Time1Day*1L);

 	while(1)
	{
		while((WRCS_DownLoadGiveupTimerSet(NULL)))
		{
			FrontLEDDisplay();
			OSTimeDly(1000L);
		}
		while(!WRCS_DownLoadGiveupTimerSet(NULL) && !tTestFlag)
		{
			ReadAdcValue_TRIO();
			if(ChkAttChange == RESET)	AGCCheckFunction();
			
			StatustoIO();
			Period_Check();

			if(TimeOverCheck(TimerAlmReport))
			{
				chkReport = SET;
			}
			

//			OSTimeDly(200L);
			OSTimeDly(400L);
		}
		OSTimeDly(500L);
	}
}

void ResetStart(void)
{
	TimerRegist(TimerReset, Time1Sec);
}

INT8U F_RESET_IN_Read(void)
{
    return 0;
}

void Period_Check(void)
{
	if(!TimeOverCheck(Timer_Period)) return;
	TimerRegist(Timer_Period, Time100mSec*5L);
//	RvsSleepMode(); 	//////////20130319

	AlarmCheck();	//////
	if((tDnrSts->ModuleAlarm.Main.DCFail == Normal)&&(PwrAlarm.ACFail == Normal))
//	if((PwrAlarm.ACFail == Normal))
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
	
//	FrontLEDDisplay();

//	if(ChkAttChange == RESET)	AGCCheckFunction();
	if(++PeriodCnt >= 2)
	{
 		PeriodCnt = 0;
//		ShutDownCheck();	
		FrontLEDDisplay();
		
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
//		Chk_Reset = SET;
#if 0		
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

		if((tDnrSts->ShutDownOnOff_LTE_A1 == _Enable)&&(tDnrSts->Band_Select_LTE_A1 == __USE))
		{
			ShutdownFunc(PATH_LTE_A1, SD_FI_LTE_A1);
			ShutdownFunc(PATH_LTE_A1, SD_FO_LTE_A1);
			ShutdownFunc(PATH_LTE_A1, SD_RO_LTE_A1);
		}

		if((tDnrSts->ShutDownOnOff_LTE_A2 == _Enable)&&(tDnrSts->Band_Select_LTE_A2[0] == __USE))
		{
			ShutdownFunc(PATH_LTE_A2, SD_FI_LTE_A2);
			ShutdownFunc(PATH_LTE_A2, SD_FO_LTE_A2);
			ShutdownFunc(PATH_LTE_A2, SD_RO_LTE_A2);
		}

		if(iRepeaterType == _TRIO_MM)
		{
			if(tDnrSts->ShutDownOnOff_LTE1 == _Enable)
			{
				ShutdownFunc(PATH_LTE_1, SD_FI_LTE_1);
				ShutdownFunc(PATH_LTE_1, SD_FO_LTE_1);
				ShutdownFunc(PATH_LTE_1, SD_RO_LTE_1);
			}

			if((tDnrSts->ShutDownOnOff_LTE_A1_1 == _Enable)&&(tDnrSts->Band_Select_LTE_A1 == __USE))
			{
				ShutdownFunc(PATH_LTE_A1_1, SD_FI_LTE_A1_1);
				ShutdownFunc(PATH_LTE_A1_1, SD_FO_LTE_A1_1);
				ShutdownFunc(PATH_LTE_A1_1, SD_RO_LTE_A1_1);
			}
			
			if((tDnrSts->ShutDownOnOff_LTE_A2_1 == _Enable)&&(tDnrSts->Band_Select_LTE_A2[0] == __USE))
			{
				ShutdownFunc(PATH_LTE_A2_1, SD_FI_LTE_A2_1);
				ShutdownFunc(PATH_LTE_A2_1, SD_FO_LTE_A2_1);
				ShutdownFunc(PATH_LTE_A2_1, SD_RO_LTE_A2_1);
			}
		}
	}
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

void FrontLEDSet(INT8U tindex, INT8U tstatus)
{
	LEDStatus[tindex%LED_SelMax] = tstatus;
}

void FrontLEDDisplay(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	if(tDnrSts->AlmSts.ACFail)
	{
		GreenLED_CDMA		= 0;
		RedLED_CDMA 		= 0;

		GreenLED_LTE		= 0;
		RedLED_LTE			= 0;	

		GreenLED_LTE_A1_0	= 0;
		RedLED_LTE_A1_0		= 0;
		
		GreenLED_LTE_A2_0	= 0;
		RedLED_LTE_A2_0		= 0;

		GreenLED_WCDMA		= 0;
		RedLED_WCDMA		= 0;
		
		GreenLED_LTE_1		= 0;
		RedLED_LTE_1		= 0;	

		GreenLED_LTE_A1_1	= 0;
		RedLED_LTE_A1_1		= 0;
		
		GreenLED_LTE_A2_1	= 0;
		RedLED_LTE_A2_1		= 0;
	}	
	else
	{

		if(tDnrSts->LTE15MUse == __NOTUSE)
		{
			if(((Sd_Step[SD_FI_2G]>= 1)&&(Sd_Step[SD_FI_2G]< 30))
				||((Sd_Step[SD_FO_2G]>= 1)&&(Sd_Step[SD_FO_2G]< 30))
				||((Sd_Step[SD_RO_2G]>= 1)&&(Sd_Step[SD_RO_2G]< 30)))
			{
				if(RedLEDFlag_2G)
				{
					GreenLED_CDMA		= 0;
					RedLED_CDMA 		= 1;
				}
				else
				{
					GreenLED_CDMA		= 0;
					RedLED_CDMA 		= 0;
				}
				RedLEDFlag_2G ^= 1;
			}
			else if(((Sd_Step[SD_FI_2G]== 30)||(Sd_Step[SD_FO_2G]== 30)||(Sd_Step[SD_RO_2G]== 30))
				||(tDnrSts->AlmSts.FwdAmpOnOff_2G== Disable))
			{
				GreenLED_CDMA		= 0;
				RedLED_CDMA 		= 1;
			}
			else
			{
				if((tDnrSts->AlmSts.FwdOutLowerLmtFail_2G == Alarm) &&(LimitAlarmCnt[PATH_2G]< AlarmCheckTime)
				&&(LimitAlarmCnt[PATH_2G]> StartAlarmCheckTime))
				{
					if(YellowLEDFlag_2G)
					{
						GreenLED_CDMA		= 1;
						RedLED_CDMA 		= 1;
					}
					else
					{
						GreenLED_CDMA		= 0;
						RedLED_CDMA 		= 0;
					}
					YellowLEDFlag_2G ^= 1;
				}
				else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_2G == Alarm) &&(LimitAlarmCnt[PATH_2G]== AlarmCheckTime))
					||((tDnrSts->AlmSts.OverInAlarm_CDMALTE == Alarm)&&(CurrAlarm.OverInAlarm_CDMALTE_1 == Alarm))

					||(tDnrSts->AlmSts.FwdInUpperLmtFail_2G == Alarm))
				{
					GreenLED_CDMA		= 1;
					RedLED_CDMA 		= 1;
				}
				else
				{
					GreenLED_CDMA		= 1;  
					RedLED_CDMA 		= 0; 
				}
			}
		}
		else
		{
			GreenLED_CDMA		= 0;  
			RedLED_CDMA 		= 0; 
		}		
		

///////////////  LTE
		if(Sts->FemtocellUseOnOff.LTE == __NOTUSE)
		{
			if(((Sd_Step[SD_FI_LTE]>= 1)&&(Sd_Step[SD_FI_LTE]< 30))
				||((Sd_Step[SD_FO_LTE]>= 1)&&(Sd_Step[SD_FO_LTE]< 30))
				||((Sd_Step[SD_RO_LTE]>= 1)&&(Sd_Step[SD_RO_LTE]< 30)))
			{
				if(RedLEDFlag_LTE)
				{
					GreenLED_LTE	= 0;
					RedLED_LTE		= 1;
				}
				else
				{
					GreenLED_LTE	= 0;
					RedLED_LTE 		= 0;
				}
				RedLEDFlag_LTE ^= 1;
			}
			else if(((Sd_Step[SD_FI_LTE]== 30)||(Sd_Step[SD_FO_LTE]== 30)||(Sd_Step[SD_RO_LTE]== 30))
				||(tDnrSts->AlmSts.FwdAmpOnOff_LTE== Disable))
			{
				GreenLED_LTE		= 0;
				RedLED_LTE 			= 1;
			}
			else
			{
				if((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE == Alarm) &&(LimitAlarmCnt[PATH_LTE]< AlarmCheckTime)
					&&(LimitAlarmCnt[PATH_LTE]> StartAlarmCheckTime))
				{
					if(YellowLEDFlag_LTE)
					{
						GreenLED_LTE	= 1;
						RedLED_LTE 		= 1;
					}
					else
					{
						GreenLED_LTE	= 0;
						RedLED_LTE 		= 0;
					}
					YellowLEDFlag_LTE ^= 1;
				}
				else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE == Alarm) &&(LimitAlarmCnt[PATH_LTE]== AlarmCheckTime))
					||((tDnrSts->AlmSts.OverInAlarm_CDMALTE == Alarm)&&(CurrAlarm.OverInAlarm_CDMALTE_2 == Alarm))
					||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE == Alarm))
				{
					GreenLED_LTE	= 1;
					RedLED_LTE 		= 1;
				}
				else
				{
					GreenLED_LTE	= 1;  
					RedLED_LTE 		= 0; 
				}
			}
		}
		else
		{
			GreenLED_LTE	= 0;  
			RedLED_LTE 		= 0; 
		}
///////////////  LTE_A1
		if(tDnrSts->Band_Select_LTE_A1 == __NOTUSE)
		{
			GreenLED_LTE_A1_0	= 0;  
			RedLED_LTE_A1_0		= 0; 
		}
		else if((Sts->FemtocellUseOnOff.LTE_A1 == __NOTUSE))
		{
			if(((Sd_Step[SD_FI_LTE_A1]>= 1)&&(Sd_Step[SD_FI_LTE_A1]< 30))
				||((Sd_Step[SD_FO_LTE_A1]>= 1)&&(Sd_Step[SD_FO_LTE_A1]< 30))
				||((Sd_Step[SD_RO_LTE_A1]>= 1)&&(Sd_Step[SD_RO_LTE_A1]< 30)))
			{
				if(RedLEDFlag_LTE_A1)
				{
					GreenLED_LTE_A1_0	= 0;
					RedLED_LTE_A1_0		= 1;
				}
				else
				{
					GreenLED_LTE_A1_0	= 0;
					RedLED_LTE_A1_0		= 0;
				}
				RedLEDFlag_LTE_A1 ^= 1;
			}
			else if(((Sd_Step[SD_FI_LTE_A1]== 30)||(Sd_Step[SD_FO_LTE_A1]== 30)||(Sd_Step[SD_RO_LTE_A1]== 30))
				||(tDnrSts->AlmSts.FwdAmpOnOff_LTE_A1== Disable))
			{
				GreenLED_LTE_A1_0		= 0;
				RedLED_LTE_A1_0			= 1;
			}
			else
			{
				if((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A1 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A1]< AlarmCheckTime)
				&&(LimitAlarmCnt[PATH_LTE_A1]> StartAlarmCheckTime))
				{
					if(YellowLEDFlag_LTE_A1)
					{
						GreenLED_LTE_A1_0	= 1;
						RedLED_LTE_A1_0		= 1;
					}
					else
					{
						GreenLED_LTE_A1_0	= 0;
						RedLED_LTE_A1_0		= 0;
					}
					YellowLEDFlag_LTE_A1 ^= 1;
				}
				else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A1 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A1]== AlarmCheckTime))
//					||(tDnrSts->AlmSts.OverInAlarm_LTE_A		== Alarm)
					||((tDnrSts->AlmSts.OverInAlarm_LTE_A == Alarm)&&(CurrAlarm.OverInAlarm_LTE_A1 == Alarm))
					||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE_A1 == Alarm))
				{
					GreenLED_LTE_A1_0	= 1;
					RedLED_LTE_A1_0		= 1;
				}
				else
				{
					GreenLED_LTE_A1_0	= 1;  
					RedLED_LTE_A1_0		= 0; 
				}
			}
		}
		else
		{
			GreenLED_LTE_A1_0	= 0;  
			RedLED_LTE_A1_0		= 0; 
		}		
///////////////
///////////////  LTE_A2
		if(tDnrSts->Band_Select_LTE_A2[0] == __NOTUSE)
		{
			GreenLED_LTE_A2_0	= 0;  
			RedLED_LTE_A2_0 	= 0; 
		}
		else if((Sts->FemtocellUseOnOff.LTE_A2 == __NOTUSE))
		{
			if(((Sd_Step[SD_FI_LTE_A2]>= 1)&&(Sd_Step[SD_FI_LTE_A2]< 30))
				||((Sd_Step[SD_FO_LTE_A2]>= 1)&&(Sd_Step[SD_FO_LTE_A2]< 30))
				||((Sd_Step[SD_RO_LTE_A2]>= 1)&&(Sd_Step[SD_RO_LTE_A2]< 30)))
			{
				if(RedLEDFlag_LTE_A2)
				{
					GreenLED_LTE_A2_0	= 0;
					RedLED_LTE_A2_0 	= 1;
				}
				else
				{
					GreenLED_LTE_A2_0	= 0;
					RedLED_LTE_A2_0 	= 0;
				}
				RedLEDFlag_LTE_A2 ^= 1;
			}
			else if(((Sd_Step[SD_FI_LTE_A2]== 30)||(Sd_Step[SD_FO_LTE_A2]== 30)||(Sd_Step[SD_RO_LTE_A2]== 30))
				||(tDnrSts->AlmSts.FwdAmpOnOff_LTE_A2== Disable))
			{
				GreenLED_LTE_A2_0		= 0;
				RedLED_LTE_A2_0 		= 1;
			}
			else
			{
				if((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A2 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A2]< AlarmCheckTime)
				&&(LimitAlarmCnt[PATH_LTE_A2]> StartAlarmCheckTime))
				{
					if(YellowLEDFlag_LTE_A2)
					{
						GreenLED_LTE_A2_0	= 1;
						RedLED_LTE_A2_0 	= 1;
					}
					else
					{
						GreenLED_LTE_A2_0	= 0;
						RedLED_LTE_A2_0 	= 0;
					}
					YellowLEDFlag_LTE_A2 ^= 1;
				}
				else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_LTE_A2 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A2]== AlarmCheckTime))
//					||(tDnrSts->AlmSts.OverInAlarm_LTE_A		== Alarm)

					||((tDnrSts->AlmSts.OverInAlarm_LTE_A == Alarm)&&(CurrAlarm.OverInAlarm_LTE_A2	== Alarm))

					||(tDnrSts->AlmSts.FwdInUpperLmtFail_LTE_A2 == Alarm))
				{
					GreenLED_LTE_A2_0	= 1;
					RedLED_LTE_A2_0 	= 1;
				}
				else
				{
					GreenLED_LTE_A2_0	= 1;  
					RedLED_LTE_A2_0 	= 0; 
				}
			}
		}
		else
		{
			GreenLED_LTE_A2_0	= 0;  
			RedLED_LTE_A2_0 	= 0; 
		}		
///////////////
///////////////  WCDMA
		{
			if(((Sd_Step[SD_FI_3G]>= 1)&&(Sd_Step[SD_FI_3G]< 30))
				||((Sd_Step[SD_FO_3G]>= 1)&&(Sd_Step[SD_FO_3G]< 30))
				||((Sd_Step[SD_RO_3G]>= 1)&&(Sd_Step[SD_RO_3G]< 30)))
			{
				if(RedLEDFlag_3G)
				{
					GreenLED_WCDMA	= 0;
					RedLED_WCDMA 	= 1;
				}
				else
				{
					GreenLED_WCDMA	= 0;
					RedLED_WCDMA 	= 0;
				}
				RedLEDFlag_3G ^= 1;
			}
			else if(((Sd_Step[SD_FI_3G]== 30)||(Sd_Step[SD_FO_3G]== 30)||(Sd_Step[SD_RO_3G]== 30))
				||(tDnrSts->AlmSts.FwdAmpOnOff_3G== Disable))
			{
				GreenLED_WCDMA		= 0;
				RedLED_WCDMA 		= 1;
			}
			else
			{
				if((tDnrSts->AlmSts.FwdOutLowerLmtFail_3G == Alarm) &&(LimitAlarmCnt[PATH_3G]< AlarmCheckTime)
				&&(LimitAlarmCnt[PATH_3G]> StartAlarmCheckTime))
				{
					if(YellowLEDFlag_3G)
					{
						GreenLED_WCDMA	= 1;
						RedLED_WCDMA 	= 1;
					}
					else
					{
						GreenLED_WCDMA	= 0;
						RedLED_WCDMA 	= 0;
					}
					YellowLEDFlag_3G ^= 1;
				}
				else if(((tDnrSts->AlmSts.FwdOutLowerLmtFail_3G == Alarm) &&(LimitAlarmCnt[PATH_3G]== AlarmCheckTime))
					||(tDnrSts->AlmSts.OverInAlarm_3G		== Alarm)
					||(tDnrSts->AlmSts.FwdInUpperLmtFail_3G == Alarm))
				{
					GreenLED_WCDMA	= 1;
					RedLED_WCDMA 	= 1;
				}
				else
				{
					GreenLED_WCDMA	= 1;  
					RedLED_WCDMA 	= 0; 
				}
			}
		}

///////////////
		if(iRepeaterType == _TRIO_MM)
		{
			if((Sts->FemtocellUseOnOff.LTE_1 == __NOTUSE))
			{
				if(((Sd_Step[SD_FI_LTE_1]>= 1)&&(Sd_Step[SD_FI_LTE_1]< 30))
					||((Sd_Step[SD_FO_LTE_1]>= 1)&&(Sd_Step[SD_FO_LTE_1]< 30))
					||((Sd_Step[SD_RO_LTE_1]>= 1)&&(Sd_Step[SD_RO_LTE_1]< 30)))
				{
					if(RedLEDFlag_LTE_1)
					{
						GreenLED_LTE_1	= 0;
						RedLED_LTE_1		= 1;
					}
					else
					{
						GreenLED_LTE_1	= 0;
						RedLED_LTE_1		= 0;
					}
					RedLEDFlag_LTE_1 ^= 1;
				}
				else if(((Sd_Step[SD_FI_LTE_1]== 30)||(Sd_Step[SD_FO_LTE_1]== 30)||(Sd_Step[SD_RO_LTE_1]== 30))
					||(tDnrSts->AlmSts.FwdAmp1OnOff_LTE== Disable))
				{
					GreenLED_LTE_1		= 0;
					RedLED_LTE_1			= 1;
				}
				else
				{
					if((tDnrSts->AlmSts.Fwd1OutLowerLmtFail_LTE == Alarm) &&(LimitAlarmCnt[PATH_LTE_1]< AlarmCheckTime)
						&&(LimitAlarmCnt[PATH_LTE_1]> StartAlarmCheckTime))
					{
						if(YellowLEDFlag_LTE_1)
						{
							GreenLED_LTE_1	= 1;
							RedLED_LTE_1	= 1;
						}
						else
						{
							GreenLED_LTE_1	= 0;
							RedLED_LTE_1		= 0;
						}
						YellowLEDFlag_LTE_1 ^= 1;
					}
					else if(((tDnrSts->AlmSts.Fwd1OutLowerLmtFail_LTE == Alarm) &&(LimitAlarmCnt[PATH_LTE_1]== AlarmCheckTime))
						||(CurrAlarm.OverInAlarm_LTE_1				== Alarm)
						||(tDnrSts->AlmSts.Fwd1InUpperLmtFail_LTE 	== Alarm))
					{
						GreenLED_LTE_1		= 1;
						RedLED_LTE_1		= 1;
					}
					else
					{
						GreenLED_LTE_1		= 1;  
						RedLED_LTE_1		= 0; 
					}
				}
			}
			else
			{
				GreenLED_LTE_1		= 0;  
				RedLED_LTE_1		= 0; 
			}

	///////////////  LTE_A2
			if(tDnrSts->Band_Select_LTE_A1 == __NOTUSE)
			{
				GreenLED_LTE_A1_1	= 0;  
				RedLED_LTE_A1_1 	= 0; 
			}
			else if((Sts->FemtocellUseOnOff.LTE_A1_1 == __NOTUSE))
			{
				if(((Sd_Step[SD_FI_LTE_A1_1]>= 1)&&(Sd_Step[SD_FI_LTE_A1_1]< 30))
					||((Sd_Step[SD_FO_LTE_A1_1]>= 1)&&(Sd_Step[SD_FO_LTE_A1_1]< 30))
					||((Sd_Step[SD_RO_LTE_A1_1]>= 1)&&(Sd_Step[SD_RO_LTE_A1_1]< 30)))
				{
					if(RedLEDFlag_LTE_A1_1)
					{
						GreenLED_LTE_A1_1	= 0;
						RedLED_LTE_A1_1 	= 1;
					}
					else
					{
						GreenLED_LTE_A1_1	= 0;
						RedLED_LTE_A1_1 	= 0;
					}
					RedLEDFlag_LTE_A1_1 ^= 1;
				}
				else if(((Sd_Step[SD_FI_LTE_A1_1]== 30)||(Sd_Step[SD_FO_LTE_A1_1]== 30)||(Sd_Step[SD_RO_LTE_A1_1]== 30))
					||(tDnrSts->AlmSts.FwdAmp1OnOff_LTE_A1== Disable))
				{
					GreenLED_LTE_A1_1		= 0;
					RedLED_LTE_A1_1 		= 1;
				}
				else
				{
					if((tDnrSts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A1_1]< AlarmCheckTime)
					&&(LimitAlarmCnt[PATH_LTE_A1_1]> StartAlarmCheckTime))
					{
						if(YellowLEDFlag_LTE_A1_1)
						{
							GreenLED_LTE_A1_1	= 1;
							RedLED_LTE_A1_1 	= 1;
						}
						else
						{
							GreenLED_LTE_A1_1	= 0;
							RedLED_LTE_A1_1 	= 0;
						}
						YellowLEDFlag_LTE_A1_1 ^= 1;
					}
					else if(((tDnrSts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A1_1]== AlarmCheckTime))
						||((tDnrSts->AlmSts.OverInAlarm_LTE_A == Alarm)&&(CurrAlarm.OverInAlarm_LTE_A1_1 == Alarm))
						||(tDnrSts->AlmSts.Fwd1InUpperLmtFail_LTE_A1 == Alarm))
					{
						GreenLED_LTE_A1_1	= 1;
						RedLED_LTE_A1_1 	= 1;
					}
					else
					{
						GreenLED_LTE_A1_1	= 1;  
						RedLED_LTE_A1_1 	= 0; 
					}
				}
			}
			else
			{
				GreenLED_LTE_A1_1	= 0;  
				RedLED_LTE_A1_1 	= 0; 
			}		
	///////////////
	///////////////  LTE_A2
			if(tDnrSts->Band_Select_LTE_A2[0] == __NOTUSE)
			{
				GreenLED_LTE_A2_1	= 0;  
				RedLED_LTE_A2_1 	= 0; 
			}
			else if((Sts->FemtocellUseOnOff.LTE_A2_1 == __NOTUSE))
			{
				if(((Sd_Step[SD_FI_LTE_A2_1]>= 1)&&(Sd_Step[SD_FI_LTE_A2_1]< 30))
					||((Sd_Step[SD_FO_LTE_A2_1]>= 1)&&(Sd_Step[SD_FO_LTE_A2_1]< 30))
					||((Sd_Step[SD_RO_LTE_A2_1]>= 1)&&(Sd_Step[SD_RO_LTE_A2_1]< 30)))
				{
					if(RedLEDFlag_LTE_A2_1)
					{
						GreenLED_LTE_A2_1	= 0;
						RedLED_LTE_A2_1 	= 1;
					}
					else
					{
						GreenLED_LTE_A2_1	= 0;
						RedLED_LTE_A2_1 	= 0;
					}
					RedLEDFlag_LTE_A2_1 ^= 1;
				}
				else if(((Sd_Step[SD_FI_LTE_A2_1]== 30)||(Sd_Step[SD_FO_LTE_A2_1]== 30)||(Sd_Step[SD_RO_LTE_A2_1]== 30))
					||(tDnrSts->AlmSts.FwdAmp1OnOff_LTE_A2 == Disable))
				{
					GreenLED_LTE_A2_1		= 0;
					RedLED_LTE_A2_1 		= 1;
				}
				else
				{
					if((tDnrSts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A2_1]< AlarmCheckTime)
					&&(LimitAlarmCnt[PATH_LTE_A2_1]> StartAlarmCheckTime))
					{
						if(YellowLEDFlag_LTE_A2_1)
						{
							GreenLED_LTE_A2_1	= 1;
							RedLED_LTE_A2_1 	= 1;
						}
						else
						{
							GreenLED_LTE_A2_1	= 0;
							RedLED_LTE_A2_1 	= 0;
						}
						YellowLEDFlag_LTE_A2_1 ^= 1;
					}
					else if(((tDnrSts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2 == Alarm) &&(LimitAlarmCnt[PATH_LTE_A2_1]== AlarmCheckTime))
						||((tDnrSts->AlmSts.OverInAlarm_LTE_A == Alarm)&&(CurrAlarm.OverInAlarm_LTE_A2_1 == Alarm))
						||(tDnrSts->AlmSts.Fwd1InUpperLmtFail_LTE_A2 == Alarm))
					{
						GreenLED_LTE_A2_1	= 1;
						RedLED_LTE_A2_1 	= 1;
					}
					else
					{
						GreenLED_LTE_A2_1	= 1;  
						RedLED_LTE_A2_1 	= 0; 
					}
				}
			}
			else
			{
				GreenLED_LTE_A2_1	= 0;  
				RedLED_LTE_A2_1 	= 0; 
			}
		}
	}
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

INT8S DnrReferToTable(INT8U TblID,INT8U AttTemp,INT8U tAttAccuOnOff)
{
	INT8S tLocation = 0;

	INT8S tAttTemp = 0;
	INT8S AccuAttTemp = 0;
	INT8S tIndex = 0;

	tLocation = AttnTableLocation(TblID);
	tIndex = TableIndex(TblID);

	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	if(tAttAccuOnOff == Disable) return AttTemp;

	
	if(tLocation == _SvrAttn_Location)
	{
		AccuAttTemp = vEE_BACK1->SvrAttnTbl[tIndex].Data[AttMaxLimit- AttTemp];

	}
	else
	{
		AccuAttTemp = vSYS_TABLE->DnrAttnTbl[tIndex].Data[AttMaxLimit- AttTemp];
		if(DnrAttnTblAlarm[tIndex])AccuAttTemp = 0;
	}
	
	tAttTemp = AttTemp + AccuAttTemp;

	tAttTemp = MinMaxAttnCheck(tAttTemp, DIGATTENMAX,ATTENMIN);
	return tAttTemp;
}

void AttAccuChange(void)
{
	__Dnr_Sts  *Sts = tDnrSts;

	INT8S AttTemp = 0;
	
	//////////////////////////////////CDMA
	
	AttTemp = Sts->FwdAttn1_2G;
	Sts->AttValue.FwdAttn1_2G = Sts->CurrFwdAttn1_2G =DnrReferToTable(Index_FwdAttn1_2G,AttTemp,tAttAccu);

	AttTemp = Sts->FwdAttn2_2G + Sts->FwdGainOffset_2G + Sts->FwdTemp_2G;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.FwdAttn2_2G = Sts->CurrFwdAttn2_2G =DnrReferToTable(Index_FwdAttn2_2G,AttTemp,tAttAccu);

	AttTemp = Sts->RvsAttn1_2G + Sts->RvsTemp_2G + Sts->RvsGainOffset_2G + Sts->AttOffset.RvsAttn1_2G;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn1_2G = Sts->CurrRvsAttn1_2G = DnrReferToTable(Index_RvsAttn1_2G,AttTemp,tAttAccu);

	AttTemp = Sts->RvsAttn2_2G;
	Sts->AttValue.RvsAttn2_2G = Sts->CurrRvsAttn2_2G = DnrReferToTable(Index_RvsAttn2_2G,AttTemp,tAttAccu);
	
	AttTemp = Sts->RvsAttn3_2G;
	Sts->AttValue.RvsAttn3_2G = Sts->CurrRvsAttn3_2G = DnrReferToTable(Index_RvsAttn3_2G,AttTemp,tAttAccu);
	
//////////////////////////////////LTE

	AttTemp = Sts->FwdAttn1_LTE;
	Sts->AttValue.FwdAttn1_LTE = Sts->CurrFwdAttn1_LTE = DnrReferToTable(Index_FwdAttn1_LTE,AttTemp,tAttAccu);

	AttTemp = Sts->FwdAttn2_LTE + Sts->FwdGainOffset_LTE + Sts->FwdTemp_LTE ;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.FwdAttn2_LTE = Sts->CurrFwdAttn2_LTE = DnrReferToTable(Index_FwdAttn2_LTE,AttTemp,tAttAccu);


	AttTemp = Sts->RvsAttn1_LTE + Sts->RvsTemp_LTE + Sts->RvsGainOffset_LTE;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn1_LTE = Sts->CurrRvsAttn1_LTE = DnrReferToTable(Index_RvsAttn1_LTE,AttTemp,tAttAccu);

	AttTemp = Sts->RvsAttn2_LTE; 
	Sts->AttValue.RvsAttn2_LTE = Sts->CurrRvsAttn2_LTE = DnrReferToTable(Index_RvsAttn2_LTE,AttTemp,tAttAccu);
	
	AttTemp = Sts->RvsAttn3_LTE;
	Sts->AttValue.RvsAttn3_LTE = Sts->CurrRvsAttn3_LTE = DnrReferToTable(Index_RvsAttn3_LTE,AttTemp,tAttAccu);

	//////////////////// CDMA/LTE Common
	AttTemp = Sts->FwdAttn1_CDMALTE;
	Sts->AttValue.FwdAttn1_CDMALTE = Sts->CurrFwdAttn1_CDMALTE = DnrReferToTable(Index_FwdAttn1_CDMALTE,AttTemp,tAttAccu);

	AttTemp = Sts->RvsAttn1_CDMALTE;
	Sts->AttValue.RvsAttn1_CDMALTE = Sts->CurrRvsAttn1_CDMALTE = DnrReferToTable(Index_RvsAttn1_CDMALTE,AttTemp,tAttAccu);

	//////////////////// LTE-A1
	AttTemp = Sts->FwdAttn1_LTE_A1;
	Sts->AttValue.FwdAttn1_LTE_A1 = Sts->CurrFwdAttn1_LTE_A1 = DnrReferToTable(Index_FwdAttn1_LTE_A1,AttTemp,tAttAccu);
	

	AttTemp = Sts->FwdAttn2_LTE_A1 + Sts->FwdGainOffset_LTE_A1 + Sts->FwdTemp_LTE_A1;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.FwdAttn2_LTE_A1 = Sts->CurrFwdAttn2_LTE_A1 = DnrReferToTable(Index_FwdAttn2_LTE_A1,AttTemp,tAttAccu);
	

	AttTemp = Sts->RvsAttn1_LTE_A1 + Sts->RvsGainOffset_LTE_A1 + Sts->RvsTemp_LTE_A1;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn1_LTE_A1 = Sts->CurrRvsAttn1_LTE_A1 = DnrReferToTable(Index_RvsAttn1_LTE_A1,AttTemp,tAttAccu);
	
	AttTemp = Sts->RvsAttn2_LTE_A1;
	Sts->AttValue.RvsAttn2_LTE_A1 = Sts->CurrRvsAttn2_LTE_A1 = DnrReferToTable(Index_RvsAttn2_LTE_A1,AttTemp,tAttAccu);
	

	AttTemp = Sts->RvsAttn3_LTE_A1;
	Sts->AttValue.RvsAttn3_LTE_A1 = Sts->CurrRvsAttn3_LTE_A1 = DnrReferToTable(Index_RvsAttn3_LTE_A1,AttTemp,tAttAccu);

////////////////////////////////////////////////////////////////////////////
	//////////////////// LTE-A2
	AttTemp = Sts->FwdAttn1_LTE_A2;
	Sts->AttValue.FwdAttn1_LTE_A2 = Sts->CurrFwdAttn1_LTE_A2 = DnrReferToTable(Index_FwdAttn1_LTE_A2,AttTemp,tAttAccu);
	

	AttTemp = Sts->FwdAttn2_LTE_A2 + Sts->FwdGainOffset_LTE_A2 + Sts->FwdTemp_LTE_A2;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.FwdAttn2_LTE_A2 = Sts->CurrFwdAttn2_LTE_A2 = DnrReferToTable(Index_FwdAttn2_LTE_A2,AttTemp,tAttAccu);
	

	AttTemp = Sts->RvsAttn1_LTE_A2+ Sts->RvsGainOffset_LTE_A2 + Sts->RvsTemp_LTE_A2;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn1_LTE_A2 = Sts->CurrRvsAttn1_LTE_A2 = DnrReferToTable(Index_RvsAttn1_LTE_A2,AttTemp,tAttAccu);
	
	AttTemp = Sts->RvsAttn2_LTE_A2;
	Sts->AttValue.RvsAttn2_LTE_A2 = Sts->CurrRvsAttn2_LTE_A2 = DnrReferToTable(Index_RvsAttn2_LTE_A2,AttTemp,tAttAccu);
	
	AttTemp = Sts->RvsAttn3_LTE_A2;
	Sts->AttValue.RvsAttn3_LTE_A2 = Sts->CurrRvsAttn3_LTE_A2 = DnrReferToTable(Index_RvsAttn3_LTE_A2,AttTemp,tAttAccu);

	//////////////////// LTE-A Common
	AttTemp = Sts->FwdAttn1_LTE_A;
	Sts->AttValue.FwdAttn1_LTE_A = Sts->CurrFwdAttn1_LTE_A = DnrReferToTable(Index_FwdAttn1_LTE_A,AttTemp,tAttAccu);
	
	AttTemp = Sts->RvsAttn1_LTE_A;
	Sts->AttValue.RvsAttn1_LTE_A = Sts->CurrRvsAttn1_LTE_A = DnrReferToTable(Index_RvsAttn1_LTE_A,AttTemp,tAttAccu);
	
	//////////////////////////////////WCDMA
	AttTemp = Sts->FwdAttn1_3G;
	Sts->AttValue.FwdAttn1_3G = Sts->CurrFwdAttn1_3G = DnrReferToTable(Index_FwdAttn1_3G,AttTemp,tAttAccu);
	

	AttTemp = Sts->FwdAttn2_3G + Sts->FwdGainOffset_3G + Sts->FwdTemp_3G;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.FwdAttn2_3G = Sts->CurrFwdAttn2_3G = DnrReferToTable(Index_FwdAttn2_3G,AttTemp,tAttAccu);


	AttTemp = Sts->RvsAttn1_3G;
	Sts->AttValue.RvsAttn1_3G = Sts->CurrRvsAttn1_3G = DnrReferToTable(Index_RvsAttn1_3G,AttTemp,tAttAccu);


	AttTemp = Sts->RvsAttn2_3G;
	Sts->AttValue.RvsAttn2_3G = Sts->CurrRvsAttn2_3G = DnrReferToTable(Index_RvsAttn2_3G,AttTemp,tAttAccu);
	

	AttTemp = Sts->RvsAttn3_3G + Sts->RvsGainOffset_3G + Sts->RvsTemp_3G;
	AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
	Sts->AttValue.RvsAttn3_3G = Sts->CurrRvsAttn3_3G = DnrReferToTable(Index_RvsAttn3_3G,AttTemp,tAttAccu);
	

	AttTemp = Sts->RvsAttn4_3G;
	Sts->AttValue.RvsAttn4_3G = Sts->CurrRvsAttn4_3G = DnrReferToTable(Index_RvsAttn4_3G,AttTemp,tAttAccu);
	
	if(iRepeaterType == _TRIO_MM)
	{
		//////////////////// LTE1
		AttTemp = Sts->Fwd1Attn1_LTE;
		Sts->Att1Value.Fwd1Attn1_LTE = Sts->CurrFwd1Attn1_LTE = DnrReferToTable(Index_Fwd1Attn1_LTE,AttTemp,tAttAccu);

		AttTemp = Sts->Fwd1Attn2_LTE + Sts->Fwd1GainOffset_LTE + Sts->Fwd1Temp_LTE;
		AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
		Sts->Att1Value.Fwd1Attn2_LTE = Sts->CurrFwd1Attn2_LTE = DnrReferToTable(Index_Fwd1Attn2_LTE,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn1_LTE;
		Sts->Att1Value.Rvs1Attn1_LTE = Sts->CurrRvs1Attn1_LTE = DnrReferToTable(Index_Rvs1Attn1_LTE,AttTemp,tAttAccu);


		AttTemp = Sts->Rvs1Attn2_LTE + Sts->Rvs1GainOffset_LTE + Sts->Rvs1Temp_LTE;
		AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
		Sts->Att1Value.Rvs1Attn2_LTE = Sts->CurrRvs1Attn2_LTE = DnrReferToTable(Index_Rvs1Attn2_LTE,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn3_LTE;
		Sts->Att1Value.Rvs1Attn3_LTE = Sts->CurrRvs1Attn3_LTE = DnrReferToTable(Index_Rvs1Attn3_LTE,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn4_LTE;
		Sts->Att1Value.Rvs1Attn4_LTE = Sts->CurrRvs1Attn4_LTE = DnrReferToTable(Index_Rvs1Attn4_LTE,AttTemp,tAttAccu);
		

		//////////////////// LTE-A1 
		AttTemp = Sts->Fwd1Attn1_LTE_A1;
		Sts->Att1Value.Fwd1Attn1_LTE_A1 = Sts->CurrFwd1Attn1_LTE_A1 = DnrReferToTable(Index_Fwd1Attn1_LTE_A1,AttTemp,tAttAccu);
		
		AttTemp = Sts->Fwd1Attn2_LTE_A1 + Sts->Fwd1GainOffset_LTE_A1 + Sts->Fwd1Temp_LTE_A1;
		AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
		Sts->Att1Value.Fwd1Attn2_LTE_A1 = Sts->CurrFwd1Attn2_LTE_A1 = DnrReferToTable(Index_Fwd1Attn2_LTE_A1,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn1_LTE_A1 + Sts->Rvs1GainOffset_LTE_A1 + Sts->Rvs1Temp_LTE_A1;
		AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
		Sts->Att1Value.Rvs1Attn1_LTE_A1 = Sts->CurrRvs1Attn1_LTE_A1 = DnrReferToTable(Index_Rvs1Attn1_LTE_A1,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn2_LTE_A1;
		Sts->Att1Value.Rvs1Attn2_LTE_A1 = Sts->CurrRvs1Attn2_LTE_A1 = DnrReferToTable(Index_Rvs1Attn2_LTE_A1,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn3_LTE_A1 ;
		Sts->Att1Value.Rvs1Attn3_LTE_A1 = Sts->CurrRvs1Attn3_LTE_A1 = DnrReferToTable(Index_Rvs1Attn3_LTE_A1,AttTemp,tAttAccu);
		//////////////////// LTE-A2
		AttTemp = Sts->Fwd1Attn1_LTE_A2;
		Sts->Att1Value.Fwd1Attn1_LTE_A2 = Sts->CurrFwd1Attn1_LTE_A2 = DnrReferToTable(Index_Fwd1Attn1_LTE_A2,AttTemp,tAttAccu);
		
		AttTemp = Sts->Fwd1Attn2_LTE_A2 + Sts->Fwd1GainOffset_LTE_A2 + Sts->Fwd1Temp_LTE_A2;
		AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
		Sts->Att1Value.Fwd1Attn2_LTE_A2 = Sts->CurrFwd1Attn2_LTE_A2 = DnrReferToTable(Index_Fwd1Attn2_LTE_A2,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn1_LTE_A2 + Sts->Rvs1GainOffset_LTE_A2 + Sts->Rvs1Temp_LTE_A2;
		AttTemp = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
		Sts->Att1Value.Rvs1Attn1_LTE_A2 = Sts->CurrRvs1Attn1_LTE_A2 = DnrReferToTable(Index_Rvs1Attn1_LTE_A2,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn2_LTE_A2;
		Sts->Att1Value.Rvs1Attn2_LTE_A2 = Sts->CurrRvs1Attn2_LTE_A2 = DnrReferToTable(Index_Rvs1Attn2_LTE_A2,AttTemp,tAttAccu);

		AttTemp = Sts->Rvs1Attn3_LTE_A2 ;
		Sts->Att1Value.Rvs1Attn3_LTE_A2 = Sts->CurrRvs1Attn3_LTE_A2 = DnrReferToTable(Index_Rvs1Attn3_LTE_A2,AttTemp,tAttAccu);

		//////////////////// LTE-A Common
		AttTemp = Sts->Fwd1Attn1_LTE_A;
		Sts->Att1Value.Fwd1Attn1_LTE_A = Sts->CurrFwd1Attn1_LTE_A = DnrReferToTable(Index_FwdAttn1_LTE_A_1,AttTemp,tAttAccu);
	
		AttTemp = Sts->Rvs1Attn1_LTE_A;
		Sts->Att1Value.Rvs1Attn1_LTE_A = Sts->CurrRvs1Attn1_LTE_A = DnrReferToTable(Index_RvsAttn1_LTE_A_1,AttTemp,tAttAccu);
	}
}

void StatustoIO(void)
{
	__Dnr_Sts  *Sts = tDnrSts;

	AttAccuChange();

	if(CurrFwdAttn1_2G != Sts->CurrFwdAttn1_2G)
	{
		CurrFwdAttn1_2G = Sts->CurrFwdAttn1_2G;
		AttnDataOutput(_FwdAttn1_2G_SEL, Sts->CurrFwdAttn1_2G);
	}

	if(CurrFwdAttn2_2G != Sts->CurrFwdAttn2_2G)
	{
		CurrFwdAttn2_2G = Sts->CurrFwdAttn2_2G;
		AttnDataOutput(_FwdAttn2_2G_SEL, Sts->CurrFwdAttn2_2G);
	}

	if(CurrRvsAttn1_2G != Sts->CurrRvsAttn1_2G)
	{
		CurrRvsAttn1_2G = Sts->CurrRvsAttn1_2G;
		AttnDataOutput(_RvsAttn1_2G_SEL, Sts->CurrRvsAttn1_2G);
	}

	if(CurrRvsAttn2_2G != Sts->CurrRvsAttn2_2G)
	{
		CurrRvsAttn2_2G = Sts->CurrRvsAttn2_2G;
		AttnDataOutput(_RvsAttn2_2G_SEL, Sts->CurrRvsAttn2_2G);
	}

	if(CurrRvsAttn3_2G != Sts->CurrRvsAttn3_2G)
	{
		CurrRvsAttn3_2G = Sts->CurrRvsAttn3_2G;
		AttnDataOutput(_RvsAttn3_2G_SEL, Sts->CurrRvsAttn3_2G);
	}
/////////////////////////////////////////////////////////// LTE Fwd

	if(CurrFwdAttn1_LTE!= Sts->CurrFwdAttn1_LTE)
	{
		CurrFwdAttn1_LTE= Sts->CurrFwdAttn1_LTE;
		AttnDataOutput(_FwdAttn1_LTE_SEL, Sts->CurrFwdAttn1_LTE);
	}

	if(CurrFwdAttn2_LTE != Sts->CurrFwdAttn2_LTE)
	{
		CurrFwdAttn2_LTE = Sts->CurrFwdAttn2_LTE;
		AttnDataOutput(_FwdAttn2_LTE_SEL, Sts->CurrFwdAttn2_LTE);
	}

	if(CurrRvsAttn1_LTE != Sts->CurrRvsAttn1_LTE)
	{
		CurrRvsAttn1_LTE = Sts->CurrRvsAttn1_LTE;
		AttnDataOutput(_RvsAttn1_LTE_SEL, Sts->CurrRvsAttn1_LTE);
	}

	if(CurrRvsAttn2_LTE != Sts->CurrRvsAttn2_LTE)
	{
		CurrRvsAttn2_LTE = Sts->CurrRvsAttn2_LTE;
		AttnDataOutput(_RvsAttn2_LTE_SEL, Sts->CurrRvsAttn2_LTE);
	}

	if(CurrRvsAttn3_LTE != Sts->CurrRvsAttn3_LTE)
	{
		CurrRvsAttn3_LTE = Sts->CurrRvsAttn3_LTE;
		AttnDataOutput(_RvsAttn3_LTE_SEL, Sts->CurrRvsAttn3_LTE);
	}

/////////////////////////////////////////////////////////// CDMA/LTE

	if(CurrFwdAttn1_CDMALTE!= Sts->CurrFwdAttn1_CDMALTE)
	{
		CurrFwdAttn1_CDMALTE = Sts->CurrFwdAttn1_CDMALTE;
		AttnDataOutput(_FwdAttn1_Common_SEL, Sts->CurrFwdAttn1_CDMALTE);
	}

	if(CurrRvsAttn1_CDMALTE!= Sts->CurrRvsAttn1_CDMALTE)
	{
		CurrRvsAttn1_CDMALTE = Sts->CurrRvsAttn1_CDMALTE;
		AttnDataOutput(_RvsAttn1_Common_SEL, Sts->CurrRvsAttn1_CDMALTE);
	}

	
/////////////////////////////////////////////////////////// LTE-A1

	if(CurrFwdAttn1_LTE_A1!= Sts->CurrFwdAttn1_LTE_A1)
	{
		CurrFwdAttn1_LTE_A1 = Sts->CurrFwdAttn1_LTE_A1;
		AttnDataOutput(_FwdAttn1_LTE_A1_SEL, Sts->CurrFwdAttn1_LTE_A1);
	}
	if(CurrFwdAttn2_LTE_A1 != Sts->CurrFwdAttn2_LTE_A1)
	{
		CurrFwdAttn2_LTE_A1 = Sts->CurrFwdAttn2_LTE_A1;
		AttnDataOutput(_FwdAttn2_LTE_A1_SEL, Sts->CurrFwdAttn2_LTE_A1);
	}
	
	if(CurrRvsAttn1_LTE_A1 != Sts->CurrRvsAttn1_LTE_A1)
	{
		CurrRvsAttn1_LTE_A1 = Sts->CurrRvsAttn1_LTE_A1;
		AttnDataOutput(_RvsAttn1_LTE_A1_SEL, Sts->CurrRvsAttn1_LTE_A1);
	}
	
	if(CurrRvsAttn2_LTE_A1 != Sts->CurrRvsAttn2_LTE_A1)
	{
		CurrRvsAttn2_LTE_A1 = Sts->CurrRvsAttn2_LTE_A1;
		AttnDataOutput(_RvsAttn2_LTE_A1_SEL, Sts->CurrRvsAttn2_LTE_A1);
	}

	if(CurrRvsAttn3_LTE_A1 != Sts->CurrRvsAttn3_LTE_A1)
	{
		CurrRvsAttn3_LTE_A1 = Sts->CurrRvsAttn3_LTE_A1;
		AttnDataOutput(_RvsAttn3_LTE_A1_SEL, Sts->CurrRvsAttn3_LTE_A1);
	}
	
/////////////////////////////////////////////////////////// LTE-A2

	if(CurrFwdAttn1_LTE_A2!= Sts->CurrFwdAttn1_LTE_A2)
	{
		CurrFwdAttn1_LTE_A2 = Sts->CurrFwdAttn1_LTE_A2;
		AttnDataOutput(_FwdAttn1_LTE_A2_SEL, Sts->CurrFwdAttn1_LTE_A2);
	}
	if(CurrFwdAttn2_LTE_A2 != Sts->CurrFwdAttn2_LTE_A2)
	{
		CurrFwdAttn2_LTE_A2 = Sts->CurrFwdAttn2_LTE_A2;
		AttnDataOutput(_FwdAttn2_LTE_A2_SEL, Sts->CurrFwdAttn2_LTE_A2);
	}
	
	if(CurrRvsAttn1_LTE_A2 != Sts->CurrRvsAttn1_LTE_A2)
	{
		CurrRvsAttn1_LTE_A2 = Sts->CurrRvsAttn1_LTE_A2;
		AttnDataOutput(_RvsAttn1_LTE_A2_SEL, Sts->CurrRvsAttn1_LTE_A2);
	}
	
	if(CurrRvsAttn2_LTE_A2 != Sts->CurrRvsAttn2_LTE_A2)
	{
		CurrRvsAttn2_LTE_A2 = Sts->CurrRvsAttn2_LTE_A2;
		AttnDataOutput(_RvsAttn2_LTE_A2_SEL, Sts->CurrRvsAttn2_LTE_A2);
	}

	if(CurrRvsAttn3_LTE_A2 != Sts->CurrRvsAttn3_LTE_A2)
	{
		CurrRvsAttn3_LTE_A2 = Sts->CurrRvsAttn3_LTE_A2;
		AttnDataOutput(_RvsAttn3_LTE_A2_SEL, Sts->CurrRvsAttn3_LTE_A2);
	}

/////////////////////////////////////////////////////////// LTE_A 공통

	if(CurrFwdAttn1_LTE_A != Sts->CurrFwdAttn1_LTE_A)
	{
		CurrFwdAttn1_LTE_A = Sts->CurrFwdAttn1_LTE_A;
		AttnDataOutput(_FwdAttn1_LTE_A_SEL, Sts->CurrFwdAttn1_LTE_A);
	}

	if(CurrRvsAttn1_LTE_A!= Sts->CurrRvsAttn1_LTE_A)
	{
		CurrRvsAttn1_LTE_A = Sts->CurrRvsAttn1_LTE_A;
		AttnDataOutput(_RvsAttn1_LTE_A_SEL, Sts->CurrRvsAttn1_LTE_A);
	}

	/////////////////////////////////////////////////////////// 3G

	if(CurrFwdAttn1_3G!= Sts->CurrFwdAttn1_3G)
	{
		CurrFwdAttn1_3G = Sts->CurrFwdAttn1_3G;
		AttnDataOutput(_FwdAttn1_3G_SEL, Sts->CurrFwdAttn1_3G);
	}

	if(CurrFwdAttn2_3G != Sts->CurrFwdAttn2_3G)
	{
		CurrFwdAttn2_3G = Sts->CurrFwdAttn2_3G;
		AttnDataOutput(_FwdAttn2_3G_SEL, Sts->CurrFwdAttn2_3G);
	}

	if(CurrRvsAttn1_3G != Sts->CurrRvsAttn1_3G)
	{
		CurrRvsAttn1_3G = Sts->CurrRvsAttn1_3G;
		AttnDataOutput(_RvsAttn1_3G_SEL, Sts->CurrRvsAttn1_3G);
	}
	
	if(CurrRvsAttn2_3G != Sts->CurrRvsAttn2_3G)
	{
		CurrRvsAttn2_3G = Sts->CurrRvsAttn2_3G;
		AttnDataOutput(_RvsAttn2_3G_SEL, Sts->CurrRvsAttn2_3G);
	}

	if(CurrRvsAttn3_3G != Sts->CurrRvsAttn3_3G)
	{
		CurrRvsAttn3_3G = Sts->CurrRvsAttn3_3G;
		AttnDataOutput(_RvsAttn3_3G_SEL, Sts->CurrRvsAttn3_3G);
	}

	if(CurrRvsAttn4_3G != Sts->CurrRvsAttn4_3G)
	{
		CurrRvsAttn4_3G = Sts->CurrRvsAttn4_3G;
		AttnDataOutput(_RvsAttn4_3G_SEL, Sts->CurrRvsAttn4_3G);
	}

	if(iRepeaterType == _TRIO_MM)
	{
	/////////////////////////////////////////////////////////// LTE
		if(CurrFwd1Attn1_LTE!= Sts->CurrFwd1Attn1_LTE)
		{
			CurrFwd1Attn1_LTE = Sts->CurrFwd1Attn1_LTE;
			AttnDataOutput(_Fwd1Attn1_LTE_SEL, Sts->Fwd1Attn1_LTE);
		}
		
		if(CurrFwd1Attn2_LTE != Sts->CurrFwd1Attn2_LTE)
		{
			CurrFwd1Attn2_LTE = Sts->CurrFwd1Attn2_LTE;
			AttnDataOutput(_Fwd1Attn2_LTE_SEL, Sts->CurrFwd1Attn2_LTE);
		}
		
		if(CurrRvs1Attn1_LTE != Sts->CurrRvs1Attn1_LTE)
		{
			CurrRvs1Attn1_LTE = Sts->CurrRvs1Attn1_LTE;
			AttnDataOutput(_Rvs1Attn1_LTE_SEL, Sts->CurrRvs1Attn1_LTE);
		}
		
		if(CurrRvs1Attn2_LTE != Sts->CurrRvs1Attn2_LTE)
		{
			CurrRvs1Attn2_LTE = Sts->CurrRvs1Attn2_LTE;
			AttnDataOutput(_Rvs1Attn2_LTE_SEL, Sts->CurrRvs1Attn2_LTE);
		}

		if(CurrRvs1Attn3_LTE != Sts->CurrRvs1Attn3_LTE)
		{
			CurrRvs1Attn3_LTE = Sts->CurrRvs1Attn3_LTE;
			AttnDataOutput(_Rvs1Attn3_LTE_SEL, Sts->CurrRvs1Attn3_LTE);
		}
		
		if(CurrRvs1Attn4_LTE != Sts->CurrRvs1Attn4_LTE)
		{
			CurrRvs1Attn4_LTE = Sts->CurrRvs1Attn4_LTE;
			AttnDataOutput(_Rvs1Attn4_LTE_SEL, Sts->CurrRvs1Attn4_LTE);
		}

	/////////////////////////////////////////////////////////// LTE-A

		if(CurrFwd1Attn1_LTE_A1!= Sts->CurrFwd1Attn1_LTE_A1)
		{
			CurrFwd1Attn1_LTE_A1 = Sts->CurrFwd1Attn1_LTE_A1;
			AttnDataOutput(_Fwd1Attn1_LTE_A1_SEL, Sts->CurrFwd1Attn1_LTE_A1);
		}

		if(CurrFwd1Attn2_LTE_A1 != Sts->CurrFwd1Attn2_LTE_A1)
		{
			CurrFwd1Attn2_LTE_A1 = Sts->CurrFwd1Attn2_LTE_A1;
			AttnDataOutput(_Fwd1Attn2_LTE_A1_SEL, Sts->CurrFwd1Attn2_LTE_A1);
		}

		if(CurrRvs1Attn1_LTE_A1 != Sts->CurrRvs1Attn1_LTE_A1)
		{
			CurrRvs1Attn1_LTE_A1 = Sts->CurrRvs1Attn1_LTE_A1;
			AttnDataOutput(_Rvs1Attn1_LTE_A1_SEL, Sts->CurrRvs1Attn1_LTE_A1);
		}

		if(CurrRvs1Attn2_LTE_A1 != Sts->CurrRvs1Attn2_LTE_A1)
		{
			CurrRvs1Attn2_LTE_A1 = Sts->CurrRvs1Attn2_LTE_A1;
			AttnDataOutput(_Rvs1Attn2_LTE_A1_SEL, Sts->CurrRvs1Attn2_LTE_A1);
		}

		if(CurrRvs1Attn3_LTE_A1 != Sts->CurrRvs1Attn3_LTE_A1)
		{
			CurrRvs1Attn3_LTE_A1 = Sts->CurrRvs1Attn3_LTE_A1;
			AttnDataOutput(_Rvs1Attn3_LTE_A1_SEL, Sts->CurrRvs1Attn3_LTE_A1);
		}
	/////////////////////////////////////////////////////////// LTE-A2
	
		if(CurrFwd1Attn1_LTE_A2!= Sts->CurrFwd1Attn1_LTE_A2)
		{
			CurrFwd1Attn1_LTE_A2 = Sts->CurrFwd1Attn1_LTE_A2;
			AttnDataOutput(_Fwd1Attn1_LTE_A2_SEL, Sts->CurrFwd1Attn1_LTE_A2);
		}
		
		if(CurrFwd1Attn2_LTE_A2 != Sts->CurrFwd1Attn2_LTE_A2)
		{
			CurrFwd1Attn2_LTE_A2 = Sts->CurrFwd1Attn2_LTE_A2;
			AttnDataOutput(_Fwd1Attn2_LTE_A2_SEL, Sts->CurrFwd1Attn2_LTE_A2);
		}
		
		if(CurrRvs1Attn1_LTE_A2 != Sts->CurrRvs1Attn1_LTE_A2)
		{
			CurrRvs1Attn1_LTE_A2 = Sts->CurrRvs1Attn1_LTE_A2;
			AttnDataOutput(_Rvs1Attn1_LTE_A2_SEL, Sts->CurrRvs1Attn1_LTE_A2);
		}
		
		if(CurrRvs1Attn2_LTE_A2 != Sts->CurrRvs1Attn2_LTE_A2)
		{
			CurrRvs1Attn2_LTE_A2 = Sts->CurrRvs1Attn2_LTE_A2;
			AttnDataOutput(_Rvs1Attn2_LTE_A2_SEL, Sts->CurrRvs1Attn2_LTE_A2);
		}
	
		if(CurrRvs1Attn3_LTE_A2 != Sts->CurrRvs1Attn3_LTE_A2)
		{
			CurrRvs1Attn3_LTE_A2 = Sts->CurrRvs1Attn3_LTE_A2;
			AttnDataOutput(_Rvs1Attn3_LTE_A2_SEL, Sts->CurrRvs1Attn3_LTE_A2);
		}
	
	/////////////////////////////////////////////////////////// LTE_A 공통
	
		if(CurrFwd1Attn1_LTE_A != Sts->CurrFwd1Attn1_LTE_A)
		{
			CurrFwd1Attn1_LTE_A = Sts->CurrFwd1Attn1_LTE_A;
			AttnDataOutput(_Fwd1Attn1_LTE_A_SEL, Sts->CurrFwd1Attn1_LTE_A);
		}
	
		if(CurrRvs1Attn1_LTE_A!= Sts->CurrRvs1Attn1_LTE_A)
		{
			CurrRvs1Attn1_LTE_A = Sts->CurrRvs1Attn1_LTE_A;
			AttnDataOutput(_Rvs1Attn1_LTE_A_SEL, Sts->CurrRvs1Attn1_LTE_A);
		}
	}

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
			AmpOnOff_LTE_A1_0 = 0;
			AmpOnOff_LTE_A2_0 = 0;
			AmpOnOff_WCDMA = 0;

			AmpOnOff_LTE_1 = 0;
			AmpOnOff_LTE_A1_1 = 0;
			AmpOnOff_LTE_A2_1 = 0;

			AmpBitReason(PATH_3G, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_2G, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTE, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTE_A1, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTE_A2, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTE_1, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTE_A1_1, _Disable, __DCAlarm, SD_AMP_OFF_INF);
			AmpBitReason(PATH_LTE_A2_1, _Disable, __DCAlarm, SD_AMP_OFF_INF);
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

				if(AlarmCheck_LTE == SET)
				{
					if(Sts->AlmSts.FwdAmpOnOff_LTE== Enable)		
					{
						AmpOnOff_LTE_0 = 1;
					}
					else
					{
						AmpOnOff_LTE_0 = 0;
					}
				}
				else
				{
//					Sts->FwdAmpOnOff_LTE = Disable;
					AmpOnOff_LTE_0 = 0;
				}				
			}
			if(AlarmCheck_LTE_A1 == SET)
			{
				if(Sts->AlmSts.FwdAmpOnOff_LTE_A1 == Enable)
				{
					AmpOnOff_LTE_A1_0 = 1;
				}
				else
				{
					AmpOnOff_LTE_A1_0 = 0;
				}
			}
			else
			{
//				Sts->FwdAmpOnOff_LTE_A1 = Disable;
				AmpOnOff_LTE_A1_0 = 0;
			}

			if(AlarmCheck_LTE_A2 == SET)
			{
				if(Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Enable)
				{
					AmpOnOff_LTE_A2_0 = 1;
				}
				else
				{
					AmpOnOff_LTE_A2_0 = 0;
				}
			}
			else
			{
//				Sts->FwdAmpOnOff_LTE_A2 = Disable;
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
		
		if(iRepeaterType == _TRIO_MM)
		{

			if(AlarmCheck_LTE_1 == SET)
			{
				if(Sts->AlmSts.FwdAmp1OnOff_LTE == Enable)
				{
					AmpOnOff_LTE_1 = 1;
				}
				else
				{
					AmpOnOff_LTE_1 = 0;
				}
			}
			else
			{
//				Sts->FwdAmp1OnOff_LTE= Disable;
				AmpOnOff_LTE_1 = 0;
			}


		
			if(AlarmCheck_LTE_A1_1 == SET)
			{
				if(Sts->AlmSts.FwdAmp1OnOff_LTE_A1 == Enable)
				{
					AmpOnOff_LTE_A1_1 = 1;
				}
				else
				{
					AmpOnOff_LTE_A1_1 = 0;
				}
			}
			else
			{
//				Sts->FwdAmp1OnOff_LTE_A1 = Disable;
				AmpOnOff_LTE_A1_1 = 0;
			}
		
			if(AlarmCheck_LTE_A2_1 == SET)
			{
				if(Sts->AlmSts.FwdAmp1OnOff_LTE_A2 == Enable)
				{
					AmpOnOff_LTE_A2_1 = 1;
				}
				else
				{
					AmpOnOff_LTE_A2_1 = 0;
				}
			}
			else
			{
//				Sts->FwdAmp1OnOff_LTE_A2 = Disable;
				AmpOnOff_LTE_A2_1 = 0;
			}
		}
	}

	if( CurrLTE15MUse != Sts->LTE15MUse)
	{
		CurrLTE15MUse = Sts->LTE15MUse;
		if(Sts->LTE15MUse == __USE) 	PCA9555BitRst(_15M_Switch_LTE,&AttnCS1Val); 	
		else							PCA9555BitSet(_15M_Switch_LTE,&AttnCS1Val);
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

			_FWDRVS1_PllOut(iBand_Freq*1000);
			OSTimeDly(50);
			_FWDRVS2_PllOut(iBand_Freq*1000);
		}

		ChkBandSelet = RESET;
	}

	if(ChkPllFregOffset_LTE)
	{
		INT32U tLocal = 0;

		tLocal = 1097000 + Sts->PllFregOffset_LTE *25;
		_PllOut_LTE(tLocal*1000);
	
		ChkPllFregOffset_LTE = RESET;
	}
}


void AttnDataOutput(unsigned short int Sel, unsigned char Data)
{
	INT8U i = 0;

	Data = (~Data )& 0x3f;
//	Data = Data & 0x3f;

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
				PCA9555BitSet(Fwd_Att1_CDMA,&AttnCS2Val); 
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_CDMA,&AttnCS2Val); 		
			break;
			
			case _FwdAttn2_2G_SEL:			
				PCA9555BitSet(Fwd_Att2_CDMA,&AttnCS2Val); 		
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_CDMA,&AttnCS2Val); 		
			break;
			
			case _RvsAttn1_2G_SEL:			
				PCA9555BitSet(Rvs_Att1_CDMA,&AttnCS2Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_CDMA,&AttnCS2Val); 		
			break;
			
			case _RvsAttn2_2G_SEL:			
				PCA9555BitSet(Rvs_Att2_CDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_CDMA,&AttnCS0Val);		
			break;
			
			case _RvsAttn3_2G_SEL:			
				PCA9555BitSet(Rvs_Att3_CDMA,&AttnCS0Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_CDMA,&AttnCS0Val); 
			break;
			
			case _FwdAttn1_LTE_SEL: 		
				PCA9555BitSet(Fwd_Att1_LTE_0,&AttnCS2Val);		
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_0,&AttnCS2Val);	
			break;
			
			case _FwdAttn2_LTE_SEL: 		
				PCA9555BitSet(Fwd_Att2_LTE_0,&AttnCS2Val);		
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_LTE_0,&AttnCS2Val); 
			break;
			
			case _RvsAttn1_LTE_SEL: 		
				PCA9555BitSet(Rvs_Att1_LTE_0,&AttnCS2Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_0,&AttnCS2Val);		
			break;
			
			case _RvsAttn2_LTE_SEL: 		
				PCA9555BitSet(Rvs_Att2_LTE_0,&AttnCS0Val);
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_0,&AttnCS0Val); 	
			break;
			
			case _RvsAttn3_LTE_SEL: 		
				PCA9555BitSet(Rvs_Att3_LTE_0,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_0,&AttnCS0Val); 
			break;

			case _FwdAttn1_Common_SEL:		
				PCA9555BitSet(Fwd_Att1_CDMALTE,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_CDMALTE,&AttnCS0Val); 	
			break;
			
			case _RvsAttn1_Common_SEL:		
				PCA9555BitSet(Rvs_Att1_CDMALTE,&AttnCS2Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_CDMALTE,&AttnCS2Val); 				
			break;

			case _FwdAttn1_LTE_A1_SEL:		
				PCA9555BitSet(Fwd_Att1_LTE_A1_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_A1_0,&AttnCS0Val); 	
			break;

			case _FwdAttn2_LTE_A1_SEL:		
				PCA9555BitSet(Fwd_Att2_LTE_A1_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_LTE_A1_0,&AttnCS0Val); 	
			break;
			
			case _RvsAttn1_LTE_A1_SEL:		
				PCA9555BitSet(Rvs_Att1_LTE_A1_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_A1_0,&AttnCS0Val); 	
			break;
			
			case _RvsAttn2_LTE_A1_SEL:		
				PCA9555BitSet(Rvs_Att2_LTE_A1_0,&AttnCS1Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_A1_0,&AttnCS1Val); 	
			break;
			
			case _RvsAttn3_LTE_A1_SEL:		
				PCA9555BitSet(Rvs_Att3_LTE_A1_0,&AttnCS0Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_A1_0,&AttnCS0Val);	
			break;
////////////////////////////////////////////////////////////////			
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
	////////////////////////////////////////////////////////////////			
			case _RvsAttn1_LTE_A2_SEL:		
				PCA9555BitSet(Rvs_Att1_LTE_A2_0,&AttnCS1Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_A2_0,&AttnCS1Val); 	
			break;
			
			case _RvsAttn2_LTE_A2_SEL:		
				PCA9555BitSet(Rvs_Att2_LTE_A2_0,&AttnCS1Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_A2_0,&AttnCS1Val); 	
			break;
			
			case _RvsAttn3_LTE_A2_SEL:		
				PCA9555BitSet(Rvs_Att3_LTE_A2_0,&AttnCS1Val);		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_A2_0,&AttnCS1Val);	
			break;
///////////////////////////////////////////////////////////////////
			case _FwdAttn1_LTE_A_SEL:		
				PCA9555BitSet(Fwd_Att1_LTE_A_0,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_A_0,&AttnCS0Val); 	
			break;
			
			case _RvsAttn1_LTE_A_SEL:		
				PCA9555BitSet(Rvs_Att1_LTE_A_0,&AttnCS2Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_A_0,&AttnCS2Val); 				
			break;	
/////////////////////////////////////////////////////////////

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
				PCA9555BitSet(Rvs_Att1_WCDMA,&AttnCS2Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_WCDMA,&AttnCS2Val); 		
			break;
			
			case _RvsAttn2_3G_SEL:			
				PCA9555BitSet(Rvs_Att2_WCDMA,&AttnCS2Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_WCDMA,&AttnCS2Val); 		
			break;
			
			case _RvsAttn3_3G_SEL:			
				PCA9555BitSet(Rvs_Att3_WCDMA,&AttnCS1Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_WCDMA,&AttnCS1Val); 		
			break;
			
			case _RvsAttn4_3G_SEL:			
				PCA9555BitSet(Rvs_Att4_WCDMA,&AttnCS1Val); 		
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att4_WCDMA,&AttnCS1Val); 
			break;
			

			case _Fwd1Attn1_LTE_SEL:		
				PCA9555BitSet(Fwd_Att1_LTE_1,&AttnCS3Val);	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_1,&AttnCS3Val);	
			break;
			
			case _Fwd1Attn2_LTE_SEL:		
				PCA9555BitSet(Fwd_Att2_LTE_1,&AttnCS3Val);	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_LTE_1,&AttnCS3Val);	
			break;
			
			case _Rvs1Attn1_LTE_SEL:		
				PCA9555BitSet(Rvs_Att1_LTE_1,&AttnCS1Val);	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_1,&AttnCS1Val);	
			break;
			
			case _Rvs1Attn2_LTE_SEL:		
				PCA9555BitSet(Rvs_Att2_LTE_1,&AttnCS1Val);	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_1,&AttnCS1Val);	
			break;
			
			case _Rvs1Attn3_LTE_SEL:		
				PCA9555BitSet(Rvs_Att3_LTE_1,&AttnCS3Val);	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_1,&AttnCS3Val);	
			break;
			
			case _Rvs1Attn4_LTE_SEL:		
				PCA9555BitSet(Rvs_Att4_LTE_1,&AttnCS2Val);	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att4_LTE_1,&AttnCS2Val);	
			break;
			
			case _Fwd1Attn1_LTE_A1_SEL:		
				PCA9555BitSet(Fwd_Att1_LTE_A1_1,&AttnCS3Val);	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_A1_1,&AttnCS3Val); 
			break;
			
			case _Fwd1Attn2_LTE_A1_SEL:		
				PCA9555BitSet(Fwd_Att2_LTE_A1_1,&AttnCS3Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_LTE_A1_1,&AttnCS3Val); 	
			break;
			
			case _Rvs1Attn1_LTE_A1_SEL:		
				PCA9555BitSet(Rvs_Att1_LTE_A1_1,&AttnCS3Val); 
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_A1_1,&AttnCS3Val); 	
			break;
			
			case _Rvs1Attn2_LTE_A1_SEL:		
				PCA9555BitSet(Rvs_Att2_LTE_A1_1,&AttnCS3Val); 
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_A1_1,&AttnCS3Val); 	
			break;
			
			case _Rvs1Attn3_LTE_A1_SEL:		
				PCA9555BitSet(Rvs_Att3_LTE_A1_1,&AttnCS3Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_A1_1,&AttnCS3Val);	
			break;

////
			case _Fwd1Attn1_LTE_A2_SEL: 	
				PCA9555BitSet(Fwd_Att1_LTE_A2_1,&AttnCS3Val);	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_A2_1,&AttnCS3Val); 
			break;

			case _Fwd1Attn2_LTE_A2_SEL: 	
				PCA9555BitSet(Fwd_Att2_LTE_A2_1,&AttnCS3Val);	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att2_LTE_A2_1,&AttnCS3Val);	
			break;

			case _Rvs1Attn1_LTE_A2_SEL: 	
				PCA9555BitSet(Rvs_Att1_LTE_A2_1,&AttnCS3Val); 
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_A2_1,&AttnCS3Val);	
			break;

			case _Rvs1Attn2_LTE_A2_SEL: 	
				PCA9555BitSet(Rvs_Att2_LTE_A2_1,&AttnCS3Val); 
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att2_LTE_A2_1,&AttnCS3Val);	
			break;

			case _Rvs1Attn3_LTE_A2_SEL: 	
				PCA9555BitSet(Rvs_Att3_LTE_A2_1,&AttnCS3Val);	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att3_LTE_A2_1,&AttnCS3Val);	
			break;
			
			case _Fwd1Attn1_LTE_A_SEL:		
				PCA9555BitSet(Fwd_Att1_LTE_A_1,&AttnCS0Val); 	
				ForDelay(100L);
				PCA9555BitRst(Fwd_Att1_LTE_A_1,&AttnCS0Val); 	
			break;
			
			case _Rvs1Attn1_LTE_A_SEL:		
				PCA9555BitSet(Rvs_Att1_LTE_A_1,&AttnCS1Val); 	
				ForDelay(100L);
				PCA9555BitRst(Rvs_Att1_LTE_A_1,&AttnCS1Val); 				
			break;	
		}
	}
}

void TimerRelatedOperation(void)
{
	if(TimeOverCheck(Timer_AttnOut))
	{
//		AttnOutBufferInit();
		TimerRegist(Timer_AttnOut, Time1Sec*5L); // 500msec 뒤에 다시 Attn!!
		iDebugCnt = 0; 
	}
}

void TypeCheck(void)
{
	__Dnr_Sts	*Sts = tDnrSts;

	if((RRTYPE == SET))
	{
		Sts->RepeaterType[0]	= hibyte(TRIO_M_TYPE);
		Sts->RepeaterType[1]	= lobyte(TRIO_M_TYPE);
		Sts->SWVer 				= TRIO_M_SystemVer;
		Sts->RCUAddVer 			= TRIO_M_PROGRAMVER;	

		iRepeaterType = _TRIO_M;
	}
	else 
	{
		Sts->RepeaterType[0]	= hibyte(TRIO_MM_TYPE);
		Sts->RepeaterType[1]	= lobyte(TRIO_MM_TYPE);
		Sts->SWVer 				= TRIO_MM_SystemVer;
		Sts->RCUAddVer 			= TRIO_MM_PROGRAMVER;	

		iRepeaterType = _TRIO_MM;
	}	 
//	iRepeaterType = _TRIO_MM;
}


void pPCA9555Port_Init(INT8U tIndex)
{
	_PCA9555Reg Reg;
	Reg.Data = tIndex;	// Output  0

	PCASetConfiguration(Attn_CS0,Reg);
	PCASetConfiguration(Attn_CS1,Reg);
	PCASetConfiguration(Attn_CS2,Reg);
	PCASetConfiguration(Attn_CS3,Reg);
}


///////////////////////////////////////////////////////////////////////////////
// End of Source File

////////////////////////
