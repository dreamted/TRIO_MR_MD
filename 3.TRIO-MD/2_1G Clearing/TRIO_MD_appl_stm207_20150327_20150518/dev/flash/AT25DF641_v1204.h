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

#define WIP_Flag   0x01  /* Write In Progress (WIP) flag */

#define Dummy_Byte 0xA5

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




//////////////////////////////////////////////////////
// DEVICE CONTROL
INT32S sFLASH_SetRegister(DevSPIxStr *Devptr, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen);
INT32S sFLASH_WaitWriteEnd(DevSPIxStr *Devptr);



////////////////////////////////////////////////////////////////////////////////
// Individual fucntion
#define sFLASH_CS0_Init(){\
		AT25DFSpi.OSSem = OSSemCreate(1);\
		AT25DFSpi.SPIx = USE_SPI2;\
		AT25DFSpi.nDevNo = SPI_FLASHCH;\
		sFLASH_Init(&AT25DFSpi);\
		}

#define sFLASH_CS0_ReadStsRegister(DATA) 		sFLASH_ReadStsRegister(&AT25DFSpi, DATA)
#define sFLASH_CS0_AllErase()					sFLASH_AllErase(&AT25DFSpi)
#define sFLASH_CS0_4kErase(ADDR)				sFLASH_4kErase(&AT25DFSpi, ADDR)	//4KB erase;//4KB erase
#define sFLASH_CS0_DataWrite(ADDR, DATA, nlen)	sFLASH_DataWrite(&AT25DFSpi, ADDR, DATA, nlen)
#define sFLASH_CS0_DataRead(ADDR)				sFLASH_DataRead(&AT25DFSpi, ADDR)
#define sFLASH_CS0_BufferRead(ADDR, DATA, nlen)	sFLASH_BufferRead(&AT25DFSpi, ADDR, DATA, nlen)
#define sFLASH_CS0_BL4kCheckErase(ADDR, nlen)	sFLASH_BL4kCheckErase(&AT25DFSpi, ADDR, nlen)


#endif // __SPI_FLASH_H

/******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
