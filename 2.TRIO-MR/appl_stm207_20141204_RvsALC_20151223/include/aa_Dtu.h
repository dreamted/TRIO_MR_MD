
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart1_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 01/17/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

//=======================================================================//
#define Ser4Bps		38400L
#define Ser4LCR		(_DATA8BIT | _1_STOP | _NONPARITY)

#ifdef SER4INT_C
	#define	_USER_SER4EXT
#else
	#define _USER_SER4EXT		extern
#endif

//=======================================================================//
// Definition



//=======================================================================//
// Global Variable Declaration

//-----------------------------------------------------------------------//
#ifdef	SER4INT_C
//-----------------------------------------------------------------------//

	#define SER4_STK_SIZE	300
	OS_STK Ser4TaskStk[SER4_STK_SIZE] @ "iram";;
	
	__ProtocolPtr DtuSerB, *DtuSer = &DtuSerB;
	__F_MU_CTRL		DtuControlB, *DtuControl = &DtuControlB;

	INT8U	DtuLinkFailCnt = 0;
	INT8U	DtuInitFlag = 0;	// 0: Boot, 1: Init, 2: Ready, 3: Control
	INT8U   Dtu_Idle = 1;
	
//-----------------------------------------------------------------------//
#else
//-----------------------------------------------------------------------//

	extern	__ProtocolPtr *DtuSer;
	extern	__F_MU_CTRL	*DtuControl;

	extern	INT8U	DtuLinkFailCnt;
	extern	INT8U	DtuInitFlag;
	
//-----------------------------------------------------------------------//
#endif
//-----------------------------------------------------------------------//

_USER_SER4EXT SIO	Sdtu, Rdtu;


//=======================================================================//
// Prototype Definition

void Ser4Init(void);
void Ser4Task(void *pdata);

void DtuProtocolComCheck (__ProtocolPtr *nPtr);
void GetDtuCommand(void);
void EndDtuCommand(void);

void Dtu2Status(__F_MU_STS *Ptr);
void DtuInitControl(__ProtocolPtr *toPtr);
INT8S OpConvert(INT16S OptVal);

//=======================================================================//
// End of Header File
//=======================================================================//


