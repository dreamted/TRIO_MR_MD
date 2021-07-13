/*******************************************************************************
 *
 * This module contains the function STM32F103xxx original source file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2008 - bizistyle(bgyoon@naver.com), All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2008.07.
* v1010: APPEND + LIS33DL 
 ******************************************************************************/
#define LIS03LV02_C
//#define LIS03LV02_DBG

#include <math.h>
#include "../include/main.h"

INT8U DevName;

#if defined(USE_SPI1)
	#define LIS_CS_SET()	GPIOA->ODR.B4 = 1
	#define LIS_CS_RST()	GPIOA->ODR.B4 = 0
	#define LIS_BASE		SPI1
#elif defined(USE_SPI2)
	#define LIS_CS_SET()	GPIOB->ODR.B12 = 1
	#define LIS_CS_RST()	GPIOB->ODR.B12 = 0
	#define LIS_BASE		SPI2
#else
	#define LIS_CS_SET()
	#define LIS_CS_RST()
	#define LIS_BASE
#endif

void Lis03lv02init(void)
{
//int i;
	#ifdef USE_SPI1
		//////////////////////////////////
		// Port
		GPIOA->CNF.B4 = __PA4_OU_PP;
		GPIOA->CNF.B5 = __SPI1_SCK;
		GPIOA->CNF.B7 = __SPI1_MOSI;
		GPIOA->CNF.B6 = __SPI1_MISO;

		SPI1Init();		
	#elif defined(USE_SPI2)
		GPIOB->CNF.B12 = __PB12_OU_PP;
		GPIOB->CNF.B13 = __SPI2_SCK;
		GPIOB->CNF.B15 = __SPI2_MOSI;
		GPIOB->CNF.B14 = __SPI2_MISO;
		SPI2Init();
	#endif
	LIS_CS_SET();
    DevName = ReadLSIData(WHO_AM_I);
#ifdef LIS03LV02_DBG	
	USART1Printf("CTRL REG:0x%02xh\n", ReadLSIData(CTRL_REG1));
	USART1Printf("WHO AM I:0x%02xh\n", DevName);
#endif

	{
		LIS_CTRLReg Ctrl;

		Ctrl.Data = 0;
		Ctrl.Xen = 1;
		Ctrl.Yen = 1;
		Ctrl.Zen = 1;
		Ctrl.PD = DEON;
		
		WriteLSI(CTRL_REG1, Ctrl.Data);		//myAccel3LV02 √ ±‚»≠ 1000.0111 Power on, enable all axis, self test off     
	}
}


INT8S SlopeConvert(TITLSTR *rval)
{
	double dval;
	
	INT16S	TempX = 0;
	INT16S	TempY = 0;
	INT16S	TempZ = 0;
		
	TempX  |= (ReadLSIData(OUTX_L) & 0xff) << 0;
	TempX  |= (ReadLSIData(OUTX_H) & 0xff) << 8;
	
	TempY  |= (ReadLSIData(OUTY_L) & 0xff) << 0;
	TempY  |= (ReadLSIData(OUTY_H) & 0xff) << 8;

	TempZ  |= (ReadLSIData(OUTZ_L) & 0xff) << 0;
	TempZ  |= (ReadLSIData(OUTZ_H) & 0xff) << 8;

#ifdef LIS03LV02_DBG
	USART1Printf("TempX:%03d\n",    TempX);
	USART1Printf("TempY:%03d\n",    TempY);
	USART1Printf("TempZ:%03d\n\n",TempZ);
#endif
	dval = (double)TempX/1024.0;
	rval->xradian = (INT16S)((asinf(dval)*1800)/3.14);
#ifdef LIS03LV02_DBG
	USART1Printf("x-val:%d\n", rval->xradian/10);
#endif

	dval = (double)TempY/1024.0;
	rval->yradian = (INT16S)((asinf(dval)*1800)/3.14);
#ifdef LIS03LV02_DBG
	USART1Printf("y-val:%d\n", rval->yradian/10);
#endif

	dval = (double)TempZ/1024.0;
	rval->zradian = (INT16S)((acosf(dval)*1800)/3.14);
#ifdef LIS03LV02_DBG
	USART1Printf("z-val:%d\n", rval->zradian/10);
#endif
    
	return TRUE;
}

INT16U SetLSICommand(INT16U Comm)
{
	//INT8U rtry = 0xff;
	
	//while(rtry-- && SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_TXE) == RESET);
	while(SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_TXE) == RESET);
	// Send SPI2 data
	SPI_I2S_SendData(LIS_BASE, Comm);
	// Wait to receive a byte
  	while(SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_RXNE) == RESET);
	//while(rtry-- && SPI_I2S_GetFlagStatus(LIS_BASE, SPI_I2S_FLAG_RXNE) == RESET);
	// Return the byte read from the SPI bus
	return SPI_I2S_ReceiveData(LIS_BASE);
}

void WriteLSI(INT16U Comm, INT8U DATA)
{
	LIS_CS_RST();

	SetLSICommand(MA3_ADDR_WR(Comm));
	SetLSICommand(DATA);

	LIS_CS_SET();
}

INT8U ReadLSICtrl(INT8U Comm)
{
	INT8U rval;
	LIS_CS_RST();

		
	SetLSICommand(Comm);
	rval = SetLSICommand(NULL);

	LIS_CS_SET();

	return rval;
}


INT16U ReadLSIData(INT16U Comm)
{
	INT16U rval;
	LIS_CS_RST();

	SetLSICommand(MA3_ADDR_RD(Comm));
	rval = SetLSICommand(NULL);
	
	LIS_CS_SET();
	return (rval);
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

