
/*********************************************
* File Name          : exlib.c
* Author             : 
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define TEST_C

#include "../include/main.h"

void TestInit(void)
{
	OSTaskCreate(TestTask, (void *)NULL, (OS_STK *)&TestTaskStk[TEST_START_STK_SIZE - 1], TEST_START_PRIO);
}

void TestTask(void *p_arg)
{
	INT16U nCnt = 0;
	nCnt = nCnt;
	p_arg = p_arg;

	tTestFlag = FALSE;
	
	OSTimeDly(10L);

	while(1)
	{
		if(CheckSWConf() == 0x05 || iUser_Value2 == __ChangeDebug)
		{
			PrintLogo();
			PromptOut();
			
			while(CheckSWConf() == 0x05 || iUser_Value2 == __ChangeDebug)
			{
				if(SerPtr->CheckByte(1, &nCnt))
				{
					KeyProc(SerPtr->RxGetByte());
				}
				tTestFlag = TRUE;

				if(TimeOverCheck(Timer_DebugCnt))
				{
					iUser_Value2 = 0;
				}
				OSTimeDly(10L);
			}
		}

		tTestFlag = FALSE;
		OSTimeDly(100L*5L);
	}
}

void KeyProc( char sbuf )
{
	INT16U nSize = sizeof(tRevData);

	tRevData[tIndex%nSize] = sbuf;
	if( tRevData[tIndex%nSize] == 0x0D )			// Enter 입력
	{
		SerPtr->PutToBuffer('\r');
		SerPtr->PutToBuffer('\n');
		tRevData[tIndex%nSize] = '\0';
		OnCommand();
		tIndex = 0;
		return;
	}
	else if( tRevData[tIndex%nSize] == 0x08 )		// Back Space
	{
		if (tIndex == 0)
			return;

		SerPtr->PutToBuffer(0x08);
		SerPtr->PutToBuffer(' ');
		SerPtr->PutToBuffer(0x08);
		tIndex--;

		return;
	}
	SerPtr->PutToBuffer(tRevData[tIndex%nSize]);			// 입력 키 출력
	if(++tIndex >= nSize) tIndex = 0;
}

INT16U tmpAddr = 0;
//#define EEP_TEST_ADDR	128
#define EEP_TEST_ADDR	64

void OnCommand ( void )
{
	INT8U tdata = TRUE;

    tdata = tdata;
    
   	switch(tRevData[0])
   	{
		case '?':
			PrintLogo();
		break;
		case 'O':
		case 'o':
			{
				char *tstmsg = "Dig Output";
				
				if(tTest.Output)
				{
					tdata = returnmsgTest(tstmsg);
				}
				if(tdata)
				{
					INT32U nFlag = 0;
					INT16U nCnt;
	
					SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);
	
					TimerRegist(TimerTest, Time1Sec*60L*5L);
	
					while(1)
					{
						HwTestOutFunc(&nFlag);
	
						if(TimeOverCheck(TimerTest))
						{
							SerPtr->printf("%s test TimeOut\n", tstmsg);
							TimerRegist(TimerTest, Time1Sec);
							break;
						}
						if(SerPtr->CheckByte(1, &nCnt))
						{
							nCnt = SerPtr->RxGetByte();
							if(nCnt == 'C' || nCnt == 'c')
							{
								SerPtr->printf("%s test Canceled\n", tstmsg);
								break;
							}
							else if(nCnt == 'F' || nCnt == 'f')
							{
								INT32U cpu_sr;

								OS_ENTER_CRITICAL();
								{
									EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

									tTest.Output = TRUE;

									ptr->OutputTestBp = tTestOK;
									WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));									
								}
								OS_EXIT_CRITICAL();
								SerPtr->printf("%s test Finished\n", tstmsg);
								break;
							}
						}

						OSTimeDly(300L);
					}
				}
			}
		break;
		
		case 'A':
		case 'a':
		{
			char *tstmsg = "ADC/RAM";
			if(tTest.Analogin)
			{
				tdata = returnmsgTest(tstmsg);
			}
			if(tdata)
			{
				INT16U nCnt;

				SerPtr->printf("\n* [%s] TEST START TimeOut 5 Min]\n", tstmsg);

				TimerRegist(TimerTest, Time1Sec*60L*5L);

				while(1)
				{
					AdInputStatus();

					if(TimeOverCheck(TimerTest))
					{
						SerPtr->printf("%s Test TimeOut\n", tstmsg);

						TimerRegist(TimerTest, Time1Sec);
						break;
					}
					if(SerPtr->CheckByte(1, &nCnt))
					{
						nCnt = SerPtr->RxGetByte();
						if(nCnt == 'c' || nCnt == 'C')
						{
							SerPtr->printf("%s Test Canceled\n", tstmsg);
							break;
						}
						else if(nCnt == 'f' || nCnt == 'F')
						{
							INT32U cpu_sr;
							OS_ENTER_CRITICAL();
							{
								EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);

								tTest.Analogin = TRUE;
								ptr->AnalogTestBp = tTestOK;
								WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
							}
							OS_EXIT_CRITICAL();
							SerPtr->printf("%s Test Finished\n", tstmsg);
							break;
						}
					}
					OSTimeDly(2000L);
					/////////////////////////////////////////////////////////////
				}
			}
		}
		break;


		case 'I':
		case 'i':
		{
			char *tstmsg = "Dig Input";
			if(tTest.Input)
			{
				tdata = returnmsgTest(tstmsg);
			}
			if(tdata)
			{
				INT16U nCnt;

				SerPtr->printf("\n* [%s TEST START TimeOut 5 Min]\n", tstmsg);
				TimerRegist(TimerTest, Time1Sec*60L*5L);

				CurrentInputStatus(0);
				tinputStsOld = tinputSts;

				while(1)
				{
					CurrentInputStatus(1);

					if(TimeOverCheck(TimerTest))
					{
						SerPtr->printf("%s Test TimeOut\n", tstmsg);
						TimerRegist(TimerTest, Time1Sec);
						break;
					}
					if(SerPtr->CheckByte(1, &nCnt))
					{
						nCnt = SerPtr->RxGetByte();
						if(nCnt == 'c' || nCnt == 'C')
						{
							SerPtr->printf("%s Test Canceled\n", tstmsg);
							break;
						}
						else if(nCnt == 'f' || nCnt == 'F')
						{
							INT32U cpu_sr;

							OS_ENTER_CRITICAL();
							{
								EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
								
								tTest.Input = TRUE;
								ptr->InputTestBp = tTestOK;
								WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
							}
							OS_EXIT_CRITICAL();
							SerPtr->printf("%s Test Finished\n", tstmsg);
							break;
						}
					}
					OSTimeDly(300L);
					/////////////////////////////////////////////////////////////
				}
			}
		}				
		break;

		case 'C':
		case 'c':
			{
				char *tstmsg = "COM";
				if(tTest.Comm)
				{
					tdata = returnmsgTest(tstmsg);
				}
				if(tdata)
				{
					INT16U nCnt;
					
					SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);
	
					TimerRegist(TimerTest, Time1Sec*60L*5L);
	
					while(1)
					{
						COMTestFunc();

						if(TimeOverCheck(TimerTest))
						{
							SerPtr->printf("%s test Test TimeOut\n", tstmsg);
							TimerRegist(TimerTest, Time1Sec);
							break;
						}
	
						if(SerPtr->CheckByte(1, &nCnt))
						{
							nCnt = SerPtr->RxGetByte();
							if(nCnt == 'C' || nCnt == 'c')
							{
								SerPtr->printf("%s test Test Canceled\n", tstmsg);
								break;
							}
							else if(nCnt == 'F' || nCnt == 'f')
							{
								INT32U cpu_sr;

								OS_ENTER_CRITICAL();
								{
									EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
									tTest.Comm = TRUE;
									ptr->COMTestBp = tTestOK;
									WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
								}
								OS_EXIT_CRITICAL();
								SerPtr->printf("%s Test Test Finished\n", tstmsg);
								break;
							}
						}
						OSTimeDly(2000L);
					}
				}
			}
		break;
		
		case 'G':
		case 'g':
			DownloadFlagClr();
			ForDelay(20L);
			DownLoadBootingJump();
		break;
		
    	default:
		break;

	}
	PromptOut();
}


void AdcPrintf(char *sptr, INT16U rawData, INT8U is_5V)
{
	INT16U Data;
	if(is_5V) 	Data = AdctoVolt5opamp(rawData);
	else		Data = AdctoVolt33V(rawData);
	
	SerPtr->printf(STARMSG);
	SerPtr->printf("%s: %d.%d[V], [raw:%04d]", sptr, Data/10, Data%10, rawData);
	SerPtr->printf(ENTMSG);
}


INT8U returnmsgTest(char *str)
{
	SerPtr->printf("%s이 수행되어 있습니다. 계속 진행하시겠습니까?[Y]es, [C]ancel\n", str);
	return WaringMssageReturn();
}

INT8U WaringMssageReturn(void)
{
	INT16U nCnt;

	TimerRegist(TimerTest, Time1Sec*5L);

	while(1)
	{
		if(TimeOverCheck(TimerTest))
		{
			TimerRegist(TimerTest, Time1Sec*5L);
			return TRUE;
		}
		if(SerPtr->CheckByte(1, &nCnt))
		{
			nCnt = SerPtr->RxGetByte();
			if(nCnt == 'C' || nCnt == 'c')
			{
				SerPtr->printf("CANCEL TEST \n");
				return FALSE;
			}
			else return TRUE;
		}
		OSTimeDly(10L);
	}
}

void PrintLogo(void)
{
	EE_TABLE1 *ptr = vEE_TABLE1;

	
	if(ptr->OutputTestBp == tTestOK)		tTest.Output = TRUE;
	else									tTest.Output = FALSE;

	if(ptr->InputTestBp == tTestOK)  		tTest.Input = TRUE;
	else									tTest.Input = FALSE;

	if(ptr->COMTestBp == tTestOK)  			tTest.Comm = TRUE;
	else								    tTest.Comm = FALSE;

	if(ptr->AnalogTestBp == tTestOK)  		tTest.Analogin = TRUE;
	else								    tTest.Analogin = FALSE;

	if(ptr->eepromBp == tTestOK)  			tTest.eeprom = TRUE;
	else								    tTest.eeprom = FALSE;

	SerPtr->printf("\n\n");
	PrintStar();
	SerPtr->printf("* %s VER:%d.%d\n", BoardTestMode, (TRIO_M_SystemVer >> 4)& 0x0f,  TRIO_M_SystemVer & 0x0f);

	SerPtr->printf("    -COMMAND 1st-\n");
	SerPtr->printf("*  ?        : help(this message)\n");
    SerPtr->printf("*  C        : com test              [%s]\n", testResult[tTest.Comm]);
	SerPtr->printf("*  O        : output test           [%s]\n", testResult[tTest.Output]);
	SerPtr->printf("*  I        : input test            [%s]\n", testResult[tTest.Input]);
    SerPtr->printf("*  A        : ADC/RAM               [%s]\n", testResult[tTest.Analogin]);
    SerPtr->printf("*  F        : EERROM                [%s]\n", testResult[tTest.eeprom]);
	SerPtr->printf("*  G        : compulsory boot(eeprom)\n");
	PrintStar();
}

void PrintStar(void)
{
	SerPtr->printf("*******************************************************************************\n");
}

void PromptOut(void)
{
	SerPtr->printf("TRIO >>");
}


INT32U comtstcnt = 0;

void COMTestFunc(void)
{
	INT16U Recv;

	{
		pUSART1.printf(STARMSG);
		pUSART1.printf("통신시험 Ser4[MODEM] 시험을 체크하여 주세요     ");
		pUSART4.BuffClear();
		pUSART4.PutToBuffer(comtstcnt & 0x0f);		

		OSTimeDly(100L);

		if(pUSART4.CheckByte(1, &Recv))
		{
			if( pUSART4.RxGetByte() == (comtstcnt & 0x0f)// &&
				//pUSART3.RxGetByte() == 'b' &&
				//pUSART3.RxGetByte() == 'i' &&
				//pUSART3.RxGetByte() == 'z' &&
				//pUSART3.RxGetByte() == 'i'
				)
						pUSART1.printf("[OK]");
			else		pUSART1.printf("[FAIL 1]");
		}
		else pUSART1.printf("[FAIL 2]: %d", Recv);
		pUSART1.printf(ENTMSG);
	}
		

	pUSART1.printf(ENTMSG);
	pUSART1.printf(ENTMSG);
	comtstcnt++;
}


void AdInputStatus(void)
{
////////////////////////////////////////////////////////////////////////////////
	PrintStar();
	{
		SerPtr->printf("[2G]    : FwdOut[%04d],RvsOut [%04d]  [LTE]: FwdOut[%04d],RvsOut [%04d]\n",ADC_DATA[FwdOutAvgVolt_2G],ADC_DATA[RvsOutVolt_2G],ADC_DATA[FwdOutAvgVolt_LTE],ADC_DATA[RvsOutVolt_LTE]);	
		SerPtr->printf("CDMALTE : FwdIn [%04d],FwdOut [%04d]  RvsIn [%04d],RvsOut [%04d]\n",ADC_DATA[FwdInVolt_CDMALTE],ADC_DATA[FwdOutAvgVolt_CDMALTE],ADC_DATA[RvsInVolt_CDMALTE],ADC_DATA[RvsOutVolt_CDMALTE]);
		SerPtr->printf("3G      : FwdIn [%04d],FwdOut [%04d]  RvsIn [%04d],RvsOut [%04d]\n",ADC_DATA[FwdInVolt_3G],ADC_DATA[FwdOutAvgVolt_3G],ADC_DATA[RvsInVolt_3G],ADC_DATA[RvsOutVolt_3G]);
		SerPtr->printf("LTE_A1  : FwdOut[%04d],RvsOut [%04d]  LTE_A2  : FwdOut[%04d],RvsOut [%04d]\n",ADC_DATA[FwdOutAvgVolt_LTE_A1],ADC_DATA[RvsOutVolt_LTE_A1],ADC_DATA[FwdOutAvgVolt_LTE_A2],ADC_DATA[RvsOutVolt_LTE_A2]);	
		SerPtr->printf("LTE_A   : FwdIn [%04d],FwdOut [%04d]  RvsIn [%04d],RvsOut [%04d]\n",ADC_DATA[FwdInVolt_LTE_A],ADC_DATA[FwdOutAvgVolt_LTE_A],ADC_DATA[RvsInVolt_LTE_A],ADC_DATA[RvsOutVolt_LTE_A]);
		SerPtr->printf("LTE_1   : FwdIn [%04d],FwdOut [%04d]  RvsIn [%04d],RvsOut [%04d]\n",ADC_DATA[Fwd1InVolt_LTE],ADC_DATA[Fwd1OutAvgVolt_LTE],ADC_DATA[Rvs1InVolt_LTE],ADC_DATA[Rvs1OutVolt_LTE]);
		SerPtr->printf("LTE_A1_1: FwdOut[%04d],RvsOut [%04d]  LTE_A2_1: FwdOut[%04d],RvsOut [%04d]\n",ADC_DATA[Fwd1OutAvgVolt_LTE_A1],ADC_DATA[Rvs1OutVolt_LTE_A1],ADC_DATA[Fwd1OutAvgVolt_LTE_A2],ADC_DATA[Rvs1OutVolt_LTE_A2]);	
		SerPtr->printf("LTE_A_1 : FwdOut[%04d],RvsOut [%04d]  RvsIn [%04d],RvsOut [%04d]\n",ADC_DATA[FwdInVolt_LTE_A_1],ADC_DATA[FwdOutAvgVolt_LTE_A_1],ADC_DATA[RvsInVolt_LTE_A_1],ADC_DATA[RvsOutVolt_LTE_A_1]);	
		SerPtr->printf("Temp[%04d],DCOutVolt [%04d],PSUDCVolt [%04d]\n",ADC_DATA[Curr_Temp],ADC_DATA[DCOutVolt],ADC_DATA[PSUDCVolt]);	
	    
		OSTimeDly(30L);
	}
	PrintStar();
	SerPtr->printf("\n\n");
}


void CurrentInputStatus(INT8U vcheck)
{
	INT8U tcnt = 0;
	INT8U tval = FALSE;
    tcnt = tcnt;

	if(!vcheck)PrintStar();
	{
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_CDMALTE, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_LTE_A1_0, PHAMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_LTE_A2_0, PHAMSG, ENTMSG, vcheck);
		
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_WCDMA, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_LTE_1, PHAMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_LTE_A1_1, PHAMSG, ENTMSG, vcheck);

		tval += DigitalInputDiplay(tcnt++, PLLAlarm_LTE_A2_1, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, AC_Alarm, PHAMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, RRTYPE, PHAMSG, ENTMSG, vcheck);


	}

	if(!vcheck)PrintStar();
	if(vcheck)
	{
		if(tval) SerPtr->printf("\n");
	}
}

INT32U vstrval = 0;
INT8S vstr[64];

void HwTestOutFunc(INT32U *nFlag)
{
	INT32U MaxValue = 0xFFFF;
	INT8U Data = *nFlag;
	INT8U  i = 0;

    MaxValue = MaxValue;
    Data = Data;

///////////////////////////////////////////////////////////
//	Dig_Reset	
	GreenLED_CDMA		= 0;
	RedLED_CDMA			= 0;
	GreenLED_WCDMA		= 0;
	RedLED_WCDMA		= 0;
	GreenLED_LTE 		= 0;
	RedLED_LTE			= 0;
	GreenLED_LTE_A1_0	= 0;
	RedLED_LTE_A1_0		= 0;
	GreenLED_LTE_A2_0	= 0;
	RedLED_LTE_A2_0		= 0;	
	GreenLED_LTE_1 		= 0;
	RedLED_LTE_1 		= 0;
	GreenLED_LTE_A1_1	= 0;
	RedLED_LTE_A1_1		= 0;
	
	GreenLED_LTE_A2_1	= 0;
	RedLED_LTE_A2_1		= 0;
	
	AmpOnOff_CDMA		= 0;
	AmpOnOff_LTE_0		= 0;
	AmpOnOff_LTE_A1_0	= 0;
	AmpOnOff_LTE_A2_0	= 0;
	AmpOnOff_WCDMA		= 0;
	AmpOnOff_LTE_1		= 0;
	AmpOnOff_LTE_A2_1	= 0;
	AmpOnOff_LTE_A1_1	= 0;
	SMS_PWR = 0;

	PCA9555BitRst(_15M_Switch_LTE,		&AttnCS1Val); 

	for(i = 0;i < Att_SelMax ; i++)
	{
		AttnDataOutput(i, ~0);
	}

	switch(Data)
	{
		case 0:
			GreenLED_CDMA	= 1;
		break;
		
		case 1:
			RedLED_CDMA		= 1;
		break;

		case 2:
			GreenLED_LTE 	= 1;
		break;
		
		case 3:
			RedLED_LTE		= 1;
		break;			
		
		case 4:
			GreenLED_LTE_A2_0	= 1;
		break;
		
		case 5:
			RedLED_LTE_A2_0		= 1;
		break;	
		

		case 6:
			GreenLED_LTE_A1_0	= 1;
		break;
		
		case 7:
			RedLED_LTE_A1_0		= 1;
		break;	
		
		case 8:
			GreenLED_WCDMA	= 1;
		break;
		
		case 9:
			RedLED_WCDMA	= 1;
		break;			
		
		case 10:
			GreenLED_LTE_1		= 1;
		break;
		
		case 11:
			RedLED_LTE_1 		= 1;
		break;			
		
		case 12:
			GreenLED_LTE_A2_1	= 1;
		break;
		
		case 13:
			RedLED_LTE_A2_1		= 1;
		break;	


		case 14:
			GreenLED_LTE_A1_1	= 1;
		break;
		
		case 15:
			RedLED_LTE_A1_1		= 1;
		break;	

		
		case 16:
			AmpOnOff_CDMA		= 1;
		break;
		
		case 17:
			AmpOnOff_LTE_0		= 1;
		
		break;
		
		case 18:
			AmpOnOff_LTE_A1_0 	= 1;
		break;
		
		case 19:
			AmpOnOff_LTE_A2_0 	= 1;
		break;
		
		case 20:
			AmpOnOff_WCDMA 		= 1;
		break;
		
	
		case 21:
			AmpOnOff_LTE_1		= 1;
		break;
		
		case 22:
			AmpOnOff_LTE_A2_1	= 1;
		break;
		
		case 23:
			AmpOnOff_LTE_A1_1	= 1;
		break;

		case 24:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~1);
			}
		break;

		case 25:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~2);
			}
		break;

		case 26:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~4);
			}
		break;

		case 27:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~8);
			}
		break;

		case 28:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~16);
			}
		break;

		case 29:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~32);
			}
		break;

 		case 30:
			MaxValue = Data;
			//BuzzShort();
		break;
	}

	
	*nFlag = *nFlag + 1;

	if(*nFlag >= MaxValue) *nFlag = 0;

}

INT32U DigitalInputDiplay(INT8U num, INT8U ival,
							INT8U *fmsg, INT8U *emsg,
							INT8U vcheck)
{
	INT32U temp = FALSE;
	INT8U *currentptr = (INT8U *)&tinputSts;
	INT8U *beforeptr = (INT8U *)&tinputStsOld;

	// first
	if(!vcheck)
	{
		if(fmsg != NULL) SerPtr->printf("%s", fmsg);	// start // phase mssage
	}

	currentptr[num] = ival;

	{
		if( (vcheck && (beforeptr[num] != currentptr[num]) ) )
		{
			SerPtr->printf("%02d. ", num);
			SerPtr->printf("%s", tDisplay[num]);
			{
				if(ival) SerPtr->printf(OFFMSG);
				else	 SerPtr->printf(ONMSG);
			}
			temp = TRUE;
		}
		else if(!vcheck)
		{
			SerPtr->printf("%s", tDisplay[num]);
			{
				if(ival) SerPtr->printf(OFFMSG);
				else	 SerPtr->printf(ONMSG);
			}
		}
	}

////////////////////////////////////////////////////////////////////////////////
	if(vcheck)
	{
		if(temp)
		{
			OSTimeDly(1L);
			SerPtr->printf(ENTMSG);
		}
	}
	else
	{
		if(emsg)
		{
			OSTimeDly(1L);
			SerPtr->printf(ENTMSG);
		}
	}

	beforeptr[num] = currentptr[num];
	return (INT32U)temp;
}

///////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////

