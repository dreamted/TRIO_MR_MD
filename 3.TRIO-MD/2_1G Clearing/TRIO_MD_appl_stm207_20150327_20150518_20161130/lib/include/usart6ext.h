
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart1ext.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define _USART6

#define Rx6BuffLen	(256*8)
#define Tx6BuffLen	(256*8)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void InitUSART6(INT32U nBps, INT8U nLCR);
void USART6_IRQHandler(void);
unsigned char USART6PutToBuffer(unsigned char Data);
unsigned char USART6PutChar(unsigned char Data);
unsigned long int USART6Printf( const char *format, ...);
void USART6PutStr(unsigned char *Str, unsigned short int Length, int iEn);
signed short int USART6RxGetByte(void);
unsigned char USART6CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
void USART6BuffClear(void);
void USART6TxClear(void);
signed short int USART6TxCheckByte(void);
		
extern __SerStrPtr pUSART6;

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

