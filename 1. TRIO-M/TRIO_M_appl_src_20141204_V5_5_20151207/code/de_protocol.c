/*********************************************
* File Name          : DE_Protocol.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/
#define DE_Protocol_C

#include "../include/main.h"

INT16U GenDnrAidSts(INT8U *dptr, __Dnr_Sts *Sts,__ProtocolPtr *nPtr )
{
	INT16U rlen = 0;
	INT16U i = 0;

	i = i;
	// alarm !!
	dptr[rlen++] = (Aid_RepeaterAlarm >> 8) & 0xff;
	dptr[rlen++] = (Aid_RepeaterAlarm >> 0) & 0xff;
	dptr[rlen++] = 2 *(sizeof(__DnrAlarmDataStr));

	for(i = 0; i < (sizeof(__DnrAlarmDataStr)); i++)	dptr[rlen++] = *((INT8U *)&(Sts->Flag) + i);
	for(i = 0; i < (sizeof(__DnrAlarmDataStr)); i++)	dptr[rlen++] = *((INT8U *)&(Sts->AlmSts) + i);

	// Manufacture !!
	rlen += GenAidData(Aid_Manufacture, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Manufacture), 1);

	// Supplier !!
	rlen += GenAidData(Aid_Supplier, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Supplier), 1);

	// RepeaterType !!
	rlen += GenAidData(Aid_RepeaterType, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RepeaterType[0]), 2);

	// SystemVer !!
	rlen += GenAidData(Aid_SystemVer,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SWVer), 1);
	rlen += GenAidData(Aid_MobileManufacture,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->MobileManufacture), 1);
	rlen += GenAidData(Aid_MobileModel, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->MobileModel), 1);
	rlen += GenAidData(Aid_MobileVer,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->MobileVer), sizeof(Sts->MobileVer));


	rlen += GenAidData(Aid_FwdInPwr_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_3G), sizeof(Sts->FwdInPwr_3G));
	rlen += GenAidData(Aid_FwdOutPwr_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_3G), sizeof(Sts->FwdOutPwr_3G));
	rlen += GenAidData(Aid_FwdOutUpperLmt_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_3G), sizeof(Sts->FwdOutUpperLmt_3G));
	rlen += GenAidData(Aid_FwdOutLowerLmt_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_3G), sizeof(Sts->FwdOutLowerLmt_3G));
	rlen += GenAidData(Aid_FwdGainSet_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_3G), 1);
	rlen += GenAidData(Aid_FwdGain_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_3G), 1);

	rlen += GenAidData(Aid_FwdInPwr_2G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_2G), sizeof(Sts->FwdInPwr_2G));
	rlen += GenAidData(Aid_FwdOutPwr_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_2G), sizeof(Sts->FwdOutPwr_2G));
	rlen += GenAidData(Aid_FwdOutUpperLmt_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_2G), sizeof(Sts->FwdOutUpperLmt_2G));
	rlen += GenAidData(Aid_FwdOutLowerLmt_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_2G), sizeof(Sts->FwdOutLowerLmt_2G));
	rlen += GenAidData(Aid_FwdGainSet_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_2G), 1);
	rlen += GenAidData(Aid_FwdGainSts_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_2G), 1);

	rlen += GenAidData(Aid_FwdInPwr_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_LTE), sizeof(Sts->FwdInPwr_LTE));
	rlen += GenAidData(Aid_FwdOutPwr_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_LTE), sizeof(Sts->FwdOutPwr_LTE));
	rlen += GenAidData(Aid_FwdOutUpperLmt_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_LTE), sizeof(Sts->FwdOutUpperLmt_LTE));
	rlen += GenAidData(Aid_FwdOutLowerLmt_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_LTE), sizeof(Sts->FwdOutLowerLmt_LTE));
	rlen += GenAidData(Aid_FwdGainSet_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_LTE), 1);
	rlen += GenAidData(Aid_FwdGainSts_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_LTE), 1);

	rlen += GenAidData(Aid_FwdInPwr_LTE_A1,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_LTE_A1), sizeof(Sts->FwdInPwr_LTE_A1));
	rlen += GenAidData(Aid_FwdOutPwr_LTE_A1, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_LTE_A1), sizeof(Sts->FwdOutPwr_LTE_A1));
	rlen += GenAidData(Aid_FwdOutUpperLmt_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_LTE_A1), sizeof(Sts->FwdOutUpperLmt_LTE_A1));
	rlen += GenAidData(Aid_FwdOutLowerLmt_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_LTE_A1), sizeof(Sts->FwdOutLowerLmt_LTE_A1));
	rlen += GenAidData(Aid_FwdGainSet_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_LTE_A1), 1);
	rlen += GenAidData(Aid_FwdGain_LTE_A1,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_LTE_A1), 1);

	rlen += GenAidData(Aid_FwdInPwr_LTE_A2,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_LTE_A2), sizeof(Sts->FwdInPwr_LTE_A2));
	rlen += GenAidData(Aid_FwdOutPwr_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_LTE_A2), sizeof(Sts->FwdOutPwr_LTE_A2));
	rlen += GenAidData(Aid_FwdOutUpperLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_LTE_A2), sizeof(Sts->FwdOutUpperLmt_LTE_A2));
	rlen += GenAidData(Aid_FwdOutLowerLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_LTE_A2), sizeof(Sts->FwdOutLowerLmt_LTE_A2));
	rlen += GenAidData(Aid_FwdGainSet_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_LTE_A2), 1);
	rlen += GenAidData(Aid_FwdGain_LTE_A2,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_LTE_A2), 1);
 	rlen += GenAidData(Aid_RvsGainSts_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE_A2), 1);


	rlen += GenAidData(Aid_RvsGainSet_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_3G), 1);
	rlen += GenAidData(Aid_RvsGainSts_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_3G), 1);
	rlen += GenAidData(Aid_RvsGainBalance_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_3G), 1);
	rlen += GenAidData(Aid_RvsGainSet_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_2G), 1);
	rlen += GenAidData(Aid_RvsGainSts_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_2G), 1);
	rlen += GenAidData(Aid_RvsGainBalance_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_2G), 1);
	rlen += GenAidData(Aid_RvsGainSet_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_LTE), 1);
	rlen += GenAidData(Aid_RvsGainSts_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE), 1);
	rlen += GenAidData(Aid_RvsGainBalance_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_LTE), 1);
	rlen += GenAidData(Aid_RvsGainSet_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_LTE_A1), 1);
	rlen += GenAidData(Aid_RvsGainSts_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE_A1), 1);
	rlen += GenAidData(Aid_RvsGainBalance_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_LTE_A1), 1);
	rlen += GenAidData(Aid_RvsGainSet_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_LTE_A2), 1);
	rlen += GenAidData(Aid_RvsGainSts_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE_A2), 1);
	rlen += GenAidData(Aid_RvsGainBalance_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_LTE_A2), 1);


	rlen += GenAidData(Aid_AmpOffCase_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_3G), 1);
	rlen += GenAidData(Aid_AmpOffCase_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_2G), 1);
	rlen += GenAidData(Aid_AmpOffCase_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_LTE), 1);
	rlen += GenAidData(Aid_AmpOffCase_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_LTE_A1), 1);
	rlen += GenAidData(Aid_AmpOffCase_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_LTE_A2), 1);


	rlen += GenAidData(Aid_LTE15MUse,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LTE15MUse), 1);
	rlen += GenAidData(Aid_RepeatResetPriod,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RepeatResetPriod), 1);

	rlen += GenAidData(Aid_AGCOnOff_3G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_3G), 1);
	rlen += GenAidData(Aid_AGCOnOff_CDMALTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_CDMALTE), 1);
	rlen += GenAidData(Aid_AGCOnOff_LTE_A_0,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_LTE_A_0), 1);

	rlen += GenAidData(Aid_AGCMode_3G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_3G), 1);
	rlen += GenAidData(Aid_AGCMode_2G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_2G), 1);
	rlen += GenAidData(Aid_AGCMode_LTE, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE), 1);
	rlen += GenAidData(Aid_AGCMode_LTE_A1,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE_A1), 1);
	rlen += GenAidData(Aid_AGCMode_LTE_A2,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE_A2), 1);

	rlen += GenAidData(Aid_Band_Select_LTE_A1,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Band_Select_LTE_A1), sizeof(Sts->Band_Select_LTE_A1));	
	rlen += GenAidData(Aid_Band_Select_LTE_A2,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Band_Select_LTE_A2), sizeof(Sts->Band_Select_LTE_A2));	
	rlen += GenAidData(Aid_FemtocellUseOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FemtocellUseOnOff), sizeof(Sts->FemtocellUseOnOff));	
	rlen += GenAidData(Aid_RvsOverInAlarmCount, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOverInAlarmCount), sizeof(Sts->RvsOverInAlarmCount));
	rlen += GenAidData(Aid_RvsOtherOverInAlarmCount, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOtherOverInAlarmCount), sizeof(Sts->RvsOverInAlarmCount));


	rlen += GenAidData(Aid_HostStn, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->HostNumber), 11);
	rlen += GenAidData(Aid_AutoReportPriod, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AutoReportPriod), 1);
	// AutoReportTime
	rlen += GenAidData(Aid_ReportTime,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AutoReportBasePer), sizeof(Sts->AutoReportBasePer));
	// ReportHours
	rlen += GenAidData(Aid_ReportHours,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ReportHours), sizeof(Sts->ReportHours));





///////////////////////////////////////////
	rlen += GenAidData(Aid_TPTL_OnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TPTL_OnOff), 1);
	rlen += GenAidData(Aid_TempOffset,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TempOffset), 1);
	rlen += GenAidData(Aid_RCUAddVer,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RCUAddVer), 1);
	rlen += GenAidData(Aid_AlarmMask,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AlarmMask), 1);

	if(iRepeaterType == _TRIO_MM)
	{
		rlen += GenAidData(Aid_LedAlarm,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LedAlarm), sizeof(Sts->LedAlarm));
	}
	else
	{
		rlen += GenAidData(Aid_LedAlarm,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LedAlarm), (sizeof(Sts->LedAlarm)- 3));
	}
	rlen += GenAidData(Aid_ModemMINNumber,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->MinNumber), sizeof(Sts->MinNumber));
	rlen += GenAidData(Aid_ModemOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ModemOnOff), 1);
	rlen += GenAidData(Aid_ModuleAlarm, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ModuleAlarm), sizeof(Sts->ModuleAlarm));
	rlen += GenAidData(Aid_ModuleTemp,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrentTemp), sizeof(Sts->CurrentTemp));
	rlen += GenAidData(Aid_TableSts,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TableStatus), sizeof(Sts->TableStatus));
	rlen += GenAidData(Aid_LockOrderSts,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LockOrderSts), sizeof(Sts->LockOrderSts));

	// VccDet_Lmt
	dptr[rlen++] = (Aid_VccDet_Lmt >> 8) & 0xff;
	dptr[rlen++] = (Aid_VccDet_Lmt >> 0) & 0xff;
	dptr[rlen++] = 2;
	dptr[rlen++] = (Sts->VccDet_Lmt.Byte.High);
	dptr[rlen++] = (Sts->VccDet_Lmt.Byte.Low);

	rlen += GenAidData(Aid_FwdInPwrOffset_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwrOffset_2G), 1);
	rlen += GenAidData(Aid_FwdInPwrOffset_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwrOffset_3G), 1);
	rlen += GenAidData(Aid_Rvs0OutPwrOffset_2G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutPwrOffset_2G), 1);
	rlen += GenAidData(Aid_Rvs0OutPwrOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutPwrOffset_3G), 1);
	rlen += GenAidData(Aid_FwdOutPwrOffset_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwrOffset_2G), 1);
	rlen += GenAidData(Aid_FwdOutPwrOffset_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwrOffset_3G), 1);
	rlen += GenAidData(Aid_FwdAttn1_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_2G, 1);
	rlen += GenAidData(Aid_FwdAttn2_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_2G, 1);
	rlen += GenAidData(Aid_FwdAttn1_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_3G, 1);
	rlen += GenAidData(Aid_FwdAttn2_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_3G, 1);
	rlen += GenAidData(Aid_RvsAttn1_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_2G, 1);
	rlen += GenAidData(Aid_RvsAttn2_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_2G, 1);
	rlen += GenAidData(Aid_RvsAttn3_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_2G, 1);
	rlen += GenAidData(Aid_RvsAttn1_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_3G, 1);
	rlen += GenAidData(Aid_RvsAttn2_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_3G, 1);
	rlen += GenAidData(Aid_RvsAttn3_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_3G, 1);
	rlen += GenAidData(Aid_RvsAttn4_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn4_3G, 1);
	rlen += GenAidData(Aid_ResetPeriodCountSts, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->ResetPeriodCountSts), sizeof(Sts->ResetPeriodCountSts));
	rlen += GenAidData(Aid_ResetPeriodCountSet, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->ResetPeriodCountSet), sizeof(Sts->ResetPeriodCountSet));
	rlen += GenAidData(Aid_FwdInPwrOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdInPwrOffset_LTE, 1);
	rlen += GenAidData(Aid_FwdOutPwrOffset_LTE, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdOutPwrOffset_LTE, 1);
	rlen += GenAidData(Aid_Rvs0OutPwrOffset_LTE,(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsOutPwrOffset_LTE, 1);
	rlen += GenAidData(Aid_SmsRvsOutPwr_3G, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_3G), sizeof(Sts->RvsOutPwr_3G));
	rlen += GenAidData(Aid_SmsRvsOutPwr_2G, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_2G), sizeof(Sts->RvsOutPwr_2G));
	rlen += GenAidData(Aid_ShutDownOnOff_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ShutDownOnOff_3G), sizeof(Sts->ShutDownOnOff_3G));
	rlen += GenAidData(Aid_ShutDownOnOff_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ShutDownOnOff_2G), sizeof(Sts->ShutDownOnOff_2G));
	rlen += GenAidData(Aid_RvsOutUpperLmt_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_3G), sizeof(Sts->RvsOutUpperLmt_3G));
	rlen += GenAidData(Aid_RvsOutUpperLmt_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_2G), sizeof(Sts->RvsOutUpperLmt_2G));
	rlen += GenAidData(Aid_FwdGainOffset_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainOffset_3G), sizeof(Sts->FwdGainOffset_3G));
	rlen += GenAidData(Aid_RvsGainOffset_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainOffset_3G), sizeof(Sts->RvsGainOffset_3G));
	rlen += GenAidData(Aid_FwdGainOffset_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainOffset_2G), sizeof(Sts->FwdGainOffset_2G));
	rlen += GenAidData(Aid_RvsGainOffset_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainOffset_2G), sizeof(Sts->RvsGainOffset_2G));
	rlen += GenAidData(Aid_FwdTemp_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdTemp_3G), sizeof(Sts->FwdTemp_3G));
	rlen += GenAidData(Aid_RvsTemp_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsTemp_3G), sizeof(Sts->RvsTemp_3G));
	rlen += GenAidData(Aid_FwdTemp_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdTemp_2G), sizeof(Sts->FwdTemp_2G));
	rlen += GenAidData(Aid_RvsTemp_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsTemp_2G), sizeof(Sts->RvsTemp_2G));
	rlen += GenAidData(Aid_FwdOutHighLmt_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_3G), sizeof(Sts->FwdOutHighLmt_3G));
	rlen += GenAidData(Aid_FwdOutHighLmt_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_2G), sizeof(Sts->FwdOutHighLmt_2G));
	rlen += GenAidData(Aid_DebugOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->DebugOnOff, 1);
	rlen += GenAidData(Aid_RadioMeasureOnOff,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RadioMeasureOnOff, 1);

	// Adc_Value
	dptr[rlen++] = (Aid_DetVolt >> 8) & 0xff;
	dptr[rlen++] = (Aid_DetVolt >> 0) & 0xff;
	dptr[rlen++] = sizeof(__DETVOLT);
	{
		INT8U j;
		__TBL16 r;
		
		for(j = 0; j < sizeof(__DETVOLT)/2; j++)
		{
			r.Data = *((INT16U *)&Sts->DetVolt + j);
		
			dptr[rlen++] = r.Byte.High;
			dptr[rlen++] = r.Byte.Low;
		}	
	}

	rlen += GenAidData(Aid_DetPwr,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DetPwr), sizeof(Sts->DetPwr));
	rlen += GenAidData(Aid_DetOffset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DetOffset), sizeof(Sts->DetOffset));
	rlen += GenAidData(Aid_AttValue,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AttValue), sizeof(Sts->AttValue));
	rlen += GenAidData(Aid_AttOffset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AttOffset), sizeof(Sts->AttOffset));

	
	rlen += GenAidData(Aid_FwdInPwrOffset_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdInPwrOffset_LTE_A1, 1);
	rlen += GenAidData(Aid_FwdOutPwrOffset_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdOutPwrOffset_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsOutPwrOffset_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsOutPwrOffset_LTE_A1, 1);
	rlen += GenAidData(Aid_FwdAttn1_CDMALTE, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_CDMALTE, 1);
	rlen += GenAidData(Aid_RvsAttn1_CDMALTE, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_CDMALTE, 1);

	rlen += GenAidData(Aid_FwdAttn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE, 1);
	rlen += GenAidData(Aid_FwdAttn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE, 1);
	rlen += GenAidData(Aid_FwdAttn1_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A1, 1);
	rlen += GenAidData(Aid_FwdAttn2_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE_A1, 1);

	rlen += GenAidData(Aid_FwdAttn1_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdAttn2_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE_A2, 1);


	rlen += GenAidData(Aid_RvsAttn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE, 1);
	rlen += GenAidData(Aid_RvsAttn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE, 1);
	rlen += GenAidData(Aid_RvsAttn3_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_LTE, 1);
	rlen += GenAidData(Aid_RvsAttn1_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsAttn2_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsAttn3_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_LTE_A1, 1);

	rlen += GenAidData(Aid_RvsAttn1_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsAttn2_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsAttn3_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_LTE_A2, 1);

	rlen += GenAidData(Aid_FwdAttn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A, 1);
	rlen += GenAidData(Aid_RvsAttn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE_A, 1);

	rlen += GenAidData(Aid_Fwd1Attn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn1_LTE_A, 1);
	rlen += GenAidData(Aid_Rvs1Attn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn1_LTE_A, 1);

	rlen += GenAidData(Aid_FwdGainOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdGainOffset_LTE, 1);
	rlen += GenAidData(Aid_RvsGainOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsGainOffset_LTE, 1);
	rlen += GenAidData(Aid_FwdGainOffset_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdGainOffset_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsGainOffset_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsGainOffset_LTE_A1, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_2G, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_LTE, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_LTE_A1, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_3G, 1);

	rlen += GenAidData(Aid_RvsAlcAttn_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_2G, 1);
	rlen += GenAidData(Aid_RvsAlcAttn_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_LTE, 1);
	rlen += GenAidData(Aid_RvsAlcAttn_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsAlcAttn_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_3G, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_2G, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_LTE, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_3G, 1);
	rlen += GenAidData(Aid_RvsOutPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE), sizeof(Sts->RvsOutPwr_LTE));
	rlen += GenAidData(Aid_RvsOutPwr_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE_A1), sizeof(Sts->RvsOutPwr_LTE_A1));
	rlen += GenAidData(Aid_RvsInPwr_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_2G), sizeof(Sts->RvsInPwr_2G));
	rlen += GenAidData(Aid_RvsInPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE), sizeof(Sts->RvsInPwr_LTE));
	rlen += GenAidData(Aid_RvsInPwr_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE_A1), sizeof(Sts->RvsInPwr_LTE_A1));
	rlen += GenAidData(Aid_RvsInPwr_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_3G), sizeof(Sts->RvsInPwr_3G));
	rlen += GenAidData(Aid_ShutDownOnOff_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE, 1);
	rlen += GenAidData(Aid_ShutDownOnOff_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE), sizeof(Sts->RvsOutUpperLmt_LTE));
	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE_A1,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE_A1), sizeof(Sts->RvsOutUpperLmt_LTE_A1));
	rlen += GenAidData(Aid_FwdTemp_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdTemp_LTE, 1);
	rlen += GenAidData(Aid_RvsTemp_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsTemp_LTE, 1);
	rlen += GenAidData(Aid_FwdTemp_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdTemp_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsTemp_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsTemp_LTE_A1, 1);
	rlen += GenAidData(Aid_FwdOutHighLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE), sizeof(Sts->FwdOutHighLmt_LTE));
	rlen += GenAidData(Aid_FwdOutHighLmt_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE_A1), sizeof(Sts->FwdOutHighLmt_LTE_A1));
	rlen += GenAidData(Aid_OverInAlarmLmt_2G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_2G, 1);
	rlen += GenAidData(Aid_OverInAlarmLmt_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_LTE, 1);
	rlen += GenAidData(Aid_OverInAlarmLmt_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_LTE_A1, 1);
	rlen += GenAidData(Aid_OverInAlarmLmt_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_3G, 1);

	rlen += GenAidData(Aid_RvsALCLvl_2G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_2G, 1);
	rlen += GenAidData(Aid_RvsALCLvl_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_LTE, 1);
	rlen += GenAidData(Aid_RvsALCLvl_LTE_A1, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsALCLvl_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_3G, 1);

///////////////////////
	rlen += GenAidData(Aid_FwdInPwrOffset_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdInPwrOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdOutPwrOffset_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdOutPwrOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsOutPwrOffset_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsOutPwrOffset_LTE_A2, 1);

	rlen += GenAidData(Aid_FwdAttn1_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdAttn2_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdGainOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdGainOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsGainOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsGainOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsAlcAttn_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsOutPwr_LTE_A2, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE_A2), sizeof(Sts->RvsOutPwr_LTE_A2));

	rlen += GenAidData(Aid_RvsInPwr_LTE_A2, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE_A2), sizeof(Sts->RvsInPwr_LTE_A2));
	rlen += GenAidData(Aid_ShutDownOnOff_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE_A2,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE_A2), sizeof(Sts->RvsOutUpperLmt_LTE_A2));
	rlen += GenAidData(Aid_FwdTemp_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdTemp_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsTemp_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsTemp_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdOutHighLmt_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE_A2), sizeof(Sts->FwdOutHighLmt_LTE_A2));
	rlen += GenAidData(Aid_OverInAlarmLmt_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_LTE_A2, 1);

	rlen += GenAidData(Aid_RvsALCLvl_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_LTE_A2, 1);

///////////////Wave
	rlen += GenAidData(Aid_SMS_TxRetry, 			(INT8U *)&dptr[rlen], (INT8U *)&Sts->WaveSts.SMS_TxRetry, 1);
	rlen += GenAidData(Aid_ActChannel,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.ActChannel), sizeof(Sts->WaveSts.ActChannel));
	rlen += GenAidData(Aid_OneFAStatus, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.OneFAStatus), sizeof(Sts->WaveSts.OneFAStatus));

	rlen += GenAidData(Aid_RxMaxVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.RxMaxVal), sizeof(Sts->WaveCtrl.RxMaxVal));
	rlen += GenAidData(Aid_RxMinVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.RxMinVal), sizeof(Sts->WaveCtrl.RxMinVal));
	rlen += GenAidData(Aid_TxMaxVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.TxMaxVal), sizeof(Sts->WaveCtrl.TxMaxVal));
	rlen += GenAidData(Aid_TxMinVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.TxMinVal), sizeof(Sts->WaveCtrl.TxMinVal));
	rlen += GenAidData(Aid_EcIo,					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.EcIo), sizeof(Sts->WaveCtrl.EcIo));
	rlen += GenAidData(Aid_FARxValue,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.FARxVal), sizeof(Sts->WaveSts.FARxVal));
	rlen += GenAidData(Aid_FAFerValue,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.WaveNormalStatus.FAFerVal), sizeof(Sts->WaveSts.WaveNormalStatus.FAFerVal));
	rlen += GenAidData(Aid_PN_Val,					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.PN_Val), sizeof(Sts->WaveSts.PN_Val));
	rlen += GenAidData(Aid_EcIo_Val,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.EcIo_Val), sizeof(Sts->WaveSts.EcIo_Val));


	rlen += GenAidData(Aid_TxVal,					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.TxVal), sizeof(Sts->WaveSts.TxVal));
	rlen += GenAidData(Aid_WcdmaChannel,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveSts.WcdmaChannel), sizeof(Sts->WaveSts.WcdmaChannel));


	rlen += GenAidData(Aid_ARMode, 					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.AR_Mode), sizeof(Sts->WaveCtrl.AR_Mode));
	rlen += GenAidData(Aid_RadioReportTime,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.Radio_ReportTime), sizeof(Sts->WaveCtrl.Radio_ReportTime));
	rlen += GenAidData(Aid_RadioReportPeriod,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.Radio_ReportPeriod), sizeof(Sts->WaveCtrl.Radio_ReportPeriod));
	rlen += GenAidData(Aid_TestStn, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TestStn), sizeof(Sts->TestStn));

	rlen += GenAidData(Aid_SMS_ALARM, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RFAlarm), sizeof(Sts->RFAlarm));

	rlen += GenAidData(Aid_System_Time, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->System_Time), sizeof(Sts->System_Time));
	rlen += GenAidData(Aid_Last_SMS_Time, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Backup_Time), sizeof(Sts->Backup_Time));
	rlen += GenAidData(Aid_Last_AutoReport, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Last_AutoReport), sizeof(Sts->Last_AutoReport));

	rlen += GenAidData16(Aid_Auto_Remain_Time, 		(INT8U *)&dptr[rlen], Sts->Auto_Remain_Time, sizeof(Sts->Auto_Remain_Time));
	rlen += GenAidData16(Aid_AR2_Remain_Time, 		(INT8U *)&dptr[rlen], Sts->AR2_Remain_Time, sizeof(Sts->AR2_Remain_Time));
	rlen += GenAidData16(Aid_AR3_Remain_Time, 		(INT8U *)&dptr[rlen], Sts->AR3_Remain_Time, sizeof(Sts->AR3_Remain_Time));

	if(iRepeaterType == _TRIO_MM)
	{
		rlen += GenAidData(Aid_Fwd1InPwr_LTE, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1InPwr_LTE), sizeof(Sts->Fwd1InPwr_LTE));
		rlen += GenAidData(Aid_Fwd1OutPwr_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutPwr_LTE), sizeof(Sts->Fwd1OutPwr_LTE));
		rlen += GenAidData(Aid_Fwd1OutUpperLmt_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutUpperLmt_LTE), sizeof(Sts->Fwd1OutUpperLmt_LTE));
		rlen += GenAidData(Aid_Fwd1OutLowerLmt_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutLowerLmt_LTE), sizeof(Sts->Fwd1OutLowerLmt_LTE));
		rlen += GenAidData(Aid_Fwd1GainSet_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1GainSet_LTE), 1);
		rlen += GenAidData(Aid_Fwd1GainSts_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1Gain_LTE), 1);

		rlen += GenAidData(Aid_Fwd1InPwr_LTE_A1, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1InPwr_LTE_A1), sizeof(Sts->Fwd1InPwr_LTE_A1));
		rlen += GenAidData(Aid_Fwd1OutPwr_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutPwr_LTE_A1), sizeof(Sts->Fwd1OutPwr_LTE_A1));
		rlen += GenAidData(Aid_Fwd1OutUpperLmt_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutUpperLmt_LTE_A1), sizeof(Sts->Fwd1OutUpperLmt_LTE_A1));
		rlen += GenAidData(Aid_Fwd1OutLowerLmt_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutLowerLmt_LTE_A1), sizeof(Sts->Fwd1OutLowerLmt_LTE_A1));
		rlen += GenAidData(Aid_Fwd1GainSet_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1GainSet_LTE_A1), 1);
		rlen += GenAidData(Aid_Fwd1GainSts_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1Gain_LTE_A1), 1);

		rlen += GenAidData(Aid_Fwd1InPwr_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1InPwr_LTE_A2), sizeof(Sts->Fwd1InPwr_LTE_A2));
		rlen += GenAidData(Aid_Fwd1OutPwr_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutPwr_LTE_A2), sizeof(Sts->Fwd1OutPwr_LTE_A2));
		rlen += GenAidData(Aid_Fwd1OutUpperLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutUpperLmt_LTE_A2), sizeof(Sts->Fwd1OutUpperLmt_LTE_A2));
		rlen += GenAidData(Aid_Fwd1OutLowerLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutLowerLmt_LTE_A2), sizeof(Sts->Fwd1OutLowerLmt_LTE_A2));
		rlen += GenAidData(Aid_Fwd1GainSet_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1GainSet_LTE_A2), 1);
		rlen += GenAidData(Aid_Fwd1Gain_LTE_A2, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1Gain_LTE_A2), 1);

		rlen += GenAidData(Aid_Rvs1GainSet_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSet_LTE), 1);
		rlen += GenAidData(Aid_Rvs1GainSts_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSts_LTE), 1);
		rlen += GenAidData(Aid_Rvs1GainBalance_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainBalance_LTE), 1);
		rlen += GenAidData(Aid_Rvs1GainSet_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSet_LTE_A1), 1);
		rlen += GenAidData(Aid_Rvs1GainSts_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSts_LTE_A1), 1);
		rlen += GenAidData(Aid_Rvs1GainBalance_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainBalance_LTE_A1), 1);
		rlen += GenAidData(Aid_Rvs1GainSet_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSet_LTE_A2), 1);
		rlen += GenAidData(Aid_Rvs1GainSts_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSts_LTE_A2), 1);
		rlen += GenAidData(Aid_Rvs1GainBalance_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainBalance_LTE_A2), 1);

		rlen += GenAidData(Aid_Amp1OffCase_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Amp1OffCase_LTE), 1);
		rlen += GenAidData(Aid_Amp1OffCase_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Amp1OffCase_LTE_A1), 1);
		rlen += GenAidData(Aid_Amp1OffCase_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Amp1OffCase_LTE_A2), 1);

		rlen += GenAidData(Aid_AGC1OnOff_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGC1OnOff_LTE), 1);
		rlen += GenAidData(Aid_AGCOnOff_LTE_A_1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_LTE_A_1), 1);
	////////////////////////////////////////////
		// Adc_Value
		dptr[rlen++] = (Aid_Det1Volt >> 8) & 0xff;
		dptr[rlen++] = (Aid_Det1Volt >> 0) & 0xff;
		dptr[rlen++] = sizeof(__DET1VOLT);
		{
			INT8U j;
			__TBL16 r;
			
			for(j = 0; j < sizeof(__DET1VOLT)/2; j++)
			{
				r.Data = *((INT16U *)&Sts->Det1Volt + j);
			
				dptr[rlen++] = r.Byte.High;
				dptr[rlen++] = r.Byte.Low;
			}	
		}

		rlen += GenAidData(Aid_Det1Pwr, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Det1Pwr), sizeof(Sts->Det1Pwr));
		rlen += GenAidData(Aid_Det1Offset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Det1Offset), sizeof(Sts->Det1Offset));
		rlen += GenAidData(Aid_Att1Value,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Att1Value), sizeof(Sts->Att1Value));
		rlen += GenAidData(Aid_Att1Offset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Att1Offset), sizeof(Sts->Att1Offset));		

		rlen += GenAidData(Aid_Fwd1InPwrOffset_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1InPwrOffset_LTE, 1);
		rlen += GenAidData(Aid_Fwd1OutPwrOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1OutPwrOffset_LTE, 1);
		rlen += GenAidData(Aid_Rvs1OutPwrOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1OutPwrOffset_LTE, 1);
		rlen += GenAidData(Aid_Fwd1InPwrOffset_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1InPwrOffset_LTE_A1, 1);
		rlen += GenAidData(Aid_Fwd1OutPwrOffset_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1OutPwrOffset_LTE_A1, 1);
		rlen += GenAidData(Aid_Rvs1OutPwrOffset_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1OutPwrOffset_LTE_A1, 1);
		rlen += GenAidData(Aid_Fwd1Attn1_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn1_LTE, 1);
		rlen += GenAidData(Aid_Fwd1Attn2_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn2_LTE, 1);
		rlen += GenAidData(Aid_Fwd1Attn1_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn1_LTE_A1, 1);
		rlen += GenAidData(Aid_Fwd1Attn2_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn2_LTE_A1, 1);
		rlen += GenAidData(Aid_Rvs1Attn1_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn1_LTE, 1);
		rlen += GenAidData(Aid_Rvs1Attn2_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn2_LTE, 1);
		rlen += GenAidData(Aid_Rvs1Attn3_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn3_LTE, 1);
		rlen += GenAidData(Aid_Rvs1Attn4_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn4_LTE, 1);
		rlen += GenAidData(Aid_Rvs1Attn1_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn1_LTE_A1, 1);
		rlen += GenAidData(Aid_Rvs1Attn2_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn2_LTE_A1, 1);
		rlen += GenAidData(Aid_Rvs1Attn3_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn3_LTE_A1, 1);
		rlen += GenAidData(Aid_Fwd1GainOffset_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1GainOffset_LTE, 1);
		rlen += GenAidData(Aid_Rvs1GainOffset_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1GainOffset_LTE, 1);
		rlen += GenAidData(Aid_Fwd1GainOffset_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1GainOffset_LTE_A1, 1);
		rlen += GenAidData(Aid_Rvs1GainOffset_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1GainOffset_LTE_A1, 1);

		rlen += GenAidData(Aid_Fwd1AgcAttn_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE, 1);
		rlen += GenAidData(Aid_Fwd1AgcAttn_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE_A1, 1);
		rlen += GenAidData(Aid_Rvs1AlcOnOff_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1AlcOnOff_LTE, 1);
		rlen += GenAidData(Aid_Rvs1AlcOnOff_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1AlcOnOff_LTE_A1, 1);
		rlen += GenAidData(Aid_Rvs1OutPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutPwr_LTE), sizeof(Sts->Rvs1OutPwr_LTE));
		rlen += GenAidData(Aid_Rvs1OutPwr_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutPwr_LTE_A1), sizeof(Sts->Rvs1OutPwr_LTE_A1));
		rlen += GenAidData(Aid_Rvs1InPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1InPwr_LTE), sizeof(Sts->Rvs1InPwr_LTE));
		rlen += GenAidData(Aid_Rvs1InPwr_LTE_A1, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1InPwr_LTE_A1), sizeof(Sts->Rvs1InPwr_LTE_A1));
		rlen += GenAidData(Aid_ShutDownOnOff1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE1, 1);
		rlen += GenAidData(Aid_ShutDownOnOff1_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE_A1_1, 1);
		rlen += GenAidData(Aid_Rvs1OutUpperLmt_LTE, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutUpperLmt_LTE), sizeof(Sts->Rvs1OutUpperLmt_LTE));
		rlen += GenAidData(Aid_Rvs1OutUpperLmt_LTE_A1,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutUpperLmt_LTE_A1), sizeof(Sts->Rvs1OutUpperLmt_LTE_A1));
		rlen += GenAidData(Aid_Fwd1Temp_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Temp_LTE, 1);
		rlen += GenAidData(Aid_Rvs1Temp_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Temp_LTE, 1);
//		rlen += GenAidData(Aid_Fwd1Temp_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Temp_LTE_A1, 1);
//		rlen += GenAidData(Aid_Rvs1Temp_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Temp_LTE_A1, 1);
		rlen += GenAidData(Aid_Fwd1OutHighLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutHighLmt_LTE), sizeof(Sts->Fwd1OutHighLmt_LTE));
		rlen += GenAidData(Aid_Fwd1OutHighLmt_LTE_A1, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutHighLmt_LTE_A1), sizeof(Sts->Fwd1OutHighLmt_LTE_A1));
		rlen += GenAidData(Aid_Rvs1ALCLvl_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1ALCLvl_LTE, 1);
		rlen += GenAidData(Aid_Rvs1ALCLvl_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1ALCLvl_LTE_A1, 1);



		rlen += GenAidData(Aid_Fwd1InPwrOffset_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1InPwrOffset_LTE_A2, 1);
		rlen += GenAidData(Aid_Fwd1OutPwrOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1OutPwrOffset_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1OutPwrOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1OutPwrOffset_LTE_A2, 1);
		rlen += GenAidData(Aid_Fwd1Attn1_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn1_LTE_A2, 1);
		rlen += GenAidData(Aid_Fwd1Attn2_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn2_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1Attn1_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn1_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1Attn2_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn2_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1Attn3_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn3_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1Attn4_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn4_LTE_A2, 1);
		rlen += GenAidData(Aid_Fwd1GainOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1GainOffset_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1GainOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1GainOffset_LTE_A2, 1);
		
		rlen += GenAidData(Aid_Fwd1AgcAttn_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE_A2, 1);
		rlen += GenAidData(Aid_Fwd1AgcAttn_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1AlcOnOff_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1AlcOnOff_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1OutPwr_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutPwr_LTE_A2), sizeof(Sts->Rvs1OutPwr_LTE_A2));
		rlen += GenAidData(Aid_Rvs1InPwr_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1InPwr_LTE_A2), sizeof(Sts->Rvs1InPwr_LTE_A2));
		rlen += GenAidData(Aid_ShutDownOnOff_LTE_A2_1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE_A2_1, 1);
		rlen += GenAidData(Aid_Rvs1OutUpperLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutUpperLmt_LTE_A2), sizeof(Sts->Rvs1OutUpperLmt_LTE_A2));
		rlen += GenAidData(Aid_Fwd1Temp_LTE_A2, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Temp_LTE_A2, 1);
		rlen += GenAidData(Aid_Rvs1Temp_LTE_A2, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Temp_LTE_A2, 1);
		
		rlen += GenAidData(Aid_Fwd1OutHighLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutHighLmt_LTE_A2), sizeof(Sts->Fwd1OutHighLmt_LTE_A2));
		rlen += GenAidData(Aid_Rvs1ALCLvl_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1ALCLvl_LTE_A2, 1);

		rlen += GenAidData(Aid_AutoShutDownSts_LTE1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE_1), sizeof(Sts->SD_Status_LTE_1));
		rlen += GenAidData(Aid_AutoShutDownSts_LTE_A1_1,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE_A1_1), sizeof(Sts->SD_Status_LTE_A1_1));
		rlen += GenAidData(Aid_AutoShutDownSts_LTE_A2_1,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE_A2_1), sizeof(Sts->SD_Status_LTE_A2_1));



		rlen += GenAidData(Aid_Rvs1AlcAttn_LTE,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1AlcAttn_LTE), sizeof(Sts->Rvs1AlcAttn_LTE));
		rlen += GenAidData(Aid_Rvs1AlcAttn_LTE_A1,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1AlcAttn_LTE_A1), sizeof(Sts->Rvs1AlcAttn_LTE_A1));
		rlen += GenAidData(Aid_Rvs1AlcAttn_LTE_A2,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1AlcAttn_LTE_A2), sizeof(Sts->Rvs1AlcAttn_LTE_A2));

	}

	rlen += GenAidData(Aid_AutoShutDownSts_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_2G), sizeof(Sts->SD_Status_2G));
	rlen += GenAidData(Aid_AutoShutDownSts_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_3G), sizeof(Sts->SD_Status_3G));
	rlen += GenAidData(Aid_AutoShutDownSts_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE), sizeof(Sts->SD_Status_LTE));
	rlen += GenAidData(Aid_AutoShutDownSts_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE_A1), sizeof(Sts->SD_Status_LTE_A1));
	rlen += GenAidData(Aid_AutoShutDownSts_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE_A2), sizeof(Sts->SD_Status_LTE_A2));


	rlen += GenAidData(Aid_ShunDownTime,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ShunDownTime), sizeof(Sts->ShunDownTime));
	rlen += GenAidData(Aid_ESNCheck,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->EsnNumber), sizeof(Sts->EsnNumber));
	rlen += GenAidData(Aid_OverInputAGCOnOff,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->OverInputAGCOnOff), sizeof(Sts->OverInputAGCOnOff));
	rlen += GenAidData(Aid_RB_StsOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RB_StsOnOff), sizeof(Sts->RB_StsOnOff));
	rlen += GenAidData16(Aid_DCOffSet,			(INT8U *)&dptr[rlen], Sts->DCOffSet, sizeof(Sts->DCOffSet));
	rlen += GenAidData(Aid_PllFregOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->PllFregOffset_LTE), sizeof(Sts->PllFregOffset_LTE));

#ifdef __RvsCount
	rlen += GenAidData(Aid_CurrRvsOSCAlarmCount_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvsOSCAlarmCount_3G), sizeof(Sts->CurrRvsOSCAlarmCount_3G));
	rlen += GenAidData(Aid_CurrRvsOSCAlarmCount_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvsOSCAlarmCount_2G), sizeof(Sts->CurrRvsOSCAlarmCount_2G));
	rlen += GenAidData(Aid_CurrRvsOSCAlarmCount_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvsOSCAlarmCount_LTE), sizeof(Sts->CurrRvsOSCAlarmCount_LTE));
//	rlen += GenAidData(Aid_CurrRvsOSCAlarmCount_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvsOSCAlarmCount_LTE_A1), sizeof(Sts->CurrRvsOSCAlarmCount_LTE_A1));
	rlen += GenAidData(Aid_CurrRvsOSCAlarmCount_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvsOSCAlarmCount_LTE_A2), sizeof(Sts->CurrRvsOSCAlarmCount_LTE_A2));
	rlen += GenAidData(Aid_CurrRvs1OSCAlarmCount_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvs1OSCAlarmCount_LTE), sizeof(Sts->CurrRvs1OSCAlarmCount_LTE));
//	rlen += GenAidData(Aid_CurrRvs1OSCAlarmCount_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvs1OSCAlarmCount_LTE_A1), sizeof(Sts->CurrRvs1OSCAlarmCount_LTE_A1));
	rlen += GenAidData(Aid_CurrRvs1OSCAlarmCount_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrRvs1OSCAlarmCount_LTE_A2), sizeof(Sts->CurrRvs1OSCAlarmCount_LTE_A2));



	rlen += GenAidData(Aid_RvsOSCAlarmCount_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOSCAlarmCount_3G), sizeof(Sts->RvsOSCAlarmCount_3G));
	rlen += GenAidData(Aid_RvsOSCAlarmCount_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOSCAlarmCount_2G), sizeof(Sts->RvsOSCAlarmCount_2G));
	rlen += GenAidData(Aid_RvsOSCAlarmCount_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOSCAlarmCount_LTE), sizeof(Sts->RvsOSCAlarmCount_LTE));
//	rlen += GenAidData(Aid_RvsOSCAlarmCount_LTE_A1,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOSCAlarmCount_LTE_A1), sizeof(Sts->RvsOSCAlarmCount_LTE_A1));
	rlen += GenAidData(Aid_RvsOSCAlarmCount_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOSCAlarmCount_LTE_A2), sizeof(Sts->RvsOSCAlarmCount_LTE_A2));
	rlen += GenAidData(Aid_Rvs1OSCAlarmCount_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OSCAlarmCount_LTE), sizeof(Sts->Rvs1OSCAlarmCount_LTE));
//	rlen += GenAidData(Aid_Rvs1OSCAlarmCount_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OSCAlarmCount_LTE_A1), sizeof(Sts->Rvs1OSCAlarmCount_LTE_A1));
	rlen += GenAidData(Aid_Rvs1OSCAlarmCount_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OSCAlarmCount_LTE_A2), sizeof(Sts->Rvs1OSCAlarmCount_LTE_A2));
#endif


/////////////////////////20130319
#if 0    
	// VccDet_Lmt
	dptr[rlen++] = (Aid_SleepMode_2G >> 8) & 0xff;
	dptr[rlen++] = (Aid_SleepMode_2G >> 0) & 0xff;
	dptr[rlen++] = 5;
	dptr[rlen++] = Sts->SleepMode_2G.SleepMode_OnOff;
	dptr[rlen++] = (Sts->SleepMode_2G.SleepModeOnVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_2G.SleepModeOnVolt.Byte.Low);
	dptr[rlen++] = (Sts->SleepMode_2G.SleepModeOffVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_2G.SleepModeOffVolt.Byte.Low);


	dptr[rlen++] = (Aid_SleepMode_LTE >> 8) & 0xff;
	dptr[rlen++] = (Aid_SleepMode_LTE >> 0) & 0xff;
	dptr[rlen++] = 5;
	dptr[rlen++] = Sts->SleepMode_LTE.SleepMode_OnOff;
	dptr[rlen++] = (Sts->SleepMode_LTE.SleepModeOnVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_LTE.SleepModeOnVolt.Byte.Low);
	dptr[rlen++] = (Sts->SleepMode_LTE.SleepModeOffVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_LTE.SleepModeOffVolt.Byte.Low);



	dptr[rlen++] = (Aid_SleepMode_LTE_A1 >> 8) & 0xff;
	dptr[rlen++] = (Aid_SleepMode_LTE_A1 >> 0) & 0xff;
	dptr[rlen++] = 5;
	dptr[rlen++] = Sts->SleepMode_LTE_A1.SleepMode_OnOff;
	dptr[rlen++] = (Sts->SleepMode_LTE_A1.SleepModeOnVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_LTE_A1.SleepModeOnVolt.Byte.Low);
	dptr[rlen++] = (Sts->SleepMode_LTE_A1.SleepModeOffVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_LTE_A1.SleepModeOffVolt.Byte.Low);

	dptr[rlen++] = (Aid_SleepMode_LTE_A2 >> 8) & 0xff;
	dptr[rlen++] = (Aid_SleepMode_LTE_A2 >> 0) & 0xff;
	dptr[rlen++] = 5;
	dptr[rlen++] = Sts->SleepMode_LTE_A2.SleepMode_OnOff;
	dptr[rlen++] = (Sts->SleepMode_LTE_A2.SleepModeOnVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_LTE_A2.SleepModeOnVolt.Byte.Low);
	dptr[rlen++] = (Sts->SleepMode_LTE_A2.SleepModeOffVolt.Byte.High);
	dptr[rlen++] = (Sts->SleepMode_LTE_A2.SleepModeOffVolt.Byte.Low);
#endif
#if 0

	Sts->SleepMode_2G.SleepMode_OnOff			= tptr->BackUp.SleepMode_2G.SleepMode_OnOff;
	Sts->SleepMode_2G.SleepModeOnVolt.Data		= tptr->BackUp.SleepMode_2G.SleepModeOnVolt.Data;
	Sts->SleepMode_2G.SleepModeOffVolt.Data 	= tptr->BackUp.SleepMode_2G.SleepModeOffVolt.Data;
	
	Sts->SleepMode_LTE.SleepMode_OnOff			= tptr->BackUp.SleepMode_LTE.SleepMode_OnOff;
	Sts->SleepMode_LTE.SleepModeOnVolt.Data 	= tptr->BackUp.SleepMode_LTE.SleepModeOnVolt.Data;
	Sts->SleepMode_LTE.SleepModeOffVolt.Data	= tptr->BackUp.SleepMode_LTE.SleepModeOffVolt.Data;
	
	Sts->SleepMode_LTE_A1.SleepMode_OnOff		= tptr->BackUp.SleepMode_LTE_A1.SleepMode_OnOff;
	Sts->SleepMode_LTE_A1.SleepModeOnVolt.Data	= tptr->BackUp.SleepMode_LTE_A1.SleepModeOnVolt.Data;
	Sts->SleepMode_LTE_A1.SleepModeOffVolt.Data = tptr->BackUp.SleepMode_LTE_A1.SleepModeOffVolt.Data;
	
	Sts->SleepMode_LTE_A2.SleepMode_OnOff		= tptr->BackUp.SleepMode_LTE_A2.SleepMode_OnOff;
	Sts->SleepMode_LTE_A2.SleepModeOnVolt.Data	= tptr->BackUp.SleepMode_LTE_A2.SleepModeOnVolt.Data;
	Sts->SleepMode_LTE_A2.SleepModeOffVolt.Data = tptr->BackUp.SleepMode_LTE_A2.SleepModeOffVolt.Data;
#endif	
	


	return rlen;
}

INT8U SetCtrlData(INT16U AID_Command, INT8U *AID_Value, INT8U Length,INT8U Ctrl, __ProtocolPtr *nPtr, EE_BACK1 *tptr)
{
	INT8U rval = FALSE;
	__Dnr_Sts *Sts = tDnrSts;

	INT8U i;
	
	switch(AID_Command)
	{

		case Aid_EsnChecksum:
		case Aid_ICCIDChecksum:
			Sts->ICCIDChecksum[0] = AID_Value[0];
			Sts->ICCIDChecksum[1] = AID_Value[1];

			if( (EsnChecksumH !=AID_Value[0]) ||(EsnChecksumL != AID_Value[1]))
			{
				iMobileESN = NACK;
				break;
			}
			iMobileESN = ACK;
		break;

		case Aid_FwdOutUpperLmt_3G:
			Sts->FwdOutUpperLmt_3G[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_3G[1] = AID_Value[1];

			tptr->BackUp.FwdOutUpperLmt_3G[0] = Sts->FwdOutUpperLmt_3G[0];
			tptr->BackUp.FwdOutUpperLmt_3G[1] = Sts->FwdOutUpperLmt_3G[1];
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutLowerLmt_3G:
			Sts->FwdOutLowerLmt_3G[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_3G[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_3G[0] = Sts->FwdOutLowerLmt_3G[0];
			tptr->BackUp.FwdOutLowerLmt_3G[1] = Sts->FwdOutLowerLmt_3G[1];
			if(Ctrl)rval = TRUE;
		break;


		case Aid_FwdGainSet_3G:
			Sts->FwdGainSet_3G = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_3G = Sts->FwdGainSet_3G*2;

			Sts->FwdGainSet_3G = MinMaxAttnCheck(Sts->FwdGainSet_3G, Gain_3G, FwdMinGain_3G);
			Sts->FwdAgcAttn_3G = GainAttnCalculation(Sts->FwdGainSet_3G, Gain_3G, FwdMinGain_3G);
			ChkAttChange = RESET;

			tptr->BackUp.FwdGainSet_3G = Sts->FwdGainSet_3G;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutUpperLmt_2G:
			Sts->FwdOutUpperLmt_2G[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_2G[1] = AID_Value[1];
			tptr->BackUp.FwdOutUpperLmt_2G[0] = Sts->FwdOutUpperLmt_2G[0];
			tptr->BackUp.FwdOutUpperLmt_2G[1] = Sts->FwdOutUpperLmt_2G[1];
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutLowerLmt_2G:
			Sts->FwdOutLowerLmt_2G[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_2G[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_2G[0] = Sts->FwdOutLowerLmt_2G[0];
			tptr->BackUp.FwdOutLowerLmt_2G[1] = Sts->FwdOutLowerLmt_2G[1];
			
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_FwdGainSet_2G:
			Sts->FwdGainSet_2G = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_2G = Sts->FwdGainSet_2G*2;
			Sts->FwdGainSet_2G = MinMaxAttnCheck(Sts->FwdGainSet_2G, Gain_2G, FwdMinGain_2G);
			Sts->FwdAgcAttn_2G = GainAttnCalculation(Sts->FwdGainSet_2G,Gain_2G,ATTENMIN);
			tptr->BackUp.FwdGainSet_2G = Sts->FwdGainSet_2G;

			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;	
		break;


		case Aid_FwdOutUpperLmt_LTE:
			Sts->FwdOutUpperLmt_LTE[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_LTE[1] = AID_Value[1];     
			tptr->BackUp.FwdOutUpperLmt_LTE[0] = Sts->FwdOutUpperLmt_LTE[0];
			tptr->BackUp.FwdOutUpperLmt_LTE[1] = Sts->FwdOutUpperLmt_LTE[1];
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutLowerLmt_LTE:
			Sts->FwdOutLowerLmt_LTE[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_LTE[1] = AID_Value[1];    

			tptr->BackUp.FwdOutLowerLmt_LTE[0] = Sts->FwdOutLowerLmt_LTE[0];
			tptr->BackUp.FwdOutLowerLmt_LTE[1] = Sts->FwdOutLowerLmt_LTE[1];
			
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_FwdGainSet_LTE:
			Sts->FwdGainSet_LTE = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_LTE = Sts->FwdGainSet_LTE*2;
			
			Sts->FwdGainSet_LTE = MinMaxAttnCheck(Sts->FwdGainSet_LTE, Gain_LTE, FwdMinGain_LTE);
			Sts->FwdAgcAttn_LTE = GainAttnCalculation(Sts->FwdGainSet_LTE,Gain_LTE,ATTENMIN);
			ChkAttChange = RESET;
			
			tptr->BackUp.FwdGainSet_LTE = Sts->FwdGainSet_LTE;
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_FwdOutUpperLmt_LTE_A1:
			Sts->FwdOutUpperLmt_LTE_A1[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_LTE_A1[1] = AID_Value[1];

			tptr->BackUp.FwdOutUpperLmt_LTE_A1[0] = Sts->FwdOutUpperLmt_LTE_A1[0];
			tptr->BackUp.FwdOutUpperLmt_LTE_A1[1] = Sts->FwdOutUpperLmt_LTE_A1[1];
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutLowerLmt_LTE_A1:
			Sts->FwdOutLowerLmt_LTE_A1[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_LTE_A1[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_LTE_A1[0] = Sts->FwdOutLowerLmt_LTE_A1[0];
			tptr->BackUp.FwdOutLowerLmt_LTE_A1[1] = Sts->FwdOutLowerLmt_LTE_A1[1];			
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_FwdGainSet_LTE_A1:
			Sts->FwdGainSet_LTE_A1 = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_LTE_A1 = Sts->FwdGainSet_LTE_A1*2;
			Sts->FwdGainSet_LTE_A1 = MinMaxAttnCheck(Sts->FwdGainSet_LTE_A1, Gain_LTE_A, FwdMinGain_LTE_A);
			Sts->FwdAgcAttn_LTE_A1 = GainAttnCalculation(Sts->FwdGainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
			
			tptr->BackUp.FwdGainSet_LTE_A1 = Sts->FwdGainSet_LTE_A1;
			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutUpperLmt_LTE_A2:
			Sts->FwdOutUpperLmt_LTE_A2[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_LTE_A2[1] = AID_Value[1];
			tptr->BackUp.FwdOutUpperLmt_LTE_A2[0] = Sts->FwdOutUpperLmt_LTE_A2[0];
			tptr->BackUp.FwdOutUpperLmt_LTE_A2[1] = Sts->FwdOutUpperLmt_LTE_A2[1];			
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutLowerLmt_LTE_A2:
			Sts->FwdOutLowerLmt_LTE_A2[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_LTE_A2[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_LTE_A2[0] = Sts->FwdOutLowerLmt_LTE_A2[0];
			tptr->BackUp.FwdOutLowerLmt_LTE_A2[1] = Sts->FwdOutLowerLmt_LTE_A2[1];				
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_FwdGainSet_LTE_A2:
			Sts->FwdGainSet_LTE_A2 = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_LTE_A2 = Sts->FwdGainSet_LTE_A2*2;
			Sts->FwdGainSet_LTE_A2 = MinMaxAttnCheck(Sts->FwdGainSet_LTE_A2, Gain_LTE_A, FwdMinGain_LTE_A);
			Sts->FwdAgcAttn_LTE_A2 = GainAttnCalculation(Sts->FwdGainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
			tptr->BackUp.FwdGainSet_LTE_A2 = Sts->FwdGainSet_LTE_A2;

			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;
		break;


		case Aid_RvsGainSet_3G:
			Sts->Rvs0GainSet_3G = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_3G = Sts->Rvs0GainSet_3G*2;
			
			Sts->Rvs0GainSet_3G = MinMaxAttnCheck(Sts->Rvs0GainSet_3G, Gain_3G, RvsMinGain_3G);
			Sts->RvsGainAttn_3G = GainAttnCalculation(Sts->Rvs0GainSet_3G,Gain_3G,ATTENMIN);
			
			tptr->BackUp.Rvs0GainSet_3G = Sts->Rvs0GainSet_3G;
			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsGainBalance_3G:
			Sts->RvsGainBalance_3G = AID_Value[0];
			
			tptr->BackUp.RvsGainBalance_3G = Sts->RvsGainBalance_3G;
			if(Ctrl)rval = TRUE;
		break;


		case Aid_RvsGainSet_2G:
			Sts->Rvs0GainSet_2G = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_2G = Sts->Rvs0GainSet_2G*2;
			
			Sts->Rvs0GainSet_2G = MinMaxAttnCheck(Sts->Rvs0GainSet_2G, Gain_2G, RvsMinGain_2G);
			Sts->RvsGainAttn_2G = GainAttnCalculation(Sts->Rvs0GainSet_2G,Gain_2G,ATTENMIN);

			tptr->BackUp.Rvs0GainSet_2G = Sts->Rvs0GainSet_2G;

			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsGainBalance_2G:
			Sts->RvsGainBalance_2G = AID_Value[0];
			
			tptr->BackUp.RvsGainBalance_2G = Sts->RvsGainBalance_2G;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsGainSet_LTE:
			Sts->Rvs0GainSet_LTE = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_LTE = Sts->Rvs0GainSet_LTE*2;
			
			Sts->RvsGainAttn_LTE = MinMaxAttnCheck(Sts->RvsGainAttn_LTE, Gain_LTE, RvsMinGain_LTE);
			Sts->RvsGainAttn_LTE = GainAttnCalculation(Sts->Rvs0GainSet_LTE,Gain_LTE,ATTENMIN);
			ChkAttChange = RESET;
			
			tptr->BackUp.Rvs0GainSet_LTE = Sts->Rvs0GainSet_LTE;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsGainBalance_LTE:
			Sts->RvsGainBalance_LTE = AID_Value[0];
			
			tptr->BackUp.RvsGainBalance_LTE = Sts->RvsGainBalance_LTE;
			if(Ctrl)rval = TRUE;
		break;		

		case Aid_RvsGainSet_LTE_A1:
			Sts->Rvs0GainSet_LTE_A1 = AID_Value[0];
			
			if(nPtr== SmsSer)Sts->Rvs0GainSet_LTE_A1 = Sts->Rvs0GainSet_LTE_A1*2;
			Sts->Rvs0GainSet_LTE_A1 = MinMaxAttnCheck(Sts->Rvs0GainSet_LTE_A1, Gain_LTE_A, RvsMinGain_LTE_A);
			Sts->RvsGainAttn_LTE_A1 = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
			
			tptr->BackUp.Rvs0GainSet_LTE_A1 = Sts->Rvs0GainSet_LTE_A1;
			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsGainBalance_LTE_A1:
			Sts->RvsGainBalance_LTE_A1 = AID_Value[0];
			
			tptr->BackUp.RvsGainBalance_LTE_A1 = Sts->RvsGainBalance_LTE_A1;
			if(Ctrl)rval = TRUE;
		break;			

		case Aid_RvsGainSet_LTE_A2:
			Sts->Rvs0GainSet_LTE_A2 = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_LTE_A2 = Sts->Rvs0GainSet_LTE_A2*2;
			
			Sts->Rvs0GainSet_LTE_A2 = MinMaxAttnCheck(Sts->Rvs0GainSet_LTE_A2, Gain_LTE_A, RvsMinGain_LTE_A);
			Sts->RvsGainAttn_LTE_A2 = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
			
			ChkAttChange = RESET;
			
			tptr->BackUp.Rvs0GainSet_LTE_A2 = Sts->Rvs0GainSet_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsGainBalance_LTE_A2:
			Sts->RvsGainBalance_LTE_A2 = AID_Value[0];
			
			tptr->BackUp.RvsGainBalance_LTE_A2 = Sts->RvsGainBalance_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_FwdAmpOnOff_2G:
			Sts->FwdAmpOnOff_2G = AID_Value[0];
			Sts->AmpOffCase_2G = __UsrCtrl;
			RefFwdAmpOnOff_2G = Sts->FwdAmpOnOff_2G;

			tptr->BackUp.FwdAmpOnOff_2G = Sts->FwdAmpOnOff_2G;

			if(Ctrl)rval = TRUE;

			Sd_Step[SD_FI_2G] = 0;
			Sd_Step[SD_FO_2G] = 0;
			Sd_Step[SD_RO_2G] = 0;
			Sd_Cnt[SD_FI_2G] = 0;
			Sd_Cnt[SD_FO_2G] = 0;
			Sd_Cnt[SD_RO_2G] = 0;
			Sd_Path[PATH_2G] = 0;
			PwrAlarmChange.RvsOutUpperLmtFail_2G = RESET;
			PwrAlarmChange.FwdOutUpperLmtFail_2G = RESET;
			PwrAlarmChange.FwdInUpperLmtFail_2G = RESET;
			PwrAlarmChange.FwdInUpperLmtFail_2G = RESET;

			if(Sts->FwdAmpOnOff_2G == Enable)
			{
				Sts->AlmSts.FwdAmpOnOff_2G = Enable;
				
				Sts->SD_Status_2G = SD_AMP_ON;
				Amp_Step[PATH_2G] = 10;


			}
			else
			{
				Sts->AlmSts.FwdAmpOnOff_2G = Disable;
			}			
		break;	

		case Aid_FwdAmpOnOff_LTE:
			Sts->FwdAmpOnOff_LTE = AID_Value[0];
			Sts->AmpOffCase_LTE = __UsrCtrl;
			RefFwdAmpOnOff_LTE = Sts->FwdAmpOnOff_LTE;
			tptr->BackUp.FwdAmpOnOff_LTE = Sts->FwdAmpOnOff_LTE;

			if(Ctrl)rval = TRUE;

			Sd_Step[SD_FI_LTE] = 0;
			Sd_Step[SD_FO_LTE] = 0;
			Sd_Step[SD_RO_LTE] = 0;
			Sd_Cnt[SD_FI_LTE] = 0;
			Sd_Cnt[SD_FO_LTE] = 0;
			Sd_Cnt[SD_RO_LTE] = 0;
			Sd_Path[PATH_LTE] = 0;			
			
			PwrAlarmChange.RvsOutUpperLmtFail_LTE = RESET;
			PwrAlarmChange.FwdOutUpperLmtFail_LTE = RESET;
			PwrAlarmChange.FwdInUpperLmtFail_LTE = RESET;	
			PwrAlarmChange.FwdAmpOnOff_LTE = RESET;	

			if(Sts->FwdAmpOnOff_LTE == Enable)
			{
				Sts->AlmSts.FwdAmpOnOff_LTE = Enable;

				Sts->SD_Status_LTE = SD_AMP_ON;

				Amp_Step[PATH_LTE] = 10;
			}
			else
			{
				Sts->AlmSts.FwdAmpOnOff_LTE = Disable;
			}	
		break;	


		case Aid_FwdAmpOnOff_3G:
			Sts->FwdAmpOnOff_3G = AID_Value[0];
			Sts->AmpOffCase_3G = __UsrCtrl;
			RefFwdAmpOnOff_3G = Sts->FwdAmpOnOff_3G;
			tptr->BackUp.FwdAmpOnOff_3G = Sts->FwdAmpOnOff_3G;

			if(Ctrl)rval = TRUE;

			Sd_Step[SD_FI_3G] = 0;
			Sd_Step[SD_FO_3G] = 0;
			Sd_Step[SD_RO_3G] = 0;
			Sd_Cnt[SD_FI_3G] = 0;
			Sd_Cnt[SD_FO_3G] = 0;
			Sd_Cnt[SD_RO_3G] = 0;
			Sd_Path[PATH_3G] = 0;

			if(Sts->FwdAmpOnOff_3G == Enable)
			{
				Sts->AlmSts.FwdAmpOnOff_3G = Enable;

				Sts->SD_Status_3G = SD_AMP_ON;

				Amp_Step[PATH_3G] = 10;				
			}
			else
			{
				Sts->AlmSts.FwdAmpOnOff_3G = Disable;
			}
		break;	

		case Aid_FwdAmpOnOff_LTE_A1:
			Sts->FwdAmpOnOff_LTE_A1 = AID_Value[0];
			Sts->AmpOffCase_LTE_A1 = __UsrCtrl;
			RefFwdAmpOnOff_LTE_A1 = Sts->FwdAmpOnOff_LTE_A1;
			tptr->BackUp.FwdAmpOnOff_LTE_A1 = Sts->FwdAmpOnOff_LTE_A1;

			if(Ctrl)rval = TRUE;


			Sd_Step[SD_FI_LTE_A1] = 0;
			Sd_Step[SD_FO_LTE_A1] = 0;
			Sd_Step[SD_RO_LTE_A1] = 0;
			Sd_Cnt[SD_FI_LTE_A1] = 0;
			Sd_Cnt[SD_FO_LTE_A1] = 0;
			Sd_Cnt[SD_RO_LTE_A1] = 0;
			Sd_Path[PATH_LTE_A1] = 0;
			PwrAlarmChange.RvsOutUpperLmtFail_LTE_A1 = RESET;
			PwrAlarmChange.FwdOutUpperLmtFail_LTE_A1 = RESET;
			PwrAlarmChange.FwdInUpperLmtFail_LTE_A1= RESET; 
			PwrAlarmChange.FwdAmpOnOff_LTE_A1 = RESET;	

			if(Sts->FwdAmpOnOff_LTE_A1 == Enable)
			{
				Sts->AlmSts.FwdAmpOnOff_LTE_A1 = Enable;
				Sts->SD_Status_LTE_A1 = SD_AMP_ON;

				Amp_Step[PATH_LTE_A1] = 10;
			}
			else
			{
				Sts->AlmSts.FwdAmpOnOff_LTE_A1 = Disable;
			}
			
		break;	


		case Aid_FwdAmpOnOff_LTE_A2:
			Sts->FwdAmpOnOff_LTE_A2 = AID_Value[0];
			Sts->AmpOffCase_LTE_A2 = __UsrCtrl;
			RefFwdAmpOnOff_LTE_A2 = Sts->FwdAmpOnOff_LTE_A2;
			tptr->BackUp.FwdAmpOnOff_LTE_A2 = Sts->FwdAmpOnOff_LTE_A2;

			if(Ctrl)rval = TRUE;

			Sd_Step[SD_FI_LTE_A2] = 0;
			Sd_Step[SD_FO_LTE_A2] = 0;
			Sd_Step[SD_RO_LTE_A2] = 0;
			Sd_Cnt[SD_FI_LTE_A2] = 0;
			Sd_Cnt[SD_FO_LTE_A2] = 0;
			Sd_Cnt[SD_RO_LTE_A2] = 0;
			Sd_Path[PATH_LTE_A2] = 0;

			PwrAlarmChange.RvsOutUpperLmtFail_LTE_A2 = RESET;
			PwrAlarmChange.FwdOutUpperLmtFail_LTE_A2 = RESET;
			PwrAlarmChange.FwdInUpperLmtFail_LTE_A2= RESET; 
			PwrAlarmChange.FwdAmpOnOff_LTE_A2 = RESET;	

			if(Sts->FwdAmpOnOff_LTE_A2 == Enable)
			{
				Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Enable;
				Sts->SD_Status_LTE_A2 = SD_AMP_ON;

				Amp_Step[PATH_LTE_A2] = 10;				
			}
			else
			{
				Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Disable;
			}		
		break;	

		case Aid_FwdAmp1OnOff_LTE:
			Sts->FwdAmp1OnOff_LTE = AID_Value[0];
			Sts->Amp1OffCase_LTE = __UsrCtrl;
			RefFwdAmp1OnOff_LTE = Sts->FwdAmp1OnOff_LTE;
			
			tptr->BackUp.FwdAmp1OnOff_LTE = Sts->FwdAmp1OnOff_LTE;
			if(Ctrl)rval = TRUE;
			if(Sts->FwdAmp1OnOff_LTE_A2 == Enable)
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE = Enable;
			}
			else
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE = Disable;
			}

			Sd_Step[SD_FI_LTE_1] = 0;
			Sd_Step[SD_FO_LTE_1] = 0;
			Sd_Step[SD_RO_LTE_1] = 0;
			Sd_Cnt[SD_FI_LTE_1] = 0;
			Sd_Cnt[SD_FO_LTE_1] = 0;
			Sd_Cnt[SD_RO_LTE_1] = 0;
			Sd_Path[PATH_LTE_1] = 0;

			
			PwrAlarmChange.Rvs1OutUpperLmtFail_LTE = RESET;
			PwrAlarmChange.Fwd1OutUpperLmtFail_LTE = RESET;
			PwrAlarmChange.Fwd1InUpperLmtFail_LTE= RESET; 
			PwrAlarmChange.FwdAmp1OnOff_LTE = RESET;	
			
			if(Sts->FwdAmp1OnOff_LTE == Enable)
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE = Enable;
				Sts->SD_Status_LTE_1 = SD_AMP_ON;
			
				Amp_Step[PATH_LTE_1] = 10; 			
			}
			else
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE = Disable;
			}	
		break;	

		case Aid_FwdAmp1OnOff_LTE_A1:
			Sts->FwdAmp1OnOff_LTE_A1 = AID_Value[0];
			Sts->Amp1OffCase_LTE_A1 = __UsrCtrl;
			RefFwdAmp1OnOff_LTE_A1 = Sts->FwdAmp1OnOff_LTE_A1;
			
			tptr->BackUp.FwdAmp1OnOff_LTE_A1 = Sts->FwdAmp1OnOff_LTE_A1;
			if(Ctrl)rval = TRUE;

			if(Sts->FwdAmp1OnOff_LTE_A2 == Enable)
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = Enable;
			}
			else
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = Disable;
			}
			
			Sd_Step[SD_FI_LTE_A1_1] = 0;
			Sd_Step[SD_FO_LTE_A1_1] = 0;
			Sd_Step[SD_RO_LTE_A1_1] = 0;
			Sd_Cnt[SD_FI_LTE_A1_1] = 0;
			Sd_Cnt[SD_FO_LTE_A1_1] = 0;
			Sd_Cnt[SD_RO_LTE_A1_1] = 0;
			Sd_Path[PATH_LTE_A1_1] = 0;

			
			PwrAlarmChange.Rvs1OutUpperLmtFail_LTE_A1 = RESET;
			PwrAlarmChange.Fwd1OutUpperLmtFail_LTE_A1 = RESET;
			PwrAlarmChange.Fwd1InUpperLmtFail_LTE_A1 = RESET; 
			PwrAlarmChange.FwdAmp1OnOff_LTE_A1 = RESET;	
			
			if(Sts->FwdAmp1OnOff_LTE_A1== Enable)
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A1= Enable;
				Sts->SD_Status_LTE_A1_1 = SD_AMP_ON;
			
				Amp_Step[PATH_LTE_A1_1] = 10; 			
			}
			else
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = Disable;
			}	
		break;

		case Aid_FwdAmp1OnOff_LTE_A2:
			Sts->FwdAmp1OnOff_LTE_A2 = AID_Value[0];
			Sts->Amp1OffCase_LTE_A2 = __UsrCtrl;
			RefFwdAmp1OnOff_LTE_A2 = Sts->FwdAmp1OnOff_LTE_A2;
			
			tptr->BackUp.FwdAmp1OnOff_LTE_A2 = Sts->FwdAmp1OnOff_LTE_A2;
			if(Ctrl)rval = TRUE;

			if(Sts->FwdAmp1OnOff_LTE_A2 == Enable)
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = Enable;
			}
			else
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = Disable;
			}
			
			Sd_Step[SD_FI_LTE_A2_1] = 0;
			Sd_Step[SD_FO_LTE_A2_1] = 0;
			Sd_Step[SD_RO_LTE_A2_1] = 0;
			Sd_Cnt[SD_FI_LTE_A2_1] = 0;
			Sd_Cnt[SD_FO_LTE_A2_1] = 0;
			Sd_Cnt[SD_RO_LTE_A2_1] = 0;
			Sd_Path[PATH_LTE_A2_1] = 0;
			PwrAlarmChange.Rvs1OutUpperLmtFail_LTE_A2 = RESET;
			PwrAlarmChange.Fwd1OutUpperLmtFail_LTE_A2 = RESET;
			PwrAlarmChange.Fwd1InUpperLmtFail_LTE_A2= RESET; 
			PwrAlarmChange.FwdAmp1OnOff_LTE_A2 = RESET;	

			
			if(Sts->FwdAmp1OnOff_LTE_A2== Enable)
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A2= Enable;
				Sts->SD_Status_LTE_A2_1 = SD_AMP_ON;
			
				Amp_Step[PATH_LTE_A2_1] = 10; 			
			}
			else
			{
				Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = Disable;
			}	
		break;	


		case Aid_LTE15MUse:
			Sts->LTE15MUse = AID_Value[0];

			if(tDnrSts->LTE15MUse == __NOTUSE)
			{
				Sts->FwdOutHighLmt_LTE[0]		= FwdHighLmt_LTE + 3;
				Sts->FwdOutHighLmt_LTE[1]		= 0; 

				Sts->FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
				Sts->FwdOutUpperLmt_LTE[1]		= 0;

				Sts->OverInAlarmLmt_LTE 		= FwdOverInSDAlmLmt_LTE*2; 
			}
			else
			{
				Sts->FwdOutHighLmt_LTE[0]		= FwdHighLmt_LTE15M + 3;
				Sts->FwdOutHighLmt_LTE[1]		= 0; 

				Sts->FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE15M; 
				Sts->FwdOutUpperLmt_LTE[1]		= 0;
				
				Sts->OverInAlarmLmt_LTE 	= FwdOverInSDAlmLmt_LTE15M*2; 
			}



			Sts->Fwd1OutHighLmt_LTE[0]	= Sts->FwdOutHighLmt_LTE[0];
			Sts->Fwd1OutHighLmt_LTE[1]	= Sts->FwdOutHighLmt_LTE[1];
			Sts->Fwd1OutUpperLmt_LTE[0]  = Sts->FwdOutUpperLmt_LTE[0];
			Sts->Fwd1OutUpperLmt_LTE[1]  = Sts->FwdOutUpperLmt_LTE[1];	
			
			tptr->BackUp.LTE15MUse = Sts->LTE15MUse;
			tptr->BackUp.FwdOutUpperLmt_LTE[0] = Sts->FwdOutUpperLmt_LTE[0];
			tptr->BackUp.FwdOutUpperLmt_LTE[1] = Sts->FwdOutUpperLmt_LTE[1];
			tptr->BackUp.Fwd1OutUpperLmt_LTE[0] = Sts->Fwd1OutUpperLmt_LTE[0];
			tptr->BackUp.Fwd1OutUpperLmt_LTE[1] = Sts->Fwd1OutUpperLmt_LTE[1];
			if(Ctrl)rval = TRUE;
		break;	
        
        case Aid_RepeatResetPriod:
            Sts->RepeatResetPriod = AID_Value[0];
			
			tptr->BackUp.RepeatResetPriod = Sts->RepeatResetPriod;
			Auto_ResetCheckInit();
			AutoResetCnt = 0;
			
            if(Ctrl)rval = TRUE;
        break;	
 ////////////////////////////////////////
		case Aid_AGCOnOff_3G:
			Sts->AGCOnOff_3G = AID_Value[0];
			
			tptr->BackUp.AGCOnOff_3G = Sts->AGCOnOff_3G;
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGCOnOff_CDMALTE:
			Sts->AGCOnOff_CDMALTE = AID_Value[0];
			tptr->BackUp.AGCOnOff_CDMALTE = Sts->AGCOnOff_CDMALTE;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGCOnOff_LTE_A_0:
			Sts->AGCOnOff_LTE_A_0 = AID_Value[0];
			tptr->BackUp.AGCOnOff_LTE_A_0 = Sts->AGCOnOff_LTE_A_0;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGC1OnOff_LTE:
			Sts->AGC1OnOff_LTE = AID_Value[0];
			tptr->BackUp.AGC1OnOff_LTE = Sts->AGC1OnOff_LTE;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGCOnOff_LTE_A_1:
			Sts->AGCOnOff_LTE_A_1 = AID_Value[0];
			tptr->BackUp.AGCOnOff_LTE_A_1 = Sts->AGCOnOff_LTE_A_1;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGCMode_3G:
			Sts->AGCMode_3G = AID_Value[0];
			tptr->BackUp.AGCMode_3G = Sts->AGCMode_3G;
			
			if(Ctrl)rval = TRUE;
		break;	
		
		case Aid_AGCMode_2G:
			Sts->AGCMode_2G = AID_Value[0];
			tptr->BackUp.AGCMode_2G = Sts->AGCMode_2G;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGCMode_LTE:
			Sts->AGCMode_LTE = AID_Value[0];
			tptr->BackUp.AGCMode_LTE = Sts->AGCMode_LTE;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGCMode_LTE_A1:
			Sts->AGCMode_LTE_A1 = AID_Value[0];
			tptr->BackUp.AGCMode_LTE_A1 = Sts->AGCMode_LTE_A1;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AGCMode_LTE_A2:
			Sts->AGCMode_LTE_A2 = AID_Value[0];
			tptr->BackUp.AGCMode_LTE_A2 = Sts->AGCMode_LTE_A2;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_AutoReportPriod:
			Sts->AutoReportPriod = AID_Value[0];
			tptr->BackUp.AutoReportPriod = Sts->AutoReportPriod;
			
			PeriodStart = 1;
			TimeStart = 1;					// 자동보고 기준시 클리어 //			
			if(Ctrl)rval = TRUE;
		break;	


		case Aid_ReportTime:
			Sts->AutoReportBasePer[0] = AID_Value[0];
			Sts->AutoReportBasePer[1] = AID_Value[1];
			
			tptr->BackUp.AutoReportBasePer[0] = Sts->AutoReportBasePer[0];
			tptr->BackUp.AutoReportBasePer[1] = Sts->AutoReportBasePer[1];

			TimeStart = 1;		// 자동보고 기준시 클리어 //
			PeriodStart = 1;

			if(Ctrl)rval = TRUE;
		break;	
		
		/////////////////////////////////////////////////////////////
		case Aid_TPTL_OnOff:
			Sts->TPTL_OnOff = AID_Value[0];
			tptr->BackUp.TPTL_OnOff = Sts->TPTL_OnOff;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_TempOffset:
			Sts->TempOffset = AID_Value[0];
			tptr->BackUp.TempOffset = Sts->TempOffset;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_AlarmMask:
			Sts->AlarmMask = AID_Value[0];
			tptr->BackUp.AlarmMask = Sts->AlarmMask;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_ModemOnOff:
			Sts->ModemOnOff = AID_Value[0];
			if(Sts->ModemOnOff == Disable)	
			{
				SetSMS_PWR = SET;
			}
		break;

		case Aid_InitialSet:
			Sts->InitialSet = AID_Value[0];
			DefaultValueSet();
		break;

		case Aid_DefaultSet:
			Sts->DefaultSet = AID_Value[0];
			DefaultTableSet();
		break;

		case Aid_VccDet_Lmt:
			Sts->VccDet_Lmt.Data = ByteToWord(AID_Value[0],AID_Value[1]);
			tptr->BackUp.VccDet_Lmt.Data = Sts->VccDet_Lmt.Data;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdInPwrOffset_2G:
			Sts->FwdInPwrOffset_2G = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_2G = Sts->FwdInPwrOffset_2G;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdInPwrOffset_3G:
			Sts->FwdInPwrOffset_3G = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_3G = Sts->FwdInPwrOffset_3G;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs0OutPwrOffset_2G:
			Sts->Rvs0OutPwrOffset_2G = AID_Value[0];
			tptr->BackUp.Rvs0OutPwrOffset_2G = Sts->Rvs0OutPwrOffset_2G;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs0OutPwrOffset_3G:
			Sts->Rvs0OutPwrOffset_3G = AID_Value[0];
			tptr->BackUp.Rvs0OutPwrOffset_3G = Sts->Rvs0OutPwrOffset_3G;
			
			if(Ctrl)rval = TRUE;
		break;
		case Aid_FwdOutPwrOffset_2G:
			Sts->FwdOutPwrOffset_2G = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_2G = Sts->FwdOutPwrOffset_2G;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutPwrOffset_3G:
			Sts->FwdOutPwrOffset_3G = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_3G = Sts->FwdOutPwrOffset_3G;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdAttn1_2G:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->FwdAttn1_2G = AID_Value[0];
				CurrFwdAttn1_2G = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn2_2G:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->FwdAttn2_2G = AID_Value[0];
				CurrFwdAttn2_2G = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn1_3G:
			
			if( Sts->AGCOnOff_3G == Disable)
			{
				Sts->FwdAttn1_3G = AID_Value[0];
				CurrFwdAttn1_3G = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn2_3G:
			if(Sts->AGCOnOff_3G == Disable)
			{
				Sts->FwdAttn2_3G = AID_Value[0];
				CurrFwdAttn2_3G = 0xff;
				ChkAttChange = SET;
			}
		break;
		
		case Aid_RvsAttn1_2G:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn1_2G 		= AID_Value[0];
				Sts->ToggleRvsAttn2_2G 	= AID_Value[0];
				CurrRvsAttn1_2G = 0xff;
				ChkAttChange = SET;
			}
		break;
		
		case Aid_RvsAttn2_2G:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn2_2G = AID_Value[0];
				CurrRvsAttn2_2G = 0xff;
				ChkAttChange = SET;
			}
		break;
				
		case Aid_RvsAttn3_2G:
			if(Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn3_2G = AID_Value[0];
				CurrRvsAttn3_2G = 0xff;
				ChkAttChange = SET;
			}
		break;


		case Aid_RvsAttn1_3G:
			if( Sts->AGCOnOff_3G == Disable)
			{
				Sts->RvsAttn1_3G = AID_Value[0];
				CurrRvsAttn1_3G = 0xff;
				ChkAttChange = SET;
			}
		break;

		
		case Aid_RvsAttn2_3G:
			if( Sts->AGCOnOff_3G == Disable)
			{
				Sts->RvsAttn2_3G = AID_Value[0];
				CurrRvsAttn2_3G = 0xff;
				ChkAttChange = SET;
			}
		break;
				
		case Aid_RvsAttn3_3G:
			if( Sts->AGCOnOff_3G == Disable)
			{
				Sts->RvsAttn3_3G = AID_Value[0];
				CurrRvsAttn3_3G = 0xff;
				ChkAttChange = SET;
			}
		break;
		
		case Aid_RvsAttn4_3G:
			if( Sts->AGCOnOff_3G == Disable)
			{
				Sts->RvsAttn4_3G = AID_Value[0];
				CurrRvsAttn4_3G = 0xff;
				ChkAttChange = SET;
			}
		break;
		
		case Aid_ResetPeriodCountSet:
			Sts->ResetPeriodCountSet[0] = AID_Value[0];
			Sts->ResetPeriodCountSet[1] = AID_Value[1];
			Sts->ResetPeriodCountSet[2] = AID_Value[2];	
		break;

		case Aid_FwdInPwrOffset_LTE:
			Sts->FwdInPwrOffset_LTE = AID_Value[0];
			
			tptr->BackUp.FwdInPwrOffset_LTE = Sts->FwdInPwrOffset_LTE;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutPwrOffset_LTE:
			Sts->FwdOutPwrOffset_LTE = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_LTE = Sts->FwdOutPwrOffset_LTE;
			if(Ctrl)rval = TRUE;
		break;


		case Aid_Rvs0OutPwrOffset_LTE:
			Sts->RvsOutPwrOffset_LTE = AID_Value[0];
			tptr->BackUp.RvsOutPwrOffset_LTE = Sts->RvsOutPwrOffset_LTE;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_ShutDownOnOff_3G:
			Sts->ShutDownOnOff_3G = AID_Value[0];
		break;

		case Aid_ShutDownOnOff_2G:
			Sts->ShutDownOnOff_2G = AID_Value[0];
		break;

		case Aid_RvsOutUpperLmt_3G:
 			Sts->RvsOutUpperLmt_3G[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_3G[1] = AID_Value[1];
		break;
		
		case Aid_RvsOutUpperLmt_2G:
 			Sts->RvsOutUpperLmt_2G[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_2G[1] = AID_Value[1];
		break;

		case Aid_FwdGainOffset_3G:
			Sts->FwdGainOffset_3G = AID_Value[0];
			tptr->BackUp.FwdGainOffset_3G = Sts->FwdGainOffset_3G;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_3G:
			Sts->RvsGainOffset_3G = AID_Value[0];
			tptr->BackUp.RvsGainOffset_3G = Sts->RvsGainOffset_3G;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_FwdGainOffset_2G:
			Sts->FwdGainOffset_2G = AID_Value[0];
			tptr->BackUp.FwdGainOffset_2G = Sts->FwdGainOffset_2G;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_2G:
			Sts->RvsGainOffset_2G = AID_Value[0];
			tptr->BackUp.RvsGainOffset_2G = Sts->RvsGainOffset_2G;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;


		case Aid_FwdOutHighLmt_3G:
 			Sts->FwdOutHighLmt_3G[0] = AID_Value[0];
 			Sts->FwdOutHighLmt_3G[1] = AID_Value[1];
		break;

		case Aid_FwdOutHighLmt_2G:
 			Sts->FwdOutHighLmt_2G[0] = AID_Value[0];
 			Sts->FwdOutHighLmt_2G[1] = AID_Value[1];
		break;


		case Aid_DebugOnOff:
			Sts->DebugOnOff = AID_Value[0];
			if(Sts->DebugOnOff == Enable) 	iSMS_Debug_Mode = SET;
			else 							iSMS_Debug_Mode = RESET;
		break;

		case Aid_RadioMeasureOnOff:
			Sts->RadioMeasureOnOff = AID_Value[0];
			if( Sts->RadioMeasureOnOff == Enable)	PcFreqStsRqstFlag = TRUE;
		break;
///////////////////////////////
		case Aid_DetOffset:
			{
				INT8U i;

				for(i = 0; i < (sizeof(__DET)); i++)	 *((INT8U *)&(Sts->DetOffset.FwdOutAvgPwr_2G) + i) = AID_Value[i];
				memcpy((INT8U*)&tptr->BackUp.DetOffset, (INT8U*)&Sts->DetOffset, sizeof(Sts->DetOffset));
				if(Ctrl)rval = TRUE;
			}	
		break;

		case Aid_FwdInPwrOffset_LTE_A1:
			Sts->FwdInPwrOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_LTE_A1 = Sts->FwdInPwrOffset_LTE_A1;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutPwrOffset_LTE_A1:
			Sts->FwdOutPwrOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_LTE_A1 = Sts->FwdOutPwrOffset_LTE_A1;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsOutPwrOffset_LTE_A1:
			Sts->RvsOutPwrOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.RvsOutPwrOffset_LTE_A1 = Sts->RvsOutPwrOffset_LTE_A1;
			if(Ctrl)rval = TRUE;
		break;


		case Aid_FwdInPwrOffset_LTE_A2:
			Sts->FwdInPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_LTE_A2 = Sts->FwdInPwrOffset_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_FwdOutPwrOffset_LTE_A2:
			Sts->FwdOutPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_LTE_A2 = Sts->FwdOutPwrOffset_LTE_A2;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsOutPwrOffset_LTE_A2:
			Sts->RvsOutPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.RvsOutPwrOffset_LTE_A2 = Sts->RvsOutPwrOffset_LTE_A2;
			
			if(Ctrl)rval = TRUE;
		break;


		case Aid_FwdAttn1_CDMALTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->FwdAttn1_CDMALTE = AID_Value[0];
				CurrFwdAttn1_CDMALTE = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn1_CDMALTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn1_CDMALTE = AID_Value[0];
				CurrRvsAttn1_CDMALTE = 0xff;
				ChkAttChange = SET;
			}
		break;
		
		case Aid_FwdAttn1_LTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->FwdAttn1_LTE = AID_Value[0];
				CurrFwdAttn1_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn2_LTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->FwdAttn2_LTE = AID_Value[0];
				CurrFwdAttn2_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn1_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAttn1_LTE_A1 = AID_Value[0];
				CurrFwdAttn1_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn2_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAttn2_LTE_A1 = AID_Value[0];
				CurrFwdAttn2_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn1_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAttn1_LTE_A2 = AID_Value[0];
				CurrFwdAttn1_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn2_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAttn2_LTE_A2 = AID_Value[0];
				CurrFwdAttn2_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;


		case Aid_FwdAttn1_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAttn1_LTE_A = AID_Value[0];
				CurrFwdAttn1_LTE_A = 0xff;
				ChkAttChange = SET;
			}
		break;


		case Aid_RvsAttn1_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn1_LTE_A = AID_Value[0];
				CurrRvsAttn1_LTE_A = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Fwd1Attn1_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->Fwd1Attn1_LTE_A = AID_Value[0];
				CurrFwd1Attn1_LTE_A = 0xff;
				ChkAttChange = SET;
			}
		break;


		case Aid_Rvs1Attn1_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->Rvs1Attn1_LTE_A = AID_Value[0];
				CurrRvs1Attn1_LTE_A = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn1_LTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn1_LTE = AID_Value[0];
				CurrRvsAttn1_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn2_LTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn2_LTE = AID_Value[0];
				CurrRvsAttn2_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn3_LTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn3_LTE = AID_Value[0];
				CurrRvsAttn3_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn1_LTE_A1:
			
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn1_LTE_A1 = AID_Value[0];
				CurrRvsAttn1_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn2_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn2_LTE_A1 = AID_Value[0];
				CurrRvsAttn2_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn3_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn3_LTE_A1 = AID_Value[0];
				CurrRvsAttn3_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn1_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn1_LTE_A2 = AID_Value[0];
				CurrRvsAttn1_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn2_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn2_LTE_A2 = AID_Value[0];
				CurrRvsAttn2_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_RvsAttn3_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn3_LTE_A2 = AID_Value[0];
				CurrRvsAttn3_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdGainOffset_LTE:
			Sts->FwdGainOffset_LTE = AID_Value[0];
			tptr->BackUp.FwdGainOffset_LTE = Sts->FwdGainOffset_LTE;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsGainOffset_LTE:
			Sts->RvsGainOffset_LTE = AID_Value[0];
			tptr->BackUp.RvsGainOffset_LTE = Sts->RvsGainOffset_LTE;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_FwdGainOffset_LTE_A1:
			Sts->FwdGainOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.FwdGainOffset_LTE_A1 = Sts->FwdGainOffset_LTE_A1;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_LTE_A1:
			Sts->RvsGainOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.RvsGainOffset_LTE_A1 = Sts->RvsGainOffset_LTE_A1;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_FwdGainOffset_LTE_A2:
			Sts->FwdGainOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.FwdGainOffset_LTE_A2 = Sts->FwdGainOffset_LTE_A2;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_LTE_A2:
			Sts->RvsGainOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.RvsGainOffset_LTE_A2 = Sts->RvsGainOffset_LTE_A2;
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;


		case Aid_FwdAgcAttn_2G:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->FwdAgcAttn_2G = AID_Value[0];
			}
		break;
		
		case Aid_FwdAgcAttn_LTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->FwdAgcAttn_LTE = AID_Value[0];
			}
		break;
		
		case Aid_FwdAgcAttn_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAgcAttn_LTE_A1 = AID_Value[0];
			}
		break;

		case Aid_FwdAgcAttn_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAgcAttn_LTE_A2 = AID_Value[0];
			}
		break;
				
		
		case Aid_FwdAgcAttn_3G:
			if( Sts->AGCOnOff_3G == Disable)
			{
				Sts->FwdAgcAttn_3G = AID_Value[0];
			}
		break;

		case Aid_RvsAlcAttn_2G:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAlcAttn_2G = AID_Value[0];
			}
		break;
		
		case Aid_RvsAlcAttn_LTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAlcAttn_LTE = AID_Value[0];
			}
		break;		

		case Aid_RvsAlcAttn_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAlcAttn_LTE_A2 = AID_Value[0];
			}
		break;		

		case Aid_RvsAlcAttn_3G:
			Sts->RvsAlcAttn_3G = AID_Value[0];
		break;

		case Aid_RvsAlcOnOff_2G:
			Sts->RvsAlcOnOff_2G = AID_Value[0];
		break;

		case Aid_RvsAlcOnOff_LTE:
			Sts->RvsAlcOnOff_LTE = AID_Value[0];
		break;

		case Aid_RvsAlcOnOff_LTE_A1:
			Sts->RvsAlcOnOff_LTE_A1 = AID_Value[0];
		break;

		case Aid_RvsAlcOnOff_LTE_A2:
			Sts->RvsAlcOnOff_LTE_A2 = AID_Value[0];
		break;

		case Aid_RvsAlcOnOff_3G:
			Sts->RvsAlcOnOff_3G = AID_Value[0];
		break;
		
		case Aid_ShutDownOnOff_LTE:
			Sts->ShutDownOnOff_LTE = AID_Value[0];
		break;

		case Aid_ShutDownOnOff_LTE_A1:
			Sts->ShutDownOnOff_LTE_A1= AID_Value[0];
		break;

		case Aid_ShutDownOnOff_LTE_A2:
			Sts->ShutDownOnOff_LTE_A2= AID_Value[0];
		break;

		case Aid_RvsOutUpperLmt_LTE:
 			Sts->RvsOutUpperLmt_LTE[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_LTE[1] = AID_Value[1];
		break;
		
		case Aid_RvsOutUpperLmt_LTE_A1:
 			Sts->RvsOutUpperLmt_LTE_A1[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_LTE_A1[1] = AID_Value[1];
		break;

		case Aid_RvsOutUpperLmt_LTE_A2:
 			Sts->RvsOutUpperLmt_LTE_A2[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_LTE_A2[1] = AID_Value[1];
		break;

		case Aid_FwdOutHighLmt_LTE:
 			Sts->FwdOutHighLmt_LTE[0] = AID_Value[0];
 			Sts->FwdOutHighLmt_LTE[1] = AID_Value[1];
		break;

		case Aid_FwdOutHighLmt_LTE_A1:
 			Sts->FwdOutHighLmt_LTE_A1[0] = AID_Value[0];
 			Sts->FwdOutHighLmt_LTE_A1[1] = AID_Value[1];
		break;


		case Aid_FwdOutHighLmt_LTE_A2:
 			Sts->FwdOutHighLmt_LTE_A2[0] = AID_Value[0];
 			Sts->FwdOutHighLmt_LTE_A2[1] = AID_Value[1];
		break;


		case Aid_OverInAlarmLmt_2G:
 			Sts->OverInAlarmLmt_2G = AID_Value[0];
		break;
		
		case Aid_OverInAlarmLmt_LTE:
 			Sts->OverInAlarmLmt_LTE = AID_Value[0];
		break;

		case Aid_OverInAlarmLmt_LTE_A1:
 			Sts->OverInAlarmLmt_LTE_A1 = AID_Value[0];
		break;

		case Aid_OverInAlarmLmt_LTE_A2:
 			Sts->OverInAlarmLmt_LTE_A2 = AID_Value[0];
		break;


		case Aid_OverInAlarmLmt_3G:
 			Sts->OverInAlarmLmt_3G = AID_Value[0];
		break;

		case Aid_RvsALCLvl_2G:
			Sts->RvsALCLvl_2G = AID_Value[0];
			tptr->BackUp.RvsALCLvl_2G = Sts->RvsALCLvl_2G;
			
 			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsALCLvl_LTE:
			Sts->RvsALCLvl_LTE = AID_Value[0];
			tptr->BackUp.RvsALCLvl_LTE = Sts->RvsALCLvl_LTE;
			
 			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsALCLvl_LTE_A1:
			Sts->RvsALCLvl_LTE_A1 = AID_Value[0];
			tptr->BackUp.RvsALCLvl_LTE_A1 = Sts->RvsALCLvl_LTE_A1;
			
 			if(Ctrl)rval = TRUE;
		break;

		case Aid_RvsALCLvl_LTE_A2:
			Sts->RvsALCLvl_LTE_A2 = AID_Value[0];
			tptr->BackUp.RvsALCLvl_LTE_A2 = Sts->RvsALCLvl_LTE_A2;
			
 			if(Ctrl)rval = TRUE;
		break;


		case Aid_RvsALCLvl_3G:
			Sts->RvsALCLvl_3G = AID_Value[0];
			tmpRvsALCLvl_3G = Sts->RvsALCLvl_3G;
			tptr->BackUp.RvsALCLvl_3G = Sts->RvsALCLvl_3G;
			
 			if(Ctrl)rval = TRUE;
		break;
		/////////////////////////////////////////////////////////////
//ETC

////////////////////////////////////////////////////
		case Aid_RCUReset:
			Chk_Reset = SET;
		break;

		case Aid_Fwd1OutUpperLmt_LTE:
			Sts->Fwd1OutUpperLmt_LTE[0] = AID_Value[0];
			Sts->Fwd1OutUpperLmt_LTE[1] = AID_Value[1];

			tptr->BackUp.Fwd1OutUpperLmt_LTE[0] = Sts->Fwd1OutUpperLmt_LTE[0];
			tptr->BackUp.Fwd1OutUpperLmt_LTE[1] = Sts->Fwd1OutUpperLmt_LTE[1];

			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutLowerLmt_LTE:
			Sts->Fwd1OutLowerLmt_LTE[0] = AID_Value[0];
			Sts->Fwd1OutLowerLmt_LTE[1] = AID_Value[1];

			tptr->BackUp.Fwd1OutLowerLmt_LTE[0] = Sts->Fwd1OutLowerLmt_LTE[0];
			tptr->BackUp.Fwd1OutLowerLmt_LTE[1] = Sts->Fwd1OutLowerLmt_LTE[1];
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1GainSet_LTE:
			Sts->Fwd1GainSet_LTE = AID_Value[0];
			if(nPtr== SmsSer)Sts->Fwd1GainSet_LTE = Sts->Fwd1GainSet_LTE*2;
			Sts->Fwd1GainSet_LTE = MinMaxAttnCheck(Sts->Fwd1GainSet_LTE, Gain_LTE, RvsMinGain_LTE);
			Sts->Fwd1AgcAttn_LTE= GainAttnCalculation(Sts->Fwd1GainSet_LTE,Gain_LTE,ATTENMIN);
			
			tptr->BackUp.Fwd1GainSet_LTE = Sts->Fwd1GainSet_LTE;
			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutUpperLmt_LTE_A1:
			Sts->Fwd1OutUpperLmt_LTE_A1[0] = AID_Value[0];
			Sts->Fwd1OutUpperLmt_LTE_A1[1] = AID_Value[1];
			
			tptr->BackUp.Fwd1OutUpperLmt_LTE_A1[0] = Sts->Fwd1OutUpperLmt_LTE_A1[0];
			tptr->BackUp.Fwd1OutUpperLmt_LTE_A1[1] = Sts->Fwd1OutUpperLmt_LTE_A1[1];
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutLowerLmt_LTE_A1:
			Sts->Fwd1OutLowerLmt_LTE_A1[0] = AID_Value[0];
			Sts->Fwd1OutLowerLmt_LTE_A1[1] = AID_Value[1];
			tptr->BackUp.Fwd1OutLowerLmt_LTE_A1[0] = Sts->Fwd1OutLowerLmt_LTE_A1[0];
			tptr->BackUp.Fwd1OutLowerLmt_LTE_A1[1] = Sts->Fwd1OutLowerLmt_LTE_A1[1];			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1GainSet_LTE_A1:
			Sts->Fwd1GainSet_LTE_A1 = AID_Value[0];
			if(nPtr== SmsSer)Sts->Fwd1GainSet_LTE_A1 = Sts->Fwd1GainSet_LTE_A1*2;
			
			Sts->Fwd1AgcAttn_LTE_A1 = MinMaxAttnCheck(Sts->Fwd1AgcAttn_LTE_A1, Gain_LTE_A, RvsMinGain_LTE_A);
			Sts->Fwd1AgcAttn_LTE_A1 = GainAttnCalculation(Sts->Fwd1GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
			
			tptr->BackUp.Fwd1GainSet_LTE_A1 = Sts->Fwd1GainSet_LTE_A1;
			ChkAttChange = RESET;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutUpperLmt_LTE_A2:
			Sts->Fwd1OutUpperLmt_LTE_A2[0] = AID_Value[0];
			Sts->Fwd1OutUpperLmt_LTE_A2[1] = AID_Value[1];

			tptr->BackUp.Fwd1OutUpperLmt_LTE_A2[0] = Sts->Fwd1OutUpperLmt_LTE_A2[0];
			tptr->BackUp.Fwd1OutUpperLmt_LTE_A2[1] = Sts->Fwd1OutUpperLmt_LTE_A2[1];			
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutLowerLmt_LTE_A2:
			Sts->Fwd1OutLowerLmt_LTE_A2[0] = AID_Value[0];
			Sts->Fwd1OutLowerLmt_LTE_A2[1] = AID_Value[1];
			tptr->BackUp.Fwd1OutLowerLmt_LTE_A2[0] = Sts->Fwd1OutLowerLmt_LTE_A2[0];
			tptr->BackUp.Fwd1OutLowerLmt_LTE_A2[1] = Sts->Fwd1OutLowerLmt_LTE_A2[1];			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1GainSet_LTE_A2:
			Sts->Fwd1GainSet_LTE_A2 = AID_Value[0];
			if(nPtr== SmsSer)Sts->Fwd1GainSet_LTE_A2 = Sts->Fwd1GainSet_LTE_A2*2;
			
			Sts->Fwd1AgcAttn_LTE_A2 = MinMaxAttnCheck(Sts->Fwd1AgcAttn_LTE_A2, Gain_LTE_A, RvsMinGain_LTE_A);
			Sts->Fwd1AgcAttn_LTE_A2 = GainAttnCalculation(Sts->Fwd1GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
			
			ChkAttChange = RESET;
			
			tptr->BackUp.Fwd1GainSet_LTE_A2 = Sts->Fwd1GainSet_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;


		case Aid_Rvs1GainSet_LTE:
			Sts->Rvs1GainSet_LTE = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs1GainSet_LTE = Sts->Rvs1GainSet_LTE*2;
			Sts->Rvs1GainSet_LTE = MinMaxAttnCheck(Sts->Rvs1GainSet_LTE, Gain_LTE, RvsMinGain_LTE);
			Sts->Rvs1GainAttn_LTE = GainAttnCalculation(Sts->Rvs1GainSet_LTE,Gain_LTE,ATTENMIN);
			
			ChkAttChange = RESET;
			
			tptr->BackUp.Rvs1GainSet_LTE = Sts->Rvs1GainSet_LTE;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs1GainBalance_LTE:
			Sts->Rvs1GainBalance_LTE = AID_Value[0];
			tptr->BackUp.Rvs1GainBalance_LTE = Sts->Rvs1GainBalance_LTE;
			if(Ctrl)rval = TRUE;
		break;		

		case Aid_Rvs1GainSet_LTE_A1:
			Sts->Rvs1GainSet_LTE_A1 = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs1GainSet_LTE_A1 = Sts->Rvs1GainSet_LTE_A1*2;
			
			Sts->Rvs1GainSet_LTE_A1 = MinMaxAttnCheck(Sts->Rvs1GainSet_LTE_A1, Gain_LTE_A, RvsMinGain_LTE_A);
			Sts->Rvs1GainAttn_LTE_A1 = GainAttnCalculation(Sts->Rvs1GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
			ChkAttChange = RESET;
			
			tptr->BackUp.Rvs1GainSet_LTE_A1 = Sts->Rvs1GainSet_LTE_A1;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs1GainBalance_LTE_A1:
			Sts->Rvs1GainBalance_LTE_A1 = AID_Value[0];
			
			tptr->BackUp.Rvs1GainBalance_LTE_A1 = Sts->Rvs1GainBalance_LTE_A1;
			if(Ctrl)rval = TRUE;
		break;			

		case Aid_Rvs1GainSet_LTE_A2:
			Sts->Rvs1GainSet_LTE_A2 = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs1GainSet_LTE_A2 = Sts->Rvs1GainSet_LTE_A2*2;
			Sts->Rvs1GainSet_LTE_A2 = MinMaxAttnCheck(Sts->Rvs1GainSet_LTE_A2, Gain_LTE_A, RvsMinGain_LTE_A);
			Sts->Rvs1GainAttn_LTE_A2 = GainAttnCalculation(Sts->Rvs1GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
			ChkAttChange = RESET;
			
			tptr->BackUp.Rvs1GainSet_LTE_A2 = Sts->Rvs1GainSet_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs1GainBalance_LTE_A2:
			Sts->Rvs1GainBalance_LTE_A2 = AID_Value[0];
			tptr->BackUp.Rvs1GainBalance_LTE_A2 = Sts->Rvs1GainBalance_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;			

		case Aid_Det1Offset:
			{
				INT8U i;

				for(i = 0; i < (sizeof(__DET1)); i++)	 *((INT8U *)&(Sts->Det1Offset.Fwd1InPwr_LTE) + i) = AID_Value[i];
				
				memcpy((INT8U*)&tptr->BackUp.Det1Offset, (INT8U*)&Sts->Det1Offset, sizeof(Sts->Det1Offset));
				if(Ctrl)rval = TRUE;
			}	
		break;


		case Aid_Fwd1InPwrOffset_LTE:
			Sts->Fwd1InPwrOffset_LTE = AID_Value[0];
			
			tptr->BackUp.Fwd1InPwrOffset_LTE = Sts->Fwd1InPwrOffset_LTE;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutPwrOffset_LTE:
			Sts->Fwd1OutPwrOffset_LTE = AID_Value[0];
			
			tptr->BackUp.Fwd1OutPwrOffset_LTE = Sts->Fwd1OutPwrOffset_LTE;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs1OutPwrOffset_LTE:
			Sts->Rvs1OutPwrOffset_LTE = AID_Value[0];
			tptr->BackUp.Rvs1OutPwrOffset_LTE = Sts->Rvs1OutPwrOffset_LTE;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1InPwrOffset_LTE_A1:
			Sts->Fwd1InPwrOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.Fwd1InPwrOffset_LTE_A1 = Sts->Fwd1InPwrOffset_LTE_A1;
			
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutPwrOffset_LTE_A1:
			Sts->Fwd1OutPwrOffset_LTE_A1 = AID_Value[0];
			
			tptr->BackUp.Fwd1OutPwrOffset_LTE_A1 = Sts->Fwd1OutPwrOffset_LTE_A1;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs1OutPwrOffset_LTE_A1:
			Sts->Rvs1OutPwrOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.Rvs1OutPwrOffset_LTE_A1 = Sts->Rvs1OutPwrOffset_LTE_A1;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1InPwrOffset_LTE_A2:
			Sts->Fwd1InPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.Fwd1InPwrOffset_LTE_A2 = Sts->Fwd1InPwrOffset_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Fwd1OutPwrOffset_LTE_A2:
			Sts->Fwd1OutPwrOffset_LTE_A2 = AID_Value[0];
			
			tptr->BackUp.Fwd1OutPwrOffset_LTE_A2 = Sts->Fwd1OutPwrOffset_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs1OutPwrOffset_LTE_A2:
			Sts->Rvs1OutPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.Rvs1OutPwrOffset_LTE_A2 = Sts->Rvs1OutPwrOffset_LTE_A2;
			if(Ctrl)rval = TRUE;
		break;



		case Aid_Fwd1Attn1_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Fwd1Attn1_LTE = AID_Value[0];
				CurrFwd1Attn1_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Fwd1Attn2_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Fwd1Attn2_LTE = AID_Value[0];
				CurrFwd1Attn2_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Fwd1Attn1_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Fwd1Attn1_LTE_A1 = AID_Value[0];
				CurrFwd1Attn1_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Fwd1Attn2_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Fwd1Attn2_LTE_A1 = AID_Value[0];
				CurrFwd1Attn2_LTE_A1 = 0xff;
				ChkAttChange = SET;

			}
		break;

		case Aid_Fwd1Attn1_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Fwd1Attn1_LTE_A2 = AID_Value[0];
				CurrFwd1Attn1_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Fwd1Attn2_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Fwd1Attn2_LTE_A2 = AID_Value[0];
				CurrFwd1Attn2_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;


		case Aid_Rvs1Attn1_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Rvs1Attn1_LTE = AID_Value[0];
				CurrRvs1Attn1_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn2_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Rvs1Attn2_LTE = AID_Value[0];
				CurrRvs1Attn2_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn3_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Rvs1Attn3_LTE = AID_Value[0];
				CurrRvs1Attn3_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn4_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Rvs1Attn4_LTE = AID_Value[0];
				CurrRvs1Attn4_LTE = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn1_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1Attn1_LTE_A1 = AID_Value[0];
				CurrRvs1Attn1_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn2_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1Attn2_LTE_A1 = AID_Value[0];
				CurrRvs1Attn2_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn3_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1Attn3_LTE_A1 = AID_Value[0];
				CurrRvs1Attn3_LTE_A1 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn1_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1Attn1_LTE_A2 = AID_Value[0];
				CurrRvs1Attn1_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn2_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1Attn2_LTE_A2 = AID_Value[0];
				CurrRvs1Attn2_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Rvs1Attn3_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1Attn3_LTE_A2 = AID_Value[0];
				CurrRvs1Attn3_LTE_A2 = 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_Fwd1GainOffset_LTE:
			Sts->Fwd1GainOffset_LTE = AID_Value[0];
			tptr->BackUp.Fwd1GainOffset_LTE = Sts->Fwd1GainOffset_LTE;
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_Rvs1GainOffset_LTE:
			Sts->Rvs1GainOffset_LTE = AID_Value[0];
			tptr->BackUp.Rvs1GainOffset_LTE = Sts->Rvs1GainOffset_LTE;
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_Fwd1GainOffset_LTE_A1:
			Sts->Fwd1GainOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.Fwd1GainOffset_LTE_A1 = Sts->Fwd1GainOffset_LTE_A1;
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_Rvs1GainOffset_LTE_A1:
			Sts->Rvs1GainOffset_LTE_A1 = AID_Value[0];
			tptr->BackUp.Rvs1GainOffset_LTE_A1 = Sts->Rvs1GainOffset_LTE_A1;
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_Fwd1GainOffset_LTE_A2:
			Sts->Fwd1GainOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.Fwd1GainOffset_LTE_A2 = Sts->Fwd1GainOffset_LTE_A2;
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;

		case Aid_Rvs1GainOffset_LTE_A2:
			Sts->Rvs1GainOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.Rvs1GainOffset_LTE_A2 = Sts->Rvs1GainOffset_LTE_A2;
			
			if(Ctrl)rval = TRUE;
			ChkAttChange = RESET;
		break;		
		
		case Aid_Fwd1AgcAttn_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Fwd1AgcAttn_LTE = AID_Value[0];
			}
		break;
		
		case Aid_Fwd1AgcAttn_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Fwd1AgcAttn_LTE_A1 = AID_Value[0];
			}
		break;

		case Aid_Fwd1AgcAttn_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Fwd1AgcAttn_LTE_A2 = AID_Value[0];
			}
		break;

		
		case Aid_Rvs1AlcAttn_LTE:
			if( Sts->AGC1OnOff_LTE == Disable)
			{
				Sts->Rvs1AlcAttn_LTE = AID_Value[0];
			}
		break;		

		case Aid_Rvs1AlcAttn_LTE_A1:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1AlcAttn_LTE_A1 = AID_Value[0];
			}
		break;		

		case Aid_Rvs1AlcAttn_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_1 == Disable)
			{
				Sts->Rvs1AlcAttn_LTE_A2 = AID_Value[0];
			}
		break;		

		case Aid_Rvs1AlcOnOff_LTE:
			Sts->Rvs1AlcOnOff_LTE = AID_Value[0];
		break;

		case Aid_Rvs1AlcOnOff_LTE_A1:
			Sts->Rvs1AlcOnOff_LTE_A1 = AID_Value[0];
		break;

		case Aid_Rvs1AlcOnOff_LTE_A2:
			Sts->Rvs1AlcOnOff_LTE_A2 = AID_Value[0];
		break;
		
		case Aid_ShutDownOnOff1_LTE:
			Sts->ShutDownOnOff_LTE1 = AID_Value[0];
		break;

		case Aid_ShutDownOnOff1_LTE_A1:
			Sts->ShutDownOnOff_LTE_A1_1= AID_Value[0];
		break;

		case Aid_ShutDownOnOff_LTE_A2_1:
			Sts->ShutDownOnOff_LTE_A2_1= AID_Value[0];
		break;

		case Aid_Rvs1OutUpperLmt_LTE:
 			Sts->Rvs1OutUpperLmt_LTE[0] = AID_Value[0];
 			Sts->Rvs1OutUpperLmt_LTE[1] = AID_Value[1];
		break;
		
		case Aid_Rvs1OutUpperLmt_LTE_A1:
 			Sts->Rvs1OutUpperLmt_LTE_A1[0] = AID_Value[0];
 			Sts->Rvs1OutUpperLmt_LTE_A1[1] = AID_Value[1];
		break;

		case Aid_Rvs1OutUpperLmt_LTE_A2:
 			Sts->Rvs1OutUpperLmt_LTE_A2[0] = AID_Value[0];
 			Sts->Rvs1OutUpperLmt_LTE_A2[1] = AID_Value[1];
		break;

		case Aid_Fwd1OutHighLmt_LTE:
 			Sts->Fwd1OutHighLmt_LTE[0] = AID_Value[0];
 			Sts->Fwd1OutHighLmt_LTE[1] = AID_Value[1];
		break;

		case Aid_Fwd1OutHighLmt_LTE_A1:
 			Sts->Fwd1OutHighLmt_LTE_A1[0] = AID_Value[0];
 			Sts->Fwd1OutHighLmt_LTE_A1[1] = AID_Value[1];
		break;

		case Aid_Fwd1OutHighLmt_LTE_A2:
 			Sts->Fwd1OutHighLmt_LTE_A2[0] = AID_Value[0];
 			Sts->Fwd1OutHighLmt_LTE_A2[1] = AID_Value[1];
		break;

		case Aid_Rvs1ALCLvl_LTE:
			Sts->Rvs1ALCLvl_LTE = AID_Value[0];
			tptr->BackUp.Rvs1ALCLvl_LTE = Sts->Rvs1ALCLvl_LTE;
 			if(Ctrl)rval = TRUE;
		break;

		case Aid_Rvs1ALCLvl_LTE_A1:
			Sts->Rvs1ALCLvl_LTE_A1 = AID_Value[0];
			tptr->BackUp.Rvs1ALCLvl_LTE_A1 = Sts->Rvs1ALCLvl_LTE_A1;
 			if(Ctrl)rval = TRUE;
		break; 

		case Aid_Rvs1ALCLvl_LTE_A2:
			Sts->Rvs1ALCLvl_LTE_A2 = AID_Value[0];
			tptr->BackUp.Rvs1ALCLvl_LTE_A2 = Sts->Rvs1ALCLvl_LTE_A2;
 			if(Ctrl)rval = TRUE;
		break; 		
//////////////////////////Wave
		case Aid_RxMaxVal  :
		  Sts->WaveCtrl.RxMaxVal[0] = AID_Value[0];
		  Sts->WaveCtrl.RxMaxVal[1] = AID_Value[1];

		  tptr->BackUp.RxMaxVal[0] = Sts->WaveCtrl.RxMaxVal[0];
		  tptr->BackUp.RxMaxVal[1] = Sts->WaveCtrl.RxMaxVal[1];
		  if(Ctrl)rval = TRUE;
		break;		


		case Aid_RxMinVal  :
		  Sts->WaveCtrl.RxMinVal[0] = AID_Value[0];
		  Sts->WaveCtrl.RxMinVal[1] = AID_Value[1];

		  tptr->BackUp.RxMinVal[0] = Sts->WaveCtrl.RxMinVal[0];
		  tptr->BackUp.RxMinVal[1] = Sts->WaveCtrl.RxMinVal[1];
		  
		  if(Ctrl)rval = TRUE;
		break;			

		case Aid_TxMaxVal  :
		  Sts->WaveCtrl.TxMaxVal[0] = AID_Value[0];
		  Sts->WaveCtrl.TxMaxVal[1] = AID_Value[1];
		  tptr->BackUp.TxMaxVal[0] = Sts->WaveCtrl.TxMaxVal[0];
		  tptr->BackUp.TxMaxVal[1] = Sts->WaveCtrl.TxMaxVal[1];
		  
		  if(Ctrl)rval = TRUE;
		break;		

		case Aid_TxMinVal  :
		  Sts->WaveCtrl.TxMinVal[0] = AID_Value[0];
		  Sts->WaveCtrl.TxMinVal[1] = AID_Value[1];
		  tptr->BackUp.TxMinVal[0] = Sts->WaveCtrl.TxMinVal[0];
		  tptr->BackUp.TxMinVal[1] = Sts->WaveCtrl.TxMinVal[1];		  
		  if(Ctrl)rval = TRUE;
		break;			

		case Aid_EcIo:
		  Sts->WaveCtrl.EcIo = AID_Value[0];
		  
		  tptr->BackUp.EcIo = Sts->WaveCtrl.EcIo;
		  if(Ctrl)rval = TRUE;
		break;			

		case Aid_ARMode:
		  Sts->WaveCtrl.AR_Mode[0] = AID_Value[0];
		  Sts->WaveCtrl.AR_Mode[1] = AID_Value[1];

		  tptr->BackUp.AR_Mode[0] = Sts->WaveCtrl.AR_Mode[0];
		  tptr->BackUp.AR_Mode[1] = Sts->WaveCtrl.AR_Mode[1];		  
		  if(Ctrl)rval = TRUE;
		break;			

		case Aid_RadioReportTime  :
			Sts->WaveCtrl.Radio_ReportTime[0] = AID_Value[0];
			Sts->WaveCtrl.Radio_ReportTime[1] = AID_Value[1];

			tptr->BackUp.Radio_ReportTime[0] = Sts->WaveCtrl.Radio_ReportTime[0];
			tptr->BackUp.Radio_ReportTime[1] = Sts->WaveCtrl.Radio_ReportTime[1];		

			WTwoTimeStart = 1;

			if(Ctrl)rval = TRUE;
		break;			

		case Aid_RadioReportPeriod	  :
		  Sts->WaveCtrl.Radio_ReportPeriod[0] = AID_Value[0];
		  Sts->WaveCtrl.Radio_ReportPeriod[1] = AID_Value[1];
		  tptr->BackUp.Radio_ReportPeriod[0] = Sts->WaveCtrl.Radio_ReportPeriod[0];
		  tptr->BackUp.Radio_ReportPeriod[1] = Sts->WaveCtrl.Radio_ReportPeriod[1];	  
		  
		  WTwoPeriodStart= 1;		  
		  if(Ctrl)rval = TRUE;
		break;			

		case Aid_TestStn :
		for(i=0;i<11;i++)
		{
			TestStation[i] = AID_Value[i];
			Sts->TestStn[i] = AID_Value[i];

			
			Sts->WaveCtrl.TestStn[i]=TestStation[i];
			if ((TestStation[i]<'0')||(TestStation[i]>'9') )TestStation[i] = 0x00;
			
			memcpy((INT8U*)&tptr->BackUp.TestStn, (INT8U*)&Sts->TestStn, sizeof(Sts->TestStn));
			if(Ctrl)rval = TRUE;
		}
		break;


		case Aid_HostStn:
			for(i = 0; i < 11; i++)
			{
			  Sts->HostNumber[i] = AID_Value[i];
			  if ((Sts->HostNumber[i]<'0')||(Sts->HostNumber[i]>'9') )Sts->HostNumber[i] = 0x00;
			}		
			
			memcpy((INT8U*)&tptr->BackUp.HostNumber, (INT8U*)&Sts->HostNumber, sizeof(Sts->HostNumber));
			if(Ctrl)rval = TRUE;
		break;		

		case Aid_Band_Select_LTE_A1  :
			Sts->Band_Select_LTE_A1 = AID_Value[0];
			tptr->BackUp.Band_Select_LTE_A1 = Sts->Band_Select_LTE_A1;		

			if(tDnrSts->Band_Select_LTE_A1 == __USE)
			{
				Sts->FwdAmpOnOff_LTE_A1 = Enable;
				if(iRepeaterType == _TRIO_MM)	
				{
					Sts->FwdAmp1OnOff_LTE_A1 = Enable;
				}
 			}
			else
			{
				Sts->FwdAmpOnOff_LTE_A1= Disable;
				
				if(iRepeaterType == _TRIO_MM)	
				{
					Sts->FwdAmp1OnOff_LTE_A1 = Disable;
				}
 			}

			tptr->BackUp.FwdAmpOnOff_LTE_A1 = Sts->FwdAmpOnOff_LTE_A1;
			
			if(iRepeaterType == _TRIO_MM)	
			{
				tptr->BackUp.FwdAmp1OnOff_LTE_A2 = Sts->FwdAmpOnOff_LTE_A1;
			}
			if(Ctrl)rval = TRUE;
		break;	
		
		case Aid_Band_Select_LTE_A2  :
			Sts->Band_Select_LTE_A2[0] = AID_Value[0];
			Sts->Band_Select_LTE_A2[1] = AID_Value[1];
			Sts->Band_Select_LTE_A2[2] = AID_Value[2];
			ChkBandSelet = SET;


			tptr->BackUp.Band_Select_LTE_A2[0] = Sts->Band_Select_LTE_A2[0];		
			tptr->BackUp.Band_Select_LTE_A2[1] = Sts->Band_Select_LTE_A2[1];		
			tptr->BackUp.Band_Select_LTE_A2[2] = Sts->Band_Select_LTE_A2[2];		

			if(tDnrSts->Band_Select_LTE_A2[0] == __USE)
			{
				Sts->FwdAmpOnOff_LTE_A2 = Enable;
				
				if(iRepeaterType == _TRIO_MM)	
				{
					Sts->FwdAmp1OnOff_LTE_A2 = Enable;
				}
 			}
			else
			{
				Sts->FwdAmpOnOff_LTE_A2= Disable;
				if(iRepeaterType == _TRIO_MM)	
				{
					Sts->FwdAmp1OnOff_LTE_A2 = Disable;
				}
 			}

			tptr->BackUp.FwdAmpOnOff_LTE_A2 = Sts->FwdAmpOnOff_LTE_A2;
			
			if(iRepeaterType == _TRIO_MM)	
			{
				tptr->BackUp.FwdAmp1OnOff_LTE_A2 = Sts->FwdAmp1OnOff_LTE_A2;
			}
			if(Ctrl)rval = TRUE;
		break;	
		
		case Aid_FemtocellUseOnOff  :
			Sts->FemtocellUseOnOff.Data = AID_Value[0];

			if( Sts->FemtocellUseOnOff.LTE == __NOTUSE)
			{
				Sts->FwdAmpOnOff_LTE = Enable;
				Sts->AmpOffCase_LTE  = __UsrCtrl;
			}
			else
			{
				Sts->FwdAmpOnOff_LTE = Disable;
				Sts->AmpOffCase_LTE  = __UsrCtrl;
			}
			
			if( Sts->FemtocellUseOnOff.LTE_A1 == __NOTUSE)
			{
				Sts->FwdAmpOnOff_LTE_A1= Enable;
				Sts->AmpOffCase_LTE_A1 = __UsrCtrl;
			}
			else 
			{
				Sts->FwdAmpOnOff_LTE_A1= Disable;
				Sts->AmpOffCase_LTE_A1 = __UsrCtrl;
			}

			if( Sts->FemtocellUseOnOff.LTE_A2 == __NOTUSE)
			{
				Sts->FwdAmpOnOff_LTE_A2 = Enable;
				Sts->AmpOffCase_LTE_A2  = __UsrCtrl;
			}
			else 
			{
				Sts->FwdAmpOnOff_LTE_A2 = Disable;
				Sts->AmpOffCase_LTE_A2 = __UsrCtrl;
			}

			if( Sts->FemtocellUseOnOff.LTE_1 == __NOTUSE)
			{
				Sts->FwdAmp1OnOff_LTE = Enable;
				Sts->Amp1OffCase_LTE  = __UsrCtrl;
			}
			else
			{
				Sts->FwdAmp1OnOff_LTE = Disable;
				Sts->Amp1OffCase_LTE  = __UsrCtrl;
			}
			
			if( Sts->FemtocellUseOnOff.LTE_A1_1 == __NOTUSE)
			{
				Sts->FwdAmp1OnOff_LTE_A1= Enable;
				Sts->Amp1OffCase_LTE_A1 = __UsrCtrl;
			}
			else 
			{
				Sts->FwdAmp1OnOff_LTE_A1= Disable;
				Sts->Amp1OffCase_LTE_A1 = __UsrCtrl;
			}

			if( Sts->FemtocellUseOnOff.LTE_A2_1 == __NOTUSE)
			{
				Sts->FwdAmp1OnOff_LTE_A2 = Enable;
				Sts->Amp1OffCase_LTE_A2  = __UsrCtrl;
			}
			else 
			{
				Sts->FwdAmp1OnOff_LTE_A2 = Disable;
				Sts->Amp1OffCase_LTE_A2 = __UsrCtrl;
			}

	
			tptr->BackUp.FemtocellUseOnOff = Sts->FemtocellUseOnOff.Data;	
			tptr->BackUp.FwdAmpOnOff_LTE = Sts->FwdAmpOnOff_LTE;
			tptr->BackUp.FwdAmpOnOff_LTE_A1 = Sts->FwdAmpOnOff_LTE_A1;
			tptr->BackUp.FwdAmpOnOff_LTE_A2 = Sts->FwdAmpOnOff_LTE_A2;
			tptr->BackUp.FwdAmp1OnOff_LTE = Sts->FwdAmp1OnOff_LTE;
			tptr->BackUp.FwdAmp1OnOff_LTE_A1 = Sts->FwdAmp1OnOff_LTE_A1;
			tptr->BackUp.FwdAmp1OnOff_LTE_A2 = Sts->FwdAmp1OnOff_LTE_A2;
			
			if(Ctrl)rval = TRUE;
		break;	

		case Aid_OverInputAGCOnOff:
			Sts->OverInputAGCOnOff = AID_Value[0];
			
			Sts->RvsOtherOverInAlarmCount = 0;
			Sts->RvsOverInAlarmCount      = 0;
		break;		

		case Aid_ShunDownTime:
			Sts->ShunDownTime = AID_Value[0];
			if(tDnrSts->ShunDownTime == 0)
			{
				TimerRegist(Timer_RvsOSCAlarmCount, Time1Sec*1L);
			}
		break;		

		case Aid_RB_Value:
			Sts->RB_Value.LTE_0RB 		= AID_Value[0];
			Sts->RB_Value.LTE_A1_0RB 	= AID_Value[1];
			Sts->RB_Value.LTE_1_0RB 	= AID_Value[2];
			Sts->RB_Value.LTE_A1_1_0RB 	= AID_Value[3];
		break;		

		case Aid_RB_StsOnOff:
			Sts->RB_StsOnOff = AID_Value[0];
		break;		

		case Aid_DCOffSet:
 			Sts->DCOffSet 	= ByteToWord(AID_Value[0],AID_Value[1]);

			tptr->BackUp.DCOffSet = Sts->DCOffSet;		
			if(Ctrl)rval = TRUE;
		break;



		case Aid_PllFregOffset_LTE:
			Sts->PllFregOffset_LTE = AID_Value[0];
			tptr->BackUp.PllFregOffset_LTE = Sts->PllFregOffset_LTE;
			
			ChkPllFregOffset_LTE	= SET;
			if(Ctrl)rval = TRUE;
		break;


#if 0
		case Aid_SleepMode_2G:
			Sts->SleepMode_2G.SleepMode_OnOff = AID_Value[0];
			Sts->SleepMode_2G.SleepModeOnVolt.Data = ByteToWord(AID_Value[1],AID_Value[2]);
			Sts->SleepMode_2G.SleepModeOffVolt.Data = ByteToWord(AID_Value[3],AID_Value[4]);

			tptr->BackUp.SleepMode_2G.SleepMode_OnOff = Sts->SleepMode_2G.SleepMode_OnOff;
			tptr->BackUp.SleepMode_2G.SleepModeOnVolt.Data = Sts->SleepMode_2G.SleepModeOnVolt.Data;
			tptr->BackUp.SleepMode_2G.SleepModeOffVolt.Data = Sts->SleepMode_2G.SleepModeOffVolt.Data;
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_SleepMode_LTE:
			Sts->SleepMode_LTE.SleepMode_OnOff = AID_Value[0];
			Sts->SleepMode_LTE.SleepModeOnVolt.Data = ByteToWord(AID_Value[1],AID_Value[2]);
			Sts->SleepMode_LTE.SleepModeOffVolt.Data = ByteToWord(AID_Value[3],AID_Value[4]);

			tptr->BackUp.SleepMode_LTE.SleepMode_OnOff 		= Sts->SleepMode_LTE.SleepMode_OnOff;
			tptr->BackUp.SleepMode_LTE.SleepModeOnVolt.Data = Sts->SleepMode_LTE.SleepModeOnVolt.Data;
			tptr->BackUp.SleepMode_LTE.SleepModeOffVolt.Data = Sts->SleepMode_LTE.SleepModeOffVolt.Data;
			
			if(Ctrl)rval = TRUE;
		break;
		
		case Aid_SleepMode_LTE_A1:
			Sts->SleepMode_LTE_A1.SleepMode_OnOff = AID_Value[0];
			Sts->SleepMode_LTE_A1.SleepModeOnVolt.Data = ByteToWord(AID_Value[1],AID_Value[2]);
			Sts->SleepMode_LTE_A1.SleepModeOffVolt.Data = ByteToWord(AID_Value[3],AID_Value[4]);

			tptr->BackUp.SleepMode_LTE_A1.SleepMode_OnOff 		= Sts->SleepMode_LTE_A1.SleepMode_OnOff;
			tptr->BackUp.SleepMode_LTE_A1.SleepModeOnVolt.Data  = Sts->SleepMode_LTE_A1.SleepModeOnVolt.Data;
			tptr->BackUp.SleepMode_LTE_A1.SleepModeOffVolt.Data = Sts->SleepMode_LTE_A1.SleepModeOffVolt.Data;

			if(Ctrl)rval = TRUE;
		break;

		case Aid_SleepMode_LTE_A2:
			Sts->SleepMode_LTE_A2.SleepMode_OnOff = AID_Value[0];
			Sts->SleepMode_LTE_A2.SleepModeOnVolt.Data = ByteToWord(AID_Value[1],AID_Value[2]);
			Sts->SleepMode_LTE_A2.SleepModeOffVolt.Data = ByteToWord(AID_Value[3],AID_Value[4]);

			tptr->BackUp.SleepMode_LTE_A2.SleepMode_OnOff		= Sts->SleepMode_LTE_A2.SleepMode_OnOff;
			tptr->BackUp.SleepMode_LTE_A2.SleepModeOnVolt.Data	= Sts->SleepMode_LTE_A2.SleepModeOnVolt.Data;
			tptr->BackUp.SleepMode_LTE_A2.SleepModeOffVolt.Data = Sts->SleepMode_LTE_A2.SleepModeOffVolt.Data;

			if(Ctrl)rval = TRUE;
		break;
#endif
        default:
		break;
	}
	
	return rval;
}




void LoadBackupData(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT8U i = 0;
	INT8U err = 0;
	INT8U rval = FALSE;

	OSSemPend(CtrlSem, 0, &err);
	{
		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
		INT8U iDataFlag = tptr->BackUp.IsDataFlag;
		
		if(iDataFlag != ISDATA)
		{
			// default set!!
		}

		Sts->FwdOutUpperLmt_3G[0]		= tptr->BackUp.FwdOutUpperLmt_3G[0];
		Sts->FwdOutUpperLmt_3G[1]		= tptr->BackUp.FwdOutUpperLmt_3G[1];
		Sts->FwdOutLowerLmt_3G[0]		= tptr->BackUp.FwdOutLowerLmt_3G[0];
		Sts->FwdOutLowerLmt_3G[1]		= tptr->BackUp.FwdOutLowerLmt_3G[1];
		Sts->FwdGainSet_3G				= tptr->BackUp.FwdGainSet_3G;

		Sts->FwdOutUpperLmt_2G[0]		= tptr->BackUp.FwdOutUpperLmt_2G[0];
		Sts->FwdOutUpperLmt_2G[1]		= tptr->BackUp.FwdOutUpperLmt_2G[1];
		Sts->FwdOutLowerLmt_2G[0]		= tptr->BackUp.FwdOutLowerLmt_2G[0];
		Sts->FwdOutLowerLmt_2G[1]		= tptr->BackUp.FwdOutLowerLmt_2G[1];
		Sts->FwdGainSet_2G				= tptr->BackUp.FwdGainSet_2G;

		Sts->FwdOutUpperLmt_LTE[0]		= tptr->BackUp.FwdOutUpperLmt_LTE[0];
		Sts->FwdOutUpperLmt_LTE[1]		= tptr->BackUp.FwdOutUpperLmt_LTE[1];
		Sts->FwdOutLowerLmt_LTE[0]		= tptr->BackUp.FwdOutLowerLmt_LTE[0];
		Sts->FwdOutLowerLmt_LTE[1]		= tptr->BackUp.FwdOutLowerLmt_LTE[1];
		Sts->FwdGainSet_LTE 			= tptr->BackUp.FwdGainSet_LTE;

		Sts->FwdOutUpperLmt_LTE_A1[0]	= tptr->BackUp.FwdOutUpperLmt_LTE_A1[0];
		Sts->FwdOutUpperLmt_LTE_A1[1]	= tptr->BackUp.FwdOutUpperLmt_LTE_A1[1];
		Sts->FwdOutLowerLmt_LTE_A1[0]	= tptr->BackUp.FwdOutLowerLmt_LTE_A1[0];
		Sts->FwdOutLowerLmt_LTE_A1[1]	= tptr->BackUp.FwdOutLowerLmt_LTE_A1[1];
		Sts->FwdGainSet_LTE_A1			= tptr->BackUp.FwdGainSet_LTE_A1;

		Sts->FwdOutUpperLmt_LTE_A2[0]	= tptr->BackUp.FwdOutUpperLmt_LTE_A2[0];
		Sts->FwdOutUpperLmt_LTE_A2[1]	= tptr->BackUp.FwdOutUpperLmt_LTE_A2[1];
		Sts->FwdOutLowerLmt_LTE_A2[0]	= tptr->BackUp.FwdOutLowerLmt_LTE_A2[0];
		Sts->FwdOutLowerLmt_LTE_A2[1]	= tptr->BackUp.FwdOutLowerLmt_LTE_A2[1];
		Sts->FwdGainSet_LTE_A2			= tptr->BackUp.FwdGainSet_LTE_A2;

		Sts->Rvs0GainSet_2G 			= tptr->BackUp.Rvs0GainSet_2G;
		Sts->RvsGainBalance_2G			= tptr->BackUp.RvsGainBalance_2G;
		Sts->Rvs0GainSet_LTE			= tptr->BackUp.Rvs0GainSet_LTE;
		Sts->RvsGainBalance_LTE 		= tptr->BackUp.RvsGainBalance_LTE;
		Sts->Rvs0GainSet_LTE_A1			= tptr->BackUp.Rvs0GainSet_LTE_A1;
		Sts->RvsGainBalance_LTE_A1		= tptr->BackUp.RvsGainBalance_LTE_A1;
		Sts->Rvs0GainSet_LTE_A2			= tptr->BackUp.Rvs0GainSet_LTE_A2;
		Sts->RvsGainBalance_LTE_A2		= tptr->BackUp.RvsGainBalance_LTE_A2;
		Sts->Rvs0GainSet_3G 			= tptr->BackUp.Rvs0GainSet_3G;
		Sts->RvsGainBalance_3G			= tptr->BackUp.RvsGainBalance_3G;


		Sts->FwdAmpOnOff_2G  			= tptr->BackUp.FwdAmpOnOff_2G;
		Sts->FwdAmpOnOff_LTE			= tptr->BackUp.FwdAmpOnOff_LTE;
		Sts->FwdAmpOnOff_LTE_A1			= tptr->BackUp.FwdAmpOnOff_LTE_A1;
		Sts->FwdAmpOnOff_LTE_A2			= tptr->BackUp.FwdAmpOnOff_LTE_A2;
		Sts->FwdAmpOnOff_3G 			= tptr->BackUp.FwdAmpOnOff_3G;
		Sts->FwdAmp1OnOff_LTE			= tptr->BackUp.FwdAmp1OnOff_LTE;
		Sts->FwdAmp1OnOff_LTE_A1		= tptr->BackUp.FwdAmp1OnOff_LTE_A1;
		Sts->FwdAmp1OnOff_LTE_A2		= tptr->BackUp.FwdAmp1OnOff_LTE_A2;

		Sts->AlmSts.FwdAmpOnOff_2G  	= Sts->FwdAmpOnOff_2G;	
		Sts->AlmSts.FwdAmpOnOff_LTE		= Sts->FwdAmpOnOff_LTE;		
		Sts->AlmSts.FwdAmpOnOff_LTE_A1	= Sts->FwdAmpOnOff_LTE_A1;
		Sts->AlmSts.FwdAmpOnOff_LTE_A2	= Sts->FwdAmpOnOff_LTE_A2;
		Sts->AlmSts.FwdAmpOnOff_3G 		= Sts->FwdAmpOnOff_3G;
		Sts->AlmSts.FwdAmp1OnOff_LTE	= Sts->FwdAmp1OnOff_LTE;
		Sts->AlmSts.FwdAmp1OnOff_LTE_A1	= Sts->FwdAmp1OnOff_LTE_A1;
		Sts->AlmSts.FwdAmp1OnOff_LTE_A2	= Sts->FwdAmp1OnOff_LTE_A2;


  	    Sts->LTE15MUse 					= tptr->BackUp.LTE15MUse;
		Sts->RepeatResetPriod 			= tptr->BackUp.RepeatResetPriod;

		Sts->Band_Select_LTE_A1 		= tptr->BackUp.Band_Select_LTE_A1;
		Sts->Band_Select_LTE_A2[0] 		= tptr->BackUp.Band_Select_LTE_A2[0];
		Sts->Band_Select_LTE_A2[1] 		= tptr->BackUp.Band_Select_LTE_A2[1];
		Sts->Band_Select_LTE_A2[2] 		= tptr->BackUp.Band_Select_LTE_A2[2];
		Sts->FemtocellUseOnOff.Data 	= tptr->BackUp.FemtocellUseOnOff;

/////////////////
		Sts->AGCOnOff_3G				= tptr->BackUp.AGCOnOff_3G;
		Sts->AGCOnOff_CDMALTE			= tptr->BackUp.AGCOnOff_CDMALTE;
		Sts->AGCOnOff_LTE_A_0			= tptr->BackUp.AGCOnOff_LTE_A_0;
		Sts->AGC1OnOff_LTE				= tptr->BackUp.AGC1OnOff_LTE;
		Sts->AGCOnOff_LTE_A_1			= tptr->BackUp.AGCOnOff_LTE_A_1;

		Sts->AGCMode_2G					= tptr->BackUp.AGCMode_2G;
		Sts->AGCMode_LTE				= tptr->BackUp.AGCMode_LTE;
		Sts->AGCMode_LTE_A1				= tptr->BackUp.AGCMode_LTE_A1;
		Sts->AGCMode_LTE_A2				= tptr->BackUp.AGCMode_LTE_A2;
		Sts->AGCMode_3G					= tptr->BackUp.AGCMode_3G;
		
/////////////////////////////

		Sts->AutoReportPriod			= tptr->BackUp.AutoReportPriod;
		Sts->AutoReportBasePer[0]		= tptr->BackUp.AutoReportBasePer[0];
		Sts->AutoReportBasePer[1]		= tptr->BackUp.AutoReportBasePer[1];
		Sts->TPTL_OnOff 				= tptr->BackUp.TPTL_OnOff;
		Sts->TempOffset 				= tptr->BackUp.TempOffset;
		Sts->AlarmMask					= tptr->BackUp.AlarmMask;
		Sts->VccDet_Lmt.Data			= tptr->BackUp.VccDet_Lmt.Data;

		Sts->FwdInPwrOffset_2G			= tptr->BackUp.FwdInPwrOffset_2G;
		Sts->FwdOutPwrOffset_2G 		= tptr->BackUp.FwdOutPwrOffset_2G;
		Sts->Rvs0OutPwrOffset_2G		= tptr->BackUp.Rvs0OutPwrOffset_2G;

		Sts->FwdInPwrOffset_LTE 		= tptr->BackUp.FwdInPwrOffset_LTE;
		Sts->FwdOutPwrOffset_LTE		= tptr->BackUp.FwdOutPwrOffset_LTE;
		Sts->RvsOutPwrOffset_LTE		= tptr->BackUp.RvsOutPwrOffset_LTE;
		
		Sts->FwdInPwrOffset_LTE_A1		= tptr->BackUp.FwdInPwrOffset_LTE_A1;
		Sts->FwdOutPwrOffset_LTE_A1		= tptr->BackUp.FwdOutPwrOffset_LTE_A1;
		Sts->RvsOutPwrOffset_LTE_A1		= tptr->BackUp.RvsOutPwrOffset_LTE_A1;

		Sts->FwdInPwrOffset_LTE_A2		= tptr->BackUp.FwdInPwrOffset_LTE_A2;
		Sts->FwdOutPwrOffset_LTE_A2		= tptr->BackUp.FwdOutPwrOffset_LTE_A2;
		Sts->RvsOutPwrOffset_LTE_A2		= tptr->BackUp.RvsOutPwrOffset_LTE_A2;
		
		Sts->FwdInPwrOffset_3G			= tptr->BackUp.FwdInPwrOffset_3G;
		Sts->Rvs0OutPwrOffset_3G		= tptr->BackUp.Rvs0OutPwrOffset_3G;
		Sts->FwdOutPwrOffset_3G 		= tptr->BackUp.FwdOutPwrOffset_3G;


		Sts->Fwd1InPwrOffset_LTE 		= tptr->BackUp.Fwd1InPwrOffset_LTE;
		Sts->Fwd1OutPwrOffset_LTE		= tptr->BackUp.Fwd1OutPwrOffset_LTE;
		Sts->Rvs1OutPwrOffset_LTE		= tptr->BackUp.Rvs1OutPwrOffset_LTE;


		Sts->Fwd1InPwrOffset_LTE_A1		= tptr->BackUp.Fwd1InPwrOffset_LTE_A1;
		Sts->Fwd1OutPwrOffset_LTE_A1 	= tptr->BackUp.Fwd1OutPwrOffset_LTE_A1;
		Sts->Rvs1OutPwrOffset_LTE_A1 	= tptr->BackUp.Rvs1OutPwrOffset_LTE_A1;

		Sts->Fwd1InPwrOffset_LTE_A2		= tptr->BackUp.Fwd1InPwrOffset_LTE_A2;
		Sts->Fwd1OutPwrOffset_LTE_A2 	= tptr->BackUp.Fwd1OutPwrOffset_LTE_A2;
		Sts->Rvs1OutPwrOffset_LTE_A2 	= tptr->BackUp.Rvs1OutPwrOffset_LTE_A2;

		memcpy((INT8U*)&Sts->DetOffset, (INT8U*)&tptr->BackUp.DetOffset, sizeof(__DET));

		
		Sts->FwdGainOffset_2G			= tptr->BackUp.FwdGainOffset_2G;
		Sts->RvsGainOffset_2G			= tptr->BackUp.RvsGainOffset_2G;
		
		Sts->FwdGainOffset_LTE			= tptr->BackUp.FwdGainOffset_LTE;
		Sts->RvsGainOffset_LTE			= tptr->BackUp.RvsGainOffset_LTE;
		
		Sts->FwdGainOffset_LTE_A1		= tptr->BackUp.FwdGainOffset_LTE_A1;
		Sts->RvsGainOffset_LTE_A1		= tptr->BackUp.RvsGainOffset_LTE_A1;

		Sts->FwdGainOffset_LTE_A2		= tptr->BackUp.FwdGainOffset_LTE_A2;
		Sts->RvsGainOffset_LTE_A2		= tptr->BackUp.RvsGainOffset_LTE_A2;
		
		Sts->FwdGainOffset_3G			= tptr->BackUp.FwdGainOffset_3G;
		Sts->RvsGainOffset_3G			= tptr->BackUp.RvsGainOffset_3G;
		
		Sts->Fwd1GainOffset_LTE 		= tptr->BackUp.Fwd1GainOffset_LTE;
		Sts->Rvs1GainOffset_LTE 		= tptr->BackUp.Rvs1GainOffset_LTE;
		
		Sts->Fwd1GainOffset_LTE_A1		= tptr->BackUp.Fwd1GainOffset_LTE_A1;
		Sts->Rvs1GainOffset_LTE_A1		= tptr->BackUp.Rvs1GainOffset_LTE_A1;

		Sts->Fwd1GainOffset_LTE_A2		= tptr->BackUp.Fwd1GainOffset_LTE_A2;
		Sts->Rvs1GainOffset_LTE_A2		= tptr->BackUp.Rvs1GainOffset_LTE_A2;

		Sts->Fwd1OutUpperLmt_LTE[0]		= tptr->BackUp.Fwd1OutUpperLmt_LTE[0];
		Sts->Fwd1OutUpperLmt_LTE[1]		= tptr->BackUp.Fwd1OutUpperLmt_LTE[1];
		Sts->Fwd1OutLowerLmt_LTE[0]		= tptr->BackUp.Fwd1OutLowerLmt_LTE[0];
		Sts->Fwd1OutLowerLmt_LTE[1]		= tptr->BackUp.Fwd1OutLowerLmt_LTE[1];
		Sts->Fwd1OutUpperLmt_LTE_A1[0]	= tptr->BackUp.Fwd1OutUpperLmt_LTE_A1[0];
		Sts->Fwd1OutUpperLmt_LTE_A1[1]	= tptr->BackUp.Fwd1OutUpperLmt_LTE_A1[1];
		Sts->Fwd1OutLowerLmt_LTE_A1[0]	= tptr->BackUp.Fwd1OutLowerLmt_LTE_A1[0];
		Sts->Fwd1OutLowerLmt_LTE_A1[1]	= tptr->BackUp.Fwd1OutLowerLmt_LTE_A1[1];

		Sts->Fwd1OutUpperLmt_LTE_A2[0]	= tptr->BackUp.Fwd1OutUpperLmt_LTE_A2[0];
		Sts->Fwd1OutUpperLmt_LTE_A2[1]	= tptr->BackUp.Fwd1OutUpperLmt_LTE_A2[1];
		Sts->Fwd1OutLowerLmt_LTE_A2[0]	= tptr->BackUp.Fwd1OutLowerLmt_LTE_A2[0];
		Sts->Fwd1OutLowerLmt_LTE_A2[1]	= tptr->BackUp.Fwd1OutLowerLmt_LTE_A2[1];


		Sts->Fwd1GainSet_LTE			= tptr->BackUp.Fwd1GainSet_LTE;
		Sts->Fwd1GainSet_LTE_A1			= tptr->BackUp.Fwd1GainSet_LTE_A1;
		Sts->Fwd1GainSet_LTE_A2			= tptr->BackUp.Fwd1GainSet_LTE_A2;

		Sts->Rvs1GainSet_LTE			= tptr->BackUp.Rvs1GainSet_LTE;
		Sts->Rvs1GainBalance_LTE		= tptr->BackUp.Rvs1GainBalance_LTE;

		Sts->Rvs1GainSet_LTE_A1			= tptr->BackUp.Rvs1GainSet_LTE_A1;
		Sts->Rvs1GainBalance_LTE_A1		= tptr->BackUp.Rvs1GainBalance_LTE_A1;

		Sts->Rvs1GainSet_LTE_A2 		= tptr->BackUp.Rvs1GainSet_LTE_A2;
		Sts->Rvs1GainBalance_LTE_A2 	= tptr->BackUp.Rvs1GainBalance_LTE_A2;


		memcpy((INT8U*)&Sts->Det1Offset, (INT8U*)&tptr->BackUp.Det1Offset, sizeof(__DET1));
///////////////////////////////// Wave
		Sts->WaveCtrl.RxMaxVal[0]				= tptr->BackUp.RxMaxVal[0];
		Sts->WaveCtrl.RxMaxVal[1]				= tptr->BackUp.RxMaxVal[1];
		Sts->WaveCtrl.RxMinVal[0]				= tptr->BackUp.RxMinVal[0];
		Sts->WaveCtrl.RxMinVal[1]				= tptr->BackUp.RxMinVal[1];
		Sts->WaveCtrl.TxMaxVal[0]				= tptr->BackUp.TxMaxVal[0];
		Sts->WaveCtrl.TxMaxVal[1]				= tptr->BackUp.TxMaxVal[1];
		Sts->WaveCtrl.TxMinVal[0]				= tptr->BackUp.TxMinVal[0];
		Sts->WaveCtrl.TxMinVal[1]				= tptr->BackUp.TxMinVal[1];

		Sts->WaveCtrl.EcIo						= tptr->BackUp.EcIo;
		Sts->WaveCtrl.AR_Mode[0] 				= tptr->BackUp.AR_Mode[0];
		Sts->WaveCtrl.AR_Mode[1] 				= tptr->BackUp.AR_Mode[1];
		Sts->WaveCtrl.Radio_ReportTime[0]		= tptr->BackUp.Radio_ReportTime[0];
		Sts->WaveCtrl.Radio_ReportTime[1]		= tptr->BackUp.Radio_ReportTime[1];
		Sts->WaveCtrl.Radio_ReportPeriod[0]		= tptr->BackUp.Radio_ReportPeriod[0];
		Sts->WaveCtrl.Radio_ReportPeriod[1]		= tptr->BackUp.Radio_ReportPeriod[1];

		iMasterPNH = tptr->BackUp.MasterPNH;
		iMasterPNL = tptr->BackUp.MasterPNL;
		
		Sts->WaveCtrl.RxMaxVal[0] = tptr->BackUp.RxMaxVal[0];
		Sts->WaveCtrl.RxMaxVal[1] = tptr->BackUp.RxMaxVal[1];
		Sts->WaveCtrl.RxMinVal[0] = tptr->BackUp.RxMinVal[0];
		Sts->WaveCtrl.RxMinVal[1] = tptr->BackUp.RxMinVal[1];
		Sts->WaveCtrl.TxMaxVal[0] = tptr->BackUp.TxMaxVal[0];
		Sts->WaveCtrl.TxMaxVal[1] = tptr->BackUp.TxMaxVal[1];
		Sts->WaveCtrl.TxMinVal[0] = tptr->BackUp.TxMinVal[0];
		Sts->WaveCtrl.TxMinVal[1] = tptr->BackUp.TxMinVal[1];
	
		for(i = 0;i < 11;i++)
		{	
			Sts->HostNumber[i]			=	tptr->BackUp.HostNumber[i];
			Sts->WaveCtrl.TestStn[i]	=	tptr->BackUp.TestStn[i];
			Sts->TestStn[i] 			=	Sts->WaveCtrl.TestStn[i];
		}	
		memcpy((INT8U*)&Sts->TestStn, 	(INT8U*)&tptr->BackUp.TestStn, sizeof(Sts->TestStn));
		memcpy((INT8U*)&Sts->HostNumber, (INT8U*)&tptr->BackUp.HostNumber, sizeof(Sts->HostNumber));

		tDnrSts->AutoReportPriod		= tptr->BackUp.AutoReportPriod;
		tDnrSts->AutoReportBasePer[0] 	= tptr->BackUp.AutoReportBasePer[0];
		tDnrSts->AutoReportBasePer[1] 	= tptr->BackUp.AutoReportBasePer[1];;

		tDnrSts->AlarmMask 				= tptr->BackUp.AlarmMask;
		
		///////////////////////////////////////////////////////////////////////
		tDnrSts->RvsALCLvl_2G 		= tmpRvsALCLvl_2G		= tptr->BackUp.RvsALCLvl_2G;
		tDnrSts->RvsALCLvl_LTE		= tmpRvsALCLvl_LTE		= tptr->BackUp.RvsALCLvl_LTE;
		tDnrSts->RvsALCLvl_LTE_A1 	= tmpRvsALCLvl_LTE_A1	= tptr->BackUp.RvsALCLvl_LTE_A1;
		tDnrSts->RvsALCLvl_LTE_A2 	= tmpRvsALCLvl_LTE_A2	= tptr->BackUp.RvsALCLvl_LTE_A2;
		tDnrSts->RvsALCLvl_3G 		= tmpRvsALCLvl_3G		= tptr->BackUp.RvsALCLvl_3G;
		tDnrSts->Rvs1ALCLvl_LTE		= tmpRvs1ALCLvl_LTE		= tptr->BackUp.Rvs1ALCLvl_LTE;
		tDnrSts->Rvs1ALCLvl_LTE_A1	= tmpRvs1ALCLvl_LTE_A1	= tptr->BackUp.Rvs1ALCLvl_LTE_A1;
		tDnrSts->Rvs1ALCLvl_LTE_A2	= tmpRvs1ALCLvl_LTE_A2	= tptr->BackUp.Rvs1ALCLvl_LTE_A2;

		tDnrSts->DCOffSet			= tptr->BackUp.DCOffSet;
		tDnrSts->PllFregOffset_LTE	= tptr->BackUp.PllFregOffset_LTE;
///////////////////////////////20130319
#if 0
		Sts->SleepMode_2G.SleepMode_OnOff			= tptr->BackUp.SleepMode_2G.SleepMode_OnOff;
		Sts->SleepMode_2G.SleepModeOnVolt.Data 		= tptr->BackUp.SleepMode_2G.SleepModeOnVolt.Data;
		Sts->SleepMode_2G.SleepModeOffVolt.Data 	= tptr->BackUp.SleepMode_2G.SleepModeOffVolt.Data;

		Sts->SleepMode_LTE.SleepMode_OnOff			= tptr->BackUp.SleepMode_LTE.SleepMode_OnOff;
		Sts->SleepMode_LTE.SleepModeOnVolt.Data 	= tptr->BackUp.SleepMode_LTE.SleepModeOnVolt.Data;
		Sts->SleepMode_LTE.SleepModeOffVolt.Data 	= tptr->BackUp.SleepMode_LTE.SleepModeOffVolt.Data;

		Sts->SleepMode_LTE_A1.SleepMode_OnOff		= tptr->BackUp.SleepMode_LTE_A1.SleepMode_OnOff;
		Sts->SleepMode_LTE_A1.SleepModeOnVolt.Data 	= tptr->BackUp.SleepMode_LTE_A1.SleepModeOnVolt.Data;
		Sts->SleepMode_LTE_A1.SleepModeOffVolt.Data = tptr->BackUp.SleepMode_LTE_A1.SleepModeOffVolt.Data;

		Sts->SleepMode_LTE_A2.SleepMode_OnOff		= tptr->BackUp.SleepMode_LTE_A2.SleepMode_OnOff;
		Sts->SleepMode_LTE_A2.SleepModeOnVolt.Data 	= tptr->BackUp.SleepMode_LTE_A2.SleepModeOnVolt.Data;
		Sts->SleepMode_LTE_A2.SleepModeOffVolt.Data = tptr->BackUp.SleepMode_LTE_A2.SleepModeOffVolt.Data;

#endif



		///////////////////////////////20130319

		Sts->ResetCase = rambackup[0];
		rambackup[0] = 0;
		
		if((Sts->ResetCase != UserReset) && (Sts->ResetCase != FWDownReset))
		{
			Sts->ResetCase = PowerReset;
		}
		
		Sts->ResetCase = Sts->ResetCase;

		if(rval) WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
	}
	OSSemPost(CtrlSem);

	if(Sts->AGCOnOff_CDMALTE == Disable)
	{
		Sts->FwdAgcAttn_2G 			= GainAttnCalculation(Sts->FwdGainSet_2G,Gain_2G,ATTENMIN);
		Sts->RvsGainAttn_2G 		= GainAttnCalculation(Sts->Rvs0GainSet_2G,Gain_2G,ATTENMIN);
		Sts->FwdAgcAttn_LTE 		= GainAttnCalculation(Sts->FwdGainSet_LTE,Gain_LTE,ATTENMIN);
		Sts->RvsGainAttn_LTE		= GainAttnCalculation(Sts->Rvs0GainSet_LTE,Gain_LTE,ATTENMIN);
	}
	else
	{
		Sts->FwdAgcAttn_2G 			= FwdMinGain_2G;
		Sts->RvsGainAttn_2G 		= RvsMinGain_2G;
		Sts->FwdAgcAttn_LTE 		= FwdMinGain_LTE;
		Sts->RvsGainAttn_LTE		= RvsMinGain_LTE;

		Sts->FwdAttn1_2G = DIGATTENMAX;
		Sts->FwdAttn2_2G = DIGATTENMAX;
	
		Sts->FwdAttn1_LTE = DIGATTENMAX;
		Sts->FwdAttn2_LTE = DIGATTENMAX;
	}

	
	
	if(Sts->AGCOnOff_LTE_A_0 == Disable)
	{
		Sts->FwdAgcAttn_LTE_A1		= GainAttnCalculation(Sts->FwdGainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
		Sts->RvsGainAttn_LTE_A1 	= GainAttnCalculation(Sts->Rvs0GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
		Sts->FwdAgcAttn_LTE_A2		= GainAttnCalculation(Sts->FwdGainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
		Sts->RvsGainAttn_LTE_A2 	= GainAttnCalculation(Sts->Rvs0GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
	}
	else
	{
		Sts->FwdAgcAttn_LTE_A1		= FwdMinGain_LTE_A;
		Sts->RvsGainAttn_LTE_A1 	= RvsMinGain_LTE_A;
		Sts->FwdAgcAttn_LTE_A2		= FwdMinGain_LTE_A;
		Sts->RvsGainAttn_LTE_A2 	= RvsMinGain_LTE_A;

		Sts->FwdAttn1_LTE_A1 = DIGATTENMAX;
		Sts->FwdAttn2_LTE_A1 = DIGATTENMAX;
		Sts->FwdAttn1_LTE_A2 = DIGATTENMAX;
		Sts->FwdAttn2_LTE_A2 = DIGATTENMAX;
	}

	if(Sts->AGCOnOff_3G == Disable)
	{
		Sts->FwdAgcAttn_3G 		= GainAttnCalculation(Sts->FwdGainSet_3G,Gain_3G,ATTENMIN);
		Sts->RvsGainAttn_3G 	= GainAttnCalculation(Sts->Rvs0GainSet_3G,Gain_3G,ATTENMIN);
	}
	else
	{
		Sts->FwdAgcAttn_3G 		= FwdMinGain_3G;
		Sts->RvsGainAttn_3G 	= RvsMinGain_3G;

		Sts->FwdAttn1_3G 		= DIGATTENMAX;
		Sts->FwdAttn2_3G 		= DIGATTENMAX;
	}


	if(Sts->AGC1OnOff_LTE  == Disable)
	{
		Sts->Fwd1AgcAttn_LTE		= GainAttnCalculation(Sts->Fwd1GainSet_LTE,Gain_LTE,ATTENMIN);
		Sts->Rvs1GainAttn_LTE		= GainAttnCalculation(Sts->Rvs1GainSet_LTE,Gain_LTE,ATTENMIN);
	}
	else
	{
		Sts->Fwd1AgcAttn_LTE		= FwdMinGain_LTE;
		Sts->Rvs1GainAttn_LTE		= RvsMinGain_LTE;

		
		Sts->Fwd1Attn1_LTE = DIGATTENMAX;
		Sts->Fwd1Attn2_LTE = DIGATTENMAX;
	}
	
	if(Sts->AGCOnOff_LTE_A_0 == Disable)
	{
		Sts->Fwd1AgcAttn_LTE_A1		= GainAttnCalculation(Sts->Fwd1GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
		Sts->Rvs1GainAttn_LTE_A1	= GainAttnCalculation(Sts->Rvs1GainSet_LTE_A1,Gain_LTE_A,ATTENMIN);
		Sts->Fwd1AgcAttn_LTE_A2 	= GainAttnCalculation(Sts->Fwd1GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
		Sts->Rvs1GainAttn_LTE_A2   	= GainAttnCalculation(Sts->Rvs1GainSet_LTE_A2,Gain_LTE_A,ATTENMIN);
	}
	else
	{
		Sts->Fwd1AgcAttn_LTE_A1		= FwdMinGain_LTE_A;
		Sts->Rvs1GainAttn_LTE_A1 	= RvsMinGain_LTE_A;
		Sts->Fwd1AgcAttn_LTE_A2		= FwdMinGain_LTE_A;
		Sts->Rvs1GainAttn_LTE_A2 	= RvsMinGain_LTE_A;
		Sts->Fwd1Attn1_LTE_A1 = DIGATTENMAX;
		Sts->Fwd1Attn2_LTE_A1 = DIGATTENMAX;

		Sts->Fwd1Attn1_LTE_A2 = DIGATTENMAX;
		Sts->Fwd1Attn2_LTE_A2 = DIGATTENMAX;
	}


	Sts->FwdAttn1_CDMALTE = DIGATTENMAX;
	Sts->RvsAttn1_CDMALTE = DIGATTENMAX;
	Sts->FwdAttn1_LTE_A = DIGATTENMAX;
	Sts->RvsAttn1_LTE_A = DIGATTENMAX;

	Sts->Fwd1Attn1_LTE_A = DIGATTENMAX;
	Sts->Rvs1Attn1_LTE_A = DIGATTENMAX;
}


void SaveBackupData(void)
{
	__Dnr_Sts *Sts = tDnrSts;

   	INT32U cpu_sr;

	OS_ENTER_CRITICAL();
	{
		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);

		tptr->BackUp.FwdOutUpperLmt_3G[0]	= Sts->FwdOutUpperLmt_3G[0];
		tptr->BackUp.FwdOutUpperLmt_3G[1]	= Sts->FwdOutUpperLmt_3G[1];
		tptr->BackUp.FwdOutLowerLmt_3G[0]	= Sts->FwdOutLowerLmt_3G[0];
		tptr->BackUp.FwdOutLowerLmt_3G[1]	= Sts->FwdOutLowerLmt_3G[1];
		tptr->BackUp.FwdGainSet_3G			= Sts->FwdGainSet_3G;

		tptr->BackUp.FwdOutUpperLmt_2G[0]	= Sts->FwdOutUpperLmt_2G[0];
		tptr->BackUp.FwdOutUpperLmt_2G[1]	= Sts->FwdOutUpperLmt_2G[1];
		tptr->BackUp.FwdOutLowerLmt_2G[0]	= Sts->FwdOutLowerLmt_2G[0];
		tptr->BackUp.FwdOutLowerLmt_2G[1]	= Sts->FwdOutLowerLmt_2G[1];
		tptr->BackUp.FwdGainSet_2G			= Sts->FwdGainSet_2G;

		tptr->BackUp.FwdOutUpperLmt_LTE[0]	= Sts->FwdOutUpperLmt_LTE[0];
		tptr->BackUp.FwdOutUpperLmt_LTE[1]	= Sts->FwdOutUpperLmt_LTE[1];
		tptr->BackUp.FwdOutLowerLmt_LTE[0]	= Sts->FwdOutLowerLmt_LTE[0];
		tptr->BackUp.FwdOutLowerLmt_LTE[1]	= Sts->FwdOutLowerLmt_LTE[1];
		tptr->BackUp.FwdGainSet_LTE 		= Sts->FwdGainSet_LTE;

		tptr->BackUp.FwdOutUpperLmt_LTE_A1[0]= Sts->FwdOutUpperLmt_LTE_A1[0];
		tptr->BackUp.FwdOutUpperLmt_LTE_A1[1]= Sts->FwdOutUpperLmt_LTE_A1[1];
		tptr->BackUp.FwdOutLowerLmt_LTE_A1[0]= Sts->FwdOutLowerLmt_LTE_A1[0];
		tptr->BackUp.FwdOutLowerLmt_LTE_A1[1]= Sts->FwdOutLowerLmt_LTE_A1[1];
		tptr->BackUp.FwdGainSet_LTE_A1		= Sts->FwdGainSet_LTE_A1;

		tptr->BackUp.FwdOutUpperLmt_LTE_A2[0]= Sts->FwdOutUpperLmt_LTE_A2[0];
		tptr->BackUp.FwdOutUpperLmt_LTE_A2[1]= Sts->FwdOutUpperLmt_LTE_A2[1];
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[0]= Sts->FwdOutLowerLmt_LTE_A2[0];
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[1]= Sts->FwdOutLowerLmt_LTE_A2[1];
		tptr->BackUp.FwdGainSet_LTE_A2		= Sts->FwdGainSet_LTE_A2;

		tptr->BackUp.Rvs0GainSet_3G 		= Sts->Rvs0GainSet_3G;
		tptr->BackUp.RvsGainBalance_3G		= Sts->RvsGainBalance_3G;
		
		tptr->BackUp.Rvs0GainSet_2G 		= Sts->Rvs0GainSet_2G;
		tptr->BackUp.RvsGainBalance_2G		= Sts->RvsGainBalance_2G;
		
		tptr->BackUp.Rvs0GainSet_LTE		= Sts->Rvs0GainSet_LTE;
		tptr->BackUp.RvsGainBalance_LTE 	= Sts->RvsGainBalance_LTE;
		
		tptr->BackUp.Rvs0GainSet_LTE_A1		= Sts->Rvs0GainSet_LTE_A1;
		tptr->BackUp.RvsGainBalance_LTE_A1	= Sts->RvsGainBalance_LTE_A1;

		tptr->BackUp.Rvs0GainSet_LTE_A2		= Sts->Rvs0GainSet_LTE_A2;
		tptr->BackUp.RvsGainBalance_LTE_A2	= Sts->RvsGainBalance_LTE_A2;

		tptr->BackUp.FwdAmpOnOff_2G 		= RefFwdAmpOnOff_2G;
		tptr->BackUp.FwdAmpOnOff_LTE		= RefFwdAmpOnOff_LTE;
		tptr->BackUp.FwdAmpOnOff_LTE_A1 	= RefFwdAmpOnOff_LTE_A1;
		tptr->BackUp.FwdAmpOnOff_LTE_A2 	= RefFwdAmpOnOff_LTE_A2;
		tptr->BackUp.FwdAmpOnOff_3G 		= RefFwdAmpOnOff_3G;
		tptr->BackUp.FwdAmp1OnOff_LTE		= RefFwdAmp1OnOff_LTE;
		tptr->BackUp.FwdAmp1OnOff_LTE_A1	= RefFwdAmp1OnOff_LTE_A2;
		tptr->BackUp.FwdAmp1OnOff_LTE_A2	= RefFwdAmp1OnOff_LTE_A2;
		
		tptr->BackUp.LTE15MUse 				= Sts->LTE15MUse;
		tptr->BackUp.RepeatResetPriod 		= Sts->RepeatResetPriod;

		tptr->BackUp.Band_Select_LTE_A1		= Sts->Band_Select_LTE_A1;

		tptr->BackUp.Band_Select_LTE_A2[0] 	= Sts->Band_Select_LTE_A2[0];
		tptr->BackUp.Band_Select_LTE_A2[1] 	= Sts->Band_Select_LTE_A2[1];
		tptr->BackUp.Band_Select_LTE_A2[2] 	= Sts->Band_Select_LTE_A2[2];

		tptr->BackUp.FemtocellUseOnOff 		= Sts->FemtocellUseOnOff.Data;
/////////////////////////////////////////////////////////////

		tptr->BackUp.AGCOnOff_3G			= Sts->AGCOnOff_3G;
		tptr->BackUp.AGCOnOff_CDMALTE		= Sts->AGCOnOff_CDMALTE;
		tptr->BackUp.AGCOnOff_LTE_A_0 		= Sts->AGCOnOff_LTE_A_0;
		tptr->BackUp.AGC1OnOff_LTE			= Sts->AGC1OnOff_LTE;
		tptr->BackUp.AGCOnOff_LTE_A_1		= Sts->AGCOnOff_LTE_A_1;

		tptr->BackUp.AGCMode_3G 			= Sts->AGCMode_3G;
		tptr->BackUp.AGCMode_2G 			= Sts->AGCMode_2G;
		tptr->BackUp.AGCMode_LTE			= Sts->AGCMode_LTE;
		tptr->BackUp.AGCMode_LTE_A1			= Sts->AGCMode_LTE_A1;
		tptr->BackUp.AGCMode_LTE_A2			= Sts->AGCMode_LTE_A2;
		
/////////////////////////////////////////////////////

		tptr->BackUp.AutoReportPriod		= Sts->AutoReportPriod;
		tptr->BackUp.AutoReportBasePer[0]	= Sts->AutoReportBasePer[0];
		tptr->BackUp.AutoReportBasePer[1]	= Sts->AutoReportBasePer[1];
		tptr->BackUp.TPTL_OnOff 			= Sts->TPTL_OnOff;
		tptr->BackUp.TempOffset 			= Sts->TempOffset;
		tptr->BackUp.AlarmMask				= Sts->AlarmMask;
		tptr->BackUp.VccDet_Lmt.Data		= Sts->VccDet_Lmt.Data;
		
		tptr->BackUp.FwdInPwrOffset_2G		= Sts->FwdInPwrOffset_2G;
		tptr->BackUp.FwdOutPwrOffset_2G 	= Sts->FwdOutPwrOffset_2G;
		tptr->BackUp.Rvs0OutPwrOffset_2G	= Sts->Rvs0OutPwrOffset_2G;

		tptr->BackUp.FwdInPwrOffset_3G		= Sts->FwdInPwrOffset_3G;
		tptr->BackUp.Rvs0OutPwrOffset_3G	= Sts->Rvs0OutPwrOffset_3G;
		tptr->BackUp.FwdOutPwrOffset_3G 	= Sts->FwdOutPwrOffset_3G;

		tptr->BackUp.FwdInPwrOffset_LTE 	= Sts->FwdInPwrOffset_LTE;
		tptr->BackUp.FwdOutPwrOffset_LTE	= Sts->FwdOutPwrOffset_LTE;
		tptr->BackUp.RvsOutPwrOffset_LTE	= Sts->RvsOutPwrOffset_LTE;

		tptr->BackUp.FwdInPwrOffset_LTE_A1	= Sts->FwdInPwrOffset_LTE_A1;
		tptr->BackUp.FwdOutPwrOffset_LTE_A1	= Sts->FwdOutPwrOffset_LTE_A1;
		tptr->BackUp.RvsOutPwrOffset_LTE_A1	= Sts->RvsOutPwrOffset_LTE_A1;

		tptr->BackUp.FwdInPwrOffset_LTE_A2	= Sts->FwdInPwrOffset_LTE_A2;
		tptr->BackUp.FwdOutPwrOffset_LTE_A2	= Sts->FwdOutPwrOffset_LTE_A2;
		tptr->BackUp.RvsOutPwrOffset_LTE_A2	= Sts->RvsOutPwrOffset_LTE_A2;

		tptr->BackUp.FwdGainOffset_2G		= Sts->FwdGainOffset_2G;
		tptr->BackUp.RvsGainOffset_2G		= Sts->RvsGainOffset_2G;

		tptr->BackUp.FwdGainOffset_LTE		= Sts->FwdGainOffset_LTE;
		tptr->BackUp.RvsGainOffset_LTE		= Sts->RvsGainOffset_LTE;
		
		tptr->BackUp.FwdGainOffset_LTE_A1	= Sts->FwdGainOffset_LTE_A1;
		tptr->BackUp.RvsGainOffset_LTE_A1	= Sts->RvsGainOffset_LTE_A1;

		tptr->BackUp.FwdGainOffset_LTE_A2	= Sts->FwdGainOffset_LTE_A2;
		tptr->BackUp.RvsGainOffset_LTE_A2	= Sts->RvsGainOffset_LTE_A2;
		
		tptr->BackUp.FwdGainOffset_3G		= Sts->FwdGainOffset_3G;
		tptr->BackUp.RvsGainOffset_3G		= Sts->RvsGainOffset_3G;

		memcpy((INT8U*)&tptr->BackUp.DetOffset, (INT8U*)&Sts->DetOffset, sizeof(Sts->DetOffset));
		memcpy((INT8U*)&tptr->BackUp.Det1Offset, (INT8U*)&Sts->Det1Offset, sizeof(Sts->Det1Offset));

////////////////////////////////////////////////////

		tptr->BackUp.Fwd1OutUpperLmt_LTE[0] = Sts->Fwd1OutUpperLmt_LTE[0];
		tptr->BackUp.Fwd1OutUpperLmt_LTE[1] = Sts->Fwd1OutUpperLmt_LTE[1];
		tptr->BackUp.Fwd1OutLowerLmt_LTE[0] = Sts->Fwd1OutLowerLmt_LTE[0];
		tptr->BackUp.Fwd1OutLowerLmt_LTE[1] = Sts->Fwd1OutLowerLmt_LTE[1];
		tptr->BackUp.Fwd1GainSet_LTE			= Sts->Fwd1GainSet_LTE;
		
		tptr->BackUp.Fwd1OutUpperLmt_LTE_A1[0]	= Sts->Fwd1OutUpperLmt_LTE_A1[0];
		tptr->BackUp.Fwd1OutUpperLmt_LTE_A1[1]	= Sts->Fwd1OutUpperLmt_LTE_A1[1];
		tptr->BackUp.Fwd1OutLowerLmt_LTE_A1[0]	= Sts->Fwd1OutLowerLmt_LTE_A1[0];
		tptr->BackUp.Fwd1OutLowerLmt_LTE_A1[1]	= Sts->Fwd1OutLowerLmt_LTE_A1[1];
		tptr->BackUp.Fwd1GainSet_LTE_A1			= Sts->Fwd1GainSet_LTE_A1;

		tptr->BackUp.Fwd1OutUpperLmt_LTE_A2[0]	= Sts->Fwd1OutUpperLmt_LTE_A2[0];
		tptr->BackUp.Fwd1OutUpperLmt_LTE_A2[1]	= Sts->Fwd1OutUpperLmt_LTE_A2[1];
		tptr->BackUp.Fwd1OutLowerLmt_LTE_A2[0]	= Sts->Fwd1OutLowerLmt_LTE_A2[0];
		tptr->BackUp.Fwd1OutLowerLmt_LTE_A2[1]	= Sts->Fwd1OutLowerLmt_LTE_A2[1];
		tptr->BackUp.Fwd1GainSet_LTE_A2			= Sts->Fwd1GainSet_LTE_A2;

		tptr->BackUp.Rvs1GainSet_LTE		= Sts->Rvs1GainSet_LTE;
		tptr->BackUp.Rvs1GainBalance_LTE	= Sts->Rvs1GainBalance_LTE;
		tptr->BackUp.Rvs1GainSet_LTE_A1		= Sts->Rvs1GainSet_LTE_A1;
		tptr->BackUp.Rvs1GainBalance_LTE_A1	= Sts->Rvs1GainBalance_LTE_A1;
		tptr->BackUp.Rvs1GainSet_LTE_A2		= Sts->Rvs1GainSet_LTE_A2;
		tptr->BackUp.Rvs1GainBalance_LTE_A2	= Sts->Rvs1GainBalance_LTE_A2;

		tptr->BackUp.Fwd1InPwrOffset_LTE 	= Sts->Fwd1InPwrOffset_LTE;
		tptr->BackUp.Fwd1OutPwrOffset_LTE	= Sts->Fwd1OutPwrOffset_LTE;
		tptr->BackUp.Rvs1OutPwrOffset_LTE	= Sts->Rvs1OutPwrOffset_LTE;

		tptr->BackUp.Fwd1InPwrOffset_LTE_A1	= Sts->Fwd1InPwrOffset_LTE_A1;
		tptr->BackUp.Fwd1OutPwrOffset_LTE_A1 = Sts->Fwd1OutPwrOffset_LTE_A1;
		tptr->BackUp.Rvs1OutPwrOffset_LTE_A1 = Sts->Rvs1OutPwrOffset_LTE_A1;

		tptr->BackUp.Fwd1InPwrOffset_LTE_A2	= Sts->Fwd1InPwrOffset_LTE_A2;
		tptr->BackUp.Fwd1OutPwrOffset_LTE_A2 = Sts->Fwd1OutPwrOffset_LTE_A2;
		tptr->BackUp.Rvs1OutPwrOffset_LTE_A2 = Sts->Rvs1OutPwrOffset_LTE_A2;
		
		tptr->BackUp.Fwd1GainOffset_LTE 	= Sts->Fwd1GainOffset_LTE;
		tptr->BackUp.Rvs1GainOffset_LTE 	= Sts->Rvs1GainOffset_LTE;
		tptr->BackUp.Fwd1GainOffset_LTE_A1	= Sts->Fwd1GainOffset_LTE_A1;
		tptr->BackUp.Rvs1GainOffset_LTE_A1	= Sts->Rvs1GainOffset_LTE_A1;
		tptr->BackUp.Fwd1GainOffset_LTE_A2	= Sts->Fwd1GainOffset_LTE_A2;
		tptr->BackUp.Rvs1GainOffset_LTE_A2	= Sts->Rvs1GainOffset_LTE_A2;

		tptr->BackUp.RxMaxVal[0]			= Sts->WaveCtrl.RxMaxVal[0];
		tptr->BackUp.RxMaxVal[1]			= Sts->WaveCtrl.RxMaxVal[1];
		tptr->BackUp.RxMinVal[0]			= Sts->WaveCtrl.RxMinVal[0];
		tptr->BackUp.RxMinVal[1]			= Sts->WaveCtrl.RxMinVal[1];
		tptr->BackUp.TxMaxVal[0]			= Sts->WaveCtrl.TxMaxVal[0];
		tptr->BackUp.TxMaxVal[1]			= Sts->WaveCtrl.TxMaxVal[1];
		tptr->BackUp.TxMinVal[0]			= Sts->WaveCtrl.TxMinVal[0];
		tptr->BackUp.TxMinVal[1]			= Sts->WaveCtrl.TxMinVal[1];

		tptr->BackUp.EcIo					= Sts->WaveCtrl.EcIo;
		tptr->BackUp.AR_Mode[0] 			= Sts->WaveCtrl.AR_Mode[0];
		tptr->BackUp.AR_Mode[1] 			= Sts->WaveCtrl.AR_Mode[1];
		tptr->BackUp.Radio_ReportTime[0]	= Sts->WaveCtrl.Radio_ReportTime[0];
		tptr->BackUp.Radio_ReportTime[1]	= Sts->WaveCtrl.Radio_ReportTime[1];
		tptr->BackUp.Radio_ReportPeriod[0]	= Sts->WaveCtrl.Radio_ReportPeriod[0];
		tptr->BackUp.Radio_ReportPeriod[1]	= Sts->WaveCtrl.Radio_ReportPeriod[1];

		tptr->BackUp.RvsALCLvl_2G			= Sts->RvsALCLvl_2G;
		tptr->BackUp.RvsALCLvl_LTE 			= Sts->RvsALCLvl_LTE;
		tptr->BackUp.RvsALCLvl_LTE_A1		= Sts->RvsALCLvl_LTE_A1;
		tptr->BackUp.RvsALCLvl_LTE_A2		= Sts->RvsALCLvl_LTE_A2;
		tptr->BackUp.RvsALCLvl_3G			= Sts->RvsALCLvl_3G;
		tptr->BackUp.Rvs1ALCLvl_LTE			= Sts->Rvs1ALCLvl_LTE;
		tptr->BackUp.Rvs1ALCLvl_LTE_A1		= Sts->Rvs1ALCLvl_LTE_A1;
		tptr->BackUp.Rvs1ALCLvl_LTE_A2		= Sts->Rvs1ALCLvl_LTE_A2;

		tptr->BackUp.DCOffSet				= Sts->DCOffSet;

		tptr->BackUp.MasterPNH		= iMasterPNH;
		tptr->BackUp.MasterPNL		= iMasterPNL;

		memcpy((INT8U*)&tptr->BackUp.HostNumber, (INT8U*)&Sts->HostNumber, sizeof(Sts->HostNumber));
		memcpy((INT8U*)&tptr->BackUp.TestStn, (INT8U*)&Sts->TestStn, sizeof(Sts->TestStn));

#if 0
		tptr->BackUp.SleepMode_2G.SleepMode_OnOff 		= Sts->SleepMode_2G.SleepMode_OnOff;
		tptr->BackUp.SleepMode_2G.SleepModeOnVolt.Data 	= Sts->SleepMode_2G.SleepModeOnVolt.Data;
		tptr->BackUp.SleepMode_2G.SleepModeOffVolt.Data = Sts->SleepMode_2G.SleepModeOffVolt.Data;		

		tptr->BackUp.SleepMode_LTE.SleepMode_OnOff		 = Sts->SleepMode_LTE.SleepMode_OnOff;
		tptr->BackUp.SleepMode_LTE.SleepModeOnVolt.Data	 = Sts->SleepMode_LTE.SleepModeOnVolt.Data;
		tptr->BackUp.SleepMode_LTE.SleepModeOffVolt.Data = Sts->SleepMode_LTE.SleepModeOffVolt.Data;		

		tptr->BackUp.SleepMode_LTE_A1.SleepMode_OnOff		 = Sts->SleepMode_LTE_A1.SleepMode_OnOff;
		tptr->BackUp.SleepMode_LTE_A1.SleepModeOnVolt.Data	 = Sts->SleepMode_LTE_A1.SleepModeOnVolt.Data;
		tptr->BackUp.SleepMode_LTE_A1.SleepModeOffVolt.Data  = Sts->SleepMode_LTE_A1.SleepModeOffVolt.Data;		


		tptr->BackUp.SleepMode_LTE_A2.SleepMode_OnOff		 = Sts->SleepMode_LTE_A2.SleepMode_OnOff;
		tptr->BackUp.SleepMode_LTE_A2.SleepModeOnVolt.Data	 = Sts->SleepMode_LTE_A2.SleepModeOnVolt.Data;
		tptr->BackUp.SleepMode_LTE_A2.SleepModeOffVolt.Data  = Sts->SleepMode_LTE_A2.SleepModeOffVolt.Data; 	
#endif
		
#if 0
	__SleepMode  SleepMode_2G;
	__SleepMode  SleepMode_LTE;
	__SleepMode  SleepMode_LTE_A1;
	__SleepMode  SleepMode_LTE_A2;
#endif

		
	}
	
	WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));

	OS_EXIT_CRITICAL();
}


void Initialize(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	Sts->Manufacture		= 0x0B;
	Sts->Supplier			= 0x0B;


	{
		INT8U i;
		for(i = 0; i < sizeof(Sts->EsnNumber); i++)
		{
			Sts->EsnNumber[i] = 0x30;
		}

		for(i = 0; i < sizeof(Sts->MinNumber); i++)
		{
			Sts->MinNumber[i] = 0x30;
		}
	}
	
	AttnOutBufferInit();

	Sts->OverInputAGCOnOff			= Disable;
	Sts->RB_StsOnOff				= __NOTUSE;

	Sts->ModemOnOff 				= Enable;
	Sts->DebugOnOff					= Disable;
	
	Sts->FwdOutHighLmt_2G[0]		= FwdHighLmt_2G +3;
	Sts->FwdOutHighLmt_2G[1]		= 0;
	
	Sts->FwdOutHighLmt_LTE[0]		= FwdHighLmt_LTE + 3;
	Sts->FwdOutHighLmt_LTE[1]		= 0; 

	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		Sts->FwdOutHighLmt_LTE[0]		= FwdHighLmt_LTE + 3;
		Sts->FwdOutHighLmt_LTE[1]		= 0; 
	}
	else
	{
		Sts->FwdOutHighLmt_LTE[0]		= FwdHighLmt_LTE15M + 3;
		Sts->FwdOutHighLmt_LTE[1]		= 0; 
	}
	

	Sts->FwdOutHighLmt_LTE_A1[0] 	= FwdHighLmt_LTE_A1 + 3; 
	Sts->FwdOutHighLmt_LTE_A1[1] 	= 0; 

	Sts->FwdOutHighLmt_LTE_A2[0] 	= FwdHighLmt_LTE_A2 + 3; 
	Sts->FwdOutHighLmt_LTE_A2[1] 	= 0; 
	
	Sts->FwdOutHighLmt_3G[0]		= FwdHighLmt_3G + 3;
	Sts->FwdOutHighLmt_3G[1]		= 0;

	Sts->Fwd1OutHighLmt_LTE[0]		= FwdHighLmt_LTE + 3;
	Sts->Fwd1OutHighLmt_LTE[1]		= 0; 

	Sts->Fwd1OutHighLmt_LTE_A1[0] 	= FwdHighLmt_LTE_A1 + 3; 
	Sts->Fwd1OutHighLmt_LTE_A1[1] 	= 0; 

	Sts->Fwd1OutHighLmt_LTE_A2[0] 	= FwdHighLmt_LTE_A2 + 3; 
	Sts->Fwd1OutHighLmt_LTE_A2[1] 	= 0; 

	Sts->RvsOutUpperLmt_2G[0]		= RvsHighLmt_2G+ 3;
	Sts->RvsOutUpperLmt_2G[1]		= 0;

	Sts->RvsOutUpperLmt_LTE[0]		= RvsHighLmt_LTE+ 3;
	Sts->RvsOutUpperLmt_LTE[1]		= 0;

	Sts->RvsOutUpperLmt_LTE_A1[0]	= RvsHighLmt_LTE_A+ 3;
	Sts->RvsOutUpperLmt_LTE_A1[1]	= 0;

	Sts->RvsOutUpperLmt_LTE_A2[0]	= RvsHighLmt_LTE_A+ 3;
	Sts->RvsOutUpperLmt_LTE_A2[1]	= 0;


	Sts->RvsOutUpperLmt_3G[0]		= RvsHighLmt_3G+ 3;
	Sts->RvsOutUpperLmt_3G[1]		= 0;

	Sts->Rvs1OutUpperLmt_LTE[0]		= RvsHighLmt_LTE+ 3;
	Sts->Rvs1OutUpperLmt_LTE[1]		= 0;

	Sts->Rvs1OutUpperLmt_LTE_A1[0]	= RvsHighLmt_LTE_A+ 3;
	Sts->Rvs1OutUpperLmt_LTE_A1[1]	= 0;

	Sts->Rvs1OutUpperLmt_LTE_A2[0]	= RvsHighLmt_LTE_A+ 3;
	Sts->Rvs1OutUpperLmt_LTE_A2[1]	= 0;

	Sts->OverInAlarmLmt_2G			= FwdOverInSDAlmLmt_2G*2; 
	Sts->OverInAlarmLmt_3G			= FwdOverInSDAlmLmt_3G*2; 
	Sts->OverInAlarmLmt_LTE_A1		= FwdOverInSDAlmLmt_LTE_A1*2; 
	Sts->OverInAlarmLmt_LTE_A2		= FwdOverInSDAlmLmt_LTE_A2*2; 
	if(tDnrSts->LTE15MUse == __NOTUSE)
	{
		Sts->OverInAlarmLmt_LTE 	= FwdOverInSDAlmLmt_LTE*2; 
	}
	else
	{
		Sts->OverInAlarmLmt_LTE 	= FwdOverInSDAlmLmt_LTE15M*2; 
	}

//////////////////////////////////
	ChkBandSelet				= SET;
	ChkPllFregOffset_LTE		= SET;

	Sts->ShunDownTime = 0;

	Sts->FwdAttn2_2G			= ToggleFwdAttn_2G;
	Sts->FwdAttn2_LTE 			= ToggleFwdAttn_LTE;
	Sts->AttOffset.RvsAttn1_2G 	= ToggleRvsAttn_2G;
	tmpRvsAttn1_2G 				=  ToggleRvsAttn_2G;

	Sts->FwdAttn2_LTE_A1 		= ToggleFwdAttn_LTE_A1;
	Sts->FwdAttn2_LTE_A2 		= ToggleFwdAttn_LTE_A2;

	Sts->Fwd1Attn2_LTE_A1 		= ToggleFwdAttn_LTE_A1;
	Sts->Fwd1Attn2_LTE_A2 		= ToggleFwdAttn_LTE_A2;

#if 0
	Sts->SleepMode_2G.SleepMode_OnOff = Enable;
	Sts->SleepMode_2G.SleepModeOnVolt.Data = 5000;
	Sts->SleepMode_2G.SleepModeOffVolt.Data = 2500;
#endif	
}


INT8U AnalyzeAidData(__ProtocolPtr *nPtr, INT8U Ctrl)
{
	INT8U i = 0;
	INT8U A_ID[2];
	INT8U rAID_Value[70];
	INT8U Length;

	INT16U Cnt = 0;
	INT16U AID_Command;
	INT32U cpu_sr;

	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody%2];

	INT8U rval = FALSE;

	OS_ENTER_CRITICAL();
	{
		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);

		while(BodyFrame->SubLength > Cnt)
		{
			A_ID[0] = (INT8U)(BodyFrame->SubData[Cnt++]);
			A_ID[1] = (INT8U)(BodyFrame->SubData[Cnt++]);

			AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
			Length = BodyFrame->SubData[Cnt++];
			if( Length >= sizeof(rAID_Value)) break;
			for (i = 0; i < Length; i++) rAID_Value[i] = (INT8U)(BodyFrame->SubData[Cnt++]);

			
			rval += SetCtrlData(AID_Command, rAID_Value, Length, Ctrl,nPtr, tptr);

			if(Cnt >= BodyFrame->SubLength) break;
		}

		if(rval)
		{
			//write eeprom!!
			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
		}
	}
	OS_EXIT_CRITICAL();


	return TRUE;
}

INT8U ISAscII(INT8U Data)
{
	if('0' <= Data && Data <= '9')	return TRUE;
	else							return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////

