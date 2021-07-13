///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:41 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\de_pr /
//                    otocol.c                                                /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\de_pr /
//                    otocol.c -D _MIMO_Type -lcN                             /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\de_pr /
//                    otocol.s                                                /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME de_protocol

        EXTERN AttnOutBufferInit
        EXTERN B1_HostStation
        EXTERN B1_TestStation
        EXTERN ByteToWord
        EXTERN ChkAttChange
        EXTERN Chk_Reset
        EXTERN CtrlSem
        EXTERN DefaultValueSet
        EXTERN GainAttnCalculation
        EXTERN GenAidData
        EXTERN GenAidData16
        EXTERN HostStation
        EXTERN OSSemPend
        EXTERN OSSemPost
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN RoadBackuptobuffer
        EXTERN SerPtr
        EXTERN TestStation
        EXTERN WriteBuffertoBackup
        EXTERN __aeabi_memcpy
        EXTERN chkHostStation
        EXTERN rambackup
        EXTERN tDnrSts

        PUBLIC AnalyzeAidData
        PUBLIC AttnOffsetTable
        PUBLIC AttnOffsetTableB
        PUBLIC AttnTempTable
        PUBLIC AttnTempTableB
        PUBLIC CtrlData
        PUBLIC GenDnrAidSts
        PUBLIC HostStation_Init
        PUBLIC ISAscII
        PUBLIC LoadBackupData
        PUBLIC OutputTable
        PUBLIC OutputTableB
        PUBLIC RetNormaltoSMSData
        PUBLIC SaveBackupData
        PUBLIC TRIO_Initialize

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\de_protocol.c
//    1 /*********************************************
//    2 * File Name          : DE_Protocol.c
//    3 * Author             :
//    4 * Date First Issued  : 10/20/2010
//    5 * Description        : This file provides all the port/input/update firmware functions.
//    6 * $Revision: 0.1 $
//    7 * $Revision date: 2010.10.__
//    8 ********************************************************************************/
//    9 #define DE_Protocol_C
//   10 
//   11 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// __OutputTable __data OutputTableB
OutputTableB:
        DS8 3096

        SECTION `.data`:DATA:NOROOT(2)
// __OutputTable *__data OutputTable
OutputTable:
        DATA
        DC32 OutputTableB

        SECTION `.bss`:DATA:NOROOT(2)
// struct <unnamed> __data AttnOffsetTableB
AttnOffsetTableB:
        DS8 2480

        SECTION `.data`:DATA:NOROOT(2)
// struct <unnamed> *__data AttnOffsetTable
AttnOffsetTable:
        DATA
        DC32 AttnOffsetTableB

        SECTION `.bss`:DATA:NOROOT(2)
// __AttnTempTable __data AttnTempTableB
AttnTempTableB:
        DS8 336

        SECTION `.data`:DATA:NOROOT(2)
// __AttnTempTable *__data AttnTempTable
AttnTempTable:
        DATA
        DC32 AttnTempTableB
//   12 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   13 INT16U GenDnrAidSts(INT8U *dptr, __Dnr_Sts *Sts,__ProtocolPtr *nPtr )
//   14 {
GenDnrAidSts:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R5,R1
//   15 	INT16U rlen = 0;
//   16 	INT16U i = 0;
//   17 
//   18 	i = i;
//   19 
//   20 	// alarm !!
//   21 	dptr[rlen++] = (Aid_RepeaterAlarm >> 8) & 0xff;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//   22 	dptr[rlen++] = (Aid_RepeaterAlarm >> 0) & 0xff;
        MOVS     R0,#+1
        STRB     R0,[R4, #+1]
//   23 	dptr[rlen++] = 2 *(sizeof(__DnrAlarmDataStr));
        MOVS     R0,#+18
        STRB     R0,[R4, #+2]
        MOVS     R6,#+3
//   24 
//   25 	for(i = 0; i < (sizeof(__DnrAlarmDataStr)); i++)	dptr[rlen++] = *((INT8U *)&(Sts->Flag) + i);
        ADDS     R0,R4,#+3
        MOVS     R2,#+3
??GenDnrAidSts_0:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        ADDS     R6,R6,#+3
        UXTH     R6,R6
        SUBS     R2,R2,#+1
        BNE.N    ??GenDnrAidSts_0
//   26 	for(i = 0; i < (sizeof(__DnrAlarmDataStr)); i++)	dptr[rlen++] = *((INT8U *)&(Sts->Alm) + i);
        MOV      R0,R5
        MOVS     R1,#+9
??GenDnrAidSts_1:
        LDRB     R3,[R0, #+9]
        STRB     R3,[R6, R4]
        ADDS     R6,R6,#+1
        UXTH     R6,R6
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??GenDnrAidSts_1
//   27 
//   28 	// Manufacture !!
//   29 	rlen += GenAidData(Aid_Manufacture, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Manufacture), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+27
        ADDS     R1,R6,R4
        MOV      R0,#+256
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   30 
//   31 	// Supplier !!
//   32 	rlen += GenAidData(Aid_Supplier, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Supplier), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+28
        ADDS     R1,R6,R4
        MOVW     R0,#+257
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   33 
//   34 	// RepeaterType !!
//   35 	rlen += GenAidData(Aid_RepeaterType, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RepeaterType[0]), 2);
        MOVS     R3,#+2
        ADD      R2,R5,#+29
        ADDS     R1,R6,R4
        MOV      R0,#+258
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   36 
//   37 	// SystemVer !!
//   38 	rlen += GenAidData(Aid_SystemVer,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SWVer), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+31
        ADDS     R1,R6,R4
        MOVW     R0,#+259
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   39 	rlen += GenAidData(Aid_MobileManufacture,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->MobileManufacture), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+32
        ADDS     R1,R6,R4
        MOV      R0,#+260
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   40 	rlen += GenAidData(Aid_MobileModel, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->MobileModel), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+33
        ADDS     R1,R6,R4
        MOVW     R0,#+261
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   41 
//   42 
//   43 	// PhoneVersion_H
//   44 	dptr[rlen++] = (Aid_MobileVer >> 8) & 0xff;
        MOVS     R2,#+1
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//   45 	dptr[rlen++] = (Aid_MobileVer >> 0) & 0xff;
        MOVS     R2,#+6
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//   46 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//   47 	dptr[rlen++] = Sts->PhoneVersion_H;
        LDRB     R2,[R5, #+34]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//   48 	dptr[rlen++] = Sts->PhoneVersion_L;
        ADD      R2,R5,#+34
        LDRB     R2,[R2, #+1]
        STRB     R2,[R0, R4]
        ADDS     R6,R0,#+1
        UXTH     R6,R6
//   49 
//   50 	// FwdInPwr_3G
//   51 #if 0	
//   52 	dptr[rlen++] = (Aid_FwdOutPwr_3G_Sms >> 8) & 0xff;
//   53 	dptr[rlen++] = (Aid_FwdOutPwr_3G_Sms >> 0) & 0xff;
//   54 	dptr[rlen++] = 1;
//   55 //	dptr[rlen++] =	abs(Sts->FwdInPwr_3G);				// 0x0500
//   56 	dptr[rlen++] =	(Sts->FwdOutPwr_3G);				// 0x0500
//   57 #endif
//   58 
//   59 	rlen += GenAidData(Aid_FwdOutPwr_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_3G), sizeof(Sts->FwdOutPwr_3G));
        MOVS     R3,#+2
        ADD      R2,R5,#+36
        ADDS     R1,R6,R4
        MOVW     R0,#+1283
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   60 	rlen += GenAidData(Aid_FwdOutUpperLmt_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_3G), sizeof(Sts->FwdOutUpperLmt_3G));
        MOVS     R3,#+2
        ADD      R2,R5,#+38
        ADDS     R1,R6,R4
        MOVW     R0,#+1284
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   61 	rlen += GenAidData(Aid_FwdOutLowerLmt_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_3G), sizeof(Sts->FwdOutLowerLmt_3G));
        MOVS     R3,#+2
        ADD      R2,R5,#+40
        ADDS     R1,R6,R4
        MOVW     R0,#+1285
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   62 	rlen += GenAidData(Aid_FwdGainSet_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+42
        ADDS     R1,R6,R4
        MOVW     R0,#+1321
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   63 	rlen += GenAidData(Aid_FwdGain_3G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+43
        ADDS     R1,R6,R4
        MOVW     R0,#+1322
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   64 	rlen += GenAidData(Aid_FwdOutPwr_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_2G), sizeof(Sts->FwdOutPwr_2G));
        MOVS     R3,#+2
        ADD      R2,R5,#+44
        ADDS     R1,R6,R4
        MOVW     R0,#+1300
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   65 	rlen += GenAidData(Aid_FwdOutUpperLmt_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_2G), sizeof(Sts->FwdOutUpperLmt_2G));
        MOVS     R3,#+2
        ADD      R2,R5,#+46
        ADDS     R1,R6,R4
        MOVW     R0,#+1301
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   66 	rlen += GenAidData(Aid_FwdOutLowerLmt_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_2G), sizeof(Sts->FwdOutLowerLmt_2G));
        MOVS     R3,#+2
        ADD      R2,R5,#+48
        ADDS     R1,R6,R4
        MOVW     R0,#+1302
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   67 	rlen += GenAidData(Aid_FwdGainSet_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+50
        ADDS     R1,R6,R4
        MOVW     R0,#+1346
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   68 	rlen += GenAidData(Aid_FwdGainSts_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+51
        ADDS     R1,R6,R4
        MOVW     R0,#+1347
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   69 	rlen += GenAidData(Aid_FwdOutPwr_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwr_LTE), sizeof(Sts->FwdOutPwr_LTE));
        MOVS     R3,#+2
        ADD      R2,R5,#+52
        ADDS     R1,R6,R4
        MOVW     R0,#+1366
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   70 	rlen += GenAidData(Aid_FwdOutUpperLmt_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_LTE), sizeof(Sts->FwdOutUpperLmt_LTE));
        MOVS     R3,#+2
        ADD      R2,R5,#+54
        ADDS     R1,R6,R4
        MOVW     R0,#+1367
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   71 	rlen += GenAidData(Aid_FwdOutLowerLmt_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_LTE), sizeof(Sts->FwdOutLowerLmt_LTE));
        MOVS     R3,#+2
        ADD      R2,R5,#+56
        ADDS     R1,R6,R4
        MOV      R0,#+1368
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   72 	rlen += GenAidData(Aid_FwdGainSet_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+58
        ADDS     R1,R6,R4
        MOVW     R0,#+1385
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//   73 	rlen += GenAidData(Aid_FwdGainSts_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+59
        ADDS     R1,R6,R4
        MOVW     R0,#+1386
        BL       GenAidData
        ADDS     R7,R0,R6
        UXTH     R7,R7
//   74 	rlen += GenAidData(Aid_FwdOutPwr_LTE_A, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SmsFwdInPwr_LTE_A), 1);
        ADDW     R6,R5,#+477
        MOVS     R3,#+1
        MOV      R2,R6
        ADDS     R1,R7,R4
        MOVW     R0,#+1388
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   75 	rlen += GenAidData(Aid_FwdOutUpperLmt_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_LTE_A), sizeof(Sts->FwdOutUpperLmt_LTE_A));
        MOVS     R3,#+2
        ADD      R2,R5,#+62
        ADDS     R1,R7,R4
        MOVW     R0,#+1389
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   76 	rlen += GenAidData(Aid_FwdOutLowerLmt_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_LTE_A), sizeof(Sts->FwdOutLowerLmt_LTE_A));
        MOVS     R3,#+2
        ADD      R2,R5,#+64
        ADDS     R1,R7,R4
        MOVW     R0,#+1390
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   77 	rlen += GenAidData(Aid_FwdGainSet_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainSet_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+66
        ADDS     R1,R7,R4
        MOVW     R0,#+1393
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   78 	rlen += GenAidData(Aid_FwdGainSts_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGain_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+67
        ADDS     R1,R7,R4
        MOVW     R0,#+1394
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   79 	rlen += GenAidData(Aid_RvsGainSet_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+68
        ADDS     R1,R7,R4
        MOVW     R0,#+1540
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   80 	rlen += GenAidData(Aid_RvsGainSts_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+69
        ADDS     R1,R7,R4
        MOVW     R0,#+1582
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   81 	rlen += GenAidData(Aid_RvsGainBalance_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+70
        ADDS     R1,R7,R4
        MOVW     R0,#+1581
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   82 	rlen += GenAidData(Aid_RvsGainSet_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+71
        ADDS     R1,R7,R4
        MOVW     R0,#+1551
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   83 	rlen += GenAidData(Aid_RvsGainSts_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+72
        ADDS     R1,R7,R4
        MOV      R0,#+1600
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   84 	rlen += GenAidData(Aid_RvsGainBalance_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+73
        ADDS     R1,R7,R4
        MOVW     R0,#+1599
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   85 	rlen += GenAidData(Aid_RvsGainSet_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+74
        ADDS     R1,R7,R4
        MOVW     R0,#+1652
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   86 	rlen += GenAidData(Aid_RvsGainSts_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+75
        ADDS     R1,R7,R4
        MOVW     R0,#+1655
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   87 	rlen += GenAidData(Aid_RvsGainBalance_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+76
        ADDS     R1,R7,R4
        MOVW     R0,#+1654
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   88 	rlen += GenAidData(Aid_RvsGainSet_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0GainSet_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+77
        ADDS     R1,R7,R4
        MOVW     R0,#+1658
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   89 	rlen += GenAidData(Aid_RvsGainSts_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainSts_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+78
        ADDS     R1,R7,R4
        MOVW     R0,#+1661
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   90 	rlen += GenAidData(Aid_RvsGainBalance_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainBalance_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+79
        ADDS     R1,R7,R4
        MOVW     R0,#+1660
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   91 	rlen += GenAidData(Aid_AmpOffCase_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+80
        ADDS     R1,R7,R4
        MOVW     R0,#+1807
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   92 	rlen += GenAidData(Aid_AmpOffCase_Common,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_Common), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+81
        ADDS     R1,R7,R4
        MOVW     R0,#+1878
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   93 	rlen += GenAidData(Aid_AmpOffCase_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+82
        ADDS     R1,R7,R4
        MOVW     R0,#+1877
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   94 	rlen += GenAidData(Aid_BandSelect_15M,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->BandSelect_15M), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+86
        ADDS     R1,R7,R4
        MOVW     R0,#+4185
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   95 
//   96 	rlen += GenAidData(Aid_AGCOnOff_3G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+93
        ADDS     R1,R7,R4
        MOVW     R0,#+2314
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   97 	rlen += GenAidData(Aid_AGCOnOff_2G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+94
        ADDS     R1,R7,R4
        MOVW     R0,#+2357
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   98 	rlen += GenAidData(Aid_AGCOnOff_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+97
        ADDS     R1,R7,R4
        MOVW     R0,#+4177
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//   99 	rlen += GenAidData(Aid_AGCOnOff_LTE_A,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCOnOff_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+98
        ADDS     R1,R7,R4
        MOVW     R0,#+4178
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  100 	rlen += GenAidData(Aid_AGC1OnOff_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGC1OnOff_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+101
        ADDS     R1,R7,R4
        MOVW     R0,#+4191
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  101 	rlen += GenAidData(Aid_AGC1OnOff_LTE_A,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGC1OnOff_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+102
        ADDS     R1,R7,R4
        MOV      R0,#+4192
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  102 
//  103 	rlen += GenAidData(Aid_AGCMode_3G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+95
        ADDS     R1,R7,R4
        MOVW     R0,#+4187
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  104 	rlen += GenAidData(Aid_AGCMode_2G,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+96
        ADDS     R1,R7,R4
        MOVW     R0,#+4188
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  105 	rlen += GenAidData(Aid_AGCMode_LTE, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+99
        ADDS     R1,R7,R4
        MOVW     R0,#+4189
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  106 	rlen += GenAidData(Aid_AGCMode_LTE_A,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AGCMode_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+100
        ADDS     R1,R7,R4
        MOVW     R0,#+4190
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  107 	rlen += GenAidData(Aid_AutoReportPriod, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AutoReportPriod), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+88
        ADDS     R1,R7,R4
        MOVW     R0,#+2338
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  108 
//  109 	// AutoReportTime
//  110 	dptr[rlen++] = (Aid_ReportTime >> 8) & 0xff;
        MOVS     R2,#+9
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  111 	dptr[rlen++] = (Aid_ReportTime >> 0) & 0xff;
        MOVS     R2,#+35
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  112 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  113 	dptr[rlen++] = Sts->AutoReportTime_H; 
        LDRB     R2,[R5, #+89]
        STRB     R2,[R0, R4]
        ADDS     R1,R0,#+1
        UXTH     R1,R1
//  114 	dptr[rlen++] = Sts->AutoReportTime_M; 
        ADD      R0,R5,#+89
        LDRB     R3,[R0, #+1]
        STRB     R3,[R1, R4]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  115 
//  116 	// ReportHours
//  117 	dptr[rlen++] = (Aid_ReportHours >> 8) & 0xff;
        MOVS     R3,#+9
        STRB     R3,[R1, R4]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  118 	dptr[rlen++] = (Aid_ReportHours >> 0) & 0xff;
        MOVS     R3,#+46
        STRB     R3,[R1, R4]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  119 	dptr[rlen++] = 2;
        MOVS     R3,#+2
        STRB     R3,[R1, R4]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  120 	dptr[rlen++] = Sts->PresentHour; 
        LDRB     R3,[R0, #+2]
        STRB     R3,[R1, R4]
        ADDS     R1,R1,#+1
        UXTH     R1,R1
//  121 	dptr[rlen++] = Sts->PresentMin; 
        LDRB     R0,[R0, #+3]
        STRB     R0,[R1, R4]
        ADDS     R7,R1,#+1
        UXTH     R7,R7
//  122 ///////////////////////////////////////////
//  123 	rlen += GenAidData(Aid_TPTL_OnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TPTL_OnOff), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+103
        ADDS     R1,R7,R4
        MOV      R0,#+40960
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  124 	rlen += GenAidData(Aid_TempOffset,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TempOffset), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+104
        ADDS     R1,R7,R4
        MOVW     R0,#+40961
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  125 	rlen += GenAidData(Aid_RCUAddVer,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RCUAddVer), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+105
        ADDS     R1,R7,R4
        MOVW     R0,#+40966
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  126 	rlen += GenAidData(Aid_AlarmMask,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AlarmMask), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+106
        ADDS     R1,R7,R4
        MOVW     R0,#+40973
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  127 	rlen += GenAidData(Aid_LedAlarm,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LedAlarm), sizeof(Sts->LedAlarm));
        MOVS     R3,#+6
        ADD      R2,R5,#+107
        ADDS     R1,R7,R4
        MOVW     R0,#+40974
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  128 	rlen += GenAidData(Aid_ModemMINNumber,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ModemStation), sizeof(Sts->ModemStation));
        MOVS     R3,#+11
        ADD      R2,R5,#+113
        ADDS     R1,R7,R4
        MOVW     R0,#+40975
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  129 	rlen += GenAidData(Aid_ESNCheck,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->BcMEsnNum), sizeof(Sts->BcMEsnNum));
        MOVS     R3,#+19
        ADD      R2,R5,#+124
        ADDS     R1,R7,R4
        MOVW     R0,#+40976
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  130 
//  131 	rlen += GenAidData(Aid_ModemOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ModemOnOff), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+143
        ADDS     R1,R7,R4
        MOVW     R0,#+40977
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  132 	rlen += GenAidData(Aid_ModuleAlarm, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Module_Alarm), sizeof(Sts->Module_Alarm));
        MOVS     R3,#+5
        ADD      R2,R5,#+144
        ADDS     R1,R7,R4
        MOVW     R0,#+40978
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  133 	rlen += GenAidData(Aid_ModuleTemp,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrentTemp), sizeof(Sts->CurrentTemp));
        MOVS     R3,#+1
        ADD      R2,R5,#+149
        ADDS     R1,R7,R4
        MOVW     R0,#+40979
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  134 	rlen += GenAidData(Aid_TableSts,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TableStatus), sizeof(Sts->TableStatus));
        MOVS     R3,#+1
        ADD      R2,R5,#+150
        ADDS     R1,R7,R4
        MOVW     R0,#+40980
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  135 	rlen += GenAidData(Aid_LockOrderSts,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->LockOrderSts), sizeof(Sts->LockOrderSts));
        MOVS     R3,#+1
        ADD      R2,R5,#+153
        ADDS     R1,R7,R4
        MOVW     R0,#+41002
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  136 
//  137 
//  138 	// VccDet_Lmt
//  139 	dptr[rlen++] = (Aid_VccDet_Lmt >> 8) & 0xff;
        MOVS     R2,#+160
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  140 	dptr[rlen++] = (Aid_VccDet_Lmt >> 0) & 0xff;
        MOVS     R2,#+43
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  141 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  142 	dptr[rlen++] = (Sts->VccDet_Lmt.Byte.High);
        LDRH     R2,[R5, #+154]
        LSRS     R2,R2,#+8
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  143 	dptr[rlen++] = (Sts->VccDet_Lmt.Byte.Low);
        LDRH     R2,[R5, #+154]
        STRB     R2,[R0, R4]
        ADDS     R7,R0,#+1
        UXTH     R7,R7
//  144 
//  145 	rlen += GenAidData(Aid_FwdInPwrOffset_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwrOffset_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+156
        ADDS     R1,R7,R4
        MOVW     R0,#+41217
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  146 	rlen += GenAidData(Aid_FwdInPwrOffset_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwrOffset_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+157
        ADDS     R1,R7,R4
        MOVW     R0,#+41218
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  147 	rlen += GenAidData(Aid_Rvs0OutPwrOffset_2G, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutPwrOffset_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+158
        ADDS     R1,R7,R4
        MOVW     R0,#+41225
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  148 	rlen += GenAidData(Aid_Rvs0OutPwrOffset_3G, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutPwrOffset_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+159
        ADDS     R1,R7,R4
        MOVW     R0,#+41227
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  149 	rlen += GenAidData(Aid_FwdOutPwrOffset_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwrOffset_2G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+160
        ADDS     R1,R7,R4
        MOVW     R0,#+41410
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  150 	rlen += GenAidData(Aid_FwdOutPwrOffset_3G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwrOffset_3G), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+161
        ADDS     R1,R7,R4
        MOVW     R0,#+41305
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  151 	rlen += GenAidData(Aid_FwdAttn1_2G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+162
        ADDS     R1,R7,R4
        MOVW     R0,#+41310
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  152 	rlen += GenAidData(Aid_FwdAttn2_2G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+163
        ADDS     R1,R7,R4
        MOVW     R0,#+41311
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  153 	rlen += GenAidData(Aid_FwdAttn1_3G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+164
        ADDS     R1,R7,R4
        MOVW     R0,#+41314
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  154 	rlen += GenAidData(Aid_FwdAttn2_3G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+165
        ADDS     R1,R7,R4
        MOVW     R0,#+41315
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  155 	rlen += GenAidData(Aid_RvsAttn1_2G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+166
        ADDS     R1,R7,R4
        MOVW     R0,#+41318
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  156 	rlen += GenAidData(Aid_RvsAttn2_2G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+167
        ADDS     R1,R7,R4
        MOVW     R0,#+41319
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  157 	rlen += GenAidData(Aid_RvsAttn3_2G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+168
        ADDS     R1,R7,R4
        MOVW     R0,#+41320
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  158 	rlen += GenAidData(Aid_RvsAttn1_3G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+170
        ADDS     R1,R7,R4
        MOVW     R0,#+41322
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  159 	rlen += GenAidData(Aid_RvsAttn2_3G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+171
        ADDS     R1,R7,R4
        MOVW     R0,#+41323
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  160 	rlen += GenAidData(Aid_RvsAttn3_3G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+172
        ADDS     R1,R7,R4
        MOVW     R0,#+41324
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  161 	rlen += GenAidData(Aid_RvsAttn4_3G, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn4_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+173
        ADDS     R1,R7,R4
        MOVW     R0,#+41325
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  162 	rlen += GenAidData(Aid_ResetPeriodCountSts, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ResetPeriodCountSts), sizeof(Sts->ResetPeriodCountSts));
        MOVS     R3,#+3
        ADD      R2,R5,#+185
        ADDS     R1,R7,R4
        MOVW     R0,#+41405
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  163 	rlen += GenAidData(Aid_ResetPeriodCountSet, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ResetPeriodCountSet), sizeof(Sts->ResetPeriodCountSet));
        MOVS     R3,#+3
        ADD      R2,R5,#+188
        ADDS     R1,R7,R4
        MOVW     R0,#+41406
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  164 	rlen += GenAidData(Aid_FwdInPwrOffset_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdInPwrOffset_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+191
        ADDS     R1,R7,R4
        MOVW     R0,#+41411
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  165 	rlen += GenAidData(Aid_FwdOutPwrOffset_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdOutPwrOffset_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+192
        ADDS     R1,R7,R4
        MOVW     R0,#+41412
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  166 	rlen += GenAidData(Aid_Rvs0OutPwrOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsOutPwrOffset_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+193
        ADDS     R1,R7,R4
        MOVW     R0,#+41421
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  167 	rlen += GenAidData(Aid_SmsFwdInPwr_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->SmsFwdInPwr_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+194
        ADDS     R1,R7,R4
        MOVW     R0,#+41800
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  168 	rlen += GenAidData(Aid_SmsFwdInPwr_2G,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->SmsFwdInPwr_2G), sizeof(Sts->SmsFwdInPwr_2G));
        MOVS     R3,#+1
        ADD      R2,R5,#+195
        ADDS     R1,R7,R4
        MOVW     R0,#+41801
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  169 	rlen += GenAidData(Aid_SmsRvsOutPwr_3G, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_3G), sizeof(Sts->RvsOutPwr_3G));
        MOVS     R3,#+2
        ADD      R2,R5,#+196
        ADDS     R1,R7,R4
        MOVW     R0,#+41802
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  170 	rlen += GenAidData(Aid_SmsRvsOutPwr_2G, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_2G), sizeof(Sts->RvsOutPwr_2G));
        MOVS     R3,#+2
        ADD      R2,R5,#+198
        ADDS     R1,R7,R4
        MOVW     R0,#+41803
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  171 	rlen += GenAidData(Aid_ShutDownOnOff_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ShutDownOnOff_3G), sizeof(Sts->ShutDownOnOff_3G));
        MOVS     R3,#+1
        ADD      R2,R5,#+201
        ADDS     R1,R7,R4
        MOVW     R0,#+41804
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  172 	rlen += GenAidData(Aid_ShutDownOnOff_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ShutDownOnOff_2G), sizeof(Sts->ShutDownOnOff_2G));
        MOVS     R3,#+1
        ADD      R2,R5,#+202
        ADDS     R1,R7,R4
        MOVW     R0,#+41805
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  173 	rlen += GenAidData(Aid_RvsOutUpperLmt_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_3G), sizeof(Sts->RvsOutUpperLmt_3G));
        MOVS     R3,#+2
        ADD      R2,R5,#+203
        ADDS     R1,R7,R4
        MOVW     R0,#+41831
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  174 	rlen += GenAidData(Aid_RvsOutUpperLmt_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_2G), sizeof(Sts->RvsOutUpperLmt_2G));
        MOVS     R3,#+2
        ADD      R2,R5,#+205
        ADDS     R1,R7,R4
        MOVW     R0,#+41833
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  175 	rlen += GenAidData(Aid_FwdGainOffset_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainOffset_3G), sizeof(Sts->FwdGainOffset_3G));
        MOVS     R3,#+1
        ADD      R2,R5,#+207
        ADDS     R1,R7,R4
        MOVW     R0,#+41834
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  176 	rlen += GenAidData(Aid_RvsGainOffset_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainOffset_3G), sizeof(Sts->RvsGainOffset_3G));
        MOVS     R3,#+1
        ADD      R2,R5,#+208
        ADDS     R1,R7,R4
        MOVW     R0,#+41835
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  177 	rlen += GenAidData(Aid_FwdGainOffset_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdGainOffset_2G), sizeof(Sts->FwdGainOffset_2G));
        MOVS     R3,#+1
        ADD      R2,R5,#+209
        ADDS     R1,R7,R4
        MOVW     R0,#+41836
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  178 	rlen += GenAidData(Aid_RvsGainOffset_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsGainOffset_2G), sizeof(Sts->RvsGainOffset_2G));
        MOVS     R3,#+1
        ADD      R2,R5,#+210
        ADDS     R1,R7,R4
        MOVW     R0,#+41837
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  179 	rlen += GenAidData(Aid_FwdTemp_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdTemp_3G), sizeof(Sts->FwdTemp_3G));
        MOVS     R3,#+1
        ADD      R2,R5,#+211
        ADDS     R1,R7,R4
        MOVW     R0,#+41838
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  180 	rlen += GenAidData(Aid_RvsTemp_3G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsTemp_3G), sizeof(Sts->RvsTemp_3G));
        MOVS     R3,#+1
        ADD      R2,R5,#+212
        ADDS     R1,R7,R4
        MOVW     R0,#+41839
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  181 	rlen += GenAidData(Aid_FwdTemp_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdTemp_2G), sizeof(Sts->FwdTemp_2G));
        MOVS     R3,#+1
        ADD      R2,R5,#+213
        ADDS     R1,R7,R4
        MOVW     R0,#+41840
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  182 	rlen += GenAidData(Aid_RvsTemp_2G,			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsTemp_2G), sizeof(Sts->RvsTemp_2G));
        MOVS     R3,#+1
        ADD      R2,R5,#+214
        ADDS     R1,R7,R4
        MOVW     R0,#+41841
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  183 	rlen += GenAidData(Aid_FwdOutHighLmt_3G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_3G), sizeof(Sts->FwdOutHighLmt_3G));
        MOVS     R3,#+2
        ADD      R2,R5,#+215
        ADDS     R1,R7,R4
        MOVW     R0,#+41843
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  184 	rlen += GenAidData(Aid_FwdOutHighLmt_2G,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_2G), sizeof(Sts->FwdOutHighLmt_2G));
        MOVS     R3,#+2
        ADD      R2,R5,#+217
        ADDS     R1,R7,R4
        MOVW     R0,#+41844
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  185 	rlen += GenAidData(Aid_DebugOnOff,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->DebugOnOff, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+219
        ADDS     R1,R7,R4
        MOVW     R0,#+41873
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  186 	rlen += GenAidData(Aid_RadioMeasureOnOff,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RadioMeasureOnOff, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+220
        ADDS     R1,R7,R4
        MOVW     R0,#+41874
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  187 
//  188 	// Adc_Value
//  189 	dptr[rlen++] = (Aid_DetVolt >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  190 	dptr[rlen++] = (Aid_DetVolt >> 0) & 0xff;
        MOVS     R2,#+0
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  191 	dptr[rlen++] = sizeof(__DETVOLT);
        MOVS     R2,#+76
        STRB     R2,[R0, R4]
        ADDS     R7,R0,#+1
        UXTH     R7,R7
//  192 	{
//  193 		INT8U j;
//  194 		__TBL16 r;
//  195 		
//  196 		for(j = 0; j < sizeof(__DETVOLT)/2; j++)
        MOV      R0,R5
        MOVS     R1,#+38
//  197 		{
//  198 			r.Data = *((INT16U *)&Sts->DetVolt + j);
??GenDnrAidSts_2:
        LDRH     R2,[R0, #+221]
        STRH     R2,[SP, #+0]
//  199 		
//  200 			dptr[rlen++] = r.Byte.High;
        LSRS     R3,R2,#+8
        STRB     R3,[R7, R4]
        ADDS     R2,R7,#+1
        UXTH     R2,R2
//  201 			dptr[rlen++] = r.Byte.Low;
        LDRH     R7,[SP, #+0]
        STRB     R7,[R2, R4]
        ADDS     R7,R2,#+1
        UXTH     R7,R7
//  202 		}	
        ADDS     R0,R0,#+2
        SUBS     R1,R1,#+1
        BNE.N    ??GenDnrAidSts_2
//  203 	}
//  204 
//  205 	rlen += GenAidData(Aid_DetPwr,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DetPwr), sizeof(Sts->DetPwr));
        MOVS     R3,#+22
        ADDW     R2,R5,#+297
        ADDS     R1,R7,R4
        MOVW     R0,#+43009
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  206 	rlen += GenAidData(Aid_DetOffset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->DetOffset), sizeof(Sts->DetOffset));
        MOVS     R3,#+22
        ADDW     R2,R5,#+319
        ADDS     R1,R7,R4
        MOVW     R0,#+43010
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  207 	rlen += GenAidData(Aid_AttValue,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AttValue), sizeof(Sts->AttValue));
        MOVS     R3,#+43
        ADDW     R2,R5,#+341
        ADDS     R1,R7,R4
        MOVW     R0,#+43011
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  208 	rlen += GenAidData(Aid_AttOffset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AttOffset), sizeof(Sts->AttOffset));
        MOVS     R3,#+43
        ADD      R2,R5,#+384
        ADDS     R1,R7,R4
        MOVW     R0,#+43012
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  209 	rlen += GenAidData(Aid_FwdInPwrOffset_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdInPwrOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+427
        ADDS     R1,R7,R4
        MOVW     R0,#+43013
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  210 	rlen += GenAidData(Aid_FwdOutPwrOffset_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdOutPwrOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+428
        ADDS     R1,R7,R4
        MOVW     R0,#+43014
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  211 	rlen += GenAidData(Aid_RvsOutPwrOffset_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsOutPwrOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+429
        ADDS     R1,R7,R4
        MOVW     R0,#+43015
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  212 	rlen += GenAidData(Aid_FwdAttn1_Common, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_Common, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+430
        ADDS     R1,R7,R4
        MOVW     R0,#+43016
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  213 	rlen += GenAidData(Aid_RvsAttn1_Common, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_Common, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+431
        ADDS     R1,R7,R4
        MOVW     R0,#+43019
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  214 
//  215 	rlen += GenAidData(Aid_FwdAttn2_Common, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_Common, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+434
        ADDS     R1,R7,R4
        MOVW     R0,#+43017
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  216 	rlen += GenAidData(Aid_RvsAttn2_Common, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_Common, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+435
        ADDS     R1,R7,R4
        MOVW     R0,#+43020
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  217 
//  218 	rlen += GenAidData(Aid_FwdAttn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+438
        ADDS     R1,R7,R4
        MOVW     R0,#+43024
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  219 	rlen += GenAidData(Aid_FwdAttn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+439
        ADDS     R1,R7,R4
        MOVW     R0,#+43025
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  220 	rlen += GenAidData(Aid_FwdAttn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn1_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+440
        ADDS     R1,R7,R4
        MOVW     R0,#+43028
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  221 	rlen += GenAidData(Aid_FwdAttn2_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAttn2_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+441
        ADDS     R1,R7,R4
        MOVW     R0,#+43029
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  222 	rlen += GenAidData(Aid_RvsAttn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+442
        ADDS     R1,R7,R4
        MOVW     R0,#+43032
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  223 	rlen += GenAidData(Aid_RvsAttn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+443
        ADDS     R1,R7,R4
        MOVW     R0,#+43033
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  224 	rlen += GenAidData(Aid_RvsAttn3_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+444
        ADDS     R1,R7,R4
        MOVW     R0,#+43034
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  225 	rlen += GenAidData(Aid_RvsAttn1_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn1_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+445
        ADDS     R1,R7,R4
        MOVW     R0,#+43037
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  226 	rlen += GenAidData(Aid_RvsAttn2_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn2_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+446
        ADDS     R1,R7,R4
        MOVW     R0,#+43038
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  227 	rlen += GenAidData(Aid_RvsAttn3_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn3_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+447
        ADDS     R1,R7,R4
        MOVW     R0,#+43039
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  228 	rlen += GenAidData(Aid_RvsAttn4_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAttn4_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+448
        ADDS     R1,R7,R4
        MOVW     R0,#+43040
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  229 //#if 0
//  230 
//  231 	rlen += GenAidData(Aid_FwdGainOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdGainOffset_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+460
        ADDS     R1,R7,R4
        MOVW     R0,#+43042
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  232 	rlen += GenAidData(Aid_RvsGainOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsGainOffset_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+461
        ADDS     R1,R7,R4
        MOVW     R0,#+43043
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  233 	rlen += GenAidData(Aid_FwdGainOffset_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdGainOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+462
        ADDS     R1,R7,R4
        MOVW     R0,#+43044
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  234 	rlen += GenAidData(Aid_RvsGainOffset_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsGainOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+463
        ADDS     R1,R7,R4
        MOVW     R0,#+43045
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  235 	rlen += GenAidData(Aid_FwdAgcAttn_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+464
        ADDS     R1,R7,R4
        MOVW     R0,#+43046
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  236 	rlen += GenAidData(Aid_FwdAgcAttn_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+465
        ADDS     R1,R7,R4
        MOVW     R0,#+43047
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  237 	rlen += GenAidData(Aid_FwdAgcAttn_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+466
        ADDS     R1,R7,R4
        MOVW     R0,#+43048
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  238 	rlen += GenAidData(Aid_FwdAgcAttn_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdAgcAttn_3G, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+467
        ADDS     R1,R7,R4
        MOVW     R0,#+43049
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  239 
//  240 	rlen += GenAidData(Aid_RvsAlcAttn_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+468
        ADDS     R1,R7,R4
        MOVW     R0,#+43050
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  241 	rlen += GenAidData(Aid_RvsAlcAttn_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+469
        ADDS     R1,R7,R4
        MOVW     R0,#+43051
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  242 	rlen += GenAidData(Aid_RvsAlcAttn_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+470
        ADDS     R1,R7,R4
        MOVW     R0,#+43052
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  243 	rlen += GenAidData(Aid_RvsAlcAttn_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcAttn_3G, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+471
        ADDS     R1,R7,R4
        MOVW     R0,#+43053
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  244 	rlen += GenAidData(Aid_RvsAlcOnOff_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_2G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+472
        ADDS     R1,R7,R4
        MOVW     R0,#+43054
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  245 	rlen += GenAidData(Aid_RvsAlcOnOff_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+473
        ADDS     R1,R7,R4
        MOVW     R0,#+43055
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  246 	rlen += GenAidData(Aid_RvsAlcOnOff_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+474
        ADDS     R1,R7,R4
        MOVW     R0,#+43056
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  247 	rlen += GenAidData(Aid_RvsAlcOnOff_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcOnOff_3G, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+475
        ADDS     R1,R7,R4
        MOVW     R0,#+43057
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  248 	rlen += GenAidData(Aid_SmsFwdInPwr_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->SmsFwdInPwr_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+476
        ADDS     R1,R7,R4
        MOVW     R0,#+43074
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  249 	rlen += GenAidData(Aid_SmsFwdInDet_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->SmsFwdInPwr_LTE_A, 1);
        MOVS     R3,#+1
        MOV      R2,R6
        ADDS     R1,R7,R4
        MOVW     R0,#+43075
        BL       GenAidData
        ADDS     R6,R0,R7
        UXTH     R6,R6
//  250 	rlen += GenAidData(Aid_RvsOutPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE), sizeof(Sts->RvsOutPwr_LTE));
        MOVS     R3,#+2
        ADD      R2,R5,#+478
        ADDS     R1,R6,R4
        MOVW     R0,#+43076
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  251 	rlen += GenAidData(Aid_RvsOutPwr_LTE_A, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPwr_LTE_A), sizeof(Sts->RvsOutPwr_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+481
        ADDS     R1,R6,R4
        MOVW     R0,#+43077
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  252 	rlen += GenAidData(Aid_RvsInPwr_2G, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_2G), sizeof(Sts->RvsInPwr_2G));
        MOVS     R3,#+2
        ADDW     R2,R5,#+483
        ADDS     R1,R6,R4
        MOVW     R0,#+43078
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  253 	rlen += GenAidData(Aid_RvsInPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE), sizeof(Sts->RvsInPwr_LTE));
        MOVS     R3,#+2
        ADD      R2,R5,#+486
        ADDS     R1,R6,R4
        MOVW     R0,#+43079
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  254 	rlen += GenAidData(Aid_RvsInPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_LTE_A), sizeof(Sts->RvsInPwr_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+489
        ADDS     R1,R6,R4
        MOVW     R0,#+43080
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  255 	rlen += GenAidData(Aid_RvsInPwr_3G, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_3G), sizeof(Sts->RvsInPwr_3G));
        MOVS     R3,#+2
        ADD      R2,R5,#+492
        ADDS     R1,R6,R4
        MOVW     R0,#+43081
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  256 	rlen += GenAidData(Aid_ShutDownOnOff_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+495
        ADDS     R1,R6,R4
        MOVW     R0,#+43082
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  257 	rlen += GenAidData(Aid_ShutDownOnOff_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+496
        ADDS     R1,R6,R4
        MOVW     R0,#+43083
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  258 	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE), sizeof(Sts->RvsOutUpperLmt_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+497
        ADDS     R1,R6,R4
        MOVW     R0,#+43084
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  259 	rlen += GenAidData(Aid_RvsOutUpperLmt_LTE_A,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutUpperLmt_LTE_A), sizeof(Sts->RvsOutUpperLmt_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+499
        ADDS     R1,R6,R4
        MOVW     R0,#+43085
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  260 	rlen += GenAidData(Aid_FwdTemp_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdTemp_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+501
        ADDS     R1,R6,R4
        MOVW     R0,#+43086
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  261 	rlen += GenAidData(Aid_RvsTemp_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsTemp_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+502
        ADDS     R1,R6,R4
        MOVW     R0,#+43087
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  262 	rlen += GenAidData(Aid_FwdTemp_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->FwdTemp_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+503
        ADDS     R1,R6,R4
        MOVW     R0,#+43088
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  263 	rlen += GenAidData(Aid_RvsTemp_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsTemp_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+504
        ADDS     R1,R6,R4
        MOVW     R0,#+43089
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  264 	rlen += GenAidData(Aid_FwdOutHighLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE), sizeof(Sts->FwdOutHighLmt_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+505
        ADDS     R1,R6,R4
        MOVW     R0,#+43090
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  265 	rlen += GenAidData(Aid_FwdOutHighLmt_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutHighLmt_LTE_A), sizeof(Sts->FwdOutHighLmt_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+507
        ADDS     R1,R6,R4
        MOVW     R0,#+43091
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  266 	rlen += GenAidData(Aid_OverInAlarmLmt_2G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_2G, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+509
        ADDS     R1,R6,R4
        MOVW     R0,#+43092
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  267 	rlen += GenAidData(Aid_OverInAlarmLmt_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+510
        ADDS     R1,R6,R4
        MOVW     R0,#+43093
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  268 	rlen += GenAidData(Aid_OverInAlarmLmt_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+511
        ADDS     R1,R6,R4
        MOVW     R0,#+43094
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  269 	rlen += GenAidData(Aid_OverInAlarmLmt_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->OverInAlarmLmt_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+512
        ADDS     R1,R6,R4
        MOVW     R0,#+43095
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  270 	rlen += GenAidData(Aid_OtherOverInAlarmLmt_2G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->OtherOverInAlarmLmt_2G, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+513
        ADDS     R1,R6,R4
        MOVW     R0,#+43096
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  271 	rlen += GenAidData(Aid_OtherOverInAlarmLmt_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->OtherOverInAlarmLmt_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+514
        ADDS     R1,R6,R4
        MOVW     R0,#+43097
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  272 	rlen += GenAidData(Aid_OtherOverInAlarmLmt_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->OtherOverInAlarmLmt_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+515
        ADDS     R1,R6,R4
        MOVW     R0,#+43098
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  273 	rlen += GenAidData(Aid_OtherOverInAlarmLmt_3G,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->OtherOverInAlarmLmt_3G, 1);	
        MOVS     R3,#+1
        ADD      R2,R5,#+516
        ADDS     R1,R6,R4
        MOVW     R0,#+43099
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  274 	rlen += GenAidData(Aid_RvsALCLvl_2G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_2G, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+517
        ADDS     R1,R6,R4
        MOVW     R0,#+43101
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  275 	rlen += GenAidData(Aid_RvsALCLvl_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+518
        ADDS     R1,R6,R4
        MOVW     R0,#+43102
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  276 	rlen += GenAidData(Aid_RvsALCLvl_LTE_A, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+519
        ADDS     R1,R6,R4
        MOVW     R0,#+43103
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  277 	rlen += GenAidData(Aid_RvsALCLvl_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsALCLvl_3G, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+520
        ADDS     R1,R6,R4
        MOVW     R0,#+43104
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  278 #if 1
//  279 
//  280 ///////////////Wave
//  281 	rlen += GenAidData(Aid_SMS_TxRetry, 			(INT8U *)&dptr[rlen], (INT8U *)&Sts->SMS_TxRetry, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+602
        ADDS     R1,R6,R4
        MOV      R0,#+3072
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  282 	rlen += GenAidData(Aid_ActChannel,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->ActChannel), sizeof(Sts->ActChannel));
        MOVS     R3,#+2
        ADDW     R2,R5,#+603
        ADDS     R1,R6,R4
        MOVW     R0,#+3073
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  283 	rlen += GenAidData(Aid_OneFAStatus, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->OneFAStatus), sizeof(Sts->OneFAStatus));
        MOVS     R3,#+1
        ADDW     R2,R5,#+605
        ADDS     R1,R6,R4
        MOVW     R0,#+3074
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  284 
//  285 	rlen += GenAidData(Aid_RxMaxVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RxMaxVal), sizeof(Sts->RxMaxVal));
        MOVS     R3,#+2
        ADD      R2,R5,#+572
        ADDS     R1,R6,R4
        MOVW     R0,#+3075
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  286 	rlen += GenAidData(Aid_RxMinVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RxMinVal), sizeof(Sts->RxMinVal));
        MOVS     R3,#+2
        ADDW     R2,R5,#+574
        ADDS     R1,R6,R4
        MOVW     R0,#+3076
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  287 	rlen += GenAidData(Aid_TxMaxVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TxMaxVal), sizeof(Sts->TxMaxVal));
        MOVS     R3,#+2
        ADD      R2,R5,#+576
        ADDS     R1,R6,R4
        MOVW     R0,#+3077
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  288 	rlen += GenAidData(Aid_TxMinVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TxMinVal), sizeof(Sts->TxMinVal));
        MOVS     R3,#+2
        ADDW     R2,R5,#+578
        ADDS     R1,R6,R4
        MOVW     R0,#+3078
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  289 	rlen += GenAidData(Aid_AdjMaxVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AdjMaxVal), sizeof(Sts->AdjMaxVal));
        MOVS     R3,#+2
        ADD      R2,R5,#+580
        ADDS     R1,R6,R4
        MOVW     R0,#+3079
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  290 	rlen += GenAidData(Aid_AdjMinVal,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AdjMinVal), sizeof(Sts->AdjMinVal));
        MOVS     R3,#+2
        ADDW     R2,R5,#+582
        ADDS     R1,R6,R4
        MOVW     R0,#+3080
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  291 	rlen += GenAidData(Aid_EcIo,					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->EcIo), sizeof(Sts->EcIo));
        MOVS     R3,#+1
        ADD      R2,R5,#+584
        ADDS     R1,R6,R4
        MOVW     R0,#+3081
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  292 	rlen += GenAidData(Aid_FARxValue,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FARxVal), sizeof(Sts->FARxVal));
        MOVS     R3,#+2
        ADDW     R2,R5,#+606
        ADDS     R1,R6,R4
        MOVW     R0,#+3082
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  293 	rlen += GenAidData(Aid_FAAdjValue,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FAAdjVal), sizeof(Sts->FAAdjVal));
        MOVS     R3,#+2
        ADDW     R2,R5,#+626
        ADDS     R1,R6,R4
        MOVW     R0,#+3083
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  294 	rlen += GenAidData(Aid_FAFerValue,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->FAFerVal), sizeof(Sts->FAFerVal));
        MOVS     R3,#+1
        ADD      R2,R5,#+628
        ADDS     R1,R6,R4
        MOVW     R0,#+3084
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  295 	rlen += GenAidData(Aid_PN_Val,					(INT8U *)&dptr[rlen], (INT8U *)&(Sts->PN_Val), sizeof(Sts->PN_Val));
        MOVS     R3,#+12
        ADD      R2,R5,#+608
        ADDS     R1,R6,R4
        MOVW     R0,#+3085
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  296 	rlen += GenAidData(Aid_EcIo_Val,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->EcIo_Val), sizeof(Sts->EcIo_Val));
        MOVS     R3,#+6
        ADD      R2,R5,#+620
        ADDS     R1,R6,R4
        MOVW     R0,#+3086
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  297 
//  298 
//  299 //	rlen += GenAidData(Aid_Tx_Time, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Tx_Time), sizeof(Sts->PN_Val));
//  300 //	rlen += GenAidData(Aid_Master_PN,				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Master_PN), sizeof(Sts->PN_Val));
//  301 
//  302 	rlen += GenAidData(Aid_AR_Mode, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->AR_Mode), sizeof(Sts->AR_Mode));
        MOVS     R3,#+2
        ADDW     R2,R5,#+585
        ADDS     R1,R6,R4
        MOVW     R0,#+3089
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  303 	rlen += GenAidData(Aid_Radio_ReportTime,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Radio_ReportTime), sizeof(Sts->Radio_ReportTime));
        MOVS     R3,#+2
        ADDW     R2,R5,#+587
        ADDS     R1,R6,R4
        MOVW     R0,#+3090
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  304 	rlen += GenAidData(Aid_Radio_ReportPeriod,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Radio_ReportPeriod), sizeof(Sts->Radio_ReportPeriod));
        MOVS     R3,#+2
        ADDW     R2,R5,#+589
        ADDS     R1,R6,R4
        MOVW     R0,#+3091
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  305 	rlen += GenAidData(Aid_TestStn, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->TestStn), sizeof(Sts->TestStn));
        MOVS     R3,#+11
        ADDW     R2,R5,#+591
        ADDS     R1,R6,R4
        MOVW     R0,#+3092
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  306 
//  307 	rlen += GenAidData(Aid_RFAlarm, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->RFAlarm), sizeof(Sts->RFAlarm));
        MOVS     R3,#+2
        ADDW     R2,R5,#+629
        ADDS     R1,R6,R4
        MOVW     R0,#+58627
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  308 
//  309 	rlen += GenAidData(Aid_System_Time, 			(INT8U *)&dptr[rlen], (INT8U *)&(Sts->System_Time), sizeof(Sts->System_Time));
        MOVS     R3,#+6
        ADDW     R2,R5,#+631
        ADDS     R1,R6,R4
        MOVW     R0,#+58628
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  310 	rlen += GenAidData(Aid_Tx_Time, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Tx_Time), sizeof(Sts->Tx_Time));
        MOVS     R3,#+6
        ADDW     R2,R5,#+637
        ADDS     R1,R6,R4
        MOVW     R0,#+58629
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  311 	rlen += GenAidData(Aid_Ar_Time, 				(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Ar_Time), sizeof(Sts->Ar_Time));
        MOVS     R3,#+6
        ADDW     R2,R5,#+643
        ADDS     R1,R6,R4
        MOVW     R0,#+58630
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  312 
//  313 	rlen += GenAidData16(Aid_AR_Delay0, 			(INT8U *)&dptr[rlen], Sts->AR_Delay0, sizeof(Sts->AR_Delay0));
        MOVS     R3,#+2
        LDRH     R2,[R5, #+649]
        ADDS     R1,R6,R4
        MOVW     R0,#+58631
        BL       GenAidData16
        ADDS     R7,R0,R6
        UXTH     R7,R7
//  314 	rlen += GenAidData16(Aid_AR_Delay1, 			(INT8U *)&dptr[rlen], Sts->AR_Delay1, sizeof(Sts->AR_Delay1));
        ADDW     R6,R5,#+649
        MOVS     R3,#+2
        LDRH     R2,[R6, #+2]
        ADDS     R1,R7,R4
        MOVW     R0,#+58632
        BL       GenAidData16
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  315 	rlen += GenAidData16(Aid_AR_Delay2, 			(INT8U *)&dptr[rlen], Sts->AR_Delay2, sizeof(Sts->AR_Delay2));
        MOVS     R3,#+2
        LDRH     R2,[R6, #+4]
        ADDS     R1,R7,R4
        MOVW     R0,#+58633
        BL       GenAidData16
        ADDS     R6,R0,R7
        UXTH     R6,R6
//  316 #endif
//  317 
//  318 #ifdef _MIMO_Type 
//  319 	rlen += GenAidData(Aid_Fwd1OutPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutPwr_LTE), sizeof(Sts->Fwd1OutPwr_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+655
        ADDS     R1,R6,R4
        MOV      R0,#+6912
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  320 	rlen += GenAidData(Aid_Fwd1OutUpperLmt_LTE, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutUpperLmt_LTE), sizeof(Sts->Fwd1OutUpperLmt_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+657
        ADDS     R1,R6,R4
        MOVW     R0,#+6913
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  321 	rlen += GenAidData(Aid_Fwd1OutLowerLmt_LTE, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutLowerLmt_LTE), sizeof(Sts->Fwd1OutLowerLmt_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+659
        ADDS     R1,R6,R4
        MOVW     R0,#+6914
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  322 	rlen += GenAidData(Aid_Fwd1GainSet_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1GainSet_LTE), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+661
        ADDS     R1,R6,R4
        MOVW     R0,#+6915
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  323 	rlen += GenAidData(Aid_Fwd1GainSts_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1Gain_LTE), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+662
        ADDS     R1,R6,R4
        MOVW     R0,#+6916
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  324 	rlen += GenAidData(Aid_Fwd1OutPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutPwr_LTE_A), sizeof(Sts->Fwd1OutPwr_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+663
        ADDS     R1,R6,R4
        MOVW     R0,#+6918
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  325 	rlen += GenAidData(Aid_Fwd1OutUpperLmt_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutUpperLmt_LTE_A), sizeof(Sts->Fwd1OutUpperLmt_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+665
        ADDS     R1,R6,R4
        MOVW     R0,#+6919
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  326 	rlen += GenAidData(Aid_Fwd1OutLowerLmt_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutLowerLmt_LTE_A), sizeof(Sts->Fwd1OutLowerLmt_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+667
        ADDS     R1,R6,R4
        MOVW     R0,#+6920
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  327 	rlen += GenAidData(Aid_Fwd1GainSet_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1GainSet_LTE_A), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+669
        ADDS     R1,R6,R4
        MOVW     R0,#+6921
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  328 	rlen += GenAidData(Aid_Fwd1GainSts_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1Gain_LTE_A), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+670
        ADDS     R1,R6,R4
        MOVW     R0,#+6928
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  329 	rlen += GenAidData(Aid_Rvs1GainSet_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSet_LTE), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+671
        ADDS     R1,R6,R4
        MOV      R0,#+7168
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  330 	rlen += GenAidData(Aid_Rvs1GainSts_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSts_LTE), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+672
        ADDS     R1,R6,R4
        MOVW     R0,#+7171
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  331 	rlen += GenAidData(Aid_Rvs1GainBalance_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainBalance_LTE), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+673
        ADDS     R1,R6,R4
        MOVW     R0,#+7170
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  332 	rlen += GenAidData(Aid_Rvs1GainSet_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSet_LTE_A), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+674
        ADDS     R1,R6,R4
        MOVW     R0,#+7173
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  333 	rlen += GenAidData(Aid_Rvs1GainSts_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainSts_LTE_A), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+675
        ADDS     R1,R6,R4
        MOVW     R0,#+7176
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  334 	rlen += GenAidData(Aid_Rvs1GainBalance_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1GainBalance_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+676
        ADDS     R1,R6,R4
        MOVW     R0,#+7175
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  335 	rlen += GenAidData(Aid_Amp1OffCase_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Amp1OffCase_LTE), 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+679
        ADDS     R1,R6,R4
        MOVW     R0,#+1879
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  336 	rlen += GenAidData(Aid_Amp1OffCase_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Amp1OffCase_LTE_A), 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+680
        ADDS     R1,R6,R4
        MOV      R0,#+1880
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  337 
//  338 ////////////////////////////////////////////
//  339 
//  340 	// Adc_Value
//  341 	dptr[rlen++] = (Aid_Det1Volt >> 8) & 0xff;
        MOVS     R2,#+169
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  342 	dptr[rlen++] = (Aid_Det1Volt >> 0) & 0xff;
        MOVS     R2,#+0
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  343 	dptr[rlen++] = sizeof(__DET1VOLT);
        MOVS     R2,#+28
        STRB     R2,[R0, R4]
        ADDS     R6,R0,#+1
        UXTH     R6,R6
//  344 	{
//  345 		INT8U j;
//  346 		__TBL16 r;
//  347 		
//  348 		for(j = 0; j < sizeof(__DET1VOLT)/2; j++)
        MOV      R0,R5
        MOVS     R1,#+14
//  349 		{
//  350 			r.Data = *((INT16U *)&Sts->Det1Volt + j);
??GenDnrAidSts_3:
        LDRH     R2,[R0, #+681]
        STRH     R2,[SP, #+0]
//  351 		
//  352 			dptr[rlen++] = r.Byte.High;
        LSRS     R3,R2,#+8
        STRB     R3,[R6, R4]
        ADDS     R2,R6,#+1
        UXTH     R2,R2
//  353 			dptr[rlen++] = r.Byte.Low;
        LDRH     R6,[SP, #+0]
        STRB     R6,[R2, R4]
        ADDS     R6,R2,#+1
        UXTH     R6,R6
//  354 		}	
        ADDS     R0,R0,#+2
        SUBS     R1,R1,#+1
        BNE.N    ??GenDnrAidSts_3
//  355 	}
//  356 
//  357 	rlen += GenAidData(Aid_Det1Pwr, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Det1Pwr), sizeof(Sts->Det1Pwr));
        MOVS     R3,#+8
        ADDW     R2,R5,#+709
        ADDS     R1,R6,R4
        MOVW     R0,#+43265
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  358 	rlen += GenAidData(Aid_Det1Offset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Det1Offset), sizeof(Sts->Det1Offset));
        MOVS     R3,#+8
        ADDW     R2,R5,#+717
        ADDS     R1,R6,R4
        MOVW     R0,#+43266
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  359 	rlen += GenAidData(Aid_Att1Value,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Att1Value), sizeof(Sts->Att1Value));
        MOVS     R3,#+17
        ADDW     R2,R5,#+725
        ADDS     R1,R6,R4
        MOVW     R0,#+43267
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  360 	rlen += GenAidData(Aid_Att1Offset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Att1Offset), sizeof(Sts->Att1Offset));
        MOVS     R3,#+17
        ADDW     R2,R5,#+742
        ADDS     R1,R6,R4
        MOVW     R0,#+43268
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  361 	rlen += GenAidData(Aid_Fwd1InPwrOffset_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1InPwrOffset_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+759
        ADDS     R1,R6,R4
        MOVW     R0,#+43269
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  362 	rlen += GenAidData(Aid_Fwd1OutPwrOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1OutPwrOffset_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+760
        ADDS     R1,R6,R4
        MOVW     R0,#+43270
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  363 	rlen += GenAidData(Aid_Rvs1OutPwrOffset_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1OutPwrOffset_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+761
        ADDS     R1,R6,R4
        MOVW     R0,#+43271
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  364 	rlen += GenAidData(Aid_Fwd1InPwrOffset_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1InPwrOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+762
        ADDS     R1,R6,R4
        MOVW     R0,#+43272
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  365 	rlen += GenAidData(Aid_Fwd1OutPwrOffset_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1OutPwrOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+763
        ADDS     R1,R6,R4
        MOVW     R0,#+43273
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  366 	rlen += GenAidData(Aid_Rvs1OutPwrOffset_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1OutPwrOffset_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+764
        ADDS     R1,R6,R4
        MOVW     R0,#+43274
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  367 	rlen += GenAidData(Aid_Fwd1Attn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn1_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+765
        ADDS     R1,R6,R4
        MOVW     R0,#+43275
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  368 	rlen += GenAidData(Aid_Fwd1Attn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn2_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+766
        ADDS     R1,R6,R4
        MOVW     R0,#+43276
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  369 	rlen += GenAidData(Aid_Fwd1Attn1_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn1_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+767
        ADDS     R1,R6,R4
        MOVW     R0,#+43279
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  370 	rlen += GenAidData(Aid_Fwd1Attn2_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Attn2_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+768
        ADDS     R1,R6,R4
        MOVW     R0,#+43280
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  371 	rlen += GenAidData(Aid_Rvs1Attn1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn1_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+769
        ADDS     R1,R6,R4
        MOVW     R0,#+43283
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  372 	rlen += GenAidData(Aid_Rvs1Attn2_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn2_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+770
        ADDS     R1,R6,R4
        MOVW     R0,#+43284
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  373 	rlen += GenAidData(Aid_Rvs1Attn3_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn3_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+771
        ADDS     R1,R6,R4
        MOVW     R0,#+43285
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  374 	rlen += GenAidData(Aid_Rvs1Attn4_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn4_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+772
        ADDS     R1,R6,R4
        MOVW     R0,#+43286
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  375 	rlen += GenAidData(Aid_Rvs1Attn1_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn1_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+773
        ADDS     R1,R6,R4
        MOVW     R0,#+43288
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  376 	rlen += GenAidData(Aid_Rvs1Attn2_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn2_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+774
        ADDS     R1,R6,R4
        MOVW     R0,#+43289
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  377 	rlen += GenAidData(Aid_Rvs1Attn3_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn3_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+775
        ADDS     R1,R6,R4
        MOVW     R0,#+43290
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  378 	rlen += GenAidData(Aid_Rvs1Attn4_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Attn4_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+776
        ADDS     R1,R6,R4
        MOVW     R0,#+43291
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  379 	rlen += GenAidData(Aid_Fwd1AgcAttn_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE, 1);
        ADDW     R10,R5,#+793
        MOVW     R8,#+43297
        MOVS     R3,#+1
        MOV      R2,R10
        ADDS     R1,R6,R4
        MOV      R0,R8
        BL       GenAidData
        ADDS     R7,R0,R6
        UXTH     R7,R7
//  380 	rlen += GenAidData(Aid_Fwd1AgcAttn_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE_A, 1);
        ADDW     R9,R5,#+794
        MOVW     R6,#+43298
        MOVS     R3,#+1
        MOV      R2,R9
        ADDS     R1,R7,R4
        MOV      R0,R6
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  381 	rlen += GenAidData(Aid_Fwd1AgcAttn_LTE, 	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE, 1);
        MOVS     R3,#+1
        MOV      R2,R10
        ADDS     R1,R7,R4
        MOV      R0,R8
        BL       GenAidData
        ADDS     R7,R0,R7
        UXTH     R7,R7
//  382 	rlen += GenAidData(Aid_Fwd1AgcAttn_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1AgcAttn_LTE_A, 1);
        MOVS     R3,#+1
        MOV      R2,R9
        ADDS     R1,R7,R4
        MOV      R0,R6
        BL       GenAidData
        ADDS     R6,R0,R7
        UXTH     R6,R6
//  383 	rlen += GenAidData(Aid_Rvs1AlcOnOff_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1AlcOnOff_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+797
        ADDS     R1,R6,R4
        MOVW     R0,#+43301
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  384 	rlen += GenAidData(Aid_Rvs1AlcOnOff_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1AlcOnOff_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+798
        ADDS     R1,R6,R4
        MOVW     R0,#+43302
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  385 	rlen += GenAidData(Aid_SmsFwd1InPwr_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->SmsFwd1InPwr_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+799
        ADDS     R1,R6,R4
        MOVW     R0,#+43305
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  386 	rlen += GenAidData(Aid_SmsFwd1InPwr_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->SmsFwd1InPwr_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+800
        ADDS     R1,R6,R4
        MOVW     R0,#+43306
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  387 	rlen += GenAidData(Aid_Rvs1OutPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutPwr_LTE), sizeof(Sts->Rvs1OutPwr_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+801
        ADDS     R1,R6,R4
        MOVW     R0,#+43307
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  388 	rlen += GenAidData(Aid_Rvs1OutPwr_LTE_A,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutPwr_LTE_A), sizeof(Sts->Rvs1OutPwr_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+803
        ADDS     R1,R6,R4
        MOVW     R0,#+43308
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  389 	rlen += GenAidData(Aid_Rvs1InPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1InPwr_LTE), sizeof(Sts->Rvs1InPwr_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+805
        ADDS     R1,R6,R4
        MOVW     R0,#+43309
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  390 	rlen += GenAidData(Aid_Rvs1InPwr_LTE_A, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1InPwr_LTE_A), sizeof(Sts->Rvs1InPwr_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+807
        ADDS     R1,R6,R4
        MOVW     R0,#+43310
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  391 	rlen += GenAidData(Aid_ShutDownOnOff1_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE1, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+809
        ADDS     R1,R6,R4
        MOVW     R0,#+43311
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  392 	rlen += GenAidData(Aid_ShutDownOnOff1_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&Sts->ShutDownOnOff_LTE_A1, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+810
        ADDS     R1,R6,R4
        MOVW     R0,#+43312
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  393 	rlen += GenAidData(Aid_Rvs1OutUpperLmt_LTE, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutUpperLmt_LTE), sizeof(Sts->Rvs1OutUpperLmt_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+811
        ADDS     R1,R6,R4
        MOVW     R0,#+43313
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  394 	rlen += GenAidData(Aid_Rvs1OutUpperLmt_LTE_A,(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs1OutUpperLmt_LTE_A), sizeof(Sts->Rvs1OutUpperLmt_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+813
        ADDS     R1,R6,R4
        MOVW     R0,#+43314
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  395 	rlen += GenAidData(Aid_Fwd1Temp_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Temp_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+815
        ADDS     R1,R6,R4
        MOVW     R0,#+43315
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  396 	rlen += GenAidData(Aid_Rvs1Temp_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Temp_LTE, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+816
        ADDS     R1,R6,R4
        MOVW     R0,#+43316
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  397 	rlen += GenAidData(Aid_Fwd1Temp_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Fwd1Temp_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+817
        ADDS     R1,R6,R4
        MOVW     R0,#+43317
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  398 	rlen += GenAidData(Aid_Rvs1Temp_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1Temp_LTE_A, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+818
        ADDS     R1,R6,R4
        MOVW     R0,#+43318
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  399 	rlen += GenAidData(Aid_Fwd1OutHighLmt_LTE,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutHighLmt_LTE), sizeof(Sts->Fwd1OutHighLmt_LTE));
        MOVS     R3,#+2
        ADDW     R2,R5,#+819
        ADDS     R1,R6,R4
        MOVW     R0,#+43319
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  400 	rlen += GenAidData(Aid_Fwd1OutHighLmt_LTE_A, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd1OutHighLmt_LTE_A), sizeof(Sts->Fwd1OutHighLmt_LTE_A));
        MOVS     R3,#+2
        ADDW     R2,R5,#+821
        ADDS     R1,R6,R4
        MOVW     R0,#+43320
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  401 	rlen += GenAidData(Aid_Rvs1ALCLvl_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1ALCLvl_LTE, 1);
        MOVS     R3,#+1
        ADDW     R2,R5,#+823
        ADDS     R1,R6,R4
        MOVW     R0,#+43321
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  402 	rlen += GenAidData(Aid_Rvs1ALCLvl_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1ALCLvl_LTE_A, 1);
        MOVS     R3,#+1
        ADD      R2,R5,#+824
        ADDS     R1,R6,R4
        MOVW     R0,#+43322
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  403 #endif
//  404 
//  405 
//  406 	rlen += GenAidData(Aid_Det2Pwr, 	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Det2Pwr), sizeof(Sts->Det2Pwr));
        MOVS     R3,#+16
        ADD      R2,R5,#+540
        ADDS     R1,R6,R4
        MOVW     R0,#+53268
        BL       GenAidData
        ADDS     R6,R0,R6
        UXTH     R6,R6
//  407 	rlen += GenAidData(Aid_Det2Offset,	(INT8U *)&dptr[rlen], (INT8U *)&(Sts->Det2Offset), sizeof(Sts->Det2Offset));
        MOVS     R3,#+16
        ADD      R2,R5,#+556
        ADDS     R1,R6,R4
        MOVW     R0,#+53269
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  408 
//  409 
//  410 #if 0
//  411 	rlen += GenAidData(Aid_DetFwdInPwr_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetFwdInPwr_3G, 1);
//  412 	rlen += GenAidData(Aid_DetFwdInPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetFwdInPwr_LTE_A, 1);
//  413 	rlen += GenAidData(Aid_DetFwd1InPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetFwd1InPwr_LTE, 1);
//  414 	rlen += GenAidData(Aid_DetFwd1InPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetFwd1InPwr_LTE_A, 1);
//  415 
//  416 	rlen += GenAidData(Aid_DetRvsInPwr_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetRvsInPwr_3G, 1);
//  417 	rlen += GenAidData(Aid_DetRvsInPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetRvsInPwr_LTE_A, 1);
//  418 	rlen += GenAidData(Aid_DetRvs1InPwr_LTE,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetRvs1InPwr_LTE, 1);
//  419 	rlen += GenAidData(Aid_DetRvs1InPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->DetRvs1InPwr_LTE_A, 1);
//  420 
//  421 
//  422 	rlen += GenAidData(Aid_RvsAlcInPwr_2G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcInPwr_2G, 1);
//  423 	rlen += GenAidData(Aid_RvsAlcInPwr_LTE,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcInPwr_LTE, 1);
//  424 	rlen += GenAidData(Aid_RvsAlcInPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcInPwr_LTE_A, 1);
//  425 	rlen += GenAidData(Aid_RvsAlcInPwr_3G,			(INT8U *)&dptr[rlen], (INT8U *)&Sts->RvsAlcInPwr_3G, 1);
//  426 
//  427 	rlen += GenAidData(Aid_Rvs1AlcInPwr_LTE, 		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1AlcInPwr_LTE, 1);
//  428 	rlen += GenAidData(Aid_Rvs1AlcInPwr_LTE_A,		(INT8U *)&dptr[rlen], (INT8U *)&Sts->Rvs1AlcInPwr_LTE_A, 1);
//  429 #endif
//  430 
//  431 #if 0
//  432 // FwdOutUpperLmt_2G
//  433 dptr[rlen++] = (Aid_FwdOutUpperLmt_2G >> 8) & 0xff;
//  434 dptr[rlen++] = (Aid_FwdOutUpperLmt_2G >> 0) & 0xff;
//  435 dptr[rlen++] = 2;
//  436 dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_2G[0]);
//  437 dptr[rlen++] = RetNormaltoSMSData(Sts->FwdOutUpperLmt_2G[1]);
//  438 
//  439 
//  440 
//  441 #endif
//  442 	return rlen;
        POP      {R1,R2,R4-R10,PC}  ;; return
//  443 }
//  444 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  445 INT8U CtrlData(INT16U AID_Command, INT8U *AID_Value, INT8U Length,INT8U Ctrl, __ProtocolPtr *nPtr)
//  446 {
CtrlData:
        PUSH     {R4-R8,LR}
        MOV      R8,R0
        MOV      R4,R1
        MOV      R5,R3
//  447 	INT8U rval = FALSE;
        MOVS     R6,#+0
//  448 	__Dnr_Sts *Sts = tDnrSts;
        LDR.W    R0,??CtrlData_0  ;; tDnrSts
        LDR      R7,[R0, #+0]
//  449 
//  450 //	INT8U i;
//  451 	if(tDnrSts->Test_Mode == Debug_AID) 
        LDRB     R0,[R7, #+826]
        CMP      R0,#+17
        BNE.N    ??CtrlData_1
//  452 	{
//  453 		SerPtr->printf("AID_Command [%x][%d][%x][%x]\n",AID_Command,Length,AID_Value[0],AID_Value[1]);
        LDRB     R0,[R4, #+1]
        PUSH     {R0,LR}
        LDRB     R3,[R4, #+0]
        MOV      R1,R8
        LDR.W    R0,??CtrlData_0+0x4  ;; `?<Constant "AID_Command [%x][%d][...">`
        LDR.W    R12,??CtrlData_0+0x8  ;; SerPtr
        LDR      R12,[R12, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
        ADD      SP,SP,#+8
//  454 	}
//  455 
//  456 	switch(AID_Command)
??CtrlData_1:
        MOVW     R0,#+1284
        SUBS     R0,R8,R0
        BEQ.W    ??CtrlData_2
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_3
        SUBS     R0,R0,#+16
        BEQ.W    ??CtrlData_4
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_5
        SUBS     R0,R0,#+19
        BEQ.W    ??CtrlData_6
        SUBS     R0,R0,#+25
        BEQ.W    ??CtrlData_7
        SUBS     R0,R0,#+21
        BEQ.W    ??CtrlData_8
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_9
        SUBS     R0,R0,#+17
        BEQ.W    ??CtrlData_10
        SUBS     R0,R0,#+4
        BEQ.W    ??CtrlData_11
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_12
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_13
        SUBS     R0,R0,#+147
        BEQ.W    ??CtrlData_14
        SUBS     R0,R0,#+11
        BEQ.W    ??CtrlData_15
        SUBS     R0,R0,#+30
        BEQ.W    ??CtrlData_16
        SUBS     R0,R0,#+18
        BEQ.W    ??CtrlData_17
        SUBS     R0,R0,#+53
        BEQ.W    ??CtrlData_18
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_19
        SUBS     R0,R0,#+4
        BEQ.W    ??CtrlData_20
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_21
        SUBS     R0,R0,#+138
        BEQ.W    ??CtrlData_22
        SUBS     R0,R0,#+74
        BEQ.W    ??CtrlData_23
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_24
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_25
        SUBS     R1,R0,#+1
        BEQ.W    ??CtrlData_26
        MOVW     R0,#+439
        SUBS     R0,R1,R0
        BEQ.W    ??CtrlData_27
        SUBS     R0,R0,#+10
        BEQ.W    ??CtrlData_28
        SUBS     R0,R0,#+14
        BEQ.W    ??CtrlData_29
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_30
        SUBS     R0,R0,#+11
        BEQ.W    ??CtrlData_31
        SUBS     R1,R0,#+7
        BEQ.W    ??CtrlData_32
        MOVW     R0,#+1772
        SUBS     R0,R1,R0
        BEQ.W    ??CtrlData_33
        SUBS     R0,R0,#+48
        BEQ.W    ??CtrlData_34
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_35
        SUBS     R0,R0,#+7
        BEQ.W    ??CtrlData_36
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_37
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_38
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_39
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_40
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_41
        SUBS     R1,R0,#+1
        BEQ.W    ??CtrlData_42
        MOVW     R0,#+2721
        SUBS     R0,R1,R0
        BEQ.W    ??CtrlData_43
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_44
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_45
        SUBS     R0,R0,#+4
        BEQ.W    ??CtrlData_46
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_47
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_48
        SUBS     R0,R0,#+247
        BEQ.W    ??CtrlData_49
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_50
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_51
        SUBS     R1,R0,#+2
        BEQ.W    ??CtrlData_52
        MOVW     R0,#+33785
        SUBS     R0,R1,R0
        BEQ.W    ??CtrlData_53
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_54
        SUBS     R0,R0,#+12
        BEQ.W    ??CtrlData_55
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_56
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_57
        SUBS     R0,R0,#+14
        BEQ.W    ??CtrlData_58
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_59
        SUBS     R0,R0,#+10
        BEQ.W    ??CtrlData_60
        SUBS     R0,R0,#+214
        BEQ.W    ??CtrlData_61
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_62
        SUBS     R0,R0,#+7
        BEQ.W    ??CtrlData_63
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_64
        SUBS     R0,R0,#+78
        BEQ.W    ??CtrlData_65
        SUBS     R0,R0,#+5
        BEQ.W    ??CtrlData_66
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_67
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_68
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_69
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_70
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_71
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_72
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_73
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_74
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_75
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_76
        SUBS     R0,R0,#+81
        BEQ.W    ??CtrlData_77
        SUBS     R0,R0,#+4
        BEQ.W    ??CtrlData_78
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_79
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_80
        SUBS     R1,R0,#+9
        BEQ.W    ??CtrlData_81
        MOVW     R0,#+383
        SUBS     R0,R1,R0
        BEQ.W    ??CtrlData_82
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_83
        SUBS     R0,R0,#+26
        BEQ.W    ??CtrlData_84
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_85
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_86
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_87
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_88
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_89
        SUBS     R0,R0,#+6
        BEQ.W    ??CtrlData_90
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_91
        SUBS     R0,R0,#+29
        BEQ.W    ??CtrlData_92
        SUBS     R1,R0,#+1
        BEQ.W    ??CtrlData_93
        MOV      R0,#+1136
        SUBS     R0,R1,R0
        BEQ.W    ??CtrlData_94
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_95
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_96
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_97
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_98
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_99
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_100
        SUBS     R0,R0,#+5
        BEQ.W    ??CtrlData_101
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_102
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_103
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_104
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_105
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_106
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_107
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_108
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_109
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_110
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_111
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_112
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_113
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_114
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_115
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_116
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_117
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_118
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_119
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_120
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_121
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_122
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_123
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_124
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_125
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_126
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_127
        SUBS     R0,R0,#+25
        BEQ.W    ??CtrlData_128
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_129
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_130
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_131
        SUBS     R0,R0,#+5
        BEQ.W    ??CtrlData_132
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_133
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_134
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_135
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_136
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_137
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_138
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_139
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_140
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_141
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_142
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_143
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_144
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_145
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_146
        SUBS     R0,R0,#+162
        BEQ.W    ??CtrlData_147
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_148
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_149
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_150
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_151
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_152
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_153
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_154
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_155
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_156
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_157
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_158
        SUBS     R0,R0,#+3
        BEQ.W    ??CtrlData_159
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_160
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_161
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_162
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_163
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_164
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_165
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_166
        SUBS     R0,R0,#+2
        BEQ.W    ??CtrlData_167
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_168
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_169
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_170
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_171
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_172
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_173
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_174
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_175
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_176
        SUBS     R0,R0,#+9
        BEQ.W    ??CtrlData_177
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_178
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_179
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_180
        SUBS     R0,R0,#+5
        BEQ.W    ??CtrlData_181
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_182
        SUBS     R0,R0,#+1
        BEQ.W    ??CtrlData_183
        SUBS     R1,R0,#+1
        BEQ.W    ??CtrlData_184
        MOVW     R0,#+9939
        SUBS     R0,R1,R0
        BEQ.W    ??CtrlData_185
        SUBS     R0,R0,#+8
        BEQ.W    ??CtrlData_186
        B.W      ??CtrlData_187
//  457 	{
//  458 
//  459 		case Aid_EsnChecksum:
//  460 #if 0			
//  461 		  if( (EsnChecksumH !=AID_Value[0]) ||(EsnChecksumL != AID_Value[1]))
//  462 		  {
//  463 			  ErrRspFunc(0x00,0xff,0xff,0x10);
//  464 			  iMobileESN=NACK;
//  465 			  break;
//  466 		  }
//  467 		 iMobileESN=ACK;
//  468 #endif		 
//  469 		break;
//  470 
//  471 		case Aid_FwdOutUpperLmt_3G:
//  472 			Sts->FwdOutUpperLmt_3G[0] = AID_Value[0];
??CtrlData_2:
        LDRSB    R0,[R4, R6]
        STRB     R0,[R7, #+38]
//  473 			Sts->FwdOutUpperLmt_3G[1] = AID_Value[1];
        ADD      R0,R7,#+38
        LDRSB    R1,[R4, #+1]
??CtrlData_188:
        STRB     R1,[R0, #+1]
//  474 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  475 		break;
//  476 
//  477 		case Aid_FwdOutLowerLmt_3G:
//  478 			Sts->FwdOutLowerLmt_3G[0] = AID_Value[0];
??CtrlData_3:
        ADD      R1,R7,#+38
??CtrlData_190:
        LDRSB    R0,[R4, R6]
        STRB     R0,[R1, #+2]
//  479 			Sts->FwdOutLowerLmt_3G[1] = AID_Value[1];
        LDRSB    R0,[R4, #+1]
        STRB     R0,[R1, #+3]
//  480 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  481 		break;
//  482 		
//  483 		case Aid_FwdGainSet_3G:
//  484 			Sts->FwdGainSet_3G = AID_Value[0];
??CtrlData_6:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+38
        STRB     R0,[R1, #+4]
//  485 			Sts->FwdGainAttn_3G = GainAttnCalculation(Sts->FwdGainSet_3G,Gain_3G,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+2]
//  486 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  487 		break;
//  488 
//  489 
//  490 		case Aid_FwdOutUpperLmt_2G:
//  491 			Sts->FwdOutUpperLmt_2G[0] = AID_Value[0];
??CtrlData_4:
        ADD      R1,R7,#+38
??CtrlData_191:
        LDRSB    R0,[R4, R6]
        STRB     R0,[R1, #+8]
//  492 			Sts->FwdOutUpperLmt_2G[1] = AID_Value[1];
        LDRSB    R0,[R4, #+1]
        STRB     R0,[R1, #+9]
//  493 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  494 		break;
//  495 
//  496 		case Aid_FwdOutLowerLmt_2G:
//  497 			Sts->FwdOutLowerLmt_2G[0] = AID_Value[0];
??CtrlData_5:
        ADD      R1,R7,#+38
??CtrlData_192:
        LDRSB    R0,[R4, R6]
        STRB     R0,[R1, #+10]
//  498 			Sts->FwdOutLowerLmt_2G[1] = AID_Value[1];
        LDRSB    R0,[R4, #+1]
        STRB     R0,[R1, #+11]
//  499 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  500 		break;
//  501 		
//  502 		case Aid_FwdGainSet_2G:
//  503 			Sts->FwdGainSet_2G = AID_Value[0];
??CtrlData_7:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+38
        STRB     R0,[R1, #+12]
//  504 			Sts->FwdGainAttn_2G = GainAttnCalculation(Sts->FwdGainSet_2G,Gain_2G,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        BL       GainAttnCalculation
        STRB     R0,[R7, #+870]
//  505 
//  506 			ChkAttChange = RESET;
??CtrlData_193:
        LDR.W    R0,??CtrlData_0+0xC  ;; ChkAttChange
        STRB     R6,[R0, #+0]
//  507 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  508 		break;
//  509 
//  510 
//  511 		case Aid_FwdOutUpperLmt_LTE:
//  512 			Sts->FwdOutUpperLmt_LTE[0] = AID_Value[0];
??CtrlData_8:
        ADD      R1,R7,#+38
        LDRSB    R0,[R4, R6]
        STRB     R0,[R1, #+16]
//  513 			Sts->FwdOutUpperLmt_LTE[1] = AID_Value[1];            
        LDRSB    R0,[R4, #+1]
        STRB     R0,[R1, #+17]
//  514 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  515 		break;
//  516 
//  517 		case Aid_FwdOutLowerLmt_LTE:
//  518 			Sts->FwdOutLowerLmt_LTE[0] = AID_Value[0];
??CtrlData_9:
        ADD      R1,R7,#+38
        LDRSB    R0,[R4, R6]
        STRB     R0,[R1, #+18]
//  519 			Sts->FwdOutLowerLmt_LTE[1] = AID_Value[1];            
        LDRSB    R0,[R4, #+1]
        STRB     R0,[R1, #+19]
//  520 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  521 		break;
//  522 		
//  523 		case Aid_FwdGainSet_LTE:
//  524 			Sts->FwdGainSet_LTE = AID_Value[0];
??CtrlData_10:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+38
        STRB     R0,[R1, #+20]
//  525 			Sts->FwdGainAttn_LTE = GainAttnCalculation(Sts->FwdGainSet_LTE,Gain_LTE,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+4]
//  526 
//  527 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
//  528 			if(Ctrl)rval = TRUE;
//  529 		break;
//  530 		
//  531 		case Aid_FwdOutUpperLmt_LTE_A:
//  532 			Sts->FwdOutUpperLmt_LTE_A[0] = AID_Value[0];
??CtrlData_11:
        ADD      R1,R7,#+38
        LDRSB    R0,[R4, R6]
        STRB     R0,[R1, #+24]
//  533 			Sts->FwdOutUpperLmt_LTE_A[1] = AID_Value[1];
        LDRSB    R0,[R4, #+1]
        STRB     R0,[R1, #+25]
//  534 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  535 		break;
//  536 
//  537 		case Aid_FwdOutLowerLmt_LTE_A:
//  538 			Sts->FwdOutLowerLmt_LTE_A[0] = AID_Value[0];
??CtrlData_12:
        ADD      R1,R7,#+38
        LDRSB    R0,[R4, R6]
        STRB     R0,[R1, #+26]
//  539 			Sts->FwdOutLowerLmt_LTE_A[1] = AID_Value[1];
        LDRSB    R0,[R4, #+1]
        STRB     R0,[R1, #+27]
//  540 			
//  541 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  542 		break;
//  543 		
//  544 		case Aid_FwdGainSet_LTE_A:
//  545 			Sts->FwdGainSet_LTE_A = AID_Value[0];
??CtrlData_13:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+38
        STRB     R0,[R1, #+28]
//  546 			Sts->FwdGainAttn_LTE_A = GainAttnCalculation(Sts->FwdGainSet_LTE_A,Gain_LTE_A,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+6]
//  547 
//  548 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
//  549 			if(Ctrl)rval = TRUE;
//  550 		break;
//  551 
//  552 		case Aid_RvsGainSet_3G:
//  553 			Sts->Rvs0GainSet_3G = AID_Value[0];
??CtrlData_14:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+38
        STRB     R0,[R1, #+30]
//  554 			Sts->RvsGainAttn_3G = GainAttnCalculation(Sts->Rvs0GainSet_3G,Gain_3G,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+3]
//  555 			ChkAttChange = RESET;
??CtrlData_194:
        LDR.W    R0,??CtrlData_0+0xC  ;; ChkAttChange
        STRB     R6,[R0, #+0]
//  556 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  557 		break;
//  558 
//  559 		case Aid_RvsGainBalance_3G:
//  560 			Sts->RvsGainBalance_3G = AID_Value[0];
??CtrlData_16:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+70]
//  561 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  562 		break;
//  563 
//  564 		case Aid_RvsGainSet_2G:
//  565 			Sts->Rvs0GainSet_2G = AID_Value[0];
??CtrlData_15:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+70
        STRB     R0,[R1, #+1]
//  566 			Sts->RvsGainAttn_2G = GainAttnCalculation(Sts->Rvs0GainSet_2G,Gain_2G,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+1]
//  567 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
//  568 			if(Ctrl)rval = TRUE;
//  569 		break;
//  570 
//  571 		case Aid_RvsGainBalance_2G:
//  572 			Sts->RvsGainBalance_2G = AID_Value[0];
??CtrlData_17:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_195:
        STRB     R1,[R0, #+3]
//  573 			if(Ctrl)rval = TRUE;
        B.W      ??CtrlData_189
//  574 		break;
//  575 
//  576 		case Aid_RvsGainSet_LTE:
//  577 			Sts->Rvs0GainSet_LTE = AID_Value[0];
??CtrlData_18:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+70
        STRB     R0,[R1, #+4]
//  578 			Sts->RvsGainAttn_LTE = GainAttnCalculation(Sts->Rvs0GainSet_LTE,Gain_LTE,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+5]
//  579 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
//  580 			if(Ctrl)rval = TRUE;
//  581 		break;
//  582 
//  583 		case Aid_RvsGainBalance_LTE:
//  584 			Sts->RvsGainBalance_LTE = AID_Value[0];
??CtrlData_19:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_196:
        STRB     R1,[R0, #+6]
//  585 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  586 		break;		
//  587 
//  588 		case Aid_RvsGainSet_LTE_A:
//  589 			Sts->Rvs0GainSet_LTE_A = AID_Value[0];
??CtrlData_20:
        LDRB     R0,[R4, #+0]
        ADD      R1,R7,#+70
        STRB     R0,[R1, #+7]
//  590 			Sts->RvsGainAttn_LTE_A = GainAttnCalculation(Sts->Rvs0GainSet_LTE_A,Gain_LTE_A,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+7]
//  591 			
//  592 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
//  593 			if(Ctrl)rval = TRUE;
//  594 		break;
//  595 
//  596 		case Aid_RvsGainBalance_LTE_A:
//  597 			Sts->RvsGainBalance_LTE_A = AID_Value[0];
??CtrlData_21:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+9]
//  598 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  599 		break;			
//  600 
//  601 		case Aid_FwdAmpOnOff_3G:
//  602 			Sts->AmpOnOff_3G = AID_Value[0];
??CtrlData_22:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_197:
        STRB     R1,[R0, #+13]
//  603 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  604 		break;	
//  605 
//  606 		case Aid_FwdAmpOnOff_Common:
//  607 			Sts->AmpOnOff_Common = AID_Value[0];
??CtrlData_24:
        ADD      R0,R7,#+70
??CtrlData_198:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+14]
//  608 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  609 		break;	
//  610 
//  611 
//  612 		case Aid_FwdAmpOnOff_LTE_A:
//  613 			Sts->AmpOnOff_LTE_A = AID_Value[0];
??CtrlData_23:
        ADD      R0,R7,#+70
??CtrlData_199:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+15]
//  614 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  615 		break;	
//  616 
//  617 		case Aid_BandSelect_15M:
//  618 			Sts->BandSelect_15M = AID_Value[0];
??CtrlData_36:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_200:
        STRB     R1,[R0, #+16]
//  619 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  620 		break;	
//  621         
//  622         case Aid_RepeatResetPriod:
//  623             Sts->RepeatResetPriod = AID_Value[0];
??CtrlData_33:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_201:
        STRB     R1,[R0, #+17]
//  624             if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  625         break;	
//  626  ////////////////////////////////////////
//  627 		case Aid_AGCOnOff_3G:
//  628 			Sts->AGCOnOff_3G = AID_Value[0];
??CtrlData_27:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_202:
        STRB     R1,[R0, #+23]
//  629 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  630 		break;	
//  631 
//  632 		case Aid_AGCOnOff_2G:
//  633 			Sts->AGCOnOff_2G = AID_Value[0];
??CtrlData_32:
        ADD      R0,R7,#+70
??CtrlData_203:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+24]
//  634 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  635 		break;	
//  636 
//  637 		case Aid_AGCOnOff_LTE:
//  638 			Sts->AGCOnOff_LTE = AID_Value[0];
??CtrlData_34:
        ADD      R0,R7,#+70
??CtrlData_204:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+27]
//  639 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  640 		break;	
//  641 
//  642 		case Aid_AGCOnOff_LTE_A:
//  643 			Sts->AGCOnOff_LTE_A = AID_Value[0];
??CtrlData_35:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_205:
        STRB     R1,[R0, #+28]
//  644 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  645 		break;	
//  646 
//  647 		case Aid_AGC1OnOff_LTE:
//  648 			Sts->AGC1OnOff_LTE = AID_Value[0];
??CtrlData_41:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+31]
//  649 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  650 		break;	
//  651 
//  652 		case Aid_AGC1OnOff_LTE_A:
//  653 			Sts->AGC1OnOff_LTE_A = AID_Value[0];
??CtrlData_42:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+102]
//  654 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  655 		break;	
//  656 
//  657 
//  658 		case Aid_AGCMode_3G:
//  659 			Sts->AGCMode_3G = AID_Value[0];
??CtrlData_37:
        ADD      R0,R7,#+70
??CtrlData_206:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+25]
//  660 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  661 		break;	
//  662 		
//  663 		case Aid_AGCMode_2G:
//  664 			Sts->AGCMode_2G = AID_Value[0];
??CtrlData_38:
        ADD      R0,R7,#+70
??CtrlData_207:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+26]
//  665 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  666 		break;	
//  667 
//  668 		case Aid_AGCMode_LTE:
//  669 			Sts->AGCMode_LTE = AID_Value[0];
??CtrlData_39:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+29]
//  670 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  671 		break;	
//  672 
//  673 		case Aid_AGCMode_LTE_A:
//  674 			Sts->AGCMode_LTE_A = AID_Value[0];
??CtrlData_40:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_208:
        STRB     R1,[R0, #+30]
//  675 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  676 		break;	
//  677 
//  678 		case Aid_AutoReportPriod:
//  679 			Sts->AutoReportPriod = AID_Value[0];
??CtrlData_29:
        ADD      R0,R7,#+70
        LDRB     R1,[R4, #+0]
??CtrlData_209:
        STRB     R1,[R0, #+18]
//  680 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  681 			
//  682 #if 0			
//  683 			if(Ctrl)
//  684 			{
//  685 				PeriodStart = 1;				//Duo-L IF 
//  686 				TimeStart = 1;					// 자동보고 기준시 클리어 //			
//  687 			}
//  688 			tmpBp = AutoReportPriodBp;
//  689 		goto EEP_CTRL;
//  690 #endif		
//  691 		break;	
//  692 
//  693 
//  694 		case Aid_ReportTime:
//  695 			Sts->AutoReportTime_H = AID_Value[0];
??CtrlData_30:
        ADD      R1,R7,#+70
        LDRB     R0,[R4, #+0]
        STRB     R0,[R1, #+19]
//  696 			Sts->AutoReportTime_M = AID_Value[1];
        LDRB     R0,[R4, #+1]
        STRB     R0,[R1, #+20]
//  697 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  698 #if 0
//  699 			if(Ctrl)
//  700 			{
//  701 				PeriodStart = 1;		// 자동보고 기준시 클리어 //
//  702 				iARTime_H = AID_Value[0];
//  703 				iARTime_M = AID_Value[1];
//  704 			}
//  705 			tmpBp = AutoReportTime_H;
//  706 			tmp = 2;
//  707 #endif			
//  708 		break;	
//  709 		
//  710 		case Aid_ReportHours:
//  711 			Sts->PresentHour = AID_Value[0];
??CtrlData_31:
        ADD      R1,R7,#+70
        LDRB     R0,[R4, #+0]
        STRB     R0,[R1, #+21]
//  712 			Sts->PresentMin = AID_Value[1];
        LDRB     R0,[R4, #+1]
        STRB     R0,[R1, #+22]
        B.N      ??CtrlData_187
//  713 		break;
//  714 
//  715 
//  716 		/////////////////////////////////////////////////////////////
//  717 
//  718 		case Aid_TPTL_OnOff:
//  719 			Sts->TPTL_OnOff = AID_Value[0];
??CtrlData_53:
        ADD      R0,R7,#+102
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_188
//  720 			if(Ctrl)rval = TRUE;
//  721 		break;
//  722 
//  723 
//  724 		case Aid_TempOffset:
//  725 			Sts->TempOffset = AID_Value[0];
??CtrlData_54:
        ADD      R0,R7,#+102
??CtrlData_210:
        LDRSB    R1,[R4, R6]
??CtrlData_211:
        STRB     R1,[R0, #+2]
//  726 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  727 		break;
//  728 
//  729 
//  730 		case Aid_AlarmMask:
//  731 			Sts->AlarmMask = AID_Value[0];
??CtrlData_55:
        ADD      R0,R7,#+102
        LDRB     R1,[R4, #+0]
??CtrlData_212:
        STRB     R1,[R0, #+4]
//  732 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  733 		break;
//  734 
//  735 		case Aid_ModemMINNumber:
//  736 			{
//  737 				INT8U i;
//  738 				for(i = 0; i < 19; i++)
??CtrlData_56:
        MOVS     R0,#+19
//  739 				{
//  740 					Sts->BcMEsnNum[i] = AID_Value[i];
??CtrlData_213:
        LDRB     R1,[R4], #+1
        STRB     R1,[R7, #+124]
//  741 				}
        ADDS     R7,R7,#+1
        SUBS     R0,R0,#+1
        BNE.N    ??CtrlData_213
//  742 				if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  743 			}
//  744 		break;
//  745 
//  746 		case Aid_ModemOnOff:
//  747 			Sts->ModemOnOff = AID_Value[0];
??CtrlData_57:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+143]
        B.N      ??CtrlData_187
//  748 
//  749 		break;
//  750 
//  751 
//  752 		case Aid_InitialSet:
//  753 			Sts->InitialSet = AID_Value[0];
??CtrlData_58:
        ADD      R0,R7,#+143
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+8]
//  754 			DefaultValueSet();
        BL       DefaultValueSet
        B.N      ??CtrlData_187
//  755 		break;
//  756 
//  757 		case Aid_DefaultSet:
//  758 			Sts->DefaultSet = AID_Value[0];
??CtrlData_59:
        ADD      R0,R7,#+143
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+9]
        B.N      ??CtrlData_187
//  759 		break;
//  760 
//  761 		case Aid_VccDet_Lmt:
//  762 			Sts->VccDet_Lmt.Data = ByteToWord(AID_Value[0],AID_Value[1]);
??CtrlData_60:
        LDRB     R1,[R4, #+1]
        LDRB     R0,[R4, #+0]
        BL       ByteToWord
        STRH     R0,[R7, #+154]
//  763 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  764 		break;
//  765 
//  766 
//  767 		case Aid_FwdInPwrOffset_2G:
//  768 			Sts->FwdInPwrOffset_2G = AID_Value[0];
??CtrlData_61:
        ADD      R0,R7,#+154
        B.N      ??CtrlData_210
//  769 			if(Ctrl)rval = TRUE;
//  770 		break;
//  771 
//  772 		case Aid_FwdInPwrOffset_3G:
//  773 			Sts->FwdInPwrOffset_3G = AID_Value[0];
??CtrlData_62:
        ADD      R0,R7,#+154
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_195
//  774 			if(Ctrl)rval = TRUE;
//  775 		break;
//  776 
//  777 		case Aid_Rvs0OutPwrOffset_2G:
//  778 			Sts->Rvs0OutPwrOffset_2G = AID_Value[0];
??CtrlData_63:
        ADD      R0,R7,#+154
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_212
//  779 			if(Ctrl)rval = TRUE;
//  780 		break;
//  781 
//  782 		case Aid_Rvs0OutPwrOffset_3G:
//  783 			Sts->Rvs0OutPwrOffset_3G = AID_Value[0];
??CtrlData_64:
        ADD      R0,R7,#+154
??CtrlData_214:
        LDRSB    R1,[R4, R6]
??CtrlData_215:
        STRB     R1,[R0, #+5]
//  784 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  785 		break;
//  786 		case Aid_FwdOutPwrOffset_2G:
//  787 			Sts->FwdOutPwrOffset_2G = AID_Value[0];
??CtrlData_78:
        ADD      R0,R7,#+154
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_196
//  788 			if(Ctrl)rval = TRUE;
//  789 		break;
//  790 
//  791 		case Aid_FwdOutPwrOffset_3G:
//  792 			Sts->FwdOutPwrOffset_3G = AID_Value[0];
??CtrlData_65:
        ADD      R0,R7,#+154
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+7]
//  793 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  794 		break;
//  795 
//  796 		case Aid_FwdAttn1_2G:
//  797 			Sts->FwdAttn1_2G = AID_Value[0];
??CtrlData_66:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+8]
//  798 			ChkAttChange = SET;
??CtrlData_216:
        LDR.W    R0,??CtrlData_0+0xC  ;; ChkAttChange
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  799 			if(Ctrl)rval = TRUE;
        CMP      R5,#+0
        BEQ.W    ??CtrlData_187
        B.N      ??CtrlData_217
//  800 		break;
//  801 
//  802 		case Aid_FwdAttn2_2G:
//  803 			Sts->FwdAttn2_2G = AID_Value[0];
??CtrlData_67:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+9]
//  804 			ChkAttChange = SET;
        B.N      ??CtrlData_216
//  805 			if(Ctrl)rval = TRUE;
//  806 		break;
//  807 
//  808 		case Aid_FwdAttn1_3G:
//  809 			Sts->FwdAttn1_3G = AID_Value[0];
??CtrlData_68:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+10]
//  810 			ChkAttChange = SET;
??CtrlData_218:
        LDR.W    R0,??CtrlData_0+0xC  ;; ChkAttChange
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  811 			if(Ctrl)rval = TRUE;
        CMP      R5,#+0
        BEQ.W    ??CtrlData_187
        B.N      ??CtrlData_217
//  812 		break;
//  813 
//  814 		case Aid_FwdAttn2_3G:
//  815 			Sts->FwdAttn2_3G = AID_Value[0];
??CtrlData_69:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+11]
//  816 			ChkAttChange = SET;
        B.N      ??CtrlData_216
//  817 			if(Ctrl)rval = TRUE;
//  818 		break;
//  819 		
//  820 		case Aid_RvsAttn1_2G:
//  821 			Sts->RvsAttn1_2G = AID_Value[0];
??CtrlData_70:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+12]
//  822 			ChkAttChange = SET;
        B.N      ??CtrlData_218
//  823 			if(Ctrl)rval = TRUE;
//  824 		break;
//  825 		
//  826 		case Aid_RvsAttn2_2G:
//  827 			Sts->RvsAttn2_2G = AID_Value[0];
??CtrlData_71:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+13]
//  828 			Sts->FwdFixAttn_2G = 0;	
        ADDW     R0,R7,#+870
        STRB     R6,[R0, #+12]
//  829 			ChkAttChange = SET;
        B.N      ??CtrlData_216
//  830 			if(Ctrl)rval = TRUE;
//  831 		break;
//  832 				
//  833 		case Aid_RvsAttn3_2G:
//  834 			Sts->RvsAttn3_2G = AID_Value[0];
??CtrlData_72:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+14]
//  835 			ChkAttChange = SET;
??CtrlData_219:
        LDR.W    R0,??CtrlData_0+0xC  ;; ChkAttChange
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  836 			if(Ctrl)rval = TRUE;
        CMP      R5,#+0
        BEQ.W    ??CtrlData_187
        B.N      ??CtrlData_217
//  837 		break;
//  838 
//  839 		case Aid_RvsAttn5_2G:
//  840 			Sts->RvsAttn5_2G = AID_Value[0];
??CtrlData_142:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+15]
        B.N      ??CtrlData_187
//  841 
//  842 		break;
//  843 
//  844 
//  845 		case Aid_RvsAttn1_3G:
//  846 			Sts->RvsAttn1_3G = AID_Value[0];
??CtrlData_73:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+16]
//  847 			ChkAttChange = SET;
        B.N      ??CtrlData_216
//  848 			if(Ctrl)rval = TRUE;
//  849 		break;
//  850 
//  851 		
//  852 		case Aid_RvsAttn2_3G:
//  853 			Sts->RvsAttn2_3G = AID_Value[0];
??CtrlData_74:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+17]
//  854 			ChkAttChange = SET;
        B.N      ??CtrlData_218
//  855 			if(Ctrl)rval = TRUE;
//  856 		break;
//  857 				
//  858 		case Aid_RvsAttn3_3G:
//  859 			Sts->RvsAttn3_3G = AID_Value[0];
??CtrlData_75:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+18]
//  860 			ChkAttChange = SET;
        B.N      ??CtrlData_216
//  861 			if(Ctrl)rval = TRUE;
//  862 		break;
//  863 		
//  864 		case Aid_RvsAttn4_3G:
//  865 			Sts->RvsAttn4_3G = AID_Value[0];
??CtrlData_76:
        ADD      R0,R7,#+154
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+19]
//  866 			ChkAttChange = SET;
        B.N      ??CtrlData_219
//  867 			if(Ctrl)rval = TRUE;
//  868 		break;
//  869 		
//  870 		case Aid_ResetPeriodCountSet:
//  871 			Sts->ResetPeriodCountSet[0] = AID_Value[0];
??CtrlData_77:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+188]
//  872 			Sts->ResetPeriodCountSet[1] = AID_Value[1];
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+1]
        STRB     R1,[R0, #+1]
//  873 			Sts->ResetPeriodCountSet[2] = AID_Value[2];			
        LDRB     R1,[R4, #+2]
        B.N      ??CtrlData_211
//  874 			if(Ctrl)rval = TRUE;
//  875 		break;
//  876 
//  877 		case Aid_FwdInPwrOffset_LTE:
//  878 			Sts->FwdInPwrOffset_LTE = AID_Value[0];
??CtrlData_79:
        ADD      R0,R7,#+188
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_195
//  879 			if(Ctrl)rval = TRUE;
//  880 		break;
//  881 
//  882 		case Aid_FwdOutPwrOffset_LTE:
//  883 			Sts->FwdOutPwrOffset_LTE = AID_Value[0];
??CtrlData_80:
        ADD      R0,R7,#+188
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_212
//  884 			if(Ctrl)rval = TRUE;
//  885 		break;
//  886 
//  887 
//  888 		case Aid_Rvs0OutPwrOffset_LTE:
//  889 			Sts->RvsOutPwrOffset_LTE = AID_Value[0];
??CtrlData_81:
        ADD      R0,R7,#+188
        B.N      ??CtrlData_214
//  890 			if(Ctrl)rval = TRUE;
//  891 		break;
//  892 
//  893 		case Aid_ShutDownOnOff_3G:
//  894 			Sts->ShutDownOnOff_3G = AID_Value[0];
??CtrlData_82:
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+13]
        B.N      ??CtrlData_187
//  895 		break;
//  896 
//  897 		case Aid_ShutDownOnOff_2G:
//  898 			Sts->ShutDownOnOff_2G = AID_Value[0];
??CtrlData_83:
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+14]
        B.N      ??CtrlData_187
//  899 		break;
//  900 
//  901 		case Aid_RvsOutUpperLmt_3G:
//  902  			Sts->RvsOutUpperLmt_3G[0] = AID_Value[0];
??CtrlData_84:
        ADD      R0,R7,#+188
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+15]
//  903  			Sts->RvsOutUpperLmt_3G[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_200
//  904  			if(Ctrl)rval = TRUE;
//  905 		break;
//  906 		
//  907 		case Aid_RvsOutUpperLmt_2G:
//  908  			Sts->RvsOutUpperLmt_2G[0] = AID_Value[0];
??CtrlData_85:
        ADD      R0,R7,#+188
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+17]
//  909  			Sts->RvsOutUpperLmt_2G[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_209
//  910  			if(Ctrl)rval = TRUE;
//  911 		break;
//  912 
//  913 		case Aid_FwdGainOffset_3G:
//  914 			Sts->FwdGainOffset_3G = AID_Value[0];
??CtrlData_86:
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+0]
??CtrlData_220:
        STRB     R1,[R0, #+19]
//  915 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  916 		break;
//  917 
//  918 		case Aid_RvsGainOffset_3G:
//  919 			Sts->RvsGainOffset_3G = AID_Value[0];
??CtrlData_87:
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+0]
??CtrlData_221:
        STRB     R1,[R0, #+20]
//  920 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  921 		break;
//  922 
//  923 		case Aid_FwdGainOffset_2G:
//  924 			Sts->FwdGainOffset_2G = AID_Value[0];
??CtrlData_88:
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+0]
??CtrlData_222:
        STRB     R1,[R0, #+21]
//  925 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  926 		break;
//  927 
//  928 		case Aid_RvsGainOffset_2G:
//  929 			Sts->RvsGainOffset_2G = AID_Value[0];
??CtrlData_89:
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+0]
??CtrlData_223:
        STRB     R1,[R0, #+22]
//  930 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  931 		break;
//  932 
//  933 
//  934 		case Aid_FwdOutHighLmt_3G:
//  935  			Sts->FwdOutHighLmt_3G[0] = AID_Value[0];
??CtrlData_90:
        ADD      R0,R7,#+188
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+27]
//  936  			Sts->FwdOutHighLmt_3G[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_205
//  937  			if(Ctrl)rval = TRUE;
//  938 		break;
//  939 
//  940 		case Aid_FwdOutHighLmt_2G:
//  941  			Sts->FwdOutHighLmt_2G[0] = AID_Value[0];
??CtrlData_91:
        ADD      R0,R7,#+188
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+29]
//  942  			Sts->FwdOutHighLmt_2G[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_208
//  943  			if(Ctrl)rval = TRUE;
//  944 		break;
//  945 
//  946 
//  947 		case Aid_DebugOnOff:
//  948 			Sts->DebugOnOff = AID_Value[0];
??CtrlData_92:
        ADD      R0,R7,#+188
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+31]
        B.N      ??CtrlData_187
//  949 		break;
//  950 
//  951 		case Aid_RadioMeasureOnOff:
//  952 			Sts->RadioMeasureOnOff = AID_Value[0];
??CtrlData_93:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+220]
        B.N      ??CtrlData_187
//  953 		break;
//  954 ///////////////////////////////
//  955 		case Aid_DetOffset:
//  956 //			memcpy((INT8U*)Sts->DetOffset, (INT8U*)&AID_Value, sizeof(Sts->DetOffset));
//  957 			{
//  958 				INT8U i;
//  959 
//  960 				for(i = 0; i < (sizeof(__DET)); i++)	 *((INT8U *)&(Sts->DetOffset.FwdOutAvg_2G) + i) = AID_Value[i];
??CtrlData_94:
        MOVS     R0,#+22
??CtrlData_224:
        LDRB     R1,[R4], #+1
        STRB     R1,[R7, #+319]
        ADDS     R7,R7,#+1
        SUBS     R0,R0,#+1
        BNE.N    ??CtrlData_224
//  961 				if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
//  962 			}	
//  963 		break;
//  964 
//  965 		case Aid_AttOffset:
//  966 			{
//  967 				INT8U i;
//  968 
//  969 				for(i = 0; i < (sizeof(__AttOffset)); i++)	 *((INT8U *)&(Sts->AttOffset.FwdAttn1_2G) + i) = AID_Value[i];
??CtrlData_95:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+384]
        ADDW     R0,R7,#+385
        ADDS     R1,R4,#+1
        MOVS     R2,#+6
??CtrlData_225:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        SUBS     R2,R2,#+1
        BNE.N    ??CtrlData_225
//  970 
//  971 				Sts->FwdAttn1_2G 		= Sts->AttOffset.FwdAttn1_2G;
        ADD      R0,R7,#+154
        LDRB     R1,[R7, #+384]
        STRB     R1,[R0, #+8]
//  972 				Sts->FwdAttn2_2G 		= Sts->AttOffset.FwdAttn2_2G;
        ADD      R1,R7,#+384
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+9]
//  973 				Sts->RvsAttn1_2G 		= Sts->AttOffset.RvsAttn1_2G;
        LDRB     R2,[R1, #+4]
        STRB     R2,[R0, #+12]
//  974 				Sts->RvsAttn2_2G 		= Sts->AttOffset.RvsAttn2_2G;
        LDRB     R2,[R1, #+5]
        STRB     R2,[R0, #+13]
//  975 				Sts->RvsAttn3_2G 		= Sts->AttOffset.RvsAttn3_2G;
        LDRB     R2,[R1, #+6]
        STRB     R2,[R0, #+14]
//  976 				Sts->FwdAttn1_LTE 		= Sts->AttOffset.FwdAttn1_LTE;
        ADD      R2,R7,#+416
        LDRB     R3,[R1, #+9]
        STRB     R3,[R2, #+22]
//  977 				Sts->FwdAttn2_LTE 		= Sts->AttOffset.FwdAttn2_LTE;
        LDRB     R3,[R1, #+10]
        STRB     R3,[R2, #+23]
//  978 				Sts->RvsAttn1_LTE 		= Sts->AttOffset.RvsAttn1_LTE;
        LDRB     R3,[R1, #+13]
        STRB     R3,[R2, #+26]
//  979 				Sts->RvsAttn2_LTE 		= Sts->AttOffset.RvsAttn2_LTE;
        LDRB     R3,[R1, #+14]
        STRB     R3,[R2, #+27]
//  980 				Sts->RvsAttn3_LTE 		= Sts->AttOffset.RvsAttn3_LTE;
        LDRB     R3,[R1, #+15]
        STRB     R3,[R2, #+28]
//  981 				Sts->FwdAttn1_LTE_A 	= Sts->AttOffset.FwdAttn1_LTE_A;
        LDRB     R3,[R1, #+18]
        STRB     R3,[R2, #+24]
//  982 				Sts->FwdAttn2_LTE_A 	= Sts->AttOffset.FwdAttn2_LTE_A;
        LDRB     R3,[R1, #+19]
        STRB     R3,[R2, #+25]
//  983 				Sts->RvsAttn1_LTE_A 	= Sts->AttOffset.RvsAttn1_LTE_A;
        LDRB     R3,[R1, #+22]
        STRB     R3,[R2, #+29]
//  984 				Sts->RvsAttn2_LTE_A 	= Sts->AttOffset.RvsAttn2_LTE_A;
        LDRB     R3,[R1, #+23]
        STRB     R3,[R2, #+30]
//  985 				Sts->RvsAttn3_LTE_A 	= Sts->AttOffset.RvsAttn3_LTE_A;
        LDRB     R3,[R1, #+24]
        STRB     R3,[R2, #+31]
//  986 				Sts->RvsAttn4_LTE_A 	= Sts->AttOffset.RvsAttn4_LTE_A;
        LDRB     R3,[R1, #+25]
        STRB     R3,[R7, #+448]
//  987 
//  988 				Sts->FwdAttn1_3G	 	= Sts->AttOffset.FwdAttn1_3G;
        LDRB     R3,[R1, #+27]
        STRB     R3,[R0, #+10]
//  989 				Sts->FwdAttn2_3G		= Sts->AttOffset.FwdAttn2_3G;
        LDRB     R3,[R1, #+28]
        STRB     R3,[R0, #+11]
//  990 
//  991 				Sts->RvsAttn1_3G	 	= Sts->AttOffset.RvsAttn1_3G;
        LDRB     R1,[R1, #+31]
        STRB     R1,[R0, #+16]
//  992 				Sts->RvsAttn2_3G	 	= Sts->AttOffset.RvsAttn2_3G;
        LDRB     R1,[R7, #+416]
        STRB     R1,[R0, #+17]
//  993 				Sts->RvsAttn3_3G	 	= Sts->AttOffset.RvsAttn3_3G;
        LDRB     R1,[R2, #+1]
        STRB     R1,[R0, #+18]
//  994 				Sts->RvsAttn4_3G	 	= Sts->AttOffset.RvsAttn4_3G;
        LDRB     R1,[R2, #+2]
        STRB     R1,[R0, #+19]
//  995 
//  996 				Sts->FwdAttn1_Common 	= Sts->AttOffset.FwdAttn1_Common;
        LDRB     R0,[R2, #+4]
        STRB     R0,[R2, #+14]
//  997 				Sts->RvsAttn1_Common 	= Sts->AttOffset.RvsAttn1_Common;
        LDRB     R0,[R2, #+7]
        STRB     R0,[R2, #+15]
        B.N      ??CtrlData_187
//  998 			}	
//  999 		break;
// 1000 
// 1001 		case Aid_FwdInPwrOffset_LTE_A:
// 1002 			Sts->FwdInPwrOffset_LTE_A = AID_Value[0];
??CtrlData_96:
        ADD      R0,R7,#+416
        LDRSB    R1,[R4, R6]
??CtrlData_226:
        STRB     R1,[R0, #+11]
// 1003 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
// 1004 		break;
// 1005 
// 1006 		case Aid_FwdOutPwrOffset_LTE_A:
// 1007 			Sts->FwdOutPwrOffset_LTE_A = AID_Value[0];
??CtrlData_97:
        ADD      R0,R7,#+416
        LDRSB    R1,[R4, R6]
??CtrlData_227:
        STRB     R1,[R0, #+12]
// 1008 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
// 1009 		break;
// 1010 
// 1011 		case Aid_RvsOutPwrOffset_LTE_A:
// 1012 			Sts->RvsOutPwrOffset_LTE_A = AID_Value[0];
??CtrlData_98:
        ADD      R0,R7,#+416
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_197
// 1013 			if(Ctrl)rval = TRUE;
// 1014 		break;
// 1015 
// 1016 
// 1017 		case Aid_FwdAttn1_Common:
// 1018 			Sts->FwdAttn1_Common = AID_Value[0];
??CtrlData_99:
        ADD      R0,R7,#+416
        B.N      ??CtrlData_198
// 1019 			if(Ctrl)rval = TRUE;
// 1020 		break;
// 1021 
// 1022         case Aid_RvsAttn1_Common:
// 1023 			Sts->RvsAttn1_Common = AID_Value[0];
??CtrlData_100:
        ADD      R0,R7,#+416
        B.N      ??CtrlData_199
// 1024 			if(Ctrl)rval = TRUE;
// 1025 		break;
// 1026 		
// 1027 		case Aid_FwdAttn1_LTE:
// 1028 			Sts->FwdAttn1_LTE = AID_Value[0];
??CtrlData_101:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+22]
// 1029 			ChkAttChange = SET;
        B.N      ??CtrlData_216
// 1030 			if(Ctrl)rval = TRUE;
// 1031 		break;
// 1032 
// 1033 		case Aid_FwdAttn2_LTE:
// 1034 			Sts->FwdAttn2_LTE = AID_Value[0];
??CtrlData_102:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+23]
// 1035 			ChkAttChange = SET;
        B.N      ??CtrlData_218
// 1036 			if(Ctrl)rval = TRUE;
// 1037 		break;
// 1038 
// 1039 		case Aid_FwdAttn1_LTE_A:
// 1040 			Sts->FwdAttn1_LTE_A = AID_Value[0];
??CtrlData_103:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+24]
// 1041 			ChkAttChange = SET;
        B.N      ??CtrlData_216
// 1042 			if(Ctrl)rval = TRUE;
// 1043 		break;
// 1044 
// 1045 		case Aid_FwdAttn2_LTE_A:
// 1046 			Sts->FwdAttn2_LTE_A = AID_Value[0];
??CtrlData_104:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+25]
// 1047 			ChkAttChange = SET;
        B.N      ??CtrlData_219
// 1048 			if(Ctrl)rval = TRUE;
// 1049 		break;
// 1050 
// 1051 		case Aid_RvsAttn1_LTE:
// 1052 			Sts->RvsAttn1_LTE = AID_Value[0];
??CtrlData_105:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+26]
// 1053 			ChkAttChange = SET;
        B.N      ??CtrlData_216
// 1054 			if(Ctrl)rval = TRUE;
// 1055 		break;
// 1056 
// 1057 		case Aid_RvsAttn2_LTE:
// 1058 			Sts->RvsAttn2_LTE = AID_Value[0];
??CtrlData_106:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+27]
// 1059 			Sts->FwdFixAttn_LTE = 0;	
        ADDW     R0,R7,#+870
        STRB     R6,[R0, #+13]
// 1060 			ChkAttChange = SET;
        B.N      ??CtrlData_218
// 1061 			if(Ctrl)rval = TRUE;
// 1062 		break;
// 1063 
// 1064 		case Aid_RvsAttn3_LTE:
// 1065 			Sts->RvsAttn3_LTE = AID_Value[0];
??CtrlData_107:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+28]
// 1066 			ChkAttChange = SET;
        B.N      ??CtrlData_216
// 1067 			if(Ctrl)rval = TRUE;
// 1068 		break;
// 1069 
// 1070 		case Aid_RvsAttn1_LTE_A:
// 1071 			Sts->RvsAttn1_LTE_A = AID_Value[0];
??CtrlData_108:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+29]
// 1072 			ChkAttChange = SET;
        LDR.W    R0,??CtrlData_0+0xC  ;; ChkAttChange
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
// 1073 			if(Ctrl)rval = TRUE;
        CMP      R5,#+0
        BEQ.W    ??CtrlData_187
        B.N      ??CtrlData_217
// 1074 		break;
// 1075 
// 1076 		case Aid_RvsAttn2_LTE_A:
// 1077 			Sts->RvsAttn2_LTE_A = AID_Value[0];
??CtrlData_109:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+30]
// 1078 			ChkAttChange = SET;
        B.N      ??CtrlData_216
// 1079 			if(Ctrl)rval = TRUE;
// 1080 		break;
// 1081 
// 1082 		case Aid_RvsAttn3_LTE_A:
// 1083 			Sts->RvsAttn3_LTE_A = AID_Value[0];
??CtrlData_110:
        ADD      R0,R7,#+416
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+31]
// 1084 			ChkAttChange = SET;
        B.N      ??CtrlData_218
// 1085 			if(Ctrl)rval = TRUE;
// 1086 		break;
// 1087 
// 1088 		case Aid_RvsAttn4_LTE_A:
// 1089 			Sts->RvsAttn4_LTE_A = AID_Value[0];
??CtrlData_111:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+448]
// 1090 			ChkAttChange = SET;
        B.N      ??CtrlData_216
// 1091 			if(Ctrl)rval = TRUE;
// 1092 		break;
// 1093 
// 1094 		case Aid_FwdGainOffset_LTE:
// 1095 			Sts->FwdGainOffset_LTE = AID_Value[0];
??CtrlData_112:
        ADD      R0,R7,#+448
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_227
// 1096 			if(Ctrl)rval = TRUE;
// 1097 		break;
// 1098 
// 1099 		case Aid_RvsGainOffset_LTE:
// 1100 			Sts->RvsGainOffset_LTE = AID_Value[0];
??CtrlData_113:
        ADD      R0,R7,#+448
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_197
// 1101 			if(Ctrl)rval = TRUE;
// 1102 		break;
// 1103 
// 1104 		case Aid_FwdGainOffset_LTE_A:
// 1105 			Sts->FwdGainOffset_LTE_A = AID_Value[0];
??CtrlData_114:
        ADD      R0,R7,#+448
        B.N      ??CtrlData_198
// 1106 			if(Ctrl)rval = TRUE;
// 1107 		break;
// 1108 
// 1109 		case Aid_RvsGainOffset_LTE_A:
// 1110 			Sts->RvsGainOffset_LTE_A = AID_Value[0];
??CtrlData_115:
        ADD      R0,R7,#+448
        B.N      ??CtrlData_199
// 1111 			if(Ctrl)rval = TRUE;
// 1112 		break;
// 1113 
// 1114 		case Aid_FwdAgcAttn_2G:
// 1115 			Sts->FwdAgcAttn_2G = AID_Value[0];
??CtrlData_116:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_200
// 1116 			if(Ctrl)rval = TRUE;
// 1117 		break;
// 1118 		
// 1119 		case Aid_FwdAgcAttn_LTE:
// 1120 			Sts->FwdAgcAttn_LTE = AID_Value[0];
??CtrlData_117:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_201
// 1121 			if(Ctrl)rval = TRUE;
// 1122 		break;
// 1123 		
// 1124 		case Aid_FwdAgcAttn_LTE_A:
// 1125 			Sts->FwdAgcAttn_LTE_A = AID_Value[0];
??CtrlData_118:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_209
// 1126 			if(Ctrl)rval = TRUE;
// 1127 		break;
// 1128 		
// 1129 		case Aid_FwdAgcAttn_3G:
// 1130 			Sts->FwdAgcAttn_3G = AID_Value[0];
??CtrlData_119:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_220
// 1131 			if(Ctrl)rval = TRUE;
// 1132 		break;
// 1133 
// 1134 		case Aid_RvsAlcAttn_2G:
// 1135 			Sts->RvsAlcAttn_2G = AID_Value[0];
??CtrlData_120:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_221
// 1136 			if(Ctrl)rval = TRUE;
// 1137 		break;
// 1138 		
// 1139 		case Aid_RvsAlcAttn_LTE:
// 1140 			Sts->RvsAlcAttn_LTE = AID_Value[0];
??CtrlData_121:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_222
// 1141 			if(Ctrl)rval = TRUE;
// 1142 		break;		
// 1143 
// 1144 		case Aid_RvsAlcAttn_LTE_A:
// 1145 			Sts->RvsAlcAttn_LTE_A = AID_Value[0];
??CtrlData_122:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_223
// 1146 			if(Ctrl)rval = TRUE;
// 1147 		break;		
// 1148 
// 1149 		case Aid_RvsAlcAttn_3G:
// 1150 			Sts->RvsAlcAttn_3G = AID_Value[0];
??CtrlData_123:
        ADD      R0,R7,#+448
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_202
// 1151 			if(Ctrl)rval = TRUE;
// 1152 		break;
// 1153 
// 1154 		case Aid_RvsAlcOnOff_2G:
// 1155 			Sts->RvsAlcOnOff_2G = AID_Value[0];
??CtrlData_124:
        ADD      R0,R7,#+448
        B.N      ??CtrlData_203
// 1156 			if(Ctrl)rval = TRUE;
// 1157 		break;
// 1158 
// 1159 		case Aid_RvsAlcOnOff_LTE:
// 1160 			Sts->RvsAlcOnOff_LTE = AID_Value[0];
??CtrlData_125:
        ADD      R0,R7,#+448
        B.N      ??CtrlData_206
// 1161 			if(Ctrl)rval = TRUE;
// 1162 		break;
// 1163 
// 1164 		case Aid_RvsAlcOnOff_LTE_A:
// 1165 			Sts->RvsAlcOnOff_LTE_A = AID_Value[0];
??CtrlData_126:
        ADD      R0,R7,#+448
        B.N      ??CtrlData_207
// 1166 			if(Ctrl)rval = TRUE;
// 1167 		break;
// 1168 
// 1169 		case Aid_RvsAlcOnOff_3G:
// 1170 			Sts->RvsAlcOnOff_3G = AID_Value[0];
??CtrlData_127:
        ADD      R0,R7,#+448
        B.N      ??CtrlData_204
// 1171 			if(Ctrl)rval = TRUE;
// 1172 		break;
// 1173 		
// 1174 		case Aid_ShutDownOnOff_LTE:
// 1175 			Sts->ShutDownOnOff_LTE = AID_Value[0];
??CtrlData_128:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+495]
        B.N      ??CtrlData_187
// 1176 		break;
// 1177 
// 1178 		case Aid_ShutDownOnOff_LTE_A:
// 1179 			Sts->ShutDownOnOff_LTE_A= AID_Value[0];
??CtrlData_129:
        ADDW     R0,R7,#+495
??CtrlData_228:
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+1]
        B.N      ??CtrlData_187
// 1180 		break;
// 1181 
// 1182 		case Aid_RvsOutUpperLmt_LTE:
// 1183  			Sts->RvsOutUpperLmt_LTE[0] = AID_Value[0];
??CtrlData_130:
        ADDW     R0,R7,#+495
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+2]
// 1184  			Sts->RvsOutUpperLmt_LTE[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_195
// 1185  			if(Ctrl)rval = TRUE;
// 1186 		break;
// 1187 		
// 1188 		case Aid_RvsOutUpperLmt_LTE_A:
// 1189  			Sts->RvsOutUpperLmt_LTE_A[0] = AID_Value[0];
??CtrlData_131:
        ADDW     R0,R7,#+495
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+4]
// 1190  			Sts->RvsOutUpperLmt_LTE_A[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_215
// 1191  			if(Ctrl)rval = TRUE;
// 1192 		break;
// 1193 
// 1194 		case Aid_FwdOutHighLmt_LTE:
// 1195  			Sts->FwdOutHighLmt_LTE[0] = AID_Value[0];
??CtrlData_132:
        ADDW     R0,R7,#+495
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+10]
// 1196  			Sts->FwdOutHighLmt_LTE[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_226
// 1197  			if(Ctrl)rval = TRUE;
// 1198 		break;
// 1199 
// 1200 		case Aid_FwdOutHighLmt_LTE_A:
// 1201  			Sts->FwdOutHighLmt_LTE_A[0] = AID_Value[0];
??CtrlData_133:
        ADDW     R0,R7,#+495
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+12]
// 1202  			Sts->FwdOutHighLmt_LTE_A[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_197
// 1203  			if(Ctrl)rval = TRUE;
// 1204 		break;
// 1205 
// 1206 		case Aid_OverInAlarmLmt_2G:
// 1207  			Sts->OverInAlarmLmt_2G = AID_Value[0];
??CtrlData_134:
        ADDW     R0,R7,#+495
        B.N      ??CtrlData_198
// 1208  			if(Ctrl)rval = TRUE;
// 1209 		break;
// 1210 		
// 1211 		case Aid_OverInAlarmLmt_LTE:
// 1212  			Sts->OverInAlarmLmt_LTE = AID_Value[0];
??CtrlData_135:
        ADDW     R0,R7,#+495
        B.N      ??CtrlData_199
// 1213  			if(Ctrl)rval = TRUE;
// 1214 		break;
// 1215 
// 1216 		case Aid_OverInAlarmLmt_LTE_A:
// 1217  			Sts->OverInAlarmLmt_LTE_A = AID_Value[0];
??CtrlData_136:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_200
// 1218  			if(Ctrl)rval = TRUE;
// 1219 		break;
// 1220 
// 1221 		case Aid_OverInAlarmLmt_3G:
// 1222  			Sts->OverInAlarmLmt_3G = AID_Value[0];
??CtrlData_137:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_201
// 1223  			if(Ctrl)rval = TRUE;
// 1224 		break;
// 1225 
// 1226 		case Aid_OtherOverInAlarmLmt_2G:
// 1227 			Sts->OtherOverInAlarmLmt_2G = AID_Value[0];
??CtrlData_138:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_209
// 1228 			if(Ctrl)rval = TRUE;
// 1229 		break;
// 1230 
// 1231 		case Aid_OtherOverInAlarmLmt_LTE:
// 1232 			Sts->OtherOverInAlarmLmt_LTE = AID_Value[0];
??CtrlData_139:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_220
// 1233 			if(Ctrl)rval = TRUE;
// 1234 		break;
// 1235 
// 1236 		case Aid_OtherOverInAlarmLmt_LTE_A:
// 1237 			Sts->OtherOverInAlarmLmt_LTE_A = AID_Value[0];
??CtrlData_140:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_221
// 1238 			if(Ctrl)rval = TRUE;
// 1239 		break;
// 1240 
// 1241 		case Aid_OtherOverInAlarmLmt_3G:
// 1242 			Sts->OtherOverInAlarmLmt_3G = AID_Value[0];
??CtrlData_141:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_222
// 1243 			if(Ctrl)rval = TRUE;
// 1244 		break;
// 1245 
// 1246 		case Aid_RvsALCLvl_2G:
// 1247 			Sts->RvsALCLvl_2G = AID_Value[0];
??CtrlData_143:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_223
// 1248 			if(Ctrl)rval = TRUE;
// 1249 		break;
// 1250 
// 1251 		case Aid_RvsALCLvl_LTE:
// 1252 			Sts->RvsALCLvl_LTE = AID_Value[0];
??CtrlData_144:
        ADDW     R0,R7,#+495
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_202
// 1253 			if(Ctrl)rval = TRUE;
// 1254 		break;
// 1255 
// 1256 		case Aid_RvsALCLvl_LTE_A:
// 1257 			Sts->RvsALCLvl_LTE_A = AID_Value[0];
??CtrlData_145:
        ADDW     R0,R7,#+495
        B.N      ??CtrlData_203
// 1258 			if(Ctrl)rval = TRUE;
// 1259 		break;
// 1260 
// 1261 		case Aid_RvsALCLvl_3G:
// 1262 			Sts->RvsALCLvl_3G = AID_Value[0];
??CtrlData_146:
        ADDW     R0,R7,#+495
        B.N      ??CtrlData_206
// 1263 			if(Ctrl)rval = TRUE;
// 1264 		break;
// 1265 		/////////////////////////////////////////////////////////////
// 1266 //ETC
// 1267 
// 1268 ////////////////////////////////////////////////////
// 1269 		case Aid_RCUReset:
// 1270 			Chk_Reset = SET;
??CtrlData_28:
        LDR.N    R0,??CtrlData_0+0x10  ;; Chk_Reset
??CtrlData_229:
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
        B.N      ??CtrlData_187
// 1271 		break;
// 1272 
// 1273 
// 1274  		case Aid_DE_Factory_default:
// 1275 //			Chk_Factory_default = SET;
// 1276 		break;
// 1277 
// 1278 
// 1279 		case Aid_ShunDown_Value:
// 1280 			Sts->ShunDown_Value = AID_Value[0];
??CtrlData_185:
        ADDW     R0,R7,#+809
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+19]
        B.N      ??CtrlData_187
// 1281 		break;
// 1282 
// 1283     	case Aid_TestPwr:
// 1284 //			Sts->TestPwr = AID_Value[0];
// 1285 		break;
// 1286 		
// 1287 		case Aid_TestMode:
// 1288 //			Sts->TestMode = AID_Value[0];
// 1289 		break;
// 1290 		
// 1291 		case Aid_TestValue:
// 1292 //			Sts->TestValue = AID_Value[0];
// 1293 		break;
// 1294 
// 1295 #ifdef _MIMO_Type 
// 1296 		case Aid_Fwd1OutUpperLmt_LTE:
// 1297 			Sts->Fwd1OutUpperLmt_LTE[0] = AID_Value[0];
??CtrlData_43:
        LDRSB    R0,[R4, R6]
        STRB     R0,[R7, #+657]
// 1298 			Sts->Fwd1OutUpperLmt_LTE[1] = AID_Value[1];
        ADDW     R0,R7,#+657
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_188
// 1299 			
// 1300 			if(Ctrl)rval = TRUE;
// 1301 		break;
// 1302 
// 1303 		case Aid_Fwd1OutLowerLmt_LTE:
// 1304 			Sts->Fwd1OutLowerLmt_LTE[0] = AID_Value[0];
??CtrlData_44:
        ADDW     R1,R7,#+657
        B.N      ??CtrlData_190
// 1305 			Sts->Fwd1OutLowerLmt_LTE[1] = AID_Value[1];
// 1306 			if(Ctrl)rval = TRUE;
// 1307 		break;
// 1308 
// 1309 		case Aid_Fwd1GainSet_LTE:
// 1310 			Sts->Fwd1GainSet_LTE = AID_Value[0];
??CtrlData_45:
        LDRB     R0,[R4, #+0]
        ADDW     R1,R7,#+657
        STRB     R0,[R1, #+4]
// 1311 			Sts->Fwd1GainAttn_LTE = GainAttnCalculation(Sts->Fwd1GainSet_LTE,Gain_LTE_A,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+8]
// 1312 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
// 1313 			if(Ctrl)rval = TRUE;
// 1314 		break;
// 1315 
// 1316 		case Aid_Fwd1OutUpperLmt_LTE_A:
// 1317 			Sts->Fwd1OutUpperLmt_LTE_A[0] = AID_Value[0];
??CtrlData_46:
        ADDW     R1,R7,#+657
        B.N      ??CtrlData_191
// 1318 			Sts->Fwd1OutUpperLmt_LTE_A[1] = AID_Value[1];
// 1319 			
// 1320 			if(Ctrl)rval = TRUE;
// 1321 		break;
// 1322 
// 1323 		case Aid_Fwd1OutLowerLmt_LTE_A:
// 1324 			Sts->Fwd1OutLowerLmt_LTE_A[0] = AID_Value[0];
??CtrlData_47:
        ADDW     R1,R7,#+657
        B.N      ??CtrlData_192
// 1325 			Sts->Fwd1OutLowerLmt_LTE_A[1] = AID_Value[1];
// 1326 			if(Ctrl)rval = TRUE;
// 1327 		break;
// 1328 
// 1329 		case Aid_Fwd1GainSet_LTE_A:
// 1330 			Sts->Fwd1GainSet_LTE_A = AID_Value[0];
??CtrlData_48:
        LDRB     R0,[R4, #+0]
        ADDW     R1,R7,#+657
        STRB     R0,[R1, #+12]
// 1331 			Sts->Fwd1GainAttn_LTE_A = GainAttnCalculation(Sts->Fwd1GainSet_LTE_A,Gain_LTE_A1,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+10]
// 1332 			
// 1333 			ChkAttChange = RESET;
        B.N      ??CtrlData_194
// 1334 			if(Ctrl)rval = TRUE;
// 1335 		break;
// 1336 
// 1337 		case Aid_Rvs1GainSet_LTE:
// 1338 			Sts->Rvs1GainSet_LTE = AID_Value[0];
??CtrlData_49:
        LDRB     R0,[R4, #+0]
        ADDW     R1,R7,#+657
        STRB     R0,[R1, #+14]
// 1339 			Sts->Rvs1GainAttn_LTE = GainAttnCalculation(Sts->Rvs1GainSet_LTE,Gain_LTE1,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+9]
// 1340 			
// 1341 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
// 1342 			if(Ctrl)rval = TRUE;
// 1343 		break;
// 1344 
// 1345 		case Aid_Rvs1GainBalance_LTE:
// 1346 			Sts->Rvs1GainBalance_LTE = AID_Value[0];
??CtrlData_50:
        ADDW     R0,R7,#+657
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_200
// 1347 			if(Ctrl)rval = TRUE;
// 1348 		break;		
// 1349 
// 1350 		case Aid_Rvs1GainSet_LTE_A:
// 1351 			Sts->Rvs1GainSet_LTE_A = AID_Value[0];
??CtrlData_51:
        LDRB     R0,[R4, #+0]
        ADDW     R1,R7,#+657
        STRB     R0,[R1, #+17]
// 1352 			Sts->Rvs1GainAttn_LTE_A = GainAttnCalculation(Sts->Rvs1GainSet_LTE_A,Gain_LTE_A1,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        BL       GainAttnCalculation
        ADDW     R1,R7,#+870
        STRB     R0,[R1, #+11]
// 1353 			ChkAttChange = RESET;
        B.N      ??CtrlData_193
// 1354 			if(Ctrl)rval = TRUE;
// 1355 		break;
// 1356 
// 1357 		case Aid_Rvs1GainBalance_LTE_A:
// 1358 			Sts->Rvs1GainBalance_LTE_A = AID_Value[0];
??CtrlData_52:
        ADDW     R0,R7,#+657
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_220
// 1359 			if(Ctrl)rval = TRUE;
// 1360 		break;			
// 1361 
// 1362 		case Aid_FwdAmp1OnOff_LTE:
// 1363 			Sts->Amp1OnOff_LTE = AID_Value[0];
??CtrlData_25:
        ADDW     R0,R7,#+657
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_222
// 1364 			if(Ctrl)rval = TRUE;
// 1365 		break;	
// 1366 
// 1367 		case Aid_FwdAmp1OnOff_LTE_A:
// 1368 			Sts->Amp1OnOff_LTE_A = AID_Value[0];
??CtrlData_26:
        ADDW     R0,R7,#+657
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_221
// 1369 			if(Ctrl)rval = TRUE;
// 1370 		break;	
// 1371 ///////////////////////////
// 1372 		case Aid_Det1Offset:
// 1373 //			memcpy((INT8U*)Sts->DetOffset, (INT8U*)&AID_Value, sizeof(Sts->DetOffset));
// 1374 			#if 0
// 1375 			{
// 1376 				INT8U i;
// 1377 				for(i = 0; i < sizeof(Sts->DetOffset); i++)
// 1378 				{
// 1379 					Sts->DetOffset[i] = AID_Value[i];
// 1380 				}
// 1381 				if(Ctrl)rval = TRUE;
// 1382 			}
// 1383 			#endif
// 1384 			{
// 1385 				INT8U i;
// 1386 
// 1387 				for(i = 0; i < (sizeof(__DET1)); i++)	 *((INT8U *)&(Sts->Det1Offset.Fwd1OutAvg_LTE) + i) = AID_Value[i];
??CtrlData_147:
        MOVS     R0,#+8
??CtrlData_230:
        LDRB     R1,[R4], #+1
        STRB     R1,[R7, #+717]
        ADDS     R7,R7,#+1
        SUBS     R0,R0,#+1
        BNE.N    ??CtrlData_230
// 1388 				if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
// 1389 			}	
// 1390 		break;
// 1391 
// 1392 		case Aid_Att1Offset:
// 1393 			{
// 1394 				INT8U i;
// 1395 
// 1396 				for(i = 0; i < (sizeof(__Att1Offset)); i++)	 *((INT8U *)&(Sts->Att1Offset.Fwd1Attn1_LTE) + i) = AID_Value[i];
??CtrlData_148:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+742]
        ADDW     R0,R7,#+743
        ADDS     R1,R4,#+1
        MOVS     R2,#+4
??CtrlData_231:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
        SUBS     R2,R2,#+1
        BNE.N    ??CtrlData_231
// 1397 
// 1398 				Sts->Fwd1Attn1_LTE = Sts->Att1Offset.Fwd1Attn1_LTE;
        ADDW     R0,R7,#+742
        LDRB     R1,[R7, #+742]
        STRB     R1,[R0, #+23]
// 1399 				Sts->Fwd1Attn2_LTE = Sts->Att1Offset.Fwd1Attn2_LTE;
        LDRB     R1,[R0, #+1]
        STRB     R1,[R0, #+24]
// 1400 				Sts->Rvs1Attn1_LTE = Sts->Att1Offset.Rvs1Attn1_LTE;
        LDRB     R1,[R0, #+4]
        STRB     R1,[R0, #+27]
// 1401 				Sts->Rvs1Attn2_LTE = Sts->Att1Offset.Rvs1Attn2_LTE;
        LDRB     R1,[R0, #+5]
        STRB     R1,[R0, #+28]
// 1402 				Sts->Rvs1Attn3_LTE = Sts->Att1Offset.Rvs1Attn3_LTE;
        LDRB     R1,[R0, #+6]
        STRB     R1,[R0, #+29]
// 1403 				Sts->Rvs1Attn4_LTE = Sts->Att1Offset.Rvs1Attn4_LTE;
        LDRB     R1,[R0, #+7]
        STRB     R1,[R0, #+30]
// 1404 				Sts->Fwd1Attn1_LTE_A = Sts->Att1Offset.Fwd1Attn1_LTE_A;
        LDRB     R1,[R0, #+8]
        STRB     R1,[R0, #+25]
// 1405 				Sts->Fwd1Attn2_LTE_A = Sts->Att1Offset.Fwd1Attn2_LTE_A;
        LDRB     R1,[R0, #+9]
        STRB     R1,[R0, #+26]
// 1406 				Sts->Rvs1Attn1_LTE_A = Sts->Att1Offset.Rvs1Attn1_LTE_A;
        LDRB     R1,[R0, #+12]
        STRB     R1,[R0, #+31]
// 1407 				Sts->Rvs1Attn2_LTE_A = Sts->Att1Offset.Rvs1Attn2_LTE_A;
        LDRB     R1,[R0, #+13]
        STRB     R1,[R7, #+774]
// 1408 				Sts->Rvs1Attn3_LTE_A = Sts->Att1Offset.Rvs1Attn3_LTE_A;
        ADDW     R1,R7,#+774
        LDRB     R2,[R0, #+14]
        STRB     R2,[R1, #+1]
// 1409 				Sts->Rvs1Attn4_LTE_A = Sts->Att1Offset.Rvs1Attn4_LTE_A;
        LDRB     R0,[R0, #+15]
        STRB     R0,[R1, #+2]
        B.N      ??CtrlData_187
// 1410 			}	
// 1411 		break;
// 1412 
// 1413 		case Aid_Fwd1InPwrOffset_LTE:
// 1414 			Sts->Fwd1InPwrOffset_LTE = AID_Value[0];
??CtrlData_149:
        ADDW     R0,R7,#+742
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_201
// 1415 			if(Ctrl)rval = TRUE;
// 1416 		break;
// 1417 
// 1418 		case Aid_Fwd1OutPwrOffset_LTE:
// 1419 			Sts->Fwd1OutPwrOffset_LTE = AID_Value[0];
??CtrlData_150:
        ADDW     R0,R7,#+742
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_209
// 1420 			if(Ctrl)rval = TRUE;
// 1421 		break;
// 1422 
// 1423 		case Aid_Rvs1OutPwrOffset_LTE:
// 1424 			Sts->Rvs1OutPwrOffset_LTE = AID_Value[0];
??CtrlData_151:
        ADDW     R0,R7,#+742
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_220
// 1425 			if(Ctrl)rval = TRUE;
// 1426 		break;
// 1427 
// 1428 		case Aid_Fwd1InPwrOffset_LTE_A:
// 1429 			Sts->Fwd1InPwrOffset_LTE_A = AID_Value[0];
??CtrlData_152:
        ADDW     R0,R7,#+742
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_221
// 1430 			if(Ctrl)rval = TRUE;
// 1431 		break;
// 1432 
// 1433 		case Aid_Fwd1OutPwrOffset_LTE_A:
// 1434 			Sts->Fwd1OutPwrOffset_LTE_A = AID_Value[0];
??CtrlData_153:
        ADDW     R0,R7,#+742
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_222
// 1435 			if(Ctrl)rval = TRUE;
// 1436 		break;
// 1437 
// 1438 		case Aid_Rvs1OutPwrOffset_LTE_A:
// 1439 			Sts->Rvs1OutPwrOffset_LTE_A = AID_Value[0];
??CtrlData_154:
        ADDW     R0,R7,#+742
        LDRSB    R1,[R4, R6]
        B.N      ??CtrlData_223
// 1440 			if(Ctrl)rval = TRUE;
// 1441 		break;
// 1442 
// 1443 		case Aid_Fwd1Attn1_LTE:
// 1444 			Sts->Fwd1Attn1_LTE = AID_Value[0];
??CtrlData_155:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+23]
// 1445 			ChkAttChange = SET;
??CtrlData_232:
        LDR.N    R0,??CtrlData_0+0xC  ;; ChkAttChange
        B.N      ??CtrlData_229
// 1446 		break;
// 1447 
// 1448 		case Aid_Fwd1Attn2_LTE:
// 1449 			Sts->Fwd1Attn2_LTE = AID_Value[0];
??CtrlData_156:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+24]
// 1450 			ChkAttChange = SET;
??CtrlData_233:
        LDR.N    R0,??CtrlData_0+0xC  ;; ChkAttChange
        B.N      ??CtrlData_229
// 1451 		break;
// 1452 
// 1453 		case Aid_Fwd1Attn1_LTE_A:
// 1454 			Sts->Fwd1Attn1_LTE_A = AID_Value[0];
??CtrlData_157:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+25]
// 1455 			ChkAttChange = SET;
        B.N      ??CtrlData_232
// 1456 		break;
// 1457 
// 1458 		case Aid_Fwd1Attn2_LTE_A:
// 1459 			Sts->Fwd1Attn2_LTE_A = AID_Value[0];
??CtrlData_158:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+26]
// 1460 			ChkAttChange = SET;
        B.N      ??CtrlData_233
// 1461 		break;
// 1462 
// 1463 		case Aid_Rvs1Attn1_LTE:
// 1464 			Sts->Rvs1Attn1_LTE = AID_Value[0];
??CtrlData_159:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+27]
// 1465 			ChkAttChange = SET;
??CtrlData_234:
        LDR.N    R0,??CtrlData_0+0xC  ;; ChkAttChange
        B.N      ??CtrlData_229
// 1466 		break;
// 1467 
// 1468 		case Aid_Rvs1Attn2_LTE:
// 1469 			Sts->Rvs1Attn2_LTE = AID_Value[0];
??CtrlData_160:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+28]
// 1470 			ChkAttChange = SET;
??CtrlData_235:
        LDR.N    R0,??CtrlData_0+0xC  ;; ChkAttChange
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
        B.N      ??CtrlData_187
// 1471 		break;
// 1472 
// 1473 		case Aid_Rvs1Attn3_LTE:
// 1474 			Sts->Rvs1Attn3_LTE = AID_Value[0];
??CtrlData_161:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+29]
// 1475 			ChkAttChange = SET;
        B.N      ??CtrlData_232
// 1476 		break;
// 1477 
// 1478 		case Aid_Rvs1Attn4_LTE:
// 1479 			Sts->Rvs1Attn4_LTE = AID_Value[0];
??CtrlData_162:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+30]
// 1480 			ChkAttChange = SET;
        B.N      ??CtrlData_233
// 1481 		break;
// 1482 
// 1483 		case Aid_Rvs1Attn1_LTE_A:
// 1484 			Sts->Rvs1Attn1_LTE_A = AID_Value[0];
??CtrlData_163:
        ADDW     R0,R7,#+742
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+31]
// 1485 			ChkAttChange = SET;
        B.N      ??CtrlData_234
// 1486 		break;
// 1487 
// 1488 		case Aid_Rvs1Attn2_LTE_A:
// 1489 			Sts->Rvs1Attn2_LTE_A = AID_Value[0];
??CtrlData_164:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+774]
// 1490 			ChkAttChange = SET;
        B.N      ??CtrlData_235
// 1491 		break;
// 1492 
// 1493 		case Aid_Rvs1Attn3_LTE_A:
// 1494 			Sts->Rvs1Attn3_LTE_A = AID_Value[0];
??CtrlData_165:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+1]
// 1495 			ChkAttChange = SET;
        B.N      ??CtrlData_232
// 1496 		break;
// 1497 
// 1498 		case Aid_Rvs1Attn4_LTE_A:
// 1499 			Sts->Rvs1Attn4_LTE_A = AID_Value[0];
??CtrlData_166:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+2]
// 1500 			ChkAttChange = SET;
        B.N      ??CtrlData_233
// 1501 		break;
// 1502 
// 1503 		case Aid_Fwd1GainOffset_LTE:
// 1504 			Sts->Fwd1GainOffset_LTE = AID_Value[0];
??CtrlData_167:
        ADDW     R0,R7,#+774
        B.N      ??CtrlData_199
// 1505 			if(Ctrl)rval = TRUE;
// 1506 		break;
// 1507 
// 1508 		case Aid_Rvs1GainOffset_LTE:
// 1509 			Sts->Rvs1GainOffset_LTE = AID_Value[0];
??CtrlData_168:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_200
// 1510 			if(Ctrl)rval = TRUE;
// 1511 		break;
// 1512 
// 1513 		case Aid_Fwd1GainOffset_LTE_A:
// 1514 			Sts->Fwd1GainOffset_LTE_A = AID_Value[0];
??CtrlData_169:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_201
// 1515 			if(Ctrl)rval = TRUE;
// 1516 		break;
// 1517 
// 1518 		case Aid_Rvs1GainOffset_LTE_A:
// 1519 			Sts->Rvs1GainOffset_LTE_A = AID_Value[0];
??CtrlData_170:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_209
// 1520 			if(Ctrl)rval = TRUE;
// 1521 		break;
// 1522 		
// 1523 		case Aid_Fwd1AgcAttn_LTE:
// 1524 			Sts->Fwd1AgcAttn_LTE = AID_Value[0];
??CtrlData_171:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_220
// 1525 			if(Ctrl)rval = TRUE;
// 1526 		break;
// 1527 		
// 1528 		case Aid_Fwd1AgcAttn_LTE_A:
// 1529 			Sts->Fwd1AgcAttn_LTE_A = AID_Value[0];
??CtrlData_172:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_221
// 1530 			if(Ctrl)rval = TRUE;
// 1531 		break;
// 1532 		
// 1533 		
// 1534 		case Aid_Rvs1AlcAttn_LTE:
// 1535 			Sts->Rvs1AlcAttn_LTE = AID_Value[0];
??CtrlData_173:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_222
// 1536 			if(Ctrl)rval = TRUE;
// 1537 		break;		
// 1538 
// 1539 		case Aid_Rvs1AlcAttn_LTE_A:
// 1540 			Sts->Rvs1AlcAttn_LTE_A = AID_Value[0];
??CtrlData_174:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        STRB     R1,[R0, #+22]
// 1541 			if(Ctrl)rval = TRUE;
        B.N      ??CtrlData_189
// 1542 		break;		
// 1543 
// 1544 		case Aid_Rvs1AlcOnOff_LTE:
// 1545 			Sts->Rvs1AlcOnOff_LTE = AID_Value[0];
??CtrlData_175:
        ADDW     R0,R7,#+774
        LDRB     R1,[R4, #+0]
        B.N      ??CtrlData_202
// 1546 			if(Ctrl)rval = TRUE;
// 1547 		break;
// 1548 
// 1549 		case Aid_Rvs1AlcOnOff_LTE_A:
// 1550 			Sts->Rvs1AlcOnOff_LTE_A = AID_Value[0];
??CtrlData_176:
        ADDW     R0,R7,#+774
        B.N      ??CtrlData_203
// 1551 			if(Ctrl)rval = TRUE;
// 1552 		break;
// 1553 		
// 1554 		case Aid_ShutDownOnOff1_LTE:
// 1555 			Sts->ShutDownOnOff_LTE1 = AID_Value[0];
??CtrlData_177:
        LDRB     R0,[R4, #+0]
        STRB     R0,[R7, #+809]
        B.N      ??CtrlData_187
// 1556 		break;
// 1557 
// 1558 		case Aid_ShutDownOnOff1_LTE_A:
// 1559 			Sts->ShutDownOnOff_LTE_A1= AID_Value[0];
??CtrlData_178:
        ADDW     R0,R7,#+809
        B.N      ??CtrlData_228
// 1560 		break;
// 1561 
// 1562 		case Aid_Rvs1OutUpperLmt_LTE:
// 1563  			Sts->Rvs1OutUpperLmt_LTE[0] = AID_Value[0];
??CtrlData_179:
        ADDW     R0,R7,#+809
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+2]
// 1564  			Sts->Rvs1OutUpperLmt_LTE[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_195
// 1565  			if(Ctrl)rval = TRUE;
// 1566 		break;
// 1567 		
// 1568 		case Aid_Rvs1OutUpperLmt_LTE_A:
// 1569  			Sts->Rvs1OutUpperLmt_LTE_A[0] = AID_Value[0];
??CtrlData_180:
        ADDW     R0,R7,#+809
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+4]
// 1570  			Sts->Rvs1OutUpperLmt_LTE_A[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_215
// 1571  			if(Ctrl)rval = TRUE;
// 1572 		break;
// 1573 
// 1574 		case Aid_Fwd1OutHighLmt_LTE:
// 1575  			Sts->Fwd1OutHighLmt_LTE[0] = AID_Value[0];
??CtrlData_181:
        ADDW     R0,R7,#+809
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+10]
// 1576  			Sts->Fwd1OutHighLmt_LTE[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_226
// 1577  			if(Ctrl)rval = TRUE;
// 1578 		break;
// 1579 
// 1580 		case Aid_Fwd1OutHighLmt_LTE_A:
// 1581  			Sts->Fwd1OutHighLmt_LTE_A[0] = AID_Value[0];
??CtrlData_182:
        ADDW     R0,R7,#+809
        LDRSB    R1,[R4, R6]
        STRB     R1,[R0, #+12]
// 1582  			Sts->Fwd1OutHighLmt_LTE_A[1] = AID_Value[1];
        LDRSB    R1,[R4, #+1]
        B.N      ??CtrlData_197
// 1583  			if(Ctrl)rval = TRUE;
// 1584 		break;
// 1585 
// 1586 		case Aid_Rvs1ALCLvl_LTE:
// 1587 			Sts->Rvs1ALCLvl_LTE = AID_Value[0];
??CtrlData_183:
        ADDW     R0,R7,#+809
        B.N      ??CtrlData_198
// 1588 			if(Ctrl)rval = TRUE;
// 1589 		break;
// 1590 
// 1591 		case Aid_Rvs1ALCLvl_LTE_A:
// 1592 			Sts->Rvs1ALCLvl_LTE_A = AID_Value[0];
??CtrlData_184:
        ADDW     R0,R7,#+809
        B.N      ??CtrlData_199
// 1593 			if(Ctrl)rval = TRUE;
// 1594 		break; 
// 1595 		
// 1596 		case Aid_Det2Offset:
// 1597 			{
// 1598 				INT8U i;
// 1599 
// 1600 				for(i = 0; i < (sizeof(__DET2)); i++)	 *((INT8U *)&(Sts->Det2Offset.DetFwdInPwr_Common) + i) = AID_Value[i];
??CtrlData_186:
        MOVS     R0,#+16
??CtrlData_236:
        LDRB     R1,[R4], #+1
        STRB     R1,[R7, #+556]
        ADDS     R7,R7,#+1
        SUBS     R0,R0,#+1
        BNE.N    ??CtrlData_236
// 1601 				if(Ctrl)rval = TRUE;
??CtrlData_189:
        CBZ      R5,??CtrlData_187
??CtrlData_217:
        MOVS     R6,#+1
// 1602 			}	
// 1603 		break;
// 1604 
// 1605 		
// 1606 #endif
// 1607         default:
// 1608 #if 0
// 1609         if(tDnrSts->Test_Mode == Debug_defaultAID) 
// 1610 		{
// 1611 			SerPtr->printf("Default:[%x][%d][%d]\n",AID_Command,Length,AID_Value[0]);
// 1612 		}
// 1613 #endif        
// 1614 		break;
// 1615 	}
// 1616 	
// 1617 	return rval;
??CtrlData_187:
        MOV      R0,R6
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??CtrlData_0:
        DC32     tDnrSts
        DC32     `?<Constant "AID_Command [%x][%d][...">`
        DC32     SerPtr
        DC32     ChkAttChange
        DC32     Chk_Reset
// 1618 }
// 1619 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1620 void LoadBackupData(void)
// 1621 {
LoadBackupData:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
// 1622 	__Dnr_Sts *Sts = tDnrSts;
        LDR.W    R0,??LoadBackupData_0  ;; tDnrSts
        LDR      R10,[R0, #+0]
// 1623 
// 1624 	INT8U i = 0;
// 1625 
// 1626 	INT8U err = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
// 1627 	
// 1628 	INT8U rval = FALSE;
// 1629     i = i;
// 1630 	OSSemPend(CtrlSem, 0, &err);
        LDR.W    R8,??LoadBackupData_0+0x4  ;; CtrlSem
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        LDR      R0,[R8, #+0]
        BL       OSSemPend
// 1631 	{
// 1632 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.W    R0,??LoadBackupData_0+0x8  ;; 0x8006000
        BL       RoadBackuptobuffer
        MOV      R9,R0
// 1633 		INT8U iDataFlag = tptr->BackUp.IsDataFlag;
// 1634 		
// 1635 		if(iDataFlag != ISDATA)
// 1636 		{
// 1637 			// default set!!
// 1638 		}
// 1639 #if 1
// 1640 		Sts->FwdOutUpperLmt_3G[0]		= tptr->BackUp.FwdOutUpperLmt_3G[0];
        LDRB     R0,[R9, #+3]
        STRB     R0,[R10, #+38]
// 1641 		Sts->FwdOutUpperLmt_3G[1]		= tptr->BackUp.FwdOutUpperLmt_3G[1];
        ADD      R5,R10,#+38
        ADD      R0,R9,#+3
        LDRB     R1,[R0, #+1]
        STRB     R1,[R5, #+1]
// 1642 
// 1643 		Sts->FwdOutLowerLmt_3G[0]		= tptr->BackUp.FwdOutLowerLmt_3G[0];
        LDRB     R1,[R0, #+2]
        STRB     R1,[R5, #+2]
// 1644 		Sts->FwdOutLowerLmt_3G[1]		= tptr->BackUp.FwdOutLowerLmt_3G[1];
        LDRB     R1,[R0, #+3]
        STRB     R1,[R5, #+3]
// 1645 		
// 1646 		Sts->FwdGainSet_3G				= tptr->BackUp.FwdGainSet_3G;
        LDRB     R1,[R0, #+4]
        STRB     R1,[R5, #+4]
// 1647 		Sts->FwdOutUpperLmt_2G[0]		= tptr->BackUp.FwdOutUpperLmt_2G[0];
        LDRB     R1,[R0, #+5]
        STRB     R1,[R5, #+8]
// 1648 		Sts->FwdOutUpperLmt_2G[1]		= tptr->BackUp.FwdOutUpperLmt_2G[1];
        LDRB     R1,[R0, #+6]
        STRB     R1,[R5, #+9]
// 1649 
// 1650 		Sts->FwdOutLowerLmt_2G[0]		= tptr->BackUp.FwdOutLowerLmt_2G[0];
        LDRB     R1,[R0, #+7]
        STRB     R1,[R5, #+10]
// 1651 		Sts->FwdOutLowerLmt_2G[1]		= tptr->BackUp.FwdOutLowerLmt_2G[1];
        LDRB     R1,[R0, #+8]
        STRB     R1,[R5, #+11]
// 1652 
// 1653 		Sts->FwdGainSet_2G				= tptr->BackUp.FwdGainSet_2G;
        LDRB     R1,[R0, #+9]
        STRB     R1,[R5, #+12]
// 1654 		Sts->FwdOutUpperLmt_LTE[0]		= tptr->BackUp.FwdOutUpperLmt_LTE[0];
        LDRB     R1,[R0, #+10]
        STRB     R1,[R5, #+16]
// 1655 		Sts->FwdOutUpperLmt_LTE[1]		= tptr->BackUp.FwdOutUpperLmt_LTE[1];
        LDRB     R1,[R0, #+11]
        STRB     R1,[R5, #+17]
// 1656 		
// 1657 		Sts->FwdOutLowerLmt_LTE[0]		= tptr->BackUp.FwdOutLowerLmt_LTE[0];
        LDRB     R1,[R0, #+12]
        STRB     R1,[R5, #+18]
// 1658 		Sts->FwdOutLowerLmt_LTE[1]		= tptr->BackUp.FwdOutLowerLmt_LTE[1];
        LDRB     R1,[R0, #+13]
        STRB     R1,[R5, #+19]
// 1659 		
// 1660 		Sts->FwdGainSet_LTE 			= tptr->BackUp.FwdGainSet_LTE;
        LDRB     R1,[R0, #+14]
        STRB     R1,[R5, #+20]
// 1661 		Sts->FwdOutUpperLmt_LTE_A[0]	= tptr->BackUp.FwdOutUpperLmt_LTE_A[0];
        LDRB     R1,[R0, #+15]
        STRB     R1,[R5, #+24]
// 1662 		Sts->FwdOutUpperLmt_LTE_A[1]	= tptr->BackUp.FwdOutUpperLmt_LTE_A[1];
        LDRB     R1,[R0, #+16]
        STRB     R1,[R5, #+25]
// 1663 
// 1664 		Sts->FwdOutLowerLmt_LTE_A[0]	= tptr->BackUp.FwdOutLowerLmt_LTE_A[0];
        LDRB     R1,[R0, #+17]
        STRB     R1,[R5, #+26]
// 1665 		Sts->FwdOutLowerLmt_LTE_A[1]	= tptr->BackUp.FwdOutLowerLmt_LTE_A[1];
        LDRB     R1,[R0, #+18]
        STRB     R1,[R5, #+27]
// 1666 
// 1667 		Sts->FwdGainSet_LTE_A			= tptr->BackUp.FwdGainSet_LTE_A;
        LDRB     R1,[R0, #+19]
        STRB     R1,[R5, #+28]
// 1668 		Sts->Rvs0GainSet_3G 			= tptr->BackUp.Rvs0GainSet_3G;
        LDRB     R1,[R0, #+20]
        STRB     R1,[R5, #+30]
// 1669 		Sts->RvsGainBalance_3G			= tptr->BackUp.RvsGainBalance_3G;
        LDRB     R1,[R0, #+21]
        STRB     R1,[R10, #+70]
// 1670 		Sts->Rvs0GainSet_2G 			= tptr->BackUp.Rvs0GainSet_2G;
        ADD      R6,R10,#+70
        LDRB     R1,[R0, #+22]
        STRB     R1,[R6, #+1]
// 1671 		Sts->RvsGainBalance_2G			= tptr->BackUp.RvsGainBalance_2G;
        LDRB     R1,[R0, #+23]
        STRB     R1,[R6, #+3]
// 1672 		Sts->Rvs0GainSet_LTE			= tptr->BackUp.Rvs0GainSet_LTE;
        LDRB     R1,[R0, #+24]
        STRB     R1,[R6, #+4]
// 1673 		Sts->RvsGainBalance_LTE 		= tptr->BackUp.RvsGainBalance_LTE;
        LDRB     R1,[R0, #+25]
        STRB     R1,[R6, #+6]
// 1674 		Sts->Rvs0GainSet_LTE_A			= tptr->BackUp.Rvs0GainSet_LTE_A;
        LDRB     R1,[R0, #+26]
        STRB     R1,[R6, #+7]
// 1675 		Sts->RvsGainBalance_LTE_A		= tptr->BackUp.RvsGainBalance_LTE_A;
        LDRB     R1,[R0, #+27]
        STRB     R1,[R6, #+9]
// 1676 		Sts->AmpOffCase_3G				= tptr->BackUp.AmpOffCase_3G;
        LDRB     R1,[R0, #+28]
        STRB     R1,[R6, #+10]
// 1677 		Sts->AmpOffCase_Common			= tptr->BackUp.AmpOffCase_Common;
        LDRB     R1,[R0, #+29]
        STRB     R1,[R6, #+11]
// 1678 		Sts->AmpOffCase_LTE_A			= tptr->BackUp.AmpOffCase_LTE_A;
        LDRB     R1,[R0, #+30]
        STRB     R1,[R6, #+12]
// 1679 		Sts->BandSelect_15M 			= tptr->BackUp.BandSelect_15M;
        LDRB     R0,[R0, #+31]
        STRB     R0,[R6, #+16]
// 1680 		Sts->RepeatResetPriod 			= tptr->BackUp.RepeatResetPriod;
        LDRB     R0,[R9, #+35]
        STRB     R0,[R6, #+17]
// 1681 
// 1682 		
// 1683 /////////////////
// 1684 		Sts->AGCOnOff_3G				= tptr->BackUp.AGCOnOff_3G;
        ADD      R0,R9,#+35
        LDRB     R1,[R0, #+4]
        STRB     R1,[R6, #+23]
// 1685 		Sts->AGCOnOff_2G				= tptr->BackUp.AGCOnOff_2G;
        LDRB     R1,[R0, #+5]
        STRB     R1,[R6, #+24]
// 1686 		Sts->AGCOnOff_LTE				= tptr->BackUp.AGCOnOff_LTE;
        LDRB     R1,[R0, #+6]
        STRB     R1,[R6, #+27]
// 1687 		Sts->AGCOnOff_LTE_A				= tptr->BackUp.AGCOnOff_LTE_A;
        LDRB     R1,[R0, #+7]
        STRB     R1,[R6, #+28]
// 1688 		Sts->AGC1OnOff_LTE				= tptr->BackUp.AGC1OnOff_LTE;
        LDRB     R1,[R0, #+8]
        STRB     R1,[R6, #+31]
// 1689 		Sts->AGC1OnOff_LTE_A			= tptr->BackUp.AGC1OnOff_LTE_A;
        LDRB     R1,[R0, #+9]
        STRB     R1,[R10, #+102]
// 1690 		Sts->AGCMode_3G					= tptr->BackUp.AGCMode_3G;
        LDRB     R1,[R0, #+10]
        STRB     R1,[R6, #+25]
// 1691 		Sts->AGCMode_2G					= tptr->BackUp.AGCMode_2G;
        LDRB     R1,[R0, #+11]
        STRB     R1,[R6, #+26]
// 1692 		Sts->AGCMode_LTE				= tptr->BackUp.AGCMode_LTE;
        LDRB     R1,[R0, #+12]
        STRB     R1,[R6, #+29]
// 1693 		Sts->AGCMode_LTE_A				= tptr->BackUp.AGCMode_LTE_A;
        LDRB     R1,[R0, #+13]
        STRB     R1,[R6, #+30]
// 1694 		
// 1695 /////////////////////////////
// 1696 		Sts->AutoReportPriod			= tptr->BackUp.AutoReportPriod;
        LDRB     R1,[R0, #+1]
        STRB     R1,[R6, #+18]
// 1697 		Sts->AutoReportTime_H			= tptr->BackUp.AutoReportTime_H;
        LDRB     R1,[R0, #+2]
        STRB     R1,[R6, #+19]
// 1698 		Sts->AutoReportTime_M			= tptr->BackUp.AutoReportTime_M;
        LDRB     R1,[R0, #+3]
        STRB     R1,[R6, #+20]
// 1699 		Sts->TPTL_OnOff 				= tptr->BackUp.TPTL_OnOff;
        ADD      R1,R10,#+102
        LDRB     R2,[R0, #+14]
        STRB     R2,[R1, #+1]
// 1700 		Sts->TempOffset 				= tptr->BackUp.TempOffset;
        LDRB     R2,[R0, #+15]
        STRB     R2,[R1, #+2]
// 1701 		Sts->AlarmMask					= tptr->BackUp.AlarmMask;
        LDRB     R2,[R0, #+16]
        STRB     R2,[R1, #+4]
// 1702 		Sts->ModemOnOff 				= tptr->BackUp.ModemOnOff;
        LDRB     R1,[R0, #+17]
        STRB     R1,[R10, #+143]
// 1703 		Sts->VccDet_Lmt.Data			= tptr->BackUp.VccDet_Lmt.Data;
        LDRH     R1,[R0, #+18]
        STRH     R1,[R10, #+154]
// 1704 		Sts->FwdInPwrOffset_2G			= tptr->BackUp.FwdInPwrOffset_2G;
        ADD      R1,R10,#+154
        LDRB     R2,[R0, #+20]
        STRB     R2,[R1, #+2]
// 1705 		Sts->FwdInPwrOffset_3G			= tptr->BackUp.FwdInPwrOffset_3G;
        LDRB     R2,[R0, #+21]
        STRB     R2,[R1, #+3]
// 1706 		Sts->Rvs0OutPwrOffset_2G		= tptr->BackUp.Rvs0OutPwrOffset_2G;
        LDRB     R2,[R0, #+22]
        STRB     R2,[R1, #+4]
// 1707 		Sts->Rvs0OutPwrOffset_3G		= tptr->BackUp.Rvs0OutPwrOffset_3G;
        LDRB     R2,[R0, #+23]
        STRB     R2,[R1, #+5]
// 1708 		Sts->FwdOutPwrOffset_2G 		= tptr->BackUp.FwdOutPwrOffset_2G;
        LDRB     R2,[R0, #+24]
        STRB     R2,[R1, #+6]
// 1709 		Sts->FwdOutPwrOffset_3G 		= tptr->BackUp.FwdOutPwrOffset_3G;
        LDRB     R2,[R0, #+25]
        STRB     R2,[R1, #+7]
// 1710 		Sts->ResetPeriodCountSet[0] 	= tptr->BackUp.ResetPeriodCountSet[0];
        LDRB     R1,[R0, #+26]
        STRB     R1,[R10, #+188]
// 1711 		Sts->ResetPeriodCountSet[1] 	= tptr->BackUp.ResetPeriodCountSet[1];
        ADD      R1,R10,#+188
        LDRB     R2,[R0, #+27]
        STRB     R2,[R1, #+1]
// 1712 		Sts->ResetPeriodCountSet[2] 	= tptr->BackUp.ResetPeriodCountSet[2];
        LDRB     R2,[R0, #+28]
        STRB     R2,[R1, #+2]
// 1713 		Sts->FwdInPwrOffset_LTE 		= tptr->BackUp.FwdInPwrOffset_LTE;
        LDRB     R2,[R0, #+29]
        STRB     R2,[R1, #+3]
// 1714 		Sts->FwdOutPwrOffset_LTE		= tptr->BackUp.FwdOutPwrOffset_LTE;
        LDRB     R2,[R0, #+30]
        STRB     R2,[R1, #+4]
// 1715 		Sts->RvsOutPwrOffset_LTE		= tptr->BackUp.RvsOutPwrOffset_LTE;
        LDRB     R2,[R0, #+31]
        STRB     R2,[R1, #+5]
// 1716 		Sts->RvsOutUpperLmt_3G[0]		= tptr->BackUp.RvsOutUpperLmt_3G[0];
        LDRB     R2,[R0, #+32]
        STRB     R2,[R1, #+15]
// 1717 		Sts->RvsOutUpperLmt_3G[1]		= tptr->BackUp.RvsOutUpperLmt_3G[1];
        LDRB     R2,[R0, #+33]
        STRB     R2,[R1, #+16]
// 1718 		Sts->RvsOutUpperLmt_2G[0]		= tptr->BackUp.RvsOutUpperLmt_2G[0];
        LDRB     R2,[R0, #+34]
        STRB     R2,[R1, #+17]
// 1719 		Sts->RvsOutUpperLmt_2G[1]		= tptr->BackUp.RvsOutUpperLmt_2G[1];
        LDRB     R0,[R0, #+35]
        STRB     R0,[R1, #+18]
// 1720 		Sts->FwdGainOffset_3G			= tptr->BackUp.FwdGainOffset_3G;
        LDRB     R0,[R9, #+71]
        STRB     R0,[R1, #+19]
// 1721 		Sts->RvsGainOffset_3G			= tptr->BackUp.RvsGainOffset_3G;
        ADD      R7,R9,#+71
        LDRB     R0,[R7, #+1]
        STRB     R0,[R1, #+20]
// 1722 		Sts->FwdGainOffset_2G			= tptr->BackUp.FwdGainOffset_2G;
        LDRB     R0,[R7, #+2]
        STRB     R0,[R1, #+21]
// 1723 		Sts->RvsGainOffset_2G			= tptr->BackUp.RvsGainOffset_2G;
        LDRB     R0,[R7, #+3]
        STRB     R0,[R1, #+22]
// 1724 		Sts->FwdOutHighLmt_3G[0]		= tptr->BackUp.FwdOutHighLmt_3G[0];
        LDRB     R0,[R7, #+4]
        STRB     R0,[R1, #+27]
// 1725 		Sts->FwdOutHighLmt_3G[1]		= tptr->BackUp.FwdOutHighLmt_3G[1];
        LDRB     R0,[R7, #+5]
        STRB     R0,[R1, #+28]
// 1726 		Sts->FwdOutHighLmt_2G[0]		= tptr->BackUp.FwdOutHighLmt_2G[0];
        LDRB     R0,[R7, #+6]
        STRB     R0,[R1, #+29]
// 1727 		Sts->FwdOutHighLmt_2G[1]		= tptr->BackUp.FwdOutHighLmt_2G[1];
        LDRB     R0,[R7, #+7]
        STRB     R0,[R1, #+30]
// 1728 
// 1729 		memcpy((INT8U*)&Sts->DetOffset, (INT8U*)&tptr->BackUp.DetOffset, sizeof(__DET));
        MOVS     R2,#+22
        ADD      R1,R9,#+79
        ADDW     R0,R10,#+319
        BL       __aeabi_memcpy
// 1730 
// 1731 		Sts->FwdInPwrOffset_LTE_A		= tptr->BackUp.FwdInPwrOffset_LTE_A;
        LDRB     R0,[R7, #+30]
        STRB     R0,[R10, #+427]
// 1732 		Sts->FwdOutPwrOffset_LTE_A		= tptr->BackUp.FwdOutPwrOffset_LTE_A;
        ADDW     R0,R10,#+427
        LDRB     R1,[R7, #+31]
        STRB     R1,[R0, #+1]
// 1733 		Sts->RvsOutPwrOffset_LTE_A		= tptr->BackUp.RvsOutPwrOffset_LTE_A;
        LDRB     R1,[R7, #+32]
        STRB     R1,[R0, #+2]
// 1734 		Sts->FwdGainOffset_LTE			= tptr->BackUp.FwdGainOffset_LTE;
        LDRB     R0,[R9, #+104]
        STRB     R0,[R10, #+460]
// 1735 		Sts->RvsGainOffset_LTE			= tptr->BackUp.RvsGainOffset_LTE;
        ADD      R1,R10,#+460
        ADD      R0,R9,#+104
        LDRB     R2,[R0, #+1]
        STRB     R2,[R1, #+1]
// 1736 		Sts->FwdGainOffset_LTE_A		= tptr->BackUp.FwdGainOffset_LTE_A;
        LDRB     R2,[R0, #+2]
        STRB     R2,[R1, #+2]
// 1737 		Sts->RvsGainOffset_LTE_A		= tptr->BackUp.RvsGainOffset_LTE_A;
        LDRB     R2,[R0, #+3]
        STRB     R2,[R1, #+3]
// 1738 #if 0
// 1739 		Sts->FwdAgcAttn_2G				= tptr->BackUp.FwdAgcAttn_2G;
// 1740 		Sts->FwdAgcAttn_LTE 			= tptr->BackUp.FwdAgcAttn_LTE;
// 1741 		Sts->FwdAgcAttn_LTE_A			= tptr->BackUp.FwdAgcAttn_LTE_A;
// 1742 		Sts->FwdAgcAttn_3G				= tptr->BackUp.FwdAgcAttn_3G;
// 1743 		Sts->RvsAlcAttn_2G				= tptr->BackUp.RvsAlcAttn_2G;
// 1744 		Sts->RvsAlcAttn_LTE 			= tptr->BackUp.RvsAlcAttn_LTE;
// 1745 		Sts->RvsAlcAttn_LTE_A			= tptr->BackUp.RvsAlcAttn_LTE_A;
// 1746 		Sts->RvsAlcAttn_3G				= tptr->BackUp.RvsAlcAttn_3G;
// 1747 #endif
// 1748         Sts->RvsAlcOnOff_2G 			= tptr->BackUp.RvsAlcOnOff_2G;
        LDRB     R2,[R0, #+4]
        STRB     R2,[R1, #+12]
// 1749 		Sts->RvsAlcOnOff_LTE			= tptr->BackUp.RvsAlcOnOff_LTE;
        LDRB     R2,[R0, #+5]
        STRB     R2,[R1, #+13]
// 1750 		Sts->RvsAlcOnOff_LTE_A			= tptr->BackUp.RvsAlcOnOff_LTE_A;
        LDRB     R2,[R0, #+6]
        STRB     R2,[R1, #+14]
// 1751 		Sts->RvsAlcOnOff_3G 			= tptr->BackUp.RvsAlcOnOff_3G;
        LDRB     R2,[R0, #+7]
        STRB     R2,[R1, #+15]
// 1752 		Sts->RvsOutUpperLmt_LTE[0]		= tptr->BackUp.RvsOutUpperLmt_LTE[0];
        LDRB     R1,[R0, #+8]
        STRB     R1,[R10, #+497]
// 1753 		Sts->RvsOutUpperLmt_LTE[1]		= tptr->BackUp.RvsOutUpperLmt_LTE[1];
        ADDW     R1,R10,#+497
        LDRB     R2,[R0, #+9]
        STRB     R2,[R1, #+1]
// 1754 		Sts->RvsOutUpperLmt_LTE_A[0]	= tptr->BackUp.RvsOutUpperLmt_LTE_A[0];
        LDRB     R2,[R0, #+10]
        STRB     R2,[R1, #+2]
// 1755 		Sts->RvsOutUpperLmt_LTE_A[1]	= tptr->BackUp.RvsOutUpperLmt_LTE_A[1];
        LDRB     R2,[R0, #+11]
        STRB     R2,[R1, #+3]
// 1756 		Sts->FwdOutHighLmt_LTE[0]		= tptr->BackUp.FwdOutHighLmt_LTE[0];
        LDRB     R2,[R0, #+12]
        STRB     R2,[R1, #+8]
// 1757 		Sts->FwdOutHighLmt_LTE[1]		= tptr->BackUp.FwdOutHighLmt_LTE[1];
        LDRB     R2,[R0, #+13]
        STRB     R2,[R1, #+9]
// 1758 		Sts->FwdOutHighLmt_LTE_A[0] 	= tptr->BackUp.FwdOutHighLmt_LTE_A[0];
        LDRB     R2,[R0, #+14]
        STRB     R2,[R1, #+10]
// 1759 		Sts->FwdOutHighLmt_LTE_A[1] 	= tptr->BackUp.FwdOutHighLmt_LTE_A[1];
        LDRB     R2,[R0, #+15]
        STRB     R2,[R1, #+11]
// 1760 		Sts->OverInAlarmLmt_2G			= tptr->BackUp.OverInAlarmLmt_2G;
        LDRB     R2,[R0, #+16]
        STRB     R2,[R1, #+12]
// 1761 		Sts->OverInAlarmLmt_LTE 		= tptr->BackUp.OverInAlarmLmt_LTE;
        LDRB     R2,[R0, #+17]
        STRB     R2,[R1, #+13]
// 1762 		Sts->OverInAlarmLmt_LTE_A		= tptr->BackUp.OverInAlarmLmt_LTE_A;
        LDRB     R2,[R0, #+18]
        STRB     R2,[R1, #+14]
// 1763 		Sts->OverInAlarmLmt_3G			= tptr->BackUp.OverInAlarmLmt_3G;
        LDRB     R2,[R0, #+19]
        STRB     R2,[R1, #+15]
// 1764 		Sts->OtherOverInAlarmLmt_2G 	= tptr->BackUp.OtherOverInAlarmLmt_2G;
        LDRB     R2,[R0, #+20]
        STRB     R2,[R1, #+16]
// 1765 		Sts->OtherOverInAlarmLmt_LTE	= tptr->BackUp.OtherOverInAlarmLmt_LTE;
        LDRB     R2,[R0, #+21]
        STRB     R2,[R1, #+17]
// 1766 		Sts->OtherOverInAlarmLmt_LTE_A	= tptr->BackUp.OtherOverInAlarmLmt_LTE_A;
        LDRB     R2,[R0, #+22]
        STRB     R2,[R1, #+18]
// 1767 		Sts->OtherOverInAlarmLmt_3G 	= tptr->BackUp.OtherOverInAlarmLmt_3G;
        LDRB     R2,[R0, #+23]
        STRB     R2,[R1, #+19]
// 1768 		Sts->RvsALCLvl_2G				= tptr->BackUp.RvsALCLvl_2G; 
        LDRB     R2,[R0, #+24]
        STRB     R2,[R1, #+20]
// 1769 		Sts->RvsALCLvl_LTE				= tptr->BackUp.RvsALCLvl_LTE;
        LDRB     R2,[R0, #+25]
        STRB     R2,[R1, #+21]
// 1770 		Sts->RvsALCLvl_LTE_A			= tptr->BackUp.RvsALCLvl_LTE_A;
        LDRB     R2,[R0, #+26]
        STRB     R2,[R1, #+22]
// 1771 		Sts->RvsALCLvl_3G				= tptr->BackUp.RvsALCLvl_3G;
        LDRB     R2,[R0, #+27]
        STRB     R2,[R1, #+23]
// 1772 
// 1773 #ifdef __1stType
// 1774 #else
// 1775 		//	Sts->RmtFwdInPwrOffset_Common		= ReadAT24C64(RmtFwdInPwrOffset_CommonBp	); 
// 1776 
// 1777 #endif	
// 1778 
// 1779 		/////////////////////////////////////////////////////////////
// 1780 
// 1781 		Sts->RxMaxVal[0]				= tptr->BackUp.RxMaxVal[0];
        LDRB     R1,[R0, #+28]
        STRB     R1,[R10, #+572]
// 1782 		Sts->RxMaxVal[1]				= tptr->BackUp.RxMaxVal[1];
        ADD      R1,R10,#+572
        LDRB     R2,[R0, #+29]
        STRB     R2,[R1, #+1]
// 1783 		Sts->RxMinVal[0]				= tptr->BackUp.RxMinVal[0];
        LDRB     R2,[R0, #+30]
        STRB     R2,[R1, #+2]
// 1784 		Sts->RxMinVal[1]				= tptr->BackUp.RxMinVal[1];
        LDRB     R0,[R0, #+31]
        STRB     R0,[R1, #+3]
// 1785 		Sts->TxMaxVal[0]				= tptr->BackUp.TxMaxVal[0];
        LDRB     R0,[R9, #+136]
        STRB     R0,[R1, #+4]
// 1786 		Sts->TxMaxVal[1]				= tptr->BackUp.TxMaxVal[1];
        ADD      R4,R9,#+136
        LDRB     R0,[R4, #+1]
        STRB     R0,[R1, #+5]
// 1787 		Sts->TxMinVal[0]				= tptr->BackUp.TxMinVal[0];
        LDRB     R0,[R4, #+2]
        STRB     R0,[R1, #+6]
// 1788 		Sts->TxMinVal[1]				= tptr->BackUp.TxMinVal[1];
        LDRB     R0,[R4, #+3]
        STRB     R0,[R1, #+7]
// 1789 #if 0
// 1790 		Sts->AdjMaxVal[0]				= tptr->BackUp.AdjMaxVal[0];
// 1791 		Sts->AdjMaxVal[1]				= tptr->BackUp.AdjMaxVal[1];
// 1792 		Sts->AdjMinVal[0]				= tptr->BackUp.AdjMinVal[0];
// 1793 		Sts->AdjMinVal[1]				= tptr->BackUp.AdjMinVal[1];
// 1794 #endif        
// 1795 		Sts->EcIo						= tptr->BackUp.EcIo;
        LDRB     R0,[R4, #+4]
        STRB     R0,[R1, #+12]
// 1796 		Sts->AR_Mode[0] 				= tptr->BackUp.AR_Mode[0];
        LDRB     R0,[R4, #+5]
        STRB     R0,[R1, #+13]
// 1797 		Sts->AR_Mode[1] 				= tptr->BackUp.AR_Mode[1];
        LDRB     R0,[R4, #+6]
        STRB     R0,[R1, #+14]
// 1798 		Sts->Radio_ReportTime[0]		= tptr->BackUp.Radio_ReportTime[0];
        LDRB     R0,[R4, #+7]
        STRB     R0,[R1, #+15]
// 1799 		Sts->Radio_ReportTime[1]		= tptr->BackUp.Radio_ReportTime[1];
        LDRB     R0,[R4, #+8]
        STRB     R0,[R1, #+16]
// 1800 		Sts->Radio_ReportPeriod[0]		= tptr->BackUp.Radio_ReportPeriod[0];
        LDRB     R0,[R4, #+9]
        STRB     R0,[R1, #+17]
// 1801 		Sts->Radio_ReportPeriod[1]		= tptr->BackUp.Radio_ReportPeriod[1];
        LDRB     R0,[R4, #+10]
        STRB     R0,[R1, #+18]
// 1802 
// 1803 		memcpy((INT8U*)&Sts->TestStn, (INT8U*)&tptr->BackUp.TestStn, sizeof(Sts->TestStn));
        MOVS     R2,#+11
        ADD      R1,R9,#+147
        ADDW     R0,R10,#+591
        BL       __aeabi_memcpy
// 1804 
// 1805 #ifdef _MIMO_Type 
// 1806 		Sts->Fwd1OutUpperLmt_LTE[0]		= tptr->BackUp.Fwd1OutUpperLmt_LTE[0];
        LDRB     R0,[R4, #+22]
        STRB     R0,[R10, #+657]
// 1807 		Sts->Fwd1OutUpperLmt_LTE[1]		= tptr->BackUp.Fwd1OutUpperLmt_LTE[1];
        ADDW     R7,R10,#+657
        LDRB     R0,[R4, #+23]
        STRB     R0,[R7, #+1]
// 1808 		Sts->Fwd1OutLowerLmt_LTE[0]		= tptr->BackUp.Fwd1OutLowerLmt_LTE[0];
        LDRB     R0,[R4, #+24]
        STRB     R0,[R7, #+2]
// 1809 		Sts->Fwd1OutLowerLmt_LTE[1]		= tptr->BackUp.Fwd1OutLowerLmt_LTE[1];
        LDRB     R0,[R4, #+25]
        STRB     R0,[R7, #+3]
// 1810 		Sts->Fwd1GainSet_LTE			= tptr->BackUp.Fwd1GainSet_LTE;
        LDRB     R0,[R4, #+26]
        STRB     R0,[R7, #+4]
// 1811 		Sts->Fwd1OutUpperLmt_LTE_A[0]	= tptr->BackUp.Fwd1OutUpperLmt_LTE_A[0];
        LDRB     R0,[R4, #+27]
        STRB     R0,[R7, #+8]
// 1812 		Sts->Fwd1OutUpperLmt_LTE_A[1]	= tptr->BackUp.Fwd1OutUpperLmt_LTE_A[1];
        LDRB     R0,[R4, #+28]
        STRB     R0,[R7, #+9]
// 1813 		Sts->Fwd1OutLowerLmt_LTE_A[0]	= tptr->BackUp.Fwd1OutLowerLmt_LTE_A[0];
        LDRB     R0,[R4, #+29]
        STRB     R0,[R7, #+10]
// 1814 		Sts->Fwd1OutLowerLmt_LTE_A[1]	= tptr->BackUp.Fwd1OutLowerLmt_LTE_A[1];
        LDRB     R0,[R4, #+30]
        STRB     R0,[R7, #+11]
// 1815 
// 1816 		Sts->Fwd1GainSet_LTE_A			= tptr->BackUp.Fwd1GainSet_LTE_A;
        LDRB     R0,[R4, #+31]
        STRB     R0,[R7, #+12]
// 1817 		Sts->Rvs1GainSet_LTE			= tptr->BackUp.Rvs1GainSet_LTE;
        LDRB     R0,[R9, #+168]
        STRB     R0,[R7, #+14]
// 1818 		Sts->Rvs1GainBalance_LTE		= tptr->BackUp.Rvs1GainBalance_LTE;
        ADD      R4,R9,#+168
        LDRB     R0,[R4, #+1]
        STRB     R0,[R7, #+16]
// 1819 		Sts->Rvs1GainSet_LTE_A			= tptr->BackUp.Rvs1GainSet_LTE_A;
        LDRB     R0,[R4, #+2]
        STRB     R0,[R7, #+17]
// 1820 		Sts->Rvs1GainBalance_LTE_A		= tptr->BackUp.Rvs1GainBalance_LTE_A;
        LDRB     R0,[R4, #+3]
        STRB     R0,[R7, #+19]
// 1821 		Sts->Amp1OffCase_LTE			= tptr->BackUp.Amp1OffCase_LTE;
        LDRB     R0,[R4, #+4]
        STRB     R0,[R7, #+22]
// 1822 		Sts->Amp1OffCase_LTE_A			= tptr->BackUp.Amp1OffCase_LTE_A;
        LDRB     R0,[R4, #+5]
        STRB     R0,[R7, #+23]
// 1823 
// 1824 		memcpy((INT8U*)&Sts->Det1Offset, (INT8U*)&tptr->BackUp.Det1Offset, sizeof(__DET1));
        MOVS     R2,#+8
        ADD      R1,R9,#+174
        ADDW     R0,R10,#+717
        BL       __aeabi_memcpy
// 1825 
// 1826 
// 1827 		Sts->Fwd1InPwrOffset_LTE_A		= tptr->BackUp.Fwd1InPwrOffset_LTE_A;
        LDRB     R0,[R4, #+17]
        STRB     R0,[R10, #+762]
// 1828 		Sts->Fwd1OutPwrOffset_LTE_A 	= tptr->BackUp.Fwd1OutPwrOffset_LTE_A;
        ADDW     R0,R10,#+762
        LDRB     R1,[R4, #+18]
        STRB     R1,[R0, #+1]
// 1829 		Sts->Rvs1OutPwrOffset_LTE_A 	= tptr->BackUp.Rvs1OutPwrOffset_LTE_A;
        LDRB     R1,[R4, #+19]
        STRB     R1,[R0, #+2]
// 1830 		Sts->Fwd1GainOffset_LTE 		= tptr->BackUp.Fwd1GainOffset_LTE;
        LDRB     R1,[R4, #+20]
        STRB     R1,[R0, #+27]
// 1831 		Sts->Rvs1GainOffset_LTE 		= tptr->BackUp.Rvs1GainOffset_LTE;
        LDRB     R1,[R4, #+21]
        STRB     R1,[R0, #+28]
// 1832 		Sts->Fwd1GainOffset_LTE_A		= tptr->BackUp.Fwd1GainOffset_LTE_A;
        LDRB     R1,[R4, #+22]
        STRB     R1,[R0, #+29]
// 1833 		Sts->Rvs1GainOffset_LTE_A		= tptr->BackUp.Rvs1GainOffset_LTE_A;
        LDRB     R1,[R4, #+23]
        STRB     R1,[R0, #+30]
// 1834 #if 0
// 1835 		Sts->Fwd1AgcAttn_LTE			= tptr->BackUp.Fwd1AgcAttn_LTE;
// 1836 		Sts->Fwd1AgcAttn_LTE_A			= tptr->BackUp.Fwd1AgcAttn_LTE_A;
// 1837 		Sts->Rvs1AlcAttn_LTE			= tptr->BackUp.Rvs1AlcAttn_LTE;
// 1838 		Sts->Rvs1AlcAttn_LTE_A			= tptr->BackUp.Rvs1AlcAttn_LTE_A;
// 1839 		Sts->Rvs1AlcOnOff_LTE			= tptr->BackUp.Rvs1AlcOnOff_LTE;
// 1840 		Sts->Rvs1AlcOnOff_LTE_A 		= tptr->BackUp.Rvs1AlcOnOff_LTE_A;
// 1841 #endif
// 1842 		Sts->Rvs1OutUpperLmt_LTE[0] 	= tptr->BackUp.Rvs1OutUpperLmt_LTE[0];
        LDRB     R0,[R4, #+24]
        STRB     R0,[R10, #+811]
// 1843 		Sts->Rvs1OutUpperLmt_LTE[1] 	= tptr->BackUp.Rvs1OutUpperLmt_LTE[1];
        ADDW     R0,R10,#+811
        LDRB     R1,[R4, #+25]
        STRB     R1,[R0, #+1]
// 1844 		Sts->Rvs1OutUpperLmt_LTE_A[0]	= tptr->BackUp.Rvs1OutUpperLmt_LTE_A[0];
        LDRB     R1,[R4, #+26]
        STRB     R1,[R0, #+2]
// 1845 		Sts->Rvs1OutUpperLmt_LTE_A[1]	= tptr->BackUp.Rvs1OutUpperLmt_LTE_A[1];
        LDRB     R1,[R4, #+27]
        STRB     R1,[R0, #+3]
// 1846 		Sts->Fwd1OutHighLmt_LTE[0]		= tptr->BackUp.Fwd1OutHighLmt_LTE[0];
        LDRB     R1,[R4, #+28]
        STRB     R1,[R0, #+8]
// 1847 		Sts->Fwd1OutHighLmt_LTE[1]		= tptr->BackUp.Fwd1OutHighLmt_LTE[1];
        LDRB     R1,[R4, #+29]
        STRB     R1,[R0, #+9]
// 1848 		Sts->Fwd1OutHighLmt_LTE_A[0]	= tptr->BackUp.Fwd1OutHighLmt_LTE_A[0];
        LDRB     R1,[R4, #+30]
        STRB     R1,[R0, #+10]
// 1849 		Sts->Fwd1OutHighLmt_LTE_A[1]	= tptr->BackUp.Fwd1OutHighLmt_LTE_A[1];
        LDRB     R1,[R4, #+31]
        STRB     R1,[R0, #+11]
// 1850 		Sts->Rvs1ALCLvl_LTE 			= tptr->BackUp.Rvs1ALCLvl_LTE;
        LDRB     R1,[R9, #+200]
        STRB     R1,[R0, #+12]
// 1851 		Sts->Rvs1ALCLvl_LTE_A			= tptr->BackUp.Rvs1ALCLvl_LTE_A;
        ADD      R1,R9,#+200
        LDRB     R1,[R1, #+1]
        STRB     R1,[R0, #+13]
// 1852 
// 1853 
// 1854 
// 1855 		memcpy((INT8U*)&Sts->Det2Offset, (INT8U*)&tptr->BackUp.Det2Offset, sizeof(__DET2));
        MOVS     R2,#+16
        ADD      R1,R9,#+207
        ADD      R0,R10,#+556
        BL       __aeabi_memcpy
// 1856 
// 1857 #endif
// 1858 
// 1859 
// 1860 #endif
// 1861 
// 1862 #if 0
// 1863 	
// 1864 #if 0
// 1865 			Sts->FwdAttn1_2G		= ReadAT24C64(FwdAttn1_2G	); 
// 1866 			Sts->FwdAttn2_2G		= ReadAT24C64(FwdAttn2_2G	); 
// 1867 			Sts->RvsAttn1_2G		= ReadAT24C64(RvsAttn1_2G	); 
// 1868 			Sts->RvsAttn2_2G		= ReadAT24C64(RvsAttn2_2G	); 
// 1869 			Sts->RvsAttn3_2G		= ReadAT24C64(RvsAttn3_2G	); 
// 1870 	
// 1871 			SerPtr->printf(" Att:[%d][%d][%d][%d][%d]\n", Sts->FwdAttn1_2G,Sts->FwdAttn2_2G,Sts->RvsAttn1_2G,Sts->RvsAttn2_2G,Sts->RvsAttn3_2G);
// 1872 #endif
// 1873 	
// 1874 			Sts->FwdAttn1_2G			= tptr->BackUp.FwdAttn1_2G; 	
// 1875 			Sts->FwdAttn2_2G			= tptr->BackUp.FwdAttn2_2G; 	
// 1876 			Sts->RvsAttn1_2G			= tptr->BackUp.RvsAttn1_2G; 	
// 1877 			Sts->RvsAttn2_2G			= tptr->BackUp.RvsAttn2_2G; 	
// 1878 			Sts->RvsAttn3_2G			= tptr->BackUp.RvsAttn3_2G; 	
// 1879 			Sts->FwdAttn1_3G			= tptr->BackUp.FwdAttn1_3G; 	
// 1880 			Sts->FwdAttn2_3G			= tptr->BackUp.FwdAttn2_3G; 	
// 1881 			Sts->RvsAttn1_3G			= tptr->BackUp.RvsAttn1_3G; 	
// 1882 			Sts->RvsAttn2_3G			= tptr->BackUp.RvsAttn2_3G; 	
// 1883 			Sts->RvsAttn3_3G			= tptr->BackUp.RvsAttn3_3G; 	
// 1884 			Sts->RvsAttn4_3G			= tptr->BackUp.RvsAttn4_3G; 	
// 1885 			Sts->FwdAttn1_Common		= tptr->BackUp.FwdAttn1_Common;
// 1886 			Sts->RvsAttn1_Common		= tptr->BackUp.RvsAttn1_Common;
// 1887 			Sts->FwdAttn1_LTE			= tptr->BackUp.FwdAttn1_LTE;		
// 1888 			Sts->FwdAttn2_LTE			= tptr->BackUp.FwdAttn2_LTE;		
// 1889 			Sts->FwdAttn1_LTE_A 		= tptr->BackUp.FwdAttn1_LTE_A; 
// 1890 			Sts->FwdAttn2_LTE_A 		= tptr->BackUp.FwdAttn2_LTE_A; 
// 1891 			Sts->RvsAttn1_LTE			= tptr->BackUp.RvsAttn1_LTE;		
// 1892 			Sts->RvsAttn2_LTE			= tptr->BackUp.RvsAttn2_LTE;		
// 1893 			Sts->RvsAttn3_LTE			= tptr->BackUp.RvsAttn3_LTE;		
// 1894 			Sts->RvsAttn1_LTE_A 		= tptr->BackUp.RvsAttn1_LTE_A; 
// 1895 			Sts->RvsAttn2_LTE_A 		= tptr->BackUp.RvsAttn2_LTE_A; 
// 1896 			Sts->RvsAttn3_LTE_A 		= tptr->BackUp.RvsAttn3_LTE_A; 
// 1897 			Sts->RvsAttn4_LTE_A 		= tptr->BackUp.RvsAttn4_LTE_A; 
// 1898 	
// 1899 	
// 1900 			Sts->AmpOnOff_3G			= tptr->BackUp.AmpOnOff_3G; 
// 1901 			Sts->AmpOnOff_Common		= tptr->BackUp.AmpOnOff_Common; 
// 1902 			Sts->AmpOnOff_LTE_A 		= tptr->BackUp.AmpOnOff_LTE_A; 
// 1903 			Sts->Amp1OnOff_LTE			= tptr->BackUp.Amp1OnOff_LTE; 
// 1904 			Sts->Amp1OnOff_LTE_A		= tptr->BackUp.Amp1OnOff_LTE_A; 
// 1905 	
// 1906 	
// 1907 #endif
// 1908 
// 1909 
// 1910 	///////////////////////////////////////////////////////////////////////
// 1911 		Sts->ResetCase = rambackup[0];
        LDR.N    R0,??LoadBackupData_0+0xC  ;; rambackup
        LDR      R1,[R0, #+0]
        LDRSB    R1,[R1, #+0]
        STRB     R1,[R10, #+862]
// 1912 		rambackup[0] = 0;
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
// 1913 
// 1914 		if(Sts->ResetCase != 0x01 && Sts->ResetCase != 0x02 && Sts->ResetCase != 0x04)
        LDRSB    R0,[R10, #+862]
        CMP      R0,#+1
        BEQ.N    ??LoadBackupData_1
        CMP      R0,#+2
        BEQ.N    ??LoadBackupData_1
        CMP      R0,#+4
        BEQ.N    ??LoadBackupData_1
// 1915 			Sts->ResetCase = 0x03;
        MOVS     R0,#+3
        STRB     R0,[R10, #+862]
// 1916 
// 1917 		Sts->ResetCase = Sts->ResetCase;
// 1918 
// 1919 		if(rval) WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
// 1920 	}
// 1921 	OSSemPost(CtrlSem);
??LoadBackupData_1:
        LDR      R0,[R8, #+0]
        BL       OSSemPost
// 1922 
// 1923 //	LoadTableConv();
// 1924 
// 1925 	 Sts->FwdGainAttn_2G 		= GainAttnCalculation(Sts->FwdGainSet_2G,Gain_2G,ATTENMIN);
        ADDW     R10,R10,#+862
        MOVS     R2,#+0
        MOVS     R1,#+146
        LDRB     R0,[R5, #+12]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+8]
// 1926 	 Sts->RvsGainAttn_2G 		= GainAttnCalculation(Sts->Rvs0GainSet_2G,Gain_2G,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        LDRB     R0,[R6, #+1]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+9]
// 1927 	 Sts->FwdGainAttn_3G 		= GainAttnCalculation(Sts->FwdGainSet_3G,Gain_3G,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        LDRB     R0,[R5, #+4]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+10]
// 1928 	 Sts->RvsGainAttn_3G 		= GainAttnCalculation(Sts->Rvs0GainSet_3G,Gain_3G,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        LDRB     R0,[R5, #+30]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+11]
// 1929 	 Sts->FwdGainAttn_LTE 		= GainAttnCalculation(Sts->FwdGainSet_LTE,Gain_LTE,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        LDRB     R0,[R5, #+20]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+12]
// 1930 	 Sts->RvsGainAttn_LTE 		= GainAttnCalculation(Sts->Rvs0GainSet_LTE,Gain_LTE,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        LDRB     R0,[R6, #+4]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+13]
// 1931 	 Sts->FwdGainAttn_LTE_A		= GainAttnCalculation(Sts->FwdGainSet_LTE_A,Gain_LTE_A,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        LDRB     R0,[R5, #+28]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+14]
// 1932 	 Sts->RvsGainAttn_LTE_A		= GainAttnCalculation(Sts->Rvs0GainSet_LTE_A,Gain_LTE_A,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        LDRB     R0,[R6, #+7]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+15]
// 1933 	 Sts->Fwd1GainAttn_LTE 		= GainAttnCalculation(Sts->Fwd1GainSet_LTE,Gain_LTE,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        LDRB     R0,[R7, #+4]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+16]
// 1934 	 Sts->Rvs1GainAttn_LTE 		= GainAttnCalculation(Sts->Rvs1GainSet_LTE,Gain_LTE,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+146
        LDRB     R0,[R7, #+14]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+17]
// 1935 	 Sts->Fwd1GainAttn_LTE_A	= GainAttnCalculation(Sts->Fwd1GainSet_LTE_A,Gain_LTE_A,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        LDRB     R0,[R7, #+12]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+18]
// 1936 	 Sts->Rvs1GainAttn_LTE_A	= GainAttnCalculation(Sts->Rvs1GainSet_LTE_A,Gain_LTE_A,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+166
        LDRB     R0,[R7, #+17]
        BL       GainAttnCalculation
        STRB     R0,[R10, #+19]
// 1937 }
        POP      {R0,R1,R4-R10,PC}  ;; return
        DATA
??LoadBackupData_0:
        DC32     tDnrSts
        DC32     CtrlSem
        DC32     0x8006000
        DC32     rambackup
// 1938 
// 1939 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1940 void SaveBackupData(void)
// 1941 {
SaveBackupData:
        PUSH     {R4-R10,LR}
// 1942 	__Dnr_Sts *Sts = tDnrSts;
        LDR.N    R0,??SaveBackupData_0  ;; tDnrSts
        LDR      R8,[R0, #+0]
// 1943 
// 1944    	INT32U cpu_sr;
// 1945 
// 1946 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R9,R0
// 1947 	{
// 1948 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.W    R10,??SaveBackupData_0+0x4  ;; 0x8006000
        MOV      R0,R10
        BL       RoadBackuptobuffer
        MOV      R7,R0
// 1949 
// 1950 #if 1
// 1951 		tptr->BackUp.FwdOutUpperLmt_3G[0]	= Sts->FwdOutUpperLmt_3G[0];
        LDRB     R0,[R8, #+38]
        STRB     R0,[R7, #+3]
// 1952 		tptr->BackUp.FwdOutUpperLmt_3G[1]	= Sts->FwdOutUpperLmt_3G[1];
        ADDS     R0,R7,#+3
        ADD      R1,R8,#+38
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+1]
// 1953 
// 1954 		tptr->BackUp.FwdOutLowerLmt_3G[0]	= Sts->FwdOutLowerLmt_3G[0];
        LDRB     R2,[R1, #+2]
        STRB     R2,[R0, #+2]
// 1955 		tptr->BackUp.FwdOutLowerLmt_3G[1]	= Sts->FwdOutLowerLmt_3G[1];
        LDRB     R2,[R1, #+3]
        STRB     R2,[R0, #+3]
// 1956 		
// 1957 		tptr->BackUp.FwdGainSet_3G			= Sts->FwdGainSet_3G;
        LDRB     R2,[R1, #+4]
        STRB     R2,[R0, #+4]
// 1958 		tptr->BackUp.FwdOutUpperLmt_2G[0]	= Sts->FwdOutUpperLmt_2G[0];
        LDRB     R2,[R1, #+8]
        STRB     R2,[R0, #+5]
// 1959 		tptr->BackUp.FwdOutUpperLmt_2G[1]	= Sts->FwdOutUpperLmt_2G[1];
        LDRB     R2,[R1, #+9]
        STRB     R2,[R0, #+6]
// 1960 		tptr->BackUp.FwdOutLowerLmt_2G[0]	= Sts->FwdOutLowerLmt_2G[0];
        LDRB     R2,[R1, #+10]
        STRB     R2,[R0, #+7]
// 1961 		tptr->BackUp.FwdOutLowerLmt_2G[1]	= Sts->FwdOutLowerLmt_2G[1];
        LDRB     R2,[R1, #+11]
        STRB     R2,[R0, #+8]
// 1962 		tptr->BackUp.FwdGainSet_2G			= Sts->FwdGainSet_2G;
        LDRB     R2,[R1, #+12]
        STRB     R2,[R0, #+9]
// 1963 		tptr->BackUp.FwdOutUpperLmt_LTE[0]	= Sts->FwdOutUpperLmt_LTE[0];
        LDRB     R2,[R1, #+16]
        STRB     R2,[R0, #+10]
// 1964 		tptr->BackUp.FwdOutUpperLmt_LTE[1]	= Sts->FwdOutUpperLmt_LTE[1];
        LDRB     R2,[R1, #+17]
        STRB     R2,[R0, #+11]
// 1965 
// 1966 		tptr->BackUp.FwdOutLowerLmt_LTE[0]	= Sts->FwdOutLowerLmt_LTE[0];
        LDRB     R2,[R1, #+18]
        STRB     R2,[R0, #+12]
// 1967 		tptr->BackUp.FwdOutLowerLmt_LTE[1]	= Sts->FwdOutLowerLmt_LTE[1];
        LDRB     R2,[R1, #+19]
        STRB     R2,[R0, #+13]
// 1968 
// 1969 		tptr->BackUp.FwdGainSet_LTE 		= Sts->FwdGainSet_LTE;
        LDRB     R2,[R1, #+20]
        STRB     R2,[R0, #+14]
// 1970 		tptr->BackUp.FwdOutUpperLmt_LTE_A[0]= Sts->FwdOutUpperLmt_LTE_A[0];
        LDRB     R2,[R1, #+24]
        STRB     R2,[R0, #+15]
// 1971 		tptr->BackUp.FwdOutUpperLmt_LTE_A[1]= Sts->FwdOutUpperLmt_LTE_A[1];
        LDRB     R2,[R1, #+25]
        STRB     R2,[R0, #+16]
// 1972 
// 1973 		tptr->BackUp.FwdOutLowerLmt_LTE_A[0]= Sts->FwdOutLowerLmt_LTE_A[0];
        LDRB     R2,[R1, #+26]
        STRB     R2,[R0, #+17]
// 1974 		tptr->BackUp.FwdOutLowerLmt_LTE_A[1]= Sts->FwdOutLowerLmt_LTE_A[1];
        LDRB     R2,[R1, #+27]
        STRB     R2,[R0, #+18]
// 1975 		
// 1976 		tptr->BackUp.FwdGainSet_LTE_A		= Sts->FwdGainSet_LTE_A;
        LDRB     R2,[R1, #+28]
        STRB     R2,[R0, #+19]
// 1977 		tptr->BackUp.Rvs0GainSet_3G 		= Sts->Rvs0GainSet_3G;
        LDRB     R1,[R1, #+30]
        STRB     R1,[R0, #+20]
// 1978 		tptr->BackUp.RvsGainBalance_3G		= Sts->RvsGainBalance_3G;
        LDRB     R1,[R8, #+70]
        STRB     R1,[R0, #+21]
// 1979 		tptr->BackUp.Rvs0GainSet_2G 		= Sts->Rvs0GainSet_2G;
        ADD      R4,R8,#+70
        LDRB     R1,[R4, #+1]
        STRB     R1,[R0, #+22]
// 1980 		tptr->BackUp.RvsGainBalance_2G		= Sts->RvsGainBalance_2G;
        LDRB     R1,[R4, #+3]
        STRB     R1,[R0, #+23]
// 1981 		tptr->BackUp.Rvs0GainSet_LTE		= Sts->Rvs0GainSet_LTE;
        LDRB     R1,[R4, #+4]
        STRB     R1,[R0, #+24]
// 1982 		tptr->BackUp.RvsGainBalance_LTE 	= Sts->RvsGainBalance_LTE;
        LDRB     R1,[R4, #+6]
        STRB     R1,[R0, #+25]
// 1983 		tptr->BackUp.Rvs0GainSet_LTE_A		= Sts->Rvs0GainSet_LTE_A;
        LDRB     R1,[R4, #+7]
        STRB     R1,[R0, #+26]
// 1984 		tptr->BackUp.RvsGainBalance_LTE_A	= Sts->RvsGainBalance_LTE_A;
        LDRB     R1,[R4, #+9]
        STRB     R1,[R0, #+27]
// 1985 		tptr->BackUp.AmpOffCase_3G			= Sts->AmpOffCase_3G;
        LDRB     R1,[R4, #+10]
        STRB     R1,[R0, #+28]
// 1986 		tptr->BackUp.AmpOffCase_Common		= Sts->AmpOffCase_Common;
        LDRB     R1,[R4, #+11]
        STRB     R1,[R0, #+29]
// 1987 		tptr->BackUp.AmpOffCase_LTE_A		= Sts->AmpOffCase_LTE_A;
        LDRB     R1,[R4, #+12]
        STRB     R1,[R0, #+30]
// 1988 		tptr->BackUp.BandSelect_15M 		= Sts->BandSelect_15M;
        LDRB     R1,[R4, #+16]
        STRB     R1,[R0, #+31]
// 1989 		tptr->BackUp.RepeatResetPriod 		= Sts->RepeatResetPriod;
        LDRB     R0,[R4, #+17]
        STRB     R0,[R7, #+35]
// 1990 /////////////////////////////////////////////////////////////
// 1991 
// 1992 		tptr->BackUp.AGCOnOff_3G			= Sts->AGCOnOff_3G;
        ADD      R0,R7,#+35
        LDRB     R1,[R4, #+23]
        STRB     R1,[R0, #+4]
// 1993 		tptr->BackUp.AGCOnOff_2G			= Sts->AGCOnOff_2G;
        LDRB     R1,[R4, #+24]
        STRB     R1,[R0, #+5]
// 1994 		tptr->BackUp.AGCOnOff_LTE			= Sts->AGCOnOff_LTE;
        LDRB     R1,[R4, #+27]
        STRB     R1,[R0, #+6]
// 1995 		tptr->BackUp.AGCOnOff_LTE_A 		= Sts->AGCOnOff_LTE_A;
        LDRB     R1,[R4, #+28]
        STRB     R1,[R0, #+7]
// 1996 		tptr->BackUp.AGC1OnOff_LTE			= Sts->AGC1OnOff_LTE;
        LDRB     R1,[R4, #+31]
        STRB     R1,[R0, #+8]
// 1997 		tptr->BackUp.AGC1OnOff_LTE_A		= Sts->AGC1OnOff_LTE_A;
        LDRB     R1,[R8, #+102]
        STRB     R1,[R0, #+9]
// 1998 
// 1999 		tptr->BackUp.AGCMode_3G 			= Sts->AGCMode_3G;
        LDRB     R1,[R4, #+25]
        STRB     R1,[R0, #+10]
// 2000 		tptr->BackUp.AGCMode_2G 			= Sts->AGCMode_2G;
        LDRB     R1,[R4, #+26]
        STRB     R1,[R0, #+11]
// 2001 		tptr->BackUp.AGCMode_LTE			= Sts->AGCMode_LTE;
        LDRB     R1,[R4, #+29]
        STRB     R1,[R0, #+12]
// 2002 		tptr->BackUp.AGCMode_LTE_A			= Sts->AGCMode_LTE_A;
        LDRB     R1,[R4, #+30]
        STRB     R1,[R0, #+13]
// 2003 
// 2004 		
// 2005 /////////////////////////////////////////////////////
// 2006 		
// 2007 		tptr->BackUp.AutoReportPriod		= Sts->AutoReportPriod;
        LDRB     R1,[R4, #+18]
        STRB     R1,[R0, #+1]
// 2008 		tptr->BackUp.AutoReportTime_H		= Sts->AutoReportTime_H;
        LDRB     R1,[R4, #+19]
        STRB     R1,[R0, #+2]
// 2009 		tptr->BackUp.AutoReportTime_M		= Sts->AutoReportTime_M;
        LDRB     R1,[R4, #+20]
        STRB     R1,[R0, #+3]
// 2010 		tptr->BackUp.TPTL_OnOff 			= Sts->TPTL_OnOff;
        ADD      R1,R8,#+102
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+14]
// 2011 		tptr->BackUp.TempOffset 			= Sts->TempOffset;
        LDRB     R2,[R1, #+2]
        STRB     R2,[R0, #+15]
// 2012 		tptr->BackUp.AlarmMask				= Sts->AlarmMask;
        LDRB     R1,[R1, #+4]
        STRB     R1,[R0, #+16]
// 2013 		tptr->BackUp.ModemOnOff 			= Sts->ModemOnOff;
        LDRB     R1,[R8, #+143]
        STRB     R1,[R0, #+17]
// 2014 		tptr->BackUp.VccDet_Lmt.Data		= Sts->VccDet_Lmt.Data;
        LDRH     R1,[R8, #+154]
        STRH     R1,[R0, #+18]
// 2015 		tptr->BackUp.FwdInPwrOffset_2G		= Sts->FwdInPwrOffset_2G;
        ADD      R1,R8,#+154
        LDRB     R2,[R1, #+2]
        STRB     R2,[R0, #+20]
// 2016 		tptr->BackUp.FwdInPwrOffset_3G		= Sts->FwdInPwrOffset_3G;
        LDRB     R2,[R1, #+3]
        STRB     R2,[R0, #+21]
// 2017 		tptr->BackUp.Rvs0OutPwrOffset_2G	= Sts->Rvs0OutPwrOffset_2G;
        LDRB     R2,[R1, #+4]
        STRB     R2,[R0, #+22]
// 2018 		tptr->BackUp.Rvs0OutPwrOffset_3G	= Sts->Rvs0OutPwrOffset_3G;
        LDRB     R2,[R1, #+5]
        STRB     R2,[R0, #+23]
// 2019 		tptr->BackUp.FwdOutPwrOffset_2G 	= Sts->FwdOutPwrOffset_2G;
        LDRB     R2,[R1, #+6]
        STRB     R2,[R0, #+24]
// 2020 		tptr->BackUp.FwdOutPwrOffset_3G 	= Sts->FwdOutPwrOffset_3G;
        LDRB     R1,[R1, #+7]
        STRB     R1,[R0, #+25]
// 2021 		tptr->BackUp.ResetPeriodCountSet[0] = Sts->ResetPeriodCountSet[0];
        LDRB     R1,[R8, #+188]
        STRB     R1,[R0, #+26]
// 2022 		tptr->BackUp.ResetPeriodCountSet[1] = Sts->ResetPeriodCountSet[1];
        ADD      R1,R8,#+188
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+27]
// 2023 		tptr->BackUp.ResetPeriodCountSet[2] = Sts->ResetPeriodCountSet[2];
        LDRB     R2,[R1, #+2]
        STRB     R2,[R0, #+28]
// 2024 		tptr->BackUp.FwdInPwrOffset_LTE 	= Sts->FwdInPwrOffset_LTE;
        LDRB     R2,[R1, #+3]
        STRB     R2,[R0, #+29]
// 2025 		tptr->BackUp.FwdOutPwrOffset_LTE	= Sts->FwdOutPwrOffset_LTE;
        LDRB     R2,[R1, #+4]
        STRB     R2,[R0, #+30]
// 2026 		tptr->BackUp.RvsOutPwrOffset_LTE	= Sts->RvsOutPwrOffset_LTE;
        LDRB     R2,[R1, #+5]
        STRB     R2,[R0, #+31]
// 2027 		tptr->BackUp.RvsOutUpperLmt_3G[0]	= Sts->RvsOutUpperLmt_3G[0];
        LDRB     R0,[R1, #+15]
        STRB     R0,[R7, #+67]
// 2028 		tptr->BackUp.RvsOutUpperLmt_3G[1]	= Sts->RvsOutUpperLmt_3G[1];
        ADD      R0,R7,#+67
        LDRB     R2,[R1, #+16]
        STRB     R2,[R0, #+1]
// 2029 		tptr->BackUp.RvsOutUpperLmt_2G[0]	= Sts->RvsOutUpperLmt_2G[0];
        LDRB     R2,[R1, #+17]
        STRB     R2,[R0, #+2]
// 2030 		tptr->BackUp.RvsOutUpperLmt_2G[1]	= Sts->RvsOutUpperLmt_2G[1];
        LDRB     R2,[R1, #+18]
        STRB     R2,[R0, #+3]
// 2031 		tptr->BackUp.FwdGainOffset_3G		= Sts->FwdGainOffset_3G;
        LDRB     R2,[R1, #+19]
        STRB     R2,[R0, #+4]
// 2032 		tptr->BackUp.RvsGainOffset_3G		= Sts->RvsGainOffset_3G;
        LDRB     R2,[R1, #+20]
        STRB     R2,[R0, #+5]
// 2033 		tptr->BackUp.FwdGainOffset_2G		= Sts->FwdGainOffset_2G;
        LDRB     R2,[R1, #+21]
        STRB     R2,[R0, #+6]
// 2034 		tptr->BackUp.RvsGainOffset_2G		= Sts->RvsGainOffset_2G;
        LDRB     R2,[R1, #+22]
        STRB     R2,[R0, #+7]
// 2035 		tptr->BackUp.FwdOutHighLmt_3G[0]	= Sts->FwdOutHighLmt_3G[0];
        LDRB     R2,[R1, #+27]
        STRB     R2,[R0, #+8]
// 2036 		tptr->BackUp.FwdOutHighLmt_3G[1]	= Sts->FwdOutHighLmt_3G[1];
        LDRB     R2,[R1, #+28]
        STRB     R2,[R0, #+9]
// 2037 		tptr->BackUp.FwdOutHighLmt_2G[0]	= Sts->FwdOutHighLmt_2G[0];
        LDRB     R2,[R1, #+29]
        STRB     R2,[R0, #+10]
// 2038 		tptr->BackUp.FwdOutHighLmt_2G[1]	= Sts->FwdOutHighLmt_2G[1];
        LDRB     R1,[R1, #+30]
        STRB     R1,[R0, #+11]
// 2039 
// 2040 //		for(i = 0; i < sizeof(__DET); i++)
// 2041 		{
// 2042 			memcpy((INT8U*)&tptr->BackUp.DetOffset, (INT8U*)&Sts->DetOffset, sizeof(__DET));
        MOVS     R2,#+22
        ADDW     R1,R8,#+319
        ADD      R0,R7,#+79
        BL       __aeabi_memcpy
// 2043 		}
// 2044 		
// 2045 
// 2046 		tptr->BackUp.FwdInPwrOffset_LTE_A	= Sts->FwdInPwrOffset_LTE_A;
        LDRB     R0,[R8, #+427]
        STRB     R0,[R7, #+101]
// 2047 		tptr->BackUp.FwdOutPwrOffset_LTE_A	= Sts->FwdOutPwrOffset_LTE_A;
        ADD      R0,R7,#+101
        ADDW     R1,R8,#+427
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+1]
// 2048 		tptr->BackUp.RvsOutPwrOffset_LTE_A	= Sts->RvsOutPwrOffset_LTE_A;
        LDRB     R1,[R1, #+2]
        STRB     R1,[R0, #+2]
// 2049 		tptr->BackUp.FwdGainOffset_LTE		= Sts->FwdGainOffset_LTE;
        LDRB     R1,[R8, #+460]
        STRB     R1,[R0, #+3]
// 2050 		tptr->BackUp.RvsGainOffset_LTE		= Sts->RvsGainOffset_LTE;
        ADD      R1,R8,#+460
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+4]
// 2051 		tptr->BackUp.FwdGainOffset_LTE_A	= Sts->FwdGainOffset_LTE_A;
        LDRB     R2,[R1, #+2]
        STRB     R2,[R0, #+5]
// 2052 		tptr->BackUp.RvsGainOffset_LTE_A	= Sts->RvsGainOffset_LTE_A;
        LDRB     R2,[R1, #+3]
        STRB     R2,[R0, #+6]
// 2053 #if 0
// 2054 		tptr->BackUp.FwdAgcAttn_2G			= Sts->FwdAgcAttn_2G;
// 2055 		tptr->BackUp.FwdAgcAttn_LTE 		= Sts->FwdAgcAttn_LTE;
// 2056 		tptr->BackUp.FwdAgcAttn_LTE_A		= Sts->FwdAgcAttn_LTE_A;
// 2057 		tptr->BackUp.FwdAgcAttn_3G			= Sts->FwdAgcAttn_3G;
// 2058 		tptr->BackUp.RvsAlcAttn_2G			= Sts->RvsAlcAttn_2G;
// 2059 		tptr->BackUp.RvsAlcAttn_LTE 		= Sts->RvsAlcAttn_LTE;
// 2060 		tptr->BackUp.RvsAlcAttn_LTE_A		= Sts->RvsAlcAttn_LTE_A;
// 2061 		tptr->BackUp.RvsAlcAttn_3G			= Sts->RvsAlcAttn_3G;
// 2062 #endif
// 2063 		tptr->BackUp.RvsAlcOnOff_2G 		= Sts->RvsAlcOnOff_2G;
        LDRB     R2,[R1, #+12]
        STRB     R2,[R0, #+7]
// 2064 		tptr->BackUp.RvsAlcOnOff_LTE		= Sts->RvsAlcOnOff_LTE;
        LDRB     R2,[R1, #+13]
        STRB     R2,[R0, #+8]
// 2065 		tptr->BackUp.RvsAlcOnOff_LTE_A		= Sts->RvsAlcOnOff_LTE_A;
        LDRB     R2,[R1, #+14]
        STRB     R2,[R0, #+9]
// 2066 		tptr->BackUp.RvsAlcOnOff_3G 		= Sts->RvsAlcOnOff_3G;
        LDRB     R2,[R1, #+15]
        STRB     R2,[R0, #+10]
// 2067 		tptr->BackUp.RvsOutUpperLmt_LTE[0]	= Sts->RvsOutUpperLmt_LTE[0];
        LDRB     R2,[R1, #+37]
        STRB     R2,[R0, #+11]
// 2068 		tptr->BackUp.RvsOutUpperLmt_LTE[1]	= Sts->RvsOutUpperLmt_LTE[1];
        LDRB     R2,[R1, #+38]
        STRB     R2,[R0, #+12]
// 2069 		tptr->BackUp.RvsOutUpperLmt_LTE_A[0]= Sts->RvsOutUpperLmt_LTE_A[0];
        LDRB     R2,[R1, #+39]
        STRB     R2,[R0, #+13]
// 2070 		tptr->BackUp.RvsOutUpperLmt_LTE_A[1]= Sts->RvsOutUpperLmt_LTE_A[1];
        LDRB     R2,[R1, #+40]
        STRB     R2,[R0, #+14]
// 2071 		tptr->BackUp.FwdOutHighLmt_LTE[0]	= Sts->FwdOutHighLmt_LTE[0];
        LDRB     R2,[R1, #+45]
        STRB     R2,[R0, #+15]
// 2072 		tptr->BackUp.FwdOutHighLmt_LTE[1]	= Sts->FwdOutHighLmt_LTE[1];
        LDRB     R2,[R1, #+46]
        STRB     R2,[R0, #+16]
// 2073 		tptr->BackUp.FwdOutHighLmt_LTE_A[0] = Sts->FwdOutHighLmt_LTE_A[0];
        LDRB     R2,[R1, #+47]
        STRB     R2,[R0, #+17]
// 2074 		tptr->BackUp.FwdOutHighLmt_LTE_A[1] = Sts->FwdOutHighLmt_LTE_A[1];
        LDRB     R1,[R1, #+48]
        STRB     R1,[R0, #+18]
// 2075 		tptr->BackUp.OverInAlarmLmt_2G		= Sts->OverInAlarmLmt_2G;
        LDRB     R1,[R8, #+509]
        STRB     R1,[R0, #+19]
// 2076 		tptr->BackUp.OverInAlarmLmt_LTE 	= Sts->OverInAlarmLmt_LTE;
        ADDW     R1,R8,#+509
        LDRB     R2,[R1, #+1]
        STRB     R2,[R0, #+20]
// 2077 		tptr->BackUp.OverInAlarmLmt_LTE_A	= Sts->OverInAlarmLmt_LTE_A;
        LDRB     R2,[R1, #+2]
        STRB     R2,[R0, #+21]
// 2078 		tptr->BackUp.OverInAlarmLmt_3G		= Sts->OverInAlarmLmt_3G;
        LDRB     R2,[R1, #+3]
        STRB     R2,[R0, #+22]
// 2079 		tptr->BackUp.OtherOverInAlarmLmt_2G = Sts->OtherOverInAlarmLmt_2G;
        LDRB     R2,[R1, #+4]
        STRB     R2,[R0, #+23]
// 2080 		tptr->BackUp.OtherOverInAlarmLmt_LTE = Sts->OtherOverInAlarmLmt_LTE;
        LDRB     R2,[R1, #+5]
        STRB     R2,[R0, #+24]
// 2081 		tptr->BackUp.OtherOverInAlarmLmt_LTE_A = Sts->OtherOverInAlarmLmt_LTE_A;
        LDRB     R2,[R1, #+6]
        STRB     R2,[R0, #+25]
// 2082 		tptr->BackUp.OtherOverInAlarmLmt_3G = Sts->OtherOverInAlarmLmt_3G;
        LDRB     R2,[R1, #+7]
        STRB     R2,[R0, #+26]
// 2083 		tptr->BackUp.RvsALCLvl_2G			= Sts->RvsALCLvl_2G;
        LDRB     R2,[R1, #+8]
        STRB     R2,[R0, #+27]
// 2084 		tptr->BackUp.RvsALCLvl_LTE			= Sts->RvsALCLvl_LTE;
        LDRB     R2,[R1, #+9]
        STRB     R2,[R0, #+28]
// 2085 		tptr->BackUp.RvsALCLvl_LTE_A		= Sts->RvsALCLvl_LTE_A;
        LDRB     R2,[R1, #+10]
        STRB     R2,[R0, #+29]
// 2086 		tptr->BackUp.RvsALCLvl_3G			= Sts->RvsALCLvl_3G;
        LDRB     R1,[R1, #+11]
        STRB     R1,[R0, #+30]
// 2087 
// 2088 ////////////////////////////////////////////////////
// 2089 
// 2090 		tptr->BackUp.RxMaxVal[0]			= Sts->RxMaxVal[0];
        LDRB     R1,[R8, #+572]
        STRB     R1,[R0, #+31]
// 2091 		tptr->BackUp.RxMaxVal[1]			= Sts->RxMaxVal[1];
        ADD      R5,R8,#+572
        LDRB     R0,[R5, #+1]
        STRB     R0,[R7, #+133]
// 2092 		tptr->BackUp.RxMinVal[0]			= Sts->RxMinVal[0];
        ADD      R6,R7,#+133
        LDRB     R0,[R5, #+2]
        STRB     R0,[R6, #+1]
// 2093 		tptr->BackUp.RxMinVal[1]			= Sts->RxMinVal[1];
        LDRB     R0,[R5, #+3]
        STRB     R0,[R6, #+2]
// 2094 		tptr->BackUp.TxMaxVal[0]			= Sts->TxMaxVal[0];
        LDRB     R0,[R5, #+4]
        STRB     R0,[R6, #+3]
// 2095 		tptr->BackUp.TxMaxVal[1]			= Sts->TxMaxVal[1];
        LDRB     R0,[R5, #+5]
        STRB     R0,[R6, #+4]
// 2096 		tptr->BackUp.TxMinVal[0]			= Sts->TxMinVal[0];
        LDRB     R0,[R5, #+6]
        STRB     R0,[R6, #+5]
// 2097 		tptr->BackUp.TxMinVal[1]			= Sts->TxMinVal[1];
        LDRB     R0,[R5, #+7]
        STRB     R0,[R6, #+6]
// 2098 #if 0
// 2099 		tptr->BackUp.AdjMaxVal[0]			= Sts->AdjMaxVal[0];
// 2100 		tptr->BackUp.AdjMaxVal[1]			= Sts->AdjMaxVal[1];
// 2101 		tptr->BackUp.AdjMinVal[0]			= Sts->AdjMinVal[0];
// 2102 		tptr->BackUp.AdjMinVal[1]			= Sts->AdjMinVal[1];
// 2103 #endif        
// 2104 		tptr->BackUp.EcIo					= Sts->EcIo;
        LDRB     R0,[R5, #+12]
        STRB     R0,[R6, #+7]
// 2105 		tptr->BackUp.AR_Mode[0] 			= Sts->AR_Mode[0];
        LDRB     R0,[R5, #+13]
        STRB     R0,[R6, #+8]
// 2106 		tptr->BackUp.AR_Mode[1] 			= Sts->AR_Mode[1];
        LDRB     R0,[R5, #+14]
        STRB     R0,[R6, #+9]
// 2107 		tptr->BackUp.Radio_ReportTime[0]	= Sts->Radio_ReportTime[0];
        LDRB     R0,[R5, #+15]
        STRB     R0,[R6, #+10]
// 2108 		tptr->BackUp.Radio_ReportTime[1]	= Sts->Radio_ReportTime[1];
        LDRB     R0,[R5, #+16]
        STRB     R0,[R6, #+11]
// 2109 		tptr->BackUp.Radio_ReportPeriod[0]	= Sts->Radio_ReportPeriod[0];
        LDRB     R0,[R5, #+17]
        STRB     R0,[R6, #+12]
// 2110 		tptr->BackUp.Radio_ReportPeriod[1]	= Sts->Radio_ReportPeriod[1];
        LDRB     R0,[R5, #+18]
        STRB     R0,[R6, #+13]
// 2111 //		for(i = 0; i < sizeof(Sts->TestStn); i++)
// 2112 		{
// 2113 			memcpy((INT8U*)&tptr->BackUp.TestStn, (INT8U*)&Sts->TestStn, sizeof(Sts->TestStn));
        MOVS     R2,#+11
        ADDW     R1,R8,#+591
        ADD      R0,R7,#+147
        BL       __aeabi_memcpy
// 2114 		}
// 2115 
// 2116 #ifdef _MIMO_Type 
// 2117 		tptr->BackUp.Fwd1OutUpperLmt_LTE[0] = Sts->Fwd1OutUpperLmt_LTE[0];
        LDRB     R0,[R5, #+85]
        STRB     R0,[R6, #+25]
// 2118 		tptr->BackUp.Fwd1OutUpperLmt_LTE[1] = Sts->Fwd1OutUpperLmt_LTE[1];
        LDRB     R0,[R5, #+86]
        STRB     R0,[R6, #+26]
// 2119 
// 2120 		tptr->BackUp.Fwd1OutLowerLmt_LTE[0] = Sts->Fwd1OutLowerLmt_LTE[0];
        LDRB     R0,[R5, #+87]
        STRB     R0,[R6, #+27]
// 2121 		tptr->BackUp.Fwd1OutLowerLmt_LTE[1] = Sts->Fwd1OutLowerLmt_LTE[1];
        LDRB     R0,[R5, #+88]
        STRB     R0,[R6, #+28]
// 2122 
// 2123 		tptr->BackUp.Fwd1GainSet_LTE			= Sts->Fwd1GainSet_LTE;
        LDRB     R0,[R8, #+661]
        STRB     R0,[R6, #+29]
// 2124 		tptr->BackUp.Fwd1OutUpperLmt_LTE_A[0]	= Sts->Fwd1OutUpperLmt_LTE_A[0];
        ADDW     R5,R8,#+661
        LDRB     R0,[R5, #+4]
        STRB     R0,[R6, #+30]
// 2125 		tptr->BackUp.Fwd1OutUpperLmt_LTE_A[1]	= Sts->Fwd1OutUpperLmt_LTE_A[1];
        LDRB     R0,[R5, #+5]
        STRB     R0,[R6, #+31]
// 2126 
// 2127 		tptr->BackUp.Fwd1OutLowerLmt_LTE_A[0]	= Sts->Fwd1OutLowerLmt_LTE_A[0];
        LDRB     R0,[R5, #+6]
        STRB     R0,[R7, #+165]
// 2128 		tptr->BackUp.Fwd1OutLowerLmt_LTE_A[1]	= Sts->Fwd1OutLowerLmt_LTE_A[1];
        ADD      R6,R7,#+165
        LDRB     R0,[R5, #+7]
        STRB     R0,[R6, #+1]
// 2129 
// 2130 		tptr->BackUp.Fwd1GainSet_LTE_A		= Sts->Fwd1GainSet_LTE_A;
        LDRB     R0,[R5, #+8]
        STRB     R0,[R6, #+2]
// 2131 		tptr->BackUp.Rvs1GainSet_LTE		= Sts->Rvs1GainSet_LTE;
        LDRB     R0,[R5, #+10]
        STRB     R0,[R6, #+3]
// 2132 		tptr->BackUp.Rvs1GainBalance_LTE	= Sts->Rvs1GainBalance_LTE;
        LDRB     R0,[R5, #+12]
        STRB     R0,[R6, #+4]
// 2133 		tptr->BackUp.Rvs1GainSet_LTE_A		= Sts->Rvs1GainSet_LTE_A;
        LDRB     R0,[R5, #+13]
        STRB     R0,[R6, #+5]
// 2134 		tptr->BackUp.Rvs1GainBalance_LTE_A	= Sts->Rvs1GainBalance_LTE_A;
        LDRB     R0,[R5, #+15]
        STRB     R0,[R6, #+6]
// 2135 		tptr->BackUp.Amp1OffCase_LTE		= Sts->Amp1OffCase_LTE;
        LDRB     R0,[R5, #+18]
        STRB     R0,[R6, #+7]
// 2136 		tptr->BackUp.Amp1OffCase_LTE_A		= Sts->Amp1OffCase_LTE_A;
        LDRB     R0,[R5, #+19]
        STRB     R0,[R6, #+8]
// 2137 
// 2138 //		for(i = 0; i < sizeof(__DET); i++)
// 2139 		{
// 2140 			memcpy((INT8U*)&tptr->BackUp.Det1Offset, (INT8U*)&Sts->Det1Offset, sizeof(__DET1));
        MOVS     R2,#+8
        ADDW     R1,R8,#+717
        ADD      R0,R7,#+174
        BL       __aeabi_memcpy
// 2141 		}
// 2142 
// 2143 
// 2144 		tptr->BackUp.Fwd1InPwrOffset_LTE_A	= Sts->Fwd1InPwrOffset_LTE_A;
        LDRB     R0,[R5, #+101]
        STRB     R0,[R6, #+20]
// 2145 		tptr->BackUp.Fwd1OutPwrOffset_LTE_A = Sts->Fwd1OutPwrOffset_LTE_A;
        LDRB     R0,[R5, #+102]
        STRB     R0,[R6, #+21]
// 2146 		tptr->BackUp.Rvs1OutPwrOffset_LTE_A = Sts->Rvs1OutPwrOffset_LTE_A;
        LDRB     R0,[R5, #+103]
        STRB     R0,[R6, #+22]
// 2147 		tptr->BackUp.Fwd1GainOffset_LTE 	= Sts->Fwd1GainOffset_LTE;
        LDRB     R0,[R8, #+789]
        STRB     R0,[R6, #+23]
// 2148 		tptr->BackUp.Rvs1GainOffset_LTE 	= Sts->Rvs1GainOffset_LTE;
        ADDW     R0,R8,#+789
        LDRB     R1,[R0, #+1]
        STRB     R1,[R6, #+24]
// 2149 		tptr->BackUp.Fwd1GainOffset_LTE_A	= Sts->Fwd1GainOffset_LTE_A;
        LDRB     R1,[R0, #+2]
        STRB     R1,[R6, #+25]
// 2150 		tptr->BackUp.Rvs1GainOffset_LTE_A	= Sts->Rvs1GainOffset_LTE_A;
        LDRB     R1,[R0, #+3]
        STRB     R1,[R6, #+26]
// 2151 #if 0
// 2152 		tptr->BackUp.Fwd1AgcAttn_LTE		= Sts->Fwd1AgcAttn_LTE;
// 2153 		tptr->BackUp.Fwd1AgcAttn_LTE_A		= Sts->Fwd1AgcAttn_LTE_A;
// 2154 		tptr->BackUp.Rvs1AlcAttn_LTE		= Sts->Rvs1AlcAttn_LTE;
// 2155 		tptr->BackUp.Rvs1AlcAttn_LTE_A		= Sts->Rvs1AlcAttn_LTE_A;
// 2156 		tptr->BackUp.Rvs1AlcOnOff_LTE		= Sts->Rvs1AlcOnOff_LTE;
// 2157 		tptr->BackUp.Rvs1AlcOnOff_LTE_A 	= Sts->Rvs1AlcOnOff_LTE_A;
// 2158 #endif
// 2159 		tptr->BackUp.Rvs1OutUpperLmt_LTE[0] = Sts->Rvs1OutUpperLmt_LTE[0];
        LDRB     R1,[R0, #+22]
        STRB     R1,[R6, #+27]
// 2160 		tptr->BackUp.Rvs1OutUpperLmt_LTE[1] = Sts->Rvs1OutUpperLmt_LTE[1];
        LDRB     R1,[R0, #+23]
        STRB     R1,[R6, #+28]
// 2161 		tptr->BackUp.Rvs1OutUpperLmt_LTE_A[0]= Sts->Rvs1OutUpperLmt_LTE_A[0];
        LDRB     R1,[R0, #+24]
        STRB     R1,[R6, #+29]
// 2162 		tptr->BackUp.Rvs1OutUpperLmt_LTE_A[1]= Sts->Rvs1OutUpperLmt_LTE_A[1];
        LDRB     R1,[R0, #+25]
        STRB     R1,[R6, #+30]
// 2163 		tptr->BackUp.Fwd1OutHighLmt_LTE[0]	= Sts->Fwd1OutHighLmt_LTE[0];
        LDRB     R1,[R0, #+30]
        STRB     R1,[R6, #+31]
// 2164 		tptr->BackUp.Fwd1OutHighLmt_LTE[1]	= Sts->Fwd1OutHighLmt_LTE[1];
        LDRB     R1,[R0, #+31]
        STRB     R1,[R7, #+197]
// 2165 		tptr->BackUp.Fwd1OutHighLmt_LTE_A[0] = Sts->Fwd1OutHighLmt_LTE_A[0];
        ADD      R6,R7,#+197
        LDRB     R1,[R0, #+32]
        STRB     R1,[R6, #+1]
// 2166 		tptr->BackUp.Fwd1OutHighLmt_LTE_A[1] = Sts->Fwd1OutHighLmt_LTE_A[1];
        LDRB     R0,[R0, #+33]
        STRB     R0,[R6, #+2]
// 2167 		tptr->BackUp.Rvs1ALCLvl_LTE 		= Sts->Rvs1ALCLvl_LTE;
        LDRB     R0,[R8, #+823]
        STRB     R0,[R6, #+3]
// 2168 		tptr->BackUp.Rvs1ALCLvl_LTE_A		= Sts->Rvs1ALCLvl_LTE_A;
        ADDW     R0,R8,#+823
        LDRB     R0,[R0, #+1]
        STRB     R0,[R6, #+4]
// 2169 
// 2170 #endif
// 2171 
// 2172 
// 2173 		{
// 2174 			memcpy((INT8U*)&tptr->BackUp.Det2Offset, (INT8U*)&Sts->Det2Offset, sizeof(__DET2));
        MOVS     R2,#+16
        ADD      R1,R8,#+556
        ADD      R0,R7,#+207
        BL       __aeabi_memcpy
// 2175 		}
// 2176 
// 2177 
// 2178 
// 2179 #if 0
// 2180 		WriteAT24C64(FwdAttn1_2G,		Sts->FwdAttn1_2G);
// 2181 		WriteAT24C64(FwdAttn2_2G,		Sts->FwdAttn2_2G);
// 2182 		WriteAT24C64(RvsAttn1_2G,		Sts->RvsAttn1_2G);
// 2183 		WriteAT24C64(RvsAttn2_2G,		Sts->RvsAttn2_2G);
// 2184 		WriteAT24C64(RvsAttn3_2G,		Sts->RvsAttn3_2G);
// 2185 
// 2186 	tptr->BackUp.FwdAttn1_2G		= Sts->FwdAttn1_2G;
// 2187 	tptr->BackUp.FwdAttn2_2G 		= Sts->FwdAttn2_2G;
// 2188 	tptr->BackUp.RvsAttn1_2G 		= Sts->RvsAttn1_2G;
// 2189 	tptr->BackUp.RvsAttn2_2G		= Sts->RvsAttn2_2G;
// 2190 	tptr->BackUp.RvsAttn3_2G 		= Sts->RvsAttn3_2G;
// 2191 
// 2192 	
// 2193 	tptr->BackUp.FwdAttn1_3G 		= Sts->FwdAttn1_3G;
// 2194 	tptr->BackUp.FwdAttn2_3G 		= Sts->FwdAttn2_3G;
// 2195 	tptr->BackUp.RvsAttn1_3G		= Sts->RvsAttn1_3G;
// 2196 	tptr->BackUp.RvsAttn2_3G 		= Sts->RvsAttn2_3G;
// 2197 	tptr->BackUp.RvsAttn3_3G 		= Sts->RvsAttn3_3G;
// 2198 	tptr->BackUp.RvsAttn4_3G		= Sts->RvsAttn4_3G;
// 2199 	tptr->BackUp.FwdAttn1_Common 	= Sts->FwdAttn1_Common;
// 2200 	tptr->BackUp.RvsAttn1_Common 	= Sts->RvsAttn1_Common;
// 2201 	tptr->BackUp.FwdAttn1_LTE		= Sts->FwdAttn1_LTE;	
// 2202 	tptr->BackUp.FwdAttn2_LTE 		= Sts->FwdAttn2_LTE;	
// 2203 	tptr->BackUp.FwdAttn1_LTE_A 	= Sts->FwdAttn1_LTE_A;
// 2204 	tptr->BackUp.FwdAttn2_LTE_A 	= Sts->FwdAttn2_LTE_A;
// 2205 	tptr->BackUp.RvsAttn1_LTE 		= Sts->RvsAttn1_LTE;	
// 2206 	tptr->BackUp.RvsAttn2_LTE		= Sts->RvsAttn2_LTE;	
// 2207 	tptr->BackUp.RvsAttn3_LTE 		= Sts->RvsAttn3_LTE;	
// 2208 	tptr->BackUp.RvsAttn1_LTE_A 	= Sts->RvsAttn1_LTE_A;
// 2209 	tptr->BackUp.RvsAttn2_LTE_A 	= Sts->RvsAttn2_LTE_A;
// 2210 	tptr->BackUp.RvsAttn3_LTE_A		= Sts->RvsAttn3_LTE_A;
// 2211 	tptr->BackUp.RvsAttn4_LTE_A 	= Sts->RvsAttn4_LTE_A;
// 2212 
// 2213 #endif
// 2214 
// 2215 	tptr->BackUp.AmpOnOff_3G 		= Sts->AmpOnOff_3G;
        LDRB     R0,[R4, #+13]
        STRB     R0,[R6, #+5]
// 2216 	tptr->BackUp.AmpOnOff_Common 	= Sts->AmpOnOff_Common;
        LDRB     R0,[R4, #+14]
        STRB     R0,[R6, #+6]
// 2217 	tptr->BackUp.AmpOnOff_LTE_A 	= Sts->AmpOnOff_LTE_A;
        LDRB     R0,[R4, #+15]
        STRB     R0,[R6, #+7]
// 2218 	tptr->BackUp.Amp1OnOff_LTE 		= Sts->Amp1OnOff_LTE;
        LDRB     R0,[R5, #+17]
        STRB     R0,[R6, #+8]
// 2219 	tptr->BackUp.Amp1OnOff_LTE_A 	= Sts->Amp1OnOff_LTE_A;
        LDRB     R0,[R5, #+16]
        STRB     R0,[R6, #+9]
// 2220 
// 2221 #endif
// 2222 	}
// 2223 	
// 2224 	WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVW     R1,#+2038
        MOV      R0,R10
        BL       WriteBuffertoBackup
// 2225 
// 2226 	OS_EXIT_CRITICAL();
        MOV      R0,R9
        POP      {R4-R10,LR}
        B.W      OS_CPU_SR_Restore
        Nop      
        DATA
??SaveBackupData_0:
        DC32     tDnrSts
        DC32     0x8006000
// 2227 }
// 2228 
// 2229 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2230 void TRIO_Initialize(void)
// 2231 {
TRIO_Initialize:
        PUSH     {R3-R5,LR}
// 2232 	__Dnr_Sts *Sts = tDnrSts;
        LDR.N    R0,??TRIO_Initialize_0  ;; tDnrSts
        LDR      R4,[R0, #+0]
// 2233 
// 2234 	Sts->Manufacture		= 0x0B;
        MOVS     R0,#+11
        STRB     R0,[R4, #+27]
// 2235 	Sts->Supplier			= 0x0B;
        STRB     R0,[R4, #+28]
// 2236 
// 2237 	Sts->SWVer 				= SystemVer;
        MOVS     R0,#+1
        STRB     R0,[R4, #+31]
// 2238 	Sts->RCUAddVer 			= PROGRAMVER;	
        ADD      R5,R4,#+93
        STRB     R0,[R5, #+12]
// 2239 
// 2240 
// 2241 	Sts->RepeaterType[0]	= hibyte(TRIO_M_TYPE);
        MOVS     R0,#+2
        STRB     R0,[R4, #+29]
// 2242 	Sts->RepeaterType[1]	= lobyte(TRIO_M_TYPE);
        MOVS     R0,#+90
        STRB     R0,[R4, #+30]
// 2243 
// 2244 	{
// 2245 		INT8U i;
// 2246 		for(i = 0; i < sizeof(Sts->BcMEsnNum); i++)
        MOV      R0,R4
        MOVS     R1,#+19
        MOVS     R2,#+48
// 2247 		{
// 2248 			Sts->BcMEsnNum[i] = 0x30;
??TRIO_Initialize_1:
        STRB     R2,[R0, #+124]
// 2249 		}
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??TRIO_Initialize_1
// 2250 
// 2251 		for(i = 0; i < sizeof(Sts->ModemStation); i++)
        MOV      R0,R4
        MOVS     R1,#+11
// 2252 		{
// 2253 			Sts->ModemStation[i] = 0x30;
??TRIO_Initialize_2:
        STRB     R2,[R0, #+113]
// 2254 		}
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??TRIO_Initialize_2
// 2255 	}
// 2256 	AttnOutBufferInit();
        BL       AttnOutBufferInit
// 2257 
// 2258 
// 2259 	Sts->ShutDownOnOff_2G			= Disable;
        ADD      R0,R4,#+201
        MOVS     R1,#+1
        STRB     R1,[R0, #+1]
// 2260 	Sts->ShutDownOnOff_3G			= Disable;
        STRB     R1,[R4, #+201]
// 2261 	Sts->ShutDownOnOff_LTE			= Disable;
        ADD      R0,R4,#+472
        STRB     R1,[R0, #+23]
// 2262 	Sts->ShutDownOnOff_LTE_A		= Disable;
        STRB     R1,[R0, #+24]
// 2263 	Sts->ShutDownOnOff_LTE1			= Disable;
        ADDW     R1,R4,#+797
        MOVS     R2,#+1
        STRB     R2,[R1, #+12]
// 2264 	Sts->ShutDownOnOff_LTE_A1		= Disable;
        STRB     R2,[R1, #+13]
// 2265 
// 2266 #if 1
// 2267 	Sts->AGCOnOff_3G				= Disable;
        STRB     R2,[R4, #+93]
// 2268 	Sts->AGCOnOff_2G				= Disable;
        STRB     R2,[R5, #+1]
// 2269 	Sts->AGCOnOff_LTE				= Disable;
        STRB     R2,[R5, #+4]
// 2270 	Sts->AGCOnOff_LTE_A 			= Disable;
        STRB     R2,[R5, #+5]
// 2271 	Sts->AGC1OnOff_LTE				= Disable;
        STRB     R2,[R5, #+8]
// 2272 	Sts->AGC1OnOff_LTE_A			= Disable;
        STRB     R2,[R5, #+9]
// 2273 
// 2274 
// 2275 	Sts->RvsAlcOnOff_2G 			= Disable;
        STRB     R2,[R4, #+472]
// 2276 	Sts->RvsAlcOnOff_LTE			= Disable;
        STRB     R2,[R0, #+1]
// 2277 	Sts->RvsAlcOnOff_LTE_A			= Disable;
        STRB     R2,[R0, #+2]
// 2278 	Sts->RvsAlcOnOff_3G 			= Disable;
        STRB     R2,[R0, #+3]
// 2279 	Sts->Rvs1AlcOnOff_LTE			= Disable;
        STRB     R2,[R4, #+797]
// 2280 	Sts->Rvs1AlcOnOff_LTE_A			= Disable;
        STRB     R2,[R1, #+1]
// 2281 #endif
// 2282 
// 2283 	Sts->FwdFixAttn_2G				= 10*2;
        MOVS     R0,#+20
        STRB     R0,[R4, #+882]
// 2284 	Sts->FwdFixAttn_LTE				= 10*2;
        ADDW     R0,R4,#+882
        MOVS     R1,#+20
        STRB     R1,[R0, #+1]
// 2285 
// 2286 //	Sts->TPTL_OnOff = Enable;
// 2287 
// 2288 }
        POP      {R0,R4,R5,PC}    ;; return
        DATA
??TRIO_Initialize_0:
        DC32     tDnrSts
// 2289 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2290 INT8U AnalyzeAidData(__ProtocolPtr *nPtr, INT8U Ctrl)
// 2291 {
AnalyzeAidData:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+76
        MOV      R9,R0
        MOV      R8,R1
// 2292 	INT8U i = 0;
// 2293 	INT8U A_ID[2];
// 2294 	INT8U rAID_Value[70];
// 2295 	INT8U Length;
// 2296 
// 2297 	INT16U Cnt = 0;
        MOVS     R5,#+0
// 2298 	INT16U AID_Command;
// 2299 
// 2300 	__WRCSSIO *Recv = nPtr->WRCSRecv;
        LDR      R0,[R9, #+28]
// 2301 	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody%2];
        LDRB     R1,[R0, #+1723]
        ASRS     R2,R1,#+1
        SUB      R1,R1,R2, LSL #+1
        MOV      R2,#+1712
        MLA      R0,R1,R2,R0
        ADD      R6,R0,#+8
// 2302 	INT8U id0 = BodyFrame->SubID[0];
// 2303 
// 2304 	INT8U rval = FALSE;
        MOVS     R7,#+0
// 2305 	id0 = id0;
        ADD      R4,SP,#+0
// 2306 	{
// 2307 		while(BodyFrame->SubLength > Cnt)
??AnalyzeAidData_0:
        LDRH     R1,[R6, #+1707]
        CMP      R5,R1
        BCS.N    ??AnalyzeAidData_1
// 2308 		{
// 2309 			A_ID[0] = (INT8U)(BodyFrame->SubData[Cnt++]);
        ADDS     R0,R5,R6
        LDRB     R0,[R0, #+7]
        STRB     R0,[SP, #+0]
        ADDS     R0,R5,#+1
        UXTH     R0,R0
// 2310 			A_ID[1] = (INT8U)(BodyFrame->SubData[Cnt++]);
        ADDS     R1,R0,R6
        LDRB     R1,[R1, #+7]
        STRB     R1,[R4, #+1]
        ADDS     R3,R0,#+1
        UXTH     R3,R3
// 2311 
// 2312 			AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
        LDRB     R0,[SP, #+0]
        ORR      R0,R1,R0, LSL #+8
// 2313 			Length = BodyFrame->SubData[Cnt++];
        ADDS     R1,R3,R6
        LDRB     R2,[R1, #+7]
        ADDS     R5,R3,#+1
        UXTH     R5,R5
// 2314 			if( Length >= sizeof(rAID_Value)) break;
        CMP      R2,#+70
        BCS.N    ??AnalyzeAidData_1
// 2315 			for (i = 0; i < Length; i++) rAID_Value[i] = (INT8U)(BodyFrame->SubData[Cnt++]);
        MOVS     R1,R2
        BEQ.N    ??AnalyzeAidData_2
        ADD      R1,SP,#+4
        MOV      R3,R2
??AnalyzeAidData_3:
        ADD      R12,R5,R6
        LDRB     R12,[R12, #+7]
        STRB     R12,[R1], #+1
        ADDS     R5,R5,#+1
        UXTH     R5,R5
        SUBS     R3,R3,#+1
        BNE.N    ??AnalyzeAidData_3
// 2316 
// 2317 
// 2318  			rval += CtrlData(AID_Command, rAID_Value, Length, Ctrl,nPtr);
??AnalyzeAidData_2:
        PUSH     {R9,LR}
        MOV      R3,R8
        ADD      R1,SP,#+12
        BL       CtrlData
        ADD      SP,SP,#+8
        ADDS     R7,R0,R7
        UXTB     R7,R7
// 2319 
// 2320 			if(Cnt >= BodyFrame->SubLength) break;
        LDRH     R1,[R6, #+1707]
        CMP      R5,R1
        BCC.N    ??AnalyzeAidData_0
// 2321 		}
// 2322 		
// 2323 		if(Ctrl)
??AnalyzeAidData_1:
        CMP      R8,#+0
        BEQ.N    ??AnalyzeAidData_4
// 2324 		{
// 2325 			if(rval) SaveBackupData();
        CBZ      R7,??AnalyzeAidData_4
        BL       SaveBackupData
// 2326 		}
// 2327 	}
// 2328 	
// 2329 
// 2330 	return TRUE;
??AnalyzeAidData_4:
        MOVS     R0,#+1
        ADD      SP,SP,#+76
        POP      {R4-R9,PC}       ;; return
// 2331 }
// 2332 
// 2333 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2334 void HostStation_Init(void)
// 2335 {
HostStation_Init:
        PUSH     {R3-R6}
// 2336 	INT8U i = 0;
// 2337 
// 2338 	for(i = 0; i < 11; i++)
        LDR.N    R0,??HostStation_Init_0  ;; HostStation
        MOV      R1,R0
        LDR.N    R2,??HostStation_Init_0+0x4  ;; B1_HostStation
        LDR.N    R3,??HostStation_Init_0+0x8  ;; TestStation
        LDR.N    R4,??HostStation_Init_0+0xC  ;; B1_TestStation
        MOVS     R5,#+11
// 2339 	{
// 2340 		if(!ISAscII(HostStation[i]) && ISAscII(B1_HostStation[i]))
??HostStation_Init_1:
        LDRB     R6,[R1, #+0]
        CMP      R6,#+48
        BCC.N    ??HostStation_Init_2
        CMP      R6,#+58
        BCC.N    ??HostStation_Init_3
??HostStation_Init_2:
        LDRB     R6,[R2, #+0]
        CMP      R6,#+48
        BCC.N    ??HostStation_Init_3
        CMP      R6,#+58
        BCS.N    ??HostStation_Init_3
// 2341 		{
// 2342 			HostStation[i] = B1_HostStation[i];
        STRB     R6,[R1, #+0]
// 2343 		}
// 2344 
// 2345 		if(!ISAscII(TestStation[i]) && ISAscII(B1_TestStation[i]))
??HostStation_Init_3:
        LDRB     R6,[R3, #+0]
        CMP      R6,#+48
        BCC.N    ??HostStation_Init_4
        CMP      R6,#+58
        BCC.N    ??HostStation_Init_5
??HostStation_Init_4:
        LDRB     R6,[R4, #+0]
        CMP      R6,#+48
        BCC.N    ??HostStation_Init_5
        CMP      R6,#+58
        BCS.N    ??HostStation_Init_5
// 2346 		{
// 2347 			TestStation[i] = B1_TestStation[i];
        STRB     R6,[R3, #+0]
// 2348 		}
// 2349 	}
??HostStation_Init_5:
        ADDS     R4,R4,#+1
        ADDS     R3,R3,#+1
        ADDS     R2,R2,#+1
        ADDS     R1,R1,#+1
        SUBS     R5,R5,#+1
        BNE.N    ??HostStation_Init_1
// 2350 
// 2351 	if( !ISAscII(HostStation[0]) && !ISAscII(HostStation[1]) &&
// 2352 		!ISAscII(HostStation[2]) && !ISAscII(HostStation[3]) &&
// 2353 		!ISAscII(HostStation[4]) && !ISAscII(HostStation[5])
// 2354 		)
        LDRB     R1,[R0, #+0]
        CMP      R1,#+48
        BCC.N    ??HostStation_Init_6
        CMP      R1,#+58
        BCC.N    ??HostStation_Init_7
??HostStation_Init_6:
        LDRB     R1,[R0, #+1]
        CMP      R1,#+48
        BCC.N    ??HostStation_Init_8
        CMP      R1,#+58
        BCC.N    ??HostStation_Init_7
??HostStation_Init_8:
        LDRB     R1,[R0, #+2]
        CMP      R1,#+48
        BCC.N    ??HostStation_Init_9
        CMP      R1,#+58
        BCC.N    ??HostStation_Init_7
??HostStation_Init_9:
        LDRB     R1,[R0, #+3]
        CMP      R1,#+48
        BCC.N    ??HostStation_Init_10
        CMP      R1,#+58
        BCC.N    ??HostStation_Init_7
??HostStation_Init_10:
        LDRB     R1,[R0, #+4]
        CMP      R1,#+48
        BCC.N    ??HostStation_Init_11
        CMP      R1,#+58
        BCC.N    ??HostStation_Init_7
??HostStation_Init_11:
        LDRB     R0,[R0, #+5]
        CMP      R0,#+48
        BCC.N    ??HostStation_Init_12
        CMP      R0,#+58
        SBCS     R1,R1,R1
        LSRS     R1,R1,#+31
        B.N      ??HostStation_Init_13
// 2355 		{
// 2356 			chkHostStation = Uninstall;
??HostStation_Init_12:
        MOVS     R1,#+0
// 2357 			for(i = 0; i < 11; i++)
        B.N      ??HostStation_Init_13
// 2358 			{
// 2359 //				HostStation[i]=ReadEEprom(HostStationBp + i);
// 2360 			}
// 2361 		}
// 2362 	else chkHostStation = Install;
??HostStation_Init_7:
        MOVS     R1,#+1
??HostStation_Init_13:
        LDR.N    R0,??HostStation_Init_0+0x10  ;; chkHostStation
        STRB     R1,[R0, #+0]
// 2363 	
// 2364 	if( !ISAscII(TestStation[0]) && !ISAscII(TestStation[1]) &&
// 2365 		!ISAscII(TestStation[2]) && !ISAscII(TestStation[3])
// 2366 		)
// 2367 		{
// 2368 			for(i = 0; i < 11; i++)
// 2369 			{
// 2370 //				TestStation[i] = ReadEEprom(TestStationBp + i);
// 2371 			}
// 2372 		}
// 2373 }
        POP      {R0,R4-R6}
        BX       LR               ;; return
        DATA
??HostStation_Init_0:
        DC32     HostStation
        DC32     B1_HostStation
        DC32     TestStation
        DC32     B1_TestStation
        DC32     chkHostStation
// 2374 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2375 INT8U ISAscII(INT8U Data)
// 2376 {
// 2377 	if('0' <= Data && Data <= '9')	return TRUE;
ISAscII:
        CMP      R0,#+48
        BCC.N    ??ISAscII_0
        CMP      R0,#+58
        BCS.N    ??ISAscII_0
        MOVS     R0,#+1
        BX       LR
// 2378 	else							return FALSE;
??ISAscII_0:
        MOVS     R0,#+0
        BX       LR               ;; return
// 2379 }
// 2380 
// 2381 
// 2382 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2383 INT8U RetNormaltoSMSData(INT8S Data)
// 2384 {
// 2385 	INT8S rVal = 0;
// 2386 
// 2387 	if(Data < 0)
RetNormaltoSMSData:
        CMP      R0,#+0
        BPL.N    ??RetNormaltoSMSData_0
// 2388 	{
// 2389 		rVal = -Data;
// 2390 		BitSet(rVal, 6);
        RSBS     R1,R0,#+0
        ORR      R0,R1,#0x40
// 2391 	}
// 2392 	else rVal = Data;
// 2393 	
// 2394 	return rVal;
??RetNormaltoSMSData_0:
        UXTB     R0,R0
        BX       LR               ;; return
// 2395 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AID_Command [%x][%d][...">`:
        DATA
        DC8 "AID_Command [%x][%d][%x][%x]\012"
        DC8 0, 0

        END
// 2396 
// 2397 
// 2398 #if 0
// 2399 [ TX ] 16 16 16 16 30 00 0d 3d 00 ff ff 01 34 00 04 a0 00 01 00 6e e0 03
// 2400 [ RX ] 16 16 16 16 30 05 d5 0a 00 ff ff 00 35 05 cc 00 01 12 78 7f 78 7e 7c 7c 7e 7c 40 20 15 28 64 00 00 0e 00 00 01 00 01 0b 01 01 01 0b 01 02 02 02 59 01 03 01 01 01 04 01 00 01 05 01 00 01 06 02 00 00 05 03 02 1e 00 05 04 02 15 00 05 05 02 0b 00 05 29 01 a6 05 2a 01 00 05 14 02 c4 00 05 15 02 09 00 05 16 02 ff 00 05 42 01 92 05 43 01 00 05 56 02 1e 00 05 57 02 0c 00 05 58 02 02 00 05 69 01 92 05 6a 01 00 05 6c 01 aa 05 6d 02 11 00 05 6e 02 07 00 05 71 01 a6 05 72 01 00 06 04 01 a6 06 2e 01 00 06 2d 01 00 06 0f 01 92 06 40 01 00 06 3f 01 00 06 74 01 92 06 77 01 00 06 76 01 00 06 7a 01 a6 06 7d 01 00 06 7c 01 00 07 0f 01 00 07 56 01 00 07 55 01 00 10 59 01 00 09 0a 01 01 09 35 01 01 10 51 01 01 10 52 01 01 10 5f 01 01 10 60 01 01 10 5b 01 01 10 5c 01 01 10 5d 01 01 10 5e 01 01 09 22 01 00 09 23 02 00 00 09 2e 02 00 00 a0 00 01 01 a0 01 01 00 a0 06 01 01 a0 0d 01 00 a0 0e 06 00 00 00 00 00 00 a0 0f 0b 30 30 30 30 30 30 30 30 30 30 30 a0 10 13 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 a0 11 01 01 a0 12 05 00 00 00 00 00 a0 13 01 21 a0 14 01 00 a0 2a 01 00 a0 2b 02 00 00 a1 01 01 00 a1 02 01 00 a1 09 01 00 a1 0b 01 00 a1 c2 01 00 a1 59 01 00 a1 5e 01 00 a1 5f 01 32 a1 62 01 00 a1 63 01 00 a1 66 01 00 a1 67 01 14 a1 68 01 00 a1 6a 01 00 a1 6b 01 00 a1 6c 01 00 a1 6d 01 00 a1 bd 03 00 00 00 a1 be 03 01 00 00 a1 c3 01 00 a1 c4 01 00 a1 cd 01 00 a3 48 01 96 a3 49 01 f6 a3 4a 02 c4 00 a3 4b 02 c4 00 a3 4c 01 01 a3 4d 01 01 a3 67 02 00 00 a3 69 02 00 00 a3 6a 01 00 a3 6b 01 00 a3 6c 01 00 a3 6d 01 00 a3 6e 01 00 a3 70 01 00 a3 71 01 00 a3 72 01 00 a3 73 02 18 00 a3 74 02 0c 00 a3 91 01 00 a3 92 01 00 a8 00 4c 00 00 00 00 00 00 00 01 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 05 bd 00 00 00 00 0a 39 03 3e 00 00 00 00 00 00 00 00 00 00 a8 01 16 00 00 88 88 88 3c 00 3c 3c 00 00 3c 3c 00 00 3c 3c 3c 4c 00 00 00 a8 02 16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 03 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 04 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 05 01 00 a8 06 01 00 a8 07 01 00 a8 08 01 00 a8 0b 01 00 a8 10 01 00 a8 11 01 32 a8 14 01 00 a8 15 01 00 a8 18 01 00 a8 19 01 14 a8 1a 01 00 a8 1d 01 00 a8 1e 01 00 a8 1f 01 00 a8 20 01 00 a8 22 01 00 a8 23 01 00 a8 24 01 00 a8 25 01 00 a8 26 01 00 a8 27 01 00 a8 28 01 00 a8 29 01 00 a8 2a 01 00 a8 2b 01 00 a8 2c 01 00 a8 2d 01 00 a8 2e 01 01 a8 2f 01 01 a8 30 01 01 a8 31 01 01 a8 42 01 96 a8 43 01 aa a8 44 02 c4 00 a8 45 02 1e 00 a8 46 02 fb 00 a8 47 02 fb 00 a8 48 02 d5 00 a8 49 02 cb 00 a8 4a 01 01 a8 4b 01 01 a8 4c 02 00 00 a8 4d 02 00 00 a8 4e 01 00 a8 4f 01 00 a8 50 01 00 a8 51 01 00 a8 52 02 0f 00 a8 53 02 14 00 a8 54 01 00 a8 55 01 00 a8 56 01 00 a8 57 01 00 a8 58 01 00 a8 59 01 00 a8 5a 01 00 a8 5b 01 00 a8 5d 01 00 a8 5e 01 00 a8 5f 01 00 a8 60 01 00 0c 00 01 00 0c 01 02 00 00 0c 02 01 00 0c 03 02 00 00 0c 04 02 00 00 0c 05 02 00 00 0c 06 02 00 00 0c 07 02 00 00 0c 08 02 00 00 0c 09 01 00 0c 0a 02 00 00 0c 0b 02 00 00 0c 0c 01 00 0c 0d 0c 00 00 00 00 00 00 00 00 00 00 00 00 0c 0e 06 00 00 00 00 00 00 0c 11 02 00 00 0c 12 02 00 00 0c 13 02 00 00 0c 14 0b 00 04 00 20 9d 42 00 08 91 32 00 e5 03 02 00 00 e5 04 06 00 00 00 00 00 00 e5 05 06 00 00 00 00 00 00 e5 06 06 00 00 00 00 00 00 e5 07 02 00 00 e5 08 02 00 00 e5 09 02 00 00 1b 00 02 1e 00 1b 01 02 0c 00 1b 02 02 02 00 1b 03 01 92 1b 04 01 00 1b 06 02 1e 00 1b 07 02 11 00 1b 08 02 07 00 1b 09 01 a6 1b 10 01 00 1c 00 01 92 1c 03 01 00 1c 02 01 00 1c 05 01 a6 1c 08 01 00 1c 07 01 00 07 57 01 00 07 58 01 00 a9 01 08 00 00 3c 3c 00 00 3c 3c a9 02 08 00 00 00 00 00 00 00 00 a9 03 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 04 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 05 01 00 a9 06 01 00 a9 07 01 00 a9 08 01 00 a9 09 01 00 a9 0a 01 00 a9 0b 01 00 a9 0c 01 00 a9 0f 01 00 a9 10 
// 2401 01 00 a9 13 01 00 a9 14 01 00 a9 15 01 00 a9 16 01 00 a9 18 01 00 a9 19 01 00 a9 1a 01 00 a9 1b 01 00 a9 21 01 00 a9 22 01 00 a9 21 01 00 a9 22 01 00 a9 25 01 01 a9 26 01 01 a9 29 01 00 a9 2a 01 96 a9 2b 02 00 00 a9 2c 02 00 00 a9 2d 02 37 00 a9 2e 02 37 00 a9 2f 01 01 a9 30 01 01 a9 31 02 00 00 a9 32 02 00 00 a9 33 01 00 a9 34 01 00 a9 35 01 00 a9 36 01 00 a9 37 02 0f 00 a9 38 02 14 00 a9 39 01 00 a9 3a 01 00 d8 d0 03 16 16 16 16 30 05 d5 0a 00 ff ff 01 35 05 cc 00 01 12 78 7f 78 7e 7c 7c 7e 7c 40 20 15 28 64 00 00 0e 00 00 01 00 01 0b 01 01 01 0b 01 02 02 02 59 01 03 01 01 01 04 01 00 01 05 01 00 01 06 02 00 00 05 03 02 1e 00 05 04 02 15 00 05 05 02 0b 00 05 29 01 a6 05 2a 01 00 05 14 02 c4 00 05 15 02 09 00 05 16 02 ff 00 05 42 01 92 05 43 01 00 05 56 02 1e 00 05 57 02 0c 00 05 58 02 02 00 05 69 01 92 05 6a 01 00 05 6c 01 aa 05 6d 02 11 00 05 6e 02 07 00 05 71 01 a6 05 72 01 00 06 04 01 a6 06 2e 01 00 06 2d 01 00 06 0f 01 92 06 40 01 00 06 3f 01 00 06 74 01 92 06 77 01 00 06 76 01 00 06 7a 01 a6 06 7d 01 00 06 7c 01 00 07 0f 01 00 07 56 01 00 07 55 01 00 10 59 01 00 09 0a 01 01 09 35 01 01 10 51 01 01 10 52 01 01 10 5f 01 01 10 60 01 01 10 5b 01 01 10 5c 01 01 10 5d 01 01 10 5e 01 01 09 22 01 00 09 23 02 00 00 09 2e 02 00 00 a0 00 01 00 a0 01 01 00 a0 06 01 01 a0 0d 01 00 a0 0e 06 00 00 00 00 00 00 a0 0f 0b 30 30 30 30 30 30 30 30 30 30 30 a0 10 13 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 a0 11 01 01 a0 12 05 00 00 00 00 00 a0 13 01 21 a0 14 01 00 a0 2a 01 00 a0 2b 02 00 00 a1 01 01 00 a1 02 01 00 a1 09 01 00 a1 0b 01 00 a1 c2 01 00 a1 59 01 00 a1 5e 01 00 a1 5f 01 32 a1 62 01 00 a1 63 01 00 a1 66 01 00 a1 67 01 14 a1 68 01 00 a1 6a
// 2402 [ RX ] 01 00 a1 6b 01 00 a1 6c 01 00 a1 6d 01 00 a1 bd 03 00 00 00 a1 be 03 01 00 00 a1 c3 01 00 a1 c4 01 00 a1 cd 01 00 a3 48 01 96 a3 49 01 f6 a3 4a 02 c4 00 a3 4b 02 c4 00 a3 4c 01 01 a3 4d 01 01 a3 67 02 00 00 a3 69 02 00 00 a3 6a 01 00 a3 6b 01 00 a3 6c 01 00 a3 6d 01 00 a3 6e 01 00 a3 70 01 00 a3 71 01 00 a3 72 01 00 a3 73 02 18 00 a3 74 02 0c 00 a3 91 01 00 a3 92 01 00 a8 00 4c 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 03 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 05 bd 00 00 00 00 0a 3b 03 40 00 00 00 00 00 00 00 00 00 00 a8 01 16 00 00 88 88 88 3c 00 3c 3c 00 00 3c 3c 00 00 3c 3c 3c 4c 00 00 00 a8 02 16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 03 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 04 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 05 01 00 a8 06 01 00 a8 07 01 00 a8 08 01 00 a8 0b 01 00 a8 10 01 00 a8 11 01 32 a8 14 01 00 a8 15 01 00 a8 18 01 00 a8 19 01 14 a8 1a 01 00 a8 1d 01 00 a8 1e 01 00 a8 1f 01 00 a8 20 01 00 a8 22 01 00 a8 23 01 00 a8 24 01 00 a8 25 01 00 a8 26 01 00 a8 27 01 00 a8 28 01 00 a8 29 01 00 a8 2a 01 00 a8 2b 01 00 a8 2c 01 00 a8 2d 01 00 a8 2e 01 01 a8 2f 01 01 a8 30 01 01 a8 31 01 01 a8 42 01 96 a8 43 01 aa a8 44 02 c4 00 a8 45 02 1e 00 a8 46 02 fb 00 a8 47 02 fb 00 a8 48 02 d5 00 a8 49 02 cb 00 a8
// 2403 [ RX ] 4a 01 01 a8 4b 01 01 a8 4c 02 00 00 a8 4d 02 00 00 a8 4e 01 00 a8 4f 01 00 a8 50 01 00 a8 51 01 00 a8 52 02 0f 00 a8 53 02 14 00 a8 54 01 00 a8 55 01 00 a8 56 01 00 a8 57 01 00 a8 58 01 00 a8 59 01 00 a8 5a 01 00 a8 5b 01 00 a8 5d 01 00 a8 5e 01 00 a8 5f 01 00 a8 60 01 00 0c 00 01 00 0c 01 02 00 00 0c 02 01 00 0c 03 02 00 00 0c 04 02 00 00 0c 05 02 00 00 0c 06 02 00 00 0c 07 02 00 00 0c 08 02 00 00 0c 09 01 00 0c 0a 02 00 00 0c 0b 02 00 00 0c 0c 01 00 0c 0d 0c 00 00 00 00 00 00 00 00 00 00 00 00 0c 0e 06 00 00 00 00 00 00 0c 11 02 00 00 0c 12 02 00 00 0c 13 02 00 00 0c 14 0b 00 04 00 20 9d 42 00 08 91 32 00 e5 03 02 00 00 e5 04 06 00 00 00 00 00 00 e5 05 06 00 00 00 00 00 00 e5 06 06 00 00 00 00 00 00 e5 07 02 00 00 e5 08 02 00 00 e5 09 02 00 00 1b 00 02 1e 00 1b 01 02 0c 00 1b 02 02 02 00 1b 03 01 92 1b 04 01 00 1b 06 02 1e 00 1b 07 02 11 00 1b 08 02 07 00 1b 09 01 a6 1b 10 01 00 1c 00 01 92 1c 03 01 00 1c 02 01 00 1c 05 01 a6 1c 08 01 00 1c 07 01 00 07 57 01 00 07 58 01 00 a9 01 08 00 00 3c 3c 00 00 3c 3c a9 02 08 00 00 00 00 00 00 00 00 a9 03 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 04 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 05 01 00 a9 06 01 00 a9 07 01 00 a9 08 01 00 a9 09 01 00 a9 0a 01 00 a9 0b 01 00 a9 0c 01 ff a9 0f 01 00 a9 10 01 ff a9 13 01 ff a9 14 01 00 a9 15 01 00 a9 16 01 00 a9 18 01 00 a9 19 01 00 a9 1a 01 ff a9 1b 01 00 a9 21 01 00 a9 22 01 00 a9 21 01 00 a9 22 01 00 a9 25 01 01 a9 26 01 01 a9 29 01 00 a9 2a 01 96 a9 2b 02 00 00 a9 2c 02 00 00 a9 2d 02 37 00 a9 2e 02 37 00 a9 2f 01 01 a9 30 01 01 a9 31 02 00 00 a9 32 02 00 00 a9 33 01 ff a9 34 01 ff a9 35 01 ff a9 36 01 ff a9 37 02 0f 00 a9 38 02 14 00 a9 39 01 00 a9 3a 01 00 cc c4 03
// 2404 
// 2405 
// 2406 16 16 16 16 30 05 d5 0a 00 ff ff 00 35 05 cc 00 01 12 78 7f 78 7e 7c 7c 7e 7c 40 20 15 28 64 00 00 0e 00 00 01 00 01 0b 01 01 01 0b 01 02 02 02 59 01 03 01 01 01 04 01 00 01 05 01 00 01 06 02 00 00 05 03 02 1e 00 05 04 02 15 00 05 05 02 0b 00 05 29 01 a6 05 2a 01 00 05 14 02 c4 00 05 15 02 09 00 05 16 02 ff 00 05 42 01 92 05 43 01 00 05 56 02 1e 00 05 57 02 0c 00 05 58 02 02 00 05 69 01 92 05 6a 01 00 05 6c 01 aa 05 6d 02 11 00 05 6e 02 07 00 05 71 01 a6 05 72 01 00 06 04 01 a6 06 2e 01 00 06 2d 01 00 06 0f 01 92 06 40 01 00 06 3f 01 00 06 74 01 92 06 77 01 00 06 76 01 00 06 7a 01 a6 06 7d 01 00 06 7c 01 00 07 0f 01 00 07 56 01 00 07 55 01 00 10 59 01 00 09 0a 01 01 09 35 01 01 10 51 01 01 10 52 01 01 10 5f 01 01 10 60 01 01 10 5b 01 01 10 5c 01 01 10 5d 01 01 10 5e 01 01 09 22 01 00 09 23 02 00 00 09 2e 02 00 00 a0 00 01 00 a0 01 01 00 a0 06 01 01 a0 0d 01 00 a0 0e 06 00 00 00 00 00 00 a0 0f 0b 30 30 30 30 30 30 30 30 30 30 30 a0 10 13 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 a0 11 01 01 a0 12 05 00 00 00 00 00 a0 13 01 21 a0 14 01 00 a0 2a 01 00 a0 2b 02 00 00 a1 01 01 00 a1 02 01 00 a1 09 01 00 a1 0b 01 00 a1 c2 01 00 a1 59 01 00 a1 5e 01 00 a1 5f 01 32 a1 62 01 00 a1 63 01 00 a1 66 01 00 a1 67 01 14 a1 68 01 00 a1 6a 01 00 a1 6b 01 00 a1 6c 01 00 a1 6d 01 00 a1 bd 03 00 00 00 a1 be 03 01 00 00 a1 c3 01 00 a1 c4 01 00 a1 cd 01 00 a3 48 01 96 a3 49 01 f6 a3 4a 02 c4 00 a3 4b 02 c4 00 a3 4c 01 01 a3 4d 01 01 a3 67 02 00 00 a3 69 02 00 00 a3 6a 01 00 a3 6b 01 00 a3 6c 01 00 a3 6d 01 00 a3 6e 01 00 a3 70 01 00 a3 71 01 00 a3 72 01 00 a3 73 02 18 00 a3 74 02 0c 00 a3 91 01 00 a3 92 01 00 a8 00 4c 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 03 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 05 bd 00 00 00 00 0a 39 03 3f 00 00 00 00 00 00 00 00 00 00 a8 01 16 00 00 88 88 88 3c 00 3c 3c 00 00 3c 3c 00 00 3c 3c 3c 4c 00 00 00 a8 02 16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 03 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 04 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 05 01 00 a8 06 01 00 a8 07 01 00 a8 08 01 00 a8 0b 01 00 a8 10 01 00 a8 11 01 32 a8 14 01 00 a8 15 01 00 a8 18 01 00 a8 19 01 14 a8 1a 01 00 a8 1d 01 00 a8 1e 01 00 a8 1f 01 00 a8 20 01 00 a8 22 01 00 a8 23 01 00 a8 24 01 00 a8 25 01 00 a8 26 01 00 a8 27 01 00 a8 28 01 00 a8 29 01 00 a8 2a 01 00 a8 2b 01 00 a8 2c 01 00 a8 2d 01 00 a8 2e 01 01 a8 2f 01 01 a8 30 01 01 a8 31 01 01 a8 42 01 96 a8 43 01 aa a8 44 02 c4 00 a8 45 02 1e 00 a8 46 02 fb 00 a8 47 02 fb 00 a8 48 02 d5 00 a8 49 02 cb 00 a8 4a 01 01 a8 4b 01 01 a8 4c 02 00 00 a8 4d 02 00 00 a8 4e 01 00 a8 4f 01 00 a8 50 01 00 a8 51 01 00 a8 52 02 0f 00 a8 53 02 14 00 a8 54 01 00 a8 55 01 00 a8 56 01 00 a8 57 01 00 a8 58 01 00 a8 59 01 00 a8 5a 01 00 a8 5b 01 00 a8 5d 01 00 a8 5e 01 00 a8 5f 01 00 a8 60 01 00 0c 00 01 00 0c 01 02 00 00 0c 02 01 00 0c 03 02 00 00 0c 04 02 00 00 0c 05 02 00 00 0c 06 02 00 00 0c 07 02 00 00 0c 08 02 00 00 0c 09 01 00 0c 0a 02 00 00 0c 0b 02 00 00 0c 0c 01 00 0c 0d 0c 00 00 00 00 00 00 00 00 00 00 00 00 0c 0e 06 00 00 00 00 00 00 0c 11 02 00 00 0c 12 02 00 00 0c 13 02 00 00 0c 14 0b 00 04 00 20 9d 42 00 08 91 32 00 e5 03 02 00 00 e5 04 06 00 00 00 00 00 00 e5 05 06 00 00 00 00 00 00 e5 06 06 00 00 00 00 00 00 e5 07 02 00 00 e5 08 02 00 00 e5 09 02 00 00 1b 00 02 1e 00 1b 01 02 0c 00 1b 02 02 02 00 1b 03 01 92 1b 04 01 00 1b 06 02 1e 00 1b 07 02 11 00 1b 08 02 07 00 1b 09 01 a6 1b 10 01 00 1c 00 01 92 1c 03 01 00 1c 02 01 00 1c 05 01 a6 1c 08 01 00 1c 07 01 00 07 57 01 00 07 58 01 00 a9 01 08 00 00 3c 3c 00 00 3c 3c a9 02 08 00 00 00 00 00 00 00 00 a9 03 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 04 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 05 01 00 a9 06 01 00 a9 07 01 00 a9 08 01 00 a9 09 01 00 a9 0a 01 00 a9 0b 01 00 a9 0c 01 ff a9 0f 01 00 a9 10 01 ff 
// 2407 a9 13 01 ff a9 14 01 00 a9 15 01 00 a9 16 01 00 a9 18 01 00 a9 19 01 00 a9 1a 01 ff a9 1b 01 00 a9 21 01 00 a9 22 01 00 a9 21 01 00 a9 22 01 00 a9 25 01 01 a9 26 01 01 a9 29 01 00 a9 2a 01 96 a9 2b 02 00 00 a9 2c 02 00 00 a9 2d 02 37 00 a9 2e 02 37 00 a9 2f 01 01 a9 30 01 01 a9 31 02 00 00 a9 32 02 00 00 a9 33 01 ff a9 34 01 ff a9 35 01 ff a9 36 01 ff a9 37 02 0f 00 a9 38 02 14 00 a9 39 01 00 a9 3a 01 00 a8 ef 03
// 2408 
// 2409 
// 2410 #endif
// 2411 ////////////////////////////////////////////////////////////////////////////////
// 2412 // End of Source File
// 2413 ////////////////////////
// 2414 
// 
//  5 912 bytes in section .bss
//     12 bytes in section .data
//     32 bytes in section .rodata
// 11 828 bytes in section .text
// 
// 11 828 bytes of CODE  memory
//     32 bytes of CONST memory
//  5 924 bytes of DATA  memory
//
//Errors: none
//Warnings: none
