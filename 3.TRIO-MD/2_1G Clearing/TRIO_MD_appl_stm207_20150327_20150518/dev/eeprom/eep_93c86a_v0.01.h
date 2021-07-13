/******************************************************************************* 
 *
 * This module contains the function EEPROM(AT24C64) related', a function
 * that is called before the `main' function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- MorningIT All rights reserved.
 *
 * $Revision: 0.01 $
 * $Revision date: 2004.05.__
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------
// Instruction | SB | Op Code |     Address             |     Data          |  Comments
//                            |   x 8      |  x 16      |  x 8 | x 16       |
//------------------------------------------------------------------------------
// READ        |  1 |   10    | A10 - A0   | A9 - A0    |                   | Reads data stored in memory,
//             |    |         |            |            |                   | at specified address.
//------------------------------------------------------------------------------
// EWEN        |  1 |   00    | 11XXXXXXXX |11XXXXXXXX  |                   | Write enable must precede all
//             |    |         |            |            |                   | programming modes.
//------------------------------------------------------------------------------
// ERASE       |  1 |   11    | A10 - A0   | A9 - A0    |                   | Erases memory location An - A0.
//------------------------------------------------------------------------------
// WRITE       |  1 |   01    | A10 - A0   | A9 - A0    |D7 - D0 |D15 - D0  | Writes memory location An - A0.
//------------------------------------------------------------------------------
// ERAL        |  1 |   00    | 10XXXXXXXX | 10XXXXXXXX |                   | Erases all memory locations.
//             |    |         |            |            |                   | Valid only at VCC = 4.5V to 5.5V.
//------------------------------------------------------------------------------
// WRAL        |  1 |   00    | 01XXXXXXXX | 01XXXXXXXX |D7 - D0 |D15 - D0  | Writes all memory locations.
//             |    |         |            |            |                   | Valid when VCC = 4.5V to 5.5V and
//             |    |         |            |            |                   | Disable Register cleared.
//------------------------------------------------------------------------------
// EWDS        |  1 |   00    | 00XXXXXXXX | 00XXXXXXXX |                   |Disables all programming instructions.
//------------------------------------------------------------------------------
#define READOP		2
#define EWENOP		0
#define ERASEOP		3
#define WRITEOP 	1
#define ERALOP  	0
#define WRALOP		0
#define EWDSOP		0

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
extern void ForDelay(unsigned long int count);
extern void WatchdogClear(void);

extern void ExpioBitSet (unsigned short int Bitaddr);
extern void ExpioBitRst(unsigned short int Bitaddr);
extern unsigned short int ExpioHardBitRead (unsigned short int Bitaddr);
extern unsigned long int Ser0Printf( const char *format, ... );


////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

