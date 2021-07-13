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

#include "stm32f10x_conf.h"
#include "../include/cLcdlibExt.h"
#include "cLcdlib_v1006.h"

void LcdInit(INT32U bAddr, INT16U _A0, INT16U _Sel, INT8U LineSize, INT8U LineMax, INT8U swtime, char *init)
{
	cLval.LcdOnOff = FALSE;
	cLval.BlankCnt = 0;
	cLval.LcdBlinkTimer = 0;
	cLval.LcdCharCount = 0;
	cLval.cs = bAddr;

	cLval.LcdSel = _Sel;
	cLval.LcdA0 = _A0;

////////////////////////////////////////////////////////////////////////////
	OSTimeDly(100);
    //ForDelay(2);
    LcdCommandWrite(0x30);  		ForDelay(2);
    LcdCommandWrite(0x30);  		ForDelay(2);
    LcdCommandWrite(0x30);  		ForDelay(2);
	LcdCommandWrite(FUNC_SET | (LineMax >> 2));  	ForDelay(2); //data length : 8bit, 2 line, 5*7 dot
    LcdCommandWrite(FUNC_SET | (LineMax >> 2));  	ForDelay(2); //data length : 8bit, 2 line, 5*7 dot */
    LcdCommandWrite(FUNC_SET | (LineMax >> 2));  	ForDelay(2);
    LcdCommandWrite(CURSOR_OFF);  	ForDelay(2);
    LcdCommandWrite(CURSOR_HOME);	ForDelay(2);
    LcdCommandWrite(INC_MODE);  	ForDelay(2); //cursor forward
    LcdCommandWrite(CLEAR_DISP);	ForDelay(2);
    LcdCommandWrite(CURSOR_OFF);

	cLval.Sem = OSSemCreate(1);

	cLval.Line1stAddr = 0x00 | 0x80;

	if(LineMax == 2)
	{
		cLval.Line2ndAddr = 0x40 | 0x80;
	}
	else
	{
		cLval.Line2ndAddr = 0x20 | 0x80;
	}
	if(!swtime)	cLval.swtime = 20;
	else		cLval.swtime = swtime;
	if(LineSize <= cLCDlineSIZE )	cLval.LineSize = LineSize;
	else							cLval.LineSize = cLCDlineSIZE;

	if(LineMax <=  cLCDlineMAX)		cLval.LineMax = LineMax;
	else							cLval.LineMax = cLCDlineMAX;

	cLval.LcdUserPtrF = &cLval.lcd_buffersF[0];
	cLval.LcdUserPtrB = &cLval.lcd_buffersB[0];
	cLval.LcdIntPtr = cLval.LcdUserPtrF;
	cLval.LcdCharCount = 0;

	Lcdprintf((char *)init, BlinkON);

}

void LcdCommandWrite ( INT8U Comm )
{

	ExpioBitRst(cLval.LcdA0);
	ExpioWriteData(cLval.cs, Comm);
	ExpioBitSet(cLval.LcdSel);
	ForDelay(1);
	ExpioBitRst(cLval.LcdSel);
}

void Lcdprintf ( char *Ptr, INT8U Blink )
{
	INT32U	i;

	INT8U err;

	OSSemPend(cLval.Sem, 0, &err);

	if( Blink == BlinkON )
	{
		for( i = 0; i < (cLCDlineSIZE*cLCDlineMAX) && i < (cLval.LineSize * cLval.LineMax); i++ )
		{
			cLval.lcd_buffersF[i] = *(Ptr + i);
			cLval.lcd_buffersB[i] = *(Ptr +(cLval.LineSize*cLval.LineMax) + i);
		}
	}
	else
	{
		for( i = 0; i < (cLCDlineSIZE*cLCDlineMAX) && i < (cLval.LineSize * cLval.LineMax); i++ )
		{
			cLval.lcd_buffersF[i] = *(Ptr + i);
			cLval.lcd_buffersB[i] = *(Ptr + i);
		}
	}
 	OSSemPost(cLval.Sem);

}

void LcdClear(void)
{
	INT32U	i;

	INT8U err;

	OSSemPend(cLval.Sem, 0, &err);

	for( i = 0; i < (cLCDlineSIZE*cLCDlineMAX) && i < cLval.LineSize * cLval.LineMax; i++ )
	{
			cLval.lcd_buffersF[i] = ' ';
			cLval.lcd_buffersB[i] = ' ';
	}

 	OSSemPost(cLval.Sem);

}
int Lcdsprintf(INT32U Addr, const char *format, ... )
{
	char buf[100];
	va_list argptr;

	va_start(argptr, format);
	/*cnt = */vsprintf(buf, format, argptr);
	va_end( argptr );

	ReplaceStr((char *)buf, Addr, strlen(buf));

	return (strlen(buf));
}

#define StrLimit {\
\
	if(Addr + Cnt > (cLval.LineSize * cLval.LineMax)) \
	{ \
		if(Addr >= (cLval.LineSize * cLval.LineMax)) return; \
		else	Cnt = (cLval.LineSize * cLval.LineMax) - Addr; \
	} \
	if(strlen(Ptr) < Cnt) Cnt = strlen(Ptr);\
}

void ReplaceStr(char *Ptr, INT32U Addr, INT32U Cnt)
{
	INT32U	i;
	INT8U err;


	OSSemPend(cLval.Sem, 0, &err);

	StrLimit;

	for( i = 0; i < Cnt; i++ )
	{	*((char *)cLval.lcd_buffersF+Addr + i) = *(Ptr + i);
		*((char *)cLval.lcd_buffersB+Addr + i) = *(Ptr + i);
	}

	OSSemPost(cLval.Sem);
}

void ReplaceOneStr (char *Ptr, INT32U Addr, INT32U Cnt, INT32U FwdOrNot)
{
	INT32U	i;
	char *WrPtr;
	INT8U err;

	OSSemPend(cLval.Sem, 0, &err);

	StrLimit;

	if(FwdOrNot == FwdWrite)WrPtr = (char *)cLval.lcd_buffersF;
	else					WrPtr = (char *)cLval.lcd_buffersB;

	for( i = 0; i < Cnt; i++ ) *((char *)WrPtr+Addr + i) = *(Ptr + i);

 	OSSemPost(cLval.Sem);
}

void LcdWriting(void)
{
	if ( cLval.LcdBlinkTimer != 0 )
		cLval.LcdBlinkTimer--;
	LcdPutChar();
}

void DispLine1Adrs ( INT8U Addr )
 {
	LcdCommandWrite( DDRAML1addr + Addr );
 }

void DispLine2Adrs ( INT8U Addr )
 {
	LcdCommandWrite( DDRAML2addr + Addr );
 }

void DispLine3Adrs ( INT8U Addr )
 {
	LcdCommandWrite( DDRAML1addr + 0x40 + Addr );
 }

void DispLine4Adrs ( INT8U Addr )
 {
	LcdCommandWrite( DDRAML2addr + 0x40 + Addr );
 }

void LcdPutChar(void)
{
	if(	cLval.LcdOnOff == TRUE )
	{
		if(cLval.LineMax == 2)
		{
			if( cLval.LcdCharCount == cLval.LineSize )
			{
			  	DispLine2Adrs(0);
			}
			else if( cLval.LcdCharCount == cLval.LineSize*2)
			{
				DispLine1Adrs(0);
				cLval.LcdCharCount = 0;
				StringSwitch();
			}
		}
		else	// 4 Line
		{
			if( cLval.LcdCharCount == cLval.LineSize )
			{
			  	DispLine2Adrs(0);
			}
			else if( cLval.LcdCharCount == cLval.LineSize*2)
			{
			  	DispLine3Adrs(0);
			}
			else if( cLval.LcdCharCount == cLval.LineSize*3)
			{
			  	DispLine4Adrs(0);
			}
			else if( cLval.LcdCharCount == cLval.LineSize*4)
			{
				DispLine1Adrs(0);
				cLval.LcdCharCount = 0;
				StringSwitch();
			}
		}
	   	cLval.LcdOnOff = FALSE;
	}
	else
	{
		// VFD_FuncSet = 0x40;
		while(cLval.LcdOnOff == FALSE)
		{
			ExpioBitSet(cLval.LcdA0);
			ExpioWriteData(cLval.cs, *((INT8U*)(cLval.LcdIntPtr + cLval.LcdCharCount)));
			ExpioBitSet(cLval.LcdSel);
			ForDelay(1);
			ExpioBitRst(cLval.LcdSel);
			cLval.LcdCharCount++;

			if((cLval.LcdCharCount%cLval.LineSize) == 0 )cLval.LcdOnOff = TRUE;
		}
	}
}

void StringSwitch ( void )
{
	if( cLval.LcdBlinkTimer == 0 )
	{	cLval.LcdBlinkTimer = cLval.swtime%100;
		if( cLval.LcdIntPtr != cLval.LcdUserPtrB )	cLval.LcdIntPtr = cLval.LcdUserPtrB;
		else					      				cLval.LcdIntPtr = cLval.LcdUserPtrF;
	}
}

