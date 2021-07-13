
/*********************************************
* File Name          : usart3_vx.x.c
* Author             :
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

////////////////////////////////////////////////////////////////////////////////
#if 1
#ifdef EXPIO_C1
	#define _USR_EXT_EXPIO1
#else
	#define _USR_EXT_EXPIO1	extern
#endif
#endif

///////////////////////////////////////////////////////////////////




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



#ifdef EXPIO_C1
////////////////////
//	#define EXPIO_START_STK_SIZE		256
#if 0
    static OS_STK ExpioTaskStk[EXPIO_START_STK_SIZE];
	OS_EVENT *ExpioSem = NULL;
	OS_EVENT *ExpSem = NULL;
#endif
	
#if 0	
	INT8U LEDStatus[LED_SelMax] = {0,};
	INT8U BlinkFlag = FALSE;
	INT8U PeriodCnt = 0;

	INT8U ResetCnt = 0;
	INT8U Chk_Reset = 0;
	INT8U Chk_Factory_default = 0;

	INT8U iResetCnt = 0;
	INT8U PeriodCnt = 0;
	INT8U ChkAttChange = 0;

	INT8U ChkBandSelet= 0;
	INT32U iBand_Freq = 0;

	INT8U ChkPllFregOffset_LTE = 0;
#endif	
#if 0
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
#endif	
#if 0
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
#endif   
#else
#if 0
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
#endif
#endif
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////




//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////


