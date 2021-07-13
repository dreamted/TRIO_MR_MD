/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_adc.c
* Author             : MCD Application Team
* Version            : V1.0
* Date               : 10/08/2007
* Description        : This file provides all the ADC firmware functions.
********************************************************************************/
// Includes ////////////////////////////////////////////////////////////////////

#include "stm32f10x_conf.h"


#define V25		1738L	// 1.4v
#define Vsp		5558L	// 4.4478mv/'c --> 4.3

int  ReadIntTempTable(u16 Data)
{
	int __tC = (int)(1775L - Data);

	return(((__tC * 10000)/Vsp) + 250);
}


/*******************************************************************************
* Function Name  : ADC_SoftwareStartConvCmd
* Description    : Enables or disables the selected ADC software start conversion .
* Input          : - ADCx: where x can be 1, 2 or 3 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC software start conversion.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
//extern __SerStrPtr *SerPtr;

void ADC_SoftwareStartConvCmd(ADC_TypeDef* ADCx, u32 NewState)
{
	if(ADCx->CR1.EOCIE)
	{
		ADCx->CR2.SWSTART = NewState;
	}
}

/*******************************************************************************
* Function Name  : ADC_DiscModeChannelCountConfig
* Description    : Configures the discontinuous mode for the selected ADC regular
*                  group channel.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - Number: specifies the discontinuous mode regular channel
*                    count value. This number must be between 1 and 8.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_DiscModeChannelCountConfig(ADC_TypeDef* ADCx, u8 Number)
{
  u32 tmpreg1 = 0;
  u8 tmpreg2 = 0;

  /* Check the parameters */
  //assert_param(IS_ADC_REGULAR_DISC_NUMBER(Number));

  /* Get the old register value */
  tmpreg1 = ADCx->CR1.Data;
  /* Clear the old discontinuous mode channel count */
  tmpreg1 &= CR1_DISCNUM_Reset;
  /* Set the discontinuous mode channel count */
  tmpreg2 = Number - 1;
  tmpreg1 |= ((u32)tmpreg2 << 13);
  /* Store the new register value */
  ADCx->CR1.Data = tmpreg1;
}

/*******************************************************************************
* Function Name  : ADC_DiscModeCmd
* Description    : Enables or disables the discontinuous mode on regular group
*                  channel for the specified ADC
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC discontinuous mode
*                    on regular group channel.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_DiscModeCmd(ADC_TypeDef* ADCx, u32 NewState)
{
  if (NewState != DISABLE)
  {
    /* Enable the selected ADC regular discontinuous mode */
    ADCx->CR1.Data |= CR1_DISCEN_Set;
  }
  else
  {
    /* Disable the selected ADC regular discontinuous mode */
    ADCx->CR1.Data &= CR1_DISCEN_Reset;
  }
}

/*******************************************************************************
* Function Name  : ADC_ExternalTrigConvCmd
* Description    : Enables or disables the ADCx conversion through external trigger.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC external trigger
*                    start of conversion.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_ExternalTrigConvCmd(ADC_TypeDef* ADCx, u32 NewState)
{
  /* Check the parameters */
  //assert_param(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
  {
    /* Enable the selected ADC conversion on external event */
    ADCx->CR2.Data |= CR2_EXTTRIG_Set;
  }
  else
  {
    /* Disable the selected ADC conversion on external event */
    ADCx->CR2.Data &= CR2_EXTTRIG_Reset;
  }
}

/*******************************************************************************
* Function Name  : ADC_GetDualModeConversionValue
* Description    : Returns the last ADCs conversion result data in dual mode.
* Output         : None
* Return         : The Data conversion value.
*******************************************************************************/
u32 ADC_GetDualModeConversionValue(void)
{
  /* Return the dual mode conversion value */
  return ADC1->DR;
}

/*******************************************************************************
* Function Name  : ADC_AutoInjectedConvCmd
* Description    : Enables or disables the selected ADC automatic injected group
*                  conversion after regular one.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC auto injected
*                    conversion
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_AutoInjectedConvCmd(ADC_TypeDef* ADCx, u32 NewState)
{
  /* Check the parameters */
  //assert_param(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
  {
    /* Enable the selected ADC automatic injected group conversion */
    ADCx->CR1.Data |= CR1_JAUTO_Set;
  }
  else
  {
    /* Disable the selected ADC automatic injected group conversion */
    ADCx->CR1.Data &= CR1_JAUTO_Reset;
  }
}

/*******************************************************************************
* Function Name  : ADC_InjectedDiscModeCmd
* Description    : Enables or disables the discontinuous mode for injected group
*                  channel for the specified ADC
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC discontinuous mode
*                    on injected group channel.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_InjectedDiscModeCmd(ADC_TypeDef* ADCx, u32 NewState)
{
  /* Check the parameters */
  //assert_param(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
  {
    /* Enable the selected ADC injected discontinuous mode */
    ADCx->CR1.Data |= CR1_JDISCEN_Set;
  }
  else
  {
    /* Disable the selected ADC injected discontinuous mode */
    ADCx->CR1.Data &= CR1_JDISCEN_Reset;
  }
}

void ADC_ExtTrigInjConvCfg(ADC_TypeDef* ADCx, u32 ExtTrigInjConv)
{
	// Set the external event selection for injected group
  	ADCx->CR2.JEXTSEL = ExtTrigInjConv;
}

/*******************************************************************************
* Function Name  : ADC_ExternalTrigInjectedConvCmd
* Description    : Enables or disables the ADCx injected channels conversion
*                  through external trigger
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC external trigger
*                    start of injected conversion.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_ExternalTrigInjectedConvCmd(ADC_TypeDef* ADCx, u32 NewState)
{
  /* Check the parameters */
  //assert_param(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
  {
    /* Enable the selected ADC external event selection for injected group */
    ADCx->CR2.Data |= CR2_JEXTTRIG_Set;
  }
  else
  {
    /* Disable the selected ADC external event selection for injected group */
    ADCx->CR2.Data &= CR2_JEXTTRIG_Reset;
  }
}

/*******************************************************************************
* Function Name  : ADC_SoftwareStartInjectedConvCmd
* Description    : Enables or disables the selected ADC start of the injected 
*                  channels conversion.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - NewState: new state of the selected ADC software start
*                    injected conversion.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_SoftwareStartInjectedConvCmd(ADC_TypeDef* ADCx, u32 NewState)
{
  /* Check the parameters */
  //assert_param(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
  {
    /* Enable the selected ADC external event selection for injected group */
    /* Starts the selected ADC injected conversion */
    ADCx->CR2.Data |= CR2_JEXTTRIG_JSWSTRT_Set;
  }
  else
  {
    /* Stops the selected ADC injected conversion */
    /* Disable the selected ADC external event selection for injected group */
	ADCx->CR2.Data &= CR2_JEXTTRIG_JSWSTRT_Reset;
  }
}

/*******************************************************************************
* Function Name  : ADC_GetSoftwareStartInjectedConvCmdStatus
* Description    : Gets the selected ADC Software start injected conversion Status.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
* Output         : None
* Return         : The new state of ADC software start injected conversion (SET or RESET).
*******************************************************************************/
u32 ADC_GetSoftwareStartInjectedConvCmdStatus(ADC_TypeDef* ADCx)
{
  u32 bitstatus = RESET;

  /* Check the status of JSWSTRT bit */
  if ((ADCx->CR2.Data & CR2_JSWSTRT_Set) != (u32)RESET)
  {
    /* JSWSTRT bit is set */
    bitstatus = SET;
  }
  else
  {
    /* JSWSTRT bit is reset */
    bitstatus = RESET;
  }
  /* Return the JSWSTRT bit status */
  return  bitstatus;
}

/*******************************************************************************
* Function Name  : ADC_InjChannelCfg
* Description    : Configures for the selected ADC injected channel its corresponding
*                  rank in the sequencer and its sample time.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - ADC_Channel: the ADC channel to configure. 
*                    This parameter can be one of the following values:
*                       - ADC_Channel_0: ADC Channel0 selected
*                       - ADC_Channel_1: ADC Channel1 selected
*                       - ADC_Channel_2: ADC Channel2 selected
*                       - ADC_Channel_3: ADC Channel3 selected
*                       - ADC_Channel_4: ADC Channel4 selected
*                       - ADC_Channel_5: ADC Channel5 selected
*                       - ADC_Channel_6: ADC Channel6 selected
*                       - ADC_Channel_7: ADC Channel7 selected
*                       - ADC_Channel_8: ADC Channel8 selected
*                       - ADC_Channel_9: ADC Channel9 selected
*                       - ADC_Channel_10: ADC Channel10 selected
*                       - ADC_Channel_11: ADC Channel11 selected
*                       - ADC_Channel_12: ADC Channel12 selected
*                       - ADC_Channel_13: ADC Channel13 selected
*                       - ADC_Channel_14: ADC Channel14 selected
*                       - ADC_Channel_15: ADC Channel15 selected
*                       - ADC_Channel_16: ADC Channel16 selected
*                       - ADC_Channel_17: ADC Channel17 selected
*                  - Rank: The rank in the injected group sequencer. This parameter
*                    must be between 1 to 4.
*                  - ADC_SampleTime: The sample time value to be set for the
*                    selected channel. 
*                    This parameter can be one of the following values:
*                       - ADC_SampleTime_1Cycles5: Sample time equal to 1.5 cycles
*                       - ADC_SampleTime_7Cycles5: Sample time equal to 7.5 cycles
*                       - ADC_SampleTime_13Cycles5: Sample time equal to 13.5 cycles
*                       - ADC_SampleTime_28Cycles5: Sample time equal to 28.5 cycles	
*                       - ADC_SampleTime_41Cycles5: Sample time equal to 41.5 cycles	
*                       - ADC_SampleTime_55Cycles5: Sample time equal to 55.5 cycles	
*                       - ADC_SampleTime_71Cycles5: Sample time equal to 71.5 cycles	
*                       - ADC_SampleTime_239Cycles5: Sample time equal to 239.5 cycles	
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_InjChannelCfg(ADC_TypeDef* ADCx, u32 ADC_Channel, u32 Rank, u32 ADC_SampleTime)
{
	switch(ADC_Channel)
	{
		case ADC_Channel_0:  ADCx->SMPR2.SMP0  = ADC_SampleTime; break;
		case ADC_Channel_1:  ADCx->SMPR2.SMP1  = ADC_SampleTime; break;
		case ADC_Channel_2:  ADCx->SMPR2.SMP2  = ADC_SampleTime; break;
		case ADC_Channel_3:  ADCx->SMPR2.SMP3  = ADC_SampleTime; break;
		case ADC_Channel_4:  ADCx->SMPR2.SMP4  = ADC_SampleTime; break;
		case ADC_Channel_5:  ADCx->SMPR2.SMP5  = ADC_SampleTime; break;
		case ADC_Channel_6:  ADCx->SMPR2.SMP6  = ADC_SampleTime; break;
		case ADC_Channel_7:  ADCx->SMPR2.SMP7  = ADC_SampleTime; break;
		case ADC_Channel_8:  ADCx->SMPR2.SMP8  = ADC_SampleTime; break;
		case ADC_Channel_9:  ADCx->SMPR2.SMP9  = ADC_SampleTime; break;
		case ADC_Channel_10: ADCx->SMPR1.SMP10 = ADC_SampleTime; break;
		case ADC_Channel_11: ADCx->SMPR1.SMP11 = ADC_SampleTime; break;
		case ADC_Channel_12: ADCx->SMPR1.SMP12 = ADC_SampleTime; break;
		case ADC_Channel_13: ADCx->SMPR1.SMP13 = ADC_SampleTime; break;
		case ADC_Channel_14: ADCx->SMPR1.SMP14 = ADC_SampleTime; break;
		case ADC_Channel_15: ADCx->SMPR1.SMP15 = ADC_SampleTime; break;
		case ADC_Channel_16: ADCx->SMPR1.SMP16 = ADC_SampleTime; break;
		case ADC_Channel_17: ADCx->SMPR1.SMP17 = ADC_SampleTime; break;
	}

	// Rank configuration
	switch(Rank)
	{
		case 0:	ADCx->JSQR.JSQ1 = ADC_Channel; break;
		case 1: ADCx->JSQR.JSQ2 = ADC_Channel; break;
		case 2: ADCx->JSQR.JSQ2 = ADC_Channel; break;
		case 3: ADCx->JSQR.JSQ2 = ADC_Channel; break;
	}
}

/*******************************************************************************
* Function Name  : ADC_InjSequencerLenCfg
* Description    : Configures the sequencer length for injected channels
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - Length: The sequencer length. 
*                    This parameter must be a number between 1 to 4.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_InjSequencerLenCfg(ADC_TypeDef* ADCx, u32 nCnt)
{
	ADCx->JSQR.JL = (nCnt - 1);
}

/*******************************************************************************
* Function Name  : ADC_SetInjectedOffset
* Description    : Set the injected channels conversion value offset
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - ADC_InjectedChannel: the ADC injected channel to set its
*                    offset. 
*                    This parameter can be one of the following values:
*                       - ADC_InjectedChannel_1: Injected Channel1 selected
*                       - ADC_InjectedChannel_2: Injected Channel2 selected
*                       - ADC_InjectedChannel_3: Injected Channel3 selected
*                       - ADC_InjectedChannel_4: Injected Channel4 selected
*                  - Offset: the offset value for the selected ADC injected channel
*                    This parameter must be a 12bit value.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_SetInjectedOffset(ADC_TypeDef* ADCx, u8 ADC_InjectedChannel, u16 Offset)
{
  // Set the selected injected channel data offset
  *((u32 *)((*(u32*)&ADCx) + ADC_InjectedChannel)) = (u32)Offset;
}

/*******************************************************************************
* Function Name  : ADC_GetInjectedConversionValue
* Description    : Returns the ADC injected channel conversion result
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - ADC_InjectedChannel: the converted ADC injected channel.
*                    This parameter can be one of the following values:
*                       - ADC_InjectedChannel_1: Injected Channel1 selected
*                       - ADC_InjectedChannel_2: Injected Channel2 selected
*                       - ADC_InjectedChannel_3: Injected Channel3 selected
*                       - ADC_InjectedChannel_4: Injected Channel4 selected
* Output         : None
* Return         : The Data conversion value.
*******************************************************************************/
u16 ADC_GetInjectedConversionValue(ADC_TypeDef* ADCx, u8 ADC_InjectedChannel)
{
  //assert_param(IS_ADC_INJECTED_CHANNEL(ADC_InjectedChannel));

  // Returns the selected injected channel conversion data value
  return (u16) (*(u32*) (((*(u32*)&ADCx) + ADC_InjectedChannel + JDR_Offset)));
}

/*******************************************************************************
* Function Name  : ADC_AnalogWatchdogCmd
* Description    : Enables or disables the analog watchdog on single/all regular
*                  or injected channels
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - ADC_AnalogWatchdog: the ADC analog watchdog configuration.
*                    This parameter can be one of the following values:
*                       - ADC_AnalogWatchdog_SingleRegEnable: Analog watchdog on
*                         a single regular channel
*                       - ADC_AnalogWatchdog_SingleInjecEnable: Analog watchdog on
*                         a single injected channel
*                       - ADC_AnalogWatchdog_SingleRegOrInjecEnable: Analog 
*                         watchdog on a single regular or injected channel
*                       - ADC_AnalogWatchdog_AllRegEnable: Analog watchdog on
*                         all regular channel
*                       - ADC_AnalogWatchdog_AllInjecEnable: Analog watchdog on
*                         all injected channel
*                       - ADC_AnalogWatchdog_AllRegAllInjecEnable: Analog watchdog
*                         on all regular and injected channels
*                       - ADC_AnalogWatchdog_None: No channel guarded by the
*                         analog watchdog
* Output         : None
* Return         : None	  
*******************************************************************************/
void ADC_AnalogWatchdogCmd(ADC_TypeDef* ADCx, u32 ADC_AnalogWatchdog)
{
  u32 tmpreg = 0;

  // Check the parameters 

  /* Get the old register value */
  tmpreg = ADCx->CR1.Data;
  /* Clear AWDEN, AWDENJ and AWDSGL bits */
  tmpreg &= CR1_AWDMode_Reset;
  /* Set the analog watchdog enable mode */
  tmpreg |= ADC_AnalogWatchdog;
  /* Store the new register value */
  ADCx->CR1.Data = tmpreg;
}

/*******************************************************************************
* Function Name  : ADC_AnalogWatchdogThresholdsConfig
* Description    : Configures the high and low thresholds of the analog watchdog.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - HighThreshold: the ADC analog watchdog High threshold value.
*                    This parameter must be a 12bit value.
*                  - LowThreshold: the ADC analog watchdog Low threshold value.
*                    This parameter must be a 12bit value.
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_AnalogWatchdogThresholdsConfig(ADC_TypeDef* ADCx, u16 HighThreshold,
                                        u16 LowThreshold)
{
  /* Check the parameters */
  //assert_param(IS_ADC_THRESHOLD(HighThreshold));
  //assert_param(IS_ADC_THRESHOLD(LowThreshold));

  /* Set the ADCx high threshold */
  ADCx->HTR = HighThreshold;
  /* Set the ADCx low threshold */
  ADCx->LTR = LowThreshold;
}

/*******************************************************************************
* Function Name  : ADC_AnalogWatchdogSingleChannelConfig
* Description    : Configures the analog watchdog guarded single channel
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - ADC_Channel: the ADC channel to configure for the analog
*                    watchdog. 
*                    This parameter can be one of the following values:
*                       - ADC_Channel_0: ADC Channel0 selected
*                       - ADC_Channel_1: ADC Channel1 selected
*                       - ADC_Channel_2: ADC Channel2 selected
*                       - ADC_Channel_3: ADC Channel3 selected
*                       - ADC_Channel_4: ADC Channel4 selected
*                       - ADC_Channel_5: ADC Channel5 selected
*                       - ADC_Channel_6: ADC Channel6 selected
*                       - ADC_Channel_7: ADC Channel7 selected
*                       - ADC_Channel_8: ADC Channel8 selected
*                       - ADC_Channel_9: ADC Channel9 selected
*                       - ADC_Channel_10: ADC Channel10 selected
*                       - ADC_Channel_11: ADC Channel11 selected
*                       - ADC_Channel_12: ADC Channel12 selected
*                       - ADC_Channel_13: ADC Channel13 selected
*                       - ADC_Channel_14: ADC Channel14 selected
*                       - ADC_Channel_15: ADC Channel15 selected
*                       - ADC_Channel_16: ADC Channel16 selected
*                       - ADC_Channel_17: ADC Channel17 selected
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_AnalogWatchdogSingleChannelConfig(ADC_TypeDef* ADCx, u8 ADC_Channel)
{
  u32 tmpreg = 0;

  /* Check the parameters */
  /* Get the old register value */
  tmpreg = ADCx->CR1.Data;
  /* Clear the Analog watchdog channel select bits */
  tmpreg &= CR1_AWDCH_Reset;
  /* Set the Analog watchdog channel */
  tmpreg |= ADC_Channel;
  /* Store the new register value */
  ADCx->CR1.Data = tmpreg;
}

/*******************************************************************************
* Function Name  : ADC_GetFlagStatus
* Description    : Checks whether the specified ADC flag is set or not.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - ADC_FLAG: specifies the flag to check. 
*                    This parameter can be one of the following values:
*                       - ADC_FLAG_AWD: Analog watchdog flag
*                       - ADC_FLAG_EOC: End of conversion flag
*                       - ADC_FLAG_JEOC: End of injected group conversion flag
*                       - ADC_FLAG_JSTRT: Start of injected group conversion flag
*                       - ADC_FLAG_STRT: Start of regular group conversion flag
* Output         : None
* Return         : The new state of ADC_FLAG (SET or RESET).
*******************************************************************************/
u32 ADC_GetFlagStatus(ADC_TypeDef* ADCx, u8 ADC_FLAG)
{
  u32 bitstatus = RESET;

  /* Check the parameters */
  //assert_param(IS_ADC_GET_FLAG(ADC_FLAG));

  /* Check the status of the specified ADC flag */
  if ((ADCx->SR.Data & ADC_FLAG) != (u8)RESET)
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

/*******************************************************************************
* Function Name  : ADC_ClearFlag
* Description    : Clears the ADCx's pending flags.
* Input          : - ADCx: where x can be 1 or 2 to select the ADC peripheral.
*                  - ADC_FLAG: specifies the flag to clear. 
*                    This parameter can be any combination of the following values:
*                       - ADC_FLAG_AWD: Analog watchdog flag
*                       - ADC_FLAG_EOC: End of conversion flag
*                       - ADC_FLAG_JEOC: End of injected group conversion flag
*                       - ADC_FLAG_JSTRT: Start of injected group conversion flag
*                       - ADC_FLAG_STRT: Start of regular group conversion flag
* Output         : None
* Return         : None
*******************************************************************************/
void ADC_ClearFlag(ADC_TypeDef* ADCx, u8 ADC_FLAG)
{
  /* Check the parameters */
  //assert_param(IS_ADC_CLEAR_FLAG(ADC_FLAG));

  /* Clear the selected ADC flags */
  ADCx->SR.Data &= ~(u32)ADC_FLAG;
}


/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
