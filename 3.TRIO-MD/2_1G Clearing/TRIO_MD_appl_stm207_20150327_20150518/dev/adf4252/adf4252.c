/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original source file, a function
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
 * $Revision date: 2006.08.__
 *
  ******************************************************************************/
#include "../include/main.h"
//#include "../include/adf4252.h"
#define ADF4252_debug

//#define __IFPRE			16
//#define __RFPRE			128

#define __RFRVAL	5
//#define __IFRVAL	65

//#define __IFPRE			8
#define __IFPRE			16
//#define __IFPRE			32
//#define __IFPRE			64

//////////////////////////////////////////////////////////////////////////////////////
// Ref
typedef struct {
	INT32U rfrq;
	INT32U rsol;
	INT16U pllClkAddr;
	INT16U pllDataAddr;
	INT16U pllEnAddr;

} _ADF4252Str;

_ADF4252Str ADF4252StrB;
_ADF4252Str *ADF4252Str = &ADF4252StrB;

void ADF4252Init(INT32U rfrq, INT32U rsol, INT16U pllClkAddr, INT16U pllDataAddr, INT16U pllEnAddr)
	//rfrq: Reference Freq,  Resol: Resolution
{
	ADF4252Str->rfrq = rfrq;
	ADF4252Str->rsol = rsol;
	ADF4252Str->pllClkAddr = pllClkAddr;
	ADF4252Str->pllDataAddr = pllDataAddr;
	ADF4252Str->pllEnAddr = pllEnAddr;
}
void ADF4252IFOutput(INT64U fvco)
{
	INT32U tMsb = (1 << 21);
	INT32U i = 0;
	INT32U cpu_sr;

	{
		_IFNDividerReg	IFNDivider;
		_IFRDividerReg	IFRDivider;
		_IFControlReg IFControl;
		_MasterReg Master;

		IFNDivider.Data = __IFNDividerRegSel;
		IFRDivider.Data = __IFRDividerRegSel;
		IFControl.Data = __IFControlRegSel;
		Master.Data = __MasterRegSel;

		fvco = fvco/ADF4252Str->rsol;
		{
			INT32U D = __DISABLE;	// Doubler disable
			INT32U R = (ADF4252Str->rfrq*(1+D))/ADF4252Str->rsol;
			INT32U A = fvco%__IFPRE;
			INT32U B = fvco/__IFPRE;

			IFNDivider.Bit.A = A;
			IFNDivider.Bit.B = B;

			{
				INT32U tmp = __IFPRE;

				     if(tmp == 8)	tmp = __IF_PR8;
				else if(tmp == 16)	tmp = __IF_PR16;
				else if(tmp == 32)	tmp = __IF_PR32;
				else if(tmp == 64)	tmp = __IF_PR64;

				IFNDivider.Bit.IFPRESCALER = tmp;
			}
			IFNDivider.Bit.IFCPGain = __DISABLE;


		IFRDivider.Bit.R = R;
		IFRDivider.Bit.IFDOUBLER = D;


		IFControl.Bit.IFCOUNTERRst = __DISABLE;
		IFControl.Bit.IFCPThreeSts = __DISABLE;
		IFControl.Bit.IFPWRDN = __DISABLE;
		IFControl.Bit.IFLDP = __IFLDP3;
		IFControl.Bit.IFPDPOL = __POS;
		IFControl.Bit.IFCPCURSet = __IFICP1mA;
		IFControl.Bit.RFPhaseRSync1 = __RFRSyncDisable;
		IFControl.Bit.RFPhaseRSync2 = __RFRSyncDisable;

		Master.Bit.COUNTERRst = __DISABLE;
		Master.Bit.CPThreeSts = __DISABLE;
		Master.Bit.PWRDN = __DISABLE;
		Master.Bit.XODisable = __XOEnable;	// 0
		Master.Bit.MuxOut = __IFDIGLock;	// 0

		}

		#ifdef ADF4252_debug
		{
			Ser0Printf("IF N Divider: %06x \n", IFNDivider.Grp.tot & 0xffffff);
			Ser0Printf("IF R Counter: %05x \n", IFRDivider.Grp.tot & 0xffffff);
			Ser0Printf("IF CONTROL  : %04x \n", IFControl.Grp.tot & 0xffffff);
			Ser0Printf("MASTER      : %03x \n", Master.Grp.tot & 0xffffff);
			OSTimeDly(100);
		}
		#endif
		OS_ENTER_CRITICAL();

		tMsb = 1 << 23;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 24; i++)				// N Divider
		{
			if(IFNDivider.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else							ExpioBitRst(ADF4252Str->pllDataAddr);

			IFNDivider.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);

		tMsb = 1 << 18;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 19; i++)				// N Divider
		{
			if(IFRDivider.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else							ExpioBitRst(ADF4252Str->pllDataAddr);

			IFRDivider.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);

		tMsb = 1 << 15;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 16; i++)				// N Divider
		{
			if(IFControl.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else							ExpioBitRst(ADF4252Str->pllDataAddr);

			IFControl.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);

		tMsb = 1 << 10;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 11; i++)				// N Divider
		{
			if(Master.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else						ExpioBitRst(ADF4252Str->pllDataAddr);

			Master.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);
		OS_EXIT_CRITICAL();
	}
}
void ADF4252RFOutput(INT64U fvco)
{
	INT32U tMsb = (1 << 21);
	INT32U i = 0;
	INT32U cpu_sr;

	{
		_RFNDividerReg	RFNDivider;
		_RFRDividerReg	RFRDivider;
		_RFControlReg RFControl;
		_MasterReg Master;

		RFNDivider.Data = __RFNDividerRegSel;
		RFRDivider.Data = __RFRDividerRegSel;
		RFControl.Data = __RFControlRegSel;
		Master.Data = __MasterRegSel;

		{
			INT32U R = __RFRVAL;	// RF reference division factor
			INT32U D = __DISABLE;	// Doubler disable
			INT32U Fpfd = (ADF4252Str->rfrq/R)*((1+D));
			INT32U MOD = Fpfd/ADF4252Str->rsol;

			RFNDivider.Bit.INTVAL = fvco/Fpfd;
			RFNDivider.Bit.FRACVAL = ((((fvco*100L)/Fpfd)%100L)*MOD)/100L;
			RFRDivider.Bit.MODVAL = MOD;
			RFRDivider.Bit.R = R;
			RFRDivider.Bit.RFDOUBLER = D;
			RFRDivider.Bit.RFPRESCALER = __RF_PR8;

			RFControl.Bit.RFCOUNTERRst = __DISABLE;
			RFControl.Bit.RFCPThreeSts = __DISABLE;
			RFControl.Bit.RFPWRDN = __DISABLE;
			{
				INT8U Set = __LOWESTNOISE;

				RFControl.Bit.RFNASSet1 = (Set >> 0) & (0x01);
				RFControl.Bit.RFNASSet2 = (Set >> 1) & (0x01);
				RFControl.Bit.RFNASSet3 = (Set >> 2) & (0x01);;
			}
			RFControl.Bit.RFPDPOL = __POS;
			RFControl.Bit.RFCPCURSet = __RFICP7mA;

			Master.Bit.COUNTERRst = __DISABLE;
			Master.Bit.CPThreeSts = __DISABLE;
			Master.Bit.PWRDN = __DISABLE;
			Master.Bit.XODisable = __XODisable;	// 0
			Master.Bit.MuxOut = __RFDIGLock;	// 0

			#ifdef ADF4252_debug
			{
				Ser0Printf("VCO: %d [MHz]\n", fvco/1000000L);
				Ser0Printf("RF ref: %d, Fpfd: %d, MOD: %06x \n",  ADF4252Str->rfrq,  Fpfd, MOD & 0xffffff);
				Ser0Printf("INTVAL: %d, FRACVAL: %d \n",  RFNDivider.Bit.INTVAL,  RFNDivider.Bit.FRACVAL);
				Ser0Printf("RF N Divider: %06x \n", RFNDivider.Grp.tot & 0xffffff);
				Ser0Printf("RF R Counter: %05x \n", RFRDivider.Grp.tot & 0xffffff);
				Ser0Printf("RF CONTROL  : %04x \n", RFControl.Grp.tot & 0xffffff);
				Ser0Printf("MASTER      : %03x \n", Master.Grp.tot & 0xffffff);
				OSTimeDly(100);
			}
			#endif
		}
		OS_ENTER_CRITICAL();

		tMsb = 1 << 23;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 24; i++)				// N Divider
		{
			if(RFNDivider.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else							ExpioBitRst(ADF4252Str->pllDataAddr);

			RFNDivider.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);

		tMsb = 1 << 20;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 21; i++)				// N Divider
		{
			if(RFRDivider.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else							ExpioBitRst(ADF4252Str->pllDataAddr);

			RFRDivider.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);

		tMsb = 1 << 15;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 16; i++)				// N Divider
		{
			if(RFControl.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else							ExpioBitRst(ADF4252Str->pllDataAddr);

			RFControl.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);

		tMsb = 1 << 10;
		ExpioBitRst(ADF4252Str->pllEnAddr);
		for(i = 0; i < 11; i++)				// N Divider
		{
			if(Master.Grp.tot & tMsb)	ExpioBitSet(ADF4252Str->pllDataAddr);
			else						ExpioBitRst(ADF4252Str->pllDataAddr);

			Master.Grp.tot <<= 1;
			ExpioBitSet(ADF4252Str->pllClkAddr);
			ExpioBitRst(ADF4252Str->pllClkAddr);
		}
		ExpioBitSet(ADF4252Str->pllEnAddr);
		OS_EXIT_CRITICAL();

	}
	////////////////////////////////////////////////////////////
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

