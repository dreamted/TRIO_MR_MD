
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : main.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/28/2008
* Description        : This file provides all the serial prompt firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__

********************************************************************************/
#include <includes.h>

////////////////////////////////////////////////////////////////////////////////

// device & lib Related include ------------------------------------------------
// "lib include files" should(must) be declared before "device include files"
#include "stm32f2xx_usart1_1208.h"
//#include "stm32f2xx_usart2_1208.h"

#include "stm32f2xx_usart3_1208.h"
#include "stm32f2xx_usart4_1208.h"

#include "../lib/include/lib_timerext.h"
//#include "../lib/fsmc/lib_fsmc_sram_1208.h"

#include "../lib/include/eepext.h"


// "lib devices files"     should(must) be decalred before "code include files"
#include "../dev/intvect/stm32f2xx_it_1208.h"
//#include "../dev/MB15E07SL/MB15E07SL_v1209.h"
#include "../dev/adf411x/adf411x.h"

//#include "../dev/ad9362/ad9362_v1207.h"
//#include "../dev/pll2332/pll2332_v1107.h"
//#include "../dev/mem/fsmc_sram_v1010.h"
//#include "../dev/extint/extint_v1003.h"


#include "../include/Swab.h"
#include "../include/AdcFunc.h"
#include "../include/exlib.h"

// application Related include ------------------------------------------------

//#include "../include/aa_Aidlen.h"
#include "../include/aa_btype.h"

//#include "../include/Wave_Str.h"

#include "../include/TRIO_StrDnr.h"
#include "../include/aa_Table.h"
#include "../include/aa_Protocol.h"
#include "../include/aa_serial1.h"
/////////////////////////////////////////////////////
#include "../include/Aidlen.h"

#include "../include/Protocol.h"
//#include "../include/Wave_Str.h"

//#include "../include/TRIO_StrDnr.h"
//#include "../include/StrTable.h"
//#include "../include/DE_Table.h"

//#include "../include/DE_Protocol.h"
#include "../dev/iobus/PCA9555.h"
#include "../dev/bellwave/bell860s_v0112.h"


//#include "../include/DDR_WRCS.h"

/////////////////////////////////////////////////////
#include "../include/aa_expio.h"
#include "../include/aa_alc.h"
#include "../include/aa_test.h"


//#include "../include/alc.h"
#include "../include/alarm.h"
//#include "../include/expio.h"

#include "../include/cdma.h"
#include "../include/apl_dtu.h"

#include "../dev/SFlash/AT25DF641_v1204.h"

#include "../dev/SFlash/N25Q.h"
#include "../include/aa_iAPD.h"
//#include "../include/aa_iRems.h"

/////////////////////////

#define __pAPBK_SRAMAddr        ((u32)&*((u8 *)(Bank1_SRAM1_ADDR)) + ((512-(256-32))*1024L))  

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////////////////////////////////////////////////////
#ifdef MAIN_C
/////////////
	__SerStrPtr *SerPtr;
	__SerStrPtr *Ser2Ptr;

	__SerStrPtr *Ser3Ptr;
	__SerStrPtr *Ser4Ptr;
	
	const selfinfo convinfo = {
								"TRIO-MR"	
								"NC0",
								"NC1",
								"123456789",
							};
////////////////////////////////////////////////////////////////////////////////

	INT8U iAdcIndex = 3;



#else
////////////////
	extern __SerStrPtr *SerPtr;
	extern __SerStrPtr *Ser2Ptr;

	extern __SerStrPtr *Ser3Ptr;
	extern __SerStrPtr *Ser4Ptr;

	extern const selfinfo convinfo;


	extern INT8U iAdcIndex;

////////////////////////////////////////////////////////////////////////////////
#endif
////////////////////////////////////////////////////////////////////////////////
#if 0
#define SystemVer	0x10
#define PROGRAMVER	0x14
#endif
#define SystemVer	0x31
#define PROGRAMVER	0x03


/*
#define SystemVer	0x30
#define PROGRAMVER	0x03
*/
#define RUNLEDSEL	GPIOB->__B.ODR.B2
#define SystemDate	__DATE__
#define SystemTime  __TIME__


#if 1  //////////////////
//#define DTU_TEST
//#define PLL_TEST_2_1G

#endif


#define _2_1G_Clearing


////20140206 양산배 포 

/////2015.05.18 1.0.14 DC 알람 카운트 3회이상일 경우 알람으로 처리
/////2016.11.30 5.2.00 2.1GHz 10MHz Band 변경
/////2017.04.18 3.1.00 2.1GHz 15MHz 5MHz Band 변경




//#define DTU_TEST

//#define Alarm_Test
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////
void mainTask (void *p_arg);

void LedDisplay(void);
void InitStm32f103(void);
void PheripheralInit(void);

void InitGPIO(void);
void InitAFIO(void);


extern unsigned short __swab16p(unsigned short *x);
extern unsigned short ___swab16(unsigned short x);

////////////////////////////////////////////////////////////////////////////////
/*
********************************************************************************
*											TASK PRIORITIES
********************************************************************************
*/
enum
{
	START_PRIO  = MAIN_START_PRIO,
	SMSTASK_PRIO,

	ALC_START_PRIO,
	DTU_START_PRIO,
	EXPIO_START_PRIO,
	SER1TASK_PRIO,
	APD0_TASK_PRIO,
	TEST_START_PRIO,
	MAX_PRIO_NUM
};									   

/////////////////////////////////////////////////////////////////////////////
// Timer Register & Specification
enum
{
	TimerReserved	= 0,
	TimerLed,
	TimerSioRx,
	TimerTest,
	TimerEsc,
	TimerLEDBlink,
	Timer_DebugCnt,
	TimerReset,
	TimerLEDInit,

//////////////////////
	Timer_AttnOut,
	Timer_Period,
	TimerSmsRx,
	TimerSmsEndWait,
	TimerSmsFirstTx,
	TimerPerReport,
	TimerAlmReport,
	TimerLockOrder,

	// ALC
	TimerSD_2G,
	TimerSD_3G,
	TimerSD_LTE,
	TimerSD_LTE_A2,
	TimerSD_LTE_21,

	Timer_ModemReset,
	TimerEnvTemp,
	TimerULGainPriod,

	TimerULAlarm_800M,
	TimerULAlarm_1800M,
	TimerULAlarm_2100M,

	TimerULAlarmMode2_800M,
	TimerULAlarmMode2_1800M,
	TimerULAlarmMode2_2100M,

	Timer_ISOStop,

	TimerTcpRx,


	TimerDNMode,
	TimerAGC_3G,

///////////////////////////////////////////////////
// USER DEFINE TIMER

// END Of User TIMER
//////////////////////////////////////////////////
};


////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

