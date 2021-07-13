///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:32 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DDR_M /
//                    HU.C                                                    /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DDR_M /
//                    HU.C -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_appl /
//                    _src_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl /
//                    _src_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_ /
//                    src_20120109\sout\ --endian=little --cpu=Cortex-M3 -e   /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120109\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120109\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\DDR_M /
//                    HU.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME DDR_MHU

        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN SmsSer
        EXTERN pUSART4

        PUBLIC FSKTask
        PUBLIC FskInit
        PUBLIC FskSer
        PUBLIC FskSerB
        PUBLIC RFsksksio
        PUBLIC SFsksksio

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DDR_MHU.C
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : fsmc_sram.h
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.2
//    5 * Date               : 07/11/2008
//    6 * Description        : Header for fsmc_sram.c file.
//    7 ********************************************************************************
//    8 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//    9 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   10 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   11 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   12 * CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   13 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   14 *******************************************************************************/
//   15 #define FSK_C
//   16 
//   17 #include "../include/main.h"

        SECTION `.data`:DATA:NOROOT(2)
// __ProtocolPtr *__data FskSer
FskSer:
        DATA
        DC32 FskSerB

        SECTION `.bss`:DATA:NOROOT(2)
// static OS_STK __data FSKTaskStk[256]
FSKTaskStk:
        DS8 1024
// __WRCSSIO __data SFsksksio
SFsksksio:
        DS8 1724
// __WRCSSIO __data RFsksksio
RFsksksio:
        DS8 1724

        SECTION `.bss`:DATA:NOROOT(2)
// __ProtocolPtr __data FskSerB
FskSerB:
        DS8 48
//   18 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   19 void FskInit(void)
//   20 {
FskInit:
        PUSH     {R3-R5,LR}
//   21 #if 1
//   22  	SmsSer->CheckByte 	= pUSART4.CheckByte;
        LDR.N    R4,??FskInit_0   ;; SmsSer
        LDR      R0,[R4, #+0]
        LDR.N    R1,??FskInit_0+0x4  ;; pUSART4
        LDR      R2,[R1, #+4]
        STR      R2,[R0, #+0]
//   23 	SmsSer->RxGetByte 	= pUSART4.RxGetByte;
        LDR      R2,[R1, #+8]
        STR      R2,[R0, #+4]
//   24 	SmsSer->PutStr 		= pUSART4.PutStr;
        LDR      R2,[R1, #+12]
        STR      R2,[R0, #+8]
//   25 	SmsSer->TxCheckByte = pUSART4.TxCheckByte;
        LDR      R1,[R1, #+28]
        STR      R1,[R0, #+16]
//   26 
//   27 	SmsSer->TimerRx 	= TimerFSKRx;
        MOVS     R1,#+5
        STRH     R1,[R0, #+20]
//   28 	SmsSer->TimerEndWait = TimerFSKEndWait;
        MOVS     R1,#+6
        STRH     R1,[R0, #+22]
//   29 	
//   30 	SmsSer->WRCSRecv 	= &RFsksksio;
        LDR.N    R5,??FskInit_0+0x8  ;; FSKTaskStk
        ADDW     R1,R5,#+2748
        STR      R1,[R0, #+28]
//   31 	SmsSer->WRCSSend 	= &SFsksksio;
        ADD      R1,R5,#+1024
        STR      R1,[R0, #+32]
//   32 	SmsSer->Sem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR      R1,[R4, #+0]
        STR      R0,[R1, #+44]
//   33 	
//   34 	OSTaskCreate(FSKTask, (void *)NULL, (OS_STK *)&FSKTaskStk[FSK_START_STK_SIZE - 1], FSKTASK_PRIO);
        MOVS     R3,#+3
        ADD      R2,R5,#+1020
        MOVS     R1,#+0
        LDR.N    R0,??FskInit_0+0xC  ;; FSKTask
        ADD      SP,SP,#+4
        POP      {R4,R5,LR}
        B.W      OSTaskCreate
        DATA
??FskInit_0:
        DC32     SmsSer
        DC32     pUSART4
        DC32     FSKTaskStk
        DC32     FSKTask
//   35 #endif
//   36 }
//   37 
//   38 
//   39 
//   40 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 void FSKTask(void *pdata)
//   42 {
//   43 #if 0
//   44     INT16U nRet = 0;
//   45 	INT16U InitCnt = 0;
//   46 
//   47 	__ProtocolPtr *nPtr = (__ProtocolPtr *)FskSer;
//   48 
//   49 	pdata = pdata;
//   50 	OSTimeDly(500L);
//   51 
//   52 	BcMdemDebug(TRUE, (INT32S *)NULL);
//   53 	BcMdemPtrInit(&pUSART4, TimerSMSRx);
//   54 
//   55 	
//   56 	SWRST_START:
//   57 	SerPtr->printf("\n\nSTART SMS TASK\n\n");
//   58 
//   59 	if( (nRet = BcMdemInit(VersionCmd)) == 0)
//   60 	
//   61 	{
//   62 		if(++InitCnt > MaxTryNo) goto SWRST_START;
//   63 		TimerRegist(TimerSMSRx, 1000*2L);
//   64 		goto RETRY_START;
//   65 	}
//   66 	
//   67 	nRet = nRet;
//   68 
//   69 	RETRY_START:
//   70 
//   71 	while(1)
//   72 	{
//   73 		nPtr->WRCSRecv->cBody = 0;
//   74 	
//   75 		if(!tTestFlag)
//   76 		{
//   77 			if(ProtocolCheck(nPtr))
//   78 			{
//   79 			#if TWO_BODY >= 2
//   80 				while(nPtr->WRCSRecv->cBody  <=  nPtr->WRCSRecv->BodyNo)
//   81 				{
//   82 			#endif
//   83 				ProtocolComCheck(nPtr);
//   84 			#if TWO_BODY >= 2
//   85 					nPtr->WRCSRecv->cBody++;
//   86 				}
//   87 			#endif
//   88 			}			
//   89 		}
//   90 		WRCS_DownLoadGiveupTimerChk(nPtr);
//   91 		OSTimeDly(100L);
//   92 	}
//   93 #endif    
//   94 }
FSKTask:
        BX       LR               ;; return

        END
//   95 
//   96 ////////////////////////////////////////////////////////////////////////////////
//   97 // End of Source File
//   98 //////////////////////
//   99 
// 
// 4 520 bytes in section .bss
//     4 bytes in section .data
//    94 bytes in section .text
// 
//    94 bytes of CODE memory
// 4 524 bytes of DATA memory
//
//Errors: none
//Warnings: none
