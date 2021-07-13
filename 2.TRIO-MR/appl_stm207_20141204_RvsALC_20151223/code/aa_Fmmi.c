/*******************************************************************************
 *
 * This module contains the function 7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 *
 ******************************************************************************/

////////////////////////////////////////////////////////////////////////////////
#define FMMI_C

#include "../include/main.h"

void FmmiInit(void)
{
	LcdInit((INT32U)CS1SEL, VFD_A0Sel, VFD_SELSel, 16, 2, NULL, (char *)HUBDefaultMsg);
	OSTaskCreate(FmmiTask, (void *)0, (OS_STK *)&FmmiTaskStk[FMMI_START_STK_SIZE - 1], FMMI_START_PRIO);
}
void FmmiTask(void * pdata)
{

	INT8U  DigitString[3] = "1.1";
	INT8U *ptr;
	INT8U tmp = 0;
	
	pdata = pdata;

	VfdDisplayStep = NULL;
	FirstPrintf	= NULL;

	while(1)
	{
		while(WRCS_DownLoadGiveupTimerSet(NULL))
		{
			switch(DownloadID)
			{         
				case DNRID:	cLcd->Replace( (char *)" DNR DOWNLOAD   ", 0*LCDlineSIZE, 16); break;
				case OTRUID:
					if(DnrSts[0].RepeaterType[1] == __DEITYPE)
							cLcd->Replace( (char *)" IDU DOWNLOAD   ", 0*LCDlineSIZE, 16);
					else	cLcd->Replace( (char *)" ODU DOWNLOAD   ", 0*LCDlineSIZE, 16);
				break;

				case RMTID:	cLcd->Replace( (char *)" ORU DOWNLOAD   ", 0*LCDlineSIZE, 16); break;
				case ITUID:	cLcd->Replace( (char *)" ITU DOWNLOAD   ", 0*LCDlineSIZE, 16); break;

				default:
				break;

			}
			if(!(tmp)) cLcd->Replace( (char *)BlinkMSG, 1 * LCDlineSIZE,     16);
            cLcd->Replace( (char *)"%",      1 * LCDlineSIZE + tmp, 1);
			
            tmp++;
			tmp %= 16;
			FirstPrintf = 0;
			OSTimeDly(500L);
		}
	
		while(!WRCS_DownLoadGiveupTimerSet(NULL) && !tTestFlag)
		{
			tmp = 0;
			
			if(FirstPrintf == 0)
			{
				FirstPrintf = 1;
				cLcd->printf((char*)HUBDefaultMsg, BlinkON );
				
				DigitString[0] = 0x30 | (SystemVer >> 4);
				DigitString[1] = '.';
				DigitString[2] = 0x30 | (SystemVer & 0x0F);
				
				cLcd->ReplaceOne( (char *)DigitString, 0 * LCDlineSIZE + 13, 3, FwdWrite);
				cLcd->ReplaceOne( (char *)DigitString, 0 * LCDlineSIZE + 13, 3, BwdWrite);

				     if(DnrSts[0].RepeaterType[1] == __DEITYPE)	ptr = (INT8U *)IndoorMsg;
				else if(DnrSts[0].RepeaterType[1] == __DEOTYPE)	ptr = (INT8U *)OutdoorMsg;

				cLcd->ReplaceOne( (char *)ptr, 0 * LCDlineSIZE + 4, 7, FwdWrite);
				cLcd->ReplaceOne( (char *)ptr, 0 * LCDlineSIZE + 4, 7, BwdWrite);
			}
			else
			{
				if(DoorVfdCheck())
				{
					switch(VfdDisplayStep)
					{
						case 0:	// Init Display, 1 Sec timer Rester
							FirstPrintf = 0;
							VfdDisplayStep++;
							TimerRegist(TimerVFDOut, TimerVfd1stOffTime);
						break;

						case 1:
							if(TimeOverCheck(TimerVFDOut))
							{
								cLcd->Clear();
								VfdDisplayStep++;
								TimerRegist(TimerVFDOut, TimerVfd2stOnTime);
							}
						break;

						case 2:
							if(TimeOverCheck(TimerVFDOut))
							{
								FirstPrintf = 0;
								VfdDisplayStep = 1;
								TimerRegist(TimerVFDOut, TimeVfdEscTime);
							}
						break;
					}
				}	
				else
				{
					cLcd->Clear();				// VFD OFF
					VfdDisplayStep = 0;
				}
			}
		
			if(IsKey5Pushed(1))
			{
	            INT8U tkval = ReadKey5Buffer();
				INT8U rval = 0;
				if(tkval == keyMENU)
				{
					if(VfdDisplayStep == 1) { 		// display on time 일 때, menu로 들어간다...
						KeyPadOnFlag = TRUE;
						//SelectMenuDisplay();
						KeyPadOnFlag = FALSE;
					}
					rval = TRUE;
				}
				else if(tkval == keyENTR) {rval = TRUE;}
				else if(tkval == keyDOWN) {rval = TRUE;}
				else if(tkval == keyUP)   {rval = TRUE;}
				else if(tkval == keyESC)  {rval = TRUE;}

				if(rval == TRUE)			
				{
					Key5BufferClear();
					VfdDisplayStep = 0;
				}
			}
			OSTimeDly(200L);
	    }
		OSTimeDly(500L);
	}
}

INT8U DoorVfdCheck(void)
{
//////////////////////////////////////////////////////////////////////////////
	return TRUE;
}


void KeyPushBuffSet(void)
{
	TimerRegist (TimerVFDOut, TimeVfdEscTime);
}

void SelectMenuDisplay(void)
{
	INT8U	DigitString[3];
	INT8U	MenuMaxNo;
	INT8S 	Menu = 0;
	INT8U 	pdisplayFlag = 0;
	//__BeaconStsStr *Sts = BeaconSts;
	
	Menu = 0;

	Key5BufferClear();
	InitKeyVal();
		
	MenuMaxNo = MenuEnviroment;

	while(1)
	{
		
		if(TimeOverCheck(TimerVFDOut))
		{
RINIT:
			InitKeyVal();
			return;			//ESC while
		}
		if(IsKey5Pushed(1) || !pdisplayFlag)
		{
			INT8U tkval;
			
			if(pdisplayFlag){
				tkval = ReadKey5Buffer();
			}
			pdisplayFlag = TRUE;

			if(tkval == keyDOWN)	{ if(++Menu > MenuMaxNo) Menu = MenuMaxNo;
				if(Menu == MenuReverse)
				{
					 	  //if(Sts->RepeaterType[1] == __GEN_IN)	 Menu++;
					// else if(Sts->RepeaterType[1] == __GEN_OUT)  Menu++;
					// else if(Sts->RepeaterType[1] == __GEN_RACK) Menu++;
				}
				 
				if(Menu == MenuAmp)
				{
					// 	  if(Sts->RepeaterType[1] == __COPY_RACK)  Menu++;
					// else if(Sts->RepeaterType[1] == __GEN_RACK) Menu++;
				}

			}
			else if(tkval == keyUP) 	{ if(--Menu < 0)		 Menu = 0;			

				if(Menu == MenuAmp)
				{
					//  if(Sts->RepeaterType[1] == __COPY_RACK)  Menu--;
					//else if(Sts->RepeaterType[1] == __GEN_RACK) Menu--;
				}
				
				if(Menu == MenuReverse)
				{
					//	  if(Sts->RepeaterType[1] == __GEN_IN)	 Menu--;
					// else if(Sts->RepeaterType[1] == __GEN_OUT)  Menu--;
					// else if(Sts->RepeaterType[1] == __GEN_RACK) Menu--;
				}
				 
			}
			else if(tkval == keyENTR)
			{
			
				KeyPushBuffSet();

					 if(Menu == MenuForward)  	{if(FwdStsMenuDisplay()) goto RINIT;} 
				else if(Menu == MenuReverse)   	{if(RvsStsMenuDisplay()) goto RINIT;} 		
				else if(Menu == MenuAmp) 		{if(AmpStsMenuDisplay()) goto RINIT;}
				else if(Menu == MenuEnviroment) {if(EnvStsMenuDisplay()) goto RINIT;}
				else if(Menu == MenuFA)			{if(FAStsMenuDisplay())  goto RINIT;}

			}
			else if(tkval == keyMENU) {goto RINIT;}
			else if(tkval == keyESC)  {goto RINIT;}
			//////////////////////////////////////////////////////////////
			switch(Menu)
			{	
				case MenuForward:	
				{
					const char *_2ndMSG = MenuRvsMSG;

					//     if(Sts->RepeaterType[1] == __COPY_IN)	{_2ndMSG = MenuRvsMSG;}
					//else if(Sts->RepeaterType[1] == __COPY_OUT)	{_2ndMSG = MenuRvsMSG;}
					//else if(Sts->RepeaterType[1] == __GEN_IN)	{_2ndMSG = MenuAmpMSG;}
					//else if(Sts->RepeaterType[1] == __GEN_OUT)	{_2ndMSG = MenuAmpMSG;}
					//else if(Sts->RepeaterType[1] == __COPY_RACK){_2ndMSG = MenuRvsMSG;}
					//else if(Sts->RepeaterType[1] == __GEN_RACK)	{_2ndMSG = MenuFAMSG;}
					
					cLcd->Replace( (char *)MenuFwdMSG,		0*LCDlineSIZE, 16);
					cLcd->Replace( (char *)_2ndMSG, 		1*LCDlineSIZE, 16);
				}
				break;

				case MenuReverse:	
				{
					const char *_2ndMSG = MenuAmpMSG;
					
					//     if(Sts->RepeaterType[1] == __COPY_IN)	{_2ndMSG = MenuAmpMSG;}
					//else if(Sts->RepeaterType[1] == __COPY_OUT)	{_2ndMSG = MenuAmpMSG;}
					//else if(Sts->RepeaterType[1] == __COPY_RACK){_2ndMSG = MenuFAMSG;}
					
					cLcd->Replace( (char *)MenuRvsMSG,		0*LCDlineSIZE, 16);
					cLcd->Replace( (char *)_2ndMSG, 		1*LCDlineSIZE, 16);
				}
				break;	

				case MenuAmp:
				{
					cLcd->Replace( (char *)MenuAmpMSG,		0*LCDlineSIZE, 16);
					cLcd->Replace( (char *)MenuFAMSG,       1*LCDlineSIZE, 16);
				}
				break;

				case MenuFA:	
					cLcd->Replace( (char *)MenuFAMSG,		0*LCDlineSIZE, 16);
					cLcd->Replace( (char *)MenuEnvironMSG,	1*LCDlineSIZE, 16);
				break;

                case MenuEnviroment:	
					cLcd->Replace( (char *)MenuEnvironMSG,	0*LCDlineSIZE, 16);
					cLcd->Replace( (char *)BlinkMSG,  1*LCDlineSIZE, 16);
				break;

			}
			
			DigitString[0] = 0x10;
			cLcd->Replace( (char *)DigitString, 0*LCDlineSIZE, 1);
			TimerRegist (TimerVFDOut, TimeVfdEscTime);
		}			
		OSTimeDly(200);
	}
}

INT8U FwdSelectMenuDisplay(void)
{

	INT8U	MenuMaxNo;
	INT8U	DigitString[3];
	INT8U	rval = FALSE;
	INT8S	SubMenu = 0;
	
	Key5BufferClear();	
	InitKeyVal();

	cLcd->Replace( (char *)MenuNODEBFwdMSG,	0*LCDlineSIZE, 16);
	cLcd->Replace( (char *)MenuRepFwdMSG,	1*LCDlineSIZE, 16);
	DigitString[0] = 0x10;
	cLcd->Replace( (char *)DigitString, 	0*LCDlineSIZE, 1);
	
	MenuMaxNo = MenuRepFwd;
		
	while(1)
	{	
		if(TimeOverCheck(TimerVFDOut) || !DoorVfdCheck())
		{
			rval = TRUE;
RINIT:
			InitKeyVal();
			return rval; 		//ESC while
		}
		if(IsKey5Pushed(1))
		{
			INT8U tkval = ReadKey5Buffer();

			 KeyPushBuffSet();

				 if(tkval == keyDOWN)	{ if(++SubMenu > MenuMaxNo) 	SubMenu = MenuMaxNo;	}
			else if(tkval == keyUP) 	{ if(--SubMenu < 0) 			SubMenu = 0;			}

			else if(tkval == keyENTR)
			{
				if( (rval = FwdStsMenuDisplay())) goto RINIT; 		
									
			}
			else if(tkval == keyMENU) {goto RINIT;}
			else if(tkval == keyESC)  {goto RINIT;}

		//////////////////////////////////////////////////////////////
		
			switch(SubMenu)
			{	
				case MenuNODEBFwd:	
					cLcd->Replace( (char *)MenuNODEBFwdMSG,		0*LCDlineSIZE, 16);
					cLcd->Replace( (char *)MenuRepFwdMSG,  	    1*LCDlineSIZE, 16);
				break;

				case MenuRepFwd:	
					cLcd->Replace( (char *)MenuRepFwdMSG,		0*LCDlineSIZE, 16);
					cLcd->Replace( (char *)BlinkMSG,			1*LCDlineSIZE, 16);
				break;
			}
			DigitString[0] = 0x10;
			cLcd->Replace( (char *)DigitString, 0*LCDlineSIZE, 1);
		
			TimerRegist (TimerVFDOut, TimeVfdEscTime);
		}
		OSTimeDly(200);
	}
}

INT8U FwdStsMenuDisplay(void)
{
	INT8U SetMode = FALSE;
	INT8U DisplayFlag = FALSE; 

	INT32S Max,Min;
	INT32S TempValue = 0;
	INT32S MenuMaxBuff;
	INT8U rval = 0;
	INT8S SelectMenu = 0;
	INT8U isitbackup = 0;
	
	//__BeaconStsStr *Sts = BeaconSts;
	
	Key5BufferClear();	
	InitKeyVal();

	MenuMaxBuff = MenuFwdOutSWTime;

	while(1)
	{
		
		if(TimeOverCheck(TimerVFDOut) || !DoorVfdCheck())
		{
			rval = TRUE;
RINIT:
			InitKeyVal();
			return rval; 		//ESC while
		}
		if(IsKey5Pushed(1))
		{
			INT8U tkval = ReadKey5Buffer();

			KeyPushBuffSet();

			if(tkval == keyDOWN)	
		 	{ 
				if (SetMode)
				{
					if(--TempValue < Min)TempValue = Min;
					DisplayFlag = TRUE; 
				}	
				else
				{
					if (++SelectMenu > MenuMaxBuff) SelectMenu = 0;

					if( SelectMenu == MenuFwdREPOutPwr)
					{								
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					}
					
					if( SelectMenu == MenuFwdREPOutPwrHigh)
					{								
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					}
					
					if( SelectMenu == MenuFwdREPOutPwrLow)
					{								
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					}
					
					if( SelectMenu == MenuFwdREPOutAttn)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					}
				}
			}
			else if(tkval == keyUP) 
			{
				if(SetMode)
				{
					if(++TempValue > Max)TempValue = Max;
					DisplayFlag = TRUE; 
				}
				else{

					if(--SelectMenu < 0) SelectMenu = MenuMaxBuff; 

					if( SelectMenu == MenuFwdREPOutAttn)
					{								
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}

					if( SelectMenu == MenuFwdREPOutPwrLow)
					{								
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}

					if( SelectMenu == MenuFwdREPOutPwrHigh)
					{								
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}
					
					if( SelectMenu == MenuFwdREPOutPwr)
					{								
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}
				}
			}

			else if(tkval == keyENTR)
			{
				if(SetMode)
				{
					INT32U cpu_sr;
					OS_ENTER_CRITICAL();
					{
						//EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
						
						switch(SelectMenu)
						{
							case MenuFwdInAttn:
							{
								//INT8S tmp = TempValue;
								//isitbackup = SetDnrCtrlData(Aid_FwdInAttn_3G, (INT8U *)&tmp, 0, tptr);
							}
							break;						
				
							case MenuFwdOutAttn: 
							{
								//INT8S tmp = TempValue;
								//isitbackup = SetDnrCtrlData(Aid_FwdOutAttn_3G, (INT8U *)&tmp, 0, tptr);
							}
							break;
				
							case MenuFwdREPOutAttn: 
							{
								//INT8S tmp = TempValue;
								//isitbackup = SetDnrCtrlData(Aid_FwdOutAttn_REP_3G, (INT8U *)&tmp, 0, tptr);
							}
							case MenuFwdOutSWTime:
							{	
								//INT8S tmp = TempValue;
								//isitbackup = SetDnrCtrlData(Aid_OutSwitchTime_3G, (INT8U *)&tmp, 0, tptr);
							}
							break;	
						}
						///////////////
						if(isitbackup)
						{
							//WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
						}
					}
					OS_EXIT_CRITICAL();
					SetMode = FALSE;
					
				}
				else
				{
					switch(SelectMenu)
					{
						case MenuFwdInAttn:	
						break;						
			
						case MenuFwdOutAttn: 
						break;
			
						case MenuFwdREPOutAttn: 
						break;	

						case MenuFwdOutSWTime:
						break;
					}	
				
				}
			}
			else if(tkval == keyMENU) {goto RINIT;}
			else if(tkval == keyESC)  {goto RINIT;}

		//////////////////////////////////////////////////////////////
			TimerRegist (TimerVFDOut, TimeVfdEscTime);
		}	

		if (SetMode)
		{
			if (DisplayFlag)
			{
				switch(SelectMenu)
				{
					case MenuFwdInAttn:
					case MenuFwdOutAttn: 
					case MenuFwdREPOutAttn:
						AttnDisplay(TempValue, BlinkON, 12);
					break;

					case MenuFwdOutSWTime:
						cLcd->Replace( (char *)MenuFwdOutSWTimeMSG, 1*LCDlineSIZE, 16);
						VauleDisplay(TempValue*5L, BlinkON, 12);
					break;
				}
				DisplayFlag = FALSE;
			}
		}
		else 	// STATUS
		{

			cLcd->Replace( (char *)MenuFwdMSG,		0*LCDlineSIZE, 16);
			switch(SelectMenu)
			{
				
				case MenuFwdInPwr: 
					//cLcd->Replace( (char *)MenuInPwrMSG, 1*LCDlineSIZE, 16);
					//AttnDisplay(Sts->FwdInPwr_3G, BlinkOFF, 12);
				break;
				
				case MenuFwdInPwrHigh:
					//cLcd->Replace( (char *)MenuInPwrHighMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdInUpperLmt_3G, 9);
				break;	

				case MenuFwdInPwrLow:
					//cLcd->Replace( (char *)MenuInPwrLowMSG,	1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdInLowerLmt_3G, 9);
				break;
				
				case MenuFwdOutPwr:
					//cLcd->Replace( (char *)MenuFwdOutPwrMSG, 1*LCDlineSIZE, 16);
					//AttnDisplay(ConvLevelOneByte(Sts->FwdPwr_3G), BlinkOFF, 12);
				break;

				case MenuFwdOutPwrHigh: 
					//cLcd->Replace( (char *)MenuFwdOutPwrHighMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdOutUpperLmt_3G, 9);
				break;	

				case MenuFwdOutPwrLow: 	
					//cLcd->Replace( (char *)MenuFwdOutPwrLowMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdOutLowerLmt_3G, 9);
				break;	

				case MenuFwdREPOutPwr:
					//cLcd->Replace( (char *)MenuREPOutPwrMSG, 1*LCDlineSIZE, 16);
					//AttnDisplay(ConvLevelOneByte(Sts->FwdPwrREP_3G), BlinkOFF, 12);
				break;

				case MenuFwdREPOutPwrHigh: 
					//cLcd->Replace( (char *)MenuREPOutPwrHighMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdOut_REPUpperLmt_3G, 9);
				break;	

				case MenuFwdREPOutPwrLow: 	
					//cLcd->Replace( (char *)MenuREPOutPwrLowMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdOut_REPLowerLmt_3G, 9);
				break;	

				case MenuFwdInAttn: 
					//cLcd->Replace( (char *)MenuInAttnMSG, 1*LCDlineSIZE, 16);
					//AttnDisplay(Sts->FwdInAttn_3G, BlinkOFF, 12);
 				break;	
				
				case MenuFwdOutAttn: 	
					//cLcd->Replace( (char *)MenuOutAttnMSG, 1*LCDlineSIZE, 16);
 					//AttnDisplay(Sts->FwdOutAttn_3G, BlinkOFF, 12);
				break;	

				case MenuFwdREPOutAttn: 	
					//cLcd->Replace( (char *)MenuREPOutAttnMSG, 1*LCDlineSIZE, 16);
 					//AttnDisplay(Sts->FwdOutAttn_REP_3G, BlinkOFF, 12);
				break;

				case MenuFwdOutSWTime:
					//cLcd->Replace( (char *)MenuFwdOutSWTimeMSG, 1*LCDlineSIZE, 16);
					//VauleDisplay(Sts->OutSwitchTime_3G.Data*5L, BlinkOFF, 12);
				break;
			}
		}
		OSTimeDly(200);
	}
}


INT8U RvsStsMenuDisplay(void)
{
	INT8U SetMode = FALSE;
	INT8U DisplayFlag = FALSE; 

	INT32S Max, Min;
	INT32S TempValue = 0;
	INT32S MenuMaxBuff;
	INT8U rval = 0;
	INT8S SelectMenu = 0;
	INT8U isitbackup = 0;
	
	//BeaconStsStr *Sts = BeaconSts;
	
	Key5BufferClear();	
	InitKeyVal();

	MenuMaxBuff = MenuRvsOsc;

	while(1)
	{
		
		if(TimeOverCheck(TimerVFDOut) || !DoorVfdCheck())
		{
			rval = TRUE;
RINIT:
			InitKeyVal();
			return rval; 		//ESC while
		}
		if(IsKey5Pushed(1))
		{
			INT8U tkval = ReadKey5Buffer();

			KeyPushBuffSet();

			if(tkval == keyDOWN)	
		 	{ 
				if (SetMode)
				{
					if(--TempValue < Min)TempValue = Min;
					DisplayFlag = TRUE; 
				}	
				else if (++SelectMenu > MenuMaxBuff) SelectMenu = 0;
			}
			else if(tkval == keyUP) 
			{
				if(SetMode)
				{
					if(++TempValue > Max)TempValue = Max;
					DisplayFlag = TRUE; 
				}
				else if(--SelectMenu < 0) SelectMenu = MenuMaxBuff; 
			}

			else if(tkval == keyENTR)
			{
				
				if(SetMode)
				{
					INT32U cpu_sr;
					OS_ENTER_CRITICAL();
					{
						//INT8S tmp = TempValue;
						//EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
	                    
	  				    switch(SelectMenu)
						{
							
							case MenuRvsAttn:
							{
								//isitbackup = SetDnrCtrlData(Aid_Rvs0Attn_3G, (INT8U *)&tmp, 0, tptr);
							}
							case MenuRvsCWOnOff:
							{
								//isitbackup = SetDnrCtrlData(Aid_CW0OnOff_3G, (INT8U *)&tmp, 0, tptr);
							}
							break;
							
							case MenuRvsPathLoss:					
							{
								//isitbackup = SetDnrCtrlData(Aid_RFPassLossOnoff_3G, (INT8U *)&tmp, 0, tptr);
							}
							break;	
						}
						///////////////
						if(isitbackup)
						{
							//WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
						}
					}
					OS_EXIT_CRITICAL();
					SetMode = FALSE;
					
				}
				else
				{
					switch(SelectMenu)
					{
						case MenuRvsAttn:
						break;
			
						case MenuRvsCWOnOff:
						break;

						case MenuRvsPathLoss:
						break;			
					}	
				
				}
			}

			else if(tkval == keyMENU) {goto RINIT;}
			else if(tkval == keyESC)  {goto RINIT;}

		//////////////////////////////////////////////////////////////
			TimerRegist (TimerVFDOut, TimeVfdEscTime);
		}	

		if (SetMode)
		{
			if (DisplayFlag)
			{
				switch(SelectMenu)
				{
					case MenuRvsAttn:	
						AttnDisplay(TempValue, BlinkON, 12);
					break;						
		
					case MenuRvsCWOnOff: 
						OnOffDisplay(TempValue, BlinkON, 11);
					break;

					case MenuRvsPathLoss:
						SetDisplay(TempValue, BlinkON, 11);
					break;
				}
				DisplayFlag = FALSE;
			}
		}
		else 
		{
			switch(SelectMenu)
			{
				case MenuRvsPathLoss:
					//cLcd->Replace( (char *)MenuCableLossCMSG, 0*LCDlineSIZE, 16);
				break;

				case MenuRvsCWOnOff:
					//cLcd->Replace( (char *)MenuCWMSG, 0*LCDlineSIZE, 16);
				break;
				
				default:
					//cLcd->Replace( (char *)MenuRvsMSG,		0*LCDlineSIZE, 16);
				break;
			}
		
			switch(SelectMenu)
			{	

			
				case MenuRvsInPwr:
					//cLcd->Replace( (char *)MenuInPwrMSG, 1*LCDlineSIZE, 16);
					//AttnDisplay(Sts->RvsInPwr_3G, BlinkOFF, 12);
				break;

				case MenuRvsInPwrHigh:
					//cLcd->Replace( (char *)MenuInPwrHighMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.RvsInUpperLmt_3G, 9);
				break;

				case MenuRvsInPwrLow:
					//cLcd->Replace( (char *)MenuInPwrLowMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.RvsInLowerLmt_3G, 9);
				break;

				case MenuRvsOutPwr:
					//cLcd->Replace( (char *)MenuRvsOutPwrMSG, 1*LCDlineSIZE, 16);
					//AttnDisplay(ConvLevelOneByte(Sts->Rvs0OutPwr_3G), BlinkOFF, 12);
				break;

				case MenuRvsOutPwrHigh:
					//cLcd->Replace( (char *)MenuOutPwrHighMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.RvsOutUpperLmt_3G, 9);
				break;
				
				case MenuRvsOutPwrLow:
					//cLcd->Replace( (char *)MenuOutPwrLowMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.RvsOutLowerLmt_3G, 9);
				break;

				case MenuRvsAttn: 
					//cLcd->Replace( (char *)MenuAttnMSG, 1*LCDlineSIZE, 16);
					//AttnDisplay(Sts->Rvs0Attn_3G, BlinkOFF, 12);
				break;				

				case MenuRvsCWOnOff:
					//cLcd->Replace( (char *)MenuRvsCWOnOffMSG, 1*LCDlineSIZE, 16);
					//OnOffDisplay(Sts->CW0OnOff_3G, BlinkOFF, 0);
					//OnOffDisplay((!Sts->CW0OnOff_3G) & 0x01, BlinkOFF, 11);
				break;

				case MenuRvsPathLoss:
					//cLcd->Replace( (char *)MenuCableLossMSG, 1*LCDlineSIZE, 16);
					//PathLossDisplay(Sts->RFPathLossResult_3G);
				break;

				case MenuRvsOsc:
					//cLcd->Replace( (char *)MenuRvsOscMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.RvsOsc_3G, 9);
				break;
				

			}
		}
		OSTimeDly(200);
	}
}

INT8U FAStsMenuDisplay(void)
{
	INT8U SetMode = FALSE;
	INT8U DisplayFlag = FALSE; 

	INT32S Max, Min;
	INT32S TempValue = 0;
	INT32S MenuMaxBuff;
	INT8U rval = 0;
	INT8S SelectMenu = 0;
	INT8U isitbackup = 0;
	
	//__BeaconStsStr *Sts = BeaconSts;
	
	Key5BufferClear();	
	InitKeyVal();
	
	MenuMaxBuff = MenuAmpDc;

	while(1)
	{		

		if(TimeOverCheck(TimerVFDOut) || !DoorVfdCheck())
		{
			rval = TRUE;
RINIT:
			InitKeyVal();
			return rval; 		//ESC while
		}
		if(IsKey5Pushed(1))
		{
			INT8U tkval = ReadKey5Buffer();

			KeyPushBuffSet();

			if(tkval == keyDOWN)	
		 	{ 
				if (SetMode)
				{
					if(--TempValue < Min)TempValue = Min;
					DisplayFlag = TRUE; 
				}	
				else if (++SelectMenu > MenuMaxBuff) SelectMenu = 0;
			}
			else if(tkval == keyUP) 
			{
				if(SetMode)
				{
					if(++TempValue > Max)TempValue = Max;
					DisplayFlag = TRUE; 
				}
				else if(--SelectMenu < 0) SelectMenu = MenuMaxBuff; 
			}

			else if(tkval == keyENTR)
			{
				if(SetMode)
				{
					INT32U cpu_sr;

					OS_ENTER_CRITICAL();
					{
						//INT8S tmp = TempValue;
						//EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
					
						switch(SelectMenu)
						{
							case MenuFAIn:
								//isitbackup = SetDnrCtrlData(Aid_FwdInFA_3G, (INT8U *)&tmp, 0, tptr);
							break;
							
							case MenuFAOut1:
								//isitbackup = SetDnrCtrlData(Aid_FwdOutFA1_3G, (INT8U *)&tmp, 0, tptr);
							break;
							
							case MenuFAOut2:
								//isitbackup = SetDnrCtrlData(Aid_FwdOutFA2_3G, (INT8U *)&tmp, 0, tptr);
							break;			
				
						}
						///////////////
						if(isitbackup)
						{
							//WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
						}
					}
					OS_EXIT_CRITICAL();

					#ifdef __SUNWAVE
					//if(isitbackup)
					{
						TXCUSendCnt = 0;
						TXCURecvCnt = 0;
						
						while(TXCUCtrlSendCheck())
						{						
							TimerRegist(TimerRmtCtrl, Time100mSec*50L);
							while(TXCUSendCnt != TXCURecvCnt)
							{
								if(TimeOverCheck(TimerRmtCtrl))
								{
									break;
								}
								OSTimeDly(50L);
							}
						}
					}
					#endif
					SetMode = FALSE;
				}
				else
				{
					switch(SelectMenu)
					{
						case MenuFAIn:
							//TempValue = Sts->FwdInFA_3G;
							//Max = 6; Min = 1;
							//SetMode = TRUE;
							//DisplayFlag = TRUE; 
						break;
						
						case MenuFAOut1:
							//TempValue = Sts->FwdOutFA1_3G;
							//Max = 6; Min = 0;
							//SetMode = TRUE;
							//DisplayFlag = TRUE; 
						break;
						
						case MenuFAOut2:
							//TempValue = Sts->FwdOutFA2_3G;
							//Max = 6; Min = 0;
							//SetMode = TRUE;
							//DisplayFlag = TRUE; 
						break;			
					}	
				
				}
			}

			else if(tkval == keyMENU) {goto RINIT;}
			else if(tkval == keyESC)  {goto RINIT;}

		//////////////////////////////////////////////////////////////
			TimerRegist (TimerVFDOut, TimeVfdEscTime);
		}	

		if (SetMode)
		{
			if (DisplayFlag)
			{
				switch(SelectMenu)
				{
					case MenuFAIn:
						FADisplay(TempValue, BlinkON);
					break;
					
					case MenuFAOut1:
						FADisplay(TempValue, BlinkON);
					break;
					
					case MenuFAOut2:
						FADisplay(TempValue, BlinkON);
					break;
				}
				DisplayFlag = FALSE;
			}
		}
		else 
		{
			switch(SelectMenu)
			{
				default:
					cLcd->Replace( (char *)MenuFASelectMSG,		0*LCDlineSIZE, 16);
				break;
			}	
			
			switch(SelectMenu)
			{	

				case MenuFASts:
					//cLcd->Replace( (char *)MenuFAStsMSG,	1*LCDlineSIZE, 16);
					//VauleDisplay(Sts->FANo_3G, BlinkOFF, 12);
				break;

				case MenuFAIn:
					//cLcd->Replace( (char *)MenuFAInMSG,	1*LCDlineSIZE, 16);
					//FADisplay(Sts->FwdInFA_3G, BlinkOFF);
				break;

				case MenuFAOut1:
					//cLcd->Replace( (char *)MenuFAOut1MSG, 1*LCDlineSIZE, 16);
					//FADisplay(Sts->FwdOutFA1_3G, BlinkOFF);
				break;

				case MenuFAOut2:
					//cLcd->Replace( (char *)MenuFAOut2MSG, 1*LCDlineSIZE, 16);
					//FADisplay(Sts->FwdOutFA2_3G, BlinkOFF);
				break;
			}
		}
		OSTimeDly(200);
	}
}

INT8U AmpStsMenuDisplay(void)
{
	INT8U SetMode = FALSE;
	INT8U DisplayFlag = FALSE; 

	INT32S Max, Min;
	INT32S TempValue = 0;
	INT32S MenuMaxBuff;
	INT8U rval = 0;
	INT8S SelectMenu = 0;
	INT8U isitbackup = 0;
	
	//__BeaconStsStr *Sts = BeaconSts;
	
	Key5BufferClear();	
	InitKeyVal();
	
	MenuMaxBuff = MenuAmpDc;

	while(1)
	{		

		if(TimeOverCheck(TimerVFDOut) || !DoorVfdCheck())
		{
			rval = TRUE;
RINIT:
			InitKeyVal();
			return rval; 		//ESC while
		}
		if(IsKey5Pushed(1))
		{
			INT8U tkval = ReadKey5Buffer();

			KeyPushBuffSet();

			if(tkval == keyDOWN)	
		 	{ 
				if (SetMode)
				{
					if(--TempValue < Min)TempValue = Min;
					DisplayFlag = TRUE; 
				}	
				else if (++SelectMenu > MenuMaxBuff) SelectMenu = 0;
			}
			else if(tkval == keyUP) 
			{
				if(SetMode)
				{
					if(++TempValue > Max)TempValue = Max;
					DisplayFlag = TRUE; 
				}
				else if(--SelectMenu < 0) SelectMenu = MenuMaxBuff; 
			}

			else if(tkval == keyENTR)
			{
				if(SetMode)
				{
					INT32U cpu_sr;
					OS_ENTER_CRITICAL();
					{
						//INT8S tmp = TempValue;
						//EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
						
						switch(SelectMenu)
						{
							case MenuAmpOnOff:	
							{
								//isitbackup = SetDnrCtrlData(Aid_FwdAmpOff_3G, (INT8U *)&tmp, 0, tptr);
							}
							break;			
				
						}
						///////////////
						if(isitbackup)
						{
							//WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
						}

					}
					OS_EXIT_CRITICAL();
					
					#ifdef __SUNWAVE
					//if(isitbackup)
					{
						PAUSendCnt = 0;
						PAURecvCnt = 0;
						
						while(PauCtrlSendCheck())
						{						
							TimerRegist(TimerRmtCtrl, Time100mSec*50L);
							while(PAUSendCnt != PAURecvCnt)
							{
								if(TimeOverCheck(TimerRmtCtrl))
								{
									break;
								}
								OSTimeDly(50L);
							}
						}
					}
					#endif
					SetMode = FALSE;
				}
				else
				{
					switch(SelectMenu)
					{
						case MenuAmpOnOff:	

							//TempValue = Sts->BeaconAlm.FwdAmpOff_3G;
							//Max = Disable; Min = Enable;
							//SetMode = TRUE;
							//DisplayFlag = TRUE; 
						break;
			
					}	
				
				}
			}

			else if(tkval == keyMENU) {goto RINIT;}
			else if(tkval == keyESC)  {goto RINIT;}

		//////////////////////////////////////////////////////////////
			TimerRegist (TimerVFDOut, TimeVfdEscTime);
		}	

		if (SetMode)
		{
			if (DisplayFlag)
			{
				switch(SelectMenu)
				{
					case MenuAmpOnOff:	
						OnOffDisplay(TempValue, BlinkON, 11);
					break;						
				
				}
				DisplayFlag = FALSE;
			}
		}
		else 
		{
			switch(SelectMenu)
			{
				case MenuAmpVendor:
					cLcd->Replace( (char *)MenuAmpVendorWMSG,		0*LCDlineSIZE, 16);
				break;

				default:
					cLcd->Replace( (char *)MenuWcdmaAmpSubMSG,		0*LCDlineSIZE, 16);
				break;
			}	
			
			switch(SelectMenu)
			{	
				case MenuAmpVendor:
					//cLcd->Replace( (char *)MenuAmpVendorMSG,	1*LCDlineSIZE, 16);
					//PauMakerDisplay(Sts->AmpManufacture_3G);
					//VauleDisplay(Sts->AmpCapability_3G, BlinkOFF, 12);
				break;						
				
				case MenuAmpOnOff:
					//cLcd->Replace( (char *)MenuAmpOnOffMSG,		1*LCDlineSIZE, 16);
					//OnOffDisplay(Sts->BeaconAlm.FwdAmpOff_3G, BlinkOFF, 11);
				break;
				
				case MenuAmpOverPwr:
					//cLcd->Replace( (char *)MenuAmpOverPwrMSG,	1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdAmpOvrPwrFail_3G, 9);
				break;

				case MenuAmpOverTemp:
					//cLcd->Replace( (char *)MenuAmpOverTempMSG,		1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdAmpHighTempFail_3G, 9);
				break;	

				case MenuAmpVswr:
					//cLcd->Replace( (char *)MenuAmpVswrMSG,		1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdAmpVSWRFail_3G, 9);
				break;	

				case MenuAmpDc:
					//cLcd->Replace( (char *)MenuAmpDcMSG,		1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.FwdAmpDCFail_3G, 9);
				break;	

			}
		}
		OSTimeDly(200);
	}
}



INT8U EnvStsMenuDisplay(void)
{
	INT8U SetMode = FALSE;
	INT8U DisplayFlag = FALSE; 

	INT32S Max, Min;
	INT32S TempValue = 0;
	INT32S MenuMaxBuff;
	INT8U rval = 0;
	INT8S SelectMenu = 0;
	
	//__BeaconStsStr *Sts = BeaconSts;
	
	Key5BufferClear();	
	InitKeyVal();

	MenuMaxBuff = MenuLocal;

	while(1)
	{
		if(TimeOverCheck(TimerVFDOut) || !DoorVfdCheck())
		{
			rval = TRUE;
RINIT:
			InitKeyVal();
			return rval; 		//ESC while
		}
		if(IsKey5Pushed(1))
		{
			INT8U tkval = ReadKey5Buffer();

			KeyPushBuffSet();

			if(tkval == keyDOWN)	
		 	{ 
				if (SetMode)
				{
					if(--TempValue < Min)TempValue = Min;
					DisplayFlag = TRUE; 
				}	
				else{

					if (++SelectMenu > MenuMaxBuff) SelectMenu = 0;

					if(SelectMenu == MenuDoor)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					}
					
					if(SelectMenu == MenuBattery)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_IN)	{SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_IN)	{SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					}
					
					if(SelectMenu == MenuAc)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_IN)	{SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_IN)	{SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					}

					 if(SelectMenu == MenuDc)
					 {
						// 	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						// else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					 }
						 
					 if(SelectMenu == MenuBatteryLow)
					 {
						//	  if(Sts->RepeaterType[1] == __COPY_IN)  {SelectMenu++;}
						// else if(Sts->RepeaterType[1] == __GEN_IN)	 {SelectMenu++;}
						// else if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu++;}
						// else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu++;}
					 }
				}
			}
			else if(tkval == keyUP) 
			{
				if(SetMode)
				{
					if(++TempValue > Max)TempValue = Max;
					DisplayFlag = TRUE; 
				}
				else{
					if(--SelectMenu < 0) SelectMenu = MenuMaxBuff; 

					if(SelectMenu == MenuBatteryLow)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_IN)	{SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_IN)	{SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}
					
					if(SelectMenu == MenuDc)
					{
						//	if(Sts->RepeaterType[1] == __COPY_RACK) {SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}
					
					if(SelectMenu == MenuAc)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_IN)	{SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_IN)	{SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}
					if(SelectMenu == MenuBattery)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_IN)	{SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_IN)	{SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}
					if(SelectMenu == MenuDoor)
					{
						//	 if(Sts->RepeaterType[1] == __COPY_RACK){SelectMenu--;}
						//else if(Sts->RepeaterType[1] == __GEN_RACK) {SelectMenu--;}
					}						 
				}
			}

			else if(tkval == keyENTR)
			{
				if(SetMode)
				{
					switch(SelectMenu)
					{
						default:										
						break;						
												
					}			
					SetMode = FALSE;
					
				}
				else
				{
					switch(SelectMenu)
					{
						default:	
							//SetMode = TRUE;
							//DisplayFlag = TRUE; 
						break;						
			
					}	
				
				}
			}

			else if(tkval == keyMENU) {goto RINIT;}
			else if(tkval == keyESC)  {goto RINIT;}

		//////////////////////////////////////////////////////////////
			TimerRegist (TimerVFDOut, TimeVfdEscTime);
		}	

		if (SetMode)
		{
			if (DisplayFlag)
			{
				switch(SelectMenu)
				{
					default:	
					break;						
				
				}
				DisplayFlag = FALSE;
			}
		}
		else 
		{
			cLcd->Replace( (char *)MenuEnvironMSG, 0*LCDlineSIZE, 16);

			switch(SelectMenu)
			{	
				case MenuMaker:
					//cLcd->Replace( (char *)MenuMakerMSG, 1*LCDlineSIZE, 16);		
				 	//ManufactureDisplay(Sts->Manufacture);
				break;

				case MenuType:
					//cLcd->Replace( (char *)MenuTypeMSG, 1*LCDlineSIZE, 16);		
				 	//RepeaterType(Sts->RepeaterType[1]);
				break;

				case MenuDoor:	
					//cLcd->Replace( (char *)MenuDoorMSG, 1*LCDlineSIZE, 16);

					//if(Sts->BeaconAlm.DoorOpen)	ReplaceString( (char *)OpenMSG,(char *)OpenMSG, 1 * LCDlineSIZE + 10, strlen(OpenMSG));
					//else 	  					ReplaceString( (char *)CloseMSG,(char *)CloseMSG, 1 * LCDlineSIZE + 10, strlen(CloseMSG));	
					
				break;						
				
				case MenuTemp:
					{
						//INT8U tmp = 0xB0;
						//cLcd->Replace( (char *)MenuTempMSG,	1*LCDlineSIZE, 16);
						//VauleDisplay(Sts->CurrentTemp, BlinkOFF, 12);
						//cLcd->Replace( (char *)&tmp, 1*LCDlineSIZE+13, 1);	
					}
				break;
				
				case MenuBattery: 	
					//cLcd->Replace( (char *)MenuBatteryMSG, 1*LCDlineSIZE, 16);
					//BatteryDisplay(Sts->BatteryIns, BlinkOFF, 9);
				break;

				case MenuPwrSupply: 	
					//cLcd->Replace( (char *)MenuPwrSupplyMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.PwrSupplyLow, 9);
				break;
				
				case MenuAc:
					//cLcd->Replace( (char *)MenuAcMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.ACFail, 9);
				break;	

				case MenuDc: 	
					//cLcd->Replace( (char *)MenuDcMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.DCFail, 9);
				break;	

				case MenuBatteryLow:
					//cLcd->Replace( (char *)MenuBatteryLowMSG, 1*LCDlineSIZE, 16);
					//FailNrmDisplay(Sts->BeaconAlm.BatteryLow, 9);
				break;

				case MenuLocal:
					//cLcd->Replace( (char *)MenuLocalMSG, 1*LCDlineSIZE, 16);
					//UnlockDisplay(Sts->BeaconAlm.LocalFail_3G, 9);
				break;
			}
		}
		OSTimeDly(200);
	}
}





void BatteryDisplay(INT8U vaule, INT8U Blink, INT8U DisPtr)
{
	if(Blink == BlinkON)
	{
			 if(vaule == 0)ReplaceString( (char *)NotUseMSG,(char *)BlinkMSG, 	1 * LCDlineSIZE + DisPtr, strlen(NotUseMSG));
		else if(vaule == 1)ReplaceString( (char *)_extMSG,	(char *)BlinkMSG, 	1 * LCDlineSIZE + DisPtr, strlen(_extMSG));
		else if(vaule == 2)ReplaceString( (char *)_intMSG,	(char *)BlinkMSG, 	1 * LCDlineSIZE + DisPtr, strlen(_intMSG));
	}
	else
	{
			 if(vaule == 0)ReplaceString( (char *)NotUseMSG,(char *)NotUseMSG, 	1 * LCDlineSIZE + DisPtr, strlen(NotUseMSG));
		else if(vaule == 1)ReplaceString( (char *)_extMSG,	(char *)_extMSG, 	1 * LCDlineSIZE + DisPtr, strlen(_extMSG));
		else if(vaule == 2)ReplaceString( (char *)_intMSG,	(char *)_intMSG, 	1 * LCDlineSIZE + DisPtr, strlen(_intMSG));
	}
}


void PowerDisplay(INT16S vaule,INT8U Blink, INT8U EndPtr)
{
	INT16U	AttnConvData;
	
	AttnConvData = ((INT16U)vaule * 10L)/10L;
	DoubleDisplay(AttnConvData, Blink,  EndPtr);
}


void AttnDisplay(INT32S vaule,INT8U Blink, INT8U EndPtr)
{
	INT32S	AttnConvData;
	
	AttnConvData = ((INT32S)vaule * 10L)/2L;
	DoubleDisplay(AttnConvData, Blink,  EndPtr);
}

void DoubleDisplay(INT32S vaule, INT8U Blink, INT8U EndPtr)
{
	INT8U	DigitString[5];
	INT8U	DisCnt = 0;

	if(vaule < 0) // 음수 값
	{	
		vaule *= (INT32S)-1;
		DigitString[DisCnt++] = '-';
	}
	else DigitString[DisCnt++] = ' ';
	

	if(vaule >= 100)
	{
		DigitString[DisCnt++] = (vaule / (INT16S)100)+0x30;

		vaule = (vaule % (INT16S)100);
	}
	else
	{
		if(vaule > 0)DigitString[DisCnt++] = 0x20;
	}	
		
	DigitString[DisCnt++] = (vaule / 10)+0x30;
	vaule = (vaule % 10);
	
	DigitString[DisCnt++] = '.';
	DigitString[DisCnt++] = vaule + 0x30;

	if(Blink == BlinkON)
		 ReplaceString( (char *)DigitString,(char *)BlinkMSG,(1 * LCDlineSIZE + (EndPtr-(DisCnt-1))), DisCnt);	
	else ReplaceString( (char *)DigitString,(char *)DigitString,(1 * LCDlineSIZE + (EndPtr-(DisCnt-1))), DisCnt);	

}

void OutPwrDisplay(INT8S *vaule, INT8U Blink, INT8U EndPtr) // 정수, 소수 2Byte처리
{
	INT8U	DigitString[8];
	INT8U	DisCnt = 0;
	INT8S	Dec = vaule[0], Sq = vaule[1];

	if(Dec < 0) // 음수 값
	{	
		Dec *= (INT16S)-1;
		DigitString[DisCnt++] = '-';
	}
	else DigitString[DisCnt++] = ' ';
	

	if(Dec >= 100)Dec = (Dec % (INT16S)100);


	if(Dec >= 10)
	{
		DigitString[DisCnt++] = (Dec / (INT16S)10)+0x30;
		Dec = (Dec % 10);

	}
	else	DigitString[DisCnt++] = 0x20;
		
	DigitString[DisCnt++] = Dec + 0x30;
	
	DigitString[DisCnt++] = '.';

	if(Sq < 0)Sq *= (INT16S)-1;
	DigitString[DisCnt++] = Sq + 0x30;

	/*if(Blink == BlinkON)
		 ReplaceString( (char *)DigitString,(char *)BlinkMSG,(1 * LCDlineSIZE + (EndPtr-(DisCnt-1))), DisCnt);	
	else*/ ReplaceString( (char *)DigitString,(char *)DigitString,(1 * LCDlineSIZE + (EndPtr-(DisCnt-1))), DisCnt);	

}

void VauleDisplay(INT32S value, INT8U Blink,INT8U EndPtr)
{
	INT8U	DigitString[6] = {0x30, 0x30, 0x30, 0x30, 0x30, 0x30};
	INT8U	DisCnt = 0;

	if(value < 0) // 음수 값
	{	
		value *= -1;
		DigitString[DisCnt++] = '-';
	}
	else DigitString[DisCnt++] = ' ';

	if(value >= 1000) {
		DigitString[DisCnt++] = (value / 1000)+0x30;
		if(!(value = (value % 1000))) {DisCnt += 3; goto RINIT;}
	}
	
	if(value >= 100)
	{
		DigitString[DisCnt++] = (value / 100)+0x30;
		value = (value % 100);
		if(!(value = (value % 100 ))) {DisCnt += 2; goto RINIT;}
	}

	if(value >= 10)
	{
		DigitString[DisCnt++] = (value / 10)+0x30;
		value = (value % 10);
		if(!(value = (value % 10  ))) {DisCnt += 1; goto RINIT;}
	}
	
	DigitString[DisCnt++] = value + 0x30;

RINIT:
	if(Blink == BlinkON)
		 ReplaceString( (char *)DigitString,(char *)BlinkMSG,	(1 * LCDlineSIZE + (EndPtr-(DisCnt-1))), DisCnt);	
	else ReplaceString( (char *)DigitString,(char *)DigitString,(1 * LCDlineSIZE + (EndPtr-(DisCnt-1))), DisCnt);	
}

void AlmNrmDisplay(INT8U vaule, INT8U DisPtr)
{
	if(vaule) ReplaceString( (char *)AlarmMSG,(char *)AlarmMSG, 1 * LCDlineSIZE + DisPtr, strlen(AlarmMSG));
	else 	  ReplaceString( (char *)NormalMSG,(char *)NormalMSG, 1 * LCDlineSIZE + DisPtr, strlen(NormalMSG));	
	
}

void FailNrmDisplay(INT8U vaule, INT8U DisPtr)
{
	if(vaule) ReplaceString( (char *)FailMSG,(char *)FailMSG, 1 * LCDlineSIZE + DisPtr, strlen(FailMSG));
	else 	  ReplaceString( (char *)NormalMSG,(char *)NormalMSG, 1 * LCDlineSIZE + DisPtr, strlen(NormalMSG));	

}

void UnlockDisplay(INT8U value, INT8U DisPtr)
{
	if(value) ReplaceString( (char *)UnlockMSG,(char *)UnlockMSG, 1 * LCDlineSIZE + DisPtr, strlen(UnlockMSG));
	else 	  ReplaceString( (char *)LockMSG,(char *)LockMSG, 1 * LCDlineSIZE + DisPtr, strlen(LockMSG));	
}


void OnOffDisplay(INT8U value, INT8U Blink, INT8U DisPtr)
{
	if(Blink == BlinkON)
	{
		if(value == Enable)	ReplaceString( (char *)OnMSG,(char *)BlinkMSG, 1 * LCDlineSIZE + DisPtr, strlen(OnMSG));
		else	 			ReplaceString( (char *)OffMSG,(char *)BlinkMSG, 1 * LCDlineSIZE + DisPtr, strlen(OffMSG));
	}
	else
	{
		if(value == Enable) ReplaceString( (char *)OnMSG,(char *)OnMSG, 1 * LCDlineSIZE + DisPtr, strlen(OnMSG));
		else	 			ReplaceString( (char *)OffMSG,(char *)OffMSG, 1 * LCDlineSIZE + DisPtr, strlen(OffMSG));
	}
}

void ManufactureDisplay(INT8U value)
{
	const char *ptr = RSVMSG;
	char len = strlen(RSVMSG);
	
	switch(value)
	{
		case 0x11:	ptr = GTMSG;	break;
		case 0x17:	ptr = SUNMSG;	break;
	}
	
	ReplaceString( (char *)ptr,(char *)ptr, 1 * LCDlineSIZE + 11, len);
}

void RepeaterType(INT16S value)
{
	const char *ptr = COPYINMSG;
	char len = strlen(COPYINMSG);

	switch(value)
	{
		case __COPY_IN:		ptr = COPYINMSG;	break;
		case __COPY_OUT:	ptr = COPYOUTMSG;	break;
		case __GEN_IN:		ptr = GENINMSG;		break;
		case __GEN_OUT:		ptr = GENOUTMSG;	break;
		case __COPY_RACK:	ptr = COPYRACKMSG;	break;
		case __GEN_RACK:	ptr = GENRACKMSG;	break;
	}
	
	ReplaceString( (char *)ptr,(char *)ptr, 1 * LCDlineSIZE + 6, len);
}
void PathLossDisplay(INT16S value)
{
	const char *ptr = OffMSG;
	char len = strlen(OffMSG);
	switch(value)
	{
		case 0:	ptr = OkMSG;		break;
		case 1:	ptr = MaxAttnMSG;	break;
		case 2:	ptr = MinAttnMSG;	break;
		case 3:	ptr = CommFailMSG;	break;
		case 4:	ptr = NoSignalMSG;	break;
		case 5:	ptr = NoDeviceMSG;	break;
		case 6:	ptr = NoCNTLMSG;	break;
		case 8:	ptr = EtcMSG;		break;
		case 9:	ptr = OkMSG;		break;
	}
	ReplaceString( (char *)ptr,(char *)ptr, 1 * LCDlineSIZE, len);
	
}
void FADisplay(INT16S value, INT8U Blink)
{
	const char *ptr = OffMSG;
	char len = strlen(OffMSG);

	switch(value)
	{
		case 0:	ptr = OffMSG;	break;
		case 1: ptr = p_1FAMSG;	break;
		case 2: ptr = p_2FAMSG; break;
		case 3: ptr = p_3FAMSG; break;
		case 4: ptr = p_4FAMSG; break;
		case 5: ptr = p_7FAMSG; break;
		case 6: ptr = p_8FAMSG; break;

	}
	if(Blink == BlinkON)
	{
		ReplaceString( (char *)ptr,(char *)BlinkMSG, 1 * LCDlineSIZE + 12, len);
	}
	else
	{
		ReplaceString( (char *)ptr,(char *)ptr, 1 * LCDlineSIZE + 12, len);
	}

}
void PauMakerDisplay(INT16S value)
{
	const char *ptr = RSVMSG;
	char len = strlen(RSVMSG);

	switch(value)
	{
		case 1:	ptr = GSIMSG;	break;
		case 2:	ptr = RMMSG;	break;
		case 3:	ptr = SWMSG;	break;
		case 5: ptr = TSMSG;	break;
		case 6: ptr = WEMSG;	break;
		case 7: ptr = COMSG;	break;
		case 8: ptr = RHMSG;	break;
		case 9: ptr = HSMSG;	break;
		case 10:ptr = RFHICMSG;	break;
		case 11:ptr = EDMSG;    break;
		case 12:ptr = PWMSG;    break;
		case 13:ptr = STMSG;    break;
		case 14:ptr = SUNMSG;   break;
		case 15:ptr = NCLMSG;   break;
	}
	ReplaceString( (char *)ptr,(char *)ptr, 1 * LCDlineSIZE, len);

}

void SetDisplay(INT8U value, INT8U Blink, INT8U DisPtr)
{
	if(Blink == BlinkON)
	{
		ReplaceString( (char *)SetMSG,(char *)BlinkMSG, 1 * LCDlineSIZE + DisPtr, strlen(SetMSG));
	}
	else
	{
		ReplaceString( (char *)SetMSG,(char *)SetMSG, 1 * LCDlineSIZE + DisPtr, strlen(SetMSG));
	}
}

void ReplaceString (char * FwdMsg, char * BwdMsg, INT16U Addr, INT16U Cnt)
{
	cLcd->ReplaceOne( (char *)FwdMsg, Addr, Cnt, FwdWrite);
	cLcd->ReplaceOne( (char *)BwdMsg, Addr, Cnt, BwdWrite);
}

void InitKeyVal(void)
{
	IntINCKey = 0;
	IntDECKey = 0;
	IntMNUKey = 0;
	IntESCKey = 0;
	IntENTKey = 0;

	TimerRegist (TimerVFDOut, TimeVfdEscTime);
}


////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////


