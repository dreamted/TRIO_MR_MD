/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_adc.h
* Author             : MCD Application Team
* Version            : V1.0
* Date               : 10/08/2007
* Description        : This file contains all the functions prototypes for the
*                      ADC firmware library.
********************************************************************************/
////////////////////////////////////////////////////////////////////////////////
// Analog to Digital Converter
#define _ADC

#ifdef ADC_C
	#define _USR_EXT_ADC
#else
	#define _USR_EXT_ADC	extern 
#endif

 #define __ADCAVR	100



#define ADCIDLE				0
#define ADCING				1
#define ADCFINISH			2



typedef union{
	vu32 Data;
	struct	{
		u32 B0		:1;
		u32 B1		:1;
		u32 B2		:1;
		u32 B3		:1;
		u32 B4		:1;
		u32 B5		:1;
		u32 B6		:1;
		u32 B7		:1;
		u32 B8		:1;
		u32 B9		:1;
		u32 B10		:1;
		u32 B11		:1;
		u32 B12		:1;
		u32 B13		:1;
		u32 B14		:1;
		u32 B15		:1;
	};
} AdcChanelEn;	// ADC control Register 2

enum
{
#if 1

	FwdOutAvgVolt_2G = 0,		// 0
	FwdOutPeakVolt_2G, 			// 1
	RvsOutVolt_2G, 				// 2
	FwdOutAvgVolt_LTE, 			// 3
	FwdOutPeakVolt_LTE, 		// 4
	RvsOutVolt_LTE, 			// 5
	
	FwdInVolt_CDMALTE,			// 6
	RvsOutVolt_CDMALTE,			// 7
	RvsInVolt_3G, 				// 8
	FwdOutAvgVolt_LTE_A2,		// 9
	
	FwdInVolt_LTE_A,			// 10
	Fwd1InVolt_LTE, 			// 11
	Rvs1OutVolt_LTE, 			// 12
	Fwd1OutAvgVolt_LTE_A2,		// 13
	
	Rvs1OutVolt_LTE_A2, 		// 14
	Curr_Temp,					// 15
	FwdOutAvgVolt_CDMALTE, 		// 16
	FwdInVolt_3G, 				// 17    
	
	RvsOutVolt_3G, 				// 18
	FwdOutPeakVolt_LTE_A2,		// 19    
	FwdOutAvgVolt_LTE_A,		// 20
	Fwd1OutAvgVolt_LTE, 		// 21
	
	FwdInVolt_LTE_A_1,			// 22
	Fwd1OutPeakVolt_LTE_A2, 	// 23
	RvsInVolt_LTE_A_1,			// 24  xxxxxxxxxxxx
	PSUDCVolt, 					// 25
	
	FwdOutPeakVolt_CDMALTE, 	// 26
	FwdOutAvgVolt_3G, 			// 27
	FwdOutAvgVolt_LTE_A1, 		// 28
	RvsOutVolt_LTE_A1,			// 29
	
	RvsInVolt_LTE_A,			// 30  xxxxxxxxxxxxxxxx
	Fwd1OutPeakVolt_LTE, 		// 31
	Fwd1OutAvgVolt_LTE_A1,		// 32
	FwdOutAvgVolt_LTE_A_1, 		// 33
	
	RvsOutVolt_LTE_A_1, 		// 34
	DCOutVolt, 					// 35
	RvsInVolt_CDMALTE,			// 36
	FwdOutPeakVolt_3G, 			// 37
	
	FwdOutPeakVolt_LTE_A1, 		// 38
	RvsOutVolt_LTE_A2,			// 39
	RvsOutVolt_LTE_A,			// 40
	Rvs1InVolt_LTE, 			// 41
	
	Fwd1OutPeakVolt_LTE_A1, 	// 42
	Rvs1OutVolt_LTE_A1, 		// 43
    SpVolt,						// 44
	Sp1_Volt,					// 45
#endif

	_ADCIndex_Max,
};



////////////////////////////////////////////////////////////////////////////////
// Global variable
////////////////////////////////
#define __ADC_MAX	46
#define __ADC2MAX	15

_USR_EXT_ADC AdcChanelEn AdcEn1;
_USR_EXT_ADC INT16U ADC_DATA[__ADC_MAX];
_USR_EXT_ADC INT32U ADC_SUM[__ADC_MAX];
_USR_EXT_ADC INT16U ADC_AVR[__ADCMAX][__ADCAVR];
_USR_EXT_ADC INT16U ADC_WRCNT[__ADCMAX];

_USR_EXT_ADC INT8U ADCSTART[__ADCMAX];
_USR_EXT_ADC INT8U ASTART;
_USR_EXT_ADC INT8U ADCSubIndex;


#ifdef ADC_C
  	INT8U ADCIndex = 0;

	const INT32U AdcEn = (		(1 << ADC_Channel_8) |
								(1 << ADC_Channel_0) |
								(1 << ADC_Channel_14)|
								(1 << ADC_Channel_7) |
								(1 << ADC_Channel_6) |
								(1 << ADC_Channel_9) |
								(1 << ADC_Channel_1) |
								(1 << ADC_Channel_2) |
								(1 << ADC_Channel_3) |
								(1 << ADC_Channel_4) |
								(1 << ADC_Channel_5) |
								(1 << ADC_Channel_10) |
								(1 << ADC_Channel_11) |
								(1 << ADC_Channel_12) |
								(1 << ADC_Channel_13) |	
								(1 << ADC_Channel_15) |			
								  0);
#else
 
#endif

 
#define DET0				ADC_Channel_0
//#define DET1				ADC_Channel_1
#define DET2				ADC_Channel_2
#define DET3				ADC_Channel_3
//#define DET4				ADC_Channel_4
#define DET5				ADC_Channel_5
#define DET6				ADC_Channel_6
#define DET7				ADC_Channel_7
#define DET8				ADC_Channel_8
#define DET9				ADC_Channel_9
#define DET10				ADC_Channel_10
#define DET11				ADC_Channel_11
#define DET12				ADC_Channel_12
#define DET13				ADC_Channel_13
#define DET14				ADC_Channel_14
#define DET15				ADC_Channel_15



////////////////////////////////////////////////////////////////////////////////
// function prototype
////////////////////////////////////
int ReadEnvTempTable(int channel);
void ADCInit(int INT_EN);
void ADC_IRQHandler(void);
void ADC1_SWStart(void);
void ADCChannelSEL(void);
void SwapData(INT16U *a, INT16U *b);


void AutoGetAdcValue(void);
void GetAdcValueInt(INT8U channel);
INT16U GetAdcValue(INT8U channel);

INT16S Get_AdcValue(INT8U channel);

INT16U AdctoVolt33V(INT16U Data);
INT16U AdctoVolt5opamp(INT16U Data);

extern unsigned char USART1PutChar(unsigned char Data);

INT8U ADC_CheckFinish(INT8U channel);
void ADC_ChannelEnable(INT8U channel);

INT16U SelectSortMinMax(INT16U *aptr, INT16U *minvalue, INT16U *Maxvalue, INT16U nlen);
INT16U SelectSort(INT16U *aptr, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen);
INT16U SelectSort_1(INT16U *aptr,INT16U *minvalue, INT16U *Maxvalue, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U MAXGARBAGENO_1, INT16U MINGARBAGENO_1, INT16U nlen);


INT16U Detect_SUM(INT16U *aptr,INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen);

///////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

