
void FndFirstDataDisplay(void)
{
	FndBLink = FALSE;
	FndIsoDisplay();
	TimerRegist(TimerFnd, Time1Sec*10);
	TimerRegist(TimreFndData, Time1Sec);
}

void FndIsoDisplay(void)
{
	INT8U i = 0;
	
	ISO_LedSts = TRUE;
	DL_OUT_LedSts = FALSE;

	for(i = 0; i < 2; i++)
	{
		if(MainStatus->AlarmFlag[i].ISO_WAITING)
		{
			SEG_printf("", i);
		}
		else if(MainStatus->AlarmFlag[i].ISO_ALM)
		{
			SEG_printf("OFF", i);
		}
		else
		{
			char sptr[10];
			sprintf(sptr, "%d", MainStatus->IsolationLvl[i]/2);
			SEG_printf(sptr, i);
		}
	}
}

void FndOperDisplay(void)
{
	INT8U i = 0;
	
	ISO_LedSts = FALSE;
	DL_OUT_LedSts = TRUE;

	for(i = 0; i < 2; i++)
	{
		if(MainStatus->AlarmFlag[i].ISO_WAITING)
		{
			SEG_printf("", i);
		}
		else if(MainStatus->AlarmFlag[i].ISO_ALM)
		{
			SEG_printf("OFF", i);
		}
		else if(MainStatus->FwdPower[i] >= 250)
		{
			SEG_printf("Hi", i);
		}
		else if(MainStatus->FwdPower[i] < 0)
		{
			SEG_printf("Lo", i);
		}
		else
		{
			char sptr[10];
			int tmp = ((MainStatus->FwdPower[i]/2)*2);
			sprintf(sptr, "%d.%d", tmp/10,tmp%10);
			SEG_printf(sptr, i);
		}
	}
}

void FndDataDisplay(void)
{
	if(MainStatus->AlarmFlag[0].ISO_WAITING && MainStatus->AlarmFlag[0].ISO_WAITING)
	{
		// NO ACTION!!
		ISO_LedSts = FALSE;
		DL_OUT_LedSts = FALSE;
		SEG_printf("", 0);
		SEG_printf("", 1);
	}
	else
	{
		if(TimeOverCheck(TimreFndData))
		{
			if(!FndBLink) 	FndIsoDisplay();
			else			FndOperDisplay();
			TimerRegist(TimreFndData, Time1Sec);
		}

		if(TimeOverCheck(TimerFnd))
		{
			if(!FndBLink)	TimerRegist(TimerFnd, Time1Sec*10);
			else			TimerRegist(TimerFnd, Time1Sec*5);
			FndBLink = !FndBLink;
		}
	}

	_ISOLED = ISO_LedSts;
	_DLOUTLED = DL_OUT_LedSts;
}

void SEG_printf(char *sptr, INT8U IsIt3G)
{
	INT8U i = 0;
	INT8U len = strlen(sptr);
	INT8S segpos = 2;
	
	for(i = 0; i < 3; i++) SEG_Data[IsIt3G][i] = 0;

	while(len--)
	{
		if(sptr[len] == '.') SEG_Data[IsIt3G][segpos] |= 0x80;
		else if(segpos >= 0){
			SEG_Data[IsIt3G][segpos] |= sptr[len];
			segpos--;
		}
	}
}

void SEG_Display(INT8U Data, INT8U DotEn, INT8U Sel)
{
	INT8U tmp = 0;
	INT32U i = 0;

	if(DotEn) tmp = 0x80;

	for(i = 0; i < sizeof(SEG_TBL)/2; i++)
	{	
		if(Data == SEG_TBL[i][0]){
			break;
		}
	}
	tmp |= SEG_TBL[i][1];

	_4G_DIG_VCC1 = 0;
	_4G_DIG_VCC2 = 0;
	_4G_DIG_VCC3 = 0;

	_3G_DIG_VCC1 = 0;
	_3G_DIG_VCC2 = 0;
	_3G_DIG_VCC3 = 0;	

	     if(Sel == 0) _4G_DIG_VCC1 = 1;
	else if(Sel == 1) _4G_DIG_VCC2 = 1;
	else if(Sel == 2) _4G_DIG_VCC3 = 1;
	else if(Sel == 3) _3G_DIG_VCC1 = 1;
	else if(Sel == 4) _3G_DIG_VCC2 = 1;
	else if(Sel == 5) _3G_DIG_VCC3 = 1;

	_FND_A  = !((tmp >> 0) & 0x01);
	_FND_B  = !((tmp >> 1) & 0x01);
	_FND_C  = !((tmp >> 2) & 0x01);
	_FND_D  = !((tmp >> 3) & 0x01);
	_FND_E  = !((tmp >> 4) & 0x01);
	_FND_F  = !((tmp >> 5) & 0x01);
	_FND_G  = !((tmp >> 6) & 0x01);
	_FND_DP = !((tmp >> 7) & 0x01);
}


//=======================================================================//
// End of Source File
//=======================================================================//

