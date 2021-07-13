
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart2_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/


#define USART2		((USART_TypeDef *) USART2_BASE)

#define Rx2BuffLen	(256*4)
#define Tx2BuffLen	(256*4)
////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
INT8U Rx2Buff[Rx2BuffLen] @ "iram";
INT8U Tx2Buff[Tx2BuffLen] @ "iram";
INT16U	Rx2RdCnt @ "iram" = 0, Rx2WrCnt @ "iram" = 0;
INT16U	Tx2RdCnt @ "iram" = 0, Tx2WrCnt @ "iram" = 0;

__SerStrPtr pUSART2 = {
	
	InitUSART2,
	USART2CheckByte,
	USART2RxGetByte,
	USART2PutStr,
	USART2Printf,
	USART2PutChar,
	USART2PutToBuffer,
	USART2TxCheckByte,
	USART2BuffClear,
	USART2TxClear
};

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////




////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

