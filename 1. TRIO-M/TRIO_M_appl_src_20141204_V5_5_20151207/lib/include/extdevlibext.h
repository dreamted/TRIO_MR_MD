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
	INT8U  Data1[2000];
	
} SYS_BACK;
////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototype Declaration
/////////////////////////////////
INT8U CheckSWConf(void);
void DownLoadBootingJump(void);
void DownloadFlagSet(unsigned long int nsize);
void DownloadFlagSetExtSRAM(unsigned long int nsize);
void DownloadFlagClr(void);
void DownFlagSet(INT16U mode);

INT32U *RoadBackuptobuffer(INT32U sptr);
int WriteBuffertoBackup(INT32U dptr, INT32U size);

signed long int UpLoadData(unsigned char *ptr, unsigned short int len, unsigned long int pcnt);
signed long int UpLoadExtSRAM(unsigned char *ptr, unsigned short int len, unsigned long int pcnt);
unsigned short int Crc16Calc(unsigned char *buf_ptr, unsigned long int len, unsigned short int ninit);
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////



