///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:34 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DE_Ta /
//                    ble.C                                                   /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DE_Ta /
//                    ble.C -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_app /
//                    l_src_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_app /
//                    l_src_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl /
//                    _src_20120109\sout\ --endian=little --cpu=Cortex-M3 -e  /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\DE_Ta /
//                    ble.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME DE_Table

        EXTERN AttnOffsetTable
        EXTERN AttnTempTable
        EXTERN GenBodyFrame
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OutputTable
        EXTERN ReadAT24C64
        EXTERN RoadBackuptobuffer
        EXTERN SaveBackupData
        EXTERN WRCS_ProDataAckTx
        EXTERN WatchdogClear
        EXTERN WriteAT24C64
        EXTERN WriteBuffertoBackup
        EXTERN __fswab16
        EXTERN tDnrSts

        PUBLIC DefaultValueSet
        PUBLIC LoadTableConv
        PUBLIC PwrInit
        PUBLIC PwrInit1
        PUBLIC Response_Table_DE
        PUBLIC TableIndex
        PUBLIC TableIndexBackup
        PUBLIC TableLocation
        PUBLIC _AttInit
        PUBLIC _AttInit1
        PUBLIC _AttInit2
        PUBLIC _TempInit
        PUBLIC _TempInit1

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\DE_Table.C
//    1 /*********************************************
//    2 * File Name          : DE_Table.c
//    3 * Author             :
//    4 * Date First Issued  : 10/20/2010
//    5 * Description        : This file provides all the port/input/update firmware functions.
//    6 * $Revision: 0.1 $
//    7 * $Revision date: 2010.10.__
//    8 ********************************************************************************/
//    9 
//   10 #define DE_Table_C
//   11 
//   12 #include "../include/main.h"

        SECTION `.rodata`:CONST:NOROOT(2)
// unsigned char const __data _AttInit[65]
_AttInit:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// unsigned char const __data _AttInit2[65]
_AttInit2:
        DC8 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
        DC8 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
        DC8 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
        DC8 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 0, 0, 0
// unsigned char const __data _TempInit[25]
_TempInit:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0
// unsigned char const __data _TempInit1[25]
_TempInit1:
        DC8 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
        DC8 20, 31, 32, 33, 34, 35, 0, 0, 0
// unsigned short const __data PwrInit[81]
PwrInit:
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
// unsigned char const __data _AttInit1[65]
_AttInit1:
        DATA
        DC8 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
        DC8 20, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46
        DC8 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 1, 2, 3, 4
        DC8 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
// unsigned short const __data PwrInit1[81]
PwrInit1:
        DATA
        DC16 3299, 3276, 3253, 3230, 3207, 3184, 3160, 3137, 3114, 3091, 3068
        DC16 3038, 3008, 2979, 2949, 2919, 2889, 2859, 2830, 2800, 2770, 2747
        DC16 2725, 2702, 2679, 2657, 2634, 2611, 2588, 2566, 2543, 2514, 2484
        DC16 2455, 2425, 2396, 2367, 2337, 2308, 2278, 2249, 2230, 2211, 2192
        DC16 2173, 2154, 2134, 2115, 2096, 2077, 2058, 2034, 2009, 1985, 1961
        DC16 1937, 1912, 1888, 1864, 1839, 1815, 1786, 1756, 1727, 1698, 1669
        DC16 1639, 1610, 1581, 1551, 1522, 1502, 1483, 1463, 1444, 1424, 1404
        DC16 1385, 1365, 1346, 1326
        DC8 0, 0
//   13 
//   14 
//   15 
//   16 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   17 void DefaultValueSet(void)
//   18 {
DefaultValueSet:
        PUSH     {R3-R11,LR}
//   19 	__Dnr_Sts *Sts = tDnrSts;
        LDR.W    R0,??DefaultValueSet_0  ;; tDnrSts
        LDR      R6,[R0, #+0]
//   20 	
//   21 	INT32U cpu_sr;
//   22 
//   23 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//   24 
//   25 	Sts->FwdAttn1_2G			= 0; 	
        ADD      R5,R6,#+154
        MOVS     R0,#+0
        STRB     R0,[R5, #+8]
//   26 	Sts->FwdAttn2_2G			= 0; 	
        STRB     R0,[R5, #+9]
//   27 	Sts->RvsAttn1_2G			= 0; 	
        STRB     R0,[R5, #+12]
//   28 	Sts->RvsAttn2_2G			= 0; 	
        STRB     R0,[R5, #+13]
//   29 	Sts->RvsAttn3_2G			= 0; 	
        STRB     R0,[R5, #+14]
//   30 	Sts->FwdAttn1_3G			= 0; 	
        STRB     R0,[R5, #+10]
//   31 	Sts->FwdAttn2_3G			= 0; 	
        STRB     R0,[R5, #+11]
//   32 	Sts->RvsAttn1_3G			= 0; 	
        STRB     R0,[R5, #+16]
//   33 	Sts->RvsAttn2_3G			= 0; 	
        STRB     R0,[R5, #+17]
//   34 	Sts->RvsAttn3_3G			= 0; 	
        STRB     R0,[R5, #+18]
//   35 	Sts->RvsAttn4_3G			= 0; 	
        STRB     R0,[R5, #+19]
//   36 	Sts->FwdAttn1_Common		= 0;
        ADDW     R3,R6,#+427
        STRB     R0,[R3, #+3]
//   37 	Sts->RvsAttn1_Common		= 0;
        STRB     R0,[R3, #+4]
//   38 	Sts->FwdAttn1_LTE			= 0;	
        STRB     R0,[R3, #+11]
//   39 	Sts->FwdAttn2_LTE			= 0;	
        STRB     R0,[R3, #+12]
//   40 	Sts->FwdAttn1_LTE_A 		= 0;
        STRB     R0,[R3, #+13]
//   41 	Sts->FwdAttn2_LTE_A 		= 0;
        STRB     R0,[R3, #+14]
//   42 	Sts->RvsAttn1_LTE			= 0;	
        STRB     R0,[R3, #+15]
//   43 	Sts->RvsAttn2_LTE			= 0;	
        STRB     R0,[R3, #+16]
//   44 	Sts->RvsAttn3_LTE			= 0;	
        STRB     R0,[R3, #+17]
//   45 	Sts->RvsAttn1_LTE_A 		= 0;
        STRB     R0,[R3, #+18]
//   46 	Sts->RvsAttn2_LTE_A 		= 0;
        STRB     R0,[R3, #+19]
//   47 	Sts->RvsAttn3_LTE_A 		= 0;
        STRB     R0,[R3, #+20]
//   48 	Sts->RvsAttn4_LTE_A 		= 0;
        STRB     R0,[R3, #+21]
//   49 
//   50 
//   51 
//   52 	Sts->FwdOutUpperLmt_3G[0]		= FwdHighLmt_3G; 
        MOVS     R0,#+21
        STRB     R0,[R6, #+38]
//   53 	Sts->FwdOutUpperLmt_3G[1]		= 0; 
        ADD      R2,R6,#+38
        MOVS     R0,#+0
        STRB     R0,[R2, #+1]
//   54 	Sts->FwdOutLowerLmt_3G[0]		= FwdHighLmt_3G - 10; 
        MOVS     R0,#+11
        STRB     R0,[R2, #+2]
//   55 	Sts->FwdOutLowerLmt_3G[1]		= 0; 
        MOVS     R0,#+0
        STRB     R0,[R2, #+3]
//   56 	Sts->FwdGainSet_3G				= Gain_3G; 
        MOVS     R0,#+166
        STRB     R0,[R2, #+4]
//   57 	Sts->Rvs0GainSet_3G 			= Gain_3G;
        STRB     R0,[R2, #+30]
//   58 	Sts->RvsGainBalance_3G			= 0;
        MOVS     R0,#+0
        STRB     R0,[R6, #+70]
//   59 	Sts->FwdOutHighLmt_3G[0]		= FwdHighLmt_3G + 3;
        ADD      R0,R6,#+188
        MOVS     R1,#+24
        STRB     R1,[R0, #+27]
//   60 	Sts->FwdOutHighLmt_3G[1]		= 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+28]
//   61 	Sts->RvsOutUpperLmt_3G[0]		= 0;
        STRB     R1,[R0, #+15]
//   62 	Sts->RvsOutUpperLmt_3G[1]		= 0;
        STRB     R1,[R0, #+16]
//   63 	Sts->OverInAlarmLmt_LTE 		= 0; 
        ADDW     R1,R6,#+495
        MOVS     R7,#+0
        STRB     R7,[R1, #+15]
//   64 	Sts->OverInAlarmLmt_3G			= 0; 
        STRB     R7,[R1, #+17]
//   65 	Sts->OtherOverInAlarmLmt_3G 	= 0; 
        STRB     R7,[R1, #+21]
//   66 	Sts->RvsALCLvl_3G				= 0;
        STRB     R7,[R1, #+25]
//   67 
//   68 	
//   69 	Sts->FwdOutUpperLmt_2G[0]		= FwdHighLmt_2G; 
        MOVS     R7,#+9
        STRB     R7,[R2, #+8]
//   70 	Sts->FwdOutUpperLmt_2G[1]		= 0; 
        MOVS     R7,#+0
        STRB     R7,[R2, #+9]
//   71 	Sts->FwdOutLowerLmt_2G[0]		= FwdHighLmt_2G - 10; 
        MOV      R7,#-1
        STRB     R7,[R2, #+10]
//   72 	Sts->FwdOutLowerLmt_2G[1]		= 0; 
        MOVS     R7,#+0
        STRB     R7,[R2, #+11]
//   73 	Sts->FwdGainSet_2G				= Gain_2G;
        MOVS     R7,#+146
        STRB     R7,[R2, #+12]
//   74 	Sts->Rvs0GainSet_2G 			= Gain_2G;
        ADD      R7,R6,#+70
        MOVS     R4,#+146
        STRB     R4,[R7, #+1]
//   75 	Sts->RvsGainBalance_2G			= 0;
        MOVS     R4,#+0
        STRB     R4,[R7, #+3]
//   76 	Sts->FwdOutHighLmt_2G[0]		= FwdHighLmt_2G +3;
        MOVS     R4,#+12
        STRB     R4,[R0, #+29]
//   77 	Sts->FwdOutHighLmt_2G[1]		= 0;
        MOVS     R4,#+0
        STRB     R4,[R0, #+30]
//   78 	Sts->RvsOutUpperLmt_2G[0]		= 0;
        STRB     R4,[R0, #+17]
//   79 	Sts->RvsOutUpperLmt_2G[1]		= 0;
        STRB     R4,[R0, #+18]
//   80 	Sts->OverInAlarmLmt_2G			= 0; 
        STRB     R4,[R1, #+14]
//   81 	Sts->RvsALCLvl_2G				= 0;
        STRB     R4,[R1, #+22]
//   82 	Sts->OtherOverInAlarmLmt_2G 	= 0; 
        STRB     R4,[R1, #+18]
//   83 
//   84 	Sts->FwdOutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
        MOVS     R4,#+12
        STRB     R4,[R2, #+16]
//   85 	Sts->FwdOutUpperLmt_LTE[1]		= 0;
        MOVS     R4,#+0
        STRB     R4,[R2, #+17]
//   86 	Sts->FwdOutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
        MOVS     R4,#+2
        STRB     R4,[R2, #+18]
//   87 	Sts->FwdOutLowerLmt_LTE[1]		= 0;
        MOVS     R4,#+0
        STRB     R4,[R2, #+19]
//   88 	Sts->FwdGainSet_LTE 			= Gain_LTE;
        MOVS     R4,#+146
        STRB     R4,[R2, #+20]
//   89 	Sts->Rvs0GainSet_LTE			= Gain_LTE; 
        STRB     R4,[R7, #+4]
//   90 	Sts->RvsGainBalance_LTE 		= 0; 
        MOVS     R4,#+0
        STRB     R4,[R7, #+6]
//   91 	Sts->FwdOutHighLmt_LTE[0]		= FwdHighLmt_LTE + 3;
        MOVS     R4,#+15
        STRB     R4,[R1, #+10]
//   92 	Sts->FwdOutHighLmt_LTE[1]		= 0; 
        MOVS     R4,#+0
        STRB     R4,[R1, #+11]
//   93 	Sts->RvsOutUpperLmt_LTE[0]		= 0;
        STRB     R4,[R1, #+2]
//   94 	Sts->RvsOutUpperLmt_LTE[1]		= 0;
        STRB     R4,[R1, #+3]
//   95 	Sts->RvsALCLvl_LTE				= 0;
        STRB     R4,[R1, #+23]
//   96 	Sts->OtherOverInAlarmLmt_LTE	= 0; 
        STRB     R4,[R1, #+19]
//   97 
//   98 	
//   99 	Sts->FwdOutUpperLmt_LTE_A[0]	= FwdHighLmt_LTE_A;
        MOVS     R4,#+17
        STRB     R4,[R2, #+24]
//  100 	Sts->FwdOutUpperLmt_LTE_A[1]	= 0;
        MOVS     R4,#+0
        STRB     R4,[R2, #+25]
//  101 	Sts->FwdOutLowerLmt_LTE_A[0]	= FwdHighLmt_LTE_A -10;
        MOVS     R4,#+7
        STRB     R4,[R2, #+26]
//  102 	Sts->FwdOutLowerLmt_LTE_A[1]	= 0;
        MOVS     R4,#+0
        STRB     R4,[R2, #+27]
//  103 	Sts->FwdGainSet_LTE_A			= Gain_LTE_A;
        MOVS     R4,#+166
        STRB     R4,[R2, #+28]
//  104 	Sts->Rvs0GainSet_LTE_A			= Gain_LTE_A; 
        STRB     R4,[R7, #+7]
//  105 	Sts->RvsGainBalance_LTE_A		= 0; 
        MOVS     R2,#+0
        STRB     R2,[R7, #+9]
//  106 	Sts->FwdOutHighLmt_LTE_A[0] 	= FwdHighLmt_LTE_A + 3; 
        MOVS     R2,#+20
        STRB     R2,[R1, #+12]
//  107 	Sts->FwdOutHighLmt_LTE_A[1] 	= 0; 
        MOVS     R2,#+0
        STRB     R2,[R1, #+13]
//  108 
//  109 	Sts->RvsOutUpperLmt_LTE_A[0]	= 0;
        STRB     R2,[R1, #+4]
//  110 	Sts->RvsOutUpperLmt_LTE_A[1]	= 0;
        STRB     R2,[R1, #+5]
//  111 	Sts->RvsALCLvl_LTE_A			= 0;
        STRB     R2,[R1, #+24]
//  112 	Sts->OverInAlarmLmt_LTE_A		= 0; 
        STRB     R2,[R1, #+16]
//  113 	Sts->OtherOverInAlarmLmt_LTE_A	= 0; 
        STRB     R2,[R1, #+20]
//  114 
//  115 
//  116 	Sts->Fwd1OutUpperLmt_LTE[0]		= FwdHighLmt_LTE; 
        MOVS     R2,#+12
        STRB     R2,[R6, #+657]
//  117 	Sts->Fwd1OutUpperLmt_LTE[1]		= 0;
        ADDW     R12,R6,#+657
        MOVS     R2,#+0
        STRB     R2,[R12, #+1]
//  118 	Sts->Fwd1OutLowerLmt_LTE[0]		= FwdHighLmt_LTE - 10;
        MOVS     R2,#+2
        STRB     R2,[R12, #+2]
//  119 	Sts->Fwd1OutLowerLmt_LTE[1]		= 0;
        MOVS     R2,#+0
        STRB     R2,[R12, #+3]
//  120 	Sts->Fwd1GainSet_LTE 			= Gain_LTE1;
        MOVS     R2,#+146
        STRB     R2,[R12, #+4]
//  121 	Sts->Rvs1GainSet_LTE			= Gain_LTE1; 
        STRB     R2,[R12, #+14]
//  122 	Sts->Rvs1GainBalance_LTE 		= 0; 
        MOVS     R2,#+0
        STRB     R2,[R12, #+16]
//  123 	Sts->Fwd1OutHighLmt_LTE[0]		= FwdHighLmt_LTE+3;
        ADDW     R2,R6,#+794
        MOVS     R4,#+15
        STRB     R4,[R2, #+25]
//  124 	Sts->Fwd1OutHighLmt_LTE[1]		= 0; 
        MOVS     R4,#+0
        STRB     R4,[R2, #+26]
//  125 	Sts->Rvs1OutUpperLmt_LTE[0]		= 0;
        STRB     R4,[R2, #+17]
//  126 	Sts->Rvs1OutUpperLmt_LTE[1]		= 0;
        STRB     R4,[R2, #+18]
//  127 	Sts->Rvs1ALCLvl_LTE				= 0;
        STRB     R4,[R2, #+29]
//  128 
//  129 	
//  130 	Sts->Fwd1OutUpperLmt_LTE_A[0]	= FwdHighLmt_LTE_A;
        MOVS     R4,#+17
        STRB     R4,[R12, #+8]
//  131 	Sts->Fwd1OutUpperLmt_LTE_A[1]	= 0;
        MOVS     R4,#+0
        STRB     R4,[R12, #+9]
//  132 	Sts->Fwd1OutLowerLmt_LTE_A[0]	= FwdHighLmt_LTE_A - 10;
        MOVS     R4,#+7
        STRB     R4,[R12, #+10]
//  133 	Sts->Fwd1OutLowerLmt_LTE_A[1]	= 0;
        MOVS     R4,#+0
        STRB     R4,[R12, #+11]
//  134 	Sts->Fwd1GainSet_LTE_A			= Gain_LTE_A1;
        MOVS     R4,#+166
        STRB     R4,[R12, #+12]
//  135 	Sts->Rvs1GainSet_LTE_A			= Gain_LTE_A1; 
        STRB     R4,[R12, #+17]
//  136 	Sts->Rvs1GainBalance_LTE_A		= 0; 
        MOVS     R4,#+0
        STRB     R4,[R12, #+19]
//  137 	Sts->Fwd1OutHighLmt_LTE_A[0] 	= FwdHighLmt_LTE_A+3; 
        MOVS     R4,#+20
        STRB     R4,[R2, #+27]
//  138 	Sts->Fwd1OutHighLmt_LTE_A[1] 	= 0; 
        MOVS     R4,#+0
        STRB     R4,[R2, #+28]
//  139 
//  140 	Sts->Rvs1OutUpperLmt_LTE_A[0]	= 0;
        STRB     R4,[R2, #+19]
//  141 	Sts->Rvs1OutUpperLmt_LTE_A[1]	= 0;
        STRB     R4,[R2, #+20]
//  142 	Sts->Rvs1ALCLvl_LTE_A			= 0;
        STRB     R4,[R2, #+30]
//  143 
//  144 	Sts->AmpOffCase_3G				= 0; 
        STRB     R4,[R7, #+10]
//  145 	Sts->AmpOffCase_Common			= 0; 
        STRB     R4,[R7, #+11]
//  146 	Sts->AmpOffCase_LTE_A			= 0; 
        STRB     R4,[R7, #+12]
//  147 	Sts->BandSelect_15M 			= 0; 
        STRB     R4,[R7, #+16]
//  148 	Sts->AGCOnOff_3G				= Disable; 
        MOVS     R4,#+1
        STRB     R4,[R7, #+23]
//  149 	Sts->AGCOnOff_2G				= Disable; 
        STRB     R4,[R7, #+24]
//  150 	Sts->AGCOnOff_LTE				= Disable; 
        STRB     R4,[R7, #+27]
//  151 	Sts->AGCOnOff_LTE_A 			= Disable;
        STRB     R4,[R7, #+28]
//  152 	Sts->AGC1OnOff_LTE				= Disable;
        STRB     R4,[R7, #+31]
//  153 	Sts->AGC1OnOff_LTE_A			= Disable;
        STRB     R4,[R6, #+102]
//  154 	Sts->AGCMode_3G 				= 1;
        STRB     R4,[R7, #+25]
//  155 	Sts->AGCMode_2G 				= 1;
        STRB     R4,[R7, #+26]
//  156 	Sts->AGCMode_LTE				= 1;
        STRB     R4,[R7, #+29]
//  157 	Sts->AGCMode_LTE_A				= 1;
        STRB     R4,[R7, #+30]
//  158 	Sts->AutoReportPriod			= 0;
        MOVS     R4,#+0
        STRB     R4,[R7, #+18]
//  159 	Sts->AutoReportTime_H			= 0;
        STRB     R4,[R7, #+19]
//  160 	Sts->AutoReportTime_M			= 0;
        STRB     R4,[R7, #+20]
//  161 	Sts->TPTL_OnOff 				= 0;
        ADD      R7,R6,#+102
        STRB     R4,[R7, #+1]
//  162 	Sts->TempOffset 				= 0;
        STRB     R4,[R7, #+2]
//  163 	Sts->AlarmMask					= 0;
        STRB     R4,[R7, #+4]
//  164 	Sts->ModemOnOff 				= 0; 
        STRB     R4,[R6, #+143]
//  165 	Sts->VccDet_Lmt.Data			= 0; 
        STRH     R4,[R6, #+154]
//  166 	Sts->FwdInPwrOffset_2G			= 0; 
        STRB     R4,[R5, #+2]
//  167 	Sts->FwdInPwrOffset_3G			= 0; 
        STRB     R4,[R5, #+3]
//  168 	Sts->Rvs0OutPwrOffset_2G		= 0; 
        STRB     R4,[R5, #+4]
//  169 	Sts->Rvs0OutPwrOffset_3G		= 0; 
        STRB     R4,[R5, #+5]
//  170 	Sts->FwdOutPwrOffset_2G 		= 0; 
        STRB     R4,[R5, #+6]
//  171 	Sts->FwdOutPwrOffset_3G 		= 0; 
        STRB     R4,[R5, #+7]
//  172 	Sts->ResetPeriodCountSet[0] 	= 1; 
        MOVS     R7,#+1
        STRB     R7,[R6, #+188]
//  173 	Sts->ResetPeriodCountSet[1] 	= 0; 
        STRB     R4,[R0, #+1]
//  174 	Sts->ResetPeriodCountSet[2] 	= 0; 
        STRB     R4,[R0, #+2]
//  175 	Sts->FwdInPwrOffset_LTE 		= 0;
        STRB     R4,[R0, #+3]
//  176 	Sts->FwdOutPwrOffset_LTE		= 0;
        STRB     R4,[R0, #+4]
//  177 	Sts->RvsOutPwrOffset_LTE		= 0;
        STRB     R4,[R0, #+5]
//  178 	Sts->FwdGainOffset_3G			= 0;
        STRB     R4,[R0, #+19]
//  179 	Sts->RvsGainOffset_3G			= 0;
        STRB     R4,[R0, #+20]
//  180 	Sts->FwdGainOffset_2G			= 0;
        STRB     R4,[R0, #+21]
//  181 	Sts->RvsGainOffset_2G			= 0;
        STRB     R4,[R0, #+22]
//  182 
//  183 	{
//  184 
//  185 		Sts->DetOffset.FwdOutAvg_2G 	= 0;
        STRB     R4,[R6, #+319]
//  186 		Sts->DetOffset.FwdOutPeak_2G  	= 0;
        ADDW     R7,R6,#+319
        STRB     R4,[R7, #+1]
//  187 		Sts->DetOffset.FwdAgcAvg_2G  	= 0;
        STRB     R4,[R7, #+2]
//  188 		Sts->DetOffset.FwdAgcPeak_2G 	= 0;
        STRB     R4,[R7, #+3]
//  189 		Sts->DetOffset.FwdIn_Common  	= 0;
        STRB     R4,[R7, #+4]
//  190 		Sts->DetOffset.FwdOutAvg_Common = 0;
        STRB     R4,[R7, #+5]
//  191 		Sts->DetOffset.FwdOutPeak_Common= 0;
        STRB     R4,[R7, #+6]
//  192 		Sts->DetOffset.RvsIn_Common 	= 0;
        STRB     R4,[R7, #+7]
//  193 		Sts->DetOffset.RvsOut_Common  	= 0;
        STRB     R4,[R7, #+8]
//  194 		Sts->DetOffset.FwdOutAvg_LTE  	= 0;
        STRB     R4,[R7, #+9]
//  195 		Sts->DetOffset.FwdOutPeak_LTE  	= 0;
        STRB     R4,[R7, #+10]
//  196 		Sts->DetOffset.FwdAgcAvg_LTE  	= 0;
        STRB     R4,[R7, #+11]
//  197 		Sts->DetOffset.FwdAgcPeak_LTE 	= 0;
        STRB     R4,[R7, #+12]
//  198 		Sts->DetOffset.FwdOutAvg_LTE_A  = 0;
        STRB     R4,[R7, #+13]
//  199 		Sts->DetOffset.FwdOutPeak_LTE_A = 0;
        STRB     R4,[R7, #+14]
//  200 		Sts->DetOffset.FwdAgcAvg_LTE_A  = 0;
        STRB     R4,[R7, #+15]
//  201 		Sts->DetOffset.FwdAgcPeak_LTE_A = 0;
        STRB     R4,[R7, #+16]
//  202 		Sts->DetOffset.FwdOutAvg_3G  	= 0;
        STRB     R4,[R7, #+17]
//  203 		Sts->DetOffset.FwdOutPeak_3G  	= 0;
        STRB     R4,[R7, #+18]
//  204 		Sts->DetOffset.AgsVolt_Common  	= 0;
        STRB     R4,[R7, #+19]
//  205 		Sts->DetOffset.AgsVolt_LTE_A  	= 0;
        STRB     R4,[R7, #+20]
//  206 		Sts->DetOffset.AgsVolt_3G  		= 0;
        STRB     R4,[R7, #+21]
//  207 
//  208 
//  209 		Sts->Det1Offset.Fwd1OutAvg_LTE  = 0;
        STRB     R4,[R6, #+717]
//  210 		Sts->Det1Offset.Fwd1OutPeak_LTE  = 0;
        ADDW     R7,R6,#+717
        STRB     R4,[R7, #+1]
//  211 		Sts->Det1Offset.Fwd1AgcAvg_LTE   = 0;
        STRB     R4,[R7, #+2]
//  212 		Sts->Det1Offset.Fwd1AgcPeak_LTE  = 0;
        STRB     R4,[R7, #+3]
//  213 		Sts->Det1Offset.Fwd1OutAvg_LTE_A   = 0;
        STRB     R4,[R7, #+4]
//  214 		Sts->Det1Offset.Fwd1OutPeak_LTE_A   = 0;
        STRB     R4,[R7, #+5]
//  215 		Sts->Det1Offset.Fwd1AgcAvg_LTE_A   = 0;
        STRB     R4,[R7, #+6]
//  216 		Sts->Det1Offset.Fwd1AgcPeak_LTE_A   = 0;
        STRB     R4,[R7, #+7]
//  217 	}
//  218 
//  219 	Sts->FwdInPwrOffset_LTE_A		= 0; 
        STRB     R4,[R6, #+427]
//  220 	Sts->FwdOutPwrOffset_LTE_A		= 0; 
        STRB     R4,[R3, #+1]
//  221 	Sts->RvsOutPwrOffset_LTE_A		= 0; 
        STRB     R4,[R3, #+2]
//  222 	Sts->FwdGainOffset_LTE			= 0; 
        STRB     R4,[R6, #+460]
//  223 	Sts->RvsGainOffset_LTE			= 0; 
        ADD      R3,R6,#+460
        STRB     R4,[R3, #+1]
//  224 	Sts->FwdGainOffset_LTE_A		= 0; 
        STRB     R4,[R3, #+2]
//  225 	Sts->RvsGainOffset_LTE_A		= 0; 
        STRB     R4,[R3, #+3]
//  226 	Sts->FwdAgcAttn_2G				= 0; 
        STRB     R4,[R3, #+4]
//  227 	Sts->FwdAgcAttn_LTE 			= 0; 
        STRB     R4,[R3, #+5]
//  228 	Sts->FwdAgcAttn_LTE_A			= 0; 
        STRB     R4,[R3, #+6]
//  229 	Sts->FwdAgcAttn_3G				= 0; 
        STRB     R4,[R3, #+7]
//  230 	Sts->RvsAlcAttn_2G				= 0;
        STRB     R4,[R3, #+8]
//  231 	Sts->RvsAlcAttn_LTE 			= 0;
        STRB     R4,[R3, #+9]
//  232 	Sts->RvsAlcAttn_LTE_A			= 0;
        STRB     R4,[R3, #+10]
//  233 	Sts->RvsAlcAttn_3G				= 0;
        STRB     R4,[R3, #+11]
//  234 	Sts->RvsAlcOnOff_2G 			= Disable;
        MOVS     R7,#+1
        STRB     R7,[R3, #+12]
//  235 	Sts->RvsAlcOnOff_LTE			= Disable;
        STRB     R7,[R3, #+13]
//  236 	Sts->RvsAlcOnOff_LTE_A			= Disable;
        STRB     R7,[R3, #+14]
//  237 	Sts->RvsAlcOnOff_3G 			= Disable;
        STRB     R7,[R3, #+15]
//  238 
//  239 	Sts->RxMaxVal[0]				= 0;
        STRB     R4,[R6, #+572]
//  240 	Sts->RxMaxVal[1]				= 0;
        ADD      R3,R6,#+572
        STRB     R4,[R3, #+1]
//  241 	Sts->RxMinVal[0]				= 0;
        STRB     R4,[R3, #+2]
//  242 	Sts->RxMinVal[1]				= 0;
        STRB     R4,[R3, #+3]
//  243 	Sts->TxMaxVal[0]				= 0;
        STRB     R4,[R3, #+4]
//  244 	Sts->TxMaxVal[1]				= 0;
        STRB     R4,[R3, #+5]
//  245 	Sts->TxMinVal[0]				= 0;
        STRB     R4,[R3, #+6]
//  246 	Sts->TxMinVal[1]				= 0;
        STRB     R4,[R3, #+7]
//  247 	Sts->AdjMaxVal[0]				= 0;
        STRB     R4,[R3, #+8]
//  248 	Sts->AdjMaxVal[1]				= 0;
        STRB     R4,[R3, #+9]
//  249 	Sts->AdjMinVal[0]				= 0;
        STRB     R4,[R3, #+10]
//  250 	Sts->AdjMinVal[1]				= 0;
        STRB     R4,[R3, #+11]
//  251 	Sts->EcIo						= 0;
        STRB     R4,[R3, #+12]
//  252 	Sts->AR_Mode[0] 				= 0;
        STRB     R4,[R3, #+13]
//  253 	Sts->AR_Mode[1] 				= 0;
        STRB     R4,[R3, #+14]
//  254 	Sts->Radio_ReportTime[0]		= 0;
        STRB     R4,[R3, #+15]
//  255 	Sts->Radio_ReportTime[1]		= 0;
        STRB     R4,[R3, #+16]
//  256 	Sts->Radio_ReportPeriod[0]		= 0;
        STRB     R4,[R3, #+17]
//  257 	Sts->Radio_ReportPeriod[1]		= 0;
        STRB     R4,[R3, #+18]
//  258 	Sts->Amp1OffCase_LTE			= 0;
        STRB     R4,[R12, #+22]
//  259 	Sts->Amp1OffCase_LTE_A			= 0;
        STRB     R4,[R12, #+23]
//  260 	Sts->Fwd1InPwrOffset_LTE_A		= 0;
        STRB     R4,[R6, #+762]
//  261 	Sts->Fwd1OutPwrOffset_LTE_A 	= 0;
        ADDW     R3,R6,#+762
        STRB     R4,[R3, #+1]
//  262 	Sts->Rvs1OutPwrOffset_LTE_A 	= 0;
        STRB     R4,[R3, #+2]
//  263 	Sts->Fwd1GainOffset_LTE 		= 0;
        STRB     R4,[R3, #+27]
//  264 	Sts->Rvs1GainOffset_LTE 		= 0;
        STRB     R4,[R3, #+28]
//  265 	Sts->Fwd1GainOffset_LTE_A		= 0;
        STRB     R4,[R3, #+29]
//  266 	Sts->Rvs1GainOffset_LTE_A		= 0;
        STRB     R4,[R3, #+30]
//  267 	Sts->Fwd1AgcAttn_LTE			= 0;
        STRB     R4,[R3, #+31]
//  268 	Sts->Fwd1AgcAttn_LTE_A			= 0;
        STRB     R4,[R6, #+794]
//  269 	Sts->Rvs1AlcAttn_LTE			= 0;
        STRB     R4,[R2, #+1]
//  270 	Sts->Rvs1AlcAttn_LTE_A			= 0;
        STRB     R4,[R2, #+2]
//  271 	Sts->Rvs1AlcOnOff_LTE			= Disable;
        MOVS     R3,#+1
        STRB     R3,[R2, #+3]
//  272 	Sts->Rvs1AlcOnOff_LTE_A 		= Disable;
        STRB     R3,[R2, #+4]
//  273 	
//  274 	Sts->ShutDownOnOff_2G			= Disable;
        STRB     R3,[R0, #+14]
//  275 	Sts->ShutDownOnOff_3G			= Disable;
        STRB     R3,[R0, #+13]
//  276 
//  277 	Sts->ShutDownOnOff_LTE			= Disable;
        STRB     R3,[R6, #+495]
//  278 	Sts->ShutDownOnOff_LTE_A		= Disable;
        STRB     R3,[R1, #+1]
//  279 	Sts->ShutDownOnOff_LTE1			= Disable;
        STRB     R3,[R2, #+15]
//  280 	Sts->ShutDownOnOff_LTE_A1		= Disable;
        STRB     R3,[R2, #+16]
//  281 
//  282 	
//  283 	SaveBackupData();
        BL       SaveBackupData
//  284 
//  285 	{
//  286 		int i = 0;
//  287 		int j = 0;
//  288 
//  289 		for(j = 0; j < 24; j++)
        MOVW     R11,#+1954
        LDR.N    R6,??DefaultValueSet_0+0x4  ;; _AttInit
        MOV      R10,#+67
        LDR.W    R7,??DataTable7  ;; 0x8006800
//  290 		{
//  291 			__AttnOffsetTblStr *AttTblStr;
//  292 
//  293 			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
??DefaultValueSet_1:
        MOV      R0,R7
        BL       RoadBackuptobuffer
//  294 
//  295 
//  296 			AttTblStr = &tptr->_AttnTbl[j];
        MLA      R0,R4,R10,R0
        ADD      R1,R0,#+346
//  297 			AttTblStr->limit = (31.5 *2);
        MOVS     R0,#+63
        STRB     R0,[R1, #+0]
//  298 			AttTblStr->nsize = AttTBL_Size;
        MOVS     R0,#+64
        STRB     R0,[R1, #+1]
//  299 			{
//  300 				if( Sts->RvsAttn5_2G != 0)
        LDRB     R0,[R5, #+15]
        CBZ      R0,??DefaultValueSet_2
//  301 				{
//  302 					INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  303 					INT8U *stptr = (INT8U *)_AttInit2;
//  304 						
//  305 					for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
        MOVS     R0,#+0
        ADDS     R2,R1,#+2
??DefaultValueSet_3:
        ADDS     R3,R0,R6
        LDRB     R3,[R3, #+68]
        STRB     R3,[R2], #+1
        ADDS     R0,R0,#+1
        LDRB     R3,[R1, #+1]
        CMP      R0,R3
        BGE.N    ??DefaultValueSet_4
        B.N      ??DefaultValueSet_3
//  306 				}
//  307 				else
//  308 				{
//  309 					INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  310 					INT8U *stptr = (INT8U *)_AttInit;
//  311 						
//  312 					for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
??DefaultValueSet_2:
        ADDS     R2,R1,#+2
??DefaultValueSet_5:
        LDRB     R3,[R0, R6]
        STRB     R3,[R2], #+1
        ADDS     R0,R0,#+1
        LDRB     R3,[R1, #+1]
        CMP      R0,R3
        BLT.N    ??DefaultValueSet_5
//  313 				}
//  314 			}
//  315 
//  316 			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
??DefaultValueSet_4:
        MOV      R1,R11
        MOV      R0,R7
        BL       WriteBuffertoBackup
//  317 		}
        ADDS     R4,R4,#+1
        CMP      R4,#+24
        BLT.N    ??DefaultValueSet_1
//  318 
//  319 		for(j = 0; j < 12; j++)
        MOVS     R4,#+0
        LDR.W    R9,??DataTable6  ;; 0x8006000
//  320 		{
//  321 			__AttnOffsetTblStr *AttTblStr;
//  322 		
//  323 			EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
??DefaultValueSet_6:
        MOV      R0,R9
        BL       RoadBackuptobuffer
//  324 		
//  325 			AttTblStr = &tptr->_Attn1Tbl[j];
        MLA      R0,R4,R10,R0
        ADDW     R1,R0,#+1234
//  326 			AttTblStr->limit = (31.5 *2);
        MOVS     R0,#+63
        STRB     R0,[R1, #+0]
//  327 			AttTblStr->nsize = AttTBL_Size;
        MOVS     R0,#+64
        STRB     R0,[R1, #+1]
//  328 			{
//  329 
//  330 				if(Sts->RvsAttn5_2G != 0)
        LDRB     R0,[R5, #+15]
        CBZ      R0,??DefaultValueSet_7
//  331 				{
//  332 					INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  333 					INT8U *stptr = (INT8U *)_AttInit2;
//  334 						
//  335 					for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
        MOVS     R0,#+0
        ADDS     R2,R1,#+2
??DefaultValueSet_8:
        ADDS     R3,R0,R6
        LDRB     R3,[R3, #+68]
        STRB     R3,[R2], #+1
        ADDS     R0,R0,#+1
        LDRB     R3,[R1, #+1]
        CMP      R0,R3
        BGE.N    ??DefaultValueSet_9
        B.N      ??DefaultValueSet_8
//  336 				}
//  337 				else
//  338 				{
//  339 					INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  340 					INT8U *stptr = (INT8U *)_AttInit;
//  341 						
//  342 					for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
??DefaultValueSet_7:
        ADDS     R2,R1,#+2
??DefaultValueSet_10:
        LDRB     R3,[R0, R6]
        STRB     R3,[R2], #+1
        ADDS     R0,R0,#+1
        LDRB     R3,[R1, #+1]
        CMP      R0,R3
        BLT.N    ??DefaultValueSet_10
//  343 
//  344 				}
//  345 			}
//  346 		
//  347 			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
??DefaultValueSet_9:
        MOVW     R1,#+2038
        MOV      R0,R9
        BL       WriteBuffertoBackup
//  348 		}
        ADDS     R4,R4,#+1
        CMP      R4,#+12
        BLT.N    ??DefaultValueSet_6
//  349 
//  350 		for(j = 0; j < 12; j++)
        MOVS     R4,#+0
        MOV      R9,#+28
//  351 		{
//  352 			__AttnTempTblStr *AttTblStr;
//  353 		
//  354 			EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
??DefaultValueSet_11:
        MOV      R0,R7
        BL       RoadBackuptobuffer
//  355 		
//  356 			AttTblStr = &tptr->_TptlAttnTbl[j];
        MLA      R0,R4,R9,R0
        ADD      R1,R0,#+10
//  357 			AttTblStr->limit = Temp_limit;
        MOVS     R0,#+90
        STRB     R0,[R1, #+0]
//  358 			AttTblStr->nsize = TempTBL_Size;
        MOVS     R0,#+25
        STRB     R0,[R1, #+1]
//  359 
//  360 			if(Sts->RvsAttn5_2G != 0)
        LDRB     R0,[R5, #+15]
        CBZ      R0,??DefaultValueSet_12
//  361 			{
//  362 				INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  363 				INT8U *stptr = (INT8U *)_TempInit1;
//  364 					
//  365 				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
        MOVS     R0,#+0
        ADDS     R2,R1,#+2
??DefaultValueSet_13:
        ADDS     R3,R0,R6
        LDRB     R3,[R3, #+164]
        STRB     R3,[R2], #+1
        ADDS     R0,R0,#+1
        LDRB     R3,[R1, #+1]
        CMP      R0,R3
        BGE.N    ??DefaultValueSet_14
        B.N      ??DefaultValueSet_13
//  366 			}
//  367 			else
//  368 			{
//  369 				INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  370 				INT8U *stptr = (INT8U *)_TempInit;
//  371 					
//  372 				for(i = 0; i < AttTblStr->nsize; i++) dsptr[i] = stptr[i];
??DefaultValueSet_12:
        ADDS     R2,R1,#+2
??DefaultValueSet_15:
        ADDS     R3,R0,R6
        LDRB     R3,[R3, #+136]
        STRB     R3,[R2], #+1
        ADDS     R0,R0,#+1
        LDRB     R3,[R1, #+1]
        CMP      R0,R3
        BLT.N    ??DefaultValueSet_15
//  373 			}
//  374 
//  375 			WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
??DefaultValueSet_14:
        MOV      R1,R11
        MOV      R0,R7
        BL       WriteBuffertoBackup
//  376 		}
        ADDS     R4,R4,#+1
        CMP      R4,#+12
        BLT.N    ??DefaultValueSet_11
//  377 //////////////////////////////////////////////
//  378 
//  379 		for(j = 0; j < 28; j++)
        MOVS     R5,#+0
        MOVW     R9,#+2020
        MOVS     R7,#+72
        LDR.W    R4,??DataTable3  ;; 0x8005800
//  380 		{
//  381 			__OutputTblStr *TblStr;
//  382 			EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);
??DefaultValueSet_16:
        MOV      R0,R4
        BL       RoadBackuptobuffer
//  383 
//  384 			TblStr = &(tptr->OutputTbl[j]);
        MLA      R0,R5,R7,R0
        ADDS     R1,R0,#+2
//  385 			TblStr->limit = 20*2;
        MOVS     R0,#+40
        STRB     R0,[R1, #+0]
//  386 			TblStr->nsize = OutputTBL_Size;
        MOVS     R0,#+35
        STRB     R0,[R1, #+1]
//  387 			{
//  388 				INT16U *dsptr = (INT16U *)TblStr->Data;
//  389 				INT16U *stptr = (INT16U *)PwrInit;
//  390 				for(i = 0; i < TblStr->nsize; i++)	dsptr[i] = stptr[i];
        MOVS     R0,#+0
        ADDS     R2,R1,#+2
        ADD      R3,R6,#+192
??DefaultValueSet_17:
        LDRH     R12,[R3], #+2
        STRH     R12,[R2], #+2
        ADDS     R0,R0,#+1
        LDRB     R12,[R1, #+1]
        CMP      R0,R12
        BLT.N    ??DefaultValueSet_17
//  391 			}
//  392 
//  393 			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
        MOV      R1,R9
        MOV      R0,R4
        BL       WriteBuffertoBackup
//  394 		}
        ADDS     R5,R5,#+1
        CMP      R5,#+28
        BLT.N    ??DefaultValueSet_16
//  395 	}
//  396 	OS_EXIT_CRITICAL();
        MOV      R0,R8
        POP      {R1,R4-R11,LR}
        B.W      OS_CPU_SR_Restore
        Nop      
        DATA
??DefaultValueSet_0:
        DC32     tDnrSts
        DC32     _AttInit
//  397 }
//  398 
//  399 
//  400 
//  401 
//  402 
//  403 #ifdef __1stType
//  404 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  405 void Response_Table_DE(__ProtocolPtr *nPtr)
//  406 {
Response_Table_DE:
        PUSH     {R0,R4-R11,LR}
        SUB      SP,SP,#+16
//  407 	INT8U TblID = 0;
//  408 	INT8S tIndex = 0;
//  409 
//  410 	INT8U Comm;
//  411 	
//  412 	INT8S tlimit;
//  413 	INT8U tsize;
//  414 	INT32U tbllen = 0;		//, mlen = 0;
//  415 	INT32U i = 0;
//  416 
//  417 	__WRCSSIO *Recv = nPtr->WRCSRecv;
        LDR      R0,[R0, #+28]
//  418 	__WRCSSIO *Send = nPtr->WRCSSend;
        LDR      R1,[SP, #+16]
        LDR      R1,[R1, #+32]
        STR      R1,[SP, #+12]
//  419 
//  420 
//  421     __BODYFRAME *rBody = &Recv->BodyFrame[Recv->cBody];
        LDRB     R1,[R0, #+1723]
        MOV      R2,#+1712
        MULS     R1,R1,R2
        ADDS     R0,R1,R0
        ADD      R6,R0,#+8
//  422     __BODYFRAME *sBody = &Send->BodyFrame[Recv->cBody];
        LDR      R0,[SP, #+12]
        ADDS     R0,R1,R0
        ADD      R4,R0,#+8
//  423 
//  424 	Comm = rBody->Command;
        LDRB     R0,[R6, #+3]
        STR      R0,[SP, #+0]
//  425 	TblID = rBody->SubData[0];
        LDRB     R5,[R6, #+7]
//  426 	
//  427 	INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};
        LDRB     R0,[R6, #+0]
        STRB     R0,[SP, #+4]
        ADD      R0,SP,#+4
        LDRB     R1,[R6, #+1]
        STRB     R1,[R0, #+1]
        LDRB     R1,[R6, #+2]
        STRB     R1,[R0, #+2]
//  428 
//  429 	if( (tIndex = TableIndex(TblID)) == -1) return;
        MOV      R0,R5
        BL       TableIndex
        MOV      R1,R0
        MOV      R2,#-1
        CMP      R0,R2
        BEQ.W    ??Response_Table_DE_1
//  430 
//  431 	switch(TblID)	//command üũ
        SUBS     R0,R5,#+1
        CMP      R0,#+137
        BHI.W    ??Response_Table_DE_2
        TBH      [PC, R0, LSL #+1]
        DATA
??Response_Table_DE_0:
        DC16     +138,+138,+138,+222
        DC16     +138,+138,+138,+222
        DC16     +138,+514,+138,+138
        DC16     +138,+138,+138,+222
        DC16     +138,+138,+138,+138
        DC16     +138,+138,+138,+138
        DC16     +222,+138,+138,+138
        DC16     +138,+138,+138,+222
        DC16     +138,+306,+306,+514
        DC16     +514,+306,+306,+306
        DC16     +514,+514,+306,+306
        DC16     +514,+514,+306,+306
        DC16     +306,+306,+514,+306
        DC16     +306,+514,+514,+306
        DC16     +306,+306,+306,+514
        DC16     +306,+306,+514,+514
        DC16     +306,+306,+306,+306
        DC16     +514,+306,+514,+514
        DC16     +306,+514,+514,+514
        DC16     +447,+447,+447,+447
        DC16     +447,+447,+447,+447
        DC16     +138,+138,+514,+514
        DC16     +514,+514,+514,+514
        DC16     +514,+514,+514,+514
        DC16     +514,+514,+514,+514
        DC16     +222,+138,+138,+222
        DC16     +138,+138,+138,+138
        DC16     +138,+138,+222,+138
        DC16     +138,+138,+377,+377
        DC16     +514,+514,+377,+377
        DC16     +377,+377,+514,+377
        DC16     +377,+514,+514,+377
        DC16     +377,+377,+514,+514
        DC16     +447,+447,+447,+447
        DC16     +138,+138
        THUMB
//  432 	{
//  433 		case Index_FwdInPwr_2G			:
//  434 		case Index_FwdOutAvgPwr_2G		:
//  435 		case Index_FwdOutPeakPwr_2G 	:
//  436 		case Index_RvsOutPwr_2G 		:
//  437 		case Index_FwdAgcAvgPwr_2G		:
//  438 		case Index_FwdAgcPeakPwr_2G 	:
//  439 		case Index_FwdOutAvgPwr_Common 	:
//  440 		case Index_RvsInPwr_Common		:
//  441 		case Index_RvsOutPwr_Common 	:
//  442 		case Index_FwdInPwr_LTE 		:
//  443 		case Index_FwdOutAvgPwr_LTE 	:
//  444 		case Index_FwdOutPeakPwr_LTE	:
//  445 		case Index_RvsOutPwr_LTE		:
//  446 		case Index_Fwd15MOutAvgPwr_LTE	:
//  447 		case Index_Fwd15MOutPeakPwr_LTE :
//  448 		case Index_FwdAgcAvgPwr_LTE 	:
//  449 		case Index_FwdAgcPeakPwr_LTE	:
//  450 		case Index_FwdInPwr_LTE_A		:
//  451 		case Index_FwdOutAvgPwr_LTE_A	:
//  452 		case Index_FwdOutPeakPwr_LTE_A	:
//  453 		case Index_RvsOutPwr_LTE_A		:
//  454 		case Index_FwdAgcAvgPwr_LTE_A	:
//  455 		case Index_FwdAgcPeakPwr_LTE_A	:
//  456 		case Index_FwdInPwr_3G			:
//  457 		case Index_FwdOutAvgPwr_3G		:
//  458 		case Index_FwdOutPeakPwr_3G 	:
//  459 		case Index_RvsOutPwr_3G 		:
//  460 		case Index_OtherRvsInPwr_3G 	:
//  461 		case Index_OtherRvsInPwr_LTE_A	:
//  462 			
//  463 		case Index_Fwd1OutAvgPwr_LTE	:
//  464 		case Index_Fwd1OutPeakPwr_LTE	:
//  465 		case Index_Rvs1OutPwr_LTE		:
//  466 		case Index_Fwd1AgcAvgPwr_LTE	:
//  467 		case Index_Fwd1AgcPeakPwr_LTE	:
//  468 		case Index_Fwd1InPwr_LTE_A		:
//  469 		case Index_Fwd1OutAvgPwr_LTE_A	:
//  470 		case Index_Fwd1OutPeakPwr_LTE_A :
//  471 		case Index_Rvs1OutPwr_LTE_A 	:
//  472 		case Index_Fwd1AgcAvgPwr_LTE_A	:
//  473 		case Index_Fwd1AgcPeakPwr_LTE_A :
//  474 		case Index_OtherRvs1InPwr_LTE	:
//  475 		case Index_OtherRvs1InPwr_LTE_A :
//  476 		{
//  477 			__OutputTblStr *TblStr;
//  478 			
//  479 			if( Comm == DDRTableSetQue)
??Response_Table_DE_3:
        MOVS     R0,#+72
        MUL      R9,R1,R0
        LDR      R0,[SP, #+0]
        UXTB     R0,R0
        CMP      R0,#+117
        BNE.N    ??Response_Table_DE_4
//  480 			{
//  481 				INT32U cpu_sr;
//  482 				OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R10,R0
//  483 
//  484 				{
//  485 					EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr);
        LDR.W    R8,??DataTable3  ;; 0x8005800
        MOV      R0,R8
        BL       RoadBackuptobuffer
//  486 
//  487 					TblStr = &(tptr->OutputTbl[tIndex]);
        ADD      R0,R9,R0
//  488 					tlimit = TblStr->limit = rBody->SubData[1];
        LDRSB    R1,[R6, #+8]
        STRB     R1,[R0, #+2]!
//  489 					tsize = TblStr->nsize = rBody->SubData[2];
        LDRB     R1,[R6, #+9]
        STRB     R1,[R0, #+1]
//  490 
//  491 					if( tsize > OutputTBL_Size)  tsize = OutputTBL_Size; 
        CMP      R1,#+36
        BCC.N    ??Response_Table_DE_5
        MOVS     R1,#+35
//  492 
//  493 					tbllen = (tsize*2); // data type: int16!!
??Response_Table_DE_5:
        LSLS     R1,R1,#+1
//  494 
//  495 					{
//  496 						INT16U *dsptr = (INT16U *)TblStr->Data;
        ADDS     R0,R0,#+2
        STR      R0,[SP, #+8]
//  497 						INT16U *stptr = (INT16U *)&rBody->SubData[3];
        ADD      R11,R6,#+10
//  498 						for(i = 0; i < tbllen/2 && i < (OutputTBL_Size); i++)
        MOVS     R6,#+0
        LSRS     R7,R1,#+1
        B.N      ??Response_Table_DE_6
//  499 						{
//  500 							dsptr[i] = swab16(stptr[i]);
??Response_Table_DE_7:
        LDRH     R0,[R11, R6, LSL #+1]
        BL       __fswab16
        LDR      R1,[SP, #+8]
        STRH     R0,[R1, R6, LSL #+1]
//  501 						}
        ADDS     R6,R6,#+1
??Response_Table_DE_6:
        CMP      R6,R7
        BCS.N    ??Response_Table_DE_8
        CMP      R6,#+35
        BCC.N    ??Response_Table_DE_7
//  502 					}
//  503 
//  504 					WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
??Response_Table_DE_8:
        MOVW     R1,#+2020
        MOV      R0,R8
        BL       WriteBuffertoBackup
//  505 				}
//  506 				OS_EXIT_CRITICAL();
        MOV      R0,R10
        BL       OS_CPU_SR_Restore
//  507 			}
//  508 			{
//  509 				TblStr = &(vEE_TABLE->OutputTbl[tIndex]);
??Response_Table_DE_4:
        LDR.N    R0,??Response_Table_DE_9  ;; 0x8005802
        ADD      R2,R9,R0
//  510 
//  511 				tlimit = TblStr->limit;
        LDRSB    R3,[R2, #+0]
//  512 				tsize  = TblStr->nsize;
        LDRB     R1,[R2, #+1]
//  513 				if( tsize > OutputTBL_Size)  tsize = OutputTBL_Size; 
        CMP      R1,#+36
        BCC.N    ??Response_Table_DE_10
        MOVS     R1,#+35
//  514 				tbllen = (tsize*2); // data type: int16!!
??Response_Table_DE_10:
        LSLS     R0,R1,#+1
//  515 
//  516 					
//  517 				sBody->SubData[0] = TblID;
        STRB     R5,[R4, #+7]
//  518 				sBody->SubData[1] = tlimit;
        STRB     R3,[R4, #+8]
//  519 				sBody->SubData[2] = tsize;
        STRB     R1,[R4, #+9]
//  520 				{
//  521 					INT16U *dsptr = (INT16U *)&sBody->SubData[3];
        ADDS     R4,R4,#+10
//  522 					INT16U *stptr = (INT16U *)TblStr->Data;
        ADDS     R5,R2,#+2
//  523 
//  524 					for(i = 0; i < tbllen/2 && i < (OutputTBL_Size); i++)
        MOVS     R7,#+0
        LSRS     R6,R0,#+1
??Response_Table_DE_11:
        CMP      R7,R6
        BCS.W    ??Response_Table_DE_2
        CMP      R7,#+35
        BCS.W    ??Response_Table_DE_2
//  525 					{
//  526 						dsptr[i] = swab16(stptr[i]);
        LDRH     R0,[R5, R7, LSL #+1]
        BL       __fswab16
        STRH     R0,[R4, R7, LSL #+1]
//  527 					}
        ADDS     R7,R7,#+1
        B.N      ??Response_Table_DE_11
//  528 				}
//  529 			}
//  530 		}
//  531 		break;
//  532 
//  533 		case Index_RvsInPwr_2G			:
//  534 		case Index_FwdInPwr_Common		:
//  535 		case Index_RvsInPwr_LTE 		:
//  536 		case Index_RvsInPwr_LTE_A		:
//  537 		case Index_RvsInPwr_3G			:
//  538 		case Index_Fwd1InPwr_LTE		:
//  539 		case Index_Rvs1InPwr_LTE		:
//  540 		case Index_Rvs1InPwr_LTE_A		:
//  541 
//  542 		{
//  543 			__Output1TblStr *TblStr;
//  544 			
//  545 			if( Comm == DDRTableSetQue)
??Response_Table_DE_12:
        MOVS     R0,#+126
        MUL      R10,R1,R0
        LDR      R0,[SP, #+0]
        UXTB     R0,R0
        CMP      R0,#+117
        BNE.N    ??Response_Table_DE_13
//  546 			{
//  547 				INT32U cpu_sr;
//  548 				OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  549 
//  550 				{
//  551 					EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.W    R9,??DataTable6  ;; 0x8006000
        MOV      R0,R9
        BL       RoadBackuptobuffer
//  552  
//  553 					TblStr = &(tptr->OutputTbl[tIndex]);
        ADD      R0,R10,R0
//  554 					tlimit = TblStr->limit = rBody->SubData[1];
        LDRSB    R1,[R6, #+8]
        STRB     R1,[R0, #+226]!
//  555 					tsize = TblStr->nsize = rBody->SubData[2];
        LDRB     R1,[R6, #+9]
        STRB     R1,[R0, #+1]
//  556 
//  557 					if( tsize > OutputTBL_Size)  tsize = OutputTBL_Size; 
        CMP      R1,#+36
        BCC.N    ??Response_Table_DE_14
        MOVS     R1,#+35
//  558 
//  559 					tbllen = (tsize*2); // data type: int16!!
??Response_Table_DE_14:
        LSLS     R1,R1,#+1
//  560 
//  561 					{
//  562 						INT16U *dsptr = (INT16U *)TblStr->Data;
        ADDS     R0,R0,#+2
        STR      R0,[SP, #+8]
//  563 						INT16U *stptr = (INT16U *)&rBody->SubData[3];
        ADD      R11,R6,#+10
//  564 						for(i = 0; i < tbllen/2 && i < (OutputTBL_Size); i++)
        MOVS     R6,#+0
        LSRS     R7,R1,#+1
        B.N      ??Response_Table_DE_15
//  565 						{
//  566 							dsptr[i] = swab16(stptr[i]);
??Response_Table_DE_16:
        LDRH     R0,[R11, R6, LSL #+1]
        BL       __fswab16
        LDR      R1,[SP, #+8]
        STRH     R0,[R1, R6, LSL #+1]
//  567 						}
        ADDS     R6,R6,#+1
??Response_Table_DE_15:
        CMP      R6,R7
        BCS.N    ??Response_Table_DE_17
        CMP      R6,#+35
        BCC.N    ??Response_Table_DE_16
//  568 					}
//  569 
//  570 					WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
??Response_Table_DE_17:
        MOVW     R1,#+2038
        MOV      R0,R9
        BL       WriteBuffertoBackup
//  571 				}
//  572 				OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  573 			}
//  574 			{
//  575 				TblStr = &(vEE_BACK1->OutputTbl[tIndex]);
??Response_Table_DE_13:
        LDR.N    R0,??Response_Table_DE_9+0x4  ;; 0x80060e2
        ADD      R2,R10,R0
//  576 
//  577 				tlimit = TblStr->limit;
        LDRSB    R3,[R2, #+0]
//  578 				tsize  = TblStr->nsize;
        LDRB     R1,[R2, #+1]
//  579 				if( tsize > OutputTBL_Size)  tsize = OutputTBL_Size; 
        CMP      R1,#+36
        BCC.N    ??Response_Table_DE_18
        MOVS     R1,#+35
//  580 				tbllen = (tsize*2); // data type: int16!!
??Response_Table_DE_18:
        LSLS     R0,R1,#+1
//  581 
//  582 					
//  583 				sBody->SubData[0] = TblID;
        STRB     R5,[R4, #+7]
//  584 				sBody->SubData[1] = tlimit;
        STRB     R3,[R4, #+8]
//  585 				sBody->SubData[2] = tsize;
        STRB     R1,[R4, #+9]
//  586 				{
//  587 					INT16U *dsptr = (INT16U *)&sBody->SubData[3];
        ADDS     R4,R4,#+10
//  588 					INT16U *stptr = (INT16U *)TblStr->Data;
        ADDS     R5,R2,#+2
//  589 
//  590 					for(i = 0; i < tbllen/2 && i < (OutputTBL_Size); i++)
        MOVS     R7,#+0
        LSRS     R6,R0,#+1
??Response_Table_DE_19:
        CMP      R7,R6
        BCS.W    ??Response_Table_DE_2
        CMP      R7,#+35
        BCS.W    ??Response_Table_DE_2
//  591 					{
//  592 						dsptr[i] = swab16(stptr[i]);
        LDRH     R0,[R5, R7, LSL #+1]
        BL       __fswab16
        STRH     R0,[R4, R7, LSL #+1]
//  593 					}
        ADDS     R7,R7,#+1
        B.N      ??Response_Table_DE_19
//  594 				}
//  595 			}
//  596 		}
//  597 		break;
//  598 				
//  599 		
//  600 		case Index_FwdAttn1_2G	 :
//  601 		case Index_FwdAttn2_2G	 :
//  602 		case Index_RvsAttn1_2G	 :
//  603 		case Index_RvsAttn2_2G	 :
//  604 		case Index_RvsAttn3_2G	 :
//  605 		case Index_FwdAttn1_LTE  :
//  606 		case Index_FwdAttn2_LTE  :
//  607 		case Index_RvsAttn1_LTE  :
//  608 		case Index_RvsAttn2_LTE  :
//  609 		case Index_RvsAttn3_LTE  :
//  610 		case Index_RvsAttn4_LTE  :
//  611 		case Index_FwdAttn1_LTE_A  :
//  612 		case Index_FwdAttn2_LTE_A  :
//  613 		case Index_RvsAttn1_LTE_A  :
//  614 		case Index_RvsAttn2_LTE_A  :
//  615 		case Index_RvsAttn3_LTE_A  :
//  616 		case Index_RvsAttn4_LTE_A  :
//  617 		case Index_FwdAttn1_3G	 :
//  618 		case Index_FwdAttn2_3G	 :
//  619 		case Index_RvsAttn1_3G	 :
//  620 		case Index_RvsAttn2_3G	 :
//  621 		case Index_RvsAttn3_3G	 :
//  622 		case Index_RvsAttn4_3G	 :
//  623 		case Index_FwdAttn1_Common :
//  624 		case Index_RvsAttn1_Common :
//  625 		{
//  626 			__AttnOffsetTblStr *AttTblStr;
//  627 
//  628 			if( Comm == DDRTableSetQue)
??Response_Table_DE_20:
        MOVS     R0,#+67
        MUL      R10,R1,R0
        LDR      R0,[SP, #+0]
        UXTB     R0,R0
        CMP      R0,#+117
        BNE.N    ??Response_Table_DE_21
//  629 			{
//  630 				INT32U cpu_sr;
//  631 				OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  632 				{
//  633 					EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
        LDR.W    R9,??DataTable7  ;; 0x8006800
        MOV      R0,R9
        BL       RoadBackuptobuffer
//  634 					AttTblStr = &tptr->_AttnTbl[tIndex];
        ADD      R0,R10,R0
        ADD      R0,R0,#+346
//  635 					tlimit = AttTblStr->limit = rBody->SubData[1];
        LDRSB    R1,[R6, #+8]
        STRB     R1,[R0, #+0]
//  636 					//tlimit = AttTblStr->limit = 0;
//  637 					tsize = AttTblStr->nsize = rBody->SubData[2];
        LDRB     R1,[R6, #+9]
        STRB     R1,[R0, #+1]
//  638 					if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 
        CMP      R1,#+65
        BCC.N    ??Response_Table_DE_22
        MOVS     R1,#+64
//  639 
//  640 					tbllen = (tsize*1); // data type: int16!!
//  641 					{
//  642 						INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  643 						INT8U *stptr = (INT8U *)&rBody->SubData[3];
//  644 						
//  645 						for(i = 0; i < tbllen && i < (AttTBL_Size); i++)
??Response_Table_DE_22:
        MOVS     R7,#+0
        ADDS     R0,R0,#+2
        ADD      R2,R6,#+10
        B.N      ??Response_Table_DE_23
//  646 						{
//  647 							dsptr[i] = (stptr[i]);
??Response_Table_DE_24:
        LDRB     R3,[R2], #+1
        STRB     R3,[R0], #+1
//  648 						}
        ADDS     R7,R7,#+1
??Response_Table_DE_23:
        CMP      R7,R1
        BCS.N    ??Response_Table_DE_25
        CMP      R7,#+64
        BCC.N    ??Response_Table_DE_24
//  649 					}
//  650 					WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
??Response_Table_DE_25:
        MOVW     R1,#+1954
        MOV      R0,R9
        BL       WriteBuffertoBackup
//  651 				}
//  652 				OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  653 			}
//  654 			{
//  655 				AttTblStr = &vEE_TABLE1->_AttnTbl[tIndex];
??Response_Table_DE_21:
        LDR.N    R0,??Response_Table_DE_9+0x8  ;; 0x800695a
        ADD      R2,R10,R0
//  656 
//  657 				//tlimit = AttTblStr->limit = 0;
//  658 				tlimit = AttTblStr->limit;
        LDRSB    R3,[R2, #+0]
//  659 				if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 
//  660 				tsize = AttTblStr->nsize;
        LDRB     R1,[R2, #+1]
//  661 
//  662 				tbllen = (tsize*1); // data type: int16!!
        MOVS     R0,R1
//  663 
//  664 				sBody->SubData[0] = TblID;
        STRB     R5,[R4, #+7]
//  665 				sBody->SubData[1] = tlimit;
        STRB     R3,[R4, #+8]
//  666 				sBody->SubData[2] = tsize;
        STRB     R1,[R4, #+9]
//  667 				{
//  668 					INT8U *dsptr = (INT8U *)&sBody->SubData[3];
//  669 					INT8U *stptr = (INT8U *)AttTblStr->Data;
//  670 					
//  671 					for(i = 0; i < tbllen ; i++)
        BEQ.W    ??Response_Table_DE_2
        ADD      R1,R4,#+10
        ADDS     R2,R2,#+2
//  672 					{
//  673 						dsptr[i] = stptr[i];
??Response_Table_DE_26:
        LDRB     R3,[R2], #+1
        STRB     R3,[R1], #+1
//  674 					}
        SUBS     R0,R0,#+1
        BEQ.W    ??Response_Table_DE_2
        B.N      ??Response_Table_DE_26
//  675 				}
//  676 			}
//  677 		}
//  678 		break;
//  679 		
//  680 		case Index_Fwd1Attn1_LTE	:
//  681 		case Index_Fwd1Attn2_LTE	:
//  682 		case Index_Rvs1Attn1_LTE	:
//  683 		case Index_Rvs1Attn2_LTE	:
//  684 		case Index_Rvs1Attn3_LTE	:
//  685 		case Index_Rvs1Attn4_LTE	:
//  686 		case Index_Fwd1Attn1_LTE_A	:
//  687 		case Index_Fwd1Attn2_LTE_A	:
//  688 		case Index_Rvs1Attn1_LTE_A	:
//  689 		case Index_Rvs1Attn2_LTE_A	:
//  690 		case Index_Rvs1Attn3_LTE_A	:
//  691 		{
//  692 			__AttnOffsetTblStr *AttTblStr;
//  693 
//  694 			if( Comm == DDRTableSetQue)
??Response_Table_DE_27:
        MOVS     R0,#+67
        MUL      R10,R1,R0
        LDR      R0,[SP, #+0]
        UXTB     R0,R0
        CMP      R0,#+117
        BNE.N    ??Response_Table_DE_28
//  695 			{
//  696 				INT32U cpu_sr;
//  697 				OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  698 				{
//  699 					EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.W    R9,??DataTable6  ;; 0x8006000
        MOV      R0,R9
        BL       RoadBackuptobuffer
//  700 					AttTblStr = &tptr->_Attn1Tbl[tIndex];
        ADD      R0,R10,R0
        ADDW     R0,R0,#+1234
//  701 					//tlimit = AttTblStr->limit = rBody->SubData[1];
//  702 					tlimit = AttTblStr->limit = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  703 					tsize = AttTblStr->nsize = rBody->SubData[2];
        LDRB     R1,[R6, #+9]
        STRB     R1,[R0, #+1]
//  704 					if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 
        CMP      R1,#+65
        BCC.N    ??Response_Table_DE_29
        MOVS     R1,#+64
//  705 
//  706 					tbllen = (tsize*1); // data type: int16!!
//  707 					{
//  708 						INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  709 						INT8U *stptr = (INT8U *)&rBody->SubData[3];
//  710 						
//  711 						for(i = 0; i < tbllen && i < (AttTBL_Size); i++)
??Response_Table_DE_29:
        MOVS     R7,#+0
        ADDS     R0,R0,#+2
        ADD      R2,R6,#+10
        B.N      ??Response_Table_DE_30
//  712 						{
//  713 							dsptr[i] = (stptr[i]);
??Response_Table_DE_31:
        LDRB     R3,[R2], #+1
        STRB     R3,[R0], #+1
//  714 						}
        ADDS     R7,R7,#+1
??Response_Table_DE_30:
        CMP      R7,R1
        BCS.N    ??Response_Table_DE_32
        CMP      R7,#+64
        BCC.N    ??Response_Table_DE_31
//  715 					}
//  716 					WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
??Response_Table_DE_32:
        MOVW     R1,#+2038
        MOV      R0,R9
        BL       WriteBuffertoBackup
//  717 				}
//  718 				OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  719 			}
//  720 			{
//  721 				AttTblStr = &vEE_BACK1->_Attn1Tbl[tIndex];
??Response_Table_DE_28:
        LDR.N    R0,??Response_Table_DE_9+0xC  ;; 0x80064d2
        ADD      R2,R10,R0
//  722 
//  723 				tlimit = AttTblStr->limit = 0;
        MOVS     R0,#+0
        STRB     R0,[R2, #+0]
//  724 				if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 
//  725 				tsize = AttTblStr->nsize;
        LDRB     R1,[R2, #+1]
//  726 
//  727 				tbllen = (tsize*1); // data type: int16!!
        MOV      R0,R1
//  728 
//  729 				sBody->SubData[0] = TblID;
        STRB     R5,[R4, #+7]
//  730 				sBody->SubData[1] = tlimit;
        MOVS     R3,#+0
        STRB     R3,[R4, #+8]
//  731 				sBody->SubData[2] = tsize;
        STRB     R1,[R4, #+9]
//  732 				{
//  733 					INT8U *dsptr = (INT8U *)&sBody->SubData[3];
//  734 					INT8U *stptr = (INT8U *)AttTblStr->Data;
//  735 					
//  736 					for(i = 0; i < tbllen ; i++)
        CMP      R0,#+0
        BEQ.N    ??Response_Table_DE_2
        ADD      R1,R4,#+10
        ADDS     R2,R2,#+2
//  737 					{
//  738 						dsptr[i] = stptr[i];
??Response_Table_DE_33:
        LDRB     R3,[R2], #+1
        STRB     R3,[R1], #+1
//  739 					}
        SUBS     R0,R0,#+1
        BEQ.N    ??Response_Table_DE_2
        B.N      ??Response_Table_DE_33
//  740 				}
//  741 			}
//  742 		}
//  743 		break;
//  744 
//  745 		
//  746 		case Index_FwdTempAttn_2G	 :
//  747 		case Index_RvsTempAttn_2G	 :
//  748 		case Index_FwdTempAttn_LTE	 :
//  749 		case Index_RvsTempAttn_LTE	 :
//  750 		case Index_FwdTempAttn_LTE_A :
//  751 		case Index_RvsTempAttn_LTE_A :
//  752 		case Index_FwdTempAttn_3G	 :
//  753 		case Index_RvsTempAttn_3G	 :
//  754 		case Index_Fwd1TempAttn_LTE  :
//  755 		case Index_Rvs1TempAttn_LTE  :
//  756 		case Index_Fwd1TempAttn_LTE_A :
//  757 		case Index_Rvs1TempAttn_LTE_A :
//  758 		{
//  759 			__AttnTempTblStr *AttTblStr;
//  760 
//  761 			if( Comm == DDRTableSetQue)
??Response_Table_DE_34:
        MOVS     R0,#+28
        MUL      R10,R1,R0
        LDR      R0,[SP, #+0]
        UXTB     R0,R0
        CMP      R0,#+117
        BNE.N    ??Response_Table_DE_35
//  762 			{
//  763 				INT32U cpu_sr;
//  764 				OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  765 				{
//  766 					EE_TABLE1 *tptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
        LDR.W    R9,??DataTable7  ;; 0x8006800
        MOV      R0,R9
        BL       RoadBackuptobuffer
//  767 					AttTblStr = &tptr->_TptlAttnTbl[tIndex];
        ADD      R0,R10,R0
//  768 					tlimit = AttTblStr->limit = rBody->SubData[1];
        LDRSB    R1,[R6, #+8]
        STRB     R1,[R0, #+10]!
//  769 					//tlimit = AttTblStr->limit = 0;
//  770 					tsize = AttTblStr->nsize = rBody->SubData[2];
        LDRB     R1,[R6, #+9]
        STRB     R1,[R0, #+1]
//  771 					if( tsize > TempTBL_Size)  tsize = TempTBL_Size; 
        CMP      R1,#+26
        BCC.N    ??Response_Table_DE_36
        MOVS     R1,#+25
//  772 
//  773 					tbllen = (tsize*1); // data type: int16!!
//  774 					{
//  775 						INT8U *dsptr = (INT8U *)AttTblStr->Data;
//  776 						INT8U *stptr = (INT8U *)&rBody->SubData[3];
//  777 						
//  778 						for(i = 0; i < tbllen && i < (TempTBL_Size); i++)
??Response_Table_DE_36:
        MOVS     R7,#+0
        ADDS     R0,R0,#+2
        ADD      R2,R6,#+10
        B.N      ??Response_Table_DE_37
//  779 						{
//  780 							dsptr[i] = (stptr[i]);
??Response_Table_DE_38:
        LDRB     R3,[R2], #+1
        STRB     R3,[R0], #+1
//  781 						}
        ADDS     R7,R7,#+1
??Response_Table_DE_37:
        CMP      R7,R1
        BCS.N    ??Response_Table_DE_39
        CMP      R7,#+25
        BCC.N    ??Response_Table_DE_38
//  782 					}
//  783 					WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
??Response_Table_DE_39:
        MOVW     R1,#+1954
        MOV      R0,R9
        BL       WriteBuffertoBackup
//  784 				}
//  785 				OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  786 			}
//  787 			{
//  788 				AttTblStr = &vEE_TABLE1->_TptlAttnTbl[tIndex];
??Response_Table_DE_35:
        LDR.N    R0,??Response_Table_DE_9+0x10  ;; 0x800680a
        ADD      R2,R10,R0
//  789 
//  790 				//tlimit = AttTblStr->limit = 0;
//  791 				tlimit = AttTblStr->limit;
        LDRSB    R3,[R2, #+0]
//  792 				if( tsize > TempTBL_Size)  tsize = TempTBL_Size; 
//  793 				tsize = AttTblStr->nsize;
        LDRB     R1,[R2, #+1]
//  794 
//  795 				tbllen = (tsize*1); // data type: int16!!
        MOVS     R0,R1
//  796 
//  797 				sBody->SubData[0] = TblID;
        STRB     R5,[R4, #+7]
//  798 				sBody->SubData[1] = tlimit;
        STRB     R3,[R4, #+8]
//  799 				sBody->SubData[2] = tsize;
        STRB     R1,[R4, #+9]
//  800 				{
//  801 					INT8U *dsptr = (INT8U *)&sBody->SubData[3];
//  802 					INT8U *stptr = (INT8U *)AttTblStr->Data;
//  803 					
//  804 					for(i = 0; i < tbllen ; i++)
        BEQ.N    ??Response_Table_DE_2
        ADD      R1,R4,#+10
        ADDS     R2,R2,#+2
//  805 					{
//  806 						dsptr[i] = stptr[i];
??Response_Table_DE_40:
        LDRB     R3,[R2], #+1
        STRB     R3,[R1], #+1
//  807 					}
        SUBS     R0,R0,#+1
        BNE.N    ??Response_Table_DE_40
//  808 				}
//  809 			}
//  810 		}			
//  811 		break;
//  812 
//  813 
//  814 		default:
//  815     	break;
//  816 	}
//  817 
//  818 	GenBodyFrame(tid[0], tid[0], tid[0], (INT8U *)Send->BodyFrame[0].SubData, Send->BodyFrame[0].SubLength, Comm, nPtr, 0);
??Response_Table_DE_2:
        MOVS     R1,#+0
        LDR      R0,[SP, #+16]
        PUSH     {R0,R1}
        LDR      R1,[SP, #+8]
        LDR      R0,[SP, #+20]
        LDRH     R0,[R0, #+1715]
        UXTB     R1,R1
        PUSH     {R0,R1}
        LDR      R0,[SP, #+28]
        ADD      R3,R0,#+15
        LDRB     R2,[SP, #+20]
        MOV      R1,R2
        MOV      R0,R1
        BL       GenBodyFrame
        ADD      SP,SP,#+16
//  819 	WRCS_ProDataAckTx(nPtr);
        LDR      R0,[SP, #+16]
        BL       WRCS_ProDataAckTx
//  820 }
??Response_Table_DE_1:
        ADD      SP,SP,#+20
        POP      {R4-R11,PC}      ;; return
        DATA
??Response_Table_DE_9:
        DC32     0x8005802
        DC32     0x80060e2
        DC32     0x800695a
        DC32     0x80064d2
        DC32     0x800680a

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     0x8005800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0x8006000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     0x8006800
//  821 #else
//  822 
//  823 void Response_Table_DE(__ProtocolPtr *nPtr)
//  824 {
//  825 	INT8U TblID = 0;
//  826 	INT8S tIndex = 0;
//  827 	INT8U Comm;
//  828 	INT8U tsize;
//  829 	INT8U *tptr, *sptr;
//  830 	INT16U ntableBp = 0;
//  831 	INT32U i = 0;
//  832 
//  833 	__WRCSSIO *Recv = nPtr->WRCSRecv;
//  834 	__WRCSSIO *Send = nPtr->WRCSSend;
//  835 
//  836     __BODYFRAME *rBody = &Recv->BodyFrame[Recv->cBody];
//  837     __BODYFRAME *sBody = &Send->BodyFrame[Recv->cBody];
//  838 
//  839 	Comm = rBody->Command;
//  840 	TblID = rBody->SubData[0];
//  841 	
//  842 	INT8U tid[3] = {rBody->SubID[0], rBody->SubID[1], rBody->SubID[2]};
//  843 	
//  844 	if( (tIndex = TableIndex(TblID)) == -1) return;
//  845 
//  846 	switch(TblID)	//command üũ
//  847 	{
//  848 		case Index_FwdInPwr_2G			:
//  849 		case Index_FwdOutAvgPwr_2G		:
//  850 		case Index_FwdOutPeakPwr_2G 	:
//  851 		case Index_RvsInPwr_2G			:
//  852 		case Index_RvsOutPwr_2G 		:
//  853 		case Index_FwdAgcAvgPwr_2G		:
//  854 		case Index_FwdAgcPeakPwr_2G 	:
//  855 		case Index_FwdInPwr_Common		:
//  856 		case Index_FwdOutAvgPwr_Common 	:
//  857 		case Index_RvsInPwr_Common		:
//  858 		case Index_RvsOutPwr_Common 	:
//  859 		case Index_FwdInPwr_LTE 		:
//  860 		case Index_FwdOutAvgPwr_LTE 	:
//  861 		case Index_FwdOutPeakPwr_LTE	:
//  862 		case Index_RvsInPwr_LTE 		:
//  863 		case Index_RvsOutPwr_LTE		:
//  864 		case Index_Fwd15MOutAvgPwr_LTE	:
//  865 		case Index_Fwd15MOutPeakPwr_LTE :
//  866 		case Index_FwdAgcAvgPwr_LTE 	:
//  867 		case Index_FwdAgcPeakPwr_LTE	:
//  868 		case Index_FwdInPwr_LTE_A		:
//  869 		case Index_FwdOutAvgPwr_LTE_A	:
//  870 		case Index_FwdOutPeakPwr_LTE_A	:
//  871 		case Index_RvsInPwr_LTE_A		:
//  872 		case Index_RvsOutPwr_LTE_A		:
//  873 		case Index_FwdAgcAvgPwr_LTE_A	:
//  874 		case Index_FwdAgcPeakPwr_LTE_A	:
//  875 		case Index_FwdInPwr_3G			:
//  876 		case Index_FwdOutAvgPwr_3G		:
//  877 		case Index_FwdOutPeakPwr_3G 	:
//  878 		case Index_RvsInPwr_3G			:
//  879 		case Index_RvsOutPwr_3G 		:
//  880 		case Index_OtherRvsInPwr_3G 	:
//  881 		case Index_OtherRvsInPwr_LTE_A	:
//  882 			
//  883 #ifdef _MIMO_Type
//  884 		case Index_Fwd1InPwr_LTE		:
//  885 		case Index_Fwd1OutAvgPwr_LTE	:
//  886 		case Index_Fwd1OutPeakPwr_LTE	:
//  887 		case Index_Rvs1InPwr_LTE		:
//  888 		case Index_Rvs1OutPwr_LTE		:
//  889 		case Index_Fwd1AgcAvgPwr_LTE	:
//  890 		case Index_Fwd1AgcPeakPwr_LTE	:
//  891 		case Index_Fwd1InPwr_LTE_A		:
//  892 		case Index_Fwd1OutAvgPwr_LTE_A	:
//  893 		case Index_Fwd1OutPeakPwr_LTE_A :
//  894 		case Index_Rvs1InPwr_LTE_A		:
//  895 		case Index_Rvs1OutPwr_LTE_A 	:
//  896 		case Index_Fwd1AgcAvgPwr_LTE_A	:
//  897 		case Index_Fwd1AgcPeakPwr_LTE_A :
//  898 		case Index_OtherRvs1InPwr_LTE	:
//  899 		case Index_OtherRvs1InPwr_LTE_A :
//  900 #endif	
//  901 		{
//  902 			__OutputTblStr *table = (__OutputTblStr *)OutputTable;
//  903 
//  904 			if((Comm == DDRTableSetQue))
//  905 			{
//  906 				ntableBp = (TableBp + tIndex*(sizeof(__OutputTblStr)));
//  907 				
//  908 				table[tIndex].limit = rBody->SubData[1];
//  909 				tsize = table[tIndex].nsize = rBody->SubData[2];
//  910 				
//  911 				tptr = (INT8U *)table[tIndex].Data;
//  912 				sptr = (INT8U *)&rBody->SubData[3];
//  913 
//  914 				for(i = 0; i < (tsize%OutputTBL_Size); i++)
//  915 				{
//  916 					*((INT16U *)(tptr) + i) = swab16p(((INT16U *)sptr + i));
//  917 				}
//  918 				TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%OutputTBL_Size)*2 + 2);
//  919 			}
//  920 
//  921 			{
//  922 				int j = 0;
//  923 				tptr = (INT8U *)(Send->BodyFrame[0].SubData);
//  924 
//  925 				*tptr++ = rBody->SubData[0];
//  926 				*tptr++ = table[tIndex].limit;
//  927 				*tptr++ = (table[tIndex].nsize)%OutputTBL_Size;
//  928 
//  929 				for(i = 0; i < ((table[tIndex].nsize)%OutputTBL_Size); i++)
//  930 				{
//  931 					tptr[j++] = table[tIndex].Data[i] >> 8;
//  932 					tptr[j++] = table[tIndex].Data[i] >> 0;
//  933 				}
//  934 				sBody->SubLength = 3 + (i*2);
//  935 			}
//  936 		}
//  937 		break;
//  938 
//  939 		case Index_FwdAttn1_2G	 :
//  940 		case Index_FwdAttn2_2G	 :
//  941 		case Index_RvsAttn1_2G	 :
//  942 		case Index_RvsAttn2_2G	 :
//  943 		case Index_RvsAttn3_2G	 :
//  944 		case Index_FwdAttn1_LTE  :
//  945 		case Index_FwdAttn2_LTE  :
//  946 		case Index_RvsAttn1_LTE  :
//  947 		case Index_RvsAttn2_LTE  :
//  948 		case Index_RvsAttn3_LTE  :
//  949 		case Index_RvsAttn4_LTE  :
//  950 		case Index_FwdAttn1_LTE_A  :
//  951 		case Index_FwdAttn2_LTE_A  :
//  952 		case Index_RvsAttn1_LTE_A  :
//  953 		case Index_RvsAttn2_LTE_A  :
//  954 		case Index_RvsAttn3_LTE_A  :
//  955 		case Index_RvsAttn4_LTE_A  :
//  956 		case Index_FwdAttn1_3G	 :
//  957 		case Index_FwdAttn2_3G	 :
//  958 		case Index_RvsAttn1_3G	 :
//  959 		case Index_RvsAttn2_3G	 :
//  960 		case Index_RvsAttn3_3G	 :
//  961 		case Index_RvsAttn4_3G	 :
//  962 		case Index_FwdAttn1_Common :
//  963 		case Index_RvsAttn1_Common :
//  964 		{
//  965 			__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
//  966 						
//  967 			if(Comm == DDRTableSetQue)
//  968 			{
//  969 				ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));
//  970 
//  971 				table[tIndex].limit = rBody->SubData[1] = 0;
//  972 				tsize = table[tIndex].nsize = rBody->SubData[2] = 61;
//  973 				if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 
//  974 
//  975 								
//  976 				tptr = (INT8U *)table[tIndex].Data;
//  977 				sptr = (INT8U *)&rBody->SubData[3];
//  978 
//  979 				for(i = 0; i < (tsize%AttTBL_Size); i++)
//  980 				{
//  981 					*((INT8U *)(tptr) + i) = *((INT8U *)sptr + i);
//  982 				}
//  983 				TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
//  984 			}
//  985 
//  986 			{
//  987 				int j = 0;
//  988 				tptr = (INT8U *)(Send->BodyFrame[0].SubData);
//  989 
//  990 				*tptr++ = rBody->SubData[0];
//  991 				*tptr++ = table[tIndex].limit = (INT8U)(0);
//  992 				*tptr++ = table[tIndex].nsize = 61;
//  993 				
//  994 				for(i = 0; i < ((table[tIndex].nsize)%AttTBL_Size); i++)
//  995 				{
//  996 					tptr[j++] = table[tIndex].Data[i];
//  997 				}
//  998 				sBody->SubLength = 3 + (i);
//  999 			}
// 1000 		}
// 1001  		break;
// 1002 //////////////////
// 1003 		case Index_Fwd1Attn1_LTE	:
// 1004 		case Index_Fwd1Attn2_LTE	:
// 1005 		case Index_Rvs1Attn1_LTE	:
// 1006 		case Index_Rvs1Attn2_LTE	:
// 1007 		case Index_Rvs1Attn3_LTE	:
// 1008 		case Index_Rvs1Attn4_LTE	:
// 1009 		case Index_Fwd1Attn1_LTE_A	:
// 1010 		case Index_Fwd1Attn2_LTE_A	:
// 1011 		case Index_Rvs1Attn1_LTE_A	:
// 1012 		case Index_Rvs1Attn2_LTE_A	:
// 1013 		case Index_Rvs1Attn3_LTE_A	:
// 1014 		{
// 1015 			__AttnOffsetTblStr *table = (__AttnOffsetTblStr *)AttnOffsetTable;
// 1016 						
// 1017 			if(Comm == DDRTableSetQue)
// 1018 			{
// 1019 				ntableBp = (AttnTableBp + tIndex*(sizeof(__AttnOffsetTblStr)));
// 1020 
// 1021 				table[tIndex].limit = rBody->SubData[1] = 0;
// 1022 				tsize = table[tIndex].nsize = rBody->SubData[2] = 61;
// 1023 				if( tsize > AttTBL_Size)  tsize = AttTBL_Size; 
// 1024 
// 1025 								
// 1026 				tptr = (INT8U *)table[tIndex].Data;
// 1027 				sptr = (INT8U *)&rBody->SubData[3];
// 1028 
// 1029 				for(i = 0; i < (tsize%AttTBL_Size); i++)
// 1030 				{
// 1031 					*((INT8U *)(tptr) + i) = *((INT8U *)sptr + i);
// 1032 				}
// 1033 				TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
// 1034 			}
// 1035 
// 1036 			{
// 1037 				int j = 0;
// 1038 				tptr = (INT8U *)(Send->BodyFrame[0].SubData);
// 1039 
// 1040 				*tptr++ = rBody->SubData[0];
// 1041 				*tptr++ = table[tIndex].limit = (INT8U)(0);
// 1042 				*tptr++ = table[tIndex].nsize = 61;
// 1043 				
// 1044 				for(i = 0; i < ((table[tIndex].nsize)%AttTBL_Size); i++)
// 1045 				{
// 1046 					tptr[j++] = table[tIndex].Data[i];
// 1047 				}
// 1048 				sBody->SubLength = 3 + (i);
// 1049 			}
// 1050 		}
// 1051  		break;
// 1052 ///////////////////////
// 1053 		case Index_FwdTempAttn_2G	 :
// 1054 		case Index_RvsTempAttn_2G	 :
// 1055 		case Index_FwdTempAttn_LTE	 :
// 1056 		case Index_RvsTempAttn_LTE	 :
// 1057 		case Index_FwdTempAttn_LTE_A :
// 1058 		case Index_RvsTempAttn_LTE_A :
// 1059 		case Index_FwdTempAttn_3G	 :
// 1060 		case Index_RvsTempAttn_3G	 :
// 1061 		case Index_Fwd1TempAttn_LTE  :
// 1062 		case Index_Rvs1TempAttn_LTE  :
// 1063 		case Index_Fwd1TempAttn_LTE_A :
// 1064 		case Index_Rvs1TempAttn_LTE_A :
// 1065 		{
// 1066 			__AttnTempTblStr *table = (__AttnTempTblStr *)AttnTempTable;
// 1067 						
// 1068 			if(Comm == DDRTableSetQue)
// 1069 			{
// 1070 				ntableBp = (AttnTptlTableBp + tIndex*(sizeof(__AttnTempTblStr)));
// 1071 
// 1072 				table[tIndex].limit = rBody->SubData[1] = 80;
// 1073 				tsize = table[tIndex].nsize = rBody->SubData[2] = 22;
// 1074 								
// 1075 				tptr = (INT8U *)table[tIndex].Data;
// 1076 				sptr = (INT8U *)&rBody->SubData[3];
// 1077 
// 1078 				for(i = 0; i < (tsize%AttTBL_Size); i++)
// 1079 				{
// 1080 					*((INT8U *)(tptr) + i) = *((INT8U *)sptr + i);
// 1081 				}
// 1082 				TableIndexBackup(ntableBp, (INT32U)&table[tIndex], (tsize%AttTBL_Size) + 2);
// 1083 			}
// 1084 
// 1085 			{
// 1086 				int j = 0;
// 1087 				tptr = (INT8U *)(Send->BodyFrame[0].SubData);
// 1088 
// 1089 				*tptr++ = rBody->SubData[0];
// 1090 				*tptr++ = (INT8U)(80);//table->limit;
// 1091 				//*tptr++ = (table->nsize)%AttTBL_Size;
// 1092 				*tptr++ = table[tIndex].nsize = 22;
// 1093 				
// 1094 				for(i = 0; i < ((table[tIndex].nsize)%AttTBL_Size); i++)
// 1095 				{
// 1096 					tptr[j++] = table[tIndex].Data[i];
// 1097 				}
// 1098 				sBody->SubLength = 3 + (i);
// 1099 			}
// 1100 		}
// 1101 		break;
// 1102 		
// 1103 		default:
// 1104     	break;
// 1105 	}
// 1106 
// 1107 	GenBodyFrame(tid[0], tid[0], tid[0], (INT8U *)Send->BodyFrame[0].SubData, Send->BodyFrame[0].SubLength, Comm, nPtr, 0);
// 1108 	WRCS_ProDataAckTx(nPtr);
// 1109 }
// 1110 
// 1111 
// 1112 #endif
// 1113 
// 1114 
// 1115 
// 1116 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1117 INT8S TableIndex(INT8U TblID)
// 1118 {
// 1119     INT8S tIndex = -1;
// 1120 
// 1121 	switch(TblID)
TableIndex:
        SUBS     R0,R0,#+4
        CMP      R0,#+134
        BHI.W    ??TableIndex_1
        TBB      [PC, R0]
        DATA
??TableIndex_0:
        DC8      +68,+126,+68,+70
        DC8      +70,+80,+126,+82
        DC8      +84,+126,+126,+126
        DC8      +72,+126,+86,+88
        DC8      +90,+92,+74,+126
        DC8      +126,+74,+94,+96
        DC8      +98,+72,+100,+102
        DC8      +76,+104,+68,+70
        DC8      +126,+126,+72,+74
        DC8      +76,+126,+126,+78
        DC8      +80,+126,+126,+82
        DC8      +84,+86,+126,+126
        DC8      +88,+90,+126,+126
        DC8      +126,+94,+96,+98
        DC8      +126,+100,+102,+126
        DC8      +126,+104,+106,+108
        DC8      +110,+126,+112,+126
        DC8      +126,+114,+126,+126
        DC8      +126,+68,+70,+72
        DC8      +74,+76,+78,+80
        DC8      +82,+106,+108,+126
        DC8      +126,+126,+126,+126
        DC8      +126,+126,+126,+126
        DC8      +126,+126,+126,+126
        DC8      +126,+78,+126,+126
        DC8      +80,+110,+112,+114
        DC8      +78,+126,+126,+82
        DC8      +116,+118,+120,+68
        DC8      +70,+126,+126,+72
        DC8      +74,+76,+78,+126
        DC8      +80,+82,+126,+126
        DC8      +84,+86,+88,+90
        DC8      +126,+84,+86,+88
        DC8      +90,+122,+124,+0
        THUMB
// 1122 	{
// 1123 		case Index_RvsInPwr_2G			:	return Local_RvsInPwr_2G;
??TableIndex_2:
        MOVS     R0,#+0
        BX       LR
// 1124 		case Index_FwdInPwr_Common		:	return Local_FwdInPwr_Common;
??TableIndex_3:
        MOVS     R0,#+1
        BX       LR
// 1125 		case Index_RvsInPwr_LTE 		:	return Local_RvsInPwr_LTE;
??TableIndex_4:
        MOVS     R0,#+2
        BX       LR
// 1126 		case Index_RvsInPwr_LTE_A		:	return Local_RvsInPwr_LTE_A;
??TableIndex_5:
        MOVS     R0,#+3
        BX       LR
// 1127 		case Index_RvsInPwr_3G			:	return Local_RvsInPwr_3G;
??TableIndex_6:
        MOVS     R0,#+4
        BX       LR
// 1128 		case Index_Fwd1InPwr_LTE		:	return Local_Fwd1InPwr_LTE;
??TableIndex_7:
        MOVS     R0,#+5
        BX       LR
// 1129 		case Index_Rvs1InPwr_LTE		:	return Local_Rvs1InPwr_LTE;
??TableIndex_8:
        MOVS     R0,#+6
        BX       LR
// 1130 		case Index_Rvs1InPwr_LTE_A		:	return Local_Rvs1InPwr_LTE_A;
??TableIndex_9:
        MOVS     R0,#+7
        BX       LR
// 1131 
// 1132 
// 1133 		case Index_FwdAgcAvgPwr_2G		:	return Local_FwdAgcAvgPwr_2G;
// 1134 		case Index_FwdAgcPeakPwr_2G 	:	return Local_FwdAgcPeakPwr_2G;
// 1135 		case Index_FwdOutAvgPwr_Common 	:	return Local_FwdOutPwr_Common;
// 1136 		case Index_RvsInPwr_Common		:	return Local_RvsInPwr_Common;
// 1137 		case Index_RvsOutPwr_Common 	:	return Local_RvsOutPwr_Common ;
??TableIndex_10:
        MOVS     R0,#+8
        BX       LR
// 1138 		case Index_Fwd15MOutAvgPwr_LTE	:	return Local_Fwd15MOutAvgPwr_LTE;
??TableIndex_11:
        MOVS     R0,#+9
        BX       LR
// 1139 		case Index_Fwd15MOutPeakPwr_LTE :	return Local_Fwd15MOutPeakPwr_LTE;
??TableIndex_12:
        MOVS     R0,#+10
        BX       LR
// 1140 		case Index_FwdAgcAvgPwr_LTE 	:	return Local_FwdAgcAvgPwr_LTE;
??TableIndex_13:
        MOVS     R0,#+11
        BX       LR
// 1141 		case Index_FwdAgcPeakPwr_LTE	:	return Local_FwdAgcPeakPwr_LTE;
??TableIndex_14:
        MOVS     R0,#+12
        BX       LR
// 1142 		case Index_FwdInPwr_LTE_A		:	return Local_FwdInPwr_LTE_A;
// 1143 		case Index_RvsOutPwr_LTE_A		:	return Local_RvsOutPwr_LTE_A;
??TableIndex_15:
        MOVS     R0,#+13
        BX       LR
// 1144 		case Index_FwdAgcAvgPwr_LTE_A	:	return Local_FwdAgcAvgPwr_LTE_A;
??TableIndex_16:
        MOVS     R0,#+14
        BX       LR
// 1145 		case Index_FwdAgcPeakPwr_LTE_A	:	return Local_FwdAgcPeakPwr_LTE_A;
??TableIndex_17:
        MOVS     R0,#+15
        BX       LR
// 1146 		case Index_FwdInPwr_3G			:	return Local_FwdInPwr_3G;
// 1147 		case Index_FwdOutAvgPwr_3G		:	return Local_FwdOutAvgPwr_3G;
??TableIndex_18:
        MOVS     R0,#+16
        BX       LR
// 1148 		case Index_FwdOutPeakPwr_3G 	:	return Local_FwdOutPeakPwr_3G;
??TableIndex_19:
        MOVS     R0,#+17
        BX       LR
// 1149 		case Index_RvsOutPwr_3G 		:	return Local_RvsOutPwr_3G;
??TableIndex_20:
        MOVS     R0,#+18
        BX       LR
// 1150 		case Index_OtherRvsInPwr_3G 	:	return Local_OtherRvsInPwr_3G;
??TableIndex_21:
        MOVS     R0,#+19
        BX       LR
// 1151 		case Index_OtherRvsInPwr_LTE_A	:	return Local_OtherRvsInPwr_LTE_A;
??TableIndex_22:
        MOVS     R0,#+20
        BX       LR
// 1152 
// 1153 		case Index_Rvs1OutPwr_LTE		:	return Local_Rvs1OutPwr_LTE; 
??TableIndex_23:
        MOVS     R0,#+21
        BX       LR
// 1154 		case Index_Fwd1AgcAvgPwr_LTE	:	return Local_Fwd1AgcAvgPwr_LTE;
??TableIndex_24:
        MOVS     R0,#+22
        BX       LR
// 1155 		case Index_Fwd1AgcPeakPwr_LTE	:	return Local_Fwd1AgcPeakPwr_LTE;
??TableIndex_25:
        MOVS     R0,#+23
        BX       LR
// 1156 		case Index_Fwd1InPwr_LTE_A		:	return Local_Fwd1InPwr_LTE_A;
// 1157 		case Index_Rvs1OutPwr_LTE_A 	:	return Local_Rvs1OutPwr_LTE_A; 
??TableIndex_26:
        MOVS     R0,#+24
        BX       LR
// 1158 		case Index_Fwd1AgcAvgPwr_LTE_A	:	return Local_Fwd1AgcAvgPwr_LTE_A;
??TableIndex_27:
        MOVS     R0,#+25
        BX       LR
// 1159 		case Index_Fwd1AgcPeakPwr_LTE_A :	return Local_Fwd1AgcPeakPwr_LTE_A;
??TableIndex_28:
        MOVS     R0,#+26
        BX       LR
// 1160 		case Index_OtherRvs1InPwr_LTE	:	return Local_OtherRvs1InPwr_LTE;
??TableIndex_29:
        MOVS     R0,#+27
        BX       LR
// 1161 		case Index_OtherRvs1InPwr_LTE_A :	return Local_OtherRvs1InPwr_LTE_A;
??TableIndex_30:
        MOVS     R0,#+28
        BX       LR
// 1162 
// 1163 
// 1164 		case Index_FwdAttn1_2G			:	return Local_FwdAttn1_2G;
// 1165 		case Index_FwdAttn2_2G			:	return Local_FwdAttn2_2G;	
// 1166 		case Index_RvsAttn1_2G			:	return Local_RvsAttn1_2G;
// 1167 		case Index_RvsAttn2_2G			:	return Local_RvsAttn2_2G;
// 1168 		case Index_RvsAttn3_2G			:	return Local_RvsAttn3_2G;
// 1169 		case Index_FwdAttn1_LTE 		:	return Local_FwdAttn1_LTE;
// 1170 		case Index_FwdAttn2_LTE 		:	return Local_FwdAttn2_LTE;
// 1171 		case Index_RvsAttn1_LTE 		:	return Local_RvsAttn1_LTE;
// 1172 		case Index_RvsAttn2_LTE 		:	return Local_RvsAttn2_LTE;
// 1173 		case Index_RvsAttn3_LTE 		:	return Local_RvsAttn3_LTE;
// 1174 		case Index_FwdAttn1_LTE_A		:	return Local_FwdAttn1_LTE_A;
// 1175 		case Index_FwdAttn2_LTE_A		:	return Local_FwdAttn2_LTE_A;
// 1176 		case Index_RvsAttn2_LTE_A		:	return Local_RvsAttn2_LTE_A;
// 1177 		case Index_RvsAttn3_LTE_A		:	return Local_RvsAttn3_LTE_A;
// 1178 		case Index_RvsAttn4_LTE_A		:	return Local_RvsAttn4_LTE_A;
// 1179 		
// 1180 		case Index_FwdAttn1_3G			:	return Local_FwdAttn1_3G;
// 1181 		case Index_FwdAttn2_3G			:	return Local_FwdAttn2_3G;	
// 1182 		case Index_RvsAttn1_3G			:	return Local_RvsAttn1_3G;	
// 1183 		case Index_RvsAttn2_3G			:	return Local_RvsAttn2_3G;	
// 1184 		case Index_RvsAttn3_3G			:	return Local_RvsAttn3_3G;	
// 1185 		case Index_RvsAttn4_3G			:	return Local_RvsAttn4_3G;	
// 1186 		case Index_FwdAttn1_Common		:	return Local_FwdAttn1_Common;
// 1187 		case Index_RvsAttn1_Common		:	return Local_RvsAttn1_Common;
// 1188 
// 1189 		case Index_FwdTempAttn_2G		:	return Local_FwdTempAttn_2G;
// 1190 		case Index_RvsTempAttn_2G		:	return Local_RvsTempAttn_2G;
// 1191 		case Index_FwdTempAttn_LTE		:	return Local_FwdTempAttn_LTE;
// 1192 		case Index_RvsTempAttn_LTE		:	return Local_RvsTempAttn_LTE;
// 1193 		case Index_FwdTempAttn_LTE_A	:	return Local_FwdTempAttn_LTE_A;
// 1194 		case Index_RvsTempAttn_LTE_A	:	return Local_RvsTempAttn_LTE_A;
// 1195 		case Index_FwdTempAttn_3G		:	return Local_FwdTempAttn_3G;
// 1196 		case Index_RvsTempAttn_3G		:	return Local_RvsTempAttn_3G;
// 1197 
// 1198 
// 1199 		case Index_Fwd1Attn1_LTE		:	return Local_Fwd1Attn1_LTE;
// 1200 		case Index_Fwd1Attn2_LTE		:	return Local_Fwd1Attn2_LTE;
// 1201 		case Index_Rvs1Attn1_LTE		:	return Local_Rvs1Attn1_LTE;
// 1202 		case Index_Rvs1Attn2_LTE		:	return Local_Rvs1Attn2_LTE;
// 1203 		case Index_Rvs1Attn3_LTE		:	return Local_Rvs1Attn3_LTE;
// 1204 		case Index_Rvs1Attn4_LTE		:	return Local_Rvs1Attn4_LTE;
// 1205 		case Index_Fwd1Attn1_LTE_A		:	return Local_Fwd1Attn1_LTE_A;
// 1206 		case Index_Fwd1Attn2_LTE_A		:	return Local_Fwd1Attn2_LTE_A;
// 1207 		case Index_Rvs1Attn1_LTE_A		:	return Local_Rvs1Attn1_LTE_A;
// 1208 		case Index_Rvs1Attn2_LTE_A		:	return Local_Rvs1Attn2_LTE_A;
// 1209 		case Index_Rvs1Attn3_LTE_A		:	return Local_Rvs1Attn3_LTE_A;
// 1210 		case Index_Rvs1Attn4_LTE_A		:	return Local_Rvs1Attn4_LTE_A;
// 1211 
// 1212 		
// 1213 		case Index_Fwd1TempAttn_LTE 	:	return Local_Fwd1TempAttn_LTE;
// 1214 		case Index_Rvs1TempAttn_LTE 	:	return Local_Rvs1TempAttn_LTE;
// 1215 		case Index_Fwd1TempAttn_LTE_A	:	return Local_Fwd1TempAttn_LTE_A;
// 1216 		case Index_Rvs1TempAttn_LTE_A	:	return Local_Rvs1TempAttn_LTE_A;
// 1217 	}
// 1218 
// 1219 	return tIndex;
??TableIndex_1:
        MOV      R0,#-1
        BX       LR               ;; return
// 1220 }
// 1221 
// 1222 
// 1223 
// 1224 
// 1225 
// 1226 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1227 INT8S TableLocation(INT8U TblID)
// 1228 {
TableLocation:
        MOV      R1,R0
// 1229     INT8S tIndex = -1;
        MOV      R0,#-1
// 1230 
// 1231 	switch(TblID)
        SUBS     R1,R1,#+4
        CMP      R1,#+134
        BHI.W    ??TableLocation_1
        TBB      [PC, R1]
        DATA
??TableLocation_0:
        DC8      +68,+71,+70,+70
        DC8      +68,+70,+71,+70
        DC8      +70,+71,+71,+71
        DC8      +68,+71,+70,+70
        DC8      +70,+70,+70,+71
        DC8      +71,+68,+70,+70
        DC8      +70,+70,+70,+70
        DC8      +68,+70,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+70,+70,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+68,+71,+71
        DC8      +68,+70,+70,+70
        DC8      +70,+71,+71,+68
        DC8      +70,+70,+70,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+71,+71,+71
        DC8      +71,+70,+70,+0
        THUMB
// 1232 	{
// 1233 		case Index_RvsInPwr_2G			:
// 1234 		case Index_FwdInPwr_Common		:
// 1235 		case Index_RvsInPwr_LTE 		:
// 1236 		case Index_RvsInPwr_LTE_A		:
// 1237 		case Index_RvsInPwr_3G			:
// 1238 		case Index_Fwd1InPwr_LTE		:
// 1239 		case Index_Rvs1InPwr_LTE		:
// 1240 		case Index_Rvs1InPwr_LTE_A		:
// 1241 			tIndex = _2ST_Location;
??TableLocation_2:
        MOVS     R0,#+1
        BX       LR
// 1242 		break;
// 1243 
// 1244 		case Index_FwdAgcAvgPwr_2G		:
// 1245 		case Index_FwdAgcPeakPwr_2G 	:
// 1246 		case Index_FwdOutAvgPwr_Common 	:
// 1247 		case Index_RvsInPwr_Common		:
// 1248 		case Index_RvsOutPwr_Common 	:
// 1249 		case Index_Fwd15MOutAvgPwr_LTE	:
// 1250 		case Index_Fwd15MOutPeakPwr_LTE :
// 1251 		case Index_FwdAgcAvgPwr_LTE 	:
// 1252 		case Index_FwdAgcPeakPwr_LTE	:
// 1253 		case Index_FwdInPwr_LTE_A		:
// 1254 		case Index_RvsOutPwr_LTE_A		:
// 1255 		case Index_FwdAgcAvgPwr_LTE_A	:
// 1256 		case Index_FwdAgcPeakPwr_LTE_A	:
// 1257 		case Index_FwdInPwr_3G			:
// 1258 		case Index_FwdOutAvgPwr_3G		:
// 1259 		case Index_FwdOutPeakPwr_3G 	:
// 1260 		case Index_RvsOutPwr_3G 		:
// 1261 		case Index_OtherRvsInPwr_3G 	:
// 1262 		case Index_OtherRvsInPwr_LTE_A	:
// 1263 
// 1264 		case Index_Rvs1OutPwr_LTE		:
// 1265 		case Index_Fwd1AgcAvgPwr_LTE	:
// 1266 		case Index_Fwd1AgcPeakPwr_LTE	:
// 1267 		case Index_Fwd1InPwr_LTE_A		:
// 1268 		case Index_Rvs1OutPwr_LTE_A 	:
// 1269 		case Index_Fwd1AgcAvgPwr_LTE_A	:
// 1270 		case Index_Fwd1AgcPeakPwr_LTE_A :
// 1271 		case Index_OtherRvs1InPwr_LTE	:
// 1272 		case Index_OtherRvs1InPwr_LTE_A :
// 1273 			tIndex = _1ST_Location;
??TableLocation_3:
        MOVS     R0,#+0
// 1274 		break;
// 1275 
// 1276 		default:
// 1277 			
// 1278 		break;
// 1279 	}
// 1280 
// 1281 	return tIndex;
??TableLocation_1:
        BX       LR               ;; return
// 1282 }
// 1283 
// 1284 
// 1285 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1286 void TableIndexBackup(INT16U EEADDR, INT32U sptr, INT32U len)
// 1287 {
TableIndexBackup:
        PUSH     {R4-R8,LR}
        MOV      R5,R0
        MOV      R6,R1
        MOV      R4,R2
// 1288 
// 1289 	INT32U i = 0;
// 1290 	INT8U *ptr = ((INT8U *)sptr);
// 1291 	INT8U verify = 0;
// 1292 	
// 1293 	for(i = 0; i < len; i++) 
        MOVS     R7,#+0
        CBZ      R4,??TableIndexBackup_0
// 1294 	{
// 1295 		WatchdogClear();
??TableIndexBackup_1:
        BL       WatchdogClear
// 1296 
// 1297 		verify = *ptr;
        LDRB     R8,[R6, #+0]
// 1298 		if(verify != (INT8U)WriteAT24C64(EEADDR++, *ptr++))
        LDRB     R1,[R6], #+1
        UXTH     R0,R5
        BL       WriteAT24C64
        ADDS     R5,R5,#+1
        UXTB     R0,R0
        CMP      R8,R0
        BNE.N    ??TableIndexBackup_0
// 1299 		{
// 1300 			#ifdef Debug_Mode
// 1301 				Ser1Printf("error\n");
// 1302 			#endif
// 1303 			return;
// 1304 		}
// 1305 	}
        ADDS     R7,R7,#+1
        CMP      R7,R4
        BCC.N    ??TableIndexBackup_1
??TableIndexBackup_0:
        POP      {R4-R8,PC}       ;; return
// 1306 }
// 1307 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1308 void LoadTableConv(void)
// 1309 {
LoadTableConv:
        PUSH     {R4-R6,LR}
// 1310 	INT32U i = 0;
// 1311 	{
// 1312 		INT8U *dptr = (INT8U *)OutputTable;
        LDR.N    R0,??LoadTableConv_0  ;; OutputTable
        LDR      R4,[R0, #+0]
// 1313 		for(i = 0; i < sizeof(__OutputTable); i++)
        MOVS     R5,#+0
        MOVW     R6,#+3096
// 1314 		{
// 1315 			*dptr++ = ReadAT24C64(TableBp + i);
??LoadTableConv_1:
        ADD      R0,R5,#+1024
        UXTH     R0,R0
        BL       ReadAT24C64
        STRB     R0,[R4], #+1
// 1316 		}
        ADDS     R5,R5,#+1
        CMP      R5,R6
        BCC.N    ??LoadTableConv_1
// 1317 	}
// 1318 
// 1319 	{
// 1320 		INT8U *dptr = (INT8U *)AttnOffsetTable;
        LDR.N    R0,??LoadTableConv_0+0x4  ;; AttnOffsetTable
        LDR      R4,[R0, #+0]
// 1321 		for(i = 0; i < sizeof(__AttnOffsetTable); i++)
        MOVS     R5,#+0
        MOVW     R6,#+2479
// 1322 		{
// 1323 			*dptr++ = ReadAT24C64(AttnTableBp + i);
??LoadTableConv_2:
        ADD      R0,R5,#+2048
        UXTH     R0,R0
        BL       ReadAT24C64
        STRB     R0,[R4], #+1
// 1324 		}
        ADDS     R5,R5,#+1
        CMP      R5,R6
        BCC.N    ??LoadTableConv_2
// 1325 	}
// 1326 
// 1327 	{
// 1328 		INT8U *dptr = (INT8U *)AttnTempTable;
        LDR.N    R0,??LoadTableConv_0+0x8  ;; AttnTempTable
        LDR      R4,[R0, #+0]
// 1329 		for(i = 0; i < sizeof(__AttnTempTable); i++)
        MOVS     R5,#+0
// 1330 		{
// 1331 			*dptr++ = ReadAT24C64(AttnTptlTableBp + i);
??LoadTableConv_3:
        ADD      R0,R5,#+3072
        UXTH     R0,R0
        BL       ReadAT24C64
        STRB     R0,[R4], #+1
// 1332 		}
        ADDS     R5,R5,#+1
        CMP      R5,#+336
        BCC.N    ??LoadTableConv_3
// 1333 	}
// 1334 	
// 1335 }
        POP      {R4-R6,PC}       ;; return
        DATA
??LoadTableConv_0:
        DC32     OutputTable
        DC32     AttnOffsetTable
        DC32     AttnTempTable

        END
// 1336 
// 1337 #if 0
// 1338 16 16 16 16 30 00 0a 3a 00 0f ff 76 35 00 01 46 85 ca 03
// 1339 16 16 16 16 30 00 0A 3A 00 00 00 76 2D 00 01 00 ED FA 03
// 1340 
// 1341 
// 1342 16 16 16 16 30 00 0A 3A 00 00 00 76 2D 00 01 00 ED FA 03
// 1343 
// 1344 
// 1345 [ TX ] 16 16 16 16 30 00 0A 3A 00 00 00 76 2D 00 01 00 ED FA 03
// 1346 [ TX ] 16 16 16 16 30 00 0A 3A 00 00 00 76 2D 00 01 0C 2C 76 03
// 1347 [ TX ] 16 16 16 16 30 00 0A 3A 00 00 00 76 2D 00 01 0E 0C 34 03
// 1348 
// 1349 
// 1350 
// 1351 
// 1352 
// 1353 
// 1354 [ TX ] 16 16 16 16 30 00 0a 3a 00 0f ff 76 35 00 01 4d 34 a1 03 
// 1355 
// 1356 [ RX ] 16 16 16 16 30 00 22 52 00 00 00 76 35 00 19 4d 50 16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 27 49 03 
// 1357 
// 1358 [ TX ] 16 16 16 16 30 00 25 55 00 0f ff 75 35 00 1c 4d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 17 b2 03 
// 1359 
// 1360 [ RX ] 16 16 16 16 30 00 22 52 00 00 00 75 35 00 19 4d 50 16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 26 42 03 
// 1361 
// 1362 
// 1363 
// 1364 
// 1365 [ TX ] 16 16 16 16 30 00 25 55 00 ff ff 75 34 00 1c 4e 5a 19 
// 1366 00 00 00 00 00 00 00 00 00 00 
// 1367 00 00 00 00 00 00 00 00 00 00 
// 1368 00 00 00 00 00 d1 ed 03
// 1369 [ RX ] 16 16 16 16 30 05 d5 0a 00 00 00 75 35 05 cc 4e 5a 18 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 01 0b 01 02 02 02 59 01 03 01 01 01 04 01 00 01 05 01 00 01 06 02 00 00 05 03 02 c4 00 05 04 02 15 00 05 05 02 0b 00 05 29 01 a6 05 2a 01 00 05 14 02 c4 00 05 15 02 09 00 05 16 02 ff 00 05 42 01 92 05 43 01 00 05 56 02 c4 00 05 57 02 0c 00 05 58 02 02 00 05 69 01 92 05 6a 01 00 05 6c 01 f6 05 6d 02 11 00 05 6e 02 07 00 05 71 01 a6 05 72 01 00 06 04 01 a6 06 2e 01 00 06 2d 01 00 06 0f 01 92 06 40 01 00 06 3f 01 00 06 74 01 92 06 77 01 00 06 76 01 00 06 7a 01 a6 06 7d 01 00 06 7c 01 00 07 0f 01 00 07 56 01 00 07 55 01 00 10 59 01 00 09 0a 01 01 09 35 01 01 10 51 01 01 10 52 01 01 10 5f 01 01 10 60 01 01 10 5b 01 01 10 5c 01 01 10 5d 01 01 10 5e 01 01 09 22 01 00 09 23 02 00 00 09 2e 02 00 00 a0 00 01 00 a0 01 01 00 a0 06 01 01 a0 0d 01 00 a0 0e 06 00 00 00 00 00 00 a0 0f 0b 30 30 30 30 30 30 30 30 30 30 30 a0 10 13 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 a0 11 01 00 a0 12 05 00 00 00 00 00 a0 13 01 1e a0 14 01 00 a0 2a 01 00 a0 2b 02 00 00 a1 01 01 00 a1 02 01 00 a1 09 01 00 a1 0b 01 00 a1 c2 01 00 a1 59 01 00 a1 5e 01 00 a1 5f 01 32 a1 62 01 00 a1 63 01 00 a1 66 01 00 a1 67 01 14 a1 68 01 00 a1 6a 01 00 a1 6b 01 00 a1 6c 01 00 a1 6d 01 00 a1 bd 03 00 00 00 a1 be 03 01 00 00 a1 c3 01 00 a1 c4 01 00 a1 cd 01 00 a3 48 01 e2 a3 49 01 f6 a3 4a 02 c4 00 a3 4b 02 c4 00 a3 4c 01 01 a3 4d 01 01 a3 67 02 00 00 a3 69 02 00 00 a3 6a 01 00 a3 6b 01 00 a3 6c 01 00 a3 6d 01 00 a3 6e 01 00 a3 70 01 00 a3 71 01 00 a3 72 01 00 a3 73 02 18 00 a3 74 02 0c 00 a3 91 01 00 a3 92 01 00 a8 00 4c 00 00 00 00 00 00 00 00 00 00 00 01 00 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 00 04 00 00 00 00 00 01 00 01 00 01 00 01 00 00 00 00 05 c8 00 00 00 00 0a 4a 03 25 00 00 00 00 00 00 00 00 00 01 a8 01 16 00 00 88 88 88 88 00 88 88 00 00 88 88 00 00 88 88 88 88 00 00 00 a8 02 16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 03 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 04 2b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 05 01 00 a8 06 01 00 a8 07 01 00 a8 08 01 00 a8 0b 01 00 a8 10 01 00 a8 11 01 32 a8 14 01 00 a8 15 01 00 a8 18 01 00 a8 19 01 14 a8 1a 01 00 a8 1d 01 00 a8 1e 01 00 a8 1f 01 00 a8 20 01 00 a8 22 01 00 a8 23 01 00 a8 24 01 00 a8 25 01 00 a8 26 01 00 a8 27 01 00 a8 28 01 00 a8 29 01 00 a8 2a 01 00 a8 2b 01 00 a8 2c 01 00 a8 2d 01 00 a8 2e 01 01 a8 2f 01 01 a8 30 01 01 a8 31 01 01 a8 42 01 4a a8 43 01 f6 a8 44 02 c4 00 a8 45 02 c4 00 a8 46 02 fb 00 a8 47 02 fb 00 a8 48 02 fb 00 a8 49 02 f1 00 a8 4a 01 01 a8 4b 01 01 a8 4c 02 00 00 a8 4d 02 00 00 a8 4e 01 00 a8 4f 01 00 a8 50 01 00 a8 51 01 00 a8 52 02 0f 00 a8 53 02 14 00 a8 54 01 00 a8 55 01 00 a8 56 01 00 a8 57 01 00 a8 58 01 00 a8 59 01 00 a8 5a 01 00 a8 5b 01 00 a8 5d 01 00 a8 5e 01 00 a8 5f 01 00 a8 60 01 00 0c 00 01 00 0c 01 02 00 00 0c 02 01 00 0c 03 02 00 00 0c 04 02 00 00 0c 05 02 00 00 0c 06 02 00 00 0c 07 02 00 00 0c 08 02 00 00 0c 09 01 00 0c 0a 02 00 00 0c 0b 02 00 00 0c 0c 01 00 0c 0d 0c 00 00 00 00 00 00 00 00 00 00 00 00 0c 0e 06 00 00 00 00 00 00 0c 11 02 00 00 0c 12 02 00 00 0c 13 02 00 00 0c 14 0b 00 04 00 20 9d 42 00 08 91 32 00 e5 03 02 00 00 e5 04 06 00 00 00 00 00 00 e5 05 06 00 00 00 00 00 00 e5 06 06 00 00 00 00 00 00 e5 07 02 00 00 e5 08 02 00 00 e5 09 02 00 00 1b 00 02 f8 00 1b 01 02 0c 00 1b 02 02 02 00 1b 03 01 92 1b 04 01 00 1b 06 02 c4 00 1b 07 02 11 00 1b 08 02 07 00 1b 09 01 a6 1b 10 01 00 1c 00 01 92 1c 03 01 00 1c 02 01 00 1c 05 01 a6 1c 08 01 00 1c 07 01 00 07 57 01 00 07 58 01 00 a9 01 08 00 00 f0 88 00 00 88 88 a9 02 08 00 00 00 00 00 00 00 00 a9 03 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 04 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a9 05 01 00 a9 06 01 00 a9 07 01 00 a9 08 01 00 a9 09 01 00 a9 0a 01 00 a9 0b 01 00 a9 0c 01 00 a9 0f 01 00 a9 10 
// 1370 01 00 a9 13 01 00 a9 14 01 00 a9 15 01 00 a9 16 01 00 a9 18 01 00 a9 19 01 00 a9 1a 01 00 a9 1b 01 00 a9 21 01 00 a9 22 01 00 a9 21 01 00 a9 22 01 00 a9 25 01 01 a9 26 01 01 a9 29 01 00 a9 2a 01 e2 a9 2b 02 00 00 a9 2c 02 00 00 a9 2d 02 37 00 a9 2e 02 37 00 a9 2f 01 01 a9 30 01 01 a9 31 02 00 00 a9 32 02 00 00 a9 33 01 00 a9 34 01 00 a9 35 01 00 a9 36 01 00 a9 37 02 0f 00 a9 38 02 14 00 a9 39 01 00 a9 3a 01 00 b0 f7 03
// 1371 
// 1372 
// 1373 #endif
// 1374  ////////////////////////////////////////////////////////////////////////////////
// 1375 // End of Source File
// 1376 /////////////////////
// 1377 
// 
//   588 bytes in section .rodata
// 2 862 bytes in section .text
// 
// 2 862 bytes of CODE  memory
//   588 bytes of CONST memory
//
//Errors: none
//Warnings: none
