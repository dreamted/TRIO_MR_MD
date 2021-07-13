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

#define cLCDlineSIZE		24
#define cLCDlineMAX			4



// LCD INSTRUCION DEFINE
#define  CLEAR_DISP			0x01
#define  CURSOR_HOME		0x02
#define  DEC_MODE			0x04	// cursor direction left
#define  INC_MODE			0x06	// cursor direction right
#define  CURSOR_OFF			0x0C
#define  CURSOR_ON			0x0E
#define  DISP_SFT			0x14	// cursor right shift
#define  FUNC_SET			0x38	// data length: 2byte, 2 line, 5*7dot
#define  CG_RAM				0x40
#define  DD_RAM				0x80
#define  DISP_OFF			0x08
#define  DISP_ON			0x0C

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
////////////////////////////////
typedef struct {
	INT8U LcdOnOff;
	INT8U BlankCnt;
	INT8U lcd_buffersF[cLCDlineSIZE*cLCDlineMAX];
	INT8U lcd_buffersB[cLCDlineSIZE*cLCDlineMAX];
	INT8U LcdBlinkTimer;
	INT8U LcdCharCount;

	INT8U *LcdUserPtrF;
	INT8U *LcdUserPtrB;
	INT8U *LcdIntPtr;

	OS_EVENT *Sem;
	INT32U cs;
	INT32U Sel;
	INT8U LcdSel;
	INT8U LcdA0;
	INT8U LineSize;
	INT8U LineMax;
	INT8U Line1stAddr;
	INT8U Line2ndAddr;
	INT8U swtime;		// default 20, max 100

} cLcdVar;

cLcdVar cLval;

struct cLcdStr cLcdB =
{
	LcdInit,
	LcdWriting,
	Lcdprintf,
	Lcdsprintf,
	LcdClear,
	ReplaceStr,
	ReplaceOneStr
};

struct cLcdStr *cLcd = &cLcdB;

#define	 DDRAML1addr		cLval.Line1stAddr//0x80	// DD RAM Address Line1
#define	 DDRAML2addr		cLval.Line2ndAddr//0xC0	// DD RAM Address Line2

////////////////////////////////////////////////////////////////////////////////
// Fuction Prototype Declaration
////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// extern related variables or function prototype
/////////////////////////////////////////////////
extern void ForDelay(unsigned long int count);
extern void ExpioBitRst(INT16U Bitaddr);
extern void ExpioBitSet(INT16U Bitaddr);
extern void ExpioWriteData(INT8U SEL, INT16U Data);

void DispLine1Adrs(INT8U Addr);
void DispLine2Adrs(INT8U Addr);
void DispLine3Adrs(INT8U Addr);
void DispLine4Adrs(INT8U Addr);


////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

