
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
	//#define NO_ISO
	//#define ISO_NOT_ENUGH
	//#define NO_OSC
////////////////////////////////////////////////////////////////////////////////
#ifdef EXPIO_C
	#define _USR_EXT_EXPIO
#else
	#define _USR_EXT_EXPIO	extern
#endif

_USR_EXT_EXPIO _PCA9555Reg AttnCS0Val;
_USR_EXT_EXPIO _PCA9555Reg AttnCS1Val;


#define Attn_CS0 0x00

	#define Attn_CS0_SEL0	1		// port 0
		#define AttnCS0_SEL0				((Attn_CS0_SEL0*8) * 8 + Attn_CS0)

		#define Fwd_Att1_LTE_A2_0		((Attn_CS0_SEL0*8 + 0) * 8 + Attn_CS0) ////// 
		#define Fwd_Att2_LTE_A2_0		((Attn_CS0_SEL0*8 + 1) * 8 + Attn_CS0) 
		#define Fwd_Att1_WCDMA			((Attn_CS0_SEL0*8 + 2) * 8 + Attn_CS0) 
		#define Fwd_Att2_WCDMA			((Attn_CS0_SEL0*8 + 3) * 8 + Attn_CS0) 
		#define Rvs_Att1_LTE_A2_0		((Attn_CS0_SEL0*8 + 4) * 8 + Attn_CS0)
		#define Rvs_Att2_LTE_A2_0		((Attn_CS0_SEL0*8 + 5) * 8 + Attn_CS0)
		#define Rvs_Att3_LTE_A2_0		((Attn_CS0_SEL0*8 + 6) * 8 + Attn_CS0)
		#define Rvs_Att4_LTE_A2_0		((Attn_CS0_SEL0*8 + 7) * 8 + Attn_CS0)



	#define Attn_CS0_SEL1 0		// port 1
		#define AttnCS0_SEL1			((Attn_CS0_SEL1*8) * 8 + Attn_CS0) 

		#define Rvs_BalanceAtt_LTE_A2	((Attn_CS0_SEL1*8 + 0) * 8 + Attn_CS0) 
		#define Rvs_Att1_WCDMA			((Attn_CS0_SEL1*8 + 1) * 8 + Attn_CS0) 
		#define Rvs_Att2_WCDMA			((Attn_CS0_SEL1*8 + 2) * 8 + Attn_CS0) 
		#define Rvs_Att3_WCDMA			((Attn_CS0_SEL1*8 + 3) * 8 + Attn_CS0) 
		#define Rvs_Att4_WCDMA			((Attn_CS0_SEL1*8 + 4) * 8 + Attn_CS0) 
		#define Rvs_BalanceAtt_WCDMA	((Attn_CS0_SEL1*8 + 5) * 8 + Attn_CS0) 
		#define SP_EN1					((Attn_CS0_SEL1*8 + 7) * 8 + Attn_CS0) 



#define Attn_CS1 0x01 
		
	#define Attn_CS1_SEL0	1		// port 0
		#define AttnCS1_SEL0			((Attn_CS1_SEL0*8) * 8 + Attn_CS1)


		#define Fwd_Att1_CDMALTE		((Attn_CS1_SEL0*8 + 0) * 8 + Attn_CS1)
		#define Fwd_Att1_CDMA			((Attn_CS1_SEL0*8 + 1) * 8 + Attn_CS1)
		#define Fwd_Att1_LTE_0			((Attn_CS1_SEL0*8 + 2) * 8 + Attn_CS1)
		#define Rvs_Att1_CDMALTE		((Attn_CS1_SEL0*8 + 3) * 8 + Attn_CS1) 
		#define Rvs_Att1_CDMA			((Attn_CS1_SEL0*8 + 4) * 8 + Attn_CS1) 
		#define Rvs_Att2_CDMA			((Attn_CS1_SEL0*8 + 5) * 8 + Attn_CS1) 
		#define Rvs_Att3_CDMA			((Attn_CS1_SEL0*8 + 6) * 8 + Attn_CS1) 
		#define Rvs_Att1_LTE_0			((Attn_CS1_SEL0*8 + 7) * 8 + Attn_CS1) 


		
		
	#define Attn_CS1_SEL1 0		// port 1
		#define AttnCS1_SEL1			((Attn_CS1_SEL1*8) * 8 + Attn_CS1) 

		#define Rvs_Att2_LTE_0			((Attn_CS1_SEL1*8 + 0) * 8 + Attn_CS1) 
		#define Rvs_Att3_LTE_0			((Attn_CS1_SEL1*8 + 1) * 8 + Attn_CS1) 
		#define Rvs_BalanceAtt_CDMALTE	((Attn_CS1_SEL1*8 + 2) * 8 + Attn_CS1) 
		#define SP_EN2					((Attn_CS1_SEL1*8 + 7) * 8 + Attn_CS1) 



#define RedLED_CDMA					GPIOD->__B.ODR.B3
#define GreenLED_CDMA				GPIOD->__B.ODR.B4
#define RedLED_LTE					GPIOD->__B.ODR.B5
#define GreenLED_LTE				GPIOD->__B.ODR.B6
#define GreenLED_LTE_A2_0			GPIOD->__B.ODR.B0
#define RedLED_LTE_A2_0				GPIOD->__B.ODR.B1
#define RedLED_WCDMA				GPIOD->__B.ODR.B7
#define GreenLED_WCDMA				GPIOA->__B.ODR.B14

#define PLLAlarm_WCDMA				GPIOA->__B.IDR.B12
		
#define _PCA9555_CLK 				GPIOB->__B.ODR.B7
#define _PCA9555_DATA				GPIOB->__B.ODR.B4

#define PLL_CLK						GPIOB->__B.ODR.B7
#define PLL_DATA					GPIOB->__B.ODR.B4
		
		
#define PLLAlarm_CDMALTE			GPIOB->__B.IDR.B12	
#define AC_Alarm					GPIOB->__B.IDR.B14
		
#define DC_OnOff					GPIOC->__B.ODR.B9
		
#define AmpOnOff_LTE_A2_0			GPIOD->__B.ODR.B8
#define AmpOnOff_WCDMA				GPIOD->__B.ODR.B9
#define PLLAlarm_LTE_A2_0			GPIOD->__B.IDR.B15
		
#define S_DATA						GPIOE->__B.ODR.B2

#define ADC_Sel0					GPIOE->__B.ODR.B4
#define ADC_Sel1					GPIOE->__B.ODR.B5

#define _ATTN_CLK					GPIOE->__B.ODR.B8
#define _ATTN_DATA					GPIOE->__B.ODR.B7

#define PLLEN_LTE 					GPIOB->__B.ODR.B8
#define PLLEN_LTE_A2 				GPIOC->__B.ODR.B6
#define PLLEN_LTE_A2_1 				GPIOA->__B.ODR.B13

#define RRTYPE						GPIOC->__B.IDR.B7
#define SMS_PWR						GPIOE->__B.ODR.B11

#define SMS_VCC_ONOFF				GPIOE->__B.ODR.B11



#define AmpOnOff_CDMA				GPIOE->__B.ODR.B12
#define AmpOnOff_LTE_0				GPIOE->__B.ODR.B13
#if 0
#define Rvs_TurnOn_CDMA 			GPIOB->__B.IDR.B13
#define Rvs_TurnOn_LTE				GPIOE->__B.IDR.B9
#define Rvs_TurnOn_LTE_A2			GPIOE->__B.IDR.B10
#define Rvs_TurnOn_WCDMA			GPIOE->__B.IDR.B6
#endif

////////////////////////////////////////////////////////////////////////////////
// RIGHT

enum {
	__index_TxUsrAttn_4G,
	__Index_TxSubAttn_4G,
	__Index_TxInAttn_4G,
	__index_RxUsrAttn_4G,
	__Index_RxSubAttn_4G,

	__index_TxUsrAttn_3G,
	__Index_TxSubAttn_3G,
	__Index_TxInAttn_3G,
	__index_RxUsrAttn_3G,
	__Index_RxSubAttn_3G,

};

#define FREQOFFSET	 	-295000000L
#define FREQMIN_10M_4G 	1810000000L 
#define FREQMIN_15M_4G 	1812500000L 
#define FREQMIN_20M_4G 	1815000000L 
#define FREQMIN_BYPSS	1850000000L 
//
#define FREQ_3G			2040000000L




enum {
	_FwdAttn1_2G_SEL = 0x00,	
	_RvsAttn1_2G_SEL,
	_RvsAttn2_2G_SEL,	
	_RvsAttn3_2G_SEL,
	
	_FwdAttn1_LTE_SEL,	
	_RvsAttn1_LTE_SEL,	
	_RvsAttn2_LTE_SEL,	
	_RvsAttn3_LTE_SEL,	
	
	_FwdAttn1_Common_SEL,	
	_RvsAttn1_Common_SEL,	

	_FwdAttn1_LTE_A2_SEL, 
	_FwdAttn2_LTE_A2_SEL, 
	_RvsAttn1_LTE_A2_SEL, 
	_RvsAttn2_LTE_A2_SEL, 
	_RvsAttn3_LTE_A2_SEL, 
	_RvsAttn4_LTE_A2_SEL, 
	
	_FwdAttn1_3G_SEL,	
	_FwdAttn2_3G_SEL,	
	_RvsAttn1_3G_SEL,	
	_RvsAttn2_3G_SEL,	
	_RvsAttn3_3G_SEL,	
	_RvsAttn4_3G_SEL,
	_RvsAttn5_3G_SEL,

	_RvsBalanceAtt_2G_SEL,
	_RvsBalanceAtt_3G_SEL,
	_RvsBalanceAtt_LTEA_SEL,
	
	Att_SelMax
};





////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
#ifdef EXPIO_C
////////////////////
	#define EXPIO_START_STK_SIZE	(128*3)
	
	static OS_STK ExpioTaskStk[EXPIO_START_STK_SIZE] @ "iram";
	OS_EVENT *ExpioSem = NULL;
	OS_EVENT *ExpSem = NULL;
	
	INT8S	tempIndexHys = 0;

	INT8U CurrFwdAttn1_2G = 0xff;
	INT8U CurrRvsAttn1_2G = 0xff;
	INT8U CurrRvsAttn2_2G = 0xff;
	INT8U CurrRvsAttn3_2G = 0xff;
	INT8U CurrFwdAttn1_LTE = 0xff;
	INT8U CurrRvsAttn1_LTE = 0xff;
	INT8U CurrRvsAttn2_LTE = 0xff;
	INT8U CurrRvsAttn3_LTE = 0xff;

	INT8U CurrFwdAttn1_CDMALTE = 0xff;	
	INT8U CurrRvsAttn1_CDMALTE = 0xff;	
	INT8U CurrFwdAttn1_LTE_A2 = 0xff; 
	INT8U CurrFwdAttn2_LTE_A2 = 0xff; 
	INT8U CurrRvsAttn1_LTE_A2 = 0xff; 
	INT8U CurrRvsAttn2_LTE_A2 = 0xff; 
	INT8U CurrRvsAttn3_LTE_A2 = 0xff; 
	INT8U CurrRvsAttn4_LTE_A2 = 0xff; 


	INT8U CurrFwdAttn1_3G = 0xff;	
	INT8U CurrFwdAttn2_3G = 0xff;	
	INT8U CurrRvsAttn1_3G = 0xff;	
	INT8U CurrRvsAttn2_3G = 0xff;	
	INT8U CurrRvsAttn3_3G = 0xff;	
	INT8U CurrRvsAttn4_3G = 0xff;	

	INT8U CurrRvsBalanceAtt_2G = 0xff;	
	INT8U CurrRvsBalanceAtt_3G = 0xff;	
	INT8U CurrRvsBalanceAtt_LTEA = 0xff;	

	INT8U ResetCnt = 0;
	INT8U Chk_Reset = 0;
	INT8U Chk_Factory_default = 0;

	INT8U iResetCnt = 0;
	INT8U PeriodCnt = 0;
	INT8U ChkAttChange = 0;

	INT8U ChkBandSelet= SET;
	INT32U iBand_Freq = 0;

	INT8U ChkPllFregOffset_LTE = 0;

	INT8U	Pre_AC_Sts = 0;
	INT8U	SetAcRecovery = 0;

	INT8U SetSMS_PWR = 0;	


/////////////////////////////////////////////////
	INT8U FirstPNCheckFlag = FALSE;

	INT8U ChkTableAlarm = 1;
	INT8U PwrTblAlarm[Local_PwrSts_Max]= {0,};

	INT8U AttnTblAlarm[Local_AttnSts_Max]= {0,};

	INT32U TimePeriodElased = 0;
	INT8U FirstCheckFlag = FALSE;

	INT8U RvsOverInAlarmCnt = 0;
	INT8U RvsOtherOverInAlarmCnt = 0;

	INT8U ChkRvsOtherOverInAlarm = 0;


	INT8U AlarmCheck_2G = 0;
	INT8U AlarmCheck_LTE = 0;
	INT8U AlarmCheck_LTE_A2 = 0;

	INT8U ACFailCnt = 0;
	INT8U ChkRvsOverInAlarm = 0;

	
	INT32U CurrLOFREQ_LTE = 0xffffffff;

	

	INT8U tAGC10_ATTENMAX_3G 	= 0;
	INT8U tAGC_ATTENMAX_2G 		= 0;
	INT8U tAGC_ATTENMAX_LTE 	= 0;
	INT8U tAGC_ATTENMAX_LTE_A2 	= 0;
	INT8U tALC_ATTENMAX_2G 		= 0;
	INT8U tALC_ATTENMAX_LTE 	= 0;

	
	INT8U Chk_RvsOSCAlarmCount = 0;
////////////////////////////////////////////////////////////////////////////////
#else
///////////////////////////
	extern OS_EVENT *ExpioSem;
	extern OS_EVENT *ExpSem;

	extern INT8S tempIndexHys;
	extern INT8U SleepTempOffset;

	extern INT8U ResetCnt;
	extern INT8U Chk_Reset;
	extern INT8U Chk_Factory_default;

	extern INT8U ChkAttChange;
	extern INT8U ChkBandSelet;
	extern INT8U ChkPllFregOffset_LTE;

	extern INT32U iBand_Freq;
	extern INT8U Pre_AC_Sts;
	extern INT8U SetAcRecovery;

	extern INT8U SetSMS_PWR;

	extern INT8U PeriodCnt;

	extern INT8U FirstPNCheckFlag;
	extern INT8U ChkTableAlarm;
	extern INT8U PwrTblAlarm[Local_PwrSts_Max];
	extern INT8U AttnTblAlarm[Local_AttnSts_Max];


	extern INT8U AlarmCheck_2G;
	extern INT8U AlarmCheck_LTE;
	extern INT8U AlarmCheck_LTE_A2;

	extern INT8U ACFailCnt;
	extern INT32U TimePeriodElased;
	extern INT8U FirstCheckFlag;

	extern INT8U CurrFwdAttn1_2G;
	extern INT8U CurrRvsAttn1_2G;
	extern INT8U CurrRvsAttn2_2G;
	extern INT8U CurrRvsAttn3_2G;
	extern INT8U CurrFwdAttn1_LTE;
	extern INT8U CurrRvsAttn1_LTE;
	extern INT8U CurrRvsAttn2_LTE;
	extern INT8U CurrRvsAttn3_LTE;

	extern INT8U CurrFwdAttn1_CDMALTE;	
	extern INT8U CurrRvsAttn1_CDMALTE;	
	extern INT8U CurrFwdAttn1_LTE_A2; 
	extern INT8U CurrFwdAttn2_LTE_A2; 
	extern INT8U CurrRvsAttn1_LTE_A2; 
	extern INT8U CurrRvsAttn2_LTE_A2; 
	extern INT8U CurrRvsAttn3_LTE_A2; 
	extern INT8U CurrRvsAttn4_LTE_A2; 


	extern INT8U CurrFwdAttn1_3G;	
	extern INT8U CurrFwdAttn2_3G;	
	extern INT8U CurrRvsAttn1_3G;	
	extern INT8U CurrRvsAttn2_3G;	
	extern INT8U CurrRvsAttn3_3G;	
	extern INT8U CurrRvsAttn4_3G;	
	extern INT8U CurrRvsAttn5_3G;

	extern INT8U CurrRvsBalanceAtt_2G;	
	extern INT8U CurrRvsBalanceAtt_3G;	
	extern INT8U CurrRvsBalanceAtt_LTEA;	

	extern INT8U Chk_RvsOSCAlarmCount;
////////////////////////////////////////////////////////////////////////////////
#endif

_USR_EXT_EXPIO  INT8S tmpRvsAttn1_2G;

_USR_EXT_EXPIO INT8U CurrLTE15MUse; 
_USR_EXT_EXPIO INT8U CurrModemOnOff; 
_USR_EXT_EXPIO INT8U CurrACFail; 
_USR_EXT_EXPIO INT8U CurrRvsOverInAlarm; 
_USR_EXT_EXPIO INT8U CurrRvsOtherOverInAlarm; 
_USR_EXT_EXPIO INT8S dptr[10];



	
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

void ExpioInit(void);
void ExpioPortInit(void);

void ExpioTask(void *p_arg);
void AlarmCheck(void);

void StatusUpdate(void);
void AlarmStatusUpdate(void);
void StatustoIO(void);

void AttnBufferInit(void);
void OperatingFunc(void);

INT8U MaxAttnCheck(INT16S cAttn, INT16S tMax);

void ResetStart(INT32U tms);

BOOL AlarmCntFunc(INT8U *Cnt, INT8U Num);
///////////////////////////////////////////////
INT8S MinMaxAttnCheck(INT16S cAttn, INT16S tMax, INT16S tMin);
INT16S GainAttnCalculation(INT16S cGain, INT16S cGainMax,INT8S cAttMin);


///////////////////////////////////
void Period_Check(void);


void AttnDataOutput(unsigned short int Sel, unsigned char Data);
void ADC_Select(INT8U Index);
void pPCA9555Port_Init(INT8U tIndex);
void FrontLEDSet(INT8U tindex, INT8U tstatus);

void TimerRelatedOperation(void);
void TRIO_AlarmCheck(void);

INT8S RetPower(INT8S *tmp);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

