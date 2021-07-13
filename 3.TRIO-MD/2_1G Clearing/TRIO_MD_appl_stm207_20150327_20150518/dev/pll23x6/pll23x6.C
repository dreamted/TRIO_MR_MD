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
 * - used for LMX2306/LMX2316/LMX2326
 
 * $Revision: 0.1 $
 * $Revision date: 2006.08.__
 *
  ******************************************************************************/
#define PLL_C
 
#include "../include/main.h"
//#include "../include/pll2332.h"
//#define Pll232x_debug

// 1st Step: select your device
#define _LMX2326
//#define _LMX2316
//#define _LMX2306

#if defined(_LMX2326) || defined(_LMX2316)
	#define __PRE			32
#elif _LMX2306
	#define __PRE			8
#endif

void Pll2326Create(_pPll2336Str ptr, 
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
}

void SetPllClk(void)
{
	ExpioBitSet(PLL_CLKsel);
}

void RstPllClk(void)
{
	ExpioBitRst(PLL_CLKsel);
}

void SetPllData(void)
{
	ExpioBitSet(PLL_DATASel);
}

void RstPllData(void)
{
	ExpioBitRst(PLL_DATASel);
	//GPIOB->ODR.Bit.ODR7 = 0;
}

void SetPllEnA(void)	// PLL IN1
{
	ExpioBitSet(PLL_EN2Sel);
	//GPIOB->ODR.Bit.ODR9 = 1;
}

void RstPllEnA(void)	// PLL IN1
{
	ExpioBitRst(PLL_EN2Sel);
	//GPIOB->ODR.Bit.ODR9 = 0;
}

void SetPllEnB(void)	// PLL IN2
{
	ExpioBitSet(PLL_EN1Sel);
	//GPIOB->ODR.Bit.ODR8 = 1;
}

void RstPllEnB(void)	// PLL IN2
{
	ExpioBitRst(PLL_EN1Sel);
	//GPIOB->ODR.Bit.ODR8 = 0;
}

void SetPllEnC(void)	// PLL OUT
{
	ExpioBitSet(PLL_EN3Sel);
	//GPIOB->ODR.Bit.ODR14 = 1;
}

void RstPllEnC(void)	// PLL OUT
{
	ExpioBitRst(PLL_EN3Sel);
	//GPIOB->ODR.Bit.ODR14 = 0;
}

void Pll2326Init(INT32U rfrq, INT32U dRatio, _pPll2336Str ptr)	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
{
    if(ptr)
    {
	    ptr->rfrq = rfrq;
	    ptr->dRatio = dRatio;
	    ptr->PR = rfrq/dRatio;
	}
}

void Pll2326_Output(INT32U fvco, _pPll2336Str ptr)
{
	INT32U tMsb = (1 << 20);
	INT32U i = 0;

	fvco = fvco/ptr->dRatio;
	{
		_RCounterReg RCounter;
		_NCounterReg NCounter;
		_FUNCReg Func;

		RCounter.Data = 0;				// init
		NCounter.Data = 0;				// init
		Func.Data = 0;
		
		RCounter.Bit.C = __RCounter;
		RCounter.Bit.R = ptr->PR;

		NCounter.Bit.C = __NCounter;
		NCounter.Bit.A = fvco%__PRE;
		NCounter.Bit.B = fvco/__PRE;
		NCounter.Bit.GOBIT = __ICP1mA;

		Func.Bit.C = __FUNCSet;
		Func.Bit.CNTRST = __RSTDISABLED;
		Func.Bit.PWRDN = __PWRUP;
		Func.Bit.LD = __LDDIG;
		Func.Bit.POL = __POS;
		
		#ifdef Pll232x_debug
		{
			Ser0Printf("R Counter: %03x \n", RCounter.Grp.tot & 0xffffff);
			Ser0Printf("N Counter: %03x \n", NCounter.Grp.tot & 0xffffff);
			Ser0Printf("F Counter: %03x \n", Func.Grp.tot & 0xffffff);
			//OSTimeDly(100);
		}
		#endif
		ptr->RstEn();

		for(i = 0; i < 21; i++)			// R Counter Program modes	(5bit)
		{	
			if(RCounter.Grp.tot & tMsb)	ptr->SetData();// ExpioBitSet(PllData);
			else						ptr->RstData();// ExpioBitRst(PllData);

			RCounter.Grp.tot <<= 1;
			ptr->SetClk();
			ptr->RstClk();
		}	
		ptr->SetEn();



		ptr->RstEn();

		for(i = 0; i < 21; i++) 		// R Counter Program modes	(5bit)
		{	



			if(NCounter.Grp.tot & tMsb)	ptr->SetData();
			else					 	ptr->RstData();

			NCounter.Grp.tot <<= 1; 
			ptr->SetClk();
			ptr->RstClk();
		}		
		ptr->SetEn();

		ptr->RstEn();
		tMsb = 1 << 19;
		
		for(i = 0; i < 20; i++) 		// R Counter Program modes	(5bit)
		{	
			if(Func.Grp.tot & tMsb) 	ptr->SetData();
			else						ptr->RstData();
		
			Func.Grp.tot <<= 1; 
			ptr->SetClk();
			ptr->RstClk();
		}		
		ptr->SetEn();
		ptr->RstEn();
		
	}
	////////////////////////////////////////////////////////////	
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

