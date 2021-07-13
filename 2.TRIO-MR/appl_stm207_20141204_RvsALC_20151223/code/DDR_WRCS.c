
/*********************************************
* File Name          : usart1_vx.x.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define SER0INT_C

#include "../include/main.h"
//#include "download.c"












#if 0
unsigned char Check_Data_Image( unsigned char *_Dat )
{
	unsigned char i;
	
	INT8U Img_Sum = 0;

	
	Img_Sum = (REMOTE_IMG + Rmt_FPGA_IMG + Rmt_FPGA_APP_IMG);

	for( i = 0; i < 32; i++ )
	{
		if (Img_Sum & REMOTE_IMG)
		{
			if( RmtCode_Image[i] != _Dat[i] ) Img_Sum &= (~REMOTE_IMG); 
		}
 	}
	
	ImgKind = Img_Sum;

	return ImgKind;

}
#endif
#if 0
char ustrcmp(char *sbuff,char *dbuff, INT8U len)
{
	while(*dbuff){
		if(toupper(*sbuff++)!=*dbuff++)
			return(1);
	}
	return(0);
}

unsigned long int pPrintf(INT8U	Command, const char *format, ...)
{
	INT8U tmpData[512];
    OS_CPU_SR  cpu_sr;

	OS_ENTER_CRITICAL();
	va_list argptr;	
	va_start(argptr, format);
	vsprintf((char *)tmpData, format, argptr);
	va_end( argptr );

	{
		INT8U tid[3] = {0x00, 0xff, 0xff};
		GenBodyFrame(tid, (INT8U *)tmpData, strlen((const char *)tmpData), Command, PcSer, 0);
		WRCS_ProDataAckTx(PcSer);
	}

	OS_EXIT_CRITICAL();
	return FALSE;
}
#endif



////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

