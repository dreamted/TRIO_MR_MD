/*******************************************************************************
 *
 * This module contains the function HMS39C7092 EEPROM(AT24C64) related, a function
 * that is called before the 'main' function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2008- bizistyle(bgyoon@naver.com), All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2008.06
 ******************************************************************************/

#include "../include/eepext.h"
#include "lib_24c64_1208.h"

//#define EEp_debug
unsigned long int USART1Printf( const char *format, ... );

unsigned long int (*eprintf)( const char *format, ... ) = USART1Printf;

void EEpromInit(void)
{

	// This Fuction should be used after declare pio or expio init function.
	// Write Protecion Enable, Prohibit normal write operation
	// Low SCL, SDA: input access
    RCC->__B.AHB1ENR.IOPBEN = ENABLE;
	
	// Port Initialization - In
	// SCL
	__PB6_PP_PP();
	// SDA
	__PB9_IN_PU();
	RstSCL(0);
	
	// Port Initialization - Out
	// SCL
	//__PA14_PP_PP();
	// SDA
	//__PE2_IN_PU();
	//RstSCL(1);
}

INT16S WriteEEprom(INT8U DevID, INT16U ADDR, INT8U Data, INT8U Path)
{
	INT8U cnt = EEpromWrTry;
	INT8U rVal = 0;
	INT16S pVal = (Data & 0xff);
	// 0: Write Fail
	// 1: Write Success
	//INT8U tmpDevAddr = (At24cDevID << 4) | ((ADDR/At24CMaxNo) << 1);
//	eprintf("ADDR: %d [%d] \n", ADDR,Data);

	rVal = Write_EEprom_16Addr_8Data(DevID, ADDR, Data, Path);

	if(!rVal) return -1;

	// Confirm Data
	while(cnt--)
	{
		OSTimeDly(1);
		if(Read_EEprom_16Addr_8Data(DevID, ADDR, Path) == pVal) return pVal;
	}
	return Data;
}

INT8U ReadEEprom(INT8U DevID, INT16U ADDR, INT8U Path)
{
//	INT8U tmpDevAddr = (At24cDevID << 4) | ((ADDR/At24CMaxNo) << 1);

//	ADDR %= At24CMaxNo;

	return Read_EEprom_16Addr_8Data(DevID, ADDR, Path);
}

INT8U Write_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data, INT8U Path)
{
	INT8U cnt = EEpromWrTry;
	// Start Condition
	// Write Protection Disable, Allows normal write operation
	//
	// output 1(SDATA)
	// START Conditon making
	while(cnt--)
	{
		StartEEprom(Path);
		WriteEEpromData(DevAddr & (~0x01), Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK((0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr >> 8), Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK(1): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr     ), Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData(Data, Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		StopEEprom(Path);

		return TRUE;
	}
	return FALSE;
}


INT16S Read_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Path)
{
	INT8U cnt = EEpromWrTry;
	INT8U rVal = 0;

	// Device Address Writing
	while(cnt--)
	{

		StartEEprom(Path);
		WriteEEpromData(DevAddr & (~0x01), Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK(0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr >> 8), Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK(1): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr     ), Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		StartEEprom(Path);
		WriteEEpromData((DevAddr | 0x01), Path);
		#ifndef EEp_debug
			if(ACKEEprom(Path)) continue;
		#else
		{
			INT8U _Ack = ACKEEprom(Path);
			eprintf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		rVal = ReadEEpromData(Path);

		NACKEEprom(Path);
	 	StopEEprom(Path);

		return (rVal & 0xff);
	}
	return -1;
}

INT8U ACKEEprom(INT8U Path)
{
	INT8U Data;

 	SetSDAInMode(Path);
	// ACK Check
	SetSCL(Path);
	Data = ReadSDA(Path);
	RstSCL(Path);
	return Data;
}

void NACKEEprom(INT8U Path)
{
	// NACK
 	SetSDAOutMode(Path);

	SetSDA(Path);
	SetSCL(Path);
	RstSCL(Path);
}

void WriteEEpromData(INT8U Data, INT8U Path)
{
	INT8U i = 0;

 	SetSDAOutMode(Path);

	RstSCL(Path);
	for(i = 0; i < 8; i++)
	{
		if((Data & 0x80)) 	SetSDA(Path);
		else				RstSDA(Path);
		SetSCL(Path);
		RstSCL(Path);
		Data <<= 1;
	}
}

INT8U ReadEEpromData(INT8U Path)
{
	INT8U Data = 0, i = 0;

	SetSDAInMode(Path);

	for(i = 0; i < 8; i++)
	{
        Data = (Data << 1);
        SetSCL(Path);
        if(ReadSDA(Path))	Data |= 0x01;
        RstSCL(Path);
	}
	return Data;
}


void StartEEprom(INT8U Path)
{
	// START Conditon making
	SetSDAOutMode(Path);

	SetSDA(Path);

	SetSCL(Path);
	RstSDA(Path);
	RstSCL(Path);

}
void StopEEprom(INT8U Path)
{
	// STOP
	SetSDAOutMode(Path);

	RstSDA(Path);
	SetSCL(Path);
	SetSDA(Path);
	RstSCL(Path);
}

void SetSDAInMode(INT8U Path)
{
	if(Path == 0)	__PB9_IN_FL();
	else			__PE2_IN_FL();
}

void SetSDAOutMode(INT8U Path)
{
	if(Path == 0)	__PB9_PP_PP();
	else			__PE2_PP_PP();
}

void SetSCL(INT8U Path)
{
	if(Path == 0)	{GPIOB->__B.ODR.B6 = SET; CLKDELAY;}
	else			{GPIOA->__B.ODR.B14 = SET; CLKDELAY;}
}
void RstSCL(INT8U Path)
{
	if(Path == 0)	{GPIOB->__B.ODR.B6 = RESET; CLKDELAY;}
	else			{GPIOA->__B.ODR.B14 = RESET; CLKDELAY;}
}

void SetSDA(INT8U Path)
{
	if(Path == 0)	{GPIOB->__B.ODR.B9 = SET; CLKDELAY;}
	else			{GPIOE->__B.ODR.B2 = SET; CLKDELAY;}
}

void RstSDA(INT8U Path)
{
	if(Path == 0)	{GPIOB->__B.ODR.B9 = RESET; CLKDELAY;}
	else			{GPIOE->__B.ODR.B2 = RESET; CLKDELAY;}
}
INT8U ReadSDA(INT8U Path)
{
	INT8U	RetVal;
/////////////////////////////////////////	
	if(Path == 0)
	{
		CLKDELAY;	RetVal = GPIOB->__B.IDR.B9;
	}
	else
	{
		CLKDELAY2;	RetVal = GPIOE->__B.IDR.B2;
	}
	
	return	RetVal;
}
void EnableWriteEEprom(void)
{
	// Low
}
void DisableWriteEEprom(void)
{
	// High
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

