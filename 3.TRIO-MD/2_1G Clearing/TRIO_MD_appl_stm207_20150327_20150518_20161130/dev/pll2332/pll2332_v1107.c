#define PLL_C

#include "../include/main.h"
//#include "../include/pll2332.h"
//#define Pll233x_debug

#define __IFPRE			16
#define __RFPRE			64


void Pll2322Create(_pPll2332Str ptr, 
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


void Pll2332Init(INT32U rfrq, INT32U dRatio, _pPll2332Str ptr)	//rfrq: Reference Freq,  dRatio: dRatio: Devide Prescaler
{
	ptr->rfrq = rfrq;
	ptr->dRatio = dRatio;
	ptr->PR = rfrq/dRatio;

	ptr->IFfvco = 0;
	ptr->RFfvco = 0;
}


void Pll2332_IFOutput(INT32U fvco, _pPll2332Str ptr)
{
	INT32U tMsb = (1 << 21);
	INT32U i = 0;
	//INT32U cpu_sr;

	if(ptr->IFfvco == fvco) return;
	

	fvco = fvco/ptr->dRatio;
	{
		_RCounterReg RCounter;
		_NCounterReg NCounter;

		RCounter.Data = 0;				// init
		NCounter.Data = 0;				// init
		
		RCounter.Bit.C = __IFRCounter;
		RCounter.Bit.R = ptr->PR;
		RCounter.Bit.POL = __POS;
		RCounter.Bit.ICPO = __ICPOLOW;
		RCounter.Bit.TRI = __NOR;
		RCounter.Bit.LD = __LDNO;

		NCounter.Bit.C = __IFNCounter;
		NCounter.Bit.A = fvco%__IFPRE;
		NCounter.Bit.B = fvco/__IFPRE;
		NCounter.Bit.PR = __n233x_IF_PR16;
		NCounter.Bit.PWEN = __PWDN;

		#ifdef Pll233x_debug
		{
			SerPtr->printf("IF R Counter: %03x \n", RCounter.Grp.tot & 0xffffff);
			SerPtr->printf("IF N Counter: %03x \n", NCounter.Grp.tot & 0xffffff);
			OSTimeDly(100);
		}
		#endif
		//OS_ENTER_CRITICAL();
		
		ptr->RstPllEn();

		for(i = 0; i < 22; i++)			// R Counter Program modes	(5bit)
		{	
			if(RCounter.Grp.tot & tMsb)	ptr->SetPllData();
			else						ptr->RstPllData();

			RCounter.Grp.tot <<= 1;
			ptr->SetPllClk();
			ptr->RstPllClk();
		}	

	 	ptr->SetPllEn();
		ptr->RstPllEn();

		for(i = 0; i < 22; i++) 		// R Counter Program modes	(5bit)
		{	
			if(NCounter.Grp.tot & tMsb)	ptr->SetPllData();
			else					 	ptr->RstPllData();

			NCounter.Grp.tot <<= 1; 
			ptr->SetPllClk();
			ptr->RstPllClk();
		}		
	 	ptr->SetPllEn();
		ptr->RstPllEn();
		
		//OS_EXIT_CRITICAL();
	}
	////////////////////////////////////////////////////////////	
}

void Pll2332_RFOutput(INT32U fvco, _pPll2332Str ptr)
{
	INT32U tMsb = (1 << 21);
	INT32U i = 0;
	//INT32U cpu_sr;

	if(ptr->RFfvco == fvco) return;

	fvco = fvco/ptr->dRatio;
	{
		_RCounterReg RCounter;
		_NCounterReg NCounter;

		RCounter.Data = 0;				// init
		NCounter.Data = 0;				// init
		
		RCounter.Bit.C = __RFRCounter;
		RCounter.Bit.R = ptr->PR;
		RCounter.Bit.POL = __POS;
		RCounter.Bit.ICPO = __ICPOHIG;
		RCounter.Bit.TRI = __NOR;
		RCounter.Bit.LD = __LDNO;

		NCounter.Bit.C = __RFNCounter;
		NCounter.Bit.A = fvco%__RFPRE;
		NCounter.Bit.B = fvco/__RFPRE;
		NCounter.Bit.PR = __n2332_RF_PR_64;
		NCounter.Bit.PWEN = __PWUP;

		#ifdef Pll233x_debug
		{
			SerPtr->printf("RF R Counter: %03x \n", RCounter.Grp.tot & 0xffffff);
			SerPtr->printf("RF N Counter: %03x \n", NCounter.Grp.tot & 0xffffff);
			OSTimeDly(100);
		}
		#endif
		//OS_ENTER_CRITICAL();
		
		ptr->RstPllEn();
		
		for(i = 0; i < 22; i++)			// R Counter Program modes	(5bit)
		{	
			if(RCounter.Grp.tot & tMsb)	ptr->SetPllData();
			else						ptr->RstPllData();

			RCounter.Grp.tot <<= 1;
			
			ptr->SetPllClk();
			ptr->RstPllClk();
		}	
		ptr->SetPllEn();
		ptr->RstPllEn();

		for(i = 0; i < 22; i++) 		//N Counter Program modes	(5bit)
		{	
			if(NCounter.Grp.tot & tMsb)	ptr->SetPllData();
			else					 	ptr->RstPllData();

			NCounter.Grp.tot <<= 1; 

			ptr->SetPllClk();
			ptr->RstPllClk();
		}		
		ptr->SetPllEn();
		ptr->RstPllEn();
		
		//OS_EXIT_CRITICAL();
	}
	////////////////////////////////////////////////////////////	
}

void SetPllClk(void)
{
	_ATTN_CLK = 1;

#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllClk(void)
{
	_ATTN_CLK = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void SetPllData(void)
{
	_ATTN_DATA = 1;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllData(void)
{
	_ATTN_DATA = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void SetPllEnA(void)	// PLL IN1
{
	//_2G_PLL_LE = 1;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllEnA(void)	// PLL IN1
{
	//_2G_PLL_LE = 0;
#if PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void SetPllEnB(void)	// PLL IN2
{
	//_3G_PLL_LE = 1;
#ifdef PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

void RstPllEnB(void)	// PLL IN2
{
	//_3G_PLL_LE = 0;
#ifdef PLL_DEFINE	
	ForDelay(PLL_DELAY);
#endif
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

