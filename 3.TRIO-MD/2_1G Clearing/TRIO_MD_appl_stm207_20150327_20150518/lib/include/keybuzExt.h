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
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 * $Revision: 0.2 $
 * $Revision date: 2007.07.21
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
#define _KEYBUZZ

#define keyMENU		0x0001
#define keyUP		0x0002
#define keyDOWN		0x0004
#define keyENTR		0x0008
#define keyESC		0x0010
#define Key20		0x0020
#define Key40		0x0040
#define Key80		0x0080

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////
// Prototype Definition
///////////////
void KeyBuzInit (INT16U bAddr);
void CheckBuzzTimer(void);
void Key5BufferClear(void);

unsigned char IsKey5Pushed(INT8U DataNum);
unsigned char ReadKey5Buffer(void);

signed char KeyDetecting (void);


void BuzzPortOff ( void );
void BuzzShort ( void );
void BuzzReject ( void );
void BuzzMedium ( void );
void BuzzLong ( void );

////////////////////////////////////////////////////////////////////////////////
// End Of Header File
//////////////////////

