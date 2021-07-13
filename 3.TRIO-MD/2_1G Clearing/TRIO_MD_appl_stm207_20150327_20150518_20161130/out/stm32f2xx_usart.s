///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:51:59 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart.c                               /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart.c -D OS_INCLUDED -D APPL_SRC    /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_usa /
//                    rt.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_usart

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN RCC_APB1PeriphResetCmd
        EXTERN RCC_APB2PeriphResetCmd
        EXTERN RCC_GetClocksFreq

        PUBLIC USART_ClearFlag
        PUBLIC USART_ClearITPendingBit
        PUBLIC USART_ClockInit
        PUBLIC USART_ClockStructInit
        PUBLIC USART_Cmd
        PUBLIC USART_DMACmd
        PUBLIC USART_DeInit
        PUBLIC USART_GetFlagStatus
        PUBLIC USART_GetITStatus
        PUBLIC USART_HalfDuplexCmd
        PUBLIC USART_ITConfig
        PUBLIC USART_Init
        PUBLIC USART_IrDACmd
        PUBLIC USART_IrDAConfig
        PUBLIC USART_LINBreakDetectLengthConfig
        PUBLIC USART_LINCmd
        PUBLIC USART_OneBitMethodCmd
        PUBLIC USART_OverSampling8Cmd
        PUBLIC USART_ReceiveData
        PUBLIC USART_ReceiverWakeUpCmd
        PUBLIC USART_SendBreak
        PUBLIC USART_SendData
        PUBLIC USART_SetAddress
        PUBLIC USART_SetGuardTime
        PUBLIC USART_SetPrescaler
        PUBLIC USART_SmartCardCmd
        PUBLIC USART_SmartCardNACKCmd
        PUBLIC USART_StructInit
        PUBLIC USART_WakeUpConfig
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_usart.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_usart.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7   * @brief   This file provides firmware functions to manage the following 
//    8   *          functionalities of the Universal synchronous asynchronous receiver
//    9   *          transmitter (USART):           
//   10   *           - Initialization and Configuration
//   11   *           - Data transfers
//   12   *           - Multi-Processor Communication
//   13   *           - LIN mode
//   14   *           - Half-duplex mode
//   15   *           - Smartcard mode
//   16   *           - IrDA mode
//   17   *           - DMA transfers management
//   18   *           - Interrupts and flags management 
//   19   *           
//   20   *  @verbatim
//   21   *      
//   22   *          ===================================================================
//   23   *                                 How to use this driver
//   24   *          ===================================================================
//   25   *          1. Enable peripheral clock using the follwoing functions
//   26   *             RCC_APB2PeriphClockCmd(RCC_APB2Periph_USARTx, ENABLE) for USART1 and USART6 
//   27   *             RCC_APB1PeriphClockCmd(RCC_APB1Periph_USARTx, ENABLE) for USART2, USART3, UART4 or UART5.
//   28   *
//   29   *          2.  According to the USART mode, enable the GPIO clocks using 
//   30   *              RCC_AHB1PeriphClockCmd() function. (The I/O can be TX, RX, CTS, 
//   31   *              or/and SCLK). 
//   32   *
//   33   *          3. Peripheral's alternate function: 
//   34   *                 - Connect the pin to the desired peripherals' Alternate 
//   35   *                   Function (AF) using GPIO_PinAFConfig() function
//   36   *                 - Configure the desired pin in alternate function by:
//   37   *                   GPIO_InitStruct->GPIO_Mode = GPIO_Mode_AF
//   38   *                 - Select the type, pull-up/pull-down and output speed via 
//   39   *                   GPIO_PuPd, GPIO_OType and GPIO_Speed members
//   40   *                 - Call GPIO_Init() function
//   41   *        
//   42   *          4. Program the Baud Rate, Word Length , Stop Bit, Parity, Hardware 
//   43   *             flow control and Mode(Receiver/Transmitter) using the USART_Init()
//   44   *             function.
//   45   *
//   46   *          5. For synchronous mode, enable the clock and program the polarity,
//   47   *             phase and last bit using the USART_ClockInit() function.
//   48   *
//   49   *          5. Enable the NVIC and the corresponding interrupt using the function 
//   50   *             USART_ITConfig() if you need to use interrupt mode. 
//   51   *
//   52   *          6. When using the DMA mode 
//   53   *                   - Configure the DMA using DMA_Init() function
//   54   *                   - Active the needed channel Request using USART_DMACmd() function
//   55   * 
//   56   *          7. Enable the USART using the USART_Cmd() function.
//   57   * 
//   58   *          8. Enable the DMA using the DMA_Cmd() function, when using DMA mode. 
//   59   *
//   60   *          Refer to Multi-Processor, LIN, half-duplex, Smartcard, IrDA sub-sections
//   61   *          for more details
//   62   *          
//   63   *          In order to reach higher communication baudrates, it is possible to
//   64   *          enable the oversampling by 8 mode using the function USART_OverSampling8Cmd().
//   65   *          This function should be called after enabling the USART clock (RCC_APBxPeriphClockCmd())
//   66   *          and before calling the function USART_Init().
//   67   *          
//   68   *  @endverbatim
//   69   *        
//   70   ******************************************************************************
//   71   * @attention
//   72   *
//   73   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   74   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   75   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   76   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   77   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   78   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   79   *
//   80   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   81   ******************************************************************************  
//   82   */ 
//   83 
//   84 /* Includes ------------------------------------------------------------------*/
//   85 #include "stm32f2xx_usart.h"
//   86 
//   87 /** @addtogroup STM32F2xx_StdPeriph_Driver
//   88   * @{
//   89   */
//   90 
//   91 /** @defgroup USART 
//   92   * @brief USART driver modules
//   93   * @{
//   94   */
//   95 
//   96 /* Private typedef -----------------------------------------------------------*/
//   97 /* Private define ------------------------------------------------------------*/
//   98 
//   99 /*!< USART CR1 register clear Mask ((~(uint16_t)0xE9F3)) */
//  100 #define CR1_CLEAR_MASK            ((uint16_t)(USART_CR1_M | USART_CR1_PCE | \ 
//  101                                               USART_CR1_PS | USART_CR1_TE | \ 
//  102                                               USART_CR1_RE))
//  103 
//  104 /*!< USART CR2 register clock bits clear Mask ((~(uint16_t)0xF0FF)) */
//  105 #define CR2_CLOCK_CLEAR_MASK      ((uint16_t)(USART_CR2_CLKEN | USART_CR2_CPOL | \ 
//  106                                               USART_CR2_CPHA | USART_CR2_LBCL))
//  107 
//  108 /*!< USART CR3 register clear Mask ((~(uint16_t)0xFCFF)) */
//  109 #define CR3_CLEAR_MASK            ((uint16_t)(USART_CR3_RTSE | USART_CR3_CTSE))
//  110 
//  111 /*!< USART Interrupts mask */
//  112 #define IT_MASK                   ((uint16_t)0x001F)
//  113 
//  114 /* Private macro -------------------------------------------------------------*/
//  115 /* Private variables ---------------------------------------------------------*/
//  116 /* Private function prototypes -----------------------------------------------*/
//  117 /* Private functions ---------------------------------------------------------*/
//  118 
//  119 /** @defgroup USART_Private_Functions
//  120   * @{
//  121   */
//  122 
//  123 /** @defgroup USART_Group1 Initialization and Configuration functions
//  124  *  @brief   Initialization and Configuration functions 
//  125  *
//  126 @verbatim   
//  127  ===============================================================================
//  128                   Initialization and Configuration functions
//  129  ===============================================================================  
//  130 
//  131   This subsection provides a set of functions allowing to initialize the USART 
//  132   in asynchronous and in synchronous modes.
//  133    - For the asynchronous mode only these parameters can be configured: 
//  134         - Baud Rate
//  135         - Word Length 
//  136         - Stop Bit
//  137         - Parity: If the parity is enabled, then the MSB bit of the data written
//  138           in the data register is transmitted but is changed by the parity bit.
//  139           Depending on the frame length defined by the M bit (8-bits or 9-bits),
//  140           the possible USART frame formats are as listed in the following table:
//  141    +-------------------------------------------------------------+     
//  142    |   M bit |  PCE bit  |            USART frame                |
//  143    |---------------------|---------------------------------------|             
//  144    |    0    |    0      |    | SB | 8 bit data | STB |          |
//  145    |---------|-----------|---------------------------------------|  
//  146    |    0    |    1      |    | SB | 7 bit data | PB | STB |     |
//  147    |---------|-----------|---------------------------------------|  
//  148    |    1    |    0      |    | SB | 9 bit data | STB |          |
//  149    |---------|-----------|---------------------------------------|  
//  150    |    1    |    1      |    | SB | 8 bit data | PB | STB |     |
//  151    +-------------------------------------------------------------+            
//  152         - Hardware flow control
//  153         - Receiver/transmitter modes
//  154 
//  155   The USART_Init() function follows the USART  asynchronous configuration procedure
//  156   (details for the procedure are available in reference manual (RM0033)).
//  157 
//  158   - For the synchronous mode in addition to the asynchronous mode parameters these 
//  159     parameters should be also configured:
//  160         - USART Clock Enabled
//  161         - USART polarity
//  162         - USART phase
//  163         - USART LastBit
//  164   
//  165   These parameters can be configured using the USART_ClockInit() function.
//  166 
//  167 @endverbatim
//  168   * @{
//  169   */
//  170   
//  171 /**
//  172   * @brief  Deinitializes the USARTx peripheral registers to their default reset values.
//  173   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  174   *         UART peripheral.
//  175   * @retval None
//  176   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function USART_DeInit
        THUMB
//  177 void USART_DeInit(USART_TypeDef* USARTx)
//  178 {
USART_DeInit:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  179   /* Check the parameters */
//  180   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  181 
//  182   if (USARTx == USART1)
        LDR.N    R1,??DataTable1  ;; 0x40011000
        CMP      R0,R1
        BNE.N    ??USART_DeInit_0
//  183   {
//  184     RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART1, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+16
        BL       RCC_APB2PeriphResetCmd
//  185     RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART1, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+16
        B.N      ??USART_DeInit_1
//  186   }
//  187   else if (USARTx == USART2)
??USART_DeInit_0:
        LDR.N    R1,??DataTable1_1  ;; 0x40004400
        CMP      R0,R1
        BNE.N    ??USART_DeInit_2
//  188   {
//  189     RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART2, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+131072
        BL       RCC_APB1PeriphResetCmd
//  190     RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART2, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+131072
        B.N      ??USART_DeInit_3
//  191   }
//  192   else if (USARTx == USART3)
??USART_DeInit_2:
        LDR.N    R1,??DataTable1_2  ;; 0x40004800
        CMP      R0,R1
        BNE.N    ??USART_DeInit_4
//  193   {
//  194     RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART3, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+262144
        BL       RCC_APB1PeriphResetCmd
//  195     RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART3, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+262144
        B.N      ??USART_DeInit_3
//  196   }    
//  197   else if (USARTx == UART4)
??USART_DeInit_4:
        LDR.N    R1,??DataTable1_3  ;; 0x40004c00
        CMP      R0,R1
        BNE.N    ??USART_DeInit_5
//  198   {
//  199     RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART4, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+524288
        BL       RCC_APB1PeriphResetCmd
//  200     RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART4, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+524288
??USART_DeInit_3:
        POP      {R2,LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      RCC_APB1PeriphResetCmd
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  201   }
//  202   else if (USARTx == UART5)
??USART_DeInit_5:
        LDR.N    R1,??DataTable1_4  ;; 0x40005000
        CMP      R0,R1
        BNE.N    ??USART_DeInit_6
//  203   {
//  204     RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART5, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+1048576
        BL       RCC_APB1PeriphResetCmd
//  205     RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART5, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+1048576
        B.N      ??USART_DeInit_3
//  206   }     
//  207   else
//  208   {
//  209     if (USARTx == USART6)
??USART_DeInit_6:
        LDR.N    R1,??DataTable1_5  ;; 0x40011400
        CMP      R0,R1
        BNE.N    ??USART_DeInit_7
//  210     { 
//  211       RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART6, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+32
        BL       RCC_APB2PeriphResetCmd
//  212       RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART6, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+32
??USART_DeInit_1:
        BL       RCC_APB2PeriphResetCmd
//  213     }
//  214   }
//  215 }
??USART_DeInit_7:
        POP      {R0,PC}          ;; return
        CFI EndBlock cfiBlock0
//  216 
//  217 /**
//  218   * @brief  Initializes the USARTx peripheral according to the specified
//  219   *         parameters in the USART_InitStruct .
//  220   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  221   *         UART peripheral.
//  222   * @param  USART_InitStruct: pointer to a USART_InitTypeDef structure that contains
//  223   *         the configuration information for the specified USART peripheral.
//  224   * @retval None
//  225   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function USART_Init
        THUMB
//  226 void USART_Init(USART_TypeDef* USARTx, USART_InitTypeDef* USART_InitStruct)
//  227 {
USART_Init:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+20
        CFI CFA R13+32
        MOV      R4,R0
        MOV      R5,R1
//  228 	uint32_t tmpreg = 0x00, apbclock = 0x00;
//  229 	uint32_t integerdivider = 0x00;
//  230 	uint32_t fractionaldivider = 0x00;
//  231 	RCC_ClocksTypeDef RCC_ClocksStatus;
//  232 
//  233 	/* Check the parameters */
//  234 	assert_param(IS_USART_ALL_PERIPH(USARTx));
//  235 	assert_param(IS_USART_BAUDRATE(USART_InitStruct->USART_BaudRate));  
//  236 	assert_param(IS_USART_WORD_LENGTH(USART_InitStruct->USART_WordLength));
//  237 	assert_param(IS_USART_STOPBITS(USART_InitStruct->USART_StopBits));
//  238 	assert_param(IS_USART_PARITY(USART_InitStruct->USART_Parity));
//  239 	assert_param(IS_USART_MODE(USART_InitStruct->USART_Mode));
//  240 	assert_param(IS_USART_HARDWARE_FLOW_CONTROL(USART_InitStruct->USART_HardwareFlowControl));
//  241 
//  242 	/* The hardware flow control is available only for USART1, USART2, USART3 and USART6 */
//  243 	if (USART_InitStruct->USART_HardwareFlowControl != USART_HardwareFlowControl_None)
//  244 	{
//  245 		assert_param(IS_USART_1236_PERIPH(USARTx));
//  246 	}
//  247 
//  248 	/*---------------------------- USART CR2 Configuration -----------------------*/
//  249 	tmpreg = USARTx->CR2;
//  250 
//  251 	/* Clear STOP[13:12] bits */
//  252 	tmpreg &= (uint32_t)~((uint32_t)USART_CR2_STOP);
//  253 
//  254 	/* Configure the USART Stop Bits, Clock, CPOL, CPHA and LastBit :
//  255 	  Set STOP[13:12] bits according to USART_StopBits value */
//  256 	tmpreg |= (uint32_t)USART_InitStruct->USART_StopBits;
//  257 
//  258 	/* Write to USART CR2 */
//  259 	USARTx->CR2 = (uint16_t)tmpreg;
        LDRH     R0,[R4, #+16]
        MOVW     R1,#+53247
        ANDS     R0,R1,R0
        LDRH     R1,[R5, #+6]
        ORRS     R0,R1,R0
        STRH     R0,[R4, #+16]
//  260 
//  261 	/*---------------------------- USART CR1 Configuration -----------------------*/
//  262 	tmpreg = USARTx->CR1;
//  263 
//  264 	/* Clear M, PCE, PS, TE and RE bits */
//  265 	tmpreg &= (uint32_t)~((uint32_t)CR1_CLEAR_MASK);
//  266 
//  267   /* Configure the USART Word Length, Parity and mode: 
//  268      Set the M bits according to USART_WordLength value 
//  269      Set PCE and PS bits according to USART_Parity value
//  270      Set TE and RE bits according to USART_Mode value */
//  271 	tmpreg |= (uint32_t)USART_InitStruct->USART_WordLength | USART_InitStruct->USART_Parity |
//  272 	        USART_InitStruct->USART_Mode;
//  273 
//  274 	/* Write to USART CR1 */
//  275 	USARTx->CR1 = (uint16_t)tmpreg;
        LDRH     R0,[R4, #+12]
        MOVW     R1,#+59891
        ANDS     R0,R1,R0
        LDRH     R1,[R5, #+4]
        ORRS     R0,R1,R0
        LDRH     R1,[R5, #+8]
        ORRS     R0,R1,R0
        LDRH     R1,[R5, #+10]
        ORRS     R0,R1,R0
        STRH     R0,[R4, #+12]
//  276 
//  277 	/*---------------------------- USART CR3 Configuration -----------------------*/  
//  278 	tmpreg = USARTx->CR3;
//  279 
//  280 	/* Clear CTSE and RTSE bits */
//  281 	tmpreg &= (uint32_t)~((uint32_t)CR3_CLEAR_MASK);
//  282 
//  283 	/* Configure the USART HFC : 
//  284 	  Set CTSE and RTSE bits according to USART_HardwareFlowControl value */
//  285 	tmpreg |= USART_InitStruct->USART_HardwareFlowControl;
//  286 
//  287 	/* Write to USART CR3 */
//  288 	USARTx->CR3 = (uint16_t)tmpreg;
        LDRH     R0,[R4, #+20]
        MOVW     R1,#+64767
        ANDS     R0,R1,R0
        LDRH     R1,[R5, #+12]
        ORRS     R0,R1,R0
        STRH     R0,[R4, #+20]
//  289 
//  290 /*---------------------------- USART BRR Configuration -----------------------*/
//  291 	/* Configure the USART Baud Rate */
//  292 	RCC_GetClocksFreq(&RCC_ClocksStatus);
        ADD      R0,SP,#+0
        BL       RCC_GetClocksFreq
//  293 
//  294 	if ((USARTx == USART1) || (USARTx == USART6))
        LDR.N    R0,??DataTable1  ;; 0x40011000
        CMP      R4,R0
        BEQ.N    ??USART_Init_0
        LDR.N    R0,??DataTable1_5  ;; 0x40011400
        CMP      R4,R0
        BNE.N    ??USART_Init_1
//  295 	{
//  296 		apbclock = RCC_ClocksStatus.PCLK2_Frequency;
??USART_Init_0:
        LDR      R0,[SP, #+12]
        B.N      ??USART_Init_2
//  297 	}
//  298 	else
//  299 	{
//  300 		apbclock = RCC_ClocksStatus.PCLK1_Frequency;
??USART_Init_1:
        LDR      R0,[SP, #+8]
//  301 	}
//  302   
//  303 	/* Determine the integer part */
//  304 	if ((USARTx->CR1 & USART_CR1_OVER8) != 0)
??USART_Init_2:
        LDR      R1,[R5, #+0]
        MOVS     R2,#+25
        MULS     R0,R2,R0
        LDRH     R2,[R4, #+12]
        LSLS     R2,R2,#+16
        ITE      MI 
        LSLMI    R1,R1,#+1
        LSLPL    R1,R1,#+2
//  305 	{
//  306 		/* Integer part computing in case Oversampling mode is 8 Samples */
//  307 		integerdivider = ((25 * apbclock) / (2 * (USART_InitStruct->USART_BaudRate)));    
//  308 	}
//  309 	else /* if ((USARTx->CR1 & USART_CR1_OVER8) == 0) */
//  310 	{
//  311 		/* Integer part computing in case Oversampling mode is 16 Samples */
//  312 		integerdivider = ((25 * apbclock) / (4 * (USART_InitStruct->USART_BaudRate)));    
        UDIV     R1,R0,R1
//  313 	}
//  314 	tmpreg = (integerdivider / 100) << 4;
        MOVS     R2,#+100
        UDIV     R0,R1,R2
        LSLS     R0,R0,#+4
//  315 
//  316 	/* Determine the fractional part */
//  317 	fractionaldivider = integerdivider - (100 * (tmpreg >> 4));
        LSRS     R3,R0,#+4
        MLS      R1,R2,R3,R1
//  318 
//  319 	/* Implement the fractional part in the register */
//  320 	if ((USARTx->CR1 & USART_CR1_OVER8) != 0)
        LDRH     R3,[R4, #+12]
        LSLS     R3,R3,#+16
        BPL.N    ??USART_Init_3
//  321 	{
//  322 		tmpreg |= ((((fractionaldivider * 8) + 50) / 100)) & ((uint8_t)0x07);
        LSLS     R1,R1,#+3
        ADDS     R1,R1,#+50
        UDIV     R1,R1,R2
        AND      R1,R1,#0x7
        B.N      ??USART_Init_4
//  323 	}
//  324 	else /* if ((USARTx->CR1 & USART_CR1_OVER8) == 0) */
//  325 	{
//  326 		tmpreg |= ((((fractionaldivider * 16) + 50) / 100)) & ((uint8_t)0x0F);
??USART_Init_3:
        LSLS     R1,R1,#+4
        ADDS     R1,R1,#+50
        UDIV     R1,R1,R2
        AND      R1,R1,#0xF
??USART_Init_4:
        ORRS     R0,R1,R0
//  327 	}
//  328 
//  329 	/* Write to USART BRR register */
//  330 	USARTx->BRR = (uint16_t)tmpreg;
        STRH     R0,[R4, #+8]
//  331 }
        ADD      SP,SP,#+20
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x40011000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0x40004400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     0x40004800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     0x40004c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     0x40005000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_5:
        DC32     0x40011400
//  332 
//  333 /**
//  334   * @brief  Fills each USART_InitStruct member with its default value.
//  335   * @param  USART_InitStruct: pointer to a USART_InitTypeDef structure which will
//  336   *         be initialized.
//  337   * @retval None
//  338   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function USART_StructInit
        THUMB
//  339 void USART_StructInit(USART_InitTypeDef* USART_InitStruct)
//  340 {
//  341   /* USART_InitStruct members default value */
//  342   USART_InitStruct->USART_BaudRate = 9600;
USART_StructInit:
        MOV      R1,#+9600
        STR      R1,[R0, #+0]
//  343   USART_InitStruct->USART_WordLength = USART_WordLength_8b;
        MOVS     R1,#+0
        STRH     R1,[R0, #+4]
//  344   USART_InitStruct->USART_StopBits = USART_StopBits_1;
        STRH     R1,[R0, #+6]
//  345   USART_InitStruct->USART_Parity = USART_Parity_No ;
        STRH     R1,[R0, #+8]
//  346   USART_InitStruct->USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
        MOVS     R1,#+12
        STRH     R1,[R0, #+10]
//  347   USART_InitStruct->USART_HardwareFlowControl = USART_HardwareFlowControl_None;  
        MOVS     R1,#+0
        STRH     R1,[R0, #+12]
//  348 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  349 
//  350 /**
//  351   * @brief  Initializes the USARTx peripheral Clock according to the 
//  352   *         specified parameters in the USART_ClockInitStruct .
//  353   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART peripheral.
//  354   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure that
//  355   *         contains the configuration information for the specified  USART peripheral.
//  356   * @note   The Smart Card and Synchronous modes are not available for UART4 and UART5.    
//  357   * @retval None
//  358   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function USART_ClockInit
        THUMB
//  359 void USART_ClockInit(USART_TypeDef* USARTx, USART_ClockInitTypeDef* USART_ClockInitStruct)
//  360 {
//  361   uint32_t tmpreg = 0x00;
//  362   /* Check the parameters */
//  363   assert_param(IS_USART_1236_PERIPH(USARTx));
//  364   assert_param(IS_USART_CLOCK(USART_ClockInitStruct->USART_Clock));
//  365   assert_param(IS_USART_CPOL(USART_ClockInitStruct->USART_CPOL));
//  366   assert_param(IS_USART_CPHA(USART_ClockInitStruct->USART_CPHA));
//  367   assert_param(IS_USART_LASTBIT(USART_ClockInitStruct->USART_LastBit));
//  368   
//  369 /*---------------------------- USART CR2 Configuration -----------------------*/
//  370   tmpreg = USARTx->CR2;
//  371   /* Clear CLKEN, CPOL, CPHA and LBCL bits */
//  372   tmpreg &= (uint32_t)~((uint32_t)CR2_CLOCK_CLEAR_MASK);
//  373   /* Configure the USART Clock, CPOL, CPHA and LastBit ------------*/
//  374   /* Set CLKEN bit according to USART_Clock value */
//  375   /* Set CPOL bit according to USART_CPOL value */
//  376   /* Set CPHA bit according to USART_CPHA value */
//  377   /* Set LBCL bit according to USART_LastBit value */
//  378   tmpreg |= (uint32_t)USART_ClockInitStruct->USART_Clock | USART_ClockInitStruct->USART_CPOL | 
//  379                  USART_ClockInitStruct->USART_CPHA | USART_ClockInitStruct->USART_LastBit;
//  380   /* Write to USART CR2 */
//  381   USARTx->CR2 = (uint16_t)tmpreg;
USART_ClockInit:
        LDRH     R2,[R0, #+16]
        MOVW     R3,#+61695
        ANDS     R2,R3,R2
        LDRH     R3,[R1, #+0]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+2]
        ORRS     R2,R3,R2
        LDRH     R3,[R1, #+4]
        ORRS     R2,R3,R2
        LDRH     R1,[R1, #+6]
        B.N      ??Subroutine0_0
        CFI EndBlock cfiBlock3
//  382 }
//  383 
//  384 /**
//  385   * @brief  Fills each USART_ClockInitStruct member with its default value.
//  386   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure
//  387   *         which will be initialized.
//  388   * @retval None
//  389   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function USART_ClockStructInit
        THUMB
//  390 void USART_ClockStructInit(USART_ClockInitTypeDef* USART_ClockInitStruct)
//  391 {
//  392   /* USART_ClockInitStruct members default value */
//  393   USART_ClockInitStruct->USART_Clock = USART_Clock_Disable;
USART_ClockStructInit:
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  394   USART_ClockInitStruct->USART_CPOL = USART_CPOL_Low;
        STRH     R1,[R0, #+2]
//  395   USART_ClockInitStruct->USART_CPHA = USART_CPHA_1Edge;
        STRH     R1,[R0, #+4]
//  396   USART_ClockInitStruct->USART_LastBit = USART_LastBit_Disable;
        STRH     R1,[R0, #+6]
//  397 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  398 
//  399 /*******************************************************************************
//  400   * @brief  Enables or disables the specified USART peripheral.
//  401   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  402   *         UART peripheral.
//  403   * @param  NewState: new state of the USARTx peripheral.
//  404   *          This parameter can be: ENABLE or DISABLE.
//  405   * @retval None
//  406   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function USART_Cmd
        THUMB
//  407 void USART_Cmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  408 {
//  409 	/* Check the parameters */
//  410 	assert_param(IS_USART_ALL_PERIPH(USARTx));
//  411 	assert_param(IS_FUNCTIONAL_STATE(NewState));
//  412   
//  413 	if (NewState != DISABLE)
USART_Cmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+12]
        ITEE     NE 
        ORRNE    R1,R1,#0x2000
        MOVWEQ   R2,#+57343
        ANDEQ    R1,R2,R1
//  414 	{
//  415 		/* Enable the selected USART by setting the UE bit in the CR1 register */
//  416 		USARTx->CR1 |= USART_CR1_UE;
//  417   	}
//  418  	else
//  419   	{
//  420     	/* Disable the selected USART by clearing the UE bit in the CR1 register */
//  421     	USARTx->CR1 &= (uint16_t)~((uint16_t)USART_CR1_UE);
        STRH     R1,[R0, #+12]
//  422   	}
//  423 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  424 
//  425 /**
//  426   * @brief  Sets the system clock prescaler.
//  427   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  428   *         UART peripheral.
//  429   * @param  USART_Prescaler: specifies the prescaler clock. 
//  430   * @note   The function is used for IrDA mode with UART4 and UART5.   
//  431   * @retval None
//  432   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function USART_SetPrescaler
        THUMB
//  433 void USART_SetPrescaler(USART_TypeDef* USARTx, uint8_t USART_Prescaler)
//  434 { 
//  435   /* Check the parameters */
//  436   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  437   
//  438   /* Clear the USART prescaler */
//  439   USARTx->GTPR &= USART_GTPR_GT;
USART_SetPrescaler:
        LDRH     R2,[R0, #+24]
        AND      R2,R2,#0xFF00
        STRH     R2,[R0, #+24]
//  440   /* Set the USART prescaler */
//  441   USARTx->GTPR |= USART_Prescaler;
        LDRH     R2,[R0, #+24]
        ORRS     R1,R1,R2
        STRH     R1,[R0, #+24]
//  442 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  443 
//  444 /**
//  445   * @brief  Enables or disables the USART's 8x oversampling mode.
//  446   * @note   This function has to be called before calling USART_Init() function
//  447   *         in order to have correct baudrate Divider value.
//  448   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  449   *         UART peripheral.
//  450   * @param  NewState: new state of the USART 8x oversampling mode.
//  451   *          This parameter can be: ENABLE or DISABLE.
//  452   * @retval None
//  453   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function USART_OverSampling8Cmd
        THUMB
//  454 void USART_OverSampling8Cmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  455 {
//  456   /* Check the parameters */
//  457   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  458   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  459   
//  460   if (NewState != DISABLE)
USART_OverSampling8Cmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+12]
        ITEE     NE 
        ORRNE    R1,R1,#0x8000
        LSLEQ    R1,R1,#+17
        LSREQ    R1,R1,#+17
//  461   {
//  462     /* Enable the 8x Oversampling mode by setting the OVER8 bit in the CR1 register */
//  463     USARTx->CR1 |= USART_CR1_OVER8;
//  464   }
//  465   else
//  466   {
//  467     /* Disable the 8x Oversampling mode by clearing the OVER8 bit in the CR1 register */
//  468     USARTx->CR1 &= (uint16_t)~((uint16_t)USART_CR1_OVER8);
        STRH     R1,[R0, #+12]
//  469   }
//  470 }  
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  471 
//  472 /**
//  473   * @brief  Enables or disables the USART's one bit sampling method.
//  474   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  475   *         UART peripheral.
//  476   * @param  NewState: new state of the USART one bit sampling method.
//  477   *          This parameter can be: ENABLE or DISABLE.
//  478   * @retval None
//  479   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function USART_OneBitMethodCmd
        THUMB
//  480 void USART_OneBitMethodCmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  481 {
//  482   /* Check the parameters */
//  483   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  484   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  485   
//  486   if (NewState != DISABLE)
USART_OneBitMethodCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+20]
        ITEE     NE 
        ORRNE    R1,R1,#0x800
        MOVWEQ   R2,#+63487
        ANDEQ    R1,R2,R1
//  487   {
//  488     /* Enable the one bit method by setting the ONEBITE bit in the CR3 register */
//  489     USARTx->CR3 |= USART_CR3_ONEBIT;
//  490   }
//  491   else
//  492   {
//  493     /* Disable the one bit method by clearing the ONEBITE bit in the CR3 register */
//  494     USARTx->CR3 &= (uint16_t)~((uint16_t)USART_CR3_ONEBIT);
        STRH     R1,[R0, #+20]
//  495   }
//  496 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  497 
//  498 /**
//  499   * @}
//  500   */
//  501 
//  502 /** @defgroup USART_Group2 Data transfers functions
//  503  *  @brief   Data transfers functions 
//  504  *
//  505 @verbatim   
//  506  ===============================================================================
//  507                             Data transfers functions
//  508  ===============================================================================  
//  509 
//  510   This subsection provides a set of functions allowing to manage the USART data 
//  511   transfers.
//  512   
//  513   During an USART reception, data shifts in least significant bit first through 
//  514   the RX pin. In this mode, the USART_DR register consists of a buffer (RDR) 
//  515   between the internal bus and the received shift register.
//  516 
//  517   When a transmission is taking place, a write instruction to the USART_DR register 
//  518   stores the data in the TDR register and which is copied in the shift register 
//  519   at the end of the current transmission.
//  520 
//  521   The read access of the USART_DR register can be done using the USART_ReceiveData()
//  522   function and returns the RDR buffered value. Whereas a write access to the USART_DR 
//  523   can be done using USART_SendData() function and stores the written data into 
//  524   TDR buffer.
//  525 
//  526 @endverbatim
//  527   * @{
//  528   */
//  529 
//  530 /**
//  531   * @brief  Transmits single data through the USARTx peripheral.
//  532   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  533   *         UART peripheral.
//  534   * @param  Data: the data to transmit.
//  535   * @retval None
//  536   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function USART_SendData
        THUMB
//  537 void USART_SendData(USART_TypeDef* USARTx, uint16_t Data)
//  538 {
//  539   /* Check the parameters */
//  540   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  541   assert_param(IS_USART_DATA(Data)); 
//  542     
//  543   /* Transmit Data */
//  544   USARTx->DR = (Data & (uint16_t)0x01FF);
USART_SendData:
        LSLS     R1,R1,#+23
        LSRS     R1,R1,#+23
        STRH     R1,[R0, #+4]
//  545 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  546 
//  547 /**
//  548   * @brief  Returns the most recent received data by the USARTx peripheral.
//  549   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  550   *         UART peripheral.
//  551   * @retval The received data.
//  552   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function USART_ReceiveData
        THUMB
//  553 uint16_t USART_ReceiveData(USART_TypeDef* USARTx)
//  554 {
//  555   /* Check the parameters */
//  556   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  557   
//  558   /* Receive Data */
//  559   return (uint16_t)(USARTx->DR & (uint16_t)0x01FF);
USART_ReceiveData:
        LDRH     R0,[R0, #+4]
        LSLS     R0,R0,#+23
        LSRS     R0,R0,#+23
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  560 }
//  561 
//  562 /**
//  563   * @}
//  564   */
//  565 
//  566 /** @defgroup USART_Group3 MultiProcessor Communication functions
//  567  *  @brief   Multi-Processor Communication functions 
//  568  *
//  569 @verbatim   
//  570  ===============================================================================
//  571                     Multi-Processor Communication functions
//  572  ===============================================================================  
//  573 
//  574   This subsection provides a set of functions allowing to manage the USART 
//  575   multiprocessor communication.
//  576   
//  577   For instance one of the USARTs can be the master, its TX output is connected to 
//  578   the RX input of the other USART. The others are slaves, their respective TX outputs 
//  579   are logically ANDed together and connected to the RX input of the master.
//  580 
//  581   USART multiprocessor communication is possible through the following procedure:
//  582      1. Program the Baud rate, Word length = 9 bits, Stop bits, Parity, Mode transmitter 
//  583         or Mode receiver and hardware flow control values using the USART_Init()
//  584         function.
//  585      2. Configures the USART address using the USART_SetAddress() function.
//  586      3. Configures the wake up method (USART_WakeUp_IdleLine or USART_WakeUp_AddressMark)
//  587         using USART_WakeUpConfig() function only for the slaves.
//  588      4. Enable the USART using the USART_Cmd() function.
//  589      5. Enter the USART slaves in mute mode using USART_ReceiverWakeUpCmd() function.
//  590 
//  591   The USART Slave exit from mute mode when receive the wake up condition.
//  592 
//  593 @endverbatim
//  594   * @{
//  595   */
//  596 
//  597 /**
//  598   * @brief  Sets the address of the USART node.
//  599   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  600   *         UART peripheral.
//  601   * @param  USART_Address: Indicates the address of the USART node.
//  602   * @retval None
//  603   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function USART_SetAddress
        THUMB
//  604 void USART_SetAddress(USART_TypeDef* USARTx, uint8_t USART_Address)
//  605 {
//  606   /* Check the parameters */
//  607   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  608   assert_param(IS_USART_ADDRESS(USART_Address)); 
//  609     
//  610   /* Clear the USART address */
//  611   USARTx->CR2 &= (uint16_t)~((uint16_t)USART_CR2_ADD);
USART_SetAddress:
        LDRH     R2,[R0, #+16]
        MOVW     R3,#+65520
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock11
//  612   /* Set the USART address node */
//  613   USARTx->CR2 |= USART_Address;
//  614 }
//  615 
//  616 /**
//  617   * @brief  Determines if the USART is in mute mode or not.
//  618   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  619   *         UART peripheral.
//  620   * @param  NewState: new state of the USART mute mode.
//  621   *          This parameter can be: ENABLE or DISABLE.
//  622   * @retval None
//  623   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function USART_ReceiverWakeUpCmd
        THUMB
//  624 void USART_ReceiverWakeUpCmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  625 {
//  626   /* Check the parameters */
//  627   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  628   assert_param(IS_FUNCTIONAL_STATE(NewState)); 
//  629   
//  630   if (NewState != DISABLE)
USART_ReceiverWakeUpCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+12]
        ITEE     NE 
        ORRNE    R1,R1,#0x2
        MOVWEQ   R2,#+65533
        ANDEQ    R1,R2,R1
//  631   {
//  632     /* Enable the USART mute mode  by setting the RWU bit in the CR1 register */
//  633     USARTx->CR1 |= USART_CR1_RWU;
//  634   }
//  635   else
//  636   {
//  637     /* Disable the USART mute mode by clearing the RWU bit in the CR1 register */
//  638     USARTx->CR1 &= (uint16_t)~((uint16_t)USART_CR1_RWU);
        STRH     R1,[R0, #+12]
//  639   }
//  640 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  641 /**
//  642   * @brief  Selects the USART WakeUp method.
//  643   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  644   *         UART peripheral.
//  645   * @param  USART_WakeUp: specifies the USART wakeup method.
//  646   *          This parameter can be one of the following values:
//  647   *            @arg USART_WakeUp_IdleLine: WakeUp by an idle line detection
//  648   *            @arg USART_WakeUp_AddressMark: WakeUp by an address mark
//  649   * @retval None
//  650   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function USART_WakeUpConfig
        THUMB
//  651 void USART_WakeUpConfig(USART_TypeDef* USARTx, uint16_t USART_WakeUp)
//  652 {
//  653   /* Check the parameters */
//  654   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  655   assert_param(IS_USART_WAKEUP(USART_WakeUp));
//  656   
//  657   USARTx->CR1 &= (uint16_t)~((uint16_t)USART_CR1_WAKE);
USART_WakeUpConfig:
        LDRH     R2,[R0, #+12]
        MOVW     R3,#+63487
        ANDS     R2,R3,R2
        STRH     R2,[R0, #+12]
//  658   USARTx->CR1 |= USART_WakeUp;
        LDRH     R2,[R0, #+12]
        ORRS     R1,R1,R2
        STRH     R1,[R0, #+12]
//  659 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  660 
//  661 /**
//  662   * @}
//  663   */
//  664 
//  665 /** @defgroup USART_Group4 LIN mode functions
//  666  *  @brief   LIN mode functions 
//  667  *
//  668 @verbatim   
//  669  ===============================================================================
//  670                                 LIN mode functions
//  671  ===============================================================================  
//  672 
//  673   This subsection provides a set of functions allowing to manage the USART LIN 
//  674   Mode communication.
//  675   
//  676   In LIN mode, 8-bit data format with 1 stop bit is required in accordance with 
//  677   the LIN standard.
//  678 
//  679   Only this LIN Feature is supported by the USART IP:
//  680     - LIN Master Synchronous Break send capability and LIN slave break detection
//  681       capability :  13-bit break generation and 10/11 bit break detection
//  682 
//  683 
//  684   USART LIN Master transmitter communication is possible through the following procedure:
//  685      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  686         Mode transmitter or Mode receiver and hardware flow control values using 
//  687         the USART_Init() function.
//  688      2. Enable the USART using the USART_Cmd() function.
//  689      3. Enable the LIN mode using the USART_LINCmd() function.
//  690      4. Send the break character using USART_SendBreak() function.
//  691 
//  692   USART LIN Master receiver communication is possible through the following procedure:
//  693      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  694         Mode transmitter or Mode receiver and hardware flow control values using 
//  695         the USART_Init() function.
//  696      2. Enable the USART using the USART_Cmd() function.
//  697      3. Configures the break detection length using the USART_LINBreakDetectLengthConfig()
//  698         function.
//  699      4. Enable the LIN mode using the USART_LINCmd() function.
//  700 
//  701 
//  702 @note In LIN mode, the following bits must be kept cleared:
//  703         - CLKEN in the USART_CR2 register,
//  704         - STOP[1:0], SCEN, HDSEL and IREN in the USART_CR3 register.
//  705 
//  706 @endverbatim
//  707   * @{
//  708   */
//  709 
//  710 /**
//  711   * @brief  Sets the USART LIN Break detection length.
//  712   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  713   *         UART peripheral.
//  714   * @param  USART_LINBreakDetectLength: specifies the LIN break detection length.
//  715   *          This parameter can be one of the following values:
//  716   *            @arg USART_LINBreakDetectLength_10b: 10-bit break detection
//  717   *            @arg USART_LINBreakDetectLength_11b: 11-bit break detection
//  718   * @retval None
//  719   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function USART_LINBreakDetectLengthConfig
        THUMB
//  720 void USART_LINBreakDetectLengthConfig(USART_TypeDef* USARTx, uint16_t USART_LINBreakDetectLength)
//  721 {
//  722   /* Check the parameters */
//  723   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  724   assert_param(IS_USART_LIN_BREAK_DETECT_LENGTH(USART_LINBreakDetectLength));
//  725   
//  726   USARTx->CR2 &= (uint16_t)~((uint16_t)USART_CR2_LBDL);
USART_LINBreakDetectLengthConfig:
        LDRH     R2,[R0, #+16]
        MOVW     R3,#+65503
        CFI EndBlock cfiBlock14
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  727   USARTx->CR2 |= USART_LINBreakDetectLength;  
//  728 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        ANDS     R2,R3,R2
        STRH     R2,[R0, #+16]
        LDRH     R2,[R0, #+16]
??Subroutine0_0:
        ORRS     R1,R1,R2
        STRH     R1,[R0, #+16]
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  729 
//  730 /**
//  731   * @brief  Enables or disables the USART's LIN mode.
//  732   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  733   *         UART peripheral.
//  734   * @param  NewState: new state of the USART LIN mode.
//  735   *          This parameter can be: ENABLE or DISABLE.
//  736   * @retval None
//  737   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function USART_LINCmd
        THUMB
//  738 void USART_LINCmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  739 {
//  740   /* Check the parameters */
//  741   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  742   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  743   
//  744   if (NewState != DISABLE)
USART_LINCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+16]
        ITEE     NE 
        ORRNE    R1,R1,#0x4000
        MOVWEQ   R2,#+49151
        ANDEQ    R1,R2,R1
//  745   {
//  746     /* Enable the LIN mode by setting the LINEN bit in the CR2 register */
//  747     USARTx->CR2 |= USART_CR2_LINEN;
//  748   }
//  749   else
//  750   {
//  751     /* Disable the LIN mode by clearing the LINEN bit in the CR2 register */
//  752     USARTx->CR2 &= (uint16_t)~((uint16_t)USART_CR2_LINEN);
        STRH     R1,[R0, #+16]
//  753   }
//  754 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  755 
//  756 /**
//  757   * @brief  Transmits break characters.
//  758   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  759   *         UART peripheral.
//  760   * @retval None
//  761   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function USART_SendBreak
        THUMB
//  762 void USART_SendBreak(USART_TypeDef* USARTx)
//  763 {
//  764   /* Check the parameters */
//  765   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  766   
//  767   /* Send break characters */
//  768   USARTx->CR1 |= USART_CR1_SBK;
USART_SendBreak:
        LDRH     R1,[R0, #+12]
        ORR      R1,R1,#0x1
        STRH     R1,[R0, #+12]
//  769 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  770 
//  771 /**
//  772   * @}
//  773   */
//  774 
//  775 /** @defgroup USART_Group5 Halfduplex mode function
//  776  *  @brief   Half-duplex mode function 
//  777  *
//  778 @verbatim   
//  779  ===============================================================================
//  780                          Half-duplex mode function
//  781  ===============================================================================  
//  782 
//  783   This subsection provides a set of functions allowing to manage the USART 
//  784   Half-duplex communication.
//  785   
//  786   The USART can be configured to follow a single-wire half-duplex protocol where 
//  787   the TX and RX lines are internally connected.
//  788 
//  789   USART Half duplex communication is possible through the following procedure:
//  790      1. Program the Baud rate, Word length, Stop bits, Parity, Mode transmitter 
//  791         or Mode receiver and hardware flow control values using the USART_Init()
//  792         function.
//  793      2. Configures the USART address using the USART_SetAddress() function.
//  794      3. Enable the USART using the USART_Cmd() function.
//  795      4. Enable the half duplex mode using USART_HalfDuplexCmd() function.
//  796 
//  797 
//  798 @note The RX pin is no longer used
//  799 @note In Half-duplex mode the following bits must be kept cleared:
//  800         - LINEN and CLKEN bits in the USART_CR2 register.
//  801         - SCEN and IREN bits in the USART_CR3 register.
//  802 
//  803 @endverbatim
//  804   * @{
//  805   */
//  806 
//  807 /**
//  808   * @brief  Enables or disables the USART's Half Duplex communication.
//  809   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  810   *         UART peripheral.
//  811   * @param  NewState: new state of the USART Communication.
//  812   *          This parameter can be: ENABLE or DISABLE.
//  813   * @retval None
//  814   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function USART_HalfDuplexCmd
        THUMB
//  815 void USART_HalfDuplexCmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  816 {
//  817   /* Check the parameters */
//  818   assert_param(IS_USART_ALL_PERIPH(USARTx));
//  819   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  820   
//  821   if (NewState != DISABLE)
USART_HalfDuplexCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+20]
        ITEE     NE 
        ORRNE    R1,R1,#0x8
        MOVWEQ   R2,#+65527
        ANDEQ    R1,R2,R1
//  822   {
//  823     /* Enable the Half-Duplex mode by setting the HDSEL bit in the CR3 register */
//  824     USARTx->CR3 |= USART_CR3_HDSEL;
//  825   }
//  826   else
//  827   {
//  828     /* Disable the Half-Duplex mode by clearing the HDSEL bit in the CR3 register */
//  829     USARTx->CR3 &= (uint16_t)~((uint16_t)USART_CR3_HDSEL);
        STRH     R1,[R0, #+20]
//  830   }
//  831 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//  832 
//  833 /**
//  834   * @}
//  835   */
//  836 
//  837 
//  838 /** @defgroup USART_Group6 Smartcard mode functions
//  839  *  @brief   Smartcard mode functions 
//  840  *
//  841 @verbatim   
//  842  ===============================================================================
//  843                                Smartcard mode functions
//  844  ===============================================================================  
//  845 
//  846   This subsection provides a set of functions allowing to manage the USART 
//  847   Smartcard communication.
//  848   
//  849   The Smartcard interface is designed to support asynchronous protocol Smartcards as
//  850   defined in the ISO 7816-3 standard.
//  851 
//  852   The USART can provide a clock to the smartcard through the SCLK output.
//  853   In smartcard mode, SCLK is not associated to the communication but is simply derived 
//  854   from the internal peripheral input clock through a 5-bit prescaler.
//  855 
//  856   Smartcard communication is possible through the following procedure:
//  857      1. Configures the Smartcard Prescaler using the USART_SetPrescaler() function.
//  858      2. Configures the Smartcard Guard Time using the USART_SetGuardTime() function.
//  859      3. Program the USART clock using the USART_ClockInit() function as following:
//  860         - USART Clock enabled
//  861         - USART CPOL Low
//  862         - USART CPHA on first edge
//  863         - USART Last Bit Clock Enabled
//  864      4. Program the Smartcard interface using the USART_Init() function as following:
//  865         - Word Length = 9 Bits
//  866         - 1.5 Stop Bit
//  867         - Even parity
//  868         - BaudRate = 12096 baud
//  869         - Hardware flow control disabled (RTS and CTS signals)
//  870         - Tx and Rx enabled
//  871      5. Optionally you can enable the parity error interrupt using the USART_ITConfig()
//  872         function
//  873      6. Enable the USART using the USART_Cmd() function.
//  874      7. Enable the Smartcard NACK using the USART_SmartCardNACKCmd() function.
//  875      8. Enable the Smartcard interface using the USART_SmartCardCmd() function.
//  876 
//  877   Please refer to the ISO 7816-3 specification for more details.
//  878 
//  879 
//  880 @note It is also possible to choose 0.5 stop bit for receiving but it is recommended 
//  881       to use 1.5 stop bits for both transmitting and receiving to avoid switching 
//  882       between the two configurations.
//  883 @note In smartcard mode, the following bits must be kept cleared:
//  884         - LINEN bit in the USART_CR2 register.
//  885         - HDSEL and IREN bits in the USART_CR3 register.
//  886 @note Smartcard mode is available on USART peripherals only (not available on UART4 
//  887       and UART5 peripherals).
//  888 
//  889 @endverbatim
//  890   * @{
//  891   */
//  892 
//  893 /**
//  894   * @brief  Sets the specified USART guard time.
//  895   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  896   *         UART peripheral.
//  897   * @param  USART_GuardTime: specifies the guard time.   
//  898   * @retval None
//  899   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function USART_SetGuardTime
        THUMB
//  900 void USART_SetGuardTime(USART_TypeDef* USARTx, uint8_t USART_GuardTime)
//  901 {    
//  902   /* Check the parameters */
//  903   assert_param(IS_USART_1236_PERIPH(USARTx));
//  904   
//  905   /* Clear the USART Guard time */
//  906   USARTx->GTPR &= USART_GTPR_PSC;
USART_SetGuardTime:
        LDRH     R2,[R0, #+24]
        UXTB     R2,R2
        STRH     R2,[R0, #+24]
//  907   /* Set the USART guard time */
//  908   USARTx->GTPR |= (uint16_t)((uint16_t)USART_GuardTime << 0x08);
        LDRH     R2,[R0, #+24]
        ORR      R1,R2,R1, LSL #+8
        STRH     R1,[R0, #+24]
//  909 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//  910 
//  911 /**
//  912   * @brief  Enables or disables the USART's Smart Card mode.
//  913   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  914   *         UART peripheral.
//  915   * @param  NewState: new state of the Smart Card mode.
//  916   *          This parameter can be: ENABLE or DISABLE.      
//  917   * @retval None
//  918   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function USART_SmartCardCmd
        THUMB
//  919 void USART_SmartCardCmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  920 {
//  921   /* Check the parameters */
//  922   assert_param(IS_USART_1236_PERIPH(USARTx));
//  923   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  924   if (NewState != DISABLE)
USART_SmartCardCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+20]
        ITEE     NE 
        ORRNE    R1,R1,#0x20
        MOVWEQ   R2,#+65503
        ANDEQ    R1,R2,R1
//  925   {
//  926     /* Enable the SC mode by setting the SCEN bit in the CR3 register */
//  927     USARTx->CR3 |= USART_CR3_SCEN;
//  928   }
//  929   else
//  930   {
//  931     /* Disable the SC mode by clearing the SCEN bit in the CR3 register */
//  932     USARTx->CR3 &= (uint16_t)~((uint16_t)USART_CR3_SCEN);
        STRH     R1,[R0, #+20]
//  933   }
//  934 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock20
//  935 
//  936 /**
//  937   * @brief  Enables or disables NACK transmission.
//  938   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  939   *         UART peripheral.
//  940   * @param  NewState: new state of the NACK transmission.
//  941   *          This parameter can be: ENABLE or DISABLE.  
//  942   * @retval None
//  943   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function USART_SmartCardNACKCmd
        THUMB
//  944 void USART_SmartCardNACKCmd(USART_TypeDef* USARTx, FunctionalState NewState)
//  945 {
//  946   /* Check the parameters */
//  947   assert_param(IS_USART_1236_PERIPH(USARTx)); 
//  948   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  949   if (NewState != DISABLE)
USART_SmartCardNACKCmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+20]
        ITEE     NE 
        ORRNE    R1,R1,#0x10
        MOVWEQ   R2,#+65519
        ANDEQ    R1,R2,R1
//  950   {
//  951     /* Enable the NACK transmission by setting the NACK bit in the CR3 register */
//  952     USARTx->CR3 |= USART_CR3_NACK;
//  953   }
//  954   else
//  955   {
//  956     /* Disable the NACK transmission by clearing the NACK bit in the CR3 register */
//  957     USARTx->CR3 &= (uint16_t)~((uint16_t)USART_CR3_NACK);
        STRH     R1,[R0, #+20]
//  958   }
//  959 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
//  960 
//  961 /**
//  962   * @}
//  963   */
//  964 
//  965 /** @defgroup USART_Group7 IrDA mode functions
//  966  *  @brief   IrDA mode functions 
//  967  *
//  968 @verbatim   
//  969  ===============================================================================
//  970                                 IrDA mode functions
//  971  ===============================================================================  
//  972 
//  973   This subsection provides a set of functions allowing to manage the USART 
//  974   IrDA communication.
//  975   
//  976   IrDA is a half duplex communication protocol. If the Transmitter is busy, any data
//  977   on the IrDA receive line will be ignored by the IrDA decoder and if the Receiver 
//  978   is busy, data on the TX from the USART to IrDA will not be encoded by IrDA.
//  979   While receiving data, transmission should be avoided as the data to be transmitted
//  980   could be corrupted.
//  981 
//  982   IrDA communication is possible through the following procedure:
//  983      1. Program the Baud rate, Word length = 8 bits, Stop bits, Parity, Transmitter/Receiver 
//  984         modes and hardware flow control values using the USART_Init() function.
//  985      2. Enable the USART using the USART_Cmd() function.
//  986      3. Configures the IrDA pulse width by configuring the prescaler using  
//  987         the USART_SetPrescaler() function.
//  988      4. Configures the IrDA  USART_IrDAMode_LowPower or USART_IrDAMode_Normal mode
//  989         using the USART_IrDAConfig() function.
//  990      5. Enable the IrDA using the USART_IrDACmd() function.
//  991 
//  992 @note A pulse of width less than two and greater than one PSC period(s) may or may
//  993       not be rejected.
//  994 @note The receiver set up time should be managed by software. The IrDA physical layer
//  995       specification specifies a minimum of 10 ms delay between transmission and 
//  996       reception (IrDA is a half duplex protocol).
//  997 @note In IrDA mode, the following bits must be kept cleared:
//  998         - LINEN, STOP and CLKEN bits in the USART_CR2 register.
//  999         - SCEN and HDSEL bits in the USART_CR3 register.
// 1000 
// 1001 @endverbatim
// 1002   * @{
// 1003   */
// 1004 
// 1005 /**
// 1006   * @brief  Configures the USART's IrDA interface.
// 1007   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1008   *         UART peripheral.
// 1009   * @param  USART_IrDAMode: specifies the IrDA mode.
// 1010   *          This parameter can be one of the following values:
// 1011   *            @arg USART_IrDAMode_LowPower
// 1012   *            @arg USART_IrDAMode_Normal
// 1013   * @retval None
// 1014   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function USART_IrDAConfig
        THUMB
// 1015 void USART_IrDAConfig(USART_TypeDef* USARTx, uint16_t USART_IrDAMode)
// 1016 {
// 1017   /* Check the parameters */
// 1018   assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1019   assert_param(IS_USART_IRDA_MODE(USART_IrDAMode));
// 1020     
// 1021   USARTx->CR3 &= (uint16_t)~((uint16_t)USART_CR3_IRLP);
USART_IrDAConfig:
        LDRH     R2,[R0, #+20]
        MOVW     R3,#+65531
        ANDS     R2,R3,R2
        STRH     R2,[R0, #+20]
// 1022   USARTx->CR3 |= USART_IrDAMode;
        LDRH     R2,[R0, #+20]
        ORRS     R1,R1,R2
        STRH     R1,[R0, #+20]
// 1023 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
// 1024 
// 1025 /**
// 1026   * @brief  Enables or disables the USART's IrDA interface.
// 1027   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1028   *         UART peripheral.
// 1029   * @param  NewState: new state of the IrDA mode.
// 1030   *          This parameter can be: ENABLE or DISABLE.
// 1031   * @retval None
// 1032   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function USART_IrDACmd
        THUMB
// 1033 void USART_IrDACmd(USART_TypeDef* USARTx, FunctionalState NewState)
// 1034 {
// 1035   /* Check the parameters */
// 1036   assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1037   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1038     
// 1039   if (NewState != DISABLE)
USART_IrDACmd:
        CMP      R1,#+0
        LDRH     R1,[R0, #+20]
        ITEE     NE 
        ORRNE    R1,R1,#0x2
        MOVWEQ   R2,#+65533
        ANDEQ    R1,R2,R1
// 1040   {
// 1041     /* Enable the IrDA mode by setting the IREN bit in the CR3 register */
// 1042     USARTx->CR3 |= USART_CR3_IREN;
// 1043   }
// 1044   else
// 1045   {
// 1046     /* Disable the IrDA mode by clearing the IREN bit in the CR3 register */
// 1047     USARTx->CR3 &= (uint16_t)~((uint16_t)USART_CR3_IREN);
        STRH     R1,[R0, #+20]
// 1048   }
// 1049 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock23
// 1050 
// 1051 /**
// 1052   * @}
// 1053   */
// 1054 
// 1055 /** @defgroup USART_Group8 DMA transfers management functions
// 1056  *  @brief   DMA transfers management functions
// 1057  *
// 1058 @verbatim   
// 1059  ===============================================================================
// 1060                       DMA transfers management functions
// 1061  ===============================================================================  
// 1062 
// 1063 @endverbatim
// 1064   * @{
// 1065   */
// 1066   
// 1067 /**
// 1068   * @brief  Enables or disables the USART's DMA interface.
// 1069   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1070   *         UART peripheral.
// 1071   * @param  USART_DMAReq: specifies the DMA request.
// 1072   *          This parameter can be any combination of the following values:
// 1073   *            @arg USART_DMAReq_Tx: USART DMA transmit request
// 1074   *            @arg USART_DMAReq_Rx: USART DMA receive request
// 1075   * @param  NewState: new state of the DMA Request sources.
// 1076   *          This parameter can be: ENABLE or DISABLE.   
// 1077   * @retval None
// 1078   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function USART_DMACmd
        THUMB
// 1079 void USART_DMACmd(USART_TypeDef* USARTx, uint16_t USART_DMAReq, FunctionalState NewState)
// 1080 {
// 1081   /* Check the parameters */
// 1082   assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1083   assert_param(IS_USART_DMAREQ(USART_DMAReq));  
// 1084   assert_param(IS_FUNCTIONAL_STATE(NewState)); 
// 1085 
// 1086   if (NewState != DISABLE)
USART_DMACmd:
        CMP      R2,#+0
        LDRH     R2,[R0, #+20]
        ITE      NE 
        ORRNE    R1,R1,R2
        BICEQ    R1,R2,R1
// 1087   {
// 1088     /* Enable the DMA transfer for selected requests by setting the DMAT and/or
// 1089        DMAR bits in the USART CR3 register */
// 1090     USARTx->CR3 |= USART_DMAReq;
// 1091   }
// 1092   else
// 1093   {
// 1094     /* Disable the DMA transfer for selected requests by clearing the DMAT and/or
// 1095        DMAR bits in the USART CR3 register */
// 1096     USARTx->CR3 &= (uint16_t)~USART_DMAReq;
        STRH     R1,[R0, #+20]
// 1097   }
// 1098 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
// 1099 
// 1100 /**
// 1101   * @}
// 1102   */
// 1103   
// 1104 /** @defgroup USART_Group9 Interrupts and flags management functions
// 1105  *  @brief   Interrupts and flags management functions 
// 1106  *
// 1107 @verbatim   
// 1108  ===============================================================================
// 1109                    Interrupts and flags management functions
// 1110  ===============================================================================  
// 1111 
// 1112   This subsection provides a set of functions allowing to configure the USART 
// 1113   Interrupts sources, DMA channels requests and check or clear the flags or 
// 1114   pending bits status.
// 1115   The user should identify which mode will be used in his application to manage 
// 1116   the communication: Polling mode, Interrupt mode or DMA mode. 
// 1117     
// 1118   Polling Mode
// 1119   =============
// 1120   In Polling Mode, the SPI communication can be managed by 10 flags:
// 1121      1. USART_FLAG_TXE : to indicate the status of the transmit buffer register
// 1122      2. USART_FLAG_RXNE : to indicate the status of the receive buffer register
// 1123      3. USART_FLAG_TC : to indicate the status of the transmit operation
// 1124      4. USART_FLAG_IDLE : to indicate the status of the Idle Line             
// 1125      5. USART_FLAG_CTS : to indicate the status of the nCTS input
// 1126      6. USART_FLAG_LBD : to indicate the status of the LIN break detection
// 1127      7. USART_FLAG_NE : to indicate if a noise error occur
// 1128      8. USART_FLAG_FE : to indicate if a frame error occur
// 1129      9. USART_FLAG_PE : to indicate if a parity error occur
// 1130      10. USART_FLAG_ORE : to indicate if an Overrun error occur
// 1131 
// 1132   In this Mode it is advised to use the following functions:
// 1133       - FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, uint16_t USART_FLAG);
// 1134       - void USART_ClearFlag(USART_TypeDef* USARTx, uint16_t USART_FLAG);
// 1135 
// 1136   Interrupt Mode
// 1137   ===============
// 1138   In Interrupt Mode, the USART communication can be managed by 8 interrupt sources
// 1139   and 10 pending bits: 
// 1140 
// 1141   Pending Bits:
// 1142   ------------- 
// 1143      1. USART_IT_TXE : to indicate the status of the transmit buffer register
// 1144      2. USART_IT_RXNE : to indicate the status of the receive buffer register
// 1145      3. USART_IT_TC : to indicate the status of the transmit operation
// 1146      4. USART_IT_IDLE : to indicate the status of the Idle Line             
// 1147      5. USART_IT_CTS : to indicate the status of the nCTS input
// 1148      6. USART_IT_LBD : to indicate the status of the LIN break detection
// 1149      7. USART_IT_NE : to indicate if a noise error occur
// 1150      8. USART_IT_FE : to indicate if a frame error occur
// 1151      9. USART_IT_PE : to indicate if a parity error occur
// 1152      10. USART_IT_ORE : to indicate if an Overrun error occur
// 1153 
// 1154   Interrupt Source:
// 1155   -----------------
// 1156      1. USART_IT_TXE : specifies the interrupt source for the Tx buffer empty 
// 1157                        interrupt. 
// 1158      2. USART_IT_RXNE : specifies the interrupt source for the Rx buffer not 
// 1159                         empty interrupt.
// 1160      3. USART_IT_TC : specifies the interrupt source for the Transmit complete 
// 1161                        interrupt. 
// 1162      4. USART_IT_IDLE : specifies the interrupt source for the Idle Line interrupt.             
// 1163      5. USART_IT_CTS : specifies the interrupt source for the CTS interrupt. 
// 1164      6. USART_IT_LBD : specifies the interrupt source for the LIN break detection
// 1165                        interrupt. 
// 1166      7. USART_IT_PE : specifies the interrupt source for the parity error interrupt. 
// 1167      8. USART_IT_ERR :  specifies the interrupt source for the errors interrupt.
// 1168 
// 1169 @note Some parameters are coded in order to use them as interrupt source or as pending bits.
// 1170 
// 1171   In this Mode it is advised to use the following functions:
// 1172      - void USART_ITConfig(USART_TypeDef* USARTx, uint16_t USART_IT, FunctionalState NewState);
// 1173      - ITStatus USART_GetITStatus(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1174      - void USART_ClearITPendingBit(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1175 
// 1176   DMA Mode
// 1177   ========
// 1178   In DMA Mode, the USART communication can be managed by 2 DMA Channel requests:
// 1179      1. USART_DMAReq_Tx: specifies the Tx buffer DMA transfer request
// 1180      2. USART_DMAReq_Rx: specifies the Rx buffer DMA transfer request
// 1181 
// 1182   In this Mode it is advised to use the following function:
// 1183      - void USART_DMACmd(USART_TypeDef* USARTx, uint16_t USART_DMAReq, FunctionalState NewState);
// 1184 
// 1185 @endverbatim
// 1186   * @{
// 1187   */
// 1188 
// 1189 /*******************************************************************************
// 1190   * @brief  Enables or disables the specified USART interrupts.
// 1191   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1192   *         UART peripheral.
// 1193   * @param  USART_IT: specifies the USART interrupt sources to be enabled or disabled.
// 1194   *          This parameter can be one of the following values:
// 1195   *            @arg USART_IT_CTS:  CTS change interrupt
// 1196   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1197   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1198   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1199   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1200   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1201   *            @arg USART_IT_PE:   Parity Error interrupt
// 1202   *            @arg USART_IT_ERR:  Error interrupt(Frame error, noise error, overrun error)
// 1203   * @param  NewState: new state of the specified USARTx interrupts.
// 1204   *          This parameter can be: ENABLE or DISABLE.
// 1205   * @retval None
// 1206 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function USART_ITConfig
        THUMB
// 1207 void USART_ITConfig(USART_TypeDef* USARTx, uint16_t USART_IT, FunctionalState NewState)
// 1208 {
// 1209 	uint32_t usartreg = 0x00, itpos = 0x00, itmask = 0x00;
// 1210 	uint32_t usartxbase = 0x00;
// 1211 	/* Check the parameters */
// 1212 	assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1213 	assert_param(IS_USART_CONFIG_IT(USART_IT));
// 1214 	assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1215 
// 1216 	/* The CTS interrupt is not available for UART4 and UART5 */
// 1217 	if (USART_IT == USART_IT_CTS)
// 1218 	{
// 1219 		assert_param(IS_USART_1236_PERIPH(USARTx));
// 1220 	} 
// 1221 
// 1222 	usartxbase = (uint32_t)USARTx;
// 1223 
// 1224 	/* Get the USART register index */
// 1225 	usartreg = (((uint8_t)USART_IT) >> 0x05);
USART_ITConfig:
        LSLS     R3,R1,#+24
        LSRS     R3,R3,#+29
// 1226 
// 1227 	/* Get the interrupt position */
// 1228 	itpos = USART_IT & IT_MASK;
// 1229 	itmask = (((uint32_t)0x01) << itpos);
        MOV      R12,#+1
        AND      R1,R1,#0x1F
        LSL      R1,R12,R1
// 1230 
// 1231 	if (usartreg == 0x01) /* The IT is in CR1 register */
        CMP      R3,#+1
        IT       EQ 
        ADDEQ    R0,R0,#+12
// 1232 	{
// 1233 		usartxbase += 0x0C;
        BEQ.N    ??USART_ITConfig_0
// 1234 	}
// 1235 	else if (usartreg == 0x02) /* The IT is in CR2 register */
        CMP      R3,#+2
        ITE      EQ 
        ADDEQ    R0,R0,#+16
        ADDNE    R0,R0,#+20
// 1236 	{
// 1237 		usartxbase += 0x10;
// 1238 	}
// 1239 	else /* The IT is in CR3 register */
// 1240 	{
// 1241 		usartxbase += 0x14; 
// 1242 	}
// 1243 	if (NewState != DISABLE)
??USART_ITConfig_0:
        CMP      R2,#+0
        LDR      R2,[R0, #+0]
        ITE      NE 
        ORRNE    R1,R1,R2
        BICEQ    R1,R2,R1
// 1244 	{
// 1245 		*(__IO uint32_t*)usartxbase  |= itmask;
// 1246 	}
// 1247 	else
// 1248 	{
// 1249 		*(__IO uint32_t*)usartxbase &= ~itmask;
        STR      R1,[R0, #+0]
// 1250 	}
// 1251 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
// 1252 
// 1253 /**
// 1254   * @brief  Checks whether the specified USART flag is set or not.
// 1255   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1256   *         UART peripheral.
// 1257   * @param  USART_FLAG: specifies the flag to check.
// 1258   *          This parameter can be one of the following values:
// 1259   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5)
// 1260   *            @arg USART_FLAG_LBD:  LIN Break detection flag
// 1261   *            @arg USART_FLAG_TXE:  Transmit data register empty flag
// 1262   *            @arg USART_FLAG_TC:   Transmission Complete flag
// 1263   *            @arg USART_FLAG_RXNE: Receive data register not empty flag
// 1264   *            @arg USART_FLAG_IDLE: Idle Line detection flag
// 1265   *            @arg USART_FLAG_ORE:  OverRun Error flag
// 1266   *            @arg USART_FLAG_NE:   Noise Error flag
// 1267   *            @arg USART_FLAG_FE:   Framing Error flag
// 1268   *            @arg USART_FLAG_PE:   Parity Error flag
// 1269   * @retval The new state of USART_FLAG (SET or RESET).
// 1270   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function USART_GetFlagStatus
        THUMB
// 1271 FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, uint16_t USART_FLAG)
// 1272 {
// 1273   FlagStatus bitstatus = RESET;
USART_GetFlagStatus:
        MOVS     R2,#+0
// 1274   /* Check the parameters */
// 1275   assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1276   assert_param(IS_USART_FLAG(USART_FLAG));
// 1277 
// 1278   /* The CTS flag is not available for UART4 and UART5 */
// 1279   if (USART_FLAG == USART_FLAG_CTS)
// 1280   {
// 1281     assert_param(IS_USART_1236_PERIPH(USARTx));
// 1282   } 
// 1283     
// 1284   if ((USARTx->SR & USART_FLAG) != (uint16_t)RESET)
        LDRH     R0,[R0, #+0]
        TST      R0,R1
        IT       NE 
        MOVNE    R2,#+1
// 1285   {
// 1286     bitstatus = SET;
// 1287   }
// 1288   else
// 1289   {
// 1290     bitstatus = RESET;
// 1291   }
// 1292   return bitstatus;
        MOV      R0,R2
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
// 1293 }
// 1294 
// 1295 /**
// 1296   * @brief  Clears the USARTx's pending flags.
// 1297   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1298   *         UART peripheral.
// 1299   * @param  USART_FLAG: specifies the flag to clear.
// 1300   *          This parameter can be any combination of the following values:
// 1301   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5).
// 1302   *            @arg USART_FLAG_LBD:  LIN Break detection flag.
// 1303   *            @arg USART_FLAG_TC:   Transmission Complete flag.
// 1304   *            @arg USART_FLAG_RXNE: Receive data register not empty flag.
// 1305   *   
// 1306   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1307   *          error) and IDLE (Idle line detected) flags are cleared by software 
// 1308   *          sequence: a read operation to USART_SR register (USART_GetFlagStatus()) 
// 1309   *          followed by a read operation to USART_DR register (USART_ReceiveData()).
// 1310   * @note   RXNE flag can be also cleared by a read to the USART_DR register 
// 1311   *          (USART_ReceiveData()).
// 1312   * @note   TC flag can be also cleared by software sequence: a read operation to 
// 1313   *          USART_SR register (USART_GetFlagStatus()) followed by a write operation
// 1314   *          to USART_DR register (USART_SendData()).
// 1315   * @note   TXE flag is cleared only by a write to the USART_DR register 
// 1316   *          (USART_SendData()).
// 1317   *   
// 1318   * @retval None
// 1319   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function USART_ClearFlag
        THUMB
// 1320 void USART_ClearFlag(USART_TypeDef* USARTx, uint16_t USART_FLAG)
// 1321 {
// 1322   /* Check the parameters */
// 1323   assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1324   assert_param(IS_USART_CLEAR_FLAG(USART_FLAG));
// 1325 
// 1326   /* The CTS flag is not available for UART4 and UART5 */
// 1327   if ((USART_FLAG & USART_FLAG_CTS) == USART_FLAG_CTS)
// 1328   {
// 1329     assert_param(IS_USART_1236_PERIPH(USARTx));
// 1330   } 
// 1331        
// 1332   USARTx->SR = (uint16_t)~USART_FLAG;
USART_ClearFlag:
        B.N      ?Subroutine1
        CFI EndBlock cfiBlock27
// 1333 }
// 1334 
// 1335 /**
// 1336   * @brief  Checks whether the specified USART interrupt has occurred or not.
// 1337   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1338   *         UART peripheral.
// 1339   * @param  USART_IT: specifies the USART interrupt source to check.
// 1340   *          This parameter can be one of the following values:
// 1341   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1342   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1343   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1344   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1345   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1346   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1347   *            @arg USART_IT_ORE:  OverRun Error interrupt
// 1348   *            @arg USART_IT_NE:   Noise Error interrupt
// 1349   *            @arg USART_IT_FE:   Framing Error interrupt
// 1350   *            @arg USART_IT_PE:   Parity Error interrupt
// 1351   * @retval The new state of USART_IT (SET or RESET).
// 1352   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function USART_GetITStatus
        THUMB
// 1353 ITStatus USART_GetITStatus(USART_TypeDef* USARTx, uint16_t USART_IT)
// 1354 {
USART_GetITStatus:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        MOV      R2,R1
// 1355   uint32_t bitpos = 0x00, itmask = 0x00, usartreg = 0x00;
// 1356   ITStatus bitstatus = RESET;
        MOVS     R1,#+0
// 1357   /* Check the parameters */
// 1358   assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1359   assert_param(IS_USART_GET_IT(USART_IT)); 
// 1360 
// 1361   /* The CTS interrupt is not available for UART4 and UART5 */ 
// 1362   if (USART_IT == USART_IT_CTS)
// 1363   {
// 1364     assert_param(IS_USART_1236_PERIPH(USARTx));
// 1365   } 
// 1366     
// 1367   /* Get the USART register index */
// 1368   usartreg = (((uint8_t)USART_IT) >> 0x05);
        LSLS     R3,R2,#+24
        LSRS     R3,R3,#+29
// 1369   /* Get the interrupt position */
// 1370   itmask = USART_IT & IT_MASK;
// 1371   itmask = (uint32_t)0x01 << itmask;
        MOVS     R4,#+1
        AND      R5,R2,#0x1F
        LSL      R5,R4,R5
// 1372   
// 1373   if (usartreg == 0x01) /* The IT  is in CR1 register */
        CMP      R3,#+1
        IT       EQ 
        LDRHEQ   R3,[R0, #+12]
// 1374   {
// 1375     itmask &= USARTx->CR1;
        BEQ.N    ??USART_GetITStatus_0
// 1376   }
// 1377   else if (usartreg == 0x02) /* The IT  is in CR2 register */
        CMP      R3,#+2
        ITE      EQ 
        LDRHEQ   R3,[R0, #+16]
        LDRHNE   R3,[R0, #+20]
// 1378   {
// 1379     itmask &= USARTx->CR2;
// 1380   }
// 1381   else /* The IT  is in CR3 register */
// 1382   {
// 1383     itmask &= USARTx->CR3;
??USART_GetITStatus_0:
        ANDS     R3,R3,R5
// 1384   }
// 1385   
// 1386   bitpos = USART_IT >> 0x08;
// 1387   bitpos = (uint32_t)0x01 << bitpos;
// 1388   bitpos &= USARTx->SR;
        LSRS     R2,R2,#+8
        LSL      R2,R4,R2
        LDRH     R0,[R0, #+0]
        ANDS     R0,R0,R2
// 1389   if ((itmask != (uint16_t)RESET)&&(bitpos != (uint16_t)RESET))
        CBZ.N    R3,??USART_GetITStatus_1
        CBZ.N    R0,??USART_GetITStatus_1
// 1390   {
// 1391     bitstatus = SET;
        MOVS     R1,#+1
// 1392   }
// 1393   else
// 1394   {
// 1395     bitstatus = RESET;
// 1396   }
// 1397   
// 1398   return bitstatus;  
??USART_GetITStatus_1:
        MOV      R0,R1
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock28
// 1399 }
// 1400 
// 1401 /**
// 1402   * @brief  Clears the USARTx's interrupt pending bits.
// 1403   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1404   *         UART peripheral.
// 1405   * @param  USART_IT: specifies the interrupt pending bit to clear.
// 1406   *          This parameter can be one of the following values:
// 1407   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1408   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1409   *            @arg USART_IT_TC:   Transmission complete interrupt. 
// 1410   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt.
// 1411   *
// 1412   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1413   *          error) and IDLE (Idle line detected) pending bits are cleared by 
// 1414   *          software sequence: a read operation to USART_SR register 
// 1415   *          (USART_GetITStatus()) followed by a read operation to USART_DR register 
// 1416   *          (USART_ReceiveData()).
// 1417   * @note   RXNE pending bit can be also cleared by a read to the USART_DR register 
// 1418   *          (USART_ReceiveData()).
// 1419   * @note   TC pending bit can be also cleared by software sequence: a read 
// 1420   *          operation to USART_SR register (USART_GetITStatus()) followed by a write 
// 1421   *          operation to USART_DR register (USART_SendData()).
// 1422   * @note   TXE pending bit is cleared only by a write to the USART_DR register 
// 1423   *          (USART_SendData()).
// 1424   *  
// 1425   * @retval None
// 1426   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function USART_ClearITPendingBit
        THUMB
// 1427 void USART_ClearITPendingBit(USART_TypeDef* USARTx, uint16_t USART_IT)
// 1428 {
// 1429   uint16_t bitpos = 0x00, itmask = 0x00;
// 1430   /* Check the parameters */
// 1431   assert_param(IS_USART_ALL_PERIPH(USARTx));
// 1432   assert_param(IS_USART_CLEAR_IT(USART_IT)); 
// 1433 
// 1434   /* The CTS interrupt is not available for UART4 and UART5 */
// 1435   if (USART_IT == USART_IT_CTS)
// 1436   {
// 1437     assert_param(IS_USART_1236_PERIPH(USARTx));
// 1438   } 
// 1439     
// 1440   bitpos = USART_IT >> 0x08;
// 1441   itmask = ((uint16_t)0x01 << (uint16_t)bitpos);
// 1442   USARTx->SR = (uint16_t)~itmask;
USART_ClearITPendingBit:
        MOVS     R2,#+1
        LSRS     R1,R1,#+8
        LSL      R1,R2,R1
        UXTH     R1,R1
        CFI EndBlock cfiBlock29
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
// 1443 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine1:
        MVNS     R1,R1
        STRH     R1,[R0, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock30

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 1444 
// 1445 /**
// 1446   * @}
// 1447   */
// 1448 
// 1449 /**
// 1450   * @}
// 1451   */
// 1452 
// 1453 /**
// 1454   * @}
// 1455   */
// 1456 
// 1457 /**
// 1458   * @}
// 1459   */
// 1460 
// 1461 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 842 bytes in section .text
// 
// 842 bytes of CODE memory
//
//Errors: none
//Warnings: none
