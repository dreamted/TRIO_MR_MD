/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart1_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/


#define	EXTDEV_C

#include "lib_extdev_1208.h"
#include "../include/lib_extdevext.h"

extern __SerStrPtr pUSART1;

void DownFlagSet(INT16U mode)
{
/*
	INT32U cpu_sr;
	OS_ENTER_CRITICAL();
	{
		SYS_BACK *ptr = (SYS_BACK *)RoadBackuptobuffer(__pSYSTAddr);

		ptr->Data[DownLoadFlag1] = (mode >> 8) & 0xff;
		ptr->Data[DownLoadFlag2] = (mode >> 0) & 0xff;

		WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK));
	}
	OS_EXIT_CRITICAL();
	*/
	WriteEEprom(At24cDevID, DownLoadFlag1, 	(INT8U)(mode >> 8), 0);
	WriteEEprom(At24cDevID, DownLoadFlag2, 	(INT8U)(mode     ), 0);
}

void DownloadFlagClr(void)
{
	DownFlagSet(NOMODE);
}

////////////////////////////////////////////////////////////////////////////////

unsigned short int Crc16Calc(unsigned char *buf_ptr, unsigned long int len, unsigned short int ninit)
{
	INT16U dt;
	INT16U crc16;

	len *= 8;
	for(crc16 = ninit; len >= 8; len -= 8, buf_ptr++)
	{
		crc16 = Crc_tbl[(crc16>>8) ^ *buf_ptr] ^ (crc16<<8);
	}
	if(len != 0)
	{
		dt = ((INT16U)(*buf_ptr)) << 8;
		while(len-- != 0)
		{
			if(((crc16^dt) & ((INT16U)1 << 15)) != 0)
			{crc16 <<= 1;crc16 ^= POLYNOMIAL;}
			else crc16 <<= 1;
			dt <<= 1;
		}
	}
	return(crc16);
}

INT32U FLASHpAPBK_Check_Erase(void)
{
	if(FLASH_If_EraseFunc(__pAPBKAddr) != FLASH_COMPLETE)
	{
		return FALSE;
	}
	return TRUE;
}

// -1: error
//__pAPBKAddr


signed long int UpLoadData(unsigned int bAddr, unsigned char *ptr, unsigned short int len, unsigned long int pcnt)
{
	INT32U i = 0;
	INT32U rdata = 0;
	volatile INT8U *upLdAddr = (INT8U * )(bAddr + pcnt);

	for(i = 0; i < len; i = i+4 )
	{	// copy to download area.
		rdata = 0;
		rdata |= (*ptr++) << 0;
		rdata |= (*ptr++) << 8;
		rdata |= (*ptr++) << 16;
		rdata |= (*ptr++) << 24;	
		WatchdogClear();

		if(FLASH_ProgramWord(((INT32U)&upLdAddr[i]), rdata) != FLASH_COMPLETE )
        {
            pUSART1.printf("data: %08x, len: %d, i: %d, pcnt: %d \n", rdata, len, i, pcnt);
            return -1;
        }

		if( !(i%128) ) OSTimeDly(1);
		
	}
	return (pcnt + len);
}

signed long int UpLoadExtSRAM(unsigned char *ptr, unsigned short int len, unsigned long int pcnt)
{
  /**
	INT32U i = 0;
	INT32U rdata = 0;
	volatile INT8U *upLdAddr = (INT8U * )(__pAPBK_SRAMAddr + pcnt);

	if((pcnt + len) > (APPLSIZE*2L)) return -1;

	for(i = 0; i < len; i = i+4 )
	{	// copy to download area.
		rdata = 0;
		rdata |= (*ptr++) << 0;
		rdata |= (*ptr++) << 8;
		rdata |= (*ptr++) << 16;
		rdata |= (*ptr++) << 24;	

		*(volatile INT32U *)((INT8U *)upLdAddr + i) = rdata;
		if( !(i%128) ) OSTimeDly(1);
	}
	return (pcnt + len);
  **/
  return 0;
}

INT8U SetBootBaudRate(INT32U nBps)
{
	INT8U rval = FALSE;
	INT32U rBAUD = 0;

	rBAUD = ((ReadEEprom(At24cDevID, BackupMark1H, 0) << 8) | (ReadEEprom(At24cDevID, BackupMark1L, 0))) * 100L;

	if(rBAUD != nBps)
	{
		nBps = nBps/100L;
		WriteEEprom(At24cDevID, BackupMark1L,	(nBps >> 0) & 0xff, 0);
		WriteEEprom(At24cDevID, BackupMark1H,	(nBps >> 8) & 0xff, 0);

		rval = TRUE;
	}
	return rval;
}



void DownloadFlagSet(unsigned long int nsize)
{
	WriteEEprom(At24cDevID, DownLoadFlag1, 	(INT8U)(APDNMODE >> 8), 0);
	WriteEEprom(At24cDevID, DownLoadFlag2, 	(INT8U)(APDNMODE     ), 0);

	WriteEEprom(At24cDevID, FWDataSize3_MSB,	(INT8U)((nsize >> 24) & 0xFF), 0);
	WriteEEprom(At24cDevID, FWDataSize2, 		(INT8U)((nsize >> 16) & 0xFF), 0);
	WriteEEprom(At24cDevID, FWDataSize1, 		(INT8U)((nsize >> 8 ) & 0xFF), 0);
	WriteEEprom(At24cDevID, FWDataSize0_LSB,	(INT8U)((nsize		) & 0xFF), 0);

}

void DownloadFlagSetExtSRAM(unsigned long int nsize)
{
	WriteEEprom(At24cDevID, DownLoadFlag1,	(INT8U)(APDNSRAM >> 8), 0);
	WriteEEprom(At24cDevID, DownLoadFlag2,	(INT8U)(APDNSRAM     ), 0);

	WriteEEprom(At24cDevID, FWDataSize3_MSB,	(INT8U)((nsize >> 24) & 0xFF), 0);
	WriteEEprom(At24cDevID, FWDataSize2,	   	(INT8U)((nsize >> 16) & 0xFF), 0);
	WriteEEprom(At24cDevID, FWDataSize1,		(INT8U)((nsize >> 8 ) & 0xFF), 0);
	WriteEEprom(At24cDevID, FWDataSize0_LSB,	(INT8U)((nsize		) & 0xFF), 0);
}


void DownLoadBootingJump(void)
{
	INT32U cpu_sr;
	OS_ENTER_CRITICAL();
	cpu_sr = cpu_sr;
	//while(1);
	SYSTEMRESET;
	//OS_EXIT_CRITICAL();
}

INT32U DATEtoInt(char *DATE)
{
      // retval: yyyy mm dd
    char *MChar[] =
    {
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
    };
    
	INT32U i = 0;
	INT32U rval = 0;
	for(i = 0; i < 12; i++)
	{
		if(!strncmp(MChar[i], DATE, 3)) break;
	}
	rval  = (i+1) << 8;
	rval |= (atoi((char *)&DATE[4]) & 0xff);
	rval |= (atoi((char *)&DATE[7]) & 0xffff) << 16;

	return rval;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

