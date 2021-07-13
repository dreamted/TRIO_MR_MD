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
//#include "../include/main.h"
#define DEV_ADF4153

#include "../include/main.h"

//#define ADF4153_debug

//#define __IFPRE			16
//#define __RFPRE			128

#define __RFRVAL	1
//#define __IFRVAL	65

//#define __IFPRE			8
//#define __IFPRE			16
//#define __IFPRE			32
//#define __IFPRE			64

void SetRxPllClk(void)
{
	ExpioBitSet(RxPLL_CLKSel);
}

void RstRxPllClk(void)
{
	ExpioBitRst(RxPLL_CLKSel);
}

void SetRxPllData(void)
{
	ExpioBitSet(RxPLL_DATASel);
}

void RstRxPllData(void)
{
	ExpioBitRst(RxPLL_DATASel);
}

void SetRxPllEnA(void)	// RX PLL IN1
{
	//ExpioBitSet(RxBEACONFA1EnSel);
	ForDelay(ADF4153DELAY);
}

void RstRxPllEnA(void)	// RX PLL IN1
{
//	ExpioBitRst(RxBEACONFA1EnSel);
	ForDelay(ADF4153DELAY);
}

void SetRxPllEnB(void)	// RX PLL IN2
{
//	ExpioBitSet(RxBEACONFA2EnSel);
	ForDelay(ADF4153DELAY);
}


void RstRxPllEnB(void)	// RX PLL IN2
{
//	ExpioBitRst(RxBEACONFA2EnSel);
	ForDelay(ADF4153DELAY);
}

void SetRxPllEnC(void)	// Rx PLL OUT
{
#ifdef __SUNWAVE
	ExpioBitSet(PLL_EN3Sel);
#else
	ExpioBitSet(RxCopyEnSel);
#endif
#ifdef __SUNWAVE
		ForDelay(ADF4153DELAY);
#endif
}

void RstRxPllEnC(void)	// Rx PLL OUT
{
#ifdef __SUNWAVE
	ExpioBitRst(PLL_EN3Sel);
#else
	ExpioBitRst(RxCopyEnSel);
#endif
#ifdef __SUNWAVE
	ForDelay(ADF4153DELAY);
#endif
}



void SetTxPllClk(void)
{
	//ExpioBitSet(PLL_CLKsel);
}

void RstTxPllClk(void)
{
	//ExpioBitRst(PLL_CLKsel);
}

void SetTxPllData(void)
{
	//ExpioBitSet(PLL_DATASel);
}

void RstTxPllData(void)
{
	//ExpioBitRst(PLL_DATASel);
}


void SetTxPllEnA(void)	// TX PLL OUT1
{
	ExpioBitSet(TxBEACONFA1EnSel);
}

void RstTxPllEnA(void)	// TX PLL OUT1
{
	ExpioBitRst(TxBEACONFA1EnSel);
}

void SetTxPllEnB(void)	// TX PLL OUT2
{
	ExpioBitSet(TxBEACONFA2EnSel);
}

void RstTxPllEnB(void)	// PLL IN2
{
	ExpioBitRst(TxBEACONFA2EnSel);
}

void SetTxPllEnC(void)	// TX PLL IN
{
	ExpioBitSet(TxCopyEnSel);
}

void RstTxPllEnC(void)	// TX PLL IN
{
	ExpioBitRst(TxCopyEnSel);
}


////////////////////////////////////////////////////////////////////////////////
void ADF4153Create(_pADF4252Str ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)(),
							  void (*SetEn)(), void (*RstEn)() )
{
	ptr->SetClk = SetClk;
	ptr->RstClk = RstClk;
	ptr->SetData = SetData;
	ptr->RstData = RstData;
	ptr->SetEn = SetEn;
	ptr->RstEn = RstEn;

	ptr->RstData();
	ptr->RstClk();
	//ptr->SetEn();
	ptr->RstEn();
}


void ADF4153Init(INT32U rfrq, INT32U rsol, _pADF4252Str ptr)
{
	ptr->rfrq = rfrq;
	ptr->rsol = rsol;
}


_ADF4153Reg ADF4153RFOutput(INT32U fvco, _pADF4252Str ptr, INT8U nfullCtrl)
{
	INT32U i = 0;
	_ADF4153Reg Reg;

	{
		_RFNDividerReg	RFNDivider;
		_RFRDividerReg	RFRDivider;
		_RFControlReg RFControl;
		_RFNoiseReg RFNoise;

		RFNDivider.Data = __RFNDividerRegSel;
		RFRDivider.Data = __RFRDividerRegSel;
		RFControl.Data = __RFControlRegSel;
		RFNoise.Data = __RFNoiseSpurRegSet;

		{
			INT32U R = __RFRVAL;	// RF reference division factor
			INT32U D = __DISABLE;	// Doubler disable
			INT32U Fpfd = (ptr->rfrq/R)*((1+D));
			INT32U MOD = Fpfd/ptr->rsol;

			// N Divider Set
			RFNDivider.Bit.INTVAL = fvco/Fpfd;
			//RFNDivider.Bit.FRACVAL = (((((INT64U)fvco*100L)/Fpfd)%100L)*MOD)/100L;
			{
				double tmp;
				tmp = (double)fvco/(double)Fpfd - (double)RFNDivider.Bit.INTVAL;
				tmp = tmp*MOD*10L;
				RFNDivider.Bit.FRACVAL = ((INT32U)tmp + 1)/10L;
			}
			RFNDivider.Bit.FL = __NOR;

			// R Divider Set
			RFRDivider.Bit.MODVAL = MOD;
			RFRDivider.Bit.R = R;
			if(fvco > 2000000000L) 	RFRDivider.Bit.RFPRESCALER = __RF_PR8;
			else					RFRDivider.Bit.RFPRESCALER = __RF_PR4;

			RFRDivider.Bit.MUXOUT = __DIGLock;
			RFRDivider.Bit.LOADCTRL = __NOR;


			RFControl.Bit.RFCOUNTERRst = __DISABLE;
			RFControl.Bit.RFCPThreeSts = __DISABLE;
			RFControl.Bit.RFPWRDN = __DISABLE;
			RFControl.Bit.LDP = __24PFD;
			RFControl.Bit.RFPDPOL = __POS;
			RFControl.Bit.RFCPCURSet = __ICP5_1K_1_25mA;//__ICP5_1K_1_25mA;
			RFControl.Bit.RFDOUBLER = __DISABLE;
			RFControl.Bit.RFRYNC = 0;

			RFNoise.Bit.NOISEMODE = __LowestNoise;
//#define	ADF4153_debug

			#ifdef ADF4153_debug
			{
				SerPtr->printf("VCO: %d [MHz]\n", fvco/1000000L);
				SerPtr->printf("RF ref: %d, Fpfd: %d, MOD: %06x \n",  ptr->rfrq,  Fpfd, MOD & 0xffffff);
				SerPtr->printf("INTVAL: %d, FRACVAL: %d \n",  RFNDivider.Bit.INTVAL,  RFNDivider.Bit.FRACVAL);
				SerPtr->printf("RF N Divider: %06x \n", RFNDivider.Grp.tot & 0xffffff);
				SerPtr->printf("RF R Counter: %05x \n", RFRDivider.Grp.tot & 0xffffff);
				SerPtr->printf("RF CONTROL  : %04x \n", RFControl.Grp.tot & 0xffffff);
				SerPtr->printf("RF NOISE    : %03x \n", RFNoise.Grp.tot & 0xffffff);
				
				OSTimeDly(100);
			}
			#endif

			Reg.RFNDividerReg = RFNDivider.Data;
			Reg.RFRDividerReg = RFRDivider.Data;
			Reg.RFControlReg = RFControl.Data;
			Reg.RFNoiseSpurReg = RFNoise.Data;

			if(!nfullCtrl) return Reg;
		}

/////////////
// 3
/////////////
			for(i = 0; i < 24; i++)				// Noise & Spur
			{
				if((RFNoise.Data & 0x800000) == 0x800000)	ptr->SetData();
				else										ptr->RstData();


				RFNoise.Data <<= 1;
				ptr->SetClk();
				ptr->RstClk();
			}
			ptr->RstData();
			ptr->SetEn();
			ptr->RstEn();
/////////////
// 2
/////////////
			for(i = 0; i < 24; i++) 			// control
			{
				if((RFControl.Data & 0x800000) == 0x800000)	ptr->SetData();
				else										ptr->RstData();

				ptr->SetClk();
				RFControl.Data <<= 1;
				ptr->RstClk();
			}
			
			ptr->RstData();
			ptr->SetEn();
			ptr->RstEn();
/////////////
// 1
/////////////
		//RFRDivider.Grp.tot = 0x044065;

		//tMsb = 1 << 23;
		for(i = 0; i < 24; i++)				// R Divider
		{
			if((RFRDivider.Data & 0x800000) == 0x800000)	ptr->SetData();
			else											ptr->RstData();

			ptr->SetClk();
			RFRDivider.Data <<= 1;
			ptr->RstClk();
		}
		
		ptr->RstData();
		ptr->SetEn();
		ptr->RstEn();
/////////////
// 0
/////////////

		//tMsb = 1 << 23;

		//RFNDivider.Grp.tot = 0x33401C;

		for(i = 0; i < 24; i++)				// N Divider
		{
			if((RFNDivider.Data & 0x800000) == 0x800000)	ptr->SetData();
			else											ptr->RstData();
			ptr->SetClk();
			RFNDivider.Data <<= 1;
			ptr->RstClk();
		}
		ptr->RstData();
		ptr->SetEn();
		ptr->RstEn();
/////////////// 	
	}

	////////////////////////////////////////////////////////////
	return Reg;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

