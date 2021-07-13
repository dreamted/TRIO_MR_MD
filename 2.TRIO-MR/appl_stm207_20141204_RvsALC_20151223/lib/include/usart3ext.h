
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart2ext.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define _USART3

#define Rx3BuffLen	(256*8)
#define Tx3BuffLen	(256*8)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void InitUSART3(INT32U nBps, INT8U nLCR);
void USART3_IRQHandler(void);

unsigned char USART3PutChar(unsigned char Data);
unsigned char USART3PutToBuffer(unsigned char Data);
signed short int USART3RxGetByte( void );
unsigned char USART3CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
unsigned long int USART3Printf( const char *format, ... );
void USART3PutStr(unsigned char *Str, unsigned short int Length, int iEn);
signed short int USART3TxCheckByte(void);
void USART3BuffClear( void );
void USART3TxClear(void);



extern __SerStrPtr pUSART3;
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////


