/**
  ******************************************************************************
  * @file    stm32f2xx_usart.c
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    18-April-2011
  * @brief   This file provides firmware functions to manage the following 
  *          functionalities of the Universal synchronous asynchronous receiver
  *          transmitter (USART):           
  *           - Initialization and Configuration
  *           - Data transfers
  *           - Multi-Processor Communication
  *           - LIN mode
  *           - Half-duplex mode
  *           - Smartcard mode
  *           - IrDA mode
  *           - DMA transfers management
  *           - Interrupts and flags management 
  *           
  *  @verbatim
  *      
  *          ===================================================================
  *                                 How to use this driver
  *          ===================================================================
  *          1. Enable peripheral clock using the follwoing functions
  *             RCC_APB2PeriphClockCmd(RCC_APB2Periph_USARTx, ENABLE) for USART1 and USART6 
  *             RCC_APB1PeriphClockCmd(RCC_APB1Periph_USARTx, ENABLE) for USART2, USART3, UART4 or UART5.
  *
  *          2.  According to the USART mode, enable the GPIO clocks using 
  *              RCC_AHB1PeriphClockCmd() function. (The I/O can be TX, RX, CTS, 
  *              or/and SCLK). 
  *
  *          3. Peripheral's alternate function: 
  *                 - Connect the pin to the desired peripherals' Alternate 
  *                   Function (AF) using GPIO_PinAFConfig() function
  *                 - Configure the desired pin in alternate function by:
  *                   GPIO_InitStruct->GPIO_Mode = GPIO_Mode_AF
  *                 - Select the type, pull-up/pull-down and output speed via 
  *                   GPIO_PuPd, GPIO_OType and GPIO_Speed members
  *                 - Call GPIO_Init() function
  *        
  *          4. Program the Baud Rate, Word Length , Stop Bit, Parity, Hardware 
  *             flow control and Mode(Receiver/Transmitter) using the USART_Init()
  *             function.
  *
  *          5. For synchronous mode, enable the clock and program the polarity,
  *             phase and last bit using the USART_ClockInit() function.
  *
  *          5. Enable the NVIC and the corresponding interrupt using the function 
  *             USART_ITConfig() if you need to use interrupt mode. 
  *
  *          6. When using the DMA mode 
  *                   - Configure the DMA using DMA_Init() function
  *                   - Active the needed channel Request using USART_DMACmd() function
  * 
  *          7. Enable the USART using the USART_Cmd() function.
  * 
  *          8. Enable the DMA using the DMA_Cmd() function, when using DMA mode. 
  *
  *          Refer to Multi-Processor, LIN, half-duplex, Smartcard, IrDA sub-sections
  *          for more details
  *          
  *          In order to reach higher communication baudrates, it is possible to
  *          enable the oversampling by 8 mode using the function USART_OverSampling8Cmd().
  *          This function should be called after enabling the USART clock (RCC_APBxPeriphClockCmd())
  *          and before calling the function USART_Init().
  *          
  *  @endverbatim
  *        
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************  
  */ 

/* Includes ------------------------------------------------------------------*/
#include "stm32f2xx_usart5_1208.h"

/** @addtogroup STM32F2xx_StdPeriph_Driver
  * @{
  */

/** @defgroup USART 
  * @brief USART driver modules
  * @{
  */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/


/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
#if !defined (OS_INCLUDED) 
	INT8U Rx5Buff[Rx5BuffLen];
	INT8U Tx5Buff[Tx5BuffLen];

	INT16U	Rx5RdCnt = 0, Rx5WrCnt = 0;
	INT16U	Tx5RdCnt = 0, Tx5WrCnt = 0;
#else
	INT8U Rx5Buff[Rx5BuffLen] @ "iram";
	INT8U Tx5Buff[Tx5BuffLen] @ "iram";

	INT16U	Rx5RdCnt @ "iram"= 0, Rx5WrCnt @ "iram" = 0;
	INT16U	Tx5RdCnt @ "iram"= 0, Tx5WrCnt @ "iram" = 0;
#endif

#if !defined (OS_INCLUDED) 
__SerStrPtr pUSART5 = {

#else
__SerStrPtr pUSART5 @ "iram" = {
#endif
	InitUSART5,
	USART5CheckByte,
	USART5RxGetByte,
	USART5PutStr,
	USART5Printf,
	USART5PutChar,
	USART5PutToBuffer,
	USART5TxCheckByte,
	USART5BuffClear,
	USART5TxClear
};
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/** @defgroup USART_Private_Functions
  * @{
  */

/** @defgroup USART_Group1 Initialization and Configuration functions
 *  @brief   Initialization and Configuration functions 
 *
@verbatim   
 ===============================================================================
                  Initialization and Configuration functions
 ===============================================================================  

  This subsection provides a set of functions allowing to initialize the USART 
  in asynchronous and in synchronous modes.
   - For the asynchronous mode only these parameters can be configured: 
        - Baud Rate
        - Word Length 
        - Stop Bit
        - Parity: If the parity is enabled, then the MSB bit of the data written
          in the data register is transmitted but is changed by the parity bit.
          Depending on the frame length defined by the M bit (8-bits or 9-bits),
          the possible USART frame formats are as listed in the following table:
   +-------------------------------------------------------------+     
   |   M bit |  PCE bit  |            USART frame                |
   |---------------------|---------------------------------------|             
   |    0    |    0      |    | SB | 8 bit data | STB |          |
   |---------|-----------|---------------------------------------|  
   |    0    |    1      |    | SB | 7 bit data | PB | STB |     |
   |---------|-----------|---------------------------------------|  
   |    1    |    0      |    | SB | 9 bit data | STB |          |
   |---------|-----------|---------------------------------------|  
   |    1    |    1      |    | SB | 8 bit data | PB | STB |     |
   +-------------------------------------------------------------+            
        - Hardware flow control
        - Receiver/transmitter modes

  The USART_Init() function follows the USART  asynchronous configuration procedure
  (details for the procedure are available in reference manual (RM0033)).

  - For the synchronous mode in addition to the asynchronous mode parameters these 
    parameters should be also configured:
        - USART Clock Enabled
        - USART polarity
        - USART phase
        - USART LastBit
  
  These parameters can be configured using the USART_ClockInit() function.

@endverbatim
  * @{
  */
  
/**
  * @brief  Deinitializes the USARTx peripheral registers to their default reset values.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @retval None
  */
void InitUSART5(INT32U nBps, INT32U nLCR)
{
	USART_InitTypeDef USART_InitStructure;

///
// PORT INIT
	RCC->__B.AHB1ENR.IOPCEN = ENABLE;
	RCC->__B.AHB1ENR.IOPDEN = ENABLE;

	RCC->__B.APB1ENR.UART5EN = ENABLE;
	
	__PC12_U5_TX(); 			// USART5_TX
	__PD2_U5_RX();				// USART5_RX

////////////////////////////////////////////////////////////////////////////////
	USART_InitStructure.USART_BaudRate = nBps;

	if( ((nLCR >> 4) & 0x01) ==  (_DATA8BIT >> 4)) {
			USART_InitStructure.USART_WordLength = USART_WordLength_8b;
	}
	else	USART_InitStructure.USART_WordLength = USART_WordLength_9b;

////////////////////////////////////////////////////////////////////////////////
	if( ((nLCR >> 2) & 0x02) ==  (_05STOP >> 2)) {
		USART_InitStructure.USART_StopBits = USART_StopBits_0_5;
	}
	else if( ((nLCR >> 2) & 0x02) ==  (_1_STOP >> 2)) {
			USART_InitStructure.USART_StopBits = USART_StopBits_1;
	}
	else if( ((nLCR >> 2) & 0x02) ==  (_2_STOP >> 2)) {
			USART_InitStructure.USART_StopBits = USART_StopBits_2;
	}
	else	USART_InitStructure.USART_StopBits = USART_StopBits_1_5;
	
////////////////////////////////////////////////////////////////////////////////
	
	if(((nLCR >> 0) & 0x03) == (_NONPARITY >> 0)){
		USART_InitStructure.USART_Parity = USART_Parity_No;
	}
	else if(((nLCR >> 0) & 0x03) == (_ODDPARITY >> 0)){
		USART_InitStructure.USART_Parity = USART_Parity_Odd;
	}
	else{
		USART_InitStructure.USART_Parity = USART_Parity_Even;
	}
	
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;

	/* USART configuration */
	USART_Init(UART5, &USART_InitStructure);

#if defined (OS_INCLUDED) 
	pUSART5.sem = OSSemCreate(1);
#endif
	/* Enable USART */
	USART_Cmd(UART5, ENABLE);

	USART_ITConfig(UART5, USART_IT_RXNE, ENABLE);
	NVIC_Init(UART5_IRQn, ENABLE); 

	USART5Printf("\n");	
}

/*******************************************************************************
  * @brief  Interrupt handler USART5 global interrupt request
  * @param  None 
  * @retval None
  *****************************************************************************/
void USART5_IRQIntHandler(void)
{

	INT16U tmp = UART5->SR;

#ifdef OS_INCLUDED
	INT32U cpu_sr;
	CPU_CRITICAL_ENTER();                                       // Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	CPU_CRITICAL_EXIT();
#endif /* OS_INCLUDED */
	// Rx Data Received
	if(tmp & ( 1 << __RXNE))
	{
		Rx5Buff[Rx5WrCnt%Rx5BuffLen] = UART5->DR;		// When the receive register is read, the RDR bit is automatically cleared.
		if(++Rx5WrCnt >= Rx5BuffLen) Rx5WrCnt = 0;
	}
	else if(tmp & ( 1 << __TXE))
	{
		if(Tx5RdCnt != Tx5WrCnt)
		{
			UART5->DR = Tx5Buff[Tx5RdCnt%Tx5BuffLen];
			if(++Tx5RdCnt >= Tx5BuffLen ) Tx5RdCnt = 0;
		}
		else UART5->__B.CR1.TXEIE = DISABLE;
	}
	else // error, dummy read
	{
		tmp =  UART5->DR;
	}

#ifdef OS_INCLUDED
	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
#endif /* OS_INCLUDED */

}

unsigned char USART5PutToBuffer(unsigned char Data)
{
#ifdef OS_INCLUDED
	INT8U err;
	//////////////////////////////////////////////////

	OSSemPend(pUSART5.sem, 0, &err);
#endif /* OS_INCLUDED */
	//////////////////////////////////////////////////
	Tx5Buff[Tx5WrCnt%Tx5BuffLen] = Data;
	if(++Tx5WrCnt >= Tx5BuffLen) Tx5WrCnt = 0;
	
	UART5->__B.CR1.TXEIE = ENABLE; 		
	///////////////////////////////////////////////////
#ifdef OS_INCLUDED
	OSSemPost(pUSART5.sem);
#endif /* OS_INCLUDED */

	return 0;
}



//Not using interrupt
unsigned char USART5PutChar(unsigned char Data)
{
	#ifdef OS_INCLUDED
		INT8U err;
		//////////////////////////////////////////////////
	
		OSSemPend(pUSART5.sem, 0, &err);
	#endif /* OS_INCLUDED */
		UART5->__B.DR.DR = Data;
		while(!UART5->__B.SR.TXE);
	#ifdef OS_INCLUDED
		OSSemPost(pUSART5.sem);
	#endif /* OS_INCLUDED */
	return Data;
}

unsigned long int USART5Printf( const char *format, ...)
{
	unsigned long int i, cnt;
	char buf[128];
	va_list argptr;

	va_start(argptr, format);
	cnt = vsprintf(buf, format, argptr);
	va_end( argptr );

	for(i = 0;;i++)
	{
		if(buf[i] == 0) break;
		if(buf[i] == '\n') USART5PutToBuffer('\r');
		USART5PutToBuffer(buf[i]);
	}
	while(!USART5TxCheckByte())
	{
#ifdef OS_INCLUDED
	OSTimeDly(1);
#endif /* OS_INCLUDED */
	}
	return cnt;
}

//#define OS_INCLUDED

void USART5PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{
	u32 i = 0;

	USART5BuffClear();
	
#ifdef OS_INCLUDED
	INT8U err;
	OSSemPend(pUSART5.sem, 0, &err);
#endif /* OS_INCLUDED */


	for(i = 0; i < Length; i++)
	{
		Tx5Buff[Tx5WrCnt++] = Str[i];
		if(Tx5WrCnt >= Tx5BuffLen) Tx5WrCnt = 0;
	}

	if(iEn)
	{
		UART5->__B.CR1.TXEIE = ENABLE;
	}	
#ifdef OS_INCLUDED
		OSSemPost(pUSART5.sem);
#endif /* OS_INCLUDED */
}

signed short int USART5RxGetByte(void)
{
	s16 RetVal = 0;

#ifndef OS_INCLUDED
	while(Rx5RdCnt == Rx5WrCnt);
#else
	if(Rx5RdCnt == Rx5WrCnt) return -1;
#endif

	RetVal = Rx5Buff[Rx5RdCnt%Rx5BuffLen];
	if(++Rx5RdCnt >= Rx5BuffLen) Rx5RdCnt = 0;

	return (RetVal & 0xff);
}

unsigned char USART5CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	u32 i = 0, j = 0;
	u8 RetVal = TRUE;

	*Recv = 0;
	i = (u32) Rx5RdCnt;
	j = (u32) Rx5WrCnt;

	if(i == j) RetVal = FALSE;
	else if(i < j)
	{
		*Recv = j - i;
		i = i + ByteCnt;
		if(i > j) RetVal = FALSE;
	}
	else if(i > j)
	{
		*Recv = (Rx5BuffLen +j) - i;
		i = i + ByteCnt;
		j = j + Rx5BuffLen;
		if(i > j) RetVal = FALSE; 
	}
	return (RetVal);
}

void USART5BuffClear(void)
{
	Rx5RdCnt = 0;
	Rx5WrCnt = 0;
	Tx5RdCnt = 0;
	Tx5WrCnt = 0;
}

void USART5TxClear(void)
{
	Tx5RdCnt = 0;
	Tx5WrCnt = 0;
}

/*******************************************************************************
  * @brief  if the bytes have been transmitted, retrun true or not
  * @param  None
  * @retval TRUE/FALSE
  ******************************************************************************/

signed short int USART5TxCheckByte(void)
{
	if(Tx5RdCnt == Tx5WrCnt) return TRUE;
	else return FALSE;
}




/**
  * @brief  Initializes the USARTx peripheral Clock according to the 
  *         specified parameters in the USART_ClockInitStruct .
  * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART peripheral.
  * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure that
  *         contains the configuration information for the specified  USART peripheral.
  * @note   The Smart Card and Synchronous modes are not available for UART4 and UART5.    
  * @retval None
  */

/**
  * @brief  Fills each USART_ClockInitStruct member with its default value.
  * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef structure
  *         which will be initialized.
  * @retval None
  */


/**
  * @brief  Enables or disables the specified USART peripheral.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the USARTx peripheral.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */


/**
  * @brief  Sets the system clock prescaler.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_Prescaler: specifies the prescaler clock. 
  * @note   The function is used for IrDA mode with UART4 and UART5.   
  * @retval None
  */

/**
  * @brief  Enables or disables the USART's 8x oversampling mode.
  * @note   This function has to be called before calling USART_Init() function
  *         in order to have correct baudrate Divider value.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the USART 8x oversampling mode.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
  

/**
  * @brief  Enables or disables the USART's one bit sampling method.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the USART one bit sampling method.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */

/**
  * @}
  */

/** @defgroup USART_Group2 Data transfers functions
 *  @brief   Data transfers functions 
 *
@verbatim   
 ===============================================================================
                            Data transfers functions
 ===============================================================================  

  This subsection provides a set of functions allowing to manage the USART data 
  transfers.
  
  During an USART reception, data shifts in least significant bit first through 
  the RX pin. In this mode, the USART_DR register consists of a buffer (RDR) 
  between the internal bus and the received shift register.

  When a transmission is taking place, a write instruction to the USART_DR register 
  stores the data in the TDR register and which is copied in the shift register 
  at the end of the current transmission.

  The read access of the USART_DR register can be done using the USART_ReceiveData()
  function and returns the RDR buffered value. Whereas a write access to the USART_DR 
  can be done using USART_SendData() function and stores the written data into 
  TDR buffer.

@endverbatim
  * @{
  */

/**
  * @brief  Transmits single data through the USARTx peripheral.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  Data: the data to transmit.
  * @retval None
  */


/**
  * @brief  Returns the most recent received data by the USARTx peripheral.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @retval The received data.
  */

/**
  * @}
  */

/** @defgroup USART_Group3 MultiProcessor Communication functions
 *  @brief   Multi-Processor Communication functions 
 *
@verbatim   
 ===============================================================================
                    Multi-Processor Communication functions
 ===============================================================================  

  This subsection provides a set of functions allowing to manage the USART 
  multiprocessor communication.
  
  For instance one of the USARTs can be the master, its TX output is connected to 
  the RX input of the other USART. The others are slaves, their respective TX outputs 
  are logically ANDed together and connected to the RX input of the master.

  USART multiprocessor communication is possible through the following procedure:
     1. Program the Baud rate, Word length = 9 bits, Stop bits, Parity, Mode transmitter 
        or Mode receiver and hardware flow control values using the USART_Init()
        function.
     2. Configures the USART address using the USART_SetAddress() function.
     3. Configures the wake up method (USART_WakeUp_IdleLine or USART_WakeUp_AddressMark)
        using USART_WakeUpConfig() function only for the slaves.
     4. Enable the USART using the USART_Cmd() function.
     5. Enter the USART slaves in mute mode using USART_ReceiverWakeUpCmd() function.

  The USART Slave exit from mute mode when receive the wake up condition.

@endverbatim
  * @{
  */

/**
  * @brief  Sets the address of the USART node.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_Address: Indicates the address of the USART node.
  * @retval None
  */


/**
  * @brief  Determines if the USART is in mute mode or not.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the USART mute mode.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */

/**
  * @brief  Selects the USART WakeUp method.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_WakeUp: specifies the USART wakeup method.
  *          This parameter can be one of the following values:
  *            @arg USART_WakeUp_IdleLine: WakeUp by an idle line detection
  *            @arg USART_WakeUp_AddressMark: WakeUp by an address mark
  * @retval None
  */


/**
  * @}
  */

/** @defgroup USART_Group4 LIN mode functions
 *  @brief   LIN mode functions 
 *
@verbatim   
 ===============================================================================
                                LIN mode functions
 ===============================================================================  

  This subsection provides a set of functions allowing to manage the USART LIN 
  Mode communication.
  
  In LIN mode, 8-bit data format with 1 stop bit is required in accordance with 
  the LIN standard.

  Only this LIN Feature is supported by the USART IP:
    - LIN Master Synchronous Break send capability and LIN slave break detection
      capability :  13-bit break generation and 10/11 bit break detection


  USART LIN Master transmitter communication is possible through the following procedure:
     1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
        Mode transmitter or Mode receiver and hardware flow control values using 
        the USART_Init() function.
     2. Enable the USART using the USART_Cmd() function.
     3. Enable the LIN mode using the USART_LINCmd() function.
     4. Send the break character using USART_SendBreak() function.

  USART LIN Master receiver communication is possible through the following procedure:
     1. Program the Baud rate, Word length = 8bits, Stop bits = 1bit, Parity, 
        Mode transmitter or Mode receiver and hardware flow control values using 
        the USART_Init() function.
     2. Enable the USART using the USART_Cmd() function.
     3. Configures the break detection length using the USART_LINBreakDetectLengthConfig()
        function.
     4. Enable the LIN mode using the USART_LINCmd() function.


@note In LIN mode, the following bits must be kept cleared:
        - CLKEN in the USART_CR2 register,
        - STOP[1:0], SCEN, HDSEL and IREN in the USART_CR3 register.

@endverbatim
  * @{
  */

/**
  * @brief  Sets the USART LIN Break detection length.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_LINBreakDetectLength: specifies the LIN break detection length.
  *          This parameter can be one of the following values:
  *            @arg USART_LINBreakDetectLength_10b: 10-bit break detection
  *            @arg USART_LINBreakDetectLength_11b: 11-bit break detection
  * @retval None
  */

/**
  * @brief  Enables or disables the USART's LIN mode.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the USART LIN mode.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */


/**
  * @brief  Transmits break characters.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @retval None
  */


/**
  * @}
  */

/** @defgroup USART_Group5 Halfduplex mode function
 *  @brief   Half-duplex mode function 
 *
@verbatim   
 ===============================================================================
                         Half-duplex mode function
 ===============================================================================  

  This subsection provides a set of functions allowing to manage the USART 
  Half-duplex communication.
  
  The USART can be configured to follow a single-wire half-duplex protocol where 
  the TX and RX lines are internally connected.

  USART Half duplex communication is possible through the following procedure:
     1. Program the Baud rate, Word length, Stop bits, Parity, Mode transmitter 
        or Mode receiver and hardware flow control values using the USART_Init()
        function.
     2. Configures the USART address using the USART_SetAddress() function.
     3. Enable the USART using the USART_Cmd() function.
     4. Enable the half duplex mode using USART_HalfDuplexCmd() function.


@note The RX pin is no longer used
@note In Half-duplex mode the following bits must be kept cleared:
        - LINEN and CLKEN bits in the USART_CR2 register.
        - SCEN and IREN bits in the USART_CR3 register.

@endverbatim
  * @{
  */

/**
  * @brief  Enables or disables the USART's Half Duplex communication.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the USART Communication.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */


/**
  * @}
  */


/** @defgroup USART_Group6 Smartcard mode functions
 *  @brief   Smartcard mode functions 
 *
@verbatim   
 ===============================================================================
                               Smartcard mode functions
 ===============================================================================  

  This subsection provides a set of functions allowing to manage the USART 
  Smartcard communication.
  
  The Smartcard interface is designed to support asynchronous protocol Smartcards as
  defined in the ISO 7816-3 standard.

  The USART can provide a clock to the smartcard through the SCLK output.
  In smartcard mode, SCLK is not associated to the communication but is simply derived 
  from the internal peripheral input clock through a 5-bit prescaler.

  Smartcard communication is possible through the following procedure:
     1. Configures the Smartcard Prescaler using the USART_SetPrescaler() function.
     2. Configures the Smartcard Guard Time using the USART_SetGuardTime() function.
     3. Program the USART clock using the USART_ClockInit() function as following:
        - USART Clock enabled
        - USART CPOL Low
        - USART CPHA on first edge
        - USART Last Bit Clock Enabled
     4. Program the Smartcard interface using the USART_Init() function as following:
        - Word Length = 9 Bits
        - 1.5 Stop Bit
        - Even parity
        - BaudRate = 12096 baud
        - Hardware flow control disabled (RTS and CTS signals)
        - Tx and Rx enabled
     5. Optionally you can enable the parity error interrupt using the USART_ITConfig()
        function
     6. Enable the USART using the USART_Cmd() function.
     7. Enable the Smartcard NACK using the USART_SmartCardNACKCmd() function.
     8. Enable the Smartcard interface using the USART_SmartCardCmd() function.

  Please refer to the ISO 7816-3 specification for more details.


@note It is also possible to choose 0.5 stop bit for receiving but it is recommended 
      to use 1.5 stop bits for both transmitting and receiving to avoid switching 
      between the two configurations.
@note In smartcard mode, the following bits must be kept cleared:
        - LINEN bit in the USART_CR2 register.
        - HDSEL and IREN bits in the USART_CR3 register.
@note Smartcard mode is available on USART peripherals only (not available on UART4 
      and UART5 peripherals).

@endverbatim
  * @{
  */

/**
  * @brief  Sets the specified USART guard time.
  * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_GuardTime: specifies the guard time.   
  * @retval None
  */

/**
  * @brief  Enables or disables the USART's Smart Card mode.
  * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the Smart Card mode.
  *          This parameter can be: ENABLE or DISABLE.      
  * @retval None
  */


/**
  * @brief  Enables or disables NACK transmission.
  * @param  USARTx: where x can be 1, 2, 3 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the NACK transmission.
  *          This parameter can be: ENABLE or DISABLE.  
  * @retval None
  */

/**
  * @}
  */

/** @defgroup USART_Group7 IrDA mode functions
 *  @brief   IrDA mode functions 
 *
@verbatim   
 ===============================================================================
                                IrDA mode functions
 ===============================================================================  

  This subsection provides a set of functions allowing to manage the USART 
  IrDA communication.
  
  IrDA is a half duplex communication protocol. If the Transmitter is busy, any data
  on the IrDA receive line will be ignored by the IrDA decoder and if the Receiver 
  is busy, data on the TX from the USART to IrDA will not be encoded by IrDA.
  While receiving data, transmission should be avoided as the data to be transmitted
  could be corrupted.

  IrDA communication is possible through the following procedure:
     1. Program the Baud rate, Word length = 8 bits, Stop bits, Parity, Transmitter/Receiver 
        modes and hardware flow control values using the USART_Init() function.
     2. Enable the USART using the USART_Cmd() function.
     3. Configures the IrDA pulse width by configuring the prescaler using  
        the USART_SetPrescaler() function.
     4. Configures the IrDA  USART_IrDAMode_LowPower or USART_IrDAMode_Normal mode
        using the USART_IrDAConfig() function.
     5. Enable the IrDA using the USART_IrDACmd() function.

@note A pulse of width less than two and greater than one PSC period(s) may or may
      not be rejected.
@note The receiver set up time should be managed by software. The IrDA physical layer
      specification specifies a minimum of 10 ms delay between transmission and 
      reception (IrDA is a half duplex protocol).
@note In IrDA mode, the following bits must be kept cleared:
        - LINEN, STOP and CLKEN bits in the USART_CR2 register.
        - SCEN and HDSEL bits in the USART_CR3 register.

@endverbatim
  * @{
  */

/**
  * @brief  Configures the USART's IrDA interface.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_IrDAMode: specifies the IrDA mode.
  *          This parameter can be one of the following values:
  *            @arg USART_IrDAMode_LowPower
  *            @arg USART_IrDAMode_Normal
  * @retval None
  */

/**
  * @brief  Enables or disables the USART's IrDA interface.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  NewState: new state of the IrDA mode.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */


/**
  * @}
  */

/** @defgroup USART_Group8 DMA transfers management functions
 *  @brief   DMA transfers management functions
 *
@verbatim   
 ===============================================================================
                      DMA transfers management functions
 ===============================================================================  

@endverbatim
  * @{
  */
  
/**
  * @brief  Enables or disables the USART's DMA interface.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_DMAReq: specifies the DMA request.
  *          This parameter can be any combination of the following values:
  *            @arg USART_DMAReq_Tx: USART DMA transmit request
  *            @arg USART_DMAReq_Rx: USART DMA receive request
  * @param  NewState: new state of the DMA Request sources.
  *          This parameter can be: ENABLE or DISABLE.   
  * @retval None
  */

/**
  * @}
  */
  
/** @defgroup USART_Group9 Interrupts and flags management functions
 *  @brief   Interrupts and flags management functions 
 *
@verbatim   
 ===============================================================================
                   Interrupts and flags management functions
 ===============================================================================  

  This subsection provides a set of functions allowing to configure the USART 
  Interrupts sources, DMA channels requests and check or clear the flags or 
  pending bits status.
  The user should identify which mode will be used in his application to manage 
  the communication: Polling mode, Interrupt mode or DMA mode. 
    
  Polling Mode
  =============
  In Polling Mode, the SPI communication can be managed by 10 flags:
     1. USART_FLAG_TXE : to indicate the status of the transmit buffer register
     2. USART_FLAG_RXNE : to indicate the status of the receive buffer register
     3. USART_FLAG_TC : to indicate the status of the transmit operation
     4. USART_FLAG_IDLE : to indicate the status of the Idle Line             
     5. USART_FLAG_CTS : to indicate the status of the nCTS input
     6. USART_FLAG_LBD : to indicate the status of the LIN break detection
     7. USART_FLAG_NE : to indicate if a noise error occur
     8. USART_FLAG_FE : to indicate if a frame error occur
     9. USART_FLAG_PE : to indicate if a parity error occur
     10. USART_FLAG_ORE : to indicate if an Overrun error occur

  In this Mode it is advised to use the following functions:
      - FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, uint16_t USART_FLAG);
      - void USART_ClearFlag(USART_TypeDef* USARTx, uint16_t USART_FLAG);

  Interrupt Mode
  ===============
  In Interrupt Mode, the USART communication can be managed by 8 interrupt sources
  and 10 pending bits: 

  Pending Bits:
  ------------- 
     1. USART_IT_TXE : to indicate the status of the transmit buffer register
     2. USART_IT_RXNE : to indicate the status of the receive buffer register
     3. USART_IT_TC : to indicate the status of the transmit operation
     4. USART_IT_IDLE : to indicate the status of the Idle Line             
     5. USART_IT_CTS : to indicate the status of the nCTS input
     6. USART_IT_LBD : to indicate the status of the LIN break detection
     7. USART_IT_NE : to indicate if a noise error occur
     8. USART_IT_FE : to indicate if a frame error occur
     9. USART_IT_PE : to indicate if a parity error occur
     10. USART_IT_ORE : to indicate if an Overrun error occur

  Interrupt Source:
  -----------------
     1. USART_IT_TXE : specifies the interrupt source for the Tx buffer empty 
                       interrupt. 
     2. USART_IT_RXNE : specifies the interrupt source for the Rx buffer not 
                        empty interrupt.
     3. USART_IT_TC : specifies the interrupt source for the Transmit complete 
                       interrupt. 
     4. USART_IT_IDLE : specifies the interrupt source for the Idle Line interrupt.             
     5. USART_IT_CTS : specifies the interrupt source for the CTS interrupt. 
     6. USART_IT_LBD : specifies the interrupt source for the LIN break detection
                       interrupt. 
     7. USART_IT_PE : specifies the interrupt source for the parity error interrupt. 
     8. USART_IT_ERR :  specifies the interrupt source for the errors interrupt.

@note Some parameters are coded in order to use them as interrupt source or as pending bits.

  In this Mode it is advised to use the following functions:
     - void USART_ITConfig(USART_TypeDef* USARTx, uint16_t USART_IT, FunctionalState NewState);
     - ITStatus USART_GetITStatus(USART_TypeDef* USARTx, uint16_t USART_IT);
     - void USART_ClearITPendingBit(USART_TypeDef* USARTx, uint16_t USART_IT);

  DMA Mode
  ========
  In DMA Mode, the USART communication can be managed by 2 DMA Channel requests:
     1. USART_DMAReq_Tx: specifies the Tx buffer DMA transfer request
     2. USART_DMAReq_Rx: specifies the Rx buffer DMA transfer request

  In this Mode it is advised to use the following function:
     - void USART_DMACmd(USART_TypeDef* USARTx, uint16_t USART_DMAReq, FunctionalState NewState);

@endverbatim
  * @{
  */

/**
  * @brief  Enables or disables the specified USART interrupts.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_IT: specifies the USART interrupt sources to be enabled or disabled.
  *          This parameter can be one of the following values:
  *            @arg USART_IT_CTS:  CTS change interrupt
  *            @arg USART_IT_LBD:  LIN Break detection interrupt
  *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
  *            @arg USART_IT_TC:   Transmission complete interrupt
  *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
  *            @arg USART_IT_IDLE: Idle line detection interrupt
  *            @arg USART_IT_PE:   Parity Error interrupt
  *            @arg USART_IT_ERR:  Error interrupt(Frame error, noise error, overrun error)
  * @param  NewState: new state of the specified USARTx interrupts.
  *          This parameter can be: ENABLE or DISABLE.
  * @retval None
  */

/**
  * @brief  Checks whether the specified USART flag is set or not.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_FLAG: specifies the flag to check.
  *          This parameter can be one of the following values:
  *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5)
  *            @arg USART_FLAG_LBD:  LIN Break detection flag
  *            @arg USART_FLAG_TXE:  Transmit data register empty flag
  *            @arg USART_FLAG_TC:   Transmission Complete flag
  *            @arg USART_FLAG_RXNE: Receive data register not empty flag
  *            @arg USART_FLAG_IDLE: Idle Line detection flag
  *            @arg USART_FLAG_ORE:  OverRun Error flag
  *            @arg USART_FLAG_NE:   Noise Error flag
  *            @arg USART_FLAG_FE:   Framing Error flag
  *            @arg USART_FLAG_PE:   Parity Error flag
  * @retval The new state of USART_FLAG (SET or RESET).
  */

/**
  * @brief  Clears the USARTx's pending flags.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_FLAG: specifies the flag to clear.
  *          This parameter can be any combination of the following values:
  *            @arg USART_FLAG_CTS:  CTS Change flag (not available for UART4 and UART5).
  *            @arg USART_FLAG_LBD:  LIN Break detection flag.
  *            @arg USART_FLAG_TC:   Transmission Complete flag.
  *            @arg USART_FLAG_RXNE: Receive data register not empty flag.
  *   
  * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
  *          error) and IDLE (Idle line detected) flags are cleared by software 
  *          sequence: a read operation to USART_SR register (USART_GetFlagStatus()) 
  *          followed by a read operation to USART_DR register (USART_ReceiveData()).
  * @note   RXNE flag can be also cleared by a read to the USART_DR register 
  *          (USART_ReceiveData()).
  * @note   TC flag can be also cleared by software sequence: a read operation to 
  *          USART_SR register (USART_GetFlagStatus()) followed by a write operation
  *          to USART_DR register (USART_SendData()).
  * @note   TXE flag is cleared only by a write to the USART_DR register 
  *          (USART_SendData()).
  *   
  * @retval None
  */


/**
  * @brief  Checks whether the specified USART interrupt has occurred or not.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_IT: specifies the USART interrupt source to check.
  *          This parameter can be one of the following values:
  *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
  *            @arg USART_IT_LBD:  LIN Break detection interrupt
  *            @arg USART_IT_TXE:  Transmit Data Register empty interrupt
  *            @arg USART_IT_TC:   Transmission complete interrupt
  *            @arg USART_IT_RXNE: Receive Data register not empty interrupt
  *            @arg USART_IT_IDLE: Idle line detection interrupt
  *            @arg USART_IT_ORE:  OverRun Error interrupt
  *            @arg USART_IT_NE:   Noise Error interrupt
  *            @arg USART_IT_FE:   Framing Error interrupt
  *            @arg USART_IT_PE:   Parity Error interrupt
  * @retval The new state of USART_IT (SET or RESET).
  */


/**
  * @brief  Clears the USARTx's interrupt pending bits.
  * @param  USARTx: where x can be 1, 2, 3, 4, 5 or 6 to select the USART or 
  *         UART peripheral.
  * @param  USART_IT: specifies the interrupt pending bit to clear.
  *          This parameter can be one of the following values:
  *            @arg USART_IT_CTS:  CTS change interrupt (not available for UART4 and UART5)
  *            @arg USART_IT_LBD:  LIN Break detection interrupt
  *            @arg USART_IT_TC:   Transmission complete interrupt. 
  *            @arg USART_IT_RXNE: Receive Data register not empty interrupt.
  *
  * @note   PE (Parity error), FE (Framing error), NE (Noise error), ORE (OverRun 
  *          error) and IDLE (Idle line detected) pending bits are cleared by 
  *          software sequence: a read operation to USART_SR register 
  *          (USART_GetITStatus()) followed by a read operation to USART_DR register 
  *          (USART_ReceiveData()).
  * @note   RXNE pending bit can be also cleared by a read to the USART_DR register 
  *          (USART_ReceiveData()).
  * @note   TC pending bit can be also cleared by software sequence: a read 
  *          operation to USART_SR register (USART_GetITStatus()) followed by a write 
  *          operation to USART_DR register (USART_SendData()).
  * @note   TXE pending bit is cleared only by a write to the USART_DR register 
  *          (USART_SendData()).
  *  
  * @retval None
  */


/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
