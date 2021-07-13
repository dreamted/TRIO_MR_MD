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
#define AD9777_C

#include "../include/main.h"



void Ad9777_Write(DevSPIxStr *Devptr, INT8U ADDR, INT8U DATA)
{
	INT8U err;

	OSSemPend(Devptr->OSSem, 0, &err );

	iDev_SPIx_CS_RST(Devptr->nDevNo);
	SetSPIxCommand(Devptr->SPIx, ADDR & 0x7F);
	SetSPIxCommand(Devptr->SPIx, DATA);
	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);
}


INT8U Ad9777_Read(DevSPIxStr *Devptr, INT8U ADDR)
{
	INT8U rval = 0;
	INT8U err;

	OSSemPend(Devptr->OSSem, 0, &err );

	iDev_SPIx_CS_RST(Devptr->nDevNo);
	SetSPIxCommand(Devptr->SPIx,  ADDR | 0x80);
	rval = SetSPIxCommand(Devptr->SPIx, NULL);

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);

	return rval;
}

void Ad9777_SetRegister(DevSPIxStr *Devptr)
{
	INT8U i = 0;
	
	for(i = 0; i < 13; i++) Ad9777_Write(Devptr, i, AD9777RegInit[i]);

	
}



