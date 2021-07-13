////////////////////////////////////////////////////////////////////////////////
// Control Bits Definition
//////////////////////////
enum {
	__NCounter = 0,
	__RCounter,
};

// SW
#define __32		1
#define __64		0
// CS
#define __6p0mA		1
#define __1p5mA		0
// LDS
#define __fout		1
#define __LD		0

typedef union {
	INT32U Data;

	///struct {
	//	INT32U	tot		:19;
	//} Grp;
	
	struct {
		INT32U CNT		:1;
		INT32U R		:14;
		INT32U SW		:1;	// polarity
		INT32U FC		:1;
		INT32U LDS		:1;
		INT32U CS		:1;
	};
} _RCounterReg;

typedef union {
	INT32U Data;

	//struct {
	//	INT32U tot		:19;
	//} Grp;

	struct {
		INT32U CNT		:1;
		INT32U A		:7;
		INT32U N		:11;
	};
} _NCounterReg;

//////////////////////////////////////////////////////////////////////////////////////
// Ref 
typedef struct {
	INT32U rfrq;
	INT32U dRatio;
	INT32U PR;
	void (*SetPllClk)(void);
	void (*RstPllClk)(void);
	void (*SetPllData)(void);
	void (*RstPllData)(void);
	void (*SetPllEn)(void);
	void (*RstPllEn)(void);

	INT32U fvco;
	
} _MB15E07SLStr, *_pMB15E07SLStr;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#ifdef PLL_C
//////////////////////////////
	_MB15E07SLStr p4GApll;
	_MB15E07SLStr p3GApll;
	_MB15E07SLStr p3GApll_1;


////////////////////////////////////////////////////////////////////////////////
#else
//////////////////////////////
	extern _MB15E07SLStr p4GApll;
	extern _MB15E07SLStr p3GApll;
	extern _MB15E07SLStr p3GApll_1;

////////////////////////////////////////////////////////////////////////////////
#endif

//#define PLL_DEFINE			0
#define PLL_DELAY			500


#define RefFreq				26000000L		// 10M Hz
#define FreqStep			50000L			// 100K  Hz 

#define PllInit_4G()		{	LM15E07SLCreate(&p4GApll, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnA, RstPllEnA); \
								\
							}
#define PllInit_3G_GT()		{	LM15E07SLCreate(&p3GApll, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnB, RstPllEnB); \
								\
							}
#define PllInit_3G()		{	LM15E07SLCreate(&p3GApll_1, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnC, RstPllEnC); \
								\
							}

// 2756MHz
#define PllOut_4G(fvco)	{	\
								LM15E07SLInit(RefFreq, FreqStep, &p4GApll); \
								LM15E07SLOutput(fvco, &p4GApll);\
							}

#define PllOut_3G_GT(fvco)	{	\
								LM15E07SLInit(RefFreq, FreqStep, &p3GApll); \
								LM15E07SLOutput(fvco, &p3GApll);\
							}

#define PllOut_3G(fvco)	{	\
								LM15E07SLInit(RefFreq, FreqStep, &p3GApll_1); \
								LM15E07SLOutput(fvco, &p3GApll_1);\
							}

void LM15E07SLCreate(_pMB15E07SLStr ptr, 
	void (*SetClk)(), void (*RstClk)(), 
		void (*SetData)(), void (*RstData)(),
		  void (*SetEn)(), void (*RstEn)() );
void LM15E07SLInit(INT32U rfrq, INT32U dRatio, _pMB15E07SLStr ptr);	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
void LM15E07SLOutput(INT32U fvco, _pMB15E07SLStr ptr);

void SetPllClk(void);
void RstPllClk(void);
void SetPllData(void);
void RstPllData(void);
void SetPllEnA(void);	// PLL IN1
void RstPllEnA(void);	// PLL IN1
void SetPllEnB(void);	// PLL IN1
void RstPllEnB(void);	// PLL IN1
void SetPllEnC(void);	// PLL IN1
void RstPllEnC(void);	// PLL IN1

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

