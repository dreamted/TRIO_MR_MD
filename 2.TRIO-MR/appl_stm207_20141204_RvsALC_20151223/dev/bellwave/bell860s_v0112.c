/*******************************************************************************
 *
 * This module contains the function 7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 *
 * &Revision:
 * &Revision date: 
 ******************************************************************************/

#define __BELL_C
 

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "../include/main.h"

#define ____	USART1Printf("%s %d\n", __FUNCTION__, __LINE__);


void BcMdemDebug(INT32U nDebug, INT32S *DebugPtr)
{
	BcMdebug = nDebug;
	if(DebugPtr != NULL) dUartPtr = (__SerStrPtr *)(DebugPtr);
	else				 dUartPtr = (__SerStrPtr *)(&pUSART1);

}

INT8S BcMdemInit(__SerStrPtr *uPtr, INT16U TimerRx)
{
    INT8U CmdStep = RstCmd;
	INT8U result = 0;
	INT16U i = 0;
	INT8U Ptr[100];
	

	// memory Allocation
	if(dUartPtr == NULL)				return -1;			// error: debuguart not allocated --> BcMDebug excuted befor
	if( (eUartPtr = uPtr) == NULL)		return -2;			// error: Excution Ptr not allocated --> 
	
	if( (BcMTimerRx = TimerRx) == NULL)	return -3;			// error: TimerValue Error
	
INIT_SEQUENCE : 

//	USART1Printf("0 : CmdStep[%d][%d]>[%d] \n",CmdStep,ModemType,BcMRtryNo);

	switch(CmdStep)
	{
		case RstCmd: 				BcMdemXmit(CdmaRstCmd); 			result = 0; break;
		case ModemHangUpCmd : 		BcMdemXmit(CdmaModemHangUpCmd); 	result = 3; break;
//		case ModemRptModeSetCmd :	BcMdemXmit(CdmaRptModeSetCmd); 		result = 1; break;
		case VersionCmd : 			BcMdemXmit(CdmaVersionCmd); 		result = 2; break;
		case ModemMinNumCmd : 		BcMdemXmit(CdmaModemMinNumCmd); 	result = 2; break;
		case ModemEsnCmd :			
		{
//			if((BcMType == 0x0C)||(BcMType == 0x0D))
				
			if( ModemType == _WCMDA_Modem)
			{
				BcMdemXmit(WcdmaModemICCIDCmd); 	result = 2; break;
			}
			else
			{
				BcMdemXmit(CdmaModemEsnCmd);		result = 2; break;
			}
		}
		case ModemTimeCmd : 		BcMdemXmit(CdmaModemTimeCmd); 		result = 2; break;

 	}
		
	switch(result)
	{
		case 0:
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) == 14) break;
			}	
			else return FALSE;
			
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) != 14) return FALSE;
			}
			else return FALSE;
		break;

		case 1:
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) != 14) return FALSE;
			}
			else return FALSE;
		break;

		case 2:
			if(BcMdemSyncProtocolCheck())
			{
				if(!BcMdemDataProtocolCheck(CmdStep))return FALSE;

				if(CmdStep == ModemMinNumCmd)break;
				
				if(!BcMdemSyncProtocolCheck())							 return FALSE;
				if(BcMdemSyncCheck((char *)RxCdmaData) != 14)			 return FALSE;
			}
			else return FALSE;
		break;

		case 3:
			if(BcMdemSyncProtocolCheck())
			{
				for(i = 0; i < strlen(RspmsgHangup);i++)Ptr[i] = RxCdmaData[i];
				Ptr[i] = 0;
				if(BcMdemSyncCheck((char *)Ptr) != 30)return FALSE;
				
//				if(RxCdmaData[i] != '1')return FALSE;
//				if(RxCdmaData[i] != '1')return TRUE;
			}
			else return FALSE;
		break;
		
	}

	if(CmdStep++ == ModemTimeCmd)	return TRUE;

	goto INIT_SEQUENCE;
}

void BcMdemXmit(INT8U *dataPtr)
{	
	if(!eUartPtr) return;
	eUartPtr->BuffClear();
	eUartPtr->printf("%s\n", (char *)dataPtr);
	if(BcMdebug) dUartPtr->printf("%s\n", (char *)dataPtr);
}

INT32S BcMdemMSGTx(char *DstTel, char *dataPtr, INT16U nlen)
{
	INT16U i = 0;
	
	INT8U Ptr[200];
	INT32S nRet = TRUE;

	if(nlen > SmsMaxLen) return -3;
	if(nlen > SmsWanLen) nRet = 3;	


  	if(ModemType == _WCMDA_Modem)
	{
		sprintf((char *)TxCdmaData, "%s%s,%s,4098,0,0,0,", CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
 	}
 	else
	{
		sprintf((char *)TxCdmaData, "%s%s,%s,4098,,,,", CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
	}

	for(i = 0; i < nlen; i++)
	{
		sprintf((char *)Ptr, "%02X", dataPtr[i]);
		strcat((char *)TxCdmaData, (const char *)Ptr);
	}

	BcMdemXmit((INT8U *)TxCdmaData);
	if(BcMdemSyncProtocolCheck())
	{
    	if(BcMdemSyncCheck((char *)RxCdmaData) == 14)
    	{
    	    if(nRet == 3) nRet = 4;
    	    else          nRet = 2;
    	} 
		else  nRet = -2;
		
	}	
	else return FALSE;

	OSTimeDly(Time100mSec);
	for(i = 0 ;i < 4; i++)
		{
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) == 10)
				{
				         if(nRet == 4) nRet = 5;
				    else if(nRet == 2) nRet = 6;
				    else nRet = TRUE;
				}
				else  nRet = -1;
			}
			if( nRet != 2) break;
			OSTimeDly(Time100mSec*2L);
		}
	
	//  6: Sms Len Over 80 Bytes(Waringin), But Success, 1st Response OK, but 1st resonse data error, 2nd Response Data NOK
    //  5: Sms Len Over 80 Bytes(Waringin), But Success, 1st Response OK, but 1st resonse data error, 2nd Response Data OK
	//  4: Sms Len over 80 Bytes(Warning) But Success, 1st Response OK, but 1st resonse data error, 2nd Rsponse No response
	//  2: 1st Response OK, but 1st resonse data error, 2nd Rsponse No response
	//  1: Modem Send Success
	//  0: Modem No Response
	// -1: 2nd Response Data Error
	// -2: 1st Response Data Error, 2nd Response No response
	// -3: Max Buffer Error
	return nRet;
}


INT32S BcMdemMSGSentTx(char *DstTel,char *SentTel, char *dataPtr, INT16U nlen)
{
	INT16U i = 0;
	
	INT8U Ptr[200];
	INT32S nRet = TRUE;

	if(nlen > SmsMaxLen) return -3;
	if(nlen > SmsWanLen) nRet = 3;	


//	if((BcMType == 0x0C)||(BcMType == 0x0D))
//	if( ModemType == _WCMDA_Modem)


	if(ModemType == _WCMDA_Modem)
	{
		sprintf((char *)TxCdmaData, "%s%s,%s,4098,0,0,0,", CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
	}
	else
	{
		sprintf((char *)TxCdmaData, "%s%s,%s,4098,,,,", CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
	}

	for(i = 0; i < nlen; i++)
	{
		sprintf((char *)Ptr, "%02X", dataPtr[i]);
		strcat((char *)TxCdmaData, (const char *)Ptr);
	}

	BcMdemXmit((INT8U *)TxCdmaData);

	if(BcMdemSyncProtocolCheck())
	{
    	if(BcMdemSyncCheck((char *)RxCdmaData) == 14)
    	{
    	    if(nRet == 3) nRet = 4;
    	    else          nRet = 2;
    	} 
		else  nRet = -2;
		
	}	
	else return FALSE;

	OSTimeDly(Time100mSec);

	for(i = 0 ;i < 4; i++)
		{
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) == 10)
				{
				         if(nRet == 4) nRet = 5;
				    else if(nRet == 2) nRet = 6;
				    else nRet = TRUE;
				}
				else  nRet = -1;
			}
			if( nRet != 2) break;
			OSTimeDly(Time100mSec*2L);
		}
	return nRet;
}



INT32S BcMdemTCPTx(char *dataPtr, INT16U nlen)
{

    INT16U i;
	INT8U Ptr[200];
	INT32S nRet = TRUE;

	sprintf((char *)TxCdmaData, "%s", CdmaModemTcpWrCmd);

	for(i = 0; i < nlen; i++)
	{
		sprintf((char *)Ptr, "%02X", dataPtr[i]);
		strcat((char *)TxCdmaData, (const char *)Ptr);
	}

	BcMdemXmit((INT8U *)TxCdmaData);

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 14) return FALSE;
	}	
	else return FALSE;

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 24) return FALSE;
	}
	else return FALSE;

	return nRet;
}

INT32S BcMdemTCPRxCheck(INT8U *rbuf)
{	
	INT32S nRet = 0;
	INT32U i = 0, j = 0, len = 0;
	INT8S CheckDataBuff[20];
	INT8U *tPtr = RxCdmaData;

	if(BcMdemSyncProtocolCheck())
	{
		eUartPtr->BuffClear();
		
		for(i = 0; i < strlen(CdmaModemTcpRdCmd); i++)CheckDataBuff[i] = *tPtr++;

		CheckDataBuff[i] = 0;

		if(BcMdemSyncCheck((char *)CheckDataBuff) != 25)return FALSE;
		
		for(j = 0; *tPtr != 0; j++)
		{
			INT8U temp;

			//if((*tPtr == 0x0D)||(*tPtr == 0x0A)) break;
			
			temp = atoh(*tPtr++);
			temp = atoh(*tPtr++) + ( temp << 4 );
			
			rbuf[len++] = temp;
		}
				
		nRet = len;
		rbuf[len++] = 0;	// null data insert
				
	}	
	else
	{
		nRet = FALSE;
		eUartPtr->BuffClear();
	}
	
	return nRet;
}

INT32S BcMdemSyncProtocolCheck(void)
{
	INT16U	Recv;
	INT32S  DataCnt = 0;

	TimerRegist(BcMTimerRx, Time1Sec * 15L);
	//TimerRegist(BcMTimerRx, 600L*100L); // 1분

	while(1)
	{
		if(TimeOverCheck(BcMTimerRx)) return FALSE;
		/*
		if(eUartPtr->CheckByte(1, &Recv))
		{
			RxCdmaData[DataCnt] = eUartPtr->RxGetByte();

			if(BcMdebug) dUartPtr->PutChar(RxCdmaData[DataCnt]);	// debug

			if ((DataCnt == 0)&&((RxCdmaData[DataCnt] == 0x0d)||(RxCdmaData[DataCnt] == 0x0a))) continue;
		
			if ( RxCdmaData[DataCnt++] == 0x0d )
			{
				RxCdmaData[DataCnt++] = 0x0a;
				RxCdmaData[DataCnt++] = 0;		// insert null point

				//if(RxCdmaData[0] == '$')
				//{
				//	Ret = BcMdemSyncCheck((char *)RxCdmaData);
					
				//	if((Ret == 15)||(Ret == 16))
				//	{
				//		DataCnt = 0;
				//		continue;
				//	}
				//}
				//Ser0Printf("DataCnt: %d, DataCnt - 3, %d \n", DataCnt, DataCnt-3);
				return(DataCnt - 3);	// received length(2005.05.17 by bgyoon)
			}
			if(DataCnt > CdmaBuffLen ) return FALSE;
		
		}
		else OSTimeDly(_OS_1ms);
		*/

		while(eUartPtr->CheckByte(1, &Recv))
		{
			RxCdmaData[DataCnt] = eUartPtr->RxGetByte();

			if(BcMdebug) dUartPtr->PutChar(RxCdmaData[DataCnt]);	// debug

			if ((DataCnt == 0)&&((RxCdmaData[DataCnt] == 0x0d)||(RxCdmaData[DataCnt] == 0x0a))) continue;
		
			if ( RxCdmaData[DataCnt++] == 0x0d )
			{
				RxCdmaData[DataCnt++] = 0x0a;
				RxCdmaData[DataCnt++] = 0;		// insert null point

				//if(RxCdmaData[0] == '$')
				//{
				//	Ret = BcMdemSyncCheck((char *)RxCdmaData);
					
				//	if((Ret == 15)||(Ret == 16))
				//	{
				//		DataCnt = 0;
				//		continue;
				//	}
				//}
//				USART1Printf("DataCnt: %d, DataCnt - 3, %d \n", DataCnt, DataCnt-3);
				return(DataCnt - 3);	// received length(2005.05.17 by bgyoon)
			}
#if 0
			RxCdmaData[DataCnt + 1] = 0x0A;
			RxCdmaData[DataCnt + 2] = 0x00;
			
			if(BcMdebug) pPrintf(WaveDebugMode, "%s\r\n ", RxCdmaData);
#endif			
			
			if(DataCnt >= CdmaBuffLen ) return FALSE;

		}
		OSTimeDly(1);
	}
}

INT32S BcMdemSyncCheck(char *Ptr)
{

	if(Ptr == NULL || strlen(Ptr) == 0) 						return 0;

	if(!strncmp(Ptr, RspTxAckmsg, strlen(RspTxAckmsg))) 		return 10;
	if(!strncmp(Ptr, Rspconnect, strlen(Rspconnect))) 			return 11;
	if(!strncmp(Ptr, Rspnocarr, strlen(Rspnocarr))) 			return 12;

	if(!strncmp(Ptr, CdmaErr, strlen(CdmaErr))) 				return 13;
	if(!strncmp(Ptr, CdmaOk, strlen(CdmaOk))) 					return 14;

	if(!strncmp(Ptr, Rspmsg0Rx, strlen(Rspmsg0Rx))) 			return 15;
	if(!strncmp(Ptr, Rspmsg1Rx, strlen(Rspmsg1Rx))) 			return 16;

	if(!strncmp(Ptr, RspTxmsg, strlen(RspTxmsg))) 				return 17;

	if(!strncmp(Ptr, RspTcpOpenOk, strlen(RspTcpOpenOk))) 		return 18;
	if(!strncmp(Ptr, RspmsgRxCnt,  strlen(RspmsgRxCnt))) 		return 19;
	if(!strncmp(Ptr, RspmsgRxMsg,  strlen(RspmsgRxMsg))) 		return 20;
	if(!strncmp(Ptr, RspmsgRxEsn,  strlen(RspmsgRxEsn))) 		return 21;
	if(!strncmp(Ptr, RspmsgRxRfSts,  strlen(RspmsgRxRfSts))) 	return 22;
	if(!strncmp(Ptr, RspmsgTraffic,  strlen(RspmsgTraffic)))	return 23;
	
	if(!strncmp(Ptr, CdmaModemTcpSendDone, strlen(CdmaModemTcpSendDone)))return 24;
	if(!strncmp(Ptr, CdmaModemTcpRdCmd,  strlen(CdmaModemTcpRdCmd)))	return 25;
	if(!strncmp(Ptr, RspTcpCloseOk,  strlen(RspTcpCloseOk)))			return 26;
	if(!strncmp(Ptr, RspmsgSwRst,  strlen(RspmsgSwRst)))				return 27;
	if(!strncmp(Ptr, RspmsgCallAck,  strlen(RspmsgCallAck)))			return 28;
	if(!strncmp(Ptr, RspmsgCallConnect,  strlen(RspmsgCallConnect)))	return 29;
	if(!strncmp(Ptr, RspmsgHangup,  strlen(RspmsgHangup)))				return 30;
	if(!strncmp(Ptr, RspmsgPilot,  strlen(RspmsgPilot)))				return 31;
	if(!strncmp(Ptr, RspmsgMinNum,  strlen(RspmsgMinNum)))				return 32;
	if(!strncmp(Ptr, RspmsgCallingCmd,  strlen(RspmsgCallingCmd)))		return 33;

	if(!strncmp(Ptr, RspICCID,  strlen(RspICCID)))						return 34;

	if(!strncmp(Ptr, RspLockOrder,	strlen(RspLockOrder)))				return 35;
	
	if(!strncmp(Ptr, RspGMMLockOrder, strlen(RspGMMLockOrder)))			return 36;
	return -1;	// Normal Data
}

	
INT8S  BcMdemDataProtocolCheck(INT8S Command)
{
	INT8S nRet = 0;
	INT8U i = 0, j = 0 ;
	INT8S CheckDataBuff[20];
	
	INT8U DataCnt=0, DataCnt2=0 ;

	switch(Command)
	{
		case VersionCmd:

			for(i = 0; RxCdmaData[i] != 0x0d; i++) {}

			if(i < 6)return FALSE;

			//////////////////////////////////////////////////////////////////////////
			 // 단말기 제조사
			if( (strstr(((char*)RxCdmaData), ((char*)"SAT"))) != NULL )
			{
				BcMMaker = 0x04;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"KST"))) != NULL )
			{
				BcMMaker = 0x02;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"ATS"))) != NULL )
			{
				BcMMaker = 0x03;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"x05"))) != NULL )
			{
				BcMMaker = 0x05;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"x06"))) != NULL )
			{
				BcMMaker = 0x06;////ANTS
			}
			else
			{


			}
			//////////////////////////////////////////////////////////////////////////
			// 단말기 Type
			if( (strstr(((char*)RxCdmaData), ((char*)"ZZB3"))) != NULL )
			{
				BcMType = 0x05;
				ModemType = _CMDA_Modem;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"ZZB4"))) != NULL )
			{
				//SXC-2080
				BcMType = 0x04;
				ModemType = _CMDA_Modem;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"ZZB5"))) != NULL )
			{
				BcMType = 0x06;
				ModemType = _CMDA_Modem;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"0x0C"))) != NULL )
			{
				BcMType = 0x0C;
				ModemType = _WCMDA_Modem;
			}
			else if( (strstr(((char*)RxCdmaData), ((char*)"0x0D"))) != NULL )
			{
				BcMType = 0x0D;   //////0x0D : ANTS-E300SWA(WCDMA내장형)
				ModemType = _WCMDA_Modem;
			}
			else
			{
				ModemType = _WCMDA_Modem;
			}

			BcMVerNum[0] = RxCdmaData[i-3];
			BcMVerNum[1] = RxCdmaData[i-2];
			BcMVerNum[2] = RxCdmaData[i-1];

			nRet = TRUE;
		break;
		
		case ModemMinNumCmd:
			for(i = 0; i < strlen(RspmsgMinNum);i++)
			{
				CheckDataBuff[i] = RxCdmaData[i];
			}
			CheckDataBuff[i] = 0;

			if(BcMdemSyncCheck((char *)CheckDataBuff) != 32)return FALSE;
		
			nRet = TRUE;

			for ( i=0; i<TelNo; i++ ) if ( RxCdmaData[strlen(RspmsgMinNum)+ (DataCnt++)] == '-' ) break;
  			{
				INT8U Data,k = 0;
 				for ( j=0; j < TelNo; j++ )
				{
					Data = RxCdmaData[strlen(RspmsgMinNum)+ j];
 					if ( Data == 0x0d ) break;
					if('-' == Data) 
					{
//						BcMSrcTel[j] = RxCdmaData[strlen(RspmsgMinNum)+ j];
					}
					else
					{

						BcMSrcTel[k++] = Data;
					}
					DataCnt2 = k;
 				}
 				DataCnt2 = DataCnt2;
 			}
  		break;

		case ModemEsnCmd:
 			if( ModemType == _WCMDA_Modem)
			{

				for(i = 0; i < strlen(RspICCID);i++)CheckDataBuff[i] = RxCdmaData[i];

				CheckDataBuff[i] = 0;
				
				if(BcMdemSyncCheck((char *)CheckDataBuff) != 34)return FALSE;
				
				for(j = 0; j < 19; j++, i++)ICCIDNum[j] = RxCdmaData[i];
			
				nRet = TRUE;
			}
			else
			{
				for(i = 0; i < strlen(RspmsgRxEsn);i++)CheckDataBuff[i] = RxCdmaData[i];

				CheckDataBuff[i] = 0;
				
				if(BcMdemSyncCheck((char *)CheckDataBuff) != 21)return FALSE;
				
				for(j = 0; j < 8; j++, i++)BcMEsnNum[j] = RxCdmaData[i];
			
				nRet = TRUE;
			}
		break;
		
		case MsgCheckCmd:
		{
			for(i = 0; i < strlen(RspmsgRxCnt);i++)CheckDataBuff[i] = RxCdmaData[i];
			
			CheckDataBuff[i] = 0;

			if(BcMdemSyncCheck((char *)CheckDataBuff) != 19) return FALSE;
#if 0
			if((RxCdmaData[i] < '0')||(RxCdmaData[i] > '9')) nRet = FALSE;
			else if(RxCdmaData[i] == '0')					 nRet = NOT_DATA;
			else 											 nRet = TRUE;
#endif		

#if 1
			if(RxCdmaData[i] == '0')					 			 nRet = NOT_DATA;
			else if((RxCdmaData[i] < '0')||(RxCdmaData[i] > '9'))	 nRet = FALSE;
			else 													 nRet = TRUE;
#endif		
//			if(BcMdebug) dUartPtr->printf("1: MsgCheckCnt[%d]> %d\n", MsgCheckCnt,nRet);
		}
		break;
		
		case MsgReciveCmd:
			for(i = 0; i < strlen(RspmsgRxMsg);i++)CheckDataBuff[i] = RxCdmaData[i];

			CheckDataBuff[i] = 0;

			if(BcMdemSyncCheck((char *)CheckDataBuff) != 20)return FALSE;
			
			if((RxCdmaData[i] < '0')||(RxCdmaData[i] > '9'))nRet = FALSE;
			//else if(RxCdmaData[i] == '0')	nRet = NOT_DATA;			
			else nRet = TRUE;

			//if(RxCdmaData[i] == 0x22)i++;
							
			for(j = 0; RxCdmaData[i] != 0; j++,i++) RxBcMData[j] = RxCdmaData[i];
			RxBcMData[j] = 0;

		break;
		
		case ModemTimeCmd:

			for(i = 0; i < strlen(RspmsgTraffic);i++)CheckDataBuff[i] = RxCdmaData[i];

			CheckDataBuff[i] = 0;

			if(BcMdemSyncCheck((char *)CheckDataBuff) != 23)return FALSE;
			
			i += 2; // Traffic Status skip

			// Init
			for(j = 0; j < sizeof(BcMTimeStr); j++) *((INT8U *)BcMpresentTime + j) = 0;

			for(j = 0; j < 14; j++, i++) *((char *)BcMpresentTime + j) = RxCdmaData[i];
			
			nRet = TRUE;
			
		break;

		case ModemRfStsCmd:
			
			for(i = 0; i < strlen(RspmsgRxRfSts);i++)CheckDataBuff[i] = RxCdmaData[i];

			CheckDataBuff[i] = 0;

			if(BcMdemSyncCheck((char *)CheckDataBuff) != 22)return FALSE;
			
			if((RxCdmaData[i] < '0')||(RxCdmaData[i] > '9'))return FALSE;

			nRet = BcMFreqStateCheck( (INT8U *)&RxCdmaData[i] );
			
		break;

		case ModemTrafficCmd:
			
			for(i = 0; i < strlen(RspmsgTraffic);i++)CheckDataBuff[i] = RxCdmaData[i];

			CheckDataBuff[i] = 0;

			if(BcMdemSyncCheck((char *)CheckDataBuff) != 23)return FALSE;

			nRet = RxCdmaData[i];
  		break;

		case ModemPilotCmd:
			
			for(i = 0; i < strlen(RspmsgPilot);i++)CheckDataBuff[i] = RxCdmaData[i];

			CheckDataBuff[i] = 0;

 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 31)return FALSE;
			nRet = BcMPilotStateCheck( (INT8U *)&RxCdmaData[i]);
		break;

		case ModemLockOrderCmd:
 			{
				for(i = 0; i < strlen(RspLockOrder);i++)CheckDataBuff[i] = RxCdmaData[i];

				CheckDataBuff[i] = 0;
				
				if(BcMdemSyncCheck((char *)CheckDataBuff) != 35)return FALSE;
 			
				nRet = TRUE;
			}
 		break;
		
		
		default : return FALSE;
	}	

	return nRet;
	
}

INT8S BcMFreqStateCheck ( INT8U *DataBuff )
{
 	if( ModemType == _WCMDA_Modem)
	{
		INT8U	i, j, k = 0, DataCnt=0, DataCnt2=0, pw;
		INT16S	TempCopy, Power, Actch = 0, chlist = 0;
		INT16S	PSClist = 0;


        k = k;
        Actch = Actch;
        chlist = chlist;
		//================//
		// Active Channel //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}
		
		Actch = TempCopy;
		BcMRfStatus->ActChannel = TempCopy;

//		USART1Printf("BcMRfStatus->ActChannel : %d \n", BcMRfStatus->ActChannel);

		//=====================//
		// Number Of Channel //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}
		
		BcMRfStatus->NumberOfChannel = TempCopy;
		
		if ( TempCopy == 0 ) return(FALSE);
		
		//SWaveStatus->ChannelList = ( ((TempCopy/10)<<4) + (TempCopy%10) );
		chlist = TempCopy;

//		USART1Printf("chlist : %d \n", chlist);
		//==============//
		// Channel List //
		//========================================================================//
		for ( k=0; k<chlist; k++ )
		{
			DataCnt2 = DataCnt;
			TempCopy = 0;
			for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
			
//			USART1Printf("0: PN_Vaule : [%d][%d][%d] \n", i,k,BcMRfStatus->PN_Vaule[k]);
			if ( i > 6 ) return(FALSE);

			for ( j=0; j<i; j++ )
			{
//				USART1Printf("1: PN_Vaule : [%d][%d] \n", k,BcMRfStatus->PN_Vaule[k]);

				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			
			BcMRfStatus->PN_Vaule[k] = TempCopy;
			if ( Actch == TempCopy ){}

//			USART1Printf("2: PN_Vaule : [%d][%d] \n", k,BcMRfStatus->PN_Vaule[k]);
		}		

		//================//
		// Active PSC     //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}
		
		BcMRfStatus->PSClist = TempCopy;
		
		if ( TempCopy == 0 ) return(FALSE);
		
		//SWaveStatus->ChannelList = ( ((TempCopy/10)<<4) + (TempCopy%10) );
		PSClist = TempCopy;

//		USART1Printf("PSClist : %d \n", PSClist);

		//==============//
		// PSC List //
		//========================================================================//
		for ( k=0; k<PSClist; k++ )
		{
			DataCnt2 = DataCnt;
			TempCopy = 0;
		
			for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == '(' ) break;
			
			if ( i > 6 ) return(FALSE);
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			
			BcMRfStatus->PSC_Vaule[k] = TempCopy;
//			USART1Printf("0: PSC_Vaule : [%d][%d] \n", k,BcMRfStatus->PSC_Vaule[k]);
			DataCnt2 = DataCnt;
			TempCopy = 0;
			for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ')' ) break;
			DataCnt++;		// Remove ','
			
			if ( DataBuff[DataCnt2] == '-' )
			{
				DataCnt2++;
				for ( j=0; j<i-1; j++ )
				{
					if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
					for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
					TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
				}
				TempCopy = -TempCopy;
				BcMRfStatus->EcIo[k] = TempCopy;
			}
			else
			{
				for ( j=0; j<i; j++ )
				{
					if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
					for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
					TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
				}
				BcMRfStatus->EcIo[k] = TempCopy;
			}
//			USART1Printf("2: EcIo : [%d][%d][%d] \n", i,k,BcMRfStatus->EcIo[k]);
		}

//		FER_VAULE:
		//===========//
		// BER Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}
		
		BcMRfStatus->BER = TempCopy;
//		USART1Printf("2: BER : [%d] \n",BcMRfStatus->BER);
		//==========//
		// RX Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		if ( DataBuff[DataCnt2] == '-' )
		{
			DataCnt2++;
			for ( j=0; j<i-1; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			TempCopy = -TempCopy;
			BcMRfStatus->RxValue = TempCopy;
		}
		else
		{
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			BcMRfStatus->RxValue = TempCopy;
		}
//		USART1Printf("2: RxValue : [%d] \n",BcMRfStatus->RxValue);

		//========================================================================//
		if ( TempCopy > 0 ) return(FALSE);

		//==========//
		// TX Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		if ( DataBuff[DataCnt2] == '-' )
		{
			DataCnt2++;
			for ( j=0; j<i-1; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			TempCopy = -TempCopy;
			BcMRfStatus->TxValue = TempCopy;
		}
		else
		{
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			BcMRfStatus->TxValue = TempCopy;
		}

//		USART1Printf("2: TxValue : [%d] \n",BcMRfStatus->TxValue);
 	
		//===========//
		// ADJ Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == 0x0d ) break;
		if ( DataBuff[DataCnt2] == '-' )
		{
			DataCnt2++;
			for ( j=0; j<i-1; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			TempCopy = -TempCopy;
			BcMRfStatus->AdjValue = TempCopy;
			
		}
		else
		{
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			BcMRfStatus->AdjValue = TempCopy;
		}
//		USART1Printf("2: AdjValue : [%d] \n",BcMRfStatus->AdjValue);
 	}
	else
	{
		INT8U	i, j, k, DataCnt=0, DataCnt2=0, pw;
		INT16S		TempCopy, Power, Actch, chlist;
		//================//
		// Active Channel //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}
		Actch = TempCopy;
		BcMRfStatus->ActChannel = TempCopy;

		//SWaveStatus->OneFAStatus = 0x03;		// Current FA
		//========================================================================//

		//=====================//
		// Number Of Channel //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}

		BcMRfStatus->NumberOfChannel = TempCopy;

		if ( TempCopy == 0 ) return(FALSE);

		//SWaveStatus->ChannelList = ( ((TempCopy/10)<<4) + (TempCopy%10) );
		chlist = TempCopy;

		//==============//
		// Channel List //
		//========================================================================//
		for ( k=0; k<chlist; k++ )
		{
			DataCnt2 = DataCnt;
			TempCopy = 0;
			for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
			if ( i > 4 ) return(FALSE);
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			
			BcMRfStatus->PN_Vaule[k] = TempCopy;
			if ( Actch == TempCopy ){}
				
		}
		//========================================================================//

		//=======================//
		// Number Of Active PN	//
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		if ( i > 1 ) return(FALSE);

		if(DataBuff[DataCnt2]  == '0')goto FER_VAULE;

		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}
		BcMRfStatus->ActPN = TempCopy;
		//	Ser0Printf("ActPN : %d	\n", Rf_sts.ActPN);

		if ( (TempCopy > 6)||(TempCopy < 1 ) ) return(FALSE);
		chlist = TempCopy;
		//========================================================================//


		//============================//
		// Active Channel Ec/Io Value //
		//========================================================================//
		for ( k=0; k<chlist; k++ )
		{
			DataCnt2 = DataCnt;
			TempCopy = 0;

			for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == '(' ) break;
			if ( i > 4 ) return(FALSE);
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			
			BcMRfStatus->PN_Vaule[k] = TempCopy;
			
			DataCnt2 = DataCnt;
			TempCopy = 0;
			for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ')' ) break;
			DataCnt++;		// Remove ','
			if ( DataBuff[DataCnt2] == '-' )
			{
				DataCnt2++;
				for ( j=0; j<i-1; j++ )
				{
					if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
					for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
					TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
				}
				TempCopy = -TempCopy;
				BcMRfStatus->EcIo[k] = TempCopy;
			}
			else
			{
				for ( j=0; j<i; j++ )
				{
					if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
					for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
					TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
				}
				BcMRfStatus->EcIo[k] = TempCopy;
			}
		}
		///////

		for ( k=chlist; k<6; k++ )
		{
			BcMRfStatus->PN_Vaule[k] = 0;
			BcMRfStatus->EcIo[k]	 = 0;
		}
		//========================================================================//

		FER_VAULE:
		//===========//
		// FER Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( j=0; j<i; j++ )
		{
			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
		}

		BcMRfStatus->FerValue = TempCopy;
		//========================================================================//

		//==========//
		// RX Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		if ( DataBuff[DataCnt2] == '-' )
		{
			DataCnt2++;
			for ( j=0; j<i-1; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			TempCopy = -TempCopy;
			BcMRfStatus->RxValue = TempCopy;
		}
		else
		{
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			BcMRfStatus->RxValue = TempCopy;
		}

		//========================================================================//
		if ( TempCopy > 0 ) return(FALSE);

		//==========//
		// TX Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		if ( DataBuff[DataCnt2] == '-' )
		{
			DataCnt2++;
			for ( j=0; j<i-1; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			TempCopy = -TempCopy;
			BcMRfStatus->TxValue = TempCopy;
		}
		else
		{
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			BcMRfStatus->TxValue = TempCopy;
		}

		//===========//
		// ADJ Value //
		//========================================================================//
		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == 0x0d ) break;
		if ( DataBuff[DataCnt2] == '-' )
		{
			DataCnt2++;
			for ( j=0; j<i-1; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			TempCopy = -TempCopy;
			BcMRfStatus->AdjValue = TempCopy;
			
		}
		else
		{
			for ( j=0; j<i; j++ )
			{
				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
			}
			BcMRfStatus->AdjValue = TempCopy;
		}
		//========================================================================//
	}
	return(TRUE);
}

INT8S BcMPilotStateCheck ( INT8U *DataBuff )
{
	INT8U 	i, j, DataCnt=0, DataCnt2=0, pw;
	INT8U   k;
	INT16S	TempCopy, Power;
	INT8U	uTemp;
 
	//============================//
	// Active Channel Ec/Io Value //
	//========================================================================//

	DataCnt = 0;
	TempCopy = 0;


	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
	for ( j=0; j<(DataCnt-1); j++ )
	{
		for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
		TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
	}
	BcMPilotStatus->PN_Vaule[0] = TempCopy;

	if (DataBuff[DataCnt] == '-' )DataCnt++;

	DataCnt2 = DataCnt;
	TempCopy = 0;
	k = DataCnt;		

 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
	for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
	if(i>(DataCnt-DataCnt2))	{k=DataCnt; i=DataCnt-DataCnt2-1;}			// 130304

	for ( j = DataCnt2; j < (k-1); j++ )
	{
		for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
		TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
	}
	BcMPilotStatus->EcIo[0] = TempCopy;
 
	DataCnt2 = DataCnt;
	TempCopy = 0;

	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
	for ( j=DataCnt2; j<(DataCnt-1); j++ )
	{
		for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
		TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
	}
	BcMPilotStatus->PN_Vaule[1] = TempCopy;;

	{
		
 		if (DataBuff[DataCnt] == '-' )DataCnt++;

		DataCnt2 = DataCnt;
		TempCopy = 0;
		k = DataCnt;
 
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
		for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
		if(i>(DataCnt-DataCnt2)) {k=DataCnt; i=DataCnt-DataCnt2-1;}				// 130304

		

		for ( j = DataCnt2; j < (k-1); j++ )
		{
 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
  		}
		BcMPilotStatus->EcIo[1] = TempCopy;;

 		DataCnt2 = DataCnt;
		TempCopy = 0;
		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;


		for ( j=DataCnt2; j<(DataCnt-1); j++ )
		{
			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
 		}
		BcMPilotStatus->PN_Vaule[2] = (INT8U )TempCopy;;
 	}

	
 	if (DataBuff[DataCnt] == '-' )DataCnt++;

	DataCnt2 = DataCnt;
	TempCopy = 0;
	k = DataCnt;		

	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
	for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
	if(i>(DataCnt-DataCnt2)) {k=DataCnt; i=DataCnt-DataCnt2-1;} 			// 130304
 
	for ( j = DataCnt2; j < (k-1); j++ )
	{
		for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
		TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
	}
	BcMPilotStatus->EcIo[2] = TempCopy;

	DataCnt2 = DataCnt;
	TempCopy = 0;

	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;

	for ( j=DataCnt2; j<(DataCnt-1); j++ )
	{
		for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
		TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
	}

	BcMPilotStatus->PN_Vaule[3] = TempCopy;

 // EcIO 3	
	if (DataBuff[DataCnt] == '-' )DataCnt++;

	DataCnt2 = DataCnt;
	TempCopy = 0;
	k = DataCnt;		

	for ( i=0; i<10; i++ )
	{
		uTemp = DataBuff[DataCnt++];
		if ((uTemp == ',') || (uTemp == NULL)|| (uTemp == 0x0d))	break;		// 130304
	}
	for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
	if(i>(DataCnt-DataCnt2))	{k=DataCnt; i=DataCnt-DataCnt2-1;}				// 130304


	for ( j = DataCnt2; j < (k-1); j++ )
	{
		for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
		TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
	}
	BcMPilotStatus->EcIo[3] = TempCopy;;
  	return(TRUE);
}


INT32S BcMdemTcpConnect(INT8U *ConnectIP, INT8U IPLen, INT32U PortNum)
{
    INT8U CmdStep = 0,result = 0;
	INT8U CmdStepCnt = 0;

	INT8U Tmp = FALSE;

	CmdStep = ModemTcpModeCmd;
	
TCP_INIT_SEQUENCE : 

	if( CmdStepCnt > 4) return FALSE;

	switch(CmdStep)
	{
		case ModemTcpModeCmd: 	BcMdemXmit(CdmaModemTcpModeCmd); 	result = 0; break;
		case ModemTcpIdCmd: 	BcMdemXmit(CdmaModemTcpIdCmd); 		result = 0; break;
		case ModemTcpPwCmd: 	BcMdemXmit(CdmaModemTcpPwCmd); 		result = 0; break;
		case ModemTcpConnect: 	BcMdemXmit(CdmaModemTcpConnect); 	result = 1; break;
		case ModemTcpOpenCmd: 	

			ConnectIP[IPLen] = 0; //Insert Null
			sprintf((char *)TxCdmaData, "%s%s,%d", CdmaModemTcpOpenCmd,ConnectIP, PortNum);
			BcMdemXmit((INT8U *)TxCdmaData);
	
			result = 2; 
		break;
	}
	OSTimeDly(500L);
	CmdStepCnt++;
	switch(result)
	{
		case 0:
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE;
			}
			else return FALSE;
			CmdStepCnt = 0;		
			Tmp = TRUE;
		break;

		case 1:
			if(BcMdemSyncProtocolCheck())
			{	
				if(BcMdemSyncCheck((char *)RxCdmaData) == 11)
				{
					Tmp = TRUE;
					break;  		//"CONNECT"	
				}
				if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE; 	//"OK"
			}
			else return FALSE;
			
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) != 11)return FALSE;
			}
			else return FALSE;
			CmdStepCnt = 0;		
			Tmp = TRUE;
		break;

		case 2:
			if(BcMdemSyncProtocolCheck())
			{
				if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE;
			}
			else return FALSE;
			
			if(BcMdemSyncProtocolCheck())
			{	
				if(BcMdemSyncCheck((char *)RxCdmaData) != 18)return FALSE;
				
			}
			else return FALSE;
			CmdStepCnt = 0;		
			Tmp = TRUE;
		break;
		
	}

	if(CmdStep == ModemTcpOpenCmd)return TRUE;
//	CmdStep++;
	if(	Tmp == TRUE )	CmdStep++;
	goto TCP_INIT_SEQUENCE;
}

INT32S BcMdemTcpExit(void)
{ 
	INT8U nRet = TRUE;
	
	BcMdemXmit(CdmaModemTcpCloseCmd);

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return 1;

	}
	else return FALSE;
	
	OSTimeDly(Time10mSec);

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 26)return 2;
	}
	else return FALSE;

	OSTimeDly(Time10mSec);
	
	BcMdemXmit(CdmaModemTcpExitCmd);

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return 3;
	}
	else return FALSE;

	OSTimeDly(Time10mSec);

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 12)return 4;
	}
	else return FALSE;

	return nRet;
}	

INT32S BcMdemSwReset(void)
{ 
	INT8U nRet = TRUE;
	
	BcMdemXmit(CdmaModemSwRstCmd);

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 27)return FALSE;
	}
	else return FALSE;

	OSTimeDly(Time10mSec);

	if(BcMdemSyncProtocolCheck())
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE;
	}
	else return FALSE;

	return nRet;
}	

// RETRUN DEFINE
// -1 : *SKT*ORI Error
// -2 : OK Error
// -3 : *SKT*VCALL Error
// -4 : *SKT*VOICECONNECT Error

INT32S BcMdemCalling(char *DstTel)
{ 
	INT16U i = 0, j = 0;
	INT8U Ptr[100];
	INT32S nRet = TRUE;
	
	sprintf((char *)TxCdmaData, "%s%s", CdmaCallingCmd, DstTel);

	BcMdemXmit((INT8U *)TxCdmaData);

	if(BcMdemSyncProtocolCheck()) // *SKT*ORI=
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 33)return -1; 
	}
	else return -1;

	if(BcMdemSyncProtocolCheck()) // OK
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return -2; 
	}
	else return -2;
	
	if(BcMdemSyncProtocolCheck()) // *SKT*VCALL:
	{
		for(i = 0; i < strlen(RspmsgCallAck);i++)Ptr[i] = RxCdmaData[i];
		Ptr[i] = 0;
		if(BcMdemSyncCheck((char *)Ptr) != 28)return -3;
		
		for(j = 0; j < strlen(DstTel); j++, i++)
		{
			if(DstTel[j] != RxCdmaData[i])return -3;
		}
	}
	else return -3;

	if(BcMdemSyncProtocolCheck()) // *SKT*VOICECONNECT
	{
		if(BcMdemSyncCheck((char *)RxCdmaData) != 29)return -4; 
	}
	else return -4;
	
	return nRet;
}


INT32S CdmaModemTrafficCheck(void)
{ 
	INT8U nRet = TRUE;
	
	nRet = BcMdemCommad(ModemTrafficCmd);

	return nRet;
}

INT32S CdmaModemHangUp(void)
{ 
	INT8U nRet = TRUE;
	
	nRet = BcMdemCommad(ModemHangUpCmd);

	return nRet;
}



INT32S ModemHangUp(void)
{ 
	INT8U nRet = TRUE;
	
	nRet = BcMdemCommad(ModemHangUpCommand);

	return nRet;
}




INT32S ModemLockOrder(void)
{ 
	INT8U nRet = TRUE;
	
	nRet = BcMdemCommad(ModemLockOrderCmd);

	return nRet;
}


INT32S ModemGMMLockOrder(void)
{ 
	INT8U nRet = TRUE;
	
	nRet = BcMdemCommad(ModemGMMLockOrderCmd);

	return nRet;
}

INT32S ModemPwrOFF(void)
{ 
	INT8U nRet = TRUE;
	
	nRet = BcMdemCommad(ModemPWROFFCmd);

	return nRet;
}



INT32S BcMdemCommad(INT8U Commad)
{
	INT16U i = 0;
	INT32S nlen = 0;
	INT32S nRet = 0;
	INT8U Ptr[100];
  
	switch(Commad)
	{
		case MsgReciveCmd: 			BcMdemXmit(CdmaMsgReciveCmd); 	break;
		case MsgCheckCmd: 			BcMdemXmit(CdmaMsgCheckCmd); 	break;
		case ModemTimeCmd: 			BcMdemXmit(CdmaModemTimeCmd); 	break;
		case ModemRfStsCmd: 		BcMdemXmit(CdmaModemRfStsCmd); 	break;
		case ModemHangUpCmd: 		BcMdemXmit(CdmaModemHangUpCmd); break;
		case ModemTrafficCmd:		BcMdemXmit(CdmaModemTrafficCmd);break;
		case ModemPilotCmd: 		BcMdemXmit(CdmaModemPilotCmd); 	break; 
		case ModemLockOrderCmd: 	BcMdemXmit(LockOrderCmd); 		break; 
		case ModemGMMLockOrderCmd: 	BcMdemXmit(GMMLockOrderCmd); 	break; 
		case ModemPWROFFCmd: 		BcMdemXmit(ModemPWROFF); 		break; 


		case ModemHangUpCommand: 	BcMdemXmit(PhoneHangUpCmd); break;


		default : return FALSE;
	}

	switch(Commad)
	{
		case MsgReciveCmd:
		
			if((nlen = BcMdemSyncProtocolCheck()) != FALSE)
			{
				nRet = BcMdemDataProtocolCheck(Commad);
				if(!nRet)return FALSE;
				if(nRet > 0) nRet = nlen;	// normal case 이면.. len을 return한다.
			}
			else return FALSE;
		break;	

		case ModemPilotCmd:
		case MsgCheckCmd: 	
		case ModemTimeCmd:
		case ModemRfStsCmd:
		case ModemTrafficCmd:
		case ModemPWROFFCmd:	
			if((nlen = BcMdemSyncProtocolCheck()) != FALSE)
			{
				nRet = BcMdemDataProtocolCheck(Commad);

				if(!nRet)return FALSE;
				if(!BcMdemSyncProtocolCheck())return FALSE;
				
				if((BcMdemSyncCheck((char *)RxCdmaData) != 14))	return FALSE;

				if(Commad == MsgCheckCmd)
				{
//					nRet = nlen;
				}
 				else if(Commad != ModemTrafficCmd)
				{
					if(nRet > 0) nRet = nlen;	// normal case 이면.. len을 return한다.
				}	
			}
			else return FALSE;
		break;	
 		case ModemHangUpCmd:
		case ModemHangUpCommand:
			
			if(BcMdemSyncProtocolCheck())
			{
				for(i = 0; i < strlen(RspmsgHangup);i++)Ptr[i] = RxCdmaData[i];
				Ptr[i] = 0;
				if(BcMdemSyncCheck((char *)Ptr) != 30)return FALSE;
				
				if(RxCdmaData[i] != '1')return FALSE;
			}
			else return FALSE;
			
		break; 
		case ModemLockOrderCmd:
			
			if(BcMdemSyncProtocolCheck())
			{
				for(i = 0; i < strlen(RspLockOrder);i++)Ptr[i] = RxCdmaData[i];
				Ptr[i] = 0;
				if(BcMdemSyncCheck((char *)Ptr) != 35)	return FALSE;

				{
					INT8U *tPtr = RxCdmaData;

					for(; i < 20; i++)
					{
						if(*tPtr == ',')
						{	
							*tPtr++;
							break;
						}
						else
						{
							tPtr++;

						}
						
//						Ser3Ptr->printf("[%c]",*tPtr);
					}
//					Ser3Ptr->printf("\n");
					
					LockOrder = atoh(*tPtr);
	//				Ser3Ptr->printf("RxCdmaData [%d][%d]>[%d]\n",i, *tPtr,LockOrder);
				}
			}
			else return FALSE;

			
		break; 
		case ModemGMMLockOrderCmd:
			if(BcMdemSyncProtocolCheck())
			{
				for(i = 0; i < strlen(RspGMMLockOrder);i++)Ptr[i] = RxCdmaData[i];
				Ptr[i] = 0;
				if(BcMdemSyncCheck((char *)Ptr) != 36)return FALSE;

				GMMLockOrder = atoh(RxCdmaData[i]);
			}
			else return FALSE;

			
		break; 

 	}
	return nRet;
}

INT32S BcdemTimeGet(BcMTimeStr *nPtr)
{
	INT8U i = 0;
	INT8U *tPtr = (INT8U *)nPtr;
	INT32S nRet = TRUE;
		
S_START:

	if(BcMRtryNo >= MaxTryNo) return FALSE;	// Max Try Error

	nRet = BcMdemCommad(ModemTimeCmd);

//	USART1Printf("1: BcdemTimeGet : [%d][%d]\n",BcMRtryNo,nRet);

	if(nRet == FALSE)
	{
		BcMRtryNo++;
		OSTimeDly(1500);
		goto S_START;
	}

	
	// mem init
	for(i = 0; i < sizeof(BcMTimeStr); i++)  *tPtr++ = 0;
	
	for(i = 0; i < 4; i++) nPtr->Year[i] = BcMpresentTime->Year[i];
	for(i = 0; i < 2; i++)
	{
		nPtr->Month[i]	= BcMpresentTime->Month[i];
		nPtr->Day[i]	= BcMpresentTime->Day[i];
		nPtr->Hour[i]	= BcMpresentTime->Hour[i];
		nPtr->Min[i]	= BcMpresentTime->Min[i];
		nPtr->Sec[i]	= BcMpresentTime->Sec[i];
	}	

	OSTimeDly(1500);
	return nRet;
}

INT32S BcdemRfStsGet(BcMRfStsStr *nPtr)
{
	INT8U i = 0;
//	INT16S *tPtr = (INT16S *)nPtr;
	INT8U *tPtr = (INT8U *)nPtr;

	INT32S nRet = TRUE;
//	USART1Printf("01 :BcdemRfStsGet : [%d][%x] \n", tPtr,&tPtr);

	
RF_START:
	if(BcMRtryNo >= MaxTryNo) return FALSE;	// Max Try Error

	nRet = BcMdemCommad(ModemRfStsCmd);

	if(nRet == FALSE)
	{
		BcMRtryNo++;
		OSTimeDly(1000);
		goto RF_START;
	}
	// mem init
//	for(i = 0; i < sizeof(BcMRfStsStr); i++)  *tPtr++ = 0;

	nPtr->ActChannel =	BcMRfStatus->ActChannel;
//	USART1Printf("01 :ActChannel : [%d][%d] \n", BcMRfStatus->ActChannel,nPtr->ActChannel);
	
	for(i = 0; i < 6; i++)
	{
		nPtr->PN_Vaule[i] 	= BcMRfStatus->PN_Vaule[i];
		nPtr->EcIo[i] 	  	= BcMRfStatus->EcIo[i];
		nPtr->PSC_Vaule[i]	= BcMRfStatus->PSC_Vaule[i];
	}

	nPtr->FerValue 	=	BcMRfStatus->FerValue;
	nPtr->RxValue 	=	BcMRfStatus->RxValue;
	nPtr->TxValue 	=	BcMRfStatus->TxValue;
	nPtr->AdjValue 	=	BcMRfStatus->AdjValue;

	nPtr->NumberOfChannel = BcMRfStatus->NumberOfChannel;
	nPtr->ActPN = BcMRfStatus->ActPN;	

	nPtr->PSClist 	= BcMRfStatus->PSClist;	
	nPtr->BER 		= BcMRfStatus->BER;	

	return nRet;
}

INT32S BcMdemFuncselect(void)
{
	// Modem Status Check.
////////////////////////////////////////////////////////////////////////////////////////	
	// error Case
	if(BcMRtryNo >= MaxTryNo)
	{
		TimeReqCnt = 0;
		BcMRtryNo = 0;
		return  MAX_TRY;
	}

	if(++TimeReqCnt > 5)
	{
		TimeReqCnt = 0;
		return SELF_TIME;
	}
	else if(TimeReqCnt%2)	return SELF_RECV;
	else					return SELF_SEND;
}

INT32S BcMdemRecv(INT8U *rbuf, INT8U *sTel, BcMTimeStr *rtime)
{
	INT32S len = 0;
	INT32S nRet = 0;
	// 0: Fail
	// -1: Not Data
	
S_START:

	if(BcMRtryNo >= MaxTryNo) return  FALSE;
	
	nRet = BcMdemCommad(MsgCheckCmd);

	if(nRet == FALSE)
	{
		BcMRtryNo++;
		OSTimeDly(1500);
		goto S_START;
	}
	else if(nRet == NOT_DATA)
	{
		nRet = NOT_DATA;
	}
	else if(nRet > 0)//(nRet == TRUE)										// protocol ok --> data read
	{
		nRet = BcMdemCommad(MsgReciveCmd);
		if(nRet == FALSE)
		{
			BcMRtryNo++;
			OSTimeDly(1500);
			goto S_START;
		}
		//else if(nRet < 0)
		//{
		//	nRet = len;
		//}
		else if(nRet > 0)
		{
			//len = len;
			// RxCdmaData
			{
				INT16U i = 0, cnt = 0, tcnt = 0;
				INT8U *tPtr = RxBcMData;

				////////////////////////////////////////////////////////////////
				for(i = 0; i < sizeof(BcMTimeStr); i++) *((INT8U *)rtime + i) = 0;
				//////////////////////////////////////////////////////////////////////
				for(i = 0; i < 4; i++, cnt++) rtime->Year[i] = *tPtr++;
				for(i = 0; i < 2; i++, cnt++) rtime->Month[i]= *tPtr++;
				for(i = 0; i < 2; i++, cnt++) rtime->Day[i]= *tPtr++;
				for(i = 0; i < 2; i++, cnt++) rtime->Hour[i]= *tPtr++;
				for(i = 0; i < 2; i++, cnt++) rtime->Min[i]= *tPtr++;
				for(i = 0; i < 2; i++, cnt++) rtime->Sec[i]= *tPtr++;

				*tPtr++; cnt++;		// ','
				
				for(; cnt < nRet; cnt++)
				{
					if(*tPtr != ',')
					{	
						if(tcnt == 0)
						{
							*sTel++ = *tPtr++;
						}
						else if(tcnt == 1) tPtr++;
						else if(tcnt == 2) tPtr++;
						else if(tcnt == 3) tPtr++;
						else
						{
							INT8U temp;
							temp = atoh(*tPtr++);
							temp = atoh(*tPtr++) + ( temp << 4 );
							rbuf[len++] = temp;
							cnt++;
						}
					}
					else
					{
						tPtr++;
						tcnt++;
					}
				}				
				nRet = len;
				rbuf[len++] = 0;	// null data insert
				*sTel++ = 0;		// null data insert

			//Ser0Printf(" rDATA: %s", RxBcMData);
			//Ser0Printf(" DATA: %s", rbuf);
			//Ser0Printf(" len: %d \n", nRet);
			}
		}
	}
	OSTimeDly(1500);

	return nRet;
}

INT32S BcdemPilotGet(BcMPilotStsStr *nPtr)
{
	INT8U i = 0;
//	INT16S *tPtr = (INT16S *)nPtr;
	INT8U *tPtr = (INT8U *)nPtr;
	INT32S nRet = TRUE;

	nRet = BcMdemCommad(ModemPilotCmd);
//	USART1Printf("01 :BcdemPilotGet : [%d][%x] \n", tPtr,&tPtr);

	// mem init
	for(i = 0; i < sizeof(BcMPilotStsStr); i++)  *tPtr++ = 0;

	for(i = 0; i < 4; i++)
	{
		nPtr->PN_Vaule[i] = BcMPilotStatus->PN_Vaule[i];
		nPtr->EcIo[i] 	  = BcMPilotStatus->EcIo[i];
 	}
	return nRet;
}

int vSprintf(char * buf, const char *fmt, ...)
{
	va_list args;
	int i;

	va_start(args, fmt);
	i=vsprintf(buf,fmt,args);
	va_end(args);
	return i;
}
#if 0

int snprintf(char *str,size_t count,const char *fmt,...)
{
	size_t ret;
	va_list ap;
    
	va_start(ap, fmt);
	ret = vsnprintf(str, count, fmt, ap);
	va_end(ap);
	return ret;
}
#endif


////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

