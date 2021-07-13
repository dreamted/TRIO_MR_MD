/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_gpio.c
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file provides all the GPIO firmware functions.
********************************************************************************
* History:
*
*******************************************************************************/

// Includes --------------------------------------------------------------------
#include "stm32f10x_conf.h"

/*******************************************************************************
* Function Name  : GPIO_PinLockConfig
* Description    : Locks GPIO Pins configuration registers.
* Input          : - GPIOx: where x can be (A..E) to select the GPIO peripheral.
*                  - GPIO_Pin: specifies the port bit to be written.
*                    This parameter can be any combination of GPIO_Pin_x where 
*                    x can be (0..15).
* Output         : None
* Return         : None
*******************************************************************************/
void GPIO_PinLockConfig(GPIO_TypeDef* GPIOx, u16 GPIO_Pin)
{
  u32 tmp = 0x00010000;
  
  /* Check the parameters */
  assert(IS_GPIO_PIN(GPIO_Pin));
  
  tmp |= GPIO_Pin;
  /* Set LCKK bit */
  GPIOx->LCKR = tmp;
  /* Reset LCKK bit */
  GPIOx->LCKR =  GPIO_Pin;
  /* Set LCKK bit */
  GPIOx->LCKR = tmp;
  /* Read LCKK bit*/
  tmp = GPIOx->LCKR;
  /* Read LCKK bit*/
  tmp = GPIOx->LCKR;
}

/*******************************************************************************
* Function Name  : GPIO_EventOutputConfig
* Description    : Selects the GPIO pin used as Event output.
* Input          : - GPIO_PortSource: selects the GPIO port to be used as source
*                    for Event output.
*                    This parameter can be GPIO_PortSourceGPIOx where x can be
*                    (A..E).
*                  - GPIO_PinSource: specifies the pin for the Event output.
*                    This parameter can be GPIO_PinSourcex where x can be (0..15).
* Output         : None
* Return         : None
*******************************************************************************/
void GPIO_EventOutputConfig(u8 GPIO_PortSource, u8 GPIO_PinSource)
{
    //u32 tmpreg = 0x00;

    // tmpreg = AFIO->EVCR;
    // Clear the PORT[6:4] and PIN[3:0] bits
    //tmpreg &= EVCR_PORTPINCONFIG_MASK;
    //tmpreg |= (u32)GPIO_PortSource << 0x04;
    //tmpreg |= GPIO_PinSource;

    //AFIO->EVCR = tmpreg;
}

/*******************************************************************************
* Function Name  : GPIO_EventOutputCmd
* Description    : Enables or disables the Event Output.
* Input          : - NewState: new state of the Event output.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void GPIO_EventOutputCmd(INT32U NewState)
{
	//*(vu32 *) EVCR_EVOE_BB = (u32)NewState;
}

/*******************************************************************************
* Function Name  : GPIO_PinRemapConfig
* Description    : Changes the mapping of the specified pin.
* Input          : - GPIO_Remap: selects the pin to remap.
*                    This parameter can be one of the following values:
*                       - GPIO_Remap_SPI1
*                       - GPIO_Remap_I2C1
*                       - GPIO_Remap_USART1
*                       - GPIO_Remap_USART2
*                       - GPIO_PartialRemap_USART3
*                       - GPIO_FullRemap_USART3
*                       - GPIO_PartialRemap_TIM1
*                       - GPIO_FullRemap_TIM1
*                       - GPIO_PartialRemap1_TIM2
*                       - GPIO_PartialRemap2_TIM2
*                       - GPIO_FullRemap_TIM2
*                       - GPIO_PartialRemap_TIM3
*                       - GPIO_FullRemap_TIM3
*                       - GPIO_Remap_TIM4
*                       - GPIO_Remap1_CAN
*                       - GPIO_Remap2_CAN
*                       - GPIO_Remap_PD01
*                       - GPIO_Remap_SWJ_NoJTRST
*                       - GPIO_Remap_SWJ_JTAGDisable
*                       - GPIO_Remap_SWJ_Disable
*                  - NewState: new state of the port pin remapping.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
#define EVCR_PORTPINCONFIG_MASK     ((u16)0xFF80)
#define LSB_MASK                    ((u16)0xFFFF)
#define DBGAFR_POSITION_MASK        ((u32)0x000F0000)
#define DBGAFR_SWJCFG_MASK          ((u32)0xF8FFFFFF)
#define DBGAFR_LOCATION_MASK        ((u32)0x00200000)
#define DBGAFR_NUMBITS_MASK         ((u32)0x00100000)

void GPIO_PinRemapConfig(u32 GPIO_Remap, INT32U NewState)
{
/***/ 
	u32 tmp = 0x00, tmp1 = 0x00, tmpreg = 0x00, tmpmask = 0x00;

	tmpreg = AFIO->MAPR.Data;

	tmpmask = (GPIO_Remap & DBGAFR_POSITION_MASK) >> 0x10;
	tmp = GPIO_Remap & LSB_MASK;

	if ((GPIO_Remap & DBGAFR_LOCATION_MASK) == DBGAFR_LOCATION_MASK)
	{
    	tmpreg &= DBGAFR_SWJCFG_MASK;
	}
	else if ((GPIO_Remap & DBGAFR_NUMBITS_MASK) == DBGAFR_NUMBITS_MASK)
	{
    	tmp1 = ((u32)0x03) << tmpmask;
    	tmpreg &= ~tmp1;
  	}
  	else
  	{
  	  	tmpreg &= ~tmp;
  	}

	if (NewState != DISABLE)
  	{
    	if ((GPIO_Remap & DBGAFR_LOCATION_MASK) == DBGAFR_LOCATION_MASK)
		{
      		tmpreg |= (tmp << 0x10);
    	}
    	else
    	{
      		tmpreg |= tmp;
    	}
  	}
  AFIO->MAPR.Data = tmpreg;
  /***/
}

/*******************************************************************************
* Function Name  : GPIO_EXTILineConfig
* Description    : Selects the GPIO pin used as EXTI Line.
* Input          : - GPIO_PortSource: selects the GPIO port to be used as
*                    source for EXTI lines.
*                  - GPIO_PinSource: specifies the EXTI line to be configured.
*                   This parameter can be GPIO_PinSourcex where x can be (0..15).
* Output         : None
* Return         : None
*******************************************************************************/
void GPIO_EXTILineConfig(u32 GPIO_SRC, u8 PORTx)
{
	switch(PORTx)
	{
		case GPIO_PinSrc0:
			AFIO->EXTICR1.EXTI0 = GPIO_SRC;
		break;
		case GPIO_PinSrc1:
			AFIO->EXTICR1.EXTI1 = GPIO_SRC;
		break;
		case GPIO_PinSrc2:
			AFIO->EXTICR1.EXTI2 = GPIO_SRC;
		break;
		case GPIO_PinSrc3:
			AFIO->EXTICR1.EXTI3 = GPIO_SRC;
		break;
		case GPIO_PinSrc4:
			AFIO->EXTICR2.EXTI4 = GPIO_SRC;
		break;
		case GPIO_PinSrc5:
			AFIO->EXTICR2.EXTI5 = GPIO_SRC;
		break;
		case GPIO_PinSrc6:
			AFIO->EXTICR2.EXTI6 = GPIO_SRC;
		break;
		case GPIO_PinSrc7:
			AFIO->EXTICR2.EXTI7 = GPIO_SRC;
		break;
		case GPIO_PinSrc8:
			AFIO->EXTICR3.EXTI8 = GPIO_SRC;
		break;
		case GPIO_PinSrc9:
			AFIO->EXTICR3.EXTI9 = GPIO_SRC;
		break;
		case GPIO_PinSrc10:
			AFIO->EXTICR3.EXTI10 = GPIO_SRC;
		break;
		case GPIO_PinSrc11:
			AFIO->EXTICR3.EXTI11 = GPIO_SRC;
		break;
		case GPIO_PinSrc12:
			AFIO->EXTICR4.EXTI12 = GPIO_SRC;
		break;
		case GPIO_PinSrc13:
			AFIO->EXTICR4.EXTI13 = GPIO_SRC;
		break;
		case GPIO_PinSrc14:
			AFIO->EXTICR4.EXTI14 = GPIO_SRC;
		break;
		case GPIO_PinSrc15:
			AFIO->EXTICR4.EXTI15 = GPIO_SRC;
		break;
	}
/**
	  u32 tmp = 0x00;

	  // Check the parameters
	  assert(IS_GPIO_PORT_SOURCE(GPIO_PortSource));
	  assert(IS_GPIO_PIN_SOURCE(GPIO_PinSource));
	  
	  tmp = ((u32)0x0F) << (0x04 * (GPIO_PinSource & (u8)0x03));

	  AFIO->EXTICR[GPIO_PinSource >> 0x02] &= ~tmp;
	  AFIO->EXTICR[GPIO_PinSource >> 0x02] |= (((u32)GPIO_PortSource) << (0x04 * (GPIO_PinSource & (u8)0x03)));
**/

}

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
