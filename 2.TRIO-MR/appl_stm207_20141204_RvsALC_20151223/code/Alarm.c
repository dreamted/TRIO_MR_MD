/*********************************************
* File Name          : alarm.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/

#define ALARM_C

#include "../include/main.h"
 #include <stdlib.h>



void PeriodReportCheck(void)
{
	INT16U	PeriodSec = 1;
	
	if(TimeOverCheck(TimerPerReport))
	{
		TimePeriodElased++;
		TimerRegist(TimerPerReport, Time1Sec);	
	}

	if(TimePeriodElased >= PeriodSec)
	{
		TimePeriodElased = 0;
		
		if(!FirstCheckFlag)
		{
		//	*SmsDnrPreAlm = *(_SmsDnrAlarm *)SmsDnrAlarm;
		//	*SmsRmtPreAlm = *(_SmsRmtAlarm *)SmsRmtAlarm;
			
			FirstCheckFlag = TRUE;
		}
			
		SmsDnrAlarm_Check();
	}
}


void SmsDnrAlarm_Check(void)
{
	 if(chkDnrAlarmReport == SET)return;
	 if( DnrAlarmCheckUpdate(tDnrSts->AlarmMask) != 0)chkDnrAlarmReport = SET;
#if 0
		  SerPtr->printf("RvsOutUpperLmtFail_2G[%d]>[%d] [%d]>[%d][%d]\n",	PwrAlarm.RvsOutUpperLmtFail_2G, 
		  PwrAlarmChange.RvsOutUpperLmtFail_2G, 
		  PwrAlarmTimer.RvsOutUpperLmtFail_2G,
		  PwrAlarmChange.FwdAmpOnOff_2G,
		  PwrAlarmTimer.FwdAmpOnOff_2G);
#endif	 

#if 1
		  SerPtr->printf("RvsOutUpperLmtFail_LTE[%d]>[%d] [%d]>[%d][%d]\n",	PwrAlarm.RvsOutUpperLmtFail_LTE, 
		  PwrAlarmChange.RvsOutUpperLmtFail_LTE, 
		  PwrAlarmTimer.RvsOutUpperLmtFail_LTE,
		  PwrAlarmChange.FwdAmpOnOff_LTE,
		  PwrAlarmTimer.FwdAmpOnOff_LTE);
#endif	 


#if 0
	 SerPtr->printf("RvsOutUpperLmtFail_2G[%d][%d]: [%d][%d]>[%d]\n",  PwrAlarm.RvsOutUpperLmtFail_2G, 
	 PwrAlarmChange.RvsOutUpperLmtFail_2G, 
	 PwrAlarmTimer.RvsOutUpperLmtFail_2G,
 	 PwrAlarmCnt.RvsOutUpperLmtFail_2G,
	 PwrAlarmChange.FwdAmpOnOff_2G);
#endif	 
}

INT32U DnrAlarmCheckUpdate(INT8U TotMask)
{
	int i;

	INT8U *CurSts		= (INT8U *)&PwrAlarm;
	INT8U *PreSts		= (INT8U *)&PwrAlarmPre;
	INT8U *ChangeFlag	= (INT8U *)&PwrAlarmChange;
	INT8U *AlarmTimer	= (INT8U *)&PwrAlarmTimer;
	INT8U *AlarmCnt		= (INT8U *)&PwrAlarmCnt;

	INT8U DataLen	= sizeof(__PwrAlmStr)/1;

	INT8U tCnt = 0;

	for(i = 0; i < DataLen; i++)
	{
		tCnt += UPdateAlarm(CurSts + i, PreSts + i, ChangeFlag + i, AlarmTimer + i, AlarmCnt+ i);
	}
	
	if(TotMask)
	{
		return FALSE;	 // Mask 이면 check 하지 않는다.
	}

	if(tCnt != 0) return TRUE;
	return FALSE;
}

INT8U UPdateAlarm(INT8U *CurSts, INT8U *PreSts, INT8U *ChangeFlag, INT8U *AlarmTimer, INT8U *AlarmCnt)
{
//	*ChangeFlag = 0;
 	if( (*CurSts) ==  (*PreSts) )
	{
		*AlarmTimer = *AlarmCnt;
	}
	else
 	{
		if(*AlarmTimer == 0)
		{
			*PreSts = *CurSts;
			*ChangeFlag = 1;
			return TRUE;
		}
		else *AlarmTimer = *AlarmTimer - 1;
	}
	return FALSE;
}

void Table_Alarm(void)
{
	INT8U AlarmSum = 0;

	INT8U i;
	INT8U Pwr0TblAlarm = 0;
	INT8U Att0TblAlarm = 0;
	
 	
	for(i = Local_FwdOutAvgPwr_2G; i <= Local_PwrSts_Max; i++)
	{
		Pwr0TblAlarm 	+= OutPutTable_Alarm_check(i);
		//SerPtr->printf("Pwr0TblAlarm[%d]:[%d]\n", i, Pwr0TblAlarm);
	}

	for(i = Local_FwdAttn1_2G; i <= Local_AttnSts_Max; i++)
	{
		Att0TblAlarm 	+= AttTable_Alarm_check(i);
//		SerPtr->printf("Att0TblAlarm[%d]:[%d]\n", i, Att0TblAlarm);
	}

#if 1

	SerPtr->printf("PwrTblAlarm[%d][%d][%d][%d][%d],[%d][%d][%d][%d][%d],[%d][%d][%d][%d][%d],[%d][%d][%d][%d][%d]\n",
											PwrTblAlarm[0],PwrTblAlarm[1],PwrTblAlarm[2],PwrTblAlarm[3],PwrTblAlarm[4],
											PwrTblAlarm[5],PwrTblAlarm[6],PwrTblAlarm[7],PwrTblAlarm[8],PwrTblAlarm[9],
											PwrTblAlarm[10],PwrTblAlarm[11],PwrTblAlarm[12],PwrTblAlarm[13],PwrTblAlarm[14],
											PwrTblAlarm[15],PwrTblAlarm[16],PwrTblAlarm[17],PwrTblAlarm[18],PwrTblAlarm[19]);

	for(i = 0; i < Local_PwrSts_Max; i++)
	{
//		SerPtr->printf("PwrTblAlarm[%d]:[%d]\n", i, PwrTblAlarm[i]);
	}
	for(i = 0; i < Local_AttnSts_Max; i++)
	{
//		SerPtr->printf("Att0TblAlarm[%d]:[%d]\n", i, AttnTblAlarm[i]);
	}
#endif

	AlarmSum = Pwr0TblAlarm + Att0TblAlarm;

	if(AlarmSum)	tDnrSts->TableStatus = Alarm;
	else			tDnrSts->TableStatus = Normal;

}

INT8U OutPutTable_Alarm_check(INT8U tIndex)
{
	
	INT32S i = 0;
	INT8U rval = Normal;
	INT8S tPass = 0;

	PwrTblAlarm[tIndex] = Normal;

	{
		INT16U *dptr;
		INT32S limit;
		INT32S nsize;

		INT8S TblLmt;
		INT8S TblSize;


		if(tIndex == Local_FwdOutAvgPwr_2G)
		{
			dptr  = OutputTable->FwdOutAvgPwr_2G.Data;
			limit = OutputTable->FwdOutAvgPwr_2G.limit;
			nsize = OutputTable->FwdOutAvgPwr_2G.nsize;
			TblLmt  = FwdOutAvgPwr_2G_TblLmt;
			TblSize = FwdOutAvgPwr_2G_TblSize;
			OutputTable->FwdOutAvgPwr_2G.limit = TblLmt;
			OutputTable->FwdOutAvgPwr_2G.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_2G.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_2G.nsize = TblSize;
				rval = Alarm;
			}
////
#if 0
			TblLmt  = PwrTablelimitLocation(tIndex,0);
			if( TblLmtCheck(limit,TblLmt) == Alarm)		limit = TblLmt;
			TblSize = PwrTablelimitLocation(tIndex,1);
			if( TblLmtCheck(nsize,TblSize) == Alarm)	nsize = TblLmt;
#endif
//			SerPtr->printf("Local_FwdOutAvgPwr_2G[%d]:\n", rval);
		}
#if 1	
		else if(tIndex == Local_RvsOutPwr_2G)
		{
			dptr  = OutputTable->RvsOutPwr_2G.Data;
			limit = OutputTable->RvsOutPwr_2G.limit;
			nsize = OutputTable->RvsOutPwr_2G.nsize;
			TblLmt  = RvsOutPwr_2G_TblLmt;
			TblSize = RvsOutPwr_2G_TblSize;
			OutputTable->RvsOutPwr_2G.limit = TblLmt;
			OutputTable->RvsOutPwr_2G.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_2G.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_2G.nsize = TblSize;
				rval = Alarm;
			}
			
//			SerPtr->printf("Local_RvsOutPwr_2G[%d]:\n", rval);
		}
		else if(tIndex == Local_FwdOutAvgPwr_LTE)
		{
			dptr  = OutputTable->FwdOutAvgPwr_LTE.Data;
			limit = OutputTable->FwdOutAvgPwr_LTE.limit;
			nsize = OutputTable->FwdOutAvgPwr_LTE.nsize;
			TblLmt  = FwdOutAvgPwr_LTE_TblLmt;
			TblSize = FwdOutAvgPwr_LTE_TblSize;
			OutputTable->FwdOutAvgPwr_LTE.limit = TblLmt;
			OutputTable->FwdOutAvgPwr_LTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_LTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_LTE.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_RvsOutPwr_LTE)
		{
			dptr  = OutputTable->RvsOutPwr_LTE.Data;
			limit = OutputTable->RvsOutPwr_LTE.limit;
			nsize = OutputTable->RvsOutPwr_LTE.nsize;
			TblLmt  = RvsOutPwr_LTE_TblLmt;
			TblSize = RvsOutPwr_LTE_TblSize;
			OutputTable->RvsOutPwr_LTE.limit = TblLmt;
			OutputTable->RvsOutPwr_LTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_LTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_LTE.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_FwdInPwr_CDMALTE)
		{
			dptr  = OutputTable->FwdInPwr_CDMALTE.Data;
			limit = OutputTable->FwdInPwr_CDMALTE.limit;
			nsize = OutputTable->FwdInPwr_CDMALTE.nsize;
			TblLmt  = FwdInPwr_CDMALTE_TblLmt;
			TblSize = FwdInPwr_CDMALTE_TblSize;
			OutputTable->FwdInPwr_CDMALTE.limit = TblLmt;
			OutputTable->FwdInPwr_CDMALTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdInPwr_CDMALTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdInPwr_CDMALTE.nsize = TblSize;
				rval = Alarm;
			}
		}	
 		else if(tIndex == Local_FwdOutAvgPwr_CDMALTE)
		{
			dptr  = OutputTable->FwdOutAvgPwr_CDMALTE.Data;
			limit = OutputTable->FwdOutAvgPwr_CDMALTE.limit;
			nsize = OutputTable->FwdOutAvgPwr_CDMALTE.nsize;
			TblLmt  = FwdOutAvgPwr_CDMALTE_TblLmt;
			TblSize = FwdOutAvgPwr_CDMALTE_TblSize;
			OutputTable->FwdOutAvgPwr_CDMALTE.limit = TblLmt;
			OutputTable->FwdOutAvgPwr_CDMALTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_CDMALTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_CDMALTE.nsize = TblSize;
				rval = Alarm;
			}
		}
		else if(tIndex == Local_RvsInPwr_CDMALTE)
		{
			dptr = OutputTable->RvsInPwr_CDMALTE.Data;
			limit = OutputTable->RvsInPwr_CDMALTE.limit;
			nsize = OutputTable->RvsInPwr_CDMALTE.nsize;
			TblLmt  = RvsInPwr_CDMALTE_TblLmt;
			TblSize = RvsInPwr_CDMALTE_TblSize;
			OutputTable->RvsInPwr_CDMALTE.limit = TblLmt;
			OutputTable->RvsInPwr_CDMALTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsInPwr_CDMALTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsInPwr_CDMALTE.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_RvsOutPwr_CDMALTE)
		{
			dptr  = OutputTable->RvsOutPwr_CDMALTE.Data;
			limit = OutputTable->RvsOutPwr_CDMALTE.limit;
			nsize = OutputTable->RvsOutPwr_CDMALTE.nsize;
			TblLmt  = RvsOutPwr_CDMALTE_TblLmt;
			TblSize = RvsOutPwr_CDMALTE_TblSize;
			OutputTable->RvsOutPwr_CDMALTE.limit = TblLmt;
			OutputTable->RvsOutPwr_CDMALTE.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_CDMALTE.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_CDMALTE.nsize = TblSize;
				rval = Alarm;
			}
		}	

		else if(tIndex == Local_FwdOutAvgPwr_LTE_A2)
		{
			dptr  = OutputTable->FwdOutAvgPwr_LTE_A2.Data;
			limit = OutputTable->FwdOutAvgPwr_LTE_A2.limit;
			nsize = OutputTable->FwdOutAvgPwr_LTE_A2.nsize;
			TblLmt  = FwdOutAvgPwr_LTE_A2_TblLmt;
			TblSize = FwdOutAvgPwr_LTE_A2_TblSize;
			OutputTable->FwdOutAvgPwr_LTE_A2.limit = TblLmt;
			OutputTable->FwdOutAvgPwr_LTE_A2.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_LTE_A2.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_LTE_A2.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_RvsOutPwr_LTE_A2)
		{
			dptr  = OutputTable->RvsOutPwr_LTE_A2.Data;
			limit = OutputTable->RvsOutPwr_LTE_A2.limit;
			nsize = OutputTable->RvsOutPwr_LTE_A2.nsize;
			TblLmt  = RvsOutPwr_LTE_A2_TblLmt;
			TblSize = RvsOutPwr_LTE_A2_TblSize;
			OutputTable->RvsOutPwr_LTE_A2.limit = TblLmt;
			OutputTable->RvsOutPwr_LTE_A2.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_LTE_A2.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_LTE_A2.nsize = TblSize;
				rval = Alarm;
			}
		}
 		else if(tIndex == Local_FwdInPwr_LTE_A)
		{
			dptr  = OutputTable->FwdInPwr_LTE_A.Data;
			limit = OutputTable->FwdInPwr_LTE_A.limit;
			nsize = OutputTable->FwdInPwr_LTE_A.nsize;
			TblLmt  = FwdInPwr_LTE_A_TblLmt;
			TblSize = FwdInPwr_LTE_A_TblSize;
			OutputTable->FwdInPwr_LTE_A.limit = TblLmt;
			OutputTable->FwdInPwr_LTE_A.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdInPwr_LTE_A.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdInPwr_LTE_A.nsize = TblSize;
				rval = Alarm;
			}
			
		}
#if 0		
		else if(tIndex == Local_FwdOutAvgPwr_LTE_A)/////xxxx
		{
			dptr  = OutputTable->FwdOutAvgPwr_LTE_A.Data;
			limit = OutputTable->FwdOutAvgPwr_LTE_A.limit;
			nsize = OutputTable->FwdOutAvgPwr_LTE_A.nsize;
			TblLmt  = FwdOutAvgPwr_2G_TblLmt;
			TblSize = FwdOutAvgPwr_2G_TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_LTE_A.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_LTE_A.nsize = TblSize;
				rval = Alarm;
			}
		}	
#endif		

		else if(tIndex == Local_RvsInPwr_LTE_A)
		{
			dptr  = OutputTable->RvsInPwr_LTE_A.Data;
			limit = OutputTable->RvsInPwr_LTE_A.limit;
			nsize = OutputTable->RvsInPwr_LTE_A.nsize;
			TblLmt  = RvsInPwr_LTE_A_TblLmt;
			TblSize = RvsInPwr_LTE_A_TblSize;
			OutputTable->RvsInPwr_LTE_A.limit = TblLmt;
			OutputTable->RvsInPwr_LTE_A.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsInPwr_LTE_A.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsInPwr_LTE_A.nsize = TblSize;
				rval = Alarm;
			}
		}	
		#if 0
		else if(tIndex == Local_RvsOutPwr_LTE_A)
		{
			dptr  = OutputTable->RvsOutPwr_LTE_A.Data;
			limit = OutputTable->RvsOutPwr_LTE_A.limit;
			nsize = OutputTable->RvsOutPwr_LTE_A.nsize;
			TblLmt  = RvsOutPwr_LTE_A_TblLmt;
			TblSize = RvsOutPwr_LTE_A_TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_LTE_A.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_LTE_A.nsize = TblSize;
				rval = Alarm;
			}
		}
		#endif
		#if 0
		else if(tIndex == Local_Rvs1InPwr_LTE_A)/////xxxxxx
		{
			dptr  = OutputTable->Rvs1InPwr_LTE_A.Data;
			limit = OutputTable->Rvs1InPwr_LTE_A.limit;
			nsize = OutputTable->Rvs1InPwr_LTE_A.nsize;
			TblLmt  = FwdOutAvgPwr_2G_TblLmt;
			TblSize = FwdOutAvgPwr_2G_TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->Rvs1InPwr_LTE_A.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->Rvs1InPwr_LTE_A.nsize = TblSize;
				rval = Alarm;
			}
		}
		#endif
		else if(tIndex == Local_FwdInPwr_3G)
		{
			dptr  = OutputTable->FwdInPwr_3G.Data;
			limit = OutputTable->FwdInPwr_3G.limit;
			nsize = OutputTable->FwdInPwr_3G.nsize;
			TblLmt  = FwdInPwr_3G_TblLmt;
			TblSize = FwdInPwr_3G_TblSize;
			OutputTable->FwdInPwr_3G.limit = TblLmt;
			OutputTable->FwdInPwr_3G.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdInPwr_3G.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdInPwr_3G.nsize = TblSize;
				rval = Alarm;
			}
		}
		else if(tIndex == Local_FwdOutAvgPwr_3G)
		{
			dptr  = OutputTable->FwdOutAvgPwr_3G.Data;
			limit = OutputTable->FwdOutAvgPwr_3G.limit;
			nsize = OutputTable->FwdOutAvgPwr_3G.nsize;
			TblLmt  = FwdOutAvgPwr_3G_TblLmt;
			TblSize = FwdOutAvgPwr_3G_TblSize;
			OutputTable->FwdOutAvgPwr_3G.limit = TblLmt;
			OutputTable->FwdOutAvgPwr_3G.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_3G.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->FwdOutAvgPwr_3G.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_RvsInPwr_3G)
		{
			dptr  = OutputTable->RvsInPwr_3G.Data;
			limit = OutputTable->RvsInPwr_3G.limit;
			nsize = OutputTable->RvsInPwr_3G.nsize;
			TblLmt  = RvsInPwr_3G_TblLmt;
			TblSize = RvsInPwr_3G_TblSize;
			OutputTable->RvsInPwr_3G.limit = TblLmt;
			OutputTable->RvsInPwr_3G.nsize = TblSize;

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsInPwr_3G.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsInPwr_3G.nsize = TblSize;
				rval = Alarm;
			}
		}	
		else if(tIndex == Local_RvsOutPwr_3G)
		{
			dptr  = OutputTable->RvsOutPwr_3G.Data;
			limit = OutputTable->RvsOutPwr_3G.limit;
			nsize = OutputTable->RvsOutPwr_3G.nsize;
			TblLmt  = RvsOutPwr_3G_TblLmt;
			TblSize = RvsOutPwr_3G_TblSize;
			OutputTable->RvsOutPwr_3G.limit = TblLmt;
			OutputTable->RvsOutPwr_3G.nsize = TblSize;
			
//			SerPtr->printf("nsize[%d]:[%d][%d]\n", tIndex,nsize,TblSize);

			if((limit < (TblLmt - 5*2))	||(limit > (TblLmt + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_3G.limit = TblLmt;
				rval = Alarm;
			}
			if((nsize < (TblSize - 5*2))||(nsize > (TblSize + 2*2)))
			{
				if(tTblAlmInit)OutputTable->RvsOutPwr_3G.nsize = TblSize;
				rval = Alarm;
			}
		}
		else
		{

			tPass = SET;

		}
#endif		 

		if( tPass != SET)
		{
			for(i = 0; i < nsize && i < OutputTBL_Size; i++)
			{
				if((dptr[i] > 3500)||(dptr[i] < 100))	
				{
					rval = Alarm;  

				}
				if(i)
				{
					if( dptr[i-1] < dptr[i] )			
					{
						rval = Alarm;  
					}
				}
			}
		}
	
//		if((nsize < 10)||(nsize > OutputTBL_Size))	rval = Alarm;

		PwrTblAlarm[tIndex] = rval;


	}

	return rval;
}
 INT8U AttTable_Alarm_check(INT8U tIndex)
{
	INT32S i = 0;
	INT8U rval = Normal;
	INT8S *dptr;
	INT8U nsize;
	INT8S tPass = 0;
	AttnTblAlarm[tIndex] = Normal;

	if(tIndex == Local_FwdAttn1_2G)
	{
		dptr = AttnOffsetTable->FwdAttn1_2G.Data;
		nsize = AttnOffsetTable->FwdAttn1_2G.nsize;
	}
	else if (tIndex == Local_RvsAttn1_2G)
	{
		dptr = AttnOffsetTable->RvsAttn1_2G.Data;
		nsize = AttnOffsetTable->RvsAttn1_2G.nsize;
	}	
	else if (tIndex == Local_RvsAttn2_2G)
	{
		
		dptr = AttnOffsetTable->RvsAttn2_2G.Data;
		nsize = AttnOffsetTable->RvsAttn2_2G.nsize;
	}	
	else if (tIndex == Local_RvsAttn3_2G)
	{
		dptr = AttnOffsetTable->RvsAttn3_2G.Data;
		nsize = AttnOffsetTable->RvsAttn3_2G.nsize;
	}	
	else if (tIndex == Local_FwdAttn1_LTE)
	{
		dptr = AttnOffsetTable->FwdAttn1_LTE.Data;
		nsize = AttnOffsetTable->FwdAttn1_LTE.nsize;
	}	
	else if (tIndex == Local_RvsAttn1_LTE)
	{
		dptr = AttnOffsetTable->RvsAttn1_LTE.Data;
		nsize = AttnOffsetTable->RvsAttn1_LTE.nsize;
	}	
	else if (tIndex == Local_RvsAttn2_LTE)
	{
		dptr = AttnOffsetTable->RvsAttn2_LTE.Data;
		nsize = AttnOffsetTable->RvsAttn2_LTE.nsize;
	}	
	else if (tIndex == Local_RvsAttn3_LTE)
	{
		dptr = AttnOffsetTable->RvsAttn3_LTE.Data;
		nsize = AttnOffsetTable->RvsAttn3_LTE.nsize;
	}	
	else if (tIndex == Local_FwdAttn1_CDMALTE)
	{
		dptr = AttnOffsetTable->FwdAttn1_CDMALTE.Data;
		nsize = AttnOffsetTable->FwdAttn1_CDMALTE.nsize;
	}	
	else if (tIndex == Local_RvsAttn1_CDMALTE)
	{
		dptr = AttnOffsetTable->RvsAttn1_CDMALTE.Data;
		nsize = AttnOffsetTable->RvsAttn1_CDMALTE.nsize;
	}	
	else if (tIndex == Local_FwdAttn1_LTE_A2)
	{
		dptr = AttnOffsetTable->FwdAttn1_LTE_A2.Data;
		nsize = AttnOffsetTable->FwdAttn1_LTE_A2.nsize;
	}	
	else if (tIndex == Local_FwdAttn2_LTE_A2)
	{
		dptr = AttnOffsetTable->FwdAttn2_LTE_A2.Data;
		nsize = AttnOffsetTable->FwdAttn2_LTE_A2.nsize;
	}	
	else if (tIndex == Local_RvsAttn1_LTE_A2)
	{
		dptr = AttnOffsetTable->RvsAttn1_LTE_A2.Data;
		nsize = AttnOffsetTable->RvsAttn1_LTE_A2.nsize;
	}	
	else if (tIndex == Local_RvsAttn2_LTE_A2)
	{
		dptr = AttnOffsetTable->RvsAttn2_LTE_A2.Data;
		nsize = AttnOffsetTable->RvsAttn2_LTE_A2.nsize;
	}	
	else if (tIndex == Local_RvsAttn3_LTE_A2)
	{
		dptr = AttnOffsetTable->RvsAttn3_LTE_A2.Data;
		nsize = AttnOffsetTable->RvsAttn3_LTE_A2.nsize;
	}	
	else if (tIndex == Local_RvsAttn4_LTE_A2)
	{
		dptr = AttnOffsetTable->RvsAttn4_LTE_A2.Data;
		nsize = AttnOffsetTable->RvsAttn4_LTE_A2.nsize;
	}	
	else if (tIndex == Local_FwdAttn1_3G)
	{
		dptr = AttnOffsetTable->FwdAttn1_3G.Data;
		nsize = AttnOffsetTable->FwdAttn1_3G.nsize;
	}	
	else if (tIndex == Local_FwdAttn2_3G)
	{
		dptr = AttnOffsetTable->FwdAttn2_3G.Data;
		nsize = AttnOffsetTable->FwdAttn2_3G.nsize;
	}	
	else if (tIndex == Local_RvsAttn1_3G)
	{
		dptr = AttnOffsetTable->RvsAttn1_3G.Data;
		nsize = AttnOffsetTable->RvsAttn1_3G.nsize;
	}	
	else if (tIndex == Local_RvsAttn2_3G)
	{
		dptr = AttnOffsetTable->RvsAttn2_3G.Data;
		nsize = AttnOffsetTable->RvsAttn2_3G.nsize;
	}	
	else if (tIndex == Local_RvsAttn3_3G)
	{
		dptr = AttnOffsetTable->RvsAttn3_3G.Data;
		nsize = AttnOffsetTable->RvsAttn3_3G.nsize;
	}	
	else if (tIndex == Local_RvsAttn4_3G)
	{
		dptr = AttnOffsetTable->RvsAttn4_3G.Data;
		nsize = AttnOffsetTable->RvsAttn4_3G.nsize;
	}	
	else
	{
		tPass = SET;
	}	
 
	if(tPass == RESET)
	{
 	
		for(i = 0;i < AttTBL_Size; i++)
		{
			if(abs(dptr[i]) > 10)	rval = Alarm;
//			SerPtr->printf("Att0TblAlarm[%d][%d]:[%d]\n", i, dptr[i],rval);
		}
		
		if((nsize < 10)||(nsize > AttTBL_Size))  rval = Alarm;	

		AttnTblAlarm[tIndex]= rval;
	}
 	return rval;
}


INT16S TableOffset(INT16S Temp, INT16S Temp10x, INT16S Offset, INT16S *Ret10x)
{
	INT8S DectVal = 0;

	DectVal = Temp + Offset;
	*Ret10x = Temp10x + (Offset*10);
	
	return (DectVal);
}



INT8U LimitAlarmUpdate( INT8U CurrAlarm, INT8U PreAlarm, INT16U AlarmIndex)
{
	if(CurrAlarm != PreAlarm)
	{
		LimitAlarmCnt[AlarmIndex]++;
		
		if(LimitAlarmCnt[AlarmIndex] > AlarmCheckTime)
		{
			LimitAlarmCnt[AlarmIndex] = 0;
			
			return CurrAlarm;
		}
	}
	else LimitAlarmCnt[AlarmIndex] = 0;

	return PreAlarm;
}


INT8U OffsetLmtCheck(INT8S Value,INT8S Offset)
{
	INT8U rval = Normal;

	if(abs(Value) > Offset)	rval = Alarm;

	return rval;
}


INT8U TblLmtCheck(INT8S tlimit,INT8S tTblLimit)
{
	INT8U tmp = Normal;;

	if((tlimit < (tTblLimit - 5*2)) ||(tlimit > (tTblLimit + 2*2)))tmp = Alarm;
	
	return tmp;
}

INT8U HighLimitCheck1(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl)
{
	INT8U tmp = 0;

 		 if(DetLvl >= LimitLvl)		tmp = Alarm;
	else if(DetLvl <= RecoveryLvl)	tmp = Normal;
	
	return tmp;
}



INT8U LowLimitCheck1(INT16S DetLvl,INT16S LimitLvl,INT16S RecoveryLvl)
{
	INT8U tmp = 0;

 	     if(DetLvl <= LimitLvl)		tmp =  Alarm;
	else if(DetLvl >= RecoveryLvl)	tmp = Normal;

	return tmp;
}


INT8U HighLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm)
{
 	     if(DetLvl >= LimitLvl)				return Alarm;
	else if(DetLvl <= LimitLvl - Offset)	return Normal;

	return CurrentAlarm;

}

INT8U LowLimitCheck(INT16S DetLvl,INT16S LimitLvl,INT16S Offset, INT8U CurrentAlarm)
{
 	     if(DetLvl <= LimitLvl)	return Alarm;
	else if(DetLvl >= LimitLvl + Offset)return Normal;

	return CurrentAlarm;

}

INT8S RetSMStoNormalData(INT8U Data)
{
	INT8S rVal = Data & 0x3f;

	if(BitRead(Data, 6))rVal = -rVal;

	return rVal;
}

INT8U RetNormaltoSMSData(INT8S Data)
{
	INT8S rVal = 0;

	if(Data < 0)
	{
		rVal = -Data;
		BitSet(rVal, 6);
	}
	else rVal = Data;
	
	return rVal;
}


INT8U RetSmsOffVal(INT8U OnOff)
{
	INT8U rVal;
	
	rVal = (~(OnOff - '0')) & 0x01;

	return rVal;
}
