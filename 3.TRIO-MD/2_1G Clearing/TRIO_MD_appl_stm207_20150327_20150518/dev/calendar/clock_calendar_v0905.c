/**
  ******************************************************************************
  * @file RTC/src/clock_calendar.c 
  * @author  MCD Application Team
  * @version  V2.0.0
  * @date  04/27/2009
  * @brief  Clock Calendar basic routines
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


/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Private variables--------------------------------------------------------- */
u8 ClockSource;
const u8 *MonthsNames[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug",\
                    "Sep","Oct","Nov","Dec"};
const u8 CalibrationPpm[128]={0,1,2,3,4,5,6,7,8,9,10,10,11,12,13,14,15,16,17,\
                         18,19,20,21,22,23,24,25,26,27,28,29,30,31,31,32,33,34,\
                         35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,51,\
                         52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,\
                         70,71,72,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,\
                         87,88,89,90,91,92,93,93,94,95,96,97,98,99,100,101,102,\
                         103,104,105,106,107,108,109,110,111,112,113,113,114,\
                         115,116,117,118,119,120,121};
/*Structure variable declaration for system time, system date,
alarm time, alarm date */
struct Time_s s_TimeStructVar;
struct AlarmTime_s s_AlarmStructVar;
struct Date_s s_DateStructVar;
struct AlarmDate_s s_AlarmDateStructVar;

u16 s_SummerTimeCorrect;

/** @addtogroup RTC
  * @{
  */ 


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/


/*******************************************************************************
 * brief:  Configuration of RTC Registers, Selection and Enabling of 
 * 		   RTC clock
 * param:  None
 * retval: None
 ******************************************************************************/
#define CONFIGDEF_DR	BKP_DR1
#define MONTH_DR		BKP_DR2
#define DAY_DR			BKP_DR3
#define YEAR_DR			BKP_DR4

#define SUMMER_DR		BKP_DR7
#define ALM_MONTH_DR	BKP_DR8
#define ALM_DAY_DR		BKP_DR9
#define ALM_YEAR_DR		BKP_DR10

INT8U RTCInitEnd = 0;
INT8U rSystem_Time[6];

#define __SEC			0
#define __MIN			1
#define __HOUR			2
#define __DAY			3
#define __MONTH			4
#define __YEAR			5

void CalendarInit(void)
{
	RTC_Configuration();

#ifdef __CLOCK_RTC_USED
	CheckForDaysElapsed();
	RTCInitEnd = 1;
#endif	
}

INT8U RetRtcInit(void)
{
	return RTCInitEnd;
}

void RTC_LoadBackupData(void)
{
//	__LIF_DnrStatus *Sts = LIF_DnrSts;
	
	// STS->rtc time buffer
	//memcpy(rSystem_Time, Sts->time, 6); 
}

void RTC_WritetoStatus(void)
{
	//	__LIF_DnrStatus *Sts = LIF_DnrSts;
		
		// rtc time buffer -> STS
		//memcpy(Sts->time, rSystem_Time, 6); 
}

void CheckDateTime(void)
{
/***
	INT32U System_Time, Backup_Time, Change_Time;
	
	__LIF_DnrStatus  *Sts = LIF_DnrSts;
	
	EE_BACK1 *tptr = vEE_BACK1;

	CalculateTime();
	

	// time backup!!
	System_Time  = Sts->EtcInfo.System_Time[5] * 365;
	System_Time += Sts->EtcInfo.System_Time[4] * 30;
	System_Time += Sts->EtcInfo.System_Time[3];

	Backup_Time  = tptr->BackUp.System_Time[5] * 365;
	Backup_Time += tptr->BackUp.System_Time[4] * 30;
	Backup_Time += tptr->BackUp.System_Time[3];

	Change_Time  = Sts->EtcInfo.Change_Time[5] * 365;
	Change_Time += Sts->EtcInfo.Change_Time[4] * 30;
	Change_Time += Sts->EtcInfo.Change_Time[3];

	if(System_Time <  Change_Time + 2)
	{
		if(System_Time >= (Backup_Time + 1))
		{
			INT8U err = 0;
			INT8U i = 0;
			
			OSSemPend(CtrlSem, 0, &err);
			tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
			for(i = 0; i < 6; i++) tptr->BackUp.System_Time[i] = Sts->EtcInfo.System_Time[i];
			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
			OSSemPost(CtrlSem);
		}
	}

	System_Time = (System_Time*24) + Sts->EtcInfo.System_Time[2];
	System_Time = (System_Time*60) + Sts->EtcInfo.System_Time[1];
	
	Change_Time = (Change_Time*24) + Sts->EtcInfo.Change_Time[2];
	Change_Time = (Change_Time*60) + Sts->EtcInfo.Change_Time[1];
	
	if(System_Time >= Change_Time)
	{
		Time_BandSelect = TRUE;	
	}
	else Time_BandSelect = FALSE;

	**/
}

void RTC_Configuration(void)
{
#ifdef __CLOCK_RTC_USED
	u8 rtime = 0;
	u32 tmpreg = 0;
#endif    
	// Allow access to Backup Registers
	RCC->APB1ENR.Data |= (__BKPEN | __PWREN);
	
#ifdef __CLOCK_RTC_USED
	NVIC_Init(RTC_IRQChannel, ENABLE);
	//NVIC_Init(RTCAlarm_IRQChannel, ENABLE);	// Enable the RTC Alarm Interrupt

	PWR_BackupAccessCmd(ENABLE);

	if(rSystem_Time[5] >  99 ||\
	   rSystem_Time[4] >  12 ||\
	   rSystem_Time[3] >  31 ||\
	   rSystem_Time[2] >  23 ||\
	   rSystem_Time[1] >  59 ||\
	   rSystem_Time[0] >  59 \
	)
	{
		rSystem_Time[0] = 0;
		rSystem_Time[1] = 0;
		rSystem_Time[2] = 0;		
		rSystem_Time[3] = DEFAULT_DAY;
		rSystem_Time[4] = DEFAULT_MONTH;
		rSystem_Time[5] = DEFAULT_YEAR;
		rtime = TRUE;
	}

	if(	BKP_ReadBackupRegister(YEAR_DR)  > 2099 || \
		BKP_ReadBackupRegister(MONTH_DR) > 12 || \
		BKP_ReadBackupRegister(DAY_DR)	 > 31 )
	{
		rtime = TRUE;
	}

	if(BKP_ReadBackupRegister(CONFIGDEF_DR) != CONFIGURATION_DONE || rtime == TRUE)
	{
INIT:	
		BKP_DeInit();

		s_DateStructVar.Month = rSystem_Time[4];
   		s_DateStructVar.Day = rSystem_Time[3];
   		s_DateStructVar.Year = rSystem_Time[5] + 2000;

		BKP_WriteBackupRegister(MONTH_DR, s_DateStructVar.Month);
		BKP_WriteBackupRegister(DAY_DR, s_DateStructVar.Day);
		BKP_WriteBackupRegister(YEAR_DR, s_DateStructVar.Year);
		BKP_WriteBackupRegister(CONFIGDEF_DR, CONFIGURATION_DONE);

		RCC_LSEConfig(RCC_LSE_ON);	// Enable 32.768 kHz external oscillator
		do
		{
			WatchdogClear();
			tmpreg = RCC->BDCR.LSERDY;
		}
		while(!tmpreg);
		
		RCC_RTCCLKConfig(RCC_RTCCLKSource_LSE);	// RTC Enabled
		RCC_RTCCLKCmd(ENABLE);	// SerPtr->printf("\n#1\n");
		RTC_WaitForLastTask();	// Wait for RTC registers synchronisation
								// SerPtr->printf("\n#2\n");
		RTC_WaitForSynchro();	//SerPtr->printf("\n#3\n");
		RTC_WaitForLastTask();	// Setting RTC Interrupts-Seconds interrupt enabled

		RTC_SetPrescaler(32766); // RTC period = RTCCLK/RTC_PR = (32.768 KHz)/(32767+1)
		// Prescaler is set to 32766 instead of 32768 to compensate for
	  	// lower as well as higher frequencies*/
		// Wait until last write operation on RTC registers has finished */
		RTC_WaitForLastTask();
		{
			INT8U Hour = rSystem_Time[2] % 24;
			INT8U Minute = rSystem_Time[1] % 60;
			INT8U Seconds = rSystem_Time[0] % 60;

			SetTime(Hour, Minute, Seconds);
		}
		{
			/**
			int RTC_CAL = (Sts->EtcInfo.RTC_CAL[0] << 16)| \
						  (Sts->EtcInfo.RTC_CAL[1] << 8) | \
						  (Sts->EtcInfo.RTC_CAL[2] << 0);

	        if(Sts->EtcInfo.RTC_CAL[3] != ((APPMODE) & 0xFF)) RTC_CAL = 512000L;

			RTC_CalibrationFunc(RTC_CAL & 0xffff);
			SerPtr->printf("DEFAULT SET CAL: %d\n", RTC_CAL & 0xfffff);			
			**/
		}
	}
	else
	{
		tmpreg += RCC->BDCR.LSERDY;
		tmpreg += RCC->BDCR.LSEON;
		tmpreg += RCC->BDCR.RTCSEL;
		tmpreg += RCC->BDCR.RTCEN;
		
		if(tmpreg != 4)
		{
			goto INIT;
		}
	}
	OSTimeDly(10);
    RTC_WaitForLastTask();
    RTC_ITConfig(RTC_IT_SEC, ENABLE);
    RTC_WaitForLastTask();
	BKP_RTCOutputConfig(ENABLE);

#endif //__CLOCK_RTC_USED

}


/*******************************************************************************
  * @brief Chaeks is counter value is more than 86399 and the number of
  *   elapsed and updates date that many times
  * @param None
  * @retval :None
*******************************************************************************/
void CheckForDaysElapsed(void)
{
	u8 DaysElapsed = 0;
 
	if((RTC_GetCounter() / SECONDS_IN_DAY) != 0)
  	{
    	for(;DaysElapsed < (RTC_GetCounter() / SECONDS_IN_DAY); DaysElapsed++)
		{
      		DateUpdate();
			USART1Printf("Day Updated!! \n");
    	}
		RTC_SetCounter(RTC_GetCounter() % SECONDS_IN_DAY);
  	}

	s_DateStructVar.Month = BKP_ReadBackupRegister(MONTH_DR);
	s_DateStructVar.Day = BKP_ReadBackupRegister(DAY_DR);
	s_DateStructVar.Year = BKP_ReadBackupRegister(YEAR_DR);
	
	s_SummerTimeCorrect = BKP_ReadBackupRegister(SUMMER_DR);
	s_AlarmDateStructVar.Month = BKP_ReadBackupRegister(ALM_MONTH_DR);
	s_AlarmDateStructVar.Day = BKP_ReadBackupRegister(ALM_DAY_DR);
	s_AlarmDateStructVar.Year = BKP_ReadBackupRegister(ALM_YEAR_DR);
}

/*******************************************************************************
  * @brief Updates the Date (This function is called when 1 Day has elapsed
  * @param None
  * @retval :None
*******************************************************************************/
void DateUpdate(void)
{
	s_DateStructVar.Month = BKP_ReadBackupRegister(MONTH_DR);
	s_DateStructVar.Year = BKP_ReadBackupRegister(YEAR_DR);
	s_DateStructVar.Day = BKP_ReadBackupRegister(DAY_DR);

	switch(s_DateStructVar.Month)
	{
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
		{
			if(s_DateStructVar.Day < 31) s_DateStructVar.Day++;
			else // Date structure member: s_DateStructVar.Day = 31
			{
				if(s_DateStructVar.Month != 12)
			  	{
					s_DateStructVar.Month++;
					s_DateStructVar.Day = 1;
			  	}
			 	else // Date structure member: s_DateStructVar.Day = 31 & s_DateStructVar.Month = 12
				{
					s_DateStructVar.Month = 1;
					s_DateStructVar.Day = 1;
					s_DateStructVar.Year++;
				}
			}
		}
		break;

		case 4:
		case 6:
		case 9:
		case 11:
		{
    		if(s_DateStructVar.Day < 30) s_DateStructVar.Day++;	
		    else // Date structure member: s_DateStructVar.Day = 30
    		{
      			s_DateStructVar.Month++;
      			s_DateStructVar.Day = 1;
    		}
  		}
		break;

		case 2:
		{
			if(s_DateStructVar.Day < 28)
			{
			  	s_DateStructVar.Day++;
			}
			else if(s_DateStructVar.Day == 28)
			{
			  	// Leap Year Correction
			 	if(CheckLeap(s_DateStructVar.Year))
			  	{
					s_DateStructVar.Day++;
			  	}
			  	else
			  	{
					s_DateStructVar.Month++;
					s_DateStructVar.Day = 1;
			  	}
			}
			else if(s_DateStructVar.Day == 29)
			{
				s_DateStructVar.Month++;
			 	s_DateStructVar.Day = 1;
			}
		}
		break;
	}
	BKP_WriteBackupRegister(MONTH_DR, s_DateStructVar.Month);
  	BKP_WriteBackupRegister(DAY_DR, s_DateStructVar.Day);
  	BKP_WriteBackupRegister(YEAR_DR, s_DateStructVar.Year);
}

/*******************************************************************************
  * @brief  Checks whether the passed year is Leap or not.
  * @param  None
  * @retval : 1: leap year
  *   0: not leap year
*******************************************************************************/
u8 CheckLeap(u16 Year)
{
	     if((Year%400)==0) 	return LEAP;
	else if((Year%100)==0) 	return NOT_LEAP;
	else if((Year%4  )==0) 	return LEAP;
	else					return NOT_LEAP;
}

/*******************************************************************************
  * @brief Calcuate the Time (in hours, minutes and seconds  derived from
  *   COunter value
  * @param None
  * @retval :None
*******************************************************************************/
void CalculateTime(void)
{

	u32 TimeVar = RTC_GetCounter();
	TimeVar %= 86400;

	s_TimeStructVar.HourHigh =(u8)(TimeVar/3600)/10;
	s_TimeStructVar.HourLow  =(u8)(TimeVar/3600)%10;
	s_TimeStructVar.MinHigh  =(u8)((TimeVar%3600)/60)/10;
	s_TimeStructVar.MinLow   =(u8)((TimeVar%3600)/60)%10;
	s_TimeStructVar.SecHigh  =(u8)((TimeVar%3600)%60)/10;
	s_TimeStructVar.SecLow   =(u8)((TimeVar %3600)%60)%10;


	rSystem_Time[0] = s_TimeStructVar.SecHigh*10 + s_TimeStructVar.SecLow;
	rSystem_Time[1] = s_TimeStructVar.MinHigh*10 + s_TimeStructVar.MinLow;
	rSystem_Time[2] = s_TimeStructVar.HourHigh*10 +s_TimeStructVar.HourLow;
	rSystem_Time[3] = s_DateStructVar.Day;
	rSystem_Time[4] = s_DateStructVar.Month;
	rSystem_Time[5] = (s_DateStructVar.Year) % 100;

}

/*******************************************************************************
  * @brief  Sets the RTC Current Counter Value
  * @param Hour, Minute and Seconds data
  * @retval : None
*******************************************************************************/

void SetTime(u8 Hour, u8 Minute, u8 Seconds)
{
	u32 CounterValue = ((Hour * 3600)+ (Minute * 60)+ Seconds);

	RTC_WaitForLastTask();
	RTC_SetCounter(CounterValue);
	RTC_WaitForLastTask();
}


/*******************************************************************************
  * @brief  Sets the RTC Date(DD/MM/YYYY)
  * @param DD,MM,YYYY
  * @retval : None
*******************************************************************************/
void SetDate(u8 Day, u8 Month, u16 Year)
{
  	// Check if the date entered by the user is correct or not, Displays an error
	// message if date is incorrect
	if((   (Month==4 || Month==6  || Month==9 || Month==11) && Day ==31) \
    	|| (Month==2 && Day == 31)|| (Month==2 && Day==30)|| \
      	   (Month==2 && Day == 29 && (CheckLeap(Year)==0)))
 	{

  	}
  	// if date entered is correct then set the date
  	else
  	{
    	s_DateStructVar.Day = Day;
    	s_DateStructVar.Month = Month;
    	s_DateStructVar.Year = Year;
		BKP_WriteBackupRegister(MONTH_DR, Month);
		BKP_WriteBackupRegister(DAY_DR, Day);
		BKP_WriteBackupRegister(YEAR_DR,Year);
  	}
}

/*******************************************************************************
  * @brief  Sets the RTC Alarm Register Value
  * @param Hours, Minutes and Seconds data
  * @retval : None
*******************************************************************************/

void SetAlarm(u8 Hour, u8 Minute, u8 Seconds)
{
	u32 CounterValue;
  
  CounterValue=((Hour * 3600) + (Minute * 60)+Seconds);
  
	if(CounterValue == 0)
	{
		CounterValue = SECONDS_IN_DAY;
	}

	RTC_WaitForLastTask();
	RTC_SetAlarm(CounterValue);
	RTC_WaitForLastTask();
}


/*******************************************************************************
  * @brief  DisplayTime
  * @param  None
  * @retval : None
*******************************************************************************/

void DisplayTime(void)
{
	
	SerPtr->printf("TIME: %d%d:%d%d:%d%d\n",		\
		s_TimeStructVar.HourHigh, s_TimeStructVar.HourLow,	\
		s_TimeStructVar.MinHigh, s_TimeStructVar.MinLow, \
		s_TimeStructVar.SecHigh, s_TimeStructVar.SecLow);
}

/*******************************************************************************
* @brief Displays the Date(DD/MM/YY and DAY ) on LCD
* @param None
* @retval :None
*******************************************************************************/
void DisplayDate(void)
{
	SerPtr->printf("DATE: %02d %s %04d ", 
						s_DateStructVar.Day,
						MonthsNames[s_DateStructVar.Month-1],
						s_DateStructVar.Year);

	switch(WeekDay(s_DateStructVar.Year,s_DateStructVar.Month,s_DateStructVar.Day))
	{
		case 0: SerPtr->printf("Sun \n");
		        break;
		case 1: SerPtr->printf("Mon \n");
		        break;
		case 2: SerPtr->printf("Tue \n");
		        break;
		case 3: SerPtr->printf("Wed \n");
		        break;
		case 4: SerPtr->printf("Thu \n");
		        break;
		case 5: SerPtr->printf("Fri \n");
		        break;
		case 6: SerPtr->printf("Sat \n");
		        break;
	}
}

/*******************************************************************************
  * @brief Determines the weekday
  * @param Year,Month and Day
  * @retval :Returns the CurrentWeekDay Number 0- Sunday 6- Saturday
*******************************************************************************/
u16 WeekDay(u16 CurrentYear, u8 CurrentMonth, u8 CurrentDay)
{
	u16 Temp1, Temp2, Temp3, Temp4, CurrentWeekDay;

	if(CurrentMonth < 3)
	{
		CurrentMonth = CurrentMonth + 12;
		CurrentYear = CurrentYear-1;
	}

	Temp1=(6*(CurrentMonth + 1))/10;
	Temp2=CurrentYear/4;
	Temp3=CurrentYear/100;
	Temp4=CurrentYear/400;
	CurrentWeekDay=CurrentDay + (2 * CurrentMonth) + Temp1 \
	 + CurrentYear + Temp2 - Temp3 + Temp4 +1;
	CurrentWeekDay = CurrentWeekDay % 7;

	return(CurrentWeekDay);
}


/**
  * @brief  Summer Time Correction routine
  * @param  None
  * @retval : None
  */
void SummerTimeCorrection(void)
{
	u8 CorrectionPending = 0;
	u8 CheckCorrect = 0;
  
  	if((s_SummerTimeCorrect & OCTOBER_FLAG_SET)!=0)
  	{
    	if((s_DateStructVar.Month==10) && (s_DateStructVar.Day >24 ))
    	{
      		for(CheckCorrect = 25;CheckCorrect <=s_DateStructVar.Day;CheckCorrect++)
      		{
        		if(WeekDay(s_DateStructVar.Year,s_DateStructVar.Month,CheckCorrect )==0)
        		{
         			if(CheckCorrect == s_DateStructVar.Day)
          			{
            			// Check if Time is greater than equal to 1:59:59
            			if(RTC_GetCounter()>=7199)
            			{
              				CorrectionPending=1;
            			}
          			}
          			else
					{
						CorrectionPending=1;
					}
         			break;
       			}
     		}
   		}
  		else if((s_DateStructVar.Month > 10))
		{
			CorrectionPending = 1;
		}
   		else if(s_DateStructVar.Month < 3)
   		{
     		CorrectionPending=1;
   		}
   		else if(s_DateStructVar.Month == 3)
   		{
     		if(s_DateStructVar.Day<24)
     		{
       			CorrectionPending=1;
     		}
     		else
	    	{
	       		for(CheckCorrect = 24; CheckCorrect<= s_DateStructVar.Day; CheckCorrect++)
	       		{
	         		if(WeekDay(s_DateStructVar.Year,s_DateStructVar.Month,CheckCorrect)==0)
	         		{
	           			if(CheckCorrect == s_DateStructVar.Day)
	           			{
	             			// Check if Time is less than 1:59:59 and year is not the same in which
	                		// March correction was done
	             			if((RTC_GetCounter() < 7199) && ((s_SummerTimeCorrect & 0x3FFF) != \
	                                   s_DateStructVar.Year))
	             			{
	               				CorrectionPending=1;
	             			}
	             			else
	             			{
	               				CorrectionPending=0;
	             			}
	             			break;
	            		}
	            		else
	            		{
	              			CorrectionPending=1;
	            		}
	          		}
	        	}
			}
    	}
  	}
  	else if((s_SummerTimeCorrect & MARCH_FLAG_SET)!=0)
  	{
    	if((s_DateStructVar.Month == 3) && (s_DateStructVar.Day >24 ))
    	{
      		for(CheckCorrect = 25;CheckCorrect <=s_DateStructVar.Day;\
         		CheckCorrect++)
      		{
        		if(WeekDay(s_DateStructVar.Year,s_DateStructVar.Month,\
           					CheckCorrect ) == 0)
        		{
          			if(CheckCorrect == s_DateStructVar.Day)
          			{
            			// Check if time is greater than equal to 1:59:59
            			if(RTC_GetCounter() >= 7199)
            			{
              				CorrectionPending = 1;
            			}
          			}
          			else
          			{
            			CorrectionPending=1;
          			}
        			break;
        		}
      		}
    	}
    	else if((s_DateStructVar.Month > 3) && (s_DateStructVar.Month < 10 ))
    	{
     		CorrectionPending = 1;
    	}
    	else if(s_DateStructVar.Month ==10)
    	{
      		if(s_DateStructVar.Day<24)
      		{
        		CorrectionPending=1;
      		}
      		else
	      	{
	        	for(CheckCorrect=24; CheckCorrect <= s_DateStructVar.Day;\
	          		CheckCorrect++)
		        {
		          	if(WeekDay(s_DateStructVar.Year, s_DateStructVar.Month,\
		            		CheckCorrect) == 0)
		          	{
		            	if(CheckCorrect == s_DateStructVar.Day)
			            {
			              	// Check if Time is less than 1:59:59 and year is not the same in
			              	// which March correction was done
			              	
			              	if((RTC_GetCounter() < 7199) && \
			                		((s_SummerTimeCorrect & 0x3FFF) != s_DateStructVar.Year))
				            {
				              	CorrectionPending=1;
				            }
			              	else
			              	{
			                	CorrectionPending=0;
			              	}
			            	break;
			            }
		          	}
		        }
	      	}
    	}
  	}

  	if(CorrectionPending == 1)
  	{
    	if((s_SummerTimeCorrect & OCTOBER_FLAG_SET)!=0)
		{
			// Subtract 1 hour from the current time
			RTC_SetCounter(RTC_GetCounter() - 3599);
			// Reset October correction flag
			s_SummerTimeCorrect &= 0xBFFF;
			// Set March correction flag
			s_SummerTimeCorrect |= MARCH_FLAG_SET;
			s_SummerTimeCorrect |= s_DateStructVar.Year;
			BKP_WriteBackupRegister(BKP_DR7, s_SummerTimeCorrect);
		}
    	else if((s_SummerTimeCorrect & MARCH_FLAG_SET)!=0)
    	{
     		// Add 1 hour to current time
     		RTC_SetCounter(RTC_GetCounter() + 3601);
     		// Reset March correction flag
     		s_SummerTimeCorrect &= 0x7FFF;
     		// Set October correction flag
     		s_SummerTimeCorrect |= OCTOBER_FLAG_SET;
     		s_SummerTimeCorrect |= s_DateStructVar.Year;
     		BKP_WriteBackupRegister(BKP_DR7, s_SummerTimeCorrect);
    	}
  	}
}

// RTC_SetPrescaler(32766); // RTC period = RTCCLK/RTC_PR = (32.768 KHz)/(32767+1)
// Prescaler is set to 32766 instead of 32768 to compensate for
// lower as well as higher frequencies*/
// Wait until last write operation on RTC registers has finished */
// RTC_WaitForLastTask();

u16 RTC_CalibrationFunc(s32 mHz)
{
	u8 CountWait = 0;
	u8 rtry = 0;
	u32 rRefClk;
	s32 f32_Deviation = 0;
	// Calulate Deviation in ppm  using the formula:
	//Deviation in ppm = (Deviation from 511.968/511.968)*1 million
START:

	rRefClk = (32766000L + rtry*1000)/64L;
	f32_Deviation = (mHz - rRefClk);

	if(f32_Deviation < 0) f32_Deviation *= -1;
	f32_Deviation = (f32_Deviation*10000000)/rRefClk;
	if( (f32_Deviation%10) >= 5) f32_Deviation = f32_Deviation + 10;
	f32_Deviation /= 10;

	// Frequency deviation in ppm should be les than equal to 121 ppm

	if(f32_Deviation <= 121)
	{
		while(CountWait < 128)
		{
			if(CalibrationPpm[CountWait] == f32_Deviation)
			break;
			CountWait++;
		}

		RTC_SetPrescaler(32765 + rtry); // RTC period = RTCCLK/RTC_PR = (32.768 KHz)/(32767+1)
		RTC_WaitForLastTask();

		BKP_SetRTCCalibrationValue(CountWait);
	}
	else // Frequency deviation in ppm is more than 121 ppm, hence calibration can not be done
	{
		if(rtry++ < 5) goto START;
	}

    return (u16)(f32_Deviation);
}


void RTC_IRQHandler(void)
{
	u8  Month = BKP_ReadBackupRegister(MONTH_DR);
	u8  Day = BKP_ReadBackupRegister(DAY_DR);
	u16 Year = BKP_ReadBackupRegister(YEAR_DR);

	INT32U cpu_sr;

	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
	OSIntNesting++;
	CPU_CRITICAL_EXIT();
  
	//NVIC_ClearPendingIRQ(RTC_IRQn);
	RTC_ClearITPendingBit(RTC_IT_SEC);
	// If counter is equal to 86399: one day was elapsed
	// This takes care of date change and resetting of counter in case of
	// power on - Run mode/ Main supply switched on condition
	if(RTC_GetCounter() == 86399)
	{
		RTC_WaitForLastTask();	//Wait until last write operation on RTC registers has finished */
		RTC_SetCounter(0x0);	//Reset counter value
		// Wait until last write operation on RTC registers has finished */
		RTC_WaitForLastTask();	// Increment the date
		DateUpdate();
	}
	
	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR

}

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
