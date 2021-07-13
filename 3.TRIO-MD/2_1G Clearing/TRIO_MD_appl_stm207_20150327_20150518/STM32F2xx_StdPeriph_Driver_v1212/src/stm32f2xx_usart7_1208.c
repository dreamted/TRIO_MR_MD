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


#include "stm32f2xx_usart7_1208.h"

#if !defined (OS_INCLUDED) 
	INT8U Rx7Buff[Rx7BuffLen];
	INT8U Tx7Buff[Tx7BuffLen];

	INT16U	Rx7RdCnt = 0, Rx7WrCnt = 0;
	INT16U	Tx7RdCnt = 0, Tx7WrCnt = 0;
#else
	INT8U Rx7Buff[Rx7BuffLen] @ "iram";
	INT8U Tx7Buff[Tx7BuffLen] @ "iram";

	INT16U	Rx7RdCnt @ "iram"= 0, Rx7WrCnt @ "iram" = 0;
	INT16U	Tx7RdCnt @ "iram"= 0, Tx7WrCnt @ "iram" = 0;
#endif

#if !defined (OS_INCLUDED) 
__SerStrPtr pUSART7 = {

#else
__SerStrPtr pUSART7 @ "iram" = {
#endif
	NULL,
	USART7CheckByte,
	USART7RxGetByte,
	USART7PutStr,
	USART7Printf,
	USART7PutChar,
	USART7PutToBuffer,
	USART7TxCheckByte,
	USART7BuffClear,
	USART7TxClear
};

unsigned long int USART1Printf( const char *format, ...);
unsigned char USART1PutChar(unsigned char Data);

unsigned char USART7Init(unsigned long int nBps, unsigned char _LCR, unsigned long int bAddr)
{
	INT8U ch = 0;
	INT8U rval = TRUE;
    // CLK: 49.7664 Mhz
	UART7_base = bAddr;

	U7LCR = 0x80;			// Baud rate select mode
	U7DLL = ch = (INT8U)(UART_CLOCK/(16L*nBps));
	
//	USART1Printf("U7LCR: %02x \n", U7LCR);
//	USART1Printf("U7DLL: %02x \n", U7DLL);

	if(U7DLL != ch) rval = FALSE;
	U7DLM = 0x00;			//
	U7LCR = _LCR;			// Normal mode register
	if(U7LCR != _LCR) rval = FALSE;
	U7MCR = 0x0B;			// Here, Reserved
	U7FCR = 0x07;			// Reset FIFO, Tx Fifo Reset, Rx Fifo Reset
	U7FCR = 0x01;			// Fifo

	U7IER = 0x05;			// Rx Interrupt Enable
//	USART1Printf("U7IER: %02x \n", U7IER);

	ch = U7MSR;
	ch = ch | 0x20 ;
	U7MSR = ch;
	ch = U7MCR;
	ch = ch | 0x01 ;		// DTR 1 set
	U7MCR = ch;
	if(U7MCR != ch) rval = FALSE;

	////////////////////////////////////////////////////////////////
#if defined (OS_INCLUDED) 
		pUSART7.sem = OSSemCreate(1);
#endif


	return rval;
}

////////////////////////////////////////////////////////////////////
void USART7Handler(void)
{
	INT16S Reg = U7FCR & 0x0f;

	if(Reg == 0x04)
	{
		Rx7Buff[Rx7WrCnt] = U7RBR;		// When the receive register is read, the RDR bit is automatically cleared.
		if(++Rx7WrCnt >= Rx7BuffLen) Rx7WrCnt = 0;
	}
	else if(Reg == 0x02)
	{
		while(1)
		{
			Reg = U7LSR & 0x60;
			//USART1PutChar(Reg);
			if(Reg != 0) break;
		}

		Reg = USART7TxGetByte();
		//USART1PutChar((INT8U)(Reg >> 8));
		//USART1PutChar((INT8U)(Reg >> 0));
		if(Reg != -1)
		{
			U7THR = (INT8U)Reg;
			//USART1PutChar((INT8U)(Reg >> 0));
			//U7IER |= (IER_TIE | IER_RIE);	// TXIE set
			//USART1PutChar((INT8U)U7IER);
		}
		else
		{
			///USART1PutChar('E');
			U7IER = 0x01;
		}
	}
	else
	{
		Reg  = U7LSR;
		Reg  = U7RBR;		// dummy하게 RD값을 읽는다(무시)
		Reg  = U7MSR;
		U7FCR = 0x07;		// fifo clear
	}
}

////////////////////////////////////////////////////////////////////////////////
unsigned char USART7PutToBuffer(unsigned char Data)
{
#ifdef OS_INCLUDED
		INT8U err;
		//////////////////////////////////////////////////
	
		OSSemPend(pUSART7.sem, 0, &err);
#endif /* OS_INCLUDED */

	Tx7Buff[Tx7WrCnt] = Data;
	if(++Tx7WrCnt >= Tx7BuffLen) Tx7WrCnt = 0;
	U7IER |= IER_TIE;	// TXIE set
///////////////////////////////////////////////////
#ifdef OS_INCLUDED
		OSSemPost(pUSART7.sem);
#endif /* OS_INCLUDED */

	return OS_NO_ERR;
}


unsigned char USART7PutChar(unsigned char Data)
{
#ifdef OS_INCLUDED
		INT8U err;
		//////////////////////////////////////////////////
	
		OSSemPend(pUSART7.sem, 0, &err);
#endif /* OS_INCLUDED */

//	if(err != OS_NO_ERR ) return err;

/////////////////////////////////////////////////////////////////////
	while((U7LSR & LSR_THRE) == 0);
	U7THR = Data;
/////////////////////////////////////////////////////////////////////
	#ifdef OS_INCLUDED
		OSSemPost(pUSART7.sem);
	#endif /* OS_INCLUDED */
	return OS_NO_ERR;
}

unsigned long int USART7Printf( const char *format, ... )
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
		if(buf[i] == '\n') USART7PutToBuffer('\r');
		USART7PutToBuffer(buf[i]);
	}
	while(!USART7TxCheckByte())
	{
#ifdef OS_INCLUDED
	OSTimeDly(1);
#endif /* OS_INCLUDED */
	}
	return cnt;
}


void USART7PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{
	unsigned long int i;

	USART7BuffClear();

#ifdef OS_INCLUDED
		INT8U err;
		OSSemPend(pUSART7.sem, 0, &err);
#endif /* OS_INCLUDED */

	for(i = 0; i < Length; i++)
	{
		Tx7Buff[Tx7WrCnt++] = Str[i];
		Tx7WrCnt %= Tx7BuffLen;
	}
///////////////////////////////////////////////////
	if(iEn)
	{
		U7IER |= IER_TIE;	// TXIE set
	}	
#ifdef OS_INCLUDED
			OSSemPost(pUSART7.sem);
#endif /* OS_INCLUDED */

}





signed short int USART7RxGetByte(void)
{
    INT16S RetVal = 0;

    if(Rx7RdCnt == Rx7WrCnt) return -1;
	RetVal = Rx7Buff[Rx7RdCnt];
	if(++Rx7RdCnt >= Rx7BuffLen ) Rx7RdCnt = 0;

	return (RetVal & 0xff);
}

signed short int USART7TxGetByte(void)
{
	INT16S RetVal = 0;

	if(Tx7RdCnt == Tx7WrCnt) return -1;

	RetVal = Tx7Buff[Tx7RdCnt];
	if(++Tx7RdCnt >= Tx7BuffLen ) Tx7RdCnt = 0;
	return (RetVal & 0xff);
}

unsigned char USART7CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	INT32U	i = 0, j = 0;
	BOOL	RetVal = TRUE;

	*Recv = 0;
	i = (INT32U) Rx7RdCnt;
	j = (INT32U) Rx7WrCnt;

	if		(i == j) RetVal = FALSE;
	else if (i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j)   RetVal = FALSE;
	}
	else if (i > j)
	{
		*Recv = (Rx7BuffLen + j) - i;
		i = i + ByteCnt;
		j = j + Rx7BuffLen;
		if(i > j)   RetVal = FALSE;
	}
	return(RetVal);
}

void USART7BuffClear( void )
{
	Rx7RdCnt = 0;
	Rx7WrCnt = 0;
	Tx7RdCnt = 0;
	Tx7WrCnt = 0;
}

void USART7TxClear( void )
{
	Tx7RdCnt = 0;
	Tx7WrCnt = 0;
}

signed short int USART7TxCheckByte(void)
{
	if(Tx7RdCnt == Tx7WrCnt) return TRUE;
	else					 return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

