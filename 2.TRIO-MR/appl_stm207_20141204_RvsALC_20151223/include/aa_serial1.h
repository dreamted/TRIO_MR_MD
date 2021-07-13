
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart1_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define Ser0Bps		38400L
#define Ser0LCR		(_DATA8BIT | _1_STOP | _NONPARITY)


#ifdef SER1INT_C
	#define	_USER_SER1EXT
#else
	#define _USER_SER1EXT		extern
#endif

////////////////////////////////////////////////////////////////////////////////
// Definition
/////////////
#define ISDATA				0xA0
#define ISFIRST				0xA6

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////
#ifdef	SER1INT_C
///////////////////////////////
	#define SER1_STK_SIZE	(128*3)
	OS_STK Ser1TaskStk[SER1_STK_SIZE] @ "iram";;
	
	__ProtocolPtr PcSerB, *PcSer = &PcSerB;
	
	INT32U downloadFlag = 0;
	BOOL SerialPadOnFlag = FALSE;
    
	MSTATUS MainStatusB, *MainStatus = &MainStatusB;


	INT8U m_writing = FALSE;

	
	__Dnr_Sts	 tDnrStsB, *tDnrSts = &tDnrStsB;

	INT8U FSKDebug = 0;

	
	OS_EVENT *CtrlSem = NULL;
////////////////////////////////////////////////////////////////////////////////
#else
//////////////////////
	extern __ProtocolPtr *PcSer;
	extern INT32U downloadFlag;
	extern BOOL	SerialPadOnFlag;
	extern MSTATUS *MainStatus;
	
	extern INT8U m_writing;

	extern __Dnr_Sts *tDnrSts;
	
	extern OS_EVENT *CtrlSem;

	
	extern INT8U FSKDebug;
////////////////////////////////////////////////////////////////////////////////
#endif
/////////////////////////////////
_USER_SER1EXT __WRCSSIO	SPcsksio, RPcsksio;

_USER_SER1EXT SIO	Ssio, Rsio;

_USER_SER1EXT INT8U iDebugCnt;
_USER_SER1EXT INT8U iUser_Value2;
_USER_SER1EXT INT8U iResetCase;
//_USER_SER1EXT INT8U Booting[2];

#define __ChangeDebug  	0x0d


////////////////////////////////////////////////////////
// Prototype Definition
///////////////////////

void Ser1Init(void);
void Ser1Task(void *pdata);

void ProtocolComCheck (__ProtocolPtr *nPtr);
INT16U WhatRxComm(__ProtocolPtr *nPtr);

INT32U ProtocolCheck(__ProtocolPtr *nPtr);
// Download Related
void DownLoadGiveupTimerRst(void);
BOOL DownLoadGiveupTimerChk(__ProtocolPtr *nPtr);
INT32U DownLoadGiveupTimerSet(INT32U dnFlag);
INT8U DownloadFunc (__ProtocolPtr *nPtr);

void GenBodyFrame(INT8U* tid, INT8U *Data, INT16U nCnt,INT8U Comm, __ProtocolPtr *nPtr, INT8U BodyNo);
unsigned char WRCS_ProDataAckTx(__ProtocolPtr *nPtr);


////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

