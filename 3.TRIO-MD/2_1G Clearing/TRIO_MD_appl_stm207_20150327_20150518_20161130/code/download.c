#define DOWNLOAD_C

//#define ESCTime			Time1Sec*20L
#define ESCTime			Time1Sec*30L

INT16U	FrameCounterOld	= 0xFFFF;
INT16U	FrameCounter	= 0xFFFF;

INT16U	FrameCnt = 0xFFFF;
INT16U	TotFrame = 0xFFFF;
INT16U	Swcrc16 = 0;
INT32S	DataCount = 0xFFFFFFFF;
INT8U	scriptIndex = 0;

INT16U	FastFrameCnt = 0;

///////////////////////////////////
INT8U DownLoadTargetID = 0;

INT8U ImageCheck = 0;
INT8U ImageHeadCheck = 32;
INT8U ImageTailCheck = 14;

INT8U AmpImageCheck = 0;
INT16U recvLengthInit = 0;
INT32U DownLoadTotalSize = 0;

////////////////////////////////////////


BOOL DnReceiveData(__ProtocolPtr *nPtr);

INT8U DownloadFunc (__ProtocolPtr *nPtr);
BOOL ModuleDnReceiveData(__ProtocolPtr *nPtr);


#define __EXT_RAM_USED

//#define __pAPBK_SRAMAddr        ((u32)&*((u8 *)(Bank1_SRAM1_ADDR)) + ((512-(256-32))*1024L))  

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
	TcpData = RESET;
}

BOOL DownLoadGiveupTimerChk(__ProtocolPtr *nPtr)
{
	if(nPtr == PcSer && TimeOverCheck(TimerEsc) )
	{
 		downloadFlag =  0;
		TcpData = RESET;
 		return TRUE;
	}
	return FALSE;
}

BOOL DownLoadGiveupTimerChk1(__ProtocolPtr *nPtr)
{
	if(nPtr == PcSer && TimeOverCheck(TimerEsc) )
	{
 		downloadFlag =  0;
		TcpData = RESET;
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

			
//			if( rBody->SubID[2] == 0xff)
			if(DownLoadTargetID == RCUID)
			{
				
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
			
			}
			else
			{
				tmpData[tmpLen++] = ACK;
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

/////////////////////
		case ModuleDownloadCMD:
			tmpData[tmpLen++] = rBody->SubData[0];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[1];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[2];	// Module ID
			tmpData[tmpLen++] = ACK;
			tmpData[tmpLen++] = rBody->SubData[3];	// version
			tmpData[tmpLen++] = rBody->SubData[4];	// 1st frame high
			tmpData[tmpLen++] = rBody->SubData[5];	// 2nd fram low
			
			TotFrame = ((rBody->SubData[1] << 8) | rBody->SubData[2]);
		break;
		
		case ModuleDownloadCMDConfirm:
			tmpData[tmpLen++] = rBody->SubData[0];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[1];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[2];	// Module ID

			if(DownLoadTargetID == RCUID)
			{
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
			
			}
			else
			{
				tmpData[tmpLen++] = ACK;
			}
			
/*
			if( rBody->SubID[2] == 0xff)
			{
				
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
			
			}
			else
			{
				tmpData[tmpLen++] = ACK;
			}
*/
		break;
		
		case ModuleDownLoadData:
			tmpData[tmpLen++] = rBody->SubData[0];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[1];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[2];	// Module ID

			if(ModuleDnReceiveData(nPtr))
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
		
		case ModuleDownLoadDataConfirm:
			tmpData[tmpLen++] = rBody->SubData[0];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[1];	// Module ID
			tmpData[tmpLen++] = rBody->SubData[2];	// Module ID

			{
				INT16U tmpCRC;
				tmpCRC = (INT16U)((rBody->SubData[5] << 8) | rBody->SubData[6]);
				if((Swcrc16 == tmpCRC))	tmpData[tmpLen++] = ACK;
				else					tmpData[tmpLen++] = NACK;
			}

			tmpData[tmpLen++] = (INT8U)(FrameCnt+1 >> 8);
			tmpData[tmpLen++] = (INT8U)(FrameCnt+1	 );

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
			pUSART3.printf("0 : DownLoadDataConfirm = [%d][%x] \n", tmpData[0],DownLoadTargetID);

			if( rBody->SubID[2] == 0xff)
			{
				if(DownLoadTargetID == FPGAID)
				{
					OSTimeDly(10L);
					iFPGAConfig_DnFlagSet(DataCount, Swcrc16);
					DownLoadBootingJump();
				}
				else if(DownLoadTargetID == FILTERID)
				{
					u8 *tptr = (u8 *)(__pAPBK_SRAMAddr);
	
					FilterRxCheck(tptr,DataCount);
					
					if( tDnrSts->FilterStart == Enable)
					{
						OSTimeDly(100L);
						DownLoadBootingJump();
					}
					else
					{
						FilterOperating();
					}
				}
				else if(DownLoadTargetID == DNTESTID)
				{
					OSTimeDly(10L);
					iFPGAConfig_DnFlagSet(DataCount, Swcrc16);
					DownLoadBootingJump();
				}
				else
				{
					pUSART3.printf("1: DownLoadDataConfirm = %d \n", tmpData[0]);

					if(tmpData[0] == ACK)
					{
						INT32U t = *((INT32U *)(__pAPBK_SRAMAddr + 40));	// jump base addr + selfaddinfo address
						INT32U s = *((INT32U *)(__pAPBK_SRAMAddr + 36));	// jump base addr!!
						selfinfo *p = (selfinfo *)(__pAPBK_SRAMAddr + (t-s));

						pUSART3.printf("2: DataCount = [%s][%s] \n", p->infor[0],convinfo.infor[0]);

						if(!memcmp(p->infor[0], convinfo.infor[0], strlen(convinfo.infor[0])))
						{
							if((nPtr == SmsSer)||(nPtr == ModemSer))ResetCaseBackup(FWDownReset);
							DownloadFlagSetExtSRAM(DataCount);
							OSTimeDly(100L);
							DownLoadBootingJump();
						}
					}
				}
/*
				if(tmpData[0] == ACK)
				{
					INT32U t = *((INT32U *)(__pAPBK_SRAMAddr + 40));	// jump base addr + selfaddinfo address
					INT32U s = *((INT32U *)(__pAPBK_SRAMAddr + 36));	// jump base addr!!
					selfinfo *p = (selfinfo *)(__pAPBK_SRAMAddr + (t-s));

					if(!memcmp(p->infor[0], convinfo.infor[0], strlen(convinfo.infor[0])))
					{
						if((nPtr == SmsSer)||(nPtr == ModemSer))ResetCaseBackup(FWDownReset);
						DownloadFlagSetExtSRAM(DataCount);
						OSTimeDly(100L);
						DownLoadBootingJump();
					}
				}
*/				
			}
			else if( rBody->SubID[2] == 0x00)
			{
				OSTimeDly(10L);
				iFPGAConfig_DnFlagSet(DataCount, Swcrc16);
				DownLoadBootingJump();
			}
			else
			{
			}
		break;
		
		case ModuleDownLoadDataConfirm:
			{
				u8 *tptr = (u8 *)(__pAPBK_SRAMAddr);

				FilterRxCheck(tptr,DataCount);
				
				if( tDnrSts->FilterStart == Enable)
				{
					OSTimeDly(100L);
					DownLoadBootingJump();
				}
				else
				{
					FilterOperating();
				}
			}
		break;		
	}
	return TRUE;
}


BOOL DnReceiveData(__ProtocolPtr *nPtr)
{
 	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody];
		
	INT16U	tmpFrameCnt = 0;
	INT32U	tmpLength = 0;
	INT32U	recvLength = 0;
	
	INT32S	err = 0;
	INT32S	i = 0;

    INT8S Module_Chk = 0;

	// get the download Frame number

//	INT8U tmpID = BodyFrame->SubID[2];		///////

	tmpFrameCnt = BodyFrame->SubData[0];		// FIX!!
	tmpFrameCnt = (tmpFrameCnt << 8) | BodyFrame->SubData[1];		// Frame Number
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
	
	if(tmpFrameCnt == 0)
	{
		if(BodyFrame->SubData[2] == '#' && BodyFrame->SubData[3] == '#' && BodyFrame->SubData[4] == '#')
		{
			if(BodyFrame->SubData[10] == '#' && BodyFrame->SubData[11] == 'F' && BodyFrame->SubData[12] == 'P'
				&BodyFrame->SubData[13] == 'G' && BodyFrame->SubData[14] == 'A')
			{
				DownLoadTargetID = FPGAID;

				pUSART3.printf("FPGA[%d][%d]\n",DownLoadTargetID,tmpLength);
			}
			else if(BodyFrame->SubData[10] == '#' && BodyFrame->SubData[11] == 'F' && BodyFrame->SubData[12] == 'I'
					&&BodyFrame->SubData[13] == 'L' && BodyFrame->SubData[14] == 'T' && BodyFrame->SubData[15] == 'E'
					&&BodyFrame->SubData[16] == 'R')	
			{
				DownLoadTargetID = FILTERID;

				pUSART3.printf("FILTER[%d][%d]\n",DownLoadTargetID,tmpLength);
			}
			else if(BodyFrame->SubData[10] == '#' && BodyFrame->SubData[11] == 'R' && BodyFrame->SubData[12] == 'C'
					&&BodyFrame->SubData[13] == 'U' && BodyFrame->SubData[14] == '0' && BodyFrame->SubData[15] == '0'
					&&BodyFrame->SubData[16] == '0')	
			{
				DownLoadTargetID = RCUID;

				pUSART3.printf("RCUID[%d][%d]\n",DownLoadTargetID,tmpLength);
			}

			else if(BodyFrame->SubData[10] == '#' && BodyFrame->SubData[11] == 'T' && BodyFrame->SubData[12] == 'E'
					&&BodyFrame->SubData[13] == 'S' && BodyFrame->SubData[14] == 'T' && BodyFrame->SubData[15] == '0'
					&&BodyFrame->SubData[16] == '0')	
			{
				DownLoadTargetID = DNTESTID;
				pUSART3.printf("DNTESTID [%d][%d]\n",DownLoadTargetID,tmpLength);
			}
			else
			{
				pUSART3.printf("FALSE\n");

				return FALSE;
			}

			Module_Chk = 32;
			ImageCheck = SET;
		}
		else
		{
			ImageCheck = RESET;
			DownLoadTargetID = RCUID;
		}

		recvLengthInit = recvLength;
		DownLoadTotalSize = atoh(BodyFrame->SubData[2+24])*10000000 + atoh(BodyFrame->SubData[2+25])*1000000 
			+ atoh(BodyFrame->SubData[2+26])*100000 + atoh(BodyFrame->SubData[2+27])*10000 + atoh(BodyFrame->SubData[2+28])*1000 
			+ atoh(BodyFrame->SubData[2+29])*100 + atoh(BodyFrame->SubData[2+30])*10 + atoh(BodyFrame->SubData[2+31])*1;
	}

	for (i = 0; i< tmpLength; i++)
	{
		DownPageData[i] = BodyFrame->SubData[2+i+Module_Chk];
	}

	if(DownLoadTargetID == FPGAID)
	{
		INT8U rval = FALSE;
	
		_DTU_SEL0 = SET;

		rval = sFLASH_CS1_BL4kCheckErase(sFLASH_APBKAddr + DataCount, tmpLength- Module_Chk);
		if(rval == TRUE){
			rval= sFLASH_CS1_DataWrite(sFLASH_APBKAddr + DataCount, DownPageData, tmpLength- Module_Chk);
		}
		DataCount += (tmpLength - Module_Chk);
		pUSART3.printf("DataCount = %d \n", DataCount);
		
		if(rval == FALSE) err = -1;
	}
	else if(DownLoadTargetID == FILTERID)
	{
		INT8U rval = FALSE;
	
		_DTU_SEL0 = SET;

		rval = sFLASH_CS0_BL4kCheckErase(sFLASH_APBKAddr + DataCount, tmpLength- Module_Chk);
		if(rval == TRUE){
			rval= sFLASH_CS0_DataWrite(sFLASH_APBKAddr + DataCount, DownPageData, tmpLength- Module_Chk);
		}

		DataCount += (tmpLength - Module_Chk);

		pUSART3.printf("DataCount = %d \n", DataCount);
		
		if(rval == FALSE) err = -1;
	}
	else if(DownLoadTargetID == DNTESTID)
	{
		INT8U rval = FALSE;
	
		_DTU_SEL0 = SET;

		rval = sFLASH_CS0_BL4kCheckErase(sFLASH_APBKAddr + DataCount, tmpLength- Module_Chk);
		if(rval == TRUE){
			rval= sFLASH_CS0_DataWrite(sFLASH_APBKAddr + DataCount, DownPageData, tmpLength- Module_Chk);
		}

		DataCount += (tmpLength - Module_Chk);
		pUSART3.printf("DNTESTID DataCount = %d \n", DataCount);
		
		if(rval == FALSE) err = -1;
	}
	
	else 
	{
		INT32U upLdAddr = (__pAPBK_SRAMAddr + DataCount);
		err = DataCount = ExtSRAM_DataWrite(upLdAddr,DownPageData, tmpLength - Module_Chk, DataCount);

		pUSART3.printf("RCU DataCount = [%x] [%d][%d] \n", upLdAddr,DataCount,tmpLength);
	}
	
	Swcrc16 = Crc16Calc((INT8U*)&BodyFrame->SubData[2], tmpLength, Swcrc16);
	FrameCnt = tmpFrameCnt;

	if(err == -1) return FALSE;
	return TRUE;
}


BOOL ModuleDnReceiveData(__ProtocolPtr *nPtr)
{
 	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody];
		
	INT16U	tmpFrameCnt = 0;
	INT32U	tmpLength = 0;
	INT32U	recvLength = 0;

	INT32S	err = 0;
	INT32S	i = 0;

	INT32U upLdAddr;
    INT8U Module_Inx = 3;
    INT8S Module_Chk = 0;

	INT8U tmpID = BodyFrame->SubID[2];		///////

	tmpFrameCnt = BodyFrame->SubData[Module_Inx + 0];		// FIX!!
	tmpFrameCnt = (tmpFrameCnt << 8) | BodyFrame->SubData[Module_Inx + 1];		// Frame Number
	tmpLength = BodyFrame->SubLength - 2 - Module_Inx;

//	pUSART3.printf("0 : SubData =[%x][%x][%x][%x][%x]>[%d][%d]\n", BodyFrame->SubData[0],BodyFrame->SubData[1],BodyFrame->SubData[2],
//		BodyFrame->SubData[3],BodyFrame->SubData[4],tmpFrameCnt,tmpLength);

	if ( tmpFrameCnt == 0 )
	{
		// counter initialize when tmpFramecnt == 0.
		DataCount = 0;
		Swcrc16 = 0;
	}

	if(tmpFrameCnt == 0)
	{
		if(BodyFrame->SubData[Module_Inx + 2] == '#' && BodyFrame->SubData[Module_Inx + 3] == '#' && BodyFrame->SubData[Module_Inx + 4] == '#')
		{
			if(BodyFrame->SubData[Module_Inx + 10] == '#' && BodyFrame->SubData[Module_Inx + 11] == 'F' && BodyFrame->SubData[Module_Inx + 12] == 'P'
				&BodyFrame->SubData[Module_Inx + 13] == 'G' && BodyFrame->SubData[Module_Inx + 14] == 'A')
			{
				DownLoadTargetID = FPGAID;
//				pUSART3.printf("FPGA[%d]\n",DownLoadTargetID);
			}
			else if(BodyFrame->SubData[Module_Inx + 10] == '#' && BodyFrame->SubData[Module_Inx + 11] == 'F' && BodyFrame->SubData[Module_Inx + 12] == 'I'
					&&BodyFrame->SubData[Module_Inx + 13] == 'L' && BodyFrame->SubData[Module_Inx + 14] == 'T' && BodyFrame->SubData[Module_Inx + 15] == 'E'
					&&BodyFrame->SubData[Module_Inx + 16] == 'R')	
			{
				DownLoadTargetID = FILTERID;
//				pUSART3.printf("FILTER[%d]\n",DownLoadTargetID);
			}
			else if(BodyFrame->SubData[Module_Inx + 10] == '#' && BodyFrame->SubData[Module_Inx + 11] == 'R' && BodyFrame->SubData[Module_Inx + 12] == 'C'
					&&BodyFrame->SubData[Module_Inx + 13] == 'U' && BodyFrame->SubData[Module_Inx + 14] == '0' && BodyFrame->SubData[Module_Inx + 15] == '0'
					&&BodyFrame->SubData[Module_Inx + 16] == '0')	
			{
				DownLoadTargetID = FILTERID;
//				pUSART3.printf("FILTER[%d]\n",DownLoadTargetID);
			}

			Module_Chk = 32;

			ImageCheck = SET;
		}
		else
		{
			ImageCheck = RESET;

			if(tmpID == FPGAID)
			{
				DownLoadTargetID = FPGAID;
			}
			else
			{
				DownLoadTargetID = FILTERID;
			}

			DownLoadTargetID = FILTERID;
			
//			pUSART3.printf("DownLoadTargetID [%d][%d]##\n",DownLoadTargetID,tmpID);
		}

		recvLengthInit = recvLength;
		DownLoadTotalSize = atoh(BodyFrame->SubData[Module_Inx + 2+24])*10000000 + atoh(BodyFrame->SubData[Module_Inx + 2+25])*1000000 
			+ atoh(BodyFrame->SubData[Module_Inx + 2+26])*100000 + atoh(BodyFrame->SubData[Module_Inx + 2+27])*10000 + atoh(BodyFrame->SubData[Module_Inx + 2+28])*1000 
			+ atoh(BodyFrame->SubData[Module_Inx + 2+29])*100 + atoh(BodyFrame->SubData[Module_Inx + 2+30])*10 + atoh(BodyFrame->SubData[Module_Inx + 2+31])*1;

//		pUSART3.printf("atoh[%d][%d][%d][%d][%d]>[%d]\n",atoh(BodyFrame->SubData[Module_Inx + 2+27]),atoh(BodyFrame->SubData[Module_Inx + 2+28]),atoh(BodyFrame->SubData[Module_Inx + 2+29]),atoh(BodyFrame->SubData[Module_Inx + 2+30]),atoh(BodyFrame->SubData[Module_Inx + 2+31]),DownLoadTotalSize);
	}

	tmpLength = tmpLength - Module_Chk; 
//	pUSART3.printf("tmpLength>[%d]\n",tmpLength);

	for (i=0; i< tmpLength; i++)
	{
		DownPageData[i] = BodyFrame->SubData[Module_Inx + 2 + i + Module_Chk];
	}


	if(DownLoadTargetID == FPGAID)
	{
		INT8U rval = FALSE;

		_DTU_SEL0 = SET;
		
		rval = sFLASH_CS1_BL4kCheckErase(sFLASH_APBKAddr + DataCount, tmpLength);
		if(rval == TRUE){
			rval= sFLASH_CS1_DataWrite(sFLASH_APBKAddr + DataCount, DownPageData, tmpLength);
		}
		DataCount += tmpLength;
//		pUSART3.printf("0 : FPGA DataCount = %d \n", DataCount);
		
		if(rval == FALSE) err = -1;
	}
	else 
	{
		upLdAddr = (__pAPBK_SRAMAddr + DataCount);
		err = DataCount = ExtSRAM_DataWrite(upLdAddr,DownPageData, tmpLength, DataCount);
//		pUSART3.printf("0 : Module DataCount = %d \n", DataCount);
	}

	Swcrc16 = Crc16Calc((INT8U*)&BodyFrame->SubData[Module_Inx+ 2], (tmpLength + Module_Chk), Swcrc16);
	FrameCnt = tmpFrameCnt;

	if(err == -1) return FALSE;
	return TRUE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

