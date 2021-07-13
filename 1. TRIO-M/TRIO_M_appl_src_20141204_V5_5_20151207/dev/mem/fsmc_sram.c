/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : fsmc_sram.c
* Author             : MCD Application Team
* Version            : V2.0.2
* Date               : 07/11/2008
* Description        : This file provides a set of functions needed to drive the 
*                      IS61WV51216BLL SRAM memory mounted on STM3210E-EVAL board.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

// Includes --------------------------------------------------------------------
#include "stm32f10x_conf.h"
#include "fsmc_sram.h"

// Private variables -----------------------------------------------------------

/*******************************************************************************
* Function Name  : FSMC_SRAM_Init
* Description    : Configures the FSMC and GPIOs to interface with the SRAM memory.
*                  This function must be called before any write/read operation
*                  on the SRAM.
* Input          : None 
* Output         : None
* Return         : None
*******************************************************************************/
void FSMC_SRAM_Init(void)
{
#ifdef __EXT_RAM_USED

	// AHB ENABLE
	RCC->AHBENR.Data |= (__FSMCEN);
	RCC->APB2ENR.Data |= (__IOPBEN | __IOPDEN | __IOPEEN | __IOPFEN | __IOPGEN);

	///-- GPIO Configuration ------------------------------------------------------*/
	// SRAM Data lines(DATA0) configuration
	GPIOD->CNF.B14 = __FAD0;
	GPIOD->CNF.B15 = __FAD1;
	GPIOD->CNF.B0 = __FAD2;
	GPIOD->CNF.B1 = __FAD3;

	GPIOE->CNF.B7 = __FAD4;
	GPIOE->CNF.B8 = __FAD5;
	GPIOE->CNF.B9 = __FAD6;
	GPIOE->CNF.B10 = __FAD7;

#ifdef __UPPER_DATA_USED
	GPIOE->CNF.B11 = __FAD8;
	GPIOE->CNF.B12 = __FAD9;
	GPIOE->CNF.B13 = __FAD10;
	GPIOE->CNF.B14 = __FAD11;

	GPIOE->CNF.B15 = __FAD12;
	GPIOD->CNF.B8 = __FAD13;
	GPIOD->CNF.B9 = __FAD14;
	GPIOD->CNF.B10 = __FAD15;
#endif

	GPIOE->CNF.B3 = __FA19;
	GPIOE->CNF.B4 = __FA20;
	GPIOE->CNF.B5 = __FA21;
	GPIOE->CNF.B6 = __FA22;
	// NOE and NWE configuration
	GPIOD->CNF.B5 = __NWE;
	GPIOD->CNF.B4 = __NOE;
	
	// NE1 configuration
	GPIOD->CNF.B7 = __NCE;

	// NBL0, NBL1 configuration
	//GPIOE->CR.Bit.CNF1 = __NBL1;
	//GPIOE->CR.Bit.CNF0 = __NBL0;

	// NADV(ADDRESS LATCH ENABLE) configuration
	GPIOB->CNF.B7 = __NADV;

    {
      //-- FSMC Configuration ----------------------------------------------------
        FSMC_NORSRAMInitTypeDef  FSMC_NORSRAMInitStructure;
        FSMC_NORSRAMTimingInitTypeDef  p;
    
        p.FSMC_AddressSetupTime = 0;
        p.FSMC_AddressHoldTime = 1;
        p.FSMC_DataSetupTime = 8;
        p.FSMC_BusTurnAroundDuration = 0;
        p.FSMC_CLKDivision = 0;
        p.FSMC_DataLatency = 0;
        p.FSMC_AccessMode = FSMC_AccessMode_A;
    
        FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM1;
        FSMC_NORSRAMInitStructure.FSMC_DataAddressMux = FSMC_DataAddressMux_Enable;
        FSMC_NORSRAMInitStructure.FSMC_MemoryType = FSMC_MemoryType_NOR;
        FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
        FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
        FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
        FSMC_NORSRAMInitStructure.FSMC_WrapMode = FSMC_WrapMode_Disable;
        FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
        FSMC_NORSRAMInitStructure.FSMC_WriteOperation = FSMC_WriteOperation_Enable;
        FSMC_NORSRAMInitStructure.FSMC_WaitSignal = FSMC_WaitSignal_Disable;
        FSMC_NORSRAMInitStructure.FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
        FSMC_NORSRAMInitStructure.FSMC_AsyncWait = FSMC_AsyncWait_Disable;
        FSMC_NORSRAMInitStructure.FSMC_WriteBurst = FSMC_WriteBurst_Disable;
        FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct = &p;
        FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct = &p;
    
        FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure); 
    
        // Enable FSMC Bank1_SRAM Bank
        FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM1, ENABLE); 


    }
#endif //__EXT_RAM_USED

}

/*******************************************************************************
* Function Name  : FSMC_SRAM_WriteBuffer
* Description    : Writes a Half-word buffer to the FSMC SRAM memory. 
* Input          : - pBuffer : pointer to buffer. 
*                  - WriteAddr : SRAM memory internal address from which the data 
*                    will be written.
*                  - NumHalfwordToWrite : number of half-words to write. 
*                    
* Output         : None
* Return         : None
*******************************************************************************/
void FSMC_SRAM_WriteBuffer(u16* pBuffer, u32 WriteAddr, u32 NumHalfwordToWrite)
{
  for(; NumHalfwordToWrite != 0; NumHalfwordToWrite--) /* while there is data to write */
  {
    /* Transfer data to the memory */
    *(u16 *) (Bank1_SRAM3_ADDR + WriteAddr) = *pBuffer++;
    
    /* Increment the address*/  
    WriteAddr += 2;
  }   
}

/*******************************************************************************
* Function Name  : FSMC_SRAM_ReadBuffer
* Description    : Reads a block of data from the FSMC SRAM memory.
* Input          : - pBuffer : pointer to the buffer that receives the data read 
*                    from the SRAM memory.
*                  - ReadAddr : SRAM memory internal address to read from.
*                  - NumHalfwordToRead : number of half-words to read.
* Output         : None
* Return         : None
*******************************************************************************/
void FSMC_SRAM_ReadBuffer(u16* pBuffer, u32 ReadAddr, u32 NumHalfwordToRead)
{
  for(; NumHalfwordToRead != 0; NumHalfwordToRead--) /* while there is data to read */
  {
    /* Read a half-word from the memory */
    *pBuffer++ = *(vu16*) (Bank1_SRAM3_ADDR + ReadAddr);

    /* Increment the address*/  
    ReadAddr += 2;
  }  
}
/******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
