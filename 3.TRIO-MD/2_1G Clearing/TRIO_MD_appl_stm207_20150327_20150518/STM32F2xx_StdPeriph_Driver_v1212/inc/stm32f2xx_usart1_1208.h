/**
  ******************************************************************************
  * @file    stm32f2xx_usart.h
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    18-April-2011
  * @brief   This file contains all the functions prototypes for the USART 
  *          firmware library.
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************  
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F2xx_USART_1
#define __STM32F2xx_USART_1

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f2xx_1212.h"

#define USART1_C


/** @addtogroup STM32F2xx_StdPeriph_Driver
  * @{
  */
/** @addtogroup USART
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/ 

/** 
  * @brief  USART Init Structure definition  
  */ 

/** 
  * @brief  USART Clock Init Structure definition  
  */ 
  

/* Exported constants --------------------------------------------------------*/

/** @defgroup USART_Exported_Constants
  * @{
  */ 
#if 0  
#define Rx1BuffLen	(256*6)
#define Tx1BuffLen	(256*6)
#endif
#if 0
#define Rx1BuffLen	(256*8)
#define Tx1BuffLen	(256*8)
#endif
 
#define Rx1BuffLen	(256*10)
#define Tx1BuffLen	(256*10)

/**
  * @}
  */ 



/** @defgroup USART_Exported_variables 
  * @{
  */ 
	extern __SerStrPtr pUSART1;
  
/**
  * @}
  */ 

/* Exported macro ------------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/  
/*  Function used to set the USART configuration to the default reset state ***/ 

void InitUSART1(INT32U nBps, INT32U nLCR);
void USART1_IRQIntHandler(void);
void USART1PutStr(unsigned char *Str, unsigned short int Length, int iEn);
void USART1BuffClear(void);
void USART1TxClear(void);

unsigned char USART1PutToBuffer(unsigned char Data);
unsigned char USART1PutChar(unsigned char Data);
unsigned long int USART1Printf( const char *format, ...);
signed short int USART1RxGetByte(void);
unsigned char USART1CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
signed short int USART1TxCheckByte(void);


#ifdef __cplusplus
}
#endif

#endif /* __STM32F2xx_USART_H */

/**
  * @}
  */ 

/**
  * @}
  */ 

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
