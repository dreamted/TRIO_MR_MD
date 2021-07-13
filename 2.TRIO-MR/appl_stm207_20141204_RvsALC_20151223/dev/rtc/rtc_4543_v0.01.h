/******************************************************************************* 
 *
 * This module contains the function EEPROM(AT24C64) related', a function
 * that is called before the 'main' function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bizisytle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.02 $
 * $Revision date: 2004.05.__
 * $Revision date: 2006.01.24
 *               : ReleasEeprom, AccessEeprom Function Deletion because of not requiring. 
 *                 Clean the Source File by Seyoung.
 * $Revision date: 2006.05.20
 *               : separate from ~ext.h, .h
 *                 by bgyoon 
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void Rtc4543Init(void);
void Set4543WR(void);
void Rst4543WR(void);
void Set4543CE(void);
void Rst4543CE(void);
void Set4543CLK(void);
void Rst4543CLK(void);
void Set4543DATALine(void);
void Rst4543DATALine(void);

void Write4543Time(Rtc4543Time *nTime);
void Write4543Data(INT8U Data);

INT8U Read4543Data(void);
INT8U Read4543DATALine(void);

extern void ForDelay(unsigned long int count);
extern unsigned long int Ser0Printf( const char *format, ... );

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

