
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : timer_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define Time10mSec		10u
#define Time100mSec		100u
#define Time1Sec		1000u

#define Time1Min		1000u*60u
#define Time1Hour		(Time1Min*60u)
#define Time1Day		(Time1Hour*24u)

#define ALCTime			(Time1Day*7u)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////

void Tmr_TickInit(u32 ms);
void TimerInit(void);
void WatchdogInit(void);
void ForDelay(unsigned long int count);
void CheckSoftTimer(void);
void WatchdogClear(void);

INT8U TimerCancel(int TimeId );
INT8U TimeOverCheck(int TimeId );
INT8U TimerRegist(int TimeId, INT32U TimeCnt);
INT32U TimeRemainCheck(int TimeId);

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

