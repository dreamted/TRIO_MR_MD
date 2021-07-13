/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_systick.c
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file provides all the SysTick firmware functions.
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
/* ---------------------- SysTick registers bit mask -------------------- */
/* CTRL TICKINT Mask */
#define CTRL_TICKINT_Set      ((u32)0x00000002)
#define CTRL_TICKINT_Reset    ((u32)0xFFFFFFFD)

/* SysTick Flag Mask */
#define FLAG_Mask             ((u8)0x1F)

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : SysTick_CLKSourceConfig
* Description    : Configures the SysTick clock source.
* Input          : - SysTick_CLKSource: specifies the SysTick clock source.
*                    This parameter can be one of the following values:
*                       - SysTick_CLKSource_HCLK_Div8: AHB clock divided by 8
*                         selected as SysTick clock source.
*                       - SysTick_CLKSource_HCLK: AHB clock selected as
*                         SysTick clock source.
* Output         : None
* Return         : None
*******************************************************************************/
void SysTick_CLKSourceConfig(u32 SysTick_CLKSource)
{
  /* Check the parameters */
  assert(IS_SYSTICK_CLK_SOURCE(SysTick_CLKSource));

  if (SysTick_CLKSource == SysTick_CLKSource_HCLK)
  {
    SysTick->CTRL.Data |= SysTick_CLKSource_HCLK;
  }
  else
  {
    SysTick->CTRL.Data &= SysTick_CLKSource_HCLK_Div8;
  }
}

/*******************************************************************************
* Function Name  : SysTick_SetReload
* Description    : Sets SysTick Reload value.
* Input          : - Reload: SysTick Reload new value.
*                    This parameter must be a number between 1 and 0xFFFFFF.
* Output         : None
* Return         : None
*******************************************************************************/
void SysTick_SetReload(u32 _ms)
{
  /* Check the parameters */
  //assert(IS_SYSTICK_RELOAD(Reload));
  //GRA0 = (CntmS * SYSTEM_CLOCK)/(16L * 1000L); // Ref: 1ms
  SysTick->LOAD.Data = (_ms * SYSCLK)/(8L * 1000L);
}

/*******************************************************************************
* Function Name  : SysTick_ITConfig
* Description    : Enables or disables the SysTick Interrupt.
* Input          : - NewState: new state of the SysTick Interrupt.
*                    This parameter can be: ENABLE or DISABLE.
* Output         : None
* Return         : None
*******************************************************************************/
void SysTick_ITConfig(INT32U NewState)
{
  /* Check the parameters */
  assert(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
  {
    SysTick->CTRL.Data |= CTRL_TICKINT_Set;		//by hong : counting down 0 pends the SysTick handler.
  }
  else
  {
    SysTick->CTRL.Data &= CTRL_TICKINT_Reset;	//by hong : counting down 0 does not pend the SysTick handler.
  }
}

/*******************************************************************************
* Function Name  : SysTick_GetCounter
* Description    : Gets SysTick counter value.
* Input          : None
* Output         : None
* Return         : SysTick current value
*******************************************************************************/
u32 SysTick_GetCounter(void)
{
  return(SysTick->VAL.Data);
}

/*******************************************************************************
* Function Name  : SysTick_GetFlagStatus
* Description    : Checks whether the specified SysTick flag is set or not.
* Input          : - SysTick_FLAG: specifies the flag to check.
*                    This parameter can be one of the following values:
*                       - SysTick_FLAG_COUNT
*                       - SysTick_FLAG_SKEW
*                       - SysTick_FLAG_NOREF
* Output         : None
* Return         : None
*******************************************************************************/
INT32U SysTick_GetFlagStatus(u8 SysTick_FLAG)
{
  u32 tmp = 0;
  u32 statusreg = 0;
  INT32U bitstatus = RESET;

  /* Check the parameters */
  assert(IS_SYSTICK_FLAG(SysTick_FLAG));

  /* Get the SysTick register index */
  tmp = SysTick_FLAG >> 5;

  if (tmp == 1) /* The flag to check is in CTRL register */
  {
    statusreg = SysTick->CTRL.Data;
  }
  else          /* The flag to check is in CALIB register */
  {
    statusreg = SysTick->CALIB.Data;
  }

  /* Get the flag position */
  tmp = SysTick_FLAG & FLAG_Mask;

  if ((statusreg & ((u32)1 << tmp)) != (u32)RESET)
  {
    bitstatus = SET;
  }
  else
  {
    bitstatus = RESET;
  }
  return bitstatus;
}

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
