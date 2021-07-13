
/*********************************************
* File Name          : usart1_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#include "stm32f10x_conf.h"
#include "../include/usart1ext.h"
#include "usart1_v0.1.h"

void InitUSART1(INT32U nBps, INT8U nLCR)
{
	// Enalbe GPIOA and AFIO clocks
	RCC->APB2ENR.USART1EN = ENABLE;

	//USART1 Configuration
	Write_USART_BaudRate(USART1, nBps); //Set BaudRate
	USART1->CR1.Bit.TXEIE = ENABLE; 

	if( 	((nLCR >> 0) & 0x03) == (_NONPARITY >> 0))
	{
		USART1->CR1.Bit.PCE = 0;	//parity control disable

			 if(((nLCR >> 4) & 0x03) ==  (_DATA8BIT >> 4))
		{
			USART1->CR1.Bit.M = 0;		//word length = 8
			USART1->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
		else //if( ((nLCR >> 4) & 0x03) ==	_DATA9BIT )
		{
			USART1->CR1.Bit.M = 1;		//word length = 9			
		}
	}
	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0))
	{
		USART1->CR1.Bit.PCE = 1;	//parity control disable
		USART1->CR1.Bit.PS = 1;
		USART1->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1

		 if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4)) 	USART1->CR1.Bit.M = 0;
		 else												USART1->CR1.Bit.M = 1;
	}
	else //if(((nLCR >> 0) & 0x03) == _EVNPARITY)
	{
		USART1->CR1.Bit.PCE = 1;	//parity control disable
		USART1->CR1.Bit.PS = 0;
		USART1->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1		

		if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4))	 USART1->CR1.Bit.M = 0;
		else											 USART1->CR1.Bit.M = 1;
	}
	/**/
	USART1->CR3.Bit.RTSE = 0;	//RTS hardware flow control disabled
	USART1->CR3.Bit.CTSE = 0;	//CTS hardware flow control disabled
	USART1->CR1.Bit.TE = ENABLE;//Transmitter is enable
	USART1->CR1.Bit.RE = ENABLE;//Receiver is Enalbe
	USART1->CR2.Bit.CLKEN = 0;	//SCLK pin disabled
	USART1->CR2.Bit.CPOL = 0;	//Steady low value on SCLK pin outside transmission window
	USART1->CR2.Bit.CPHA = 1;	//The second clock transition is the first data capture edge
	USART1->CR2.Bit.LBCL = 0;	//The clock pulse of the last data bit is not output to the SCLK pin

	USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);

	// Enable the USART1
	USART_Cmd(USART1, ENABLE);
	// Enable the USART1 Interrupt
	NVIC_Init(USART1_IRQChannel, ENABLE); 

	pUSART1.sem = OSSemCreate(1);
	USART1Printf("\n");
}


/*******************************************************************************
* Function Name  : USART1_IRQHandler
* Description    : This function handles USART1 global interrupt request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void USART1_IRQHandler(void)
{

	INT16U tmp = USART1->SR.Data;
	INT32U cpu_sr;

    CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
    OSIntNesting++;
    CPU_CRITICAL_EXIT();

	// Rx Data Received
	if(tmp & ( 1 << __RXNE))
	{
		Rx1Buff[Rx1WrCnt++] = USART1->DR.Bit.DR;		// When the receive register is read, the RDR bit is automatically cleared.
		Rx1WrCnt %= Rx1BuffLen;
	}
	else if(tmp & ( 1 << __TXE))
	{
		if(Tx1RdCnt != Tx1WrCnt)
		{
			USART1->DR.Bit.DR = Tx1Buff[Tx1RdCnt++];
			Tx1RdCnt %= Tx1BuffLen;
		}
		else USART1->CR1.Bit.TXEIE = DISABLE;

		//OSSemPost(pUSART1.sem);
	}
	else // error, dummy read
	{
		tmp =  USART1->DR.Bit.DR;
	}

    OSIntExit();                                                // Tell uC/OS-II that we are leaving the ISR
}

unsigned char USART1PutToBuffer(unsigned char Data)
{
	INT8U err;
	//////////////////////////////////////////////////

	OSSemPend(pUSART1.sem, 0, &err);

	Tx1Buff[Tx1WrCnt++] = Data;
	Tx1WrCnt %= Tx1BuffLen;
	
	USART1->CR1.Bit.TXEIE = ENABLE;
	///////////////////////////////////////////////////

	OSSemPost(pUSART1.sem);
	return 0;
}



//Not using interrupt
unsigned char USART1PutChar(unsigned char Data)
{
	USART1->DR.Bit.DR = Data;
	while(!USART1->SR.Bit.TXE);
	return Data;
}


unsigned long int USART1Printf( const char *format, ...)
{
	unsigned long int i, cnt;
//	char buf[128];
	char *buf = (char *)&Tx1Buff[Tx1BuffLen-256];

	va_list argptr;

	va_start(argptr, format);
	cnt = vsprintf(buf, format, argptr);
	va_end( argptr );

	for(i = 0;;i++)
	{
		if(buf[i] == 0) break;
		if(buf[i] == '\n') USART1PutToBuffer('\r');
		USART1PutToBuffer(buf[i]);
	}
	while(!USART1TxCheckByte()) OSTimeDly(1);
	USART1TxClear();
	return cnt;
}


void USART1PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{

	INT8U err;
	unsigned long int i;

	OSSemPend(pUSART1.sem, 0, &err);
	
	for(i = 0; i < Length; i++)
	{
		Tx1Buff[Tx1WrCnt++] = Str[i];
		Tx1WrCnt %= Tx1BuffLen;
	}

	if(iEn)
	{
		USART1->CR1.Bit.TXEIE = ENABLE;
	}	

	OSSemPost(pUSART1.sem);
}

signed short int USART1RxGetByte(void)
{
	s16 RetVal = 0;

#if (APPOFFSET == 0)
	while(Rx1RdCnt == Rx1WrCnt);
#else
	if(Rx1RdCnt == Rx1WrCnt) return -1;
#endif

	RetVal = Rx1Buff[Rx1RdCnt++];
	Rx1RdCnt %= Rx1BuffLen;

	return (RetVal & 0xff);
}

unsigned char USART1CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	u32 i = 0, j = 0;
	u8 RetVal = TRUE;

	*Recv = 0;
	i = (u32) Rx1RdCnt;
	j = (u32) Rx1WrCnt;

	if(i == j) RetVal = FALSE;
	else if(i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j) RetVal = FALSE;
	}
	else if(i > j)
	{
		*Recv = (Rx1BuffLen +j) - i;
		i = i + ByteCnt;
		j = j + Rx1BuffLen;
		if(i > j) RetVal = FALSE; 
	}
	return (RetVal);
}

void USART1BuffClear(void)
{
	Rx1RdCnt = 0;
	Rx1WrCnt = 0;
	Tx1RdCnt = 0;
	Tx1WrCnt = 0;
}

void USART1TxClear(void)
{
	Tx1RdCnt = 0;
	Tx1WrCnt = 0;
}

signed short int USART1TxCheckByte(void)
{
	if(!USART1->CR1.Bit.TXEIE) return TRUE;
	return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

