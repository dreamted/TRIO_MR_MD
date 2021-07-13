/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : stm32f10x_dac.h
* Author             : MCD Application Team
* Version            : V2.0.2
* Date               : 07/11/2008
* Description        : This file contains all the functions prototypes for the
*                      DAC firmware library.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F10x_DAC_H
#define __STM32F10x_DAC_H

// DAC Register structure definition
typedef struct
{
	union {
		vu32 Data;
		struct {
			vu32 EN1		:1; // DAC channel 1 Enable
			vu32 BOFF1		:1; // DAC channl 1 output buffer disable 0: enable, 1: Enable
			//vu32 TEN1		:1;
			vu32 TSEL1		:4;
			vu32 WAVE1		:2;
			vu32 MAMP1		:4; // DAC channel 1 Mask/Amplitude selector
			vu32 DAMEN1		:1;
			vu32			:3;
			vu32 EN2		:1; // DAC channel 2 Enable
			vu32 BOFF2		:1; // DAC channl 2 output buffer disable 0: enable, 1: Enable
			//vu32 TEN2		:1;
			vu32 TSEL2		:4;
			vu32 WAVE2		:2; // DAC channel2 noise/triangle wave generation enable
                                // 00: wave generation disabled
                                // 01: Noise wave generation enabled
			vu32 MAMP2		:4;
			vu32 DAMEN2		:1;	// DAC channel2 DMA enable 	0: DAC channel2 DMA mode disabled
								//							1: DAC channel2 DMA mode enabled
			vu32			:3;
		} B;
  	} CR;	// Control Register
  
	union {
		vu32 Data;
		struct {
			vu32 SWTRIG1	:1;
			vu32 SWTRIG2	:1;
		} B;
	} SWTRIGR;	// software trigger
	
	vu32 DHR12R1; //DAC channel1 12-bit Right-aligned Data Holding Register
	vu32 DHR12L1; //DAC channel1 12-bit Left aligned Data Holding Register
	vu32 DHR8R1;  //DAC channel1 8-bit Right aligned Data Holding Register
	
	vu32 DHR12R2;
	vu32 DHR12L2;
	vu32 DHR8R2;
	//union {
	//	vu32 Data;
		vu16 DHR12RD[2];			
	//} DHR12RD;
	vu32 DHR12LD;
	vu32 DHR8RD;
	vu32 DOR[2];	 // DAC channel1 Data Output Register (DAC_DOR1)
	//vu32 DOR2;
} DAC_TypeDef;

// DAC Init structure definition
typedef struct
{
  u32 DAC_Trigger;
  u32 DAC_WaveGeneration;
  u32 DAC_LFSRUnmask_TriangleAmplitude;
  u32 DAC_OutputBuffer; 
}DAC_InitTypeDef;

// Exported constants ----------------------------------------------------------
// DAC trigger selection
#define DAC_T_NONE						0
#define DAC_T_T6						((0 << 1) | 1)
#define DAC_T_T8						((1 << 1) | 1)
#define DAC_T_T7						((2 << 1) | 1)
#define DAC_T_T5						((3 << 1) | 1)
#define DAC_T_T2						((4 << 1) | 1)
#define DAC_T_T4						((5 << 1) | 1)
#define DAC_T_EXT_IT9					((6 << 1) | 1)
#define DAC_T_SOFT						((7 << 1) | 1)

// DAC wave generation
#define DAC_WAVE_N						((u32)0)
#define DAC_WAVE_NOISE					((u32)1)
#define DAC_WAVE_TRI					((u32)2)

//00: wave generation disabled
//01: Noise wave generation enabled
//1x: Triangle wave generation enabled
//Note: only used if bit TEN1/2 = 1 (DAC channel2 trigger enabled)

// DAC noise wave generation mask / triangle wave generation max amplitude
// MAMP2[3:0]: DAC channel2 Mask/Amplitude selector
// These bits are written by software to select mask in wave generation mode or amplitude in triangle
// generation mode.
// 0000: Unmask bit0 of LFSR/ Triangle Amplitude equal to 1
// 0001: Unmask bits[1:0] of LFSR/ Triangle Amplitude equal to 3
// 0010: Unmask bits[2:0] of LFSR/ Triangle Amplitude equal to 7
// 0011: Unmask bits[3:0] of LFSR/ Triangle Amplitude equal to 15
// 0100: Unmask bits[4:0] of LFSR/ Triangle Amplitude equal to 31
// 0101: Unmask bits[5:0] of LFSR/ Triangle Amplitude equal to 63
// 0110: Unmask bits[6:0] of LFSR/ Triangle Amplitude equal to 127
// 0111: Unmask bits[7:0] of LFSR/ Triangle Amplitude equal to 255
// 1000: Unmask bits[8:0] of LFSR/ Triangle Amplitude equal to 511
// 1001: Unmask bits[9:0] of LFSR/ Triangle Amplitude equal to 1023
// 1010: Unmask bits[10:0] of LFSR/ Triangle Amplitude equal to 2047
// 1011: Unmask bits[11:0] of LFSR/ Triangle Amplitude equal to 4095

#define DAC_LFSRUnmask_Bit0                ((u32)0)
#define DAC_LFSRUnmask_Bits1_0             ((u32)1)
#define DAC_LFSRUnmask_Bits2_0             ((u32)2)
#define DAC_LFSRUnmask_Bits3_0             ((u32)3)
#define DAC_LFSRUnmask_Bits4_0             ((u32)4)
#define DAC_LFSRUnmask_Bits5_0             ((u32)5)
#define DAC_LFSRUnmask_Bits6_0             ((u32)6)
#define DAC_LFSRUnmask_Bits7_0             ((u32)7)
#define DAC_LFSRUnmask_Bits8_0             ((u32)8)
#define DAC_LFSRUnmask_Bits9_0             ((u32)9)
#define DAC_LFSRUnmask_Bits10_0            ((u32)10)
#define DAC_LFSRUnmask_Bits11_0            ((u32)11)

#define DAC_TriangleAmplitude_1            ((u32)0)
#define DAC_TriangleAmplitude_3            ((u32)1)
#define DAC_TriangleAmplitude_7            ((u32)2)
#define DAC_TriangleAmplitude_15           ((u32)3)
#define DAC_TriangleAmplitude_31           ((u32)4)
#define DAC_TriangleAmplitude_63           ((u32)5)
#define DAC_TriangleAmplitude_127          ((u32)6)
#define DAC_TriangleAmplitude_255          ((u32)7)
#define DAC_TriangleAmplitude_511          ((u32)8)
#define DAC_TriangleAmplitude_1023         ((u32)9)
#define DAC_TriangleAmplitude_2047         ((u32)10)
#define DAC_TriangleAmplitude_4095         ((u32)11)

#define IS_DAC_LFSR_UNMASK_TRIANGLE_AMPLITUDE(VALUE) (((VALUE) == DAC_LFSRUnmask_Bit0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits1_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits2_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits3_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits4_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits5_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits6_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits7_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits8_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits9_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits10_0) || \
                                                      ((VALUE) == DAC_LFSRUnmask_Bits11_0) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_1) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_3) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_7) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_15) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_31) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_63) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_127) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_255) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_511) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_1023) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_2047) || \
                                                      ((VALUE) == DAC_TriangleAmplitude_4095))

/* DAC output buffer */
#define DAC_OutputBuffer_Enable            ((u32)0x00000000)
#define DAC_OutputBuffer_Disable           ((u32)0x00000002)

#define IS_DAC_OUTPUT_BUFFER_STATE(STATE) (((STATE) == DAC_OutputBuffer_Enable) || \
                                           ((STATE) == DAC_OutputBuffer_Disable))

// DAC Channel selection
#define DAC_Channel_1                      ((u32)0x00000000)
#define DAC_Channel_2                      ((u32)0x00000010)

#define DAC1								DAC_Channel_1
#define DAC2								DAC_Channel_2

// DAC data alignement
#define DAC_Align_12b_R                    ((u32)0x00000000)
#define DAC_Align_12b_L                    ((u32)0x00000004)
#define DAC_Align_8b_R                     ((u32)0x00000008)

#define IS_DAC_ALIGN(ALIGN) (((ALIGN) == DAC_Align_12b_R) || \
                             ((ALIGN) == DAC_Align_12b_L) || \
                             ((ALIGN) == DAC_Align_8b_R))

/* DAC wave generation */
#define DAC_Wave_Noise                     ((u32)0x00000040)
#define DAC_Wave_Triangle                  ((u32)0x00000080)

#define IS_DAC_WAVE(WAVE) (((WAVE) == DAC_Wave_Noise) || \
                           ((WAVE) == DAC_Wave_Triangle))

// DAC data --------------------------------------------------------------------
#define IS_DAC_DATA(DATA) ((DATA) <= 0xFFF0) 

// Exported macro --------------------------------------------------------------
#define DAC                 ((DAC_TypeDef *) DAC_BASE)

// Exported functions ----------------------------------------------------------
void DAC_DeInit(void);
void DAC1Init(void);
void DAC2Init(void);
void DAC_Init(u32 DAC_Channel, DAC_InitTypeDef* DAC_InitStruct);
u16 DAC_SetData(u32 Channel, u16 Data);

void DAC_StructInit(DAC_InitTypeDef* DAC_InitStruct);
void DAC_Cmd(u32 DAC_Channel, u32 NewState);
void DAC_DMACmd(u32 DAC_Channel, u32 NewState);
void DAC_SoftwareTriggerCmd(u32 DAC_Channel, u32 NewState);
void DAC_DualSoftwareTriggerCmd(u32 NewState);
void DAC_WaveGenerationCmd(u32 DAC_Channel, u32 DAC_Wave, u32 NewState);
void DAC_SetChannel1Data(u32 DAC_Align, u16 Data);
void DAC_SetChannel2Data(u32 DAC_Align, u16 Data);
void DAC_SetDualChannelData(u32 DAC_Align, u16 Data2, u16 Data1);
u16 DAC_GetDataOutputValue(u32 DAC_Channel);

extern unsigned long int USART1Printf( const char *format, ...);

#endif /*__STM32F10x_DAC_H */

/******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
