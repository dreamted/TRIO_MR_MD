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

#define ADCIDLE				0
#define ADCING				1
#define ADCFINISH			2

////////////////////////////////////////////////////////////////////////////////
// 1 time: 25us(4MHz)
////////////////////////////////
#define __ADCAVR			100

#define __RvsADCAVR			10
#define __EtcADCAVR			10

////////////////////////////////////////////////////////////////////////////////
// Global variable
////////////////////////////////
#define __ADC00_MAX			__ADCAVR
#define __ADC01_MAX			__ADCAVR
#if 1
#define __ADC02_MAX			__ADCAVR
#define __ADC03_MAX			__ADCAVR
#define __ADC04_MAX			__ADCAVR
#define __ADC05_MAX			__ADCAVR
#define __ADC06_MAX			__ADCAVR
#define __ADC07_MAX			__ADCAVR
#define __ADC08_MAX			__ADCAVR
#define __ADC09_MAX			__ADCAVR
#define __ADC10_MAX			__ADCAVR
#define __ADC11_MAX			__ADCAVR
#define __ADC12_MAX			__RvsADCAVR
#define __ADC13_MAX			__RvsADCAVR
#define __ADC14_MAX			__EtcADCAVR
#define __ADC15_MAX			__EtcADCAVR
#endif

#define ADC_00_USED
#define ADC_01_USED
#if 0
#define ADC_02_USED
#define ADC_03_USED
#define ADC_04_USED
#define ADC_05_USED
#define ADC_06_USED
#define ADC_07_USED
#define ADC_08_USED
#define ADC_09_USED
#define ADC_10_USED
#define ADC_11_USED
#define ADC_12_USED
#define ADC_13_USED
#define ADC_14_USED
#define ADC_15_USED
#endif
#if 0
enum
{
	FwdOutAvgVolt_2G = 0,		// 0
	FwdOutPeakVolt_2G,			// 1
	RvsOutVolt_2G,				// 2
	FwdOutAvgVolt_LTE,			// 3
	FwdOutPeakVolt_LTE, 		// 4
	RvsOutVolt_LTE, 			// 5
	FwdInVolt_CDMALTE,			// 6
	RvsOutVolt_CDMALTE, 		// 7
	FwdOutAvgVolt_CDMALTE,		// 8
	FwdOutPeakVolt_CDMALTE, 	// 9
	RvsInVolt_CDMALTE,			// 10
	FwdOutAvgVolt_3G,			// 11
	FwdOutPeakVolt_3G,			// 12
	FwdInVolt_3G,				// 13	 
	RvsOutVolt_3G,				// 14
	FwdOutAvgVolt_LTE_A2,		// 15
	FwdOutPeakVolt_LTE_A2,		// 16
	RvsOutVolt_LTE_A2,			// 17
	FwdInVolt_LTE_A,			// 18
	FwdOutAvgVolt_LTE_A,		// 19
	RvsOutVolt_LTE_A,			// 20
	RvsOutVolt_LTE_A1,			// 21
	BalanceVolt_CDMA,			// 22
	BalanceVolt_LTE,			// 23
	BalanceVolt_LTE_A,			// 24
	BalanceVolt_WCDMA, 			// 25
	Curr_Temp,					// 26
	PSUDCVolt,					// 27
	RvsInVolt_3G,				// 28
	RvsInVolt_LTE_A,			// 29 xxxxxxxxxxxxxxxx

	_ADCIndex_Max,
};
#endif 

enum
{
	_FwdOutAvgVolt_CDMALTE = 0, 	// 0
	_RvsOutVolt_CDMALTE, 	 		// 1
	_FwdOutAvgVolt_LTE_A,		 	// 2
	_RvsOutVolt_LTE_A,			 	// 3
	_FwdOutAvgVolt_3G,			 	// 4
	_RvsOutVolt_3G,			 		// 5

	Curr_Temp,						// 6
	PSUDCVolt,						// 7
	_ADCIndex_Max1,




};

 
////////////////////////////////////////////////////////////////////////////////
#ifdef ADC_C
/////////////////////////
	const INT32U AdcBuffMax[__ADCMAX] ={
			__ADC00_MAX,
			__ADC01_MAX,
			__ADC02_MAX,
			__ADC03_MAX,
			__ADC04_MAX,
			__ADC05_MAX,
			__ADC06_MAX,
			__ADC07_MAX,
			__ADC08_MAX,
			__ADC09_MAX,
			__ADC10_MAX,
			__ADC11_MAX,
			__ADC12_MAX,
			__ADC13_MAX,
			__ADC14_MAX,
			__ADC15_MAX,
	};

	const INT32U Adc3BuffMax[__ADCMAX] ={
			__ADC00_MAX,
			__ADC01_MAX,
			__ADC02_MAX,
			__ADC03_MAX,
			__ADC04_MAX,
			__ADC05_MAX,
			__ADC06_MAX,
			__ADC07_MAX,
			__ADC08_MAX,
			__ADC09_MAX,
			__ADC10_MAX,
			__ADC11_MAX,
			__ADC12_MAX,
			__ADC13_MAX,
			__ADC14_MAX,
			__ADC15_MAX,
	};



	const INT32U AdcEn = (
#ifdef ADC_00_USED
						(1 << ADC_Channel_0) |
#endif
#ifdef ADC_01_USED
						(1 << ADC_Channel_1) |
#endif
#ifdef ADC_02_USED
						(1 << ADC_Channel_2) |
#endif
#ifdef ADC_03_USED
						(1 << ADC_Channel_3) |
#endif
#ifdef ADC_04_USED
						(1 << ADC_Channel_4) |
#endif
#ifdef ADC_05_USED
						(1 << ADC_Channel_5) |
#endif
#ifdef ADC_06_USED
						(1 << ADC_Channel_6) |
#endif
#ifdef ADC_07_USED
						(1 << ADC_Channel_7) |
#endif
#ifdef ADC_08_USED
						(1 << ADC_Channel_8) |
#endif
#ifdef ADC_08_USED
						(1 << ADC_Channel_9) |
#endif
#ifdef ADC_10_USED
						(1 << ADC_Channel_10) |
#endif
#ifdef ADC_11_USED
						(1 << ADC_Channel_11) |
#endif
#ifdef ADC_12_USED
						(1 << ADC_Channel_12) |
#endif
#ifdef ADC_13_USED
						(1 << ADC_Channel_13) |
#endif
#ifdef ADC_14_USED
						(1 << ADC_Channel_14) |
#endif
#ifdef ADC_15_USED
						(1 << ADC_Channel_15) |
#endif
                        0);



	const INT32U Adc3En = (
#ifdef ADC_00_USED
						(1 << ADC_Channel_0) |
#endif
#ifdef ADC_01_USED
						(1 << ADC_Channel_1) |
#endif
#ifdef ADC_02_USED
						(1 << ADC_Channel_2) |
#endif
#ifdef ADC_03_USED
						(1 << ADC_Channel_3) |
#endif
#ifdef ADC_04_USED
						(1 << ADC_Channel_4) |
#endif
#ifdef ADC_05_USED
						(1 << ADC_Channel_5) |
#endif
#ifdef ADC_06_USED
						(1 << ADC_Channel_6) |
#endif
#ifdef ADC_07_USED
						(1 << ADC_Channel_7) |
#endif
#ifdef ADC_08_USED
						(1 << ADC_Channel_8) |
#endif
#ifdef ADC_08_USED
						(1 << ADC_Channel_9) |
#endif
#ifdef ADC_10_USED
						(1 << ADC_Channel_10) |
#endif
#ifdef ADC_11_USED
						(1 << ADC_Channel_11) |
#endif
#ifdef ADC_12_USED
						(1 << ADC_Channel_12) |
#endif
#ifdef ADC_13_USED
						(1 << ADC_Channel_13) |
#endif
#ifdef ADC_14_USED
						(1 << ADC_Channel_14) |
#endif
#ifdef ADC_15_USED
						(1 << ADC_Channel_15) |
#endif
                        0);



#ifdef ADC_00_USED
	INT16U ADC_AVR_VALUE0[__ADC00_MAX];
#endif
#ifdef ADC_01_USED
	INT16U ADC_AVR_VALUE1[__ADC01_MAX];
#endif 
#ifdef ADC_02_USED
	INT16U ADC_AVR_VALUE2[__ADC02_MAX];
#endif
#ifdef ADC_03_USED
	INT16U ADC_AVR_VALUE3[__ADC03_MAX];
#endif 
#ifdef ADC_04_USED
	INT16U ADC_AVR_VALUE4[__ADC04_MAX];
#endif
#ifdef ADC_05_USED
	INT16U ADC_AVR_VALUE5[__ADC05_MAX];
#endif 
#ifdef ADC_06_USED
	INT16U ADC_AVR_VALUE6[__ADC06_MAX];
#endif
#ifdef ADC_07_USED
	INT16U ADC_AVR_VALUE7[__ADC07_MAX];
#endif
#ifdef ADC_08_USED
	INT16U ADC_AVR_VALUE8[__ADC08_MAX];
#endif
#ifdef ADC_09_USED
	INT16U ADC_AVR_VALUE9[__ADC09_MAX];
#endif
#ifdef ADC_10_USED
	INT16U ADC_AVR_VALUE10[__ADC10_MAX];
#endif
#ifdef ADC_11_USED
	INT16U ADC_AVR_VALUE11[__ADC11_MAX];
#endif
#ifdef ADC_12_USED
	INT16U ADC_AVR_VALUE12[__ADC12_MAX];
#endif
#ifdef ADC_13_USED
	INT16U ADC_AVR_VALUE13[__ADC13_MAX];
#endif
#ifdef ADC_14_USED
	INT16U ADC_AVR_VALUE14[__ADC14_MAX];
#endif
#ifdef ADC_15_USED
	INT16U ADC_AVR_VALUE15[__ADC15_MAX];
#endif
////////////////////////////////////////////////////////////////////////////////



	INT16U *ADC_AVR[__ADCMAX] = {
#ifdef ADC_00_USED
			ADC_AVR_VALUE0,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_01_USED
			ADC_AVR_VALUE1,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_02_USED
			ADC_AVR_VALUE2,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_03_USED
			ADC_AVR_VALUE3,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_04_USED
			ADC_AVR_VALUE4,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_05_USED
			ADC_AVR_VALUE5,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_06_USED
			ADC_AVR_VALUE6,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_07_USED
			ADC_AVR_VALUE7,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_08_USED
			ADC_AVR_VALUE8,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_09_USED
			ADC_AVR_VALUE9,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_10_USED
			ADC_AVR_VALUE10,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_11_USED
			ADC_AVR_VALUE11,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_12_USED
			ADC_AVR_VALUE12,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_13_USED
			ADC_AVR_VALUE13,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_14_USED
			ADC_AVR_VALUE14,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_15_USED
			ADC_AVR_VALUE15,
#else
			(INT16U *)NULL,
#endif
				};


	INT16U *ADC3_AVR[__ADCMAX] = {

#ifdef ADC_00_USED
			ADC_AVR_VALUE0,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_01_USED
			ADC_AVR_VALUE1,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_02_USED
			ADC_AVR_VALUE2,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_03_USED
			ADC_AVR_VALUE3,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_04_USED
			ADC_AVR_VALUE4,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_05_USED
			ADC_AVR_VALUE5,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_06_USED
			ADC_AVR_VALUE6,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_07_USED
			ADC_AVR_VALUE7,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_08_USED
			ADC_AVR_VALUE8,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_09_USED
			ADC_AVR_VALUE9,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_10_USED
			ADC_AVR_VALUE10,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_11_USED
			ADC_AVR_VALUE11,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_12_USED
			ADC_AVR_VALUE12,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_13_USED
			ADC_AVR_VALUE13,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_14_USED
			ADC_AVR_VALUE14,
#else
			(INT16U *)NULL,
#endif

#ifdef ADC_15_USED
			ADC_AVR_VALUE15,
#else
			(INT16U *)NULL,
#endif
				};



////////////////////////////////////////////////////////////////////////////////
#else 
////////////////////////////////
	extern const INT32U AdcBuffMax[__ADCMAX];
	extern const INT32U AdcEn;
	extern INT16U *ADC_AVR[__ADCMAX];

	extern const INT32U Adc3BuffMax[__ADCMAX];
	extern const INT32U Adc3En;

	extern INT16U *ADC3_AVR[__ADCMAX];

////////////////////////////////////////////////////////////////////////////////
#endif
////////////////////////////////
#define __ADC_MAX	30

#define __ADC2MAX	15
#if 1
_USR_EXT_ADC INT16U ADC_DATA[__ADCMAX];
_USR_EXT_ADC INT32U ADC_SUM[__ADCMAX];
_USR_EXT_ADC INT8U ADCIndex;
_USR_EXT_ADC INT8U ADCSTART[__ADCMAX];
_USR_EXT_ADC INT8U ASTART;

_USR_EXT_ADC INT16U ADC_WRCNT[__ADCMAX];



_USR_EXT_ADC INT8U ADC3Index;

_USR_EXT_ADC INT8U ASTART3;

_USR_EXT_ADC INT8U ADC3START[__ADCMAX];

_USR_EXT_ADC INT16U ADC3_WRCNT[__ADCMAX];

#endif
///////////////////////////////////////////////
//_USR_EXT_ADC AdcChanelEn AdcEn1;
_USR_EXT_ADC INT16U ADC_DATA1[__ADC_MAX];


////////////////////////////////////////////
#define DET0_CH123				ADC_Channel_0
#define DET1_CH123				ADC_Channel_1

#if 0
#define DET0_CH123				ADC_Channel_0
#define DET1_CH123				ADC_Channel_1
#define DET2_CH123				ADC_Channel_2
#define DET3_CH123				ADC_Channel_3
#define DET4_CH12				ADC_Channel_4
#define DET5_CH12				ADC_Channel_5
#define DET6_CH12				ADC_Channel_6
#define DET7_CH12				ADC_Channel_7
#define DET8_CH12				ADC_Channel_8
#define DET9_CH12				ADC_Channel_9
#define DET10_CH123				ADC_Channel_10
#define DET11_CH123				ADC_Channel_11
#define DET12_CH123				ADC_Channel_12
#define DET13_CH123				ADC_Channel_13
#define DET14_CH12				ADC_Channel_14
#define DET15_CH12				ADC_Channel_15
#endif

#if 0
#define adcFwdOutDet_CDMA			ADC_Channel_0
#define adcFwdOutDet_LTE			ADC_Channel_1
#define adcFwdOutDet_LTE15M			ADC_Channel_2
#define adcFwdOutDet_WCDMA			ADC_Channel_3
#define adcFwdOutDet_LTEA			ADC_Channel_4
#define adcRvsOutDet_CDMA			ADC_Channel_5
#define adcRvsOutDet_LTE			ADC_Channel_6
#define adcRvsOutDetBal_WCDMA		ADC_Channel_7
#define adcRvsOutDet_LTEA			ADC_Channel_8
#define adcFwdInDet_CDMALTE			ADC_Channel_9
#define adcFwdInDet_WCDMA			ADC_Channel_10
#define adcFwdInDet_LTE_A			ADC_Channel_11
#define DET12						ADC_Channel_12
#define DET13						ADC_Channel_13
#define DET14						ADC_Channel_14
#define adcEnvTemp					ADC_Channel_15
#endif
#define adcEnvTemp					ADC_Channel_15

////////////////////////////////////////////////////////////////////////////////
// function prototype
////////////////////////////////////
int ReadEnvTempTable(int Adcvalue);

void ADCInit(int INT_EN);
void ADC_IRQHandler(void);
void ADC1_SWStart(void);
void ADC3_SWStart(void);

void ADC_ChannelEnable(INT8U channel);
void SwapData(INT16U *a, INT16U *b);
INT8U ADC_CheckFinish(INT8U channel);
INT16U SelectSort(INT16U *aptr, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen);
INT16U SelectSortMax(INT16U *aptr, INT16U nlen);
INT16U SelectMax(INT16U *aptr, INT16U nlen);
INT16U SelectAverage(INT16U *aptr, INT16U nlen);
INT16U GetAdcValue(INT8U channel);

INT16U AdctoVolt33V(INT16U Data);
INT16U AdctoVolt5opamp(INT16U Data);


INT16U SelectSort_1(INT16U *aptr,INT16U *AvgValue, INT16U *PeakValue, INT16U AvgMAX, INT16U AvgMIN, INT16U PeakMAX, INT16U PeakMIN, INT16U nlen);
INT16U SelectSort_MinMax(INT16U *aptr, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen, INT8U Mode);

//INT16U BubbleSort(INT16U *aptr, int start_pos, int end_pos);

static int quick_sort_partition( INT16U array[], int start_pos, int end_pos);
void quick_sort( INT16U array[], int start_pos, int end_pos);
INT32U average_rssi(INT16U rssi[], int array_size);
INT16U Average_Sum(INT16U *aptr,INT16U AvgMAX, INT16U AvgMIN, INT16U nlen);


void SortSelect(INT16U *aptr, int start_pos, int end_pos);

FlagStatus ADC_GetFlagStatus(ADC_TypeDef* ADCx, uint8_t ADC_FLAG);


INT8U ADC3_CheckFinish(INT8U channel);
void ADC3_ChannelEnable(INT8U channel);

void insertionSort(INT16U array[], INT16U min, INT16U max);
void BubbleSort(INT16U array[], INT16U min, INT16U max);

void mergeSort(INT16U array[], INT16U min, INT16U max);
void merge(INT16U array[], INT16U min, INT16U max, INT16U mid);
INT16U Average_Sum_Test(INT16U *aptr,INT16U AvgMAX, INT16U AvgMIN, INT16U nlen);

///////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

