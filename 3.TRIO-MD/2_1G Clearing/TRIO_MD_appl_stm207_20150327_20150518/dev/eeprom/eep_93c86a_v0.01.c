/*******************************************************************************
 *
 * This module contains the function EEPROM(AT24C64) related, a function
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
 ******************************************************************************/
//#define EEPROM_C

#include "../include/ucos_ii.h"	// uCOS-ii include
#include "../include/pio_v0.04.h"
#include "../include/7092_v0.03.h"
#include "../include/at93c86ext.h"
#include "eep_93c86a_v0.01.h"


void EEp93C86AInit(AT93C86Str *_ePtr, INT16U _CS, INT16U _SK, INT16U _DI, INT16U _DO)
{
	// This Fuction should be used after declare pio or expio init function.
	// Write Protecion Enable, Prohibit normal write operation
	// Low SCL, SDA: input access
	//
	Ser0Printf("Eeprom AT93C86A Init\n");
	
	_ePtr->_CS = _CS;
	_ePtr->_SK = _SK;
	_ePtr->_DI = _DI;
	_ePtr->_DO = _DO;

	// Initialize AT93Cxx control lines
	ExpioBitSet(_CS);
	ExpioBitRst(_CS);

	ExpioBitSet(_SK);
	ExpioBitRst(_SK);
	
	ExpioBitRst(_DI);
	ExpioBitSet(_DI);
	
	//RstSCL();
	//DisableWriteEEprom();
}

//EWEN 1 00 11XXXXXXXX :Write enable must precede all programming modes.

void EWEN93C86A(AT93C86Str *_ePtr)
{

	ExpioBitSet(_ePtr->_CS);

	SetOPCode(_ePtr, EWENOP);
	SetAddr(_ePtr, 0x600);

	ExpioBitRst(_ePtr->_CS);
}

void EWDS93C86A(AT93C86Str *_ePtr)
{

	ExpioBitSet(_ePtr->_CS);
	SetOPCode(_ePtr, EWDSOP);
	SetAddr(_ePtr, 0);
	ExpioBitRst(_ePtr->_CS);
}


void Write93C86A(AT93C86Str *_ePtr, INT16U ADDR, INT8U DATA)
{
	INT8U i = 0;

	EWEN93C86A(_ePtr);

	ExpioBitSet(_ePtr->_CS);
	SetOPCode(_ePtr, WRITEOP);

	SetAddr(_ePtr, ADDR);


	/////////////////////////////////////////////
	// Write Operation
	for(i = 0; i < 8; i++)
	{
		WatchdogClear();

		if(DATA & 0x80)	ExpioBitSet(_ePtr->_DI);
		else			ExpioBitRst(_ePtr->_DI);
		ExpioBitSet(_ePtr->_SK);
		ExpioBitRst(_ePtr->_SK);
		DATA <<= 1;
	}
	ExpioBitRst(_ePtr->_CS);
	ExpioBitSet(_ePtr->_CS);

	OSTimeDly(4);
	// Initialization
	ExpioBitRst(_ePtr->_CS);
	ExpioBitRst(_ePtr->_SK);
	ExpioBitSet(_ePtr->_DI);
	EWDS93C86A(_ePtr);

}

void SetOPCode(AT93C86Str *_ePtr, INT8U dpl)
{
	INT8U i = 0;

	ExpioBitSet(_ePtr->_DI);
	ExpioBitSet(_ePtr->_SK);
	ExpioBitRst(_ePtr->_SK);
	
	for(i = 0; i < 2; i++)
	{
		if(dpl & 0x02)	ExpioBitSet(_ePtr->_DI);
		else			ExpioBitRst(_ePtr->_DI);
		ExpioBitSet(_ePtr->_SK);
		ExpioBitRst(_ePtr->_SK);
		dpl <<= 1;
	}
}

void SetAddr(AT93C86Str *_ePtr, INT16U ADDR)
{

	INT16U i = 0, bMask = 0x0400;
	
	for(i = 0; i < 11; i++)
	{
		WatchdogClear();
		if(ADDR & bMask)	ExpioBitSet(_ePtr->_DI);
		else				ExpioBitRst(_ePtr->_DI);
		ExpioBitSet(_ePtr->_SK);
		ExpioBitRst(_ePtr->_SK);
		ADDR <<= 1;
	}
}

INT8U Read93C86A(AT93C86Str *_ePtr, INT16U ADDR)
{
	INT8U i = 0;
	INT8U eData = 0;

	// Start Condition
	///////////////////////////////////////////////////////
	// Device Address Writing
	// Enable
	ExpioBitSet(_ePtr->_CS);

	SetOPCode(_ePtr, READOP);
	SetAddr(_ePtr, ADDR);

	/////////////////////////////////////////////
	// Read Operation
	for(i = 0; i < 8; i++)
	{
		WatchdogClear();
		eData <<= 1;

		ExpioBitSet(_ePtr->_SK);
		if(ExpioHardBitRead(_ePtr->_DO))	eData |= 1;
		ExpioBitRst(_ePtr->_SK);
	}
	ExpioBitRst(_ePtr->_CS);
	ExpioBitRst(_ePtr->_SK);
	ExpioBitSet(_ePtr->_DI);
	
	return eData;

}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

