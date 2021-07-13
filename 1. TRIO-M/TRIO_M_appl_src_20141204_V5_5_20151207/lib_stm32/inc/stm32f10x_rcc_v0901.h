
/*********************************************
* File Name          : stm32f10x_rcc.h
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

//	Define to prevent recursive inclusion
#ifndef __STM32F10x_RCC_H
#define __STM32F10x_RCC_H

////////////////////////////////////////////////////////////////////////////////
// Reset and Clock Control
//////////////////////////
typedef struct
{
	union {
		vu32 Data;				// 0x00
		struct	{
			vu32 HSION		:1;	// rw, internal(8MHz) high speed clock enable, ON: 1, OFF:0
			vu32 HSIRDY		:1;	// r, internal high speed clock ready flag, ready: 1, Not Ready: 0
			vu32			:1;
			vu32 HSITRIM	:5;	// rw, internal high speed clock trimming(adjust calibration)
			vu32 HSICAL		:8;	// r, interanl high speed clok calibration
			vu32 HSEON		:1;	// rw, external(1~25Mhz) high speed clock enable, ON: 1, OFF: 0
			vu32 HSERDY		:1;	// r, external(1~25Mhz) high speed clock ready flag, ready(1), not reday(1)
			vu32 HSEBYP		:1;	// rw, external(1~25Mhz) high speed clock Bypass 0: not bypass, 1: bypass
			vu32 CSSON		:1; // rw, Clock Security System Enable: if)Ext osc is, Set: 1, else 0:
			vu32			:4;
			vu32 PLLON		:1;	// rw, PLL enable, 1: PLL ON, 0: PLL OFF
			vu32 PLLRDY		:1;	// r, PLL clock ready flag, 0: PLL unlocked, 1: PLL locked

		};
	} CR;		// control Register
	union {
		vu32 Data;				// 0x04
		struct {
			vu32 SW			:2;	// rw, system clock switch
			vu32 SWS		:2;	// r,
			vu32 HPRE		:4;	// rw, AHB(High clock) prescaler
			vu32 PPRE1		:3; // rw, APB1 High Speed Prescaler(max 32Mhz)
			vu32 PPRE2		:3;	// rw, APB2 High Speed Prescaler(max 72Mhz)
			vu32 ADCPRE		:2;	// rw, ADC prescaler
			vu32 PLLSRC		:1;	// rw, PLL entry clock source, 0: HSI clock/2 input, 1: HSE clock/1
			vu32 PLLXTPRE	:1;	// rw, HSE divider for PLL entry
			vu32 PLLMUL		:4;	// rw, PLL multiplication factor, only can modified when PLL disabled
			vu32 USBPRE		:1;	// rw, USB Presaler 1: /1.5, 0: /1
			vu32			:1;
			vu32 MCO		:3; // rw, Microcontroller clock Output
		};

	} CFGR;		// clock configuration register
	vu32 CIR;					// 0x08
	union {
		vu32 Data;				// 0x0C
		struct {
			vu32 AFIORST	:1;
			vu32			:1;
			vu32 IOPARST	:1;
			vu32 IOPBRST	:1;
			vu32 IOPCRST	:1;
			vu32 IOPDRST	:1;
			vu32 IOPERST	:1;
			vu32 			:2;
			vu32 ADC1RST	:1;
			vu32 ADC2RST	:1;
			vu32 TIM1RST	:1;
			vu32 SPI1RST	:1;
			vu32 			:1;
			vu32 USART1RST	:1;
		};
	} APB2RSTR;
	union {
		vu32 Data;				// 0x10
		struct {
			vu32 TIM2RST	:1;	//0
			vu32 TIM3RST	:1;	//1
			vu32 TIM4RST	:1;	//2
			vu32 TIM5RST	:1;	//3
			vu32 TIM6RST	:1;	//4
			vu32 TIM7RST	:1;	//5
			vu32			:5;
			vu32 WWDGRST	:1;	//11
			vu32			:2;
			vu32 SPI2RST	:1;	//14
			vu32 SPI3RST	:1;	//15
			
			vu32			:1;	//16
			vu32 USART2RST	:1;	//17
			vu32 USART3RST	:1;	//18
			vu32 UART4RST	:1;	//19
			vu32 UART5RST	:1;	//20
			vu32 I2C1RST	:1;
			vu32 I2C2RST	:1;
			vu32 USBRST		:1;
			vu32			:1;
			vu32 CANRST		:1;
			vu32			:1;
			vu32 BKPRST		:1;
			vu32 PWRRST		:1;
			vu32 DACRST		:1;
		};
	} APB1RSTR;
	union {
		vu32 Data;				// 0x14
		struct {
			vu32 DM1AEN		:1;	// rw, DMA clock enable
			vu32 DM2AEN		:1;
			vu32 SRAMEN		:1;	// rw, SRAM interface clock enable
			vu32			:1;
			vu32 FLITFEN	:1;	// rw, FLITF clock Enable
			vu32			:1;
			vu32 CRCEN		:1;
			vu32			:1;
			vu32 FSMCEN		:1;
			vu32			:1;
			vu32 SDIOEN		:1;
		};

	} AHBENR;	// AHB clock Enable Register

	union {
		vu32 Data;				// 0x18
		struct {
			vu32 AFIOEN		:1;	// rw
			vu32			:1;
			vu32 IOPAEN		:1;	// rw
			vu32 IOPBEN		:1;	// rw
			vu32 IOPCEN		:1;	// rw
			vu32 IOPDEN		:1;	// rw
			vu32 IOPEEN		:1;	// rw
			vu32 IOPFEN		:1;
			vu32 IOPGEN		:1;
			vu32 ADC1EN		:1;	// rw
			vu32 ADC2EN		:1;	// rw
			vu32 TIM1EN		:1;	// rw
			vu32 SPI1EN		:1;	// rw
			vu32 TIM8EN		:1;
			vu32 USART1EN	:1;	// rw
			vu32 ADC3EN		:1;

		};
	} APB2ENR;

	union {
		vu32 Data;
		struct {
			vu32 TIM2EN		:1;
			vu32 TIM3EN		:1;
			vu32 TIM4EN		:1;
			vu32 TIM5EN		:1;
			vu32 TIM6EN		:1;
			vu32 TIM7EN		:1;
			vu32			:5;
			vu32 WWDGEN		:1;
			vu32 			:2;
			vu32 SPI2EN		:1;
			vu32 SPI3EN		:1;
			vu32			:1;
			vu32 USART2EN	:1;
			vu32 USART3EN	:1;
			vu32 UART4EN	:1;
			vu32 UART5EN	:1;
			vu32 I2C1EN		:1;
			vu32 I2C2EN		:1;
			vu32 USBEN		:1;
			vu32 			:1;
			vu32 CANEN		:1;
			vu32 			:1;
			vu32 BKPEN		:1;
			vu32 PWREN		:1;
			vu32 DACEN		:1;
		};
	} APB1ENR;

	union {
		vu32 Data;
		struct {
			vu32 LSEON		:1;		// rw, external low speed osc. enable
			vu32 LSERDY		:1;		// r, external low speed osc. Ready
			vu32 LSEBYP		:1;		// rw, external low speed osc. bypass
			vu32 			:5;
			vu32 RTCSEL		:2;		// rw, rtc clock source selection
									//	- 0: no clock
									//	- 1: LSE used as RTC clock
									//	- 2: LSI used as RTC clock
									//	- 3: HSE used as divided 128 RTC clock
			vu32 			:5;		
			vu32 RTCEN		:1;		// rw, rtc clock enable
			vu32 BDRST		:1;		// rw, backup domain reset
		};
	} BDCR;	// backup domain control register

	union {
		vu32 Data;
		struct {
			vu32 LSION		:1;		// rw, 
			vu32 LSIRDY		:1;
			vu32 			:22;
			vu32 PMVF		:1;
			vu32			:1;
			vu32 PINRSTF	:1;
			vu32 PORRSTF	:1;
			vu32 SFTRSTF	:1;
			vu32 IWDGRSTF	:1;
			vu32 WWDGRSTF	:1;
			vu32 LPWRRSTF	:1;
		};
	} CSR;	// control status register


} RCC_TypeDef;

#define RCC                           ((RCC_TypeDef *) RCC_BASE)

typedef struct
{
	u32 SYSCLK_Frequency;
	u32 HCLK_Frequency;
	u32 PCLK1_Frequency;
	u32 PCLK2_Frequency;
	u32 ADCCLK_Frequency;
}RCC_ClocksTypeDef;

// Exported constants ----------------------------------------------------------

// HSE configuration
#define RCC_HSE_OFF                      ((u32)0x00000000)
#define RCC_HSE_ON                       ((u32)0x00010000)
#define RCC_HSE_Bypass                   ((u32)0x00040000)

#define IS_RCC_HSE(HSE) ((HSE == RCC_HSE_OFF) || (HSE == RCC_HSE_ON) || \
                         (HSE == RCC_HSE_Bypass))

// PLL entry clock source entry
#define RCC_PLLSource_HSI_Div2           ((u32)0x00000000)
#define RCC_PLLSource_HSE_Div1           ((u32)0x00010000)
#define RCC_PLLSource_HSE_Div2           ((u32)0x00030000)

#define __HSISRC2					0
#define __HSESRC					1  // ---
// PLL HSE drive clock soure entry     //    |
#define __HSESRC1					0  // <--
#define __HSESRC2					1  // <-- connected

#define IS_RCC_PLL_SOURCE(SOURCE) ((SOURCE == RCC_PLLSource_HSI_Div2) || \
                                   (SOURCE == RCC_PLLSource_HSE_Div1) || \
                                   (SOURCE == RCC_PLLSource_HSE_Div2))

// PLL multiplication factor
#define RCC_PLLMul_2                     ((u32)0x00000000)
#define RCC_PLLMul_3                     ((u32)0x00040000)
#define RCC_PLLMul_4                     ((u32)0x00080000)
#define RCC_PLLMul_5                     ((u32)0x000C0000)
#define RCC_PLLMul_6                     ((u32)0x00100000)
#define RCC_PLLMul_7                     ((u32)0x00140000)
#define RCC_PLLMul_8                     ((u32)0x00180000)
#define RCC_PLLMul_9                     ((u32)0x001C0000)
#define RCC_PLLMul_10                    ((u32)0x00200000)
#define RCC_PLLMul_11                    ((u32)0x00240000)
#define RCC_PLLMul_12                    ((u32)0x00280000)
#define RCC_PLLMul_13                    ((u32)0x002C0000)
#define RCC_PLLMul_14                    ((u32)0x00300000)
#define RCC_PLLMul_15                    ((u32)0x00340000)
#define RCC_PLLMul_16                    ((u32)0x00380000)

#define __PLLMUL2                     0
#define __PLLMUL3                     1
#define __PLLMUL4                     2
#define __PLLMUL5                     3
#define __PLLMUL6                     4
#define __PLLMUL7                     5
#define __PLLMUL8                     6
#define __PLLMUL9                     7
#define __PLLMUL10                    8
#define __PLLMUL11                    9
#define __PLLMUL12                    10
#define __PLLMUL13                    11
#define __PLLMUL14                    12
#define __PLLMUL15                    13
#define __PLLMUL16                    14


#define IS_RCC_PLL_MUL(MUL) ((MUL == RCC_PLLMul_2) || (MUL == RCC_PLLMul_3)   ||\
                             (MUL == RCC_PLLMul_4) || (MUL == RCC_PLLMul_5)   ||\
                             (MUL == RCC_PLLMul_6) || (MUL == RCC_PLLMul_7)   ||\
                             (MUL == RCC_PLLMul_8) || (MUL == RCC_PLLMul_9)   ||\
                             (MUL == RCC_PLLMul_10) || (MUL == RCC_PLLMul_11) ||\
                             (MUL == RCC_PLLMul_12) || (MUL == RCC_PLLMul_13) ||\
                             (MUL == RCC_PLLMul_14) || (MUL == RCC_PLLMul_15) ||\
                             (MUL == RCC_PLLMul_16))

////////////////////////////////////////////////////////////////////////////////
// System clock source & Status
////////////////////////////////////////////////////////////////////////////////
#define RCC_SYSCLKSource_HSI             ((u32)0x00000000)
#define RCC_SYSCLKSource_HSE             ((u32)0x00000001)
#define RCC_SYSCLKSource_PLLCLK          ((u32)0x00000002)

#define __SW_HSI					0
#define __SW_HSE					1
#define __SW_PLL					2


#define IS_RCC_SYSCLK_SOURCE(SOURCE) ((SOURCE == RCC_SYSCLKSource_HSI) || \
                                      (SOURCE == RCC_SYSCLKSource_HSE) || \
                                      (SOURCE == RCC_SYSCLKSource_PLLCLK))

// AHB clock source(prescaler)
#define RCC_SYSCLK_Div1                  ((u32)0x00000000)
#define RCC_SYSCLK_Div2                  ((u32)0x00000080)
#define RCC_SYSCLK_Div4                  ((u32)0x00000090)
#define RCC_SYSCLK_Div8                  ((u32)0x000000A0)
#define RCC_SYSCLK_Div16                 ((u32)0x000000B0)
#define RCC_SYSCLK_Div64                 ((u32)0x000000C0)
#define RCC_SYSCLK_Div128                ((u32)0x000000D0)
#define RCC_SYSCLK_Div256                ((u32)0x000000E0)
#define RCC_SYSCLK_Div512                ((u32)0x000000F0)

#define __SYSCLK1					0
#define __SYSCLK2					8
#define __SYSCLK4					9
#define __SYSCLK8					10
#define __SYSCLK16					11
#define __SYSCLK64					12
#define __SYSCLK128					13
#define __SYSCLK256					14
#define __SYSCLK512					15


#define IS_RCC_HCLK(HCLK) ((HCLK == RCC_SYSCLK_Div1) || (HCLK == RCC_SYSCLK_Div2) || \
                           (HCLK == RCC_SYSCLK_Div4) || (HCLK == RCC_SYSCLK_Div8) || \
                           (HCLK == RCC_SYSCLK_Div16) || (HCLK == RCC_SYSCLK_Div64) || \
                           (HCLK == RCC_SYSCLK_Div128) || (HCLK == RCC_SYSCLK_Div256) || \
                           (HCLK == RCC_SYSCLK_Div512))

// APB1/APB2 clock source Prescaler
#define RCC_HCLK_Div1                    ((u32)0x00000000)
#define RCC_HCLK_Div2                    ((u32)0x00000400)
#define RCC_HCLK_Div4                    ((u32)0x00000500)
#define RCC_HCLK_Div8                    ((u32)0x00000600)
#define RCC_HCLK_Div16                   ((u32)0x00000700)

#define __HCLK1						0
#define __HCLK2						4
#define __HCLK4						5
#define __HCLK8						6
#define __HCLK16					7


#define IS_RCC_PCLK(PCLK) ((PCLK == RCC_HCLK_Div1) || (PCLK == RCC_HCLK_Div2) || \
                           (PCLK == RCC_HCLK_Div4) || (PCLK == RCC_HCLK_Div8) || \
                           (PCLK == RCC_HCLK_Div16))

// RCC Interrupt source
#define RCC_IT_LSIRDY                    ((u8)0x01)
#define RCC_IT_LSERDY                    ((u8)0x02)
#define RCC_IT_HSIRDY                    ((u8)0x04)
#define RCC_IT_HSERDY                    ((u8)0x08)
#define RCC_IT_PLLRDY                    ((u8)0x10)
#define RCC_IT_CSS                       ((u8)0x80)

#define IS_RCC_IT(IT) (((IT & (u8)0xE0) == 0x00) && (IT != 0x00))
#define IS_RCC_GET_IT(IT) ((IT == RCC_IT_LSIRDY) || (IT == RCC_IT_LSERDY) || \
                           (IT == RCC_IT_HSIRDY) || (IT == RCC_IT_HSERDY) || \
                           (IT == RCC_IT_PLLRDY) || (IT == RCC_IT_CSS))
#define IS_RCC_CLEAR_IT(IT) (((IT & (u8)0x60) == 0x00) && (IT != 0x00))

// USB clock source
#define RCC_USBCLKSource_PLLCLK_1Div5    ((u8)0x00)
#define RCC_USBCLKSource_PLLCLK_Div1     ((u8)0x01)

#define __USBPLLCLK15				0		// devided /1.5  72Mhz/1.5 = 48Mhz()
#define __USBPLLCLK1				1		//

#define IS_RCC_USBCLK_SOURCE(SOURCE) ((SOURCE == RCC_USBCLKSource_PLLCLK_1Div5) || \
                                      (SOURCE == RCC_USBCLKSource_PLLCLK_Div1))

// ADC clock source prescaler
#define __PCLK22					0
#define __PCLK24					1
#define __PCLK26					2
#define __PCLK28					3

// LSE configuration
#define RCC_LSE_OFF						((u8)0x00)
#define RCC_LSE_ON						((u8)0x01)
#define RCC_LSE_Bypass					((u8)0x04)

#define IS_RCC_LSE(LSE) ((LSE == RCC_LSE_OFF) || (LSE == RCC_LSE_ON) || \
                         (LSE == RCC_LSE_Bypass))

// RTC clock source
#define RCC_RTCCLKSource_LSE			((u32)0x00000100)
#define RCC_RTCCLKSource_LSI			((u32)0x00000200)
#define RCC_RTCCLKSource_HSE_Div128		((u32)0x00000300)

#define __RCC_RTCCLKSRC_LSE				1
#define __RCC_RTCCLKSRC_LSI				2
#define __RCC_RTCCLKSRC_HSE				3

#define IS_RCC_RTCCLK_SOURCE(SOURCE) ((SOURCE == RCC_RTCCLKSource_LSE) || \
                                      (SOURCE == RCC_RTCCLKSource_LSI) || \
                                      (SOURCE == RCC_RTCCLKSource_HSE_Div128))

// AHB peripheral
#define __DMA1EN       					0x00000001L
#define __DMA2EN						0x00000002L
#define __SRAM               			0x00000004L
#define __FLITF             			0x00000010L
#define __CRCEN							0x00000040L
#define __FSMCEN						0x00000100L
#define __SDIOEN						0x00000400L

// APB2 peripheral Clock Enable
#define __AFIOEN			            0x00000001L
#define __IOPAEN						0x00000004L
#define __IOPBEN						0x00000008L
#define __IOPCEN						0x00000010L
#define __IOPDEN						0x00000020L
#define __IOPEEN						0x00000040L
#define __IOPFEN						0x00000080L
#define __IOPGEN						0x00000100L
#define __ADC1EN              			0x00000200L
#define __ADC2EN						0x00000400L
#define __TIM1EN              			0x00000800L
#define __SPI1EN              			0x00001000L
#define	__TIM8EN						0x00002000L
#define __USART1EN						0x00004000L
#define __ADC3EN						0x00008000L
#define __APB2EN_ALL               		0x0000FEFDL

// APB1 peripheral Clock Enable
#define __TIM2EN						0x00000001L
#define __TIM3EN              			0x00000002L
#define __TIM4EN              			0x00000004L
#define __TIM5EN						0x00000008L
#define __TIM6EN						0x00000010L
#define __TIM7EN						0x00000020L
#define __WWDGEN              			0x00000800L
#define __SPI2EN              			0x00004000L
#define __SPI3EN              			0x00008000L
#define __USART2EN            			0x00020000L
#define __USART3EN            			0x00040000L
#define __UART4EN						0x00080000L
#define __UART5EN						0x00100000L
#define __I2C1EN              			0x00200000L
#define __I2C2EN              			0x00400000L
#define __USBEN               			0x00800000L
#define __CANEN               			0x02000000L
#define __BKPEN               			0x08000000L
#define __PWREN               			0x10000000L
#define __DACEN							0x20000000L
#define __APB1EN_ALL               		0x3AFEC83FL

// Clock source to output on MCO pin
#define RCC_MCO_NoClock                  ((u8)0x00)
#define RCC_MCO_SYSCLK                   ((u8)0x04)
#define RCC_MCO_HSI                      ((u8)0x05)
#define RCC_MCO_HSE                      ((u8)0x06)
#define RCC_MCO_PLLCLK_Div2              ((u8)0x07)

// RCC Flag
#define RCC_FLAG_HSIRDY                  ((u8)0x20)
#define RCC_FLAG_HSERDY                  ((u8)0x31)
#define RCC_FLAG_PLLRDY                  ((u8)0x39)
#define RCC_FLAG_LSERDY                  ((u8)0x41)
#define RCC_FLAG_LSIRDY                  ((u8)0x61)
#define RCC_FLAG_PINRST                  ((u8)0x7A)
#define RCC_FLAG_PORRST                  ((u8)0x7B)
#define RCC_FLAG_SFTRST                  ((u8)0x7C)
#define RCC_FLAG_IWDGRST                 ((u8)0x7D)
#define RCC_FLAG_WWDGRST                 ((u8)0x7E)
#define RCC_FLAG_LPWRRST                 ((u8)0x7F)

#define IS_RCC_FLAG(FLAG) ((FLAG == RCC_FLAG_HSIRDY) || (FLAG == RCC_FLAG_HSERDY) || \
                           (FLAG == RCC_FLAG_PLLRDY) || (FLAG == RCC_FLAG_LSERDY) || \
                           (FLAG == RCC_FLAG_LSIRDY) || (FLAG == RCC_FLAG_PINRST) || \
                           (FLAG == RCC_FLAG_PORRST) || (FLAG == RCC_FLAG_SFTRST) || \
                           (FLAG == RCC_FLAG_IWDGRST)|| (FLAG == RCC_FLAG_WWDGRST)|| \
                           (FLAG == RCC_FLAG_LPWRRST))

#define IS_RCC_CALIBRATION_VALUE(VALUE) (VALUE <= 0x1F)

/* Exported macro ------------------------------------------------------------*/
#define RCC_BackupResetCmd(sts)	RCC->BDCR.BDRST = sts

// Exported functions ----------------------------------------------------------
void RCC_DeInit(void);
u32 RCC_WaitForHSEStartUp(int flag);
void RCC_AdjustHSICalibrationValue(u8 HSICalibrationValue);
void RCC_HSICmd(INT32U NewState);
void RCC_SYSCLKConfig(u32 RCC_SYSCLKSource);
u8 RCC_GetSYSCLKSource(void);
void RCC_ITConfig(u8 RCC_IT, INT32U NewState);
void RCC_USBCLKConfig(u32 RCC_USBCLKSource);
void RCC_ADCCLKConfig(u32 RCC_ADCCLK);
void RCC_LSEConfig(u32 RCC_LSE);
void RCC_LSICmd(INT32U NewState);
void RCC_RTCCLKConfig(u32 RCC_RTCCLKSource);
void RCC_GetClocksFreq(RCC_ClocksTypeDef* RCC_Clocks);
void RCC_APB2PeriphResetCmd(u32 RCC_APB2Periph, INT32U NewState);
void RCC_APB1PeriphResetCmd(u32 RCC_APB1Periph, INT32U NewState);
void RCC_ClockSecuritySystemCmd(INT32U NewState);
void RCC_MCOConfig(u8 RCC_MCO);
INT32U RCC_GetFlagStatus(u8 RCC_FLAG);
void RCC_ClearFlag(void);
INT32U RCC_GetITStatus(u8 RCC_IT);
void RCC_ClearITPendingBit(u8 RCC_IT);

#endif /* __STM32F10x_RCC_H */

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

