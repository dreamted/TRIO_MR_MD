/**
  ******************************************************************************
  * @file RCCalibration/src/HSI_calibration.c 
  * @author  MCD Application Team
  * @version  V2.0.0
  * @date  04/27/2009
  * @brief  HSI Calibration basic routines
  ******************************************************************************
  * @copy
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THEf
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  */ 


// Includes --------------------------------------------------------------------
#include <includes.h>
#include "HSI_calibration_v0907.h"
// Private variables------------------------------------------------------------
s32 Real_RC_Frequency = 0;

void TIM3_IRQHandler(void)
{
	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	 //TIM_ClearITPendingBit(TIM3, TIM_IT_Update);
	// TIM3->SR = 0;
	HSI_FreqMeasure();

	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
}

/**
  * @brief  Calibrates the internal RC and returns the current frequency 
  *   after calibration.
  * @param  None
  * @retval : None
  */
void HSI_FreqMeasure(void)
{
	INT32U tmp;

	{	
		// Clear TIM3 Capture compare 1 interrupt pending bit
		//TIM_ClearITPendingBit(TIM3, TIM_IT_CC1);
		TIM3->SR = 0;

		// Get the Input Capture 1 value of timer TIM3
#if	  (SYSCLK	>  33000000L)
		tmp = (65535 + TIM_GetCapture1(TIM3)) * Ref_Frequency;
#else
		tmp = (TIM_GetCapture1(TIM3)) * Ref_Frequency;
#endif
		tmp = Real_RC_Frequency * 31 + tmp;
			Real_RC_Frequency = (tmp >> 5);
  	}
}

void HSI_CalibrationInit(void)
{
	NVIC_Init(TIM3_IRQChannel, ENABLE);
	TIM_ConfigurationForHSI();
}

/*******************************************************************************
  * @brief  Calibrates the internal RC with the minimum error found 
  *   and returns the frequency error after calibration.
  * @param  None
  * @retval : The HSI frequency value after calibration
*******************************************************************************/
void HSI_CalibrateMinError(void)
{
	s32 rval = 0;
	s32 _HSITRIM = (RCC->CR.HSITRIM);

	if( Real_RC_Frequency - (SYSCLK + 9000) > 0)
	{
		if(--_HSITRIM < 0)  _HSITRIM = 0;
		rval = TRUE;
	}
	if( Real_RC_Frequency - (SYSCLK - 9000) < 0)
	{
		if(++_HSITRIM > 31) _HSITRIM = 31;
		rval = TRUE;
	}

	if(rval) RCC_AdjustHSICalibrationValue(_HSITRIM);

}



/**
  * @brief  Calibrates the internal RC with the maximum allowed Error 
  *   value fixed by the user. If this value was not found, this
  *   function sets the RC frequency to default value (HSITRIM = 16).
  * @param AllowedErrorMax: maximum absolute value allowed of the HSI 
  *   frequency Error given in Hz.
  * @param Freq: pointer to a uint32_t variable that will contain the value  
  *   of the HSI frequency after calibration.
  * @retval : - An ErrorStatus enumuration value:
  * @param SUCCESS: an error with value =< AllowedErrorMax was
  *   found.
  * @param ERROR: an error with value =< AllowedErrorMax was
  *   not found.                  
  */
u32 HSI_CalibrateFixedError(u32 AllowedErrorMax, s32* Freq)
{
#if 0
   NVIC_InitTypeDef  NVIC_InitStructureForHSI; 
   int32_t Error=0;
   int8_t HSITRIM=16;
   int8_t Sign= 1;
   int8_t i;
   ErrorStatus CalibrationStatus = ERROR;
 
   /* System clock configuration for HSI calibration process */
   RCC_ConfigurationForHSI();

   /* Enable the TIM3 global Interrupt for HSI calibration process */
   NVIC_InitStructureForHSI.NVIC_IRQChannel = TIM3_IRQn;
   NVIC_InitStructureForHSI.NVIC_IRQChannelPreemptionPriority = 0;
   NVIC_InitStructureForHSI.NVIC_IRQChannelSubPriority = 1;
   NVIC_InitStructureForHSI.NVIC_IRQChannelCmd = ENABLE;
   NVIC_Init(&NVIC_InitStructureForHSI);

   /* Configure the GPIO ports for HSI calibration process */

#ifdef  USE_Reference_RTC   
	// RTC configuration for HSI calibration process
	// output the RTC clock with frequency divided by 64 on the Tamper pin
	BKP_RTCOutputConfig(BKP_RTCOutputSource_CalibClock);
#endif   
  
   /* Configure the timer for HSI calibration process */
   TIM_ConfigurationForHSI();

   /* RC Frequency measurement for different values 0 to 31 of HSITRIM[4:0] bits
      in RCC_CR register */
   for(i=0; i<32; i++)
   {
     /* Reset "measurement done" */
     MeasurementDone = 0;
     
     /* Compute next HSITRIM value for frequency measurments */
     /* HSITRIM = 16 then 15, 17, 14, 18, 13, 19 etc until HSITRIM = 31 */
     HSITRIM = HSITRIM + (i*Sign);
     Sign *= (-1);
       
     /* Set the HSITRIM[4:0] bits to HSITRIM value to be ready for measurements */
     RCC_AdjustHSICalibrationValue(HSITRIM);
    
     /* Start Frequency measurement for current HSITRIM value:
     Enable TIM3 and its interrupts */
     TIM_Cmd(TIM3, ENABLE); 
     TIM_ITConfig(TIM3, TIM_IT_CC1 | TIM_IT_Update, ENABLE);
    
     /* Wait for all periods of the current frequency were measured */
     while (MeasurementDone == 0)
     {
     }
     
     /* Initialize the counted periods after measurement */
     PeriodCount=0;
     
     /* Disable TIM3 */
     TIM_Cmd(TIM3, DISABLE); 
    
     /* Disable TIM3 interrupts to avoid to enter again in the interrpt routine */
     TIM_ITConfig(TIM3, TIM_IT_CC1 | TIM_IT_Update, DISABLE);
     
     /* Compute current frequency Error */
     if(((int32_t)Real_RC_Frequency - 8000000) < 0)
     {
       Error = 8000000 - Real_RC_Frequency;
     }
     else
     {
       Error = Real_RC_Frequency - 8000000;
     }
     /* If an error less or equal to value settled by the user */
     if((uint32_t)Error <= AllowedErrorMax )
     {
       CalibrationStatus = SUCCESS; /* The calibration has succeed */
       break; /* stop searching and measurments for frequencies */
     }
   }

   *Freq = Real_RC_Frequency;
   
   /* If the frequncy error settled by the user was not found in the chip */
   if(CalibrationStatus == ERROR)
   {
     /* Set the HSITRIM[4:0] bits to HSITRIM default value */      
     RCC_AdjustHSICalibrationValue(16);
   }
   
   /* Disable TIM3 and its interrupts */
   NVIC_InitStructureForHSI.NVIC_IRQChannel = TIM3_IRQn;
   NVIC_InitStructureForHSI.NVIC_IRQChannelCmd = DISABLE;
   NVIC_Init(&NVIC_InitStructureForHSI);

#ifdef  USE_Reference_RTC     
   /* Restore user configuration of RTC output on the Tamper pin */
   BKP_RTCOutputConfig(CC0_Bit);
    
   /* Restore the user configuration of the access to BKP Domain */
   PWR_BackupAccessCmd(BA_bit);
#endif
    
   /* Restore RCC User configuration */
   
   /* Return the calibration status: failed or succeed */
   return (CalibrationStatus);
#endif
return 0;

}


/*******************************************************************************
  * @brief  Configures the TIM to mesure the frequency.
  * @param  None
  * @retval : None
*******************************************************************************/
void TIM_ConfigurationForHSI(void)
{
  	////////////////////////////////////////////////////////////////////////////
	// TIM3 configuration: Input Capture mode: slave mode reset ---
	// The tamper pin (PC13) is connected to TIM3 CH1 pin (PA.06),          
	// The Rising edge is used as active edge,
	// The TIM3 CCR1 is used to compute the RC frequency value
	////////////////////////////////////////////////////////////////////////////
    TIM_ICInitTypeDef  TIM_ICInitStructureForHSI;
//	TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;

	RCC->APB1ENR.Data |= (__TIM3EN);

//TIM_TimeBaseStructure.TIM_Prescaler = 0;
//TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
//TIM_TimeBaseStructure.TIM_Period = ((unsigned long long )1 * SYSCLK)/(1000L);	//4095;
//TIM_TimeBaseStructure.TIM_ClockDivision = 0;
//TIM_TimeBaseStructure.TIM_RepetitionCounter = 0;

//TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure);
//TIM_ITConfig(TIM3, TIM_IT_Update, ENABLE);

/* TIM1 counter enable */
//TIM_Cmd(TIM3, ENABLE);

    TIM_ICStructInit(&TIM_ICInitStructureForHSI);
	TIM_ICInitStructureForHSI.TIM_Channel = TIM_Channel_1;
    TIM_ICInitStructureForHSI.TIM_ICPolarity = TIM_ICPolarity_Rising;
    TIM_ICInitStructureForHSI.TIM_ICSelection = TIM_ICSelection_DirectTI;
    TIM_ICInitStructureForHSI.TIM_ICPrescaler = TIM_ICPSC_DIV1;
    TIM_ICInitStructureForHSI.TIM_ICFilter = 0x0;

    TIM_ICInit(TIM3, &TIM_ICInitStructureForHSI);   
    // Select the TIM3 Input Trigger: TI1FP1
    TIM_SelectInputTrigger(TIM3, TIM_TS_TI1FP1);
    // Select the slave Mode: Reset Mode
    TIM_SelectSlaveMode(TIM3, TIM_SlaveMode_Reset);   
    // Enable the Master/Slave Mode
    TIM_SelectMasterSlaveMode(TIM3, TIM_MasterSlaveMode_Enable);    
    // Disable TIM3 and its interrupts to avoid unwanted frequency measurements
    TIM_Cmd(TIM3, ENABLE); 
    TIM_ITConfig(TIM3, TIM_IT_CC1, ENABLE);
//	TIM_ITConfig(TIM3, TIM_IT_CC1| TIM_IT_Update, ENABLE);
//	TIM_ITConfig(TIM3, TIM_IT_Update, ENABLE);
	// Reset all flags on TIM3_SR register
    TIM3->SR = 0x0000;

}  



/**
  * @brief  Configures the different system clocks.
  * @param  None
  * @retval : the Peripheral used by the user before the calibration
  */
void RCC_ConfigurationForHSI(void)
{
#if 0 
    /* Enable Prefetch Buffer */
    FLASH_PrefetchBufferCmd(FLASH_PrefetchBuffer_Enable);

    /* HCLK = SYSCLK = 8MHz */
    RCC_HCLKConfig(RCC_SYSCLK_Div1); 
      
    /* PCLK2 = HCLK = 8MHz */
    RCC_PCLK2Config(RCC_HCLK_Div1); 

    /* PCLK1 = HCLK = 8MHz */
    RCC_PCLK1Config(RCC_HCLK_Div1);
    
    /* Flash 0 wait state */
    FLASH_SetLatency(FLASH_Latency_0);

    /* Select HSI as system clock source */
    RCC_SYSCLKConfig(RCC_SYSCLKSource_HSI);
    
    /* Get the used user clocks on APB1 before calibration */
    APB1_UserPeriph = RCC->APB1ENR;
    /* Get the used user clocks on APB2 before calibration */
    APB2_UserPeriph = RCC->APB2ENR;    

    /* Enable (add to user clocks) TIM3, Buckup and PWR clocks */
    RCC_APB1PeriphClockCmd( APB1_UserPeriph | RCC_APB1Periph_TIM3 |
                            RCC_APB1Periph_BKP  |
                            RCC_APB1Periph_PWR , ENABLE);

    /* Enable (add to user clocks)  GPIOA, GPIOC and AFIO clocks */
    RCC_APB2PeriphClockCmd( APB2_UserPeriph | RCC_APB2Periph_GPIOA |
                            RCC_APB2Periph_GPIOC |
                            RCC_APB2Periph_AFIO, ENABLE);

#endif
}
//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

