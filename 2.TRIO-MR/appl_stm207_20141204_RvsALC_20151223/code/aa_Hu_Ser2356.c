
//=====================================================================//
// RU Comm
//=====================================================================//
#define SER2INT_C

#include "../include/main.h"

//=======================================================================//
// Library Function Code
//=======================================================================//
//#define	DIST_DEG

void Ser2Init(void)
{
	// Ser2
 	Hu_Ser2Ser->CheckByte = pUSART2.CheckByte;
	Hu_Ser2Ser->RxGetByte = pUSART2.RxGetByte;
	Hu_Ser2Ser->PutStr = pUSART2.PutStr;
	Hu_Ser2Ser->TxCheckByte = pUSART2.TxCheckByte;
	Hu_Ser2Ser->BuffClear = pUSART2.BuffClear;

	Hu_Ser2Ser->TimerRx = TimerCcnRx;

	Hu_Ser2Ser->Recv = &Rhu;
	Hu_Ser2Ser->Send = &Shu;

	Hu_Ser2Ser->OSSem = OSSemCreate(1);

	// Ser3
 	Hu_Ser3Ser->CheckByte = pUSART3.CheckByte;
	Hu_Ser3Ser->RxGetByte = pUSART3.RxGetByte;
	Hu_Ser3Ser->PutStr = pUSART3.PutStr;
	Hu_Ser3Ser->TxCheckByte = pUSART3.TxCheckByte;
	Hu_Ser3Ser->BuffClear = pUSART3.BuffClear;

	Hu_Ser3Ser->TimerRx = TimerCcnRx;

	Hu_Ser3Ser->Recv = &Rhu;
	Hu_Ser3Ser->Send = &Shu;

	Hu_Ser3Ser->OSSem = OSSemCreate(1);

	// Ser5
 	//Hu_Ser5Ser->CheckByte = pUSART5.CheckByte;
	//Hu_Ser5Ser->RxGetByte = pUSART5.RxGetByte;
	//Hu_Ser5Ser->PutStr = pUSART5.PutStr;
	//Hu_Ser5Ser->TxCheckByte = pUSART5.TxCheckByte;
	//Hu_Ser5Ser->BuffClear = pUSART5.BuffClear;

	Hu_Ser5Ser->TimerRx = TimerCcnRx;

	Hu_Ser5Ser->Recv = &Rhu;
	Hu_Ser5Ser->Send = &Shu;

	Hu_Ser5Ser->OSSem = OSSemCreate(1);

	// Ser6
 	//Hu_Ser6Ser->CheckByte = pUSART6.CheckByte;
	//Hu_Ser6Ser->RxGetByte = pUSART6.RxGetByte;
	//Hu_Ser6Ser->PutStr = pUSART6.PutStr;
	//Hu_Ser6Ser->TxCheckByte = pUSART6.TxCheckByte;
	//Hu_Ser6Ser->BuffClear = pUSART6.BuffClear;

	Hu_Ser6Ser->TimerRx = TimerCcnRx;

	Hu_Ser6Ser->Recv = &Rhu;
	Hu_Ser6Ser->Send = &Shu;

	Hu_Ser6Ser->OSSem = OSSemCreate(1);
		
	OSTaskCreate(Ser2Task, (void *)Hu_Ser2Ser, (OS_STK *)&Ser2TaskStk[SER2_STK_SIZE - 1], CCN_PRIO);
}

void Ser2Task(void *pdata)
{
	SubIDStr	HuID;
		
	__ProtocolPtr *nPtr = (__ProtocolPtr *)pdata;

	OSTimeDly(100*CCN_PRIO);

	while(1)
	{
		while(!DownLoadGiveupTimerSet(NULL) && (!tTestFlag))
		{
			if(DistFlag == _OFF)
			{
				GetHuCommand();

				HuID.MuID = MyID.MuID;
				HuID.HuID = HuPollID[HuPollCnt];
				HuID.RuID = 0xFF;
				if((HuID.HuID==0)||(HuID.HuID==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((HuID.HuID==2)||(HuID.HuID==3))	nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((HuID.HuID==4)||(HuID.HuID==5))	nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((HuID.HuID==6)||(HuID.HuID==7))	nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				MuxControl(HuID.HuID);
				SysInfoCopy(MU_PATH, MyID);
				SioDataAckTx(MyID, HuID, (INT8U*)MuStatus, sizeof(__MU_STS), StatusRQST, nPtr);
				
				if(LinkFailCnt[HuID.HuID]++ > 5)
				{
					LinkFailCnt[HuID.HuID] = 10;
					SysInfo->Hu_Install[HuID.HuID] = SYS_LINK_FAIL;
				}
				
				if(ProtocolCheck(nPtr, (Time1Sec*2L)))
				{
					HuProtocolComCheck(nPtr, 0);
					
					LinkFailCnt[HuID.HuID] = 0;
					//SysInfo->Hu_Install[HuID.HuID] = SYS_NORMAL;
				}

				EndHuCommand();

				HuPollCnt++;
				if(HuPollCnt==HU_MAX)			HuPollCnt = 0;
				if(HuPollID[HuPollCnt]==0xFF)	HuPollCnt = 0;
				
				OSTimeDly(500L);
			}
			else
			{
				if(DistType == MEA_TYPE)		Mea_DistCheckFunc();
				else if(DistType == TAR_TYPE)	Tar_DistCheckFunc();
				else if((DistType == BR_TYPE)||(DistType == ALL_TYPE))	Total_DistCheckFunc();	

				OSTimeDly(100L);
			}
		}
		OSTimeDly(1000L);
	}
}


void HuProtocolComCheck (__ProtocolPtr *nPtr, __N_ProtocolPtr *NmsPtr)
{
#if 0
	INT8U	PathChk = 0;
	
	SIO *Recv = nPtr->Recv;

	PathChk = ID_Check(Recv->DstID);
//	pUSART1.printf("\n Rev Path %d", PathChk); 
	if(PathChk == MY_PATH)
	{
		switch(Recv->Command) //command 체크
		{
			//-----------------------------------------------------------------------//
			case StatusRSPS:
//				pUSART1.printf("\n Rev RU[%d][%d]", BrID, (Recv->SrcID.HuID&0x0F)); 
				if(Recv->SubDataLength == sizeof(__HU_STS))
				{
					RecvHuDataUpdate((__HU_STS*)Recv->Data, Recv->SrcID);
				}
				else if(Recv->SubDataLength == sizeof(__RU_STS))
				{
					RecvRuDataUpdate((__RU_STS*)Recv->Data, Recv->SrcID);
				}
			break;

			case ControlRSPS:
				if(Recv->SubDataLength == sizeof(__HU_STS))
				{
					RecvHuDataUpdate((__HU_STS*)Recv->Data, Recv->SrcID);
				}
				else if(Recv->SubDataLength == sizeof(__RU_STS))
				{
					RecvRuDataUpdate((__RU_STS*)Recv->Data, Recv->SrcID);
				}
				
				if(NmsPtr == Eth0)
				{
					if(Recv->SubDataLength == sizeof(__HU_STS))
					{
						NmsDataCopy(HU_PATH, Recv->SrcID);
						NmsDataAckTx((INT8U*)N_HuStatus, sizeof(__N_HU_STS), N_Control_CMD, NmsPtr);
					}
					else if(Recv->SubDataLength == sizeof(__RU_STS))
					{
						NmsDataCopy(RU_PATH, Recv->SrcID);
						NmsDataAckTx((INT8U*)N_RuStatus, sizeof(__N_RU_STS), N_Control_CMD, NmsPtr);
					}
				}
				else
				{
					if(DistFlag == _OFF)	BypassFunction(PcSer, nPtr);
				}
				break;

			case ResetRSPS:
				if(NmsPtr == Eth0)
				{
					if(Recv->SrcID.RuID == 0xFF)
					{
						NmsDataCopy(HU_PATH, Recv->SrcID);
						N_HuStatus->ResetReason = UserReset;
						NmsDataAckTx((INT8U*)N_HuStatus, sizeof(__N_HU_STS), N_Control_CMD, NmsPtr);
					}
					else
					{
						NmsDataCopy(RU_PATH, Recv->SrcID);
						N_RuStatus->ResetReason = UserReset;
						NmsDataAckTx((INT8U*)N_RuStatus, sizeof(__N_RU_STS), N_Control_CMD, NmsPtr);
					}
				}
				else
				{
					BypassFunction(PcSer, nPtr);
				}
			break;
				
			case TableStsRSPS:
			case TableSetRSPS:
			case DownloadRSPS:
			case DownDataRSPS:
			case DownConfirmRSPS:
				BypassFunction(PcSer, nPtr);
			break;

			//-----------------------------------------------------------------------//
			case N_DownloadCMD:
			case N_DownloadCMDConfirm:
			case N_DownLoadData:
			case N_DownLoadDataConfirm:
				NmsDataAckTx((INT8U*)Recv->Data, Recv->SubDataLength, Recv->Command, NmsPtr);
			break;

			//-----------------------------------------------------------------------//
			case ControlRQST:
				if(Recv->SubDataLength != sizeof(__MU_CTRL)) break;

				SetDnrCtrlData((__MU_CTRL*)Recv->Data);

				SysInfoCopy(MU_PATH, Recv->DstID);
				SioDataAckTx(Recv->DstID, Recv->SrcID, (INT8U*)MuStatus, sizeof(__MU_STS), ControlRSPS, nPtr);
			break;
		}
	}
	else if(PathChk == GUI_PATH)
	{
		switch(Recv->Command)
		{
			//-----------------------------------------------------------------------//
			case ControlRSPS:
				if(Recv->SubDataLength == sizeof(__HU_STS))
				{
					RecvHuDataUpdate((__HU_STS*)Recv->Data, Recv->SrcID);
				}
				else if(Recv->SubDataLength == sizeof(__RU_STS))
				{
					RecvRuDataUpdate((__RU_STS*)Recv->Data, Recv->SrcID);
				}
			case TableStsRSPS:
			case TableSetRSPS:
			case ResetRSPS:
			case DownloadRSPS:
			case DownDataRSPS:
				// PC
				BypassFunction(PcSer, nPtr);
			break;

			case DownConfirmRSPS:
				// PC
				BypassFunction(PcSer, nPtr);

				OSTimeDly(1000L);
				DownLoadGiveupTimerRst();
			break;
		}
	}
#endif
}

void GetHuCommand(void)
{
	while( !Hu_Idle )	OSTimeDly(100);
	Hu_Idle = 0;
}

void EndHuCommand(void)
{
	Hu_Idle = 1;
}

//=======================================================================//
void MuxControl(INT8U BrID)
{
	switch(BrID)
	{
		//-----------------------------------------------------------------------//
		case 0:
			DCC_SEL01_CS = _LOW;
			break;
		case 1:
			DCC_SEL01_CS = _HIGH;
			break;
			
		//-----------------------------------------------------------------------//
		case 2:
			DCC_SEL23_CS = _LOW;
			break;
		case 3:
			DCC_SEL23_CS = _HIGH;
			break;

		//-----------------------------------------------------------------------//
		case 4:
			DCC_SEL45_CS = _LOW;
			break;
		case 5:
			DCC_SEL45_CS = _HIGH;
			break;

		//-----------------------------------------------------------------------//
		case 6:
			DCC_SEL67_CS = _LOW;
			break;
		case 7:
			DCC_SEL67_CS = _HIGH;
			break;
		
	}
	OSTimeDly(100L);
}

void RecvHuDataUpdate(__HU_STS *ptr, SubIDStr sID)
{
	INT16U	i, j;
	INT8U	AlmCnt = 0;

	//---------------------------------------------------------------------//
	// Ru install Update
	for(i=0; i<HDTU_MAX; i++)
	{
		for(j=0; j<HU_RU_MAX; j++)
			SysInfo->Hu_Ru[sID.HuID].Ru_Install[i][j] = ptr->SystemIns.Hu_Ru[sID.HuID].Ru_Install[i][j];
	}

	//---------------------------------------------------------------------//
	// Hu Status Update
	for(i=0; i<sizeof(__HU_STS); i++)
	{
		*((INT8U*)HuStatus[sID.HuID]+i) = *((INT8U*)ptr+i);
	}

	//---------------------------------------------------------------------//
	// ALARM LED
	if(HuStatus[sID.HuID]->HuAlm.Data[0] != _Normal)					AlmCnt++;
//	if(HuStatus[sID.HuID]->HuAlm.Data[1] != _Normal)					AlmCnt++;
	for(i=0; i<HDTU_MAX; i++)
		if(HuStatus[sID.HuID]->HdtuSts[i].Alarm.Data != _Normal)			AlmCnt++;
	
	if(AlmCnt != 0)		SysInfo->Hu_Install[sID.HuID] = SYS_ALARM;
	else				SysInfo->Hu_Install[sID.HuID] = SYS_NORMAL;

	// Reset Check
	//if(HuStatus[sID.HuID]->HuAlm.Reset_Alarm == _Alarm)
	//	HuBootFlag[sID.HuID] = HuStatus[sID.HuID]->ResetReason;
}

void RecvRuDataUpdate(__RU_STS *ptr, SubIDStr sID)
{
	INT16U	i, j;
	INT8U	BrID, RuID = 0;

	BrID = (sID.RuID>>4)&0x0F;
	RuID = 0;
	//RuID = sID.RuID&0x0F;
	if(RuID > 0)	RuID = 0;
	
	//---------------------------------------------------------------------//
	// Ru Status Update
	for(i=0, j=sizeof(InstallStr); i<sizeof(__RU_BUF_STS); i++, j++)
	{
		*((INT8U*)RuBuf[sID.HuID][BrID][RuID]+i) = *((INT8U*)ptr+j);
	}

	// Reset Check
	if(RuBuf[sID.HuID][BrID][RuID]->RuAlm.Reset_Alarm == _Alarm)
	{
//		RuBootFlag[sID.HuID][BrID] = RuBuf[sID.HuID][BrID][RuID]->ResetReason;
//		SerPtr->printf("\nRu Reset[%x][%x][%x], Reason=%d ", sID.MuID, sID.HuID, sID.RuID, RuBuf[sID.HuID][BrID][RuID]->ResetReason);
	}
}

BOOL InstallCheck(SubIDStr sID, INT8U Path)
{
	BOOL	rVal = FALSE;
	INT8U	BrID, RuID;

	BrID = ((sID.RuID>>4)&0x0F);
	RuID = (sID.RuID&0x0F);

	if(Path == HU_PATH)
	{
		if(SysInfo->Hu_Install[sID.HuID] != SYS_NOT_INST)	rVal = TRUE;
		else												rVal = FALSE;
	}
	else if(Path == RU_PATH)
	{
		if(sID.HuID == 0xFF)
		{
			if(SysInfo->Mu_Ru_Install[BrID][RuID] != SYS_NOT_INST)	rVal = TRUE;
			else													rVal = FALSE;
		}
		else
		{
			if(SysInfo->Hu_Ru[sID.HuID].Ru_Install[BrID][RuID] != SYS_NOT_INST)	rVal = TRUE;
			else																rVal = FALSE;
		}
	}

	return	rVal;
}

//=======================================================================//
void Mea_DistCheckFunc(void)
{
	INT8U	Dist_MuBr = 0;
	INT8U	Dist_HuBr = 0;
	INT8U	Dist_Ru = 0;
	INT8U	Path;

	__ProtocolPtr *nPtr;
	
	Dist_MuBr = DistTarID.HuID;
	Path = ID_Check(DistTarID);
	Dist_HuBr = (DistTarID.RuID>>4)&0x0F;
	Dist_Ru = DistTarID.RuID&0x0F;
	if(Dist_Ru>0)	Dist_Ru = 0;
	
	switch(DistStep)
	{
		//-----------------------------------------------------------------------//
		// ID, Intstall, Link Fail Check
		case 0:
			DistCnt = 0;
			
			if(Path == HU_PATH)
			{
				if((SysInfo->Hu_Install[Dist_MuBr] == SYS_ALARM)
					||(SysInfo->Hu_Install[Dist_MuBr] == SYS_NORMAL))
						DistStep = 1;
				else	DistStep = 10;	// Not Insrt or Link Fail
			}
			else if(Path == RU_PATH)
			{
				if((SysInfo->Hu_Ru[Dist_MuBr].Ru_Install[Dist_HuBr][Dist_Ru] == SYS_ALARM)
					||(SysInfo->Hu_Ru[Dist_MuBr].Ru_Install[Dist_HuBr][Dist_Ru] == SYS_NORMAL))
						DistStep = 1;
				else	DistStep = 10;	// Not Insrt or Link Fail
			}
			else		DistStep = 10;
			break;

		//-----------------------------------------------------------------------//
		// HU/RU Loop Back & Check
		case 1:
			GetHuCommand();
			
			if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
			else if((Dist_MuBr==2)||(Dist_MuBr==3))	nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
			else if((Dist_MuBr==4)||(Dist_MuBr==5))	nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
			else if((Dist_MuBr==6)||(Dist_MuBr==7))	nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

			LoopBackCtrlFunc(Path, DistTarID, nPtr, _ON);

			if(ProtocolCheck(nPtr, (Time1Sec*2L)))
			{
				HuProtocolComCheck(nPtr, 0);

				if(Path == HU_PATH)
				{
					if(HuStatus[Dist_MuBr]->LoopBack == _ON)
					{
						DistCnt = 0;
						DistStep = 2;
					}
					else	DistCnt++;
				}
				else
				{
					if(RuBuf[Dist_MuBr][Dist_HuBr][Dist_Ru]->LoopBack == _ON)
					{
						DistCnt = 0;
						DistStep = 2;
					}
					else	DistCnt++;
				}
			}
			else	DistCnt++;

			EndHuCommand();
			
			if(DistCnt>=3)
			{
				DistCnt = 0;
				DistStep = 10;
			}
			break;

		//-----------------------------------------------------------------------//
		// DTU Control : On
		case 2:
			DtuLoopBackControl(_ON, Dist_MuBr);

			if((DtuStatus->MeaLoop == _ON)&&(DtuStatus->MeaBranch == Dist_MuBr))
			{
				DistStep = 3;
				DistCnt = 0;

				OSTimeDly(100L);
			}
			else	DistCnt++;

			if(DistCnt>=3)
			{
				DistCnt = 0;
				DistStep = 10;
			}
			break;

		//-----------------------------------------------------------------------//
		// DTU Status Check
		case 3:
			GetDtuCommand();
			SioDataAckTx(MyID, DtuID, (INT8U*)NULL, 0, StatusRQST, DtuSer);
			if(ProtocolCheck(DtuSer, (Time1Sec*2L)))
			{
				DtuProtocolComCheck(DtuSer);

				if(DtuStatus->MeaResult != 0)
				{
					if(DistTarID.RuID == 0xFF)
					{
						if(DtuStatus->MeaResult < DLY_EU_MIN)	DtuStatus->MeaResult = DLY_EU_MIN;
						MuStatus->MeaResult	= DtuStatus->MeaResult;
					}
					else
					{
						if(DtuStatus->MeaResult < DLY_RU_MIN)	DtuStatus->MeaResult = DLY_RU_MIN;
						MuStatus->MeaResult	= DtuStatus->MeaResult + RuBuf[Dist_MuBr][Dist_HuBr][Dist_Ru]->DL_Delay_21G;
					}
					DistStep = 4;
				}
				else	DistCnt++;
			}
			else	DistCnt++;
			EndDtuCommand();
			OSTimeDly(100L);
			
			if(DistCnt>=5)	DistStep = 10;
			break;

		//-----------------------------------------------------------------------//
		// Success
		case 4:
			DistCnt = 0;
			MuStatus->MeaSts = 0;
			
			DistStep = 20;
			break;

		//-----------------------------------------------------------------------//
		// Fail...
		case 10:
			MuStatus->MeaResult = 0;

			DistCnt = 0;
			MuStatus->MeaSts = 0;
			
			DistStep = 20;
			break;

		//=======================================================================//
		// Loopback Control : OFF
		case 20:
			GetHuCommand();
			
			if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
			else if((Dist_MuBr==2)||(Dist_MuBr==3))	nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
			else if((Dist_MuBr==4)||(Dist_MuBr==5))	nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
			else if((Dist_MuBr==6)||(Dist_MuBr==7))	nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

			LoopBackCtrlFunc(Path, DistTarID, nPtr, _OFF);

			if(ProtocolCheck(nPtr, (Time1Sec*2L)))
			{
				HuProtocolComCheck(nPtr, 0);

				if(Path == HU_PATH)
				{
					if(HuStatus[Dist_MuBr]->LoopBack == _OFF)
					{
						DistCnt = 0;
						DistStep = 21;
					}
					else	DistCnt++;
				}
				else
				{
					if(RuBuf[Dist_MuBr][Dist_HuBr][Dist_Ru]->LoopBack == _OFF)
					{
						DistCnt = 0;
						DistStep = 21;
					}
					else	DistCnt++;
				}
			}
			else	DistCnt++;

			EndHuCommand();
			
			if(DistCnt>=3)
			{
				DistCnt = 0;
				DistStep = 21;
			}

			DistStep = 21;
#ifdef DIST_DEG
		SerPtr->printf("\n Step20 -> goto %d\n", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// DTU Control : OFF
		case 21:
			DtuLoopBackControl(_OFF, 0);
			
			DistStep = 0;
			DistFlag = _OFF;
			break;
	}
}

void Tar_DistCheckFunc(void)
{
	INT8U	Dist_MuBr = 0;
	INT8U	Dist_HuBr = 0;
	INT8U	Dist_Ru = 0;
	INT8U	Path;
	
	__ProtocolPtr *nPtr;
	
	Dist_MuBr = DistTarID.HuID;
	Path = ID_Check(DistTarID);
	Dist_HuBr = (DistTarID.RuID>>4)&0x0F;
	Dist_Ru = DistTarID.RuID&0x0F;
	if(Dist_Ru>0)	Dist_Ru = 0;
	
	switch(DistStep)
	{
		//=======================================================================//
		// Delay Measure
		//=======================================================================//
		
		// ID, Intstall, Link Fail Check
		case 0:
			DistCnt = 0;
			
			if(Path == HU_PATH)
			{
				if((SysInfo->Hu_Install[Dist_MuBr] == SYS_ALARM)
					||(SysInfo->Hu_Install[Dist_MuBr] == SYS_NORMAL))
						DistStep = 1;
				else	DistStep = 10;	// Not Insrt or Link Fail

				DelaySts->DelayVal[Dist_MuBr].Hu_Delay = 0xFFFF;
#ifdef DIST_DEG
	SerPtr->printf("\n HU Step0 -> goto %d\n", DistStep);
#endif
			}
			else if(Path == RU_PATH)
			{
				if((SysInfo->Hu_Ru[Dist_MuBr].Ru_Install[Dist_HuBr][Dist_Ru] == SYS_ALARM)
					||(SysInfo->Hu_Ru[Dist_MuBr].Ru_Install[Dist_HuBr][Dist_Ru] == SYS_NORMAL))
						DistStep = 1;
				else	DistStep = 10;	// Not Insrt or Link Fail

				DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr] = 0xFFFF;
				DelayAlarmCheck(Dist_MuBr, Dist_HuBr, _Normal);
#ifdef DIST_DEG
	SerPtr->printf("\n HU Step0 -> goto %d\n", DistStep);
#endif
			}
			else		DistStep = 10;
			break;

		//-----------------------------------------------------------------------//
		// HU/RU Loop Back & Check
		case 1:
			GetHuCommand();
			
			if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
			else if((Dist_MuBr==2)||(Dist_MuBr==3))	nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
			else if((Dist_MuBr==4)||(Dist_MuBr==5))	nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
			else if((Dist_MuBr==6)||(Dist_MuBr==7))	nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

			LoopBackCtrlFunc(Path, DistTarID, nPtr, _ON);

			if(ProtocolCheck(nPtr, (Time1Sec*2L)))
			{
				HuProtocolComCheck(nPtr, 0);

				if(Path == HU_PATH)
				{
					if(HuStatus[Dist_MuBr]->LoopBack == _ON)
					{
						DistCnt = 0;
						DistStep = 2;
					}
					else	DistCnt++;
				}
				else
				{
					if(RuBuf[Dist_MuBr][Dist_HuBr][Dist_Ru]->LoopBack == _ON)
					{
						DistCnt = 0;
						DistStep = 2;
					}
					else	DistCnt++;
				}
			}
			else	DistCnt++;

			EndHuCommand();
			
			if(DistCnt>=3)
			{
				DistCnt = 0;
				DistStep = 10;
			}
#ifdef DIST_DEG
	SerPtr->printf("\n Step1 -> goto %d\n", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// DTU Control : On
		case 2:
			DtuLoopBackControl(_ON, Dist_MuBr);

			if((DtuStatus->MeaLoop == _ON)&&(DtuStatus->MeaBranch == Dist_MuBr))
			{
				DistStep = 3;
				DistCnt = 0;
				OSTimeDly(100L);
			}
			else	DistCnt++;

			if(DistCnt>=3)
			{
				DistCnt = 0;
				DistStep = 10;
			}
#ifdef DIST_DEG
	SerPtr->printf("\n Step2 -> goto %d\n", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// DTU Status Check
		case 3:
			GetDtuCommand();
			
			SioDataAckTx(MyID, DtuID, (INT8U*)NULL, 0, StatusRQST, DtuSer);
						
			if(ProtocolCheck(DtuSer, (Time1Sec*2L)))
			{
				DtuProtocolComCheck(DtuSer);

				if(DtuStatus->MeaResult != 0)
				{
					if(DistTarID.RuID == 0xFF)
					{
						if(DtuStatus->MeaResult < DLY_EU_MIN)	DtuStatus->MeaResult = DLY_EU_MIN;
						DelaySts->DelayVal[Dist_MuBr].Hu_Delay = DtuStatus->MeaResult;
					}
					else
					{
						if(DtuStatus->MeaResult < DLY_RU_MIN)	DtuStatus->MeaResult = DLY_RU_MIN;
						DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr] = DtuStatus->MeaResult;
					}
					DistStep = 4;
				}
				else	DistCnt++;
			}
			else	DistCnt++;
			EndDtuCommand();

			OSTimeDly(100L);
			if(DistCnt>=7)	DistStep = 10;
#ifdef DIST_DEG
		SerPtr->printf("\n Step3 -> goto %d\n", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// Success
		case 4:
			DistCnt = 0;
			MuStatus->MeaSts = 0;
			
			DistStep = 5;
			DistCnt = 0;
#ifdef DIST_DEG
		SerPtr->printf("\n Step4 -> goto %d\n", DistStep);
#endif
			break;

		//=======================================================================//
		// Delay Control
		//=======================================================================//
		case 5:
			if(DistTarID.RuID == 0xFF)
			{
				GetHuCommand();
				
				if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Dist_MuBr==2)||(Dist_MuBr==3)) nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Dist_MuBr==4)||(Dist_MuBr==5)) nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Dist_MuBr==6)||(Dist_MuBr==7)) nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				LoopBackCtrlFunc(Path, DistTarID, nPtr, _OFF);

				if(ProtocolCheck(nPtr, (Time1Sec*2L)))
				{
					HuProtocolComCheck(nPtr, 0);

					if(nPtr->Recv->Command == ControlRSPS)	DistStep = 20;
					else									DistCnt++;
				}
				else	DistCnt++;
				EndHuCommand();
			}
			else
			{
				GetHuCommand();
				
				if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Dist_MuBr==2)||(Dist_MuBr==3))	nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Dist_MuBr==4)||(Dist_MuBr==5))	nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Dist_MuBr==6)||(Dist_MuBr==7))	nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				DelayCtrlFunc(Path, DistTarID, nPtr);

				if(ProtocolCheck(nPtr, (Time1Sec*2L)))
				{
					HuProtocolComCheck(nPtr, 0);

					if(nPtr->Recv->Command == ControlRSPS)	DistStep = 20;
					else									DistCnt++;
				}
				else	DistCnt++;

				EndHuCommand();
			}

			if(DistCnt>=3)
			{
				DelayAlarmCheck(Dist_MuBr, Dist_HuBr, _Alarm);
				DistStep = 20;
			}
#ifdef DIST_DEG
		SerPtr->printf("\n Step5 -> goto %d\n", DistStep);
#endif
			break;

		//=======================================================================//
		// Fail...
		case 10:
			DistCnt = 0;
			MuStatus->MeaSts = 0;
			if(Path == HU_PATH)			DelaySts->DelayVal[Dist_MuBr].Hu_Delay = 0xFFFF;
			else if(Path == RU_PATH)	DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr] = 0xFFFF;
			
			DistStep = 20;
#ifdef DIST_DEG
		SerPtr->printf("\n Step10 -> goto %d\n", DistStep);
#endif
			break;

		//=======================================================================//
		// Loopback Control : OFF
		case 20:
			GetHuCommand();
			
			if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
			else if((Dist_MuBr==2)||(Dist_MuBr==3))	nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
			else if((Dist_MuBr==4)||(Dist_MuBr==5))	nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
			else if((Dist_MuBr==6)||(Dist_MuBr==7))	nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

			LoopBackCtrlFunc(Path, DistTarID, nPtr, _OFF);

			if(ProtocolCheck(nPtr, (Time1Sec*2L)))
			{
				HuProtocolComCheck(nPtr, 0);

				if(Path == HU_PATH)
				{
					if(HuStatus[Dist_MuBr]->LoopBack == _OFF)
					{
						DistCnt = 0;
						DistStep = 21;
					}
					else	DistCnt++;
				}
				else
				{
					if(RuBuf[Dist_MuBr][Dist_HuBr][Dist_Ru]->LoopBack == _OFF)
					{
						DistCnt = 0;
						DistStep = 21;
					}
					else	DistCnt++;
				}
			}
			else	DistCnt++;

			EndHuCommand();
			
			if(DistCnt>=3)
			{
				DistCnt = 0;
				DistStep = 21;
			}

			DistStep = 21;
#ifdef DIST_DEG
		SerPtr->printf("\n Step20 -> goto %d\n", DistStep);
#endif
			break;

		//=======================================================================//
		// DTU Control : OFF
		case 21:
			DtuLoopBackControl(_OFF, 0);

			DistStep = 30;
#ifdef DIST_DEG
		SerPtr->printf("\n Step21 -> goto %d\n", DistStep);
#endif
			break;

		//=======================================================================//
		// Result Send
		case 30:
			SioDataAckTx(MyID, GuiID, (INT8U*)DelaySts, sizeof(_STS_DELAY), DelayMea1EaRSPS, PcSer);
			DistStep = 0;
			DistFlag = _OFF;
#ifdef DIST_DEG
	SerPtr->printf("\n Step30 -> Reponse Send\n");
#endif
			break;
	}
}

void Total_DistCheckFunc(void)
{
	INT16U	i, j;
	INT8U	Dist_MuBr = 0;
	INT8U	Dist_HuBr = 0;
	INT8U	Dist_Ru = 0;
	INT8U	Path;
	
	__ProtocolPtr *nPtr;

	if(DistStep == 0)
	{
		if(DistType == ALL_TYPE)	DistTarID.HuID = MDTU_MAX-1;
		DistTarID.RuID = 0xF0;
	}
	Dist_MuBr = DistTarID.HuID;
	Dist_HuBr = (DistTarID.RuID>>4)&0x0F;
	Dist_Ru = 0;
	
	switch(DistStep)
	{
		//=======================================================================//
		// Delay Measure
		//=======================================================================//
		
		// Value/Alarm Clear
		case 0:
			DistCnt = 0;
			if(DistType == BR_TYPE)
			{
				DelaySts->DelayVal[Dist_MuBr].Hu_Delay = 0xFFFF;
				for(i=0; i<HDTU_MAX; i++)
				{
					DelaySts->DelayVal[Dist_MuBr].Ru_Delay[i] = 0xFFFF;
					DelayAlarmCheck(Dist_MuBr, i, _Normal);
				}
			}
			else
			{
				for(i=0; i<MDTU_MAX; i++)
				{
					DelaySts->DelayVal[i].Hu_Delay = 0xFFFF;
					for(j=0; j<HDTU_MAX; j++)
					{
						DelaySts->DelayVal[i].Ru_Delay[j] = 0xFFFF;
						DelayAlarmCheck(i, j, _Normal);
					}
				}
			}
			DistStep = 1;	// HU Insert/Link Fail Check
#ifdef DIST_DEG
		SerPtr->printf("\n Step0 -> Dist Start[%x] -> goto %d",DistType, DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// HU Insert/Link Fail Check
		case 1:
			if((SysInfo->Hu_Install[Dist_MuBr] == SYS_ALARM)||(SysInfo->Hu_Install[Dist_MuBr] == SYS_NORMAL))
			{
				if(DistTarID.RuID == 0xFF)	DistStep = 3;		// DTU Control : LoopBack On
				else						DistStep = 2;		// Ru Insert/Link Fail Check
			}
			else
			{
				if(DistType == BR_TYPE)	DistStep = 20;
				else
				{
					if(Dist_MuBr == 0)	DistStep = 20;
					else
					{
						DistTarID.HuID--;
						DistTarID.RuID = 0xF0;
					}
				}
			}

#ifdef DIST_DEG
		SerPtr->printf("\n Step1[00][%2x][%2x] -> goto %d", DistTarID.HuID, DistTarID.RuID, DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// Ru Insert/Link Fail Check
		case 2:
			if((SysInfo->Hu_Ru[Dist_MuBr].Ru_Install[Dist_HuBr][Dist_Ru] == SYS_ALARM)
				||(SysInfo->Hu_Ru[Dist_MuBr].Ru_Install[Dist_HuBr][Dist_Ru] == SYS_NORMAL))
			{
				DistStep = 3;					// DTU Control : LoopBack On
			}
			else
			{
				if(Dist_HuBr == 0)	// Br#1
				{
					DistTarID.RuID = 0xFF;		// HU 측정...
					DistStep = 3;				// DTU Control : LoopBack On
				}
				else
				{
					Dist_HuBr--;
					DistTarID.RuID = (Dist_HuBr<<4)&0xF0;
				}
			}
			DistCnt = 0;
			
#ifdef DIST_DEG
		SerPtr->printf("\n Step2[00][%2x][%2x] -> goto %d", DistTarID.HuID, DistTarID.RuID, DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// DTU Control : LoopBack On
		case 3:
			DtuLoopBackControl(_ON, Dist_MuBr);

			if((DtuStatus->MeaLoop == _ON)&&(DtuStatus->MeaBranch==Dist_MuBr))
			{
				DistOnBr = Dist_MuBr;
				DistStep = 4;				// HU/RU Loop Back & Check
				DistCnt = 0;
			}
			else
			{
				if(DistCnt++>=5)
				{
					DistStep = 30;			// On Control Fail...
				}
			}
#ifdef DIST_DEG
	SerPtr->printf("\n Step3 -> goto %d", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// HU/RU Loop Back & Check
		case 4:
			Path = ID_Check(DistTarID);
			
			GetHuCommand();
			
			if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
			else if((Dist_MuBr==2)||(Dist_MuBr==3))	nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
			else if((Dist_MuBr==4)||(Dist_MuBr==5))	nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
			else if((Dist_MuBr==6)||(Dist_MuBr==7))	nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

			LoopBackCtrlFunc(Path, DistTarID, nPtr, _ON);

			if(ProtocolCheck(nPtr, (Time1Sec*2L)))
			{
				HuProtocolComCheck(nPtr, 0);

				if(Path == HU_PATH)
				{
					if(HuStatus[Dist_MuBr]->LoopBack == _ON)
					{
						DistStep = 5;	// Delay Read
						DistCnt = 0;

						OSTimeDly(500L);
					}
					else	DistCnt++;
				}
				else
				{
					if(RuBuf[Dist_MuBr][Dist_HuBr][Dist_Ru]->LoopBack == _ON)
					{
						DistStep = 5;	// Delay Read
						DistCnt = 0;

						OSTimeDly(500L);
					}
					else	DistCnt++;
				}
			}
			else	DistCnt++;
			EndHuCommand();
			
			if(DistCnt>=10)	DistStep = 11;		// Check Next ID
			
#ifdef DIST_DEG
	SerPtr->printf("\n Step4 -> goto %d", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// Delay Read
		case 5:
			GetDtuCommand();
			
			SioDataAckTx(MyID, DtuID, (INT8U*)NULL, 0, StatusRQST, DtuSer);
						
			if(ProtocolCheck(DtuSer, (Time1Sec*2L)))
			{
				DtuProtocolComCheck(DtuSer);

				if(BitRead(DtuStatus->MeaSts, Dist_MuBr))
				{
					if(DistTarID.RuID == 0xFF)
					{
						if(DtuStatus->MeaResult < DLY_EU_MIN)	DtuStatus->MeaResult = DLY_EU_MIN;
						DelaySts->DelayVal[Dist_MuBr].Hu_Delay = DtuStatus->MeaResult;
						WriteEEprom(At24cDevID, Hu_DelayVal_Bp+(2*Dist_MuBr), (INT8U)((DtuStatus->MeaResult>>8)&0xFF), IN_EEP);
						WriteEEprom(At24cDevID, Hu_DelayVal_Bp+(2*Dist_MuBr)+1, (INT8U)(DtuStatus->MeaResult&0xFF), IN_EEP);
					}
					else
					{
						if(DtuStatus->MeaResult < DLY_RU_MIN)	DtuStatus->MeaResult = DLY_RU_MIN;
						DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr] = DtuStatus->MeaResult;
						WriteEEprom(At24cDevID, Ru_DelayVal_Bp+(32*Dist_MuBr)+(2*Dist_HuBr), (INT8U)((DtuStatus->MeaResult>>8)&0xFF), IN_EEP);
						WriteEEprom(At24cDevID, Ru_DelayVal_Bp+(32*Dist_MuBr)+(2*Dist_HuBr)+1, (INT8U)(DtuStatus->MeaResult&0xFF), IN_EEP);
					}
					DistStep = 6;					// DTU LoopBack OFF;
				}
			}
			EndDtuCommand();
			
			if(DistCnt++>=10)	DistStep = 6;						// Change Next ID

//if(DistCnt < 10)	SerPtr->printf("\n Delay Read (Measure_Sts[%x]), ID[00][%2x][%2x] Delay = %d", DtuStatus->MeaSts, DistTarID.HuID, DistTarID.RuID, DtuStatus->MeaResult);
//else				SerPtr->printf("\n Delay Read Fail !! -> Measure_Sts[%x]", DtuStatus->MeaSts);

#ifdef DIST_DEG
		if(DistCnt < 10)	SerPtr->printf("\n Step5 Delay Read[00][%2x][%2x] = %d -> goto %d", DistTarID.HuID, DistTarID.RuID, DtuStatus->MeaResult, DistStep);
		else				SerPtr->printf("\n Step5 Delay Read Fail !! -> goto %d", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// DTU Control : LoopBack OFF
		case 6:
			DtuLoopBackControl(_OFF, Dist_MuBr);

			if(MuStatus->MeaLoop == 0)
			{
				DistOnBr = Dist_MuBr;
				DistStep = 10;				// RU Delay Control
				DistCnt = 0;
			}
			else
			{
				if(DistCnt++>=10)
				{
					DistStep = 30;			// Off Control Fail...
				}
			}
#ifdef DIST_DEG
	SerPtr->printf("\n Step6 -> goto %d", DistStep);
#endif
			break;

		
		//=======================================================================//
		// Delay Control
		//=======================================================================//
		case 10:
			if(DistTarID.RuID == 0xFF)
			{
				GetHuCommand();
				
				if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Dist_MuBr==2)||(Dist_MuBr==3)) nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Dist_MuBr==4)||(Dist_MuBr==5)) nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Dist_MuBr==6)||(Dist_MuBr==7)) nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				LoopBackCtrlFunc(Path, DistTarID, nPtr, _OFF);

				if(ProtocolCheck(nPtr, (Time1Sec*2L)))
				{
					HuProtocolComCheck(nPtr, 0);

					if(nPtr->Recv->Command == ControlRSPS)	DistStep = 11;
					else									DistCnt++;
				}
				else	DistCnt++;
				EndHuCommand();
			}
			else
			{
				GetHuCommand();
				
				if((Dist_MuBr==0)||(Dist_MuBr==1))		nPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Dist_MuBr==2)||(Dist_MuBr==3)) nPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Dist_MuBr==4)||(Dist_MuBr==5)) nPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Dist_MuBr==6)||(Dist_MuBr==7)) nPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				DelayCtrlFunc(Path, DistTarID, nPtr);

				if(ProtocolCheck(nPtr, (Time1Sec*2L)))
				{
					HuProtocolComCheck(nPtr, 0);

					if(nPtr->Recv->Command == ControlRSPS)	DistStep = 11;
					else									DistCnt++;
				}
				else	DistCnt++;
				EndHuCommand();
			}

			if(DistCnt>=4)
			{
				DelayAlarmCheck(Dist_MuBr, Dist_HuBr, _Alarm);
				DistStep = 11;
			}
			
#ifdef DIST_DEG
		SerPtr->printf("\n Step10 -> goto %d", DistStep);
#endif
			break;

		//-----------------------------------------------------------------------//
		// Change Next ID
		case 11:
			if(DistTarID.RuID == 0xFF)
			{
				if(DistType == BR_TYPE)			DistStep = 40;	// DTU Control : OFF
				else
				{
					if(DistTarID.HuID==0x00)	DistStep = 40;	// DTU Control : OFF
					else
					{
						DistTarID.HuID--;
						DistTarID.RuID = 0xF0;
						DistStep = 1;
					}
				}
			}
			else
			{
				if(DistTarID.RuID == 0x00)
				{
					if(DistType == BR_TYPE)
					{
						DistTarID.RuID = 0xFF;
						DistStep = 1;
					}
					else
					{
						if(DistTarID.HuID==0x00)
						{
							DistTarID.RuID = 0xFF;
							DistStep = 1;
						}
						else
						{
							DistTarID.HuID--;
							DistTarID.RuID = 0xF0;
							DistStep = 1;
						}
					}
				}
				else
				{
					DistTarID.RuID -= 0x10;
					DistStep = 2;
				}
			}
#ifdef DIST_DEG
		SerPtr->printf("\n Step11 -> goto %d", DistStep);
#endif
			break;
		
		//=======================================================================//
		// HU Install/Link Fail...
		case 20:
			DistCnt = 0;
			if(Path == HU_PATH)			DelaySts->DelayVal[Dist_MuBr].Hu_Delay = 0xFFFF;
			else if(Path == RU_PATH)	DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr] = 0xFFFF;
			
			DistStep = 50;
#ifdef DIST_DEG
		SerPtr->printf("\n Step20 -> goto %d", DistStep);
#endif
			break;

		//=======================================================================//
		// Response Fail...
		case 30:
			DistCnt = 0;
			if(Path == HU_PATH)			DelaySts->DelayVal[Dist_MuBr].Hu_Delay = 0xFFFF;
			else if(Path == RU_PATH)	DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr] = 0xFFFF;
			
			DistStep = 40;
#ifdef DIST_DEG
		SerPtr->printf("\n Step30 -> goto %d", DistStep);
#endif
			break;

		//=======================================================================//
		// DTU Control : OFF
		case 40:
			DtuLoopBackControl(_OFF, 0);

			DistStep = 50;
#ifdef DIST_DEG
		SerPtr->printf("\n Step40 -> goto %d\n", DistStep);
#endif
			break;

		//=======================================================================//
		// Result Send
		case 50:
			SioDataAckTx(MyID, GuiID, (INT8U*)DelaySts, sizeof(_STS_DELAY), DelayMea1EaRSPS, PcSer);
			DistStep = 0;
			DistFlag = _OFF;
#ifdef DIST_DEG
	SerPtr->printf("\n Step50 -> Reponse Send\n");
#endif
			break;
	}
}


//=======================================================================//
void LoopBackCtrlFunc(INT8U tPath, SubIDStr	tID,  __ProtocolPtr *nPtr, INT8U OnSts)
{
	INT8U	i = 0;
			
	MuxControl(tID.HuID);
	
	if(tPath == HU_PATH)
	{
		__HU_CTRL	CtrlB, *Ctrl = &CtrlB;

		for(i=0; i<sizeof(HuCtrlFlagSts); i++)	*((INT8U*)Ctrl+i) = 0;
			
		Ctrl->CtrlFlag.System.LoopBack = 1;
		Ctrl->LoopBack = OnSts;

		SioDataAckTx(MyID, tID, (INT8U*)Ctrl, sizeof(__HU_CTRL), ControlRQST, nPtr);
	}
	else
	{
		__RU_CTRL	CtrlB, *Ctrl = &CtrlB;

		for(i=0; i<sizeof(RuCtrlFlagSts); i++)	*((INT8U*)Ctrl+i) = 0;

		Ctrl->CtrlFlag.System.LoopBack = 1;
		Ctrl->LoopBack = OnSts;

		SioDataAckTx(MyID, tID, (INT8U*)Ctrl, sizeof(__RU_CTRL), ControlRQST, nPtr);
	}
}

void DelayCtrlFunc(INT8U tPath, SubIDStr	tID,  __ProtocolPtr *nPtr)
{
	INT16U	i = 0;
	INT8U	AlmCnt = 0;
	INT32S	iVal;

	INT8U	Dist_MuBr = 0;
	INT8U	Dist_HuBr = 0;
	
	Dist_MuBr = tID.HuID;
	Dist_HuBr = (tID.RuID>>4)&0x0F;

	//-----------------------------------------------------------------------//
	MuxControl(tID.HuID);
	
	__RU_CTRL	CtrlB, *Ctrl = &CtrlB;

	for(i=0; i<sizeof(RuCtrlFlagSts); i++)	*((INT8U*)Ctrl+i) = 0;

	//-----------------------------------------------------------------------//
	if(DistBand == BAND_ALL)
	{
		iVal = DelaySts->TimeAdv_21G*2 - DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr]/2 + 7;
		if(iVal > 102)
		{
			Ctrl->CtrlFlag.RdtuCommon.DL_Delay_21G = 1;
			Ctrl->CtrlFlag.RdtuCommon.UL_Delay_21G = 1;
			Ctrl->DL_Delay_21G = (INT16U)iVal-102;
			Ctrl->UL_Delay_21G = (INT16U)iVal-90;
		}
		else			AlmCnt++;
	
		iVal = DelaySts->TimeAdv_900M*2 - DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr]/2 + 7;
		if(iVal > 106)
		{
			Ctrl->CtrlFlag.RdtuCommon.DL_Delay_900M = 1;
			Ctrl->CtrlFlag.RdtuCommon.UL_Delay_900M = 1;
			Ctrl->DL_Delay_900M = (INT16U)iVal-106;
			Ctrl->UL_Delay_900M = (INT16U)iVal-91;
		}
		else			AlmCnt++;
	
		iVal = DelaySts->TimeAdv_25G*2 - DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr]/2 + 7;
		if(iVal > 95)
		{
			Ctrl->CtrlFlag.RdtuCommon.DL_Delay_25G = 1;
			Ctrl->CtrlFlag.RdtuCommon.UL_Delay_25G = 1;
			Ctrl->DL_Delay_25G = (INT16U)iVal-95;
			Ctrl->UL_Delay_25G = (INT16U)iVal-92;
		}
		else			AlmCnt++;
	}
	else
	{
		if(DistBand == BAND_21G)
		{
			iVal = DelaySts->TimeAdv_21G*2 - DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr]/2 + 7;
			if(iVal > 102)
			{
				Ctrl->CtrlFlag.RdtuCommon.DL_Delay_21G = 1;
				Ctrl->CtrlFlag.RdtuCommon.UL_Delay_21G = 1;
				Ctrl->DL_Delay_21G = (INT16U)iVal-102;
				Ctrl->UL_Delay_21G = (INT16U)iVal-90;
			}
			else			AlmCnt++;
		}
		if(DistBand == BAND_900M)
		{
			iVal = DelaySts->TimeAdv_900M*2 - DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr]/2 + 7;
			if(iVal > 106)
			{
				Ctrl->CtrlFlag.RdtuCommon.DL_Delay_900M = 1;
				Ctrl->CtrlFlag.RdtuCommon.UL_Delay_900M = 1;
				Ctrl->DL_Delay_900M = (INT16U)iVal-106;
				Ctrl->UL_Delay_900M = (INT16U)iVal-91;
			}
			else			AlmCnt++;
		}
		if(DistBand == BAND_25G)
		{
			iVal = DelaySts->TimeAdv_25G*2 - DelaySts->DelayVal[Dist_MuBr].Ru_Delay[Dist_HuBr]/2 + 7;
			if(iVal > 95)
			{
				Ctrl->CtrlFlag.RdtuCommon.DL_Delay_25G = 1;
				Ctrl->CtrlFlag.RdtuCommon.UL_Delay_25G = 1;
				Ctrl->DL_Delay_25G = (INT16U)iVal-95;
				Ctrl->UL_Delay_25G = (INT16U)iVal-92;
			}
			else			AlmCnt++;
		}
	}

	// LoopBack OFF...
	Ctrl->CtrlFlag.System.LoopBack = 1;
	Ctrl->LoopBack = _OFF;

	if(AlmCnt!=0)
	{
		DelayAlarmCheck(Dist_MuBr, Dist_HuBr, _Alarm);
	}

	SioDataAckTx(MyID, tID, (INT8U*)Ctrl, sizeof(__RU_CTRL), ControlRQST, nPtr);
}



void DtuLoopBackControl(INT8U CtrlVal, INT8U TarBr)
{
	INT8U	i;

	for(i=0; i<sizeof(__F_MU_CTRL); i++)	*((INT8U*)DtuControl+i) = 0;

	MuStatus->MeaLoop = CtrlVal;
			
	DtuControl->ControlFlag.MeaLoop = 1;
	DtuControl->ControlFlag.MeaBranch = 1;

	DtuControl->MeaLoop = CtrlVal;
	DtuControl->MeaBranch = TarBr;

	GetDtuCommand();
	
	SioDataAckTx(MyID, DtuID, (INT8U*)DtuControl, sizeof(__F_MU_CTRL), ControlRQST, DtuSer);
				
	if(ProtocolCheck(DtuSer, (Time1Sec*2L)))
	{
		DtuProtocolComCheck(DtuSer);
#ifdef DIST_DEG
		SerPtr->printf("\n Measure Status -> %x", DtuStatus->MeaSts);
#endif


	}
	EndDtuCommand();
}


//=======================================================================//
void DelayAlarmCheck(INT8U Mu_BrID, INT8U Hu_BrID, INT8U AlmSts)
{
	switch(Hu_BrID)
	{
		case 0:		DelaySts->DelayAlarm[Mu_BrID].Br1_RuAlarm = AlmSts;		break;
		case 1:		DelaySts->DelayAlarm[Mu_BrID].Br2_RuAlarm = AlmSts;		break;
		case 2:		DelaySts->DelayAlarm[Mu_BrID].Br3_RuAlarm = AlmSts;		break;
		case 3:		DelaySts->DelayAlarm[Mu_BrID].Br4_RuAlarm = AlmSts;		break;
		case 4:		DelaySts->DelayAlarm[Mu_BrID].Br5_RuAlarm = AlmSts;		break;
		case 5:		DelaySts->DelayAlarm[Mu_BrID].Br6_RuAlarm = AlmSts;		break;
		case 6:		DelaySts->DelayAlarm[Mu_BrID].Br7_RuAlarm = AlmSts;		break;
		case 7:		DelaySts->DelayAlarm[Mu_BrID].Br8_RuAlarm = AlmSts;		break;
		case 8:		DelaySts->DelayAlarm[Mu_BrID].Br9_RuAlarm = AlmSts;		break;
		case 9:		DelaySts->DelayAlarm[Mu_BrID].Br10_RuAlarm = AlmSts;	break;
		case 10:	DelaySts->DelayAlarm[Mu_BrID].Br11_RuAlarm = AlmSts;	break;
		case 11:	DelaySts->DelayAlarm[Mu_BrID].Br12_RuAlarm = AlmSts;	break;
		case 12:	DelaySts->DelayAlarm[Mu_BrID].Br13_RuAlarm = AlmSts;	break;
		case 13:	DelaySts->DelayAlarm[Mu_BrID].Br14_RuAlarm = AlmSts;	break;
		case 14:	DelaySts->DelayAlarm[Mu_BrID].Br15_RuAlarm = AlmSts;	break;
		case 15:	DelaySts->DelayAlarm[Mu_BrID].Br16_RuAlarm = AlmSts;	break;
	}
}

//=======================================================================//
// End of Source File
//=======================================================================//


