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
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 *
 ******************************************************************************/
#define SMS_C

#include "../include/main.h"
//#include <ctype.h>

#define __SmsDebug

extern INT8U DownLoadTargetID;
extern INT8U ImageCheck;
extern INT32U DownLoadTotalSize;
extern INT32S	DataCount;

void SmsInit(void)
{
	SmsSer = &SmsSerB;
	ModemSer = &ModemSerB;

 	SmsSer->CheckByte 		= pUSART4.CheckByte;
	SmsSer->RxGetByte 		= pUSART4.RxGetByte;
	SmsSer->PutStr 			= pUSART4.PutStr;
	SmsSer->TxCheckByte 	= pUSART4.TxCheckByte;

	SmsSer->TimerRx 		= TimerSmsRx;
	SmsSer->TimerEndWait	= TimerSmsEndWait;

	SmsSer->WRCSRecv 		= &Rtcpsms;
	SmsSer->WRCSSend 		= &Stcpsms;

	SmsSer->SmsRecv 		= &Rwrcssms;
	SmsSer->SmsSend 		= &Swrcssms;	

 	ModemSer->CheckByte 	= AnyCheckByte;
	ModemSer->RxGetByte 	= AnyRxGetByte;
	ModemSer->TimerRx 		= TimerTcpRx;

	ModemSer->WRCSRecv 		= &RTcpBuff;

	SmsSer->OSSem = OSSemCreate(1);
	
	CdmaSem = OSSemCreate(1);				

	OSTaskCreate(DnrSmsTask, (void *)NULL, (OS_STK *)&CDMATaskStk[CDMA_START_STK_SIZE-1], SMSTASK_PRIO);
}


void ResetPeriodSet(void)
{
	TimerRegist(TimerSmsFirstTx, Time1Sec*540L); // 9min

	OSTimeDly(1000L);
	
	SmsResetPeriodFlag = FALSE; //Reset 주기 체크 한다.
}

INT32S CdmaFuncselect(void)
{
	// Modem Status Check.
////////////////////////////////////////////////////////////////////////////////////////	
	// error Case

	if(BcMRtryNo >= MaxTryNo)
	{	
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

//	return SELF_RECV;
}

void DnrSMS2Data(void)
{
	__Dnr_Sts *Sts = tDnrSts;


	memcpy((INT8U *)&Sts->MinNumber, BcMSrcTel, 11);
	
	if( ModemType == _WCMDA_Modem)
	{
		memcpy((INT8U *)&Sts->EsnNumber, ICCIDNum, 19);
	}
	else
	{
		memcpy((INT8U *)&Sts->EsnNumber, BcMEsnNum, 8);
	}

	Sts->MobileManufacture 	= BcMMaker;
	Sts->MobileModel		= BcMType;

	Sts->MobileVer[0]		= atoh(BcMVerNum[0]);
	Sts->MobileVer[1]		= (atoh(BcMVerNum[1]) << 4) | (atoh(BcMVerNum[2]) & 0x0f);

	Sts->ReportHours[0] 	= PresentHour;		//자동 보고 시간
	Sts->ReportHours[1] 	= PresentMin; 		//자동 보고 시간
	if( ModemType == _WCMDA_Modem)
	{
		Sts->LockOrderSts 		= LockOrder;	
	}
}

INT8U sms_buff[256];
INT8U sentTel[TelNo];
INT32S sms_len;
BcMTimeStr sms_time;
BcMRfStsStr Rf_sts;
BcMPilotStsStr Pilot_Sts;
INT32S tcp_port;
INT32S tcp_len;

void DnrSmsTask(void * pdata)
{
	INT16U InitCnt = 0;
	INT8S s = 0 ;
		
	__ProtocolPtr *nPtr = SmsSer;

	pdata = pdata;

	iSMS_Debug_Mode = SET;//SET;//RESET;
	
	TcpDnLoadFlag = RESET;
	OneDayResetCnt = RESET;

	// SmsResetPeriodFlag : TRUE 이면 Reset허용
	// SmsResetPeriodFlag : FALSE 이면 Reset불가
	
	SmsResetPeriodFlag = TRUE; //Reset 주기 체크 한다.
	SmsTxFailFlag = FALSE;
	
	USART4BuffClear();

	SMS_PWR = 1;
	OSTimeDly(1000L*5L);
	SMS_PWR = 0;

	BcMdemTcpExit();
		
	OSTimeDly(1000L*20L);  ///3G Modem Pwr On  20SEC 대기 
	PeriodStart = 1;

	//	BcMdemDebug(iSMS_Debug_Mode, (INT32S *)Ser3Ptr);
	BcMdemDebug(iSMS_Debug_Mode, (INT32S *)SerPtr);

	BootAlarmFlag = TRUE;		
	goto RETRY_START;

SWRST_START:
	BcMdemTcpExit();
	SmsResetPeriodFlag = TRUE;
	
		
PWRST_START:
	if(FSKDebug)USART1Printf("PWRST_START \n");
	if(tDnrSts->ModemOnOff == Disable)  goto PWRST_START;


	InitCnt = 0;
	SMS_PWR = 1;
	OSTimeDly(1000L*5L);
	SMS_PWR = 0;	

	BootAlarmFlag = TRUE;
	OneDayResetCnt = NULL;
	TcpDnLoadFlag = RESET;
				
	OSTimeDly(1000L*20L);
	
	AutoResetFlg = RESET;	
	Ser3Ptr->printf("1 : AutoResetFlg [%d]\n", AutoResetFlg);

RETRY_START:
	if(FSKDebug)USART1Printf("RETRY_START \n");
//	BcMdemDebug(iSMS_Debug_Mode, (INT32S *)Ser3Ptr);
	BcMdemDebug(iSMS_Debug_Mode, (INT32S *)SerPtr);

 		if( BcMdemInit(Ser4Ptr, TimerSmsRx) <= 0)
		{
			while(tTestFlag)
			{
				OSTimeDly(100L);
			}	
			if(++InitCnt > MaxTryNo)
			{	
				InitCnt = 0;
				
				if(SmsResetPeriodFlag)
				{					
					 ResetPeriodSet();
					 SmsTxFailFlag = FALSE;
					 
					 goto PWRST_START;
				}
				else goto RETRY_START;
			}
			else goto RETRY_START;
		}
		else
		{
			InitCnt = 0;
		}	
	
ModemLock_START:	
		ModemEsnCheck();
		
		if( ModemType == _WCMDA_Modem)
		{
			ModemLockOrder();
//			Ser3Ptr->printf("ModemLockOrder [%d]\n", LockOrder);
//			LockOrder = 1;
		}

		DnrSMS2Data();
/*
		#ifdef __SmsDebug
			iSMS_Debug_Mode = SET;
		#else
			iSMS_Debug_Mode = RESET;
		#endif
*/		while(1)
		{
			if(!tTestFlag)
			{
				while(!DownLoadGiveupTimerSet(NULL))
				{
//					BcMdemDebug(iSMS_Debug_Mode, (INT32S *)Ser3Ptr);
					BcMdemDebug(iSMS_Debug_Mode, (INT32S *)SerPtr);
				
					AutoResetCheck();
					if(SmsTxFailFlag)
					{
						if(SmsResetPeriodFlag)
						{
	//						SmsDataAckTx(Rmt_ID,Dnr_ID, (INT8U *)SmsDnrSts, sizeof(_SmsDnrStatus)-2, StatusQue,SmsSer);
							SmsTxFailFlag = FALSE;
						}	
					}
					
					if(TcpDnLoadFlag)	goto SWRST_START;

//					if(tDnrSts->FTPOnOff == Disable)
					{
						s = CdmaFuncselect();
						switch(s)
						{
							case SELF_RECV:
							WhatTime();

							if( (sms_len = BcMdemRecv(sms_buff, sentTel, &sms_time)) > 0)
							{
								if(0)
								{
									Ser3Ptr->printf("\n\r");
									USART3PutStr(sms_buff, sms_len, ENABLE);
									Ser3Ptr->printf("\n\r");
									if(FSKDebug)SerPtr->printf("\n");
									if(FSKDebug)SerPtr->printf("SendTel: %s \n", sentTel);
									if(FSKDebug)SerPtr->printf("sms_len: %d \n", sms_len);
								
									if(FSKDebug)SerPtr->printf("Arrive Time: %s %s %s %s %s %s %s\n",
								
									sms_time.Year,
									sms_time.Month,
									sms_time.Day,
									sms_time.Hour,
									sms_time.Min,
									sms_time.Sec,
									sms_time.Week);
								}

								if(Sms1_Protocol_Check(nPtr)) //Ser0ComCheck();
								{			
									SmsComCheck (nPtr);
								}
							}
							break;

							case SELF_TIME:
							break;

							case SELF_SEND:
								// if you want send ... please insert this area..

								if(PcFreqStsRqstFlag)
								{
									INT8U tid[3] = {0xff, 0xff, 0xff};
									SpecFreqState_RspFunc(tid,RadioAutoReport,2,NormalMode,nPtr);
									PcFreqStsRqstFlag = FALSE;
								}	

								///////// SEND ///////////
								if((BcMRtryNo < MaxTryNo)&&(LockOrder == 1))
								{
									if( tDnrSts->ResetCase == EtcReset)
									{
										FirstFlag = 0;
										BootAlarmFlag = 0;
									}
									
									if(!FirstFlag)
									{	
										INT8U i= 0;
										WhatTime();

										for(i = 0; i < 11; i++)tDnrSts->MinNumber[i] = BcMSrcTel[i];
										for(i = 0; i < 8;  i++)tDnrSts->EsnNumber[i] = BcMEsnNum[i];

										SmsAlarmRptFunc(Index_ResetAlarm,AlarmSCODE,Endcode,SmsSer);

										if (BootAlarmFlag)
										{
											SmsAlarmRptFunc(Index_BootAlarm,AlarmSCODE,Endcode,SmsSer);
											TimerRegist(TimerPerReport, Time1Sec*10L);	
											BootAlarmFlag = FALSE;
										}
										
										FirstFlag = 1;
									}
									WhatTime();

									SmsAlarm();
									SmsAutoReportCheck(nPtr);
									DnrSMS2Data();

///
									FTPDownloadheck(nPtr);
									if(tDnrSts->FTPOnOff == Enable)
									{
										FTPMode = tDnrSts->FTPMode ;
										TrsnsferMode = 0;

										if(tDnrSts->FTPIndex == 1)
										{
											iSMS_Debug_Mode ^= 1;
											tDnrSts->FTPIndex = 0;
										}
										else if(tDnrSts->FTPIndex == 2)		////Size
										{
											FTP_Mode(Index_FTPFileSize,SmsSer);
											tDnrSts->FTPFileSize.uD32 = FTPFileSizeRxCheck(RxDataBuff);
											tDnrSts->FTPIndex = 0;
										}
										else if(tDnrSts->FTPIndex == 3)
										{
											FTP_Mode(Index_FTPFileErase,SmsSer);
											tDnrSts->FTPIndex = 0;
										}		

										else if(tDnrSts->FTPIndex == 4)
										{
											INT16U len = 0;
											
											FTPFrameCnt = tDnrSts->FTPFrameCnt.uD16;
											ModemFTPFileGet(tDnrSts->FTP_DnFileName,FTPFrameCnt,tDnrSts->FTPFileStep.uD16,TrsnsferMode);

											len = BcMdemSyncProtocolCheck_Mode(RxDataBuff,tDnrSts->FTPFileStep.uD16);
											FTPRxProtocolCheck(SmsSer,RxDataBuff,len,tDnrSts->FTPFrameCnt.uD16,FTPFrameCnt);
											tDnrSts->FTPIndex = 0;
										}		
										if(tDnrSts->FTPIndex == 6)
										{
											FTP_Mode(Index_FTPGet,SmsSer);
											tDnrSts->FTPIndex  = 0;
										}
										else if(tDnrSts->FTPIndex == 8)
										{
											FTP_Mode(Index_FTPOnen,SmsSer);
											tDnrSts->FTPIndex = 0;
										}
										else if(tDnrSts->FTPIndex == 9)
										{
											FTP_Mode(Index_ModemBaudRate,SmsSer);
											tDnrSts->FTPIndex = 0;
										}
									}

									if(SetSMS_PWR)
									{
										ModemPwrOFF();
										OSTimeDly(1000*10L);
										SetSMS_PWR = RESET;
									}
								}
								else if(LockOrder == 0)
								{
//									if( LockOrderCnt++ > 5*30)	 /// 1이 2초 
									if( LockOrderCnt++ > 5*2)	 /// 1이 2초 
									{
										LockOrderCnt = 0;
										chkLockOrder = chkLockOrder + 1;

										if( chkLockOrder >= 3 )  ////3
										{
	//										tDnrSts->ModemOnOff = Disable;
										}
										else
										{
											goto ModemLock_START;
										}
									}
								}
							break;
											
							case MAX_TRY:
								// if(iSMS_Debug_Mode)	USART1Printf("MAX_TRY \n");
								// reset routine!!

								if(TimeOverCheck(TimerSmsFirstTx))
								{
									SmsResetPeriodFlag = TRUE;
								}

								if(SmsResetPeriodFlag)
								{	
									 SmsTxFailFlag = TRUE;
									 ResetPeriodSet();

									 goto PWRST_START;
								}
												
							default:					
							break;
						}
						
						OSTimeDly(500L);
					}
#if 0				
					else
					{
						FTPMode = tDnrSts->FTPMode ;
						TrsnsferMode = 0;

						if(tDnrSts->FTPIndex == 1)
						{
							iSMS_Debug_Mode ^= 1;
							tDnrSts->FTPIndex = 0;
						}
						else if(tDnrSts->FTPIndex == 2)		////Size
						{
							FTP_Mode(Index_FTPFileSize,SmsSer);
							tDnrSts->FTPFileSize.uD32 = FTPFileSizeRxCheck(RxDataBuff);
							tDnrSts->FTPIndex = 0;
						}
						else if(tDnrSts->FTPIndex == 3)
						{
							FTP_Mode(Index_FTPFileErase,SmsSer);
							tDnrSts->FTPIndex = 0;
						}		

						else if(tDnrSts->FTPIndex == 4)
						{
							INT16U len = 0;
							
							FTPFrameCnt = tDnrSts->FTPFrameCnt.uD16;
							ModemFTPFileGet(tDnrSts->FTP_DnFileName,FTPFrameCnt,tDnrSts->FTPFileStep.uD16,TrsnsferMode);

							len = BcMdemSyncProtocolCheck_Mode(RxDataBuff,tDnrSts->FTPFileStep.uD16);
							FTPRxProtocolCheck(SmsSer,RxDataBuff,len,tDnrSts->FTPFrameCnt.uD16,FTPFrameCnt);
							tDnrSts->FTPIndex = 0;
						}		

						
						if(tDnrSts->FTPIndex == 6)
						{
							FTP_Mode(Index_FTPGet,SmsSer);
							tDnrSts->FTPIndex  = 0;
						}
						else if(tDnrSts->FTPIndex == 8)
						{
							FTP_Mode(Index_FTPOnen,SmsSer);
							tDnrSts->FTPIndex = 0;
						}
						else if(tDnrSts->FTPIndex == 9)
						{
							FTP_Mode(Index_ModemBaudRate,SmsSer);
							tDnrSts->FTPIndex = 0;
						}
						OSTimeDly(100L*1L);
					}
#endif					
			}
			while(DownLoadGiveupTimerSet(NULL))
			{
				INT16U len;
				INT16U nCnt;

				INT8U pcheck = 0;

				len = BcMdemTCPRxCheck1(RxDataBuff);
                len = len;
				while(ModemSer->CheckByte(4, &nCnt))
				{
					pcheck = ProtocolCheck_1(ModemSer);
					if(pcheck)
					{
						TCPComCheck(ModemSer);
					}
				}

				OSTimeDly(10L);
			}		
		}
		else OSTimeDly(500L);			
	}
}
//// Task에 지연 발생 
void Auto_ResetCheckInit(void)
{
	if		( tDnrSts->RepeatResetPriod == 0x01 )	tPeriod = ((24L*3600L)*1 )/1;
	else if ( tDnrSts->RepeatResetPriod == 0x02 )	tPeriod = ((24L*3600L)*3 )/1;
	else if ( tDnrSts->RepeatResetPriod == 0x03 )	tPeriod = ((24L*3600L)*7 )/1;
	else if ( tDnrSts->RepeatResetPriod == 0x04 )	tPeriod = ((24L*3600L)*10)/1;	
	else if ( tDnrSts->RepeatResetPriod == 0x05 )	tPeriod = ((24L*3600L)*30)/1;
	else 											tPeriod = ((24L*3600L)*1 )/1;

	OneDayPeriod = (24L*3600L)*1;

//	CheckTime(tDnrSts->ResetPeriodCountSet,tPeriod);
	
}


INT32U CheckTime(INT8U *tCount,INT32U tTime,INT8U Mode)
{
	INT32U Temp,Temp1,Temp2;

	if( Mode == 0)
	{
		Temp = tTime / 60;

		Temp1 = Temp % 60;
		Temp2 = Temp / 60;

		tCount[2] = (INT8U)Temp1;
		tCount[1] = (INT8U)(Temp2 % 24);
		tCount[0] = (INT8U)(Temp2 / 24);
	}
	else
	{
		tTime = (tCount[0]*24*60*60) + (tCount[1]*60*60) + tCount[2]*60;
		
		Ser3Ptr->printf("tTime [%d]\n", tTime);
	}
	return  tTime;
}

void AutoResetCheck(void)
{
//	AutoResetCnt++;
	OneDayResetCnt++;

	if(OneDayResetCnt > OneDayPeriod )
	{
		SET_ULAlarmCnt = SET;
		OneDayResetCnt = NULL;		
	}

	if(AutoResetCnt > OneDayPeriod )
	{
		SET_ULAlarmCnt = SET;
	}

 	if( tDnrSts->RepeatResetPriod == 0x7f) return;
#if 0
	if(AutoResetCnt > tPeriod )
	{
		BcMRtryNo = MaxTryNo;
		AutoResetCnt = NULL;	
		AutoResetFlg = SET;
	}
#endif
//	CheckTime(tDnrSts->ResetPeriodCountSts,OneDayResetCnt,0);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
INT16U ArRemainTime[4]; // 자동보고 남은 시간 10초단위 환산. [0/1/2] ==>[상태/전파/idle]
static INT16U Init_ar_time[4] = {0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF}; // 현재의 시스템시간을 10초단위 저장.

// 자동보고주기를 10초단위로 환산, index : 1일(0),5분(1),...,12시간(9) 
// 10초단위 카운트 수.
// 1일 = 8640 = 24 x 60 x 60 / 10초단위
const INT16U AutoTime[10] = { 8640, 30, 60, 120, 180, 360, 720, 1440, 2160, 4320 }; // {1일, 5분, 10분,..,12시간}


// 현재설정된 자동보고주기를 10초단위로 환산한 값을 리턴한다.
//
// idx : 0(상태), 1(전파), 2(idle전파)
// 자동보고 주기 : 
// 5분~12시간 : 1~9
// 1일 : 0x10
// 없음: 0x7F
/*******************************************************************************
 자동보고주기(10초단위 환산시간)을 리턴한다. 1일이상은 무조건 1일 이상.
--------------------------------------------------------------------------------
[IN] 
idx	: 0 ~ 2 [상태/전파1/전파2]
[OUT]
[RET]
*******************************************************************************/
INT16U GetPeriod( INT8U idx )
{
	// 5분(1) ~ 12시간(9) 주기이면 해당되는 10초단위환산주기값을 리턴하고, 그렇지 않으면, 1일자동주기로 환산한다.
	// 10 : 자동보고주기 1일 이하의 경우, 자동주기에 해당하는 시간(10초단위)리턴
	if( m_sms.ArPeriod[idx]<10 ) return AutoTime[m_sms.ArPeriod[idx]];
	else return 8640; // 1일 이상은 무조건 1일.
}

// idx : 0(상태), 1(전파), 2(idle전파)
// 자동보고 기준시 및 자동보고 주기 변경되면 호출됨.
// 자동보고여부 체크시, 초기자동보고시간(Init_ar_time)이 0xFFFF이면 호출됨.
// 자동보고 남은시간 갱신 및 Init_ar_time 를 현재의 시스템 시간 10초환산단위로 갱신.
/*******************************************************************************
 자동보고시간을 계산.
--------------------------------------------------------------------------------
[IN] 
idx	: 0 ~ 2 [상태/전파1/전파2]
[OUT]
[RET]
*******************************************************************************/
void CalcARTime( INT8U idx )
{
	INT16U	ar_time, period; // 10초단위 환산값.
	INT16U	a_r, c_r;
	
	
	// 모뎀에서 아직 시간을 받지 못해서 업데이트 안되었으면, 그냥 리턴.
	if( cur_10s_time == 0xFFFF )
	{
		Init_ar_time[idx] = 0xFFFF;
		return;
	}

	// 자동보고 기준시/분을 10초 단위로 환산하여 ar_time 에 저장.
	
	// 자동보고 기준시를 10초단위로 환산한 절대값 계산. 기준시가 0시1분이면, ar_time은 6이 된다.
	// 상태자동보고
	if( idx == 0 ) 
	{
		ar_time = (m_sms.RepArTime[0]*360) + (m_sms.RepArTime[1]*6);
	}	
	// 전파자동보고
	else 
	{
		ar_time = (m_sms.RfArTime[0]*360) + (m_sms.RfArTime[1]*6);
	}
	
	// ar_time ==> 자동보고 기준시,기준분을 10초 단위 환산.

	// 자동보고 주기 10 초 단위 시간( 5분 주기의 경우, 30)
	period = GetPeriod(idx);


	// 자동보고 기준시의 주기와 현재 시간의 주기의 남은 시간 비교
	a_r = ar_time%period; // 기준시를 주기로 나눈 나머지. 
	c_r = cur_10s_time%period; // 현재시간을 주기로 나눈 나머지.

	ar_time = cur_10s_time - c_r;
	ar_time += a_r;

	if( c_r>=a_r ) ar_time += period;
	
//	m_sms.ArRemain[idx] = next_ar_time[idx] - cur_10s_time;

	// 10초단위의 자동보고 남은 시간.
	ArRemainTime[idx] = ar_time - cur_10s_time;
	m_sms.ArRemain[idx] = ArRemainTime[idx];
	Init_ar_time[idx] = cur_10s_time;

//	if( next_ar_time[idx]=>8640 ) next_ar_time[idx] = 8640-next_ar_time[idx];
	
}

// 자동보고 시간되었는지 확인. 자동보고 해야 하면 1 아니면 0 리턴.
// idx : 0(상태) 1(전파) 2(idle 전파)
/*******************************************************************************
 지금 시간이 자동보고해야하는 시간인지 체크
--------------------------------------------------------------------------------
[IN] 
idx	: 0 ~ 2 [상태/전파1/전파2]
[OUT]
[RET] 지금 자동보고 해야 할 시간이면 1을 아니면 0을 리턴
*******************************************************************************/
INT8U CheckARTime( INT8U idx )
{
	INT16U ref_time; // 경과시간

	// 자동보고 없음(0x7F)이면 : 해당항목이 자동보고주기가 자동보고없음이면 리턴 0.
	if( m_sms.ArPeriod[idx] == 0x7F ) return 0;

	// 전파/idle전파 이나, 자동보고 안함(0x03)이면 리턴 0, 자동보고 안함.
	if(idx) 
	{
		if( m_sms.ArMode[idx-1] == 0x03 ) return 0;
	}

	if( Init_ar_time[idx] == 0xFFFF ) 
	{
		CalcARTime( idx );
	}

	// 경과시간
	if( cur_10s_time >= Init_ar_time[idx] )
		ref_time = cur_10s_time-Init_ar_time[idx];
	else ref_time = (8640-Init_ar_time[idx])+cur_10s_time;
	
	// 자동보고 남은 시간 계산
	// 경과시간이 남은시간보다 크면 자동보고 해야함.
	if( ref_time >= ArRemainTime[idx] )
		m_sms.ArRemain[idx] = 0;
	else m_sms.ArRemain[idx] = ArRemainTime[idx] - ref_time;

	// 자동보고 남은 시간이 0이면, 자동보고해야 할 시간.
	if( m_sms.ArRemain[idx] == 0 )
	{
		CalcARTime( idx );
		return 1; // 자동보고 해야함.
	}
	
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////
void SmsAlarm(void)
{
	INT16U tcnt = 0;
	
	__BODYFRAME  *Send = SmsSer->SmsSend;

	if(chkDnrAlarmReport == SET)
	{
		INT8U tid[3] = {0xff, 0xff, 0xff};

		tcnt = DnrAlarmReport((INT8U *)Send->SubData, SmsSer);
		if( tcnt > 4) 	SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, AlarmSCODE,SmsSer);

		if(( SetAcRecovery == 0)&&PwrAlarm.ACFail)
		{
			tcnt = DnrAlarmReport((INT8U *)Send->SubData, SmsSer);
			if( tcnt >= 4)
			{
				OSTimeDly(1000*2L);
				SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, AlarmSCODE,SmsSer);
			}
		}
		OSTimeDly(1000*10L);

		chkDnrAlarmReport = RESET;
	}
}

void SmsAutoReportCheck(__ProtocolPtr *nPtr)
{
//	INT8U nRet = 0;
	INT8U tid[3] = {0xff, 0xff, 0xff};

	if(AutoRptChk())
	{
		tDnrSts->ReportHours[0] = PresentHour;			//자동 보고 시간
		tDnrSts->ReportHours[1] = PresentMin;			//자동 보고 시간

		SmsStsTransmitData(tid,AutoReportSCODE,SmsSer);
	}
	
	if(WavTwoAutoRptChk()|| (PcFreqStsRqstFlag == SET))
	{
		if ( tDnrSts->WaveCtrl.AR_Mode[0] != 0x03 )
		{
			SpecFreqState_RspFunc(tid, RadioAutoReport,tDnrSts->WaveCtrl.AR_Mode[0],NormalMode,nPtr);	// ID Modify
			PcFreqStsRqstFlag = RESET;
		}	
	}

	if(WavThrAutoRptChk())
	{
		if ( tDnrSts->WaveCtrl.AR_Mode[1] != 0x03 )
		{
			SpecFreqState_RspFunc(tid, IdleStatusReport,tDnrSts->WaveCtrl.AR_Mode[1],IdleMode,nPtr);  	// ID Modify
		}	
	}
}



INT32U Sms1_Protocol_Check(__ProtocolPtr *nPtr)
{
	INT8U CHKSUM = 0;
	INT16U DataCnt = 0;

	__BODYFRAME *Recv = nPtr->SmsRecv;

	{
		if( (Recv->SubID[0] = sms_buff[DataCnt++]) != 0xff) Recv->SubID[0] &= 0x7f;
		if( (Recv->SubID[1] = sms_buff[DataCnt++]) != 0xff) Recv->SubID[1] &= 0x7f;
		if( (Recv->SubID[2] = sms_buff[DataCnt++]) != 0xff) Recv->SubID[2] &= 0x7f;

		Recv->Command = sms_buff[DataCnt++] & 0x7f;
		Recv->RCode = sms_buff[DataCnt++] & 0x7f;
		Recv->SubLen[0] = sms_buff[DataCnt++] & 0x7f;
		Recv->SubLen[1] = sms_buff[DataCnt++]& 0x7f;
		Recv->SubLength = (Recv->SubLen[0] << 8) | (Recv->SubLen[1]);
	}

    {
		INT16U i;
//		INT8U *dptr = (INT8U *)Recv->SubData;

//		Ser3Ptr->printf("\n\r Command: [%x]",Recv->Command);
#if 1
#if 0
		if((Recv->Command == FTPDownloadCMD)||(Recv->Command == FTPDownLoadDataConfirm))
		{
			INT8U *dptr = (INT8U *)Recv->SubData[4];

			Recv->SubData[0] = sms_buff[DataCnt++];
			Recv->SubData[1] = sms_buff[DataCnt++];
			Recv->SubData[2] = sms_buff[DataCnt++];
			Recv->SubData[3] = sms_buff[DataCnt++];


			for(i = 0; i < (Recv->SubLength + 2); i++) *dptr++ = sms_buff[4 + DataCnt++];
		}
		else
#endif			
		{
			INT8U *dptr = (INT8U *)Recv->SubData;

			for(i = 0; i < (Recv->SubLength + 2); i++) *dptr++ = sms_buff[DataCnt++] & 0x7f;
		}
#endif
//		for(i = 0; i < (Recv->SubLength + 2); i++) *dptr++ = sms_buff[DataCnt++] & 0x7f;


//		Ser3Ptr->printf("\n\r Command: [%x][%x][%x][%x]>[%x][%x][%x][%x][%x][%x]\n\r",Recv->Command,Recv->RCode,Recv->SubLen[0],Recv->SubLen[1],
//			Recv->SubData[0],Recv->SubData[1],Recv->SubData[2],Recv->SubData[3],Recv->SubData[4],Recv->SubData[5]);

		// Frame CHKSUM //
		{
			INT8U  i = 0;
			for(i = 0; i < Recv->SubLen[1] + 7; i++) CHKSUM = CHKSUM + *((INT8U *)Recv->SubID+ i);
		}
		
		Recv->CrcOK = TRUE;
	
		if(Recv->SubData[Recv->SubLen[1]] != DataConv(HIGH,CHKSUM))
		{
			SmsAlarmRptFunc(Index_ErrRsp,ErrorCODE,EsnMismatch,nPtr);

			Recv->CrcOK = FALSE;
			return FALSE;
		}
		if(Recv->SubData[Recv->SubLen[1]+1] != DataConv(LOW,CHKSUM))
		{
			SmsAlarmRptFunc(Index_ErrRsp,ErrorCODE,EsnMismatch,nPtr);

			Recv->CrcOK = FALSE;
			return FALSE;
		}
	}

	return TRUE;
}


INT8U WhatRxSms(__ProtocolPtr *nPtr)
{
	INT16U RetVal = 0;

	//SIO´ BODY is ONLY ONE(1)
	if(nPtr->SmsRecv->CrcOK)	// CRC OK
	{
		RetVal = nPtr->SmsRecv->Command;
	}
	else //NO ERROR
	{
		//ERROR CASE
		RetVal = crcERROR;
	}
    return (RetVal);	
}


void SmsComCheck (__ProtocolPtr *nPtr)
{
	INT16U tcnt = 0;
	INT8U Comm;

	__BODYFRAME *Recv = nPtr->SmsRecv;
	__BODYFRAME *Send = nPtr->SmsSend;
 
 	Comm = WhatRxSms(nPtr);

    INT8U tid[3] = {Recv->SubID[0], Recv->SubID[1], Recv->SubID[2]};

	pUSART3.printf("\n\r 0: Comm [%x]\n", Comm);
//	if((Recv->Command == FTPDownloadCMD)||(Recv->Command == FTPDownLoadDataConfirm))

	switch(Comm)	//command 체크
	{
		case EtcInforStsQue: 
			SmsStsTransmitData(tid,Comm,SmsSer);
		break;

		case Etc1InforStsQue: 
			SmsEtcTransmitData(tid,Comm,SmsSer);
		break;

		case StatusQue:	
			SmsStsTransmitData(tid,Comm,SmsSer);
		break;
		
		case ControlQue:
		case RadioSetRQST:
		{
            Sms_Response_Control(SmsSer,TRUE);

			if(iMobileESN == ACK)
			{
				if( Comm == ControlQue)
				{
					SmsStsTransmitData(tid,Comm,SmsSer);
				}
				else if( Comm == RadioSetRQST)
				{
					tcnt = GenWaveStsAid((INT8U *)Send->SubData,tDnrSts);
					SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,SmsSer);
				}
			}
			else
			{
 				SmsAlarmRptFunc(Index_ErrRsp,ErrorCODE,EsnMismatch,nPtr);
 			}
		}
		break;

		case AlarmMaskSetSCODE:
			tDnrSts->AlarmMask = Recv->SubData[0];
			{
				EE_BACK1 *tptr = &gEE_BACK1;
				tptr->BackUp.AlarmMask = tDnrSts->AlarmMask;
				WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AlarmMask), tDnrSts->AlarmMask, 0);
			}
			SmsDataAckTx(tid, Recv->SubData, 1, Comm,nPtr);
		break;
		
		case SpecFreqStateSCODE:
			SpecFreqState_RspFunc(tid,Comm,0x01,NormalMode,nPtr);	
		break;

		case DnrSwHistorySCODE:
			SwHistroyRspFunc(tid,Comm,nPtr);
		break;

		case FreqConfigValSCODE :
			tcnt = GenWaveStsAid((INT8U *)Send->SubData,tDnrSts);
			SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,SmsSer);
		break;
	
		case DnrIpAddressSCODE:
			DnrIpAddressAck(tid,Comm,nPtr);
			DnrPacketReadyFunc(nPtr);
		break;

		case FTPDownloadCMD:
		case FTPDownLoadDataConfirm:
			FTPSts((INT8U *)Recv->SubData,Recv->SubLength);

			if( tDnrSts->MobileManufacture == 0x05)
			{
				Send->SubData[0] = NACK;
				pUSART3.printf("NACK[%d]\n",tDnrSts->MobileManufacture);
			}
			else
			{
				Send->SubData[0] = ACK;
				
				pUSART3.printf("ACK[%d]\n",tDnrSts->MobileManufacture);
			}
			SmsDataAckTx(tid, Send->SubData, 1, Comm,nPtr);
		break;
				
		default:
		break;
	}
}	

void SmsStsTransmitData(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr)
{
	INT16U tcnt = 0;
	__BODYFRAME *Send = nPtr->SmsSend;

	{
		tcnt = GenSmsStsAidSts_1St((INT8U *)Send->SubData,tDnrSts);
		SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,SmsSer);
	}

	{
		tcnt = GenSmsStsAidSts_2St((INT8U *)Send->SubData,tDnrSts);
		SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,SmsSer);
	}

	if(SET_ULAlarmCnt)
	{
		tDnrSts->RvsOverInAlarmCount		= 0;
		tDnrSts->RvsOtherOverInAlarmCount	= 0;
		SET_ULAlarmCnt = SET;
	}
}


// ===========================================================
//	CONTROL & 응답 정보 전송
// ===========================================================
INT8U Sms_Response_Control(__ProtocolPtr *nPtr, INT8U Ctrl)
{
	INT8U  Len = 0,   Length = 0;
	INT8U i= 0;
	INT8U  A_ID[2];
	INT8U AID_Value[40];
	INT16U  AID_Command;

	INT8U rval = TRUE;
//	INT32U cpu_sr;
	
//	INT8U err = 0;

	__BODYFRAME *Recv = nPtr->SmsRecv;

	ModemEsnCheck();

//	OS_ENTER_CRITICAL();
//	OSSemPend(pBackupSem, 0, &err);
//	OSSemPend(AlcSem, 0, &err);
//	OSSemPend(ExpSem, 0, &err);

	{
  		while(Recv->SubLength >  Len)
		{
			A_ID[0] = (INT8U)(Recv->SubData[Len++]);
			A_ID[1] = (INT8U)(Recv->SubData[Len++]);
			AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
			Length = Recv->SubData[Len++];

			for (i = 0 ; i<Length && i < 40; i++) AID_Value[i] = (INT8U)(Recv->SubData[Len++]);

			rval += SetCtrlData(AID_Command, AID_Value, Length, Ctrl,nPtr);

			if( iMobileESN == NACK) 	break;

			if(Len >= Recv->SubLength)break;
		}		
	}
	
//	OS_EXIT_CRITICAL();

//	OSSemPost(pBackupSem);
//	OSSemPost(AlcSem);
//	OSSemPost(ExpSem);

	return TRUE;
}

void SmsDataAckTx (INT8U* tid,  INT8U *Data, INT16U nCnt,  INT8U Comm,__ProtocolPtr *nPtr)
{
	INT16U i;
	INT8U	CHKSUM = 0;
	INT8U err = 0;  
	
	__BODYFRAME  *Send = nPtr->SmsSend;

	OSSemPend(nPtr->OSSem, 0, &err);	

	Send->SubID[0] = tid[0];
	Send->SubID[1] = tid[1];
	Send->SubID[2] = tid[2];

	Send->Command = Comm;
	Send->RCode = TRIO_RCODE;

	Send->SubLength = nCnt;
	
	Send->SubLen[0] = (INT8U)(Send->SubLength >> 8);
	Send->SubLen[1] = (INT8U)(Send->SubLength);

	for(i = 0; i < nCnt && i < BODYSIZEMAX; i++)
	{
		Send->SubData[i] =  Data[i];
	}

	for(i = 0; i < nCnt+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
	
	Send->SubData[nCnt++] = DataConv(HIGH,CHKSUM);
	Send->SubData[nCnt++] = DataConv(LOW,CHKSUM);

	OSSemPost(nPtr->OSSem);

	Sms_DataAckTx(Send->Command,nPtr);
}


void Sms_DataAckTx(INT8U Comm,__ProtocolPtr *nPtr)
{
	INT8U i;
  	INT32S ret = 0;
    ret = ret;
    
	__BODYFRAME  *Send = nPtr->SmsSend;
	
	if(Send->Command == DnrSwHistorySCODE)
	{
		for ( i=0; i< (7 + 2); i++ )
		{
			*((INT8U *)Send->SubID + i) = *((INT8U *)Send->SubID + i)|0x80;
		}
	}
	else
	{
		for(i = 0; i < Send->SubLength + 7 + 2; i++ )
		{
			*((INT8U *)Send->SubID + i) = *((INT8U *)Send->SubID + i)|0x80;
		}
	}
	
	for(i = 0 ;i < 13; i++)HostStation[i] = 0;
	for(i = 0 ;i < 11; i++)HostStation[i] = tDnrSts->HostNumber[i];	

	DnrSMS2Data();

	if((HostStation[0] < '0')||(HostStation[0] > '9')) return;

	{
		INT8U Flag = TRUE;	
		for(i = 1; i < 11 && (HostStation[i] != 0); i++)
		{
			if (HostStation[0] != HostStation[i]) Flag = FALSE;
		}
	
		if (Flag) return; 
	}


	for(i = 0; i < 3; i++)
	{
		if((Send->Command == EtcInforStsQue)||(Comm == Etc1InforStsQue))
		{
			if( (ret = BcMdemMSGSentTx((char *)HostStation,(char *)sentTel,(char *)Send, (Send->SubLength+ 7 + 2) )) > 0)
			{
				BcMRtryNo = 0;
				SmsTxFailFlag = FALSE;
				break;
			}
			else
			{
				BcMRtryNo = MaxTryNo;
			}
		}
		else
		{
			if( (ret = BcMdemMSGTx((char *)HostStation, (char *)Send, (Send->SubLength+ 7 + 2) )) > 0)
			{
				BcMRtryNo = 0;
				SmsTxFailFlag = FALSE;
				break;
			}
			else
			{
				BcMRtryNo = MaxTryNo;
			}
		}
		OSTimeDly(1000*10L);
	}
	
	if(Comm == AutoReportSCODE)
	{
		tDnrSts->Last_AutoReport[0] = TwoAsciDeciNum2OneHex(sms_time.Year[2],sms_time.Year[3]);
		tDnrSts->Last_AutoReport[1] = TwoAsciDeciNum2OneHex(sms_time.Month[0],sms_time.Month[1]);
		tDnrSts->Last_AutoReport[2] = TwoAsciDeciNum2OneHex(sms_time.Day[0],sms_time.Day[1]);
		tDnrSts->Last_AutoReport[3] = TwoAsciDeciNum2OneHex(sms_time.Hour[0],sms_time.Hour[1]);
		tDnrSts->Last_AutoReport[4] = TwoAsciDeciNum2OneHex(sms_time.Min[0],sms_time.Min[1]);
		tDnrSts->Last_AutoReport[5] = TwoAsciDeciNum2OneHex(sms_time.Sec[0],sms_time.Sec[1]);
	}
	else
	{
		tDnrSts->Backup_Time[0] = TwoAsciDeciNum2OneHex(sms_time.Year[2],sms_time.Year[3]);
		tDnrSts->Backup_Time[1] = TwoAsciDeciNum2OneHex(sms_time.Month[0],sms_time.Month[1]);
		tDnrSts->Backup_Time[2] = TwoAsciDeciNum2OneHex(sms_time.Day[0],sms_time.Day[1]);
		tDnrSts->Backup_Time[3] = TwoAsciDeciNum2OneHex(sms_time.Hour[0],sms_time.Hour[1]);
		tDnrSts->Backup_Time[4] = TwoAsciDeciNum2OneHex(sms_time.Min[0],sms_time.Min[1]);
		tDnrSts->Backup_Time[5] = TwoAsciDeciNum2OneHex(sms_time.Sec[0],sms_time.Sec[1]);
	}		
}


INT32U AutoTimeChk ( INT8U ReportPriod )
{
	INT8U 	Temp=0;
	long	Period;

	Temp = ReportPriod;
	if		( Temp == 0x01 )	Period = 5;
	else if ( Temp == 0x02 )	Period = 10;
	else if ( Temp == 0x03 )	Period = 20;
	else if ( Temp == 0x04 )	Period = 30;
	else if ( Temp == 0x05 )	Period = 1*60;
	else if ( Temp == 0x06 )	Period = 2*60;
	else if ( Temp == 0x07 )	Period = 4*60;
	else if ( Temp == 0x08 )	Period = 6*60;
	else if ( Temp == 0x09 )	Period = 12*60;
	else if ( Temp == 0x10 )	Period = 1*24*60;
	else if ( Temp == 0x11 )	Period = 2*24*60;
	else if ( Temp == 0x12 )	Period = 3*24*60;
	else if ( Temp == 0x13 )	Period = 7*24*60;
	else if ( Temp == 0x7f )	return(FALSE);
	else 						return(FALSE);

	return Period;
}



BOOL AutoRptChk ( void )
{
	INT8U 	Temp = 0;
	long	Period, Present, Base = 0;//, Past;
 
	Temp	= tDnrSts->AutoReportPriod;
	
	Present = 60 * PresentHour + PresentMin;
	Base	= (60*tDnrSts->AutoReportBasePer[0] + tDnrSts->AutoReportBasePer[1]);

	/* Period 기호 -> 분 */
	
	Period = AutoTimeChk(Temp);

	if 		( Period == FALSE )	return(FALSE);

	if((PresentDay == 0)&&(PresentMonth == 0))
	{
		PresentHour	= iPresentHourCnt;
		PresentMin	= iPresentMinCnt;
	}

	if 		( PastMin < PresentMin ) TimeElapse += (PresentMin - PastMin);
	else if ( PastMin > PresentMin ) TimeElapse += (60 + PresentMin - PastMin);

	PastHour = PresentHour;
	PastMin  = PresentMin;

	/*  제어설정후 기준시각 체크  */
	
	if ( TimeStart )
	{
		TimeStart = 0;
		TimeElapse = 0;
		
		if ( Present >= Base )return(TRUE);
		else				  return(FALSE);
	}
	// New Period Check //
	if ( PeriodStart )
	{
		PeriodStart = 0;
		if ( Present >= Base )	TimeElapse = (Present - Base) % Period;
		else					TimeElapse = (24 * 60 + Present - Base) % Period;
		return(FALSE);
	}

	tDnrSts->Auto_Remain_Time = ((Period - TimeElapse) * 6)- PresentSec/10; 

	if ( TimeElapse >= Period )
	{
		TimeElapse = (TimeElapse % Period);
		return(TRUE);
	}
	return (FALSE);
}


BOOL WavTwoAutoRptChk ( void )
{
	INT8U 	Temp;
	long	Period, Present, Base;

	Temp	= tDnrSts->WaveCtrl.Radio_ReportPeriod[0];
	Present = 60*PresentHour + PresentMin;
	Base	= 60*tDnrSts->WaveCtrl.Radio_ReportTime[0] + tDnrSts->WaveCtrl.Radio_ReportTime[1];

	/* Period 기호 -> 분 */
	Period = AutoTimeChk(Temp);
	if 		( Period == FALSE )	return(FALSE);
	/**********************************************************************
	Period = (Temp>>4)*10 + (Temp&0x0f);
	if ( Period <= 0 )	return(FALSE);
	***********************************************************************/
	/////////////////////////
	if 		( WTwoPastMin < PresentMin ) WTwoTimeElapse = WTwoTimeElapse + (PresentMin-WTwoPastMin);
	else if ( WTwoPastMin > PresentMin ) WTwoTimeElapse = WTwoTimeElapse + (60+PresentMin-WTwoPastMin);

	WTwoPastHour = PresentHour;
	WTwoPastMin  = PresentMin;

	// New Base Time Check //

	if ( WTwoTimeStart )
	{ 	
		WTwoTimeStart = 0;
		WTwoTimeElapse = 0;
			
		if ( Present>=Base )return(TRUE);
		else				return(FALSE);
	}

	// New Period Check //
	if ( WTwoPeriodStart )
	{	
		WTwoPeriodStart = 0;
		if ( Present >= Base )	WTwoTimeElapse = (Present-Base)%Period;
		else					WTwoTimeElapse = (24*60+Present-Base)%Period;
		return(FALSE);
	}

	tDnrSts->AR2_Remain_Time = ((Period - WTwoTimeElapse) * 6)- PresentSec/10; 

	// Elapsed Time Over Check //
	if ( WTwoTimeElapse >= Period )
	{	
		WTwoTimeElapse = (WTwoTimeElapse%Period);
		return(TRUE);
	}
	return (FALSE);
}


BOOL WavThrAutoRptChk ( void )
{
	INT8U 	Temp;
	long	Period, Present, Base;//, Past;

	Temp	= tDnrSts->WaveCtrl.Radio_ReportPeriod[1];
	
	Present = 60*PresentHour + PresentMin;
	Base	= 60*tDnrSts->WaveCtrl.Radio_ReportTime[0] + tDnrSts->WaveCtrl.Radio_ReportTime[1];

	Period = AutoTimeChk(Temp);
	if 		( Period == FALSE )	return(FALSE);

	if 		( WThreePastMin < PresentMin ) WThreeTimeElapse = WThreeTimeElapse + (PresentMin-WThreePastMin);
	else if ( WThreePastMin > PresentMin ) WThreeTimeElapse = WThreeTimeElapse + (60+PresentMin-WThreePastMin);

	WThreePastHour = PresentHour;
	WThreePastMin  = PresentMin;

	// New Base Time Check //
	if ( WThreeTimeStart )
	{ 	
		WThreeTimeStart = 0;
		WThreeTimeElapse = 0;
			
		if ( Present>=Base )return(TRUE);
		else				return(FALSE);
	}

	// New Period Check //
	if ( WThreePeriodStart )
	{	
		WThreePeriodStart = 0;
		if ( Present >= Base )	WThreeTimeElapse = (Present-Base)%Period;
		else					WThreeTimeElapse = (24*60+Present-Base)%Period;
		return(FALSE);
	}

	tDnrSts->AR3_Remain_Time = ((Period - WThreeTimeElapse) * 6)- PresentSec/10; 

	// Elapsed Time Over Check //
	if ( WThreeTimeElapse >= Period )
	{	
		WThreeTimeElapse = (WThreeTimeElapse%Period);
		return(TRUE);
	}
	return (FALSE);
}


void ModemEsnCheck ( void )
{
	INT16U	EsnChk = 0;
	
	INT16U	i;
	if( ModemType == _WCMDA_Modem)
	{
		for( i = 0; i < 19; i++ )
		{
			EsnChk += atoh( ICCIDNum[i] );
		}
	}
	else
	{
		EsnChk = TwoAsciNum2OneHex( BcMEsnNum[0], BcMEsnNum[1] )
				+TwoAsciNum2OneHex( BcMEsnNum[2], BcMEsnNum[3] )
				+TwoAsciNum2OneHex( BcMEsnNum[4], BcMEsnNum[5] )
				+TwoAsciNum2OneHex( BcMEsnNum[6], BcMEsnNum[7] );
	}
	
	EsnChecksumH = DataConv(HIGH, EsnChk);
	EsnChecksumL = DataConv(LOW, EsnChk);
}

void WhatTime(void)
{
	__Dnr_Sts *Sts = tDnrSts;

	BcdemTimeGet(&sms_time);
	{
		PresentDay 		= TwoAsciDeciNum2OneHex(sms_time.Day[0],sms_time.Day[1]);	
		PresentHour 	= TwoAsciDeciNum2OneHex(sms_time.Hour[0],sms_time.Hour[1]);
		PresentMin  	= TwoAsciDeciNum2OneHex(sms_time.Min[0],sms_time.Min[1]);
		PresentSec		= TwoAsciDeciNum2OneHex(sms_time.Sec[0],sms_time.Sec[1]);
		PresentMonth 	= TwoAsciDeciNum2OneHex(sms_time.Month[0],sms_time.Month[1]);
	}

	Sts->System_Time[0] = TwoAsciDeciNum2OneHex(sms_time.Year[2],sms_time.Year[3]);
	Sts->System_Time[1] = TwoAsciDeciNum2OneHex(sms_time.Month[0],sms_time.Month[1]);

	Sts->System_Time[2] = TwoAsciDeciNum2OneHex(sms_time.Day[0],sms_time.Day[1]);
	Sts->System_Time[3] = TwoAsciDeciNum2OneHex(sms_time.Hour[0],sms_time.Hour[1]);

	Sts->System_Time[4] = TwoAsciDeciNum2OneHex(sms_time.Min[0],sms_time.Min[1]);
	Sts->System_Time[5] = TwoAsciDeciNum2OneHex(sms_time.Sec[0],sms_time.Sec[1]);

}

void SwHistroyRspFunc (INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr)
{
    INT8U	CHKSUM=0, DataCnt=0, i,j;

	__BODYFRAME  *Send = nPtr->SmsSend;

	// Frame Header //
	Send->SubID[0] = tid[0];
	Send->SubID[1] = tid[1];
	Send->SubID[2] = tid[2];
    
	Send->RCode			= TRIO_RCODE;
	Send->Command		= Comm;
	Send->SubLen[0]		= 0;
	Send->SubLen[1]		= LineLengh+1+1; // more + line lenght + line data

	
	for(j = 0; j < VersionNum; j++)
	{
		DataCnt = 0, CHKSUM = 0;
		
		if(j == VersionNum - 1)	Send->SubData[DataCnt++] = 0x00;		// more 추가 정보
		else					Send->SubData[DataCnt++] = 0x01;		// more 추가 정보
		
		Send->SubData[DataCnt++] = LineLengh;	// LineLengh
		for(i = 0; i < LineLengh; i++)
		{
		   Send->SubData[DataCnt++] = *(DnrVerString+ (i +(j*LineLengh)));	// LineLengh
	    }
	    /*********************/		
		// Frame CHKSUM //
		for(i = 0; i < DataCnt+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);

		Send->SubData[DataCnt++] = DataConv(HIGH,CHKSUM);
		Send->SubData[DataCnt++] = DataConv(LOW,CHKSUM);
		Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1]	)& 0x00ff);

		Sms_DataAckTx(Send->Command,nPtr);
	}
}

void DnrIpAddressAck(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr)
{
	INT16U i;
	INT8U	CHKSUM = 0;
	__BODYFRAME  *Send = nPtr->SmsSend;
	__BODYFRAME  *Recv = nPtr->SmsRecv;

	Send->SubID[0] = tid[0];
	Send->SubID[1] = tid[1];
	Send->SubID[2] = tid[2];

	Send->Command = Comm;
	Send->RCode = Recv->RCode;

	Send->SubLength = Recv->SubLength ;

	Send->SubLen[0]	= (INT8U)(Send->SubLength >> 8);
	Send->SubLen[1]	= (INT8U)(Send->SubLength);

	for(i = 0; i < Send->SubLength && i < BODYSIZEMAX; i++)
	{
		Send->SubData[i] =  Recv->SubData[i];
	}

	for(i = 0; i < Send->SubLength+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
	Send->SubData[Send->SubLength++] = DataConv(HIGH,CHKSUM);
	Send->SubData[Send->SubLength++] = DataConv(LOW,CHKSUM);

	Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);

	Sms_DataAckTx(Send->Command,nPtr);
}


void DnrPacketReadyFunc(__ProtocolPtr *nPtr)
{
	INT16U i;
    INT32S ret = 0;
		
	ret=ret;// 
	__BODYFRAME  *Recv = nPtr->SmsRecv;
	
	tcp_port = 8081;

	for(i = 0 ; i < 5; i++)
	{
 		if(ret=(BcMdemTcpConnect(Recv->SubData,Recv->SubLen[1],tcp_port))==1)
		{
			DownLoadGiveupTimerSet(Ser4DownLoading);
			break;
		}
		else
		{
//			ModemHangUp();
			if(iSMS_Debug_Mode)USART1Printf("IP Not Connect \n");
		}
		OSTimeDly(1000*5L);
	}

	if(i > 4)TcpExit();
}

INT8U TcpExit(void)
{
	INT8U nRet = TRUE;
//	INT16U i;

//	for( i = 0; i < 5; i++)
	{
		if( nRet = BcMdemTcpExit() > 3)
		{
			// if(iSMS_Debug_Mode)	USART1Printf("BcMdemTcpExit[%d] \n",nRet);
			return TRUE;
		}
		else
		{
			nRet = FALSE;
			// if(iSMS_Debug_Mode)USART1Printf("Tx FALSE: BcMdemTcpExit[%d]\n",nRet);
		}
		OSTimeDly(1000*5L);
	}
	return nRet;
}

void SpecFreqState_RspFunc (INT8U* tid,INT8U Comm, INT8U Auto, INT8U Idle,__ProtocolPtr *nPtr )
{
	INT8U CHKSUM=0,Count=0,i;

	__BODYFRAME  *Send = nPtr->SmsSend;

	for(i = 0; i < 13; i++)TestStation[i] = 0;
	for(i = 0; i < 13; i++)TestStation[i] = tDnrSts->TestStn[i];

	if (Idle == NormalMode)
	{
		for(i = 0 ; i<3; i++)
		{
			if((TestStation[0] >= '0')&&(TestStation[0] <= '9'))
			{
				if(BcMdemCalling((char *)TestStation) == TRUE)
				{
				 	break;
				}
			}
			else break;
			
			OSTimeDly(1000 * 5L);
		}

		{
			if(TrafficCheck() == TRUE) 	tDnrSts->WaveSts.OneFAStatus = 0x03;	// Call OK!
			else 						tDnrSts->WaveSts.OneFAStatus = 0x04;	// Call Fail!
		}
	}
	else	tDnrSts->WaveSts.OneFAStatus = 0x03;				// Call OK!


	SpecFreqStateUpdate();

	for ( i = 0; i < 3; i++ ) 
	{
		INT32S ret = TrafficCheck();

		if(ret == TRUE)	CdmaModemHangUp();
		else  			break;	// Hang Up //
		OSTimeDly(1000*5L);
	}

	if(!PcFreqStsRqstFlag)FreqAlarmCheckRpt(tid,nPtr);

	{
	// Frame Header //
   	Send->SubID[0] = tid[0];
	Send->SubID[1] = tid[1];
	Send->SubID[2] = tid[2];

    
	Send->Command = Comm;
	Send->RCode = TRIO_RCODE;

 
	Send->SubData[Count++]= 0x00;
	Send->SubData[Count++]= 0x01;
	Send->SubData[Count++]= 0x04;

	// 알람 체크 Flag 설정
	Send->SubData[Count++]= 0x7e;
	Send->SubData[Count++]= 0x7e;
	Send->SubData[Count++]= tDnrSts->RFAlarm.RxTxAlarm.Data;
	Send->SubData[Count++]= tDnrSts->RFAlarm.EcIo.Data;


	if(Auto == 0x01)
	{
		Send->SubData[Count++] = hibyte(Aid_SMS_TxRetry); // A_ID
		Send->SubData[Count++] = lobyte(Aid_SMS_TxRetry);
		Send->SubData[Count++] = 0x01;
		Send->SubData[Count++] = tDnrSts->WaveSts.SMS_TxRetry;

		if( ModemType == _WCMDA_Modem)
		{
			Send->SubData[Count++] = hibyte(Aid_WcdmaChannel); // A_ID
			Send->SubData[Count++] = lobyte(Aid_WcdmaChannel);
			Send->SubData[Count++] = 0x03;
			Send->SubData[Count++] = tDnrSts->WaveSts.WcdmaChannel[0];
			Send->SubData[Count++] = tDnrSts->WaveSts.WcdmaChannel[1];
			Send->SubData[Count++] = tDnrSts->WaveSts.WcdmaChannel[2];
		}
		else
		{
			Send->SubData[Count++] = hibyte(Aid_ActChannel); // A_ID
			Send->SubData[Count++] = lobyte(Aid_ActChannel);
			Send->SubData[Count++] = 0x02;
			Send->SubData[Count++] = tDnrSts->WaveSts.ActChannel[0];
			Send->SubData[Count++] = tDnrSts->WaveSts.ActChannel[1];
		}
		Send->SubData[Count++] = hibyte(Aid_OneFAStatus); // A_ID
		Send->SubData[Count++] = lobyte(Aid_OneFAStatus);
		Send->SubData[Count++] = 0x01;
		Send->SubData[Count++] = tDnrSts->WaveSts.OneFAStatus;

		Send->SubData[Count++] = hibyte(Aid_FARxValue); // A_ID
		Send->SubData[Count++] = lobyte(Aid_FARxValue);
		Send->SubData[Count++] = 0x02;
		Send->SubData[Count++] = tDnrSts->WaveSts.FARxVal[0];
		Send->SubData[Count++] = tDnrSts->WaveSts.FARxVal[1];

		Send->SubData[Count++] = hibyte(Aid_TxVal); // A_ID
		Send->SubData[Count++] = lobyte(Aid_TxVal);
		Send->SubData[Count++] = 0x02;
		Send->SubData[Count++] = tDnrSts->WaveSts.TxVal[0];
		Send->SubData[Count++] = tDnrSts->WaveSts.TxVal[1];

		if (Idle == NormalMode)
		{
			Send->SubData[Count++] = hibyte(Aid_FAFerValue); // A_ID
			Send->SubData[Count++] = lobyte(Aid_FAFerValue);
			Send->SubData[Count++] = 0x01;
			Send->SubData[Count++] = tDnrSts->WaveSts.WaveNormalStatus.FAFerVal;
		}
		Send->SubData[Count++] = hibyte(Aid_PN_Val); // A_ID
		Send->SubData[Count++] = lobyte(Aid_PN_Val);
		Send->SubData[Count++] = 0x0c;
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[0];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[1];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[2];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[3];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[4];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[5];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[6];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[7];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[8];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[9];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[10];
		Send->SubData[Count++] = tDnrSts->WaveSts.PN_Val[11];

		Send->SubData[Count++] = hibyte(Aid_EcIo_Val); // A_ID
		Send->SubData[Count++] = lobyte(Aid_EcIo_Val);
		Send->SubData[Count++] = 0x06;
		Send->SubData[Count++] = tDnrSts->WaveSts.EcIo_Val[0];
		Send->SubData[Count++] = tDnrSts->WaveSts.EcIo_Val[1];
		Send->SubData[Count++] = tDnrSts->WaveSts.EcIo_Val[2];
		Send->SubData[Count++] = tDnrSts->WaveSts.EcIo_Val[3];
		Send->SubData[Count++] = tDnrSts->WaveSts.EcIo_Val[4];
		Send->SubData[Count++] = tDnrSts->WaveSts.EcIo_Val[5];

		if ((Comm == RadioAutoReport)||(Comm == IdleStatusReport))
		{
			Send->SubData[Count++] = hibyte(Aid_ReportHours); // A_ID
			Send->SubData[Count++] = lobyte(Aid_ReportHours);
			Send->SubData[Count++] = 0x02;
			Send->SubData[Count++] = PresentHour;
			Send->SubData[Count++] = PresentMin;

			tDnrSts->WaveSts.PresentHour = dtoh(PresentHour);
			tDnrSts->WaveSts.PresentMin	= dtoh(PresentMin);
		}
	}

		Send->SubLen[0] = 0;
		Send->SubLen[1] = Count;
	
		
		// Frame CHKSUM //
		for(i = 0; i < Count+ 7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
		Send->SubData[Count++] = DataConv(HIGH,CHKSUM);
		Send->SubData[Count++] = DataConv(LOW,CHKSUM);
		Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);

		Sms_DataAckTx(Send->Command,nPtr);
	}
}


INT8U TrafficCheck(void)
{
	INT8U j;
	INT8U nRet = TRUE;

	for(j = 0 ; j < 3; j++)
	{
		INT32S ret = 0;
        ret=ret;

		if( ModemType == _WCMDA_Modem)
		{
			if( ret= CdmaModemTrafficCheck() == '1') 	nRet = TRUE;
			else  										nRet = FALSE;				
		}
		else
		{
			if( ret= CdmaModemTrafficCheck() == '3')  	nRet = TRUE;
			else		 								nRet = FALSE;		
		}

		OSTimeDly(500);
	}
	
	return nRet;
}

void SpecFreqStateUpdate ( void )
{
	 int	 i = 0, TempThreshold = 0;
	 int	 NumTry = 0,j = 0;
	 INT8U	 TempCopy;
	
	 INT16S CurrFer	= 0;
	 INT16S CurrRx	= 0;
	 INT16S CurrAdj	= 0;
	 INT16S CurrTx 	= 0;

 //=======================//
 // Rx, Tx, Adj Averaging //
 //=========================================================================//

	BcdemRfStsGet(&Rf_sts);

	CurrFer = Rf_sts.FerValue;
	CurrRx  = Rf_sts.RxValue;
	CurrAdj = Rf_sts.AdjValue;
	CurrTx = Rf_sts.TxValue;
	 
	OSTimeDly(1000L*2L);

	NumTry = 5;
	for ( j=0; j<  NumTry ; j++ )
	{
		BcdemRfStsGet(&Rf_sts);

		CurrFer = (CurrFer + Rf_sts.FerValue)/2;
		CurrRx  = (CurrRx + Rf_sts.RxValue)/2;
		CurrAdj = (CurrAdj + Rf_sts.AdjValue)/2;
		CurrTx  = (CurrTx + Rf_sts.TxValue)/2;
		OSTimeDly(1000L*2L);
	}

	tDnrSts->WaveSts.WaveNormalStatus.FAFerVal = lobyte(CurrFer);

	tDnrSts->WaveSts.ActChannel[0] = (Rf_sts.ActChannel >> 6) & 0x3f;
	tDnrSts->WaveSts.ActChannel[1] = (Rf_sts.ActChannel	   ) & 0x3f;

	BcdemPilotGet(&Pilot_Sts);

	tDnrSts->WaveSts.PN_Val[0] = (Rf_sts.PN_Vaule[0]>>6)&0x3f;
	tDnrSts->WaveSts.PN_Val[1] = (Rf_sts.PN_Vaule[0])&0x3f;
	tDnrSts->WaveSts.EcIo_Val[0] = abs(Rf_sts.EcIo[0]);

	for(i = 0; i < 4; i++)
	{
		tDnrSts->WaveSts.PN_Val[i*2 ] = (Pilot_Sts.PN_Vaule[i]>>6) & 0x3f;
		tDnrSts->WaveSts.PN_Val[i*2 + 1] = (Pilot_Sts.PN_Vaule[i]) & 0x3f;
		tDnrSts->WaveSts.EcIo_Val[i]= abs(Pilot_Sts.EcIo[i]);
	}
		
	TempCopy = 0;
	
	if( ModemType == _WCMDA_Modem)
	{
		// RX = CurrRx + CPL(10)
		CurrRx = (CurrRx + (INT8S)10);

//		tDnrSts->WaveSts.TxVal[0] = (Rf_sts.TxValue >> 6) & 0x3f;
//		tDnrSts->WaveSts.TxVal[1] = (Rf_sts.TxValue	   ) & 0x3f;
//		Rf_sts.TxValue = Rf_sts.TxValue + 10;

		tDnrSts->WaveSts.TxVal[0] =  DataConv(HIGH,Rf_sts.TxValue);
		tDnrSts->WaveSts.TxVal[1] =  DataConv(LOW,Rf_sts.TxValue);

		tDnrSts->WaveSts.WcdmaChannel[0] = (unsigned char)((Rf_sts.ActChannel>>12)&0x3F); 
		tDnrSts->WaveSts.WcdmaChannel[1] = (unsigned char)((Rf_sts.ActChannel>>6)&0x3F); 
		tDnrSts->WaveSts.WcdmaChannel[2] = (unsigned char)(Rf_sts.ActChannel&0x3F); 
	}
	else
	{

		tDnrSts->WaveSts.ActChannel[0] = (unsigned char)((Rf_sts.ActChannel>>6)&0x3F); 
		tDnrSts->WaveSts.ActChannel[1] = (unsigned char)(Rf_sts.ActChannel&0x3F); 

		// RX = CurrRx + EcIo + CPL(10)
		CurrRx = (CurrRx + (INT8S)tDnrSts->WaveSts.EcIo_Val[0]) + (INT8S)11;

		CurrTx = - CurrRx + CurrAdj - 73;
	}

	tDnrSts->WaveSts.FARxVal[0] = DataConv(HIGH,CurrRx);
	tDnrSts->WaveSts.FARxVal[1] = DataConv(LOW,CurrRx);


	tDnrSts->WaveSts.ActChannel[0] = (Rf_sts.ActChannel >> 6) & 0x3f;
	tDnrSts->WaveSts.ActChannel[1] = (Rf_sts.ActChannel	   ) & 0x3f;

	
	if(CurrRx > TwoAsciNum2OneHex(tDnrSts->WaveCtrl.RxMaxVal[0], tDnrSts->WaveCtrl.RxMaxVal[1]))	 BitSet(TempCopy, 6);
	if(CurrRx < TwoAsciNum2OneHex(tDnrSts->WaveCtrl.RxMinVal[0], tDnrSts->WaveCtrl.RxMinVal[1]))	 BitSet(TempCopy, 5);
	if(CurrTx > TwoAsciNum2OneHex(tDnrSts->WaveCtrl.TxMaxVal[0], tDnrSts->WaveCtrl.TxMaxVal[1]))	 BitSet(TempCopy, 4);
	if(CurrTx < TwoAsciNum2OneHex(tDnrSts->WaveCtrl.TxMinVal[0], tDnrSts->WaveCtrl.TxMinVal[1]))	 BitSet(TempCopy, 3);


	iTxValH = DataConv(HIGH,CurrTx);
	iTxValL = DataConv(LOW,CurrTx);

	tDnrSts->RFAlarm.RxTxAlarm.Data = TempCopy;
	//=======================================//
	// Each PN Ecio Threshold Check -> Alarm //
	//=========================================================================//
	TempThreshold = ((tDnrSts->WaveCtrl.EcIo>>4)*10) + (tDnrSts->WaveCtrl.EcIo&0x0f);

	TempCopy = 0;

	for ( i = 0; i < 1; i++ )
	{
		if((tDnrSts->WaveSts.EcIo_Val[i]> TempThreshold)&& (tDnrSts->WaveSts.EcIo_Val[i]!= 0)) BitSet(TempCopy, 6-i);
	}
	tDnrSts->RFAlarm.EcIo.Data = TempCopy;

	//=================================//
	// Master Pn Update Check & Report //
	//=========================================================================//
	for ( i = 0; i < 6; i++ )	
	{	
		iPNVal_Old[i*2] = tDnrSts->WaveSts.PN_Val[i*2];
		iPNVal_Old[i*2+1] = tDnrSts->WaveSts.PN_Val[i*2+1];
	}

	for(i = 0 ; i < 6 ; i++)	// EcIo -> 24일 경우 0x24로 만든다. 08/07/15
	{
		TempCopy = tDnrSts->WaveSts.EcIo_Val[i];
		
		tDnrSts->WaveSts.EcIo_Val[i] = ((TempCopy/10)*0x10) + (TempCopy%10);
	}
	
	if(!FirstPNCheckFlag)
	{
		iMasterPNH  = tDnrSts->WaveSts.PN_Val[0];
		iMasterPNL  = tDnrSts->WaveSts.PN_Val[1];
		
		FirstPNCheckFlag = TRUE;
	}

	if ((iMasterPNH == tDnrSts->WaveSts.PN_Val[0])&&(iMasterPNL == tDnrSts->WaveSts.PN_Val[1]))  PnChangeCnt = 0;
	else PnChangeCnt++;


	if ( PnChangeCnt >= 2 )
	{
		iMasterPNH  = tDnrSts->WaveSts.PN_Val[0];
		iMasterPNL  = tDnrSts->WaveSts.PN_Val[1];

		PnAlarm=Alarm;
		PnChangeCnt = 0;
		
		{
			EE_BACK1 *tptr = &gEE_BACK1;

			tptr->BackUp.MasterPNH = iMasterPNH;
			tptr->BackUp.MasterPNH = iMasterPNL;

			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.AlarmMask), tDnrSts->AlarmMask, 0);
		}
					
	}
}


void FreqAlarmCheckRpt (INT8U* tid,__ProtocolPtr *nPtr)
{
 //=========================//
 // Rx, Tx, Adj, EcIo Check //
 //=========================================================================//
	 
	if(tDnrSts->AlarmMask == 0x01)	 return;
	
	RxTxAlarmNew = tDnrSts->RFAlarm.RxTxAlarm.Data;
	RxTxAlarmFlag = RxTxAlarmNew ^ RxTxAlarmOld;
	RxTxAlarmOld = RxTxAlarmNew;


	EcIoNew = tDnrSts->RFAlarm.EcIo.Data;
	EcIoFlag = EcIoNew ^EcIoOld;
	EcIoOld = EcIoNew;

	PnAlarmNew = PnAlarm;
	PnAlarmFlag = PnAlarmNew ^PnAlarmOld;
	PnAlarmOld = PnAlarmNew;


	if ((RxTxAlarmFlag) ||(EcIoFlag ) ||(PnAlarmFlag ))
	{
		FreqAlarmRptFunc(tid,nPtr);
	}
}


void FreqAlarmRptFunc(INT8U* tid,__ProtocolPtr *nPtr)
{
	 INT8U CHKSUM=0,Count=0,i;

	 __BODYFRAME  *Send = nPtr->SmsSend;

	 // Frame Header //
	Send->SubID[0] = tid[0];
	Send->SubID[1] = tid[1];
	Send->SubID[2] = tid[2];

	Send->RCode		 = TRIO_RCODE;
	Send->Command	 = RadioAlarmReport;

	if(BitRead(RxTxAlarmFlag, 6))
	{
		Send->SubData[Count++] = hibyte(Aid_RxMaxVal); // A_ID
		Send->SubData[Count++] = lobyte(Aid_RxMaxVal);

		if(BitRead(RxTxAlarmOld, 6))	 Send->SubData[Count++] = 0x01;  // 발생
		else							 Send->SubData[Count++] = 0x00;  // 해제

		Send->SubData[Count++] = 0x02; 						 // Lenght

		Send->SubData[Count++] = tDnrSts->WaveSts.FARxVal[0];						
		Send->SubData[Count++] = tDnrSts->WaveSts.FARxVal[1];		
	}

	if(BitRead(RxTxAlarmFlag, 5))
	{
		Send->SubData[Count++] = hibyte(Aid_RxMinVal); // A_ID
		Send->SubData[Count++] = lobyte(Aid_RxMinVal);

		if(BitRead(RxTxAlarmOld, 5))	 Send->SubData[Count++] = 0x01;  // 발생
		else							 Send->SubData[Count++] = 0x00;  // 해제

		Send->SubData[Count++] = 0x02; 											 // Lenght

		Send->SubData[Count++] = tDnrSts->WaveSts.FARxVal[0];						
		Send->SubData[Count++] = tDnrSts->WaveSts.FARxVal[1];					
	}

	if(BitRead(RxTxAlarmFlag, 4))
	{
		Send->SubData[Count++] = hibyte(Aid_TxMaxVal); 			 // A_ID
		Send->SubData[Count++] = lobyte(Aid_TxMaxVal);

		if(BitRead(RxTxAlarmOld, 4))	 Send->SubData[Count++] = 0x01; 	 // 발생
		else							 Send->SubData[Count++] = 0x00; 	 // 해제

		Send->SubData[Count++] = 0x02; 											 // Lenght
		Send->SubData[Count++] = iTxValH;						
		Send->SubData[Count++] = iTxValL;						
	}

	if(BitRead(RxTxAlarmFlag, 3))
	{
		Send->SubData[Count++] = hibyte(Aid_TxMinVal); 			 // A_ID
		Send->SubData[Count++] = lobyte(Aid_TxMinVal);

		if(BitRead(RxTxAlarmOld, 3))	 Send->SubData[Count++] = 0x01;  // 발생
		else							 Send->SubData[Count++] = 0x00;  // 해제
		Send->SubData[Count++] = 0x02; 											 // Lenght

		Send->SubData[Count++] = iTxValH;						
		Send->SubData[Count++] = iTxValL;
	}

	if(EcIoFlag != 0)		
	{
		Send->SubData[Count++] = hibyte(Aid_EcIo); 			 // A_ID
		Send->SubData[Count++] = lobyte(Aid_EcIo);

		if(EcIoOld!=0) 	 Send->SubData[Count++] = 0x01; 		 // 발생
		else				 Send->SubData[Count++] = 0x00; 		 // 해제

		Send->SubData[Count++] = 0x01; 										 // Lenght
		Send->SubData[Count++] = tDnrSts->WaveSts.EcIo_Val[0]; 			
	}

	if(PnAlarmFlag)
	{
		Send->SubData[Count++] = hibyte(Aid_PNUpdate);				 // A_ID
		Send->SubData[Count++] = lobyte(Aid_PNUpdate);

		if(PnAlarm)	 Send->SubData[Count++] = 0x01; 			 // 발생
		else			 Send->SubData[Count++] = 0x00; 			 // 해제

		Send->SubData[Count++] = 0x02; 							 // Lenght
		Send->SubData[Count++] = iMasterPNH;						
		Send->SubData[Count++] = iMasterPNL;						
	}

	/***************************************/
	Send->SubLen[0] = 0;
	Send->SubLen[1] = Count;

	// Frame CHKSUM //
	for(i = 0; i < Count+7; i++) CHKSUM = CHKSUM + *((INT8U *)Send->SubID + i);
	Send->SubData[Count++] = DataConv(HIGH,CHKSUM);
	Send->SubData[Count++] = DataConv(LOW,CHKSUM);

	Send->SubLength = ((Send->SubLen[0] << 8)& 0xff00) +  ((Send->SubLen[1] )& 0x00ff);

	Sms_DataAckTx(Send->Command,nPtr);
}

INT32U TCPRxProtocolCheck(__ProtocolPtr *nPtr)
{
	INT16U nInitCnt, nCnt;
	INT16U i = 0;
	INT16U Data;
	INT8U Temp;

	__WRCSSIO *Recv = nPtr->WRCSRecv;

	TimerRegist(ModemSer->TimerRx, Time1Sec*2L);
	while(1)
	{
		if(TimeOverCheck(ModemSer->TimerRx)) return FALSE;
	
		if(ModemSer->CheckByte(4, &nCnt))
		{
			Temp = ModemSer->RxGetByte();

			if (  (STX == Temp )
				&&(STX == ModemSer->RxGetByte())
				&&(STX == ModemSer->RxGetByte())
				&&(STX == ModemSer->RxGetByte()))
			{
				Recv->Sync[0] = STX;
				Recv->Sync[1] = STX;
				Recv->Sync[2] = STX;
				Recv->Sync[3] = STX;

				Recv->BodyNo = 0; // Default: 1EA
				break;
			}
		}
		else OSTimeDly(10L);
		
//		Ser3Ptr->printf("Temp[%x]\n", Temp);
	}

	TimerRegist(ModemSer->TimerRx, Time1Sec);
	ModemSer->CheckByte(1, &nInitCnt);
	while(!ModemSer->CheckByte(4, &nCnt))
	{
		if(TimeOverCheck(ModemSer->TimerRx))
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(ModemSer->TimerRx, Time100mSec);
			}
			else return FALSE;
		}
		OSTimeDly(10L);
	}
	
	Recv->TryNo 		= ModemSer->RxGetByte();
	Recv->BodyLen[0]	= ModemSer->RxGetByte();
	Recv->BodyLen[1]	= ModemSer->RxGetByte();
	Recv->CheckSum		= ModemSer->RxGetByte();

//	Ser3Ptr->printf("CheckSum[%x][%x][%x][%x]\n",Recv->TryNo,Recv->BodyLen[0],Recv->BodyLen[1],Recv->CheckSum);

	Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);

	if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
		|| (Recv->BodyLength >= (TWO_BODY*BODYSIZEMAX))
	)
	{								
		return FALSE;
	}
	
	TimerRegist(ModemSer->TimerRx, Time1Sec*1);
	ModemSer->CheckByte(1, &nInitCnt);
	while(1)
	{
		if(TimeOverCheck(ModemSer->TimerRx)) ///1byte 500us
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(ModemSer->TimerRx, Time100mSec);
			}
			else
			{
				return FALSE;
			}
		}
		if(ModemSer->CheckByte(7, &nCnt))
		{
			break;// include 0x03
		}
		OSTimeDly(1L);
	}
	
	for(i = 0; i < 7 ; i++)
	{
		*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubID + i) = ModemSer->RxGetByte();
	}

	Recv->BodyFrame[Recv->BodyNo].SubLength
		=	 ((Recv->BodyFrame[Recv->BodyNo].SubLen[0] << 8)& 0xff00)
		  +  ((Recv->BodyFrame[Recv->BodyNo].SubLen[1] << 0)& 0x00ff);

	if(Recv->BodyFrame[Recv->BodyNo].SubLength >= BODYSIZEMAX)	return FALSE;	


	TimerRegist(ModemSer->TimerRx, Time1Sec*2);

	ModemSer->CheckByte(1, &nInitCnt);
	while(1)
	{
		if(TimeOverCheck(ModemSer->TimerRx)) ///1byte 500us
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(ModemSer->TimerRx, Time100mSec);
			}
			else
			{
				return FALSE;
			}
		}
		if(ModemSer->CheckByte((INT16U)(Recv->BodyFrame[Recv->BodyNo].SubLength + 2), &nCnt))
		{
			break;// include 0x03
		}
		OSTimeDly(20L);
	}
	for(i = 0; i < Recv->BodyFrame[Recv->BodyNo].SubLength + 2; i++)
	{
		*((INT8U *)Recv->BodyFrame[Recv->BodyNo].SubData + i) = ModemSer->RxGetByte();
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
		return TRUE;
	}


	TimerRegist(ModemSer->TimerRx, Time1Sec);
	ModemSer->CheckByte(1, &nInitCnt);
	while(!ModemSer->CheckByte(1, &nCnt))
	{
		if(TimeOverCheck(ModemSer->TimerRx))
		{
			if(nCnt > nInitCnt)
			{
				nInitCnt = nCnt;
				TimerRegist(ModemSer->TimerRx, Time100mSec);
			}
			else
			{
				return FALSE;
			}
		}
		OSTimeDly(10L);
	}
	Data = ModemSer->RxGetByte();
//	Ser3Ptr->printf("Data [%x]\n", Data);

	if(Data != ETX)
	{
		return FALSE;
	}
	return TRUE;
}


INT8U WhatRxTCP(__ProtocolPtr *nPtr)
{
	INT16U RetVal = 0;

	//SIO´ BODY is ONLY ONE(1)
	if(nPtr->WRCSRecv->BodyFrame[0].CrcOK)	// CRC OK
	{
		RetVal = nPtr->WRCSRecv->BodyFrame[0].Command;
	}
	else //NO ERROR
	{
		//ERROR CASE
		RetVal = crcERROR;
	}
    return (RetVal);	
}

void TCPComCheck (__ProtocolPtr *nPtr)
{
	INT8U Comm;

 	Comm = WhatRxTCP(nPtr);
//	Ser3Ptr->printf("Comm[%x]\n", Comm);

	switch(Comm)	//command 체크
	{
		case DownloadMinNumCMD:
		case DownloadCMD:
		case DownloadCMDConfirm:
		case DownLoadData:
		case DownLoadDataConfirm:

		case ModuleDownloadCMD:
		case ModuleDownloadCMDConfirm:
		case ModuleDownLoadData:
		case ModuleDownLoadDataConfirm:
		{
			DownLoadGiveupTimerSet(Ser4DownLoading);
			DownloadFunc(nPtr);
			TcpDnLoadFlag = SET;
			
			if(Comm == DownLoadDataConfirm )
			{
				TcpExit();
				DownLoadBootingJump();
			}
#if 0
			if(Comm == ModuleDownLoadDataConfirm )
			{
				TcpExit();
				DownLoadBootingJump();
			}
#endif			
		}
		break;
		
		case FastDownloadCMD:
		case FastDownLoadData:
		case FastDownLoadDataConfirm:
		{
			DownLoadGiveupTimerSet(Ser4DownLoading);
			TcpDnLoadFlag = SET;
		}
		break;

		default:
		break;
	}
}	

unsigned char TCPProDataAckTx (INT8U* tid, INT8U *Data, INT16U nCnt,  INT8U Comm,__ProtocolPtr *nPtr)
{
	INT8U err = 0;  
	
	INT32U i;
	INT32U Cnt = 0;
	INT16U SndCnt = 0;
	__WRCSSIO *Send = nPtr->WRCSSend;
//	__WRCSSIO *Recv = nPtr->WRCSRecv;

		OSSemPend(nPtr->OSSem, 0, &err);	
	if(err != OS_NO_ERR ) return err;	

	Send->BodyFrame[0].SubID[0] = tid[0];
	Send->BodyFrame[0].SubID[1] = tid[1];
	Send->BodyFrame[0].SubID[2] = tid[2];

	Send->BodyFrame[0].Command = Comm;
	Send->BodyFrame[0].RCode = TRIO_RCODE;

	Send->BodyFrame[0].SubLength = nCnt;

	for(i = 0; i < nCnt && i < BODYSIZEMAX; i++)
	{
		Send->BodyFrame[0].SubData[i] =  Data[i];
	}

	Send->BodyFrame[0].SubLen[0]	= (INT8U)(Send->BodyFrame[0].SubLength >> 8);
	Send->BodyFrame[0].SubLen[1]	= (INT8U)(Send->BodyFrame[0].SubLength);

	///////////// CRC //
	Send->BodyFrame[0].Crc = Crc16Calc ( &(Send->BodyFrame[0].SubID[0]), Send->BodyFrame[0].SubLength + 5 + 2, NULL);
	Send->BodyFrame[0].SubData[nCnt++] = (INT8U)(Send->BodyFrame[0].Crc >> 8);
	Send->BodyFrame[0].SubData[nCnt++] = (INT8U)(Send->BodyFrame[0].Crc);

	Send->BodyFrame[0].SubData[nCnt++] = 0x03;

	for(i = 0; i < 4; i++) Send->Sync[i] = STX;

	Send->TryNo = 0x30;
	Send->BodyLength = 0;

	Cnt = ((Send->BodyFrame[0].SubLen[0] << 8) | Send->BodyFrame[0].SubLen[1]) + 5 + 2 + 2;

	Send->BodyLength = Cnt;

	Send->BodyLen[0] = (INT8U)(Send->BodyLength >> 8);
	Send->BodyLen[1] = (INT8U)(Send->BodyLength);
	// CheckSum
	Send->CheckSum = 0;
	
	Send->CheckSum = (INT8U)(Send->TryNo + Send->BodyLen[0] + Send->BodyLen[1]);
	Send->BodyFrame[0].SubLength = (Send->BodyFrame[0].SubLen[0] << 8) | (Send->BodyFrame[0].SubLen[1]);
 	// Error Check
	if(Send->BodyFrame[0].SubLength >= BODYSIZEMAX)
	{
		OSSemPost(nPtr->OSSem);
		return FALSE;
	}
	OSSemPost(nPtr->OSSem);

	for(i = 0; i < 8; i++) 											 	t1SndData[SndCnt++] = *((INT8U *)Send->Sync+ i);
	for(i = 0; i < (Send->BodyFrame[0].SubLength + 5 + 2 + 2 + 1); i++) t1SndData[SndCnt++] = *((INT8U *)Send->BodyFrame[0].SubID+ i);

	BcMdemTCPTx((char *)t1SndData, SndCnt);

	return OS_NO_ERR;
}


INT8U DataConv ( INT8U HighLow, INT8U Value )
{
	INT8U Digit10;
	INT8U Digit1;

	Digit1 = (Value & 0x0f) + 0x30;
	Digit10 = ((Value >> 4) & 0x0f) + 0x30;

	if(Digit1 >= 0x3a) 	Digit1 += 0x07;
	if(Digit10 >= 0x3a) Digit10 += 0x07;

	if(HighLow == HIGH) return( Digit10 );
	if(HighLow == LOW) return( Digit1 );
	return(0);
}


INT8S TwoAsciNum2OneHex( INT8U Upper, INT8U Lower )
{
	//if ( Upper >= 0x41 ) Upper = Upper - 0x07;
	//if ( Lower >= 0x41 ) Lower = Lower - 0x07;
	
	//return ( atoh((Upper-0x30)<<4)|(Lower-0x30) );

	return((atoh(Upper) & 0x0f) << 4)|((atoh(Lower) & 0x0f)<< 0);
}

INT8U TwoAsciDeciNum2OneHex( INT8U Upper, INT8U Lower )
{
	return ( (Upper-0x30)*10 + (Lower-0x30)*1);
}

INT8U htod (INT8U value )
{
	INT8U	num;

	num = ((value >> 4)*10) + (value & 0x0f);
	
	return (INT8U)num;
}

INT8U dtoh (INT8U value )
{
	INT8U	num;

	num = ((value/10) << 4) | (value % 10);
	
	return (INT8U)num;
}


INT16U GenSmsStsAidSts_1St(INT8U *dptr, __Dnr_Sts *Sts)
{
	INT16U rlen = 0;
	INT16U i = 0;

	if(AlarmCheck_LTE_A2 != SET)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 	= Enable;
	if(AlarmCheck_LTE != SET)		Sts->AlmSts.FwdAmpOnOff_LTE 	= Enable;
	if(AlarmCheck_LTE_21 != SET)	Sts->AlmSts.FwdAmpOnOff_LTE_21	= Enable;


	dptr[rlen++] = Sts->AlmSts.Data[0];
	dptr[rlen++] = Sts->AlmSts.Data[1];
	dptr[rlen++] = Sts->AlmSts.Data[2];
	dptr[rlen++] = Sts->AlmSts.Data[3];
	dptr[rlen++] = Sts->AlmSts.Data[4];
	dptr[rlen++] = Sts->AlmSts.Data[5];
	dptr[rlen++] = Sts->AlmSts.Data[6];
	dptr[rlen++] = Sts->AlmSts.Data[7];
	dptr[rlen++] = '1';

	dptr[rlen++] = Sts->Manufacture;
	dptr[rlen++] = Sts->Supplier;
	dptr[rlen++] = Sts->RepeaterType[0];
	dptr[rlen++] = Sts->RepeaterType[1];
	dptr[rlen++] = Sts->SWVer;
	dptr[rlen++] = Sts->MobileManufacture;
	dptr[rlen++] = Sts->MobileModel;
	dptr[rlen++] = Sts->MobileVer[0];
	dptr[rlen++] = Sts->MobileVer[1];
	dptr[rlen++] = Sts->FPGAVer[0];
	dptr[rlen++] = Sts->FPGAVer[1];

	
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdInPwr_3G);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[1]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_3G[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_3G[1]);
	dptr[rlen++] = Sts->FwdGainSet_3G/2;
	dptr[rlen++] = Sts->FwdGain_3G/2;
	
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdInPwr_2G);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[1]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_2G[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_2G[1]);
	dptr[rlen++] = Sts->FwdGainSet_2G/2;
	dptr[rlen++] = Sts->FwdGain_2G/2;

	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdInPwr_LTE_21);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_21[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_21[1]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_21[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_21[1]);
	dptr[rlen++] = Sts->FwdGainSet_LTE_21/2;
	dptr[rlen++] = Sts->FwdGain_LTE_21/2;

	dptr[rlen++] = Sts->Rvs0GainSet_3G/2;
	dptr[rlen++] = Sts->RvsGainSts_3G/2;

	dptr[rlen++] = Sts->Rvs0GainSet_2G/2;
	dptr[rlen++] = Sts->RvsGainSts_2G/2;
	dptr[rlen++] = Sts->RvsGainBalance_CDMALTE;

	dptr[rlen++] = Sts->RvsGainSet_LTE_21/2;
	dptr[rlen++] = Sts->RvsGainSts_LTE_21/2;
	dptr[rlen++] = Sts->RvsGainBalance_WCDMALTE_21;


	dptr[rlen++] = Sts->AGCOnOff_WCDMALTE_21;
	dptr[rlen++] = Sts->AGCOnOff_CDMALTE;
	dptr[rlen++] = Sts->AGCOnOff_LTE_A_0;

	dptr[rlen++] = Sts->AmpOffCase_3G;
	dptr[rlen++] = Sts->AmpOffCase_2G;	
	dptr[rlen++] = Sts->AmpOffCase_LTE;	
	dptr[rlen++] = Sts->AmpOffCase_LTE_A2;
	dptr[rlen++] = Sts->AmpOffCase_LTE_21;

	for(i = 0; i < 9; i++)
	{
		dptr[rlen++] = 0;
	}

	dptr[rlen++] = Sts->AutoReportPriod;
	dptr[rlen++] = Sts->AutoReportBasePer[0];
	dptr[rlen++] = Sts->AutoReportBasePer[1];
	dptr[rlen++] = Sts->ReportHours[0];
	dptr[rlen++] = Sts->ReportHours[1];

 	return rlen;
}

INT16U GenSmsStsAidSts_2St(INT8U *dptr, __Dnr_Sts *Sts)
{
	INT16U rlen = 0;
	INT16U i = 0;

	if(AlarmCheck_LTE_A2 != SET)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Enable;
	if(AlarmCheck_LTE != SET)		Sts->AlmSts.FwdAmpOnOff_LTE = Enable;
	if(AlarmCheck_LTE_21 != SET)	Sts->AlmSts.FwdAmpOnOff_LTE_21= Enable;


	dptr[rlen++] = Sts->AlmSts.Data[0];
	dptr[rlen++] = Sts->AlmSts.Data[1];
	dptr[rlen++] = Sts->AlmSts.Data[2];
	dptr[rlen++] = Sts->AlmSts.Data[3];
	dptr[rlen++] = Sts->AlmSts.Data[4];
	dptr[rlen++] = Sts->AlmSts.Data[5];
	dptr[rlen++] = Sts->AlmSts.Data[6];
	dptr[rlen++] = Sts->AlmSts.Data[7];

	dptr[rlen++] = '2';

	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdInPwr_LTE);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[1]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE[1]);
	dptr[rlen++] = Sts->FwdGainSet_LTE/2;
	dptr[rlen++] = Sts->FwdGain_LTE/2;
	
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdInPwr_LTE_A2);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[1]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_A2[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_A2[1]);
	dptr[rlen++] = Sts->FwdGainSet_LTE_A2/2;
	dptr[rlen++] = Sts->FwdGain_LTE_A2/2;

	dptr[rlen++] = Sts->Rvs0GainSet_LTE/2;
	dptr[rlen++] = Sts->RvsGainSts_LTE/2;
	
	dptr[rlen++] = Sts->Rvs0GainSet_LTE_A2/2;
	dptr[rlen++] = Sts->RvsGainSts_LTE_A2/2;
	dptr[rlen++] = Sts->RvsGainBalance_LTE_A;

	dptr[rlen++] = Sts->LTE_21Use;

	dptr[rlen++] = Sts->Band_Select_CDMALTE[0];
	dptr[rlen++] = Sts->Band_Select_CDMALTE[1];
	dptr[rlen++] = Sts->Band_Select_CDMALTE[2];

	dptr[rlen++] = Sts->Band_Select_LTE_A[0];
	dptr[rlen++] = Sts->Band_Select_LTE_A[1];
	dptr[rlen++] = Sts->Band_Select_LTE_A[2];


	dptr[rlen++] = Sts->Band_Select_WCDMALTE_21[0];
	dptr[rlen++] = Sts->Band_Select_WCDMALTE_21[1];
	dptr[rlen++] = Sts->Band_Select_WCDMALTE_21[2];


	dptr[rlen++] = Sts->ISOValue_WCDMALTE_21;
	dptr[rlen++] = Sts->ISOValue_CDMALTE;
	dptr[rlen++] = Sts->ISOValue_LTE_A;

	dptr[rlen++] = 0;
	dptr[rlen++] = 0;
	dptr[rlen++] = 0;


	dptr[rlen++] = Sts->ULGainPriod;
	dptr[rlen++] = Sts->ULGainMode;


	dptr[rlen++] = Sts->AGCMode_3G;
	dptr[rlen++] = Sts->AGCMode_2G;
	dptr[rlen++] = Sts->AGCMode_LTE;
	dptr[rlen++] = Sts->AGCMode_LTE_A2;
	dptr[rlen++] = Sts->AGCMode_LTE_21;

	dptr[rlen++] = Sts->FemtocellUseOnOff.Data;
	dptr[rlen++] = Sts->RepeatResetPriod;
	dptr[rlen++] = Sts->RvsOverInAlarmCount;
	dptr[rlen++] = Sts->RvsOtherOverInAlarmCount;

	for(i = 0; i < 11; i++)
	{
		dptr[rlen++] = 0;
	}
	dptr[rlen++] = Sts->AutoReportPriod;
	dptr[rlen++] = Sts->AutoReportBasePer[0];
	dptr[rlen++] = Sts->AutoReportBasePer[1];
	dptr[rlen++] = Sts->ReportHours[0];
	dptr[rlen++] = Sts->ReportHours[1];

 	return rlen;
}




void SmsEtcTransmitData(INT8U* tid,INT8U Comm,__ProtocolPtr *nPtr)
{

	INT16U tcnt = 0;
	__BODYFRAME *Send = nPtr->SmsSend;

	{
		tcnt = GenEtc1StsAid((INT8U *)Send->SubData,tDnrSts);
		SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,SmsSer);
	}
}


INT16U GenEtc1StsAid(INT8U *dptr, __Dnr_Sts *Sts)
{
	INT16U rlen = 0;
	INT16U i = 0;


	for(i = 0; i < 6; i++)dptr[rlen++] = Sts->System_Time[i];
	for(i = 0; i < 6; i++)dptr[rlen++] = Sts->Backup_Time[i];
	for(i = 0; i < 6; i++)dptr[rlen++] = Sts->Last_AutoReport[i];

	dptr[rlen++] = hibyte(Sts->Auto_Remain_Time);
	dptr[rlen++] = lobyte(Sts->Auto_Remain_Time);
	dptr[rlen++] = hibyte(Sts->AR2_Remain_Time);
	dptr[rlen++] = lobyte(Sts->AR2_Remain_Time);
	dptr[rlen++] = hibyte(Sts->AR3_Remain_Time);
	dptr[rlen++] = lobyte(Sts->AR3_Remain_Time);

	dptr[rlen++] = Sts->RvsOverInAlarmCount;
	dptr[rlen++] = Sts->RvsOtherOverInAlarmCount;

	dptr[rlen++] = Sts->ReportHours[0];
	dptr[rlen++] = Sts->ReportHours[1];

	return rlen;
}



INT16U GenWaveStsAid(INT8U *dptr, __Dnr_Sts *Sts)
{
	INT16U rlen = 0;

	rlen += GenAidData(Aid_RxMaxVal,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.RxMaxVal), sizeof(Sts->WaveCtrl.RxMaxVal));
	rlen += GenAidData(Aid_RxMinVal,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.RxMinVal), sizeof(Sts->WaveCtrl.RxMinVal));
	rlen += GenAidData(Aid_TxMaxVal,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.TxMaxVal), sizeof(Sts->WaveCtrl.TxMaxVal));
	rlen += GenAidData(Aid_TxMinVal,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.TxMinVal), sizeof(Sts->WaveCtrl.TxMinVal));
	rlen += GenAidData(Aid_EcIo,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.EcIo), sizeof(Sts->WaveCtrl.EcIo));
	rlen += GenAidData(Aid_ARMode,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.AR_Mode), sizeof(Sts->WaveCtrl.AR_Mode));

	rlen += GenAidData(Aid_RadioReportTime,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.Radio_ReportTime), sizeof(Sts->WaveCtrl.Radio_ReportTime));

	rlen += GenAidData(Aid_RadioReportPeriod, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->WaveCtrl.Radio_ReportPeriod), sizeof(Sts->WaveCtrl.Radio_ReportPeriod));
	rlen += GenAidData(Aid_TestStn, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TestStn), sizeof(Sts->TestStn));

	return rlen;
}

void SmsAlarmRptFunc(INT8U Index, INT8U Comm ,INT8U Code, __ProtocolPtr *nPtr)
{
 	INT16U rlen = 0;
	INT8U tid[3] = {0xff, 0xff, 0xff};
	INT8U	DnrAlarmBuff[20] = {0,};

	if(Index == Index_ResetAlarm)
	{
		DnrAlarmBuff[rlen++] = hibyte(Aid_RCUReset);		// A_ID
		DnrAlarmBuff[rlen++] = lobyte(Aid_RCUReset);
		DnrAlarmBuff[rlen++] = 0x01;						// 발생
		DnrAlarmBuff[rlen++] = 0x01;						// Lenght
		DnrAlarmBuff[rlen++] = tDnrSts->ResetCase;			// Reason
	}

	if(Index == Index_BootAlarm)
	{
		DnrAlarmBuff[rlen++] = hibyte(Aid_BootAlarm);		// A_ID
		DnrAlarmBuff[rlen++] = lobyte(Aid_BootAlarm);
		DnrAlarmBuff[rlen++] = 0x01;						// 발생
		DnrAlarmBuff[rlen++] = 0x00;						// Lenght
	}

	if(Index == Index_ACAlarm)
	{
		DnrAlarmBuff[rlen++] = hibyte(Aid_PowerAlarm);		// A_ID
		DnrAlarmBuff[rlen++] = lobyte(Aid_PowerAlarm);
		DnrAlarmBuff[rlen++] = PwrAlarm.ACFail; 			// 발생
		DnrAlarmBuff[rlen++] = 0x00;						// Lenght
	}

	if(Index == Index_ErrRsp)
	{
		DnrAlarmBuff[rlen++] = Code;	
	}

	SmsDataAckTx(tid, (INT8U *)DnrAlarmBuff, rlen, Comm,SmsSer);
}


#if 1

INT16U DnrAlarmReport(INT8U *dptr, __ProtocolPtr *nPtr )
{
    INT8U DataCnt = 0;

	__Dnr_Sts  *Sts = tDnrSts;	
	
	if((PwrAlarm.ACFail)||(SetAcRecovery))	chkAlarmMaskReport = SET;
	else									chkAlarmMaskReport = RESET;

//	Ser3Ptr->printf("1: DnrAlarmReport[%d]\n",DataCnt);


	if((PwrAlarmChange.ACFail)||PwrAlarmFlag )
	{
		dptr[DataCnt++] = hibyte(Aid_PowerAlarm);	// A_ID
		dptr[DataCnt++] = lobyte(Aid_PowerAlarm);
		dptr[DataCnt++] = PwrAlarm.ACFail; 			// 발생
		dptr[DataCnt++] = 0x00; 					// Lenght

		if( InitPwrAlarm ) 
		{
			InitPwrAlarm = 0;
			PwrAlarmFlag = SET;
		}
		else
		{
			PwrAlarmFlag = RESET;
		}
	
		if(SetAcRecovery)	SetAcRecovery = RESET;
	}

	if( chkAlarmMaskReport == RESET)
	{
		if(PwrAlarmChange.FwdInUpperLmtFail_3G)
		{
			dptr[DataCnt++] = hibyte(Aid_OverIn_3G);	///과입력
			dptr[DataCnt++] = lobyte(Aid_OverIn_3G);
			dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_3G;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutUpperLmtFail_3G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_3G);
			dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_3G);
			dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_3G;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutLowerLmtFail_3G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_3G);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_3G);
			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_3G;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdInUpperLmtFail_LTE_21)
		{
			dptr[DataCnt++] = hibyte(Aid_OverIn_LTE_21);	///과입력
			dptr[DataCnt++] = lobyte(Aid_OverIn_LTE_21);
			dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_LTE_21;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutUpperLmtFail_LTE_21)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE_21);
			dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE_21);
			dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_LTE_21;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutLowerLmtFail_LTE_21)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE_21);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE_21);
			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_LTE_21;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.OverInAlarm_WCDMALTE_21)
		{
			dptr[DataCnt++] = hibyte(Aid_OverInAlarm_WCDMALTE_21);
			dptr[DataCnt++] = lobyte(Aid_OverInAlarm_WCDMALTE_21);
			dptr[DataCnt++] = PwrAlarm.OverInAlarm_WCDMALTE_21;
			dptr[DataCnt++] = 0x00;
		}

		///////////////////////////// Fwd 2G
		if(PwrAlarmChange.FwdInUpperLmtFail_2G)
		{
			dptr[DataCnt++] = hibyte(Aid_OverIn_2G);
			dptr[DataCnt++] = lobyte(Aid_OverIn_2G);
			dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_2G;
			dptr[DataCnt++] = 0x00;
		}

 		if(PwrAlarmChange.FwdOutUpperLmtFail_2G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_2G);
			dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_2G);
			dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_2G;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutLowerLmtFail_2G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_2G);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_2G);
			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_2G;
			dptr[DataCnt++] = 0x00;
		}

		///////////////////////////////////LTE
		if(PwrAlarmChange.FwdInUpperLmtFail_LTE)
		{
			dptr[DataCnt++] = hibyte(Aid_OverIn_LTE);
			dptr[DataCnt++] = lobyte(Aid_OverIn_LTE);
			dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_LTE;
			dptr[DataCnt++] = 0x00;
		}
 
		if(PwrAlarmChange.FwdOutUpperLmtFail_LTE)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE);
			dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE);
			dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_LTE;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutLowerLmtFail_LTE)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE);

			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_LTE;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.OverInAlarm_CDMALTE)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOtherOverIn_Common);
			dptr[DataCnt++] = lobyte(Aid_FwdOtherOverIn_Common);
			dptr[DataCnt++] = PwrAlarm.OverInAlarm_CDMALTE;
			dptr[DataCnt++] = 0x00;
		}


		///////////////////////////////////LTE_A2
		if(PwrAlarmChange.FwdInUpperLmtFail_LTE_A2)
		{
			dptr[DataCnt++] = hibyte(Aid_OverIn_LTE_A2);
			dptr[DataCnt++] = lobyte(Aid_OverIn_LTE_A2);

			dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_LTE_A2;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutUpperLmtFail_LTE_A2)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE_A2);
			dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE_A2);
			dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_LTE_A2;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.FwdOutLowerLmtFail_LTE_A2)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE_A2);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE_A2);
			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_LTE_A2;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.OverInAlarm_LTE_A)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOtherOverIn_LTE_A);
			dptr[DataCnt++] = lobyte(Aid_FwdOtherOverIn_LTE_A);
			dptr[DataCnt++] = PwrAlarm.OverInAlarm_LTE_A;
			dptr[DataCnt++] = 0x00;
		}
		////////////
		if((PwrAlarmChange.LocalFail_CDMALTE))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_CDMALTE);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_CDMALTE);
			dptr[DataCnt++] = PwrAlarm.LocalFail_CDMALTE;
			dptr[DataCnt++] = 0x00;
		}

		if((PwrAlarmChange.LocalFail_LTE_A))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_LTE_A);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_LTE_A);
			dptr[DataCnt++] = PwrAlarm.LocalFail_LTE_A;
			dptr[DataCnt++] = 0x00;
		}

		if((PwrAlarmChange.LocalFail_WCDMALTE_21))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_WCDMALTE_21);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_WCDMALTE_21);
			dptr[DataCnt++] = PwrAlarm.LocalFail_WCDMALTE_21;
			dptr[DataCnt++] = 0x00;
		}
		////////////////////////////////////// RVS
		if(PwrAlarmChange.RvsOutUpperLmtFail_3G)
		{
			dptr[DataCnt++] = hibyte(Aid_RvsOscilation_3G);
			dptr[DataCnt++] = lobyte(Aid_RvsOscilation_3G);

			dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_3G;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.RvsOutUpperLmtFail_2G)
		{
			dptr[DataCnt++] = hibyte(Aid_RvsOscilation_2G);
			dptr[DataCnt++] = lobyte(Aid_RvsOscilation_2G);

			dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_2G;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.RvsOutUpperLmtFail_LTE)
		{
			dptr[DataCnt++] = hibyte(Aid_RvsOscilation_LTE);
			dptr[DataCnt++] = lobyte(Aid_RvsOscilation_LTE);

			dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_LTE;
			dptr[DataCnt++] = 0x00;
//			Ser3Ptr->printf("1: RvsOutUpperLmtFail_LTE\n");
			
		}

		if(PwrAlarmChange.RvsOutUpperLmtFail_LTE_A2)
		{
			dptr[DataCnt++] = hibyte(Aid_RvsOscilation_LTE_A2);
			dptr[DataCnt++] = lobyte(Aid_RvsOscilation_LTE_A2);

			dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_LTE_A2;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.RvsOutUpperLmtFail_LTE_21)
		{
			dptr[DataCnt++] = hibyte(Aid_RvsOscilation_LTE_21);
			dptr[DataCnt++] = lobyte(Aid_RvsOscilation_LTE_21);

			dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_LTE_21;
			dptr[DataCnt++] = 0x00;

//			Ser3Ptr->printf("1: RvsOutUpperLmtFail_LTE_21\n");
			
		}
///////////////////////////////////

		if(PwrAlarmChange.FwdAmpOnOff_2G)	
		{
			dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_2G);
			dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_2G);
			if(PwrAlarm.FwdAmpOnOff_2G)	dptr[DataCnt++] = 0x01;
			else						dptr[DataCnt++] = 0x00;

			dptr[DataCnt++] = 0x01;
			dptr[DataCnt++] = tDnrSts->AmpOffCase_2G;	
		}	

		if(PwrAlarmChange.FwdAmpOnOff_LTE)	
		{
			dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_LTE);
			dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_LTE);
			if(PwrAlarm.FwdAmpOnOff_LTE)	dptr[DataCnt++] = 0x01;
			else							dptr[DataCnt++] = 0x00;
			dptr[DataCnt++] = 0x01;
			dptr[DataCnt++] = tDnrSts->AmpOffCase_LTE;	
//			Ser3Ptr->printf("1: FwdAmpOnOff_LTE\n");
			
		}	

		if(PwrAlarmChange.FwdAmpOnOff_LTE_A2) 
		{
			dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_LTE_A2);
			dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_LTE_A2);
			if(PwrAlarm.FwdAmpOnOff_LTE_A2)	dptr[DataCnt++] = 0x01;
			else							dptr[DataCnt++] = 0x00;

			dptr[DataCnt++] = 0x01;
			dptr[DataCnt++] = tDnrSts->AmpOffCase_LTE_A2;
		}	

		if(PwrAlarmChange.FwdAmpOnOff_3G)	
		{
			dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_3G);
			dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_3G);
			if(PwrAlarm.FwdAmpOnOff_3G)	dptr[DataCnt++] = 0x01;
			else						dptr[DataCnt++] = 0x00;

			dptr[DataCnt++] = 0x01;
			dptr[DataCnt++] = tDnrSts->AmpOffCase_3G;
		}	

		if(PwrAlarmChange.FwdAmpOnOff_LTE_21) 
		{
			dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_LTE_21);
			dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_LTE_21);
			if(PwrAlarm.FwdAmpOnOff_LTE_21)	dptr[DataCnt++] = 0x01;
			else							dptr[DataCnt++] = 0x00;

			dptr[DataCnt++] = 0x01;
			dptr[DataCnt++] = tDnrSts->AmpOffCase_LTE_21;

			
//			Ser3Ptr->printf("1: FwdAmpOnOff_LTE_21\n");
		}	


		if(PwrAlarmChange.ULGainLowAlarm_LTEA)
		{
			dptr[DataCnt++] = hibyte(Aid_ULGainLowAlarm_LTEA);
			dptr[DataCnt++] = lobyte(Aid_ULGainLowAlarm_LTEA);
		
			dptr[DataCnt++] = PwrAlarm.ULGainLowAlarm_LTEA;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.ULGainLowAlarm_CDMALTE)
		{
			dptr[DataCnt++] = hibyte(Aid_ULGainLowAlarm_CDMALTE);
			dptr[DataCnt++] = lobyte(Aid_ULGainLowAlarm_CDMALTE);
		
			dptr[DataCnt++] = PwrAlarm.ULGainLowAlarm_CDMALTE;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.ULGainLowAlarm_WCDMALTE_21)
		{
			dptr[DataCnt++] = hibyte(Aid_ULGainLowAlarm_WCDMALTE_21);
			dptr[DataCnt++] = lobyte(Aid_ULGainLowAlarm_WCDMALTE_21);
		
			dptr[DataCnt++] = PwrAlarm.ULGainLowAlarm_WCDMALTE_21;
			dptr[DataCnt++] = 0x00;
		}

		if(PwrAlarmChange.DigitalAlarm)
		{
			dptr[DataCnt++] = hibyte(Aid_DigitalAlarm);
			dptr[DataCnt++] = lobyte(Aid_DigitalAlarm);
		
			dptr[DataCnt++] = PwrAlarm.DigitalAlarm;
			dptr[DataCnt++] = 0x00;
		}

	}
	Ser3Ptr->printf("2: DnrAlarmReport[%d]\n",DataCnt);

	/////////////////// 필수 항목 /////////////////////////////////////
	if(DataCnt)
	{
		dptr[DataCnt++] = 0xff; 				// A_ID
		dptr[DataCnt++] = 0xff;
		
		dptr[DataCnt++] = 10;					// len

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[1]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[1]);

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[1]);

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[1]);

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_21[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_21[1]);
	}
	return(DataCnt);
}
#endif

INT16S Rfatoi( INT8U *str, INT8U Len )
{
	INT8U	St = 0, i;
	INT32S	value = 0; 
	// 20100317: value 값이 3G에서는 채널 값등이,  아래 x10 하는데서 오버플로 날 수 있으므로, 32비트로 변경.

	for( i=0; i<Len; i++ )
	{
		if( str[i] == '-' ) St = 1;
		else
		{
			value += (str[i] -'0');
			value = value * 10;
		}
	}
	
	value = value / 10;
	
	if( St ) value *= (-1);
	
	return value;
}



#if 0
Boot Alarm
	
AT*SKTR*SMSMO=01071065483,01021468701,,0,,,FFFFFF82B580848C958180B5C1           
                                                                                
                        

118.67.190.46

100

118.67.190.47번 이걸로 쓰시면 됩니다,~
서브넷 255.255.255.0
게이트 118.67.190.1


*SKTR*RFSTS:10737,4,10664,10689,10713,10738,1,8(-5),0,-83,-16,-19               

*SKTR*PILOT:8,-5.0,0,0.0,0,0.0,0,0.0

///////////////////////////////////
*SKTR*RFSTS:29,3,111,29,70,1,402(-9),0,-84,-4,-15                               
                                                                                
OK                

*SKTR*RFSTS:10713,4,10664,10689,10713,10738,1,8(-7),0,-88,0,0                   
                                                                                
OK 



10713,4,10664,10689,10713,10738,1,8(-7),0,-88,0,0  

10737,4,10664,10689,10713,10738,1      ,8(-5),0  ,-83,-16,-19   
   29,3,111  ,29   ,70   ,1    ,402(-9),0    ,-84,-4,-15 


Download 5'52'' 80kbyte
#endif



///////////////////////////////////////////////

INT8U Ascii2Hex ( INT8U Upper,INT8U Lower )
{
	if ( Upper >= 0x41 ) Upper = Upper - 0x07;
	if ( Lower >= 0x41 ) Lower = Lower - 0x07;
	return ( ((Upper-0x30)<<4)|(Lower-0x30) );
}


//=====================================================================//


INT8U AHex2Dig( INT8U *d )
{
	INT8U Value;
	Value = ( ( atoh( d[0] ) << 4 ) & 0xF0 ) | ( atoh( d[1] ) & 0x0F );
	return Value;
}

INT32U FTPRxProtocolCheck(__ProtocolPtr *nPtr,INT8U *rbuf,INT16U Len,INT16U Cnt,INT16U FrameCnt)
{
	INT16U i = 0;
	INT16U nCnt = 0;
	INT8U SubLen[2] = {0,};

	int buffer_size;
	unsigned char buffer[2048];

 	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__BODYFRAME *BodyFrame = &Recv->BodyFrame[0];

	BodyFrame->CrcOK = TRUE;

#if 0
	Ser3Ptr->printf("ProtocolCheck[%d]\n", Len);
	for ( i = 0; i< Len; i++ )
	{
		pUSART3.printf("%02x ", rbuf[i]);
	}
	
	pUSART3.printf("\n");
#endif	

	protocol_frame_to_buffer(rbuf, Len, buffer, &buffer_size);

#if 0
	Ser3Ptr->printf("Byte Stuffing[%d]>[%d]\n", buffer_size,Cnt);
	for ( i = 0; i< buffer_size; i++ )
	{
		pUSART3.printf("%02X ", buffer[i]);
	}
	
	pUSART3.printf("\n");
#endif							

	BodyFrame->SubID[0] = 0xff;
	BodyFrame->SubID[1] = 0xff;
	BodyFrame->SubID[2] = 0xff;

	SubLen[1] = buffer[nCnt++];
	SubLen[0] = buffer[nCnt++];
	BodyFrame->SubLength = (SubLen[0] << 8) + (SubLen[1]) + 2;

	BodyFrame->SubLen[0] = (INT8U)(BodyFrame->SubLength >> 8);
	BodyFrame->SubLen[1] = (INT8U)(BodyFrame->SubLength >> 0);


	BodyFrame->SubData[0] = (INT8U)(FTPFrameCnt >> 8);
	BodyFrame->SubData[1] = (INT8U)(FTPFrameCnt >> 0);

//FTPFrameCnt
	for(i = 0; i < BodyFrame->SubLength; i++)
	{
		*((INT8U *)BodyFrame->SubData + i + 2) = buffer[nCnt++];
	}
	
	{
		INT16U calc_fcs = HDLC_FCS_START; /* init CRC */
		calc_fcs = makeFCS((INT8U*)&buffer,BodyFrame->SubLength,&calc_fcs);
		calc_fcs ^= 0xffff;
		BodyFrame->Crc = calc_fcs;
//		Ser3Ptr->printf("calc_fcs[%d]:[%x][%x][%x]\n",BodyFrame->SubLength, calc_fcs,BodyFrame->SubData[BodyFrame->SubLength],BodyFrame->SubData[BodyFrame->SubLength + 1]);
	}


	if (   ( (INT8U)(BodyFrame->Crc >> 8)!= BodyFrame->SubData[BodyFrame->SubLength + 1] )
		|| ( (INT8U)(BodyFrame->Crc	   )!= BodyFrame->SubData[BodyFrame->SubLength] )	)
	{
		//CRC ERROR!!
		BodyFrame->CrcOK = FALSE;
//		return TRUE;
		return FALSE;
	}
	else

	{
		BodyFrame->Crc = Crc16Calc ((INT8U *)BodyFrame->SubID, 7 + i, NULL);
		BodyFrame->SubData[BodyFrame->SubLength+1] = (INT8U)(BodyFrame->Crc >> 8);
		BodyFrame->SubData[BodyFrame->SubLength] = (INT8U)(BodyFrame->Crc 	);

		return TRUE;
	}
}

// 수신 프레임을 처리 해서 버퍼에 저장
unsigned protocol_frame_to_buffer(unsigned char* frame, int frame_size, unsigned char* buffer, int* buffer_size)
{
	int i;
	int j;
	int k;

	for(k = 0; k < frame_size; k++)	// Stuffing 처리
	{
		if(frame[k] == 0x7E) break;
	}

	for(i = k + 1, j = 0; j < frame_size - 1; i++, j++)	// Stuffing 처리
	{
		if(0x7D == frame[i])
		{
			i++;
			buffer[j] = 0x20 ^ frame[i];
		}
		else buffer[j] = frame[i];
	}

	*buffer_size = j;

	return 1;
}


void FTPSts(INT8U *dptr,INT16U Len)
{
	INT16U rlen = 0;
	INT8U i = 0, j = 0, DataCnt=0, DataCnt2=0;
	INT8U tHour[6] ={0,};
	INT8U Buff[4] = {0,};

	for(i = 0; i < 20;i++)
	{
		tDnrSts->FTP_ID[i] = 0x00;
		tDnrSts->FTP_PW[i] = 0x00;
		tDnrSts->FTP_DnFilePath[i] = 0x00;
		tDnrSts->FTP_DnFileName[i] = 0x00;
	}

#if 0
	for(i = 0; i < Len;i++)
	{
		pUSART3.printf("[%x]",dptr[i]);
	}
	pUSART3.printf("\n");
#endif

	tDnrSts->FTP_Port	= dptr[0];
	DataCnt2 = 1;

	for ( i = 0; i< 20; i++ ) if ( dptr[DataCnt++] == '.' ) break;
	rlen = (DataCnt - DataCnt2) - 1;

	for ( i = 0; i < rlen; i++ )
	{
		Buff[i] = 0;
		Buff[i] = atoh(dptr[DataCnt2 + i]);
	}
	if(rlen == 1)
	{
		tDnrSts->FTP_IP[0] = Buff[0];
	}
	else if(rlen == 2)
	{
		tDnrSts->FTP_IP[0] = Buff[0]*10 + Buff[2]*1;
	}
	else if(rlen == 3)
	{
		tDnrSts->FTP_IP[0] = Buff[0]*100 + Buff[1]*10 + Buff[2]*1;
	}	
	DataCnt2 = DataCnt;

	for ( i = 0; i< 20; i++ ) if ( dptr[DataCnt++] == '.' ) break;
	rlen = (DataCnt - DataCnt2) - 1;

	for ( i = 0; i < 4; i++ )		Buff[i] = 0;
	
	for ( i = 0; i < rlen; i++ )
	{
		Buff[i] = atoh(dptr[DataCnt2 + i]);
	}

	if(rlen == 1)
	{
		tDnrSts->FTP_IP[1] = Buff[0];
	}
	else if(rlen == 2)
	{
		tDnrSts->FTP_IP[1] = Buff[0]*10 + Buff[1]*1;
	}
	else if(rlen == 3)
	{
		tDnrSts->FTP_IP[1] = Buff[0]*100 + Buff[1]*10 + Buff[2]*1;
	}	
	DataCnt2 = DataCnt;

	for ( i = 0; i< 20; i++ ) if ( dptr[DataCnt++] == '.' ) break;
	rlen = (DataCnt - DataCnt2) - 1;

	for ( i = 0; i < 4; i++ )		Buff[i] = 0;
	for ( i = 0; i < rlen; i++ )
	{
		Buff[i] = atoh(dptr[DataCnt2 + i]);
	}
	if(rlen == 1)
	{
		tDnrSts->FTP_IP[2] = Buff[0];
	}
	else if(rlen == 2)
	{
		tDnrSts->FTP_IP[2] = Buff[0]*10 + Buff[1]*1;
	}
	else if(rlen == 3)
	{
		tDnrSts->FTP_IP[2] = Buff[0]*100 + Buff[1]*10 + Buff[2]*1;
	}	
	DataCnt2 = DataCnt;
//	pUSART3.printf("IP2: [%d][%d][%d][%d]>[%d]\n",Buff[0],Buff[1],Buff[2],tDnrSts->FTP_IP[2],DataCnt2);

	for ( i=0; i< 20; i++ ) if ( dptr[DataCnt++] == ',' ) break;
	rlen = (DataCnt - DataCnt2) - 1;

	for ( i = 0; i < 4; i++ )		Buff[i] = 0;
	for ( i = 0; i < rlen; i++ )
	{
		Buff[i] = atoh(dptr[DataCnt2 + i]);
	}
	if(rlen == 1)
	{
		tDnrSts->FTP_IP[3] = Buff[0];
	}
	else if(rlen == 2)
	{
		tDnrSts->FTP_IP[3] = Buff[0]*10 + Buff[1]*1;
	}
	else if(rlen == 3)
	{
		tDnrSts->FTP_IP[3] = Buff[0]*100 + Buff[1]*10 + Buff[2]*1;
	}	
	DataCnt2 = DataCnt;

	for ( i = 0; i< 20; i++ ) if ( dptr[DataCnt++] == ',' ) break;
	tDnrSts->FTP_ID_len = (DataCnt - DataCnt2) - 1;

	for ( j = 0; j < tDnrSts->FTP_ID_len; j++ )
	{
		tDnrSts->FTP_ID[j]	= dptr[DataCnt2+j];
	}
	DataCnt2 = DataCnt;

//// PW
	for ( i = 0; i < 20; i++ ) if ( dptr[DataCnt++] == ',' ) break;
	tDnrSts->FTP_PW_len = (DataCnt - DataCnt2) - 1;
	for ( j = 0; j < tDnrSts->FTP_PW_len; j++ )
	{
		tDnrSts->FTP_PW[j]	= dptr[DataCnt2+j];
	}
	DataCnt2 = DataCnt;
//// DnFilePath
	for ( i = 0; i < 20; i++ ) if ( dptr[DataCnt++] == ',' ) break;
	tDnrSts->FTP_DnFilePath_len = (DataCnt - DataCnt2) - 1;
	for ( j = 0; j < tDnrSts->FTP_DnFilePath_len; j++ )
	{
		tDnrSts->FTP_DnFilePath[j]	= dptr[DataCnt2+j];
	}
	DataCnt2 = DataCnt;
//// FTP_DnFileName
	for ( i = 0; i < 20; i++ ) if ( dptr[DataCnt++] == ',' ) break;
	
	tDnrSts->FTP_DnFileName_len = (DataCnt - DataCnt2) - 1;
	for ( j = 0; j < tDnrSts->FTP_DnFileName_len; j++ )
	{
		tDnrSts->FTP_DnFileName[j]	= dptr[DataCnt2+j];
	}

	if((tDnrSts->FTP_DnFileName[0] == 'G')&&(tDnrSts->FTP_DnFileName[1] == 'S')&&(tDnrSts->FTP_DnFileName[2] == 'T')
		&&(tDnrSts->FTP_DnFileName[3] == 'R')&&(tDnrSts->FTP_DnFileName[4] == 'D')&&(tDnrSts->FTP_DnFileName[5] == 'D')
		&&(tDnrSts->FTP_DnFileName[6] == 'T')&&(tDnrSts->FTP_DnFileName[6] == 'U'))
	{
		DNMode = 1;
	}
	else
	{
		DNMode = 0;
	}


	
	DataCnt2 = DataCnt;
//// 
	for ( j = 0; j < 6; j++ )
	{
		tHour[j] = dptr[DataCnt2+j];
	}

	tDnrSts->FTP_DnHours[0] = tHour[0]>>1; 
	tDnrSts->FTP_DnHours[1] =(((tHour[0]& 0x01)<<7)& 0xff)|tHour[1];

	tDnrSts->FTP_DnHours[2] = tHour[2];
	tDnrSts->FTP_DnHours[3] = tHour[3];
	tDnrSts->FTP_DnHours[4] = tHour[4];
	tDnrSts->FTP_DnHours[5] = tHour[5];


	{
		EE_BACK1 *tptr = &gEE_BACK1;

		for(i = 0; i < 4; i++)
		{
			tptr->BackUp.FTP_IP[i] = tDnrSts->FTP_IP[i];
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_IP[i]), tDnrSts->FTP_IP[i], 0);
		}

		{
			tptr->BackUp.FTP_Port = tDnrSts->FTP_Port;
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_Port), tDnrSts->FTP_Port, 0);
		}

		for(i = 0; i < 20; i++)
		{
			tptr->BackUp.FTP_ID[i] = tDnrSts->FTP_ID[i];
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_ID[i]), tDnrSts->FTP_ID[i], 0);
		}

		for(i = 0; i < 20; i++)
		{
			tptr->BackUp.FTP_PW[i] = tDnrSts->FTP_PW[i];
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_PW[i]), tDnrSts->FTP_PW[i], 0);
		}

		for(i = 0; i < 20; i++)
		{
			tptr->BackUp.FTP_DnFilePath[i] = tDnrSts->FTP_DnFilePath[i];
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_DnFilePath[i]), tDnrSts->FTP_DnFilePath[i], 0);
		}

		for(i = 0; i < 20; i++)
		{
			tptr->BackUp.FTP_DnFileName[i] = tDnrSts->FTP_DnFileName[i];
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_DnFileName[i]), tDnrSts->FTP_DnFileName[i], 0);
		}

		for(i = 0; i < 6; i++)
		{
			tptr->BackUp.FTP_DnHours[i] = tDnrSts->FTP_DnHours[i];
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FTP_DnHours[i]), tDnrSts->FTP_DnHours[i], 0);
		}
	}
}


INT16U FTPDownloadheck(__ProtocolPtr *nPtr)
{
	INT8U nRet = TRUE;

	INT16U year;
	INT16U FTPyear;
	
	FTPyear = ((tDnrSts->FTP_DnHours[0]<< 8)& 0xff00) + ((tDnrSts->FTP_DnHours[1]<< 0)& 0x00ff);
	year = TwoAsciDeciNum2OneHex(sms_time.Year[0],sms_time.Year[1])*100 + TwoAsciDeciNum2OneHex(sms_time.Year[2],sms_time.Year[3]);

	if((year >= FTPyear)&&(tDnrSts->System_Time[1] >= tDnrSts->FTP_DnHours[2])&&
		(tDnrSts->System_Time[2] >= tDnrSts->FTP_DnHours[3])&&
		(tDnrSts->System_Time[3] >= tDnrSts->FTP_DnHours[4])&&
		(tDnrSts->System_Time[4] >= tDnrSts->FTP_DnHours[5]))
	{
		pUSART3.printf("OK\n");
		nRet = TRUE;
	}
	else
	{
		pUSART3.printf("NOK\n");
		nRet = FALSE;
	}
	
	return nRet;
}


INT32U FTP_Mode(INT8U Mode,__ProtocolPtr *nPtr)
{
	INT32U nRet = TRUE;

	if( Mode == Index_FTPFileSize)
	{
		nRet = ModemFTPSize(tDnrSts->FTP_DnFileName);
		tDnrSts->FTPFileSize.uD32 = FTPFileSizeRxCheck(RxDataBuff);
	}
	else if( Mode == Index_FTPFileErase)
	{
		ModemFTPFileErase(tDnrSts->FTP_DnFileName);
		BcMdemSyncProtocolCheck1();
	}
	else if( Mode == Index_FTPGet)
	{
		INT16U tmp = 0;
		INT16U len = 0;
		INT16U i = 0;

		ModemFTPSize(tDnrSts->FTP_DnFileName);
		tDnrSts->FTPFileSize.uD32 = FTPFileSizeRxCheck(RxDataBuff);
		
		FTPTotFrame = tDnrSts->FTPFileSize.uD32/tDnrSts->FTPFileStep.uD16;
		if(tDnrSts->FTPFileSize.uD32%tDnrSts->FTPFileStep.uD16)FTPTotFrame = FTPTotFrame +1;

		tDnrSts->FTPTotFrame.uD16 = FTPTotFrame;

		pUSART3.printf("FTPTotFrame = [%d]\n", FTPTotFrame);

		{
			for ( i = 0; i < (FTPTotFrame); i++ )
			{
				FTPFrameCnt = tDnrSts->FTPFrameCnt.uD16;

				ModemFTPFileGet(tDnrSts->FTP_DnFileName,FTPFrameCnt,tDnrSts->FTPFileStep.uD16,TrsnsferMode);

				{
					len = BcMdemSyncProtocolCheck_Mode(RxDataBuff,tDnrSts->FTPFileStep.uD16);
					tmp = FTPRxProtocolCheck(SmsSer,RxDataBuff,len,tDnrSts->FTPFrameCnt.uD16,FTPFrameCnt);
					tmp = tmp;

					DnReceiveData(SmsSer);

				}
				tDnrSts->FTPFrameCnt.uD16 = tDnrSts->FTPFrameCnt.uD16 + 1;
			}

			{
				INT32U t = *((INT32U *)(__pAPBK_SRAMAddr + 40));	// jump base addr + selfaddinfo address
				INT32U s = *((INT32U *)(__pAPBK_SRAMAddr + 36));	// jump base addr!!
				selfinfo *p = (selfinfo *)(__pAPBK_SRAMAddr + (t-s));

				pUSART3.printf("2: DataCount = [%s][%s] \n", p->infor[0],convinfo.infor[0]);

				if(!memcmp(p->infor[0], convinfo.infor[0], strlen(convinfo.infor[0])))
				{
					DownloadFlagSetExtSRAM(DataCount);
					OSTimeDly(100L);
					DownLoadBootingJump();
				}
			}
		}
		
		tDnrSts->FTPIndex  = 0;
	}
	else if( Mode == Index_FTPOnen)
	{
		INT8S tmp = 0;
		INT16U nCnt = 0;
		FTPFileSize = 0;
		INT8S Mode = 0;

		if( DNMode == 0)
		{
			TimerRegist(TimerDNMode, Time1Sec*20L);
		}
		else
		{
			TimerRegist(TimerDNMode, Time1Min*20L);
		}


		ModemFTPOpen(tDnrSts->FTP_IP,tDnrSts->FTP_Port,tDnrSts->FTP_ID,tDnrSts->FTP_PW,tDnrSts->FTP_DnFilePath,tDnrSts->FTP_DnFileName);
FTPDNCheck:

		tmp = FTPGetRxCheck(&Mode);

		if(Mode == 4)
		{
			tDnrSts->FTPFileSize.uD32 = tmp;
		}

		if(TimeOverCheck(TimerDNMode))
		{
			DNModeMaxCnt = SET;
		}

//		if(( nCnt++ > 10* 10)||(Mode == 6))
		if((DNModeMaxCnt)||(Mode == 6))
		{
		
		}
		else
		{
			if( DNMode == 0)
			{
				DNModeCnt = 1000L*5L;
			}
			else
			{
				DNModeCnt = 1000L*10L;
			}

			OSTimeDly(DNModeCnt);
			goto FTPDNCheck;
		}	

		ModemFTPSize(tDnrSts->FTP_DnFileName);
		tDnrSts->FTPFileSize.uD32 = FTPFileSizeRxCheck(RxDataBuff);

		Ser3Ptr->printf("4 : nCnt[%d]>[%d]\n",nCnt,tmp);
	}	
#if 1
	else if( Mode == Index_ModemBaudRate)
	{
		ModemBaudRateSet();

		Ser4Ptr = &pUSART4; 										
		Ser4Ptr->init(230400L, (_DATA8BIT | _1_STOP | _NONPARITY));
	}
#endif	
	return nRet;
}



