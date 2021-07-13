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

////////////////////////////////////////////////////////////////////////////////
// Includes
///////////////////////////
#include "stm32f10x_conf.h"
#include "extint_v1003.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define EXTI_LineNone    ((u32)0x00000)  // No interrupt selected

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : EXTI0_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI0_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOB;
	INT8U trigger = EXTI_FallingEdge;
	// PORT SEL
	NVIC_Init(EXTI0_IRQChannel, ENABLE);	
	EXTI_Init(tport, GPIO_PinSrc12, trigger);
}


/*******************************************************************************
* Function Name  : EXTI1_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI1_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOB;
	INT8U trigger = EXTI_FallingEdge;
	// PORT SEL
	NVIC_Init(EXTI1_IRQChannel, ENABLE);	
	EXTI_Init(tport, GPIO_PinSrc12, trigger);
}


/*******************************************************************************
* Function Name  : EXTI2_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI2_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOB;
	INT8U trigger = EXTI_FallingEdge;
	// PORT SEL
	NVIC_Init(EXTI2_IRQChannel, ENABLE);	
	EXTI_Init(tport, GPIO_PinSrc12, trigger);
}

/*******************************************************************************
* Function Name  : EXTI3_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI3_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOB;
	INT8U trigger = EXTI_FallingEdge;
	// PORT SEL
	NVIC_Init(EXTI3_IRQChannel, ENABLE);	
	EXTI_Init(tport, GPIO_PinSrc12, trigger);
	
}

/*******************************************************************************
* Function Name  : EXTI4_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI4_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOC;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI4_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc4, trigger);
}

/*******************************************************************************
* Function Name  : EXTI5_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI5_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOC;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc5, trigger);
}

/*******************************************************************************
* Function Name  : EXTI6_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI6_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOC;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc6, trigger);
}

/*******************************************************************************
* Function Name  : EXTI7_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI7_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc7, trigger);
}

/*******************************************************************************
* Function Name  : EXTI8_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI8_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc8, trigger);
}

/*******************************************************************************
* Function Name  : EXTI9_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI9_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc9, trigger);
}

/*******************************************************************************
* Function Name  : EXTI10_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI10_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI15_10_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc10, trigger);
}

/*******************************************************************************
* Function Name  : EXTI11_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI11_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI15_10_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc11, trigger);
}


/*******************************************************************************
* Function Name  : EXTI12_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI12_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_FallingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI15_10_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc12, trigger);
}


/*******************************************************************************
* Function Name  : EXTI13_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI13_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI15_10_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc13, trigger);
}

/*******************************************************************************
* Function Name  : EXTI13_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI14_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI15_10_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc14, trigger);
}

/*******************************************************************************
* Function Name  : EXTI15_Init
* Description    : Initializes the EXTI peripheral according to the specified
*                  parameters in the EXTI_InitStruct.
* Input          : - tport   : CPU PORT(GPIOA/GPIOB)등 선택하여야 한다.
*				   - trigger : rising edge/falling edge 또는 둘다를 선택하여야 한다.
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI15_Init(void)
{
	INT8U tport = GPIO_PortSrcGPIOA;
	INT8U trigger = EXTI_RisingEdge;
	
	// PORT SEL
	NVIC_Init(EXTI15_10_IRQChannel, ENABLE);
	EXTI_Init(tport, GPIO_PinSrc15, trigger);
}

/*******************************************************************************
* Function Name  : EXTI0_IRQHandler
* Description    : This function handles External interrupt Line 0 request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI0_IRQHandler(void)
{
	INT8U tpin = GPIO_PinSrc12;

	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	if(EXTI_GetITStatus((1 << tpin)) != RESET)
	{
		EXTI->PR = (1 << tpin);
		// Action Function Insert
	}
	OSIntExit();	

}


/*******************************************************************************
* Function Name  : EXTI1_IRQHandler
* Description    : This function handles External interrupt Line 1 request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI1_IRQHandler(void)
{
	INT8U tpin = GPIO_PinSrc12;

	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	if(EXTI_GetITStatus((1 << tpin)) != RESET)
	{
		EXTI->PR = (1 << tpin);
		// Action Function Insert
	}
	OSIntExit();	
}


/*******************************************************************************
* Function Name  : EXTI2_IRQHandler
* Description    : This function handles External interrupt Line 2 request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

void EXTI2_IRQHandler(void)
{
	INT8U tpin = GPIO_PinSrc12;

	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	if(EXTI_GetITStatus((1 << tpin)) != RESET)
	{
		EXTI->PR = (1 << tpin);
		// Action Function Insert
	}
	OSIntExit();	
}
//F_RESET_IN

/*******************************************************************************
* Function Name  : EXTI3_IRQHandler
* Description    : This function handles External interrupt Line 3 request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/


void EXTI3_IRQHandler(void)
{
	INT8U tpin = GPIO_PinSrc12;

	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	if(EXTI_GetITStatus((1 << tpin)) != RESET)
	{
		EXTI->PR = (1 << tpin);
		// Action Function Insert
	}
	OSIntExit();	
}



/*******************************************************************************
* Function Name  : EXTI4_IRQHandler
* Description    : This function handles External interrupt Line 4 request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI4_IRQHandler(void)
{
	INT8U tpin = GPIO_PinSrc12;

	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	if(EXTI_GetITStatus((1 << tpin)) != RESET)
	{
		EXTI->PR = (1 << tpin);
		// Action Function Insert
	}
	OSIntExit();	
}


/*******************************************************************************
* Function Name  : EXTI9_5_IRQHandler
* Description    : This function handles External lines 9 to 5 interrupt request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
#define EXTI5_IN		GPIOA->IDR.Bit.IDR7

void EXTI9_5_IRQHandler(void)
{
	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	if(EXTI_GetITStatus((1 << GPIO_PinSrc5)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc5);
		// Action Function Insert
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc6)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc6);
		// Action Function Insert
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc7)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc7);
		// Action Function Insert
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc8)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc8);
		// Action Function Insert
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc9)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc9);
		// Action Function Insert
	}


	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
}

/*******************************************************************************
* Function Name  : EXTI15_10_IRQHandler
* Description    : This function handles External lines 15 to 10 interrupt request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void EXTI15_10_IRQHandler(void)
{
	OS_CPU_SR  cpu_sr;


	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	OS_EXIT_CRITICAL();

	if(EXTI_GetITStatus((1 << GPIO_PinSrc10)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc10);
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc11)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc11);
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc12)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc12);
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc13)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc13);
	}
	else if(EXTI_GetITStatus((1 << GPIO_PinSrc14)) != RESET)
	{
		EXTI->PR = (1 << GPIO_PinSrc14);
	}

	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
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



/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/

