/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_iwdg.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the functions prototypes for the
*                      IWDG firmware library.
*******************************************************************************/

// Define to prevent recursive inclusion ---------------------------------------
#ifndef __STM32F10x_IWDG_H
#define __STM32F10x_IWDG_H

// Includes --------------------------------------------------------------------
// Exported types --------------------------------------------------------------
// Exported constants ----------------------------------------------------------
// Write access to IWDG_PR and IWDG_RLR registers
#define IWDG_WriteAccess_Enable     ((u16)0x5555)
#define IWDG_WriteAccess_Disable    ((u16)0x0000)
// KR register bit mask
#define KR_Reload					((u16)0xAAAA)
#define KR_Enable					((u16)0xCCCC)

#define IS_IWDG_WRITE_ACCESS(ACCESS) ((ACCESS == IWDG_WriteAccess_Enable) || \
                                      (ACCESS == IWDG_WriteAccess_Disable))

// IWDG prescaler
#define IWDG_CLK4            ((u8)0x00)		// 40KHz/4 =  10kHz
#define IWDG_CLK8            ((u8)0x01)		// 40KHz/8 =  5kHz
#define IWDG_CLK16           ((u8)0x02)		// 40KHz/16 = 2.5kHz
#define IWDG_CLK32           ((u8)0x03)		// 40kHz/32 = 1.25kHz
#define IWDG_CLK64           ((u8)0x04)		// 40kHz/64 = 0.625kHz
#define IWDG_CLK128          ((u8)0x05)		// 40kHz/128= 0.3125kHz
#define IWDG_CLK256          ((u8)0x06)		// 40kHz/256= 0.15625kHz

// IWDG Flag
#define IWDG_FLAG_PVU               ((u16)0x0001)
#define IWDG_FLAG_RVU               ((u16)0x0002)

#define IS_IWDG_FLAG(FLAG) ((FLAG == IWDG_FLAG_PVU) || (FLAG == IWDG_FLAG_RVU))

#define IS_IWDG_RELOAD(RELOAD) (RELOAD <= 0xFFF)

// Exported macro --------------------------------------------------------------
// Exported functions ----------------------------------------------------------
void IWDG_WriteAccessCmd(u16 IWDG_WriteAccess);
void IWDG_SetPrescaler(u8 IWDG_Prescaler);
void IWDG_SetReload(u16 ms);
void IWDG_ReloadCounter(void);
void IWDG_Enable(void);
int IWDG_GetFlagStatus(u16 IWDG_FLAG);

#endif // __STM32F10x_IWDG_H

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
