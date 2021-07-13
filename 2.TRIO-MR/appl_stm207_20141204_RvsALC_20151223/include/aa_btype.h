/*******************************************************************************
 *
 * This module contains the function header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * Values of global or static variables.
 *
 *
 * Copyright 2011 - bizistyle(bgyoon@naver.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2011.07
 *
 ******************************************************************************/


#pragma pack(1)

#define	SIOtxdNO	700		// Used In Setting For Source Address

/*===============================================================*
 *          PROTOCOL FRAME FILED DEFINE                          *
 *===============================================================*
 *  SYNC  | SUB_ID |  TYPE  |  LEN  | SUB_DATA  |CRC    | *
 *---------------------------------------------------------------*
 * 4 BYTE | 2 BYTE | 1 BYTE | 1 BYTE| 700 BYTE  | 2 BYTE| *
 *===============================================================*/
 
typedef struct {
	INT8U	Sync[4];
	INT8U	SUBID1; 			// SUBID 1 : Address Information
	INT8U	SUBID2; 			// SUBID 2 : Address Information
	INT8U	Command;			// Frame Type
	INT8U	RCode;				// 소형/초소형 --> 'L'
	INT8U	DataLength[2]; 		// Data Field Lenght
	INT8U	Data[SIOtxdNO+2];	// CCN Data

	INT16U	Crc;				// SIO CRC
	INT8U	CrcErr;
} SIO;

#define STX						0x16			// Start code

#define	STX1					0x15
#define REMSTX				0x16

#define	NODATA				0xCD
#if 0
#define	ACK					'0'
#define	NACK				'1'
#endif
#define ACK					0x00		// Ack
#define NACK				0x01		// Nack


#define RCODE				's'

// Path
#define L_PATH				0
#define	W_PATH				1

#define	_Enable				0x00
#define	_Disable			0x01

#define	__SET				0x01
#define	__RESET				0x00

#define Enable 				0
#define Disable 			1

#define UnMask				0
#define Mask				1

#define Normal				0
#define Alarm				1

#define Install				1
#define Uninstall			0

#define _Off				0
#define _On 				1

#define _Manual 			0
#define _Auto 				1


#define _AGC_Mode 			0
#define _ALC_Mode 			1


#define __Alarm				0x01
#define __Normal			0x00

#define __ON				0x01
#define __OFF				0x00

#define DnrMaxID			2
///////////////////////////////
// Download

#define ServerPadTime		(1*Time1Min)

#define GAIN_MAX85			(85*2)
#define GAIN_MAX75			(75*2)
#define ATTN_MAX30			30
#define ATTN_MAX31			31

#define ATTN_MAX60			60
#define ATTN_MAX63			63


#define MAX_Retry			18

////////////////////////////////////////////////////////////////////////////////
// command
#define	NODATA					0xCD


//===================
//   SIO COMMAND
//===================
#define NStatusRQST				0x00
#define NStatusRSPS				0x80
#define	NControlRQST			0x01
#define NControlRSPS			0x81
#define NResetRQST				0x02
#define NResetRSPS				0x82
#define NiRemsResetRQST			0x03
#define NiRemsResetRSPS			0x83
//-----------------------------------//

#define	DTableStsRQST			0xB4
#define	DTableStsRSPS			0xB5
#define	DTableSetRQST			0xB6
#define	DTableSetRSPS			0xB7
#define	DTableGetRQST			0xB8
#define	DTableGetRSPS			0xB9

#define PStatusRQST				0xD0
#define PStatusRSPS				0xD1
#define	PControlRQST			0xD2
#define PControlRSPS			0xD3


//===================================//
#define DefaultSetCMD      	 	0xBC
#define DefaultTABLECMD			0xBF 

#define	notMINE					0xE2
#define	crcERROR				0xE1
#define NULLcomm				0xE0
//===================================//
#define ProgramVerQue			0x0A
#define	DownloadCMD				0x0B
#define	DownloadCMDConfirm		0x0C
#define	DownLoadData			0x0D
#define	DownLoadDataConfirm		0x0E

#define DownloadMinNumCMD		0x09

//===================================//
#define ErrorRSPS				0xFF


typedef union{
    INT16U Data;
    struct {
	    INT16U Low  	:8;
	    INT16U High 	:8;
	} Byte;

} __TBL16;

#if 1
// ********************************************************
#define TWO_BODY		1

#define BODYSIZEMAX			2048			// Body data Max 11K
#define SMSBODYSIZEMAX		1024			// Body data Max 11K


// ********************************************************


typedef struct {
	
	INT8U	SubID[3];		// 0: Dest					   
	INT8U	Command;		// Command
	INT8U	RCode;			// Repeater Code
	INT8U	SubLen[2];		// SUB_DATA filed length
	INT8U	SubData[BODYSIZEMAX];

	//////////////////////////////////////////////////
	INT16U	SubLength;

	INT16U	Crc;			// SIO CRC
	BOOL    CrcOK;
} __BODYFRAME;

// Struct of Frame
typedef struct {
	INT8U	SubID[3];		// 0: Dest					   
	INT8U	Command;		// Command
	INT8U	RCode;			// Repeater Code
	INT8U	SubLen[2];		// SUB_DATA filed length
	INT8U	SubData[128];
	//////////////////////////////////////////////////
	INT16U	SubLength;

	INT16U	Crc;			// SIO CRC
	BOOL    CrcOK;
} __BODYFRAME2;


typedef struct {

	INT8U	Sync[4];
	INT8U  	TryNo;
	INT8U	BodyLen[2];	
	INT8U	CheckSum;

	__BODYFRAME BodyFrame[TWO_BODY];
	//INT8U  	SubID[3];

	//INT8U	Command;
	//INT8U	Rcode;
	//INT8U	SubLen[2];
	//INT8U	SubData[BODYSIZEMAX];
	//INT16U	Crc;
	//------------------------------//	Tail
	//------------------------------//	Etc.. (상위프로그램과 연관 없음)
	INT16U	BodyLength;
	INT8U	BodyNo;			// received body cnt!!
	INT8U   cBody;			// current body cnt!!
	
	//INT16U	SubLength;
	//INT8U	CrcErr;
	//BOOL	CrcOK;
	//INT8U 	OrgDstID;
	//INT8U	OrgSrcID;
} __WRCSSIO;



typedef struct {
	
	INT8U	SubID[3];		// 0: Dest					   
	INT8U	Command;		// Command
	INT8U	RCode;			// Repeater Code
	INT8U	SubLen[2];		// SUB_DATA filed length
	INT8U	SubData[SMSBODYSIZEMAX];
	//////////////////////////////////////////////////
	INT16U	SubLength;

	INT16U	Crc;			// SIO CRC
	BOOL    CrcOK;
} __SMSBODYFRAME;


typedef struct {

	INT8U	Sync[4];
	INT8U  	TryNo;
	INT8U	BodyLen[2];	
	INT8U	CheckSum;

	__SMSBODYFRAME BodyFrame[TWO_BODY];
	//INT8U  	SubID[3];

	//INT8U	Command;
	//INT8U	Rcode;
	//INT8U	SubLen[2];
	//INT8U	SubData[BODYSIZEMAX];
	//INT16U	Crc;
	//------------------------------//	Tail
	//------------------------------//	Etc.. (상위프로그램과 연관 없음)
	INT16U	BodyLength;
	INT8U	BodyNo;			// received body cnt!!
	INT8U   cBody;			// current body cnt!!
	
	//INT16U	SubLength;
	//INT8U	CrcErr;
	//BOOL	CrcOK;
	//INT8U 	OrgDstID;
	//INT8U	OrgSrcID;
} __SMSWRCSSIO;




#endif

#pragma pack()

typedef struct {
	unsigned char (*CheckByte)(unsigned short int, unsigned short int *);
	signed short int (*RxGetByte)(void);
	void (*PutStr)(unsigned char *, unsigned short int, int);
	void (*TxClear)(void);

	signed short int (*TxCheckByte)(void);
	void (*BuffClear)(void);

	INT16U TimerRx;
	INT16U TimerEndWait;
	INT32U ctrlsrc;			//
	OS_EVENT *OSSem;

	SIO *Recv;
	SIO	*Send;
#if 1
	__WRCSSIO *WRCSRecv;
	__WRCSSIO *WRCSSend;

	__BODYFRAME *SmsRecv;	//
	__BODYFRAME *SmsSend;	//
#endif	
} __ProtocolPtr;


////////////////////////////////////////////////////////////////////////////////
//_USER_Protocol INT8U CurrCDMA_FwdInAttn;

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

////////////////////////////////////////////////////////
// End of Headerfile
///////////////////////

