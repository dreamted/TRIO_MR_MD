#define PCA9555_C

#include "../../include/main.h"


//#define pPCA9555_debug
#define CLKDELAY	ForDelay(5)


void PCA9555_Init(_pPCA9555Str ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)())
{
	// Port Initialization
#if 1
	__PA8_PP_PP();			//_PCA9555_CLK;		PG12
	__PC9_IN_FL();			//_PCA9555_DATA;	PG15
#endif


#if 0
	__PG12_PP_PP();			//_PCA9555_CLK;		PG12
	__PG15_IN_FL();			//_PCA9555_DATA;	PG15
#endif


    ptr->SetClk = SetClk;
    ptr->RstClk = RstClk;
    ptr->SetData = SetData;
    ptr->RstData = RstData;
	
	RstpPCA9555SCL();
}
 
void pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitSet(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData(dAddr, pVal->Data,ptr,Path);
}

void pPCA9555BitRst(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitRst(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData(dAddr, pVal->Data,ptr,Path);
}

void _pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitSet(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData(dAddr, pVal->Data,ptr,Path);
}


void pPCA9555SetData(INT32U pSel, INT8U Data, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path)
{
	INT16U	dAddr = pSel%8;

	pSel = (pSel/8)/8;
	pVal->pData[pSel].Data = Data;	
	pPCASetPortData(dAddr, pVal->Data,ptr,Path);
}

INT8U pPCA9555BitRead(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	pVal->Data = pPCAReadPortData(dAddr,ptr,Path);
	return (BitRead(pVal->pData[pSel].Data, BitNumber));
}

INT8U pPCA9555ReadData(INT32U pSel, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path)
{
	INT16U	dAddr = pSel%8;

	pSel = (pSel/8)/8;
	pVal->Data = pPCAReadPortData(dAddr,ptr,Path);
	return pVal->pData[pSel].Data;
}


////////////////////////////////////////////////////////////////////////////////////////
void pPCASetConfiguration(INT8U DevAddr, _PCA9555Reg Reg, _pPCA9555Str ptr,INT8U Path)
{
	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _ConfigPort0, Reg.Data, ptr,Path);
}

void pPCASetPortData(INT8U DevAddr, INT16U Data,_pPCA9555Str ptr,INT8U Path)
{
	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _OutputPort0, Data, ptr,Path);
}

INT16U pPCAReadPortData(INT16U DevAddr,_pPCA9555Str ptr,INT8U Path)
{
	return Read_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _InputPort0, ptr,Path);
}


INT16U Write_pPCA9555_8Addr_16Data(INT8U DevAddr, INT8U Command, INT16U Data, _pPCA9555Str ptr,INT8U Path)
{
	INT8U cnt = pPCAWrTry;
	// Start Condition
	// Write Protection Disable, Allows normal write operation
	// 
	// output 1(SDATA)
	// START Conditon making

	while(cnt--)
	{

//////////Start
		StartpPCA9555(ptr,Path);
		
		WritepPCA9555Data(DevAddr & (~0x01),ptr,Path);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr,Path)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepPCA9555Data((INT8U)(Command     ),ptr,Path);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr,Path)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepPCA9555Data((INT8U)(Data >> 8),ptr,Path);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr,Path)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif

		WritepPCA9555Data((INT8U)(Data >> 0),ptr,Path);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr,Path)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif

		//////////Stop

		StoppPCA9555(ptr,Path);
//		SerPtr->printf("1: Write_pPCA9555_8Addr_16Data \n");

		return TRUE;
	}
	return FALSE;
}


INT16U Read_pPCA9555_8Addr_16Data(INT8U DevAddr, INT16U Command, _pPCA9555Str ptr,INT8U Path)
{
	INT16U rVal = 0;
	
	// Device Address Writing
	StartpPCA9555(ptr,Path);
	WritepPCA9555Data(DevAddr & (~0x01),ptr,Path);
	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr,Path);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif

	WritepPCA9555Data((INT8U)(Command),ptr,Path);
	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr,Path);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif
	
	StartpPCA9555(ptr,Path);
	WritepPCA9555Data(DevAddr | 0x01,ptr,Path);
	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr,Path);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif	
	rVal = (rVal << 8) | ReadpPCA9555Data(ptr,Path);
	rVal = (rVal << 8) | ReadpPCA9555Data(ptr,Path);

	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr,Path);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif	

	NACKpPCA9555(ptr,Path);
 	StoppPCA9555(ptr,Path);

	return rVal;
}

void WritepPCA9555Data(INT8U Data, _pPCA9555Str ptr,INT8U Path)
{
	INT8U i = 0;

 	SetpPCA9555SDAOutMode(Path);
	ForDelay(100L);			///20120407 Adder

	ptr->RstClk();
	
	for(i = 0; i < 8; i++)
	{
		if((Data & 0x80)) 	ptr->SetData();
		else				ptr->RstData();

		ptr->SetClk();
		ptr->RstClk();
		Data <<= 1;
	}
}

INT8U ReadpPCA9555Data(_pPCA9555Str ptr,INT8U Path)
{
	INT8U Data = 0, i = 0;

	SetpPCA9555SDAInMode(Path);
	ForDelay(100L);			///20120407 Adder

	for(i = 0; i < 8; i++)
	{
        Data = (Data << 1);
		ptr->SetClk();

        if(ReadpPCA9555SDA(Path))	Data |= 0x01;

		ptr->RstClk();
	}	
	return Data;
}

void StartpPCA9555(_pPCA9555Str ptr,INT8U Path)
{
	// START Conditon making
 	SetpPCA9555SDAOutMode(Path);

	ptr->SetData();
	ptr->SetClk();
	ptr->RstData();
	ptr->RstClk();

}

void StoppPCA9555(_pPCA9555Str ptr,INT8U Path)
{
	// STOP
 	SetpPCA9555SDAOutMode(Path);
	
	ptr->RstData();
	ptr->SetClk();
	ptr->SetData();
}

INT8U ACKpPCA9555(_pPCA9555Str ptr,INT8U Path)
{
	INT8U Data;

 	SetpPCA9555SDAInMode(Path);
	// ACK Check
	ptr->SetClk();
	Data = ReadpPCA9555SDA(Path);
	ptr->RstClk();
	return Data;
}

void NACKpPCA9555(_pPCA9555Str ptr,INT8U Path)
{
	// NACK
 	SetpPCA9555SDAOutMode(Path);
	
	ptr->SetData();
	ptr->SetClk();
	ptr->RstClk();	
}

////////////////////////////////////////////////////////////////////////////////
// Default Read/Write, Access F31xx Series
//////////////////////////////////////////
void SetpPCA9555SDAInMode(INT8U Path)
{
//	__PC9_IU_PD();
//	__PC9_IN_PD();
//	 SerPtr->printf("SetpPCA9555SDAInMode: %d \n", Path);

	     if(Path == 0)	__PC9_IN_PU();
	else if(Path == 1)	__PG15_IN_PU();

#if 0
	__PC9_IN_PU();
#endif
#if 1
//	__PG15_IN_PU();
#endif

}

void SetpPCA9555SDAOutMode(INT8U Path)
{
#if 0
	__PC9_PP_PP();
#endif
#if 1
//	__PG15_PP_PP();
#endif
//		 SerPtr->printf("SetpPCA9555SDAOutMode: %d \n", Path);

		 if(Path == 0)	__PC9_PP_PP();
	else if(Path == 1)	__PG15_PP_PP();
}

void SetpPCA9555SDA(void)
{
	_PCA9555_DATA = 1;
	_I2C_DATA = 1;
#if 0
	GPIOC->__B.ODR.B9 = SET;
#endif
#if 0
	GPIOG->__B.ODR.B15 = SET;
#endif
	CLKDELAY;
}

void RstpPCA9555SDA(void)
{
	_PCA9555_DATA = 0;
	_I2C_DATA = 0;
#if 0
	GPIOC->__B.ODR.B9 = RESET;
#endif
#if 0
	GPIOG->__B.ODR.B15 = RESET;
#endif

	CLKDELAY;
}


void SetpPCA9555SCL(void)
{
	_PCA9555_CLK = 1;
	_I2C_CLK = 1;
#if 0
	GPIOA->__B.ODR.B8 = SET;
#endif
#if 0
	GPIOG->__B.ODR.B12 = SET;
#endif


	CLKDELAY;
}

void RstpPCA9555SCL(void)
{
	_PCA9555_CLK = 0;
	_I2C_CLK = 0;
#if 0 
	GPIOA->__B.ODR.B8 = RESET;
#endif
#if 0
		GPIOG->__B.ODR.B12 = RESET;
#endif

	CLKDELAY;
}

INT8U ReadpPCA9555SDA(INT8U Path)
{
	INT8U	RetVal;

	CLKDELAY;
#if 0	
	RetVal = GPIOA->__B.IDR.B8;
#endif
#if 0
	RetVal = GPIOG->__B.IDR.B15;
#endif
//	RetVal = _PCA9555_DATA_Read;
		 if(Path == 0)	RetVal = _I2C_DATA_Read;
	else if(Path == 1)	RetVal = _PCA9555_DATA_Read;
	return	RetVal;
}


////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

