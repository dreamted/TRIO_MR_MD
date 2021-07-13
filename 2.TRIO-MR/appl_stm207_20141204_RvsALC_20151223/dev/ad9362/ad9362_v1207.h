/*!
*********************************************************************************************************
*              	- AD9362 HEADER
*
*              	-(c) Copyright 2007-2012;
*
*              	-All rights reserved.  Protected by international copyright laws.
*              	-Knowledge of the source code may NOT be used to develop a similar product.
*              	-Please help us continue to provide the Embedded community with the finest
*              	-software available.  Your honesty is greatly appreciated.
*
* 				-file 		: iapd.c
* 				-author		: Yoon Byong-Gyu, bgyoon@naver.com
* 				-date		: 2012.05.
*********************************************************************************************************
*/
////////////////////////////////////////////////////////////////////////////////
#ifdef AD9362_C
	#define _USR_EXT_AD9362
#else
	#define _USR_EXT_AD9362	extern
#endif


#define AD9362BPPRefClk		(30720000*2L)//30.72 MHz
#define AD9362RefClk		(30720000L)//30.72 MHz

typedef union{
	INT8U Data;
	struct{
		INT8U SoftRst		:1;		// 0: NORMAL, 	1: RESET
		INT8U SPIType		:1;		// 0: 4-Wire,	1: 3-Wire
		INT8U LSBFirst		:1;		// 0: MSB,		1: LSB
	};
} __SPIConfStr;


#define ADDR_SPICONF			0x000
	// FIR Enable Value!!
	#define FIRx1Bypass				0x00
	#define FIRx1Enable				0x01
	#define FIRx2Enable				0x02
	#define FIRx4Enable				0x03
	// THB3 Enable Value!!
	#define THB3x1Bypass			0x00
	#define THB3x2Enable			0x01
	#define THB3x4Enable			0x02
	
#define ADDR_TXEN				0x002
#define ADDR_RXEN				0x003
#define ADDR_INPUTSEL			0x004
#define ADDR_RFPLLDIVIDER		0x005

	#define XTALN					0x00
	#define REFCLK					0x01
	#define DCXOCLK 				0x02
#define ADDR_CLKEN				0x009

	#define ADCDivd1				0x00
	#define ADCDivd2				0x01
	#define ADCDivd4				0x02
	#define ADCDivd8				0x03
#define ADDR_BPPLL				0x00A
//////////////////////////
// ENABLE STATUS MACHINE
#define ADDR_ENSMCFG1			0x014

//////////////////////////
// BPPLL CONTROL REGISTER
#define ADDR_SDMCTRL1			0x03F
#define ADDR_SDMCTRL2			0x040
#define ADDR_BBMOD1				0x041
#define ADDR_BBMOD2				0x042
#define ADDR_BBMOD3				0x043
#define ADDR_BBINT				0x044
#define ADDR_BBCLKCTRL			0x045
#define ADDR_BBCPCURR			0x046

//////////////////////////
// TRANSMITTER CONFIGURATION
#define ADDR_TXFILTER			0x065

//////////////////////////
// TX POWER CONTROL & ATTEN REGISTER
#define ADDR_TX1ATTN0			0x073
#define ADDR_TX1ATTN1			0x074
#define ADDR_TX2ATTN0			0x075
#define ADDR_TX2ATTN1			0x076

#define ADDR_TX1DIGATTN			0x079
#define ADDR_TX2DIGATTN			0x07C

//////////////////////////
// RECEIVER CONFIGURATION
#define ADDR_RXFILTER			0x0F5
#define ADDR_RXFILTERGAIN		0x0F6


#define ADDR_RX1MANGAIN			0x109
#define ADDR_RX2MANGAIN			0x10C

///////////////////////////
// RX RSSI
#define ADDR_RX1POWER			0x161
#define ADDR_RX2POWER			0x163

//////////////////////////
// RX SYNTHESIZER
#define ADDR_RXINT0				0x231
#define ADDR_RXINT1				0x232
#define ADDR_RXFRAC0			0x233
#define ADDR_RXFRAC1			0x234
#define ADDR_RXFRAC2			0x235

#define ADDR_TXINT0				0x271
#define ADDR_TXINT1				0x272
#define ADDR_TXFRAC0			0x273
#define ADDR_TXFRAC1			0x274
#define ADDR_TXFRAC2			0x275

//////////////////////////
// DCXO SETTING
#define ADDR_DCXOCOAR			0x292
#define ADDR_DCXOFINE2			0x293
#define ADDR_DCXOFINE1			0x294

#define ADDR_REFDIV1			0x2AB
#define ADDR_REFDIV2			0x2AC

#pragma pack(1)

typedef struct {
	INT16U Addr;
	INT8U Data;
} __regStr;

typedef struct {
	INT8U Data[2];
} __FIRregStr;

#pragma pack()

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
#ifdef AD9362_C
////////////////////
	const INT16U AD9362SetAddr[] = {
	//************************************************************
	// AD9362 R2 Auto Generated Initialization Script:	This script was
	// generated using the AD9361 Customer software Version 2.1.1
	//************************************************************
	// Profile: LTE 15 MHz
	// REFCLK_IN: 30.720 MHz
	
	//RESET_FPGA	
	//RESET_DUT	
	//BlockWrite	2,6 // Set ADI FPGA SPI to 20Mhz
	/*SPIWrite	*/0x3DF,
	//ReadPartNumber
	/*SPIWrite	*/0x295,	// Power up XO path (Default)
	/*SPIWrite	*/0x2A6,	// Enable Master Bias
	/*SPIWrite	*/0x2A8,	// Set Bandgap Trim
	//REFCLK_Scale	30.720000,2,2	// Sets local variables in script engine, user can ignore
	/*SPIWrite	*/0x292,	// Set DCXO Coarse Tune[5:0]
	/*SPIWrite	*/0x293,	// Set DCXO Fine Tune [12:5]
	/*SPIWrite	*/0x294,	// Set DCXO Fine Tune [4:0]
	/*SPIWrite	*/0x2AB,	// Set RF PLL reflclk scale to REFCLK * 2
	/*SPIWrite	*/0x2AC,	// Set RF PLL reflclk scale to REFCLK * 2
	/*SPIWrite	*/0x009,	// Enable Clocks						// 10 EA
		
	//WAIT	20	// waits 20 ms
	//************************************************************
	// Set BBPLL Frequency: 737.280000
	//************************************************************
	/*SPIWrite	*/0x045,	// Set BBPLL reflclk scale to REFCLK * 2
	/*SPIWrite	*/0x046,	// Set BBPLL Loop Filter Charge Pump current
	/*SPIWrite	*/0x048,	// Set BBPLL Loop Filter C1, R1
	/*SPIWrite	*/0x049,	// Set BBPLL Loop Filter R2, C2, C1
	/*SPIWrite	*/0x04A,	// Set BBPLL Loop Filter C3,R2
	/*SPIWrite	*/0x04B,	// Allow calibration to occur and set cal count to 1024 for max accuracy
	/*SPIWrite	*/0x04E,	// Set calibration clock to REFCLK/4 for more accuracy
	/*SPIWrite	*/0x043,	// BBPLL Freq Word (Fractional[7:0])
	/*SPIWrite	*/0x042,	// BBPLL Freq Word (Fractional[15:8])
	/*SPIWrite	*/0x041,	// BBPLL Freq Word (Fractional[23:16])
	/*SPIWrite	*/0x044,	// BBPLL Freq Word (Integer[7:0])
	/*SPIWrite	*/0x03F,	// Start BBPLL Calibration
	/*SPIWrite	*/0x03F,	// Clear BBPLL start calibration bit
	/*SPIWrite	*/0x04C,	// Increase BBPLL KV and phase margin
	/*SPIWrite	*/0x04D,	// Increase BBPLL KV and phase margin
	/*SPIWrite	*/0x04D,	// Increase BBPLL KV and phase margin
	
	//WAIT_CALDONE	BBPLL,2000	// Wait for BBPLL to lock, Timeout 2sec, Max BBPLL VCO Cal Time: 225.000 us (Done when 0x05E[7]==1)
	//SPIRead 05E // Check BBPLL locked status  (0x05E[7]==1 is locked)

	/*SPIWrite	*/0x002,	// Setup Tx Digital Filters/ Channels
	/*SPIWrite	*/0x003,	// Setup Rx Digital Filters/ Channels
	/*SPIWrite	*/0x004,	// Select Rx input pin(A,B,C)/ Tx out pin (A,B)
	/*SPIWrite	*/0x00A,	// Set BBPLL post divide rate
	
	//************************************************************
	// Program Tx FIR: C:\Program Files\Analog Devices\AD9361R2
	// Evaluation Software\DigitalFilters\LTE15_MHz.ftr
	//************************************************************
	/*SPIWrite	*/0x065,	// Enable clock to Tx FIR Filter and set Filter gain Setting 
	//WAIT	1	// waits 1 ms
	/*SPIWrite	*/0x060,	// Write FIR coefficient address
	/*SPIWrite	*/0x061,	// Write FIR coefficient data[7:0]
	/*SPIWrite	*/0x062,	// Write FIR coefficient data[15:8]
	/*SPIWrite	*/0x065,	// Set Write EN to push data into FIR filter register map
	/*SPIWrite	*/0x064,	// Write to Read only register to delay ~1us
	/*SPIWrite	*/0x064,	// Write to Read only register to delay ~1us
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x060,
	/*SPIWrite	*/0x061,
	/*SPIWrite	*/0x062,
	/*SPIWrite	*/0x065,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x064,
	/*SPIWrite	*/0x065,	// Disable clock to Tx Filter
	
	//************************************************************
	// Program Rx FIR: C:\Program Files\Analog Devices\AD9361R2
	// Evaluation Software\DigitalFilters\LTE15_MHz.ftr
	//************************************************************
	/*SPIWrite	*/0x0F5,	// Enable clock to Rx FIR Filter 
	/*SPIWrite	*/0x0F6,	// Write Filter Gain setting
	//WAIT	1	// waits 1 ms
	/*SPIWrite	*/0x0F0,	// Write FIR coefficient address
	/*SPIWrite	*/0x0F1,	// Write FIR coefficient data[7:0]
	/*SPIWrite	*/0x0F2,	// Write FIR coefficient data[15:8]
	/*SPIWrite	*/0x0F5,	// Set Write EN to push data into FIR filter register map
	/*SPIWrite	*/0x0F4,	// Dummy Write to Read only register to delay ~1us
	/*SPIWrite	*/0x0F4,	// Dummy Write to Read only register to delay ~1us
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F0,
	/*SPIWrite	*/0x0F1,
	/*SPIWrite	*/0x0F2,
	/*SPIWrite	*/0x0F5,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F4,
	/*SPIWrite	*/0x0F5,	// Disable clock to Rx Filter
	
	//**********************************************************
	// Setup the ParallePort (Digital Data Interface)
	//**********************************************************
	/*SPIWrite	*/0x010,	// PPORT Config 1
	/*SPIWrite	*/0x011,	// PPORT Config 2
	/*SPIWrite	*/0x012,	// PPORT Config 3
	/*SPIWrite	*/0x006,	// PPORT Rx Delay (adjusts Tco Dataclk->Data)
	/*SPIWrite	*/0x007,	// PPORT TX Delay (adjusts setup/hold FBCLK->Data)
	
	//**********************************************************
	// Setup AuxDAC
	//**********************************************************
	/*SPIWrite	*/0x018,	// AuxDAC1 Word[9:2]
	/*SPIWrite	*/0x019,	// AuxDAC2 Word[9:2]
	/*SPIWrite	*/0x01A,	// AuxDAC1 Config and Word[1:0]
	/*SPIWrite	*/0x01B,	// AuxDAC2 Config and Word[1:0]
	/*SPIWrite	*/0x023,	// AuxDAC Manaul/Auto Control
	/*SPIWrite	*/0x026,	// AuxDAC Manual Select Bit/GPO Manual Select
	/*SPIWrite	*/0x030,	// AuxDAC1 Rx Delay
	/*SPIWrite	*/0x031,	// AuxDAC1 Tx Delay
	/*SPIWrite	*/0x032,	// AuxDAC2 Rx Delay
	/*SPIWrite	*/0x033,	// AuxDAC2 Tx Delay
	
	//**********************************************************
	// Setup AuxADC
	//**********************************************************
	/*SPIWrite	*/0x00B,	// Temp Sensor Setup (Offset)
	/*SPIWrite	*/0x00C,	// Temp Sensor Setup (Temp Window)
	/*SPIWrite	*/0x00D,	// Temp Sensor Setup (Periodic Measure)
	/*SPIWrite	*/0x00F,	// Temp Sensor Setup (Decimation)
	/*SPIWrite	*/0x01C,	// AuxADC Setup (Clock Div)
	/*SPIWrite	*/0x01D,	// AuxADC Setup (Decimation/Enable)
	
	//**********************************************************
	// Setup Control Out
	//**********************************************************
	/*SPIWrite	*/0x035,	// Ctrl Out index
	/*SPIWrite	*/0x036,	// Ctrl Out [7:0] output enable
	
	//**********************************************************
	// Setup GPO
	//**********************************************************
	/*SPIWrite	*/0x03A,	// Set number of REFCLK cycles for 1us delay timer
	/*SPIWrite	*/0x020,	// GPO Auto Enable Setup in RX and TX
	/*SPIWrite	*/0x027,	// GPO Manual and GPO auto value in ALERT
	/*SPIWrite	*/0x028,	// GPO_0 RX Delay
	/*SPIWrite	*/0x029,	// GPO_1 RX Delay
	/*SPIWrite	*/0x02A,	// GPO_2 RX Delay
	/*SPIWrite	*/0x02B,	// GPO_3 RX Delay
	/*SPIWrite	*/0x02C,	// GPO_0 TX Delay
	/*SPIWrite	*/0x02D,	// GPO_1 TX Delay
	/*SPIWrite	*/0x02E,	// GPO_2 TX Delay
	/*SPIWrite	*/0x02F,	// GPO_3 TX Delay
	
	/*SPIWrite	*/0x261,	// Set Rx LO Power mode
	/*SPIWrite	*/0x2A1,	// Set Tx LO Power mode
	/*SPIWrite	*/0x248,	// Enable Rx VCO LDO
	/*SPIWrite	*/0x288,	// Enable Tx VCO LDO
	/*SPIWrite	*/0x246,	// Set VCO Power down TCF bits
	/*SPIWrite	*/0x286,	// Set VCO Power down TCF bits
	/*SPIWrite	*/0x249,	// Set VCO cal length
	/*SPIWrite	*/0x289,	// Set VCO cal length
	/*SPIWrite	*/0x23B,	// Enable Rx VCO cal
	/*SPIWrite	*/0x27B,	// Enable Tx VCO cal
	/*SPIWrite	*/0x243,	// Set Rx prescaler bias
	/*SPIWrite	*/0x283,	// Set Tx prescaler bias
	/*SPIWrite	*/0x23D,	// Clear Half VCO cal clock setting
	/*SPIWrite	*/0x27D,	// Clear Half VCO cal clock setting
	
	/*SPIWrite	*/0x015,	// Set Dual Synth mode bit
	/*SPIWrite	*/0x014,	// Set Force ALERT State bit
	/*SPIWrite	*/0x013,	// Set ENSM FDD mode
	//WAIT	1	// waits ms
	/*SPIWrite	*/0x23D,	// Start RX CP cal
	//WAIT_CALDONE	RXCP00	// Wait for CP cal to complete, Max RXCP Cal time: 600.000 (us)(Done when 0x244[7]==1)
	/*SPIWrite	*/0x27D,	// Start TX CP cal
	//WAIT_CALDONE	TXCP00	// Wait for CP cal to complete, Max TXCP Cal time: 600.000 (us)(Done when 0x284[7]==1)
	//**********************************************************
	// FDD RX/TX Synth Fquency: 800.000000,850.000000 MHz
	//**********************************************************
	//**********************************************************
	// Setup Synthesizer
	//**********************************************************
	/*SPIWrite	*/0x23A,	// Set VCO Output level[3:0]
	/*SPIWrite	*/0x239,	// Set Init ALC Value[3:0] and VCO Varactor[3:0]
	/*SPIWrite	*/0x242,	// Set VCO Bias Tcf[1:0] and VCO Bias Ref[2:0]
	/*SPIWrite	*/0x238,	// Set VCO Cal Offset[3:0]
	/*SPIWrite	*/0x245,	// Set VCO Cal Ref Tcf[2:0]
	/*SPIWrite	*/0x251,	// Set VCO Varactor Reference[3:0]
	/*SPIWrite	*/0x250,	// Set VCO Varactor Ref Tcf[2:0] and VCO Varactor Offset[3:0]
	/*SPIWrite	*/0x23B,	// Set Synth Loop Filter charge pump current (Icp)
	/*SPIWrite	*/0x23E,	// Set Synth Loop Filter C2 and C1
	/*SPIWrite	*/0x23F,	// Set Synth Loop Filter  R1 and C3
	/*SPIWrite	*/0x240,	// Set Synth Loop Filter R3
	
	//**********************************************************
	// Setup Synthesizer
	//**********************************************************
	/*SPIWrite	*/0x27A,	// Set VCO Output level[3:0]
	/*SPIWrite	*/0x279,	// Set Init ALC Value[3:0] and VCO Varactor[3:0]
	/*SPIWrite	*/0x282,	// Set VCO Bias Tcf[1:0] and VCO Bias Ref[2:0]
	/*SPIWrite	*/0x278,	// Set VCO Cal Offset[3:0]
	/*SPIWrite	*/0x285,	// Set VCO Cal Ref Tcf[2:0]
	/*SPIWrite	*/0x291,	// Set VCO Varactor Reference[3:0]
	/*SPIWrite	*/0x290,	// Set VCO Varactor Ref Tcf[2:0] and VCO Varactor Offset[3:0]
	/*SPIWrite	*/0x27B,	// Set Synth Loop Filter charge pump current (Icp)
	/*SPIWrite	*/0x27E,	// Set Synth Loop Filter C2 and C1
	/*SPIWrite	*/0x27F,	// Set Synth Loop Filter  R1 and C3
	/*SPIWrite	*/0x280,	// Set Synth Loop Filter R3
	
	/*SPIWrite	*/0x233,	// Write Rx Synth Fractional Freq Word[7:0]
	/*SPIWrite	*/0x234,	// Write Rx Synth Fractional Freq Word[15:8]
	/*SPIWrite	*/0x235,	// Write Rx Synth Fractional Freq Word[22:16]
	/*SPIWrite	*/0x232,	// Write Rx Synth Integer Freq Word[10:8]
	/*SPIWrite	*/0x231,	// Write Rx Synth Integer Freq Word[7:0]
	/*SPIWrite	*/0x005,	// Set LO divider setting
	/*SPIWrite	*/0x273,	// Write Tx Synth Fractional Freq Word[7:0]
	/*SPIWrite	*/0x274,	// Write Tx Synth Fractional Freq Word[15:8]
	/*SPIWrite	*/0x275,	// Write Tx Synth Fractional Freq Word[22:16]
	/*SPIWrite	*/0x272,	// Write Tx Synth Integer Freq Word[10:8]
	/*SPIWrite	*/0x271,	// Write Tx Synth Integer Freq Word[7:0] (starts VCO cal)
	/*SPIWrite	*/0x005,	// Set LO divider setting
	//SPIRead 247 // CheckX RF PLL lock status (0x247[1]==1 is locked)
	//SPIRead 287 // CheckX RF PLL lock status (0x287[1]==1 is locked)
	//**********************************************************
	// Program Mixer GM b-table
	//**********************************************************
	/*SPIWrite	*/0x13F,	// Start Clock
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x138,	// Addr Table Index
	/*SPIWrite	*/0x139,	// Gain
	/*SPIWrite	*/0x13A,	// Bias
	/*SPIWrite	*/0x13B,	// GM
	/*SPIWrite	*/0x13F,	// Write Words
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x13F,	// Clear Write Bit
	/*SPIWrite	*/0x13C,	// Delay for 3 ADCCLK/16 clock cycles (Dummy Write)
	/*SPIWrite	*/0x13C,	// Delay ~1us (Dummy Write)
	/*SPIWrite	*/0x13F,	// Stop Clock
	
	//**********************************************************
	// Program Rx Gain Tles with GainTable800MHz.csv
	//**********************************************************
	/*SPIWrite	*/0x137,	// Start Gain Table Clock
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x130,	// Gain Table Index
	/*SPIWrite	*/0x131,	// Ext LNA, Int LNA, & Mixer Gain Word
	/*SPIWrite	*/0x132,	// TIA & LPF Word
	/*SPIWrite	*/0x133,	// DC Cal bit & Dig Gain Word
	/*SPIWrite	*/0x137,	// Write Words
	/*SPIWrite	*/0x134,	// Dummy Write to delay 3 ADCCLK/16 cycles
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x137,	// Clear Write Bit
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x134,	// Dummy Write to delay ~1us
	/*SPIWrite	*/0x137,	// Stop Gain Table Clock
	//************************************************************
	// Setup Rx Manual Gain Registers
	//************************************************************
	/*SPIWrite	*/0x0FA,	// Gain Control Mode Select
	/*SPIWrite	*/0x0FB,	// Table, Digital Gain, Man Gain Ctrl
	/*SPIWrite	*/0x0FC,	// Incr Step Size, ADC Overrange Size
	/*SPIWrite	*/0x0FD,	// Max Full/LMT Gain Table Index
	/*SPIWrite	*/0x0FE,	// Decr Step Size, Peak Overload Time
	/*SPIWrite	*/0x100,	// Max Digital Gain
	/*SPIWrite	*/0x104,	// ADC Small Overload Threshold
	/*SPIWrite	*/0x105,	// ADC Large Overload Threshold
	/*SPIWrite	*/0x107,	// Large LMT Overload Threshold
	/*SPIWrite	*/0x108,	// Small LMT Overload Threshold
	/*SPIWrite	*/0x109,	// Rx1 Full/LMT Gain Index
	/*SPIWrite	*/0x10A,	// Rx1 LPF Gain Index
	/*SPIWrite	*/0x10B,	// Rx1 Digital Gain Index
	/*SPIWrite	*/0x10C,	// Rx2 Full/LMT Gain Index
	/*SPIWrite	*/0x10D,	// Rx2 LPF Gain Index
	/*SPIWrite	*/0x10E,	// Rx2 Digital Gain Index
	/*SPIWrite	*/0x114,	// Low Power Threshold
	/*SPIWrite	*/0x11A,	// Initial LMT Gain Limit
	/*SPIWrite	*/0x081,	// Tx Symbol Gain Control
	//************************************************************
	// RX Baseband Filter Tuning (Real BW: 7.000000 MHz) 3dB Filter
	// Corner @ 9.800000 MHz)
	//************************************************************
	/*SPIWrite	*/0x1FB,	// RX Freq Corner (MHz)
	/*SPIWrite	*/0x1FC,	// RX Freq Corner (Khz)
	/*SPIWrite	*/0x1F8,	// Rx BBF Tune Divider[7:0]
	/*SPIWrite	*/0x1F9,	// RX BBF Tune Divider[8]
	
	/*SPIWrite	*/0x1D5,	// Set Rx Mix LO CM
	/*SPIWrite	*/0x1C0,	// Set GM common mode
	/*SPIWrite	*/0x1E2,	// Enable Rx1 Filter Tuner 
	/*SPIWrite	*/0x1E3,	// Enable Rx2 Filter Tuner 
	/*SPIWrite	*/0x016,	// Start RX Filter Tune
	//WAIT_CALDONE	RXFILTER,2000	// Wait for RX filter to tune, Max Cal Time: 7.446 us (Done when 0x016[7]==0)
	/*SPIWrite	*/0x1E2,	// Disable Rx Filter Tuner (Rx1)
	/*SPIWrite	*/0x1E3,	// Disable Rx Filter Tuner (Rx2)
	//************************************************************
	// TX Baseband Filter Tuning (Real BW: 7.000000 MHz) 3dB Filter
	// Corner @ 11.200000 MHz)
	//************************************************************
	/*SPIWrite	*/0x0D6,	// TX BBF Tune Divier[7:0]
	/*SPIWrite	*/0x0D7,	// TX BBF Tune Divider[8]
	
	/*SPIWrite	*/0x0CA,	// Enable Tx Filter Tuner
	/*SPIWrite	*/0x016,	// Start Tx Filter Tune
	//WAIT_CALDONE	TXFILTER,2000	// Wait for TX filter to tune, Max Cal Time: 3.852 us (Done when 0x016[6]==0)
	/*SPIWrite	*/0x0CA,	// Disable Tx Filter Tuner (Both Channels)
	//************************************************************
	// RX TIA Setup:  Setup values scale based on RxBBF calibration
	// results.  See information in Calibration Guide. 
	//************************************************************
	//SPIRead 1EB // Read RXBBF C3(MSB)
	//SPIRead 1EC // Read RXBBF C3(LSB)
	//SPIRead 1E6 // Read RXBBF R2346
	/*SPIWrite	*/0x1DB,	// Set TIA selcc[2:0]
	/*SPIWrite	*/0x1DD,	// Set RX TIA1 C MSB[6:0]
	/*SPIWrite	*/0x1DF,	// Set RX TIA2 C MSB[6:0]
	/*SPIWrite	*/0x1DC,	// Set RX TIA1 C LSB[5:0]
	/*SPIWrite	*/0x1DE,	// Set RX TIA2 C LSB[5:0]
	
	//************************************************************
	// TX Secondary Filter Calibration Setup:  Real Bandwidth
	// 7.000000MHz, 3dB Corner @ 35.000000MHz
	//************************************************************
	/*SPIWrite	*/0x0D2,	// TX Secondary Filter PDF Cap cal[5:0]
	/*SPIWrite	*/0x0D1,	// TX Secondary Filter PDF Res cal[3:0]
	/*SPIWrite	*/0x0D0,	// Pdampbias 
	
	//************************************************************
	// ADC Setup:  Tune ADC Performance based on RX analog filter tune
	// corner.	Real Bandwidth: 6.455167 MHz, ADC Clock Frequency:
	// 368.640000 MHz.	The values in registers 0x200 - 0x227 need to be
	// calculated using the equations in the Calibration Guide.
	//************************************************************
	//SPIRead 1EB // Read RxBBF C3 MSB after calibration
	//SPIRead 1EC // Read RxBBF C3 LSB after calibration
	//SPIRead 1E6 // Read RxBBF R3 after calibration
	
	/*SPIWrite	*/0x200,
	/*SPIWrite	*/0x201,
	/*SPIWrite	*/0x202,
	/*SPIWrite	*/0x203,
	/*SPIWrite	*/0x204,
	/*SPIWrite	*/0x205,
	/*SPIWrite	*/0x206,
	/*SPIWrite	*/0x207,
	/*SPIWrite	*/0x208,
	/*SPIWrite	*/0x209,
	/*SPIWrite	*/0x20A,
	/*SPIWrite	*/0x20B,
	/*SPIWrite	*/0x20C,
	/*SPIWrite	*/0x20D,
	/*SPIWrite	*/0x20E,
	/*SPIWrite	*/0x20F,
	/*SPIWrite	*/0x210,
	/*SPIWrite	*/0x211,
	/*SPIWrite	*/0x212,
	/*SPIWrite	*/0x213,
	/*SPIWrite	*/0x214,
	/*SPIWrite	*/0x215,
	/*SPIWrite	*/0x216,
	/*SPIWrite	*/0x217,
	/*SPIWrite	*/0x218,
	/*SPIWrite	*/0x219,
	/*SPIWrite	*/0x21A,
	/*SPIWrite	*/0x21B,
	/*SPIWrite	*/0x21C,
	/*SPIWrite	*/0x21D,
	/*SPIWrite	*/0x21E,
	/*SPIWrite	*/0x21F,
	/*SPIWrite	*/0x220,
	/*SPIWrite	*/0x221,
	/*SPIWrite	*/0x222,
	/*SPIWrite	*/0x223,
	/*SPIWrite	*/0x224,
	/*SPIWrite	*/0x225,
	/*SPIWrite	*/0x226,
	/*SPIWrite	*/0x227,
	//************************************************************
	// Tx Quadrature Calibration Settings
	//************************************************************
	//SPIRead 0A3 // Masked Read:  Read lower 6 bits, overwrite [7:6] below
	/*SPIWrite	*/0x0A0,	// Set TxQuadcal NCO frequency
	/*SPIWrite	*/0x0A3,	// Set TxQuadcal NCO frequency (Only update bits [7:6])
	/*SPIWrite	*/0x0A1,	// Set TxQuadcal M[1:0]
	/*SPIWrite	*/0x0A9,	// Set Tx Quad Cal Count
	/*SPIWrite	*/0x0A2,	// Set Tx Quad Cal Kexp
	/*SPIWrite	*/0x0A5,	// Set Tx Quad Cal Magnitude Threshhold
	/*SPIWrite	*/0x0A6,	// Set Tx Quad Cal Magnitude Threshhold
	/*SPIWrite	*/0x0AA,	// Set Tx Quad Cal Gain Table index
	/*SPIWrite	*/0x0A4,	// Set Tx Quad Cal Setting Count
	/*SPIWrite	*/0x0AE,	// Set Tx Quad Cal LPF Gain index incase Split table mode used
	
	/*SPIWrite	*/0x193,	// BBDC Cal setting
	/*SPIWrite	*/0x190,	// Set BBDC tracking shift M value, only applies when BB DC tracking enabled
	/*SPIWrite	*/0x194,	// BBDC Cal setting
	/*SPIWrite	*/0x016,	// Start BBDC offset cal
	//WAIT_CALDONE	BBDC,2000	// BBDC Max Cal Time: 8767.361 us. Cal done when 0x016[0]==0
	/*SPIWrite	*/0x185,	// Set RF DC offset Wait Count
	/*SPIWrite	*/0x186,	// Set RF DC Offset Count[7:0]
	/*SPIWrite	*/0x187,	// Settings for RF DC cal
	/*SPIWrite	*/0x18B,	// Settings for RF DC cal
	/*SPIWrite	*/0x188,	// Settings for RF DC cal
	/*SPIWrite	*/0x189,	// Settings for RF DC cal
	/*SPIWrite	*/0x016,	// RFDC Max Cal Time: 39949.219 us
	//WAIT_CALDONE	RFDC,2000	// Wait for cal to complete (Done when 0x016[1]==0)
	/*SPIWrite	*/0x016,	// TXQuad Max Cal Time: 2050.000 us
	//WAIT_CALDONE	TXQUAD,2000 // Wait for cal to complete (Done when 0x016[4]==0)
	/*SPIWrite	*/0x168,	// Set RX Quadcal Tone Level
	/*SPIWrite	*/0x16E,	// Set Rx Gain index to use during RX Quadcal
	/*SPIWrite	*/0x16A,	// Set Kexp Phase
	/*SPIWrite	*/0x16B,	// Set Kexp Amplitude
	/*SPIWrite	*/0x169,
	/*SPIWrite	*/0x18B,
	/*SPIWrite	*/0x012,	// Cals done, Set PPORT Config
	/*SPIWrite	*/0x013,	// Set ENSM FDD/TDD bit
	/*SPIWrite	*/0x015,	// Set Dual Synth Mode, FDD External Control bits properly
	//************************************************************
	// Set Tx Attenuation: Tx1: 10.00 dB,  Tx2: 10.00 dB 
	//************************************************************
	/*SPIWrite	*/0x073,
	/*SPIWrite	*/0x074,
	/*SPIWrite	*/0x075,
	/*SPIWrite	*/0x076,
	//************************************************************
	// Setup RSSI and Power Measurement Duration Registers
	//************************************************************
	/*SPIWrite	*/0x150,	// RSSI Measurement Duration 0, 1
	/*SPIWrite	*/0x151,	// RSSI Measurement Duration 2, 3
	/*SPIWrite	*/0x152,	// RSSI Weighted Multiplier 0
	/*SPIWrite	*/0x153,	// RSSI Weighted Multiplier 1
	/*SPIWrite	*/0x154,	// RSSI Weighted Multiplier 2
	/*SPIWrite	*/0x155,	// RSSI Weighted Multiplier 3
	/*SPIWrite	*/0x156,	// RSSI Delay
	/*SPIWrite	*/0x157,	// RSSI Wait
	/*SPIWrite	*/0x158,	// RSSI Mode Select
	/*SPIWrite	*/0x15C,	// Power Measurement Duration
	
	/*SPIWrite	*/0x002,	// Set # transmitters enabled
	/*SPIWrite	*/0x003,	// Set # receivers enabled
};
	#define sizeAD9362Set	(sizeof(AD9362SetAddr)/sizeof(INT16U))
////////////////////
#else
////////////////////
	extern const INT16U AD9362SetAddr[];
////////////////////
#endif
///////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////

INT8U AD9362Init(INT8U ch, INT8U IsItReset);

void AD9362InitSet(INT8U ch, INT8U type);

INT8U AD9362TxOn(INT8U ch, INT8U TxOn);
INT8U AD9362TxEnable(INT8U ch, INT8U Tx1En, INT8U Tx2En);
INT8U AD9362TxFilterSet(INT8U ch, INT8U THB3En, INT8U THB2En, INT8U THB1En, INT8U TxFIREn);

INT8U AD9362RxEnable(INT8U ch, INT8U Rx1En, INT8U Rx2En);
INT8U AD9362RxFilterSet(INT8U ch, INT8U RHB3En, INT8U RHB2En, INT8U RHB1En, INT8U RxFIREn);
INT8U AD9362InOutSelect(INT8U ch, INT8U Tx_AEn,
								  INT8U Rx_ANEn, INT8U Rx_APEn,
								  INT8U Rx_BNEn, INT8U Rx_BPEn,
								  INT8U Rx_CNEn, INT8U Rx_CPEn);

void AD9362CLKSelect(INT8U ch, INT8U type);
void AD9362BPPLLCtrl(INT8U ch, INT8U ADCDiv, INT8U DACDiv2En);
INT8U AD8362BPPLLWrite(INT8U ch, INT32U fLo);
void AD9362DCXOSet(INT8U ch, INT8U Coarse, INT16U Fine);
void AD9362TxFilterConf(INT8U ch, INT8U NoOfTabs, INT8U Gain);
void AD9362RxFilterConf(INT8U ch, INT8U NoOfTabs);
void AD9362RxFilterGain(INT8U ch, INT8U Gain);
void AD9362Rx1GainSet(INT8U ch, INT8U gain);
void AD9362Rx2GainSet(INT8U ch, INT8U gain);
void AD9362Tx1AttnSet(INT8U ch, INT16U Tx1Attn);	// 0.25/dB
void AD9362Tx2AttnSet(INT8U ch, INT16U Tx2Attn);	// 0.25/dB
void AD9362Tx12AllSel(INT8U ch, INT8U Tx1TTx2);
void AD9362TxAttnUpdateEn(INT8U ch, INT8U iEn);

INT8U AD9362GetRssi(INT8U ch, INT8U isItRx2);

INT8U AD9362RxLOPLLCtrl(INT8U ch, INT64U fLo, INT32U offset);
INT8U AD9362TxLOPLLCtrl(INT8U ch, INT64U fLo, INT32U offset);


void WriteAD9362(INT8U OPCODE, INT16U ADDR, INT8U DATA);
INT8U ReadAD9362(INT8U OPCODE, INT16U ADDR);


//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

