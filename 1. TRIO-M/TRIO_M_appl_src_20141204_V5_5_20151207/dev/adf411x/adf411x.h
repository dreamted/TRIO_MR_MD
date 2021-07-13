/*******************************************************************************
 *
 * This module contains the function HMS39C7092 Header source file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2007- bizistyle(bgyoon@hanafos.com) All rights reserved.
 * - used for LMX2306/LMX2316/LMX411x
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.08.__
 *
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
// Control Bits Definition
//////////////////////////
enum {
		
	__RCounter = 0,
	__NCounter,
	__FUNCSet,
	__INIT
};

typedef union {
	INT32U Data;

	struct {
		INT32U	tot		:24;
	} Grp;
	
	struct {
		INT32U C		:2;
		INT32U R		:14;

		INT32U TEST		:4;
		INT32U LDPRE	:1;
		INT32U SYNC		:1;
		INT32U DLY		:1;
		
		INT32U RSV		:1;

	} Bit;
} _RCounterReg;

typedef union {
	INT32U Data;

	struct {
		INT32U tot		:24;
	} Grp;

	struct {
		INT32U C		:2;
		INT32U A		:6;
		INT32U B		:13;

		INT32U CPGAIN	:1;

		INT32U RSV		:2;
	} Bit;
} _NCounterReg;


typedef union {
	INT32U Data;

	struct {
		INT32U tot			:24;
	} Grp;

	struct {
		INT32U C			:2;
			#define __RSTDISABLED	0
			#define __RSTENABLED	1
		INT32U CNTRST		:1;
			#define __PWRUP			0
			#define __PWRDN			1
		INT32U PWRDN		:1;
			#define __LDTRI			0	// TRI-STATE
			#define __LDDIG			1	// Digital Lock Deteck
			#define __fp			2	// N Devider Freq.
			#define __LDHIGH		3	// Active High
			#define __fr			4	// R Devider Freq.
			#define __OpenDrain		5	// n Channel Open Drain
			#define __SDataOut		6	// Serial Data Out
			#define __LDLOW			7	// Active Low
		INT32U LD			:3;
			#define __NEG			0
			#define __POS			1
		INT32U POL			:1; // polarity
			#define __CPNOR			0
			#define __CPTRI			1
		INT32U CPTRI		:1;
			#define __NOFAST		0
		INT32U FLOCKEN		:1;
		INT32U FLOCKCTRL	:1;
		INT32U TIMEOUTCNT	:4;
		INT32U CUR1SET		:3;
		INT32U CUR2SET		:3;
//		INT32U PWREN        :1;
		INT32U PWRDN2       :1;
		INT32U PLVALUE		:2;
		
	} Bit;
} _FUNCReg;


//////////////////////////////////////////////////////////////////////////////////////
// Ref 
typedef struct {
	INT32U rfrq;
	INT32U dRatio;
	INT32U PR;
	void (*SetClk)(void);
	void (*RstClk)(void);
	void (*SetData)(void);
	void (*RstData)(void);
	void (*SetEn)(void);
	void (*RstEn)(void);
	
} _Pll411xStr, *_pPll411xStr;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#ifdef PLL_C
//////////////////////////////
		_Pll411xStr pLoApllB, pLoBpllB, pLoCpllB; 

		_pPll411xStr pLoApll = &pLoApllB;
		_pPll411xStr pLoBpll = &pLoBpllB;
		
		_pPll411xStr pLoCpll = &pLoCpllB;

////////////////////////////////////////////////////////////////////////////////
#else
//////////////////////////////
	extern _pPll411xStr pLoApll;
	extern _pPll411xStr pLoBpll;
	extern _pPll411xStr pLoCpll;


////////////////////////////////////////////////////////////////////////////////
#endif

#define RefFreq				13000000L		// 13MHz
#define FreqStep			25000L			// 0.1MHz = 100KHz


//#define PLL_2G		0
//#define	PLL_3G		1

#define _FWDRVS1PllInit()		{		Pll411xCreate(pLoApll, SetPllClkA, RstPllClkA, SetPllDataA, RstPllDataA ,SetPllEnA, RstPllEnA); \
									Pll411xInit(RefFreq, FreqStep, pLoApll); \
							}
#define _FWDRVS2PllInit()		{		Pll411xCreate(pLoBpll, SetPllClkA, RstPllClkA, SetPllDataA, RstPllDataA ,SetPllEnB, RstPllEnB); \
									Pll411xInit(RefFreq, FreqStep, pLoBpll); \
							}

#define _PllInit_LTE()		{		Pll411xCreate(pLoCpll, SetPllClkA, RstPllClkA, SetPllDataA, RstPllDataA ,SetPllEnC, RstPllEnC); \
									Pll411xInit(RefFreq, FreqStep, pLoCpll); \
							}


#define _FWDRVS1_PllOut(fvco)	Pll411x_Output(fvco, pLoApll)
#define _FWDRVS2_PllOut(fvco)	Pll411x_Output(fvco, pLoBpll)
#define _PllOut_LTE(fvco)		Pll411x_Output(fvco, pLoCpll)


//////////////////////////////
void Pll411xCreate(_pPll411xStr ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)(),
							  void (*SetEn)(), void (*RstEn)() );

void Pll411xInit(INT32U rfrq, INT32U dRatio, _pPll411xStr ptr);	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
void Pll411x_Output(INT32U fvco, _pPll411xStr ptr);

void SetPllClkA(void);
void RstPllClkA(void);
void SetPllDataA(void);
void RstPllDataA(void);
void SetPllEnA(void);
void RstPllEnA(void);

void SetPllClkB(void);
void RstPllClkB(void);
void SetPllDataB(void);
void RstPllDataB(void);
void SetPllEnB(void);
void RstPllEnB(void);

void SetPllEnC(void);
void RstPllEnC(void);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

