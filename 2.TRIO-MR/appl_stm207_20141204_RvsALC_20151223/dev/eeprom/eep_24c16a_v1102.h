/*******************************************************************************
 *
 * This module contains the function STM32F10x EEPROM(AT24C01~16) related, a function
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

////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#define At16aAddr	(0x07 << 0)
#define At16aDevID	(0x0A << 4)

#define AT16aWrTry	7

#define AT24C01AMaxAddr	 128
#define AT24C02AMaxAddr	 256
#define AT24C04AMaxAddr	 512
#define AT24C08AMaxAddr	 1024
#define AT24C16AMaxAddr	 2048

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void AT24C16AInit(void);
void DisableWriteAt24c16A(void);
void EnableWriteAt24c16A(void);
void Rst16ASCL(void);
void Set16ASCL(void);
void Rst16ASDA(void);
void Set16ASDA(void);
void Set16ASDAInMode(void);
void Set16ASDAOutMode(void);
void Start16AEEprom(void);
void Stop16AEEprom(void);

void Write16AEEpromData(INT8U Data);
void NACK16AEEprom(void);

INT8U ACK16AEEprom(void);
INT8U Read16AEEpromData(void);

INT8U Write_16A_8Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data);
INT16S Read_16A_8Addr_8Data(INT8U DevAddr, INT16U Addr);

signed short int Write24C16(unsigned short int ADDR, unsigned char DATA);
unsigned char Read24C16(unsigned short int ADDR);
unsigned char Read16ASDA(void);

extern void ForDelay(unsigned long int count);
extern void WatchdogClear(void);
extern __SerStrPtr pUSART1;

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

