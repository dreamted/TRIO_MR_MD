/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_type.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the common data types used for the
*                      STM32F10x firmware library.
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
#ifndef __STM32F10x_TYPE_H
#define __STM32F10x_TYPE_H

/*! Includes ------------------------------------------------------------------*/

/*! define ------------------------------------------------------------------*/
#define _pilog  (('P' << 8 | 'I' << 0 | 'L' << 24 | 'O' << 16))
#define _extram (('E' << 0 | 'X' << 8 | 'T' << 16 | 'R' << 24)) 

/*! Exported types ------------------------------------------------------------*/
typedef signed long  s32;
typedef signed short s16;
typedef signed char  s8;

typedef volatile signed long  vs32;
typedef volatile signed short vs16;
typedef volatile signed char  vs8;

typedef unsigned long  u32;
typedef unsigned short u16;
typedef unsigned char  u8;

typedef unsigned long  const uc32;  /* Read Only */
typedef unsigned short const uc16;  /* Read Only */
typedef unsigned char  const uc8;   /* Read Only */

typedef volatile unsigned long  vu32;
typedef volatile unsigned short vu16;
typedef volatile unsigned char  vu8;

typedef volatile unsigned long  const vuc32;  /* Read Only */
typedef volatile unsigned short const vuc16;  /* Read Only */
typedef volatile unsigned char  const vuc8;   /* Read Only */

typedef volatile const signed long vsc32;	/*!< Read Only */
typedef volatile const signed short vsc16;  /*!< Read Only */
typedef volatile const signed char vsc8;	/*!< Read Only */

#ifndef  OS_INCLUDED
typedef unsigned char		BOOLEAN;
typedef unsigned char		INT8U;				/* Unsigned  8 bit quantity */
typedef signed   char		INT8S;				/* Signed    8 bit quantity */
typedef unsigned short		INT16U;				/* Unsigned 16 bit quantity */
typedef signed   short int	INT16S;				/* Signed   16 bit quantity */
typedef unsigned long int	INT32U;				/* Unsigned 32 bit quantity */
typedef signed   long int	INT32S;				/* Signed   32 bit quantity */
typedef float				FP32;				/* Single precision floating point */
typedef double				FP64;				/* Double precision floating point */

typedef unsigned long int	OS_STK;				/* Each stack entry is 32-bit wide */
typedef unsigned long int	OS_CPU_SR;			/* Define size of CPU status register (PSR = 32 bits) */
typedef unsigned char		BOOL;

typedef unsigned long long 	INT64U;
#endif /* OS_CPU_H */

#define IS_FUNCTIONAL_STATE(STATE) ((STATE == DISABLE) || (STATE == ENABLE))

enum {FALSE = 0, TRUE = !FALSE};
typedef enum {ERROR = 0, SUCCESS = !ERROR} ErrorStatus;
typedef enum {DISABLE = 0, ENABLE = !DISABLE} FunctionalState;
typedef enum {RESET = 0, SET = !RESET} FlagStatus, ITStatus;


#pragma pack(1)

typedef struct {
	unsigned char Eth0MacAddr[6];
	unsigned char Eth0IpAddr[4];
	unsigned char Eth0GatewayAddr[4];
	unsigned char Eth0SubnetAddr[4];
	unsigned short int Eth0nPort;

	unsigned char Eth1MacAddr[6];
	unsigned char Eth1IpAddr[4];
	unsigned char Eth1GatewayAddr[4];
	unsigned char Eth1SubnetAddr[4];
	unsigned short int Eth1nPort;
	
} __IPINFOR;

#pragma pack()


#define U8_MAX     ((u8)255)
#define S8_MAX     ((s8)127)
#define S8_MIN     ((s8)-128)
#define U16_MAX    ((u16)65535u)
#define S16_MAX    ((s16)32767)
#define S16_MIN    ((s16)-32768)
#define U32_MAX    ((u32)4294967295uL)
#define S32_MAX    ((s32)2147483647)
#define S32_MIN    ((s32)2147483648uL)


////////////////////////////////////////////////////////////////////////////////
typedef void( *intfunc )( void );
typedef union { intfunc __fun; void * __ptr; } intvec_elem;
typedef struct {
	char infor[5][10];
} selfinfo;

/////////////////////////////////////////////////////////////////
// USER Define
#define	BitSet(a,b)				a = a|(1<<b)
#define	BitRst(a,b)				a = a&(~(1<<b))
#define	BitRead(a,b)			((a >> b) & 1)

#define	SetRegister(a,b)		a = a|(1<<b)
#define	RstRegister(a,b)		a = a&(~(1<<b))
#define	ReadRegister(a,b)		((a >> b) & 1)

////////////////////////////////////////////////////////////////////////////////
// Common utility macros
//
#define hiword(x)		((unsigned short int)((x) >> 16))
#define	loword(x)		((unsigned short int)(x))
#define	hibyte(x)		(((x) >> 8) & 0xff)
#define	lobyte(x)		((x) & 0xff)
#define	hinibble(x)		(((x) >> 4) & 0xf)
#define	lonibble(x)		((x) & 0xf)
#define	dim(x)			(sizeof(x) / sizeof(x[0]))


/******************************************************************************
 * Return the minimum and maximum of two values.  Not recommended for function
 * expressions.
 ******************************************************************************/
#ifndef MIN
#define MIN(a,b) ((a) < (b) ? (a) : (b))
#endif
#ifndef MAX
#define MAX(a,b) ((a) > (b) ? (a) : (b))
#endif
/* XXX These should be the function call equivalents. */
#define max(a,b)	(((a) > (b)) ? (a) : (b))
#define min(a,b)	(((a) < (b)) ? (a) : (b))
////////////////////////////////////////////////////////////////////////////////


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
/* Exported functions ------------------------------------------------------- */
  void assert_failed(u8* file, u32 line);
#else
  #define assert(expr) ((void)0)
#endif /* DEBUG */

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

#endif /* __STM32F10x_TYPE_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
