/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original source file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 * - used for LMX2306/LMX2316/LMX2326
 
 * $Revision: 0.1 $
 * $Revision date: 2006.08.__
 *
  ******************************************************************************/
#define AD9518_C

#include "../include/main.h"


void Ad9518_SetRegister(DevSPIxStr *Devptr)
{
	INT8U i = 0;
	
	for( i = 0; i < 68; i++) ClkSynthesizerRegWrite(Devptr, AD9518InitAddress[i], AD9518InitData[i]);

	ClkSynthesizerRegWrite(Devptr, REG_UPDATE_REG, 0x01);
	OSTimeDly(100L);
	ClkSynthesizerRegWrite(Devptr, 0x0018, 0x07);    
	ClkSynthesizerRegWrite(Devptr, REG_UPDATE_REG, 0x01);

	
	//for( i = 0; i < 68; i++) {
	//	pUSART5.printf("ADDR[%04x] = [%02x] \n", AD9518InitAddress[i], ClkSynthesizerRegRead(Devptr, AD9518InitAddress[i]));
	//}
}


void ClkSynthesizerRegWrite(DevSPIxStr *Devptr, INT16U ADDR, INT8U DATA)
{
	
	INT8U err;

	OSSemPend(Devptr->OSSem, 0, &err );

	iDev_SPIx_CS_RST(Devptr->nDevNo);
	SetSPIxCommand(Devptr->SPIx, (ADDR >> 8) & 0x7F);
	SetSPIxCommand(Devptr->SPIx, (ADDR >> 0)       );
	SetSPIxCommand(Devptr->SPIx, DATA);
	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);

}

INT8U ClkSynthesizerRegRead(DevSPIxStr *Devptr, INT16U ADDR)
{
	INT8U rval = 0;
	INT8U err;

	OSSemPend(Devptr->OSSem, 0, &err );

	iDev_SPIx_CS_RST(Devptr->nDevNo);
	SetSPIxCommand(Devptr->SPIx,  (ADDR >> 8) | 0x80);
	SetSPIxCommand(Devptr->SPIx, (ADDR >> 0) & 0xff);

	rval = SetSPIxCommand(Devptr->SPIx, NULL);

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);

	return rval;
}

