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



void AlarmCheck(void)
{
	INT16S cval;
	INT16S tlimit;
	INT16U RecoveryAlarm;

//	INT8U i;

	__Dnr_Sts *Sts = tDnrSts;

	Sts->AlmSts.Data[0] = 0x00;
	Sts->AlmSts.Data[1] = 0x00;
	Sts->AlmSts.Data[2] = 0x00;
	Sts->AlmSts.Data[3] = 0x00;
	Sts->AlmSts.Data[4] = 0x00;
	Sts->AlmSts.Data[7] = 0x00;

	if(ChkTableAlarm)
	{
//		Table_Alarm();
		ChkTableAlarm = RESET;
	}

	{
		if(AC_Alarm)
		{
			if(++ACFailCnt >= 2)
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
//		if(cval <= tlimit)				PwrAlarm.DCFail = Alarm;
//		else if(cval >= RecoveryAlarm)	PwrAlarm.DCFail = Normal;

		if(cval <= tlimit)
		{
			if(++DCFailCnt >= 3)
			{
				PwrAlarm.DCFail = Alarm;
			}
		}
		else if(cval >= RecoveryAlarm)
		{
			PwrAlarm.DCFail = Normal;
		}
	}	

	if(PwrAlarm.DCFail)	    Sts->ModuleAlarm.Main.DCFail = Alarm;
	else					Sts->ModuleAlarm.Main.DCFail = Normal;

	if(PLLAlarm_WCDMA)		Sts->AlmSts.LocalFail_WCDMALTE_21	= Normal;
	else					Sts->AlmSts.LocalFail_WCDMALTE_21	= Alarm;

	if(PLLAlarm_CDMALTE)	Sts->AlmSts.LocalFail_CDMALTE		= Normal;
	else					Sts->AlmSts.LocalFail_CDMALTE		= Alarm;

	if(PLLAlarm_LTE_A2)		Sts->AlmSts.LocalFail_LTE_A			= Normal;
	else					Sts->AlmSts.LocalFail_LTE_A			= Alarm;


	if(Sts->ModuleAlarm.Main.Data[1] > 0)	Sts->AlmSts.DigitalAlarm	= Alarm;
	//////////////////CDMA

	AlarmCheck_2G = SET;

	if(Sts->FemtocellUseOnOff.LTE == __NOTUSE)
	{
		AlarmCheck_LTE = SET;
	}
	else
	{
		AlarmCheck_LTE = RESET;
	}


	if(Sts->FemtocellUseOnOff.LTE_A2 == __NOTUSE)
	{
		AlarmCheck_LTE_A2 = SET;
	}
	else
	{
		AlarmCheck_LTE_A2 = RESET;
	}
	

	if(Sts->FemtocellUseOnOff.LTE_21 == __NOTUSE)
	{
		if(Sts->LTE_21Use == __USE)
		{
			AlarmCheck_LTE_21 = SET;
		}
		else
		{
			AlarmCheck_LTE_21 = RESET;
		}
	}
	else
	{
		AlarmCheck_LTE_21 = RESET;
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


		mFwdHighAlm[PATH_LTE_A2].Level		 	= RetPower(Sts->FwdOutPwr_LTE_A2);
		mFwdHighAlm[PATH_LTE_A2].AlarmLevel 	= RetPower(Sts->FwdOutHighLmt_LTE_A2);
		mFwdHighAlm[PATH_LTE_A2].AlarmRecovery 	= mFwdHighAlm[PATH_LTE_A2].AlarmLevel - 2;

		mFwdHighAlm[PATH_3G].Level			= RetPower(Sts->FwdOutPwr_3G);
		mFwdHighAlm[PATH_3G].AlarmLevel 	= RetPower(Sts->FwdOutHighLmt_3G);
		mFwdHighAlm[PATH_3G].AlarmRecovery	= mFwdHighAlm[PATH_3G].AlarmLevel - 2;


		mFwdHighAlm[PATH_LTE_21].Level			= RetPower(Sts->FwdOutPwr_LTE_21);
		mFwdHighAlm[PATH_LTE_21].AlarmLevel 	= RetPower(Sts->FwdOutHighLmt_LTE_21);
		mFwdHighAlm[PATH_LTE_21].AlarmRecovery	= mFwdHighAlm[PATH_LTE_21].AlarmLevel - 2;


		for(i = 0; i < PATH_MAX; i++)
		{
			INT16S DetLvl 		= mFwdHighAlm[i].Level;
			INT16S LimitLvl 	= mFwdHighAlm[i].AlarmLevel;
			INT16S RecoveryLvl 	= mFwdHighAlm[i].AlarmRecovery;

			mFwdHighAlm[i].cAlarm	= HighLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}

		if(mFwdHighAlm[PATH_2G].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_2G = Alarm;
		if(Sd_Step[SD_FO_2G] != 0)					Sts->AlmSts.FwdOutUpperLmtFail_2G = Alarm;

		if(mFwdHighAlm[PATH_LTE].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_LTE = Alarm;
		if(Sd_Step[SD_FO_LTE] != 0)					Sts->AlmSts.FwdOutUpperLmtFail_LTE = Alarm;

		if(mFwdHighAlm[PATH_LTE_A2].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2 = Alarm;
		if(Sd_Step[SD_FO_LTE_A2] != 0) 				Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2 = Alarm;


		if(mFwdHighAlm[PATH_3G].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_3G = Alarm;
		if(Sd_Step[SD_FO_3G] != 0)					Sts->AlmSts.FwdOutUpperLmtFail_3G = Alarm;

		if(mFwdHighAlm[PATH_LTE_21].cAlarm == Alarm)	Sts->AlmSts.FwdOutUpperLmtFail_LTE_21 = Alarm;
		if(Sd_Step[PATH_LTE_21] != 0)					Sts->AlmSts.FwdOutUpperLmtFail_LTE_21 = Alarm;

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


		mFwdLowAlm[PATH_LTE_A2].Level		 	= RetPower(Sts->FwdOutPwrPeak_LTE_A2);
		mFwdLowAlm[PATH_LTE_A2].AlarmLevel 		= RetPower(Sts->FwdOutLowerLmt_LTE_A2);
		mFwdLowAlm[PATH_LTE_A2].AlarmRecovery 	= mFwdLowAlm[PATH_LTE_A2].AlarmLevel + 2;

		mFwdLowAlm[PATH_3G].Level				= RetPower(Sts->FwdOutPwr_3G);
		mFwdLowAlm[PATH_3G].AlarmLevel 			= RetPower(Sts->FwdOutLowerLmt_3G);
		mFwdLowAlm[PATH_3G].AlarmRecovery		= mFwdLowAlm[PATH_3G].AlarmLevel + 2;


		mFwdLowAlm[PATH_LTE_21].Level			= RetPower(Sts->FwdOutPwr_LTE_21);
		mFwdLowAlm[PATH_LTE_21].AlarmLevel 		= RetPower(Sts->FwdOutLowerLmt_LTE_21);
		mFwdLowAlm[PATH_LTE_21].AlarmRecovery	= mFwdLowAlm[PATH_LTE_21].AlarmLevel + 2;


		for(i = 0; i < PATH_MAX; i++)
		{
			INT16S DetLvl 		= mFwdLowAlm[i].Level;
			INT16S LimitLvl 	= mFwdLowAlm[i].AlarmLevel;
			INT16S RecoveryLvl 	= mFwdLowAlm[i].AlarmRecovery;
			mFwdLowAlm[i].cAlarm	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}

	}

#if 1//20150428
	{
		INT8U i = 0;
		mFwdOutLowAlm[_PATH_800M].Level			= Sts->DetPwr.DTU_FwdOutPwr_CDMALTE;
		mFwdOutLowAlm[_PATH_800M].AlarmLevel	= Sts->DetPwr.FwdOutPwr_CDMALTE+ 10*2;
		mFwdOutLowAlm[_PATH_800M].AlarmRecovery	= mFwdOutLowAlm[_PATH_800M].AlarmLevel - 4;

		mFwdOutLowAlm[_PATH_1800M].Level 		= Sts->DetPwr.DTU_FwdOutPwr_LTE_A;
		mFwdOutLowAlm[_PATH_1800M].AlarmLevel	= Sts->DetPwr.FwdOutPwr_LTE_A + 10*2;
		mFwdOutLowAlm[_PATH_1800M].AlarmRecovery = mFwdOutLowAlm[_PATH_1800M].AlarmLevel - 4;

		mFwdOutLowAlm[_PATH_2100M].Level		= Sts->DetPwr.DTU_FwdOutPwr_WCDMALTE_21;
		mFwdOutLowAlm[_PATH_2100M].AlarmLevel	= Sts->DetPwr.FwdOutPwr_WCDMALTE_21 + 10*2;
		mFwdOutLowAlm[_PATH_2100M].AlarmRecovery = mFwdOutLowAlm[_PATH_2100M].AlarmLevel - 4;

//		Ser3Ptr->printf("0_1 mFwdOutLowAlm[%d][%d]\n",Sts->DetPwr.FwdOutPwr_WCDMALTE_21,Sts->DetPwr.DTU_FwdOutPwr_WCDMALTE_21 );
		for(i = 0; i < SvrPATH_MAX; i++)
		{
			INT16S DetLvl		= mFwdOutLowAlm[i].Level;
			INT16S LimitLvl 	= mFwdOutLowAlm[i].AlarmLevel;
			INT16S RecoveryLvl	= mFwdOutLowAlm[i].AlarmRecovery;
			mFwdOutLowAlm[i].cAlarm	= HighLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			
//			Ser3Ptr->printf("0 [%d]: mFwdOutLowAlm[%d][%d][%d]>[%d]\n",i,DetLvl,LimitLvl,RecoveryLvl,mFwdOutLowAlm[i].cAlarm );

		}
		
		for(i = 0; i < SvrPATH_MAX; i++)
		{
	//		if(mFwdOutLowAlm[i].FwdLowMask)
			{
				if( mFwdOutLowAlm[i].cAlarm == Alarm)
				{
					if(++mFwdOutLowAlm[i].AlarmCnt >= AlarmCheckTime)
					{
						mFwdOutLowAlm[i].IsItAlarm = SET;
						mFwdOutLowAlm[i].AlarmCnt = AlarmCheckTime;
					}	
				}
				else
				{
					mFwdOutLowAlm[i].IsItAlarm = RESET;
					mFwdOutLowAlm[i].AlarmCnt = 0;
				}
			}
 
//			Ser3Ptr->printf("1 [%d]: mFwdOutLowAlm[%d][%d][%d]\n",i,mFwdOutLowAlm[i].cAlarm ,mFwdOutLowAlm[i].AlarmCnt ,mFwdOutLowAlm[i].IsItAlarm );
		}
//		SerPtr->printf("mFwdOutLowAlm[%d][%d][%d]\n",mFwdOutLowAlm[0].cAlarm ,mFwdOutLowAlm[0].AlarmCnt ,mFwdOutLowAlm[0].IsItAlarm );
	}



#endif

//////////////////////
	if (((tDnrSts->FwdAmpOnOff_2G == Disable)&&(tDnrSts->AmpOffCase_2G == __UsrCtrl))
		||(Sd_Step[SD_FO_2G] > 1))
	{
		mFwdLowAlm[PATH_2G].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_2G].FwdLowMask = SET;


	if (((tDnrSts->FwdAmpOnOff_LTE == Disable)&&(tDnrSts->AmpOffCase_LTE == __UsrCtrl))
		||(Sd_Step[SD_FO_LTE] > 1))
	{
		mFwdLowAlm[PATH_LTE].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_LTE].FwdLowMask = SET;

	if (((tDnrSts->FwdAmpOnOff_LTE_A2 == Disable)&&(tDnrSts->AmpOffCase_LTE_A2 == __UsrCtrl))
		||(Sd_Step[SD_FO_LTE_A2 ] > 1))
	{
		mFwdLowAlm[PATH_LTE_A2].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_LTE_A2].FwdLowMask = SET;
	
	if (((tDnrSts->FwdAmpOnOff_3G == Disable)&&(tDnrSts->AmpOffCase_3G == __UsrCtrl))
		||(Sd_Step[SD_FO_3G] > 1))
	{
		mFwdLowAlm[PATH_3G].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_3G].FwdLowMask = SET;

	if (((tDnrSts->FwdAmpOnOff_LTE_21 == Disable)&&(tDnrSts->AmpOffCase_LTE_21 == __UsrCtrl))
		||(Sd_Step[SD_FO_LTE_21] > 1))
	{
		mFwdLowAlm[PATH_LTE_21].FwdLowMask = RESET;
	}
	else mFwdLowAlm[PATH_LTE_21].FwdLowMask = SET;

	{
		INT8U i;
		
		for(i = 0; i < PATH_MAX; i++)
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
	if(mFwdLowAlm[PATH_2G].cAlarm == Alarm) Sts->AlmSts.FwdOutLowerLmtFail_2G = Alarm;
	PwrAlarm.FwdOutLowerLmtFail_2G = mFwdLowAlm[PATH_2G].IsItAlarm;

	if(mFwdLowAlm[PATH_LTE].cAlarm == Alarm)	Sts->AlmSts.FwdOutLowerLmtFail_LTE= Alarm;
	PwrAlarm.FwdOutLowerLmtFail_LTE = mFwdLowAlm[PATH_LTE].IsItAlarm;

	if(mFwdLowAlm[PATH_LTE_A2].cAlarm == Alarm)	Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2 = Alarm;
	PwrAlarm.FwdOutLowerLmtFail_LTE_A2 = mFwdLowAlm[PATH_LTE_A2].IsItAlarm;

	if(mFwdLowAlm[PATH_3G].cAlarm == Alarm)	Sts->AlmSts.FwdOutLowerLmtFail_3G = Alarm;
	PwrAlarm.FwdOutLowerLmtFail_3G = mFwdLowAlm[PATH_3G].IsItAlarm;

	if(mFwdLowAlm[PATH_LTE_21].cAlarm == Alarm) Sts->AlmSts.FwdOutLowerLmtFail_LTE_21 = Alarm;
	PwrAlarm.FwdOutLowerLmtFail_LTE_21= mFwdLowAlm[PATH_LTE_21].IsItAlarm;

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

		mRvsHighAlm[PATH_LTE_A2].Level		 	= RetPower(Sts->RvsOutPwr_LTE_A2);
		mRvsHighAlm[PATH_LTE_A2].AlarmLevel	 	= RetPower(Sts->RvsOutUpperLmt_LTE_A2);
		mRvsHighAlm[PATH_LTE_A2].AlarmRecovery 	= mRvsHighAlm[PATH_LTE_A2].AlarmLevel - 2;

		mRvsHighAlm[PATH_3G].Level				= RetPower(Sts->RvsOutPwr_3G);
		mRvsHighAlm[PATH_3G].AlarmLevel 		= RetPower(Sts->RvsOutUpperLmt_3G);
		mRvsHighAlm[PATH_3G].AlarmRecovery		= mRvsHighAlm[PATH_3G].AlarmLevel - 2;

		mRvsHighAlm[PATH_LTE_21].Level			= RetPower(Sts->RvsOutPwr_LTE_21);
		mRvsHighAlm[PATH_LTE_21].AlarmLevel 	= RetPower(Sts->RvsOutUpperLmt_LTE_21);
		mRvsHighAlm[PATH_LTE_21].AlarmRecovery	= mRvsHighAlm[PATH_LTE_21].AlarmLevel - 2;


		for(i = 0; i < PATH_MAX; i++)
		{
			INT16S DetLvl		= mRvsHighAlm[i].Level;
			INT16S LimitLvl		= mRvsHighAlm[i].AlarmLevel;
			INT16S RecoveryLvl	= mRvsHighAlm[i].AlarmRecovery;

			mRvsHighAlm[i].cAlarm	= HighLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}

		if((mRvsHighAlm[PATH_2G].cAlarm == Alarm))			Sts->AlmSts.RvsOutUpperLmtFail_2G = Alarm;
		if((Sd_Step[SD_RO_2G] != 0))						Sts->AlmSts.RvsOutUpperLmtFail_2G = Alarm;

		if((mRvsHighAlm[PATH_LTE].cAlarm == Alarm))			Sts->AlmSts.RvsOutUpperLmtFail_LTE = Alarm;
		if((Sd_Step[SD_RO_LTE] != 0))						Sts->AlmSts.RvsOutUpperLmtFail_LTE = Alarm;

		if((mRvsHighAlm[PATH_LTE_A2].cAlarm == Alarm))		Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2 = Alarm;
		if((Sd_Step[SD_RO_LTE_A2] != 0))					Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2 = Alarm;

		if((mRvsHighAlm[PATH_3G].cAlarm == Alarm))			Sts->AlmSts.RvsOutUpperLmtFail_3G = Alarm;
		if((Sd_Step[SD_RO_3G] != 0))						Sts->AlmSts.RvsOutUpperLmtFail_3G = Alarm;

		if((mRvsHighAlm[PATH_LTE_21].cAlarm == Alarm))		Sts->AlmSts.RvsOutUpperLmtFail_LTE_21 = Alarm;
		if((Sd_Step[SD_RO_LTE_21] != 0))					Sts->AlmSts.RvsOutUpperLmtFail_LTE_21 = Alarm;
	}

	// Over In Alarm 
	{
		INT8U i = 0;

		mFwdInHighAlm[PATH_2G].Level			= -(Sts->FwdInPwr_2G*1);
		mFwdInHighAlm[PATH_2G].AlarmLevel 		= FwdOverInAlmLmt_2G;		// 과입력 Alarm  '-24±2dBm~-11±2dBm
		mFwdInHighAlm[PATH_2G].AlarmRecovery	= mFwdInHighAlm[PATH_2G].AlarmLevel - 2;

		mFwdInHighAlm[PATH_LTE].Level			= -(Sts->FwdInPwr_LTE*1);
		mFwdInHighAlm[PATH_LTE].AlarmLevel		= FwdOverInAlmLmt_LTE;		// 과입력 Alarm  -21±2dBm~-8±2dBm
		mFwdInHighAlm[PATH_LTE].AlarmRecovery	= mFwdInHighAlm[PATH_LTE].AlarmLevel - 2;


		mFwdInHighAlm[PATH_LTE_A2].Level			= -(Sts->FwdInPwr_LTE_A2*1);
		mFwdInHighAlm[PATH_LTE_A2].AlarmLevel		= Sts->OverInAlarmLmt_LTE_A2/2;		//	-15
		mFwdInHighAlm[PATH_LTE_A2].AlarmRecovery	= mFwdInHighAlm[PATH_LTE_A2].AlarmLevel - 2;

		mFwdInHighAlm[PATH_3G].Level			= -(Sts->FwdInPwr_3G*1);
		mFwdInHighAlm[PATH_3G].AlarmLevel 		= Sts->OverInAlarmLmt_3G/2; 			//-36*2  //	-19
		mFwdInHighAlm[PATH_3G].AlarmRecovery	= mFwdInHighAlm[PATH_3G].AlarmLevel - 2;


		mFwdInHighAlm[PATH_LTE_21].Level			= -(Sts->FwdInPwr_LTE_21*1);
		mFwdInHighAlm[PATH_LTE_21].AlarmLevel 		= Sts->OverInAlarmLmt_LTE_21/2; 	//-36*2  //	-19
		mFwdInHighAlm[PATH_LTE_21].AlarmRecovery	= mFwdInHighAlm[PATH_LTE_21].AlarmLevel - 2;


		for(i = 0; i < PATH_MAX; i++)
		{
			INT16S DetLvl		= mFwdInHighAlm[i].Level;
			INT16S LimitLvl		= mFwdInHighAlm[i].AlarmLevel;
			INT16S RecoveryLvl	= mFwdInHighAlm[i].AlarmRecovery;

			mFwdInHighAlm[i].cAlarm	= HighLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}

		if(mFwdInHighAlm[PATH_2G].cAlarm == Alarm)		Sts->AlmSts.FwdInUpperLmtFail_2G = Alarm;
		if(Sd_Step[SD_FI_2G] != 0)						Sts->AlmSts.FwdInUpperLmtFail_2G = Alarm;

		if(mFwdInHighAlm[PATH_LTE].cAlarm == Alarm)		Sts->AlmSts.FwdInUpperLmtFail_LTE= Alarm;
		if(Sd_Step[SD_FI_LTE] != 0) 					Sts->AlmSts.FwdInUpperLmtFail_LTE = Alarm;


		if(mFwdInHighAlm[PATH_LTE_A2].cAlarm == Alarm)	Sts->AlmSts.FwdInUpperLmtFail_LTE_A2= Alarm;
		if(Sd_Step[SD_FI_LTE_A2] != 0)					Sts->AlmSts.FwdInUpperLmtFail_LTE_A2 = Alarm;

		if(mFwdInHighAlm[PATH_3G].cAlarm == Alarm)		Sts->AlmSts.FwdInUpperLmtFail_3G = Alarm;
		if(Sd_Step[SD_FI_3G] != 0)						Sts->AlmSts.FwdInUpperLmtFail_3G = Alarm;

		if(mFwdInHighAlm[PATH_LTE_21].cAlarm == Alarm)	Sts->AlmSts.FwdInUpperLmtFail_LTE_21 = Alarm;
		if(Sd_Step[SD_FI_LTE_21] != 0)					Sts->AlmSts.FwdInUpperLmtFail_LTE_21 = Alarm;
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
		Sts->AlmSts.LocalFail_LTE_A				= Normal;
		Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.FwdInUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2	= Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_LTE_A2	= Normal;
	}
	
	if(AlarmCheck_LTE_21 != SET)
	{
		Sts->AlmSts.FwdOutUpperLmtFail_LTE_21	= Normal;
		Sts->AlmSts.FwdInUpperLmtFail_LTE_21	= Normal;
		Sts->AlmSts.RvsOutUpperLmtFail_LTE_21	= Normal;
		Sts->AlmSts.FwdOutLowerLmtFail_LTE_21	= Normal;
	}

	//////////////////CDMA LTE
//	if(Sts->LTE15MUse == __NOTUSE)
	{
		{
			INT16S DetLvl 		= -(Sts->FwdInPwr_2G)+ 25 ;
			INT16S LimitLvl 	= (Sts->DetPwr.FwdInPwr_CDMALTE);

			INT16S RecoveryLvl 	= LimitLvl + 1;

			if((Sts->AlmSts.FwdAmpOnOff_2G == Enable)&&( Sts->FwdOutPwr_2G[0] > Sts->FwdOutLowerLmt_2G[0]))
			{
				CurrAlarm.OverInAlarm_CDMALTE_1	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			}
			else
			{
				CurrAlarm.OverInAlarm_CDMALTE_1 = Normal;
			}

//			Ser3Ptr->printf("OverInAlarm_CDMALTE_1[%d][%d][%d]\n",DetLvl,LimitLvl,CurrAlarm.OverInAlarm_CDMALTE_1);
		}

		{
			INT16S DetLvl 		= -(Sts->FwdInPwr_LTE)+ 25 ;
			INT16S LimitLvl 	= (Sts->DetPwr.FwdInPwr_CDMALTE);
			INT16S RecoveryLvl 	= LimitLvl + 1;

			if((Sts->AlmSts.FwdAmpOnOff_LTE == Enable)&&( Sts->FwdOutPwr_LTE[0] > Sts->FwdOutLowerLmt_LTE[0]))
			{
				CurrAlarm.OverInAlarm_CDMALTE_2	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			}
			else
			{
				CurrAlarm.OverInAlarm_CDMALTE_2 = Normal;
			}
			
//			Ser3Ptr->printf("OverInAlarm_CDMALTE_2[%d][%d][%d]\n",DetLvl,LimitLvl,CurrAlarm.OverInAlarm_CDMALTE_2);
		}

#if 0
		if((AlarmCheck_2G == SET)&&(AlarmCheck_LTE == SET))
		{
			INT16S DetLvl = Sts->DetPwr.FwdInPwr_CDMALTE + 4;
			INT16S LimitLvl;
			INT16S RecoveryLvl;

			if(Sts->FwdInPwr_2G >= Sts->FwdInPwr_LTE)		LimitLvl = -(Sts->FwdInPwr_LTE);
			else if(Sts->FwdInPwr_2G < Sts->FwdInPwr_LTE)	LimitLvl = -(Sts->FwdInPwr_2G);
			RecoveryLvl = LimitLvl + 1;
			CurrAlarm.OverInAlarm_CDMALTE_3 = LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}
#endif
		if((AlarmCheck_2G == SET)&&(AlarmCheck_LTE == SET))
		{
			INT16S DetLvl = abs(Sts->FwdInPwr_2G - Sts->FwdInPwr_LTE);
			INT16S LimitLvl = 19;
			
			INT16S RecoveryLvl	= 18;
			CurrAlarm.OverInAlarm_CDMALTE_3 = LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);

			
//			Ser3Ptr->printf("OverInAlarm_CDMALTE_3[%d][%d][%d]\n",DetLvl,LimitLvl,CurrAlarm.OverInAlarm_CDMALTE_3);
		}

#if 1
		{
			if((CurrAlarm.OverInAlarm_CDMALTE_1)||(CurrAlarm.OverInAlarm_CDMALTE_2))
			{


				if(CurrAlarm.OverInAlarm_CDMALTE_3)
				{
					Sts->AlmSts.OverInAlarm_CDMALTE = Alarm;
				}
				else Sts->AlmSts.OverInAlarm_CDMALTE = Normal;

				if(Sts->AlmSts.FwdOutLowerLmtFail_2G == Alarm)
				{
					Sts->AlmSts.OverInAlarm_CDMALTE = CurrAlarm.OverInAlarm_CDMALTE_2;
				}

				if(Sts->AlmSts.FwdOutLowerLmtFail_LTE== Alarm)
				{
					Sts->AlmSts.OverInAlarm_CDMALTE = CurrAlarm.OverInAlarm_CDMALTE_1;
				}

			}
			else Sts->AlmSts.OverInAlarm_CDMALTE = Normal;
		}
#endif

#if 0		
		{
			if((CurrAlarm.OverInAlarm_CDMALTE_1)||(CurrAlarm.OverInAlarm_CDMALTE_2))
			{
				Sts->AlmSts.OverInAlarm_CDMALTE = Alarm;
			}
			else Sts->AlmSts.OverInAlarm_CDMALTE = Normal;

		}
#endif
	}

	{
		// LTE_A1 타사 Over InAlarm 
		if(AlarmCheck_LTE_A2 == SET)
		{
			INT16S DetLvl 		= -(Sts->FwdInPwr_LTE_A2)+ 25 ;
			INT16S LimitLvl 	= (Sts->DetPwr.FwdInPwr_LTE_A);
			INT16S RecoveryLvl 	= LimitLvl + 1;

			if((Sts->AlmSts.FwdAmpOnOff_LTE_A2 == Enable)&&( Sts->FwdOutPwr_LTE_A2[0] > Sts->FwdOutLowerLmt_LTE_A2[0]))
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

		if(Sts->FwdInPwr_3G != NoSignal)
		{
			INT16S DetLvl 		= -(Sts->FwdInPwr_3G)+ 25 ;
			INT16S LimitLvl 	= (Sts->DetPwr.FwdInPwr_WCDMALTE_21);


			INT16S RecoveryLvl 	= LimitLvl + 1;

			if((Sts->AlmSts.FwdAmpOnOff_3G == Enable)&&( Sts->FwdOutPwr_3G[0] > Sts->FwdOutLowerLmt_3G[0]))
			{
				CurrAlarm.OverInAlarm_WCDMALTE_21_1	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			}
			else
			{
				CurrAlarm.OverInAlarm_WCDMALTE_21_1 = Normal;
			}

		}
		
		
		if(Sts->FwdInPwr_LTE_21 != NoSignal)
		{
			INT16S DetLvl 		= -(Sts->FwdInPwr_LTE_21)+ 25 ;
			INT16S LimitLvl 	= (Sts->DetPwr.FwdInPwr_WCDMALTE_21);
			INT16S RecoveryLvl 	= LimitLvl + 1;

			if((Sts->AlmSts.FwdAmpOnOff_LTE_21 == Enable)&&( Sts->FwdOutPwr_LTE_21[0] > Sts->FwdOutLowerLmt_LTE_21[0]))
			{
				CurrAlarm.OverInAlarm_WCDMALTE_21_2	= LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			}
			else
			{
				CurrAlarm.OverInAlarm_WCDMALTE_21_2 = Normal;
			}
		}
#if 0
		if((AlarmCheck_LTE_21== SET))
		{
			INT16S DetLvl = Sts->DetPwr.FwdInPwr_WCDMALTE_21 + 4;
			INT16S LimitLvl;
			INT16S RecoveryLvl;

			if(Sts->FwdInPwr_3G >= Sts->FwdInPwr_LTE_21)		LimitLvl = -(Sts->FwdInPwr_LTE_21);
			else if(Sts->FwdInPwr_3G < Sts->FwdInPwr_LTE_21)	LimitLvl = -(Sts->FwdInPwr_3G);
			RecoveryLvl = LimitLvl + 1;
			CurrAlarm.OverInAlarm_WCDMALTE_21_3 = LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
		}
#endif	
		{
			INT16S DetLvl = abs(Sts->FwdInPwr_3G - Sts->FwdInPwr_LTE_21);
			INT16S LimitLvl = 19;
			INT16S RecoveryLvl	= 18;

			CurrAlarm.OverInAlarm_WCDMALTE_21_3 = LowLimitCheck1(DetLvl, LimitLvl, RecoveryLvl);
			
//			Ser3Ptr->printf("OverInAlarm_CDMALTE_3[%d][%d][%d]\n",DetLvl,LimitLvl,CurrAlarm.OverInAlarm_CDMALTE_3);
		}

		{
			if((CurrAlarm.OverInAlarm_WCDMALTE_21_1)||(CurrAlarm.OverInAlarm_WCDMALTE_21_2))
			{
				if(CurrAlarm.OverInAlarm_WCDMALTE_21_3)
				{
					Sts->AlmSts.OverInAlarm_WCDMALTE_21 = Alarm;
				}
				else Sts->AlmSts.OverInAlarm_WCDMALTE_21 = Normal;

				if((Sts->AlmSts.FwdOutLowerLmtFail_3G == Alarm))
				{
					Sts->AlmSts.OverInAlarm_WCDMALTE_21 = CurrAlarm.OverInAlarm_WCDMALTE_21_2;
				}
				
				if((Sts->AlmSts.FwdOutLowerLmtFail_LTE_21== Alarm))
				{
					Sts->AlmSts.OverInAlarm_WCDMALTE_21 = CurrAlarm.OverInAlarm_WCDMALTE_21_1;
				}

				
			}
			else Sts->AlmSts.OverInAlarm_WCDMALTE_21 = Normal;
		}


		#if 0
		{
			if((CurrAlarm.OverInAlarm_WCDMALTE_21_1)||(CurrAlarm.OverInAlarm_WCDMALTE_21_2))
			{
				Sts->AlmSts.OverInAlarm_WCDMALTE_21 = Alarm;
			}
			else Sts->AlmSts.OverInAlarm_WCDMALTE_21 = Normal;
		}
		#endif
	}
	
	if(Sts->AlmSts.FwdAmpOnOff_LTE == Enable)
	{
		INT16S DetLvl 		= Sts->RvsInPwr_LTE[0];
 		INT16S LimitLvl  	= -33;
		INT16S RecoveryLvl	= LimitLvl - 1;


		{
			if((DetLvl >= LimitLvl)&&(Sts->RvsOutPwr_LTE[0] > 0))
			{
				Sts->ModuleAlarm.Main.RvsOverInAlarm = Alarm;
			}
			else							
			{
				Sts->ModuleAlarm.Main.RvsOverInAlarm = Normal;
				ChkRvsOverInAlarm = SET;
				RvsOverInAlarmCnt = 0;
			}

			if ( Sts->DetPwr.RvsInPwr_CDMALTE >= LimitLvl)
			{
				// CDMA Over InAlarm 

				INT32S gap;
				gap = Sts->DetPwr.RvsInPwr_CDMALTE - DetLvl;

				if(Sts->DetPwr.RvsInPwr_CDMALTE <= DetLvl )
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
			else if( Sts->DetPwr.RvsInPwr_CDMALTE <= RecoveryLvl) //-34
			{
				Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
				ChkRvsOtherOverInAlarm = SET;
				RvsOtherOverInAlarmCnt = 0;
			}
			else
			{

			}
		}
	}
	else 
	{
		Sts->ModuleAlarm.Main.RvsOverInAlarm = Normal;
		Sts->ModuleAlarm.Main.RvsOtherOverInAlarm = Normal;
	}

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
	Sts->LedAlarm._LED_3G.PllUnlock 		= Sts->AlmSts.LocalFail_WCDMALTE_21;
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
		Sts->LedAlarm._LED_LTE_A2.PllUnlock 	= Sts->AlmSts.LocalFail_LTE_A;
		Sts->LedAlarm._LED_LTE_A2.ShutDown		= Sts->AlmSts.FwdAmpOnOff_LTE_A2;
	}

	{
		if((Sts->AlmSts.FwdOutUpperLmtFail_LTE_21)||(Sts->AlmSts.FwdInUpperLmtFail_LTE_21))
		{
			Sts->LedAlarm._LED_LTE_21.OverInAlarm = Alarm;
		}
		else
		{
			Sts->LedAlarm._LED_LTE_21.OverInAlarm = Normal;
		}
		
		Sts->LedAlarm._LED_LTE_21.RvsOscAlarm	= Sts->AlmSts.RvsOutUpperLmtFail_LTE_21;
		Sts->LedAlarm._LED_LTE_21.LowInputAlarm = Sts->AlmSts.FwdOutLowerLmtFail_LTE_21;
		Sts->LedAlarm._LED_LTE_21.PllUnlock 	= Sts->AlmSts.LocalFail_WCDMALTE_21;
		Sts->LedAlarm._LED_LTE_21.ShutDown		= Sts->AlmSts.FwdAmpOnOff_LTE_21;
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
			AlmSts  = Sts->AlmSts.LocalFail_WCDMALTE_21;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_3G = Disable;
			FlagAmpOnOff_3G = SET;
			if(Sts->AlmSts.LocalFail_WCDMALTE_21)		tDnrSts->AmpOffCase_3G = __PllFail;
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
			AlmSts	= Sts->AlmSts.LocalFail_LTE_A;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Disable;
			FlagAmpOnOff_LTE_A2 = SET;
			
			if(Sts->AlmSts.LocalFail_LTE_A)		
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


	if(Sts->FwdAmpOnOff_LTE_21 == Disable)
	{
		Sts->AlmSts.FwdAmpOnOff_LTE_21 = Disable;
	}
	else
	{
		if(tDnrSts->ShutDownOnOff_LTE_21 == Enable) 
		{
			AlmSts	= Sts->AlmSts.LocalFail_WCDMALTE_21;
		}
		if(AlmSts)
		{
			Sts->AlmSts.FwdAmpOnOff_LTE_21 = Disable;
			FlagAmpOnOff_LTE_21 = SET;
			
			if(Sts->AlmSts.LocalFail_LTE_A)		
			{
				tDnrSts->AmpOffCase_LTE_21 = __PllFail;
			}
		}
		else
		{
			Sts->AlmSts.FwdAmpOnOff_LTE_21 = Enable;

			if(FlagAmpOnOff_LTE_21)
			{
				tDnrSts->AmpOffCase_LTE_21 = __UsrCtrl;
				FlagAmpOnOff_LTE_21 = RESET;
				AttnBufferInit();
			}
		}
	}	
}


void ShutDownCheck(void)
{
	if((tDnrSts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail)||(PwrAlarm.DigitalAlarm))
	{

	}
	else
	{
		if(tDnrSts->ShutDownOnOff_2G == _Enable)
		{
			ShutdownFunc(PATH_2G, SD_FI_2G);
			ShutdownFunc(PATH_2G, SD_FO_2G);
			ShutdownFunc(PATH_2G, SD_RO_2G);
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

		if((tDnrSts->ShutDownOnOff_LTE_A2 == _Enable))
		{
			ShutdownFunc(PATH_LTE_A2, SD_FI_LTE_A2);
			ShutdownFunc(PATH_LTE_A2, SD_FO_LTE_A2);
			ShutdownFunc(PATH_LTE_A2, SD_RO_LTE_A2);
		}

		if(tDnrSts->ShutDownOnOff_LTE_21 == _Enable)
		{
			ShutdownFunc(PATH_LTE_21, SD_FI_LTE_21);
			ShutdownFunc(PATH_LTE_21, SD_FO_LTE_21);
			ShutdownFunc(PATH_LTE_21, SD_RO_LTE_21);
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

			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_2G == AGCATTMAX_800M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			break;

		case SD_FO_2G:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_2G;
			DetValue = Sts->FwdOutPwr_2G[0]*10 + Sts->FwdOutPwr_2G[1];
			LmtValue = Sts->FwdOutHighLmt_2G[0]*10 + Sts->FwdOutHighLmt_2G[1];
			AmpOnOff = &Sts->FwdAmpOnOff_2G;
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_2G == AGCATTMAX_800M))
			{
				AlarmChk = SET;
			}		
			else AlarmChk = SET;
			break;

		case SD_RO_2G:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_2G;
			DetValue = Sts->RvsOutPwr_2G[0]*10 + Sts->RvsOutPwr_2G[1];
//			DetValue = Sts->RvsInPwr_2G[0]*10 + Sts->RvsInPwr_2G[1];
			LmtValue = Sts->RvsOutUpperLmt_2G[0]*10 + Sts->RvsOutUpperLmt_2G[1];
			AmpOnOff = &Sts->FwdAmpOnOff_2G;
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->RvsAlcAttn_2G == RVSALCATTMAX_800M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			break;
		//---------------------------------------------------------------------//
		// LTE
		case SD_FI_LTE:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE;
			DetValue = -tDnrSts->FwdInPwr_LTE;
			LmtValue = tDnrSts->OverInAlarmLmt_LTE/2;	 //과입력 Shutdown -8dBm
			AmpOnOff = &Sts->FwdAmpOnOff_LTE;
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_LTE == AGCATTMAX_800M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			break;

		case SD_FO_LTE:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE;
			DetValue = Sts->FwdOutPwr_LTE[0]*10 + Sts->FwdOutPwr_LTE[1];
			LmtValue = Sts->FwdOutHighLmt_LTE[0]*10 + Sts->FwdOutHighLmt_LTE[1];
			AmpOnOff = &Sts->FwdAmpOnOff_LTE;
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->FwdAgcAttn_LTE == AGCATTMAX_800M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			break;

		case SD_RO_LTE:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE;
			DetValue = Sts->RvsOutPwr_LTE[0]*10 + Sts->RvsOutPwr_LTE[1];
//			DetValue = Sts->RvsInPwr_LTE[0]*10 + Sts->RvsInPwr_LTE[1];
			LmtValue = Sts->RvsOutUpperLmt_LTE[0]*10 + Sts->RvsOutUpperLmt_LTE[1];
			AmpOnOff = &Sts->FwdAmpOnOff_LTE;
			
			if((Sts->AGCOnOff_CDMALTE == Enable)&&(Sts->RvsAlcAttn_LTE == RVSALCATTMAX_800M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			break;

		//---------------------------------------------------------------------//
		// 3G
		case SD_FI_3G:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_3G;
			DetValue = - tDnrSts->FwdInPwr_3G;
			LmtValue = tDnrSts->OverInAlarmLmt_3G/2;	//과입력 Shutdown  -19dBm
			AmpOnOff = &Sts->FwdAmpOnOff_3G;
			if((Sts->AGCOnOff_WCDMALTE_21 == Enable)&&(Sts->FwdAgcAttn_3G == AGCATTMAX_2100M))
			{
				AlarmChk = SET;
			}	
			else AlarmChk = SET;
			break;

		case SD_FO_3G:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_3G;
			DetValue = Sts->FwdOutPwr_3G[0]*10 + Sts->FwdOutPwr_3G[1];
			LmtValue = Sts->FwdOutHighLmt_3G[0]*10 + Sts->FwdOutHighLmt_3G[1];
			AmpOnOff = &Sts->FwdAmpOnOff_3G;
			if((Sts->AGCOnOff_WCDMALTE_21 == Enable)&&(Sts->FwdAgcAttn_3G == AGCATTMAX_2100M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			break;

		case SD_RO_3G:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_3G;
			DetValue = Sts->RvsOutPwr_3G[0]*10 + Sts->RvsOutPwr_3G[1];
//			DetValue = Sts->RvsInPwr_3G[0]*10 + Sts->RvsInPwr_3G[1];
			LmtValue = Sts->RvsOutUpperLmt_3G[0]*10 + Sts->RvsOutUpperLmt_3G[1];
			AmpOnOff = &Sts->FwdAmpOnOff_3G;
			
			if((Sts->AGCOnOff_WCDMALTE_21 == Enable)&&(Sts->RvsAlcAttn_3G == RVSALCATTMAX_2100M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			break;

		//---------------------------------------------------------------------//
		// LTE-A2
		case SD_FI_LTE_A2:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE_A2;
			DetValue = -tDnrSts->FwdInPwr_LTE_A2;
			LmtValue = tDnrSts->OverInAlarmLmt_LTE_A2/2;	// 과입력 Shutdown -15dBm
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A2;

			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->FwdAgcAttn_LTE_A2 == AGCATTMAX_1800M))
			{
				AlarmChk = SET;
			}	
			else AlarmChk = SET;
			break;

		case SD_FO_LTE_A2:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE_A2;
			DetValue = Sts->FwdOutPwr_LTE_A2[0]*10 + Sts->FwdOutPwr_LTE_A2[1];
			LmtValue = Sts->FwdOutHighLmt_LTE_A2[0]*10 + Sts->FwdOutHighLmt_LTE_A2[1];
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A2;
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->FwdAgcAttn_LTE_A2 == AGCATTMAX_1800M))
			{
				AlarmChk = SET;
			}	
			else AlarmChk = SET;
			break;

		case SD_RO_LTE_A2:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE_A2;
			DetValue = Sts->RvsOutPwr_LTE_A2[0]*10 + Sts->RvsOutPwr_LTE_A2[1];
//			DetValue = Sts->RvsInPwr_LTE_A2[0]*10 + Sts->RvsInPwr_LTE_A2[1];

			LmtValue = (Sts->RvsOutUpperLmt_LTE_A2[0]*10 + Sts->RvsOutUpperLmt_LTE_A2[1]);
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_A2;
			
			if((Sts->AGCOnOff_LTE_A_0 == Enable)&&(Sts->RvsAlcAttn_LTE_A2 == RVSALCATTMAX_1800M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
			
			break;
		//---------------------------------------------------------------------//
		// LTE-21
		case SD_FI_LTE_21:
			OffReason = CASE_OverInPwr;
			SdTimer = TimerSD_LTE_21;
			DetValue = -tDnrSts->FwdInPwr_LTE_21;
			LmtValue = tDnrSts->OverInAlarmLmt_LTE_21/2;	// 과입력 Shutdown -15dBm
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_21;
			if((Sts->AGCOnOff_WCDMALTE_21 == Enable)&&(Sts->FwdAgcAttn_LTE_21 == AGCATTMAX_2100M))
			{
				AlarmChk = SET;
			}		
			else AlarmChk = SET;
			break;

		case SD_FO_LTE_21:
			OffReason = CASE_OverPwr;
			SdTimer = TimerSD_LTE_21;
			DetValue = Sts->FwdOutPwr_LTE_21[0]*10 + Sts->FwdOutPwr_LTE_21[1];
			LmtValue = Sts->FwdOutHighLmt_LTE_21[0]*10 + Sts->FwdOutHighLmt_LTE_21[1];
			AmpOnOff = &Sts->FwdAmpOnOff_LTE_21;
			if((Sts->AGCOnOff_WCDMALTE_21 == Enable)&&(Sts->FwdAgcAttn_LTE_21 == AGCATTMAX_2100M))
			{
				AlarmChk = SET;
			}		
			else AlarmChk = SET;
			break;

		case SD_RO_LTE_21:
			OffReason = CASE_RvsFail;
			SdTimer = TimerSD_LTE_21;
			DetValue = Sts->RvsOutPwr_LTE_21[0]*10 + Sts->RvsOutPwr_LTE_21[1];
//			DetValue = Sts->RvsInPwr_LTE_21[0]*10 + Sts->RvsInPwr_LTE_21[1];
//			LmtValue = (Sts->RvsOutUpperLmt_LTE_A2[0]*10 + Sts->RvsOutUpperLmt_LTE_21[1]);
			LmtValue = (Sts->RvsOutUpperLmt_LTE_21[0]*10 + Sts->RvsOutUpperLmt_LTE_21[1]);
	

			AmpOnOff = &Sts->FwdAmpOnOff_LTE_21;
			if((Sts->AGCOnOff_WCDMALTE_21 == Enable)&&(Sts->RvsAlcAttn_LTE_21 == RVSALCATTMAX_2100M))
			{
				AlarmChk = SET;
			}
			else AlarmChk = SET;
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
			
			break;
			
		case 2:  // Amp On Check = After 5sec
			if(!TimeOverCheck(SdTimer))	return;

			Sd_Cnt[Path]++; // Off Count
			if(Sd_Cnt[Path] >= 3)
			{
#ifdef Alarm_Test
				TimerRegist(SdTimer, Time1Sec*20L);
#else
				if(tDnrSts->ShunDownTime == 0)		TimerRegist(SdTimer, Time1Sec*60L*30L); 
				else								TimerRegist(SdTimer, Time1Sec*20L); 

#endif
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
			if(DetValue < (LmtValue))	// 정상...
			{
				Sd_Step[Path] = 0;
				Sd_Path[SysPath] = 0;
				break;
			}
			if(!TimeOverCheck(SdTimer)) return;
			*AmpOnOff = _Disable;
			AmpBitReason(SysPath, _Disable, OffReason, SD_AMP_OFF_INF);
			
			Sd_Step[Path] = 30; // 완전 Shutdown
#if 0
			if(!TimeOverCheck(SdTimer))
			{   // Timer  동안 유지 Check
				if(DetValue<LmtValue)	Sd_Step[Path] = 0;
				break;
			}

			*AmpOnOff = _Disable;
			AmpBitReason(SysPath, _Disable, OffReason, SD_AMP_OFF_INF);

			Sd_Step[Path] = 30;	// 완전 Shutdown
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
 			break;

		//---------------------------------------------------------------------//
		default :
			Sd_Step[Path] = 0;
			Sd_Path[SysPath] = 0;
		break;
	}
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


void AlarmStatusUpdate(void)
{
	__Dnr_Sts *Sts = tDnrSts;

////////////////////////

	PwrAlarm.ACFail							= Sts->AlmSts.ACFail;

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

	PwrAlarm.OverInAlarm_WCDMALTE_21	= Sts->AlmSts.OverInAlarm_WCDMALTE_21;	


	PwrAlarm.LocalFail_WCDMALTE_21		= Sts->AlmSts.LocalFail_WCDMALTE_21;		

	if(AlarmCheck_LTE_A2 == SET)
	{
		if(Sd_Step[SD_FI_LTE_A2] >= 3) 	PwrAlarm.FwdInUpperLmtFail_LTE_A2	= Sts->AlmSts.FwdInUpperLmtFail_LTE_A2;
		else							PwrAlarm.FwdInUpperLmtFail_LTE_A2	= 0;

		if(Sd_Step[SD_FO_LTE_A2] >= 3) 	PwrAlarm.FwdOutUpperLmtFail_LTE_A2	= Sts->AlmSts.FwdOutUpperLmtFail_LTE_A2;	
		else							PwrAlarm.FwdOutUpperLmtFail_LTE_A2	= 0;

		if(Sd_Step[SD_RO_LTE_A2] >= 3)	PwrAlarm.RvsOutUpperLmtFail_LTE_A2	= Sts->AlmSts.RvsOutUpperLmtFail_LTE_A2;
		else							PwrAlarm.RvsOutUpperLmtFail_LTE_A2	= 0;

		PwrAlarm.LocalFail_LTE_A		= Sts->AlmSts.LocalFail_LTE_A;
		PwrAlarm.OverInAlarm_LTE_A = Sts->AlmSts.OverInAlarm_LTE_A;
	}

	if(AlarmCheck_LTE_21 == SET)
	{
		if(Sd_Step[SD_FI_LTE_21] >= 3)	PwrAlarm.FwdInUpperLmtFail_LTE_21	= Sts->AlmSts.FwdInUpperLmtFail_LTE_21;
		else							PwrAlarm.FwdInUpperLmtFail_LTE_21	= 0;

		if(Sd_Step[SD_FO_LTE_21] >= 3)	PwrAlarm.FwdOutUpperLmtFail_LTE_21	= Sts->AlmSts.FwdOutUpperLmtFail_LTE_21;	
		else							PwrAlarm.FwdOutUpperLmtFail_LTE_21	= 0;

		if(Sd_Step[SD_RO_LTE_21] >= 3)	PwrAlarm.RvsOutUpperLmtFail_LTE_21	= Sts->AlmSts.RvsOutUpperLmtFail_LTE_21;
		else							PwrAlarm.RvsOutUpperLmtFail_LTE_21	= 0;

	}

	//	if((PwrAlarm.ACFail)||(PwrAlarm.DigitalAlarm))
//	if((Sts->ModuleAlarm.Main.DCFail)||(PwrAlarm.ACFail)||(PwrAlarm.DigitalAlarm))

	if((PwrAlarm.ACFail)||(PwrAlarm.DigitalAlarm))
	{

	}
	else
	{
		PwrAlarm.FwdAmpOnOff_3G 		= Sts->AlmSts.FwdAmpOnOff_3G;
		PwrAlarm.FwdAmpOnOff_2G 		= Sts->AlmSts.FwdAmpOnOff_2G;
		PwrAlarm.FwdAmpOnOff_LTE		= Sts->AlmSts.FwdAmpOnOff_LTE;
		PwrAlarm.FwdAmpOnOff_LTE_21		= Sts->AlmSts.FwdAmpOnOff_LTE_21;
		PwrAlarm.FwdAmpOnOff_LTE_A2 	= Sts->AlmSts.FwdAmpOnOff_LTE_A2;
	}

	PwrAlarm.DigitalAlarm					= Sts->AlmSts.DigitalAlarm;
	PwrAlarm.ULGainLowAlarm_CDMALTE 		= Sts->AlmSts.ULGainLowAlarm_CDMALTE;
	PwrAlarm.ULGainLowAlarm_LTEA			= Sts->AlmSts.ULGainLowAlarm_LTEA;
	PwrAlarm.ULGainLowAlarm_WCDMALTE_21		= Sts->AlmSts.ULGainLowAlarm_WCDMALTE_21;
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
	*ChangeFlag = 0;
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
	
	for(i = Local_FwdOutAvgPwr_CDMALTE; i <= Local_PwrSts_Max; i++)
	{
		Pwr0TblAlarm 	+= OutPutTable_Alarm_check(i);
		//SerPtr->printf("Pwr0TblAlarm[%d]:[%d]\n", i, Pwr0TblAlarm);
	}

	for(i = Local_FwdAttn1_CDMALTE; i <= Local_AttnSts_Max; i++)
	{
		Att0TblAlarm 	+= AttTable_Alarm_check(i);
	}


	AlarmSum = Pwr0TblAlarm + Att0TblAlarm;

	if(AlarmSum)	tDnrSts->TableStatus = Alarm;
	else			tDnrSts->TableStatus = Normal;

}

INT8U OutPutTable_Alarm_check(INT8U tIndex)
{
	
	INT32S i = 0;
	INT8U rval = Normal;
	INT8S tPass = 0;

	PwrTblAlarm[tIndex] = Normal;

	{
		INT16U *dptr;
		INT32S limit;
		INT32S nsize;

		INT8S TblLmt;
		INT8S TblSize;

 		if(tIndex == Local_FwdOutAvgPwr_CDMALTE)
		{
			dptr  = OutputTable->FwdOutAvgPwr_CDMALTE.Data;
			limit = OutputTable->FwdOutAvgPwr_CDMALTE.limit;
			nsize = OutputTable->FwdOutAvgPwr_CDMALTE.nsize;
			TblLmt  = FwdOutAvgPwr_CDMALTE_TblLmt;
			TblSize = FwdOutAvgPwr_CDMALTE_TblSize;
			OutputTable->FwdOutAvgPwr_CDMALTE.limit = TblLmt;
			OutputTable->FwdOutAvgPwr_CDMALTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_CDMALTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_CDMALTE.nsize = TblSize;
				rval = Alarm;
			}
		}
		else if(tIndex == Local_RvsOutPwr_CDMALTE)
		{
			dptr  = OutputTable->RvsOutPwr_CDMALTE.Data;
			limit = OutputTable->RvsOutPwr_CDMALTE.limit;
			nsize = OutputTable->RvsOutPwr_CDMALTE.nsize;
			TblLmt  = RvsOutPwr_CDMALTE_TblLmt;
			TblSize = RvsOutPwr_CDMALTE_TblSize;
			OutputTable->RvsOutPwr_CDMALTE.limit = TblLmt;
			OutputTable->RvsOutPwr_CDMALTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_CDMALTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_CDMALTE.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_FwdOutAvgPwr_3G)
		{
			dptr  = OutputTable->FwdOutAvgPwr_WCDMALTE_21.Data;
			limit = OutputTable->FwdOutAvgPwr_WCDMALTE_21.limit;
			nsize = OutputTable->FwdOutAvgPwr_WCDMALTE_21.nsize;
			TblLmt  = FwdOutAvgPwr_3G_TblLmt;
			TblSize = FwdOutAvgPwr_3G_TblSize;
			OutputTable->FwdOutAvgPwr_WCDMALTE_21.limit = TblLmt;
			OutputTable->FwdOutAvgPwr_WCDMALTE_21.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_WCDMALTE_21.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_WCDMALTE_21.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_RvsOutPwr_3G)
		{
			dptr  = OutputTable->RvsOutPwr_WCDMALTE_21.Data;
			limit = OutputTable->RvsOutPwr_WCDMALTE_21.limit;
			nsize = OutputTable->RvsOutPwr_WCDMALTE_21.nsize;
			TblLmt  = RvsOutPwr_3G_TblLmt;
			TblSize = RvsOutPwr_3G_TblSize;
			OutputTable->RvsOutPwr_WCDMALTE_21.limit = TblLmt;
			OutputTable->RvsOutPwr_WCDMALTE_21.nsize = TblSize;
			
//			SerPtr->printf("nsize[%d]:[%d][%d]\n", tIndex,nsize,TblSize);

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_WCDMALTE_21.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_WCDMALTE_21.nsize = TblSize;
				rval = Alarm;
			}
		}
		else
		{
			tPass = SET;
		}

		if( tPass != SET)
		{
			for(i = 0; i < nsize && i < OutputTBL_Size; i++)
			{
				if((dptr[i] > 3500)||(dptr[i] < 100))	
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
		}
	
		PwrTblAlarm[tIndex] = rval;
	}

	return rval;
}
 INT8U AttTable_Alarm_check(INT8U tIndex)
{
	INT32S i = 0;
	INT8U rval = Normal;
	INT8S *dptr;
	INT8U nsize;
	INT8S tPass = 0;
	AttnTblAlarm[tIndex] = Normal;

	if (tIndex == Local_FwdAttn1_CDMALTE)
	{
		dptr = AttnOffsetTable->FwdAttn1_CDMALTE.Data;
		nsize = AttnOffsetTable->FwdAttn1_CDMALTE.nsize;
	}	
	else if (tIndex == Local_RvsAttn1_CDMALTE)
	{
		dptr = AttnOffsetTable->RvsAttn1_CDMALTE.Data;
		nsize = AttnOffsetTable->RvsAttn1_CDMALTE.nsize;
	}	
	else if (tIndex == Local_FwdAttn1_LTE_A)
	{
		dptr = AttnOffsetTable->FwdAttn1_LTE_A.Data;
		nsize = AttnOffsetTable->FwdAttn1_LTE_A.nsize;
	}	
	else if (tIndex == Local_RvsAttn1_LTE_A)
	{
		dptr = AttnOffsetTable->RvsAttn1_LTE_A.Data;
		nsize = AttnOffsetTable->RvsAttn1_LTE_A.nsize;
	}	
	else if (tIndex == Local_RvsAttn2_LTE_A)
	{
		dptr = AttnOffsetTable->RvsAttn2_LTE_A.Data;
		nsize = AttnOffsetTable->RvsAttn2_LTE_A.nsize;
	}	

	else if (tIndex == Local_FwdAttn1_WCDMALTE_21)
	{
		dptr = AttnOffsetTable->FwdAttn1_WCDMALTE_21.Data;
		nsize = AttnOffsetTable->FwdAttn1_WCDMALTE_21.nsize;
	}	
	else if (tIndex == Local_RvsAttn1_WCDMALTE_21)
	{
		dptr = AttnOffsetTable->RvsAttn1_WCDMALTE_21.Data;
		nsize = AttnOffsetTable->RvsAttn1_WCDMALTE_21.nsize;
	}	
	else if (tIndex == Local_RvsAttn2_WCDMALTE_21)
	{
		dptr = AttnOffsetTable->RvsAttn2_WCDMALTE_21.Data;
		nsize = AttnOffsetTable->RvsAttn2_WCDMALTE_21.nsize;
	}	
	else if (tIndex == Local_RvsAttn3_WCDMALTE_21)
	{
		dptr = AttnOffsetTable->RvsAttn3_WCDMALTE_21.Data;
		nsize = AttnOffsetTable->RvsAttn3_WCDMALTE_21.nsize;
	}	
	else
	{
		tPass = SET;
	}	
 
	if(tPass == RESET)
	{
 	
		for(i = 0;i < AttTBL_Size; i++)
		{
			if(abs(dptr[i]) > 10)	rval = Alarm;
		}
		
		if((nsize < 10)||(nsize > AttTBL_Size))  rval = Alarm;	

		AttnTblAlarm[tIndex]= rval;
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


INT8U OffsetLmtCheck(INT8S Value,INT8S Offset)
{
	INT8U rval = Normal;

//	if(abs(Value) > Offset)	rval = Alarm;

	return rval;
}


INT8U TblLmtCheck(INT8S tlimit,INT8S tTblLimit)
{
	INT8U tmp = Normal;;

	if((tlimit < (tTblLimit - 5*2)) ||(tlimit > (tTblLimit + 2*2)))tmp = Alarm;
	
	return tmp;
}

INT8U HighLimitCheck1(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl)
{
	INT8U tmp = 0;

 		 if(DetLvl >= LimitLvl)		tmp = Alarm;
	else if(DetLvl <= RecoveryLvl)	tmp = Normal;
	
	return tmp;
}



INT8U LowLimitCheck1(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl)
{
	INT8U tmp = 0;

 	     if(DetLvl <= LimitLvl)		tmp =  Alarm;
	else if(DetLvl >= RecoveryLvl)	tmp = Normal;

	return tmp;
}




INT8U HighLimitCheck1_Test(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl)
{
	INT8U tmp = 0;

 		 if(DetLvl >= LimitLvl)		tmp = Alarm;
	else if(DetLvl <= RecoveryLvl)	tmp = Normal;
	
	Ser3Ptr->printf("LowLimitCheck1_Test[%d][%d][%d]>[%d]\n",DetLvl ,LimitLvl ,RecoveryLvl,tmp );
	return tmp;
}



INT8U HighLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm)
{
 	     if(DetLvl >= LimitLvl)				return Alarm;
	else if(DetLvl <= LimitLvl - Offset)	return Normal;

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
