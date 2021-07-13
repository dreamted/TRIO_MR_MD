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
 * Copyright 2006- All rights reserved.
 *
 * $If you use this lib. you modify the pin assignment as your system
 *
 * $Revision: 0.02 $
 * $Revision date: 2004.05.__
 * $Revision date: 2006.01.24
 *               : ReleasEeprom, AccessEeprom Function Deletion because of not requiring. 
 *                 Clean the Sorce File by Seyoung.
 *******************************************************************************/
#include "../include/ucos_ii.h"			// uCOS-ii include
#include "../include/pio_v0.04.h"
#include "../include/7092_v0.03.h"
#include "../include/Rtc_4543Ext.h"
#include "Rtc_4543_v0.01.h"



void Rtc4543Init(void)
{
	// This Fuction should be used after declare pio or expio init function.
	// Write Protecion Enable, Prohibit normal write operation
	// Low SCL, SDA: input access
	//
	Ser0Printf("RTC 4543 Init \n");

	// CE
	PAMRReg->PA2 = __PA2;		// PORT
	PADDRReg->D2 = 0;			// Output
	Rst4543CE();

	// WR Reg Port Declaration
	P7MRReg->P76 = __P76;		// PORT 
	P7DDRReg->D6 = 0;			// Output
	Rst4543WR();

	// CLK Reg Port Declration
	P6MRReg->P60 = __P60;		// PORT
	P6DDRReg->D0 = 0;			// Output
	Rst4543CLK();

	// DATA
	P8MRReg->P81 = __P81;		// PORT
	P8DDRReg->D1 = 1;			// Input;

}
void Set4543WR(void)
{
	P7DRReg->D6 = 1;
	//ForDelay(5);
}

void Rst4543WR(void)
{
	P7DRReg->D6 = 0;
	//ForDelay(5);
}

void Set4543CE(void)
{
	PADRReg->D2 = 1;
	//ForDelay(5);
}

void Rst4543CE(void)
{
	PADRReg->D2 = 0;
	//ForDelay(5);
}

void Set4543CLK(void)
{
	P6DRReg->D0 = 1;
	//ForDelay(5);
}

void Rst4543CLK(void)
{
	P6DRReg->D0 = 0;
	//ForDelay(5);
}

void Set4543DATALine(void)
{
	P8DDRReg->D1 = 0;	// output
	ForDelay(0);
	P8DRReg->D1 = 1;
	//ForDelay(5);
}

void Rst4543DATALine(void)
{
	P8DDRReg->D1 = 0;	// output
	ForDelay(0);
	P8DRReg->D1 = 0;
}

INT8U Read4543DATALine(void)
{

	P8DDRReg->D1 = 1;	// Input
	ForDelay(0);
	return(P8DRReg->D1);
}


INT8U Read4543Time(Rtc4543Time *nTime)
{
//////////////////////////////////////////////////////
	Rst4543WR();	// Read Mode
	Set4543CE();	// Chip Enable

	
	// Second Low
	nTime->Seconds = (Read4543Data() & 0x0f);
	// Second High
	nTime->Seconds += ((Read4543Data() & 0x07) * 10);

	// Min Low
	nTime->Minutes = (Read4543Data() & 0x0f);
	// Min High
	nTime->Minutes += ((Read4543Data() & 0x07) * 10);


	// Hour Low
	nTime->Hour = (Read4543Data() & 0x0f);
	// Hour High
	nTime->Hour += ((Read4543Data() & 0x03) * 10);

	// Week
	nTime->Week = (Read4543Data() & 0x07);
	
	// Day Low
	nTime->Day = (Read4543Data() & 0x0f);
	// Day High
	nTime->Day += ((Read4543Data() & 0x03) * 10);

	// Month Low
	nTime->Month = (Read4543Data() & 0x0f);
	// Month High
	nTime->Month += ((Read4543Data() & 0x01) * 10);

	// Year Low
	nTime->Year = (Read4543Data() & 0x0f);
	// Year High
	nTime->Year += ((Read4543Data() & 0x0f) * 10);


	Rst4543CE();	// disable 
	Rst4543WR();	// Init(Low)
	Rst4543CLK();	// 

	return TRUE;
}

INT8U Read4543Data(void)
{
	INT8U Data = 0, i = 0;

	for(; i < 4; i++)
	{
        Data >>= 1;
        Set4543CLK();	  
        if(Read4543DATALine()) Data |= 0x08;
        Rst4543CLK();
	}
	return Data;
}
void Write4543Data(INT8U Data)
{
	INT8U i = 0;
	
	for(i = 0; i < 4; i++)
	{
		if(Data & 0x01) Set4543DATALine();
		else			Rst4543DATALine();
		Set4543CLK();
		Rst4543CLK();
		Data >>= 1;
	}
}
void Write4543Time(Rtc4543Time *nTime)
{
	INT8U Data;
	// Start Condition
//////////////////////////////////////////////////////

	//OS_ENTER_CRITICAL();
	
	Set4543WR();	// Write Mode
	Set4543CE();	// Chip Enable

	
	// Second Low
	Data = (nTime->Seconds%10) & 0x0f;
	Write4543Data(Data);
	// Second High
	Data = (nTime->Seconds/10) & 0x07;
	Write4543Data(Data);

	// Min Low
	Data = (nTime->Minutes%10) & 0x0f;
	Write4543Data(Data);
	// Min High
	Data = (nTime->Minutes/10) & 0x07;
	Write4543Data(Data);

	// Hour Low
	Data = (nTime->Hour%10) & 0x0f;
	Write4543Data(Data);
	// Hour High
	Data = (nTime->Hour/10) & 0x03;
	Write4543Data(Data);

	// Week
	Data = nTime->Week & 0x07;
	Write4543Data(Data);
	
	// Day Low
	Data = (nTime->Day%10) & 0x0f;
	Write4543Data(Data);
	// Day High
	Data = (nTime->Day/10) & 0x03;
	Write4543Data(Data);

	// Month Low
	Data = (nTime->Month%10) & 0x0f;
	Write4543Data(Data);
	// Month High
	Data = (nTime->Month/10) & 0x01;
	Write4543Data(Data);

	// Year Low
	Data = (nTime->Year%10) & 0x0f;
	Write4543Data(Data);
	// Year High
	Data = (nTime->Year/10) & 0x0f;
	Write4543Data(Data);

	Rst4543CE();	// disable 
	Rst4543WR();	// Init(Low)
	Rst4543CLK();	// 

	//OS_EXIT_CRITICAL();
	
}


////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

