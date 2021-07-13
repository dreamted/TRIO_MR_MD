/**
  ******************************************************************************
  * @file RTC/inc/clock_calendar.h 
  * @author  MCD Application Team
  * @version  V2.0.0
  * @date  04/27/2009
  * @brief  This files contains the Clock Calendar functions prototypes
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
  */ 


//#define __CLOCK_RTC_USED			// if you used RTC/CLOCK --> define
////////////////////////////////////////////////////////////////////////////////
#ifdef	__CLOCK_RTC_USED
	#define __PWR_BACKUP_USED		// don't touch
#else
/////////////////////////////////////////////////////////////////////////////////
	//#define __PWR_BACKUP_USED		// if you don't used "__CLOCK_RTC_USED" you can decide "pwr_backup register"
#endif

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __CLOCK_CALENDAR_H
#define __CLOCK_CALENDAR_H

// Includes --------------------------------------------------------------------


/* Exported types ------------------------------------------------------------*/
/* Time Structure definition */
struct Time_s
{
	u8 SecLow;
	u8 SecHigh;
	u8 MinLow;
	u8 MinHigh;
	u8 HourLow;
	u8 HourHigh;
};
extern struct Time_s s_TimeStructVar;

/* Alarm Structure definition */
struct AlarmTime_s
{
	u8 SecLow;
	u8 SecHigh;
	u8 MinLow;
	u8 MinHigh;
	u8 HourLow;
	u8 HourHigh;
};
extern struct AlarmTime_s s_AlarmStructVar;

/* Date Structure definition */
struct Date_s
{
	u8 Month;
	u8 Day;
	u16 Year;
};
extern struct Date_s s_DateStructVar;

/* Alarm Date Structure definition */
struct AlarmDate_s
{
	u8 Month;
	u8 Day;
	u16 Year;
};
extern struct AlarmDate_s s_AlarmDateStructVar;

// Exported constants ----------------------------------------------------------
#define BATTERY_REMOVED 		98
#define BATTERY_RESTORED 		99
#define SECONDS_IN_DAY 			86399
#define CONFIGURATION_DONE 		0xAAAF
#define CONFIGURATION_RESET 	0x0000
#define OCTOBER_FLAG_SET 		0x4000
#define MARCH_FLAG_SET 			0x8000
#define DEFAULT_DAY 			1
#define DEFAULT_MONTH 			7
#define DEFAULT_YEAR 			11			// 2009 Year
#define DEFAULT_HOURS 			0
#define DEFAULT_MINUTES 		1
#define DEFAULT_SECONDS 		0

#define LEAP 					1
#define NOT_LEAP 				0


// Exported macro --------------------------------------------------------------
// Exported functions ----------------------------------------------------------
void CalendarInit(void);
void RTC_Configuration(void);
void SetTime(u8, u8, u8);
void SetAlarm(u8, u8, u8);
void SetDate(u8, u8, u16);
void RTC_Application(void);
void DateUpdate(void);
u16 WeekDay(u16, u8, u8);
u16 RTC_CalibrationFunc(s32 mHz);

u8 CheckLeap(u16);
void CalculateTime(void);
void DisplayDate(void);
void DisplayTime(void);
void DisplayAlarm(void);
void RTC_NVIC_Configuration(void);
void ApplicationInit(void);
void GPIO_Configuration(void);
void DelayLowPower(vu32 nCount);
void SysTickConfig(void);
void CheckForDaysElapsed(void);
void SummerTimeCorrection(void);
void Tamper_NVIC_Configuration(void);
void ManualClockCalibration(void);
void AutoClockCalibration(void);
void ReturnFromStopMode(void);

void RTC_IRQHandler(void);
void RTC_LoadBackupData(void);
void RTC_WritetoStatus(void);
void CheckDateTime(void);
INT8U RetRtcInit(void);
#endif /* __CLOCK_CALENDAR_H */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
