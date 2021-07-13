
/*********************************************
* File Name          : usart1_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define SER0INT_C

#include "../include/main.h"
#include "download.c"

void WRCS_SerInit(void)
{
 	PcSer->CheckByte = pUSART1.CheckByte;
	PcSer->RxGetByte = pUSART1.RxGetByte;
	PcSer->PutStr = pUSART1.PutStr;
	PcSer->TxCheckByte = pUSART1.TxCheckByte;

	PcSer->TimerRx = TimerSioRx;
	PcSer->WRCSRecv = &RPcsksio;
	PcSer->WRCSSend = &SPcsksio;
	
	CtrlSem = OSSemCreate(1);

	PcSer->OSSem = OSSemCreate(1);
	
 	OSTaskCreate(WRCSTask, (void *)PcSer, (OS_STK *)&Ser1TaskStk[SER1_STK_SIZE - 1], SER0TASK_PRIO);

	LoadBackupData();	// default setting!!
	Initialize();
	AlarmInitialize();
		

	SerPtr->printf(" TRIO-M VER:%d.%d.%d-->Type[%d]\n", (TRIO_M_SystemVer >> 4)& 0x0f, TRIO_M_SystemVer & 0x0f,TRIO_M_PROGRAMVER & 0x0f,iRepeaterType);
//	SerPtr->printf(" sizeof:[%d][%d][%d]:[%d][%d]\n", sizeof(EE_BACK1),sizeof(EE_TABLE),sizeof(EE_TABLE1),sizeof(__BackupStr),sizeof(SYS_BACK));


#if 0
	  SerPtr->printf("PwrAlarmCnt[%d][%d][%d][%d][%d]>[%d][%d][%d]\n",	PwrAlarmCnt.FwdAmpOnOff_2G, 
	  PwrAlarmCnt.FwdAmpOnOff_LTE, 
	  PwrAlarmCnt.FwdAmpOnOff_3G,
	  PwrAlarmCnt.FwdAmpOnOff_LTE_A1,
	  PwrAlarmCnt.FwdAmpOnOff_LTE_A2,
	  PwrAlarmCnt.FwdAmp1OnOff_LTE,
	  PwrAlarmCnt.FwdAmp1OnOff_LTE_A1,
 	 PwrAlarmCnt.FwdAmp1OnOff_LTE_A2
);
#endif	 


	ChkTableAlarm = SET;
}


void WRCSTask(void *pdata)
{
	__ProtocolPtr *nPtr = (__ProtocolPtr *)PcSer;

	pdata = pdata;

	while(1)
	{
		nPtr->WRCSRecv->cBody = 0;
	
		if(!tTestFlag)
		{
			if(ProtocolCheck(nPtr))
			{
			#if TWO_BODY >= 2
				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
				{
			#endif
 					ProtocolComCheck(nPtr);
			#if TWO_BODY >= 2
					nPtr->WRCSRecv->cBody++;
				}
			#endif
			}			
		}
		WRCS_DownLoadGiveupTimerChk(nPtr);
		OSTimeDly(100L);
	}
}

INT32U ProtocolCheck(__ProtocolPtr *nPtr)
{
	INT16U nInitCnt, nCnt;
	INT16U i = 0;
	INT16U Data;
	INT8U Temp;

	__WRCSSIO *Recv = nPtr->WRCSRecv;

	TimerRegist(nPtr->TimerRx, Time1Sec*2L);
	while(1)
	{
		if(TimeOverCheck(nPtr->TimerRx)) return FALSE;
	
		if(nPtr->CheckByte(4, &nCnt))
		{
			Temp = nPtr->RxGetByte();

			if (  (STX == Temp )
				&&(STX == nPtr->RxGetByte())
				&&(STX == nPtr->RxGetByte())
				&&(STX == nPtr->RxGetByte()))
			{
				Recv->Sync[0] = STX;
				Recv->Sync[1] = STX;
				Recv->Sync[2] = STX;
				Recv->Sync[3] = STX;

				Recv->BodyNo = 0; // Default: 1EA
				break;
			}
 			{
				if((nPtr == PcSer)&&(downloadFlag == 0))
				{
					if((Temp == 'x')||(Temp == 'X'))
					{
						iDebugCnt++;
						
						if(iDebugCnt > 20)
						{
							iUser_Value2 = __ChangeDebug;
							iDebugCnt = 0; 
							TimerRegist(Timer_DebugCnt, Time1Min*10L);
						}
					}
				}				
			}
 		}
		else OSTimeDly(10L);
	}

	TimerRegist(nPtr->TimerRx, Time1Sec);
	nPtr->CheckByte(1, &nInitCnt);
	while(!nPtr->CheckByte(4, &nCnt))
	{
		if(TimeOverCheck(nPtr->TimerRx))
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(nPtr->TimerRx, Time100mSec);
			}
			else return FALSE;
		}
		OSTimeDly(10L);
	}
	
	Recv->TryNo 		= nPtr->RxGetByte();
	Recv->BodyLen[0]	= nPtr->RxGetByte();
	Recv->BodyLen[1]	= nPtr->RxGetByte();
	Recv->CheckSum		= nPtr->RxGetByte();

	Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);

	if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
		|| (Recv->BodyLength >= (TWO_BODY*BODYSIZEMAX))
	)
	{								
		return FALSE;
	}
    
#if TWO_BODY >= 2
BODYRE:
#endif
	TimerRegist(nPtr->TimerRx, Time1Sec*2);
	nPtr->CheckByte(1, &nInitCnt);
	while(1)
	{
		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(nPtr->TimerRx, Time100mSec);
			}
			else
			{
				return FALSE;
			}
		}
		if(nPtr->CheckByte(7, &nCnt))
		{
			break;// include 0x03
		}
		OSTimeDly(20L);
	}
	
	for(i = 0; i < 7 ; i++)
	{
		*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubID + i) = nPtr->RxGetByte();
	}

	Recv->BodyFrame[Recv->BodyNo].SubLength
		=	 ((Recv->BodyFrame[Recv->BodyNo].SubLen[0] << 8)& 0xff00)
		  +  ((Recv->BodyFrame[Recv->BodyNo].SubLen[1] << 0)& 0x00ff);

	if(Recv->BodyFrame[Recv->BodyNo].SubLength >= BODYSIZEMAX)	return FALSE;	


	TimerRegist(nPtr->TimerRx, Time1Sec*2);

	nPtr->CheckByte(1, &nInitCnt);
	while(1)
	{
		if(TimeOverCheck(nPtr->TimerRx)) ///1byte 500us
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(nPtr->TimerRx, Time100mSec);
			}
			else
			{
				return FALSE;
			}
		}
		if(nPtr->CheckByte((INT16U)(Recv->BodyFrame[Recv->BodyNo].SubLength + 2), &nCnt))
		{
			break;// include 0x03
		}
		OSTimeDly(20L);
	}
	for(i = 0; i < Recv->BodyFrame[Recv->BodyNo].SubLength + 2; i++)
	{
	    *((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubData + i) = nPtr->RxGetByte();
	}


	Recv->BodyFrame[Recv->BodyNo].Crc= Crc16Calc ( &(Recv->BodyFrame[Recv->BodyNo].SubID[0])
						                            , Recv->BodyFrame[Recv->BodyNo].SubLength + 5 + 2, NULL);
	Recv->BodyFrame[Recv->BodyNo].CrcOK = TRUE;

	Data = Recv->BodyFrame[Recv->BodyNo].SubLength;

	if (   ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc >> 8)!= Recv->BodyFrame[Recv->BodyNo].SubData[Data  ] )
		|| ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc     )!= Recv->BodyFrame[Recv->BodyNo].SubData[Data+1] )  )
	{
		//CRC ERROR!!
		Recv->BodyFrame[Recv->BodyNo].CrcOK = FALSE;
		return TRUE;
	}

#if TWO_BODY >= 2
	if(!Recv->BodyNo)
	{
		if(Recv->BodyLength != (Recv->BodyFrame[Recv->BodyNo].SubLength
															  + 5 + 2 + 2))
		{
			Recv->BodyNo++;
			goto BODYRE;
		}
	}
#endif	
////////////////////////////////////////////////////////////////////////////////

	TimerRegist(nPtr->TimerRx, Time1Sec);
	nPtr->CheckByte(1, &nInitCnt);
	while(!nPtr->CheckByte(1, &nCnt))
	{
		if(TimeOverCheck(nPtr->TimerRx))
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(nPtr->TimerRx, Time100mSec);
			}
			else
			{
				return FALSE;
			}
		}
		OSTimeDly(10L);
	}
	Data = nPtr->RxGetByte();

	if(Data != ETX)
	{
		return FALSE;
	}
	return TRUE;
}


INT16U WhatRxComm(__ProtocolPtr *nPtr)
{
	INT16U RetVal = 0;
	INT8U cBody = nPtr->WRCSRecv->cBody;
	
	if(nPtr->WRCSRecv->BodyFrame[cBody].CrcOK)
	{
		RetVal = nPtr->WRCSRecv->BodyFrame[cBody].Command;
	}
	else //NO ERROR
	{
		//ERROR CASE
		RetVal = AlarmSCODE;
	}
    return (RetVal);
}

void GenBodyFrame(INT8U* tid, INT8U *Data, INT16U nCnt,
					INT8U Comm, __ProtocolPtr *nPtr, INT8U BodyNo)
{
	int i = 0;
	int DataCnt = 0;
	
	__WRCSSIO *Send = nPtr->WRCSSend;
	
#if TWO_BODY >= 2
	__BODYFRAME *BodyFrame = &(Send->BodyFrame[BodyNo]);
#else
	__BODYFRAME *BodyFrame = &(Send->BodyFrame[0]);
	BodyNo = 0;
#endif

	Send->BodyNo = BodyNo;

	BodyFrame->SubID[0] = tid[0];
	BodyFrame->SubID[1] = tid[1];
	BodyFrame->SubID[2] = tid[2];

	BodyFrame->Command = Comm;
	
	BodyFrame->RCode = TRIO_RCODE;

	BodyFrame->SubLength = nCnt;
	BodyFrame->SubLen[0] = (INT8U)((nCnt) >> 8);
	BodyFrame->SubLen[1] = (INT8U)((nCnt) >> 0);

	for(i = 0 ; i < nCnt && i < BODYSIZEMAX; i++)
	{
		BodyFrame->SubData[DataCnt++] = Data[i];
	}

	///////////// CRC //
	{
		BodyFrame->Crc = Crc16Calc ((INT8U *)BodyFrame->SubID, 7 + i, NULL);
		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc >> 8);
		BodyFrame->SubData[DataCnt++] = (INT8U)(BodyFrame->Crc		);
	}
	
	BodyFrame->SubData[DataCnt++] = ETX;
}


unsigned char WRCS_ProDataAckTx(__ProtocolPtr *nPtr)
{
	INT16U i, Len = 0;
//	INT8U err = 0;
	
	__WRCSSIO *Send = nPtr->WRCSSend;

#if TWO_BODY >= 2
	INT8U BodyNo = Send->BodyNo;
#else
	INT8U BodyNo = 0;
#endif
	
//	OSSemPend(nPtr->OSSem, 0, &err );

	Send->Sync[0] = STX;
	Send->Sync[1] = STX;
	Send->Sync[2] = STX;
	Send->Sync[3] = STX;

	Send->TryNo= '0';

	Send->BodyLength = 0;

	for(i = 0; i <= BodyNo; i++)
	{
		Len = ((Send->BodyFrame[i].SubLen[0] << 8) | Send->BodyFrame[i].SubLen[1]) + 5 + 2 + 2;
		Send->BodyLength += Len;
	}
	Send->BodyLen[0] = (INT8U)(Send->BodyLength >> 8);
	Send->BodyLen[1] = (INT8U)(Send->BodyLength >> 0);

	Send->CheckSum = Send->TryNo + Send->BodyLen[0] + Send->BodyLen[1];

	nPtr->PutStr((INT8U *)Send, 4 + 1 + 2 + 1, FALSE);

	for(i = 0; i <= BodyNo; i++)
	{
		nPtr->PutStr((INT8U *)&Send->BodyFrame[i], Send->BodyFrame[i].SubLength + 7 + 2, FALSE);
	}

	BodyNo = ETX;
	nPtr->PutStr((INT8U *)&BodyNo, 1, TRUE);
//	OSSemPost(nPtr->Sem);
//	return OS_NO_ERR;
	return 0;

}

void ProtocolComCheck (__ProtocolPtr *nPtr)
{
	INT16U tcnt = 0;
	INT16U Comm = WhatRxComm(nPtr);
	
	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__WRCSSIO *Send = nPtr->WRCSSend;
    __BODYFRAME *rBody = &Recv->BodyFrame[0];
    __BODYFRAME *sBody = &Send->BodyFrame[0];

    INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};

	switch(Comm)
	{
		case SetDebugMode:
			tDnrSts->Text_Debug_Mode 		= rBody->SubData[0];
			tDnrSts->Comm_Debug_Mode.Data 	= rBody->SubData[1];
			tDnrSts->TestMode 				= rBody->SubData[2];
			tDnrSts->ModeValue 				= rBody->SubData[3];

 			GenBodyFrame(tid, (INT8U *)rBody->SubData, rBody->SubLength, Comm, nPtr, 0);
			WRCS_ProDataAckTx(nPtr);
		break;

		case ControlQue:
			if(nPtr == PcSer || (nPtr == SmsSer))
			{
				if(WRCS_DownLoadGiveupTimerSet(NULL))
				{
					if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
				}

				AnalyzeAidData(nPtr, TRUE);
				{
					OSTimeDly(100L);
 					tcnt = GenDnrAidSts((INT8U *)sBody->SubData, tDnrSts,nPtr);
					GenBodyFrame(tid, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
					WRCS_ProDataAckTx(nPtr);
				}
			}
		break;

		case DDRTableSetQue:
		case DDRTableStsQue:
			if(nPtr == PcSer || (nPtr == SmsSer))
			{
				if(WRCS_DownLoadGiveupTimerSet(NULL))
				{
					if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
				}

				Response_Table_DE(Comm,nPtr);
			}
		break;

		case StatusQue:
			if(nPtr == PcSer || (nPtr == SmsSer))
			{
				{
					tcnt = GenDnrAidSts((INT8U *)sBody->SubData, tDnrSts,nPtr);
					GenBodyFrame(tid, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
					WRCS_ProDataAckTx(nPtr);
				}

				if((nPtr == SmsSer))
				{
					if( tDnrSts->ResetCase != 0)
					{
						tDnrSts->ResetCase = 0;
					}
				}
			}
			else
			{
				AnalyzeAidData(nPtr, FALSE);
			}
		break;
		
		case DefaultQue:
			DefaultValueSet_Test(rBody->SubData[0]);
			OSTimeDly(200L);			

			tcnt = GenDnrAidSts((INT8U *)sBody->SubData, tDnrSts,nPtr);
			GenBodyFrame(tid, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
			WRCS_ProDataAckTx(nPtr);
		break;

		case DownloadCMD:
		case DownloadCMDConfirm:
		case DownLoadData:
		case DownLoadDataConfirm:
 			if(nPtr == PcSer || (nPtr == SmsSer))
			{
				if(WRCS_DownLoadGiveupTimerSet(NULL))
				{
					if( WRCS_DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
				}
				WRCS_DownLoadGiveupTimerSet((INT32U)nPtr);

				WRCS_DownloadFunc(nPtr);
 			}
		default:
		break;
	}
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


unsigned char Check_Data_Image( unsigned char *_Dat )
{
	unsigned char i;
	
	INT8U Img_Sum = 0;

	
	Img_Sum = (REMOTE_IMG + Rmt_FPGA_IMG + Rmt_FPGA_APP_IMG);

	for( i = 0; i < 32; i++ )
	{
		if (Img_Sum & REMOTE_IMG)
		{
			if( RmtCode_Image[i] != _Dat[i] ) Img_Sum &= (~REMOTE_IMG); 
		}
 	}
	
	ImgKind = Img_Sum;

	return ImgKind;

}

char ustrcmp(char *sbuff,char *dbuff, INT8U len)
{
	while(*dbuff){
		if(toupper(*sbuff++)!=*dbuff++)
			return(1);
	}
	return(0);
}

unsigned long int pPrintf(INT8U	Command, const char *format, ...)
{
	INT8U tmpData[512];
    OS_CPU_SR  cpu_sr;

	OS_ENTER_CRITICAL();
	va_list argptr;	
	va_start(argptr, format);
	vsprintf((char *)tmpData, format, argptr);
	va_end( argptr );

	{
		INT8U tid[3] = {0x00, 0xff, 0xff};
		GenBodyFrame(tid, (INT8U *)tmpData, strlen((const char *)tmpData), Command, PcSer, 0);
		WRCS_ProDataAckTx(PcSer);
	}

	OS_EXIT_CRITICAL();
	return FALSE;
}




////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

