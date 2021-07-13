///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:03 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_fsmc.c                                /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_fsmc.c -D OS_INCLUDED -D APPL_SRC     /
//                    -lA D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ -o       /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\out\              /
//                    --endian=little --cpu=Cortex-M3 -e --fpu=None           /
//                    --dlib_config "C:\Programming\IAR Systems\Embedded      /
//                    Workbench 6.0\arm\INC\c\DLib_Config_Normal.h" -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\include\ -I       /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\..\..\STM32F2xx_S /
//                    tdPeriph_Driver\ -I D:\Work\Project\2012\NL_INBUILD\FW\ /
//                    MU\..\..\STM32F2xx_StdPeriph_Driver\inc\ -I             /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-CPU\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-LIB\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Ports\    /
//                    -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Source /
//                    \ -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-Probe\    /
//                    -Oh --use_c++_inline                                    /
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_fsm /
//                    c.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_fsmc

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        PUBLIC FSMC_ClearFlag
        PUBLIC FSMC_ClearITPendingBit
        PUBLIC FSMC_GetECC
        PUBLIC FSMC_GetFlagStatus
        PUBLIC FSMC_GetITStatus
        PUBLIC FSMC_ITConfig
        PUBLIC FSMC_NANDCmd
        PUBLIC FSMC_NANDDeInit
        PUBLIC FSMC_NANDECCCmd
        PUBLIC FSMC_NANDInit
        PUBLIC FSMC_NANDStructInit
        PUBLIC FSMC_NORSRAMCmd
        PUBLIC FSMC_NORSRAMDeInit
        PUBLIC FSMC_NORSRAMInit
        PUBLIC FSMC_NORSRAMStructInit
        PUBLIC FSMC_PCCARDCmd
        PUBLIC FSMC_PCCARDDeInit
        PUBLIC FSMC_PCCARDInit
        PUBLIC FSMC_PCCARDStructInit
        
        CFI Names cfiNames0
        CFI StackFrame CFA R13 DATA
        CFI Resource R0:32, R1:32, R2:32, R3:32, R4:32, R5:32, R6:32, R7:32
        CFI Resource R8:32, R9:32, R10:32, R11:32, R12:32, R13:32, R14:32
        CFI EndNames cfiNames0
        
        CFI Common cfiCommon0 Using cfiNames0
        CFI CodeAlign 2
        CFI DataAlign 4
        CFI ReturnAddress R14 CODE
        CFI CFA R13+0
        CFI R0 Undefined
        CFI R1 Undefined
        CFI R2 Undefined
        CFI R3 Undefined
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R12 Undefined
        CFI R14 SameValue
        CFI EndCommon cfiCommon0
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_fsmc.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_fsmc.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7  * @brief    This file provides firmware functions to manage the following 
//    8   *          functionalities of the FSMC peripheral:           
//    9   *           - Interface with SRAM, PSRAM, NOR and OneNAND memories
//   10   *           - Interface with NAND memories
//   11   *           - Interface with 16-bit PC Card compatible memories  
//   12   *           - Interrupts and flags management   
//   13   *           
//   14   ******************************************************************************
//   15 
//   16   * @attention
//   17   *
//   18   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   19   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   20   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   21   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   22   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   23   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   24   *
//   25   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   26   ******************************************************************************
//   27   */
//   28 
//   29 /* Includes ------------------------------------------------------------------*/
//   30 #include "stm32f2xx_fsmc.h"
//   31 //#include "stm32f2xx_rcc.h"
//   32 
//   33 /** @addtogroup STM32F2xx_StdPeriph_Driver
//   34   * @{
//   35   */
//   36 
//   37 /** @defgroup FSMC 
//   38   * @brief FSMC driver modules
//   39   * @{
//   40   */ 
//   41 
//   42 /* Private typedef -----------------------------------------------------------*/
//   43 /* Private define ------------------------------------------------------------*/
//   44 
//   45 /* --------------------- FSMC registers bit mask ---------------------------- */
//   46 /* FSMC BCRx Mask */
//   47 #define BCR_MBKEN_SET          ((uint32_t)0x00000001)
//   48 #define BCR_MBKEN_RESET        ((uint32_t)0x000FFFFE)
//   49 #define BCR_FACCEN_SET         ((uint32_t)0x00000040)
//   50 
//   51 /* FSMC PCRx Mask */
//   52 #define PCR_PBKEN_SET          ((uint32_t)0x00000004)
//   53 #define PCR_PBKEN_RESET        ((uint32_t)0x000FFFFB)
//   54 #define PCR_ECCEN_SET          ((uint32_t)0x00000040)
//   55 #define PCR_ECCEN_RESET        ((uint32_t)0x000FFFBF)
//   56 #define PCR_MEMORYTYPE_NAND    ((uint32_t)0x00000008)
//   57 
//   58 /* Private macro -------------------------------------------------------------*/
//   59 /* Private variables ---------------------------------------------------------*/
//   60 /* Private function prototypes -----------------------------------------------*/
//   61 /* Private functions ---------------------------------------------------------*/
//   62 
//   63 /** @defgroup FSMC_Private_Functions
//   64   * @{
//   65   */
//   66 
//   67 /** @defgroup FSMC_Group1 NOR/SRAM Controller functions
//   68  *  @brief   NOR/SRAM Controller functions 
//   69  *
//   70 @verbatim   
//   71  ===============================================================================
//   72                     NOR/SRAM Controller functions
//   73  ===============================================================================  
//   74 
//   75  The following sequence should be followed to configure the FSMC to interface with
//   76  SRAM, PSRAM, NOR or OneNAND memory connected to the NOR/SRAM Bank:
//   77  
//   78    1. Enable the clock for the FSMC and associated GPIOs using the following functions:
//   79           RCC_AHB3PeriphClockCmd(RCC_AHB3Periph_FSMC, ENABLE);
//   80           RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOx, ENABLE);
//   81 
//   82    2. FSMC pins configuration 
//   83        - Connect the involved FSMC pins to AF12 using the following function 
//   84           GPIO_PinAFConfig(GPIOx, GPIO_PinSourcex, GPIO_AF_FSMC); 
//   85        - Configure these FSMC pins in alternate function mode by calling the function
//   86           GPIO_Init();    
//   87        
//   88    3. Declare a FSMC_NORSRAMInitTypeDef structure, for example:
//   89           FSMC_NORSRAMInitTypeDef  FSMC_NORSRAMInitStructure;
//   90       and fill the FSMC_NORSRAMInitStructure variable with the allowed values of
//   91       the structure member.
//   92       
//   93    4. Initialize the NOR/SRAM Controller by calling the function
//   94           FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure); 
//   95 
//   96    5. Then enable the NOR/SRAM Bank, for example:
//   97           FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM2, ENABLE);  
//   98 
//   99    6. At this stage you can read/write from/to the memory connected to the NOR/SRAM Bank. 
//  100    
//  101 @endverbatim
//  102   * @{
//  103   */
//  104 
//  105 /**
//  106   * @brief  Deinitializes the FSMC NOR/SRAM Banks registers to their default 
//  107   *   reset values.
//  108   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  109   *          This parameter can be one of the following values:
//  110   *            @arg FSMC_Bank1_NORSRAM1: FSMC Bank1 NOR/SRAM1  
//  111   *            @arg FSMC_Bank1_NORSRAM2: FSMC Bank1 NOR/SRAM2 
//  112   *            @arg FSMC_Bank1_NORSRAM3: FSMC Bank1 NOR/SRAM3 
//  113   *            @arg FSMC_Bank1_NORSRAM4: FSMC Bank1 NOR/SRAM4 
//  114   * @retval None
//  115   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function FSMC_NORSRAMDeInit
        THUMB
//  116 void FSMC_NORSRAMDeInit(uint32_t FSMC_Bank)
//  117 {
//  118 	/* Check the parameter */
//  119 	assert_param(IS_FSMC_NORSRAM_BANK(FSMC_Bank));
//  120 
//  121 	/* FSMC_Bank1_NORSRAM1 */
//  122 	if(FSMC_Bank == FSMC_Bank1_NORSRAM1)
FSMC_NORSRAMDeInit:
        MOV      R1,#-1610612736
        CMP      R0,#+0
        ITTEE    EQ 
        MOVWEQ   R2,#+12507
        STREQ    R2,[R1, #+0]
        MOVWNE   R2,#+12498
        STRNE    R2,[R1, R0, LSL #+2]
//  123 	{
//  124 		FSMC_Bank1->BTCR[FSMC_Bank] = 0x000030DB;    
//  125 	}
//  126 	/* FSMC_Bank1_NORSRAM2,  FSMC_Bank1_NORSRAM3 or FSMC_Bank1_NORSRAM4 */
//  127 	else
//  128 	{   
//  129 		FSMC_Bank1->BTCR[FSMC_Bank] = 0x000030D2; 
//  130 	}
//  131 		FSMC_Bank1->BTCR[FSMC_Bank + 1] = 0x0FFFFFFF;
        MVN      R1,#-268435456
        LSLS     R2,R0,#+2
        SUB      R2,R2,#+1610612736
        STR      R1,[R2, #+4]
//  132 		FSMC_Bank1E->BWTR[FSMC_Bank] = 0x0FFFFFFF;  
        LDR.W    R2,??DataTable14  ;; 0xa0000104
        B.N      ?Subroutine4
        CFI EndBlock cfiBlock0
//  133 }
//  134 
//  135 /**
//  136   * @brief  Initializes the FSMC NOR/SRAM Banks according to the specified
//  137   *         parameters in the FSMC_NORSRAMInitStruct.
//  138   * @param  FSMC_NORSRAMInitStruct : pointer to a FSMC_NORSRAMInitTypeDef structure
//  139   *         that contains the configuration information for the FSMC NOR/SRAM 
//  140   *         specified Banks.                       
//  141   * @retval None
//  142   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function FSMC_NORSRAMInit
        THUMB
//  143 void FSMC_NORSRAMInit(FSMC_NORSRAMInitTypeDef* FSMC_NORSRAMInitStruct)
//  144 { 
FSMC_NORSRAMInit:
        PUSH     {R4}
        CFI R4 Frame(CFA, -4)
        CFI CFA R13+4
//  145 	/* Check the parameters */
//  146 	assert_param(IS_FSMC_NORSRAM_BANK(FSMC_NORSRAMInitStruct->FSMC_Bank));
//  147 	assert_param(IS_FSMC_MUX(FSMC_NORSRAMInitStruct->FSMC_DataAddressMux));
//  148 	assert_param(IS_FSMC_MEMORY(FSMC_NORSRAMInitStruct->FSMC_MemoryType));
//  149 	assert_param(IS_FSMC_MEMORY_WIDTH(FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth));
//  150 	assert_param(IS_FSMC_BURSTMODE(FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode));
//  151 	assert_param(IS_FSMC_ASYNWAIT(FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait));
//  152 	assert_param(IS_FSMC_WAIT_POLARITY(FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity));
//  153 	assert_param(IS_FSMC_WRAP_MODE(FSMC_NORSRAMInitStruct->FSMC_WrapMode));
//  154 	assert_param(IS_FSMC_WAIT_SIGNAL_ACTIVE(FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive));
//  155 	assert_param(IS_FSMC_WRITE_OPERATION(FSMC_NORSRAMInitStruct->FSMC_WriteOperation));
//  156 	assert_param(IS_FSMC_WAITE_SIGNAL(FSMC_NORSRAMInitStruct->FSMC_WaitSignal));
//  157 	assert_param(IS_FSMC_EXTENDED_MODE(FSMC_NORSRAMInitStruct->FSMC_ExtendedMode));
//  158 	assert_param(IS_FSMC_WRITE_BURST(FSMC_NORSRAMInitStruct->FSMC_WriteBurst));  
//  159 	assert_param(IS_FSMC_ADDRESS_SETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime));
//  160 	assert_param(IS_FSMC_ADDRESS_HOLD_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime));
//  161 	assert_param(IS_FSMC_DATASETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime));
//  162 	assert_param(IS_FSMC_TURNAROUND_TIME(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration));
//  163 	assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision));
//  164 	assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency));
//  165 	assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode)); 
//  166   
//  167   /* Bank1 NOR/SRAM control register configuration */ 
//  168 	FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
//  169 	        (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
//  170 	        FSMC_NORSRAMInitStruct->FSMC_MemoryType |
//  171 	        FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
//  172 	        FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
//  173 	        FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
//  174 	        FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
//  175 	        FSMC_NORSRAMInitStruct->FSMC_WrapMode |
//  176 	        FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
//  177 	        FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
//  178 	        FSMC_NORSRAMInitStruct->FSMC_WaitSignal |
//  179 	        FSMC_NORSRAMInitStruct->FSMC_ExtendedMode |
//  180 	        FSMC_NORSRAMInitStruct->FSMC_WriteBurst;
        MOV      R1,#-1610612736
        LDR      R2,[R0, #+4]
        LDR      R3,[R0, #+8]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+12]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+16]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+20]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+24]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+28]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+32]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+36]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+40]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+44]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+48]
        ORRS     R2,R3,R2
        LDR      R3,[R0, #+0]
        STR      R2,[R1, R3, LSL #+2]
//  181 	if(FSMC_NORSRAMInitStruct->FSMC_MemoryType == FSMC_MemoryType_NOR)
        LDR      R2,[R0, #+8]
        CMP      R2,#+8
        BNE.N    ??FSMC_NORSRAMInit_0
//  182 	{
//  183 		FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] |= (uint32_t)BCR_FACCEN_SET;
        LDR      R2,[R0, #+0]
        LDR      R3,[R1, R2, LSL #+2]
        ORR      R3,R3,#0x40
        STR      R3,[R1, R2, LSL #+2]
//  184 	}
//  185 	/* Bank1 NOR/SRAM timing register configuration */
//  186 	FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
//  187 	        (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
//  188 	        (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
//  189 	        (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
//  190 	        (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration << 16) |
//  191 	        (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision << 20) |
//  192 	        (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency << 24) |
//  193 	         FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode;
??FSMC_NORSRAMInit_0:
        LDR      R1,[R0, #+52]
        LDR      R2,[R1, #+0]
        LDR      R3,[R1, #+4]
        ORR      R2,R2,R3, LSL #+4
        LDR      R3,[R1, #+8]
        ORR      R2,R2,R3, LSL #+8
        LDR      R3,[R1, #+12]
        ORR      R2,R2,R3, LSL #+16
        LDR      R3,[R1, #+16]
        ORR      R2,R2,R3, LSL #+20
        LDR      R3,[R1, #+20]
        ORR      R2,R2,R3, LSL #+24
        LDR      R1,[R1, #+24]
        ORRS     R1,R1,R2
        LDR      R2,[R0, #+0]
        LSLS     R2,R2,#+2
        SUB      R2,R2,#+1610612736
        STR      R1,[R2, #+4]
//  194             
//  195     
//  196 	/* Bank1 NOR/SRAM timing register for write configuration, if extended mode is used */
//  197 	if(FSMC_NORSRAMInitStruct->FSMC_ExtendedMode == FSMC_ExtendedMode_Enable)
        LDR      R1,[R0, #+0]
        LDR.W    R2,??DataTable14  ;; 0xa0000104
        LDR      R3,[R0, #+44]
        CMP      R3,#+16384
        BNE.N    ??FSMC_NORSRAMInit_1
//  198 	{
//  199 		assert_param(IS_FSMC_ADDRESS_SETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime));
//  200 		assert_param(IS_FSMC_ADDRESS_HOLD_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime));
//  201 		assert_param(IS_FSMC_DATASETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime));
//  202 		assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision));
//  203 		assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency));
//  204 		assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
//  205 		FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
//  206 		          (uint32_t)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
//  207 		          (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
//  208 		          (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime << 8) |
//  209 		          (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision << 20) |
//  210 		          (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency << 24) |
//  211 		           FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode;
        LDR      R0,[R0, #+56]
        LDR      R3,[R0, #+0]
        LDR      R4,[R0, #+4]
        ORR      R3,R3,R4, LSL #+4
        LDR      R4,[R0, #+8]
        ORR      R3,R3,R4, LSL #+8
        LDR      R4,[R0, #+16]
        ORR      R3,R3,R4, LSL #+20
        LDR      R4,[R0, #+20]
        ORR      R3,R3,R4, LSL #+24
        LDR      R0,[R0, #+24]
        ORRS     R0,R0,R3
        B.N      ??FSMC_NORSRAMInit_2
//  212 	}
//  213 	else
//  214 	{
//  215 		FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 0x0FFFFFFF;
??FSMC_NORSRAMInit_1:
        MVN      R0,#-268435456
??FSMC_NORSRAMInit_2:
        STR      R0,[R2, R1, LSL #+2]
//  216 	}
//  217 }
        POP      {R4}
        CFI R4 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  218 
//  219 /**
//  220   * @brief  Fills each FSMC_NORSRAMInitStruct member with its default value.
//  221   * @param  FSMC_NORSRAMInitStruct: pointer to a FSMC_NORSRAMInitTypeDef structure 
//  222   *         which will be initialized.
//  223   * @retval None
//  224   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function FSMC_NORSRAMStructInit
        THUMB
//  225 void FSMC_NORSRAMStructInit(FSMC_NORSRAMInitTypeDef* FSMC_NORSRAMInitStruct)
//  226 {  
//  227   /* Reset NOR/SRAM Init structure parameters values */
//  228   FSMC_NORSRAMInitStruct->FSMC_Bank = FSMC_Bank1_NORSRAM1;
FSMC_NORSRAMStructInit:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  229   FSMC_NORSRAMInitStruct->FSMC_DataAddressMux = FSMC_DataAddressMux_Enable;
        MOVS     R1,#+2
        STR      R1,[R0, #+4]
//  230   FSMC_NORSRAMInitStruct->FSMC_MemoryType = FSMC_MemoryType_SRAM;
        MOVS     R1,#+0
        STR      R1,[R0, #+8]
//  231   FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
        STR      R1,[R0, #+12]
//  232   FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
        STR      R1,[R0, #+16]
//  233   FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait = FSMC_AsynchronousWait_Disable;
        STR      R1,[R0, #+20]
//  234   FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
        STR      R1,[R0, #+24]
//  235   FSMC_NORSRAMInitStruct->FSMC_WrapMode = FSMC_WrapMode_Disable;
        STR      R1,[R0, #+28]
//  236   FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
        STR      R1,[R0, #+32]
//  237   FSMC_NORSRAMInitStruct->FSMC_WriteOperation = FSMC_WriteOperation_Enable;
        MOV      R1,#+4096
        STR      R1,[R0, #+36]
//  238   FSMC_NORSRAMInitStruct->FSMC_WaitSignal = FSMC_WaitSignal_Enable;
        MOV      R1,#+8192
        STR      R1,[R0, #+40]
//  239   FSMC_NORSRAMInitStruct->FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
        MOVS     R1,#+0
        STR      R1,[R0, #+44]
//  240   FSMC_NORSRAMInitStruct->FSMC_WriteBurst = FSMC_WriteBurst_Disable;
        STR      R1,[R0, #+48]
//  241   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime = 0xF;
        LDR      R1,[R0, #+52]
        MOVS     R2,#+15
        STR      R2,[R1, #+0]
//  242   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime = 0xF;
        STR      R2,[R1, #+4]
//  243   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime = 0xFF;
        MOVS     R2,#+255
        STR      R2,[R1, #+8]
//  244   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration = 0xF;
        MOVS     R3,#+15
        STR      R3,[R1, #+12]
//  245   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision = 0xF;
        STR      R3,[R1, #+16]
//  246   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency = 0xF;
        STR      R3,[R1, #+20]
//  247   FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode = FSMC_AccessMode_A; 
        MOVS     R3,#+0
        STR      R3,[R1, #+24]
//  248   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime = 0xF;
        LDR      R0,[R0, #+56]
        MOVS     R1,#+15
        STR      R1,[R0, #+0]
//  249   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime = 0xF;
        STR      R1,[R0, #+4]
//  250   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime = 0xFF;
        STR      R2,[R0, #+8]
//  251   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_BusTurnAroundDuration = 0xF;
        STR      R1,[R0, #+12]
//  252   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision = 0xF;
        STR      R1,[R0, #+16]
//  253   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency = 0xF;
        STR      R1,[R0, #+20]
//  254   FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode = FSMC_AccessMode_A;
        STR      R3,[R0, #+24]
//  255 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  256 
//  257 /**
//  258   * @brief  Enables or disables the specified NOR/SRAM Memory Bank.
//  259   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  260   *          This parameter can be one of the following values:
//  261   *            @arg FSMC_Bank1_NORSRAM1: FSMC Bank1 NOR/SRAM1  
//  262   *            @arg FSMC_Bank1_NORSRAM2: FSMC Bank1 NOR/SRAM2 
//  263   *            @arg FSMC_Bank1_NORSRAM3: FSMC Bank1 NOR/SRAM3 
//  264   *            @arg FSMC_Bank1_NORSRAM4: FSMC Bank1 NOR/SRAM4 
//  265   * @param  NewState: new state of the FSMC_Bank. This parameter can be: ENABLE or DISABLE.
//  266   * @retval None
//  267   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function FSMC_NORSRAMCmd
        THUMB
//  268 void FSMC_NORSRAMCmd(uint32_t FSMC_Bank, FunctionalState NewState)
//  269 {
//  270   assert_param(IS_FSMC_NORSRAM_BANK(FSMC_Bank));
//  271   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  272   
//  273   if (NewState != DISABLE)
FSMC_NORSRAMCmd:
        MOV      R2,#-1610612736
        CMP      R1,#+0
        LDR      R1,[R2, R0, LSL #+2]
        ITEE     NE 
        ORRNE    R1,R1,#0x1
        LDREQ.N  R3,??DataTable14_1  ;; 0xffffe
        ANDEQ    R1,R3,R1
        CFI EndBlock cfiBlock3
//  274   {
//  275     /* Enable the selected NOR/SRAM Bank by setting the PBKEN bit in the BCRx register */
//  276     FSMC_Bank1->BTCR[FSMC_Bank] |= BCR_MBKEN_SET;
//  277   }
//  278   else
//  279   {
//  280     /* Disable the selected NOR/SRAM Bank by clearing the PBKEN bit in the BCRx register */
//  281     FSMC_Bank1->BTCR[FSMC_Bank] &= BCR_MBKEN_RESET;
        REQUIRE ?Subroutine4
        ;; // Fall through to label ?Subroutine4
//  282   }
//  283 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine4:
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  284 /**
//  285   * @}
//  286   */
//  287 
//  288 /** @defgroup FSMC_Group2 NAND Controller functions
//  289  *  @brief   NAND Controller functions 
//  290  *
//  291 @verbatim   
//  292  ===============================================================================
//  293                     NAND Controller functions
//  294  ===============================================================================  
//  295 
//  296  The following sequence should be followed to configure the FSMC to interface with
//  297  8-bit or 16-bit NAND memory connected to the NAND Bank:
//  298  
//  299    1. Enable the clock for the FSMC and associated GPIOs using the following functions:
//  300           RCC_AHB3PeriphClockCmd(RCC_AHB3Periph_FSMC, ENABLE);
//  301           RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOx, ENABLE);
//  302 
//  303    2. FSMC pins configuration 
//  304        - Connect the involved FSMC pins to AF12 using the following function 
//  305           GPIO_PinAFConfig(GPIOx, GPIO_PinSourcex, GPIO_AF_FSMC); 
//  306        - Configure these FSMC pins in alternate function mode by calling the function
//  307           GPIO_Init();    
//  308        
//  309    3. Declare a FSMC_NANDInitTypeDef structure, for example:
//  310           FSMC_NANDInitTypeDef  FSMC_NANDInitStructure;
//  311       and fill the FSMC_NANDInitStructure variable with the allowed values of
//  312       the structure member.
//  313       
//  314    4. Initialize the NAND Controller by calling the function
//  315           FSMC_NANDInit(&FSMC_NANDInitStructure); 
//  316 
//  317    5. Then enable the NAND Bank, for example:
//  318           FSMC_NANDCmd(FSMC_Bank3_NAND, ENABLE);  
//  319 
//  320    6. At this stage you can read/write from/to the memory connected to the NAND Bank. 
//  321    
//  322 @note To enable the Error Correction Code (ECC), you have to use the function
//  323           FSMC_NANDECCCmd(FSMC_Bank3_NAND, ENABLE);  
//  324       and to get the current ECC value you have to use the function
//  325           ECCval = FSMC_GetECC(FSMC_Bank3_NAND); 
//  326 
//  327 @endverbatim
//  328   * @{
//  329   */
//  330   
//  331 /**
//  332   * @brief  Deinitializes the FSMC NAND Banks registers to their default reset values.
//  333   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  334   *          This parameter can be one of the following values:
//  335   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  336   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND 
//  337   * @retval None
//  338   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function FSMC_NANDDeInit
        THUMB
//  339 void FSMC_NANDDeInit(uint32_t FSMC_Bank)
//  340 {
//  341   /* Check the parameter */
//  342   assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
//  343   
//  344   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_NANDDeInit:
        MOV      R1,#-50529028
        LDR.N    R2,??DataTable14_2  ;; 0xa0000060
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDDeInit_0
//  345   {
//  346     /* Set the FSMC_Bank2 registers to their reset values */
//  347     FSMC_Bank2->PCR2 = 0x00000018;
        MOVS     R0,#+24
        STR      R0,[R2, #+0]
//  348     FSMC_Bank2->SR2 = 0x00000040;
        MOVS     R0,#+64
        STR      R0,[R2, #+4]
//  349     FSMC_Bank2->PMEM2 = 0xFCFCFCFC;
        STR      R1,[R2, #+8]
//  350     FSMC_Bank2->PATT2 = 0xFCFCFCFC;  
        STR      R1,[R2, #+12]
        BX       LR
//  351   }
//  352   /* FSMC_Bank3_NAND */  
//  353   else
//  354   {
//  355     /* Set the FSMC_Bank3 registers to their reset values */
//  356     FSMC_Bank3->PCR3 = 0x00000018;
??FSMC_NANDDeInit_0:
        MOVS     R0,#+24
        STR      R0,[R2, #+32]
//  357     FSMC_Bank3->SR3 = 0x00000040;
        MOVS     R0,#+64
        STR      R0,[R2, #+36]
//  358     FSMC_Bank3->PMEM3 = 0xFCFCFCFC;
        STR      R1,[R2, #+40]
//  359     FSMC_Bank3->PATT3 = 0xFCFCFCFC; 
        STR      R1,[R2, #+44]
//  360   }  
//  361 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  362 
//  363 /**
//  364   * @brief  Initializes the FSMC NAND Banks according to the specified parameters
//  365   *         in the FSMC_NANDInitStruct.
//  366   * @param  FSMC_NANDInitStruct : pointer to a FSMC_NANDInitTypeDef structure that
//  367   *         contains the configuration information for the FSMC NAND specified Banks.                       
//  368   * @retval None
//  369   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function FSMC_NANDInit
        THUMB
//  370 void FSMC_NANDInit(FSMC_NANDInitTypeDef* FSMC_NANDInitStruct)
//  371 {
FSMC_NANDInit:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  372   uint32_t tmppcr = 0x00000000, tmppmem = 0x00000000, tmppatt = 0x00000000; 
//  373     
//  374   /* Check the parameters */
//  375   assert_param( IS_FSMC_NAND_BANK(FSMC_NANDInitStruct->FSMC_Bank));
//  376   assert_param( IS_FSMC_WAIT_FEATURE(FSMC_NANDInitStruct->FSMC_Waitfeature));
//  377   assert_param( IS_FSMC_MEMORY_WIDTH(FSMC_NANDInitStruct->FSMC_MemoryDataWidth));
//  378   assert_param( IS_FSMC_ECC_STATE(FSMC_NANDInitStruct->FSMC_ECC));
//  379   assert_param( IS_FSMC_ECCPAGE_SIZE(FSMC_NANDInitStruct->FSMC_ECCPageSize));
//  380   assert_param( IS_FSMC_TCLR_TIME(FSMC_NANDInitStruct->FSMC_TCLRSetupTime));
//  381   assert_param( IS_FSMC_TAR_TIME(FSMC_NANDInitStruct->FSMC_TARSetupTime));
//  382   assert_param(IS_FSMC_SETUP_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime));
//  383   assert_param(IS_FSMC_WAIT_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime));
//  384   assert_param(IS_FSMC_HOLD_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime));
//  385   assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime));
//  386   assert_param(IS_FSMC_SETUP_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime));
//  387   assert_param(IS_FSMC_WAIT_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime));
//  388   assert_param(IS_FSMC_HOLD_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime));
//  389   assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
//  390   
//  391   /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
//  392   tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
//  393             PCR_MEMORYTYPE_NAND |
//  394             FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
//  395             FSMC_NANDInitStruct->FSMC_ECC |
//  396             FSMC_NANDInitStruct->FSMC_ECCPageSize |
//  397             (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
//  398             (FSMC_NANDInitStruct->FSMC_TARSetupTime << 13);
        LDR      R1,[R0, #+4]
        LDR      R2,[R0, #+8]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+12]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+16]
        ORRS     R1,R2,R1
        LDR      R2,[R0, #+20]
        ORR      R1,R1,R2, LSL #+9
        LDR      R2,[R0, #+24]
        ORR      R1,R1,R2, LSL #+13
        ORR      R1,R1,#0x8
//  399             
//  400   /* Set tmppmem value according to FSMC_CommonSpaceTimingStructure parameters */
//  401   tmppmem = (uint32_t)FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
//  402             (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  403             (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  404             (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
        LDR      R2,[R0, #+28]
        LDR      R3,[R2, #+0]
        LDR      R4,[R2, #+4]
        ORR      R3,R3,R4, LSL #+8
        LDR      R4,[R2, #+8]
        ORR      R3,R3,R4, LSL #+16
        LDR      R2,[R2, #+12]
        ORR      R2,R3,R2, LSL #+24
//  405             
//  406   /* Set tmppatt value according to FSMC_AttributeSpaceTimingStructure parameters */
//  407   tmppatt = (uint32_t)FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
//  408             (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  409             (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  410             (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);
        LDR      R3,[R0, #+32]
        LDR      R4,[R3, #+0]
        LDR      R5,[R3, #+4]
        ORR      R4,R4,R5, LSL #+8
        LDR      R5,[R3, #+8]
        ORR      R4,R4,R5, LSL #+16
        LDR      R3,[R3, #+12]
        ORR      R3,R4,R3, LSL #+24
//  411   
//  412 	if(FSMC_NANDInitStruct->FSMC_Bank == FSMC_Bank2_NAND)
        LDR.N    R4,??DataTable14_2  ;; 0xa0000060
        LDR      R0,[R0, #+0]
        CMP      R0,#+16
        ITTT     EQ 
        STREQ    R1,[R4, #+0]
        STREQ    R2,[R4, #+8]
        STREQ    R3,[R4, #+12]
//  413 	{
//  414 		/* FSMC_Bank2_NAND registers configuration */
//  415 		FSMC_Bank2->PCR2 = tmppcr;
//  416 		FSMC_Bank2->PMEM2 = tmppmem;
//  417 		FSMC_Bank2->PATT2 = tmppatt;
        BEQ.N    ??FSMC_NANDInit_0
//  418 	}
//  419 	else
//  420 	{
//  421 		/* FSMC_Bank3_NAND registers configuration */
//  422 		FSMC_Bank3->PCR3 = tmppcr;
        STR      R1,[R4, #+32]
//  423 		FSMC_Bank3->PMEM3 = tmppmem;
        STR      R2,[R4, #+40]
//  424 		FSMC_Bank3->PATT3 = tmppatt;
        STR      R3,[R4, #+44]
//  425 	}
//  426 }
??FSMC_NANDInit_0:
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  427 
//  428 
//  429 /**
//  430   * @brief  Fills each FSMC_NANDInitStruct member with its default value.
//  431   * @param  FSMC_NANDInitStruct: pointer to a FSMC_NANDInitTypeDef structure which
//  432   *         will be initialized.
//  433   * @retval None
//  434   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function FSMC_NANDStructInit
        THUMB
//  435 void FSMC_NANDStructInit(FSMC_NANDInitTypeDef* FSMC_NANDInitStruct)
//  436 { 
//  437   /* Reset NAND Init structure parameters values */
//  438   FSMC_NANDInitStruct->FSMC_Bank = FSMC_Bank2_NAND;
FSMC_NANDStructInit:
        MOVS     R1,#+16
        STR      R1,[R0, #+0]
//  439   FSMC_NANDInitStruct->FSMC_Waitfeature = FSMC_Waitfeature_Disable;
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//  440   FSMC_NANDInitStruct->FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
        STR      R1,[R0, #+8]
//  441   FSMC_NANDInitStruct->FSMC_ECC = FSMC_ECC_Disable;
        STR      R1,[R0, #+12]
//  442   FSMC_NANDInitStruct->FSMC_ECCPageSize = FSMC_ECCPageSize_256Bytes;
        STR      R1,[R0, #+16]
//  443   FSMC_NANDInitStruct->FSMC_TCLRSetupTime = 0x0;
        STR      R1,[R0, #+20]
//  444   FSMC_NANDInitStruct->FSMC_TARSetupTime = 0x0;
        STR      R1,[R0, #+24]
//  445   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R1,[R0, #+28]
        MOVS     R2,#+252
        STR      R2,[R1, #+0]
//  446   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R1, #+4]
//  447   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R1, #+8]
//  448   FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
        STR      R2,[R1, #+12]
//  449   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R0,[R0, #+32]
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock7
//  450   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
//  451   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
//  452   FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;	  
//  453 }
//  454 
//  455 /**
//  456   * @brief  Enables or disables the specified NAND Memory Bank.
//  457   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  458   *          This parameter can be one of the following values:
//  459   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  460   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  461   * @param  NewState: new state of the FSMC_Bank. This parameter can be: ENABLE or DISABLE.
//  462   * @retval None
//  463   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function FSMC_NANDCmd
        THUMB
//  464 void FSMC_NANDCmd(uint32_t FSMC_Bank, FunctionalState NewState)
//  465 {
//  466   assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
//  467   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  468   
//  469   if (NewState != DISABLE)
FSMC_NANDCmd:
        LDR.N    R2,??DataTable14_2  ;; 0xa0000060
        CBZ.N    R1,??FSMC_NANDCmd_0
//  470   {
//  471     /* Enable the selected NAND Bank by setting the PBKEN bit in the PCRx register */
//  472     if(FSMC_Bank == FSMC_Bank2_NAND)
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDCmd_1
//  473     {
//  474       FSMC_Bank2->PCR2 |= PCR_PBKEN_SET;
        LDR      R0,[R2, #+0]
        ORR      R0,R0,#0x4
??FSMC_NANDCmd_2:
        STR      R0,[R2, #+0]
        BX       LR
//  475     }
//  476     else
//  477     {
//  478       FSMC_Bank3->PCR3 |= PCR_PBKEN_SET;
??FSMC_NANDCmd_1:
        LDR      R0,[R2, #+32]
        ORR      R0,R0,#0x4
        B.N      ??FSMC_NANDCmd_3
//  479     }
//  480   }
//  481   else
//  482   {
//  483     /* Disable the selected NAND Bank by clearing the PBKEN bit in the PCRx register */
//  484     if(FSMC_Bank == FSMC_Bank2_NAND)
??FSMC_NANDCmd_0:
        LDR.N    R1,??DataTable14_3  ;; 0xffffb
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDCmd_4
//  485     {
//  486       FSMC_Bank2->PCR2 &= PCR_PBKEN_RESET;
        LDR      R0,[R2, #+0]
        ANDS     R0,R1,R0
        B.N      ??FSMC_NANDCmd_2
//  487     }
//  488     else
//  489     {
//  490       FSMC_Bank3->PCR3 &= PCR_PBKEN_RESET;
??FSMC_NANDCmd_4:
        LDR      R0,[R2, #+32]
        ANDS     R0,R1,R0
??FSMC_NANDCmd_3:
        STR      R0,[R2, #+32]
//  491     }
//  492   }
//  493 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  494 /**
//  495   * @brief  Enables or disables the FSMC NAND ECC feature.
//  496   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  497   *          This parameter can be one of the following values:
//  498   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  499   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  500   * @param  NewState: new state of the FSMC NAND ECC feature.  
//  501   *          This parameter can be: ENABLE or DISABLE.
//  502   * @retval None
//  503   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function FSMC_NANDECCCmd
        THUMB
//  504 void FSMC_NANDECCCmd(uint32_t FSMC_Bank, FunctionalState NewState)
//  505 {
//  506   assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
//  507   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  508   
//  509   if (NewState != DISABLE)
FSMC_NANDECCCmd:
        LDR.N    R2,??DataTable14_2  ;; 0xa0000060
        CBZ.N    R1,??FSMC_NANDECCCmd_0
//  510   {
//  511     /* Enable the selected NAND Bank ECC function by setting the ECCEN bit in the PCRx register */
//  512     if(FSMC_Bank == FSMC_Bank2_NAND)
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDECCCmd_1
//  513     {
//  514       FSMC_Bank2->PCR2 |= PCR_ECCEN_SET;
        LDR      R0,[R2, #+0]
        ORR      R0,R0,#0x40
??FSMC_NANDECCCmd_2:
        STR      R0,[R2, #+0]
        BX       LR
//  515     }
//  516     else
//  517     {
//  518       FSMC_Bank3->PCR3 |= PCR_ECCEN_SET;
??FSMC_NANDECCCmd_1:
        LDR      R0,[R2, #+32]
        ORR      R0,R0,#0x40
        B.N      ??FSMC_NANDECCCmd_3
//  519     }
//  520   }
//  521   else
//  522   {
//  523     /* Disable the selected NAND Bank ECC function by clearing the ECCEN bit in the PCRx register */
//  524     if(FSMC_Bank == FSMC_Bank2_NAND)
??FSMC_NANDECCCmd_0:
        LDR.N    R1,??DataTable14_4  ;; 0xfffbf
        CMP      R0,#+16
        BNE.N    ??FSMC_NANDECCCmd_4
//  525     {
//  526       FSMC_Bank2->PCR2 &= PCR_ECCEN_RESET;
        LDR      R0,[R2, #+0]
        ANDS     R0,R1,R0
        B.N      ??FSMC_NANDECCCmd_2
//  527     }
//  528     else
//  529     {
//  530       FSMC_Bank3->PCR3 &= PCR_ECCEN_RESET;
??FSMC_NANDECCCmd_4:
        LDR      R0,[R2, #+32]
        ANDS     R0,R1,R0
??FSMC_NANDECCCmd_3:
        STR      R0,[R2, #+32]
//  531     }
//  532   }
//  533 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  534 
//  535 /**
//  536   * @brief  Returns the error correction code register value.
//  537   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  538   *          This parameter can be one of the following values:
//  539   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  540   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  541   * @retval The Error Correction Code (ECC) value.
//  542   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function FSMC_GetECC
        THUMB
//  543 uint32_t FSMC_GetECC(uint32_t FSMC_Bank)
//  544 {
//  545   uint32_t eccval = 0x00000000;
//  546   
//  547   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_GetECC:
        LDR.N    R1,??DataTable14_5  ;; 0xa0000074
        CMP      R0,#+16
        ITE      EQ 
        LDREQ    R0,[R1, #+0]
        LDRNE    R0,[R1, #+32]
//  548   {
//  549     /* Get the ECCR2 register value */
//  550     eccval = FSMC_Bank2->ECCR2;
        BX       LR
        CFI EndBlock cfiBlock10
//  551   }
//  552   else
//  553   {
//  554     /* Get the ECCR3 register value */
//  555     eccval = FSMC_Bank3->ECCR3;
//  556   }
//  557   /* Return the error correction code value */
//  558   return(eccval);
//  559 }
//  560 /**
//  561   * @}
//  562   */
//  563 
//  564 /** @defgroup FSMC_Group3 PCCARD Controller functions
//  565  *  @brief   PCCARD Controller functions 
//  566  *
//  567 @verbatim   
//  568  ===============================================================================
//  569                     PCCARD Controller functions
//  570  ===============================================================================  
//  571 
//  572  The following sequence should be followed to configure the FSMC to interface with
//  573  16-bit PC Card compatible memory connected to the PCCARD Bank:
//  574  
//  575    1. Enable the clock for the FSMC and associated GPIOs using the following functions:
//  576           RCC_AHB3PeriphClockCmd(RCC_AHB3Periph_FSMC, ENABLE);
//  577           RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOx, ENABLE);
//  578 
//  579    2. FSMC pins configuration 
//  580        - Connect the involved FSMC pins to AF12 using the following function 
//  581           GPIO_PinAFConfig(GPIOx, GPIO_PinSourcex, GPIO_AF_FSMC); 
//  582        - Configure these FSMC pins in alternate function mode by calling the function
//  583           GPIO_Init();    
//  584        
//  585    3. Declare a FSMC_PCCARDInitTypeDef structure, for example:
//  586           FSMC_PCCARDInitTypeDef  FSMC_PCCARDInitStructure;
//  587       and fill the FSMC_PCCARDInitStructure variable with the allowed values of
//  588       the structure member.
//  589       
//  590    4. Initialize the PCCARD Controller by calling the function
//  591           FSMC_PCCARDInit(&FSMC_PCCARDInitStructure); 
//  592 
//  593    5. Then enable the PCCARD Bank:
//  594           FSMC_PCCARDCmd(ENABLE);  
//  595 
//  596    6. At this stage you can read/write from/to the memory connected to the PCCARD Bank. 
//  597  
//  598 @endverbatim
//  599   * @{
//  600   */
//  601 
//  602 /**
//  603   * @brief  Deinitializes the FSMC PCCARD Bank registers to their default reset values.
//  604   * @param  None                       
//  605   * @retval None
//  606   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function FSMC_PCCARDDeInit
        THUMB
//  607 void FSMC_PCCARDDeInit(void)
//  608 {
//  609   /* Set the FSMC_Bank4 registers to their reset values */
//  610   FSMC_Bank4->PCR4 = 0x00000018; 
FSMC_PCCARDDeInit:
        LDR.N    R0,??DataTable14_6  ;; 0xa00000a0
        MOVS     R1,#+24
        STR      R1,[R0, #+0]
//  611   FSMC_Bank4->SR4 = 0x00000000;	
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//  612   FSMC_Bank4->PMEM4 = 0xFCFCFCFC;
        MOV      R1,#-50529028
        STR      R1,[R0, #+8]
//  613   FSMC_Bank4->PATT4 = 0xFCFCFCFC;
        STR      R1,[R0, #+12]
//  614   FSMC_Bank4->PIO4 = 0xFCFCFCFC;
        STR      R1,[R0, #+16]
//  615 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  616 
//  617 /**
//  618   * @brief  Initializes the FSMC PCCARD Bank according to the specified parameters
//  619   *         in the FSMC_PCCARDInitStruct.
//  620   * @param  FSMC_PCCARDInitStruct : pointer to a FSMC_PCCARDInitTypeDef structure
//  621   *         that contains the configuration information for the FSMC PCCARD Bank.                       
//  622   * @retval None
//  623   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function FSMC_PCCARDInit
        THUMB
//  624 void FSMC_PCCARDInit(FSMC_PCCARDInitTypeDef* FSMC_PCCARDInitStruct)
//  625 {
FSMC_PCCARDInit:
        PUSH     {R4}
        CFI R4 Frame(CFA, -4)
        CFI CFA R13+4
//  626   /* Check the parameters */
//  627   assert_param(IS_FSMC_WAIT_FEATURE(FSMC_PCCARDInitStruct->FSMC_Waitfeature));
//  628   assert_param(IS_FSMC_TCLR_TIME(FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime));
//  629   assert_param(IS_FSMC_TAR_TIME(FSMC_PCCARDInitStruct->FSMC_TARSetupTime));
//  630  
//  631   assert_param(IS_FSMC_SETUP_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime));
//  632   assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime));
//  633   assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime));
//  634   assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime));
//  635   
//  636   assert_param(IS_FSMC_SETUP_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime));
//  637   assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime));
//  638   assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime));
//  639   assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
//  640   assert_param(IS_FSMC_SETUP_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime));
//  641   assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime));
//  642   assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime));
//  643   assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime));
//  644   
//  645   /* Set the PCR4 register value according to FSMC_PCCARDInitStruct parameters */
//  646   FSMC_Bank4->PCR4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_Waitfeature |
//  647                      FSMC_MemoryDataWidth_16b |  
//  648                      (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
//  649                      (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
        LDR.N    R1,??DataTable14_6  ;; 0xa00000a0
        LDR      R2,[R0, #+0]
        LDR      R3,[R0, #+4]
        ORR      R2,R2,R3, LSL #+9
        LDR      R3,[R0, #+8]
        ORR      R2,R2,R3, LSL #+13
        ORR      R2,R2,#0x10
        STR      R2,[R1, #+0]
//  650             
//  651   /* Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters */
//  652   FSMC_Bank4->PMEM4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
//  653                       (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  654                       (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  655                       (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
        LDR      R2,[R0, #+12]
        LDR      R3,[R2, #+0]
        LDR      R4,[R2, #+4]
        ORR      R3,R3,R4, LSL #+8
        LDR      R4,[R2, #+8]
        ORR      R3,R3,R4, LSL #+16
        LDR      R2,[R2, #+12]
        ORR      R2,R3,R2, LSL #+24
        STR      R2,[R1, #+8]
//  656             
//  657   /* Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters */
//  658   FSMC_Bank4->PATT4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
//  659                       (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  660                       (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  661                       (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
        LDR      R2,[R0, #+16]
        LDR      R3,[R2, #+0]
        LDR      R4,[R2, #+4]
        ORR      R3,R3,R4, LSL #+8
        LDR      R4,[R2, #+8]
        ORR      R3,R3,R4, LSL #+16
        LDR      R2,[R2, #+12]
        ORR      R2,R3,R2, LSL #+24
        STR      R2,[R1, #+12]
//  662             
//  663   /* Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters */
//  664   FSMC_Bank4->PIO4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime |
//  665                      (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
//  666                      (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
//  667                      (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime << 24);             
        LDR      R0,[R0, #+20]
        LDR      R2,[R0, #+0]
        LDR      R3,[R0, #+4]
        ORR      R2,R2,R3, LSL #+8
        LDR      R3,[R0, #+8]
        ORR      R2,R2,R3, LSL #+16
        LDR      R0,[R0, #+12]
        ORR      R0,R2,R0, LSL #+24
        STR      R0,[R1, #+16]
//  668 }
        POP      {R4}
        CFI R4 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  669 
//  670 /**
//  671   * @brief  Fills each FSMC_PCCARDInitStruct member with its default value.
//  672   * @param  FSMC_PCCARDInitStruct: pointer to a FSMC_PCCARDInitTypeDef structure
//  673   *         which will be initialized.
//  674   * @retval None
//  675   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function FSMC_PCCARDStructInit
        THUMB
//  676 void FSMC_PCCARDStructInit(FSMC_PCCARDInitTypeDef* FSMC_PCCARDInitStruct)
//  677 {
//  678   /* Reset PCCARD Init structure parameters values */
//  679   FSMC_PCCARDInitStruct->FSMC_Waitfeature = FSMC_Waitfeature_Disable;
FSMC_PCCARDStructInit:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  680   FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime = 0x0;
        STR      R1,[R0, #+4]
//  681   FSMC_PCCARDInitStruct->FSMC_TARSetupTime = 0x0;
        STR      R1,[R0, #+8]
//  682   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R1,[R0, #+12]
        MOVS     R2,#+252
        STR      R2,[R1, #+0]
//  683   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R1, #+4]
//  684   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R1, #+8]
//  685   FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
        STR      R2,[R1, #+12]
//  686   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R1,[R0, #+16]
        STR      R2,[R1, #+0]
//  687   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
        STR      R2,[R1, #+4]
//  688   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
        STR      R2,[R1, #+8]
//  689   FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;	
        STR      R2,[R1, #+12]
//  690   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime = 0xFC;
        LDR      R0,[R0, #+20]
        CFI EndBlock cfiBlock13
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  691   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
//  692   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
//  693   FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
//  694 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        STR      R2,[R0, #+0]
        STR      R2,[R0, #+4]
        STR      R2,[R0, #+8]
        STR      R2,[R0, #+12]
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  695 
//  696 /**
//  697   * @brief  Enables or disables the PCCARD Memory Bank.
//  698   * @param  NewState: new state of the PCCARD Memory Bank.  
//  699   *          This parameter can be: ENABLE or DISABLE.
//  700   * @retval None
//  701   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function FSMC_PCCARDCmd
        THUMB
//  702 void FSMC_PCCARDCmd(FunctionalState NewState)
//  703 {
//  704   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  705   
//  706   if (NewState != DISABLE)
FSMC_PCCARDCmd:
        LDR.N    R1,??DataTable14_6  ;; 0xa00000a0
        CMP      R0,#+0
        LDR      R0,[R1, #+0]
        ITEE     NE 
        ORRNE    R0,R0,#0x4
        LDREQ.N  R2,??DataTable14_3  ;; 0xffffb
        ANDEQ    R0,R2,R0
//  707   {
//  708     /* Enable the PCCARD Bank by setting the PBKEN bit in the PCR4 register */
//  709     FSMC_Bank4->PCR4 |= PCR_PBKEN_SET;
//  710   }
//  711   else
//  712   {
//  713     /* Disable the PCCARD Bank by clearing the PBKEN bit in the PCR4 register */
//  714     FSMC_Bank4->PCR4 &= PCR_PBKEN_RESET;
        STR      R0,[R1, #+0]
//  715   }
//  716 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  717 /**
//  718   * @}
//  719   */
//  720 
//  721 /** @defgroup FSMC_Group4  Interrupts and flags management functions
//  722  *  @brief    Interrupts and flags management functions
//  723  *
//  724 @verbatim   
//  725  ===============================================================================
//  726                      Interrupts and flags management functions
//  727  ===============================================================================  
//  728 
//  729 @endverbatim
//  730   * @{
//  731   */
//  732 
//  733 /**
//  734   * @brief  Enables or disables the specified FSMC interrupts.
//  735   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  736   *          This parameter can be one of the following values:
//  737   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  738   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  739   *            @arg FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  740   * @param  FSMC_IT: specifies the FSMC interrupt sources to be enabled or disabled.
//  741   *          This parameter can be any combination of the following values:
//  742   *            @arg FSMC_IT_RisingEdge: Rising edge detection interrupt. 
//  743   *            @arg FSMC_IT_Level: Level edge detection interrupt.
//  744   *            @arg FSMC_IT_FallingEdge: Falling edge detection interrupt.
//  745   * @param  NewState: new state of the specified FSMC interrupts.
//  746   *          This parameter can be: ENABLE or DISABLE.
//  747   * @retval None
//  748   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function FSMC_ITConfig
        THUMB
//  749 void FSMC_ITConfig(uint32_t FSMC_Bank, uint32_t FSMC_IT, FunctionalState NewState)
//  750 {
//  751   assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
//  752   assert_param(IS_FSMC_IT(FSMC_IT));	
//  753   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  754   
//  755   if (NewState != DISABLE)
FSMC_ITConfig:
        LDR.N    R3,??DataTable14_7  ;; 0xa0000064
        CBZ.N    R2,??FSMC_ITConfig_0
//  756   {
//  757     /* Enable the selected FSMC_Bank2 interrupts */
//  758     if(FSMC_Bank == FSMC_Bank2_NAND)
        CMP      R0,#+16
        BNE.N    ??FSMC_ITConfig_1
//  759     {
//  760       FSMC_Bank2->SR2 |= FSMC_IT;
        LDR      R0,[R3, #+0]
        ORRS     R0,R1,R0
??FSMC_ITConfig_2:
        STR      R0,[R3, #+0]
        BX       LR
//  761     }
//  762     /* Enable the selected FSMC_Bank3 interrupts */
//  763     else if (FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ITConfig_1:
        MOV      R2,#+256
        CMP      R0,R2
        BNE.N    ??FSMC_ITConfig_3
//  764     {
//  765       FSMC_Bank3->SR3 |= FSMC_IT;
        LDR      R0,[R3, #+32]
        ORRS     R0,R1,R0
??FSMC_ITConfig_4:
        STR      R0,[R3, #+32]
        BX       LR
//  766     }
//  767     /* Enable the selected FSMC_Bank4 interrupts */
//  768     else
//  769     {
//  770       FSMC_Bank4->SR4 |= FSMC_IT;    
??FSMC_ITConfig_3:
        LDR      R0,[R3, #+64]
        ORRS     R0,R1,R0
        B.N      ??FSMC_ITConfig_5
//  771     }
//  772   }
//  773   else
//  774   {
//  775     /* Disable the selected FSMC_Bank2 interrupts */
//  776     if(FSMC_Bank == FSMC_Bank2_NAND)
??FSMC_ITConfig_0:
        MVNS     R1,R1
        CMP      R0,#+16
        BNE.N    ??FSMC_ITConfig_6
//  777     {
//  778       
//  779       FSMC_Bank2->SR2 &= (uint32_t)~FSMC_IT;
        LDR      R0,[R3, #+0]
        ANDS     R0,R1,R0
        B.N      ??FSMC_ITConfig_2
//  780     }
//  781     /* Disable the selected FSMC_Bank3 interrupts */
//  782     else if (FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ITConfig_6:
        MOV      R2,#+256
        CMP      R0,R2
        BNE.N    ??FSMC_ITConfig_7
//  783     {
//  784       FSMC_Bank3->SR3 &= (uint32_t)~FSMC_IT;
        LDR      R0,[R3, #+32]
        ANDS     R0,R1,R0
        B.N      ??FSMC_ITConfig_4
//  785     }
//  786     /* Disable the selected FSMC_Bank4 interrupts */
//  787     else
//  788     {
//  789       FSMC_Bank4->SR4 &= (uint32_t)~FSMC_IT;    
??FSMC_ITConfig_7:
        LDR      R0,[R3, #+64]
        ANDS     R0,R1,R0
??FSMC_ITConfig_5:
        STR      R0,[R3, #+64]
//  790     }
//  791   }
//  792 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  793 
//  794 /**
//  795   * @brief  Checks whether the specified FSMC flag is set or not.
//  796   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  797   *          This parameter can be one of the following values:
//  798   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  799   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  800   *            @arg FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  801   * @param  FSMC_FLAG: specifies the flag to check.
//  802   *          This parameter can be one of the following values:
//  803   *            @arg FSMC_FLAG_RisingEdge: Rising edge detection Flag.
//  804   *            @arg FSMC_FLAG_Level: Level detection Flag.
//  805   *            @arg FSMC_FLAG_FallingEdge: Falling edge detection Flag.
//  806   *            @arg FSMC_FLAG_FEMPT: Fifo empty Flag. 
//  807   * @retval The new state of FSMC_FLAG (SET or RESET).
//  808   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function FSMC_GetFlagStatus
        THUMB
//  809 FlagStatus FSMC_GetFlagStatus(uint32_t FSMC_Bank, uint32_t FSMC_FLAG)
//  810 {
//  811   FlagStatus bitstatus = RESET;
FSMC_GetFlagStatus:
        MOVS     R2,#+0
//  812   uint32_t tmpsr = 0x00000000;
//  813   
//  814   /* Check the parameters */
//  815   assert_param(IS_FSMC_GETFLAG_BANK(FSMC_Bank));
//  816   assert_param(IS_FSMC_GET_FLAG(FSMC_FLAG));
//  817   
//  818   if(FSMC_Bank == FSMC_Bank2_NAND)
        LDR.N    R3,??DataTable14_7  ;; 0xa0000064
        CMP      R0,#+16
        IT       EQ 
        LDREQ    R0,[R3, #+0]
//  819   {
//  820     tmpsr = FSMC_Bank2->SR2;
        BEQ.N    ??FSMC_GetFlagStatus_0
//  821   }  
//  822   else if(FSMC_Bank == FSMC_Bank3_NAND)
        MOV      R12,#+256
        CMP      R0,R12
        ITE      EQ 
        LDREQ    R0,[R3, #+32]
        LDRNE    R0,[R3, #+64]
//  823   {
//  824     tmpsr = FSMC_Bank3->SR3;
//  825   }
//  826   /* FSMC_Bank4_PCCARD*/
//  827   else
//  828   {
//  829     tmpsr = FSMC_Bank4->SR4;
//  830   } 
//  831   
//  832   /* Get the flag status */
//  833   if ((tmpsr & FSMC_FLAG) != (uint16_t)RESET )
??FSMC_GetFlagStatus_0:
        TST      R0,R1
        IT       NE 
        MOVNE    R2,#+1
//  834   {
//  835     bitstatus = SET;
//  836   }
//  837   else
//  838   {
//  839     bitstatus = RESET;
//  840   }
//  841   /* Return the flag status */
//  842   return bitstatus;
        MOV      R0,R2
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  843 }
//  844 
//  845 /**
//  846   * @brief  Clears the FSMC's pending flags.
//  847   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  848   *          This parameter can be one of the following values:
//  849   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  850   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  851   *            @arg FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  852   * @param  FSMC_FLAG: specifies the flag to clear.
//  853   *          This parameter can be any combination of the following values:
//  854   *            @arg FSMC_FLAG_RisingEdge: Rising edge detection Flag.
//  855   *            @arg FSMC_FLAG_Level: Level detection Flag.
//  856   *            @arg FSMC_FLAG_FallingEdge: Falling edge detection Flag.
//  857   * @retval None
//  858   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function FSMC_ClearFlag
        THUMB
//  859 void FSMC_ClearFlag(uint32_t FSMC_Bank, uint32_t FSMC_FLAG)
//  860 {
//  861  /* Check the parameters */
//  862   assert_param(IS_FSMC_GETFLAG_BANK(FSMC_Bank));
//  863   assert_param(IS_FSMC_CLEAR_FLAG(FSMC_FLAG)) ;
//  864     
//  865   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_ClearFlag:
        MVNS     R1,R1
        LDR.N    R2,??DataTable14_7  ;; 0xa0000064
        CMP      R0,#+16
        BNE.N    ??FSMC_ClearFlag_0
//  866   {
//  867     FSMC_Bank2->SR2 &= ~FSMC_FLAG; 
        LDR      R0,[R2, #+0]
        B.N      ?Subroutine3
//  868   }  
//  869   else if(FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ClearFlag_0:
        MOV      R3,#+256
        CMP      R0,R3
        BNE.N    ??FSMC_ClearFlag_1
//  870   {
//  871     FSMC_Bank3->SR3 &= ~FSMC_FLAG;
        LDR      R0,[R2, #+32]
        B.N      ?Subroutine2
//  872   }
//  873   /* FSMC_Bank4_PCCARD*/
//  874   else
//  875   {
//  876     FSMC_Bank4->SR4 &= ~FSMC_FLAG;
??FSMC_ClearFlag_1:
        LDR      R0,[R2, #+64]
        B.N      ?Subroutine1
        CFI EndBlock cfiBlock18
//  877   }
//  878 }
//  879 
//  880 /**
//  881   * @brief  Checks whether the specified FSMC interrupt has occurred or not.
//  882   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  883   *          This parameter can be one of the following values:
//  884   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  885   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  886   *            @arg FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  887   * @param  FSMC_IT: specifies the FSMC interrupt source to check.
//  888   *          This parameter can be one of the following values:
//  889   *            @arg FSMC_IT_RisingEdge: Rising edge detection interrupt. 
//  890   *            @arg FSMC_IT_Level: Level edge detection interrupt.
//  891   *            @arg FSMC_IT_FallingEdge: Falling edge detection interrupt. 
//  892   * @retval The new state of FSMC_IT (SET or RESET).
//  893   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function FSMC_GetITStatus
        THUMB
//  894 ITStatus FSMC_GetITStatus(uint32_t FSMC_Bank, uint32_t FSMC_IT)
//  895 {
//  896   ITStatus bitstatus = RESET;
FSMC_GetITStatus:
        MOVS     R2,#+0
//  897   uint32_t tmpsr = 0x0, itstatus = 0x0, itenable = 0x0; 
//  898   
//  899   /* Check the parameters */
//  900   assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
//  901   assert_param(IS_FSMC_GET_IT(FSMC_IT));
//  902   
//  903   if(FSMC_Bank == FSMC_Bank2_NAND)
        LDR.N    R3,??DataTable14_7  ;; 0xa0000064
        CMP      R0,#+16
        IT       EQ 
        LDREQ    R0,[R3, #+0]
//  904   {
//  905     tmpsr = FSMC_Bank2->SR2;
        BEQ.N    ??FSMC_GetITStatus_0
//  906   }  
//  907   else if(FSMC_Bank == FSMC_Bank3_NAND)
        MOV      R12,#+256
        CMP      R0,R12
        ITE      EQ 
        LDREQ    R0,[R3, #+32]
        LDRNE    R0,[R3, #+64]
//  908   {
//  909     tmpsr = FSMC_Bank3->SR3;
//  910   }
//  911   /* FSMC_Bank4_PCCARD*/
//  912   else
//  913   {
//  914     tmpsr = FSMC_Bank4->SR4;
//  915   } 
//  916   
//  917   itstatus = tmpsr & FSMC_IT;
//  918   
//  919   itenable = tmpsr & (FSMC_IT >> 3);
??FSMC_GetITStatus_0:
        AND      R3,R0,R1, LSR #+3
//  920   if ((itstatus != (uint32_t)RESET)  && (itenable != (uint32_t)RESET))
        TST      R0,R1
        BEQ.N    ??FSMC_GetITStatus_1
        CBZ.N    R3,??FSMC_GetITStatus_1
//  921   {
//  922     bitstatus = SET;
        MOVS     R2,#+1
//  923   }
//  924   else
//  925   {
//  926     bitstatus = RESET;
//  927   }
//  928   return bitstatus; 
??FSMC_GetITStatus_1:
        MOV      R0,R2
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//  929 }
//  930 
//  931 /**
//  932   * @brief  Clears the FSMC's interrupt pending bits.
//  933   * @param  FSMC_Bank: specifies the FSMC Bank to be used
//  934   *          This parameter can be one of the following values:
//  935   *            @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
//  936   *            @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
//  937   *            @arg FSMC_Bank4_PCCARD: FSMC Bank4 PCCARD
//  938   * @param  FSMC_IT: specifies the interrupt pending bit to clear.
//  939   *          This parameter can be any combination of the following values:
//  940   *            @arg FSMC_IT_RisingEdge: Rising edge detection interrupt. 
//  941   *            @arg FSMC_IT_Level: Level edge detection interrupt.
//  942   *            @arg FSMC_IT_FallingEdge: Falling edge detection interrupt.
//  943   * @retval None
//  944   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function FSMC_ClearITPendingBit
        THUMB
//  945 void FSMC_ClearITPendingBit(uint32_t FSMC_Bank, uint32_t FSMC_IT)
//  946 {
//  947   /* Check the parameters */
//  948   assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
//  949   assert_param(IS_FSMC_IT(FSMC_IT));
//  950     
//  951   if(FSMC_Bank == FSMC_Bank2_NAND)
FSMC_ClearITPendingBit:
        LDR.N    R2,??DataTable14_7  ;; 0xa0000064
        CMP      R0,#+16
        BNE.N    ??FSMC_ClearITPendingBit_0
//  952   {
//  953     FSMC_Bank2->SR2 &= ~(FSMC_IT >> 3); 
        LDR      R0,[R2, #+0]
        UBFX     R1,R1,#+3,#+29
        MVN      R3,#-536870912
        EORS     R1,R3,R1
        B.N      ?Subroutine3
//  954   }  
//  955   else if(FSMC_Bank == FSMC_Bank3_NAND)
??FSMC_ClearITPendingBit_0:
        MOV      R3,#+256
        CMP      R0,R3
        BNE.N    ??FSMC_ClearITPendingBit_1
//  956   {
//  957     FSMC_Bank3->SR3 &= ~(FSMC_IT >> 3);
        LDR      R0,[R2, #+32]
        UBFX     R1,R1,#+3,#+29
        MVN      R3,#-536870912
        EORS     R1,R3,R1
        B.N      ?Subroutine2
//  958   }
//  959   /* FSMC_Bank4_PCCARD*/
//  960   else
//  961   {
//  962     FSMC_Bank4->SR4 &= ~(FSMC_IT >> 3);
??FSMC_ClearITPendingBit_1:
        LDR      R0,[R2, #+64]
        UBFX     R1,R1,#+3,#+29
        MVN      R3,#-536870912
        EORS     R1,R3,R1
        B.N      ?Subroutine1
        CFI EndBlock cfiBlock20
//  963   }
//  964 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14:
        DC32     0xa0000104

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_1:
        DC32     0xffffe

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_2:
        DC32     0xa0000060

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_3:
        DC32     0xffffb

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_4:
        DC32     0xfffbf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_5:
        DC32     0xa0000074

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_6:
        DC32     0xa00000a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_7:
        DC32     0xa0000064

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine3:
        ANDS     R0,R1,R0
        STR      R0,[R2, #+0]
        BX       LR
        CFI EndBlock cfiBlock21

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine2:
        ANDS     R0,R1,R0
        STR      R0,[R2, #+32]
        BX       LR
        CFI EndBlock cfiBlock22

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine1:
        ANDS     R0,R1,R0
        STR      R0,[R2, #+64]
        BX       LR               ;; return
        CFI EndBlock cfiBlock23

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  965 
//  966 /**
//  967   * @}
//  968   */ 
//  969 
//  970 /**
//  971   * @}
//  972   */ 
//  973 
//  974 /**
//  975   * @}
//  976   */
//  977 
//  978 /**
//  979   * @}
//  980   */
//  981 
//  982 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 1 080 bytes in section .text
// 
// 1 080 bytes of CODE memory
//
//Errors: none
//Warnings: none
