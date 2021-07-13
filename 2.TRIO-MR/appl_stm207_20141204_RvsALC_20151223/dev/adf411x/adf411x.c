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

#define	__PRE		32

//#define	Pll232x_debug

#define CLKDELAY	ForDelay(10)

void SetPllClk(INT8U Path)
{
	     if(Path == 0)	PLL_CLK = SET;
	else if(Path == 1)	PLL_CLK = SET;
}

void RstPllClk(INT8U Path)
{
	     if(Path == 0)	PLL_CLK = RESET;
	else if(Path == 1)	PLL_CLK = RESET;
}

void SetPllData(INT8U Path)
{
	CLKDELAY;	
	     if(Path == 0)	PLL_DATA = SET;
	else if(Path == 1)	PLL_DATA = SET;
}

void RstPllData(INT8U Path)
{
	CLKDELAY;	
	     if(Path == 0) 	PLL_DATA = RESET;
	else if(Path == 1)	PLL_DATA = RESET;
}

////////////////////////////////////////////////////
void SetPllEn(INT8U Path)
{
#if 0
	     if(Path == 0)	PLLEN_LTE_A2 = SET;
	else if(Path == 1)	PLLEN_LTE_A2_1 = SET;
#endif
#if 1
	     if(Path == 0)	PLLEN_LTE_A2 = RESET;
	else if(Path == 1)	PLLEN_LTE = RESET;
#endif	

}

void RstPllEn(INT8U Path)
{
#if 0
	     if(Path == 0)	PLLEN_LTE_A2 = RESET;
	else if(Path == 1)	PLLEN_LTE_A2_1 = RESET;
#endif
#if 1
	     if(Path == 0)	PLLEN_LTE_A2 = SET;
	else if(Path == 1)	PLLEN_LTE = SET;
#endif	

}

//rfrq: Reference Freq,  dRatio: dRatio, PR: Devide Prescaler
void Pll411xInit(INT32U rfrq, INT32U dRatio, INT8U Path)
{
	dReffreq[Path] = rfrq;
	dStep[Path] = dRatio;
	dPre[Path] = rfrq/dRatio;
}

void Pll411x_Output(INT32U fvco, INT8U Path)
{
	INT32U tMsb = (1 << 23);
	INT32U i = 0;

 	SetpPCA9555SDAOutMode();

//	SerPtr->printf("\nfvco[%u], dStep[%d], dPre[%d]", fvco,dStep[Path],dPre[Path]);
	
	fvco = fvco/dStep[Path];	// 1.8Ghz = 18000 -> 1800000000
	{
		_RCounterReg RCounter;
		_NCounterReg NCounter;
		_FUNCReg Func;

		RCounter.Data = 0;				// init
		NCounter.Data = 0;				// init
		Func.Data = 0;

		// Reference Counter
		RCounter.Bit.C = __RCounter;
		RCounter.Bit.R = dPre[Path];	// RefFreq / FreqStep
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
		Func.Bit.PLVALUE = PreScl;
		
		#ifdef Pll232x_debug
		{
			SerPtr->printf("\nR Counter: %03x \n", RCounter.Grp.tot & 0xffffff);
			SerPtr->printf("N Counter: %03x \n", NCounter.Grp.tot & 0xffffff);
			SerPtr->printf("F Counter: %03x \n", Func.Grp.tot & 0xffffff);
		}
		#endif

		// R Counter Program modes

		SetPllEn(Path);
		ForDelay(20);
		RstPllEn(Path);
		ForDelay(20);

		for(i = 0; i < 24; i++)			
		{	
			if(RCounter.Grp.tot & tMsb)	SetPllData(Path);
			else						RstPllData(Path);

			RCounter.Grp.tot <<= 1;
			SetPllClk(Path);
			
//			ForDelay(20);
			RstPllClk(Path);
			
//			ForDelay(20);
		}	
		
		ForDelay(20);
		SetPllEn(Path);
		ForDelay(20);///

		// AB Counter Program modes	(5bit)
		RstPllEn(Path);
	//	ForDelay(20);
	
		ForDelay(20);
		for(i = 0; i < 24; i++) 		
		{	
			if(NCounter.Grp.tot & tMsb)	SetPllData(Path);
			else					 	RstPllData(Path);

			NCounter.Grp.tot <<= 1; 
			SetPllClk(Path);
//			ForDelay(20);
			RstPllClk(Path);
//			ForDelay(20);
		}		

		
		ForDelay(20);////
		SetPllEn(Path);
		
		// Func Program modes	(5bit)
		
		ForDelay(20);///
		RstPllEn(Path);
		ForDelay(20);///a
		for(i = 0; i < 24; i++) 		
		{	
			if(Func.Grp.tot & tMsb) 	SetPllData(Path);
			else						RstPllData(Path);
		
			Func.Grp.tot <<= 1; 
			SetPllClk(Path);
			
//			ForDelay(20);//
			RstPllClk(Path);
//			ForDelay(20);///
		}		
		
		ForDelay(20);///
		SetPllEn(Path);
		ForDelay(20); //
		RstPllEn(Path);
		ForDelay(20);  //

	}
	////////////////////////////////////////////////////////////	
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

