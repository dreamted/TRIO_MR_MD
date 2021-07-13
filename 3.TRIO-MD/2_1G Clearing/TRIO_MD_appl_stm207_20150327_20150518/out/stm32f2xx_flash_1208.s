///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:02 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_flash_1208.c                          /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_flash_1208.c -D OS_INCLUDED -D        /
//                    APPL_SRC -lA D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ /
//                     -o D:\Work\Project\2012\NL_INBUILD\FW\MU\out\          /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_fla /
//                    sh_1208.s                                               /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_flash_1208

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        PUBLIC FLASH_ClearFlag
        PUBLIC FLASH_DataCacheCmd
        PUBLIC FLASH_DataCacheReset
        PUBLIC FLASH_EraseAllSectors
        PUBLIC FLASH_EraseSector
        PUBLIC FLASH_GetFlagStatus
        PUBLIC FLASH_GetStatus
        PUBLIC FLASH_ITConfig
        PUBLIC FLASH_If_Erase
        PUBLIC FLASH_If_EraseFunc
        PUBLIC FLASH_If_GetWPStatus
        PUBLIC FLASH_If_Init
        PUBLIC FLASH_InstructionCacheCmd
        PUBLIC FLASH_InstructionCacheReset
        PUBLIC FLASH_Lock
        PUBLIC FLASH_OB_BORConfig
        PUBLIC FLASH_OB_GetBOR
        PUBLIC FLASH_OB_GetRDP
        PUBLIC FLASH_OB_GetUser
        PUBLIC FLASH_OB_GetWRP
        PUBLIC FLASH_OB_Launch
        PUBLIC FLASH_OB_Lock
        PUBLIC FLASH_OB_RDPConfig
        PUBLIC FLASH_OB_Unlock
        PUBLIC FLASH_OB_UserConfig
        PUBLIC FLASH_OB_WRPConfig
        PUBLIC FLASH_PrefetchBufferCmd
        PUBLIC FLASH_ProgramByte
        PUBLIC FLASH_ProgramDoubleWord
        PUBLIC FLASH_ProgramHalfWord
        PUBLIC FLASH_ProgramWord
        PUBLIC FLASH_SetLatency
        PUBLIC FLASH_Unlock
        PUBLIC FLASH_WPDisable
        PUBLIC FLASH_WaitForLastOperation
        PUBLIC GetSector
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_flash_1208.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_flash.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7   * @brief   This file provides firmware functions to manage the following 
//    8   *          functionalities of the FLASH peripheral:
//    9   *            - FLASH Interface configuration
//   10   *            - FLASH Memory Programming
//   11   *            - Option Bytes Programming
//   12   *            - Interrupts and flags management
//   13   *  
//   14   *  @verbatim
//   15   *  
//   16   *          ===================================================================
//   17   *                                 How to use this driver
//   18   *          ===================================================================
//   19   *                           
//   20   *          This driver provides functions to configure and program the FLASH 
//   21   *          memory of all STM32F2xx devices.
//   22   *          These functions are split in 4 groups:
//   23   * 
//   24   *           1. FLASH Interface configuration functions: this group includes the
//   25   *              management of the following features:
//   26   *                    - Set the latency
//   27   *                    - Enable/Disable the prefetch buffer
//   28   *                    - Enable/Disable the Instruction cache and the Data cache
//   29   *                    - Reset the Instruction cache and the Data cache
//   30   *  
//   31   *           2. FLASH Memory Programming functions: this group includes all needed
//   32   *              functions to erase and program the main memory:
//   33   *                    - Lock and Unlock the FLASH interface
//   34   *                    - Erase function: Erase sector, erase all sectors
//   35   *                    - Program functions: byte, half word, word and double word
//   36   *  
//   37   *           3. Option Bytes Programming functions: this group includes all needed
//   38   *              functions to manage the Option Bytes:
//   39   *                    - Set/Reset the write protection
//   40   *                    - Set the Read protection Level
//   41   *                    - Set the BOR level
//   42   *                    - Program the user Option Bytes
//   43   *                    - Launch the Option Bytes loader
//   44   *  
//   45   *           4. Interrupts and flags management functions: this group 
//   46   *              includes all needed functions to:
//   47   *                    - Enable/Disable the FLASH interrupt sources
//   48   *                    - Get flags status
//   49   *                    - Clear flags
//   50   *                    - Get FLASH operation status
//   51   *                    - Wait for last FLASH operation
//   52   * 
//   53   *  @endverbatim
//   54   *                      
//   55   ******************************************************************************
//   56   * @attention
//   57   *
//   58   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   59   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   60   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   61   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   62   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   63   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   64   *
//   65   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   66   ******************************************************************************
//   67   */
//   68 
//   69 /* Includes ------------------------------------------------------------------*/
//   70 #include "stm32f2xx_flash_1208.h"
//   71 
//   72 /** @addtogroup STM32F2xx_StdPeriph_Driver
//   73   * @{
//   74   */
//   75 
//   76 /** @defgroup FLASH 
//   77   * @brief FLASH driver modules
//   78   * @{
//   79   */ 
//   80 
//   81 /* Private typedef -----------------------------------------------------------*/
//   82 /* Private define ------------------------------------------------------------*/ 
//   83 #define SECTOR_MASK               ((uint32_t)0xFFFFFF07)
//   84 
//   85 /* Private macro -------------------------------------------------------------*/
//   86 /* Private variables ---------------------------------------------------------*/
//   87 /* Private function prototypes -----------------------------------------------*/
//   88 /* Private functions ---------------------------------------------------------*/
//   89 
//   90 /** @defgroup FLASH_Private_Functions
//   91   * @{
//   92   */ 
//   93 
//   94 /** @defgroup FLASH_Group1 FLASH Interface configuration functions
//   95   *  @brief   FLASH Interface configuration functions 
//   96  *
//   97 
//   98 @verbatim   
//   99  ===============================================================================
//  100                        FLASH Interface configuration functions
//  101  ===============================================================================
//  102 
//  103    This group includes the following functions:
//  104     - void FLASH_SetLatency(uint32_t FLASH_Latency)
//  105        To correctly read data from FLASH memory, the number of wait states (LATENCY) 
//  106        must be correctly programmed according to the frequency of the CPU clock 
//  107       (HCLK) and the supply voltage of the device.
//  108  +-------------------------------------------------------------------------------------+     
//  109  | Latency       |                HCLK clock frequency (MHz)                           |
//  110  |               |---------------------------------------------------------------------|     
//  111  |               | voltage range  | voltage range  | voltage range   | voltage range   |
//  112  |               | 2.7 V - 3.6 V  | 2.4 V - 2.7 V  | 2.1 V - 2.4 V   | 1.8 V - 2.1 V   |
//  113  |---------------|----------------|----------------|-----------------|-----------------|              
//  114  |0WS(1CPU cycle)|0 < HCLK <= 30  |0 < HCLK <= 24  |0 < HCLK <= 18   |0 < HCLK <= 16   |
//  115  |---------------|----------------|----------------|-----------------|-----------------|   
//  116  |1WS(2CPU cycle)|30 < HCLK <= 60 |24 < HCLK <= 48 |18 < HCLK <= 36  |16 < HCLK <= 32  | 
//  117  |---------------|----------------|----------------|-----------------|-----------------|   
//  118  |2WS(3CPU cycle)|60 < HCLK <= 90 |48 < HCLK <= 72 |36 < HCLK <= 54  |32 < HCLK <= 48  |
//  119  |---------------|----------------|----------------|-----------------|-----------------| 
//  120  |3WS(4CPU cycle)|90 < HCLK <= 120|72 < HCLK <= 96 |54 < HCLK <= 72  |48 < HCLK <= 64  |
//  121  |---------------|----------------|----------------|-----------------|-----------------| 
//  122  |4WS(5CPU cycle)|      NA        |96 < HCLK <= 120|72 < HCLK <= 90  |64 < HCLK <= 80  |
//  123  |---------------|----------------|----------------|-----------------|-----------------| 
//  124  |5WS(6CPU cycle)|      NA        |      NA        |90 < HCLK <= 108 |80 < HCLK <= 96  | 
//  125  |---------------|----------------|----------------|-----------------|-----------------| 
//  126  |6WS(7CPU cycle)|      NA        |      NA        |108 < HCLK <= 120|96 < HCLK <= 112 | 
//  127  |---------------|----------------|----------------|-----------------|-----------------| 
//  128  |7WS(8CPU cycle)|      NA        |      NA        |     NA          |112 < HCLK <= 120| 
//  129  |***************|****************|****************|*****************|*****************|*****************************+
//  130  |               | voltage range  | voltage range  | voltage range   | voltage range   | voltage range 2.7 V - 3.6 V |
//  131  |               | 2.7 V - 3.6 V  | 2.4 V - 2.7 V  | 2.1 V - 2.4 V   | 1.8 V - 2.1 V   | with External Vpp = 9V      |
//  132  |---------------|----------------|----------------|-----------------|-----------------|-----------------------------| 
//  133  |Max Parallelism|      x32       |               x16                |       x8        |          x64                |              
//  134  |---------------|----------------|----------------|-----------------|-----------------|-----------------------------|   
//  135  |PSIZE[1:0]     |      10        |               01                 |       00        |           11                |
//  136  +-------------------------------------------------------------------------------------------------------------------+  
//  137     
//  138     - void FLASH_PrefetchBufferCmd(FunctionalState NewState)
//  139     - void FLASH_InstructionCacheCmd(FunctionalState NewState)
//  140     - void FLASH_DataCacheCmd(FunctionalState NewState)
//  141     - void FLASH_InstructionCacheReset(void)
//  142     - void FLASH_DataCacheReset(void)
//  143    
//  144    The unlock sequence is not needed for these functions.
//  145  
//  146 @endverbatim
//  147   * @{
//  148   */
//  149 
//  150 
//  151 /**
//  152   * @brief  Unlocks Flash for write access
//  153   * @param  None
//  154   * @retval None
//  155   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function FLASH_If_Init
        THUMB
//  156 void FLASH_If_Init(void)
//  157 {
FLASH_If_Init:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  158 	FLASH_Unlock(); 
        BL       FLASH_Unlock
//  159 	/* Clear pending flags (if any) */  
//  160 	FLASH_ClearFlag(FLASH_FLAG_EOP | FLASH_FLAG_OPERR | FLASH_FLAG_WRPERR | 
//  161 	              FLASH_FLAG_PGAERR | FLASH_FLAG_PGPERR|FLASH_FLAG_PGSERR);
        LDR.W    R0,??DataTable32  ;; 0x40023c0c
        MOVS     R1,#+243
        STR      R1,[R0, #+0]
//  162 
//  163 }
        POP      {R0,PC}          ;; return
        CFI EndBlock cfiBlock0
//  164 
//  165 
//  166 
//  167 /**
//  168   * @brief  Sets the code latency value.
//  169   * @param  FLASH_Latency: specifies the FLASH Latency value.
//  170   *          This parameter can be one of the following values:
//  171   *            @arg FLASH_Latency_0: FLASH Zero Latency cycle
//  172   *            @arg FLASH_Latency_1: FLASH One Latency cycle
//  173   *            @arg FLASH_Latency_2: FLASH Two Latency cycles
//  174   *            @arg FLASH_Latency_3: FLASH Three Latency cycles
//  175   *            @arg FLASH_Latency_4: FLASH Four Latency cycles 
//  176   *            @arg FLASH_Latency_5: FLASH Five Latency cycles 
//  177   *            @arg FLASH_Latency_6: FLASH Six Latency cycles
//  178   *            @arg FLASH_Latency_7: FLASH Seven Latency cycles      
//  179   * @retval None
//  180   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function FLASH_SetLatency
        THUMB
//  181 void FLASH_SetLatency(uint32_t FLASH_Latency)
//  182 {
//  183 	/* Check the parameters */
//  184 	assert_param(IS_FLASH_LATENCY(FLASH_Latency));
//  185 
//  186 	/* Perform Byte access to FLASH_ACR[8:0] to set the Latency value */
//  187 	*(__IO uint8_t *)ACR_BYTE0_ADDRESS = (uint8_t)FLASH_Latency;
FLASH_SetLatency:
        LDR.W    R1,??DataTable32_1  ;; 0x40023c00
        STRB     R0,[R1, #+0]
//  188 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  189 
//  190 /**
//  191   * @brief  Enables or disables the Prefetch Buffer.
//  192   * @param  NewState: new state of the Prefetch Buffer.
//  193   *          This parameter  can be: ENABLE or DISABLE.
//  194   * @retval None
//  195   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function FLASH_PrefetchBufferCmd
        THUMB
//  196 void FLASH_PrefetchBufferCmd(FunctionalState NewState)
//  197 {
//  198 	/* Check the parameters */
//  199 	assert_param(IS_FUNCTIONAL_STATE(NewState));
//  200 
//  201 	/* Enable or disable the Prefetch Buffer */
//  202 	if(NewState != DISABLE)
FLASH_PrefetchBufferCmd:
        LDR.W    R1,??DataTable32_1  ;; 0x40023c00
        CMP      R0,#+0
        LDR      R0,[R1, #+0]
        ITTE     NE 
        MOVNE    R2,#+256
        ORRNE    R0,R2,R0
        BICEQ    R0,R0,#0x100
//  203 	{
//  204 		FLASH->ACR |= FLASH_ACR_PRFTEN;
//  205 	}
//  206 	else
//  207 	{
//  208 		FLASH->ACR &= (~FLASH_ACR_PRFTEN);
        STR      R0,[R1, #+0]
//  209 	}
//  210 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  211 
//  212 /**
//  213   * @brief  Enables or disables the Instruction Cache feature.
//  214   * @param  NewState: new state of the Instruction Cache.
//  215   *          This parameter  can be: ENABLE or DISABLE.
//  216   * @retval None
//  217   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function FLASH_InstructionCacheCmd
        THUMB
//  218 void FLASH_InstructionCacheCmd(FunctionalState NewState)
//  219 {
//  220   /* Check the parameters */
//  221   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  222   
//  223   if(NewState != DISABLE)
FLASH_InstructionCacheCmd:
        LDR.W    R1,??DataTable32_1  ;; 0x40023c00
        CMP      R0,#+0
        LDR      R0,[R1, #+0]
        ITTE     NE 
        MOVNE    R2,#+512
        ORRNE    R0,R2,R0
        BICEQ    R0,R0,#0x200
//  224   {
//  225     FLASH->ACR |= FLASH_ACR_ICEN;
//  226   }
//  227   else
//  228   {
//  229     FLASH->ACR &= (~FLASH_ACR_ICEN);
        STR      R0,[R1, #+0]
//  230   }
//  231 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  232 
//  233 /**
//  234   * @brief  Enables or disables the Data Cache feature.
//  235   * @param  NewState: new state of the Data Cache.
//  236   *          This parameter  can be: ENABLE or DISABLE.
//  237   * @retval None
//  238   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function FLASH_DataCacheCmd
        THUMB
//  239 void FLASH_DataCacheCmd(FunctionalState NewState)
//  240 {
//  241 	/* Check the parameters */
//  242 	assert_param(IS_FUNCTIONAL_STATE(NewState));
//  243   
//  244 	if(NewState != DISABLE)
FLASH_DataCacheCmd:
        LDR.W    R1,??DataTable32_1  ;; 0x40023c00
        CMP      R0,#+0
        LDR      R0,[R1, #+0]
        ITE      NE 
        ORRNE    R0,R0,#0x400
        BICEQ    R0,R0,#0x400
//  245 	{
//  246 	FLASH->ACR |= FLASH_ACR_DCEN;
//  247 	}
//  248 	else
//  249 	{
//  250 	FLASH->ACR &= (~FLASH_ACR_DCEN);
        STR      R0,[R1, #+0]
//  251 	}
//  252 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  253 
//  254 /**
//  255   * @brief  Resets the Instruction Cache.
//  256   * @note   This function must be used only when the Instruction Cache is disabled.  
//  257   * @param  None
//  258   * @retval None
//  259   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function FLASH_InstructionCacheReset
        THUMB
//  260 void FLASH_InstructionCacheReset(void)
//  261 {
//  262 	FLASH->ACR |= FLASH_ACR_ICRST;
FLASH_InstructionCacheReset:
        LDR.W    R0,??DataTable32_1  ;; 0x40023c00
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x800
        STR      R1,[R0, #+0]
//  263 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  264 
//  265 /**
//  266   * @brief  Resets the Data Cache.
//  267   * @note   This function must be used only when the Data Cache is disabled.  
//  268   * @param  None
//  269   * @retval None
//  270   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function FLASH_DataCacheReset
        THUMB
//  271 void FLASH_DataCacheReset(void)
//  272 {
//  273 	FLASH->ACR |= FLASH_ACR_DCRST;
FLASH_DataCacheReset:
        LDR.W    R0,??DataTable32_1  ;; 0x40023c00
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1000
        STR      R1,[R0, #+0]
//  274 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  275 
//  276 /**
//  277   * @}
//  278   */
//  279 
//  280 /** @defgroup FLASH_Group2 FLASH Memory Programming functions
//  281  *  @brief   FLASH Memory Programming functions
//  282  *
//  283 @verbatim   
//  284  ===============================================================================
//  285                       FLASH Memory Programming functions
//  286  ===============================================================================   
//  287 
//  288    This group includes the following functions:
//  289     - void FLASH_Unlock(void)
//  290     - void FLASH_Lock(void)
//  291     - FLASH_Status FLASH_EraseSector(uint32_t FLASH_Sector, uint8_t VoltageRange)
//  292     - FLASH_Status FLASH_EraseAllSectors(uint8_t VoltageRange)
//  293     - FLASH_Status FLASH_ProgramDoubleWord(uint32_t Address, uint64_t Data)
//  294     - FLASH_Status FLASH_ProgramWord(uint32_t Address, uint32_t Data)
//  295     - FLASH_Status FLASH_ProgramHalfWord(uint32_t Address, uint16_t Data)
//  296     - FLASH_Status FLASH_ProgramByte(uint32_t Address, uint8_t Data)
//  297    
//  298    Any operation of erase or program should follow these steps:
//  299    1. Call the FLASH_Unlock() function to enable the FLASH control register access
//  300 
//  301    2. Call the desired function to erase sector(s) or program data
//  302 
//  303    3. Call the FLASH_Lock() function to disable the FLASH control register access
//  304       (recommended to protect the FLASH memory against possible unwanted operation)
//  305     
//  306 @endverbatim
//  307   * @{
//  308   */
//  309 
//  310 /**
//  311   * @brief  Unlocks the FLASH control register access
//  312   * @param  None
//  313   * @retval None
//  314   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function FLASH_Unlock
        THUMB
//  315 void FLASH_Unlock(void)
//  316 {
//  317   if((FLASH->CR & FLASH_CR_LOCK) != RESET)
FLASH_Unlock:
        LDR.W    R0,??DataTable32_2  ;; 0x40023c04
        LDR      R1,[R0, #+12]
        CMP      R1,#+0
        BPL.N    ??FLASH_Unlock_0
//  318   {
//  319     /* Authorize the FLASH Registers access */
//  320     FLASH->KEYR = FLASH_KEY1;
        LDR.W    R1,??DataTable32_3  ;; 0x45670123
        STR      R1,[R0, #+0]
//  321     FLASH->KEYR = FLASH_KEY2;
        LDR.W    R1,??DataTable32_4  ;; 0xcdef89ab
        STR      R1,[R0, #+0]
//  322   }  
//  323 }
??FLASH_Unlock_0:
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  324 
//  325 /**
//  326   * @brief  Locks the FLASH control register access
//  327   * @param  None
//  328   * @retval None
//  329   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function FLASH_Lock
        THUMB
//  330 void FLASH_Lock(void)
//  331 {
//  332 	/* Set the LOCK Bit to lock the FLASH Registers access */
//  333 	FLASH->CR |= FLASH_CR_LOCK;
FLASH_Lock:
        LDR.W    R0,??DataTable32_5  ;; 0x40023c10
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80000000
        STR      R1,[R0, #+0]
//  334 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  335 
//  336 
//  337 /**
//  338   * @brief  This function does an erase of all user flash area
//  339   * @param  StartSector: start of user flash area
//  340   * @retval 0: user flash area successfully erased
//  341   *         1: error occurred
//  342   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function FLASH_If_Erase
        THUMB
//  343 uint32_t FLASH_If_Erase(uint32_t Addr)
//  344 {
FLASH_If_Erase:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  345 	/* Get the sector where start the user flash area */
//  346     if (FLASH_EraseSector(GetSector(Addr)) != FLASH_COMPLETE)
        BL       GetSector
        BL       FLASH_EraseSector
        CMP      R0,#+9
        BEQ.N    ??FLASH_If_Erase_0
//  347     {
//  348 		/* Error occurred while page erase */
//  349  		return (FALSE);
        MOVS     R0,#+0
        POP      {R1,PC}
//  350     }
//  351 	return (TRUE);
??FLASH_If_Erase_0:
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
        CFI EndBlock cfiBlock9
//  352 }
//  353 
//  354 /**
//  355   * @brief  This function does an erase of all user flash area including unlock
//  356   			flash
//  357   * @param  StartSector: start of user flash area
//  358   * @retval 0: user flash area successfully erased
//  359   *         1: error occurred
//  360   */
//  361 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function FLASH_If_EraseFunc
        THUMB
//  362 uint32_t FLASH_If_EraseFunc(uint32_t Addr)
//  363 {
FLASH_If_EraseFunc:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOV      R4,R0
//  364 	uint32_t	rVal = FLASH_COMPLETE;
//  365 
//  366 	FLASH_If_Init();
        BL       FLASH_Unlock
        LDR.W    R0,??DataTable32  ;; 0x40023c0c
        MOVS     R1,#+243
        STR      R1,[R0, #+0]
//  367 
//  368 	if(!FLASH_If_GetWPStatus(Addr))
        MOV      R0,R4
        BL       FLASH_If_GetWPStatus
        CBNZ.N   R0,??FLASH_If_EraseFunc_0
//  369 	{
//  370 		//SerPtr->printf("*FLASH Write Protected !!\n");
//  371 
//  372 		if(FLASH_WPDisable(Addr) != 1)
        MOV      R0,R4
        BL       FLASH_WPDisable
        CMP      R0,#+1
        BEQ.N    ??FLASH_If_EraseFunc_0
//  373 		{
//  374 			//SerPtr->printf("*Error: Flash write unprotection failed\n");
//  375 			rVal = FLASH_ERROR_WRP;
//  376 			return rVal;
        MOVS     R0,#+5
        POP      {R4,PC}
//  377 		}
//  378 	}
//  379 
//  380 	if(FLASH_If_Erase(Addr)==FALSE)
??FLASH_If_EraseFunc_0:
        MOV      R0,R4
        BL       FLASH_If_Erase
        CMP      R0,#+0
        BNE.N    ??FLASH_If_EraseFunc_1
//  381 	{
//  382 		//SerPtr->printf("*FLASH BACKUP AREA ERROR \n");
//  383 		rVal = FLASH_ERROR_ERS;
//  384 		return rVal;
        MOVS     R0,#+8
        POP      {R4,PC}
//  385 	}
//  386 
//  387 	return rVal;
??FLASH_If_EraseFunc_1:
        MOVS     R0,#+9
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock10
//  388 }
//  389 
//  390 /**
//  391   * @brief  Erases a specified FLASH Sector.
//  392   *   
//  393   * @param  FLASH_Sector: The Sector number to be erased.
//  394   *          This parameter can be a value between FLASH_Sector_0 and FLASH_Sector_11
//  395   *    
//  396   * @param  VoltageRange: The device voltage range which defines the erase parallelism.  
//  397   *          This parameter can be one of the following values:
//  398   *            @arg VoltageRange_1: when the device voltage range is 1.8V to 2.1V, 
//  399   *                                  the operation will be done by byte (8-bit) 
//  400   *            @arg VoltageRange_2: when the device voltage range is 2.1V to 2.7V,
//  401   *                                  the operation will be done by half word (16-bit)
//  402   *            @arg VoltageRange_3: when the device voltage range is 2.7V to 3.6V,
//  403   *                                  the operation will be done by word (32-bit)
//  404   *            @arg VoltageRange_4: when the device voltage range is 2.7V to 3.6V + External Vpp, 
//  405   *                                  the operation will be done by double word (64-bit)
//  406   *       
//  407   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
//  408   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
//  409   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function FLASH_EraseSector
        THUMB
//  410 FLASH_Status FLASH_EraseSector(uint32_t FLASH_Sector)
//  411 {
FLASH_EraseSector:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R4,R0
//  412 	FLASH_Status status = FLASH_COMPLETE;
//  413 
//  414 	/* Wait for last operation to be completed */
//  415 	status = FLASH_WaitForLastOperation();
//  416   
//  417 	if(status == FLASH_COMPLETE)
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+9
        BNE.N    ??FLASH_EraseSector_0
//  418 	{ 
//  419 		/* if the previous operation is completed, proceed to erase the sector */
//  420 		FLASH->CR &= CR_PSIZE_MASK;
        LDR.W    R5,??DataTable32_5  ;; 0x40023c10
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0x300
        STR      R0,[R5, #+0]
//  421 		FLASH->CR |= FLASH_PSIZE_WORD;
        LDR      R0,[R5, #+0]
        MOV      R1,#+512
        ORRS     R0,R1,R0
        STR      R0,[R5, #+0]
//  422 		//FLASH->CR &= SECTOR_MASK;
//  423 		FLASH->__B.CR.SER = SET;
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x2
        STR      R0,[R5, #+0]
//  424 		FLASH->__B.CR.SNB = FLASH_Sector;
        LDR      R0,[R5, #+0]
        BFI      R0,R4,#+3,#+4
        STR      R0,[R5, #+0]
//  425 		//FLASH->CR |= FLASH_CR_SER | FLASH_Sector;
//  426 		FLASH->CR |= FLASH_CR_STRT;
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x10000
        STR      R0,[R5, #+0]
//  427 
//  428 		/* Wait for last operation to be completed */
//  429 		status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  430 
//  431 		/* if the erase operation is completed, disable the SER Bit */
//  432 		FLASH->CR &= (~FLASH_CR_SER);
        LDR      R1,[R5, #+0]
        BIC      R1,R1,#0x2
        STR      R1,[R5, #+0]
//  433 		FLASH->CR &= SECTOR_MASK; 
        LDR      R1,[R5, #+0]
        BIC      R1,R1,#0xF8
        STR      R1,[R5, #+0]
        POP      {R1,R4,R5,PC}
//  434 	}
//  435 	else status = FLASH_NULL;
??FLASH_EraseSector_0:
        MOVS     R0,#+0
//  436 	/* Return the Erase Status */
//  437 	return status;
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock11
//  438 }
//  439 
//  440 /**
//  441   * @brief  Erases all FLASH Sectors.
//  442   *    
//  443   * @param  VoltageRange: The device voltage range which defines the erase parallelism.  
//  444   *          This parameter can be one of the following values:
//  445   *            @arg VoltageRange_1: when the device voltage range is 1.8V to 2.1V, 
//  446   *                                  the operation will be done by byte (8-bit) 
//  447   *            @arg VoltageRange_2: when the device voltage range is 2.1V to 2.7V,
//  448   *                                  the operation will be done by half word (16-bit)
//  449   *            @arg VoltageRange_3: when the device voltage range is 2.7V to 3.6V,
//  450   *                                  the operation will be done by word (32-bit)
//  451   *            @arg VoltageRange_4: when the device voltage range is 2.7V to 3.6V + External Vpp, 
//  452   *                                  the operation will be done by double word (64-bit)
//  453   *       
//  454   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
//  455   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
//  456   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function FLASH_EraseAllSectors
        THUMB
//  457 FLASH_Status FLASH_EraseAllSectors(uint8_t VoltageRange)
//  458 {
FLASH_EraseAllSectors:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R4,R0
//  459   uint32_t tmp_psize = 0x0;
        MOVS     R5,#+0
//  460   FLASH_Status status = FLASH_COMPLETE;
//  461   
//  462   /* Wait for last operation to be completed */
//  463   status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  464   assert_param(IS_VOLTAGERANGE(VoltageRange));
//  465   
//  466   if(VoltageRange == VoltageRange_1)
        CBZ.N    R4,??FLASH_EraseAllSectors_0
//  467   {
//  468      tmp_psize = FLASH_PSIZE_BYTE;
//  469   }
//  470   else if(VoltageRange == VoltageRange_2)
        CMP      R4,#+1
        IT       EQ 
        MOVEQ    R5,#+256
//  471   {
//  472     tmp_psize = FLASH_PSIZE_HALF_WORD;
        BEQ.N    ??FLASH_EraseAllSectors_0
//  473   }
//  474   else if(VoltageRange == VoltageRange_3)
        CMP      R4,#+2
        ITE      EQ 
        MOVEQ    R5,#+512
        MOVNE    R5,#+768
//  475   {
//  476     tmp_psize = FLASH_PSIZE_WORD;
//  477   }
//  478   else
//  479   {
//  480     tmp_psize = FLASH_PSIZE_DOUBLE_WORD;
//  481   }  
//  482   if(status == FLASH_COMPLETE)
??FLASH_EraseAllSectors_0:
        CMP      R0,#+9
        BNE.N    ??FLASH_EraseAllSectors_1
//  483   {
//  484     /* if the previous operation is completed, proceed to erase all sectors */
//  485      FLASH->CR &= CR_PSIZE_MASK;
        LDR.N    R4,??DataTable32_5  ;; 0x40023c10
        LDR      R0,[R4, #+0]
        BIC      R0,R0,#0x300
        STR      R0,[R4, #+0]
//  486      FLASH->CR |= tmp_psize;
        LDR      R0,[R4, #+0]
        ORRS     R0,R5,R0
        STR      R0,[R4, #+0]
//  487      FLASH->CR |= FLASH_CR_MER;
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x4
        STR      R0,[R4, #+0]
//  488      FLASH->CR |= FLASH_CR_STRT;
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x10000
        STR      R0,[R4, #+0]
//  489     
//  490     /* Wait for last operation to be completed */
//  491     status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  492 
//  493     /* if the erase operation is completed, disable the MER Bit */
//  494     FLASH->CR &= (~FLASH_CR_MER);
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x4
        STR      R1,[R4, #+0]
//  495 
//  496   }   
//  497   /* Return the Erase Status */
//  498   return status;
??FLASH_EraseAllSectors_1:
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock12
//  499 }
//  500 
//  501 /**
//  502   * @brief  Programs a double word (64-bit) at a specified address.
//  503   * @note   This function must be used when the device voltage range is from
//  504   *         2.7V to 3.6V and an External Vpp is present.           
//  505   * @param  Address: specifies the address to be programmed.
//  506   * @param  Data: specifies the data to be programmed.
//  507   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
//  508   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
//  509   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function FLASH_ProgramDoubleWord
        THUMB
//  510 FLASH_Status FLASH_ProgramDoubleWord(uint32_t Address, uint64_t Data)
//  511 {
FLASH_ProgramDoubleWord:
        PUSH     {R3-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+24
        MOV      R6,R0
        MOV      R4,R2
        MOV      R5,R3
//  512   FLASH_Status status = FLASH_COMPLETE;
//  513 
//  514   /* Check the parameters */
//  515   assert_param(IS_FLASH_ADDRESS(Address));
//  516 
//  517   /* Wait for last operation to be completed */
//  518   status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  519   
//  520   if(status == FLASH_COMPLETE)
        CMP      R0,#+9
        BNE.N    ??FLASH_ProgramDoubleWord_0
//  521   {
//  522     /* if the previous operation is completed, proceed to program the new data */
//  523     FLASH->CR &= CR_PSIZE_MASK;
        LDR.N    R7,??DataTable32_5  ;; 0x40023c10
        LDR      R0,[R7, #+0]
        BIC      R0,R0,#0x300
        STR      R0,[R7, #+0]
//  524     FLASH->CR |= FLASH_PSIZE_DOUBLE_WORD;
        LDR      R0,[R7, #+0]
        MOV      R1,#+768
        ORRS     R0,R1,R0
        STR      R0,[R7, #+0]
//  525     FLASH->CR |= FLASH_CR_PG;
        LDR      R0,[R7, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R7, #+0]
//  526   
//  527     *(__IO uint64_t*)Address = Data;
        STRD     R4,R5,[R6, #+0]
//  528         
//  529     /* Wait for last operation to be completed */
//  530     status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  531 
//  532     /* if the program operation is completed, disable the PG Bit */
//  533     FLASH->CR &= (~FLASH_CR_PG);
        LDR      R1,[R7, #+0]
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R7, #+0]
//  534   } 
//  535   /* Return the Program Status */
//  536   return status;
??FLASH_ProgramDoubleWord_0:
        POP      {R1,R4-R7,PC}    ;; return
        CFI EndBlock cfiBlock13
//  537 }
//  538 
//  539 /**
//  540   * @brief  Programs a word (32-bit) at a specified address.
//  541   * @param  Address: specifies the address to be programmed.
//  542   *         This parameter can be any address in Program memory zone or in OTP zone.  
//  543   * @note   This function must be used when the device voltage range is from 2.7V to 3.6V. 
//  544   * @param  Data: specifies the data to be programmed.
//  545   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
//  546   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
//  547   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function FLASH_ProgramWord
        THUMB
//  548 FLASH_Status FLASH_ProgramWord(uint32_t Address, uint32_t Data)
//  549 {
FLASH_ProgramWord:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOV      R4,R0
        MOV      R5,R1
//  550 	FLASH_Status status = FLASH_COMPLETE;
//  551 
//  552 	/* Check the parameters */
//  553 	assert_param(IS_FLASH_ADDRESS(Address));
//  554 
//  555 	/* Wait for last operation to be completed */
//  556 	status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  557 
//  558 	if(status == FLASH_COMPLETE)
        CMP      R0,#+9
        BNE.N    ??FLASH_ProgramWord_0
//  559 	{
//  560 		/* if the previous operation is completed, proceed to program the new data */
//  561 		FLASH->CR &= CR_PSIZE_MASK;
        LDR.N    R6,??DataTable32_5  ;; 0x40023c10
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x300
        STR      R0,[R6, #+0]
//  562 		FLASH->CR |= FLASH_PSIZE_WORD;
        LDR      R0,[R6, #+0]
        MOV      R1,#+512
        ORRS     R0,R1,R0
        STR      R0,[R6, #+0]
//  563 		FLASH->CR |= FLASH_CR_PG;
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R6, #+0]
//  564 
//  565 		*(__IO uint32_t*)Address = Data;
        STR      R5,[R4, #+0]
//  566 	    
//  567 		/* Wait for last operation to be completed */
//  568 		status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  569 
//  570 		/* if the program operation is completed, disable the PG Bit */
//  571 		FLASH->CR &= (~FLASH_CR_PG);
        LDR      R1,[R6, #+0]
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R6, #+0]
//  572 	} 
//  573 	/* Return the Program Status */
//  574 	return status;
??FLASH_ProgramWord_0:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock14
//  575 }
//  576 
//  577 /**
//  578   * @brief  Programs a half word (16-bit) at a specified address. 
//  579   * @note   This function must be used when the device voltage range is from 2.1V to 3.6V.               
//  580   * @param  Address: specifies the address to be programmed.
//  581   *         This parameter can be any address in Program memory zone or in OTP zone.  
//  582   * @param  Data: specifies the data to be programmed.
//  583   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
//  584   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
//  585   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function FLASH_ProgramHalfWord
        THUMB
//  586 FLASH_Status FLASH_ProgramHalfWord(uint32_t Address, uint16_t Data)
//  587 {
FLASH_ProgramHalfWord:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOV      R4,R0
        MOV      R5,R1
//  588 	FLASH_Status status = FLASH_COMPLETE;
//  589 
//  590 	/* Check the parameters */
//  591 	assert_param(IS_FLASH_ADDRESS(Address));
//  592 
//  593 	/* Wait for last operation to be completed */
//  594 	status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  595 
//  596 	if(status == FLASH_COMPLETE)
        CMP      R0,#+9
        BNE.N    ??FLASH_ProgramHalfWord_0
//  597 	{
//  598 		/* if the previous operation is completed, proceed to program the new data */
//  599 		FLASH->CR &= CR_PSIZE_MASK;
        LDR.N    R6,??DataTable32_5  ;; 0x40023c10
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x300
        STR      R0,[R6, #+0]
//  600 		FLASH->CR |= FLASH_PSIZE_HALF_WORD;
        LDR      R0,[R6, #+0]
        MOV      R1,#+256
        ORRS     R0,R1,R0
        STR      R0,[R6, #+0]
//  601 		FLASH->CR |= FLASH_CR_PG;
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R6, #+0]
//  602 
//  603 		*(__IO uint16_t*)Address = Data;
        STRH     R5,[R4, #+0]
//  604 		    
//  605 		/* Wait for last operation to be completed */
//  606 		status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  607 
//  608 		/* if the program operation is completed, disable the PG Bit */
//  609 		FLASH->CR &= (~FLASH_CR_PG);
        LDR      R1,[R6, #+0]
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R6, #+0]
//  610 	} 
//  611 	/* Return the Program Status */
//  612 	return status;
??FLASH_ProgramHalfWord_0:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock15
//  613 }
//  614 
//  615 /**
//  616   * @brief  Programs a byte (8-bit) at a specified address.
//  617   * @note   This function can be used within all the device supply voltage ranges.               
//  618   * @param  Address: specifies the address to be programmed.
//  619   *         This parameter can be any address in Program memory zone or in OTP zone.  
//  620   * @param  Data: specifies the data to be programmed.
//  621   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
//  622   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
//  623   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function FLASH_ProgramByte
        THUMB
//  624 FLASH_Status FLASH_ProgramByte(uint32_t Address, uint8_t Data)
//  625 {
FLASH_ProgramByte:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOV      R5,R0
        MOV      R6,R1
//  626   FLASH_Status status = FLASH_COMPLETE;
//  627 
//  628   /* Check the parameters */
//  629   assert_param(IS_FLASH_ADDRESS(Address));
//  630 
//  631   /* Wait for last operation to be completed */
//  632   status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  633   
//  634   if(status == FLASH_COMPLETE)
        CMP      R0,#+9
        BNE.N    ??FLASH_ProgramByte_0
//  635   {
//  636     /* if the previous operation is completed, proceed to program the new data */
//  637     FLASH->CR &= CR_PSIZE_MASK;
        LDR.N    R4,??DataTable32_5  ;; 0x40023c10
        LDR      R0,[R4, #+0]
        BIC      R0,R0,#0x300
        STR      R0,[R4, #+0]
//  638     FLASH->CR |= FLASH_PSIZE_BYTE;
        LDR      R0,[R4, #+0]
        STR      R0,[R4, #+0]
//  639     FLASH->CR |= FLASH_CR_PG;
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R4, #+0]
//  640   
//  641     *(__IO uint8_t*)Address = Data;
        STRB     R6,[R5, #+0]
//  642         
//  643     /* Wait for last operation to be completed */
//  644     status = FLASH_WaitForLastOperation();
        BL       FLASH_WaitForLastOperation
//  645 
//  646     /* if the program operation is completed, disable the PG Bit */
//  647     FLASH->CR &= (~FLASH_CR_PG);
        LDR      R1,[R4, #+0]
        LSRS     R1,R1,#+1
        LSLS     R1,R1,#+1
        STR      R1,[R4, #+0]
//  648   } 
//  649 
//  650   /* Return the Program Status */
//  651   return status;
??FLASH_ProgramByte_0:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock16
//  652 }
//  653 
//  654 /**
//  655   * @}
//  656   */
//  657 
//  658 /** @defgroup FLASH_Group3 Option Bytes Programming functions
//  659  *  @brief   Option Bytes Programming functions 
//  660  *
//  661 @verbatim   
//  662  ===============================================================================
//  663                         Option Bytes Programming functions
//  664  ===============================================================================  
//  665  
//  666    This group includes the following functions:
//  667    - void FLASH_OB_Unlock(void)
//  668    - void FLASH_OB_Lock(void)
//  669    - void FLASH_OB_WRPConfig(uint32_t OB_WRP, FunctionalState NewState)
//  670    - void FLASH_OB_RDPConfig(uint8_t OB_RDP)
//  671    - void FLASH_OB_UserConfig(uint8_t OB_IWDG, uint8_t OB_STOP, uint8_t OB_STDBY)
//  672    - void FLASH_OB_BORConfig(uint8_t OB_BOR)
//  673    - FLASH_Status FLASH_ProgramOTP(uint32_t Address, uint32_t Data)							
//  674    - FLASH_Status FLASH_OB_Launch(void)
//  675    - uint32_t FLASH_OB_GetUser(void)						
//  676    - uint8_t FLASH_OB_GetWRP(void)						
//  677    - uint8_t FLASH_OB_GetRDP(void)							
//  678    - uint8_t FLASH_OB_GetBOR(void)
//  679    
//  680    Any operation of erase or program should follow these steps:
//  681    1. Call the FLASH_OB_Unlock() function to enable the FLASH option control register access
//  682 
//  683    2. Call one or several functions to program the desired Option Bytes:
//  684       - void FLASH_OB_WRPConfig(uint32_t OB_WRP, FunctionalState NewState) => to Enable/Disable 
//  685         the desired sector write protection
//  686       - void FLASH_OB_RDPConfig(uint8_t OB_RDP) => to set the desired read Protection Level
//  687       - void FLASH_OB_UserConfig(uint8_t OB_IWDG, uint8_t OB_STOP, uint8_t OB_STDBY) => to configure 
//  688         the user Option Bytes.
//  689       - void FLASH_OB_BORConfig(uint8_t OB_BOR) => to set the BOR Level 			 
//  690 
//  691    3. Once all needed Option Bytes to be programmed are correctly written, call the
//  692       FLASH_OB_Launch() function to launch the Option Bytes programming process.
//  693      
//  694      @note When changing the IWDG mode from HW to SW or from SW to HW, a system 
//  695            reset is needed to make the change effective.  
//  696 
//  697    4. Call the FLASH_OB_Lock() function to disable the FLASH option control register
//  698       access (recommended to protect the Option Bytes against possible unwanted operations)
//  699     
//  700 @endverbatim
//  701   * @{
//  702   */
//  703 
//  704 /**
//  705   * @brief  Unlocks the FLASH Option Control Registers access.
//  706   * @param  None
//  707   * @retval None
//  708   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function FLASH_OB_Unlock
        THUMB
//  709 void FLASH_OB_Unlock(void)
//  710 {
//  711 	if((FLASH->OPTCR & FLASH_OPTCR_OPTLOCK) != RESET)
FLASH_OB_Unlock:
        LDR.N    R0,??DataTable32_6  ;; 0x40023c08
        LDR      R1,[R0, #+12]
        LSLS     R1,R1,#+31
        BPL.N    ??FLASH_OB_Unlock_0
//  712 	{
//  713 		/* Authorizes the Option Byte register programming */
//  714 		FLASH->OPTKEYR = FLASH_OPT_KEY1;
        LDR.N    R1,??DataTable32_7  ;; 0x8192a3b
        STR      R1,[R0, #+0]
//  715 		FLASH->OPTKEYR = FLASH_OPT_KEY2;
        LDR.N    R1,??DataTable32_8  ;; 0x4c5d6e7f
        STR      R1,[R0, #+0]
//  716 	}  
//  717 }
??FLASH_OB_Unlock_0:
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  718 
//  719 /**
//  720   * @brief  Locks the FLASH Option Control Registers access.
//  721   * @param  None
//  722   * @retval None
//  723   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function FLASH_OB_Lock
        THUMB
//  724 void FLASH_OB_Lock(void)
//  725 {
//  726 	/* Set the OPTLOCK Bit to lock the FLASH Option Byte Registers access */
//  727 	FLASH->OPTCR |= FLASH_OPTCR_OPTLOCK;
FLASH_OB_Lock:
        LDR.N    R0,??DataTable32_9  ;; 0x40023c14
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//  728 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//  729 
//  730 /**
//  731   * @brief  Enables or disables the write protection of the desired sectors
//  732   * @param  OB_WRP: specifies the sector(s) to be write protected or unprotected.
//  733   *          This parameter can be one of the following values:
//  734   *            @arg OB_WRP: A value between OB_WRP_Sector0 and OB_WRP_Sector11                      
//  735   *            @arg OB_WRP_Sector_All
//  736   * @param  Newstate: new state of the Write Protection.
//  737   *          This parameter can be: ENABLE or DISABLE.
//  738   * @retval None  
//  739   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function FLASH_OB_WRPConfig
        THUMB
//  740 void FLASH_OB_WRPConfig(uint32_t OB_WRP, FunctionalState NewState)
//  741 { 
FLASH_OB_WRPConfig:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R4,R0
        MOV      R5,R1
//  742 	FLASH_Status status = FLASH_COMPLETE;
//  743   
//  744 	/* Check the parameters */
//  745 	assert_param(IS_OB_WRP(OB_WRP));
//  746 	assert_param(IS_FUNCTIONAL_STATE(NewState));
//  747 
//  748 	status = FLASH_WaitForLastOperation();
//  749 
//  750 	if(status == FLASH_COMPLETE)
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+9
        BNE.N    ??FLASH_OB_WRPConfig_0
//  751 	{ 
//  752 		if(NewState != DISABLE)
        MOVS     R0,#+1
        LSLS     R0,R0,R4
        LDR.N    R1,??DataTable32_9  ;; 0x40023c14
        CMP      R5,#+0
        LDR      R2,[R1, #+0]
        ITEE     NE 
        ORRNE    R0,R0,R2, LSR #+16
        LSREQ    R2,R2,#+16
        BICEQ    R0,R2,R0
//  753 		{
//  754 			BitSet(FLASH->__B.OPTCR.nWRP, OB_WRP);
//  755 			//*(__IO uint16_t*)OPTCR_BYTE2_ADDRESS &= (~OB_WRP);
//  756 		}
//  757 		else
//  758 		{
//  759 			BitRst(FLASH->__B.OPTCR.nWRP, OB_WRP);
        LDR      R2,[R1, #+0]
        BFI      R2,R0,#+16,#+12
        STR      R2,[R1, #+0]
//  760 			//*(__IO uint16_t*)OPTCR_BYTE2_ADDRESS |= (uint16_t)OB_WRP;
//  761 		}
//  762 	}
//  763 }
??FLASH_OB_WRPConfig_0:
        POP      {R0,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock19
//  764 
//  765 /**
//  766   * @brief  Sets the read protection level.
//  767   * @param  OB_RDP: specifies the read protection level.
//  768   *          This parameter can be one of the following values:
//  769   *            @arg OB_RDP_Level_0: No protection
//  770   *            @arg OB_RDP_Level_1: Read protection of the memory
//  771   *            @arg OB_RDP_Level_2: Full chip protection
//  772   *   
//  773   * !!!Warning!!! When enabling OB_RDP level 2 it's no more possible to go back to level 1 or 0
//  774   *    
//  775   * @retval None
//  776   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function FLASH_OB_RDPConfig
        THUMB
//  777 void FLASH_OB_RDPConfig(uint8_t OB_RDP)
//  778 {
FLASH_OB_RDPConfig:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOV      R4,R0
//  779   FLASH_Status status = FLASH_COMPLETE;
//  780 
//  781   /* Check the parameters */
//  782   assert_param(IS_OB_RDP(OB_RDP));
//  783 
//  784   status = FLASH_WaitForLastOperation();
//  785 
//  786   if(status == FLASH_COMPLETE)
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+9
        ITT      EQ 
        LDREQ.N  R0,??DataTable32_10  ;; 0x40023c15
        STRBEQ   R4,[R0, #+0]
//  787   {
//  788     *(__IO uint8_t*)OPTCR_BYTE1_ADDRESS = OB_RDP;
//  789 
//  790   }
//  791 }
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock20
//  792 
//  793 /**
//  794   * @brief  Programs the FLASH User Option Byte: IWDG_SW / RST_STOP / RST_STDBY.    
//  795   * @param  OB_IWDG: Selects the IWDG mode
//  796   *          This parameter can be one of the following values:
//  797   *            @arg OB_IWDG_SW: Software IWDG selected
//  798   *            @arg OB_IWDG_HW: Hardware IWDG selected
//  799   * @param  OB_STOP: Reset event when entering STOP mode.
//  800   *          This parameter  can be one of the following values:
//  801   *            @arg OB_STOP_NoRST: No reset generated when entering in STOP
//  802   *            @arg OB_STOP_RST: Reset generated when entering in STOP
//  803   * @param  OB_STDBY: Reset event when entering Standby mode.
//  804   *          This parameter  can be one of the following values:
//  805   *            @arg OB_STDBY_NoRST: No reset generated when entering in STANDBY
//  806   *            @arg OB_STDBY_RST: Reset generated when entering in STANDBY
//  807   * @retval None
//  808   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function FLASH_OB_UserConfig
        THUMB
//  809 void FLASH_OB_UserConfig(uint8_t OB_IWDG, uint8_t OB_STOP, uint8_t OB_STDBY)
//  810 {
FLASH_OB_UserConfig:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//  811   uint8_t optiontmp = 0xFF;
//  812   FLASH_Status status = FLASH_COMPLETE; 
//  813 
//  814   /* Check the parameters */
//  815   assert_param(IS_OB_IWDG_SOURCE(OB_IWDG));
//  816   assert_param(IS_OB_STOP_SOURCE(OB_STOP));
//  817   assert_param(IS_OB_STDBY_SOURCE(OB_STDBY));
//  818 
//  819   /* Wait for last operation to be completed */
//  820   status = FLASH_WaitForLastOperation();
//  821   
//  822   if(status == FLASH_COMPLETE)
        BL       FLASH_WaitForLastOperation
        CMP      R0,#+9
        BNE.N    ??FLASH_OB_UserConfig_0
//  823   { 
//  824     /* Mask OPTLOCK, OPTSTRT and BOR_LEV bits */
//  825     optiontmp =  (uint8_t)((*(__IO uint8_t *)OPTCR_BYTE0_ADDRESS) & (uint8_t)0x0F); 
        LDR.N    R0,??DataTable32_9  ;; 0x40023c14
        LDRB     R1,[R0, #+0]
//  826 
//  827     /* Update User Option Byte */
//  828     *(__IO uint8_t *)OPTCR_BYTE0_ADDRESS = OB_IWDG | (uint8_t)(OB_STDBY | (uint8_t)(OB_STOP | ((uint8_t)optiontmp))); 
        ORR      R2,R6,R4
        ORRS     R2,R5,R2
        AND      R1,R1,#0xF
        ORRS     R1,R1,R2
        STRB     R1,[R0, #+0]
//  829   }  
//  830 }
??FLASH_OB_UserConfig_0:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock21
//  831 
//  832 /**
//  833   * @brief  Sets the BOR Level. 
//  834   * @param  OB_BOR: specifies the Option Bytes BOR Reset Level.
//  835   *          This parameter can be one of the following values:
//  836   *            @arg OB_BOR_LEVEL3: Supply voltage ranges from 2.7 to 3.6 V
//  837   *            @arg OB_BOR_LEVEL2: Supply voltage ranges from 2.4 to 2.7 V
//  838   *            @arg OB_BOR_LEVEL1: Supply voltage ranges from 2.1 to 2.4 V
//  839   *            @arg OB_BOR_OFF: Supply voltage ranges from 1.62 to 2.1 V
//  840   * @retval None
//  841   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function FLASH_OB_BORConfig
        THUMB
//  842 void FLASH_OB_BORConfig(uint8_t OB_BOR)
//  843 {
//  844   /* Check the parameters */
//  845   assert_param(IS_OB_BOR(OB_BOR));
//  846 
//  847   /* Set the BOR Level */
//  848   *(__IO uint8_t *)OPTCR_BYTE0_ADDRESS &= (~FLASH_OPTCR_BOR_LEV);
FLASH_OB_BORConfig:
        LDR.N    R1,??DataTable32_9  ;; 0x40023c14
        LDRB     R2,[R1, #+0]
        AND      R2,R2,#0xF3
        STRB     R2,[R1, #+0]
//  849   *(__IO uint8_t *)OPTCR_BYTE0_ADDRESS |= OB_BOR;
        LDRB     R2,[R1, #+0]
        ORRS     R0,R0,R2
        STRB     R0,[R1, #+0]
//  850 
//  851 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//  852 
//  853 /**
//  854   * @brief  Launch the option byte loading.
//  855   * @param  None
//  856   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
//  857   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
//  858   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function FLASH_OB_Launch
        THUMB
//  859 FLASH_Status FLASH_OB_Launch(void)
//  860 {
//  861 	FLASH_Status status = FLASH_COMPLETE;
//  862 
//  863 	/* Set the OPTSTRT bit in OPTCR register */
//  864 	*(__IO uint8_t *)OPTCR_BYTE0_ADDRESS |= FLASH_OPTCR_OPTSTRT;
FLASH_OB_Launch:
        LDR.N    R0,??DataTable32_9  ;; 0x40023c14
        LDRB     R1,[R0, #+0]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+0]
//  865 
//  866 	/* Wait for last operation to be completed */
//  867 	status = FLASH_WaitForLastOperation();
//  868 //FLASH_TypeDef
//  869 	return status;
        B.N      FLASH_WaitForLastOperation
        CFI EndBlock cfiBlock23
//  870 }
//  871 
//  872 /**
//  873   * @brief  Returns the FLASH User Option Bytes values.
//  874   * @param  None
//  875   * @retval The FLASH User Option Bytes values: IWDG_SW(Bit0), RST_STOP(Bit1)
//  876   *         and RST_STDBY(Bit2).
//  877   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function FLASH_OB_GetUser
        THUMB
//  878 uint8_t FLASH_OB_GetUser(void)
//  879 {
//  880   /* Return the User Option Byte */
//  881   return (uint8_t)(FLASH->OPTCR >> 5);
FLASH_OB_GetUser:
        LDR.N    R0,??DataTable32_9  ;; 0x40023c14
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+19
        LSRS     R0,R0,#+24
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
//  882 }
//  883 
//  884 /*******************************************************************************
//  885   * @brief  Returns the FLASH Write Protection Option Bytes value.
//  886   * @param  None
//  887   * @retval The FLASH Write Protection  Option Bytes value
//  888   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function FLASH_OB_GetWRP
        THUMB
//  889 uint16_t FLASH_OB_GetWRP(uint32_t Sector)
//  890 {
//  891 	/* Return the FLASH write protection Register value */
//  892 	return ((FLASH->__B.OPTCR.nWRP >> Sector) & 0x01);
FLASH_OB_GetWRP:
        LDR.N    R1,??DataTable32_9  ;; 0x40023c14
        LDR      R1,[R1, #+0]
        UBFX     R1,R1,#+16,#+12
        ASR      R0,R1,R0
        AND      R0,R0,#0x1
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
//  893 	//return (*(__IO uint16_t *)(OPTCR_BYTE2_ADDRESS));
//  894 	// 0: write protection
//  895 	// 1: no write protection
//  896 }
//  897 
//  898 /*******************************************************************************
//  899   * @brief  Returns the FLASH Read Protection level.
//  900   * @param  None
//  901   * @retval FLASH ReadOut Protection Status:
//  902   *           - SET, when OB_RDP_Level_1 or OB_RDP_Level_2 is set
//  903   *           - RESET, when OB_RDP_Level_0 is set
//  904   ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function FLASH_OB_GetRDP
        THUMB
//  905 FlagStatus FLASH_OB_GetRDP(void)
//  906 {
//  907   FlagStatus readstatus = RESET;
FLASH_OB_GetRDP:
        MOVS     R0,#+0
//  908 
//  909   if ((*(__IO uint8_t*)(OPTCR_BYTE1_ADDRESS) != (uint8_t)OB_RDP_Level_0))
        LDR.N    R1,??DataTable32_10  ;; 0x40023c15
        LDRB     R1,[R1, #+0]
        CMP      R1,#+170
        IT       NE 
        MOVNE    R0,#+1
//  910   {
//  911     readstatus = SET;
//  912   }
//  913   else
//  914   {
//  915     readstatus = RESET;
//  916   }
//  917   return readstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
//  918 }
//  919 
//  920 /**
//  921   * @brief  Returns the FLASH BOR level.
//  922   * @param  None
//  923   * @retval The FLASH BOR level:
//  924   *           - OB_BOR_LEVEL3: Supply voltage ranges from 2.7 to 3.6 V
//  925   *           - OB_BOR_LEVEL2: Supply voltage ranges from 2.4 to 2.7 V
//  926   *           - OB_BOR_LEVEL1: Supply voltage ranges from 2.1 to 2.4 V
//  927   *           - OB_BOR_OFF   : Supply voltage ranges from 1.62 to 2.1 V  
//  928   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function FLASH_OB_GetBOR
        THUMB
//  929 uint8_t FLASH_OB_GetBOR(void)
//  930 {
//  931   /* Return the FLASH BOR level */
//  932   return (uint8_t)(*(__IO uint8_t *)(OPTCR_BYTE0_ADDRESS) & (uint8_t)0x0C);
FLASH_OB_GetBOR:
        LDR.N    R0,??DataTable32_9  ;; 0x40023c14
        LDRB     R0,[R0, #+0]
        AND      R0,R0,#0xC
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
//  933 }
//  934 
//  935 /**
//  936   * @}
//  937   */
//  938 
//  939 /** @defgroup FLASH_Group4 Interrupts and flags management functions
//  940  *  @brief   Interrupts and flags management functions
//  941  *
//  942 @verbatim   
//  943  ===============================================================================
//  944                   Interrupts and flags management functions
//  945  ===============================================================================  
//  946 
//  947 @endverbatim
//  948   * @{
//  949   */
//  950 
//  951 /**
//  952   * @brief  Enables or disables the specified FLASH interrupts.
//  953   * @param  FLASH_IT: specifies the FLASH interrupt sources to be enabled or disabled.
//  954   *          This parameter can be any combination of the following values:
//  955   *            @arg FLASH_IT_ERR: FLASH Error Interrupt
//  956   *            @arg FLASH_IT_EOP: FLASH end of operation Interrupt
//  957   * @retval None 
//  958   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function FLASH_ITConfig
        THUMB
//  959 void FLASH_ITConfig(uint32_t FLASH_IT, FunctionalState NewState)
//  960 {
//  961   /* Check the parameters */
//  962   assert_param(IS_FLASH_IT(FLASH_IT)); 
//  963   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  964 
//  965   if(NewState != DISABLE)
FLASH_ITConfig:
        LDR.N    R2,??DataTable32_5  ;; 0x40023c10
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
//  966   {
//  967     /* Enable the interrupt sources */
//  968     FLASH->CR |= FLASH_IT;
//  969   }
//  970   else
//  971   {
//  972     /* Disable the interrupt sources */
//  973     FLASH->CR &= ~(uint32_t)FLASH_IT;
        STR      R0,[R2, #+0]
//  974   }
//  975 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock28
//  976 
//  977 /**
//  978   * @brief  Checks whether the specified FLASH flag is set or not.
//  979   * @param  FLASH_FLAG: specifies the FLASH flag to check.
//  980   *          This parameter can be one of the following values:
//  981   *            @arg FLASH_FLAG_EOP: FLASH End of Operation flag 
//  982   *            @arg FLASH_FLAG_OPERR: FLASH operation Error flag 
//  983   *            @arg FLASH_FLAG_WRPERR: FLASH Write protected error flag 
//  984   *            @arg FLASH_FLAG_PGAERR: FLASH Programming Alignment error flag
//  985   *            @arg FLASH_FLAG_PGPERR: FLASH Programming Parallelism error flag
//  986   *            @arg FLASH_FLAG_PGSERR: FLASH Programming Sequence error flag
//  987   *            @arg FLASH_FLAG_BSY: FLASH Busy flag
//  988   * @retval The new state of FLASH_FLAG (SET or RESET).
//  989   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function FLASH_GetFlagStatus
        THUMB
//  990 FlagStatus FLASH_GetFlagStatus(uint32_t FLASH_FLAG)
//  991 {
//  992   FlagStatus bitstatus = RESET;
FLASH_GetFlagStatus:
        MOVS     R1,#+0
//  993   /* Check the parameters */
//  994   assert_param(IS_FLASH_GET_FLAG(FLASH_FLAG));
//  995 
//  996   if((FLASH->SR & FLASH_FLAG) != (uint32_t)RESET)
        LDR.N    R2,??DataTable32  ;; 0x40023c0c
        LDR      R2,[R2, #+0]
        TST      R2,R0
        IT       NE 
        MOVNE    R1,#+1
//  997   {
//  998     bitstatus = SET;
//  999   }
// 1000   else
// 1001   {
// 1002     bitstatus = RESET;
// 1003   }
// 1004   /* Return the new state of FLASH_FLAG (SET or RESET) */
// 1005   return bitstatus; 
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock29
// 1006 }
// 1007 
// 1008 /**
// 1009   * @brief  Clears the FLASH's pending flags.
// 1010   * @param  FLASH_FLAG: specifies the FLASH flags to clear.
// 1011   *          This parameter can be any combination of the following values:
// 1012   *            @arg FLASH_FLAG_EOP: FLASH End of Operation flag 
// 1013   *            @arg FLASH_FLAG_OPERR: FLASH operation Error flag 
// 1014   *            @arg FLASH_FLAG_WRPERR: FLASH Write protected error flag 
// 1015   *            @arg FLASH_FLAG_PGAERR: FLASH Programming Alignment error flag 
// 1016   *            @arg FLASH_FLAG_PGPERR: FLASH Programming Parallelism error flag
// 1017   *            @arg FLASH_FLAG_PGSERR: FLASH Programming Sequence error flag
// 1018   * @retval None
// 1019   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI Function FLASH_ClearFlag
        THUMB
// 1020 void FLASH_ClearFlag(uint32_t FLASH_FLAG)
// 1021 {
// 1022 	/* Check the parameters */
// 1023 	assert_param(IS_FLASH_CLEAR_FLAG(FLASH_FLAG));
// 1024 
// 1025 	/* Clear the flags */
// 1026 	FLASH->SR = FLASH_FLAG;
FLASH_ClearFlag:
        LDR.N    R1,??DataTable32  ;; 0x40023c0c
        STR      R0,[R1, #+0]
// 1027 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock30
// 1028 
// 1029 /*******************************************************************************
// 1030   * @brief  Returns the FLASH Status.
// 1031   * @param  None
// 1032   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
// 1033   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
// 1034   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock31 Using cfiCommon0
        CFI Function FLASH_GetStatus
        THUMB
// 1035 FLASH_Status FLASH_GetStatus(void)
// 1036 {
// 1037 	FLASH_Status flashstatus = FLASH_COMPLETE;
FLASH_GetStatus:
        MOVS     R0,#+9
// 1038   
// 1039 	if((FLASH->SR & FLASH_FLAG_BSY) == FLASH_FLAG_BSY) 
        LDR.N    R1,??DataTable32  ;; 0x40023c0c
        LDR      R2,[R1, #+0]
        LSLS     R2,R2,#+15
        BPL.N    ??FLASH_GetStatus_0
// 1040 	{
// 1041 		flashstatus = FLASH_BUSY;
        MOVS     R0,#+1
        BX       LR
// 1042 	}
// 1043 	else 
// 1044 	{  
// 1045 		if((FLASH->SR & FLASH_FLAG_WRPERR) != (uint32_t)0x00)
??FLASH_GetStatus_0:
        LDR      R2,[R1, #+0]
        LSLS     R2,R2,#+27
        BPL.N    ??FLASH_GetStatus_1
// 1046 		{ 
// 1047 			flashstatus = FLASH_ERROR_WRP;
        MOVS     R0,#+5
        BX       LR
// 1048 		}
// 1049 		else 
// 1050 		{
// 1051 			if((FLASH->SR & (uint32_t)0xEF) != (uint32_t)0x00)
??FLASH_GetStatus_1:
        LDR      R2,[R1, #+0]
        ANDS     R2,R2,#0xEF
        BEQ.N    ??FLASH_GetStatus_2
// 1052 		  	{
// 1053 		   		flashstatus = FLASH_ERROR_PROGRAM; 
        MOVS     R0,#+6
        BX       LR
// 1054 		  	}
// 1055 		  	else
// 1056 		  	{
// 1057 		    	if((FLASH->SR & FLASH_FLAG_OPERR) != (uint32_t)0x00)
??FLASH_GetStatus_2:
        LDR      R1,[R1, #+0]
        LSLS     R1,R1,#+30
        IT       MI 
        MOVMI    R0,#+7
// 1058 		    	{
// 1059 		    	  	flashstatus = FLASH_ERROR_OPERATION;
// 1060 		    	}
// 1061 		    	else
// 1062 		    	{
// 1063 		     		flashstatus = FLASH_COMPLETE;
// 1064 		    	}
// 1065 		  	}
// 1066 		}
// 1067 	}
// 1068 	/* Return the FLASH Status */
// 1069 	return flashstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock31
// 1070 }
// 1071 
// 1072 /*******************************************************************************
// 1073   * @brief  Waits for a FLASH operation to complete.
// 1074   * @param  None
// 1075   * @retval FLASH Status: The returned value can be: FLASH_BUSY, FLASH_ERROR_PROGRAM,
// 1076   *                       FLASH_ERROR_WRP, FLASH_ERROR_OPERATION or FLASH_COMPLETE.
// 1077   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock32 Using cfiCommon0
        CFI Function FLASH_WaitForLastOperation
        THUMB
// 1078 FLASH_Status FLASH_WaitForLastOperation(void)
// 1079 {
FLASH_WaitForLastOperation:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
// 1080 	u32 rtry = 0xffff;
        MOVW     R4,#+65535
// 1081 	__IO FLASH_Status status = FLASH_COMPLETE;
        MOVS     R0,#+9
        STRB     R0,[SP, #+0]
// 1082    
// 1083 	/* Check for the FLASH Status */
// 1084 	status = FLASH_GetStatus();
// 1085 
// 1086 	/* Wait for the FLASH operation to complete by polling on BUSY flag to be reset.
// 1087 	 Even if the FLASH operation fails, the BUSY flag will be reset and an error
// 1088 	 flag will be set */
// 1089 	while(status == FLASH_BUSY && rtry--)
// 1090 	{
// 1091 		status = FLASH_GetStatus();
??FLASH_WaitForLastOperation_0:
        BL       FLASH_GetStatus
        STRB     R0,[SP, #+0]
// 1092 	}
        LDRB     R0,[SP, #+0]
        CMP      R0,#+1
        BNE.N    ??FLASH_WaitForLastOperation_1
        MOV      R0,R4
        SUBS     R4,R0,#+1
        CMP      R0,#+0
        BNE.N    ??FLASH_WaitForLastOperation_0
// 1093 	
// 1094 	/* Return the operation status */
// 1095 	return status;
??FLASH_WaitForLastOperation_1:
        LDRB     R0,[SP, #+0]
        POP      {R1,R2,R4,PC}    ;; return
        CFI EndBlock cfiBlock32
// 1096 }
// 1097 
// 1098 /*******************************************************************************
// 1099   * @brief  Returns the write protection status of user flash area.
// 1100   * @param  None
// 1101   * @retval 0: No write protected sectors inside the user flash area
// 1102   *         1: Some sectors inside the user flash area are write protected
// 1103   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock33 Using cfiCommon0
        CFI Function FLASH_If_GetWPStatus
        THUMB
// 1104 uint16_t FLASH_If_GetWPStatus(uint32_t Addr)
// 1105 {
FLASH_If_GetWPStatus:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
// 1106 	uint32_t uSector = GetSector(Addr);
        BL       GetSector
// 1107 
// 1108 	return FLASH_OB_GetWRP(uSector);
        LDR.N    R1,??DataTable32_9  ;; 0x40023c14
        LDR      R1,[R1, #+0]
        UBFX     R1,R1,#+16,#+12
        ASR      R0,R1,R0
        AND      R0,R0,#0x1
        POP      {R1,PC}          ;; return
        CFI EndBlock cfiBlock33
// 1109 
// 1110 	/* 1: No write protected sectors inside the user flash area */
// 1111 	/* 0: Some sectors inside the user flash area are write protected */
// 1112 }
// 1113 
// 1114 /*******************************************************************************
// 1115   * @brief  Disables the write protection of user flash area.
// 1116   * @param  None
// 1117   * @retval 1: Write Protection successfully disabled
// 1118   *         2: Error: Flash write unprotection failed
// 1119   ******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock34 Using cfiCommon0
        CFI Function FLASH_WPDisable
        THUMB
// 1120 uint32_t FLASH_WPDisable(uint32_t Addr)
// 1121 {
FLASH_WPDisable:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
// 1122 	__IO uint32_t uSector = FLASH_Sector_1;
        MOVS     R1,#+8
        STR      R1,[SP, #+0]
// 1123 
// 1124 	/* Get the sector where start the user flash area */
// 1125 	uSector = GetSector(Addr);
        BL       GetSector
        STR      R0,[SP, #+0]
// 1126 
// 1127 	/* Mark all sectors inside the user flash area as non protected */  
// 1128 	//UserWrpSectors = 0xFFF-((1 << (UserStartSector/8))-1);
// 1129 
// 1130 	/* Unlock the Option Bytes */
// 1131 	FLASH_OB_Unlock();
        BL       FLASH_OB_Unlock
// 1132 
// 1133 	/* Disable the write protection for all sectors inside the user flash area */
// 1134 	FLASH_OB_WRPConfig(uSector, DISABLE);
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       FLASH_OB_WRPConfig
// 1135 
// 1136 	/* Start the Option Bytes programming process. */  
// 1137 	if (FLASH_OB_Launch() != FLASH_COMPLETE)
        BL       FLASH_OB_Launch
        CMP      R0,#+9
        BEQ.N    ??FLASH_WPDisable_0
// 1138 	{
// 1139 		/* Error: Flash write unprotection failed */
// 1140 		return (2);
        MOVS     R0,#+2
        POP      {R1,PC}
// 1141 	}
// 1142 
// 1143 	/* Write Protection successfully disabled */
// 1144 	return (1);
??FLASH_WPDisable_0:
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
        CFI EndBlock cfiBlock34
// 1145 //FLASH_TypeDef
// 1146 }
// 1147 
// 1148 /*******************************************************************************
// 1149   * @brief  Gets the sector of a given address
// 1150   * @param  Address: Flash address
// 1151   * @retval The sector of a given address
// 1152   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock35 Using cfiCommon0
        CFI Function GetSector
        THUMB
// 1153 uint32_t GetSector(uint32_t Addr)
// 1154 {
// 1155 		 if(Addr < ADDR_FLASH_SECTOR_1)		return 0;
GetSector:
        LDR.N    R1,??DataTable32_11  ;; 0x8004000
        CMP      R0,R1
        BCS.N    ??GetSector_0
        MOVS     R0,#+0
        BX       LR
// 1156 	else if(Addr < ADDR_FLASH_SECTOR_2) 	return 1;
??GetSector_0:
        LDR.N    R1,??DataTable32_12  ;; 0x8008000
        CMP      R0,R1
        BCS.N    ??GetSector_1
        MOVS     R0,#+1
        BX       LR
// 1157 	else if(Addr < ADDR_FLASH_SECTOR_3) 	return 2;
??GetSector_1:
        LDR.N    R1,??DataTable32_13  ;; 0x800c000
        CMP      R0,R1
        BCS.N    ??GetSector_2
        MOVS     R0,#+2
        BX       LR
// 1158 	else if(Addr < ADDR_FLASH_SECTOR_4) 	return 3;
??GetSector_2:
        LDR.N    R1,??DataTable32_14  ;; 0x8010000
        CMP      R0,R1
        BCS.N    ??GetSector_3
        MOVS     R0,#+3
        BX       LR
// 1159 	else if(Addr < ADDR_FLASH_SECTOR_5) 	return 4;
??GetSector_3:
        LDR.N    R1,??DataTable32_15  ;; 0x8020000
        CMP      R0,R1
        BCS.N    ??GetSector_4
        MOVS     R0,#+4
        BX       LR
// 1160 	else if(Addr < ADDR_FLASH_SECTOR_6) 	return 5;
??GetSector_4:
        LDR.N    R1,??DataTable32_16  ;; 0x8040000
        CMP      R0,R1
        BCS.N    ??GetSector_5
        MOVS     R0,#+5
        BX       LR
// 1161 	else if(Addr < ADDR_FLASH_SECTOR_7) 	return 6;
??GetSector_5:
        LDR.N    R1,??DataTable32_17  ;; 0x8060000
        CMP      R0,R1
        BCS.N    ??GetSector_6
        MOVS     R0,#+6
        BX       LR
// 1162 	else if(Addr < ADDR_FLASH_SECTOR_8) 	return 7;
??GetSector_6:
        LDR.N    R1,??DataTable32_18  ;; 0x8080000
        CMP      R0,R1
        BCS.N    ??GetSector_7
        MOVS     R0,#+7
        BX       LR
// 1163 	else if(Addr < ADDR_FLASH_SECTOR_9) 	return 8;
??GetSector_7:
        LDR.N    R1,??DataTable32_19  ;; 0x80a0000
        CMP      R0,R1
        BCS.N    ??GetSector_8
        MOVS     R0,#+8
        BX       LR
// 1164 	else if(Addr < ADDR_FLASH_SECTOR_10)	return 9;
??GetSector_8:
        LDR.N    R1,??DataTable32_20  ;; 0x80c0000
        CMP      R0,R1
        BCS.N    ??GetSector_9
        MOVS     R0,#+9
        BX       LR
// 1165 	else if(Addr < ADDR_FLASH_SECTOR_11)	return 10;
??GetSector_9:
        LDR.N    R1,??DataTable32_21  ;; 0x80e0000
        CMP      R0,R1
        BCS.N    ??GetSector_10
        MOVS     R0,#+10
        BX       LR
// 1166 	else									return 11;
??GetSector_10:
        MOVS     R0,#+11
        BX       LR               ;; return
        CFI EndBlock cfiBlock35
// 1167 
// 1168 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32:
        DC32     0x40023c0c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_1:
        DC32     0x40023c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_2:
        DC32     0x40023c04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_3:
        DC32     0x45670123

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_4:
        DC32     0xcdef89ab

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_5:
        DC32     0x40023c10

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_6:
        DC32     0x40023c08

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_7:
        DC32     0x8192a3b

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_8:
        DC32     0x4c5d6e7f

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_9:
        DC32     0x40023c14

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_10:
        DC32     0x40023c15

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_11:
        DC32     0x8004000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_12:
        DC32     0x8008000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_13:
        DC32     0x800c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_14:
        DC32     0x8010000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_15:
        DC32     0x8020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_16:
        DC32     0x8040000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_17:
        DC32     0x8060000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_18:
        DC32     0x8080000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_19:
        DC32     0x80a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_20:
        DC32     0x80c0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_21:
        DC32     0x80e0000

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 1169 
// 1170 
// 1171 /**
// 1172   * @}
// 1173   */ 
// 1174 
// 1175 /**
// 1176   * @}
// 1177   */ 
// 1178 
// 1179 /**
// 1180   * @}
// 1181   */ 
// 1182 
// 1183 /**
// 1184   * @}
// 1185   */
// 1186 
// 1187 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 1 244 bytes in section .text
// 
// 1 244 bytes of CODE memory
//
//Errors: none
//Warnings: none
