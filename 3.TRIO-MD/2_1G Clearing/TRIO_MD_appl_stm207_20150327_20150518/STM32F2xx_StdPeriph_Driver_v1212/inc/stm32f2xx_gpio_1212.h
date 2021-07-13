/**
  ******************************************************************************
  * @file    stm32f2xx_gpio.h
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    18-April-2011
  * @brief   This file contains all the functions prototypes for the GPIO firmware
  *          library.
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F2xx_GPIO_H
#define __STM32F2xx_GPIO_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/

/** @addtogroup STM32F2xx_StdPeriph_Driver
  * @{
  */

/** @addtogroup GPIO
  * @{
  */ 

/* Exported types ------------------------------------------------------------*/

#define IS_GPIO_ALL_PERIPH(PERIPH) (((PERIPH) == GPIOA) || \
                                    ((PERIPH) == GPIOB) || \
                                    ((PERIPH) == GPIOC) || \
                                    ((PERIPH) == GPIOD) || \
                                    ((PERIPH) == GPIOE) || \
                                    ((PERIPH) == GPIOF) || \
                                    ((PERIPH) == GPIOG) || \
                                    ((PERIPH) == GPIOH) || \
                                    ((PERIPH) == GPIOI))
                                                                
/** 
  * @brief  GPIO Configuration Mode enumeration 
  */   
typedef enum
{ 
	GPIO_Mode_IN   = 0x00, /*!< GPIO Input Mode */
	GPIO_Mode_OUT  = 0x01, /*!< GPIO Output Mode */
	GPIO_Mode_AF   = 0x02, /*!< GPIO Alternate function Mode */
	GPIO_Mode_AN   = 0x03  /*!< GPIO Analog Mode */
} GPIOMode_TypeDef;



#define IS_GPIO_MODE(MODE) (((MODE) == GPIO_Mode_IN)  || ((MODE) == GPIO_Mode_OUT) || \
                            ((MODE) == GPIO_Mode_AF)|| ((MODE) == GPIO_Mode_AN))

/** 
  * @brief  GPIO Output type enumeration 
  */  
typedef enum
{ 
	GPIO_OType_PP = 0x00,
	GPIO_OType_OD = 0x01
}GPIOOType_TypeDef;
#define IS_GPIO_OTYPE(OTYPE) (((OTYPE) == GPIO_OType_PP) || ((OTYPE) == GPIO_OType_OD))


/** 
  * @brief  GPIO Output Maximum frequency enumeration 
  */  
typedef enum
{ 
	GPIO_Speed_2MHz   = 0x00, /*!< Low speed */
	GPIO_Speed_25MHz  = 0x01, /*!< Medium speed */
	GPIO_Speed_50MHz  = 0x02, /*!< Fast speed */
	GPIO_Speed_100MHz = 0x03  /*!< High speed on 30 pF (80 MHz Output max speed on 15 pF) */
}GPIOSpeed_TypeDef;
#define IS_GPIO_SPEED(SPEED) (((SPEED) == GPIO_Speed_2MHz) || ((SPEED) == GPIO_Speed_25MHz) || \
                              ((SPEED) == GPIO_Speed_50MHz)||  ((SPEED) == GPIO_Speed_100MHz)) 

/** 
  * @brief  GPIO Configuration PullUp PullDown enumeration 
  */ 
typedef enum
{ 
	GPIO_PuPd_NOPULL = 0x00,
	GPIO_PuPd_UP     = 0x01,
	GPIO_PuPd_DOWN   = 0x02
}GPIOPuPd_TypeDef;
#define IS_GPIO_PUPD(PUPD) (((PUPD) == GPIO_PuPd_NOPULL) || ((PUPD) == GPIO_PuPd_UP) || \
                            ((PUPD) == GPIO_PuPd_DOWN))

/** 
  * @brief  GPIO Bit SET and Bit RESET enumeration 
  */ 
typedef enum
{ 
  Bit_RESET = 0,
  Bit_SET
}BitAction;
#define IS_GPIO_BIT_ACTION(ACTION) (((ACTION) == Bit_RESET) || ((ACTION) == Bit_SET))


/** 
  * @brief   GPIO Init structure definition  
  */ 
typedef struct
{
  uint32_t GPIO_Pin;              /*!< Specifies the GPIO pins to be configured.
                                       This parameter can be any value of @ref GPIO_pins_define */

  GPIOMode_TypeDef GPIO_Mode;     /*!< Specifies the operating mode for the selected pins.
                                       This parameter can be a value of @ref GPIOMode_TypeDef */

  GPIOSpeed_TypeDef GPIO_Speed;   /*!< Specifies the speed for the selected pins.
                                       This parameter can be a value of @ref GPIOSpeed_TypeDef */

  GPIOOType_TypeDef GPIO_OType;   /*!< Specifies the operating output type for the selected pins.
                                       This parameter can be a value of @ref GPIOOType_TypeDef */

  GPIOPuPd_TypeDef GPIO_PuPd;     /*!< Specifies the operating Pull-up/Pull down for the selected pins.
                                       This parameter can be a value of @ref GPIOPuPd_TypeDef */
}GPIO_InitTypeDef;

/* Exported constants --------------------------------------------------------*/

/** @defgroup GPIO_Exported_Constants
  * @{
  */ 

/** @defgroup GPIO_pins_define 
  * @{
  */ 
#define GPIO_Pin_0                 ((uint16_t)0x0001)  /* Pin 0 selected */
#define GPIO_Pin_1                 ((uint16_t)0x0002)  /* Pin 1 selected */
#define GPIO_Pin_2                 ((uint16_t)0x0004)  /* Pin 2 selected */
#define GPIO_Pin_3                 ((uint16_t)0x0008)  /* Pin 3 selected */
#define GPIO_Pin_4                 ((uint16_t)0x0010)  /* Pin 4 selected */
#define GPIO_Pin_5                 ((uint16_t)0x0020)  /* Pin 5 selected */
#define GPIO_Pin_6                 ((uint16_t)0x0040)  /* Pin 6 selected */
#define GPIO_Pin_7                 ((uint16_t)0x0080)  /* Pin 7 selected */
#define GPIO_Pin_8                 ((uint16_t)0x0100)  /* Pin 8 selected */
#define GPIO_Pin_9                 ((uint16_t)0x0200)  /* Pin 9 selected */
#define GPIO_Pin_10                ((uint16_t)0x0400)  /* Pin 10 selected */
#define GPIO_Pin_11                ((uint16_t)0x0800)  /* Pin 11 selected */
#define GPIO_Pin_12                ((uint16_t)0x1000)  /* Pin 12 selected */
#define GPIO_Pin_13                ((uint16_t)0x2000)  /* Pin 13 selected */
#define GPIO_Pin_14                ((uint16_t)0x4000)  /* Pin 14 selected */
#define GPIO_Pin_15                ((uint16_t)0x8000)  /* Pin 15 selected */
#define GPIO_Pin_All               ((uint16_t)0xFFFF)  /* All pins selected */

#define IS_GPIO_PIN(PIN) ((((PIN) & (uint16_t)0x00) == 0x00) && ((PIN) != (uint16_t)0x00))
#define IS_GET_GPIO_PIN(PIN) (((PIN) == GPIO_Pin_0) || \
                              ((PIN) == GPIO_Pin_1) || \
                              ((PIN) == GPIO_Pin_2) || \
                              ((PIN) == GPIO_Pin_3) || \
                              ((PIN) == GPIO_Pin_4) || \
                              ((PIN) == GPIO_Pin_5) || \
                              ((PIN) == GPIO_Pin_6) || \
                              ((PIN) == GPIO_Pin_7) || \
                              ((PIN) == GPIO_Pin_8) || \
                              ((PIN) == GPIO_Pin_9) || \
                              ((PIN) == GPIO_Pin_10) || \
                              ((PIN) == GPIO_Pin_11) || \
                              ((PIN) == GPIO_Pin_12) || \
                              ((PIN) == GPIO_Pin_13) || \
                              ((PIN) == GPIO_Pin_14) || \
                              ((PIN) == GPIO_Pin_15))
/**
  * @}
  */ 


/** @defgroup GPIO_Pin_sources 
  * @{
  */ 
#define GPIO_PinSource0            ((uint8_t)0x00)
#define GPIO_PinSource1            ((uint8_t)0x01)
#define GPIO_PinSource2            ((uint8_t)0x02)
#define GPIO_PinSource3            ((uint8_t)0x03)
#define GPIO_PinSource4            ((uint8_t)0x04)
#define GPIO_PinSource5            ((uint8_t)0x05)
#define GPIO_PinSource6            ((uint8_t)0x06)
#define GPIO_PinSource7            ((uint8_t)0x07)
#define GPIO_PinSource8            ((uint8_t)0x08)
#define GPIO_PinSource9            ((uint8_t)0x09)
#define GPIO_PinSource10           ((uint8_t)0x0A)
#define GPIO_PinSource11           ((uint8_t)0x0B)
#define GPIO_PinSource12           ((uint8_t)0x0C)
#define GPIO_PinSource13           ((uint8_t)0x0D)
#define GPIO_PinSource14           ((uint8_t)0x0E)
#define GPIO_PinSource15           ((uint8_t)0x0F)

#define IS_GPIO_PIN_SOURCE(PINSOURCE) (((PINSOURCE) == GPIO_PinSource0) || \
                                       ((PINSOURCE) == GPIO_PinSource1) || \
                                       ((PINSOURCE) == GPIO_PinSource2) || \
                                       ((PINSOURCE) == GPIO_PinSource3) || \
                                       ((PINSOURCE) == GPIO_PinSource4) || \
                                       ((PINSOURCE) == GPIO_PinSource5) || \
                                       ((PINSOURCE) == GPIO_PinSource6) || \
                                       ((PINSOURCE) == GPIO_PinSource7) || \
                                       ((PINSOURCE) == GPIO_PinSource8) || \
                                       ((PINSOURCE) == GPIO_PinSource9) || \
                                       ((PINSOURCE) == GPIO_PinSource10) || \
                                       ((PINSOURCE) == GPIO_PinSource11) || \
                                       ((PINSOURCE) == GPIO_PinSource12) || \
                                       ((PINSOURCE) == GPIO_PinSource13) || \
                                       ((PINSOURCE) == GPIO_PinSource14) || \
                                       ((PINSOURCE) == GPIO_PinSource15))
/**
  * @}
  */ 

/** @defgroup GPIO_Alternat_function_selection_define 
  * @{
  */ 
/******************************************************************************* 
  * @brief   AF 0 selection  
  *****************************************************************************/
#define GPIO_AF_RTC_50Hz      ((uint8_t)0x00)  /* RTC_50Hz Alternate Function mapping */
#define GPIO_AF_MCO           ((uint8_t)0x00)  /* MCO (MCO1 and MCO2) Alternate Function mapping */
#define GPIO_AF_TAMPER        ((uint8_t)0x00)  /* TAMPER (TAMPER_1 and TAMPER_2) Alternate Function mapping */
#define GPIO_AF_SWJ           ((uint8_t)0x00)  /* SWJ (SWD and JTAG) Alternate Function mapping */
#define GPIO_AF_TRACE         ((uint8_t)0x00)  /* TRACE Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 1 selection  
  *****************************************************************************/ 
#define GPIO_AF_TIM1          ((uint8_t)0x01)  /* TIM1 Alternate Function mapping */
#define GPIO_AF_TIM2          ((uint8_t)0x01)  /* TIM2 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 2 selection  
  *****************************************************************************/ 
#define GPIO_AF_TIM3          ((uint8_t)0x02)  /* TIM3 Alternate Function mapping */
#define GPIO_AF_TIM4          ((uint8_t)0x02)  /* TIM4 Alternate Function mapping */
#define GPIO_AF_TIM5          ((uint8_t)0x02)  /* TIM5 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 3 selection  
  *****************************************************************************/ 
#define GPIO_AF_TIM8          ((uint8_t)0x03)  /* TIM8 Alternate Function mapping */
#define GPIO_AF_TIM9          ((uint8_t)0x03)  /* TIM9 Alternate Function mapping */
#define GPIO_AF_TIM10         ((uint8_t)0x03)  /* TIM10 Alternate Function mapping */
#define GPIO_AF_TIM11         ((uint8_t)0x03)  /* TIM11 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 4 selection  
  *****************************************************************************/ 
#define GPIO_AF_I2C1          ((uint8_t)0x04)  /* I2C1 Alternate Function mapping */
#define GPIO_AF_I2C2          ((uint8_t)0x04)  /* I2C2 Alternate Function mapping */
#define GPIO_AF_I2C3          ((uint8_t)0x04)  /* I2C3 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 5 selection  
  *****************************************************************************/ 
#define GPIO_AF_SPI1          ((uint8_t)0x05)  /* SPI1 Alternate Function mapping */
#define GPIO_AF_SPI2          ((uint8_t)0x05)  /* SPI2/I2S2 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 6 selection  
  *****************************************************************************/ 
#define GPIO_AF_SPI3          ((uint8_t)0x06)  /* SPI3/I2S3 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 7 selection  
  *****************************************************************************/ 
#define GPIO_AF_USART1        ((uint8_t)0x07)  /* USART1 Alternate Function mapping */
#define GPIO_AF_USART2        ((uint8_t)0x07)  /* USART2 Alternate Function mapping */
#define GPIO_AF_USART3        ((uint8_t)0x07)  /* USART3 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 8 selection  
  *****************************************************************************/ 
#define GPIO_AF_UART4         ((uint8_t)0x08)  /* UART4 Alternate Function mapping */
#define GPIO_AF_UART5         ((uint8_t)0x08)  /* UART5 Alternate Function mapping */
#define GPIO_AF_USART6        ((uint8_t)0x08)  /* USART6 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 9 selection 
  *****************************************************************************/ 
#define GPIO_AF_CAN1          ((uint8_t)0x09)  /* CAN1 Alternate Function mapping */
#define GPIO_AF_CAN2          ((uint8_t)0x09)  /* CAN2 Alternate Function mapping */
#define GPIO_AF_TIM12         ((uint8_t)0x09)  /* TIM12 Alternate Function mapping */
#define GPIO_AF_TIM13         ((uint8_t)0x09)  /* TIM13 Alternate Function mapping */
#define GPIO_AF_TIM14         ((uint8_t)0x09)  /* TIM14 Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 10 selection  
  *****************************************************************************/ 
#define GPIO_AF_OTG_FS         ((uint8_t)0xA)  /* OTG_FS Alternate Function mapping */
#define GPIO_AF_OTG_HS         ((uint8_t)0xA)  /* OTG_HS Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 11 selection  
  *****************************************************************************/ 
#define GPIO_AF_ETH             ((uint8_t)0x0B)  /* ETHERNET Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 12 selection  
  *****************************************************************************/ 
#define GPIO_AF_FSMC            ((uint8_t)0xC)  /* FSMC Alternate Function mapping */
#define GPIO_AF_OTG_HS_FS       ((uint8_t)0xC)  /* OTG HS configured in FS, Alternate Function mapping */
#define GPIO_AF_SDIO            ((uint8_t)0xC)  /* SDIO Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 13 selection  
  *****************************************************************************/ 
#define GPIO_AF_DCMI          ((uint8_t)0x0D)  /* DCMI Alternate Function mapping */

/******************************************************************************* 
  * @brief   AF 15 selection  
  *****************************************************************************/ 
#define GPIO_AF_EVENTOUT      ((uint8_t)0x0F)  /* EVENTOUT Alternate Function mapping */

#define IS_GPIO_AF(AF)   (((AF) == GPIO_AF_RTC_50Hz)  || ((AF) == GPIO_AF_TIM14)  || \
                          ((AF) == GPIO_AF_MCO)       || ((AF) == GPIO_AF_TAMPER) || \
                          ((AF) == GPIO_AF_SWJ)       || ((AF) == GPIO_AF_TRACE)  || \
                          ((AF) == GPIO_AF_TIM1)      || ((AF) == GPIO_AF_TIM2)   || \
                          ((AF) == GPIO_AF_TIM3)      || ((AF) == GPIO_AF_TIM4)   || \
                          ((AF) == GPIO_AF_TIM5)      || ((AF) == GPIO_AF_TIM8)   || \
                          ((AF) == GPIO_AF_I2C1)      || ((AF) == GPIO_AF_I2C2)   || \
                          ((AF) == GPIO_AF_I2C3)      || ((AF) == GPIO_AF_SPI1)   || \
                          ((AF) == GPIO_AF_SPI2)      || ((AF) == GPIO_AF_TIM13)  || \
                          ((AF) == GPIO_AF_SPI3)      || ((AF) == GPIO_AF_TIM14)  || \
                          ((AF) == GPIO_AF_USART1)    || ((AF) == GPIO_AF_USART2) || \
                          ((AF) == GPIO_AF_USART3)    || ((AF) == GPIO_AF_UART4)  || \
                          ((AF) == GPIO_AF_UART5)     || ((AF) == GPIO_AF_USART6) || \
                          ((AF) == GPIO_AF_CAN1)      || ((AF) == GPIO_AF_CAN2)   || \
                          ((AF) == GPIO_AF_OTG_FS)    || ((AF) == GPIO_AF_OTG_HS) || \
                          ((AF) == GPIO_AF_ETH)       || ((AF) == GPIO_AF_FSMC)   || \
                          ((AF) == GPIO_AF_OTG_HS_FS) || ((AF) == GPIO_AF_SDIO)   || \
                          ((AF) == GPIO_AF_DCMI)      || ((AF) == GPIO_AF_EVENTOUT))
/**
  * @}
  */

/******************************************************************************* 
  * @brief   GPIO Information  
  *****************************************************************************/ 
  
#define __GPIO_2MHz 		(GPIO_Speed_2MHz << 4)
#define __GPIO_25MHz		(GPIO_Speed_25MHz << 4)
#define __GPIO_50MHz		(GPIO_Speed_50MHz << 4)
#define __GPIO_100MHz		(GPIO_Speed_100MHz << 4)


#define __MODEOUT		((GPIO_Mode_OUT << 0) | __GPIO_50MHz)
	#define __PP			(GPIO_OType_PP << 2)
	#define __OD			(GPIO_OType_OD << 2)


	#define __PU			(GPIO_PuPd_UP	<< 6)
	#define __PD			(GPIO_PuPd_DOWN << 6)
	

#define __MODEIN		(GPIO_Mode_IN << 0)
#define __MODEAF		((GPIO_Mode_AF << 0) | __GPIO_50MHz)
#define __MODEAN		(GPIO_Mode_AN << 0)

/////////////////////////////////////////////////////////////////////////////////
#define __GP_PP_PP		(__MODEOUT | __PP)
#define __GP_PP_PU		(__MODEOUT | __PP | __PU)
#define __GP_PP_PD		(__MODEOUT | __PP | __PD)

#define __GP_OD_OD		(__MODEOUT | __OD)
#define __GP_OD_PU		(__MODEOUT | __OD | __PU)
#define __GP_OD_PD		(__MODEOUT | __OD | __PD)

#define __GP_AP_PP		(__MODEAF | __PP)
#define __GP_AP_PU		(__MODEAF | __PP | __PU)
#define __GP_AP_PD		(__MODEAF | __PP | __PD)

#define __GP_AD_OD		(__MODEAF | __OD)
#define __GP_AD_PU		(__MODEAF | __OD | __PU)
#define __GP_AD_PD		(__MODEAF | __OD | __PD)

#define __GP_IN_FL		(__MODEIN)
#define __GP_IN_PU		(__MODEIN | __PU)
#define __GP_IN_PD		(__MODEIN | __PD)

#define __GP_AIN		(__MODEAN)


/////////////////////////////////////////////////////////////////////////////////
// Port A

#define __PA0_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource0)
#define __PA0_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource0)
#define __PA0_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource0)
#define __PA0_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource0)
#define __ADC_IN0()			GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource0)

#define __PA1_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource1)
#define __PA1_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource1)
#define __PA1_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource1)
#define __PA1_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource1)
#define __ADC_IN1()			GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource1)

#define __PA2_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource2)
#define __PA2_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource2)
#define __PA2_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource2)
#define __PA2_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource2)
#define __ADC_IN2()			GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource2)
#define __PA2_U2_TX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART2,GPIOA, GPIO_PinSource2)

#define __PA3_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource3)
#define __PA3_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource3)
#define __PA3_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource3)
#define __PA3_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource3)
#define __ADC_IN3()			GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource3)
#define __PA3_U2_RX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART2,GPIOA, GPIO_PinSource3)

#define __PA4_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource4)
#define __PA4_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource4)
#define __PA4_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource4)
#define __PA4_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource4)
#define __ADC_IN4() 		GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource4)
//#define __PA4_SPI_SCK()		GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI1, 	GPIOA, GPIO_PinSource4)

#define __PA5_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource5)
#define __PA5_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource5)
#define __PA5_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource5)
#define __PA5_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource5)
#define __ADC_IN5() 		GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource5)
#define __PA5_SPI_SCK()		GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI1, 	GPIOA, GPIO_PinSource5)

#define __PA6_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource6)
#define __PA6_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource6)
#define __PA6_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource6)
#define __PA6_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource6)
#define __ADC_IN6() 		GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource6)
#define __PA6_SPI_MISO()	GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI1, 	GPIOA, GPIO_PinSource6)

#define __PA7_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource7)
#define __PA7_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource7)
#define __PA7_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource7)
#define __PA7_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource7)
#define __ADC_IN7() 		GPIOPortInit(__GP_AIN,	 0, 			GPIOA, GPIO_PinSource7)
#define __PA7_SPI_MOSI()	GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI1, 	GPIOA, GPIO_PinSource7)///AXXXX



#define __PA8_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource8)
#define __PA8_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource8)
#define __PA8_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource8)
#define __PA8_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOA, GPIO_PinSource8)



#define __PA9_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource9)
#define __PA9_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource9)
#define __PA9_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOA, GPIO_PinSource9)

#define __PA9_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource9)
#define __PA9_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOA, GPIO_PinSource9)
#define __PA9_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOA, GPIO_PinSource9)

#define __PA9_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOA, GPIO_PinSource9)
#define __PA9_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOA, GPIO_PinSource9)
#define __PA9_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOA, GPIO_PinSource9)

#define __PA9_T1_CH2()		GPIOPortInit(__GP_AD_OD, GPIO_AF_TIM1, 	GPIOA, GPIO_PinSource9)
#define __PA9_I2C3_SMBA()	GPIOPortInit(__GP_AD_OD, GPIO_AF_I2C3, 	GPIOA, GPIO_PinSource9)
#define __PA9_U1_TX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART1,GPIOA, GPIO_PinSource9)
#define __PA9_DCMI_D0()		GPIOPortInit(__GP_AD_OD, GPIO_AF_DCMI,	GPIOA, GPIO_PinSource9)
/////////////////////////////
#define __PA10_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource10)
#define __PA10_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource10)
#define __PA10_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOA, GPIO_PinSource10)

#define __PA10_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource10)
#define __PA10_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOA, GPIO_PinSource10)
#define __PA10_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOA, GPIO_PinSource10)

#define __PA10_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOA, GPIO_PinSource10)
#define __PA10_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOA, GPIO_PinSource10)
#define __PA10_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOA, GPIO_PinSource10)

#define __PA10_T1_CH3()		GPIOPortInit(__GP_AD_OD, GPIO_AF_TIM1, 	GPIOA, GPIO_PinSource10)
#define __PA10_U1_RX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART1,GPIOA, GPIO_PinSource10)
#define __PA9_DCMI_D1()		GPIOPortInit(__GP_AD_OD, GPIO_AF_DCMI,	GPIOA, GPIO_PinSource10)

/////////////////////////////
#define __PA11_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource11)
#define __PA11_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource11)
#define __PA11_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOA, GPIO_PinSource11)

#define __PA11_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource11)
#define __PA11_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOA, GPIO_PinSource11)
#define __PA11_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOA, GPIO_PinSource11)

#define __PA11_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOA, GPIO_PinSource11)
#define __PA11_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOA, GPIO_PinSource11)
#define __PA11_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOA, GPIO_PinSource11)

/////////////////////////////
#define __PA12_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource12)
#define __PA12_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource12)
#define __PA12_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOA, GPIO_PinSource12)

#define __PA12_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource12)
#define __PA12_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOA, GPIO_PinSource12)
#define __PA12_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOA, GPIO_PinSource12)

#define __PA12_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOA, GPIO_PinSource12)
#define __PA12_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOA, GPIO_PinSource12)
#define __PA12_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOA, GPIO_PinSource12)

/////////////////////////////
#define __PA13_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource13)
#define __PA13_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource13)
#define __PA13_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOA, GPIO_PinSource13)

#define __PA13_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource13)
#define __PA13_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOA, GPIO_PinSource13)
#define __PA13_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOA, GPIO_PinSource13)

#define __PA13_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOA, GPIO_PinSource13)
#define __PA13_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOA, GPIO_PinSource13)
#define __PA13_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOA, GPIO_PinSource13)

/////////////////////////////
#define __PA14_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource14)
#define __PA14_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource14)
#define __PA14_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOA, GPIO_PinSource14)

#define __PA14_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource14)
#define __PA14_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOA, GPIO_PinSource14)
#define __PA14_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOA, GPIO_PinSource14)

#define __PA14_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOA, GPIO_PinSource14)
#define __PA14_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOA, GPIO_PinSource14)
#define __PA14_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOA, GPIO_PinSource14)

/////////////////////////////
#define __PA15_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOA, GPIO_PinSource15)
#define __PA15_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOA, GPIO_PinSource15)
#define __PA15_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOA, GPIO_PinSource15)

#define __PA15_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource15)
#define __PA15_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOA, GPIO_PinSource15)
#define __PA15_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOA, GPIO_PinSource15)

#define __PA15_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOA, GPIO_PinSource15)
#define __PA15_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOA, GPIO_PinSource15)
#define __PA15_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOA, GPIO_PinSource15)

#define __PA15_NSS()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOA, GPIO_PinSource15)


/////////////////////////////////////////////////////////////////////////////////
// Port B

/////////////////////////////
#define __PB0_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource0)
#define __PB0_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource0)
#define __PB0_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource0)
#define __PB0_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource0)
#define __ADC_IN8()			GPIOPortInit(__GP_AIN,	 0, 			GPIOB, GPIO_PinSource0)

/////////////////////////////
#define __PB1_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource1)
#define __PB1_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource1)
#define __PB1_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource1)
#define __PB1_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource1)
#define __ADC_IN9() 		GPIOPortInit(__GP_AIN,	 0, 			GPIOB, GPIO_PinSource1)

/////////////////////////////
#define __PB2_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource2)
#define __PB2_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource2)
#define __PB2_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource2)

#define __PB2_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource2)
#define __PB2_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource2)
#define __PB2_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource2)

#define __PB2_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource2)
#define __PB2_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource2)
#define __PB2_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource2)

/////////////////////////////
#define __PB3_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource3)
#define __PB3_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource3)
#define __PB3_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource3)

#define __PB3_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource3)
#define __PB3_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource3)
#define __PB3_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource3)

#define __PB3_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource3)
#define __PB3_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource3)
#define __PB3_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource3)

#define __PB3_SPI_SCK()		GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI1, 	GPIOB, GPIO_PinSource3)


/////////////////////////////
#define __PB4_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource4)
#define __PB4_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource4)
#define __PB4_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource4)

#define __PB4_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource4)
#define __PB4_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource4)
#define __PB4_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource4)

#define __PB4_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource4)
#define __PB4_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource4)
#define __PB4_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource4)

#define __PB4_SPI_MISO()	GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI1, 	GPIOB, GPIO_PinSource4)


/////////////////////////////
#define __PB5_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource5)
#define __PB5_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource5)
#define __PB5_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource5)

#define __PB5_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource5)
#define __PB5_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource5)
#define __PB5_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource5)

#define __PB5_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource5)
#define __PB5_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource5)
#define __PB5_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource5)

#define __PB5_SPI_MOSI()	GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI1, 	GPIOB, GPIO_PinSource5)


/////////////////////////////
#define __PB6_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource6)
#define __PB6_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource6)
#define __PB6_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource6)

#define __PB6_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource6)
#define __PB6_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource6)
#define __PB6_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource6)

#define __PB6_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource6)
#define __PB6_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource6)
#define __PB6_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource6)

#define __PB6_I2C1_SCL()	GPIOPortInit(__GP_AD_OD, GPIO_AF_I2C1, 	GPIOB, GPIO_PinSource6)

/////////////////////////////
#define __PB7_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource7)
#define __PB7_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource7)
#define __PB7_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource7)

#define __PB7_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource7)
#define __PB7_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource7)
#define __PB7_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource7)

#define __PB7_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource7)
#define __PB7_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource7)
#define __PB7_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource7)

/////////////////////////////
#define __PB8_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource8)
#define __PB8_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource8)
#define __PB8_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource8)

#define __PB8_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource8)
#define __PB8_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource8)
#define __PB8_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource8)

#define __PB8_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource8)
#define __PB8_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource8)
#define __PB8_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource8)


/////////////////////////////
#define __PB9_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource9)
#define __PB9_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource9)
#define __PB9_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource9)

#define __PB9_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource9)
#define __PB9_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOB, GPIO_PinSource9)
#define __PB9_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOB, GPIO_PinSource9)

#define __PB9_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOB, GPIO_PinSource9)
#define __PB9_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOB, GPIO_PinSource9)
#define __PB9_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOB, GPIO_PinSource9)


/////////////////////////////
#define __PB10_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource10)
#define __PB10_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource10)
#define __PB10_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource10)
#define __PB10_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource10)
#define __PB10_U3_TX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART3,GPIOB, GPIO_PinSource10)

/////////////////////////////
#define __PB11_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource11)
#define __PB11_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource11)
#define __PB11_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource11)
#define __PB11_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource11)
#define __PB11_U3_RX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART3,GPIOB, GPIO_PinSource11)

/////////////////////////////
#define __PB12_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource12)
#define __PB12_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource12)
#define __PB12_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource12)
#define __PB12_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource12)

/////////////////////////////
#define __PB13_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource13)
#define __PB13_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource13)
#define __PB13_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource13)
#define __PB13_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource13)
#define __PB13_SPI_SCK()	GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI2, 	GPIOB, GPIO_PinSource13)

/////////////////////////////
#define __PB14_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource14)
#define __PB14_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource14)
#define __PB14_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource14)
#define __PB14_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource14)

/////////////////////////////
#define __PB15_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOB, GPIO_PinSource15)
#define __PB15_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOB, GPIO_PinSource15)
#define __PB15_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOB, GPIO_PinSource15)
#define __PB15_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOB, GPIO_PinSource15)


/////////////////////////////////////////////////////////////////////////////////
// Port C

/////////////////////////////
#define __PC0_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource0)
#define __PC0_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource0)
#define __PC0_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource0)
#define __PC0_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource0)
#define __ADC_IN10()		GPIOPortInit(__GP_AIN, 	 0, 			GPIOC, GPIO_PinSource0)

/////////////////////////////
#define __PC1_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource1)
#define __PC1_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource1)
#define __PC1_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource1)
#define __PC1_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource1)
#define __ADC_IN11()		GPIOPortInit(__GP_AIN,	 0, 			GPIOC, GPIO_PinSource1)

/////////////////////////////
#define __PC2_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource2)
#define __PC2_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource2)
#define __PC2_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource2)
#define __PC2_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource2)
#define __ADC_IN12()		GPIOPortInit(__GP_AIN,	 0, 			GPIOC, GPIO_PinSource2)
#define __PC2_SPI_MISO()	GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI2, 	GPIOC, GPIO_PinSource2)

/////////////////////////////
#define __PC3_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource3)
#define __PC3_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource3)
#define __PC3_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource3)
#define __PC3_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource3)
#define __ADC_IN13()		GPIOPortInit(__GP_AIN,	 0, 			GPIOC, GPIO_PinSource3)
#define __PC3_SPI_MOSI()	GPIOPortInit(__GP_AP_PP, GPIO_AF_SPI2, 	GPIOC, GPIO_PinSource3)

/////////////////////////////
#define __PC4_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource4)
#define __PC4_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource4)
#define __PC4_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource4)
#define __PC4_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource4)
#define __ADC_IN14() 		GPIOPortInit(__GP_AIN,	 0, 			GPIOC, GPIO_PinSource4)

/////////////////////////////
#define __PC5_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource5)
#define __PC5_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource5)
#define __PC5_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource5)
#define __PC5_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource5)
#define __ADC_IN15()		GPIOPortInit(__GP_AIN,	 0, 			GPIOC, GPIO_PinSource5)


/////////////////////////////
#define __PC6_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource6)
#define __PC6_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource6)
#define __PC6_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource6)
#define __PC6_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource6)
#define __PC6_U6_TX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART6,GPIOC, GPIO_PinSource6)

/////////////////////////////
#define __PC7_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource7)
#define __PC7_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource7)
#define __PC7_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource7)
#define __PC7_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource7)
#define __PC7_U6_RX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_USART6,GPIOC, GPIO_PinSource7)


/////////////////////////////
#define __PC8_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource8)
#define __PC8_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource8)
#define __PC8_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource8)
#define __PC8_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource8)

/////////////////////////////
#define __PC9_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource9)
#define __PC9_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource9)
#define __PC9_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource9)
#define __PC9_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOC, GPIO_PinSource9)
#define __PC9_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOB, GPIO_PinSource9)

/////////////////////////////
#define __PC10_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource10)
#define __PC10_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource10)
#define __PC10_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOC, GPIO_PinSource10)

#define __PC10_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource10)
#define __PC10_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOC, GPIO_PinSource10)
#define __PC10_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOC, GPIO_PinSource10)

#define __PC10_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOC, GPIO_PinSource10)
#define __PC10_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOC, GPIO_PinSource10)
#define __PC10_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOC, GPIO_PinSource10)

#define __PC10_U4_TX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_UART4,GPIOC, GPIO_PinSource10)

/////////////////////////////
#define __PC11_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource11)
#define __PC11_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource11)
#define __PC11_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOC, GPIO_PinSource11)

#define __PC11_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource11)
#define __PC11_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOC, GPIO_PinSource11)
#define __PC11_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOC, GPIO_PinSource11)

#define __PC11_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOC, GPIO_PinSource11)
#define __PC11_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOC, GPIO_PinSource11)
#define __PC11_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOC, GPIO_PinSource11)

#define __PC11_U4_RX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_UART4,GPIOC, GPIO_PinSource11)

/////////////////////////////
#define __PC12_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource12)
#define __PC12_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource12)
#define __PC12_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOC, GPIO_PinSource12)

#define __PC12_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource12)
#define __PC12_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOC, GPIO_PinSource12)
#define __PC12_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOC, GPIO_PinSource12)

#define __PC12_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOC, GPIO_PinSource12)
#define __PC12_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOC, GPIO_PinSource12)
#define __PC12_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOC, GPIO_PinSource12)

#define __PC12_U5_TX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_UART5, GPIOC, GPIO_PinSource12)


/////////////////////////////
#define __PC13_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource13)
#define __PC13_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource13)
#define __PC13_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOC, GPIO_PinSource13)

#define __PC13_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource13)
#define __PC13_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOC, GPIO_PinSource13)
#define __PC13_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOC, GPIO_PinSource13)

#define __PC13_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOC, GPIO_PinSource13)
#define __PC13_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOC, GPIO_PinSource13)
#define __PC13_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOC, GPIO_PinSource13)


#define __PC14_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource14)
#define __PC14_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource14)
#define __PC14_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOC, GPIO_PinSource14)

#define __PC14_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource14)
#define __PC14_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOC, GPIO_PinSource14)
#define __PC14_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOC, GPIO_PinSource14)


#define __PC14_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOC, GPIO_PinSource14)
#define __PC14_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOC, GPIO_PinSource14)
#define __PC14_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOC, GPIO_PinSource14)


#define __PC15_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOC, GPIO_PinSource15)
#define __PC15_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOC, GPIO_PinSource15)
#define __PC15_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOC, GPIO_PinSource15)

#define __PC15_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOC, GPIO_PinSource15)
#define __PC15_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOC, GPIO_PinSource15)
#define __PC15_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOC, GPIO_PinSource15)


#define __PC15_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOC, GPIO_PinSource15)
#define __PC15_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOC, GPIO_PinSource15)
#define __PC15_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOC, GPIO_PinSource15)


/////////////////////////////////////////////////////////////////////////////////
// Port D

/////////////////////////////
#define __PD0_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource0)
#define __PD0_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource0)
#define __PD0_FSMC_D2()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource0)

/////////////////////////////
#define __PD1_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource1)
#define __PD1_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource1)
#define __PD1_FSMC_D3()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource1)

/////////////////////////////
#define __PD2_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource2)
#define __PD2_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource2)
#define __PD2_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOD, GPIO_PinSource2)

#define __PD2_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource2)
#define __PD2_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOD, GPIO_PinSource2)
#define __PD2_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOD, GPIO_PinSource2)

#define __PD2_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOD, GPIO_PinSource2)
#define __PD2_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOD, GPIO_PinSource2)
#define __PD2_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOD, GPIO_PinSource2)

#define __PD2_U5_RX()		GPIOPortInit(__GP_AP_PU, GPIO_AF_UART5,GPIOD, GPIO_PinSource2)

/////////////////////////////
#define __PD3_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource3)
#define __PD3_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource3)
#define __PD3_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOD, GPIO_PinSource3)

#define __PD3_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource3)
#define __PD3_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOD, GPIO_PinSource3)
#define __PD3_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOD, GPIO_PinSource3)

#define __PD3_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOD, GPIO_PinSource3)
#define __PD3_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOD, GPIO_PinSource3)
#define __PD3_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOD, GPIO_PinSource3)

/////////////////////////////
#define __PD4_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource4)
#define __PD4_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource4)
#define __PD4_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource4)
#define __PD4_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource4)
#define __PD4_FSMC_nOE()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource4)

/////////////////////////////
#define __PD5_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource5)
#define __PD5_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource5)
#define __PD5_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource5)
#define __PD5_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource5)
#define __PD5_FSMC_nWE()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource5)

/////////////////////////////
#define __PD6_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource6)
#define __PD6_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource6)
#define __PD6_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource6)
#define __PD6_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource6)

#define __PD6_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOD, GPIO_PinSource6)
#define __PD6_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOD, GPIO_PinSource6)
#define __PD6_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOD, GPIO_PinSource6)

#define __PD7_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource7)
#define __PD7_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource7)
#define __PD7_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource7)
#define __PD7_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource7)

#define __PD7_FSMC_NE1()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource7)

/////////////////////////////
#define __PD8_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource8)
#define __PD8_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource8)
#define __PD8_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource8)
#define __PD8_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource8)
#define __PD8_FSMC_D13()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource8)

/////////////////////////////
#define __PD9_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource9)
#define __PD9_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource9)
#define __PD9_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource9)
#define __PD9_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource9)
#define __PD9_FSMC_D14()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource9)

/////////////////////////////
#define __PD10_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource10)
#define __PD10_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource10)
#define __PD10_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource10)
#define __PD10_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource10)

#define __PD10_FSMC_D15()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource10)

/////////////////////////////
#define __PD11_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource11)
#define __PD11_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource11)
#define __PD11_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource11)
#define __PD11_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource11)

#define __PD11_FSMC_A16()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource11)

/////////////////////////////
#define __PD12_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource12)
#define __PD12_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource12)
#define __PD12_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource12)
#define __PD12_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource12)

#define __PD12_FSMC_A17()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource12)

/////////////////////////////
#define __PD13_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource13)
#define __PD13_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource13)
#define __PD13_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource13)
#define __PD13_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource13)

#define __PD13_FSMC_A18()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource13)

/////////////////////////////
#define __PD14_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource14)
#define __PD14_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource14)
#define __PD14_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource14)
#define __PD14_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource14)

#define __PD14_FSMC_D0()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource14)

/////////////////////////////
#define __PD15_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOD, GPIO_PinSource15)
#define __PD15_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOD, GPIO_PinSource15)
#define __PD15_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOD, GPIO_PinSource15)
#define __PD15_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOD, GPIO_PinSource15)
#define __PD15_FSMC_D1()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOD, GPIO_PinSource15)


/////////////////////////////////////////////////////////////////////////////////
// Port E

/////////////////////////////
#define __PE0_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource0)
#define __PE0_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource0)
#define __PE0_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOE, GPIO_PinSource0)

#define __PE0_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource0)
#define __PE0_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOE, GPIO_PinSource0)
#define __PE0_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOE, GPIO_PinSource0)

#define __PE0_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOE, GPIO_PinSource0)
#define __PE0_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOE, GPIO_PinSource0)
#define __PE0_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOE, GPIO_PinSource0)

/////////////////////////////
#define __PE1_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource1)
#define __PE1_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource1)
#define __PE1_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOE, GPIO_PinSource1)

#define __PE1_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource1)
#define __PE1_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOE, GPIO_PinSource1)
#define __PE1_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOE, GPIO_PinSource1)

#define __PE1_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOE, GPIO_PinSource1)
#define __PE1_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOE, GPIO_PinSource1)
#define __PE1_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOE, GPIO_PinSource1)


/////////////////////////////
#define __PE2_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource2)
#define __PE2_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource2)
#define __PE2_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource2)
#define __PE2_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource2)

#define __PE2_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOE, GPIO_PinSource2)
#define __PE2_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOE, GPIO_PinSource2)
#define __PE2_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOE, GPIO_PinSource2)


/////////////////////////////
#define __PE3_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource3)
#define __PE3_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource3)
#define __PE3_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource3)
#define __PE3_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource3)
///20140619 Adder
#define __PE3_FSMC_A19()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource3)

/////////////////////////////
#define __PE4_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource4)
#define __PE4_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource4)
#define __PE4_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource4)
#define __PE4_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource4)
///20140619 Adder
#define __PE4_FSMC_A20()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource4)

/////////////////////////////
#define __PE5_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource5)
#define __PE5_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource5)
#define __PE5_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource5)
#define __PE5_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource5)
///20140619 Adder
#define __PE5_FSMC_A21()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource5)

/////////////////////////////
#define __PE6_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource6)
#define __PE6_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource6)
#define __PE6_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource6)
#define __PE6_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource6)

/////////////////////////////
#define __PE7_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource7)
#define __PE7_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource7)
#define __PE7_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource7)
#define __PE7_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource7)
#define __PE7_FSMC_D4()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource7)

/////////////////////////////
#define __PE8_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource8)
#define __PE8_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource8)
#define __PE8_FSMC_D5()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource8)

/////////////////////////////
#define __PE9_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource9)
#define __PE9_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource9)
#define __PE9_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource9)
#define __PE9_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource9)
#define __PE9_FSMC_D6()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource9)

/////////////////////////////
#define __PE10_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource10)
#define __PE10_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource10)
#define __PE10_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource10)
#define __PE10_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource10)
#define __PE10_FSMC_D7()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource10)

/////////////////////////////
#define __PE11_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource11)
#define __PE11_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource11)
#define __PE11_IU_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource11)

#define __PE11_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOE, GPIO_PinSource11)
#define __PE11_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource11)

#define __PE11_FSMC_D8()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource11)

/////////////////////////////
#define __PE12_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource12)
#define __PE12_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource12)
#define __PE12_IU_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource12)

#define __PE12_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOE, GPIO_PinSource12)
#define __PE12_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource12)

#define __PE12_FSMC_D9()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource12)

/////////////////////////////
#define __PE13_FSMC_D10()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource13)
#define __PE13_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource13)

/////////////////////////////
#define __PE14_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource14)
#define __PE14_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource14)
#define __PE14_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource14)
#define __PE14_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource14)
#define __PE14_FSMC_D11()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource14)

/////////////////////////////
#define __PE15_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOE, GPIO_PinSource15)
#define __PE15_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOE, GPIO_PinSource15)
#define __PE15_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOE, GPIO_PinSource15)
#define __PE15_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOE, GPIO_PinSource15)
#define __PE15_FSMC_D12()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOE, GPIO_PinSource15)


/////////////////////////////////////////////////////////////////////////////////
// Port F
#define __PF0_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource0)
#define __PF0_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource0)
#define __PF0_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource0)
#define __PF0_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource0)

#define __PF0_FSMC_A0()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource0)

/////////////////////////////
#define __PF1_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource1)
#define __PF1_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource1)
#define __PF1_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource1)
#define __PF1_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource1)

#define __PF1_FSMC_A1()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource1)

/////////////////////////////
#define __PF2_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource2)
#define __PF2_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource2)
#define __PF2_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource2)
#define __PF2_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource2)

#define __PF2_FSMC_A2()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource2)

/////////////////////////////
#define __PF3_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource3)
#define __PF3_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource3)
#define __PF3_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource3)
#define __PF3_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource3)

#define __PF3_FSMC_A3()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource3)

/////////////////////////////
#define __PF4_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource4)
#define __PF4_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource4)
#define __PF4_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource4)
#define __PF4_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource4)

#define __PF4_FSMC_A4()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource4)

/////////////////////////////
#define __PF5_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource5)
#define __PF5_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource5)
#define __PF5_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource5)
#define __PF5_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource5)

#define __PF5_FSMC_A5()		GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource5)

/////////////////////////////
#define __PF6_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource6)
#define __PF6_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource6)
#define __PF6_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource6)
#define __PF6_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource6)

/////////////////////////////
#define __PF7_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource7)
#define __PF7_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource7)
#define __PF7_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource7)
#define __PF7_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource7)

/////////////////////////////
#define __PF8_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource8)
#define __PF8_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource8)
#define __PF8_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource8)
#define __PF8_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource8)

/////////////////////////////
#define __PF9_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource9)
#define __PF9_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource9)
#define __PF9_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource9)
#define __PF9_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource9)

/////////////////////////////
#define __PF10_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource10)
#define __PF10_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource10)
#define __PF10_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource10)
#define __PF10_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource10)

/////////////////////////////
#define __PF11_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource11)
#define __PF11_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource11)
#define __PF11_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource11)
#define __PF11_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource11)

/////////////////////////////
#define __PF12_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource12)
#define __PF12_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource12)
#define __PF12_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource12)
#define __PF12_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource12)

#define __PF12_FSMC_A6()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource12)

/////////////////////////////
#define __PF13_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource13)
#define __PF13_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource13)
#define __PF13_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource13)
#define __PF13_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource13)

#define __PF13_FSMC_A7()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource13)

/////////////////////////////
#define __PF14_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource14)
#define __PF14_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource14)
#define __PF14_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource14)
#define __PF14_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource14)

#define __PF14_FSMC_A8()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource14)

/////////////////////////////
#define __PF15_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOF, GPIO_PinSource15)
#define __PF15_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOF, GPIO_PinSource15)
#define __PF15_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOF, GPIO_PinSource15)
#define __PF15_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOF, GPIO_PinSource15)

#define __PF15_FSMC_A9()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOF, GPIO_PinSource15)


/////////////////////////////////////////////////////////////////////////////////
// Port G
#define __PG0_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource0)
#define __PG0_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource0)
#define __PG0_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource0)
#define __PG0_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOG, GPIO_PinSource0)
#define __PG0_FSMC_A10()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOG, GPIO_PinSource0)

/////////////////////////////
#define __PG1_FSMC_A11()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOG, GPIO_PinSource1)

/////////////////////////////
#define __PG2_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource2)
#define __PG2_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource2)
#define __PG2_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource2)

#define __PG2_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource2)
#define __PG2_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource2)
#define __PG2_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource2)

#define __PG2_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource2)
#define __PG2_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource2)
#define __PG2_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource2)

#define __PG2_FSMC_A12()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOG, GPIO_PinSource2)

/////////////////////////////
#define __PG3_FSMC_A13()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOG, GPIO_PinSource3)

////////////////////////////
#define __PG4_FSMC_A14()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOG, GPIO_PinSource4)

/////////////////////////////
#define __PG5_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource5)
#define __PG5_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource5)
#define __PG5_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource5)

#define __PG5_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource5)
#define __PG5_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource5)
#define __PG5_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource5)

#define __PG5_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource5)
#define __PG5_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource5)
#define __PG5_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource5)

#define __PG5_FSMC_A15()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOG, GPIO_PinSource5)

/////////////////////////////
#define __PG6_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource6)
#define __PG6_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource6)
#define __PG6_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource6)

#define __PG6_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource6)
#define __PG6_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource6)
#define __PG6_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource6)

#define __PG6_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource6)
#define __PG6_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource6)
#define __PG6_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource6)

#define __PG6_FSMC_INT2()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC,	GPIOG, GPIO_PinSource6)

/////////////////////////////
#define __PG7_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource7)
#define __PG7_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource7)
#define __PG7_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource7)
#define __PG7_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOG, GPIO_PinSource7)

/////////////////////////////
#define __PG8_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource8)
#define __PG8_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource8)
#define __PG8_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource8)
#define __PG8_IN_PD()		GPIOPortInit(__GP_IN_PD, 0, 			GPIOG, GPIO_PinSource8)


/////////////////////////////
#define __PG9_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource9)


#define __PG9_FSMC_NE2()	GPIOPortInit(__GP_AP_PP, GPIO_AF_FSMC, 	GPIOG, GPIO_PinSource9)

/////////////////////////////
#define __PG10_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource10)
#define __PG10_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource10)
#define __PG10_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource10)

#define __PG10_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource10)
#define __PG10_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource10)
#define __PG10_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource10)

#define __PG10_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource10)
#define __PG10_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource10)
#define __PG10_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource10)

/////////////////////////////
#define __PG11_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource11)
#define __PG11_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource11)
#define __PG11_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource11)

#define __PG11_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource11)
#define __PG11_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource11)
#define __PG11_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource11)

#define __PG11_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource11)
#define __PG11_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource11)
#define __PG11_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource11)

/////////////////////////////
#define __PG12_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource12)
#define __PG12_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource12)
#define __PG12_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource12)

#define __PG12_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource12)
#define __PG12_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource12)
#define __PG12_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource12)

#define __PG12_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource12)
#define __PG12_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource12)
#define __PG12_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource12)

/////////////////////////////
#define __PG13_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource13)
#define __PG13_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource13)
#define __PG13_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource13)

#define __PG13_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource13)
#define __PG13_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource13)
#define __PG13_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource13)

#define __PG13_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource13)
#define __PG13_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource13)
#define __PG13_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource13)

/////////////////////////////
#define __PG14_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource14)
#define __PG14_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource14)
#define __PG14_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource14)

#define __PG14_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource14)
#define __PG14_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource14)
#define __PG14_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource14)

#define __PG14_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource14)
#define __PG14_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource14)
#define __PG14_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource14)

/////////////////////////////
#define __PG15_IN_FL()		GPIOPortInit(__GP_IN_FL, 0, 			GPIOG, GPIO_PinSource15)
#define __PG15_IN_PU()		GPIOPortInit(__GP_IN_PU, 0, 			GPIOG, GPIO_PinSource15)
#define __PG15_IU_PD()		GPIOPortInit(__GP_AD_PU, 0, 			GPIOG, GPIO_PinSource15)

#define __PG15_PP_PP()		GPIOPortInit(__GP_PP_PP, 0, 			GPIOG, GPIO_PinSource15)
#define __PG15_PP_PU()		GPIOPortInit(__GP_PP_PU, 0, 			GPIOG, GPIO_PinSource15)
#define __PG15_PP_PD()		GPIOPortInit(__GP_PP_PD, 0, 			GPIOG, GPIO_PinSource15)

#define __PG15_OD_OD()		GPIOPortInit(__GP_OD_OD, 0, 			GPIOG, GPIO_PinSource15)
#define __PG15_OD_PU()		GPIOPortInit(__GP_OD_PU, 0, 			GPIOG, GPIO_PinSource15)
#define __PG15_OD_PD()		GPIOPortInit(__GP_OD_PD, 0, 			GPIOG, GPIO_PinSource15)


/////////////////////////////





/** @defgroup GPIO_Legacy 
  * @{
  */
    
#define GPIO_Mode_AIN           GPIO_Mode_AN

#define GPIO_AF_OTG1_FS         GPIO_AF_OTG_FS
#define GPIO_AF_OTG2_HS         GPIO_AF_OTG_HS
#define GPIO_AF_OTG2_FS         GPIO_AF_OTG_HS_FS

/**
  * @}
  */

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/ 

/*  Function used to set the GPIO configuration to the default reset state ****/
void GPIO_DeInit(GPIO_TypeDef* GPIOx);

/* Initialization and Configuration functions *********************************/
void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_InitTypeDef* GPIO_InitStruct);
void GPIO_StructInit(GPIO_InitTypeDef* GPIO_InitStruct);
void GPIO_PinLockConfig(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
void GPIOPortInit(uint16_t Reg, uint8_t GPIO_AF, GPIO_TypeDef* GPIOx, uint16_t Pin_Src);

/* GPIO Read and Write functions **********************************************/
uint8_t GPIO_ReadInputDataBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
uint16_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx);
uint8_t GPIO_ReadOutputDataBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
uint16_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx);
void GPIO_SetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
void GPIO_ResetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);
void GPIO_WriteBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin, BitAction BitVal);
void GPIO_Write(GPIO_TypeDef* GPIOx, uint16_t PortVal);
void GPIO_ToggleBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin);

/* GPIO Alternate functions configuration function ****************************/
void GPIO_PinAFConfig(GPIO_TypeDef* GPIOx, uint16_t GPIO_PinSource, uint8_t GPIO_AF);

#ifdef __cplusplus
}
#endif

#endif /*__STM32F2xx_GPIO_H */

/**
  * @}
  */ 

/**
  * @}
  */ 

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
