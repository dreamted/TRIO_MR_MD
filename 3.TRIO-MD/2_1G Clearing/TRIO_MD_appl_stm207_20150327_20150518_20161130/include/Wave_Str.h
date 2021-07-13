#pragma pack(1)

typedef   struct {
	// 알람 발생
	union {
		INT8U Data;
		struct {
				INT8U Sp2					:1;
//				INT8U AdjLowLimitAlarm		:1;
//				INT8U AdjHiLimitAlarm		:1;
				INT8U 						:2;

				INT8U TxLowLimitAlarm		:1;
				INT8U TxHiLimitAlarm		:1;
				INT8U RxLowLimitAlarm		:1;
				INT8U RxHiLimitAlarm		:1;
				INT8U Sp1					:1;
		};
	} RxTxAlarm;

	union {
		INT8U Data;
		struct {
			INT8U Sp2					:1;
			INT8U EcIo_6th				:1;
			INT8U EcIo_5th				:1;
			INT8U EcIo_4th				:1;
			INT8U EcIo_3th				:1;
			INT8U EcIo_2nd				:1;
			INT8U EcIo_1st				:1;
			INT8U Sp1					:1;
		};
	} EcIo;
} _RadioAlarm;



typedef struct {	
	INT8S RxMaxVal[2];				// 0x0C03
	INT8S RxMinVal[2];				// 0x0C04
	INT8S TxMaxVal[2];				// 0x0C05
	INT8S TxMinVal[2];				// 0x0C06
//	INT8U AdjMaxVal[2];				// 0x0C07
//	INT8U AdjMinVal[2];				// 0x0C08
	INT8U EcIo;						// 0x0C09
	INT8U AR_Mode[2];				// 0x0C11
	INT8U Radio_ReportTime[2];		// 0x0C12
	INT8U Radio_ReportPeriod[2];	// 0x0C13
	INT8U TestStn[11];				// 0x0C14
}_WaveCtrl;


typedef struct {	
//	INT8U FAAdjVal[2];				// 0x0C0B
	INT8U FAFerVal;					// 0x0C0C
}_WaveNormalStatus;

typedef struct {
	INT8U SMS_TxRetry;				// 0x0C00
	INT8U ActChannel[2];			// 0x0C01
	INT8U OneFAStatus;				// 0x0C02
	INT8U FARxVal[2];				// 0x0C0A
	INT8U PN_Val[12];				// 0x0C0D
	INT8U EcIo_Val[6];				// 0x0C0E
//	INT8U Tx_Val[2];				// 0x0C17

///////////////////////WCDMA
	INT8U TxVal[2];					// 0x0C17
	INT8U WcdmaChannel[3]; 			// 0x0C18

////////////////////////////////
	_WaveNormalStatus		WaveNormalStatus;
	INT8U PresentHour;				// 0x092E
	INT8U PresentMin;				// 0x092E
} _WaveSts;

#pragma pack()
////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

