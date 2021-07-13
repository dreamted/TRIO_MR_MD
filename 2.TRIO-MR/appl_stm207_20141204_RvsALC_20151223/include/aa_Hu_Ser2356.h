
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart1_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

//=======================================================================//
#define Ser2Bps		38400L
#define Ser2LCR		(_DATA8BIT | _1_STOP | _NONPARITY)

#ifdef SER2INT_C
	#define	_USER_SER2EXT
#else
	#define _USER_SER2EXT		extern
#endif

//=======================================================================//
// Definition

#define	DLY_EU_MIN	7
#define	DLY_RU_MIN	15


//=======================================================================//
// Global Variable Declaration

//-----------------------------------------------------------------------//
#ifdef	SER2INT_C
//-----------------------------------------------------------------------//

	#define SER2_STK_SIZE	300
	OS_STK Ser2TaskStk[SER2_STK_SIZE] @ "iram";;
	
	__ProtocolPtr Hu_Ser2SerB, *Hu_Ser2Ser = &Hu_Ser2SerB;
	__ProtocolPtr Hu_Ser3SerB, *Hu_Ser3Ser = &Hu_Ser3SerB;
	__ProtocolPtr Hu_Ser5SerB, *Hu_Ser5Ser = &Hu_Ser5SerB;
	__ProtocolPtr Hu_Ser6SerB, *Hu_Ser6Ser = &Hu_Ser6SerB;

	INT8U	LinkFailCnt[HU_MAX] = {0,};
	INT8U   Hu_Idle = 1;

	INT8U	HuPollID[HU_MAX];	// 0xff ; Not User
	INT8U	HuPollCnt = 0;

	SubIDStr	DistTarID;
	INT8U	DistFlag = 0;		// 1: 수행...
	INT8U	DistStep = 0;
	INT8U	DistCnt = 0;
	INT8U	DistType = 0;		// 1: 단독, 2: Br, 3: All, 4: 측정만..
	INT8U	DistBand = 0;		// 0: 2.1G, 1: 900M, 2: 2.5G, 3: ALL
	INT8U	DistOnBr = 0xFF;
	
//-----------------------------------------------------------------------//
#else
//-----------------------------------------------------------------------//

	extern	__ProtocolPtr *Hu_Ser2Ser;
	extern	__ProtocolPtr *Hu_Ser3Ser;
	extern	__ProtocolPtr *Hu_Ser5Ser;
	extern	__ProtocolPtr *Hu_Ser6Ser;

	extern	INT8U	LinkFailCnt[HU_MAX];

	extern	INT8U	HuPollID[HU_MAX];

	extern	SubIDStr	DistTarID;
	extern	INT8U	DistFlag;
	extern	INT8U	DistStep;
	extern	INT8U	DistType;
	extern	INT8U	DistBand;
		
//-----------------------------------------------------------------------//
#endif
//-----------------------------------------------------------------------//

_USER_SER2EXT SIO	Shu, Rhu;


//=======================================================================//
// Prototype Definition

void Ser2Init(void);
void Ser2Task(void *pdata);

void HuProtocolComCheck (__ProtocolPtr *nPtr, __N_ProtocolPtr *NmsPtr);
void GetHuCommand(void);
void EndHuCommand(void);

void MuxControl(INT8U BrID);
void RecvHuDataUpdate(__HU_STS *ptr, SubIDStr sID);
void RecvRuDataUpdate(__RU_STS *ptr, SubIDStr sID);

BOOL InstallCheck(SubIDStr sID, INT8U Path);

void Mea_DistCheckFunc(void);
void Tar_DistCheckFunc(void);
void Total_DistCheckFunc(void);
void LoopBackCtrlFunc(INT8U tPath, SubIDStr tID,  __ProtocolPtr *nPtr, INT8U OnSts);
void DelayCtrlFunc(INT8U tPath, SubIDStr	tID,  __ProtocolPtr *nPtr);
void DtuLoopBackControl(INT8U CtrlVal, INT8U TarBr);

void DelayAlarmCheck(INT8U Mu_BrID, INT8U Hu_BrID, INT8U AlmSts);

//=======================================================================//
// End of Header File
//=======================================================================//


