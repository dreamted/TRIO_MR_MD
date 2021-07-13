
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
#include "../lib/include/lib_extdevext.h"
////////////////////////////////////////////////////////////////////////////////
#ifdef EXLIB_C
	#define _USR_EXT_EXL
#else
	#define _USR_EXT_EXL	extern
#endif


#ifndef isprint
#define in_range(c, lo, up)  ((u8)c >= lo && (u8)c <= up)
#define isprint(c)           in_range(c, 0x20, 0x7f)
#define isdigit(c)           in_range(c, '0', '9')
#define isxdigit(c)          (isdigit(c) || in_range(c, 'a', 'f') || in_range(c, 'A', 'F'))
#define islower(c)           in_range(c, 'a', 'z')
#define isspace(c)           (c == ' ' || c == '\f' || c == '\n' || c == '\r' || c == '\t' || c == '\v')
#endif   


////////////////////////////////////////////////////
// Expio Address
enum{
	CS0SEL = 0,
	CS1SEL,
	CS2SEL,
	CS3SEL,
	CS4SEL,
	CS5SEL,
	CS6SEL,
	CS7SEL,
	CS8SEL,
	CS9SEL,
	CS10SEL,
	CS11SEL,
	CS12SEL,
	CS13SEL,
	CS14SEL,
	CS15SEL,
	CS16SEL,
	CS17SEL,
	CS18SEL,
	CS19SEL,
	EXPIOPointMAX
};

#ifndef __FSMC_SRAM_H
	#define	CS0			((GPIOC_OFFSET)*16 + 6)			// t-low
	#define	CS1			((GPIOE_OFFSET)*16 + 10)		// t-period

	#define	CS2			((GPIOB_OFFSET)*16 + 9)
	#define	CS3			((GPIOB_OFFSET)*16 + 12)
	#define	CS4			((GPIOB_OFFSET)*16 + 13)
	#define	CS5			((GPIOB_OFFSET)*16 + 14)
	#define	CS6			((GPIOB_OFFSET)*16 + 15)
	#define	CS7			((GPIOC_OFFSET)*16 + 14)
	#define	CS8			((GPIOC_OFFSET)*16 + 15)
	#define	CS9			((GPIOA_OFFSET)*16 + 11)
	#define	CS10		((GPIOA_OFFSET)*16 + 12)
#endif
////////////////////////////////////////////////////////////////////////////////
// Do not modify, because it is connected "fsms_sram"
/////////////////////////////////////////////////////
#ifdef __FSMC_SRAM_H
	#define	CS0			nCS0
	#define	CS1			nCS1
	#define	CS2			nCS2
	#define	CS3			nCS3
	#define	CS4			nCS4
	#define	CS5			nCS5
	#define	CS6			nCS6
	#define	CS7			nCS7
	#define	CS8			nCS8
	#define	CS9			nCS9
	#define	CS10		nCS10
	#define CS11		nCS11
	#define CS12		nCS12
	#define CS13		nCS13
	#define CS14		nCS14
	#define CS15		nCS15
#endif
////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
#ifdef EXLIB_C
#ifndef __FSMC_SRAM_H
const unsigned long ExpioCS[EXPIOPointMAX] = {
			CS0,
			CS1,
			CS2,
			CS3,
			CS4,
			CS5,
			CS6,
			CS7,
			CS8,
			CS9,
			CS10
		};
#else// __FSMC_SRAM_H
	// Do not modify, because it is connected "fsms_sram"
	const unsigned long ExpioCS[EXPIOPointMAX] = {0,};
#endif

unsigned short int EXPIOrawData[EXPIOPointMAX];


////////////////////
#else


////////////////////
#endif
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////


void ExpioBitSet(unsigned short int Bitaddr);
void ExpioBitRst(unsigned short int Bitaddr);


unsigned short int ExpioBitRead (unsigned short int Bitaddr);
INT16U ExpioReadData(INT8U SEL);
void ExpioWriteData(INT8U SEL, INT16U Data);
void ExpioModeChanege(INT8U tmode);
INT8U atoh(INT8U value);
INT8U SearchWord(INT8U IsDec,INT8U nLen,INT16U SearchVal, INT16U *Buff);
INT16U ByteToWord(INT8U HighByte, INT8U LowByte);

////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

