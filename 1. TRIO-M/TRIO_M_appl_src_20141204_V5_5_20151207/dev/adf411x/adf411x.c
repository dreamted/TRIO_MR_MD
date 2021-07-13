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
 * - used for LMX2306/LMX2316/LMX411x
 
 * $Revision: 0.1 $
 * $Revision date: 2006.08.__
 *
  ******************************************************************************/
#define PLL_C
 
#include "../include/main.h"


#define __PRE		32


#define	Pll232x_debug

void Pll411xCreate(_pPll411xStr ptr, 
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

void SetPllClkA(void)
{
	PLL_CLK = 1;
}

void RstPllClkA(void)
{
	PLL_CLK = 0;
}

void SetPllDataA(void)
{
	PLL_DATA = 1;
}

void RstPllDataA(void)
{
	PLL_DATA = 0;
}

#ifdef __PLLEnToggle
	void SetPllEnA(void)	// PLL IN1
	{
		PLL_EN1 = 0;
	}

	void RstPllEnA(void)	// PLL IN1
	{
		PLL_EN1 = 1;
	}

	void SetPllEnB(void)	// PLL IN1
	{
		PLL_EN2 = 0;
	}

	void RstPllEnB(void)	// PLL IN1
	{
		PLL_EN2 = 1;
	}

	void SetPllEnC(void)	// PLL IN1
	{
		PLL_EN3 = 0;
	}

	void RstPllEnC(void)	// PLL IN1
	{
		PLL_EN3 = 1;
	}	
#else
	void SetPllEnA(void)	// PLL IN1
	{
		PLL_EN1 = 1;
	}

	void RstPllEnA(void)	// PLL IN1
	{
		PLL_EN1 = 0;
	}

	void SetPllEnB(void)	// PLL IN1
	{
		PLL_EN2 = 1;
	}

	void RstPllEnB(void)	// PLL IN1
	{
		PLL_EN2 = 0;
	}
#endif


void Pll411xInit(INT32U rfrq, INT32U dRatio, _pPll411xStr ptr)	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
{
    if(ptr)
    {
	    ptr->rfrq = rfrq;
	    ptr->dRatio = dRatio;
	    ptr->PR = rfrq/dRatio;
	}
}

void Pll411x_Output(INT32U fvco, _pPll411xStr ptr)
{
	INT32U tMsb = (1 << 23);
	INT32U i = 0;
 	SetpPCA9555SDAOutMode();
	SerPtr->printf("\nfvco[%u]", fvco);

	fvco = fvco/ptr->dRatio;	// 1.8Ghz = 18000 -> 180 000 0000
	{
		_RCounterReg RCounter;
		_NCounterReg NCounter;
		_FUNCReg Func;

		RCounter.Data = 0;				// init
		NCounter.Data = 0;				// init
		Func.Data = 0;

		// Reference Counter
		RCounter.Bit.C = __RCounter;
		RCounter.Bit.R = ptr->PR;		// RefFreq / FreqStep
		RCounter.Bit.DLY = 0;			//RCounter.Bit.DLY = 1;

	

		// AB Counter
		NCounter.Bit.C = __NCounter;
		NCounter.Bit.A = fvco%__PRE;
		NCounter.Bit.B = fvco/__PRE;
		NCounter.Bit.CPGAIN = 0;	// NCounter.Bit.CPGAIN = 1;

		// Function
		Func.Bit.C = __FUNCSet;
		Func.Bit.LD = __LDDIG;
		Func.Bit.POL = __POS;//__NEG;
		Func.Bit.CUR1SET = 7;
		Func.Bit.CUR2SET = 7;
		Func.Bit.PLVALUE = 2;	// 32/33
		
		#ifdef Pll232x_debug
		{
			SerPtr->printf("\nR Counter: %03x \n", RCounter.Grp.tot & 0xffffff);
			SerPtr->printf("N Counter: %03x \n", NCounter.Grp.tot & 0xffffff);
			SerPtr->printf("F Counter: %03x \n", Func.Grp.tot & 0xffffff);
			//OSTimeDly(100);
		}
		#endif

		// R Counter Program modes
		
		ptr->SetEn();
		ForDelay(300);
		ptr->RstEn();
		ForDelay(300);
		for(i = 0; i < 24; i++)			
		{	
			if(RCounter.Grp.tot & tMsb)	ptr->SetData();// ExpioBitSet(PllData);
			else						ptr->RstData();// ExpioBitRst(PllData);

			RCounter.Grp.tot <<= 1;
			ptr->SetClk();
			ForDelay(20);
			ptr->RstClk();
			ForDelay(20);
		}	
		
		ForDelay(300);
		ptr->SetEn();
		ForDelay(300);

		// AB Counter Program modes	(5bit)
		ptr->RstEn();
		
		ForDelay(300);
//		ForDelay(20);
		for(i = 0; i < 24; i++) 		
		{	
			if(NCounter.Grp.tot & tMsb)	ptr->SetData();
			else					 	ptr->RstData();

			NCounter.Grp.tot <<= 1; 
			ptr->SetClk();
			ForDelay(20);
			ptr->RstClk();
			ForDelay(20);
		}		
		
		ForDelay(300);
		ptr->SetEn();
		
		// Func Program modes	(5bit)
//		ForDelay(20);
		ForDelay(300);
		ptr->RstEn();
		ForDelay(300);
		for(i = 0; i < 24; i++) 		
		{	
			if(Func.Grp.tot & tMsb) 	ptr->SetData();
			else						ptr->RstData();
		
			Func.Grp.tot <<= 1; 
			ptr->SetClk();
			ForDelay(20);
			ptr->RstClk();
			ForDelay(20);
		}		
		
		ForDelay(300);
		ptr->SetEn();
//		ForDelay(20);
		ForDelay(300);
		ptr->RstEn();
//		ForDelay(20);
		ForDelay(300);
	}
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

