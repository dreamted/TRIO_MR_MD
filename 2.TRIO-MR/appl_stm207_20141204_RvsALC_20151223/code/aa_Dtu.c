
//=====================================================================//
// DTU Comm
//=====================================================================//
#define SER4INT_C

#include "../include/main.h"

//=======================================================================//
// Library Function Code
//=======================================================================//

void Ser4Init(void)
{
 	DtuSer->CheckByte = pUSART4.CheckByte;
	DtuSer->RxGetByte = pUSART4.RxGetByte;
	DtuSer->PutStr = pUSART4.PutStr;
	DtuSer->TxCheckByte = pUSART4.TxCheckByte;
	DtuSer->BuffClear = pUSART4.BuffClear;

	DtuSer->TimerRx = TimerDtuRx;

	DtuSer->Recv = &Rdtu;
	DtuSer->Send = &Sdtu;

	DtuSer->OSSem = OSSemCreate(1);

	DtuControl = &DtuControlB;
	// DTU Alarm
	MuStatus->MuAlm.DtuLink_Alarm = _Alarm;
	MuStatus->MuAlm.DtuSts_Alarm = _Alarm;
	
	OSTaskCreate(Ser4Task, (void *)DtuSer, (OS_STK *)&Ser4TaskStk[SER4_STK_SIZE - 1], DTU_PRIO);
}

void Ser4Task(void *pdata)
{
	__ProtocolPtr *nPtr = (__ProtocolPtr *)pdata;

    nPtr = nPtr;
	pdata = pdata;
	OSTimeDly(100*DTU_PRIO);

	while(1)
	{
		while(!DownLoadGiveupTimerSet(NULL) && (!tTestFlag) && (!DistFlag))
		{
			GetDtuCommand();

			if((DtuInitFlag == 1)||(DtuInitFlag == 3))	DtuInitControl(nPtr);
			else					SioDataAckTx(MyID, DtuID, (INT8U*)NULL, 0, StatusRQST, nPtr);
			
			if(DtuLinkFailCnt++ > 5)
			{
				DtuLinkFailCnt = 10;
				MuStatus->MuAlm.DtuLink_Alarm = _Alarm;
			}
			
			if(ProtocolCheck(nPtr, (Time1Sec*2L)))
			{
				DtuProtocolComCheck(nPtr);
				
				DtuLinkFailCnt = 0;
				MuStatus->MuAlm.DtuLink_Alarm = _Normal;
			}

			EndDtuCommand();
			
			OSTimeDly(500L);
		}
		OSTimeDly(1000L);
	}
}


void DtuProtocolComCheck (__ProtocolPtr *nPtr)
{
	INT8U	i = 0;
	
	SIO *Recv = nPtr->Recv;
	
	switch(Recv->Command) //command 체크
	{
		//-----------------------------------------------------------------------//
		case StatusRSPS:
			Dtu2Status((__F_MU_STS*)Recv->Data);
		break;

		case ControlRSPS:
			if((DtuInitFlag == 1)||(DtuInitFlag == 3))
			{
				DtuInitFlag = 2;
				Sio_Crtl_Flag = 0;
			}

			for(i=0; i<5; i++)	DtuControl->ControlFlag.Data[i] = 0;
			Dtu2Status((__F_MU_STS*)Recv->Data);
		break;

		case ResetRSPS:
			//BypassFunction(PcSer, nPtr);
		break;

		//-----------------------------------------------------------------------//
		case DownloadRSPS:
		case DownDataRSPS:
		case DownConfirmRSPS:
			BypassFunction(PcSer, nPtr);
		break;
	}
}

void GetDtuCommand(void)
{
	while( !Dtu_Idle )	OSTimeDly(100);
	Dtu_Idle = 0;
}

void EndDtuCommand(void)
{
	Dtu_Idle = 1;
}

//=======================================================================//
void Dtu2Status(__F_MU_STS *Ptr)
{
	INT8U	i = 0;
//	INT8U	HuID, BrID, RuID;
	
	__MU_STS	*Sts = MuStatus;

	for(i=0; i<sizeof(__F_MU_STS); i++)
	{
		*((INT8U*)DtuStatus+i) = *((INT8U*)Ptr+i);
	}
	
	if(Sio_Crtl_Flag)	return;
	//if(Nms_Crtl_Flag)	return;
	
	if(DtuInitFlag == 0)
	{
		if(Ptr->FpgaSts == _Normal)
		{
			DtuInitFlag = 1;
		}
		Sts->MuAlm.DtuSts_Alarm	= Ptr->FpgaSts;
	}
	else if(DtuInitFlag == 2)
	{
		//-----------------------------------------------------------------------//
		Sts->DtuFpgaVer	= Ptr->FpgaVer;
		Sts->DtuVer	= Ptr->DtuVer;
		Sts->MuAlm.DtuSts_Alarm	= Ptr->FpgaSts;
		
		for(i=0; i<MDTU_MAX; i++)
		{
			Sts->MdtuSts[i].Install			= Ptr->OpticAlarm[i].Sfp_Insert;

			if(SysInfo->Hu_Install[i] != SYS_NOT_INST)
			{
				Sts->MdtuSts[i].Alarm.Pd_Alarm	= Ptr->OpticAlarm[i].Pd_Alarm;
				Sts->MdtuSts[i].Alarm.Ld_Alarm	= Ptr->OpticAlarm[i].Ld_Alarm;

				Sts->MdtuSts[i].LD_Power		= OpConvert(Ptr->LD_Power[i])+Sts->MdtuSts[i].LD_Offset;
				Sts->MdtuSts[i].PD_Power		= OpConvert(Ptr->PD_Power[i])+Sts->MdtuSts[i].PD_Offset;
			}
			else
			{
				Sts->MdtuSts[i].Alarm.Pd_Alarm	= _Normal;
				Sts->MdtuSts[i].Alarm.Ld_Alarm	= _Normal;

				Sts->MdtuSts[i].LD_Power		= 0;
				Sts->MdtuSts[i].PD_Power		= 0;
			}
			
			Sts->MdtuSts[i].BIP				= Ptr->BIP[i];
		}

		//-----------------------------------------------------------------------//
		/*
		if(DistFlag)
		{
			HuID = DistTarID.HuID;
			BrID = (DistTarID.RuID>>4)&0x0F;
			RuID = 0;
			if((DistType == MEA_TYPE)||(DistType == TAR_TYPE))
			{
				if(DistStep == 3)
				{
				//SerPtr->printf("\n Delay Update[%d]...%d\n",Ptr->Mea.MeaSts, Ptr->MeaResult);
					if(DistTarID.RuID == 0xFF)
							Sts->MeaResult				= Ptr->MeaResult;
					else	Sts->MeaResult				= Ptr->MeaResult + RuBuf[HuID][BrID][RuID]->DL_Delay_21G;
				}
			}
			else
			{
				if(DistStep == 5)
				{
					//SerPtr->printf("\n Delay Update[%d]...%d\n",Ptr->Mea.MeaSts, Ptr->MeaResult);
					if(DistTarID.RuID == 0xFF)
							DelaySts->DelayVal[HuID].Hu_Delay = Ptr->MeaResult;
					else	DelaySts->DelayVal[HuID].Ru_Delay[BrID] = Ptr->MeaResult;
				}
			}
		}
		*/
		Sts->MeaLoop				= Ptr->MeaLoop;
		Sts->MeaSts					= Ptr->MeaSts;
		Sts->MeaPath				= Ptr->MeaBranch;

#ifdef DIST_DEG
		if(DistFlag)	
			SerPtr->printf("\n Measure Status -> %x", Ptr->MeaSts);
#endif

		//-----------------------------------------------------------------------//
		Sts->MdtuSts[0].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br0;
		Sts->MdtuSts[1].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br1;
		Sts->MdtuSts[2].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br2;
		Sts->MdtuSts[3].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br3;
		Sts->MdtuSts[4].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br4;
		Sts->MdtuSts[5].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br5;
		Sts->MdtuSts[6].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br6;
		Sts->MdtuSts[7].OpticSum	= (INT8U)Ptr->OpticSum.Sum_Br7;
		//pUSART1.printf("\nOpticSum = %x Recv = %x ", Sts->MdtuSts[0].OpticSum, Ptr->OpticSum.Data);
		
		//-----------------------------------------------------------------------//
		Sts->CfrSts[S_900M_PATH].DL_DgtPower	= Ptr->DL_DgtPower[F_S_900M_PATH];
		Sts->CfrSts[M_900M_PATH].DL_DgtPower	= Ptr->DL_DgtPower[F_M_900M_PATH];
		Sts->CfrSts[S_21G_PATH].DL_DgtPower		= Ptr->DL_DgtPower[F_S_21G_PATH];
		Sts->CfrSts[M_21G_PATH].DL_DgtPower		= Ptr->DL_DgtPower[F_M_21G_PATH];
		Sts->CfrSts[S_25G_PATH].DL_DgtPower		= Ptr->DL_DgtPower[F_S_25G_PATH];
		Sts->CfrSts[M_25G_PATH].DL_DgtPower		= Ptr->DL_DgtPower[F_M_25G_PATH];

		Sts->CfrSts[M_900M_PATH].UL_DgtPower	= Ptr->UL_DgtPower[F_M_900M_PATH];
		Sts->CfrSts[S_900M_PATH].UL_DgtPower	= Ptr->UL_DgtPower[F_S_900M_PATH];
		Sts->CfrSts[S_21G_PATH].UL_DgtPower		= Ptr->UL_DgtPower[F_S_21G_PATH];
		Sts->CfrSts[M_21G_PATH].UL_DgtPower		= Ptr->UL_DgtPower[F_M_21G_PATH];
		Sts->CfrSts[S_25G_PATH].UL_DgtPower		= Ptr->UL_DgtPower[F_S_25G_PATH];
		Sts->CfrSts[M_25G_PATH].UL_DgtPower		= Ptr->UL_DgtPower[F_M_25G_PATH];

		//-----------------------------------------------------------------------//
		Sts->CfrSts[S_900M_PATH].Cfr_OnOff		= Ptr->Cfr_OnOff.S_900M;
		Sts->CfrSts[M_900M_PATH].Cfr_OnOff		= Ptr->Cfr_OnOff.M_900M;
		Sts->CfrSts[S_21G_PATH].Cfr_OnOff 		= Ptr->Cfr_OnOff.S_21G;
		Sts->CfrSts[M_21G_PATH].Cfr_OnOff 		= Ptr->Cfr_OnOff.M_21G;
		Sts->CfrSts[S_25G_PATH].Cfr_OnOff 		= Ptr->Cfr_OnOff.S_25G;
		Sts->CfrSts[M_25G_PATH].Cfr_OnOff 		= Ptr->Cfr_OnOff.M_25G;

		//-----------------------------------------------------------------------//
		Sts->CfrSts[S_900M_PATH].Cfr_Select.Data	= Ptr->Cfr_Select[F_S_900M_PATH].Data;
		Sts->CfrSts[M_900M_PATH].Cfr_Select.Data	= Ptr->Cfr_Select[F_M_900M_PATH].Data;
		Sts->CfrSts[S_21G_PATH].Cfr_Select.Data		= Ptr->Cfr_Select[F_S_21G_PATH].Data;
		Sts->CfrSts[M_21G_PATH].Cfr_Select.Data		= Ptr->Cfr_Select[F_M_21G_PATH].Data;
		Sts->CfrSts[S_25G_PATH].Cfr_Select.Data		= Ptr->Cfr_Select[F_S_25G_PATH].Data;
		Sts->CfrSts[M_25G_PATH].Cfr_Select.Data		= Ptr->Cfr_Select[F_M_25G_PATH].Data;

		//-----------------------------------------------------------------------//
		Sts->CfrSts[S_900M_PATH].Cfr_Threshold	= Ptr->Cfr_Threshold[F_S_900M_PATH];
		Sts->CfrSts[M_900M_PATH].Cfr_Threshold	= Ptr->Cfr_Threshold[F_M_900M_PATH];
		Sts->CfrSts[S_21G_PATH].Cfr_Threshold	= Ptr->Cfr_Threshold[F_S_21G_PATH];
		Sts->CfrSts[M_21G_PATH].Cfr_Threshold	= Ptr->Cfr_Threshold[F_M_21G_PATH];
		Sts->CfrSts[S_25G_PATH].Cfr_Threshold	= Ptr->Cfr_Threshold[F_S_25G_PATH];
		Sts->CfrSts[M_25G_PATH].Cfr_Threshold	= Ptr->Cfr_Threshold[F_M_25G_PATH];

		//-----------------------------------------------------------------------//
		// TDD
		Sts->TDD_Type				= Ptr->TDD_Type;
		Sts->DL_Sync_Fix			= Ptr->DL_Sync_Fix;
		Sts->UL_Sync_Fix			= Ptr->UL_Sync_Fix;
		Sts->DL_Start_Adj[0]		= Ptr->DL_Start_Adj[0];
		Sts->DL_Start_Adj[1]		= Ptr->DL_Start_Adj[1];
		Sts->DL_End_Adj[0]			= Ptr->DL_End_Adj[0];
		Sts->DL_End_Adj[1]			= Ptr->DL_End_Adj[1];
		Sts->UL_Start_Adj[0]		= Ptr->UL_Start_Adj[0];
		Sts->UL_Start_Adj[1]		= Ptr->UL_Start_Adj[1];
		Sts->UL_End_Adj[0]			= Ptr->UL_End_Adj[0];
		Sts->UL_End_Adj[1]			= Ptr->UL_End_Adj[1];
		Sts->Noise_Threshold[0]		= Ptr->Noise_Threshold[0];
		Sts->Noise_Threshold[1]		= Ptr->Noise_Threshold[1];
		Sts->Signal_Threshold[0]	= Ptr->Signal_Threshold[0];
		Sts->Signal_Threshold[1]	= Ptr->Signal_Threshold[1];
		Sts->Signal_Threshold[2]	= Ptr->Signal_Threshold[2];
		Sts->Signal_Threshold[3]	= Ptr->Signal_Threshold[3];

	}
}

//=======================================================================//
void DtuInitControl(__ProtocolPtr *toPtr)
{
	INT8U	i = 0, TemVal = 0;

	__MU_STS	*Sts = MuStatus;

	//-----------------------------------------------------------------------//
	if(DtuInitFlag == 1)	// 초기화 시에만 사용...
	{
		DtuControl->ControlFlag.Data[0] = 0x07;
		DtuControl->ControlFlag.Data[1] = 0x7F;
		DtuControl->ControlFlag.Data[2] = 0x3F;
		DtuControl->ControlFlag.Data[3] = 0x1F;
		DtuControl->ControlFlag.Data[4] = 0xFF;
	}
		
	for(i=0; i<5; i++)
		TemVal += DtuControl->ControlFlag.Data[i];
	
	if(TemVal != 0)
	{
		//-----------------------------------------------------------------------//
		DtuControl->MeaLoop				= _F_OFF;
		DtuControl->MeaBranch			= 0;

		//-----------------------------------------------------------------------//
		DtuControl->OpticSum.Sum_Br0	= Sts->MdtuSts[0].OpticSum;
		DtuControl->OpticSum.Sum_Br1	= Sts->MdtuSts[1].OpticSum;
		DtuControl->OpticSum.Sum_Br2	= Sts->MdtuSts[2].OpticSum;
		DtuControl->OpticSum.Sum_Br3	= Sts->MdtuSts[3].OpticSum;
		DtuControl->OpticSum.Sum_Br4	= Sts->MdtuSts[4].OpticSum;
		DtuControl->OpticSum.Sum_Br5	= Sts->MdtuSts[5].OpticSum;
		DtuControl->OpticSum.Sum_Br6	= Sts->MdtuSts[6].OpticSum;
		DtuControl->OpticSum.Sum_Br7	= Sts->MdtuSts[7].OpticSum;
					
		//-----------------------------------------------------------------------//
		DtuControl->Cfr_OnOff.S_900M	= Sts->CfrSts[S_900M_PATH].Cfr_OnOff;
		DtuControl->Cfr_OnOff.M_900M	= Sts->CfrSts[M_900M_PATH].Cfr_OnOff;
		DtuControl->Cfr_OnOff.S_21G		= Sts->CfrSts[S_21G_PATH].Cfr_OnOff;
		DtuControl->Cfr_OnOff.M_21G		= Sts->CfrSts[M_21G_PATH].Cfr_OnOff;
		DtuControl->Cfr_OnOff.S_25G		= Sts->CfrSts[S_25G_PATH].Cfr_OnOff;
		DtuControl->Cfr_OnOff.M_25G		= Sts->CfrSts[M_25G_PATH].Cfr_OnOff;
		
		//-----------------------------------------------------------------------//
		DtuControl->Cfr_Select[F_S_900M_PATH]	= Sts->CfrSts[S_900M_PATH].Cfr_Select;
		DtuControl->Cfr_Select[F_M_900M_PATH]	= Sts->CfrSts[M_900M_PATH].Cfr_Select;
		DtuControl->Cfr_Select[F_S_21G_PATH]	= Sts->CfrSts[S_21G_PATH].Cfr_Select;
		DtuControl->Cfr_Select[F_M_21G_PATH]	= Sts->CfrSts[M_21G_PATH].Cfr_Select;
		DtuControl->Cfr_Select[F_S_25G_PATH]	= Sts->CfrSts[S_25G_PATH].Cfr_Select;
		DtuControl->Cfr_Select[F_M_25G_PATH]	= Sts->CfrSts[M_25G_PATH].Cfr_Select;

		//-----------------------------------------------------------------------//
		DtuControl->Cfr_Threshold[F_S_900M_PATH]	= Sts->CfrSts[S_900M_PATH].Cfr_Threshold;
		DtuControl->Cfr_Threshold[F_M_900M_PATH]	= Sts->CfrSts[M_900M_PATH].Cfr_Threshold;
		DtuControl->Cfr_Threshold[F_S_21G_PATH]	= Sts->CfrSts[S_21G_PATH].Cfr_Threshold;
		DtuControl->Cfr_Threshold[F_M_21G_PATH]	= Sts->CfrSts[M_21G_PATH].Cfr_Threshold;
		DtuControl->Cfr_Threshold[F_S_25G_PATH]	= Sts->CfrSts[S_25G_PATH].Cfr_Threshold;
		DtuControl->Cfr_Threshold[F_M_25G_PATH]	= Sts->CfrSts[M_25G_PATH].Cfr_Threshold;
		
		//-----------------------------------------------------------------------//
		// TDD
		DtuControl->TDD_Type			= Sts->TDD_Type;
		DtuControl->DL_Sync_Fix			= Sts->DL_Sync_Fix;
		DtuControl->UL_Sync_Fix			= Sts->UL_Sync_Fix;
		DtuControl->DL_Start_Adj[0]		= Sts->DL_Start_Adj[0];
		DtuControl->DL_Start_Adj[1]		= Sts->DL_Start_Adj[1];
		DtuControl->DL_End_Adj[0]		= Sts->DL_End_Adj[0];
		DtuControl->DL_End_Adj[1]		= Sts->DL_End_Adj[1];
		DtuControl->UL_Start_Adj[0]		= Sts->UL_Start_Adj[0];
		DtuControl->UL_Start_Adj[1]		= Sts->UL_Start_Adj[1];
		DtuControl->UL_End_Adj[0]		= Sts->UL_End_Adj[0];
		DtuControl->UL_End_Adj[1]		= Sts->UL_End_Adj[1];
		DtuControl->Noise_Threshold[0]	= Sts->Noise_Threshold[0];
		DtuControl->Noise_Threshold[1]	= Sts->Noise_Threshold[1];
		DtuControl->Signal_Threshold[0]	= Sts->Signal_Threshold[0];
		DtuControl->Signal_Threshold[1]	= Sts->Signal_Threshold[1];
		DtuControl->Signal_Threshold[2]	= Sts->Signal_Threshold[2];
		DtuControl->Signal_Threshold[3]	= Sts->Signal_Threshold[3];

		//-----------------------------------------------------------------------//
		SioDataAckTx(MyID, DtuID, (INT8U*)DtuControl, sizeof(__F_MU_CTRL), ControlRQST, toPtr);

		//SioDataAckTx(MyID, DtuID, (INT8U*)DtuControl, sizeof(__F_MU_CTRL), ControlRQST, PcSer);
	}
	else
	{
		DtuInitFlag = 2;
		SioDataAckTx(MyID, DtuID, (INT8U*)NULL, 0, StatusRQST, toPtr);
	}
}

//=======================================================================//
INT8S OpConvert(INT16S OptVal)
{
	INT8S	RetVal = -50;
	INT8S	Round;
	INT16S	iVal;

	if(OptVal < -500)	return	RetVal;
	
	iVal = abs(OptVal%10);
//	SerPtr->printf("\n %d -> %d  / ", OptVal, iVal);

	if((iVal == 9)||(iVal == 8)||(iVal == 7)||(iVal == 4)||(iVal == 3))
	{
		if(OptVal >= 0)	Round = 1;
		else			Round = -1;
	}
	else	Round = 0;

//	SerPtr->printf(" Round = %d  / ", Round);

	RetVal = (OptVal/5) + Round;

	return	RetVal;
}


//=======================================================================//
// End of Source File
//=======================================================================//


