
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

////////////////////////////////////////////////////////////////////////////////
#ifdef TEST_C
	#define _USR_TEST
#else
	#define _USR_TEST	extern
#endif


#define tTestOK				0x5A

#define BoardTestMode		"TRIO RCU CTRL TEST PROGRAM"

#define STARMSG		"* "

#define OFFMSG		"[OFF]"
#define ONMSG		"[ON ]"

#define PHAMSG		", "
#define ENTMSG		"\n"

enum{
    ADCTest = 0,
	InputTest,
	OutputTest,
	CommTest,
	EepromTest,
	EepromResult,
};

typedef union {
	INT8U tinput[50];
} _inputStsStr;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////////////////////////////////////////////////////

#ifdef TEST_C
////////////////////
	#define TEST_START_STK_SIZE		512
	static OS_STK TestTaskStk[TEST_START_STK_SIZE] @ "iram";;

	INT8U tTestFlag = 0;

	char  tIndex = 0;
	INT8U tRevData[30] = {0,};
	INT8U gTestFlag = 0;

	INT8U PrevData[5][30] = {{0,0},};
	INT8S PrevWRCnt = 0;
	INT8S PrevRDCnt = 0;
	
	INT8U	SysPath = 0;

#if 0 
	
	const INT8U *testResult[] = { "NON TESTED",
								  "    TESTED",
                                  "NON TESTED",
                                  "NON TESTED",
						};
	_inputStsStr tinputSts;
	_inputStsStr tinputStsOld;

	const char *tDisplay[] = {
		"PLL LD 4G :",
		"PLL LD 3G :",
	};
#endif	
///////////////////////////////////////////
	const INT8U *testResult[] = { "NON TESTED",
								  "    TESTED"
						};

	_inputStsStr tinputSts;
	_inputStsStr tinputStsOld;

	const char *tDisplay[] = {

		"Insert          :",
		"AC_Alarm        :",

		"PLL_CDMALTE     :",
		"PLL_WCDMA       :",
		"PLL_LTE_A2      :",
 	};


///////////////////////////////////////////////


	INT8U FNDi = 0;
	INT8U FNDj = 0;
	INT32U testFNDCnt = 0;
	INT8U FNDSTOPFlag = SET;


#else
////////////////////
	extern INT8U gTestFlag;
	extern INT8U tTestFlag;


////////////////////
#endif
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

void TestInit(void);
void TestTask(void *p_arg);

void PrintLogo(void);
void PrintStar(void);
void PromptOut(void);
void KeyProc( char sbuf, void (*func)(void));

INT8U htob(INT8U hex);
INT8U dGetHex (INT8U Data_H, INT8U Data_L);
void OnCommand(void);
void TestCommand(void);

void HwTestOutFunc(INT32U *nFlag);
void CurrentInputStatus(INT8U vcheck);
void COMTestFunc(void);
void AdInputStatus(void);
void AdcPrintf(char *sptr, INT16U rawData, INT8U is_5V);

INT8U returnmsgTest(char *str);
INT8U WaringMssageReturn(void);
INT8U SavetoTestBackup(INT8U tmpIndex, INT8U tSet, INT8U IsItLoad);

INT32U DigitalInputDiplay(INT8U num, INT8U ival,
							INT8U *fmsg, INT8U *emsg,
							INT8U vcheck);


//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

