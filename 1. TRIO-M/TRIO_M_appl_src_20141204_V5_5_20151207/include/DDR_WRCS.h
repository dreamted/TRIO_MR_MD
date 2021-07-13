
/*********************************************
* File Name          : usart1_vx.x.c
* Author             :
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define Ser0Bps		38400L
#define Ser0LCR		(_DATA8BIT | _1STOP | _NONPARITY)


#ifdef SER0INT_C
	#define	_USER_SER0INT
#else
	#define _USER_SER0INT		extern
#endif

////////////////////////////////////////////////////////////////////////////////
// Definition
/////////////
#define ACK					0x00		// Ack
#define NACK				0x01		// Nack

#define ISDATA				0xA5
#define DEI_RCODE			0x2C		// 
#define DEO_RCODE			0x2D		// 




#define NO_IMG				(0)
#define OTRU_IMG			(0x01) // bit1
#define FPGA_IMG			(0x02) // bit2
#define FPGA_APP_IMG		(0x04) // bit3
#define REMOTE_IMG			(0x10) // bit4
#define Rmt_FPGA_IMG		(0x20) // bit2
#define Rmt_FPGA_APP_IMG	(0x40) // bit3

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////
#define SER1_STK_SIZE	256

#ifdef	SER0INT_C
	OS_STK Ser1TaskStk[SER1_STK_SIZE];
	__ProtocolPtr PcSerB, *PcSer = &PcSerB;
	
	OS_EVENT *CtrlSem = NULL;
	__Dnr_Sts	 tDnrStsB, *tDnrSts = &tDnrStsB;

	INT32U downloadFlag = 0;
	BOOL SerialPadOnFlag = FALSE;

	INT8U chkDownLoad = 0;
	INT8U DnImageCheck = 0;

	const unsigned char  *RmtCode_Image		  	=   (unsigned char *)"##GSI#DE-O#RMT#RCU#201011#012345"; 

	static INT8U ImgKind = 0; //


#else
	extern OS_STK Ser1TaskStk[SER1_STK_SIZE];

	extern __ProtocolPtr *PcSer;
	
	extern INT32U downloadFlag;
	extern BOOL	SerialPadOnFlag;
	extern __Dnr_Sts *tDnrSts;

	extern OS_EVENT *CtrlSem;


	extern INT8U chkDownLoad ;
	extern INT8U DnImageCheck ;

	extern const unsigned char  *RmtCode_Image;	  

	extern INT8U ImgKind; 


#endif

_USER_SER0INT __WRCSSIO	SPcsksio, RPcsksio;
_USER_SER0INT INT8U iDebugCnt;
_USER_SER0INT INT8U iUser_Value2;
_USER_SER0INT INT8U iRepeaterType;


#define __ChangeDebug  		0x0d


////////////////////////////////////////////////////////
// Prototype Definition
///////////////////////

void WRCS_SerInit(void);
void WRCSTask(void *pdata);


void GenBodyFrame(INT8U* tid, INT8U *Data, INT16U nCnt,INT8U Comm, __ProtocolPtr *nPtr, INT8U BodyNo);

unsigned char WRCS_ProDataAckTx(__ProtocolPtr *nPtr);
void ProtocolComCheck (__ProtocolPtr *nPtr);

INT16U WhatRxComm(__ProtocolPtr *nPtr);
INT32U ProtocolCheck(__ProtocolPtr *nPtr);

// Download Related
void WRCS_DownLoadGiveupTimerRst(void);
BOOL WRCS_DownLoadGiveupTimerChk(__ProtocolPtr *nPtr);
INT32U WRCS_DownLoadGiveupTimerSet(INT32U dnFlag);
extern INT8U WRCS_DownloadFunc (__ProtocolPtr *nPtr);

INT16U GenAidData(INT16U Aid, INT8U *dptr, INT8U *sptr, INT16U len);
INT16U GenAidData16(INT16U Aid, INT8U *dptr, INT16U sptr, INT16U len);

unsigned char Check_Data_Image( unsigned char *_Dat );
char ustrcmp(char *sbuff,char *dbuff, INT8U len);
unsigned long int pPrintf(INT8U	Command, const char *format, ...);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

