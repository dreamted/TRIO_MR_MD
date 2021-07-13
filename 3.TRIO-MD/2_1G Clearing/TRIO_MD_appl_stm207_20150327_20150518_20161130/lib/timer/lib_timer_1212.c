
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : timer_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
#include "stm32f2xx_1212.h"
#include "../include/lib_timerext.h"
#include "lib_timer_1212.h"



/*******************************************************************************
* Function Name  : TimerInit
* Description    : This function software timer initialize
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void TimerInit(void)
{
	INT8U i = 0;

	for(i = 0; i < TIMERmax; i++)
	{
		LongTimer[i].TimerID = 0;
		LongTimer[i].Count = 0;
	}
}
void CheckSoftTimer(void)
{
	int i = 0;

	for(i = 0; i < TIMERmax; i++ )
	{
		if(LongTimer[i].Count != 0)
		{
		    if(LongTimer[i].Count >= 2) LongTimer[i].Count -= 2;
			else 						LongTimer[i].Count--;
		}
	}
}

INT8U TimerRegist(int TimeId, INT32U TimeCnt)
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

INT32U TimeRemainCheck(int TimeId)
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

INT8U TimeOverCheck(int TimeId )
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
INT8U TimerCancel(int TimeId )
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
	u32 ms = 3000L;
	
	// IWDG timeout equal to 280 ms (the timeout may varies due to LSI frequency dispersion)
	// Enable write access to IWDG_PR and IWDG_RLR registers
	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
	
	// IWDG counter clock: 32KHz(LSI) / 32 = 1.25 KHz
	IWDG_SetPrescaler(IWDG_Prescaler_256);
	
	// Set counter reload value to 349
	IWDG_SetReload((u16)((ms * (LSICLK))/(256L * 1000L)));
	
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

