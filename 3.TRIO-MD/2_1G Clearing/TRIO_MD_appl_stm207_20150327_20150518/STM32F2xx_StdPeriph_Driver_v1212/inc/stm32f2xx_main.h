
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : main.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/28/2008
* Description        : This file provides all the serial prompt firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
/////////////////////////
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F2xx_MAIN_H
#define __STM32F2xx_MAIN_H

#ifndef __STM32F10x_EXT_MAIN
#define __STM32F10x_EXT_MAIN extern
#endif	/* __STM32F10x_EXT_MAIN */

int main(void);
///////////////////////////////////////////////////
// USER DEFINE TIMER

// END Of User TIMER
//////////////////////////////////////////////////

#if defined(OS_INCLUDED)
	__STM32F10x_EXT_MAIN OS_STK MainTaskStk[OS_TASK_STK_SIZE] @ "iram";
#endif

void  mainTask (void *p_arg);

#endif /* __STM32F2xx_MAIN_H */
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

