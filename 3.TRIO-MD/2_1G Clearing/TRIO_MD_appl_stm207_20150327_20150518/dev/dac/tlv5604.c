/*******************************************************************************
 *
 * This module contains the function 7202 original source file, a function
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
 ******************************************************************************/

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

#include "../include/ucos_ii.h"			// uCOS-ii include
#include "../include/pio_v0.04.h"
#include "../include/7092_v0.03.h"
#include "../include/dacExt.h"

#include "tlv5604.h"

typedef union {
	INT16U Data;

	#define FastMode	1
	#define SlowMode	0

	#define PwrDn		1
	#define NorOper 	0

	struct{
		INT16U			:2;
		INT16U	DACVal	:10;
		INT16U	SPD		:1;
		INT16U	PWR		:1;
		INT16U	A		:2;

	} CtrlBit;

} _TLV1505Reg;

////////////////////////////////////////////////////////////////////////////////

_TLV5604Str TLV5604PtrB;
_TLV5604Str *TLV5604Ptr = &TLV5604PtrB;

void TLV5604Init
    (void (*Set_LDAC)(void), void (*Rst_LDAC)(void), 
     void (*Set_CLK)(void), void (*Rst_CLK)(void),
     void (*Set_SDIN)(void), void (*Rst_SDIN)(void),
     void (*Set_FSIN)(void), void (*Rst_FSIN)(void),
	 void (*Set_CS)(void), void (*Rst_CS)(void))
{

	TLV5604Ptr->Set_LDAC = Set_LDAC;
	TLV5604Ptr->Rst_LDAC = Rst_LDAC;
	TLV5604Ptr->Set_CLK = Set_CLK;
	TLV5604Ptr->Rst_CLK = Rst_CLK;
	TLV5604Ptr->Set_SDIN = Set_SDIN;
	TLV5604Ptr->Rst_SDIN = Rst_SDIN;
	TLV5604Ptr->Set_FSIN = Set_FSIN;
	TLV5604Ptr->Rst_FSIN = Rst_FSIN;
	TLV5604Ptr->Set_CS = Set_CS;
	TLV5604Ptr->Rst_CS = Rst_CS;

}

INT16U TLV5604DACOut(INT8U Index, INT16U Data)
{
	INT16U i = 0;
	INT16U RetVal;
	_TLV1505Reg	Reg;

	Reg.Data = 0;

	Reg.CtrlBit.PWR = NorOper;
	Reg.CtrlBit.SPD = FastMode;
	Reg.CtrlBit.DACVal = Data;
	Reg.CtrlBit.A = Index;

	RetVal = Reg.Data;
	
 	// Initalize
 	TLV5604Ptr->Rst_LDAC(); // UPDATE ENABLE
	ForDelay(3);
	TLV5604Ptr->Set_CLK();
	ForDelay(3);
	TLV5604Ptr->Rst_CS();
	ForDelay(3);
	TLV5604Ptr->Rst_FSIN();
	ForDelay(3);
  
	for(i = 0; i < 16; i++)
	{
		if((Reg.Data & 0x8000) == 0x8000)	TLV5604Ptr->Set_SDIN();
		else								TLV5604Ptr->Rst_SDIN();
		Reg.Data <<= 1;
		
		ForDelay(3);
		TLV5604Ptr->Rst_CLK();
		ForDelay(3);
		TLV5604Ptr->Set_CLK();	// Clock
		ForDelay(3);
	}
	TLV5604Ptr->Set_FSIN();
	ForDelay(3);
	TLV5604Ptr->Set_CS();
	ForDelay(3);
 	TLV5604Ptr->Set_LDAC(); // UPDATE DISABLE
	ForDelay(3);

	return RetVal;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
//////////////////////

