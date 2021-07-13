#define DOWNLOAD_C

#define ESCTime			Time1Sec*30L


INT16U	FrameCounterOld	= 0xFFFF;
INT16U	FrameCounter	= 0xFFFF;

INT16U	FrameCnt = 0xFFFF;
INT16U	TotFrame = 0xFFFF;
INT16U	Swcrc16 = 0;
INT32S	DataCount = 0xFFFFFFFF;


BOOL WRCS_ReceiveData(__ProtocolPtr *nPtr);
INT8U WRCS_DownloadFunc (__ProtocolPtr *nPtr);
unsigned char Check_Data_Image( unsigned char *_Dat );


INT32U WRCS_DownLoadGiveupTimerSet (INT32U dnFlag)
{
	if(dnFlag)
	{
		downloadFlag = dnFlag;
		TimerRegist(TimerEsc, ESCTime);	// 다운로드 포기 타이머 동작 //
	}
	
	return downloadFlag;
}

void WRCS_DownLoadGiveupTimerRst(void)
{
	downloadFlag = 0;
}

BOOL WRCS_DownLoadGiveupTimerChk(__ProtocolPtr *nPtr)
{
	if(nPtr == PcSer && TimeOverCheck(TimerEsc) )
	{
 		downloadFlag =  0;
 		return TRUE;
	}
	
	return FALSE;
}


INT8U WRCS_DownloadFunc (__ProtocolPtr *nPtr)
{

	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *rBody = &Recv->BodyFrame[Recv->cBody];

	INT8U tmpData[20] = {0,};
	INT8U tmpLen = 0;

    INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};

	switch(rBody->Command)
	{
		case DownloadMinNumCMD:
		{
			INT8U i;
			for(i = 0; i < sizeof(tDnrSts->MinNumber); i++)
			{
				tmpData[tmpLen++] = tDnrSts->MinNumber[i] ;
			}
			tmpData[tmpLen++] = 0x00;
			tmpData[tmpLen++] = 0x00;
			tmpData[tmpLen++] = 0x00;
			tmpData[tmpLen++] = 0x00;
		}
		break;



		case DownloadCMD:
		{
			tmpData[tmpLen++] = ACK;
			tmpData[tmpLen++] = rBody->SubData[0];	// version
			tmpData[tmpLen++] = rBody->SubData[1];	// 1st frame high
			tmpData[tmpLen++] = rBody->SubData[2];	// 2nd fram low
			TotFrame = ((rBody->SubData[1] << 8) | rBody->SubData[2]);
		}
		break;
		
		case DownloadCMDConfirm:
		{
			INT32U cpu_sr;
			OS_ENTER_CRITICAL();

			#ifdef __EXT_RAM_USED
				tmpData[tmpLen++] = ACK;
			#else
				if(!FLASHpAPBK_Check_Erase())
				{
					tmpData[tmpLen++] = NACK;
				}
				else	tmpData[tmpLen++] = ACK;
			#endif
			OS_EXIT_CRITICAL();
		}
		break;
		
		case DownLoadData:
			if(WRCS_ReceiveData(nPtr))
			{
				tmpData[tmpLen++] = ACK;
				FrameCnt = FrameCnt;
			}
			else
			{
				tmpData[tmpLen++] = NACK;
 			}
			tmpData[tmpLen++] = (INT8U)((FrameCnt >> 8) & 0xff);
			tmpData[tmpLen++] = (INT8U)((FrameCnt     ) & 0xff);

//			USART1Printf("FrameCnt[%d]\n",FrameCnt);
		break;
		
		case DownLoadDataConfirm:
			{
				INT16U tmpCRC;
				tmpCRC = (INT16U)((rBody->SubData[2] << 8) | rBody->SubData[3]);
				if((Swcrc16 == tmpCRC) && (TotFrame == FrameCnt + 1))	tmpData[tmpLen++] = ACK;
				else													tmpData[tmpLen++] = NACK;
				
			}
			tmpData[tmpLen++] = (INT8U)(TotFrame >> 8);
			tmpData[tmpLen++] = (INT8U)(TotFrame     );
			tmpData[tmpLen++] = (INT8U)(Swcrc16 >> 8 );
			tmpData[tmpLen++] = (INT8U)(Swcrc16      );
		break;
	}

	if(nPtr == PcSer)
	{
		GenBodyFrame(tid, (INT8U *)tmpData, tmpLen, rBody->Command, nPtr, 0);
		WRCS_ProDataAckTx(nPtr);
 	}
	else
	{
		TCPProDataAckTx(tid, (INT8U *)tmpData, tmpLen, rBody->Command, SmsSer);
 	}


	// Jump the boot.
	////////////////////////////////////////////////////////////////////////////
	// Download OpeSocketInforating
	///////////////////////////////
	// Down Load Ending


	switch(rBody->Command)
	{
		case DownloadCMDConfirm:
		break;

		case DownLoadDataConfirm:
			OSTimeDly(100);
			if(tmpData[0] == ACK)
			{
              	INT32U t = *((INT32U *)(__pAPBKAddr + 40));
				INT32U s = *((INT32U *)(__pAPBKAddr + 36));
				selfinfo *p = (selfinfo *)(__pAPBKAddr + (t-s));
				OSTimeDly(100);
 				if(!memcmp(p->infor[0], "TRIO-M", strlen("TRIO-M")))
 				{

					if(nPtr == SmsSer)	ResetCaseBackup(FWDownReset);
					OSTimeDly(100);
			#ifdef __EXT_RAM_USED
					DownloadFlagSetExtSRAM(DataCount);
			#else
					DownloadFlagSet(DataCount);
			#endif
					DownLoadBootingJump();
				}
			}
		break;
	}
  
	return TRUE;
}


BOOL WRCS_ReceiveData(__ProtocolPtr *nPtr)
{
 	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody];
		
	INT16U	tmpFrameCnt = 0;
	INT32U	tmpLength = 0;
	INT32S	err = 0;

    INT8U Start_Inx = 0;

	// get the download Frame number
	tmpFrameCnt = BodyFrame->SubData[0];
	tmpFrameCnt = (tmpFrameCnt << 8) | BodyFrame->SubData[1];		// Frame Number

	if ( tmpFrameCnt == 0 )
	{

		if( ImgKind == NO_IMG)	Start_Inx = 0;
		else					Start_Inx = 32;
		
		DataCount = 0;
		Swcrc16 = 0;

	}
	else
	{	// frame Number Check old != current
		if((tmpFrameCnt != (FrameCnt + 1))) return FALSE;
		else
		{
			if(tmpFrameCnt == FrameCnt) return TRUE;
		}
	}

	// Download Data Length : length - 2(frame number 2byte)
	tmpLength = BodyFrame->SubLength - 2;
	if(nPtr == SmsSer)
	{
#ifdef __EXT_RAM_USED
		err = DataCount = UpLoadExtSRAM((INT8U *)&BodyFrame->SubData[2]+ Start_Inx, tmpLength - Start_Inx, DataCount);
#else
		err = DataCount = UpLoadData((INT8U *)&BodyFrame->SubData[2]+ Start_Inx, tmpLength - Start_Inx, DataCount);

#endif
	}
	else
	{
#ifdef __EXT_RAM_USED
		err = DataCount = UpLoadExtSRAM((INT8U *)&BodyFrame->SubData[2], tmpLength, DataCount);
#else
		err = DataCount = UpLoadData((INT8U *)&BodyFrame->SubData[2]+ Start_Inx, tmpLength - Start_Inx, DataCount);
#endif
	}

	Swcrc16 = Crc16Calc((INT8U*)&BodyFrame->SubData[2], tmpLength, Swcrc16);

	FrameCnt = tmpFrameCnt;
	err = 0;

	if(err == -1) return FALSE;
	
	return TRUE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

