
/*********************************************
* File Name          : alc.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/


////////////////////////////////////////////////////////////////////////////////
#ifdef ALC_C1
	#define _USR_EXT_ALC1
#else
	#define _USR_EXT_ALC1	extern
#endif

//=====================================================================//
// Amp Reason
#define CASE_User				0x00		// 사용자에 의함.
#define CASE_DeviceAutoSD		0x01		// Device Auto Shutdown
#define CASE_RvsFail			0x02		// 역방향 장애
#define CASE_TempHigh			0x03		// 온도 상한
#define CASE_OverPwr			0x04		// Over Power
#define CASE_PSU_SWOFF			0x05		// 전원 Switch OFF
#define CASE_AmpLinkFail		0x06		// AMP Link Fail
#define CASE_VSWRFail			0x07		// VSWR Fail
#define CASE_LoopFail			0x08		// Loop Fail
#define CASE_DCFail				0x09		// DC Fail
#define CASE_SubPSU_SWOFF		0x0A		// SUB 전원 Switch OFF
#define CASE_SwitchingFail		0x0B		// Switching 이상
#define CASE_PLL_UNLOCK			0x0C		// PLL UNLOCK 이상
#define CASE_PwrFail			0x0D		// 전원이상 
#define CASE_DgBdErr			0x0E		// Digital Board 이상 
#define CASE_Unknown			0x0F		// Unknow   
#define CASE_PDFail				0x10		// PD Fail

// SD OFF Status
#define	SD_AMP_ON				0x00
#define	SD_AMP_OFF_5S			0x01
#define	SD_AMP_OFF_30M			0x02
#define	SD_AMP_OFF_INF			0x03



#if 0
enum SYSPATH_NUM{
	PATH_2G = 0,
	PATH_LTE,
	PATH_3G,
	PATH_LTE_A1,
	PATH_LTE_A2,
	PATH_LTE_1,
	PATH_LTE_A1_1,
	PATH_LTE_A2_1,

	SysPathMax,
};

enum {

	SD_FI_2G = 0,
	SD_FI_LTE,
	SD_FI_3G,
	SD_FI_LTE_A1,
	SD_FI_LTE_A2,
	SD_FI_LTE_1,
	SD_FI_LTE_A1_1,
	SD_FI_LTE_A2_1,

	SD_FO_2G,
	SD_FO_LTE,
	SD_FO_3G,
	SD_FO_LTE_A1,
	SD_FO_LTE_A2,
	SD_FO_LTE_1,
	SD_FO_LTE_A1_1,
	SD_FO_LTE_A2_1,

	SD_RO_2G,
	SD_RO_LTE,
	SD_RO_3G,
	SD_RO_LTE_A1,
	SD_RO_LTE_A2,

	SD_RO_LTE_1,
	SD_RO_LTE_A1_1,
	SD_RO_LTE_A2_1,

	SD_SysMax,
};
#endif



#ifdef ALC_C1
	
//	OS_EVENT *AlcSem = NULL;
	
//	INT8S tempIndexHys = 0;

/////////////////////////////////

#else
#endif





//////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

