/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_adc.c
* Author             : MCD Application Team
* Version            : V1.0
* Date               : 10/08/2007
* Description        : This file provides all the ADC firmware functions.
********************************************************************************/
#define ADC_C

// Includes ////////////////////////////////////////////////////////////////////
#include "../include/main.h"
/// AD 1 Sample  당 20uSEC  50개 1mSec
#define ADC_AUTO_SCAN_ONE_TIME
//#define ADC_AVER


void ADCInit(int INT_EN)
{
	INT32U cpu_sr;
	
	ADC_TypeDef *ADCx = ADC1;

	OS_ENTER_CRITICAL();

//	AdcEn.Data = 0;
	ADCIndex = 0;
	ASTART = 0;
	ADCx->SQR1.L = 0;	// 1EA
	ADCx->SQR3.SQ1 = 0; // Start Zer0

	NVIC_Init(ADC_IRQChannel, INT_EN);
	
	// ADC1 regular channel14 configuration
	ADCx->SMPR1.Data = 0x00FFFFFF;		// ADC_SampleTime_239Cycles5
	ADCx->SMPR2.Data = 0x3FFFFFFF;		// ADC_SampleTime_239Cycles5

	// ADC1 configuration
	ADCx->CR1.DUALMOD = __dMODE_INDEPENDENT;
	ADCx->CR1.SCAN = DISABLE;
	ADCx->CR1.EOCIE = INT_EN;		// interrupt enable
	ADCx->CR2.CONT = DISABLE;
	ADCx->CR2.ALIGN = __ALI_Right;
	ADCx->CR2.EXTSEL = __SWSTART;
	ADCx->CR2.DMAMODE = DISABLE;
	ADCx->CR2.EXTTRIG = ENABLE;
	ADCx->CR2.TSVREFE = ENABLE; 	// temperature sensor enable
	ADCx->CR2.ADON = ENABLE;		// Enable ADC1

	// Enable ADC1 reset calibaration register
	{
		INT16U rtry = 0xffff;
	
		ADCx->CR2.RSTCAL = SET;
		while((rtry--) && ADCx->CR2.RSTCAL);
	}
	// Start ADC1 calibaration
	{
		INT16U rtry = 0xffff;
	
		ADCx->CR2.CAL = SET;
		while((rtry--) && ADCx->CR2.CAL);
	}
	// Start ADC1 Software Conversion
	//ADCx->CR2.Bit.SWSTART = INT_EN;//INT_EN;		// ADC1->CONVERTER START

	OS_EXIT_CRITICAL();
}


INT8U ADC_CheckFinish(INT8U channel)
{
//	SerPtr->printf("c111[%d]: %d, ADCSTART = %d\n", iAdcIndex ,channel, ADCSTART[channel]);
	if(ADCSTART[channel] == ADCFINISH) return TRUE;
	return FALSE;
}

void ADC_ChannelEnable(INT8U channel)
{
	ADCSTART[channel] = ADCIDLE;
}

void ADCChannelSEL(void)
{
	ADC_ChannelEnable(ADC_Channel_0);
//	ADC_ChannelEnable(ADC_Channel_1);
	ADC_ChannelEnable(ADC_Channel_2);
	ADC_ChannelEnable(ADC_Channel_3);
//	ADC_ChannelEnable(ADC_Channel_4);
	ADC_ChannelEnable(ADC_Channel_5);
	ADC_ChannelEnable(ADC_Channel_6);
	ADC_ChannelEnable(ADC_Channel_7);
	ADC_ChannelEnable(ADC_Channel_8);
	ADC_ChannelEnable(ADC_Channel_9);
	ADC_ChannelEnable(ADC_Channel_10);
	ADC_ChannelEnable(ADC_Channel_11);
	ADC_ChannelEnable(ADC_Channel_12);
	ADC_ChannelEnable(ADC_Channel_13);
	ADC_ChannelEnable(ADC_Channel_14);	
	ADC_ChannelEnable(ADC_Channel_15);
}

/*******************************************************************************
* Function Name  : GetAdcValue
* Description    : get ADC Value directly(only case no_interrupt mode
*                  group channel.
* Input          : - channel: where x can be 1 or 2 to select the ADC channel
* Output         : None
* Return         : - direct ADCx channel 12 bit value
*******************************************************************************/
void ADC1_SWStart(void)
{
#ifdef ADC_AUTO_SCAN_ONE_TIME
	int i;

	if(ADC1->CR1.EOCIE && ASTART == RESET)
	{
		for(i = 0; i < __ADCMAX ; i++)
		{
			ADCIndex++;
			ADCIndex %= __ADCMAX;

			if(((AdcEn >> ADCIndex) & 0x01) && ADCSTART[ADCIndex] == ADCIDLE)
			{
				ADC_WRCNT[ADCIndex] = 0;
				ASTART = SET;

				ADCSTART[ADCIndex] = ADCING;
				ADC1->SQR3.SQ1 = ADCIndex;
				ADC1->CR2.SWSTART = ENABLE;
				break;
			}
		}
	}

///////////////////////////////////////////////////////////////////////////////
#else    /////////////////////////////////////// #else(ADC_AUTO_SCAN_ONE_TIME)
	int i = 0;

#ifndef ADC_AVER
	while(ASTART){ ForDelay(1); }
#endif
	if(ADC1->CR1.EOCIE)
	{
		for(i = 0; i < __ADCMAX ; i++)
		{
			ADCIndex++;
			ADCIndex %= __ADCMAX;

			if((AdcEn.Data >> ADCIndex) & 0x01 )
			{
#ifndef ADC_AVER
				ADC_WRCNT[ADCIndex]++;
				ADC_WRCNT[ADCIndex] %= __ADCAVR;
#endif
				break;
			}
		}
		ADC1->SQR3.SQ1 = ADCIndex;
		ADC1->CR2.SWSTART = ENABLE;
	}
#endif	/////////////////////////////////////// #endif(ADC_AUTO_SCAN_ONE_TIME)
	
}



/*******************************************************************************
* Function Name  : GetAdcValue
* Description    : get ADC Value directly(only case no_interrupt mode
*                  group channel.
* Input          : - channel: where x can be 1 or 2 to select the ADC channel
* Output         : None
* Return         : - direct ADCx channel 12 bit value
*******************************************************************************/
INT16U GetAdcValue(INT8U channel)
{
	if(!ADC1->CR2.ADON) return 0;
	if(!ADC1->CR1.EOCIE)
	{
		ADC1->SQR3.SQ1 = channel;
		ADC1->CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
		
		while(!ADC1->SR.EOC);
		ADC_DATA[channel] = ADC1->DR;
		return ADC_DATA[channel];
	}
	return 0;
}

INT16S Get_AdcValue(INT8U channel)
{
	//if(!ADC1->CR2.ADON) return 0;
	if(!ADC1->CR1.EOCIE)
	{
		ADC1->SQR3.SQ1 = channel;
		ADC1->CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
		
		while(!ADC1->SR.EOC);
		ADC1->SR.EOC = 0;
		return ADC1->DR;
	}
	return -1;
}



void GetAdcValueInt(INT8U channel)
{
	while(ASTART){ForDelay(1);}
	ForDelay(1);
	ASTART = 1;
	ADC1->SQR3.SQ1 = channel;
	ADC1->CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
}


INT16U AdctoVolt33V(INT16U Data)
{
	double RetVal;

	RetVal = ((((double)Data)*3300.0) / (1 << 12));
    return (INT16U)RetVal;
}

INT16U AdctoVolt5opamp(INT16U Data)
{
	double RetVal;

	RetVal = (((((double)Data)*33*(665 + 340)) / (1 << 12))/(665.0));

	if((int)(RetVal*100) >= 5) RetVal += 1;
    return (INT16U)RetVal;
}


void SwapData(INT16U *a, INT16U *b)
{
	INT16U temp = *a;

	*a = *b;
	
	*b = temp;
}

//#define GARBAGENO	2		// 버리는 값...
//#define GARBAGENO	10		// 버리는 값...
#define GARBAGENO	2		// 버리는 값...
// 
/*******************************************************************************
* Function Name  : ADC_IRQHandler
* Description    : 각 ADC값들을내림차순으로 정리하여, 낮은수치 몇개를 정리하여 높은수로만 평균값함..
*				   GARBAGENO: 버리는 낮은 값들.. 1이면 낮은값 1개를 버린다.
*
*					이 함수는 인터럽트 내에서 average를 취하지 않을 때,
*					메인 호출 함수 내에서 호출하여 사용한다.
* Input          : - aptr: 각 Channel의 ADC DATA들...(ADC_AVR)
* Output         : None
* Return         : 높은수 값들의 평균값.
* Example		 : ADC_DATA[ADC_Channel_0] = SelectSort(ADC_AVR[ADC_Channel_0]);
*******************************************************************************/
INT16U SelectSortMinMax(INT16U *aptr, INT16U *minvalue, INT16U *Maxvalue, INT16U nlen)
{
	INT16U i = 0, j = 0;


	for(i = 0 ; i < nlen - 1; i++)
	{

		for(j = i+1; j < nlen; j++ )
		{
			if(aptr[i] > aptr[j])
			{
				SwapData( &aptr[i] , &aptr[j]) ;
			}
		}
	}

	*minvalue = aptr[0];
	*Maxvalue = aptr[nlen - 1];
	

	return TRUE;
}


INT16U SelectSort(INT16U *aptr, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen)
{
	int sum = 0;
	int i , j ;
	INT32U sumtotal;
	INT16U tbuf[__ADCAVR];

	if(nlen > __ADCAVR) nlen = __ADCAVR;

	for(i = 0; i < nlen; i++)
	{
		tbuf[i] = aptr[i];
		sumtotal += aptr[i]; 
	}

	for(i = 0 ; i < nlen - 1; i++)
	{

		for(j = i+1; j < nlen; j++ )
		{
			if(tbuf[i] > tbuf[j])
			{
				SwapData( &tbuf[i] , &tbuf[j]) ;
			}
		}
 	}

	for(i = MINGARBAGENO; i < nlen - MAXGARBAGENO; i++)
	{
		sum += tbuf[i];
	}

	return (INT16U)(sum/(nlen-MAXGARBAGENO-MINGARBAGENO));
}


INT16U SelectSort_1(INT16U *aptr,INT16U *minvalue, INT16U *Maxvalue, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U MAXGARBAGENO_1, INT16U MINGARBAGENO_1, INT16U nlen)
{
	int sum = 0;
	int sum1 = 0;
	
	int i , j ;
	INT32U sumtotal;
	INT16U tbuf[__ADCAVR];

	if(nlen > __ADCAVR) nlen = __ADCAVR;

	for(i = 0; i < nlen; i++)
	{
		tbuf[i] = aptr[i];
		sumtotal += aptr[i]; 
	}

	for(i = 0 ; i < nlen - 1; i++)
	{
		for(j = i+1; j < nlen; j++ )
		{
			if(tbuf[i] > tbuf[j])
			{
				SwapData( &tbuf[i] , &tbuf[j]) ;
			}
		}
 	}
	//	SelectSort_1(ADC_AVR[ADC_Channel_8],&min, &max, 5, 80, 20, 10, __ADCAVR);

	for(i = MINGARBAGENO; i < nlen - MAXGARBAGENO; i++)
	{
		sum += tbuf[i];
	}

	for(i = MINGARBAGENO_1; i < nlen - MAXGARBAGENO_1; i++)
	{
		sum1 += tbuf[i];
	}

	*minvalue = AdctoVolt33V((INT16U)(sum/(nlen-MAXGARBAGENO-MINGARBAGENO)));
	*Maxvalue = AdctoVolt33V((INT16U)(sum1/(nlen-MAXGARBAGENO_1-MINGARBAGENO_1)));

	return (INT16U)(sum/(nlen-MAXGARBAGENO-MINGARBAGENO));
}


INT16U Detect_SUM(INT16U *aptr,INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen)
{
	int sum = 0;
	int i ;

	for(i = MINGARBAGENO; i < nlen - MAXGARBAGENO; i++)
	{
		sum += aptr[i];
	}
	return (INT16U)(sum/(nlen-MAXGARBAGENO-MINGARBAGENO));
}


/*******************************************************************************
* Function Name  : ADC_IRQHandler
* Description    : Enables or disables the selected ADC software start conversion .
* Input          : - ADCx: where x can be 1, 2 or 3 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC software start conversion.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_IRQHandler(void)
{

	INT32U cpu_sr;

	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	CPU_CRITICAL_EXIT();
#ifdef ADC_AUTO_SCAN_ONE_TIME

	ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = ADC1->DR;

	if(++ADC_WRCNT[ADCIndex] >= __ADCAVR)
	{
		ADC_WRCNT[ADCIndex] = 0;
		ADCSTART[ADCIndex] = ADCFINISH;
		ASTART = FALSE;
	}
	else{
		ADC1->CR2.SWSTART = ENABLE;
	}

#else /////////////////////////////////////// #else(ADC_AUTO_SCAN_ONE_TIME)

	
#ifdef ADC_AVER
	// Get injected channel10 and channel11 converted value
	ADC_SUM[ADCIndex] -= ADC_DATA[ADCIndex];
	ADC_SUM[ADCIndex] += ADC1->DR;
    ADC_DATA[ADCIndex] = ADC_SUM[ADCIndex]/__ADCAVR;
#else
	ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = ADC1->DR;
	ASTART = 0;
#endif

#endif /////////////////////////////////////// #endif(ADC_AUTO_SCAN_ONE_TIME)

	OSIntExit();											// Tell uC/OS-II that we are leaving the ISR
}


int ReadEnvTempTable(int channel)
{
#ifdef ADC_AVER
	INT32S tmpx10 = AdctoVolt33V(ADC_DATA[channel]);
#else
	INT32S tmpx10 = AdctoVolt33V(ADC_AVR[channel][0]);
#endif
	tmpx10 = (tmpx10 - 500);

	return tmpx10;	// 10배 값이 return 된다. 
}

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
