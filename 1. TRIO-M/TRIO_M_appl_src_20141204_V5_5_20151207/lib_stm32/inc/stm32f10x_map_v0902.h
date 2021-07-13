/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_map.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the peripheral register's definitions
*                      and memory mapping.
* Revised            :
*                    : _v0812.h
*                    : high density and support new function
********************************************************************************/
typedef struct
{
	vu32 TIR;
	vu32 TDTR;
	vu32 TDLR;
	vu32 TDHR;
} CAN_TxMailBox_TypeDef;

typedef struct
{
	vu32 RIR;
	vu32 RDTR;
	vu32 RDLR;
	vu32 RDHR;
} CAN_FIFOMailBox_TypeDef;

typedef struct
{
	vu32 FR0;
	vu32 FR1;
} CAN_FilterRegister_TypeDef;

typedef struct
{
	vu32 MCR;
	vu32 MSR;
	vu32 TSR;
	vu32 RF0R;
	vu32 RF1R;
	vu32 IER;
	vu32 ESR;
	vu32 BTR;
	u32 RESERVED0[88];
	CAN_TxMailBox_TypeDef sTxMailBox[3];
	CAN_FIFOMailBox_TypeDef sFIFOMailBox[2];
	u32 RESERVED1[12];
	vu32 FMR;
	vu32 FM0R;
	u32 RESERVED2[1];
	vu32 FS0R;
	u32 RESERVED3[1];
	vu32 FFA0R;
	u32 RESERVED4[1];
	vu32 FA0R;
	u32 RESERVED5[8];
	CAN_FilterRegister_TypeDef sFilterRegister[14];
} CAN_TypeDef;

/*------------------------ DMA Controller ------------------------------------*/
typedef struct
{
	vu32 CCR;
	vu32 CNDTR;
	vu32 CPAR;
	vu32 CMAR;
} DMA_Channel_TypeDef;

typedef struct
{
	vu32 ISR;
	vu32 IFCR;
} DMA_TypeDef;

/*------------------------ External Interrupt/Event Controller ---------------*/
typedef struct
{
	vu32 IMR;
	vu32 EMR;
	vu32 RTSR;
	vu32 FTSR;
	vu32 SWIER;
	vu32 PR;
} EXTI_TypeDef;

/*------------------------ Independent WATCHDOG ------------------------------*/
typedef struct
{
	vu32 KR;
	vu32 PR;
	vu32 RLR;
	vu32 SR;
} IWDG_TypeDef;

/*------------------------ Real-Time Clock -----------------------------------*/
typedef struct
{
	vu16 CRH;
	u16 RESERVED0;
	vu16 CRL;
	u16 RESERVED1;
	vu16 PRLH;
	u16 RESERVED2;
	vu16 PRLL;
	u16 RESERVED3;
	vu16 DIVH;
	u16 RESERVED4;
	vu16 DIVL;
	u16 RESERVED5;
	vu16 CNTH;
	u16 RESERVED6;
	vu16 CNTL;
	u16 RESERVED7;
	vu16 ALRH;
	u16 RESERVED8;
	vu16 ALRL;
	u16 RESERVED9;
} RTC_TypeDef;

/*------------------------ General Purpose Timer -----------------------------*/
typedef struct
{
	vu16 CR1;
	u16 RESERVED0;
	vu16 CR2;
	u16 RESERVED1;
	vu16 SMCR;
	u16 RESERVED2;
	vu16 DIER;
	u16 RESERVED3;
	vu16 SR;
	u16 RESERVED4;
	vu16 EGR;
	u16 RESERVED5;
	vu16 CCMR1;
	u16 RESERVED6;
	vu16 CCMR2;
	u16 RESERVED7;
	vu16 CCER;
	u16 RESERVED8;
	vu16 CNT;
	u16 RESERVED9;
	vu16 PSC;
	u16 RESERVED10;
	vu16 ARR;
	u16 RESERVED11[3];
	vu16 CCR1;
	u16 RESERVED12;
	vu16 CCR2;
	u16 RESERVED13;
	vu16 CCR3;
	u16 RESERVED14;
	vu16 CCR4;
	u16 RESERVED15[3];
	vu16 DCR;
	u16 RESERVED16;
	vu16 DMAR;
	u16 RESERVED17;
} TIM_TypeDef;


/*------------------------ Window WATCHDOG -----------------------------------*/
typedef struct
{
	vu32 CR;
	vu32 CFR;
	vu32 SR;
} WWDG_TypeDef;

/******************************************************************************/
/*                       Peripheral memory map                                */
/******************************************************************************/
// Peripheral and SRAM base address in the alias region
#define PERIPH_BB_BASE			(0x42000000)
#define SRAM_BB_BASE			(0x22000000)

// Peripheral and SRAM base address in the bit-band region
#define SRAM_BASE             	(0x20000000)
#define PERIPH_BASE           	(0x40000000)
#define FLASH_BASE				(0x08000000)
// Flash registers base address
#define FLASH_INT_BASE			(0x40022000)
// Flash Option Bytes base address
#define OB_BASE               	(0x1FFFF800)

// FSMC registers base address
#define FSMC_R_BASE				(0xA0000000)

// FSMC Bankx registers base address
#define FSMC_Bank1_R_BASE		(FSMC_R_BASE + 0x0000)
#define FSMC_Bank1E_R_BASE		(FSMC_R_BASE + 0x0104)
#define FSMC_Bank2_R_BASE		(FSMC_R_BASE + 0x0060)
#define FSMC_Bank3_R_BASE		(FSMC_R_BASE + 0x0080)
#define FSMC_Bank4_R_BASE		(FSMC_R_BASE + 0x00A0)


// Peripheral memory map
#define APB1PERIPH_BASE			PERIPH_BASE
#define APB2PERIPH_BASE			(PERIPH_BASE + 0x10000)
	#define GPIOA_OFFSET		0x0800
	#define GPIOB_OFFSET		0x0C00
	#define GPIOC_OFFSET		0x1000
	#define GPIOD_OFFSET		0x1400
	#define GPIOE_OFFSET		0x1800

#define AHBPERIPH_BASE			(PERIPH_BASE + 0x20000)

#define TIM2_BASE             	(APB1PERIPH_BASE + 0x0000)
#define TIM3_BASE             	(APB1PERIPH_BASE + 0x0400)
#define TIM4_BASE             	(APB1PERIPH_BASE + 0x0800)
#define TIM5_BASE				(APB1PERIPH_BASE + 0x0C00)
#define TIM6_BASE 				(APB1PERIPH_BASE + 0x1000)
#define TIM7_BASE				(APB1PERIPH_BASE + 0x1400)
#define RTC_BASE              	(APB1PERIPH_BASE + 0x2800)
#define WWDG_BASE             	(APB1PERIPH_BASE + 0x2C00)
#define IWDG_BASE             	(APB1PERIPH_BASE + 0x3000)
#define SPI2_BASE             	(APB1PERIPH_BASE + 0x3800)
#define SPI3_BASE				(APB1PERIPH_BASE + 0x3C00)
#define USART2_BASE           	(APB1PERIPH_BASE + 0x4400)
#define USART3_BASE           	(APB1PERIPH_BASE + 0x4800)
#define UART4_BASE				(APB1PERIPH_BASE + 0x4C00)
#define UART5_BASE				(APB1PERIPH_BASE + 0x5000)
#define I2C1_BASE             	(APB1PERIPH_BASE + 0x5400)
#define I2C2_BASE             	(APB1PERIPH_BASE + 0x5800)
#define CAN_BASE              	(APB1PERIPH_BASE + 0x6400)
#define BKP_BASE              	(APB1PERIPH_BASE + 0x6C00)
	#define DR1_BASE			(BKP_BASE + 0x04)
	#define DR2_BASE			(BKP_BASE + 0x08)
	#define DR3_BASE			(BKP_BASE + 0x0C)
	#define DR4_BASE			(BKP_BASE + 0x10)
	#define DR5_BASE			(BKP_BASE + 0x14)
	#define DR6_BASE			(BKP_BASE + 0x18)
	#define DR7_BASE			(BKP_BASE + 0x1C)
	#define DR8_BASE			(BKP_BASE + 0x20)
	#define DR9_BASE			(BKP_BASE + 0x24)
	#define DR10_BASE			(BKP_BASE + 0x28)

#define PWR_BASE              	(APB1PERIPH_BASE + 0x7000)
#define DAC_BASE				(APB1PERIPH_BASE + 0x7400)
////////////////////////////////////////////////////////////////////////////////
#define AFIO_BASE             	(APB2PERIPH_BASE + 0x0000)
#define EXTI_BASE             	(APB2PERIPH_BASE + 0x0400)
#define GPIOA_BASE            	(APB2PERIPH_BASE + 0x0800)
	#define GPIOA_CRL			(GPIOA_BASE + 0x00)
	#define GPIOA_CRH			(GPIOA_BASE + 0x04)
	#define GPIOA_IDR			(GPIOA_BASE + 0x08)
	#define GPIOA_ODR			(GPIOA_BASE + 0x0C)
	#define GPIOA_BSRR			(GPIOA_BASE + 0x10)

	#define GPIOA_BRR			(GPIOA_BASE + 0x14)
	#define GPIOA_LCKR			(GPIOA_BASE + 0x18)

#define GPIOB_BASE            	(APB2PERIPH_BASE + 0x0C00)
	#define GPIOB_CRL			(GPIOB_BASE + 0x00)
	#define GPIOB_CRH			(GPIOB_BASE + 0x04)
	#define GPIOB_IDR			(GPIOB_BASE + 0x08)
	#define GPIOB_ODR			(GPIOB_BASE + 0x0C)
	#define GPIOB_BSRR			(GPIOB_BASE + 0x10)

	#define GPIOB_BRR			(GPIOB_BASE + 0x14)
	#define GPIOB_LCKR			(GPIOB_BASE + 0x18)
	
#define GPIOC_BASE            	(APB2PERIPH_BASE + 0x1000)
	#define GPIOC_CRL			(GPIOC_BASE + 0x00)
	#define GPIOC_CRH			(GPIOC_BASE + 0x04)
	#define GPIOC_IDR			(GPIOC_BASE + 0x08)
	#define GPIOC_ODR			(GPIOC_BASE + 0x0C)
	#define GPIOC_BSRR			(GPIOC_BASE + 0x10)

	#define GPIOC_BRR			(GPIOC_BASE + 0x14)
	#define GPIOC_LCKR			(GPIOC_BASE + 0x18)

#define GPIOD_BASE            	(APB2PERIPH_BASE + 0x1400)
	#define GPIOD_CRL			(GPIOD_BASE + 0x00)
	#define GPIOD_CRH			(GPIOD_BASE + 0x04)
	#define GPIOD_IDR			(GPIOD_BASE + 0x08)
	#define GPIOD_ODR			(GPIOD_BASE + 0x0C)
	#define GPIOD_BSRR			(GPIOD_BASE + 0x10)

	#define GPIOD_BRR			(GPIOD_BASE + 0x14)
	#define GPIOD_LCKR			(GPIOD_BASE + 0x18)

#define GPIOE_BASE            	(APB2PERIPH_BASE + 0x1800)
	#define GPIOE_CRL			(GPIOE_BASE + 0x00)
	#define GPIOE_CRH			(GPIOE_BASE + 0x04)
	#define GPIOE_IDR			(GPIOE_BASE + 0x08)
	#define GPIOE_ODR			(GPIOE_BASE + 0x0C)
	#define GPIOE_BSRR			(GPIOE_BASE + 0x10)

	#define GPIOE_BRR			(GPIOE_BASE + 0x14)
	#define GPIOE_LCKR			(GPIOE_BASE + 0x18)

#define GPIOF_BASE            	(APB2PERIPH_BASE + 0x1C00)
	#define GPIOF_CRL			(GPIOF_BASE + 0x00)
	#define GPIOF_CRH			(GPIOF_BASE + 0x04)
	#define GPIOF_IDR			(GPIOF_BASE + 0x08)
	#define GPIOF_ODR			(GPIOF_BASE + 0x0C)
	#define GPIOF_BSRR			(GPIOF_BASE + 0x10)
	
	#define GPIOF_BRR			(GPIOF_BASE + 0x14)
	#define GPIOF_LCKR			(GPIOF_BASE + 0x18)

#define GPIOG_BASE            	(APB2PERIPH_BASE + 0x2000)
	#define GPIOG_CRL			(GPIOG_BASE + 0x00)
	#define GPIOG_CRH			(GPIOG_BASE + 0x04)
	#define GPIOG_IDR			(GPIOG_BASE + 0x08)
	#define GPIOG_ODR			(GPIOG_BASE + 0x0C)
	#define GPIOG_BSRR			(GPIOG_BASE + 0x10)
		
	#define GPIOG_BRR			(GPIOG_BASE + 0x14)
	#define GPIOG_LCKR			(GPIOG_BASE + 0x18)

#define ADC1_BASE             	(APB2PERIPH_BASE + 0x2400)
	#define ADC1_SR				(ADC1_BASE + 0x00)
	#define ADC1_CR1			(ADC1_BASE + 0x04)
	#define ADC1_CR2			(ADC1_BASE + 0x08)
	#define ADC1_SMPR1			(ADC1_BASE + 0x0C)

	#define ADC1_SMPR2			(ADC1_BASE + 0x10)
	#define ADC1_JOFR1			(ADC1_BASE + 0x14)
	#define ADC1_JOFR2			(ADC1_BASE + 0x18)
	#define ADC1_JOFR3			(ADC1_BASE + 0x1C)

	#define ADC1_JOFR4			(ADC1_BASE + 0x20)
	#define ADC1_HTR			(ADC1_BASE + 0x24)
	#define ADC1_LTR			(ADC1_BASE + 0x28)
	#define ADC1_SQR1			(ADC1_BASE + 0x2C)

	#define ADC1_SQR2			(ADC1_BASE + 0x30)
	#define ADC1_SQR3			(ADC1_BASE + 0x34)
	#define ADC1_JSQR			(ADC1_BASE + 0x38)
	#define ADC1_JDR1			(ADC1_BASE + 0x3C)

	#define ADC1_JDR2			(ADC1_BASE + 0x40)
	#define ADC1_JDR3			(ADC1_BASE + 0x44)
	#define ADC1_JDR4			(ADC1_BASE + 0x48)
	#define ADC1_DR				(ADC1_BASE + 0x4C)

#define ADC2_BASE             	(APB2PERIPH_BASE + 0x2800)
	#define ADC2_SR 			(ADC2_BASE + 0x00)
	#define ADC2_CR1			(ADC2_BASE + 0x04)
	#define ADC2_CR2			(ADC2_BASE + 0x08)
	#define ADC2_SMPR1			(ADC2_BASE + 0x0C)

	#define ADC2_SMPR2			(ADC2_BASE + 0x10)
	#define ADC2_JOFR1			(ADC2_BASE + 0x14)
	#define ADC2_JOFR2			(ADC2_BASE + 0x18)
	#define ADC2_JOFR3			(ADC2_BASE + 0x1C)

	#define ADC2_JOFR4			(ADC2_BASE + 0x20)
	#define ADC2_HTR			(ADC2_BASE + 0x24)
	#define ADC2_LTR			(ADC2_BASE + 0x28)
	#define ADC2_SQR1			(ADC2_BASE + 0x2C)

	#define ADC2_SQR2			(ADC2_BASE + 0x30)
	#define ADC2_SQR3			(ADC2_BASE + 0x34)
	#define ADC2_JSQR			(ADC2_BASE + 0x38)
	#define ADC2_JDR1			(ADC2_BASE + 0x3C)

	#define ADC2_JDR2			(ADC2_BASE + 0x40)
	#define ADC2_JDR3			(ADC2_BASE + 0x44)
	#define ADC2_JDR4			(ADC2_BASE + 0x48)
	#define ADC2_DR 			(ADC2_BASE + 0x4C)
#define TIM1_BASE             	(APB2PERIPH_BASE + 0x2C00)
#define SPI1_BASE             	(APB2PERIPH_BASE + 0x3000)
#define USART1_BASE           	(APB2PERIPH_BASE + 0x3800)

#define DMA_BASE              	(AHBPERIPH_BASE + 0x0000)
#define DMA_Channel1_BASE     	(AHBPERIPH_BASE + 0x0008)
#define DMA_Channel2_BASE     	(AHBPERIPH_BASE + 0x001C)
#define DMA_Channel3_BASE     	(AHBPERIPH_BASE + 0x0030)
#define DMA_Channel4_BASE     	(AHBPERIPH_BASE + 0x0044)
#define DMA_Channel5_BASE     	(AHBPERIPH_BASE + 0x0058)
#define DMA_Channel6_BASE     	(AHBPERIPH_BASE + 0x006C)
#define DMA_Channel7_BASE     	(AHBPERIPH_BASE + 0x0080)
#define RCC_BASE              	(AHBPERIPH_BASE + 0x1000)

// System Control Space memory map
#define SCS_BASE              	((u32)0xE000E000)

#define SysTick_BASE          	(SCS_BASE + 0x0010)
#define NVIC_BASE             	(SCS_BASE + 0x0100)
#define SCB_BASE              	(SCS_BASE + 0x0D00)

#define FLASH_SIZE				(*(INT16U *)0x1FFFF7E0)

#define BOOTSIZE				(20*1024)
#define SYSTEMSIZE				( 2*1024)
#define VEEPSIZE				( 6*1024)

#define APPLSIZE				(((FLASH_SIZE-28)/2)*1024)
#define APBKSIZE				(((FLASH_SIZE-28)/2)*1024)

#define __pBOOT					0
#define __pSYST					(__pBOOT + BOOTSIZE)
#define __pVEEP					(__pSYST + SYSTEMSIZE)
#define __pAPPL					(__pVEEP + VEEPSIZE)
#define __pAPBK					(__pAPPL + APPLSIZE)

#define __pBOOTAddr				(FLASH_BASE + __pBOOT)
#define __pSYSTAddr				(FLASH_BASE + __pSYST)
#define __pAPPLAddr				(FLASH_BASE + __pAPPL)
#define __pAPBKAddr				(FLASH_BASE + __pAPBK)
#define __pVEEPAddr				(FLASH_BASE + __pVEEP)


#define APPOFFSET				__pAPPL

#define ERAM_SIZE				(512*1024L)
#define nExtRAMCS				nCS15

/******************************************************************************/
/*                            IPs' declaration                                */
/******************************************************************************/
#define ADC1                ((ADC_TypeDef *) ADC1_BASE)
#define ADC2                ((ADC_TypeDef *) ADC2_BASE)
#define EXTI                ((EXTI_TypeDef *) EXTI_BASE)
#define TIM2                ((TIM_TypeDef *) TIM2_BASE)
#define TIM3                ((TIM_TypeDef *) TIM3_BASE)
#define TIM4                ((TIM_TypeDef *) TIM4_BASE)
#define RTC                 ((RTC_TypeDef *) RTC_BASE)
#define WWDG                ((WWDG_TypeDef *) WWDG_BASE)
#define IWDG                ((IWDG_TypeDef *) IWDG_BASE)
#define CAN                 ((CAN_TypeDef *) CAN_BASE)
#define DMA                 ((DMA_TypeDef *) DMA_BASE)
#define DMA_Channel1        ((DMA_Channel_TypeDef *) DMA_Channel1_BASE)
#define DMA_Channel2        ((DMA_Channel_TypeDef *) DMA_Channel2_BASE)
#define DMA_Channel3        ((DMA_Channel_TypeDef *) DMA_Channel3_BASE)
#define DMA_Channel4        ((DMA_Channel_TypeDef *) DMA_Channel4_BASE)
#define DMA_Channel5        ((DMA_Channel_TypeDef *) DMA_Channel5_BASE)
#define DMA_Channel6        ((DMA_Channel_TypeDef *) DMA_Channel6_BASE)
#define DMA_Channel7        ((DMA_Channel_TypeDef *) DMA_Channel7_BASE)


/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
