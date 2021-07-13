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

	__FilterTable 		FilterTableB, 		*FilterTable		= &FilterTableB;


#else
	extern INT8U *rambackup;
	extern INT8U NmsResetCase;

	extern __OutputTable		*OutputTable;
	extern __AttnOffsetTable	*AttnOffsetTable;
	extern __AttnTempTable		*AttnTempTable;

	extern __FilterTable		*FilterTable;

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
INT8U AnalyzeAidData(__ProtocolPtr *nPtr, INT8U Ctrl);
INT16U GenDnrAidSts(INT8U *dptr, __Dnr_Sts *Sts,__ProtocolPtr *nPtr );
INT8U ISAscII(INT8U Data);


INT16U GenAidData(INT16U Aid, INT8U *dptr, INT8U *sptr, INT16U len);
INT16U GenAidData16(INT16U Aid, INT8U *dptr, INT16U sptr, INT16U len);
INT16U GenAidData32(INT16U Aid, INT8U *dptr, INT32U *sptr, INT16U len);

INT16U GenAidData32Bit(INT16U Aid, INT8U *dptr, INT32U sptr, INT16U len);
INT16U GenAidData16Bit(INT16U Aid, INT8U *dptr, INT16U *sptr, INT16U len);


#pragma pack()
////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////



