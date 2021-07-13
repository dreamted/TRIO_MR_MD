
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

#define Bank1_SRAM1_ADDR			((u32)0x60000000)
#define Bank1_SRAM2_ADDR			((u32)0x64000000)
#define Bank1_SRAM3_ADDR			((u32)0x68000000)

#define tTestOK				0x5A

#define BoardTestMode		"TRIO-MD RCU CTRL TEST PROGRAM"

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


/* Common routines */
#define IS_AF(c)  ((c >= 'A') && (c <= 'F'))
#define IS_af(c)  ((c >= 'a') && (c <= 'f'))
#define IS_09(c)  ((c >= '0') && (c <= '9'))
#define ISVALIDHEX(c)  IS_AF(c) || IS_af(c) || IS_09(c)
#define ISVALIDDEC(c)  IS_09(c)
#define CONVERTDEC(c)  (c - '0')

#define CONVERTHEX_alpha(c)  (IS_AF(c) ? (c - 'A'+10) : (c - 'a'+10))
#define CONVERTHEX(c)   (IS_09(c) ? (c - '0') : CONVERTHEX_alpha(c))


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////////////////////////////////////////////////////
#define SRAM_NONE		0
#define SRAM_INSERT		1
//////////////////////////////////////////////////////

typedef unsigned short int word;
typedef unsigned char  byte;
#define OK    1
#define FAIL  0
#define MAX_SARGC 15



#define COM_BUFF_SIZ 80  /* 수신된 명령어를 저장하기 위한 버퍼 크기.*/

typedef struct{
       INT8U  m_Mode;        				/* MODE       */
       INT8U  m_Ptr;         				/* POINTER    */
       char  m_Buff[COM_BUFF_SIZ];   	/* BUFFER     */
       INT8U  m_PromptBuff[COM_BUFF_SIZ];
}MON_STR;

/* Control Character. */
#define BELL  0x07
#define BS    0x08
#define LF    0x0a
#define CR    0x0d
#define ESC   0x1B
#define SP    0x20
#define DEL   0x7f
#define SLASH 0x2F


#ifdef TEST_C
////////////////////
	#define TEST_START_STK_SIZE		512
	
	static OS_STK TestTaskStk[TEST_START_STK_SIZE] @ "iram";;

	#define TEST1_START_STK_SIZE 	256


	INT8U tTestFlag = 0;

	char  tIndex = 0;
	INT8U tRevData[30] = {0,};
	char rRevData[30] = {0,};

	INT8U gTestFlag = 0;

	INT8U PrevData[5][30] = {{0,0},};
	INT8S PrevWRCnt = 0;
	INT8S PrevRDCnt = 0;
	
	INT8U	SysPath = 0;

	INT16U Argc;
	char *Argv[MAX_SARGC]= {0,};

	MON_STR  MonStr;

	INT8U DTUTest = 0;

///////////////////////////////////////////
	const INT8U *testResult[] = { "NON TESTED",
								  "    TESTED"
						};

	_inputStsStr tinputSts;
	_inputStsStr tinputStsOld;
#if 0
	const char *tDisplay[] = {
		"AC_Alarm        :",
		"PLL_CDMALTE     :",
		"PLL_LTE_A2      :",
		"PLL_WCDMA       :",
		"F_DONE          :",
 	};
#endif
#if 1
	const char *tDisplay[] = {
		"AC(PSU)      :",
		"CL_PLL_LD    :",
		"LTEA_PLL_LD  :",
		"WCDMA_PLL_LD :",
		"F_DONE       :",
		"DTU_Insert   :",
		"DTU_Insert1  :",
		"RF_Insert    :",
		"EXT_Insert	  :",
 	};
#endif

///////////////////////////////////////////////


	INT8U FNDi = 0;
	INT8U FNDj = 0;
	INT32U testFNDCnt = 0;
	INT8U FNDSTOPFlag = SET;


#else
////////////////////
	extern INT8U gTestFlag;
	extern INT8U tTestFlag;

	extern INT16U Argc;
	extern INT8U *Argv[MAX_SARGC];
	extern INT8U DTUTest;

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

INT8U RAMAccesscheck(void);
  
void Parser(char *buff);

INT8U GetCommand(INT8U Sio);
INT8U CommandInterpret(INT8U Sio);

int Atox(char *Buff);
char Atox8(char *Buff);
char Atox4(char Ascii);
int lower(char c);



INT32S sSPI_DataRead(DevSPIxStr *Devptr, INT8U Path, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen);
INT32S sSPI_SetRegister(DevSPIxStr *Devptr, INT8U Path, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen);

//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

