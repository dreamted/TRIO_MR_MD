

/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
////////////////////////////////////////////////////////////////////////////////
#ifdef AD9777_C
	#define _USR_EXT_AD9777
#else
	#define _USR_EXT_AD9777	extern
#endif




////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
#ifdef AD9777_C
////////////////////
	const unsigned char AD9777RegInit[13] =
	{
	    0x00,   0xA7,   0x30,   0x00,   0xc7,   0x00,   0x0f,
	    0x00,   0x00,   0x00,   0x0f,   0x00,   0x00    
	};


////////////////////
#else
////////////////////
	extern const unsigned char AD9777RegInit[13];

////////////////////
#endif
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////
void Ad9777_Write(DevSPIxStr *Devptr, INT8U ADDR, INT8U DATA);
void Ad9777_SetRegister(DevSPIxStr *Devptr);

INT8U Ad9777_Read(DevSPIxStr *Devptr, INT8U ADDR);

////////////////////////////////////////////////////////////////////////////////

#define Ad9777_CS0_Init(){\
			  AD9771Spi.OSSem = OSSemCreate(1);\
			  AD9771Spi.SPIx = USE_SPI3; \
			  AD9771Spi.nDevNo = SPI_AD9777CH; \
              iSPIxInit(&AD9771Spi);\
			}
#define Ad9777_CS0_SetRegister() Ad9777_SetRegister(&AD9771Spi)		
#define Ad9777_CS0_Write(ADDR, DATA) Ad9777_Write(&AD9771Spi, ADDR, DATA)
#define Ad9777_CS0_Read(ADDR) Ad9777_Read(&AD9771Spi, ADDR)

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

