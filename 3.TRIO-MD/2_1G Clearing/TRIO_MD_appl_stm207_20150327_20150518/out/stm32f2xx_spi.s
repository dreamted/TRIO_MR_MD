///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:05 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_spi.c                                 /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_spi.c -D OS_INCLUDED -D APPL_SRC -lA  /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ -o           /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_spi /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_spi

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN RCC_APB1PeriphResetCmd
        EXTERN RCC_APB2PeriphResetCmd

        PUBLIC I2S_Cmd
        PUBLIC I2S_Init
        PUBLIC I2S_StructInit
        PUBLIC SPI1Init
        PUBLIC SPI_BiDirectionalLineConfig
        PUBLIC SPI_CalculateCRC
        PUBLIC SPI_Cmd
        PUBLIC SPI_DataSizeConfig
        PUBLIC SPI_GetCRC
        PUBLIC SPI_GetCRCPolynomial
        PUBLIC SPI_I2S_ClearFlag
        PUBLIC SPI_I2S_ClearITPendingBit
        PUBLIC SPI_I2S_DMACmd
        PUBLIC SPI_I2S_DeInit
        PUBLIC SPI_I2S_GetFlagStatus
        PUBLIC SPI_I2S_GetITStatus
        PUBLIC SPI_I2S_ITConfig
        PUBLIC SPI_I2S_ReceiveData
        PUBLIC SPI_I2S_SendData
        PUBLIC SPI_Init
        PUBLIC SPI_NSSInternalSoftwareConfig
        PUBLIC SPI_SSOutputCmd
        PUBLIC SPI_StructInit
        PUBLIC SPI_TIModeCmd
        PUBLIC SPI_TransmitCRC
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_spi.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_spi.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7   * @brief   This file provides firmware functions to manage the following 
//    8   *          functionalities of the Serial peripheral interface (SPI):           
//    9   *           - Initialization and Configuration
//   10   *           - Data transfers functions
//   11   *           - Hardware CRC Calculation
//   12   *           - DMA transfers management
//   13   *           - Interrupts and flags management 
//   14   *           
//   15   *  @verbatim
//   16   *          
//   17   *                    
//   18   *          ===================================================================
//   19   *                                 How to use this driver
//   20   *          ===================================================================
//   21   *          1. Enable peripheral clock using the following functions 
//   22   *             RCC_APB2PeriphClockCmd(RCC_APB2Periph_SPI1, ENABLE) for SPI1
//   23   *             RCC_APB1PeriphClockCmd(RCC_APB1Periph_SPI2, ENABLE) for SPI2
//   24   *             RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI3, ENABLE) for SPI3.
//   25   *
//   26   *          2. Enable SCK, MOSI, MISO and NSS GPIO clocks using RCC_AHB1PeriphClockCmd()
//   27   *             function.
//   28   *             In I2S mode, if an external clock source is used then the I2S CKIN pin GPIO
//   29   *             clock should also be enabled.
//   30   *
//   31   *          3. Peripherals alternate function: 
//   32   *                 - Connect the pin to the desired peripherals' Alternate 
//   33   *                   Function (AF) using GPIO_PinAFConfig() function
//   34   *                 - Configure the desired pin in alternate function by:
//   35   *                   GPIO_InitStruct->GPIO_Mode = GPIO_Mode_AF
//   36   *                 - Select the type, pull-up/pull-down and output speed via 
//   37   *                   GPIO_PuPd, GPIO_OType and GPIO_Speed members
//   38   *                 - Call GPIO_Init() function
//   39   *              In I2S mode, if an external clock source is used then the I2S CKIN pin
//   40   *              should be also configured in Alternate function Push-pull pull-up mode. 
//   41   *        
//   42   *          4. Program the Polarity, Phase, First Data, Baud Rate Prescaler, Slave 
//   43   *             Management, Peripheral Mode and CRC Polynomial values using the SPI_Init()
//   44   *             function.
//   45   *             In I2S mode, program the Mode, Standard, Data Format, MCLK Output, Audio 
//   46   *             frequency and Polarity using I2S_Init() function.
//   47   *             For I2S mode, make sure that either:
//   48   *              - I2S PLL is configured using the functions RCC_I2SCLKConfig(RCC_I2S2CLKSource_PLLI2S), 
//   49   *                RCC_PLLI2SCmd(ENABLE) and RCC_GetFlagStatus(RCC_FLAG_PLLI2SRDY).
//   50   *              or 
//   51   *              - External clock source is configured using the function 
//   52   *                RCC_I2SCLKConfig(RCC_I2S2CLKSource_Ext) and after setting correctly the define constant
//   53   *                I2S_EXTERNAL_CLOCK_VAL in the stm32f2xx_conf.h file. 
//   54   *
//   55   *          5. Enable the NVIC and the corresponding interrupt using the function 
//   56   *             SPI_ITConfig() if you need to use interrupt mode. 
//   57   *
//   58   *          6. When using the DMA mode 
//   59   *                   - Configure the DMA using DMA_Init() function
//   60   *                   - Active the needed channel Request using SPI_I2S_DMACmd() function
//   61   * 
//   62   *          7. Enable the SPI using the SPI_Cmd() function or enable the I2S using
//   63   *             I2S_Cmd().
//   64   * 
//   65   *          8. Enable the DMA using the DMA_Cmd() function when using DMA mode. 
//   66   *
//   67   *          9. Optionally, you can enable/configure the following parameters without
//   68   *             re-initialization (i.e there is no need to call again SPI_Init() function):
//   69   *              - When bidirectional mode (SPI_Direction_1Line_Rx or SPI_Direction_1Line_Tx)
//   70   *                is programmed as Data direction parameter using the SPI_Init() function
//   71   *                it can be possible to switch between SPI_Direction_Tx or SPI_Direction_Rx
//   72   *                using the SPI_BiDirectionalLineConfig() function.
//   73   *              - When SPI_NSS_Soft is selected as Slave Select Management parameter 
//   74   *                using the SPI_Init() function it can be possible to manage the 
//   75   *                NSS internal signal using the SPI_NSSInternalSoftwareConfig() function.
//   76   *              - Reconfigure the data size using the SPI_DataSizeConfig() function  
//   77   *              - Enable or disable the SS output using the SPI_SSOutputCmd() function  
//   78   *          
//   79   *          10. To use the CRC Hardware calculation feature refer to the Peripheral 
//   80   *              CRC hardware Calculation subsection.
//   81   *   
//   82   *
//   83   * @note    This driver supports only the I2S clock scheme available in Silicon
//   84   *          RevisionB and RevisionY.
//   85   *     
//   86   * @note    In I2S mode: if an external clock is used as source clock for the I2S,  
//   87   *          then the define I2S_EXTERNAL_CLOCK_VAL in file stm32f2xx_conf.h should 
//   88   *          be enabled and set to the value of the source clock frequency (in Hz).
//   89   * 
//   90   * @note    In SPI mode: To use the SPI TI mode, call the function SPI_TIModeCmd() 
//   91   *          just after calling the function SPI_Init().
//   92   *
//   93   *  @endverbatim  
//   94   *                                  
//   95   ******************************************************************************
//   96   * @attention
//   97   *
//   98   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   99   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//  100   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//  101   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//  102   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//  103   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//  104   *
//  105   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//  106   ******************************************************************************  
//  107   */ 
//  108 
//  109 /* Includes ------------------------------------------------------------------*/
//  110 #include "stm32f2xx_spi.h"
//  111 #include "stm32f2xx_rcc_1208.h"
//  112 
//  113 /** @addtogroup STM32F2xx_StdPeriph_Driver
//  114   * @{
//  115   */
//  116 
//  117 /** @defgroup SPI 
//  118   * @brief SPI driver modules
//  119   * @{
//  120   */ 
//  121 
//  122 /* Private typedef -----------------------------------------------------------*/
//  123 /* Private define ------------------------------------------------------------*/
//  124 
//  125 /* SPI registers Masks */
//  126 #define CR1_CLEAR_MASK            ((uint16_t)0x3040)
//  127 #define I2SCFGR_CLEAR_MASK        ((uint16_t)0xF040)
//  128 
//  129 /* RCC PLLs masks */
//  130 #define PLLCFGR_PPLR_MASK         ((uint32_t)0x70000000)
//  131 #define PLLCFGR_PPLN_MASK         ((uint32_t)0x00007FC0)
//  132 
//  133 #define SPI_CR2_FRF               ((uint16_t)0x0010)
//  134 #define SPI_SR_TIFRFE             ((uint16_t)0x0100)
//  135 
//  136 /* Private macro -------------------------------------------------------------*/
//  137 /* Private variables ---------------------------------------------------------*/
//  138 /* Private function prototypes -----------------------------------------------*/
//  139 /* Private functions ---------------------------------------------------------*/
//  140 
//  141 /** @defgroup SPI_Private_Functions
//  142   * @{
//  143   */
//  144 
//  145 /** @defgroup SPI_Group1 Initialization and Configuration functions
//  146  *  @brief   Initialization and Configuration functions 
//  147  *
//  148 @verbatim   
//  149  ===============================================================================
//  150                   Initialization and Configuration functions
//  151  ===============================================================================  
//  152 
//  153   This section provides a set of functions allowing to initialize the SPI Direction,
//  154   SPI Mode, SPI Data Size, SPI Polarity, SPI Phase, SPI NSS Management, SPI Baud
//  155   Rate Prescaler, SPI First Bit and SPI CRC Polynomial.
//  156   
//  157   The SPI_Init() function follows the SPI configuration procedures for Master mode
//  158   and Slave mode (details for these procedures are available in reference manual
//  159   (RM0033)).
//  160   
//  161 @endverbatim
//  162   * @{
//  163   */
//  164 
//  165 /**
//  166   * @brief  Deinitialize the SPIx peripheral registers to their default reset values.
//  167   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
//  168   *         in SPI mode or 2 or 3 in I2S mode.   
//  169   * @retval None
//  170   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function SPI_I2S_DeInit
        THUMB
//  171 void SPI_I2S_DeInit(SPI_TypeDef* SPIx)
//  172 {
SPI_I2S_DeInit:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  173   /* Check the parameters */
//  174   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  175 
//  176   if (SPIx == SPI1)
        LDR.N    R1,??DataTable2  ;; 0x40013000
        CMP      R0,R1
        BNE.N    ??SPI_I2S_DeInit_0
//  177   {
//  178     /* Enable SPI1 reset state */
//  179     RCC_APB2PeriphResetCmd(RCC_APB2Periph_SPI1, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+4096
        BL       RCC_APB2PeriphResetCmd
//  180     /* Release SPI1 from reset state */
//  181     RCC_APB2PeriphResetCmd(RCC_APB2Periph_SPI1, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+4096
        POP      {R2,LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      RCC_APB2PeriphResetCmd
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  182   }
//  183   else if (SPIx == SPI2)
??SPI_I2S_DeInit_0:
        LDR.N    R1,??DataTable2_1  ;; 0x40003800
        CMP      R0,R1
        BNE.N    ??SPI_I2S_DeInit_1
//  184   {
//  185     /* Enable SPI2 reset state */
//  186     RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI2, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+16384
        BL       RCC_APB1PeriphResetCmd
//  187     /* Release SPI2 from reset state */
//  188     RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI2, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+16384
        B.N      ??SPI_I2S_DeInit_2
//  189     }
//  190   else
//  191   {
//  192     if (SPIx == SPI3)
??SPI_I2S_DeInit_1:
        LDR.N    R1,??DataTable2_2  ;; 0x40003c00
        CMP      R0,R1
        BNE.N    ??SPI_I2S_DeInit_3
//  193     {
//  194       /* Enable SPI3 reset state */
//  195       RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI3, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+32768
        BL       RCC_APB1PeriphResetCmd
//  196       /* Release SPI3 from reset state */
//  197       RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI3, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+32768
??SPI_I2S_DeInit_2:
        BL       RCC_APB1PeriphResetCmd
//  198     }
//  199   }
//  200 }
??SPI_I2S_DeInit_3:
        POP      {R0,PC}          ;; return
        CFI EndBlock cfiBlock0
//  201 
//  202 /**
//  203   * @brief  Initializes the SPIx peripheral according to the specified 
//  204   *         parameters in the SPI_InitStruct.
//  205   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  206   * @param  SPI_InitStruct: pointer to a SPI_InitTypeDef structure that
//  207   *         contains the configuration information for the specified SPI peripheral.
//  208   * @retval None
//  209   */
//  210 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function SPI1Init
        THUMB
//  211 void SPI1Init(void)
//  212 {
SPI1Init:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+24
        CFI CFA R13+32
//  213   SPI_InitTypeDef  SPI_InitStructure;
//  214 
//  215   RCC->__B.APB2ENR.SPI1EN = ENABLE;
        LDR.N    R0,??DataTable2_3  ;; 0x40023844
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1000
        STR      R1,[R0, #+0]
//  216  
//  217   /*!< SPI configuration */
//  218   SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//  219   SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
        MOV      R0,#+260
        STRH     R0,[SP, #+2]
//  220   SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  221   SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;
//  222   SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;
        STRH     R0,[SP, #+8]
//  223   SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
        MOV      R0,#+512
        STRH     R0,[SP, #+10]
//  224   //SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_4;
//  225 	
//  226   SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_8;
        MOVS     R0,#+16
        STRH     R0,[SP, #+12]
//  227   
//  228   SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
        MOVS     R0,#+0
        STRH     R0,[SP, #+14]
//  229   SPI_InitStructure.SPI_CRCPolynomial = 7;
        MOVS     R0,#+7
        STRH     R0,[SP, #+16]
//  230   
//  231   SPI_Init(SPI1, &SPI_InitStructure);
        LDR.N    R4,??DataTable2  ;; 0x40013000
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       SPI_Init
//  232 
//  233   /*!< Enable the sFLASH_SPI  */
//  234   SPI_Cmd(SPI1, ENABLE);
        MOVS     R1,#+1
        MOV      R0,R4
        BL       SPI_Cmd
//  235 }
        ADD      SP,SP,#+24
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock1
//  236 
//  237 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function SPI_Init
        THUMB
//  238 void SPI_Init(SPI_TypeDef* SPIx, SPI_InitTypeDef* SPI_InitStruct)
//  239 {
//  240   uint16_t tmpreg = 0;
//  241   
//  242   /* check the parameters */
//  243   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  244   
//  245   /* Check the SPI parameters */
//  246   assert_param(IS_SPI_DIRECTION_MODE(SPI_InitStruct->SPI_Direction));
//  247   assert_param(IS_SPI_MODE(SPI_InitStruct->SPI_Mode));
//  248   assert_param(IS_SPI_DATASIZE(SPI_InitStruct->SPI_DataSize));
//  249   assert_param(IS_SPI_CPOL(SPI_InitStruct->SPI_CPOL));
//  250   assert_param(IS_SPI_CPHA(SPI_InitStruct->SPI_CPHA));
//  251   assert_param(IS_SPI_NSS(SPI_InitStruct->SPI_NSS));
//  252   assert_param(IS_SPI_BAUDRATE_PRESCALER(SPI_InitStruct->SPI_BaudRatePrescaler));
//  253   assert_param(IS_SPI_FIRST_BIT(SPI_InitStruct->SPI_FirstBit));
//  254   assert_param(IS_SPI_CRC_POLYNOMIAL(SPI_InitStruct->SPI_CRCPolynomial));
//  255 
//  256 /*---------------------------- SPIx CR1 Configuration ------------------------*/
//  257   /* Get the SPIx CR1 value */
//  258   tmpreg = SPIx->CR1;
//  259   /* Clear BIDIMode, BIDIOE, RxONLY, SSM, SSI, LSBFirst, BR, MSTR, CPOL and CPHA bits */
//  260   tmpreg &= CR1_CLEAR_MASK;
//  261   /* Configure SPIx: direction, NSS management, first transmitted bit, BaudRate prescaler
//  262      master/salve mode, CPOL and CPHA */
//  263   /* Set BIDImode, BIDIOE and RxONLY bits according to SPI_Direction value */
//  264   /* Set SSM, SSI and MSTR bits according to SPI_Mode and SPI_NSS values */
//  265   /* Set LSBFirst bit according to SPI_FirstBit value */
//  266   /* Set BR bits according to SPI_BaudRatePrescaler value */
//  267   /* Set CPOL bit according to SPI_CPOL value */
//  268   /* Set CPHA bit according to SPI_CPHA value */
//  269   tmpreg |= (uint16_t)((uint32_t)SPI_InitStruct->SPI_Direction | SPI_InitStruct->SPI_Mode |
//  270                   SPI_InitStruct->SPI_DataSize | SPI_InitStruct->SPI_CPOL |  
//  271                   SPI_InitStruct->SPI_CPHA | SPI_InitStruct->SPI_NSS |  
//  272                   SPI_InitStruct->SPI_BaudRatePrescaler | SPI_InitStruct->SPI_FirstBit);
//  273   /* Write to SPIx CR1 */
//  274   SPIx->CR1 = tmpreg;
SPI_Init:
        LDRH     R2,[R0, #+0]
        AND      R2,R2,#0x3040
        LDRH     R3,[R1, #+0]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+2]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+4]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+6]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+8]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+10]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+12]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+14]
        ORRS     R2,R3,R2
        STRH     R2,[R0, #+0]
//  275 
//  276   /* Activate the SPI mode (Reset I2SMOD bit in I2SCFGR register) */
//  277   SPIx->I2SCFGR &= (uint16_t)~((uint16_t)SPI_I2SCFGR_I2SMOD);
        LDRH     R2,[R0, #+28]
        MOVW     R3,#+63487
        ANDS     R2,R3,R2
        STRH     R2,[R0, #+28]
//  278 /*---------------------------- SPIx CRCPOLY Configuration --------------------*/
//  279   /* Write to SPIx CRCPOLY */
//  280   SPIx->CRCPR = SPI_InitStruct->SPI_CRCPolynomial;
        LDRH     R1,[R1, #+16]
        STRH     R1,[R0, #+16]
//  281 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  282 
//  283 /**
//  284   * @brief  Initializes the SPIx peripheral according to the specified 
//  285   *         parameters in the I2S_InitStruct.
//  286   * @param  SPIx: where x can be  2 or 3 to select the SPI peripheral (configured in I2S mode).
//  287   * @param  I2S_InitStruct: pointer to an I2S_InitTypeDef structure that
//  288   *         contains the configuration information for the specified SPI peripheral
//  289   *         configured in I2S mode.
//  290   *           
//  291   * @note   The function calculates the optimal prescaler needed to obtain the most 
//  292   *         accurate audio frequency (depending on the I2S clock source, the PLL values 
//  293   *         and the product configuration). But in case the prescaler value is greater 
//  294   *         than 511, the default value (0x02) will be configured instead.    
//  295   * 
//  296   * @note   if an external clock is used as source clock for the I2S, then the define
//  297   *         I2S_EXTERNAL_CLOCK_VAL in file stm32f2xx_conf.h should be enabled and set
//  298   *         to the value of the the source clock frequency (in Hz).
//  299   *  
//  300   * @retval None
//  301   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function I2S_Init
        THUMB
//  302 void I2S_Init(SPI_TypeDef* SPIx, I2S_InitTypeDef* I2S_InitStruct)
//  303 {
I2S_Init:
        PUSH     {R4-R7}
        CFI R7 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  304   uint16_t tmpreg = 0, i2sdiv = 2, i2sodd = 0, packetlength = 1;
        MOVS     R3,#+1
//  305   uint32_t tmp = 0, i2sclk = 0;
//  306 #ifndef I2S_EXTERNAL_CLOCK_VAL
//  307   uint32_t pllm = 0, plln = 0, pllr = 0;
//  308 #endif /* I2S_EXTERNAL_CLOCK_VAL */
//  309   
//  310   /* Check the I2S parameters */
//  311   assert_param(IS_SPI_23_PERIPH(SPIx));
//  312   assert_param(IS_I2S_MODE(I2S_InitStruct->I2S_Mode));
//  313   assert_param(IS_I2S_STANDARD(I2S_InitStruct->I2S_Standard));
//  314   assert_param(IS_I2S_DATA_FORMAT(I2S_InitStruct->I2S_DataFormat));
//  315   assert_param(IS_I2S_MCLK_OUTPUT(I2S_InitStruct->I2S_MCLKOutput));
//  316   assert_param(IS_I2S_AUDIO_FREQ(I2S_InitStruct->I2S_AudioFreq));
//  317   assert_param(IS_I2S_CPOL(I2S_InitStruct->I2S_CPOL));  
//  318 
//  319 /*----------------------- SPIx I2SCFGR & I2SPR Configuration -----------------*/
//  320   /* Clear I2SMOD, I2SE, I2SCFG, PCMSYNC, I2SSTD, CKPOL, DATLEN and CHLEN bits */
//  321   SPIx->I2SCFGR &= I2SCFGR_CLEAR_MASK; 
        LDRH     R2,[R0, #+28]
        MOVW     R4,#+61504
        ANDS     R2,R4,R2
        STRH     R2,[R0, #+28]
//  322   SPIx->I2SPR = 0x0002;
        MOVS     R2,#+2
        STRH     R2,[R0, #+32]
//  323   
//  324   /* Get the I2SCFGR register value */
//  325   tmpreg = SPIx->I2SCFGR;
        LDRH     R2,[R0, #+28]
//  326   
//  327   /* If the default value has to be written, reinitialize i2sdiv and i2sodd*/
//  328   if(I2S_InitStruct->I2S_AudioFreq == I2S_AudioFreq_Default)
        LDR      R4,[R1, #+8]
        CMP      R4,#+2
        IT       EQ 
        MOVEQ    R3,#+0
//  329   {
//  330     i2sodd = (uint16_t)0;
//  331     i2sdiv = (uint16_t)2;   
        BEQ.N    ??I2S_Init_0
//  332   }
//  333   /* If the requested audio frequency is not the default, compute the prescaler */
//  334   else
//  335   {
//  336     /* Check the frame length (For the Prescaler computing) *******************/
//  337     if(I2S_InitStruct->I2S_DataFormat == I2S_DataFormat_16b)
        LDRH     R4,[R1, #+4]
        CBZ.N    R4,??I2S_Init_1
//  338     {
//  339       /* Packet length is 16 bits */
//  340       packetlength = 1;
//  341     }
//  342     else
//  343     {
//  344       /* Packet length is 32 bits */
//  345       packetlength = 2;
        MOVS     R3,#+2
//  346     }
//  347 
//  348     /* Get I2S source Clock frequency (only in Silicon RevisionB and RevisionY) */
//  349       
//  350     /* If an external I2S clock has to be used, this define should be set  
//  351        in the project configuration or in the stm32f2xx_conf.h file */
//  352   #ifdef I2S_EXTERNAL_CLOCK_VAL     
//  353     /* Set external clock as I2S clock source */
//  354     if ((RCC->CFGR & RCC_CFGR_I2SSRC) == 0)
//  355     {
//  356       RCC->CFGR |= (uint32_t)RCC_CFGR_I2SSRC;
//  357     }
//  358     
//  359     /* Set the I2S clock to the external clock  value */
//  360     i2sclk = I2S_EXTERNAL_CLOCK_VAL;
//  361 
//  362   #else /* There is no define for External I2S clock source */
//  363     /* Set PLLI2S as I2S clock source */
//  364     if ((RCC->CFGR & RCC_CFGR_I2SSRC) != 0)
??I2S_Init_1:
        LDR.N    R4,??DataTable2_4  ;; 0x40023804
        LDR      R5,[R4, #+4]
        LSLS     R5,R5,#+8
        BPL.N    ??I2S_Init_2
//  365     {
//  366       RCC->CFGR &= ~(uint32_t)RCC_CFGR_I2SSRC;
        LDR      R5,[R4, #+4]
        BIC      R5,R5,#0x800000
        STR      R5,[R4, #+4]
//  367     }    
//  368     
//  369     /* Get the PLLI2SN value */
//  370     plln = (uint32_t)(((RCC->PLLI2SCFGR & RCC_PLLI2SCFGR_PLLI2SN) >> 6) & \ 
//  371                       (RCC_PLLI2SCFGR_PLLI2SN >> 6));
??I2S_Init_2:
        LDR.N    R5,??DataTable2_5  ;; 0x40023884
        LDR      R6,[R5, #+0]
//  372     
//  373     /* Get the PLLI2SR value */
//  374     pllr = (uint32_t)(((RCC->PLLI2SCFGR & RCC_PLLI2SCFGR_PLLI2SR) >> 28) & \ 
//  375                       (RCC_PLLI2SCFGR_PLLI2SR >> 28));
        LDR      R5,[R5, #+0]
//  376     
//  377     /* Get the PLLM value */
//  378     pllm = (uint32_t)(RCC->PLLCFGR & RCC_PLLCFGR_PLLM);      
        LDR      R4,[R4, #+0]
//  379     
//  380     /* Get the I2S source clock value */
//  381     i2sclk = (uint32_t)(((HSE_VALUE / pllm) * plln) / pllr);
        LDR.N    R7,??DataTable2_6  ;; 0x17d7840
        AND      R4,R4,#0x3F
        UDIV     R4,R7,R4
        UBFX     R6,R6,#+6,#+9
        MULS     R4,R6,R4
        UBFX     R5,R5,#+28,#+3
        UDIV     R5,R4,R5
//  382   #endif /* I2S_EXTERNAL_CLOCK_VAL */
//  383     
//  384     /* Compute the Real divider depending on the MCLK output state, with a floating point */
//  385     if(I2S_InitStruct->I2S_MCLKOutput == I2S_MCLKOutput_Enable)
        LDR      R4,[R1, #+8]
        LDRH     R6,[R1, #+6]
        MOV      R7,#+512
        CMP      R6,R7
        ITEE     EQ 
        LSREQ    R3,R5,#+8
        LSLNE    R3,R3,#+5
        UDIVNE   R3,R5,R3
//  386     {
//  387       /* MCLK output is enabled */
//  388       tmp = (uint16_t)(((((i2sclk / 256) * 10) / I2S_InitStruct->I2S_AudioFreq)) + 5);
//  389     }
//  390     else
//  391     {
//  392       /* MCLK output is disabled */
//  393       tmp = (uint16_t)(((((i2sclk / (32 * packetlength)) *10 ) / I2S_InitStruct->I2S_AudioFreq)) + 5);
        ADD      R5,R3,R3, LSL #+2
        LSLS     R3,R5,#+1
        UDIV     R3,R3,R4
        ADDS     R3,R3,#+5
        UXTH     R3,R3
//  394     }
//  395     
//  396     /* Remove the flatting point */
//  397     tmp = tmp / 10;  
        MOVS     R4,#+10
        UDIV     R3,R3,R4
//  398       
//  399     /* Check the parity of the divider */
//  400     i2sodd = (uint16_t)(tmp & (uint16_t)0x0001);
        AND      R5,R3,#0x1
//  401    
//  402     /* Compute the i2sdiv prescaler */
//  403     i2sdiv = (uint16_t)((tmp - i2sodd) / 2);
        SUBS     R3,R3,R5
        LSRS     R4,R3,#+1
        UXTH     R4,R4
//  404    
//  405     /* Get the Mask for the Odd bit (SPI_I2SPR[8]) register */
//  406     i2sodd = (uint16_t) (i2sodd << 8);
        LSLS     R3,R5,#+8
//  407   }
//  408 
//  409   /* Test if the divider is 1 or 0 or greater than 0xFF */
//  410   if ((i2sdiv < 2) || (i2sdiv > 0xFF))
??I2S_Init_0:
        SUBS     R5,R4,#+2
        CMP      R5,#+254
        ITT      CS 
        MOVCS    R4,#+2
        MOVCS    R3,#+0
//  411   {
//  412     /* Set the default values */
//  413     i2sdiv = 2;
//  414     i2sodd = 0;
//  415   }
//  416 
//  417   /* Write to SPIx I2SPR register the computed value */
//  418   SPIx->I2SPR = (uint16_t)((uint16_t)i2sdiv | (uint16_t)(i2sodd | (uint16_t)I2S_InitStruct->I2S_MCLKOutput));
        ORRS     R3,R3,R4
        LDRH     R4,[R1, #+6]
        ORRS     R3,R4,R3
        STRH     R3,[R0, #+32]
//  419  
//  420   /* Configure the I2S with the SPI_InitStruct values */
//  421   tmpreg |= (uint16_t)((uint16_t)SPI_I2SCFGR_I2SMOD | (uint16_t)(I2S_InitStruct->I2S_Mode | \ 
//  422                   (uint16_t)(I2S_InitStruct->I2S_Standard | (uint16_t)(I2S_InitStruct->I2S_DataFormat | \ 
//  423                   (uint16_t)I2S_InitStruct->I2S_CPOL))));
//  424  
//  425   /* Write to SPIx I2SCFGR */  
//  426   SPIx->I2SCFGR = tmpreg;
        LDRH     R3,[R1, #+0]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+2]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+4]
        ORRS     R2,R3,R2
        LDRH     R1,[R1, #+12]
        ORRS     R1,R1,R2
        ORR      R1,R1,#0x800
        STRH     R1,[R0, #+28]
//  427 }
        POP      {R4-R7}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0x40013000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     0x40003800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     0x40003c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     0x40023844

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0x40023804

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     0x40023884

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     0x17d7840
//  428 
//  429 /**
//  430   * @brief  Fills each SPI_InitStruct member with its default value.
//  431   * @param  SPI_InitStruct: pointer to a SPI_InitTypeDef structure which will be initialized.
//  432   * @retval None
//  433   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function SPI_StructInit
        THUMB
//  434 void SPI_StructInit(SPI_InitTypeDef* SPI_InitStruct)
//  435 {
//  436 /*--------------- Reset SPI init structure parameters values -----------------*/
//  437   /* Initialize the SPI_Direction member */
//  438   SPI_InitStruct->SPI_Direction = SPI_Direction_2Lines_FullDuplex;
SPI_StructInit:
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  439   /* initialize the SPI_Mode member */
//  440   SPI_InitStruct->SPI_Mode = SPI_Mode_Slave;
        STRH     R1,[R0, #+2]
//  441   /* initialize the SPI_DataSize member */
//  442   SPI_InitStruct->SPI_DataSize = SPI_DataSize_8b;
        STRH     R1,[R0, #+4]
//  443   /* Initialize the SPI_CPOL member */
//  444   SPI_InitStruct->SPI_CPOL = SPI_CPOL_Low;
        STRH     R1,[R0, #+6]
//  445   /* Initialize the SPI_CPHA member */
//  446   SPI_InitStruct->SPI_CPHA = SPI_CPHA_1Edge;
        STRH     R1,[R0, #+8]
//  447   /* Initialize the SPI_NSS member */
//  448   SPI_InitStruct->SPI_NSS = SPI_NSS_Hard;
        STRH     R1,[R0, #+10]
//  449   /* Initialize the SPI_BaudRatePrescaler member */
//  450   SPI_InitStruct->SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_2;
        STRH     R1,[R0, #+12]
//  451   /* Initialize the SPI_FirstBit member */
//  452   SPI_InitStruct->SPI_FirstBit = SPI_FirstBit_MSB;
        STRH     R1,[R0, #+14]
//  453   /* Initialize the SPI_CRCPolynomial member */
//  454   SPI_InitStruct->SPI_CRCPolynomial = 7;
        MOVS     R1,#+7
        STRH     R1,[R0, #+16]
//  455 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  456 
//  457 /**
//  458   * @brief  Fills each I2S_InitStruct member with its default value.
//  459   * @param  I2S_InitStruct: pointer to a I2S_InitTypeDef structure which will be initialized.
//  460   * @retval None
//  461   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function I2S_StructInit
        THUMB
//  462 void I2S_StructInit(I2S_InitTypeDef* I2S_InitStruct)
//  463 {
//  464 /*--------------- Reset I2S init structure parameters values -----------------*/
//  465   /* Initialize the I2S_Mode member */
//  466   I2S_InitStruct->I2S_Mode = I2S_Mode_SlaveTx;
I2S_StructInit:
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  467   
//  468   /* Initialize the I2S_Standard member */
//  469   I2S_InitStruct->I2S_Standard = I2S_Standard_Phillips;
        STRH     R1,[R0, #+2]
//  470   
//  471   /* Initialize the I2S_DataFormat member */
//  472   I2S_InitStruct->I2S_DataFormat = I2S_DataFormat_16b;
        STRH     R1,[R0, #+4]
//  473   
//  474   /* Initialize the I2S_MCLKOutput member */
//  475   I2S_InitStruct->I2S_MCLKOutput = I2S_MCLKOutput_Disable;
        STRH     R1,[R0, #+6]
//  476   
//  477   /* Initialize the I2S_AudioFreq member */
//  478   I2S_InitStruct->I2S_AudioFreq = I2S_AudioFreq_Default;
        MOVS     R1,#+2
        STR      R1,[R0, #+8]
//  479   
//  480   /* Initialize the I2S_CPOL member */
//  481   I2S_InitStruct->I2S_CPOL = I2S_CPOL_Low;
        MOVS     R1,#+0
        STRH     R1,[R0, #+12]
//  482 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  483 
//  484 /**
//  485   * @brief  Enables or disables the specified SPI peripheral.
//  486   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  487   * @param  NewState: new state of the SPIx peripheral. 
//  488   *          This parameter can be: ENABLE or DISABLE.
//  489   * @retval None
//  490   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SPI_Cmd
        THUMB
//  491 void SPI_Cmd(SPI_TypeDef* SPIx, FunctionalState NewState)
//  492 {
//  493   /* Check the parameters */
//  494   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  495   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  496   if (NewState != DISABLE)
SPI_Cmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+0]
        ITEE     NE 
        ORRNE    R1,R1,#0x40
        MOVWEQ   R2,#+65471
        ANDEQ    R1,R2,R1
//  497   {
//  498     /* Enable the selected SPI peripheral */
//  499     SPIx->CR1 |= SPI_CR1_SPE;
//  500   }
//  501   else
//  502   {
//  503     /* Disable the selected SPI peripheral */
//  504     SPIx->CR1 &= (uint16_t)~((uint16_t)SPI_CR1_SPE);
        STRH     R1,[R0, #+0]
//  505   }
//  506 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  507 
//  508 /**
//  509   * @brief  Enables or disables the specified SPI peripheral (in I2S mode).
//  510   * @param  SPIx: where x can be 2 or 3 to select the SPI peripheral.
//  511   * @param  NewState: new state of the SPIx peripheral. 
//  512   *         This parameter can be: ENABLE or DISABLE.
//  513   * @retval None
//  514   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function I2S_Cmd
        THUMB
//  515 void I2S_Cmd(SPI_TypeDef* SPIx, FunctionalState NewState)
//  516 {
//  517   /* Check the parameters */
//  518   assert_param(IS_SPI_23_PERIPH(SPIx));
//  519   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  520   
//  521   if (NewState != DISABLE)
I2S_Cmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+28]
        ITEE     NE 
        ORRNE    R1,R1,#0x400
        MOVWEQ   R2,#+64511
        ANDEQ    R1,R2,R1
//  522   {
//  523     /* Enable the selected SPI peripheral (in I2S mode) */
//  524     SPIx->I2SCFGR |= SPI_I2SCFGR_I2SE;
//  525   }
//  526   else
//  527   {
//  528     /* Disable the selected SPI peripheral in I2S mode */
//  529     SPIx->I2SCFGR &= (uint16_t)~((uint16_t)SPI_I2SCFGR_I2SE);
        STRH     R1,[R0, #+28]
//  530   }
//  531 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  532 
//  533 /**
//  534   * @brief  Configures the data size for the selected SPI.
//  535   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  536   * @param  SPI_DataSize: specifies the SPI data size.
//  537   *          This parameter can be one of the following values:
//  538   *            @arg SPI_DataSize_16b: Set data frame format to 16bit
//  539   *            @arg SPI_DataSize_8b: Set data frame format to 8bit
//  540   * @retval None
//  541   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SPI_DataSizeConfig
        THUMB
//  542 void SPI_DataSizeConfig(SPI_TypeDef* SPIx, uint16_t SPI_DataSize)
//  543 {
//  544   /* Check the parameters */
//  545   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  546   assert_param(IS_SPI_DATASIZE(SPI_DataSize));
//  547   /* Clear DFF bit */
//  548   SPIx->CR1 &= (uint16_t)~SPI_DataSize_16b;
SPI_DataSizeConfig:
        LDRH     R2,[R0, #+0]
        MOVW     R3,#+63487
        ANDS     R2,R3,R2
        STRH     R2,[R0, #+0]
//  549   /* Set new DFF bit value */
//  550   SPIx->CR1 |= SPI_DataSize;
        LDRH     R2,[R0, #+0]
        ORRS     R1,R1,R2
        STRH     R1,[R0, #+0]
//  551 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  552 
//  553 /**
//  554   * @brief  Selects the data transfer direction in bidirectional mode for the specified SPI.
//  555   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  556   * @param  SPI_Direction: specifies the data transfer direction in bidirectional mode. 
//  557   *          This parameter can be one of the following values:
//  558   *            @arg SPI_Direction_Tx: Selects Tx transmission direction
//  559   *            @arg SPI_Direction_Rx: Selects Rx receive direction
//  560   * @retval None
//  561   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function SPI_BiDirectionalLineConfig
        THUMB
//  562 void SPI_BiDirectionalLineConfig(SPI_TypeDef* SPIx, uint16_t SPI_Direction)
//  563 {
//  564   /* Check the parameters */
//  565   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  566   assert_param(IS_SPI_DIRECTION(SPI_Direction));
//  567   if (SPI_Direction == SPI_Direction_Tx)
SPI_BiDirectionalLineConfig:
        CMP      R1,#+16384
        LDRH     R1,[R0, #+0]
        ITEE     EQ 
        ORREQ    R1,R1,#0x4000
        MOVWNE   R2,#+49151
        ANDNE    R1,R2,R1
//  568   {
//  569     /* Set the Tx only mode */
//  570     SPIx->CR1 |= SPI_Direction_Tx;
//  571   }
//  572   else
//  573   {
//  574     /* Set the Rx only mode */
//  575     SPIx->CR1 &= SPI_Direction_Rx;
        STRH     R1,[R0, #+0]
//  576   }
//  577 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  578 
//  579 /**
//  580   * @brief  Configures internally by software the NSS pin for the selected SPI.
//  581   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  582   * @param  SPI_NSSInternalSoft: specifies the SPI NSS internal state.
//  583   *          This parameter can be one of the following values:
//  584   *            @arg SPI_NSSInternalSoft_Set: Set NSS pin internally
//  585   *            @arg SPI_NSSInternalSoft_Reset: Reset NSS pin internally
//  586   * @retval None
//  587   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function SPI_NSSInternalSoftwareConfig
        THUMB
//  588 void SPI_NSSInternalSoftwareConfig(SPI_TypeDef* SPIx, uint16_t SPI_NSSInternalSoft)
//  589 {
//  590   /* Check the parameters */
//  591   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  592   assert_param(IS_SPI_NSS_INTERNAL(SPI_NSSInternalSoft));
//  593   if (SPI_NSSInternalSoft != SPI_NSSInternalSoft_Reset)
SPI_NSSInternalSoftwareConfig:
        MOVW     R2,#+65279
        CMP      R1,R2
        LDRH     R1,[R0, #+0]
        ITTE     NE 
        MOVNE    R2,#+256
        ORRNE    R1,R2,R1
        ANDEQ    R1,R2,R1
//  594   {
//  595     /* Set NSS pin internally by software */
//  596     SPIx->CR1 |= SPI_NSSInternalSoft_Set;
//  597   }
//  598   else
//  599   {
//  600     /* Reset NSS pin internally by software */
//  601     SPIx->CR1 &= SPI_NSSInternalSoft_Reset;
        STRH     R1,[R0, #+0]
//  602   }
//  603 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  604 
//  605 /**
//  606   * @brief  Enables or disables the SS output for the selected SPI.
//  607   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  608   * @param  NewState: new state of the SPIx SS output. 
//  609   *          This parameter can be: ENABLE or DISABLE.
//  610   * @retval None
//  611   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function SPI_SSOutputCmd
        THUMB
//  612 void SPI_SSOutputCmd(SPI_TypeDef* SPIx, FunctionalState NewState)
//  613 {
//  614   /* Check the parameters */
//  615   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  616   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  617   if (NewState != DISABLE)
SPI_SSOutputCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+4]
        ITEE     NE 
        ORRNE    R1,R1,#0x4
        MOVWEQ   R2,#+65531
        ANDEQ    R1,R2,R1
//  618   {
//  619     /* Enable the selected SPI SS output */
//  620     SPIx->CR2 |= (uint16_t)SPI_CR2_SSOE;
//  621   }
//  622   else
//  623   {
//  624     /* Disable the selected SPI SS output */
//  625     SPIx->CR2 &= (uint16_t)~((uint16_t)SPI_CR2_SSOE);
        STRH     R1,[R0, #+4]
//  626   }
//  627 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  628 
//  629 /**
//  630   * @brief  Enables or disables the SPIx/I2Sx DMA interface.
//  631   *   
//  632   * @note   This function can be called only after the SPI_Init() function has 
//  633   *         been called. 
//  634   * @note   When TI mode is selected, the control bits SSM, SSI, CPOL and CPHA 
//  635   *         are not taken into consideration and are configured by hardware
//  636   *         respectively to the TI mode requirements.  
//  637   * 
//  638   * @param  SPIx: where x can be 1, 2 or 3 
//  639   * @param  NewState: new state of the selected SPI TI communication mode.
//  640   *          This parameter can be: ENABLE or DISABLE.
//  641   * @retval None
//  642   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function SPI_TIModeCmd
        THUMB
//  643 void SPI_TIModeCmd(SPI_TypeDef* SPIx, FunctionalState NewState)
//  644 {
//  645   /* Check the parameters */
//  646   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  647   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  648 
//  649   if (NewState != DISABLE)
SPI_TIModeCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+4]
        ITEE     NE 
        ORRNE    R1,R1,#0x10
        MOVWEQ   R2,#+65519
        ANDEQ    R1,R2,R1
//  650   {
//  651     /* Enable the TI mode for the selected SPI peripheral */
//  652     SPIx->CR2 |= SPI_CR2_FRF;
//  653   }
//  654   else
//  655   {
//  656     /* Disable the TI mode for the selected SPI peripheral */
//  657     SPIx->CR2 &= (uint16_t)~SPI_CR2_FRF;
        STRH     R1,[R0, #+4]
//  658   }
//  659 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  660 
//  661 /**
//  662   * @}
//  663   */
//  664 
//  665 /** @defgroup SPI_Group2 Data transfers functions
//  666  *  @brief   Data transfers functions
//  667  *
//  668 @verbatim   
//  669  ===============================================================================
//  670                          Data transfers functions
//  671  ===============================================================================  
//  672 
//  673   This section provides a set of functions allowing to manage the SPI data transfers
//  674   
//  675   In reception, data are received and then stored into an internal Rx buffer while 
//  676   In transmission, data are first stored into an internal Tx buffer before being 
//  677   transmitted.
//  678 
//  679   The read access of the SPI_DR register can be done using the SPI_I2S_ReceiveData()
//  680   function and returns the Rx buffered value. Whereas a write access to the SPI_DR 
//  681   can be done using SPI_I2S_SendData() function and stores the written data into 
//  682   Tx buffer.
//  683 
//  684 @endverbatim
//  685   * @{
//  686   */
//  687 
//  688 /**
//  689   * @brief  Returns the most recent received data by the SPIx/I2Sx peripheral. 
//  690   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
//  691   *         in SPI mode or 2 or 3 in I2S mode. 
//  692   * @retval The value of the received data.
//  693   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function SPI_I2S_ReceiveData
        THUMB
//  694 uint16_t SPI_I2S_ReceiveData(SPI_TypeDef* SPIx)
//  695 {
//  696   /* Check the parameters */
//  697   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  698   
//  699   /* Return the data in the DR register */
//  700   return SPIx->DR;
SPI_I2S_ReceiveData:
        LDRH     R0,[R0, #+12]
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  701 }
//  702 
//  703 /**
//  704   * @brief  Transmits a Data through the SPIx/I2Sx peripheral.
//  705   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
//  706   *         in SPI mode or 2 or 3 in I2S mode.     
//  707   * @param  Data: Data to be transmitted.
//  708   * @retval None
//  709   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function SPI_I2S_SendData
        THUMB
//  710 void SPI_I2S_SendData(SPI_TypeDef* SPIx, uint16_t Data)
//  711 {
//  712   /* Check the parameters */
//  713   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  714   
//  715   /* Write in the DR register the data to be sent */
//  716   SPIx->DR = Data;
SPI_I2S_SendData:
        STRH     R1,[R0, #+12]
//  717 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  718 
//  719 /**
//  720   * @}
//  721   */
//  722 
//  723 /** @defgroup SPI_Group3 Hardware CRC Calculation functions
//  724  *  @brief   Hardware CRC Calculation functions
//  725  *
//  726 @verbatim   
//  727  ===============================================================================
//  728                          Hardware CRC Calculation functions
//  729  ===============================================================================  
//  730 
//  731   This section provides a set of functions allowing to manage the SPI CRC hardware 
//  732   calculation
//  733 
//  734   SPI communication using CRC is possible through the following procedure:
//  735      1. Program the Data direction, Polarity, Phase, First Data, Baud Rate Prescaler, 
//  736         Slave Management, Peripheral Mode and CRC Polynomial values using the SPI_Init()
//  737         function.
//  738      2. Enable the CRC calculation using the SPI_CalculateCRC() function.
//  739      3. Enable the SPI using the SPI_Cmd() function
//  740      4. Before writing the last data to the TX buffer, set the CRCNext bit using the 
//  741       SPI_TransmitCRC() function to indicate that after transmission of the last 
//  742       data, the CRC should be transmitted.
//  743      5. After transmitting the last data, the SPI transmits the CRC. The SPI_CR1_CRCNEXT
//  744         bit is reset. The CRC is also received and compared against the SPI_RXCRCR 
//  745         value. 
//  746         If the value does not match, the SPI_FLAG_CRCERR flag is set and an interrupt
//  747         can be generated when the SPI_I2S_IT_ERR interrupt is enabled.
//  748 
//  749 @note It is advised not to read the calculated CRC values during the communication.
//  750 
//  751 @note When the SPI is in slave mode, be careful to enable CRC calculation only 
//  752       when the clock is stable, that is, when the clock is in the steady state. 
//  753       If not, a wrong CRC calculation may be done. In fact, the CRC is sensitive 
//  754       to the SCK slave input clock as soon as CRCEN is set, and this, whatever 
//  755       the value of the SPE bit.
//  756 
//  757 @note With high bitrate frequencies, be careful when transmitting the CRC.
//  758       As the number of used CPU cycles has to be as low as possible in the CRC 
//  759       transfer phase, it is forbidden to call software functions in the CRC 
//  760       transmission sequence to avoid errors in the last data and CRC reception. 
//  761       In fact, CRCNEXT bit has to be written before the end of the transmission/reception 
//  762       of the last data.
//  763 
//  764 @note For high bit rate frequencies, it is advised to use the DMA mode to avoid the
//  765       degradation of the SPI speed performance due to CPU accesses impacting the 
//  766       SPI bandwidth.
//  767 
//  768 @note When the STM32F2xx is configured as slave and the NSS hardware mode is 
//  769       used, the NSS pin needs to be kept low between the data phase and the CRC 
//  770       phase.
//  771 
//  772 @note When the SPI is configured in slave mode with the CRC feature enabled, CRC
//  773       calculation takes place even if a high level is applied on the NSS pin. 
//  774       This may happen for example in case of a multi-slave environment where the 
//  775       communication master addresses slaves alternately.
//  776 
//  777 @note Between a slave de-selection (high level on NSS) and a new slave selection 
//  778       (low level on NSS), the CRC value should be cleared on both master and slave
//  779       sides in order to resynchronize the master and slave for their respective 
//  780       CRC calculation.
//  781 
//  782 @note To clear the CRC, follow the procedure below:
//  783         1. Disable SPI using the SPI_Cmd() function
//  784         2. Disable the CRC calculation using the SPI_CalculateCRC() function.
//  785         3. Enable the CRC calculation using the SPI_CalculateCRC() function.
//  786         4. Enable SPI using the SPI_Cmd() function.
//  787 
//  788 @endverbatim
//  789   * @{
//  790   */
//  791 
//  792 /**
//  793   * @brief  Enables or disables the CRC value calculation of the transferred bytes.
//  794   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  795   * @param  NewState: new state of the SPIx CRC value calculation.
//  796   *          This parameter can be: ENABLE or DISABLE.
//  797   * @retval None
//  798   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function SPI_CalculateCRC
        THUMB
//  799 void SPI_CalculateCRC(SPI_TypeDef* SPIx, FunctionalState NewState)
//  800 {
//  801   /* Check the parameters */
//  802   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  803   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  804   if (NewState != DISABLE)
SPI_CalculateCRC:
        CMP      R1,#+0
        LDRH     R1,[R0, #+0]
        ITEE     NE 
        ORRNE    R1,R1,#0x2000
        MOVWEQ   R2,#+57343
        ANDEQ    R1,R2,R1
//  805   {
//  806     /* Enable the selected SPI CRC calculation */
//  807     SPIx->CR1 |= SPI_CR1_CRCEN;
//  808   }
//  809   else
//  810   {
//  811     /* Disable the selected SPI CRC calculation */
//  812     SPIx->CR1 &= (uint16_t)~((uint16_t)SPI_CR1_CRCEN);
        STRH     R1,[R0, #+0]
//  813   }
//  814 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  815 
//  816 /**
//  817   * @brief  Transmit the SPIx CRC value.
//  818   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  819   * @retval None
//  820   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function SPI_TransmitCRC
        THUMB
//  821 void SPI_TransmitCRC(SPI_TypeDef* SPIx)
//  822 {
//  823   /* Check the parameters */
//  824   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  825   
//  826   /* Enable the selected SPI CRC transmission */
//  827   SPIx->CR1 |= SPI_CR1_CRCNEXT;
SPI_TransmitCRC:
        LDRH     R1,[R0, #+0]
        ORR      R1,R1,#0x1000
        STRH     R1,[R0, #+0]
//  828 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  829 
//  830 /**
//  831   * @brief  Returns the transmit or the receive CRC register value for the specified SPI.
//  832   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  833   * @param  SPI_CRC: specifies the CRC register to be read.
//  834   *          This parameter can be one of the following values:
//  835   *            @arg SPI_CRC_Tx: Selects Tx CRC register
//  836   *            @arg SPI_CRC_Rx: Selects Rx CRC register
//  837   * @retval The selected CRC register value..
//  838   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function SPI_GetCRC
        THUMB
//  839 uint16_t SPI_GetCRC(SPI_TypeDef* SPIx, uint8_t SPI_CRC)
//  840 {
//  841   uint16_t crcreg = 0;
//  842   /* Check the parameters */
//  843   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  844   assert_param(IS_SPI_CRC(SPI_CRC));
//  845   if (SPI_CRC != SPI_CRC_Rx)
SPI_GetCRC:
        CMP      R1,#+1
        ITE      NE 
        LDRHNE   R0,[R0, #+24]
        LDRHEQ   R0,[R0, #+20]
//  846   {
//  847     /* Get the Tx CRC register */
//  848     crcreg = SPIx->TXCRCR;
        BX       LR
        CFI EndBlock cfiBlock17
//  849   }
//  850   else
//  851   {
//  852     /* Get the Rx CRC register */
//  853     crcreg = SPIx->RXCRCR;
//  854   }
//  855   /* Return the selected CRC register */
//  856   return crcreg;
//  857 }
//  858 
//  859 /**
//  860   * @brief  Returns the CRC Polynomial register value for the specified SPI.
//  861   * @param  SPIx: where x can be 1, 2 or 3 to select the SPI peripheral.
//  862   * @retval The CRC Polynomial register value.
//  863   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function SPI_GetCRCPolynomial
        THUMB
//  864 uint16_t SPI_GetCRCPolynomial(SPI_TypeDef* SPIx)
//  865 {
//  866   /* Check the parameters */
//  867   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  868   
//  869   /* Return the CRC polynomial register */
//  870   return SPIx->CRCPR;
SPI_GetCRCPolynomial:
        LDRH     R0,[R0, #+16]
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//  871 }
//  872 
//  873 /**
//  874   * @}
//  875   */
//  876 
//  877 /** @defgroup SPI_Group4 DMA transfers management functions
//  878  *  @brief   DMA transfers management functions
//  879   *
//  880 @verbatim   
//  881  ===============================================================================
//  882                          DMA transfers management functions
//  883  ===============================================================================  
//  884 
//  885 @endverbatim
//  886   * @{
//  887   */
//  888 
//  889 /**
//  890   * @brief  Enables or disables the SPIx/I2Sx DMA interface.
//  891   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
//  892   *         in SPI mode or 2 or 3 in I2S mode. 
//  893   * @param  SPI_I2S_DMAReq: specifies the SPI DMA transfer request to be enabled or disabled. 
//  894   *          This parameter can be any combination of the following values:
//  895   *            @arg SPI_I2S_DMAReq_Tx: Tx buffer DMA transfer request
//  896   *            @arg SPI_I2S_DMAReq_Rx: Rx buffer DMA transfer request
//  897   * @param  NewState: new state of the selected SPI DMA transfer request.
//  898   *          This parameter can be: ENABLE or DISABLE.
//  899   * @retval None
//  900   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function SPI_I2S_DMACmd
        THUMB
//  901 void SPI_I2S_DMACmd(SPI_TypeDef* SPIx, uint16_t SPI_I2S_DMAReq, FunctionalState NewState)
//  902 {
//  903   /* Check the parameters */
//  904   assert_param(IS_SPI_ALL_PERIPH(SPIx));
//  905   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  906   assert_param(IS_SPI_I2S_DMAREQ(SPI_I2S_DMAReq));
//  907 
//  908   if (NewState != DISABLE)
SPI_I2S_DMACmd:
        CMP      R2,#+0
        LDRH     R2,[R0, #+4]
        ITE      NE 
        ORRNE    R1,R1,R2
        BICEQ    R1,R2,R1
//  909   {
//  910     /* Enable the selected SPI DMA requests */
//  911     SPIx->CR2 |= SPI_I2S_DMAReq;
//  912   }
//  913   else
//  914   {
//  915     /* Disable the selected SPI DMA requests */
//  916     SPIx->CR2 &= (uint16_t)~SPI_I2S_DMAReq;
        STRH     R1,[R0, #+4]
//  917   }
//  918 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//  919 
//  920 /**
//  921   * @}
//  922   */
//  923 
//  924 /** @defgroup SPI_Group5 Interrupts and flags management functions
//  925  *  @brief   Interrupts and flags management functions
//  926   *
//  927 @verbatim   
//  928  ===============================================================================
//  929                          Interrupts and flags management functions
//  930  ===============================================================================  
//  931 
//  932   This section provides a set of functions allowing to configure the SPI Interrupts 
//  933   sources and check or clear the flags or pending bits status.
//  934   The user should identify which mode will be used in his application to manage 
//  935   the communication: Polling mode, Interrupt mode or DMA mode. 
//  936     
//  937   Polling Mode
//  938   =============
//  939   In Polling Mode, the SPI/I2S communication can be managed by 9 flags:
//  940      1. SPI_I2S_FLAG_TXE : to indicate the status of the transmit buffer register
//  941      2. SPI_I2S_FLAG_RXNE : to indicate the status of the receive buffer register
//  942      3. SPI_I2S_FLAG_BSY : to indicate the state of the communication layer of the SPI.
//  943      4. SPI_FLAG_CRCERR : to indicate if a CRC Calculation error occur              
//  944      5. SPI_FLAG_MODF : to indicate if a Mode Fault error occur
//  945      6. SPI_I2S_FLAG_OVR : to indicate if an Overrun error occur
//  946      7. I2S_FLAG_TIFRFE: to indicate a Frame Format error occurs.
//  947      8. I2S_FLAG_UDR: to indicate an Underrun error occurs.
//  948      9. I2S_FLAG_CHSIDE: to indicate Channel Side.
//  949 
//  950 @note Do not use the BSY flag to handle each data transmission or reception.  It is
//  951       better to use the TXE and RXNE flags instead.
//  952 
//  953   In this Mode it is advised to use the following functions:
//  954      - FlagStatus SPI_I2S_GetFlagStatus(SPI_TypeDef* SPIx, uint16_t SPI_I2S_FLAG);
//  955      - void SPI_I2S_ClearFlag(SPI_TypeDef* SPIx, uint16_t SPI_I2S_FLAG);
//  956 
//  957   Interrupt Mode
//  958   ===============
//  959   In Interrupt Mode, the SPI communication can be managed by 3 interrupt sources
//  960   and 7 pending bits: 
//  961   Pending Bits:
//  962   ------------- 
//  963      1. SPI_I2S_IT_TXE : to indicate the status of the transmit buffer register
//  964      2. SPI_I2S_IT_RXNE : to indicate the status of the receive buffer register
//  965      3. SPI_IT_CRCERR : to indicate if a CRC Calculation error occur (available in SPI mode only)            
//  966      4. SPI_IT_MODF : to indicate if a Mode Fault error occur (available in SPI mode only)
//  967      5. SPI_I2S_IT_OVR : to indicate if an Overrun error occur
//  968      6. I2S_IT_UDR : to indicate an Underrun Error occurs (available in I2S mode only).
//  969      7. I2S_FLAG_TIFRFE : to indicate a Frame Format error occurs (available in TI mode only).
//  970 
//  971   Interrupt Source:
//  972   -----------------
//  973      1. SPI_I2S_IT_TXE: specifies the interrupt source for the Tx buffer empty 
//  974                         interrupt.  
//  975      2. SPI_I2S_IT_RXNE : specifies the interrupt source for the Rx buffer not 
//  976                           empty interrupt.
//  977      3. SPI_I2S_IT_ERR : specifies the interrupt source for the errors interrupt.
//  978 
//  979   In this Mode it is advised to use the following functions:
//  980      - void SPI_I2S_ITConfig(SPI_TypeDef* SPIx, uint8_t SPI_I2S_IT, FunctionalState NewState);
//  981      - ITStatus SPI_I2S_GetITStatus(SPI_TypeDef* SPIx, uint8_t SPI_I2S_IT);
//  982      - void SPI_I2S_ClearITPendingBit(SPI_TypeDef* SPIx, uint8_t SPI_I2S_IT);
//  983 
//  984   DMA Mode
//  985   ========
//  986   In DMA Mode, the SPI communication can be managed by 2 DMA Channel requests:
//  987      1. SPI_I2S_DMAReq_Tx: specifies the Tx buffer DMA transfer request
//  988      2. SPI_I2S_DMAReq_Rx: specifies the Rx buffer DMA transfer request
//  989 
//  990   In this Mode it is advised to use the following function:
//  991     - void SPI_I2S_DMACmd(SPI_TypeDef* SPIx, uint16_t SPI_I2S_DMAReq, FunctionalState NewState);
//  992 
//  993 @endverbatim
//  994   * @{
//  995   */
//  996 
//  997 /**
//  998   * @brief  Enables or disables the specified SPI/I2S interrupts.
//  999   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
// 1000   *         in SPI mode or 2 or 3 in I2S mode.  
// 1001   * @param  SPI_I2S_IT: specifies the SPI interrupt source to be enabled or disabled. 
// 1002   *          This parameter can be one of the following values:
// 1003   *            @arg SPI_I2S_IT_TXE: Tx buffer empty interrupt mask
// 1004   *            @arg SPI_I2S_IT_RXNE: Rx buffer not empty interrupt mask
// 1005   *            @arg SPI_I2S_IT_ERR: Error interrupt mask
// 1006   * @param  NewState: new state of the specified SPI interrupt.
// 1007   *          This parameter can be: ENABLE or DISABLE.
// 1008   * @retval None
// 1009   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function SPI_I2S_ITConfig
        THUMB
// 1010 void SPI_I2S_ITConfig(SPI_TypeDef* SPIx, uint8_t SPI_I2S_IT, FunctionalState NewState)
// 1011 {
// 1012   uint16_t itpos = 0, itmask = 0 ;
// 1013   
// 1014   /* Check the parameters */
// 1015   assert_param(IS_SPI_ALL_PERIPH(SPIx));
// 1016   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1017   assert_param(IS_SPI_I2S_CONFIG_IT(SPI_I2S_IT));
// 1018 
// 1019   /* Get the SPI IT index */
// 1020   itpos = SPI_I2S_IT >> 4;
// 1021 
// 1022   /* Set the IT mask */
// 1023   itmask = (uint16_t)1 << (uint16_t)itpos;
SPI_I2S_ITConfig:
        MOVS     R3,#+1
        LSRS     R1,R1,#+4
        LSL      R1,R3,R1
        UXTH     R1,R1
// 1024 
// 1025   if (NewState != DISABLE)
        CMP      R2,#+0
        LDRH     R2,[R0, #+4]
        ITE      NE 
        ORRNE    R1,R1,R2
        BICEQ    R1,R2,R1
// 1026   {
// 1027     /* Enable the selected SPI interrupt */
// 1028     SPIx->CR2 |= itmask;
// 1029   }
// 1030   else
// 1031   {
// 1032     /* Disable the selected SPI interrupt */
// 1033     SPIx->CR2 &= (uint16_t)~itmask;
        STRH     R1,[R0, #+4]
// 1034   }
// 1035 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock20
// 1036 
// 1037 /**
// 1038   * @brief  Checks whether the specified SPIx/I2Sx flag is set or not.
// 1039   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
// 1040   *         in SPI mode or 2 or 3 in I2S mode. 
// 1041   * @param  SPI_I2S_FLAG: specifies the SPI flag to check. 
// 1042   *          This parameter can be one of the following values:
// 1043   *            @arg SPI_I2S_FLAG_TXE: Transmit buffer empty flag.
// 1044   *            @arg SPI_I2S_FLAG_RXNE: Receive buffer not empty flag.
// 1045   *            @arg SPI_I2S_FLAG_BSY: Busy flag.
// 1046   *            @arg SPI_I2S_FLAG_OVR: Overrun flag.
// 1047   *            @arg SPI_FLAG_MODF: Mode Fault flag.
// 1048   *            @arg SPI_FLAG_CRCERR: CRC Error flag.
// 1049   *            @arg SPI_I2S_FLAG_TIFRFE: Format Error.
// 1050   *            @arg I2S_FLAG_UDR: Underrun Error flag.
// 1051   *            @arg I2S_FLAG_CHSIDE: Channel Side flag.  
// 1052   * @retval The new state of SPI_I2S_FLAG (SET or RESET).
// 1053   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function SPI_I2S_GetFlagStatus
        THUMB
// 1054 FlagStatus SPI_I2S_GetFlagStatus(SPI_TypeDef* SPIx, uint16_t SPI_I2S_FLAG)
// 1055 {
// 1056   FlagStatus bitstatus = RESET;
SPI_I2S_GetFlagStatus:
        MOVS     R2,#+0
// 1057   /* Check the parameters */
// 1058   assert_param(IS_SPI_ALL_PERIPH(SPIx));
// 1059   assert_param(IS_SPI_I2S_GET_FLAG(SPI_I2S_FLAG));
// 1060   
// 1061   /* Check the status of the specified SPI flag */
// 1062   if ((SPIx->SR & SPI_I2S_FLAG) != (uint16_t)RESET)
        LDRH     R0,[R0, #+8]
        TST      R0,R1
        IT       NE 
        MOVNE    R2,#+1
// 1063   {
// 1064     /* SPI_I2S_FLAG is set */
// 1065     bitstatus = SET;
// 1066   }
// 1067   else
// 1068   {
// 1069     /* SPI_I2S_FLAG is reset */
// 1070     bitstatus = RESET;
// 1071   }
// 1072   /* Return the SPI_I2S_FLAG status */
// 1073   return  bitstatus;
        MOV      R0,R2
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
// 1074 }
// 1075 
// 1076 /**
// 1077   * @brief  Clears the SPIx CRC Error (CRCERR) flag.
// 1078   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
// 1079   *         in SPI mode or 2 or 3 in I2S mode. 
// 1080   * @param  SPI_I2S_FLAG: specifies the SPI flag to clear. 
// 1081   *          This function clears only CRCERR flag.
// 1082   *            @arg SPI_FLAG_CRCERR: CRC Error flag.  
// 1083   *  
// 1084   * @note   OVR (OverRun error) flag is cleared by software sequence: a read 
// 1085   *          operation to SPI_DR register (SPI_I2S_ReceiveData()) followed by a read 
// 1086   *          operation to SPI_SR register (SPI_I2S_GetFlagStatus()).
// 1087   * @note   UDR (UnderRun error) flag is cleared by a read operation to 
// 1088   *          SPI_SR register (SPI_I2S_GetFlagStatus()).   
// 1089   * @note   MODF (Mode Fault) flag is cleared by software sequence: a read/write 
// 1090   *          operation to SPI_SR register (SPI_I2S_GetFlagStatus()) followed by a 
// 1091   *          write operation to SPI_CR1 register (SPI_Cmd() to enable the SPI).
// 1092   *  
// 1093   * @retval None
// 1094   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function SPI_I2S_ClearFlag
        THUMB
// 1095 void SPI_I2S_ClearFlag(SPI_TypeDef* SPIx, uint16_t SPI_I2S_FLAG)
// 1096 {
// 1097   /* Check the parameters */
// 1098   assert_param(IS_SPI_ALL_PERIPH(SPIx));
// 1099   assert_param(IS_SPI_I2S_CLEAR_FLAG(SPI_I2S_FLAG));
// 1100     
// 1101   /* Clear the selected SPI CRC Error (CRCERR) flag */
// 1102   SPIx->SR = (uint16_t)~SPI_I2S_FLAG;
SPI_I2S_ClearFlag:
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock22
// 1103 }
// 1104 
// 1105 /**
// 1106   * @brief  Checks whether the specified SPIx/I2Sx interrupt has occurred or not.
// 1107   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
// 1108   *         in SPI mode or 2 or 3 in I2S mode.   
// 1109   * @param  SPI_I2S_IT: specifies the SPI interrupt source to check. 
// 1110   *          This parameter can be one of the following values:
// 1111   *            @arg SPI_I2S_IT_TXE: Transmit buffer empty interrupt.
// 1112   *            @arg SPI_I2S_IT_RXNE: Receive buffer not empty interrupt.
// 1113   *            @arg SPI_I2S_IT_OVR: Overrun interrupt.
// 1114   *            @arg SPI_IT_MODF: Mode Fault interrupt.
// 1115   *            @arg SPI_IT_CRCERR: CRC Error interrupt.
// 1116   *            @arg I2S_IT_UDR: Underrun interrupt.  
// 1117   *            @arg SPI_I2S_IT_TIFRFE: Format Error interrupt.  
// 1118   * @retval The new state of SPI_I2S_IT (SET or RESET).
// 1119   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function SPI_I2S_GetITStatus
        THUMB
// 1120 ITStatus SPI_I2S_GetITStatus(SPI_TypeDef* SPIx, uint8_t SPI_I2S_IT)
// 1121 {
SPI_I2S_GetITStatus:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
// 1122   ITStatus bitstatus = RESET;
        MOVS     R2,#+0
// 1123   uint16_t itpos = 0, itmask = 0, enablestatus = 0;
// 1124 
// 1125   /* Check the parameters */
// 1126   assert_param(IS_SPI_ALL_PERIPH(SPIx));
// 1127   assert_param(IS_SPI_I2S_GET_IT(SPI_I2S_IT));
// 1128 
// 1129   /* Get the SPI_I2S_IT index */
// 1130   itpos = 0x01 << (SPI_I2S_IT & 0x0F);
// 1131 
// 1132   /* Get the SPI_I2S_IT IT mask */
// 1133   itmask = SPI_I2S_IT >> 4;
// 1134 
// 1135   /* Set the IT mask */
// 1136   itmask = 0x01 << itmask;
// 1137 
// 1138   /* Get the SPI_I2S_IT enable bit status */
// 1139   enablestatus = (SPIx->CR2 & itmask) ;
        MOVS     R3,#+1
        LDRH     R4,[R0, #+4]
        LSRS     R5,R1,#+4
        LSL      R5,R3,R5
        ANDS     R4,R5,R4
// 1140 
// 1141   /* Check the status of the specified SPI interrupt */
// 1142   if (((SPIx->SR & itpos) != (uint16_t)RESET) && enablestatus)
        LDRH     R0,[R0, #+8]
        AND      R1,R1,#0xF
        LSL      R1,R3,R1
        TST      R0,R1
        BEQ.N    ??SPI_I2S_GetITStatus_0
        CBZ.N    R4,??SPI_I2S_GetITStatus_0
// 1143   {
// 1144     /* SPI_I2S_IT is set */
// 1145     bitstatus = SET;
        MOVS     R2,#+1
// 1146   }
// 1147   else
// 1148   {
// 1149     /* SPI_I2S_IT is reset */
// 1150     bitstatus = RESET;
// 1151   }
// 1152   /* Return the SPI_I2S_IT status */
// 1153   return bitstatus;
??SPI_I2S_GetITStatus_0:
        MOV      R0,R2
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock23
// 1154 }
// 1155 
// 1156 /**
// 1157   * @brief  Clears the SPIx CRC Error (CRCERR) interrupt pending bit.
// 1158   * @param  SPIx: To select the SPIx/I2Sx peripheral, where x can be: 1, 2 or 3 
// 1159   *         in SPI mode or 2 or 3 in I2S mode.  
// 1160   * @param  SPI_I2S_IT: specifies the SPI interrupt pending bit to clear.
// 1161   *         This function clears only CRCERR interrupt pending bit.   
// 1162   *            @arg SPI_IT_CRCERR: CRC Error interrupt.
// 1163   *   
// 1164   * @note   OVR (OverRun Error) interrupt pending bit is cleared by software 
// 1165   *          sequence: a read operation to SPI_DR register (SPI_I2S_ReceiveData()) 
// 1166   *          followed by a read operation to SPI_SR register (SPI_I2S_GetITStatus()).
// 1167   * @note   UDR (UnderRun Error) interrupt pending bit is cleared by a read 
// 1168   *          operation to SPI_SR register (SPI_I2S_GetITStatus()).   
// 1169   * @note   MODF (Mode Fault) interrupt pending bit is cleared by software sequence:
// 1170   *          a read/write operation to SPI_SR register (SPI_I2S_GetITStatus()) 
// 1171   *          followed by a write operation to SPI_CR1 register (SPI_Cmd() to enable 
// 1172   *          the SPI).
// 1173   * @retval None
// 1174   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function SPI_I2S_ClearITPendingBit
        THUMB
// 1175 void SPI_I2S_ClearITPendingBit(SPI_TypeDef* SPIx, uint8_t SPI_I2S_IT)
// 1176 {
// 1177   uint16_t itpos = 0;
// 1178   /* Check the parameters */
// 1179   assert_param(IS_SPI_ALL_PERIPH(SPIx));
// 1180   assert_param(IS_SPI_I2S_CLEAR_IT(SPI_I2S_IT));
// 1181 
// 1182   /* Get the SPI_I2S IT index */
// 1183   itpos = 0x01 << (SPI_I2S_IT & 0x0F);
// 1184 
// 1185   /* Clear the selected SPI CRC Error (CRCERR) interrupt pending bit */
// 1186   SPIx->SR = (uint16_t)~itpos;
SPI_I2S_ClearITPendingBit:
        MOVS     R2,#+1
        AND      R1,R1,#0xF
        LSL      R1,R2,R1
        UXTH     R1,R1
        CFI EndBlock cfiBlock24
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
// 1187 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        MVNS     R1,R1
        STRH     R1,[R0, #+8]
        BX       LR               ;; return
        CFI EndBlock cfiBlock25

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 1188 
// 1189 /**
// 1190   * @}
// 1191   */
// 1192 
// 1193 /**
// 1194   * @}
// 1195   */ 
// 1196 
// 1197 /**
// 1198   * @}
// 1199   */ 
// 1200 
// 1201 /**
// 1202   * @}
// 1203   */ 
// 1204 
// 1205 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 786 bytes in section .text
// 
// 786 bytes of CODE memory
//
//Errors: none
//Warnings: none
