/*******************************************************************************
 *
 * This module contains the function STM32F10x EEPROM(AT24C01~16) related, a function
 * that is called before the 'main' function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * AT24C01A:  1024bit,  128 Bytes
 * AT24C02A:  2048bit,  256 Bytes
 * AT24C04A:  4096bit,  512 Bytes
 * AT24C08A:  8192bit, 1024 Bytes
 * AT24C16A: 16384bit, 2048 Bytes
 * * Copyright 2011- bizistyle(bgyoon@naver.com), All rights reserved.
 *
 * $Revision: 2011.02 $
 * $Revision date: 2008.06
 ******************************************************************************/

#include "stm32f10x_conf.h"
#include "eep_24c16a_v1102.h"

//#define EEp_debug

void AT24C16AInit(void)
{
	// This Fuction should be used after declare pio or expio init function.
	// Write Protecion Enable, Prohibit normal write operation
	// Low SCL, SDA: input access
	//
	// SCL
	GPIOB->CNF.B8 = __PB8_OU_PP; //__I2C1_SCL;			// AT24C00 SCL
	// SDA
	GPIOB->CNF.B13 = __PB13_IN_FL; //__I2C1_SDA;		// AT24C00 SDA
	//WP
	GPIOB->CNF.B5 = __PB5_OU_PP; //__I2C1_WP;			// AT24C00 WP
	
	Rst16ASCL();
	DisableWriteAt24c16A();
}

INT16S Write24C16(INT16U ADDR, INT8U Data)
{
	INT8U cnt = AT16aWrTry;
	INT8U tmpDevID; 
	INT8U rVal = 0;
	INT16S pVal = (Data & 0xff);
	// 0: Write Fail
	// 1: Write Success
	EnableWriteAt24c16A();

	tmpDevID = (~((ADDR >> 8) & 0xff) & At16aAddr);
	tmpDevID = At16aDevID | (tmpDevID << 1);

	rVal = Write_16A_8Addr_8Data(tmpDevID, ADDR, Data);
	
	DisableWriteAt24c16A();

#ifdef EEp_debug
	USART1Printf("ADDR = %02x, rval = %d\n", tmpDevID, rVal);
#endif
	if(!rVal) return -1;

	// Confirm Data
	while(cnt--)
	{
		OSTimeDly(3);
		if(Read_16A_8Addr_8Data(tmpDevID, ADDR) == pVal) return pVal;
	}
	return -2;
}

INT8U Read24C16(INT16U ADDR)
{
	INT8U tmpDevID; 
	
	tmpDevID = (~((ADDR >> 8) & 0xff) & At16aAddr);
	tmpDevID = At16aDevID | (tmpDevID << 1);

	tmpDevID = Read_16A_8Addr_8Data(tmpDevID, ADDR);

	return tmpDevID;
}

INT8U Write_16A_8Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data)
{
	INT8U cnt = AT16aWrTry;
	// Start Condition
	// Write Protection Disable, Allows normal write operation
	// 
	// output 1(SDATA)
	// START Conditon making
	while(cnt--)
	{
		Start16AEEprom();
		Write16AEEpromData(DevAddr & (~0x01));
		#ifndef EEp_debug
			if(ACK16AEEprom()) continue;
		#else
		{
			INT8U _Ack = ACK16AEEprom();
			pUSART1.printf("ACK(0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		
		Write16AEEpromData((INT8U)(Addr     ));
		#ifndef EEp_debug
			if(ACK16AEEprom()) continue;
		#else
		{
			INT8U _Ack = ACK16AEEprom();
			pUSART1.printf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		Write16AEEpromData(Data);
		#ifndef EEp_debug
			if(ACK16AEEprom()) continue;
		#else
		{
			INT8U _Ack = ACK16AEEprom();
			pUSART1.printf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		Stop16AEEprom();

		return TRUE;
	}
	return FALSE;
}


INT16S Read_16A_8Addr_8Data(INT8U DevAddr, INT16U Addr)
{
	INT8U cnt = AT16aWrTry;
	INT8U rVal = 0;
	
	// Device Address Writing
	while(cnt--)
	{

		Start16AEEprom();
		Write16AEEpromData(DevAddr & (~0x01));
		#ifndef EEp_debug
			if(ACK16AEEprom()) continue;
		#else
		{
			INT8U _Ack = ACK16AEEprom();
			pUSART1.printf("ACK(0): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		
		Write16AEEpromData((INT8U)(Addr     ));
		#ifndef EEp_debug
			if(ACK16AEEprom()) continue;
		#else
		{
			INT8U _Ack = ACK16AEEprom();
			pUSART1.printf("ACK(2): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif
		Start16AEEprom();
		Write16AEEpromData(DevAddr | 0x01);
		#ifndef EEp_debug
			if(ACK16AEEprom()) continue;
		#else
		{
			INT8U _Ack = ACK16AEEprom();
			pUSART1.printf("ACK(3): %d \n", _Ack);
			if(_Ack) continue;
		}
		#endif	
		rVal = Read16AEEpromData();

		NACK16AEEprom();
	 	Stop16AEEprom();

		return (rVal & 0xff);
	}
	return -1;
}

INT8U ACK16AEEprom(void)
{
	INT8U Data;

 	Set16ASDAInMode();
	// ACK Check
	Set16ASCL();
	Data = Read16ASDA();
	Rst16ASCL();
	return Data;
}

void NACK16AEEprom(void)
{
	// NACK
 	Set16ASDAOutMode();
	
	Set16ASDA();
	Set16ASCL();
	Rst16ASCL();
}

void Write16AEEpromData(INT8U Data)
{
	INT8U i = 0;

 	Set16ASDAOutMode();

	Rst16ASCL();
	for(i = 0; i < 8; i++)
	{
		if((Data & 0x80)) 	Set16ASDA();
		else				Rst16ASDA();
		Set16ASCL();
		Rst16ASCL();
		Data <<= 1;
	}
}

INT8U Read16AEEpromData(void)
{
	INT8U Data = 0, i = 0;

	Set16ASDAInMode();

	for(i = 0; i < 8; i++)
	{
        Data = (Data << 1);
        Set16ASCL();
        if(Read16ASDA())	Data |= 0x01;
        Rst16ASCL();
	}	
	return Data;
}


void Start16AEEprom(void)
{
	// START Conditon making
	Set16ASDAOutMode();
	
	Set16ASDA();
	
	Set16ASCL();
	Rst16ASDA();
	Rst16ASCL();

}
void Stop16AEEprom(void)
{
	// STOP
	Set16ASDAOutMode();
	
	Rst16ASDA();
	Set16ASCL();
	Set16ASDA();
	Rst16ASCL();
}

void Set16ASDAInMode(void)
{
	GPIOB->CNF.B13 = __PB13_IN_PU; //__I2C1_SDA;			// AT24C64 SDA
	//GPIOB->ODR.B13 = SET;
}

void Set16ASDAOutMode(void)
{
	GPIOB->CNF.B13 = __PB13_OU_PP; //__I2C1_SDA;			// AT24C64 SDA
	//GPIOB->ODR.B13 = RESET;
}


void Set16ASCL(void)
{
	GPIOB->ODR.B8 = SET;
}

void Rst16ASCL(void)
{
	GPIOB->ODR.B8 = RESET;
}
void Set16ASDA(void)
{
	GPIOB->ODR.B13 = SET;
}

void Rst16ASDA(void)
{
	GPIOB->ODR.B13 = RESET;
}

INT8U Read16ASDA(void)
{
/////////////////////////////////////////
	return(GPIOB->IDR.B13);
}
void EnableWriteAt24c16A(void)
{
	GPIOB->ODR.B5 = 0;
}
void DisableWriteAt24c16A(void)
{
	GPIOB->ODR.B5 = 1;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

