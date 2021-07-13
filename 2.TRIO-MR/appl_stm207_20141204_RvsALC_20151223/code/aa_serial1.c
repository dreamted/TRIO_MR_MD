
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart1_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define SER1INT_C

#include "../include/main.h"
#include "download.c"


void Ser1Init(void)
{
 	PcSer->CheckByte = pUSART1.CheckByte;
	PcSer->RxGetByte = pUSART1.RxGetByte;
	PcSer->PutStr = pUSART1.PutStr;
	PcSer->TxCheckByte = pUSART1.TxCheckByte;
	PcSer->TxClear = pUSART1.TxClear;
	PcSer->BuffClear = pUSART1.BuffClear;

	PcSer->TimerRx = TimerSioRx;


	PcSer->WRCSRecv = &RPcsksio;
	PcSer->WRCSSend = &SPcsksio;
	
//	CtrlSem = OSSemCreate(1);/////확인 필요 
	
	PcSer->OSSem = OSSemCreate(1);
	pBackupSem = OSSemCreate(1);

	AlcSem = OSSemCreate(1);
	ExpSem = OSSemCreate(1);

	
	Initialize();
	OSTaskCreate(Ser1Task, (void *)PcSer, (OS_STK *)&Ser1TaskStk[SER1_STK_SIZE - 1], SER1TASK_PRIO);

//	ChkTableAlarm = SET;
}

void Ser1Task(void *pdata)
{
	__ProtocolPtr *nPtr = (__ProtocolPtr *)PcSer;

	pdata = pdata;

	SerPtr->printf("SKT TRIO-M Rev Ver[%02x].[%02x]\n", SystemVer, PROGRAMVER);
	SerPtr->printf("SystemDate[%s]\n", SystemDate);
	SerPtr->printf("SystemTime[%s]\n", SystemTime);
	SerPtr->printf("ResetCASE = [%d][%d]\n", rambackup[ResetCountBp1],tDnrSts->ResetCase);
	{
		INT8U rval = SetBootBaudRate(38400L);
//			SerPtr->printf("write BaudRate[%d]\n", rval);
	}
	{
		INT8U tmp;
		tmp = FLASH_OB_GetBOR();

		if(tmp != OB_BOR_LEVEL2)
		{
			FLASH_OB_Unlock();
			FLASH_OB_BORConfig(OB_BOR_LEVEL2);
			FLASH_OB_Launch();
			FLASH_OB_Lock();
			
			SerPtr->printf("1: FLASH_OB_GetBOR\n");
		}
	}
//	SerPtr->printf("__OutputTable[%d][%d][%d][%d]\n",sizeof(EE_BACK1) ,sizeof(__OutputTable),sizeof(__AttnOffsetTable),sizeof(__AttnTempTable));


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
		DownLoadGiveupTimerChk1(nPtr);
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
				#if 1
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

				if((Temp == 'd')||(Temp == 'D'))
				{
					iDebugCnt++;
					
					if(iDebugCnt > 20)
					{
						FSKDebug ^= 1;
						iSMS_Debug_Mode = FSKDebug;

						iDebugCnt = 0; 
						TimerRegist(Timer_DebugCnt, Time1Min*5L);
						USART1Printf("FSKDebug[%d] \n",FSKDebug);
					}
				}

				
				#endif
				#if 0
				if((nPtr == PcSer) && (downloadFlag == 0))
				{
					if((Data == 'x')||(Data == 'X'))
					{
						iDebugCnt++;
						
						if(iDebugCnt > 20)
						{
							nPtr->BuffClear();
							TimerRegist(nPtr->TimerRx, Time1Sec*30L);
							
							SerPtr->printf("\n\n---ENTER THE \"test/TEST\"--- \n");
							
							PromptOut();
							
							while(1)
							{
								if(SerPtr->CheckByte(1, &nCnt))
								{
									//KeyProc(SerPtr->RxGetByte(), TestCommand);
								}
								OSTimeDly(20L);
								if(TimeOverCheck(nPtr->TimerRx)) return FALSE;
							}
							////////////////////////////////////////////////////////////////////////////
						}
					}
					else{
					}
				}
				#endif
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


void ProtocolComCheck(__ProtocolPtr *nPtr)
{
	INT16U tcnt = 0;
	INT16U Comm = WhatRxComm(nPtr);
	
	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__WRCSSIO *Send = nPtr->WRCSSend;
    __BODYFRAME *rBody = &Recv->BodyFrame[0];
    __BODYFRAME *sBody = &Send->BodyFrame[0];

    INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};

//	SerPtr->printf("Comm[%x]\n", Comm);

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
			if(DownLoadGiveupTimerSet(NULL))
			{
				if(DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
			}

			AnalyzeAidData(nPtr, TRUE);
			{
				OSTimeDly(100L);
					tcnt = GenDnrAidSts((INT8U *)sBody->SubData, tDnrSts,nPtr);
				GenBodyFrame(tid, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
				WRCS_ProDataAckTx(nPtr);
			}
		break;

		case DDRTableSetQue:
		case DDRTableStsQue:
			if(DownLoadGiveupTimerSet(NULL))
			{
				if(DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
			}
			Response_Table(nPtr);

			ChkTableAlarm = SET;
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
#if 0			
			DefaultValueSet_Test(rBody->SubData[0]);
			OSTimeDly(200L);			

			tcnt = GenDnrAidSts((INT8U *)sBody->SubData, tDnrSts,nPtr);
			GenBodyFrame(tid, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
			WRCS_ProDataAckTx(nPtr);
#endif
            break;

		case DownloadCMD:
		case DownloadCMDConfirm:
		case DownLoadData:
		case DownLoadDataConfirm:
			if(DownLoadGiveupTimerSet(NULL))
			{
				if(DownLoadGiveupTimerSet(NULL) != (INT32U)nPtr ) return;
			}
			DownLoadGiveupTimerSet((INT32U)nPtr);
			DownloadFunc(nPtr);
		default:
		break;
	}
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

//	SerPtr->printf("1 :BodyLength[%d]\n", Send->BodyLength);  /// FALSE

	nPtr->PutStr((INT8U *)Send, 4 + 1 + 2 + 1, FALSE);

	for(i = 0; i <= BodyNo; i++)
	{
		nPtr->PutStr((INT8U *)&Send->BodyFrame[i], Send->BodyFrame[i].SubLength + 7 + 2, FALSE);
	}

	BodyNo = ETX;
	nPtr->PutStr((INT8U *)&BodyNo, 1, TRUE);
//	OSSemPost(nPtr->OSSem);
//	return OS_NO_ERR;
	return 0;
//
//nPtr->PutStr((INT8U *)Send, Count + 12, TRUE);	
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

