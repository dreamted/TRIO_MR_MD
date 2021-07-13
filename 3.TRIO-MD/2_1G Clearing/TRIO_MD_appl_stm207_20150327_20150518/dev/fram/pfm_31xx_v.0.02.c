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
 * $Revision: 0.02 $
 * $Revision date: 2004.05.__
 * $Revision date: 2006.01.24
 *               : ReleasEeprom, AccessEeprom Function Deletion because of not requiring. 
 *                 Clean the Sorce File by Seyoung.
 *******************************************************************************/
#include "../include/ucos_ii.h"	// uCOS-ii include
#include "../include/pio_v0.04.h"
#include "../include/7092_v0.03.h"
#include "../include/pfm_31xxExt.h"
#include "pfm_31xx_v.0.02.h"

//#define pFM31xx_debug
void pFM31xxInit(void)
{
	// This Fuction should be used after declare pio or expio init function.
	// Write Protecion Enable, Prohibit normal write operation
	// Low SCL, SDA: input access
	//
	Ser0Printf("pFM31xxInit Init(v0.02)\n");

	// Port Initialization
	// SCL
	P7MRReg->P76 = __P76;		// PORT
	P7DDRReg->D6 = 0;			// Output

	// SDA
	P7MRReg->P77 = __P77;		// PORT 
	P7DDRReg->D7 = 1;			// Input

	RstpFM31xxSCL();
	pFM31xxSetOSCEn();			// Osc Enable
	pFM31xxSetCALMODE(TRUE);	// Cal Mode Disable
	pFM31xxSetBatteryCharge(__VBAKCHARGEDIS);	// battery char disable
	
}

void pFM31xxSetTime(_F31xxTime *nTime)
{
	_F31xxReg RtcReg, Reg;

	// Set TIME SET
	RtcReg.Data = ReadpFM31xxRegister(_F31xxRTCCtrl);
	RtcReg._F31xxRTCCtrlBit.W = __W;	// Write Mode
	WritepFM31xxRegister(_F31xxRTCCtrl, RtcReg.Data);

	// Seconds
	Reg._F31xxSecondsBit.Second1 = nTime->Seconds%10;
	Reg._F31xxSecondsBit.Second10 = nTime->Seconds/10;
	WritepFM31xxRegister(_F31xxSeconds, Reg.Data);

	// Min
	Reg._F31xxMinuitesBit.Minute1 = nTime->Minutes%10;
	Reg._F31xxMinuitesBit.Minute10 = nTime->Minutes/10;
	WritepFM31xxRegister(_F31xxMinuites, Reg.Data);

	// Hour
	Reg._F31xxHoursBit.Hour1 = nTime->Hour%10;
	Reg._F31xxHoursBit.Hour10 = nTime->Hour/10;
	WritepFM31xxRegister(_F31xxHours, Reg.Data);

	// Week
	Reg._F31xxWeekBit.Week = nTime->Week;
	WritepFM31xxRegister(_F31xxWeek, Reg.Data);
	
	// Date
	Reg._F31xxDateBit.Date1 = nTime->Date%10;
	Reg._F31xxDateBit.Date10 = nTime->Date/10;
	WritepFM31xxRegister(_F31xxDate, Reg.Data);
	
	// Month
	Reg._F31xxMonthBit.Month1 = nTime->Month%10;
	Reg._F31xxMonthBit.Month10 = nTime->Month/10;
	WritepFM31xxRegister(_F31xxMonth, Reg.Data);

	// Year
	Reg._F31xxYearsBit.Year1 = nTime->Year%10;
	Reg._F31xxYearsBit.Year10 = nTime->Year/10;
	WritepFM31xxRegister(_F31xxYears, Reg.Data);

	// Write TIME REALEASE
	RtcReg._F31xxRTCCtrlBit.W = 0;	// Write Mode Release
    WritepFM31xxRegister(_F31xxRTCCtrl, RtcReg.Data);

}


void pFM31xxGetTime(_F31xxTime *nTime)
{
	_F31xxReg Reg;

	// READ TIME SET
	Reg.Data = ReadpFM31xxRegister(_F31xxRTCCtrl);
	Reg._F31xxRTCCtrlBit.R = __R;	// Read Mode
	WritepFM31xxRegister(_F31xxRTCCtrl, Reg.Data);
	OSTimeDly(10);
	// READ TIME REALEASE
	Reg._F31xxRTCCtrlBit.R = 0;	// Read Mode
    WritepFM31xxRegister(_F31xxRTCCtrl, Reg.Data);

	// Sec
	Reg.Data = ReadpFM31xxRegister(_F31xxSeconds);
	nTime->Seconds = (Reg._F31xxSecondsBit.Second10 * 10) + (Reg._F31xxSecondsBit.Second1);

	// Min
	Reg.Data = ReadpFM31xxRegister(_F31xxMinuites);
	nTime->Minutes = (Reg._F31xxMinuitesBit.Minute10 * 10) + (Reg._F31xxMinuitesBit.Minute1);

	// Hour
	Reg.Data = ReadpFM31xxRegister(_F31xxHours);
	nTime->Hour = (Reg._F31xxHoursBit.Hour10 * 10) + (Reg._F31xxHoursBit.Hour1);

	// Week
	Reg.Data = ReadpFM31xxRegister(_F31xxWeek);
	nTime->Week = (Reg._F31xxWeekBit.Week);

	// Day
	Reg.Data = ReadpFM31xxRegister(_F31xxDate);
	nTime->Date= (Reg._F31xxDateBit.Date10 * 10)+ (Reg._F31xxDateBit.Date1);

	// Month
	Reg.Data = ReadpFM31xxRegister(_F31xxMonth);
	nTime->Month = (Reg._F31xxMonthBit.Month10 * 10) + (Reg._F31xxMonthBit.Month1);

	// Year
	Reg.Data = ReadpFM31xxRegister(_F31xxYears);
	nTime->Year = (Reg._F31xxYearsBit.Year10 * 10) + (Reg._F31xxYearsBit.Year1);
	
}
////////////////////////////////////////////////////////////////////////////////
// Function
///////////
void pFM31xxSetOSCEn(void)
{
	_F31xxReg Reg;
	Reg.Data = ReadpFM31xxRegister(_F31xxCALCtrl);
	Reg._F31xxCALCtrlBit.OSCEN = __OSCEN;
	WritepFM31xxRegister(_F31xxCALCtrl, Reg.Data);
}

void pFM31xxSetBatteryCharge(INT8U nEnable)
{
	_F31xxReg Reg;
	if(nEnable) nEnable = TRUE;
	
	Reg.Data = ReadpFM31xxRegister(_F31xxCompanionCtrl);
	Reg._F31xxCompanionCtrlBit.VBC = nEnable;
	WritepFM31xxRegister(_F31xxCompanionCtrl, Reg.Data);

}

void pFM31xxSetCALMODE(INT8U nEnable)
{
	_F31xxReg Reg;
	if(nEnable) nEnable = TRUE;
	
	Reg.Data = ReadpFM31xxRegister(_F31xxRTCCtrl);
	Reg._F31xxRTCCtrlBit.CAL = nEnable;
	WritepFM31xxRegister(_F31xxRTCCtrl, Reg.Data);
}

INT8U pFM31xxSetCalData(INT8U Data)
{
	_F31xxReg Reg;
	Reg.Data = ReadpFM31xxRegister(_F31xxCALCtrl);
	Reg._F31xxCALCtrlBit.CAL = Data;
	WritepFM31xxRegister(_F31xxCALCtrl, Reg.Data);

	if(Reg.Data == ReadpFM31xxRegister(_F31xxCALCtrl)) return TRUE;
	return FALSE;

}

INT8U ReadpFM31xxRegister(INT8U Addr)
{
	return (Read_pFM31xx_8Addr_8Data(ComDevID, Addr));
}

void WritepFM31xxRegister(INT8U Addr, INT8U Data)
{
	Write_pFM31xx_8Addr_8Data(ComDevID, Addr, Data);
}

void pFM31xxRegisterFullRead(void)
{
	INT8U Data, i = 0;
	
	for(; i < _F31xxMaxRegNo; i++)
	{
		Data = ReadpFM31xxRegister(i);
		Ser0Printf("Register %02xh = %02xh\n", i, Data);
	}
}
INT8S pFM31xxFRAMFullTest(void)
{
	INT8U Data = 0;
	INT16U	i = 0;	

	for(i = 0; i < FM31256Addr; i++)
	{
		if(!WritepFM31xxFRAM(i, i))
		{
			Ser0Printf("Write Fail: ACK Addr: %04x\n", i);
			return -1;
		}
		Data = ReadpFM31xxFRAM(i);
		//Ser0Printf("Data: %02x, Addr: %04x \n", Data, i);
		if(Data != (INT8U)i)
		{
			Ser0Printf("error, Data: %02x, Addr: %04x \n", Data, i);
			return	0;
		}
	}
	return TRUE;
}

INT8U WritepFM31xxFRAM(INT16U Addr, INT8U Data)
{
	// 0: Write Fail
	// 1: Write Success
	return (Write_pFM31xx_16Addr_8Data(MemDevID, Addr, Data));
}

INT8U ReadpFM31xxFRAM(INT16U Addr)
{
	return Read_pFM31xx_16Addr_8Data(MemDevID, Addr);
}
////////////////////////////////////////////////////////////////////////////////
// Default Read/Write, Access F31xx Series
//////////////////////////////////////////
void SetFM31xxSDAInMode(void)
{
	P7DDRReg->D7 = 1;	// output
}

void SetFM31xxSDAOutMode(void)
{
	P7DDRReg->D7 = 0;	// output
}

void SetpFM31xxSDA(void)
{
	P7DRReg->D7 = 1;	// Output
}

void RstpFM31xxSDA(void)
{
	P7DRReg->D7 = 0;			// Output
 }

void SetpFM31xxSCL(void)
{
	P7DRReg->D6 = 1;
}

void RstpFM31xxSCL(void)
{
	P7DRReg->D6 = 0;
}

INT8U ReadpFM31xxSDA(void)
{
 	return(P7DRReg->D7);
}

void StartpFM31xx(void)
{
	// START Conditon making
 	SetFM31xxSDAOutMode();

	SetpFM31xxSDA();
	
	SetpFM31xxSCL();
	RstpFM31xxSDA();
	RstpFM31xxSCL();

}
void StoppFM31xx(void)
{
	// STOP
 	SetFM31xxSDAOutMode();
	
	RstpFM31xxSDA();	
	SetpFM31xxSCL();
 	SetpFM31xxSDA();
}

INT8U ACKpFM31xx(void)
{
	INT8U Data;

 	SetFM31xxSDAInMode();
	// ACK Check
	SetpFM31xxSCL();
	Data = ReadpFM31xxSDA();
	RstpFM31xxSCL();
	return Data;
}

void NACKpFM31xx(void)
{
	// NACK
 	SetFM31xxSDAOutMode();
	
	SetpFM31xxSDA();
	SetpFM31xxSCL();
	RstpFM31xxSCL();
}


void WritepFM31xxData(INT8U Data)
{
	INT8U i = 0;

 	SetFM31xxSDAOutMode();

	RstpFM31xxSCL();
	for(i = 0; i < 8; i++)
	{
		if((Data & 0x80)) 	SetpFM31xxSDA();
		else				RstpFM31xxSDA();
		SetpFM31xxSCL();
		RstpFM31xxSCL();
		Data <<= 1;
	}
}

INT8U ReadpFM31xxData(void)
{
	INT8U Data = 0, i = 0;

	SetFM31xxSDAInMode();

	for(i = 0; i < 8; i++)
	{
        Data = (Data << 1);
        SetpFM31xxSCL();
        if(ReadpFM31xxSDA())	Data |= 0x01;
        RstpFM31xxSCL();
	}	
	return Data;
}

INT8U Write_pFM31xx_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data)
{
	INT8U cnt = pFMWrTry;
	// Start Condition
	// Write Protection Disable, Allows normal write operation
	// 
	// output 1(SDATA)
	// START Conditon making
	while(cnt--)
	{
		StartpFM31xx();
		WritepFM31xxData(DevAddr & (~0x01));
		#ifndef pFM31xx_debug
			if(ACKpFM31xx()) continue;
		#else
		{
			INT8U _Ack = ACKpFM31xx();
			Ser0Printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepFM31xxData((INT8U)(Addr >> 8));
		#ifndef pFM31xx_debug
			if(ACKpFM31xx()) continue;
		#else
		{
			INT8U _Ack = ACKpFM31xx();
			Ser0Printf("ACK: %d \n", _Ack);
		}
		#endif	
		WritepFM31xxData((INT8U)(Addr     ));
		#ifndef pFM31xx_debug
			if(ACKpFM31xx()) continue;
		#else
		{
			INT8U _Ack = ACKpFM31xx();
			Ser0Printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepFM31xxData(Data);
		#ifndef pFM31xx_debug
			if(ACKpFM31xx()) continue;
		#else
		{
			INT8U _Ack = ACKpFM31xx();
			Ser0Printf("ACK: %d \n", _Ack);
		}
		#endif
		StoppFM31xx();

		return TRUE;
	}
	return FALSE;
}

INT8U Write_pFM31xx_8Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data)
{
	INT8U cnt = pFMWrTry;

	while(cnt--)
	{
		StartpFM31xx();
		WritepFM31xxData(DevAddr & (~0x01));
		#ifndef pFM31xx_debug
			if(ACKpFM31xx()) continue;
		#else
		{
			INT8U _Ack = ACKpFM31xx();
			Ser0Printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepFM31xxData(Addr);
		#ifndef pFM31xx_debug
			if(ACKpFM31xx()) continue;
		#else
		{
			INT8U _Ack = ACKpFM31xx();
			Ser0Printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepFM31xxData(Data);
		#ifndef pFM31xx_debug
			if(ACKpFM31xx()) continue;
		#else
		{
			INT8U _Ack = ACKpFM31xx();
			Ser0Printf("ACK: %d \n", _Ack);
		}
		#endif
		StoppFM31xx();

		return TRUE;
	}
	return FALSE;
}

INT8U Read_pFM31xx_16Addr_8Data(INT8U DevAddr, INT16U Addr)
{
	INT8U rVal = 0;
	
	// Device Address Writing
	StartpFM31xx();
	WritepFM31xxData(DevAddr & (~0x01));
	#ifndef pFM31xx_debug
		ACKpFM31xx();
	#else
	{
		INT8U _Ack = ACKpFM31xx();
		Ser0Printf("ACK: %d \n", _Ack);
	}
	#endif
	WritepFM31xxData((INT8U)(Addr >> 8));
	#ifndef pFM31xx_debug
		ACKpFM31xx();
	#else
	{
		INT8U _Ack = ACKpFM31xx();
		Ser0Printf("ACK: %d \n", _Ack);
	}
	#endif
	WritepFM31xxData((INT8U)(Addr     ));
	#ifndef pFM31xx_debug
		ACKpFM31xx();
	#else
	{
		INT8U _Ack = ACKpFM31xx();
		Ser0Printf("ACK: %d \n", _Ack);
	}
	#endif
	StartpFM31xx();
	WritepFM31xxData(DevAddr | 0x01);
	#ifndef pFM31xx_debug
		ACKpFM31xx();
	#else
	{
		INT8U _Ack = ACKpFM31xx();
		Ser0Printf("ACK: %d \n", _Ack);
	}
	#endif	
	rVal = ReadpFM31xxData();

	NACKpFM31xx();
 	StoppFM31xx();

	return rVal;
}


INT8U Read_pFM31xx_8Addr_8Data(INT8U DevAddr, INT8U Addr)
{
	INT8U rVal = 0;
	// Device Address Writing
	StartpFM31xx();
	WritepFM31xxData(DevAddr & (~0x01));
	#ifndef pFM31xx_debug
		ACKpFM31xx();
	#else
	{
		INT8U _Ack = ACKpFM31xx();
		Ser0Printf("ACK: %d \n", _Ack);
	}
	#endif
	WritepFM31xxData(Addr);
	#ifndef pFM31xx_debug
		ACKpFM31xx();
	#else
	{
		INT8U _Ack = ACKpFM31xx();
		Ser0Printf("ACK: %d \n", _Ack);
	}
	#endif

	StartpFM31xx();
	WritepFM31xxData(DevAddr | 0x01);
	#ifndef pFM31xx_debug
		ACKpFM31xx();
	#else
	{
		INT8U _Ack = ACKpFM31xx();
		Ser0Printf("ACK: %d \n", _Ack);
	}
	#endif
	rVal = ReadpFM31xxData();
	
	NACKpFM31xx();
	StoppFM31xx();

	return rVal;
}
////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

