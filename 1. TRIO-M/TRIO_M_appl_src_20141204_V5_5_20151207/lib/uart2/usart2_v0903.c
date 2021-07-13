
/*********************************************
* File Name          : usart2_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#include "stm32f10x_conf.h"
#include "../include/usart2ext.h"
#include "usart2_v0.1.h"


void InitUSART2(INT32U nBps, INT8U nLCR)
{
	// Enable GPIOA and AFIO clocks */
	RCC->APB1ENR.USART2EN = ENABLE;

	//USART2 Configuration
	Write_USART_BaudRate(USART2, nBps);	//Set BaudRate
	USART2->CR1.Bit.TXEIE = ENABLE;	

	if(     ((nLCR >> 0) & 0x03) == (_NONPARITY >> 0))
	{
		USART2->CR1.Bit.PCE = 0;	//parity control disable

		     if(((nLCR >> 4) & 0x03) ==  (_DATA8BIT >> 4))
		{
			USART2->CR1.Bit.M = 0;		//word length = 8
			USART2->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
		else //if( ((nLCR >> 4) & 0x03) ==  _DATA9BIT )
		{
			USART2->CR1.Bit.M = 1;		//word length = 9
			//USART2->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
	}
	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0))
	{
		USART2->CR1.Bit.PCE = 1;	//parity control disable
		USART2->CR1.Bit.PS = 1;
		USART2->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1

		 if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4)) 	USART2->CR1.Bit.M = 0;
		 else										        USART2->CR1.Bit.M = 1;
	}
	else //if(((nLCR >> 0) & 0x03) == _EVNPARITY)
	{
		USART2->CR1.Bit.PCE = 1;	//parity control disable
		USART2->CR1.Bit.PS = 0;
		USART2->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1		

		if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4))   USART2->CR1.Bit.M = 0;
		else									         USART2->CR1.Bit.M = 1;
	}
	/**/
	USART2->CR3.Bit.RTSE = 0;	//RTS hardware flow control disabled
	USART2->CR3.Bit.CTSE = 0;	//CTS hardware flow control disabled
	USART2->CR1.Bit.TE = ENABLE;//Transmitter is enable
	USART2->CR1.Bit.RE = ENABLE;//Receiver is Enalbe
	USART2->CR2.Bit.CLKEN = 0;	//SCLK pin disabled
	USART2->CR2.Bit.CPOL = 0;	//Steady low value on SCLK pin outside transmission window
	USART2->CR2.Bit.CPHA = 1;	//The second clock transition is the first data capture edge
	USART2->CR2.Bit.LBCL = 0;	//The clock pulse of the last data bit is not output to the SCLK pin

	USART_ITConfig(USART2, USART_IT_RXNE, ENABLE);

	// Enable the USART2
	USART_Cmd(USART2, ENABLE);
	// Enable the USART2 Interrupt
 	NVIC_Init(USART2_IRQChannel, ENABLE);	

	pUSART2.sem = OSSemCreate(1);
	USART2Printf("\n");

}

/*******************************************************************************
* Function Name  : USART2_IRQHandler
* Description    : This function handles USART2 global interrupt request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
unsigned char USART1PutChar(unsigned char Data);

void USART2_IRQHandler(void)
{

	INT16U tmp = USART2->SR.Data;
	INT32U cpu_sr;

	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	CPU_CRITICAL_EXIT();

	// Rx Data Received
	if(tmp & ( 1 << __RXNE))
	{
		Rx2Buff[Rx2WrCnt++] = USART2->DR.Bit.DR;		// When the receive register is read, the RDR bit is automatically cleared.
		Rx2WrCnt %= Rx2BuffLen;
	}
	else if(tmp & ( 1 << __TXE))
	{
		if(Tx2RdCnt != Tx2WrCnt)
		{
			USART2->DR.Bit.DR = Tx2Buff[Tx2RdCnt++];
			Tx2RdCnt %= Tx2BuffLen;
		}
		else USART2->CR1.Bit.TXEIE = DISABLE;
	}
	else // error, dummy read
	{
		tmp =  USART2->DR.Bit.DR;
	}

	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
}


unsigned char USART2PutToBuffer(unsigned char Data)
{
	INT8U err;
	//////////////////////////////////////////////////

	OSSemPend(pUSART2.sem, 0, &err);
	
	//////////////////////////////////////////////////
	Tx2Buff[Tx2WrCnt++] = Data;
	Tx2WrCnt %= Tx2BuffLen;
	
	USART2->CR1.Bit.TXEIE = ENABLE;			
	///////////////////////////////////////////////////
	OSSemPost(pUSART2.sem);
	return 0;
}

unsigned char USART2PutChar(unsigned char Data)
{

	USART2->DR.Bit.DR = Data;
	while(!USART2->SR.Bit.TXE);
    
    return Data;
}

unsigned long int USART2Printf( const char *format, ... )
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
		if(buf[i] == '\n') USART2PutToBuffer('\r');
		USART2PutToBuffer(buf[i]);
	}
	return cnt;
}

void USART2PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{

	INT8U err;
	unsigned long int i;

	OSSemPend(pUSART2.sem, 0, &err);
	
	for(i = 0; i < Length; i++)
	{
		Tx2Buff[Tx2WrCnt++] = Str[i];
		Tx2WrCnt %= Tx2BuffLen;
	}

	if(iEn)
	{
		USART2->CR1.Bit.TXEIE = ENABLE;
	}	

	OSSemPost(pUSART2.sem);
}


signed short int USART2RxGetByte( void )
{
	s16 RetVal = 0;

#if (APPOFFSET == 0)
	while(Rx2RdCnt == Rx2WrCnt);
#else
	if(Rx2RdCnt == Rx2WrCnt) return -1;
#endif
	RetVal = Rx2Buff[Rx2RdCnt++];
	Rx2RdCnt %= Rx2BuffLen;

	return (RetVal & 0xff);
}

unsigned char USART2CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	u32	i = 0, j = 0;
	u8	RetVal = TRUE;

	*Recv = 0;
	i = (u32) Rx2RdCnt;
	j = (u32) Rx2WrCnt;

	if		(i == j) RetVal = FALSE;
	else if (i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j)	RetVal = FALSE;
	}
	else if (i > j)
	{
		*Recv = (Rx2BuffLen + j) - i;
		i = i + ByteCnt;
		j = j + Rx2BuffLen;
		if(i > j)	RetVal = FALSE;
	}
	return(RetVal);
}

void USART2BuffClear( void )
{
	Rx2RdCnt = 0;
	Rx2WrCnt = 0;
	Tx2RdCnt = 0;
	Tx2WrCnt = 0;
}

void USART2TxClear(void)
{
	Tx2RdCnt = 0;
	Tx2WrCnt = 0;
}

signed short int USART2TxCheckByte(void)
{
	if(!USART2->CR1.Bit.TXEIE) return TRUE;
	return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

