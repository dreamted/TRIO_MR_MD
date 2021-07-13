
/*********************************************
* File Name          : usart3_vx.x.h
* Author             :
* Date First Issued  : 06/05/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/


#define USART4		((USART_TypeDef *) UART4_BASE)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
INT8U Rx4Buff[Rx4BuffLen] @ "iram";
INT8U Tx4Buff[Tx4BuffLen] @ "iram";
INT16U	Rx4RdCnt @ "iram" = 0, Rx4WrCnt @ "iram" = 0;
INT16U	Tx4RdCnt @ "iram" = 0, Tx4WrCnt @ "iram" = 0;

__SerStrPtr pUSART4 = {
	
	InitUSART4,
	USART4CheckByte,
	USART4RxGetByte,
	USART4PutStr,
	USART4Printf,
	USART4PutChar,
	USART4PutToBuffer,
	USART4TxCheckByte,
	USART4BuffClear,
	USART4TxClear
};

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////




////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

