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
 * - used for LMX2306/LMX2316/LMX2326
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
		INT32U	tot		:21;
	} Grp;
	
	struct {
		INT32U C		:2;
		INT32U R		:14;

		INT32U TEST		:4;
			#define __3CYCLE			0
			#define __5CYCLE			1
		INT32U LDPRE	:1;

	} Bit;
} _RCounterReg;

typedef union {
	INT32U Data;

	struct {
		INT32U tot		:21;
	} Grp;

	struct {
		INT32U C		:2;
		INT32U A		:5;
		INT32U B		:13;
			#define __ICP250uA			0	// the charge pump current magnitute
			#define __ICP1mA			1
		INT32U GOBIT	:1;					// Set
	} Bit;
} _NCounterReg;


typedef union {
	INT32U Data;

	struct {
		INT32U tot			:20;
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
		INT32U TIMEOUTEN	:1;
		INT32U TIMEOUTCNT	:4;
		INT32U TEST			:3; // Set 0
		INT32U              :1;
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
	
} _Pll2336Str, *_pPll2336Str;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#ifdef PLL_C
//////////////////////////////
		_Pll2336Str pLoApllB, pLoBpllB, pLoCpllB, pLoDpllB; 

		_pPll2336Str pLoApll = &pLoApllB;
		_pPll2336Str pLoBpll = &pLoBpllB;
		_pPll2336Str pLoCpll = &pLoCpllB;

////////////////////////////////////////////////////////////////////////////////
#else
//////////////////////////////
	extern _pPll2336Str pLoApll;
	extern _pPll2336Str pLoBpll;
	extern _pPll2336Str pLoCpll;

////////////////////////////////////////////////////////////////////////////////
#endif

#define RefFreq				10000000L		// 10M Hz
#define FreqStep			40000L			// 40K  Hz 

#define _RxIn1PllInit()		{		Pll2326Create(pLoApll, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnA, RstPllEnA); \
									Pll2326Init(RefFreq, FreqStep, pLoApll); \
							}
#define _RxIn2PllInit()		{		Pll2326Create(pLoBpll, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnB, RstPllEnB); \
									Pll2326Init(RefFreq, FreqStep, pLoBpll); \
							}

#define _RxOutPllInit()		{		Pll2326Create(pLoCpll, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnC, RstPllEnC); \
									Pll2326Init(RefFreq, FreqStep, pLoCpll); \
							}

#define _RxIn1PllOut(fvco)	Pll2326_Output(fvco, pLoApll)
#define _RxIn2PllOut(fvco)	Pll2326_Output(fvco, pLoBpll)
#define _RxOutPllOut(fvco)	Pll2326_Output(fvco, pLoCpll)


//////////////////////////////
void Pll2326Create(_pPll2336Str ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)(),
							  void (*SetEn)(), void (*RstEn)() );

void Pll2326Init(INT32U rfrq, INT32U dRatio, _pPll2336Str ptr);	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
void Pll2326_Output(INT32U fvco, _pPll2336Str ptr);

void SetPllClk(void);
void RstPllClk(void);
void SetPllData(void);
void RstPllData(void);
void SetPllEnA(void);
void RstPllEnA(void);
void SetPllEnB(void);
void RstPllEnB(void);
void SetPllEnC(void);
void RstPllEnC(void);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

