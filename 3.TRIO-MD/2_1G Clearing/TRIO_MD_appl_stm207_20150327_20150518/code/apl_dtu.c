
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : exlib.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define DTU_C

#include <math.h>
//#include "apl_main.h"
#include "main.h"

#define ____	USART3Printf("%s %d\n", __FUNCTION__, __LINE__);

void DtuInit(void)
{
	OSTaskCreate(DtuTask, (void *)NULL, (OS_STK *)&DtuTaskStk[DTU_STK_SIZE - 1], DTU_START_PRIO);
}

void DtuTask(void *p_arg)
{
	(void)p_arg;

	OSTimeDly(100u*DTU_START_PRIO);
	DTUSwResetFunc();

	while(1)
	{
//		while(!DownLoadGiveupTimerSet(NULL) && !gTestFlag)
		while(!DownLoadGiveupTimerSet(NULL))
		{
			if(DTUInitCheck()){
				if(!gTestFlag)DTUStatusUpdate();
				DtuStsUpdate();
			}
			OSTimeDly(50*1L);
		}
		OSTimeDly(500u);
	}
}

void DtuStsUpdate(void)
{
//  INT8U i,j;
  __Dnr_Sts *Sts = tDnrSts;

	if(IsItDTUInited != TRUE) return;

	Sts->ModuleAlarm.Main._10MPLL_LOCK =  !tDnrSts->DTU_PLL_STS._10MPLL_LOCK;
	Sts->ModuleAlarm.Main._ClockIC_LOCK = !tDnrSts->DTU_PLL_STS._ClockIC_LOCK;
	Sts->ModuleAlarm.Main._200MPLL_LOCK = !tDnrSts->DTU_PLL_STS._200MPLL_LOCK;


	if(tDnrSts->DtuSts_Alarm) 	Sts->ModuleAlarm.Main._DTU_Staus = Alarm;
	else    					Sts->ModuleAlarm.Main._DTU_Staus = Normal;

	ChkAgcChange = RESET;
}


void DTUSwResetFunc(void)
{
	_nFPGA_CONF_PROG = 0;
	OSTimeDly((500u));
	_nFPGA_CONF_PROG = SET;

	_nRCU_RST = RESET;
	OSTimeDly(500u);
	_nRCU_RST = SET;
	
	OSTimeDly(4000u);

	IsItDTUInited = FALSE;
}

INT8U RtnDTUInited(void)
{
	return IsItDTUInited;
}

INT8U DTUInitCheck(void)
{
	int i = 0, j = 0;
	INT8U tmpData;
	INT16U addr = 0;
	INT16U Data = 0;

//	if(_DTU_Insert == __RESET)
	if(_DTU_Insert)
	{
		tDnrSts->DtuSts_Alarm 					= SET;
		tDnrSts->ModuleAlarm.Main._DTU_Staus 	= Alarm;
	}

	if(!IsItDTUInited)		//DTU ÃÊ±âÈ­
	{
		tmpData = F_DONE;

		if( tmpData == RESET) DTUSwResetFunc();

		DTU_WriteData(CS0SEL, DTU_STATUS, INIT_CHECK_DATA);
		if(DTU_ReadData(CS0SEL, DTU_STATUS) != INIT_CHECK_DATA){
			if(DTULinkFailCnt++ >= 10){
				DTULinkFailCnt = 10;
				tDnrSts->DtuSts_Alarm = SET;
			}
			return FALSE;
		}
		else{
			tDnrSts->FPGAVer[0]  	= DTU_ReadData(CS0SEL, DTU_VER);
			tDnrSts->VendorID 		= DTU_ReadData(CS0SEL, DTU_VENDOR_ID);
			tDnrSts->UnitID   		= DTU_ReadData(CS0SEL, DTU_UNIT_ID);
			tDnrSts->FPGAAddVer		= DTU_ReadData(CS0SEL, DTU_AddVER);

			tDnrSts->BandFilterInfo = DTU_ReadData(CS0SEL, DTU_Filter_Info);


			DTULinkFailCnt 			= RESET;
			tDnrSts->DtuSts_Alarm 	= RESET;
			SerPtr->printf("FPGA Version[%x][%x][%x]\n",tDnrSts->FPGAVer[0] ,tDnrSts->VendorID ,tDnrSts->UnitID);
			Ser3Ptr->printf("FPGA Version[%x][%x][%x]\n",tDnrSts->FPGAVer[0] ,tDnrSts->VendorID ,tDnrSts->UnitID);

			// First Data Write !!
			DTU_WriteData(CS0SEL, DTU_BW_SEL_B0, tDnrSts->Band_Select_CDMALTE[0]);
			DTU_WriteData(CS0SEL, DTU_BW_SEL_B1, tDnrSts->Band_Select_LTE_A[0]);
			DTU_WriteData(CS0SEL, DTU_BW_SEL_B2, tDnrSts->Band_Select_WCDMALTE_21[0]);

			for(i = 0; i < SvrPATH_MAX; i++)
			{
				for(j = 0; j < 2; j++){
					
					addr = DTU_DLLAGCLevel_800M + 2*i + j;
					Data = tDnrSts->DTU_DLAGCLevel[i][j] - DTU_INIT_AGClevel;
					DTU_WriteData(CS0SEL, addr, Data);
				}
			}


			if(tDnrSts->FilterStart == Enable)
			{
				tDnrSts->FPGAAdd.Data = 0;
				
				FilterOperating();

				if((tDnrSts->FilterUSE[0] == SET)&&(tDnrSts->FilterUSE[1] == SET))
				{
					tDnrSts->Band_Select_CDMALTE[0] = 0x01;
					tDnrSts->FPGAAdd.Filter_800M = SET;
				}
				
				if((tDnrSts->FilterUSE[2] == SET)&&(tDnrSts->FilterUSE[3] == SET))
				{
					tDnrSts->Band_Select_LTE_A[0] = 0x01;
					tDnrSts->FPGAAdd.Filter_1800M = SET;
				}
				tDnrSts->FPGAVer[1] = tDnrSts->FPGAAdd.Data;
			}

#if 0	////20140424 Adder

			for(i = 0; i < Att_SelMax;i++)	AttnDataOutput(i, DIGATTENMAX);

			for(i = 0; i < SvrPATH_MAX; i++)
			{
				// DL AGC Gain
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_DLLAGCGain_800M, DTU_DLRAGCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_DLRAGCGain_1800M, DTU_DLLAGCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_DLLAGCGain_2100M, DTU_DLRAGCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						DTU_WriteData(CS0SEL, tmpAddr[i][j], DTU_INIT_GAIN - DIGATTENMAX);
					}
				}
	
				// UL AGC Gain
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_ULLAGCGain_800M, DTU_ULRAGCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_ULRAGCGain_1800M, DTU_ULLAGCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_ULLAGCGain_2100M, DTU_ULRAGCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						DTU_WriteData(CS0SEL, tmpAddr[i][j], DTU_INIT_GAIN - DIGATTENMAX);
					}
				}
	
				//DL ALC Attn
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_DLLALCGain_800M, DTU_DLRALCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_DLRALCGain_1800M, DTU_DLLALCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_DLLALCGain_2100M, DTU_DLRALCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						DTU_WriteData(CS0SEL, tmpAddr[i][j], DTU_INIT_GAIN - DIGATTENMAX);
					}
				}
	
				//DL ALC Attn
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_ULLALCGain_800M, DTU_ULRALCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_ULRALCGain_1800M, DTU_ULLALCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_ULLALCGain_2100M, DTU_ULRALCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						DTU_WriteData(CS0SEL, tmpAddr[i][j], DTU_INIT_GAIN - DIGATTENMAX);
					}
				}
			}
			OSTimeDly(500L);
#endif

			OSTimeDly(500L*3L);

			IsItDTUInited = TRUE;
		}
	}

    return TRUE;
}


INT8U DTUGetSpecData(INT8S *gptr,INT16U Path)
{
	int i = 0;
	type32 tmp;
	type16 tmpData;

	INT8U tmpDATA;

	// PATH SEL
	DTU_WriteData(CS0SEL, DTU_Spec_Path, Path);
	DTU_WriteData(CS0SEL, DTU_Spec_Start, 0x00);
	DTU_WriteData(CS0SEL, DTU_Spec_Start, 0x01);
 	OSTimeDly(100);
 //	tmp.uD8[0] = DTU_ReadData(CS0SEL, DTU_Spec_Busy);
	tmpDATA = DTU_ReadData(CS0SEL, DTU_Spec_Busy);
  
//	if(!tmp.uD8[0]) return FALSE;
	if(tmpDATA != 0x01) return FALSE;
	
	for(i = 0; i < 1024; i++){
		DTU_WriteData(CS0SEL, DTU_Spec_Addr + 0, hibyte(i));
		DTU_WriteData(CS0SEL, DTU_Spec_Addr + 1, lobyte(i));

		DTU_WriteData(CS0SEL, DTU_Spec_Rdn, 0x01);
		DTU_WriteData(CS0SEL, DTU_Spec_Rdn, 0x00);

		tmp.uD8[3] = DTU_ReadData(CS0SEL, DTU_Spec_Data + 0);
		tmp.uD8[2] = DTU_ReadData(CS0SEL, DTU_Spec_Data + 1);
		tmp.uD8[1] = DTU_ReadData(CS0SEL, DTU_Spec_Data + 2);
		tmp.uD8[0] = DTU_ReadData(CS0SEL, DTU_Spec_Data + 3);
		tmpData.uD16 = logx(tmp.uD32);

//		tmpData.uD16 = logx(tmp.uD32 + tDnrSts->SampleOffsetA.sD32) + tDnrSts->SampleOffsetB.uD16;
		gptr[2*i + 0] = tmpData.uD8[0];
		gptr[2*i + 1] = tmpData.uD8[1];
	}

    return TRUE;
}

void DTUStatusUpdate(void)
{
	int i = 0, j = 0;
	
	__Dnr_Sts *Sts = tDnrSts;

	if(Spectrum_Flag) return;
	if(DTU_ReadData(CS0SEL, DTU_STATUS) != INIT_CHECK_DATA)
	{
		if(DTULinkFailCnt++ >= 10){
			DTULinkFailCnt = 10;
			tDnrSts->DtuSts_Alarm = SET;
		}
	}
	else{
  	    DTULinkFailCnt 			= RESET;
		tDnrSts->DtuSts_Alarm 	= RESET;
		// status update

		tDnrSts->DTU_PLL_STS.Data 			= DTU_ReadData(CS0SEL, DTU_PLL_STS);

		tDnrSts->PathOnOff_800M.Data 		= DTU_ReadData(CS0SEL, DTU_PATHOnOff_800M);
		tDnrSts->PathOnOff_1800M.Data 		= DTU_ReadData(CS0SEL, DTU_PATHOnOff_1800M);
		tDnrSts->PathOnOff_2100M.Data 		= DTU_ReadData(CS0SEL, DTU_PATHOnOff_2100M);

		tDnrSts->SmartAGCDLOnOff.Data 		= DTU_ReadData(CS0SEL, DTU_DLAGCOnOff);
		tDnrSts->SmartAGCULOnOff.Data 		= DTU_ReadData(CS0SEL, DTU_ULAGCOnOff);


		{
			type32 tmp;
			for(i = 0; i < DTU_Power_MAX; i++)
			{
				DTU_WriteData(CS0SEL, DTU_ReadSelect, i);

				///Power Select  
				// filter peak power
				{
					INT8U tmpAddr = DTU_PeakPower_B0;

					tmp.sD8[3] = DTU_ReadData(CS0SEL, tmpAddr + 0);
					tmp.sD8[2] = DTU_ReadData(CS0SEL, tmpAddr + 1);
					tmp.sD8[1] = DTU_ReadData(CS0SEL, tmpAddr + 2);
					tmp.sD8[0] = DTU_ReadData(CS0SEL, tmpAddr + 3);

					Sts->DTUPeakPower[i].sD16 = logx(tmp.uD32)+ Sts->DTUPeakOffset[i].sD16 - InitPeakOffset[i];

				}

				// filter Aver power
				{
					INT8U tmpAddr = DTU_AverPower_B0;

					tmp.sD8[3] = DTU_ReadData(CS0SEL, tmpAddr + 0);
					tmp.sD8[2] = DTU_ReadData(CS0SEL, tmpAddr + 1);
					tmp.sD8[1] = DTU_ReadData(CS0SEL, tmpAddr + 2);
					tmp.sD8[0] = DTU_ReadData(CS0SEL, tmpAddr + 3);

					Sts->DTUAverPower[i].sD16 = logx(tmp.uD32)+ Sts->DTUAverOffset[i].sD16 - InitAverOffset[i];
				}
			}
			
			for(i = 0; i < SvrPATH_MAX; i++)
			{
				// DL AGC Gain
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_DLLAGCGain_800M, DTU_DLRAGCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_DLRAGCGain_1800M, DTU_DLLAGCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_DLLAGCGain_2100M, DTU_DLRAGCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						Sts->DLAGCAttn[i][j] = DTU_ReadData(CS0SEL, tmpAddr[i][j]);
					}
				}
	
				// UL AGC Gain
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_ULLAGCGain_800M, DTU_ULRAGCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_ULRAGCGain_1800M, DTU_ULLAGCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_ULLAGCGain_2100M, DTU_ULRAGCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						Sts->ULAGCAttn[i][j] = DTU_ReadData(CS0SEL, tmpAddr[i][j]);
					}
				}
	
				//DL ALC Attn
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_DLLALCGain_800M, DTU_DLRALCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_DLRALCGain_1800M, DTU_DLLALCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_DLLALCGain_2100M, DTU_DLRALCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						Sts->DLALCAttn[i][j] = DTU_ReadData(CS0SEL, tmpAddr[i][j]);
					}
				}
	
				//DL ALC Attn
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_ULLALCGain_800M, DTU_ULRALCGain_800M}, 	//	800MHz UL after filter peak power
						{DTU_ULRALCGain_1800M, DTU_ULLALCGain_1800M},	// 1800MHz UL after filter peak power
						{DTU_ULLALCGain_2100M, DTU_ULRALCGain_2100M}	// 2100MHz UL after filter peak power
					};
				
					for(j = 0; j < 2; j++){
						Sts->ULALCAttn[i][j] = DTU_ReadData(CS0SEL, tmpAddr[i][j]);
					}
				}
				//DTU DL AGCLevel
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_DLLAGCLevel_800M, DTU_DLRAGCLevel_800M}, 	//	800MHz 
						{DTU_DLLAGCLevel_1800M, DTU_DLRAGCLevel_1800M},	// 1800MHz 
						{DTU_DLLAGCLevel_2100M, DTU_DLRAGCLevel_2100M}	// 2100MHz 
					};
				
					for(j = 0; j < 2; j++){
						Sts->DTU_DLAGCLevel[i][j] = DTU_ReadData(CS0SEL, tmpAddr[i][j]);
					}
				}

				//DTU UL AGCLevel
				{
					INT8U tmpAddr[SvrPATH_MAX][2] = {					// dtu channel address
						{DTU_ULLAGCLevel_800M, DTU_ULRAGCLevel_800M}, 	//	800MHz
						{DTU_ULLAGCLevel_1800M, DTU_ULRAGCLevel_1800M},	// 1800MHz
						{DTU_ULLAGCLevel_2100M, DTU_ULRAGCLevel_2100M}	// 2100MHz
					};
				
					for(j = 0; j < 2; j++){
						Sts->DTU_ULAGCLevel[i][j] = DTU_ReadData(CS0SEL, tmpAddr[i][j]);
					}
				}

				if((ISOOnOffStart == Enable)||(tDnrSts->ISOMode == 0x01))
				{
					INT32U ecs_x, ecs_0;

					{
						tmp.sD8[3] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 0);
						tmp.sD8[2] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 1);
						tmp.sD8[1] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 2);
						tmp.sD8[0] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 3);
						ecs_0 = tmp.uD32;

						tmp.sD8[3] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 0);
						tmp.sD8[2] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 1);
						tmp.sD8[1] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 2);
						tmp.sD8[0] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 3);
						ecs_x = tmp.uD32;

						if(tDnrSts->ISOMode == 0x01)
						{
							INT16S Temp;
							Temp = -log2x((double)ecs_x/(double)ecs_0);
							if(( Temp > 0)&&( Temp <= 600))
							{
								tDnrSts->ISO[tDnrSts->ISOSelect%16].sD16 = Temp;
							}
						}
						else
						{

							INT16U CurrAttn = 0;
							INT16S Temp;
							
							Temp = -log2x((double)ecs_x/(double)ecs_0);

							if(( Temp > 0)&&( Temp <= 600))
							{
								ISO_DATA[ISOStartCnt].sD16 = Temp;
								if(ISO_DATA[ISOStartCnt].sD16 >= 300) ISO_DATA[ISOStartCnt].sD16 = 300;

								if(tDnrSts->ISOSelect == 0x3)
								{
									CurrAttn = tDnrSts->RvsGainSts_2G;
								}
								else if(tDnrSts->ISOSelect == 0x13)
								{
									CurrAttn = tDnrSts->RvsGainSts_LTE;
								}
								else if((tDnrSts->ISOSelect == 0x4)||(tDnrSts->ISOSelect == 0x14))
								{
									CurrAttn = tDnrSts->RvsGainSts_LTE_A2;
								}
								else if(tDnrSts->ISOSelect == 0x5)
								{
									CurrAttn = tDnrSts->RvsGainSts_LTE_21;
								}
								else if(tDnrSts->ISOSelect == 0x15)
								{
									CurrAttn = tDnrSts->RvsGainSts_3G;
								}
	
								ISO_DATA[ISOStartCnt].sD16	= ISO_DATA[ISOStartCnt].sD16 + CurrAttn * 5 + + Sts->ISOOffset[tISOSelect].sD16;

								ISOStartCnt++;

								ISOCntInit = 0;
							}
							else
							{
								if(ISOCntInit++ > 10)
								{
									tDnrSts->ISOSelect = 0x03;
									if(tISOSelect == 3)  		tDnrSts->ISOSelect = 0x03;
									else if(tISOSelect == 4)  	tDnrSts->ISOSelect = 0x04;
									else if(tISOSelect == 5)  	tDnrSts->ISOSelect = 0x05;
									IsolationPathSelect(tDnrSts->ISOSelect);
									
									ChkISOSet = RESET;
								}
							}

							
							if((tDnrSts->ISOSelect == 0x0)||(tDnrSts->ISOSelect == 0x10)||(tDnrSts->ISOSelect == 0x3)||(tDnrSts->ISOSelect == 0x13))
							{
								if(ISO_DATA[ISOStartCnt].sD16  >= DTU_ISO_800M_Max) ISO_DATA[ISOStartCnt].sD16	= DTU_ISO_800M_Max;
							}
							
							if((tDnrSts->ISOSelect == 0x1)||(tDnrSts->ISOSelect == 0x11)||(tDnrSts->ISOSelect == 0x4)||(tDnrSts->ISOSelect == 0x14))
							{
								if(ISO_DATA[ISOStartCnt].sD16  >= 1160) ISO_DATA[ISOStartCnt].sD16	= 1160;
							}

							if((tDnrSts->ISOSelect == 0x2)||(tDnrSts->ISOSelect == 0x12)||(tDnrSts->ISOSelect == 0x5)||(tDnrSts->ISOSelect == 0x15))
							{
								if(ISO_DATA[ISOStartCnt].sD16  >= 1170) ISO_DATA[ISOStartCnt].sD16	= 1170;
							}
						}
					}
					ISOOnOffStart = Disable;
				}
			}
		}
	}
}


void DTU_WriteData(INT8U SEL, INT8U Addr, INT8U Data)
{
#if 0
	INT8U err;
	INT32U pAddr = ExpioCS0[SEL]/16;
	INT32U bAddr = ExpioCS0[SEL]%16;
	
	OSSemPend(ExpioSem, 0, &err);
	{
		
		_RCPU_ALE = 0;
		// low
		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) &=	~(1 << bAddr);
		
		ExpioModeChanege(0);

		GPIOC->__B.ODR.B0  = (Addr >> 0) & 0x01;
		GPIOC->__B.ODR.B1  = (Addr >> 1) & 0x01;
		GPIOG->__B.ODR.B8  = (Addr >> 2) & 0x01;
		GPIOA->__B.ODR.B11 = (Addr >> 3) & 0x01;
		GPIOC->__B.ODR.B4  = (Addr >> 4) & 0x01;
		GPIOC->__B.ODR.B5  = (Addr >> 5) & 0x01;
		GPIOB->__B.ODR.B0  = (Addr >> 6) & 0x01;
		GPIOB->__B.ODR.B1  = (Addr >> 7) & 0x01;

		// high
		_RCPU_ALE = 1;
		_RCPU_ALE = 0;
		
		GPIOC->__B.ODR.B0  = (Data >> 0) & 0x01;
		GPIOC->__B.ODR.B1  = (Data >> 1) & 0x01;
		GPIOG->__B.ODR.B8  = (Data >> 2) & 0x01;
		GPIOA->__B.ODR.B11 = (Data >> 3) & 0x01;
		GPIOC->__B.ODR.B4  = (Data >> 4) & 0x01;
		GPIOC->__B.ODR.B5  = (Data >> 5) & 0x01;
		GPIOB->__B.ODR.B0  = (Data >> 6) & 0x01;
		GPIOB->__B.ODR.B1  = (Data >> 7) & 0x01;
		// low
		_RCPU_RWn = 0;
		// low
//		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) &=	~(1 << bAddr);
		// high
		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) |=	 (1 << bAddr);

		ExpioModeChanege(1);
		_RCPU_RWn = 1;
	}
	OSSemPost(ExpioSem);
#endif	
#if 1
	INT8U err;
	INT32U pAddr = ExpioCS0[SEL]/16;
	INT32U bAddr = ExpioCS0[SEL]%16;
	
	OSSemPend(ExpioSem, 0, &err);
	{
		
		_RCPU_ALE = 0;
		ExpioModeChanege(0);

		GPIOC->__B.ODR.B0  = (Addr >> 0) & 0x01;
		GPIOC->__B.ODR.B1  = (Addr >> 1) & 0x01;
		GPIOG->__B.ODR.B8  = (Addr >> 2) & 0x01;
		GPIOA->__B.ODR.B11 = (Addr >> 3) & 0x01;
		GPIOC->__B.ODR.B4  = (Addr >> 4) & 0x01;
		GPIOC->__B.ODR.B5  = (Addr >> 5) & 0x01;
		GPIOB->__B.ODR.B0  = (Addr >> 6) & 0x01;
		GPIOB->__B.ODR.B1  = (Addr >> 7) & 0x01;

		// high
		_RCPU_ALE = 1;
		_RCPU_ALE = 0;
		
		GPIOC->__B.ODR.B0  = (Data >> 0) & 0x01;
		GPIOC->__B.ODR.B1  = (Data >> 1) & 0x01;
		GPIOG->__B.ODR.B8  = (Data >> 2) & 0x01;
		GPIOA->__B.ODR.B11 = (Data >> 3) & 0x01;
		GPIOC->__B.ODR.B4  = (Data >> 4) & 0x01;
		GPIOC->__B.ODR.B5  = (Data >> 5) & 0x01;
		GPIOB->__B.ODR.B0  = (Data >> 6) & 0x01;
		GPIOB->__B.ODR.B1  = (Data >> 7) & 0x01;
		// low
		_RCPU_RWn = 0;
		// low
		
		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) &=	~(1 << bAddr);
		// high
		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) |=	 (1 << bAddr);

		ExpioModeChanege(1);
		_RCPU_RWn = 1;
	}
	OSSemPost(ExpioSem);
#endif	

}

INT16U DTU_ReadData(INT8U SEL, INT8U Addr)
{
#if 0
	INT16U ret = 0;
	INT8U err;

	INT32U pAddr = ExpioCS0[SEL]/16;
	INT32U bAddr = ExpioCS0[SEL]%16;
	
	OSSemPend(ExpioSem, 0, &err);

	{
		// low
		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) &= ~(1 << bAddr);

		_RCPU_RWn = 1;	
	  	_RCPU_ALE = 0;
	   	ExpioModeChanege(0);

		GPIOC->__B.ODR.B0  = (Addr >> 0) & 0x01;
		GPIOC->__B.ODR.B1  = (Addr >> 1) & 0x01;
		GPIOG->__B.ODR.B8  = (Addr >> 2) & 0x01;
		GPIOA->__B.ODR.B11 = (Addr >> 3) & 0x01;
		GPIOC->__B.ODR.B4  = (Addr >> 4) & 0x01;
		GPIOC->__B.ODR.B5  = (Addr >> 5) & 0x01;
		GPIOB->__B.ODR.B0  = (Addr >> 6) & 0x01;
		GPIOB->__B.ODR.B1  = (Addr >> 7) & 0x01;
	   
		// high
		_RCPU_ALE = 1;
		_RCPU_ALE = 0;
		// low
//		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) &=	~(1 << bAddr);

		ExpioModeChanege(1);

		ret = (ret << 1) | (GPIOB->__B.IDR.B1 );
		ret = (ret << 1) | (GPIOB->__B.IDR.B0 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B5 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B4 );
		ret = (ret << 1) | (GPIOA->__B.IDR.B11);
		ret = (ret << 1) | (GPIOG->__B.IDR.B8 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B1 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B0 );

	   // SEL
	   // high
	   *(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) |=	(1 << bAddr);
	}
	OSSemPost(ExpioSem);
	return ret;
#endif	

#if 1
	INT16U ret = 0;
	INT8U err;

	INT32U pAddr = ExpioCS0[SEL]/16;
	INT32U bAddr = ExpioCS0[SEL]%16;
	
	OSSemPend(ExpioSem, 0, &err);

	{
		_RCPU_RWn = 1;	
	  	_RCPU_ALE = 0;
	   	ExpioModeChanege(0);

		GPIOC->__B.ODR.B0  = (Addr >> 0) & 0x01;
		GPIOC->__B.ODR.B1  = (Addr >> 1) & 0x01;
		GPIOG->__B.ODR.B8  = (Addr >> 2) & 0x01;
		GPIOA->__B.ODR.B11 = (Addr >> 3) & 0x01;
		GPIOC->__B.ODR.B4  = (Addr >> 4) & 0x01;
		GPIOC->__B.ODR.B5  = (Addr >> 5) & 0x01;
		GPIOB->__B.ODR.B0  = (Addr >> 6) & 0x01;
		GPIOB->__B.ODR.B1  = (Addr >> 7) & 0x01;
	   
		// high
		_RCPU_ALE = 1;
		_RCPU_ALE = 0;
		// low
		*(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) &=	~(1 << bAddr);

		ExpioModeChanege(1);

		ret = (ret << 1) | (GPIOB->__B.IDR.B1 );
		ret = (ret << 1) | (GPIOB->__B.IDR.B0 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B5 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B4 );
		ret = (ret << 1) | (GPIOA->__B.IDR.B11);
		ret = (ret << 1) | (GPIOG->__B.IDR.B8 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B1 );
		ret = (ret << 1) | (GPIOC->__B.IDR.B0 );

	   // SEL
	   // high
	   *(volatile INT32U *)(AHB1PERIPH_BASE + pAddr + 0x14) |=	(1 << bAddr);
	}
	OSSemPost(ExpioSem);
	return ret;
#endif	

}

void FilterCoefficientWrite(INT8U Path)
{
	__Dnr_Sts *Sts = tDnrSts;
	INT8U i = 0;
	INT8U Addr = 0;

	__FilterTblStr *table = (__FilterTblStr *)FilterTable;


	DTU_WriteData(CS0SEL, DTU_Coefficient_Sel,		table[Path].Path);
	DTU_WriteData(CS0SEL, DTU_Coefficient_FregSel,	table[Path].DLFreg_Sel);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg, 	table[Path].DLFreg_Data[0]);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg+1,	table[Path].DLFreg_Data[1]);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg+2,	table[Path].DLFreg_Data[2]);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg+3,	table[Path].DLFreg_Data[3]);
	DTU_WriteData(CS0SEL, DTU_Coefficient_FregSel,	table[Path].ULFreg_Sel);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg, 	table[Path].ULFreg_Data[0]);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg+1,	table[Path].ULFreg_Data[1]);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg+2,	table[Path].ULFreg_Data[2]);
	DTU_WriteData(CS0SEL, DTU_Coefficient_Freg+3,	table[Path].ULFreg_Data[3]);


	Sts->Coeff_Ctrl.Data = 0x00;
	Sts->Coeff_Ctrl.wea = SET;
	DTU_WriteData(CS0SEL, DTU_Coefficient_ctl, Sts->Coeff_Ctrl.Data);
	OSTimeDly(500);
#if 0
	for(i = 0 ; i < table[Path].Filter_Cnt; i++)
	{
		pUSART3.printf("FilterCoefficientWrite:[%d][%d]>[%x]\n",Path,i,table[Path].Filter_Data[i]);
	}
#endif

	for(i = 0 ; i < table[Path].Filter_Cnt/2; i++)
	{
		DTU_WriteData(CS0SEL, DTU_Coefficient_Addr, Addr + i);

		DTU_WriteData(CS0SEL, DTU_Coefficient_Data, 	table[Path].Filter_Data[2*i]);
		DTU_WriteData(CS0SEL, DTU_Coefficient_Data+1, 	table[Path].Filter_Data[2*i+1]);

		Sts->Coeff_Ctrl.Write = SET;
		Sts->Coeff_Ctrl.wea   = SET;

		DTU_WriteData(CS0SEL, DTU_Coefficient_ctl, Sts->Coeff_Ctrl.Data);

		Sts->Coeff_Ctrl.Write = RESET;
		Sts->Coeff_Ctrl.wea   = SET;

		DTU_WriteData(CS0SEL, DTU_Coefficient_ctl, Sts->Coeff_Ctrl.Data);
	}

	Sts->Coeff_Ctrl.wea 		= RESET;
	Sts->Coeff_Ctrl.LoadEnable	= SET;

	DTU_WriteData(CS0SEL, DTU_Coefficient_ctl, Sts->Coeff_Ctrl.Data);
}


void FilterOperating(void)
{
	INT8U i = 0;
	__Dnr_Sts *Sts = tDnrSts;
	
	for(i = 0 ; i < (DTU_FilterDN_MAX - 1); i++)
	{
		if(Sts->FilterUSE[i] == SET )
		{
			FilterCoefficientWrite(i);
		}
	}
}


void FilterRxCheck(INT8U* Data,INT16U nCnt)
{
	INT8U Temp = 0;
	INT16U Len = 0,nLen = 0,sLen = 0;

	INT16U i = 0,j = 0; 
	INT8U FilterID = 0;
	INT8U FilterCnt = 0;
	INT8S tIndex = 0;

	__Dnr_Sts *Sts = tDnrSts;
	
	__FilterTblStr *table = (__FilterTblStr *)FilterTable;

	for(i = 0 ; i < (DTU_FilterDN_MAX - 1); i++)
	{

		table[i].Flag = 0;
	}

FilterCheck_START:	
	for ( i = sLen; i < nCnt; i++ ) 
	{
		if ( Data[Len] == ',' ) break;

		Temp = atoh(Data[Len++]);
		Temp = atoh(Data[Len++]) + ( Temp << 4 );
		
		FilterDataBuff[i-sLen] = Temp;
	}


	FilterID = FilterDataBuff[nLen++];
	tIndex = FilterID - 1;

	table[tIndex].Flag 				= SET;
	table[tIndex].Path 				= FilterID;
	table[tIndex].DLFreg_Sel 		= FilterDataBuff[nLen++];

	table[tIndex].DLFreg_Data[0]	= FilterDataBuff[nLen++];
	table[tIndex].DLFreg_Data[1]	= FilterDataBuff[nLen++];
	table[tIndex].DLFreg_Data[2]	= FilterDataBuff[nLen++];
	table[tIndex].DLFreg_Data[3]	= FilterDataBuff[nLen++];

	table[tIndex].ULFreg_Sel		= FilterDataBuff[nLen++];

	table[tIndex].ULFreg_Data[0]	= FilterDataBuff[nLen++];
	table[tIndex].ULFreg_Data[1]	= FilterDataBuff[nLen++];
	table[tIndex].ULFreg_Data[2]	= FilterDataBuff[nLen++];
	table[tIndex].ULFreg_Data[3]	= FilterDataBuff[nLen++];

	table[tIndex].Filter_Cnt 		= (i-sLen)-11;

	FilterCnt = table[tIndex].Filter_Cnt;

	for(j = 0 ; j < FilterCnt; j++)
	{
		table[tIndex].Filter_Data[j]	= FilterDataBuff[nLen+j];
	}


	{
		INT16U ntableBp = 0;
		INT8U tsize;
	
		tsize = table[tIndex].Filter_Cnt + 13;
	
		ntableBp = (FilterBp + tIndex*(sizeof(__FilterTblStr)));
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], tsize);
	}

	if((nCnt > (Len+3))&&(nCnt - Len+3) >= 60)
	{
		sLen = Len;
		nLen = 0;
		Len++;


		goto FilterCheck_START;
	}

	if(table[0].Flag == SET)	Sts->FilterUSE[0] = Install;
	else						Sts->FilterUSE[0] = RESET;

	if(table[1].Flag == SET)	Sts->FilterUSE[1] = SET;
	else						Sts->FilterUSE[1] = RESET;

	if(table[2].Flag == SET)	Sts->FilterUSE[2] = SET;
	else						Sts->FilterUSE[2] = RESET;

	if(table[3].Flag == SET)	Sts->FilterUSE[3] = SET;
	else						Sts->FilterUSE[3] = RESET;

	if(table[4].Flag == SET)	Sts->FilterUSE[4]= SET;
	else						Sts->FilterUSE[4]= RESET;

	if(table[5].Flag == SET)	Sts->FilterUSE[5]= SET;
	else						Sts->FilterUSE[5]= RESET;

	for(i = 0; i < DTU_FilterDN_MAX; i++)
	{
		EE_BACK1 *tptr = &gEE_BACK1;

		tptr->BackUp.FilterUSE[i] = Sts->FilterUSE[i];

		WriteEEprom(At24cDevID, SearchOffsetEeprom((INT32U)&tptr->BackUp.FilterUSE[i]), Sts->FilterUSE[i], 0);
	}
}
///////////////////////////////////////////////////////////////////////////
// End of Source File
//////////////////////

