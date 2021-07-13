/*********************************************
* File Name          : usart1_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define	KEYBUZ_C


#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

#include "stm32f10x_conf.h"
#include "../include/KeyBuzExt.h"
#include "KeyBuz5Key_v0901.h"


void KeyBuzInit (INT16U bAddr)
{
	m5KeySts->mFirstKey = 0;
	m5KeySts->mKeyRDIndex = 0;
	m5KeySts->mKeyWRIndex = 0;
	m5KeySts->mKeyDebounce = 0;
	m5KeySts->mKEYCSPtr = bAddr;


	TIM1_Init(550L);	// 550Hz freq Set
	TIM1_OC1Init(__TIM1_PWM2, 50L); // 50: 50%
	BuzzPortOff();
}

signed char KeyDetecting(void)
{
	INT8U	keyCnt = 0;
	INT8U rtmpval = 0;

	rtmpval = (INT8U)(~(ExpioReadData(m5KeySts->mKEYCSPtr)) & keyMASK);

	if(rtmpval)
	{
		keyCnt++;
		m5KeySts->mFirstKey = rtmpval;
	}

	if(keyCnt == TRUE)
	{
		if(m5KeySts->mPrevKey != m5KeySts->mFirstKey) m5KeySts->mKeyDebounce = 0;
		else
		{
			m5KeySts->mKeyDebounce++;
		}
		m5KeySts->mPrevKey = m5KeySts->mFirstKey;

		if( m5KeySts->mKeyDebounce == DebouncedMin)
		{
			switch(m5KeySts->mPrevKey)
			{
				case keyMENU:
				case keyUP:
				case keyDOWN:
				case keyENTR:
				case keyESC:
					m5KeySts->mKeyBuffer[m5KeySts->mKeyWRIndex] = (INT8U)m5KeySts->mPrevKey;
				break;
				default: return -1;
			}

			{
				signed char rval = m5KeySts->mKeyBuffer[m5KeySts->mKeyWRIndex];

				m5KeySts->mKeyWRIndex++;
				m5KeySts->mKeyWRIndex %= KeyBufferNum;

				return rval;
			}
		}
		else if(m5KeySts->mKeyDebounce >= DebouncedMax)
		{
			m5KeySts->mKeyDebounce = 0;
		}
	}
	else if(!keyCnt) m5KeySts->mKeyDebounce = 0;

	return -1;
}

INT8U IsKey5Pushed(INT8U DataNum)
{
	INT8U retValue = 0;

	if(m5KeySts->mKeyWRIndex - m5KeySts->mKeyRDIndex == 0) retValue = 0;
	else if(m5KeySts->mKeyWRIndex - m5KeySts->mKeyRDIndex > 0){
		retValue = m5KeySts->mKeyWRIndex - m5KeySts->mKeyRDIndex;
		if( retValue < DataNum ) retValue = 0;
	}
	else if(m5KeySts->mKeyWRIndex - m5KeySts->mKeyRDIndex < 0){
		retValue = (KeyBufferNum + m5KeySts->mKeyWRIndex) - m5KeySts->mKeyRDIndex;
		if( retValue < DataNum ) retValue = 0;
	}

	return retValue;
}

INT8U ReadKey5Buffer(void)
{
	INT8U retValue = 0;

	retValue = m5KeySts->mKeyBuffer[m5KeySts->mKeyRDIndex++];
	m5KeySts->mKeyRDIndex = m5KeySts->mKeyRDIndex%KeyBufferNum;

	return retValue;
}

void Key5BufferClear(void)
{
	m5KeySts->mKeyWRIndex = 0;
	m5KeySts->mKeyRDIndex = 0;
}

//==========================================================================
//	NAME:		BuzzShort, BuzMedium, BuzLong
//	FUNCTION:		WRITE TO BUZZER TIMER
//	INPUTS:		None
//	OUTPUTS:		None
//==========================================================================
void CheckBuzzTimer(void)
{
//=======================================================//
	if ( BuzzTimer != 0 )
    {
    	BuzzTimer--;    	/* The Buzzer Timer Timer */
	}
	else
	{
		BuzzPortOff();
	}
	//=======================================================//
}

void BuzzPortOff(void)
{
	TIM1->CCER.Bit.CC1E = DISABLE;
}


void BuzzShort(void)
{
	BuzzTimer = 70;
	TIM1->CCER.Bit.CC1E = ENABLE;
}

void BuzzMedium(void)
{
	BuzzTimer = 250;
	TIM1->CCER.Bit.CC1E = ENABLE;
}

void BuzzLong(void)
{
	BuzzTimer = 255;
	TIM1->CCER.Bit.CC1E = ENABLE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

