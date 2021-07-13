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
typedef struct
{
	union {
		vu32 Data;
		struct {
			vu32 AWD		:1;	// Analog watchdog flag: 0: No Analog watchdog event occured
								// 						 1: Analog Watchdog event occured
			vu32 EOC		:1;	// End of converstion	 0: conversion is not complete
								//						 1: conversion complete
			vu32 JEOC		:1;	// injected channel end of conversion			
			vu32 JSTRT		:1;	// injected channel start flag: 0: No Injected group converstion started
								//								1: Injected group converstion has started
			vu32 STRT		:1;	// Regular channel start flag

		};
	}SR;	// ADC Status Register

	union {
		vu32 Data;
		struct {
			vu32 AWDCH		:5;	// Analog watchdog channel select bit
			vu32 EOCIE		:1;	// interrupt enable EOC
			vu32 AWDIE		:1; // Analog watchdog interrupt enable
			vu32 JEOCIE		:1; // interrup enable for injected channels
			vu32 SCAN		:1;	// scan mode
			vu32 AWDSGL		:1;	// Enable the watchdog on a single channel in scan mode
			vu32 JAUTO		:1; // automatic injected group conversion
			vu32 DISCEN		:1; // Discontinuous mode on regular channel
			vu32 DISCENJ	:1;	// discontinuous mode on injected channel
			vu32 DISCNUM	:3;	// discontinuous mode channel count
			vu32 DUALMOD	:4;	// dual mode selection
			vu32			:2;
			vu32 AWDENJ		:1;	// Analog watchdog enable on injected channels
			vu32 AWDEN		:1;	// Analog watchdog enable on regular channels
		};
	} CR1;	// ADC control Register 1

	union {
		vu32 Data;
		struct {
			vu32 ADON		:1;	// A/D converter ON/OFF
			vu32 CONT		:1;	// Continous conversion
			vu32 CAL		:1;	// A/D Calibration
			vu32 RSTCAL		:1;	// Reset Calibration
			vu32			:4;	// 
			vu32 DMAMODE	:1;	// Direct Memory access mode
			vu32			:2;
			vu32 ALIGN		:1;	// Data Alignment
			vu32 JEXTSEL	:3;	// external event select for injected group
			vu32 JEXTTRIG	:1;	// External Trigger conversion mode for injected channels
			vu32			:1;
			vu32 EXTSEL		:3;	// External Trigger select for regular group
			vu32 EXTTRIG	:1;	// External Trigger conersion mode for regular channels
			vu32 SWSTARTJ	:1;	// Start conversion of injected channel
			vu32 SWSTART	:1;	// Start Conversion of regular channel
			vu32 TSVREFE	:1;	// Temerature Sensor and V(REFINT) Enable
		};
	} CR2;	// ADC control Register 2

	union {
		vu32 Data;
		struct {
			vu32 SMP10		:3;
			vu32 SMP11		:3;
			vu32 SMP12		:3;
			vu32 SMP13		:3;
			vu32 SMP14		:3;
			vu32 SMP15		:3;
			vu32 SMP16		:3;
			vu32 SMP17		:3;
			vu32 SMP18		:3;
		};
	} SMPR1;	// ADC sample time register 1(ADC_SMPR1)

	union {
		vu32 Data;
		struct {
			vu32 SMP0		:3;
			vu32 SMP1		:3;
			vu32 SMP2		:3;
			vu32 SMP3		:3;
			vu32 SMP4		:3;
			vu32 SMP5		:3;
			vu32 SMP6		:3;
			vu32 SMP7		:3;
			vu32 SMP8		:3;
			vu32 SMP9		:3;
		};
	} SMPR2;	// ADC sample time register 2(ADC_SMPR2)
	vu32 JOFR1;
	vu32 JOFR2;
	vu32 JOFR3;
	vu32 JOFR4;
	vu32 HTR;
	vu32 LTR;
	union {
		vu32 Data;
		struct {
			vu32 SQ13		:5;
			vu32 SQ14		:5;
			vu32 SQ15		:5;
			vu32 SQ16		:5;
			vu32 L			:4;		// Regular channel sequence No.
		};
	} SQR1;	// ADC regular sequence register 1
	
	union {
		vu32 Data;
		struct {
			vu32 SQ7		:5;
			vu32 SQ8		:5;
			vu32 SQ9		:5;
			vu32 SQ10		:5;
			vu32 SQ11		:5;
			vu32 SQ12		:5;
		};
	} SQR2;	// ADC regular sequence register 2
	
	union {
		vu32 Data;
		struct {
			vu32 SQ1		:5;
			vu32 SQ2		:5;
			vu32 SQ3		:5;
			vu32 SQ4		:5;
			vu32 SQ5		:5;
			vu32 SQ6		:5;
		};
	} SQR3;	// ADC regular sequence register 3

	union {
		vu32 Data;
		struct {
			vu32 JSQ1		:5;
			vu32 JSQ2		:5;
			vu32 JSQ3		:5;
			vu32 JSQ4		:5;
			vu32 JL			:3;
		};
	} JSQR;	// ADC injected sequence register(ADC_JSQR)

	vu32 JDR1;
	vu32 JDR2;
	vu32 JDR3;
	vu32 JDR4;
	vu32 DR;
} ADC_TypeDef;


////////////////////////////////////////////////////////////////////////////////
// Bit/vaule definition
///////////////////////
// CR1
// ADC dual mode
#define __dMODE_INDEPENDENT					0
#define __dMODE_RegInjecSimul				1
#define __dMODE_RegSimult_AlterTrig			2
#define __dMODE_InjecSimult_FastInterl		3
#define __dMODE_InjecSimult_SlowInterl		4
#define __dMODE_InjecSimult					5
#define __dMODE_RegSimult					6
#define __dMODE_FastInterl					7
#define __dMODE_SlowInterl					8
#define __dMODE_AlterTrig					9


// CR2
// EXTSEL[2:0]
// ADC extrenal trigger sources for regular channels conversion
#define __T1_CC1                0
#define __T1_CC2                1
#define __T1_CC3				2
#define __T2_CC2				3
#define __T3_TRGO				4
#define __T4_CC4				5
#define __EXT_IT11				6
#define __SWSTART				7

// JEXTSEL[2:0]
// ADC extrenal trigger sources for injected channels conversion
#define __JT1_TRGO				0	// Timer1 TRGO event selected
#define __JT1_CC4				1	// Timer1 capture compare4 selected
#define __JT2_TRGO				2	// Timer2 TRGO event selected
#define __JT2_CC1				3	// Timer2 capture compare1 selected
#define __JT3_CC4				4	// Timer3 capture compare4 selected
#define __JT4_TRGO				5	// Timer4 TRGO event selected 
#define __JEXT_IT15				6	// External interrupt 15 event selected
#define __JSWSTART				7	//Injected conversion started by software and not by external trigger

// ADC data align ------------------------------------------------------------*/
#define __ALI_Right				0
#define __ALI_Left				1

// ADC_SMPR1/2
// ADC sampling times
#define __SP_15Cycle			0	// sample time 1.5 cycles
#define __SP_74Cycle			1	// sample time 7.4 cycles
#define __SP_135Cycle			2	// sample time 13.5 cycles
#define __SP_285Cycle			3	// sample time 28.5 cycles
#define __SP_415Cycle			4	// sample time 41.5 cycles
#define __SP_555Cycle			5	// sample time 55.5 cycles
#define __SP_715Cycle			6	// sample time 715.5 cycles
#define __SP_2395Cycle			7	// sample time 239.5 cycles

/* ADC RSTCAL mask */
#define CR2_RSTCAL_Set             ((u16)0x0008)

/* ADC CAL mask */
#define CR2_CAL_Set                ((u16)0x0004)

/* ADC SWSTRT mask */
#define CR2_SWSTRT_Set             ((u32)0x00400000)

/* ADC DISCNUM mask */
#define CR1_DISCNUM_Reset          ((u32)0xFFFF1FFF)

/* ADC DISCEN mask */
#define CR1_DISCEN_Set             ((u32)0x00000800)
#define CR1_DISCEN_Reset           ((u32)0xFFFFF7FF)

/* ADC EXTTRIG mask */
#define CR2_EXTTRIG_Set            ((u32)0x00100000)
#define CR2_EXTTRIG_Reset          ((u32)0xFFEFFFFF)

/* ADC Software start mask */
#define CR2_EXTTRIG_SWSTRT_Set     ((u32)0x00500000)
#define CR2_EXTTRIG_SWSTRT_Reset   ((u32)0xFFAFFFFF)

/* ADC JAUTO mask */
#define CR1_JAUTO_Set              ((u32)0x00000400)
#define CR1_JAUTO_Reset            ((u32)0xFFFFFBFF)

/* ADC JDISCEN mask */
#define CR1_JDISCEN_Set            ((u32)0x00001000)
#define CR1_JDISCEN_Reset          ((u32)0xFFFFEFFF)

/* ADC JEXTSEL mask */
#define CR2_JEXTSEL_Reset          ((u32)0xFFFF8FFF)

/* ADC JEXTTRIG mask */
#define CR2_JEXTTRIG_Set           ((u32)0x00008000)
#define CR2_JEXTTRIG_Reset         ((u32)0xFFFF7FFF)

/* ADC JSWSTRT mask */
#define CR2_JSWSTRT_Set            ((u32)0x00200000)

/* ADC injected software start mask */
#define CR2_JEXTTRIG_JSWSTRT_Set   ((u32)0x00208000)
#define CR2_JEXTTRIG_JSWSTRT_Reset ((u32)0xFFDF7FFF)

/* ADC AWDCH mask */
#define CR1_AWDCH_Reset            ((u32)0xFFFFFFE0)

/* ADC SQx mask */
#define SQR3_SQ_Set                ((u8)0x1F)
#define SQR2_SQ_Set                ((u8)0x1F)
#define SQR1_SQ_Set                ((u8)0x1F)

/* ADC JSQx mask */
#define JSQR_JSQ_Set               ((u8)0x1F)

/* ADC JL mask */
#define JSQR_JL_Reset              ((u32)0xFFCFFFFF)

/* ADC SMPx mask */
#define SMPR1_SMP_Set              ((u8)0x07)
#define SMPR2_SMP_Set              ((u8)0x07)

/* ADC Analog watchdog enable mode mask */
#define CR1_AWDMode_Reset          ((u32)0xFF3FFDFF)

/* ADC TSPD mask */
#define CR2_TSVREFE_Set            ((u32)0x00800000)
#define CR2_TSVREFE_Reset          ((u32)0xFF7FFFFF)

/* ADC JDRx registers= offset */
#define JDR_Offset                 ((u8)0x28)

/* ADC registers Masks */
#define CR1_CLEAR_Mask             ((u32)0xFFF0FEFF)
#define CR2_CLEAR_Mask             ((u32)0xFFF1F7FD)
#define SQR1_CLEAR_Mask            ((u32)0xFF0FFFFF)


// ADC Init structure definition
typedef struct
{
  u32 ADC_Mode;
  u32 ADC_ScanConvMode; 
  u32 ADC_ContinuousConvMode;
  u32 ADC_ExternalTrigConv;
  u32 ADC_DataAlign;
  u8 ADC_NbrOfChannel;

}ADC_InitTypeDef;


// ADC channels ----------------------------------------------------------------
#define ADC_Channel_0                               ((u8)0x00)
#define ADC_Channel_1                               ((u8)0x01)
#define ADC_Channel_2                               ((u8)0x02)
#define ADC_Channel_3                               ((u8)0x03)
#define ADC_Channel_4                               ((u8)0x04)
#define ADC_Channel_5                               ((u8)0x05)
#define ADC_Channel_6                               ((u8)0x06)
#define ADC_Channel_7                               ((u8)0x07)
#define ADC_Channel_8                               ((u8)0x08)
#define ADC_Channel_9                               ((u8)0x09)
#define ADC_Channel_10                              ((u8)0x0A)
#define ADC_Channel_11                              ((u8)0x0B)
#define ADC_Channel_12                              ((u8)0x0C)
#define ADC_Channel_13                              ((u8)0x0D)
#define ADC_Channel_14                              ((u8)0x0E)
#define ADC_Channel_15                              ((u8)0x0F)
#define ADC_Channel_16                              ((u8)0x10)
#define ADC_TEMP									((u8)0x10)
#define ADC_Channel_17                              ((u8)0x11)
#define ADC_VREFINT									((u8)0x11)
#define __ADCMAX									17

// ADC injected channel selection ----------------------------------------------
#define ADC_InjectedChannel_1                       ((u8)0x14)
#define ADC_InjectedChannel_2                       ((u8)0x18)
#define ADC_InjectedChannel_3                       ((u8)0x1C)
#define ADC_InjectedChannel_4                       ((u8)0x20)

// ADC analog watchdog selection -----------------------------------------------
#define ADC_AnalogWatchdog_SingleRegEnable         ((u32)0x00800200)
#define ADC_AnalogWatchdog_SingleInjecEnable       ((u32)0x00400200)
#define ADC_AnalogWatchdog_SingleRegOrInjecEnable  ((u32)0x00C00200)
#define ADC_AnalogWatchdog_AllRegEnable            ((u32)0x00800000)
#define ADC_AnalogWatchdog_AllInjecEnable          ((u32)0x00400000)
#define ADC_AnalogWatchdog_AllRegAllInjecEnable    ((u32)0x00C00000)
#define ADC_AnalogWatchdog_None                    ((u32)0x00000000)

// ADC flags definition
#define ADC_FLAG_AWD                               ((u8)0x01)
#define ADC_FLAG_EOC                               ((u8)0x02)
#define ADC_FLAG_JEOC                              ((u8)0x04)
#define ADC_FLAG_JSTRT                             ((u8)0x08)
#define ADC_FLAG_STRT                              ((u8)0x10)

#define IS_ADC_CLEAR_FLAG(FLAG) (((FLAG & (u8)0xE0) == 0x00) && (FLAG != 0x00))
#define IS_ADC_GET_FLAG(FLAG) ((FLAG == ADC_FLAG_AWD) || (FLAG == ADC_FLAG_EOC) || \
                               (FLAG == ADC_FLAG_JEOC) || (FLAG == ADC_FLAG_JSTRT) || \
                               (FLAG == ADC_FLAG_STRT))

/* ADC thresholds ------------------------------------------------------------*/
#define IS_ADC_THRESHOLD(THRESHOLD) (THRESHOLD <= 0xFFF)

/* ADC injected offset -------------------------------------------------------*/
#define IS_ADC_OFFSET(OFFSET) (OFFSET <= 0xFFF)

/* ADC injected rank ---------------------------------------------------------*/
#define IS_ADC_INJECTED_RANK(RANK) ((RANK >= 0x1) && (RANK <= 0x4))

/* ADC regular length --------------------------------------------------------*/
#define IS_ADC_REGULAR_LENGTH(LENGTH) ((LENGTH >= 0x1) && (LENGTH <= 0x10))

/* ADC regular rank ----------------------------------------------------------*/
#define IS_ADC_REGULAR_RANK(RANK) ((RANK >= 0x1) && (RANK <= 0x10))

/* ADC regular discontinuous mode number -------------------------------------*/
#define IS_ADC_REGULAR_DISC_NUMBER(NUMBER) ((NUMBER >= 0x1) && (NUMBER <= 0x8))

///////////////////////////////////////////////////////////////////////////////
// function prototype
////////////////////////////////////
void ADC_DiscModeChannelCountConfig(ADC_TypeDef* ADCx, u8 Number);
void ADC_DiscModeCmd(ADC_TypeDef* ADCx, u32 NewState);
void ADC_ExternalTrigConvCmd(ADC_TypeDef* ADCx, u32 NewState);
u32 ADC_GetDualModeConversionValue(void);
void ADC_AutoInjectedConvCmd(ADC_TypeDef* ADCx, u32 NewState);
void ADC_InjectedDiscModeCmd(ADC_TypeDef* ADCx, u32 NewState);
void ADC_ExtTrigInjConvCfg(ADC_TypeDef* ADCx, u32 ExtTrigInjConv);
void ADC_ExternalTrigInjectedConvCmd(ADC_TypeDef* ADCx, u32 NewState);
void ADC_SoftwareStartInjectedConvCmd(ADC_TypeDef* ADCx, u32 NewState);
u32 ADC_GetSoftwareStartInjectedConvCmdStatus(ADC_TypeDef* ADCx);
void ADC_InjChannelCfg(ADC_TypeDef* ADCx, u32 ADC_Channel, u32 Rank, u32 ADC_SampleTime);
void ADC_InjSequencerLenCfg(ADC_TypeDef* ADCx, u32 nCnt);
void ADC_SetInjectedOffset(ADC_TypeDef* ADCx, u8 ADC_InjectedChannel, u16 Offset);
u16 ADC_GetInjectedConversionValue(ADC_TypeDef* ADCx, u8 ADC_InjectedChannel);
void ADC_AnalogWatchdogCmd(ADC_TypeDef* ADCx, u32 ADC_AnalogWatchdog);
void ADC_AnalogWatchdogThresholdsConfig(ADC_TypeDef* ADCx, u16 HighThreshold, u16 LowThreshold);
void ADC_AnalogWatchdogSingleChannelConfig(ADC_TypeDef* ADCx, u8 ADC_Channel);
u32 ADC_GetFlagStatus(ADC_TypeDef* ADCx, u8 ADC_FLAG);
void ADC_ClearFlag(ADC_TypeDef* ADCx, u8 ADC_FLAG);
void ADC_SoftwareStartConvCmd(ADC_TypeDef* ADCx, u32 NewState);

int  ReadIntTempTable(u16 Data);
void ADC_ChannelEnable(INT8U channel);
void ADC_ChannelDisable(INT8U channel);

extern unsigned long int USART1Printf( const char *format, ...);

///////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

