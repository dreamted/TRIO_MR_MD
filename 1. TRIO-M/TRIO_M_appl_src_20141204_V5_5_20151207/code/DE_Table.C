/*********************************************
* File Name          : DE_Table.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/

#define DE_Table_C

#include "../include/main.h"



void DefaultValueSet(void)
{
	__Dnr_Sts *Sts = tDnrSts;
	
	INT32U cpu_sr;

	OS_ENTER_CRITICAL();

	Sts->FwdOutUpperLmt_3G[0]		= FwdHighLmt_3G; 
	Sts->FwdOutUpperLmt_3G[1]		= 0; 
	Sts->FwdOutLowerLmt_3G[0]		= FwdHighLmt_3G - 10; 
	Sts->FwdOutLowerLmt_3G[1]		= 0; 
	Sts->FwdGainSet_3G				= DefaultGain_3G; 
	Sts->Rvs0GainSet_3G 			= DefaultGain_3G;
	Sts->RvsGainBalance_3G			= DefaultGainBalance;

	Sts->OverInAlarmLmt_3G			= FwdOverInSDAlmLmt_3G; 

	Sts->FwdOutUpperLmt_2G[0]		= FwdHighLmt_2G; 
	Sts->FwdOutUpperLmt_2G[1]		= 0; 
	Sts->FwdOutLowerLmt_2G[0]		= FwdHighLmt_2G - 10; 
	Sts->FwdOutLowerLmt_2G[1]		= 0; 
	Sts->FwdGainSet_2G				= DefaultGain_2G;
	Sts->Rvs0GainSet_2G 			= DefaultGain_2G;
	Sts->RvsGainBalance_2G			= DefaultGainBalance;

	Sts->OverInAlarmLmt_2G			= FwdOverInSDAlmLmt_2G; 

	Sts->FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
	Sts->FwdOutUpperLmt_LTE[1]		= 0;
	Sts->FwdOutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
	Sts->FwdOutLowerLmt_LTE[1]		= 0;
	Sts->FwdGainSet_LTE 			= DefaultGain_LTE;
	Sts->Rvs0GainSet_LTE			= DefaultGain_LTE; 
	Sts->RvsGainBalance_LTE 		= DefaultGainBalance; 

	Sts->OverInAlarmLmt_LTE 		= FwdOverInSDAlmLmt_LTE; 

	Sts->FwdOutUpperLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1;
	Sts->FwdOutUpperLmt_LTE_A1[1]	= 0;
	Sts->FwdOutLowerLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1 -10;
	Sts->FwdOutLowerLmt_LTE_A1[1]	= 0;
	Sts->FwdGainSet_LTE_A1			= DefaultGain_LTE_A;
	Sts->Rvs0GainSet_LTE_A1			= DefaultGain_LTE_A;
	Sts->RvsGainBalance_LTE_A1		= DefaultGainBalance; 

	Sts->OverInAlarmLmt_LTE_A1		= FwdOverInSDAlmLmt_LTE_A1; 

	Sts->FwdOutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2;
	Sts->FwdOutUpperLmt_LTE_A2[1]	= 0;
	Sts->FwdOutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2 -10;
	Sts->FwdOutLowerLmt_LTE_A2[1]	= 0;
	Sts->FwdGainSet_LTE_A2			= DefaultGain_LTE_A;
	Sts->Rvs0GainSet_LTE_A2			= DefaultGain_LTE_A;
	Sts->RvsGainBalance_LTE_A2		= DefaultGainBalance; 

	Sts->OverInAlarmLmt_LTE_A2		= FwdOverInSDAlmLmt_LTE_A2; 

	Sts->Fwd1OutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
	Sts->Fwd1OutUpperLmt_LTE[1]		= 0;
	Sts->Fwd1OutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
	Sts->Fwd1OutLowerLmt_LTE[1]		= 0;
	Sts->Fwd1GainSet_LTE 			= DefaultGain_LTE;
	Sts->Rvs1GainSet_LTE			= DefaultGain_LTE; 
	Sts->Rvs1GainBalance_LTE 		= DefaultGainBalance;

	Sts->Fwd1OutUpperLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1;
	Sts->Fwd1OutUpperLmt_LTE_A1[1]	= 0;
	Sts->Fwd1OutLowerLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1 - 10;
	Sts->Fwd1OutLowerLmt_LTE_A1[1]	= 0;
	Sts->Fwd1GainSet_LTE_A1			= DefaultGain_LTE_A;
	Sts->Rvs1GainSet_LTE_A1			= DefaultGain_LTE_A;
	Sts->Rvs1GainBalance_LTE_A1		= DefaultGainBalance; 

	Sts->Fwd1OutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A1;
	Sts->Fwd1OutUpperLmt_LTE_A2[1]	= 0;
	Sts->Fwd1OutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A1 - 10;
	Sts->Fwd1OutLowerLmt_LTE_A2[1]	= 0;
	Sts->Fwd1GainSet_LTE_A2			= DefaultGain_LTE_A;
	Sts->Rvs1GainSet_LTE_A2			= DefaultGain_LTE_A;
	Sts->Rvs1GainBalance_LTE_A2		= DefaultGainBalance; 

	Sts->AmpOffCase_2G				= Enable; 
	Sts->AmpOffCase_LTE				= Enable; 
	Sts->AmpOffCase_3G				= Enable; 
	Sts->AmpOffCase_LTE_A1			= Enable; 
	Sts->AmpOffCase_LTE_A2			= Enable; 

	Sts->LTE15MUse 					= __NOTUSE; 

	Sts->AGCOnOff_3G				= Enable; 
	Sts->AGCOnOff_CDMALTE			= Enable; 
	Sts->AGCOnOff_LTE_A_0 			= Enable;
	Sts->AGC1OnOff_LTE				= Enable;
	Sts->AGCOnOff_LTE_A_1			= Enable;
	
	Sts->AGCMode_3G 				= _AGCAvgMode;
	Sts->AGCMode_2G 				= _AGCAvgMode;
	Sts->AGCMode_LTE				= _AGCPeakMode;
	Sts->AGCMode_LTE_A1				= _AGCPeakMode;
	Sts->AGCMode_LTE_A2				= _AGCPeakMode;
	
	Sts->AutoReportPriod			= 0;
	Sts->AutoReportBasePer[0]		= 0;
	Sts->AutoReportBasePer[1]		= 0;
	Sts->TPTL_OnOff 				= Disable;
	Sts->TempOffset 				= 0;
	Sts->AlarmMask					= Enable;
	Sts->VccDet_Lmt.Data			= 4200; 
	Sts->FwdInPwrOffset_2G			= 0; 
	Sts->FwdInPwrOffset_3G			= 0; 
	Sts->Rvs0OutPwrOffset_2G		= 0; 
	Sts->Rvs0OutPwrOffset_3G		= 0; 
	Sts->FwdOutPwrOffset_2G 		= 0; 
	Sts->FwdOutPwrOffset_3G 		= 0; 
	Sts->ResetPeriodCountSet[0] 	= 1; 
	Sts->ResetPeriodCountSet[1] 	= 0; 
	Sts->ResetPeriodCountSet[2] 	= 0; 
	Sts->FwdInPwrOffset_LTE 		= 0;
	Sts->FwdOutPwrOffset_LTE		= 0;
	Sts->RvsOutPwrOffset_LTE		= 0;
	{
		INT8U i;

		for(i = 0; i < (sizeof(__DET)); i++)	 *((INT8U *)&(Sts->DetOffset.FwdOutAvgPwr_2G) + i) = 0;
		
		for(i = 0; i < (sizeof(__DET1)); i++)	 *((INT8U *)&(Sts->Det1Offset.Fwd1OutAvgPwr_LTE) + i) = 0;
	}
	Sts->FwdInPwrOffset_LTE_A1		= 0; 
	Sts->FwdOutPwrOffset_LTE_A1		= 0; 
	Sts->RvsOutPwrOffset_LTE_A1		= 0; 

	Sts->FwdInPwrOffset_LTE_A2		= 0; 
	Sts->FwdOutPwrOffset_LTE_A2		= 0; 
	Sts->RvsOutPwrOffset_LTE_A2		= 0; 
	Sts->WaveCtrl.RxMaxVal[0]				= 0x30;
	Sts->WaveCtrl.RxMaxVal[1]				= 0x61;
	Sts->WaveCtrl.RxMinVal[0]				= 0x39;
	Sts->WaveCtrl.RxMinVal[1]				= 0x63;
	Sts->WaveCtrl.TxMaxVal[0]				= 0x33;
	Sts->WaveCtrl.TxMaxVal[1]				= 0x63;
	Sts->WaveCtrl.TxMinVal[0]				= 0x62;
	Sts->WaveCtrl.TxMinVal[1]				= 0x30;
	Sts->WaveCtrl.EcIo						= 0x10;	//-10
	Sts->WaveCtrl.Radio_ReportTime[0]		= 0;
	Sts->WaveCtrl.Radio_ReportTime[1]		= 0;
	Sts->Amp1OffCase_LTE			= Enable;
	Sts->Amp1OffCase_LTE_A1			= Enable;
	Sts->Fwd1InPwrOffset_LTE_A1		= 0;
	Sts->Fwd1OutPwrOffset_LTE_A1 	= 0;
	Sts->Rvs1OutPwrOffset_LTE_A1 	= 0;
	Sts->Amp1OffCase_LTE_A2			= Enable;
	Sts->Fwd1InPwrOffset_LTE_A2		= 0;
	Sts->Fwd1OutPwrOffset_LTE_A2 	= 0;
	Sts->Rvs1OutPwrOffset_LTE_A2 	= 0;
	Sts->Band_Select_LTE_A1		   = __USE;
	Sts->Band_Select_LTE_A2[0]     = __USE;
	Sts->Band_Select_LTE_A2[1]     = 1;
	Sts->Band_Select_LTE_A2[2]     = 0x70;


	Sts->RvsALCLvl_2G 		= RvsHighLmt_2G; 
	Sts->RvsALCLvl_3G 		= RvsHighLmt_2G; 
	Sts->RvsALCLvl_LTE 		= RvsHighLmt_2G; 
	Sts->RvsALCLvl_LTE_A1	= RvsHighLmt_2G; 
	Sts->RvsALCLvl_LTE_A2 	= RvsHighLmt_2G; 
	Sts->Rvs1ALCLvl_LTE		= RvsHighLmt_2G; 
	Sts->Rvs1ALCLvl_LTE_A1	= RvsHighLmt_2G; 
	Sts->Rvs1ALCLvl_LTE_A2 	= RvsHighLmt_2G; 

	if(iRepeaterType == _TRIO_M)
	{
		Sts->DCOffSet = 1930;
	}
	else
	{

		Sts->DCOffSet = 1990;
	}


	Sts->FemtocellUseOnOff.LTE = __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A1 = __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A2 = __NOTUSE;

	Sts->FemtocellUseOnOff.LTE_1= __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A1_1 = __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A2_1 = __NOTUSE;


	tDnrSts->AutoReportPriod = 0x05;

	tDnrSts->WaveCtrl.Radio_ReportPeriod[0] = 0x09;
	tDnrSts->WaveCtrl.Radio_ReportPeriod[1] = 0x10;

	Sts->WaveCtrl.AR_Mode[0] = 0x03;
	Sts->WaveCtrl.AR_Mode[1] = 0x03;

	SaveBackupData();
	OS_EXIT_CRITICAL();
}


void DefaultTableSet(void)
{
	__Dnr_Sts *Sts = tDnrSts;
	
	INT32U cpu_sr;

	OS_ENTER_CRITICAL();

	Sts->FwdOutUpperLmt_3G[0]		= FwdHighLmt_3G; 
	Sts->FwdOutUpperLmt_3G[1]		= 0; 
	Sts->FwdOutLowerLmt_3G[0]		= FwdHighLmt_3G - 10; 
	Sts->FwdOutLowerLmt_3G[1]		= 0; 
	Sts->FwdGainSet_3G				= DefaultGain_3G; 
	Sts->Rvs0GainSet_3G 			= DefaultGain_3G;
	Sts->RvsGainBalance_3G			= DefaultGainBalance;

	Sts->OverInAlarmLmt_3G			= FwdOverInSDAlmLmt_3G; 

	Sts->FwdOutUpperLmt_2G[0]		= FwdHighLmt_2G; 
	Sts->FwdOutUpperLmt_2G[1]		= 0; 
	Sts->FwdOutLowerLmt_2G[0]		= FwdHighLmt_2G - 10; 
	Sts->FwdOutLowerLmt_2G[1]		= 0; 
	Sts->FwdGainSet_2G				= DefaultGain_2G;
	Sts->Rvs0GainSet_2G 			= DefaultGain_2G;
	Sts->RvsGainBalance_2G			= DefaultGainBalance;

	Sts->OverInAlarmLmt_2G			= FwdOverInSDAlmLmt_2G; 

	Sts->FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
	Sts->FwdOutUpperLmt_LTE[1]		= 0;
	Sts->FwdOutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
	Sts->FwdOutLowerLmt_LTE[1]		= 0;
	Sts->FwdGainSet_LTE 			= DefaultGain_LTE;
	Sts->Rvs0GainSet_LTE			= DefaultGain_LTE; 
	Sts->RvsGainBalance_LTE 		= DefaultGainBalance; 

	Sts->OverInAlarmLmt_LTE 		= FwdOverInSDAlmLmt_LTE; 

	Sts->FwdOutUpperLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1;
	Sts->FwdOutUpperLmt_LTE_A1[1]	= 0;
	Sts->FwdOutLowerLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1 -10;
	Sts->FwdOutLowerLmt_LTE_A1[1]	= 0;
	Sts->FwdGainSet_LTE_A1			= DefaultGain_LTE_A;
	Sts->Rvs0GainSet_LTE_A1 		= DefaultGain_LTE_A;
	Sts->RvsGainBalance_LTE_A1		= DefaultGainBalance; 

	Sts->OverInAlarmLmt_LTE_A1		= FwdOverInSDAlmLmt_LTE_A1; 

	Sts->FwdOutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2;
	Sts->FwdOutUpperLmt_LTE_A2[1]	= 0;
	Sts->FwdOutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2 -10;
	Sts->FwdOutLowerLmt_LTE_A2[1]	= 0;
	Sts->FwdGainSet_LTE_A2			= DefaultGain_LTE_A;
	Sts->Rvs0GainSet_LTE_A2 		= DefaultGain_LTE_A;
	Sts->RvsGainBalance_LTE_A2		= DefaultGainBalance; 

	Sts->OverInAlarmLmt_LTE_A2		= FwdOverInSDAlmLmt_LTE_A2; 

	Sts->Fwd1OutUpperLmt_LTE[0] 	= FwdHighLmt_LTE; 
	Sts->Fwd1OutUpperLmt_LTE[1] 	= 0;
	Sts->Fwd1OutLowerLmt_LTE[0] 	= FwdHighLmt_LTE - 10;
	Sts->Fwd1OutLowerLmt_LTE[1] 	= 0;
	Sts->Fwd1GainSet_LTE			= DefaultGain_LTE;
	Sts->Rvs1GainSet_LTE			= DefaultGain_LTE; 
	Sts->Rvs1GainBalance_LTE		= DefaultGainBalance;

	Sts->Fwd1OutUpperLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1;
	Sts->Fwd1OutUpperLmt_LTE_A1[1]	= 0;
	Sts->Fwd1OutLowerLmt_LTE_A1[0]	= FwdHighLmt_LTE_A1 - 10;
	Sts->Fwd1OutLowerLmt_LTE_A1[1]	= 0;
	Sts->Fwd1GainSet_LTE_A1 		= DefaultGain_LTE_A;
	Sts->Rvs1GainSet_LTE_A1 		= DefaultGain_LTE_A;
	Sts->Rvs1GainBalance_LTE_A1 	= DefaultGainBalance; 

	Sts->Fwd1OutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A1;
	Sts->Fwd1OutUpperLmt_LTE_A2[1]	= 0;
	Sts->Fwd1OutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A1 - 10;
	Sts->Fwd1OutLowerLmt_LTE_A2[1]	= 0;
	Sts->Fwd1GainSet_LTE_A2 		= DefaultGain_LTE_A;
	Sts->Rvs1GainSet_LTE_A2 		= DefaultGain_LTE_A;
	Sts->Rvs1GainBalance_LTE_A2 	= DefaultGainBalance; 

	Sts->AmpOffCase_2G				= Enable; 
	Sts->AmpOffCase_LTE 			= Enable; 
	Sts->AmpOffCase_3G				= Enable; 
	Sts->AmpOffCase_LTE_A1			= Disable; 
	Sts->AmpOffCase_LTE_A2			= Disable; 

	Sts->LTE15MUse					= __NOTUSE; 

	Sts->AGCOnOff_3G				= Enable; 
	Sts->AGCOnOff_CDMALTE			= Enable; 
	Sts->AGCOnOff_LTE_A_0			= Enable;
	Sts->AGC1OnOff_LTE				= Enable;
	Sts->AGCOnOff_LTE_A_1			= Enable;
	
	Sts->AGCMode_3G 				= _AGCAvgMode;
	Sts->AGCMode_2G 				= _AGCAvgMode;
	Sts->AGCMode_LTE				= _AGCPeakMode;
	Sts->AGCMode_LTE_A1 			= _AGCPeakMode;
	Sts->AGCMode_LTE_A2 			= _AGCPeakMode;
	
	Sts->AutoReportPriod			= 0;
	Sts->AutoReportBasePer[0]		= 0;
	Sts->AutoReportBasePer[1]		= 0;
	Sts->TPTL_OnOff 				= Disable;
	Sts->AlarmMask					= Enable;
	Sts->VccDet_Lmt.Data			= 4200; 
	Sts->ResetPeriodCountSet[0] 	= 1; 
	Sts->ResetPeriodCountSet[1] 	= 0; 
	Sts->ResetPeriodCountSet[2] 	= 0; 

	Sts->WaveCtrl.RxMaxVal[0]				= 0x30;
	Sts->WaveCtrl.RxMaxVal[1]				= 0x61;
	Sts->WaveCtrl.RxMinVal[0]				= 0x39;
	Sts->WaveCtrl.RxMinVal[1]				= 0x63;
	Sts->WaveCtrl.TxMaxVal[0]				= 0x33;
	Sts->WaveCtrl.TxMaxVal[1]				= 0x63;
	Sts->WaveCtrl.TxMinVal[0]				= 0x62;
	Sts->WaveCtrl.TxMinVal[1]				= 0x30;
	Sts->WaveCtrl.EcIo						= 0x10; //-10
	Sts->WaveCtrl.Radio_ReportTime[0]		= 0;
	Sts->WaveCtrl.Radio_ReportTime[1]		= 0;
	
	Sts->Amp1OffCase_LTE				= Enable;
	Sts->Amp1OffCase_LTE_A1 			= Disable;
	Sts->Amp1OffCase_LTE_A2 			= Disable;
	
	Sts->Band_Select_LTE_A1 	   = __NOTUSE;
	Sts->Band_Select_LTE_A2[0]	   = __NOTUSE;
	Sts->Band_Select_LTE_A2[1]	   = 1;
	Sts->Band_Select_LTE_A2[2]	   = 0x70;


	Sts->RvsALCLvl_2G		= RvsHighLmt_2G; 
	Sts->RvsALCLvl_3G		= RvsHighLmt_2G; 
	Sts->RvsALCLvl_LTE		= RvsHighLmt_2G; 
	Sts->RvsALCLvl_LTE_A1	= RvsHighLmt_2G; 
	Sts->RvsALCLvl_LTE_A2	= RvsHighLmt_2G; 
	Sts->Rvs1ALCLvl_LTE 	= RvsHighLmt_2G; 
	Sts->Rvs1ALCLvl_LTE_A1	= RvsHighLmt_2G; 
	Sts->Rvs1ALCLvl_LTE_A2	= RvsHighLmt_2G; 

	Sts->FemtocellUseOnOff.LTE = __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A1 = __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A2 = __NOTUSE;

	Sts->FemtocellUseOnOff.LTE_1= __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A1_1 = __NOTUSE;
	Sts->FemtocellUseOnOff.LTE_A2_1 = __NOTUSE;

	tDnrSts->AutoReportPriod = 0x05;

	tDnrSts->WaveCtrl.Radio_ReportPeriod[0] = 0x09;
	tDnrSts->WaveCtrl.Radio_ReportPeriod[1] = 0x10;

	Sts->WaveCtrl.AR_Mode[0] = 0x03;
	Sts->WaveCtrl.AR_Mode[1] = 0x03;

	SaveBackupData();
	OS_EXIT_CRITICAL();
}

void Response_Table_DE(INT8U Comm,__ProtocolPtr *nPtr)
{
	INT8U TblID = 0;
	INT8S tIndex = 0;

	INT8S tlimit;
	INT8U tsize;
	INT32U tbllen = 0;		//, mlen = 0;
	INT32U i = 0;


	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__WRCSSIO *Send = nPtr->WRCSSend;

    __BODYFRAME *rBody = &Recv->BodyFrame[Recv->cBody];
    __BODYFRAME *sBody = &Send->BodyFrame[Recv->cBody];

	TblID = rBody->SubData[0];
	
	INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};

	if( (tIndex = TableIndex(TblID)) == -1) return;

	switch(TblID)	//command üũ
	{
		case Index_RvsOutPwr_CDMALTE 	:
		case Index_FwdOutAvgPwr_LTE_A1 	:
		case Index_FwdOutPeakPwr_LTE_A1	:
		case Index_RvsOutPwr_LTE_A1 	:
		case Index_RvsOutPwr_LTE_A2 	:
		case Index_FwdOutAvgPwr_LTE_A2 	:
		case Index_FwdOutPeakPwr_LTE_A2	:
		case Index_FwdInPwr_LTE_A		:
		case Index_RvsOutPwr_LTE_A 		:
		case Index_FwdInPwr_3G 			:
		case Index_Fwd1OutAvgPwr_LTE 	:
		case Index_Fwd1OutPeakPwr_LTE	:
		case Index_Rvs1InPwr_LTE 		:
		case Index_FwdOutAvgPwr_LTE_A_1 :
		{
			__Dnr0OutputTblStr *TblStr;
			
			if( Comm == DDRTableSetQue)
			{
				INT32U cpu_sr;
				OS_ENTER_CRITICAL();

				{
					EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

					TblStr = &(tptr->Dnr0OutputTbl[tIndex]);
					tlimit = TblStr->limit = rBody->SubData[1];
					tsize = TblStr->nsize = rBody->SubData[2];

					if( tsize > Dnr0OutputTBL_Size)  tsize = TblStr->nsize =  Dnr0OutputTBL_Size; 

					tbllen = (tsize*2); // data type: int16!!

					{
						INT16U *dsptr = (INT16U *)TblStr->Data;
						INT16U *stptr = (INT16U *)&rBody->SubData[3];
						for(i = 0; i < tbllen/2 && i < (Dnr0OutputTBL_Size); i++)
						{
							dsptr[i] = swab16(stptr[i]);
						}
					}

					WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
				}
				OS_EXIT_CRITICAL();
			}
			{
				TblStr = &(vEE_TABLE1->Dnr0OutputTbl[tIndex]);

				tlimit = TblStr->limit;
				tsize  = TblStr->nsize;
				if( tsize > Dnr0OutputTBL_Size)  tsize = TblStr->nsize =  Dnr0OutputTBL_Size; 
				tbllen = (tsize*2); // data type: int16!!

					
				sBody->SubData[0] = TblID;
				sBody->SubData[1] = tlimit;
				sBody->SubData[2] = tsize;
				{
					INT16U *dsptr = (INT16U *)&sBody->SubData[3];
					INT16U *stptr = (INT16U *)TblStr->Data;

					for(i = 0; i < tbllen/2 && i < (Dnr0OutputTBL_Size); i++)
					{
						dsptr[i] = swab16(stptr[i]);
					}
				}
			}
		}
		break;

		case Index_FwdInPwr_CDMALTE		:
		case Index_RvsOutPwr_3G			:
		case Index_RvsInPwr_LTE_A_1		:
		{
			__Dnr1OutputTblStr *TblStr;
			
			if( Comm == DDRTableSetQue)
			{
				INT32U cpu_sr;
				OS_ENTER_CRITICAL();

				{
					EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

					TblStr = &(tptr->Dnr1OutputTbl[tIndex]);
					tlimit = TblStr->limit = rBody->SubData[1];
					tsize = TblStr->nsize = rBody->SubData[2];

					if( tsize > Dnr1OutputTBL_Size)  tsize = TblStr->nsize =  Dnr1OutputTBL_Size; 

					tbllen = (tsize*2); // data type: int16!!

					{
						INT16U *dsptr = (INT16U *)TblStr->Data;
						INT16U *stptr = (INT16U *)&rBody->SubData[3];
						for(i = 0; i < tbllen/2 && i < (Dnr1OutputTBL_Size); i++)
						{
							dsptr[i] = swab16(stptr[i]);
						}
					}

					WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
				}
				OS_EXIT_CRITICAL();
			}
			{
				TblStr = &(vEE_TABLE1->Dnr1OutputTbl[tIndex]);

				tlimit = TblStr->limit;
				tsize  = TblStr->nsize;
				if( tsize > Dnr1OutputTBL_Size)  tsize = TblStr->nsize =  Dnr1OutputTBL_Size; 
				tbllen = (tsize*2); // data type: int16!!

					
				sBody->SubData[0] = TblID;
				sBody->SubData[1] = tlimit;
				sBody->SubData[2] = tsize;
				{
					INT16U *dsptr = (INT16U *)&sBody->SubData[3];
					INT16U *stptr = (INT16U *)TblStr->Data;

					for(i = 0; i < tbllen/2 && i < (Dnr1OutputTBL_Size); i++)
					{
						dsptr[i] = swab16(stptr[i]);
					}
				}
			}
		}
		break;

		case Index_FwdOutAvgPwr_2G		:
		case Index_FwdOutPeakPwr_2G 	:
		case Index_RvsOutPwr_2G 		:
		case Index_FwdOutAvgPwr_LTE 	:
		case Index_FwdOutPeakPwr_LTE	:
		case Index_RvsOutPwr_LTE 		:
		case Index_FwdOutAvgPwr_CDMALTE 	:
		case Index_FwdOutPeakPwr_CDMALTE :
		case Index_RvsInPwr_CDMALTE		:
		case Index_FwdOutAvgPwr_LTE_A 	:
		case Index_FwdOutAvgPwr_3G 		:
		case Index_FwdOutPeakPwr_3G 	:
		case Index_RvsInPwr_3G 			:
		{
			__Svr0OutputTblStr *TblStr;
			
			if( Comm == DDRTableSetQue)
			{
				INT32U cpu_sr;
				OS_ENTER_CRITICAL();

				{
					EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

					TblStr = &(tptr->Svr0OutputTbl[tIndex]);
					tlimit = TblStr->limit = rBody->SubData[1];
					tsize = TblStr->nsize = rBody->SubData[2];

					if( tsize > Svr0OutputTBL_Size)  tsize = TblStr->nsize =  Svr0OutputTBL_Size; 

					tbllen = (tsize*2); // data type: int16!!

					{
						INT16U *dsptr = (INT16U *)TblStr->Data;
						INT16U *stptr = (INT16U *)&rBody->SubData[3];
						for(i = 0; i < tbllen/2 && i < (Svr0OutputTBL_Size); i++)
						{
							dsptr[i] = swab16(stptr[i]);
						}
					}

					WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
				}
				OS_EXIT_CRITICAL();
			}
			{
				TblStr = &(vEE_TABLE->Svr0OutputTbl[tIndex]);

				tlimit = TblStr->limit;
				tsize  = TblStr->nsize;
				if( tsize > Svr0OutputTBL_Size)  tsize = TblStr->nsize =  Svr0OutputTBL_Size; 
				tbllen = (tsize*2); // data type: int16!!

					
				sBody->SubData[0] = TblID;
				sBody->SubData[1] = tlimit;
				sBody->SubData[2] = tsize;
				{
					INT16U *dsptr = (INT16U *)&sBody->SubData[3];
					INT16U *stptr = (INT16U *)TblStr->Data;

					for(i = 0; i < tbllen/2 && i < (Svr0OutputTBL_Size); i++)
					{
						dsptr[i] = swab16(stptr[i]);
					}
				}
			}
		}
		break;

		
		case Index_RvsInPwr_LTE_A		:
		case Index_Fwd1InPwr_LTE 		:
		case Index_Rvs1OutPwr_LTE 		:
		case Index_Fwd1OutAvgPwr_LTE_A1 :
		case Index_Fwd1OutPeakPwr_LTE_A1:
		case Index_Fwd1OutAvgPwr_LTE_A2 :
		case Index_Fwd1OutPeakPwr_LTE_A2:
		case Index_Rvs1OutPwr_LTE_A1 	:
		case Index_Rvs1OutPwr_LTE_A2 	:
		case Index_FwdInPwr_LTE_A_1		:
		case Index_RvsOutPwr_LTE_A_1 	:
		{
			__Svr1OutputTblStr *TblStr;
			
			if( Comm == DDRTableSetQue)
			{
				INT32U cpu_sr;
				OS_ENTER_CRITICAL();

				{
					EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

					TblStr = &(tptr->Svr1OutputTbl[tIndex]);
					tlimit = TblStr->limit = rBody->SubData[1];
					tsize = TblStr->nsize = rBody->SubData[2];

					if( tsize > Svr1OutputTBL_Size)  tsize = TblStr->nsize =  Svr1OutputTBL_Size; 

					tbllen = (tsize*2); // data type: int16!!

					{
						INT16U *dsptr = (INT16U *)TblStr->Data;
						INT16U *stptr = (INT16U *)&rBody->SubData[3];
						for(i = 0; i < tbllen/2 && i < (Svr1OutputTBL_Size); i++)
						{
							dsptr[i] = swab16(stptr[i]);
						}
					}

					WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
				}
				OS_EXIT_CRITICAL();
			}
			{
				TblStr = &(vEE_TABLE->Svr1OutputTbl[tIndex]);

				tlimit = TblStr->limit;
				tsize  = TblStr->nsize;
				if( tsize > Svr1OutputTBL_Size)  tsize = TblStr->nsize =  Svr1OutputTBL_Size; 
				tbllen = (tsize*2); // data type: int16!!

					
				sBody->SubData[0] = TblID;
				sBody->SubData[1] = tlimit;
				sBody->SubData[2] = tsize;
				{
					INT16U *dsptr = (INT16U *)&sBody->SubData[3];
					INT16U *stptr = (INT16U *)TblStr->Data;

					for(i = 0; i < tbllen/2 && i < (Svr1OutputTBL_Size); i++)
					{
						dsptr[i] = swab16(stptr[i]);
					}
				}
			}
		}
		break;

		case Index_RvsAttn2_2G 			:
		case Index_RvsAttn3_2G 			:
		case Index_RvsAttn2_LTE 		:
		case Index_RvsAttn3_LTE 		:
		case Index_FwdAttn1_CDMALTE 		:
		case Index_FwdAttn1_LTE_A1 		:
		case Index_FwdAttn2_LTE_A1 		:
		case Index_RvsAttn1_LTE_A1 		:
		case Index_RvsAttn2_LTE_A1 		:
		case Index_RvsAttn3_LTE_A1		:
		case Index_FwdAttn1_LTE_A2 		:
		case Index_FwdAttn2_LTE_A2 		:
		case Index_RvsAttn1_LTE_A2 		:
		case Index_RvsAttn2_LTE_A2 		:
		case Index_RvsAttn3_LTE_A2 		:
		case Index_FwdAttn1_LTE_A 		:
		case Index_FwdAttn1_3G 			:
		case Index_FwdAttn2_3G 			:
		case Index_RvsAttn3_3G 			:
		case Index_RvsAttn4_3G 			:
		case Index_Rvs1Attn1_LTE		:
		case Index_Rvs1Attn2_LTE		:
		case Index_RvsAttn1_LTE_A_1		:
		{
			__AttnOffsetTblStr *AttTblStr;

			if( Comm == DDRTableSetQue)
			{
				INT32U cpu_sr;
				OS_ENTER_CRITICAL();
				{
					SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);

					AttTblStr = &tptr->DnrAttnTbl[tIndex];

					tlimit = AttTblStr->limit = rBody->SubData[1] = AttMaxLimit;
					tsize = AttTblStr->nsize = rBody->SubData[2] = AttTBL_Size;
					if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 

					tbllen = (tsize*1); // data type: int16!!
					{
						INT8U *dsptr = (INT8U *)AttTblStr->Data;
						INT8U *stptr = (INT8U *)&rBody->SubData[3];
						
						for(i = 0; i < tbllen && i < (AttTBL_Size); i++)
						{
							dsptr[i] = (stptr[i]);
						}
					}
					WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
				}
				OS_EXIT_CRITICAL();
			}
			{
				AttTblStr = &vSYS_TABLE->DnrAttnTbl[tIndex];


				tlimit = AttTblStr->limit;
				tsize = AttTblStr->nsize;
				
				if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 

				tbllen = (tsize*1); // data type: int16!!

				sBody->SubData[0] = TblID;
				sBody->SubData[1] = tlimit;
				sBody->SubData[2] = tsize;
				{
					INT8U *dsptr = (INT8U *)&sBody->SubData[3];
					INT8U *stptr = (INT8U *)AttTblStr->Data;
					
					for(i = 0; i < tbllen ; i++)
					{
						dsptr[i] = stptr[i];
					}
				}
			}
		}			
		break;

		case Index_FwdAttn1_2G 			:
		case Index_FwdAttn2_2G 			:
		case Index_RvsAttn1_2G 			:
		case Index_FwdAttn1_LTE 		:
		case Index_FwdAttn2_LTE 		:
		case Index_RvsAttn1_LTE 		:
		case Index_RvsAttn1_CDMALTE  	:
		case Index_RvsAttn1_LTE_A 		:
		case Index_RvsAttn1_3G 			:
		case Index_RvsAttn2_3G 			:
		case Index_Fwd1Attn1_LTE	 	:
		case Index_Fwd1Attn2_LTE	 	:
		case Index_Rvs1Attn3_LTE	 	:
		case Index_Rvs1Attn4_LTE	 	:
		
		case Index_Fwd1Attn1_LTE_A1 	:
		case Index_Fwd1Attn2_LTE_A1		:
		case Index_Rvs1Attn1_LTE_A1	 	:
		case Index_Rvs1Attn2_LTE_A1 	:
		case Index_Rvs1Attn3_LTE_A1 	:
		case Index_Fwd1Attn1_LTE_A2 	:
		case Index_Fwd1Attn2_LTE_A2		:
		case Index_Rvs1Attn1_LTE_A2 	:
		case Index_Rvs1Attn2_LTE_A2 	:
		case Index_Rvs1Attn3_LTE_A2 	:
		case Index_FwdAttn1_LTE_A_1 	:
		{
			__AttnOffsetTblStr *AttTblStr;

			if( Comm == DDRTableSetQue)
			{
				INT32U cpu_sr;
				OS_ENTER_CRITICAL();
				{
					EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
					
					AttTblStr = &tptr->SvrAttnTbl[tIndex];

					tlimit = AttTblStr->limit = rBody->SubData[1] = AttMaxLimit;
					tsize = AttTblStr->nsize = rBody->SubData[2] = AttTBL_Size;
						
					if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 

					tbllen = (tsize*1); // data type: int16!!
					{
						INT8U *dsptr = (INT8U *)AttTblStr->Data;
						INT8U *stptr = (INT8U *)&rBody->SubData[3];
						
						for(i = 0; i < tbllen && i < (AttTBL_Size); i++)
						{
							dsptr[i] = (stptr[i]);
						}
					}
					WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
				}
				OS_EXIT_CRITICAL();
			}
			{

				AttTblStr = &vEE_BACK1->SvrAttnTbl[tIndex];

				tlimit = AttTblStr->limit;
				tsize = AttTblStr->nsize;
				
				
				if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 

				tbllen = (tsize*1); // data type: int16!!

				sBody->SubData[0] = TblID;
				sBody->SubData[1] = tlimit;
				sBody->SubData[2] = tsize;
				{
					INT8U *dsptr = (INT8U *)&sBody->SubData[3];
					INT8U *stptr = (INT8U *)AttTblStr->Data;
					
					for(i = 0; i < tbllen ; i++)
					{
						dsptr[i] = stptr[i];
					}
				}
			}
		}			
		break;

		case Index_FwdTempAttn_2G  		:
		case Index_RvsTempAttn_2G  		:
		case Index_FwdTempAttn_LTE 		:
		case Index_RvsTempAttn_LTE 		:
		case Index_FwdTempAttn_LTE_A1	:
		case Index_RvsTempAttn_LTE_A1	:
		case Index_FwdTempAttn_LTE_A2	:
		case Index_RvsTempAttn_LTE_A2	:
		case Index_FwdTempAttn_3G  		:
		case Index_RvsTempAttn_3G		:
		case Index_Fwd1TempAttn_LTE 	:
		case Index_Rvs1TempAttn_LTE 	:
		case Index_Fwd1TempAttn_LTE_A1 	:
		case Index_Rvs1TempAttn_LTE_A1 	:
		case Index_Fwd1TempAttn_LTE_A2 	:
		case Index_Rvs1TempAttn_LTE_A2 	:	
		{
			__AttnTempTblStr *AttTblStr;

			if( Comm == DDRTableSetQue)
			{
				INT32U cpu_sr;
				OS_ENTER_CRITICAL();
				{
					SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);
					AttTblStr = &tptr->AttnTempTbl[tIndex];
					tlimit = AttTblStr->limit = rBody->SubData[1] = TempMaxlimit;
					tsize = AttTblStr->nsize = rBody->SubData[2]= TempTBL_Size;
					if( tsize > TempTBL_Size)  tsize = AttTblStr->nsize = TempTBL_Size; 

					tbllen = (tsize*1); // data type: int16!!
					{
						INT8U *dsptr = (INT8U *)AttTblStr->Data;
						INT8U *stptr = (INT8U *)&rBody->SubData[3];
						
						for(i = 0; i < tbllen && i < (TempTBL_Size); i++)
						{
							dsptr[i] = (stptr[i]);
						}
					}
					WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
				}
				OS_EXIT_CRITICAL();
			}
			{
				AttTblStr = &vSYS_TABLE->AttnTempTbl[tIndex];

				tlimit = AttTblStr->limit;
				tsize = AttTblStr->nsize;
				if( tsize > TempTBL_Size)  tsize = AttTblStr->nsize = TempTBL_Size; 

				tbllen = (tsize*1); // data type: int16!!

				sBody->SubData[0] = TblID;
				sBody->SubData[1] = tlimit;
				sBody->SubData[2] = tsize;
				{
					INT8U *dsptr = (INT8U *)&sBody->SubData[3];
					INT8U *stptr = (INT8U *)AttTblStr->Data;
					
					for(i = 0; i < tbllen ; i++)
					{
						dsptr[i] = stptr[i];
					}
				}
			}

		}			
		break;

		default:
    	break;
	}

	GenBodyFrame(tid, (INT8U *)Send->BodyFrame[0].SubData, Send->BodyFrame[0].SubLength, Comm, nPtr, 0);
	WRCS_ProDataAckTx(nPtr);
}


INT8S TableIndex(INT8U TblID)
{
    INT8S tIndex = -1;

	switch(TblID)
	{
	//Dnr0
		case Index_RvsOutPwr_CDMALTE 	:	return Local_RvsOutPwr_CDMALTE; 
		case Index_FwdOutAvgPwr_LTE_A1 	:	return Local_FwdOutAvgPwr_LTE_A1;
		case Index_RvsOutPwr_LTE_A1 	:	return Local_RvsOutPwr_LTE_A1;
		case Index_RvsOutPwr_LTE_A2 	:	return Local_RvsOutPwr_LTE_A2;
		case Index_FwdOutAvgPwr_LTE_A2 	:	return Local_FwdOutAvgPwr_LTE_A2;
		case Index_FwdInPwr_LTE_A		:	return Local_FwdInPwr_LTE_A;
		case Index_RvsOutPwr_LTE_A 		:	return Local_RvsOutPwr_LTE_A; 
		case Index_FwdInPwr_3G 			:	return Local_FwdInPwr_3G;
		case Index_Fwd1OutAvgPwr_LTE 	:	return Local_Fwd1OutAvgPwr_LTE;
		case Index_Rvs1InPwr_LTE 		:	return Local_Rvs1InPwr_LTE;
		case Index_FwdOutAvgPwr_LTE_A_1 :	return Local_FwdOutAvgPwr_LTE_A_1;
	//Dnr1
		case Index_FwdInPwr_CDMALTE		:	return Local_FwdInPwr_CDMALTE;
		case Index_RvsOutPwr_3G 		:	return Local_RvsOutPwr_3G;
		case Index_RvsInPwr_LTE_A_1 	:	return Local_RvsInPwr_LTE_A_1;

	//Svr0
		case Index_FwdOutAvgPwr_2G		:	return Local_FwdOutAvgPwr_2G;
		case Index_RvsOutPwr_2G 		:	return Local_RvsOutPwr_2G;
		case Index_FwdOutAvgPwr_LTE 	:	return Local_FwdOutAvgPwr_LTE;
		case Index_RvsOutPwr_LTE 		:	return Local_RvsOutPwr_LTE;
		case Index_FwdOutAvgPwr_CDMALTE 	:	return Local_FwdOutAvgPwr_CDMALTE;
		case Index_RvsInPwr_CDMALTE		:	return Local_RvsInPwr_CDMALTE;
		case Index_FwdOutAvgPwr_LTE_A 	:	return Local_FwdOutAvgPwr_LTE_A;
		case Index_FwdOutAvgPwr_3G 		:	return Local_FwdOutAvgPwr_3G; 
		case Index_RvsInPwr_3G 			:	return Local_RvsInPwr_3G;
		
		case Index_RvsInPwr_LTE_A		:	return Local_RvsInPwr_LTE_A;
		case Index_Fwd1InPwr_LTE 		:	return Local_Fwd1InPwr_LTE;
		case Index_Rvs1OutPwr_LTE 		:	return Local_Rvs1OutPwr_LTE; 
		case Index_Fwd1OutAvgPwr_LTE_A1 :	return Local_Fwd1OutAvgPwr_LTE_A1;
		case Index_Fwd1OutAvgPwr_LTE_A2 :	return Local_Fwd1OutAvgPwr_LTE_A2;
		case Index_Rvs1OutPwr_LTE_A1 	:	return Local_Rvs1OutPwr_LTE_A1;
		case Index_Rvs1OutPwr_LTE_A2 	:	return Local_Rvs1OutPwr_LTE_A2;
		case Index_FwdInPwr_LTE_A_1		:	return Local_FwdInPwr_LTE_A_1;
		case Index_RvsOutPwr_LTE_A_1 	:	return Local_RvsOutPwr_LTE_A_1; 
///Dnr
		case Index_RvsAttn2_2G 			:	return Local_RvsAttn2_2G; 
		case Index_RvsAttn3_2G 			:	return Local_RvsAttn3_2G;
		case Index_RvsAttn2_LTE 		:	return Local_RvsAttn2_LTE; 
		case Index_RvsAttn3_LTE 		:	return Local_RvsAttn3_LTE;
		case Index_FwdAttn1_CDMALTE 	:	return Local_FwdAttn1_CDMALTE;
		case Index_FwdAttn1_LTE_A1 		:	return Local_FwdAttn1_LTE_A1;
		case Index_FwdAttn2_LTE_A1 		:	return Local_FwdAttn2_LTE_A1;
		case Index_RvsAttn1_LTE_A1 		:	return Local_RvsAttn1_LTE_A1;
		case Index_RvsAttn2_LTE_A1 		:	return Local_RvsAttn2_LTE_A1;
		case Index_RvsAttn3_LTE_A1		:	return Local_RvsAttn3_LTE_A1;	 
		case Index_FwdAttn1_LTE_A2 		:	return Local_FwdAttn1_LTE_A2;
		case Index_FwdAttn2_LTE_A2 		:	return Local_FwdAttn2_LTE_A2;
		case Index_RvsAttn1_LTE_A2 		:	return Local_RvsAttn1_LTE_A2;
		case Index_RvsAttn2_LTE_A2 		:	return Local_RvsAttn2_LTE_A2;
		case Index_RvsAttn3_LTE_A2 		:	return Local_RvsAttn3_LTE_A2;
		case Index_FwdAttn1_LTE_A 		:	return Local_FwdAttn1_LTE_A;
		case Index_FwdAttn1_3G 			:	return Local_FwdAttn1_3G;
		case Index_FwdAttn2_3G 			:	return Local_FwdAttn2_3G;
		case Index_RvsAttn3_3G 			:	return Local_RvsAttn3_3G;
		case Index_RvsAttn4_3G 			:	return Local_RvsAttn4_3G;
		case Index_Rvs1Attn1_LTE		:	return Local_Rvs1Attn1_LTE;	 
		case Index_Rvs1Attn2_LTE		:	return Local_Rvs1Attn2_LTE;
		case Index_RvsAttn1_LTE_A_1		:	return Local_RvsAttn1_LTE_A_1;

//Svr0
		case Index_FwdAttn1_2G 			:	return Local_FwdAttn1_2G;
		case Index_FwdAttn2_2G 			:	return Local_FwdAttn2_2G;
		case Index_RvsAttn1_2G 			:	return Local_RvsAttn1_2G;
		case Index_FwdAttn1_LTE 		:	return Local_FwdAttn1_LTE; 
		case Index_FwdAttn2_LTE 		:	return Local_FwdAttn2_LTE;
		case Index_RvsAttn1_LTE 		:	return Local_RvsAttn1_LTE;
		case Index_RvsAttn1_CDMALTE 	:	return Local_RvsAttn1_CDMALTE;
		case Index_RvsAttn1_LTE_A 		:	return Local_RvsAttn1_LTE_A;
		case Index_RvsAttn1_3G 			:	return Local_RvsAttn1_3G;
		case Index_RvsAttn2_3G 			:	return Local_RvsAttn2_3G;
		case Index_Fwd1Attn1_LTE	 	:	return Local_Fwd1Attn1_LTE;	
		case Index_Fwd1Attn2_LTE	 	:	return Local_Fwd1Attn2_LTE;
		case Index_Rvs1Attn3_LTE	 	:	return Local_Rvs1Attn3_LTE;
		case Index_Rvs1Attn4_LTE	 	:	return Local_Rvs1Attn4_LTE;

		
//Svr1
		case Index_Fwd1Attn1_LTE_A1 	:	return Local_Fwd1Attn1_LTE_A1;
		case Index_Fwd1Attn2_LTE_A1		:	return Local_Fwd1Attn2_LTE_A1;
		case Index_Rvs1Attn1_LTE_A1	 	:	return Local_Rvs1Attn1_LTE_A1;
		case Index_Rvs1Attn2_LTE_A1 	:	return Local_Rvs1Attn2_LTE_A1;
		case Index_Rvs1Attn3_LTE_A1 	:	return Local_Rvs1Attn3_LTE_A1;
		case Index_Fwd1Attn1_LTE_A2 	:	return Local_Fwd1Attn1_LTE_A2;
		case Index_Fwd1Attn2_LTE_A2		:	return Local_Fwd1Attn2_LTE_A2;
		case Index_Rvs1Attn1_LTE_A2 	:	return Local_Rvs1Attn1_LTE_A2;
		case Index_Rvs1Attn2_LTE_A2 	:	return Local_Rvs1Attn2_LTE_A2;
		case Index_Rvs1Attn3_LTE_A2 	:	return Local_Rvs1Attn3_LTE_A2;
		case Index_FwdAttn1_LTE_A_1 	:	return Local_FwdAttn1_LTE_A_1;

		case Index_FwdTempAttn_2G  		:	return Local_FwdTempAttn_2G; 
		case Index_RvsTempAttn_2G  		:	return Local_RvsTempAttn_2G; 
		case Index_FwdTempAttn_LTE 		:	return Local_FwdTempAttn_LTE; 
		case Index_RvsTempAttn_LTE 		:	return Local_RvsTempAttn_LTE;
		case Index_FwdTempAttn_LTE_A1	:	return Local_FwdTempAttn_LTE_A1;
		case Index_RvsTempAttn_LTE_A1	:	return Local_RvsTempAttn_LTE_A1;
		case Index_FwdTempAttn_LTE_A2	:	return Local_FwdTempAttn_LTE_A2;
		case Index_RvsTempAttn_LTE_A2	:	return Local_RvsTempAttn_LTE_A2;
		case Index_FwdTempAttn_3G  		:	return Local_FwdTempAttn_3G;
		case Index_RvsTempAttn_3G		:	return Local_RvsTempAttn_3G;
		case Index_Fwd1TempAttn_LTE 	:	return Local_Fwd1TempAttn_LTE; 
		case Index_Rvs1TempAttn_LTE 	:	return Local_Rvs1TempAttn_LTE;
		case Index_Fwd1TempAttn_LTE_A1 	:	return Local_Fwd1TempAttn_LTE_A1;
		case Index_Rvs1TempAttn_LTE_A1 	:	return Local_Rvs1TempAttn_LTE_A1;
		case Index_Fwd1TempAttn_LTE_A2 	:	return Local_Fwd1TempAttn_LTE_A2;
		case Index_Rvs1TempAttn_LTE_A2 	:	return Local_Rvs1TempAttn_LTE_A2;
	}
	return tIndex;
}

INT8S TableLocation(INT8U TblID)
{
    INT8S tIndex = -1;

	switch(TblID)
	{
		case Index_RvsOutPwr_CDMALTE 	:
		case Index_FwdOutAvgPwr_LTE_A1 	:
		case Index_RvsOutPwr_LTE_A1 	:
		case Index_RvsOutPwr_LTE_A2 	:
		case Index_FwdOutAvgPwr_LTE_A2 	:
		case Index_FwdInPwr_LTE_A		:
		case Index_RvsOutPwr_LTE_A 		:
		case Index_FwdInPwr_3G 			:
		case Index_Fwd1OutAvgPwr_LTE 	:
		case Index_Rvs1InPwr_LTE 		:
		case Index_FwdOutAvgPwr_LTE_A_1 :
			tIndex = _DnrPwr0_Location;
		break;


	    case Index_FwdInPwr_CDMALTE     :
	    case Index_RvsOutPwr_3G 		:
	    case Index_RvsInPwr_LTE_A_1		:
			tIndex = _DnrPwr1_Location;
		break;

		case Index_FwdOutAvgPwr_2G		:
		case Index_RvsOutPwr_2G 		:
		case Index_FwdOutAvgPwr_LTE 	:
		case Index_RvsOutPwr_LTE 		:
		case Index_FwdOutAvgPwr_CDMALTE	:
		case Index_RvsInPwr_CDMALTE		:
		case Index_FwdOutAvgPwr_LTE_A 	:
		case Index_FwdOutAvgPwr_3G 		:
		case Index_RvsInPwr_3G 			:
			tIndex = _SvrPwr0_Location;
		break;

		case Index_RvsInPwr_LTE_A		:
		case Index_Fwd1InPwr_LTE 		:
		case Index_Rvs1OutPwr_LTE 		:
		case Index_Fwd1OutAvgPwr_LTE_A1 :
		case Index_Fwd1OutAvgPwr_LTE_A2 :
		case Index_Rvs1OutPwr_LTE_A1 	:
		case Index_Rvs1OutPwr_LTE_A2 	:
		case Index_FwdInPwr_LTE_A_1		:
		case Index_RvsOutPwr_LTE_A_1 	:

			tIndex = _SvrPwr1_Location;
		break;

		default:
			tIndex = _ETC_Location;
		break;
	}

	return tIndex;
}


INT8S PwrTableLocation(INT8U TblID)
{
    INT8S tIndex = -1;

	switch(TblID)
	{
		case Index_FwdOutAvgPwr_3G		:
		case Index_FwdOutAvgPwr_2G		:
		case Index_FwdOutAvgPwr_LTE 	:
		case Index_FwdOutAvgPwr_LTE_A1	:
		case Index_FwdOutAvgPwr_LTE_A2	:
		case Index_Fwd1OutAvgPwr_LTE	:
		case Index_Fwd1OutAvgPwr_LTE_A1 :
		case Index_Fwd1OutAvgPwr_LTE_A2 :
		case Index_FwdOutAvgPwr_CDMALTE :
		case Index_FwdOutAvgPwr_LTE_A	:
		case Index_FwdOutAvgPwr_LTE_A_1 :
			tIndex = _FwdOutPwr_Location;
		break;


		case Index_FwdInPwr_3G 			:
		case Index_FwdInPwr_CDMALTE 	:
		case Index_FwdInPwr_LTE_A		:
		case Index_Fwd1InPwr_LTE		:
		case Index_FwdInPwr_LTE_A_1 	:
			tIndex = _FwdInPwr_Location;
		break;

		case Index_RvsInPwr_CDMALTE 	:
		case Index_RvsInPwr_3G			:
		case Index_Rvs1InPwr_LTE		:
		case Index_RvsInPwr_LTE_A		:
		case Index_RvsInPwr_LTE_A_1 	:
			tIndex = _RvsInPwr_Location;
		break;


		case Index_RvsOutPwr_3G 		:
		case Index_RvsOutPwr_2G 		:
		case Index_RvsOutPwr_LTE		:
		case Index_RvsOutPwr_LTE_A1 	:
		case Index_RvsOutPwr_LTE_A2 	:
		case Index_Rvs1OutPwr_LTE		:
		case Index_Rvs1OutPwr_LTE_A1	:
		case Index_Rvs1OutPwr_LTE_A2	:

		case Index_RvsOutPwr_CDMALTE 	:
		case Index_RvsOutPwr_LTE_A 		:
		case Index_RvsOutPwr_LTE_A_1	:
			tIndex = _RvsOutPwr_Location;
		break;

		default:
		break;
	}

	return tIndex;
}

INT8S AttnTableLocation(INT8U TblID)
{
    INT8S tIndex = -1;

	switch(TblID)
	{
		case Index_RvsAttn2_2G 			:
		case Index_RvsAttn3_2G 			:
		case Index_RvsAttn2_LTE 		:
		case Index_RvsAttn3_LTE 		:
		case Index_FwdAttn1_CDMALTE 		:
		case Index_FwdAttn1_LTE_A1 		:
		case Index_FwdAttn2_LTE_A1 		:
		case Index_RvsAttn1_LTE_A1 		:
		case Index_RvsAttn2_LTE_A1 		:
		case Index_RvsAttn3_LTE_A1		:
		case Index_FwdAttn1_LTE_A2 		:
		case Index_FwdAttn2_LTE_A2 		:
		case Index_RvsAttn1_LTE_A2 		:
		case Index_RvsAttn2_LTE_A2 		:
		case Index_RvsAttn3_LTE_A2 		:
		case Index_FwdAttn1_LTE_A 		:
		case Index_FwdAttn1_3G 			:
		case Index_FwdAttn2_3G 			:
		case Index_RvsAttn3_3G 			:
		case Index_RvsAttn4_3G 			:
		case Index_Rvs1Attn1_LTE		:
		case Index_Rvs1Attn2_LTE		:
		case Index_RvsAttn1_LTE_A_1		:
			tIndex = _DnrAttn_Location;
		break;

		case Index_FwdAttn1_2G 			:
		case Index_FwdAttn2_2G 			:
		case Index_RvsAttn1_2G 			:
		case Index_FwdAttn1_LTE 		:
		case Index_FwdAttn2_LTE 		:
		case Index_RvsAttn1_LTE 		:
		case Index_RvsAttn1_CDMALTE 		:
		case Index_RvsAttn1_LTE_A 		:
		case Index_RvsAttn1_3G 			:
		case Index_RvsAttn2_3G 			:
		case Index_Fwd1Attn1_LTE	 	:
		case Index_Fwd1Attn2_LTE	 	:
		case Index_Rvs1Attn3_LTE	 	:
		case Index_Rvs1Attn4_LTE	 	:
		case Index_Fwd1Attn1_LTE_A1 	:
		case Index_Fwd1Attn2_LTE_A1		:
		case Index_Rvs1Attn1_LTE_A1	 	:
		case Index_Rvs1Attn2_LTE_A1 	:
		case Index_Rvs1Attn3_LTE_A1 	:
		case Index_Fwd1Attn1_LTE_A2 	:
		case Index_Fwd1Attn2_LTE_A2		:
		case Index_Rvs1Attn1_LTE_A2 	:
		case Index_Rvs1Attn2_LTE_A2 	:
		case Index_Rvs1Attn3_LTE_A2 	:
		case Index_FwdAttn1_LTE_A_1 	:
			tIndex = _SvrAttn_Location;
		break;
		default:
		break;
	}

	return tIndex;
}




void DefaultValueSet_Test(INT8U Value)
{
//	INT8U err = 0;
	INT32U cpu_sr;
	OS_ENTER_CRITICAL();

	#ifdef __DefaultTbl
	switch(Value) //command u?
	{
		case TRIO_M_TBL :
			DefaultAttTable_TRIO_M();
			DefaultTempTable_TRIO_M();
//			DefaultPwrTable_TRIO_M();
			DefaultTableSet();
		break;

		case TRIO_MM_TBL:
			DefaultAttTable_TRIO_MM();
			DefaultTempTable_TRIO_MM();
//			DefaultPwrTable_TRIO_MM();
			DefaultTableSet();
		break;

		case Default_TBL:
			DefaultAttTableInit();
			DefaultTempTableInit();
			DefaultPwrTableInit();
			DefaultTableSet();
		break;
		default:
		break;
	}
	#endif
	OS_EXIT_CRITICAL();
}

void DefaultAttTable_TRIO_M(void)
{
	INT32U cpu_sr;

	int i = 0;
	
	OS_ENTER_CRITICAL();
	{
		__AttnOffsetTblStr *AttTblStr;
		SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_2G];
		AttTblStr->limit = AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn2_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_2G];
		AttTblStr->limit = AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn3_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn2_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}
		
		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn3_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_CDMALTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn1_CDMALTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn1_LTE_A1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn2_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn2_LTE_A1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		
		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn1_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn1_LTE_A1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);

		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);

		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn1_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}
		
		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn2_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn1_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn2_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn3_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_LTE_A];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn1_LTE_A;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn2_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}
		
		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn4_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}			


		WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
	}


	{
		__AttnOffsetTblStr *AttTblStr;
		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);

		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn1_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn1_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn2_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn2_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		
		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn1_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	


		
		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn1_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn1_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));


		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn2_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_FwdAttn2_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn1_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_CDMALTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn1_CDMALTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		
		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_LTE_A];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	

		
		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_M_RvsAttn1_WCDMA;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn2_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	


		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));

	}

	OS_EXIT_CRITICAL();
}




void DefaultAttTable_TRIO_MM(void)
{
	INT32U cpu_sr;

	int i = 0;
	
	OS_ENTER_CRITICAL();
	{
		__AttnOffsetTblStr *AttTblStr;
		SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn2_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn2_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}
		
		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn3_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_CDMALTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_CDMALTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn2_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_LTE_A1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		
		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn1_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_LTE_A1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}
		
		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn2_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn1_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn2_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn2_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn3_LTE_A2;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_LTE_A];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}


		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn1_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_WCDMA;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_FwdAttn2_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_WCDMA;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}
		
		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn3_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn4_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn4_WCDMA;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}			

		AttTblStr = &tptr->DnrAttnTbl[Local_Rvs1Attn1_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_LTE_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->DnrAttnTbl[Local_Rvs1Attn2_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn2_LTE_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->DnrAttnTbl[Local_RvsAttn1_LTE_A_1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	

		WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
	}


	{
		__AttnOffsetTblStr *AttTblStr;
		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);

		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn1_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn2_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		
		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_2G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_2G;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	


		
		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn1_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));


		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn2_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_LTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_CDMALTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_CDMALTE;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		
		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_LTE_A];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	

		
		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn1_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}

		AttTblStr = &tptr->SvrAttnTbl[Local_RvsAttn2_3G];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_Fwd1Attn1_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_LTE_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->SvrAttnTbl[Local_Fwd1Attn2_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_LTE_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn3_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn3_LTE_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}

		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn4_LTE];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn4_LTE_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_Fwd1Attn1_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_LTE_A1_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_Fwd1Attn2_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_LTE_A1_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	

		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn1_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_LTE_A1_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	
		
		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn2_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn2_LTE_A1_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	
		
		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn3_LTE_A1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn3_LTE_A1_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	
//
		AttTblStr = &tptr->SvrAttnTbl[Local_Fwd1Attn1_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn1_LTE_A2_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	
		
		AttTblStr = &tptr->SvrAttnTbl[Local_Fwd1Attn2_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_FwdAttn2_LTE_A2_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	
		
		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn1_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			INT8U *stptr = (INT8U *)TRIO_MM_RvsAttn1_LTE_A2_1;
				
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
		}	
		
		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn2_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	
		
		AttTblStr = &tptr->SvrAttnTbl[Local_Rvs1Attn3_LTE_A2];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	


		AttTblStr = &tptr->SvrAttnTbl[Local_FwdAttn1_LTE_A_1];
		AttTblStr->limit =  AttMaxLimit;
		AttTblStr->nsize = 61;
		{
			INT8U *dsptr = (INT8U *)AttTblStr->Data;
			for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
		}	

		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));

	}

	OS_EXIT_CRITICAL();
}




void DefaultTempTable_TRIO_M(void)
{
	INT32U i = 0;

	__AttnTempTblStr *AttTblStr;

	{
		INT32U cpu_sr;
		OS_ENTER_CRITICAL();
		{
			SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_2G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);;
				
//				INT8U *stptr = (INT8U *)TRIO_M_FwdTempAtt_CDMA;
				
//				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_2G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);;
			}

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_LTE];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);;
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_LTE];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);;
			}

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_LTE_A1];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_M_FwdTempAtt_LTE_A1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_LTE_A2];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_M_FwdTempAtt_LTE_A2;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_LTE_A1];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_M_RvsTempAtt_LTE_A1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_LTE_A2];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_M_RvsTempAtt_LTE_A2;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_3G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_M_FwdTempAtt_WCDMA;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_3G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_M_RvsTempAtt_WCDMA;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
		}
		OS_EXIT_CRITICAL();
	}
}


void DefaultTempTable_TRIO_MM(void)
{
	INT32U i = 0;

	__AttnTempTblStr *AttTblStr;

	{
		INT32U cpu_sr;
		OS_ENTER_CRITICAL();
		{
			SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_2G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_CDMA;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_2G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_CDMA;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_LTE];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_LTE;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_LTE];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_LTE;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_LTE_A1];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_LTE_A1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_LTE_A2];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_LTE_A2;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_LTE_A1];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_LTE_A1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_LTE_A2];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_LTE_A2;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			AttTblStr = &tptr->AttnTempTbl[Local_FwdTempAttn_3G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_WCDMA;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_RvsTempAttn_3G];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_WCDMA;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}
///
			AttTblStr = &tptr->AttnTempTbl[Local_Fwd1TempAttn_LTE];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_LTE_1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_Rvs1TempAttn_LTE];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_LTE_1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_Fwd1TempAttn_LTE_A1];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_LTE_A1_1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_Fwd1TempAttn_LTE_A2];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_FwdTempAtt_LTE_A2_1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			AttTblStr = &tptr->AttnTempTbl[Local_Rvs1TempAttn_LTE_A1];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_LTE_A1_1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			AttTblStr = &tptr->AttnTempTbl[Local_Rvs1TempAttn_LTE_A2];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				INT8U *stptr = (INT8U *)TRIO_MM_RvsTempAtt_LTE_A2_1;
					
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
		}
		OS_EXIT_CRITICAL();
	}
}



void DefaultPwrTable_TRIO_M(void)
{
	INT32U i = 0;

	{
		INT32U cpu_sr;
		OS_ENTER_CRITICAL();

		{
			__Dnr0OutputTblStr *TblStr;

			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_CDMALTE]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;

			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_CDMALTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}
			
			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdOutAvgPwr_LTE_A1]);
			TblStr->limit = 25*2;
			TblStr->nsize = 26;

			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdOutPwr_LTE_A1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}


			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_LTE_A1]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_LTE_A1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_LTE_A2]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_LTE_A2;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdOutAvgPwr_LTE_A2]);
			TblStr->limit = 28*2;
			TblStr->nsize = 26;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdOutPwr_LTE_A2;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}
			
			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdInPwr_LTE_A]);
			TblStr->limit = -15*2;
			TblStr->nsize = 32;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdInPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_LTE_A]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdInPwr_3G]);
			TblStr->limit = -17*2;
			TblStr->nsize = 34;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdInPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
		}
		
		{
			__Dnr1OutputTblStr *TblStr;

			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

			TblStr = &(tptr->Dnr1OutputTbl[Local_FwdInPwr_CDMALTE]);
			TblStr->limit = -4*2;
			TblStr->nsize = 47;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdInPwr_CDMALTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Dnr1OutputTbl[Local_RvsOutPwr_3G]);
			TblStr->limit = 26*2;
			TblStr->nsize = 58;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
		}
		
		{
			__Svr0OutputTblStr *TblStr;

			EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_2G]);
			TblStr->limit = 22*2;
			TblStr->nsize = 26;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdOutPwr_CDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsOutPwr_2G]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_CDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_LTE]);
			TblStr->limit = 25*2;
			TblStr->nsize = 26;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdOutPwr_LTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsOutPwr_LTE]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_LTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_CDMALTE]);
			TblStr->limit = 27*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdOutPwr_CDMALTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsInPwr_CDMALTE]);
			TblStr->limit = -12*2;
			TblStr->nsize = 31;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsInPwr_CDMALTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_LTE_A]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdOutPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_3G]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_FwdOutPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsInPwr_3G]);
			TblStr->limit = -12*2;
			TblStr->nsize = 31;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsInPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
		}
		
		{
			__Svr1OutputTblStr *TblStr;

			EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

			TblStr = &(tptr->Svr1OutputTbl[Local_RvsInPwr_LTE_A]);
			TblStr->limit = -12*2;
			TblStr->nsize = 39;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_M_RvsInPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
		}
		
		OS_EXIT_CRITICAL();
	}
}


void DefaultPwrTable_TRIO_MM(void)
{
	INT32U i = 0;

	{
		INT32U cpu_sr;
		OS_ENTER_CRITICAL();

		{
			__Dnr0OutputTblStr *TblStr;

			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_CDMALTE]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;

			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
//				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = (NULL);;
#if 1
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_CDMALTE;
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
#endif
			}
			
			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdOutAvgPwr_LTE_A1]);
			TblStr->limit = 25*2;
			TblStr->nsize = 26;

			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE_A1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}


			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_LTE_A1]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE_A1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_LTE_A2]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE_A2;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdOutAvgPwr_LTE_A2]);
			TblStr->limit = 28*2;
			TblStr->nsize = 26;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE_A2;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}
			
			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdInPwr_LTE_A]);
			TblStr->limit = -15*2;
			TblStr->nsize = 32;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdInPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_RvsOutPwr_LTE_A]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}



			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdInPwr_3G]);
			TblStr->limit = -17*2;
			TblStr->nsize = 34;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdInPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			TblStr = &(tptr->Dnr0OutputTbl[Local_Fwd1OutAvgPwr_LTE]);
			TblStr->limit = 27*2;
			TblStr->nsize = 23;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}


			TblStr = &(tptr->Dnr0OutputTbl[Local_Rvs1InPwr_LTE]);
			TblStr->limit = -12*2;
			TblStr->nsize = 31;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsInPwr_LTE_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}


			TblStr = &(tptr->Dnr0OutputTbl[Local_FwdOutAvgPwr_LTE_A_1]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE_A_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];

			}

			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
		}
		
		{
			__Dnr1OutputTblStr *TblStr;

			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

			TblStr = &(tptr->Dnr1OutputTbl[Local_FwdInPwr_CDMALTE]);
			TblStr->limit = -4*2;
			TblStr->nsize = 47;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdInPwr_CDMALTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Dnr1OutputTbl[Local_RvsOutPwr_3G]);
			TblStr->limit = 26*2;
			TblStr->nsize = 58;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Dnr1OutputTbl[Local_RvsInPwr_LTE_A_1]);
			TblStr->limit = -12*2;
			TblStr->nsize = 39;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsInPwr_LTE_A_1;
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}
			
			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
		}
		
		{
			__Svr0OutputTblStr *TblStr;

			EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_2G]);
			TblStr->limit = 22*2;
			TblStr->nsize = 26;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_CDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsOutPwr_2G]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_CDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_LTE]);
			TblStr->limit = 25*2;
			TblStr->nsize = 26;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsOutPwr_LTE]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_CDMALTE]);
			TblStr->limit = 27*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_CDMALTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsInPwr_CDMALTE]);
			TblStr->limit = -12*2;
			TblStr->nsize = 31;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsInPwr_CDMALTE;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_LTE_A]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_FwdOutAvgPwr_3G]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr0OutputTbl[Local_RvsInPwr_3G]);
			TblStr->limit = -12*2;
			TblStr->nsize = 31;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsInPwr_WCDMA;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
		}
		
		{
			__Svr1OutputTblStr *TblStr;

			EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

			TblStr = &(tptr->Svr1OutputTbl[Local_RvsInPwr_LTE_A]);
			TblStr->limit = -12*2;
			TblStr->nsize = 39;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsInPwr_LTE_A;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}


			TblStr = &(tptr->Svr1OutputTbl[Local_Fwd1InPwr_LTE]);
			TblStr->limit = -4*2;
			TblStr->nsize = 47;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdInPwr_LTE_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			 TblStr = &(tptr->Svr1OutputTbl[Local_Rvs1OutPwr_LTE]);
			 TblStr->limit = 26*2;
			 TblStr->nsize = 67;
			 {
				 INT16U *dsptr = (INT16U *)TblStr->Data;
				 INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE_1;
				 
				 for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			 }

			 TblStr = &(tptr->Svr1OutputTbl[Local_Fwd1OutAvgPwr_LTE_A1]);
			 TblStr->limit = 25*2;
			 TblStr->nsize = 26;
			 {
				 INT16U *dsptr = (INT16U *)TblStr->Data;
				 INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE_A1_1;
				 
				 for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			 }


			TblStr = &(tptr->Svr1OutputTbl[Local_Fwd1OutAvgPwr_LTE_A2]);
			TblStr->limit = 28*2;
			TblStr->nsize = 26;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdOutPwr_LTE_A2_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr1OutputTbl[Local_Rvs1OutPwr_LTE_A1]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE_A1_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr1OutputTbl[Local_Rvs1OutPwr_LTE_A2]);
			TblStr->limit = 26*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE_A2_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr1OutputTbl[Local_FwdInPwr_LTE_A_1]);
			TblStr->limit = -15*2;
			TblStr->nsize = 32;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_FwdInPwr_LTE_A_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			TblStr = &(tptr->Svr1OutputTbl[Local_RvsOutPwr_LTE_A_1]);
			TblStr->limit = 28*2;
			TblStr->nsize = 21;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				INT16U *stptr = (INT16U *)TRIO_MM_RvsOutPwr_LTE_A_1;
				
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = stptr[i];
			}

			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
		}
		
		OS_EXIT_CRITICAL();
	}
}

void DefaultAttTableInit(void)
{
	INT32U cpu_sr;

	int i = 0;
	int j = 0;

	j =j;
	OS_ENTER_CRITICAL();
	{
		__AttnOffsetTblStr *AttTblStr;
		SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);

		for(j = 0; j < Local_DnrAttn_Max; j++) 
		{
			
			AttTblStr = &tptr->DnrAttnTbl[j];
			AttTblStr->limit = AttMaxLimit;
			AttTblStr->nsize = 61;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
			}
		}

		WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
	}


	{
		__AttnOffsetTblStr *AttTblStr;
		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);

		for(j = 0; j < Local_Svr0Attn_Max; j++) 
		{
			
			AttTblStr = &tptr->SvrAttnTbl[j];
			AttTblStr->limit = AttMaxLimit;
			AttTblStr->nsize = 61;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
			}
		}

		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
	}

	OS_EXIT_CRITICAL();
}




void DefaultTempTableInit(void)
{
	INT32U i = 0;
	INT32U j = 0;

	__AttnTempTblStr *AttTblStr;

	j = j;
	{
		INT32U cpu_sr;
		OS_ENTER_CRITICAL();
		{
			SYS_TABLE *tptr = (SYS_TABLE *)RoadBackuptobuffer(__pSYSTAddr);

			for(j = 0; j < Local_TempAttn_Max; j++) 
			{
				
				AttTblStr = &tptr->AttnTempTbl[j];
				AttTblStr->limit = TempMaxlimit;
				AttTblStr->nsize = TempTBL_Size;
				{
					INT8U *dsptr = (INT8U *)AttTblStr->Data;
					for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
				}
			}

			WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
		}
		OS_EXIT_CRITICAL();
	}
}


void DefaultPwrTableInit(void)
{
	INT32U i = 0;
	INT32U j = 0;

	{
		INT32U cpu_sr;
		OS_ENTER_CRITICAL();

		{
			__Dnr0OutputTblStr *TblStr;

			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

			for(j = 0; j < Local_DnrPwr0_Max; j++) 
			{
				
				TblStr = &(tptr->Dnr0OutputTbl[j]);
				TblStr->limit = 0;
				TblStr->nsize = Dnr0OutputTBL_Size;
				{
					INT16U *dsptr = (INT16U *)TblStr->Data;
					for(i = 0; i < TblStr->nsize; i++) dsptr[i] = (NULL);
				}
			}
			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
		}
		
		{
			__Dnr1OutputTblStr *TblStr;

			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

			for(j = 0; j < Local_DnrPwr1_Max; j++) 
			{
				
				TblStr = &(tptr->Dnr1OutputTbl[j]);
				TblStr->limit = 0;
				TblStr->nsize = Dnr1OutputTBL_Size;
				{
					INT16U *dsptr = (INT16U *)TblStr->Data;
					for(i = 0; i < TblStr->nsize; i++) dsptr[i] = (NULL);
				}
			}
			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
		}
		
		{
			__Svr0OutputTblStr *TblStr;

			EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

			for(j = 0; j < Local_SvrPwr0_Max; j++) 
			{
				
				TblStr = &(tptr->Svr0OutputTbl[j]);
				TblStr->limit = 0;
				TblStr->nsize = Svr0OutputTBL_Size*2;
				{
					INT16U *dsptr = (INT16U *)TblStr->Data;
					for(i = 0; i < TblStr->nsize; i++) dsptr[i] = (NULL);
				}
			}

			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
		}
		
		{
			__Svr1OutputTblStr *TblStr;

			EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);

			for(j = 0; j < Local_SvrPwr1_Max; j++) 
			{
				
				TblStr = &(tptr->Svr1OutputTbl[j]);
				TblStr->limit = 0;
				TblStr->nsize = Svr1OutputTBL_Size*2;
				{
					INT16U *dsptr = (INT16U *)TblStr->Data;
					for(i = 0; i < TblStr->nsize; i++) dsptr[i] = (NULL);
				}
			}


			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
		}
		
		OS_EXIT_CRITICAL();
	}
}



////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

