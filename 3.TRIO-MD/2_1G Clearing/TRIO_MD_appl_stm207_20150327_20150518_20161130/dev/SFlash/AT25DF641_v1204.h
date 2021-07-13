/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : spi_flash.h
* Author             : MCD Application Team
* Version            : V2.0.3
* Date               : 09/22/2008
* Description        : Header for spi_flash.c file.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SPI_FLASH_H
#define __SPI_FLASH_H

////////////////////////////////////////////////////////////////////////////////
// Declaration
///////////////////////////////////////////////////////////////////////////////
// OPCODE

#define WRITE			0x02  /* Write to Memory instruction */
#define WRSR1			0x01  /* Write Status Register instruction */
#define WRSR2			0x31  /* Write Status Register instruction */

#define WREN			0x06  /* Write enable instruction */

#define READ			0x03  // Read from Memory instruction
#define RDSR			0x05  /* Read Status Register instruction  */
#define RDID			0x9F  /* Read identification */
#define AllErase		0xC7  /* Bulk Erase instruction */
#define BlockE4K		0x20  /* Block Erase instruction */
#define BlockE32K		0x52  /* Block Erase instruction */
#define BlockE64K		0xD8  /* Block Erase instruction */
#define ProtectSE		0x36  /* ProtectS Sector */
#define uProtectSE		0x39  /* UnProtectS Sector */
#define RDProtectS		0x3C  /* Read Protect Sector Register */

#define WIP_Flag  		0x01  /* Write In Progress (WIP) flag */

#define Dummy_Byte 		0xA5
//////////////////////////////////////////////////////////
#define RDID1			0x9E  /* Read identification */   /////1 ~ 20

#define MultiID			0xAF  /* Read identification */  ///1~3


#define READ_EXT		0xC8  // Read from Memory instruction
#define WRITE_EXT		0xC5  // Read from Memory instruction

#define READFlagSTS		0x70  // Read from Memory instruction


#define CMD_BANKADDR_BRWR		0x17  ////XXXXXXXXXXX
#define CMD_BANKADDR_BRRD		0x16  ////XXXXX
#define CMD_EXTNADDR_WREAR		0xC5
#define CMD_EXTNADDR_RDEAR		0xC8


#define READNVCR				0xB5
#define WRITENVCR				0xB1




#define SPI_FLASH_16MB_BOUN		0x1000000

////////////////////////////////////////////////////








// READ STATUS 1 REGISTER !!
typedef union {
	INT8U Data;
	struct {
		INT8U BUSY			:1;
		INT8U WEL			:1;
		INT8U SWP			:2;

		INT8U WPP			:1;	// 1
		INT8U EPE			:1;	// erase/program error
		INT8U				:1;
		INT8U SPRL			:1;	// sector protection Registers Locked
	};
} RDSts1Reg;
////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
#ifdef AD25DF_C
////////////////////

////////////////////
#else
////////////////////

////////////////////
#endif
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
INT32S sFLASH_BL4kCheckErase(DevSPIxStr *Devptr, INT32U ADDR, INT32U nlen);


////////////////////////////////////////
// OS CONTRL(SEMOPHORE)
void sFLASH_Init(DevSPIxStr *Devptr);

INT32S sFLASH_Unprotected(DevSPIxStr *Devptr);
INT32S sFLASH_ReadStsRegister(DevSPIxStr *Devptr, INT8U *DATA);
INT32S sFLASH_AllErase(DevSPIxStr *Devptr);
INT32S sFLASH_4kErase(DevSPIxStr *Devptr, INT32U ADDR);//4KB erase
INT32S sFLASH_DataWrite(DevSPIxStr *Devptr, INT32U ADDR, INT8U *DATA, INT32U nlen);

INT8U sFLASH_DataRead(DevSPIxStr *Devptr, INT32U ADDR);
void sFLASH_BufferRead(DevSPIxStr *Devptr, INT32U ADDR, INT8U *DATA, INT32U nlen);
void sFLASH_BufferReadCommand(DevSPIxStr *Devptr,INT8U Command, INT32U ADDR, INT8U *DATA, INT32U nlen);
void sFLASH_BufferRead_RDID(DevSPIxStr *Devptr, INT32U ADDR, INT8U *DATA, INT32U nlen);




//////////////////////////////////////////////////////
// DEVICE CONTROL
INT32S sFLASH_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen);
INT32S sFLASH_WaitWriteEnd(DevSPIxStr *Devptr);

//INT8U sFLASH_DataReadExt(DevSPIxStr *Devptr, INT32U ADDR);
//INT8U sFLASH_DataWriteExt(DevSPIxStr *Devptr, INT32U ADDR);



////////////////////////////////////////////////////////////////////////////////
// Individual fucntion
#if 1
#define sFLASH_CS0_Init(){\
		AT25DFSpi.OSSem = OSSemCreate(1);\
		AT25DFSpi.SPIx = USE_SPI2;\
		AT25DFSpi.nDevNo = SPI_FLASHCH;\
		sFLASH_Init(&AT25DFSpi);\
		}

#define sFLASH_CS1_Init(){\
		N25QSpi.OSSem = N25QSpi.OSSem;\
		N25QSpi.SPIx = USE_SPI1;\
		N25QSpi.nDevNo = SPI_FLASHCH1;\
		iSPIxInit(&N25QSpi);\
		}
#endif

#if 0
#define sFLASH_CS0_Init(){\
		N25QSpi.OSSem = OSSemCreate(1);\
		N25QSpi.SPIx = USE_SPI2;\
		N25QSpi.nDevNo = SPI_FLASHCH;\
		sFLASH_Init(&N25QSpi);\
		}

#define sFLASH_CS1_Init(){\
		AT25DFSpi.OSSem = OSSemCreate(1);\
		AT25DFSpi.SPIx = USE_SPI1;\
		AT25DFSpi.nDevNo = SPI_FLASHCH1;\
		iSPIxInit(&AT25DFSpi);\
		}
#endif




#define sFLASH_CS0_ReadStsRegister(DATA) 		sFLASH_ReadStsRegister(&AT25DFSpi, DATA)
#define sFLASH_CS0_AllErase()					sFLASH_AllErase(&AT25DFSpi)
#define sFLASH_CS0_4kErase(ADDR)				sFLASH_4kErase(&AT25DFSpi, ADDR)	//4KB erase;//4KB erase
#define sFLASH_CS0_DataWrite(ADDR, DATA, nlen)	sFLASH_DataWrite(&AT25DFSpi, ADDR, DATA, nlen)
#define sFLASH_CS0_DataRead(ADDR)				sFLASH_DataRead(&AT25DFSpi, ADDR)
#define sFLASH_CS0_BufferRead(ADDR, DATA, nlen)	sFLASH_BufferRead(&AT25DFSpi, ADDR, DATA, nlen)
#define sFLASH_CS0_BL4kCheckErase(ADDR, nlen)	sFLASH_BL4kCheckErase(&AT25DFSpi, ADDR, nlen)
#define sFLASH_CS0_DataReadExt(ADDR)			sFLASH_DataReadExt(&AT25DFSpi, ADDR)
#define sFLASH_CS0_DataWriteExt(ADDR)			sFLASH_DataWriteExt(&AT25DFSpi, ADDR)


#define sFLASH_CS0_SetRegister(OPCODE,ADDR,DATA,nlen)			sFLASH_SetRegister(&AT25DFSpi, OPCODE,ADDR, DATA, nlen)



#define sFLASH_CS1_ReadStsRegister(DATA) 		sFLASH_ReadStsRegister(&N25QSpi, DATA)
#define sFLASH_CS1_AllErase()					sFLASH_AllErase(&N25QSpi)
#define sFLASH_CS1_4kErase(ADDR)				sFLASH_4kErase(&N25QSpi, ADDR)	//4KB erase;//4KB erase
#define sFLASH_CS1_DataWrite(ADDR, DATA, nlen)	sFLASH_DataWrite(&N25QSpi, ADDR, DATA, nlen)
#define sFLASH_CS1_DataRead(ADDR)				sFLASH_DataRead(&N25QSpi, ADDR)
#define sFLASH_CS1_BufferRead(ADDR, DATA, nlen)	sFLASH_BufferRead(&N25QSpi, ADDR, DATA, nlen)
#define sFLASH_CS1_BL4kCheckErase(ADDR, nlen)	sFLASH_BL4kCheckErase(&N25QSpi, ADDR, nlen)


#endif // __SPI_FLASH_H

/******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/

