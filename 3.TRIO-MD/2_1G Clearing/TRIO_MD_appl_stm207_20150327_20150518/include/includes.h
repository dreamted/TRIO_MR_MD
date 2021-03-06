/*
*********************************************************************************************************
*                                              EXAMPLE CODE
*
*                          (c) Copyright 2003-2007; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*               Knowledge of the source code may NOT be used to develop a similar product.
*               Please help us continue to provide the Embedded community with the finest
*               software available.  Your honesty is greatly appreciated.
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                           MASTER INCLUDES
*
*                                     ST Microelectronics STM32
*                                              with the
*                                   IAR STM32-SK Evaluation Board
*
* Filename      : includes.h
* Version       : V1.00
* Programmer(s) : Brian Nagel
*********************************************************************************************************
*/

#ifndef  __INCLUDES_H__
#define  __INCLUDES_H__

#include    <stdio.h>
#include    <string.h>
#include    <stdlib.h>
#include    <stdarg.h>

#include    <lib_def.h>
#include    <lib_mem.h>
#include    <lib_str.h>


//#include    <ctype.h>
#include 	<math.h>///20110220


#include    "stm32f2xx_1212.h"

//#include    "stm32f2xx_spi.h"


#if (uC_LCD_MODULE > 0)
#include    <lcd.h>
#endif

#if (uC_PROBE_OS_PLUGIN > 0)
#include    <os_probe.h>
#endif

#if (uC_PROBE_COM_MODULE > 0)
#include    <probe_com.h>

#if (PROBE_COM_METHOD_RS232 > 0)
#include    <probe_rs232.h>
#endif
#endif




#endif
