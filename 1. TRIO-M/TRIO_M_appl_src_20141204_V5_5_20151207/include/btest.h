
/*********************************************
* File Name          : Btest.c
* Author             :
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

#define BoardTestMode		"TRIO-M MCU CTRL TEST PROGRAM"

#define STARMSG		"* "

#define OFFMSG		"[OFF]"
#define ONMSG		"[ON ]"

#define PHAMSG		", "
#define ENTMSG		"\n"

typedef struct {
	INT32U Output			:1;
	INT32U Input			:1;
	INT32U Comm				:1;
	INT32U Analogin			:1;
	INT32U eeprom           :1;
} tstStr;

typedef union {
	INT8U tinput[50];
} _inputStsStr;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////////////////////////////////////////////////////
#define TEST_START_STK_SIZE 	256

#ifdef TEST_C
////////////////////
	static OS_STK TestTaskStk[TEST_START_STK_SIZE];


	char  tIndex = 0;
	INT8U tRevData[50] = {0,};
	INT8U tTestFlag = 0;
	tstStr tTest;
	
	const INT8U *testResult[] = { "NON TESTED",
								  "    TESTED"
						};
	_inputStsStr tinputSts;
	_inputStsStr tinputStsOld;

	const char *tDisplay[] = {

		"PLL_CDMALTE  :",
		"PLL_LTE_A1   :",
		"PLL_LTE_A2   :",
		"PLL_WCDMA    :",
		"PLL_LTE_1    :",
		"PLL_LTE_A1_1 :",
		"PLL_LTE_A2_1 :",
		"AC_Alarm     :",
		"Insert       :",

	};

#else
////////////////////
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
void KeyProc( char sbuf );
void OnCommand ( void );

void HwTestOutFunc(INT32U *nFlag);
void CurrentInputStatus(INT8U vcheck);
void COMTestFunc(void);
void AdInputStatus(void);
void AdcPrintf(char *sptr, INT16U rawData, INT8U is_5V);

INT8U returnmsgTest(char *str);
INT8U WaringMssageReturn(void);

INT32U DigitalInputDiplay(INT8U num, INT8U ival,
							INT8U *fmsg, INT8U *emsg,
							INT8U vcheck);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

