
/*********************************************
* File Name          : usart2ext.h
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define _USART2

#define Rx2BuffLen	(256*4)
#define Tx2BuffLen	(256*4)


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void InitUSART2(INT32U nBps, INT8U nLCR);
void USART2_IRQHandler(void);

unsigned char USART2PutChar(unsigned char Data);
unsigned char USART2PutToBuffer(unsigned char Data);
signed short int USART2RxGetByte( void );
unsigned char USART2CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
unsigned long int USART2Printf( const char *format, ... );
void USART2PutStr(unsigned char *Str, unsigned short int Length, int iEn);
signed short int USART2TxCheckByte(void);
void USART2BuffClear( void );
void USART2TxClear(void);


extern __SerStrPtr pUSART2;
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

