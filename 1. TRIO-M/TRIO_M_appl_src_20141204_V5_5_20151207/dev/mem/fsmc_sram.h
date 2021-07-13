/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : fsmc_sram.h
* Author             : MCD Application Team
* Version            : V2.0.2
* Date               : 07/11/2008
* Description        : Header for fsmc_sram.c file.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

// Define to prevent recursive inclusion -------------------------------------
#ifndef __FSMC_SRAM_H
	#define __FSMC_SRAM_H
#endif // __FSMC_SRAM_H

// Predeclaration
//#define __EXT_RAM_USED
////////////////////////////////////////////////////////////////////////////////
// DON'T TOUCH
#ifdef __EXT_RAM_USED
	#define __UPPER_DATA_USED  // D8 ~ D15 사용할시.. ADDR8 ~ ADDR15 사용할시..
////////////////////////////////////////////////////////////////////////////////

#else
	//#define __UPPER_DATA_USED  // D8 ~ D15 사용할시.. ADDR8 ~ ADDR15 사용할시..	
#endif

#define Bank1_SRAM1_ADDR	((u32)0x60000000)
	#define EXPIOptr		Bank1_SRAM1_ADDR
	#define EXPIOsize	   	(0x80000L)	// 512Kbytes

////////////////////////////////////////////////////
// Expio Address
enum{
	nCS0SEL = 0,
	nCS1SEL,
	nCS2SEL,
	nCS3SEL,
	nCS4SEL,
	nCS5SEL,
	nCS6SEL,
	nCS7SEL,
	nCS8SEL,
	nCS9SEL,
	nCS10SEL,
	nCS11SEL,
	nCS12SEL,
	nCS13SEL,
	nCS14SEL,
	nCS15SEL,
	ExtMAX
};

#define	nCS0			*((volatile unsigned char *)(EXPIOptr + nCS0SEL*EXPIOsize))
#define	nCS1			*((volatile unsigned char *)(EXPIOptr + nCS1SEL*EXPIOsize))
#define	nCS2			*((volatile unsigned char *)(EXPIOptr + nCS2SEL*EXPIOsize))
#define	nCS3			*((volatile unsigned char *)(EXPIOptr + nCS3SEL*EXPIOsize))
#define	nCS4			*((volatile unsigned char *)(EXPIOptr + nCS4SEL*EXPIOsize))
#define	nCS5			*((volatile unsigned char *)(EXPIOptr + nCS5SEL*EXPIOsize))
#define	nCS6			*((volatile unsigned char *)(EXPIOptr + nCS6SEL*EXPIOsize))
#define	nCS7			*((volatile unsigned char *)(EXPIOptr + nCS7SEL*EXPIOsize))
#define	nCS8			*((volatile unsigned char *)(EXPIOptr + nCS8SEL*EXPIOsize))
#define	nCS9			*((volatile unsigned char *)(EXPIOptr + nCS9SEL*EXPIOsize))
#define	nCS10			*((volatile unsigned char *)(EXPIOptr + nCS10SEL*EXPIOsize))
#define	nCS11			*((volatile unsigned char *)(EXPIOptr + nCS11SEL*EXPIOsize))
#define	nCS12			*((volatile unsigned char *)(EXPIOptr + nCS12SEL*EXPIOsize))
#define	nCS13			*((volatile unsigned char *)(EXPIOptr + nCS13SEL*EXPIOsize))
#define	nCS14			*((volatile unsigned char *)(EXPIOptr + nCS14SEL*EXPIOsize))
#define	nCS15			*((volatile unsigned char *)(EXPIOptr + nCS15SEL*EXPIOsize))

#define Bank1_SRAM2_ADDR			((u32)0x64000000)
#define Bank1_SRAM3_ADDR			((u32)0x68000000)
#define Bank1_SRAM4_ADDR			((u32)0x6C000000)

#define __pAPBK_SRAMAddr		((u32)&nCS15 + ((512-(FLASH_SIZE-28))*1024L))

// Exported variables-----------------------------------------------------------

// Exported constants ----------------------------------------------------------
// Exported macro --------------------------------------------------------------
// Exported functions ----------------------------------------------------------
void FSMC_SRAM_Init(void);
void FSMC_SRAM_WriteBuffer(u16* pBuffer, u32 WriteAddr, u32 NumHalfwordToWrite);
void FSMC_SRAM_ReadBuffer(u16* pBuffer, u32 ReadAddr, u32 NumHalfwordToRead);

/******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
