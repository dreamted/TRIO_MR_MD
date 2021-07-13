
/*********************************************
* File Name          : usart3_vx.x.c
* Author             :
* Date First Issued  : 06/05/2008
* Description        : This file provides all the USART3 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.06.__
********************************************************************************/

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

#include "stm32f10x_conf.h"
#include "../include/usart3ext.h"
#include "usart3_v0.1.h"


void InitUSART3(INT32U nBps, INT8U nLCR)
{
	// Enable GPIOA and AFIO clocks */
	RCC->APB1ENR.USART3EN = ENABLE;

	//USART3 Configuration
	Write_USART_BaudRate(USART3, nBps);	//Set BaudRate
	USART3->CR1.Bit.TXEIE = ENABLE;	

	if(     ((nLCR >> 0) & 0x03) == (_NONPARITY >> 0))
	{
		USART3->CR1.Bit.PCE = 0;	//parity control disable

		     if(((nLCR >> 4) & 0x03) ==  (_DATA8BIT >> 4))
		{
			USART3->CR1.Bit.M = 0;		//word length = 8
			USART3->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
		else //if( ((nLCR >> 4) & 0x03) ==  _DATA9BIT )
		{
			USART3->CR1.Bit.M = 1;		//word length = 9
			//USART3->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
	}
	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0))
	{
		USART3->CR1.Bit.PCE = 1;	//parity control disable
		USART3->CR1.Bit.PS = 1;
		USART3->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1

		 if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4)) 	USART3->CR1.Bit.M = 0;
		 else										        USART3->CR1.Bit.M = 1;
	}
	else //if(((nLCR >> 0) & 0x03) == _EVNPARITY)
	{
		USART3->CR1.Bit.PCE = 1;	//parity control disable
		USART3->CR1.Bit.PS = 0;
		USART3->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1		

		if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4))   USART3->CR1.Bit.M = 0;
		else									         USART3->CR1.Bit.M = 1;
	}
	/**/
	USART3->CR3.Bit.RTSE = 0;	//RTS hardware flow control disabled
	USART3->CR3.Bit.CTSE = 0;	//CTS hardware flow control disabled
	USART3->CR1.Bit.TE = ENABLE;//Transmitter is enable
	USART3->CR1.Bit.RE = ENABLE;//Receiver is Enalbe
	USART3->CR2.Bit.CLKEN = 0;	//SCLK pin disabled
	USART3->CR2.Bit.CPOL = 0;	//Steady low value on SCLK pin outside transmission window
	USART3->CR2.Bit.CPHA = 1;	//The second clock transition is the first data capture edge
	USART3->CR2.Bit.LBCL = 0;	//The clock pulse of the last data bit is not output to the SCLK pin

	USART_ITConfig(USART3, USART_IT_RXNE, ENABLE);

	// Enable the USART3
	USART_Cmd(USART3, ENABLE);
	// Enable the USART3 Interrupt
 	NVIC_Init(USART3_IRQChannel, ENABLE);	

	pUSART3.sem = OSSemCreate(1);
//	USART3Printf("\n");
}

/*******************************************************************************
* Function Name  : USART3_IRQHandler
* Description    : This function handles USART3 global interrupt request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

void USART3_IRQHandler(void)
{

	INT16U tmp = USART3->SR.Data;
	INT32U cpu_sr;

    CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
    OSIntNesting++;
    CPU_CRITICAL_EXIT();

	// Rx Data Received
	if(tmp & ( 1 << __RXNE))
	{
		Rx3Buff[Rx3WrCnt++] = USART3->DR.Bit.DR;		// When the receive register is read, the RDR bit is automatically cleared.
		Rx3WrCnt %= Rx3BuffLen;
	}
	else if(tmp & ( 1 << __TXE))
	{
		if(Tx3RdCnt != Tx3WrCnt)
		{
			USART3->DR.Bit.DR = Tx3Buff[Tx3RdCnt++];
			Tx3RdCnt %= Tx3BuffLen;
		}
		else USART3->CR1.Bit.TXEIE = DISABLE;
	}
	else // error, dummy read
	{
		tmp =  USART3->DR.Bit.DR;
	}

	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR

}

unsigned char USART3PutToBuffer(unsigned char Data)
{
	INT8U err;
	//////////////////////////////////////////////////

	OSSemPend(pUSART3.sem, 0, &err);
	
	//////////////////////////////////////////////////
	Tx3Buff[Tx3WrCnt++] = Data;
	Tx3WrCnt %= Tx3BuffLen;
	
	USART3->CR1.Bit.TXEIE = ENABLE;			
	///////////////////////////////////////////////////
	OSSemPost(pUSART3.sem);
	return 0;
}

unsigned char USART3PutChar(unsigned char Data)
{


	USART3->DR.Bit.DR = Data;
	while(!USART3->SR.Bit.TXE);
    
    return Data;
}

unsigned long int USART3Printf( const char *format, ... )
{
    unsigned long int i, cnt;
    char buf[128];
 	va_list argptr;

    va_start(argptr, format);
	cnt = vsprintf(buf, format, argptr);
	va_end( argptr );

	for(i = 0;;i++)
	{
		if(buf[i] == 0) break;
		if(buf[i] == '\n') USART3PutToBuffer('\r');
		USART3PutToBuffer(buf[i]);
	}
	while(!USART3TxCheckByte()) OSTimeDly(1);
	return cnt;
}

void USART3PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{

	INT8U err;
	unsigned long int i;

	OSSemPend(pUSART3.sem, 0, &err);
	
	for(i = 0; i < Length; i++)
	{
		Tx3Buff[Tx3WrCnt++] = Str[i];
		Tx3WrCnt %= Tx3BuffLen;
	}

	if(iEn)
	{
		USART3->CR1.Bit.TXEIE = ENABLE;
	}	

	OSSemPost(pUSART3.sem);
}


signed short int USART3RxGetByte( void )
{
	s16 RetVal = 0;

#if (APPOFFSET == 0)
	while(Rx3RdCnt == Rx3WrCnt);
#else
	if(Rx3RdCnt == Rx3WrCnt) return -1;
#endif
	RetVal = Rx3Buff[Rx3RdCnt++];
	Rx3RdCnt %= Rx3BuffLen;

	return (RetVal & 0xff);
}

unsigned char USART3CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	u32	i = 0, j = 0;
	u8	RetVal = TRUE;

	*Recv = 0;
	i = (u32) Rx3RdCnt;
	j = (u32) Rx3WrCnt;

	if		(i == j) RetVal = FALSE;
	else if (i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j)	RetVal = FALSE;
	}
	else if (i > j)
	{
		*Recv = (Rx3BuffLen + j) - i;
		i = i + ByteCnt;
		j = j + Rx3BuffLen;
		if(i > j)	RetVal = FALSE;
	}
	return(RetVal);
}

void USART3BuffClear( void )
{
	Rx3RdCnt = 0;
	Rx3WrCnt = 0;
	Tx3RdCnt = 0;
	Tx3WrCnt = 0;
}

void USART3TxClear(void)
{
	Tx3RdCnt = 0;
	Tx3WrCnt = 0;
}


signed short int USART3TxCheckByte(void)
{
	if(!USART3->CR1.Bit.TXEIE) return TRUE;
	return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////


