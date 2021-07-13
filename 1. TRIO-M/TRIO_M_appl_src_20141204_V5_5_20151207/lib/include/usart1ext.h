
/*********************************************
* File Name          : usart1ext.h
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define _USART1

#define USART1		((USART_TypeDef *) USART1_BASE)


#define Rx1BuffLen	(256*8)
#define Tx1BuffLen	(256*8)


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void InitUSART1(INT32U nBps, INT8U nLCR);
void USART1_IRQHandler(void);
unsigned char USART1PutToBuffer(unsigned char Data);
unsigned char USART1PutChar(unsigned char Data);
unsigned long int USART1Printf( const char *format, ...);
void USART1PutStr(unsigned char *Str, unsigned short int Length, int iEn);
signed short int USART1RxGetByte(void);
unsigned char USART1CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
void USART1BuffClear(void);
void USART1TxClear(void);
signed short int USART1TxCheckByte(void);
		
extern __SerStrPtr pUSART1;

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

