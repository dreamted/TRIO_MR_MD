/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2007 - bizistyle(bgyoon@naver.com) All rights reserved.
 *
 * $Revision: 0.1 $
 ******************************************************************************/


unsigned long int UART6_base = 0;

#define	U6RBR			*((unsigned char *)(UART6_base + (RBR << 2)))
#define	U6THR			*((unsigned char *)(UART6_base + (THR << 2)))
#define	U6DLL			*((unsigned char *)(UART6_base + (DLL << 2)))
#define	U6IER			*((unsigned char *)(UART6_base + (IER << 2)))
#define	U6DLM			*((unsigned char *)(UART6_base + (DLM << 2)))
#define	U6IIR			*((unsigned char *)(UART6_base + (IIR << 2)))
#define	U6FCR			*((unsigned char *)(UART6_base + (FCR << 2)))
#define	U6LCR			*((unsigned char *)(UART6_base + (LCR << 2)))

#define	U6MCR			*((unsigned char *)(UART6_base + (MCR << 2)))
#define	U6LSR			*((unsigned char *)(UART6_base + (LSR << 2)))
#define	U6MSR			*((unsigned char *)(UART6_base + (MSR << 2)))
#define	U6SCR			*((unsigned char *)(UART6_base + (SCR << 2)))

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////
INT8U Ser6RxBuff[Ser6BuffLen];
INT8U Ser6TxBuff[Ser6BuffLen];
INT16U Rx6RdCnt = 0, Rx6WrCnt = 0;
INT16U Tx6RdCnt = 0, Tx6WrCnt = 0;

OS_EVENT *Tx6CharSem = NULL;

////////////////////////////////////////////////////////////////////////////////
// Function Prototype Declaration
/////////////////////////////////
void Ser6BuffClear( void );
signed short int Ser6TxGetByte(void);
unsigned char Ser6CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
unsigned char Ser6PutChar(unsigned char Data);
unsigned long int Ser6Printf( const char *format, ... );
signed short int Ser6TxCheckByte(void);
signed short int Ser6RxGetByte(void);
void Ser6PutStr(unsigned char *Str, unsigned short int Length, int iEn);
unsigned char Ser6Init(unsigned long int nBps, unsigned char _LCR, unsigned long int bAddr);
unsigned char Ser6PutToBuffer(unsigned char Data);
void Ser6Handler(void);

extern unsigned long int USART1Printf( const char *format, ...);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

