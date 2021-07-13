/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_type.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the common data types used for the
*                      STM32F10x firmware library.
********************************************************************************/
// Define to prevent recursive inclusion ---------------------------------------
#ifndef __STM32F10x_TYPE_H
#define __STM32F10x_TYPE_H

// Includes --------------------------------------------------------------------
#ifndef OS_INCLUDED



#endif
// Exported types --------------------------------------------------------------
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

typedef enum {FALSE = 0, TRUE = !FALSE} bool;

typedef enum {RESET = 0, SET = !RESET} FlagStatus, ITStatus;

enum  {
	DISABLE = 0,
	ENABLE = !DISABLE
};

enum {
	ERROR = 0,
	SUCCESS = !ERROR
};

#define U8_MAX     ((u8)255)
#define S8_MAX     ((s8)127)
#define S8_MIN     ((s8)-128)
#define U16_MAX    ((u16)65535u)
#define S16_MAX    ((s16)32767)
#define S16_MIN    ((s16)-32768)
#define U32_MAX    ((u32)4294967295uL)
#define S32_MAX    ((s32)2147483647)
#define S32_MIN    ((s32)2147483648uL)


#define	BitSet(a,b)				a = a|(1<<b)
#define	BitRst(a,b)				a = a&(~(1<<b))
#define	BitRead(a,b)			((a >> b) & 1)

typedef  void  (*intfunc)(void);

typedef  union {
    intfunc  __fun;
    void    *__ptr;
} INTVECT_ELEM;

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


/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

#endif /* __STM32F10x_TYPE_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
