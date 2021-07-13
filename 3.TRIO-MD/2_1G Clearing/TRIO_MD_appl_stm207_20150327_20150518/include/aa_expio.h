
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
		#define AttnCS0_SEL0			((Attn_CS0_SEL0*8) * 8 + Attn_CS0)

		#define Fwd_Att1_CDMALTE		((Attn_CS0_SEL0*8 + 0) * 8 + Attn_CS0) ////// 
		#define Rvs_Att1_CDMALTE		((Attn_CS0_SEL0*8 + 1) * 8 + Attn_CS0) 
		#define Rvs_Att2_CDMALTE		((Attn_CS0_SEL0*8 + 2) * 8 + Attn_CS0) 
		#define Rvs_Att3_CDMALTE		((Attn_CS0_SEL0*8 + 3) * 8 + Attn_CS0) 
		#define Fwd_Att1_LTEA			((Attn_CS0_SEL0*8 + 4) * 8 + Attn_CS0)
		#define Rvs_Att1_LTEA			((Attn_CS0_SEL0*8 + 5) * 8 + Attn_CS0)
		#define Rvs_Att2_LTEA			((Attn_CS0_SEL0*8 + 6) * 8 + Attn_CS0)
		#define Rvs_Att3_LTEA			((Attn_CS0_SEL0*8 + 7) * 8 + Attn_CS0)

	#define Attn_CS0_SEL1 0		// port 1
		#define AttnCS0_SEL1			((Attn_CS0_SEL1*8) * 8 + Attn_CS0) 

		#define Fwd_Att1_WCDMA			((Attn_CS0_SEL1*8 + 0) * 8 + Attn_CS0) 
		#define Rvs_Att1_WCDMA			((Attn_CS0_SEL1*8 + 1) * 8 + Attn_CS0) 
		#define Rvs_Att2_WCDMA			((Attn_CS0_SEL1*8 + 2) * 8 + Attn_CS0) 
		#define Rvs_Att3_WCDMA			((Attn_CS0_SEL1*8 + 3) * 8 + Attn_CS0) 

		#define SP_EN1					((Attn_CS0_SEL1*8 + 7) * 8 + Attn_CS0) 

#define Attn_CS1 0x01 
		
	#define Attn_CS1_SEL0	1		// port 0
		#define AttnCS1_SEL0			((Attn_CS1_SEL0*8) * 8 + Attn_CS1)

		#define RedLED_CDMA				((Attn_CS1_SEL0*8 + 0) * 8 + Attn_CS1)
		#define GreenLED_CDMA			((Attn_CS1_SEL0*8 + 1) * 8 + Attn_CS1)
		#define RedLED_LTE				((Attn_CS1_SEL0*8 + 2) * 8 + Attn_CS1)
		#define GreenLED_LTE			((Attn_CS1_SEL0*8 + 3) * 8 + Attn_CS1) 
		#define RedLED_LTE_21			((Attn_CS1_SEL0*8 + 4) * 8 + Attn_CS1) /////WCDMA
		#define GreenLED_LTE_21			((Attn_CS1_SEL0*8 + 5) * 8 + Attn_CS1) /////WCDMA
		#define RedLED_LTE_A2			((Attn_CS1_SEL0*8 + 6) * 8 + Attn_CS1) 
		#define GreenLED_LTE_A2			((Attn_CS1_SEL0*8 + 7) * 8 + Attn_CS1) 

	#define Attn_CS1_SEL1 0		// port 1
		#define AttnCS1_SEL1			((Attn_CS1_SEL1*8) * 8 + Attn_CS1) 

		#define Fwd_PLLEN_LTE			((Attn_CS1_SEL1*8 + 0) * 8 + Attn_CS1) 
		#define Rvs_PLLEN_LTE			((Attn_CS1_SEL1*8 + 1) * 8 + Attn_CS1) 
		#define PLLEN_LTE_A				((Attn_CS1_SEL1*8 + 2) * 8 + Attn_CS1) 

		#define Fwd_PLLEN_WCDMA			((Attn_CS1_SEL1*8 + 3) * 8 + Attn_CS1) 
		#define RVS_PLLEN_WCDMA			((Attn_CS1_SEL1*8 + 4) * 8 + Attn_CS1) 

		#define RedLED_WCDMA			((Attn_CS1_SEL1*8 + 5) * 8 + Attn_CS1) 
		#define GreenLED_WCDMA			((Attn_CS1_SEL1*8 + 6) * 8 + Attn_CS1) 
		#define SP_EN2					((Attn_CS1_SEL1*8 + 7) * 8 + Attn_CS1) 


#define DL_AmpOnOff_CDMALTE			GPIOF->__B.ODR.B6
#define UL_AmpOnOff_CDMALTE			GPIOF->__B.ODR.B7

#define DL_AmpOnOff_LTEA			GPIOF->__B.ODR.B8
#define UL_AmpOnOff_LTEA			GPIOF->__B.ODR.B9

#define DL_AmpOnOff_WCDMA			GPIOF->__B.ODR.B10
#define UL_AmpOnOff_WCDMA			GPIOF->__B.ODR.B11

#define ADC_Sel0					GPIOB->__B.ODR.B14
#define ADC_Sel1					GPIOB->__B.ODR.B15
#define SMS_PWR						GPIOG->__B.ODR.B7
#define SMS_VCC_ONOFF				GPIOG->__B.ODR.B7
#define AC_Alarm					GPIOG->__B.IDR.B6


#define PLLAlarm_CDMALTE			GPIOC->__B.IDR.B6
#define PLLAlarm_WCDMA				GPIOC->__B.IDR.B7
#define PLLAlarm_LTE_A2				GPIOC->__B.IDR.B8

#define _ATTN_CLK					GPIOE->__B.ODR.B2
#define _ATTN_DATA					GPIOE->__B.ODR.B6

#define _I2C_CLK 					GPIOA->__B.ODR.B8
#define _I2C_DATA					GPIOC->__B.ODR.B9
#define _I2C_DATA_Read				GPIOC->__B.IDR.B9

#define _PCA9555_CLK 				GPIOG->__B.ODR.B12
#define _PCA9555_DATA				GPIOG->__B.ODR.B15
#define _PCA9555_DATA_Read			GPIOG->__B.IDR.B15

#define PLL_CLK						GPIOA->__B.ODR.B15
#define PLL_DATA					GPIOB->__B.ODR.B3


#define F_PROG						GPIOC->__B.ODR.B14

#define _nFPGA_CONF_PROG			GPIOC->__B.ODR.B14
#define _nFPGA_CONF_DONE			GPIOC->__B.IDR.B15

#define F_DONE						GPIOC->__B.IDR.B15

#define _nRCU_RST					GPIOA->__B.ODR.B13
#define _MBD_RST					GPIOA->__B.ODR.B13
#define _nFPGA_RESET				GPIOA->__B.ODR.B13

#define _DTU_RW						GPIOG->__B.ODR.B13
#define _DTU_ALE					GPIOG->__B.ODR.B14
#define _RCPU_RWn					GPIOG->__B.ODR.B13
#define _RCPU_ALE					GPIOG->__B.ODR.B14

#define _DTU_CS0					GPIOG->__B.ODR.B11
#define _DTU_CS1					GPIOB->__B.IDR.B8

#define _DTU_Insert1				GPIOB->__B.IDR.B8

#define _DTU_Insert					GPIOA->__B.IDR.B12  //// 실제 사용 

#define _RF_Module_Insert			GPIOG->__B.ODR.B12
#define _Ext_Module_Insert			GPIOG->__B.ODR.B15


#define _nFLASH_nCS1				GPIOB->__B.ODR.B12   /// SPI2_NSS  내부 
#define _nFPGA_nCS0					GPIOA->__B.ODR.B4    /// SPI1_NSS  외부 



#define _DTU_SEL0					GPIOB->__B.ODR.B4
#define _DTU_SEL1					GPIOB->__B.ODR.B5


#if 1
#define _AD9528_SPI_TX_nCS				GPIOB->__B.ODR.B5
#define _ADC9368_SPI_RX_nCS				GPIOB->__B.ODR.B6
#define _ADC9652_SPI_TX_nCS				GPIOB->__B.ODR.B8

#define _SPI_CLK					GPIOB->__B.ODR.B13
#define _SPI_MISO					GPIOB->__B.ODR.B14
#define _SPI_MOSI					GPIOB->__B.ODR.B15

#endif

#if 0
#define _3G_SPI_TX_nCS				GPIOB->__B.ODR.B5
#define _3G_SPI_RX_nCS				GPIOB->__B.ODR.B6
#define _4G_SPI_TX_nCS				GPIOB->__B.ODR.B8
#define _4G_SPI_RX_nCS				GPIOB->__B.ODR.B9

#define _FPGA_SPI_RX_nCS			GPIOB->__B.ODR.B12


#endif


#define GreenLEDSet_CDMA(); 			PCA9555BitSet(GreenLED_CDMA,  &AttnCS1Val);
#define GreenLEDRst_CDMA(); 			PCA9555BitRst(GreenLED_CDMA,  &AttnCS1Val);


////////////////////////////////////////////////////////////////////////////////
// RIGHT

#define DL_FREQ_800M		876500L
#define UL_FREQ_800M		831500L

#define DL_VCO_800M			-157500L
#define UL_VCO_800M		 	 287500L

#if 0
#define DL_FREQ_1800M		1819250L
#define UL_FREQ_1800M		1724250L
#endif

#if 1
#define DL_FREQ_1800M		1814000L
#define UL_FREQ_1800M		1719000L
#endif


#define DL_VCO_1800M_Mode0		242500L
#define DL_VCO_1800M_Mode1		247750L

#define UL_VCO_1800M		242500L

#define DL_FREQ_2100M		2124600L
#define UL_FREQ_2100M		1934600L
#define DL_VCO_2100M		-152400L
#define UL_VCO_2100M		 437600L

#define UL_VCO_2100M_Test	 467600L


enum {
	_FwdAttn1_CDMALTE_SEL = 0x00,	
	_RvsAttn1_CDMALTE_SEL,
	_RvsAttn2_CDMALTE_SEL,	
	_RvsAttn3_CDMALTE_SEL,
	
	_FwdAttn1_LTEA_SEL,	
	_RvsAttn1_LTEA_SEL,	
	_RvsAttn2_LTEA_SEL,	
	_RvsAttn3_LTEA_SEL,	
	
	_FwdAttn1_WCDMALTE_21_SEL,	
	_RvsAttn1_WCDMALTE_21_SEL,	
	_RvsAttn2_WCDMALTE_21_SEL,	
	_RvsAttn3_WCDMALTE_21_SEL,	


	Att_SelMax
};


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////

//#define	ISOSampleMax			8
//#define	ISOSampleMax			12

#define	ISOSampleMax				30


////////////////////////////////////////////////////////////////////////////////
#ifdef EXPIO_C
////////////////////
	#define EXPIO_START_STK_SIZE	(128*3)
	
	static OS_STK ExpioTaskStk[EXPIO_START_STK_SIZE] @ "iram";
	OS_EVENT *ExpioSem = NULL;
	OS_EVENT *ExpSem = NULL;
	
	INT8S	tempIndexHys = 0;

	INT8U CurrFwdAttn1_2G			= 0xff;
	INT8U CurrFwdAttn2_2G			= 0xff;
	INT8U CurrRvsAttn1_2G			= 0xff;
	INT8U CurrRvsAttn2_2G			= 0xff;
	INT8U CurrFwdAttn1_LTE			= 0xff;
	INT8U CurrFwdAttn2_LTE			= 0xff;
	INT8U CurrRvsAttn1_LTE			= 0xff;
	INT8U CurrRvsAttn2_LTE			= 0xff;
	INT8U CurrFwdAttn1_CDMALTE		= 0xff; 
	INT8U CurrRvsAttn1_CDMALTE		= 0xff; 
	INT8U CurrRvsAttn2_CDMALTE		= 0xff; 
	INT8U CurrRvsAttn3_CDMALTE		= 0xff; 
	INT8U CurrFwdAttn1_LTE_A2		= 0xff; 
	INT8U CurrFwdAttn2_LTE_A2		= 0xff; 
	INT8U CurrRvsAttn1_LTE_A2		= 0xff; 
	INT8U CurrRvsAttn2_LTE_A2		= 0xff; 

	INT8U CurrFwdAttn1_LTE_A1		= 0xff; 
	INT8U CurrFwdAttn2_LTE_A1		= 0xff; 
	INT8U CurrRvsAttn1_LTE_A1		= 0xff; 
	INT8U CurrRvsAttn2_LTE_A1		= 0xff; 

	INT8U CurrFwdAttn1_LTEA			= 0xff; 
	INT8U CurrRvsAttn1_LTEA			= 0xff; 
	INT8U CurrRvsAttn2_LTEA			= 0xff; 
	INT8U CurrRvsAttn3_LTEA			= 0xff; 

	INT8U CurrFwdAttn1_3G			= 0xff; 
	INT8U CurrFwdAttn2_3G			= 0xff; 
	INT8U CurrRvsAttn1_3G			= 0xff; 
	INT8U CurrRvsAttn2_3G			= 0xff; 
	INT8U CurrFwdAttn1_LTE_21		= 0xff; 
	INT8U CurrFwdAttn2_LTE_21		= 0xff; 
	INT8U CurrRvsAttn1_LTE_21		= 0xff; 
	INT8U CurrRvsAttn2_LTE_21		= 0xff; 
	INT8U CurrFwdAttn1_WCDMALTE_21	= 0xff; 
	INT8U CurrRvsAttn1_WCDMALTE_21	= 0xff; 
	INT8U CurrRvsAttn2_WCDMALTE_21	= 0xff; 
	INT8U CurrRvsAttn3_WCDMALTE_21	= 0xff; 

///////////////////////
	INT8U ResetCnt = 0;
	INT8U Chk_Reset = 0;
	INT8U Chk_Factory_default = 0;

	INT8U iResetCnt = 0;
	INT8U PeriodCnt = 0;
	INT8U ChkAttChange = 0;

	INT8U ChkAgcChange = 0;
	INT8U ISOCnt = 0;
	INT8U ISOStartCnt = 0;

	INT16U ULGainPeriodCnt = 0;

	INT8U ChkBandSelet_CDMALTE = SET;
	INT8U ChkBandSelet_LTE_A = SET;
	INT8U ChkBandSelet_WCDMALTE_21 = SET;

	INT32U iBand_Freq_CDMALTE  = 0;
	INT32U iBand_Freq_LTE_A  = 0;
	INT32U iBand_Freq_WCDMALTE_21  = 0;


	INT8U Pre_AC_Sts = 0;
	INT8U SetAcRecovery = 0;

	INT8U SetSMS_PWR = 0;	

/////////////////////////////////////////////////
	INT8U FirstPNCheckFlag = FALSE;

	INT8U ChkTableAlarm = 1;
	INT8U PwrTblAlarm[Local_PwrSts_Max]= {0,};

	INT8U AttnTblAlarm[Local_AttnSts_Max]= {0,};

	type16 ISO_DATA[ISOSampleMax + 2] = {0,};

	INT32U TimePeriodElased = 0;
	INT8U FirstCheckFlag = FALSE;



	INT8U AlarmCheck_2G = 0;
	INT8U AlarmCheck_LTE = 0;
	INT8U AlarmCheck_LTE_A2 = 0;
	INT8U AlarmCheck_LTE_21 = 0;

	INT8U ACFailCnt = 0;
	INT8U DCFailCnt = 0;

	INT8U tAGC10_ATTENMAX_3G 	= 0;
	INT8U tAGC_ATTENMAX_2G 		= 0;
	INT8U tAGC_ATTENMAX_LTE 	= 0;
	INT8U tAGC_ATTENMAX_LTE_A2 	= 0;
	INT8U tALC_ATTENMAX_2G 		= 0;
	INT8U tALC_ATTENMAX_LTE 	= 0;

	INT8U DCAlarm = 0;


	
	INT8U ISOCntInit = 0;

#else
	extern OS_EVENT *ExpioSem;
	extern OS_EVENT *ExpSem;

	extern INT8S tempIndexHys;
	extern INT8U SleepTempOffset;

	extern INT8U ResetCnt;
	extern INT8U Chk_Reset;
	extern INT8U Chk_Factory_default;

	extern INT8U ChkAttChange;
	extern INT8U ChkAgcChange;

	extern INT8U ChkBandSelet_CDMALTE;
	extern INT8U ChkBandSelet_LTE_A;
	extern INT8U ChkBandSelet_WCDMALTE_21;;

	extern INT32U iBand_Freq;
	extern INT8U Pre_AC_Sts;
	extern INT8U SetAcRecovery;

	extern INT8U SetSMS_PWR;

	extern INT8U PeriodCnt;

	extern INT8U FirstPNCheckFlag;
	extern INT8U ChkTableAlarm;
	extern INT8U PwrTblAlarm[Local_PwrSts_Max];
	extern INT8U AttnTblAlarm[Local_AttnSts_Max];

	extern type16 ISO_DATA[ISOSampleMax + 2];

	extern INT8U ISOStartCnt;
	extern INT8U ISOCnt;

	extern INT8U AlarmCheck_2G;
	extern INT8U AlarmCheck_LTE;
	extern INT8U AlarmCheck_LTE_A2;
	extern INT8U AlarmCheck_LTE_21;

	extern INT8U ACFailCnt;
	extern INT8U DCFailCnt;
	
	extern INT32U TimePeriodElased;
	extern INT8U FirstCheckFlag;

	extern INT16U ULGainPeriodCnt;

/////
	extern INT8U CurrFwdAttn1_2G;
	extern INT8U CurrFwdAttn2_2G;
	extern INT8U CurrRvsAttn1_2G;
	extern INT8U CurrRvsAttn2_2G;
	extern INT8U CurrFwdAttn1_LTE;
	extern INT8U CurrFwdAttn2_LTE;
	extern INT8U CurrRvsAttn1_LTE;
	extern INT8U CurrRvsAttn2_LTE;
	extern INT8U CurrFwdAttn1_CDMALTE;	
	extern INT8U CurrRvsAttn1_CDMALTE;	
	extern INT8U CurrRvsAttn2_CDMALTE;	
	extern INT8U CurrRvsAttn3_CDMALTE;
	
	extern INT8U CurrFwdAttn1_LTE_A1; 
	extern INT8U CurrFwdAttn2_LTE_A1; 
	extern INT8U CurrRvsAttn1_LTE_A1; 
	extern INT8U CurrRvsAttn2_LTE_A1; 
	extern INT8U CurrFwdAttn1_LTE_A2; 
	extern INT8U CurrFwdAttn2_LTE_A2; 
	extern INT8U CurrRvsAttn1_LTE_A2; 
	extern INT8U CurrRvsAttn2_LTE_A2;
	extern INT8U CurrFwdAttn1_LTE_A1; 
	extern INT8U CurrFwdAttn2_LTE_A1; 
	extern INT8U CurrRvsAttn1_LTE_A1; 
	extern INT8U CurrRvsAttn2_LTE_A1;

	extern INT8U CurrFwdAttn1_LTEA;
	extern INT8U CurrRvsAttn1_LTEA;
	extern INT8U CurrRvsAttn2_LTEA; 
	extern INT8U CurrRvsAttn3_LTEA;
	
	extern INT8U CurrFwdAttn1_3G;	
	extern INT8U CurrFwdAttn2_3G;	
	extern INT8U CurrRvsAttn1_3G;	
	extern INT8U CurrRvsAttn2_3G;	
	extern INT8U CurrFwdAttn1_LTE_21; 
	extern INT8U CurrFwdAttn2_LTE_21; 
	extern INT8U CurrRvsAttn1_LTE_21; 
	extern INT8U CurrRvsAttn2_LTE_21; 
	extern INT8U CurrFwdAttn1_WCDMALTE_21;	
	extern INT8U CurrRvsAttn1_WCDMALTE_21;	
	extern INT8U CurrRvsAttn2_WCDMALTE_21;	
	extern INT8U CurrRvsAttn3_WCDMALTE_21;	
	
	extern INT8U ISOCntInit;
////////////////////////////////////////////////////////////////////////////////
#endif


_USR_EXT_EXPIO INT8U CurrModemOnOff; 
_USR_EXT_EXPIO INT8U CurrACFail; 
_USR_EXT_EXPIO INT8S dptr[10];
	
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

void ExpioInit(void);
void ExpioPortInit(void);

void ExpioTask(void *p_arg);

void StatusUpdate(void);

void AmpPathOnOff(INT8U Path,INT8U OnOff );

void StatustoIO(void);
void DTUStatustoIO(void);

void AttnBufferInit(void);
void OperatingFunc(void);

INT8U MaxAttnCheck(INT16S cAttn, INT16S tMax);

void ResetStart(INT32U tms);

BOOL AlarmCntFunc(INT8U *Cnt, INT8U Num);
///////////////////////////////////////////////
INT16S MinMaxAttnCheck(INT16S cAttn, INT16S tMax, INT16S tMin);
INT16S GainAttnCalculation(INT16S cGain, INT16S cGainMax,INT8S cAttMin);
///////////////////////////////////
void Period_Check(void);


void AttnDataOutput(unsigned short int Sel, unsigned char Data);
void ADC_Select(INT8U Index);
void pPCA9555Port_Init(INT8U tIndex);
void FrontLEDSet(INT8U tindex, INT8U tstatus);

void TimerRelatedOperation(void);

INT16S RetPower(INT8S *tmp);

void OperatingFunc_DLAttn(INT8U IsItPath);
void OperatingFunc_ULAttn(INT8U IsItPath);


//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

