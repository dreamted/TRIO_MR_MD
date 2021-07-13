/*********************************************
* File Name          : alarm.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/

#define ALARM_C

#include "../include/main.h"
 #include <stdlib.h>

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

void AlarmCheck(void)
{
	INT16S cval;
	INT16S tlimit;
	INT16U RecoveryAlarm;

	INT8U FwdLowMask;

	__Dnr_Sts *Sts = tDnrSts;
	

	if(ChkTableAlarm)
	{
//		Table_Alarm();
		ChkTableAlarm = RESET;
	}

	{
		if(AC_Alarm)
		{
			ACFailCnt = ACFailCnt + 1;
			if(ACFailCnt >= 4)
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
		tlimit = Sts->VccDet_Lmt.Data;
		RecoveryAlarm  = tlimit + 200;
		if(cval <= tlimit)				PwrAlarm.DCFail = Alarm;
		else if(cval >= RecoveryAlarm)	PwrAlarm.DCFail = Normal;
	}	

	if(PwrAlarm.DCFail)	    Sts->ModuleAlarm.Main.DCFail = Alarm;
	else					Sts->ModuleAlarm.Main.DCFail = Normal;
		
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


	if((Sts->Band_Select_LTE_A1 == __NOTUSE)||(Sts->FemtocellUseOnOff.LTE_A1 == __USE))
	{
		AlarmCheck_LTE_A1 = RESET;
	}
	else
	{
		AlarmCheck_LTE_A1 = SET;
	}


	if((Sts->Band_Select_LTE_A2[0]  == __NOTUSE)||(Sts->FemtocellUseOnOff.LTE_A2 == __USE))
	{
		AlarmCheck_LTE_A2 = RESET;
	}
	else
	{
		AlarmCheck_LTE_A2 = SET;
	}

	if(Sts->FemtocellUseOnOff.LTE_1== __NOTUSE)
	{
		AlarmCheck_LTE_1= SET;
	}
	else
	{
		AlarmCheck_LTE_1 = RESET;
	}

	if((Sts->Band_Select_LTE_A1 == __NOTUSE)||(Sts->FemtocellUseOnOff.LTE_A1_1 == __USE))
	{
		AlarmCheck_LTE_A1_1 = RESET;
	}
	else
	{
		AlarmCheck_LTE_A1_1 = SET;
	}

	if((Sts->Band_Select_LTE_A2[0]	== __NOTUSE)||(Sts->FemtocellUseOnOff.LTE_A2_1 == __USE))
	{
		AlarmCheck_LTE_A2_1 = RESET;
	}
	else
	{
		AlarmCheck_LTE_A2_1 = SET;
	}


	
	if(AlarmCheck_2G == SET)
	{
		// 2G FWD OUT High
		{
			INT8S LimitLvl;
			INT8S DetLvl;
			DetLvl		= Sts->FwdOutPwr_2G[0]*2;
			if(Sts->FwdOutPwr_2G[1] >= 5)DetLvl++;
			
			LimitLvl		= Sts->FwdOutHighLmt_2G[0]*2;
			if(Sts->FwdOutHighLmt_2G[1] >= 5)LimitLvl++;
			
			if(Sd_Step[SD_FO_2G] != 0)	Sts->AlmSts.FwdOutUpperLmtFail_2G = Alarm;
			else 						Sts->AlmSts.FwdOutUpperLmtFail_2G = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutUpperLmtFail_2G);

		}

		{
			// 2G FWD OUT Low
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->FwdOutPwr_2G[0]*2;
			if(Sts->FwdOutPwr_2G[1] >= 5)DetLvl++;
			LimitLvl		= Sts->FwdOutLowerLmt_2G[0]*2;
			if(Sts->FwdOutLowerLmt_2G[1] >= 5)LimitLvl++;


			if (((tDnrSts->FwdAmpOnOff_2G == Disable)&&(tDnrSts->AmpOffCase_2G == __UsrCtrl))
				||(Sd_Step[SD_FO_2G] > 1))
			{
				FwdLowMask = RESET;
			}
			else FwdLowMask = SET;

			if(FwdLowMask)
			{
				Sts->AlmSts.FwdOutLowerLmtFail_2G = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutLowerLmtFail_2G);
				
				if( Sts->AlmSts.FwdOutLowerLmtFail_2G == Alarm)
				{
					if(++LimitAlarmCnt[PATH_2G]>= AlarmCheckTime)
					{
						PwrAlarm.FwdOutLowerLmtFail_2G = SET;
						LimitAlarmCnt[PATH_2G] = AlarmCheckTime;
					}	
				}
				else
				{
					PwrAlarm.FwdOutLowerLmtFail_2G = RESET;
					LimitAlarmCnt[PATH_2G] = 0;
				}
			}
			else
			{
				Sts->AlmSts.FwdOutLowerLmtFail_2G  = Normal;
				PwrAlarm.FwdOutLowerLmtFail_2G = RESET;
				LimitAlarmCnt[PATH_2G] = 0;
			}
 		}
		{
			// Rvs Upper Limit	CDMA
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->RvsOutPwr_2G[0]*2;
			if(Sts->RvsOutPwr_2G[1] >= 5)DetLvl++;
			LimitLvl		= Sts->RvsOutUpperLmt_2G[0]*2;
			if(Sts->RvsOutUpperLmt_2G[1] >= 5)LimitLvl++;

			if(Sd_Step[SD_RO_2G] != 0)	Sts->AlmSts.RvsOutUpperLmtFail_2G = Alarm;
			else 						Sts->AlmSts.RvsOutUpperLmtFail_2G = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.RvsOutUpperLmtFail_2G);
		}
		
		{
			// CDMA Over In Alarm 
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= -(Sts->FwdInPwr_2G*1);
			LimitLvl	= FwdOverInAlmLmt_2G;   // 과입력 Alarm  '-24±2dBm~-11±2dBm
			if(Sd_Step[SD_FI_2G] != 0)	Sts->AlmSts.FwdInUpperLmtFail_2G = Alarm;
			else						Sts->AlmSts.FwdInUpperLmtFail_2G = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdInUpperLmtFail_2G);
		}
	}
	else
	{
		Sts->AlmSts.FwdOutUpperLmtFail_2G	= Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_2G	= Normal;
		Sts->AlmSts.FwdInUpperLmtFail_2G	= Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_2G	= Normal;
	}

	
	////////////////// LTE
	if(AlarmCheck_LTE == SET)
	{
		{
			if(PLLAlarm_CDMALTE)	Sts->AlmSts.LocalFail_CDMALTE	= Normal;
			else					Sts->AlmSts.LocalFail_CDMALTE	= Alarm;
		}


		// LTE FWD OUT High
		{
			INT8S LimitLvl;
			INT8S DetLvl;
			DetLvl		= Sts->FwdOutPwr_LTE[0]*2;
			if(Sts->FwdOutPwr_LTE[1] >= 5)DetLvl++;
			
			LimitLvl		= Sts->FwdOutHighLmt_LTE[0]*2;
			if(Sts->FwdOutHighLmt_LTE[1] >= 5)LimitLvl++;
			
			if(Sd_Step[SD_FO_LTE] != 0)	Sts->AlmSts.FwdOutUpperLmtFail_LTE = Alarm;
			else						Sts->AlmSts.FwdOutUpperLmtFail_LTE = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutUpperLmtFail_LTE);
		}

		{
			// LTE FWD OUT Low
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->FwdOutPwrPeak_LTE[0]*2;
			if(Sts->FwdOutPwrPeak_LTE[1] >= 5)DetLvl++;
			LimitLvl		= Sts->FwdOutLowerLmt_LTE[0]*2;
			if(Sts->FwdOutLowerLmt_LTE[1] >= 5)LimitLvl++;


			if (((tDnrSts->FwdAmpOnOff_LTE == Disable)&&(tDnrSts->AmpOffCase_LTE== __UsrCtrl))
				||(Sd_Step[SD_FO_LTE] > 1))
			{
				FwdLowMask = RESET;
			}
			else FwdLowMask = SET;

			if(FwdLowMask)
			{
				Sts->AlmSts.FwdOutLowerLmtFail_LTE = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutLowerLmtFail_LTE);
				if( Sts->AlmSts.FwdOutLowerLmtFail_LTE == Alarm)
				{
					if(++LimitAlarmCnt[PATH_LTE]>= AlarmCheckTime)
					{
						PwrAlarm.FwdOutLowerLmtFail_LTE = SET;
						LimitAlarmCnt[PATH_LTE] = AlarmCheckTime;
					}	
				}
				else
				{
					PwrAlarm.FwdOutLowerLmtFail_LTE = RESET;
					LimitAlarmCnt[PATH_LTE] = 0;
				}
			}
			else
			{
				Sts->AlmSts.FwdOutLowerLmtFail_LTE = Normal;
				PwrAlarm.FwdOutLowerLmtFail_LTE = RESET;
				LimitAlarmCnt[PATH_LTE] = 0;
			}

		}
		{
			// LTE Rvs Upper Limit	
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->RvsOutPwr_LTE[0]*2;
			if(Sts->RvsOutPwr_LTE[1] >= 5)DetLvl++;
			LimitLvl		= Sts->RvsOutUpperLmt_LTE[0]*2;
			if(Sts->RvsOutUpperLmt_LTE[1] >= 5)LimitLvl++;
			if(Sd_Step[SD_RO_LTE] != 0)		Sts->AlmSts.RvsOutUpperLmtFail_LTE = Alarm;
			else 							Sts->AlmSts.RvsOutUpperLmtFail_LTE = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.RvsOutUpperLmtFail_LTE);
		}

		{
			// LTE Over In Alarm 
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= -(Sts->FwdInPwr_LTE*1);

			if(tDnrSts->LTE15MUse == __NOTUSE)
			{
				LimitLvl	= FwdOverInAlmLmt_LTE;	// 과입력 Alarm  -21±2dBm~-8±2dBm
			}
			else
			{
				LimitLvl	= FwdOverInAlmLmt_LTE15M;	// 과입력 Alarm  -19±2dBm~-8±2dBm
			}
			
			if(Sd_Step[SD_FI_LTE] != 0)			Sts->AlmSts.FwdInUpperLmtFail_LTE = Alarm;
			else								Sts->AlmSts.FwdInUpperLmtFail_LTE = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdInUpperLmtFail_LTE);
		}
	}
	else
	{
		Sts->AlmSts.FwdOutUpperLmtFail_LTE = Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_LTE = Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_LTE = Normal;
		Sts->AlmSts.FwdInUpperLmtFail_LTE = Normal;
	}
	
	//////////////////CDMA LTE
	{
		// CDMA Over InAlarm 

		INT8S LimitLvl;
		INT8S DetLvl;

		
		if(AlarmCheck_2G == SET)
		{
			DetLvl		= Sts->DetPwr.FwdInPwr_CDMALTE + 25;
			LimitLvl	= Sts->FwdInPwr_2G;
//			if((Sts->AlmSts.FwdAmpOnOff_2G == Enable)&&( Sts->DetPwr.FwdOutAvgPwr_2G  > 0))
			if((Sts->AlmSts.FwdAmpOnOff_2G == Enable)&&( Sts->FwdOutPwr_2G[0] > Sts->FwdOutLowerLmt_2G[0]))
			{
				CurrAlarm.OverInAlarm_CDMALTE_1 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_CDMALTE_1);	//2dB 
			}
		}
		else
		{
			CurrAlarm.OverInAlarm_CDMALTE_1 = Normal;
		}
			
		
		if(AlarmCheck_LTE == SET)
		{
			DetLvl		= Sts->DetPwr.FwdInPwr_CDMALTE + 25;
			LimitLvl	= Sts->FwdInPwr_LTE;

//			if((Sts->AlmSts.FwdAmpOnOff_LTE == Enable)&&( Sts->DetPwr.FwdOutAvgPwr_LTE > 0))
			if((Sts->AlmSts.FwdAmpOnOff_LTE == Enable)&&( Sts->FwdOutPwr_LTE[0] > Sts->FwdOutLowerLmt_LTE[0]))
			{
				CurrAlarm.OverInAlarm_CDMALTE_2 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_CDMALTE_2);	//2dB 
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

			INT8S LimitLvl;
			INT8S DetLvl;
#if 0
			if(Sts->FwdInPwr_2G >= Sts->FwdInPwr_LTE)   	LimitLvl = Sts->FwdInPwr_LTE;
			else if(Sts->FwdInPwr_2G < Sts->FwdInPwr_LTE)	LimitLvl = Sts->FwdInPwr_2G;

			DetLvl	  = Sts->DetPwr.FwdInPwr_CDMALTE + 4;
			CurrAlarm.OverInAlarm_CDMALTE_3 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_CDMALTE_3);	//2dB 
#endif
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

//			SerPtr->printf("2: LimitLvl,DetLvl[%d]\n", CurrAlarm.OverInAlarm_CDMALTE_3);

		}
//////
#if 0
		if(iRepeaterType == _TRIO_MM)
		{
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
		}
		else
		{
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
		}
#endif
///// 2016 01 12
		{
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
	}
	//////////////////LTE-A1
	
	if(AlarmCheck_LTE_A1 == SET)
	{
		{
			if(PLLAlarm_LTE_A1_0)	Sts->AlmSts.LocalFail_LTE_A1	= Normal;
			else					Sts->AlmSts.LocalFail_LTE_A1	= Alarm;
		}
		

		// LTE-A1 FWD OUT High
		{
			INT8S LimitLvl;
			INT8S DetLvl;
			DetLvl		= Sts->FwdOutPwr_LTE_A1[0]*2;
			if(Sts->FwdOutPwr_LTE_A1[1] >= 5)DetLvl++;
			
			LimitLvl		= Sts->FwdOutHighLmt_LTE_A1[0]*2;
			if(Sts->FwdOutHighLmt_LTE_A1[1] >= 5)LimitLvl++;
			

			if(Sd_Step[SD_FO_LTE_A1] != 0)	Sts->AlmSts.FwdOutUpperLmtFail_LTE_A1 = Alarm;
			else 							Sts->AlmSts.FwdOutUpperLmtFail_LTE_A1 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutUpperLmtFail_LTE_A1);
		}

		{
			// LTE-A1 FWD OUT Low
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->FwdOutPwrPeak_LTE_A1[0]*2;
			if(Sts->FwdOutPwrPeak_LTE_A1[1] >= 5)DetLvl++;
			LimitLvl		= Sts->FwdOutLowerLmt_LTE_A1[0]*2;
			if(Sts->FwdOutLowerLmt_LTE_A1[1] >= 5)LimitLvl++;


			if (((tDnrSts->FwdAmpOnOff_LTE_A1 == Disable)&&(tDnrSts->AmpOffCase_LTE_A1 == __UsrCtrl))
				||(Sd_Step[SD_FO_LTE_A1 ] > 1))
			{
				FwdLowMask = RESET;
			}
			else FwdLowMask = SET;

			if(FwdLowMask)
			{
				Sts->AlmSts.FwdOutLowerLmtFail_LTE_A1 = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutLowerLmtFail_LTE_A1);
				if( Sts->AlmSts.FwdOutLowerLmtFail_LTE_A1 == Alarm)
				{
					if(++LimitAlarmCnt[PATH_LTE_A1]>= AlarmCheckTime)
					{
						PwrAlarm.FwdOutLowerLmtFail_LTE_A1 = SET;
						LimitAlarmCnt[PATH_LTE_A1] = AlarmCheckTime;
					}	
				}
				else
				{
					PwrAlarm.FwdOutLowerLmtFail_LTE_A1 = RESET;
					LimitAlarmCnt[PATH_LTE_A1] = 0;
				}
			}
			else
			{
				Sts->AlmSts.FwdOutLowerLmtFail_LTE_A1 = Normal;
				PwrAlarm.FwdOutLowerLmtFail_LTE_A1 = RESET;
				LimitAlarmCnt[PATH_LTE_A1] = 0;
			}
		}

		{
			// LTE-A1 Rvs Upper Limit	
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->RvsOutPwr_LTE_A1[0]*2;
			if(Sts->RvsOutPwr_LTE_A1[1] >= 5)DetLvl++;
			LimitLvl		= Sts->RvsOutUpperLmt_LTE_A1[0]*2;
			if(Sts->RvsOutUpperLmt_LTE_A1[1] >= 5)LimitLvl++;
			
			if(Sd_Step[SD_RO_LTE_A1] != 0)	Sts->AlmSts.RvsOutUpperLmtFail_LTE_A1 = Alarm;
			else 							Sts->AlmSts.RvsOutUpperLmtFail_LTE_A1 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.RvsOutUpperLmtFail_LTE_A1);

		}

		{
			// LTE-A1 Over In Alarm 
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= -(Sts->FwdInPwr_LTE_A1);
			LimitLvl	= Sts->OverInAlarmLmt_LTE_A1/2;// 과입력 Alarm  -15±2dBm

	
			if(Sd_Step[SD_FI_LTE_A1] != 0)	Sts->AlmSts.FwdInUpperLmtFail_LTE_A1 = Alarm;
			else							Sts->AlmSts.FwdInUpperLmtFail_LTE_A1 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdInUpperLmtFail_LTE_A1);

		}
	}
	else
	{
		Sts->AlmSts.LocalFail_LTE_A1		= Normal;
		
		Sts->AlmSts.FwdOutUpperLmtFail_LTE_A1	= Normal;
		Sts->AlmSts.FwdInUpperLmtFail_LTE_A1	= Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_LTE_A1	= Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_LTE_A1	= Normal;
	}

	//////////////////LTE-A2
	if(AlarmCheck_LTE_A2 == SET)
	{
		{
			if(PLLAlarm_LTE_A2_0)	Sts->AlmSts.LocalFail_LTE_A2	= Normal;
			else					Sts->AlmSts.LocalFail_LTE_A2	= Alarm;
		}

		// LTE-A2 FWD OUT High
		{
			INT8S LimitLvl;
			INT8S DetLvl;
			DetLvl		= Sts->FwdOutPwr_LTE_A2[0]*2;
			if(Sts->FwdOutPwr_LTE_A2[1] >= 5)DetLvl++;
			
			LimitLvl		= Sts->FwdOutHighLmt_LTE_A2[0]*2;
			if(Sts->FwdOutHighLmt_LTE_A2[1] >= 5)LimitLvl++;
			
			if(Sd_Step[SD_FO_LTE_A2] != 0)	Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2 = Alarm;
			else							Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2);
		}

		{
			// LTE-A2 FWD OUT Low
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->FwdOutPwrPeak_LTE_A2[0]*2;
			if(Sts->FwdOutPwrPeak_LTE_A2[1] >= 5)DetLvl++;
			LimitLvl		= Sts->FwdOutLowerLmt_LTE_A2[0]*2;
			if(Sts->FwdOutLowerLmt_LTE_A2[1] >= 5)LimitLvl++;

			if (((tDnrSts->FwdAmpOnOff_LTE_A2 == Disable)&&(tDnrSts->AmpOffCase_LTE_A2 == __UsrCtrl))
				||(Sd_Step[SD_FO_LTE_A2 ] > 1))
			{
				FwdLowMask = RESET;
			}
			else FwdLowMask = SET;

			if(FwdLowMask)
			{
				Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2 = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2);

				if( Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2 == Alarm)
				{
					if(++LimitAlarmCnt[PATH_LTE_A2]>= AlarmCheckTime)
					{
						PwrAlarm.FwdOutLowerLmtFail_LTE_A2 = SET;
						LimitAlarmCnt[PATH_LTE_A2] = AlarmCheckTime;
					}	
				}
				else
				{
					PwrAlarm.FwdOutLowerLmtFail_LTE_A2 = RESET;
					LimitAlarmCnt[PATH_LTE_A2] = 0;
				}
			}
			else
			{
				Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2 = Normal;
				PwrAlarm.FwdOutLowerLmtFail_LTE_A2 = RESET;
				LimitAlarmCnt[PATH_LTE_A2] = 0;
			}
		}

		{
			// LTE-A2 Rvs Upper Limit	
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->RvsOutPwr_LTE_A2[0]*2;
			if(Sts->RvsOutPwr_LTE_A2[1] >= 5)DetLvl++;
			LimitLvl		= Sts->RvsOutUpperLmt_LTE_A2[0]*2;
			if(Sts->RvsOutUpperLmt_LTE_A2[1] >= 5)LimitLvl++;

			if(Sd_Step[SD_RO_LTE_A2] != 0)	Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2 = Alarm;
			else							Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2);
		}
		
		{
			// LTE-A2 Over In Alarm 
			INT8S LimitLvl;
			INT8S DetLvl;
			DetLvl		= -(Sts->FwdInPwr_LTE_A2);
			LimitLvl	= Sts->OverInAlarmLmt_LTE_A2/2;

			
			if(Sd_Step[SD_FI_LTE_A2] != 0)	Sts->AlmSts.FwdInUpperLmtFail_LTE_A2 = Alarm;
			else							Sts->AlmSts.FwdInUpperLmtFail_LTE_A2 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdInUpperLmtFail_LTE_A2);
		}
	}	
	else
	{
		Sts->AlmSts.LocalFail_LTE_A2			= Normal;
		Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.FwdInUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2	= Normal;
	}
	
	{
		// LTE_A1 Over InAlarm 

		INT8S LimitLvl;
		INT8S DetLvl;
		
		DetLvl		= Sts->DetPwr.FwdInPwr_LTE_A + 25;
		LimitLvl	= Sts->FwdInPwr_LTE_A1;

		if(AlarmCheck_LTE_A1 == SET)
		{
			if((Sts->AlmSts.FwdAmpOnOff_LTE_A1 == Enable)&&( Sts->DetPwr.FwdOutPeakPwr_LTE_A1 > 0))
			{
				CurrAlarm.OverInAlarm_LTE_A1 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A1);	//2dB 
			}
			else
			{
				CurrAlarm.OverInAlarm_LTE_A1 = Normal;
			}
		}
		else	CurrAlarm.OverInAlarm_LTE_A1 = Normal;

	
		if(AlarmCheck_LTE_A2 == SET)
		{
			DetLvl		= Sts->DetPwr.FwdInPwr_LTE_A + 25;
			LimitLvl	= Sts->FwdInPwr_LTE_A2;
			if((Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Enable)&&( Sts->DetPwr.FwdOutPeakPwr_LTE_A2 > 0))
			{
				CurrAlarm.OverInAlarm_LTE_A2 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A2);	//2dB 
			}
			else
			{
				CurrAlarm.OverInAlarm_LTE_A2 = Normal;
			}
		}
		else	CurrAlarm.OverInAlarm_LTE_A2 = Normal;


		if((AlarmCheck_LTE_A1 == SET)&&(AlarmCheck_LTE_A2 == SET))
		{

			INT8S LimitLvl;
			INT8S DetLvl;
#if 0
			if(Sts->FwdInPwr_LTE_A1 >= Sts->FwdInPwr_LTE_A2)   		LimitLvl = Sts->FwdInPwr_LTE_A2;
			else if(Sts->FwdInPwr_LTE_A1 < Sts->FwdInPwr_LTE_A2)	LimitLvl = Sts->FwdInPwr_LTE_A1;

			DetLvl	  = Sts->DetPwr.FwdInPwr_LTE_A+4;
			LimitLvl  = LimitLvl ;
			CurrAlarm.OverInAlarm_LTE_A = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A);	//2dB 
#endif
			if(Sts->FwdInPwr_LTE_A1 >= Sts->FwdInPwr_LTE_A2)		
			{
				LimitLvl = Sts->FwdInPwr_LTE_A2;
				DetLvl	 = Sts->FwdInPwr_LTE_A1 - 25;
			
			}
			else if(Sts->FwdInPwr_LTE_A1 < Sts->FwdInPwr_LTE_A2)	
			{
				LimitLvl = Sts->FwdInPwr_LTE_A1;
				DetLvl	 = Sts->FwdInPwr_LTE_A2 - 25;
			}
			CurrAlarm.OverInAlarm_LTE_A = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A);	//2dB 

		}		
	}

	//////////////////WCDMA
	{
		{
			if(PLLAlarm_WCDMA)		Sts->AlmSts.LocalFail_3G		= Normal;
			else					Sts->AlmSts.LocalFail_3G		= Alarm;
		}


		// WCDMA FWD OUT High
		{
			INT8S LimitLvl;
			INT8S DetLvl;
			DetLvl		= Sts->FwdOutPwr_3G[0]*2;
			if(Sts->FwdOutPwr_3G[1] >= 5)DetLvl++;
			
			LimitLvl		= Sts->FwdOutHighLmt_3G[0]*2;
			if(Sts->FwdOutHighLmt_3G[1] >= 5)LimitLvl++;

			
			if(Sd_Step[SD_FO_3G] != 0)	Sts->AlmSts.FwdOutUpperLmtFail_3G = Alarm;
			else						Sts->AlmSts.FwdOutUpperLmtFail_3G = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutUpperLmtFail_3G);
		}

		{
			// WCDMA FWD OUT Low
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->FwdOutPwr_3G[0]*2;
			if(Sts->FwdOutPwr_3G[1] >= 5)DetLvl++;
			LimitLvl		= Sts->FwdOutLowerLmt_3G[0]*2;
			if(Sts->FwdOutLowerLmt_3G[1] >= 5)LimitLvl++;

			if (((tDnrSts->FwdAmpOnOff_3G == Disable)&&(tDnrSts->AmpOffCase_3G == __UsrCtrl))
				||(Sd_Step[SD_FO_3G] > 1))
			{
				FwdLowMask = RESET;
			}
			else FwdLowMask = SET;

			if(FwdLowMask)
			{
				Sts->AlmSts.FwdOutLowerLmtFail_3G = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdOutLowerLmtFail_3G);
				if( Sts->AlmSts.FwdOutLowerLmtFail_3G == Alarm)
				{
					if(++LimitAlarmCnt[PATH_3G]>=AlarmCheckTime)
					{
						PwrAlarm.FwdOutLowerLmtFail_3G = SET;
						LimitAlarmCnt[PATH_3G] = AlarmCheckTime;
					}	
				}
				else
				{
					PwrAlarm.FwdOutLowerLmtFail_3G = RESET;
					LimitAlarmCnt[PATH_3G] = 0;
				}
			}
			else
			{
				Sts->AlmSts.FwdOutLowerLmtFail_3G = Normal;
				PwrAlarm.FwdOutLowerLmtFail_3G = RESET;
				LimitAlarmCnt[PATH_3G] = 0;
			}
		}

		{
			// WCDMA Rvs Upper Limit	
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->RvsOutPwr_3G[0]*2;
			if(Sts->RvsOutPwr_3G[1] >= 5)DetLvl++;
			LimitLvl		= Sts->RvsOutUpperLmt_3G[0]*2;
			if(Sts->RvsOutUpperLmt_3G[1] >= 5)LimitLvl++;
			
			if(Sd_Step[SD_RO_3G] != 0)	Sts->AlmSts.RvsOutUpperLmtFail_3G = Alarm;
			else						Sts->AlmSts.RvsOutUpperLmtFail_3G = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.RvsOutUpperLmtFail_3G);

		}


		{
			// WCDMA Over In Alarm 
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= -(Sts->FwdInPwr_3G*1);
			LimitLvl	= Sts->OverInAlarmLmt_3G/2;	//-36*2
			if(Sd_Step[SD_FI_3G] != 0)	Sts->AlmSts.FwdInUpperLmtFail_3G = Alarm;
			else 						Sts->AlmSts.FwdInUpperLmtFail_3G = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.FwdInUpperLmtFail_3G);
		}
		
		{
			// WCDMA Over InAlarm 
			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->DetPwr.FwdInPwr_3G + 25;
			LimitLvl	= Sts->FwdInPwr_3G;
			if((Sts->AlmSts.FwdAmpOnOff_3G == Enable)&&( Sts->DetPwr.FwdOutAvgPwr_3G  > 0))
			{
				Sts->AlmSts.OverInAlarm_3G = LowLimitCheck(DetLvl, LimitLvl, 1, Sts->AlmSts.OverInAlarm_3G);	//2dB 
			}
			else  Sts->AlmSts.OverInAlarm_3G = Normal;
		}
	}

	if(iRepeaterType == _TRIO_MM)
	{
		//////////////////LTE MOMO
		
		if(AlarmCheck_LTE_1 == SET)
		{
			{
				if(PLLAlarm_LTE_1)		Sts->AlmSts.LocalFail_LTE_1 	= Normal;
				else					Sts->AlmSts.LocalFail_LTE_1 	= Alarm;
			}
			


			// LTE MOMO FWD OUT High
			{
				INT8S LimitLvl;
				INT8S DetLvl;
				DetLvl		= Sts->Fwd1OutPwr_LTE[0]*2;
				if(Sts->Fwd1OutPwr_LTE[1] >= 5)DetLvl++;
				
				LimitLvl		= Sts->Fwd1OutHighLmt_LTE[0]*2;
				if(Sts->Fwd1OutHighLmt_LTE[1] >= 5)LimitLvl++;
				
				if(Sd_Step[SD_FO_LTE_1] != 0)	Sts->AlmSts.Fwd1OutUpperLmtFail_LTE = Alarm;
				else							Sts->AlmSts.Fwd1OutUpperLmtFail_LTE = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1OutUpperLmtFail_LTE);
			}
	
			{
				// LTE MOMO FWD OUT Low
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= Sts->Fwd1OutPwrPeak_LTE[0]*2;
				if(Sts->Fwd1OutPwrPeak_LTE[1] >= 5)DetLvl++;
				LimitLvl		= Sts->Fwd1OutLowerLmt_LTE[0]*2;
				if(Sts->Fwd1OutLowerLmt_LTE[1] >= 5)LimitLvl++;


				if (((tDnrSts->FwdAmp1OnOff_LTE == Disable)&&(tDnrSts->Amp1OffCase_LTE== __UsrCtrl))
					||(Sd_Step[SD_FO_LTE_1] > 1))
				{
					FwdLowMask = RESET;
				}
				else FwdLowMask = SET;
				
				if(FwdLowMask)
				{
					Sts->AlmSts.Fwd1OutLowerLmtFail_LTE = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1OutLowerLmtFail_LTE);

					if( Sts->AlmSts.Fwd1OutLowerLmtFail_LTE == Alarm)
					{
						if(++LimitAlarmCnt[PATH_LTE_1]>=AlarmCheckTime)
						{
							PwrAlarm.Fwd1OutLowerLmtFail_LTE = SET;
							LimitAlarmCnt[PATH_LTE_1] = AlarmCheckTime;
						}	
					}
					else
					{
						PwrAlarm.Fwd1OutLowerLmtFail_LTE = RESET;
						LimitAlarmCnt[PATH_LTE_1] = 0;
					}		
				}
				else
				{
					Sts->AlmSts.Fwd1OutLowerLmtFail_LTE = Normal;
					PwrAlarm.Fwd1OutLowerLmtFail_LTE = RESET;
					LimitAlarmCnt[PATH_LTE_1] = 0;
				}
			}
			
			{
				// LTE MOMO Rvs Upper Limit	
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= Sts->Rvs1OutPwr_LTE[0]*2;
				if(Sts->Rvs1OutPwr_LTE[1] >= 5)DetLvl++;
				LimitLvl		= Sts->Rvs1OutUpperLmt_LTE[0]*2;
				if(Sts->Rvs1OutUpperLmt_LTE[1] >= 5)LimitLvl++;

				if(Sd_Step[SD_RO_LTE_1] != 0)	Sts->AlmSts.Rvs1OutUpperLmtFail_LTE = Alarm;
				else							Sts->AlmSts.Rvs1OutUpperLmtFail_LTE = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Rvs1OutUpperLmtFail_LTE);
			}
			
			{
				// LTE Over In Alarm 
				INT8S LimitLvl;
				INT8S DetLvl;
				DetLvl		= -(Sts->Fwd1InPwr_LTE);
				LimitLvl	= Sts->OverInAlarmLmt_LTE/2;

				
				if(Sd_Step[SD_FI_LTE_1] != 0)	Sts->AlmSts.Fwd1InUpperLmtFail_LTE = Alarm;
				else							Sts->AlmSts.Fwd1InUpperLmtFail_LTE = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1InUpperLmtFail_LTE);
			}
		}
		else
		{
			Sts->AlmSts.Fwd1OutUpperLmtFail_LTE = Normal;
			Sts->AlmSts.Fwd1OutLowerLmtFail_LTE = Normal;
			Sts->AlmSts.Rvs1OutUpperLmtFail_LTE = Normal;
			Sts->AlmSts.Fwd1InUpperLmtFail_LTE = Normal;
		}
/////////////////////////////////////////
		{
			// LTE MIMO Over InAlarm 

			INT8S LimitLvl;
			INT8S DetLvl;
			
			DetLvl		= Sts->Det1Pwr.Fwd1InPwr_LTE + 25;
			LimitLvl	= Sts->Fwd1InPwr_LTE;

			if((Sts->AlmSts.FwdAmp1OnOff_LTE == Enable)&&( Sts->Det1Pwr.Fwd1OutAvgPwr_LTE > 0))
			{
				CurrAlarm.OverInAlarm_LTE_1 = LowLimitCheck(DetLvl, LimitLvl, 2, CurrAlarm.OverInAlarm_LTE_1);	//2dB 
			}
			else
			{
				CurrAlarm.OverInAlarm_LTE_1 = Normal;
			}
		}
/////////////////////////////////////////
		//////////////////LTE-A1 MOMO
		if(AlarmCheck_LTE_A1_1 == SET)
		{

			{
				if(PLLAlarm_LTE_A1_1)	Sts->AlmSts.LocalFail_LTE_A1_1	= Normal;
				else					Sts->AlmSts.LocalFail_LTE_A1_1	= Alarm;
			}
			

			// LTE-A1 MOMO FWD OUT High
			{
				INT8S LimitLvl;
				INT8S DetLvl;
				DetLvl		= Sts->Fwd1OutPwr_LTE_A1[0]*2;
				if(Sts->Fwd1OutPwr_LTE_A1[1] >= 5)DetLvl++;
				
				LimitLvl		= Sts->Fwd1OutHighLmt_LTE_A1[0]*2;
				if(Sts->Fwd1OutHighLmt_LTE_A1[1] >= 5)LimitLvl++;

				if(Sd_Step[SD_FO_LTE_A1_1] != 0)	Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A1 = Alarm;
				else								Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A1 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A1);

			}
	
			{
				// LTE-A1 MOMO FWD OUT Low
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= Sts->Fwd1OutPwrPeak_LTE_A1[0]*2;
				if(Sts->Fwd1OutPwrPeak_LTE_A1[1] >= 5)DetLvl++;
				LimitLvl		= Sts->Fwd1OutLowerLmt_LTE_A1[0]*2;
				if(Sts->Fwd1OutLowerLmt_LTE_A1[1] >= 5)LimitLvl++;

				if (((tDnrSts->FwdAmp1OnOff_LTE_A1 == Disable)&&(tDnrSts->Amp1OffCase_LTE_A1 == __UsrCtrl))
						||(Sd_Step[SD_FO_LTE_A1_1] > 1))
				{
					FwdLowMask = RESET;
				}
				else FwdLowMask = SET;
				
				if(FwdLowMask)
				{
					Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1 = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1);

					if( Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1 == Alarm)
					{
						if(++LimitAlarmCnt[PATH_LTE_A1_1]>=AlarmCheckTime)
						{
							PwrAlarm.Fwd1OutLowerLmtFail_LTE_A1 = SET;
							LimitAlarmCnt[PATH_LTE_A1_1] = AlarmCheckTime;
						}	
					}
					else
					{
						PwrAlarm.Fwd1OutLowerLmtFail_LTE_A1 = RESET;
						LimitAlarmCnt[PATH_LTE_A1_1] = 0;
					}
				}
				else
				{
					Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1 = Normal;
					PwrAlarm.Fwd1OutLowerLmtFail_LTE_A1 = RESET;
					LimitAlarmCnt[PATH_LTE_A1_1] = 0;
				}
			}
	
			{
				// LTE-A1 MOMO Rvs Upper Limit	
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= Sts->Rvs1OutPwr_LTE_A1[0]*2;
				if(Sts->Rvs1OutPwr_LTE_A1[1] >= 5)DetLvl++;
				LimitLvl		= Sts->Rvs1OutUpperLmt_LTE_A1[0]*2;
				if(Sts->Rvs1OutUpperLmt_LTE_A1[1] >= 5)LimitLvl++;

				if(Sd_Step[SD_RO_LTE_A1_1] != 0)	Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A1 = Alarm;
				else								Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A1 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A1);
			}
			
			{
				// LTE-A1 Over In Alarm 
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= -(Sts->Fwd1InPwr_LTE_A1);
				LimitLvl	= Sts->OverInAlarmLmt_LTE_A1/2;

				if(Sd_Step[SD_FI_LTE_A1_1] != 0)	Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A1 = Alarm;
				else								Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A1 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A1);

			}
		}
		else
		{
 			Sts->AlmSts.LocalFail_LTE_A1_1 	= Normal;
 			
			Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A1 	= Normal;
			Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A1	= Normal;
			Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A1 	= Normal;
			Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1 	= Normal;
 		}

		//////////////////LTE-A2 MOMO
		if(AlarmCheck_LTE_A2_1 == SET)
		{
			{
				if(PLLAlarm_LTE_A2_1)	Sts->AlmSts.LocalFail_LTE_A2_1	= Normal;
				else					Sts->AlmSts.LocalFail_LTE_A2_1	= Alarm;
			}

			// LTE-A2 MOMO FWD OUT High
			{
				INT8S LimitLvl;
				INT8S DetLvl;
				DetLvl		= Sts->Fwd1OutPwr_LTE_A2[0]*2;
				if(Sts->Fwd1OutPwr_LTE_A2[1] >= 5)DetLvl++;
				
				LimitLvl		= Sts->Fwd1OutHighLmt_LTE_A2[0]*2;
				if(Sts->Fwd1OutHighLmt_LTE_A2[1] >= 5)LimitLvl++;

				
				if(Sd_Step[SD_FO_LTE_A2_1] != 0)	Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A2 = Alarm;
				else								Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A2 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A2);
			}

			{
				// LTE-A2 MOMO FWD OUT Low
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= Sts->Fwd1OutPwrPeak_LTE_A2[0]*2;
				if(Sts->Fwd1OutPwrPeak_LTE_A2[1] >= 5)DetLvl++;
				LimitLvl		= Sts->Fwd1OutLowerLmt_LTE_A2[0]*2;
				if(Sts->Fwd1OutLowerLmt_LTE_A2[1] >= 5)LimitLvl++;

				if (((tDnrSts->FwdAmp1OnOff_LTE_A2 == Disable)&&(tDnrSts->Amp1OffCase_LTE_A2 == __UsrCtrl))
						||(Sd_Step[SD_FO_LTE_A2_1] > 1))
				{
					FwdLowMask = RESET;
				}
				else FwdLowMask = SET;
				
				if(FwdLowMask)
				{
					Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2 = LowLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2);

					if( Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2 == Alarm)
					{
						if(++LimitAlarmCnt[PATH_LTE_A2_1]>=AlarmCheckTime)
						{
							PwrAlarm.Fwd1OutLowerLmtFail_LTE_A2 = SET;
							LimitAlarmCnt[PATH_LTE_A2_1] = AlarmCheckTime;
						}	
					}
					else
					{
						PwrAlarm.Fwd1OutLowerLmtFail_LTE_A2 = RESET;
						LimitAlarmCnt[PATH_LTE_A2_1] = 0;
					}					
				}
				else
				{
					Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2 = Normal;
					PwrAlarm.Fwd1OutLowerLmtFail_LTE_A2 = RESET;
					LimitAlarmCnt[PATH_LTE_A2_1] = 0;
				}
			}

			{
				// LTE-A2 MOMO Rvs Upper Limit	
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= Sts->Rvs1OutPwr_LTE_A2[0]*2;
				if(Sts->Rvs1OutPwr_LTE_A2[1] >= 5)DetLvl++;
				LimitLvl		= Sts->Rvs1OutUpperLmt_LTE_A2[0]*2;
				if(Sts->Rvs1OutUpperLmt_LTE_A2[1] >= 5)LimitLvl++;

				if(Sd_Step[SD_RO_LTE_A2_1] != 0)	Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A2 = Alarm;
				else								Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A2 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A2);
			}

			{
				// LTE-A2 Over In Alarm 
				INT8S LimitLvl;
				INT8S DetLvl;
				
				DetLvl		= -(Sts->Fwd1InPwr_LTE_A2);
				LimitLvl	= Sts->OverInAlarmLmt_LTE_A2/2;
				
				if(Sd_Step[SD_FI_LTE_A2_1] != 0)	Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A2 = Alarm;
				else								Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A2 = HighLimitCheck(DetLvl, LimitLvl, 2, Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A2);
			}
		}
		else
		{
			Sts->AlmSts.LocalFail_LTE_A2_1 	= Normal;

			Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A2 = Normal;
			Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A2	= Normal;
			Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A2 = Normal;
			Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2 = Normal;
		}

		{
			// LTE_A1 Over InAlarm 

			INT8S LimitLvl;
			INT8S DetLvl;
			
			if(AlarmCheck_LTE_A1_1 == SET)
			{
				DetLvl		= Sts->Det1Pwr.FwdInPwr_LTE_A_1 + 25;
				LimitLvl	= Sts->Fwd1InPwr_LTE_A1;

				if((Sts->AlmSts.FwdAmp1OnOff_LTE_A1 == Enable)&&( Sts->Det1Pwr.Fwd1OutPeakPwr_LTE_A1> 0))
				{
					CurrAlarm.OverInAlarm_LTE_A1_1 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A1_1);	//2dB 
				}
				else
				{
					CurrAlarm.OverInAlarm_LTE_A1_1 = Normal;
				}
			}
			else
			{
				CurrAlarm.OverInAlarm_LTE_A1_1 = Normal;
			}

		
			if(AlarmCheck_LTE_A2_1 == SET)
			{
				DetLvl		= Sts->Det1Pwr.FwdInPwr_LTE_A_1 + 25;
				LimitLvl	= Sts->Fwd1InPwr_LTE_A2;
				if((Sts->AlmSts.FwdAmp1OnOff_LTE_A2 == Enable)&&( Sts->Det1Pwr.Fwd1OutPeakPwr_LTE_A2> 0))
				{
					CurrAlarm.OverInAlarm_LTE_A2_1 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A2_1);	//2dB 
				}
				else
				{
					CurrAlarm.OverInAlarm_LTE_A2_1 = Normal;
				}
			}
			else
			{
				CurrAlarm.OverInAlarm_LTE_A2_1 = Normal;
			}

			if((AlarmCheck_LTE_A1_1 == SET)&&(AlarmCheck_LTE_A2_1 == SET))
			{

				INT8S LimitLvl;
				INT8S DetLvl;
#if 0
				if(Sts->Fwd1InPwr_LTE_A1 >= Sts->Fwd1InPwr_LTE_A2)   		LimitLvl = Sts->Fwd1InPwr_LTE_A2;
				else if(Sts->Fwd1InPwr_LTE_A1 < Sts->Fwd1InPwr_LTE_A2)		LimitLvl = Sts->Fwd1InPwr_LTE_A1;

				DetLvl	  = Sts->Det1Pwr.FwdInPwr_LTE_A_1+4;
				LimitLvl  = LimitLvl;
				CurrAlarm.OverInAlarm_LTE_A_1 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A_1);	//2dB 
#endif

				if(Sts->Fwd1InPwr_LTE_A1 >= Sts->Fwd1InPwr_LTE_A2)		
				{
					LimitLvl = Sts->Fwd1InPwr_LTE_A2;
					DetLvl	 = Sts->Fwd1InPwr_LTE_A1 + 25;
				
				}
				else if(Sts->Fwd1InPwr_LTE_A1 < Sts->Fwd1InPwr_LTE_A2)	
				{
					LimitLvl = Sts->Fwd1InPwr_LTE_A1;
					DetLvl	 = Sts->Fwd1InPwr_LTE_A2 + 25;
				}
				CurrAlarm.OverInAlarm_LTE_A_1 = LowLimitCheck(DetLvl, LimitLvl, 1, CurrAlarm.OverInAlarm_LTE_A_1);	//2dB 


			}	
		}
	}

	if(iRepeaterType == _TRIO_MM)
	{
#if 1  ///20151223 Adder
		if((AlarmCheck_LTE_A1 == SET)&&(AlarmCheck_LTE_A2 == SET))
		{
			if	((CurrAlarm.OverInAlarm_LTE_A1)||(CurrAlarm.OverInAlarm_LTE_A2)||
				(CurrAlarm.OverInAlarm_LTE_A1_1||CurrAlarm.OverInAlarm_LTE_A2_1))
			{
				if((CurrAlarm.OverInAlarm_LTE_A)||CurrAlarm.OverInAlarm_LTE_A_1)
				{
					Sts->AlmSts.OverInAlarm_LTE_A = Alarm;
					}
				else Sts->AlmSts.OverInAlarm_LTE_A = Normal;
			}
			else Sts->AlmSts.OverInAlarm_LTE_A = Normal;
		}
		else if(AlarmCheck_LTE_A1 == SET)
		{
			if((CurrAlarm.OverInAlarm_LTE_A1)||(CurrAlarm.OverInAlarm_LTE_A1_1))
			{
				Sts->AlmSts.OverInAlarm_LTE_A = Alarm;
			}
			else Sts->AlmSts.OverInAlarm_LTE_A = Normal;
		}
		else if(AlarmCheck_LTE_A2 == SET)
		{
			if((CurrAlarm.OverInAlarm_LTE_A2)||(CurrAlarm.OverInAlarm_LTE_A2_1))
			{
				Sts->AlmSts.OverInAlarm_LTE_A = Alarm;
			}
			else Sts->AlmSts.OverInAlarm_LTE_A = Normal;
		}
#endif
	}
	else
	{
#if 1  ///20151223 Adder
		if((AlarmCheck_LTE_A1 == SET)&&(AlarmCheck_LTE_A2 == SET))
		{
			if	((CurrAlarm.OverInAlarm_LTE_A1)||(CurrAlarm.OverInAlarm_LTE_A2))
			{
				if(CurrAlarm.OverInAlarm_LTE_A)
				{
					Sts->AlmSts.OverInAlarm_LTE_A = Alarm;
				}
				else Sts->AlmSts.OverInAlarm_LTE_A = Normal;
			}
			else Sts->AlmSts.OverInAlarm_LTE_A = Normal;

		}
		else if(AlarmCheck_LTE_A1 == SET)
		{
			if((CurrAlarm.OverInAlarm_LTE_A1))
			{
				Sts->AlmSts.OverInAlarm_LTE_A = Alarm;
			}
			else Sts->AlmSts.OverInAlarm_LTE_A = Normal;
		}
		else if(AlarmCheck_LTE_A2 == SET)
		{
			if((CurrAlarm.OverInAlarm_LTE_A2))
			{
				Sts->AlmSts.OverInAlarm_LTE_A = Alarm;
			}
			else Sts->AlmSts.OverInAlarm_LTE_A = Normal;
		}
#endif

	}

	if(Sts->AlmSts.FwdAmpOnOff_LTE == Enable)
	{
		///LTE800 Uplink 자/타사 과입력 Alarm Count

#if 0
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
#endif
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

	if (Sts->ModuleAlarm.Main.RvsOverInAlarm ) RvsOverInAlarmCnt = RvsOverInAlarmCnt + 1;

	if((RvsOverInAlarmCnt > 4) && ( ChkRvsOverInAlarm)) 
	{
		Sts->RvsOverInAlarmCount = Sts->RvsOverInAlarmCount + 1 ;
		ChkRvsOverInAlarm = RESET;
	}
	if( Sts->RvsOverInAlarmCount > 127) Sts->RvsOverInAlarmCount = 1;

	if (Sts->ModuleAlarm.Main.RvsOtherOverInAlarm ) RvsOtherOverInAlarmCnt = RvsOtherOverInAlarmCnt + 1;

	if((RvsOtherOverInAlarmCnt > 6) && ( ChkRvsOtherOverInAlarm)) 
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


	if(AlarmCheck_LTE_A1 == SET)
	{
		if((Sts->AlmSts.FwdOutUpperLmtFail_LTE_A1)||(Sts->AlmSts.FwdInUpperLmtFail_LTE_A1))
		{
			Sts->LedAlarm._LED_LTE_A1.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_LTE_A1.OverInAlarm = Normal;
		}
		
		Sts->LedAlarm._LED_LTE_A1.RvsOscAlarm	= Sts->AlmSts.RvsOutUpperLmtFail_LTE_A1;
		Sts->LedAlarm._LED_LTE_A1.LowInputAlarm = Sts->AlmSts.FwdOutLowerLmtFail_LTE_A1;
		Sts->LedAlarm._LED_LTE_A1.PllUnlock 	= Sts->AlmSts.LocalFail_LTE_A1;
		Sts->LedAlarm._LED_LTE_A1.ShutDown		= Sts->AlmSts.FwdAmpOnOff_LTE_A1;
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

	if(AlarmCheck_LTE_1 == SET)
	{
		if((Sts->AlmSts.Fwd1OutUpperLmtFail_LTE))
		{
			Sts->LedAlarm._LED_LTE1.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_LTE1.OverInAlarm = Normal;
		}
		Sts->LedAlarm._LED_LTE1.RvsOscAlarm		= Sts->AlmSts.Rvs1OutUpperLmtFail_LTE;
		Sts->LedAlarm._LED_LTE1.LowInputAlarm 	= Sts->AlmSts.Fwd1OutLowerLmtFail_LTE;
		Sts->LedAlarm._LED_LTE1.PllUnlock 		= Sts->AlmSts.LocalFail_LTE_1;
		Sts->LedAlarm._LED_LTE1.ShutDown		= Sts->AlmSts.FwdAmp1OnOff_LTE;
	}

	if(AlarmCheck_LTE_A1_1 == SET)
	{
		if((Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A1))
		{
			Sts->LedAlarm._LED_LTE_A1_1.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_LTE_A1_1.OverInAlarm = Normal;
		}


		Sts->LedAlarm._LED_LTE_A1_1.RvsOscAlarm		= Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A1;
		Sts->LedAlarm._LED_LTE_A1_1.LowInputAlarm	= Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A1;
		Sts->LedAlarm._LED_LTE_A1_1.PllUnlock		= Sts->AlmSts.LocalFail_LTE_A1_1;
		Sts->LedAlarm._LED_LTE_A1_1.ShutDown		= Sts->AlmSts.FwdAmp1OnOff_LTE_A1;
	}

	if(AlarmCheck_LTE_A2_1 == SET)
	{
		if((Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A2))
		{
			Sts->LedAlarm._LED_LTE_A2_1.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_LTE_A2_1.OverInAlarm = Normal;
		}
		Sts->LedAlarm._LED_LTE_A2_1.RvsOscAlarm		= Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A2;
		Sts->LedAlarm._LED_LTE_A2_1.LowInputAlarm	= Sts->AlmSts.Fwd1OutLowerLmtFail_LTE_A2;
		Sts->LedAlarm._LED_LTE_A2_1.PllUnlock		= Sts->AlmSts.LocalFail_LTE_A2_1;
		Sts->LedAlarm._LED_LTE_A2_1.ShutDown		= Sts->AlmSts.FwdAmp1OnOff_LTE_A2;
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

	if(AlarmCheck_LTE_A1 == SET)
	{
		if(Sd_Step[SD_FI_LTE_A1] >= 3) 	PwrAlarm.FwdInUpperLmtFail_LTE_A1	= Sts->AlmSts.FwdInUpperLmtFail_LTE_A1;
		else							PwrAlarm.FwdInUpperLmtFail_LTE_A1	= 0;
		
		if(Sd_Step[SD_FO_LTE_A1] >= 3) 	PwrAlarm.FwdOutUpperLmtFail_LTE_A1	= Sts->AlmSts.FwdOutUpperLmtFail_LTE_A1;
		else							PwrAlarm.FwdOutUpperLmtFail_LTE_A1	= 0;

		if(Sd_Step[SD_FO_LTE_A1] >= 3)	PwrAlarm.RvsOutUpperLmtFail_LTE_A1	= Sts->AlmSts.RvsOutUpperLmtFail_LTE_A1;
		else							PwrAlarm.RvsOutUpperLmtFail_LTE_A1	= 0;

		PwrAlarm.LocalFail_LTE_A1			= Sts->AlmSts.LocalFail_LTE_A1;

//		if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
#if 0
		if((PwrAlarm.ACFail))
		{

		}
		else
		{
			PwrAlarm.FwdAmpOnOff_LTE_A1 	= Sts->AlmSts.FwdAmpOnOff_LTE_A1;
		}
#endif		
	}

	
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
	
	if((AlarmCheck_LTE_A1 == SET)||(AlarmCheck_LTE_A2 == SET))
	{
		PwrAlarm.OverInAlarm_LTE_A1			= Sts->AlmSts.OverInAlarm_LTE_A;
	}

	
	
	if(AlarmCheck_LTE_1 == SET)
	{
		if(Sd_Step[SD_FI_LTE_1] >= 3) 	PwrAlarm.Fwd1InUpperLmtFail_LTE		= Sts->AlmSts.Fwd1InUpperLmtFail_LTE;
		else							PwrAlarm.Fwd1InUpperLmtFail_LTE	= 0;

		if(Sd_Step[SD_FO_LTE_1] >= 3) 	PwrAlarm.Fwd1OutUpperLmtFail_LTE	= Sts->AlmSts.Fwd1OutUpperLmtFail_LTE;
		else							PwrAlarm.Fwd1OutUpperLmtFail_LTE	= 0;
		if(Sd_Step[SD_FO_LTE_1] >= 3)	PwrAlarm.Rvs1OutUpperLmtFail_LTE	= Sts->AlmSts.Rvs1OutUpperLmtFail_LTE;
		else							PwrAlarm.Rvs1OutUpperLmtFail_LTE	= 0;
		PwrAlarm.LocalFail_LTE_1			= Sts->AlmSts.LocalFail_LTE_1;
	}
	
	if(AlarmCheck_LTE_A1_1 == SET)
	{
		if(Sd_Step[SD_FI_LTE_A1_1] >= 3) 	PwrAlarm.Fwd1InUpperLmtFail_LTE_A1	= Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A1;
		else								PwrAlarm.Fwd1InUpperLmtFail_LTE_A1	= 0;
		if(Sd_Step[SD_FO_LTE_A1_1] >= 3) 	PwrAlarm.Fwd1OutUpperLmtFail_LTE_A1	= Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A1;
		else								PwrAlarm.Fwd1OutUpperLmtFail_LTE_A1	= 0;
		if(Sd_Step[SD_FO_LTE_A1_1] >= 3)	PwrAlarm.Rvs1OutUpperLmtFail_LTE_A1	= Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A1;	
		else								PwrAlarm.Rvs1OutUpperLmtFail_LTE_A1	= 0;
		PwrAlarm.LocalFail_LTE_A1_1			= Sts->AlmSts.LocalFail_LTE_A1_1;

//		if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
#if 0
		if((PwrAlarm.ACFail))
		{

		}
		else
		{
			PwrAlarm.FwdAmp1OnOff_LTE_A1 	= Sts->AlmSts.FwdAmp1OnOff_LTE_A1;
		}	
#endif		
	}
	
	if(AlarmCheck_LTE_A2_1 == SET)
	{
		if(Sd_Step[SD_FI_LTE_A2_1] >= 3) 	PwrAlarm.Fwd1InUpperLmtFail_LTE_A2	= Sts->AlmSts.Fwd1InUpperLmtFail_LTE_A2;
		else								PwrAlarm.Fwd1InUpperLmtFail_LTE_A2	= 0;
		if(Sd_Step[SD_FO_LTE_A2_1] >= 3) 	PwrAlarm.Fwd1OutUpperLmtFail_LTE_A2	= Sts->AlmSts.Fwd1OutUpperLmtFail_LTE_A2; 	
		else								PwrAlarm.Fwd1OutUpperLmtFail_LTE_A2	= 0;
		if(Sd_Step[SD_FO_LTE_A2_1] >= 3)	PwrAlarm.Rvs1OutUpperLmtFail_LTE_A2	= Sts->AlmSts.Rvs1OutUpperLmtFail_LTE_A2;	
		else								PwrAlarm.Rvs1OutUpperLmtFail_LTE_A2	= 0;
		PwrAlarm.LocalFail_LTE_A2_1			= Sts->AlmSts.LocalFail_LTE_A2_1;
		
//		if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
#if 0
		if((PwrAlarm.ACFail))
		{

		}
		else
		{
			PwrAlarm.FwdAmp1OnOff_LTE_A2 	= Sts->AlmSts.FwdAmp1OnOff_LTE_A2;
		}
#endif		
	}
	
//	if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail))
	if((PwrAlarm.ACFail))
	{

	}
	else
	{
#if 0
		if (Sts->AmpOffCase_2G == CASE_User)
		{
			PwrAlarm.FwdAmpOnOff_2G 		= Sts->AlmSts.FwdAmpOnOff_2G;
		}
		if (Sts->AmpOffCase_3G == CASE_User)
		{
			PwrAlarm.FwdAmpOnOff_3G 		= Sts->AlmSts.FwdAmpOnOff_3G;
		}

		if (Sts->AmpOffCase_LTE== CASE_User)
		{
			PwrAlarm.FwdAmpOnOff_LTE = Sts->AlmSts.FwdAmpOnOff_LTE;
		}

		if (Sts->AmpOffCase_LTE_A1 == CASE_User)
		{
			PwrAlarm.FwdAmpOnOff_LTE_A1 = Sts->AlmSts.FwdAmpOnOff_LTE_A1;
		}

		if (Sts->AmpOffCase_LTE_A2 == CASE_User)
		{
			PwrAlarm.FwdAmpOnOff_LTE_A2 = Sts->AlmSts.FwdAmpOnOff_LTE_A2;
		}

		
		if (Sts->Amp1OffCase_LTE== CASE_User)
		{
			PwrAlarm.FwdAmp1OnOff_LTE= Sts->AlmSts.FwdAmp1OnOff_LTE;
		}
		
		if (Sts->Amp1OffCase_LTE_A1 == CASE_User)
		{
			PwrAlarm.FwdAmp1OnOff_LTE_A1 = Sts->AlmSts.FwdAmp1OnOff_LTE_A1;
		}

		if (Sts->Amp1OffCase_LTE_A2 == CASE_User)
		{
			PwrAlarm.FwdAmp1OnOff_LTE_A2 = Sts->AlmSts.FwdAmp1OnOff_LTE_A2;
		}
#endif

#if 1  ///20151207 Adder
		PwrAlarm.FwdAmpOnOff_3G 		= Sts->AlmSts.FwdAmpOnOff_3G;
		if(AlarmCheck_2G == SET)		PwrAlarm.FwdAmpOnOff_2G 		= Sts->AlmSts.FwdAmpOnOff_2G;
		if(AlarmCheck_LTE == SET)		PwrAlarm.FwdAmpOnOff_LTE		= Sts->AlmSts.FwdAmpOnOff_LTE;
		if(AlarmCheck_LTE_A1 == SET)	PwrAlarm.FwdAmpOnOff_LTE_A1 	= Sts->AlmSts.FwdAmpOnOff_LTE_A1;
		if(AlarmCheck_LTE_A2 == SET)  	PwrAlarm.FwdAmpOnOff_LTE_A2 	= Sts->AlmSts.FwdAmpOnOff_LTE_A2;
		
		if(AlarmCheck_LTE_1== SET)		PwrAlarm.FwdAmp1OnOff_LTE		= Sts->AlmSts.FwdAmp1OnOff_LTE;
		if(AlarmCheck_LTE_A1_1 == SET) 	PwrAlarm.FwdAmp1OnOff_LTE_A1	= Sts->AlmSts.FwdAmp1OnOff_LTE_A1;
		if(AlarmCheck_LTE_A2_1 == SET)  PwrAlarm.FwdAmp1OnOff_LTE_A2	= Sts->AlmSts.FwdAmp1OnOff_LTE_A2;
#endif
	}
}


void AttnOutBufferInit(void)
{
	CurrLTE15MUse 			= 0xFF;
	CurrModemOnOff			= 0xFF;
	ChkBandSelet			= 0xFF;

	CurrFwdAttn1_3G 		= 0xFF; 
	CurrFwdAttn2_3G 		= 0xFF; 
	CurrRvsAttn1_3G 		= 0xFF; 
	CurrRvsAttn2_3G 		= 0xFF; 
	CurrRvsAttn3_3G 		= 0xFF; 
	CurrRvsAttn4_3G 		= 0xFF; 

	CurrFwdAttn1_2G 		= 0xFF; 
	CurrFwdAttn2_2G 		= 0xFF; 
	CurrRvsAttn1_2G 		= 0xFF; 
	CurrRvsAttn2_2G 		= 0xFF; 
	CurrRvsAttn3_2G 		= 0xFF; 

	CurrFwdAttn1_LTE		= 0xFF; 
	CurrFwdAttn2_LTE		= 0xFF; 
	CurrRvsAttn1_LTE		= 0xFF; 
	CurrRvsAttn2_LTE		= 0xFF; 
	CurrRvsAttn3_LTE		= 0xFF; 

	CurrFwdAttn1_CDMALTE 	= 0xFF;
	CurrRvsAttn1_CDMALTE 	= 0xFF;

	CurrFwdAttn1_LTE_A1		= 0xFF; 
	CurrFwdAttn2_LTE_A1		= 0xFF; 
	CurrRvsAttn1_LTE_A1		= 0xFF; 
	CurrRvsAttn2_LTE_A1		= 0xFF; 
	CurrRvsAttn3_LTE_A1		= 0xFF; 

	CurrFwdAttn1_LTE_A2		= 0xFF; 
	CurrFwdAttn2_LTE_A2		= 0xFF; 
	CurrRvsAttn1_LTE_A2		= 0xFF; 
	CurrRvsAttn2_LTE_A2		= 0xFF; 
	CurrRvsAttn3_LTE_A2		= 0xFF; 


	CurrFwdAttn1_LTE_A 		= 0xFF;
	CurrRvsAttn1_LTE_A 		= 0xFF;

	CurrFwd1Attn1_LTE		= 0xFF; 
	CurrFwd1Attn2_LTE		= 0xFF; 
	CurrRvs1Attn1_LTE		= 0xFF; 
	CurrRvs1Attn2_LTE		= 0xFF; 
	CurrRvs1Attn3_LTE		= 0xFF; 
	CurrRvs1Attn4_LTE		= 0xFF; 

	CurrFwd1Attn1_LTE_A1 	= 0xFF;
	CurrFwd1Attn2_LTE_A1 	= 0xFF;
	CurrRvs1Attn1_LTE_A1 	= 0xFF;
	CurrRvs1Attn2_LTE_A1 	= 0xFF;
	CurrRvs1Attn3_LTE_A1 	= 0xFF;

	CurrFwd1Attn1_LTE_A2 	= 0xFF;
	CurrFwd1Attn2_LTE_A2 	= 0xFF;
	CurrRvs1Attn1_LTE_A2 	= 0xFF;
	CurrRvs1Attn2_LTE_A2 	= 0xFF;
	CurrRvs1Attn3_LTE_A2 	= 0xFF;	

	CurrFwd1Attn1_LTE_A 	= 0xFF;
	CurrRvs1Attn1_LTE_A 	= 0xFF;
}


void ResetCaseBackup(INT8U Cause)
{
	rambackup[0] = Cause;
}


void PeriodReportCheck(void)
{
	INT16U	PeriodSec = 1;
	
	if(TimeOverCheck(TimerPerReport))
	{
		TimePeriodElased++;
		TimerRegist(TimerPerReport, Time1Sec);	
	}

	if(TimePeriodElased >= PeriodSec)
	{
		TimePeriodElased = 0;
		
		if(!FirstCheckFlag)
		{
		//	*SmsDnrPreAlm = *(_SmsDnrAlarm *)SmsDnrAlarm;
		//	*SmsRmtPreAlm = *(_SmsRmtAlarm *)SmsRmtAlarm;
			
			FirstCheckFlag = TRUE;
		}
			
		SmsDnrAlarm_Check();
	}
}


void SmsDnrAlarm_Check(void)
{
	 if(chkDnrAlarmReport == SET)return;
	 if( DnrAlarmCheckUpdate(tDnrSts->AlarmMask) != 0)chkDnrAlarmReport = SET;
}

INT32U DnrAlarmCheckUpdate(INT8U TotMask)
{
	int i;

	INT8U *CurSts		= (INT8U *)&PwrAlarm;
	INT8U *PreSts		= (INT8U *)&PwrAlarmPre;
	INT8U *ChangeFlag	= (INT8U *)&PwrAlarmChange;
	INT8U *AlarmTimer	= (INT8U *)&PwrAlarmTimer;
	INT8U *AlarmCnt		= (INT8U *)&PwrAlarmCnt;

	INT8U DataLen	= sizeof(__PwrAlmStr)/1;

	INT8U tCnt = 0;

	for(i = 0; i < DataLen; i++)
	{
		tCnt += UPdateAlarm(CurSts + i, PreSts + i, ChangeFlag + i, AlarmTimer + i, AlarmCnt+ i);
	}
	
	if(TotMask)
	{
		return FALSE;	 // Mask 이면 check 하지 않는다.
	}

	if(tCnt != 0) return TRUE;
	return FALSE;
}

INT8U UPdateAlarm(INT8U *CurSts, INT8U *PreSts, INT8U *ChangeFlag, INT8U *AlarmTimer, INT8U *AlarmCnt)
{
//	*ChangeFlag = 0;
 	if( (*CurSts) ==  (*PreSts) )
	{
		*AlarmTimer = *AlarmCnt;
	}
	else
 	{
		if(*AlarmTimer == 0)
		{
			*PreSts = *CurSts;
			*ChangeFlag = 1;
			return TRUE;
		}
		else *AlarmTimer = *AlarmTimer - 1;
	}
	return FALSE;
}

void Table_Alarm(void)
{
	INT8U AlarmSum = 0;

	INT8U i;
	INT8U Pwr0TblAlarm = 0;
	INT8U Att0TblAlarm = 0;
	
	INT8U Pwr1TblAlarm = 0;
	INT8U Att1TblAlarm = 0;
	
	
	for(i = Index_FwdOutAvgPwr_2G; i <= Index_RvsOutPwr_3G; i++)
	{
		Pwr0TblAlarm 	+= OutPutTable_Alarm_check(i);
	}

	for(i = Index_FwdAttn1_2G; i <= Index_RvsAttn4_CDMALTE; i++)
	{
		Att0TblAlarm 	+= AttTable_Alarm_check(i);
	}

	if(iRepeaterType == _TRIO_MM)
	{
		for(i = Index_Fwd1InPwr_LTE; i <= Index_Fwd1OutPeakPwr_LTE_A1; i++)
		{
			Pwr1TblAlarm 	+= OutPutTable_Alarm_check(i);
		}
		
		for(i = Index_Fwd1Attn1_LTE; i <= Index_RvsAttn4_LTE_A_1; i++)
		{
			Att1TblAlarm 	+= AttTable_Alarm_check(i);
		}
	}
	AlarmSum = Pwr0TblAlarm + Att0TblAlarm + Pwr1TblAlarm + Att1TblAlarm;

	if(AlarmSum)	tDnrSts->TableStatus = Alarm;
	else			tDnrSts->TableStatus = Normal;

}


INT8U OutPutTable_Alarm_check(INT8U TblID)
{
	INT8S tIndex = 0;
	INT8S tLocation = 0;
	
	INT32S i = 0;
	INT8U rval = Normal;

	tLocation = TableLocation(TblID);
	if( (tIndex = TableIndex(TblID)) == -1) return Normal;

	if(tLocation == _DnrPwr0_Location)
	{
		__Dnr0OutputTblStr *table =(__Dnr0OutputTblStr *)&vEE_TABLE1->Dnr0OutputTbl[tIndex];

		INT16U *dptr = table->Data;
		INT32S nsize = table->nsize;
		
		for(i = 0; i < nsize && i < Dnr0OutputTBL_Size; i++)
		{
//			if((dptr[i] > 3500)||(dptr[i] < 200)) 	
			if((dptr[i] > 3500)) 	
			{
				rval = Alarm;  

			}
		    if(i)
	        {
	            if( dptr[i-1] < dptr[i] )			
            	{
					rval = Alarm;  
            	}
	        }
		}

		if((nsize < 10)||(nsize > Dnr0OutputTBL_Size))  rval = Alarm;  
	}
	else if(tLocation == _SvrPwr0_Location)
	{
		__Svr0OutputTblStr *table =(__Svr0OutputTblStr *)&vEE_TABLE->Svr0OutputTbl[tIndex];

		INT16U *dptr = table->Data;
		INT32S nsize = table->nsize;
		
		for(i = 0; i < nsize && i < Svr0OutputTBL_Size; i++)
		{
//			if((dptr[i] > 3500)||(dptr[i] < 200)) 	rval = Alarm;  
			if((dptr[i] > 3500))	rval = Alarm;  

		    if(i)
	        {
	            if( dptr[i-1] < dptr[i] )			rval = Alarm;  
	        }
		}

		if((nsize < 10)||(nsize > Svr0OutputTBL_Size))  rval = Alarm;  
	}
	else if(tLocation == _DnrPwr1_Location)
	{
		rval = Normal;
	}
	else if(tLocation == _SvrPwr1_Location)
	{
		rval = Normal;
	}
	else if(tLocation == _ETC_Location)
	{
		rval = Normal;
	}
		
	return rval;
}

INT8U AttTable_Alarm_check(INT8U TblID)
{
	INT8S tIndex = 0;
	INT8S tLocation = 0;

	INT32S i = 0;
	INT8U rval = Normal;

	tLocation = AttnTableLocation(TblID);
	if( (tIndex = TableIndex(TblID)) == -1) return Normal;

	if(tLocation == _DnrAttn_Location)
	{
		__AttnOffsetTblStr *AttTblStr = &vSYS_TABLE->DnrAttnTbl[tIndex];

	
		INT8S *dptr = AttTblStr->Data;
		INT8U nsize = AttTblStr->nsize;
		
		for(i = 0; i < nsize && i < AttTBL_Size; i++)
		{
			if(abs(dptr[i]) > 10)	rval = Alarm;
		}
		
		if((nsize < 10)||(nsize > AttTBL_Size))  rval = Alarm;	

		DnrAttnTblAlarm[tIndex]= rval;
	}
	else if(tLocation == _SvrAttn_Location)
	{
		__AttnOffsetTblStr *AttTblStr;

		AttTblStr = &vEE_BACK1->SvrAttnTbl[tIndex];
	
		INT8S *dptr = AttTblStr->Data;
		INT8U nsize = AttTblStr->nsize;
		
		for(i = 0; i < nsize && i < AttTBL_Size; i++)
		{
			if(abs(dptr[i]) > 10)	rval = Alarm;
		}
		
		if((nsize < 10)||(nsize > AttTBL_Size))  rval = Alarm;
		
		SvrAttnTblAlarm[tIndex]= rval;
	}
	
	return rval;
}



INT16S TableOffset(INT16S Temp, INT16S Temp10x, INT16S Offset, INT16S *Ret10x)
{
	INT8S DectVal = 0;

	DectVal = Temp + Offset;
	*Ret10x = Temp10x + (Offset*10);
	
	return (DectVal);
}



INT8U LimitAlarmUpdate( INT8U CurrAlarm, INT8U PreAlarm, INT16U AlarmIndex)
{
	if(CurrAlarm != PreAlarm)
	{
		LimitAlarmCnt[AlarmIndex]++;
		
		if(LimitAlarmCnt[AlarmIndex] > AlarmCheckTime)
		{
			LimitAlarmCnt[AlarmIndex] = 0;
			
			return CurrAlarm;
		}
	}
	else LimitAlarmCnt[AlarmIndex] = 0;

	return PreAlarm;
}

INT8U HighLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm)
{
 	     if(DetLvl >= LimitLvl)	return Alarm;
	else if(DetLvl <= LimitLvl - Offset)return Normal;

	return CurrentAlarm;

}

INT8U LowLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm)
{
 	     if(DetLvl <= LimitLvl)	return Alarm;
	else if(DetLvl >= LimitLvl + Offset)return Normal;

	return CurrentAlarm;

}

INT8S RetSMStoNormalData(INT8U Data)
{
	INT8S rVal = Data & 0x3f;

	if(BitRead(Data, 6))rVal = -rVal;

	return rVal;
}

INT8U RetNormaltoSMSData(INT8S Data)
{
	INT8S rVal = 0;

	if(Data < 0)
	{
		rVal = -Data;
		BitSet(rVal, 6);
	}
	else rVal = Data;
	
	return rVal;
}


INT8U RetSmsOffVal(INT8U OnOff)
{
	INT8U rVal;
	
	rVal = (~(OnOff - '0')) & 0x01;

	return rVal;
}

#if 0
INT8U RvsSleepMode(void)
{
	INT8U rVal = 0;

	__Dnr_Sts *Sts = tDnrSts;

////////////////////////////////////////////////
	{
		if( Sts->SleepMode_2G.SleepMode_OnOff == Enable)
		{
			if( tDnrSts->ModeValue == 1)
			{
				SerPtr->printf(" [%d][%d]>[%d][%d]:[%d]\n", Sts->DetVolt.RvsOutVolt_2G.Data,Sts->SleepMode_2G.SleepModeOnVolt.Data,SleepModeCnt[PATH_2G],Sts->ModuleAlarm.Main.SleepMode_2G,chkSleepMode[PATH_2G]);
			}
			if(chkSleepMode[PATH_2G] == RESET)
			{
				if( Sts->DetVolt.RvsOutVolt_2G.Data < Sts->SleepMode_2G.SleepModeOnVolt.Data)
				{
					Sts->ModuleAlarm.Main.SleepMode_2G = Alarm;

					if(++SleepModeCnt[PATH_2G]>= SleepAlarmCheckTime)
					{
						chkSleepMode[PATH_2G] = SET;
						SleepModeCnt[PATH_2G] = SleepAlarmCheckTime;
						
						InitSleepMode[PATH_2G] = SET;
					}				
				}
				else
				{
					Sts->ModuleAlarm.Main.SleepMode_2G = Normal;
					SleepModeCnt[PATH_2G] = 0;
				}
			}
			
			if (( Sts->DetVolt.RvsOutVolt_2G.Data > Sts->SleepMode_2G.SleepModeOffVolt.Data)&&(chkSleepMode[PATH_2G]))
			{
				Sts->ModuleAlarm.Main.SleepMode_2G = Normal;
				SleepModeCnt[PATH_2G] = 0;
				chkSleepMode[PATH_2G] = RESET;

				if( InitSleepMode[PATH_2G] == SET)
				{
					InitSleepMode[PATH_2G] = RESET;
					Sts->RvsGainAttn_2G = GainAttnCalculation(Sts->Rvs0GainSet_2G,Gain_2G,ATTENMIN);
				}
			}
		}
		else
		{
			Sts->ModuleAlarm.Main.SleepMode_2G = Normal;
			SleepModeCnt[PATH_2G] = 0;
			chkSleepMode[PATH_2G] = RESET;
			if( InitSleepMode[PATH_2G] == SET)
			{
				InitSleepMode[PATH_2G] = RESET;
				Sts->RvsGainAttn_2G = GainAttnCalculation(Sts->Rvs0GainSet_2G,Gain_2G,ATTENMIN);
			}			
		}
	}

	{
		if( Sts->SleepMode_LTE.SleepMode_OnOff == Enable)
		{
			if( tDnrSts->ModeValue == 2)
			{
				SerPtr->printf(" [%d][%d]>[%d][%d]:[%d]\n", Sts->DetVolt.RvsOutVolt_LTE.Data,Sts->SleepMode_LTE.SleepModeOnVolt.Data,SleepModeCnt[PATH_LTE],Sts->ModuleAlarm.Main.SleepMode_LTE,chkSleepMode[PATH_LTE]);
			}

			if(chkSleepMode[PATH_LTE] == RESET)
			{
				if( Sts->DetVolt.RvsOutVolt_LTE.Data < Sts->SleepMode_LTE.SleepModeOnVolt.Data)
				{
					Sts->ModuleAlarm.Main.SleepMode_LTE = Alarm;

					if(++SleepModeCnt[PATH_LTE]>= SleepAlarmCheckTime)
					{
						chkSleepMode[PATH_LTE] = SET;
						InitSleepMode[PATH_LTE] = SET;
						
						SleepModeCnt[PATH_LTE] = SleepAlarmCheckTime;
					}				
				}
				else
				{
					Sts->ModuleAlarm.Main.SleepMode_LTE = Normal;
					SleepModeCnt[PATH_LTE] = 0;
				}
			}
			
			if (( Sts->DetVolt.RvsOutVolt_LTE.Data > Sts->SleepMode_LTE.SleepModeOffVolt.Data)&&(chkSleepMode[PATH_LTE]))
			{
				Sts->ModuleAlarm.Main.SleepMode_LTE = Normal;
				SleepModeCnt[PATH_LTE] = 0;
				chkSleepMode[PATH_LTE] = RESET;

//				SerPtr->printf("0 InitSleepMode [%d] \n", InitSleepMode[PATH_LTE]);

				if( InitSleepMode[PATH_LTE] == SET)
				{
					InitSleepMode[PATH_LTE] = RESET;
					Sts->RvsGainAttn_LTE = GainAttnCalculation(Sts->Rvs0GainSet_LTE,Gain_LTE,ATTENMIN);
//					SerPtr->printf("1 InitSleepMode [%d]:[%d][%d] \n", InitSleepMode[PATH_LTE],Sts->RvsGainAttn_LTE,Sts->Rvs0GainSet_LTE);
				}				
			}
		}
		else
		{
			Sts->ModuleAlarm.Main.SleepMode_LTE = Normal;
			SleepModeCnt[PATH_LTE] = 0;
			chkSleepMode[PATH_LTE] = RESET;
			
			if( InitSleepMode[PATH_LTE] == SET)
			{
				InitSleepMode[PATH_LTE] = RESET;
				Sts->RvsGainAttn_LTE = GainAttnCalculation(Sts->Rvs0GainSet_LTE,Gain_LTE,ATTENMIN);
			}				
		}
	}

	{
		if( Sts->SleepMode_LTE_A1.SleepMode_OnOff == Enable)
		{
			if(chkSleepMode[PATH_LTE_A1] == RESET)
			{
				if( Sts->DetVolt.RvsOutVolt_LTE_A1.Data < Sts->SleepMode_LTE_A1.SleepModeOnVolt.Data)
				{
					Sts->ModuleAlarm.Main.SleepMode_LTE_A1 = Alarm;

					if(++SleepModeCnt[PATH_LTE_A1]>= SleepAlarmCheckTime)
					{
						chkSleepMode[PATH_LTE_A1] = SET;
						InitSleepMode[PATH_LTE_A1] = SET;
						
						SleepModeCnt[PATH_LTE_A1] = SleepAlarmCheckTime;
					}				
				}
				else
				{
					Sts->ModuleAlarm.Main.SleepMode_LTE_A1 = Normal;
					SleepModeCnt[PATH_LTE_A1] = 0;
				}
			}
			
			if (( Sts->DetVolt.RvsOutVolt_LTE_A1.Data > Sts->SleepMode_LTE_A1.SleepModeOffVolt.Data)&&(chkSleepMode[PATH_LTE]))
			{
				Sts->ModuleAlarm.Main.SleepMode_LTE_A1 = Normal;
				SleepModeCnt[PATH_LTE_A1] = 0;
				chkSleepMode[PATH_LTE_A1] = RESET;
				if( InitSleepMode[PATH_LTE_A1] == SET)
				{
					InitSleepMode[PATH_LTE_A1] = RESET;
					Sts->RvsGainAttn_LTE_A1 = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
				}					
			}
		}
		else
		{
			Sts->ModuleAlarm.Main.SleepMode_LTE_A1 = Normal;
			SleepModeCnt[PATH_LTE_A1] = 0;
			chkSleepMode[PATH_LTE_A1] = RESET;

			if( InitSleepMode[PATH_LTE_A1] == SET)
			{
				InitSleepMode[PATH_LTE_A1] = RESET;
				Sts->RvsGainAttn_LTE_A1 = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
			}					
		}
	}	

	{
		if( Sts->SleepMode_LTE_A2.SleepMode_OnOff == Enable)
		{
			if(chkSleepMode[PATH_LTE_A2] == RESET)
			{
				if( Sts->DetVolt.RvsOutVolt_LTE_A2.Data < Sts->SleepMode_LTE_A2.SleepModeOnVolt.Data)
				{
					Sts->ModuleAlarm.Main.SleepMode_LTE_A2 = Alarm;

					if(++SleepModeCnt[PATH_LTE_A2]>= SleepAlarmCheckTime)
					{
						chkSleepMode[PATH_LTE_A2] = SET;
						InitSleepMode[PATH_LTE_A2] = SET;
						
						SleepModeCnt[PATH_LTE_A2] = SleepAlarmCheckTime;
					}				
				}
				else
				{
					Sts->ModuleAlarm.Main.SleepMode_LTE_A2 = Normal;
					SleepModeCnt[PATH_LTE_A2] = 0;
				}
			}			
			
			if (( Sts->DetVolt.RvsOutVolt_LTE_A2.Data > Sts->SleepMode_LTE_A2.SleepModeOffVolt.Data)&&(chkSleepMode[PATH_LTE_A2]))
			{
				Sts->ModuleAlarm.Main.SleepMode_LTE_A2 = Normal;
				SleepModeCnt[PATH_LTE_A2] = 0;
				chkSleepMode[PATH_LTE_A2] = RESET;

				if( InitSleepMode[PATH_LTE_A2] == SET)
				{
					InitSleepMode[PATH_LTE_A2] = RESET;
					Sts->RvsGainAttn_LTE_A2 = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
				}					
			}
		}
		else
		{
			Sts->ModuleAlarm.Main.SleepMode_LTE_A2 = Normal;
			SleepModeCnt[PATH_LTE_A2] = 0;
			chkSleepMode[PATH_LTE_A2] = RESET;

			if( InitSleepMode[PATH_LTE_A2] == SET)
			{
				InitSleepMode[PATH_LTE_A2] = RESET;
				Sts->RvsGainAttn_LTE_A2 = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
			}				
		}
	}	
	return rVal;
}
#endif
