
/*********************************************
* File Name          : usart1_vx.x.c
* Author             :
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/



////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
INT8U Rx1Buff[Rx1BuffLen] @ "iram";
INT8U Tx1Buff[Tx1BuffLen] @ "iram";

INT16U	Rx1RdCnt @ "iram"= 0, Rx1WrCnt @ "iram" = 0;
INT16U	Tx1RdCnt @ "iram"= 0, Tx1WrCnt @ "iram" = 0;

__SerStrPtr pUSART1 @ "iram" = {

	InitUSART1,
	USART1CheckByte,
	USART1RxGetByte,
	USART1PutStr,
	USART1Printf,
	USART1PutChar,
	USART1PutToBuffer,
	USART1TxCheckByte,
	USART1BuffClear,
	USART1TxClear
};


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////


////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

