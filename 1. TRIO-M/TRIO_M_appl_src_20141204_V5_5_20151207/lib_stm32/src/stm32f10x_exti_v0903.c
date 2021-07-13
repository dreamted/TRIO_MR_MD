/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_exti.c
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file provides all the EXTI firmware functions.
********************************************************************************
* History:
* 05/21/2007: V0.3
* 04/02/2007: V0.2
* 02/05/2007: V0.1
* 09/29/2006: V0.01
********************************************************************************
* THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "stm32f10x_conf.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define EXTI_LineNone    ((u32)0x00000)  /* No interrupt selected */

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : EXTI_DeInit
* Description    : Deinitializes the EXTI peripheral registers to their default 
*                  reset values.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI_DeInit(void)
{
	EXTI->IMR = 0x00000000;
	EXTI->EMR = 0x00000000;
	EXTI->RTSR = 0x00000000; 
	EXTI->FTSR = 0x00000000; 
	EXTI->PR = 0x0007FFFF;
}


/*******************************************************************************
* Function Name  : EXTI_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : pointer to a EXTI_InitTypeDef structure
*                  - tpin    : 
*				   - trigger :
* Output         : None
* Return         : None
*******************************************************************************/

void EXTI_Init(INT8U tport, INT8U tpin, INT8U trigger)
{
	GPIO_EXTILineConfig(tport, tpin);

	EXTI->IMR |= (1 << tpin);	// 1: interrup not masked 0: disable

	// Clear Rising Falling edge configuration
	EXTI->RTSR &= ~(1 << tpin);
	EXTI->FTSR &= ~(1 << tpin);

	if(trigger == EXTI_RisingEdge)
	{
		EXTI->RTSR |= (1 << tpin);
	}
	else if(trigger == EXTI_FallingEdge)
	{
		EXTI->FTSR |= (1 << tpin);
	}
	else 
	{
		EXTI->RTSR |= (1 << tpin);
		EXTI->FTSR |= (1 << tpin);
	}

	// interrutp enable
	EXTI->SWIER |= (1 << tpin);
}


/* Configure EXTI Line9 to generate an interrupt on falling edge */  
/**
EXTI_InitStructure.EXTI_Line = EXTI_Line9;
EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;
EXTI_InitStructure.EXTI_LineCmd = ENABLE;
EXTI_Init(&EXTI_InitStructure);
**/
// Generate software interrupt: simulate a falling edge applied on EXTI line 9
//EXTI_GenerateSWInterrupt(EXTI_Line9);
/********
void EXTI_Init(EXTI_InitTypeDef* EXTI_InitStruct)
{
	// Check the parameters
	// assert(IS_EXTI_MODE(EXTI_InitStruct->EXTI_Mode));
	// assert(IS_EXTI_TRIGGER(EXTI_InitStruct->EXTI_Trigger));
	// assert(IS_EXTI_LINE(EXTI_InitStruct->EXTI_Line));  
	// assert(IS_FUNCTIONAL_STATE(EXTI_InitStruct->EXTI_LineCmd));
	 
	if (EXTI_InitStruct->EXTI_LineCmd != DISABLE)
	{
	    *(u32 *)(EXTI_BASE + (u32)EXTI_InitStruct->EXTI_Mode)|= EXTI_InitStruct->EXTI_Line;

	    // Clear Rising Falling edge configuration
	    EXTI->RTSR &= ~EXTI_InitStruct->EXTI_Line;
	    EXTI->FTSR &= ~EXTI_InitStruct->EXTI_Line;
	    
	    // Select the trigger for the selected external interrupts 
	    if (EXTI_InitStruct->EXTI_Trigger == EXTI_Rising_FallingEdge)
	    {
	      // Rising Falling edge
	      EXTI->RTSR |= EXTI_InitStruct->EXTI_Line;
	      EXTI->FTSR |= EXTI_InitStruct->EXTI_Line;
	    }
	    else
	    {
	    	*(u32 *)(EXTI_BASE + (u32)EXTI_InitStruct->EXTI_Trigger)|= EXTI_InitStruct->EXTI_Line;
	    }
	}
	else
	{
		// Disable the selected external lines
		// *(u32 *)(EXTI_BASE + (u32)EXTI_InitStruct->EXTI_Mode)&= ~EXTI_InitStruct->EXTI_Line;
	}
}
****/
/*******************************************************************************
* Function Name  : EXTI_StructInit
* Description    : Fills each EXTI_InitStruct member with its reset value.
* Input          : - EXTI_InitStruct: pointer to a EXTI_InitTypeDef structure
*                    which will be initialized.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI_StructInit(EXTI_InitTypeDef* EXTI_InitStruct)
{


}

/*******************************************************************************
* Function Name  : EXTI_GenerateSWInterrupt
* Description    : Generates a Software interrupt.
* Input          : - EXTI_Line: specifies the EXTI lines to be enabled or
*                    disabled.
*                    This parameter can be:
*                       - EXTI_Linex: External interrupt line x where x(0..18)
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI_GenerateSWInterrupt(u32 EXTI_Line)
{
	EXTI->SWIER |= EXTI_Line;
}

/*******************************************************************************
* Function Name  : EXTI_GetFlagStatus
* Description    : Checks whether the specified EXTI line flag is set or not.
* Input          : - EXTI_Line: specifies the EXTI lines flag to check.
*                    This parameter can be:
*                       - EXTI_Linex: External interrupt line x where x(0..18)
* Output         : None
* Return         : The new state of EXTI_Line (SET or RESET).
*******************************************************************************/
u32 EXTI_GetFlagStatus(u32 EXTI_Line)
{
	u32 bitstatus = RESET;

	if ((EXTI->PR & EXTI_Line) != (u32)RESET)
	{
		bitstatus = SET;
	}
	else
	{
		bitstatus = RESET;
	}
	return bitstatus;
}

/*******************************************************************************
* Function Name  : EXTI_ClearFlag
* Description    : Clears the EXTI’s line pending flags.
* Input          : - EXTI_Line: specifies the EXTI lines flags to clear.
*                    This parameter can be:
*                       - EXTI_Linex: External interrupt line x where x(0..18)
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI_ClearFlag(u32 EXTI_Line)
{
	EXTI->PR = EXTI_Line;
}

/*******************************************************************************
* Function Name  : EXTI_GetITStatus
* Description    : Checks whether the specified EXTI line is asserted or not.
* Input          : - EXTI_Line: specifies the EXTI lines to check.
*                    This parameter can be:
*                       - EXTI_Linex: External interrupt line x where x(0..18)
* Output         : None
* Return         : The new state of EXTI_Line (SET or RESET).
*******************************************************************************/
u32 EXTI_GetITStatus(u32 EXTI_Line)
{
	ITStatus bitstatus = RESET;
	u32 enablestatus = 0;

	enablestatus =  EXTI->IMR & EXTI_Line;

	if (((EXTI->PR & EXTI_Line) != (u32)RESET) && enablestatus)
	{
		bitstatus = SET;
	}
	else
	{
		bitstatus = RESET;
	}
	return bitstatus;
}

/*******************************************************************************
* Function Name  : EXTI_ClearITPendingBit
* Description    : Clears the EXTI’s line pending bits.
* Input          : - EXTI_Line: specifies the EXTI lines to clear.
*                    This parameter can be:
*                       - EXTI_Linex: External interrupt line x where x(0..18)
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI_ClearITPendingBit(u32 EXTI_Line)
{
	EXTI->PR = EXTI_Line;
}

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
