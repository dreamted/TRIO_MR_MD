
/*********************************************
* File Name          : stm32f10x_conf.h
* Author             :
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
#define OS_INCLUDED

// 1. STM103 or STM101 SELECTION
// 둘중 하나를 선택한다.(2010. Reserved)
//#define STM32103_DEF
//#define STM32101_DEF

// 2. External Clock SELECTION
#define HSE_USED		// 외부클럭 사용시 ENABLE 시킨다..

// 3. CPU SELECTION(64pin or 100pin)
//#define STM32FRxT6_USED
#define STM32FVxT6_USED

// 4. SYTEM CLOCK SELECTIO
#define HSE_Value    					 8000000L	// 8MHz
#define SYSCLK							(36000000L)	// 36MHz


#ifndef EXT
	#define EXT extern
#endif // EXT

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// STM32 Lib Related Includes
#ifdef OS_INCLUDED
	#include "ucos_ii.h"
	#include "cpu.h"
#endif
#include "stm32f10x_type.h"
#include "stm32f10x_map_v0902.h"
#include "cortexm3_macro.h"

#include "stm32f10x_adc_0902.h"

#include "stm32f10x_bkp.h"
#include "stm32f10x_can.h"
#include "stm32f10x_dma.h"
#include "stm32f10x_exti_v0903.h"
#include "stm32f10x_flash.h"
#include "stm32f10x_gpio_v0903.h"
#include "stm32f10x_i2c.h"
#include "stm32f10x_iwdg.h"
#include "stm32f10x_nvic_0902.h"
#include "stm32f10x_pwr.h"
#include "stm32f10x_rcc_v0901.h"
#include "stm32f10x_rtc.h"
#include "stm32f10x_spi.h"
#include "stm32f10x_systick.h"
#include "stm32f10x_tim.h"
#include "stm32f10x_tim1_v0901.h"
#include "stm32f10x_usart.h"
#include "stm32f10x_wwdg.h"
#include "stm32f10x_fsmc.h"
#include "stm32f10x_dac.h"

// Exported macro
#undef assert
#ifdef  DEBUG
/*******************************************************************************
* Macro Name     : assert
* Description    : The assert macro is used for function's parameters check.
*                  It is used only if the library is compiled in DEBUG mode.
* Input          : - expr: If expr is false, it calls assert_failed function
*                    which reports the name of the source file and the source
*                    line number of the call that failed.
*                    If expr is true, it returns no value.
* Return         : None
*******************************************************************************/
	#define assert(expr) ((expr) ? (void)0 : assert_failed((u8 *)__FILE__, __LINE__))
	// Exported functions ------------------------------------------------------
	void assert_failed(u8* file, u32 line);
#else
	#define assert(expr) ((void)0)
#endif /* DEBUG */

////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

