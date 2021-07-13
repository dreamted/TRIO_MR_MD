/******************************************************************************* 
 *
 * This module contains the function I2C device related, a function
 * that is called before the PHILLIPS PCA95555' function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- All rights reserved.
 *
 * $Revision: 0.01 $
 * $Revision date: 2006.08.24
 * $Revision: 0.02 $
 * $Revision date: 2007.04.24
 *                 error correction: INT16U Read_pPCA9555_8Addr_16Data(INT8U DevAddr, INT16U Addr)
 *                                   <-- Port 0 Read Error
 *                 append: INT8U pPCA9555BitRead(INT32U Bitaddr, _PCA9555Reg *pVal);
 *                 append: INT8U pPCA9555ReadData(INT32U pSel, _PCA9555Reg *pVal);
 ******************************************************************************/
 
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Definition(Pre Declration)
#define pPCAWrTry	3

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

#define PCA9555Addr		(0x04 << 4)


////////////////////////////////////////////////////////////////////////////////
// REGISTERS
////////////
enum {
	_InputPort0,
	_InputPort1,
	_OutputPort0,
	_OutputPort1,
	_PolarityPort0,
	_PolarityPort1,
	_ConfigPort0,
	_ConfigPort1,
	_PCA9555MaxRegNo
};

////////////////////////////////////////////////////////////////////////////////
// PCA9555	Register definition
////////////////////////////////////
typedef union {
	INT8U Data;

	struct {
		INT8U D0		:1;
		INT8U D1		:1;
		INT8U D2		:1;
		INT8U D3		:1;
		INT8U D4		:1;
		INT8U D5		:1;
		INT8U D6		:1;
		INT8U D7		:1;
	} Bit;

} _PCA8BitReg;

typedef union {
	INT16U	Data;

	_PCA8BitReg pData[2];

	struct {
		INT16U	D10		:1;
		INT16U	D11		:1;
		INT16U	D12		:1;
		INT16U	D13		:1;
		INT16U	D14		:1;
		INT16U	D15		:1;
		INT16U	D16		:1;
		INT16U	D17		:1;

		INT16U	D00		:1;
		INT16U	D01		:1;
		INT16U	D02		:1;
		INT16U	D03		:1;
		INT16U	D04		:1;
		INT16U	D05		:1;
		INT16U	D06		:1;
		INT16U	D07		:1;
	} Bit;
} _PCA9555Reg;

typedef struct 
{ 
	INT8U address; // slave address to sent/receive message 
	INT8U nrBytes; // number of bytes in message buffer 
	INT8U *buf; // pointer to application message buffer 
} I2C_MESSAGE; 

typedef struct 
{ 						// made up of a number of messages and pointers to the messages 
	INT8U nrMessages; 	// number of message in one transfer 
	I2C_MESSAGE **p_message; // pointer to pointer to message 
} I2C_TRANSFER; 


#define PCA9555_WR 0x46
#define PCA9555_RD 0x47

/**** Status Errors ****/ 


#define I2C_OK 					0 // transfer ended No Errors 
#define I2C_BUSY 				1 // transfer busy 
#define I2C_ERROR 				2 // err: general error 
#define I2C_NO_DATA 			3 // err: No data in block 
#define I2C_NACK_ON_DATA 		4 // err: No ack on data 
#define I2C_NACK_ON_ADDRESS 	5 // err: No ack on address 
#define I2C_DEVICE_NOT_PRESENT 	6 // err: Device not present 
#define I2C_ARBITRATION_LOST 	7 // err: Arbitration lost 
#define I2C_TIME_OUT 			8 // err: Time out occurred 
#define I2C_SLAVE_ERROR 		9 // err: Slave mode error 
#define I2C_INIT_ERROR 			10 // err: Initialization (not done) 
#define I2C_RETRIES 			11 // err: Initialization (not done) 


typedef struct {
	
	INT32U addr;
	INT32U DevAddr;
	
	void (*SetClk)(void);
	void (*RstClk)(void);
	void (*SetData)(void);
	void (*RstData)(void);
} _PCA9555Str, *_pPCA9555Str;



#ifdef PCA9555_C

	_PCA9555Str pPCA9555StrB;
	_pPCA9555Str pPCA9555Str = &pPCA9555StrB;


	_PCA9555Reg 	pLEDCSVal0B, *pLEDCSVal0 = &pLEDCSVal0B;
	_PCA9555Reg 	pLEDCSVal1B, *pLEDCSVal1 = &pLEDCSVal1B;


	_PCA9555Reg 	pAttnVal0B, *pAttnVal0 = &pAttnVal0B;
	_PCA9555Reg 	pAttnVal1B, *pAttnVal1 = &pAttnVal1B;
	_PCA9555Reg 	pAttnVal2B, *pAttnVal2 = &pAttnVal2B;


#else
	extern _pPCA9555Str pPCA9555Str;

	extern _PCA9555Reg	*pLEDCSVal0;
	extern _PCA9555Reg	*pLEDCSVal1;

	
	extern _PCA9555Reg	*pAttnVal0;
	extern _PCA9555Reg	*pAttnVal1;
	extern _PCA9555Reg	*pAttnVal2;

#endif


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
#define _PCA9555Init()		{				PCA9555_Init(pPCA9555Str, SetpPCA9555SCL, RstpPCA9555SCL, SetpPCA9555SDA ,RstpPCA9555SDA); \
							}


#define PCASetConfiguration(DevAddr,Reg)	pPCASetConfiguration(DevAddr,Reg, pPCA9555Str,0)
#define PCASetPortData(DevAddr,Data)		pPCASetPortData(DevAddr,Data, pPCA9555Str,INT8U Path)
#define PCA9555SetData(pSel,Data,pVal)		pPCA9555SetData(pSel,Data,pVal,pPCA9555Str)

#define PCA9555BitSet(Bitaddr,pVal)			pPCA9555BitSet(Bitaddr,pVal,pPCA9555Str,0)
#define PCA9555BitRst(Bitaddr,pVal)			pPCA9555BitRst(Bitaddr,pVal,pPCA9555Str,0)


void PCA9555_Init(_pPCA9555Str ptr, 
						void (*SetClk)(), void (*RstClk)(), 
							void (*SetData)(), void (*RstData)());

void pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path);
void pPCA9555BitRst(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path);
void pPCA9555SetData(INT32U pSel, INT8U Data, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path);
INT8U pPCA9555BitRead(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path);
INT8U pPCA9555ReadData(INT32U pSel, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path);

void pPCASetConfiguration(INT8U DevAddr, _PCA9555Reg Reg, _pPCA9555Str ptr,INT8U Path);
void pPCASetPortData(INT8U DevAddr, INT16U Data,_pPCA9555Str ptr,INT8U Path);
INT16U pPCAReadPortData(INT16U DevAddr,_pPCA9555Str ptr,INT8U Path);

INT16U Write_pPCA9555_8Addr_16Data(INT8U DevAddr, INT8U Command, INT16U Data, _pPCA9555Str ptr,INT8U Path);
INT16U Read_pPCA9555_8Addr_16Data(INT8U DevAddr, INT16U Command, _pPCA9555Str ptr,INT8U Path);


void WritepPCA9555Data(INT8U Data, _pPCA9555Str ptr,INT8U Path);
INT8U ReadpPCA9555Data(_pPCA9555Str ptr,INT8U Path);

void StartpPCA9555(_pPCA9555Str ptr,INT8U Path);
void StoppPCA9555(_pPCA9555Str ptr,INT8U Path);
INT8U ACKpPCA9555(_pPCA9555Str ptr,INT8U Path);
void NACKpPCA9555(_pPCA9555Str ptr,INT8U Path);

void SetpPCA9555SDAInMode(INT8U Path);
void SetpPCA9555SDAOutMode(INT8U Path);

void SetpPCA9555SDA(void);
void RstpPCA9555SDA(void);
void SetpPCA9555SCL(void);
void RstpPCA9555SCL(void);
INT8U ReadpPCA9555SDA(INT8U Path);

void _pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr,INT8U Path);
//void _pPCA9555BitRst(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr);


////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

