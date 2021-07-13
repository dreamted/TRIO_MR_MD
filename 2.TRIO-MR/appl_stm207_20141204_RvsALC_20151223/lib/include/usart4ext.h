
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart2ext.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define _USART4

#define Rx4BuffLen	(256*4)
#define Tx4BuffLen	(256*4)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void InitUSART4(INT32U nBps, INT8U nLCR);
void USART4_IRQHandler(void);

unsigned char USART4PutChar(unsigned char Data);
unsigned char USART4PutToBuffer(unsigned char Data);
signed short int USART4RxGetByte( void );
unsigned char USART4CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
unsigned long int USART4Printf( const char *format, ... );
void USART4PutStr(unsigned char *Str, unsigned short int Length, int iEn);
signed short int USART4TxCheckByte(void);
void USART4BuffClear( void );
void USART4TxClear(void);

extern __SerStrPtr pUSART4;
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////


