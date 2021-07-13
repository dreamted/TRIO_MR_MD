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
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.03.__
 * $Revision: 0.2 $
 * $Revision date: 2007.04.__
 *               : to support to variable clcd like application 4*24 etc
 *                 void LcdInit(INT32U bAddr, INT16U _A0, INT16U _Sel,
 *                              INT8U LineSize, INT8U LineMax, INT8U swtime, char *init);
 ******************************************************************************/

#ifdef BlinkON
	#undef BlinkON
#endif

#ifdef BlinkOFF
	#undef BlinkOFF
#endif

#define	 BlinkON			1
#define	 BlinkOFF			2

#ifdef LCDlineSIZE
	#undef	LCDlineSIZE
#endif

#ifdef LCDlineMAX
	#undef	LCDlineMAX
#endif

#define	LCDlineSIZE			16
#define	LCDlineMAX  		2

#ifdef FwdWrite
	#undef	FwdWrite
#endif

#ifdef BwdWrite
	#undef	BwdWrite
#endif

#define FwdWrite			1
#define BwdWrite			0

////////////////////////////////////////////////////////////////////////////////

struct cLcdStr {
	void (*init)(INT32U bAddr, INT16U _A0, INT16U _Sel, INT8U LineSize, INT8U LineMax, INT8U swtime, char *init);
	void (*write)(void);
	void (*printf)(char *Ptr, INT8U Blink );
	int  (*sprintf)(INT32U Addr, const char *format, ... );
	void (*Clear)(void);
	void (*Replace)(char *Ptr, INT32U Addr, INT32U Cnt);
	void (*ReplaceOne)(char *Ptr, INT32U Addr, INT32U Cnt, INT32U FwdOrNot);

};

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

extern struct cLcdStr *cLcd;


////////////////////////////////////////////////////////////////////////////////
// Fuction Prototype Declaration
////////////////////////////////
void LcdInit(INT32U bAddr, INT16U _A0, INT16U _Sel, INT8U LineSize, INT8U LineMax, INT8U swtime, char *init);
void LcdClear(void);
void LcdCommandWrite (INT8U Comm );
void Lcdprintf (char *Ptr, INT8U Blink );
void LcdPutChar(void);
void LcdWriting(void);
void ReplaceOneStr (char *Ptr, INT32U Addr, INT32U Cnt, INT32U FwdOrNot);
void ReplaceStr(char *Ptr, INT32U Addr, INT32U Cnt);
void StringSwitch ( void );

int Lcdsprintf(INT32U Addr, const char *format, ... );
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

