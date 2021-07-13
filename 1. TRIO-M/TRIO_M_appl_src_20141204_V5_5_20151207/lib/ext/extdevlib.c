/*********************************************
* File Name          : usart1_vx.x.c
* Author             :
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define	EXTDEV_C

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "ucos_ii.h"
#include "cpu.h"

#include "stm32f10x_type.h"
#include "stm32f10x_conf.h"

#include "../include/extdevlibext.h"
#include "extdevlib.h"
#include "../dev/mem/fsmc_sram.h"


void DownFlagSet(INT16U mode)
{
	INT32U cpu_sr;
	OS_ENTER_CRITICAL();
	{
		SYS_BACK *ptr = (SYS_BACK *)RoadBackuptobuffer(__pSYSTAddr);

		ptr->Data[DownLoadFlag1] = (mode >> 8) & 0xff;
		ptr->Data[DownLoadFlag2] = (mode >> 0) & 0xff;

		WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK));
	}
	OS_EXIT_CRITICAL();
}


void DownloadFlagClr(void)
{
	DownFlagSet(NOMODE);
}

INT8U CheckSWConf(void)
{
	INT8U ret = 0;

	ret = (ret << 1) | GPIOB->IDR.B3;	// DIP SW ID3
	ret = (ret << 1) | GPIOA->IDR.B14; 	// DIP SW ID2
	ret = (ret << 1) | GPIOA->IDR.B13;	// DIP SW ID1
	ret = (ret << 1) | GPIOA->IDR.B15;	// DIP SW ID0

	return ((~ret) & 0x0f);
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


// -1: error
#define USED_HALFWORD

signed long int UpLoadData(unsigned char *ptr, unsigned short int len, unsigned long int pcnt)
{
	INT32U i = 0;
	INT32U rdata = 0;
	volatile INT8U *upLdAddr = (INT8U * )(__pAPBKAddr + pcnt);

#ifdef USED_HALFWORD
	for(i = 0; i < len; i = i+2 )
#else
	for(i = 0; i < len; i = i+4 )
#endif
	{	// copy to download area.
		rdata = 0;
		rdata |= (*ptr++) << 0;
		rdata |= (*ptr++) << 8;
#ifndef USED_HALFWORD
		rdata |= (*ptr++) << 16;
		rdata |= (*ptr++) << 24;	
#endif
		WatchdogClear();

#ifdef USED_HALFWORD
		if(FLASH_ProgramHalfWord(((INT32U)&upLdAddr[i]), rdata & 0xffff) != FLASH_COMPLETE )
#else
		if(FLASH_ProgramWord(((INT32U)&upLdAddr[i]), rdata) != FLASH_COMPLETE )
#endif
        {
            //pUSART3.dprintf("data: %08x, len: %d, i: %d, pcnt: %d \n", rdata, len, i, pcnt);
            return -1;
        }

		if( !(i%128) ) OSTimeDly(1);
		
	}
	return (pcnt + len);
}

signed long int UpLoadExtSRAM(unsigned char *ptr, unsigned short int len, unsigned long int pcnt)
{
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
}

void DownloadFlagSet(unsigned long int nsize)
{
	INT32U cpu_sr;
	OS_ENTER_CRITICAL();
	{
		SYS_BACK *ptr = (SYS_BACK *)RoadBackuptobuffer(__pSYSTAddr);

		ptr->Data[DownLoadFlag1] = (INT8U)(APDNMODE >> 8);
		ptr->Data[DownLoadFlag2] = (INT8U)(APDNMODE 	);

		ptr->Data[FWDataSize3_MSB] = (INT8U)((nsize >> 24) & 0xFF);
		ptr->Data[FWDataSize2]	   = (INT8U)((nsize >> 16) & 0xFF);
		ptr->Data[FWDataSize1]	   = (INT8U)((nsize >> 8 ) & 0xFF);
		ptr->Data[FWDataSize0_LSB] = (INT8U)((nsize 	) & 0xFF);

		WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK)); 
	}
	OS_EXIT_CRITICAL();
}

void DownloadFlagSetExtSRAM(unsigned long int nsize)
{
	INT32U cpu_sr;
	
	OS_ENTER_CRITICAL();
	{
		SYS_BACK *ptr = (SYS_BACK *)RoadBackuptobuffer(__pSYSTAddr);

		ptr->Data[DownLoadFlag1] = (INT8U)(APDNSRAM >> 8);
		ptr->Data[DownLoadFlag2] = (INT8U)(APDNSRAM     );

		ptr->Data[FWDataSize3_MSB] = (INT8U)((nsize >> 24) & 0xFF);
		ptr->Data[FWDataSize2]	   = (INT8U)((nsize >> 16) & 0xFF);
		ptr->Data[FWDataSize1]     = (INT8U)((nsize >> 8 ) & 0xFF);
		ptr->Data[FWDataSize0_LSB] = (INT8U)((nsize		) & 0xFF);

		WriteBuffertoBackup(__pSYSTAddr, sizeof(SYS_BACK));	
	}
	OS_EXIT_CRITICAL();
}


void DownLoadBootingJump(void)
{
	//__SETPRIMASK(); //Interrupt Disable
	INT32U cpu_sr;
	OS_ENTER_CRITICAL();
	cpu_sr = cpu_sr;
	while(1);
}


#ifdef USART1_USING
	extern INT8U Tx1Buff[Tx1BuffLen];
	INT8U *eepBuff = (INT8U *)Tx1Buff;
#else
	INT8U eepBuff[2048];
#endif



#define EE_ERROR	0
#define EE_NORMAL	1

INT32U *RoadBackuptobuffer(INT32U sptr)
{
	INT32U *ptr = (INT32U *)eepBuff;

	memcpy((INT8U *)ptr, (INT8U *)sptr, 2048);
    return ptr;
}


int WriteBuffertoBackup(INT32U dptr, INT32U size)
{
	int FLASHStatus = FLASH_COMPLETE;
	int i = 0;
	INT32U *ptr = (INT32U *)eepBuff;

	int tsize = (size)/4;
	if((size)%4) tsize++;

	if(!memcmp((char *)eepBuff, (char *)dptr, size)) return TRUE;

	FLASH_Unlock();
	FLASH_ClearFlag(FLASH_FLAG_BSY | FLASH_FLAG_EOP | FLASH_FLAG_PGERR | FLASH_FLAG_WRPRTERR);	
	WatchdogClear();
	FLASHStatus = FLASH_ErasePage((INT32U)dptr);

	eepBuff[0] = (size >> 0) & 0xff;
	eepBuff[1] = (size >> 8) & 0xff;

	eepBuff[size + 0] = ((0x1021 >> 0) & 0xff);
	eepBuff[size + 1] = ((0x1021 >> 8) & 0xff); // verifyFlag!!

	if(FLASHStatus == FLASH_COMPLETE)
	{
		// mirror backup
		WatchdogClear();
		for(i = 0; i < tsize; i++)	// 1 dummy
		{
			if(FLASH_ProgramWord((INT32U)((INT32U *)dptr + i), *ptr++) != FLASH_COMPLETE)
			{
				FLASHStatus = FLASH_ERRORWR;				
				break;
			}
		}
	}
	FLASH_Lock();
	
	if( *(u16 *)(dptr + size) == 0x1021)	return TRUE;
	else									return FALSE;
 }

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

