/*******************************************************************************
 *
 * This module contains the function EEPROM(AT24C64) related', a function
 * that is called before the function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 *
 * $Revision: 0.06 $
 * $Revision date: 2008.02.01
 *               : wrting timing 
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
//#define AT24C64Addr		(0x07 << 1)
#define AT24C64Addr		(0x00 << 1)
#define AT24C64DevID	(0x0A << 4) | AT24C64Addr

#define AT24C64Addr_0		(0x00 << 1)
#define AT24C64DevID_Dnr	(0x0A << 4) | AT24C64Addr_0

#define AT24C64Addr_1	(0x01 << 1)
#define AT24C64DevID_Svr	(0x0A << 4) | AT24C64Addr_1



#define AT24C64WrTry	7

#define CLK24C64DELAY	ForDelay(5)

#define AT24C64MaxAddr	 (1024*8)

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void AT24C64Init(void);
void EnableWriteAT24C64(void);
void DisableWriteAT24C64(void);
void RstAT24C64SCL(void);
void SetAT24C64SCL(void);
void RstAT24C64SDA(void);
void SetAT24C64SDA(void);
void SetAT24C64SDAInMode(void);
void SetAT24C64SDAOutMode(void);
void StartAT24C64(void);
void StopAT24C64(void);

void WriteAT24C64Data(INT8U Data);

void NACKAT24C64(void);
INT8U ACKAT24C64(void);
INT8U ReadAT24C64Data(void);
INT8U Write_AT24C64_16Addr_8Data(INT8U DevAddr, INT16U Addr, INT8U Data);
INT16S Read_AT24C64_16Addr_8Data(INT8U DevAddr, INT16U Addr);

signed short int WriteAT24C64(unsigned short int ADDR, unsigned char DATA);
unsigned char ReadAT24C64(unsigned short int ADDR);
unsigned char ReadAT24C64SDA(void);

extern void ForDelay(unsigned long int count);
extern void  OSTimeDly (INT16U ticks);



INT16S Write_AT24C64(INT8U DevAddr,INT16U ADDR, INT8U Data);
INT8U Read_AT24C64(INT8U DevAddr,INT16U ADDR);


#define DonorWriteAT24C64(ADDR,Data)	Write_AT24C64(AT24C64DevID_Dnr,ADDR, Data)
#define ServiceWriteAT24C64(ADDR,Data)	Write_AT24C64(AT24C64DevID_Svr,ADDR, Data)

#define DonorReadAT24C64(ADDR)		Read_AT24C64(AT24C64DevID_Dnr,ADDR)
#define ServiceReadAT24C64(ADDR)	Read_AT24C64(AT24C64DevID_Svr,ADDR)


//extern void WatchdogClear(void);
//extern unsigned long int Ser0Printf( const char *format, ... );
//extern void WDTRegClear(void);
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

