///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:29 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\Alarm /
//                    .c                                                      /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\Alarm /
//                    .c -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_appl_s /
//                    rc_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl_s /
//                    rc_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\sout\ --endian=little --cpu=Cortex-M3 -e     /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\Alarm /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME Alarm

        EXTERN CurrBandSelect_15M
        EXTERN CurrFwd1Attn1_LTE
        EXTERN CurrFwd1Attn1_LTE_A
        EXTERN CurrFwd1Attn2_LTE
        EXTERN CurrFwd1Attn2_LTE_A
        EXTERN CurrFwdAttn1_2G
        EXTERN CurrFwdAttn1_3G
        EXTERN CurrFwdAttn1_Common
        EXTERN CurrFwdAttn1_LTE
        EXTERN CurrFwdAttn1_LTE_A
        EXTERN CurrFwdAttn2_2G
        EXTERN CurrFwdAttn2_3G
        EXTERN CurrFwdAttn2_LTE
        EXTERN CurrFwdAttn2_LTE_A
        EXTERN CurrRvs1Attn1_LTE
        EXTERN CurrRvs1Attn1_LTE_A
        EXTERN CurrRvs1Attn2_LTE
        EXTERN CurrRvs1Attn2_LTE_A
        EXTERN CurrRvs1Attn3_LTE
        EXTERN CurrRvs1Attn3_LTE_A
        EXTERN CurrRvs1Attn4_LTE
        EXTERN CurrRvs1Attn4_LTE_A
        EXTERN CurrRvsAttn1_2G
        EXTERN CurrRvsAttn1_3G
        EXTERN CurrRvsAttn1_Common
        EXTERN CurrRvsAttn1_LTE
        EXTERN CurrRvsAttn1_LTE_A
        EXTERN CurrRvsAttn2_2G
        EXTERN CurrRvsAttn2_3G
        EXTERN CurrRvsAttn2_LTE
        EXTERN CurrRvsAttn2_LTE_A
        EXTERN CurrRvsAttn3_2G
        EXTERN CurrRvsAttn3_3G
        EXTERN CurrRvsAttn3_LTE
        EXTERN CurrRvsAttn3_LTE_A
        EXTERN CurrRvsAttn4_3G
        EXTERN CurrRvsAttn4_LTE
        EXTERN CurrRvsAttn4_LTE_A
        EXTERN InitStart
        EXTERN tDnrSts

        PUBLIC AlarmCheckUpdate
        PUBLIC AlarmCheck_TRIO
        PUBLIC AlarmInitialize
        PUBLIC AttnOutBufferInit
        PUBLIC ChkAlarm
        PUBLIC DelayLoopAlarm
        PUBLIC InitALC
        PUBLIC InitALCCheck
        PUBLIC ModuleAlarmCheck
        PUBLIC PwrAlarm
        PUBLIC PwrAlarmChange
        PUBLIC PwrAlarmPre
        PUBLIC PwrAlarmTimer
        PUBLIC ResetCaseBackup
        PUBLIC UPdateAlarm
        PUBLIC rambackup
        PUBLIC tAttAccu
        PUBLIC tDelayAlarmCnt
        PUBLIC tTimeRemain

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\Alarm.c
//    1 /*********************************************
//    2 * File Name          : alarm.c
//    3 * Author             :
//    4 * Date First Issued  : 10/20/2010
//    5 * Description        : This file provides all the port/input/update firmware functions.
//    6 * $Revision: 0.1 $
//    7 * $Revision date: 2010.10.__
//    8 ********************************************************************************/
//    9 
//   10 #define ALARM_C
//   11 
//   12 #include "../include/main.h"

        SECTION `.data`:DATA:NOROOT(2)
// INT8U *__data rambackup
rambackup:
        DATA
        DC32 2000BF9CH

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data tAttAccu
tAttAccu:
        DATA
        DC8 1

        SECTION `.bss`:DATA:NOROOT(2)
// __PwrAlmStr __data PwrAlarm
PwrAlarm:
        DS8 60
// __PwrAlmStr __data PwrAlarmChange
PwrAlarmChange:
        DS8 60
// __PwrAlmStr __data PwrAlarmPre
PwrAlarmPre:
        DS8 60
// __PwrAlmStr __data PwrAlarmTimer
PwrAlarmTimer:
        DS8 60

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data ChkAlarm
ChkAlarm:
        DATA
        DC8 0
// INT8U __data InitALC
InitALC:
        DC8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data InitALCCheck
InitALCCheck:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data tDelayAlarmCnt
tDelayAlarmCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DelayLoopAlarm
DelayLoopAlarm:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT32U __data tTimeRemain
tTimeRemain:
        DS8 4
//   13  #include <stdlib.h>
//   14 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   15 void AlarmInitialize(void)
//   16 {
//   17 	__Dnr_Sts *Sts = tDnrSts;
AlarmInitialize:
        LDR.W    R0,??DataTable3  ;; tDnrSts
        LDR      R0,[R0, #+0]
//   18 
//   19 	Sts->Flag.FwdOutLowerLmtFail_2G 	= SET;
//   20 	Sts->Flag.FwdOutUpperLmtFail_2G 	= SET;
//   21 	Sts->Flag.FwdInUpperLmtFail_2G		= SET;
        LDRB     R1,[R0, #+1]
        ORR      R1,R1,#0x70
        STRB     R1,[R0, #+1]
//   22 	Sts->Flag.OverInAlarm_3G			= SET;
//   23 	Sts->Flag.FwdOutLowerLmtFail_3G 	= SET;
//   24 	Sts->Flag.FwdOutUpperLmtFail_3G 	= SET;
//   25 	Sts->Flag.FwdInUpperLmtFail_3G		= SET;
        LDRB     R1,[R0, #+0]
        ORR      R1,R1,#0x78
        STRB     R1,[R0, #+0]
//   26 	Sts->Flag.FwdOutLowerLmtFail_LTE_A	= SET;
//   27 	Sts->Flag.FwdOutUpperLmtFail_LTE_A	= SET;
//   28 	Sts->Flag.FwdInUpperLmtFail_LTE_A	= SET;
        LDRB     R1,[R0, #+2]
        ORR      R1,R1,#0x70
//   29 	Sts->Flag.OverInAlarm_Common		= SET;
//   30 	Sts->Flag.FwdOutLowerLmtFail_LTE	= SET;
//   31 	Sts->Flag.FwdOutUpperLmtFail_LTE	= SET;
//   32 	Sts->Flag.FwdInUpperLmtFail_LTE 	= SET;
        LDRB     R2,[R0, #+1]
        ORR      R2,R2,#0xF
        STRB     R2,[R0, #+1]
//   33 	Sts->Flag.Fwd1PllFail_LTE_A 		= SET;
//   34 	Sts->Flag.Fwd1PllFail_LTE			= SET;
//   35 	Sts->Flag.FwdPllFail_LTE_A			= SET;
//   36 	Sts->Flag.FwdPllFail_Common 		= SET;
//   37 	Sts->Flag.FwdPllFail_3G 			= SET;
        LDRB     R2,[R0, #+4]
        ORR      R2,R2,#0x7C
        STRB     R2,[R0, #+4]
//   38 	Sts->Flag.OverInAlarm_LTE_A 		= SET;
        ORR      R1,R1,#0x8
        STRB     R1,[R0, #+2]
//   39 	Sts->Flag.Rvs1PllFail_LTE_A 		= SET;
//   40 	Sts->Flag.Rvs1PllFail_LTE			= SET;
//   41 	Sts->Flag.RvsPllFail_LTE_A			= SET;
//   42 	Sts->Flag.RvsPllFail_Common 		= SET;
//   43 	Sts->Flag.RvsPllFail_3G 			= SET;
        LDRB     R1,[R0, #+5]
        ORR      R1,R1,#0x7C
        STRB     R1,[R0, #+5]
//   44 	Sts->Flag.Rvs1OutUpperLmtFail_LTE_A	= SET;
//   45 	Sts->Flag.Rvs1OutUpperLmtFail_LTE	= SET;
//   46 	Sts->Flag.RvsOutUpperLmtFail_LTE_A	= SET;
//   47 	Sts->Flag.RvsOutUpperLmtFail_LTE	= SET;
//   48 	Sts->Flag.RvsOutUpperLmtFail_2G 	= SET;
//   49 	Sts->Flag.RvsOutUpperLmtFail_3G 	= SET;
        LDRB     R1,[R0, #+6]
        ORR      R1,R1,#0x7E
        STRB     R1,[R0, #+6]
//   50 	Sts->Flag.Amp1OnOff_LTE_A			= SET;
//   51 	Sts->Flag.Amp1OnOff_LTE			= SET;
//   52 	Sts->Flag.AmpOnOff_LTE_A			= SET;
//   53 	Sts->Flag.AmpOnOff_Common			= SET;
//   54 	Sts->Flag.AmpOnOff_3G				= SET;
        LDRB     R1,[R0, #+7]
        ORR      R1,R1,#0x7C
        STRB     R1,[R0, #+7]
//   55 	Sts->Flag.Fwd1OutLowerLmtFail_LTE_A	= SET;
//   56 	Sts->Flag.Fwd1OutUpperLmtFail_LTE_A	= SET;
//   57 	Sts->Flag.Fwd1InUpperLmtFail_LTE_A	= SET;
//   58 	Sts->Flag.Fwd1OutLowerLmtFail_LTE	= SET;
//   59 	Sts->Flag.Fwd1OutUpperLmtFail_LTE	= SET;
//   60 	Sts->Flag.Fwd1InUpperLmtFail_LTE	= SET;
        LDRB     R1,[R0, #+3]
        ORR      R1,R1,#0x7E
        STRB     R1,[R0, #+3]
//   61 	Sts->Flag.ACFail					= SET;
        LDRB     R1,[R0, #+8]
        ORR      R1,R1,#0x40
        STRB     R1,[R0, #+8]
//   62 }
        BX       LR               ;; return
//   63 
//   64 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   65 void ModuleAlarmCheck(void)
//   66 {
ModuleAlarmCheck:
        PUSH     {R4-R8,LR}
//   67 	INT16S cval;
//   68 	INT16S tlimit;
//   69 
//   70 	__Dnr_Sts *Sts = tDnrSts;
        LDR.W    R0,??DataTable3  ;; tDnrSts
        LDR      R0,[R0, #+0]
//   71 
//   72 
//   73 	if(AC_Alarm)			PwrAlarm.ACFail 		= Alarm;
        LDR.W    R3,??ModuleAlarmCheck_0  ;; 0x40010c08
        LDR      R1,[R3, #+0]
        TST      R1,#0x4000
        ITE      NE 
        MOVNE    R4,#+1
        MOVEQ    R4,#+0
//   74 	else					PwrAlarm.ACFail 		= Normal;	 
        LDR.W    R1,??DataTable5  ;; PwrAlarm
        ADD      R2,R1,#+33
        STRB     R4,[R2, #+3]
//   75 
//   76 	if(PLL_Alarm_Common)	PwrAlarm.PLL_Fail_Common = Alarm;
        LDR      R3,[R3, #+0]
        TST      R3,#0x1000
        ITE      NE 
        MOVNE    R3,#+1
        MOVEQ    R3,#+0
//   77 	else					PwrAlarm.PLL_Fail_Common = Normal;
        STRB     R3,[R1, #+0]
//   78 
//   79 	if(PLL_Alarm_Common1)	PwrAlarm.PLL_Fail_Common1 = Alarm;
        LDR.W    R3,??ModuleAlarmCheck_0+0x4  ;; 0x40010808
        LDR      R3,[R3, #+0]
        TST      R3,#0x1000
        ITE      NE 
        MOVNE    R3,#+1
        MOVEQ    R3,#+0
//   80 	else					PwrAlarm.PLL_Fail_Common1 = Normal;
        STRB     R3,[R1, #+1]
//   81 
//   82 
//   83 	if(PLL_Alarm_LTE1)		PwrAlarm.PLL_Fail_LTE1 = Alarm;
        LDR.W    R3,??ModuleAlarmCheck_0+0x8  ;; 0x40011008
        LDR      R4,[R3, #+0]
        TST      R4,#0x100
        ITE      NE 
        MOVNE    R4,#+1
        MOVEQ    R4,#+0
//   84 	else					PwrAlarm.PLL_Fail_LTE1 = Normal;
        STRB     R4,[R1, #+2]
//   85 
//   86 	if(PLL_Alarm_LTE_A1)	PwrAlarm.PLL_Fail_LTE_A1 = Alarm;
        LDR      R3,[R3, #+0]
        TST      R3,#0x80
        ITE      NE 
        MOVNE    R3,#+1
        MOVEQ    R3,#+0
//   87 	else					PwrAlarm.PLL_Fail_LTE_A1 = Normal;
        STRB     R3,[R1, #+3]
//   88 
//   89 	{
//   90 		// DC Alarm
//   91 		cval = Sts->DetVolt.PSUDCVolt.Data;
//   92 		tlimit = Sts->VccDet_Lmt.Data;
//   93 			
//   94 		if(cval <= tlimit)	PwrAlarm.DCFail = Alarm;
//   95 		else				PwrAlarm.DCFail = Alarm;
        MOVS     R3,#+1
        STRB     R3,[R2, #+4]
//   96 	}	
//   97 	
//   98 	{
//   99 		// Upper Limit	WCDMA
//  100 		cval = Sts->FwdOutPwr_3G[0]*10L + Sts->FwdOutPwr_3G[1];
        ADD      R4,R0,#+36
        MOVS     R3,#+10
        LDRSB    R5,[R0, #+36]
        LDRSB    R6,[R4, #+1]
        MLA      R6,R5,R3,R6
//  101 		tlimit = Sts->FwdOutHighLmt_3G[0]*10L + Sts->FwdOutHighLmt_3G[1];
        ADD      R5,R0,#+194
        LDRSB    R7,[R5, #+21]
        LDRSB    R12,[R5, #+22]
        MLA      R7,R7,R3,R12
//  102 		if(cval >= tlimit) PwrAlarm.FwdOutUpperLmtFail_3G = Alarm;
        CMP      R6,R7
        BLT.N    ??ModuleAlarmCheck_1
        MOVS     R6,#+1
        B.N      ??ModuleAlarmCheck_2
//  103 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_1:
        SUBS     R7,R7,#+20
        CMP      R7,R6
        BLT.N    ??ModuleAlarmCheck_3
//  104 		{
//  105 			PwrAlarm.FwdOutUpperLmtFail_3G = Normal;
        MOVS     R6,#+0
??ModuleAlarmCheck_2:
        STRB     R6,[R1, #+9]
//  106 		}
//  107 
//  108 		// Lower Limit
//  109 		cval = Sts->FwdOutPwr_3G[0]*10L + Sts->FwdOutPwr_3G[1];
??ModuleAlarmCheck_3:
        LDRSB    R6,[R0, #+36]
        LDRSB    R7,[R4, #+1]
        MLA      R6,R6,R3,R7
//  110 		tlimit = Sts->FwdOutLowerLmt_3G[0]*10L + Sts->FwdOutLowerLmt_3G[1];
        LDRSB    R7,[R4, #+4]
        LDRSB    R12,[R4, #+5]
        MLA      R7,R7,R3,R12
//  111 		if(cval <= tlimit) PwrAlarm.FwdOutLowerLmtFail_3G = Alarm;
        CMP      R7,R6
        BLT.N    ??ModuleAlarmCheck_4
        MOVS     R6,#+1
        B.N      ??ModuleAlarmCheck_5
//  112 		else if(cval >= tlimit + 20) 
??ModuleAlarmCheck_4:
        ADDS     R7,R7,#+20
        CMP      R6,R7
        BLT.N    ??ModuleAlarmCheck_6
//  113 		{
//  114 			PwrAlarm.FwdOutLowerLmtFail_3G = Normal;
        MOVS     R6,#+0
??ModuleAlarmCheck_5:
        STRB     R6,[R1, #+8]
//  115 		}
//  116 
//  117 		// Rvs Upper Limit	WCDMA  
//  118 		cval = Sts->RvsOutPwr_3G[0]*10L + Sts->RvsOutPwr_3G[1];
??ModuleAlarmCheck_6:
        LDRSB    R6,[R5, #+2]
        LDRSB    R7,[R5, #+3]
        MLA      R6,R6,R3,R7
//  119 		tlimit = Sts->RvsOutUpperLmt_3G[0]*10L + Sts->RvsOutUpperLmt_3G[1];
        LDRSB    R7,[R5, #+9]
        LDRSB    R12,[R5, #+10]
        MLA      R7,R7,R3,R12
//  120 		if(cval >= tlimit) PwrAlarm.RvsOutUpperLmtFail_3G = Alarm;
        CMP      R6,R7
        BLT.N    ??ModuleAlarmCheck_7
        MOVS     R6,#+1
        B.N      ??ModuleAlarmCheck_8
//  121 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_7:
        SUBS     R7,R7,#+20
        CMP      R7,R6
        BLT.N    ??ModuleAlarmCheck_9
//  122 		{
//  123 			PwrAlarm.RvsOutUpperLmtFail_3G = Normal;
        MOVS     R6,#+0
??ModuleAlarmCheck_8:
        STRB     R6,[R1, #+24]
//  124 		}
//  125 
//  126 
//  127 
//  128 		cval = Sts->SmsFwdInPwr_3G;
??ModuleAlarmCheck_9:
        LDRSB    R7,[R0, #+194]
//  129 		tlimit = Sts->OverInAlarmLmt_3G;
        ADDW     R6,R0,#+509
        LDRB     R12,[R6, #+3]
//  130 		
//  131 		if(cval >= tlimit)					PwrAlarm.FwdInUpperLmtFail_3G = Alarm;
        CMP      R7,R12
        BLT.N    ??ModuleAlarmCheck_10
        MOVS     R7,#+1
        B.N      ??ModuleAlarmCheck_11
//  132 		else if(cval <= tlimit - (2*2)) 	PwrAlarm.FwdInUpperLmtFail_3G  = Normal;
??ModuleAlarmCheck_10:
        SUB      R12,R12,#+4
        CMP      R12,R7
        BLT.N    ??ModuleAlarmCheck_12
        MOVS     R7,#+0
??ModuleAlarmCheck_11:
        STRB     R7,[R1, #+10]
//  133 		
//  134 		
//  135 		cval = Sts->Det2Pwr.DetFwdInPwr_3G;
??ModuleAlarmCheck_12:
        LDRSB    R7,[R6, #+33]
//  136 		tlimit = Sts->OtherOverInAlarmLmt_3G;
        LDRB     R12,[R6, #+7]
//  137 		
//  138 		if(cval >= tlimit)					PwrAlarm.OverInAlarm_3G = Alarm;
        CMP      R7,R12
        BLT.N    ??ModuleAlarmCheck_13
        MOVS     R7,#+1
        B.N      ??ModuleAlarmCheck_14
//  139 		else if(cval <= tlimit - (2*2)) 	PwrAlarm.OverInAlarm_3G  = Normal;
??ModuleAlarmCheck_13:
        SUB      R12,R12,#+4
        CMP      R12,R7
        BLT.N    ??ModuleAlarmCheck_15
        MOVS     R7,#+0
??ModuleAlarmCheck_14:
        STRB     R7,[R1, #+7]
//  140 	}
//  141 	
//  142 
//  143 	{
//  144 		// Upper Limit	LTE_A
//  145 		cval = Sts->FwdOutPwr_LTE_A[0]*10L + Sts->FwdOutPwr_LTE_A[1];
??ModuleAlarmCheck_15:
        LDRSB    R7,[R4, #+24]
        LDRSB    R12,[R4, #+25]
        MLA      R12,R7,R3,R12
//  146 		tlimit = Sts->FwdOutHighLmt_LTE_A[0]*10L + Sts->FwdOutHighLmt_LTE_A[1];
        ADD      R7,R0,#+476
        LDRSB    LR,[R7, #+31]
        LDRSB    R8,[R7, #+32]
        MLA      LR,LR,R3,R8
//  147 		if(cval >= tlimit) PwrAlarm.FwdOutUpperLmtFail_LTE_A = Alarm;
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_16
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_17
//  148 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_16:
        SUB      LR,LR,#+20
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_18
//  149 		{
//  150 			PwrAlarm.FwdOutUpperLmtFail_LTE_A = Normal;
        MOV      R12,#+0
??ModuleAlarmCheck_17:
        STRB     R12,[R1, #+12]
//  151 		}
//  152 
//  153 		// Lower Limit
//  154 		cval = Sts->FwdOutPwr_LTE_A[0]*10L + Sts->FwdOutPwr_LTE_A[1];
??ModuleAlarmCheck_18:
        LDRSB    R12,[R4, #+24]
        LDRSB    LR,[R4, #+25]
        MLA      R12,R12,R3,LR
//  155 		tlimit = Sts->FwdOutLowerLmt_LTE_A[0]*10L + Sts->FwdOutLowerLmt_LTE_A[1];
        LDRSB    LR,[R4, #+28]
        LDRSB    R8,[R4, #+29]
        MLA      LR,LR,R3,R8
//  156 		if(cval <= tlimit) PwrAlarm.FwdOutLowerLmtFail_LTE_A = Alarm;
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_19
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_20
//  157 		else if(cval >= tlimit + 20) 
??ModuleAlarmCheck_19:
        ADD      LR,LR,#+20
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_21
//  158 		{
//  159 			PwrAlarm.FwdOutLowerLmtFail_LTE_A = Normal;
        MOV      R12,#+0
??ModuleAlarmCheck_20:
        STRB     R12,[R1, #+11]
//  160 		}
//  161 
//  162 		// Rvs Upper Limit	LTE-A  
//  163 		cval = Sts->RvsOutPwr_LTE_A[0]*10L + Sts->RvsOutPwr_LTE_A[1];
??ModuleAlarmCheck_21:
        LDRSB    R12,[R7, #+5]
        LDRSB    LR,[R7, #+6]
        MLA      R12,R12,R3,LR
//  164 		tlimit = Sts->RvsOutUpperLmt_LTE_A[0]*10L + Sts->RvsOutUpperLmt_LTE_A[1];
        LDRSB    LR,[R7, #+23]
        LDRSB    R8,[R7, #+24]
        MLA      LR,LR,R3,R8
//  165 		if(cval >= tlimit) PwrAlarm.RvsOutUpperLmtFail_LTE_A= Alarm;
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_22
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_23
//  166 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_22:
        SUB      LR,LR,#+20
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_24
//  167 		{
//  168 			PwrAlarm.RvsOutUpperLmtFail_LTE_A = Normal;
        MOV      R12,#+0
??ModuleAlarmCheck_23:
        STRB     R12,[R1, #+21]
//  169 		}
//  170 		
//  171 
//  172 		cval = Sts->SmsFwdInPwr_LTE_A;
??ModuleAlarmCheck_24:
        LDRSB    R12,[R7, #+1]
//  173 		tlimit = Sts->OverInAlarmLmt_LTE_A;
        LDRB     LR,[R6, #+2]
//  174 
//  175 		if(cval >= tlimit)			  		PwrAlarm.FwdInUpperLmtFail_LTE_A = Alarm;
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_25
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_26
//  176 		else if(cval <= tlimit - (2*2))  	PwrAlarm.FwdInUpperLmtFail_LTE_A  = Normal;
??ModuleAlarmCheck_25:
        SUB      LR,LR,#+4
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_27
        MOV      R12,#+0
??ModuleAlarmCheck_26:
        STRB     R12,[R1, #+13]
//  177 
//  178 		
//  179 		cval = Sts->Det2Pwr.DetFwdInPwr_LTE_A;
??ModuleAlarmCheck_27:
        LDRSB    R12,[R6, #+32]
//  180 		tlimit = Sts->OtherOverInAlarmLmt_LTE_A;
        LDRB     LR,[R6, #+6]
//  181 		
//  182 		if(cval >= tlimit)			  		PwrAlarm.OverInAlarm_LTE_A = Alarm;
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_28
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_29
//  183 		else if(cval <= tlimit - (2*2))   	PwrAlarm.OverInAlarm_LTE_A  = Normal;
??ModuleAlarmCheck_28:
        SUB      LR,LR,#+4
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_30
        MOV      R12,#+0
??ModuleAlarmCheck_29:
        STRB     R12,[R1, #+18]
//  184 	}
//  185 
//  186 	{
//  187 		// Upper Limit	CDMA
//  188 		cval = Sts->FwdOutPwr_2G[0]*10L + Sts->FwdOutPwr_2G[1];
??ModuleAlarmCheck_30:
        LDRSB    R12,[R4, #+8]
        LDRSB    LR,[R4, #+9]
        MLA      R12,R12,R3,LR
//  189 		tlimit = Sts->FwdOutHighLmt_2G[0]*10L + Sts->FwdOutHighLmt_2G[1];
        LDRSB    LR,[R5, #+23]
        LDRSB    R8,[R5, #+24]
        MLA      LR,LR,R3,R8
//  190 		if(cval >= tlimit) PwrAlarm.FwdOutUpperLmtFail_2G = Alarm;
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_31
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_32
//  191 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_31:
        SUB      LR,LR,#+20
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_33
//  192 		{
//  193 			PwrAlarm.FwdOutUpperLmtFail_2G = Normal;
        MOV      R12,#+0
??ModuleAlarmCheck_32:
        STRB     R12,[R1, #+5]
//  194 		}
//  195 
//  196 		// Lower Limit
//  197 		cval = Sts->FwdOutPwr_2G[0]*10L + Sts->FwdOutPwr_2G[1];
??ModuleAlarmCheck_33:
        LDRSB    R12,[R4, #+8]
        LDRSB    LR,[R4, #+9]
        MLA      R12,R12,R3,LR
//  198 		tlimit = Sts->FwdOutLowerLmt_2G[0]*10L + Sts->FwdOutLowerLmt_2G[1];
        LDRSB    LR,[R4, #+12]
        LDRSB    R8,[R4, #+13]
        MLA      LR,LR,R3,R8
//  199 		if(cval <= tlimit) PwrAlarm.FwdOutLowerLmtFail_2G = Alarm;
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_34
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_35
//  200 		else if(cval >= tlimit + 20) 
??ModuleAlarmCheck_34:
        ADD      LR,LR,#+20
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_36
//  201 		{
//  202 			PwrAlarm.FwdOutLowerLmtFail_2G = Normal;
        MOV      R12,#+0
??ModuleAlarmCheck_35:
        STRB     R12,[R1, #+4]
//  203 		}
//  204 
//  205 		// Rvs Upper Limit	CDMA
//  206 		cval = Sts->RvsOutPwr_2G[0]*10L + Sts->RvsOutPwr_2G[1];
??ModuleAlarmCheck_36:
        LDRSB    R12,[R5, #+4]
        LDRSB    LR,[R5, #+5]
        MLA      R12,R12,R3,LR
//  207 		tlimit = Sts->RvsOutUpperLmt_2G[0]*10L + Sts->RvsOutUpperLmt_2G[1];
        LDRSB    LR,[R5, #+11]
        LDRSB    R8,[R5, #+12]
        MLA      LR,LR,R3,R8
//  208 		if(cval >= tlimit) PwrAlarm.RvsOutUpperLmtFail_2G= Alarm;
        CMP      R12,LR
        BLT.N    ??ModuleAlarmCheck_37
        MOV      R12,#+1
        B.N      ??ModuleAlarmCheck_38
//  209 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_37:
        SUB      LR,LR,#+20
        CMP      LR,R12
        BLT.N    ??ModuleAlarmCheck_39
//  210 		{
//  211 			PwrAlarm.RvsOutUpperLmtFail_2G= Normal;
        MOV      R12,#+0
??ModuleAlarmCheck_38:
        STRB     R12,[R1, #+23]
//  212 		}
//  213 		
//  214 
//  215 
//  216 		cval = Sts->SmsFwdInPwr_2G;
??ModuleAlarmCheck_39:
        LDRSB    R5,[R5, #+1]
//  217 		tlimit = Sts->OverInAlarmLmt_2G;
        LDRB     R12,[R0, #+509]
//  218 		
//  219 		if(cval >= tlimit)			  	PwrAlarm.FwdInUpperLmtFail_2G = Alarm;
        CMP      R5,R12
        BLT.N    ??ModuleAlarmCheck_40
        MOVS     R5,#+1
        B.N      ??ModuleAlarmCheck_41
//  220 		else if(cval <= tlimit - (2*2)) PwrAlarm.FwdInUpperLmtFail_2G  = Normal;
??ModuleAlarmCheck_40:
        SUB      R12,R12,#+4
        CMP      R12,R5
        BLT.N    ??ModuleAlarmCheck_42
        MOVS     R5,#+0
??ModuleAlarmCheck_41:
        STRB     R5,[R1, #+6]
//  221 		
//  222 		
//  223 		cval = Sts->Det2Pwr.DetFwdInPwr_Common;
??ModuleAlarmCheck_42:
        LDRSB    R5,[R6, #+31]
//  224 		tlimit = Sts->OtherOverInAlarmLmt_2G;
        LDRB     R12,[R6, #+4]
//  225 		
//  226 		if(cval >= tlimit)			  	PwrAlarm.OverInAlarm_Common= Alarm;
        CMP      R5,R12
        BLT.N    ??ModuleAlarmCheck_43
        MOVS     R5,#+1
        B.N      ??ModuleAlarmCheck_44
//  227 		else if(cval <= tlimit - (2*2)) PwrAlarm.OverInAlarm_Common= Normal;
??ModuleAlarmCheck_43:
        SUB      R12,R12,#+4
        CMP      R12,R5
        BLT.N    ??ModuleAlarmCheck_45
        MOVS     R5,#+0
??ModuleAlarmCheck_44:
        STRB     R5,[R1, #+14]
//  228 	}
//  229 
//  230 	{
//  231 		// Upper Limit	LTE
//  232 		cval = Sts->FwdOutPwr_LTE[0]*10L + Sts->FwdOutPwr_LTE[1];
??ModuleAlarmCheck_45:
        LDRSB    R5,[R4, #+16]
        LDRSB    R12,[R4, #+17]
        MLA      R5,R5,R3,R12
//  233 		tlimit = Sts->FwdOutHighLmt_LTE[0]*10L + Sts->FwdOutHighLmt_LTE[1];
        LDRSB    R12,[R7, #+29]
        LDRSB    LR,[R7, #+30]
        MLA      R12,R12,R3,LR
//  234 		if(cval >= tlimit) PwrAlarm.FwdOutUpperLmtFail_LTE = Alarm;
        CMP      R5,R12
        BLT.N    ??ModuleAlarmCheck_46
        MOVS     R5,#+1
        B.N      ??ModuleAlarmCheck_47
//  235 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_46:
        SUB      R12,R12,#+20
        CMP      R12,R5
        BLT.N    ??ModuleAlarmCheck_48
//  236 		{
//  237 			PwrAlarm.FwdOutUpperLmtFail_LTE = Normal;
        MOVS     R5,#+0
??ModuleAlarmCheck_47:
        STRB     R5,[R1, #+16]
//  238 		}
//  239 
//  240 		// Lower Limit
//  241 		cval = Sts->FwdOutPwr_LTE[0]*10L + Sts->FwdOutPwr_LTE[1];
??ModuleAlarmCheck_48:
        LDRSB    R5,[R4, #+16]
        LDRSB    R12,[R4, #+17]
        MLA      R5,R5,R3,R12
//  242 		tlimit = Sts->FwdOutLowerLmt_LTE[0]*10L + Sts->FwdOutLowerLmt_LTE[1];
        LDRSB    R12,[R4, #+20]
        LDRSB    R4,[R4, #+21]
        MLA      R4,R12,R3,R4
//  243 		if(cval <= tlimit) PwrAlarm.FwdOutLowerLmtFail_LTE = Alarm;
        CMP      R4,R5
        BLT.N    ??ModuleAlarmCheck_49
        MOVS     R4,#+1
        B.N      ??ModuleAlarmCheck_50
//  244 		else if(cval >= tlimit + 20) 
??ModuleAlarmCheck_49:
        ADDS     R4,R4,#+20
        CMP      R5,R4
        BLT.N    ??ModuleAlarmCheck_51
//  245 		{
//  246 			PwrAlarm.FwdOutLowerLmtFail_LTE = Normal;
        MOVS     R4,#+0
??ModuleAlarmCheck_50:
        STRB     R4,[R1, #+15]
//  247 		}
//  248 
//  249 		// Rvs Upper Limit	LTE
//  250 		cval = Sts->RvsOutPwr_LTE[0]*10L + Sts->RvsOutPwr_LTE[1];
??ModuleAlarmCheck_51:
        LDRSB    R4,[R7, #+2]
        LDRSB    R5,[R7, #+3]
        MLA      R4,R4,R3,R5
//  251 		tlimit = Sts->RvsOutUpperLmt_LTE[0]*10L + Sts->RvsOutUpperLmt_LTE[1];
        LDRSB    R5,[R7, #+21]
        LDRSB    R7,[R7, #+22]
        MLA      R5,R5,R3,R7
//  252 		if(cval >= tlimit) PwrAlarm.RvsOutUpperLmtFail_LTE= Alarm;
        CMP      R4,R5
        BLT.N    ??ModuleAlarmCheck_52
        MOVS     R4,#+1
        B.N      ??ModuleAlarmCheck_53
//  253 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_52:
        SUBS     R5,R5,#+20
        CMP      R5,R4
        BLT.N    ??ModuleAlarmCheck_54
//  254 		{
//  255 			PwrAlarm.RvsOutUpperLmtFail_LTE = Normal;
        MOVS     R4,#+0
??ModuleAlarmCheck_53:
        STRB     R4,[R1, #+22]
//  256 		}
//  257 		
//  258 		cval = Sts->SmsFwdInPwr_LTE;
??ModuleAlarmCheck_54:
        LDRSB    R4,[R0, #+476]
//  259 		tlimit = Sts->OverInAlarmLmt_LTE;
        LDRB     R5,[R6, #+1]
//  260 
//  261 		if(cval >= tlimit)			  PwrAlarm.FwdInUpperLmtFail_LTE = Alarm;
        CMP      R4,R5
        BLT.N    ??ModuleAlarmCheck_55
        MOVS     R4,#+1
        B.N      ??ModuleAlarmCheck_56
//  262 		else if(cval <= tlimit - (2*2))   PwrAlarm.FwdInUpperLmtFail_LTE  = Normal;
??ModuleAlarmCheck_55:
        SUBS     R5,R5,#+4
        CMP      R5,R4
        BLT.N    ??ModuleAlarmCheck_57
        MOVS     R4,#+0
??ModuleAlarmCheck_56:
        STRB     R4,[R1, #+17]
//  263 		
//  264 	}
//  265 
//  266 #ifdef _MIMO_Type 
//  267 	{
//  268 		// Upper Limit	LTE MIMO
//  269 		cval = Sts->Fwd1OutPwr_LTE[0]*10L + Sts->Fwd1OutPwr_LTE[1];
??ModuleAlarmCheck_57:
        ADDW     R4,R0,#+655
        LDRSB    R5,[R0, #+655]
        LDRSB    R7,[R4, #+1]
        MLA      R7,R5,R3,R7
//  270 		tlimit = Sts->Fwd1OutHighLmt_LTE[0]*10L + Sts->Fwd1OutHighLmt_LTE[1];
        ADDW     R5,R0,#+799
        LDRSB    R12,[R5, #+20]
        LDRSB    LR,[R5, #+21]
        MLA      R12,R12,R3,LR
//  271 		if(cval >= tlimit) PwrAlarm.Fwd1OutUpperLmtFail_LTE = Alarm;
        CMP      R7,R12
        BLT.N    ??ModuleAlarmCheck_58
        MOVS     R7,#+1
        B.N      ??ModuleAlarmCheck_59
//  272 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_58:
        SUB      R12,R12,#+20
        CMP      R12,R7
        BLT.N    ??ModuleAlarmCheck_60
//  273 		{
//  274 			PwrAlarm.Fwd1OutUpperLmtFail_LTE = Normal;
        MOVS     R7,#+0
??ModuleAlarmCheck_59:
        STRB     R7,[R2, #+1]
//  275 		}
//  276 
//  277 		// Lower Limit
//  278 		cval = Sts->Fwd1OutPwr_LTE[0]*10L + Sts->Fwd1OutPwr_LTE[1];
??ModuleAlarmCheck_60:
        LDRSB    R7,[R0, #+655]
        LDRSB    R12,[R4, #+1]
        MLA      R7,R7,R3,R12
//  279 		tlimit = Sts->Fwd1OutLowerLmt_LTE[0]*10L + Sts->Fwd1OutLowerLmt_LTE[1];
        LDRSB    R12,[R4, #+4]
        LDRSB    LR,[R4, #+5]
        MLA      R12,R12,R3,LR
//  280 		if(cval <= tlimit) PwrAlarm.Fwd1OutLowerLmtFail_LTE = Alarm;
        CMP      R12,R7
        BLT.N    ??ModuleAlarmCheck_61
        MOVS     R7,#+1
        B.N      ??ModuleAlarmCheck_62
//  281 		else if(cval >= tlimit + 20) 
??ModuleAlarmCheck_61:
        ADD      R12,R12,#+20
        CMP      R7,R12
        BLT.N    ??ModuleAlarmCheck_63
//  282 		{
//  283 			PwrAlarm.Fwd1OutLowerLmtFail_LTE = Normal;
        MOVS     R7,#+0
??ModuleAlarmCheck_62:
        STRB     R7,[R1, #+33]
//  284 		}
//  285 
//  286 		// Rvs Upper Limit	LTE
//  287 		cval = Sts->Rvs1OutPwr_LTE[0]*10L + Sts->Rvs1OutPwr_LTE[1];
??ModuleAlarmCheck_63:
        LDRSB    R7,[R5, #+2]
        LDRSB    R12,[R5, #+3]
        MLA      R7,R7,R3,R12
//  288 		tlimit = Sts->Rvs1OutUpperLmt_LTE[0]*10L + Sts->Rvs1OutUpperLmt_LTE[1];
        LDRSB    R12,[R5, #+12]
        LDRSB    LR,[R5, #+13]
        MLA      R12,R12,R3,LR
//  289 		if(cval >= tlimit) PwrAlarm.Rvs1OutUpperLmtFail_LTE= Alarm;
        CMP      R7,R12
        BLT.N    ??ModuleAlarmCheck_64
        MOVS     R7,#+1
        B.N      ??ModuleAlarmCheck_65
//  290 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_64:
        SUB      R12,R12,#+20
        CMP      R12,R7
        BLT.N    ??ModuleAlarmCheck_66
//  291 		{
//  292 			PwrAlarm.Rvs1OutUpperLmtFail_LTE = Normal;
        MOVS     R7,#+0
??ModuleAlarmCheck_65:
        STRB     R7,[R1, #+20]
//  293 		}
//  294 		
//  295 
//  296 		cval = Sts->SmsFwd1InPwr_LTE;
??ModuleAlarmCheck_66:
        LDRSB    R0,[R0, #+799]
//  297 		tlimit = Sts->OverInAlarmLmt_LTE;
        LDRB     R6,[R6, #+1]
//  298 
//  299 		if(cval >= tlimit)			  PwrAlarm.Fwd1InUpperLmtFail_LTE = Alarm;
        CMP      R0,R6
        BLT.N    ??ModuleAlarmCheck_67
        MOVS     R0,#+1
        B.N      ??ModuleAlarmCheck_68
//  300 		else if(cval <= tlimit - (2*2))   PwrAlarm.Fwd1InUpperLmtFail_LTE  = Normal;
??ModuleAlarmCheck_67:
        SUBS     R6,R6,#+4
        CMP      R6,R0
        BLT.N    ??ModuleAlarmCheck_69
        MOVS     R0,#+0
??ModuleAlarmCheck_68:
        STRB     R0,[R2, #+2]
//  301 	
//  302 	}
//  303 	
//  304 	{
//  305 		// Upper Limit	LTE-A MIMO
//  306 		cval = Sts->Fwd1OutPwr_LTE_A[0]*10L + Sts->Fwd1OutPwr_LTE_A[1];
??ModuleAlarmCheck_69:
        LDRSB    R0,[R4, #+8]
        LDRSB    R2,[R4, #+9]
        MLA      R0,R0,R3,R2
//  307 		tlimit = Sts->Fwd1OutHighLmt_LTE_A[0]*10L + Sts->Fwd1OutHighLmt_LTE_A[1];
        LDRSB    R2,[R5, #+22]
        LDRSB    R6,[R5, #+23]
        MLA      R2,R2,R3,R6
//  308 		if(cval >= tlimit) PwrAlarm.Fwd1OutUpperLmtFail_LTE_A= Alarm;
        CMP      R0,R2
        BLT.N    ??ModuleAlarmCheck_70
        MOVS     R0,#+1
        B.N      ??ModuleAlarmCheck_71
//  309 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_70:
        SUBS     R2,R2,#+20
        CMP      R2,R0
        BLT.N    ??ModuleAlarmCheck_72
//  310 		{
//  311 			PwrAlarm.Fwd1OutUpperLmtFail_LTE_A= Normal;
        MOVS     R0,#+0
??ModuleAlarmCheck_71:
        STRB     R0,[R1, #+31]
//  312 		}
//  313 
//  314 		// Lower Limit
//  315 		cval = Sts->Fwd1OutPwr_LTE_A[0]*10L + Sts->Fwd1OutPwr_LTE_A[1];
??ModuleAlarmCheck_72:
        LDRSB    R0,[R4, #+8]
        LDRSB    R2,[R4, #+9]
        MLA      R0,R0,R3,R2
//  316 		tlimit = Sts->Fwd1OutLowerLmt_LTE_A[0]*10L + Sts->Fwd1OutLowerLmt_LTE_A[1];
        LDRSB    R2,[R4, #+12]
        LDRSB    R4,[R4, #+13]
        MLA      R2,R2,R3,R4
//  317 		if(cval <= tlimit) PwrAlarm.Fwd1OutLowerLmtFail_LTE_A= Alarm;
        CMP      R2,R0
        BLT.N    ??ModuleAlarmCheck_73
        MOVS     R0,#+1
        B.N      ??ModuleAlarmCheck_74
//  318 		else if(cval >= tlimit + 20) 
??ModuleAlarmCheck_73:
        ADDS     R2,R2,#+20
        CMP      R0,R2
        BLT.N    ??ModuleAlarmCheck_75
//  319 		{
//  320 			PwrAlarm.Fwd1OutLowerLmtFail_LTE_A = Normal;
        MOVS     R0,#+0
??ModuleAlarmCheck_74:
        STRB     R0,[R1, #+30]
//  321 		}
//  322 
//  323 		// Rvs Upper Limit	LTE
//  324 		cval = Sts->Rvs1OutPwr_LTE_A[0]*10L + Sts->Rvs1OutPwr_LTE_A[1];
??ModuleAlarmCheck_75:
        LDRSB    R0,[R5, #+4]
        LDRSB    R2,[R5, #+5]
        MLA      R0,R0,R3,R2
//  325 		tlimit = Sts->Rvs1OutUpperLmt_LTE_A[0]*10L + Sts->Rvs1OutUpperLmt_LTE_A[1];
        LDRSB    R2,[R5, #+14]
        LDRSB    R4,[R5, #+15]
        MLA      R2,R2,R3,R4
//  326 		if(cval >= tlimit) PwrAlarm.Rvs1OutUpperLmtFail_LTE_A = Alarm;
        CMP      R0,R2
        BLT.N    ??ModuleAlarmCheck_76
        MOVS     R0,#+1
        B.N      ??ModuleAlarmCheck_77
//  327 		else if(cval <= tlimit - 20) 
??ModuleAlarmCheck_76:
        SUBS     R2,R2,#+20
        CMP      R2,R0
        BLT.N    ??ModuleAlarmCheck_78
//  328 		{
//  329 			PwrAlarm.Rvs1OutUpperLmtFail_LTE_A = Normal;
        MOVS     R0,#+0
??ModuleAlarmCheck_77:
        STRB     R0,[R1, #+19]
//  330 		}
//  331 	}
//  332 #endif    
//  333 }
??ModuleAlarmCheck_78:
        POP      {R4-R8,PC}       ;; return
        DATA
??ModuleAlarmCheck_0:
        DC32     0x40010c08
        DC32     0x40010808
        DC32     0x40011008
//  334 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  335 void AlarmCheck_TRIO(void)
//  336 {
AlarmCheck_TRIO:
        PUSH     {R4-R6,LR}
//  337 	__Dnr_Sts *Sts = tDnrSts;
        LDR.W    R0,??DataTable3  ;; tDnrSts
        LDR      R4,[R0, #+0]
//  338 	
//  339 	if(ChkAlarm)
        LDR.W    R5,??AlarmCheck_TRIO_0  ;; ChkAlarm
        LDRB     R0,[R5, #+0]
        CBZ      R0,??AlarmCheck_TRIO_1
//  340 	{
//  341 		ModuleAlarmCheck();
        BL       ModuleAlarmCheck
//  342 		InitStart = SET;
        LDR.W    R0,??AlarmCheck_TRIO_0+0x4  ;; InitStart
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  343 
//  344 		if(InitALC)
        LDRB     R0,[R5, #+1]
        CBZ      R0,??AlarmCheck_TRIO_1
//  345 		{
//  346 			InitALC = 0;
        MOVS     R0,#+0
        STRB     R0,[R5, #+1]
//  347 		}
//  348 	}
//  349 
//  350 	Sts->Alm.FwdInUpperLmtFail_3G 		= PwrAlarm.FwdInUpperLmtFail_3G;
??AlarmCheck_TRIO_1:
        LDR.W    R5,??DataTable5  ;; PwrAlarm
        LDRB     R0,[R4, #+9]
        BIC      R0,R0,#0x40
        LDRB     R1,[R5, #+10]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+9]
//  351 	Sts->Alm.FwdOutUpperLmtFail_3G 		= PwrAlarm.FwdOutUpperLmtFail_3G;
        AND      R0,R0,#0xDF
        LDRB     R1,[R5, #+9]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+9]
//  352 	Sts->Alm.FwdOutLowerLmtFail_3G 		= PwrAlarm.FwdOutLowerLmtFail_3G;
        AND      R0,R0,#0xEF
        LDRB     R1,[R5, #+8]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+9]
//  353 	Sts->Alm.OverInAlarm_3G 			= PwrAlarm.OverInAlarm_3G;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+7]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+9]
//  354 	Sts->Alm.FwdInUpperLmtFail_2G 		= PwrAlarm.FwdInUpperLmtFail_2G;
        LDRB     R0,[R4, #+10]
        BIC      R0,R0,#0x40
        LDRB     R1,[R5, #+6]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+10]
//  355 	Sts->Alm.FwdOutUpperLmtFail_2G 		= PwrAlarm.FwdOutUpperLmtFail_2G;
        AND      R0,R0,#0xDF
        LDRB     R1,[R5, #+5]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+10]
//  356 	Sts->Alm.FwdOutLowerLmtFail_2G 		= PwrAlarm.FwdOutLowerLmtFail_2G;
        AND      R0,R0,#0xEF
        LDRB     R1,[R5, #+4]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+10]
//  357 	Sts->Alm.FwdInUpperLmtFail_LTE 		= PwrAlarm.FwdInUpperLmtFail_LTE;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+17]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+10]
//  358 	Sts->Alm.FwdOutUpperLmtFail_LTE 	= PwrAlarm.FwdOutUpperLmtFail_LTE;
        AND      R0,R0,#0xFB
        LDRB     R1,[R5, #+16]
        LSLS     R1,R1,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+10]
//  359 	Sts->Alm.FwdOutLowerLmtFail_LTE 	= PwrAlarm.FwdOutLowerLmtFail_LTE;
        AND      R0,R0,#0xFD
        LDRB     R1,[R5, #+15]
        LSLS     R1,R1,#+1
        AND      R1,R1,#0x2
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+10]
//  360 	Sts->Alm.OverInAlarm_Common 		= PwrAlarm.OverInAlarm_Common;
        AND      R0,R0,#0xFE
        LDRB     R1,[R5, #+14]
        AND      R1,R1,#0x1
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+10]
//  361 	Sts->Alm.FwdInUpperLmtFail_LTE_A 	= PwrAlarm.FwdInUpperLmtFail_LTE_A;
        LDRB     R0,[R4, #+11]
        BIC      R0,R0,#0x40
        LDRB     R1,[R5, #+13]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+11]
//  362 	Sts->Alm.FwdOutUpperLmtFail_LTE_A 	= PwrAlarm.FwdOutUpperLmtFail_LTE_A;
        AND      R0,R0,#0xDF
        LDRB     R1,[R5, #+12]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+11]
//  363 	Sts->Alm.FwdOutLowerLmtFail_LTE_A 	= PwrAlarm.FwdOutLowerLmtFail_LTE_A;
        AND      R0,R0,#0xEF
        LDRB     R1,[R5, #+11]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+11]
//  364 	Sts->Alm.OverInAlarm_LTE_A			= PwrAlarm.OverInAlarm_LTE_A;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+18]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+11]
//  365 	Sts->Alm.FwdPllFail_3G				= PwrAlarm.PLL_Fail_Common;
        LDRB     R0,[R4, #+13]
        BIC      R0,R0,#0x40
        LDRB     R1,[R5, #+0]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+13]
//  366 	Sts->Alm.FwdPllFail_LTE_A			= PwrAlarm.PLL_Fail_Common;
        AND      R0,R0,#0xEF
        LDRB     R1,[R5, #+0]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+13]
//  367 	Sts->Alm.FwdPllFail_Common			= PwrAlarm.PLL_Fail_Common1;
        AND      R0,R0,#0xDF
        LDRB     R1,[R5, #+1]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+13]
//  368 	Sts->Alm.Fwd1PllFail_LTE			= PwrAlarm.PLL_Fail_LTE1;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+2]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+13]
//  369 	Sts->Alm.Fwd1PllFail_LTE_A			= PwrAlarm.PLL_Fail_LTE_A1;
        AND      R0,R0,#0xFB
        LDRB     R1,[R5, #+3]
        LSLS     R1,R1,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+13]
//  370 	Sts->Alm.RvsPllFail_3G				= PwrAlarm.PLL_Fail_Common;
        LDRB     R0,[R4, #+14]
        BIC      R0,R0,#0x40
        LDRB     R1,[R5, #+0]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+14]
//  371 	Sts->Alm.RvsPllFail_LTE_A 			= PwrAlarm.PLL_Fail_Common;
        AND      R0,R0,#0xEF
        LDRB     R1,[R5, #+0]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+14]
//  372 	Sts->Alm.RvsPllFail_Common 			= PwrAlarm.PLL_Fail_Common1;
        AND      R0,R0,#0xDF
        LDRB     R1,[R5, #+1]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+14]
//  373 	Sts->Alm.Rvs1PllFail_LTE			= PwrAlarm.PLL_Fail_LTE1;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+2]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+14]
//  374 	Sts->Alm.Rvs1PllFail_LTE_A			= PwrAlarm.PLL_Fail_LTE_A1;
        AND      R0,R0,#0xFB
        LDRB     R1,[R5, #+3]
        LSLS     R1,R1,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+14]
//  375 	Sts->Alm.RvsOutUpperLmtFail_3G 		= PwrAlarm.RvsOutUpperLmtFail_3G;
        LDRB     R0,[R4, #+15]
        BIC      R0,R0,#0x40
        LDRB     R1,[R5, #+24]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+15]
//  376 	Sts->Alm.RvsOutUpperLmtFail_2G 		= PwrAlarm.RvsOutUpperLmtFail_2G;
        AND      R0,R0,#0xDF
        LDRB     R1,[R5, #+23]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+15]
//  377 	Sts->Alm.RvsOutUpperLmtFail_LTE		= PwrAlarm.RvsOutUpperLmtFail_LTE;
        AND      R0,R0,#0xEF
        LDRB     R1,[R5, #+22]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+15]
//  378 	Sts->Alm.RvsOutUpperLmtFail_LTE_A	= PwrAlarm.RvsOutUpperLmtFail_LTE_A;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+21]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+15]
//  379 	Sts->Alm.Rvs1OutUpperLmtFail_LTE 	= PwrAlarm.Rvs1OutUpperLmtFail_LTE;
        AND      R0,R0,#0xFB
        LDRB     R1,[R5, #+20]
        LSLS     R1,R1,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+15]
//  380 	Sts->Alm.Rvs1OutUpperLmtFail_LTE_A 	= PwrAlarm.Rvs1OutUpperLmtFail_LTE_A;
        AND      R0,R0,#0xFD
        LDRB     R1,[R5, #+19]
        LSLS     R1,R1,#+1
        AND      R1,R1,#0x2
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+15]
//  381 	Sts->Alm.AmpOnOff_3G 				= PwrAlarm.AmpOnOff_3G;
        LDRB     R0,[R4, #+16]
        BIC      R0,R0,#0x40
        LDRB     R1,[R5, #+29]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+16]
//  382 	Sts->Alm.AmpOnOff_Common 			= PwrAlarm.AmpOnOff_Common;
        AND      R0,R0,#0xDF
        LDRB     R1,[R5, #+28]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+16]
//  383 	Sts->Alm.AmpOnOff_LTE_A 			= PwrAlarm.AmpOnOff_LTE_A;
        AND      R0,R0,#0xEF
        LDRB     R1,[R5, #+27]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+16]
//  384 	Sts->Alm.Amp1OnOff_LTE_A 			= PwrAlarm.Amp1OnOff_LTE_A;
        AND      R0,R0,#0xFB
        LDRB     R1,[R5, #+25]
        LSLS     R1,R1,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+16]
//  385 	Sts->Alm.Amp1OnOff_LTE 			= PwrAlarm.Amp1OnOff_LTE;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+26]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+16]
//  386 	Sts->Alm.ACFail 					= PwrAlarm.ACFail;
        ADD      R6,R5,#+32
        LDRB     R0,[R4, #+17]
        BIC      R0,R0,#0x40
        LDRB     R1,[R6, #+4]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+17]
//  387 	Sts->Alm.Fwd1InUpperLmtFail_LTE 	= PwrAlarm.Fwd1InUpperLmtFail_LTE;
        LDRB     R0,[R4, #+12]
        BIC      R0,R0,#0x40
        LDRB     R1,[R6, #+3]
        LSLS     R1,R1,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+12]
//  388 	Sts->Alm.Fwd1OutUpperLmtFail_LTE 	= PwrAlarm.Fwd1OutUpperLmtFail_LTE;
        AND      R0,R0,#0xDF
        LDRB     R1,[R6, #+2]
        LSLS     R1,R1,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+12]
//  389 	Sts->Alm.Fwd1OutLowerLmtFail_LTE 	= PwrAlarm.Fwd1OutLowerLmtFail_LTE;
        AND      R0,R0,#0xEF
        LDRB     R1,[R6, #+1]
        LSLS     R1,R1,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+12]
//  390 	Sts->Alm.Fwd1InUpperLmtFail_LTE_A 	= PwrAlarm.Fwd1InUpperLmtFail_LTE_A;
        AND      R0,R0,#0xF7
        LDRB     R1,[R5, #+32]
        LSLS     R1,R1,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+12]
//  391 	Sts->Alm.Fwd1OutUpperLmtFail_LTE_A 	= PwrAlarm.Fwd1OutUpperLmtFail_LTE_A;
        AND      R0,R0,#0xFB
        LDRB     R1,[R5, #+31]
        LSLS     R1,R1,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+12]
//  392 	Sts->Alm.Fwd1OutLowerLmtFail_LTE_A 	= PwrAlarm.Fwd1OutLowerLmtFail_LTE_A;
        AND      R0,R0,#0xFD
        LDRB     R1,[R5, #+30]
        LSLS     R1,R1,#+1
        AND      R1,R1,#0x2
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+12]
//  393 
//  394 ////////////////////////////////////////////////////////////////
//  395 
//  396 	AlarmCheckUpdate();
        BL       AlarmCheckUpdate
//  397 
//  398 	if(PwrAlarmChange.FwdInUpperLmtFail_3G 		) Sts->NMS_Alarm1.FwdInUpperLmtFail_3G 		= PwrAlarm.FwdInUpperLmtFail_3G;
        ADD      R0,R5,#+64
        LDRB     R1,[R0, #+6]
        CBZ      R1,??AlarmCheck_TRIO_2
        LDRB     R1,[R4, #+18]
        BIC      R1,R1,#0x40
        LDRB     R2,[R5, #+10]
        LSLS     R2,R2,#+6
        AND      R2,R2,#0x40
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+18]
//  399 	if(PwrAlarmChange.FwdOutUpperLmtFail_3G 	) Sts->NMS_Alarm1.FwdOutUpperLmtFail_3G 	= PwrAlarm.FwdOutUpperLmtFail_3G;
??AlarmCheck_TRIO_2:
        LDRB     R1,[R0, #+5]
        CBZ      R1,??AlarmCheck_TRIO_3
        LDRB     R1,[R4, #+18]
        BIC      R1,R1,#0x20
        LDRB     R2,[R5, #+9]
        LSLS     R2,R2,#+5
        AND      R2,R2,#0x20
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+18]
//  400 	if(PwrAlarmChange.FwdOutLowerLmtFail_3G 	) Sts->NMS_Alarm1.FwdOutLowerLmtFail_3G 	= PwrAlarm.FwdOutLowerLmtFail_3G;
??AlarmCheck_TRIO_3:
        LDRB     R1,[R0, #+4]
        CBZ      R1,??AlarmCheck_TRIO_4
        LDRB     R1,[R4, #+18]
        BIC      R1,R1,#0x10
        LDRB     R2,[R5, #+8]
        LSLS     R2,R2,#+4
        AND      R2,R2,#0x10
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+18]
//  401 	if(PwrAlarmChange.OverInAlarm_3G 			) Sts->NMS_Alarm1.OverInAlarm_3G 			= PwrAlarm.OverInAlarm_3G;
??AlarmCheck_TRIO_4:
        LDRB     R1,[R0, #+3]
        CBZ      R1,??AlarmCheck_TRIO_5
        LDRB     R1,[R4, #+18]
        BIC      R1,R1,#0x8
        LDRB     R2,[R5, #+7]
        LSLS     R2,R2,#+3
        AND      R2,R2,#0x8
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+18]
//  402 	if(PwrAlarmChange.FwdInUpperLmtFail_2G 		) Sts->NMS_Alarm1.FwdInUpperLmtFail_2G 		= PwrAlarm.FwdInUpperLmtFail_2G;
??AlarmCheck_TRIO_5:
        LDRB     R1,[R0, #+2]
        CBZ      R1,??AlarmCheck_TRIO_6
        LDRB     R1,[R4, #+19]
        BIC      R1,R1,#0x40
        LDRB     R2,[R5, #+6]
        LSLS     R2,R2,#+6
        AND      R2,R2,#0x40
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+19]
//  403 	if(PwrAlarmChange.FwdOutUpperLmtFail_2G 	) Sts->NMS_Alarm1.FwdOutUpperLmtFail_2G 	= PwrAlarm.FwdOutUpperLmtFail_2G;
??AlarmCheck_TRIO_6:
        LDRB     R1,[R0, #+1]
        CBZ      R1,??AlarmCheck_TRIO_7
        LDRB     R1,[R4, #+19]
        BIC      R1,R1,#0x20
        LDRB     R2,[R5, #+5]
        LSLS     R2,R2,#+5
        AND      R2,R2,#0x20
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+19]
//  404 	if(PwrAlarmChange.FwdOutLowerLmtFail_2G 	) Sts->NMS_Alarm1.FwdOutLowerLmtFail_2G 	= PwrAlarm.FwdOutLowerLmtFail_2G;
??AlarmCheck_TRIO_7:
        LDRB     R1,[R5, #+64]
        CBZ      R1,??AlarmCheck_TRIO_8
        LDRB     R1,[R4, #+19]
        BIC      R1,R1,#0x10
        LDRB     R2,[R5, #+4]
        LSLS     R2,R2,#+4
        AND      R2,R2,#0x10
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+19]
//  405 	if(PwrAlarmChange.FwdInUpperLmtFail_LTE 	) Sts->NMS_Alarm1.FwdInUpperLmtFail_LTE 	= PwrAlarm.FwdInUpperLmtFail_LTE;
??AlarmCheck_TRIO_8:
        LDRB     R1,[R0, #+13]
        CBZ      R1,??AlarmCheck_TRIO_9
        LDRB     R1,[R4, #+19]
        BIC      R1,R1,#0x8
        LDRB     R2,[R5, #+17]
        LSLS     R2,R2,#+3
        AND      R2,R2,#0x8
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+19]
//  406 	if(PwrAlarmChange.FwdOutUpperLmtFail_LTE 	) Sts->NMS_Alarm1.FwdOutUpperLmtFail_LTE 	= PwrAlarm.FwdOutUpperLmtFail_LTE;
??AlarmCheck_TRIO_9:
        LDRB     R1,[R0, #+12]
        CBZ      R1,??AlarmCheck_TRIO_10
        LDRB     R1,[R4, #+19]
        BIC      R1,R1,#0x4
        LDRB     R2,[R5, #+16]
        LSLS     R2,R2,#+2
        AND      R2,R2,#0x4
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+19]
//  407 	if(PwrAlarmChange.FwdOutLowerLmtFail_LTE 	) Sts->NMS_Alarm1.FwdOutLowerLmtFail_LTE 	= PwrAlarm.FwdOutLowerLmtFail_LTE;
??AlarmCheck_TRIO_10:
        LDRB     R1,[R0, #+11]
        CBZ      R1,??AlarmCheck_TRIO_11
        LDRB     R1,[R4, #+19]
        BIC      R1,R1,#0x2
        LDRB     R2,[R5, #+15]
        LSLS     R2,R2,#+1
        AND      R2,R2,#0x2
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+19]
//  408 	if(PwrAlarmChange.OverInAlarm_Common 		) Sts->NMS_Alarm1.OverInAlarm_Common 		= PwrAlarm.OverInAlarm_Common;
??AlarmCheck_TRIO_11:
        LDRB     R1,[R0, #+10]
        CBZ      R1,??AlarmCheck_TRIO_12
        LDRB     R1,[R4, #+19]
        AND      R1,R1,#0xFE
        LDRB     R2,[R5, #+14]
        AND      R2,R2,#0x1
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+19]
//  409 	if(PwrAlarmChange.FwdInUpperLmtFail_LTE_A 	) Sts->NMS_Alarm1.FwdInUpperLmtFail_LTE_A 	= PwrAlarm.FwdInUpperLmtFail_LTE_A;
??AlarmCheck_TRIO_12:
        LDRB     R1,[R0, #+9]
        CBZ      R1,??AlarmCheck_TRIO_13
        LDRB     R1,[R4, #+20]
        BIC      R1,R1,#0x40
        LDRB     R2,[R5, #+13]
        LSLS     R2,R2,#+6
        AND      R2,R2,#0x40
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+20]
//  410 	if(PwrAlarmChange.FwdOutUpperLmtFail_LTE_A 	) Sts->NMS_Alarm1.FwdOutUpperLmtFail_LTE_A 	= PwrAlarm.FwdOutUpperLmtFail_LTE_A;
??AlarmCheck_TRIO_13:
        LDRB     R1,[R0, #+8]
        CBZ      R1,??AlarmCheck_TRIO_14
        LDRB     R1,[R4, #+20]
        BIC      R1,R1,#0x20
        LDRB     R2,[R5, #+12]
        LSLS     R2,R2,#+5
        AND      R2,R2,#0x20
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+20]
//  411 	if(PwrAlarmChange.FwdOutLowerLmtFail_LTE_A 	) Sts->NMS_Alarm1.FwdOutLowerLmtFail_LTE_A 	= PwrAlarm.FwdOutLowerLmtFail_LTE_A;
??AlarmCheck_TRIO_14:
        LDRB     R1,[R0, #+7]
        CBZ      R1,??AlarmCheck_TRIO_15
        LDRB     R1,[R4, #+20]
        BIC      R1,R1,#0x10
        LDRB     R2,[R5, #+11]
        LSLS     R2,R2,#+4
        AND      R2,R2,#0x10
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+20]
//  412 	if(PwrAlarmChange.OverInAlarm_LTE_A			) Sts->NMS_Alarm1.OverInAlarm_LTE_A			= PwrAlarm.OverInAlarm_LTE_A;
??AlarmCheck_TRIO_15:
        LDRB     R1,[R0, #+14]
        CBZ      R1,??AlarmCheck_TRIO_16
        LDRB     R1,[R4, #+20]
        BIC      R1,R1,#0x8
        LDRB     R2,[R5, #+18]
        LSLS     R2,R2,#+3
        AND      R2,R2,#0x8
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+20]
//  413 #if 0
//  414 	if(PwrAlarmChange.PLL_Fail_Common			) Sts->NMS_Alarm1.FwdPllFail_3G				= PwrAlarm.PLL_Fail_Common;
//  415 	if(PwrAlarmChange.PLL_Fail_Common			) Sts->NMS_Alarm1.FwdPllFail_LTE_A			= PwrAlarm.PLL_Fail_Common;
//  416 	if(PwrAlarmChange.PLL_Fail_Common1			) Sts->NMS_Alarm1.FwdPllFail_Common			= PwrAlarm.PLL_Fail_Common1;
//  417 	if(PwrAlarmChange.PLL_Fail_LTE1				) Sts->NMS_Alarm1.Fwd1PllFail_LTE			= PwrAlarm.PLL_Fail_LTE1;
//  418 	if(PwrAlarmChange.PLL_Fail_LTE_A1			) Sts->NMS_Alarm1.Fwd1PllFail_LTE_A			= PwrAlarm.PLL_Fail_LTE_A1;
//  419 	if(PwrAlarmChange.RvsPllFail_3G				) Sts->NMS_Alarm1.RvsPllFail_3G				= PwrAlarm.PLL_Fail_Common;
//  420 	if(PwrAlarmChange.RvsPllFail_LTE_A 			) Sts->NMS_Alarm1.RvsPllFail_LTE_A 			= PwrAlarm.PLL_Fail_Common;
//  421 	if(PwrAlarmChange.RvsPllFail_Common 		) Sts->NMS_Alarm1.RvsPllFail_Common 		= PwrAlarm.PLL_Fail_Common1;
//  422 	if(PwrAlarmChange.Rvs1PllFail_LTE			) Sts->NMS_Alarm1.Rvs1PllFail_LTE			= PwrAlarm.PLL_Fail_LTE1;
//  423 	if(PwrAlarmChange.Rvs1PllFail_LTE_A			) Sts->NMS_Alarm1.Rvs1PllFail_LTE_A			= PwrAlarm.PLL_Fail_LTE_A1;
//  424 #endif
//  425 	if(PwrAlarmChange.RvsOutUpperLmtFail_3G 	) Sts->NMS_Alarm1.RvsOutUpperLmtFail_3G 	= PwrAlarm.RvsOutUpperLmtFail_3G;
??AlarmCheck_TRIO_16:
        LDRB     R1,[R0, #+20]
        CBZ      R1,??AlarmCheck_TRIO_17
        LDRB     R1,[R4, #+24]
        BIC      R1,R1,#0x40
        LDRB     R2,[R5, #+24]
        LSLS     R2,R2,#+6
        AND      R2,R2,#0x40
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+24]
//  426 	if(PwrAlarmChange.RvsOutUpperLmtFail_2G 	) Sts->NMS_Alarm1.RvsOutUpperLmtFail_2G 	= PwrAlarm.RvsOutUpperLmtFail_2G;
??AlarmCheck_TRIO_17:
        LDRB     R1,[R0, #+19]
        CBZ      R1,??AlarmCheck_TRIO_18
        LDRB     R1,[R4, #+24]
        BIC      R1,R1,#0x20
        LDRB     R2,[R5, #+23]
        LSLS     R2,R2,#+5
        AND      R2,R2,#0x20
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+24]
//  427 	if(PwrAlarmChange.RvsOutUpperLmtFail_LTE	) Sts->NMS_Alarm1.RvsOutUpperLmtFail_LTE	= PwrAlarm.RvsOutUpperLmtFail_LTE;
??AlarmCheck_TRIO_18:
        LDRB     R1,[R0, #+18]
        CBZ      R1,??AlarmCheck_TRIO_19
        LDRB     R1,[R4, #+24]
        BIC      R1,R1,#0x10
        LDRB     R2,[R5, #+22]
        LSLS     R2,R2,#+4
        AND      R2,R2,#0x10
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+24]
//  428 	if(PwrAlarmChange.RvsOutUpperLmtFail_LTE_A	) Sts->NMS_Alarm1.RvsOutUpperLmtFail_LTE_A	= PwrAlarm.RvsOutUpperLmtFail_LTE_A;
??AlarmCheck_TRIO_19:
        LDRB     R1,[R0, #+17]
        CBZ      R1,??AlarmCheck_TRIO_20
        LDRB     R1,[R4, #+24]
        BIC      R1,R1,#0x8
        LDRB     R2,[R5, #+21]
        LSLS     R2,R2,#+3
        AND      R2,R2,#0x8
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+24]
//  429 	if(PwrAlarmChange.Rvs1OutUpperLmtFail_LTE 	) Sts->NMS_Alarm1.Rvs1OutUpperLmtFail_LTE 	= PwrAlarm.Rvs1OutUpperLmtFail_LTE;
??AlarmCheck_TRIO_20:
        LDRB     R1,[R0, #+16]
        CBZ      R1,??AlarmCheck_TRIO_21
        LDRB     R1,[R4, #+24]
        BIC      R1,R1,#0x4
        LDRB     R2,[R5, #+20]
        LSLS     R2,R2,#+2
        AND      R2,R2,#0x4
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+24]
//  430 	if(PwrAlarmChange.Rvs1OutUpperLmtFail_LTE_A	) Sts->NMS_Alarm1.Rvs1OutUpperLmtFail_LTE_A	= PwrAlarm.Rvs1OutUpperLmtFail_LTE_A;
??AlarmCheck_TRIO_21:
        LDRB     R1,[R0, #+15]
        CBZ      R1,??AlarmCheck_TRIO_22
        LDRB     R1,[R4, #+24]
        BIC      R1,R1,#0x2
        LDRB     R2,[R5, #+19]
        LSLS     R2,R2,#+1
        AND      R2,R2,#0x2
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+24]
//  431 	if(PwrAlarmChange.AmpOnOff_3G 				) Sts->NMS_Alarm1.AmpOnOff_3G 				= PwrAlarm.AmpOnOff_3G;
??AlarmCheck_TRIO_22:
        LDRB     R1,[R0, #+25]
        CBZ      R1,??AlarmCheck_TRIO_23
        LDRB     R1,[R4, #+25]
        BIC      R1,R1,#0x40
        LDRB     R2,[R5, #+29]
        LSLS     R2,R2,#+6
        AND      R2,R2,#0x40
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+25]
//  432 	if(PwrAlarmChange.AmpOnOff_Common 			) Sts->NMS_Alarm1.AmpOnOff_Common 			= PwrAlarm.AmpOnOff_Common;
??AlarmCheck_TRIO_23:
        LDRB     R1,[R0, #+24]
        CBZ      R1,??AlarmCheck_TRIO_24
        LDRB     R1,[R4, #+25]
        BIC      R1,R1,#0x20
        LDRB     R2,[R5, #+28]
        LSLS     R2,R2,#+5
        AND      R2,R2,#0x20
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+25]
//  433 	if(PwrAlarmChange.AmpOnOff_LTE_A 			) Sts->NMS_Alarm1.AmpOnOff_LTE_A 			= PwrAlarm.AmpOnOff_LTE_A;
??AlarmCheck_TRIO_24:
        LDRB     R1,[R0, #+23]
        CBZ      R1,??AlarmCheck_TRIO_25
        LDRB     R1,[R4, #+25]
        BIC      R1,R1,#0x10
        LDRB     R2,[R5, #+27]
        LSLS     R2,R2,#+4
        AND      R2,R2,#0x10
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+25]
//  434 	if(PwrAlarmChange.Amp1OnOff_LTE_A 			) Sts->NMS_Alarm1.Amp1OnOff_LTE_A 			= PwrAlarm.Amp1OnOff_LTE_A;
??AlarmCheck_TRIO_25:
        LDRB     R1,[R0, #+21]
        CBZ      R1,??AlarmCheck_TRIO_26
        LDRB     R1,[R4, #+25]
        BIC      R1,R1,#0x4
        LDRB     R2,[R5, #+25]
        LSLS     R2,R2,#+2
        AND      R2,R2,#0x4
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+25]
//  435 	if(PwrAlarmChange.Amp1OnOff_LTE 			) Sts->NMS_Alarm1.Amp1OnOff_LTE 			= PwrAlarm.Amp1OnOff_LTE;
??AlarmCheck_TRIO_26:
        LDRB     R1,[R0, #+22]
        CBZ      R1,??AlarmCheck_TRIO_27
        LDRB     R1,[R4, #+25]
        BIC      R1,R1,#0x8
        LDRB     R2,[R5, #+26]
        LSLS     R2,R2,#+3
        AND      R2,R2,#0x8
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+25]
//  436 	if(PwrAlarmChange.ACFail 					) Sts->NMS_Alarm1.ACFail 					= PwrAlarm.ACFail;
??AlarmCheck_TRIO_27:
        LDRB     R1,[R5, #+96]
        CBZ      R1,??AlarmCheck_TRIO_28
        LDRB     R1,[R4, #+26]
        BIC      R1,R1,#0x40
        LDRB     R2,[R6, #+4]
        LSLS     R2,R2,#+6
        AND      R2,R2,#0x40
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+26]
//  437 	if(PwrAlarmChange.Fwd1InUpperLmtFail_LTE 	) Sts->NMS_Alarm1.Fwd1InUpperLmtFail_LTE 	= PwrAlarm.Fwd1InUpperLmtFail_LTE;
??AlarmCheck_TRIO_28:
        LDRB     R1,[R0, #+31]
        CBZ      R1,??AlarmCheck_TRIO_29
        LDRB     R1,[R4, #+21]
        BIC      R1,R1,#0x40
        LDRB     R2,[R6, #+3]
        LSLS     R2,R2,#+6
        AND      R2,R2,#0x40
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+21]
//  438 	if(PwrAlarmChange.Fwd1OutUpperLmtFail_LTE 	) Sts->NMS_Alarm1.Fwd1OutUpperLmtFail_LTE 	= PwrAlarm.Fwd1OutUpperLmtFail_LTE;
??AlarmCheck_TRIO_29:
        LDRB     R1,[R0, #+30]
        CBZ      R1,??AlarmCheck_TRIO_30
        LDRB     R1,[R4, #+21]
        BIC      R1,R1,#0x20
        LDRB     R2,[R6, #+2]
        LSLS     R2,R2,#+5
        AND      R2,R2,#0x20
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+21]
//  439 	if(PwrAlarmChange.Fwd1OutLowerLmtFail_LTE 	) Sts->NMS_Alarm1.Fwd1OutLowerLmtFail_LTE 	= PwrAlarm.Fwd1OutLowerLmtFail_LTE;
??AlarmCheck_TRIO_30:
        LDRB     R1,[R0, #+29]
        CBZ      R1,??AlarmCheck_TRIO_31
        LDRB     R1,[R4, #+21]
        BIC      R1,R1,#0x10
        LDRB     R2,[R6, #+1]
        LSLS     R2,R2,#+4
        AND      R2,R2,#0x10
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+21]
//  440 	if(PwrAlarmChange.Fwd1InUpperLmtFail_LTE_A 	) Sts->NMS_Alarm1.Fwd1InUpperLmtFail_LTE_A 	= PwrAlarm.Fwd1InUpperLmtFail_LTE_A;
??AlarmCheck_TRIO_31:
        LDRB     R1,[R0, #+28]
        CBZ      R1,??AlarmCheck_TRIO_32
        LDRB     R1,[R4, #+21]
        BIC      R1,R1,#0x8
        LDRB     R2,[R5, #+32]
        LSLS     R2,R2,#+3
        AND      R2,R2,#0x8
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+21]
//  441 	if(PwrAlarmChange.Fwd1OutUpperLmtFail_LTE_A	) Sts->NMS_Alarm1.Fwd1OutUpperLmtFail_LTE_A	= PwrAlarm.Fwd1OutUpperLmtFail_LTE_A;
??AlarmCheck_TRIO_32:
        LDRB     R1,[R0, #+27]
        CBZ      R1,??AlarmCheck_TRIO_33
        LDRB     R1,[R4, #+21]
        BIC      R1,R1,#0x4
        LDRB     R2,[R5, #+31]
        LSLS     R2,R2,#+2
        AND      R2,R2,#0x4
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+21]
//  442 	if(PwrAlarmChange.Fwd1OutLowerLmtFail_LTE_A	) Sts->NMS_Alarm1.Fwd1OutLowerLmtFail_LTE_A	= PwrAlarm.Fwd1OutLowerLmtFail_LTE_A;
??AlarmCheck_TRIO_33:
        LDRB     R0,[R0, #+26]
        CBZ      R0,??AlarmCheck_TRIO_34
        LDRB     R0,[R4, #+21]
        BIC      R0,R0,#0x2
        LDRB     R1,[R5, #+30]
        LSLS     R1,R1,#+1
        AND      R1,R1,#0x2
        ORRS     R0,R1,R0
        STRB     R0,[R4, #+21]
//  443 }
??AlarmCheck_TRIO_34:
        POP      {R4-R6,PC}       ;; return
        Nop      
        DATA
??AlarmCheck_TRIO_0:
        DC32     ChkAlarm
        DC32     InitStart

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     tDnrSts
//  444 
//  445 
//  446 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  447 void AttnOutBufferInit(void)
//  448 {
//  449 	CurrFwdAttn1_2G 		= 0xFF; 
AttnOutBufferInit:
        MOVS     R0,#+255
        LDR.N    R1,??AttnOutBufferInit_0  ;; CurrFwdAttn1_2G
        STRB     R0,[R1, #+0]
//  450 	CurrFwdAttn2_2G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x4  ;; CurrFwdAttn2_2G
        STRB     R0,[R1, #+0]
//  451 	CurrRvsAttn1_2G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x8  ;; CurrRvsAttn1_2G
        STRB     R0,[R1, #+0]
//  452 	CurrRvsAttn2_2G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0xC  ;; CurrRvsAttn2_2G
        STRB     R0,[R1, #+0]
//  453 	CurrRvsAttn3_2G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x10  ;; CurrRvsAttn3_2G
        STRB     R0,[R1, #+0]
//  454 	CurrFwdAttn1_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x14  ;; CurrFwdAttn1_LTE
        STRB     R0,[R1, #+0]
//  455 	CurrFwdAttn2_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x18  ;; CurrFwdAttn2_LTE
        STRB     R0,[R1, #+0]
//  456 	CurrRvsAttn1_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x1C  ;; CurrRvsAttn1_LTE
        STRB     R0,[R1, #+0]
//  457 	CurrRvsAttn2_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x20  ;; CurrRvsAttn2_LTE
        STRB     R0,[R1, #+0]
//  458 	CurrRvsAttn3_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x24  ;; CurrRvsAttn3_LTE
        STRB     R0,[R1, #+0]
//  459 	CurrRvsAttn4_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x28  ;; CurrRvsAttn4_LTE
        STRB     R0,[R1, #+0]
//  460 	CurrFwdAttn1_LTE_A		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x2C  ;; CurrFwdAttn1_LTE_A
        STRB     R0,[R1, #+0]
//  461 	CurrFwdAttn2_LTE_A		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x30  ;; CurrFwdAttn2_LTE_A
        STRB     R0,[R1, #+0]
//  462 	CurrRvsAttn1_LTE_A		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x34  ;; CurrRvsAttn1_LTE_A
        STRB     R0,[R1, #+0]
//  463 	CurrRvsAttn2_LTE_A		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x38  ;; CurrRvsAttn2_LTE_A
        STRB     R0,[R1, #+0]
//  464 	CurrRvsAttn3_LTE_A		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x3C  ;; CurrRvsAttn3_LTE_A
        STRB     R0,[R1, #+0]
//  465 	CurrRvsAttn4_LTE_A		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x40  ;; CurrRvsAttn4_LTE_A
        STRB     R0,[R1, #+0]
//  466 	CurrFwdAttn1_3G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x44  ;; CurrFwdAttn1_3G
        STRB     R0,[R1, #+0]
//  467 	CurrFwdAttn2_3G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x48  ;; CurrFwdAttn2_3G
        STRB     R0,[R1, #+0]
//  468 	CurrRvsAttn1_3G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x4C  ;; CurrRvsAttn1_3G
        STRB     R0,[R1, #+0]
//  469 	CurrRvsAttn2_3G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x50  ;; CurrRvsAttn2_3G
        STRB     R0,[R1, #+0]
//  470 	CurrRvsAttn3_3G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x54  ;; CurrRvsAttn3_3G
        STRB     R0,[R1, #+0]
//  471 	CurrRvsAttn4_3G 		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x58  ;; CurrRvsAttn4_3G
        STRB     R0,[R1, #+0]
//  472 	CurrFwdAttn1_Common 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x5C  ;; CurrFwdAttn1_Common
        STRB     R0,[R1, #+0]
//  473 	CurrRvsAttn1_Common 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x60  ;; CurrRvsAttn1_Common
        STRB     R0,[R1, #+0]
//  474 	CurrFwd1Attn1_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x64  ;; CurrFwd1Attn1_LTE
        STRB     R0,[R1, #+0]
//  475 	CurrFwd1Attn2_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x68  ;; CurrFwd1Attn2_LTE
        STRB     R0,[R1, #+0]
//  476 	CurrRvs1Attn1_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x6C  ;; CurrRvs1Attn1_LTE
        STRB     R0,[R1, #+0]
//  477 	CurrRvs1Attn2_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x70  ;; CurrRvs1Attn2_LTE
        STRB     R0,[R1, #+0]
//  478 	CurrRvs1Attn3_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x74  ;; CurrRvs1Attn3_LTE
        STRB     R0,[R1, #+0]
//  479 	CurrRvs1Attn4_LTE		= 0xFF; 
        LDR.N    R1,??AttnOutBufferInit_0+0x78  ;; CurrRvs1Attn4_LTE
        STRB     R0,[R1, #+0]
//  480 	CurrFwd1Attn1_LTE_A 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x7C  ;; CurrFwd1Attn1_LTE_A
        STRB     R0,[R1, #+0]
//  481 	CurrFwd1Attn2_LTE_A 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x80  ;; CurrFwd1Attn2_LTE_A
        STRB     R0,[R1, #+0]
//  482 	CurrRvs1Attn1_LTE_A 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x84  ;; CurrRvs1Attn1_LTE_A
        STRB     R0,[R1, #+0]
//  483 	CurrRvs1Attn2_LTE_A 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x88  ;; CurrRvs1Attn2_LTE_A
        STRB     R0,[R1, #+0]
//  484 	CurrRvs1Attn3_LTE_A 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x8C  ;; CurrRvs1Attn3_LTE_A
        STRB     R0,[R1, #+0]
//  485 	CurrRvs1Attn4_LTE_A 	= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x90  ;; CurrRvs1Attn4_LTE_A
        STRB     R0,[R1, #+0]
//  486 	
//  487 	CurrBandSelect_15M 		= 0xFF;
        LDR.N    R1,??AttnOutBufferInit_0+0x94  ;; CurrBandSelect_15M
        STRB     R0,[R1, #+0]
//  488 }
        BX       LR               ;; return
        DATA
??AttnOutBufferInit_0:
        DC32     CurrFwdAttn1_2G
        DC32     CurrFwdAttn2_2G
        DC32     CurrRvsAttn1_2G
        DC32     CurrRvsAttn2_2G
        DC32     CurrRvsAttn3_2G
        DC32     CurrFwdAttn1_LTE
        DC32     CurrFwdAttn2_LTE
        DC32     CurrRvsAttn1_LTE
        DC32     CurrRvsAttn2_LTE
        DC32     CurrRvsAttn3_LTE
        DC32     CurrRvsAttn4_LTE
        DC32     CurrFwdAttn1_LTE_A
        DC32     CurrFwdAttn2_LTE_A
        DC32     CurrRvsAttn1_LTE_A
        DC32     CurrRvsAttn2_LTE_A
        DC32     CurrRvsAttn3_LTE_A
        DC32     CurrRvsAttn4_LTE_A
        DC32     CurrFwdAttn1_3G
        DC32     CurrFwdAttn2_3G
        DC32     CurrRvsAttn1_3G
        DC32     CurrRvsAttn2_3G
        DC32     CurrRvsAttn3_3G
        DC32     CurrRvsAttn4_3G
        DC32     CurrFwdAttn1_Common
        DC32     CurrRvsAttn1_Common
        DC32     CurrFwd1Attn1_LTE
        DC32     CurrFwd1Attn2_LTE
        DC32     CurrRvs1Attn1_LTE
        DC32     CurrRvs1Attn2_LTE
        DC32     CurrRvs1Attn3_LTE
        DC32     CurrRvs1Attn4_LTE
        DC32     CurrFwd1Attn1_LTE_A
        DC32     CurrFwd1Attn2_LTE_A
        DC32     CurrRvs1Attn1_LTE_A
        DC32     CurrRvs1Attn2_LTE_A
        DC32     CurrRvs1Attn3_LTE_A
        DC32     CurrRvs1Attn4_LTE_A
        DC32     CurrBandSelect_15M
//  489 
//  490 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  491 void ResetCaseBackup(INT8U Cause)
//  492 {
//  493 	rambackup[0] = Cause;
ResetCaseBackup:
        LDR.N    R1,??ResetCaseBackup_0  ;; rambackup
        LDR      R1,[R1, #+0]
        STRB     R0,[R1, #+0]
//  494 }
        BX       LR               ;; return
        DATA
??ResetCaseBackup_0:
        DC32     rambackup
//  495 
//  496 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  497 INT8U UPdateAlarm(INT8U *CurSts, INT8U *PreSts, INT8U *ChangeFlag, INT8U *AlarmTimer, INT8U AlarmCnt)
//  498 {
UPdateAlarm:
        PUSH     {R4,R5}
        LDR      R4,[SP, #+8]
//  499 	*ChangeFlag = 0;
        MOVS     R5,#+0
        STRB     R5,[R2, #+0]
//  500  	if( (*CurSts) ==  (*PreSts) )
        LDRB     R0,[R0, #+0]
        LDRB     R5,[R1, #+0]
        CMP      R0,R5
        BNE.N    ??UPdateAlarm_0
//  501 	{
//  502 		*AlarmTimer = AlarmCnt;
        STRB     R4,[R3, #+0]
        B.N      ??UPdateAlarm_1
//  503 	}
//  504 	else
//  505  	{
//  506 		if(*AlarmTimer == 0)
??UPdateAlarm_0:
        LDRB     R4,[R3, #+0]
        CMP      R4,#+0
        BNE.N    ??UPdateAlarm_2
//  507 		{
//  508 			*PreSts = *CurSts;
        STRB     R0,[R1, #+0]
//  509 			*ChangeFlag = 1;
        MOVS     R0,#+1
        STRB     R0,[R2, #+0]
//  510 			return TRUE;
        POP      {R4,R5}
        BX       LR
//  511 		}
//  512 		else *AlarmTimer = *AlarmTimer - 1;
??UPdateAlarm_2:
        SUBS     R0,R4,#+1
        STRB     R0,[R3, #+0]
//  513 	}
//  514 	return FALSE;
??UPdateAlarm_1:
        MOVS     R0,#+0
        POP      {R4,R5}
        BX       LR               ;; return
//  515 }
//  516 
//  517 
//  518 
//  519 #define AlmTimerCnt		12L   
//  520 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  521 INT32U AlarmCheckUpdate(void)
//  522 {
AlarmCheckUpdate:
        PUSH     {R3-R7,LR}
//  523 	INT8U  i = 0;
//  524 	INT8U *CurSts = (INT8U *)&PwrAlarm;
//  525 	INT8U *PreSts = (INT8U *)&PwrAlarmPre;
//  526 	INT8U *ChangeFlag = (INT8U *)&PwrAlarmChange;
//  527 	INT8U *AlarmTimer = (INT8U *)&PwrAlarmTimer;
//  528 //	INT8U *AlarmCnt = (INT8U *)&PwrAlarmCnt;
//  529 
//  530 	INT8U tCnt = 0;
        MOVS     R7,#+0
//  531 	////////////////////////////////////////////////////////////////////////////
//  532 	for(i = 0; i < sizeof(__PwrAlmStr); i++)
        MOVS     R5,#+0
        LDR.N    R6,??DataTable5  ;; PwrAlarm
        ADD      R4,R6,#+180
//  533 	{
//  534 		tCnt += UPdateAlarm(CurSts + i, PreSts + i, ChangeFlag + i, AlarmTimer + i, AlmTimerCnt);
??AlarmCheckUpdate_0:
        UXTB     R0,R5
        ADDS     R1,R0,R6
        MOVS     R2,#+12
        PUSH     {R2,LR}
        MOV      R3,R4
        ADD      R2,R1,#+60
        ADDS     R1,R1,#+120
        ADDS     R0,R0,R6
        BL       UPdateAlarm
        ADD      SP,SP,#+8
        ADDS     R7,R0,R7
        UXTB     R7,R7
//  535 	}
        ADDS     R5,R5,#+1
        ADDS     R4,R4,#+1
        CMP      R5,#+57
        BCC.N    ??AlarmCheckUpdate_0
//  536 
//  537 	if(tCnt != 0) return TRUE;
        SUBS     R0,R7,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  538 	return FALSE;
        POP      {R1,R4-R7,PC}    ;; return
//  539 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     PwrAlarm

        END
//  540 
//  541 
//  542 
//  543 
//  544 ////////////////////////
// 
//   247 bytes in section .bss
//     7 bytes in section .data
// 3 212 bytes in section .text
// 
// 3 212 bytes of CODE memory
//   254 bytes of DATA memory
//
//Errors: none
//Warnings: none
