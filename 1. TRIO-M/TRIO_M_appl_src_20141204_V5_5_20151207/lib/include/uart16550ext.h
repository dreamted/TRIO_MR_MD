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
 *
 * $Revision: 0.1 $
 ******************************************************************************/

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

#define Ser6BuffLen		1024


#define Ser6Bps		38400L
#define Ser6LCR		(_16x50DATA8BIT | _16x501STOP | _16x50NONPARITY)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////
extern INT8U Ser6RxBuff[Ser6BuffLen];
extern INT8U Ser6TxBuff[Ser6BuffLen];
extern INT16U Rx6RdCnt, Rx6WrCnt;
extern INT16U Tx6RdCnt, Tx6WrCnt;
extern OS_EVENT *Tx6CharSem;


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
//extern void WatchdogClear(void);
void Ser6Handler(void);
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

