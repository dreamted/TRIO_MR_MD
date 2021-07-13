///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:03 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart2_1208.c                         /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_usart2_1208.c -D OS_INCLUDED -D       /
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
//                    rt2_1208.s                                              /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_usart2_1208

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

        PUBLIC InitUSART2
        PUBLIC Rx2Buff
        PUBLIC Rx2RdCnt
        PUBLIC Rx2WrCnt
        PUBLIC Tx2Buff
        PUBLIC Tx2RdCnt
        PUBLIC Tx2WrCnt
        PUBLIC USART2BuffClear
        PUBLIC USART2CheckByte
        PUBLIC USART2Printf
        PUBLIC USART2PutChar
        PUBLIC USART2PutStr
        PUBLIC USART2PutToBuffer
        PUBLIC USART2RxGetByte
        PUBLIC USART2TxCheckByte
        PUBLIC USART2TxClear
        PUBLIC USART2_IRQIntHandler
        PUBLIC pUSART2
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_usart2_1208.c
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
//   85 #include "stm32f2xx_usart2_1208.h"
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
//  103 	INT8U Rx2Buff[Rx2BuffLen];
//  104 	INT8U Tx2Buff[Tx2BuffLen];
//  105 
//  106 	INT16U	Rx2RdCnt = 0, Rx2WrCnt = 0;
//  107 	INT16U	Tx2RdCnt = 0, Tx2WrCnt = 0;
//  108 #else

        SECTION iram:DATA:REORDER:NOROOT(2)
//  109 	INT8U Rx2Buff[Rx2BuffLen] @ "iram";
Rx2Buff:
        DS8 2048

        SECTION iram:DATA:REORDER:NOROOT(2)
//  110 	INT8U Tx2Buff[Tx2BuffLen] @ "iram";
Tx2Buff:
        DS8 2048
//  111 

        SECTION iram:DATA:REORDER:NOROOT(2)
//  112 	INT16U	Rx2RdCnt @ "iram"= 0, Rx2WrCnt @ "iram" = 0;
Rx2RdCnt:
        DATA
        DC16 0
Rx2WrCnt:
        DC16 0
//  113 	INT16U	Tx2RdCnt @ "iram"= 0, Tx2WrCnt @ "iram" = 0;
Tx2RdCnt:
        DC16 0
Tx2WrCnt:
        DC16 0
//  114 #endif
//  115 
//  116 #if !defined (OS_INCLUDED) 
//  117 __SerStrPtr pUSART2 = {
//  118 
//  119 #else
//  120 __SerStrPtr pUSART2 @ "iram" = {
pUSART2:
        DC32 InitUSART2, USART2CheckByte, USART2RxGetByte, USART2PutStr
        DC32 USART2Printf, USART2PutChar, USART2PutToBuffer, USART2TxCheckByte
        DC32 USART2BuffClear, USART2TxClear
        DC8 0, 0, 0, 0
//  121 #endif
//  122 	InitUSART2,
//  123 	USART2CheckByte,
//  124 	USART2RxGetByte,
//  125 	USART2PutStr,
//  126 	USART2Printf,
//  127 	USART2PutChar,
//  128 	USART2PutToBuffer,
//  129 	USART2TxCheckByte,
//  130 	USART2BuffClear,
//  131 	USART2TxClear
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
        CFI Function InitUSART2
        THUMB
//  194 void InitUSART2(INT32U nBps, INT32U nLCR)
//  195 {
InitUSART2:
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
        LDR.N    R0,??DataTable9_1  ;; 0x40023830
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//  201 	RCC->__B.APB1ENR.USART2EN = ENABLE;
        LDR      R1,[R0, #+16]
        ORR      R1,R1,#0x20000
        STR      R1,[R0, #+16]
//  202 	
//  203 	__PA2_U2_TX();				// USART2_TX
        LDR.N    R6,??DataTable9_2  ;; 0x40020000
        MOVS     R3,#+2
        MOV      R2,R6
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  204 	__PA3_U2_RX();				// USART2_RX
        MOVS     R3,#+3
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
        BEQ.N    ??InitUSART2_0
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
??InitUSART2_0:
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
//  242 	USART_Init(USART2, &USART_InitStructure);
        LDR.N    R4,??DataTable9_3  ;; 0x40004400
        ADD      R1,SP,#+0
        MOV      R0,R4
        BL       USART_Init
//  243 
//  244 #if defined (OS_INCLUDED) 
//  245 	pUSART2.sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.N    R1,??DataTable9_4
        STR      R0,[R1, #+48]
//  246 #endif
//  247 	/* Enable USART */
//  248 	USART_Cmd(USART2, ENABLE);
        MOVS     R1,#+1
        MOV      R0,R4
        BL       USART_Cmd
//  249 
//  250 	USART_ITConfig(USART2, USART_IT_RXNE, ENABLE);
        MOVS     R2,#+1
        MOVW     R1,#+1317
        MOV      R0,R4
        BL       USART_ITConfig
//  251 	NVIC_Init(USART2_IRQn, ENABLE); 
        MOVS     R1,#+1
        MOVS     R0,#+38
        BL       NVIC_Init
//  252 
//  253 	USART2Printf("\n");	
        ADR.N    R0,??DataTable9  ;; "\n"
        BL       USART2Printf
//  254 }
        ADD      SP,SP,#+16
        CFI CFA R13+16
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock0
//  255 
//  256 /*******************************************************************************
//  257   * @brief  Interrupt handler USART2 global interrupt request
//  258   * @param  None 
//  259   * @retval None
//  260   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function USART2_IRQIntHandler
        THUMB
//  261 void USART2_IRQIntHandler(void)
//  262 {
USART2_IRQIntHandler:
        PUSH     {R3-R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+16
//  263 
//  264 	INT16U tmp = USART2->SR;
        LDR.N    R4,??DataTable9_3  ;; 0x40004400
        LDRH     R5,[R4, #+0]
//  265 
//  266 #ifdef OS_INCLUDED
//  267 	INT32U cpu_sr;
//  268 	CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
        BL       CPU_SR_Save
//  269 	OSIntNesting++;
        LDR.N    R1,??DataTable9_5
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  270 	CPU_CRITICAL_EXIT();
        BL       CPU_SR_Restore
//  271 #endif /* OS_INCLUDED */
//  272 	// Rx Data Received
//  273 	if(tmp & ( 1 << __RXNE))
        LSLS     R0,R5,#+26
        BPL.N    ??USART2_IRQIntHandler_0
//  274 	{
//  275 		Rx2Buff[Rx2WrCnt%Rx2BuffLen] = USART2->DR;		// When the receive register is read, the RDR bit is automatically cleared.
        LDR.N    R0,??DataTable9_4
        LDRH     R1,[R0, #+2]
        LSLS     R2,R1,#+21
        LSRS     R2,R2,#+21
        LDR.N    R3,??DataTable9_6
        LDRH     R4,[R4, #+4]
        STRB     R4,[R2, R3]
//  276 		if(++Rx2WrCnt >= Rx2BuffLen) Rx2WrCnt = 0;
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+2]
        UXTH     R1,R1
        CMP      R1,#+2048
        BCC.N    ??USART2_IRQIntHandler_1
        MOVS     R1,#+0
        STRH     R1,[R0, #+2]
        B.N      ??USART2_IRQIntHandler_1
//  277 	}
//  278 	else if(tmp & ( 1 << __TXE))
??USART2_IRQIntHandler_0:
        LSLS     R0,R5,#+24
        BPL.N    ??USART2_IRQIntHandler_2
//  279 	{
//  280 		if(Tx2RdCnt != Tx2WrCnt)
        LDR.N    R0,??DataTable9_4
        LDRH     R1,[R0, #+4]
        LDRH     R2,[R0, #+6]
        CMP      R1,R2
        BEQ.N    ??USART2_IRQIntHandler_3
//  281 		{
//  282 			USART2->DR = Tx2Buff[Tx2RdCnt%Tx2BuffLen];
        LSLS     R1,R1,#+21
        LSRS     R1,R1,#+21
        LDR.N    R2,??DataTable9_7
        LDRB     R1,[R1, R2]
        STRH     R1,[R4, #+4]
//  283 			if(++Tx2RdCnt >= Tx2BuffLen ) Tx2RdCnt = 0;
        LDRH     R1,[R0, #+4]
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+4]
        UXTH     R1,R1
        CMP      R1,#+2048
        BCC.N    ??USART2_IRQIntHandler_1
        MOVS     R1,#+0
        STRH     R1,[R0, #+4]
        B.N      ??USART2_IRQIntHandler_1
//  284 		}
//  285 		else USART2->__B.CR1.TXEIE = DISABLE;
??USART2_IRQIntHandler_3:
        LDR      R0,[R4, #+12]
        BIC      R0,R0,#0x80
        STR      R0,[R4, #+12]
        B.N      ??USART2_IRQIntHandler_1
//  286 	}
//  287 	else // error, dummy read
//  288 	{
//  289 		tmp =  USART2->DR;
??USART2_IRQIntHandler_2:
        LDRH     R0,[R4, #+4]
//  290 	}
//  291 
//  292 #ifdef OS_INCLUDED
//  293 	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
??USART2_IRQIntHandler_1:
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
        CFI Function USART2PutToBuffer
        THUMB
//  298 unsigned char USART2PutToBuffer(unsigned char Data)
//  299 {
USART2PutToBuffer:
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
//  304 	OSSemPend(pUSART2.sem, 0, &err);
        LDR.N    R4,??DataTable9_4
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  305 #endif /* OS_INCLUDED */
//  306 	//////////////////////////////////////////////////
//  307 	Tx2Buff[Tx2WrCnt%Tx2BuffLen] = Data;
        LDRH     R0,[R4, #+6]
        LSLS     R1,R0,#+21
        LSRS     R1,R1,#+21
        LDR.N    R2,??DataTable9_7
        STRB     R5,[R1, R2]
//  308 	if(++Tx2WrCnt >= Tx2BuffLen) Tx2WrCnt = 0;
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        CMP      R0,#+2048
        IT       CS 
        MOVCS    R0,#+0
        STRH     R0,[R4, #+6]
//  309 	
//  310 	USART2->__B.CR1.TXEIE = ENABLE; 		
        LDR.N    R0,??DataTable9_8  ;; 0x4000440c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+0]
//  311 	///////////////////////////////////////////////////
//  312 #ifdef OS_INCLUDED
//  313 	OSSemPost(pUSART2.sem);
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
        CFI Function USART2PutChar
        THUMB
//  322 unsigned char USART2PutChar(unsigned char Data)
//  323 {
USART2PutChar:
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
//  328 		OSSemPend(pUSART2.sem, 0, &err);
        LDR.N    R5,??DataTable9_4
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R5, #+48]
        BL       OSSemPend
//  329 	#endif /* OS_INCLUDED */
//  330 		USART2->__B.DR.DR = Data;
        LDR.N    R0,??DataTable9_3  ;; 0x40004400
        LDR      R1,[R0, #+4]
        BFI      R1,R4,#+0,#+9
        STR      R1,[R0, #+4]
//  331 		while(!USART2->__B.SR.TXE);
??USART2PutChar_0:
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??USART2PutChar_0
//  332 	#ifdef OS_INCLUDED
//  333 		OSSemPost(pUSART2.sem);
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
        CFI Function USART2Printf
        THUMB
//  338 unsigned long int USART2Printf( const char *format, ...)
//  339 {
USART2Printf:
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
        B.N      ??USART2Printf_0
//  349 	{
//  350 		if(buf[i] == 0) break;
//  351 		if(buf[i] == '\n') USART2PutToBuffer('\r');
??USART2Printf_1:
        CMP      R0,#+10
        ITT      EQ 
        MOVEQ    R0,#+13
        BLEQ     USART2PutToBuffer
//  352 		USART2PutToBuffer(buf[i]);
        LDRB     R0,[R5], #+1
        BL       USART2PutToBuffer
??USART2Printf_0:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??USART2Printf_1
//  353 	}
//  354 	while(!USART2TxCheckByte())
??USART2Printf_2:
        BL       USART2TxCheckByte
        CBNZ.N   R0,??USART2Printf_3
//  355 	{
//  356 #ifdef OS_INCLUDED
//  357 	OSTimeDly(1);
        MOVS     R0,#+1
        BL       OSTimeDly
        B.N      ??USART2Printf_2
//  358 #endif /* OS_INCLUDED */
//  359 	}
//  360 	return cnt;
??USART2Printf_3:
        MOV      R0,R4
        ADD      SP,SP,#+128
        CFI CFA R13+24
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+16
        LDR      PC,[SP], #+16    ;; return
        CFI EndBlock cfiBlock4
//  361 }
//  362 
//  363 //#define OS_INCLUDED
//  364 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function USART2PutStr
        THUMB
//  365 void USART2PutStr(unsigned char *Str, unsigned short int Length, int iEn)
//  366 {
USART2PutStr:
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
//  367 	u32 i = 0;
//  368 
//  369 	USART2BuffClear();
        BL       USART2BuffClear
//  370 	
//  371 #ifdef OS_INCLUDED
//  372 	INT8U err;
//  373 	OSSemPend(pUSART2.sem, 0, &err);
        LDR.N    R4,??DataTable9_4
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R4, #+48]
        BL       OSSemPend
//  374 #endif /* OS_INCLUDED */
//  375 
//  376 
//  377 	for(i = 0; i < Length; i++)
        LDRH     R0,[R4, #+6]
        CBZ.N    R6,??USART2PutStr_0
        LDR.N    R1,??DataTable9_7
//  378 	{
//  379 		Tx2Buff[Tx2WrCnt++] = Str[i];
??USART2PutStr_1:
        LDRB     R2,[R5, #+0]
        STRB     R2,[R0, R1]
        ADDS     R0,R0,#+1
//  380 		if(Tx2WrCnt >= Tx2BuffLen) Tx2WrCnt = 0;
        UXTH     R0,R0
        CMP      R0,#+2048
        IT       CS 
        MOVCS    R0,#+0
//  381 	}
        ADDS     R5,R5,#+1
        SUBS     R6,R6,#+1
        BNE.N    ??USART2PutStr_1
??USART2PutStr_0:
        STRH     R0,[R4, #+6]
//  382 
//  383 	if(iEn)
        CBZ.N    R7,??USART2PutStr_2
//  384 	{
//  385 		USART2->__B.CR1.TXEIE = ENABLE;
        LDR.N    R0,??DataTable9_8  ;; 0x4000440c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+0]
//  386 	}	
//  387 #ifdef OS_INCLUDED
//  388 		OSSemPost(pUSART2.sem);
??USART2PutStr_2:
        LDR      R0,[R4, #+48]
        BL       OSSemPost
//  389 #endif /* OS_INCLUDED */
//  390 }
        POP      {R0,R4-R7,PC}    ;; return
        CFI EndBlock cfiBlock5
//  391 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function USART2RxGetByte
        THUMB
//  392 signed short int USART2RxGetByte(void)
//  393 {
//  394 	s16 RetVal = 0;
//  395 
//  396 #ifndef APPL_SRC
//  397 	while(Rx2RdCnt == Rx2WrCnt);
//  398 #else
//  399 	if(Rx2RdCnt == Rx2WrCnt) return -1;
USART2RxGetByte:
        LDR.N    R1,??DataTable9_4
        LDRH     R2,[R1, #+0]
        LDRH     R0,[R1, #+2]
        CMP      R2,R0
        BNE.N    ??USART2RxGetByte_0
        MOV      R0,#-1
        BX       LR
//  400 #endif
//  401 
//  402 	RetVal = Rx2Buff[Rx2RdCnt%Rx2BuffLen];
??USART2RxGetByte_0:
        LSLS     R0,R2,#+21
        LSRS     R0,R0,#+21
        LDR.N    R3,??DataTable9_6
        LDRB     R0,[R0, R3]
//  403 	if(++Rx2RdCnt >= Rx2BuffLen) Rx2RdCnt = 0;
        ADDS     R2,R2,#+1
        STRH     R2,[R1, #+0]
        UXTH     R2,R2
        CMP      R2,#+2048
        BCC.N    ??USART2RxGetByte_1
        MOVS     R2,#+0
        STRH     R2,[R1, #+0]
//  404 
//  405 	return (RetVal & 0xff);
??USART2RxGetByte_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  406 }
//  407 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function USART2CheckByte
        THUMB
//  408 unsigned char USART2CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
//  409 {
USART2CheckByte:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  410 	u32 i = 0, j = 0;
//  411 	u8 RetVal = TRUE;
        MOVS     R2,#+1
//  412 
//  413 	*Recv = 0;
        MOVS     R3,#+0
        STRH     R3,[R1, #+0]
//  414 	i = (u32) Rx2RdCnt;
        LDR.N    R3,??DataTable9_4
        LDRH     R4,[R3, #+0]
//  415 	j = (u32) Rx2WrCnt;
        LDRH     R3,[R3, #+2]
//  416 
//  417 	if(i == j) RetVal = FALSE;
        CMP      R4,R3
        BEQ.N    ??USART2CheckByte_0
//  418 	else if(i < j)
        ADDS     R0,R0,R4
        CMP      R4,R3
        BCS.N    ??USART2CheckByte_1
//  419 	{
//  420 		*Recv = j - i;
        SUBS     R4,R3,R4
        STRH     R4,[R1, #+0]
//  421 		i = i + ByteCnt;
//  422 		if(i > j) RetVal = FALSE;
        CMP      R3,R0
        BCS.N    ??USART2CheckByte_2
        B.N      ??USART2CheckByte_0
//  423 	}
//  424 	else if(i > j)
//  425 	{
//  426 		*Recv = (Rx2BuffLen +j) - i;
??USART2CheckByte_1:
        ADD      R5,R3,#+2048
        SUBS     R4,R5,R4
        STRH     R4,[R1, #+0]
//  427 		i = i + ByteCnt;
//  428 		j = j + Rx2BuffLen;
//  429 		if(i > j) RetVal = FALSE; 
        ADD      R1,R3,#+2048
        CMP      R1,R0
        BCS.N    ??USART2CheckByte_2
??USART2CheckByte_0:
        MOVS     R2,#+0
//  430 	}
//  431 	return (RetVal);
??USART2CheckByte_2:
        MOV      R0,R2
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  432 }
//  433 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function USART2BuffClear
        THUMB
//  434 void USART2BuffClear(void)
//  435 {
//  436 	Rx2RdCnt = 0;
USART2BuffClear:
        LDR.N    R0,??DataTable9_4
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  437 	Rx2WrCnt = 0;
        STRH     R1,[R0, #+2]
//  438 	Tx2RdCnt = 0;
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock8
//  439 	Tx2WrCnt = 0;
//  440 }
//  441 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function USART2TxClear
        THUMB
//  442 void USART2TxClear(void)
//  443 {
//  444 	Tx2RdCnt = 0;
USART2TxClear:
        LDR.N    R0,??DataTable9_4
        MOVS     R1,#+0
        CFI EndBlock cfiBlock9
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  445 	Tx2WrCnt = 0;
//  446 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        STRH     R1,[R0, #+4]
        STRH     R1,[R0, #+6]
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  447 
//  448 /*******************************************************************************
//  449   * @brief  if the bytes have been transmitted, retrun true or not
//  450   * @param  None
//  451   * @retval TRUE/FALSE
//  452   ******************************************************************************/
//  453 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function USART2TxCheckByte
        THUMB
//  454 signed short int USART2TxCheckByte(void)
//  455 {
//  456 	if(Tx2RdCnt == Tx2WrCnt) return TRUE;
USART2TxCheckByte:
        LDR.N    R0,??DataTable9_4
        LDRH     R1,[R0, #+4]
        LDRH     R0,[R0, #+6]
        CMP      R1,R0
        BNE.N    ??USART2TxCheckByte_0
        MOVS     R0,#+1
        BX       LR
//  457 	else return FALSE;
??USART2TxCheckByte_0:
        MOVS     R0,#+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  458 }

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
        DC32     0x40020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x40004400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     Rx2RdCnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC32     Rx2Buff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC32     Tx2Buff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC32     0x4000440c

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
//  459 
//  460 
//  461 
//  462 
//  463 /**
//  464   * @brief  Initializes the USARTx peripheral Clock according to the 
//  465   *         specified parameters in the USART_ClockInitStruct .
//  466   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART peripheral.
//  467   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure that
//  468   *         contains the configuration information for the specified  USART peripheral.
//  469   * @note   The Smart Card and Synchronous modes are not available for UART4 and UART5.    
//  470   * @retval None
//  471   */
//  472 
//  473 /**
//  474   * @brief  Fills each USART_ClockInitStruct member with its default value.
//  475   * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure
//  476   *         which will be initialized.
//  477   * @retval None
//  478   */
//  479 
//  480 
//  481 /**
//  482   * @brief  Enables or disables the specified USART peripheral.
//  483   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  484   *         UART peripheral.
//  485   * @param  NewState: new state of the USARTx peripheral.
//  486   *          This parameter can be: ENABLE or DISABLE.
//  487   * @retval None
//  488   */
//  489 
//  490 
//  491 /**
//  492   * @brief  Sets the system clock prescaler.
//  493   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  494   *         UART peripheral.
//  495   * @param  USART_Prescaler: specifies the prescaler clock. 
//  496   * @note   The function is used for IrDA mode with UART4 and UART5.   
//  497   * @retval None
//  498   */
//  499 
//  500 /**
//  501   * @brief  Enables or disables the USART's 8x oversampling mode.
//  502   * @note   This function has to be called before calling USART_Init() function
//  503   *         in order to have correct baudrate Divider value.
//  504   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  505   *         UART peripheral.
//  506   * @param  NewState: new state of the USART 8x oversampling mode.
//  507   *          This parameter can be: ENABLE or DISABLE.
//  508   * @retval None
//  509   */
//  510   
//  511 
//  512 /**
//  513   * @brief  Enables or disables the USART's one bit sampling method.
//  514   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  515   *         UART peripheral.
//  516   * @param  NewState: new state of the USART one bit sampling method.
//  517   *          This parameter can be: ENABLE or DISABLE.
//  518   * @retval None
//  519   */
//  520 
//  521 /**
//  522   * @}
//  523   */
//  524 
//  525 /** @defgroup USART_Group2 Data transfers functions
//  526  *  @brief   Data transfers functions 
//  527  *
//  528 @verbatim   
//  529  ===============================================================================
//  530                             Data transfers functions
//  531  ===============================================================================  
//  532 
//  533   This subsection provides a set of functions allowing to manage the USART data 
//  534   transfers.
//  535   
//  536   During an USART reception, data shifts in least significant bit first through 
//  537   the RX pin. In this mode, the USART_DR register consists of a buffer (RDR) 
//  538   between the internal bus and the received shift register.
//  539 
//  540   When a transmission is taking place, a write instruction to the USART_DR register 
//  541   stores the data in the TDR register and which is copied in the shift register 
//  542   at the end of the current transmission.
//  543 
//  544   The read access of the USART_DR register can be done using the USART_ReceiveData()
//  545   function and returns the RDR buffered value. Whereas a write access to the USART_DR 
//  546   can be done using USART_SendData() function and stores the written data into 
//  547   TDR buffer.
//  548 
//  549 @endverbatim
//  550   * @{
//  551   */
//  552 
//  553 /**
//  554   * @brief  Transmits single data through the USARTx peripheral.
//  555   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  556   *         UART peripheral.
//  557   * @param  Data: the data to transmit.
//  558   * @retval None
//  559   */
//  560 
//  561 
//  562 /**
//  563   * @brief  Returns the most recent received data by the USARTx peripheral.
//  564   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  565   *         UART peripheral.
//  566   * @retval The received data.
//  567   */
//  568 
//  569 /**
//  570   * @}
//  571   */
//  572 
//  573 /** @defgroup USART_Group3 MultiProcessor Communication functions
//  574  *  @brief   Multi-Processor Communication functions 
//  575  *
//  576 @verbatim   
//  577  ===============================================================================
//  578                     Multi-Processor Communication functions
//  579  ===============================================================================  
//  580 
//  581   This subsection provides a set of functions allowing to manage the USART 
//  582   multiprocessor communication.
//  583   
//  584   For instance one of the USARTs can be the master, its TX output is connected to 
//  585   the RX input of the other USART. The others are slaves, their respective TX outputs 
//  586   are logically ANDed together and connected to the RX input of the master.
//  587 
//  588   USART multiprocessor communication is possible through the following procedure:
//  589      1. Program the Baud rate, Word length = 9 bits, Stop bits, Parity, Mode transmitter 
//  590         or Mode receiver and hardware flow control values using the USART_Init()
//  591         function.
//  592      2. Configures the USART address using the USART_SetAddress() function.
//  593      3. Configures the wake up method (USART_WakeUp_IdleLine or USART_WakeUp_AddressMark)
//  594         using USART_WakeUpConfig() function only for the slaves.
//  595      4. Enable the USART using the USART_Cmd() function.
//  596      5. Enter the USART slaves in mute mode using USART_ReceiverWakeUpCmd() function.
//  597 
//  598   The USART Slave exit from mute mode when receive the wake up condition.
//  599 
//  600 @endverbatim
//  601   * @{
//  602   */
//  603 
//  604 /**
//  605   * @brief  Sets the address of the USART node.
//  606   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  607   *         UART peripheral.
//  608   * @param  USART_Address: Indicates the address of the USART node.
//  609   * @retval None
//  610   */
//  611 
//  612 
//  613 /**
//  614   * @brief  Determines if the USART is in mute mode or not.
//  615   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  616   *         UART peripheral.
//  617   * @param  NewState: new state of the USART mute mode.
//  618   *          This parameter can be: ENABLE or DISABLE.
//  619   * @retval None
//  620   */
//  621 
//  622 /**
//  623   * @brief  Selects the USART WakeUp method.
//  624   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  625   *         UART peripheral.
//  626   * @param  USART_WakeUp: specifies the USART wakeup method.
//  627   *          This parameter can be one of the following values:
//  628   *            @arg USART_WakeUp_IdleLine: WakeUp by an idle line detection
//  629   *            @arg USART_WakeUp_AddressMark: WakeUp by an address mark
//  630   * @retval None
//  631   */
//  632 
//  633 
//  634 /**
//  635   * @}
//  636   */
//  637 
//  638 /** @defgroup USART_Group4 LIN mode functions
//  639  *  @brief   LIN mode functions 
//  640  *
//  641 @verbatim   
//  642  ===============================================================================
//  643                                 LIN mode functions
//  644  ===============================================================================  
//  645 
//  646   This subsection provides a set of functions allowing to manage the USART LIN 
//  647   Mode communication.
//  648   
//  649   In LIN mode, 8-bit data format with 1 stop bit is required in accordance with 
//  650   the LIN standard.
//  651 
//  652   Only this LIN Feature is supported by the USART IP:
//  653     - LIN Master Synchronous Break send capability and LIN slave break detection
//  654       capability :  13-bit break generation and 10/11 bit break detection
//  655 
//  656 
//  657   USART LIN Master transmitter communication is possible through the following procedure:
//  658      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  659         Mode transmitter or Mode receiver and hardware flow control values using 
//  660         the USART_Init() function.
//  661      2. Enable the USART using the USART_Cmd() function.
//  662      3. Enable the LIN mode using the USART_LINCmd() function.
//  663      4. Send the break character using USART_SendBreak() function.
//  664 
//  665   USART LIN Master receiver communication is possible through the following procedure:
//  666      1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
//  667         Mode transmitter or Mode receiver and hardware flow control values using 
//  668         the USART_Init() function.
//  669      2. Enable the USART using the USART_Cmd() function.
//  670      3. Configures the break detection length using the USART_LINBreakDetectLengthConfig()
//  671         function.
//  672      4. Enable the LIN mode using the USART_LINCmd() function.
//  673 
//  674 
//  675 @note In LIN mode, the following bits must be kept cleared:
//  676         - CLKEN in the USART_CR2 register,
//  677         - STOP[1:0], SCEN, HDSEL and IREN in the USART_CR3 register.
//  678 
//  679 @endverbatim
//  680   * @{
//  681   */
//  682 
//  683 /**
//  684   * @brief  Sets the USART LIN Break detection length.
//  685   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  686   *         UART peripheral.
//  687   * @param  USART_LINBreakDetectLength: specifies the LIN break detection length.
//  688   *          This parameter can be one of the following values:
//  689   *            @arg USART_LINBreakDetectLength_10b: 10-bit break detection
//  690   *            @arg USART_LINBreakDetectLength_11b: 11-bit break detection
//  691   * @retval None
//  692   */
//  693 
//  694 /**
//  695   * @brief  Enables or disables the USART's LIN mode.
//  696   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  697   *         UART peripheral.
//  698   * @param  NewState: new state of the USART LIN mode.
//  699   *          This parameter can be: ENABLE or DISABLE.
//  700   * @retval None
//  701   */
//  702 
//  703 
//  704 /**
//  705   * @brief  Transmits break characters.
//  706   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  707   *         UART peripheral.
//  708   * @retval None
//  709   */
//  710 
//  711 
//  712 /**
//  713   * @}
//  714   */
//  715 
//  716 /** @defgroup USART_Group5 Halfduplex mode function
//  717  *  @brief   Half-duplex mode function 
//  718  *
//  719 @verbatim   
//  720  ===============================================================================
//  721                          Half-duplex mode function
//  722  ===============================================================================  
//  723 
//  724   This subsection provides a set of functions allowing to manage the USART 
//  725   Half-duplex communication.
//  726   
//  727   The USART can be configured to follow a single-wire half-duplex protocol where 
//  728   the TX and RX lines are internally connected.
//  729 
//  730   USART Half duplex communication is possible through the following procedure:
//  731      1. Program the Baud rate, Word length, Stop bits, Parity, Mode transmitter 
//  732         or Mode receiver and hardware flow control values using the USART_Init()
//  733         function.
//  734      2. Configures the USART address using the USART_SetAddress() function.
//  735      3. Enable the USART using the USART_Cmd() function.
//  736      4. Enable the half duplex mode using USART_HalfDuplexCmd() function.
//  737 
//  738 
//  739 @note The RX pin is no longer used
//  740 @note In Half-duplex mode the following bits must be kept cleared:
//  741         - LINEN and CLKEN bits in the USART_CR2 register.
//  742         - SCEN and IREN bits in the USART_CR3 register.
//  743 
//  744 @endverbatim
//  745   * @{
//  746   */
//  747 
//  748 /**
//  749   * @brief  Enables or disables the USART's Half Duplex communication.
//  750   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  751   *         UART peripheral.
//  752   * @param  NewState: new state of the USART Communication.
//  753   *          This parameter can be: ENABLE or DISABLE.
//  754   * @retval None
//  755   */
//  756 
//  757 
//  758 /**
//  759   * @}
//  760   */
//  761 
//  762 
//  763 /** @defgroup USART_Group6 Smartcard mode functions
//  764  *  @brief   Smartcard mode functions 
//  765  *
//  766 @verbatim   
//  767  ===============================================================================
//  768                                Smartcard mode functions
//  769  ===============================================================================  
//  770 
//  771   This subsection provides a set of functions allowing to manage the USART 
//  772   Smartcard communication.
//  773   
//  774   The Smartcard interface is designed to support asynchronous protocol Smartcards as
//  775   defined in the ISO 7816-3 standard.
//  776 
//  777   The USART can provide a clock to the smartcard through the SCLK output.
//  778   In smartcard mode, SCLK is not associated to the communication but is simply derived 
//  779   from the internal peripheral input clock through a 5-bit prescaler.
//  780 
//  781   Smartcard communication is possible through the following procedure:
//  782      1. Configures the Smartcard Prescaler using the USART_SetPrescaler() function.
//  783      2. Configures the Smartcard Guard Time using the USART_SetGuardTime() function.
//  784      3. Program the USART clock using the USART_ClockInit() function as following:
//  785         - USART Clock enabled
//  786         - USART CPOL Low
//  787         - USART CPHA on first edge
//  788         - USART Last Bit Clock Enabled
//  789      4. Program the Smartcard interface using the USART_Init() function as following:
//  790         - Word Length = 9 Bits
//  791         - 1.5 Stop Bit
//  792         - Even parity
//  793         - BaudRate = 12096 baud
//  794         - Hardware flow control disabled (RTS and CTS signals)
//  795         - Tx and Rx enabled
//  796      5. Optionally you can enable the parity error interrupt using the USART_ITConfig()
//  797         function
//  798      6. Enable the USART using the USART_Cmd() function.
//  799      7. Enable the Smartcard NACK using the USART_SmartCardNACKCmd() function.
//  800      8. Enable the Smartcard interface using the USART_SmartCardCmd() function.
//  801 
//  802   Please refer to the ISO 7816-3 specification for more details.
//  803 
//  804 
//  805 @note It is also possible to choose 0.5 stop bit for receiving but it is recommended 
//  806       to use 1.5 stop bits for both transmitting and receiving to avoid switching 
//  807       between the two configurations.
//  808 @note In smartcard mode, the following bits must be kept cleared:
//  809         - LINEN bit in the USART_CR2 register.
//  810         - HDSEL and IREN bits in the USART_CR3 register.
//  811 @note Smartcard mode is available on USART peripherals only (not available on UART4 
//  812       and UART5 peripherals).
//  813 
//  814 @endverbatim
//  815   * @{
//  816   */
//  817 
//  818 /**
//  819   * @brief  Sets the specified USART guard time.
//  820   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  821   *         UART peripheral.
//  822   * @param  USART_GuardTime: specifies the guard time.   
//  823   * @retval None
//  824   */
//  825 
//  826 /**
//  827   * @brief  Enables or disables the USART's Smart Card mode.
//  828   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  829   *         UART peripheral.
//  830   * @param  NewState: new state of the Smart Card mode.
//  831   *          This parameter can be: ENABLE or DISABLE.      
//  832   * @retval None
//  833   */
//  834 
//  835 
//  836 /**
//  837   * @brief  Enables or disables NACK transmission.
//  838   * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
//  839   *         UART peripheral.
//  840   * @param  NewState: new state of the NACK transmission.
//  841   *          This parameter can be: ENABLE or DISABLE.  
//  842   * @retval None
//  843   */
//  844 
//  845 /**
//  846   * @}
//  847   */
//  848 
//  849 /** @defgroup USART_Group7 IrDA mode functions
//  850  *  @brief   IrDA mode functions 
//  851  *
//  852 @verbatim   
//  853  ===============================================================================
//  854                                 IrDA mode functions
//  855  ===============================================================================  
//  856 
//  857   This subsection provides a set of functions allowing to manage the USART 
//  858   IrDA communication.
//  859   
//  860   IrDA is a half duplex communication protocol. If the Transmitter is busy, any data
//  861   on the IrDA receive line will be ignored by the IrDA decoder and if the Receiver 
//  862   is busy, data on the TX from the USART to IrDA will not be encoded by IrDA.
//  863   While receiving data, transmission should be avoided as the data to be transmitted
//  864   could be corrupted.
//  865 
//  866   IrDA communication is possible through the following procedure:
//  867      1. Program the Baud rate, Word length = 8 bits, Stop bits, Parity, Transmitter/Receiver 
//  868         modes and hardware flow control values using the USART_Init() function.
//  869      2. Enable the USART using the USART_Cmd() function.
//  870      3. Configures the IrDA pulse width by configuring the prescaler using  
//  871         the USART_SetPrescaler() function.
//  872      4. Configures the IrDA  USART_IrDAMode_LowPower or USART_IrDAMode_Normal mode
//  873         using the USART_IrDAConfig() function.
//  874      5. Enable the IrDA using the USART_IrDACmd() function.
//  875 
//  876 @note A pulse of width less than two and greater than one PSC period(s) may or may
//  877       not be rejected.
//  878 @note The receiver set up time should be managed by software. The IrDA physical layer
//  879       specification specifies a minimum of 10 ms delay between transmission and 
//  880       reception (IrDA is a half duplex protocol).
//  881 @note In IrDA mode, the following bits must be kept cleared:
//  882         - LINEN, STOP and CLKEN bits in the USART_CR2 register.
//  883         - SCEN and HDSEL bits in the USART_CR3 register.
//  884 
//  885 @endverbatim
//  886   * @{
//  887   */
//  888 
//  889 /**
//  890   * @brief  Configures the USART's IrDA interface.
//  891   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  892   *         UART peripheral.
//  893   * @param  USART_IrDAMode: specifies the IrDA mode.
//  894   *          This parameter can be one of the following values:
//  895   *            @arg USART_IrDAMode_LowPower
//  896   *            @arg USART_IrDAMode_Normal
//  897   * @retval None
//  898   */
//  899 
//  900 /**
//  901   * @brief  Enables or disables the USART's IrDA interface.
//  902   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  903   *         UART peripheral.
//  904   * @param  NewState: new state of the IrDA mode.
//  905   *          This parameter can be: ENABLE or DISABLE.
//  906   * @retval None
//  907   */
//  908 
//  909 
//  910 /**
//  911   * @}
//  912   */
//  913 
//  914 /** @defgroup USART_Group8 DMA transfers management functions
//  915  *  @brief   DMA transfers management functions
//  916  *
//  917 @verbatim   
//  918  ===============================================================================
//  919                       DMA transfers management functions
//  920  ===============================================================================  
//  921 
//  922 @endverbatim
//  923   * @{
//  924   */
//  925   
//  926 /**
//  927   * @brief  Enables or disables the USART's DMA interface.
//  928   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
//  929   *         UART peripheral.
//  930   * @param  USART_DMAReq: specifies the DMA request.
//  931   *          This parameter can be any combination of the following values:
//  932   *            @arg USART_DMAReq_Tx: USART DMA transmit request
//  933   *            @arg USART_DMAReq_Rx: USART DMA receive request
//  934   * @param  NewState: new state of the DMA Request sources.
//  935   *          This parameter can be: ENABLE or DISABLE.   
//  936   * @retval None
//  937   */
//  938 
//  939 /**
//  940   * @}
//  941   */
//  942   
//  943 /** @defgroup USART_Group9 Interrupts and flags management functions
//  944  *  @brief   Interrupts and flags management functions 
//  945  *
//  946 @verbatim   
//  947  ===============================================================================
//  948                    Interrupts and flags management functions
//  949  ===============================================================================  
//  950 
//  951   This subsection provides a set of functions allowing to configure the USART 
//  952   Interrupts sources, DMA channels requests and check or clear the flags or 
//  953   pending bits status.
//  954   The user should identify which mode will be used in his application to manage 
//  955   the communication: Polling mode, Interrupt mode or DMA mode. 
//  956     
//  957   Polling Mode
//  958   =============
//  959   In Polling Mode, the SPI communication can be managed by 10 flags:
//  960      1. USART_FLAG_TXE : to indicate the status of the transmit buffer register
//  961      2. USART_FLAG_RXNE : to indicate the status of the receive buffer register
//  962      3. USART_FLAG_TC : to indicate the status of the transmit operation
//  963      4. USART_FLAG_IDLE : to indicate the status of the Idle Line             
//  964      5. USART_FLAG_CTS : to indicate the status of the nCTS input
//  965      6. USART_FLAG_LBD : to indicate the status of the LIN break detection
//  966      7. USART_FLAG_NE : to indicate if a noise error occur
//  967      8. USART_FLAG_FE : to indicate if a frame error occur
//  968      9. USART_FLAG_PE : to indicate if a parity error occur
//  969      10. USART_FLAG_ORE : to indicate if an Overrun error occur
//  970 
//  971   In this Mode it is advised to use the following functions:
//  972       - FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, uint16_t USART_FLAG);
//  973       - void USART_ClearFlag(USART_TypeDef* USARTx, uint16_t USART_FLAG);
//  974 
//  975   Interrupt Mode
//  976   ===============
//  977   In Interrupt Mode, the USART communication can be managed by 8 interrupt sources
//  978   and 10 pending bits: 
//  979 
//  980   Pending Bits:
//  981   ------------- 
//  982      1. USART_IT_TXE : to indicate the status of the transmit buffer register
//  983      2. USART_IT_RXNE : to indicate the status of the receive buffer register
//  984      3. USART_IT_TC : to indicate the status of the transmit operation
//  985      4. USART_IT_IDLE : to indicate the status of the Idle Line             
//  986      5. USART_IT_CTS : to indicate the status of the nCTS input
//  987      6. USART_IT_LBD : to indicate the status of the LIN break detection
//  988      7. USART_IT_NE : to indicate if a noise error occur
//  989      8. USART_IT_FE : to indicate if a frame error occur
//  990      9. USART_IT_PE : to indicate if a parity error occur
//  991      10. USART_IT_ORE : to indicate if an Overrun error occur
//  992 
//  993   Interrupt Source:
//  994   -----------------
//  995      1. USART_IT_TXE : specifies the interrupt source for the Tx buffer empty 
//  996                        interrupt. 
//  997      2. USART_IT_RXNE : specifies the interrupt source for the Rx buffer not 
//  998                         empty interrupt.
//  999      3. USART_IT_TC : specifies the interrupt source for the Transmit complete 
// 1000                        interrupt. 
// 1001      4. USART_IT_IDLE : specifies the interrupt source for the Idle Line interrupt.             
// 1002      5. USART_IT_CTS : specifies the interrupt source for the CTS interrupt. 
// 1003      6. USART_IT_LBD : specifies the interrupt source for the LIN break detection
// 1004                        interrupt. 
// 1005      7. USART_IT_PE : specifies the interrupt source for the parity error interrupt. 
// 1006      8. USART_IT_ERR :  specifies the interrupt source for the errors interrupt.
// 1007 
// 1008 @note Some parameters are coded in order to use them as interrupt source or as pending bits.
// 1009 
// 1010   In this Mode it is advised to use the following functions:
// 1011      - void USART_ITConfig(USART_TypeDef* USARTx, uint16_t USART_IT, FunctionalState NewState);
// 1012      - ITStatus USART_GetITStatus(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1013      - void USART_ClearITPendingBit(USART_TypeDef* USARTx, uint16_t USART_IT);
// 1014 
// 1015   DMA Mode
// 1016   ========
// 1017   In DMA Mode, the USART communication can be managed by 2 DMA Channel requests:
// 1018      1. USART_DMAReq_Tx: specifies the Tx buffer DMA transfer request
// 1019      2. USART_DMAReq_Rx: specifies the Rx buffer DMA transfer request
// 1020 
// 1021   In this Mode it is advised to use the following function:
// 1022      - void USART_DMACmd(USART_TypeDef* USARTx, uint16_t USART_DMAReq, FunctionalState NewState);
// 1023 
// 1024 @endverbatim
// 1025   * @{
// 1026   */
// 1027 
// 1028 /**
// 1029   * @brief  Enables or disables the specified USART interrupts.
// 1030   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1031   *         UART peripheral.
// 1032   * @param  USART_IT: specifies the USART interrupt sources to be enabled or disabled.
// 1033   *          This parameter can be one of the following values:
// 1034   *            @arg USART_IT_CTS:  CTS change interrupt
// 1035   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1036   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1037   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1038   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1039   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1040   *            @arg USART_IT_PE:   Parity Error interrupt
// 1041   *            @arg USART_IT_ERR:  Error interrupt(Frame error, noise error, overrun error)
// 1042   * @param  NewState: new state of the specified USARTx interrupts.
// 1043   *          This parameter can be: ENABLE or DISABLE.
// 1044   * @retval None
// 1045   */
// 1046 
// 1047 /**
// 1048   * @brief  Checks whether the specified USART flag is set or not.
// 1049   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1050   *         UART peripheral.
// 1051   * @param  USART_FLAG: specifies the flag to check.
// 1052   *          This parameter can be one of the following values:
// 1053   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5)
// 1054   *            @arg USART_FLAG_LBD:  LIN Break detection flag
// 1055   *            @arg USART_FLAG_TXE:  Transmit data register empty flag
// 1056   *            @arg USART_FLAG_TC:   Transmission Complete flag
// 1057   *            @arg USART_FLAG_RXNE: Receive data register not empty flag
// 1058   *            @arg USART_FLAG_IDLE: Idle Line detection flag
// 1059   *            @arg USART_FLAG_ORE:  OverRun Error flag
// 1060   *            @arg USART_FLAG_NE:   Noise Error flag
// 1061   *            @arg USART_FLAG_FE:   Framing Error flag
// 1062   *            @arg USART_FLAG_PE:   Parity Error flag
// 1063   * @retval The new state of USART_FLAG (SET or RESET).
// 1064   */
// 1065 
// 1066 /**
// 1067   * @brief  Clears the USARTx's pending flags.
// 1068   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1069   *         UART peripheral.
// 1070   * @param  USART_FLAG: specifies the flag to clear.
// 1071   *          This parameter can be any combination of the following values:
// 1072   *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5).
// 1073   *            @arg USART_FLAG_LBD:  LIN Break detection flag.
// 1074   *            @arg USART_FLAG_TC:   Transmission Complete flag.
// 1075   *            @arg USART_FLAG_RXNE: Receive data register not empty flag.
// 1076   *   
// 1077   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1078   *          error) and IDLE (Idle line detected) flags are cleared by software 
// 1079   *          sequence: a read operation to USART_SR register (USART_GetFlagStatus()) 
// 1080   *          followed by a read operation to USART_DR register (USART_ReceiveData()).
// 1081   * @note   RXNE flag can be also cleared by a read to the USART_DR register 
// 1082   *          (USART_ReceiveData()).
// 1083   * @note   TC flag can be also cleared by software sequence: a read operation to 
// 1084   *          USART_SR register (USART_GetFlagStatus()) followed by a write operation
// 1085   *          to USART_DR register (USART_SendData()).
// 1086   * @note   TXE flag is cleared only by a write to the USART_DR register 
// 1087   *          (USART_SendData()).
// 1088   *   
// 1089   * @retval None
// 1090   */
// 1091 
// 1092 
// 1093 /**
// 1094   * @brief  Checks whether the specified USART interrupt has occurred or not.
// 1095   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1096   *         UART peripheral.
// 1097   * @param  USART_IT: specifies the USART interrupt source to check.
// 1098   *          This parameter can be one of the following values:
// 1099   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1100   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1101   *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
// 1102   *            @arg USART_IT_TC:   Transmission complete interrupt
// 1103   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
// 1104   *            @arg USART_IT_IDLE: Idle line detection interrupt
// 1105   *            @arg USART_IT_ORE:  OverRun Error interrupt
// 1106   *            @arg USART_IT_NE:   Noise Error interrupt
// 1107   *            @arg USART_IT_FE:   Framing Error interrupt
// 1108   *            @arg USART_IT_PE:   Parity Error interrupt
// 1109   * @retval The new state of USART_IT (SET or RESET).
// 1110   */
// 1111 
// 1112 
// 1113 /**
// 1114   * @brief  Clears the USARTx's interrupt pending bits.
// 1115   * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
// 1116   *         UART peripheral.
// 1117   * @param  USART_IT: specifies the interrupt pending bit to clear.
// 1118   *          This parameter can be one of the following values:
// 1119   *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
// 1120   *            @arg USART_IT_LBD:  LIN Break detection interrupt
// 1121   *            @arg USART_IT_TC:   Transmission complete interrupt. 
// 1122   *            @arg USART_IT_RXNE: Receive Data register not empty interrupt.
// 1123   *
// 1124   * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
// 1125   *          error) and IDLE (Idle line detected) pending bits are cleared by 
// 1126   *          software sequence: a read operation to USART_SR register 
// 1127   *          (USART_GetITStatus()) followed by a read operation to USART_DR register 
// 1128   *          (USART_ReceiveData()).
// 1129   * @note   RXNE pending bit can be also cleared by a read to the USART_DR register 
// 1130   *          (USART_ReceiveData()).
// 1131   * @note   TC pending bit can be also cleared by software sequence: a read 
// 1132   *          operation to USART_SR register (USART_GetITStatus()) followed by a write 
// 1133   *          operation to USART_DR register (USART_SendData()).
// 1134   * @note   TXE pending bit is cleared only by a write to the USART_DR register 
// 1135   *          (USART_SendData()).
// 1136   *  
// 1137   * @retval None
// 1138   */
// 1139 
// 1140 
// 1141 /**
// 1142   * @}
// 1143   */
// 1144 
// 1145 /**
// 1146   * @}
// 1147   */
// 1148 
// 1149 /**
// 1150   * @}
// 1151   */
// 1152 
// 1153 /**
// 1154   * @}
// 1155   */
// 1156 
// 1157 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
//     2 bytes in section .rodata
//   722 bytes in section .text
// 4 148 bytes in section iram
// 
//   722 bytes of CODE  memory
//     2 bytes of CONST memory
// 4 148 bytes of DATA  memory
//
//Errors: none
//Warnings: none
