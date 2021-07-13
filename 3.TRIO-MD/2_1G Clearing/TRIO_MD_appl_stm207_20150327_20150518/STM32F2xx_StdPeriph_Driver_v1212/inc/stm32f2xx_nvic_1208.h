/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_nvic.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the functions prototypes for the
*                      NVIC firmware library.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F10x_NVIC_H
#define __STM32F10x_NVIC_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/

#define AIRC_VECTKEY_MASK    		((u32)0x05FA0000)
#define AIRC_VECTKEY				0x5FA

#define SYSTEMRESET			SCB->AIRCR = AIRC_VECTKEY_MASK | (u32)0x04
#define CORERESET			SCB->AIRCR = AIRC_VECTKEY_MASK | (u32)0x01


// Exported types --------------------------------------------------------------
/** 
  * @brief  NVIC Init Structure definition  
  */

typedef struct
{
  uint8_t NVIC_IRQChannel;                    /*!< Specifies the IRQ channel to be enabled or disabled.
                                                   This parameter can be an enumerator of @ref IRQn_Type 
                                                   enumeration (For the complete STM32 Devices IRQ Channels
                                                   list, please refer to stm32f2xx.h file) */

  uint8_t NVIC_IRQChannelPreemptionPriority;  /*!< Specifies the pre-emption priority for the IRQ channel
                                                   specified in NVIC_IRQChannel. This parameter can be a value
                                                   between 0 and 15 as described in the table @ref MISC_NVIC_Priority_Table
                                                   A lower priority value indicates a higher priority */

  uint8_t NVIC_IRQChannelSubPriority;         /*!< Specifies the subpriority level for the IRQ channel specified
                                                   in NVIC_IRQChannel. This parameter can be a value
                                                   between 0 and 15 as described in the table @ref MISC_NVIC_Priority_Table
                                                   A lower priority value indicates a higher priority */

  FunctionalState NVIC_IRQChannelCmd;         /*!< Specifies whether the IRQ channel defined in NVIC_IRQChannel
                                                   will be enabled or disabled. 
                                                   This parameter can be set either to ENABLE or DISABLE */   
} NVIC_InitTypeDef;

/* Exported constants --------------------------------------------------------*/

#define IS_NVIC_IRQ_CHANNEL(CHANNEL) ((CHANNEL == WWDG_IRQn) || \
                                      (CHANNEL == PVD_IRQn) || \
                                      (CHANNEL == TAMP_STAMP_IRQn) || \
                                      (CHANNEL == RTC_WKUP_IRQn) || \
                                      (CHANNEL == FLASH_IRQn) || \
                                      (CHANNEL == RCC_IRQn) || \
                                      (CHANNEL == EXTI0_IRQn) || \
                                      (CHANNEL == EXTI1_IRQn) || \
                                      (CHANNEL == EXTI2_IRQn) || \
                                      (CHANNEL == EXTI3_IRQn) || \
                                      (CHANNEL == EXTI4_IRQn) || \
                                      (CHANNEL == DMA1_Stream0_IRQn) || \
                                      (CHANNEL == DMA1_Stream1_IRQn) || \
                                      (CHANNEL == DMA1_Stream2_IRQn) || \
                                      (CHANNEL == DMA1_Stream3_IRQn) || \
                                      (CHANNEL == DMA1_Stream4_IRQn) || \
                                      (CHANNEL == DMA1_Stream5_IRQn) || \
                                      (CHANNEL == DMA1_Stream6_IRQn) || \
                                      (CHANNEL == ADC_IRQn) || \
                                      (CHANNEL == CAN1_TX_IRQn) || \
                                      (CHANNEL == CAN1_RX0_IRQn) || \
                                      (CHANNEL == CAN1_RX1_IRQn) || \
                                      (CHANNEL == CAN1_SCE_IRQn) || \
                                      (CHANNEL == EXTI9_5_IRQn) || \
                                      (CHANNEL == TIM1_BRK_TIM9_IRQn) || \
                                      (CHANNEL == TIM1_UP_TIM10_IRQn) || \
                                      (CHANNEL == TIM1_TRG_COM_TIM11_IRQn) || \
                                      (CHANNEL == TIM1_CC_IRQn) || \
                                      (CHANNEL == TIM2_IRQn) || \
                                      (CHANNEL == TIM3_IRQn) || \
                                      (CHANNEL == TIM4_IRQn) || \
                                      (CHANNEL == I2C1_EV_IRQn) || \
                                      (CHANNEL == I2C1_ER_IRQn) || \
                                      (CHANNEL == I2C2_EV_IRQn) || \
                                      (CHANNEL == I2C2_ER_IRQn) || \
                                      (CHANNEL == SPI1_IRQn) || \
                                      (CHANNEL == SPI2_IRQn) || \
                                      (CHANNEL == USART1_IRQn) || \
                                      (CHANNEL == USART2_IRQn) || \
                                      (CHANNEL == USART3_IRQn) || \
                                      (CHANNEL == EXTI15_10_IRQn) || \
                                      (CHANNEL == RTC_Alarm_IRQn) || \
                                      (CHANNEL == OTG_FS_WKUP_IRQn) || \
									  (CHANNEL == TIM8_BRK_TIM12_IRQn) || \
									  (CHANNEL == TIM8_TRG_COM_TIM14_IRQn) || \
									  (CHANNEL == TIM8_CC_IRQn) || \
									  (CHANNEL == DMA1_Stream7_IRQn) || \
									  (CHANNEL == FSMC_IRQn) || \
									  (CHANNEL == SDIO_IRQn) || \
									  (CHANNEL == TIM5_IRQn) || \
									  (CHANNEL == SPI3_IRQn) || \
									  (CHANNEL == UART4_IRQn) || \
									  (CHANNEL == UART5_IRQn) || \
									  (CHANNEL == TIM6_DAC_IRQn) || \
									  (CHANNEL == TIM7_IRQn) || \
									  (CHANNEL == DMA2_Stream0_IRQn) || \
									  (CHANNEL == DMA2_Stream1_IRQn) || \
									  (CHANNEL == DMA2_Stream2_IRQn) || \
									  (CHANNEL == DMA2_Stream3_IRQn	) || \
									  (CHANNEL == DMA2_Stream4_IRQn) || \
									  (CHANNEL == ETH_IRQn) || \
									  (CHANNEL == ETH_WKUP_IRQn) || \
									  (CHANNEL == CAN2_TX_IRQn) || \
									  (CHANNEL == CAN2_RX0_IRQn) || \
									  (CHANNEL == CAN2_RX1_IRQn) || \
									  (CHANNEL == CAN2_SCE_IRQn) || \
									  (CHANNEL == OTG_FS_IRQn) || \
									  (CHANNEL == DMA2_Stream5_IRQn) || \
									  (CHANNEL == DMA2_Stream6_IRQn) || \
									  (CHANNEL == DMA2_Stream7_IRQn) || \
									  (CHANNEL == USART6_IRQn) || \
									  (CHANNEL == I2C3_EV_IRQn) || \
									  (CHANNEL == I2C3_ER_IRQn) || \
									  (CHANNEL == OTG_HS_EP1_OUT_IRQn) || \
									  (CHANNEL == OTG_HS_EP1_IN_IRQn) || \
									  (CHANNEL == OTG_HS_WKUP_IRQn) || \
									  (CHANNEL == OTG_HS_IRQn) || \
									  (CHANNEL == DCMI_IRQn) || \
									  (CHANNEL == CRYP_IRQn) || \
									  (CHANNEL == HASH_RNG_IRQn))
 		
/* System Handlers -------------------------------TIM8_UP_TIM13_IRQn			----------------------------*/
#define SystemHandler_NMI            ((u32)0x00001F) /* NMI Handler */
#define SystemHandler_HardFault      ((u32)0x000000) /* Hard Fault Handler */
#define SystemHandler_MemoryManage   ((u32)0x043430) /* Memory Manage Handler */
#define SystemHandler_BusFault       ((u32)0x547931) /* Bus Fault Handler */
#define SystemHandler_UsageFault     ((u32)0x24C232) /* Usage Fault Handler */
#define SystemHandler_SVCall         ((u32)0x01FF40) /* SVCall Handler */
#define SystemHandler_DebugMonitor   ((u32)0x0A0080) /* Debug Monitor Handler */
#define SystemHandler_PSV            ((u32)0x02829C) /* PSV Handler */
#define SystemHandler_SysTick        ((u32)0x02C39A) /* SysTick Handler */
				
#define IS_CONFIG_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_MemoryManage) || \
                                           (HANDLER == SystemHandler_BusFault) || \
                                           (HANDLER == SystemHandler_UsageFault))
			
#define IS_PRIORITY_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_MemoryManage) || \
                                             (HANDLER == SystemHandler_BusFault) || \
                                             (HANDLER == SystemHandler_UsageFault) || \
                                             (HANDLER == SystemHandler_SVCall) || \
                                             (HANDLER == SystemHandler_DebugMonitor) || \
                                             (HANDLER == SystemHandler_PSV) || \
                                             (HANDLER == SystemHandler_SysTick))
				
#define IS_GET_PENDING_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_MemoryManage) || \
                                                (HANDLER == SystemHandler_BusFault) || \
                                                (HANDLER == SystemHandler_SVCall))
			
#define IS_SET_PENDING_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_NMI) || \
                                                (HANDLER == SystemHandler_PSV) || \
                                                (HANDLER == SystemHandler_SysTick))
 		
#define IS_CLEAR_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_PSV) || \
                                          (HANDLER == SystemHandler_SysTick))
 				
#define IS_GET_ACTIVE_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_MemoryManage) || \
                                               (HANDLER == SystemHandler_BusFault) || \
                                               (HANDLER == SystemHandler_UsageFault) || \
                                               (HANDLER == SystemHandler_SVCall) || \
                                               (HANDLER == SystemHandler_DebugMonitor) || \
                                               (HANDLER == SystemHandler_PSV) || \
                                               (HANDLER == SystemHandler_SysTick))

#define IS_FAULT_SOURCE_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_HardFault) || \
                                                 (HANDLER == SystemHandler_MemoryManage) || \
                                                 (HANDLER == SystemHandler_BusFault) || \
                                                 (HANDLER == SystemHandler_UsageFault) || \
                                                 (HANDLER == SystemHandler_DebugMonitor)) 

#define IS_FAULT_ADDRESS_SYSTEM_HANDLER(HANDLER) ((HANDLER == SystemHandler_MemoryManage) || \
                                                  (HANDLER == SystemHandler_BusFault))


/* Vector Table Base ---------------------------------------------------------*/
#define NVIC_VectTab_RAM             ((u32)0x20000000)
#define NVIC_VectTab_FLASH           ((u32)0x08000000)

#define IS_NVIC_VECTTAB(VECTTAB) ((VECTTAB == NVIC_VectTab_RAM) || \
                                  (VECTTAB == NVIC_VectTab_FLASH))

/** @defgroup MISC_System_Low_Power 
  * @{
  */
	
#define NVIC_LP_SEVONPEND            ((uint8_t)0x10)
#define NVIC_LP_SLEEPDEEP            ((uint8_t)0x04)
#define NVIC_LP_SLEEPONEXIT          ((uint8_t)0x02)
#define IS_NVIC_LP(LP) 				(((LP) == NVIC_LP_SEVONPEND) || \
									((LP) == NVIC_LP_SLEEPDEEP) || \
									((LP) == NVIC_LP_SLEEPONEXIT))
/**
  * @}
  */

/* Preemption Priority Group -------------------------------------------------*/
/** @defgroup MISC_Preemption_Priority_Group 
  * @{
  */

#define NVIC_PriorityGroup_0         ((uint32_t)0x700) /*!< 0 bits for pre-emption priority
                                                            4 bits for subpriority */
#define NVIC_PriorityGroup_1         ((uint32_t)0x600) /*!< 1 bits for pre-emption priority
                                                            3 bits for subpriority */
#define NVIC_PriorityGroup_2         ((uint32_t)0x500) /*!< 2 bits for pre-emption priority
                                                            2 bits for subpriority */
#define NVIC_PriorityGroup_3         ((uint32_t)0x400) /*!< 3 bits for pre-emption priority
                                                            1 bits for subpriority */
#define NVIC_PriorityGroup_4         ((uint32_t)0x300) /*!< 4 bits for pre-emption priority
                                                            0 bits for subpriority */

#define IS_NVIC_PRIORITY_GROUP(GROUP) (((GROUP) == NVIC_PriorityGroup_0) || \
                                       ((GROUP) == NVIC_PriorityGroup_1) || \
                                       ((GROUP) == NVIC_PriorityGroup_2) || \
                                       ((GROUP) == NVIC_PriorityGroup_3) || \
                                       ((GROUP) == NVIC_PriorityGroup_4))

#define IS_NVIC_PREEMPTION_PRIORITY(PRIORITY)  ((PRIORITY) < 0x10)


/**
  * @}
  */
/** @defgroup MISC_Preemption_Priority_Group 
  * @{
  */
#define IS_NVIC_SUB_PRIORITY(PRIORITY)  (PRIORITY < 0x10)
#define IS_NVIC_OFFSET(OFFSET)  ((OFFSET) < 0x000FFFFF)
#define IS_NVIC_BASE_PRI(PRI) ((PRI > 0x00) && (PRI < 0x10))

/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void NVIC_DeInit(void);
void NVIC_SCBDeInit(void);
void NVIC_PriorityGroupConfig(u32 NVIC_PriorityGroup);
void NVIC_Init(u32 NVIC_IRQChannel, u32 NVIC_IRQChannelCmd);
void NVIC_StructInit(NVIC_InitTypeDef* NVIC_InitStruct);
void NVIC_SETPRIMASK(void);
void NVIC_RESETPRIMASK(void);
void NVIC_SETFAULTMASK(void);
void NVIC_RESETFAULTMASK(void);
void NVIC_BASEPRICONFIG(u32 NewPriority);
u32 NVIC_GetBASEPRI(void);
u16 NVIC_GetCurrentPendingIRQChannel(void);
u32 NVIC_GetIRQChannelPendingBitStatus(u8 NVIC_IRQChannel);
void NVIC_SetIRQChannelPendingBit(u8 NVIC_IRQChannel);
void NVIC_ClearIRQChannelPendingBit(u8 NVIC_IRQChannel);
u16 NVIC_GetCurrentActiveHandler(void);
u32 NVIC_GetIRQChannelActiveBitStatus(u8 NVIC_IRQChannel);
u32 NVIC_GetCPUID(void);
void NVIC_SetVectorTable(u32 Addr);
void NVIC_SystemLPConfig(u8 LowPowerMode, u32 NewState);
void NVIC_SystemHandlerConfig(u32 SystemHandler, u32 NewState);
void NVIC_SystemHandlerPriorityConfig(u32 SystemHandler, u8 SystemHandlerPreemptionPriority,
                                      u8 SystemHandlerSubPriority);
u32 NVIC_GetSystemHandlerPendingBitStatus(u32 SystemHandler);
void NVIC_SetSystemHandlerPendingBit(u32 SystemHandler);
void NVIC_ClearSystemHandlerPendingBit(u32 SystemHandler);
u32 NVIC_GetSystemHandlerActiveBitStatus(u32 SystemHandler);
u32 NVIC_GetFaultHandlerSources(u32 SystemHandler);
u32 NVIC_GetFaultAddress(u32 SystemHandler);

#ifdef __cplusplus
}
#endif

#endif /* __STM32F10x_NVIC_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
