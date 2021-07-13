///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:40 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\mem\fs /
//                    mc_sram.c                                               /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\mem\fs /
//                    mc_sram.c -D _MIMO_Type -lcN                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120106\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120106\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120106\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\fsmc_ /
//                    sram.s                                                  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME fsmc_sram

        PUBLIC FSMC_SRAM_Init
        PUBLIC FSMC_SRAM_ReadBuffer
        PUBLIC FSMC_SRAM_WriteBuffer

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\mem\fsmc_sram.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : fsmc_sram.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.2
//    5 * Date               : 07/11/2008
//    6 * Description        : This file provides a set of functions needed to drive the 
//    7 *                      IS61WV51216BLL SRAM memory mounted on STM3210E-EVAL board.
//    8 ********************************************************************************
//    9 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   10 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   11 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   12 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   13 * CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   14 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   15 *******************************************************************************/
//   16 
//   17 // Includes --------------------------------------------------------------------
//   18 #include "stm32f10x_conf.h"
//   19 #include "fsmc_sram.h"
//   20 
//   21 // Private variables -----------------------------------------------------------
//   22 
//   23 /*******************************************************************************
//   24 * Function Name  : FSMC_SRAM_Init
//   25 * Description    : Configures the FSMC and GPIOs to interface with the SRAM memory.
//   26 *                  This function must be called before any write/read operation
//   27 *                  on the SRAM.
//   28 * Input          : None 
//   29 * Output         : None
//   30 * Return         : None
//   31 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   32 void FSMC_SRAM_Init(void)
//   33 {
//   34 #ifdef __EXT_RAM_USED
//   35 
//   36 	// AHB ENABLE
//   37 	RCC->AHBENR.Data |= (__FSMCEN);
//   38 	RCC->APB2ENR.Data |= (__IOPBEN | __IOPDEN | __IOPEEN | __IOPFEN | __IOPGEN);
//   39 
//   40 	///-- GPIO Configuration ------------------------------------------------------*/
//   41 	// SRAM Data lines(DATA0) configuration
//   42 	GPIOD->CNF.B14 = __FAD0;
//   43 	GPIOD->CNF.B15 = __FAD1;
//   44 	GPIOD->CNF.B0 = __FAD2;
//   45 	GPIOD->CNF.B1 = __FAD3;
//   46 
//   47 	GPIOE->CNF.B7 = __FAD4;
//   48 	GPIOE->CNF.B8 = __FAD5;
//   49 	GPIOE->CNF.B9 = __FAD6;
//   50 	GPIOE->CNF.B10 = __FAD7;
//   51 
//   52 #ifdef __UPPER_DATA_USED
//   53 	GPIOE->CNF.B11 = __FAD8;
//   54 	GPIOE->CNF.B12 = __FAD9;
//   55 	GPIOE->CNF.B13 = __FAD10;
//   56 	GPIOE->CNF.B14 = __FAD11;
//   57 
//   58 	GPIOE->CNF.B15 = __FAD12;
//   59 	GPIOD->CNF.B8 = __FAD13;
//   60 	GPIOD->CNF.B9 = __FAD14;
//   61 	GPIOD->CNF.B10 = __FAD15;
//   62 #endif
//   63 
//   64 	GPIOE->CNF.B3 = __FA19;
//   65 	GPIOE->CNF.B4 = __FA20;
//   66 	GPIOE->CNF.B5 = __FA21;
//   67 	GPIOE->CNF.B6 = __FA22;
//   68 	// NOE and NWE configuration
//   69 	GPIOD->CNF.B5 = __NWE;
//   70 	GPIOD->CNF.B4 = __NOE;
//   71 	
//   72 	// NE1 configuration
//   73 	GPIOD->CNF.B7 = __NCE;
//   74 
//   75 	// NBL0, NBL1 configuration
//   76 	//GPIOE->CR.Bit.CNF1 = __NBL1;
//   77 	//GPIOE->CR.Bit.CNF0 = __NBL0;
//   78 
//   79 	// NADV(ADDRESS LATCH ENABLE) configuration
//   80 	GPIOB->CNF.B7 = __NADV;
//   81 
//   82     {
//   83       //-- FSMC Configuration ----------------------------------------------------
//   84         FSMC_NORSRAMInitTypeDef  FSMC_NORSRAMInitStructure;
//   85         FSMC_NORSRAMTimingInitTypeDef  p;
//   86     
//   87         p.FSMC_AddressSetupTime = 0;
//   88         p.FSMC_AddressHoldTime = 1;
//   89         p.FSMC_DataSetupTime = 8;
//   90         p.FSMC_BusTurnAroundDuration = 0;
//   91         p.FSMC_CLKDivision = 0;
//   92         p.FSMC_DataLatency = 0;
//   93         p.FSMC_AccessMode = FSMC_AccessMode_A;
//   94     
//   95         FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM1;
//   96         FSMC_NORSRAMInitStructure.FSMC_DataAddressMux = FSMC_DataAddressMux_Enable;
//   97         FSMC_NORSRAMInitStructure.FSMC_MemoryType = FSMC_MemoryType_NOR;
//   98         FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
//   99         FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
//  100         FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
//  101         FSMC_NORSRAMInitStructure.FSMC_WrapMode = FSMC_WrapMode_Disable;
//  102         FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
//  103         FSMC_NORSRAMInitStructure.FSMC_WriteOperation = FSMC_WriteOperation_Enable;
//  104         FSMC_NORSRAMInitStructure.FSMC_WaitSignal = FSMC_WaitSignal_Disable;
//  105         FSMC_NORSRAMInitStructure.FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
//  106         FSMC_NORSRAMInitStructure.FSMC_AsyncWait = FSMC_AsyncWait_Disable;
//  107         FSMC_NORSRAMInitStructure.FSMC_WriteBurst = FSMC_WriteBurst_Disable;
//  108         FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct = &p;
//  109         FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct = &p;
//  110     
//  111         FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure); 
//  112     
//  113         // Enable FSMC Bank1_SRAM Bank
//  114         FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM1, ENABLE); 
//  115 
//  116 
//  117     }
//  118 #endif //__EXT_RAM_USED
//  119 
//  120 }
FSMC_SRAM_Init:
        BX       LR               ;; return
//  121 
//  122 /*******************************************************************************
//  123 * Function Name  : FSMC_SRAM_WriteBuffer
//  124 * Description    : Writes a Half-word buffer to the FSMC SRAM memory. 
//  125 * Input          : - pBuffer : pointer to buffer. 
//  126 *                  - WriteAddr : SRAM memory internal address from which the data 
//  127 *                    will be written.
//  128 *                  - NumHalfwordToWrite : number of half-words to write. 
//  129 *                    
//  130 * Output         : None
//  131 * Return         : None
//  132 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  133 void FSMC_SRAM_WriteBuffer(u16* pBuffer, u32 WriteAddr, u32 NumHalfwordToWrite)
//  134 {
FSMC_SRAM_WriteBuffer:
        PUSH     {R3,R4}
        CBZ      R2,??FSMC_SRAM_WriteBuffer_0
//  135   for(; NumHalfwordToWrite != 0; NumHalfwordToWrite--) /* while there is data to write */
//  136   {
//  137     /* Transfer data to the memory */
//  138     *(u16 *) (Bank1_SRAM3_ADDR + WriteAddr) = *pBuffer++;
??FSMC_SRAM_WriteBuffer_1:
        ADD      R3,R1,#+1744830464
        LDRH     R4,[R0], #+2
        STRH     R4,[R3, #+0]
//  139     
//  140     /* Increment the address*/  
//  141     WriteAddr += 2;
        ADDS     R1,R1,#+2
//  142   }   
        SUBS     R2,R2,#+1
        BNE.N    ??FSMC_SRAM_WriteBuffer_1
//  143 }
??FSMC_SRAM_WriteBuffer_0:
        POP      {R0,R4}
        BX       LR               ;; return
//  144 
//  145 /*******************************************************************************
//  146 * Function Name  : FSMC_SRAM_ReadBuffer
//  147 * Description    : Reads a block of data from the FSMC SRAM memory.
//  148 * Input          : - pBuffer : pointer to the buffer that receives the data read 
//  149 *                    from the SRAM memory.
//  150 *                  - ReadAddr : SRAM memory internal address to read from.
//  151 *                  - NumHalfwordToRead : number of half-words to read.
//  152 * Output         : None
//  153 * Return         : None
//  154 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  155 void FSMC_SRAM_ReadBuffer(u16* pBuffer, u32 ReadAddr, u32 NumHalfwordToRead)
//  156 {
FSMC_SRAM_ReadBuffer:
        CBZ      R2,??FSMC_SRAM_ReadBuffer_0
//  157   for(; NumHalfwordToRead != 0; NumHalfwordToRead--) /* while there is data to read */
//  158   {
//  159     /* Read a half-word from the memory */
//  160     *pBuffer++ = *(vu16*) (Bank1_SRAM3_ADDR + ReadAddr);
??FSMC_SRAM_ReadBuffer_1:
        ADD      R3,R1,#+1744830464
        LDRH     R3,[R3, #+0]
        STRH     R3,[R0], #+2
//  161 
//  162     /* Increment the address*/  
//  163     ReadAddr += 2;
        ADDS     R1,R1,#+2
//  164   }  
        SUBS     R2,R2,#+1
        BNE.N    ??FSMC_SRAM_ReadBuffer_1
//  165 }
??FSMC_SRAM_ReadBuffer_0:
        BX       LR               ;; return

        END
//  166 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 46 bytes in section .text
// 
// 46 bytes of CODE memory
//
//Errors: none
//Warnings: none
