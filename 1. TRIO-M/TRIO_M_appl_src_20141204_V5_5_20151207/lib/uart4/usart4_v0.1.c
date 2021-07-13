
/*********************************************
* File Name          : USART4_vx.x.c
* Author             : 
* Date First Issued  : 06/05/2008
* Description        : This file provides all the USART4 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.06.__
********************************************************************************/

#include "stm32f10x_conf.h"
#include "../include/USART4ext.h"
#include "usart4_v0.1.h"


void InitUSART4(INT32U nBps, INT8U nLCR)
{
	// Enable GPIOA and AFIO clocks */
	RCC->APB1ENR.UART4EN = ENABLE;

	//USART4 Configuration
	Write_USART_BaudRate(USART4, nBps);	//Set BaudRate
	USART4->CR1.Bit.TXEIE = ENABLE;	

	if(     ((nLCR >> 0) & 0x03) == (_NONPARITY >> 0))
	{
		USART4->CR1.Bit.PCE = 0;	//parity control disable

		     if(((nLCR >> 4) & 0x03) ==  (_DATA8BIT >> 4))
		{
			USART4->CR1.Bit.M = 0;		//word length = 8
			USART4->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
		else //if( ((nLCR >> 4) & 0x03) ==  _DATA9BIT )
		{
			USART4->CR1.Bit.M = 1;		//word length = 9
			//USART4->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1
		}
	}
	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0))
	{
		USART4->CR1.Bit.PCE = 1;	//parity control disable
		USART4->CR1.Bit.PS = 1;
		USART4->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1

		 if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4)) 	USART4->CR1.Bit.M = 0;
		 else										        USART4->CR1.Bit.M = 1;
	}
	else //if(((nLCR >> 0) & 0x03) == _EVNPARITY)
	{
		USART4->CR1.Bit.PCE = 1;	//parity control disable
		USART4->CR1.Bit.PS = 0;
		USART4->CR2.Bit.STOP = ((nLCR >> 2) & 0x03);	//stop bit = 1		

		if( ((nLCR >> 4) & 0x03) ==  (_DATA7BIT >> 4))   USART4->CR1.Bit.M = 0;
		else									         USART4->CR1.Bit.M = 1;
	}
	/**/
	USART4->CR3.Bit.RTSE = 0;	//RTS hardware flow control disabled
	USART4->CR3.Bit.CTSE = 0;	//CTS hardware flow control disabled
	USART4->CR1.Bit.TE = ENABLE;//Transmitter is enable
	USART4->CR1.Bit.RE = ENABLE;//Receiver is Enalbe
	USART4->CR2.Bit.CLKEN = 0;	//SCLK pin disabled
	USART4->CR2.Bit.CPOL = 0;	//Steady low value on SCLK pin outside transmission window
	USART4->CR2.Bit.CPHA = 1;	//The second clock transition is the first data capture edge
	USART4->CR2.Bit.LBCL = 0;	//The clock pulse of the last data bit is not output to the SCLK pin

	USART_ITConfig(USART4, USART_IT_RXNE, ENABLE);

	// Enable the USART4
	USART_Cmd(USART4, ENABLE);
	// Enable the USART4 Interrupt
 	NVIC_Init(UART4_IRQChannel, ENABLE);	

	pUSART4.sem = OSSemCreate(1);
	USART4Printf("\n");

}

/*******************************************************************************
* Function Name  : USART4_IRQHandler
* Description    : This function handles USART4 global interrupt request.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/

void USART4_IRQHandler(void)
{

	INT16U tmp = USART4->SR.Data;
	INT32U cpu_sr;

    CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
    OSIntNesting++;
    CPU_CRITICAL_EXIT();

	// Rx Data Received
	if(tmp & ( 1 << __RXNE))
	{
		Rx4Buff[Rx4WrCnt++] = USART4->DR.Bit.DR;		// When the receive register is read, the RDR bit is automatically cleared.
		Rx4WrCnt %= Rx4BuffLen;
	}
	else if(tmp & ( 1 << __TXE))
	{
		if(Tx4RdCnt != Tx4WrCnt)
		{
			USART4->DR.Bit.DR = Tx4Buff[Tx4RdCnt++];
			Tx4RdCnt %= Tx4BuffLen;
		}
		else USART4->CR1.Bit.TXEIE = DISABLE;
	}
	else // error, dummy read
	{
		tmp =  USART4->DR.Bit.DR;
	}

	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR

}

unsigned char USART4PutToBuffer(unsigned char Data)
{
	INT8U err;
	//////////////////////////////////////////////////

	OSSemPend(pUSART4.sem, 0, &err);
	
	//////////////////////////////////////////////////
	Tx4Buff[Tx4WrCnt++] = Data;
	Tx4WrCnt %= Tx4BuffLen;
	
	USART4->CR1.Bit.TXEIE = ENABLE;			
	///////////////////////////////////////////////////
	OSSemPost(pUSART4.sem);
	return 0;
}

unsigned char USART4PutChar(unsigned char Data)
{


	USART4->DR.Bit.DR = Data;
	while(!USART4->SR.Bit.TXE);
    
    return Data;
}

unsigned long int USART4Printf( const char *format, ... )
{
    unsigned long int i, cnt;
//    char buf[128];
	char *buf = (char *)&Tx4Buff[Tx4BuffLen-256];

 	va_list argptr;

    va_start(argptr, format);
	cnt = vsprintf(buf, format, argptr);
	va_end( argptr );

	for(i = 0;;i++)
	{
		if(buf[i] == 0) break;
		if(buf[i] == '\n') USART4PutToBuffer('\r');
		USART4PutToBuffer(buf[i]);
	}
	while(!USART4TxCheckByte()) OSTimeDly(1);
	return cnt;
}

void USART4PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{

	INT8U err;
	unsigned long int i;

	OSSemPend(pUSART4.sem, 0, &err);
	
	for(i = 0; i < Length; i++)
	{
		Tx4Buff[Tx4WrCnt++] = Str[i];
		Tx4WrCnt %= Tx4BuffLen;
	}

	if(iEn)
	{
		USART4->CR1.Bit.TXEIE = ENABLE;
	}	

	OSSemPost(pUSART4.sem);
}


signed short int USART4RxGetByte( void )
{
	s16 RetVal = 0;

#if (APPOFFSET == 0)
	while(Rx4RdCnt == Rx4WrCnt);
#else
	if(Rx4RdCnt == Rx4WrCnt) return -1;
#endif
	RetVal = Rx4Buff[Rx4RdCnt++];
	Rx4RdCnt %= Rx4BuffLen;

	return (RetVal & 0xff);
}

unsigned char USART4CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	u32	i = 0, j = 0;
	u8	RetVal = TRUE;

	*Recv = 0;
	i = (u32) Rx4RdCnt;
	j = (u32) Rx4WrCnt;

	if		(i == j) RetVal = FALSE;
	else if (i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j)	RetVal = FALSE;
	}
	else if (i > j)
	{
		*Recv = (Rx4BuffLen + j) - i;
		i = i + ByteCnt;
		j = j + Rx4BuffLen;
		if(i > j)	RetVal = FALSE;
	}
	return(RetVal);
}

void USART4BuffClear( void )
{
	Rx4RdCnt = 0;
	Rx4WrCnt = 0;
	Tx4RdCnt = 0;
	Tx4WrCnt = 0;
}

void USART4TxClear(void)
{
	Tx4RdCnt = 0;
	Tx4WrCnt = 0;
}


signed short int USART4TxCheckByte(void)
{
	if(!USART4->CR1.Bit.TXEIE) return TRUE;
	return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////


