/*******************************************************************************
 *
 * This module contains the function EEPROM(AT24C64) related', a function
 * that is called before the function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2007 bizistyle(bgyoon@hanafos.com), All rights reserved.
 *
 * $Revision: 0.06 $
 * $Revision date: 2008.02.01
 *               : wrting timing 
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#define At24cAddr	(0x07 << 1)
#define At24cDevID	(0x0A << 4) | At24cAddr

#define EEpromWrTry	7

#define CLKDELAY	ForDelay(5)


#define AT24C64AMaxAddr	 8192

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void EEpromInit(void);
void DisableWriteEEprom(void);
void EnableWriteEEprom(void);
void RstSCL(void);
void SetSCL(void);
void RstSDA(void);
void SetSDA(void);
void SetSDAInMode(void);
void SetSDAOutMode(void);
void StartEEprom(void);
void StopEEprom(void);

void WriteEEpromData(INT8U Data);

void NACKEEprom(void);
INT8U ACKEEprom(void);
INT8U ReadEEpromData(void);
INT8U Write_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data);
INT16S Read_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr);


signed short int WriteEEprom(unsigned short int ADDR, unsigned char DATA);
unsigned char ReadEEprom(unsigned short int ADDR);
unsigned char ReadSDA(void);

extern void ForDelay(unsigned long int count);
extern void  OSTimeDly (INT16U ticks);


//extern void WatchdogClear(void);
//extern unsigned long int Ser0Printf( const char *format, ... );
//extern void WDTRegClear(void);
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

