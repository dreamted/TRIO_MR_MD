/******************************************************************************* 
 *
 * This module contains the function FRAM & RTC(FM31XX) related, a function
 * that is called before the `pFM_31xx' function of the program.  Normally
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
 * $Revision date: 2004.05.__
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Definition(Pre Declration)
#define pFMWrTry	3

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void pFM31xxInit(void);
void SetFM31xxSDAInMode(void);
void SetFM31xxSDAOutMode(void);
void SetpFM31xxSDA(void);
void RstpFM31xxSDA(void);
void SetpFM31xxSCL(void);
void RstpFM31xxSCL(void);
void StartpFM31xx(void);
void StoppFM31xx(void);
void NACKpFM31xx(void);

void WritepFM31xxData(INT8U Data);
void WritepFM31xxRegister(INT8U Addr, INT8U Data);

void pFM31xxSetOSCEn(void);
void pFM31xxSetCALMODE(INT8U nEnable);
void pFM31xxSetBatteryCharge(INT8U nEnable);
void pFM31xxGetTime(_F31xxTime *nTime);
void pFM31xxSetTime(_F31xxTime *nTime);
INT8U pFM31xxSetCalData(INT8U Data);

INT8U ACKpFM31xx(void);
INT8U ReadpFM31xxSDA(void);
INT8U Read_pFM31xx_16Addr_8Data(INT8U DevAddr, INT16U Addr);
INT8U Read_pFM31xx_8Addr_8Data(INT8U DevAddr, INT8U Addr);
INT8U ReadpFM31xxData(void);
INT8U WritepFM31xxFRAM(INT16U Addr, INT8U Data);
INT8U Write_pFM31xx_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data);
INT8U Write_pFM31xx_8Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data);

INT8U ReadpFM31xxRegister(INT8U Addr);

INT8S pFM31xxFRAMFullTest(void);
void pFM31xxRegisterFullRead(void);

extern void ForDelay(unsigned long int count);
extern unsigned long int Ser0Printf( const char *format, ... );

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

