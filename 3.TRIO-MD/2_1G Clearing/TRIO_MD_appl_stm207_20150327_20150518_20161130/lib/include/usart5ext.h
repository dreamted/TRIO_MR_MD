
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart2ext.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define _USART5

#define Rx5BuffLen	(256*8)
#define Tx5BuffLen	(256*8)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void InitUSART5(INT32U nBps, INT8U nLCR);
void USART5_IRQHandler(void);

unsigned char USART5PutChar(unsigned char Data);
unsigned char USART5PutToBuffer(unsigned char Data);
signed short int USART5RxGetByte( void );
unsigned char USART5CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
unsigned long int USART5Printf( const char *format, ... );
void USART5PutStr(unsigned char *Str, unsigned short int Length, int iEn);
signed short int USART5TxCheckByte(void);
void USART5BuffClear( void );
void USART5TxClear(void);



extern __SerStrPtr pUSART5;
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////


