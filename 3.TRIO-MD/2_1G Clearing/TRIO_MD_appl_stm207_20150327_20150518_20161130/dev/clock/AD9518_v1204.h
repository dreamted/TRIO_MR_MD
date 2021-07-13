
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
////////////////////////////////////////////////////////////////////////////////
#ifdef AD9518_C
	#define _USR_EXT_AD9518
#else
	#define _USR_EXT_AD9518	extern
#endif

#define REG_UPDATE_REG 	0x0232

// ADDRESS 0x0003
#define AD9518_0		0x21
#define AD9518_1		0x61
#define AD9518_2		0xA1
#define AD9518_3		0x63
#define AD9518_4		0xE3


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
#ifdef AD9518_C
////////////////////
	const unsigned short int AD9518InitAddress[68] =
	{
		0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 
		0x0015, 0x0016, 0x0017, 0x0018, 0x0019, 0x001A, 0x001B, 0x001C, 0x001D, 0x001E, 
		0x001F, 0x00A0, 0x00A1, 0x00A2, 0x00A3, 0x00A4, 0x00A5, 0x00A6, 0x00A7, 0x00A8, 
		0x00A9, 0x00AA, 0x00AB, 0x00F0, 0x00F1, 0x00F2, 0x00F3, 0x00F4, 0x00F5, 0x0140, 
		0x0141, 0x0142, 0x0143, 0x0190, 0x0191, 0x0192, 0x0193, 0x0194, 0x0195, 0x0196, 
		0x0197, 0x0198, 0x0199, 0x019A, 0x019B, 0x019C, 0x019D, 0x019E, 0x019F, 0x01A0, 
		0x01A1, 0x01A2, 0x01A3, 0x01E0, 0x01E1, 0x0230, 0x0231, 0x0232
		
	};

	const unsigned char AD9518InitData[68] =
	{
		0x99, 0x00, 0x10, 0xE3, 0x00, 0x7C, 0x05, 0x00, 0x10, 0x1B, 
		0x00, 0x06, 0x00, 0x06, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 
		0x0E, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 
		0x01, 0x00, 0x00, 0x08, 0x0A, 0x08, 0x0A, 0x08, 0x08, 0x42, 
		0x43, 0x42, 0x43, 0x44, 0x00, 0x00, 0x44, 0x00, 0x00, 0x44, 
		0x00, 0x00, 0x22, 0x00, 0x11, 0x00, 0x00, 0x22, 0x00, 0x11, 
		0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	};



////////////////////
#else
////////////////////
	extern const unsigned short int AD9518InitAddress[68];
	extern const unsigned char AD9518InitData[68];

////////////////////
#endif
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////
void Ad9518_SetRegister(DevSPIxStr *Devptr);
void ClkSynthesizerRegWrite(DevSPIxStr *Devptr, INT16U ADDR, INT8U DATA);

INT8U ClkSynthesizerRegRead(DevSPIxStr *Devptr, INT16U ADDR);

////////////////////////////////////////////////////////////////////////////////

#define Ad9518_CS1_Init(){\
				AD9518Spi.OSSem = AD9771Spi.OSSem; \
				AD9518Spi.SPIx = USE_SPI3;\
				AD9518Spi.nDevNo = SPI_AD9518CH;\
				iSPIxInit(&AD9518Spi);\
				}
#define Ad9518_CS1_SetRegister() Ad9518_SetRegister(&AD9518Spi)		
#define Ad9518_CS1_Write(ADDR, DATA) ClkSynthesizerRegWrite(&AD9518Spi, ADDR, DATA)
#define Ad9518_CS1_Read(ADDR) ClkSynthesizerRegRead(&AD9518Spi, ADDR)

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

