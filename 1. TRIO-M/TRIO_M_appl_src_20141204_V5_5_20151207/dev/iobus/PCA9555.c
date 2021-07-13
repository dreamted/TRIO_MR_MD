#define PCA9555_C

#include "../../include/main.h"


//#define pPCA9555_debug
#define CLKDELAY	ForDelay(5)


void PCA9555_Init(_pPCA9555Str ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)())
{
	// Port Initialization
	GPIOB->CNF.B6= __PB6_OU_PP; 	//__I2C1_SCL;	
	GPIOB->CNF.B7 = __PB7_IN_FL; 	//__I2C1_SDA;

//	GPIOB->CNF.B7 = __PB7_OU_PP; 	//__I2C1_SDA;

    ptr->SetClk = SetClk;
    ptr->RstClk = RstClk;
    ptr->SetData = SetData;
    ptr->RstData = RstData;
	
	RstpPCA9555SCL();
}
 
void pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitSet(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData(dAddr, pVal->Data,ptr);
}

void pPCA9555BitRst(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitRst(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData(dAddr, pVal->Data,ptr);
}

void _pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitSet(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData(dAddr, pVal->Data,ptr);
}


void pPCA9555SetData(INT32U pSel, INT8U Data, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = pSel%8;

	pSel = (pSel/8)/8;
	pVal->pData[pSel].Data = Data;	
	pPCASetPortData(dAddr, pVal->Data,ptr);
}

INT8U pPCA9555BitRead(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	pVal->Data = pPCAReadPortData(dAddr,ptr);
	return (BitRead(pVal->pData[pSel].Data, BitNumber));
}

INT8U pPCA9555ReadData(INT32U pSel, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = pSel%8;

	pSel = (pSel/8)/8;
	pVal->Data = pPCAReadPortData(dAddr,ptr);
	return pVal->pData[pSel].Data;
}


void pPCA9555BitSet1(INT32U Bitaddr, INT8U Command, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitSet(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData1(dAddr,Command, pVal->Data,ptr);
}

void pPCA9555BitRst1(INT32U Bitaddr, INT8U Command, _PCA9555Reg *pVal, _pPCA9555Str ptr)
{
	INT16U	dAddr = Bitaddr%8;
	INT16U	pSel = (Bitaddr/8)/8;
	INT16U	BitNumber = (Bitaddr/8)%8;

	BitRst(pVal->pData[pSel].Data, BitNumber);
	pPCASetPortData1(dAddr,Command, pVal->Data,ptr);
}



////////////////////////////////////////////////////////////////////////////////////////
void pPCASetConfiguration(INT8U DevAddr, _PCA9555Reg Reg, _pPCA9555Str ptr)
{
	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _ConfigPort0, Reg.Data, ptr);
}

void pPCASetConfiguration1(INT8U DevAddr, INT8U Command, _PCA9555Reg Reg, _pPCA9555Str ptr)
{
	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), Command, Reg.Data, ptr);
}

void pPCASetPortData1(INT8U DevAddr, INT8U Command, INT16U Data,_pPCA9555Str ptr)
{
	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), Command, Data, ptr);
}

INT16U pPCAReadPortData1(INT16U DevAddr, INT8U Command,_pPCA9555Str ptr)
{
	return Read_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), Command, ptr);
}


void pPCASetPortData(INT8U DevAddr, INT16U Data,_pPCA9555Str ptr)
{
	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _OutputPort0, Data, ptr);
}

INT16U pPCAReadPortData(INT16U DevAddr,_pPCA9555Str ptr)
{
	return Read_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _InputPort0, ptr);
}


INT16U Write_pPCA9555_8Addr_16Data(INT8U DevAddr, INT8U Command, INT16U Data, _pPCA9555Str ptr)
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
		StartpPCA9555(ptr);
		
		WritepPCA9555Data(DevAddr & (~0x01),ptr);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepPCA9555Data((INT8U)(Command     ),ptr);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif
		WritepPCA9555Data((INT8U)(Data >> 8),ptr);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif

		WritepPCA9555Data((INT8U)(Data >> 0),ptr);
		#ifndef pPCA9555_debug
			if(ACKpPCA9555(ptr)) continue;
		#else
		{
			INT8U _Ack = ACKpPCA9555(ptr);
			SerPtr->printf("ACK: %d \n", _Ack);
		}
		#endif

		//////////Stop

		StoppPCA9555(ptr);
//		SerPtr->printf("1: Write_pPCA9555_8Addr_16Data \n");

		return TRUE;
	}
	return FALSE;
}


INT16U Read_pPCA9555_8Addr_16Data(INT8U DevAddr, INT16U Command, _pPCA9555Str ptr)
{
	INT16U rVal = 0;
	
	// Device Address Writing
	StartpPCA9555(ptr);
	WritepPCA9555Data(DevAddr & (~0x01),ptr);
	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif

	WritepPCA9555Data((INT8U)(Command),ptr);
	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif
	
	StartpPCA9555((ptr));
	WritepPCA9555Data(DevAddr | 0x01,ptr);
	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif	
	rVal = (rVal << 8) | ReadpPCA9555Data(ptr);
	rVal = (rVal << 8) | ReadpPCA9555Data(ptr);

	#ifndef pPCA9555_debug
		ACKpPCA9555(ptr);
	#else
	{
		INT8U _Ack = ACKpPCA9555(ptr);
		SerPtr->printf("ACK: %d \n", _Ack);
	}
	#endif	

	NACKpPCA9555(ptr);
 	StoppPCA9555(ptr);

	return rVal;
}

void WritepPCA9555Data(INT8U Data, _pPCA9555Str ptr)
{
	INT8U i = 0;

 	SetpPCA9555SDAOutMode();
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

INT8U ReadpPCA9555Data(_pPCA9555Str ptr)
{
	INT8U Data = 0, i = 0;

	SetpPCA9555SDAInMode();
	ForDelay(100L);			///20120407 Adder

	for(i = 0; i < 8; i++)
	{
        Data = (Data << 1);
		ptr->SetClk();

        if(ReadpPCA9555SDA())	Data |= 0x01;

		ptr->RstClk();
	}	
	return Data;
}

void StartpPCA9555(_pPCA9555Str ptr)
{
	// START Conditon making
 	SetpPCA9555SDAOutMode();

	ptr->SetData();
	ptr->SetClk();
	ptr->RstData();
	ptr->RstClk();

}

void StoppPCA9555(_pPCA9555Str ptr)
{
	// STOP
 	SetpPCA9555SDAOutMode();
	
	ptr->RstData();
	ptr->SetClk();
	ptr->SetData();
}

INT8U ACKpPCA9555(_pPCA9555Str ptr)
{
	INT8U Data;

 	SetpPCA9555SDAInMode();
	// ACK Check
	ptr->SetClk();
	Data = ReadpPCA9555SDA();
	ptr->RstClk();
	return Data;
}

void NACKpPCA9555(_pPCA9555Str ptr)
{
	// NACK
 	SetpPCA9555SDAOutMode();
	
	ptr->SetData();
	ptr->SetClk();
	ptr->RstClk();	
}

////////////////////////////////////////////////////////////////////////////////
// Default Read/Write, Access F31xx Series
//////////////////////////////////////////

void SetpPCA9555SDAInMode(void)
{
	GPIOB->CNF.B7 = __PB7_IN_PU; 
}

void SetpPCA9555SDAOutMode(void)
{
	GPIOB->CNF.B7 = __PB7_OU_PP; 
}

void SetpPCA9555SDA(void)
{
	_PCA9555_DATA= 1;
	CLKDELAY;
}

void RstpPCA9555SDA(void)
{
	_PCA9555_DATA= 0;
	CLKDELAY;
}


void SetpPCA9555SCL(void)
{
	_PCA9555_CLK = 1;
	CLKDELAY;
}

void RstpPCA9555SCL(void)
{
	_PCA9555_CLK = 0;
	CLKDELAY;
}

INT8U ReadpPCA9555SDA(void)
{
	CLKDELAY;
	return(GPIOB->IDR.B7);
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

