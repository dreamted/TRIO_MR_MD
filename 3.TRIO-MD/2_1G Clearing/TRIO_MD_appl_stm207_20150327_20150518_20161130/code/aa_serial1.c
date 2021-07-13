
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
		
	PcSer->OSSem = OSSemCreate(1);
	pBackupSem = OSSemCreate(1);

	AlcSem = OSSemCreate(1);
	ExpSem = OSSemCreate(1);

	
	Initialize();
	OSTaskCreate(Ser1Task, (void *)PcSer, (OS_STK *)&Ser1TaskStk[SER1_STK_SIZE - 1], SER1TASK_PRIO);

}

void Ser1Task(void *pdata)
{
	INT8U pcheck = 0;

	__ProtocolPtr *nPtr = (__ProtocolPtr *)PcSer;

	pdata = pdata;

	SerPtr->printf("SKT TRIO-MD Rev Ver[%02x].[%02x]\n", SystemVer, PROGRAMVER);
	SerPtr->printf("SystemDate[%s]\n", SystemDate);
	SerPtr->printf("SystemTime[%s]\n", SystemTime);
	SerPtr->printf("ResetCASE = [%d][%d]\n", rambackup[ResetCountBp1],tDnrSts->ResetCase);
 
	Ser3Ptr->printf("Ser3 SKT TRIO-MD Rev Ver[%02x].[%02x]\n", SystemVer, PROGRAMVER);
	Ser3Ptr->printf("__OutputTable[%0d][%0d][%0d]\n",  sizeof(__OutputTable),sizeof(__AttnOffsetTable),sizeof(__AttnTempTable));
	Ser3Ptr->printf("FilterTable_0[%x][%x]>[%x]\n",  FilterTable->Filter_800M_L.DLFreg_Sel,FilterTable->Filter_800M_L.DLFreg_Data[0],tDnrSts->DTUFilterSts.Data[0]);
	SerPtr->printf("__OutputTable[%d][%d][%d][%d]\n",sizeof(EE_BACK1) ,sizeof(__OutputTable),sizeof(__AttnOffsetTable),sizeof(__AttnTempTable));

	{
		INT8U rval = SetBootBaudRate(115200L);
//		if(rval == FALSE)
//			SerPtr->printf("write BaudRate[%d]\n", rval);
	}

//115200

#if 0
	{
		INT8U tmp;
		tmp = FLASH_OB_GetBOR();
		if(tmp != OB_BOR_LEVEL1)
		{
			FLASH_OB_Unlock();
			FLASH_OB_BORConfig(OB_BOR_LEVEL1);
			FLASH_OB_Launch();
			FLASH_OB_Lock();
			
			SerPtr->printf("1: FLASH_OB_GetBOR\n");  ///OB_BOR_LEVEL2
		}
	}
#endif		



	while(1)
	{
		nPtr->WRCSRecv->cBody = 0;
	
		if(!tTestFlag)
		{

			pcheck = ProtocolCheck_1(nPtr);

//			if(ProtocolCheck(nPtr))
			if(pcheck)
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

				if((Temp == 'i')||(Temp == 'I'))
				{
					iDebugCnt++;
					
					if(iDebugCnt > 20)
					{
						ISODebug ^= 1;
						iISO_Debug_Mode = ISODebug;

						iDebugCnt = 0; 
//						TimerRegist(Timer_DebugCnt, Time1Min*5L);
						USART1Printf("ISODebug[%d] \n",ISODebug);
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


INT32U ProtocolCheck_1(__ProtocolPtr *nPtr)
{
	INT16U nInitCnt, nCnt;
	INT16U i = 0;
	INT16U Data;
//	INT8U Temp;
	
//	INT32U RetVal = FALSE;
	INT32U wcnt = 100;
	INT8U pFlag = FALSE;
	INT8U Sync[4] = {0,0,0,0};

//	__WRCSSIO *Recv = nPtr->WRCSRecv;

	if(TimeOverCheck(nPtr->TimerRx)){
		nPtr->SerCnt = 0;
	}
	
//	Ser3Ptr->printf("SerCnt[%d]>[%d]\n",nPtr->SerCnt,wcnt);
RECHECK:
	if(nPtr->SerCnt == 0 && wcnt--)
	{
		if(nPtr->CheckByte(4, &nCnt))
		{
			Data = nPtr->RxGetByte(); // 1

			if(Data == STX || Data == STX){
				Sync[0] = Data;
				Sync[1] = nPtr->RxGetByte(); // 2
				Sync[2] = nPtr->RxGetByte(); // 3
				Sync[3] = nPtr->RxGetByte(); // 4
				
				if(Sync[0] == STX && Sync[1] == STX && Sync[2] == STX && Sync[3] == STX){
					nPtr->SerCnt = 1;
//					Ser3Ptr->printf("1");
				}

				TimerRegist(nPtr->TimerRx, Time1Sec*2);
			}
			else pFlag = TRUE;
		}

		if(pFlag){
			if((nPtr == PcSer) && (downloadFlag == 0))
			{
				if((Data == 'x')||(Data == 'X'))
				{
					if(iDebugCnt++ > 20)
					{
						iUser_Value2 = __ChangeDebug;
						iDebugCnt = 0; 
						TimerRegist(Timer_DebugCnt, Time1Min*5L);
					}
				}
				else if((Data == 'd')||(Data == 'D'))
				{
					if(iDebugCnt++ > 20)
					{
						FSKDebug ^= 1;
						iSMS_Debug_Mode = FSKDebug;
						iDebugCnt = 0; 
						TimerRegist(Timer_DebugCnt, Time1Min*5L);
						USART1Printf("FSKDebug[%d] \n",FSKDebug);
					}
				}
				else{
				}
			}
			pFlag = FALSE;
			goto RECHECK;
		}	
	}

	{
		__WRCSSIO *Recv = nPtr->WRCSRecv;
			
		if(nPtr->SerCnt == 1){

			Recv->TryNo 		= nPtr->RxGetByte();
			Recv->BodyLen[0]	= nPtr->RxGetByte();
			Recv->BodyLen[1]	= nPtr->RxGetByte();
			Recv->CheckSum		= nPtr->RxGetByte();
			
			Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);
			
			nPtr->SerCnt++;
			if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
				|| (Recv->BodyLength >= (TWO_BODY*BODYSIZEMAX))
			)
			{								
				nPtr->SerCnt = 0;
				return FALSE;
			}

		}
		if(nPtr->SerCnt == 2){
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
						nPtr->SerCnt = 0;
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
						nPtr->SerCnt = 0;
						return FALSE;
					}
				}
				if(nPtr->CheckByte((INT16U)(Recv->BodyFrame[Recv->BodyNo].SubLength + 2), &nCnt))
				{
					nPtr->SerCnt = 0;
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
				|| ( (INT8U)(Recv->BodyFrame[Recv->BodyNo].Crc	   )!= Recv->BodyFrame[Recv->BodyNo].SubData[Data+1] )	)
			{
				//CRC ERROR!!
				Recv->BodyFrame[Recv->BodyNo].CrcOK = FALSE;
				nPtr->SerCnt = 0;
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
						nPtr->SerCnt = 0;
						return FALSE;
					}
				}
				OSTimeDly(10L);
			}
			Data = nPtr->RxGetByte();
		
			if(Data != ETX)
			{
				nPtr->SerCnt = 0;
				return FALSE;
			}
				
			nPtr->SerCnt = 0;
			return TRUE;
		}
	}
	
	return FALSE;
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

	switch(Comm)
	{
		case WaveStatusRQST:
		{
			Spectrum_Flag = SET;

			DTUGetSpecData((INT8S *)sBody->SubData, rBody->SubData[0]);
			tcnt = 1024*2;
			GenBodyFrame(tid, (INT8U *)sBody->SubData, tcnt, Comm, nPtr, 0);
			WRCS_ProDataAckTx(nPtr);
			
			Spectrum_Flag = RESET;
		}
		break;

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
        break;

		case DownloadCMD:
		case DownloadCMDConfirm:
		case DownLoadData:
		case DownLoadDataConfirm:
			
		case ModuleDownloadCMD:
		case ModuleDownloadCMDConfirm:
		case ModuleDownLoadData:
		case ModuleDownLoadDataConfirm:			
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


#define HDLC_16_FCS(fcs, c) ((fcs >> 8) ^ CRC_16_Table[(fcs^c) & 0x00ff])
INT16U makeFCS(INT8U *pBuffer,INT16U pSize,INT16U *pCalcFCS)
{
	INT16U index;
	INT8U c_byte;
	INT16U calc_fcs = HDLC_FCS_START; /* init CRC */
	if(pCalcFCS) calc_fcs = *pCalcFCS;
	for(index = 0; index < pSize; index++)
	{
		c_byte = pBuffer[index];
		calc_fcs = HDLC_16_FCS(calc_fcs,c_byte);
//		Ser3Ptr->printf("0 : calc_fcs[%d]:[%x]>[%d]\n",index,pBuffer[index],calc_fcs);
	}
	return calc_fcs;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

