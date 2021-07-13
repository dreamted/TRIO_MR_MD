/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * Values of global or static variables.
 *
 *
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2007.03.__
 *
 ******************************************************************************/
#define EP_DLY		1
#define D_DLY		8			// Data Delay

#define DevAddr		0xAC		// shift include(r/w flag)

////////////////////////////////////////////////////////////////////////////////

/* SUB Addr ********************************************************************/

enum {
	__AutoRadioEnable = 2,
							//R/W,	4, 	0: Disable, 1: Enable, 		0,		TDD Switch Changes as Detected Ratio
	__RadioSelection,
							//R/W,	4,	Number of DL Symbols,		29, 	If Auto Ratio is Disabled, Use This
	__Detected_Ratio,
							//R,	4,	Number of DL Symbols,		-,		Detected Number of DL Symbols
	__FA_Search_Enable,
							//R/W,	4,	0: Disable, 1: Enable,		1,		FA Search Enable
	__FA_Index_Selection,
							//R/W,  4,	0 ~ 775						1,		If FA Search Disabled, Use This
	__Current_FA_Index,
							//R,	4,	0 ~ 775,					-,		Current FA Index
	__Cell_search_Enable,
							//R/W,	4,	0: Disable, 1: Enable,		1,		Cell Search Enable
	__Preamble_Index,
							//R/W,	4,	0~113,						0,		If Cell Search Disabled, Use This
	__Detected_Preamble_Index,
							//R 4,	0~113,							-,		Detected Preamble Index
	__Sync_Status,
							//R,	4,	0: In-Sync, 1: Out-of-Sync, -, 		Current Sync Status
	__Preamble_Power,
							//R,	4,	. 							-,		Preamble Power
	__AGC_Value,
							//R,	4,	0~255,						-,		AGC Value
	__TDD_Switch_On,
							//R/W,	4,	0: Off, 1: On,				0xFF,	Each bit corresponding Switch0 ~ 7
	__TDD_Switch_Default,
							//R/W,	4,	0: Low, 1: High 			0xFF,	Value for When TDD Switch Off or Out-of Sync
	__TDD_Switch_Polarity,
							//R/W,	4,	0: Low in DL duration,
							//			1: high in DL duration,		0xFF,	TDD Switch Polarity
	__Mux_TDD_Switch_and_Out_of_Sync,
							//R/W,	4,	0: Disable, 1: Enable,		0xFF,	Mux TDD Switch and Out-of Sync
	__TDD_Switch_0_Start_Offset,
							//R/W,	4,	(-128~127usec)				10,		Relative Offset of DL Start point
	__TDD_Switch_1_Start_Offset,
							//R/W,	4,	(-128~127usec)				10,		Relative Offset of DL Start point
	__TDD_Switch_2_Start_Offset,
							//R/W,	4,	(-128~127usec) 				10,		Relative Offset of DL Start point
	__TDD_Switch_3_Start_Offset,
							//R/W,	4,	(-128~127usec),				10,		Relative Offset of DL Start point
	__TDD_Switch_4_Start_Offset,
							//R/W,	4,	(-128~127usec),				10,		Relative Offset of DL Start point
	__TDD_Switch_5_Start_Offset,
							//R/W,	4,	(-128~127usec) 				10,		Relative Offset of DL Start point
	__TDD_Switch_6_Start_Offset,
							//R/W,	4,	(-128~127usec),				10,		Relative Offset of DL Start point
	__TDD_Switch_7_Start_Offset,
							//R/W,	4,	(-128~127usec),				10,		Relative Offset of DL Start point
	__TDD_Switch_0_End_Offset,
							//R/W,	4,	(-128~127usec),				20,		Relative Offset of DL End point
	__TDD_Switch_1_End_Offset,
							//R/W,  4,	(-128~127usec),				20,		Relative Offset of DL End point
	__TDD_Switch_2_End_Offset,
							//R/W,	4,	(-128~127usec),				20,		Relative Offset of DL End point
	__TDD_Switch_3_End_Offset,
							//R/W,	4,	(-128~127usec),				20,		Relative Offset of DL End point
	__TDD_Switch_4_End_Offset,
							//R/W,  4,	(-128~127usec),				20,		Relative Offset of DL End point
	__TDD_Switch_5_End_Offset,
							//R/W,	4,	(-128~127usec),				20,		Relative Offset of DL End point
	__TDD_Switch_6_End_Offset,
							//R/W,	4,	(-128~127usec),				20,		Relative Offset of DL End point
	__TDD_Switch_7_End_Offset,
							//R/W,	4,	(-128~127usec),				20,		Relative Offset of DL End point
	__FO_Alarm_Enable,
							//R/W,	4,	0: Disable, 1: Enable 		1,		FO Alarm Enable
	__System_delay,
							//R/W,	4,	50~1900 (nsec) LSB			1400,	System delay
	__FO_Threshold,
							//R/W,	4,	1~65535,					7,		FO Threshold
	__FO_quantity,
							//R,	4,	LSB(0 ~ 7)					-,		Quantity of FO
	__S_W_Version,
							//R,	4,	BCD code LSB S/W Version Info
	__H_W_Version,
							//R,	4,	BCD code LSB H/W Version Info
	__Save_Config,
							//W,	4,	1: Save Current Config 		0,		Save Current Config
	__RSSI,
							//R,	4,	Measured Value 				-100,	Received Signal Strength Indication
	__PLL_Setting,
							//W,	4
	__Bandwidth_Selection,
							//R/W,	4,	0 : Filter Disable
							//			1 : Filter Enable/10MHz BW	1,		Select BW(10MHz/5MHz) & Filter Disable Setting
							//			2 : Filter Enable/5MHz BW
	__FA_Search_Number_selection,
							//R/W,	4,	1 ~ 6,						3,		Select FA Search Number
	__FA1_Index,			//R/W,	4,	0 ~ 775,					604,	Select 1st FA Index
	__FA2_Index,			//R/W,	4,	0 ~ 775,					644,	Select 2nd FA Index
	__FA3_Index,			//R/W,	4,	0 ~ 775,					684,	Select 3rd FA Index
	__FA4_Index,			//R/W,	4,	0 ~ 775,					0,		Select 4th FA Index
	__FA5_Index,			//R/W,	4,	0 ~ 775,					0,		Select 5th FA Index
	__FA6_Index				//R/W,	4,	0 ~ 775,					0,		Select 6th FA Index

};

////////////////////////////////////////////////////////////////////////////////
#ifdef __DEV_AWR_301
/////////////////////
	extern unsigned long int Ser0Printf( const char *format, ... );
	extern void ForDelay(unsigned long int count);

	#ifdef I2C_CLK
		#undef I2C_CLK
	#endif
	#define I2C_CLK		P9DRReg->D2					// Ser1_TXD

    #define SetI2C_CLK	{I2C_CLK = 1; ForDelay(EP_DLY); }
    #define RstI2C_CLK	{I2C_CLK = 0; ForDelay(EP_DLY); }

    #define I2C_DataInMode()	{P9DDRReg->D3 = 1;}
    #define I2C_DataOutMode()	{P9DDRReg->D3 = 0;}

	#ifdef	I2C_DATA
		#undef I2C_DATA
	#endif
	#define I2C_DATA	P9DRReg->D3					// Ser1_RxD

    #define SetI2C_DATA	{I2C_DATA = 1; ForDelay(EP_DLY); }
    #define RstI2C_DATA	{I2C_DATA = 0; ForDelay(EP_DLY); }



////////////////////////////////////////////////////////////////////////////////
#endif
/////////////////////

void Awr_301Init(void);
INT8U WriteAwr_301(INT8U dAddr, INT8U Addr, INT32S Data);
INT32S ReadAwr_301(INT16U dAddr, INT16U Addr);


void Awr_nack(void);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

