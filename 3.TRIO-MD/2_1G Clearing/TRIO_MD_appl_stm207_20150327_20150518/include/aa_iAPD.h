/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_bkp.c
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file provides all the BKP firmware functions.
********************************************************************************/
#ifdef APD_C
	#define	_USR_EXT_APD
#else
	#define _USR_EXT_APD		extern
#endif


#pragma pack(1)



#pragma pack()

#define Reset_CS			0x00
#define Mode_CS				0x01
#define SigBlock_CS			0x02
#define DcOffsetRemove_CS	0x03
#define Tr_RxFail			0x04
#define Ru_SumAlm_CS		0x05

#define Lof_Count_Clr_CS	0x20
#define Lof_Count_H_CS		0x21
#define Lof_Count_L_CS		0x22

#define FPGAVer_CS			0x7F


#define SPI_FLASHCH				0
#define SPI_FLASHCH1			1


// 
#define FPGAAPDNMODE	0x5AA5  // Application download set
#define FPGAAPPMODE		0xA55A  // download rst

#define sFLASH_APPLAddr	0

//#define sFLASH_APPLAddr	(4*1024*1024)

//#define sFLASH_APBKAddr	(4*1024)


#define sFLASH_APBKAddr			(0*1024*1024)
#define s1FLASH_APBKAddr		0x01000000


//	9F8800	  10455040
////////////////////////////////////////////////////////////////////////////////
// Global Variables Definition
//////////////////////////////


#define SPI_3G_TX_CH			0
#define SPI_3G_RX_CH			1
#define SPI_4G_TX_CH			2
#define SPI_4G_RX_CH			3
#define SPI_FPGA_CH				4


#define SPI_FLASH_CH0			0
#define SPI_FLASH_CH1			1
#define SPI_AD9528				2
#define SPI_ADC9368				3
#define SPI_ADC9652				4



_USR_EXT_APD DevSPIxStr AT25DFSpi;
_USR_EXT_APD DevSPIxStr N25QSpi;

_USR_EXT_APD DevSPIxStr FPGASpi;
_USR_EXT_APD DevSPIxStr FPGACfgSpi;

_USR_EXT_APD DevSPIxStr iFPGASpi;


////////////////////////////////////////////////////////////////////////////////
#ifdef APD_C
/////////////////////////////
	#define APD_START_STK_SIZE		200
	static OS_STK APD0TaskStk[APD_START_STK_SIZE];

	INT8U FPGACfgFinish = FALSE;
	
	INT16U FlashTotFrame;
	INT16U FlashSwcrc16;
	INT8U FPGARUSumAlm = 0;
	
////////////////////////////////////////////////////////////////////////////////
#else
/////////////////////////////
	extern INT8U FPGACfgFinish;
	extern INT8U FPGARUSumAlm;

	extern INT16U FlashTotFrame;
	extern INT16U FlashSwcrc16;

////////////////////////////////////////////////////////////////////////////////
#endif
/////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Prototype Definition
/////////////////////////////


void iAPDInit(void);
void iAPDTask(void * pdata);

////////////////////////////////////////////////////////////////////////////////
void iFPGAConfig_SndData(DevSPIxStr *Devptr, INT16U DATA);
INT8U iFpgaConfigDown(void);
INT8U isItFPGACfgInit(void);

void iFPGA_ResetCtrl(void);
void iFPGA_INIT(void);

void iFPGAConfig_DnFlagSet(INT32S nSize, INT16U nCRC);
void iFPGAConfig_DnFlagRst(void);
void iFPGAConfig_ApplFlagSet(void);
void iFPGAGetStatus(void);
void iFPGALOFClrFunc(void);

INT16S iFPGAConfig_DnCheck(void);

////////////////////////////////////////////////////////////////////////////////
void WriteFPGA(DevSPIxStr *Devptr, INT16U ADDR, INT8U DATA);
INT16U ReadFPGAData(DevSPIxStr *Devptr, INT16U ADDR);


////////////////////////////////////////////////////////////////////////////////
// SPI DEVICE RELATED
void iSPIxInit(DevSPIxStr *Devptr);
void iDev_SPIxInit(INT8U SPIx);
void iDev_SPIx_CS_SET(INT8U SPIx);
void iDev_SPIx_CS_RST(INT8U SPIx);

INT16U SetSPIxCommand(INT8U nUSE, INT16U Comm);
SPI_TypeDef *iDev_SPIx_BASE(INT8U SPIx);




////////////////////////////////////////////////////////////////////////////////
#if 1
#define iFPGA_CS0_Init(){\
		FPGASpi.OSSem = AT25DFSpi.OSSem;\
		FPGASpi.SPIx = USE_SPI1;\
		FPGASpi.nDevNo = SPI_FLASHCH1;\
		iSPIxInit(&FPGASpi);\
		}

#define iFPGA_CS0_Read(ADDR)			ReadFPGAData(&FPGASpi, ADDR)
#define iFPGA_CS0_Write(ADDR, DATA)		WriteFPGA(&FPGASpi, ADDR, DATA)
#endif
#if 1
#define iFPGA_CS1_Init(){\
		iFPGASpi.OSSem = OSSemCreate(1);\
		iFPGASpi.SPIx = USE_SPI2;\
		iFPGASpi.nDevNo = SPI_FLASH_CH0;\
		iSPIxInit(&iFPGASpi);\
		\
		iFPGASpi.nDevNo = SPI_FLASH_CH1;\
		iSPIxInit(&iFPGASpi);\
		\
		iFPGASpi.nDevNo = SPI_AD9528;\
		iSPIxInit(&iFPGASpi);\
		\
		iFPGASpi.nDevNo = SPI_ADC9368;\
		iSPIxInit(&iFPGASpi);\
		\
		iFPGASpi.nDevNo = SPI_ADC9652;\
		iSPIxInit(&iFPGASpi);\
	}


#define iFPGA_CS1_Read(ADDR)			ReadFPGAData(&FPGASpi, ADDR)
#define iFPGA_CS1_Write(ADDR, DATA)		WriteFPGA(&FPGASpi, ADDR, DATA)


#endif



INT32U ReadFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen);
void WriteFPGAs(INT8U OPCODE, INT16U ADDR, INT8U *DATA, INT32U nlen);
INT32S iFPGA_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen);
INT32S iFPGA_GetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen);
void  iDev_SPIx_CS_SET(INT8U nDev);
void iDev_SPIx_CS_RST(INT8U nDev);
SPI_TypeDef *iDev_SPIx_BASE(INT8U SPIx);
void iDev_SPIxInit(INT8U SPIx);

INT16U SetSPIxCommand_Test(INT8U SPIx, INT16U Comm);

////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////


