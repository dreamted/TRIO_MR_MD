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
 * Copyright 2007 bizistyle(bgyoon@naver.com), All rights reserved.
 *
 * $Revision  v1205: support multi 24C64 Devices
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////

#include "stm32f2xx_1212.h"

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#define At24cAddr		(0x00 << 1)
#define At24cAddr_21G	(0x01 << 1)
#define At24cAddr_25G	(0x02 << 1)
#define At24cAddr_900M	(0x04 << 1)

#define At24cDevID		(0x0A << 4) | At24cAddr
#define At24cDevID_21G	(0x0A << 4) | At24cAddr_21G
#define At24cDevID_900M	(0x0A << 4) | At24cAddr_900M
#define At24cDevID_25G	(0x0A << 4) | At24cAddr_25G


#define At24CMaxNo	(8*1024)

#define EEpromWrTry	7

#define CLKDELAY	ForDelay(10)
#define CLKDELAY2	ForDelay(20)

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void EEpromInit(void);
void DisableWriteEEprom(void);
void EnableWriteEEprom(void);

void RstSCL(INT8U Path);
void SetSCL(INT8U Path);
void RstSDA(INT8U Path);
void SetSDA(INT8U Path);
void SetSDAInMode(INT8U Path);
void SetSDAOutMode(INT8U Path);
void StartEEprom(INT8U Path);
void StopEEprom(INT8U Path);

void WriteEEpromData(INT8U Data, INT8U Path);

void NACKEEprom(INT8U Path);
INT8U ACKEEprom(INT8U Path);
INT8U ReadEEpromData(INT8U Path);
INT8U Write_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data, INT8U Path);
INT16S Read_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Path);


signed short int WriteEEprom(INT8U DevID, unsigned short int ADDR, unsigned char DATA, unsigned char Path);
unsigned char ReadEEprom(INT8U DevID, unsigned short int ADDR, unsigned char Path);
unsigned char ReadSDA(unsigned char Path);

extern void ForDelay(unsigned long int count);
extern void  OSTimeDly (INT16U ticks);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

