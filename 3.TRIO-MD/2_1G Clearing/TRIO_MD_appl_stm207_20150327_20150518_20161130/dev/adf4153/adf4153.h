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
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.08.__
 *
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
// Control Bits Definition
//////////////////////////
typedef struct {
	INT32U RFNDividerReg;
	INT32U RFRDividerReg;
	INT32U RFControlReg;
	INT32U RFNoiseSpurReg;

} _ADF4153Reg;


#ifdef DEV_ADF4153

#define ADF4153DELAY	10
enum {

	__RFNDividerRegSel = 0,
	__RFRDividerRegSel,
	__RFControlRegSel,
	__RFNoiseSpurRegSet,
};

typedef union {
	INT32U Data;

	struct {
		INT32U tot			:24;
	} Grp;

	struct {
		INT32U CtrlBits		:2;
		INT32U FRACVAL		:12;
		INT32U INTVAL		:9;
			#define __NOR		0
			#define __FL		1
		INT32U FL			:1;
	} Bit;

} _RFNDividerReg, *_pRFNDividerReg;


typedef union {
	INT32U Data;

	struct {
		INT32U tot			:24;
	} Grp;

	struct {
		INT32U CtrlBits		:2;
		INT32U MODVAL		:12;
		INT32U R			:4;

			#define __RF_PR4			0	// RF prescaler
			#define __RF_PR8			1	// RF prescaler
		INT32U RFPRESCALER	:1;
		INT32U 				:1;

			#define __3STATE		0
			#define __DIGLock		1
			#define	__NDIVOut		2
			#define __LogicHigh		3
			#define __RDIVOut		4
			#define __ANGLock		5
			#define __FLSwitch		6
			#define __LogicLow		7
		INT32U MUXOUT		:3;

			#define __NOR			0
			#define __LOADRsync		1
		INT32U LOADCTRL		:1;

	} Bit;

} _RFRDividerReg, *_pRFRDividerReg;


enum {
    __ICP2_7K_1_18mA,//		0
    __ICP2_7K_2_46mA,//		1
    __ICP2_7K_3_54mA,//		2
    __ICP2_7K_4_72mA,//		3
    __ICP2_7K_5_90mA,//		4
    __ICP2_7K_7_08mA,//		5
    __ICP2_7K_8_26mA,//		6
    __ICP2_7K_9_45mA,//		7

    __ICP2_7K_0_59mA,//		8
    __ICP2_7K_1_23mA,//		9
    __ICP2_7K_1_77mA,//		10
    __ICP2_7K_2_36mA,//		11
    __ICP2_7K_2_95mA,//		12
    //__ICP2_7K_3_54mA,//		13
    __ICP2_7K_4_13mA = 14,//		14
    __ICP2_7K_4_73mA//		15
};

enum {
    __ICP5_1K_0_63mA,// 	0
    __ICP5_1K_1_25mA,// 	1
    __ICP5_1K_1_88mA,// 	2
    __ICP5_1K_2_50mA,// 	3
    __ICP5_1K_3_13mA,// 	4
    __ICP5_1K_3_75mA,// 	5
    __ICP5_1K_4_38mA,// 	6
    __ICP5_1K_5_00mA,// 	7

    __ICP5_1K_0_31mA,// 	8
    __ICP5_1K_0_53mA,// 	9
    __ICP5_1K_0_94mA,// 	10
    //__ICP5_1K_1_25mA,// 	11
    __ICP5_1K_1_57mA = 12,// 	12
    //__ICP5_1K_1_88mA,// 	13
    __ICP5_1K_2_19mA = 14,// 	14
    //__ICP5_1K_2_50mA,// 	15
};

enum {
    __ICP10K_0_32mA,// 	0
    __ICP10K_0_64mA,// 	1
    __ICP10K_0_96mA,// 	2
    __ICP10K_1_28mA,// 	3
    __ICP10K_1_59mA,// 	4
    __ICP10K_1_92mA,// 	5
    __ICP10K_2_23mA,// 	6
    __ICP10K_2_55mA,// 	7

    __ICP10K_0_16mA,// 	8
    //__ICP10K_0_32mA,// 	9
    __ICP10K_0_48mA = 10,// 	10
    //__ICP10K_0_64mA,// 	11
    __ICP10K_0_80mA = 12,// 	12
    //__ICP10K_0_96mA,// 	13
    __ICP10K_1_12mA = 14,// 	14
    //__ICP10K_1_28mA,// 	15
};
typedef union {
	INT32U	Data;

	struct {
		INT32U tot		:16;
	} Grp;

	struct {
		INT32U CtrlBits		:2;

			#define __DISABLE		0
			#define __ENABLE		1
		INT32U RFCOUNTERRst	:1;

			#define __DISABLE		0
			#define __RFThreeState	1
		INT32U RFCPThreeSts	:1;

			#define __NOR			0
			#define __RFPWRDN		1
		INT32U RFPWRDN		:1;

			#define __24PFD			0
			#define __40PFD			1
		INT32U LDP			:1;

			#define __NEG			0
			#define __POS			1
		INT32U RFPDPOL		:1;

		INT32U RFCPCURSet	:4;

			#define __DISABLE			0
			#define __ENABLE			1
		INT32U RFDOUBLER	:1;

		INT32U RFRYNC		:4;
	} Bit;

} _RFControlReg, *_pRFControlReg;


typedef union {
	INT32U	Data;

	struct {
		INT32U tot			:11;
	} Grp;


	struct {
		INT32U CtrlBits		:2;
			#define __LowestSpur		0
			#define __LowNoise			7 << 4
			#define __LowestNoise		0xf1
		INT32U NOISEMODE	:8;
		INT32U 				:1;
	} Bit;

} _RFNoiseReg, *_pRFNoiseReg;


#endif

//////////////////////////////////////////////////////////////////////////////////////
// Ref
typedef struct {
	INT32U rfrq;
	INT32U rsol;
	
	void (*SetClk)(void);
	void (*RstClk)(void);
	void (*SetData)(void);
	void (*RstData)(void);
	void (*SetEn)(void);
	void (*RstEn)(void);

} _ADF4252Str, *_pADF4252Str;


void ADF4153Create(_pADF4252Str ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)(),
							  void (*SetEn)(), void (*RstEn)() );
void ADF4153Init(INT32U rfrq, INT32U rsol, _pADF4252Str ptr);
_ADF4153Reg ADF4153RFOutput(INT32U fvco, _pADF4252Str ptr, INT8U nfullCtrl);

#define RefFreq				19200000L		// 10M Hz
#define FreqStep			100000L			// 100K Hz 

void SetRxPllClk(void);
void RstRxPllClk(void);
void SetRxPllData(void);
void RstRxPllData(void);
void SetRxPllEnA(void);
void RstRxPllEnA(void);
void SetRxPllEnB(void);
void RstRxPllEnB(void);
void SetRxPllEnC(void);
void RstRxPllEnC(void);

void SetTxPllClk(void);
void RstTxPllClk(void);
void SetTxPllData(void);
void RstTxPllData(void);
void SetTxPllEnA(void);
void RstTxPllEnA(void);
void SetTxPllEnB(void);
void RstTxPllEnB(void);
void SetTxPllEnC(void);
void RstTxPllEnC(void);


////////////////////////////////////////////////////////////////////////////////
#ifdef DEV_ADF4153
//////////////////
	_ADF4252Str pRxApllB, pRxBpllB, pRxCpllB; 
	_ADF4252Str pTxApllB, pTxBpllB, pTxCpllB; 

	_pADF4252Str pRxApll = &pRxApllB;
	_pADF4252Str pRxBpll = &pRxBpllB;
	_pADF4252Str pRxCpll = &pRxCpllB;

	_pADF4252Str pTxApll = &pTxApllB;
	_pADF4252Str pTxBpll = &pTxBpllB;
	_pADF4252Str pTxCpll = &pTxCpllB;


	extern unsigned long int USART1Printf( const char *format, ... );
	extern void ExpioBitSet (unsigned short int Bitaddr);
	extern void ExpioBitRst (unsigned short int Bitaddr);

////////////////////////////////////////////////////////////////////////////////
#else
/////////////
	extern _pADF4252Str pRxApll;
	extern _pADF4252Str pRxBpll;
	extern _pADF4252Str pRxCpll;

	extern _pADF4252Str pTxApll;
	extern _pADF4252Str pTxBpll;
	extern _pADF4252Str pTxCpll;

////////////////////////////////////////////////////////////////////////////////
#endif
////////////////////////////////////////////////////////////////////////////////

#define _RxIn1PllInit()		{		ADF4153Create(pRxApll, SetRxPllClk, RstRxPllClk, SetRxPllData, RstRxPllData ,SetRxPllEnA, RstRxPllEnA); \
									ADF4153Init(RefFreq, FreqStep, pRxApll); \
							}
#define _RxIn2PllInit()		{		ADF4153Create(pRxBpll, SetRxPllClk, RstRxPllClk, SetRxPllData, RstRxPllData ,SetRxPllEnB, RstRxPllEnB); \
									ADF4153Init(RefFreq, FreqStep, pRxBpll); \
							}

#define _RxOutPllInit()		{		ADF4153Create(pRxCpll, SetRxPllClk, RstRxPllClk, SetRxPllData, RstRxPllData ,SetRxPllEnC, RstRxPllEnC); \
									ADF4153Init(RefFreq, FreqStep, pRxCpll); \
							}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define _TxOut1PllInit()	{		ADF4153Create(pTxApll, SetTxPllClk, RstTxPllClk, SetTxPllData, RstTxPllData ,SetTxPllEnA, RstTxPllEnA); \
									ADF4153Init(RefFreq, FreqStep, pTxApll); \
							}
#define _TxOut2PllInit()	{		ADF4153Create(pTxBpll, SetTxPllClk, RstTxPllClk, SetTxPllData, RstTxPllData ,SetTxPllEnB, RstTxPllEnB); \
									ADF4153Init(RefFreq, FreqStep, pTxBpll); \
							}

#define _TxInPllInit()		{		ADF4153Create(pTxCpll, SetTxPllClk, RstTxPllClk, SetTxPllData, RstTxPllData ,SetTxPllEnC, RstTxPllEnC); \
									ADF4153Init(RefFreq, FreqStep, pTxCpll); \
							}

#define _RxIn1PllOut(fvco, nfull)	ADF4153RFOutput(fvco, pRxApll, nfull)
#define _RxIn2PllOut(fvco, nfull)	ADF4153RFOutput(fvco, pRxBpll, nfull)
#define _RxOutPllOut(fvco, nfull)	ADF4153RFOutput(fvco, pRxCpll, nfull)

#define _TxOut1PllOut(fvco,nfull)	ADF4153RFOutput(fvco, pTxApll, nfull)
#define _TxOut2PllOut(fvco,nfull)	ADF4153RFOutput(fvco, pTxBpll, nfull)
#define _TxInPllOut(fvco, nfull)	ADF4153RFOutput(fvco, pTxCpll, nfull)



////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

