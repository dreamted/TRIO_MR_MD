/*******************************************************************************
 *
 * This module contains the function `7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2007.04.__
 * $Revision: 0.2 $
 * $Revision date: 2007.10.__
 *               : to check insert read register -> return value
 * $Revision: 0.3 $
 * $Revision date: 2008.03.07
 *               : Ser5PutStrOpt Append
 ******************************************************************************/

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "ucos_ii.h"
#include "cpu.h"

#include "stm32f10x_type_v1010.h"
#include "../include/uart16550ext.h"
#include "Serial6.h"



unsigned long int USART1Printf( const char *format, ...);
unsigned char USART1PutChar(unsigned char Data);

unsigned char Ser6Init(unsigned long int nBps, unsigned char _LCR, unsigned long int bAddr)
{
	INT8U ch = 0;
	INT8U rval = TRUE;
    // CLK: 49.7664 Mhz
	UART6_base = bAddr;

	U6LCR = 0x80;			// Baud rate select mode
	U6DLL = ch = (INT8U)(UART_CLOCK/(16L*nBps));
	USART1Printf("U6LCR: %02x \n", U6LCR);
	USART1Printf("U6DLL: %02x \n", U6DLL);

	if(U6DLL != ch) rval = FALSE;
	U6DLM = 0x00;			//
	U6LCR = _LCR;			// Normal mode register
	if(U6LCR != _LCR) rval = FALSE;
	U6MCR = 0x0B;			// Here, Reserved
	U6FCR = 0x07;			// Reset FIFO, Tx Fifo Reset, Rx Fifo Reset
	U6FCR = 0x01;			// Fifo

	U6IER = 0x05;			// Rx Interrupt Enable
	USART1Printf("U6IER: %02x \n", U6IER);

	ch = U6MSR;
	ch = ch | 0x20 ;
	U6MSR = ch;
	ch = U6MCR;
	ch = ch | 0x01 ;		// DTR 1 set
	U6MCR = ch;
	if(U6MCR != ch) rval = FALSE;

	////////////////////////////////////////////////////////////////
	if(!Tx6CharSem)
	{
		Tx6CharSem = OSSemCreate(1);
		USART1Printf("semipore created!\n");
	}

	return rval;
}

////////////////////////////////////////////////////////////////////
void Ser6Handler(void)
{
	INT16S Reg = U6FCR & 0x0f;

	if(Reg == 0x04)
	{
		Ser6RxBuff[Rx6WrCnt] = U6RBR;		// When the receive register is read, the RDR bit is automatically cleared.
		if(++Rx6WrCnt >= Ser6BuffLen) Rx6WrCnt = 0;
	}
	else if(Reg == 0x02)
	{
		while(1)
		{
			Reg = U6LSR & 0x60;
			//USART1PutChar(Reg);
			if(Reg != 0) break;
		}

		Reg = Ser6TxGetByte();
		//USART1PutChar((INT8U)(Reg >> 8));
		//USART1PutChar((INT8U)(Reg >> 0));
		if(Reg != -1)
		{
			U6THR = (INT8U)Reg;
			//USART1PutChar((INT8U)(Reg >> 0));
			//U6IER |= (IER_TIE | IER_RIE);	// TXIE set
			//USART1PutChar((INT8U)U6IER);
		}
		else
		{
			///USART1PutChar('E');
			U6IER = 0x01;
		}
	}
	else
	{
		Reg  = U6LSR;
		Reg  = U6RBR;		// dummy하게 RD값을 읽는다(무시)
		Reg  = U6MSR;
		U6FCR = 0x07;		// fifo clear
	}
}

////////////////////////////////////////////////////////////////////////////////

unsigned char Ser6PutChar(unsigned char Data)
{
	INT8U err;
	OSSemPend(Tx6CharSem, 0, &err );
	if(err != OS_NO_ERR ) return err;

/////////////////////////////////////////////////////////////////////
	while((U6LSR & LSR_THRE) == 0);
	U6THR = Data;
/////////////////////////////////////////////////////////////////////
	OSSemPost(Tx6CharSem);
	return OS_NO_ERR;
}

unsigned char Ser6PutToBuffer(unsigned char Data)
{
	INT8U err;

	OSSemPend(Tx6CharSem, 0, &err );

	Ser6TxBuff[Tx6WrCnt] = Data;
	if(++Tx6WrCnt >= Ser6BuffLen) Tx6WrCnt = 0;
	U6IER |= IER_TIE;	// TXIE set
///////////////////////////////////////////////////
	OSSemPost(Tx6CharSem);
	return OS_NO_ERR;
}

void Ser6PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{
	unsigned char err;
	unsigned long int i;

	OSSemPend(Tx6CharSem, 0, &err);

	for(i = 0; i < Length; i++)
	{
		Ser6TxBuff[Tx6WrCnt++] = Str[i];
		Tx6WrCnt %= Ser6BuffLen;
	}
///////////////////////////////////////////////////
	if(iEn)
	{
		U6IER |= IER_TIE;	// TXIE set
	}	
	OSSemPost(Tx6CharSem);
}


unsigned long int Ser6Printf( const char *format, ... )
{
	unsigned long int i, cnt;
	char buf[256];
	va_list argptr;

	va_start(argptr, format);
	cnt = vsprintf(buf, format, argptr);
	va_end( argptr );

	for(i = 0;;i++)
	{
		if(buf[i] == 0) break;
		if(buf[i] == '\n') Ser6PutToBuffer('\r');
		Ser6PutToBuffer(buf[i]);
	}
	return cnt;
}


signed short int Ser6RxGetByte(void)
{
    INT16S RetVal = 0;

    if(Rx6RdCnt == Rx6WrCnt) return -1;
	RetVal = Ser6RxBuff[Rx6RdCnt];
	if(++Rx6RdCnt >= Ser6BuffLen ) Rx6RdCnt = 0;

	return (RetVal & 0xff);
}

signed short int Ser6TxGetByte(void)
{
	INT16S RetVal = 0;

	if(Tx6RdCnt == Tx6WrCnt) return -1;

	RetVal = Ser6TxBuff[Tx6RdCnt];
	if(++Tx6RdCnt >= Ser6BuffLen ) Tx6RdCnt = 0;
	return (RetVal & 0xff);
}

unsigned char Ser6CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	INT32U	i = 0, j = 0;
	BOOL	RetVal = TRUE;

	*Recv = 0;
	i = (INT32U) Rx6RdCnt;
	j = (INT32U) Rx6WrCnt;

	if		(i == j) RetVal = FALSE;
	else if (i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j)   RetVal = FALSE;
	}
	else if (i > j)
	{
		*Recv = (Ser6BuffLen + j) - i;
		i = i + ByteCnt;
		j = j + Ser6BuffLen;
		if(i > j)   RetVal = FALSE;
	}
	return(RetVal);
}

void Ser6BuffClear( void )
{
	Rx6RdCnt = 0;
	Rx6WrCnt = 0;
	Tx6RdCnt = 0;
	Tx6WrCnt = 0;
}

signed short int Ser6TxCheckByte(void)
{
	if(Tx6RdCnt == Tx6WrCnt) return TRUE;
	else					 return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

