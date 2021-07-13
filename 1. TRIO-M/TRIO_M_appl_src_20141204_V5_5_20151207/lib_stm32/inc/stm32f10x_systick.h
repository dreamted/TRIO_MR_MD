/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_systick.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the functions prototypes for the
*                      SysTick firmware library.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F10x_SYSTICK_H
#define __STM32F10x_SYSTICK_H

//------------------------ SystemTick ------------------------------------------

typedef struct
{	
	union {
		vu32 Data;
		struct	{
			vu32 ENABLE		:1;		//1 : counter operates in a multi-shot way 0 : counter disable
			vu32 TICKINT	:1;		//counting down to 0 pends the SysTick handler
			vu32 CLKSOURCE	:1;		//0 : external reference clock, 1 : core clock
			vu32 REVERVED	:13;	
			vu32 COUNTFLAG	:1;		//Returns 1 if timer counted to 0 since last time this was read
		} Bit;
	} CTRL;		//rw, SysTick Control and Status Register

	union {
		vu32 Data;
		struct	{
			vu32 RELOAD		:24;	//Value to load into the SysTick Current Value Register when the counter reaches 0
		} Bit;
	} LOAD;		//rw, SysTick Reload Value Register

	union {
		vu32 Data;
		struct	{
			vu32 CURRENT	:24;	//current value at the time the register is accessed
		} Bit;
			
	} VAL;			//rw,SysTick Current Value Register

	union {
		vu32 Data;
		struct	{
			vu32 TENMS		:24;	//The Reload value to use for 10ms timing
			vu32 RESERVED	:6;		
			vu32 SKEW		:1;		//1 : 
		} Bit;
	} CALIB;		//r, SysTick Calibration Value Register
} SysTick_TypeDef;

// Define to prevent recursive inclusion ---------------------------------------
#define SysTick 			((SysTick_TypeDef *) SysTick_BASE)

/* SysTick clock source */
#define SysTick_CLKSource_HCLK_Div8    ((u32)0xFFFFFFFB)
#define SysTick_CLKSource_HCLK         ((u32)0x00000004)

#define IS_SYSTICK_CLK_SOURCE(SOURCE) ((SOURCE == SysTick_CLKSource_HCLK) || \
                                       (SOURCE == SysTick_CLKSource_HCLK_Div8))

/* SysTick counter state */
#define SysTick_Counter_Disable        ((u32)0xFFFFFFFE)
#define SysTick_Counter_Enable         ((u32)0x00000001)
#define SysTick_Counter_Clear          ((u32)0x00000000)

#define IS_SYSTICK_COUNTER(COUNTER) ((COUNTER == SysTick_Counter_Disable) || \
                                     (COUNTER == SysTick_Counter_Enable)  || \
                                     (COUNTER == SysTick_Counter_Clear))

/* SysTick Flag */
#define SysTick_FLAG_COUNT             ((u8)0x30)
#define SysTick_FLAG_SKEW              ((u8)0x5E)
#define SysTick_FLAG_NOREF             ((u8)0x5F)

#define IS_SYSTICK_FLAG(FLAG) ((FLAG == SysTick_FLAG_COUNT) || \
                               (FLAG == SysTick_FLAG_SKEW)  || \
                               (FLAG == SysTick_FLAG_NOREF))

#define IS_SYSTICK_RELOAD(RELOAD) ((RELOAD > 0) && (RELOAD <= 0xFFFFFF))

//SysTick Clock Source
#define __EXTSRC		0
#define __CORESRC		1

//SysTick TICKINT
#define __PENDINT		1
#define __NOPENDINT		0

/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void SysTick_CLKSourceConfig(u32 SysTick_CLKSource);
void SysTick_SetReload(u32 _ms);
void SysTick_ITConfig(INT32U NewState);
u32 SysTick_GetCounter(void);
INT32U SysTick_GetFlagStatus(u8 SysTick_FLAG);

#endif /* __STM32F10x_SYSTICK_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
