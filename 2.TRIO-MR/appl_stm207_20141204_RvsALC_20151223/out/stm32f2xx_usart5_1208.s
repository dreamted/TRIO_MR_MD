///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:01 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart5_1208.c                         /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart5_1208.c -D OS_INCLUDED -D       /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_usa /
//                    rt5_1208.s                                              /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_usart5_1208

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        RTMODEL "__iar_require _Printf", "unknown"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN CPU_SR_Restore
        EXTERN CPU_SR_Save
        EXTERN GPIOPortInit
        EXTERN NVIC_Init
        EXTERN OSIntExit
        EXTERN OSIntNesting
        EXTERN OSSemCreate
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OSTimeDly
        EXTERN USART_Cmd
        EXTERN USART_ITConfig
        EXTERN USART_Init
        EXTERN vsprintf

        PUBLIC InitUSART5
        PUBLIC Rx5Buff
        PUBLIC Rx5RdCnt
        PUBLIC Rx5WrCnt
        PUBLIC Tx5Buff
        PUBLIC Tx5RdCnt
        PUBLIC Tx5WrCnt
        PUBLIC USART5BuffClear
        PUBLIC USART5CheckByte
        PUBLIC USART5Printf
        PUBLIC USART5PutChar
        PUBLIC USART5PutStr
        PUBLIC USART5PutToBuffer
        PUBLIC USART5RxGetByte
        PUBLIC USART5TxCheckByte
        PUBLIC USART5TxClear
        PUBLIC USART5_IRQIntHandler
        PUBLIC pUSART5
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_usart5_1208.c
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
//   85 #include "stm32f2xx_usart5_1208.h"
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
//   99 
//  100 /* Private macro -------------------------------------------------------------*/
//  101 /* Private variables ---------------------------------------------------------*/
//  102 #if !defined (OS_INCLUDED) 
//  103 	INT8U Rx5Buff[Rx5BuffLen];
//  104 	INT8U Tx5Buff[Tx5BuffLen];
//  105 
//  106 	INT16U	Rx5RdCnt = 0, Rx5WrCnt = 0;
//  107 	INT16U	Tx5RdCnt = 0, Tx5WrCnt = 0;
//  108 #else

        SECTION iram:DATA:REORDER:NOROOT(2)
//  109 	INT8U Rx5Buff[Rx5BuffLen] @ "iram";
Rx5Buff:
        DS8 2048

        SECTION iram:DATA:REORDER:NOROOT(2)
//  110 	INT8U Tx5Buff[Tx5BuffLen] @ "iram";
Tx5Buff:
        DS8 2048
//  111 

        SECTION iram:DATA:REORDER:NOROOT(2)
//  112 	INT16U	Rx5RdCnt @ "iram"= 0, Rx5WrCnt @ "iram" = 0;
Rx5RdCnt:
        DATA
        DC16 0
Rx5WrCnt:
        DC16 0
//  113 	INT16U	Tx5RdCnt @ "iram"= 0, Tx5WrCnt @ "iram" = 0;
Tx5RdCnt:
        DC16 0
Tx5WrCnt:
        DC16 0
//  114 #endif
//  115 
//  116 #if !defined (OS_INCLUDED) 
//  117 __SerStrPtr pUSART5 = {
//  118 
//  119 #else
//  120 __SerStrPtr pUSART5 @ "iram" = {
pUSART5:
        DC32 InitUSART5, USART5CheckByte, USART5RxGetByte, USART5PutStr
        DC32 USART5Printf, USART5PutChar, USART5PutToBuffer, USART5TxCheckByte
        DC32 USART5BuffClear, USART5TxClear
        DC8 0, 0, 0, 0
//  121 #endif
//  122 	InitUSART5,
//  123 	USART5CheckByte,
//  124 	USART5RxGetByte,
//  125 	USART5PutStr,
//  126 	USART5Printf,
//  127 	USART5PutChar,
//  128 	USART5PutToBuffer,
//  129 	USART5TxCheckByte,
//  130 	USART5BuffClear,
//  131 	USART5TxClear
//  132 };
//  133 /* Private function prototypes -----------------------------------------------*/
//  134 /* Private functions ---------------------------------------------------------*/
//  135 
//  136 /** @defgroup USART_Private_Functions
//  137   * @{
//  138   */
//  139 
//  140 /** @defgroup USART_Group1 Initialization and Configuration functions
//  141  *  @brief   Initialization and Configuration functions 
//  142  *
//  143 @verbatim   
//  144  ===============================================================================
//  145                   Initialization and Configuration functions
//  146  ===============================================================================  
//  147 
//  148   This subsection provides a set of functions allowing to initialize the USART 
//  149   in asynchronous and in synchronous modes.
//  150    - For the asynchronous mode only these parameters can be configured: 
//  151         - Baud Rate
//  152         - Word Length 
//  153         - Stop Bit
//  154         - Parity: If the parity is enabled, then the MSB bit of the data written
//  155           in the data register is transmitted but is changed by the parity bit.
//  156           Depending on the frame length defined by the M bit (8-bits or 9-bits),
//  157           the possible USART frame formats are as listed in the following table:
//  158    +-------------------------------------------------------------+     
//  159    |   M bit |  PCE bit  |            USART frame                |
//  160    |---------------------|---------------------------------------|             
//  161    |    0    |    0      |    | SB | 8 bit data | STB |          |
//  162    |---------|-----------|---------------------------------------|  
//  163    |    0    |    1      |    | SB | 7 bit data | PB | STB |     |
//  164    |---------|-----------|---------------------------------------|  
//  165    |    1    |    0      |    | SB | 9 bit data | STB |          |
//  166    |---------|-----------|---------------------------------------|  
//  167    |    1    |    1      |    | SB | 8 bit data | PB | STB |     |
//  168    +-------------------------------------------------------------+            
//  169         - Hardware flow control
//  170         - Receiver/transmitter modes
//  171 
//  172   The USART_Init() function follows the USART  asynchronous configuration procedure
//  173   (details for the procedure are available in reference manual (RM0033)).
//  174 
//  175   - For the synchronous mode in addition to the asynchronous mode parameters these 
//  176     parameters should be also configured:
//  177         - USART Clock Enabled
//  178         - USART polarity
//  179         - USART phase
//  180         - USART LastBit
//  181   
//  182   These parameters can be configured using the USART_ClockInit() function.
//  183 
//  184 @endverbatim
//  185   * @{
//  186   */
//  187   
//  188 /**
//  189   * @brief  Deinitializes the USARTx peripheral registers to their default reset values.
//  190   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  191   *         UART peripheral.
//  192   * @retval None
//  193   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function InitUSART5
        THUMB
//  194 void InitUSART5(INT32U nBps, INT32U nLCR)
//  195 {
InitUSART5:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+20
        CFI CFA R13+32
        MOV      R5,R0
        MOV      R4,R1
//  196 	USART_InitTypeDef USART_InitStructure;
//  197 
//  198 ///
//  199 // PORT INIT
//  200 	RCC->__B.AHB1ENR.IOPCEN = ENABLE;
        LDR.N    R0,??DataTable9_1  ;; 0x40023830
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x4
        STR      R1,[R0, #+0]
//  201 	RCC->__B.AHB1ENR.IOPDEN = ENABLE;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x8
        STR      R1,[R0, #+0]
//  202 
//  203 	RCC->__B.APB1ENR.UART5EN = ENABLE;
        LDR      R1,[R0, #+16]
        ORR      R1,R1,#0x100000
        STR      R1,[R0, #+16]
//  204 	
//  205 	__PC12_U5_TX(); 			// USART5_TX
        MOVS     R3,#+12
        LDR.N    R2,??DataTable9_2  ;; 0x40020800
        MOVS     R1,#+8
        MOVS     R0,#+38
        BL       GPIOPortInit
//  206 	__PD2_U5_RX();				// USART5_RX
        MOVS     R3,#+2
        LDR.N    R2,??DataTable9_3  ;; 0x40020c00
        MOVS     R1,#+8
        MOVS     R0,#+38
        BL       GPIOPortInit
//  207 
//  208 ////////////////////////////////////////////////////////////////////////////////
//  209 	USART_InitStructure.USART_BaudRate = nBps;
        STR      R5,[SP, #+0]
//  210 
//  211 	if( ((nLCR >> 4) & 0x01) ==  (_DATA8BIT >> 4)) {
        LSLS     R0,R4,#+27
        ITE      PL 
        MOVPL    R0,#+0
        MOVMI    R0,#+4096
//  212 			USART_InitStructure.USART_WordLength = USART_WordLength_8b;
//  213 	}
//  214 	else	USART_InitStructure.USART_WordLength = USART_WordLength_9b;
        STRH     R0,[SP, #+4]
//  215 
//  216 ////////////////////////////////////////////////////////////////////////////////
//  217 	if( ((nLCR >> 2) & 0x02) ==  (_05STOP >> 2)) {
//  218 		USART_InitStructure.USART_StopBits = USART_StopBits_0_5;
//  219 	}
//  220 	else if( ((nLCR >> 2) & 0x02) ==  (_1_STOP >> 2)) {
        LSRS     R0,R4,#+2
        LSLS     R0,R0,#+30
        ITE      PL 
        MOVPL    R0,#+0
        MOVMI    R0,#+8192
//  221 			USART_InitStructure.USART_StopBits = USART_StopBits_1;
//  222 	}
//  223 	else if( ((nLCR >> 2) & 0x02) ==  (_2_STOP >> 2)) {
//  224 			USART_InitStructure.USART_StopBits = USART_StopBits_2;
        STRH     R0,[SP, #+6]
//  225 	}
//  226 	else	USART_InitStructure.USART_StopBits = USART_StopBits_1_5;
//  227 	
//  228 ////////////////////////////////////////////////////////////////////////////////
//  229 	
//  230 	if(((nLCR >> 0) & 0x03) == (_NONPARITY >> 0)){
        ANDS     R0,R4,#0x3
        IT       EQ 
        MOVEQ    R0,#+0
//  231 		USART_InitStructure.USART_Parity = USART_Parity_No;
        BEQ.N    ??InitUSART5_0
//  232 	}
//  233 	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0)){
        CMP      R0,#+1
        ITE      EQ 
        MOVEQ    R0,#+1536
        MOVNE    R0,#+1024
//  234 		USART_InitStructure.USART_Parity = USART_Parity_Odd;
//  235 	}
//  236 	else{
//  237 		USART_InitStructure.USART_Parity = USART_Parity_Even;
??InitUSART5_0:
        STRH     R0,[SP, #+8]
//  238 	}
//  239 	
//  240 	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
        MOVS     R0,#+0
        STRH     R0,[SP, #+12]
//  241 	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
        MOVS     R0,#+12
        STRH     R0,[SP, #+10]
//  242 
//  243 	/* USART configuration */
//  244 	USART_Init(UART5, &USART_InitStructure);
        LDR.N    R4,??DataTable9_4  ;; 0x40005000
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       USART_Init
//  245 
//  246 #if defined (OS_INCLUDED) 
//  247 	pUSART5.sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.N    R1,??DataTable9_5
        STR      R0,[R1, #+48]
//  248 #endif
//  249 	/* Enable USART */
//  250 	USART_Cmd(UART5, ENABLE);
        MOVS     R1,#+1
        MOV      R0,R4
        BL       USART_Cmd
//  251 
//  252 	USART_ITConfig(UART5, USART_IT_RXNE, ENABLE);
        MOVS     R2,#+1
        MOVW     R1,#+1317
        MOV      R0,R4
        BL       USART_ITConfig
//  253 	NVIC_Init(UART5_IRQn, ENABLE); 
        MOVS     R1,#+1
        MOVS     R0,#+53
        BL       NVIC_Init
//  254 
//  255 	USART5Printf("\n");	
        ADR.N    R0,??DataTable9  ;; "\n"
        BL       USART5Printf
//  256 }
        ADD      SP,SP,#+20
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        CFI EndBlock cfiBlock0
//  257 
//  258 /*******************************************************************************
//  259   * @brief  Interrupt handler USART5 global interrupt request
//  260   * @param  None 
//  261   * @retval None
//  262   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function USART5_IRQIntHandler
        THUMB
//  263 void USART5_IRQIntHandler(void)
//  264 {
USART5_IRQIntHandler:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
//  265 
//  266 	INT16U tmp = UART5->SR;
        LDR.N    R4,??DataTable9_4  ;; 0x40005000
        LDRH     R5,[R4, #+0]
//  267 
//  268 #ifdef OS_INCLUDED
//  269 	INT32U cpu_sr;
//  270 	CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
        BL       CPU_SR_Save
//  271 	OSIntNesting++;
        LDR.N    R1,??DataTable9_6
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  272 	CPU_CRITICAL_EXIT();
        BL       CPU_SR_Restore
//  273 #endif /* OS_INCLUDED */
//  274 	// Rx Data Received
//  275 	if(tmp & ( 1 << __RXNE))
        LSLS     R0,R5,#+26
        BPL.N    ??USART5_IRQIntHandler_0
//  276 	{
//  277 		Rx5Buff[Rx5WrCnt%Rx5BuffLen] = UART5->DR;		// When the receive register is read, the RDR bit is automatically cleared.
        LDR.N    R0,??DataTable9_5
        LDRH     R1,[R0, #+2]
        LSLS     R2,R1,#+21
        LSRS     R2,R2,#+21
        LDR.N    R3,??DataTable9_7
        LDRH     R4,[R4, #+4]
        STRB     R4,[R2, R3]
//  278 		if(++Rx5WrCnt >= Rx5BuffLen) Rx5WrCnt = 0;
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+2]
        UXTH     R1,R1
        CMP      R1,#+2048
        BCC.N    ??USART5_IRQIntHandler_1
        MOVS     R1,#+0
        STRH     R1,[R0, #+2]
        B.N      ??USART5_IRQIntHandler_1
//  279 	}
//  280 	else if(tmp & ( 1 << __TXE))
??USART5_IRQIntHandler_0:
        LSLS     R0,R5,#+24
        BPL.N    ??USART5_IRQIntHandler_2
//  281 	{
//  282 		if(Tx5RdCnt != Tx5WrCnt)
        LDR.N    R0,??DataTable9_5
        LDRH     R1,[R0, #+4]
        LDRH     R2,[R0, #+6]
        CMP      R1,R2
        BEQ.N    ??USART5_IRQIntHandler_3
//  283 		{
//  284 			UART5->DR = Tx5Buff[Tx5RdCnt%Tx5BuffLen];
        LSLS     R1,R1,#+21
        LSRS     R1,R1,#+21
        LDR.N    R2,??DataTable9_8
        LDRB     R1,[R1, R2]
        STRH     R1,[R4, #+4]
//  285 			if(++Tx5RdCnt >= Tx5BuffLen ) Tx5RdCnt = 0;
        LDRH     R1,[R0, #+4]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+4]
        UXTH     R1,R1
        CMP      R1,#+2048
        BCC.N    ??USART5_IRQIntHandler_1
        MOVS     R1,#+0
        STRH     R1,[R0, #+4]
        B.N      ??USART5_IRQIntHandler_1
//  286 		}
//  287 		else UART5->__B.CR1.TXEIE = DISABLE;
??USART5_IRQIntHandler_3:
        LDR      R0,[R4, #+12]
        BIC      R0,R0,#0x80
        STR      R0,[R4, #+12]
        B.N      ??USART5_IRQIntHandler_1
//  288 	}
//  289 	else // error, dummy read
//  290 	{
//  291 		tmp =  UART5->DR;
??USART5_IRQIntHandler_2:
        LDRH     R0,[R4, #+4]
//  292 	}
//  293 
//  294 #ifdef OS_INCLUDED
//  295 	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
??USART5_IRQIntHandler_1:
        POP      {R0,R4,R5,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      OSIntExit
        CFI EndBlock cfiBlock1
//  296 #endif /* OS_INCLUDED */
//  297 
//  298 }
//  299 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function USART5PutToBuffer
        THUMB
//  300 unsigned char USART5PutToBuffer(unsigned char Data)
//  301 {
USART5PutToBuffer:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R5,R0
//  302 #ifdef OS_INCLUDED
//  303 	INT8U err;
//  304 	//////////////////////////////////////////////////
//  305 
//  306 	OSSemPend(pUSART5.sem, 0, &err);
        LDR.N    R4,??DataTable9_5
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  307 #endif /* OS_INCLUDED */
//  308 	//////////////////////////////////////////////////
//  309 	Tx5Buff[Tx5WrCnt%Tx5BuffLen] = Data;
        LDRH     R0,[R4, #+6]
        LSLS     R1,R0,#+21
        LSRS     R1,R1,#+21
        LDR.N    R2,??DataTable9_8
        STRB     R5,[R1, R2]
//  310 	if(++Tx5WrCnt >= Tx5BuffLen) Tx5WrCnt = 0;
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        CMP      R0,#+2048
        IT       CS 
        MOVCS    R0,#+0
        STRH     R0,[R4, #+6]
//  311 	
//  312 	UART5->__B.CR1.TXEIE = ENABLE; 		
        LDR.N    R0,??DataTable9_9  ;; 0x4000500c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+0]
//  313 	///////////////////////////////////////////////////
//  314 #ifdef OS_INCLUDED
//  315 	OSSemPost(pUSART5.sem);
        LDR      R0,[R4, #+48]
        BL       OSSemPost
//  316 #endif /* OS_INCLUDED */
//  317 
//  318 	return 0;
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock2
//  319 }
//  320 
//  321 
//  322 
//  323 //Not using interrupt

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function USART5PutChar
        THUMB
//  324 unsigned char USART5PutChar(unsigned char Data)
//  325 {
USART5PutChar:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R4,R0
//  326 	#ifdef OS_INCLUDED
//  327 		INT8U err;
//  328 		//////////////////////////////////////////////////
//  329 	
//  330 		OSSemPend(pUSART5.sem, 0, &err);
        LDR.N    R5,??DataTable9_5
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R5, #+48]
        BL       OSSemPend
//  331 	#endif /* OS_INCLUDED */
//  332 		UART5->__B.DR.DR = Data;
        LDR.N    R0,??DataTable9_4  ;; 0x40005000
        LDR      R1,[R0, #+4]
        BFI      R1,R4,#+0,#+9
        STR      R1,[R0, #+4]
//  333 		while(!UART5->__B.SR.TXE);
??USART5PutChar_0:
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??USART5PutChar_0
//  334 	#ifdef OS_INCLUDED
//  335 		OSSemPost(pUSART5.sem);
        LDR      R0,[R5, #+48]
        BL       OSSemPost
//  336 	#endif /* OS_INCLUDED */
//  337 	return Data;
        MOV      R0,R4
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock3
//  338 }
//  339 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function USART5Printf
        THUMB
//  340 unsigned long int USART5Printf( const char *format, ...)
//  341 {
USART5Printf:
        PUSH     {R1-R3}
        CFI CFA R13+12
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        SUB      SP,SP,#+128
        CFI CFA R13+152
//  342 	unsigned long int i, cnt;
//  343 	char buf[128];
//  344 	va_list argptr;
//  345 
//  346 	va_start(argptr, format);
        ADD      R2,SP,#+140
//  347 	cnt = vsprintf(buf, format, argptr);
        MOV      R1,R0
        ADD      R0,SP,#+0
        BL       vsprintf
        MOV      R4,R0
//  348 	va_end( argptr );
//  349 
//  350 	for(i = 0;;i++)
        ADD      R5,SP,#+0
        B.N      ??USART5Printf_0
//  351 	{
//  352 		if(buf[i] == 0) break;
//  353 		if(buf[i] == '\n') USART5PutToBuffer('\r');
??USART5Printf_1:
        CMP      R0,#+10
        ITT      EQ 
        MOVEQ    R0,#+13
        BLEQ     USART5PutToBuffer
//  354 		USART5PutToBuffer(buf[i]);
        LDRB     R0,[R5], #+1
        BL       USART5PutToBuffer
??USART5Printf_0:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??USART5Printf_1
//  355 	}
//  356 	while(!USART5TxCheckByte())
??USART5Printf_2:
        BL       USART5TxCheckByte
        CBNZ.N   R0,??USART5Printf_3
//  357 	{
//  358 #ifdef OS_INCLUDED
//  359 	OSTimeDly(1);
        MOVS     R0,#+1
        BL       OSTimeDly
        B.N      ??USART5Printf_2
//  360 #endif /* OS_INCLUDED */
//  361 	}
//  362 	return cnt;
??USART5Printf_3:
        MOV      R0,R4
        ADD      SP,SP,#+128
        CFI CFA R13+24
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+16
        LDR      PC,[SP], #+16    ;; return
        CFI EndBlock cfiBlock4
//  363 }
//  364 
//  365 //#define OS_INCLUDED
//  366 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function USART5PutStr
        THUMB
//  367 void USART5PutStr(unsigned char *Str, unsigned short int Length, int iEn)
//  368 {
USART5PutStr:
        PUSH     {R3-R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI R7 Frame(CFA, -8)
        CFI R6 Frame(CFA, -12)
        CFI R5 Frame(CFA, -16)
        CFI R4 Frame(CFA, -20)
        CFI CFA R13+24
        MOV      R5,R0
        MOV      R6,R1
        MOV      R7,R2
//  369 	u32 i = 0;
//  370 
//  371 	USART5BuffClear();
        BL       USART5BuffClear
//  372 	
//  373 #ifdef OS_INCLUDED
//  374 	INT8U err;
//  375 	OSSemPend(pUSART5.sem, 0, &err);
        LDR.N    R4,??DataTable9_5
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  376 #endif /* OS_INCLUDED */
//  377 
//  378 
//  379 	for(i = 0; i < Length; i++)
        LDRH     R0,[R4, #+6]
        CBZ.N    R6,??USART5PutStr_0
        LDR.N    R1,??DataTable9_8
//  380 	{
//  381 		Tx5Buff[Tx5WrCnt++] = Str[i];
??USART5PutStr_1:
        LDRB     R2,[R5, #+0]
        STRB     R2,[R0, R1]
        ADDS     R0,R0,#+1
//  382 		if(Tx5WrCnt >= Tx5BuffLen) Tx5WrCnt = 0;
        UXTH     R0,R0
        CMP      R0,#+2048
        IT       CS 
        MOVCS    R0,#+0
//  383 	}
        ADDS     R5,R5,#+1
        SUBS     R6,R6,#+1
        BNE.N    ??USART5PutStr_1
??USART5PutStr_0:
        STRH     R0,[R4, #+6]
//  384 
//  385 	if(iEn)
        CBZ.N    R7,??USART5PutStr_2
//  386 	{
//  387 		UART5->__B.CR1.TXEIE = ENABLE;
        LDR.N    R0,??DataTable9_9  ;; 0x4000500c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+0]
//  388 	}	
//  389 #ifdef OS_INCLUDED
//  390 		OSSemPost(pUSART5.sem);
??USART5PutStr_2:
        LDR      R0,[R4, #+48]
        BL       OSSemPost
//  391 #endif /* OS_INCLUDED */
//  392 }
        POP      {R0,R4-R7,PC}    ;; return
        CFI EndBlock cfiBlock5
//  393 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function USART5RxGetByte
        THUMB
//  394 signed short int USART5RxGetByte(void)
//  395 {
//  396 	s16 RetVal = 0;
//  397 
//  398 #ifndef APPL_SRC
//  399 	while(Rx5RdCnt == Rx5WrCnt);
//  400 #else
//  401 	if(Rx5RdCnt == Rx5WrCnt) return -1;
USART5RxGetByte:
        LDR.N    R1,??DataTable9_5
        LDRH     R2,[R1, #+0]
        LDRH     R0,[R1, #+2]
        CMP      R2,R0
        BNE.N    ??USART5RxGetByte_0
        MOV      R0,#-1
        BX       LR
//  402 #endif
//  403 
//  404 	RetVal = Rx5Buff[Rx5RdCnt%Rx5BuffLen];
??USART5RxGetByte_0:
        LSLS     R0,R2,#+21
        LSRS     R0,R0,#+21
        LDR.N    R3,??DataTable9_7
        LDRB     R0,[R0, R3]
//  405 	if(++Rx5RdCnt >= Rx5BuffLen) Rx5RdCnt = 0;
        ADDS     R2,R2,#+1
        STRH     R2,[R1, #+0]
        UXTH     R2,R2
        CMP      R2,#+2048
        BCC.N    ??USART5RxGetByte_1
        MOVS     R2,#+0
        STRH     R2,[R1, #+0]
//  406 
//  407 	return (RetVal & 0xff);
??USART5RxGetByte_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  408 }
//  409 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function USART5CheckByte
        THUMB
//  410 unsigned char USART5CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
//  411 {
USART5CheckByte:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  412 	u32 i = 0, j = 0;
//  413 	u8 RetVal = TRUE;
        MOVS     R2,#+1
//  414 
//  415 	*Recv = 0;
        MOVS     R3,#+0
        STRH     R3,[R1, #+0]
//  416 	i = (u32) Rx5RdCnt;
        LDR.N    R3,??DataTable9_5
        LDRH     R4,[R3, #+0]
//  417 	j = (u32) Rx5WrCnt;
        LDRH     R3,[R3, #+2]
//  418 
//  419 	if(i == j) RetVal = FALSE;
        CMP      R4,R3
        BEQ.N    ??USART5CheckByte_0
//  420 	else if(i < j)
        ADDS     R0,R0,R4
        CMP      R4,R3
        BCS.N    ??USART5CheckByte_1
//  421 	{
//  422 		*Recv = j - i;
        SUBS     R4,R3,R4
        STRH     R4,[R1, #+0]
//  423 		i = i + ByteCnt;
//  424 		if(i > j) RetVal = FALSE;
        CMP      R3,R0
        BCS.N    ??USART5CheckByte_2
        B.N      ??USART5CheckByte_0
//  425 	}
//  426 	else if(i > j)
//  427 	{
//  428 		*Recv = (Rx5BuffLen +j) - i;
??USART5CheckByte_1:
        ADD      R5,R3,#+2048
        SUBS     R4,R5,R4
        STRH     R4,[R1, #+0]
//  429 		i = i + ByteCnt;
//  430 		j = j + Rx5BuffLen;
//  431 		if(i > j) RetVal = FALSE; 
        ADD      R1,R3,#+2048
        CMP      R1,R0
        BCS.N    ??USART5CheckByte_2
??USART5CheckByte_0:
        MOVS     R2,#+0
//  432 	}
//  433 	return (RetVal);
??USART5CheckByte_2:
        MOV      R0,R2
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  434 }
//  435 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function USART5BuffClear
        THUMB
//  436 void USART5BuffClear(void)
//  437 {
//  438 	Rx5RdCnt = 0;
USART5BuffClear:
        LDR.N    R0,??DataTable9_5
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  439 	Rx5WrCnt = 0;
        STRH     R1,[R0, #+2]
//  440 	Tx5RdCnt = 0;
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock8
//  441 	Tx5WrCnt = 0;
//  442 }
//  443 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function USART5TxClear
        THUMB
//  444 void USART5TxClear(void)
//  445 {
//  446 	Tx5RdCnt = 0;
USART5TxClear:
        LDR.N    R0,??DataTable9_5
        MOVS     R1,#+0
        CFI EndBlock cfiBlock9
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  447 	Tx5WrCnt = 0;
//  448 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        STRH     R1,[R0, #+4]
        STRH     R1,[R0, #+6]
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  449 
//  450 /*******************************************************************************
//  451   * @brief  if the bytes have been transmitted, retrun true or not
//  452   * @param  None
//  453   * @retval TRUE/FALSE
//  454   ******************************************************************************/
//  455 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function USART5TxCheckByte
        THUMB
//  456 signed short int USART5TxCheckByte(void)
//  457 {
//  458 	if(Tx5RdCnt == Tx5WrCnt) return TRUE;
USART5TxCheckByte:
        LDR.N    R0,??DataTable9_5
        LDRH     R1,[R0, #+4]
        LDRH     R0,[R0, #+6]
        CMP      R1,R0
        BNE.N    ??USART5TxCheckByte_0
        MOVS     R0,#+1
        BX       LR
//  459 	else return FALSE;
??USART5TxCheckByte_0:
        MOVS     R0,#+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  460 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC8      "\n",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0x40023830

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0x40020800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x40020c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0x40005000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     Rx5RdCnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC32     Rx5Buff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC32     Tx5Buff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_9:
        DC32     0x4000500c

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
`?<Constant "\\n">`:
        DC8 "\012"

        END
//  461 
//  462 
//  463 
//  464 
//  465 /**
//  466   * @brief  Initializes the USARTx peripheral Clock according to the 
//  467   *         specified parameters in the USART_ClockInitStruct .
//  468   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART peripheral.
//  469   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure that
//  470   *         contains the configuration information for the specified  USART peripheral.
//  471   * @note   The Smart Card and Synchronous modes are not available for UART4 and UART5.    
//  472   * @retval None
//  473   */
//  474 
//  475 /**
//  476   * @brief  Fills each USART_ClockInitStruct member with its default value.
//  477   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure
//  478   *         which will be initialized.
//  479   * @retval None
//  480   */
//  481 
//  482 
//  483 /**
//  484   * @brief  Enables or disables the specified USART peripheral.
//  485   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  486   *         UART peripheral.
//  487   * @param  NewState: new state of the USARTx peripheral.
//  488   *          This parameter can be: ENABLE or DISABLE.
//  489   * @retval None
//  490   */
//  491 
//  492 
//  493 /**
//  494   * @brief  Sets the system clock prescaler.
//  495   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  496   *         UART peripheral.
//  497   * @param  USART_Prescaler: specifies the prescaler clock. 
//  498   * @note   The function is used for IrDA mode with UART4 and UART5.   
//  499   * @retval None
//  500   */
//  501 
//  502 /**
//  503   * @brief  Enables or disables the USART's 8x oversampling mode.
//  504   * @note   This function has to be called before calling USART_Init() function
//  505   *         in order to have correct baudrate Divider value.
//  506   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  507   *         UART peripheral.
//  508   * @param  NewState: new state of the USART 8x oversampling mode.
//  509   *          This parameter can be: ENABLE or DISABLE.
//  510   * @retval None
//  511   */
//  512   
//  513 
//  514 /**
//  515   * @brief  Enables or disables the USART's one bit sampling method.
//  516   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  517   *         UART peripheral.
//  518   * @param  NewState: new state of the USART one bit sampling method.
//  519   *          This parameter can be: ENABLE or DISABLE.
//  520   * @retval None
//  521   */
//  522 
//  523 /**
//  524   * @}
//  525   */
//  526 
//  527 /** @defgroup USART_Group2 Data transfers functions
//  528  *  @brief   Data transfers functions 
//  529  *
//  530 @verbatim   
//  531  ===============================================================================
//  532                             Data transfers functions
//  533  ===============================================================================  
//  534 
//  535   This subsection provides a set of functions allowing to manage the USART data 
//  536   transfers.
//  537   
//  538   During an USART reception, data shifts in least significant bit first through 
//  539   the RX pin. In this mode, the USART_DR register consists of a buffer (RDR) 
//  540   between the internal bus and the received shift register.
//  541 
//  542   When a transmission is taking place, a write instruction to the USART_DR register 
//  543   stores the data in the TDR register and which is copied in the shift register 
//  544   at the end of the current transmission.
//  545 
//  546   The read access of the USART_DR register can be done using the USART_ReceiveData()
//  547   function and returns the RDR buffered value. Whereas a write access to the USART_DR 
//  548   can be done using USART_SendData() function and stores the written data into 
//  549   TDR buffer.
//  550 
//  551 @endverbatim
//  552   * @{
//  553   */
//  554 
//  555 /**
//  556   * @brief  Transmits single data through the USARTx peripheral.
//  557   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  558   *         UART peripheral.
//  559   * @param  Data: the data to transmit.
//  560   * @retval None
//  561   */
//  562 
//  563 
//  564 /**
//  565   * @brief  Returns the most recent received data by the USARTx peripheral.
//  566   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  567   *         UART peripheral.
//  568   * @retval The received data.
//  569   */
//  570 
//  571 /**
//  572   * @}
//  573   */
//  574 
//  575 /** @defgroup USART_Group3 MultiProcessor Communication functions
//  576  *  @brief   Multi-Processor Communication functions 
//  577  *
//  578 @verbatim   
//  579  ===============================================================================
//  580                     Multi-Processor Communication functions
//  581  ===============================================================================  
//  582 
//  583   This subsection provides a set of functions allowing to manage the USART 
//  584   multiprocessor communication.
//  585   
//  586   For instance one of the USARTs can be the master, its TX output is connected to 
//  587   the RX input of the other USART. The others are slaves, their respective TX outputs 
//  588   are logically ANDed together and connected to the RX input of the master.
//  589 
//  590   USART multiprocessor communication is possible through the following procedure:
//  591      1. Program the Baud rate, Word length = 9 bits, Stop bits, Parity, Mode transmitter 
//  592         or Mode receiver and hardware flow control values using the USART_Init()
//  593         function.
//  594      2. Configures the USART address using the USART_SetAddress() function.
//  595      3. Configures the wake up method (USART_WakeUp_IdleLine or USART_WakeUp_AddressMark)
//  596         using USART_WakeUpConfig() function only for the slaves.
//  597      4. Enable the USART using the USART_Cmd() function.
//  598      5. Enter the USART slaves in mute mode using USART_ReceiverWakeUpCmd() function.
//  599 
//  600   The USART Slave exit from mute mode when receive the wake up condition.
//  601 
//  602 @endverbatim
//  603   * @{
//  604   */
//  605 
//  606 /**
//  607   * @brief  Sets the address of the USART node.
//  608   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  609   *         UART peripheral.
//  610   * @param  USART_Address: Indicates the address of the USART node.
//  611   * @retval None
//  612   */
//  613 
//  614 
//  615 /**
//  616   * @brief  Determines if the USART is in mute mode or not.
//  617   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  618   *         UART peripheral.
//  619   * @param  NewState: new state of the USART mute mode.
//  620   *          This parameter can be: ENABLE or DISABLE.
//  621   * @retval None
//  622   */
//  623 
//  624 /**
//  625   * @brief  Selects the USART WakeUp method.
//  626   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  627   *         UART peripheral.
//  628   * @param  USART_WakeUp: specifies the USART wakeup method.
//  629   *          This parameter can be one of the following values:
//  630   *            @arg USART_WakeUp_IdleLine: WakeUp by an idle line detection
//  631   *            @arg USART_WakeUp_AddressMark: WakeUp by an address mark
//  632   * @retval None
//  633   */
//  634 
//  635 
//  636 /**
//  637   * @}
//  638   */
//  639 
//  640 /** @defgroup USART_Group4 LIN mode functions
//  641  *  @brief   LIN mode functions 
//  642  *
//  643 @verbatim   
//  644  ===============================================================================
//  645                                 LIN mode functions
//  646  ===============================================================================  
//  647 
//  648   This subsection provides a set of functions allowing to manage the USART LIN 
//  649   Mode communication.
//  650   
//  651   In LIN mode, 8-bit data format with 1 stop bit is required in accordance with 
//  652   the LIN standard.
//  653 
//  654   Only this LIN Feature is supported by the USART IP:
//  655     - LIN Master Synchronous Break send capability and LIN slave break detection
//  656       capability :  13-bit break generation and 10/11 bit break detection
//  657 
//  658 
//  659   USART LIN Master transmitter communication is possible through the following procedure:
//  660      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  661         Mode transmitter or Mode receiver and hardware flow control values using 
//  662         the USART_Init() function.
//  663      2. Enable the USART using the USART_Cmd() function.
//  664      3. Enable the LIN mode using the USART_LINCmd() function.
//  665      4. Send the break character using USART_SendBreak() function.
//  666 
//  667   USART LIN Master receiver communication is possible through the following procedure:
//  668      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  669         Mode transmitter or Mode receiver and hardware flow control values using 
//  670         the USART_Init() function.
//  671      2. Enable the USART using the USART_Cmd() function.
//  672      3. Configures the break detection length using the USART_LINBreakDetectLengthConfig()
//  673         function.
//  674      4. Enable the LIN mode using the USART_LINCmd() function.
//  675 
//  676 
//  677 @note In LIN mode, the following bits must be kept cleared:
//  678         - CLKEN in the USART_CR2 register,
//  679         - STOP[1:0], SCEN, HDSEL and IREN in the USART_CR3 register.
//  680 
//  681 @endverbatim
//  682   * @{
//  683   */
//  684 
//  685 /**
//  686   * @brief  Sets the USART LIN Break detection length.
//  687   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  688   *         UART peripheral.
//  689   * @param  USART_LINBreakDetectLength: specifies the LIN break detection length.
//  690   *          This parameter can be one of the following values:
//  691   *            @arg USART_LINBreakDetectLength_10b: 10-bit break detection
//  692   *            @arg USART_LINBreakDetectLength_11b: 11-bit break detection
//  693   * @retval None
//  694   */
//  695 
//  696 /**
//  697   * @brief  Enables or disables the USART's LIN mode.
//  698   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  699   *         UART peripheral.
//  700   * @param  NewState: new state of the USART LIN mode.
//  701   *          This parameter can be: ENABLE or DISABLE.
//  702   * @retval None
//  703   */
//  704 
//  705 
//  706 /**
//  707   * @brief  Transmits break characters.
//  708   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  709   *         UART peripheral.
//  710   * @retval None
//  711   */
//  712 
//  713 
//  714 /**
//  715   * @}
//  716   */
//  717 
//  718 /** @defgroup USART_Group5 Halfduplex mode function
//  719  *  @brief   Half-duplex mode function 
//  720  *
//  721 @verbatim   
//  722  ===============================================================================
//  723                          Half-duplex mode function
//  724  ===============================================================================  
//  725 
//  726   This subsection provides a set of functions allowing to manage the USART 
//  727   Half-duplex communication.
//  728   
//  729   The USART can be configured to follow a single-wire half-duplex protocol where 
//  730   the TX and RX lines are internally connected.
//  731 
//  732   USART Half duplex communication is possible through the following procedure:
//  733      1. Program the Baud rate, Word length, Stop bits, Parity, Mode transmitter 
//  734         or Mode receiver and hardware flow control values using the USART_Init()
//  735         function.
//  736      2. Configures the USART address using the USART_SetAddress() function.
//  737      3. Enable the USART using the USART_Cmd() function.
//  738      4. Enable the half duplex mode using USART_HalfDuplexCmd() function.
//  739 
//  740 
//  741 @note The RX pin is no longer used
//  742 @note In Half-duplex mode the following bits must be kept cleared:
//  743         - LINEN and CLKEN bits in the USART_CR2 register.
//  744         - SCEN and IREN bits in the USART_CR3 register.
//  745 
//  746 @endverbatim
//  747   * @{
//  748   */
//  749 
//  750 /**
//  751   * @brief  Enables or disables the USART's Half Duplex communication.
//  752   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  753   *         UART peripheral.
//  754   * @param  NewState: new state of the USART Communication.
//  755   *          This parameter can be: ENABLE or DISABLE.
//  756   * @retval None
//  757   */
//  758 
//  759 
//  760 /**
//  761   * @}
//  762   */
//  763 
//  764 
//  765 /** @defgroup USART_Group6 Smartcard mode functions
//  766  *  @brief   Smartcard mode functions 
//  767  *
//  768 @verbatim   
//  769  ===============================================================================
//  770                                Smartcard mode functions
//  771  ===============================================================================  
//  772 
//  773   This subsection provides a set of functions allowing to manage the USART 
//  774   Smartcard communication.
//  775   
//  776   The Smartcard interface is designed to support asynchronous protocol Smartcards as
//  777   defined in the ISO 7816-3 standard.
//  778 
//  779   The USART can provide a clock to the smartcard through the SCLK output.
//  780   In smartcard mode, SCLK is not associated to the communication but is simply derived 
//  781   from the internal peripheral input clock through a 5-bit prescaler.
//  782 
//  783   Smartcard communication is possible through the following procedure:
//  784      1. Configures the Smartcard Prescaler using the USART_SetPrescaler() function.
//  785      2. Configures the Smartcard Guard Time using the USART_SetGuardTime() function.
//  786      3. Program the USART clock using the USART_ClockInit() function as following:
//  787         - USART Clock enabled
//  788         - USART CPOL Low
//  789         - USART CPHA on first edge
//  790         - USART Last Bit Clock Enabled
//  791      4. Program the Smartcard interface using the USART_Init() function as following:
//  792         - Word Length = 9 Bits
//  793         - 1.5 Stop Bit
//  794         - Even parity
//  795         - BaudRate = 12096 baud
//  796         - Hardware flow control disabled (RTS and CTS signals)
//  797         - Tx and Rx enabled
//  798      5. Optionally you can enable the parity error interrupt using the USART_ITConfig()
//  799         function
//  800      6. Enable the USART using the USART_Cmd() function.
//  801      7. Enable the Smartcard NACK using the USART_SmartCardNACKCmd() function.
//  802      8. Enable the Smartcard interface using the USART_SmartCardCmd() function.
//  803 
//  804   Please refer to the ISO 7816-3 specification for more details.
//  805 
//  806 
//  807 @note It is also possible to choose 0.5 stop bit for receiving but it is recommended 
//  808       to use 1.5 stop bits for both transmitting and receiving to avoid switching 
//  809       between the two configurations.
//  810 @note In smartcard mode, the following bits must be kept cleared:
//  811         - LINEN bit in the USART_CR2 register.
//  812         - HDSEL and IREN bits in the USART_CR3 register.
//  813 @note Smartcard mode is available on USART peripherals only (not available on UART4 
//  814       and UART5 peripherals).
//  815 
//  816 @endverbatim
//  817   * @{
//  818   */
//  819 
//  820 /**
//  821   * @brief  Sets the specified USART guard time.
//  822   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  823   *         UART peripheral.
//  824   * @param  USART_GuardTime: specifies the guard time.   
//  825   * @retval None
//  826   */
//  827 
//  828 /**
//  829   * @brief  Enables or disables the USART's Smart Card mode.
//  830   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  831   *         UART peripheral.
//  832   * @param  NewState: new state of the Smart Card mode.
//  833   *          This parameter can be: ENABLE or DISABLE.      
//  834   * @retval None
//  835   */
//  836 
//  837 
//  838 /**
//  839   * @brief  Enables or disables NACK transmission.
//  840   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  841   *         UART peripheral.
//  842   * @param  NewState: new state of the NACK transmission.
//  843   *          This parameter can be: ENABLE or DISABLE.  
//  844   * @retval None
//  845   */
//  846 
//  847 /**
//  848   * @}
//  849   */
//  850 
//  851 /** @defgroup USART_Group7 IrDA mode functions
//  852  *  @brief   IrDA mode functions 
//  853  *
//  854 @verbatim   
//  855  ===============================================================================
//  856                                 IrDA mode functions
//  857  ===============================================================================  
//  858 
//  859   This subsection provides a set of functions allowing to manage the USART 
//  860   IrDA communication.
//  861   
//  862   IrDA is a half duplex communication protocol. If the Transmitter is busy, any data
//  863   on the IrDA receive line will be ignored by the IrDA decoder and if the Receiver 
//  864   is busy, data on the TX from the USART to IrDA will not be encoded by IrDA.
//  865   While receiving data, transmission should be avoided as the data to be transmitted
//  866   could be corrupted.
//  867 
//  868   IrDA communication is possible through the following procedure:
//  869      1. Program the Baud rate, Word length = 8 bits, Stop bits, Parity, Transmitter/Receiver 
//  870         modes and hardware flow control values using the USART_Init() function.
//  871      2. Enable the USART using the USART_Cmd() function.
//  872      3. Configures the IrDA pulse width by configuring the prescaler using  
//  873         the USART_SetPrescaler() function.
//  874      4. Configures the IrDA  USART_IrDAMode_LowPower or USART_IrDAMode_Normal mode
//  875         using the USART_IrDAConfig() function.
//  876      5. Enable the IrDA using the USART_IrDACmd() function.
//  877 
//  878 @note A pulse of width less than two and greater than one PSC period(s) may or may
//  879       not be rejected.
//  880 @note The receiver set up time should be managed by software. The IrDA physical layer
//  881       specification specifies a minimum of 10 ms delay between transmission and 
//  882       reception (IrDA is a half duplex protocol).
//  883 @note In IrDA mode, the following bits must be kept cleared:
//  884         - LINEN, STOP and CLKEN bits in the USART_CR2 register.
//  885         - SCEN and HDSEL bits in the USART_CR3 register.
//  886 
//  887 @endverbatim
//  888   * @{
//  889   */
//  890 
//  891 /**
//  892   * @brief  Configures the USART's IrDA interface.
//  893   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  894   *         UART peripheral.
//  895   * @param  USART_IrDAMode: specifies the IrDA mode.
//  896   *          This parameter can be one of the following values:
//  897   *            @arg USART_IrDAMode_LowPower
//  898   *            @arg USART_IrDAMode_Normal
//  899   * @retval None
//  900   */
//  901 
//  902 /**
//  903   * @brief  Enables or disables the USART's IrDA interface.
//  904   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  905   *         UART peripheral.
//  906   * @param  NewState: new state of the IrDA mode.
//  907   *          This parameter can be: ENABLE or DISABLE.
//  908   * @retval None
//  909   */
//  910 
//  911 
//  912 /**
//  913   * @}
//  914   */
//  915 
//  916 /** @defgroup USART_Group8 DMA transfers management functions
//  917  *  @brief   DMA transfers management functions
//  918  *
//  919 @verbatim   
//  920  ===============================================================================
//  921                       DMA transfers management functions
//  922  ===============================================================================  
//  923 
//  924 @endverbatim
//  925   * @{
//  926   */
//  927   
//  928 /**
//  929   * @brief  Enables or disables the USART's DMA interface.
//  930   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  931   *         UART peripheral.
//  932   * @param  USART_DMAReq: specifies the DMA request.
//  933   *          This parameter can be any combination of the following values:
//  934   *            @arg USART_DMAReq_Tx: USART DMA transmit request
//  935   *            @arg USART_DMAReq_Rx: USART DMA receive request
//  936   * @param  NewState: new state of the DMA Request sources.
//  937   *          This parameter can be: ENABLE or DISABLE.   
//  938   * @retval None
//  939   */
//  940 
//  941 /**
//  942   * @}
//  943   */
//  944   
//  945 /** @defgroup USART_Group9 Interrupts and flags management functions
//  946  *  @brief   Interrupts and flags management functions 
//  947  *
//  948 @verbatim   
//  949  ===============================================================================
//  950                    Interrupts and flags management functions
//  951  ===============================================================================  
//  952 
//  953   This subsection provides a set of functions allowing to configure the USART 
//  954   Interrupts sources, DMA channels requests and check or clear the flags or 
//  955   pending bits status.
//  956   The user should identify which mode will be used in his application to manage 
//  957   the communication: Polling mode, Interrupt mode or DMA mode. 
//  958     
//  959   Polling Mode
//  960   =============
//  961   In Polling Mode, the SPI communication can be managed by 10 flags:
//  962      1. USART_FLAG_TXE : to indicate the status of the transmit buffer register
//  963      2. USART_FLAG_RXNE : to indicate the status of the receive buffer register
//  964      3. USART_FLAG_TC : to indicate the status of the transmit operation
//  965      4. USART_FLAG_IDLE : to indicate the status of the Idle Line             
//  966      5. USART_FLAG_CTS : to indicate the status of the nCTS input
//  967      6. USART_FLAG_LBD : to indicate the status of the LIN break detection
//  968      7. USART_FLAG_NE : to indicate if a noise error occur
//  969      8. USART_FLAG_FE : to indicate if a frame error occur
//  970      9. USART_FLAG_PE : to indicate if a parity error occur
//  971      10. USART_FLAG_ORE : to indicate if an Overrun error occur
//  972 
//  973   In this Mode it is advised to use the following functions:
//  974       - FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, uint16_t USART_FLAG);
//  975       - void USART_ClearFlag(USART_TypeDef* USARTx, uint16_t USART_FLAG);
//  976 
//  977   Interrupt Mode
//  978   ===============
//  979   In Interrupt Mode, the USART communication can be managed by 8 interrupt sources
//  980   and 10 pending bits: 
//  981 
//  982   Pending Bits:
//  983   ------------- 
//  984      1. USART_IT_TXE : to indicate the status of the transmit buffer register
//  985      2. USART_IT_RXNE : to indicate the status of the receive buffer register
//  986      3. USART_IT_TC : to indicate the status of the transmit operation
//  987      4. USART_IT_IDLE : to indicate the status of the Idle Line             
//  988      5. USART_IT_CTS : to indicate the status of the nCTS input
//  989      6. USART_IT_LBD : to indicate the status of the LIN break detection
//  990      7. USART_IT_NE : to indicate if a noise error occur
//  991      8. USART_IT_FE : to indicate if a frame error occur
//  992      9. USART_IT_PE : to indicate if a parity error occur
//  993      10. USART_IT_ORE : to indicate if an Overrun error occur
//  994 
//  995   Interrupt Source:
//  996   -----------------
//  997      1. USART_IT_TXE : specifies the interrupt source for the Tx buffer empty 
//  998                        interrupt. 
//  999      2. USART_IT_RXNE : specifies the interrupt source for the Rx buffer not 
// 1000                         empty interrupt.
// 1001      3. USART_IT_TC : specifies the interrupt source for the Transmit complete 
// 1002                        interrupt. 
// 1003      4. USART_IT_IDLE : specifies the interrupt source for the Idle Line interrupt.             
// 1004      5. USART_IT_CTS : specifies the interrupt source for the CTS interrupt. 
// 1005      6. USART_IT_LBD : specifies the interrupt source for the LIN break detection
// 1006                        interrupt. 
// 1007      7. USART_IT_PE : specifies the interrupt source for the parity error interrupt. 
// 1008      8. USART_IT_ERR :  specifies the interrupt source for the errors interrupt.
// 1009 
// 1010 @note Some parameters are coded in order to use them as interrupt source or as pending bits.
// 1011 
// 1012   In this Mode it is advised to use the following functions:
// 1013      - void USART_ITConfig(USART_TypeDef* USARTx, uint16_t USART_IT, FunctionalState NewState);
// 1014      - ITStatus USART_GetITStatus(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1015      - void USART_ClearITPendingBit(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1016 
// 1017   DMA Mode
// 1018   ========
// 1019   In DMA Mode, the USART communication can be managed by 2 DMA Channel requests:
// 1020      1. USART_DMAReq_Tx: specifies the Tx buffer DMA transfer request
// 1021      2. USART_DMAReq_Rx: specifies the Rx buffer DMA transfer request
// 1022 
// 1023   In this Mode it is advised to use the following function:
// 1024      - void USART_DMACmd(USART_TypeDef* USARTx, uint16_t USART_DMAReq, FunctionalState NewState);
// 1025 
// 1026 @endverbatim
// 1027   * @{
// 1028   */
// 1029 
// 1030 /**
// 1031   * @brief  Enables or disables the specified USART interrupts.
// 1032   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1033   *         UART peripheral.
// 1034   * @param  USART_IT: specifies the USART interrupt sources to be enabled or disabled.
// 1035   *          This parameter can be one of the following values:
// 1036   *            @arg USART_IT_CTS:  CTS change interrupt
// 1037   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1038   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1039   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1040   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1041   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1042   *            @arg USART_IT_PE:   Parity Error interrupt
// 1043   *            @arg USART_IT_ERR:  Error interrupt(Frame error, noise error, overrun error)
// 1044   * @param  NewState: new state of the specified USARTx interrupts.
// 1045   *          This parameter can be: ENABLE or DISABLE.
// 1046   * @retval None
// 1047   */
// 1048 
// 1049 /**
// 1050   * @brief  Checks whether the specified USART flag is set or not.
// 1051   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1052   *         UART peripheral.
// 1053   * @param  USART_FLAG: specifies the flag to check.
// 1054   *          This parameter can be one of the following values:
// 1055   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5)
// 1056   *            @arg USART_FLAG_LBD:  LIN Break detection flag
// 1057   *            @arg USART_FLAG_TXE:  Transmit data register empty flag
// 1058   *            @arg USART_FLAG_TC:   Transmission Complete flag
// 1059   *            @arg USART_FLAG_RXNE: Receive data register not empty flag
// 1060   *            @arg USART_FLAG_IDLE: Idle Line detection flag
// 1061   *            @arg USART_FLAG_ORE:  OverRun Error flag
// 1062   *            @arg USART_FLAG_NE:   Noise Error flag
// 1063   *            @arg USART_FLAG_FE:   Framing Error flag
// 1064   *            @arg USART_FLAG_PE:   Parity Error flag
// 1065   * @retval The new state of USART_FLAG (SET or RESET).
// 1066   */
// 1067 
// 1068 /**
// 1069   * @brief  Clears the USARTx's pending flags.
// 1070   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1071   *         UART peripheral.
// 1072   * @param  USART_FLAG: specifies the flag to clear.
// 1073   *          This parameter can be any combination of the following values:
// 1074   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5).
// 1075   *            @arg USART_FLAG_LBD:  LIN Break detection flag.
// 1076   *            @arg USART_FLAG_TC:   Transmission Complete flag.
// 1077   *            @arg USART_FLAG_RXNE: Receive data register not empty flag.
// 1078   *   
// 1079   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1080   *          error) and IDLE (Idle line detected) flags are cleared by software 
// 1081   *          sequence: a read operation to USART_SR register (USART_GetFlagStatus()) 
// 1082   *          followed by a read operation to USART_DR register (USART_ReceiveData()).
// 1083   * @note   RXNE flag can be also cleared by a read to the USART_DR register 
// 1084   *          (USART_ReceiveData()).
// 1085   * @note   TC flag can be also cleared by software sequence: a read operation to 
// 1086   *          USART_SR register (USART_GetFlagStatus()) followed by a write operation
// 1087   *          to USART_DR register (USART_SendData()).
// 1088   * @note   TXE flag is cleared only by a write to the USART_DR register 
// 1089   *          (USART_SendData()).
// 1090   *   
// 1091   * @retval None
// 1092   */
// 1093 
// 1094 
// 1095 /**
// 1096   * @brief  Checks whether the specified USART interrupt has occurred or not.
// 1097   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1098   *         UART peripheral.
// 1099   * @param  USART_IT: specifies the USART interrupt source to check.
// 1100   *          This parameter can be one of the following values:
// 1101   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1102   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1103   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1104   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1105   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1106   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1107   *            @arg USART_IT_ORE:  OverRun Error interrupt
// 1108   *            @arg USART_IT_NE:   Noise Error interrupt
// 1109   *            @arg USART_IT_FE:   Framing Error interrupt
// 1110   *            @arg USART_IT_PE:   Parity Error interrupt
// 1111   * @retval The new state of USART_IT (SET or RESET).
// 1112   */
// 1113 
// 1114 
// 1115 /**
// 1116   * @brief  Clears the USARTx's interrupt pending bits.
// 1117   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1118   *         UART peripheral.
// 1119   * @param  USART_IT: specifies the interrupt pending bit to clear.
// 1120   *          This parameter can be one of the following values:
// 1121   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1122   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1123   *            @arg USART_IT_TC:   Transmission complete interrupt. 
// 1124   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt.
// 1125   *
// 1126   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1127   *          error) and IDLE (Idle line detected) pending bits are cleared by 
// 1128   *          software sequence: a read operation to USART_SR register 
// 1129   *          (USART_GetITStatus()) followed by a read operation to USART_DR register 
// 1130   *          (USART_ReceiveData()).
// 1131   * @note   RXNE pending bit can be also cleared by a read to the USART_DR register 
// 1132   *          (USART_ReceiveData()).
// 1133   * @note   TC pending bit can be also cleared by software sequence: a read 
// 1134   *          operation to USART_SR register (USART_GetITStatus()) followed by a write 
// 1135   *          operation to USART_DR register (USART_SendData()).
// 1136   * @note   TXE pending bit is cleared only by a write to the USART_DR register 
// 1137   *          (USART_SendData()).
// 1138   *  
// 1139   * @retval None
// 1140   */
// 1141 
// 1142 
// 1143 /**
// 1144   * @}
// 1145   */
// 1146 
// 1147 /**
// 1148   * @}
// 1149   */
// 1150 
// 1151 /**
// 1152   * @}
// 1153   */
// 1154 
// 1155 /**
// 1156   * @}
// 1157   */
// 1158 
// 1159 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
//     2 bytes in section .rodata
//   732 bytes in section .text
// 4 148 bytes in section iram
// 
//   732 bytes of CODE  memory
//     2 bytes of CONST memory
// 4 148 bytes of DATA  memory
//
//Errors: none
//Warnings: none
