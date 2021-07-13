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
 *
 * $Revision: 0.1 $
 * $Revision date: 2008.06
 ******************************************************************************/

#include "stm32f10x_conf.h"
#include "eep_24c64_v1104.h"

//#define EEp_debug
//unsigned long int USART3Printf( const char *format, ... );

unsigned long int (*eprintf)( const char *format, ... ) = USART1Printf;

void AT24C64Init(void)
{
#if 1
	GPIOB->CNF.B8 = __PB8_OU_OD; //__I2C1_SCL;			// AT24C00 SCL
	// SDA
	GPIOB->CNF.B13 = __PB13_IN_FL; //__I2C1_SDA;		// AT24C00 SDA
	//WP
	GPIOB->CNF.B5 = __PB5_OU_PP; //__I2C1_WP;			// AT24C00 WP
	RstAT24C64SCL();
	DisableWriteAT24C64();
#endif

#if 0
	// SCL
	GPIOB->CNF.B4 = __PB4_OU_PP; //__I2C1_SCL;			// AT24C64 SCL
	// SDA
	GPIOE->CNF.B2 = __PE2_IN_FL; //__I2C1_SDA;			// AT24C64 SDA

	RstAT24C64SCL();
#endif
}

INT16S WriteAT24C64(INT16U ADDR, INT8U Data)
{
	INT8U cnt = AT24C64WrTry;
	INT8U rVal = 0;
	INT16S pVal = (Data & 0xff);
	// 0: Write Fail
	// 1: Write Success
	EnableWriteAT24C64();
	rVal = Write_AT24C64_16Addr_8Data(AT24C64DevID, ADDR, Data);
	DisableWriteAT24C64();

	if(!rVal) return -1;

	// Confirm Data
	while(cnt--)
	{
		OSTimeDly(1);
		if(Read_AT24C64_16Addr_8Data(AT24C64DevID, ADDR) == pVal) return pVal;
	}
	return Data;
}

INT16S Write_AT24C64(INT8U DevAddr,INT16U ADDR, INT8U Data)
{
	INT8U cnt = AT24C64WrTry;
	INT8U rVal = 0;
	INT16S pVal = (Data & 0xff);
	// 0: Write Fail
	// 1: Write Success
	EnableWriteAT24C64();
	rVal = Write_AT24C64_16Addr_8Data(DevAddr, ADDR, Data);
	DisableWriteAT24C64();

	if(!rVal) return -1;

	// Confirm Data
	while(cnt--)
	{
		OSTimeDly(1);
		if(Read_AT24C64_16Addr_8Data(DevAddr, ADDR) == pVal) return pVal;
	}
	return Data;
}

INT8U Read_AT24C64(INT8U DevAddr,INT16U ADDR)
{
	return Read_AT24C64_16Addr_8Data(DevAddr, ADDR);
}


INT8U ReadAT24C64(INT16U ADDR)
{
	return Read_AT24C64_16Addr_8Data(AT24C64DevID, ADDR);
}

INT8U Write_AT24C64_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data)
{
	INT8U cnt = AT24C64WrTry;
	// Start Condition
	// Write Protection Disable, Allows normal write operation
	//
	// output 1(SDATA)
	// START Conditon making
	while(cnt--)
	{
		StartAT24C64();
		WriteAT24C64Data(DevAddr & (~0x01));
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK((0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteAT24C64Data((INT8U)(Addr >> 8));
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK(1): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteAT24C64Data((INT8U)(Addr     ));
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteAT24C64Data(Data);
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		StopAT24C64();

		return TRUE;
	}
	return FALSE;
}


INT16S Read_AT24C64_16Addr_8Data(INT8U DevAddr, INT16U Addr)
{
	INT8U cnt = AT24C64WrTry;
	INT8U rVal = 0;

	// Device Address Writing
	while(cnt--)
	{

		StartAT24C64();
		WriteAT24C64Data(DevAddr & (~0x01));
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK(0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteAT24C64Data((INT8U)(Addr >> 8));
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK(1): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteAT24C64Data((INT8U)(Addr     ));
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		StartAT24C64();
		WriteAT24C64Data(DevAddr | 0x01);
		#ifndef EEp_debug
			if(ACKAT24C64()) continue;
		#else
		{
			INT8U _Ack = ACKAT24C64();
			eprintf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		rVal = ReadAT24C64Data();

		NACKAT24C64();
	 	StopAT24C64();

		return (rVal & 0xff);
	}
	return -1;
}

INT8U ACKAT24C64(void)
{
	INT8U Data;

 	SetAT24C64SDAInMode();
	// ACK Check
	SetAT24C64SCL();
	Data = ReadAT24C64SDA();
	RstAT24C64SCL();
	return Data;
}

void NACKAT24C64(void)
{
	// NACK
 	SetAT24C64SDAOutMode();

	SetAT24C64SDA();
	SetAT24C64SCL();
	RstAT24C64SCL();
}

void WriteAT24C64Data(INT8U Data)
{
	INT8U i = 0;

 	SetAT24C64SDAOutMode();

	RstAT24C64SCL();
	for(i = 0; i < 8; i++)
	{
		if((Data & 0x80)) 	SetAT24C64SDA();
		else				RstAT24C64SDA();
		SetAT24C64SCL();
		RstAT24C64SCL();
		Data <<= 1;
	}
}

INT8U ReadAT24C64Data(void)
{
	INT8U Data = 0, i = 0;

	SetAT24C64SDAInMode();

	for(i = 0; i < 8; i++)
	{
        Data = (Data << 1);
        SetAT24C64SCL();
        if(ReadAT24C64SDA())	Data |= 0x01;
        RstAT24C64SCL();
	}
	return Data;
}


void StartAT24C64(void)
{
	// START Conditon making
	SetAT24C64SDAOutMode();

	SetAT24C64SDA();

	SetAT24C64SCL();
	RstAT24C64SDA();
	RstAT24C64SCL();

}
void StopAT24C64(void)
{
	// STOP
	SetAT24C64SDAOutMode();
	RstAT24C64SDA();
	SetAT24C64SCL();
	SetAT24C64SDA();
	RstAT24C64SCL();
}

void SetAT24C64SDAInMode(void)
{
#if 1
	GPIOB->CNF.B13 = __PB13_IN_FL; //__I2C1_SDA;			// AT24C64 SDA
#endif
#if 0
	GPIOE->ODR.B2 = __PE2_IN_FL; //__I2C1_SDA;			// AT24C64 SDA
#endif
}

void SetAT24C64SDAOutMode(void)
{
#if 1
//	GPIOB->CNF.B13 = __PB13_OU_OD; //__I2C1_SDA;			// AT24C64 SDA
	GPIOB->CNF.B13 = __PB13_OU_PP; //__I2C1_SDA;			// AT24C64 SDA
#endif
#if 0
	GPIOE->ODR.B2 = __PE2_OU_PP; //__I2C1_SDA;			// AT24C64 SDA
#endif
}

void SetAT24C64SCL(void)
{
#if 1
	GPIOB->ODR.B8 = SET;
	CLK24C64DELAY;
#endif
#if 0
	GPIOB->ODR.B4 = 1;
	CLK24C64DELAY;
#endif	
}

void RstAT24C64SCL(void)
{
#if 1
	GPIOB->ODR.B8 = RESET;
	CLK24C64DELAY;
#endif
#if 0
	GPIOB->ODR.B4 = 0;
	CLK24C64DELAY;
#endif	
}

void SetAT24C64SDA(void)
{
#if 1
	GPIOB->ODR.B13 = SET;
	CLK24C64DELAY;
#endif

#if 0
	GPIOE->ODR.B2 = 1;	
	CLK24C64DELAY;
#endif	
}

void RstAT24C64SDA(void)
{
#if 1
	GPIOB->ODR.B13 = RESET;
	CLK24C64DELAY;
#endif

#if 0
	GPIOE->ODR.B2 = 0;
	CLK24C64DELAY;
#endif	
}
INT8U ReadAT24C64SDA(void)
{
/////////////////////////////////////////	
#if 1
	CLK24C64DELAY;
	return(GPIOB->IDR.B13);
#endif	
#if 0
	return(GPIOE->IDR.B2);
#endif
}

void EnableWriteAT24C64(void)
{
	GPIOB->ODR.B5 = RESET;
}
void DisableWriteAT24C64(void)
{
	GPIOB->ODR.B5 = SET;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

