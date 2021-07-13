
/*********************************************
* File Name          : USART5_vx.x.h
* Author             : 
* Date First Issued  : 06/05/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/


#define USART5			((USART_TypeDef *)UART5_BASE)


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
INT8U Rx5Buff[Rx5BuffLen] @ "iram";
INT8U Tx5Buff[Tx5BuffLen] @ "iram";

INT16U	Rx5RdCnt @ "iram" = 0, Rx5WrCnt @ "iram" = 0;
INT16U	Tx5RdCnt @ "iram" = 0, Tx5WrCnt @ "iram" = 0;

__SerStrPtr pUSART5 = {
	
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

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////




////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

