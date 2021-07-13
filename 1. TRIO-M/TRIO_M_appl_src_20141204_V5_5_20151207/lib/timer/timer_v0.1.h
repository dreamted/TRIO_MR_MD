
/*********************************************
* File Name          : timer_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define TIMERmax	30

typedef struct {
	INT8U	TimerID;		// Timer Identification //
	INT32U	Count;			// Timer Count //
} TIMER;


TIMER LongTimer[TIMERmax];

void WatchdogInit(void);
void WatchdogClear(void);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

