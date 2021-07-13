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

void Response_Table(__ProtocolPtr *nPtr)
{
	INT8U TblID = 0;
	INT8S tIndex = 0;

	INT8S tlimit;
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
		case Index_FwdOutAvgPwr_2G			:
		case Index_RvsOutPwr_2G 			: 
		case Index_FwdOutAvgPwr_LTE 		: 
		case Index_RvsInPwr_LTE 			: 
		case Index_RvsOutPwr_LTE			: 
		case Index_FwdInPwr_CDMALTE 		:
		case Index_FwdOutAvgPwr_CDMALTE 	: 
		case Index_RvsInPwr_CDMALTE 		:
		case Index_RvsOutPwr_CDMALTE		: 
		case Index_FwdOutAvgPwr_LTE_A2		: 
		case Index_RvsOutPwr_LTE_A2 		: 
		case Index_FwdInPwr_LTE_A			:
		case Index_FwdOutAvgPwr_LTE_A		: 
		case Index_RvsInPwr_LTE_A			:
		case Index_RvsOutPwr_LTE_A			: 
		case Index_Rvs1InPwr_LTE_A			:
		case Index_FwdInPwr_3G				: 
		case Index_FwdOutAvgPwr_3G			: 
		case Index_RvsInPwr_3G				: 
		case Index_RvsOutPwr_3G 			:
		{
			__OutputTblStr *table = (__OutputTblStr *)OutputTable;
			

			if((Comm == DDRTableSetQue))
			{
				ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));
				table[tIndex].limit = rBody->SubData[1];
				tsize = table[tIndex].nsize = rBody->SubData[2];
				if( tsize > OutputTBL_Size)  tsize = table[tIndex].nsize =  OutputTBL_Size; 

				//////20140424 추가 

				tlimit = PwrTablelimitLocation(tIndex,0);
				if( TblLmtCheck(table[tIndex].limit,tlimit) == Alarm)table[tIndex].limit = tlimit;



				//

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

		case Index_FwdAttn1_2G			:	
		case Index_RvsAttn1_2G			:	
		case Index_RvsAttn2_2G			:	
		case Index_RvsAttn3_2G			:	
		case Index_FwdAttn1_LTE 		: 
		case Index_RvsAttn1_LTE 		: 
		case Index_RvsAttn2_LTE 		: 
		case Index_RvsAttn3_LTE 		: 
		case Index_FwdAttn1_CDMALTE 	: 
		case Index_RvsAttn1_CDMALTE 	: 
		case Index_FwdAttn1_LTE_A2		: 
		case Index_FwdAttn2_LTE_A2		: 
		case Index_RvsAttn1_LTE_A2		: 
		case Index_RvsAttn2_LTE_A2		: 
		case Index_RvsAttn3_LTE_A2		: 
		case Index_RvsAttn4_LTE_A2		: 
		case Index_FwdAttn1_3G			:	
		case Index_FwdAttn2_3G			:	
		case Index_RvsAttn1_3G			:	
		case Index_RvsAttn2_3G			:	
		case Index_RvsAttn3_3G			:	
		case Index_RvsAttn4_3G			:	
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
		case Index_FwdTempAttn_LTE 		:
		case Index_RvsTempAttn_LTE 		:
		case Index_FwdTempAttn_LTE_A2	:
		case Index_RvsTempAttn_LTE_A2	:
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

		if(verify != (INT8U)WriteEEprom(At24cDevID, EEADDR++, *ptr++, 0))
		{
			#ifdef Debug_Mode
				Ser1Printf("error\n");
			#endif
			return;
		}
	}
}


// KT CASE !!
INT32S ReadPwrTableAscending(INT32U AdcValue, INT8S tIndex, INT8U roundingoff, INT8U *isminval)//, INT16S limit, INT16U nsize)
{
  return 1;
#if 0
    INT16U *dptr =((INT16U *)&gEE_TABLE + tIndex*(TableMAX62+2));
	INT32S i = 0, j = 0;
	INT32S rvalx10 = 0;
	INT32S tmpRef = 0;
	INT32S slopex10 = 0;
	INT16S limit = 0;
	INT16U nsize = 0;

	*isminval = FALSE;

	limit = (INT16S)dptr[0];
	nsize = dptr[1];
	
	rvalx10 = limit*10L;

	if(nsize > TableMAX62) nsize = TableMAX62;

	if(AdcValue < dptr[0 + (2)]){
		*isminval = TRUE;
	}
	
	else if(AdcValue > dptr[(nsize - 1)+2])
	{
		tmpRef = dptr[(nsize - 1) + 2]*10L;
		slopex10 = abs(dptr[(nsize - 1) + 2] - dptr[(nsize - 2) + 2]);
		rvalx10 += (((nsize - 1) + 2)*10);
		if(slopex10 != 0)
		{
			do{
				tmpRef += slopex10;
				rvalx10++;
			}
			while(tmpRef <= 10230 && (AdcValue*10) > tmpRef);
		}
	}
	else{
		for(i = 0; i < nsize; i++)
		{
			if(AdcValue < dptr[i + (2)]) break;
		}
	
		if(i == nsize) i--;
	
		rvalx10 = rvalx10 + (i*10L);
	
		if( (i != nsize) && i != 0)
		{
			INT32U stepx10 = ((dptr[i + (2)] - dptr[i-1 + (2)])*10L)/10L;
			INT32U tmp;
	
			for(j = 0; j < 10; j++)
			{
				tmp = (dptr[i + (2)]*10 - j*stepx10);
				if((AdcValue*10L) > tmp ) break;			
			}
				
			if(roundingoff == TRUE)// 반올림..
			{
					 if(j >= 8)  j = 10;
				else if(j >= 3)  j = 5;
				else			 j = 0;
			}		
		}
	
		if(i == 0 && j == 0) *isminval = TRUE;
	}
	return (rvalx10 - j);
#endif  
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
}


INT8S TableIndex(INT8U TblID)
{
    INT8S tIndex = -1;	

	switch(TblID)
	{

		case Index_FwdOutAvgPwr_2G		: 	return Local_FwdOutAvgPwr_2G;
		case Index_RvsOutPwr_2G			: 	return Local_RvsOutPwr_2G; 
		case Index_FwdOutAvgPwr_LTE		: 	return Local_FwdOutAvgPwr_LTE; 
		case Index_RvsInPwr_LTE			: 	return Local_RvsInPwr_LTE; 
		case Index_RvsOutPwr_LTE		: 	return Local_RvsOutPwr_LTE; 
		case Index_FwdInPwr_CDMALTE		:	return Local_FwdInPwr_CDMALTE;
		case Index_FwdOutAvgPwr_CDMALTE	: 	return Local_FwdOutAvgPwr_CDMALTE; 
		case Index_RvsInPwr_CDMALTE		:	return Local_RvsInPwr_CDMALTE;
		case Index_RvsOutPwr_CDMALTE	: 	return Local_RvsOutPwr_CDMALTE; 
		case Index_FwdOutAvgPwr_LTE_A2	: 	return Local_FwdOutAvgPwr_LTE_A2; 
		case Index_RvsOutPwr_LTE_A2		: 	return Local_RvsOutPwr_LTE_A2; 
		case Index_FwdInPwr_LTE_A		:	return Local_FwdInPwr_LTE_A;
		case Index_FwdOutAvgPwr_LTE_A	: 	return Local_FwdOutAvgPwr_LTE_A; 
		case Index_RvsInPwr_LTE_A		:	return Local_RvsInPwr_LTE_A;
		case Index_RvsOutPwr_LTE_A		: 	return Local_RvsOutPwr_LTE_A; 
		case Index_Rvs1InPwr_LTE_A		:	return Local_Rvs1InPwr_LTE_A;
		case Index_FwdInPwr_3G			: 	return Local_FwdInPwr_3G; 
		case Index_FwdOutAvgPwr_3G		: 	return Local_FwdOutAvgPwr_3G; 
		case Index_RvsInPwr_3G			: 	return Local_RvsInPwr_3G; 
		case Index_RvsOutPwr_3G			:	return Local_RvsOutPwr_3G; 
#if 0
		case Index_BalancePwr_CDMA 		: 	return Local_BalancePwr_CDMA;
		case Index_BalancePwr_LTE		: 	return Local_BalancePwr_LTE;
		case Index_BalancePwr_LTE_A		: 	return Local_BalancePwr_LTE_A;
		case Index_BalancePwr_WCDMA		:	return Local_BalancePwr_WCDMA;
#endif

		case Index_FwdAttn1_2G			:	return Local_FwdAttn1_2G;	
		case Index_RvsAttn1_2G			:	return Local_RvsAttn1_2G; 
		case Index_RvsAttn2_2G			:	return Local_RvsAttn2_2G; 
		case Index_RvsAttn3_2G			:	return Local_RvsAttn3_2G; 

        case Index_FwdAttn1_LTE			: 	return Local_FwdAttn1_LTE;	
		case Index_RvsAttn1_LTE			: 	return Local_RvsAttn1_LTE;	
		case Index_RvsAttn2_LTE			: 	return Local_RvsAttn2_LTE;	
		case Index_RvsAttn3_LTE			: 	return Local_RvsAttn3_LTE;	

		case Index_FwdAttn1_CDMALTE		: 	return Local_FwdAttn1_CDMALTE;	
		case Index_RvsAttn1_CDMALTE		: 	return Local_RvsAttn1_CDMALTE;	
		case Index_FwdAttn1_LTE_A2		: 	return Local_FwdAttn1_LTE_A2; 
		case Index_FwdAttn2_LTE_A2		: 	return Local_FwdAttn2_LTE_A2; 
		case Index_RvsAttn1_LTE_A2		: 	return Local_RvsAttn1_LTE_A2; 
		case Index_RvsAttn2_LTE_A2		: 	return Local_RvsAttn2_LTE_A2; 
		case Index_RvsAttn3_LTE_A2		: 	return Local_RvsAttn3_LTE_A2; 
		case Index_RvsAttn4_LTE_A2		: 	return Local_RvsAttn4_LTE_A2; 
		case Index_FwdAttn1_3G			:	return Local_FwdAttn1_3G; 
		case Index_FwdAttn2_3G			:	return Local_FwdAttn2_3G; 
		case Index_RvsAttn1_3G			:	return Local_RvsAttn1_3G; 
		case Index_RvsAttn2_3G			:	return Local_RvsAttn2_3G; 
		case Index_RvsAttn3_3G			:	return Local_RvsAttn3_3G; 
		case Index_RvsAttn4_3G			:	return Local_RvsAttn4_3G; 


		case Index_FwdTempAttn_2G  		:	return Local_FwdTempAttn_2G; 
		case Index_RvsTempAttn_2G  		:	return Local_RvsTempAttn_2G; 
		case Index_FwdTempAttn_LTE 		:	return Local_FwdTempAttn_LTE; 
		case Index_RvsTempAttn_LTE 		:	return Local_RvsTempAttn_LTE;
		case Index_FwdTempAttn_LTE_A2	:	return Local_FwdTempAttn_LTE_A2;
		case Index_RvsTempAttn_LTE_A2	:	return Local_RvsTempAttn_LTE_A2;
		case Index_FwdTempAttn_3G  		:	return Local_FwdTempAttn_3G;
		case Index_RvsTempAttn_3G		:	return Local_RvsTempAttn_3G;
	}
	return tIndex;
}


INT8S PwrTableLocation(INT8U TblID)
{
    INT8S tIndex = -1;

	switch(TblID)
	{
		case Index_FwdOutAvgPwr_3G		:
		case Index_FwdOutAvgPwr_2G		:
		case Index_FwdOutAvgPwr_LTE 	:
		case Index_FwdOutAvgPwr_LTE_A1	:
		case Index_FwdOutAvgPwr_LTE_A2	:
		case Index_FwdOutAvgPwr_CDMALTE :
		case Index_FwdOutAvgPwr_LTE_A	:
			tIndex = _FwdOutPwr_Location;
		break;


		case Index_FwdInPwr_3G 			:
		case Index_FwdInPwr_CDMALTE 	:
		case Index_FwdInPwr_LTE_A		:
			tIndex = _FwdInPwr_Location;
		break;

		case Index_RvsInPwr_CDMALTE 	:
		case Index_RvsInPwr_3G			:
		case Index_RvsInPwr_LTE_A		:
			tIndex = _RvsInPwr_Location;
		break;


		case Index_RvsOutPwr_3G 		:
		case Index_RvsOutPwr_2G 		:
		case Index_RvsOutPwr_LTE		:
		case Index_RvsOutPwr_LTE_A1 	:
		case Index_RvsOutPwr_LTE_A2 	:
		case Index_RvsOutPwr_CDMALTE 	:
		case Index_RvsOutPwr_LTE_A 		:
#if 0
    	case Index_BalancePwr_CDMA 		: 
		case Index_BalancePwr_LTE		: 
		case Index_BalancePwr_LTE_A		: 
		case Index_BalancePwr_WCDMA		:		
#endif
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

	if(tIndex == Local_FwdOutAvgPwr_2G)
	{
		TblLmt	= FwdOutAvgPwr_2G_TblLmt;
		TblSize = FwdOutAvgPwr_2G_TblSize;
	}
	else if(tIndex == Local_RvsOutPwr_2G)
	{
		TblLmt	= RvsOutPwr_2G_TblLmt;
		TblSize = RvsOutPwr_2G_TblSize;
	}
	else if(tIndex == Local_FwdOutAvgPwr_LTE)
	{
		TblLmt	= FwdOutAvgPwr_LTE_TblLmt;
		TblSize = FwdOutAvgPwr_LTE_TblSize;
	}	
	else if(tIndex == Local_RvsOutPwr_LTE)
	{
		TblLmt	= RvsOutPwr_LTE_TblLmt;
		TblSize = RvsOutPwr_LTE_TblSize;
	}	
	else if(tIndex == Local_FwdInPwr_CDMALTE)
	{
		TblLmt	= FwdInPwr_CDMALTE_TblLmt;
		TblSize = FwdInPwr_CDMALTE_TblSize;
	}	
	else if(tIndex == Local_FwdOutAvgPwr_CDMALTE)
	{
		TblLmt	= FwdOutAvgPwr_CDMALTE_TblLmt;
		TblSize = FwdOutAvgPwr_CDMALTE_TblSize;

	}
	else if(tIndex == Local_RvsInPwr_CDMALTE)
	{
		TblLmt	= RvsInPwr_CDMALTE_TblLmt;
		TblSize = RvsInPwr_CDMALTE_TblSize;
	}	
	else if(tIndex == Local_RvsOutPwr_CDMALTE)
	{
		TblLmt	= RvsOutPwr_CDMALTE_TblLmt;
		TblSize = RvsOutPwr_CDMALTE_TblSize;
	}	
	else if(tIndex == Local_FwdOutAvgPwr_LTE_A2)
	{
		TblLmt	= FwdOutAvgPwr_LTE_A2_TblLmt;
		TblSize = FwdOutAvgPwr_LTE_A2_TblSize;
	}	
	else if(tIndex == Local_RvsOutPwr_LTE_A2)
	{
		TblLmt	= RvsOutPwr_LTE_A2_TblLmt;
		TblSize = RvsOutPwr_LTE_A2_TblSize;
	}
	else if(tIndex == Local_FwdInPwr_LTE_A)
	{
		TblLmt	= FwdInPwr_LTE_A_TblLmt;
		TblSize = FwdInPwr_LTE_A_TblSize;
	}
	else if(tIndex == Local_RvsInPwr_LTE_A)
	{
		TblLmt	= RvsInPwr_LTE_A_TblLmt;
		TblSize = RvsInPwr_LTE_A_TblSize;
	}
	else if(tIndex == Local_RvsOutPwr_LTE_A)
	{
		TblLmt	= RvsOutPwr_LTE_A_TblLmt;
		TblSize = RvsOutPwr_LTE_A_TblSize;
	}	
	else if(tIndex == Local_FwdInPwr_3G)
	{
		TblLmt	= FwdInPwr_3G_TblLmt;
		TblSize = FwdInPwr_3G_TblSize;
	}
	else if(tIndex == Local_FwdOutAvgPwr_3G)
	{
		TblLmt	= FwdOutAvgPwr_3G_TblLmt;
		TblSize = FwdOutAvgPwr_3G_TblSize;
	}	
	else if(tIndex == Local_RvsInPwr_3G)
	{
		TblLmt	= RvsInPwr_3G_TblLmt;
		TblSize = RvsInPwr_3G_TblSize;
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
		tptr->BackUp.FwdGainSet_3G				= Gain_3G; 
		tptr->BackUp.Rvs0GainSet_3G 			= Gain_3G;
		tptr->BackUp.RvsGainBalance_3G			= DefaultGainBalance;

//		tptr->BackUp.OverInAlarmLmt_3G			= FwdOverInSDAlmLmt_3G; 

		tptr->BackUp.FwdOutUpperLmt_2G[0]		= FwdHighLmt_2G; 
		tptr->BackUp.FwdOutUpperLmt_2G[1]		= 0; 
		tptr->BackUp.FwdOutLowerLmt_2G[0]		= FwdHighLmt_2G - 10; 
		tptr->BackUp.FwdOutLowerLmt_2G[1]		= 0; 
		tptr->BackUp.FwdGainSet_2G				= Gain_2G;
		tptr->BackUp.Rvs0GainSet_2G 			= Gain_2G;
		tptr->BackUp.RvsGainBalance_2G			= 0;

//		tptr->BackUp.OverInAlarmLmt_2G			= FwdOverInSDAlmLmt_2G; 

		tptr->BackUp.FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
		tptr->BackUp.FwdOutUpperLmt_LTE[1]		= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
		tptr->BackUp.FwdOutLowerLmt_LTE[1]		= 0;
		tptr->BackUp.FwdGainSet_LTE 			= Gain_LTE;
		tptr->BackUp.Rvs0GainSet_LTE			= Gain_LTE; 
		tptr->BackUp.RvsGainBalance_LTE 		= 0; 

//		tptr->BackUp.OverInAlarmLmt_LTE 		= FwdOverInSDAlmLmt_LTE; 

//		tptr->BackUp.OverInAlarmLmt_LTE_A1		= FwdOverInSDAlmLmt_LTE_A1; 

		tptr->BackUp.FwdOutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2;
		tptr->BackUp.FwdOutUpperLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2 -10;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdGainSet_LTE_A2			= Gain_LTE_A;
		tptr->BackUp.Rvs0GainSet_LTE_A2			= Gain_LTE_A;
		tptr->BackUp.RvsGainBalance_LTE_A2		= 0; 

//		tptr->BackUp.OverInAlarmLmt_LTE_A2		= FwdOverInSDAlmLmt_LTE_A2; 


		tptr->BackUp.FwdAmpOnOff_2G				= Disable; 
		tptr->BackUp.FwdAmpOnOff_LTE			= Disable; 
		tptr->BackUp.FwdAmpOnOff_LTE_A2			= Disable; 
		tptr->BackUp.FwdAmpOnOff_3G				= Disable; 

		tptr->BackUp.LTE15MUse 					= __NOTUSE; 

		tptr->BackUp.AGCOnOff_3G				= Disable; 
		tptr->BackUp.AGCOnOff_CDMALTE			= Disable; 
		tptr->BackUp.AGCOnOff_LTE_A_0 			= Disable;
		
		tptr->BackUp.AGCMode_3G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_2G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_LTE				= _AGCPeakMode;
		tptr->BackUp.AGCMode_LTE_A2				= _AGCPeakMode;
		
		tptr->BackUp.AutoReportPriod			= 0;
		tptr->BackUp.AutoReportBasePer[0]		= 0;
		tptr->BackUp.AutoReportBasePer[1]		= 0;
		tptr->BackUp.TPTL_OnOff 				= Disable;
		tptr->BackUp.TempOffset 				= 0;
		tptr->BackUp.AlarmMask					= Enable;
//		tptr->BackUp.VccDet_Lmt.Data			= 4200; 
		tptr->BackUp.FwdInPwrOffset_2G			= 0; 
		tptr->BackUp.FwdInPwrOffset_3G			= 0; 
		tptr->BackUp.Rvs0OutPwrOffset_2G		= 0; 
		tptr->BackUp.Rvs0OutPwrOffset_3G		= 0; 
		tptr->BackUp.FwdOutPwrOffset_2G 		= 0; 
		tptr->BackUp.FwdOutPwrOffset_3G 		= 0; 
#if 0
		tptr->BackUp.ResetPeriodCountSet[0] 	= 1; 
		tptr->BackUp.ResetPeriodCountSet[1] 	= 0; 
		tptr->BackUp.ResetPeriodCountSet[2] 	= 0; 
#endif
		tptr->BackUp.FwdInPwrOffset_LTE 		= 0;
		tptr->BackUp.FwdOutPwrOffset_LTE		= 0;
		tptr->BackUp.RvsOutPwrOffset_LTE		= 0;
		{
			INT8U i;

			for(i = 0; i < (sizeof(__DET)); i++)	 *((INT8U *)&(tptr->BackUp.DetOffset.FwdOutAvgPwr_2G) + i) = 0;
		}
		tptr->BackUp.FwdInPwrOffset_LTE_A2		= 0; 
		tptr->BackUp.FwdOutPwrOffset_LTE_A2		= 0; 
		tptr->BackUp.RvsOutPwrOffset_LTE_A2		= 0; 
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
		tptr->BackUp.Band_Select_LTE_A2[0]     = __USE;
		tptr->BackUp.Band_Select_LTE_A2[1]     = 1;
		tptr->BackUp.Band_Select_LTE_A2[2]     = 0x70;


		tptr->BackUp.RvsALCLvl_2G 		= RvsHighLmt_2G; 
		tptr->BackUp.RvsALCLvl_3G 		= RvsHighLmt_2G; 
		tptr->BackUp.RvsALCLvl_LTE 		= RvsHighLmt_2G; 
		tptr->BackUp.RvsALCLvl_LTE_A2 	= RvsHighLmt_2G; 
	
//		tptr->BackUp.DCOffSet = 1930;

		tptr->BackUp.DCOffSet[0] = 0x07;
		tptr->BackUp.DCOffSet[1] = 0x8A;

		tptr->BackUp.VccDet_Lmt[0] = 0x10;
		tptr->BackUp.VccDet_Lmt[1] = 0x68;

		//		tptr->BackUp.VccDet_Lmt.Data			= 4200; 



		tptr->BackUp.FwdGainOffset_2G 	= 0; 
		tptr->BackUp.RvsGainOffset_2G 	= 0; 

		tptr->BackUp.FwdGainOffset_LTE 	= 0; 
		tptr->BackUp.RvsGainOffset_LTE 	= 0; 

		tptr->BackUp.FwdGainOffset_3G 	= 0; 
		tptr->BackUp.RvsGainOffset_3G 	= 0; 

		tptr->BackUp.FwdGainOffset_LTE_A2 	= 0; 
		tptr->BackUp.RvsGainOffset_LTE_A2 	= 0; 

		tptr->BackUp.FemtocellUseOnOff	= 0x00;

		tptr->BackUp.AutoReportPriod = 0x05;

		tptr->BackUp.Radio_ReportPeriod[0] = 0x09;
		tptr->BackUp.Radio_ReportPeriod[1] = 0x10;

		tptr->BackUp.AR_Mode[0] = 0x03;
		tptr->BackUp.AR_Mode[1] = 0x03;

		tDnrSts->BalanceModeOnOff.OnOff = Enable;
		tDnrSts->BalanceModeOnOff.Time = 30;
		tptr->BackUp.BalanceModeOnOff = tDnrSts->BalanceModeOnOff.Data;

		{
			INT8U i;

			for(i = 0; i < (sizeof(__BalanceModeDET)); i++)	 *((INT8U *)&(tptr->BackUp.BalanceModeDetOffset[i])) = 0;
		}


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
		tptr->BackUp.FwdGainSet_3G				= DefaultGain_3G; 
		tptr->BackUp.Rvs0GainSet_3G 			= DefaultGain_3G;
		tptr->BackUp.RvsGainBalance_3G			= DefaultGainBalance;
		
//		tptr->BackUp.OverInAlarmLmt_3G			= FwdOverInSDAlmLmt_3G; 
		
		tptr->BackUp.FwdOutUpperLmt_2G[0]		= FwdHighLmt_2G; 
		tptr->BackUp.FwdOutUpperLmt_2G[1]		= 0; 
		tptr->BackUp.FwdOutLowerLmt_2G[0]		= FwdHighLmt_2G - 10; 
		tptr->BackUp.FwdOutLowerLmt_2G[1]		= 0; 
		tptr->BackUp.FwdGainSet_2G				= DefaultGain_2G;
		tptr->BackUp.Rvs0GainSet_2G 			= DefaultGain_2G;
		tptr->BackUp.RvsGainBalance_2G			= DefaultGainBalance;
		
//		tptr->BackUp.OverInAlarmLmt_2G			= FwdOverInSDAlmLmt_2G; 
		
		tptr->BackUp.FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
		tptr->BackUp.FwdOutUpperLmt_LTE[1]		= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
		tptr->BackUp.FwdOutLowerLmt_LTE[1]		= 0;
		tptr->BackUp.FwdGainSet_LTE 			= DefaultGain_LTE;
		tptr->BackUp.Rvs0GainSet_LTE			= DefaultGain_LTE; 
		tptr->BackUp.RvsGainBalance_LTE 		= DefaultGainBalance; 
		
//		tptr->BackUp.OverInAlarmLmt_LTE 		= FwdOverInSDAlmLmt_LTE; 
		
	
//		tptr->BackUp.OverInAlarmLmt_LTE_A1		= FwdOverInSDAlmLmt_LTE_A1; 
		
		tptr->BackUp.FwdOutUpperLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2;
		tptr->BackUp.FwdOutUpperLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[0]	= FwdHighLmt_LTE_A2 -10;
		tptr->BackUp.FwdOutLowerLmt_LTE_A2[1]	= 0;
		tptr->BackUp.FwdGainSet_LTE_A2			= DefaultGain_LTE_A;
		tptr->BackUp.Rvs0GainSet_LTE_A2 		= DefaultGain_LTE_A;
		tptr->BackUp.RvsGainBalance_LTE_A2		= DefaultGainBalance; 
		
//		tptr->BackUp.OverInAlarmLmt_LTE_A2		= FwdOverInSDAlmLmt_LTE_A2; 
		
	
#if 0		
		tptr->BackUp.AmpOffCase_2G				= Enable; 
		tptr->BackUp.AmpOffCase_LTE 			= Enable; 
		tptr->BackUp.AmpOffCase_3G				= Enable; 
		tptr->BackUp.AmpOffCase_LTE_A1			= Disable; 
		tptr->BackUp.AmpOffCase_LTE_A2			= Disable; 
#endif		
		tptr->BackUp.LTE15MUse					= __NOTUSE; 
		
		tptr->BackUp.AGCOnOff_3G				= Enable; 
		tptr->BackUp.AGCOnOff_CDMALTE			= Enable; 
		tptr->BackUp.AGCOnOff_LTE_A_0			= Enable;
		
		tptr->BackUp.AGCMode_3G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_2G 				= _AGCAvgMode;
		tptr->BackUp.AGCMode_LTE				= _AGCPeakMode;
		tptr->BackUp.AGCMode_LTE_A2 			= _AGCPeakMode;
		
		tptr->BackUp.AutoReportPriod			= 0;
		tptr->BackUp.AutoReportBasePer[0]		= 0;
		tptr->BackUp.AutoReportBasePer[1]		= 0;
		tptr->BackUp.TPTL_OnOff 				= Disable;
		tptr->BackUp.AlarmMask					= Enable;
//		tptr->BackUp.VccDet_Lmt.Data			= 4200; 
#if 0
		tptr->BackUp.ResetPeriodCountSet[0] 	= 1; 
		tptr->BackUp.ResetPeriodCountSet[1] 	= 0; 
		tptr->BackUp.ResetPeriodCountSet[2] 	= 0; 
#endif

#if 1
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
#endif

		tptr->BackUp.Band_Select_LTE_A2[0]	   = __NOTUSE;
		tptr->BackUp.Band_Select_LTE_A2[1]	   = 1;
		tptr->BackUp.Band_Select_LTE_A2[2]	   = 0x70;
		
		
		tptr->BackUp.RvsALCLvl_2G		= RvsHighLmt_2G; 
		tptr->BackUp.RvsALCLvl_3G		= RvsHighLmt_2G; 
		tptr->BackUp.RvsALCLvl_LTE		= RvsHighLmt_2G; 
		tptr->BackUp.RvsALCLvl_LTE_A2	= RvsHighLmt_2G; 
#if 0	
		tptr->BackUp.FemtocellUseOnOff.LTE = __NOTUSE;
		tptr->BackUp.FemtocellUseOnOff.LTE_A1 = __NOTUSE;
		tptr->BackUp.FemtocellUseOnOff.LTE_A2 = __NOTUSE;
		
		tptr->BackUp.FemtocellUseOnOff.LTE_1= __NOTUSE;
		tptr->BackUp.FemtocellUseOnOff.LTE_A1_1 = __NOTUSE;
		tptr->BackUp.FemtocellUseOnOff.LTE_A2_1 = __NOTUSE;
#endif

		tptr->BackUp.FemtocellUseOnOff	= 0x00;
		tptr->BackUp.AutoReportPriod = 0x05;

		tptr->BackUp.Radio_ReportPeriod[0] = 0x09;
		tptr->BackUp.Radio_ReportPeriod[1] = 0x10;
		
		tptr->BackUp.AR_Mode[0] = 0x03;
		tptr->BackUp.AR_Mode[1] = 0x03;


		tDnrSts->BalanceModeOnOff.OnOff = Enable;
		tDnrSts->BalanceModeOnOff.Time = 30;
		tptr->BackUp.BalanceModeOnOff = tDnrSts->BalanceModeOnOff.Data;

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

		tIndex = Local_FwdOutAvgPwr_2G;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));
		
		table[tIndex].limit 		= FwdOutAvgPwr_2G_TblLmt;  /// 22*2;
		tsize = table[tIndex].nsize = FwdOutAvgPwr_2G_TblSize; /// 21;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdOutPwr_CDMA_TBL;

			for(i = 0; i < tsize; i++)	dsptr[i] = stptr[i];
		}

		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}

	{
		tIndex = Local_RvsOutPwr_2G;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= RvsOutPwr_2G_TblLmt; ///26*2;
		tsize = table[tIndex].nsize = RvsOutPwr_2G_TblSize; ////50;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsOutPwr_CDMA_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}
	
	{
		tIndex = Local_FwdOutAvgPwr_LTE;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= FwdOutAvgPwr_LTE_TblLmt;			//25*2;
		tsize = table[tIndex].nsize = FwdOutAvgPwr_LTE_TblSize;	//21;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdOutPwr_LTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}

	
	{
		tIndex = Local_RvsOutPwr_LTE;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 			= RvsOutPwr_LTE_TblLmt;		//26*2;
		tsize = table[tIndex].nsize 	= RvsOutPwr_LTE_TblSize;	//47;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsOutPwr_LTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	

	{
		tIndex = Local_FwdInPwr_CDMALTE;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= FwdInPwr_CDMALTE_TblLmt;///-4*2;
		tsize = table[tIndex].nsize = FwdInPwr_CDMALTE_TblSize;//38;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdInPwr_CDMALTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	
		
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
		tIndex = Local_RvsInPwr_CDMALTE;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= RvsInPwr_CDMALTE_TblLmt;	//-12*2;
		tsize = table[tIndex].nsize = RvsInPwr_CDMALTE_TblSize;	//31;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsInPwr_CDMALTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	

	{
		tIndex = Local_FwdOutAvgPwr_LTE_A2;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= FwdOutAvgPwr_LTE_A2_TblLmt;	//28*2;
		tsize = table[tIndex].nsize = FwdOutAvgPwr_LTE_A2_TblSize;	//21;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdOutPwr_LTE_A2_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	

	{
		tIndex = Local_RvsOutPwr_LTE_A2;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= RvsOutPwr_LTE_A2_TblLmt; //26*2;
		tsize = table[tIndex].nsize = RvsOutPwr_LTE_A2_TblSize;//38;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsOutPwr_LTE_A2_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);
	}	

	{
		tIndex = Local_RvsInPwr_3G;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= RvsInPwr_3G_TblLmt; //-12*2;
		tsize = table[tIndex].nsize = RvsInPwr_3G_TblSize;//31;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsInPwr_WCDMA_TBL;
			
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
		
		//////////////////
	{
		tIndex = Local_FwdInPwr_LTE_A;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= FwdInPwr_LTE_A_TblLmt;//-15*2;
		tsize = table[tIndex].nsize = FwdInPwr_LTE_A_TblSize;//27;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdInPwr_LTE_A_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize)*2 + 2);

	}	

	{
		tIndex = Local_RvsInPwr_LTE_A;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= RvsInPwr_LTE_A_TblLmt;//-12*2;
		tsize = table[tIndex].nsize = RvsInPwr_LTE_A_TblSize;//39;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)RvsInPwr_LTE_A_TBL;
			
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
		tIndex = Local_FwdInPwr_3G;
		__OutputTblStr *table = (__OutputTblStr *)OutputTable;
		ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));

		table[tIndex].limit 		= FwdInPwr_3G_TblLmt;//-17*2;
		tsize = table[tIndex].nsize = FwdInPwr_3G_TblSize;//26;
		{
			INT16U *dsptr = (INT16U *)table[tIndex].Data;
			INT16U *stptr = (INT16U *)FwdInPwr_WCDMA_TBL;
			
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
		tIndex = Local_FwdAttn1_2G;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdAttn1_2G_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn1_2G;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn1_2G_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}	
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);
	}

	{
		tIndex = Local_RvsAttn2_2G;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));


		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn2_2G_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);
	}

	{
		tIndex = Local_RvsAttn3_2G;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn3_2G_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}
	{
		tIndex = Local_FwdAttn1_LTE;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdAttn1_LTE_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}	
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn1_LTE;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn1_LTE_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);
	}


	{
		tIndex = Local_RvsAttn2_LTE;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn2_LTE_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn3_LTE;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn3_LTE_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

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
		tIndex = Local_FwdAttn1_LTE_A2;
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

		tIndex = Local_FwdAttn2_LTE_A2;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdAttn2_LTE_A2_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}

	{
		tIndex = Local_RvsAttn1_LTE_A2;
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
		tIndex = Local_RvsAttn2_LTE_A2;
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
		tIndex = Local_RvsAttn3_LTE_A2;
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
		tIndex = Local_FwdAttn1_3G;
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
		tIndex = Local_FwdAttn2_3G;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdAttn2_WCDMA_TBL;
				
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize) + 2);

	}


	{
		tIndex = Local_RvsAttn1_3G;
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
		tIndex = Local_RvsAttn2_3G;
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
		tIndex = Local_RvsAttn3_3G;
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

	{
		tIndex = Local_RvsAttn4_3G;
		__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
		ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));

		table[tIndex].limit 		= AttMaxLimit;
		tsize = table[tIndex].nsize = AttTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsAttn4_WCDMA_TBL;
				
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
		tIndex = Local_FwdTempAttn_LTE;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)FwdTempAtt_LTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}

	{
		tIndex = Local_RvsTempAttn_LTE;
		__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
		ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));

		table[tIndex].limit 		= TempMaxlimit;
		tsize = table[tIndex].nsize = TempTBL_Size;
		{
			INT8U *dsptr = (INT8U *)table[tIndex].Data;
			INT8U *stptr = (INT8U *)RvsTempAtt_LTE_TBL;
			
			for(i = 0; i < tsize; i++) dsptr[i] = stptr[i];
		}
		TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
	}

	{
		tIndex = Local_FwdTempAttn_LTE_A2;
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
		tIndex = Local_RvsTempAttn_LTE_A2;
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
		tIndex = Local_FwdTempAttn_3G;
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
		tIndex = Local_RvsTempAttn_3G;
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
#if 0
	int i = 0;
	int j = 0;

	
	EE_TABLE *tptr = (EE_TABLE *)&gEE_TABLE;
	{

		__AttnOffsetTblStr *AttTblStr;


		for(j = 0; j < Local_AttnSts_Max; j++) 
		{
			
			AttTblStr = &tptr->AttnTbl[j];
			AttTblStr->limit = AttMaxLimit;
			AttTblStr->nsize = 61;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
			}
		}
	}

	{
		__AttnTempTblStr *AttTblStr;
		for(j = 0; j < Local_TempAttnSts_Max; j++) 
		{
			
			AttTblStr = &tptr->AttnTempTbl[j];
			AttTblStr->limit = TempMaxlimit;
			AttTblStr->nsize = TempTBL_Size;
			{
				INT8U *dsptr = (INT8U *)AttTblStr->Data;
				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = (NULL);
			}
		}
	}

	{
		__OutputTblStr *TblStr;

		for(j = 0; j < Local_PwrSts_Max; j++) 
		{
			
			TblStr = &(tptr->OutputTbl[j]);
			TblStr->limit = 0;
			TblStr->nsize = OutputTBL_Size;
			{
				INT16U *dsptr = (INT16U *)TblStr->Data;
				for(i = 0; i < TblStr->nsize; i++) dsptr[i] = (NULL);
			}
		}
	}
	
	for(i = 0; i < sizeof(EE_TABLE); i++)
	{
		WriteEEprom(At24cDevID, vEE_TABLEAddr + i, *((INT8U *)tptr + i), 0);
	}


#endif	
}


////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

