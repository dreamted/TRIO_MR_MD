
/*********************************************
* File Name          : usart3_vx.x.c
* Author             :
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

////////////////////////////////////////////////////////////////////////////////
#ifdef EXPIO_C
	#define _USR_EXT_EXPIO
#else
	#define _USR_EXT_EXPIO	extern
#endif

_USR_EXT_EXPIO _PCA9555Reg AttnCS0Val;
_USR_EXT_EXPIO _PCA9555Reg AttnCS1Val;
_USR_EXT_EXPIO _PCA9555Reg AttnCS2Val;
_USR_EXT_EXPIO _PCA9555Reg AttnCS3Val;


#define Attn_CS0 0x00

	#define Attn_CS0_SEL0	1		// port 0
		#define AttnCS0_SEL0				((Attn_CS0_SEL0*8) * 8 + Attn_CS0)

		#define Fwd_Att1_CDMALTE		((Attn_CS0_SEL0*8 + 0) * 8 + Attn_CS0)
		#define Fwd_Att1_LTE_A_0		((Attn_CS0_SEL0*8 + 1) * 8 + Attn_CS0)
		#define Fwd_Att1_LTE_A1_0		((Attn_CS0_SEL0*8 + 2) * 8 + Attn_CS0) //////
		#define Fwd_Att2_LTE_A1_0		((Attn_CS0_SEL0*8 + 3) * 8 + Attn_CS0) /////
		#define Fwd_Att1_LTE_A2_0		((Attn_CS0_SEL0*8 + 4) * 8 + Attn_CS0) ////// 
		#define Fwd_Att2_LTE_A2_0		((Attn_CS0_SEL0*8 + 5) * 8 + Attn_CS0) 
		#define Fwd_Att1_WCDMA			((Attn_CS0_SEL0*8 + 6) * 8 + Attn_CS0) 
		#define Fwd_Att2_WCDMA			((Attn_CS0_SEL0*8 + 7) * 8 + Attn_CS0) 

	#define Attn_CS0_SEL1 0		// port 1
		#define AttnCS0_SEL1			((Attn_CS0_SEL1*8) * 8 + Attn_CS0) 

		#define Rvs_Att2_CDMA			((Attn_CS0_SEL1*8 + 0) * 8 + Attn_CS0) 
		#define Rvs_Att3_CDMA 			((Attn_CS0_SEL1*8 + 1) * 8 + Attn_CS0) 
		#define Rvs_Att2_LTE_0 			((Attn_CS0_SEL1*8 + 2) * 8 + Attn_CS0) 
		#define Rvs_Att3_LTE_0			((Attn_CS0_SEL1*8 + 3) * 8 + Attn_CS0) 
		#define Rvs_Att1_LTE_A1_0		((Attn_CS0_SEL1*8 + 4) * 8 + Attn_CS0) 
		#define Rvs_Att2_LTE_A1_0		((Attn_CS0_SEL1*8 + 5) * 8 + Attn_CS0) 
		#define Rvs_Att3_LTE_A1_0		((Attn_CS0_SEL1*8 + 6) * 8 + Attn_CS0) 

#define Attn_CS1 0x01 
		
	#define Attn_CS1_SEL0	1		// port 0
		#define AttnCS1_SEL0			((Attn_CS1_SEL0*8) * 8 + Attn_CS1)

		#define Rvs_Att1_LTE_A2_0	((Attn_CS1_SEL0*8 + 0) * 8 + Attn_CS1)
		#define Rvs_Att2_LTE_A2_0	((Attn_CS1_SEL0*8 + 1) * 8 + Attn_CS1)
		#define Rvs_Att3_LTE_A2_0	((Attn_CS1_SEL0*8 + 2) * 8 + Attn_CS1)
		#define Rvs_Att3_WCDMA		((Attn_CS1_SEL0*8 + 3) * 8 + Attn_CS1) 
		#define Rvs_Att4_WCDMA		((Attn_CS1_SEL0*8 + 4) * 8 + Attn_CS1) 
//		#define PLLEN_LTE_A1_0		((Attn_CS1_SEL0*8 + 5) * 8 + Attn_CS1) 
//		#define PLLEN_LTE_A2_0		((Attn_CS1_SEL0*8 + 6) * 8 + Attn_CS1) 
		#define SP_EN10				((Attn_CS1_SEL0*8 + 7) * 8 + Attn_CS1) 
		
		
	#define Attn_CS1_SEL1 0		// port 1
		#define AttnCS1_SEL1			((Attn_CS1_SEL1*8) * 8 + Attn_CS1) 

		#define SP_EN9					((Attn_CS1_SEL1*8 + 0) * 8 + Attn_CS1) 
		#define SP_EN8					((Attn_CS1_SEL1*8 + 1) * 8 + Attn_CS1) 
		#define SP_EN7					((Attn_CS1_SEL1*8 + 2) * 8 + Attn_CS1) 
		#define SP_EN6					((Attn_CS1_SEL1*8 + 3) * 8 + Attn_CS1) 

		#define Rvs_Att1_LTE_1			((Attn_CS1_SEL1*8 + 4) * 8 + Attn_CS1) 
		#define Rvs_Att2_LTE_1			((Attn_CS1_SEL1*8 + 5) * 8 + Attn_CS1) 
		#define Rvs_Att1_LTE_A_1 		((Attn_CS1_SEL1*8 + 6) * 8 + Attn_CS1) 
		#define _15M_Switch_LTE 		((Attn_CS1_SEL1*8 + 7) * 8 + Attn_CS1) 

#define Attn_CS2 0x02  
				
	#define Attn_CS2_SEL0	1		// port 0
		#define AttnCS2_SEL0			((Attn_CS2_SEL0*8) * 8 + Attn_CS2)

		#define Fwd_Att1_CDMA				((Attn_CS2_SEL0*8 + 0) * 8 + Attn_CS2)
		#define Fwd_Att2_CDMA				((Attn_CS2_SEL0*8 + 1) * 8 + Attn_CS2)
		#define Fwd_Att1_LTE_0				((Attn_CS2_SEL0*8 + 2) * 8 + Attn_CS2)
		#define Fwd_Att2_LTE_0				((Attn_CS2_SEL0*8 + 3) * 8 + Attn_CS2)
		#define Rvs_Att1_CDMALTE			((Attn_CS2_SEL0*8 + 4) * 8 + Attn_CS2) 
		#define Rvs_Att1_CDMA				((Attn_CS2_SEL0*8 + 5) * 8 + Attn_CS2) 
		#define Rvs_Att1_LTE_0				((Attn_CS2_SEL0*8 + 6) * 8 + Attn_CS2) 
		#define Rvs_Att1_LTE_A_0			((Attn_CS2_SEL0*8 + 7) * 8 + Attn_CS2) 



	#define Attn_CS2_SEL1 0		// port 1
		#define AttnCS2_SEL1			((Attn_CS2_SEL1*8) * 8 + Attn_CS2) 

		#define Rvs_Att1_WCDMA			((Attn_CS2_SEL1*8 + 0) * 8 + Attn_CS2) 
		#define Rvs_Att2_WCDMA			((Attn_CS2_SEL1*8 + 1) * 8 + Attn_CS2) 
//		#define PLLEN_LTE_A1_1			((Attn_CS2_SEL1*8 + 6) * 8 + Attn_CS2) 
//		#define PLLEN_LTE_A2_1			((Attn_CS2_SEL1*8 + 7) * 8 + Attn_CS2) 


///////
#define Attn_CS3 0x04
				
	#define Attn_CS3_SEL0	1		// port 0
		#define AttnCS3_SEL0			((Attn_CS3_SEL0*8) * 8 + Attn_CS3)
				
		#define Fwd_Att1_LTE_1			((Attn_CS3_SEL0*8 + 0) * 8 + Attn_CS3)
		#define Fwd_Att2_LTE_1			((Attn_CS3_SEL0*8 + 1) * 8 + Attn_CS3)
		#define Fwd_Att1_LTE_A_1		((Attn_CS3_SEL0*8 + 2) * 8 + Attn_CS3)
		#define Fwd_Att1_LTE_A1_1		((Attn_CS3_SEL0*8 + 3) * 8 + Attn_CS3) 
		#define Fwd_Att2_LTE_A1_1		((Attn_CS3_SEL0*8 + 4) * 8 + Attn_CS3) 
		#define Fwd_Att1_LTE_A2_1		((Attn_CS3_SEL0*8 + 5) * 8 + Attn_CS3) 
		#define Fwd_Att2_LTE_A2_1		((Attn_CS3_SEL0*8 + 6) * 8 + Attn_CS3) 
		#define Rvs_Att3_LTE_1			((Attn_CS3_SEL0*8 + 7) * 8 + Attn_CS3) 

	#define Attn_CS3_SEL1 0		// port 1
		#define AttnCS3_SEL1			((Attn_CS3_SEL1*8) * 8 + Attn_CS3) 
				
		#define Rvs_Att4_LTE_1			((Attn_CS3_SEL1*8 + 0) * 8 + Attn_CS3) 
		#define Rvs_Att1_LTE_A1_1		((Attn_CS3_SEL1*8 + 1) * 8 + Attn_CS3) 
		#define Rvs_Att2_LTE_A1_1		((Attn_CS3_SEL1*8 + 2) * 8 + Attn_CS3) 
		#define Rvs_Att3_LTE_A1_1		((Attn_CS3_SEL1*8 + 3) * 8 + Attn_CS3) 
		#define Rvs_Att1_LTE_A2_1		((Attn_CS3_SEL1*8 + 4) * 8 + Attn_CS3) 
		#define Rvs_Att2_LTE_A2_1		((Attn_CS3_SEL1*8 + 5) * 8 + Attn_CS3) 
		#define Rvs_Att3_LTE_A2_1		((Attn_CS3_SEL1*8 + 6) * 8 + Attn_CS3) 
		#define SP_EN11					((Attn_CS3_SEL1*8 + 7) * 8 + Attn_CS3) 



///////////////////////////////////////////////////////////////////

#define GreenLED_LTE_A2_0			GPIOC->ODR.B14
#define RedLED_LTE_A2_0				GPIOA->ODR.B13

#define GreenLED_LTE_A1_0			GPIOD->ODR.B0
#define RedLED_LTE_A1_0				GPIOD->ODR.B1

#define GreenLED_LTE_A2_1			GPIOE->ODR.B1
#define RedLED_LTE_A2_1				GPIOE->ODR.B0

#define GreenLED_LTE_A1_1			GPIOA->ODR.B11
#define RedLED_LTE_A1_1				GPIOB->ODR.B5

#define PLLAlarm_WCDMA				GPIOA->IDR.B12
#define GreenLED_WCDMA				GPIOA->ODR.B14

#define PLLAlarm_LTE_A2_1			GPIOA->IDR.B8

#define S_SCK						GPIOB->ODR.B4
#define AT24C04_WP					GPIOB->ODR.B5

//#define PCA9555D_I2C_CLK 			GPIOB->ODR.B6
//#define PCA9555D_I2C_Data			GPIOB->ODR.B7
#define _PCA9555_CLK 				GPIOB->ODR.B6
#define _PCA9555_DATA				GPIOB->ODR.B7

#define AT24C04_SCK					GPIOB->ODR.B8
#define GreenLED_LTE_1				GPIOB->ODR.B9
#define PLLAlarm_CDMALTE			GPIOB->IDR.B12	
#define AT24C04_DATA				GPIOB->ODR.B13	
#define AC_Alarm					GPIOB->IDR.B14
#define AmpOnOff_LTE_A1_0			GPIOB->ODR.B15

#define PLLAlarm_LTE_A1_1			GPIOC->IDR.B7
#define PLLAlarm_LTE_1				GPIOC->IDR.B8
#define DC_OnOff					GPIOC->ODR.B9
#define RedLED_LTE_1				GPIOC->ODR.B15


#define RedLED_CDMA					GPIOD->ODR.B3
#define GreenLED_CDMA				GPIOD->ODR.B4
#define RedLED_LTE					GPIOD->ODR.B5
#define GreenLED_LTE				GPIOD->ODR.B6
#define RedLED_WCDMA				GPIOD->ODR.B7

#define AmpOnOff_LTE_A2_0			GPIOD->ODR.B8
#define AmpOnOff_WCDMA				GPIOD->ODR.B9

#define AmpOnOff_LTE_1				GPIOD->ODR.B11
#define AmpOnOff_LTE_A2_1			GPIOD->ODR.B12
#define AmpOnOff_LTE_A1_1			GPIOD->ODR.B13
#define PLLAlarm_LTE_A1_0			GPIOD->IDR.B14
#define PLLAlarm_LTE_A2_0			GPIOD->IDR.B15

#define S_DATA						GPIOE->ODR.B2
#define ADC_Sel0					GPIOE->ODR.B4
#define ADC_Sel1					GPIOE->ODR.B5

#define _ATTN_DATA					GPIOE->ODR.B7
#define _ATTN_CLK					GPIOE->ODR.B8

#ifdef __2rd
	#define PLL_EN1 					GPIOC->ODR.B6
	#define PLL_EN2 					GPIOA->ODR.B1
	#define RRTYPE						GPIOA->IDR.B4

	#define PLL_EN3						GPIOB->ODR.B8

#else

	#define PLL_EN1						GPIOB->ODR.B8
	#define PLL_EN2						GPIOB->ODR.B13
	#define RRTYPE						GPIOC->IDR.B6
	
	#define PLL_EN3 					GPIOB->ODR.B8
#endif

#define PLL_DATA					GPIOB->ODR.B7
#define PLL_CLK						GPIOB->ODR.B6

#define SMS_PWR						GPIOE->ODR.B11
#define AmpOnOff_CDMA				GPIOE->ODR.B12
#define AmpOnOff_LTE_0				GPIOE->ODR.B13


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
enum {
	LEDNorON,
	LEDNorONOFF,
	LEDAlmON,
	LEDAlmONOFF,
	LEDAllOFF,
	LEDAllON,
	
	LEDAllONBlink,
	LEDAlmONOFFBlink,
};

enum {
	LED_SUMSel_2G,
	LED_SUMSel_3G,	
	LED_SUMSel_LTE,	
	LED_SUMSel_LTE_A1,
	LED_SUMSel_LTE_A2,
	
	LED_SUMSel_LTE_1,	
	LED_SUMSel_LTE_A1_1,
	LED_SUMSel_LTE_A2_1,

	LED_SelMax
};



enum {
	_FwdAttn1_2G_SEL = 0x00,	
	_FwdAttn2_2G_SEL,	
	_RvsAttn1_2G_SEL,
	_RvsAttn2_2G_SEL,	
	_RvsAttn3_2G_SEL,
	
	_FwdAttn1_LTE_SEL,	
	_FwdAttn2_LTE_SEL,
	_RvsAttn1_LTE_SEL,	
	_RvsAttn2_LTE_SEL,	
	_RvsAttn3_LTE_SEL,	
	
	_FwdAttn1_Common_SEL,	
	_RvsAttn1_Common_SEL,	
	
	_FwdAttn1_LTE_A1_SEL, 
	_FwdAttn2_LTE_A1_SEL, 
	_RvsAttn1_LTE_A1_SEL, 
	_RvsAttn2_LTE_A1_SEL, 
	_RvsAttn3_LTE_A1_SEL, 

	_FwdAttn1_LTE_A2_SEL, 
	_FwdAttn2_LTE_A2_SEL, 
	_RvsAttn1_LTE_A2_SEL, 
	_RvsAttn2_LTE_A2_SEL, 
	_RvsAttn3_LTE_A2_SEL, 

	_FwdAttn1_LTE_A_SEL,	
	_RvsAttn1_LTE_A_SEL,	
	
	
	_FwdAttn1_3G_SEL,	
	_FwdAttn2_3G_SEL,	
	_RvsAttn1_3G_SEL,	
	_RvsAttn2_3G_SEL,	
	_RvsAttn3_3G_SEL,	
	_RvsAttn4_3G_SEL,	
	
	_Fwd1Attn1_LTE_SEL,	
	_Fwd1Attn2_LTE_SEL,	
	_Rvs1Attn1_LTE_SEL,	
	_Rvs1Attn2_LTE_SEL,	
	_Rvs1Attn3_LTE_SEL,	
	_Rvs1Attn4_LTE_SEL,	
	
	_Fwd1Attn1_LTE_A1_SEL, 
	_Fwd1Attn2_LTE_A1_SEL, 
	_Rvs1Attn1_LTE_A1_SEL, 
	_Rvs1Attn2_LTE_A1_SEL, 
	_Rvs1Attn3_LTE_A1_SEL, 

	_Fwd1Attn1_LTE_A2_SEL, 
	_Fwd1Attn2_LTE_A2_SEL, 
	_Rvs1Attn1_LTE_A2_SEL, 
	_Rvs1Attn2_LTE_A2_SEL, 
	_Rvs1Attn3_LTE_A2_SEL, 


	_Fwd1Attn1_LTE_A_SEL,	
	_Rvs1Attn1_LTE_A_SEL,	

	
	Att_SelMax
};


#define Delay_TIMES				10
#define DelaySum_TIMES			5


#define RecoveryTime			5L		//5L //10L

#define Recovery1Time			9*2L		//5L //10L
#define Recovery2Time			10L			//5L
#define Recovery3Time			1800*2L		//5L

#define Recovery4Time			2*2L		//5L  /////±‚¡∏ 5

#define Recovery0Time			1L			//5L
#define AlarmDelay1Time			300L		//5L
#define AlarmDelay2Time			9L			//10L

#if 0
#define _AlarmCheckStart		0
#define _CheckStart				1
#define _Recovery				2
#define _LevelCheck				3
#define _ShutDown				4
#define _NormalRecovery			5

#define _Recovery_1				6
#endif

#if 1
#define _AlarmCheckStart		0
#define _CheckStart				1
#define _Recovery				2
#define _Recovery_1				3

#define _LevelCheck				4
#define _ShutDown				5
#define _NormalRecovery			6
#endif



#ifdef EXPIO_C
////////////////////
	#define EXPIO_START_STK_SIZE		256
	static OS_STK ExpioTaskStk[EXPIO_START_STK_SIZE];
	OS_EVENT *ExpioSem = NULL;
	OS_EVENT *ExpSem = NULL;

	
	
	INT8U LEDStatus[LED_SelMax] = {0,};
	INT8U BlinkFlag = FALSE;

	INT8U ResetCnt = 0;
	INT8U Chk_Reset = 0;
	INT8U Chk_Factory_default = 0;

	INT8U iResetCnt = 0;
	INT8U PeriodCnt = 0;
	INT8U ChkAttChange = 0;

	INT8U ChkBandSelet= 0;
	INT32U iBand_Freq = 0;

	INT8U ChkPllFregOffset_LTE = 0;
	
	INT8U RedLEDFlag_2G;
	INT8U RedLEDFlag_LTE;
	INT8U RedLEDFlag_LTE_A1;
	INT8U RedLEDFlag_LTE_A2;
	INT8U RedLEDFlag_3G;

	INT8U RedLEDFlag_LTE_1;
	INT8U RedLEDFlag_LTE_A1_1;
	INT8U RedLEDFlag_LTE_A2_1;

	INT8U YellowLEDFlag_2G;
	INT8U YellowLEDFlag_LTE;
	INT8U YellowLEDFlag_LTE_A1;
	INT8U YellowLEDFlag_LTE_A2;
	INT8U YellowLEDFlag_3G;
	INT8U YellowLEDFlag_LTE_1;
	INT8U YellowLEDFlag_LTE_A1_1;
	INT8U YellowLEDFlag_LTE_A2_1;

	INT8U	Pre_AC_Sts = 0;
	INT8U	SetAcRecovery = 0;

	INT8U RefFwdAmpOnOff_2G 		= 0;
	INT8U RefFwdAmpOnOff_LTE	 	= 0;
	INT8U RefFwdAmpOnOff_LTE_A1  	= 0;
	INT8U RefFwdAmpOnOff_LTE_A2  	= 0;
	INT8U RefFwdAmpOnOff_3G 	 	= 0;
	INT8U RefFwdAmp1OnOff_LTE 	 	= 0;
	INT8U RefFwdAmp1OnOff_LTE_A1 	= 0;
	INT8U RefFwdAmp1OnOff_LTE_A2 	= 0;

	INT8U SetSMS_PWR = 0;

	
	INT8U Chk_RvsOSCAlarmCount = 0;
#else

	extern OS_EVENT *ExpioSem;
	extern OS_EVENT *ExpSem;

	extern INT8U ResetCnt;
	extern INT8U Chk_Reset;
	extern INT8U Chk_Factory_default;

	extern INT8U ChkAttChange;
	extern INT8U ChkBandSelet;
	extern INT8U ChkPllFregOffset_LTE;

	extern INT32U iBand_Freq;
	extern INT8U Pre_AC_Sts;
	extern INT8U SetAcRecovery;

	extern INT8U RefFwdAmpOnOff_2G;
	extern INT8U RefFwdAmpOnOff_2G;
	extern INT8U RefFwdAmpOnOff_LTE;
	extern INT8U RefFwdAmpOnOff_LTE_A1;
	extern INT8U RefFwdAmpOnOff_LTE_A2;
	extern INT8U RefFwdAmpOnOff_3G;
	extern INT8U RefFwdAmp1OnOff_LTE;
	extern INT8U RefFwdAmp1OnOff_LTE_A1;
	extern INT8U RefFwdAmp1OnOff_LTE_A2;


	extern INT8U SetSMS_PWR;
	extern INT8U Chk_RvsOSCAlarmCount;

#endif
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

void ExpioInit(void);
void ExpioPortInit(void);
void ExpioTask(void *p_arg);

void ResetStart(void);
INT8U F_RESET_IN_Read(void);

void Period_Check(void);

void FrontLEDSet(INT8U tindex, INT8U tstatus);
void FrontLEDDisplay(void);

void ChangeLvltoValue(INT16S CurLvl, INT16S *PreLvl, INT16S *Cnt, INT16S *Value, INT8S MaxCnt);
INT8S MinMaxAttnCheck(INT16S cAttn, INT16S tMax, INT16S tMin);

void TimerRelatedOperation(void);


_USR_EXT_EXPIO INT8U CurrFwdAttn1_2G;
_USR_EXT_EXPIO INT8U CurrFwdAttn2_2G;	
_USR_EXT_EXPIO INT8U CurrRvsAttn1_2G;
_USR_EXT_EXPIO INT8U CurrRvsAttn2_2G;
_USR_EXT_EXPIO INT8U CurrRvsAttn3_2G;
_USR_EXT_EXPIO INT8U CurrFwdAttn1_LTE;
_USR_EXT_EXPIO INT8U CurrFwdAttn2_LTE;
_USR_EXT_EXPIO INT8U CurrRvsAttn1_LTE;
_USR_EXT_EXPIO INT8U CurrRvsAttn2_LTE;
_USR_EXT_EXPIO INT8U CurrRvsAttn3_LTE;

_USR_EXT_EXPIO INT8U CurrFwdAttn1_CDMALTE;	
_USR_EXT_EXPIO INT8U CurrRvsAttn1_CDMALTE;	

_USR_EXT_EXPIO INT8U CurrFwdAttn1_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrFwdAttn2_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrRvsAttn1_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrRvsAttn2_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrRvsAttn3_LTE_A1; 

_USR_EXT_EXPIO INT8U CurrFwdAttn1_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrFwdAttn2_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrRvsAttn1_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrRvsAttn2_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrRvsAttn3_LTE_A2; 

_USR_EXT_EXPIO INT8U CurrFwdAttn1_LTE_A; 
_USR_EXT_EXPIO INT8U CurrRvsAttn1_LTE_A; 

_USR_EXT_EXPIO INT8U CurrFwdAttn1_3G;	
_USR_EXT_EXPIO INT8U CurrFwdAttn2_3G;	
_USR_EXT_EXPIO INT8U CurrRvsAttn1_3G;	
_USR_EXT_EXPIO INT8U CurrRvsAttn2_3G;	
_USR_EXT_EXPIO INT8U CurrRvsAttn3_3G;	
_USR_EXT_EXPIO INT8U CurrRvsAttn4_3G;	

_USR_EXT_EXPIO INT8U CurrFwd1Attn1_LTE;
_USR_EXT_EXPIO INT8U CurrFwd1Attn2_LTE;
_USR_EXT_EXPIO INT8U CurrRvs1Attn1_LTE;
_USR_EXT_EXPIO INT8U CurrRvs1Attn2_LTE;
_USR_EXT_EXPIO INT8U CurrRvs1Attn3_LTE;
_USR_EXT_EXPIO INT8U CurrRvs1Attn4_LTE;

_USR_EXT_EXPIO INT8U CurrFwd1Attn1_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrFwd1Attn2_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrRvs1Attn1_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrRvs1Attn2_LTE_A1; 
_USR_EXT_EXPIO INT8U CurrRvs1Attn3_LTE_A1; 

_USR_EXT_EXPIO INT8U CurrFwd1Attn1_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrFwd1Attn2_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrRvs1Attn1_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrRvs1Attn2_LTE_A2; 
_USR_EXT_EXPIO INT8U CurrRvs1Attn3_LTE_A2; 

_USR_EXT_EXPIO INT8U CurrFwd1Attn1_LTE_A; 
_USR_EXT_EXPIO INT8U CurrRvs1Attn1_LTE_A; 

_USR_EXT_EXPIO INT8U CurrLTE15MUse; 

_USR_EXT_EXPIO INT8U CurrModemOnOff; 

_USR_EXT_EXPIO INT8U CurrACFail; 

_USR_EXT_EXPIO INT8U CurrRvsOverInAlarm; 
_USR_EXT_EXPIO INT8U CurrRvsOtherOverInAlarm; 

_USR_EXT_EXPIO INT8S dptr[10];



void AttAccuChange(void);
void StatustoIO(void);
void TimerRelatedOperation(void);
void AttnOutBufferInit(void);
void TypeCheck(void);
void AttnDataOutput(unsigned short int Sel, unsigned char Data);
void ADC_Select(INT8U Index);
void pPCA9555Port_Init(INT8U tIndex);
INT8S DnrReferToTable(INT8U TblID,INT8U AttTemp,INT8U tAttAccuOnOff);
void ShutDownCheck(void);
void TRIO_AlarmCheck(void);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////


