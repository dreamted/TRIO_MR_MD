/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original header file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2007 - bizistyle(bgyoon@hanafos.com), All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2007.10.__
 *
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
#define KeySeqNOP 	0x0000

#ifdef KeyBufferNum
	#undef KeyBufferNum
#endif

#define KeyBufferNum	5

#define DebouncedMax	10
#define DebouncedMin	3


#define keyMASK		0x001F		//extern Key Bit0 ~ Bit4
#define keyNONE   	0x0000

typedef struct {
	INT8U mKeyBuffer[KeyBufferNum];
	INT8U mKeyRDIndex;
	INT8U mKeyWRIndex;
	INT8U mFirstKey;
	INT8U mPrevKey;
	INT8U mKeyDebounce;
	unsigned short int mKEYCSPtr;
} _mKeyStr, *_pmKeyStr;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////////////////////////////////////////////////////
_mKeyStr m5KeyStsB;
_pmKeyStr m5KeySts = &m5KeyStsB;
INT8U	BuzzTimer = 0;			// The Buzzer Timer Timer

////////////////////////////////////////////////////////////////////////////////

extern INT16U ExpioReadData(INT8U SEL);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

