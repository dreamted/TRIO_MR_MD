/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_usart.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the functions prototypes for the
*                      USART firmware library.
********************************************************************************
* History:
* 05/21/2007: V0.3
* 04/02/2007: V0.2
* 02/05/2007: V0.1
* 09/29/2006: V0.01
********************************************************************************
* THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F10x_USART_H
#define __STM32F10x_USART_H

/* Includes ------------------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
// ----------------- Universal Synchronous Asynchronous Receiver Transmitter----
typedef struct
{
	union{
		vu32 Data;
		struct	{
			vu32 PE		:1;	//Parity Error
			vu32 FE		:1;	//Framing Error
			vu32 NE		:1;	//Noise Error Flag
			vu32 ORE	:1;	//OverRun Error
			vu32 IDLE	:1; //IDLE line detected
			vu32 RXNE	:1; //Read Data Register Not Empty
			vu32 TC		:1; //Transmission Complete
			vu32 TXE	:1; //Transmit Data Register Empty
			vu32 LBD	:1; //LIN Break Detecting Flag
			vu32 CTS	:1; //CTS Flag
		} Bit;
	} SR;	//Status register
	
	union{
		vu32 Data;
		struct	{
			vu32 DR		:9;	//Data value
		} Bit;
	} DR;	//Data register

	union{
		vu32 Data;
		struct	{
			vu32 DIV_Fracton	:4;		//fraction of DIV
			vu32 DIV_Mantissa	:12;	//mantissa of DIV
		} Bit;
	} BRR;	//Baud rate register

	union{
		vu32 Data;
		struct	{
			vu32 SBK		:1;	//Send Break
			vu32 RWU		:1;	//Receiver Wake-Up
			vu32 RE			:1;	//Receiver Enable
			vu32 TE			:1;	//Transmitter Enable
			vu32 IDLEIE		:1; //IDLE Interrupt Enable
			vu32 RXNEIE		:1;	//RXNE Interrupt Enable
			vu32 TCIE		:1; //Transmission Complete Interrupt Enable
			vu32 TXEIE		:1;	//TXE Interrupt Enable
			vu32 PEIE		:1;	//PE Interrupt Enable
			vu32 PS			:1; //Parity Selection
			vu32 PCE		:1;	//Parity Control Enable
			vu32 WAKE		:1;	//Wake-up method
			vu32 M			:1;	//word length
			vu32 UE			:1;	//USART Enable
		} Bit;
	} CR1; //Control register1

	union{
		vu32 Data;
		struct	{
			vu32 ADD		:4;	//Address of the USART node
			vu32 Reserved1	:1;	
			vu32 LBDL		:1;	//LIN Break Detection Length
			vu32 LBDIE		:1;	//LIN Break Detection Interrupt Enalbe
			vu32 Reserved2	:1;	
			vu32 LBCL		:1;	//Last Bit Clock pulse
			vu32 CPHA		:1;	//Clock Phase
			vu32 CPOL		:1;	//Clock Polarity
			vu32 CLKEN		:1;	//Clock Enable
			vu32 STOP		:2;	//STOP bits
			vu32 LINEN		:1;	//LIN mode enable	
		} Bit;
	} CR2;	//Control register2

	union{
		vu32 Data;
		struct	{
			vu32 EIE		:1;	//Error Interrupt Enalbe
			vu32 IREN		:1;	//IrDA mode Enalbe
			vu32 IRLP		:1;	//IrDA Low-Power
			vu32 HDSEL		:1;	//Half-Duplex Selection
			vu32 NACK		:1;	//Smartcard NACK enalbe
			vu32 SCEN		:1;	//Smartcard mode enalbe
			vu32 DMAR		:1;	//DMA Enable Receiver
			vu32 DMAT		:1;	//DMA Enalbe Transmitter
			vu32 RTSE		:1;	//RTS Enalbe
			vu32 CTSE		:1;	//CTS Enalbe
			vu32 CTSIE		:1;	//CTS Interrupt Enalbe
		} Bit;
	} CR3;	//Control register3
		
	union{
		vu32 Data;
		struct	{
			vu32 PSC	:8;	//Prescaler value
			vu32 GT		:8;	//Guard time value
		} Bit;
	} GTPR;	//Guard time and prescaler register 
} USART_TypeDef;


// UART Init Structure definition
typedef struct
{
	u32 USART_BaudRate;
	u16 USART_WordLength;
	u16 USART_StopBits;
	u16 USART_Parity;
	u16 USART_HardwareFlowControl;
	u16 USART_Mode;
	u16 USART_Clock;
	u16 USART_CPOL;
	u16 USART_CPHA;
	u16 USART_LastBit;
} USART_InitTypeDef;

/* Exported constants --------------------------------------------------------*/
/* USART Word Length ---------------------------------------------------------*/
#define USART_WordLength_8b                  ((u16)0x0000)
#define USART_WordLength_9b                  ((u16)0x1000)

#define IS_USART_WORD_LENGTH(LENGTH) ((LENGTH == USART_WordLength_8b) || \
                                      (LENGTH == USART_WordLength_9b))

/* USART Stop Bits -----------------------------------------------------------*/
#define USART_StopBits_1                     ((u16)0x0000)
#define USART_StopBits_0_5                   ((u16)0x1000)
#define USART_StopBits_2                     ((u16)0x2000)
#define USART_StopBits_1_5                   ((u16)0x3000)

#define IS_USART_STOPBITS(STOPBITS) ((STOPBITS == USART_StopBits_1) || \
                                     (STOPBITS == USART_StopBits_0_5) || \
                                     (STOPBITS == USART_StopBits_2) || \
                                     (STOPBITS == USART_StopBits_1_5))
/* USART Parity --------------------------------------------------------------*/
#define USART_Parity_No                      ((u16)0x0000)
#define USART_Parity_Even                    ((u16)0x0400)
#define USART_Parity_Odd                     ((u16)0x0600) 

#define IS_USART_PARITY(PARITY) ((PARITY == USART_Parity_No) || \
                                 (PARITY == USART_Parity_Even) || \
                                 (PARITY == USART_Parity_Odd))

/* USART Hardware Flow Control -----------------------------------------------*/
#define USART_HardwareFlowControl_None       ((u16)0x0000)
#define USART_HardwareFlowControl_RTS        ((u16)0x0100)
#define USART_HardwareFlowControl_CTS        ((u16)0x0200)
#define USART_HardwareFlowControl_RTS_CTS    ((u16)0x0300)

#define IS_USART_HARDWARE_FLOW_CONTROL(CONTROL)\
                              ((CONTROL == USART_HardwareFlowControl_None) || \
                               (CONTROL == USART_HardwareFlowControl_RTS) || \
                               (CONTROL == USART_HardwareFlowControl_CTS) || \
                               (CONTROL == USART_HardwareFlowControl_RTS_CTS))

/* USART Mode ----------------------------------------------------------------*/
#define USART_Mode_Rx                        ((u16)0x0004)
#define USART_Mode_Tx                        ((u16)0x0008)

#define IS_USART_MODE(MODE) (((MODE & (u16)0xFFF3) == 0x00) && (MODE != (u16)0x00))

/* USART Clock ---------------------------------------------------------------*/
#define USART_Clock_Disable                  ((u16)0x0000)
#define USART_Clock_Enable                   ((u16)0x0800)

#define IS_USART_CLOCK(CLOCK) ((CLOCK == USART_Clock_Disable) || \
                               (CLOCK == USART_Clock_Enable))

/* USART Clock Polarity ------------------------------------------------------*/
#define USART_CPOL_Low                       ((u16)0x0000)
#define USART_CPOL_High                      ((u16)0x0400)

#define IS_USART_CPOL(CPOL) ((CPOL == USART_CPOL_Low) || (CPOL == USART_CPOL_High))
                               
/* USART Clock Phase ---------------------------------------------------------*/
#define USART_CPHA_1Edge                     ((u16)0x0000)
#define USART_CPHA_2Edge                     ((u16)0x0200)
#define IS_USART_CPHA(CPHA) ((CPHA == USART_CPHA_1Edge) || (CPHA == USART_CPHA_2Edge))

/* USART Last Bit ------------------------------------------------------------*/
#define USART_LastBit_Disable                ((u16)0x0000)
#define USART_LastBit_Enable                 ((u16)0x0100)

#define IS_USART_LASTBIT(LASTBIT) ((LASTBIT == USART_LastBit_Disable) || \
                                   (LASTBIT == USART_LastBit_Enable))

/* USART Interrupt definition ------------------------------------------------*/
// SR Register Bit Defintion
#define __PE			0	// parity error
#define __FE			1	// framing error
#define __NE			2	// noise error flag
#define __ORE			3	// overrun error
#define __IDLE			4	// idle line detect
#define __RXNE			5	// Read data register not empty
#define __TC			6	// Transmission complete
#define __TXE			7	// Transmit data register empty
#define __LBD			8	// LIN Bread Detection flag
#define __CTS			9	// CTS Flag	

#define USART_IT_PE                          ((u16)0x0028)
#define USART_IT_TXE                         ((u16)0x0727)
#define USART_IT_TC                          ((u16)0x0626)
#define USART_IT_RXNE                        ((u16)0x0525)
#define USART_IT_IDLE                        ((u16)0x0424)
#define USART_IT_LBD                         ((u16)0x0846)
#define USART_IT_CTS                         ((u16)0x096A)
#define USART_IT_ERR                         ((u16)0x0060)
#define USART_IT_ORE                         ((u16)0x0360)
#define USART_IT_NE                          ((u16)0x0260)
#define USART_IT_FE                          ((u16)0x0160)

#define IS_USART_CONFIG_IT(IT) ((IT == USART_IT_PE) || (IT == USART_IT_TXE) || \
                               (IT == USART_IT_TC) || (IT == USART_IT_RXNE) || \
                               (IT == USART_IT_IDLE) || (IT == USART_IT_LBD) || \
                               (IT == USART_IT_CTS) || (IT == USART_IT_ERR))

#define IS_USART_IT(IT) ((IT == USART_IT_PE) || (IT == USART_IT_TXE) || \
                         (IT == USART_IT_TC) || (IT == USART_IT_RXNE) || \
                         (IT == USART_IT_IDLE) || (IT == USART_IT_LBD) || \
                         (IT == USART_IT_CTS) || (IT == USART_IT_ORE) || \
                         (IT == USART_IT_NE) || (IT == USART_IT_FE))

/* USART DMA Requests --------------------------------------------------------*/
#define USART_DMAReq_Tx                      ((u16)0x0080)
#define USART_DMAReq_Rx                      ((u16)0x0040)

#define IS_USART_DMAREQ(DMAREQ) (((DMAREQ & (u16)0xFF3F) == 0x00) && (DMAREQ != (u16)0x00))

/* USART WakeUp methods ------------------------------------------------------*/
#define USART_WakeUp_IdleLine                ((u16)0x0000)
#define USART_WakeUp_AddressMark             ((u16)0x0800)

#define IS_USART_WAKEUP(WAKEUP) ((WAKEUP == USART_WakeUp_IdleLine) || \
                                 (WAKEUP == USART_WakeUp_AddressMark))

/* USART LIN Break Detection Length ------------------------------------------*/
#define USART_LINBreakDetectLength_10b      ((u16)0x0000)
#define USART_LINBreakDetectLength_11b      ((u16)0x0020)

#define IS_USART_LIN_BREAK_DETECT_LENGTH(LENGTH) \
                               ((LENGTH == USART_LINBreakDetectLength_10b) || \
                                (LENGTH == USART_LINBreakDetectLength_11b))

/* USART IrDA Low Power ------------------------------------------------------*/
#define USART_IrDAMode_LowPower              ((u16)0x0004)
#define USART_IrDAMode_Normal                ((u16)0x0000)

#define IS_USART_IRDA_MODE(MODE) ((MODE == USART_IrDAMode_LowPower) || \
                                  (MODE == USART_IrDAMode_Normal))

/* USART Flags ---------------------------------------------------------------*/
#define USART_FLAG_CTS                       ((u16)0x0200)
#define USART_FLAG_LBD                       ((u16)0x0100)
#define USART_FLAG_TXE                       ((u16)0x0080)
#define USART_FLAG_TC                        ((u16)0x0040)
#define USART_FLAG_RXNE                      ((u16)0x0020)
#define USART_FLAG_IDLE                      ((u16)0x0010)
#define USART_FLAG_ORE                       ((u16)0x0008)
#define USART_FLAG_NE                        ((u16)0x0004)
#define USART_FLAG_FE                        ((u16)0x0002)
#define USART_FLAG_PE                        ((u16)0x0001)

#define IS_USART_FLAG(FLAG) ((FLAG == USART_FLAG_PE) || (FLAG == USART_FLAG_TXE) || \
                             (FLAG == USART_FLAG_TC) || (FLAG == USART_FLAG_RXNE) || \
                             (FLAG == USART_FLAG_IDLE) || (FLAG == USART_FLAG_LBD) || \
                             (FLAG == USART_FLAG_CTS) || (FLAG == USART_FLAG_ORE) || \
                             (FLAG == USART_FLAG_NE) || (FLAG == USART_FLAG_FE))
 
#define IS_USART_CLEAR_FLAG(FLAG) (((FLAG & (u16)0xFC00) == 0x00) && (FLAG != (u16)0x00))

#define IS_USART_BAUDRATE(BAUDRATE) ((BAUDRATE > 0) && (BAUDRATE < 0x0044AA21))
#define IS_USART_ADDRESS(ADDRESS) (ADDRESS <= 0xF)
#define IS_USART_DATA(DATA) (DATA <= 0x1FF)

// Line Control
// | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
//         |  DATA | STOP  | PARITY|

#define _DATA7BIT	  	0
#define _DATA8BIT	  	1 << 4
#define _DATA9BIT	  	2 << 4

#define _05STOP		  	1 << 2
#define _1_STOP		  	0 << 2
#define _2_STOP		  	2 << 2
#define _15STOP			3 << 2

#define _NONPARITY	  	0 << 0
#define _ODDPARITY	  	1 << 0
#define _EVNPARITY	  	2 << 0

typedef struct {
	void (*init)(INT32U nBps, INT8U nLCR);
	unsigned char (*CheckByte)(unsigned short int, unsigned short int *);
	signed short int (*RxGetByte)(void);
	void (*PutStr)(unsigned char *, unsigned short int, int);
	unsigned long int (*printf)( const char *format, ... );
	unsigned char (*PutChar)(unsigned char Data);
	unsigned char (*PutToBuffer)(unsigned char Data);
	signed short int (*TxCheckByte)(void);
	void (*BuffClear)(void);
	void (*TxClear)(void);
	OS_EVENT *sem;

} __SerStrPtr, *__pSerStrPtr;

/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void USART_Init(USART_TypeDef* USARTx, USART_InitTypeDef* USART_InitStruct);
void USART_StructInit(USART_InitTypeDef* USART_InitStruct);
void USART_Cmd(USART_TypeDef* USARTx, INT32U NewState);
void USART_ITConfig(USART_TypeDef* USARTx, u16 USART_IT, INT32U NewState);
void USART_DMACmd(USART_TypeDef* USARTx, u16 USART_DMAReq, INT32U NewState);
void USART_SetAddress(USART_TypeDef* USARTx, u8 USART_Address);
void USART_WakeUpConfig(USART_TypeDef* USARTx, u16 USART_WakeUp);
void USART_ReceiverWakeUpCmd(USART_TypeDef* USARTx, INT32U NewState);
void USART_LINBreakDetectLengthConfig(USART_TypeDef* USARTx, u16 USART_LINBreakDetectLength);
void USART_LINCmd(USART_TypeDef* USARTx, INT32U NewState);
void USART_SendData(USART_TypeDef* USARTx, u16 Data);
u16 USART_ReceiveData(USART_TypeDef* USARTx);
void USART_SendBreak(USART_TypeDef* USARTx);
void USART_SetGuardTime(USART_TypeDef* USARTx, u8 USART_GuardTime);
void USART_SetPrescaler(USART_TypeDef* USARTx, u8 USART_Prescaler);
void USART_SmartCardCmd(USART_TypeDef* USARTx, INT32U NewState);
void USART_SmartCardNACKCmd(USART_TypeDef* USARTx, INT32U NewState);
void USART_HalfDuplexCmd(USART_TypeDef* USARTx, INT32U NewState);
void USART_IrDAConfig(USART_TypeDef* USARTx, u16 USART_IrDAMode);
void USART_IrDACmd(USART_TypeDef* USARTx, INT32U NewState);
INT32U USART_GetFlagStatus(USART_TypeDef* USARTx, u16 USART_FLAG);
void USART_ClearFlag(USART_TypeDef* USARTx, u16 USART_FLAG);
INT32U USART_GetITStatus(USART_TypeDef* USARTx, u16 USART_IT);
void USART_ClearITPendingBit(USART_TypeDef* USARTx, u16 USART_IT);
//addition by Hong
void Write_USART_BaudRate(USART_TypeDef* USARTx, u32 BaudRate);

#endif /* __STM32F10x_USART_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
