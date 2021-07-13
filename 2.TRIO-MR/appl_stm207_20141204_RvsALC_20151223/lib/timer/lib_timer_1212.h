
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : timer_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define TIMERmax	50

typedef struct {
	int	TimerID;		// Timer Identification //
	INT32U	Count;			// Timer Count //
} TIMER;


TIMER LongTimer[TIMERmax];

void WatchdogInit(void);
void WatchdogClear(void);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

