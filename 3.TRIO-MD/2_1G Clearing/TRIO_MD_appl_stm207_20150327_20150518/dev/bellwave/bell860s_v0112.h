/*******************************************************************************
 *
 * This module contains the function 7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 *
 ******************************************************************************/

#define NORMAL_STS				1
#define SELF_SEND				2
#define SELF_RECV				3
#define SELF_TIME				4

#define NOT_RSPS				0
#define NOT_DATA				-1
#define MAX_TRY					-2

// Receving SMS message
#define NONE_DATA				-3

#define MaxTryNo				5

#define TelNo					13



// Time
typedef struct {
	char Year[4];
	char Month[2];
	char Day[2];
	char Hour[2];
	char Min[2];
	char Sec[2];
	char Week[4];
} BcMTimeStr;

 // RF Status
typedef struct {
	INT16S ActChannel; 		///2G 3G
	
	INT16S NumberOfChannel; ///2G 3G
	INT16S ChannelList[6];  ///2G 3G
	INT16S ActPN;
	INT16S PN_Vaule[6];
	INT16S EcIo[6];
	INT16S FerValue;
	INT16S RxValue;  ///2G 3G
	INT16S TxValue;  ///2G 3G
	INT16S AdjValue;  ///2G 3G

	/////////////////Adder
	INT16S PSClist;
	INT16S PSC_Vaule[6];
	INT16S BER;

	
} BcMRfStsStr;
 
 
// Pilot Status
typedef struct {
	INT16S PN_Vaule[4];
	INT16S EcIo[4];
//	INT8S EcIo[6];
} BcMPilotStsStr;



////////////////////////////////////////////////////////////////////////////////
// Tx, Rx Related Definition
////////////////////////////

#define SmsMaxLen		100
#define SmsWanLen		80
//#define CdmaBuffLen		1024
#define CdmaBuffLen		4095

////////////////////////////////////////////////////////////////////////////////
// Receving Modem Data Type (Command Status)
/////////////////////////////////
enum {

 RstCmd				= 0,
 ModemHangUpCmd,
// ModemRptModeSetCmd,
 VersionCmd,
 ModemMinNumCmd,
 ModemEsnCmd,
 ModemTimeCmd,

  
 ModemRfStsCmd,
 ModemTrafficCmd,
 MsgCheckCmd,			////8
 MsgReciveCmd,
 TxDataToSMSCmd,
 ModemTcpModeCmd,
 ModemTcpIdCmd,
 ModemTcpPwCmd,
 ModemTcpConnect,
 ModemTcpOpenCmd,
 ModemTcpCloseCmd,
 ModemTcpExitCmd,
 ModemPilotCmd,

 
 ModemLockOrderCmd,
 ModemGMMLockOrderCmd,

 
 ModemICCIDCmd,  ///WCDMA 추가
 ModemPWROFFCmd,
 ModemHangUpCommand,
 
 ModemFTPOpenCmd,
 ModemFTPSizeCmd,
 ModemFTPFileGetCmd,
 ModemFTPFileEraseCmd

};
#define _MdemSTART				0
#define _MdemCONCTROL			1

#define SMS_MODE				1
#define TCP_MODE				2
#define ASYNC_MODE				3


#define _CMDA_Modem				0
#define _WCMDA_Modem			1



#define CdmaRstCmd				"ATE0"

#define CdmaMsgCheckCmd 		"AT*SKTR*SMSCNT?"
//#define CdmaMsgCheckCmd 		"AT*SKTR*SMSCNT"

#define CdmaMsgReciveCmd 		"AT*SKTR*SMSMT"

#define CdmaVersionCmd 			"AT+GMR"
#define CdmaModemCustIdCmd 		"AT$CUSTID=123"
/*
AT+GMR                                                                          
+GMR:x05,0x0C,112

AT+GMR                                                                          
                                                                                
+GMR:SAT,ZZB5,102


at*sktr*smsmo=01038968361,01021468701,4098,2,0,0,616263                         
AT*SKTR*SMSMO=01038968361,01021468701,4098,,,,ffffff82b580858994818183b5c2 


*/

#define CdmaRptModeSetCmd 		"AT*SKTR*SPC=011010"
#define CdmaModemEsnCmd 		"AT*SKTR*ESN?"
#define CdmaModemRfStsCmd 		"AT*SKTR*RFSTS"

//#define CdmaModemHangUpCmd 		"AT+CHV"
#define PhoneHangUpCmd 				"AT+CHV"

#define CdmaNewMtAckkCmd 		"AT$MTACK=0"

#define CdmaTxDataToSMSCmd 		"AT*SKTR*SMSMO="

#define CdmaModemConTypeCmd 	"AT$CONRPT=0"
//#define CdmaModemTimeCmd 		"AT$BWMODEM=4?"



#define CdmaOk					"OK"
#define CdmaErr					"ERROR"
#define Rspconnect				"CONNECT"
#define Rspnocarr				"NO CARRIER"
#define RspTcpOpenOk			"$TCPOPEN"
#define RspTcpCloseOk			"$TCPCLOSED"

#define RspmsgRxCnt 			"*SKTR*SMSCNT:"
#define RspmsgRxMsg 			"*SKTR*SMSMT:"
#define RspmsgRxEsn 			"*SKTR*ESN:"
#define RspmsgRxRfSts 			"*SKTR*RFSTS:"

#define RspTxmsg				"$006"
#define RspTxAckmsg				"*SKTR*SMSMOACK:1"

#define Rspmsg0Rx				"$008:0"
#define Rspmsg1Rx				"$008:1"

#define CdmaModemTcpModeCmd		"AT+CRM=251"
//#define CdmaModemTcpIdCmd		"AT$TCPUIDNULL"
#define CdmaModemTcpIdCmd		"AT$TCPUID=SKTELECOM"

#define CdmaModemTcpPwCmd		"AT$TCPPASSWDNULL"
//#define CdmaModemTcpConnect		"ATDT1501"
#define CdmaModemTcpConnect		"ATD1501"

#define CdmaModemTcpOpenCmd		"AT$TCPOPEN="
#define CdmaModemTcpWrCmd		"AT$TCPWRITE="
#define CdmaModemTcpSendDone	"$TCPSENDDONE"
#define CdmaModemTcpCloseCmd	"AT$TCPCLOSE"
#define CdmaModemTcpExitCmd		"AT$TCPEXIT"

#define CdmaModemTcpRdCmd		"$TCPREADDATA="

#define PhoneNumSet1			"AT$BWMODE=SIMPLE"
#define PhoneNumSet2			"AT$PHONENUM=01090449833,01090449833"
#define PhoneNumSet3			"AT$BWMODE=PWREG"

#define CdmaModemSwRstCmd		"AT*SKT*RESET"
#define RspmsgSwRst				"*SKT*RESET:1"

//#define CdmaCallingCmd 			"AT+CDV "
#define CdmaCallingCmd 			"AT*SKT*ORI="
#define RspmsgCallingCmd 		"*SKT*ORI:"

#define RspmsgCallAck			"*SKT*VCALL:"
#define RspmsgCallConnect		"*SKT*VOICECONNECT"

//#define RspmsgHangup			"*SKT*VOICERELEASE"

#define CdmaModemTrafficCmd		"AT*SKT*PING"
#define CdmaModemTimeCmd 		"AT*SKT*PING"

#define RspmsgTraffic			"*SKT*PONG:"

#define CdmaModemHangUpCmd 		"AT*SKT*REL"
#define RspmsgHangup			"*SKT*REL:"

#define CdmaModemPilotCmd 		"AT*SKTR*PILOT?"
#define RspmsgPilot				"*SKTR*PILOT:"

#define CdmaModemMinNumCmd 		"AT*SKT*DIAL"
#define RspmsgMinNum 			"*SKT*DIAL:"

//#define WcdmaModemICCIDCmd 		"AT*SKTR*ICCID"
#define WcdmaModemICCIDCmd 		"AT*SKTR*ICCID?"


#define RspICCID		 		"*SKTR*ICCID:"


#define LockOrderCmd 			"AT+CGREG?"
//#define RspLockOrder			"+CGREG: 0,0"
//#define RspLockOrder			"+CGREG: 0," /////KST
//#define RspLockOrder			"+CGREG:0," /////KST
#define RspLockOrder			"+CGREG:" /////KST



#define GMMLockOrderCmd 		"AT$$GMM_REJ?"
#define RspGMMLockOrder			"$$GMM_REJ:"

#define ModemPWROFF				"AT+ZPWROFF"


#define ModemFTPOpenMsg			"AT$$FTPOPEN="
#define ModemFTPFileSizeMsg		"AT$$FSIZE="
#define ModemFTPFileGetMsg		"AT$$FGET="
#define ModemFTPFileEraseMsg	"AT$$FDONE="


#define ModemFTPFileSizeAckMsg		"$$FSIZE:1,"

#define ModemFTPFileGetAckMsg		"$$FGET:1,"


#define ModemBaudRateMsg		"AT+IPR=230400"


#define ModemFTPOpenAckMsg		"$$TELL: 150, FTP : FTP Open"
#define ModemFTPGetAckMsg		"$$TELL: 153, FTP : FTP Get"
#define ModemFTPCloseAckMsg		"$$TELL: 151, FTP : FTP Closed"
#define ModemFTPCarrierAckMsg	"$$TELL: 152, FTP : No Carrier"

#if 0
$$TELL: 150, FTP : FTP Open

$$TELL: 153, FTP : FTP Get

$$TELL: 151, FTP : FTP Closed

$$TELL: 152, FTP : No Carrier

///////////////////////////////////////////////////////
AT$$FTPOPEN=118.67.190.100,22,TEST,1234,,trio.bin

OK
$$TELL: 150, FTP : FTP Open

$$TELL: 153, FTP : FTP Get

CONNECT

$$TELL: 151, FTP : FTP Closed

#endif


// 모뎀 off 요청 있었고, 마지막 off처리명령 후 10초 지난 후, 실제로 모뎀 전원을 off( Modem_Off_Is 값은 2)

//{ (unsigned char *) "AT+ZPWROFF\r\n",			0,	  22,  1,	 22,	 0, 	100   }, /*  31 */


#if 0
AT*SKTR*ICCID                                                                   
                                                                                
*SKTR*ICCID:8982050809329194249


#endif

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////
#define	Tx2BUF_LEN			256

//#define	SerBuffNo		8192
//#define RxBUF_LEN		8192

//#define	SerBuffNo		220*30
#define	SerBuffNo		20000


#ifdef __BELL_C
	INT8U RxCdmaData[CdmaBuffLen+1];
	INT8U TxCdmaData[CdmaBuffLen+1];
	INT8U RxBcMData[CdmaBuffLen+1];

	INT8U Send2Buf[Tx2BUF_LEN];

	INT8U BcMdebug = FALSE;
//	INT8U BcMSrcTel[TelNo]={0,};
	INT8U BcMSrcTel[11];

	INT8U BcMEsnNum[8];
	INT8U ICCIDNum[19];

	INT8S BcMVerNum[3];
	INT8U TimeReqCnt = 0;
	INT8U BcMRtryNo = 0;
	INT8U BcMMaker = 0;
	INT8U BcMType = 0;
	INT8U LockOrder;
	INT8U GMMLockOrder;

	INT8S PN0_Vaule[3];
	INT8S PN1_Vaule[3];
	INT8S PN2_Vaule[3];
	INT8S PN3_Vaule[3];

	INT8S EcIo0_Vaule[3];
	INT8S EcIo1_Vaule[3];
	INT8S EcIo2_Vaule[3];
	INT8S EcIo3_Vaule[3];


	INT8S ModemVersion[50];

	INT16U BcMTimerRx = 0;



	INT8U ModemType = 0;

#if 0
	__SerStrPtr *dUartPtr = NULL;  // Debug Ptr
	__SerStrPtr *eUartPtr = NULL;  // Excution Ptr
#endif

	__SerStrPtr *dUartPtr = &pUSART1;  // Debug Ptr
	__SerStrPtr *eUartPtr = NULL;  // Excution Ptr


	BcMTimeStr BcMpresentTimeB;
	BcMTimeStr *BcMpresentTime = &BcMpresentTimeB;

	BcMRfStsStr BcMRfStatusB;
	BcMRfStsStr *BcMRfStatus = &BcMRfStatusB;

	BcMPilotStsStr BcMPilotStatusB;
	BcMPilotStsStr *BcMPilotStatus = &BcMPilotStatusB;

	INT8U MsgCheckCnt = 0;

	INT8U  SerRxBuff[SerBuffNo];
	INT16U RxBuffRdCnt = 0, RxBuffWrCnt = 0;
	INT16U Ser0Cnt = 0, Ser0DataCnt = 0;


	INT16U FTPCRC = 0;
	INT16U FTPIndex = 0;
	INT16U FTPlen = 0;
#else
	extern INT8U EsnChecksumH;
	extern INT8U EsnChecksumL;
	extern INT8S BcMVerNum[3];
	extern INT8S LockOrder;
	extern INT8S GMMLockOrder;

	extern INT8U RxCdmaData[CdmaBuffLen+1];

	extern INT8U TxCdmaData[CdmaBuffLen + 3];

//	extern INT8U BcMSrcTel[TelNo];		// phone number
	extern INT8U BcMSrcTel[11];		// phone number

	extern INT8U BcMEsnNum[8];			// phone ESN
	extern INT8U ICCIDNum[19];			// phone ESN

	extern INT8S BcMVerNum[3];			// phone Version
	extern INT8U BcMMaker;
	extern INT8U BcMType;
	extern INT8U BcMRtryNo;
	extern __SerStrPtr *Ser0Str;

	extern INT8U ModemType;
	extern INT8U TimeReqCnt;

	extern INT8U SerRxBuff[SerBuffNo];
	extern INT16U RxBuffRdCnt, RxBuffWrCnt;
	extern INT16U Ser0Cnt, Ser0DataCnt;

	extern INT16U FTPCRC;
	extern INT16U FTPIndex;
	extern INT16U FTPlen;
#endif



////////////////////////////////////////////////////////////////////////////////
// Fuction Prototype Declaration
////////////////////////////////

INT8S BcMdemInit(__SerStrPtr *uPtr, INT16U TimerRx);			// error, -1, -2, -3 case 0: error

void BcMdemDebug(INT32U nDebug, INT32S *DebugPtr);	// nDebug: 1: Enable, 0: FALSE, dbugptr: ser0 or other
INT32S BcMdemMSGTx(char *DstTel, char *dataPtr, INT16U nlen);
													//	6: Sms Len Over 80 Bytes(Waringin), But Success, 1st Response OK, but 1st resonse data error, 2nd Response Data NOK
													//	5: Sms Len Over 80 Bytes(Waringin), But Success, 1st Response OK, but 1st resonse data error, 2nd Response Data OK
													//	4: Sms Len over 80 Bytes(Warning) But Success, 1st Response OK, but 1st resonse data error, 2nd Rsponse No response
													//	2: 1st Response OK, but 1st resonse data error, 2nd Rsponse No response
													//	1: Modem Send Success
													//	0: Modem No Response
													// -1: 2nd Response Data Error
													// -2: 1st Response Data Error, 2nd Response No response
													// -3: Max Buffer Error


void BcMdemXmit(INT8U *dataPtr);

INT8S  BcMdemDataProtocolCheck(INT8S Command);
INT32S BcMdemSyncProtocolCheck(void);
INT32S BcMdemSyncProtocolCheck1(void);

INT32S BcMdemRecv(INT8U *rbuf, INT8U *sTel, BcMTimeStr *rtime);
INT32S BcMdemCommad(INT8U Commad);
INT32S BcMdemSyncCheck(char *Ptr);
INT32S BcMdemFuncselect(void);
INT32S BcdemTimeGet(BcMTimeStr *nPtr);
INT32S BcdemRfStsGet(BcMRfStsStr *nPtr);
INT8S  BcMFreqStateCheck (INT8U *DataBuff );
INT8S  BcMPilotStateCheck (INT8U *DataBuff );


INT32S BcMdemTcpConnect(INT8U *ConnectIP, INT8U IPLen, INT32U PortNum);
INT32S BcMdemTCPTx(char *dataPtr, INT16U nlen);
INT32S BcMdemTCPRxCheck(INT8U *rbuf);
INT32S BcMdemTCPRxCheck1(INT8U *rbuf);

INT32S BcMdemTcpExit(void);

INT32S BcMdemSwReset(void);

INT32S BcMdemCalling(char *DstTel);
INT32S CdmaModemTrafficCheck(void);
INT32S CdmaModemHangUp(void);
INT32S ModemHangUp(void);

INT32S BcdemPilotGet(BcMPilotStsStr *nPtr);

INT32S ModemLockOrder(void);
INT32S ModemGMMLockOrder(void);

INT32S ModemPwrOFF(void);

INT32S ModemFTPOpen(INT8U *ConnectIP,INT8U Port,INT8U *FTP_ID,INT8U *FTP_PW,INT8U *FilePath,INT8U *FileName);
INT32S ModemFTPSize(INT8U *FileName);
INT32S ModemFTPFileGet(INT8U *FileName,INT16U Cnt, INT16U Frame,INT8U TrsnsferMode);
INT32S ModemFTPFileErase(INT8U *FileName);

//int Sprintf(char * buf, const char *fmt, ...);
int vSprintf(char * buf, const char *fmt, ...);


INT32S BcMdemMSGSentTx(char *DstTel,char *SentTel, char *dataPtr, INT16U nlen);


////////////////////////////////////////////////////////////////////////////////
// Fuction Prototype Declaration
////////////////////////////////

//extern INT8U TimeOverCheck(INT8U TimeId);
//extern INT8U TimerRegist(INT8U TimeId, INT32U TimeCnt);

extern INT8U TimeOverCheck(int TimeId );
extern INT8U TimerRegist(int TimeId, INT32U TimeCnt);


extern INT8U atoh (INT8U value );
extern unsigned long int Ser0Printf( const char *format, ... );	// for debug

INT8U ReadRXByte( void );
INT8U AnyRXData(INT16U ByteCount, INT8U Port);



signed short int AnyRxGetByte(void);
unsigned char AnyCheckByte(unsigned short int ByteCnt, unsigned short int *Recv);
void AnyBuffClear(void);

INT32S FTPFileSizeRxCheck(INT8U *rbuf);
INT32S FileGetCheck (INT8U *rbuf,INT8U *DataBuff);
INT32S ModemBaudRateSet(void);
INT32S FTPOpenGetRxCheck(INT8U Index);
INT32S FTPGetRxCheck(INT8S *Mode);

INT32S BcMdemSyncProtocolCheck_Mode(INT8U *rbuf,INT16U nlen);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

