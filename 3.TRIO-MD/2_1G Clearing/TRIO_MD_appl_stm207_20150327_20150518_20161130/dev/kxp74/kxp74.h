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
#ifdef KXP_C
	#define _USR_KXP	
#else
	#define _USR_KXP	extern
#endif

#define KXP74_CLK			(VFD9SEL*16 + 4)
#define KXP74_SDI			(VFD9SEL*16 + 5)
#define KXP74_CS			(VFD9SEL*16 + 6)

#define KXP74_SDO			(IN13SEL*16 + 7)

#define SlopeBuffMAX		60


_USR_EXTADC INT8U SlopeBuffCnt;
_USR_EXTADC INT16U SlopeDataBuff[3][SlopeBuffMAX];

_USR_EXTADC INT16U SlopeData[3];

_USR_EXTADC INT16U SlopeAvgData[3][3];


void SlopeConvert(INT16S *rval);	// 0: x_axis, 1: y_axis, 2: z_axis
void SetSPICommand(INT8U Comm);
void WriteSPI(INT16U Comm, INT8U DATA);
INT16U ReadSPI(INT8U Comm);


////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

