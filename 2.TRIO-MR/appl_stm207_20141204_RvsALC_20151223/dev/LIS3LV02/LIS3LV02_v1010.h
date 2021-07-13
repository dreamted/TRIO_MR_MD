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
 * Copyright 2008 - bizistyle(bgyoon@hanafos.com), All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2008.07
 *
 ******************************************************************************/
#ifdef LIS03LV02_C
	#define _USR_LIS03LV02	
#else
	#define _USR_LIS03LV02	extern
#endif

#define SlopeBuffMAX		60


#define AXIS_X					0
#define AXIS_Y					1
#define AXIS_Z					2


#define MA3_READ_MASK					0x80
#define MA3_ADDR_AUTOINCREMENT_MASK		0x40


#define MA3_ADDR_WR(addr)													\
	((addr) & ~(MA3_READ_MASK | MA3_ADDR_AUTOINCREMENT_MASK))
#define MA3_ADDR_WR_M(addr)													\
	(((addr) & ~(MA3_READ_MASK) | MA3_ADDR_AUTOINCREMENT_MASK))
#define MA3_ADDR_RD(addr)													\
	(((addr) | MA3_READ_MASK) & ~MA3_ADDR_AUTOINCREMENT_MASK)

//myAccel3LV02 레지스터 주소 정의

#define WHO_AM_I   			(0x000f)   
#define OFFSET_X   			(0x0016)   
#define OFFSET_Y   			(0x0017)   
#define OFFSET_Z   			(0x0018)   
#define GAIN_X     			(0x0019)   
#define GAIN_Y     			(0x001a)   
#define GAIN_Z     			(0x001b)   
#define CTRL_REG1  			(0x0020)   
#define CTRL_REG2  			(0x0021)   
#define CTRL_REG3  			(0x0022)   
#define HP_FILTER_RESET  	(0x0023)   
#define STATUS_REG 			(0x0027)   
#define OUTX_L     			(0x0028)   
#define OUTX_H     			(0x0029)   
#define OUTY_L     			(0x002a)   
#define OUTY_H     			(0x002b)   
#define OUTZ_L     			(0x002c)   
#define OUTZ_H     			(0x002d)   
#define FF_WU_CFG  			(0x0030)   
#define FF_WU_SRC  			(0x0031)   
#define FF_WU_ACK  			(0x0032)   
#define FF_WU_THS_L  		(0x0034)   
#define FF_WU_THS_H  		(0x0035)   
#define FF_WU_DURATION  	(0x0036)   
#define DD_CFG     			(0x0038)   
#define DD_SRC     			(0x0039)   
#define DD_ACK     			(0x003a)   
#define DD_THSI_L  			(0x003c)   
#define DD_THSI_H  			(0x003d)   
#define DD_THSE_L  			(0x003e)   
#define DD_THSE_H  			(0x003f)   

/////////////////////////////////////////////////
// CTRL_REG1 BIT DEFINITION
#define XEN					1
#define YEN					1
#define ZEN					1
#define STEN				1

#define DF40Hz				0
#define DF160Hz				1
#define DF640Hz				2
#define DF2560Hz			3

#define PDMode				0
#define DEON				3

typedef union {
	INT8U Data;

	struct {
		INT8U Xen			:1;		// X-axis enable
		INT8U Yen			:1;		// Y-axis enable
		INT8U Zen			:1;		// Z-axis enable
		INT8U ST			:1;		// Self Test Enable
		INT8U DF			:2;		// Deciamtion Factor Contol
		INT8U PD			:2;		// Power Down Mode
	};
} LIS_CTRLReg;
////////////////////////////////////////////////////////////////////////////////
enum
{
	x_axis = 0,
	y_axis,
	z_axis,

	r_kxp74,
	w_kxp74,
};

typedef struct {
	// *10 val
	INT16S xradian;	// x ' (
	INT16S yradian;	// y '
	INT16S zradian; // z '
} TITLSTR;		// SLOPE DATA
	

void Lis03lv02init(void);
INT8S SlopeConvert(TITLSTR *rval);

void WriteLSI(INT16U Comm, INT8U DATA);
INT8U ReadLSICtrl(INT8U Comm);
INT16U ReadLSIData(INT16U Comm);
INT16U SetLSICommand(INT16U Comm);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

