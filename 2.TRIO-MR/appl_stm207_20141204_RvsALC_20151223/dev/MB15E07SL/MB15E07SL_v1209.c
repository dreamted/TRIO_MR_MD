#define PLL_C

#include "../include/main.h"
//#define Pll_debug

#define __PRE			32


void LM15E07SLCreate(_pMB15E07SLStr ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)(),
							  void (*SetEn)(), void (*RstEn)() )
{
    ptr->SetPllClk = SetClk;
    ptr->RstPllClk = RstClk;
    ptr->SetPllData = SetData;
    ptr->RstPllData = RstData;
    ptr->SetPllEn = SetEn;
    ptr->RstPllEn = RstEn;    
}


void LM15E07SLInit(INT32U rfrq, INT32U dRatio, _pMB15E07SLStr ptr)	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
{
	ptr->rfrq = rfrq;
	ptr->dRatio = dRatio;
	ptr->PR = rfrq/dRatio;

	ptr->fvco = 0;
}


void LM15E07SLOutput(INT32U fvco, _pMB15E07SLStr ptr)
{
	INT32U tMsb = (1 << 18);
	INT32U i = 0;
	//INT32U cpu_sr;

	if(ptr->fvco == fvco) return;
	

	fvco = fvco/ptr->dRatio;
	{
		_RCounterReg RCounter;
		_NCounterReg NCounter;

		RCounter.Data = 0;				// init
		NCounter.Data = 0;				// init
		
		RCounter.CNT = __RCounter;
		RCounter.R = ptr->PR;
#if (__PRE == 32)
		RCounter.SW = __32;
#else
		RCounter.SW = __64;
#endif
		RCounter.FC = SET;
		RCounter.LDS = __LD;
		RCounter.CS = __1p5mA;

		NCounter.CNT = __NCounter;
		
		NCounter.A = fvco%__PRE;
		NCounter.N = fvco/__PRE;

		#ifdef Pll_debug
		{
			SerPtr->printf("R Counter: %03x \n", RCounter.Data & 0xffffff);
			SerPtr->printf("N Counter: %03x \n", NCounter.Data & 0xffffff);
			OSTimeDly(100);
		}
		#endif
		
		ptr->RstPllEn();

		for(i = 0; i < 19; i++)			// R Counter Program modes	(5bit)
		{	
			if(RCounter.Data & tMsb)	ptr->SetPllData();
			else						ptr->RstPllData();

			RCounter.Data <<= 1;
			ptr->SetPllClk();
			ptr->RstPllClk();
		}	

		ptr->SetPllEn();
		ptr->RstPllEn();

		for(i = 0; i < 19; i++) 		// R Counter Program modes	(5bit)
		{	
			if(NCounter.Data & tMsb)	ptr->SetPllData();
			else					 	ptr->RstPllData();

			NCounter.Data <<= 1; 
			ptr->SetPllClk();
			ptr->RstPllClk();
		}		
		ptr->SetPllEn();
		ptr->RstPllEn();
	
	}
	////////////////////////////////////////////////////////////	
}

void SetPllClk(void)
{
	_PLL_CLK = 1;

#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllClk(void)
{
	_PLL_CLK = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void SetPllData(void)
{
	_PLL_DATA = 1;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllData(void)
{
	_PLL_DATA = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void SetPllEnA(void)	// PLL IN1
{
	_4G_PLL_EN = 1;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllEnA(void)	// PLL IN1
{
	_4G_PLL_EN = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void SetPllEnB(void)	// PLL IN1
{
	//_3G_PLL_EN_GT = 1;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllEnB(void)	// PLL IN1
{
	//_3G_PLL_EN_GT = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void SetPllEnC(void)	// PLL IN1
{
	_3G_PLL_EN = 1;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllEnC(void)	// PLL IN1
{
	_3G_PLL_EN = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}



////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

