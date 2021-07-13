/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : fsmc_sram.h
* Author             : MCD Application Team
* Version            : V2.0.2
* Date               : 07/11/2008
* Description        : Header for fsmc_sram.c file.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

#pragma pack(1)

#ifdef PROT_C
	#define	_USER_PRO_EXT
#else
	#define _USER_PRO_EXT	extern
#endif

// TransceiveMaker //

#define ACE			0x00
#define DONGWON		0x03
#define FRTEK		0x04
#define GTNT		0x05
#define YOUNGWOO	0x07
#define WITHUS		0x08

// TransceiveType //
#define SMALL		'D'

#define LTE_10MHz	0x00
#define LTE_15MHz	0x01
#define LTE_20MHz	0x02
#define LTE_Bypass	0x03

#define EQ_Highpass	0x00
#define EQ_Lowpass	0x01
#define EQ_Bypass	0x02

#define EQ_Basic	0x00
#define EQ_L20		0x01
#define EQ_L10		0x02
#define EQ_H20		0x03
#define EQ_H10		0x04

typedef struct {
	union {
		INT8U Data[5];	// 0 ~ 2 [STANDARD], 3~4 [HIDDEN/RESERVED]
		struct {
			INT8U OverFwdPower			:1;
			INT8U OverRvsPower			:1;
			INT8U						:2;
			
			INT8U ISO_ALM				:1;
			INT8U ISO_RALM				:1;
			INT8U ISO_WAITING			:1;
			INT8U OSCAlarm				:1;
/////////////////////////////////////////////
			INT8U SleepAlarm			:1;
			INT8U						:7;

			
/////////////////////////////////////////////
			INT8U iRemsCommAlarm		:1;
			INT8U iRemsNetAlarm			:1;
			INT8U iRemsServerAlarm		:1;
			INT8U iRemsServerCheck		:1;
			
			INT8U						:4;

/////////////////////////////////////////////
// HIDDEN AREAD
			INT8U PLL_ALM				:1;
			INT8U 						:3;

			INT8U						:4;
/////////////////////////////////////////////
		};
	} AlarmFlag[2];						// ALARM : BIT SET, NORM : BIT RESET

	INT8U	BootFlag;					// 0,1,2 --> 0: BOOT, 1: Isolation, 2: normal
	INT8U	TransceiveType;				// 
	INT8U	TransceiveMaker;			//	NAME  --> HEX
	INT8U	TransceiveVersion[2];		//  "HEX" --> HEX
	INT8S	ENVTemp;					// ab --> ab

	INT8U 	FwdInputAttn[2];			// 0.5dB [3G CASE 사용하지 않느다.
	INT8U	RvsInputAttn[2];			// 0.5dB [3G CASE 사용하지 않는다.]
	INT8S	FwdAttn[2];					// ab --> ab		// pcs
	INT8S	RvsAttn[2];					// ab --> ab		// pcs Main Attn
	INT8S	RvsAttnISO[2];				// ab --> ab		// Sub Attn
	INT16S	FwdRssi[2];					// ab --> ab

	INT16S	RvsRssi[2];					// ab --> ab
	INT16S	FwdPower[2];				// ab --> ab*10		// 2004-05-31 2:01오후
	INT16S	RvsPower[2];				// ab --> ab
	INT8U	IsolationLvl[2];			// ab --> ab
	INT8U	TxSWOnOff[2];				// ON : '1', OFF : '0'

	INT8U	RxSWOnOff[2];				// ON : '1', OFF : '0'
	INT8U	AGCOnOff[2];				// ON : '1', OFF : '0'
	INT8S	ALCOnOff[2];				// ON : '1', OFF : '0'
	INT8U	SDNOnOff[2];				// ON : '1', OFF : '0'
	INT8U	OSCOnOff;					// ON : '1', OFF : '0'

	type16	ALCPeriod[2];
	INT8U	ALCOffsetOnOff[2];	
	INT8U	TxRxOffsetOnOff[2];
	INT8U	Reserved7;

	INT8U	ISOOnOff[2];				// ON : '1', OFF : '0'(RECHECK)
	INT8U	SleepOnOff[2];				// ON : '1', OFF : '0'
	INT8S	FwdSDLimit[2];				// ab --> ab
	INT8S	RvsSDLimit[2];				// ab --> ab

	INT8S	FwdAGCLimit[2];				// ab --> ab		// fwd agc level
	INT8S	RvsAGCOffset[2];			// ab --> ab		// rvs agc offset
	INT8S	ALCUpperLmt[2];				// ab --> ab(0~10/20)		// pcs fwd alc high
	INT8S	ALCOffset[2];				// ab --> ab(-4~-10)		// pcs rvs alc low
	INT8S	OSCLimit[2];				// ab --> ab

	type16	AGCTime[2];					// ab --> ab/1sec
	INT8U	SleepChkTime[2];			// ab[sec] --> ab (10~120sec)
	INT8U	NoSleepTime[2];				// PCS Awake Time Sum
	INT8U	TypeSel[2];

	INT8U	TxRxFreqChannel;
	INT8U	iRemsStsCheck;				// '1': iRems 연동상태 Chek_ING, '0': off
	INT8U	iRemsNetCheck;
	INT8U	Reserved0[1];
	INT16S 	iRems_PSC_3G;
	INT8S	iRems_RSSI_3G;
	INT16S	iRems_ECIO_3G;				//x10
	INT8U	Reserved1[1];

	INT8U	ExtEquipSerial[10];
	INT8U	MyEquipSerial[10];
	
	INT8U	Reserved2[10];

////////////////////////////
// HIDDEN
////////////////////////////
	INT8U	TempAttnOnOff;				// ON : '1', OFF : '0'
	INT8U	FwdAttnSub[2];
	INT8U	RvsAttnSub[2];
	INT8U	OSCAttn[2];
	INT8U	TxPlatEq_4G;

	INT8U	RxPlatEq_4G;
//	INT8U	ALCInterLock;
	INT8S	TempOffset;
	INT16U 	SleepDect[2];

	type16	SleepLimit[2];
	INT32U	TxFrequency[2];		// ab --> ab
	INT16S	PLL_Temp[2];		// 1-> 50kHz
	type16	PLL_Offset[2];		// 1-> 50kHz

	INT8U	rFwdAttn1[2];		// fwd user Attn
	INT8U	rFwdAttn2[2];		// fwd sub Attn
	INT8U	rFwdAttn3[2];		// fwd in Attn
	INT8U	rRvsAttn1[2];		// Rvs user Attn
	INT8U	rRvsAttn2[2];		// Rvs sub Attn
	INT8U	rRvsAttn3[2];		// Rvs sub Attn

	INT8U 	InitIsoOnOff;
} MSTATUS;


//==================================
//	Main Control
//==================================
typedef struct {
	union {
		INT8U Data[10];	// 0 ~ 5 [STANDARD], 6~7 [HIDDEN/RESERVED]
		struct {
/////////////////////////////////////////////
			INT8U	TransceiveMaker		:1;
			INT8U	FwdInputAttn		:1;
			INT8U	FwdAttn				:1;
			INT8U	RvsAttn				:1;

			INT8U	RvsAttnISO			:1;
			INT8U						:3;

/////////////////////////////////////////////
			INT8U	TxSWOnOff			:1;
			INT8U	RxSWOnOff			:1;
			INT8U	AGCOnOff			:1;
			INT8U	ALCOnOff			:1;
			
			INT8U	SDNOnOff			:1;
			INT8U	OSCOnOff			:1;
			INT8U	ISOOnOff			:1;
			INT8U	SleepOnOff			:1;
			
/////////////////////////////////////////////
			INT8U	OperatingOnOff		:1;
			INT8U	FwdSDLimit			:1;
			INT8U	RvsSDLimit			:1;
			INT8U	FwdAGCLimit			:1;
			
			INT8U	RvsAGCOffset		:1;
			INT8U	ALCUpperLmt			:1;
			INT8U	ALCOffset			:1;
			INT8U	OSCLimit			:1;
			
/////////////////////////////////////////////
			INT8U	AGCTime				:1;
			INT8U	SleepChkTime		:1;
			INT8U	TypeSel				:1;
			INT8U	TxRxFreqChannel		:1;
			
			INT8U						:4;
/////////////////////////////////////////////
			INT8U	iRemsStsCheck		:1;
			INT8U	iRemsNetCheck		:1;
			INT8U	ALCPeriod			:1;
			INT8U						:1;
			
			INT8U						:4;
////////////////////////////////////////////
			INT8U	ALCOffsetOnOff		:1;
			INT8U	ExtEquipSerial		:1;
			INT8U   MyEquipSerial		:1;
			INT8U	TxRxOffsetOnOff		:1;
			
			INT8U						:4;
			
////////////////////////////////////////////
			////////////////////////////
			// HIDDEN
			////////////////////////////
			INT8U	TempAttnOnOff		:1;
			INT8U	FwdAttnSub			:1;	
			INT8U	RvsAttnSub			:1;
			INT8U						:1;
			
			INT8U	TempOffset			:1;
			INT8U	SleepLimit			:1;
			INT8U	PLL_Offset			:1;
			INT8U	InitIsoOnOff		:1;
////////////////////////////////////////////
			INT8U						:8;
		};
	} ControlFlag[2];					// YES : BIT SET, NO : BIT RESET

	INT8U	TransceiveMaker;			// ab --> ab*2		// 2011-12-21
	INT8U 	FwdInputAttn[2];			// 1dB
	INT8S	FwdAttn[2];					// ab --> ab		// pcs
	INT8S	RvsAttn[2];					// ab --> ab		// pcs Main Attn
	INT8S	RvsAttnISO[2];				// ab --> ab		// Sub Attn

	INT8U	TxSWOnOff[2];
	INT8U	RxSWOnOff[2];
	INT8U	AGCOnOff[2];					// ON : '1', OFF : '0'
	INT8S	ALCOnOff[2];					// ON : '1', OFF : '0'
	INT8U	SDNOnOff[2];					// ON : '1', OFF : '0'

	INT8U	OSCOnOff;					// ON : '1', OFF : '0'
	INT8U	ISOOnOff[2];				// ON : '1', OFF : '0'
	INT8U	SleepOnOff[2];				// ON : '1', OFF : '0'
	INT8S	FwdSDLimit[2];				// ab --> ab		// fwd sd limit

	INT8S	RvsSDLimit[2];
	INT8S	FwdAGCLimit[2];
	INT8S	RvsAGCOffset[2];
	INT8S	ALCUpperLmt[2];
	INT8S	ALCOffset[2];

	INT8S	OSCLimit[2];				
	type16	AGCTime[2];					
	INT8U	SleepChkTime[2];				
	INT8U	TypeSel[2];					// 0: LTE 10Mhz, 1: LTE_15MHz	2: LTE_20MHz

	INT8U	TxRxFreqChannel;
	INT8U	iRemsStsCheck;				// '1': iRems 연동상태 Chek_ING, '0': off
	INT8U	iRemsNetCheck;
	type16	ALCPeriod[2];
	
	INT8U	ExtEquipSerial[10];
	INT8U	MyEquipSerial[10];
	
	INT8U	ALCOffsetOnOff[2];	
	INT8U	TxRxOffsetOnOff[2];
	INT8U	Reserved2[8];

	/////////////////////////
	////////////////////////////
	// HIDDEN
	////////////////////////////
	INT8U	TempAttnOnOff;				// ON : '1', OFF : '0'
	INT8U	FwdAttnSub[2];	
	INT8U	RvsAttnSub[2];
//	INT8U	ALCInterLock;
	INT8S	TempOffset;

	type16	SleepLimit[2];
	type16	PLL_Offset[2];	// 1-> 50kHz
	INT8U 	InitIsoOnOff;

	INT8U	Reserved4[10];

} MCONTROL;

typedef struct{
	union {
		INT8U Data;
		struct{
			INT8U TxPlatEqTable_10M_4G	:1;
			INT8U RxPlatEqTable_10M_4G	:1; 
			INT8U TxPlatEqTable_15M_4G	:1; 
			INT8U RxPlatEqTable_15M_4G	:1;
			
			INT8U TxPlatEqTable_20M_4G	:1; 
			INT8U RxPlatEqTable_20M_4G	:1;
		};
	} ControlFlag;
		
	INT8S TxPlatEqTable_10M_4G[3][25];
	INT8S RxPlatEqTable_10M_4G[3][25]; 
	INT8S TxPlatEqTable_15M_4G[3][25]; 
	INT8S RxPlatEqTable_15M_4G[3][25]; 
	INT8S TxPlatEqTable_20M_4G[3][25]; 
	INT8S RxPlatEqTable_20M_4G[3][25]; 
} PCONTROL;

#define MRcode					0x01		// micro rptr

enum AlarmData
{
	Sleep_2G,
	Awake_2G,
	Sleep_3G,
	Awake_3G,
};

#pragma pack()

enum
{
	NMS_RESET_Bp = 0,
	ResetCountBp,
	ResetCountBp1,
	ResetOSC_Bp1,
	ResetOSC_Bp2,
	OSCAlarm_4GBp,
	OSCAlarm_3GBp,
	
};

#define RAMBACKUPADDR	(SRAM_BASE + (128*1024) - 50)

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

#ifdef	PROT_C
	INT8U *rambackup = (INT8U *)RAMBACKUPADDR;
	INT8U NmsResetCase;

	__OutputTable 		OutputTableB, 		*OutputTable 		= &OutputTableB;
	__AttnOffsetTable 	AttnOffsetTableB, 	*AttnOffsetTable 	= &AttnOffsetTableB;
	__AttnTempTable 	AttnTempTableB, 	*AttnTempTable 		= &AttnTempTableB;

#else
	extern INT8U *rambackup;
	extern INT8U NmsResetCase;

	extern __OutputTable		*OutputTable;
	extern __AttnOffsetTable	*AttnOffsetTable;
	extern __AttnTempTable		*AttnTempTable;


#endif
///////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Prototype Declaration
///////////////////////////////
void Initialize(void);

INT8U SearchWord(INT8U IsDec,INT8U nLen,INT16U SearchVal, INT16U *Buff);
 
void LoadBackupData(void);
void DefaultBackup(INT8U isInit);
void DefaultFirstBackup(EE_BACK1 *tptr);
void StatusInitialize(void);


INT8U SetCtrlData(INT16U AID_Command, INT8U *AID_Value, INT8U Length,INT8U Ctrl1, __ProtocolPtr *nPtr);
void SaveBackupData(void);
INT8U AnalyzeAidData(__ProtocolPtr *nPtr, INT8U Ctrl);
INT16U GenDnrAidSts(INT8U *dptr, __Dnr_Sts *Sts,__ProtocolPtr *nPtr );
INT8U ISAscII(INT8U Data);


INT16U GenAidData(INT16U Aid, INT8U *dptr, INT8U *sptr, INT16U len);
INT16U GenAidData16(INT16U Aid, INT8U *dptr, INT16U sptr, INT16U len);

#pragma pack()
////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////



