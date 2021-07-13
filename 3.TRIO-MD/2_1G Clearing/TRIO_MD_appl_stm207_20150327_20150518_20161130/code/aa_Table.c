/******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
* File Name          : fsmc_sram.h
* Author             : MCD Application Team
* Version            : V2.0.2
* Date               : 07/11/2008
* Description        : Header for fsmc_sram.c file.
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/
#define TABLE_C

#include "../include/main.h"

INT16U SearchOffsetEeprom(INT32U offsetptrAddr)
{
	INT16U rval = vEE_BACK1Addr;

	INT32U bAddr = (INT32U)&gEE_BACK1;
	INT32U tmpoffset = offsetptrAddr - bAddr;

	return((INT16U)(rval + tmpoffset));	
}

INT16U SearchOffsetEeprom1(INT32U offsetptrAddr)
{
	INT16U rval = FilterBp;

	INT32U bAddr = (INT32U)&gFilterTblStr;
	INT32U tmpoffset = offsetptrAddr - bAddr;

	return((INT16U)(rval + tmpoffset));	
}


void Response_Table(__ProtocolPtr *nPtr)
{
	INT8U TblID = 0;
	INT8S tIndex = 0;

//	INT8S tlimit;
	INT8U tsize;
//	INT32U tbllen = 0;		//, mlen = 0;
	INT32U i = 0;
//	INT8U err = 0;
	INT8U rtry = 5;
	INT8U Comm;

//	INT16S *tblptr16 = NULL;

	INT8U *tptr, *sptr;
	INT16U ntableBp = 0;

	__WRCSSIO *Recv = nPtr->WRCSRecv;
	__WRCSSIO *Send = nPtr->WRCSSend;

    __BODYFRAME *rBody = &Recv->BodyFrame[Recv->cBody];
    __BODYFRAME *sBody = &Send->BodyFrame[Recv->cBody];

	TblID = rBody->SubData[0];
	Comm = rBody->Command;
		
	INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};

	if( (tIndex = TableIndex(TblID)) == -1) return;

//	OSSemPend(pBackupSem, 0, &err);
//	OSSemPend(AlcSem, 0, &err );
//	OSSemPend(ExpSem, 0, &err );


	while(ASTART && rtry--){
		OSTimeDly(10);
	}

	switch(TblID)	//command 체크
	{
		case Index_FwdOutAvgPwr_CDMALTE 	: 
		case Index_RvsOutPwr_CDMALTE		: 
		case Index_FwdOutAvgPwr_LTE_A		: 
		case Index_RvsOutPwr_LTE_A			: 
		case Index_FwdOutAvgPwr_3G			: 
		case Index_RvsOutPwr_3G 			:
		{
			__OutputTblStr *table = (__OutputTblStr *)OutputTable;
			

			if((Comm == DDRTableSetQue))
			{
				ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));
				table[tIndex].limit = rBody->SubData[1];
				tsize = table[tIndex].nsize = rBody->SubData[2];
				if( tsize > OutputTBL_Size)  tsize = table[tIndex].nsize =  OutputTBL_Size; 

//		Ser3Ptr->printf("0 tmppwrout[%0d],%0d\n",DtuSts->DTUAverPower[DTU_DLAPower_800M_L].sD16, tmppwrout);

				//////20140424 추가 

//				tlimit = PwrTablelimitLocation(tIndex,0);
//				if( TblLmtCheck(table[tIndex].limit,tlimit) == Alarm)table[tIndex].limit = tlimit;

				tptr = (INT8U *)table[tIndex].Data;
				sptr = (INT8U *)&rBody->SubData[3];

//				for(i = 0; i < tsize && i < (OutputTBL_Size); i++)
				for(i = 0; i < tsize ; i++)
				{
					*((INT16U *)(tptr) + i) = swab16p(((INT16U *)sptr + i));
				}
				TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
			}

			{
				int j = 0;
				tptr = (INT8U *)(Send->BodyFrame[0].SubData);

				*tptr++ = rBody->SubData[0];
				*tptr++ = table[tIndex].limit;
				*tptr++ = (table[tIndex].nsize);

		//		for(i = 0; i < ((table[tIndex].nsize)&& i < (OutputTBL_Size)); i++)
		

				for(i = 0; i < ((table[tIndex].nsize)); i++)
				{
					tptr[j++] = table[tIndex].Data[i] >> 8;
					tptr[j++] = table[tIndex].Data[i] >> 0;
				}
				sBody->SubLength = 3 + (i*2);
			}
		}
		break;


		case Index_FwdAttn1_CDMALTE 	: 
		case Index_RvsAttn1_CDMALTE 	: 
		case Index_RvsAttn2_CDMALTE 	: 
		case Index_RvsAttn3_CDMALTE 	: 


		case Index_FwdAttn1_LTE_A		: 
		case Index_RvsAttn1_LTE_A		: 
		case Index_RvsAttn2_LTE_A		: 
		case Index_RvsAttn3_LTE_A		: 

		case Index_FwdAttn1_3G			:	
		case Index_RvsAttn1_3G			:	
		case Index_RvsAttn2_3G			:	
		case Index_RvsAttn3_3G			:	

		{
			__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
			if(Comm == DDRTableSetQue)
			{
				ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

				table[tIndex].limit = rBody->SubData[1];
				tsize = table[tIndex].nsize = rBody->SubData[2];
				if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 
				tptr = (INT8U *)table[tIndex].Data;
				sptr = (INT8U *)&rBody->SubData[3];

//				for(i = 0; i < tsize && i < (AttTBL_Size); i++)
				for(i = 0; i < tsize; i++)
				{
					*((INT8U *)(tptr) + i) = *((INT8U *)sptr + i);
				}
				TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

			}
			{
				int j = 0;
				tptr = (INT8U *)(Send->BodyFrame[0].SubData);

				*tptr++ = rBody->SubData[0];

				*tptr++ = table[tIndex].limit;
				*tptr++ = table[tIndex].nsize;
				for(i = 0; i < ((table[tIndex].nsize)); i++)
//				for(i = 0; i < ((table[tIndex].nsize)&& i < (AttTBL_Size)); i++)
				for(i = 0; i < (table[tIndex].nsize); i++)
				{
					tptr[j++] = table[tIndex].Data[i];
				}
				sBody->SubLength = 3 + (i);

//				SerPtr->printf("1: tIndex[%d]>[%d][%d]>[%d]\n", tIndex,table[tIndex].limit,table[tIndex].nsize,i);
				
			}
		}			
		break;

		case Index_FwdTempAttn_2G  		:
		case Index_RvsTempAttn_2G  		:
		case Index_FwdTempAttn_LTE_A	:
		case Index_RvsTempAttn_LTE_A	:
		case Index_FwdTempAttn_3G  		:
		case Index_RvsTempAttn_3G		:
		{
			__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
						
			if(Comm == DDRTableSetQue)
			{
				ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

				table[tIndex].limit = rBody->SubData[1];
				tsize = table[tIndex].nsize = rBody->SubData[2];
				if( tsize > TempTBL_Size)  tsize = table[tIndex].nsize = TempTBL_Size; 

				tptr = (INT8U *)table[tIndex].Data;
				sptr = (INT8U *)&rBody->SubData[3];
					
//				for(i = 0; i < tsize && i < (TempTBL_Size); i++)
				for(i = 0; i < tsize; i++)
				{
					*((INT8U *)(tptr) + i) = *((INT8U *)sptr + i);
				}
				TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
			}

			{
				int j = 0;
				tptr = (INT8U *)(Send->BodyFrame[0].SubData);

				*tptr++ = rBody->SubData[0];
				*tptr++ = table->limit;
				*tptr++ = (table->nsize);
				
//				for(i = 0; i < ((table[tIndex].nsize)&& i < (TempTBL_Size)); i++)
				for(i = 0; i < (table[tIndex].nsize); i++)
				{
					tptr[j++] = table[tIndex].Data[i];
				}
				sBody->SubLength = 3 + (i);
			}
		}			
		break;
		default:
    	break;
	}
//	OSSemPost(AlcSem);
//	OSSemPost(ExpSem);
//	OSSemPost(pBackupSem);

	GenBodyFrame(tid, (INT8U *)Send->BodyFrame[0].SubData, Send->BodyFrame[0].SubLength, Comm, nPtr, 0);
	WRCS_ProDataAckTx(nPtr);
}

// sptr(setup ptr)
void TableIndexBackup(INT16U EEADDR, INT32U sptr, INT32U len)
{
	INT32U i = 0;
	INT8U *ptr = ((INT8U *)sptr);
	INT8U verify = 0;
	
	for(i = 0; i < len; i++) 
	{
		verify = *ptr;

//		pUSART3.printf("1: TableIndexBackup = [%d][%x] \n", i,*ptr);

		if(verify != (INT8U)WriteEEprom(At24cDevID, EEADDR++, *ptr++, 0))
		{
			#ifdef Debug_Mode
				Ser1Printf("error\n");
			#endif
			return;
		}
	}
}



// sptr(setup ptr)
void TableIndexBackup_1(INT16U EEADDR, INT32U sptr, INT32U len)
{
	INT32U i = 0;
	INT8U *ptr = ((INT8U *)sptr);
	INT8U verify = 0;
	
	for(i = 0; i < len; i++) 
	{
		verify = *ptr;

		pUSART3.printf("1: TableIndexBackup = [%d]:[%x]\n", i,verify);
		*ptr++;
	}
}

void TableBackup(INT16U EEADDR, INT8U *sptr, INT32U len)
{
	INT32U i = 0;
	INT8U *ptr = ((INT8U *)sptr);
	INT8U verify = 0;
	
	for(i = 0; i < len; i++) 
	{
		verify = *ptr;

//		pUSART3.printf("1: TableIndexBackup = [%d][%x] \n", i,*ptr);

		if(verify != (INT8U)WriteEEprom(At24cDevID, EEADDR++, *ptr++, 0))
		{
			#ifdef Debug_Mode
				Ser1Printf("error\n");
			#endif
			return;
		}
	}
}




////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////


void LoadTable(void)
{
	INT32U i = 0;

	OSTimeDly(10);
	{
		INT8U *dptr = (INT8U *)OutputTable;
		for(i = 0; i < sizeof(__OutputTable); i++)
		{
			*dptr++ = ReadEEprom(At24cDevID, TableBp + i, 0);
		}
	}

	{
		INT8U *dptr = (INT8U *)AttnOffsetTable;
		for(i = 0; i < sizeof(__AttnOffsetTable); i++)
		{
			*dptr++ = ReadEEprom(At24cDevID, AttnTableBp + i, 0);
		}
	}

	{
		INT8U *dptr = (INT8U *)AttnTempTable;
		for(i = 0; i < sizeof(__AttnTempTable); i++)
		{
			*dptr++ = ReadEEprom(At24cDevID, AttnTptlTableBp + i, 0);
		}
	}


	{
		INT8U *dptr = (INT8U *)FilterTable;
		for(i = 0; i < sizeof(__FilterTable); i++)
		{
			*dptr++ = ReadEEprom(At24cDevID, FilterBp + i, 0);
		}
	}
}


INT8S TableIndex(INT8U TblID)
{
    INT8S tIndex = -1;	

	switch(TblID)
	{
		case Index_FwdOutAvgPwr_CDMALTE	: 	return Local_FwdOutAvgPwr_CDMALTE; 
		case Index_RvsOutPwr_CDMALTE	: 	return Local_RvsOutPwr_CDMALTE; 
		case Index_FwdOutAvgPwr_LTE_A	: 	return Local_FwdOutAvgPwr_LTE_A; 
		case Index_RvsOutPwr_LTE_A		: 	return Local_RvsOutPwr_LTE_A; 
		case Index_FwdOutAvgPwr_3G		: 	return Local_FwdOutAvgPwr_3G; 
		case Index_RvsOutPwr_3G			:	return Local_RvsOutPwr_3G; 


		case Index_FwdAttn1_CDMALTE		: 	return Local_FwdAttn1_CDMALTE;	
		case Index_RvsAttn1_CDMALTE		: 	return Local_RvsAttn1_CDMALTE;	
		case Index_RvsAttn2_CDMALTE		: 	return Local_RvsAttn2_CDMALTE;	
		case Index_RvsAttn3_CDMALTE		: 	return Local_RvsAttn3_CDMALTE;	


		case Index_FwdAttn1_LTE_A		: 	return Local_FwdAttn1_LTE_A; 
		case Index_RvsAttn1_LTE_A		: 	return Local_RvsAttn1_LTE_A; 
		case Index_RvsAttn2_LTE_A		: 	return Local_RvsAttn2_LTE_A; 
		case Index_RvsAttn3_LTE_A		: 	return Local_RvsAttn3_LTE_A; 

		case Index_FwdAttn1_3G			:	return Local_FwdAttn1_WCDMALTE_21; 
		case Index_RvsAttn1_3G			:	return Local_RvsAttn1_WCDMALTE_21; 
		case Index_RvsAttn2_3G			:	return Local_RvsAttn2_WCDMALTE_21; 
		case Index_RvsAttn3_3G			:	return Local_RvsAttn3_WCDMALTE_21; 

		case Index_FwdTempAttn_2G  		:	return Local_FwdTempAttn_2G; 
		case Index_RvsTempAttn_2G  		:	return Local_RvsTempAttn_2G; 
		case Index_FwdTempAttn_LTE_A	:	return Local_FwdTempAttn_LTE_A;
		case Index_RvsTempAttn_LTE_A	:	return Local_RvsTempAttn_LTE_A;
		case Index_FwdTempAttn_3G  		:	return Local_FwdTempAttn_WCDMALTE_21;
		case Index_RvsTempAttn_3G		:	return Local_RvsTempAttn_WCDMALTE_21;
	}
	return tIndex;
}


INT8S PwrTableLocation(INT8U TblID)
{
    INT8S tIndex = -1;

	switch(TblID)
	{
		case Index_FwdOutAvgPwr_3G		:
		case Index_FwdOutAvgPwr_CDMALTE :
		case Index_FwdOutAvgPwr_LTE_A	:
			tIndex = _FwdOutPwr_Location;
		break;

		case Index_RvsOutPwr_3G 		:
		case Index_RvsOutPwr_CDMALTE 	:
		case Index_RvsOutPwr_LTE_A 		:
          tIndex = _RvsOutPwr_Location;
		break;

		default:
		break;
	}

	return tIndex;
}

void DefaultValueSet_Test(INT8U Value)
{
	switch(Value) //command u?
	{
		case TRIO_M_TBL :
			DefaultTableSet();
		break;

		case Default_TBL:
			DefaultTableInit();
			DefaultTableSet();
		break;

		default:
		break;
	}
}


INT8S PwrTablelimitLocation(INT8U tIndex,INT8U Mode)
{
	INT8U rval = Normal;

	INT8S TblLmt;
	INT8S TblSize;


	if(tIndex == Local_FwdOutAvgPwr_CDMALTE)
	{
		TblLmt	= FwdOutAvgPwr_CDMALTE_TblLmt;
		TblSize = FwdOutAvgPwr_CDMALTE_TblSize;
	}
	else if(tIndex == Local_RvsOutPwr_CDMALTE)
	{
		TblLmt	= RvsOutPwr_CDMALTE_TblLmt;
		TblSize = RvsOutPwr_CDMALTE_TblSize;
	}	
	else if(tIndex == Local_FwdOutAvgPwr_LTE_A)
	{
		TblLmt	= FwdOutAvgPwr_LTE_A2_TblLmt;
		TblSize = FwdOutAvgPwr_LTE_A2_TblSize;
	}	
	else if(tIndex == Local_RvsOutPwr_LTE_A)
	{
		TblLmt	= RvsOutPwr_LTE_A_TblLmt;
		TblSize = RvsOutPwr_LTE_A_TblSize;
	}	
	else if(tIndex == Local_FwdOutAvgPwr_3G)
	{
		TblLmt	= FwdOutAvgPwr_3G_TblLmt;
		TblSize = FwdOutAvgPwr_3G_TblSize;
	}	
	else if(tIndex == Local_RvsOutPwr_3G)
	{
		TblLmt	= RvsOutPwr_3G_TblLmt;
		TblSize = RvsOutPwr_3G_TblSize;
	}
	if( Mode == 0) 	rval = TblLmt;
	else 			rval = TblSize;

	return rval;
}


void DefaultValueSet(void)
{
//	__Dnr_Sts *Sts = tDnrSts;
	
	INT8U err = 0;
	INT32U i = 0;

	OSSemPend(pBackupSem, 0, &err);
	{
		EE_BACK1 *tptr = (EE_BACK1 *)&gEE_BACK1; // Load 1st Area

		tptr->BackUp.FwdOutUpperLmt_3G[0]		= FwdHighLmt_3G; 
		tptr->BackUp.FwdOutUpperLmt_3G[1]		= 0; 
		tptr->BackUp.FwdOutLowerLmt_3G[0]		= FwdHighLmt_3G - 10; 
		tptr->BackUp.FwdOutLowerLmt_3G[1]		= 0; 
		tptr->BackUp.FwdGainSet_3G				= MAXGain_2100M; 
		tptr->BackUp.Rvs0GainSet_3G 			= MAXGain_2100M;


		tptr->BackUp.FwdOutUpperLmt_2G[0]		= FwdHighLmt_2G; 
		tptr->BackUp.FwdOutUpperLmt_2G[1]		= 0; 
		tptr->BackUp.FwdOutLowerLmt_2G[0]		= FwdHighLmt_2G - 10; 
		tptr->BackUp.FwdOutLowerLmt_2G[1]		= 0; 
		tptr->BackUp.FwdGainSet_2G				= MAXGain_800M;
		tptr->BackUp.Rvs0GainSet_2G 			= MAXGain_800M;

		tptr->BackUp.FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
		tptr->BackUp.FwdOutUpperLmt_LTE[1]		= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
		tptr->BackUp.FwdOutLowerLmt_LTE[1]		= 0;
		tptr->BackUp.FwdGainSet_LTE 			= MAXGain_800M;
		tptr->BackUp.Rvs0GainSet_LTE			= MAXGain_800M; 

		tptr->BackUp.RvsGainBalance_CDMALTE 	= 0;
		tptr->BackUp.RvsGainBalance_LTE_A		= 0;
		tptr->BackUp.RvsGainBalance_WCDMALTE_21 = 0;

		tptr->BackUp.FwdOutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2;
		tptr->BackUp.FwdOutUpperLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2 - 10;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdGainSet_LTE_A2			= MAXGain_1800M;
		tptr->BackUp.Rvs0GainSet_LTE_A2			= MAXGain_1800M;

		tptr->BackUp.FwdAmpOnOff_2G				= Disable; 
		tptr->BackUp.FwdAmpOnOff_LTE			= Disable; 
		tptr->BackUp.FwdAmpOnOff_LTE_A2			= Disable; 
		tptr->BackUp.FwdAmpOnOff_3G				= Disable; 


		tptr->BackUp.AGCOnOff_3G				= Disable; 
		tptr->BackUp.AGCOnOff_CDMALTE			= Disable; 
		tptr->BackUp.AGCOnOff_LTE_A_0 			= Disable;
		
		tptr->BackUp.AGCMode_3G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_2G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_LTE				= _AGCPeakMode;
		tptr->BackUp.AGCMode_LTE_A2				= _AGCPeakMode;
		tptr->BackUp.AGCMode_LTE_21				= _AGCPeakMode;
		
		tptr->BackUp.AutoReportPriod			= 0;
		tptr->BackUp.AutoReportBasePer[0]		= 0;
		tptr->BackUp.AutoReportBasePer[1]		= 0;
		tptr->BackUp.TPTL_OnOff 				= Disable;
		tptr->BackUp.TempOffset 				= 0;
		tptr->BackUp.AlarmMask					= Enable;
		tptr->BackUp.FwdInPwrOffset_2G			= 0; 
		tptr->BackUp.FwdInPwrOffset_3G			= 0; 
		tptr->BackUp.Rvs0OutPwrOffset_2G		= 0; 
		tptr->BackUp.Rvs0OutPwrOffset_3G		= 0; 
		tptr->BackUp.FwdOutPwrOffset_2G 		= 0; 
		tptr->BackUp.FwdOutPwrOffset_3G 		= 0; 

		tptr->BackUp.FwdInPwrOffset_LTE 		= 0;
		tptr->BackUp.FwdOutPwrOffset_LTE		= 0;
		tptr->BackUp.RvsOutPwrOffset_LTE		= 0;
		{
			INT8U i;

			for(i = 0; i < (sizeof(__DET)); i++)	 *((INT8U *)&(tptr->BackUp.DetOffset.FwdOutPwr_CDMALTE) + i) = 0;
		}

		{
			INT8U i;

			for(i = 0; i < PATH_MAX; i++)	 *((INT8U *)&(tptr->BackUp.RvsInPwrOffset) + i) = 0;
		}


		for(i = 0; i < DTU_Power_MAX; i++)
		{
			tptr->BackUp.DTUPeakOffset[i].sD8[0] = 0;
			tptr->BackUp.DTUPeakOffset[i].sD8[1] = 0;

			tptr->BackUp.DTUAverOffset[i].sD8[0] = 0;
			tptr->BackUp.DTUAverOffset[i].sD8[1] = 0;
		}


		tptr->BackUp.FwdInPwrOffset_LTE_A2		= 0; 
		tptr->BackUp.FwdOutPwrOffset_LTE_A2		= 0; 
		tptr->BackUp.RvsOutPwrOffset_LTE_A2		= 0; 

		tptr->BackUp.FwdInPwrOffset_LTE_21		= 0; 
		tptr->BackUp.FwdOutPwrOffset_LTE_21		= 0; 
		tptr->BackUp.RvsOutPwrOffset_LTE_21		= 0; 


		tptr->BackUp.RxMaxVal[0]				= 0x30;
		tptr->BackUp.RxMaxVal[1]				= 0x61;
		tptr->BackUp.RxMinVal[0]				= 0x39;
		tptr->BackUp.RxMinVal[1]				= 0x63;
		tptr->BackUp.TxMaxVal[0]				= 0x33;
		tptr->BackUp.TxMaxVal[1]				= 0x63;
		tptr->BackUp.TxMinVal[0]				= 0x62;
		tptr->BackUp.TxMinVal[1]				= 0x30;
		tptr->BackUp.EcIo						= 0x10;	//-10
		tptr->BackUp.Radio_ReportTime[0]		= 0;
		tptr->BackUp.Radio_ReportTime[1]		= 0;

		tptr->BackUp.DCOffSet[0] = 0x07;
		tptr->BackUp.DCOffSet[1] = 0x8A;

		tptr->BackUp.VccDet_Lmt[0] = 0x10;
		tptr->BackUp.VccDet_Lmt[1] = 0x68;


		tptr->BackUp.FwdGainOffset_2G 	= 0; 
		tptr->BackUp.RvsGainOffset_2G 	= 0; 

		tptr->BackUp.FwdGainOffset_LTE 	= 0; 
		tptr->BackUp.RvsGainOffset_LTE 	= 0; 

		tptr->BackUp.FwdGainOffset_3G 	= 0; 
		tptr->BackUp.RvsGainOffset_3G 	= 0; 

		tptr->BackUp.FwdGainOffset_LTE_21 = 0; 
		tptr->BackUp.RvsGainOffset_LTE_21 = 0; 

		tptr->BackUp.FwdGainOffset_LTE_A2 	= 0; 
		tptr->BackUp.RvsGainOffset_LTE_A2 	= 0; 

		tptr->BackUp.FemtocellUseOnOff	= 0x00;

		tptr->BackUp.AutoReportPriod = 0x05;

		tptr->BackUp.Radio_ReportPeriod[0] = 0x09;
		tptr->BackUp.Radio_ReportPeriod[1] = 0x10;

		tptr->BackUp.AR_Mode[0] = 0x03;
		tptr->BackUp.AR_Mode[1] = 0x03;


		for(i = 0; i < sizeof(EE_BACK1); i++)
		{
			WriteEEprom(At24cDevID, vEE_BACK1Addr + i, *((INT8U *)tptr + i), 0);
		}
	}
	OSSemPost(pBackupSem);
}

void DefaultTableSet(void)
{
	INT8U err = 0;
	INT32U i = 0;

	OSSemPend(pBackupSem, 0, &err);
	
	{
		EE_BACK1 *tptr = (EE_BACK1 *)&gEE_BACK1; // Load 1st Area

		// default set!!
		tptr->BackUp.FwdOutUpperLmt_3G[0]		= FwdHighLmt_3G; 
		tptr->BackUp.FwdOutUpperLmt_3G[1]		= 0; 
		tptr->BackUp.FwdOutLowerLmt_3G[0]		= FwdHighLmt_3G - 10; 
		tptr->BackUp.FwdOutLowerLmt_3G[1]		= 0; 
		tptr->BackUp.FwdGainSet_3G				= MINGain_2100M; 
		tptr->BackUp.Rvs0GainSet_3G 			= MINGain_2100M;
		tptr->BackUp.RvsGainBalance_CDMALTE		= DefaultGainBalance;
		tptr->BackUp.RvsGainBalance_LTE_A		= DefaultGainBalance;
		tptr->BackUp.RvsGainBalance_WCDMALTE_21	= DefaultGainBalance;
		
//		tptr->BackUp.OverInAlarmLmt_3G			= FwdOverInSDAlmLmt_3G; 
		
		tptr->BackUp.FwdOutUpperLmt_2G[0]		= FwdHighLmt_2G; 
		tptr->BackUp.FwdOutUpperLmt_2G[1]		= 0; 
		tptr->BackUp.FwdOutLowerLmt_2G[0]		= FwdHighLmt_2G - 10; 
		tptr->BackUp.FwdOutLowerLmt_2G[1]		= 0; 
		tptr->BackUp.FwdGainSet_2G				= MINGain_800M;
		tptr->BackUp.Rvs0GainSet_2G 			= MINGain_800M;
		
//		tptr->BackUp.OverInAlarmLmt_2G			= FwdOverInSDAlmLmt_2G; 
		
		tptr->BackUp.FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
		tptr->BackUp.FwdOutUpperLmt_LTE[1]		= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
		tptr->BackUp.FwdOutLowerLmt_LTE[1]		= 0;
		tptr->BackUp.FwdGainSet_LTE 			= MINGain_800M;
		tptr->BackUp.Rvs0GainSet_LTE			= MINGain_800M; 
		
//		tptr->BackUp.OverInAlarmLmt_LTE 		= FwdOverInSDAlmLmt_LTE; 
		
	
//		tptr->BackUp.OverInAlarmLmt_LTE_A1		= FwdOverInSDAlmLmt_LTE_A1; 
		
		tptr->BackUp.FwdOutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2;
		tptr->BackUp.FwdOutUpperLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2 - 10;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdGainSet_LTE_A2			= MINGain_1800M;
		tptr->BackUp.Rvs0GainSet_LTE_A2 		= MINGain_1800M;
		

		tptr->BackUp.AGCOnOff_3G				= Enable; 
		tptr->BackUp.AGCOnOff_CDMALTE			= Enable; 
		tptr->BackUp.AGCOnOff_LTE_A_0			= Enable;
		
		tptr->BackUp.AGCMode_3G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_2G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_LTE				= _AGCPeakMode;
		tptr->BackUp.AGCMode_LTE_A2 			= _AGCPeakMode;
		tptr->BackUp.AGCMode_LTE_21 			= _AGCPeakMode;
		
		tptr->BackUp.AutoReportPriod			= 0;
		tptr->BackUp.AutoReportBasePer[0]		= 0;
		tptr->BackUp.AutoReportBasePer[1]		= 0;
		tptr->BackUp.TPTL_OnOff 				= Disable;
		tptr->BackUp.AlarmMask					= Enable;
//		tptr->BackUp.VccDet_Lmt.Data			= 4200; 

		tptr->BackUp.RxMaxVal[0]				= 0x30;
		tptr->BackUp.RxMaxVal[1]				= 0x61;
		tptr->BackUp.RxMinVal[0]				= 0x39;
		tptr->BackUp.RxMinVal[1]				= 0x63;
		tptr->BackUp.TxMaxVal[0]				= 0x33;
		tptr->BackUp.TxMaxVal[1]				= 0x63;
		tptr->BackUp.TxMinVal[0]				= 0x62;
		tptr->BackUp.TxMinVal[1]				= 0x30;
		tptr->BackUp.EcIo						= 0x10; //-10
		tptr->BackUp.Radio_ReportTime[0]		= 0;
		tptr->BackUp.Radio_ReportTime[1]		= 0;

		tptr->BackUp.FemtocellUseOnOff		= 0x00;
		tptr->BackUp.AutoReportPriod 		= 0x05;

		tptr->BackUp.Radio_ReportPeriod[0] 	= 0x09;
		tptr->BackUp.Radio_ReportPeriod[1] 	= 0x10;
		
		tptr->BackUp.AR_Mode[0] = 0x03;
		tptr->BackUp.AR_Mode[1] = 0x03;


        ////////////////////////////////////////////////////////////////////////
		tptr->BackUp.IsDataFlag = ISDATA;


		for(i = 0; i < sizeof(EE_BACK1); i++)
		{
			WriteEEprom(At24cDevID, vEE_BACK1Addr + i, *((INT8U *)tptr + i), 0);
		}
	}
	OSSemPost(pBackupSem);
	////////////////////////////////////////////////////////////////////////////////
}

void DefaultTable(void)
{
	INT8S tIndex = 0;
	INT32U i = 0;
	INT8U err = 0;

	INT16U ntableBp = 0;
	INT8U tsize;

	OSSemPend(pBackupSem, 0, &err);
#if 1

	{
		tIndex = Local_FwdOutAvgPwr_CDMALTE;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= FwdOutAvgPwr_CDMALTE_TblLmt;//27*2;
		tsize = table[tIndex].nsize = FwdOutAvgPwr_CDMALTE_TblSize;//21;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdOutPwr_CDMALTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	

	{
		tIndex = Local_RvsOutPwr_3G;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= RvsOutPwr_3G_TblLmt;//26*2;
		tsize = table[tIndex].nsize = RvsOutPwr_3G_TblSize;//40;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsOutPwr_WCDMA_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	

	{
		tIndex = Local_RvsOutPwr_LTE_A;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= RvsOutPwr_LTE_A_TblLmt;//26*2;
		tsize = table[tIndex].nsize = RvsOutPwr_LTE_A_TblSize;//21;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)TRIO_M_RvsOutPwr_LTE_A;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	

	{
		tIndex = Local_RvsOutPwr_CDMALTE;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit = RvsOutPwr_CDMALTE_TblLmt;//26*2;
		tsize = table[tIndex].nsize = RvsOutPwr_CDMALTE_TblSize;//21;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsOutPwr_CDMALTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	
		

	{
		tIndex = Local_FwdOutAvgPwr_3G;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= FwdOutAvgPwr_3G_TblLmt;//26*2;
		tsize = table[tIndex].nsize = FwdOutAvgPwr_3G_TblSize;//21;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdOutPwr_WCDMA_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}
#endif
////////////////ATT Default Table
#if 1

	{
		tIndex = Local_FwdAttn1_CDMALTE;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdAttn1_CDMALTE_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn1_CDMALTE;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn1_CDMALTE_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}	
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_FwdAttn1_LTE_A;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdAttn1_LTE_A2_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}


	{
		tIndex = Local_RvsAttn1_LTE_A;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn1_LTE_A2_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);
	}


	{
		tIndex = Local_RvsAttn2_LTE_A;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn2_LTE_A2_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn3_LTE_A;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn3_LTE_A2_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}
	{
		tIndex = Local_FwdAttn1_WCDMALTE_21;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdAttn1_WCDMA_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	

	{
		tIndex = Local_RvsAttn1_WCDMALTE_21;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));


		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn1_WCDMA_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn2_WCDMALTE_21;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));


		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn2_WCDMA_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn3_WCDMALTE_21;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn3_WCDMA_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	
#endif	
#if 1
	///// 온도 보상 
	{
		tIndex = Local_FwdTempAttn_2G;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdTempAtt_CDMA_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}


	{
		tIndex = Local_RvsTempAttn_2G;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsTempAtt_CDMA_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}



	{
		tIndex = Local_FwdTempAttn_LTE_A;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdTempAtt_LTE_A2_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}

	{
		tIndex = Local_RvsTempAttn_LTE_A;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));


		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsTempAtt_LTE_A2_TBL;
				
				for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}

	{
		tIndex = Local_FwdTempAttn_WCDMALTE_21;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdTempAtt_WCDMA_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}

	{
		tIndex = Local_RvsTempAttn_WCDMALTE_21;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsTempAtt_WCDMA_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}		
#endif
	OSSemPost(pBackupSem);

	DefaultValueSet();


}


void DefaultTableInit(void)
{
}


////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

