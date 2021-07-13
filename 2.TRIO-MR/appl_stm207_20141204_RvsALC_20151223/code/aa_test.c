
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : exlib.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
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
//	INT32U nFlag = 0;
    nCnt = nCnt;
	gTestFlag = FALSE;
	
	OSTimeDly(TEST_START_PRIO*100L);
	
	while(1)
	{
		if(iUser_Value2 == __ChangeDebug)
		{
			PrintLogo();
			PromptOut();
			gTestFlag = TRUE;
	
			while(iUser_Value2 == __ChangeDebug)
			{
				if(SerPtr->CheckByte(1, &nCnt))
				{
					KeyProc(SerPtr->RxGetByte(), OnCommand);
				}

				if(TimeOverCheck(Timer_DebugCnt)) DownLoadBootingJump();
				OSTimeDly(10u);
			}
		}
//		HwTestOutFunc(&nFlag);

		OSTimeDly(200L);
	}
}

void KeyProc( char sbuf, void (*func)(void))
{
	INT16U nSize = sizeof(tRevData);

	tRevData[tIndex%nSize] = sbuf;
	if( tRevData[tIndex%nSize] == 0x0D )			// Enter 입력
	{
		SerPtr->PutToBuffer('\r');
		SerPtr->PutToBuffer('\n');
		tRevData[tIndex%nSize] = '\0';

		if(tIndex != 0)
		{
			strcpy((char *)PrevData[PrevWRCnt++], (const char *)tRevData);
			PrevWRCnt %= 5;
		}
		PrevRDCnt = PrevWRCnt;
		func();
		tIndex = 0;

		return;
	}
	else if(tRevData[tIndex%nSize] == 0x08) // Back Space
	{
		if (tIndex == 0)
			return;

		SerPtr->PutToBuffer(0x08);
		SerPtr->PutToBuffer(' ');
		SerPtr->PutToBuffer(0x08);
		tIndex--;

		return;
	}
	else if( tRevData[tIndex%nSize] == 0x09 )	// tab
	{
		while(tIndex)
		{
			SerPtr->PutToBuffer(0x08);
			SerPtr->PutToBuffer(' ');
			SerPtr->PutToBuffer(0x08);
			tIndex--;
		}

		PrevRDCnt--;
		if(PrevRDCnt < 0) PrevRDCnt = 4;
		strcpy((char *)tRevData, (const char *)PrevData[PrevRDCnt]);

		SerPtr->printf("%s", PrevData[PrevRDCnt]);
		tIndex = strlen((const char *)PrevData[PrevRDCnt]);

		return;
	}
	
	SerPtr->PutToBuffer(tRevData[tIndex%nSize]);			// 입력 키 출력

	if(++tIndex >= nSize) tIndex = 0;
}

INT8U htob(INT8U hex)
{
	INT8U i;
	
	if (hex >= '0' && hex <= '9') i=hex-'0';
	else if ( hex >= 'A' && hex <= 'F' )i=hex-'A'+10;
	else i=hex-'a'+10;
	
	return i;
}

INT8U dGetHex (INT8U Data_H, INT8U Data_L)
{
	INT8U i;
	
	i=htob( Data_H );
	i=htob( Data_L )+(i<<4);
	return i;
}

void TestCommand(void)
{

	INT8U tdata = FALSE;
	
	if(tRevData[0] == 't' && tRevData[1] == 'e' && tRevData[2] == 's' && tRevData[3] == 't') tdata = TRUE;
	if(tRevData[0] == 'T' && tRevData[1] == 'E' && tRevData[2] == 'S' && tRevData[3] == 'T') tdata = TRUE;

	if(tdata){
		iUser_Value2 = __ChangeDebug;
		iDebugCnt = 0; 
		TimerRegist(Timer_DebugCnt, Time1Min*30L);
		TimerRegist(TimerSioRx, Time100mSec);
	}
	PromptOut();
}



void OnCommand ( void )
{
	INT8U tdata = TRUE;
	
	switch(tRevData[0])
	{
		case '?':
			PrintLogo();
		break;
		
		case 'A':
		case 'a':
		{
			char *tstmsg = "ADC Input";

			
			if(SavetoTestBackup(ADCTest, SET, NULL) == SET)
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
//							gOK:
							SerPtr->printf("%s Test Finished\n", tstmsg);
							SavetoTestBackup(ADCTest, SET, SET);
							break;
						}
					}
					OSTimeDly(2000L);
					/////////////////////////////////////////////////////////////
				}
			}
		}
		break;

		case 'O':
		case 'o':
			{
				char *tstmsg = "Dig Output";
				
				if(SavetoTestBackup(OutputTest, SET, NULL) == SET)
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
								SerPtr->printf("%s test Finished\n", tstmsg);
								SavetoTestBackup(OutputTest, SET, SET);
								break;
							}
						}
						OSTimeDly(250L*1L);
						/////////////////////////////////////////////////////////////						
					}
				}
			}
		break;

		case 'I':
		case 'i':
			{
				char *tstmsg = "Dig Input";

				if(SavetoTestBackup(InputTest, SET, NULL) == SET)
				{
					tdata = returnmsgTest(tstmsg);
				}
				if(tdata)
				{
					INT16U nCnt;
	
					SerPtr->printf("\n* [%s TEST START TimeOut 5 Min]\n", tstmsg);
					TimerRegist(TimerTest, Time1Sec*60L*1L);
	
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
								SerPtr->printf("%s Test Finished\n", tstmsg);
								SavetoTestBackup(InputTest, SET, SET);
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
				char *tstmsg = "COM 시험";
				
				if(SavetoTestBackup(CommTest, SET, NULL) == SET)
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
								
								SerPtr->printf("%s Test Test Finished\n", tstmsg);
								SavetoTestBackup(CommTest, SET, SET);
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

		case 'E':
		case 'e':
#if 0         
		{
			EE_TABLE1 *ptr = &gEE_TABLE1;
			INT32U AddrOffset = vEE_TABLE1Addr + (INT32U)&(ptr->BdTestBp) - (INT32U )&gEE_TABLE1;

			if(SavetoTestBackup(EepromTest, SET, NULL) == SET)
			{
				char *tstmsg = "EEPROM(AT24C64) 시험";
				tdata = returnmsgTest(tstmsg);
			}

			if(tdata)
			{
				WriteEEprom(At24cDevID, AddrOffset + EepromResult, 'e', 0);
				tdata = ReadEEprom(At24cDevID, AddrOffset + EepromResult, 0);

				SerPtr->printf("\n\nWriting 24C64_Addr[%d] = 'e' -> ", AddrOffset);
				if(tdata == 'e'){
					SerPtr->printf("success read_data = [%c][0x%02x]\n\n", tdata, tdata);
					SavetoTestBackup(EepromTest, SET, SET);
				}
				else{
					SerPtr->printf("failed  read_data = [%d][0x%02x]\n\n", tdata, tdata);
					SavetoTestBackup(EepromTest, RESET, SET);
				}
			}
		}
#endif       
		break;		

		case 'S':
		case 's':
			SerPtr->printf("\n Default Back-up End -> Reboot...  \n\n");

			DefaultTable();
			ForDelay(20L);
			DownLoadBootingJump();
		break;
		
		default:
		break;

	}
	PromptOut();
}


void AdInputStatus(void)
{
////////////////////////////////////////////////////////////////////////////////
#if 1
	if(ADC_CheckFinish(ADC_Channel_0))		ADC_ChannelEnable(ADC_Channel_0);
	if(ADC_CheckFinish(ADC_Channel_1))		ADC_ChannelEnable(ADC_Channel_1);
	if(ADC_CheckFinish(ADC_Channel_2))		ADC_ChannelEnable(ADC_Channel_2);
	if(ADC_CheckFinish(ADC_Channel_3))		ADC_ChannelEnable(ADC_Channel_3);
	if(ADC_CheckFinish(ADC_Channel_4))		ADC_ChannelEnable(ADC_Channel_4);
	if(ADC_CheckFinish(ADC_Channel_5))		ADC_ChannelEnable(ADC_Channel_5);
	if(ADC_CheckFinish(ADC_Channel_6))		ADC_ChannelEnable(ADC_Channel_6);
	if(ADC_CheckFinish(ADC_Channel_7))		ADC_ChannelEnable(ADC_Channel_7);
	if(ADC_CheckFinish(ADC_Channel_8))		ADC_ChannelEnable(ADC_Channel_8);
	if(ADC_CheckFinish(ADC_Channel_9))		ADC_ChannelEnable(ADC_Channel_9);
	if(ADC_CheckFinish(ADC_Channel_10))		ADC_ChannelEnable(ADC_Channel_10);
	if(ADC_CheckFinish(ADC_Channel_11))		ADC_ChannelEnable(ADC_Channel_11);
	if(ADC_CheckFinish(ADC_Channel_12))		ADC_ChannelEnable(ADC_Channel_12);
	if(ADC_CheckFinish(ADC_Channel_13))		ADC_ChannelEnable(ADC_Channel_13);
	if(ADC_CheckFinish(ADC_Channel_14))		ADC_ChannelEnable(ADC_Channel_14);
	if(ADC_CheckFinish(ADC_Channel_15))		ADC_ChannelEnable(ADC_Channel_15);
#endif	

//	SerPtr->printf("ADC_Channel_0[%04d]\n", 	ADC_DATA1[FwdOutAvgVolt_2G],	ADC_DATA1[RvsOutVolt_2G],ADC_DATA1[FwdOutAvgVolt_LTE],ADC_DATA1[RvsOutVolt_LTE]);	

//	Data = AdctoVolt5opamp(ADC_AVR[adcFWDPWRdect_3G][0]);

	PrintStar();
	

#if 1
	{

		INT16S Data, tmpx;

//		Data = AdctoVolt33V(ADC_SUM[ADC_Channel_14]);
		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_0][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN0] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_1][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN1] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_2][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN2] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_3][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN3] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_4][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN4] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_5][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN5] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_6][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN6] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_7][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN7] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_8][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN8] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_9][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN9] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_10][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN10] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_11][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN11] : %d.%03d[V]\n", Data/1000, Data%1000);


		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_12][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN12] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_13][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN13] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_14][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN14] : %d.%03d[V]\n", Data/1000, Data%1000);

//		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_15][0]);
		Data = (ADC_AVR[ADC_Channel_15][0]);
		tmpx = ReadEnvTempTable(Data);
		SerPtr->printf(STARMSG);
		SerPtr->printf("TEMP                   : %d.%03d[V], %d['C]\n", Data/1000, Data%1000, tmpx/10);

		
		OSTimeDly(30L);

	}
#endif

	SerPtr->printf("\n\n");
	
	PrintStar();
}




void AdcPrintf(char *sptr, INT16U rawData, INT8U is_5V)
{
	INT16U Data=0;
	if(is_5V) 	Data = AdctoVolt5opamp(rawData);
	else		Data = AdctoVolt33V(rawData);
	
	SerPtr->printf(STARMSG);
	SerPtr->printf("%s: %d.%d[V], [raw:%04d]", sptr, Data/10, Data%10, rawData);
	SerPtr->printf(ENTMSG);
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

void CurrentInputStatus(INT8U vcheck)
{
	INT8U tcnt = 0;
	INT8U tval = FALSE;
    tcnt = tcnt;

	if(!vcheck)PrintStar();
	{
#if 0
		tval += DigitalInputDiplay(tcnt++, _4G_PLL_LD, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, _3G_PLL_LD, PHAMSG, ENTMSG, vcheck);
#endif
		tval += DigitalInputDiplay(tcnt++, RRTYPE, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, AC_Alarm, PHAMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_CDMALTE, PHAMSG, ENTMSG, vcheck);
		
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_WCDMA, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_LTE_A2_0, PHAMSG, ENTMSG, vcheck);
 	}
	
	if(!vcheck)PrintStar();
	if(vcheck)
	{
		if(tval) SerPtr->printf("\n");
	}
}



void HwTestOutFunc(INT32U *nFlag)
{
#if 1
	INT32U MaxValue = 0xFFFF;
	INT8U Data = *nFlag;

	INT8U i = 0;

	GreenLED_CDMA		= 0;
	RedLED_CDMA			= 0;
	GreenLED_WCDMA		= 0;
	RedLED_WCDMA		= 0;
	GreenLED_LTE 		= 0;
	RedLED_LTE			= 0;
	GreenLED_LTE_A2_0	= 0;
	RedLED_LTE_A2_0		= 0;	

	AmpOnOff_CDMA		= 0;
	AmpOnOff_LTE_0		= 0;
	AmpOnOff_LTE_A2_0	= 0;
	AmpOnOff_WCDMA		= 0;

	
	PLLEN_LTE			= 0;
	PLLEN_LTE_A2		= 0;
	PLLEN_LTE_A2_1		= 0;

	SMS_PWR 			= 0;


	PCA9555BitSet(SP_EN1,&AttnCS0Val); 
	PCA9555BitSet(SP_EN2,&AttnCS1Val); 


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
			GreenLED_WCDMA	= 1;
		break;
		
		case 7:
			RedLED_WCDMA	= 1;
		break;			
		
		case 8:
			AmpOnOff_CDMA		= 1;
		break;
		
		case 9:
			AmpOnOff_LTE_0		= 1;
		break;
		
		case 10:
			AmpOnOff_LTE_A2_0 	= 1;
		break;
		
		case 11:
			AmpOnOff_WCDMA 		= 1;
		break;

        case 12:
			PLLEN_LTE 		= 1;
		break;

        case 13:
			PLLEN_LTE_A2 		= 1;
		break;

   		case 14:
			PLLEN_LTE_A2_1 		= 1;
		break;

   		case 15:
			PCA9555BitRst(SP_EN1,&AttnCS0Val); 
		break;


   		case 16:
			PCA9555BitRst(SP_EN2,&AttnCS1Val); 
		break;



		case 17:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~1);
			}
		break;

		case 18:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~2);
			}
		break;

		case 19:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~4);
			}
		break;

		case 20:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~8);
			}
		break;

		case 21:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~16);
			}
		break;

		case 22:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~32);
			}
		break;

 		case 23:
			MaxValue = Data;
			//BuzzShort();
		break;
	}

	*nFlag = *nFlag + 1;

	if(*nFlag >= MaxValue) *nFlag = 0;
#endif
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
#if 1
INT8U SavetoTestBackup(INT8U tmpIndex, INT8U tSet, INT8U IsItLoad)
{
#if 0
	EE_TABLE1 *ptr = &gEE_TABLE1;
	INT32U AddrOffset = vEE_TABLE1Addr + (INT32U)&(ptr->BdTestBp) - (INT32U )&gEE_TABLE1;

	AddrOffset += tmpIndex;

	if(IsItLoad)
	{
		ptr->BdTestBp[tmpIndex] = tSet;
		WriteEEprom(At24cDevID, AddrOffset, tSet, 0);
	}
	return (ptr->BdTestBp[tmpIndex]);
#endif

return 0;

}
#endif

void PrintLogo(void)
{

	SerPtr->printf("\n\n");
	PrintStar();
	SerPtr->printf("*\n");
	SerPtr->printf("* %s [VER:%d.%d]\n", BoardTestMode, (SystemVer >> 4 & 0x0f), (SystemVer >> 0 & 0x0f));
	SerPtr->printf("*    -COMMAND 1st-\n");
	SerPtr->printf("*  ?        : help(this message)\n");
	SerPtr->printf("*  I        : INPUT Test          [%s]\n", testResult[0x03 & SavetoTestBackup(InputTest, NULL, NULL)]);
	SerPtr->printf("*  O        : OUTPUT Test         [%s]\n", testResult[0x03 & SavetoTestBackup(OutputTest,  NULL, NULL)]);
	SerPtr->printf("*  C        : SERIAL[UART]        [%s]\n", testResult[0x03 & SavetoTestBackup(CommTest, NULL, NULL)]);
	SerPtr->printf("*  A        : ANALOG DECT         [%s]\n", testResult[0x03 & SavetoTestBackup(ADCTest, 	NULL, NULL)]);
	SerPtr->printf("*  E        : EEPROM TEST         [%s]\n", testResult[0x03 & SavetoTestBackup(EepromTest, NULL, NULL)]);
	SerPtr->printf("*  S        : Factory SET\n");

//	SerPtr->printf("*  G        : compulsory boot/#,\n");
	
	PrintStar();
}




void PrintStar(void)
{
	SerPtr->printf("*******************************************************************************\n");
}

void PromptOut(void)
{
	
	SerPtr->printf("TRIO-M >>");
}





///////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////

