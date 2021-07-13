///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    04/Jan/2012  18:16:44 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\dev\bellwa /
//                    ve\bell860s.c                                           /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\dev\bellwa /
//                    ve\bell860s.c -D _MIMO_Type -lcN                        /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120102\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120102\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120102\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\sout\bell8 /
//                    60s.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME bell860s

        EXTERN OSTimeDly
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN USART1Printf
        EXTERN __aeabi_memclr
        EXTERN __aeabi_memcpy
        EXTERN __aeabi_memcpy4
        EXTERN atoh
        EXTERN memcmp
        EXTERN pPrintf
        EXTERN pUSART1
        EXTERN sprintf
        EXTERN strcat
        EXTERN strlen

        PUBLIC BcMEsnNum
        PUBLIC BcMFreqStateCheck
        PUBLIC BcMPilotStateCheck
        PUBLIC BcMPilotStatus
        PUBLIC BcMPilotStatusB
        PUBLIC BcMRfStatus
        PUBLIC BcMRfStatusB
        PUBLIC BcMRtryNo
        PUBLIC BcMSrcTel
        PUBLIC BcMTimerRx
        PUBLIC BcMVerNum
        PUBLIC BcMdebug
        PUBLIC BcMdemCalling
        PUBLIC BcMdemCommad
        PUBLIC BcMdemDataProtocolCheck
        PUBLIC BcMdemDebug
        PUBLIC BcMdemFuncselect
        PUBLIC BcMdemInit
        PUBLIC BcMdemMSGTx
        PUBLIC BcMdemPtrInit
        PUBLIC BcMdemRecv
        PUBLIC BcMdemSwReset
        PUBLIC BcMdemSyncCheck
        PUBLIC BcMdemSyncProtocolCheck
        PUBLIC BcMdemTCPRxCheck
        PUBLIC BcMdemTCPTx
        PUBLIC BcMdemTcpConnect
        PUBLIC BcMdemTcpExit
        PUBLIC BcMdemXmit
        PUBLIC BcMpresentTime
        PUBLIC BcMpresentTimeB
        PUBLIC BcdemPilotGet
        PUBLIC BcdemRfStsGet
        PUBLIC BcdemTimeGet
        PUBLIC CdmaModemHangUp
        PUBLIC CdmaModemTrafficCheck
        PUBLIC DataConv
        PUBLIC EcIo0_Vaule
        PUBLIC EcIo1_Vaule
        PUBLIC EcIo2_Vaule
        PUBLIC EcIo3_Vaule
        PUBLIC EsnChecksumH
        PUBLIC EsnChecksumL
        PUBLIC ModemEsnCheck
        PUBLIC ModemVersion
        PUBLIC PN0_Vaule
        PUBLIC PN1_Vaule
        PUBLIC PN2_Vaule
        PUBLIC PN3_Vaule
        PUBLIC RxBcMData
        PUBLIC RxCdmaData
        PUBLIC TimeReqCnt
        PUBLIC TwoAsciDeciNum2OneHex
        PUBLIC TwoAsciNum2OneHex
        PUBLIC TxCdmaData
        PUBLIC dUartPtr
        PUBLIC eUartPtr

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120102\dev\bellwave\bell860s.c
//    1 /*******************************************************************************
//    2  *
//    3  * This module contains the function 7092 original header file, a function
//    4  * whole things  initializations - global, include function and so on
//    5  *
//    6  *
//    7  * Note that this function is called before the data segments are
//    8  * initialized, this means that this function cannot rely on the
//    9  * values of global or static variables.
//   10  *
//   11  *
//   12  * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
//   13  *
//   14  * $Revision: 0.1 $
//   15  * $Revision date: 2006.03.__
//   16  * &Revision: 0.2 &
//   17  * &Revision date: 2006.06.14: bgyoon, BcMdemMSGTx(): buffer size
//   18  ******************************************************************************/
//   19 #define __BELL_C
//   20 
//   21 #include "stm32f10x_conf.h"
//   22 #include "bell860s.h"

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data RxCdmaData[515]
RxCdmaData:
        DS8 516
// INT8U __data TxCdmaData[515]
TxCdmaData:
        DS8 516

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data RxBcMData[515]
RxBcMData:
        DS8 516

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data PN0_Vaule[3]
PN0_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data PN1_Vaule[3]
PN1_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data PN2_Vaule[3]
PN2_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data PN3_Vaule[3]
PN3_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data EcIo0_Vaule[3]
EcIo0_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data EcIo1_Vaule[3]
EcIo1_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data EcIo2_Vaule[3]
EcIo2_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data EcIo3_Vaule[3]
EcIo3_Vaule:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data ModemVersion[50]
ModemVersion:
        DS8 52

        SECTION `.data`:DATA:NOROOT(2)
// INT8U __data BcMdebug
BcMdebug:
        DATA
        DC8 0
        DC8 0
// INT16U __data BcMTimerRx
BcMTimerRx:
        DC16 0
// __SerStrPtr *__data dUartPtr
dUartPtr:
        DC32 pUSART1
// __SerStrPtr *__data eUartPtr
eUartPtr:
        DC32 0H

        SECTION `.bss`:DATA:NOROOT(2)
// BcMTimeStr __data BcMpresentTimeB
BcMpresentTimeB:
        DS8 20

        SECTION `.bss`:DATA:NOROOT(2)
// BcMRfStsStr __data BcMRfStatusB
BcMRfStatusB:
        DS8 52

        SECTION `.data`:DATA:NOROOT(2)
// INT8S __data BcMVerNum[3]
BcMVerNum:
        DATA
        DC8 0, 0, 0, 0
// INT8U __data TimeReqCnt
TimeReqCnt:
        DC8 0
// INT8U __data BcMRtryNo
BcMRtryNo:
        DC8 0
// INT8U __data EsnChecksumH
EsnChecksumH:
        DC8 0
// INT8U __data EsnChecksumL
EsnChecksumL:
        DC8 0
// INT8S __data BcMSrcTel[13]
BcMSrcTel:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// INT8S __data BcMEsnNum[8]
BcMEsnNum:
        DC8 0, 0, 0, 0, 0, 0, 0, 0
// BcMTimeStr *__data BcMpresentTime
BcMpresentTime:
        DC32 BcMpresentTimeB
// BcMRfStsStr *__data BcMRfStatus
BcMRfStatus:
        DC32 BcMRfStatusB

        SECTION `.bss`:DATA:NOROOT(2)
// BcMPilotStsStr __data BcMPilotStatusB
BcMPilotStatusB:
        DS8 16

        SECTION `.data`:DATA:NOROOT(2)
// BcMPilotStsStr *__data BcMPilotStatus
BcMPilotStatus:
        DATA
        DC32 BcMPilotStatusB
//   23 
//   24 
//   25 #define ____	USART1Printf("%s %d\n", __FUNCTION__, __LINE__);
//   26 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   27 void BcMdemDebug(INT32U nDebug, INT32S *DebugPtr)
//   28 {
//   29 	BcMdebug = nDebug;
BcMdemDebug:
        LDR.W    R3,??DataTable12  ;; BcMdebug
        STRB     R0,[R3, #+0]
//   30 	if(DebugPtr != NULL)
        LDR.N    R2,??BcMdemDebug_0  ;; `?<Constant "\\n\\n 0: nDebug[%d] \\n\\n">`
        CBZ      R1,??BcMdemDebug_1
//   31 	{
//   32 		dUartPtr = (__SerStrPtr *)(DebugPtr);
        STR      R1,[R3, #+4]
//   33 		
//   34 		USART1Printf("\n\n 0: nDebug[%d] \n\n",nDebug);
        MOV      R1,R0
        MOV      R0,R2
        B.N      ??BcMdemDebug_2
//   35 	}
//   36 	else				 
//   37 		{
//   38 	dUartPtr = (__SerStrPtr *)(&pUSART1);
??BcMdemDebug_1:
        LDR.N    R1,??BcMdemDebug_0+0x4  ;; pUSART1
        STR      R1,[R3, #+4]
//   39 	USART1Printf("\n\n 1: nDebug[%d] \n\n",nDebug);
        MOV      R1,R0
        ADD      R0,R2,#+20
??BcMdemDebug_2:
        B.W      USART1Printf
        DATA
??BcMdemDebug_0:
        DC32     `?<Constant "\\n\\n 0: nDebug[%d] \\n\\n">`
        DC32     pUSART1
//   40 
//   41 		}
//   42 }
//   43 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   44 INT8S BcMdemPtrInit(__SerStrPtr *uPtr, INT16U TimerRx)
//   45 {
BcMdemPtrInit:
        PUSH     {R7,LR}
//   46 
//   47 	// memory Allocation
//   48 	if( (dUartPtr == NULL)            )	return -1;			// error: debuguart not allocated --> BcMDebug excuted befor
        LDR.W    R2,??DataTable12  ;; BcMdebug
        LDR      R3,[R2, #+4]
        CMP      R3,#+0
        BNE.N    ??BcMdemPtrInit_0
        MOV      R0,#-1
        POP      {R1,PC}
//   49 	if( (eUartPtr = uPtr)      == NULL)	return -2;			// error: Excution Ptr not allocated --> 
??BcMdemPtrInit_0:
        STR      R0,[R2, #+8]
        CMP      R0,#+0
        BNE.N    ??BcMdemPtrInit_1
        MVN      R0,#+1
        POP      {R1,PC}
//   50 	if( (BcMTimerRx = TimerRx) == NULL) return -3;			// error: TimerValue Error
??BcMdemPtrInit_1:
        STRH     R1,[R2, #+2]
        CMP      R1,#+0
        BNE.N    ??BcMdemPtrInit_2
        MVN      R0,#+2
        POP      {R1,PC}
//   51 
//   52 	eUartPtr->BuffClear();
??BcMdemPtrInit_2:
        LDR      R0,[R0, #+32]
        BLX      R0
//   53 
//   54 	return TRUE;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//   55 }
//   56 
//   57 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   58 INT8S BcMdemInit(INT32U BcmComm)
//   59 {
BcMdemInit:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
//   60     INT32U CmdStep = RstCmd;
        MOVS     R6,#+0
//   61 	INT32S result = 0;
//   62 	INT32S wRSPS = 0;			// wanted rsps!!
        MOVS     R5,#+0
//   63 	INT32S rsps = 0;
//   64 
//   65 	if(BcmComm != ModemALL) CmdStep = BcmComm;
        CMP      R4,#+18
        BEQ.N    ??BcMdemInit_1
        MOV      R6,R4
//   66 INIT_SEQUENCE:
//   67 
//   68 	result = 10;
??BcMdemInit_1:
        MOVS     R7,#+10
//   69 	USART1Printf("\n\n BcmComm[%d] \n\n",BcmComm);
        LDR.W    R8,??Subroutine1_0  ;; `?<Constant "\\n\\n BcmComm[%d] \\n\\n">`
        MOV      R1,R4
        MOV      R0,R8
        BL       USART1Printf
//   70 
//   71 	switch(CmdStep)
        CMP      R6,#+6
        BHI.N    ??BcMdemInit_2
        TBB      [PC, R6]
        DATA
??BcMdemInit_0:
        DC8      +4,+11,+18,+21
        DC8      +24,+27,+30,+0
        THUMB
//   72 	{
//   73 		case RstCmd: 				BcMdemXmit(CdmaRstCmd); 			wRSPS = 14; result = 1; break;
??BcMdemInit_3:
        ADD      R0,R8,#+20
??BcMdemInit_4:
        BL       BcMdemXmit
        MOVS     R5,#+14
        MOVS     R7,#+1
        B.N      ??BcMdemInit_2
//   74 		case ModemHangUpCmd: 		BcMdemXmit(CdmaModemHangUpCmd); 	wRSPS = 30; result = 0; break;
??BcMdemInit_5:
        ADD      R0,R8,#+28
        BL       BcMdemXmit
        MOVS     R5,#+30
        MOVS     R7,#+0
        B.N      ??BcMdemInit_2
//   75 		case ModemRptModeSetCmd:	BcMdemXmit(CdmaRptModeSetCmd); 		wRSPS = 14; result = 1; break;
??BcMdemInit_6:
        ADD      R0,R8,#+40
        B.N      ??BcMdemInit_4
//   76 		case VersionCmd: 			BcMdemXmit(CdmaVersionCmd); 		wRSPS = 14; result = 2; break;
??BcMdemInit_7:
        ADD      R0,R8,#+60
        B.N      ??BcMdemInit_8
//   77 		case ModemMinNumCmd: 		BcMdemXmit(CdmaModemMinNumCmd); 	wRSPS = 14; result = 2; break;
??BcMdemInit_9:
        ADD      R0,R8,#+68
        B.N      ??BcMdemInit_8
//   78 		case ModemEsnCmd:			BcMdemXmit(CdmaModemEsnCmd); 		wRSPS = 14; result = 2; break;
??BcMdemInit_10:
        ADD      R0,R8,#+80
        B.N      ??BcMdemInit_8
//   79 		case ModemTimeCmd: 			BcMdemXmit(CdmaModemTimeCmd); 		wRSPS = 14; result = 2; break;
??BcMdemInit_11:
        ADD      R0,R8,#+96
??BcMdemInit_8:
        BL       BcMdemXmit
        MOVS     R5,#+14
        MOVS     R7,#+2
//   80 	}
//   81 	
//   82 	OSTimeDly(10L);
??BcMdemInit_2:
        MOVS     R0,#+10
        BL       OSTimeDly
        LDR.W    R8,??DataTable28  ;; RxCdmaData
//   83 SWITCH:
//   84 
//   85 	switch(result)
??BcMdemInit_12:
        CBZ      R7,??BcMdemInit_13
        CMP      R7,#+2
        BEQ.N    ??BcMdemInit_14
        BCC.N    ??BcMdemInit_15
        B.N      ??BcMdemInit_16
//   86 	{
//   87 		case 0:
//   88 			if(!BcMdemSyncProtocolCheck()) return FALSE;
??BcMdemInit_13:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BNE.N    ??BcMdemInit_17
??BcMdemInit_18:
        MOVS     R0,#+0
        POP      {R4-R8,PC}
//   89 
//   90 			if((rsps  = BcMdemSyncCheck((char *)RxCdmaData)) <= 0) return FALSE;
??BcMdemInit_17:
        MOV      R0,R8
        BL       BcMdemSyncCheck
        CMP      R0,#+1
        BLT.N    ??BcMdemInit_18
//   91 			if( rsps != wRSPS) goto SWITCH;
        CMP      R0,R5
        BNE.N    ??BcMdemInit_12
//   92 			wRSPS = 14;
        MOVS     R5,#+14
//   93         goto rOK;
        B.N      ??BcMdemInit_15
//   94 		case 2:
//   95 			if(!BcMdemSyncProtocolCheck())	return FALSE;
??BcMdemInit_14:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemInit_18
//   96 			if(!BcMdemDataProtocolCheck(CmdStep)) return FALSE;
        SXTB     R0,R6
        BL       BcMdemDataProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemInit_18
//   97 
//   98 		goto rOK;
//   99 		case 1:
//  100 rOK:
//  101 			if(!BcMdemSyncProtocolCheck()) return FALSE;
??BcMdemInit_15:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemInit_18
//  102 
//  103 			if((rsps  = BcMdemSyncCheck((char *)RxCdmaData)) <= 0) return FALSE;
        LDR.W    R0,??DataTable28  ;; RxCdmaData
        BL       BcMdemSyncCheck
        CMP      R0,#+1
        BLT.N    ??BcMdemInit_18
//  104 			if( rsps != wRSPS) goto rOK;
        CMP      R0,R5
        BNE.N    ??BcMdemInit_15
//  105         break;
//  106         default:
//  107 		break;
//  108 	}
//  109 
//  110 	if(BcmComm == ModemALL)
??BcMdemInit_16:
        CMP      R4,#+18
        BNE.N    ??BcMdemInit_19
//  111 	{
//  112 		if(CmdStep++ == ModemTimeCmd)	return TRUE;
        MOV      R0,R6
        ADDS     R6,R0,#+1
        CMP      R0,#+6
        BNE.N    ??BcMdemInit_1
??BcMdemInit_19:
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  113 		goto INIT_SEQUENCE;
//  114 	}
//  115 	else return TRUE;
//  116 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine1:
        MOVS     R0,#+1
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??Subroutine1_0:
        DC32     `?<Constant "\\n\\n BcmComm[%d] \\n\\n">`
//  117 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  118 void BcMdemXmit(INT8U *dataPtr)
//  119 {
BcMdemXmit:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
//  120 	const char ptr[] = "\r\n";
        LDR.N    R5,??BcMdemXmit_0  ;; `?<Constant "\\r\\n">`
        ADD      R0,SP,#+0
        LDR      R1,[R5, #0]
        STR      R1,[R0, #+0]
//  121 		
//  122 	eUartPtr->BuffClear();
        LDR.N    R6,??DataTable12  ;; BcMdebug
        LDR      R0,[R6, #+8]
        LDR      R0,[R0, #+32]
        BLX      R0
//  123 	eUartPtr->PutStr((INT8U *)dataPtr, strlen((const char *)dataPtr), FALSE);
        MOV      R0,R4
        BL       strlen
        MOVS     R2,#+0
        UXTH     R1,R0
        MOV      R0,R4
        LDR      R3,[R6, #+8]
        LDR      R3,[R3, #+12]
        BLX      R3
//  124 	eUartPtr->PutStr((INT8U *)ptr, 2, TRUE);
        MOVS     R2,#+1
        MOVS     R1,#+2
        ADD      R0,SP,#+0
        LDR      R3,[R6, #+8]
        LDR      R3,[R3, #+12]
        BLX      R3
//  125 
//  126 	USART1Printf("\n\n BcMdebug[%d] \n\n",BcMdebug);
        LDRB     R1,[R6, #+0]
        ADDS     R0,R5,#+4
        BL       USART1Printf
//  127 
//  128 	
//  129 	if(BcMdebug)
        LDRB     R0,[R6, #+0]
        CBZ      R0,??BcMdemXmit_1
//  130 	{	
//  131 //		pPrintf("%s\r\n slen: %d \r\n", (char *)dataPtr, strlen((const char *)dataPtr));		
//  132 
//  133 
//  134 		USART1Printf("%s\r\n slen: %d \r\n", (char *)dataPtr, strlen((const char *)dataPtr));
        MOV      R0,R4
        BL       strlen
        MOV      R2,R0
        MOV      R1,R4
        ADD      R0,R5,#+24
        BL       USART1Printf
//  135 	}
//  136 }
??BcMdemXmit_1:
        POP      {R0,R1,R4-R6,PC}  ;; return
        DATA
??BcMdemXmit_0:
        DC32     `?<Constant "\\r\\n">`
//  137 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  138 INT32S BcMdemMSGTx(char *DstTel, char *dataPtr, INT16U nlen)
//  139 {
BcMdemMSGTx:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+12
        MOV      R3,R0
        MOV      R8,R1
        MOV      R6,R2
//  140 	INT16U i = 0;
//  141 	INT8U Ptr[10];
//  142 	INT32S nRet = TRUE;
//  143 	
//  144 	nlen = nlen;
//  145 
//  146 	if(nlen > SmsMaxLen) return -3;
        CMP      R6,#+101
        BCC.N    ??BcMdemMSGTx_0
        MVN      R0,#+2
        B.N      ?Subroutine3
//  147 //	if(nlen > SmsWanLen) nRet = 3;	
//  148 
//  149 	sprintf((char *)TxCdmaData, "%s%s,%s,4098,,,,", 	CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
??BcMdemMSGTx_0:
        LDR.W    R4,??DataTable28  ;; RxCdmaData
        ADD      R5,R4,#+516
        LDR.W    R9,??DataTable9  ;; `?<Constant "%s%s,%s,4098,,,,">`
        LDR.W    R0,??DataTable17  ;; BcMVerNum + 8
        PUSH     {R0,LR}
        ADD      R2,R9,#+20
        MOV      R1,R9
        MOV      R0,R5
        BL       sprintf
        ADD      SP,SP,#+8
//  150 //	sprintf((char *)TxCdmaData, "%s%s,%s,4098,16,1,0,", CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
//  151 //	sprintf((char *)TxCdmaData, "%s%s,%s,4098,16,0,0,", CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
//  152 //	sprintf((char *)TxCdmaData, "%s%s,%s,4098,16,1,1,", CdmaTxDataToSMSCmd, DstTel, BcMSrcTel);
//  153 	//Ptr[0] = '"';
//  154 	//Ptr[1] = 0x00;
//  155 	//strcat((char *)TxCdmaData, (const char *)Ptr);
//  156 	
//  157 	for(i = 0; i < nlen; i++)
        MOVS     R7,#+0
        CBZ      R6,??BcMdemMSGTx_1
//  158 	{
//  159 		sprintf((char *)Ptr, "%02x", dataPtr[i]);
??BcMdemMSGTx_2:
        LDRB     R2,[R8], #+1
        ADD      R1,R9,#+36
        ADD      R0,SP,#+0
        BL       sprintf
//  160 		strcat((char *)TxCdmaData, (const char *)Ptr);
        ADD      R1,SP,#+0
        MOV      R0,R5
        BL       strcat
//  161 		if(strlen((const char *)TxCdmaData) >= CdmaBuffLen) return -4;
        MOV      R0,R5
        BL       strlen
        CMP      R0,#+512
        BCC.N    ??BcMdemMSGTx_3
        MVN      R0,#+3
        B.N      ?Subroutine3
//  162 	}
??BcMdemMSGTx_3:
        ADDS     R7,R7,#+1
        UXTH     R0,R7
        CMP      R0,R6
        BCC.N    ??BcMdemMSGTx_2
//  163 	BcMdemXmit((INT8U *)TxCdmaData);
??BcMdemMSGTx_1:
        MOV      R0,R5
        BL       BcMdemXmit
//  164 
//  165 RECHECK:
//  166 	if(!BcMdemSyncProtocolCheck()) return FALSE;
??BcMdemMSGTx_4:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BNE.N    ??BcMdemMSGTx_5
??BcMdemMSGTx_6:
        MOVS     R0,#+0
        B.N      ?Subroutine3
//  167 	if((nRet = BcMdemSyncCheck((char *)RxCdmaData)) <= 0) return nRet;
??BcMdemMSGTx_5:
        MOV      R0,R4
        BL       BcMdemSyncCheck
        CMP      R0,#+1
        BLT.N    ??BcMdemMSGTx_7
//  168 	if(nRet != 14) goto RECHECK;
        CMP      R0,#+14
        BNE.N    ??BcMdemMSGTx_4
//  169 
//  170 	i = 10;
        MOVS     R7,#+10
        MOVW     R5,#+65535
//  171 	while(i--)
??BcMdemMSGTx_8:
        MOVS     R0,R7
        BEQ.N    ??BcMdemMSGTx_6
        ADDS     R7,R5,R7
        UXTH     R7,R7
//  172 	{
//  173 		if(BcMdemSyncProtocolCheck())
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemMSGTx_8
//  174 		{
//  175 			if((nRet = BcMdemSyncCheck((char *)RxCdmaData)) <= 0) return nRet;
        MOV      R0,R4
        BL       BcMdemSyncCheck
        CMP      R0,#+1
        BLT.N    ??BcMdemMSGTx_7
//  176 			if(nRet == 10) 
        CMP      R0,#+10
        BNE.N    ??BcMdemMSGTx_8
//  177 			{
//  178 				return 3;
        MOVS     R0,#+3
//  179 			}
//  180 		}
//  181 	}
??BcMdemMSGTx_7:
        REQUIRE ?Subroutine3
        ;; // Fall through to label ?Subroutine3
//  182 	//  6: Sms Len Over 80 Bytes(Waringin), But Success, 1st Response OK, but 1st resonse data error, 2nd Response Data NOK
//  183     //  5: Sms Len Over 80 Bytes(Waringin), But Success, 1st Response OK, but 1st resonse data error, 2nd Response Data OK
//  184 	//  4: Sms Len over 80 Bytes(Warning) But Success, 1st Response OK, but 1st resonse data error, 2nd Rsponse No response
//  185 	//  2: 1st Response OK, but 1st resonse data error, 2nd Rsponse No response
//  186 	//  1: Modem Send Success
//  187 	//  0: Modem No Response
//  188 	// -1: 2nd Response Data Error
//  189 	// -2: 1st Response Data Error, 2nd Response No response
//  190 	// -3: Max Buffer Error
//  191 	return 0;
//  192 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine3:
        ADD      SP,SP,#+12
        POP      {R4-R9,PC}       ;; return
//  193 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  194 INT32S BcMdemTCPTx(char *dataPtr, INT16U nlen)
//  195 {
BcMdemTCPTx:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+200
        MOV      R8,R0
        MOV      R7,R1
//  196 	INT16U i;
//  197 	INT8U Ptr[200];
//  198 	INT32S nRet = TRUE;
//  199 	
//  200 	nlen = nlen;
//  201 	
//  202 	sprintf((char *)TxCdmaData, "%s", CdmaModemTcpWrCmd);
        LDR.W    R4,??DataTable28  ;; RxCdmaData
        ADD      R5,R4,#+516
        LDR.N    R6,??DataTable9  ;; `?<Constant "%s%s,%s,4098,,,,">`
        ADD      R2,R6,#+44
        ADR.N    R1,??Subroutine2_0  ;; 0x25, 0x73, 0x00, 0x00
        MOV      R0,R5
        BL       sprintf
//  203 
//  204 	for(i = 0; i < nlen; i++)
        CBZ      R7,??BcMdemTCPTx_0
//  205 	{
//  206 		sprintf((char *)Ptr, "%02x", dataPtr[i]);
??BcMdemTCPTx_1:
        LDRB     R2,[R8], #+1
        ADD      R1,R6,#+36
        ADD      R0,SP,#+0
        BL       sprintf
//  207 		strcat((char *)TxCdmaData, (const char *)Ptr);
        ADD      R1,SP,#+0
        MOV      R0,R5
        BL       strcat
//  208 	}
        SUBS     R7,R7,#+1
        BNE.N    ??BcMdemTCPTx_1
//  209 	BcMdemXmit((INT8U *)TxCdmaData);
??BcMdemTCPTx_0:
        MOV      R0,R5
        BL       BcMdemXmit
//  210 
//  211 	if(BcMdemSyncProtocolCheck())
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTCPTx_2
//  212 	{
//  213 		if(BcMdemSyncCheck((char *)RxCdmaData) != 14) return FALSE;
        MOV      R0,R4
        BL       BcMdemSyncCheck
        CMP      R0,#+14
        BEQ.N    ??BcMdemTCPTx_3
??BcMdemTCPTx_4:
        MOVS     R0,#+0
//  214 	}	
        B.N      ?Subroutine2
//  215 	else return FALSE;
//  216 
//  217 	if(BcMdemSyncProtocolCheck())
??BcMdemTCPTx_3:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BNE.N    ??BcMdemTCPTx_5
??BcMdemTCPTx_2:
        B.N      ?Subroutine2
//  218 	{
//  219 		if(BcMdemSyncCheck((char *)RxCdmaData) != 24) return FALSE;
??BcMdemTCPTx_5:
        MOV      R0,R4
        BL       BcMdemSyncCheck
        CMP      R0,#+24
        BNE.N    ??BcMdemTCPTx_4
//  220 	}
//  221 	else return FALSE;
//  222 
//  223 	return nRet;
        MOVS     R0,#+1
        Nop      
        REQUIRE ?Subroutine2
        ;; // Fall through to label ?Subroutine2
//  224 
//  225 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine2:
        ADD      SP,SP,#+200
        POP      {R4-R8,PC}
        Nop      
        DATA
??Subroutine2_0:
        DC8      0x25, 0x73, 0x00, 0x00

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     `?<Constant "%s%s,%s,4098,,,,">`
//  226 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  227 INT32S BcMdemTCPRxCheck(INT8U *rbuf)
//  228 {	
BcMdemTCPRxCheck:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+24
        MOV      R4,R0
//  229 	INT32S nRet = 0;
//  230 	INT32U i = 0, j = 0, len = 0;
        MOVS     R5,#+0
//  231 	INT8S CheckDataBuff[20];
//  232 	INT8U *tPtr = RxCdmaData;
        LDR.W    R7,??DataTable28  ;; RxCdmaData
//  233 
//  234 
//  235 	if(BcMdemSyncProtocolCheck())
        LDR.N    R6,??DataTable12  ;; BcMdebug
        BL       BcMdemSyncProtocolCheck
        CBZ      R0,??BcMdemTCPRxCheck_0
//  236 	{
//  237 		eUartPtr->BuffClear();
        LDR      R0,[R6, #+8]
        LDR      R0,[R0, #+32]
        BLX      R0
//  238 		
//  239 		for(i = 0; i < strlen(CdmaModemTcpRdCmd); i++)CheckDataBuff[i] = *tPtr++;
        MOVS     R2,#+13
        MOV      R1,R7
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
        ADDS     R7,R7,#+13
//  240 		CheckDataBuff[i] = 0;
        STRB     R5,[SP, #+13]
//  241 
//  242 		if(BcMdemSyncCheck((char *)CheckDataBuff) != 25)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+25
        BNE.N    ??BcMdemTCPRxCheck_1
//  243 		
//  244 		for(j = 0; *tPtr != 0 && j < sizeof(RxCdmaData); j++)
        MOV      R8,R5
        MOVW     R9,#+515
        B.N      ??BcMdemTCPRxCheck_2
//  245 		{
//  246 			INT8U temp;
//  247 
//  248 			//if((*tPtr == 0x0D)||(*tPtr == 0x0A)) break;
//  249 			
//  250 			temp = atoh(*tPtr++);
??BcMdemTCPRxCheck_3:
        LDRB     R0,[R7], #+1
        BL       atoh
        MOV      R10,R0
//  251 			temp = atoh(*tPtr++) + ( temp << 4 );
        LDRB     R0,[R7], #+1
        BL       atoh
        ADD      R0,R0,R10, LSL #+4
        UXTB     R0,R0
//  252 			
//  253 			rbuf[len++] = temp;
        STRB     R0,[R5, R4]
        ADDS     R5,R5,#+1
//  254 		}
        ADD      R8,R8,#+1
??BcMdemTCPRxCheck_2:
        LDRB     R0,[R7, #+0]
        CBZ      R0,??BcMdemTCPRxCheck_4
        CMP      R8,R9
        BCC.N    ??BcMdemTCPRxCheck_3
//  255 				
//  256 		nRet = len;
//  257 		rbuf[len++] = 0;	// null data insert
??BcMdemTCPRxCheck_4:
        MOVS     R0,#+0
        STRB     R0,[R5, R4]
//  258 				
//  259 	}	
//  260 	else nRet = FALSE;
//  261 
//  262 	eUartPtr->BuffClear();
??BcMdemTCPRxCheck_0:
        LDR      R0,[R6, #+8]
        LDR      R0,[R0, #+32]
        BLX      R0
//  263 	
//  264 	return nRet;
??BcMdemTCPRxCheck_1:
        MOV      R0,R5
        ADD      SP,SP,#+24
        POP      {R4-R10,PC}      ;; return
//  265 
//  266 }
//  267 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  268 INT32S BcMdemSyncProtocolCheck(void)
//  269 {
BcMdemSyncProtocolCheck:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
//  270 	INT8U rData = 0;
//  271 	INT16U	Recv;
//  272 	INT32S  DataCnt = 0;
//  273 
//  274 	TimerRegist(BcMTimerRx, 1000L*10L);
        LDR.N    R4,??DataTable12  ;; BcMdebug
        MOVW     R1,#+10000
        LDRH     R0,[R4, #+2]
        UXTB     R0,R0
        BL       TimerRegist
        B.N      ??BcMdemSyncProtocolCheck_0
//  275 
//  276 	while(1)
//  277 	{
//  278 		if(TimeOverCheck(BcMTimerRx))
//  279 		{
//  280 			if(BcMdebug) pPrintf(" #1. Error: No Response \r\n ");
//  281 			return FALSE;
//  282 		}
//  283 
//  284 		if(eUartPtr->CheckByte(1, &Recv))
//  285 		{
//  286 			rData = eUartPtr->RxGetByte();
//  287 			TimerRegist(BcMTimerRx, 500L);
//  288 			if(rData != 0x0D && rData != 0x0A)
//  289 			{
//  290 				RxCdmaData[DataCnt++] = rData;
//  291 				break;
//  292 			}
//  293 		}
//  294 		else OSTimeDly(10L);
??BcMdemSyncProtocolCheck_1:
        MOVS     R0,#+10
        BL       OSTimeDly
??BcMdemSyncProtocolCheck_0:
        LDRH     R0,[R4, #+2]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??BcMdemSyncProtocolCheck_2
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??BcMdemSyncProtocolCheck_3
        LDR.N    R0,??BcMdemSyncProtocolCheck_4  ;; `?<Constant " #1. Error: No Respon...">`
??BcMdemSyncProtocolCheck_5:
        BL       pPrintf
??BcMdemSyncProtocolCheck_3:
        MOVS     R0,#+0
        POP      {R1,R2,R4-R6,PC}
??BcMdemSyncProtocolCheck_2:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+8]
        LDR      R2,[R2, #+4]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??BcMdemSyncProtocolCheck_1
        LDR      R0,[R4, #+8]
        LDR      R0,[R0, #+8]
        BLX      R0
        UXTB     R6,R0
        MOV      R1,#+500
        LDRH     R0,[R4, #+2]
        UXTB     R0,R0
        BL       TimerRegist
        CMP      R6,#+13
        BEQ.N    ??BcMdemSyncProtocolCheck_0
        CMP      R6,#+10
        BEQ.N    ??BcMdemSyncProtocolCheck_0
        LDR.W    R5,??DataTable28  ;; RxCdmaData
        STRB     R6,[R5, #+0]
        MOVS     R6,#+1
//  295 	}
//  296 
//  297 	TimerRegist(BcMTimerRx, 1000L);
        MOV      R1,#+1000
        LDRH     R0,[R4, #+2]
        UXTB     R0,R0
        BL       TimerRegist
        B.N      ??BcMdemSyncProtocolCheck_6
//  298 	
//  299 	while(1)
//  300 	{
//  301 		if(TimeOverCheck(BcMTimerRx))
//  302 		{
//  303 			if(BcMdebug) pPrintf(" #2 Error: No Response \r\n ");
//  304 			return FALSE;
//  305 		}
//  306 
//  307 		if(eUartPtr->CheckByte(1, &Recv))
//  308 		{
//  309 			TimerRegist(BcMTimerRx, 500L);
//  310 			if( (RxCdmaData[DataCnt] = eUartPtr->RxGetByte()) == 0x0D)
//  311 			{
//  312 				break;
//  313 			}
//  314 			if(DataCnt >= CdmaBuffLen)
//  315 			{
//  316 				if(BcMdebug) pPrintf(" Error: CdmaBuffLen OverFlow %d \r\n ", DataCnt);
//  317 				return FALSE;
//  318 			}
//  319 			DataCnt++;
??BcMdemSyncProtocolCheck_7:
        ADDS     R6,R6,#+1
??BcMdemSyncProtocolCheck_6:
        LDRH     R0,[R4, #+2]
        UXTB     R0,R0
        BL       TimeOverCheck
        CBZ      R0,??BcMdemSyncProtocolCheck_8
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??BcMdemSyncProtocolCheck_3
        LDR.N    R0,??BcMdemSyncProtocolCheck_4+0x4  ;; `?<Constant " #1. Error: No Respon...">` + 28
        B.N      ??BcMdemSyncProtocolCheck_5
??BcMdemSyncProtocolCheck_8:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+8]
        LDR      R2,[R2, #+4]
        BLX      R2
        CBZ      R0,??BcMdemSyncProtocolCheck_9
        MOV      R1,#+500
        LDRH     R0,[R4, #+2]
        UXTB     R0,R0
        BL       TimerRegist
        LDR      R0,[R4, #+8]
        LDR      R0,[R0, #+8]
        BLX      R0
        STRB     R0,[R6, R5]
        LDRB     R0,[R6, R5]
        CMP      R0,#+13
        BNE.N    ??BcMdemSyncProtocolCheck_10
//  320 		}
//  321 		else OSTimeDly(10);
//  322 	}
//  323 	RxCdmaData[DataCnt + 1] = 0x0A;
        ADDS     R0,R6,R5
        MOVS     R1,#+10
        STRB     R1,[R0, #+1]
//  324 	RxCdmaData[DataCnt + 2] = 0x00;
        MOVS     R1,#+0
        STRB     R1,[R0, #+2]
//  325 
//  326 	if(BcMdebug) pPrintf(" %s\r\n ", RxCdmaData);
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??BcMdemSyncProtocolCheck_11
        MOV      R1,R5
        LDR.N    R0,??BcMdemSyncProtocolCheck_4+0x8  ;; `?<Constant " #1. Error: No Respon...">` + 92
        BL       pPrintf
//  327 	return DataCnt;
??BcMdemSyncProtocolCheck_11:
        MOV      R0,R6
        POP      {R1,R2,R4-R6,PC}  ;; return
??BcMdemSyncProtocolCheck_10:
        CMP      R6,#+512
        BLT.N    ??BcMdemSyncProtocolCheck_7
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??BcMdemSyncProtocolCheck_3
        MOV      R1,R6
        LDR.N    R0,??BcMdemSyncProtocolCheck_4+0xC  ;; `?<Constant " #1. Error: No Respon...">` + 56
        BL       pPrintf
        B.N      ??BcMdemSyncProtocolCheck_3
??BcMdemSyncProtocolCheck_9:
        MOVS     R0,#+10
        BL       OSTimeDly
        B.N      ??BcMdemSyncProtocolCheck_6
        Nop      
        DATA
??BcMdemSyncProtocolCheck_4:
        DC32     `?<Constant " #1. Error: No Respon...">`
        DC32     `?<Constant " #1. Error: No Respon...">` + 28
        DC32     `?<Constant " #1. Error: No Respon...">` + 92
        DC32     `?<Constant " #1. Error: No Respon...">` + 56
//  328 
//  329 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     BcMdebug
//  330 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  331 INT32S BcMdemSyncCheck(char *Ptr)
//  332 {
BcMdemSyncCheck:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  333 
//  334 	if(Ptr == NULL || strlen(Ptr) == 0) 								return 0;
        BEQ.N    ??BcMdemSyncCheck_0
        BL       strlen
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_1
??BcMdemSyncCheck_0:
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//  335 
//  336 	if(!memcmp(Ptr, RspTxAckmsg, strlen(RspTxAckmsg))) 					return 10;
??BcMdemSyncCheck_1:
        LDR.N    R5,??BcMdemSyncCheck_2+0x8  ;; `?<Constant "$TCPREADDATA=">`
        MOVS     R2,#+16
        ADD      R1,R5,#+16
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_3
        MOVS     R0,#+10
        POP      {R1,R4,R5,PC}
//  337 	if(!memcmp(Ptr, Rspconnect, strlen(Rspconnect))) 					return 11;
??BcMdemSyncCheck_3:
        MOVS     R2,#+7
        ADD      R1,R5,#+36
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_4
        MOVS     R0,#+11
        POP      {R1,R4,R5,PC}
//  338 	if(!memcmp(Ptr, Rspnocarr, strlen(Rspnocarr))) 						return 12;
??BcMdemSyncCheck_4:
        MOVS     R2,#+10
        ADD      R1,R5,#+44
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_5
        MOVS     R0,#+12
        POP      {R1,R4,R5,PC}
//  339 
//  340 	if(!memcmp(Ptr, CdmaErr, strlen(CdmaErr))) 							return 13;
??BcMdemSyncCheck_5:
        MOVS     R2,#+5
        ADD      R1,R5,#+56
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_6
        MOVS     R0,#+13
        POP      {R1,R4,R5,PC}
//  341 	if(!memcmp(Ptr, CdmaOk, strlen(CdmaOk))) 							return 14;
??BcMdemSyncCheck_6:
        MOVS     R2,#+2
        ADR.N    R1,??BcMdemSyncCheck_2  ;; 0x4F, 0x4B, 0x00, 0x00
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_7
        MOVS     R0,#+14
        POP      {R1,R4,R5,PC}
//  342 
//  343 	if(!memcmp(Ptr, Rspmsg0Rx, strlen(Rspmsg0Rx))) 						return 15;
??BcMdemSyncCheck_7:
        MOVS     R2,#+6
        ADD      R1,R5,#+64
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_8
        MOVS     R0,#+15
        POP      {R1,R4,R5,PC}
//  344 	if(!memcmp(Ptr, Rspmsg1Rx, strlen(Rspmsg1Rx))) 						return 16;
??BcMdemSyncCheck_8:
        MOVS     R2,#+6
        ADD      R1,R5,#+72
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_9
        MOVS     R0,#+16
        POP      {R1,R4,R5,PC}
//  345 
//  346 	if(!memcmp(Ptr, RspTxmsg, strlen(RspTxmsg))) 						return 17;
??BcMdemSyncCheck_9:
        MOVS     R2,#+4
        ADD      R1,R5,#+80
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_10
        MOVS     R0,#+17
        POP      {R1,R4,R5,PC}
//  347 
//  348 	if(!memcmp(Ptr, RspTcpOpenOk, strlen(RspTcpOpenOk))) 				return 18;
??BcMdemSyncCheck_10:
        MOVS     R2,#+8
        ADD      R1,R5,#+88
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_11
        MOVS     R0,#+18
        POP      {R1,R4,R5,PC}
//  349 	if(!memcmp(Ptr, RspmsgRxCnt,  strlen(RspmsgRxCnt))) 				return 19;
??BcMdemSyncCheck_11:
        MOVS     R2,#+13
        ADD      R1,R5,#+100
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_12
        MOVS     R0,#+19
        POP      {R1,R4,R5,PC}
//  350 	if(!memcmp(Ptr, RspmsgRxMsg,  strlen(RspmsgRxMsg))) 				return 20;
??BcMdemSyncCheck_12:
        MOVS     R2,#+12
        ADD      R1,R5,#+116
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_13
        MOVS     R0,#+20
        POP      {R1,R4,R5,PC}
//  351 	if(!memcmp(Ptr, RspmsgRxEsn,  strlen(RspmsgRxEsn))) 				return 21;
??BcMdemSyncCheck_13:
        MOVS     R2,#+10
        ADD      R1,R5,#+132
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_14
        MOVS     R0,#+21
        POP      {R1,R4,R5,PC}
//  352 	if(!memcmp(Ptr, RspmsgRxRfSts,  strlen(RspmsgRxRfSts))) 			return 22;
??BcMdemSyncCheck_14:
        MOVS     R2,#+12
        ADD      R1,R5,#+144
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_15
        MOVS     R0,#+22
        POP      {R1,R4,R5,PC}
//  353 	if(!memcmp(Ptr, RspmsgTraffic,  strlen(RspmsgTraffic)))				return 23;
??BcMdemSyncCheck_15:
        MOVS     R2,#+10
        ADD      R1,R5,#+160
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_16
        MOVS     R0,#+23
        POP      {R1,R4,R5,PC}
//  354 	
//  355 	if(!memcmp(Ptr, CdmaModemTcpSendDone, strlen(CdmaModemTcpSendDone)))return 24;
??BcMdemSyncCheck_16:
        MOVS     R2,#+12
        ADD      R1,R5,#+172
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_17
        MOVS     R0,#+24
        POP      {R1,R4,R5,PC}
//  356 	if(!memcmp(Ptr, CdmaModemTcpRdCmd,  strlen(CdmaModemTcpRdCmd)))		return 25;
??BcMdemSyncCheck_17:
        MOVS     R2,#+13
        MOV      R1,R5
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_18
        MOVS     R0,#+25
        POP      {R1,R4,R5,PC}
//  357 	if(!memcmp(Ptr, RspTcpCloseOk,  strlen(RspTcpCloseOk)))				return 26;
??BcMdemSyncCheck_18:
        MOVS     R2,#+10
        ADD      R1,R5,#+188
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_19
        MOVS     R0,#+26
        POP      {R1,R4,R5,PC}
//  358 	if(!memcmp(Ptr, RspmsgSwRst,  strlen(RspmsgSwRst)))					return 27;
??BcMdemSyncCheck_19:
        MOVS     R2,#+12
        ADD      R1,R5,#+200
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_20
        MOVS     R0,#+27
        POP      {R1,R4,R5,PC}
//  359 	if(!memcmp(Ptr, RspmsgCallAck,  strlen(RspmsgCallAck)))				return 28;
??BcMdemSyncCheck_20:
        MOVS     R2,#+11
        ADD      R1,R5,#+216
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_21
        MOVS     R0,#+28
        POP      {R1,R4,R5,PC}
//  360 	if(!memcmp(Ptr, RspmsgCallConnect,  strlen(RspmsgCallConnect)))		return 29;
??BcMdemSyncCheck_21:
        MOVS     R2,#+17
        ADD      R1,R5,#+228
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_22
        MOVS     R0,#+29
        POP      {R1,R4,R5,PC}
//  361 	if(!memcmp(Ptr, RspmsgHangup,  strlen(RspmsgHangup)))				return 30;
??BcMdemSyncCheck_22:
        MOVS     R2,#+9
        ADD      R1,R5,#+248
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_23
        MOVS     R0,#+30
        POP      {R1,R4,R5,PC}
//  362 	if(!memcmp(Ptr, RspmsgPilot,  strlen(RspmsgPilot)))					return 31;
??BcMdemSyncCheck_23:
        MOVS     R2,#+12
        ADD      R1,R5,#+260
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_24
        MOVS     R0,#+31
        POP      {R1,R4,R5,PC}
//  363 	if(!memcmp(Ptr, RspmsgMinNum,  strlen(RspmsgMinNum)))				return 32;
??BcMdemSyncCheck_24:
        MOVS     R2,#+10
        ADD      R1,R5,#+276
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_25
        MOVS     R0,#+32
        POP      {R1,R4,R5,PC}
//  364 	if(!memcmp(Ptr, RspmsgCallingCmd,  strlen(RspmsgCallingCmd)))		return 33;
??BcMdemSyncCheck_25:
        MOVS     R2,#+9
        ADD      R1,R5,#+288
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_26
        MOVS     R0,#+33
        POP      {R1,R4,R5,PC}
//  365 	if(!memcmp(Ptr, RspmsgBootAlert,  strlen(RspmsgBootAlert)))			return 34;
??BcMdemSyncCheck_26:
        MOVS     R2,#+14
        ADD      R1,R5,#+300
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_27
        MOVS     R0,#+34
        POP      {R1,R4,R5,PC}
//  366 
//  367 	if(!memcmp(Ptr, "AT*",  strlen("AT*")))								return 100;
??BcMdemSyncCheck_27:
        MOVS     R2,#+3
        ADR.N    R1,??BcMdemSyncCheck_2+0x4  ;; "AT*"
        MOV      R0,R4
        BL       memcmp
        CMP      R0,#+0
        BNE.N    ??BcMdemSyncCheck_28
        MOVS     R0,#+100
        POP      {R1,R4,R5,PC}
//  368 	return -1;	// Normal Data
??BcMdemSyncCheck_28:
        MOV      R0,#-1
        POP      {R1,R4,R5,PC}    ;; return
        DATA
??BcMdemSyncCheck_2:
        DC8      0x4F, 0x4B, 0x00, 0x00
        DC8      "AT*"
        DC32     `?<Constant "$TCPREADDATA=">`
//  369 }
//  370 
//  371 	

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  372 INT8S BcMdemDataProtocolCheck(INT8S Command)
//  373 {
BcMdemDataProtocolCheck:
        PUSH     {R4-R7,LR}
        SUB      SP,SP,#+20
//  374 	INT8S nRet = 0;
//  375 	INT8U i = 0, j = 0 ;
//  376 	INT8S CheckDataBuff[20];
//  377 	INT8U DataCnt = 0, DataCnt2 = 0;
        MOVS     R4,#+0
//  378 
//  379 	switch(Command)
        SUBS     R0,R0,#+3
        CMP      R0,#+14
        BHI.N    ??BcMdemDataProtocolCheck_1
        TBH      [PC, R0, LSL #+1]
        DATA
??BcMdemDataProtocolCheck_0:
        DC16     +15,+45,+137,+224
        DC16     +259,+285,+161,+188
        DC16     +27,+27,+27,+27
        DC16     +27,+27,+302
        THUMB
//  380 	{
//  381 		case VersionCmd:
//  382 
//  383 			for(i = 0; RxCdmaData[i] != 0x0d; i++) {}
??BcMdemDataProtocolCheck_2:
        MOVS     R7,#+0
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        LDRB     R0,[R5, #+0]
        CMP      R0,#+13
        BEQ.N    ??BcMdemDataProtocolCheck_1
??BcMdemDataProtocolCheck_3:
        ADDS     R7,R7,#+1
        UXTB     R7,R7
        LDRB     R1,[R7, R5]
        CMP      R1,#+13
        BNE.N    ??BcMdemDataProtocolCheck_3
//  384 
//  385 			if(i < 6) return FALSE;
        CMP      R7,#+6
        BCS.N    ??BcMdemDataProtocolCheck_4
??BcMdemDataProtocolCheck_1:
        MOVS     R0,#+0
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}
//  386 
//  387 			BcMVerNum[0] = RxCdmaData[i-3];
??BcMdemDataProtocolCheck_4:
        ADDS     R0,R7,R5
        LDR.W    R1,??DataTable40  ;; BcMVerNum
        LDRSB    R2,[R0, #-3]
        STRB     R2,[R1, #+0]
//  388 			BcMVerNum[1] = RxCdmaData[i-2];
        SUBS     R0,R0,#+3
        LDRSB    R2,[R0, #+1]
        STRB     R2,[R1, #+1]
//  389 			BcMVerNum[2] = RxCdmaData[i-1];
        LDRSB    R0,[R0, #+2]
        STRB     R0,[R1, #+2]
//  390 
//  391 			nRet = TRUE;
??BcMdemDataProtocolCheck_5:
        MOVS     R6,#+1
        B.N      ??BcMdemDataProtocolCheck_6
//  392 		break;
//  393 		
//  394 		case ModemMinNumCmd:
//  395 			for(i = 0; i < strlen(RspmsgMinNum);i++)
//  396 			{
//  397 				CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_7:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+10
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
//  398 			}
//  399 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+10]
//  400 
//  401 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 32) return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+32
        BNE.N    ??BcMdemDataProtocolCheck_1
//  402 		
//  403 			nRet = TRUE;
        MOVS     R6,#+1
//  404 
//  405 			for (i = 0; i < TelNo; i++ ) if( RxCdmaData[strlen(RspmsgMinNum) + (DataCnt++)] == '-' ) break;
        MOVS     R0,#+0
        ADD      R1,R5,#+10
??BcMdemDataProtocolCheck_8:
        ADDS     R4,R4,#+1
        UXTB     R4,R4
        LDRB     R2,[R1], #+1
        CMP      R2,#+45
        BEQ.N    ??BcMdemDataProtocolCheck_9
        ADDS     R0,R0,#+1
        UXTB     R2,R0
        CMP      R2,#+13
        BCC.N    ??BcMdemDataProtocolCheck_8
//  406 			for (j = 0; j <(DataCnt-1); j++ )
??BcMdemDataProtocolCheck_9:
        SUBS     R2,R4,#+1
        CMP      R2,#+1
        BLT.N    ??BcMdemDataProtocolCheck_10
//  407 			{
//  408 				BcMSrcTel[j] = RxCdmaData[strlen(RspmsgMinNum)+ j];
        ADD      R1,R5,#+10
        LDR.N    R0,??DataTable17  ;; BcMVerNum + 8
        BL       __aeabi_memcpy
//  409 			}
//  410 			DataCnt2 = DataCnt;
??BcMdemDataProtocolCheck_10:
        MOV      R0,R4
//  411 
//  412 			for (i = 0; i < TelNo; i++ ) if ( RxCdmaData[strlen(RspmsgMinNum)+ (DataCnt++)] == '-' ) break;
        MOVS     R1,#+0
        ADDS     R2,R4,R5
        ADDS     R2,R2,#+10
??BcMdemDataProtocolCheck_11:
        ADDS     R4,R4,#+1
        UXTB     R4,R4
        LDRB     R3,[R2], #+1
        CMP      R3,#+45
        BEQ.N    ??BcMdemDataProtocolCheck_12
        ADDS     R1,R1,#+1
        UXTB     R3,R1
        CMP      R3,#+13
        BCC.N    ??BcMdemDataProtocolCheck_11
//  413 
//  414 
//  415 			for ( j = (DataCnt2); j<(DataCnt-1); j++ )
??BcMdemDataProtocolCheck_12:
        ADDS     R1,R0,R5
        ADDS     R1,R1,#+10
        SUBS     R2,R4,#+1
        B.N      ??BcMdemDataProtocolCheck_13
//  416 			{
//  417 				BcMSrcTel[j-1] = RxCdmaData[strlen(RspmsgMinNum)+ j];
??BcMdemDataProtocolCheck_14:
        LDR.W    R7,??DataTable40  ;; BcMVerNum
        ADDS     R3,R0,R7
        LDRSB    R7,[R1], #+1
        STRB     R7,[R3, #+7]
//  418 			}
        ADDS     R0,R0,#+1
        UXTB     R0,R0
??BcMdemDataProtocolCheck_13:
        CMP      R0,R2
        BLT.N    ??BcMdemDataProtocolCheck_14
//  419 			
//  420 			DataCnt2 = DataCnt;
        MOV      R0,R4
//  421 
//  422 			for ( i=0; i<TelNo; i++ ) if ( RxCdmaData[strlen(RspmsgMinNum)+ DataCnt++] == 0x0d ) break;
        MOVS     R7,#+0
        ADDS     R1,R4,R5
        ADDS     R1,R1,#+10
??BcMdemDataProtocolCheck_15:
        ADDS     R4,R4,#+1
        UXTB     R4,R4
        LDRB     R2,[R1], #+1
        CMP      R2,#+13
        BEQ.N    ??BcMdemDataProtocolCheck_16
        ADDS     R7,R7,#+1
        UXTB     R2,R7
        CMP      R2,#+13
        BCC.N    ??BcMdemDataProtocolCheck_15
//  423 
//  424 			for ( j=DataCnt2; j<(DataCnt-1); j++ )
??BcMdemDataProtocolCheck_16:
        ADDS     R1,R0,R5
        ADDS     R1,R1,#+10
        SUBS     R2,R4,#+1
??BcMdemDataProtocolCheck_17:
        CMP      R0,R2
        BGE.W    ??BcMdemDataProtocolCheck_6
//  425 			{
//  426 				BcMSrcTel[j-2] = RxCdmaData[strlen(RspmsgMinNum)+ j];
        LDR.W    R4,??DataTable40  ;; BcMVerNum
        ADDS     R3,R0,R4
        LDRSB    R4,[R1], #+1
        STRB     R4,[R3, #+6]
//  427 			}
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        B.N      ??BcMdemDataProtocolCheck_17
//  428 			
//  429 		break;
//  430 
//  431 		case ModemEsnCmd:
//  432 
//  433 			for(i = 0; i < strlen(RspmsgRxEsn);i++)CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_18:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+10
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
//  434 
//  435 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+10]
//  436 			
//  437 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 21)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+21
        BNE.N    ??BcMdemDataProtocolCheck_1
//  438 			
//  439 			for(j = 0; j < 8; j++, i++)BcMEsnNum[j] = RxCdmaData[i];
        ADD      R0,R5,#+10
        LDR.N    R1,??BcMdemDataProtocolCheck_19  ;; BcMVerNum + 24
        MOVS     R2,#+8
??BcMdemDataProtocolCheck_20:
        LDRSB    R3,[R0], #+1
        STRB     R3,[R1], #+1
        SUBS     R2,R2,#+1
        BNE.N    ??BcMdemDataProtocolCheck_20
//  440 		
//  441 			nRet = TRUE;
        B.N      ??BcMdemDataProtocolCheck_5
//  442 							
//  443 		break;
//  444 		case MsgCheckCmd:
//  445 
//  446 			for(i = 0; i < strlen(RspmsgRxCnt);i++) CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_21:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+13
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
//  447 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+13]
//  448 			
//  449 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 19)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+19
        BNE.W    ??BcMdemDataProtocolCheck_1
//  450 			
//  451 			if((RxCdmaData[i] < '0')||(RxCdmaData[i] > '9'))nRet = FALSE;
        LDRB     R0,[R5, #+13]
        CMP      R0,#+48
        BCC.N    ??BcMdemDataProtocolCheck_22
        CMP      R0,#+58
        BCC.N    ??BcMdemDataProtocolCheck_23
??BcMdemDataProtocolCheck_22:
        MOVS     R6,#+0
        B.N      ??BcMdemDataProtocolCheck_6
//  452 			else if(RxCdmaData[i] == '0')	nRet = NOT_DATA;
??BcMdemDataProtocolCheck_23:
        CMP      R0,#+48
        BNE.W    ??BcMdemDataProtocolCheck_5
        MOV      R6,#-1
        B.N      ??BcMdemDataProtocolCheck_6
//  453 			else nRet = TRUE;
//  454 		break;
//  455 		
//  456 		case MsgReciveCmd:
//  457 			for(i = 0; i < strlen(RspmsgRxMsg);i++) CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_24:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+12
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
        MOVS     R7,#+12
//  458 
//  459 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+12]
//  460 
//  461 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 20)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+20
        BNE.W    ??BcMdemDataProtocolCheck_1
//  462 			
//  463 			if((RxCdmaData[i] < '0')||(RxCdmaData[i] > '9'))nRet = FALSE;
        LDRB     R0,[R5, #+12]
        CMP      R0,#+48
        BCC.N    ??BcMdemDataProtocolCheck_25
        CMP      R0,#+58
        SBCS     R6,R6,R6
        LSRS     R6,R6,#+31
        B.N      ??BcMdemDataProtocolCheck_26
??BcMdemDataProtocolCheck_25:
        MOVS     R6,#+0
//  464 			//else if(RxCdmaData[i] == '0')	nRet = NOT_DATA;			
//  465 			else nRet = TRUE;
//  466 
//  467 			//if(RxCdmaData[i] == 0x22)i++;
//  468 							
//  469 			for(j = 0; RxCdmaData[i] != 0; j++,i++) RxBcMData[j] = RxCdmaData[i];
??BcMdemDataProtocolCheck_26:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable23  ;; RxBcMData
        B.N      ??BcMdemDataProtocolCheck_27
??BcMdemDataProtocolCheck_28:
        STRB     R3,[R0, R1]
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
        UXTB     R7,R7
??BcMdemDataProtocolCheck_27:
        LDRB     R3,[R7, R5]
        CMP      R3,#+0
        BNE.N    ??BcMdemDataProtocolCheck_28
//  470 			RxBcMData[j] = 0;
        STRB     R4,[R0, R1]
        B.N      ??BcMdemDataProtocolCheck_6
//  471 
//  472 		break;
//  473 		
//  474 		case ModemTimeCmd:
//  475 
//  476 			for(i = 0; i < strlen(RspmsgTraffic);i++)CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_29:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+10
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
//  477 
//  478 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+10]
//  479 
//  480 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 23)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+23
        BNE.W    ??BcMdemDataProtocolCheck_1
//  481 
//  482 			
//  483 			i += 2; // Traffic Status skip
//  484 
//  485 			// Init
//  486 			for(j = 0; j < sizeof(BcMTimeStr); j++) *((INT8U *)BcMpresentTime + j) = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable40  ;; BcMVerNum
        MOV      R3,R0
??BcMdemDataProtocolCheck_30:
        LDR      R2,[R1, #+32]
        STRB     R3,[R0, R2]
        ADDS     R0,R0,#+1
        CMP      R0,#+18
        BCC.N    ??BcMdemDataProtocolCheck_30
//  487 
//  488 			for(j = 0; j < 14; j++, i++) *((char *)BcMpresentTime + j) = RxCdmaData[i];
        MOVS     R0,#+0
        ADD      R2,R5,#+12
??BcMdemDataProtocolCheck_31:
        LDR      R3,[R1, #+32]
        LDRB     R4,[R2], #+1
        STRB     R4,[R0, R3]
        ADDS     R0,R0,#+1
        UXTB     R3,R0
        CMP      R3,#+14
        BCC.N    ??BcMdemDataProtocolCheck_31
//  489 			
//  490 			nRet = TRUE;
        B.N      ??BcMdemDataProtocolCheck_5
//  491 			
//  492 		break;
//  493 
//  494 		case ModemRfStsCmd:
//  495 			
//  496 			for(i = 0; i < strlen(RspmsgRxMsg);i++)CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_32:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+12
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
//  497 
//  498 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+12]
//  499 
//  500 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 22)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+22
        BNE.W    ??BcMdemDataProtocolCheck_1
//  501 			
//  502 			if((RxCdmaData[i] < '0')||(RxCdmaData[i] > '9'))return FALSE;
        LDRB     R0,[R5, #+12]
        CMP      R0,#+48
        BCC.W    ??BcMdemDataProtocolCheck_1
        CMP      R0,#+58
        BCS.W    ??BcMdemDataProtocolCheck_1
//  503 
//  504 			nRet = BcMFreqStateCheck( (INT8U *)&RxCdmaData[i] );
        ADD      R0,R5,#+12
        BL       BcMFreqStateCheck
        B.N      ??BcMdemDataProtocolCheck_33
//  505 			
//  506 		break;
//  507 
//  508 		case ModemTrafficCmd:
//  509 			
//  510 			for(i = 0; i < strlen(RspmsgTraffic);i++)CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_34:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+10
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
//  511 
//  512 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+10]
//  513 
//  514 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 23)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+23
        BNE.W    ??BcMdemDataProtocolCheck_1
//  515 
//  516 			nRet = RxCdmaData[i];
        LDRSB    R6,[R5, #+10]
        B.N      ??BcMdemDataProtocolCheck_6
//  517 									
//  518 		break;
//  519 
//  520 		case ModemPilotCmd:
//  521 			
//  522 			for(i = 0; i < strlen(RspmsgPilot);i++)CheckDataBuff[i] = RxCdmaData[i];
??BcMdemDataProtocolCheck_35:
        LDR.N    R5,??DataTable28  ;; RxCdmaData
        MOVS     R2,#+12
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
//  523 
//  524 			CheckDataBuff[i] = 0;
        STRB     R4,[SP, #+12]
//  525 
//  526 			if(BcMdemSyncCheck((char *)CheckDataBuff) != 31)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+31
        BNE.W    ??BcMdemDataProtocolCheck_1
//  527 			nRet = BcMPilotStateCheck( (INT8U *)&RxCdmaData[i]);
        ADD      R0,R5,#+12
        BL       BcMPilotStateCheck
??BcMdemDataProtocolCheck_33:
        MOV      R6,R0
//  528 
//  529 
//  530 #if 0
//  531 			for(j = 0 ;j < 3; j++)
//  532 			{
//  533 				if(( nRet = BcMPilotStateCheck( (INT8U *)&RxCdmaData[i] ))>4)
//  534 				{
//  535 				Ser0Printf("Tx True: nRet: %d\n", nRet);
//  536 				break;
//  537 				}
//  538 				else Ser0Printf("Tx FALSE: Max SMS Buffer Error, cnt \n");
//  539 			}
//  540 			
//  541 #endif
//  542 			
//  543 		break;
//  544 		
//  545 		default : return FALSE;
//  546 	}	
//  547 
//  548 	return nRet;
??BcMdemDataProtocolCheck_6:
        SXTB     R0,R6
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
        DATA
??BcMdemDataProtocolCheck_19:
        DC32     BcMVerNum + 24
//  549 	
//  550 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     BcMVerNum + 8

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable23:
        DC32     RxBcMData

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable28:
        DC32     RxCdmaData
//  551 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  552 INT8S BcMFreqStateCheck ( INT8U *DataBuff )
//  553 {
BcMFreqStateCheck:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+12
        MOV      R2,R0
//  554 	INT8U	i, j, k, DataCnt=0, DataCnt2=0, pw;
        MOVS     R1,#+0
//  555 	INT16S		TempCopy, Power, Actch, chlist;
//  556 	//================//
//  557 	// Active Channel //
//  558 	//========================================================================//
//  559 	DataCnt2 = DataCnt;
//  560 	TempCopy = 0;
        MOVS     R3,#+0
//  561 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOV      R6,R1
??BcMFreqStateCheck_0:
        ADDS     R1,R1,#+1
        UXTB     R1,R1
        LDRB     R4,[R0], #+1
        CMP      R4,#+44
        BEQ.N    ??BcMFreqStateCheck_1
        ADDS     R6,R6,#+1
        UXTB     R4,R6
        CMP      R4,#+10
        BCC.N    ??BcMFreqStateCheck_0
//  562 	for ( j=0; j<i; j++ )
??BcMFreqStateCheck_1:
        MOVS     R7,#+0
        MOV      R0,R2
        UXTB     R4,R6
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_2
//  563 	{
//  564 		if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  565 		for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMFreqStateCheck_3:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_4:
        UXTB     R8,LR
        CMP      R8,R5
        BLT.N    ??BcMFreqStateCheck_3
//  566 		TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R0], #+1
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_2:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_5
        LDRB     R12,[R0, #+0]
        CMP      R12,#+48
        BCC.N    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCC.N    ??BcMFreqStateCheck_7
??BcMFreqStateCheck_6:
        MOVS     R0,#+0
        B.N      ?Subroutine4
??BcMFreqStateCheck_7:
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_4
//  567 	}
??BcMFreqStateCheck_5:
        LDR.W    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        STRH     R3,[R0, #+0]
//  568 	Actch = TempCopy;
//  569 	BcMRfStatus->ActChannel = TempCopy;
//  570 	
//  571 	//SWaveStatus->OneFAStatus = 0x03;		// Current FA
//  572 	//========================================================================//
//  573 
//  574 	//=====================//
//  575 	// Number Of Channel //
//  576 	//========================================================================//
//  577 	DataCnt2 = DataCnt;
        MOV      R0,R1
//  578 	TempCopy = 0;
        MOVS     R3,#+0
//  579 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R6,#+0
??BcMFreqStateCheck_8:
        ADDS     R4,R1,#+1
        UXTB     R4,R4
        LDRB     R1,[R1, R2]
        CMP      R1,#+44
        MOV      R1,R4
        BEQ.N    ??BcMFreqStateCheck_9
        ADDS     R6,R6,#+1
        UXTB     R4,R6
        CMP      R4,#+10
        BCC.N    ??BcMFreqStateCheck_8
//  580 	for ( j=0; j<i; j++ )
??BcMFreqStateCheck_9:
        MOVS     R7,#+0
        UXTB     R4,R6
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_10
//  581 	{
//  582 		if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  583 		for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMFreqStateCheck_11:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_12:
        UXTB     R9,LR
        CMP      R9,R5
        BLT.N    ??BcMFreqStateCheck_11
//  584 		TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R0, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_10:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_13
        LDRB     R12,[R0, R2]
        CMP      R12,#+48
        BCC.N    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.N    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_12
//  585 	}
//  586 
//  587 	BcMRfStatus->NumberOfChannel = TempCopy;
??BcMFreqStateCheck_13:
        LDR.W    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        STRH     R3,[R0, #+2]
//  588 	
//  589 	if ( TempCopy == 0 ) return(FALSE);
        CMP      R3,#+0
        BEQ.N    ??BcMFreqStateCheck_6
//  590 
//  591 	//SWaveStatus->ChannelList = ( ((TempCopy/10)<<4) + (TempCopy%10) );
//  592 	chlist = TempCopy;
        STR      R3,[SP, #+4]
//  593 
//  594 	//==============//
//  595 	// Channel List //
//  596 	//========================================================================//
//  597 	for ( k=0; k<chlist; k++ )
        MOVS     R5,#+0
        B.N      ??BcMFreqStateCheck_14
//  598 	{
//  599 		DataCnt2 = DataCnt;
//  600 		TempCopy = 0;
//  601 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
//  602 		if ( i > 4 ) return(FALSE);
//  603 		for ( j=0; j<i; j++ )
//  604 		{
//  605 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  606 			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
//  607 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
//  608 		}
//  609 		
//  610 		BcMRfStatus->PN_Vaule[k] = TempCopy;
??BcMFreqStateCheck_15:
        LDR.W    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        ADD      R0,R0,R5, LSL #+1
        STRH     R3,[R0, #+18]
//  611 		if ( Actch == TempCopy ){}
        ADDS     R5,R5,#+1
        UXTB     R5,R5
??BcMFreqStateCheck_14:
        MOV      R0,R1
        LDR      R3,[SP, #+4]
        CMP      R5,R3
        BGE.N    ??BcMFreqStateCheck_16
        MOVS     R3,#+0
        MOVS     R6,#+0
??BcMFreqStateCheck_17:
        ADDS     R7,R1,#+1
        UXTB     R7,R7
        LDRB     R1,[R1, R2]
        CMP      R1,#+44
        MOV      R1,R7
        BEQ.N    ??BcMFreqStateCheck_18
        ADDS     R6,R6,#+1
        UXTB     R7,R6
        CMP      R7,#+10
        BCC.N    ??BcMFreqStateCheck_17
??BcMFreqStateCheck_18:
        UXTB     R7,R6
        CMP      R7,#+5
        BCS.N    ??BcMFreqStateCheck_6
        MOVS     R7,#+0
        UXTB     R12,R6
        SUB      LR,R12,#+1
        STR      LR,[SP, #+0]
        B.N      ??BcMFreqStateCheck_19
??BcMFreqStateCheck_20:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_21:
        UXTB     R10,LR
        LDR      R11,[SP, #+0]
        CMP      R10,R11
        BLT.N    ??BcMFreqStateCheck_20
        LDRB     LR,[R9, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_19:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_15
        UXTB     R9,R0
        LDRB     R12,[R9, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_21
//  612 			
//  613 	}
//  614 	//========================================================================//
//  615 
//  616 	//=======================//
//  617 	// Number Of Active PN	//
//  618 	//========================================================================//
//  619 	DataCnt2 = DataCnt;
//  620 	TempCopy = 0;
??BcMFreqStateCheck_16:
        MOVS     R3,#+0
//  621 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R6,#+0
??BcMFreqStateCheck_22:
        ADDS     R4,R1,#+1
        UXTB     R4,R4
        LDRB     R1,[R1, R2]
        CMP      R1,#+44
        MOV      R1,R4
        BEQ.N    ??BcMFreqStateCheck_23
        ADDS     R6,R6,#+1
        UXTB     R4,R6
        CMP      R4,#+10
        BCC.N    ??BcMFreqStateCheck_22
//  622 	if ( i > 1 ) return(FALSE);
??BcMFreqStateCheck_23:
        UXTB     R4,R6
        CMP      R4,#+2
        BCS.W    ??BcMFreqStateCheck_6
//  623 	
//  624 	if(DataBuff[DataCnt2]  == '0')goto FER_VAULE;
        UXTB     R4,R0
        LDRB     R4,[R4, R2]
        CMP      R4,#+48
        BEQ.W    ??BcMFreqStateCheck_24
//  625 	
//  626 	for ( j=0; j<i; j++ )
        MOVS     R7,#+0
        UXTB     R4,R6
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_25
//  627 	{
//  628 		if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  629 		for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMFreqStateCheck_26:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_27:
        UXTB     R9,LR
        CMP      R9,R5
        BLT.N    ??BcMFreqStateCheck_26
//  630 		TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R8, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_25:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_28
        UXTB     R8,R0
        LDRB     R12,[R8, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_27
//  631 	}
//  632 	BcMRfStatus->ActPN = TempCopy;
??BcMFreqStateCheck_28:
        LDR.W    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        STRH     R3,[R0, #+16]
//  633 //	Ser0Printf("ActPN : %d	\n", Rf_sts.ActPN);
//  634 
//  635 	if ( (TempCopy > 6)||(TempCopy < 1 ) ) return(FALSE);
        CMP      R3,#+7
        BGE.W    ??BcMFreqStateCheck_6
        CMP      R3,#+1
        BLT.W    ??BcMFreqStateCheck_6
//  636 	chlist = TempCopy;
        STR      R3,[SP, #+4]
//  637 	//========================================================================//
//  638 
//  639 
//  640 	//============================//
//  641 	// Active Channel Ec/Io Value //
//  642 	//========================================================================//
//  643 	for ( k=0; k<chlist; k++ )
        MOVS     R5,#+0
        B.N      ??BcMFreqStateCheck_29
//  644 	{
//  645 		DataCnt2 = DataCnt;
//  646 		TempCopy = 0;
//  647 
//  648 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == '(' ) break;
//  649 		if ( i > 4 ) return(FALSE);
//  650 		for ( j=0; j<i; j++ )
//  651 		{
//  652 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  653 			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
//  654 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
//  655 		}
//  656 		
//  657 		BcMRfStatus->PN_Vaule[k] = TempCopy;
//  658 		
//  659 		DataCnt2 = DataCnt;
//  660 		TempCopy = 0;
//  661 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ')' ) break;
//  662 		DataCnt++;		// Remove ','
//  663 		if ( DataBuff[DataCnt2] == '-' )
//  664 		{
//  665 			DataCnt2++;
//  666 			for ( j=0; j<i-1; j++ )
//  667 			{
//  668 				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  669 				for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
//  670 				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
//  671 			}
//  672 			TempCopy = -TempCopy;
//  673 			BcMRfStatus->EcIo[k] = TempCopy;
//  674 		}
//  675 		else
//  676 		{
//  677 			for ( j=0; j<i; j++ )
//  678 			{
//  679 				if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  680 				for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
//  681 				TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
//  682 			}
//  683 			BcMRfStatus->EcIo[k] = TempCopy;
??BcMFreqStateCheck_30:
        STRH     R3,[R8, #+30]
??BcMFreqStateCheck_31:
        ADDS     R5,R5,#+1
        UXTB     R5,R5
??BcMFreqStateCheck_29:
        LDR      R0,[SP, #+4]
        CMP      R5,R0
        BGE.W    ??BcMFreqStateCheck_32
        MOV      R0,R1
        MOVS     R3,#+0
        MOVS     R6,#+0
??BcMFreqStateCheck_33:
        ADDS     R7,R1,#+1
        UXTB     R7,R7
        LDRB     R1,[R1, R2]
        CMP      R1,#+40
        MOV      R1,R7
        BEQ.N    ??BcMFreqStateCheck_34
        ADDS     R6,R6,#+1
        UXTB     R7,R6
        CMP      R7,#+10
        BCC.N    ??BcMFreqStateCheck_33
??BcMFreqStateCheck_34:
        UXTB     R7,R6
        CMP      R7,#+5
        BCS.W    ??BcMFreqStateCheck_6
        MOVS     R7,#+0
        UXTB     R12,R6
        SUB      LR,R12,#+1
        STR      LR,[SP, #+0]
        B.N      ??BcMFreqStateCheck_35
??BcMFreqStateCheck_36:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_37:
        UXTB     R10,LR
        LDR      R11,[SP, #+0]
        CMP      R10,R11
        BLT.N    ??BcMFreqStateCheck_36
        LDRB     LR,[R9, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_35:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_38
        UXTB     R9,R0
        LDRB     R12,[R9, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_37
??BcMFreqStateCheck_38:
        LDR.W    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        ADD      R8,R0,R5, LSL #+1
        STRH     R3,[R8, #+18]
        MOV      R0,R1
        MOVS     R3,#+0
        MOVS     R6,#+0
??BcMFreqStateCheck_39:
        ADDS     R7,R1,#+1
        UXTB     R7,R7
        LDRB     R1,[R1, R2]
        CMP      R1,#+41
        MOV      R1,R7
        BEQ.N    ??BcMFreqStateCheck_40
        ADDS     R6,R6,#+1
        UXTB     R7,R6
        CMP      R7,#+10
        BCC.N    ??BcMFreqStateCheck_39
??BcMFreqStateCheck_40:
        ADDS     R1,R1,#+1
        UXTB     R1,R1
        UXTB     R12,R6
        LDRB     R7,[R0, R2]
        CMP      R7,#+45
        BNE.N    ??BcMFreqStateCheck_41
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        MOVS     R7,#+0
        SUB      R6,R12,#+2
        SUB      LR,R12,#+1
        STR      LR,[SP, #+0]
        B.N      ??BcMFreqStateCheck_42
??BcMFreqStateCheck_43:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_44:
        UXTB     R10,LR
        CMP      R10,R6
        BLT.N    ??BcMFreqStateCheck_43
        LDRB     LR,[R0, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_42:
        LDR      R12,[SP, #+0]
        CMP      R7,R12
        BGE.N    ??BcMFreqStateCheck_45
        LDRB     R12,[R0, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_44
??BcMFreqStateCheck_45:
        RSBS     R0,R3,#+0
        STRH     R0,[R8, #+30]
        B.N      ??BcMFreqStateCheck_31
??BcMFreqStateCheck_41:
        MOVS     R7,#+0
        SUB      LR,R12,#+1
        STR      LR,[SP, #+0]
        B.N      ??BcMFreqStateCheck_46
??BcMFreqStateCheck_47:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_48:
        UXTB     R10,LR
        LDR      R11,[SP, #+0]
        CMP      R10,R11
        BLT.N    ??BcMFreqStateCheck_47
        LDRB     LR,[R0, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_46:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.W    ??BcMFreqStateCheck_30
        LDRB     R12,[R0, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_48
//  684 		}
//  685 	}
//  686 ///////
//  687 
//  688 	for ( k=chlist; k<6; k++ )
??BcMFreqStateCheck_32:
        ADD      R0,SP,#+4
        LDRB     R5,[R0, #+0]
        B.N      ??BcMFreqStateCheck_49
??BcMFreqStateCheck_50:
        LDR.N    R3,??DataTable40  ;; BcMVerNum
        LDR      R3,[R3, #+36]
        ADD      R0,R3,R5, LSL #+1
        MOVS     R3,#+0
        STRH     R3,[R0, #+18]
//  689 	{
//  690 		BcMRfStatus->PN_Vaule[k] = 0;
//  691 		BcMRfStatus->EcIo[k]	 = 0;
        STRH     R3,[R0, #+30]
//  692 	}
        ADDS     R5,R5,#+1
        UXTB     R5,R5
??BcMFreqStateCheck_49:
        CMP      R5,#+6
        BCC.N    ??BcMFreqStateCheck_50
//  693 	//========================================================================//
//  694 
//  695 FER_VAULE:
//  696 	//===========//
//  697 	// FER Value //
//  698 	//========================================================================//
//  699 	DataCnt2 = DataCnt;
??BcMFreqStateCheck_24:
        MOV      R0,R1
//  700 	TempCopy = 0;
        MOVS     R3,#+0
//  701 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R6,#+0
??BcMFreqStateCheck_51:
        ADDS     R4,R1,#+1
        UXTB     R4,R4
        LDRB     R1,[R1, R2]
        CMP      R1,#+44
        MOV      R1,R4
        BEQ.N    ??BcMFreqStateCheck_52
        ADDS     R6,R6,#+1
        UXTB     R4,R6
        CMP      R4,#+10
        BCC.N    ??BcMFreqStateCheck_51
//  702 	for ( j=0; j<i; j++ )
??BcMFreqStateCheck_52:
        MOVS     R7,#+0
        UXTB     R4,R6
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_53
//  703 	{
//  704 		if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  705 		for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMFreqStateCheck_54:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_55:
        UXTB     R9,LR
        CMP      R9,R5
        BLT.N    ??BcMFreqStateCheck_54
//  706 		TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R8, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_53:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_56
        UXTB     R8,R0
        LDRB     R12,[R8, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_55
//  707 	}
//  708 	
//  709 	BcMRfStatus->FerValue = TempCopy;
??BcMFreqStateCheck_56:
        LDR.N    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        STRH     R3,[R0, #+42]
//  710 	//========================================================================//
//  711 
//  712 	//==========//
//  713 	// RX Value //
//  714 	//========================================================================//
//  715 	DataCnt2 = DataCnt;
        MOV      R0,R1
//  716 	TempCopy = 0;
        MOVS     R3,#+0
//  717 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R6,#+0
??BcMFreqStateCheck_57:
        ADDS     R4,R1,#+1
        UXTB     R4,R4
        LDRB     R1,[R1, R2]
        CMP      R1,#+44
        MOV      R1,R4
        BEQ.N    ??BcMFreqStateCheck_58
        ADDS     R6,R6,#+1
        UXTB     R4,R6
        CMP      R4,#+10
        BCC.N    ??BcMFreqStateCheck_57
//  718 	if ( DataBuff[DataCnt2] == '-' )
??BcMFreqStateCheck_58:
        UXTB     R4,R6
        LDRB     R5,[R0, R2]
        CMP      R5,#+45
        BNE.N    ??BcMFreqStateCheck_59
//  719 	{
//  720 		DataCnt2++;
        ADDS     R0,R0,#+1
        UXTB     R0,R0
//  721 		for ( j=0; j<i-1; j++ )
        MOVS     R7,#+0
        SUBS     R6,R4,#+2
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_60
//  722 		{
//  723 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  724 			for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
??BcMFreqStateCheck_61:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_62:
        UXTB     R9,LR
        CMP      R9,R6
        BLT.N    ??BcMFreqStateCheck_61
//  725 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R0, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_60:
        CMP      R7,R5
        BGE.N    ??BcMFreqStateCheck_63
        LDRB     R12,[R0, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_62
//  726 		}
//  727 		TempCopy = -TempCopy;
??BcMFreqStateCheck_63:
        RSBS     R0,R3,#+0
        SXTH     R3,R0
//  728 		BcMRfStatus->RxValue = TempCopy;
        B.N      ??BcMFreqStateCheck_64
//  729 	}
//  730 	else
//  731 	{
//  732 		for ( j=0; j<i; j++ )
??BcMFreqStateCheck_59:
        MOVS     R7,#+0
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_65
//  733 		{
//  734 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  735 			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMFreqStateCheck_66:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_67:
        UXTB     R9,LR
        CMP      R9,R5
        BLT.N    ??BcMFreqStateCheck_66
//  736 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R0, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_65:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_64
        LDRB     R12,[R0, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_67
//  737 		}
//  738 		BcMRfStatus->RxValue = TempCopy;
??BcMFreqStateCheck_64:
        LDR.N    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        STRH     R3,[R0, #+44]
//  739 	}
//  740 	
//  741 	//========================================================================//
//  742 if ( TempCopy > 0 ) return(FALSE);
        CMP      R3,#+1
        BGE.W    ??BcMFreqStateCheck_6
//  743 
//  744 	//==========//
//  745 	// TX Value //
//  746 	//========================================================================//
//  747 	DataCnt2 = DataCnt;
        MOV      R0,R1
//  748 	TempCopy = 0;
        MOVS     R3,#+0
//  749 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R6,#+0
??BcMFreqStateCheck_68:
        ADDS     R4,R1,#+1
        UXTB     R4,R4
        LDRB     R1,[R1, R2]
        CMP      R1,#+44
        MOV      R1,R4
        BEQ.N    ??BcMFreqStateCheck_69
        ADDS     R6,R6,#+1
        UXTB     R4,R6
        CMP      R4,#+10
        BCC.N    ??BcMFreqStateCheck_68
//  750 	if ( DataBuff[DataCnt2] == '-' )
??BcMFreqStateCheck_69:
        UXTB     R4,R6
        LDRB     R5,[R0, R2]
        CMP      R5,#+45
        BNE.N    ??BcMFreqStateCheck_70
//  751 	{
//  752 		DataCnt2++;
        ADDS     R0,R0,#+1
        UXTB     R0,R0
//  753 		for ( j=0; j<i-1; j++ )
        MOVS     R7,#+0
        SUBS     R6,R4,#+2
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_71
//  754 		{
//  755 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  756 			for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
??BcMFreqStateCheck_72:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_73:
        UXTB     R9,LR
        CMP      R9,R6
        BLT.N    ??BcMFreqStateCheck_72
//  757 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R0, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_71:
        CMP      R7,R5
        BGE.N    ??BcMFreqStateCheck_74
        LDRB     R12,[R0, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_73
//  758 		}
//  759 		TempCopy = -TempCopy;
//  760 		BcMRfStatus->TxValue = TempCopy;
??BcMFreqStateCheck_74:
        LDR.N    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        RSBS     R4,R3,#+0
        STRH     R4,[R0, #+46]
        B.N      ??BcMFreqStateCheck_75
//  761 	}
//  762 	else
//  763 	{
//  764 		for ( j=0; j<i; j++ )
??BcMFreqStateCheck_70:
        MOVS     R7,#+0
        SUBS     R5,R4,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_76
//  765 		{
//  766 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  767 			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMFreqStateCheck_77:
        MUL      R12,R12,R4
        SXTH     R12,R12
        ADD      LR,LR,#+1
        UXTB     LR,LR
??BcMFreqStateCheck_78:
        UXTB     R9,LR
        CMP      R9,R5
        BLT.N    ??BcMFreqStateCheck_77
//  768 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     LR,[R0, R2]
        SUB      LR,LR,#+48
        MLA      R3,LR,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_76:
        UXTB     R12,R7
        UXTB     LR,R6
        CMP      R12,LR
        BCS.N    ??BcMFreqStateCheck_79
        LDRB     R12,[R0, R2]
        CMP      R12,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R12,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_78
//  769 		}
//  770 		BcMRfStatus->TxValue = TempCopy;
??BcMFreqStateCheck_79:
        LDR.N    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        STRH     R3,[R0, #+46]
//  771 	}
//  772 
//  773 	//===========//
//  774 	// ADJ Value //
//  775 	//========================================================================//
//  776 	DataCnt2 = DataCnt;
??BcMFreqStateCheck_75:
        MOV      R0,R1
//  777 	TempCopy = 0;
        MOVS     R3,#+0
//  778 	for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == 0x0d ) break;
        MOVS     R6,#+0
??BcMFreqStateCheck_80:
        LDRB     R4,[R1, R2]
        CMP      R4,#+13
        BEQ.N    ??BcMFreqStateCheck_81
        ADDS     R1,R1,#+1
        UXTB     R1,R1
        ADDS     R6,R6,#+1
        UXTB     R4,R6
        CMP      R4,#+10
        BCC.N    ??BcMFreqStateCheck_80
//  779 	if ( DataBuff[DataCnt2] == '-' )
??BcMFreqStateCheck_81:
        UXTB     R1,R6
        LDRB     R4,[R0, R2]
        CMP      R4,#+45
        BNE.N    ??BcMFreqStateCheck_82
//  780 	{
//  781 		DataCnt2++;
        ADDS     R0,R0,#+1
        UXTB     R0,R0
//  782 		for ( j=0; j<i-1; j++ )
        MOVS     R7,#+0
        SUBS     R5,R1,#+2
        SUBS     R1,R1,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_83
//  783 		{
//  784 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  785 			for ( Power=1,pw=j; pw<i-2; pw++ ) Power *= 10;
??BcMFreqStateCheck_84:
        MUL      R6,R12,R4
        SXTH     R12,R6
        ADD      R6,LR,#+1
        UXTB     LR,R6
??BcMFreqStateCheck_85:
        UXTB     R6,LR
        CMP      R6,R5
        BLT.N    ??BcMFreqStateCheck_84
//  786 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     R6,[R0, R2]
        SUBS     R6,R6,#+48
        MLA      R3,R6,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_83:
        CMP      R7,R1
        BGE.N    ??BcMFreqStateCheck_86
        LDRB     R6,[R0, R2]
        CMP      R6,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R6,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_85
//  787 		}
//  788 		TempCopy = -TempCopy;
//  789 		BcMRfStatus->AdjValue = TempCopy;
??BcMFreqStateCheck_86:
        LDR.N    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        RSBS     R1,R3,#+0
        STRH     R1,[R0, #+48]
        B.N      ??BcMFreqStateCheck_87
//  790 		
//  791 	}
//  792 	else
//  793 	{
//  794 		for ( j=0; j<i; j++ )
??BcMFreqStateCheck_82:
        MOVS     R7,#+0
        SUBS     R1,R1,#+1
        MOVS     R4,#+10
        B.N      ??BcMFreqStateCheck_88
//  795 		{
//  796 			if ( (DataBuff[DataCnt2] < 0x30)||(DataBuff[DataCnt2] > 0x39) ) return(FALSE);
//  797 			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMFreqStateCheck_89:
        MUL      R5,R12,R4
        SXTH     R12,R5
        ADD      R5,LR,#+1
        UXTB     LR,R5
??BcMFreqStateCheck_90:
        UXTB     R5,LR
        CMP      R5,R1
        BLT.N    ??BcMFreqStateCheck_89
//  798 			TempCopy = TempCopy + (DataBuff[DataCnt2++]-'0')*Power;
        LDRB     R5,[R0, R2]
        SUBS     R5,R5,#+48
        MLA      R3,R5,R12,R3
        SXTH     R3,R3
        ADDS     R0,R0,#+1
        UXTB     R0,R0
        ADDS     R7,R7,#+1
??BcMFreqStateCheck_88:
        UXTB     R5,R7
        UXTB     R12,R6
        CMP      R5,R12
        BCS.N    ??BcMFreqStateCheck_91
        LDRB     R5,[R0, R2]
        CMP      R5,#+48
        BCC.W    ??BcMFreqStateCheck_6
        CMP      R5,#+58
        BCS.W    ??BcMFreqStateCheck_6
        MOV      R12,#+1
        MOV      LR,R7
        B.N      ??BcMFreqStateCheck_90
//  799 		}
//  800 		BcMRfStatus->AdjValue = TempCopy;
??BcMFreqStateCheck_91:
        LDR.N    R0,??DataTable40  ;; BcMVerNum
        LDR      R0,[R0, #+36]
        STRH     R3,[R0, #+48]
//  801 	}
//  802 	//========================================================================//
//  803 	
//  804 	return(TRUE);
??BcMFreqStateCheck_87:
        MOVS     R0,#+1
        REQUIRE ?Subroutine4
        ;; // Fall through to label ?Subroutine4
//  805 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine4:
        ADD      SP,SP,#+12
        POP      {R4-R11,PC}      ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable40:
        DC32     BcMVerNum
//  806 
//  807 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  808 INT8S BcMPilotStateCheck ( INT8U *DataBuff )
//  809 {
BcMPilotStateCheck:
        PUSH     {R4-R8,LR}
//  810 	INT8U 	i, j, DataCnt=0, DataCnt2=0, pw;
//  811 	INT8U   k;
//  812 	INT16S		TempCopy, Power;
//  813 
//  814 	//============================//
//  815 	// Active Channel Ec/Io Value //
//  816 	//========================================================================//
//  817 
//  818 
//  819 #if 1
//  820 		DataCnt = 0;
        MOVS     R6,#+0
//  821 		TempCopy = 0;
        MOVS     R1,#+0
//  822 
//  823 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOV      R3,R1
        MOV      R2,R0
??BcMPilotStateCheck_0:
        ADDS     R6,R6,#+1
        UXTB     R6,R6
        LDRB     R4,[R2], #+1
        CMP      R4,#+44
        BEQ.N    ??BcMPilotStateCheck_1
        ADDS     R3,R3,#+1
        UXTB     R4,R3
        CMP      R4,#+10
        BCC.N    ??BcMPilotStateCheck_0
//  824 
//  825 		for ( j=0; j<(DataCnt-1); j++ )
??BcMPilotStateCheck_1:
        MOVS     R2,#+0
        SUBS     R7,R6,#+1
        CMP      R7,#+1
        BLT.N    ??BcMPilotStateCheck_2
        MOV      R12,R0
        UXTB     R3,R3
        SUB      LR,R3,#+1
        MOVS     R3,#+10
//  826 		{
//  827 			for ( Power=1,pw=j; pw<i-1; pw++ ) Power *= 10;
??BcMPilotStateCheck_3:
        MOVS     R4,#+1
        MOV      R5,R2
        B.N      ??BcMPilotStateCheck_4
??BcMPilotStateCheck_5:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
        UXTB     R5,R5
??BcMPilotStateCheck_4:
        UXTB     R8,R5
        CMP      R8,LR
        BLT.N    ??BcMPilotStateCheck_5
//  828 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R12], #+1
        SUBS     R5,R5,#+48
        MLA      R1,R5,R4,R1
        SXTH     R1,R1
//  829 		}
        ADDS     R2,R2,#+1
        CMP      R2,R7
        BLT.N    ??BcMPilotStateCheck_3
//  830 		BcMPilotStatus->PN_Vaule[0] = TempCopy;
??BcMPilotStateCheck_2:
        LDR.N    R2,??BcMPilotStateCheck_6  ;; BcMPilotStatus
        LDR      R2,[R2, #+0]
        STRH     R1,[R2, #+0]
//  831 //		Ser0Printf("BcMPilotStatus->PN_Vaule0:[%d] \n ",BcMPilotStatus->PN_Vaule[0]);
//  832 
//  833 		DataBuff[DataCnt++];
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  834 
//  835 		DataCnt2 = DataCnt;
        MOV      R3,R6
        MOV      R1,R3
//  836 		TempCopy = 0;
        MOVS     R7,#+0
//  837 		k = DataCnt;		
//  838 
//  839 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R4,#+0
??BcMPilotStateCheck_7:
        ADDS     R5,R6,#+1
        UXTB     R5,R5
        LDRB     R6,[R6, R0]
        CMP      R6,#+44
        MOV      R6,R5
        BEQ.N    ??BcMPilotStateCheck_8
        ADDS     R4,R4,#+1
        UXTB     R5,R4
        CMP      R5,#+10
        BCC.N    ??BcMPilotStateCheck_7
//  840 		for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
??BcMPilotStateCheck_8:
        MOVS     R4,#+0
??BcMPilotStateCheck_9:
        ADDS     R5,R3,#+1
        UXTB     R5,R5
        LDRB     R3,[R3, R0]
        CMP      R3,#+46
        MOV      R3,R5
        BEQ.N    ??BcMPilotStateCheck_10
        ADDS     R4,R4,#+1
        UXTB     R5,R4
        CMP      R5,#+10
        BCC.N    ??BcMPilotStateCheck_9
//  841 
//  842 		for ( j = DataCnt2; j < (k-1); j++ )
??BcMPilotStateCheck_10:
        MOV      R12,R1
        SUB      LR,R3,#+1
        UXTB     R4,R4
        SUB      R8,R4,#+1
        MOVS     R3,#+10
        B.N      ??BcMPilotStateCheck_11
//  843 		{
//  844 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
??BcMPilotStateCheck_12:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
??BcMPilotStateCheck_13:
        UXTB     R5,R5
        CMP      R5,R8
        BLT.N    ??BcMPilotStateCheck_12
//  845 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R12, R0]
        SUBS     R5,R5,#+48
        MLA      R7,R5,R4,R7
        SXTH     R7,R7
        ADD      R4,R12,#+1
        UXTB     R12,R4
??BcMPilotStateCheck_11:
        CMP      R12,LR
        BGE.N    ??BcMPilotStateCheck_14
        MOVS     R4,#+1
        SUB      R5,R12,R1
        B.N      ??BcMPilotStateCheck_13
//  846 		}
//  847 		BcMPilotStatus->EcIo[0] = TempCopy;
??BcMPilotStateCheck_14:
        STRH     R7,[R2, #+8]
//  848 		
//  849 //		Ser0Printf("BcMPilotStatus->EcIo:[%d] \n",BcMPilotStatus->EcIo[0]);
//  850 
//  851 
//  852 		DataCnt2 = DataCnt;
        MOV      R1,R6
//  853 		TempCopy = 0;
        MOVS     R7,#+0
//  854 
//  855 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R3,#+0
??BcMPilotStateCheck_15:
        ADDS     R4,R6,#+1
        UXTB     R4,R4
        LDRB     R5,[R6, R0]
        CMP      R5,#+44
        MOV      R6,R4
        BEQ.N    ??BcMPilotStateCheck_16
        ADDS     R3,R3,#+1
        UXTB     R4,R3
        CMP      R4,#+10
        BCC.N    ??BcMPilotStateCheck_15
//  856 
//  857 		for ( j=DataCnt2; j<(DataCnt-1); j++ )
??BcMPilotStateCheck_16:
        MOV      R12,R1
        SUB      LR,R6,#+1
        UXTB     R3,R3
        SUB      R8,R3,#+1
        MOVS     R3,#+10
        B.N      ??BcMPilotStateCheck_17
//  858 		{
//  859 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
??BcMPilotStateCheck_18:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
??BcMPilotStateCheck_19:
        UXTB     R5,R5
        CMP      R5,R8
        BLT.N    ??BcMPilotStateCheck_18
//  860 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R12, R0]
        SUBS     R5,R5,#+48
        MLA      R7,R5,R4,R7
        SXTH     R7,R7
        ADD      R4,R12,#+1
        UXTB     R12,R4
??BcMPilotStateCheck_17:
        CMP      R12,LR
        BGE.N    ??BcMPilotStateCheck_20
        MOVS     R4,#+1
        SUB      R5,R12,R1
        B.N      ??BcMPilotStateCheck_19
//  861 		}
//  862 		BcMPilotStatus->PN_Vaule[1] = TempCopy;
??BcMPilotStateCheck_20:
        STRH     R7,[R2, #+2]
//  863 //		Ser0Printf("BcMPilotStatus->PN_Vaule1:[%d]\n ",BcMPilotStatus->PN_Vaule[1]);
//  864 
//  865 		{
//  866 			
//  867  		DataBuff[DataCnt++];
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  868 		DataCnt2 = DataCnt;
        MOV      R3,R6
        MOV      R1,R3
//  869 		TempCopy = 0;
        MOVS     R7,#+0
//  870 		k = DataCnt;		
//  871 
//  872 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R4,#+0
??BcMPilotStateCheck_21:
        ADDS     R5,R6,#+1
        UXTB     R5,R5
        LDRB     R6,[R6, R0]
        CMP      R6,#+44
        MOV      R6,R5
        BEQ.N    ??BcMPilotStateCheck_22
        ADDS     R4,R4,#+1
        UXTB     R5,R4
        CMP      R5,#+10
        BCC.N    ??BcMPilotStateCheck_21
//  873 		for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
??BcMPilotStateCheck_22:
        MOVS     R4,#+0
??BcMPilotStateCheck_23:
        ADDS     R5,R3,#+1
        UXTB     R5,R5
        LDRB     R3,[R3, R0]
        CMP      R3,#+46
        MOV      R3,R5
        BEQ.N    ??BcMPilotStateCheck_24
        ADDS     R4,R4,#+1
        UXTB     R5,R4
        CMP      R5,#+10
        BCC.N    ??BcMPilotStateCheck_23
//  874 
//  875 		for ( j = DataCnt2; j < (k-1); j++ )
??BcMPilotStateCheck_24:
        MOV      R12,R1
        SUB      LR,R3,#+1
        UXTB     R4,R4
        SUB      R8,R4,#+1
        MOVS     R3,#+10
        B.N      ??BcMPilotStateCheck_25
//  876 		{
//  877 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
??BcMPilotStateCheck_26:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
??BcMPilotStateCheck_27:
        UXTB     R5,R5
        CMP      R5,R8
        BLT.N    ??BcMPilotStateCheck_26
//  878 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R12, R0]
        SUBS     R5,R5,#+48
        MLA      R7,R5,R4,R7
        SXTH     R7,R7
        ADD      R4,R12,#+1
        UXTB     R12,R4
??BcMPilotStateCheck_25:
        CMP      R12,LR
        BGE.N    ??BcMPilotStateCheck_28
        MOVS     R4,#+1
        SUB      R5,R12,R1
        B.N      ??BcMPilotStateCheck_27
//  879 		}
//  880 		BcMPilotStatus->EcIo[1] = TempCopy;
??BcMPilotStateCheck_28:
        STRH     R7,[R2, #+10]
//  881 		
//  882 //		Ser0Printf("BcMPilotStatus->EcIo1:[%d] \n",BcMPilotStatus->EcIo[1]);
//  883 
//  884 
//  885 		DataCnt2 = DataCnt;
        MOV      R1,R6
//  886 		TempCopy = 0;
        MOVS     R7,#+0
//  887 
//  888 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R3,#+0
??BcMPilotStateCheck_29:
        ADDS     R4,R6,#+1
        UXTB     R4,R4
        LDRB     R5,[R6, R0]
        CMP      R5,#+44
        MOV      R6,R4
        BEQ.N    ??BcMPilotStateCheck_30
        ADDS     R3,R3,#+1
        UXTB     R4,R3
        CMP      R4,#+10
        BCC.N    ??BcMPilotStateCheck_29
//  889 		for ( j=DataCnt2; j<(DataCnt-1); j++ )
??BcMPilotStateCheck_30:
        MOV      R12,R1
        SUB      LR,R6,#+1
        UXTB     R3,R3
        SUB      R8,R3,#+1
        MOVS     R3,#+10
        B.N      ??BcMPilotStateCheck_31
//  890 		{
//  891 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
??BcMPilotStateCheck_32:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
??BcMPilotStateCheck_33:
        UXTB     R5,R5
        CMP      R5,R8
        BLT.N    ??BcMPilotStateCheck_32
//  892 
//  893 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R12, R0]
        SUBS     R5,R5,#+48
        MLA      R7,R5,R4,R7
        SXTH     R7,R7
        ADD      R4,R12,#+1
        UXTB     R12,R4
??BcMPilotStateCheck_31:
        CMP      R12,LR
        BGE.N    ??BcMPilotStateCheck_34
        MOVS     R4,#+1
        SUB      R5,R12,R1
        B.N      ??BcMPilotStateCheck_33
//  894 			
//  895 		}
//  896 		BcMPilotStatus->PN_Vaule[2] = TempCopy;
??BcMPilotStateCheck_34:
        STRH     R7,[R2, #+4]
//  897 //		Ser0Printf("BcMPilotStatus->PN_Vaule2:[%d] \n",BcMPilotStatus->PN_Vaule[2]);
//  898 
//  899 		}
//  900 
//  901 		
//  902 		DataBuff[DataCnt++];
        ADDS     R6,R6,#+1
        UXTB     R6,R6
//  903 
//  904 		DataCnt2 = DataCnt;
        MOV      R3,R6
        MOV      R1,R3
//  905 		TempCopy = 0;
        MOVS     R7,#+0
//  906 		k = DataCnt;		
//  907 
//  908 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R4,#+0
??BcMPilotStateCheck_35:
        ADDS     R5,R6,#+1
        UXTB     R5,R5
        LDRB     R6,[R6, R0]
        CMP      R6,#+44
        MOV      R6,R5
        BEQ.N    ??BcMPilotStateCheck_36
        ADDS     R4,R4,#+1
        UXTB     R5,R4
        CMP      R5,#+10
        BCC.N    ??BcMPilotStateCheck_35
//  909 		for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
??BcMPilotStateCheck_36:
        MOVS     R4,#+0
??BcMPilotStateCheck_37:
        ADDS     R5,R3,#+1
        UXTB     R5,R5
        LDRB     R3,[R3, R0]
        CMP      R3,#+46
        MOV      R3,R5
        BEQ.N    ??BcMPilotStateCheck_38
        ADDS     R4,R4,#+1
        UXTB     R5,R4
        CMP      R5,#+10
        BCC.N    ??BcMPilotStateCheck_37
//  910 
//  911 		for ( j = DataCnt2; j < (k-1); j++ )
??BcMPilotStateCheck_38:
        MOV      R12,R1
        SUB      LR,R3,#+1
        UXTB     R4,R4
        SUB      R8,R4,#+1
        MOVS     R3,#+10
        B.N      ??BcMPilotStateCheck_39
//  912 		{
//  913 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
??BcMPilotStateCheck_40:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
??BcMPilotStateCheck_41:
        UXTB     R5,R5
        CMP      R5,R8
        BLT.N    ??BcMPilotStateCheck_40
//  914 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R12, R0]
        SUBS     R5,R5,#+48
        MLA      R7,R5,R4,R7
        SXTH     R7,R7
        ADD      R4,R12,#+1
        UXTB     R12,R4
??BcMPilotStateCheck_39:
        CMP      R12,LR
        BGE.N    ??BcMPilotStateCheck_42
        MOVS     R4,#+1
        SUB      R5,R12,R1
        B.N      ??BcMPilotStateCheck_41
//  915 		}
//  916 		BcMPilotStatus->EcIo[2] = TempCopy;
??BcMPilotStateCheck_42:
        STRH     R7,[R2, #+12]
//  917 		
//  918 //		Ser0Printf("BcMPilotStatus->EcIo2:[%d] \n",BcMPilotStatus->EcIo[2]);
//  919 
//  920 
//  921 		DataCnt2 = DataCnt;
        MOV      R1,R6
//  922 		TempCopy = 0;
        MOVS     R7,#+0
//  923 
//  924 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R3,#+0
??BcMPilotStateCheck_43:
        ADDS     R4,R6,#+1
        UXTB     R4,R4
        LDRB     R5,[R6, R0]
        CMP      R5,#+44
        MOV      R6,R4
        BEQ.N    ??BcMPilotStateCheck_44
        ADDS     R3,R3,#+1
        UXTB     R4,R3
        CMP      R4,#+10
        BCC.N    ??BcMPilotStateCheck_43
//  925 
//  926 		for ( j=DataCnt2; j<(DataCnt-1); j++ )
??BcMPilotStateCheck_44:
        MOV      R12,R1
        SUB      LR,R6,#+1
        UXTB     R3,R3
        SUB      R8,R3,#+1
        MOVS     R3,#+10
        B.N      ??BcMPilotStateCheck_45
//  927 		{
//  928 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
??BcMPilotStateCheck_46:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
??BcMPilotStateCheck_47:
        UXTB     R5,R5
        CMP      R5,R8
        BLT.N    ??BcMPilotStateCheck_46
//  929 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R12, R0]
        SUBS     R5,R5,#+48
        MLA      R7,R5,R4,R7
        SXTH     R7,R7
        ADD      R4,R12,#+1
        UXTB     R12,R4
??BcMPilotStateCheck_45:
        CMP      R12,LR
        BGE.N    ??BcMPilotStateCheck_48
        MOVS     R4,#+1
        SUB      R5,R12,R1
        B.N      ??BcMPilotStateCheck_47
//  930 		}
//  931 
//  932 		BcMPilotStatus->PN_Vaule[3] = TempCopy;
??BcMPilotStateCheck_48:
        STRH     R7,[R2, #+6]
//  933 //		Ser0Printf("BcMPilotStatus->PN_Vaule3:[%d]\n  ",BcMPilotStatus->PN_Vaule[3]);
//  934 
//  935 		
//  936 		DataBuff[DataCnt++];
        ADDS     R3,R6,#+1
        UXTB     R3,R3
//  937 
//  938 		DataCnt2 = DataCnt;
        MOV      R4,R3
        MOV      R1,R4
//  939 		TempCopy = 0;
        MOVS     R6,#+0
//  940 		k = DataCnt;		
//  941 
//  942 		for ( i=0; i<10; i++ ) if ( DataBuff[DataCnt++] == ',' ) break;
        MOVS     R5,#+0
??BcMPilotStateCheck_49:
        LDRB     R7,[R3, R0]
        CMP      R7,#+44
        BEQ.N    ??BcMPilotStateCheck_50
        ADDS     R3,R3,#+1
        UXTB     R3,R3
        ADDS     R5,R5,#+1
        UXTB     R7,R5
        CMP      R7,#+10
        BCC.N    ??BcMPilotStateCheck_49
//  943 		for ( i=0; i<10; i++ ) if ( DataBuff[k++] == '.' ) break;
??BcMPilotStateCheck_50:
        MOVS     R3,#+0
??BcMPilotStateCheck_51:
        ADDS     R5,R4,#+1
        UXTB     R5,R5
        LDRB     R4,[R4, R0]
        CMP      R4,#+46
        MOV      R4,R5
        BEQ.N    ??BcMPilotStateCheck_52
        ADDS     R3,R3,#+1
        UXTB     R5,R3
        CMP      R5,#+10
        BCC.N    ??BcMPilotStateCheck_51
//  944 
//  945 		for ( j = DataCnt2; j < (k-1); j++ )
??BcMPilotStateCheck_52:
        MOV      R7,R1
        SUB      R12,R4,#+1
        UXTB     R3,R3
        SUB      LR,R3,#+1
        MOVS     R3,#+10
        B.N      ??BcMPilotStateCheck_53
//  946 		{
//  947 			for ( Power=1,pw = (j - DataCnt2) ; pw < (i - 1); pw++ ) Power =  Power * 10;
??BcMPilotStateCheck_54:
        MULS     R4,R4,R3
        SXTH     R4,R4
        ADDS     R5,R5,#+1
??BcMPilotStateCheck_55:
        UXTB     R5,R5
        CMP      R5,LR
        BLT.N    ??BcMPilotStateCheck_54
//  948 			TempCopy = TempCopy + (DataBuff[j]-'0')*Power;
        LDRB     R5,[R7, R0]
        SUBS     R5,R5,#+48
        MLA      R6,R5,R4,R6
        SXTH     R6,R6
        ADDS     R7,R7,#+1
        UXTB     R7,R7
??BcMPilotStateCheck_53:
        CMP      R7,R12
        BGE.N    ??BcMPilotStateCheck_56
        MOVS     R4,#+1
        SUBS     R5,R7,R1
        B.N      ??BcMPilotStateCheck_55
//  949 		}
//  950 		BcMPilotStatus->EcIo[3] = TempCopy;
??BcMPilotStateCheck_56:
        STRH     R6,[R2, #+14]
//  951 		
//  952 //		Ser0Printf("BcMPilotStatus->EcIo3:[%d] \n",BcMPilotStatus->EcIo[3]);
//  953 #endif
//  954 	return(TRUE);
        B.W      ?Subroutine1
        Nop      
        DATA
??BcMPilotStateCheck_6:
        DC32     BcMPilotStatus
//  955 
//  956 }
//  957 
//  958 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  959 INT32S BcMdemTcpConnect(INT8U *ConnectIP, INT8U IPLen, INT32U PortNum)
//  960 {
BcMdemTcpConnect:
        PUSH     {R4-R10,LR}
        MOV      R5,R0
        MOV      R9,R2
//  961     INT8U CmdStep = 0,result = 0;
        MOVS     R7,#+0
//  962 
//  963 	CmdStep = ModemTcpModeCmd;
        MOVS     R4,#+12
        MOV      R6,R1
        LDR.W    R8,??BcMdemTcpConnect_0  ;; RxCdmaData
        LDR.W    R10,??BcMdemTcpConnect_0+0x4  ;; `?<Constant "AT+CRM=251">`
        B.N      ??BcMdemTcpConnect_1
//  964 	
//  965 TCP_INIT_SEQUENCE : 
//  966 
//  967 	switch(CmdStep)
//  968 	{
//  969 		case ModemTcpModeCmd: 	BcMdemXmit(CdmaModemTcpModeCmd); 	result = 0; break;
//  970 		//case ModemTcpIdCmd: 	BcMdemXmit(CdmaModemTcpIdCmd); 		result = 0; break;
//  971 		//case ModemTcpPwCmd: 	BcMdemXmit(CdmaModemTcpPwCmd); 		result = 0; break;
//  972 		case ModemTcpConnect: 	BcMdemXmit(CdmaModemTcpConnect); 	result = 1; break;
//  973 		case ModemTcpOpenCmd: 	
//  974 
//  975 			ConnectIP[IPLen] = 0; //Insert Null
//  976 			sprintf((char *)TxCdmaData, "%s%s,%d", CdmaModemTcpOpenCmd,ConnectIP, PortNum);
//  977 
//  978 			BcMdemXmit((INT8U *)TxCdmaData);
//  979 			result = 2; 
//  980 		break;
//  981 	}
//  982 		
//  983 	switch(result)
//  984 	{
//  985 		case 0:
//  986 			if(BcMdemSyncProtocolCheck())
//  987 			{
//  988 				if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE;
//  989 			}
//  990 			else return FALSE;
//  991 		break;
//  992 
//  993 		case 1:
//  994 						
//  995 			if(BcMdemSyncProtocolCheck())
//  996 			{
//  997 				if(BcMdemSyncCheck((char *)RxCdmaData) != 11)return FALSE;
//  998 			}
//  999 			else return FALSE;
// 1000 		break;
// 1001 
// 1002 		case 2:
// 1003 			if(BcMdemSyncProtocolCheck())
// 1004 			{
// 1005 				if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE;
// 1006 			}
// 1007 			else return FALSE;
// 1008 			
// 1009 			if(BcMdemSyncProtocolCheck())
// 1010 			{	
// 1011 				if(BcMdemSyncCheck((char *)RxCdmaData) != 18)return FALSE;
// 1012 			}
// 1013 			else return FALSE;
// 1014 		break;
// 1015 		
// 1016 	}
// 1017 
// 1018 	if(CmdStep == ModemTcpOpenCmd)return TRUE;
// 1019 
// 1020 	CmdStep++;
??BcMdemTcpConnect_2:
        ADDS     R4,R4,#+1
        UXTB     R4,R4
// 1021 	
// 1022 	goto TCP_INIT_SEQUENCE;
??BcMdemTcpConnect_1:
        CMP      R4,#+12
        BEQ.N    ??BcMdemTcpConnect_3
        CMP      R4,#+13
        BEQ.N    ??BcMdemTcpConnect_4
        CMP      R4,#+14
        BEQ.N    ??BcMdemTcpConnect_5
        B.N      ??BcMdemTcpConnect_6
??BcMdemTcpConnect_3:
        MOV      R0,R10
        BL       BcMdemXmit
        MOVS     R7,#+0
        B.N      ??BcMdemTcpConnect_7
??BcMdemTcpConnect_4:
        LDR.N    R0,??BcMdemTcpConnect_0+0x8  ;; `?<Constant "AT+CRM=251">` + 12
        BL       BcMdemXmit
        MOVS     R7,#+1
??BcMdemTcpConnect_8:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTcpConnect_9
        MOV      R0,R8
        BL       BcMdemSyncCheck
        CMP      R0,#+11
        BNE.N    ??BcMdemTcpConnect_9
        B.N      ??BcMdemTcpConnect_10
??BcMdemTcpConnect_5:
        MOVS     R0,#+0
        STRB     R0,[R6, R5]
        ADD      R7,R8,#+516
        PUSH     {R9,LR}
        MOV      R3,R5
        ADD      R2,R10,#+32
        ADD      R1,R10,#+24
        MOV      R0,R7
        BL       sprintf
        ADD      SP,SP,#+8
        MOV      R0,R7
        BL       BcMdemXmit
        MOVS     R7,#+2
??BcMdemTcpConnect_11:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTcpConnect_9
        MOV      R0,R8
        BL       BcMdemSyncCheck
        CMP      R0,#+14
        BNE.N    ??BcMdemTcpConnect_9
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTcpConnect_9
        MOV      R0,R8
        BL       BcMdemSyncCheck
        CMP      R0,#+18
        BNE.N    ??BcMdemTcpConnect_9
??BcMdemTcpConnect_10:
        CMP      R4,#+14
        BNE.N    ??BcMdemTcpConnect_2
        MOVS     R0,#+1
        POP      {R4-R10,PC}      ;; return
??BcMdemTcpConnect_6:
        CBZ      R7,??BcMdemTcpConnect_7
        CMP      R7,#+2
        BEQ.N    ??BcMdemTcpConnect_11
        BCC.N    ??BcMdemTcpConnect_8
        B.N      ??BcMdemTcpConnect_10
??BcMdemTcpConnect_7:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTcpConnect_9
        MOV      R0,R8
        BL       BcMdemSyncCheck
        CMP      R0,#+14
        BEQ.N    ??BcMdemTcpConnect_10
??BcMdemTcpConnect_9:
        MOVS     R0,#+0
        POP      {R4-R10,PC}
        Nop      
        DATA
??BcMdemTcpConnect_0:
        DC32     RxCdmaData
        DC32     `?<Constant "AT+CRM=251">`
        DC32     `?<Constant "AT+CRM=251">` + 12
// 1023 	
// 1024 }
// 1025 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1026 INT32S BcMdemTcpExit(void)
// 1027 { 
BcMdemTcpExit:
        PUSH     {R3-R5,LR}
// 1028 	INT8U nRet = TRUE;
// 1029 	
// 1030 	BcMdemXmit(CdmaModemTcpCloseCmd);
        LDR.N    R4,??BcMdemTcpExit_0  ;; `?<Constant "AT$TCPCLOSE">`
        MOV      R0,R4
        BL       BcMdemXmit
// 1031 	if(!BcMdemSyncProtocolCheck()) return FALSE;
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BNE.N    ??BcMdemTcpExit_1
??BcMdemTcpExit_2:
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
// 1032 	if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return 1;
??BcMdemTcpExit_1:
        LDR.N    R5,??BcMdemTcpExit_0+0x4  ;; RxCdmaData
        MOV      R0,R5
        BL       BcMdemSyncCheck
        CMP      R0,#+14
        BNE.N    ??BcMdemTcpExit_3
// 1033 	if(!BcMdemSyncProtocolCheck()) return FALSE;
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTcpExit_2
// 1034 	if(BcMdemSyncCheck((char *)RxCdmaData) != 26)return 2;
        MOV      R0,R5
        BL       BcMdemSyncCheck
        CMP      R0,#+26
        BEQ.N    ??BcMdemTcpExit_4
        MOVS     R0,#+2
        POP      {R1,R4,R5,PC}
// 1035 
// 1036 	BcMdemXmit(CdmaModemTcpExitCmd);
??BcMdemTcpExit_4:
        ADD      R0,R4,#+12
        BL       BcMdemXmit
// 1037 	if(!BcMdemSyncProtocolCheck()) return FALSE;
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTcpExit_2
// 1038 	if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return 3;
        MOV      R0,R5
        BL       BcMdemSyncCheck
        CMP      R0,#+14
        BEQ.N    ??BcMdemTcpExit_5
        MOVS     R0,#+3
        POP      {R1,R4,R5,PC}
// 1039 	if(!BcMdemSyncProtocolCheck()) return FALSE;
??BcMdemTcpExit_5:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemTcpExit_2
// 1040 	if(BcMdemSyncCheck((char *)RxCdmaData) != 12)return 4;
        MOV      R0,R5
        BL       BcMdemSyncCheck
        CMP      R0,#+12
        BEQ.N    ??BcMdemTcpExit_3
        MOVS     R0,#+4
        POP      {R1,R4,R5,PC}
// 1041 
// 1042 	return nRet;
??BcMdemTcpExit_3:
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}    ;; return
        DATA
??BcMdemTcpExit_0:
        DC32     `?<Constant "AT$TCPCLOSE">`
        DC32     RxCdmaData
// 1043 }	
// 1044 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1045 INT32S BcMdemSwReset(void)
// 1046 { 
BcMdemSwReset:
        PUSH     {R7,LR}
// 1047 	BcMdemXmit(CdmaModemSwRstCmd);
        LDR.N    R0,??BcMdemSwReset_0  ;; `?<Constant "AT*SKT*RESET">`
        BL       BcMdemXmit
// 1048 
// 1049 /**
// 1050 	if(BcMdemSyncProtocolCheck())
// 1051 	{
// 1052 		if(BcMdemSyncCheck((char *)RxCdmaData) != 27)return FALSE;
// 1053 	}
// 1054 	else return FALSE;
// 1055 
// 1056 	OSTimeDly(10L);
// 1057 
// 1058 	if(BcMdemSyncProtocolCheck())
// 1059 	{
// 1060 		if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE;
// 1061 	}
// 1062 	else return FALSE;
// 1063 
// 1064 	return nRet;
// 1065 **/
// 1066 	return TRUE;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
        DATA
??BcMdemSwReset_0:
        DC32     `?<Constant "AT*SKT*RESET">`
// 1067 }	
// 1068 
// 1069 // RETRUN DEFINE
// 1070 // -1 : *SKT*ORI Error
// 1071 // -2 : OK Error
// 1072 // -3 : *SKT*VCALL Error
// 1073 // -4 : *SKT*VOICECONNECT Error
// 1074 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1075 INT32S BcMdemCalling(char *DstTel)
// 1076 { 
BcMdemCalling:
        PUSH     {R4-R7,LR}
        SUB      SP,SP,#+100
        MOV      R4,R0
// 1077 	INT16U i = 0, j = 0;
// 1078 	INT8U Ptr[100];
// 1079 	INT32S nRet = TRUE;
// 1080 	
// 1081 	sprintf((char *)TxCdmaData, "%s%s", CdmaCallingCmd, DstTel);
        LDR.N    R5,??BcMdemCalling_0  ;; RxCdmaData
        ADD      R6,R5,#+516
        LDR.N    R1,??BcMdemCalling_0+0x4  ;; `?<Constant "%s%s">`
        MOV      R3,R4
        ADD      R2,R1,#+8
        MOV      R0,R6
        BL       sprintf
// 1082 
// 1083 	BcMdemXmit((INT8U *)TxCdmaData);
        MOV      R0,R6
        BL       BcMdemXmit
// 1084 
// 1085 	if(BcMdemSyncProtocolCheck()) // *SKT*ORI=
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemCalling_1
// 1086 	{
// 1087 		if(BcMdemSyncCheck((char *)RxCdmaData) != 33)return -1; 
        MOV      R0,R5
        BL       BcMdemSyncCheck
        CMP      R0,#+33
        BEQ.N    ??BcMdemCalling_2
??BcMdemCalling_1:
        MOV      R0,#-1
        ADD      SP,SP,#+100
        POP      {R4-R7,PC}
// 1088 	}
// 1089 	else return -1;
// 1090 
// 1091 	if(BcMdemSyncProtocolCheck()) // OK
??BcMdemCalling_2:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemCalling_3
// 1092 	{
// 1093 		if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return -2; 
        MOV      R0,R5
        BL       BcMdemSyncCheck
        CMP      R0,#+14
        BEQ.N    ??BcMdemCalling_4
??BcMdemCalling_3:
        MVN      R0,#+1
        ADD      SP,SP,#+100
        POP      {R4-R7,PC}
// 1094 	}
// 1095 	else return -2;
// 1096 	
// 1097 	if(BcMdemSyncProtocolCheck()) // *SKT*VCALL:
??BcMdemCalling_4:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemCalling_5
// 1098 	{
// 1099 		for(i = 0; i < strlen(RspmsgCallAck);i++)Ptr[i] = RxCdmaData[i];
        MOVS     R2,#+11
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
        MOVS     R6,#+11
// 1100 		Ptr[i] = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+11]
// 1101 		if(BcMdemSyncCheck((char *)Ptr) != 28)return -3;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+28
        BEQ.N    ??BcMdemCalling_6
??BcMdemCalling_5:
        MVN      R0,#+2
        ADD      SP,SP,#+100
        POP      {R4-R7,PC}
// 1102 		
// 1103 		for(j = 0; j < strlen(DstTel); j++, i++)
??BcMdemCalling_6:
        MOVS     R7,#+0
        B.N      ??BcMdemCalling_7
// 1104 		{
// 1105 			if(DstTel[j] != RxCdmaData[i])return -3;
??BcMdemCalling_8:
        LDRB     R0,[R7, R4]
        LDRB     R1,[R6, R5]
        CMP      R0,R1
        BNE.N    ??BcMdemCalling_5
// 1106 		}
        ADDS     R7,R7,#+1
        UXTH     R7,R7
        ADDS     R6,R6,#+1
        UXTH     R6,R6
??BcMdemCalling_7:
        MOV      R0,R4
        BL       strlen
        CMP      R7,R0
        BCC.N    ??BcMdemCalling_8
// 1107 	}
// 1108 	else return -3;
// 1109 
// 1110 	if(BcMdemSyncProtocolCheck()) // *SKT*VOICECONNECT
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemCalling_9
// 1111 	{
// 1112 		if(BcMdemSyncCheck((char *)RxCdmaData) != 29)return -4; 
        MOV      R0,R5
        BL       BcMdemSyncCheck
        CMP      R0,#+29
        BNE.N    ??BcMdemCalling_9
// 1113 	}
// 1114 	else return -4;
// 1115 	
// 1116 	return nRet;
        MOVS     R0,#+1
        ADD      SP,SP,#+100
        POP      {R4-R7,PC}
??BcMdemCalling_9:
        MVN      R0,#+3
        ADD      SP,SP,#+100
        POP      {R4-R7,PC}       ;; return
        Nop      
        DATA
??BcMdemCalling_0:
        DC32     RxCdmaData
        DC32     `?<Constant "%s%s">`
// 1117 }
// 1118 
// 1119 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1120 INT32S CdmaModemTrafficCheck(void)
// 1121 { 
CdmaModemTrafficCheck:
        PUSH     {R7,LR}
// 1122 	INT8U nRet = TRUE;
// 1123 	
// 1124 	nRet = BcMdemCommad(ModemTrafficCmd);
        MOVS     R0,#+8
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
// 1125 
// 1126 	return nRet;
// 1127 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        BL       BcMdemCommad
        UXTB     R0,R0
        POP      {R1,PC}          ;; return
// 1128 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1129 INT32S CdmaModemHangUp(void)
// 1130 { 
CdmaModemHangUp:
        PUSH     {R7,LR}
// 1131 	INT8U nRet = TRUE;
// 1132 	
// 1133 	nRet = BcMdemCommad(ModemHangUpCmd);
        MOVS     R0,#+1
        B.N      ?Subroutine0
// 1134 
// 1135 	return nRet;
// 1136 }
// 1137 
// 1138 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1139 INT32S BcMdemCommad(INT8U Commad)
// 1140 {
BcMdemCommad:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+104
        MOV      R5,R0
// 1141 	INT16U i = 0;
// 1142 	INT32S nlen = 0;
// 1143 	INT32S nRet = 0;
        MOVS     R4,#+0
// 1144 	INT8U Ptr[100];
// 1145 	
// 1146 	
// 1147 	switch(Commad)
        SUBS     R0,R0,#+1
        CMP      R0,#+16
        BHI.N    ??BcMdemCommad_1
        TBB      [PC, R0]
        DATA
??BcMdemCommad_0:
        DC8      +41,+45,+45,+45
        DC8      +45,+37,+39,+37
        DC8      +35,+9,+45,+45
        DC8      +45,+45,+45,+45
        DC8      +43,+0
        THUMB
// 1148 	{
// 1149 		case MsgReciveCmd: 		BcMdemXmit(CdmaMsgReciveCmd); 	break;
??BcMdemCommad_2:
        LDR.N    R0,??BcMdemCommad_3  ;; `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 108
??BcMdemCommad_4:
        BL       BcMdemXmit
// 1150 		case MsgCheckCmd: 		BcMdemXmit(CdmaMsgCheckCmd); 	break;
// 1151 		case ModemTimeCmd: 		BcMdemXmit(CdmaModemTimeCmd); 	break;
// 1152 		case ModemRfStsCmd: 	BcMdemXmit(CdmaModemRfStsCmd); 	break;
// 1153 		case ModemHangUpCmd: 	BcMdemXmit(CdmaModemHangUpCmd); break;
// 1154 		case ModemTrafficCmd:	BcMdemXmit(CdmaModemTrafficCmd);break;
// 1155 		case ModemPilotCmd: 	BcMdemXmit(CdmaModemPilotCmd); 	break; 
// 1156 		default : return FALSE;
// 1157 	}
// 1158 
// 1159 	switch(Commad)
        SUBS     R6,R5,#+1
        BEQ.N    ??BcMdemCommad_5
        SUBS     R6,R6,#+5
        CMP      R6,#+3
        BLS.N    ??BcMdemCommad_6
        SUBS     R6,R6,#+4
        BEQ.N    ??BcMdemCommad_7
        SUBS     R6,R6,#+7
        BEQ.N    ??BcMdemCommad_6
        B.N      ??BcMdemCommad_8
// 1160 	{
// 1161 		case MsgReciveCmd:
// 1162 		
// 1163 			if((nlen = BcMdemSyncProtocolCheck()) != FALSE)
??BcMdemCommad_7:
        BL       BcMdemSyncProtocolCheck
        MOVS     R6,R0
        BEQ.N    ??BcMdemCommad_1
// 1164 			{
// 1165 				nRet = BcMdemDataProtocolCheck(Commad);
        SXTB     R0,R5
        BL       BcMdemDataProtocolCheck
        MOVS     R4,R0
// 1166 				if(!nRet)return FALSE;
        BEQ.N    ??BcMdemCommad_1
// 1167 				if(nRet > 0) nRet = nlen;	// normal case 이면.. len을 return한다.
??BcMdemCommad_9:
        CMP      R4,#+1
        BLT.N    ??BcMdemCommad_8
        MOV      R4,R6
        B.N      ??BcMdemCommad_8
// 1168 			}
??BcMdemCommad_10:
        LDR.N    R0,??BcMdemCommad_3+0x4  ;; `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 124
        B.N      ??BcMdemCommad_4
??BcMdemCommad_11:
        LDR.N    R0,??BcMdemCommad_3+0x8  ;; `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 96
        B.N      ??BcMdemCommad_4
??BcMdemCommad_12:
        LDR.N    R0,??BcMdemCommad_3+0xC  ;; `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 140
        B.N      ??BcMdemCommad_4
??BcMdemCommad_13:
        LDR.N    R0,??BcMdemCommad_3+0x10  ;; `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 28
        B.N      ??BcMdemCommad_4
??BcMdemCommad_14:
        LDR.N    R0,??BcMdemCommad_3+0x14  ;; `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 156
        B.N      ??BcMdemCommad_4
??BcMdemCommad_1:
        MOVS     R0,#+0
        ADD      SP,SP,#+104
        POP      {R4-R6,PC}
// 1169 			else return FALSE;
// 1170 		break;	
// 1171 
// 1172 		case ModemPilotCmd:
// 1173 		case MsgCheckCmd: 	
// 1174 		case ModemTimeCmd:
// 1175 		case ModemRfStsCmd:
// 1176 		case ModemTrafficCmd:
// 1177 			if((nlen = BcMdemSyncProtocolCheck()) != FALSE)
??BcMdemCommad_6:
        BL       BcMdemSyncProtocolCheck
        MOVS     R6,R0
        BEQ.N    ??BcMdemCommad_1
// 1178 			{
// 1179 				nRet = BcMdemDataProtocolCheck(Commad);
        SXTB     R0,R5
        BL       BcMdemDataProtocolCheck
        MOVS     R4,R0
// 1180 				if(!nRet)return FALSE;
        BEQ.N    ??BcMdemCommad_1
// 1181 				if(!BcMdemSyncProtocolCheck())return FALSE;
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemCommad_1
// 1182 				if(BcMdemSyncCheck((char *)RxCdmaData) != 14)return FALSE;
        LDR.N    R0,??BcMdemCommad_3+0x18  ;; RxCdmaData
        BL       BcMdemSyncCheck
        CMP      R0,#+14
        BNE.N    ??BcMdemCommad_1
// 1183 				if(Commad != ModemTrafficCmd)
        CMP      R5,#+8
        BEQ.N    ??BcMdemCommad_8
// 1184 				{
// 1185 					if(nRet > 0) nRet = nlen;	// normal case 이면.. len을 return한다.
        B.N      ??BcMdemCommad_9
// 1186 				}	
// 1187 			}
// 1188 			else return FALSE;
// 1189 		break;	
// 1190 
// 1191 		case ModemHangUpCmd:
// 1192 			if(BcMdemSyncProtocolCheck())
??BcMdemCommad_5:
        BL       BcMdemSyncProtocolCheck
        CMP      R0,#+0
        BEQ.N    ??BcMdemCommad_1
// 1193 			{
// 1194 				for(i = 0; i < strlen(RspmsgHangup);i++)Ptr[i] = RxCdmaData[i];
        LDR.N    R5,??BcMdemCommad_3+0x18  ;; RxCdmaData
        MOVS     R2,#+9
        MOV      R1,R5
        ADD      R0,SP,#+0
        BL       __aeabi_memcpy4
// 1195 				Ptr[i] = 0;
        STRB     R4,[SP, #+9]
// 1196 				if(BcMdemSyncCheck((char *)Ptr) != 30)return FALSE;
        ADD      R0,SP,#+0
        BL       BcMdemSyncCheck
        CMP      R0,#+30
        BNE.N    ??BcMdemCommad_1
// 1197 				
// 1198 				if(RxCdmaData[i] != '1')return FALSE;
        LDRB     R0,[R5, #+9]
        CMP      R0,#+49
        BNE.N    ??BcMdemCommad_1
// 1199 			}
// 1200 			else return FALSE;
// 1201 			
// 1202 		break; 
// 1203 	}
// 1204 	return nRet;
??BcMdemCommad_8:
        MOV      R0,R4
        ADD      SP,SP,#+104
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??BcMdemCommad_3:
        DC32     `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 108
        DC32     `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 124
        DC32     `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 96
        DC32     `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 140
        DC32     `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 28
        DC32     `?<Constant "\\n\\n BcmComm[%d] \\n\\n">` + 156
        DC32     RxCdmaData
// 1205 }
// 1206 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1207 INT32S BcdemTimeGet(BcMTimeStr *nPtr)
// 1208 {
BcdemTimeGet:
        PUSH     {R3-R7,LR}
        MOV      R4,R0
// 1209 	INT8U i = 0;
// 1210 	INT8U *tPtr = (INT8U *)nPtr;
// 1211 	INT32S nRet = TRUE;
        MOVW     R7,#+1500
        LDR.N    R5,??BcdemTimeGet_0  ;; BcMVerNum
        B.N      ??BcdemTimeGet_1
// 1212 		
// 1213 S_START:
// 1214 
// 1215 	if(BcMRtryNo >= MaxTryNo) return FALSE;	// Max Try Error
// 1216 
// 1217 	nRet = BcMdemCommad(ModemTimeCmd);
// 1218 
// 1219 	if(nRet == FALSE)
// 1220 	{
// 1221 		BcMRtryNo++;
??BcdemTimeGet_2:
        LDRB     R0,[R5, #+5]
        ADDS     R0,R0,#+1
        STRB     R0,[R5, #+5]
// 1222 		OSTimeDly(1500);
        MOV      R0,R7
        BL       OSTimeDly
// 1223 		goto S_START;
// 1224 	}
??BcdemTimeGet_1:
        LDRB     R0,[R5, #+5]
        CMP      R0,#+5
        BCC.N    ??BcdemTimeGet_3
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}
??BcdemTimeGet_3:
        MOVS     R0,#+6
        BL       BcMdemCommad
        MOVS     R6,R0
        BEQ.N    ??BcdemTimeGet_2
// 1225 	// mem init
// 1226 	for(i = 0; i < sizeof(BcMTimeStr); i++)  *tPtr++ = 0;
        MOVS     R1,#+18
        MOV      R0,R4
        BL       __aeabi_memclr
// 1227 	
// 1228 	for(i = 0; i < 4; i++) nPtr->Year[i] = BcMpresentTime->Year[i];
        MOVS     R0,#+0
        MOV      R1,R4
??BcdemTimeGet_4:
        LDR      R2,[R5, #+32]
        LDRB     R2,[R0, R2]
        STRB     R2,[R1], #+1
        ADDS     R0,R0,#+1
        UXTB     R2,R0
        CMP      R2,#+4
        BCC.N    ??BcdemTimeGet_4
// 1229 	for(i = 0; i < 2; i++)
        MOVS     R0,#+0
// 1230 	{
// 1231 		nPtr->Month[i]	= BcMpresentTime->Month[i];
??BcdemTimeGet_5:
        LDR      R1,[R5, #+32]
        ADDS     R1,R0,R1
        LDRB     R1,[R1, #+4]
        STRB     R1,[R4, #+4]
// 1232 		nPtr->Day[i]	= BcMpresentTime->Day[i];
        LDR      R1,[R5, #+32]
        ADDS     R1,R0,R1
        LDRB     R1,[R1, #+6]
        STRB     R1,[R4, #+6]
// 1233 		nPtr->Hour[i]	= BcMpresentTime->Hour[i];
        LDR      R1,[R5, #+32]
        ADDS     R1,R0,R1
        LDRB     R1,[R1, #+8]
        STRB     R1,[R4, #+8]
// 1234 		nPtr->Min[i]	= BcMpresentTime->Min[i];
        LDR      R1,[R5, #+32]
        ADDS     R1,R0,R1
        LDRB     R1,[R1, #+10]
        STRB     R1,[R4, #+10]
// 1235 		nPtr->Sec[i]	= BcMpresentTime->Sec[i];
        LDR      R1,[R5, #+32]
        ADDS     R1,R0,R1
        LDRB     R1,[R1, #+12]
        STRB     R1,[R4, #+12]
// 1236 	}	
        ADDS     R0,R0,#+1
        ADDS     R4,R4,#+1
        UXTB     R1,R0
        CMP      R1,#+2
        BCC.N    ??BcdemTimeGet_5
// 1237 	OSTimeDly(1500);
        MOV      R0,R7
        BL       OSTimeDly
// 1238 	return nRet;
        MOV      R0,R6
        POP      {R1,R4-R7,PC}    ;; return
        Nop      
        DATA
??BcdemTimeGet_0:
        DC32     BcMVerNum
// 1239 }
// 1240 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1241 INT32S BcdemRfStsGet(BcMRfStsStr *nPtr)
// 1242 {
BcdemRfStsGet:
        PUSH     {R4-R6,LR}
        MOV      R5,R0
// 1243 	INT8U i = 0;
// 1244 	INT16S *tPtr = (INT16S *)nPtr;
// 1245 	INT32S nRet = TRUE;
        LDR.N    R4,??BcdemRfStsGet_0  ;; BcMVerNum
        B.N      ??BcdemRfStsGet_1
// 1246 		
// 1247 RF_START:
// 1248 
// 1249 	if(BcMRtryNo >= MaxTryNo) return FALSE;	// Max Try Error
// 1250 
// 1251 	nRet = BcMdemCommad(ModemRfStsCmd);
// 1252 
// 1253 	if(nRet == FALSE)
// 1254 	{
// 1255 		BcMRtryNo++;
??BcdemRfStsGet_2:
        LDRB     R0,[R4, #+5]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+5]
// 1256 		OSTimeDly(1000);
        MOV      R0,#+1000
        BL       OSTimeDly
// 1257 		goto RF_START;
// 1258 	}
??BcdemRfStsGet_1:
        LDRB     R0,[R4, #+5]
        CMP      R0,#+5
        BCC.N    ??BcdemRfStsGet_3
        MOVS     R0,#+0
        POP      {R4-R6,PC}
??BcdemRfStsGet_3:
        MOVS     R0,#+7
        BL       BcMdemCommad
        MOVS     R6,R0
        BEQ.N    ??BcdemRfStsGet_2
// 1259 	// mem init
// 1260 	for(i = 0; i < sizeof(BcMRfStsStr); i++)  *tPtr++ = 0;
        MOVS     R1,#+100
        MOV      R0,R5
        BL       __aeabi_memclr
// 1261 
// 1262 	nPtr->ActChannel =	BcMRfStatus->ActChannel;
        LDR      R0,[R4, #+36]
        LDRH     R0,[R0, #+0]
        STRH     R0,[R5, #+0]
// 1263 	for(i = 0; i < 6; i++)
        MOVS     R0,#+0
        MOV      R1,R5
        MOVS     R2,#+6
// 1264 	{
// 1265 		nPtr->PN_Vaule[i] = BcMRfStatus->PN_Vaule[i];
??BcdemRfStsGet_4:
        LDR      R3,[R4, #+36]
        ADDS     R3,R0,R3
        LDRH     R3,[R3, #+18]
        STRH     R3,[R1, #+18]
// 1266 		nPtr->EcIo[i] 	  = BcMRfStatus->EcIo[i];
        LDR      R3,[R4, #+36]
        ADDS     R3,R0,R3
        LDRH     R3,[R3, #+30]
        STRH     R3,[R1, #+30]
// 1267 	}
        ADDS     R1,R1,#+2
        ADDS     R0,R0,#+2
        SUBS     R2,R2,#+1
        BNE.N    ??BcdemRfStsGet_4
// 1268 
// 1269 	nPtr->FerValue 	=	BcMRfStatus->FerValue;
        LDR      R0,[R4, #+36]
        LDRH     R0,[R0, #+42]
        STRH     R0,[R5, #+42]
// 1270 	nPtr->RxValue 	=	BcMRfStatus->RxValue;
        LDR      R0,[R4, #+36]
        LDRH     R0,[R0, #+44]
        STRH     R0,[R5, #+44]
// 1271 	nPtr->TxValue 	=	BcMRfStatus->TxValue;
        LDR      R0,[R4, #+36]
        LDRH     R0,[R0, #+46]
        STRH     R0,[R5, #+46]
// 1272 	nPtr->AdjValue 	=	BcMRfStatus->AdjValue;
        LDR      R0,[R4, #+36]
        LDRH     R0,[R0, #+48]
        STRH     R0,[R5, #+48]
// 1273 
// 1274 	nPtr->NumberOfChannel = BcMRfStatus->NumberOfChannel;
        LDR      R0,[R4, #+36]
        LDRH     R0,[R0, #+2]
        STRH     R0,[R5, #+2]
// 1275 	nPtr->ActPN = BcMRfStatus->ActPN;	
        LDR      R0,[R4, #+36]
        LDRH     R0,[R0, #+16]
        STRH     R0,[R5, #+16]
// 1276 	
// 1277 	return nRet;
        MOV      R0,R6
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??BcdemRfStsGet_0:
        DC32     BcMVerNum
// 1278 }
// 1279 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1280 INT32S BcMdemFuncselect(void)
// 1281 {
// 1282 	// Modem Status Check.
// 1283 ////////////////////////////////////////////////////////////////////////////////////////	
// 1284 	// error Case
// 1285 	if(BcMRtryNo >= MaxTryNo)
BcMdemFuncselect:
        LDR.N    R0,??BcMdemFuncselect_0  ;; BcMVerNum
        LDRB     R1,[R0, #+5]
        CMP      R1,#+5
        BCC.N    ??BcMdemFuncselect_1
// 1286 	{
// 1287 		TimeReqCnt = 0;
        MOVS     R1,#+0
        STRH     R1,[R0, #+4]
// 1288 		BcMRtryNo = 0;
// 1289 		return  MAX_TRY;
        MVN      R0,#+1
        BX       LR
// 1290 	}
// 1291 
// 1292 	if(++TimeReqCnt > 5)
??BcMdemFuncselect_1:
        LDRB     R1,[R0, #+4]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+4]
        UXTB     R1,R1
        CMP      R1,#+6
        BCC.N    ??BcMdemFuncselect_2
// 1293 	{
// 1294 		TimeReqCnt = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
// 1295 		return SELF_TIME;
        MOVS     R0,#+4
        BX       LR
// 1296 	}
// 1297 	else if(TimeReqCnt%2)	return SELF_RECV;
??BcMdemFuncselect_2:
        LSRS     R0,R1,#+1
        SUBS     R0,R1,R0, LSL #+1
        BEQ.N    ??BcMdemFuncselect_3
        MOVS     R0,#+3
        BX       LR
// 1298 	else					return SELF_SEND;
??BcMdemFuncselect_3:
        MOVS     R0,#+2
        BX       LR               ;; return
        Nop      
        DATA
??BcMdemFuncselect_0:
        DC32     BcMVerNum
// 1299 }
// 1300 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1301 INT32S BcMdemRecv(INT8U *rbuf, INT8U *sTel, BcMTimeStr *rtime)
// 1302 {
BcMdemRecv:
        PUSH     {R3-R11,LR}
        MOV      R11,R0
        MOV      R8,R1
        MOV      R4,R2
// 1303 	INT32S len = 0;
        MOVS     R5,#+0
// 1304 	INT32S nRet = 0;
        MOVW     R7,#+1500
        LDR.N    R6,??BcMdemRecv_0  ;; BcMVerNum
        B.N      ??BcMdemRecv_1
// 1305 	// 0: Fail
// 1306 	// -1: Not Data
// 1307 	//	
// 1308 
// 1309 S_START:
// 1310 
// 1311 	if(BcMRtryNo >= MaxTryNo) return  FALSE;
// 1312 	
// 1313 	nRet = BcMdemCommad(MsgCheckCmd);
// 1314 
// 1315 	if(nRet == FALSE)
// 1316 	{
// 1317 		BcMRtryNo++;
??BcMdemRecv_2:
        LDRB     R0,[R6, #+5]
        ADDS     R0,R0,#+1
        STRB     R0,[R6, #+5]
// 1318 		OSTimeDly(1500);
        MOV      R0,R7
        BL       OSTimeDly
// 1319 		goto S_START;
// 1320 	}
??BcMdemRecv_1:
        LDRB     R0,[R6, #+5]
        CMP      R0,#+5
        BCC.N    ??BcMdemRecv_3
        MOVS     R0,#+0
        POP      {R1,R4-R11,PC}
??BcMdemRecv_3:
        MOVS     R0,#+9
        BL       BcMdemCommad
        MOVS     R9,R0
        BEQ.N    ??BcMdemRecv_2
// 1321 	else if(nRet == NOT_DATA)
        MOV      R0,#-1
        CMP      R9,R0
        BEQ.W    ??BcMdemRecv_4
// 1322 	{
// 1323 		nRet = NOT_DATA;
// 1324 	}
// 1325 	else if(nRet > 0)//(nRet == TRUE)										// protocol ok --> data read
        CMP      R9,#+1
        BLT.W    ??BcMdemRecv_4
// 1326 	{
// 1327 		nRet = BcMdemCommad(MsgReciveCmd);
        MOVS     R0,#+10
        BL       BcMdemCommad
        MOVS     R9,R0
// 1328 
// 1329 		if(nRet == FALSE)
        BEQ.N    ??BcMdemRecv_2
// 1330 		{
// 1331 			BcMRtryNo++;
// 1332 			OSTimeDly(1500);
// 1333 			goto S_START;
// 1334 		}
// 1335 		//else if(nRet < 0)
// 1336 		//{
// 1337 		//	nRet = len;
// 1338 		//}
// 1339 		else if(nRet > 0)
        CMP      R9,#+1
        BLT.N    ??BcMdemRecv_4
// 1340 		{
// 1341 			//len = len;
// 1342 			// RxCdmaData
// 1343 			{
// 1344 				INT16U i = 0, cnt = 0, tcnt = 0;
        MOVS     R6,#+0
        MOV      R7,R5
// 1345 				INT8U *tPtr = RxBcMData;
        LDR.W    R10,??BcMdemRecv_0+0x4  ;; RxBcMData
// 1346 
// 1347 				////////////////////////////////////////////////////////////////
// 1348 				for(i = 0; i < sizeof(BcMTimeStr); i++) *((INT8U *)rtime + i) = 0;
        MOVS     R1,#+18
        MOV      R0,R4
        BL       __aeabi_memclr
// 1349 				//////////////////////////////////////////////////////////////////////
// 1350 				for(i = 0; i < 4; i++, cnt++) rtime->Year[i] = *tPtr++;
        MOV      R0,R4
        MOVS     R1,#+2
??BcMdemRecv_5:
        LDRB     R2,[R10], #+1
        STRB     R2,[R0], #+1
        LDRB     R2,[R10], #+1
        STRB     R2,[R0], #+1
        ADDS     R2,R6,#+2
        UXTH     R6,R2
        SUBS     R1,R1,#+1
        BNE.N    ??BcMdemRecv_5
// 1351 				for(i = 0; i < 2; i++, cnt++) rtime->Month[i]= *tPtr++;
        MOV      R0,R4
        MOVS     R1,#+2
??BcMdemRecv_6:
        LDRB     R2,[R10], #+1
        STRB     R2,[R0, #+4]
        ADDS     R2,R6,#+1
        UXTH     R6,R2
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??BcMdemRecv_6
// 1352 				for(i = 0; i < 2; i++, cnt++) rtime->Day[i]= *tPtr++;
        MOV      R0,R4
        MOVS     R1,#+2
??BcMdemRecv_7:
        LDRB     R2,[R10], #+1
        STRB     R2,[R0, #+6]
        ADDS     R2,R6,#+1
        UXTH     R6,R2
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??BcMdemRecv_7
// 1353 				for(i = 0; i < 2; i++, cnt++) rtime->Hour[i]= *tPtr++;
        MOV      R0,R4
        MOVS     R1,#+2
??BcMdemRecv_8:
        LDRB     R2,[R10], #+1
        STRB     R2,[R0, #+8]
        ADDS     R2,R6,#+1
        UXTH     R6,R2
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??BcMdemRecv_8
// 1354 				for(i = 0; i < 2; i++, cnt++) rtime->Min[i]= *tPtr++;
        MOV      R0,R4
        MOVS     R1,#+2
??BcMdemRecv_9:
        LDRB     R2,[R10], #+1
        STRB     R2,[R0, #+10]
        ADDS     R2,R6,#+1
        UXTH     R6,R2
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??BcMdemRecv_9
// 1355 				for(i = 0; i < 2; i++, cnt++) rtime->Sec[i]= *tPtr++;
        MOVS     R0,#+2
??BcMdemRecv_10:
        LDRB     R1,[R10], #+1
        STRB     R1,[R4, #+12]
        ADDS     R1,R6,#+1
        UXTH     R6,R1
        ADDS     R4,R4,#+1
        SUBS     R0,R0,#+1
        BNE.N    ??BcMdemRecv_10
// 1356 
// 1357 				*tPtr++; cnt++;		// ','
        ADD      R4,R10,#+1
        B.N      ??BcMdemRecv_11
// 1358 				
// 1359 				for(; cnt < nRet; cnt++)
// 1360 				{
// 1361 					if(*tPtr != ',')
// 1362 					{	
// 1363 						if(tcnt == 0)
// 1364 						{
// 1365 							*sTel++ = *tPtr++;
// 1366 						}
// 1367 						else if(tcnt == 1) tPtr++;
// 1368 						else if(tcnt == 2) tPtr++;
// 1369 						else if(tcnt == 3) tPtr++;
// 1370 						else
// 1371 						{
// 1372 							INT8U temp;
// 1373 							temp = atoh(*tPtr++);
// 1374 							temp = atoh(*tPtr++) + ( temp << 4 );
// 1375 							rbuf[len++] = temp;
// 1376 							cnt++;
// 1377 						}
// 1378 					}
// 1379 					else
// 1380 					{
// 1381 						tPtr++;
??BcMdemRecv_12:
        ADDS     R4,R4,#+1
// 1382 						tcnt++;
        ADDS     R7,R7,#+1
        UXTH     R7,R7
// 1383 					}
??BcMdemRecv_11:
        ADDS     R0,R6,#+1
        UXTH     R6,R0
        CMP      R6,R9
        BGE.N    ??BcMdemRecv_13
        LDRB     R0,[R4, #+0]
        CMP      R0,#+44
        BEQ.N    ??BcMdemRecv_12
        MOVS     R0,R7
        BNE.N    ??BcMdemRecv_14
        LDRB     R0,[R4], #+1
        STRB     R0,[R8], #+1
        B.N      ??BcMdemRecv_11
??BcMdemRecv_14:
        CMP      R7,#+1
        BNE.N    ??BcMdemRecv_15
??BcMdemRecv_16:
        ADDS     R4,R4,#+1
        B.N      ??BcMdemRecv_11
??BcMdemRecv_15:
        CMP      R7,#+2
        BEQ.N    ??BcMdemRecv_16
        CMP      R7,#+3
        BEQ.N    ??BcMdemRecv_16
??BcMdemRecv_17:
        LDRB     R0,[R4], #+1
        BL       atoh
        MOV      R10,R0
        LDRB     R0,[R4], #+1
        BL       atoh
        ADD      R0,R0,R10, LSL #+4
        UXTB     R0,R0
        STRB     R0,[R5, R11]
        ADDS     R5,R5,#+1
        ADDS     R0,R6,#+1
        UXTH     R6,R0
        B.N      ??BcMdemRecv_11
// 1384 				}				
// 1385 				nRet = len;
??BcMdemRecv_13:
        MOV      R9,R5
// 1386 				rbuf[len++] = 0;	// null data insert
        MOVS     R0,#+0
        STRB     R0,[R5, R11]
// 1387 				*sTel++ = 0;		// null data insert
        STRB     R0,[R8, #+0]
// 1388 
// 1389 			//Ser0Printf(" rDATA: %s", RxBcMData);
// 1390 			//Ser0Printf(" DATA: %s", rbuf);
// 1391 			//Ser0Printf(" len: %d \n", nRet);
// 1392 			}
// 1393 		}
// 1394 	}
// 1395 	OSTimeDly(1500);
??BcMdemRecv_4:
        MOVW     R0,#+1500
        BL       OSTimeDly
// 1396 	return nRet;
        MOV      R0,R9
        POP      {R1,R4-R11,PC}   ;; return
        DATA
??BcMdemRecv_0:
        DC32     BcMVerNum
        DC32     RxBcMData
// 1397 }
// 1398 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1399 INT32S BcdemPilotGet(BcMPilotStsStr *nPtr)
// 1400 {
BcdemPilotGet:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
// 1401 	INT8U i = 0;
// 1402 	INT16S *tPtr = (INT16S *)nPtr;
// 1403 	INT32S nRet = TRUE;
// 1404 		
// 1405 
// 1406 	nRet = BcMdemCommad(ModemPilotCmd);
        MOVS     R0,#+17
        BL       BcMdemCommad
        MOV      R5,R0
// 1407 
// 1408  
// 1409 	// mem init
// 1410 	for(i = 0; i < sizeof(BcMPilotStsStr); i++)  *tPtr++ = 0;
        MOVS     R1,#+32
        MOV      R0,R4
        BL       __aeabi_memclr
// 1411 
// 1412 
// 1413 	
// 1414 	for(i = 0; i < 4; i++)
        MOVS     R1,#+0
        MOV      R0,R4
        MOVS     R2,#+4
        LDR.N    R3,??BcdemPilotGet_0  ;; BcMPilotStatus
// 1415 	{
// 1416 		nPtr->PN_Vaule[i] = BcMPilotStatus->PN_Vaule[i];
??BcdemPilotGet_1:
        LDR      R6,[R3, #+0]
        LDRH     R6,[R1, R6]
        STRH     R6,[R4], #+2
// 1417 		nPtr->EcIo[i] 	  = BcMPilotStatus->EcIo[i];
        LDR      R6,[R3, #+0]
        ADDS     R6,R1,R6
        LDRH     R6,[R6, #+8]
        STRH     R6,[R0, #+8]
// 1418 
// 1419 	}
        ADDS     R0,R0,#+2
        ADDS     R1,R1,#+2
        SUBS     R2,R2,#+1
        BNE.N    ??BcdemPilotGet_1
// 1420 	return nRet;
        MOV      R0,R5
        POP      {R4-R6,PC}       ;; return
        DATA
??BcdemPilotGet_0:
        DC32     BcMPilotStatus
// 1421 }
// 1422 
// 1423 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1424 void ModemEsnCheck ( void )
// 1425 {
ModemEsnCheck:
        PUSH     {R4-R6,LR}
// 1426 	INT16U	EsnChk;
// 1427 
// 1428 	EsnChk = TwoAsciNum2OneHex( BcMEsnNum[0], BcMEsnNum[1] )
// 1429 			+TwoAsciNum2OneHex( BcMEsnNum[2], BcMEsnNum[3] )
// 1430 			+TwoAsciNum2OneHex( BcMEsnNum[4], BcMEsnNum[5] )
// 1431 			+TwoAsciNum2OneHex( BcMEsnNum[6], BcMEsnNum[7] );
        LDR.N    R4,??ModemEsnCheck_0  ;; BcMVerNum
        LDRB     R1,[R4, #+25]
        LDRB     R0,[R4, #+24]
        BL       TwoAsciNum2OneHex
        MOV      R5,R0
        LDRB     R1,[R4, #+27]
        LDRB     R0,[R4, #+26]
        BL       TwoAsciNum2OneHex
        MOV      R6,R0
        LDRB     R1,[R4, #+29]
        LDRB     R0,[R4, #+28]
        BL       TwoAsciNum2OneHex
        ADDS     R1,R6,R5
        ADDS     R5,R0,R1
        LDRB     R1,[R4, #+31]
        LDRB     R0,[R4, #+30]
        BL       TwoAsciNum2OneHex
        ADDS     R5,R0,R5
// 1432 	EsnChecksumH = DataConv(HIGH, EsnChk);
        UXTB     R1,R5
        MOVS     R0,#+1
        BL       DataConv
        STRB     R0,[R4, #+6]
// 1433 	EsnChecksumL = DataConv(LOW, EsnChk);
        UXTB     R1,R5
        MOVS     R0,#+2
        BL       DataConv
        STRB     R0,[R4, #+7]
// 1434 }
        POP      {R4-R6,PC}       ;; return
        DATA
??ModemEsnCheck_0:
        DC32     BcMVerNum
// 1435 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1436 INT8U DataConv ( INT8U HighLow, INT8U Value )
// 1437 {
DataConv:
        MOV      R2,R0
// 1438 	INT8U Digit10;
// 1439 	INT8U Digit1;
// 1440 
// 1441 	Digit1 = (Value & 0x0f) + 0x30;
        AND      R0,R1,#0xF
        ADDS     R0,R0,#+48
        UXTB     R0,R0
// 1442 	Digit10 = ((Value >> 4) & 0x0f) + 0x30;
        LSRS     R1,R1,#+4
        ADDS     R1,R1,#+48
        UXTB     R1,R1
// 1443 
// 1444     if(Digit1 >= 0x3a) Digit1 += 0x07;
        CMP      R0,#+58
        BCC.N    ??DataConv_0
        ADDS     R0,R0,#+7
        UXTB     R0,R0
// 1445     if(Digit10 >= 0x3a) Digit10 += 0x07;
??DataConv_0:
        CMP      R1,#+58
        BCC.N    ??DataConv_1
        ADDS     R1,R1,#+7
        UXTB     R1,R1
// 1446 
// 1447     if(HighLow == HIGH) return( Digit10 );
??DataConv_1:
        CMP      R2,#+1
        BNE.N    ??DataConv_2
        MOV      R0,R1
        BX       LR
// 1448     if(HighLow == LOW) return( Digit1 );
??DataConv_2:
        CMP      R2,#+2
        BEQ.N    ??DataConv_3
// 1449 	return(0);
        MOVS     R0,#+0
??DataConv_3:
        BX       LR               ;; return
// 1450 }
// 1451 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1452 INT8U TwoAsciDeciNum2OneHex( INT8U Upper, INT8U Lower )
// 1453 {
// 1454 	return ( (Upper-0x30)*10 + (Lower-0x30)*1);
TwoAsciDeciNum2OneHex:
        MOVS     R2,#+10
        MLA      R0,R0,R2,R1
        SUBS     R0,R0,#+16
        UXTB     R0,R0
        BX       LR               ;; return
// 1455 }
// 1456 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1457 INT8S TwoAsciNum2OneHex( INT8U Upper, INT8U Lower )
// 1458 {
// 1459 	if ( Upper >= 0x41 ) Upper = Upper - 0x07;
TwoAsciNum2OneHex:
        CMP      R0,#+65
        BCC.N    ??TwoAsciNum2OneHex_0
        SUBS     R0,R0,#+7
// 1460 	if ( Lower >= 0x41 ) Lower = Lower - 0x07;
??TwoAsciNum2OneHex_0:
        CMP      R1,#+65
        BCC.N    ??TwoAsciNum2OneHex_1
        SUBS     R1,R1,#+7
// 1461 	return ( ((Upper-0x30)<<4)|(Lower-0x30) );
??TwoAsciNum2OneHex_1:
        SUBS     R1,R1,#+48
        ORR      R0,R1,R0, LSL #+4
        SXTB     R0,R0
        BX       LR               ;; return
// 1462 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "\\n\\n 0: nDebug[%d] \\n\\n">`:
        DATA
        DC8 "\012\012 0: nDebug[%d] \012\012"
        DC8 "\012\012 1: nDebug[%d] \012\012"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "\\n\\n BcmComm[%d] \\n\\n">`:
        DATA
        DC8 "\012\012 BcmComm[%d] \012\012"
        DC8 0, 0
        DC8 "ATE0"
        DC8 0, 0, 0
        DC8 "AT*SKT*REL"
        DC8 0
        DC8 "AT*SKTR*SPC=011010"
        DC8 0
        DC8 "AT+GMR"
        DC8 0
        DC8 "AT*SKT*DIAL"
        DC8 "AT*SKTR*ESN?"
        DC8 0, 0, 0
        DC8 "AT*SKT*PING"
        DC8 "AT*SKTR*SMSMT"
        DC8 0, 0
        DC8 "AT*SKTR*SMSCNT?"
        DC8 "AT*SKTR*RFSTS"
        DC8 0, 0
        DC8 "AT*SKTR*PILOT?"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "\\r\\n">`:
        DATA
        DC8 "\015\012"
        DC8 0
        DC8 "\012\012 BcMdebug[%d] \012\012"
        DC8 0
        DC8 "%s\015\012 slen: %d \015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "%s%s,%s,4098,,,,">`:
        DATA
        DC8 "%s%s,%s,4098,,,,"
        DC8 0, 0, 0
        DC8 "AT*SKTR*SMSMO="
        DC8 0
        DC8 "%02x"
        DC8 0, 0, 0
        DC8 "AT$TCPWRITE="
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "%s"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "$TCPREADDATA=">`:
        DATA
        DC8 "$TCPREADDATA="
        DC8 0, 0
        DC8 "*SKTR*SMSMOACK:1"
        DC8 0, 0, 0
        DC8 "CONNECT"
        DC8 "NO CARRIER"
        DC8 0
        DC8 "ERROR"
        DC8 0, 0
        DC8 "$008:0"
        DC8 0
        DC8 "$008:1"
        DC8 0
        DC8 "$006"
        DC8 0, 0, 0
        DC8 "$TCPOPEN"
        DC8 0, 0, 0
        DC8 "*SKTR*SMSCNT:"
        DC8 0, 0
        DC8 "*SKTR*SMSMT:"
        DC8 0, 0, 0
        DC8 "*SKTR*ESN:"
        DC8 0
        DC8 "*SKTR*RFSTS:"
        DC8 0, 0, 0
        DC8 "*SKT*PONG:"
        DC8 0
        DC8 "$TCPSENDDONE"
        DC8 0, 0, 0
        DC8 "$TCPCLOSED"
        DC8 0
        DC8 "*SKT*RESET:1"
        DC8 0, 0, 0
        DC8 "*SKT*VCALL:"
        DC8 "*SKT*VOICECONNECT"
        DC8 0, 0
        DC8 "*SKT*REL:"
        DC8 0, 0
        DC8 "*SKTR*PILOT:"
        DC8 0, 0, 0
        DC8 "*SKT*DIAL:"
        DC8 0
        DC8 "*SKT*ORI:"
        DC8 0, 0
        DC8 "*SKT*BOOTALERT"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant " #1. Error: No Respon...">`:
        DATA
        DC8 " #1. Error: No Response \015\012 "
        DC8 " #2 Error: No Response \015\012 "
        DC8 0
        DC8 " Error: CdmaBuffLen OverFlow %d \015\012 "
        DC8 " %s\015\012 "
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "OK"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "AT*"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT+CRM=251">`:
        DATA
        DC8 "AT+CRM=251"
        DC8 0
        DC8 "ATDT1501"
        DC8 0, 0, 0
        DC8 "%s%s,%d"
        DC8 "AT$TCPOPEN="

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT$TCPCLOSE">`:
        DATA
        DC8 "AT$TCPCLOSE"
        DC8 "AT$TCPEXIT"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT*SKT*RESET">`:
        DATA
        DC8 "AT*SKT*RESET"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "%s%s">`:
        DATA
        DC8 "%s%s"
        DC8 0, 0, 0
        DC8 "AT*SKT*ORI="

        END
// 1463 
// 1464 
// 1465 ////////////////////////////////////////////////////////////////////////////////
// 1466 // End of Source File
// 1467 /////////////////////
// 1468 
// 
// 1 720 bytes in section .bss
//    56 bytes in section .data
//   848 bytes in section .rodata
// 6 714 bytes in section .text
// 
// 6 714 bytes of CODE  memory
//   848 bytes of CONST memory
// 1 776 bytes of DATA  memory
//
//Errors: none
//Warnings: none
