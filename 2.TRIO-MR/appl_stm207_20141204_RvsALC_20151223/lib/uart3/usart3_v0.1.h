
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 06/05/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/


#define USART3		((USART_TypeDef *) USART3_BASE)

#define Rx3BuffLen	(256*4)
#define Tx3BuffLen	(256*4)
////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
INT8U Rx3Buff[Rx3BuffLen] @ "iram";
INT8U Tx3Buff[Tx3BuffLen] @ "iram";
INT16U	Rx3RdCnt @ "iram" = 0, Rx3WrCnt @ "iram" = 0;
INT16U	Tx3RdCnt @ "iram" = 0, Tx3WrCnt @ "iram" = 0;

__SerStrPtr pUSART3 = {
	
	InitUSART3,
	USART3CheckByte,
	USART3RxGetByte,
	USART3PutStr,
	USART3Printf,
	USART3PutChar,
	USART3PutToBuffer,
	USART3TxCheckByte,
	USART3BuffClear,
	USART3TxClear
};

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////




////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

