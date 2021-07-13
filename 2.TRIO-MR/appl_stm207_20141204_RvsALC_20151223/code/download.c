#define DOWNLOAD_C

#define ESCTime			Time1Sec*20L

INT16U	FrameCounterOld	= 0xFFFF;
INT16U	FrameCounter	= 0xFFFF;

INT16U	FrameCnt = 0xFFFF;
INT16U	TotFrame = 0xFFFF;
INT16U	Swcrc16 = 0;
INT32S	DataCount = 0xFFFFFFFF;
INT8U	scriptIndex = 0;

BOOL DnReceiveData(__ProtocolPtr *nPtr);
INT8U DownloadFunc (__ProtocolPtr *nPtr);

INT32U DownLoadGiveupTimerSet (INT32U dnFlag)
{
	if(dnFlag)
	{
		downloadFlag = dnFlag;
		TimerRegist(TimerEsc, ESCTime);	// 다운로드 포기 타이머 동작 //
	}
	return downloadFlag;
}

void DownLoadGiveupTimerRst(void)
{
	downloadFlag = 0;
}

BOOL DownLoadGiveupTimerChk(__ProtocolPtr *nPtr)
{
	if(nPtr == PcSer && TimeOverCheck(TimerEsc) )
	{
 		downloadFlag =  0;
 		return TRUE;
	}
	return FALSE;
}

BOOL DownLoadGiveupTimerChk1(__ProtocolPtr *nPtr)
{
	if(nPtr == PcSer && TimeOverCheck(TimerEsc) )
	{
 		downloadFlag =  0;
 		return TRUE;
	}
	return FALSE;
}


INT8U DownloadFunc (__ProtocolPtr *nPtr)
{
#if 0
	SIO *Recv = nPtr->Recv;

	INT8U tmpData[10] = {0,};
	INT8U tmpLen = 0;
#endif
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
			tmpData[tmpLen++] = ACK;
			tmpData[tmpLen++] = rBody->SubData[0];	// version
			tmpData[tmpLen++] = rBody->SubData[1];	// 1st frame high
			tmpData[tmpLen++] = rBody->SubData[2];	// 2nd fram low
			
			TotFrame = ((rBody->SubData[1] << 8) | rBody->SubData[2]);
		break;
		
		case DownloadCMDConfirm:
			{
				//INT32U cpu_sr;
				//OS_ENTER_CRITICAL();
			#ifdef __EXT_RAM_USED
					tmpData[tmpLen++] = ACK;
			#else
					if(!FLASHpAPBK_Check_Erase())
					{
						tmpData[tmpLen++] = NACK;
					}
					else
						tmpData[tmpLen++] = ACK;
			#endif

				//OS_EXIT_CRITICAL();
			}
		break;
		
		case DownLoadData:
			if(DnReceiveData(nPtr))
			{
				tmpData[tmpLen++] = ACK;
			}
			else
			{
				tmpData[tmpLen++] = NACK;
			}
			tmpData[tmpLen++] = (INT8U)((FrameCnt >> 8) & 0xff);
			tmpData[tmpLen++] = (INT8U)((FrameCnt	  ) & 0xff);

		break;
		
		case DownLoadDataConfirm:
			{
				INT16U tmpCRC;
				tmpCRC = (INT16U)((rBody->SubData[2] << 8) | rBody->SubData[3]);
				if((Swcrc16 == tmpCRC) && (TotFrame == FrameCnt + 1))	tmpData[tmpLen++] = ACK;
				else													tmpData[tmpLen++] = NACK;
			}
			tmpData[tmpLen++] = (INT8U)(TotFrame >> 8);
			tmpData[tmpLen++] = (INT8U)(TotFrame	 );
			tmpData[tmpLen++] = (INT8U)(Swcrc16 >> 8 );
			tmpData[tmpLen++] = (INT8U)(Swcrc16 	 );
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
		case DownLoadDataConfirm:
			if(tmpData[0] == ACK)
			{
#ifdef __EXT_RAM_USED
//			INT32U t = *((INT32U *)(__pAPBK_SRAMAddr + 40));	// jump base addr + selfaddinfo address
//			INT32U s = *((INT32U *)(__pAPBK_SRAMAddr + 36));	// jump base addr!!
//				selfinfo *p = (selfinfo *)(__pAPBK_SRAMAddr + (t-s));
#else
			INT32U t = *((INT32U *)(__pAPBKAddr + 40)); // jump base addr + selfaddinfo address
			INT32U s = *((INT32U *)(__pAPBKAddr + 36)); // jump base addr!!
			selfinfo *p = (selfinfo *)(__pAPBKAddr + (t-s));
#endif

// 				if(!memcmp(p->infor[0], "TRIO-M", strlen("TRIO-M")))

				if(!memcmp(p->infor[0], convinfo.infor[0], strlen(convinfo.infor[0])))
				{
				
#ifdef __PWR_BACKUP_USED
					//BKP_WriteBackupRegister(BKP_DR1, 0x02);
					//PWR_BackupAccessCmd(ENABLE);
					//SerPtr->printf("BKP_DR1 = %d\n", BKP_ReadBackupRegister(BKP_DR1));
#endif
					if(nPtr == SmsSer)	ResetCaseBackup(FWDownReset);

					//SerPtr->printf("rambackup = %d\n", rambackup[0]);

					//WriteEEprom(ResetCaseBp, );
				//#ifdef __EXT_RAM_USED
				//		DownloadFlagSetExtSRAM(DataCount);
				//#else
					OSTimeDly(50L);
					DownloadFlagSet(DataCount);
				//#endif
					OSTimeDly(100L);
					DownLoadBootingJump();
				}
			}
		break;
	}
	return TRUE;

}


BOOL DnReceiveData(__ProtocolPtr *nPtr)
{
#if 0
	SIO *Recv = nPtr->Recv;
		
	INT16U	tmpFrameCnt = 0;
	INT32U	tmpLength = 0;
	INT32S	err = 0;
#endif
 	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody];
		
	INT16U	tmpFrameCnt = 0;
	INT32U	tmpLength = 0;
	INT32S	err = 0;

    INT8U Start_Inx = 0;

	// get the download Frame number

	Start_Inx = Start_Inx;

	tmpFrameCnt = BodyFrame->SubData[0];		// FIX!!
	tmpFrameCnt = (tmpFrameCnt << 8) | BodyFrame->SubData[1];		// Frame Number
//	tmpLength = ((BodyFrame->DataLength[0] << 8) | BodyFrame->DataLength[1]) - 2;
	tmpLength = BodyFrame->SubLength - 2;

	if ( tmpFrameCnt == 0 )
	{
		// counter initialize when tmpFramecnt == 0.
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


//#ifdef __EXT_RAM_USED
//		err = DataCount = UpLoadExtSRAM((INT8U *)&Recv->Data[2], tmpLength, DataCount);
//#else
		err = DataCount = UpLoadData(__pAPBKAddr, (INT8U *)&BodyFrame->SubData[2], tmpLength, DataCount);
//#endif
	Swcrc16 = Crc16Calc((INT8U*)&BodyFrame->SubData[2], tmpLength, Swcrc16);
	FrameCnt = tmpFrameCnt;

	if(err == -1) return FALSE;
	return TRUE;
}



#if 0
BOOL WRCS_ReceiveData(__N_ProtocolPtr *nPtr)
{
 	NMS *Recv = nPtr->Recv;
		
	INT16U	tmpFrameCnt = 0;
	INT32U	tmpLength = 0;
	INT32S	err = 0;

	// get the download Frame number
	tmpFrameCnt = Recv->Data[0];		// FIX!!
	tmpFrameCnt = (tmpFrameCnt << 8) | Recv->Data[1];		// Frame Number

	if ( tmpFrameCnt == 0 )
	{
		// counter initialize when tmpFramecnt == 0.
		DataCount = 0;
		Swcrc16 = 0;
		//FrameCnt = 0xFFFF;
	}
	else
	{	// frame Number Check old != current
		if(tmpFrameCnt == FrameCnt) return TRUE;
		if((tmpFrameCnt != (FrameCnt + 1))) return FALSE;
	}

	//tmpLength = 512;
	tmpLength = Recv->SubDataLength - 2;

	err = DataCount = UpLoadData(__pAPBKAddr, (INT8U *)&Recv->Data[2], tmpLength, DataCount);
	Swcrc16 = Crc16Calc((INT8U*)&Recv->Data[2], tmpLength, Swcrc16);

	FrameCnt = tmpFrameCnt;

	if(err == -1) return FALSE;
	return TRUE;
}
#endif
////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

