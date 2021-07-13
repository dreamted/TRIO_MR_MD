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
		INT32U PWREN        :1;
		INT32U PLVALUE		:2;
		
	} Bit;
} _FUNCReg;


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#ifdef PLL_C
//////////////////////////////
#if 0
	INT32U	dReffreq[2];
	INT32U	dStep[2];
	INT32U	dPre[2];
#endif

#if 1
	INT32U	dReffreq[5];
	INT32U	dStep[5];
	INT32U	dPre[5];
#endif


////////////////////////////////////////////////////////////////////////////////
#else
//////////////////////////////


////////////////////////////////////////////////////////////////////////////////
#endif

#define RefFreq				10000000L		// 13MHz
#define FreqStep			50000L			// 0.1MHz = 100KHz
#define	PreScl				2				// 1: 16/17, 2: 32/33


//////////////////////////////
void Pll411xInit(INT32U rfrq, INT32U dRatio, INT8U Path);
void Pll411x_Output(INT32U fvco, INT8U Path);

void SetPllClk(INT8U Path);
void RstPllClk(INT8U Path);
void SetPllData(INT8U Path);
void RstPllData(INT8U Path);
void SetPllEn(INT8U Path);
void RstPllEn(INT8U Path);


////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

