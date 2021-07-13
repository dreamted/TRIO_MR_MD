
/*********************************************
* File Name          : exlib.c
* Author             :
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define EXLIB_C

#include "../include/main.h"


void ExpioModeChanege(INT8U tmode)
{
#ifdef STM32FRxT6_USED
	GPIOC->CNF.B6 = tmode;
	GPIOC->CNF.B7 = tmode;
	GPIOC->CNF.B8 = tmode;
	GPIOC->CNF.B9 = tmode;
	GPIOC->CNF.B10 = tmode;
	GPIOC->CNF.B11 = tmode;
	GPIOC->CNF.B12 = tmode;
	GPIOD->CNF.B2 = tmode;
#else
	GPIOD->CNF.B14 = tmode;
	GPIOD->CNF.B15 = tmode;
	GPIOD->CNF.B0 = tmode;
	GPIOD->CNF.B1 = tmode;
	GPIOE->CNF.B7 = tmode;
	GPIOE->CNF.B8 = tmode;
	GPIOE->CNF.B9 = tmode;
	GPIOE->CNF.B10 = tmode;
#endif
}


void ExpioWriteData(INT8U SEL, INT16U Data)
{
	INT8U err;
	
	OSSemPend(ExpioSem, 0, &err);
	EXPIOrawData[SEL] = Data;

#ifdef __FSMC_SRAM_H
		*(vu8 *)(EXPIOptr + SEL*EXPIOsize) = Data;
#else
	{
	
		INT32U Addr = ExpioCS[SEL]/16;
		INT32U BitAddr = ExpioCS[SEL]%16;

		ExpioModeChanege(__PC6_OU_PP);

#ifdef STM32FRxT6_USED
		GPIOC->ODR.B6  = (Data >> 0) & 0x01;
		GPIOC->ODR.B7  = (Data >> 1) & 0x01;
		GPIOC->ODR.B8  = (Data >> 2) & 0x01;
		GPIOC->ODR.B9  = (Data >> 3) & 0x01;
		GPIOC->ODR.B10 = (Data >> 4) & 0x01;
		GPIOC->ODR.B11 = (Data >> 5) & 0x01;
		GPIOC->ODR.B12 = (Data >> 6) & 0x01;
		GPIOD->ODR.B2  = (Data >> 7) & 0x01;
#else
		GPIOD->ODR.B14	= (Data >> 0) & 0x01;
		GPIOD->ODR.B15	= (Data >> 1) & 0x01;
		GPIOD->ODR.B0	= (Data >> 2) & 0x01;
		GPIOD->ODR.B1	= (Data >> 3) & 0x01;
		GPIOE->ODR.B7	= (Data >> 4) & 0x01;
		GPIOE->ODR.B8	= (Data >> 5) & 0x01;
		GPIOE->ODR.B9	= (Data >> 6) & 0x01;
		GPIOE->ODR.B10	= (Data >> 7) & 0x01;
#endif

		// low
		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) &=	~(1 << BitAddr);
		// high
		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) |=	 (1 << BitAddr);

		ExpioModeChanege(__PC6_IN_FL);
	}
#endif
	
	OSSemPost(ExpioSem);
}


INT16U ExpioReadData(INT8U SEL)
{
	INT16U ret = 0;
	INT8U err;
	
	OSSemPend(ExpioSem, 0, &err);

#ifdef __FSMC_SRAM_H
		ret = EXPIOrawData[SEL] = *(vu8 *)(EXPIOptr + SEL*EXPIOsize);
#else
	{
		INT32U Addr = ExpioCS[SEL]/16;
		INT32U BitAddr = ExpioCS[SEL]%16;

		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) &=	~(1 << BitAddr);
		ExpioModeChanege(__PC6_IN_FL);

		// low
#ifdef STM32FRxT6_USED

		ret = (ret << 1) | (GPIOD->IDR.B2);
		ret = (ret << 1) | (GPIOC->IDR.B12);
		ret = (ret << 1) | (GPIOC->IDR.B11);
		ret = (ret << 1) | (GPIOC->IDR.B10);
		ret = (ret << 1) | (GPIOC->IDR.B9);
		ret = (ret << 1) | (GPIOC->IDR.B8);
		ret = (ret << 1) | (GPIOC->IDR.B7);
		ret = (ret << 1) | (GPIOC->IDR.B6);
#else
		ret = (ret << 1) | (GPIOE->IDR.B10);
		ret = (ret << 1) | (GPIOE->IDR.B9);
		ret = (ret << 1) | (GPIOE->IDR.B8);
		ret = (ret << 1) | (GPIOE->IDR.B7);
		ret = (ret << 1) | (GPIOD->IDR.B1);
		ret = (ret << 1) | (GPIOD->IDR.B0);
		ret = (ret << 1) | (GPIOD->IDR.B15);
		ret = (ret << 1) | (GPIOD->IDR.B14);
#endif
		// SEL
		// high
		*(volatile INT32U *)(APB2PERIPH_BASE + Addr + 0x0C) |=	 (1 << BitAddr);

		EXPIOrawData[SEL] = ret;
	}
#endif
	OSSemPost(ExpioSem);

	return ret;
}


unsigned short int ExpioBitRead (unsigned short int Bitaddr)
{
	INT16U	ExselNo;
	INT16U	BitNumber;

	ExselNo = (Bitaddr/16);
	BitNumber = (Bitaddr % 16);

	ExpioReadData(ExselNo);
	return BitRead(EXPIOrawData[ExselNo], BitNumber);	
}
void ExpioBitSet (unsigned short int Bitaddr)
{
	INT16U	ExselNo;
	INT16U	BitNumber;

	ExselNo = (Bitaddr/16);
	BitNumber = (Bitaddr % 16);
 	EXPIOrawData[ExselNo] = ( EXPIOrawData[ExselNo] |(1 << BitNumber) );
	ExpioWriteData(ExselNo, EXPIOrawData[ExselNo]);
}

void ExpioBitRst(unsigned short int Bitaddr)
{
	INT16U	ExselNo;
	INT16U	BitNumber;

	ExselNo = (Bitaddr/16);
	BitNumber = (Bitaddr % 16);
	EXPIOrawData[ExselNo] = ( EXPIOrawData[ExselNo] & ~(1 << BitNumber) );
	ExpioWriteData(ExselNo, EXPIOrawData[ExselNo]);
}

INT8U atoh (INT8U value )
{
	INT16U	num;

	// isdigit() 는 입력값이 '0' ~ '9' 일경우 True
	if( isdigit(value) ) num = value - '0';
	else if( (value >= 'a') && (value <= 'f') ) num = 10 + value - 'a';
	else if( (value >= 'A') && (value <= 'F') ) num = 10 + value - 'A';
	else										num = 0x0100;

	return (INT8U)num;
}

INT16U ByteToWord(INT8U HighByte, INT8U LowByte)
{
	INT16U WordByte = 0;
	
	WordByte = (INT16U)HighByte;
	WordByte = (WordByte << 8)& 0xff00;
	WordByte = WordByte |(INT16U)LowByte;
	return(WordByte);
}

///////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////

