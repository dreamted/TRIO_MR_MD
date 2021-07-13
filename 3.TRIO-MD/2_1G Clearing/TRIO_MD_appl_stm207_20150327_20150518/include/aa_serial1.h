
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

#define FLASH_PAGE_SIZE		(0x800*4)		//2k, 512K짜리 플래쉬 경우

#define Filter_PAGE_SIZE	(0x1024*10)		//2k, 512K짜리 플래쉬 경우

#define DataFrameMax		50000 

#define FilterFrameMax		5000 

#define HDLC_FCS_START 		0xffff /* Starting bit string for FCS*/
#define CRC_TAB_SIZE 		256 /* 2^CRC_TAB_BITS */

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
    

	INT8U m_writing = FALSE;

	__Dnr_Sts	 tDnrStsB, *tDnrSts = &tDnrStsB;

	INT8U FSKDebug = 0;
	INT8U ISODebug = 0;
	
	INT8U	DownPageData[FLASH_PAGE_SIZE];
	INT8U	FilterDownload[Filter_PAGE_SIZE] = {0,};

	INT32U	Flash_Data_Co = 0;
	INT32U	Flash_Data_Addr = 0;

	
	INT16U	WaveData[1024];
//	OS_EVENT *CtrlSem = NULL;

	INT8U DataFrame[DataFrameMax]={0,};

	INT8U	FilterDataBuff[FilterFrameMax] = {0,};

////////////////////////////////////////////////////////////////////////////////

	const unsigned short int CRC_16_Table[ CRC_TAB_SIZE ] = {
		0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
		0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
		0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
		0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
		0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
		0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
		0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
		0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
		0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
		0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
		0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
		0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
		0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
		0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
		0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
		0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
		0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
		0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
		0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
		0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
		0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
		0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
		0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
		0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
		0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
		0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
		0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
		0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
		0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
		0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
		0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
		0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
	};

#else
//////////////////////
	extern __ProtocolPtr *PcSer;
	extern INT32U downloadFlag;
	extern BOOL	SerialPadOnFlag;
	
	extern INT8U m_writing;

	extern __Dnr_Sts *tDnrSts;
	
	extern INT8U FSKDebug;

	extern INT8U DownPageData[FLASH_PAGE_SIZE];
	extern INT8U FilterDownload[Filter_PAGE_SIZE];

	extern INT32U Flash_Data_Co;
	extern INT32U Flash_Data_Addr;
	extern INT16U	WaveData[1024];

	extern INT8U DataFrame[DataFrameMax];
	extern INT8U FilterDataBuff[FilterFrameMax];

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
INT32U ProtocolCheck_1(__ProtocolPtr *nPtr);

INT32U ProtocolCheck(__ProtocolPtr *nPtr);
// Download Related
void DownLoadGiveupTimerRst(void);
BOOL DownLoadGiveupTimerChk(__ProtocolPtr *nPtr);
INT32U DownLoadGiveupTimerSet(INT32U dnFlag);
INT8U DownloadFunc (__ProtocolPtr *nPtr);
INT8U FastDownloadFunc (__ProtocolPtr *nPtr);

void GenBodyFrame(INT8U* tid, INT8U *Data, INT16U nCnt,INT8U Comm, __ProtocolPtr *nPtr, INT8U BodyNo);
unsigned char WRCS_ProDataAckTx(__ProtocolPtr *nPtr);


INT16U makeFCS(INT8U *pBuffer,INT16U pSize,INT16U *pCalcFCS);



BOOL DnReceiveData(__ProtocolPtr *nPtr);


////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

