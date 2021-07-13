/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_pwr.h
* Author             : MCD Application Team
* Date First Issued  : 09/29/2006
* Description        : This file contains all the functions prototypes for the
*                      PWR firmware library.
********************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F10x_PWR_H
#define __STM32F10x_PWR_H
//------------------------ Power Control ---------------------------------------
typedef struct
{
	union {
		vu32 Data;
		struct {
			vu32 LPDS		:1;	// rw, low-power deepsleep
								//	- 0: on during "stop" mode
								//	- 1: voltage regulator in low-power mode during STOP mode
			vu32 PDDS		:1;	// rw, power down deepsleep
								//	- 0: enter STOP mode when the CPU in deepsllep, <- LPDS
								//	- 1: enter STANDBY mode when the CPU in deepsleep
			vu32 CWUF		:1;	// rc_w1, clear Wake-up Flag
			vu32 CSBF		:1;	// rc_w1, clear STANDBY Flag
			vu32 PVDE		:1;	// rw, Power voltage detector Enable
			vu32 PLS		:3;	// rw, PVD level selection
			vu32 DBP		:1;	// rw, Disable backup domain write protection
								//	- 0: access RTC & backup register disable
								//	- 1: access RTC & backup register enable
		} Bit;
	} CR; // power control register, reset by wake-up from STADNBY mode

	union {
		vu32 Data;
		struct {
			vu32 WUF		:1;	// r, wake up flag
			vu32 SBF		:1;	// r, standby flag
			vu32 PVDO		:1;	// r, PWD output(0: Normal, 1: lower than PVD
			vu32			:5;
			vu32 EWUP		:1;	// rw, Enable WKUP pin
		} Bit;
	} CSR; // power control/status register
} PWR_TypeDef;


#define PWR 				((PWR_TypeDef *) PWR_BASE)
////////////////////////////////////////////////////////////////////////////////
// PVD detection level
#define PWR_PVDLevel_2V2          ((u32)0x00000000)
#define PWR_PVDLevel_2V3          ((u32)0x00000020)
#define PWR_PVDLevel_2V4          ((u32)0x00000040)
#define PWR_PVDLevel_2V5          ((u32)0x00000060)
#define PWR_PVDLevel_2V6          ((u32)0x00000080)
#define PWR_PVDLevel_2V7          ((u32)0x000000A0)
#define PWR_PVDLevel_2V8          ((u32)0x000000C0)
#define PWR_PVDLevel_2V9          ((u32)0x000000E0)

#define __PVDLvl_2V2				0
#define __PVDLvl_2V3				1
#define __PVDLvl_2V4				2
#define __PVDLvl_2V5				3
#define __PVDLvl_2V6				4
#define __PVDLvl_2V7				5
#define __PVDLvl_2V8				6
#define __PVDLvl_2V9				7

#define IS_PWR_PVD_LEVEL(LEVEL) ((LEVEL == PWR_PVDLevel_2V2) || (LEVEL == PWR_PVDLevel_2V3)|| \
                                 (LEVEL == PWR_PVDLevel_2V4) || (LEVEL == PWR_PVDLevel_2V5)|| \
                                 (LEVEL == PWR_PVDLevel_2V6) || (LEVEL == PWR_PVDLevel_2V7)|| \
                                 (LEVEL == PWR_PVDLevel_2V8) || (LEVEL == PWR_PVDLevel_2V9))

/* Regulator state is STOP mode */
#define PWR_Regulator_ON          ((u32)0x00000000)
#define PWR_Regulator_LowPower    ((u32)0x00000001)

#define IS_PWR_REGULATOR(REGULATOR) ((REGULATOR == PWR_Regulator_ON) || \
                                     (REGULATOR == PWR_Regulator_LowPower))

/* STOP mode entry */
#define PWR_STOPEntry_WFI         ((u8)0x01)
#define PWR_STOPEntry_WFE         ((u8)0x02)

#define IS_PWR_STOP_ENTRY(ENTRY) ((ENTRY == PWR_STOPEntry_WFI) || (ENTRY == PWR_STOPEntry_WFE))
 
/* PWR Flag */
#define PWR_FLAG_WU               ((u32)0x00000001)
#define PWR_FLAG_SB               ((u32)0x00000002)
#define PWR_FLAG_PVDO             ((u32)0x00000004)

#define IS_PWR_GET_FLAG(FLAG) ((FLAG == PWR_FLAG_WU) || (FLAG == PWR_FLAG_SB) || \
                               (FLAG == PWR_FLAG_PVDO))
#define IS_PWR_CLEAR_FLAG(FLAG) ((FLAG == PWR_FLAG_WU) || (FLAG == PWR_FLAG_SB))

// Exported macro --------------------------------------------------------------
#define PWR_BackupAccessCmd(sts)	PWR->CR.Bit.DBP = sts

/* Exported functions ------------------------------------------------------- */
void PWR_DeInit(void);
void PWR_PVDCmd(u32 NewState);
void PWR_PVDLevelConfig(u32 PWR_PVDLevel);
void PWR_WakeUpPinCmd(u32 NewState);
void PWR_EnterSTOPMode(u32 PWR_Regulator, u8 PWR_STOPEntry);
void PWR_EnterSTANDBYMode(void);
FlagStatus PWR_GetFlagStatus(u32 PWR_FLAG);
void PWR_ClearFlag(u32 PWR_FLAG);

#endif /* __STM32F10x_PWR_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
