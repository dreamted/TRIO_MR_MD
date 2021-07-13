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

void SmsInit(void)
{
	SmsSer = &SmsSerB;

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

	
	SmsSer->Sem = OSSemCreate(1);
	
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

	BcMdemDebug(iSMS_Debug_Mode, (INT32S *)SerPtr);

	BootAlarmFlag = TRUE;		
	goto RETRY_START;

SWRST_START:
	BcMdemTcpExit();
	SmsResetPeriodFlag = TRUE;
	
		
PWRST_START:
	USART1Printf("PWRST_START \n");
	if(tDnrSts->ModemOnOff == Disable)  goto PWRST_START;

	InitCnt = 0;
	SMS_PWR = 1;
	OSTimeDly(1000L*5L);
	SMS_PWR = 0;	

	BootAlarmFlag = TRUE;
	OneDayResetCnt = NULL;
	TcpDnLoadFlag = RESET;
				
	OSTimeDly(1000L*20L);

	if(AutoResetFlg)
	{
		AutoResetFlg = RESET;
		TimerRegist(Timer_ModemReset, Time1Day*1L);
	}

	
RETRY_START:
	USART1Printf("RETRY_START \n");
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
		}
		DnrSMS2Data();
		Auto_ResetCheckInit();

		#ifdef __SmsDebug
			iSMS_Debug_Mode = SET;
		#else
			iSMS_Debug_Mode = RESET;
		#endif

		while(1)
		{
			if(!tTestFlag)
			{
//				if(!WRCS_DownLoadGiveupTimerSet(NULL))
				while(!WRCS_DownLoadGiveupTimerSet(NULL))
				{
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
					
					{
						s = CdmaFuncselect();
						switch(s)
						{
							case SELF_RECV:
							if( (sms_len = BcMdemRecv(sms_buff, sentTel, &sms_time)) > 0)
							{
								if(0)
								{
									USART1PutStr(sms_buff, sms_len, ENABLE);
									USART1Printf("\n");
									USART1Printf("SendTel: %s \n", sentTel);
									USART1Printf("sms_len: %d \n", sms_len);
								
									USART1Printf("Arrive Time: %s %s %s %s %s %s %s\n",
								
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
									if(TcpDnLoadFlag) goto TCP_DNLOAD;
								}
							}
							#if 0
							else
							{
	 							if(PcFreqStsRqstFlag)
								{
									INT8U tid[3] = {0xff, 0xff, 0xff};
									SpecFreqState_RspFunc(tid,RadioAutoReport,2,NormalMode,nPtr);
									PcFreqStsRqstFlag = FALSE;
								}	
	  

								///////// SEND ///////////
								if((BcMRtryNo < MaxTryNo)&&(LockOrder == 1))
								{
									OSTimeDly(1000L*2L);
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

									SmsAlarm();

//									SmsAutoReportCheck(nPtr);

									DnrSMS2Data();

									if(SetSMS_PWR)
									{
										ModemPwrOFF();
										OSTimeDly(1000*10L);
										
										SetSMS_PWR = RESET;
									}
								}
								else if(LockOrder == 0)
								{
									if( LockOrderCnt++ > 5*30)	 /// 1이 2초 
									{
										LockOrderCnt = 0;
										chkLockOrder = chkLockOrder + 1;

										if( chkLockOrder >= 3 ) 
										{
	//										tDnrSts->ModemOnOff = Disable;
										}
										else
										{
											goto ModemLock_START;
										}
									}
								}
							}
							#endif
							break;

							case SELF_TIME:
//								SmsAutoReportCheck(nPtr);
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
//									OSTimeDly(1000L*2L);

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

									if(SetSMS_PWR)
									{
										ModemPwrOFF();
										OSTimeDly(1000*10L);
										SetSMS_PWR = RESET;
									}
								}
								else if(LockOrder == 0)
								{
									if( LockOrderCnt++ > 5*30)	 /// 1이 2초 
									{
										LockOrderCnt = 0;
										chkLockOrder = chkLockOrder + 1;

										if( chkLockOrder >= 3 ) 
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
					}	
				OSTimeDly(1000L);
//				OSTimeDly(500L);
			}
			while(WRCS_DownLoadGiveupTimerSet(NULL))
			{
	TCP_DNLOAD: 
				if(BcMdemTCPRxCheck(tcp_buff))
				{	
					if(TCPProtocolCheck(nPtr)) TCPComCheck(nPtr);
				}
//				USART1Printf("TCP_DNLOAD \n");	
//				OSTimeDly(500);
				OSTimeDly(100L);
			}		
		}
		else OSTimeDly(500L);			
	}
}

void Auto_ResetCheckInit(void)
{
	if		( tDnrSts->RepeatResetPriod == 0x01 )	tPeriod = ((24L*3600L)*1)/2;
	else if ( tDnrSts->RepeatResetPriod == 0x02 )	tPeriod = ((24L*3600L)*3)/2;
	else if ( tDnrSts->RepeatResetPriod == 0x03 )	tPeriod = ((24L*3600L)*7)/2;
	else if ( tDnrSts->RepeatResetPriod == 0x04 )	tPeriod = ((24L*3600L)*10)/2;	
	else if ( tDnrSts->RepeatResetPriod == 0x05 )	tPeriod = ((24L*3600L)*30)/2;
	else 											tPeriod = ((24L*3600L)*1)/2;

	OneDayPeriod = (24L*3600L)*1;

	CheckTime(tDnrSts->ResetPeriodCountSet,tPeriod);
}


void CheckTime(INT8U *tCount,INT32U tTime)
{
	INT32U Temp,Temp1,Temp2;

	Temp = tTime / 60;

	Temp1 = Temp % 60;
	Temp2 = Temp / 60;

	tCount[2] = (INT8U)Temp1;
	tCount[1] = (INT8U)(Temp2 % 24);
	tCount[0] = (INT8U)(Temp2 / 24);
}

void AutoResetCheck(void)
{
	AutoResetCnt++;
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

	if(AutoResetCnt > tPeriod )
	{
		BcMRtryNo = MaxTryNo;
		AutoResetCnt = NULL;	
		AutoResetFlg = SET;
	}

	CheckTime(tDnrSts->ResetPeriodCountSts,OneDayResetCnt);
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
	if( cur_10s_time>=Init_ar_time[idx] )
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
		chkDnrAlarmReport = RESET;
	}
}

void SmsAutoReportCheck(__ProtocolPtr *nPtr)
{
	INT8U tid[3] = {0xff, 0xff, 0xff};
	
//	WhatTime();

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
		INT8U *dptr = (INT8U *)Recv->SubData;

		for(i = 0; i < (Recv->SubLength + 2); i++) *dptr++ = sms_buff[DataCnt++] & 0x7f;

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
	//INT8U DataCnt=0;

	__BODYFRAME *Recv = nPtr->SmsRecv;
	__BODYFRAME *Send = nPtr->SmsSend;
 
 	Comm = WhatRxSms(nPtr);

    INT8U tid[3] = {Recv->SubID[0], Recv->SubID[1], Recv->SubID[2]};

	
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

		

		case InforStsQue:	
			tcnt = GenEtcStsAid((INT8U *)Send->SubData,tDnrSts);
			SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, Comm,SmsSer);
		break;
		
		case ControlQue:
		case RadioSetRQST:

//			if(Sms_Response_Control(tid,Comm,SmsSer)== TRUE)
			if(Sms_Response_Control(SmsSer,TRUE)== TRUE)
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
		break;

		case AlarmMaskSetSCODE:
			tDnrSts->AlarmMask = Recv->SubData[0];
			SaveBackupData();	
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
  
	{
		tcnt = GenEtcStsAid((INT8U *)Send->SubData,tDnrSts);
		SmsDataAckTx(tid, (INT8U *)Send->SubData, tcnt, InforStsQue,SmsSer);
	}
	
	if(SET_ULAlarmCnt)
	{
		tDnrSts->RvsOverInAlarmCount		= 0;
		tDnrSts->RvsOtherOverInAlarmCount	= 0;
		SET_ULAlarmCnt = SET;
	}

#ifdef __RvsCount
	if(Chk_RvsOSCAlarmCount)
	{
		tDnrSts->CurrRvsOSCAlarmCount_3G      = 0;		
		tDnrSts->CurrRvsOSCAlarmCount_2G      = 0;		
		tDnrSts->CurrRvsOSCAlarmCount_LTE     = 0; 	
		tDnrSts->CurrRvsOSCAlarmCount_LTE_A1  = 0;	
		tDnrSts->CurrRvsOSCAlarmCount_LTE_A2  = 0;	
		tDnrSts->CurrRvs1OSCAlarmCount_LTE    = 0;	
		tDnrSts->CurrRvs1OSCAlarmCount_LTE_A1 = 0;
		tDnrSts->CurrRvs1OSCAlarmCount_LTE_A2 = 0;

		Chk_RvsOSCAlarmCount = RESET;
	}
#endif
	
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
	INT32U cpu_sr;
	
	__BODYFRAME *Recv = nPtr->SmsRecv;

	ModemEsnCheck();

	OS_ENTER_CRITICAL();
	{
		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
		
  		while(Recv->SubLength >  Len)
		{

			A_ID[0] = (INT8U)(Recv->SubData[Len++]);
			A_ID[1] = (INT8U)(Recv->SubData[Len++]);
			AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
			Length = Recv->SubData[Len++];

			for (i = 0 ; i<Length && i < 40; i++) AID_Value[i] = (INT8U)(Recv->SubData[Len++]);

			rval += SetCtrlData(AID_Command, AID_Value, Length, TRUE,nPtr, tptr);

			if( iMobileESN == NACK) 	return FALSE;

			if(Len >= Recv->SubLength)break;
		}		
		
		if(rval)
		{
			//write eeprom!!
			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
		}
	}
	
	OS_EXIT_CRITICAL();
	
	return TRUE;
}

void SmsDataAckTx (INT8U* tid,  INT8U *Data, INT16U nCnt,  INT8U Comm,__ProtocolPtr *nPtr)
{
	INT16U i;
	INT8U	CHKSUM = 0;
	INT8U err = 0;  
	
	__BODYFRAME  *Send = nPtr->SmsSend;

	OSSemPend(nPtr->Sem, 0, &err);	

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
	
	//CHKSUM = 0xff;	//	지워야함 임시 테스트
		
	Send->SubData[nCnt++] = DataConv(HIGH,CHKSUM);
	Send->SubData[nCnt++] = DataConv(LOW,CHKSUM);

	OSSemPost(nPtr->Sem);

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

	for(i = 0 ;i < 3; i++)
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
	
//	OneDayResetCnt = NULL;	
	
	OSTimeDly(1000*5L);
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

#if 0
BOOL AutoRptChk ( void )
{
	INT8U 	Temp=0;
	long	Period, Present, Base=0;//, Past;
	INT16U	tPresentHour,tPresentMin;

	tPresentHour = PresentHour * 60;
	tPresentMin  = PresentMin * 60 + PresentSec;
	Present = 60*tPresentHour + tPresentMin;
	Base	= (60*tDnrSts->AutoReportBasePer[0] + tDnrSts->AutoReportBasePer[1])* 60;
	Temp	= tDnrSts->AutoReportPriod;


	/* Period 기호 -> 분 */
	if 		( Temp == 0x01 )	Period = 5;
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
	else return(FALSE);

	Period = Period*60;
//	Present = Present;
//	Base = Base;

#if 1	
	if 		( PastMin < tPresentMin ) 
	{
		TimeElapse += (tPresentMin-PastMin);
		if(iSMS_Debug_Mode) USART1Printf("0 : TimeElapse : [%d]:[%d][%d]>[%d]\n",TimeElapse,PastMin,tPresentMin,Period);
	}
	else if ( PastMin > tPresentMin ) 
	{
		TimeElapse += (60+tPresentMin-PastMin);
		
		if(iSMS_Debug_Mode) USART1Printf("1: TimeElapse : [%d]:[%d][%d]>[%d]\n",TimeElapse,PastMin,tPresentMin,Period);
	}

	PastHour = tPresentHour;
	PastMin  = tPresentMin;

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
		if ( Present >= Base )	TimeElapse = (Present-Base)%Period;
		else					TimeElapse = (24*60+Present-Base)%Period;
		return(FALSE);
	}

	tDnrSts->Auto_Remain_Time = (Period - TimeElapse) / 10; 

//	if(iSMS_Debug_Mode) USART1Printf("Auto_Remain_Time : [%d][%d][%d]\n",tDnrSts->Auto_Remain_Time,Period,TimeElapse);

	if ( TimeElapse >= Period )
	{
		TimeElapse = (TimeElapse%Period);
		return(TRUE);
	}
#endif
#if 0
	{
	//	long	Period, Present, Base=0;//, Past;
	//	INT16U	tPresentHour,tPresentMin;

		INT32U	CurrTime;
		long	tPeriod, tBase=0,TmpSum = 0;//, Past;

	//	INT16U	ar_time, period; // 10초단위 환산값.
	//	INT16U	a_r, c_r;

		tBase	= (60*tDnrSts->AutoReportBasePer[0] + tDnrSts->AutoReportBasePer[1])* 60;
		CurrTime = PresentHour * 60 *60 +  PresentMin*60 + PresentSec;

		switch(Temp)
		{
			case 1:
			case 2:
			case 3:
			case 4:
			case 5:
				tPeriod   = Period;
				CurrTime = PresentMin*60 + PresentSec;
				tBase	= tDnrSts->AutoReportBasePer[1]* 60;
//				tTimeElapse += tBase + tPeriod ;
				tTimeElapse += CurrTime;
				TmpSum = ( tBase + tPeriod);

				if( TmpSum < tTimeElapse)
				{
					tTimeElapse = tTimeElapse %TmpSum;

					if(iSMS_Debug_Mode) USART1Printf("3: tPresent [%d][%d] :[%d][%d][%d]\n",tBase,tPeriod,TmpSum,tTimeElapse,CurrTime);
				}
				
				if(iSMS_Debug_Mode) USART1Printf("4: tPresent [%d][%d]:[%d][%d]\n",tBase,tPeriod,tTimeElapse,CurrTime);
			break;



			default:
				
			break;

		}

	}
#endif


	
	return (FALSE);
}
#endif



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

	if(iSMS_Debug_Mode) USART1Printf("TimeElapse [%d][%d]\n",TimeElapse,Period);

	if ( TimeElapse >= Period )
	{
		TimeElapse = (TimeElapse % Period);
		return(TRUE);
	}
	return (FALSE);
}


#if 0
BOOL WavTwoAutoRptChk ( void )
{
	INT8U 	Temp;
	long	Period, Present, Base;
	INT16U	tPresentHour,tPresentMin;
	
	tPresentHour = PresentHour * 60;
	tPresentMin  = PresentMin * 60 + PresentSec;
	Present = 60*tPresentHour + tPresentMin;
	Base	= (60*tDnrSts->WaveCtrl.Radio_ReportTime[0] + tDnrSts->WaveCtrl.Radio_ReportTime[1])* 60;
	Temp	= tDnrSts->WaveCtrl.Radio_ReportPeriod[0];


	/* Period 기호 -> 분 */
	     if ( Temp == 0x01 )	Period = 5;
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
	else return(FALSE);
	Period = Period*60;

	/**********************************************************************
	Period = (Temp>>4)*10 + (Temp&0x0f);
	if ( Period <= 0 )	return(FALSE);
	***********************************************************************/

	if 		( WTwoPastMin < tPresentMin ) WTwoTimeElapse += (tPresentMin-WTwoPastMin);
	else if ( WTwoPastMin > tPresentMin ) WTwoTimeElapse += (60+tPresentMin-WTwoPastMin);

	WTwoPastHour = tPresentHour;
	WTwoPastMin  = tPresentMin;

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
	tDnrSts->AR2_Remain_Time = (Period - WTwoTimeElapse) / 10; 

	// Elapsed Time Over Check //
	if ( WTwoTimeElapse >= Period )
	{	
		WTwoTimeElapse = (WTwoTimeElapse%Period);
		return(TRUE);
	}
	return (FALSE);
}
#endif



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


#if 0
BOOL WavThrAutoRptChk ( void )
{
	INT8U 	Temp;
	long	Period, Present, Base;//, Past;
	INT16U	tPresentHour,tPresentMin;
	
	tPresentHour = PresentHour * 60;
	tPresentMin  = PresentMin * 60 + PresentSec;
	Present = 60*tPresentHour + tPresentMin;
	Base	= (60*tDnrSts->WaveCtrl.Radio_ReportTime[0] + tDnrSts->WaveCtrl.Radio_ReportTime[1])* 60;
	Temp	= tDnrSts->WaveCtrl.Radio_ReportPeriod[1];

	if 		( Temp == 0x01 )	Period = 5;
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
	else return(FALSE);
	Period = Period*60;

	if 		( WThreePastMin < tPresentMin ) WThreeTimeElapse += (tPresentMin-WThreePastMin);
	else if ( WThreePastMin > tPresentMin ) WThreeTimeElapse += (60+tPresentMin-WThreePastMin);

	WThreePastHour = tPresentHour;
	WThreePastMin  = tPresentMin;

	// New Base Time Check //
	if ( WThreeTimeStart )
	{ 	if ( Present>=Base )
		{
			WThreeTimeStart = 0;
			WThreeTimeElapse = 0;
			return(TRUE);
		}
		return(FALSE);
	}

	// New Period Check //
	if ( WThreePeriodStart )
	{	
		WThreePeriodStart = 0;
		if ( Present >= Base )	WThreeTimeElapse = (Present-Base)%Period;
		else					WThreeTimeElapse = (24*60+Present-Base)%Period;
		return(FALSE);
	}
	tDnrSts->AR3_Remain_Time = (Period - WThreeTimeElapse) / 10; 

	// Elapsed Time Over Check //
	if ( WThreeTimeElapse >= Period )
	{	
		WThreeTimeElapse = (WThreeTimeElapse%Period);
		return(TRUE);
	}
	return (FALSE);
}
#endif

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
//	if((BcMType == 0x0C)||(BcMType == 0x0D))
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
		PresentDay = TwoAsciDeciNum2OneHex(sms_time.Day[0],sms_time.Day[1]);	
		PresentHour = TwoAsciDeciNum2OneHex(sms_time.Hour[0],sms_time.Hour[1]);
		PresentMin  = TwoAsciDeciNum2OneHex(sms_time.Min[0],sms_time.Min[1]);
		PresentSec	= TwoAsciDeciNum2OneHex(sms_time.Sec[0],sms_time.Sec[1]);
		
		PresentMonth = TwoAsciDeciNum2OneHex(sms_time.Month[0],sms_time.Month[1]);
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
			//if(iSMS_Debug_Mode)USART1Printf("IP Connect[%d] \n",ret);
			WRCS_DownLoadGiveupTimerSet(Ser4DownLoading);
			break;
		}
		else
		{
			// if(iSMS_Debug_Mode)USART1Printf("IP Not Connect \n");
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

#if 1/// Test
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
#endif

#if 1

	SpecFreqStateUpdate();

	for ( i = 0; i < 3; i++ ) 
	{
		INT32S ret = TrafficCheck();

		if(ret == TRUE)	CdmaModemHangUp();
		else  			break;	// Hang Up //
		OSTimeDly(1000*5L);
	}
#endif
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

//		if((BcMType == 0x0C)||(BcMType == 0x0D))
		if( ModemType == _WCMDA_Modem)
		{
			Send->SubData[Count++] = hibyte(Aid_WcdmaChannel); // A_ID
			Send->SubData[Count++] = lobyte(Aid_WcdmaChannel);
			Send->SubData[Count++] = 0x03;
			Send->SubData[Count++] = tDnrSts->WaveSts.WcdmaChannel[0];
			Send->SubData[Count++] = tDnrSts->WaveSts.WcdmaChannel[1];
			Send->SubData[Count++] = tDnrSts->WaveSts.WcdmaChannel[1];
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
	
	 INT16S CurrFer=0;
	 INT16S CurrRx=0;
	 INT16S CurrAdj=0;
	 INT16S CurrTx =0;

	
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
//	for ( i = 0; i < 6; i++ )
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

		// WriteEEprom(MasterPNH,iMasterPNH);
		// WriteEEprom(MasterPNL,iMasterPNL);
		PnAlarm=Alarm;
		PnChangeCnt = 0;
		
		SaveBackupData();	
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

INT32U TCPProtocolCheck(__ProtocolPtr *nPtr)
{

	INT16U Data;
	INT16U DataCnt = 0;
	__WRCSSIO *Recv = nPtr->WRCSRecv;
	while(1)
	{
			
		if (  (STX == tcp_buff[DataCnt++])
			&&(STX == tcp_buff[DataCnt++])
			&&(STX == tcp_buff[DataCnt++])
			&&(STX == tcp_buff[DataCnt++])   )
		{

			Recv->Sync[0] = STX;
			Recv->Sync[1] = STX;
			Recv->Sync[2] = STX;
			Recv->Sync[3] = STX;
			break;
		}
	OSTimeDly(1);
	}

	Recv->TryNo 		= tcp_buff[DataCnt++];
	Recv->BodyLen[0]	= tcp_buff[DataCnt++];
	Recv->BodyLen[1]	= tcp_buff[DataCnt++];
	Recv->CheckSum		= tcp_buff[DataCnt++];

	Recv->BodyLength = (Recv->BodyLen[0] << 8) + (Recv->BodyLen[1]);

	if(Recv->CheckSum != (INT8U)(Recv->TryNo + Recv->BodyLen[0] + Recv->BodyLen[1])
		|| (Recv->BodyLength >= BODYSIZEMAX) // Error check, 2004. 02. 24
	)
	{								
		return FALSE;
	}

	{
		INT16U i;
		for(i = 0; i < 7 ; i++)
		{
		*((INT8U *)Recv->BodyFrame[0].SubID+ i) = tcp_buff[DataCnt++];
		}
	}
	Recv->BodyFrame[0].SubLength
		=	 ((Recv->BodyFrame[0].SubLen[0] << 8)& 0xff00)
		  +  ((Recv->BodyFrame[0].SubLen[1]	 )& 0x00ff) ;
	{
		INT16U i;
		for(i = 0; i < Recv->BodyFrame[0].SubLength +2 ; i++)
		{
		*((INT8U *)Recv->BodyFrame[0].SubData+ i) = tcp_buff[DataCnt++];
		}
	}
	Recv->BodyFrame[0].Crc
		= Crc16Calc ( &(Recv->BodyFrame[0].SubID[0])
					   ,Recv->BodyFrame[0].SubLength + 5 + 2, NULL);
	nPtr->WRCSRecv->BodyFrame[0].CrcOK = TRUE;

	Data = Recv->BodyFrame[0].SubLength;

	if ( ((INT8U)(Recv->BodyFrame[0].Crc >> 8)  != Recv->BodyFrame[0].SubData[Data] )
		|| ( (INT8U)(Recv->BodyFrame[0].Crc)	 != Recv->BodyFrame[0].SubData[Data+1] )  )
	{
		//CRC ERROR!!
		nPtr->WRCSRecv->BodyFrame[0].CrcOK = FALSE;
		return TRUE;
	}

	Data = tcp_buff[DataCnt++];
	if(Data != ETX)	return FALSE;
	
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

	switch(Comm)	//command 체크
	{
		case DownloadMinNumCMD:
		case DownloadCMD:
		case DownloadCMDConfirm:
		case DownLoadData:
		case DownLoadDataConfirm:
		{
			WRCS_DownLoadGiveupTimerSet(Ser4DownLoading);
			WRCS_DownloadFunc(nPtr);
			TcpDnLoadFlag = SET;
			
			if(Comm == DownLoadDataConfirm )
			{
				TcpExit();
				DownLoadBootingJump();
			}
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
	__WRCSSIO *Recv = nPtr->WRCSRecv;

		OSSemPend(nPtr->Sem, 0, &err);	
	if(err != OS_NO_ERR ) return err;	

	Send->BodyFrame[0].SubID[0] = tid[0];
	Send->BodyFrame[0].SubID[1] = tid[1];
	Send->BodyFrame[0].SubID[2] = tid[2];

	Send->BodyFrame[0].Command = Comm;
	Send->BodyFrame[0].RCode = Recv->BodyFrame[0].RCode;
//	Send->BodyFrame[0].RCode = TRIO_RCODE;

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
		OSSemPost(nPtr->Sem);
		return FALSE;
	}
	OSSemPost(nPtr->Sem);

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

	if(Digit1 >= 0x3a) Digit1 += 0x07;
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

	if(AlarmCheck_LTE_A1 != SET) 	Sts->AlmSts.FwdAmpOnOff_LTE_A1 = Enable;
	if(AlarmCheck_LTE_A2 != SET)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Enable;
	if(AlarmCheck_LTE_A1_1 != SET)	Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = Enable;
	if(AlarmCheck_LTE_A2_1 != SET)	Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = Enable;

	if(AlarmCheck_LTE != SET)		Sts->AlmSts.FwdAmpOnOff_LTE = Enable;
	if(AlarmCheck_LTE_1!= SET)		Sts->AlmSts.FwdAmp1OnOff_LTE = Enable;

	
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

	if(iRepeaterType == _TRIO_M)
	{
		for(i = 0; i < 7; i++)
		{
			dptr[rlen++] = 0;
		}
	}
	else
	{
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1InPwr_LTE);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE[0]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE[1]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutUpperLmt_LTE[0]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutUpperLmt_LTE[1]);
		dptr[rlen++] = Sts->Fwd1GainSet_LTE/2;
		dptr[rlen++] = Sts->Fwd1Gain_LTE/2;
	}

	dptr[rlen++] = Sts->Rvs0GainSet_3G/2;
	dptr[rlen++] = Sts->RvsGainSts_3G/2;
	dptr[rlen++] = Sts->RvsGainBalance_3G;
	dptr[rlen++] = Sts->Rvs0GainSet_2G/2;
	dptr[rlen++] = Sts->RvsGainSts_2G/2;
	dptr[rlen++] = Sts->RvsGainBalance_2G;

	if(iRepeaterType == _TRIO_M)
	{
		for(i = 0; i < 3; i++)
		{
			dptr[rlen++] = 0;
		}
	}
	else
	{
		dptr[rlen++] = Sts->Rvs1GainSet_LTE/2;
		dptr[rlen++] = Sts->Rvs1GainSts_LTE/2;
		dptr[rlen++] = Sts->Rvs1GainBalance_LTE;
	}

	dptr[rlen++] = Sts->AGCOnOff_3G;
	dptr[rlen++] = Sts->AGCOnOff_CDMALTE;
	dptr[rlen++] = Sts->AGCOnOff_LTE_A_0;
	dptr[rlen++] = Sts->AGC1OnOff_LTE;
	dptr[rlen++] = Sts->AGCOnOff_LTE_A_1;

	dptr[rlen++] = Sts->AmpOffCase_3G;
	dptr[rlen++] = Sts->AmpOffCase_2G;	
	dptr[rlen++] = Sts->AmpOffCase_LTE;	
	dptr[rlen++] = Sts->AmpOffCase_LTE_A1;		
	dptr[rlen++] = Sts->AmpOffCase_LTE_A2;
	dptr[rlen++] = Sts->Amp1OffCase_LTE;	
	dptr[rlen++] = Sts->Amp1OffCase_LTE_A1;
	dptr[rlen++] = Sts->Amp1OffCase_LTE_A2;

	for(i = 0; i < 5; i++)
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

	if(AlarmCheck_LTE_A1 != SET) 	Sts->AlmSts.FwdAmpOnOff_LTE_A1 = Enable;
	if(AlarmCheck_LTE_A2 != SET)	Sts->AlmSts.FwdAmpOnOff_LTE_A2 = Enable;
	if(AlarmCheck_LTE_A1_1 != SET)	Sts->AlmSts.FwdAmp1OnOff_LTE_A1 = Enable;
	if(AlarmCheck_LTE_A2_1 != SET)	Sts->AlmSts.FwdAmp1OnOff_LTE_A2 = Enable;
	if(AlarmCheck_LTE != SET)		Sts->AlmSts.FwdAmpOnOff_LTE = Enable;
	if(AlarmCheck_LTE_1!= SET)		Sts->AlmSts.FwdAmp1OnOff_LTE = Enable;


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
	
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdInPwr_LTE_A1);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A1[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A1[1]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_A1[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_A1[1]);
	dptr[rlen++] = Sts->FwdGainSet_LTE_A1/2;
	dptr[rlen++] = Sts->FwdGain_LTE_A1/2;

	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdInPwr_LTE_A2);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[1]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_A2[0]);
	dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_LTE_A2[1]);
	dptr[rlen++] = Sts->FwdGainSet_LTE_A2/2;
	dptr[rlen++] = Sts->FwdGain_LTE_A2/2;

	if(iRepeaterType == _TRIO_M)
	{
		for(i = 0; i < 14; i++)
		{
			dptr[rlen++] = 0;
		}
	}
	else
	{
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1InPwr_LTE_A1);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A1[0]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A1[1]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutUpperLmt_LTE_A1[0]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutUpperLmt_LTE_A1[1]);
		dptr[rlen++] = Sts->Fwd1GainSet_LTE_A1/2;
		dptr[rlen++] = Sts->Fwd1Gain_LTE_A1/2;

		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1InPwr_LTE_A2);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A2[0]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A2[1]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutUpperLmt_LTE_A2[0]);
		dptr[rlen++] = RetNormaltoSMSData(Sts->Fwd1OutUpperLmt_LTE_A2[1]);
		dptr[rlen++] = Sts->Fwd1GainSet_LTE_A2/2;
		dptr[rlen++] = Sts->Fwd1Gain_LTE_A2/2;
	}

	dptr[rlen++] = Sts->Rvs0GainSet_LTE/2;
	dptr[rlen++] = Sts->RvsGainSts_LTE/2;
	dptr[rlen++] = Sts->RvsGainBalance_LTE;
	
	dptr[rlen++] = Sts->Rvs0GainSet_LTE_A1/2;
	dptr[rlen++] = Sts->RvsGainSts_LTE_A1/2;
	dptr[rlen++] = Sts->RvsGainBalance_LTE_A1;

	dptr[rlen++] = Sts->Rvs0GainSet_LTE_A2/2;
	dptr[rlen++] = Sts->RvsGainSts_LTE_A2/2;
	dptr[rlen++] = Sts->RvsGainBalance_LTE_A2;

	if(iRepeaterType == _TRIO_M)
	{
		for(i = 0; i < 6; i++)
		{
			dptr[rlen++] = 0;
		}
	}
	else
	{
		dptr[rlen++] = Sts->Rvs1GainSet_LTE_A1/2;
		dptr[rlen++] = Sts->Rvs1GainSts_LTE_A1/2;
		dptr[rlen++] = Sts->Rvs1GainBalance_LTE_A1;

		dptr[rlen++] = Sts->Rvs1GainSet_LTE_A2/2;
		dptr[rlen++] = Sts->Rvs1GainSts_LTE_A2/2;
		dptr[rlen++] = Sts->Rvs1GainBalance_LTE_A2;
	}
	dptr[rlen++] = Sts->Band_Select_LTE_A1;
	dptr[rlen++] = Sts->Band_Select_LTE_A2[0];
	dptr[rlen++] = Sts->Band_Select_LTE_A2[1];
	dptr[rlen++] = Sts->Band_Select_LTE_A2[2];

	for(i = 0; i < 3; i++)
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

INT16U GenEtcStsAid(INT8U *dptr, __Dnr_Sts *Sts)
{
	INT16U rlen = 0;

	dptr[rlen++] = Sts->AGCMode_3G;
	dptr[rlen++] = Sts->AGCMode_2G;
	dptr[rlen++] = Sts->AGCMode_LTE;
	dptr[rlen++] = Sts->AGCMode_LTE_A1;
	dptr[rlen++] = Sts->AGCMode_LTE_A2;
	dptr[rlen++] = Sts->LTE15MUse;
	dptr[rlen++] = Sts->FemtocellUseOnOff.Data;
	dptr[rlen++] = Sts->RepeatResetPriod;
	dptr[rlen++] = Sts->RvsOverInAlarmCount;
	dptr[rlen++] = Sts->RvsOtherOverInAlarmCount;

	
#ifdef __RvsCount

	dptr[rlen++] = Sts->RvsOSCAlarmCount_3G;		
	dptr[rlen++] = Sts->RvsOSCAlarmCount_2G;		
	dptr[rlen++] = Sts->RvsOSCAlarmCount_LTE; 	
	dptr[rlen++] = Sts->RvsOSCAlarmCount_LTE_A1;
	dptr[rlen++] = Sts->RvsOSCAlarmCount_LTE_A2;
	dptr[rlen++] = Sts->Rvs1OSCAlarmCount_LTE;	
	dptr[rlen++] = Sts->Rvs1OSCAlarmCount_LTE_A1;
	dptr[rlen++] = Sts->Rvs1OSCAlarmCount_LTE_A2;

#endif

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


INT16U DnrAlarmReport(INT8U *dptr, __ProtocolPtr *nPtr )
{
    INT8U DataCnt = 0;

	__Dnr_Sts  *Sts = tDnrSts;	

	
	if((PwrAlarm.ACFail)||(SetAcRecovery))	chkAlarmMaskReport = SET;
	else									chkAlarmMaskReport = RESET;


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
		if(PwrAlarmChange.FwdOutLowerLmtFail_3G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_3G);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_3G);
			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_3G;
			dptr[DataCnt++] = 0x00;
			PwrAlarmChange.FwdOutLowerLmtFail_3G = RESET;
		}

		if(PwrAlarmChange.OverInAlarm_3G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOtherOverIn_3G);
			dptr[DataCnt++] = lobyte(Aid_FwdOtherOverIn_3G);
			dptr[DataCnt++] = PwrAlarm.OverInAlarm_3G;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.OverInAlarm_3G = RESET;
		}

		///////////////////////////// Fwd 2G

		if(PwrAlarmChange.FwdInUpperLmtFail_2G)
		{
			dptr[DataCnt++] = hibyte(Aid_OverIn_2G);
			dptr[DataCnt++] = lobyte(Aid_OverIn_2G);
			dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_2G;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.FwdInUpperLmtFail_2G = RESET;
		}
#if 0
		
 		if(PwrAlarmChange.FwdOutUpperLmtFail_2G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_2G);
			dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_2G);
			dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_2G;
			dptr[DataCnt++] = 0x00;
		}
#endif
		if(PwrAlarmChange.FwdOutLowerLmtFail_2G)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_2G);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_2G);
			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_2G;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.FwdOutLowerLmtFail_2G = RESET;
		}

		///////////////////////////////////LTE
		if(PwrAlarmChange.FwdInUpperLmtFail_LTE)
		{
			dptr[DataCnt++] = hibyte(Aid_OverIn_LTE);
			dptr[DataCnt++] = lobyte(Aid_OverIn_LTE);
			dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_LTE;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.FwdInUpperLmtFail_LTE = RESET;
		}

 
		if(PwrAlarmChange.FwdOutLowerLmtFail_LTE)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE);

			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_LTE;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.FwdOutLowerLmtFail_LTE = RESET;
		}

		if(PwrAlarmChange.OverInAlarm_CDMALTE)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOtherOverIn_Common);
			dptr[DataCnt++] = lobyte(Aid_FwdOtherOverIn_Common);
			dptr[DataCnt++] = PwrAlarm.OverInAlarm_CDMALTE;
			dptr[DataCnt++] = 0x00;
				
			PwrAlarmChange.OverInAlarm_CDMALTE = RESET;
		}

		///////////////////////////////////LTE_A1
		if(PwrAlarmChange.FwdOutLowerLmtFail_LTE_A1)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE_A1);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE_A1);

			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_LTE_A1;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.FwdOutLowerLmtFail_LTE_A1 = RESET;
		}

		if(PwrAlarmChange.OverInAlarm_LTE_A1)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOtherOverIn_LTE_A);
			dptr[DataCnt++] = lobyte(Aid_FwdOtherOverIn_LTE_A);

			dptr[DataCnt++] = PwrAlarm.OverInAlarm_LTE_A1;
			dptr[DataCnt++] = 0x00;

			
			PwrAlarmChange.OverInAlarm_LTE_A1 = RESET;
		}

		///////////////////////////////////LTE_A2
		if(PwrAlarmChange.FwdOutLowerLmtFail_LTE_A2)
		{
			dptr[DataCnt++] = hibyte(Aid_FwdOutLowerLmt_LTE_A2);
			dptr[DataCnt++] = lobyte(Aid_FwdOutLowerLmt_LTE_A2);
			dptr[DataCnt++] = PwrAlarm.FwdOutLowerLmtFail_LTE_A2;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.FwdOutLowerLmtFail_LTE_A2 = RESET;
		}


		////////////
		if((PwrAlarmChange.LocalFail_CDMALTE))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_CDMALTE);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_CDMALTE);
			dptr[DataCnt++] = PwrAlarm.LocalFail_CDMALTE;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.LocalFail_CDMALTE = RESET;
		}

		if((PwrAlarmChange.LocalFail_LTE_A1))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_LTE_A1);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_LTE_A1);
			dptr[DataCnt++] = PwrAlarm.LocalFail_LTE_A1;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.LocalFail_LTE_A1 = RESET;
		}

		if((PwrAlarmChange.LocalFail_LTE_A2))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_LTE_A2);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_LTE_A2);
			dptr[DataCnt++] = PwrAlarm.LocalFail_LTE_A2;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.LocalFail_LTE_A2 = RESET;
		}

		if((PwrAlarmChange.LocalFail_3G))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_3G);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_3G);
			dptr[DataCnt++] = PwrAlarm.LocalFail_3G;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.LocalFail_3G = RESET;
		}


		if((PwrAlarmChange.LocalFail_LTE_1))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_LTE_1);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_LTE_1);
			dptr[DataCnt++] = PwrAlarm.LocalFail_LTE_1;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.LocalFail_LTE_1 = RESET;
		}

		if((PwrAlarmChange.LocalFail_LTE_A1_1))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_LTE_A1_1);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_LTE_A1_1);
			dptr[DataCnt++] = PwrAlarm.LocalFail_LTE_A1_1;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.LocalFail_LTE_A1_1 = RESET;
		}

		if((PwrAlarmChange.LocalFail_LTE_A2_1))
		{
			dptr[DataCnt++] = hibyte(Aid_LocalFail_LTE_A2_1);
			dptr[DataCnt++] = lobyte(Aid_LocalFail_LTE_A2_1);
			dptr[DataCnt++] = PwrAlarm.LocalFail_LTE_A2_1;
			dptr[DataCnt++] = 0x00;
			
			PwrAlarmChange.LocalFail_LTE_A2_1 = RESET;
		}

#if 1
		if((PwrAlarmChange.FwdAmpOnOff_2G))
		{
			PwrAlarmChange.FwdAmpOnOff_2G = RESET;

			if(PwrAlarmChange.RvsOutUpperLmtFail_2G)
			{
				dptr[DataCnt++] = hibyte(Aid_RvsOscilation_2G);
				dptr[DataCnt++] = lobyte(Aid_RvsOscilation_2G);
				
				dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_2G;
				dptr[DataCnt++] = 0x00;
				PwrAlarmChange.RvsOutUpperLmtFail_2G = RESET;
			}
			if(PwrAlarmChange.FwdOutUpperLmtFail_2G)
			{
				dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_2G);
				dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_2G);
				dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_2G;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.FwdOutUpperLmtFail_2G = RESET;
			}

			{
				dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_2G);
				dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_2G);
				if(PwrAlarm.FwdAmpOnOff_2G) dptr[DataCnt++] = 0x01;
				else						dptr[DataCnt++] = 0x00;
				
				dptr[DataCnt++] = 0x01;
				dptr[DataCnt++] = tDnrSts->AmpOffCase_2G;

			}				
		}

		if((PwrAlarmChange.FwdAmpOnOff_LTE))
		{
			PwrAlarmChange.FwdAmpOnOff_LTE = RESET;

			if(PwrAlarmChange.RvsOutUpperLmtFail_LTE)
			{
				dptr[DataCnt++] = hibyte(Aid_RvsOscilation_LTE);
				dptr[DataCnt++] = lobyte(Aid_RvsOscilation_LTE);
				
				dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_LTE;
				dptr[DataCnt++] = 0x00;
				PwrAlarmChange.RvsOutUpperLmtFail_LTE = RESET;
			}

			if(PwrAlarmChange.FwdOutUpperLmtFail_LTE)
			{
				dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE);
				dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE);
				dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_LTE;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.FwdOutUpperLmtFail_LTE = RESET;
			}


			{
				dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_LTE);
				dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_LTE);
				if(PwrAlarm.FwdAmpOnOff_2G) dptr[DataCnt++] = 0x01;
				else						dptr[DataCnt++] = 0x00;
				
				dptr[DataCnt++] = 0x01;
				dptr[DataCnt++] = tDnrSts->AmpOffCase_LTE;
			}				
		}

		if((PwrAlarmChange.FwdAmpOnOff_LTE_A1))
		{
			PwrAlarmChange.FwdAmpOnOff_LTE_A1 = RESET;

			if(PwrAlarmChange.RvsOutUpperLmtFail_LTE_A1)
			{
				dptr[DataCnt++] = hibyte(Aid_RvsOscilation_LTE_A1);
				dptr[DataCnt++] = lobyte(Aid_RvsOscilation_LTE_A1);
				
				dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_LTE_A1;
				dptr[DataCnt++] = 0x00;
				PwrAlarmChange.RvsOutUpperLmtFail_LTE_A1 = RESET;
			}

			if(PwrAlarmChange.FwdOutUpperLmtFail_LTE_A1)
			{
				dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE_A1);
				dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE_A1);
				dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_LTE_A1;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.FwdOutUpperLmtFail_LTE_A1 = RESET;
			}

			if(PwrAlarmChange.FwdInUpperLmtFail_LTE_A1)
			{
				dptr[DataCnt++] = hibyte(Aid_OverIn_LTE_A1);
				dptr[DataCnt++] = lobyte(Aid_OverIn_LTE_A1);
			
				dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_LTE_A1;
				dptr[DataCnt++] = 0x00;
				PwrAlarmChange.FwdInUpperLmtFail_LTE_A1 = RESET;
			}

			{
				dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_LTE_A1);
				dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_LTE_A1);
				if(PwrAlarm.FwdAmpOnOff_LTE_A1) dptr[DataCnt++] = 0x01;
				else						dptr[DataCnt++] = 0x00;
				
				dptr[DataCnt++] = 0x01;
				dptr[DataCnt++] = tDnrSts->AmpOffCase_LTE_A1;
			}				
		}

		
		if((PwrAlarmChange.FwdAmpOnOff_LTE_A2))
		{
			PwrAlarmChange.FwdAmpOnOff_LTE_A2 = RESET;

			if(PwrAlarmChange.RvsOutUpperLmtFail_LTE_A2)
			{
				dptr[DataCnt++] = hibyte(Aid_RvsOscilation_LTE_A2);
				dptr[DataCnt++] = lobyte(Aid_RvsOscilation_LTE_A2);
				
				dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_LTE_A2;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.RvsOutUpperLmtFail_LTE_A2 = RESET;
			}
			
			if(PwrAlarmChange.FwdOutUpperLmtFail_LTE_A2)
			{
				dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE_A2);
				dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE_A2);
				dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_LTE_A2;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.FwdOutUpperLmtFail_LTE_A2 = RESET;
			}

			if(PwrAlarmChange.FwdInUpperLmtFail_LTE_A2)
			{
				dptr[DataCnt++] = hibyte(Aid_OverIn_LTE_A2);
				dptr[DataCnt++] = lobyte(Aid_OverIn_LTE_A2);
			
				dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_LTE_A2;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.FwdInUpperLmtFail_LTE_A2 = RESET;
			}

			{
				dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_LTE_A2);
				dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_LTE_A2);
				if(PwrAlarm.FwdAmpOnOff_LTE_A2) dptr[DataCnt++] = 0x01;
				else							dptr[DataCnt++] = 0x00;
				
				dptr[DataCnt++] = 0x01;
				dptr[DataCnt++] = tDnrSts->AmpOffCase_LTE_A2;
			}				
		}

		if((PwrAlarmChange.FwdAmpOnOff_3G))
		{
			PwrAlarmChange.FwdAmpOnOff_3G = RESET;

			if(PwrAlarmChange.RvsOutUpperLmtFail_3G)
			{
				dptr[DataCnt++] = hibyte(Aid_RvsOscilation_3G);
				dptr[DataCnt++] = lobyte(Aid_RvsOscilation_3G);
				
				dptr[DataCnt++] = PwrAlarm.RvsOutUpperLmtFail_3G;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.RvsOutUpperLmtFail_3G = RESET;
			}
			
			if(PwrAlarmChange.FwdOutUpperLmtFail_3G)
			{
				dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_3G);
				dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_3G);
				dptr[DataCnt++] = PwrAlarm.FwdOutUpperLmtFail_3G;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.FwdOutUpperLmtFail_3G = RESET;
			}

			if(PwrAlarmChange.FwdInUpperLmtFail_3G)
			{
				dptr[DataCnt++] = hibyte(Aid_OverIn_3G);
				dptr[DataCnt++] = lobyte(Aid_OverIn_3G);
			
				dptr[DataCnt++] = PwrAlarm.FwdInUpperLmtFail_3G;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.FwdInUpperLmtFail_3G = RESET;
			}

			{
				dptr[DataCnt++] = hibyte(Aid_FwdAmpOnOff_3G);
				dptr[DataCnt++] = lobyte(Aid_FwdAmpOnOff_3G);
				if(PwrAlarm.FwdAmpOnOff_3G) dptr[DataCnt++] = 0x01;
				else						dptr[DataCnt++] = 0x00;
				
				dptr[DataCnt++] = 0x01;
				dptr[DataCnt++] = tDnrSts->AmpOffCase_3G;
			}				
		}

		

#endif


		///////////////////////////////////LTE
		if(iRepeaterType == _TRIO_MM)
		{

			if(PwrAlarmChange.Fwd1OutLowerLmtFail_LTE)
			{
				dptr[DataCnt++] = hibyte(Aid_Fwd1OutLowerLmt_LTE);
				dptr[DataCnt++] = lobyte(Aid_Fwd1OutLowerLmt_LTE);

				dptr[DataCnt++] = PwrAlarm.Fwd1OutLowerLmtFail_LTE;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.Fwd1OutLowerLmtFail_LTE = RESET;
			}

			///////////////////////////////////LTE_A1
			if(PwrAlarmChange.Fwd1OutLowerLmtFail_LTE_A1)
			{
				dptr[DataCnt++] = hibyte(Aid_Fwd1OutLowerLmt_LTE_A1);
				dptr[DataCnt++] = lobyte(Aid_Fwd1OutLowerLmt_LTE_A1);

				dptr[DataCnt++] = PwrAlarm.Fwd1OutLowerLmtFail_LTE_A1;
				dptr[DataCnt++] = 0x00;
				
				PwrAlarmChange.Fwd1OutLowerLmtFail_LTE_A1 = RESET;
			}
			///////////////////////////////////LTE_A2
			if(PwrAlarmChange.Fwd1OutLowerLmtFail_LTE_A2)
			{
				dptr[DataCnt++] = hibyte(Aid_Fwd1OutLowerLmt_LTE_A2);
				dptr[DataCnt++] = lobyte(Aid_Fwd1OutLowerLmt_LTE_A2);

				dptr[DataCnt++] = PwrAlarm.Fwd1OutLowerLmtFail_LTE_A2;
				dptr[DataCnt++] = 0x00;
					
				PwrAlarmChange.Fwd1OutLowerLmtFail_LTE_A2 = RESET;
			}
////////////////
			if((PwrAlarmChange.FwdAmp1OnOff_LTE))
			{
				PwrAlarmChange.FwdAmp1OnOff_LTE = RESET;

				if(PwrAlarmChange.Rvs1OutUpperLmtFail_LTE)
				{
					dptr[DataCnt++] = hibyte(Aid_Rvs1Oscilation_LTE_A1);
					dptr[DataCnt++] = lobyte(Aid_Rvs1Oscilation_LTE_A1);
					
					dptr[DataCnt++] = PwrAlarm.Rvs1OutUpperLmtFail_LTE;
					dptr[DataCnt++] = 0x00;
					PwrAlarmChange.Rvs1OutUpperLmtFail_LTE = RESET;
				}

				if(PwrAlarmChange.Fwd1OutUpperLmtFail_LTE)
				{
					dptr[DataCnt++] = hibyte(Aid_Fwd1OutUpperLmt_LTE);
					dptr[DataCnt++] = lobyte(Aid_Fwd1OutUpperLmt_LTE);
					dptr[DataCnt++] = PwrAlarm.Fwd1OutUpperLmtFail_LTE;
					dptr[DataCnt++] = 0x00;
					
					PwrAlarmChange.Fwd1OutUpperLmtFail_LTE = RESET;
				}

				if(PwrAlarmChange.Fwd1InUpperLmtFail_LTE)
				{
					dptr[DataCnt++] = hibyte(Aid_OverIn_LTE_A1_1);
					dptr[DataCnt++] = lobyte(Aid_OverIn_LTE_A1_1);
				
					dptr[DataCnt++] = PwrAlarm.Fwd1InUpperLmtFail_LTE;
					dptr[DataCnt++] = 0x00;
					
					PwrAlarmChange.Fwd1InUpperLmtFail_LTE = RESET;
				}
#if 0
				{
					dptr[DataCnt++] = hibyte(Aid_FwdAmp1OnOff_LTE_A1);
					dptr[DataCnt++] = lobyte(Aid_FwdAmp1OnOff_LTE_A1);
					if(PwrAlarm.FwdAmp1OnOff_LTE) 	dptr[DataCnt++] = 0x01;
					else							dptr[DataCnt++] = 0x00;
					
					dptr[DataCnt++] = 0x01;
					dptr[DataCnt++] = tDnrSts->Amp1OffCase_LTE;
				}
#endif
///////20150104 수정 
				{
					dptr[DataCnt++] = hibyte(Aid_FwdAmp1OnOff_LTE);
					dptr[DataCnt++] = lobyte(Aid_FwdAmp1OnOff_LTE);
					if(PwrAlarm.FwdAmp1OnOff_LTE)	dptr[DataCnt++] = 0x01;
					else							dptr[DataCnt++] = 0x00;
					
					dptr[DataCnt++] = 0x01;
					dptr[DataCnt++] = tDnrSts->Amp1OffCase_LTE;
				}

				
			}


			if((PwrAlarmChange.FwdAmp1OnOff_LTE_A1))
			{
				PwrAlarmChange.FwdAmp1OnOff_LTE_A1 = RESET;

				if(PwrAlarmChange.Rvs1OutUpperLmtFail_LTE_A1)
				{
					dptr[DataCnt++] = hibyte(Aid_Rvs1Oscilation_LTE_A1);
					dptr[DataCnt++] = lobyte(Aid_Rvs1Oscilation_LTE_A1);
					
					dptr[DataCnt++] = PwrAlarm.Rvs1OutUpperLmtFail_LTE_A1;
					dptr[DataCnt++] = 0x00;
					PwrAlarmChange.Rvs1OutUpperLmtFail_LTE_A1 = RESET;
				}

				if(PwrAlarmChange.Fwd1OutUpperLmtFail_LTE_A1)
				{
					dptr[DataCnt++] = hibyte(Aid_Fwd1OutUpperLmt_LTE_A1);
					dptr[DataCnt++] = lobyte(Aid_Fwd1OutUpperLmt_LTE_A1);
					dptr[DataCnt++] = PwrAlarm.Fwd1OutUpperLmtFail_LTE_A1;
					dptr[DataCnt++] = 0x00;
					PwrAlarmChange.Fwd1OutUpperLmtFail_LTE_A1 = RESET;
				}

				if(PwrAlarmChange.Fwd1InUpperLmtFail_LTE_A1)
				{
					dptr[DataCnt++] = hibyte(Aid_OverIn_LTE_A1_1);
					dptr[DataCnt++] = lobyte(Aid_OverIn_LTE_A1_1);
				
					dptr[DataCnt++] = PwrAlarm.Fwd1InUpperLmtFail_LTE_A1;
					dptr[DataCnt++] = 0x00;
					
					PwrAlarmChange.Fwd1InUpperLmtFail_LTE_A1 = RESET;
				}

				{
					dptr[DataCnt++] = hibyte(Aid_FwdAmp1OnOff_LTE_A1);
					dptr[DataCnt++] = lobyte(Aid_FwdAmp1OnOff_LTE_A1);
					if(PwrAlarm.FwdAmp1OnOff_LTE_A1) 	dptr[DataCnt++] = 0x01;
					else								dptr[DataCnt++] = 0x00;
					
					dptr[DataCnt++] = 0x01;
					dptr[DataCnt++] = tDnrSts->Amp1OffCase_LTE_A1;
				}				
			}

			
			if((PwrAlarmChange.FwdAmp1OnOff_LTE_A2))
			{
				PwrAlarmChange.FwdAmp1OnOff_LTE_A2 = RESET;

				if(PwrAlarmChange.Rvs1OutUpperLmtFail_LTE_A2)
				{
					dptr[DataCnt++] = hibyte(Aid_Rvs1Oscilation_LTE_A2);
					dptr[DataCnt++] = lobyte(Aid_Rvs1Oscilation_LTE_A2);
					
					dptr[DataCnt++] = PwrAlarm.Rvs1OutUpperLmtFail_LTE_A2;
					dptr[DataCnt++] = 0x00;
					PwrAlarmChange.Rvs1OutUpperLmtFail_LTE_A2 = RESET;
				}

				if(PwrAlarmChange.Fwd1OutUpperLmtFail_LTE_A2)
				{
					dptr[DataCnt++] = hibyte(Aid_FwdOutUpperLmt_LTE_A2);
					dptr[DataCnt++] = lobyte(Aid_FwdOutUpperLmt_LTE_A2);
					dptr[DataCnt++] = PwrAlarm.Fwd1OutUpperLmtFail_LTE_A2;
					dptr[DataCnt++] = 0x00;
					
					PwrAlarmChange.Fwd1OutUpperLmtFail_LTE_A2 = RESET;
				}

				if(PwrAlarmChange.Fwd1InUpperLmtFail_LTE_A2)
				{
					dptr[DataCnt++] = hibyte(Aid_OverIn_LTE_A2);
					dptr[DataCnt++] = lobyte(Aid_OverIn_LTE_A2);
				
					dptr[DataCnt++] = PwrAlarm.Fwd1InUpperLmtFail_LTE_A2;
					dptr[DataCnt++] = 0x00;
					
					PwrAlarmChange.Fwd1InUpperLmtFail_LTE_A2 = RESET;
				}

				{
					dptr[DataCnt++] = hibyte(Aid_FwdAmp1OnOff_LTE_A2);
					dptr[DataCnt++] = lobyte(Aid_FwdAmp1OnOff_LTE_A2);
					if(PwrAlarm.FwdAmp1OnOff_LTE_A2) dptr[DataCnt++] = 0x01;
					else							dptr[DataCnt++] = 0x00;
					
					dptr[DataCnt++] = 0x01;
					dptr[DataCnt++] = tDnrSts->Amp1OffCase_LTE_A2;
				}				
			}
		}
	}

	/////////////////// 필수 항목 /////////////////////////////////////
	if(DataCnt)
	{
		dptr[DataCnt++] = 0xff; 				// A_ID
		dptr[DataCnt++] = 0xff;
		
		if(iRepeaterType == _TRIO_M)
		{
			dptr[DataCnt++] = 10;					// len
		}
		else
		{
			dptr[DataCnt++] = 16;					// len
		}

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_2G[1]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_3G[1]);

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE[1]);

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A1[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A1[1]);

		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[0]);
		dptr[DataCnt++] = RetNormaltoSMSData(Sts->FwdOutPwr_LTE_A2[1]);


		if(iRepeaterType == _TRIO_MM)
		{
			dptr[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE[0]);
			dptr[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE[1]);

			dptr[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A1[0]);
			dptr[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A1[1]);

			dptr[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A2[0]);
			dptr[DataCnt++] = RetNormaltoSMSData(Sts->Fwd1OutPwr_LTE_A2[1]);
		}
	}
	return(DataCnt);
}

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

01071065483

void TxDataToSMS ( UINT8 *NmsData,UINT8 DataLen,UINT8 *Dest,UINT8 *Sour )
{
    UINT16  i, DataCnt=0, Txtry=0;
    const char  *Command = "AT*SKTR*SMSMO=";
    char HtoA[16] = { '0', '1', '2', '3', '4', '5', '6', '7', 
                      '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };

    for ( i=0; i<14; i++ )
        Tx2Buff[DataCnt++] = Command[i];
    for ( i=0; i<11; i++ )
    {
        if ( (Dest[i]<'0')||(Dest[i]>'9') ) break;
        Tx2Buff[DataCnt++] = Dest[i];
    }
    Tx2Buff[DataCnt++] = ',';
    for ( i=0; i<11; i++ )
    {
        if ( (Sour[i]<'0')||(Sour[i]>'9') ) break;
        Tx2Buff[DataCnt++] = Sour[i];
    }
    Tx2Buff[DataCnt++] = ',';
    if(RhuData(0, 0, RH_PhoneModel, 0 ) != 0x0C)//KST WCDMA Modem
    {
        Tx2Buff[DataCnt++] = '4';
        Tx2Buff[DataCnt++] = '0';
        Tx2Buff[DataCnt++] = '9';
        Tx2Buff[DataCnt++] = '8';
    }
    Tx2Buff[DataCnt++] = ',';
    
    Tx2Buff[DataCnt++] = '0';//encoding
    Tx2Buff[DataCnt++] = ',';
 
    if(RhuData(0, 0, RH_PhoneModel, 0 ) != 0x0C)//KST WCDMA Modem
    {
        Tx2Buff[DataCnt++] = '1';//bearer_rply
    }
    Tx2Buff[DataCnt++] = ',';
 
    if(RhuData(0, 0, RH_PhoneModel, 0 ) != 0x0C)//KST WCDMA Modem
    {
         Tx2Buff[DataCnt++] = '0';//priority
    }
    Tx2Buff[DataCnt++] = ',';

    for ( i=0; i<DataLen; i++ )
    {
         if( i < (DataLen-2) )   NmsData[i]          = NmsData[i] | 0x80;
        Tx2Buff[DataCnt++]  = HtoA[(NmsData[i]>>4)&0x0F];
        Tx2Buff[DataCnt++]  = HtoA[(NmsData[i]>>0)&0x0F];
    }
    Tx2Buff[DataCnt++] = 0x0d;
    Tx2Buff[DataCnt++] = 0x0a;
 
    while(1)
    {
        if ( ++Txtry > 3 ) {
            Booting = 0xff; 
            return; 
        }
        TransmitUart(UART_16c550_0, (UINT8 *)Tx2Buff, DataCnt );
        
        OSTimeDlyHMSM(0, 0, 1, 0);
        if ( !RecieveACK() ) continue;
        if ( !((DataBuff[0] == 'O')&&(DataBuff[1] == 'K')) ) continue;
        for ( i=0; i<5; i++ )
        {   
            if ( !RecieveACK() ) continue;
            if( (DataBuff[0] == '$') )
            {
                //$006-->success, $007-->fail
                if      ( (DataBuff[0] == '$')&&(DataBuff[1] == '0')&&(DataBuff[2] == '0')&&(DataBuff[3] == '6') )
                        return;
                else    break;
            }
            else if( (DataBuff[11] == 'A')&&(DataBuff[12] == 'C')&&(DataBuff[13] == 'K') )
            {
                //*SKTR*SMSMOACK:1-->success, 0-->fail
                if      ( (DataBuff[11] == 'A')&&(DataBuff[12] == 'C')&&(DataBuff[13] == 'K')&&(DataBuff[15] == '1') )
                {
                    OSTimeDlyHMSM(0, 0, 1, 0);
                    return;
                }
                else    break;
            }
        }
        OSTimeDlyHMSM(0, 0, 1, 0);
    }
}

Boot Alarm
	
AT*SKTR*SMSMO=01071065483,01021468701,,0,,,FFFFFF82B580848C958180B5C1           
                                                                                
                        

118.67.190.46

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

#if 0 ///kst wcdma

 TRIO-M VER:1.3.0-->Type[0]                                                     
ATE0                                                                            
                                                                                
                                                                                
OK                                                                              
  AT*SKT*REL                                                                    
                                                                                
                                                                                
*SKT*REL:1                                                                      
          AT+GMR                                                                
                                                                                
                                                                                
+GMR:x05,0x0C,112                                                               
                                                                                
OK                                                                              
  AT*SKT*DIAL                                                                   
                                                                                
                                                                                
*SKT*DIAL:010-2148-9797                                                         
                       AT*SKTR*ICCID                                            
                                                                                
                                                                                
*SKTR*ICCID:8982051008148287933                                                 
                                                                                
OK                                                                              
  AT*SKT*PING                                                                   
                                                                                
                                                                                
*SKT*PONG:0,20130215121441                                                      
                                                                                
OK                                                                              
  AT+CGREG?                                                                     
                                                                                
                                                                                
+CGREG: 0,1

AT*SKTR*SMSMO=01071065483,01020357112											
										 ,,0,,,FFFFFF82B480858994818183B5C1



AT*SKTR*SMSMO=01071065483,01021489797,,0,,,FFFFFF82B480858994818183B5C1       
                                                                                
                                                                                
OK                                                                              
                                                                                
*SKTR*SMSMOACK:1


#endif
