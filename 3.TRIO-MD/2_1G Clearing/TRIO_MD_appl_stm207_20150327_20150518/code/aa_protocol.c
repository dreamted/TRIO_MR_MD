/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : fsmc_sram.h
* Author             : MCD Application Team
* Version            : V2.0.2
* Date               : 07/11/2008
* Description        : Header for fsmc_sram.c file.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/
#define PROT_C

#include "../include/main.h"

#define ____	USART3Printf("%s %d\n", __FUNCTION__, __LINE__);

INT16U GenDnrAidSts(INT8U *dptr, __Dnr_Sts *Sts,__ProtocolPtr *nPtr )
{
	INT16U rlen = 0;
	INT16U i = 0;

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
	rlen += GenAidData(Aid_FPGAVer,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FPGAVer), sizeof(Sts->FPGAVer));


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

	rlen += GenAidData(Aid_FwdInPwr_LTE_A2,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_LTE_A2), sizeof(Sts->FwdInPwr_LTE_A2));
	rlen += GenAidData(Aid_FwdOutPwr_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_LTE_A2), sizeof(Sts->FwdOutPwr_LTE_A2));
	rlen += GenAidData(Aid_FwdOutUpperLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_LTE_A2), sizeof(Sts->FwdOutUpperLmt_LTE_A2));
	rlen += GenAidData(Aid_FwdOutLowerLmt_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_LTE_A2), sizeof(Sts->FwdOutLowerLmt_LTE_A2));
	rlen += GenAidData(Aid_FwdGainSet_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_LTE_A2), 1);
	rlen += GenAidData(Aid_FwdGain_LTE_A2,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_LTE_A2), 1);

	rlen += GenAidData(Aid_FwdInPwr_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_LTE_21), sizeof(Sts->FwdInPwr_LTE_21));
	rlen += GenAidData(Aid_FwdOutPwr_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_LTE_21), sizeof(Sts->FwdOutPwr_LTE_21));
	rlen += GenAidData(Aid_FwdOutUpperLmt_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_LTE_21), sizeof(Sts->FwdOutUpperLmt_LTE_21));
	rlen += GenAidData(Aid_FwdOutLowerLmt_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_LTE_21), sizeof(Sts->FwdOutLowerLmt_LTE_21));
	rlen += GenAidData(Aid_FwdGainSet_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_LTE_21), 1);
	rlen += GenAidData(Aid_FwdGain_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_LTE_21), 1);

	rlen += GenAidData(Aid_RvsGainSet_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_3G), 1);
	rlen += GenAidData(Aid_RvsGainSts_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_3G), 1);

	rlen += GenAidData(Aid_RvsGainBalance_WCDMALTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_WCDMALTE_21), 1);
	rlen += GenAidData(Aid_RvsGainBalance_CDMALTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_CDMALTE), 1);
	rlen += GenAidData(Aid_RvsGainBalance_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_LTE_A), 1);

	rlen += GenAidData(Aid_RvsGainSet_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_2G), 1);
	rlen += GenAidData(Aid_RvsGainSts_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_2G), 1);

	rlen += GenAidData(Aid_RvsGainSet_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_LTE), 1);
	rlen += GenAidData(Aid_RvsGainSts_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE), 1);

	rlen += GenAidData(Aid_RvsGainSet_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_LTE_A2), 1);
	rlen += GenAidData(Aid_RvsGainSts_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE_A2), 1);

	rlen += GenAidData(Aid_RvsGainSet_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSet_LTE_21), 1);
	rlen += GenAidData(Aid_RvsGainSts_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE_21), 1);


	rlen += GenAidData(Aid_AmpOffCase_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_3G), 1);
	rlen += GenAidData(Aid_AmpOffCase_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_2G), 1);
	rlen += GenAidData(Aid_AmpOffCase_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_LTE), 1);
	rlen += GenAidData(Aid_AmpOffCase_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_LTE_A2), 1);
	rlen += GenAidData(Aid_AmpOffCase_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_LTE_21), 1);

	rlen += GenAidData(Aid_RepeatResetPriod,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RepeatResetPriod), 1);

	rlen += GenAidData(Aid_AGCOnOff_WCDMALTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_WCDMALTE_21), 1);
	rlen += GenAidData(Aid_AGCOnOff_CDMALTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_CDMALTE), 1);
	rlen += GenAidData(Aid_AGCOnOff_LTE_A_0,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_LTE_A_0), 1);

	rlen += GenAidData(Aid_AGCMode_3G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_3G), 1);
	rlen += GenAidData(Aid_AGCMode_2G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_2G), 1);
	rlen += GenAidData(Aid_AGCMode_LTE, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE), 1);
	rlen += GenAidData(Aid_AGCMode_LTE_A2,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE_A2), 1);
	rlen += GenAidData(Aid_AGCMode_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE_21), 1);


	rlen += GenAidData(Aid_Band_Select_CDMALTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Band_Select_CDMALTE), sizeof(Sts->Band_Select_CDMALTE));	
	rlen += GenAidData(Aid_Band_Select_LTE_A,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Band_Select_LTE_A), sizeof(Sts->Band_Select_LTE_A));	
	rlen += GenAidData(Aid_Band_Select_WCDMALTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Band_Select_WCDMALTE_21), sizeof(Sts->Band_Select_WCDMALTE_21));	

	rlen += GenAidData(Aid_ISOValue_WCDMALTE_21, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ISOValue_WCDMALTE_21), sizeof(Sts->ISOValue_WCDMALTE_21));	
	rlen += GenAidData(Aid_ISOValue_CDMALTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ISOValue_CDMALTE), sizeof(Sts->ISOValue_CDMALTE));	
	rlen += GenAidData(Aid_ISOValue_LTE_A, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ISOValue_LTE_A), sizeof(Sts->ISOValue_LTE_A));	

	rlen += GenAidData(Aid_ULGainPriod, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ULGainPriod), sizeof(Sts->ULGainPriod));	
	rlen += GenAidData(Aid_ULGainMode, 					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ULGainMode), sizeof(Sts->ULGainMode));	

	rlen += GenAidData(Aid_LTE_21Use, 					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LTE_21Use), sizeof(Sts->LTE_21Use));	
///////////////////////

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
#if 1
	rlen += GenAidData(Aid_TPTL_OnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TPTL_OnOff), 1);
	rlen += GenAidData(Aid_TempOffset,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TempOffset), 1);
	rlen += GenAidData(Aid_RCUAddVer,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RCUAddVer), 1);
	rlen += GenAidData(Aid_AlarmMask,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AlarmMask), 1);

	rlen += GenAidData(Aid_LedAlarm,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LedAlarm), (sizeof(Sts->LedAlarm)));
	rlen += GenAidData(Aid_ModemMINNumber,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->MinNumber), sizeof(Sts->MinNumber));
	rlen += GenAidData(Aid_ModemOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ModemOnOff), 1);
	rlen += GenAidData(Aid_ModuleAlarm, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ModuleAlarm), sizeof(Sts->ModuleAlarm));
	rlen += GenAidData(Aid_ModuleTemp,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrentTemp), sizeof(Sts->CurrentTemp));
	rlen += GenAidData(Aid_TableSts,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TableStatus), sizeof(Sts->TableStatus));
	rlen += GenAidData(Aid_LockOrderSts,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LockOrderSts), sizeof(Sts->LockOrderSts));

	// VccDet_Lmt
	rlen += GenAidData(Aid_VccDet_Lmt, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->VccDet_Lmt), sizeof(Sts->VccDet_Lmt));

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
	rlen += GenAidData(Aid_RvsAttn1_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_3G, 1);
	rlen += GenAidData(Aid_RvsAttn2_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_3G, 1);
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

	rlen += GenAidData(Aid_FwdAttn1_CDMALTE, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_CDMALTE, 1);
	rlen += GenAidData(Aid_RvsAttn1_CDMALTE, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_CDMALTE, 1);
	rlen += GenAidData(Aid_RvsAttn2_CDMALTE, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_CDMALTE, 1);
	rlen += GenAidData(Aid_RvsAttn3_CDMALTE, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_CDMALTE, 1);

	rlen += GenAidData(Aid_FwdAttn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE, 1);
	rlen += GenAidData(Aid_FwdAttn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE, 1);

	rlen += GenAidData(Aid_FwdAttn1_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdAttn2_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE_A2, 1);

	rlen += GenAidData(Aid_RvsAttn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE, 1);
	rlen += GenAidData(Aid_RvsAttn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE, 1);

	rlen += GenAidData(Aid_RvsAttn1_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsAttn2_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE_A2, 1);

	rlen += GenAidData(Aid_FwdAttn1_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A1, 1);
	rlen += GenAidData(Aid_FwdAttn2_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsAttn1_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE_A1, 1);
	rlen += GenAidData(Aid_RvsAttn2_LTE_A1,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE_A1, 1);

	rlen += GenAidData(Aid_FwdGainOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdGainOffset_LTE, 1);
	rlen += GenAidData(Aid_RvsGainOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsGainOffset_LTE, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_2G, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_LTE, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_3G, 1);

	rlen += GenAidData(Aid_RvsAlcAttn_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_2G, 1);
	rlen += GenAidData(Aid_RvsAlcAttn_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_LTE, 1);
	rlen += GenAidData(Aid_RvsAlcAttn_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_3G, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_2G, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_LTE, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_3G, 1);
	rlen += GenAidData(Aid_RvsOutPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE), sizeof(Sts->RvsOutPwr_LTE));
	rlen += GenAidData(Aid_RvsInPwr_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_2G), sizeof(Sts->RvsInPwr_2G));
	rlen += GenAidData(Aid_RvsInPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE), sizeof(Sts->RvsInPwr_LTE));
	rlen += GenAidData(Aid_RvsInPwr_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_3G), sizeof(Sts->RvsInPwr_3G));
	rlen += GenAidData(Aid_ShutDownOnOff_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE, 1);
	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE), sizeof(Sts->RvsOutUpperLmt_LTE));
	rlen += GenAidData(Aid_FwdOutHighLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE), sizeof(Sts->FwdOutHighLmt_LTE));
	rlen += GenAidData(Aid_OverInAlarmLmt_2G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_2G, 1);
	rlen += GenAidData(Aid_OverInAlarmLmt_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_LTE, 1);
	rlen += GenAidData(Aid_OverInAlarmLmt_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_3G, 1);

	rlen += GenAidData(Aid_RvsALCLvl_2G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_2G, 1);
	rlen += GenAidData(Aid_RvsALCLvl_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_3G, 1);
	rlen += GenAidData(Aid_RvsALCLvl_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_LTE, 1);

///////////////////////
	rlen += GenAidData(Aid_FwdInPwrOffset_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdInPwrOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdOutPwrOffset_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdOutPwrOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsOutPwrOffset_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsOutPwrOffset_LTE_A2, 1);

	rlen += GenAidData(Aid_FwdGainOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdGainOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsGainOffset_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsGainOffset_LTE_A2, 1);
	rlen += GenAidData(Aid_FwdAgcAttn_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsAlcAttn_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsAlcOnOff_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsOutPwr_LTE_A2, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE_A2), sizeof(Sts->RvsOutPwr_LTE_A2));

	rlen += GenAidData(Aid_RvsInPwr_LTE_A2, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE_A2), sizeof(Sts->RvsInPwr_LTE_A2));
	rlen += GenAidData(Aid_ShutDownOnOff_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE_A2, 1);
	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE_A2,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE_A2), sizeof(Sts->RvsOutUpperLmt_LTE_A2));
	rlen += GenAidData(Aid_FwdOutHighLmt_LTE_A2, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE_A2), sizeof(Sts->FwdOutHighLmt_LTE_A2));
	rlen += GenAidData(Aid_OverInAlarmLmt_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_LTE_A2, 1);

	rlen += GenAidData(Aid_RvsALCLvl_LTE_A2,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_LTE_A2, 1);


	rlen += GenAidData(Aid_FwdAttn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A, 1);
	rlen += GenAidData(Aid_RvsAttn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE_A, 1);
	rlen += GenAidData(Aid_RvsAttn2_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE_A, 1);
	rlen += GenAidData(Aid_RvsAttn3_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_LTE_A, 1);

	rlen += GenAidData(Aid_FwdTemp_CDMALTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdTemp_CDMALTE, 1);
	rlen += GenAidData(Aid_RvsTemp_CDMALTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsTemp_CDMALTE, 1);

	rlen += GenAidData(Aid_FwdTemp_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdTemp_LTE_A, 1);
	rlen += GenAidData(Aid_RvsTemp_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsTemp_LTE_A, 1);

////
	rlen += GenAidData16Bit(Aid_DTUPeakPower,	(INT8U *)&dptr[rlen], (INT16U *)&(Sts->DTUPeakPower), sizeof(Sts->DTUPeakPower));
	rlen += GenAidData16Bit(Aid_DTUAverPower,	(INT8U *)&dptr[rlen], (INT16U *)&(Sts->DTUAverPower), sizeof(Sts->DTUAverPower));
	rlen += GenAidData16Bit(Aid_DTUPeakOffset,	(INT8U *)&dptr[rlen], (INT16U *)&(Sts->DTUPeakOffset), sizeof(Sts->DTUPeakOffset));
	rlen += GenAidData16Bit(Aid_DTUAverOffset,	(INT8U *)&dptr[rlen], (INT16U *)&(Sts->DTUAverOffset), sizeof(Sts->DTUAverOffset));

	rlen += GenAidData(Aid_DLAGCAttn,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DLAGCAttn), sizeof(Sts->DLAGCAttn));
	rlen += GenAidData(Aid_ULAGCAttn,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ULAGCAttn), sizeof(Sts->ULAGCAttn));
	rlen += GenAidData(Aid_DLALCAttn,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DLALCAttn), sizeof(Sts->DLALCAttn));
	rlen += GenAidData(Aid_ULALCAttn,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ULALCAttn), sizeof(Sts->ULALCAttn));

	rlen += GenAidData(Aid_SmartAGCDLOnOff,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SmartAGCDLOnOff), sizeof(Sts->SmartAGCDLOnOff));
	rlen += GenAidData(Aid_SmartAGCULOnOff,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SmartAGCULOnOff), sizeof(Sts->SmartAGCULOnOff));
	rlen += GenAidData(Aid_DTU_DLAGCLevel, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DTU_DLAGCLevel), sizeof(Sts->DTU_DLAGCLevel));
	rlen += GenAidData(Aid_DTU_ULAGCLevel, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DTU_ULAGCLevel), sizeof(Sts->DTU_ULAGCLevel));
	rlen += GenAidData16Bit(Aid_ISO,		(INT8U *)&dptr[rlen], (INT16U *)&(Sts->ISO), sizeof(Sts->ISO));

	dptr[rlen++] = (INT8U)((Aid_ISOOnOff >> 8) & 0xFF);
	dptr[rlen++] = (INT8U)((Aid_ISOOnOff >> 0) & 0xFF);
	dptr[rlen++] = 5;
	dptr[rlen++] = Sts->ISOSelect;
	dptr[rlen++] = Sts->ISOOnOff;
	dptr[rlen++] = Sts->ISOMode;
	dptr[rlen++] = Sts->ISOStartCnt;
	dptr[rlen++] = Sts->ISOSampleAvg;

	rlen += GenAidData(Aid_PathOnOff_800M,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->PathOnOff_800M), sizeof(Sts->PathOnOff_800M));
	rlen += GenAidData(Aid_PathOnOff_1800M,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->PathOnOff_1800M), sizeof(Sts->PathOnOff_1800M));
	rlen += GenAidData(Aid_PathOnOff_2100M,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->PathOnOff_2100M), sizeof(Sts->PathOnOff_2100M));
////

	rlen += GenAidData(Aid_SamplePathSel,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SamplePathSel), sizeof(Sts->SamplePathSel));
	rlen += GenAidData16(Aid_SampleAddr,	(INT8U *)&dptr[rlen], (Sts->SampleAddr), sizeof(Sts->SampleAddr));

	// SampleData
	dptr[rlen++] = (Aid_SampleData >> 8) & 0xff;
	dptr[rlen++] = (Aid_SampleData >> 0) & 0xff;
	dptr[rlen++] = sizeof(Sts->SampleData);
	dptr[rlen++] = (INT8U)((Sts->SampleData >> 24) & 0xFF);
	dptr[rlen++] = (INT8U)((Sts->SampleData >> 16) & 0xFF);
	dptr[rlen++] = (INT8U)((Sts->SampleData >> 8) & 0xFF);
	dptr[rlen++] = (INT8U)((Sts->SampleData >> 0) & 0xFF);


	// SampleDataOffset
	dptr[rlen++] = (Aid_SampleDataOffset >> 8) & 0xff;
	dptr[rlen++] = (Aid_SampleDataOffset >> 0) & 0xff;
	dptr[rlen++] = 6;
	dptr[rlen++] = Sts->SampleOffsetA.sD8[3];
	dptr[rlen++] = Sts->SampleOffsetA.sD8[2];
	dptr[rlen++] = Sts->SampleOffsetA.sD8[1];
	dptr[rlen++] = Sts->SampleOffsetA.sD8[0];

	dptr[rlen++] = Sts->SampleOffsetB.sD8[1];
	dptr[rlen++] = Sts->SampleOffsetB.sD8[0];

	rlen += GenAidData(Aid_FwdInPwrOffset_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwrOffset_LTE_21), 	sizeof(Sts->FwdInPwrOffset_LTE_21));
	rlen += GenAidData(Aid_RvsOutPwrOffset_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwrOffset_LTE_21), 	sizeof(Sts->RvsOutPwrOffset_LTE_21));
	rlen += GenAidData(Aid_FwdOutPwrOffset_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwrOffset_LTE_21), 	sizeof(Sts->FwdOutPwrOffset_LTE_21));
	rlen += GenAidData(Aid_FwdAttn1_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAttn1_LTE_21), 		sizeof(Sts->FwdAttn1_LTE_21));
	rlen += GenAidData(Aid_FwdAttn2_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAttn2_LTE_21), 		sizeof(Sts->FwdAttn1_LTE_21));

	rlen += GenAidData(Aid_RvsAttn1_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn1_LTE_21), 		sizeof(Sts->RvsAttn1_LTE_21));
	rlen += GenAidData(Aid_RvsAttn2_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn2_LTE_21),		 	sizeof(Sts->RvsAttn2_LTE_21));
	rlen += GenAidData(Aid_RvsAttn3_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn3_LTE_21), 		sizeof(Sts->RvsAttn3_LTE_21));
	rlen += GenAidData(Aid_FwdGainOffset_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainOffset_LTE_21), 	sizeof(Sts->FwdGainOffset_LTE_21));
	rlen += GenAidData(Aid_RvsGainOffset_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainOffset_LTE_21), 	sizeof(Sts->RvsGainOffset_LTE_21));
	rlen += GenAidData(Aid_FwdAgcAttn_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAgcAttn_LTE_21), 		sizeof(Sts->FwdAgcAttn_LTE_21));
	rlen += GenAidData(Aid_RvsAlcAttn_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAlcAttn_LTE_21), 		sizeof(Sts->RvsAlcAttn_LTE_21));
	rlen += GenAidData(Aid_RvsAlcOnOff_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAlcOnOff_LTE_21), 		sizeof(Sts->RvsAlcOnOff_LTE_21));
	rlen += GenAidData(Aid_RvsOutPwr_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE_21), 		sizeof(Sts->RvsOutPwr_LTE_21));
	rlen += GenAidData(Aid_RvsInPwr_LTE_21,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE_21), 		sizeof(Sts->RvsInPwr_LTE_21));
	rlen += GenAidData(Aid_ShutDownOnOff_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ShutDownOnOff_LTE_21), 	sizeof(Sts->ShutDownOnOff_LTE_21));
	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE_21), 	sizeof(Sts->RvsOutUpperLmt_LTE_21));
	rlen += GenAidData(Aid_FwdOutHighLmt_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE_21), 	sizeof(Sts->FwdOutHighLmt_LTE_21));
	rlen += GenAidData(Aid_OverInAlarmLmt_LTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->OverInAlarmLmt_LTE_21), 	sizeof(Sts->OverInAlarmLmt_LTE_21));
	rlen += GenAidData(Aid_RvsALCLvl_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsALCLvl_LTE_21), 		sizeof(Sts->RvsALCLvl_LTE_21));
	rlen += GenAidData(Aid_SD_Status_LTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE_21), 		sizeof(Sts->SD_Status_LTE_21));
	rlen += GenAidData(Aid_FwdAttn1_WCDMALTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAttn1_WCDMALTE_21), 	sizeof(Sts->FwdAttn1_WCDMALTE_21));
	rlen += GenAidData(Aid_RvsAttn1_WCDMALTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn1_WCDMALTE_21), 	sizeof(Sts->RvsAttn1_WCDMALTE_21));
	rlen += GenAidData(Aid_RvsAttn2_WCDMALTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn2_WCDMALTE_21), 	sizeof(Sts->RvsAttn2_WCDMALTE_21));
	rlen += GenAidData(Aid_RvsAttn3_WCDMALTE_21,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn3_WCDMALTE_21), 	sizeof(Sts->RvsAttn3_WCDMALTE_21));
	rlen += GenAidData(Aid_FwdTemp_WCDMALTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdTemp_WCDMALTE_21), 	sizeof(Sts->FwdTemp_WCDMALTE_21));
	rlen += GenAidData(Aid_RvsTemp_WCDMALTE_21,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsTemp_WCDMALTE_21), 	sizeof(Sts->RvsTemp_WCDMALTE_21));

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

	rlen += GenAidData(Aid_AutoShutDownSts_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_2G), sizeof(Sts->SD_Status_2G));
	rlen += GenAidData(Aid_AutoShutDownSts_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_3G), sizeof(Sts->SD_Status_3G));
	rlen += GenAidData(Aid_AutoShutDownSts_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE), sizeof(Sts->SD_Status_LTE));
	rlen += GenAidData(Aid_AutoShutDownSts_LTE_A2,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SD_Status_LTE_A2), sizeof(Sts->SD_Status_LTE_A2));

	rlen += GenAidData(Aid_ShunDownTime,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ShunDownTime), sizeof(Sts->ShunDownTime));
	rlen += GenAidData(Aid_ESNCheck,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->EsnNumber), sizeof(Sts->EsnNumber));
	rlen += GenAidData(Aid_OverInputAGCOnOff,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->OverInputAGCOnOff), sizeof(Sts->OverInputAGCOnOff));


	rlen += GenAidData(Aid_DCOffSet,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DCOffSet), sizeof(Sts->DCOffSet));

	rlen += GenAidData16Bit(Aid_ISOOffset,	(INT8U *)&dptr[rlen], (INT16U *)&(Sts->ISOOffset), sizeof(Sts->ISOOffset));


	rlen += GenAidData(Aid_ULGainOutLmt,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ULGainOutLmt), sizeof(Sts->ULGainOutLmt));
	rlen += GenAidData(Aid_RvsInPwrOffset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwrOffset), sizeof(Sts->RvsInPwrOffset));
	rlen += GenAidData(Aid_PLLOffset,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->PLLOffset), sizeof(Sts->PLLOffset));

	rlen += GenAidData(Aid_FPGAAddVer,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FPGAAddVer), sizeof(Sts->FPGAAddVer));	

	rlen += GenAidData16Bit(Aid_DLISOOffset,	(INT8U *)&dptr[rlen], (INT16U *)&(Sts->DLISOOffset), sizeof(Sts->DLISOOffset));
	rlen += GenAidData16Bit(Aid_ULISOOffset,	(INT8U *)&dptr[rlen], (INT16U *)&(Sts->ULISOOffset), sizeof(Sts->ULISOOffset));


	rlen += GenAidData(Aid_BandFilterInfo, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->BandFilterInfo), sizeof(Sts->BandFilterInfo));
	rlen += GenAidData(Aid_FilterStart,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FilterStart), sizeof(Sts->FilterStart));
	rlen += GenAidData(Aid_DTUFilterSts,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DTUFilterSts), sizeof(Sts->DTUFilterSts));
	rlen += GenAidData(Aid_FilterUSE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FilterUSE), sizeof(Sts->FilterUSE));	

	rlen += GenAidData(Aid_FTPOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTPOnOff), sizeof(Sts->FTPOnOff));	
	rlen += GenAidData(Aid_FTPIndex,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTPIndex), sizeof(Sts->FTPIndex));	
	rlen += GenAidData16(Aid_FTPFileStep, 		(INT8U *)&dptr[rlen], Sts->FTPFileStep.uD16, sizeof(Sts->FTPFileStep));
	rlen += GenAidData32Bit(Aid_FTPFileSize,	(INT8U *)&dptr[rlen], Sts->FTPFileSize.uD32, sizeof(Sts->FTPFileSize));
	rlen += GenAidData16(Aid_FTPFrameCnt,		(INT8U *)&dptr[rlen], Sts->FTPFrameCnt.uD16, sizeof(Sts->FTPFrameCnt));
	rlen += GenAidData16(Aid_FTPTotFrame,		(INT8U *)&dptr[rlen], Sts->FTPTotFrame.uD16, sizeof(Sts->FTPTotFrame));
	rlen += GenAidData(Aid_FTPMode,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTPMode), sizeof(Sts->FTPMode));	

	rlen += GenAidData(Aid_FTP_IP, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTP_IP), sizeof(Sts->FTP_IP));	
	rlen += GenAidData(Aid_FTP_Port, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTP_Port), sizeof(Sts->FTP_Port));	
	rlen += GenAidData(Aid_FTP_ID,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTP_ID), sizeof(Sts->FTP_ID));	
	rlen += GenAidData(Aid_FTP_PW,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTP_PW), sizeof(Sts->FTP_PW));	
	rlen += GenAidData(Aid_FTP_DnFilePath,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTP_DnFilePath), sizeof(Sts->FTP_DnFilePath));	
	rlen += GenAidData(Aid_FTP_DnFileName,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTP_DnFileName), sizeof(Sts->FTP_DnFileName));	
	rlen += GenAidData(Aid_FTP_DnHours,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FTP_DnHours), sizeof(Sts->FTP_DnHours));	

#endif

	return rlen;
}


INT8U SetCtrlData(INT16U AID_Command, INT8U *AID_Value, INT8U Length,INT8U Ctrl1, __ProtocolPtr *nPtr)
{
	EE_BACK1 *tptr = &gEE_BACK1;

	INT8U rval = FALSE;
	
	INT16U addr = 0;
	
	INT16U Data = 0;
	__Dnr_Sts *Sts = tDnrSts;

//	INT8U i = 0;
	INT8U i = 0, j = 0;
	
	switch(AID_Command)
	{

		case Aid_EsnChecksum:
		case Aid_ICCIDChecksum:
			Sts->ICCIDChecksum[0] = AID_Value[0];
			Sts->ICCIDChecksum[1] = AID_Value[1];
			if( (EsnChecksumH !=AID_Value[0]) ||(EsnChecksumL != AID_Value[1]))
			{
				iMobileESN = NACK;
			}
			else iMobileESN = ACK;
		break;

		case Aid_FwdOutUpperLmt_3G:
			Sts->FwdOutUpperLmt_3G[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_3G[1] = AID_Value[1];

			tptr->BackUp.FwdOutUpperLmt_3G[0] = Sts->FwdOutUpperLmt_3G[0];
			tptr->BackUp.FwdOutUpperLmt_3G[1] = Sts->FwdOutUpperLmt_3G[1];

			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_3G[i]), Sts->FwdOutUpperLmt_3G[i], 0);
			}
		break;

		case Aid_FwdOutLowerLmt_3G:
			Sts->FwdOutLowerLmt_3G[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_3G[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_3G[0] = Sts->FwdOutLowerLmt_3G[0];
			tptr->BackUp.FwdOutLowerLmt_3G[1] = Sts->FwdOutLowerLmt_3G[1];
			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutLowerLmt_3G[i]), Sts->FwdOutLowerLmt_3G[i], 0);
			}
		break;


		case Aid_FwdGainSet_3G:
			Sts->FwdGainSet_3G = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_3G = Sts->FwdGainSet_3G*2;

			Sts->FwdGainSet_3G = MinMaxAttnCheck(Sts->FwdGainSet_3G, MAXGain_2100M, MINGain_2100M);
			Sts->FwdAgcAttn_3G = GainAttnCalculation(Sts->FwdGainSet_3G, MAXGain_2100M, MINGain_2100M);
			ChkAttChange = RESET;
			tptr->BackUp.FwdGainSet_3G = Sts->FwdGainSet_3G;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainSet_3G), Sts->FwdGainSet_3G, 0);
		break;

		case Aid_FwdOutUpperLmt_2G:
			Sts->FwdOutUpperLmt_2G[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_2G[1] = AID_Value[1];
			tptr->BackUp.FwdOutUpperLmt_2G[0] = Sts->FwdOutUpperLmt_2G[0];
			tptr->BackUp.FwdOutUpperLmt_2G[1] = Sts->FwdOutUpperLmt_2G[1];

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_2G[0]), Sts->FwdOutUpperLmt_2G[0], 0);
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_2G[1]), Sts->FwdOutUpperLmt_2G[1], 0);
		break;

		case Aid_FwdOutLowerLmt_2G:
			Sts->FwdOutLowerLmt_2G[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_2G[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_2G[0] = Sts->FwdOutLowerLmt_2G[0];
			tptr->BackUp.FwdOutLowerLmt_2G[1] = Sts->FwdOutLowerLmt_2G[1];
			
			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutLowerLmt_2G[i]), Sts->FwdOutLowerLmt_2G[i], 0);
			}
		break;
		
		case Aid_FwdGainSet_2G:
			Sts->FwdGainSet_2G = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_2G = Sts->FwdGainSet_2G*2;
			Sts->FwdGainSet_2G = MinMaxAttnCheck(Sts->FwdGainSet_2G, MAXGain_800M, MINGain_800M);
			Sts->FwdAgcAttn_2G = GainAttnCalculation(Sts->FwdGainSet_2G,MAXGain_800M,MINGain_800M);
			tptr->BackUp.FwdGainSet_2G = Sts->FwdGainSet_2G;


			ChkAttChange = RESET;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainSet_2G), Sts->FwdGainSet_2G, 0);
		break;


		case Aid_FwdOutUpperLmt_LTE:
			Sts->FwdOutUpperLmt_LTE[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_LTE[1] = AID_Value[1];     
			tptr->BackUp.FwdOutUpperLmt_LTE[0] = Sts->FwdOutUpperLmt_LTE[0];
			tptr->BackUp.FwdOutUpperLmt_LTE[1] = Sts->FwdOutUpperLmt_LTE[1];
			
			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_LTE[i]), Sts->FwdOutUpperLmt_LTE[i], 0);
			}
		break;

		case Aid_FwdOutLowerLmt_LTE:
			Sts->FwdOutLowerLmt_LTE[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_LTE[1] = AID_Value[1];    

			tptr->BackUp.FwdOutLowerLmt_LTE[0] = Sts->FwdOutLowerLmt_LTE[0];
			tptr->BackUp.FwdOutLowerLmt_LTE[1] = Sts->FwdOutLowerLmt_LTE[1];
			
			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutLowerLmt_LTE[i]), Sts->FwdOutLowerLmt_LTE[i], 0);
			}
		break;
		
		case Aid_FwdGainSet_LTE:
			Sts->FwdGainSet_LTE = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_LTE = Sts->FwdGainSet_LTE*2;
			
			Sts->FwdGainSet_LTE = MinMaxAttnCheck(Sts->FwdGainSet_LTE, MAXGain_800M, MINGain_800M);
			Sts->FwdAgcAttn_LTE = GainAttnCalculation(Sts->FwdGainSet_LTE,MAXGain_800M,MINGain_800M);
			ChkAttChange = RESET;
			
//			Ser3Ptr->printf("FwdGainSet_LTE :[%0d],[%0d]\n", Sts->FwdGainSet_LTE , Sts->FwdAgcAttn_LTE);
			tptr->BackUp.FwdGainSet_LTE = Sts->FwdGainSet_LTE;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainSet_LTE), Sts->FwdGainSet_LTE, 0);
		break;


		case Aid_FwdOutUpperLmt_LTE_A2:
			Sts->FwdOutUpperLmt_LTE_A2[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_LTE_A2[1] = AID_Value[1];
			tptr->BackUp.FwdOutUpperLmt_LTE_A2[0] = Sts->FwdOutUpperLmt_LTE_A2[0];
			tptr->BackUp.FwdOutUpperLmt_LTE_A2[1] = Sts->FwdOutUpperLmt_LTE_A2[1];			
			
			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_LTE_A2[i]), Sts->FwdOutUpperLmt_LTE_A2[i], 0);
			}
		break;

		case Aid_FwdOutLowerLmt_LTE_A2:
			Sts->FwdOutLowerLmt_LTE_A2[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_LTE_A2[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_LTE_A2[0] = Sts->FwdOutLowerLmt_LTE_A2[0];
			tptr->BackUp.FwdOutLowerLmt_LTE_A2[1] = Sts->FwdOutLowerLmt_LTE_A2[1];				
			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutLowerLmt_LTE_A2[i]), Sts->FwdOutLowerLmt_LTE_A2[i], 0);
			}
		break;
		
		case Aid_FwdGainSet_LTE_A2:
			Sts->FwdGainSet_LTE_A2 = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_LTE_A2 = Sts->FwdGainSet_LTE_A2*2;
			Sts->FwdGainSet_LTE_A2 = MinMaxAttnCheck(Sts->FwdGainSet_LTE_A2, MAXGain_1800M, MINGain_1800M);
			Sts->FwdAgcAttn_LTE_A2 = GainAttnCalculation(Sts->FwdGainSet_LTE_A2,MAXGain_1800M,MINGain_1800M);
			tptr->BackUp.FwdGainSet_LTE_A2 = Sts->FwdGainSet_LTE_A2;

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainSet_LTE_A2), Sts->FwdGainSet_LTE_A2, 0);
		break;


		case Aid_RvsGainSet_3G:
			Sts->Rvs0GainSet_3G = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_3G = Sts->Rvs0GainSet_3G*2;
			
			Sts->Rvs0GainSet_3G = MinMaxAttnCheck(Sts->Rvs0GainSet_3G, MAXGain_2100M, MINGain_2100M);
			Sts->RvsGainAttn_3G = GainAttnCalculation(Sts->Rvs0GainSet_3G,MAXGain_2100M,MINGain_2100M);
			
			tptr->BackUp.Rvs0GainSet_3G = Sts->Rvs0GainSet_3G;
			ChkAttChange = RESET;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Rvs0GainSet_3G), Sts->Rvs0GainSet_3G, 0);
		break;


		case Aid_RvsGainSet_2G:
			Sts->Rvs0GainSet_2G = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_2G = Sts->Rvs0GainSet_2G*2;
			
			Sts->Rvs0GainSet_2G = MinMaxAttnCheck(Sts->Rvs0GainSet_2G, MAXGain_800M, MINGain_800M);
			Sts->RvsGainAttn_2G = GainAttnCalculation(Sts->Rvs0GainSet_2G,MAXGain_800M,ATTENMIN);

			tptr->BackUp.Rvs0GainSet_2G = Sts->Rvs0GainSet_2G;

			ChkAttChange = RESET;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Rvs0GainSet_2G), Sts->Rvs0GainSet_2G, 0);
		break;

		case Aid_RvsGainSet_LTE:
			Sts->Rvs0GainSet_LTE = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_LTE = Sts->Rvs0GainSet_LTE*2;
			
			Sts->RvsGainAttn_LTE = MinMaxAttnCheck(Sts->RvsGainAttn_LTE, MAXGain_800M, MINGain_800M);
			Sts->RvsGainAttn_LTE = GainAttnCalculation(Sts->Rvs0GainSet_LTE,MAXGain_800M,ATTENMIN);
			ChkAttChange = RESET;
			
			tptr->BackUp.Rvs0GainSet_LTE = Sts->Rvs0GainSet_LTE;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Rvs0GainSet_LTE), Sts->Rvs0GainSet_LTE, 0);
		break;

		case Aid_RvsGainSet_LTE_A2:
			Sts->Rvs0GainSet_LTE_A2 = AID_Value[0];
			if(nPtr== SmsSer)Sts->Rvs0GainSet_LTE_A2 = Sts->Rvs0GainSet_LTE_A2*2;
			
			Sts->Rvs0GainSet_LTE_A2 = MinMaxAttnCheck(Sts->Rvs0GainSet_LTE_A2, MAXGain_1800M, MINGain_1800M);
			Sts->RvsGainAttn_LTE_A2 = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A2,MAXGain_1800M,ATTENMIN);
			
			ChkAttChange = RESET;
			
			tptr->BackUp.Rvs0GainSet_LTE_A2 = Sts->Rvs0GainSet_LTE_A2;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Rvs0GainSet_LTE_A2), Sts->Rvs0GainSet_LTE_A2, 0);
		break;

		case Aid_FwdAmpOnOff_2G:
			Sts->FwdAmpOnOff_2G = AID_Value[0];
			Sts->AmpOffCase_2G = __UsrCtrl;
			tptr->BackUp.FwdAmpOnOff_2G = Sts->FwdAmpOnOff_2G;

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_2G), Sts->FwdAmpOnOff_2G, 0);
			AmpSd_Clear(PATH_2G);

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
			Sts->AmpOffCase_LTE  = __UsrCtrl;
			tptr->BackUp.FwdAmpOnOff_LTE = Sts->FwdAmpOnOff_LTE;

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_LTE), Sts->FwdAmpOnOff_LTE, 0);
			AmpSd_Clear(PATH_LTE);
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
			tptr->BackUp.FwdAmpOnOff_3G = Sts->FwdAmpOnOff_3G;

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_3G), Sts->FwdAmpOnOff_3G, 0);
			AmpSd_Clear(PATH_3G);

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


		case Aid_FwdAmpOnOff_LTE_A2:
			Sts->FwdAmpOnOff_LTE_A2 = AID_Value[0];
			Sts->AmpOffCase_LTE_A2 = __UsrCtrl;
			tptr->BackUp.FwdAmpOnOff_LTE_A2 = Sts->FwdAmpOnOff_LTE_A2;

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_LTE_A2), Sts->FwdAmpOnOff_LTE_A2, 0);
			AmpSd_Clear(PATH_LTE_A2);
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
        
        case Aid_RepeatResetPriod:
            Sts->RepeatResetPriod = AID_Value[0];
			
			tptr->BackUp.RepeatResetPriod = Sts->RepeatResetPriod;
			Auto_ResetCheckInit();
			AutoResetCnt = 0;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RepeatResetPriod), Sts->RepeatResetPriod, 0);
        break;	

		case Aid_AGCOnOff_CDMALTE:
			Sts->AGCOnOff_CDMALTE = AID_Value[0];
			if(Sts->AGCOnOff_CDMALTE == Enable)	ChkAttChange = RESET;
			tptr->BackUp.AGCOnOff_CDMALTE = Sts->AGCOnOff_CDMALTE;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCOnOff_CDMALTE), Sts->AGCOnOff_CDMALTE, 0);
		break;	

		case Aid_AGCOnOff_LTE_A_0:
			Sts->AGCOnOff_LTE_A_0 = AID_Value[0];
			if(Sts->AGCOnOff_LTE_A_0 == Enable)	ChkAttChange = RESET;

			tptr->BackUp.AGCOnOff_LTE_A_0 = Sts->AGCOnOff_LTE_A_0;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCOnOff_LTE_A_0), Sts->AGCOnOff_LTE_A_0, 0);
		break;	

		case Aid_AGCMode_3G:
			Sts->AGCMode_3G = AID_Value[0];
			tptr->BackUp.AGCMode_3G = Sts->AGCMode_3G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCMode_3G), Sts->AGCMode_3G, 0);
		break;	
		
		case Aid_AGCMode_2G:
			Sts->AGCMode_2G = AID_Value[0];
			tptr->BackUp.AGCMode_2G = Sts->AGCMode_2G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCMode_2G), Sts->AGCMode_2G, 0);
		break;	

		case Aid_AGCMode_LTE:
			Sts->AGCMode_LTE = AID_Value[0];
			tptr->BackUp.AGCMode_LTE = Sts->AGCMode_LTE;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCMode_LTE), Sts->AGCMode_LTE, 0);
		break;	

		case Aid_AGCMode_LTE_A2:
			Sts->AGCMode_LTE_A2 = AID_Value[0];
			tptr->BackUp.AGCMode_LTE_A2 = Sts->AGCMode_LTE_A2;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCMode_LTE_A2), Sts->AGCMode_LTE_A2, 0);
		break;	

		case Aid_AutoReportPriod:
			Sts->AutoReportPriod = AID_Value[0];
			tptr->BackUp.AutoReportPriod = Sts->AutoReportPriod;
			
			PeriodStart = 1;
			TimeStart = 1;					// 자동보고 기준시 클리어 //			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AutoReportPriod), Sts->AutoReportPriod, 0);
		break;	


		case Aid_ReportTime:
			Sts->AutoReportBasePer[0] = AID_Value[0];
			Sts->AutoReportBasePer[1] = AID_Value[1];
			
			tptr->BackUp.AutoReportBasePer[0] = Sts->AutoReportBasePer[0];
			tptr->BackUp.AutoReportBasePer[1] = Sts->AutoReportBasePer[1];

			TimeStart = 1;		// 자동보고 기준시 클리어 //
			PeriodStart = 1;

			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AutoReportBasePer[i]), Sts->AutoReportBasePer[i], 0);
			}
		break;	
		
		/////////////////////////////////////////////////////////////
		case Aid_TPTL_OnOff:
			Sts->TPTL_OnOff = AID_Value[0];
			tptr->BackUp.TPTL_OnOff = Sts->TPTL_OnOff;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.TPTL_OnOff), Sts->TPTL_OnOff, 0);
		break;

		case Aid_TempOffset:
			Sts->TempOffset = AID_Value[0];
			tptr->BackUp.TempOffset = Sts->TempOffset;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.TempOffset), Sts->TempOffset, 0);
		break;

		case Aid_AlarmMask:
			Sts->AlarmMask = AID_Value[0];
			tptr->BackUp.AlarmMask = Sts->AlarmMask;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AlarmMask), Sts->AlarmMask, 0);
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
		break;

		case Aid_DefaultSet:
			Sts->DefaultSet = AID_Value[0];
			DefaultTableSet();
//			DefaultTable();
		break;

		case Aid_VccDet_Lmt:
			Sts->VccDet_Lmt[0] = AID_Value[0];
			Sts->VccDet_Lmt[1] = AID_Value[1];
			
			tptr->BackUp.VccDet_Lmt[0] = Sts->VccDet_Lmt[0];
			tptr->BackUp.VccDet_Lmt[1] = Sts->VccDet_Lmt[1];

			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.VccDet_Lmt[i]), Sts->VccDet_Lmt[i], 0);
			}
		break;

		case Aid_FwdInPwrOffset_2G:
			Sts->FwdInPwrOffset_2G = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_2G = Sts->FwdInPwrOffset_2G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdInPwrOffset_2G), Sts->FwdInPwrOffset_2G, 0);
		break;

		case Aid_FwdInPwrOffset_3G:
			Sts->FwdInPwrOffset_3G = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_3G = Sts->FwdInPwrOffset_3G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdInPwrOffset_3G), Sts->FwdInPwrOffset_3G, 0);
		break;

		case Aid_Rvs0OutPwrOffset_2G:
			Sts->Rvs0OutPwrOffset_2G = AID_Value[0];
			tptr->BackUp.Rvs0OutPwrOffset_2G = Sts->Rvs0OutPwrOffset_2G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Rvs0OutPwrOffset_2G), Sts->Rvs0OutPwrOffset_2G, 0);
		break;

		case Aid_Rvs0OutPwrOffset_3G:
			Sts->Rvs0OutPwrOffset_3G = AID_Value[0];
			tptr->BackUp.Rvs0OutPwrOffset_3G = Sts->Rvs0OutPwrOffset_3G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Rvs0OutPwrOffset_3G), Sts->Rvs0OutPwrOffset_3G, 0);
		break;
		case Aid_FwdOutPwrOffset_2G:
			Sts->FwdOutPwrOffset_2G = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_2G = Sts->FwdOutPwrOffset_2G;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutPwrOffset_2G), Sts->FwdOutPwrOffset_2G, 0);
		break;

		case Aid_FwdOutPwrOffset_3G:
			Sts->FwdOutPwrOffset_3G = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_3G = Sts->FwdOutPwrOffset_3G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutPwrOffset_3G), Sts->FwdOutPwrOffset_3G, 0);
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
//			ChkAttChange = SET;
			}
		break;


		case Aid_FwdAttn1_3G:
			Sts->FwdAttn1_3G = AID_Value[0];
			CurrFwdAttn1_3G = 0xff;
			ChkAttChange = SET;
		break;

		case Aid_FwdAttn2_3G:
			Sts->FwdAttn2_3G = AID_Value[0];
			CurrFwdAttn2_3G = 0xff;
			ChkAttChange = SET;
		break;
		
		case Aid_RvsAttn1_2G:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn1_2G 		= AID_Value[0];
				Sts->AttOffset.RvsAttn1_2G = 0;
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
				
		case Aid_RvsAttn1_3G:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAttn1_3G = AID_Value[0];
				CurrRvsAttn1_3G = 0xff;
				ChkAttChange = SET;
			}
		break;

		
		case Aid_RvsAttn2_3G:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAttn2_3G = AID_Value[0];
				CurrRvsAttn2_3G = 0xff;
				ChkAttChange = SET;
			}
		break;
				
		
		case Aid_ResetPeriodCountSet:
			Sts->ResetPeriodCountSet[0] = AID_Value[0];
			Sts->ResetPeriodCountSet[1] = AID_Value[1];
			Sts->ResetPeriodCountSet[2] = AID_Value[2];	


//			Auto_ResetCheckInit();
			
			AutoResetCnt = CheckTime(tDnrSts->ResetPeriodCountSet,AutoResetCnt,1);
			Ser3Ptr->printf("11 :AutoResetCnt [%d]\n", AutoResetCnt);

		break;

		case Aid_FwdInPwrOffset_LTE:
			Sts->FwdInPwrOffset_LTE = AID_Value[0];
			
			tptr->BackUp.FwdInPwrOffset_LTE = Sts->FwdInPwrOffset_LTE;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdInPwrOffset_LTE), Sts->FwdInPwrOffset_LTE, 0);
		break;

		case Aid_FwdOutPwrOffset_LTE:
			Sts->FwdOutPwrOffset_LTE = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_LTE = Sts->FwdOutPwrOffset_LTE;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutPwrOffset_LTE), Sts->FwdOutPwrOffset_LTE, 0);
		break;


		case Aid_Rvs0OutPwrOffset_LTE:
			Sts->RvsOutPwrOffset_LTE = AID_Value[0];
			tptr->BackUp.RvsOutPwrOffset_LTE = Sts->RvsOutPwrOffset_LTE;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsOutPwrOffset_LTE), Sts->RvsOutPwrOffset_LTE, 0);
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
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainOffset_3G), Sts->FwdGainOffset_3G, 0);
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_3G:
			Sts->InitRvsGainOffset_3G = Sts->RvsGainOffset_3G = AID_Value[0];
			tptr->BackUp.RvsGainOffset_3G = Sts->RvsGainOffset_3G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainOffset_3G), Sts->RvsGainOffset_3G, 0);
			ChkAttChange = RESET;
		break;

		case Aid_FwdGainOffset_2G:
			Sts->FwdGainOffset_2G = AID_Value[0];
			tptr->BackUp.FwdGainOffset_2G = Sts->FwdGainOffset_2G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainOffset_2G), Sts->FwdGainOffset_2G, 0);
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_2G:
			Sts->InitRvsGainOffset_2G = Sts->RvsGainOffset_2G = AID_Value[0];
			tptr->BackUp.RvsGainOffset_2G = Sts->RvsGainOffset_2G;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainOffset_2G), Sts->RvsGainOffset_2G, 0);
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
				INT8U *sptr;
				for(i = 0; i < (sizeof(__DET)); i++)	 *((INT8U *)&(Sts->DetOffset.FwdOutPwr_CDMALTE) + i) = AID_Value[i];
				memcpy((INT8U*)&tptr->BackUp.DetOffset, (INT8U*)&Sts->DetOffset, sizeof(Sts->DetOffset));
                sptr = (INT8U *)&(Sts->DetOffset.FwdOutPwr_CDMALTE);

				for(i = 0; i < (sizeof(__DET)); i++)
				{
					WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DetOffset.FwdOutPwr_CDMALTE + i), sptr[i], 0);
				}
			}	
		break;

		case Aid_FwdInPwrOffset_LTE_A2:
			Sts->FwdInPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_LTE_A2 = Sts->FwdInPwrOffset_LTE_A2;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdInPwrOffset_LTE_A2), Sts->FwdInPwrOffset_LTE_A2, 0);
		break;

		case Aid_FwdOutPwrOffset_LTE_A2:
			Sts->FwdOutPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_LTE_A2 = Sts->FwdOutPwrOffset_LTE_A2;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutPwrOffset_LTE_A2), Sts->FwdOutPwrOffset_LTE_A2, 0);
		break;

		case Aid_RvsOutPwrOffset_LTE_A2:
			Sts->RvsOutPwrOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.RvsOutPwrOffset_LTE_A2 = Sts->RvsOutPwrOffset_LTE_A2;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsOutPwrOffset_LTE_A2), Sts->RvsOutPwrOffset_LTE_A2, 0);
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

        case Aid_RvsAttn2_CDMALTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn2_CDMALTE = AID_Value[0];
				CurrRvsAttn2_CDMALTE = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn3_CDMALTE:
			if( Sts->AGCOnOff_CDMALTE == Disable)
			{
				Sts->RvsAttn3_CDMALTE = AID_Value[0];
				CurrRvsAttn3_CDMALTE = 0xff;
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
		//			ChkAttChange = SET;
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
		//			ChkAttChange = SET;
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
		//			ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn1_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAttn1_LTE_A= AID_Value[0];
				CurrFwdAttn1_LTEA = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn1_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn1_LTE_A = AID_Value[0];
				CurrRvsAttn1_LTEA = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn2_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn2_LTE_A = AID_Value[0];
				CurrRvsAttn2_LTEA = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn3_LTE_A:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->RvsAttn3_LTE_A = AID_Value[0];
				CurrRvsAttn3_LTEA = 0xff;
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
		//			CurrRvsAttn3_LTE = 0xff;
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

		case Aid_FwdGainOffset_LTE:
			Sts->FwdGainOffset_LTE = AID_Value[0];
			tptr->BackUp.FwdGainOffset_LTE = Sts->FwdGainOffset_LTE;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainOffset_LTE), Sts->FwdGainOffset_LTE, 0);
		break;

		case Aid_RvsGainOffset_LTE:
			Sts->InitRvsGainOffset_LTE = Sts->RvsGainOffset_LTE = AID_Value[0];
			
			tptr->BackUp.RvsGainOffset_LTE = Sts->RvsGainOffset_LTE;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainOffset_LTE), Sts->RvsGainOffset_LTE, 0);
			ChkAttChange = RESET;
		break;

		case Aid_FwdGainOffset_LTE_A2:
			Sts->FwdGainOffset_LTE_A2 = AID_Value[0];
			tptr->BackUp.FwdGainOffset_LTE_A2 = Sts->FwdGainOffset_LTE_A2;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainOffset_LTE_A2), Sts->FwdGainOffset_LTE_A2, 0);
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_LTE_A2:
			Sts->InitRvsGainOffset_LTE_A2 = Sts->RvsGainOffset_LTE_A2 = AID_Value[0];
			
			tptr->BackUp.RvsGainOffset_LTE_A2 = Sts->RvsGainOffset_LTE_A2;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainOffset_LTE_A2), Sts->RvsGainOffset_LTE_A2, 0);
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
		
		case Aid_FwdAgcAttn_LTE_A2:
			if( Sts->AGCOnOff_LTE_A_0 == Disable)
			{
				Sts->FwdAgcAttn_LTE_A2 = AID_Value[0];
			}
		break;
				
		
		case Aid_FwdAgcAttn_3G:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
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
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAlcAttn_3G = AID_Value[0];
			}
		break;

		case Aid_RvsAlcOnOff_2G:
			Sts->RvsAlcOnOff_2G = AID_Value[0];
		break;

		case Aid_RvsAlcOnOff_LTE:
			Sts->RvsAlcOnOff_LTE = AID_Value[0];
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

		case Aid_ShutDownOnOff_LTE_A2:
			Sts->ShutDownOnOff_LTE_A2= AID_Value[0];
		break;

		case Aid_RvsOutUpperLmt_LTE:
 			Sts->RvsOutUpperLmt_LTE[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_LTE[1] = AID_Value[1];
		break;
		
		case Aid_RvsOutUpperLmt_LTE_A2:
 			Sts->RvsOutUpperLmt_LTE_A2[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_LTE_A2[1] = AID_Value[1];
		break;

		case Aid_FwdOutHighLmt_LTE:
 			Sts->FwdOutHighLmt_LTE[0] = AID_Value[0];
 			Sts->FwdOutHighLmt_LTE[1] = AID_Value[1];
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

		case Aid_OverInAlarmLmt_LTE_A2:
 			Sts->OverInAlarmLmt_LTE_A2 = AID_Value[0];
		break;


		case Aid_OverInAlarmLmt_3G:
 			Sts->OverInAlarmLmt_3G = AID_Value[0];
		break;

		case Aid_RvsALCLvl_2G:
			Sts->RvsALCLvl_2G = AID_Value[0];
			tptr->BackUp.RvsALCLvl_2G = Sts->RvsALCLvl_2G;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsALCLvl_2G), Sts->RvsALCLvl_2G, 0);
		break;

		case Aid_RvsALCLvl_LTE:
			Sts->RvsALCLvl_LTE = AID_Value[0];
			tptr->BackUp.RvsALCLvl_LTE = Sts->RvsALCLvl_LTE;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsALCLvl_LTE), Sts->RvsALCLvl_LTE, 0);
		break;

		case Aid_RvsALCLvl_LTE_A2:
			Sts->RvsALCLvl_LTE_A2 = AID_Value[0];
			tptr->BackUp.RvsALCLvl_LTE = Sts->RvsALCLvl_LTE_A2;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsALCLvl_LTE_A2), Sts->RvsALCLvl_LTE_A2, 0);
			
		break;


		case Aid_RvsALCLvl_3G:
			Sts->RvsALCLvl_3G = AID_Value[0];
			tmpRvsALCLvl_3G = Sts->RvsALCLvl_3G;
			
			tptr->BackUp.RvsALCLvl_3G = Sts->RvsALCLvl_3G;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsALCLvl_3G), Sts->RvsALCLvl_3G, 0);
		break;

//ETC
		case Aid_RCUReset:
			Chk_Reset = SET;
		break;

//////////////////////////Wave
		case Aid_RxMaxVal  :
		  Sts->WaveCtrl.RxMaxVal[0] = AID_Value[0];
		  Sts->WaveCtrl.RxMaxVal[1] = AID_Value[1];

		  tptr->BackUp.RxMaxVal[0] = Sts->WaveCtrl.RxMaxVal[0];
		  tptr->BackUp.RxMaxVal[1] = Sts->WaveCtrl.RxMaxVal[1];
		  for(i = 0; i < 2; i++)
		  {
			  WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RxMaxVal[i]), Sts->WaveCtrl.RxMaxVal[i], 0);
		  }
		break;		


		case Aid_RxMinVal  :
		  Sts->WaveCtrl.RxMinVal[0] = AID_Value[0];
		  Sts->WaveCtrl.RxMinVal[1] = AID_Value[1];

		  tptr->BackUp.RxMinVal[0] = Sts->WaveCtrl.RxMinVal[0];
		  tptr->BackUp.RxMinVal[1] = Sts->WaveCtrl.RxMinVal[1];
		  
		  for(i = 0; i < 2; i++)
		  {
			  WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RxMinVal[i]), Sts->WaveCtrl.RxMinVal[i], 0);
		  }
		break;			

		case Aid_TxMaxVal  :
		  Sts->WaveCtrl.TxMaxVal[0] = AID_Value[0];
		  Sts->WaveCtrl.TxMaxVal[1] = AID_Value[1];
		  tptr->BackUp.TxMaxVal[0] = Sts->WaveCtrl.TxMaxVal[0];
		  tptr->BackUp.TxMaxVal[1] = Sts->WaveCtrl.TxMaxVal[1];
					  
		  for(i = 0; i < 2; i++)
		  {
			  WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.TxMaxVal[i]), Sts->WaveCtrl.TxMaxVal[i], 0);
		  }
		break;		

		case Aid_TxMinVal  :
		  Sts->WaveCtrl.TxMinVal[0] = AID_Value[0];
		  Sts->WaveCtrl.TxMinVal[1] = AID_Value[1];
		  tptr->BackUp.TxMinVal[0] = Sts->WaveCtrl.TxMinVal[0];
		  tptr->BackUp.TxMinVal[1] = Sts->WaveCtrl.TxMinVal[1];		  
		  for(i = 0; i < 2; i++)
		  {
			  WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.TxMinVal[i]), Sts->WaveCtrl.TxMinVal[i], 0);
		  }
		break;			

		case Aid_EcIo:
		  Sts->WaveCtrl.EcIo = AID_Value[0];
		  
		  tptr->BackUp.EcIo = Sts->WaveCtrl.EcIo;
		  WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.EcIo), Sts->WaveCtrl.EcIo, 0);
		break;			

		case Aid_ARMode:
		  Sts->WaveCtrl.AR_Mode[0] = AID_Value[0];
		  Sts->WaveCtrl.AR_Mode[1] = AID_Value[1];

		  tptr->BackUp.AR_Mode[0] = Sts->WaveCtrl.AR_Mode[0];
		  tptr->BackUp.AR_Mode[1] = Sts->WaveCtrl.AR_Mode[1];		  
		  for(i = 0; i < 2; i++)
		  {
			  WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AR_Mode[i]), Sts->WaveCtrl.AR_Mode[i], 0);
		  }
		break;			

		case Aid_RadioReportTime  :
			Sts->WaveCtrl.Radio_ReportTime[0] = AID_Value[0];
			Sts->WaveCtrl.Radio_ReportTime[1] = AID_Value[1];

			tptr->BackUp.Radio_ReportTime[0] = Sts->WaveCtrl.Radio_ReportTime[0];
			tptr->BackUp.Radio_ReportTime[1] = Sts->WaveCtrl.Radio_ReportTime[1];		

			WTwoTimeStart = 1;

			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Radio_ReportTime[i]), Sts->WaveCtrl.Radio_ReportTime[i], 0);
			}
		break;			

		case Aid_RadioReportPeriod	  :
		  Sts->WaveCtrl.Radio_ReportPeriod[0] = AID_Value[0];
		  Sts->WaveCtrl.Radio_ReportPeriod[1] = AID_Value[1];
		  tptr->BackUp.Radio_ReportPeriod[0] = Sts->WaveCtrl.Radio_ReportPeriod[0];
		  tptr->BackUp.Radio_ReportPeriod[1] = Sts->WaveCtrl.Radio_ReportPeriod[1];	  
		  
		  WTwoPeriodStart= 1;		  
		  for(i = 0; i < 2; i++)
		  {
			  WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Radio_ReportPeriod[i]), Sts->WaveCtrl.Radio_ReportPeriod[i], 0);
		  }
		break;			

		case Aid_TestStn :
			for(i=0;i<11;i++)
			{
				TestStation[i] = AID_Value[i];
				Sts->TestStn[i] = AID_Value[i];
				Sts->WaveCtrl.TestStn[i]= TestStation[i];
				if ((TestStation[i]<'0')||(TestStation[i]>'9') )TestStation[i] = 0x00;
			}

			memcpy((INT8U*)&tptr->BackUp.TestStn, (INT8U*)&Sts->TestStn, sizeof(Sts->TestStn));
			for(i = 0; i < 11; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.TestStn[i]), Sts->TestStn[i], 0);
			}
		break;


		case Aid_HostStn:
			for(i = 0; i < 11; i++)
			{
				Sts->HostNumber[i] = AID_Value[i];
				if ((Sts->HostNumber[i]<'0')||(Sts->HostNumber[i]>'9') )Sts->HostNumber[i] = 0x00;
			}		
			
			memcpy((INT8U*)&tptr->BackUp.HostNumber, (INT8U*)&Sts->HostNumber, sizeof(Sts->HostNumber));

			for(i = 0; i < 11; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.HostNumber[i]), Sts->HostNumber[i], 0);
			}
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

			if( Sts->FemtocellUseOnOff.LTE_21 == __NOTUSE)
			{
				Sts->FwdAmpOnOff_LTE_21 = Enable;
				Sts->AmpOffCase_LTE_21  = __UsrCtrl;
			}
			else 
			{
				Sts->FwdAmpOnOff_LTE_21 = Disable;
				Sts->AmpOffCase_LTE_21 = __UsrCtrl;
			}


			tptr->BackUp.FemtocellUseOnOff 		= Sts->FemtocellUseOnOff.Data;	
			tptr->BackUp.FwdAmpOnOff_LTE 		= Sts->FwdAmpOnOff_LTE;
			tptr->BackUp.FwdAmpOnOff_LTE_A2 	= Sts->FwdAmpOnOff_LTE_A2;
			tptr->BackUp.FwdAmpOnOff_LTE_21 	= Sts->FwdAmpOnOff_LTE_21;

			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FemtocellUseOnOff), Sts->FemtocellUseOnOff.Data, 0);
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_LTE 	), Sts->FwdAmpOnOff_LTE, 0);
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_LTE_A2 ), Sts->FwdAmpOnOff_LTE_A2, 0);
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_LTE_21 ), Sts->FwdAmpOnOff_LTE_21, 0);

		break;	

		case Aid_OverInputAGCOnOff:
			Sts->OverInputAGCOnOff = AID_Value[0];
			
			Sts->RvsOtherOverInAlarmCount = 0;
			Sts->RvsOverInAlarmCount      = 0;
		break;		

		case Aid_ShunDownTime:
			Sts->ShunDownTime = AID_Value[0];
//			Sts->FwdOutPwr_2G[0] = 21;
		break;		

		case Aid_DCOffSet:
			Sts->DCOffSet[0]	= AID_Value[0];
			Sts->DCOffSet[1]	= AID_Value[1];

			tptr->BackUp.DCOffSet[0] = Sts->DCOffSet[0];		
			tptr->BackUp.DCOffSet[1] = Sts->DCOffSet[1];		

			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DCOffSet[i]), Sts->DCOffSet[i], 0);
			}
		break;

///////////////////////////////////////////////////////
		case Aid_FwdOutUpperLmt_LTE_21:
			Sts->FwdOutUpperLmt_LTE_21[0] = AID_Value[0];
			Sts->FwdOutUpperLmt_LTE_21[1] = AID_Value[1];

			tptr->BackUp.FwdOutUpperLmt_LTE_21[0] = Sts->FwdOutUpperLmt_LTE_21[0];
			tptr->BackUp.FwdOutUpperLmt_LTE_21[1] = Sts->FwdOutUpperLmt_LTE_21[1];

			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_LTE_21[i]), Sts->FwdOutUpperLmt_LTE_21[i], 0);
			}
		break;

		case Aid_FwdOutLowerLmt_LTE_21:
			Sts->FwdOutLowerLmt_LTE_21[0] = AID_Value[0];
			Sts->FwdOutLowerLmt_LTE_21[1] = AID_Value[1];
			tptr->BackUp.FwdOutLowerLmt_LTE_21[0] = Sts->FwdOutLowerLmt_LTE_21[0];
			tptr->BackUp.FwdOutLowerLmt_LTE_21[1] = Sts->FwdOutLowerLmt_LTE_21[1];
			for(i = 0; i < 2; i++)
			{
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutLowerLmt_LTE_21[i]), Sts->FwdOutLowerLmt_LTE_21[i], 0);
			}
		break;


		case Aid_FwdGainSet_LTE_21:
			Sts->FwdGainSet_LTE_21 = AID_Value[0];
			if(nPtr== SmsSer)Sts->FwdGainSet_LTE_21 = Sts->FwdGainSet_LTE_21*2;

			Sts->FwdGainSet_LTE_21 = MinMaxAttnCheck(Sts->FwdGainSet_LTE_21, MAXGain_2100M, MINGain_2100M);
			Sts->FwdAgcAttn_LTE_21 = GainAttnCalculation(Sts->FwdGainSet_LTE_21, MAXGain_2100M, MINGain_2100M);
			ChkAttChange = RESET;
			tptr->BackUp.FwdGainSet_LTE_21 = Sts->FwdGainSet_LTE_21;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainSet_LTE_21), Sts->FwdGainSet_LTE_21, 0);
		break;

		case Aid_RvsGainSet_LTE_21:
			Sts->RvsGainSet_LTE_21 = AID_Value[0];
			if(nPtr== SmsSer)Sts->RvsGainSet_LTE_21 = Sts->RvsGainSet_LTE_21*2;
			
			Sts->RvsGainSet_LTE_21 = MinMaxAttnCheck(Sts->RvsGainSet_LTE_21, MAXGain_2100M, MINGain_2100M);
			Sts->RvsGainAttn_LTE_21 = GainAttnCalculation(Sts->RvsGainSet_LTE_21,MAXGain_2100M,MINGain_2100M);
			
			tptr->BackUp.RvsGainSet_LTE_21 = Sts->RvsGainSet_LTE_21;
			ChkAttChange = RESET;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainSet_LTE_21), Sts->RvsGainSet_LTE_21, 0);
		break;

		case Aid_FwdAmpOnOff_LTE_21:
			Sts->FwdAmpOnOff_LTE_21 = AID_Value[0];
			Sts->AmpOffCase_LTE_21 = __UsrCtrl;
			tptr->BackUp.FwdAmpOnOff_LTE_21 = Sts->FwdAmpOnOff_LTE_21;

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdAmpOnOff_LTE_21), Sts->FwdAmpOnOff_LTE_21, 0);

			AmpSd_Clear(PATH_LTE_21);

			if(Sts->FwdAmpOnOff_LTE_21== Enable)
			{
				Sts->AlmSts.FwdAmpOnOff_LTE_21 = Enable;
				
				Sts->SD_Status_LTE_21 = SD_AMP_ON;
				Amp_Step[PATH_LTE_21] = 10;
			}
			else
			{
				Sts->AlmSts.FwdAmpOnOff_LTE_21= Disable;
			}			
		break;	


		case Aid_LTE_21Use:
			Sts->LTE_21Use = AID_Value[0];
			tptr->BackUp.LTE_21Use = Sts->LTE_21Use;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.LTE_21Use), Sts->LTE_21Use, 0);
		break;	

		case Aid_AGCOnOff_WCDMALTE_21:
			Sts->AGCOnOff_WCDMALTE_21 = AID_Value[0];
			if(Sts->AGCOnOff_WCDMALTE_21 == Enable)	ChkAttChange = RESET;
			tptr->BackUp.AGCOnOff_WCDMALTE_21 = Sts->AGCOnOff_WCDMALTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCOnOff_WCDMALTE_21), Sts->AGCOnOff_WCDMALTE_21, 0);
		break;
		
		case Aid_AGCMode_LTE_21:
			Sts->AGCMode_LTE_21 = AID_Value[0];
			tptr->BackUp.AGCMode_LTE_21 = Sts->AGCMode_LTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AGCMode_LTE_21), Sts->AGCMode_LTE_21, 0);
		break;	

		case Aid_FwdInPwrOffset_LTE_21:
			Sts->FwdInPwrOffset_LTE_21 = AID_Value[0];
			tptr->BackUp.FwdInPwrOffset_LTE_21 = Sts->FwdInPwrOffset_LTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdInPwrOffset_LTE_21), Sts->FwdInPwrOffset_LTE_21, 0);
		break;

		case Aid_RvsOutPwrOffset_LTE_21:
			Sts->RvsOutPwrOffset_LTE_21 = AID_Value[0];
			tptr->BackUp.RvsOutPwrOffset_LTE_21 = Sts->RvsOutPwrOffset_LTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsOutPwrOffset_LTE_21), Sts->RvsOutPwrOffset_LTE_21, 0);
		break;

		case Aid_FwdOutPwrOffset_LTE_21:
			Sts->FwdOutPwrOffset_LTE_21 = AID_Value[0];
			tptr->BackUp.FwdOutPwrOffset_LTE_21 = Sts->FwdOutPwrOffset_LTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutPwrOffset_LTE_21), Sts->FwdOutPwrOffset_LTE_21, 0);
		break;

		case Aid_FwdAttn1_LTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->FwdAttn1_LTE_21 = AID_Value[0];
				CurrFwdAttn1_LTE_21= 0xff;
				ChkAttChange = SET;
			}
		break;

		case Aid_FwdAttn2_LTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->FwdAttn2_LTE_21 = AID_Value[0];
				CurrFwdAttn2_LTE_21= 0xff;
				ChkAttChange = SET;
			}
		break;
	
		case Aid_RvsAttn1_LTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAttn1_LTE_21		= AID_Value[0];
				CurrRvsAttn1_LTE_21 = 0xff;
				ChkAttChange = SET;
			}
		break;
		
		case Aid_RvsAttn2_LTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAttn2_LTE_21 = AID_Value[0];
				CurrRvsAttn2_LTE_21 = 0xff;
				ChkAttChange = SET;
			}
		break;
		
		case Aid_ShutDownOnOff_LTE_21:
			Sts->ShutDownOnOff_LTE_21 = AID_Value[0];
		break;

	
		case Aid_RvsOutUpperLmt_LTE_21:
 			Sts->RvsOutUpperLmt_LTE_21[0] = AID_Value[0];
 			Sts->RvsOutUpperLmt_LTE_21[1] = AID_Value[1];
		break;	

		case Aid_FwdGainOffset_LTE_21:
			Sts->FwdGainOffset_LTE_21 = AID_Value[0];
			tptr->BackUp.FwdGainOffset_LTE_21 = Sts->FwdGainOffset_LTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainOffset_LTE_21), Sts->FwdGainOffset_LTE_21, 0);
			ChkAttChange = RESET;
		break;

		case Aid_RvsGainOffset_LTE_21:
			Sts->InitRvsGainOffset_LTE_21 = Sts->RvsGainOffset_LTE_21 = AID_Value[0];
			tptr->BackUp.RvsGainOffset_LTE_21 = Sts->RvsGainOffset_LTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainOffset_LTE_21), Sts->RvsGainOffset_LTE_21, 0);
			ChkAttChange = RESET;
		break;

		case Aid_FwdOutHighLmt_LTE_21:
 			Sts->FwdOutHighLmt_LTE_21[0] = AID_Value[0];
 			Sts->FwdOutHighLmt_LTE_21[1] = AID_Value[1];
		break;

		case Aid_FwdAttn1_WCDMALTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->FwdAttn1_WCDMALTE_21 = AID_Value[0];
				CurrFwdAttn1_WCDMALTE_21 = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn1_WCDMALTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAttn1_WCDMALTE_21 = AID_Value[0];
				CurrRvsAttn1_WCDMALTE_21 = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn2_WCDMALTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAttn2_WCDMALTE_21 = AID_Value[0];
				CurrRvsAttn2_WCDMALTE_21 = 0xff;
				ChkAttChange = SET;
			}
		break;

        case Aid_RvsAttn3_WCDMALTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAttn3_WCDMALTE_21 = AID_Value[0];
				CurrRvsAttn3_WCDMALTE_21 = 0xff;
				ChkAttChange = SET;
			}
		break;


		case Aid_FwdAgcAttn_LTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->FwdAgcAttn_LTE_21 = AID_Value[0];
			}
		break;
		
		case Aid_RvsAlcAttn_LTE_21:
			if( Sts->AGCOnOff_WCDMALTE_21 == Disable)
			{
				Sts->RvsAlcAttn_LTE_21 = AID_Value[0];
			}
		break;

		case Aid_RvsAlcOnOff_LTE_21:
			Sts->RvsAlcOnOff_LTE_21 = AID_Value[0];
		break;

		case Aid_OverInAlarmLmt_LTE_21:
 			Sts->OverInAlarmLmt_LTE_21 = AID_Value[0];
		break;

		case Aid_RvsALCLvl_LTE_21:
			Sts->RvsALCLvl_LTE_21= AID_Value[0];
			tptr->BackUp.RvsALCLvl_LTE_21 = Sts->RvsALCLvl_LTE_21;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsALCLvl_LTE_21), Sts->RvsALCLvl_LTE_21, 0);
		break;
		
		case Aid_SamplePathSel:
			Sts->SamplePathSel[0] = AID_Value[0];
			Sts->SamplePathSel[1] = AID_Value[1];
		break;

		case Aid_SampleDataOffset:
			for(i = 0; i < 4; i++)
			{
				Sts->SampleOffsetA.sD8[i] = AID_Value[i];
				tptr->BackUp.SampleOffsetA.sD8[i] = Sts->SampleOffsetA.sD8[i];
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.SampleOffsetA.sD8[i]), Sts->SampleOffsetA.sD8[i], 0);
			}
			for(i = 0; i < 2; i++)
			{
				Sts->SampleOffsetB.sD8[i] = AID_Value[4+i];

				tptr->BackUp.SampleOffsetB.sD8[i] = Sts->SampleOffsetB.sD8[i];
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.SampleOffsetB.sD8[i]), Sts->SampleOffsetB.sD8[i], 0);
			}
		break;


		case Aid_Band_Select_CDMALTE:
			for(i = 0; i < 3; i++)
			{
				Sts->Band_Select_CDMALTE[i] = AID_Value[i];
				tptr->BackUp.Band_Select_CDMALTE[i] = Sts->Band_Select_CDMALTE[i];

				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Band_Select_CDMALTE[i]), Sts->Band_Select_CDMALTE[i], 0);
			}
			
			DTU_WriteData(CS0SEL, DTU_BW_SEL_B0, Sts->Band_Select_CDMALTE[0]);
			ChkBandSelet_CDMALTE = SET;
		break;


		case Aid_Band_Select_LTE_A:
			for(i = 0; i < 3; i++)
			{
				Sts->Band_Select_LTE_A[i] = AID_Value[i];
				tptr->BackUp.Band_Select_LTE_A[i] = Sts->Band_Select_LTE_A[i];

				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Band_Select_LTE_A[i]), Sts->Band_Select_LTE_A[i], 0);
			}
			
			DTU_WriteData(CS0SEL, DTU_BW_SEL_B1, Sts->Band_Select_LTE_A[0]);
			ChkBandSelet_LTE_A = SET;
		break;

		case Aid_Band_Select_WCDMALTE_21:
			for(i = 0; i < 3; i++)
			{
				Sts->Band_Select_WCDMALTE_21[i] = AID_Value[i];
				tptr->BackUp.Band_Select_WCDMALTE_21[i] = Sts->Band_Select_WCDMALTE_21[i];

				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.Band_Select_WCDMALTE_21[i]), Sts->Band_Select_WCDMALTE_21[i], 0);
			}
			
			DTU_WriteData(CS0SEL, DTU_BW_SEL_B2, Sts->Band_Select_WCDMALTE_21[0]);
			ChkBandSelet_WCDMALTE_21 = SET;

			if(Sts->Band_Select_WCDMALTE_21[0] == 0)		//10M+20M(LTEA+WCDMA)
			{
//				tDnrSts->FilterUSE[4] = RESET;
//				tDnrSts->FilterUSE[5] = RESET;
				tDnrSts->FilterStart = Disable;

			}
			else if(Sts->Band_Select_WCDMALTE_21[0] == 3)	//	20MHz+10M(LTEA+WCDMA)  
			{
//				tDnrSts->FilterUSE[4] = SET;
//				tDnrSts->FilterUSE[5] = SET;
				tDnrSts->FilterStart = Enable;
			}
			
			{
				tptr->BackUp.FilterStart = Sts->FilterStart;
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FilterStart), Sts->FilterStart, 0);
				OSTimeDly(100);
				Chk_Reset= SET;
			}
		break;


		case Aid_RvsGainBalance_WCDMALTE_21:
			Sts->RvsGainBalance_WCDMALTE_21= AID_Value[0];
			tptr->BackUp.RvsGainBalance_WCDMALTE_21 = Sts->RvsGainBalance_WCDMALTE_21;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainBalance_WCDMALTE_21), Sts->RvsGainBalance_WCDMALTE_21, 0);
		break;

		case Aid_RvsGainBalance_CDMALTE:
			Sts->RvsGainBalance_CDMALTE= AID_Value[0];
			tptr->BackUp.RvsGainBalance_CDMALTE = Sts->RvsGainBalance_CDMALTE;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainBalance_CDMALTE), Sts->RvsGainBalance_CDMALTE, 0);
		break;

		case Aid_RvsGainBalance_LTE_A:
			Sts->RvsGainBalance_LTE_A= AID_Value[0];
			tptr->BackUp.RvsGainBalance_LTE_A = Sts->RvsGainBalance_LTE_A;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsGainBalance_LTE_A), Sts->RvsGainBalance_LTE_A, 0);
		break;
//////////////////////////////
		
		case Aid_DTUPeakOffset:
			for(i = 0; i < DTU_Power_MAX; i++)
			{
				Sts->DTUPeakOffset[i].sD8[0] = AID_Value[2*i+0];
				Sts->DTUPeakOffset[i].sD8[1] = AID_Value[2*i+1];

				tptr->BackUp.DTUPeakOffset[i].sD8[0] = Sts->DTUPeakOffset[i].sD8[0];
				tptr->BackUp.DTUPeakOffset[i].sD8[1]= Sts->DTUPeakOffset[i].sD8[1];

				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DTUPeakOffset[i].sD8[0]), Sts->DTUPeakOffset[i].sD8[0], 0);
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DTUPeakOffset[i].sD8[1]), Sts->DTUPeakOffset[i].sD8[1], 0);
			}
			DTUTest = RESET;
		break;


		case Aid_DTUAverOffset:
			for(i = 0; i < DTU_Power_MAX; i++)
			{
				Sts->DTUAverOffset[i].sD8[0] = AID_Value[2*i+0];
				Sts->DTUAverOffset[i].sD8[1] = AID_Value[2*i+1];

				tptr->BackUp.DTUAverOffset[i].sD8[0] = Sts->DTUAverOffset[i].sD8[0];
				tptr->BackUp.DTUAverOffset[i].sD8[1]= Sts->DTUAverOffset[i].sD8[1];

				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DTUAverOffset[i].sD8[0]), Sts->DTUAverOffset[i].sD8[0], 0);
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DTUAverOffset[i].sD8[1]), Sts->DTUAverOffset[i].sD8[1], 0);
			}
			DTUTest = RESET;
		break;

		case Aid_SmartAGCDLOnOff:
			Sts->SmartAGCDLOnOff.Data = AID_Value[0];
			DTU_WriteData(CS0SEL, DTU_DLAGCOnOff, Sts->SmartAGCDLOnOff.Data);
		break;

		case Aid_SmartAGCULOnOff:
			Sts->SmartAGCULOnOff.Data = AID_Value[0];
			DTU_WriteData(CS0SEL, DTU_ULAGCOnOff, Sts->SmartAGCULOnOff.Data);
		break;

		case Aid_DTU_DLAGCLevel:
			for(i = 0; i < SvrPATH_MAX; i++)
			{
				for(j = 0; j < 2; j++){
					Sts->DTU_DLAGCLevel[i][j] = AID_Value[2*i+j];
					tptr->BackUp.DTU_DLAGCLevel[i][j] = Sts->DTU_DLAGCLevel[i][j];
					
					WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DTU_DLAGCLevel[i][j]), Sts->DTU_DLAGCLevel[i][j], 0);
					addr = DTU_DLLAGCLevel_800M + 2*i + j;
					Data = Sts->DTU_DLAGCLevel[i][j] - DTU_INIT_AGClevel;
					DTU_WriteData(CS0SEL, addr, Data);
				}
			}
		break;

		case Aid_DTU_ULAGCLevel:
			for(i = 0; i < SvrPATH_MAX; i++)
			{
				for(j = 0; j < 2; j++){
					Sts->DTU_ULAGCLevel[i][j] = AID_Value[2*i+j];
					tptr->BackUp.DTU_ULAGCLevel[i][j] = Sts->DTU_ULAGCLevel[i][j];
					WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DTU_ULAGCLevel[i][j]), Sts->DTU_ULAGCLevel[i][j], 0);
					addr = DTU_ULLAGCLevel_800M + 2*i + j;
					Data = Sts->DTU_ULAGCLevel[i][j] - DTU_INIT_AGClevel;
					DTU_WriteData(CS0SEL, addr, Data);
				}
			}
		break;

		case Aid_ISOOffset:
			for(i = 0; i < DTU_ISO_MAX; i++)
			{
				Sts->ISOOffset[i].sD8[0] = AID_Value[2*i+0];
				Sts->ISOOffset[i].sD8[1] = AID_Value[2*i+1];
			
				tptr->BackUp.ISOOffset[i].sD8[0] = Sts->ISOOffset[i].sD8[0];
				tptr->BackUp.ISOOffset[i].sD8[1] = Sts->ISOOffset[i].sD8[1];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ISOOffset[i].sD8[0]), Sts->ISOOffset[i].sD8[0], 0);
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ISOOffset[i].sD8[1]), Sts->ISOOffset[i].sD8[1], 0);
			}
		break;

		case Aid_ISOOnOff:
		{
			INT8U AlmSts = 0;
			AlmSts = tDnrSts->AlmSts.FwdAmpOnOff_2G + tDnrSts->AlmSts.FwdAmpOnOff_LTE +
					 tDnrSts->AlmSts.FwdAmpOnOff_3G + tDnrSts->AlmSts.FwdAmpOnOff_LTE_21
					+ tDnrSts->AlmSts.FwdAmpOnOff_LTE_A2;
			
			Sts->ISOSelect 	= AID_Value[0];
			if(AlmSts < 5) Sts->ISOOnOff 	= AID_Value[1];
			Sts->ISOMode 	= AID_Value[2];
//			Sts->ISOStartCnt 	= AID_Value[3];
//			Sts->ISOSampleAvg 	= AID_Value[4];



			TimerRegist(Timer_ISOStop, (Time1Min * 20L));

			if(tDnrSts->ISOMode == 0x01)
			{
				if( tDnrSts->ISOOnOff == Enable)
				{
					ChkISO = SET;
//					ISOOnOffStart = SET;
					ISOManualCnt = 0;

					DTU_WriteData(CS0SEL, DTU_ISOPathSel, tDnrSts->ISOSelect);
				}
			    else
		    	{
					ChkISO = RESET;
					ISOOnOffStart = RESET;
					ISOOnOffMode = 0;
		    	}

			}
			else
			{
				if( tDnrSts->ISOOnOff == Enable)
				{
					tDnrSts->ISOSelect = 0x04;

					IsolationPathSelect(tDnrSts->ISOSelect);

					ChkISO = SET;
					ISOOnOffStart = SET;
					ISOOnOffMode = 2;
				}
			    else
		    	{
					ChkISO = RESET;
					ISOOnOffStart = RESET;
					ISOOnOffMode = 0;
		    	}

			}
		}
		break;

		case Aid_PathOnOff_800M:
			Sts->PathOnOff_800M.Data = AID_Value[0];
			DTU_WriteData(CS0SEL, DTU_PATHOnOff_800M, Sts->PathOnOff_800M.Data);
		break;

		case Aid_PathOnOff_1800M:
			Sts->PathOnOff_1800M.Data = AID_Value[0];
			DTU_WriteData(CS0SEL, DTU_PATHOnOff_1800M, Sts->PathOnOff_1800M.Data);
		break;

		case Aid_PathOnOff_2100M:
			Sts->PathOnOff_2100M.Data = AID_Value[0];
			DTU_WriteData(CS0SEL, DTU_PATHOnOff_2100M, Sts->PathOnOff_2100M.Data);
		break;

		case Aid_ULGainPriod:
			Sts->ULGainPriod= AID_Value[0];
			tptr->BackUp.ULGainPriod = Sts->ULGainPriod;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ULGainPriod), Sts->ULGainPriod, 0);

			TimerRegist(TimerULGainPriod, Time1Sec * 5L);
		break;

		case Aid_ULGainMode:
			Sts->ULGainMode= AID_Value[0];
			tptr->BackUp.ULGainMode = Sts->ULGainMode;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ULGainMode), Sts->ULGainMode, 0);
			TimerRegist(TimerULGainPriod, Time1Sec * 5L);
		break;

		case Aid_ULGainOutLmt:
			Sts->ULGainOutLmt[0] = AID_Value[0];
			Sts->ULGainOutLmt[1] = AID_Value[1];
			Sts->ULGainOutLmt[2] = AID_Value[2];

			tptr->BackUp.ULGainOutLmt[0] = Sts->ULGainOutLmt[0];
			tptr->BackUp.ULGainOutLmt[1] = Sts->ULGainOutLmt[1];
			tptr->BackUp.ULGainOutLmt[2] = Sts->ULGainOutLmt[2];
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ULGainOutLmt[0]), Sts->ULGainOutLmt[0], 0);
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ULGainOutLmt[1]), Sts->ULGainOutLmt[1], 0);
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ULGainOutLmt[2]), Sts->ULGainOutLmt[2], 0);
		break;

		case Aid_RvsInPwrOffset:
			for(i = 0; i < PATH_MAX; i++)
			{
				Sts->RvsInPwrOffset[i] = AID_Value[i];
				tptr->BackUp.RvsInPwrOffset[i] = Sts->RvsInPwrOffset[i];
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.RvsInPwrOffset[i]), Sts->RvsInPwrOffset[i], 0);
			}
		break;

		case Aid_PLLOffset:
			for(i = 0; i < SvrPATH_MAX; i++)
			{
				Sts->PLLOffset[i] = AID_Value[i];
				tptr->BackUp.PLLOffset[i] = Sts->PLLOffset[i];
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.PLLOffset[i]), Sts->PLLOffset[i], 0);
			}

			ChkBandSelet_CDMALTE = SET;
			ChkBandSelet_LTE_A = SET;
			ChkBandSelet_WCDMALTE_21 = SET;
		break;

		case Aid_DLISOOffset:

			for(i = 0; i < PATH_MAX; i++)
			{
				Sts->DLISOOffset[i].sD8[0] = AID_Value[2*i+0];
				Sts->DLISOOffset[i].sD8[1] = AID_Value[2*i+1];
			
				tptr->BackUp.DLISOOffset[i].sD8[0] = Sts->DLISOOffset[i].sD8[0];
				tptr->BackUp.DLISOOffset[i].sD8[1] = Sts->DLISOOffset[i].sD8[1];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DLISOOffset[i].sD8[0]), Sts->DLISOOffset[i].sD8[0], 0);
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DLISOOffset[i].sD8[1]), Sts->DLISOOffset[i].sD8[1], 0);
			}
		break;

		case Aid_ULISOOffset:
			for(i = 0; i < PATH_MAX; i++)
			{
				Sts->ULISOOffset[i].sD8[0] = AID_Value[2*i+0];
				Sts->ULISOOffset[i].sD8[1] = AID_Value[2*i+1];
			
				tptr->BackUp.ULISOOffset[i].sD8[0] = Sts->ULISOOffset[i].sD8[0];
				tptr->BackUp.ULISOOffset[i].sD8[1] = Sts->ULISOOffset[i].sD8[1];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ULISOOffset[i].sD8[0]), Sts->ULISOOffset[i].sD8[0], 0);
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.ULISOOffset[i].sD8[1]), Sts->ULISOOffset[i].sD8[1], 0);
			}
		break;


		case Aid_DTUFilterSts:
			Sts->DTUFilterSts.Data[0] = AID_Value[0];

			tptr->BackUp.DTUFilterSts.Data[0] = Sts->DTUFilterSts.Data[0];
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.DTUFilterSts.Data[0]), Sts->DTUFilterSts.Data[0], 0);
		break;

		case Aid_FilterStart:
			Sts->FilterStart = AID_Value[0];

			tptr->BackUp.FilterStart = Sts->FilterStart;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FilterStart), Sts->FilterStart, 0);
		break;

		case Aid_FilterUSE:
			for(i = 0; i < DTU_FilterDN_MAX; i++)
			{
				Sts->FilterUSE[i] = AID_Value[i];
			
				tptr->BackUp.FilterUSE[i] = Sts->FilterUSE[i];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FilterUSE[i]), Sts->FilterUSE[i], 0);
			}
		break;

		case Aid_FTPOnOff:
			Sts->FTPOnOff = AID_Value[0];
		break;

		case Aid_FTPIndex:
			Sts->FTPIndex = AID_Value[0];
		break;

		case Aid_FTPFileStep:
			Sts->FTPFileStep.uD8[0] = AID_Value[0];
			Sts->FTPFileStep.uD8[1] = AID_Value[1];
		break;


		case Aid_FTPFrameCnt:
			Sts->FTPFrameCnt.uD8[0] = AID_Value[0];
			Sts->FTPFrameCnt.uD8[1] = AID_Value[1];
		break;	

		case Aid_FTPMode:
			Sts->FTPMode = AID_Value[0];
		break;

		case Aid_FTP_IP:
			for(i = 0; i < 4; i++)
			{
				Sts->FTP_IP[i] = AID_Value[i];
			
				tptr->BackUp.FTP_IP[i] = Sts->FTP_IP[i];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_IP[i]), Sts->FTP_IP[i], 0);
			}
		break;

		case Aid_FTP_Port:
			Sts->FTP_Port = AID_Value[0];

			tptr->BackUp.FTP_Port = Sts->FTP_Port;
			
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_Port), Sts->FTP_Port, 0);
		break;		

		case Aid_FTP_ID:
			for(i = 0; i < 20; i++)
			{
				Sts->FTP_ID[i] = AID_Value[i];
			
				tptr->BackUp.FTP_ID[i] = Sts->FTP_ID[i];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_ID[i]), Sts->FTP_ID[i], 0);
			}
		break;

		case Aid_FTP_PW:
			for(i = 0; i < 20; i++)
			{
				Sts->FTP_PW[i] = AID_Value[i];
			
				tptr->BackUp.FTP_PW[i] = Sts->FTP_PW[i];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_PW[i]), Sts->FTP_PW[i], 0);
			}
		break;

		case Aid_FTP_DnFilePath:
			for(i = 0; i < 20; i++)
			{
				Sts->FTP_DnFilePath[i] = AID_Value[i];
			
				tptr->BackUp.FTP_DnFilePath[i] = Sts->FTP_DnFilePath[i];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_DnFilePath[i]), Sts->FTP_DnFilePath[i], 0);
			}
		break;


		case Aid_FTP_DnFileName:
			for(i = 0; i < 20; i++)
			{
				Sts->FTP_DnFileName[i] = AID_Value[i];
			
				tptr->BackUp.FTP_DnFileName[i] = Sts->FTP_DnFileName[i];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_DnFileName[i]), Sts->FTP_DnFileName[i], 0);
			}
		break;

		case Aid_FTP_DnHours:
			for(i = 0; i < 6; i++)
			{
				Sts->FTP_DnHours[i] = AID_Value[i];
			
				tptr->BackUp.FTP_DnHours[i] = Sts->FTP_DnHours[i];
			
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_DnHours[i]), Sts->FTP_DnHours[i], 0);
			}
		break;



//		rlen += GenAidData(Aid_FilterUSE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FilterUSE), sizeof(Sts->FilterUSE));	

        default:
		break;
	}
	
	return rval;
}



void Initialize(void)
{
	INT8U i;

	__Dnr_Sts *Sts = tDnrSts;

	StatusInitialize();	// buffer init
	LoadBackupData();	// default setting!!
	LoadTable();


	Sts->Manufacture		= 0x0B;
	Sts->Supplier			= 0x0B;
	Sts->RepeaterType[0]	= hibyte(TRIO_MD_TYPE);
	Sts->RepeaterType[1]	= lobyte(TRIO_MD_TYPE);
	Sts->SWVer				= SystemVer;
	Sts->RCUAddVer			= PROGRAMVER;	

	Sts->ISOStartCnt 	= 12;
	Sts->ISOSampleAvg 	= 3;
	
	{
		for(i = 0; i < sizeof(Sts->EsnNumber); i++)
		{
			Sts->EsnNumber[i] = 0x30;
		}

		for(i = 0; i < sizeof(Sts->MinNumber); i++)
		{
			Sts->MinNumber[i] = 0x30;
		}
	}
	

	Sts->OverInputAGCOnOff			= Disable;
	Sts->ModemOnOff 				= Enable;
	Sts->DebugOnOff					= Disable;
	
	Sts->FwdOutHighLmt_2G[0]		= FwdHighLmt_2G +3;
	Sts->FwdOutHighLmt_2G[1]		= 0;
	
	Sts->FwdOutHighLmt_LTE[0]		= FwdHighLmt_LTE + 3;
	Sts->FwdOutHighLmt_LTE[1]		= 0; 

	Sts->FwdOutHighLmt_LTE_A2[0] 	= FwdHighLmt_LTE_A2 + 3; 
	Sts->FwdOutHighLmt_LTE_A2[1] 	= 0; 
	
	Sts->FwdOutHighLmt_3G[0]		= FwdHighLmt_3G + 3;
	Sts->FwdOutHighLmt_3G[1]		= 0;

	Sts->FwdOutHighLmt_LTE_21[0]	= FwdHighLmt_LTE_21+ 3;
	Sts->FwdOutHighLmt_LTE_21[1]	= 0;

	Sts->RvsOutUpperLmt_2G[0]		= RvsHighLmt_2G+ 3;
	Sts->RvsOutUpperLmt_2G[1]		= 0;

	Sts->RvsOutUpperLmt_LTE[0]		= RvsHighLmt_LTE+ 3;
	Sts->RvsOutUpperLmt_LTE[1]		= 0;

	Sts->RvsOutUpperLmt_LTE_A2[0]	= RvsHighLmt_LTE_A+ 3;
	Sts->RvsOutUpperLmt_LTE_A2[1]	= 0;

	Sts->RvsOutUpperLmt_LTE_21[0]	= RvsHighLmt_LTE_21+ 3;
	Sts->RvsOutUpperLmt_LTE_21[1]	= 0;

	Sts->RvsOutUpperLmt_3G[0]		= RvsHighLmt_3G+ 3;
	Sts->RvsOutUpperLmt_3G[1]		= 0;

	Sts->OverInAlarmLmt_2G			= FwdOverInSDAlmLmt_2G*2; 
	Sts->OverInAlarmLmt_3G			= FwdOverInSDAlmLmt_3G*2; 
	Sts->OverInAlarmLmt_LTE_A2		= FwdOverInSDAlmLmt_LTE_A2*2; 
	Sts->OverInAlarmLmt_LTE 		= FwdOverInSDAlmLmt_LTE*2; 
	Sts->OverInAlarmLmt_LTE_21		= FwdOverInSDAlmLmt_LTE_21*2; 

//////////////////////////////////

	Sts->ShunDownTime = 0;

	Sts->ResetPeriodCountSet[0] 	= 1; 
	Sts->ResetPeriodCountSet[1] 	= 0; 
	Sts->ResetPeriodCountSet[2] 	= 0; 

#ifdef DTU_TEST
	Sts->ShutDownOnOff_2G 		= Disable;
	Sts->ShutDownOnOff_LTE		= Disable;
	Sts->ShutDownOnOff_LTE_A2	= Disable;
	Sts->ShutDownOnOff_3G 		= Disable;
	Sts->ShutDownOnOff_LTE_21 	= Disable;
	Sts->ISOOnOff               = Disable;
#else
	Sts->ShutDownOnOff_2G		= Enable;
	Sts->ShutDownOnOff_LTE		= Enable;
	Sts->ShutDownOnOff_LTE_A2	= Enable;
	Sts->ShutDownOnOff_3G		= Enable;
	Sts->ShutDownOnOff_LTE_21	= Enable;
	Sts->ISOOnOff				= Disable;
#endif

	Sts->RvsAlcOnOff_2G		  	= Enable;
	Sts->RvsAlcOnOff_LTE		= Enable;
	Sts->RvsAlcOnOff_LTE_A2	  	= Enable;
	Sts->RvsAlcOnOff_LTE_21	  	= Enable;
	Sts->RvsAlcOnOff_3G		 	= Enable;

	Sts->RvsAlcAttn_2G		  	= 0;
	Sts->RvsAlcAttn_LTE			= 0;
	Sts->RvsAlcAttn_LTE_A2		= 0;
	Sts->RvsAlcAttn_LTE_A1		= 0;
	Sts->RvsAlcAttn_LTE_21		= 0;
	Sts->RvsAlcAttn_3G		  	= 0;

	Sts->FTPOnOff 				= Disable;
	Sts->FTPIndex 				= 0;
	Sts->FTPFileStep.uD16		= 1024;
////////////////////////////////////////////////
}


void StatusInitialize(void)
{
	INT32U i = 0;
	INT8U *ptr;

	for(i = 0; i < PATH_MAX; i++)
	{
		ptr = (INT8U *)&mSDCheck[i];
		memset(ptr, 0, sizeof(__ShutDnStr)); 
	}


	for(i = 0; i < PATH_MAX; i++)
	{
		ptr = (INT8U *)&mFwdHighAlm[i];
		memset(ptr, 0, sizeof(__AlarmStr)); 
	}

	for(i = 0; i < PATH_MAX; i++)
	{
		ptr = (INT8U *)&mFwdLowAlm[i];
		memset(ptr, 0, sizeof(__AlarmStr)); 
	}

	for(i = 0; i < PATH_MAX; i++)
	{
		ptr = (INT8U *)&mRvsHighAlm[i];
		memset(ptr, 0, sizeof(__AlarmStr)); 
	}

	for(i = 0; i < PATH_MAX; i++)
	{
		ptr = (INT8U *)&mFwdInHighAlm[i];
		memset(ptr, 0, sizeof(__AlarmStr)); 
	}

	for(i = 0; i < SvrPATH_MAX; i++)
	{
		ptr = (INT8U *)&mULGainMode1[i];
		memset(ptr, 0, sizeof(__ULGainMode1)); 

		ptr = (INT8U *)&mULGainMode2[i];
		memset(ptr, 0, sizeof(__ULGainMode2)); 
	}

	for(i = 0; i < SvrPATH_MAX; i++)
	{
		ptr = (INT8U *)&mAttnStr[i];
		memset(ptr, 0, sizeof(__AttnStr)); 
	}

	for(i = 0; i < DTU_Power_MAX; i++)
	{
		tDnrSts->DTUPeakPower[i].sD16	= DTUPwrNoSignal;
		tDnrSts->DTUAverPower[i].sD16 	= DTUPwrNoSignal;
	}

	tDnrSts->DTUAverPower[DTU_ULAPower_800M_R].sD16 = -16*10;
	tDnrSts->DTUAverPower[DTU_ULAPower_800M_L].sD16 = -16*10;
}

void LoadBackupData(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	INT32U i = 0;
	INT32U j = 0;

//	INT8U err = 0;
	INT8U rval = FALSE;
    
    i = i;
    rval = rval;
//	OSSemPend(CtrlSem, 0, &err);

#if 1 	
	{
		EE_BACK1 *tptr = (EE_BACK1 *)&gEE_BACK1;
		
		INT8U iDataFlag = ReadEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.IsDataFlag), 0);

		if(iDataFlag != ISDATA){
//            DefaultTableSet();
//			DefaultBackup(TRUE);
//			DownLoadBootingJump();
		}


		////////////////////////////////////////////////////////////////////////      
        // LOAD BACKUP
		for(i = 0; i < sizeof(EE_BACK1); i++)
		{
			*((INT8U *)tptr + i) = ReadEEprom(At24cDevID, vEE_BACK1Addr + i, 0);
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

		Sts->FwdOutUpperLmt_LTE_A2[0]	= tptr->BackUp.FwdOutUpperLmt_LTE_A2[0];
		Sts->FwdOutUpperLmt_LTE_A2[1]	= tptr->BackUp.FwdOutUpperLmt_LTE_A2[1];
		Sts->FwdOutLowerLmt_LTE_A2[0]	= tptr->BackUp.FwdOutLowerLmt_LTE_A2[0];
		Sts->FwdOutLowerLmt_LTE_A2[1]	= tptr->BackUp.FwdOutLowerLmt_LTE_A2[1];
		Sts->FwdGainSet_LTE_A2			= tptr->BackUp.FwdGainSet_LTE_A2;

		Sts->FwdOutUpperLmt_LTE_21[0]	= tptr->BackUp.FwdOutUpperLmt_LTE_21[0];
		Sts->FwdOutUpperLmt_LTE_21[1]	= tptr->BackUp.FwdOutUpperLmt_LTE_21[1];
		Sts->FwdOutLowerLmt_LTE_21[0]	= tptr->BackUp.FwdOutLowerLmt_LTE_21[0];
		Sts->FwdOutLowerLmt_LTE_21[1]	= tptr->BackUp.FwdOutLowerLmt_LTE_21[1];
		Sts->FwdGainSet_LTE_21			= tptr->BackUp.FwdGainSet_LTE_21;

		Sts->Rvs0GainSet_2G 			= tptr->BackUp.Rvs0GainSet_2G;
		Sts->Rvs0GainSet_LTE			= tptr->BackUp.Rvs0GainSet_LTE;

		Sts->Rvs0GainSet_LTE_A2			= tptr->BackUp.Rvs0GainSet_LTE_A2;
		Sts->Rvs0GainSet_3G 			= tptr->BackUp.Rvs0GainSet_3G;
		Sts->RvsGainSet_LTE_21 			= tptr->BackUp.RvsGainSet_LTE_21;

		Sts->RvsGainBalance_CDMALTE		= tptr->BackUp.RvsGainBalance_CDMALTE;
		Sts->RvsGainBalance_LTE_A		= tptr->BackUp.RvsGainBalance_LTE_A;
		Sts->RvsGainBalance_WCDMALTE_21	= tptr->BackUp.RvsGainBalance_WCDMALTE_21;

		Sts->FwdAmpOnOff_2G  			= tptr->BackUp.FwdAmpOnOff_2G;
		Sts->FwdAmpOnOff_LTE			= tptr->BackUp.FwdAmpOnOff_LTE;
		Sts->FwdAmpOnOff_LTE_A2			= tptr->BackUp.FwdAmpOnOff_LTE_A2;
		Sts->FwdAmpOnOff_3G 			= tptr->BackUp.FwdAmpOnOff_3G;
		Sts->FwdAmpOnOff_LTE_21			= tptr->BackUp.FwdAmpOnOff_LTE_21;

		Sts->AlmSts.FwdAmpOnOff_2G  	= Sts->FwdAmpOnOff_2G;	
		Sts->AlmSts.FwdAmpOnOff_LTE		= Sts->FwdAmpOnOff_LTE;		
		Sts->AlmSts.FwdAmpOnOff_LTE_A2	= Sts->FwdAmpOnOff_LTE_A2;
		Sts->AlmSts.FwdAmpOnOff_3G 		= Sts->FwdAmpOnOff_3G;
		Sts->AlmSts.FwdAmpOnOff_LTE_21  = Sts->FwdAmpOnOff_LTE_21;

  	    Sts->LTE_21Use 					= tptr->BackUp.LTE_21Use;

		Sts->RepeatResetPriod 			= tptr->BackUp.RepeatResetPriod;

		Sts->FemtocellUseOnOff.Data 	= tptr->BackUp.FemtocellUseOnOff;

		Sts->Band_Select_CDMALTE[0]		= tptr->BackUp.Band_Select_CDMALTE[0];
		Sts->Band_Select_CDMALTE[1]		= tptr->BackUp.Band_Select_CDMALTE[1];
		Sts->Band_Select_CDMALTE[2]		= tptr->BackUp.Band_Select_CDMALTE[2];

		Sts->Band_Select_LTE_A[0] 	= tptr->BackUp.Band_Select_LTE_A[0];
		Sts->Band_Select_LTE_A[1] 	= tptr->BackUp.Band_Select_LTE_A[1];
		Sts->Band_Select_LTE_A[2] 	= tptr->BackUp.Band_Select_LTE_A[2];

		memcpy((INT8U*)&Sts->Band_Select_WCDMALTE_21, (INT8U*)&tptr->BackUp.Band_Select_WCDMALTE_21, sizeof(Sts->Band_Select_WCDMALTE_21));

		Sts->AGCOnOff_CDMALTE			= tptr->BackUp.AGCOnOff_CDMALTE;
		Sts->AGCOnOff_LTE_A_0			= tptr->BackUp.AGCOnOff_LTE_A_0;
		Sts->AGCOnOff_WCDMALTE_21		= tptr->BackUp.AGCOnOff_WCDMALTE_21;

		Sts->AGCMode_2G					= tptr->BackUp.AGCMode_2G;
		Sts->AGCMode_LTE				= tptr->BackUp.AGCMode_LTE;
		Sts->AGCMode_LTE_A2				= tptr->BackUp.AGCMode_LTE_A2;
		Sts->AGCMode_3G					= tptr->BackUp.AGCMode_3G;
		Sts->AGCMode_LTE_21				= tptr->BackUp.AGCMode_LTE_21;

		Sts->RvsALCLvl_2G				= tptr->BackUp.RvsALCLvl_2G;
		Sts->RvsALCLvl_LTE				= tptr->BackUp.RvsALCLvl_LTE;
		Sts->RvsALCLvl_LTE_A2			= tptr->BackUp.RvsALCLvl_LTE_A2;
		Sts->RvsALCLvl_3G				= tptr->BackUp.RvsALCLvl_3G;
		Sts->RvsALCLvl_LTE_21			= tptr->BackUp.RvsALCLvl_LTE_21;


/////////////////////////////

		Sts->AutoReportPriod			= tptr->BackUp.AutoReportPriod;
		Sts->AutoReportBasePer[0]		= tptr->BackUp.AutoReportBasePer[0];
		Sts->AutoReportBasePer[1]		= tptr->BackUp.AutoReportBasePer[1];
		Sts->TPTL_OnOff 				= tptr->BackUp.TPTL_OnOff;
		Sts->TempOffset 				= tptr->BackUp.TempOffset;
		Sts->AlarmMask					= tptr->BackUp.AlarmMask;
		Sts->VccDet_Lmt[0]				= tptr->BackUp.VccDet_Lmt[0];
		Sts->VccDet_Lmt[1]				= tptr->BackUp.VccDet_Lmt[1];

		Sts->FwdInPwrOffset_2G			= tptr->BackUp.FwdInPwrOffset_2G;
		Sts->FwdOutPwrOffset_2G 		= tptr->BackUp.FwdOutPwrOffset_2G;
		Sts->Rvs0OutPwrOffset_2G		= tptr->BackUp.Rvs0OutPwrOffset_2G;
		Sts->FwdInPwrOffset_LTE 		= tptr->BackUp.FwdInPwrOffset_LTE;
		Sts->FwdOutPwrOffset_LTE		= tptr->BackUp.FwdOutPwrOffset_LTE;
		Sts->RvsOutPwrOffset_LTE		= tptr->BackUp.RvsOutPwrOffset_LTE;
		Sts->FwdInPwrOffset_LTE_A2		= tptr->BackUp.FwdInPwrOffset_LTE_A2;
		Sts->FwdOutPwrOffset_LTE_A2		= tptr->BackUp.FwdOutPwrOffset_LTE_A2;
		Sts->RvsOutPwrOffset_LTE_A2		= tptr->BackUp.RvsOutPwrOffset_LTE_A2;
		Sts->FwdInPwrOffset_3G			= tptr->BackUp.FwdInPwrOffset_3G;
		Sts->Rvs0OutPwrOffset_3G		= tptr->BackUp.Rvs0OutPwrOffset_3G;
		Sts->FwdOutPwrOffset_3G 		= tptr->BackUp.FwdOutPwrOffset_3G;

		Sts->FwdInPwrOffset_LTE_21		= tptr->BackUp.FwdInPwrOffset_LTE_21;
		Sts->FwdOutPwrOffset_LTE_21		= tptr->BackUp.FwdOutPwrOffset_LTE_21;
		Sts->RvsOutPwrOffset_LTE_21		= tptr->BackUp.RvsOutPwrOffset_LTE_21;

		memcpy((INT8U*)&Sts->DetOffset, (INT8U*)&tptr->BackUp.DetOffset, sizeof(__DET));

		Sts->FwdGainOffset_2G			= tptr->BackUp.FwdGainOffset_2G;
		Sts->FwdGainOffset_LTE			= tptr->BackUp.FwdGainOffset_LTE;
		Sts->FwdGainOffset_LTE_A2		= tptr->BackUp.FwdGainOffset_LTE_A2;
		Sts->FwdGainOffset_3G			= tptr->BackUp.FwdGainOffset_3G;
		Sts->FwdGainOffset_LTE_21		= tptr->BackUp.FwdGainOffset_LTE_21;

		Sts->InitRvsGainOffset_2G 		= Sts->RvsGainOffset_2G			= tptr->BackUp.RvsGainOffset_2G;
		Sts->InitRvsGainOffset_LTE 		= Sts->RvsGainOffset_LTE		= tptr->BackUp.RvsGainOffset_LTE;
		Sts->InitRvsGainOffset_LTE_A2 	= Sts->RvsGainOffset_LTE_A2		= tptr->BackUp.RvsGainOffset_LTE_A2;
		Sts->InitRvsGainOffset_3G 		= Sts->RvsGainOffset_3G			= tptr->BackUp.RvsGainOffset_3G;
		Sts->InitRvsGainOffset_LTE_21 	= Sts->RvsGainOffset_LTE_21		= tptr->BackUp.RvsGainOffset_LTE_21;

		 Sts->RvsGainBalance_WCDMALTE_21	= tptr->BackUp.RvsGainBalance_WCDMALTE_21;
		 Sts->RvsGainBalance_CDMALTE		= tptr->BackUp.RvsGainBalance_CDMALTE;
		 Sts->RvsGainBalance_LTE_A		 	= tptr->BackUp.RvsGainBalance_LTE_A;

		for(i = 0; i < DTU_Power_MAX; i++)
		{
			Sts->DTUPeakOffset[i].sD8[0] =  tptr->BackUp.DTUPeakOffset[i].sD8[0];
			Sts->DTUPeakOffset[i].sD8[1] =  tptr->BackUp.DTUPeakOffset[i].sD8[1];
			Sts->DTUAverOffset[i].sD8[0] =  tptr->BackUp.DTUAverOffset[i].sD8[0];
			Sts->DTUAverOffset[i].sD8[1] =  tptr->BackUp.DTUAverOffset[i].sD8[1];
		}

		for(i = 0; i < SvrPATH_MAX; i++)
		{
			for(j = 0; j < 2; j++){
			Sts->DTU_DLAGCLevel[i][j] =  tptr->BackUp.DTU_DLAGCLevel[i][j];
			Sts->DTU_ULAGCLevel[i][j] =  tptr->BackUp.DTU_ULAGCLevel[i][j];
			}
		}

        for(i = 0; i < DTU_ISO_MAX; i++)
		{
			Sts->ISOOffset[i].sD16 =  tptr->BackUp.ISOOffset[i].sD16;
		}


		 for(i = 0; i < PATH_MAX; i++)
		 {
			 Sts->DLISOOffset[i].sD16 =  tptr->BackUp.DLISOOffset[i].sD16;
			 Sts->DLISOOffset[i].sD16 =  tptr->BackUp.DLISOOffset[i].sD16;
		 
		 }

		 Sts->SampleOffsetA.sD32 =  tptr->BackUp.SampleOffsetA.sD32;
		 Sts->SampleOffsetB.sD16 =  tptr->BackUp.SampleOffsetB.sD16;

		 Sts->ULGainPriod 		=	tptr->BackUp.ULGainPriod;
		 Sts->ULGainPriod 		=	tptr->BackUp.ULGainPriod;

		 for(i = 0; i < SvrPATH_MAX; i++)
	 	 {
		 	Sts->ULGainOutLmt[i] 	=	tptr->BackUp.ULGainOutLmt[i];
	 	 }

		 for(i = 0; i < PATH_MAX; i++)
		 {
			Sts->RvsInPwrOffset[i]	=	tptr->BackUp.RvsInPwrOffset[i];
		 }

		 
		 for(i = 0; i < SvrPATH_MAX; i++)
		 {
			Sts->PLLOffset[i]	=	tptr->BackUp.PLLOffset[i];
		 }

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

//		iMasterPNH = tptr->BackUp.MasterPNH;
//		iMasterPNL = tptr->BackUp.MasterPNL;
		
		Sts->WaveCtrl.RxMaxVal[0] = tptr->BackUp.RxMaxVal[0];
		Sts->WaveCtrl.RxMaxVal[1] = tptr->BackUp.RxMaxVal[1];
		Sts->WaveCtrl.RxMinVal[0] = tptr->BackUp.RxMinVal[0];
		Sts->WaveCtrl.RxMinVal[1] = tptr->BackUp.RxMinVal[1];
		Sts->WaveCtrl.TxMaxVal[0] = tptr->BackUp.TxMaxVal[0];
		Sts->WaveCtrl.TxMaxVal[1] = tptr->BackUp.TxMaxVal[1];
		Sts->WaveCtrl.TxMinVal[0] = tptr->BackUp.TxMinVal[0];
		Sts->WaveCtrl.TxMinVal[1] = tptr->BackUp.TxMinVal[1];
	
		memcpy((INT8U*)&Sts->WaveCtrl.TestStn, 	(INT8U*)&tptr->BackUp.TestStn, sizeof(Sts->TestStn));
		memcpy((INT8U*)&Sts->TestStn, 			(INT8U*)&tptr->BackUp.TestStn, sizeof(Sts->TestStn));
		memcpy((INT8U*)&Sts->HostNumber,		(INT8U*)&tptr->BackUp.HostNumber, sizeof(Sts->HostNumber));

		tDnrSts->AutoReportPriod		= tptr->BackUp.AutoReportPriod;
		tDnrSts->AutoReportBasePer[0] 	= tptr->BackUp.AutoReportBasePer[0];
		tDnrSts->AutoReportBasePer[1] 	= tptr->BackUp.AutoReportBasePer[1];;

		tDnrSts->AlarmMask 				= tptr->BackUp.AlarmMask;
		
		tDnrSts->DCOffSet[0]			= tptr->BackUp.DCOffSet[0];
		tDnrSts->DCOffSet[1]			= tptr->BackUp.DCOffSet[1];

		tDnrSts->DTUFilterSts.Use		= tptr->BackUp.DTUFilterSts.Use;

		tDnrSts->FilterStart			= tptr->BackUp.FilterStart;


		for(i = 0; i < DTU_FilterDN_MAX; i++)
		{
			tDnrSts->FilterUSE[i]			= tptr->BackUp.FilterUSE[i];
		}

		for(i = 0; i < 4; i++)
		{
			tDnrSts->FTP_IP[i]			= tptr->BackUp.FTP_IP[i];
		}

		tDnrSts->FTP_Port			= tptr->BackUp.FTP_Port;



		for(i = 0; i < 20; i++)
		{
			tDnrSts->FTP_ID[i]			= tptr->BackUp.FTP_ID[i];
		}

		for(i = 0; i < 20; i++)
		{
			tDnrSts->FTP_PW[i]			= tptr->BackUp.FTP_PW[i];
		}

		for(i = 0; i < 20; i++)
		{
			tDnrSts->FTP_DnFilePath[i]	= tptr->BackUp.FTP_DnFilePath[i];
		}
		
		for(i = 0; i < 20; i++)
		{
			tDnrSts->FTP_DnFileName[i]	= tptr->BackUp.FTP_DnFileName[i];
		}
		
		for(i = 0; i < 6; i++)
		{
			tDnrSts->FTP_DnHours[i]	= tptr->BackUp.FTP_DnHours[i];
		}
		
	///////////////////////////////20130319
		Sts->ResetCase = rambackup[0];
		rambackup[0] = 0;
		
		if((Sts->ResetCase != UserReset) && (Sts->ResetCase != FWDownReset))
		{
			Sts->ResetCase = PowerReset;
		}
		
		Sts->ResetCase = Sts->ResetCase;
	}
#endif
//	OSSemPost(CtrlSem);

	if(Sts->AGCOnOff_CDMALTE == Disable)
	{
		Sts->FwdAgcAttn_2G 			= GainAttnCalculation(Sts->FwdGainSet_2G,MAXGain_800M,MINGain_800M);
		Sts->RvsGainAttn_2G 		= GainAttnCalculation(Sts->Rvs0GainSet_2G,MAXGain_800M,MINGain_800M);
		Sts->FwdAgcAttn_LTE 		= GainAttnCalculation(Sts->FwdGainSet_LTE,MAXGain_800M,MINGain_800M);
		Sts->RvsGainAttn_LTE		= GainAttnCalculation(Sts->Rvs0GainSet_LTE,MAXGain_800M,MINGain_800M);
	}
	else
	{
		Sts->FwdAgcAttn_2G 			= MINGain_800M;
		Sts->RvsGainAttn_2G 		= MINGain_800M;
		Sts->FwdAgcAttn_LTE 		= MINGain_800M;
		Sts->RvsGainAttn_LTE		= MINGain_800M;
		Sts->FwdAttn1_2G  			= DIGATTENMAX;
 		Sts->FwdAttn1_LTE 			= DIGATTENMAX;
		Sts->FwdAttn2_2G			= 0;
		Sts->FwdAttn2_LTE			= 0;
	}	
	
	if(Sts->AGCOnOff_LTE_A_0 == Disable)
	{
		Sts->FwdAgcAttn_LTE_A2		= GainAttnCalculation(Sts->FwdGainSet_LTE_A2,MAXGain_1800M,MINGain_1800M);
		Sts->RvsGainAttn_LTE_A2 	= GainAttnCalculation(Sts->Rvs0GainSet_LTE_A2,MAXGain_1800M,MINGain_1800M);

		Sts->FwdAgcAttn_LTE_A1		= 0;
		Sts->RvsGainAttn_LTE_A1		= 0;
	}
	else
	{
		Sts->FwdAgcAttn_LTE_A2		= MINGain_1800M;
		Sts->RvsGainAttn_LTE_A2 	= MINGain_1800M;
		Sts->FwdAttn1_LTE_A2 		= DIGATTENMAX;
		Sts->FwdAttn2_LTE_A2 		= 0;
	}

	if(Sts->AGCOnOff_WCDMALTE_21 == Disable)
	{
		Sts->FwdAgcAttn_3G 		= GainAttnCalculation(Sts->FwdGainSet_3G,MAXGain_2100M,MINGain_1800M);
		Sts->RvsGainAttn_3G 	= GainAttnCalculation(Sts->Rvs0GainSet_3G,MAXGain_2100M,MINGain_1800M);

		Sts->FwdAgcAttn_LTE_21 	= GainAttnCalculation(Sts->FwdGainSet_LTE_21,MAXGain_2100M,MINGain_1800M);
		Sts->RvsGainAttn_LTE_21 = GainAttnCalculation(Sts->RvsGainSet_LTE_21,MAXGain_2100M,MINGain_1800M);
	}
	else
	{
		Sts->FwdAgcAttn_3G 		= MINGain_2100M;
		Sts->RvsGainAttn_3G 	= MINGain_2100M;
 		Sts->FwdAttn1_3G 		= DIGATTENMAX;
		Sts->FwdAttn2_3G 		= 0;

		Sts->FwdAgcAttn_LTE_21	= MINGain_2100M;
		Sts->RvsGainAttn_LTE_21 = MINGain_2100M;
 		Sts->FwdAttn1_LTE_21 	= DIGATTENMAX;
		Sts->FwdAttn2_LTE_21 	= 0;
	}
}



void DefaultBackup(INT8U isInit)
{
	INT8U err = 0;
	INT32U i = 0;

	OSSemPend(pBackupSem, 0, &err);
	
	{
		EE_BACK1 *tptr = (EE_BACK1 *)&gEE_BACK1; // Load 1st Area

        ////////////////////////////////////////////////////////////////////////
		tptr->BackUp.IsDataFlag = ISDATA;

		for(i = 0; i < sizeof(EE_BACK1); i++)
		{
			WriteEEprom(At24cDevID, vEE_BACK1Addr + i, *((INT8U *)tptr + i), 0);
		}
	}
	OSSemPost(pBackupSem);
	////////////////////////////////////////////////////////////////////////////////

}

void DefaultFirstBackup(EE_BACK1 *tptr)
{



}

INT8U AnalyzeAidData(__ProtocolPtr *nPtr, INT8U Ctrl)
{
	INT8U i = 0;
	INT8U A_ID[2];
	INT8U rAID_Value[70];
	INT8U Length;

	INT16U Cnt = 0;

	
	INT16U AID_Command;
//	INT8U err = 0;

	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody%2];

	INT8U rval = FALSE;
//	OSSemPend(pBackupSem, 0, &err);
//	OSSemPend(AlcSem, 0, &err);
//	OSSemPend(ExpSem, 0, &err);

	{
		while(BodyFrame->SubLength > Cnt)
		{
			A_ID[0] = (INT8U)(BodyFrame->SubData[Cnt++]);
			A_ID[1] = (INT8U)(BodyFrame->SubData[Cnt++]);

			AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
			Length = BodyFrame->SubData[Cnt++];
			if( Length >= sizeof(rAID_Value)) break;
			for (i = 0; i < Length; i++) rAID_Value[i] = (INT8U)(BodyFrame->SubData[Cnt++]);

			
			rval += SetCtrlData(AID_Command, rAID_Value, Length, Ctrl,nPtr);

			if(Cnt >= BodyFrame->SubLength) break;
		}

		if(rval)
		{
			//write eeprom!!
//			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
		}
	}
//	OSSemPost(pBackupSem);
//	OSSemPost(AlcSem);
//	OSSemPost(ExpSem);

	return TRUE;
}

INT8U ISAscII(INT8U Data)
{
	if('0' <= Data && Data <= '9')	return TRUE;
	else							return FALSE;
}


INT16U GenAidData(INT16U Aid, INT8U *dptr, INT8U *sptr, INT16U len)
{
	INT8U i = 0;
	INT8U rval = 0;

	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
	dptr[rval++] = len;
	for(i = 0; i < len; i++) dptr[rval++] = sptr[i];

	return rval;
}

INT16U GenAidData16(INT16U Aid, INT8U *dptr, INT16U sptr, INT16U len)
{
	INT8U rval = 0;
	
	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
	dptr[rval++] = len;
	dptr[rval++] = (INT8U)((sptr >> 8) & 0xFF);
	dptr[rval++] = (INT8U)((sptr >> 0) & 0xFF);

	return rval;
}


INT16U GenAidData16Bit(INT16U Aid, INT8U *dptr, INT16U *sptr, INT16U len)
{
	INT8U i = 0;
	INT8U rval = 0;
	
	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
	dptr[rval++] = len;
	
	for(i = 0; i < len/2; i++) 
	{
		dptr[rval++] = (INT8U)((sptr[i] >> 8) & 0xFF);
		dptr[rval++] = (INT8U)((sptr[i] >> 0) & 0xFF);
	}
	return rval;
}


INT16U GenAidData32(INT16U Aid, INT8U *dptr, INT32U *sptr, INT16U len)
{
	INT8U i = 0;
	INT8U rval = 0;
	
	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
	dptr[rval++] = len;
	for(i = 0; i < len/4; i++) 
	{
		dptr[rval++] = (INT8U)((sptr[i] >> 24) & 0xFF);
		dptr[rval++] = (INT8U)((sptr[i] >> 16) & 0xFF);
		dptr[rval++] = (INT8U)((sptr[i] >> 8) & 0xFF);
		dptr[rval++] = (INT8U)((sptr[i] >> 0) & 0xFF);
	}

	return rval;
}

INT16U GenAidData32Bit(INT16U Aid, INT8U *dptr, INT32U sptr, INT16U len)
{
	INT8U rval = 0;
	
	dptr[rval++] = (INT8U)((Aid >> 8) & 0xFF);
	dptr[rval++] = (INT8U)((Aid >> 0) & 0xFF);
	dptr[rval++] = len;

	dptr[rval++] = (INT8U)((sptr >> 24) & 0xFF);
	dptr[rval++] = (INT8U)((sptr >> 16) & 0xFF);
	dptr[rval++] = (INT8U)((sptr >> 8) & 0xFF);
	dptr[rval++] = (INT8U)((sptr >> 0) & 0xFF);

	return rval;
}



////////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////

