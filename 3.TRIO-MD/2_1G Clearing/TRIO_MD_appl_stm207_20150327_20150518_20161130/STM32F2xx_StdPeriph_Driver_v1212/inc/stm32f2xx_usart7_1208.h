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

#include "stm32f2xx_1212.h"

unsigned long int UART7_base @ "iram" = 0;


#define	U7RBR			*((unsigned char *)(UART7_base + (RBR << 16)))
#define	U7THR			*((unsigned char *)(UART7_base + (THR << 16)))
#define	U7DLL			*((unsigned char *)(UART7_base + (DLL << 16)))
#define	U7IER			*((unsigned char *)(UART7_base + (IER << 16)))
#define	U7DLM			*((unsigned char *)(UART7_base + (DLM << 16)))
#define	U7IIR			*((unsigned char *)(UART7_base + (IIR << 16)))
#define	U7FCR			*((unsigned char *)(UART7_base + (FCR << 16)))
#define	U7LCR			*((unsigned char *)(UART7_base + (LCR << 16)))

#define	U7MCR			*((unsigned char *)(UART7_base + (MCR << 16)))
#define	U7LSR			*((unsigned char *)(UART7_base + (LSR << 16)))
#define	U7MSR			*((unsigned char *)(UART7_base + (MSR << 16)))
#define	U7SCR			*((unsigned char *)(UART7_base + (SCR << 16)))


#define UART_CLOCK	8000000L
//#define  UART_CLOCK		5529600L

////////////////////////////////////////////////////////////////////////////////
// UART0,1: 16C550
//////////////////
#define	RBR				0x00	// LCR DATA BIT 7 -> 0 SET
#define	THR				0x00
#define RBR_THR			0x00
#define	DLL   		 	0x00   	// Receiver Buffer Reg. (R DLAB = 0)
                       			// Transmitter Holding Reg. (W DLAB = 0)
#define	IER				0x01
#define	DLM		 		0x01   	// Interrupt Enable Reg. (R/W DLAB = 0)
                       			// Divisor Latch MS (R/W DLAB = 1)
                       			// Divisor Latch MS (R/W DLAB = 1)
#define	IIR				0x02
#define	FCR        		0x02   	// Interrupt Ident Reg. (R)
#define IIR_FCR			0x02

#define	LCR         	0x03   	// Line Control Reg. (R/W)
  // Line Control
  #define _16x50DATA5BIT		0
  #define _16x50DATA6BIT		1
  #define _16x50DATA7BIT		2
  #define _16x50DATA8BIT		3

  #define _16x501STOP			0
  #define _16x502STOP			(1 << 2)

  #define _16x50NONPARITY		0
  #define _16x50ODDPARITY		(1 << 3)
  #define _16x50EVNPARITY		(3 << 3)

 // Divisor Latch LS (R/W DLAB = 1)
#define MCR				0x04
#define	LSR         	0x05   	// Line Status Reg. (R/W)
#define MSR				0x06
#define	SCR         	0x07   	// Scratch Reg.

#define	LSR_DR			0x01
#define	LSR_THRE		0x20
#define	LSR_TEMPT		0x40
#define	IER_TIE			0x02
#define	IER_RIE			0x01

//=========== IIR(Interrupt ID Register) DATA DEFINITION =======================
#define  RxDataReady       0x04  // Rx data available --> Reading the Rcv Buffer
#define  RxLineStatus      0x06  // Overrun or Parity or Framing or Break Error --> Reading the LSR
#define  RxTimeOut         0x0c  // FIFO mode only --> Reading the Receiver Buffer Register
#define  TxHoldRegEmpty    0x02  // Tx Holding Register Empty --> Writing the THR
#define  ModemStatus       0x00  // CTS or DSR or RI or DCD --> Reading MSR

//============ IER Set/Reset Data Definition ===================================
#define  EnRxDataInt       0x01
#define  EnTxHoldRegEmpty  0x02
#define  EnRxLineStatus    0x04
#define  EnModemStatus     0x08

//============ FCR(FIFO Control Reg) Set/Reset Data Definition =================
#define  EnFIFO            0x01
#define  EnRxFIFO          0x02
#define  EnTxFIFO          0x04
#define  EnDMA             0x08

#define Tx7BuffLen		(256*8)
#define Rx7BuffLen		(256*8)

#define Ser7Bps		38400L
#define Ser7LCR		(_16x50DATA8BIT | _16x501STOP | _16x50NONPARITY)


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////


	extern __SerStrPtr pUSART7;


////////////////////////////////////////////////////////////////////////////////
// Function Prototype Declaration
/////////////////////////////////
unsigned char USART7Init(unsigned long int nBps, unsigned char _LCR, unsigned long int bAddr);
void USART7BuffClear( void );
signed short int USART7TxGetByte(void);
unsigned char USART7CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
unsigned char USART7PutChar(unsigned char Data);
unsigned long int USART7Printf( const char *format, ... );
signed short int USART7TxCheckByte(void);
signed short int USART7RxGetByte(void);
void USART7PutStr(unsigned char *Str, unsigned short int Length, int iEn);
unsigned char USART7PutToBuffer(unsigned char Data);
void USART7TxClear( void );
void USART7Handler(void);


extern unsigned long int USART1Printf( const char *format, ...);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

