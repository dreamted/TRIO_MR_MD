/*******************************************************************************
 *
 * This module contains the function STM32F10x EEPROM(DS2431) related, a function
 * that is called before the 'main' function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2011- bizistyle(bgyoon@naver.com), All rights reserved.
 *
 * $Revision: 2011.02 $
 * $Revision date: 2008.06
 ******************************************************************************/

#define PSU_DS2431		0

#define USE_DEV0		0
#define USE_DEV1		1


////////////////////////////////////////////////////////////////////////////////
// Global macros Declaration
//////////////////////////////

#define ID_CHIP_COMM_READ_ROM			0x33
#define	ID_CHIP_COMM_SKIP_ROM			0xCC
#define	ID_CHIP_COMM_READ_MEMORY		0xF0
#define	ID_CHIP_COMM_WRITE_SCRATCHPAD	0x0F
#define ID_CHIP_COMM_READ_SCRATCHPAD	0xAA

#define	ID_CHIP_COMM_COPY_SCRATCHPAD	0x55

#define ID_CHIP_ADDRESS_HI				0x00
#define ID_CHIP_ES_BYTE					0x07

#define ID_CHIP_PRODUCTION_ID_ADDRESS	0

///////////////////////////////////////////////////////////////////////////////
#define tRSTL			520		//Reset Low Time
#define tPDH			63		//Presence Detect High Time
#define tREC			30L		//	

#define tW1L			(6u)
#define tW0L			(60u)
#define tSLOT			(67u)

#define tRL				3u
#define tMSR			5u

#define tMSP			65u


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////

void DS2431Init(void);
void Delay_1us(INT32U us);
void WriteBit_DS2431(INT8U nUSE, INT8U Bit);
void WriteByte_DS2431(INT8U nUSE, INT8U Data);

INT8U RstDS2431(INT8U nUSE);

INT8S ReadBit_DS2431(INT8U nUSE);
INT16S ReadDS2431Ptr(INT8U nUSE, INT16U Addr, INT8U *Data);
INT16S ReadByte_DS2431(INT8U nUSE);

INT8S WriteDS2431(INT8U nUSE, INT16U Addr, INT8U Data);
INT16S ReadDS2431(INT8U nUSE, INT16U Addr);

// Hw 에 맞춰 고쳐야 한다.
void SetDS2431OutMode(INT8U nUSE);
void SetDS2431InMode(INT8U nUSE);
void SetDS2431DATA(INT8U nUSE);
void RstDS2431DATA(INT8U nUSE);
INT32U ReadDS2431DATA(INT8U nUSE);


extern void ForDelay(unsigned long int count);
extern __SerStrPtr pUSART1;

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////


