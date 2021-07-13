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

void ADCInit(int INT_EN)
{
	INT32U cpu_sr;

	ADC_Common_TypeDef *ADCb = ADC;
	ADC_TypeDef *ADCx = ADC1;	
//	ADC_TypeDef *ADCy = ADC2;	

	OS_ENTER_CRITICAL();

	ADCIndex = 0;
	ASTART = 0;

	ADC3Index = 0;
	ASTART3 = 0;


	ADCx->__B.SQR1.L = 0;	// 1EA
	ADCx->__B.SQR3.SQ1 = 0; // Start Zer0

	NVIC_Init(ADC_IRQn, INT_EN);

	// ADC1 regular channel14 configuration
	ADCx->__B.SMPR1.Data = 0x00FFFFFF;				// ADC_SampleTime_239Cycles5
	ADCx->__B.SMPR2.Data = 0x3FFFFFFF;				// ADC_SampleTime_239Cycles5

	// ADC
	ADCb->__B.CCR.MULT = __dMODE_INDEPENDENT;		// Multi ADC Mode
//	ADCb->__B.CCR.MULT = __dMODE_FastInterl;		// Multi ADC Mode

	ADCb->__B.CCR.DELAY = __DLY_5CYL;				// Delay between 2 sampling Phases
//	ADCb->__B.CCR.DMA = __DMA_DISABLE;				// DMA Mode (for Multi ADC mode)
	ADCb->__B.CCR.ADCPRE = __PRE_DIV8;				// PreScaler, 30MHz/8 = 3.75Mhz
#if 0	
	1개 67uSec   __PRE_DIV8
	1개 33uSec   __PRE_DIV4
	1개 16uSec   __PRE_DIV2
#endif
	ADCb->__B.CCR.VBATE = DISABLE;					// Delay between 2 sampling Phases
	ADCb->__B.CCR.TSVREFE = ENABLE; 				// temperature sensor enable
#if 1	
	// ADC1 configuration
	ADCx->__B.CR1.OVRIE = DISABLE;					// Overrun interrupt
	ADCx->__B.CR1.RES	= __RES_12BIT;					// Resolution
	ADCx->__B.CR1.AWDEN = DISABLE;					// Analog watchdog
	ADCx->__B.CR1.SCAN = DISABLE;					// Scan Mode
	ADCx->__B.CR1.EOCIE = INT_EN;					// interrupt enable

	ADCx->__B.CR2.CONT = DISABLE;					// Continuous Conversion
	ADCx->__B.CR2.DMAMODE = DISABLE;				// DMA Mode
	ADCx->__B.CR2.DDS = DISABLE;					// DMA Disable selection (for single ADC mode)
	ADCx->__B.CR2.ALIGN = __ALI_Right;				// Data Alignment
	ADCx->__B.CR2.EXTSEL = __T1_CC1;				// Start conversion of regular channels
	ADCx->__B.CR2.EXTEN = DISABLE;					// External Trigger Enable
	ADCx->__B.CR2.ADON = ENABLE;					// Enable ADC1
#endif
#if 0

	ADCy->__B.SQR1.L = 0;	// 1EA
	ADCy->__B.SQR3.SQ1 = 0; // Start Zer0

	// ADC1 regular channel14 configuration
	ADCy->__B.SMPR1.Data = 0x00FFFFFF;				// ADC_SampleTime_239Cycles5
	ADCy->__B.SMPR2.Data = 0x3FFFFFFF;				// ADC_SampleTime_239Cycles5

	ADCy->__B.CR1.OVRIE = DISABLE;					// Overrun interrupt
	ADCy->__B.CR1.RES	= __RES_12BIT;				// Resolution
	ADCy->__B.CR1.AWDEN = DISABLE;					// Analog watchdog
	ADCy->__B.CR1.SCAN = DISABLE;					// Scan Mode
	ADCy->__B.CR1.EOCIE = INT_EN;					// interrupt enable

	ADCy->__B.CR2.CONT = DISABLE;					// Continuous Conversion
	ADCy->__B.CR2.DMAMODE = DISABLE;				// DMA Mode
	ADCy->__B.CR2.DDS = DISABLE;					// DMA Disable selection (for single ADC mode)
	ADCy->__B.CR2.ALIGN = __ALI_Right;				// Data Alignment
	ADCy->__B.CR2.EXTSEL = __T1_CC1;				// Start conversion of regular channels
	ADCy->__B.CR2.EXTEN = DISABLE;					// External Trigger Enable
	ADCy->__B.CR2.ADON = ENABLE;					// Enable ADC1
#endif
	
	// Start ADC1 Software Conversion
	OS_EXIT_CRITICAL();
}


INT8U ADC_CheckFinish(INT8U channel)
{
	//SerPtr->printf("c111: %d, ADCSTART = %d\n", channel, ADCSTART[channel]);
	if(ADCSTART[channel] == ADCFINISH) return TRUE;
	return FALSE;
}

void ADC_ChannelEnable(INT8U channel)
{
	ADCSTART[channel] = ADCIDLE;
}




INT8U ADC3_CheckFinish(INT8U channel)
{
	//SerPtr->printf("c111: %d, ADCSTART = %d\n", channel, ADCSTART[channel]);
	if(ADC3START[channel] == ADCFINISH) return TRUE;
	return FALSE;
}

void ADC3_ChannelEnable(INT8U channel)
{
	ADC3START[channel] = ADCIDLE;
}


/*******************************************************************************
* Function Name  : ADC1_SWStart
* Description    : get ADC Value directly(only case no_interrupt mode
*                  group channel.
* Input          : - channel: where x can be 1 or 2 to select the ADC channel
* Output         : None
* Return         : - direct ADCx channel 12 bit value
*******************************************************************************/
void ADC1_SWStart(void)
{
    int i;

	if(ADC1->__B.CR1.EOCIE && ASTART == RESET)
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
				ADC1->__B.SQR3.SQ1 = ADCIndex;
				ADC1->__B.CR2.SWSTART = ENABLE;
				break;
			}
		}
	}

}

void ADC3_SWStart(void)
{
    int i;

	if(ADC2->__B.CR1.EOCIE && ASTART3 == RESET)
	{
		for(i = 0; i < __ADCMAX ; i++)
		{
			ADC3Index++;
			ADC3Index %= __ADCMAX;

			if(((Adc3En >> ADC3Index) & 0x01) && ADC3START[ADC3Index] == ADCIDLE)
			{
				ADC3_WRCNT[ADC3Index] = 0;
				ASTART3 = SET;

				ADC3START[ADCIndex] = ADCING;
				ADC2->__B.SQR3.SQ1 = ADCIndex;
				ADC2->__B.CR2.SWSTART = ENABLE;
				break;
			}
		}
	}

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

//	ADC1->__B.CR2.SWSTART = ENABLE;

	if(!ADC1->__B.CR2.ADON) return 0;
	if(!ADC1->__B.CR1.EOCIE)
	{
		ADC1->__B.SQR3.SQ1 = channel;
		ADC1->__B.CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
		
		while(!ADC1->__B.SR.EOC);
		ADC_DATA[channel] = ADC1->DR;
		return ADC_DATA[channel];
	}
	return 0;
}


// Return Value는 1000배가 곱한 값이다. ex) 3.403[V]->3403 return 됨..
// 12bit Value

INT16U AdctoVolt33V(INT16U Data)
{
	INT32U RetVal;

	RetVal = (((Data)*3300) / (1 << 12));
    return (INT16U)RetVal;
}

INT16U AdctoVolt5opamp(INT16U Data)
{
	INT32U  RetVal;

	RetVal = ( (((INT32U)(Data)*3300)/665 )*(665 + 340))/(1 << 12);

    return (INT16U)RetVal;
}

void SwapData(INT16U *a, INT16U *b)
{
	INT16U temp = *a;

	*a = *b;
	
	*b = temp;
}


//

/*******************************************************************************
* Function Name  : SelectSortMax
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
INT16U SelectAverage(INT16U *aptr, INT16U nlen)
{
	int i = 0;
	INT32U sum = 0;
	for(i = 0 ; i < nlen; i++)
	{
		sum += aptr[i];
	}

	return (INT16U)(sum/nlen);
	
}


INT16U SelectMax(INT16U *aptr, INT16U nlen)
{
	int i = 0;
	INT16U tmpMax = 0;
	for(i = 0 ; i < nlen; i++)
	{
		if(tmpMax < aptr[i]) tmpMax = aptr[i];
	}

	return tmpMax;
}


INT16U SelectSortMax(INT16U *aptr, INT16U nlen)
{
	int i, j ;

	if(nlen > __ADCAVR) nlen = __ADCAVR;

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
	return aptr[nlen-1];
}


/*******************************************************************************
* Function Name  : SelectSort
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


/*******************************************************************************
* Function Name  : ADC_IRQHandler(period = 40us): 1000= 25
* Description    : Enables or disables the selected ADC software start conversion .
* Input          : - ADCx: where x can be 1, 2 or 3 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC software start conversion.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/

void ADC_IRQInitHandler(void)
{
//	OSIntEnter();
	INT32U cpu_sr;

	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	CPU_CRITICAL_EXIT();

//	if (ADC1->__B.SR.EOC)
	{		
		ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = ADC1->DR;

		if(++ADC_WRCNT[ADCIndex] >= AdcBuffMax[ADCIndex])
		{
			ADC_WRCNT[ADCIndex] = 0;
			ADCSTART[ADCIndex] = ADCFINISH;
			ASTART = FALSE;
		}
		else{
			ADC1->__B.CR2.SWSTART = ENABLE;
		}
//		RUNLEDSEL ^= 1;
	}
#if 0
	if (ADC2->__B.SR.EOC)
	{		
		ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = ADC2->DR;

		if(++ADC_WRCNT[ADCIndex] >= AdcBuffMax[ADCIndex])
		{
			ADC_WRCNT[ADCIndex] = 0;
			ADCSTART[ADCIndex] = ADCFINISH;
			ASTART = FALSE;
		}
		else{
			ADC2->__B.CR2.SWSTART = ENABLE;
		}
//		RUNLEDSEL ^= 1;
	}	
#endif	
//	RUNLEDSEL ^= 1;

	OSIntExit();											// Tell uC/OS-II that we are leaving the ISR
}




void ADC3_IRQInitHandler(void)
{
//	OSIntEnter();
	INT32U cpu_sr;

	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	CPU_CRITICAL_EXIT();

//	if (ADC1->__B.SR.EOC)
	{		
		ADC3_AVR[ADC3Index][ ADC3_WRCNT[ADC3Index] ] = ADC3->DR;

		if(++ADC3_WRCNT[ADC3Index] >= Adc3BuffMax[ADC3Index])
		{
			ADC3_WRCNT[ADC3Index] = 0;
			ADC3START[ADC3Index] = ADCFINISH;
			ASTART3 = FALSE;
		}
		else{
			ADC3->__B.CR2.SWSTART = ENABLE;
		}
	}
	RUNLEDSEL ^= 1;

	OSIntExit();											// Tell uC/OS-II that we are leaving the ISR
}

int ReadEnvTempTable(int Adcvalue)
{
	INT32S tmpx10 = AdctoVolt33V(Adcvalue);

	tmpx10 = (tmpx10 - 500);

	return tmpx10;	// 10배 값이 return 된다. 
}

void BubbleSort(INT16U array[], INT16U min, INT16U max)
{
    // loop through every item in the array
    for (int i = min ; i <= max ; i++)
    {
        // loop a second time from the back of the array
        for (int j = max ; j > i ; j--)
        {
            // swap the elements if necessary
            if (array[j-1] > array[j])
            {
                int copy = array[j-1] ;
                array[j-1] = array[j] ;
                array[j] = copy ;
            }
        }
    }
}
 
INT16U Average_Sum(INT16U *aptr,INT16U AvgMAX, INT16U AvgMIN, INT16U nlen)
{
	INT32U sum = 0;
    int i= 0;
	for(i = AvgMIN; i < (nlen - AvgMAX); i++)
	{
		sum += aptr[i];
	}
	return sum = ((INT16U)(sum/(nlen- AvgMAX-AvgMIN)));
}


INT16U SelectSort_1(INT16U *aptr,INT16U *AvgValue, INT16U *PeakValue, INT16U AvgMAX, INT16U AvgMIN, INT16U PeakMAX, INT16U PeakMIN, INT16U nlen)
{
	int sum = 0;
	int sum1 = 0;
	
	int i= 0 , j = 0;
	INT32U sumtotal;
	INT16U tbuf[__ADCAVR];

	if(nlen > __ADCAVR) nlen = __ADCAVR;

	for(i = 0; i < nlen; i++)
	{
		tbuf[i] = aptr[i];
		sumtotal += aptr[i]; 
	}
#if 1
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
#endif
	for(i = AvgMIN; i < (nlen - AvgMAX); i++)
	{
		sum += tbuf[i];
	}
	*AvgValue = ((INT16U)(sum/(nlen- AvgMAX-AvgMIN)));


	for(i = PeakMIN; i < (nlen - PeakMAX); i++)
	{
//		SerPtr->printf("Sort[%d][%d]\n",i, tbuf[i]);

		sum1 += tbuf[i];
	}
	*PeakValue = ((INT16U)(sum1/(nlen-PeakMAX-PeakMIN)));

	return (INT16U)(sum/(nlen-(AvgMAX-AvgMIN)));
}



INT16U SelectSort_MinMax(INT16U *aptr, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen, INT8U Mode)
{
	int sum = 0;
	int i , j ;
	INT16U tbuf[__ADCAVR];

	if(nlen > __ADCAVR) nlen = __ADCAVR;
	
	for(i = 0; i < nlen; i++)
	{
		tbuf[i] = aptr[i];
	}

	for(i = 0 ; i < nlen - 1; i++)
	{
		for(j = i+1; j < nlen; j++ )
		{
			if(tbuf[i] > tbuf[j])
			{
				SwapData( &tbuf[i] , &tbuf[j]);
			}
		}
 	}

	for(i = MINGARBAGENO; i < (nlen - MAXGARBAGENO); i++)
	{
		sum += tbuf[i];

		
		#ifdef _DEBUG_Test
		if(AmpSts->ShunDownValue == 2)
		{
			if(Mode == Enable)
			{
				pUSART2.printf("Sort[%d][%d]\n",i, tbuf[i]);
			}
		}
		#endif
	}

	return (INT16U)(sum/(nlen-MAXGARBAGENO-MINGARBAGENO));
}




static int quick_sort_partition( INT16U array[], int start_pos, int end_pos)
{

	float pivot = array[start_pos];       // Smaller than pivot on left; larger on right
	int left_index = start_pos;    // First element
	int right_index = end_pos; // Last element

	while ( 1 ) // Loop forever; return once partitioning is completed
	{
		// Skip over large elements on right

		while ( array[right_index] > pivot && right_index >= start_pos )      
		right_index--;

		// Skip over small elements on left

		while ( array[left_index] < pivot && left_index <= end_pos )        
		left_index ++;                    

		if ( left_index < right_index )          // Exchange if halves aren't complete
		{
			INT16U temp = array[left_index];

			array[left_index] = array[right_index];

			array[right_index] = temp;

			left_index ++ ;                         // Skip over exchanged values
			right_index -- ;
		}
	else                                            // Otherwise, return location of pivot

	return  right_index;
	}
}

 
 
void quick_sort( INT16U array[], int start_pos, int end_pos)
{

   if ( start_pos == end_pos ) // Only one element
   return;

   int middle_pos = quick_sort_partition( array, start_pos, end_pos);  // Reposition elements

   quick_sort( array, start_pos, middle_pos);          // Sort left half
   quick_sort( array, middle_pos + 1, end_pos);     	// Sort right half
}

 


void SortSelect(INT16U *aptr, int start_pos, int end_pos)
{
	BubbleSort(aptr,start_pos,end_pos-1);
//	quick_sort(aptr,start_pos, end_pos-1);
//	mergeSort(aptr,start_pos, end_pos-1);
}

INT32U average_rssi(INT16U rssi[], int array_size)
{

	INT16U sum = 0;
	int i;

	if(array_size > __ADCAVR) array_size = __ADCAVR;

	for(i=0; i<array_size; i++)
	{
	//	   SerPtr->printf("0 : array_size[%d][%d]>[%d]\n", i,rssi[i],array_size);
	}

	quick_sort(rssi, 0, array_size-1);

	sum += rssi[i];

	sum /= (array_size-20);

	return sum;
}
 
void insertionSort(INT16U array[], INT16U min, INT16U max)
{
	int key ;
	// we loop through all elements in the original array from the second element
	for (int j = 1 ; j <= max ; j++)
	{
		// store the current element as the key
		key = array[j] ;
		// get the element just before the current element
		int i = j - 1 ;
		// loop through all elements from the key to the start
		// check if the current element is smaller than the key
		while (i >= 0 && array[i] > key)
		{
		 // we move the current element backward
		 array[i+1] = array[i] ;
		 i-- ;
		}
		// we finally move the key
		array[i+1] = key ;
	}
}


void mergeSort(INT16U array[], INT16U min, INT16U max)
{
	int i;
	
	for(i=0; i<max; i++)
	{
//	   SerPtr->printf("0 : array_size[%d][%d]>[%d]\n", i,array[i],max);
	}

    // prerequisite
    if (min < max)
    {
        // get the middle point
        int mid = (int)floor((max+min)/2) ;
        
        // apply merge sort to both parts of this
        mergeSort(array, min, mid) ;
        mergeSort(array, mid+1, max) ;
        
        // and finally merge all that sorted stuff
        merge(array, min, max, mid) ;
    }


}

void merge(INT16U array[], INT16U min, INT16U max, INT16U mid)
{
    int firstIndex = min ;
    int secondIndex = mid + 1 ;
    int index = min ;
//    int tempArray[max] ;
    int tempArray[__ADCAVR] ;
    // if there are still objects in both arrays
    while ((firstIndex <= mid) && (secondIndex <= max))
    {
        if (array[firstIndex] < array[secondIndex])
        {
            tempArray[index] = array[firstIndex] ;
            index++ ;
            firstIndex++ ;
        }
        else
        {
            tempArray[index] = array[secondIndex] ;
            index++ ;
            secondIndex++ ;
        }
    }
    
    // terminates the object of the lower array
    while (firstIndex <= mid)
    {
        tempArray[index] = array[firstIndex] ;
        index++ ;
        firstIndex++ ;
    }
    
    // terminates the object of the upper array
    while (secondIndex <= max)
    {
        tempArray[index] = array[secondIndex] ;
        index++ ;
        secondIndex++ ;
    }
    
    // transfer to the initial array
    for (int i = min ; i < index ; i++)
        array[i] = tempArray[i] ;
}

FlagStatus ADC_GetFlagStatus(ADC_TypeDef* ADCx, uint8_t ADC_FLAG)
{
  FlagStatus bitstatus = RESET;
  /* Check the parameters */
  assert_param(IS_ADC_ALL_PERIPH(ADCx));
  assert_param(IS_ADC_GET_FLAG(ADC_FLAG));

  /* Check the status of the specified ADC flag */
  if ((ADCx->SR & ADC_FLAG) != (uint8_t)RESET)
  {
    /* ADC_FLAG is set */
    bitstatus = SET;
  }
  else
  {
    /* ADC_FLAG is reset */
    bitstatus = RESET;
  }
  /* Return the ADC_FLAG status */
  return  bitstatus;
}


/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/

