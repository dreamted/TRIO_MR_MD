////////////////////////////////////////////////////////////////////////////////
// Control Bits Definition
//////////////////////////
enum {
	__IFRCounter = 0,
	__IFNCounter,
	__RFRCounter,
	__RFNCounter
};

typedef union {
	INT32U Data;

	struct {
		INT32U	tot		:22;
	} Grp;
	
	struct {
		INT32U C		:2;
		INT32U R		:15;
		//INT32U pMode	:5;
			#define __NEG		0
			#define __POS		1
		INT32U POL		:1;	// polarity
			#define __ICPOLOW	0
			#define __ICPOHIG	1
		INT32U ICPO		:1;
			#define __NOR		0
			#define __TRI		1
		INT32U TRI		:1;
			#define __LDNO		0
			#define __LDEN		1
		INT32U LD		:2;
		//INT32U F0		:1;			// default 0
			
	} Bit;
} _RCounterReg;

typedef union {
	INT32U Data;

	struct {
		INT32U tot		:22;
	} Grp;

	struct {
		INT32U C		:2;
		INT32U A		:7;
		INT32U B		:11;
			#define __n233x_IF_PR8		0	// IF prescaler
			#define __n233x_IF_PR16		1

			#define __n2330_RF_PR_32	0
			#define __n2330_RF_PR_64	1	// 2330 RF Prescaler

			#define __n2332_RF_PR_64	0
			#define __n2332_RF_PR_128	1	// 2332 RF Prescaler
		INT32U PR		:1;
			#define __PWUP				0
			#define __PWDN				1
		INT32U PWEN		:1;
	} Bit;
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

	INT32U IFfvco;
	INT32U RFfvco;
	
} _Pll2332Str, *_pPll2332Str;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
#ifdef PLL_C
//////////////////////////////
	_Pll2332Str p2GApll, p3GBpll;


////////////////////////////////////////////////////////////////////////////////
#else
//////////////////////////////
	extern _Pll2332Str p2GApll, p3GBpll ;

////////////////////////////////////////////////////////////////////////////////
#endif

//#define PLL_DEFINE			0
#define PLL_DELAY			500


#define RefFreq				13000000L		// 10M Hz
#define IFFreqStep			260000L			// 260K  Hz 
#define RFFreqStep			50000L			// 100K  Hz 

#define _2GPllInit()		{		Pll2322Create(&p2GApll, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnA, RstPllEnA); \
									\
							}
#define _3GPllInit()		{		Pll2322Create(&p3GBpll, SetPllClk, RstPllClk, SetPllData, RstPllData ,SetPllEnB, RstPllEnB); \
									\
							}

// 2756MHz
#define _2GIFPllOut(fvco)	{	\
								Pll2332Init(RefFreq, IFFreqStep, &p2GApll); \
								Pll2332_IFOutput(fvco, &p2GApll);\
							}
// 1690MHz
#define _2GRFPllOut(fvco)	{	\
								Pll2332Init(RefFreq, RFFreqStep, &p2GApll); \
								Pll2332_RFOutput(fvco, &p2GApll);\
							}

// 2756MHz
#define _3GIFPllOut(fvco)	{	\
								Pll2332Init(RefFreq, IFFreqStep, &p3GBpll); \
								Pll2332_IFOutput(fvco, &p3GBpll);\
							}
// 2090MHz
#define _3GRFPllOut(fvco)	{	\
								Pll2332Init(RefFreq, RFFreqStep, &p3GBpll); \
								Pll2332_RFOutput(fvco, &p3GBpll);\
							}



void Pll2322Create(_pPll2332Str ptr, 
	void (*SetClk)(), void (*RstClk)(), 
		void (*SetData)(), void (*RstData)(),
		  void (*SetEn)(), void (*RstEn)() );
void Pll2332Init(INT32U rfrq, INT32U dRatio, _pPll2332Str ptr);	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
void Pll2332_RFOutput(INT32U fvco, _pPll2332Str ptr);
void Pll2332_IFOutput(INT32U fvco, _pPll2332Str ptr);

void SetPllClk(void);
void RstPllClk(void);
void SetPllData(void);
void RstPllData(void);
void SetPllEnA(void);	// PLL IN1
void RstPllEnA(void);	// PLL IN1
void SetPllEnB(void);	// PLL IN2
void RstPllEnB(void);	// PLL IN2

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

