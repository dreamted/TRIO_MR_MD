/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_bkp.c
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file provides all the BKP firmware functions.
********************************************************************************/
#if 1

#define APD_C
//#define APD_DEBUG

#include "../include/main.h"
//#include    "stm32f10x_spi_v1203.h"
void iAPDInit(void)
{
	sFLASH_CS0_Init();		// SPI2
	sFLASH_CS1_Init();		// SPI1
	
///////////////////////////////////
	iFPGA_CS1_Init();		// SPI2


//	_nFPGA_RESET = SET;
//	_nSYN_PWRDN = SET;
//	_nSYN_RST = SET;

	OSTaskCreate(iAPDTask, (void *)NULL, (OS_STK *)&APD0TaskStk[APD_START_STK_SIZE - 1], APD0_TASK_PRIO);
}

void iAPDTask(void * pdata)
{
//	INT8U tmpSwFlag = FALSE;
	OSTimeDly(100*APD0_TASK_PRIO);
	
//	iFpgaConfigDown();
//	iFPGA_ResetCtrl();
	OSTimeDly(3000);
//	iFPGA_INIT();

	while(1)
	{
		while(!DownLoadGiveupTimerSet(NULL))
		{
#if 0
			DTU_WriteData(CS0SEL, DTU_STATUS, INIT_CHECK_DATA);
			tmp1 = DTU_ReadData(CS0SEL, DTU_STATUS);
				
			Ser3Ptr->printf("DTU_STATUS[%x][%d]\n",tmp1,tmpData);
#endif
		
#if 0
			if(tmpSwFlag)	iFPGAGetStatus();
//			else			Install_StatusUpdate();
			tmpSwFlag ^= TRUE;
#endif			
			OSTimeDly(500L);
		}
		OSTimeDly(500L);
	}
}

void iFPGA_ResetCtrl(void)
{
//	_nFPGA_RESET = 0;			// DAC ENABLE!!(LOW)
	OSTimeDly(100);
//	_nFPGA_RESET = 1;			// DAC ENABLE!!(LOW)
	OSTimeDly(100);

	iFPGA_CS0_Write(Reset_CS, 0x03);
	iFPGA_CS0_Write(Reset_CS, 0x00);
	iFPGA_CS0_Write(Reset_CS, 0x00);
}

void iFPGA_INIT(void)
{
#if 0
    INT8U tmp = 0;
	__RUStatusStr *Sts = RUStatus;

	iFPGA_CS0_Write(Mode_CS, Sts->FpgaMode);

	if(Sts->FwdSigBlock) 	BitSet(tmp, 0);
	if(Sts->RvsSigBlock) 	BitSet(tmp, 1);

	iFPGA_CS0_Write(SigBlock_CS, tmp);

	Sts->DcOffsetRemoval = SET;
	iFPGA_CS0_Write(DcOffsetRemove_CS, !Sts->DcOffsetRemoval);

	FPGACfgFinish = TRUE;
#endif    
}


/******************************************************************************
* Function Name      : isItFPGACfgInit.h
* Author             : bgyoon(bgyoon.naver.com
* Date               : 2012.04.17
* Description        : prototype definition: "aa_ipad.h"
********************************************************************************
* check for fpga configuration fininish information
* 1. return value: variable "FPGACfgFinish": (1): finish, else not yet!!
*******************************************************************************/
INT8U isItFPGACfgInit(void)
{
	return FPGACfgFinish;
}


void iFPGAGetStatus(void)
{
#if 0
    INT8U tmp;
	__RUStatusStr *Sts = RUStatus;
	
	Sts->FPGAVersion = iFPGA_CS0_Read(FPGAVer_CS);
	tmp = iFPGA_CS0_Read(Tr_RxFail) & 0x01;
	
	if(!Sts->UTPRxLink && tmp){
		if(RUStatus->UTPRxLinkCnt != 0xFFFF)
		{
			RUStatus->UTPRxLinkCnt++;
		}
	}
	Sts->UTPRxLink = tmp;	

	tmp = iFPGA_CS0_Read(Lof_Count_H_CS);
	Sts->LofCountValue = (tmp << 8) | iFPGA_CS0_Read(Lof_Count_L_CS);
#endif
}

void iFPGALOFClrFunc(void)
{
	iFPGA_CS0_Write(Lof_Count_Clr_CS, 0);
	ForDelay(100);
	iFPGA_CS0_Write(Lof_Count_Clr_CS, 1);
	ForDelay(100);
	iFPGA_CS0_Write(Lof_Count_Clr_CS, 0);
}

INT8U iFpgaConfigDown(void)
{
	INT32U i = 0, j = 0;
//	INT32U rtry = 100;
	DevSPIxStr *Devptr = &FPGASpi;

	pUSART3.printf("FPGA CONFIGURATION FUNCTION START\n");
#if 0
	_nFPGA_CONF_PROG = SET;
	_nFPGA_CONF_PROG = RESET;
	OSTimeDly(1);
	_nFPGA_CONF_PROG = SET;

	OSTimeDly(30);
	while(!_nFPGA_CONF_INITB && rtry--){
		OSTimeDly(30);
	}
#endif
	{
		INT16S IsitDown = FALSE;
		INT32U getlen = 0;
		INT16U getCRC16 = 0;
		INT32U getADDR = 0;
		INT16U remain = 0;
		
#define DUMPSIZE	200			
		INT8U tmpData[DUMPSIZE];

		if((IsitDown = iFPGAConfig_DnCheck()) == -1){
			pUSART3.printf("FPGA ALL IMAGE ERROR\n");
			return FALSE;
		}

		if(IsitDown == (INT16S)FPGAAPPMODE)
		{
#if 0
            getlen = vEE_BACK1->sFlashApplArea.totalSize;
			getCRC16 = vEE_BACK1->sFlashApplArea.totalCRC;
			getADDR = sFLASH_APPLAddr;
			pUSART5.printf("FPGA APPLICATION MODE\n");
#endif
#if 0
{
	EE_BACK1 *tptr = (EE_BACK1 *)&gEE_BACK1;

	*((INT8U *)tptr + i) = ReadEEprom(At24cDevID, vEE_BACK1Addr + i, 0);

}
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainSet_LTE), Sts->FwdGainSet_LTE, 0);
#endif
		}
		else if (IsitDown == (INT16S)FPGAAPDNMODE)
		{
#if 0
            getlen = vEE_TABLE->sFlashDownArea.totalSize;
			getCRC16 = vEE_TABLE->sFlashDownArea.totalCRC;
			getADDR = sFLASH_APBKAddr;
			
			iFPGAConfig_ApplFlagSet();
			pUSART5.printf("FPGA DOWN MODE\n");
#endif            
		}
		
		FlashSwcrc16 = 0;

		FlashTotFrame = getlen/DUMPSIZE;
		remain = getlen%DUMPSIZE;
		pUSART3.printf("TotFrame = %d, getlen = %d, remain = %d\n", FlashTotFrame, getlen, remain);
		
		for(i = 0; i < FlashTotFrame && !DownLoadGiveupTimerSet(NULL); i++)
		{
			// READ!!
			sFLASH_CS0_BufferRead(getADDR + i*DUMPSIZE, tmpData, DUMPSIZE);
			FlashSwcrc16 = Crc16Calc((INT8U*)tmpData, DUMPSIZE, FlashSwcrc16);

			for(j = 0; j < DUMPSIZE; j += 2)
			{
				iFPGAConfig_SndData(Devptr, (tmpData[j + 1] << 8) | tmpData[j]);
			}

			if(IsitDown == FPGAAPDNMODE)
			{
				sFLASH_CS0_BL4kCheckErase(sFLASH_APPLAddr + i*DUMPSIZE, DUMPSIZE);
				sFLASH_CS0_DataWrite(sFLASH_APPLAddr + i*DUMPSIZE, tmpData, DUMPSIZE);
			}
			else { 
				if(!((i*DUMPSIZE)%8000)){
					OSTimeDly(10);
					pUSART3.printf(".");
				}
			}
		}
////////////////////////////////////////////////////////////////////////////////		

		OSTimeDly(10);
		if(remain)
		{
			sFLASH_CS0_BufferRead(getADDR + i*DUMPSIZE, tmpData, remain);
			FlashSwcrc16 = Crc16Calc((INT8U*)tmpData, remain, FlashSwcrc16);

			for(j = 0; j < remain && !DownLoadGiveupTimerSet(NULL); j += 2)
			{
				iFPGAConfig_SndData(Devptr, (tmpData[j + 1] << 8) | tmpData[j]);
			}

			if(IsitDown == FPGAAPDNMODE)
			{
				sFLASH_CS0_BL4kCheckErase(sFLASH_APPLAddr + i*DUMPSIZE, DUMPSIZE);
				sFLASH_CS0_DataWrite(sFLASH_APPLAddr + i*DUMPSIZE, tmpData, DUMPSIZE);
			}

		}

		if(IsitDown == FPGAAPDNMODE && !DownLoadGiveupTimerSet(NULL))
		{
			iFPGAConfig_DnFlagRst();
		}
		
pUSART3.printf("\n");
pUSART3.printf("Swcrc16 = %04x, getCRC16 = %04x\n", FlashSwcrc16, getCRC16);
	}
	OSTimeDly(100);
	
//	if(_nFPGA_CONF_DONE)	pUSART3.printf("DONE\n");
//	else					pUSART3.printf("FAIL\n");

    return TRUE;	
}



void iFPGAConfig_SndData(DevSPIxStr *Devptr, INT16U DATA)
{
	INT8U err;

	OSSemPend(Devptr->OSSem, 0, &err);

	SetSPIxCommand(Devptr->SPIx, DATA);

	OSSemPost(Devptr->OSSem);
}

INT16U ReadFPGAData(DevSPIxStr *Devptr, INT16U ADDR)
{
	INT16U rval;
	INT8U err = 0;

	OSSemPend(Devptr->OSSem, 0, &err);

	iDev_SPIx_CS_RST(Devptr->nDevNo);

	SetSPIxCommand(Devptr->SPIx, ADDR | 0x80);
	rval = SetSPIxCommand(Devptr->SPIx, NULL);

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);

	return (rval);
}

void WriteFPGA(DevSPIxStr *Devptr, INT16U ADDR, INT8U DATA)
{
	INT8U err = 0;

	OSSemPend(Devptr->OSSem, 0, &err);
	
	iDev_SPIx_CS_RST(Devptr->nDevNo);

	SetSPIxCommand(Devptr->SPIx, ADDR);
	SetSPIxCommand(Devptr->SPIx, DATA);

	iDev_SPIx_CS_SET(Devptr->nDevNo);
	
	OSSemPost(Devptr->OSSem);
}

/////////////////////////////////////////////////////////////////////////////////
void iSPIxInit(DevSPIxStr *Devptr)
{
	iDev_SPIxInit(Devptr->SPIx);
	iDev_SPIx_CS_SET(Devptr->nDevNo);
}

void  iDev_SPIx_CS_SET(INT8U nDev)
{
		 if(nDev == SPI_FLASHCH) 	_nFLASH_nCS1 = 1;  ///SPI2
	else if(nDev == SPI_FLASHCH1) 	_nFPGA_nCS0 = 1;   ///SPI1
//////////////////////20150420 Adder
	else if(nDev == SPI_FLASH_CH0)	_nFLASH_nCS1 = 1;   ///SPI2
	else if(nDev == SPI_FLASH_CH1)	_nFPGA_nCS0 = 1;   ///SPI1
	else if(nDev == SPI_AD9528)		_nFPGA_nCS0 = 1;   ///SPI2
	else if(nDev == SPI_ADC9368)	_nFPGA_nCS0 = 1;   ///SPI2
	else if(nDev == SPI_ADC9652)	_nFPGA_nCS0 = 1;   ///SPI2
}

void iDev_SPIx_CS_RST(INT8U nDev)
{
		 if(nDev == SPI_FLASHCH) 	_nFLASH_nCS1 = 0;
	else if(nDev == SPI_FLASHCH1) 	_nFPGA_nCS0 = 0;

	else if(nDev == SPI_FLASH_CH0)	_nFLASH_nCS1 = 0;	///SPI2
	else if(nDev == SPI_FLASH_CH1)	_nFPGA_nCS0 = 0;   ///SPI1
	else if(nDev == SPI_AD9528) 	_nFPGA_nCS0 = 0;   ///SPI2
	else if(nDev == SPI_ADC9368)	_nFPGA_nCS0 = 0;   ///SPI2
	else if(nDev == SPI_ADC9652)	_nFPGA_nCS0 = 0;   ///SPI2
	
}
	
SPI_TypeDef *iDev_SPIx_BASE(INT8U SPIx)
{
	SPI_TypeDef *nBASE;
	
	     if(SPIx == USE_SPI2) 	nBASE = SPI2;
	else if(SPIx == USE_SPI1) 	nBASE = SPI1;
	else 						nBASE = SPI3;

	return nBASE;
}

void iDev_SPIxInit(INT8U SPIx)
{
    if(SPIx == USE_SPI1) {
		__PA5_SPI_SCK();  /// SPI1_SCK
		__PA6_SPI_MISO(); /// SPI1_MISO
		__PA7_SPI_MOSI(); /// SPI1_MOSI

		SPI1Init();
	}
	else if(SPIx == USE_SPI2) {
		__PB13_SPI_SCK();  ////SPI2_SCK
		__PC2_SPI_MISO(); //// SPI2_MISO
		__PC3_SPI_MOSI(); ///  SPI2_MOSI
		SPI2Init();
	}
}

INT16U SetSPIxCommand(INT8U SPIx, INT16U Comm)
{
	SPI_TypeDef *nBASE = iDev_SPIx_BASE(SPIx);
	

//	pUSART1.printf("SetSPIxCommand = %x \n", Comm);

	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_TXE) == RESET); 	// Wait to Transfer a byte
	SPI_I2S_SendData(nBASE, Comm);                                     	// Send SPI2 data
	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_RXNE) == RESET);    // Wait to receive a byte
	return SPI_I2S_ReceiveData(nBASE);                                 	// Return the byte read from the SPI bus
}


INT16U SetSPIxCommand_Test(INT8U SPIx, INT16U Comm)
{
	SPI_TypeDef *nBASE = iDev_SPIx_BASE(SPIx);
	
	pUSART1.printf("SetSPIxCommand = %x \n", Comm);

	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_TXE) == RESET); 	// Wait to Transfer a byte
	SPI_I2S_SendData(nBASE, Comm);                                     	// Send SPI2 data
	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_RXNE) == RESET);    // Wait to receive a byte
	return SPI_I2S_ReceiveData(nBASE);                                 	// Return the byte read from the SPI bus
}



INT16S iFPGAConfig_DnCheck(void)
{
	INT16S rval = FALSE;
#if 0
	     if(vEE_TABLE->sFlashDownArea.DnFlag == FPGAAPDNMODE)rval = FPGAAPDNMODE;
	else if(vEE_BACK1->sFlashApplArea.DnFlag == FPGAAPPMODE) rval = FPGAAPPMODE;
	else rval = -1;	// Image Error(Init Value)
#endif
	return rval;
}

void iFPGAConfig_DnFlagSet(INT32S nSize, INT16U nCRC)
{
#if 0
    INT32U cpu_sr;
	EE_TABLE *tptr;
	
	OS_ENTER_CRITICAL();

	tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // Load 1st Area	

	tptr->sFlashDownArea.totalSize = nSize;
	tptr->sFlashDownArea.totalCRC = nCRC;
	tptr->sFlashDownArea.DnFlag = FPGAAPDNMODE;
	
	WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));	

	OS_EXIT_CRITICAL();
#endif



#if 1
	INT8U i;
	type32 tmp32;
	type16 tmp16;

    INT32U cpu_sr;
//	EE_TABLE *tptr;
	
	OS_ENTER_CRITICAL();

//	tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // Load 1st Area	
	EE_BACK1 *tptr = &gEE_BACK1;


	tptr->BackUp.sFlashDownArea.totalSize.uD32 = nSize;
	tmp32.uD32 = nSize;
	for(i = 0; i < 4; i++)
	{
		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.sFlashDownArea.totalSize.uD8[i]), tmp32.uD8[i], 0);
	}	
	
	tptr->BackUp.sFlashDownArea.totalCRC.uD32 = nCRC;
	tmp32.uD32 = nCRC;
	for(i = 0; i < 4; i++)
	{
		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.sFlashDownArea.totalCRC.uD8[i]), tmp32.uD8[i], 0);
	}	

	tptr->BackUp.sFlashDownArea.DnFlag.uD16 = FPGAAPDNMODE;
	tmp16.uD16 = FPGAAPDNMODE;
	for(i = 0; i < 2; i++)
	{
		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.sFlashDownArea.DnFlag.uD8[i]), tmp16.uD8[i], 0);
	}	
//	WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));	
//	tptr->BackUp.FwdOutUpperLmt_3G[0] = Sts->FwdOutUpperLmt_3G[0];

//	WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_3G[i]), Sts->FwdOutUpperLmt_3G[i], 0);


	OS_EXIT_CRITICAL();
#endif

}

void iFPGAConfig_ApplFlagSet(void)
{
#if 1
#if 0
    INT32U cpu_sr;
	EE_BACK1 *tptr;
	
	OS_ENTER_CRITICAL();
	tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area	

	tptr->sFlashApplArea.DnFlag = FPGAAPDNMODE;

	WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));	
#endif

	{
	#if 0
		INT8U i;
		EE_BACK1 *tptr = &gEE_BACK1;
		tptr->BackUp.FPGADownLoadFlag1 = (INT8U)(FPGAAPDNMODE >> 8);
		tptr->BackUp.FPGADownLoadFlag2 = (INT8U)(FPGAAPDNMODE     );

		for(i = 0; i < 2; i++)
		{
			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_3G[i]), Sts->FwdOutUpperLmt_3G[i], 0);
		}
	#endif	
  		EE_BACK1 *tptr = &gEE_BACK1;

		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FPGADownLoadFlag1), (INT8U)(FPGAAPDNMODE >> 8), 0);
		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FPGADownLoadFlag1), (INT8U)(FPGAAPDNMODE 	  ), 0);

	}
	
//	OS_EXIT_CRITICAL();
 #endif
  
}


void iFPGAConfig_DnFlagRst(void)
{
#if 0
//   INT32U nSize = vEE_TABLE->sFlashDownArea.totalSize;
//   INT32U nCRC  = vEE_TABLE->sFlashDownArea.totalCRC;

	INT32U nSize = 0;
	INT32U nCRC = 0;
	INT8U i = 0;
	
	INT32U cpu_sr;

	{
//		EE_BACK1 *tptr;
		EE_BACK1 *tptr = &gEE_BACK1;
		
		OS_ENTER_CRITICAL();

//		tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area	

		tptr->BackUp.sFlashApplArea.totalSize.sD32 = nSize;
		tptr->BackUp.sFlashApplArea.totalCRC.sD32 = nCRC;
		tptr->BackUp.sFlashApplArea.DnFlag.sD16 = FPGAAPPMODE;

//		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdGainSet_3G), Sts->FwdGainSet_3G, 0);

		
//		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));	
		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.SampleOffsetA.sD8[i]), Sts->SampleOffsetA.sD8[i], 0);

#if 1
		for(i = 0; i < 2; i++)
		{
//			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.SampleOffsetA.sD8[i]), Sts->SampleOffsetA.sD8[i], 0);

//			WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FwdOutUpperLmt_3G[i]), Sts->FwdOutUpperLmt_3G[i], 0);
		}
#endif

		OS_EXIT_CRITICAL();
	}
#if 0
	{
		EE_TABLE *tptr;
		
		OS_ENTER_CRITICAL();

		tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // Load 1st Area	

		tptr->sFlashDownArea.DnFlag = FPGAAPPMODE;
		
		WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));	
		OS_EXIT_CRITICAL();
	}
#endif
#endif    

}
#endif



#if 0
/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_bkp.c
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file provides all the BKP firmware functions.
********************************************************************************/

#define APD_C
//#define APD_DEBUG

#include "../include/main.h"

void iAPDInit(void)
{
	sFLASH_CS0_Init();		// SPI2
	iFPGA_CS0_Init();		// SPI2
	
//	iFPGAConfig_CS_Init();	// SPI1

	_nFPGA_RESET = SET;
//	_nSYN_PWRDN = SET;
//	_nSYN_RST = SET;

	OSTaskCreate(iAPDTask, (void *)NULL, (OS_STK *)&APD0TaskStk[APD_START_STK_SIZE - 1], APD0_TASK_PRIO);

}

void iAPDTask(void * pdata)
{
	INT8U tmpSwFlag = FALSE;
	OSTimeDly(100*APD0_TASK_PRIO);
	

	iFpgaConfigDown();
	iFPGA_ResetCtrl();
	OSTimeDly(3000);
	iFPGA_INIT();

	while(1)
	{
		while(!DownLoadGiveupTimerSet(NULL))
		{
//			if(tmpSwFlag)	iFPGAGetStatus();
//			else			Install_StatusUpdate();
			tmpSwFlag ^= TRUE;
			
			OSTimeDly(500L);
		}
		OSTimeDly(500L);
	}
}

void iFPGA_ResetCtrl(void)
{
	_nFPGA_RESET = 0;			// DAC ENABLE!!(LOW)
	OSTimeDly(100);
	_nFPGA_RESET = 1;			// DAC ENABLE!!(LOW)
	OSTimeDly(100);

	iFPGA_CS0_Write(Reset_CS, 0x03);
	iFPGA_CS0_Write(Reset_CS, 0x00);
	iFPGA_CS0_Write(Reset_CS, 0x00);
}

void iFPGA_INIT(void)
{
#if 0
    INT8U tmp = 0;
	__RUStatusStr *Sts = RUStatus;

	iFPGA_CS0_Write(Mode_CS, Sts->FpgaMode);

	if(Sts->FwdSigBlock) 	BitSet(tmp, 0);
	if(Sts->RvsSigBlock) 	BitSet(tmp, 1);

	iFPGA_CS0_Write(SigBlock_CS, tmp);

	Sts->DcOffsetRemoval = SET;
	iFPGA_CS0_Write(DcOffsetRemove_CS, !Sts->DcOffsetRemoval);

	FPGACfgFinish = TRUE;
#endif    
}


/******************************************************************************
* Function Name      : isItFPGACfgInit.h
* Author             : bgyoon(bgyoon.naver.com
* Date               : 2012.04.17
* Description        : prototype definition: "aa_ipad.h"
********************************************************************************
* check for fpga configuration fininish information
* 1. return value: variable "FPGACfgFinish": (1): finish, else not yet!!
*******************************************************************************/

INT8U isItFPGACfgInit(void)
{
	return FPGACfgFinish;
}


void iFPGAGetStatus(void)
{
#if 0
    INT8U tmp;
	__RUStatusStr *Sts = RUStatus;
	
	Sts->FPGAVersion = iFPGA_CS0_Read(FPGAVer_CS);
	tmp = iFPGA_CS0_Read(Tr_RxFail) & 0x01;
	
	if(!Sts->UTPRxLink && tmp){
		if(RUStatus->UTPRxLinkCnt != 0xFFFF)
		{
			RUStatus->UTPRxLinkCnt++;
		}
	}
	Sts->UTPRxLink = tmp;	

	tmp = iFPGA_CS0_Read(Lof_Count_H_CS);
	Sts->LofCountValue = (tmp << 8) | iFPGA_CS0_Read(Lof_Count_L_CS);
#endif
}

void iFPGALOFClrFunc(void)
{
	iFPGA_CS0_Write(Lof_Count_Clr_CS, 0);
	ForDelay(100);
	iFPGA_CS0_Write(Lof_Count_Clr_CS, 1);
	ForDelay(100);
	iFPGA_CS0_Write(Lof_Count_Clr_CS, 0);
}

INT8U iFpgaConfigDown(void)
{
	INT32U i = 0, j = 0;
	INT32U rtry = 100;
	DevSPIxStr *Devptr = &FPGACfgSpi;

	pUSART3.printf("FPGA CONFIGURATION FUNCTION START\n");
	
	_nFPGA_CONF_PROG = SET;
	_nFPGA_CONF_PROG = RESET;
	OSTimeDly(1);
	_nFPGA_CONF_PROG = SET;

	OSTimeDly(30);
	while(!_nFPGA_CONF_INITB && rtry--){
		OSTimeDly(30);
	}

	{
		INT16S IsitDown = FALSE;
		INT32U getlen = 0;
		INT16U getCRC16 = 0;
		INT32U getADDR = 0;
		INT16U remain = 0;
		
#define DUMPSIZE	200			
		INT8U tmpData[DUMPSIZE];

		if((IsitDown = iFPGAConfig_DnCheck()) == -1){
			pUSART3.printf("FPGA ALL IMAGE ERROR\n");
			return FALSE;
		}

		if(IsitDown == (INT16S)FPGAAPPMODE)
		{
			getlen = vEE_BACK1->sFlashApplArea.totalSize;
			getCRC16 = vEE_BACK1->sFlashApplArea.totalCRC;
			getADDR = sFLASH_APPLAddr;
			pUSART3.printf("FPGA APPLICATION MODE\n");
		}
		else if (IsitDown == (INT16S)FPGAAPDNMODE)
		{
			getlen = vEE_TABLE->sFlashDownArea.totalSize;
			getCRC16 = vEE_TABLE->sFlashDownArea.totalCRC;
			getADDR = sFLASH_APBKAddr;
			
			iFPGAConfig_ApplFlagSet();
			pUSART3.printf("FPGA DOWN MODE\n");
		}
		
		FlashSwcrc16 = 0;

		FlashTotFrame = getlen/DUMPSIZE;
		remain = getlen%DUMPSIZE;
		pUSART3.printf("TotFrame = %d, getlen = %d, remain = %d\n", FlashTotFrame, getlen, remain);
		
		for(i = 0; i < FlashTotFrame && !DownLoadGiveupTimerSet(NULL); i++)
		{
			// READ!!
			sFLASH_CS0_BufferRead(getADDR + i*DUMPSIZE, tmpData, DUMPSIZE);
			FlashSwcrc16 = Crc16Calc((INT8U*)tmpData, DUMPSIZE, FlashSwcrc16);

			for(j = 0; j < DUMPSIZE; j += 2)
			{
				iFPGAConfig_SndData(Devptr, (tmpData[j + 1] << 8) | tmpData[j]);
			}

			if(IsitDown == FPGAAPDNMODE)
			{
				sFLASH_CS0_BL4kCheckErase(sFLASH_APPLAddr + i*DUMPSIZE, DUMPSIZE);
				sFLASH_CS0_DataWrite(sFLASH_APPLAddr + i*DUMPSIZE, tmpData, DUMPSIZE);
			}
			else { 
				if(!((i*DUMPSIZE)%8000)){
					OSTimeDly(10);
					pUSART3.printf(".");
				}
			}
		}
////////////////////////////////////////////////////////////////////////////////		

		OSTimeDly(10);
		if(remain)
		{
			sFLASH_CS0_BufferRead(getADDR + i*DUMPSIZE, tmpData, remain);
			FlashSwcrc16 = Crc16Calc((INT8U*)tmpData, remain, FlashSwcrc16);

			for(j = 0; j < remain && !DownLoadGiveupTimerSet(NULL); j += 2)
			{
				iFPGAConfig_SndData(Devptr, (tmpData[j + 1] << 8) | tmpData[j]);
			}

			if(IsitDown == FPGAAPDNMODE)
			{
				sFLASH_CS0_BL4kCheckErase(sFLASH_APPLAddr + i*DUMPSIZE, DUMPSIZE);
				sFLASH_CS0_DataWrite(sFLASH_APPLAddr + i*DUMPSIZE, tmpData, DUMPSIZE);
			}

		}

		if(IsitDown == FPGAAPDNMODE && !DownLoadGiveupTimerSet(NULL))
		{
			iFPGAConfig_DnFlagRst();
		}
		
pUSART3.printf("\n");
pUSART3.printf("Swcrc16 = %04x, getCRC16 = %04x\n", FlashSwcrc16, getCRC16);
	}
	OSTimeDly(100);
	
	if(_nFPGA_CONF_DONE)	pUSART3.printf("DONE\n");
	else					pUSART3.printf("FAIL\n");

    return TRUE;	
}



void iFPGAConfig_SndData(DevSPIxStr *Devptr, INT16U DATA)
{
	INT8U err;

	OSSemPend(Devptr->OSSem, 0, &err);

	SetSPIxCommand(Devptr->SPIx, DATA);

	OSSemPost(Devptr->OSSem);
}

INT16U ReadFPGAData(DevSPIxStr *Devptr, INT16U ADDR)
{
	INT16U rval;
	INT8U err = 0;

	OSSemPend(Devptr->OSSem, 0, &err);

	iDev_SPIx_CS_RST(Devptr->nDevNo);

	SetSPIxCommand(Devptr->SPIx, ADDR | 0x80);
	rval = SetSPIxCommand(Devptr->SPIx, NULL);

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);

	return (rval);
}

void WriteFPGA(DevSPIxStr *Devptr, INT16U ADDR, INT8U DATA)
{
	INT8U err = 0;

	OSSemPend(Devptr->OSSem, 0, &err);
	
	iDev_SPIx_CS_RST(Devptr->nDevNo);

	SetSPIxCommand(Devptr->SPIx, ADDR);
	SetSPIxCommand(Devptr->SPIx, DATA);

	iDev_SPIx_CS_SET(Devptr->nDevNo);
	
	OSSemPost(Devptr->OSSem);
}

/////////////////////////////////////////////////////////////////////////////////
void iSPIxInit(DevSPIxStr *Devptr)
{
	iDev_SPIxInit(Devptr->SPIx);
	iDev_SPIx_CS_SET(Devptr->nDevNo);
}

#if 1
void  iDev_SPIx_CS_SET(INT8U nDev)
{
		 if(nDev == SPI_FLASHCH) 	_nFLASH_nCS1 = 1;  ///SPI2
	else if(nDev == SPI_FLASHCH1) 	_nFPGA_nCS0 = 1;   ///SPI1
}

void iDev_SPIx_CS_RST(INT8U nDev)
{
		 if(nDev == SPI_FLASHCH) 	_nFLASH_nCS1 = 0;
	else if(nDev == SPI_FLASHCH1) 	_nFPGA_nCS0 = 0;
}
	
SPI_TypeDef *iDev_SPIx_BASE(INT8U SPIx)
{
	SPI_TypeDef *nBASE;
	
	     if(SPIx == USE_SPI2) 	nBASE = SPI2;
	else if(SPIx == USE_SPI1) 	nBASE = SPI1;
	else 						nBASE = SPI3;

	return nBASE;
}

void iDev_SPIxInit(INT8U SPIx)
{
    if(SPIx == USE_SPI1) {
//		GPIOA->CNF.B5 = __SPI1_SCK;
//		GPIOA->CNF.B7 = __SPI1_MOSI;
//		GPIOA->CNF.B6 = __SPI1_MISO;
		__PA5_SPI_SCK();  /// SPI1_SCK
		__PA6_SPI_MISO(); /// SPI1_MISO
		__PA7_SPI_MOSI(); /// SPI1_MOSI

		SPI1Init();
	}
	else if(SPIx == USE_SPI2) {
		__PB13_SPI_SCK();  ////SPI2_SCK
		__PC2_SPI_MISO(); //// SPI2_MISO
		__PC3_SPI_MOSI(); ///  SPI2_MOSI
		SPI2Init();
	}
}



#endif


INT16U SetSPIxCommand(INT8U SPIx, INT16U Comm)
{
	SPI_TypeDef *nBASE = iDev_SPIx_BASE(SPIx);
	
	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_TXE) == RESET); 	// Wait to Transfer a byte
	SPI_I2S_SendData(nBASE, Comm);                                     	// Send SPI2 data
	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_RXNE) == RESET);    // Wait to receive a byte
	return SPI_I2S_ReceiveData(nBASE);                                 	// Return the byte read from the SPI bus
}


INT16S iFPGAConfig_DnCheck(void)
{
	INT16S rval = FALSE;

	     if(vEE_TABLE->sFlashDownArea.DnFlag == FPGAAPDNMODE)rval = FPGAAPDNMODE;
	else if(vEE_BACK1->sFlashApplArea.DnFlag == FPGAAPPMODE) rval = FPGAAPPMODE;
	else rval = -1;	// Image Error(Init Value)

	return rval;
}

void iFPGAConfig_DnFlagSet(INT32S nSize, INT16U nCRC)
{
	INT32U cpu_sr;
	EE_TABLE *tptr;
	
	OS_ENTER_CRITICAL();

	tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // Load 1st Area	

	tptr->sFlashDownArea.totalSize = nSize;
	tptr->sFlashDownArea.totalCRC = nCRC;
	tptr->sFlashDownArea.DnFlag = FPGAAPDNMODE;
	
	WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));	

	OS_EXIT_CRITICAL();
}

void iFPGAConfig_ApplFlagSet(void)
{
	INT32U cpu_sr;
	EE_BACK1 *tptr;
	
	OS_ENTER_CRITICAL();

	tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area	

	tptr->sFlashApplArea.DnFlag = FPGAAPDNMODE;

	WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));	

	OS_EXIT_CRITICAL();
}
#endif

#if 0
void iFPGAConfig_DnFlagRst1(void)
{
	INT32U nSize = vEE_TABLE->sFlashDownArea.totalSize;
	INT32U nCRC  = vEE_TABLE->sFlashDownArea.totalCRC;
	
	INT32U cpu_sr;

	{
		EE_BACK1 *tptr;
		
		OS_ENTER_CRITICAL();

		tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area	

		tptr->sFlashApplArea.totalSize = nSize;
		tptr->sFlashApplArea.totalCRC = nCRC;
		tptr->sFlashApplArea.DnFlag = FPGAAPPMODE;
		
		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));	

		OS_EXIT_CRITICAL();
	}
	
	{
		EE_TABLE *tptr;
		
		OS_ENTER_CRITICAL();

		tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // Load 1st Area	

		tptr->sFlashDownArea.DnFlag = FPGAAPPMODE;
		
		WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));	

		OS_EXIT_CRITICAL();
	}

}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////







#endif



/*!******************************************************************************
* @fn		INT32U ReadFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
* @brief	to read spi datas for each channel	
* @return	length of Read
* @param	OPCODE : ndev channel no
* @param	ADDR   : spi Address
* @param	DATA   : data point read
* @param	nlen   : length read
* @remarks	prototype is declared in ther iapd.h
********************************************************************************/

INT32U ReadFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
{
	return (iFPGA_GetRegister(&iFPGASpi, OPCODE, (ADDR & 0x7fff), DATA, nlen));
}

/*!******************************************************************************
* @fn		void WriteFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
* @brief	to write spi datas for each channel	
* @return	none
* @param	OPCODE : ndev channel no
* @param	ADDR   : spi Address
* @param	DATA   : data point write
* @param	nlen   : length of writing
* @remarks	prototype is declared in ther iapd.h
********************************************************************************/

void WriteFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen)
{
	iFPGA_SetRegister(&iFPGASpi, OPCODE, (ADDR | 0x8000), DATA, nlen);
}

/*!******************************************************************************
* @fn		INT32S sFLASH_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
* @brief	to read/write spi datas for each channel	
* @return	length of Read/writed
* @param	Devptr : spi pointer
* @param	OPCODE : ndev channel no
* @param	ADDR   : spi Address
* @param	DATA   : data point returned or write
* @param	nlen   : length returned or write
* @remarks	prototype is declared in ther iapd.h
********************************************************************************/

INT32S iFPGA_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
{
	INT32U i = 0;
	INT8U err = 0;

	OSSemPend(Devptr->OSSem, 0, &err);

	Devptr->nDevNo = OPCODE;

	ADDR |= ((nlen - 1) & 0x07) << 12;

	iDev_SPIx_CS_RST(Devptr->nDevNo);
		
	SetSPIxCommand(Devptr->SPIx, (ADDR >>  8) & 0xFF);
	SetSPIxCommand(Devptr->SPIx, (ADDR >>  0) & 0xFF);

	for(i = 0; i < nlen && i < 4; i++)
	{
		SetSPIxCommand(Devptr->SPIx, DATA[i]);
	}

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);
	return i;
}

INT32S iFPGA_GetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
{
	INT32U i = 0;
	INT8U err = 0;

	OSSemPend(Devptr->OSSem, 0, &err);

	Devptr->nDevNo = OPCODE;

	ADDR |= ((nlen - 1) & 0x07) << 12;

	iDev_SPIx_CS_RST(Devptr->nDevNo);
		
	SetSPIxCommand(Devptr->SPIx, (ADDR >>  8) & 0xFF);
	SetSPIxCommand(Devptr->SPIx, (ADDR >>  0) & 0xFF);

	for(i = 0; i < nlen && i < 4; i++)
	{
		DATA[i] = SetSPIxCommand(Devptr->SPIx, DATA[i]);
	}

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	OSSemPost(Devptr->OSSem);
	return i;
}





/////////////////////////////////////////////////////////////////////////////////
#if 0
void iSPIxInit(DevSPIxStr *Devptr)
{
	iDev_SPIxInit(Devptr->SPIx);
	iDev_SPIx_CS_SET(Devptr->nDevNo);
}

void  iDev_SPIx_CS_SET(INT8U nDev)
{
         if(nDev == SPI_3G_TX_CH) 	_3G_SPI_TX_nCS = 1;
	else if(nDev == SPI_3G_RX_CH) 	_3G_SPI_RX_nCS = 1;
	else if(nDev == SPI_4G_TX_CH) 	_4G_SPI_TX_nCS = 1;
	else if(nDev == SPI_4G_RX_CH) 	_4G_SPI_RX_nCS = 1;
	else if(nDev == SPI_FPGA_CH) 	_FPGA_SPI_RX_nCS = 1;

}

void iDev_SPIx_CS_RST(INT8U nDev)
{
         if(nDev == SPI_3G_TX_CH) 	_3G_SPI_TX_nCS = 0;
	else if(nDev == SPI_3G_RX_CH) 	_3G_SPI_RX_nCS = 0;
	else if(nDev == SPI_4G_TX_CH) 	_4G_SPI_TX_nCS = 0;
	else if(nDev == SPI_4G_RX_CH) 	_4G_SPI_RX_nCS = 0;
	else if(nDev == SPI_FPGA_CH) 	_FPGA_SPI_RX_nCS = 0;
}

SPI_TypeDef *iDev_SPIx_BASE(INT8U SPIx)
{
	SPI_TypeDef *nBASE;
	
	     if(SPIx == USE_SPI2) 	nBASE = SPI2;
	else if(SPIx == USE_SPI1) 	nBASE = SPI1;
	else 						nBASE = SPI3;

	return nBASE;
}

void iDev_SPIxInit(INT8U SPIx)
{
	if(SPIx == USE_SPI1) {
		GPIOA->CNF.B5 = __SPI1_SCK;
		GPIOA->CNF.B7 = __SPI1_MOSI;
		GPIOA->CNF.B6 = __SPI1_MISO;
		SPI1Init();
	}
	else if(SPIx == USE_SPI2) {
		GPIOB->CNF.B13 = __SPI2_SCK; 
		GPIOB->CNF.B15 = __SPI2_MOSI; 
		GPIOB->CNF.B14 = __SPI2_MISO; 
		SPI2Init();
	}
	else if(SPIx == USE_SPI3) {
		GPIOB->CNF.B3 = __SPI3_SCK; 
		GPIOB->CNF.B5 = __SPI3_MOSI; 
		GPIOB->CNF.B4 = __SPI3_MISO; 
		SPI3Init();
	}
}

INT16U SetSPIxCommand(INT8U SPIx, INT16U Comm)
{
	SPI_TypeDef *nBASE = iDev_SPIx_BASE(SPIx);
	
	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_TXE) == RESET); 	// Wait to Transfer a byte
	SPI_I2S_SendData(nBASE, Comm);                                     	// Send SPI2 data
	while(SPI_I2S_GetFlagStatus(nBASE, SPI_I2S_FLAG_RXNE) == RESET);    // Wait to receive a byte
	return SPI_I2S_ReceiveData(nBASE);                                 	// Return the byte read from the SPI bus
}

#endif



////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////


