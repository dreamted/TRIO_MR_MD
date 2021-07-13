
/*********************************************
* File Name          : timer_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
#include "stm32f10x_conf.h"
#include "../include/timerext.h"
#include "timer_v0.1.h"


void Tmr_TickInit(u32 ms)
{
  	// Configure HCLK clock as SysTick clock source
 	SysTick->CTRL.Bit.CLKSOURCE = __EXTSRC;
  	// SysTick end of count event each 100us with input clock equal to 9MHz (HCLK/8, default)
	SysTick->LOAD.Data = ((unsigned long long )ms * SYSCLK)/(8L * 1000L);
	SysTick->CTRL.Bit.TICKINT = __PENDINT;	// tick interrupt enable
  
	// Enable the SysTick Counter
	SysTick->CTRL.Bit.ENABLE = ENABLE;	// systick count enable
}


/*******************************************************************************
* Function Name  : SysTickHandler
* Description    : This function handles SysTick Handler.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
	
void  Tmr_TickISR_Handler (void)
{
	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	OSTimeTick();												// Call uC/OS-II's OSTimeTick()
	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
}

void CheckSoftTimer(void)
{
	INT8U i = 0;

	for(i = 0; i < TIMERmax; i++ )
	{
		if(LongTimer[i].Count != 0L ) LongTimer[i].Count--;
	}
}

INT8U TimerRegist ( INT8U TimeId, INT32U TimeCnt)
{

    INT8U i;

    for( i = 0; i < TIMERmax; i++ )
		if ( LongTimer[i].TimerID == TimeId )
		{	LongTimer[i].Count = TimeCnt;	// TimeCnt/2 Down Fail
			return( TRUE );
		}
    for( i = 0; i < TIMERmax; i++ )
		if ( LongTimer[i].TimerID == 0 )
		{	LongTimer[i].TimerID = TimeId;
			LongTimer[i].Count = TimeCnt;	// TimeCnt/2 Down Fail
			return( TRUE );
		}
	return( FALSE );
}

INT32U TimeRemainCheck(INT8U TimeId)
{
	INT32U i;

	for( i = 0; i < TIMERmax; i++ )
	{	if ( LongTimer[i].TimerID == TimeId )
		{
			i = LongTimer[i].Count;
			return(i);
		}
	}
	return( FALSE );
}

INT8U TimeOverCheck ( INT8U TimeId )
{
    INT8U i;

    for( i = 0; i < TIMERmax; i++ )
	{	if ( LongTimer[i].TimerID == TimeId )
		{	if ( LongTimer[i].Count == 0 )
			{	LongTimer[i].TimerID = 0;
				return( TRUE );
			}
		}
	}
	return( FALSE );
}
INT8U TimerCancel ( INT16U TimeId )
{
	INT16U	i;

    for( i = 0; i < TIMERmax; i++ )
		if ( LongTimer[i].TimerID == TimeId )
		{	LongTimer[i].TimerID = 0;
			LongTimer[i].Count = 0;
			return( TRUE );
		}
	return( FALSE );
}


void ForDelay(unsigned long int count)
{
    while(count--){WatchdogClear();}
}

////////////////////////////////////////////////////////////////////////////////
void WatchdogInit(void)
{
	// IWDG timeout equal to 280 ms (the timeout may varies due to LSI frequency dispersion)
	// Enable write access to IWDG_PR and IWDG_RLR registers
	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
	
	// IWDG counter clock: 40KHz(LSI) / 32 = 1.25 KHz
	IWDG_SetPrescaler(IWDG_CLK64);
	
	// Set counter reload value to 349
	IWDG_SetReload(1000L);
	
	// Reload IWDG counter
	IWDG_ReloadCounter();
	
	// Enable IWDG (the LSI oscillator will be enabled by hardware)
	IWDG_Enable();


}

void WatchdogClear(void)
{
	// Reload IWDG counter
	IWDG_ReloadCounter();
}
////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

