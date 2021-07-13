/*******************************************************************************
 *
 * This module contains the function 'Expio-TLV56xx', a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bgyoon(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.07.__
 * $Revision date: 2006.08.12
 *          : TLV5610 Control Error Correction, by bgyoon
 *
 ******************************************************************************/
#include "../include/ucos_ii.h" // uCOS-ii include
#include "../include/pio_v0.04.h"
#include "../include/7092_v0.03.h"
#include "../include/dacExt.h"
#include "Tlv5610_v0.02.h"

void InitTlv5610(Tlv5610Str *ePtr, INT16U _FS, INT16U _SCLK, INT16U _DIN, INT16U _LDAC)
{

	//Ser0Printf("Tlv56xx Init() \n");
	
	ePtr->_FS = _FS;
	ePtr->_SCLK = _SCLK;
	ePtr->_DIN = _DIN;
	ePtr->_LDAC = _LDAC;

	ExpioBitSet(_FS);
	ExpioBitSet(_SCLK);
	
	ExpioBitSet(_DIN);
	ExpioBitSet(_LDAC);

	DacWriteTlv5610(ePtr, 8, 0x0000);	// Normal, No Digital Output, Straight Binary Mode
	DacWriteTlv5610(ePtr, 9, 0x000F);	// On : 0,1,2,3 ,, Fast Mode

}

void DacWriteTlv5608(Tlv5610Str *ePtr, INT8U Channel, INT16U uiValue)
{
	unsigned char i =0;
	_TLV56xxReg Reg;

	Reg.Data = 0;

	Reg._5608Bit.DACVal = uiValue;
	Reg._5608Bit.A = Channel;

	ExpioBitRst(ePtr->_FS);

	for (i = 0; i < 16; i++)
	{
		if((Reg.Data & 0x8000) == 0x8000)	ExpioBitSet(ePtr->_DIN);
		else								ExpioBitRst(ePtr->_DIN);

		ExpioBitRst(ePtr->_SCLK);
		ExpioBitSet(ePtr->_SCLK);
		Reg.Data <<= 1;
	}

	ExpioBitSet(ePtr->_FS);
	ExpioBitRst(ePtr->_LDAC);
	ExpioBitSet(ePtr->_LDAC);
}

void DacWriteTlv5610(Tlv5610Str *ePtr, INT8U Channel, INT16U uiValue)
{
	unsigned char i =0;
	_TLV56xxReg Reg;

	Reg.Data = 0;

	Reg._5610Bit.DACVal = uiValue;
	Reg._5610Bit.A = Channel;

	ExpioBitRst(ePtr->_FS);

	for (i = 0; i < 16; i++)
	{
		if((Reg.Data & 0x8000) == 0x8000)	ExpioBitSet(ePtr->_DIN);
		else								ExpioBitRst(ePtr->_DIN);
		ExpioBitRst(ePtr->_SCLK);
		ExpioBitSet(ePtr->_SCLK);
		Reg.Data <<= 1;
	}
	ExpioBitSet(ePtr->_FS);
	ExpioBitRst(ePtr->_LDAC);
	ExpioBitSet(ePtr->_LDAC);
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

