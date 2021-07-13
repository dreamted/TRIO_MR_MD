///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:03 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart1_1208.c                         /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart1_1208.c -D OS_INCLUDED -D       /
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
//                    rt1_1208.s                                              /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_usart1_1208

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

        PUBLIC InitUSART1
        PUBLIC Rx1Buff
        PUBLIC Rx1RdCnt
        PUBLIC Rx1WrCnt
        PUBLIC Tx1Buff
        PUBLIC Tx1RdCnt
        PUBLIC Tx1WrCnt
        PUBLIC USART1BuffClear
        PUBLIC USART1CheckByte
        PUBLIC USART1Printf
        PUBLIC USART1PutChar
        PUBLIC USART1PutStr
        PUBLIC USART1PutToBuffer
        PUBLIC USART1RxGetByte
        PUBLIC USART1TxCheckByte
        PUBLIC USART1TxClear
        PUBLIC USART1_IRQIntHandler
        PUBLIC pUSART1
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_usart1_1208.c
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
//   85 #include "stm32f2xx_usart1_1208.h"
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
//  103 	INT8U Rx1Buff[Rx1BuffLen];
//  104 	INT8U Tx1Buff[Tx1BuffLen];
//  105 
//  106 	INT16U	Rx1RdCnt = 0, Rx1WrCnt = 0;
//  107 	INT16U	Tx1RdCnt = 0, Tx1WrCnt = 0;
//  108 #else

        SECTION iram:DATA:REORDER:NOROOT(2)
//  109 	INT8U Rx1Buff[Rx1BuffLen] @ "iram";
Rx1Buff:
        DS8 2048

        SECTION iram:DATA:REORDER:NOROOT(2)
//  110 	INT8U Tx1Buff[Tx1BuffLen] @ "iram";
Tx1Buff:
        DS8 2048
//  111 

        SECTION iram:DATA:REORDER:NOROOT(2)
//  112 	INT16U	Rx1RdCnt @ "iram"= 0, Rx1WrCnt @ "iram" = 0;
Rx1RdCnt:
        DATA
        DC16 0
Rx1WrCnt:
        DC16 0
//  113 	INT16U	Tx1RdCnt @ "iram"= 0, Tx1WrCnt @ "iram" = 0;
Tx1RdCnt:
        DC16 0
Tx1WrCnt:
        DC16 0
//  114 #endif
//  115 
//  116 #if !defined (OS_INCLUDED) 
//  117 __SerStrPtr pUSART1 = {
//  118 
//  119 #else
//  120 __SerStrPtr pUSART1 @ "iram" = {
pUSART1:
        DC32 InitUSART1, USART1CheckByte, USART1RxGetByte, USART1PutStr
        DC32 USART1Printf, USART1PutChar, USART1PutToBuffer, USART1TxCheckByte
        DC32 USART1BuffClear, USART1TxClear
        DC8 0, 0, 0, 0
//  121 #endif
//  122 	InitUSART1,
//  123 	USART1CheckByte,
//  124 	USART1RxGetByte,
//  125 	USART1PutStr,
//  126 	USART1Printf,
//  127 	USART1PutChar,
//  128 	USART1PutToBuffer,
//  129 	USART1TxCheckByte,
//  130 	USART1BuffClear,
//  131 	USART1TxClear
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
        CFI Function InitUSART1
        THUMB
//  194 void InitUSART1(INT32U nBps, INT32U nLCR)
//  195 {
InitUSART1:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        SUB      SP,SP,#+16
        CFI CFA R13+32
        MOV      R5,R0
        MOV      R4,R1
//  196 	USART_InitTypeDef USART_InitStructure;
//  197 
//  198 ///
//  199 // PORT INIT
//  200 	RCC->__B.AHB1ENR.IOPAEN = ENABLE;
        LDR.N    R0,??DataTable10_1  ;; 0x40023830
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//  201 	RCC->__B.APB2ENR.USART1EN = ENABLE;
        LDR      R1,[R0, #+20]
        ORR      R1,R1,#0x10
        STR      R1,[R0, #+20]
//  202 	
//  203 	__PA9_U1_TX();
        LDR.N    R6,??DataTable10_2  ;; 0x40020000
        MOVS     R3,#+9
        MOV      R2,R6
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  204 	__PA10_U1_RX();
        MOVS     R3,#+10
        MOV      R2,R6
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  205 
//  206 ////////////////////////////////////////////////////////////////////////////////
//  207 	USART_InitStructure.USART_BaudRate = nBps;
        STR      R5,[SP, #+0]
//  208 
//  209 	if( ((nLCR >> 4) & 0x01) ==  (_DATA8BIT >> 4)) {
        LSLS     R0,R4,#+27
        ITE      PL 
        MOVPL    R0,#+0
        MOVMI    R0,#+4096
//  210 			USART_InitStructure.USART_WordLength = USART_WordLength_8b;
//  211 	}
//  212 	else	USART_InitStructure.USART_WordLength = USART_WordLength_9b;
        STRH     R0,[SP, #+4]
//  213 
//  214 ////////////////////////////////////////////////////////////////////////////////
//  215 	if( ((nLCR >> 2) & 0x02) ==  (_05STOP >> 2)) {
//  216 		USART_InitStructure.USART_StopBits = USART_StopBits_0_5;
//  217 	}
//  218 	else if( ((nLCR >> 2) & 0x02) ==  (_1_STOP >> 2)) {
        LSRS     R0,R4,#+2
        LSLS     R0,R0,#+30
        ITE      PL 
        MOVPL    R0,#+0
        MOVMI    R0,#+8192
//  219 			USART_InitStructure.USART_StopBits = USART_StopBits_1;
//  220 	}
//  221 	else if( ((nLCR >> 2) & 0x02) ==  (_2_STOP >> 2)) {
//  222 			USART_InitStructure.USART_StopBits = USART_StopBits_2;
        STRH     R0,[SP, #+6]
//  223 	}
//  224 	else	USART_InitStructure.USART_StopBits = USART_StopBits_1_5;
//  225 	
//  226 ////////////////////////////////////////////////////////////////////////////////
//  227 	
//  228 	if(((nLCR >> 0) & 0x03) == (_NONPARITY >> 0)){
        ANDS     R0,R4,#0x3
        IT       EQ 
        MOVEQ    R0,#+0
//  229 		USART_InitStructure.USART_Parity = USART_Parity_No;
        BEQ.N    ??InitUSART1_0
//  230 	}
//  231 	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0)){
        CMP      R0,#+1
        ITE      EQ 
        MOVEQ    R0,#+1536
        MOVNE    R0,#+1024
//  232 		USART_InitStructure.USART_Parity = USART_Parity_Odd;
//  233 	}
//  234 	else{
//  235 		USART_InitStructure.USART_Parity = USART_Parity_Even;
??InitUSART1_0:
        STRH     R0,[SP, #+8]
//  236 	}
//  237 	
//  238 	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
        MOVS     R0,#+0
        STRH     R0,[SP, #+12]
//  239 	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
        MOVS     R0,#+12
        STRH     R0,[SP, #+10]
//  240 
//  241 	/* USART configuration */
//  242 	USART_Init(USART1, &USART_InitStructure);
        LDR.N    R4,??DataTable10_3  ;; 0x40011000
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       USART_Init
//  243 
//  244 #if defined (OS_INCLUDED) 
//  245 	pUSART1.sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.N    R1,??DataTable10_4
        STR      R0,[R1, #+48]
//  246 #endif
//  247 	/* Enable USART */
//  248 	USART_Cmd(USART1, ENABLE);
        MOVS     R1,#+1
        MOV      R0,R4
        BL       USART_Cmd
//  249 
//  250 	USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);
        MOVS     R2,#+1
        MOVW     R1,#+1317
        MOV      R0,R4
        BL       USART_ITConfig
//  251 	NVIC_Init(USART1_IRQn, ENABLE); 
        MOVS     R1,#+1
        MOVS     R0,#+37
        BL       NVIC_Init
//  252 
//  253 	USART1Printf("\n");	
        ADR.N    R0,??DataTable10  ;; "\n"
        BL       USART1Printf
//  254 }
        ADD      SP,SP,#+16
        CFI CFA R13+16
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock0
//  255 
//  256 /*******************************************************************************
//  257   * @brief  Interrupt handler USART1 global interrupt request
//  258   * @param  None 
//  259   * @retval None
//  260   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function USART1_IRQIntHandler
        THUMB
//  261 void USART1_IRQIntHandler(void)
//  262 {
USART1_IRQIntHandler:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
//  263 
//  264 	INT16U tmp = USART1->SR;
        LDR.N    R4,??DataTable10_3  ;; 0x40011000
        LDRH     R5,[R4, #+0]
//  265 
//  266 #ifdef OS_INCLUDED
//  267 	INT32U cpu_sr;
//  268 	CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
        BL       CPU_SR_Save
//  269 	OSIntNesting++;
        LDR.N    R1,??DataTable10_5
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  270 	CPU_CRITICAL_EXIT();
        BL       CPU_SR_Restore
//  271 #endif /* OS_INCLUDED */
//  272 	// Rx Data Received
//  273 	if(tmp & ( 1 << __RXNE))
        LSLS     R0,R5,#+26
        BPL.N    ??USART1_IRQIntHandler_0
//  274 	{
//  275 		Rx1Buff[Rx1WrCnt%Rx1BuffLen] = USART1->DR;		// When the receive register is read, the RDR bit is automatically cleared.
        LDR.N    R0,??DataTable10_4
        LDRH     R1,[R0, #+2]
        LSLS     R2,R1,#+21
        LSRS     R2,R2,#+21
        LDR.N    R3,??DataTable10_6
        LDRH     R4,[R4, #+4]
        STRB     R4,[R2, R3]
//  276 		if(++Rx1WrCnt >= Rx1BuffLen) Rx1WrCnt = 0;
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+2]
        UXTH     R1,R1
        CMP      R1,#+2048
        BCC.N    ??USART1_IRQIntHandler_1
        MOVS     R1,#+0
        STRH     R1,[R0, #+2]
        B.N      ??USART1_IRQIntHandler_1
//  277 	}
//  278 	else if(tmp & ( 1 << __TXE))
??USART1_IRQIntHandler_0:
        LSLS     R0,R5,#+24
        BPL.N    ??USART1_IRQIntHandler_2
//  279 	{
//  280 		if(Tx1RdCnt != Tx1WrCnt)
        LDR.N    R0,??DataTable10_4
        LDRH     R1,[R0, #+4]
        LDRH     R2,[R0, #+6]
        CMP      R1,R2
        BEQ.N    ??USART1_IRQIntHandler_3
//  281 		{
//  282 			USART1->DR = Tx1Buff[Tx1RdCnt%Tx1BuffLen];
        LSLS     R1,R1,#+21
        LSRS     R1,R1,#+21
        LDR.N    R2,??DataTable10_7
        LDRB     R1,[R1, R2]
        STRH     R1,[R4, #+4]
//  283 			if(++Tx1RdCnt >= Tx1BuffLen ) Tx1RdCnt = 0;
        LDRH     R1,[R0, #+4]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+4]
        UXTH     R1,R1
        CMP      R1,#+2048
        BCC.N    ??USART1_IRQIntHandler_1
        MOVS     R1,#+0
        STRH     R1,[R0, #+4]
        B.N      ??USART1_IRQIntHandler_1
//  284 		}
//  285 		else USART1->__B.CR1.TXEIE = DISABLE;
??USART1_IRQIntHandler_3:
        LDR      R0,[R4, #+12]
        BIC      R0,R0,#0x80
        STR      R0,[R4, #+12]
        B.N      ??USART1_IRQIntHandler_1
//  286 	}
//  287 	else // error, dummy read
//  288 	{
//  289 		tmp =  USART1->DR;
??USART1_IRQIntHandler_2:
        LDRH     R0,[R4, #+4]
//  290 	}
//  291 
//  292 #ifdef OS_INCLUDED
//  293 	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
??USART1_IRQIntHandler_1:
        POP      {R0,R4,R5,LR}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      OSIntExit
        CFI EndBlock cfiBlock1
//  294 #endif /* OS_INCLUDED */
//  295 
//  296 }
//  297 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function USART1PutToBuffer
        THUMB
//  298 unsigned char USART1PutToBuffer(unsigned char Data)
//  299 {
USART1PutToBuffer:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R5,R0
//  300 #ifdef OS_INCLUDED
//  301 	INT8U err;
//  302 	//////////////////////////////////////////////////
//  303 
//  304 	OSSemPend(pUSART1.sem, 0, &err);
        LDR.N    R4,??DataTable10_4
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  305 #endif /* OS_INCLUDED */
//  306 	//////////////////////////////////////////////////
//  307 	Tx1Buff[Tx1WrCnt%Tx1BuffLen] = Data;
        LDRH     R0,[R4, #+6]
        LSLS     R1,R0,#+21
        LSRS     R1,R1,#+21
        LDR.N    R2,??DataTable10_7
        STRB     R5,[R1, R2]
//  308 	if(++Tx1WrCnt >= Tx1BuffLen) Tx1WrCnt = 0;
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        CMP      R0,#+2048
        IT       CS 
        MOVCS    R0,#+0
        STRH     R0,[R4, #+6]
//  309 	
//  310 	USART1->__B.CR1.TXEIE = ENABLE; 		
        LDR.N    R0,??DataTable10_8  ;; 0x4001100c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+0]
//  311 	///////////////////////////////////////////////////
//  312 #ifdef OS_INCLUDED
//  313 	OSSemPost(pUSART1.sem);
        LDR      R0,[R4, #+48]
        BL       OSSemPost
//  314 #endif /* OS_INCLUDED */
//  315 
//  316 	return 0;
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock2
//  317 }
//  318 
//  319 
//  320 
//  321 //Not using interrupt

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function USART1PutChar
        THUMB
//  322 unsigned char USART1PutChar(unsigned char Data)
//  323 {
USART1PutChar:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
        MOV      R4,R0
//  324 	#ifdef OS_INCLUDED
//  325 		INT8U err;
//  326 		//////////////////////////////////////////////////
//  327 	
//  328 		OSSemPend(pUSART1.sem, 0, &err);
        LDR.N    R5,??DataTable10_4
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R5, #+48]
        BL       OSSemPend
//  329 	#endif /* OS_INCLUDED */
//  330 		USART1->__B.DR.DR = Data;
        LDR.N    R0,??DataTable10_3  ;; 0x40011000
        LDR      R1,[R0, #+4]
        BFI      R1,R4,#+0,#+9
        STR      R1,[R0, #+4]
//  331 		while(!USART1->__B.SR.TXE);
??USART1PutChar_0:
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??USART1PutChar_0
//  332 	#ifdef OS_INCLUDED
//  333 		OSSemPost(pUSART1.sem);
        LDR      R0,[R5, #+48]
        BL       OSSemPost
//  334 	#endif /* OS_INCLUDED */
//  335 	return Data;
        MOV      R0,R4
        POP      {R1,R4,R5,PC}    ;; return
        CFI EndBlock cfiBlock3
//  336 }
//  337 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function USART1Printf
        THUMB
//  338 unsigned long int USART1Printf( const char *format, ...)
//  339 {
USART1Printf:
        PUSH     {R1-R3}
        CFI CFA R13+12
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -16)
        CFI R5 Frame(CFA, -20)
        CFI R4 Frame(CFA, -24)
        CFI CFA R13+24
        SUB      SP,SP,#+128
        CFI CFA R13+152
//  340 	unsigned long int i, cnt;
//  341 	char buf[128];
//  342 	va_list argptr;
//  343 
//  344 	va_start(argptr, format);
        ADD      R2,SP,#+140
//  345 	cnt = vsprintf(buf, format, argptr);
        MOV      R1,R0
        ADD      R0,SP,#+0
        BL       vsprintf
        MOV      R4,R0
//  346 	va_end( argptr );
//  347 
//  348 	for(i = 0;;i++)
        ADD      R5,SP,#+0
        B.N      ??USART1Printf_0
//  349 	{
//  350 		if(buf[i] == 0) break;
//  351 		if(buf[i] == '\n') USART1PutToBuffer('\r');
??USART1Printf_1:
        CMP      R0,#+10
        ITT      EQ 
        MOVEQ    R0,#+13
        BLEQ     USART1PutToBuffer
//  352 		USART1PutToBuffer(buf[i]);
        LDRB     R0,[R5], #+1
        BL       USART1PutToBuffer
??USART1Printf_0:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??USART1Printf_1
//  353 	}
//  354 	while(!USART1TxCheckByte())
??USART1Printf_2:
        BL       USART1TxCheckByte
        CBNZ.N   R0,??USART1Printf_3
//  355 	{
//  356 #ifdef OS_INCLUDED
//  357 	OSTimeDly(1);
        MOVS     R0,#+1
        BL       OSTimeDly
        B.N      ??USART1Printf_2
//  358 #endif /* OS_INCLUDED */
//  359 	}
//  360 
//  361 	USART1TxClear();
??USART1Printf_3:
        LDR.N    R0,??DataTable10_4
        MOVS     R1,#+0
        STRH     R1,[R0, #+4]
        STRH     R1,[R0, #+6]
//  362 	
//  363 	return cnt;
        MOV      R0,R4
        ADD      SP,SP,#+128
        CFI CFA R13+24
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+16
        LDR      PC,[SP], #+16    ;; return
        CFI EndBlock cfiBlock4
//  364 }
//  365 
//  366 //#define OS_INCLUDED
//  367 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function USART1PutStr
        THUMB
//  368 void USART1PutStr(unsigned char *Str, unsigned short int Length, int iEn)
//  369 {
USART1PutStr:
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
//  370 	u32 i = 0;
//  371 
//  372 	USART1BuffClear();
        BL       USART1BuffClear
//  373 	
//  374 #ifdef OS_INCLUDED
//  375 	INT8U err;
//  376 	OSSemPend(pUSART1.sem, 0, &err);
        LDR.N    R4,??DataTable10_4
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  377 #endif /* OS_INCLUDED */
//  378 
//  379 
//  380 	for(i = 0; i < Length; i++)
        LDRH     R0,[R4, #+6]
        CBZ.N    R6,??USART1PutStr_0
        LDR.N    R1,??DataTable10_7
//  381 	{
//  382 		Tx1Buff[Tx1WrCnt++] = Str[i];
??USART1PutStr_1:
        LDRB     R2,[R5, #+0]
        STRB     R2,[R0, R1]
        ADDS     R0,R0,#+1
//  383 		if(Tx1WrCnt >= Tx1BuffLen) Tx1WrCnt = 0;
        UXTH     R0,R0
        CMP      R0,#+2048
        IT       CS 
        MOVCS    R0,#+0
//  384 	}
        ADDS     R5,R5,#+1
        SUBS     R6,R6,#+1
        BNE.N    ??USART1PutStr_1
??USART1PutStr_0:
        STRH     R0,[R4, #+6]
//  385 
//  386 	if(iEn)
        CBZ.N    R7,??USART1PutStr_2
//  387 	{
//  388 		USART1->__B.CR1.TXEIE = ENABLE;
        LDR.N    R0,??DataTable10_8  ;; 0x4001100c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+0]
//  389 	}	
//  390 #ifdef OS_INCLUDED
//  391 		OSSemPost(pUSART1.sem);
??USART1PutStr_2:
        LDR      R0,[R4, #+48]
        BL       OSSemPost
//  392 #endif /* OS_INCLUDED */
//  393 }
        POP      {R0,R4-R7,PC}    ;; return
        CFI EndBlock cfiBlock5
//  394 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function USART1RxGetByte
        THUMB
//  395 signed short int USART1RxGetByte(void)
//  396 {
//  397 	s16 RetVal = 0;
//  398 
//  399 #ifndef APPL_SRC
//  400 	while(Rx1RdCnt == Rx1WrCnt);
//  401 #else
//  402 	if(Rx1RdCnt == Rx1WrCnt) return -1;
USART1RxGetByte:
        LDR.N    R1,??DataTable10_4
        LDRH     R2,[R1, #+0]
        LDRH     R0,[R1, #+2]
        CMP      R2,R0
        BNE.N    ??USART1RxGetByte_0
        MOV      R0,#-1
        BX       LR
//  403 #endif
//  404 
//  405 	RetVal = Rx1Buff[Rx1RdCnt%Rx1BuffLen];
??USART1RxGetByte_0:
        LSLS     R0,R2,#+21
        LSRS     R0,R0,#+21
        LDR.N    R3,??DataTable10_6
        LDRB     R0,[R0, R3]
//  406 	if(++Rx1RdCnt >= Rx1BuffLen) Rx1RdCnt = 0;
        ADDS     R2,R2,#+1
        STRH     R2,[R1, #+0]
        UXTH     R2,R2
        CMP      R2,#+2048
        BCC.N    ??USART1RxGetByte_1
        MOVS     R2,#+0
        STRH     R2,[R1, #+0]
//  407 
//  408 	return (RetVal & 0xff);
??USART1RxGetByte_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  409 }
//  410 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function USART1CheckByte
        THUMB
//  411 unsigned char USART1CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
//  412 {
USART1CheckByte:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  413 	u32 i = 0, j = 0;
//  414 	u8 RetVal = TRUE;
        MOVS     R2,#+1
//  415 
//  416 	*Recv = 0;
        MOVS     R3,#+0
        STRH     R3,[R1, #+0]
//  417 	i = (u32) Rx1RdCnt;
        LDR.N    R3,??DataTable10_4
        LDRH     R4,[R3, #+0]
//  418 	j = (u32) Rx1WrCnt;
        LDRH     R3,[R3, #+2]
//  419 
//  420 	if(i == j) RetVal = FALSE;
        CMP      R4,R3
        BEQ.N    ??USART1CheckByte_0
//  421 	else if(i < j)
        ADDS     R0,R0,R4
        CMP      R4,R3
        BCS.N    ??USART1CheckByte_1
//  422 	{
//  423 		*Recv = j - i;
        SUBS     R4,R3,R4
        STRH     R4,[R1, #+0]
//  424 		i = i + ByteCnt;
//  425 		if(i > j) RetVal = FALSE;
        CMP      R3,R0
        BCS.N    ??USART1CheckByte_2
        B.N      ??USART1CheckByte_0
//  426 	}
//  427 	else if(i > j)
//  428 	{
//  429 		*Recv = (Rx1BuffLen +j) - i;
??USART1CheckByte_1:
        ADD      R5,R3,#+2048
        SUBS     R4,R5,R4
        STRH     R4,[R1, #+0]
//  430 		i = i + ByteCnt;
//  431 		j = j + Rx1BuffLen;
//  432 		if(i > j) RetVal = FALSE; 
        ADD      R1,R3,#+2048
        CMP      R1,R0
        BCS.N    ??USART1CheckByte_2
??USART1CheckByte_0:
        MOVS     R2,#+0
//  433 	}
//  434 	return (RetVal);
??USART1CheckByte_2:
        MOV      R0,R2
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  435 }
//  436 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function USART1BuffClear
        THUMB
//  437 void USART1BuffClear(void)
//  438 {
//  439 	Rx1RdCnt = 0;
USART1BuffClear:
        LDR.N    R0,??DataTable10_4
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  440 	Rx1WrCnt = 0;
        STRH     R1,[R0, #+2]
//  441 	Tx1RdCnt = 0;
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock8
//  442 	Tx1WrCnt = 0;
//  443 }
//  444 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function USART1TxClear
        THUMB
//  445 void USART1TxClear(void)
//  446 {
//  447 	Tx1RdCnt = 0;
USART1TxClear:
        LDR.N    R0,??DataTable10_4
        MOVS     R1,#+0
        CFI EndBlock cfiBlock9
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  448 	Tx1WrCnt = 0;
//  449 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        STRH     R1,[R0, #+4]
        STRH     R1,[R0, #+6]
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  450 
//  451 /*******************************************************************************
//  452   * @brief  if the bytes have been transmitted, retrun true or not
//  453   * @param  None
//  454   * @retval TRUE/FALSE
//  455   ******************************************************************************/
//  456 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function USART1TxCheckByte
        THUMB
//  457 signed short int USART1TxCheckByte(void)
//  458 {
//  459 	if(Tx1RdCnt == Tx1WrCnt) return TRUE;
USART1TxCheckByte:
        LDR.N    R0,??DataTable10_4
        LDRH     R1,[R0, #+4]
        LDRH     R0,[R0, #+6]
        CMP      R1,R0
        BNE.N    ??USART1TxCheckByte_0
        MOVS     R0,#+1
        BX       LR
//  460 	else return FALSE;
??USART1TxCheckByte_0:
        MOVS     R0,#+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  461 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC8      "\n",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     0x40023830

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     0x40020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     0x40011000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     Rx1RdCnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     Rx1Buff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     Tx1Buff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_8:
        DC32     0x4001100c

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
//  462 
//  463 
//  464 
//  465 
//  466 /**
//  467   * @brief  Initializes the USARTx peripheral Clock according to the 
//  468   *         specified parameters in the USART_ClockInitStruct .
//  469   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART peripheral.
//  470   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure that
//  471   *         contains the configuration information for the specified  USART peripheral.
//  472   * @note   The Smart Card and Synchronous modes are not available for UART4 and UART5.    
//  473   * @retval None
//  474   */
//  475 
//  476 /**
//  477   * @brief  Fills each USART_ClockInitStruct member with its default value.
//  478   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure
//  479   *         which will be initialized.
//  480   * @retval None
//  481   */
//  482 
//  483 
//  484 /**
//  485   * @brief  Enables or disables the specified USART peripheral.
//  486   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  487   *         UART peripheral.
//  488   * @param  NewState: new state of the USARTx peripheral.
//  489   *          This parameter can be: ENABLE or DISABLE.
//  490   * @retval None
//  491   */
//  492 
//  493 
//  494 /**
//  495   * @brief  Sets the system clock prescaler.
//  496   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  497   *         UART peripheral.
//  498   * @param  USART_Prescaler: specifies the prescaler clock. 
//  499   * @note   The function is used for IrDA mode with UART4 and UART5.   
//  500   * @retval None
//  501   */
//  502 
//  503 /**
//  504   * @brief  Enables or disables the USART's 8x oversampling mode.
//  505   * @note   This function has to be called before calling USART_Init() function
//  506   *         in order to have correct baudrate Divider value.
//  507   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  508   *         UART peripheral.
//  509   * @param  NewState: new state of the USART 8x oversampling mode.
//  510   *          This parameter can be: ENABLE or DISABLE.
//  511   * @retval None
//  512   */
//  513   
//  514 
//  515 /**
//  516   * @brief  Enables or disables the USART's one bit sampling method.
//  517   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  518   *         UART peripheral.
//  519   * @param  NewState: new state of the USART one bit sampling method.
//  520   *          This parameter can be: ENABLE or DISABLE.
//  521   * @retval None
//  522   */
//  523 
//  524 /**
//  525   * @}
//  526   */
//  527 
//  528 /** @defgroup USART_Group2 Data transfers functions
//  529  *  @brief   Data transfers functions 
//  530  *
//  531 @verbatim   
//  532  ===============================================================================
//  533                             Data transfers functions
//  534  ===============================================================================  
//  535 
//  536   This subsection provides a set of functions allowing to manage the USART data 
//  537   transfers.
//  538   
//  539   During an USART reception, data shifts in least significant bit first through 
//  540   the RX pin. In this mode, the USART_DR register consists of a buffer (RDR) 
//  541   between the internal bus and the received shift register.
//  542 
//  543   When a transmission is taking place, a write instruction to the USART_DR register 
//  544   stores the data in the TDR register and which is copied in the shift register 
//  545   at the end of the current transmission.
//  546 
//  547   The read access of the USART_DR register can be done using the USART_ReceiveData()
//  548   function and returns the RDR buffered value. Whereas a write access to the USART_DR 
//  549   can be done using USART_SendData() function and stores the written data into 
//  550   TDR buffer.
//  551 
//  552 @endverbatim
//  553   * @{
//  554   */
//  555 
//  556 /**
//  557   * @brief  Transmits single data through the USARTx peripheral.
//  558   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  559   *         UART peripheral.
//  560   * @param  Data: the data to transmit.
//  561   * @retval None
//  562   */
//  563 
//  564 
//  565 /**
//  566   * @brief  Returns the most recent received data by the USARTx peripheral.
//  567   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  568   *         UART peripheral.
//  569   * @retval The received data.
//  570   */
//  571 
//  572 /**
//  573   * @}
//  574   */
//  575 
//  576 /** @defgroup USART_Group3 MultiProcessor Communication functions
//  577  *  @brief   Multi-Processor Communication functions 
//  578  *
//  579 @verbatim   
//  580  ===============================================================================
//  581                     Multi-Processor Communication functions
//  582  ===============================================================================  
//  583 
//  584   This subsection provides a set of functions allowing to manage the USART 
//  585   multiprocessor communication.
//  586   
//  587   For instance one of the USARTs can be the master, its TX output is connected to 
//  588   the RX input of the other USART. The others are slaves, their respective TX outputs 
//  589   are logically ANDed together and connected to the RX input of the master.
//  590 
//  591   USART multiprocessor communication is possible through the following procedure:
//  592      1. Program the Baud rate, Word length = 9 bits, Stop bits, Parity, Mode transmitter 
//  593         or Mode receiver and hardware flow control values using the USART_Init()
//  594         function.
//  595      2. Configures the USART address using the USART_SetAddress() function.
//  596      3. Configures the wake up method (USART_WakeUp_IdleLine or USART_WakeUp_AddressMark)
//  597         using USART_WakeUpConfig() function only for the slaves.
//  598      4. Enable the USART using the USART_Cmd() function.
//  599      5. Enter the USART slaves in mute mode using USART_ReceiverWakeUpCmd() function.
//  600 
//  601   The USART Slave exit from mute mode when receive the wake up condition.
//  602 
//  603 @endverbatim
//  604   * @{
//  605   */
//  606 
//  607 /**
//  608   * @brief  Sets the address of the USART node.
//  609   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  610   *         UART peripheral.
//  611   * @param  USART_Address: Indicates the address of the USART node.
//  612   * @retval None
//  613   */
//  614 
//  615 
//  616 /**
//  617   * @brief  Determines if the USART is in mute mode or not.
//  618   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  619   *         UART peripheral.
//  620   * @param  NewState: new state of the USART mute mode.
//  621   *          This parameter can be: ENABLE or DISABLE.
//  622   * @retval None
//  623   */
//  624 
//  625 /**
//  626   * @brief  Selects the USART WakeUp method.
//  627   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  628   *         UART peripheral.
//  629   * @param  USART_WakeUp: specifies the USART wakeup method.
//  630   *          This parameter can be one of the following values:
//  631   *            @arg USART_WakeUp_IdleLine: WakeUp by an idle line detection
//  632   *            @arg USART_WakeUp_AddressMark: WakeUp by an address mark
//  633   * @retval None
//  634   */
//  635 
//  636 
//  637 /**
//  638   * @}
//  639   */
//  640 
//  641 /** @defgroup USART_Group4 LIN mode functions
//  642  *  @brief   LIN mode functions 
//  643  *
//  644 @verbatim   
//  645  ===============================================================================
//  646                                 LIN mode functions
//  647  ===============================================================================  
//  648 
//  649   This subsection provides a set of functions allowing to manage the USART LIN 
//  650   Mode communication.
//  651   
//  652   In LIN mode, 8-bit data format with 1 stop bit is required in accordance with 
//  653   the LIN standard.
//  654 
//  655   Only this LIN Feature is supported by the USART IP:
//  656     - LIN Master Synchronous Break send capability and LIN slave break detection
//  657       capability :  13-bit break generation and 10/11 bit break detection
//  658 
//  659 
//  660   USART LIN Master transmitter communication is possible through the following procedure:
//  661      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  662         Mode transmitter or Mode receiver and hardware flow control values using 
//  663         the USART_Init() function.
//  664      2. Enable the USART using the USART_Cmd() function.
//  665      3. Enable the LIN mode using the USART_LINCmd() function.
//  666      4. Send the break character using USART_SendBreak() function.
//  667 
//  668   USART LIN Master receiver communication is possible through the following procedure:
//  669      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  670         Mode transmitter or Mode receiver and hardware flow control values using 
//  671         the USART_Init() function.
//  672      2. Enable the USART using the USART_Cmd() function.
//  673      3. Configures the break detection length using the USART_LINBreakDetectLengthConfig()
//  674         function.
//  675      4. Enable the LIN mode using the USART_LINCmd() function.
//  676 
//  677 
//  678 @note In LIN mode, the following bits must be kept cleared:
//  679         - CLKEN in the USART_CR2 register,
//  680         - STOP[1:0], SCEN, HDSEL and IREN in the USART_CR3 register.
//  681 
//  682 @endverbatim
//  683   * @{
//  684   */
//  685 
//  686 /**
//  687   * @brief  Sets the USART LIN Break detection length.
//  688   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  689   *         UART peripheral.
//  690   * @param  USART_LINBreakDetectLength: specifies the LIN break detection length.
//  691   *          This parameter can be one of the following values:
//  692   *            @arg USART_LINBreakDetectLength_10b: 10-bit break detection
//  693   *            @arg USART_LINBreakDetectLength_11b: 11-bit break detection
//  694   * @retval None
//  695   */
//  696 
//  697 /**
//  698   * @brief  Enables or disables the USART's LIN mode.
//  699   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  700   *         UART peripheral.
//  701   * @param  NewState: new state of the USART LIN mode.
//  702   *          This parameter can be: ENABLE or DISABLE.
//  703   * @retval None
//  704   */
//  705 
//  706 
//  707 /**
//  708   * @brief  Transmits break characters.
//  709   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  710   *         UART peripheral.
//  711   * @retval None
//  712   */
//  713 
//  714 
//  715 /**
//  716   * @}
//  717   */
//  718 
//  719 /** @defgroup USART_Group5 Halfduplex mode function
//  720  *  @brief   Half-duplex mode function 
//  721  *
//  722 @verbatim   
//  723  ===============================================================================
//  724                          Half-duplex mode function
//  725  ===============================================================================  
//  726 
//  727   This subsection provides a set of functions allowing to manage the USART 
//  728   Half-duplex communication.
//  729   
//  730   The USART can be configured to follow a single-wire half-duplex protocol where 
//  731   the TX and RX lines are internally connected.
//  732 
//  733   USART Half duplex communication is possible through the following procedure:
//  734      1. Program the Baud rate, Word length, Stop bits, Parity, Mode transmitter 
//  735         or Mode receiver and hardware flow control values using the USART_Init()
//  736         function.
//  737      2. Configures the USART address using the USART_SetAddress() function.
//  738      3. Enable the USART using the USART_Cmd() function.
//  739      4. Enable the half duplex mode using USART_HalfDuplexCmd() function.
//  740 
//  741 
//  742 @note The RX pin is no longer used
//  743 @note In Half-duplex mode the following bits must be kept cleared:
//  744         - LINEN and CLKEN bits in the USART_CR2 register.
//  745         - SCEN and IREN bits in the USART_CR3 register.
//  746 
//  747 @endverbatim
//  748   * @{
//  749   */
//  750 
//  751 /**
//  752   * @brief  Enables or disables the USART's Half Duplex communication.
//  753   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  754   *         UART peripheral.
//  755   * @param  NewState: new state of the USART Communication.
//  756   *          This parameter can be: ENABLE or DISABLE.
//  757   * @retval None
//  758   */
//  759 
//  760 
//  761 /**
//  762   * @}
//  763   */
//  764 
//  765 
//  766 /** @defgroup USART_Group6 Smartcard mode functions
//  767  *  @brief   Smartcard mode functions 
//  768  *
//  769 @verbatim   
//  770  ===============================================================================
//  771                                Smartcard mode functions
//  772  ===============================================================================  
//  773 
//  774   This subsection provides a set of functions allowing to manage the USART 
//  775   Smartcard communication.
//  776   
//  777   The Smartcard interface is designed to support asynchronous protocol Smartcards as
//  778   defined in the ISO 7816-3 standard.
//  779 
//  780   The USART can provide a clock to the smartcard through the SCLK output.
//  781   In smartcard mode, SCLK is not associated to the communication but is simply derived 
//  782   from the internal peripheral input clock through a 5-bit prescaler.
//  783 
//  784   Smartcard communication is possible through the following procedure:
//  785      1. Configures the Smartcard Prescaler using the USART_SetPrescaler() function.
//  786      2. Configures the Smartcard Guard Time using the USART_SetGuardTime() function.
//  787      3. Program the USART clock using the USART_ClockInit() function as following:
//  788         - USART Clock enabled
//  789         - USART CPOL Low
//  790         - USART CPHA on first edge
//  791         - USART Last Bit Clock Enabled
//  792      4. Program the Smartcard interface using the USART_Init() function as following:
//  793         - Word Length = 9 Bits
//  794         - 1.5 Stop Bit
//  795         - Even parity
//  796         - BaudRate = 12096 baud
//  797         - Hardware flow control disabled (RTS and CTS signals)
//  798         - Tx and Rx enabled
//  799      5. Optionally you can enable the parity error interrupt using the USART_ITConfig()
//  800         function
//  801      6. Enable the USART using the USART_Cmd() function.
//  802      7. Enable the Smartcard NACK using the USART_SmartCardNACKCmd() function.
//  803      8. Enable the Smartcard interface using the USART_SmartCardCmd() function.
//  804 
//  805   Please refer to the ISO 7816-3 specification for more details.
//  806 
//  807 
//  808 @note It is also possible to choose 0.5 stop bit for receiving but it is recommended 
//  809       to use 1.5 stop bits for both transmitting and receiving to avoid switching 
//  810       between the two configurations.
//  811 @note In smartcard mode, the following bits must be kept cleared:
//  812         - LINEN bit in the USART_CR2 register.
//  813         - HDSEL and IREN bits in the USART_CR3 register.
//  814 @note Smartcard mode is available on USART peripherals only (not available on UART4 
//  815       and UART5 peripherals).
//  816 
//  817 @endverbatim
//  818   * @{
//  819   */
//  820 
//  821 /**
//  822   * @brief  Sets the specified USART guard time.
//  823   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  824   *         UART peripheral.
//  825   * @param  USART_GuardTime: specifies the guard time.   
//  826   * @retval None
//  827   */
//  828 
//  829 /**
//  830   * @brief  Enables or disables the USART's Smart Card mode.
//  831   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  832   *         UART peripheral.
//  833   * @param  NewState: new state of the Smart Card mode.
//  834   *          This parameter can be: ENABLE or DISABLE.      
//  835   * @retval None
//  836   */
//  837 
//  838 
//  839 /**
//  840   * @brief  Enables or disables NACK transmission.
//  841   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  842   *         UART peripheral.
//  843   * @param  NewState: new state of the NACK transmission.
//  844   *          This parameter can be: ENABLE or DISABLE.  
//  845   * @retval None
//  846   */
//  847 
//  848 /**
//  849   * @}
//  850   */
//  851 
//  852 /** @defgroup USART_Group7 IrDA mode functions
//  853  *  @brief   IrDA mode functions 
//  854  *
//  855 @verbatim   
//  856  ===============================================================================
//  857                                 IrDA mode functions
//  858  ===============================================================================  
//  859 
//  860   This subsection provides a set of functions allowing to manage the USART 
//  861   IrDA communication.
//  862   
//  863   IrDA is a half duplex communication protocol. If the Transmitter is busy, any data
//  864   on the IrDA receive line will be ignored by the IrDA decoder and if the Receiver 
//  865   is busy, data on the TX from the USART to IrDA will not be encoded by IrDA.
//  866   While receiving data, transmission should be avoided as the data to be transmitted
//  867   could be corrupted.
//  868 
//  869   IrDA communication is possible through the following procedure:
//  870      1. Program the Baud rate, Word length = 8 bits, Stop bits, Parity, Transmitter/Receiver 
//  871         modes and hardware flow control values using the USART_Init() function.
//  872      2. Enable the USART using the USART_Cmd() function.
//  873      3. Configures the IrDA pulse width by configuring the prescaler using  
//  874         the USART_SetPrescaler() function.
//  875      4. Configures the IrDA  USART_IrDAMode_LowPower or USART_IrDAMode_Normal mode
//  876         using the USART_IrDAConfig() function.
//  877      5. Enable the IrDA using the USART_IrDACmd() function.
//  878 
//  879 @note A pulse of width less than two and greater than one PSC period(s) may or may
//  880       not be rejected.
//  881 @note The receiver set up time should be managed by software. The IrDA physical layer
//  882       specification specifies a minimum of 10 ms delay between transmission and 
//  883       reception (IrDA is a half duplex protocol).
//  884 @note In IrDA mode, the following bits must be kept cleared:
//  885         - LINEN, STOP and CLKEN bits in the USART_CR2 register.
//  886         - SCEN and HDSEL bits in the USART_CR3 register.
//  887 
//  888 @endverbatim
//  889   * @{
//  890   */
//  891 
//  892 /**
//  893   * @brief  Configures the USART's IrDA interface.
//  894   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  895   *         UART peripheral.
//  896   * @param  USART_IrDAMode: specifies the IrDA mode.
//  897   *          This parameter can be one of the following values:
//  898   *            @arg USART_IrDAMode_LowPower
//  899   *            @arg USART_IrDAMode_Normal
//  900   * @retval None
//  901   */
//  902 
//  903 /**
//  904   * @brief  Enables or disables the USART's IrDA interface.
//  905   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  906   *         UART peripheral.
//  907   * @param  NewState: new state of the IrDA mode.
//  908   *          This parameter can be: ENABLE or DISABLE.
//  909   * @retval None
//  910   */
//  911 
//  912 
//  913 /**
//  914   * @}
//  915   */
//  916 
//  917 /** @defgroup USART_Group8 DMA transfers management functions
//  918  *  @brief   DMA transfers management functions
//  919  *
//  920 @verbatim   
//  921  ===============================================================================
//  922                       DMA transfers management functions
//  923  ===============================================================================  
//  924 
//  925 @endverbatim
//  926   * @{
//  927   */
//  928   
//  929 /**
//  930   * @brief  Enables or disables the USART's DMA interface.
//  931   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  932   *         UART peripheral.
//  933   * @param  USART_DMAReq: specifies the DMA request.
//  934   *          This parameter can be any combination of the following values:
//  935   *            @arg USART_DMAReq_Tx: USART DMA transmit request
//  936   *            @arg USART_DMAReq_Rx: USART DMA receive request
//  937   * @param  NewState: new state of the DMA Request sources.
//  938   *          This parameter can be: ENABLE or DISABLE.   
//  939   * @retval None
//  940   */
//  941 
//  942 /**
//  943   * @}
//  944   */
//  945   
//  946 /** @defgroup USART_Group9 Interrupts and flags management functions
//  947  *  @brief   Interrupts and flags management functions 
//  948  *
//  949 @verbatim   
//  950  ===============================================================================
//  951                    Interrupts and flags management functions
//  952  ===============================================================================  
//  953 
//  954   This subsection provides a set of functions allowing to configure the USART 
//  955   Interrupts sources, DMA channels requests and check or clear the flags or 
//  956   pending bits status.
//  957   The user should identify which mode will be used in his application to manage 
//  958   the communication: Polling mode, Interrupt mode or DMA mode. 
//  959     
//  960   Polling Mode
//  961   =============
//  962   In Polling Mode, the SPI communication can be managed by 10 flags:
//  963      1. USART_FLAG_TXE : to indicate the status of the transmit buffer register
//  964      2. USART_FLAG_RXNE : to indicate the status of the receive buffer register
//  965      3. USART_FLAG_TC : to indicate the status of the transmit operation
//  966      4. USART_FLAG_IDLE : to indicate the status of the Idle Line             
//  967      5. USART_FLAG_CTS : to indicate the status of the nCTS input
//  968      6. USART_FLAG_LBD : to indicate the status of the LIN break detection
//  969      7. USART_FLAG_NE : to indicate if a noise error occur
//  970      8. USART_FLAG_FE : to indicate if a frame error occur
//  971      9. USART_FLAG_PE : to indicate if a parity error occur
//  972      10. USART_FLAG_ORE : to indicate if an Overrun error occur
//  973 
//  974   In this Mode it is advised to use the following functions:
//  975       - FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, uint16_t USART_FLAG);
//  976       - void USART_ClearFlag(USART_TypeDef* USARTx, uint16_t USART_FLAG);
//  977 
//  978   Interrupt Mode
//  979   ===============
//  980   In Interrupt Mode, the USART communication can be managed by 8 interrupt sources
//  981   and 10 pending bits: 
//  982 
//  983   Pending Bits:
//  984   ------------- 
//  985      1. USART_IT_TXE : to indicate the status of the transmit buffer register
//  986      2. USART_IT_RXNE : to indicate the status of the receive buffer register
//  987      3. USART_IT_TC : to indicate the status of the transmit operation
//  988      4. USART_IT_IDLE : to indicate the status of the Idle Line             
//  989      5. USART_IT_CTS : to indicate the status of the nCTS input
//  990      6. USART_IT_LBD : to indicate the status of the LIN break detection
//  991      7. USART_IT_NE : to indicate if a noise error occur
//  992      8. USART_IT_FE : to indicate if a frame error occur
//  993      9. USART_IT_PE : to indicate if a parity error occur
//  994      10. USART_IT_ORE : to indicate if an Overrun error occur
//  995 
//  996   Interrupt Source:
//  997   -----------------
//  998      1. USART_IT_TXE : specifies the interrupt source for the Tx buffer empty 
//  999                        interrupt. 
// 1000      2. USART_IT_RXNE : specifies the interrupt source for the Rx buffer not 
// 1001                         empty interrupt.
// 1002      3. USART_IT_TC : specifies the interrupt source for the Transmit complete 
// 1003                        interrupt. 
// 1004      4. USART_IT_IDLE : specifies the interrupt source for the Idle Line interrupt.             
// 1005      5. USART_IT_CTS : specifies the interrupt source for the CTS interrupt. 
// 1006      6. USART_IT_LBD : specifies the interrupt source for the LIN break detection
// 1007                        interrupt. 
// 1008      7. USART_IT_PE : specifies the interrupt source for the parity error interrupt. 
// 1009      8. USART_IT_ERR :  specifies the interrupt source for the errors interrupt.
// 1010 
// 1011 @note Some parameters are coded in order to use them as interrupt source or as pending bits.
// 1012 
// 1013   In this Mode it is advised to use the following functions:
// 1014      - void USART_ITConfig(USART_TypeDef* USARTx, uint16_t USART_IT, FunctionalState NewState);
// 1015      - ITStatus USART_GetITStatus(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1016      - void USART_ClearITPendingBit(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1017 
// 1018   DMA Mode
// 1019   ========
// 1020   In DMA Mode, the USART communication can be managed by 2 DMA Channel requests:
// 1021      1. USART_DMAReq_Tx: specifies the Tx buffer DMA transfer request
// 1022      2. USART_DMAReq_Rx: specifies the Rx buffer DMA transfer request
// 1023 
// 1024   In this Mode it is advised to use the following function:
// 1025      - void USART_DMACmd(USART_TypeDef* USARTx, uint16_t USART_DMAReq, FunctionalState NewState);
// 1026 
// 1027 @endverbatim
// 1028   * @{
// 1029   */
// 1030 
// 1031 /**
// 1032   * @brief  Enables or disables the specified USART interrupts.
// 1033   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1034   *         UART peripheral.
// 1035   * @param  USART_IT: specifies the USART interrupt sources to be enabled or disabled.
// 1036   *          This parameter can be one of the following values:
// 1037   *            @arg USART_IT_CTS:  CTS change interrupt
// 1038   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1039   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1040   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1041   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1042   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1043   *            @arg USART_IT_PE:   Parity Error interrupt
// 1044   *            @arg USART_IT_ERR:  Error interrupt(Frame error, noise error, overrun error)
// 1045   * @param  NewState: new state of the specified USARTx interrupts.
// 1046   *          This parameter can be: ENABLE or DISABLE.
// 1047   * @retval None
// 1048   */
// 1049 
// 1050 /**
// 1051   * @brief  Checks whether the specified USART flag is set or not.
// 1052   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1053   *         UART peripheral.
// 1054   * @param  USART_FLAG: specifies the flag to check.
// 1055   *          This parameter can be one of the following values:
// 1056   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5)
// 1057   *            @arg USART_FLAG_LBD:  LIN Break detection flag
// 1058   *            @arg USART_FLAG_TXE:  Transmit data register empty flag
// 1059   *            @arg USART_FLAG_TC:   Transmission Complete flag
// 1060   *            @arg USART_FLAG_RXNE: Receive data register not empty flag
// 1061   *            @arg USART_FLAG_IDLE: Idle Line detection flag
// 1062   *            @arg USART_FLAG_ORE:  OverRun Error flag
// 1063   *            @arg USART_FLAG_NE:   Noise Error flag
// 1064   *            @arg USART_FLAG_FE:   Framing Error flag
// 1065   *            @arg USART_FLAG_PE:   Parity Error flag
// 1066   * @retval The new state of USART_FLAG (SET or RESET).
// 1067   */
// 1068 
// 1069 /**
// 1070   * @brief  Clears the USARTx's pending flags.
// 1071   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1072   *         UART peripheral.
// 1073   * @param  USART_FLAG: specifies the flag to clear.
// 1074   *          This parameter can be any combination of the following values:
// 1075   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5).
// 1076   *            @arg USART_FLAG_LBD:  LIN Break detection flag.
// 1077   *            @arg USART_FLAG_TC:   Transmission Complete flag.
// 1078   *            @arg USART_FLAG_RXNE: Receive data register not empty flag.
// 1079   *   
// 1080   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1081   *          error) and IDLE (Idle line detected) flags are cleared by software 
// 1082   *          sequence: a read operation to USART_SR register (USART_GetFlagStatus()) 
// 1083   *          followed by a read operation to USART_DR register (USART_ReceiveData()).
// 1084   * @note   RXNE flag can be also cleared by a read to the USART_DR register 
// 1085   *          (USART_ReceiveData()).
// 1086   * @note   TC flag can be also cleared by software sequence: a read operation to 
// 1087   *          USART_SR register (USART_GetFlagStatus()) followed by a write operation
// 1088   *          to USART_DR register (USART_SendData()).
// 1089   * @note   TXE flag is cleared only by a write to the USART_DR register 
// 1090   *          (USART_SendData()).
// 1091   *   
// 1092   * @retval None
// 1093   */
// 1094 
// 1095 
// 1096 /**
// 1097   * @brief  Checks whether the specified USART interrupt has occurred or not.
// 1098   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1099   *         UART peripheral.
// 1100   * @param  USART_IT: specifies the USART interrupt source to check.
// 1101   *          This parameter can be one of the following values:
// 1102   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1103   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1104   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1105   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1106   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1107   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1108   *            @arg USART_IT_ORE:  OverRun Error interrupt
// 1109   *            @arg USART_IT_NE:   Noise Error interrupt
// 1110   *            @arg USART_IT_FE:   Framing Error interrupt
// 1111   *            @arg USART_IT_PE:   Parity Error interrupt
// 1112   * @retval The new state of USART_IT (SET or RESET).
// 1113   */
// 1114 
// 1115 
// 1116 /**
// 1117   * @brief  Clears the USARTx's interrupt pending bits.
// 1118   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1119   *         UART peripheral.
// 1120   * @param  USART_IT: specifies the interrupt pending bit to clear.
// 1121   *          This parameter can be one of the following values:
// 1122   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1123   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1124   *            @arg USART_IT_TC:   Transmission complete interrupt. 
// 1125   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt.
// 1126   *
// 1127   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1128   *          error) and IDLE (Idle line detected) pending bits are cleared by 
// 1129   *          software sequence: a read operation to USART_SR register 
// 1130   *          (USART_GetITStatus()) followed by a read operation to USART_DR register 
// 1131   *          (USART_ReceiveData()).
// 1132   * @note   RXNE pending bit can be also cleared by a read to the USART_DR register 
// 1133   *          (USART_ReceiveData()).
// 1134   * @note   TC pending bit can be also cleared by software sequence: a read 
// 1135   *          operation to USART_SR register (USART_GetITStatus()) followed by a write 
// 1136   *          operation to USART_DR register (USART_SendData()).
// 1137   * @note   TXE pending bit is cleared only by a write to the USART_DR register 
// 1138   *          (USART_SendData()).
// 1139   *  
// 1140   * @retval None
// 1141   */
// 1142 
// 1143 
// 1144 /**
// 1145   * @}
// 1146   */
// 1147 
// 1148 /**
// 1149   * @}
// 1150   */
// 1151 
// 1152 /**
// 1153   * @}
// 1154   */
// 1155 
// 1156 /**
// 1157   * @}
// 1158   */
// 1159 
// 1160 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
//     2 bytes in section .rodata
//   730 bytes in section .text
// 4 148 bytes in section iram
// 
//   730 bytes of CODE  memory
//     2 bytes of CONST memory
// 4 148 bytes of DATA  memory
//
//Errors: none
//Warnings: none
