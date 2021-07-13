/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * Values of global or static variables.
 *
 *
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 *
 ******************************************************************************/
//#include "../include/main.h"
#define __DEV_AWR_301

#include "../../lib/include/ucos_ii.h"	// uCOS-ii include
#include "../../lib/include/pio_v0.04.h"
#include "../../lib/include/7092_v1.05.h"
#include "./awr_301.h"

#define Awr_301_debug

#ifdef I2CRETRY
	#undef I2CRETRY
#endif

#define I2CRETRY		5

void Awr_301Init(void)
{
	// This Fuction should be used after declare pio or expio init function.
	// Write Protecion Enable, Prohibit normal write operation
	// Low SCL, SDA: input access
	//
	Ser0Printf("AWR_301 CB Interface I2C Init\n");

	// Port Initialization
	// SCK
	P9MRReg->P92 = __P92;		// PORT
	P9DDRReg->D2 = 0;			// Output

	// DATA
	P9MRReg->P93 = __P93;		// PORT
	P9DDRReg->D3 = 1;			// Input

	I2C_CLK = 0;
}


void Awr_start(void)
{
	I2C_DataOutMode();

	SetI2C_DATA;
	SetI2C_CLK;
	RstI2C_DATA;

	RstI2C_CLK;
}

void Awr_stop(void)
{
	I2C_DataOutMode();

	RstI2C_DATA;
	SetI2C_CLK;
	SetI2C_DATA;

	RstI2C_CLK;
}

INT8U Awr_ack(void)
{
	INT8U rval;

	I2C_DataInMode();

	RstI2C_CLK;
	SetI2C_CLK;
	rval = I2C_DATA;
	RstI2C_CLK;

	return rval;
}

void Awr_out(INT8U Data)
{
	INT8U i = 0;

	I2C_DataOutMode();

	RstI2C_CLK;

	for(i = 0; i < 8; i++)
	{
		RstI2C_DATA;
		if  (Data & 0x80) SetI2C_DATA;
		Data <<= 1;
		SetI2C_CLK;
		RstI2C_CLK;
	}
	RstI2C_DATA;
	ForDelay(D_DLY);
}


INT32S ReadAwr_301(INT16U dAddr, INT16U Addr)
{
	INT8U i = 0, j = 0, k = 0;
	INT8U ch = 0;
	INT32S rval = 0;

	INT32U cpu_sr = 0;

	OS_ENTER_CRITICAL();

	for(i = 0;  i < 2; i++)
	{
	    Awr_start();
		Awr_out(DevAddr & ~(0x01));				/* dummy write command */
		//Awr_ack();
		//Ser0Printf("EpAck = %d \n", Ep_ack());

	    Awr_out(Addr);		/* write address */
		//Awr_ack();
		//Ser0Printf("EpAck = %d \n", Ep_ack());

	    Awr_start();
		Awr_out(DevAddr | (0x01));
		//Awr_ack();

		//Ser0Printf("EpAck = %d \n", Ep_ack());
		I2C_DataInMode();

		rval = 0;

		for(j = 0; j < 4; j++)
		{
			ch = 0;
			for(k = 0; k < 8; k++)
			{
				ch <<= 1;
				SetI2C_CLK;
				if(I2C_DATA) ch = ch | 0x01;
				RstI2C_CLK;
			}
			rval |= (ch << 8*j);

			if(j != 3) 	Awr_ack();
			else		Awr_nack();
		}
		Awr_stop();
	}

	OS_EXIT_CRITICAL();
	return(rval);
}

void Awr_nack(void)
{
	// NACK
	I2C_DataOutMode();

	SetI2C_DATA;
	SetI2C_CLK;
	RstI2C_CLK;
}

// 1: succuss
// 0: fail
INT8U WriteAwr_301(INT8U dAddr, INT8U Addr, INT32S Data)
{

	INT8U ch = 0;
	INT8U rtry = I2CRETRY;
	INT32U cpu_sr = 0;

	OS_ENTER_CRITICAL();

  	Awr_start();
	Awr_out(DevAddr & ~(0x01));			/* address & write command */
	//Awr_ack();
	Awr_out(Addr);	/* write address */
	//Awr_ack();

	for(ch = 0; ch < 4; ch++)
	{
    	Awr_out((INT8U)(Data >> 8*ch));		/* write data */
		ForDelay(D_DLY);
		ForDelay(D_DLY);
		ForDelay(D_DLY);
	}
//	Awr_ack();
	Awr_stop();

	OS_EXIT_CRITICAL();
	rtry--;

	while(rtry--)
	{
		ForDelay(500);
		if(Data != ReadAwr_301(DevAddr, Addr)) continue;
		else return 1;
	}
	return 0;
}
////////////////////////////////////////////////////////////////////////////////

