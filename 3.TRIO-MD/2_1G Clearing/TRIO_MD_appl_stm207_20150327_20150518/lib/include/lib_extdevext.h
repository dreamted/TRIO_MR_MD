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
 * Copyright 2007 - bizistyle(bgyoon@naver.com) All rights reserved.
 *
 * $Revision: 0.1 $
 ******************************************************************************/



/////////////////////////////////////
enum
{
 	ReservedArea,
	DownLoadFlag1,
	DownLoadFlag2,
	FWDataSize3_MSB,
	FWDataSize2,
	FWDataSize1,
	FWDataSize0_LSB,

    BackupMark1L,		// 백업 체크..	// update cnt!!
	BackupMark1H,		// 백업 체크..
	BackupBp
	///////////////////////////////////
};

typedef struct
{
	INT16U bSize;			// backup size!!
	INT8U  Data[(BackupBp/4 + 1)*4];
} SYS_BACK;
////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototype Declaration
/////////////////////////////////

INT32U FLASHpAPBK_Check_Erase(void);

void DownLoadBootingJump(void);
void DownloadFlagSet(unsigned long int nsize);
void DownloadFlagClr(void);
void DownFlagSet(INT16U mode);
void DownloadFlagSetExtSRAM(unsigned long int nsize);
INT8U SetBootBaudRate(INT32U nBps);

INT32U DATEtoInt(char *DATE);

signed long int UpLoadData(unsigned int bAddr, unsigned char *ptr, unsigned short int len, unsigned long int pcnt);
signed long int UpLoadExtSRAM(unsigned char *ptr, unsigned short int len, unsigned long int pcnt);

signed long int ExtSRAM_DataWrite(INT32U upLdAddr,unsigned char *ptr, unsigned short int len, unsigned long int pcnt);

unsigned short int Crc16Calc(unsigned char *buf_ptr, unsigned long int len, unsigned short int ninit);
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////
