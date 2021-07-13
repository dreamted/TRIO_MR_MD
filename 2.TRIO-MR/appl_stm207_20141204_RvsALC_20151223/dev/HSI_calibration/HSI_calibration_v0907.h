/********************************************************************************
  * @file RCCalibration/inc/HSI_calibration.h 
  * @author  MCD Application Team
  * @version  V2.0.0
  * @date  04/27/2009
  * @brief  This files contains the HSI calibration functions prototypes
  ******************************************************************************
  * @copy
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
*******************************************************************************/ 


// Define to prevent recursive inclusion ---------------------------------------
#ifndef __HSI_CALIBRATION_H
#define __HSI_CALIBRATION_H

// Includes --------------------------------------------------------------------

// Exported types --------------------------------------------------------------
// Exported constants ----------------------------------------------------------
// Comment this line if the RTC/64 signal (PC13) is not the reference frequency
//#define USE_Reference_RTC
#define Ref_Frequency		(512) // The reference frequency value in Hertz
// Exported macro --------------------------------------------------------------
// Exported functions ----------------------------------------------------------
#define __TIM3

void TIM3_IRQHandler(void);
void HSI_CalibrationInit(void);

void HSI_FreqMeasure(void);
void HSI_CalibrateMinError(void);
u32 HSI_CalibrateFixedError(u32 AllowedErrorMax, s32* Freq);
void RCC_ConfigurationForHSI(void);
void TIM_ConfigurationForHSI(void);
void RTC_ConfigurationForHSI(void);
#endif // __HSI_CALIBRATION_H

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
