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
#include "AT24c64_v0.1.h"

//#define EEp_debug
unsigned long int USART3Printf( const char *format, ... );

unsigned long int USART1Printf( const char *format, ... );

unsigned long int (*eprintf)( const char *format, ... ) = USART1Printf;

void EEpromInit(void)
{

	// This Fuction should be used after declare pio or expio init function.
	// Write Protecion Enable, Prohibit normal write operation
	// Low SCL, SDA: input access
	//
	// Port Initialization
	GPIOB->CNF.B8 = __PB8_OU_PP; //__I2C1_SCL;			// AT24C00 SCL
	// SDA
	GPIOB->CNF.B13 = __PB13_IN_FL; //__I2C1_SDA;		// AT24C00 SDA
	//WP
	GPIOB->CNF.B5 = __PB5_OU_PP; //__I2C1_WP;			// AT24C00 WP


	RstSCL();
}




INT16S WriteEEprom(INT16U ADDR, INT8U Data)
{
	INT8U cnt = EEpromWrTry;
	INT8U rVal = 0;
	INT16S pVal = (Data & 0xff);
	// 0: Write Fail
	// 1: Write Success
	rVal = Write_EEprom_16Addr_8Data(At24cDevID, ADDR, Data);

//	USART1Printf("ADDR[%d][%d]\n",ADDR,Data);

	if(!rVal) return -1;

	// Confirm Data
	while(cnt--)
	{
		OSTimeDly(1);
		
		if(Read_EEprom_16Addr_8Data(At24cDevID, ADDR) == pVal) return pVal;
	}
	return Data;
}

INT8U ReadEEprom(INT16U ADDR)
{
	return Read_EEprom_16Addr_8Data(At24cDevID, ADDR);
}

INT8U Write_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data)
{
	INT8U cnt = EEpromWrTry;
	// Start Condition
	// Write Protection Disable, Allows normal write operation
	//
	// output 1(SDATA)
	// START Conditon making
	while(cnt--)
	{
		StartEEprom();
		WriteEEpromData(DevAddr & (~0x01));
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK((0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr >> 8));
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK(1): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr     ));
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData(Data);
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		StopEEprom();

		return TRUE;
	}
	return FALSE;
}


INT16S Read_EEprom_16Addr_8Data(INT8U DevAddr, INT16U Addr)
{
	INT8U cnt = EEpromWrTry;
	INT8U rVal = 0;

	// Device Address Writing
	while(cnt--)
	{

		StartEEprom();
		WriteEEpromData(DevAddr & (~0x01));
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK(0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr >> 8));
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK(1): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		WriteEEpromData((INT8U)(Addr     ));
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		StartEEprom();
		WriteEEpromData(DevAddr | 0x01);
		#ifndef EEp_debug
			if(ACKEEprom()) continue;
		#else
		{
			INT8U _Ack = ACKEEprom();
			eprintf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		rVal = ReadEEpromData();

		NACKEEprom();
	 	StopEEprom();

		return (rVal & 0xff);
	}
	return -1;
}

INT8U ACKEEprom(void)
{
	INT8U Data;

 	SetSDAInMode();
	// ACK Check
	SetSCL();
	Data = ReadSDA();
	RstSCL();
	return Data;
}

void NACKEEprom(void)
{
	// NACK
 	SetSDAOutMode();

	SetSDA();
	SetSCL();
	RstSCL();
}

void WriteEEpromData(INT8U Data)
{
	INT8U i = 0;

 	SetSDAOutMode();

	RstSCL();
	for(i = 0; i < 8; i++)
	{
		if((Data & 0x80)) 	SetSDA();
		else				RstSDA();
		SetSCL();
		RstSCL();
		Data <<= 1;
	}
}

INT8U ReadEEpromData(void)
{
	INT8U Data = 0, i = 0;

	SetSDAInMode();

	for(i = 0; i < 8; i++)
	{
        Data = (Data << 1);
        SetSCL();
        if(ReadSDA())	Data |= 0x01;
        RstSCL();
	}
	return Data;
}


void StartEEprom(void)
{
	// START Conditon making
	SetSDAOutMode();

	SetSDA();

	SetSCL();
	RstSDA();
	RstSCL();

}
void StopEEprom(void)
{
	// STOP
	SetSDAOutMode();

	RstSDA();
	SetSCL();
	SetSDA();
	RstSCL();
}

void SetSDAInMode(void)
{
	GPIOB->CNF.B13 = __PB13_IN_PU; //__I2C1_SDA;			// AT24C64 SDA
}

void SetSDAOutMode(void)
{
	GPIOB->CNF.B13 = __PB13_OU_PP; //__I2C1_SDA;			// AT24C64 SDA
}

void SetSCL(void)
{
	GPIOB->ODR.B8 = SET;

	CLKDELAY;
}
void RstSCL(void)
{
	GPIOB->ODR.B8 = RESET;
	CLKDELAY;
}

void SetSDA(void)
{
	GPIOB->ODR.B13 = SET;

	CLKDELAY;
}

void RstSDA(void)
{
	GPIOB->ODR.B13 = RESET;

	CLKDELAY;
}
INT8U ReadSDA(void)
{
/////////////////////////////////////////	
	CLKDELAY;
	return(GPIOB->IDR.B13);
}
void EnableWriteEEprom(void)
{
	GPIOB->ODR.B5 = 0;
}
void DisableWriteEEprom(void)
{
	GPIOB->ODR.B5 = 1;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

