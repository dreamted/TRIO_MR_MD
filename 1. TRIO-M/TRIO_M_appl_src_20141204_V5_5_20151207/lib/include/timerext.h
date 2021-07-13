
/*********************************************
* File Name          : timer_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define Time10mSec		10
#define Time100mSec		100
#define Time1Sec		1000L

#define Time1Min		100L*600L
#define Time1Hour		(Time1Min*60L)
#define Time1Day		(Time1Hour*24L)

#define ALCTime			(Time1Day*7L)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////

void Tmr_TickInit(u32 ms);
void WatchdogInit(void);
void Tmr_TickISR_Handler (void);
void ForDelay(unsigned long int count);
void CheckSoftTimer(void);
void WatchdogClear(void);

INT8U TimerCancel ( INT16U TimeId );
INT8U TimeOverCheck ( INT8U TimeId );
INT8U TimerRegist ( INT8U TimeId, INT32U TimeCnt);
INT32U TimeRemainCheck(INT8U TimeId);

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

