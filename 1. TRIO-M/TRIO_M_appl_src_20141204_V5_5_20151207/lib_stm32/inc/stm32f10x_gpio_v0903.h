/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_gpio.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the functions prototypes for the
*                      GPIO firmware library.
********************************************************************************
* History:
* 05/21/2007: V0.3
* 04/02/2007: V0.2
* 02/05/2007: V0.1
* 09/29/2006: V0.01
********************************************************************************
* THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/
/*------------------------ General Purpose and Alternate Function IO ---------*/

typedef struct
{
	union{
		vu32 Data[2];
		struct	{
			vu32 B0		:4; //port0 configuration 
			vu32 B1		:4; //port1 configuration
			vu32 B2		:4; //port2 configuration
			vu32 B3		:4; //port3 configuration
			vu32 B4		:4; //port4 configuration
			vu32 B5		:4; //port5 configuration
			vu32 B6		:4; //port6 configuration
			vu32 B7		:4; //port7 configuration
			vu32 B8		:4; //port8 configuration
			vu32 B9		:4; //port9 configuration
			vu32 B10	:4; //port10 configuration
			vu32 B11	:4; //port11 configuration
			vu32 B12	:4; //port12 configuration
			vu32 B13	:4; //port13 configuration
			vu32 B14	:4; //port14 configuration
			vu32 B15	:4; //port15 configuration
		};
	} CNF;	
	// port configuration register low
	// port configuration register high

	union{
		vu32 Data;
		struct	{
			vu32 B0		:1;
			vu32 B1		:1;
			vu32 B2		:1;
			vu32 B3		:1;
			vu32 B4		:1;
			vu32 B5		:1;
			vu32 B6		:1;
			vu32 B7		:1;
			vu32 B8		:1;
			vu32 B9		:1;
			vu32 B10	:1;
			vu32 B11	:1;
			vu32 B12	:1;
			vu32 B13	:1;
			vu32 B14	:1;
			vu32 B15	:1;
		};		
	} IDR;	//Port input data register
	
	union{
		vu32 Data;
		struct	{
			vu32 B0		:1;
			vu32 B1		:1;
			vu32 B2		:1;
			vu32 B3		:1;
			vu32 B4		:1;
			vu32 B5		:1;
			vu32 B6		:1;
			vu32 B7		:1;
			vu32 B8		:1;
			vu32 B9		:1;
			vu32 B10	:1;
			vu32 B11	:1;
			vu32 B12	:1;
			vu32 B13	:1;
			vu32 B14	:1;
			vu32 B15	:1;
		};
	} ODR;	//Port output data register

	union{
		vu32 Data;
		struct	{
			vu32 BS0	:1; //set bit
			vu32 BS1	:1; 
			vu32 BS2	:1;
			vu32 BS3	:1;
			vu32 BS4	:1;
			vu32 BS5	:1;
			vu32 BS6	:1;
			vu32 BS7	:1;
			vu32 BS8	:1;
			vu32 BS9	:1;
			vu32 BS10	:1;
			vu32 BS11	:1;
			vu32 BS12	:1;
			vu32 BS13	:1;
			vu32 BS14	:1;
			vu32 BS15	:1;
			vu32 BR0	:1; //reset bit
			vu32 BR1	:1;
			vu32 BR2	:1;
			vu32 BR3	:1;
			vu32 BR4	:1;
			vu32 BR5	:1;
			vu32 BR6	:1;
			vu32 BR7	:1;
			vu32 BR8	:1;
			vu32 BR9	:1;
			vu32 BR10	:1;
			vu32 BR11	:1;
			vu32 BR12	:1;
			vu32 BR13	:1;
			vu32 BR14	:1;
			vu32 BR15	:1;
		};
	} BSRR; //Port bit set/reset register

	union{
		vu32 Data;
		struct	{
			vu32 BR0	:1; //Reset bit
			vu32 BR1	:1; 
			vu32 BR2	:1;
			vu32 BR3	:1;
			vu32 BR4	:1;
			vu32 BR5	:1;
			vu32 BR6	:1;
			vu32 BR7	:1;
			vu32 BR8	:1;
			vu32 BR9	:1;
			vu32 BR10	:1;
			vu32 BR11	:1;
			vu32 BR12	:1;
			vu32 BR13	:1;
			vu32 BR14	:1;
			vu32 BR15	:1;
		};
	} BRR;	//Port bit reset register
	
  vu32 LCKR;
} GPIO_TypeDef;

typedef struct
{
	INT32U EVCR;
	union {
		INT32U Data;
		struct {
			INT32U SPI1_REMAP		:1; 		// 0: NO REMAP, 1: REMAP,
			INT32U I2C1_REMAP		:1;
			INT32U USART1_REMAP 	:1;
			INT32U USART2_REMAP 	:1;
			INT32U USART3_REMAP 	:2;
			INT32U TIM1_REMAP		:2;
			INT32U TIM2_REMAP		:2;
			INT32U TIM3_REMAP		:2;
			INT32U TIM4_REMAP		:1;
			INT32U CAN_REMAP		:2;
			INT32U PD01_REMAP		:1;
			INT32U					:8;
			INT32U SWJ_CFG			:3; 		
										// GPIO_Remap_SWJ_NoJTRST	  ((u32)0x00300100)  /* Full SWJ Enabled (JTAG-DP + SW-DP) but without JTRST */
										// GPIO_Remap_SWJ_JTAGDisable ((u32)0x00300200)  /* JTAG-DP Disabled and SW-DP Enabled */
										// GPIO_Remap_SWJ_Disable	  ((u32)0x00300400)  /* Full SWJ Disabled (JTAG-DP + SW-DP) */
		} ;
	} MAPR;

	union {
		vu32 Data;
		struct {
			vu32 EXTI0				:4;
			vu32 EXTI1				:4;
			vu32 EXTI2				:4;
			vu32 EXTI3				:4;
		};
	} EXTICR1;

	union {
		vu32 Data;
		struct {
			vu32 EXTI4				:4;
			vu32 EXTI5				:4;
			vu32 EXTI6				:4;
			vu32 EXTI7				:4;
		};
	} EXTICR2;

	union {
		vu32 Data;
		struct {
			vu32 EXTI8				:4;
			vu32 EXTI9				:4;
			vu32 EXTI10 			:4;
			vu32 EXTI11 			:4;
		};
	} EXTICR3;

	union {
		vu32 Data;
		struct {
			vu32 EXTI12 			:4;
			vu32 EXTI13 			:4;
			vu32 EXTI14 			:4;
			vu32 EXTI15 			:4;
		};
	} EXTICR4;
	
} AFIO_TypeDef;

// Define to prevent recursive inclusion ---------------------------------------
#define GPIOA               ((GPIO_TypeDef *) GPIOA_BASE)
#define GPIOB               ((GPIO_TypeDef *) GPIOB_BASE)
#define GPIOC               ((GPIO_TypeDef *) GPIOC_BASE)
#define GPIOD               ((GPIO_TypeDef *) GPIOD_BASE)
#define GPIOE               ((GPIO_TypeDef *) GPIOE_BASE)
#define AFIO                ((AFIO_TypeDef *) AFIO_BASE)

// Output Maximum frequency selection ------------------------------------------
enum
{
	__GPIO_10MHz = 1,
	__GPIO_2MHz,
	__GPIO_50MHz
};

// Configuration Mode enumeration ----------------------------------------------
#define __GPIO_AIN				0x00
#define __GPIO_IN_FLOATING		0x04
#define __GPIO_IPD				0x08
#define __GPIO_IPU				0x08
#define __GPIO_OUT_OD			0x04
#define __GPIO_OUT_PP			0x10
#define __GPIO_AF_OD			0x1C
#define __GPIO_AF_PP			0x18

// Bit_SET and Bit_RESET enumeration -------------------------------------------
enum
{
    Bit_RESET = 0,
    Bit_SET
};

// CNFx | MODEx
////////////////////////////////////////////////////////////////////////////////
// Alternate PIN configration

// PORTA
#define __PA0_IN_FL			(__GPIO_IN_FLOATING)
#define __PA0_IN_PU			(__GPIO_IPU)
#define __PA0_IN_PD			(__GPIO_IPD)
#define __PA0_OUT_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA0_OUT_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __WKUP				(__GPIO_IN_FLOATING)
#define __USART2CTS			(__GPIO_IN_FLOATING)
#define __ADC_IN0			(__GPIO_AIN)
#define __TIM2_CH1_ETR		(__GPIO_IN_FLOATING)


#define __PA1_IN_FL			(__GPIO_IN_FLOATING)
#define __PA1_IN_PU			(__GPIO_IPU)
#define __PA1_IN_PD			(__GPIO_IPD)
#define __PA1_OUT_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA1_OUT_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART2RTS			(__GPIO_AF_PP) | __GPIO_50MHz)
#define __ADC_IN1			(__GPIO_AIN)
#define __TIM2_CH2			(__GPIO_IN_FLOATING)

#define __PA2_IN_FL			(__GPIO_IN_FLOATING)
#define __PA2_IN_PU			(__GPIO_IPU)
#define __PA2_IN_PD			(__GPIO_IPD)
#define __PA2_OUT_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA2_OUT_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART2_TX			(__GPIO_AF_PP | __GPIO_50MHz)
#define __ADC_IN2			(__GPIO_AIN)
#define __TIM2_CH3			(__GPIO_IN_FLOATING)

#define __PA3_IN_FL			(__GPIO_IN_FLOATING)
#define __PA3_IN_PU			(__GPIO_IPU)
#define __PA3_IN_PD			(__GPIO_IPD)
#define __PA3_OUT_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA3_OUT_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART2_RX			(__GPIO_IN_FLOATING)
#define __ADC_IN3			(__GPIO_AIN)
#define __TIM2_CH4			(__GPIO_IN_FLOATING)

#define __PA4_IN_FL			(__GPIO_IN_FLOATING)
#define __PA4_IN_PU			(__GPIO_IPU)
#define __PA4_IN_PD			(__GPIO_IPD)
#define __PA4_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA4_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI1_NSS			(__GPIO_IN_FLOATING)
#define __USART2_CK			(__GPIO_IN_FLOATING)
#define __ADC_IN4			(__GPIO_AIN)
#define __DAC1				(__GPIO_AF_OD | __GPIO_50MHz)

#define __PA5_IN_FL			(__GPIO_IN_FLOATING)
#define __PA5_IN_PU			(__GPIO_IPU)
#define __PA5_IN_PD			(__GPIO_IPD)
#define __PA5_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA5_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI1_SCK			(__GPIO_AF_PP | __GPIO_50MHz)
#define __ADC_IN5			(__GPIO_AIN)
#define __DAC2				(__GPIO_AF_OD | __GPIO_50MHz)

#define __PA6_IN_FL			(__GPIO_IN_FLOATING)
#define __PA6_IN_PU			(__GPIO_IPU)
#define __PA6_IN_PD			(__GPIO_IPD)
#define __PA6_OU_OD			(__GPIO_OUT_OD| __GPIO_50MHz)
#define __PA6_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI1_MISO			(__GPIO_AF_PP | __GPIO_50MHz)//(__GPIO_IN_FLOATING)
#define __ADC_IN6			(__GPIO_AIN)
#define __TIM3_CH1			(__GPIO_IN_FLOATING)

#define __PA7_IN_FL			(__GPIO_IN_FLOATING)
#define __PA7_IN_PU			(__GPIO_IPU)
#define __PA7_IN_PD			(__GPIO_IPD)
#define __PA7_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA7_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI1_MOSI			(__GPIO_AF_PP | __GPIO_50MHz)
#define __ADC_IN7			(__GPIO_AIN)
#define __TIM3_CH2			(__GPIO_IN_FLOATING)

#define __PA8_IN_FL			(__GPIO_IN_FLOATING)
#define __PA8_IN_PU			(__GPIO_IPU)
#define __PA8_IN_PD			(__GPIO_IPD)
#define __PA8_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA8_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART1_CK			(__GPIO_IN_FLOATING)
#define __TIM1_CH1			(__GPIO_IN_FLOATING)
#define __TIM1_CH1_PWM		(__GPIO_AF_PP | __GPIO_50MHz)
#define __MCO				

#define __PA9_IN_FL			(__GPIO_IN_FLOATING)
#define __PA9_IN_PU			(__GPIO_IPU)
#define __PA9_IN_PD			(__GPIO_IPD)
#define __PA9_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA9_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART1_TX			(__GPIO_AF_PP | __GPIO_50MHz)
#define __TIM1_CH2			(__GPIO_IN_FLOATING)

#define __PA10_IN_FL		(__GPIO_IN_FLOATING)
#define __PA10_IN_PU		(__GPIO_IPU)
#define __PA10_IN_PD		(__GPIO_IPD)
#define __PA10_OU_OD		(__GPIO_OUT_OD) | __GPIO_50MHz)
#define __PA10_OU_PP		(__GPIO_OUT_PP) | __GPIO_50MHz)
#define __USART1_RX			(__GPIO_IN_FLOATING)
#define __TIM1_CH3			(__GPIO_IN_FLOATING)

#define __PA11_IN_FL		(__GPIO_IN_FLOATING)
#define __PA11_IN_PU		(__GPIO_IPU)
#define __PA11_IN_PD		(__GPIO_IPD)
#define __PA11_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA11_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART1_CTS		(__GPIO_IN_FLOATING)
#define __CANRX
#define __USBDM
#define __TIM1_CH4			(__GPIO_IN_FLOATING)
#define __TIM1_CH4_PWM		(__GPIO_AF_PP | __GPIO_50MHz)

#define __PA12_IN_FL		(__GPIO_IN_FLOATING)
#define __PA12_IN_PU		(__GPIO_IPU)
#define __PA12_IN_PD		(__GPIO_IPD)
#define __PA12_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA12_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART1_RTS		(__GPIO_AF_OD | __GPIO_50MHz)
#define __CANTX
#define __USBDP
#define __TIM1_ETR			(__GPIO_IN_FLOATING)

#define __PA13_IN_FL		(__GPIO_IN_FLOATING)
#define __PA13_IN_PU		(__GPIO_IPU)
#define __PA13_IN_PD		(__GPIO_IPD)
#define __PA13_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA13_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __JTMS
#define __SWDIO

#define __PA14_IN_FL		(__GPIO_IN_FLOATING)
#define __PA14_IN_PU		(__GPIO_IPU)
#define __PA14_IN_PD		(__GPIO_IPD)
#define __PA14_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA14_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __JTCK
#define __SWCLK

#define __PA15_IN_FL		(__GPIO_IN_FLOATING)
#define __PA15_IN_PU		(__GPIO_IPU)
#define __PA15_IN_PD		(__GPIO_IPD)
#define __PA15_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PA15_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __JTDI

// PORTB
#define __PB0_IN_FL			(__GPIO_IN_FLOATING)
#define __PB0_IN_PU			(__GPIO_IPU)
#define __PB0_IN_PD			(__GPIO_IPD)
#define __PB0_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB0_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __ADC_IN8			(__GPIO_AIN)
#define __TIM3_CH3			(__GPIO_IN_FLOATING)

#define __PB1_IN_FL			(__GPIO_IN_FLOATING)
#define __PB1_IN_PU			(__GPIO_IPU)
#define __PB1_IN_PD			(__GPIO_IPD)
#define __PB1_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB1_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __ADC_IN9			(__GPIO_AIN)
#define __TIM3_CH4			(__GPIO_IN_FLOATING)

#define __PB2_IN_FL			(__GPIO_IN_FLOATING)
#define __PB2_IN_PU			(__GPIO_IPU)
#define __PB2_IN_PD			(__GPIO_IPD)
#define __PB2_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB2_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __BOOT1

#define __PB3_IN_FL			(__GPIO_IN_FLOATING)
#define __PB3_IN_PU			(__GPIO_IPU)
#define __PB3_IN_PD			(__GPIO_IPD)
#define __PB3_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB3_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __JTDO
#define __TRACESWO

#define __PB4_IN_FL			(__GPIO_IN_FLOATING)
#define __PB4_IN_PU			(__GPIO_IPU)
#define __PB4_IN_PD			(__GPIO_IPD)
#define __PB4_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB4_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __JNTRST

#define __PB5_IN_FL			(__GPIO_IN_FLOATING)
#define __PB5_IN_PU			(__GPIO_IPU)
#define __PB5_IN_PD			(__GPIO_IPD)
#define __PB5_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB5_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __I2C1_SMBAI

#define __PB6_IN_FL			(__GPIO_IN_FLOATING)
#define __PB6_IN_PU			(__GPIO_IPU)
#define __PB6_IN_PD			(__GPIO_IPD)
#define __PB6_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB6_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __I2C1_SCL			(__GPIO_AF_OD | __GPIO_50MHz)
#define __TIM4_CH1			(__GPIO_IN_FLOATING)

#define __PB7_IN_FL			(__GPIO_IN_FLOATING)
#define __PB7_IN_PU			(__GPIO_IPU)
#define __PB7_IN_PD			(__GPIO_IPD)
#define __PB7_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB7_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __I2C1_SDA			(__GPIO_AF_OD | __GPIO_50MHz)
#define __TIM4_CH2			(__GPIO_IN_FLOATING)
#define __NADV				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PB8_IN_FL			(__GPIO_IN_FLOATING)
#define __PB8_IN_PU			(__GPIO_IPU)
#define __PB8_IN_PD			(__GPIO_IPD)
#define __PB8_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB8_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TIM4_CH3			(__GPIO_IN_FLOATING)

#define __PB9_IN_FL			(__GPIO_IN_FLOATING)
#define __PB9_IN_PU			(__GPIO_IPU)
#define __PB9_IN_PD			(__GPIO_IPD)
#define __PB9_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB9_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TIM4_CH4			(__GPIO_IN_FLOATING)

#define __PB10_IN_FL		(__GPIO_IN_FLOATING)
#define __PB10_IN_PU		(__GPIO_IPU)
#define __PB10_IN_PD		(__GPIO_IPD)
#define __PB10_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB10_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __I2C2_SCL
#define __USART3_TX			(__GPIO_AF_PP | __GPIO_50MHz)

#define __PB11_IN_FL		(__GPIO_IN_FLOATING)
#define __PB11_IN_PU		(__GPIO_IPU)
#define __PB11_IN_PD		(__GPIO_IPD)
#define __PB11_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB11_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __I2C2_SDA
#define __USART3_RX			(__GPIO_IN_FLOATING)

#define __PB12_IN_FL		(__GPIO_IN_FLOATING)
#define __PB12_IN_PU		(__GPIO_IPU)
#define __PB12_IN_PD		(__GPIO_IPD)
#define __PB12_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB12_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI2_NSS			(__GPIO_AF_PP | __GPIO_50MHz)
#define __I2C2_SMBA
#define __USART3_CK			(__GPIO_IN_FLOATING)
#define __TIM1_BKIN			(__GPIO_IN_FLOATING)

#define __PB13_IN_FL		(__GPIO_IN_FLOATING)
#define __PB13_IN_PU		(__GPIO_IPU)
#define __PB13_IN_PD		(__GPIO_IPD)
#define __PB13_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB13_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI2_SCK			(__GPIO_AF_PP | __GPIO_50MHz)
#define __USART3_CTS		(__GPIO_IN_FLOATING)
#define __TIM1_CH1N			(__GPIO_IN_FLOATING)

#define __PB14_IN_FL		(__GPIO_IN_FLOATING)
#define __PB14_IN_PU		(__GPIO_IPU)
#define __PB14_IN_PD		(__GPIO_IPD)
#define __PB14_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB14_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI2_MISO			(__GPIO_AF_PP | __GPIO_50MHz)
#define __USART3_RTS		(__GPIO_AF_PP | __GPIO_50MHz)
#define __TIM1_CH2N			(__GPIO_IN_FLOATING)

#define __PB15_IN_FL		(__GPIO_IN_FLOATING)
#define __PB15_IN_PU		(__GPIO_IPU)
#define __PB15_IN_PD		(__GPIO_IPD)
#define __PB15_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PB15_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __SPI2_MOSI			(__GPIO_AF_PP | __GPIO_50MHz)
#define __TIM1_CH3N			(__GPIO_IN_FLOATING)


// PORTC
#define __PC0_IN_FL			(__GPIO_IN_FLOATING)
#define __PC0_IN_PU			(__GPIO_IPU)
#define __PC0_IN_PD			(__GPIO_IPD)
#define __PC0_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC0_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __ADC_IN10			(__GPIO_AIN)

#define __PC1_IN_FL			(__GPIO_IN_FLOATING)
#define __PC1_IN_PU			(__GPIO_IPU)
#define __PC1_IN_PD			(__GPIO_IPD)
#define __PC1_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC1_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __ADC_IN11			(__GPIO_AIN)

#define __PC2_IN_FL			(__GPIO_IN_FLOATING)
#define __PC2_IN_PU			(__GPIO_IPU)
#define __PC2_IN_PD			(__GPIO_IPD)
#define __PC2_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC2_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __ADC_IN12			(__GPIO_AIN)

#define __PC3_IN_FL			(__GPIO_IN_FLOATING)
#define __PC3_IN_PU			(__GPIO_IPU)
#define __PC3_IN_PD			(__GPIO_IPD)
#define __PC3_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC3_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __RTC_CLK			(__GPIO_AF_PP | __GPIO_50MHz)
#define __ADC_IN13			(__GPIO_AIN)	

#define __PC4_IN_FL			(__GPIO_IN_FLOATING)
#define __PC4_IN_PU			(__GPIO_IPU)
#define __PC4_IN_PD			(__GPIO_IPD)
#define __PC4_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC4_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __ADC_IN14			(__GPIO_AIN)

#define __PC5_IN_FL			(__GPIO_IN_FLOATING)
#define __PC5_IN_PU			(__GPIO_IPU)
#define __PC5_IN_PD			(__GPIO_IPD)
#define __PC5_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC5_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __ADC_IN15			(__GPIO_AIN)


#define __PC6_IN_FL			(__GPIO_IN_FLOATING)
#define __PC6_IN_PU			(__GPIO_IPU)
#define __PC6_IN_PD			(__GPIO_IPD)
#define __PC6_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC6_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)

#define __PC7_IN_FL			(__GPIO_IN_FLOATING)
#define __PC7_IN_PU			(__GPIO_IPU)
#define __PC7_IN_PD			(__GPIO_IPD)
#define __PC7_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC7_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)

#define __PC8_IN_FL			(__GPIO_IN_FLOATING)
#define __PC8_IN_PU			(__GPIO_IPU)
#define __PC8_IN_PD			(__GPIO_IPD)
#define __PC8_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC8_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)

#define __PC9_IN_FL			(__GPIO_IN_FLOATING)
#define __PC9_IN_PU			(__GPIO_IPU)
#define __PC9_IN_PD			(__GPIO_IPD)
#define __PC9_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC9_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)

#define __PC10_IN_FL		(__GPIO_IN_FLOATING)
#define __PC10_IN_PU		(__GPIO_IPU)
#define __PC10_IN_PD		(__GPIO_IPD)
#define __PC10_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC10_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART4_TX			(__GPIO_AF_PP | __GPIO_50MHz)

#define __PC11_IN_FL		(__GPIO_IN_FLOATING)
#define __PC11_IN_PU		(__GPIO_IPU)
#define __PC11_IN_PD		(__GPIO_IPD)
#define __PC11_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC11_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART4_RX			(__GPIO_IN_FLOATING)

#define __PC12_IN_FL		(__GPIO_IN_FLOATING)
#define __PC12_IN_PU		(__GPIO_IPU)
#define __PC12_IN_PD		(__GPIO_IPD)
#define __PC12_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PC12_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __USART5_TX			(__GPIO_AF_PP | __GPIO_50MHz)

#define __PC13_IN_FL		(__GPIO_IN_FLOATING)
#define __PC13_IN_PU		(__GPIO_IPU)
#define __PC13_IN_PD		(__GPIO_IPD)
#define __PC13_OU_OD		(__GPIO_OUT_OD | __GPIO_2MHz)
#define __PC13_OU_PP		(__GPIO_OUT_PP | __GPIO_2MHz)
#define __ANTI_TAMP

#define __PC14_IN_FL		(__GPIO_IN_FLOATING)
#define __PC14_IN_PU		(__GPIO_IPU)
#define __PC14_IN_PD		(__GPIO_IPD)
#define __PC14_OU_OD		(__GPIO_OUT_OD | __GPIO_2MHz)
#define __PC14_OU_PP		(__GPIO_OUT_PP | __GPIO_2MHz)
#define __OSC32IN

#define __PC15_IN_FL		(__GPIO_IN_FLOATING)
#define __PC15_IN_PU		(__GPIO_IPU)
#define __PC15_IN_PD		(__GPIO_IPD)
#define __PC15_OU_OD		(__GPIO_OUT_OD | __GPIO_2MHz)
#define __PC15_OU_PP		(__GPIO_OUT_PP | __GPIO_2MHz)
#define __OSC32OUT

// PORTD
#define __PD0_IN_FL			(__GPIO_IN_FLOATING)
#define __PD0_IN_PU			(__GPIO_IPU)
#define __PD0_IN_PD			(__GPIO_IPD)
#define __PD0_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD0_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD2				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD1_IN_FL			(__GPIO_IN_FLOATING & 0x0f)
#define __PD1_IN_PU			(__GPIO_IPU & 0x0f)
#define __PD1_IN_PD			(__GPIO_IPD & 0x0f)
#define __PD1_OU_OD			(__GPIO_OUT_OD | __GPIO_2MHz)
#define __PD1_OU_PP			(__GPIO_OUT_PP | __GPIO_2MHz)
#define __FAD3				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD2_IN_FL			(__GPIO_IN_FLOATING & 0x0f)
#define __PD2_IN_PU			(__GPIO_IPU)
#define __PD2_IN_PD			(__GPIO_IPD)
#define __PD2_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD2_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TIM3_ETR			
#define __USART5_RX			(__GPIO_IN_FLOATING)

#define __PD3_IN_FL			(__GPIO_IN_FLOATING)
#define __PD3_IN_PU			(__GPIO_IPU)
#define __PD3_IN_PD			(__GPIO_IPD)
#define __PD3_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD3_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)

#define __PD4_IN_FL			(__GPIO_IN_FLOATING & 0x0f)
#define __PD4_IN_PU			(__GPIO_IPU)
#define __PD4_IN_PD			(__GPIO_IPD)
#define __PD4_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD4_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __NOE				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD5_IN_FL			(__GPIO_IN_FLOATING)
#define __PD5_IN_PU			(__GPIO_IPU)
#define __PD5_IN_PD			(__GPIO_IPD)
#define __PD5_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD5_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __NWE				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD6_IN_FL			(__GPIO_IN_FLOATING)
#define __PD6_IN_PU			(__GPIO_IPU)
#define __PD6_IN_PD			(__GPIO_IPD)
#define __PD6_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD6_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __NWAIT				(__GPIO_IN_FLOATING)

#define __PD7_IN_FL			(__GPIO_IN_FLOATING)
#define __PD7_IN_PU			(__GPIO_IPU)
#define __PD7_IN_PD			(__GPIO_IPD)
#define __PD7_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD7_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __NCE				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD8_IN_FL			(__GPIO_IN_FLOATING)
#define __PD8_IN_PU			(__GPIO_IPU)
#define __PD8_IN_PD			(__GPIO_IPD)
#define __PD8_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD8_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD13				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD9_IN_FL			(__GPIO_IN_FLOATING)
#define __PD9_IN_PU			(__GPIO_IPU)
#define __PD9_IN_PD			(__GPIO_IPD)
#define __PD9_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD9_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD14				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD10_IN_FL		(__GPIO_IN_FLOATING)
#define __PD10_IN_PU		(__GPIO_IPU)
#define __PD10_IN_PD		(__GPIO_IPD)
#define __PD10_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD10_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD15				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD11_IN_FL		(__GPIO_IN_FLOATING)
#define __PD11_IN_PU		(__GPIO_IPU)
#define __PD11_IN_PD		(__GPIO_IPD)
#define __PD11_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD11_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FA16				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD12_IN_FL		(__GPIO_IN_FLOATING)
#define __PD12_IN_PU		(__GPIO_IPU)
#define __PD12_IN_PD		(__GPIO_IPD)
#define __PD12_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD12_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FA17				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD13_IN_FL		(__GPIO_IN_FLOATING)
#define __PD13_IN_PU		(__GPIO_IPU)
#define __PD13_IN_PD		(__GPIO_IPD)
#define __PD13_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD13_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FA18				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD14_IN_FL		(__GPIO_IN_FLOATING)
#define __PD14_IN_PU		(__GPIO_IPU)
#define __PD14_IN_PD		(__GPIO_IPD)
#define __PD14_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD14_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD0				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PD15_IN_FL		(__GPIO_IN_FLOATING)
#define __PD15_IN_PU		(__GPIO_IPU)
#define __PD15_IN_PD		(__GPIO_IPD)
#define __PD15_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PD15_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD1				(__GPIO_AF_PP  | __GPIO_50MHz)
// PORTE

#define __PE0_IN_FL			(__GPIO_IN_FLOATING)
#define __PE0_IN_PU			(__GPIO_IPU)
#define __PE0_IN_PD			(__GPIO_IPD)
#define __PE0_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE0_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TIM4_ETR			(__GPIO_IN_FLOATING)
#define __NBL0				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE1_IN_FL			(__GPIO_IN_FLOATING)
#define __PE1_IN_PU			(__GPIO_IPU)
#define __PE1_IN_PD			(__GPIO_IPD)
#define __PE1_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE1_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __NBL1				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE2_IN_FL			(__GPIO_IN_FLOATING)
#define __PE2_IN_PU			(__GPIO_IPU)
#define __PE2_IN_PD			(__GPIO_IPD)
#define __PE2_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE2_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TRACECK
#define __FA23				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE3_IN_FL			(__GPIO_IN_FLOATING & 0x0f)
#define __PE3_IN_PU			(__GPIO_IPU)
#define __PE3_IN_PD			(__GPIO_IPD)
#define __PE3_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE3_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TRACED0
#define __FA19				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE4_IN_FL			(__GPIO_IN_FLOATING & 0x0f)
#define __PE4_IN_PU			(__GPIO_IPU)
#define __PE4_IN_PD			(__GPIO_IPD)
#define __PE4_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE4_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TRACED1
#define __FA20				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE5_IN_FL			(__GPIO_IN_FLOATING)
#define __PE5_IN_PU			(__GPIO_IPU)
#define __PE5_IN_PD			(__GPIO_IPD)
#define __PE5_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE5_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TRACED2
#define __FA21				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE6_IN_FL			(__GPIO_IN_FLOATING)
#define __PE6_IN_PU			(__GPIO_IPU)
#define __PE6_IN_PD			(__GPIO_IPD)
#define __PE6_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE6_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __TRACED3
#define __FA22				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE7_IN_FL			(__GPIO_IN_FLOATING & 0x0f)
#define __PE7_IN_PU			(__GPIO_IPU)
#define __PE7_IN_PD			(__GPIO_IPD)
#define __PE7_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE7_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD4				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE8_IN_FL			(__GPIO_IN_FLOATING)
#define __PE8_IN_PU			(__GPIO_IPU)
#define __PE8_IN_PD			(__GPIO_IPD)
#define __PE8_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE8_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD5				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE9_IN_FL			(__GPIO_IN_FLOATING)
#define __PE9_IN_PU			(__GPIO_IPU)
#define __PE9_IN_PD			(__GPIO_IPD)
#define __PE9_OU_OD			(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE9_OU_PP			(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD6				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE10_IN_FL		(__GPIO_IN_FLOATING)
#define __PE10_IN_PU		(__GPIO_IPU)
#define __PE10_IN_PD		(__GPIO_IPD)
#define __PE10_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE10_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD7				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE11_IN_FL		(__GPIO_IN_FLOATING)
#define __PE11_IN_PU		(__GPIO_IPU)
#define __PE11_IN_PD		(__GPIO_IPD)
#define __PE11_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE11_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD8				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE12_IN_FL		(__GPIO_IN_FLOATING)
#define __PE12_IN_PU		(__GPIO_IPU)
#define __PE12_IN_PD		(__GPIO_IPD)
#define __PE12_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE12_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD9				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE13_IN_FL		(__GPIO_IN_FLOATING)
#define __PE13_IN_PU		(__GPIO_IPU)
#define __PE13_IN_PD		(__GPIO_IPD)
#define __PE13_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE13_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD10				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE14_IN_FL		(__GPIO_IN_FLOATING)
#define __PE14_IN_PU		(__GPIO_IPU)
#define __PE14_IN_PD		(__GPIO_IPD)
#define __PE14_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE14_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD11				(__GPIO_AF_PP  | __GPIO_50MHz)

#define __PE15_IN_FL		(__GPIO_IN_FLOATING)
#define __PE15_IN_PU		(__GPIO_IPU)
#define __PE15_IN_PD		(__GPIO_IPD)
#define __PE15_OU_OD		(__GPIO_OUT_OD | __GPIO_50MHz)
#define __PE15_OU_PP		(__GPIO_OUT_PP | __GPIO_50MHz)
#define __FAD12				(__GPIO_AF_PP  | __GPIO_50MHz)

// Exported constants ----------------------------------------------------------
// GPIO pins define ------------------------------------------------------------
#define GPIO_Pin_0                 ((u16)0x0001)  /* Pin 0 selected */
#define GPIO_Pin_1                 ((u16)0x0002)  /* Pin 1 selected */
#define GPIO_Pin_2                 ((u16)0x0004)  /* Pin 2 selected */
#define GPIO_Pin_3                 ((u16)0x0008)  /* Pin 3 selected */
#define GPIO_Pin_4                 ((u16)0x0010)  /* Pin 4 selected */
#define GPIO_Pin_5                 ((u16)0x0020)  /* Pin 5 selected */
#define GPIO_Pin_6                 ((u16)0x0040)  /* Pin 6 selected */
#define GPIO_Pin_7                 ((u16)0x0080)  /* Pin 7 selected */
#define GPIO_Pin_8                 ((u16)0x0100)  /* Pin 8 selected */
#define GPIO_Pin_9                 ((u16)0x0200)  /* Pin 9 selected */
#define GPIO_Pin_10                ((u16)0x0400)  /* Pin 10 selected */
#define GPIO_Pin_11                ((u16)0x0800)  /* Pin 11 selected */
#define GPIO_Pin_12                ((u16)0x1000)  /* Pin 12 selected */
#define GPIO_Pin_13                ((u16)0x2000)  /* Pin 13 selected */
#define GPIO_Pin_14                ((u16)0x4000)  /* Pin 14 selected */
#define GPIO_Pin_15                ((u16)0x8000)  /* Pin 15 selected */
#define GPIO_Pin_All               ((u16)0xFFFF)  /* All pins selected */


// GPIO Remap define -----------------------------------------------------------
#define GPIO_Remap_SPI1				((u32)0x00000001)	// SPI1 Alternate Function mapping
#define GPIO_Remap_I2C1				((u32)0x00000002)	// I2C1 Alternate Function mapping
#define GPIO_Remap_USART1			((u32)0x00000004)	// USART1 Alternate Function mapping
#define GPIO_Remap_USART2          ((u32)0x00000008)  /* USART2 Alternate Function mapping */
#define GPIO_PartialRemap_USART3   ((u32)0x00140010)  /* USART3 Partial Alternate Function mapping */
#define GPIO_FullRemap_USART3      ((u32)0x00140030)  /* USART3 Full Alternate Function mapping */
#define GPIO_PartialRemap_TIM1     ((u32)0x00160040)  /* TIM1 Partial Alternate Function mapping */
#define GPIO_FullRemap_TIM1        ((u32)0x001600C0)  /* TIM1 Full Alternate Function mapping */
#define GPIO_PartialRemap1_TIM2    ((u32)0x00180100)  /* TIM2 Partial1 Alternate Function mapping */
#define GPIO_PartialRemap2_TIM2    ((u32)0x00180200)  /* TIM2 Partial2 Alternate Function mapping */
#define GPIO_FullRemap_TIM2        ((u32)0x00180300)  /* TIM2 Full Alternate Function mapping */
#define GPIO_PartialRemap_TIM3     ((u32)0x001A0800)  /* TIM3 Partial Alternate Function mapping */
#define GPIO_FullRemap_TIM3        ((u32)0x001A0C00)  /* TIM3 Full Alternate Function mapping */
#define GPIO_Remap_TIM4            ((u32)0x00001000)  /* TIM4 Alternate Function mapping */
#define GPIO_Remap1_CAN            ((u32)0x001D2000)  /* CAN Alternate Function mapping */
#define GPIO_Remap2_CAN            ((u32)0x001D6000)  /* CAN Alternate Function mapping */
#define GPIO_Remap_PD01            ((u32)0x00008000)  /* PD01 Alternate Function mapping */

#define GPIO_Remap_SWJ_NoJTRST     ((u32)0x00300100)  /* Full SWJ Enabled (JTAG-DP + SW-DP) but without JTRST */
#define GPIO_Remap_SWJ_JTAGDisable ((u32)0x00300200)  /* JTAG-DP Disabled and SW-DP Enabled */
#define GPIO_Remap_SWJ_Disable     ((u32)0x00300400)  /* Full SWJ Disabled (JTAG-DP + SW-DP) */

#define __SWJ_RMAP_NORMAP			0	// FULL SWJ Enabled (JTAB-DP + SW-DP)
#define __SWJ_RMAP_NOJTRST			1	// Full SWJ Enabled (JTAG-DP + SW-DP) but without JTRST
#define __SWJ_RMAP_JTAGDISABLE		2	// JTAG-DP Disabled and SW-DP Enabled
#define __SWJ_RMAP_DISABLE			4	// Full SWJ Disabled (JTAG-DP + SW-DP)


// GPIO Port Sources -----------------------------------------------------------
#define GPIO_PortSrcGPIOA       ((u8)0x00)
#define GPIO_PortSrcGPIOB       ((u8)0x01)
#define GPIO_PortSrcGPIOC       ((u8)0x02)
#define GPIO_PortSrcGPIOD       ((u8)0x03)
#define GPIO_PortSrcGPIOE       ((u8)0x04)

// GPIO Pin sources ------------------------------------------------------------
#define GPIO_PinSrc0            ((u8)0x00)
#define GPIO_PinSrc1            ((u8)0x01)
#define GPIO_PinSrc2            ((u8)0x02)
#define GPIO_PinSrc3            ((u8)0x03)
#define GPIO_PinSrc4            ((u8)0x04)
#define GPIO_PinSrc5            ((u8)0x05)
#define GPIO_PinSrc6            ((u8)0x06)
#define GPIO_PinSrc7            ((u8)0x07)
#define GPIO_PinSrc8            ((u8)0x08)
#define GPIO_PinSrc9            ((u8)0x09)
#define GPIO_PinSrc10           ((u8)0x0A)
#define GPIO_PinSrc11           ((u8)0x0B)
#define GPIO_PinSrc12           ((u8)0x0C)
#define GPIO_PinSrc13           ((u8)0x0D)
#define GPIO_PinSrc14           ((u8)0x0E)
#define GPIO_PinSrc15           ((u8)0x0F)

/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void GPIO_PinLockConfig(GPIO_TypeDef* GPIOx, u16 GPIO_Pin);
void GPIO_EventOutputConfig(u8 GPIO_PortSource, u8 GPIO_PinSource);
void GPIO_EventOutputCmd(INT32U NewState);
void GPIO_PinRemapConfig(u32 GPIO_Remap, INT32U NewState);
void GPIO_EXTILineConfig(u32 GPIO_SRC, u8 PORTx);


/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
