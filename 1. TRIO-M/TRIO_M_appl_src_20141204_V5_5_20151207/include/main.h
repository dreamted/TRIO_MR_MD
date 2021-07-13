/*********************************************
* File Name          : main.h
* Author             :
* Date First Issued  : 02/28/2008
* Description        : This file provides all the serial prompt firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
#include <includes.h>

// device & lib Related include ------------------------------------------------
// "lib include files" should(must) be declared before "device include files"
// "devices files"     should(must) be decalred before "code include files"
#include "../lib/include/timerext.h"
//#include "../lib/include/eepext.h"
#include "../lib/include/usart1ext.h"
//#include "../lib/include/usart2ext.h"
//#include "../lib/include/usart3ext.h"
#include "../lib/include/usart4ext.h"
//#include "../lib/include/usart5ext.h"
#include "../lib/include/clcdlibext.h"
#include "../lib/include/keybuzext.h"

#include "../dev/mem/fsmc_sram.h"
#include "../dev/extint/extint_v0903.h"
//#include "../dev/LIS3LV02/LIS3LV02_v1010.h"
//#include "../dev/eeprom/eep_24c16a_v1102.h"
//#include "../dev/eeprom/eep_ds2431_v1102.h"
//#include "../dev/eeprom/eep_24c64_v1104.h"

#include "../include/adcFunc.h"
 
#include "../include/Swab.h"

#include "../include/Aidlen.h"
#include "../include/Protocol.h"

#include "../include/Wave_Str.h"
#include "../include/TRIO_StrDnr.h"

#include "../include/StrTable.h"
#include "../include/DE_Table.h"

#include "../include/DE_Protocol.h"
#include "../dev/iobus/PCA9555.h"
#include "../dev/bellwave/bell860s_v0112.h"



// application Related include ------------------------------------------------
#include "../include/DDR_WRCS.h"
//#include "../include/DDR_MHU.h"
 
#include "../include/exlib.h"

#include "../include/alc.h"
#include "../include/alarm.h"

#include "../include/expio.h"
#include "../include/btest.h"
//#include "../include/SendDebug.h"
#include "../include/cdma.h"
#include "../dev/adf411x/adf411x.h"


/////////////////////////
#if 0  //���� 
//#define TRIO_M_SystemVer	0x11	
#define TRIO_M_SystemVer	0x14	
#define TRIO_M_PROGRAMVER	0x02


//#define TRIO_MM_SystemVer	0x11	
#define TRIO_MM_SystemVer	0x14	
#define TRIO_MM_PROGRAMVER	0x02

#endif
#if 0
#define TRIO_M_SystemVer	0x15	
#define TRIO_M_PROGRAMVER	0x00


#define TRIO_MM_SystemVer	0x15	
#define TRIO_MM_PROGRAMVER	0x00

#endif
#if 1
#define TRIO_M_SystemVer	0x16	
#define TRIO_M_PROGRAMVER	0x07


#define TRIO_MM_SystemVer	0x16	
#define TRIO_MM_PROGRAMVER	0x07

#endif




#define SystemDate	__DATE__
#define SystemTime  __TIME__

#define  __DefaultTbl
//#define  __HW_1St

//#define  __SmsDebug


#define  __WaveDebug

//#define  __RvsCount


#define RUNLEDSEL	GPIOB->ODR.B2


#define LASTUPDATE	   "TRIO-M 2012-12-20 17:00:00" 	   /// 

//20151207     1.6.00 LTE-A1 �̻�� Amp Off �˶� ���� �Ǵ� ���� ����




//TRIO-M
//20121220     1.1.03���� ���� �� 1.2.0���� ���� 
//20121212     1.1.03 LTE-A �̻��� ������ Amp Off �� ����� ���� �� ǥ�� �Ǵ� ���� ����


//20120601     1.0.0 ��� ���� 
//20120604     1.0.1 LTE-A2 RVS AGC ATT MAX ��� ����, LTE-A1,LTE-A2 �µ� ���� 
//20120607     1.0.2 15M Band_Select ����� ��� ���Ѱ� ���� ���� 
//20120611     1.0.3 LTE-A �̻�� ������ AMP OFF �ȵ� 
//20120612     1.0.4 AGC Off�� RVS ALC LEVEL ������ ALC ���������� ����  
//20120615     1.0.6 BandSelect �� AMP On/Off Backup �ȵǴ� ���� ����
//20120615     1.0.7 Forward Amp Off�� ���ߺ� att �� 25dB �ǰ� ���� 
//20120705     1.0.10 LTE PLL ���� ó�� �ȵ�
//20120718     1.1.00 Ÿ�� ���Է� �˶� ����

//20121121     1.1.02 HW 2�� �������� LTE-A Detect �µ�  offset ����  


//TRIO-MM
//20121212     1.1.03 LTE-A �̻��� ������ Amp Off �� ����� ���� �� ǥ�� �Ǵ� ���� ����

//20120601     1.0.0 ��� ���� 
//20120604     1.0.1 LTE-A2 RVS AGC ATT MAX ��� ����, LTE-A1,LTE-A2 �µ� ���� 
//20120607     1.0.2 15M Band_Select ����� ��� ���Ѱ� ���� ���� 
//20120611     1.0.3 LTE-A �̻�� ������ AMP OFF �ȵ�
//20120612     1.0.4 AGC Off�� RVS ALC LEVEL ������ ALC ���������� ���� 
//                     LTE-A2 MIMO RVS GAIN ǥ�� ���� 
//20120615     1.0.6 BandSelect �� AMP On/Off Backup �ȵǴ� ���� ����
//20120615     1.0.7 Forward Amp Off�� ���ߺ� att �� 25dB �ǰ� ���� 
//20120621     1.0.8 LTE MIMO Forward ��� �� ������ ���̺� ������ ��� �Է� ǥ�� �Ǵ� ���� ����
//20120628     1.0.9 LTE-A1 MIMO AGC OFF RVS ATT ���� ���� ���� ����
//20120718     1.1.00 Ÿ�� ���Է� �˶� ����




////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////////////////////////////////////////////////////

#ifdef MAIN_C

	OS_STK MainTaskStk[OS_TASK_STK_SIZE] @ "iram";
	__SerStrPtr *SerPtr;
	__SerStrPtr *Ser4Ptr;

	const selfinfo convinfo = {
								"TRIO-M",
								"NC0",
								"NC1",
								"123456789"
							};

	INT8U iAdcIndex = 0;

#else
	extern __SerStrPtr *SerPtr;
	extern __SerStrPtr *Ser4Ptr;

	extern const selfinfo convinfo;

	extern INT8U iAdcIndex;
#endif


#define RvsSD_Debug


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////
void mainTask (void *p_arg);

void LedDisplay(void);
void InitStm32f103(void);
void PheripheralInit(void);

void InitRCC(void);
void InitGPIO(void);
void InitGPIO_De(void);

void InitAFIO(void);


extern unsigned short __swab16p(unsigned short *x);
extern unsigned short ___swab16(unsigned short x);

///////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// Timer Register & Specification
enum
{
	TimerReserved	= 0,
	TimerLed,
	TimerSioRx,
	TimerTest,
	TimerEsc,
	Timer_DebugCnt,

	Timer_AttnOut,
	Timer_Period,

	TimerSmsRx,
	TimerSmsEndWait,

	TimerReset,

	TimerSmsFirstTx,

	TimerPerReport,

	TimerAlmReport,
	TimerLockOrder,

	// ALC
	TimerSD_2G,
	TimerSD_3G,
	TimerSD_LTE,
	TimerSD_LTE_A1,
	TimerSD_LTE_A2,

	TimerSD_LTE_1,
	TimerSD_LTE_A1_1,
	TimerSD_LTE_A2_1,


	Timer_ModemReset,


	Timer_RvsOSCAlarmCount,

///////////////////////////////////////////////////
// USER DEFINE TIMER
// END Of User TIMER
//////////////////////////////////////////////////
	
};


enum
{
	COMM_Pcser = 1,
	COMM_CFRSer,
	COMM_RRCUSer,
	COMM_FskSer,
	COMM_NUM
};

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

