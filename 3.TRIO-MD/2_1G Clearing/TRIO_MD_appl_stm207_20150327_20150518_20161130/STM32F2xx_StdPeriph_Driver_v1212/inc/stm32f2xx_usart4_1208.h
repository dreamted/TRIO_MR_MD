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
#ifndef __STM32F2xx_USART_4
#define __STM32F2xx_USART_4

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f2xx_1212.h"

#define USART4_C


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

//#define Rx4BuffLen	(256*8)
//#define Tx4BuffLen	(256*8)

#define Rx4BuffLen	1024 *5
#define Tx4BuffLen	1024 *5


/**
  * @}
  */ 



/** @defgroup USART_Exported_variables 
  * @{
  */ 
	extern __SerStrPtr pUSART4;
  
/**
  * @}
  */ 

/* Exported macro ------------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/  
/*  Function used to set the USART configuration to the default reset state ***/ 

void InitUSART4(INT32U nBps, INT32U nLCR);
void USART4_IRQIntHandler(void);
void USART4PutStr(unsigned char *Str, unsigned short int Length, int iEn);
void USART4BuffClear(void);
void USART4TxClear(void);

unsigned char USART4PutToBuffer(unsigned char Data);
unsigned char USART4PutChar(unsigned char Data);
unsigned long int USART4Printf( const char *format, ...);
signed short int USART4RxGetByte(void);
unsigned char USART4CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
signed short int USART4TxCheckByte(void);


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
