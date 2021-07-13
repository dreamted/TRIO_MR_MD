
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : USART5_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 06/05/2008
* Description        : This file provides all the USART5 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.06.__
********************************************************************************/
#include "stm32f10x_conf.h"
#include "../include/USART5ext.h"
#include "usart5_v0.1.h"


void InitUSART5(INT32U nBps, INT8U nLCR)
{
	// Enable GPIOA and AFIO clocks */
	RCC->APB1ENR.UART5EN = ENABLE;

	//USART5 Configuration
	Write_USART_BaudRate(USART5, nBps);	//Set BaudRate
	USART5->CR1.Bit.TXEIE = ENABLE;	

	if(     ((nLCR >> 0) & 0x03) == (_NONPARITY >> 0))
	{
		USART5->CR1.Bit.PCE = 0;	//parity control disable

		     if(((nLCR >> 4) & 0x03) ==  (_DATA8BIT >> 4))
		{
			USART5->CR1.Bit.M = 0;		//word length = 8
			USART5->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
		else //if( ((nLCR >> 4) & 0x03) ==  _DATA9BIT )
		{
			USART5->CR1.Bit.M = 1;		//word length = 9
			//USART5->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
	}
	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0))
	{
		USART5->CR1.Bit.PCE = 1;	//parity control disable
		USART5->CR1.Bit.PS = 1;
		USART5->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1

		 if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4)) 	USART5->CR1.Bit.M = 0;
		 else										        USART5->CR1.Bit.M = 1;
	}
	else //if(((nLCR >> 0) & 0x03) == _EVNPARITY)
	{
		USART5->CR1.Bit.PCE = 1;	//parity control disable
		USART5->CR1.Bit.PS = 0;
		USART5->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1		

		if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4))   USART5->CR1.Bit.M = 0;
		else									         USART5->CR1.Bit.M = 1;
	}
	/**/
	USART5->CR3.Bit.RTSE = 0;	//RTS hardware flow control disabled
	USART5->CR3.Bit.CTSE = 0;	//CTS hardware flow control disabled
	USART5->CR1.Bit.TE = ENABLE;//Transmitter is enable
	USART5->CR1.Bit.RE = ENABLE;//Receiver is Enalbe
	USART5->CR2.Bit.CLKEN = 0;	//SCLK pin disabled
	USART5->CR2.Bit.CPOL = 0;	//Steady low value on SCLK pin outside transmission window
	USART5->CR2.Bit.CPHA = 1;	//The second clock transition is the first data capture edge
	USART5->CR2.Bit.LBCL = 0;	//The clock pulse of the last data bit is not output to the SCLK pin

	USART_ITConfig(USART5, USART_IT_RXNE, ENABLE);

	// Enable the USART5
	USART_Cmd(USART5, ENABLE);
	// Enable the USART5 Interrupt
 	NVIC_Init(UART5_IRQChannel, ENABLE);	

	pUSART5.sem = OSSemCreate(1);
	USART5Printf("\n");

}

/*******************************************************************************
* Function Name  : USART5_IRQHandler
* Description    : This function handles USART5 global interrupt request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

void USART5_IRQHandler(void)
{

	INT16U tmp = USART5->SR.Data;
	INT32U cpu_sr;

    CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
    OSIntNesting++;
    CPU_CRITICAL_EXIT();

	// Rx Data Received
	if(tmp & ( 1 << __RXNE))
	{
		Rx5Buff[Rx5WrCnt++] = USART5->DR.Bit.DR;		// When the receive register is read, the RDR bit is automatically cleared.
		Rx5WrCnt %= Rx5BuffLen;
	}
	else if(tmp & ( 1 << __TXE))
	{
		if(Tx5RdCnt != Tx5WrCnt)
		{
			USART5->DR.Bit.DR = Tx5Buff[Tx5RdCnt++];
			Tx5RdCnt %= Tx5BuffLen;
		}
		else USART5->CR1.Bit.TXEIE = DISABLE;
	}
	else // error, dummy read
	{
		tmp =  USART5->DR.Bit.DR;
	}

	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR

}

unsigned char USART5PutToBuffer(unsigned char Data)
{
	INT8U err;
	//////////////////////////////////////////////////

	OSSemPend(pUSART5.sem, 0, &err);
	
	//////////////////////////////////////////////////
	Tx5Buff[Tx5WrCnt++] = Data;
	Tx5WrCnt %= Tx5BuffLen;
	
	USART5->CR1.Bit.TXEIE = ENABLE;			
	///////////////////////////////////////////////////
	OSSemPost(pUSART5.sem);
	return 0;
}

unsigned char USART5PutChar(unsigned char Data)
{


	USART5->DR.Bit.DR = Data;
	while(!USART5->SR.Bit.TXE);
    
    return Data;
}

unsigned long int USART5Printf( const char *format, ... )
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
		if(buf[i] == '\n') USART5PutToBuffer('\r');
		USART5PutToBuffer(buf[i]);
	}
	while(!USART5TxCheckByte()) OSTimeDly(1);
	return cnt;
}

void USART5PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{

	INT8U err;
	unsigned long int i;

	OSSemPend(pUSART5.sem, 0, &err);
	
	for(i = 0; i < Length; i++)
	{
		Tx5Buff[Tx5WrCnt++] = Str[i];
		Tx5WrCnt %= Tx5BuffLen;
	}

	if(iEn)
	{
		USART5->CR1.Bit.TXEIE = ENABLE;
	}	

	OSSemPost(pUSART5.sem);
}


signed short int USART5RxGetByte( void )
{
	s16 RetVal = 0;

#if (APPOFFSET == 0)
	while(Rx5RdCnt == Rx5WrCnt);
#else
	if(Rx5RdCnt == Rx5WrCnt) return -1;
#endif
	RetVal = Rx5Buff[Rx5RdCnt++];
	Rx5RdCnt %= Rx5BuffLen;

	return (RetVal & 0xff);
}

unsigned char USART5CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	u32	i = 0, j = 0;
	u8	RetVal = TRUE;

	*Recv = 0;
	i = (u32) Rx5RdCnt;
	j = (u32) Rx5WrCnt;

	if		(i == j) RetVal = FALSE;
	else if (i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j)	RetVal = FALSE;
	}
	else if (i > j)
	{
		*Recv = (Rx5BuffLen + j) - i;
		i = i + ByteCnt;
		j = j + Rx5BuffLen;
		if(i > j)	RetVal = FALSE;
	}
	return(RetVal);
}

void USART5BuffClear( void )
{
	Rx5RdCnt = 0;
	Rx5WrCnt = 0;
	Tx5RdCnt = 0;
	Tx5WrCnt = 0;
}

void USART5TxClear(void)
{
	Tx5RdCnt = 0;
	Tx5WrCnt = 0;
}


signed short int USART5TxCheckByte(void)
{
	if(!USART5->CR1.Bit.TXEIE) return TRUE;
	return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////


