/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : spi_flash.c
* Author             : MCD Application Team
* Version            : V2.0.3
* Date               : 09/22/2008
* Description        : This file provides a set of functions needed to manage the
*                      communication between SPI peripheral and SPI AT25DF641 FLASH.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/
#ifndef _SPI_FLASH_C
#define _SPI_FLASH_C

#define AD25DF_C

#include "../include/main.h"

#define SPI_FLASH_PageSize    0x100

////////////////////////////////////////////////////////////////////////////////

void sFLASH_Init(DevSPIxStr *Devptr)
{
	iDev_SPIxInit(Devptr->SPIx);
	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSTimeDly(10);

	// s_Flash Unprotect
	sFLASH_Unprotected(Devptr);

}



INT32S sFLASH_BL4kCheckErase(DevSPIxStr *Devptr, INT32U ADDR, INT32U nlen)
{
    INT32S rval = TRUE;
	INT32U i = 0;
	INT32U tmpAddr = ADDR;

#define BLSIZE	(4*(1024))

	//pUSART5.printf("ADDR = %04x, nlen = %d \n", ADDR, nlen);

	for(i = 0; i < nlen; i++)
	{
		if(!(tmpAddr%BLSIZE)){
			rval = sFLASH_4kErase(Devptr, tmpAddr);//4KB erase
			//pUSART5.printf("ERASE SECTOR = %d, ADDR = %08x \n", tmpAddr/BLSIZE, tmpAddr);
		}
		tmpAddr++;
	}
   
    return rval; 
}


INT32S sFLASH_ReadStsRegister(DevSPIxStr *Devptr, INT8U *DATA)
{
	INT8U err = 0;
	INT32S nlen;
	OSSemPend(Devptr->OSSem, 0, &err);

	nlen = sFLASH_SetRegister(Devptr, RDSR, NULL, DATA, 2);

	OSSemPost(Devptr->OSSem);

	return nlen;
}

INT32S sFLASH_Unprotected(DevSPIxStr *Devptr)
{
	INT8U rval = TRUE;
	INT8U err = 0;
	INT8U tmp[2];
	RDSts1Reg tmpreg;
    
	OSSemPend(Devptr->OSSem, 0, &err);

	sFLASH_SetRegister(Devptr, WREN, NULL, tmp, 0);

	//nlen = sFLASH_SetRegister(&AT25DFSpi, RDSR, NULL, tmp, 2);
	//pUSART5.printf("2. RDSTATUS [0] = %02x, [1] = %02x len = %d\n", tmp[0], tmp[1], nlen);
	//OSTimeDly(10);

	tmp[0] = 0x00;	// unprotect!!
	sFLASH_SetRegister(Devptr, WRSR1, NULL, tmp, 1);

	sFLASH_SetRegister(Devptr, RDSR, NULL, tmp, 2);
	{
		tmpreg.Data = tmp[0];

		if(tmpreg.SWP != 0) rval = FALSE;
	}
	//	nlen = sFLASH_SetRegister(&AT25DFSpi, RDSR, NULL, tmp, 2);
	//	pUSART5.printf("1. RDSTATUS [0] = %02x, [1] = %02x len = %d\n", tmp[0], tmp[1], nlen);
	//	OSTimeDly(10);
	OSSemPost(Devptr->OSSem);

	return rval;
}

INT8U sFLASH_DataRead(DevSPIxStr *Devptr, INT32U ADDR)
{
	INT8U err = 0;
	INT8U tmp;
    
	OSSemPend(Devptr->OSSem, 0, &err);

	sFLASH_SetRegister(Devptr, READ, ADDR, &tmp, 1);	/* Read Data */
	
	OSSemPost(Devptr->OSSem);

	return tmp;
}

void sFLASH_BufferRead(DevSPIxStr *Devptr, INT32U ADDR, INT8U *DATA, INT32U nlen)
{
	INT8U err = 0;

	OSSemPend(Devptr->OSSem, 0, &err);

	sFLASH_SetRegister(Devptr, READ, ADDR, DATA, nlen);	/* Read Data */
	
	OSSemPost(Devptr->OSSem);

}


INT32S sFLASH_DataWrite(DevSPIxStr *Devptr, INT32U ADDR, INT8U *DATA, INT32U nlen)
{
	INT8U rval = TRUE;
	INT8U err = 0;
	INT8U tmp[2];
	
	INT32U i = 0;
	INT32U tmpAddr = ADDR;
	INT32U tmplen = nlen;
	INT32U clen = 0;
	INT32U tmpCnt = (tmpAddr % 256 + tmplen)/256;		// NO of Page for writing!!
	INT32U tmpptr = 0;
	RDSts1Reg tmpReg;

	OSSemPend(Devptr->OSSem, 0, &err);

	for(i = 0; i <= tmpCnt; i++)
	{
		sFLASH_SetRegister(Devptr, WREN, NULL, tmp, 0);			/* Enable the write access to the FLASH */
		sFLASH_SetRegister(Devptr, RDSR, NULL, tmp, 2);			/* Read check WEL, SWP */
		tmpReg.Data = tmp[0];
		if(tmpReg.WEL != 1) rval = FALSE;
		if(tmpReg.SWP != 0) rval = FALSE;

		if(rval)
		{
			clen = (256 - (tmpAddr % 256));
			if(clen > tmplen) clen = tmplen;

			//pUSART5.printf("START ADDR	= %04x, len = %d \n", ADDR, clen);

			sFLASH_SetRegister(Devptr, WRITE, tmpAddr, &DATA[tmpptr], clen);		/* Wait the end of Flash writing */
			rval = sFLASH_WaitWriteEnd(Devptr);									/* Wait the end of Flash writing */

			//pUSART5.printf("INCRE ADDR	= %04x, remain len = %d \n", tmpAddr, tmplen);
			//OSTimeDly(10);

			tmplen  -= clen;
			tmpAddr += clen;
			tmpptr  += clen;
		}
		else break;
	}

	OSSemPost(Devptr->OSSem);
    
    return rval;
}


INT32S sFLASH_AllErase(DevSPIxStr *Devptr)
{
	INT8U rval = TRUE;
	INT8U err = 0;
	INT8U tmp[2];
	RDSts1Reg tmpReg;
	
	OSSemPend(Devptr->OSSem, 0, &err);

	sFLASH_SetRegister(Devptr, WREN, NULL, tmp, 0);			/* Send write enable instruction */

	sFLASH_SetRegister(Devptr, RDSR, NULL, tmp, 2);			/* Reah check WEL, SWP */
    tmpReg.Data = tmp[0];
	if(tmpReg.WEL != 1) rval = FALSE;
	if(tmpReg.SWP != 0) rval = FALSE;

	if(rval)
	{
		sFLASH_SetRegister(Devptr, AllErase, NULL, tmp, 0);	/* Bulk Erase */
		rval = sFLASH_WaitWriteEnd(Devptr);			/* Wait the end of Flash writing */
	}
	OSSemPost(Devptr->OSSem);

	return rval;
}

INT32S sFLASH_4kErase(DevSPIxStr *Devptr, INT32U ADDR)//4KB erase
{
	INT8U rval = TRUE;
	INT8U err = 0;
	INT8U tmp[2];
	RDSts1Reg tmpReg;
	
	OSSemPend(Devptr->OSSem, 0, &err);

	sFLASH_SetRegister(Devptr, WREN, NULL, tmp, 0); 		/* Send write enable instruction */

	sFLASH_SetRegister(Devptr, RDSR, NULL, tmp, 2); 		/* Reah check WEL, SWP */
	tmpReg.Data = tmp[0];
	if(tmpReg.WEL != 1) rval = FALSE;
	if(tmpReg.SWP != 0) rval = FALSE;

	if(rval)
	{
		sFLASH_SetRegister(Devptr, BlockE4K, ADDR, tmp, 0); /* Bulk Erase */
		rval = sFLASH_WaitWriteEnd(Devptr); 		/* Wait the end of Flash writing */
	}
	OSSemPost(Devptr->OSSem);

	return rval;
}


INT32S sFLASH_WaitWriteEnd(DevSPIxStr *Devptr)
{
	INT8U rval = TRUE;
	INT8U tmp[2];
	INT32U tmpWait = 0;
	RDSts1Reg tmpReg;
	
	do
	{
		OSTimeDly(10L);
		sFLASH_SetRegister(Devptr, RDSR, NULL, tmp, 2);
		//pUSART5.printf("1. RDSTATUS [0] = %02x, [1] = %02x\n", tmp[0], tmp[1]);
		tmpReg.Data = tmp[0];
		if(++tmpWait >= ((2*100)*60))
		{
			return FALSE;
		}
	}
	while ((tmpReg.BUSY) == SET); 	/* Write in progress */

	if(tmpReg.EPE) rval = FALSE;	/* Check Flash Error */

	//pUSART5.printf("rval = %d \n", rval);

	return rval;
}


INT32S sFLASH_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
{
	INT32U i = 0;
	INT8U NeedAddr = FALSE;

	
		 if(OPCODE == READ)			{NeedAddr = TRUE;}
	else if(OPCODE == WRITE)		{NeedAddr = TRUE;}
	else {
			 if(OPCODE == BlockE4K) 	{NeedAddr = TRUE;	nlen = 0;	}
		else if(OPCODE == BlockE32K) 	{NeedAddr = TRUE;	nlen = 0;	}
		else if(OPCODE == BlockE64K) 	{NeedAddr = TRUE;	nlen = 0;	}
		
		else if(OPCODE == ProtectSE) 	{NeedAddr = TRUE;	nlen = 0;	}
		else if(OPCODE == uProtectSE) 	{NeedAddr = TRUE;	nlen = 0;	}
		else if(OPCODE == RDProtectS) 	{NeedAddr = TRUE;	nlen = 0;	}

		else if(OPCODE == RDSR)			{					nlen = 2;	}
		else if(OPCODE == WRSR1)		{					nlen = 1;	}
		else if(OPCODE == WRSR2)		{					nlen = 1;	}
	}

	
	iDev_SPIx_CS_RST(Devptr->nDevNo);

	SetSPIxCommand(Devptr->SPIx, OPCODE);

	if(NeedAddr){
		SetSPIxCommand(Devptr->SPIx, (ADDR >> 16) & 0xFF);
		SetSPIxCommand(Devptr->SPIx, (ADDR >>  8) & 0xFF);
		SetSPIxCommand(Devptr->SPIx, (ADDR >>  0) & 0xFF);
	}

	for(i = 0; i < nlen; i++)
	{
		DATA[i] = SetSPIxCommand(Devptr->SPIx, DATA[i]);
		if(!(nlen%256))WatchdogClear();
	}

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	return i;
}


#endif	////////////////// END OF "#ifndef _SPI_FLASH_C"
/******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
