
/*******************************************************************************
 *
 * This module contains the function 7202 original source file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 ******************************************************************************/

/*
#define DCLK	20
#define SDIN	21
#define LDAC	22
#define FSIN	18
#define DCS		19
*/
typedef struct {

	void (*Set_LDAC)(void);
	void (*Rst_LDAC)(void);
	void (*Set_CLK)(void);
	void (*Rst_CLK)(void);
	void (*Set_SDIN)(void);
	void (*Rst_SDIN)(void);
	void (*Set_FSIN)(void);
	void (*Rst_FSIN)(void);
	void (*Set_CS)(void);
	void (*Rst_CS)(void);

} _TLV5604Str;


void TLV5604Init
    (void (*Set_LDAC)(void), void (*Rst_LDAC)(void), 
     void (*Set_CLK )(void), void (*Rst_CLK )(void),
     void (*Set_SDIN)(void), void (*Rst_SDIN)(void),
     void (*Set_FSIN)(void), void (*Rst_FSIN)(void),
	 void (*Set_CS  )(void), void (*Rst_CS  )(void));

INT16U TLV5604DACOut(INT8U Index, INT16U Data);

extern void ForDelay(INT32U count);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
//////////////////////

