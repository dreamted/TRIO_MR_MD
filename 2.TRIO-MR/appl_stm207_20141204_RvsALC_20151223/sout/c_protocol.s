///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Nov/2010  11:33:56 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\c_pro /
//                    tocol.c                                                 /
//    Command line =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\c_pro /
//                    tocol.c -lcN C:\user\project\HK-DEI\fw\appl_rcub_201011 /
//                    01\sout\ -lB C:\user\project\HK-DEI\fw\appl_rcub_201011 /
//                    01\sout\ -o C:\user\project\HK-DEI\fw\appl_rcub_2010110 /
//                    1\sout\ --endian=little --cpu=Cortex-M3 -e              /
//                    --require_prototypes --fpu=None --dlib_config           /
//                    "C:\compiler\EWARM 5.20\ARM\INC\DLib_Config_Normal.h"   /
//                    -I C:\user\project\HK-DEI\fw\appl_rcub_20101101\include /
//                    \ -I C:\user\project\HK-DEI\fw\appl_rcub_20101101\lib_s /
//                    tm32\inc\ -I C:\user\project\HK-DEI\fw\appl_rcub_201011 /
//                    01\lib_stm32\src\ -I C:\user\project\HK-DEI\fw\appl_rcu /
//                    b_20101101\uC-CPU\ -I C:\user\project\HK-DEI\fw\appl_rc /
//                    ub_20101101\uC-LIB\ -I C:\user\project\HK-DEI\fw\appl_r /
//                    cub_20101101\uCOS-II\Ports\ -I                          /
//                    C:\user\project\HK-DEI\fw\appl_rcub_20101101\uCOS-II\So /
//                    urce\ -I C:\user\project\HK-DEI\fw\appl_rcub_20101101\u /
//                    C-Probe\ -I "C:\compiler\EWARM 5.20\ARM\INC\" -Oh       /
//    List file    =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\sout\c_pro /
//                    tocol.s                                                 /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME c_protocol

        EXTERN BeaconSts
        EXTERN DATEtoInt
        EXTERN FA_Aloc_AutoMode_Set
        EXTERN FPGA_LED_Buff
        EXTERN GenAidData
        EXTERN ModuleInform
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ResetCaseBackup
        EXTERN ResetStart
        EXTERN RoadBackuptobuffer
        EXTERN RvsOSCStep_3G
        EXTERN RvsShutCnt_3G
        EXTERN SerPtr
        EXTERN TimerRegist
        EXTERN Wrcs0
        EXTERN WriteBuffertoBackup
        EXTERN __aeabi_memcpy
        EXTERN defaultip
        EXTERN destport
        EXTERN returnip

        PUBLIC AnalyzeAidData
        PUBLIC GenModuleAutoInformSts
        PUBLIC GenModuleInformSts
        PUBLIC GenRepAidSts
        PUBLIC Inform_CtrlDataCopy
        PUBLIC Initialize
        PUBLIC ItitReallyUnknown
        PUBLIC LoadBackupData
        PUBLIC LocalIPCtrlData
        PUBLIC LocalMacCtrlData
        PUBLIC SetCtrlData
        PUBLIC rambackup

// C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\c_protocol.c
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
//   15 #define Protocol_C
//   16 #define DDR_Protocol_C
//   17 
//   18 #include "../include/main.h"

        SECTION `.data`:DATA:NOROOT(2)
// INT8U *__data rambackup
rambackup:
        DATA
        DC32 2000BF9CH
//   19 
//   20 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   21 INT16U 	GenRepAidSts(INT8U *dptr, __BeaconStsStr *Sts, __ProtocolPtr *nPtr)
//   22 {
GenRepAidSts:
        PUSH     {R4-R7,LR}
        SUB      SP,SP,#+20
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//   23 	INT16U rlen = 0;
//   24 	INT16U i = 0;
//   25     INT8U tmp[2];
//   26 	__BeaconAlarmDataStr Flag = Sts->Flag;
        ADD      R0,SP,#+4
        MOVS     R2,#+7
        BL       __aeabi_memcpy
//   27 	// alarm !!
//   28 	if(nPtr == Wrcs0){
        LDR.W    R0,??GenRepAidSts_0  ;; Wrcs0
        LDR      R0,[R0, #+0]
        CMP      R6,R0
        ITTT     EQ 
//   29 		Flag.FwdAmpLinkFail_3G = 0;
        LDRBEQ   R0,[SP, #+8]
        ANDEQ    R0,R0,#0xFE
        STRBEQ   R0,[SP, #+8]
//   30 	}
//   31 	else{
//   32 
//   33 	}
//   34 	/////////////////////////////////
//   35 	if(Sts->RepeaterType[1] == __COPY_RACK || Sts->RepeaterType[1] == __GEN_RACK) {
        ADDS     R6,R5,#+7
        LDRB     R0,[R6, #+10]
        CMP      R0,#+123
        BEQ.N    ??GenRepAidSts_1
        CMP      R0,#+122
        BNE.N    ??GenRepAidSts_2
//   36 		Flag.ACFail = 0;
//   37 		Flag.DCFail = 0;
//   38 		Flag.BatteryLow = 0;
//   39 		Flag.DoorOpen = 0;
??GenRepAidSts_1:
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xA5
        STRB     R0,[SP, #+4]
        B.N      ??GenRepAidSts_3
//   40 	}
//   41 	else if(Sts->RepeaterType[1] == __COPY_IN || Sts->RepeaterType[1] == __GEN_IN) {
??GenRepAidSts_2:
        CMP      R0,#+120
        BEQ.N    ??GenRepAidSts_4
        CMP      R0,#+118
        BNE.N    ??GenRepAidSts_3
//   42 		Flag.ACFail = 0;
//   43 		Flag.BatteryLow = 0;
??GenRepAidSts_4:
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xED
        STRB     R0,[SP, #+4]
//   44 	}
//   45 
//   46 	dptr[rlen++] = (Aid_RepeaterAlarm >> 8) & 0xff;
??GenRepAidSts_3:
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//   47 	dptr[rlen++] = (Aid_RepeaterAlarm >> 0) & 0xff;
        MOVS     R0,#+1
        STRB     R0,[R4, #+1]
//   48 	dptr[rlen++] = 2 *(sizeof(__BeaconAlarmDataStr));
        MOVS     R0,#+14
        STRB     R0,[R4, #+2]
//   49 	for(i = 0; i < (sizeof(__BeaconAlarmDataStr)); i++)	dptr[rlen++] = *((INT8U *)&(Flag) + i);
        LDRB     R0,[SP, #+4]
        STRB     R0,[R4, #+3]
        MOVS     R0,#+4
        ADDS     R1,R4,#+4
        ADD      R2,SP,#+5
        MOVS     R3,#+3
??GenRepAidSts_5:
        LDRB     R12,[R2], #+1
        STRB     R12,[R1], #+2
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     R12,[R2], #+1
        STRB     R12,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        SUBS     R3,R3,#+1
        BNE.N    ??GenRepAidSts_5
//   50 	for(i = 0; i < (sizeof(__BeaconAlarmDataStr)); i++)	dptr[rlen++] = *((INT8U *)&(Sts->BeaconAlm) + i);
        LDRB     R1,[R5, #+7]
        STRB     R1,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        ADD      R1,R5,#+8
        MOVS     R2,#+3
??GenRepAidSts_6:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     R3,[R1], #+1
        STRB     R3,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        SUBS     R2,R2,#+1
        BNE.N    ??GenRepAidSts_6
//   51 
//   52 
//   53 	// Manufacture !!
//   54 	rlen += GenAidData(Aid_Manufacture, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Manufacture), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+14
        ADDS     R1,R0,R4
        MOV      R0,#+256
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   55 	// Supplier !!
//   56 	rlen += GenAidData(Aid_Supplier, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Supplier), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+15
        ADDS     R1,R0,R4
        MOVW     R0,#+257
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   57 	// RepeaterType !!
//   58 	rlen += GenAidData(Aid_RepeaterType, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RepeaterType[0]), 2);
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+16
        ADDS     R1,R0,R4
        MOV      R0,#+258
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   59 
//   60 	rlen += GenAidData(Aid_SystemVer, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->SWVer), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+18
        ADDS     R1,R0,R4
        MOVW     R0,#+259
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   61 	rlen += GenAidData(Aid_ManufactureDate, (INT8U *)&dptr[rlen], (INT8U *)&(ModuleInform->Manufacture_Date[0]), 3);
        MOVS     R7,R0
        MOVS     R3,#+3
        LDR.W    R1,??DataTable0  ;; ModuleInform
        LDR      R1,[R1, #+0]
        ADD      R2,R1,#+10
        ADDS     R1,R0,R4
        MOVW     R0,#+283
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   62 	
//   63 
//   64 	//tmp = !CWPllLD;
//   65 	//rlen += GenAidData(Aid_CurrentTemp, (INT8U *)&dptr[rlen], (INT8U *)&(tmp), 1);
//   66 	rlen += GenAidData(Aid_CurrentTemp, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrentTemp), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+19
        ADDS     R1,R0,R4
        MOVW     R0,#+513
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   67 
//   68 	rlen += GenAidData(Aid_TempUpperLmt, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->TempUpperLmt), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+20
        ADDS     R1,R0,R4
        MOVW     R0,#+514
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   69 	rlen += GenAidData(Aid_BatteryIns, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->BatteryIns), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+21
        ADDS     R1,R0,R4
        MOV      R0,#+528
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   70 	rlen += GenAidData(Aid_BatteryType, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->BatteryType), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+22
        ADDS     R1,R0,R4
        MOVW     R0,#+535
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   71 	tmp[0] = Sts->BeaconAlm.DrvFwdAmpOnOff_3G;
        LDRB     R1,[R6, #+1]
        AND      R1,R1,#0x8
        LSRS     R1,R1,#+3
        STRB     R1,[SP, #+0]
//   72 	rlen += GenAidData(Aid_DrvFwdAmpOnOff_3G, (INT8U *)&dptr[rlen], (INT8U *)&(tmp[0]), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        ADDS     R1,R0,R4
        MOVW     R0,#+1028
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   73 	tmp[0] = Sts->BeaconAlm.DrvRvsAmpOnOff_3G;
        LDRB     R1,[R6, #+1]
        AND      R1,R1,#0x4
        LSRS     R1,R1,#+2
        STRB     R1,[SP, #+0]
//   74 	rlen += GenAidData(Aid_DrvRvsAmpOnOff_3G, (INT8U *)&dptr[rlen], (INT8U *)&(tmp[0]), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        ADDS     R1,R0,R4
        MOVW     R0,#+1029
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   75 	
//   76 	rlen += GenAidData(Aid_FwdInPwr_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwr_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+68
        ADDS     R1,R0,R4
        MOV      R0,#+1280
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   77 	rlen += GenAidData(Aid_FwdInUpperLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInUpperLmt_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+69
        ADDS     R1,R0,R4
        MOVW     R0,#+1281
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   78 	rlen += GenAidData(Aid_FwdInLowerLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInLowerLmt_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+70
        ADDS     R1,R0,R4
        MOVW     R0,#+1282
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   79 	rlen += GenAidData(Aid_FwdPwr_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdPwr_3G), 2);
        MOVS     R6,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+71
        ADDS     R1,R0,R4
        MOVW     R0,#+1283
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   80 
//   81 /**
//   82 	if(Sts->FwdOutUpperLmt_3G[0] < 0){
//   83 		tmp[0] = abs(Sts->FwdOutUpperLmt_3G[0]) | 0x10;
//   84 		tmp[1] = abs(Sts->FwdOutUpperLmt_3G[1]) | 0x10;
//   85 	}
//   86 	**/
//   87 	rlen += GenAidData(Aid_FwdOutUpperLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutUpperLmt_3G[0]), 2);
        MOVS     R6,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+73
        ADDS     R1,R0,R4
        MOVW     R0,#+1284
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   88 	rlen += GenAidData(Aid_FwdOutLowerLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutLowerLmt_3G[0]), 2);
        MOVS     R6,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+75
        ADDS     R1,R0,R4
        MOVW     R0,#+1285
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   89 	rlen += GenAidData(Aid_FwdOutAttn_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutAttn_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+87
        ADDS     R1,R0,R4
        MOVW     R0,#+1286
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   90 	rlen += GenAidData(Aid_FwdInAttn_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInAttn_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+89
        ADDS     R1,R0,R4
        MOVW     R0,#+1290
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//   91 
//   92     rlen += GenAidData(Aid_Rvs0Gain_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0Gain_3G), 1);
        ADD      R6,R5,#+153
        MOVS     R7,R0
        MOVS     R3,#+1
        MOVS     R2,R6
        ADDS     R1,R0,R4
        MOV      R0,#+1536
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   93 	rlen += GenAidData(Aid_Rvs0Attn_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0Attn_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+24
        ADDS     R1,R0,R4
        MOVW     R0,#+1538
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   94 	rlen += GenAidData(Aid_RvsInPwr_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwr_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+90
        ADDS     R1,R0,R4
        MOV      R0,#+1568
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   95 	rlen += GenAidData(Aid_RvsInUpperLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInUpperLmt_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+91
        ADDS     R1,R0,R4
        MOVW     R0,#+1569
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   96 	rlen += GenAidData(Aid_RvsInLowerLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInLowerLmt_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+92
        ADDS     R1,R0,R4
        MOVW     R0,#+1570
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   97 	rlen += GenAidData(Aid_Rvs0OutPwr_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutPwr_3G[0]), 2); 
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+93
        ADDS     R1,R0,R4
        MOVW     R0,#+1571
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   98 	rlen += GenAidData(Aid_Rvs0OutUpperLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutUpperLmt_3G[0]), 2); 
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+95
        ADDS     R1,R0,R4
        MOVW     R0,#+1572
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//   99 	rlen += GenAidData(Aid_Rvs0OutLowerLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutLowerLmt_3G[0]), 2); 
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+97
        ADDS     R1,R0,R4
        MOVW     R0,#+1573
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  100 
//  101 	rlen += GenAidData(Aid_AmpCapability_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpCapability_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+31
        ADDS     R1,R0,R4
        MOV      R0,#+1800
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  102 	rlen += GenAidData(Aid_AmpManufacture_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpManufacture_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+32
        ADDS     R1,R0,R4
        MOVW     R0,#+1799
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  103 	//rlen += GenAidData(Aid_AmpSerial_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpSerial_3G), 4); 
//  104 	rlen += GenAidData(Aid_AmpOffCase_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->AmpOffCase_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+30
        ADDS     R1,R0,R4
        MOVW     R0,#+1807
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  105 
//  106 	rlen += GenAidData(Aid_CW0OnOff_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->CW0OnOff_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+27
        ADDS     R1,R0,R4
        MOVW     R0,#+2307
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  107 	rlen += GenAidData(Aid_FANo_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FANo_3G), 1); 
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+28
        ADDS     R1,R0,R4
        MOVW     R0,#+2337
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  108 	rlen += GenAidData(Aid_RFPathLossResult_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RFPathLossResult_3G), 1);	
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+152
        ADDS     R1,R0,R4
        MOVW     R0,#+2391
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  109 	rlen += GenAidData(Aid_CFRLvl, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->CFRLvl), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+52
        ADDS     R1,R0,R4
        MOVW     R0,#+5647
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  110 	rlen += GenAidData(Aid_FwdInALCLvl, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInALCLvl), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+150
        ADDS     R1,R0,R4
        MOVW     R0,#+5648
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  111 	
//  112 
//  113 	rlen += GenAidData(Aid_FwdPwr_REP_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdPwrREP_3G), 2);
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+81
        ADDS     R1,R0,R4
        MOV      R0,#+5632
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  114 	rlen += GenAidData(Aid_FwdOut_REPUpperLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOut_REPUpperLmt_3G[0]), 2);
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+83
        ADDS     R1,R0,R4
        MOVW     R0,#+5633
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  115 	rlen += GenAidData(Aid_FwdOut_REPLowerLmt_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOut_REPLowerLmt_3G[0]), 2);
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+85
        ADDS     R1,R0,R4
        MOVW     R0,#+5634
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  116 	rlen += GenAidData(Aid_FwdOutAttn_REP_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutAttn_REP_3G), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+88
        ADDS     R1,R0,R4
        MOVW     R0,#+5635
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  117 	rlen += GenAidData(Aid_FwdInFA_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInFA_3G), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+44
        ADDS     R1,R0,R4
        MOVW     R0,#+5636
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  118 	rlen += GenAidData(Aid_FwdOutFA1_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutFA1_3G), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+45
        ADDS     R1,R0,R4
        MOVW     R0,#+5637
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  119 	rlen += GenAidData(Aid_FwdOutFA2_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutFA2_3G), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+46
        ADDS     R1,R0,R4
        MOVW     R0,#+5638
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  120 
//  121 	tmp[0] = Sts->OutSwitchTime_3G.Byte.High;
        LDRH     R1,[R5, #+49]
        STRB     R1,[SP, #+0]
//  122 	tmp[1] = Sts->OutSwitchTime_3G.Byte.Low;
        LDRH     R1,[R5, #+48]
        STRB     R1,[SP, #+1]
//  123 	rlen += GenAidData(Aid_OutSwitchTime_3G, (INT8U *)&dptr[rlen], (INT8U *)&(tmp), 2);
        MOVS     R7,R0
        MOVS     R3,#+2
        ADD      R2,SP,#+0
        ADDS     R1,R0,R4
        MOVW     R0,#+5641
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  124 	
//  125 	rlen += GenAidData(Aid_OutSwitchAttnOnOff_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->OutSwitchAttnOnOff_3G), 1);	
        MOVS     R7,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+50
        ADDS     R1,R0,R4
        MOVW     R0,#+5642
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  126 
//  127 	rlen += GenAidData(Aid_RFPathLossLvl_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0Gain_3G), 1);
        MOVS     R7,R0
        MOVS     R3,#+1
        MOVS     R2,R6
        ADDS     R1,R0,R4
        MOVW     R0,#+5646
        BL       GenAidData
        ADDS     R0,R0,R7
        UXTH     R0,R0
//  128 	rlen += GenAidData(Aid_StsConSts, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->StsConFail), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+23
        ADDS     R1,R0,R4
        MOVW     R0,#+40981
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  129 	rlen += GenAidData(Aid_AlarmMask, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->AlarmMask), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+174
        ADDS     R1,R0,R4
        MOVW     R0,#+40982
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  130 	rlen += GenAidData(Aid_TPTL_OnOff, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->TPTL_OnOff), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+37
        ADDS     R1,R0,R4
        MOV      R0,#+40960
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  131 	rlen += GenAidData(Aid_TempOffset, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->TempOffset), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+39
        ADDS     R1,R0,R4
        MOVW     R0,#+40961
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  132 	rlen += GenAidData(Aid_RCUAddVer, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RCUAddVer), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+40
        ADDS     R1,R0,R4
        MOVW     R0,#+40966
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  133 	
//  134 	// Adc_Value
//  135 	dptr[rlen++] = (Aid_MhuDetVoltage >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  136 	dptr[rlen++] = (Aid_MhuDetVoltage >> 0) & 0xff;
        MOVS     R2,#+0
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  137 	dptr[rlen++] = sizeof(__CMHUDETVOLT);
        MOVS     R2,#+14
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  138 	{
//  139 		__TBL16 r;
//  140 		
//  141 		for(i = 0; i < sizeof(__CMHUDETVOLT)/2; i++)
        ADD      R1,R5,#+154
        MOVS     R2,#+7
//  142 		{
//  143 			r.Data = *((INT16U *)&Sts->_Det + i);
??GenRepAidSts_7:
        LDRH     R3,[R1], #+2
        STRH     R3,[SP, #+12]
//  144 		
//  145 			dptr[rlen++] = r.Byte.High;
        LDRH     R3,[SP, #+13]
        STRB     R3,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  146 			dptr[rlen++] = r.Byte.Low;
        LDRH     R12,[SP, #+12]
        STRB     R12,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  147 		}
        SUBS     R2,R2,#+1
        BNE.N    ??GenRepAidSts_7
//  148 	}
//  149 	rlen += GenAidData(Aid_FwdInPwrOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPwrOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+101
        ADDS     R1,R0,R4
        MOVW     R0,#+43009
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  150 	rlen += GenAidData(Aid_FwdOutPwrOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutPwrOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+99
        ADDS     R1,R0,R4
        MOVW     R0,#+43012
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  151 	rlen += GenAidData(Aid_FwdPwrREPOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdPwrREPOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+100
        ADDS     R1,R0,R4
        MOVW     R0,#+43013
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  152 	rlen += GenAidData(Aid_RvsInPwrOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInPwrOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+102
        ADDS     R1,R0,R4
        MOVW     R0,#+43014
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  153 	rlen += GenAidData(Aid_Rvs0OutPwrOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0OutPwrOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+103
        ADDS     R1,R0,R4
        MOVW     R0,#+43015
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  154 	rlen += GenAidData(Aid_FwdInAttnTemp_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInAttnTemp_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+114
        ADDS     R1,R0,R4
        MOVW     R0,#+43016
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  155 	rlen += GenAidData(Aid_Rvs0AttnTemp_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0AttnTemp_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+115
        ADDS     R1,R0,R4
        MOVW     R0,#+43017
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  156 	rlen += GenAidData(Aid_FwdInPllFreqOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInPllFreqOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+104
        ADDS     R1,R0,R4
        MOVW     R0,#+43018
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  157 	rlen += GenAidData(Aid_FwdOut1PllFreqOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOut1PllFreqOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+105
        ADDS     R1,R0,R4
        MOVW     R0,#+43019
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  158 	rlen += GenAidData(Aid_FwdOut2PllFreqOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOut2PllFreqOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+106
        ADDS     R1,R0,R4
        MOVW     R0,#+43020
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  159 	rlen += GenAidData(Aid_RvsIn1PllFreqOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsIn1PllFreqOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+107
        ADDS     R1,R0,R4
        MOVW     R0,#+43021
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  160 	rlen += GenAidData(Aid_RvsIn2PllFreqOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsIn2PllFreqOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+108
        ADDS     R1,R0,R4
        MOVW     R0,#+43022
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  161 	rlen += GenAidData(Aid_RvsOutPllFreqOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutPllFreqOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+109
        ADDS     R1,R0,R4
        MOVW     R0,#+43023
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  162 
//  163 	rlen += GenAidData(Aid_Fwd10MHzSelect_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Fwd10MHzSelect_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+47
        ADDS     R1,R0,R4
        MOVW     R0,#+43040
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  164 	rlen += GenAidData(Aid_CFROnOff, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->CFROnOff), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+51
        ADDS     R1,R0,R4
        MOVW     R0,#+43057
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  165 
//  166 	dptr[rlen++] = (Aid_FwdInPllFreqTemp_3G >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  167 	dptr[rlen++] = (Aid_FwdInPllFreqTemp_3G >> 0) & 0xff;
        MOVS     R2,#+16
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  168 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  169 	dptr[rlen++] = Sts->FwdInPllFreqTemp_3G.Byte.High;
        LDRH     R2,[R5, #+119]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  170 	dptr[rlen++] = Sts->FwdInPllFreqTemp_3G.Byte.Low;
        LDRH     R2,[R5, #+118]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  171 
//  172 	dptr[rlen++] = (Aid_FwdOut1PllFreqTemp_3G >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  173 	dptr[rlen++] = (Aid_FwdOut1PllFreqTemp_3G >> 0) & 0xff;
        MOVS     R2,#+17
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  174 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  175 	dptr[rlen++] = Sts->FwdOut1PllFreqTemp_3G.Byte.High;
        LDRH     R2,[R5, #+121]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  176 	dptr[rlen++] = Sts->FwdOut1PllFreqTemp_3G.Byte.Low;
        LDRH     R2,[R5, #+120]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  177 
//  178 	dptr[rlen++] = (Aid_FwdOut2PllFreqTemp_3G >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  179 	dptr[rlen++] = (Aid_FwdOut2PllFreqTemp_3G >> 0) & 0xff;
        MOVS     R2,#+18
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  180 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  181 	dptr[rlen++] = Sts->FwdOut2PllFreqTemp_3G.Byte.High;
        LDRH     R2,[R5, #+123]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  182 	dptr[rlen++] = Sts->FwdOut2PllFreqTemp_3G.Byte.Low;
        LDRH     R2,[R5, #+122]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  183 
//  184 	dptr[rlen++] = (Aid_RvsIn1PllFreqTemp_3G >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  185 	dptr[rlen++] = (Aid_RvsIn1PllFreqTemp_3G >> 0) & 0xff;
        MOVS     R2,#+19
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  186 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  187 	dptr[rlen++] = Sts->RvsIn1PllFreqTemp_3G.Byte.High;
        LDRH     R2,[R5, #+125]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  188 	dptr[rlen++] = Sts->RvsIn1PllFreqTemp_3G.Byte.Low;
        LDRH     R2,[R5, #+124]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  189 
//  190 	dptr[rlen++] = (Aid_RvsIn2PllFreqTemp_3G >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  191 	dptr[rlen++] = (Aid_RvsIn2PllFreqTemp_3G >> 0) & 0xff;
        MOVS     R2,#+20
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  192 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  193 	dptr[rlen++] = Sts->RvsIn2PllFreqTemp_3G.Byte.High;
        LDRH     R2,[R5, #+127]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  194 	dptr[rlen++] = Sts->RvsIn2PllFreqTemp_3G.Byte.Low;
        LDRH     R2,[R5, #+126]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  195 
//  196 	dptr[rlen++] = (Aid_RvsOutPllFreqTemp_3G >> 8) & 0xff;
        MOVS     R2,#+168
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  197 	dptr[rlen++] = (Aid_RvsOutPllFreqTemp_3G >> 0) & 0xff;
        MOVS     R2,#+21
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  198 	dptr[rlen++] = 2;
        MOVS     R2,#+2
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  199 	dptr[rlen++] = Sts->RvsOutPllFreqTemp_3G.Byte.High;
        LDRH     R2,[R5, #+129]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  200 	dptr[rlen++] = Sts->RvsOutPllFreqTemp_3G.Byte.Low;
        LDRH     R2,[R5, #+128]
        STRB     R2,[R0, R4]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
//  201 
//  202 #ifdef __SUNWAVE
//  203 	rlen += GenAidData(Aid_SCRNum, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->SCRNum[0]), 2); 
//  204 	rlen += GenAidData(Aid_CPICHPwr, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->CPICHPwr), 1); 
//  205 	rlen += GenAidData(Aid_PSCHPwr, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->PSCHPwr), 1); 
//  206 	rlen += GenAidData(Aid_SSCHPwr, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->SSCHPwr), 1); 
//  207 	rlen += GenAidData(Aid_PCCPCHPwr, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->PCCPCHPwr), 1); 
//  208 	rlen += GenAidData(Aid_CellBarred, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->CellBarred), 1); 
//  209 	rlen += GenAidData(Aid_ResBarred, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->ResBarred), 1); 
//  210 	rlen += GenAidData(Aid_T_Barred, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->T_Barred), 1); 
//  211 	rlen += GenAidData(Aid_T_Cell, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->T_Cell), 1); 
//  212 	rlen += GenAidData(Aid_MeasureSts, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->MeasureSts), 1); 
//  213 	rlen += GenAidData(Aid_MeasurePeriod, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->MeasurePeriod), 1); 
//  214 #endif	
//  215 	rlen += GenAidData(Aid_RvsInFA1_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInFA1_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+66
        ADDS     R1,R0,R4
        MOVW     R0,#+43070
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  216 	rlen += GenAidData(Aid_RvsInFA2_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsInFA2_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+67
        ADDS     R1,R0,R4
        MOVW     R0,#+43071
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  217 	rlen += GenAidData(Aid_RvsOutFA_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOutFA_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+65
        ADDS     R1,R0,R4
        MOVW     R0,#+43072
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  218 #ifdef __SUNWAVE
//  219 	rlen += GenAidData(Aid_TXCUSWVer, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->TXCUSWVer), 1); 
//  220 #endif
//  221 	rlen += GenAidData(Aid_TXCUModel, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->TXCUModel), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+41
        ADDS     R1,R0,R4
        MOVW     R0,#+43074
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  222 #ifdef __SUNWAVE
//  223 	rlen += GenAidData(Aid_SGCUSWVer, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->SGCUSWVer), 1);
//  224 #endif
//  225 
//  226 	rlen += GenAidData(Aid_FwdAttn1_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAttn1_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+134
        ADDS     R1,R0,R4
        MOVW     R0,#+43079
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  227 	rlen += GenAidData(Aid_FwdAttn2_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAttn2_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+135
        ADDS     R1,R0,R4
        MOVW     R0,#+43080
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  228 	rlen += GenAidData(Aid_FwdAttn3_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAttn3_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+136
        ADDS     R1,R0,R4
        MOVW     R0,#+43081
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  229 	rlen += GenAidData(Aid_FwdAttn4_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdAttn4_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+137
        ADDS     R1,R0,R4
        MOVW     R0,#+43082
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  230 
//  231 	rlen += GenAidData(Aid_RvsAttn1_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn1_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+138
        ADDS     R1,R0,R4
        MOVW     R0,#+43083
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  232 	rlen += GenAidData(Aid_RvsAttn2_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn2_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+139
        ADDS     R1,R0,R4
        MOVW     R0,#+43084
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  233 	rlen += GenAidData(Aid_RvsAttn3_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn3_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+140
        ADDS     R1,R0,R4
        MOVW     R0,#+43085
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  234 	rlen += GenAidData(Aid_RvsAttn4_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsAttn4_3G), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+141
        ADDS     R1,R0,R4
        MOVW     R0,#+43086
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  235 
//  236 	rlen += GenAidData(Aid_Rvs0AttnOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->Rvs0AttnOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+111
        ADDS     R1,R0,R4
        MOVW     R0,#+43087
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  237 	rlen += GenAidData(Aid_FwdPwr_NODEB_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdPwr_NODEB_3G), 2);
        MOVS     R6,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+77
        ADDS     R1,R0,R4
        MOVW     R0,#+43088
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  238 	rlen += GenAidData(Aid_FwdPwr_HPA_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdPwrHPA_3G), 2);
        MOVS     R6,R0
        MOVS     R3,#+2
        ADD      R2,R5,#+79
        ADDS     R1,R0,R4
        MOVW     R0,#+43089
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  239 
//  240 	rlen += GenAidData(Aid_RvsOscLvl, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->RvsOscLvl), 1);	
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+149
        ADDS     R1,R0,R4
        MOVW     R0,#+43090
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  241 	rlen += GenAidData(Aid_CurrentHPATemp, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->CurrentHPATemp), 1);
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+148
        ADDS     R1,R0,R4
        MOVW     R0,#+43091
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  242 	rlen += GenAidData(Aid_FwdInAttnOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdInAttnOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+110
        ADDS     R1,R0,R4
        MOVW     R0,#+43092
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  243 	rlen += GenAidData(Aid_FwdOutAttnOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutAttnOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+112
        ADDS     R1,R0,R4
        MOVW     R0,#+43093
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  244 	rlen += GenAidData(Aid_FwdOutAttnREPOffset_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutAttnREPOffset_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+113
        ADDS     R1,R0,R4
        MOVW     R0,#+43094
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  245 	rlen += GenAidData(Aid_FwdOutAttnTemp_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutAttnTemp_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+116
        ADDS     R1,R0,R4
        MOVW     R0,#+43095
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  246 	rlen += GenAidData(Aid_FwdOutREPTempAttn_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->FwdOutREPTempAttn_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+117
        ADDS     R1,R0,R4
        MOVW     R0,#+43096
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  247 	rlen += GenAidData(Aid_TotalPwrOnOff_3G, (INT8U *)&dptr[rlen], (INT8U *)&(Sts->TotalPwrOnOff_3G), 1); 
        MOVS     R6,R0
        MOVS     R3,#+1
        ADD      R2,R5,#+38
        ADDS     R1,R0,R4
        MOVW     R0,#+43097
        BL       GenAidData
        ADDS     R0,R0,R6
        UXTH     R0,R0
//  248 
//  249 	return rlen;
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
        Nop      
        DATA
??GenRepAidSts_0:
        DC32     Wrcs0
//  250 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable0:
        DC32     ModuleInform
//  251 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  252 INT8U ItitReallyUnknown(INT16U AID_Command)
//  253 {
ItitReallyUnknown:
        MOVS     R1,R0
//  254 	INT8U rval = TRUE;
        MOVS     R0,#+1
//  255 	
//  256 	switch(AID_Command)
        CMP      R1,#+1
        IT       EQ 
//  257 	{
//  258 		case Aid_RepeaterAlarm:
//  259 			rval = FALSE;
        MOVEQ    R0,#+0
//  260 		break;
//  261 	}
//  262 	return rval;
        BX       LR               ;; return
//  263 }
//  264 
//  265 
//  266 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  267 INT8U SetCtrlData(INT16U AID_Command, INT8U *AID_Value, INT8U Length, EE_BACK1 *tptr)
//  268 {
SetCtrlData:
        PUSH     {R3-R5,LR}
//  269 	INT8U rval = 0;
        MOVS     R5,#+0
//  270 	
//  271 	__BeaconStsStr *Sts = BeaconSts;
        LDR.W    R2,??SetCtrlData_0  ;; BeaconSts
        LDR      R4,[R2, #+0]
//  272 
//  273 	switch(AID_Command)
        MOVW     R2,#+514
        SUBS     R0,R0,R2
        BEQ.W    ??SetCtrlData_1
        SUBS     R0,R0,R2
        BEQ.W    ??SetCtrlData_2
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_3
        SUBS     R0,R0,#+252
        BEQ.W    ??SetCtrlData_4
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_5
        SUBS     R0,R0,#+2
        BEQ.W    ??SetCtrlData_6
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_7
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_8
        SUBS     R0,R0,#+4
        BEQ.W    ??SetCtrlData_9
        SUBS     R0,R0,#+248
        BEQ.W    ??SetCtrlData_10
        SUBS     R0,R0,#+31
        BEQ.W    ??SetCtrlData_11
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_12
        SUBS     R0,R0,#+2
        BEQ.W    ??SetCtrlData_13
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_14
        SUBS     R0,R0,#+225
        BEQ.W    ??SetCtrlData_15
        MOVW     R2,#+509
        SUBS     R0,R0,R2
        BEQ.W    ??SetCtrlData_16
        SUBS     R0,R0,#+17
        BEQ.W    ??SetCtrlData_17
        SUBS     R0,R0,#+66
        BEQ.W    ??SetCtrlData_18
        MOVW     R2,#+3243
        SUBS     R0,R0,R2
        BEQ.W    ??SetCtrlData_19
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_20
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_21
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_22
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_23
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_24
        SUBS     R0,R0,#+4
        BEQ.W    ??SetCtrlData_25
        SUBS     R0,R0,#+6
        BEQ.W    ??SetCtrlData_26
        MOVW     R2,#+35312
        SUBS     R0,R0,R2
        BEQ.W    ??SetCtrlData_27
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_28
        SUBS     R0,R0,#+21
        BEQ.W    ??SetCtrlData_29
        MOVW     R2,#+2027
        SUBS     R0,R0,R2
        BEQ.W    ??SetCtrlData_30
        SUBS     R0,R0,#+3
        BEQ.W    ??SetCtrlData_31
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_32
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_33
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_34
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_35
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_36
        SUBS     R0,R0,#+7
        BEQ.W    ??SetCtrlData_37
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_38
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_39
        SUBS     R0,R0,#+14
        BEQ.W    ??SetCtrlData_40
        SUBS     R0,R0,#+30
        BEQ.W    ??SetCtrlData_23
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_24
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_22
        SUBS     R0,R0,#+2
        BEQ.N    ??SetCtrlData_41
        SUBS     R0,R0,#+5
        BEQ.W    ??SetCtrlData_42
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_43
        SUBS     R0,R0,#+7
        BEQ.W    ??SetCtrlData_44
        SUBS     R0,R0,#+3
        BEQ.W    ??SetCtrlData_45
        SUBS     R0,R0,#+2
        BEQ.W    ??SetCtrlData_46
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_47
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_48
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_49
        SUBS     R0,R0,#+1
        BEQ.W    ??SetCtrlData_50
        SUBS     R0,R0,#+1
        ITTT     EQ 
        ADDEQ    R0,R4,#+8
        LDRBEQ   R1,[R1, #+0]
        STRBEQ   R1,[R0, #+30]
        B.N      ??SetCtrlData_51
//  274 	{
//  275 		case Aid_TempUpperLmt:
//  276 			Sts->TempUpperLmt = AID_Value[0];
??SetCtrlData_1:
        ADD      R0,R4,#+8
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+12]
//  277 			tptr->BackUp.TempUpperLmt = Sts->TempUpperLmt;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+12]
        STRB     R0,[R1, #+13]
//  278 			rval = TRUE;
??SetCtrlData_52:
        MOVS     R5,#+1
        B.N      ??SetCtrlData_51
//  279 		break;
//  280 		
//  281 		case Aid_TXCUModel:
//  282 #ifdef __SUNWAVE
//  283 			TXCUCtrl->Type = AID_Value[0];
//  284 			TXCUCtrl->Ctrl.Type = SET;
//  285 #endif
//  286 			{
//  287 				Sts->TXCUModel = AID_Value[0];
??SetCtrlData_41:
        LDRB     R2,[R1, #+0]
        STRB     R2,[R4, #+41]
//  288 				tptr->BackUp.TXCUModel = Sts->TXCUModel;
        ADD      R0,R3,#+41
        STRB     R2,[R0, #+15]
//  289 
//  290 				
//  291 				switch(AID_Value[0])
        LDRB     R0,[R1, #+0]
        CMP      R0,#+2
        BEQ.N    ??SetCtrlData_53
        CMP      R0,#+3
        BEQ.N    ??SetCtrlData_54
        CMP      R0,#+4
        BEQ.N    ??SetCtrlData_55
        CMP      R0,#+5
        BEQ.N    ??SetCtrlData_56
        CMP      R0,#+6
        BEQ.N    ??SetCtrlData_57
//  292 				{
//  293 					case 1:		Sts->RepeaterType[1] = __COPY_IN;	break;
        ADD      R0,R4,#+8
        MOVS     R1,#+120
        B.N      ??SetCtrlData_58
//  294 					case 2:		Sts->RepeaterType[1] = __COPY_OUT;	break;
??SetCtrlData_53:
        ADD      R0,R4,#+8
        MOVS     R1,#+121
        B.N      ??SetCtrlData_58
//  295 					case 3:		Sts->RepeaterType[1] = __GEN_IN;	break;
??SetCtrlData_54:
        ADD      R0,R4,#+8
        MOVS     R1,#+118
        B.N      ??SetCtrlData_58
//  296 					case 4:		Sts->RepeaterType[1] = __GEN_OUT;	break;
??SetCtrlData_55:
        ADD      R0,R4,#+8
        MOVS     R1,#+119
        B.N      ??SetCtrlData_58
//  297 					case 5:		Sts->RepeaterType[1] = __COPY_RACK;	break;
??SetCtrlData_56:
        ADD      R0,R4,#+8
        MOVS     R1,#+123
        B.N      ??SetCtrlData_58
//  298 					case 6:		Sts->RepeaterType[1] = __GEN_RACK;	break;
??SetCtrlData_57:
        ADD      R0,R4,#+8
        MOVS     R1,#+122
??SetCtrlData_58:
        STRB     R1,[R0, #+9]
//  299 					default:	Sts->RepeaterType[1] = __COPY_IN;	break;
//  300 				}
//  301 				tptr->BackUp.RepeaterType = Sts->RepeaterType[1];
        LDRB     R0,[R0, #+9]
        STRB     R0,[R3, #+3]
//  302 			}
//  303 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  304 		break;
//  305 		
//  306 		case Aid_FwdInUpperLmt_3G:
//  307 			Sts->FwdInUpperLmt_3G = AID_Value[0];
??SetCtrlData_4:
        ADD      R0,R4,#+41
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+28]
//  308 			tptr->BackUp.FwdInUpperLmt_3G = Sts->FwdInUpperLmt_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+28]
        STRB     R0,[R1, #+19]
//  309 			rval = TRUE;			
??SetCtrlData_59:
        MOVS     R5,#+1
        B.N      ??SetCtrlData_51
//  310 		break;
//  311 
//  312 		case Aid_FwdInLowerLmt_3G:
//  313 			Sts->FwdInLowerLmt_3G = AID_Value[0];
??SetCtrlData_5:
        ADD      R0,R4,#+41
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+29]
//  314 			tptr->BackUp.FwdInLowerLmt_3G = Sts->FwdInLowerLmt_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+29]
        STRB     R0,[R1, #+20]
//  315 			rval = TRUE;			
        B.N      ??SetCtrlData_52
//  316 		break;
//  317 		
//  318 		case Aid_FwdOutUpperLmt_3G:
//  319 			Sts->FwdOutUpperLmt_3G[0] = AID_Value[0];
??SetCtrlData_6:
        LDRSB    R0,[R1, R5]
        STRB     R0,[R4, #+73]
//  320 			Sts->FwdOutUpperLmt_3G[1] = AID_Value[1];
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, #+1]
        STRB     R1,[R0, #+1]
//  321 			
//  322 			tptr->BackUp.FwdOutUpperLmt_3G[0] = Sts->FwdOutUpperLmt_3G[0];
        ADDS     R1,R3,#+3
        LDRB     R2,[R4, #+73]
        STRB     R2,[R1, #+21]
//  323 			tptr->BackUp.FwdOutUpperLmt_3G[1] = Sts->FwdOutUpperLmt_3G[1];
        LDRB     R0,[R0, #+1]
        STRB     R0,[R1, #+22]
//  324 			rval = TRUE;			
        B.N      ??SetCtrlData_59
//  325 		break;
//  326 
//  327 		case Aid_FwdOutLowerLmt_3G:
//  328 			Sts->FwdOutLowerLmt_3G[0] = AID_Value[0];
??SetCtrlData_7:
        ADD      R0,R4,#+73
        LDRSB    R2,[R1, R5]
        STRB     R2,[R0, #+2]
//  329 			Sts->FwdOutLowerLmt_3G[1] = AID_Value[1];
        LDRSB    R1,[R1, #+1]
        STRB     R1,[R0, #+3]
//  330 			
//  331 			tptr->BackUp.FwdOutLowerLmt_3G[0] = Sts->FwdOutLowerLmt_3G[0];
        ADDS     R1,R3,#+3
        LDRB     R2,[R0, #+2]
        STRB     R2,[R1, #+23]
//  332 			tptr->BackUp.FwdOutLowerLmt_3G[1] = Sts->FwdOutLowerLmt_3G[1];
        LDRB     R0,[R0, #+3]
        STRB     R0,[R1, #+24]
//  333 			rval = TRUE;			
        B.N      ??SetCtrlData_52
//  334 		break;
//  335 
//  336 		case Aid_FwdOut_REPUpperLmt_3G:
//  337 			Sts->FwdOut_REPUpperLmt_3G[0] = AID_Value[0];
??SetCtrlData_19:
        ADD      R0,R4,#+73
        LDRSB    R2,[R1, R5]
        STRB     R2,[R0, #+10]
//  338 			Sts->FwdOut_REPUpperLmt_3G[1] = AID_Value[1];
        LDRSB    R1,[R1, #+1]
        STRB     R1,[R0, #+11]
//  339 			
//  340 			tptr->BackUp.FwdOut_REPUpperLmt_3G[0] = Sts->FwdOut_REPUpperLmt_3G[0];
        ADD      R1,R3,#+41
        LDRB     R2,[R0, #+10]
        STRB     R2,[R1, #+16]
//  341 			tptr->BackUp.FwdOut_REPUpperLmt_3G[1] = Sts->FwdOut_REPUpperLmt_3G[1];
        LDRB     R0,[R0, #+11]
        STRB     R0,[R1, #+17]
//  342 			rval = TRUE;			
??SetCtrlData_60:
        MOVS     R5,#+1
        B.N      ??SetCtrlData_51
//  343 		break;
//  344 		
//  345 		case Aid_FwdOut_REPLowerLmt_3G:
//  346 			Sts->FwdOut_REPLowerLmt_3G[0] = AID_Value[0];
??SetCtrlData_20:
        ADD      R0,R4,#+73
        LDRSB    R2,[R1, R5]
        STRB     R2,[R0, #+12]
//  347 			Sts->FwdOut_REPLowerLmt_3G[1] = AID_Value[1];
        LDRSB    R1,[R1, #+1]
        STRB     R1,[R0, #+13]
//  348 			
//  349 			tptr->BackUp.FwdOut_REPLowerLmt_3G[0] = Sts->FwdOut_REPLowerLmt_3G[0];
        ADD      R1,R3,#+41
        LDRB     R2,[R0, #+12]
        STRB     R2,[R1, #+18]
//  350 			tptr->BackUp.FwdOut_REPLowerLmt_3G[1] = Sts->FwdOut_REPLowerLmt_3G[1];
        LDRB     R0,[R0, #+13]
        STRB     R0,[R1, #+19]
//  351 			rval = TRUE;			
        B.N      ??SetCtrlData_52
//  352 		break;
//  353 
//  354 		case Aid_FwdInAttn_3G:
//  355 #ifdef __SUNWAVE
//  356 			TXCUCtrl->FwdInAttn_3G = AID_Value[0];
//  357 			TXCUCtrl->Ctrl.FwdInAttn_3G = SET;
//  358 #else
//  359 			Sts->FwdInAttn_3G = AID_Value[0];
??SetCtrlData_9:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+16]
//  360 			tptr->BackUp.FwdInAttn_3G = Sts->FwdInAttn_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+16]
        STRB     R0,[R1, #+10]
//  361 			rval = TRUE;			
        B.N      ??SetCtrlData_59
//  362 #endif
//  363 		break;
//  364 
//  365 		case Aid_FwdOutAttn_3G:
//  366 #ifdef __SUNWAVE
//  367 			TXCUCtrl->FwdOut1Attn_3G = AID_Value[0];
//  368 			TXCUCtrl->Ctrl.FwdOut1Attn_3G = SET;
//  369 			TXCUCtrl->Ctrl.FwdOut1AttnALC_3G = 0;
//  370 #else
//  371 			Sts->FwdOutAttn_3G = AID_Value[0];
??SetCtrlData_8:
        LDRB     R2,[R1, #+0]
        ADD      R0,R4,#+73
        STRB     R2,[R0, #+14]
//  372 			tptr->BackUp.FwdOutAttn_3G = Sts->FwdOutAttn_3G;
        ADDS     R0,R3,#+3
        STRB     R2,[R0, #+11]
//  373 			rval = TRUE;
        MOVS     R5,#+1
//  374 #endif
//  375 			Sts->FwdOutAttnInit = AID_Value[0];		
        LDRB     R0,[R1, #+0]
        STRB     R0,[R4, #+170]
        B.N      ??SetCtrlData_51
//  376 		break;
//  377 
//  378     case Aid_FwdAmpOff_3G:
//  379 #ifdef __SUNWAVE
//  380 			PauCtrl->FwdAmpOff_3G = AID_Value[0];
//  381 			PauCtrl->Ctrl.Bit.FwdAmpOff_3G = SET;
//  382 #else
//  383 
//  384 #endif			
//  385 			if(AID_Value[0] == Enable)
??SetCtrlData_15:
        ADD      R0,R4,#+8
        LDRB     R2,[R1, #+0]
        CBNZ     R2,??SetCtrlData_61
//  386 			{
//  387 				Sts->BeaconAlm.FwdAmpHighTempFail_3G = 0;
//  388 				Sts->BeaconAlm.FwdAmpOvrPwrFail_3G = 0;
//  389 				Sts->BeaconAlm.FwdAmpVSWRFail_3G = 0;
        LDRB     R2,[R0, #+3]
        AND      R2,R2,#0x8F
        STRB     R2,[R0, #+3]
//  390 			}
//  391 			
//  392 			RvsOSCStep_3G = 0;
??SetCtrlData_61:
        LDR.W    R2,??SetCtrlData_0+0x4  ;; RvsOSCStep_3G
        MOV      R12,R5
        STRB     R12,[R2, #+0]
//  393 			RvsShutCnt_3G = 0;
        LDR.W    R2,??SetCtrlData_0+0x8  ;; RvsShutCnt_3G
        STRB     R12,[R2, #+0]
//  394 			Sts->BeaconAlm.RvsOsc_3G = 0;
        LDRB     R2,[R0, #+2]
        AND      R2,R2,#0xBF
        STRB     R2,[R0, #+2]
//  395 			Sts->BeaconAlm.RvsOsc_3G_LED = 0;
        LDRB     R2,[R0, #+4]
        AND      R2,R2,#0x7F
        STRB     R2,[R0, #+4]
//  396 			Sts->FwdAmpOff_3G = AID_Value[0];
        LDRB     R2,[R1, #+0]
        STRB     R2,[R0, #+21]
//  397 			Sts->BeaconAlm.FwdAmpOff_3G = AID_Value[0];
        LDRB     R12,[R0, #+3]
        AND      R12,R12,#0xF7
        LSLS     R2,R2,#+3
        AND      R2,R2,#0x8
        ORR      R2,R2,R12
        STRB     R2,[R0, #+3]
//  398 			Sts->FwdAmpOff_3G = AID_Value[0];
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+21]
//  399 			tptr->BackUp.FwdAmpOff_3G = AID_Value[0];
        ADDS     R0,R3,#+3
        STRB     R1,[R0, #+31]
//  400 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  401 		break;
//  402 		
//  403 		case Aid_FwdOutAttn_REP_3G:
//  404 #ifdef __SUNWAVE
//  405 			TXCUCtrl->FwdOut2Attn_3G = AID_Value[0];
//  406 			TXCUCtrl->Ctrl.FwdOut2Attn_3G = SET;
//  407 			TXCUCtrl->Ctrl.FwdOut2AttnALC_3G = 0;
//  408 #else
//  409 			Sts->FwdOutAttn_REP_3G = AID_Value[0];
??SetCtrlData_21:
        LDRB     R2,[R1, #+0]
        ADD      R0,R4,#+73
        STRB     R2,[R0, #+15]
//  410 			tptr->BackUp.FwdOutAttn_REP_3G = Sts->FwdOutAttn_REP_3G;
        ADDS     R0,R3,#+3
        STRB     R2,[R0, #+12]
//  411 			rval = TRUE;
        MOVS     R5,#+1
//  412 #endif
//  413 			Sts->FwdOutAttnREPInit = AID_Value[0];
        ADD      R0,R4,#+170
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+1]
        B.N      ??SetCtrlData_51
//  414 		break;
//  415 
//  416 		case Aid_FwdInFA_3G:
//  417 		case Aid_RvsOutFA_3G:
//  418 #ifdef __SUNWAVE
//  419 			TXCUCtrl->FwdInFA_3G = AID_Value[0];
//  420 			TXCUCtrl->Ctrl.FwdInFA_3G = SET;
//  421 #endif
//  422 // 공통상황
//  423 			Sts->FwdInFA_3G = AID_Value[0];
??SetCtrlData_22:
        LDRB     R2,[R1, #+0]
        ADD      R0,R4,#+41
        STRB     R2,[R0, #+3]
//  424 			Sts->RvsOutFA_3G = AID_Value[0];
        STRB     R2,[R0, #+24]
//  425 			tptr->BackUp.FwdInFA_3G = Sts->RvsOutFA_3G;
        ADDS     R0,R3,#+3
        STRB     R2,[R0, #+2]
//  426 			rval = TRUE;
        MOVS     R5,#+1
//  427 
//  428 			if(AID_Value[0] != 0x00)	// offcase
        LDRB     R0,[R1, #+0]
        CMP      R0,#+0
        BEQ.W    ??SetCtrlData_51
//  429 			{
//  430 				TimerRegist(TimerPllRefresh, Time100mSec*3L);
??SetCtrlData_62:
        MOV      R1,#+300
        MOVS     R0,#+9
        BL       TimerRegist
//  431 				Sts->BeaconAlm.LocalFail_3G = 0;
        LDRB     R0,[R4, #+8]
        AND      R0,R0,#0xEF
        STRB     R0,[R4, #+8]
        B.N      ??SetCtrlData_51
//  432 			}
//  433 		break;
//  434 
//  435 		case Aid_FwdOutFA1_3G:
//  436 		case Aid_RvsInFA1_3G:
//  437 #ifdef __SUNWAVE
//  438 			TXCUCtrl->FwdOutFA1_3G = AID_Value[0];
//  439 			TXCUCtrl->Ctrl.FwdOutFA1_3G = SET;
//  440 #endif
//  441 // 공통상황
//  442 			Sts->FwdOutFA1_3G = AID_Value[0];
??SetCtrlData_23:
        LDRB     R2,[R1, #+0]
        ADD      R0,R4,#+41
        STRB     R2,[R0, #+4]
//  443 			Sts->RvsInFA1_3G = AID_Value[0];
        STRB     R2,[R0, #+25]
//  444 			tptr->BackUp.FwdOutFA1_3G = Sts->RvsInFA1_3G;
        ADDS     R0,R3,#+3
        STRB     R2,[R0, #+3]
//  445 			rval = TRUE;
??SetCtrlData_63:
        MOVS     R5,#+1
//  446 
//  447 			if(AID_Value[0] != 0x00)	// offcase
        LDRB     R0,[R1, #+0]
        CMP      R0,#+0
        BNE.N    ??SetCtrlData_62
        B.N      ??SetCtrlData_51
//  448 			{
//  449 				TimerRegist(TimerPllRefresh, Time100mSec*3L);
//  450 				Sts->BeaconAlm.LocalFail_3G = 0;
//  451 			}
//  452 		break;
//  453 
//  454 		case Aid_FwdOutFA2_3G:
//  455 		case Aid_RvsInFA2_3G:
//  456 #ifdef __SUNWAVE
//  457 			TXCUCtrl->FwdOutFA2_3G = AID_Value[0];
//  458 			TXCUCtrl->Ctrl.FwdOutFA2_3G = SET;
//  459 #endif
//  460 // 공통상황
//  461 			Sts->FwdOutFA2_3G = AID_Value[0];
??SetCtrlData_24:
        LDRB     R2,[R1, #+0]
        ADD      R0,R4,#+41
        STRB     R2,[R0, #+5]
//  462 			Sts->RvsInFA2_3G = AID_Value[0];
        STRB     R2,[R0, #+26]
//  463 			tptr->BackUp.FwdOutFA2_3G = Sts->RvsInFA2_3G;
        ADDS     R0,R3,#+3
        STRB     R2,[R0, #+4]
//  464 			rval = TRUE;
        B.N      ??SetCtrlData_63
//  465 			
//  466 			if(AID_Value[0] != 0x00)	// offcase
//  467 			{
//  468 				TimerRegist(TimerPllRefresh, Time100mSec*3L);
//  469 				Sts->BeaconAlm.LocalFail_3G = 0;
//  470 			}
//  471 		break;
//  472 
//  473 		case Aid_Fwd10MHzSelect_3G:
//  474 			Sts->Fwd10MHzSelect_3G = AID_Value[0];
??SetCtrlData_40:
        ADD      R0,R4,#+41
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+6]
        B.N      ??SetCtrlData_51
//  475 #ifdef __SUNWAVE
//  476 			TXCUCtrl->Fwd10MHzSelect_3G = AID_Value[0];
//  477 			TXCUCtrl->Ctrl.Fwd10MHzSelect_3G = SET;
//  478 #endif
//  479 		break; 
//  480 
//  481 		case Aid_OutSwitchTime_3G:
//  482 #ifdef __SUNWAVE
//  483 			TXCUCtrl->OutSwitchTime_3G[0] = AID_Value[0];
//  484 			TXCUCtrl->OutSwitchTime_3G[1] = AID_Value[1];
//  485 			TXCUCtrl->Ctrl.OutSwitchTime_3G = SET;
//  486 #elif defined(__GT_T)
//  487 			Sts->OutSwitchTime_3G.Byte.High = AID_Value[0];
//  488             Sts->OutSwitchTime_3G.Byte.Low = AID_Value[1];
//  489 			if(Sts->OutSwitchTime_3G.Data == 0) Sts->OutSwitchTime_3G.Data = 1;
//  490 			tptr->BackUp.OutSwitchTime_3G = Sts->OutSwitchTime_3G;
//  491 			rval = TRUE;
//  492 #endif
//  493 		break;
//  494 
//  495 #ifdef __SUNWAVE
//  496 		case Aid_CellBarred:
//  497 			SGCUCtrl->CellBarred = AID_Value[0];
//  498 			SGCUCtrl->Ctrl.CellBarred = SET;
//  499 		break;
//  500 
//  501 		case Aid_ResBarred:
//  502 			SGCUCtrl->ResBarred = AID_Value[0];
//  503 			SGCUCtrl->Ctrl.ResBarred = SET;
//  504 		break;
//  505 		
//  506 		case Aid_T_Barred:
//  507 			SGCUCtrl->T_Barred = AID_Value[0];
//  508 			SGCUCtrl->Ctrl.T_Barred = SET;
//  509 		break;
//  510 		
//  511 		case Aid_T_Cell:
//  512 			SGCUCtrl->T_Cell = AID_Value[0];
//  513 			SGCUCtrl->Ctrl.T_Cell = SET;
//  514 		break;
//  515 		
//  516 		case Aid_MeasurePeriod:
//  517 			SGCUCtrl->MeasurePeriod = AID_Value[0];
//  518 			SGCUCtrl->Ctrl.MeasurePeriod = SET;
//  519 		break;
//  520 #endif
//  521 		case Aid_RFPassLossOnoff_3G:
//  522 			if(FA_Aloc_AutoMode_Set(NULL))
??SetCtrlData_18:
        MOVS     R0,#+0
        BL       FA_Aloc_AutoMode_Set
        CMP      R0,#+0
        BEQ.W    ??SetCtrlData_51
//  523 			{
//  524 				TimerRegist(Timer_ALC, Time100mSec*20L);
        MOV      R1,#+2000
        MOVS     R0,#+8
        BL       TimerRegist
//  525 				TimerRegist(TimerCWOff, Time1Sec*10L);
        MOVW     R1,#+10000
        MOVS     R0,#+11
        BL       TimerRegist
//  526 				Sts->CW0OnOff_3G = Enable;
        ADD      R0,R4,#+8
        STRB     R5,[R0, #+19]
//  527 				Sts->RFPathLossResult_3G = PathIng;
        ADD      R0,R4,#+123
        MOVS     R1,#+8
??SetCtrlData_64:
        STRB     R1,[R0, #+29]
        B.N      ??SetCtrlData_51
//  528 			}
//  529 		break;
//  530 
//  531 		case Aid_OutSwitchAttnOnOff_3G:
//  532 			Sts->OutSwitchAttnOnOff_3G = AID_Value[0];
??SetCtrlData_25:
        LDRB     R2,[R1, #+0]
        ADD      R0,R4,#+41
        STRB     R2,[R0, #+9]
//  533 			tptr->BackUp.OutSwitchAttnOnOff_3G = Sts->OutSwitchAttnOnOff_3G;
        ADD      R0,R3,#+41
        STRB     R2,[R0, #+14]
//  534 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  535 		break;
//  536         
//  537 		case Aid_FwdInALCLvl:
//  538 			Sts->FwdInALCLvl = AID_Value[0];
??SetCtrlData_26:
        ADD      R0,R4,#+123
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+27]
//  539 			tptr->BackUp.FwdInALCLvl = Sts->FwdInALCLvl;
        ADD      R1,R3,#+41
        LDRB     R0,[R0, #+27]
        STRB     R0,[R1, #+20]
//  540 			rval = TRUE;
        B.N      ??SetCtrlData_59
//  541 		break;
//  542 			
//  543 		case Aid_Rvs0Attn_3G:
//  544 			Sts->Rvs0Attn_3G = AID_Value[0];
??SetCtrlData_10:
        LDRB     R2,[R1, #+0]
        ADD      R0,R4,#+8
        STRB     R2,[R0, #+16]
//  545 			tptr->BackUp.Rvs0Attn_3G = Sts->Rvs0Attn_3G;
        ADDS     R0,R3,#+3
        STRB     R2,[R0, #+5]
//  546 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  547 		break;
//  548 
//  549 		case Aid_RvsInUpperLmt_3G:
//  550 			Sts->RvsInUpperLmt_3G = AID_Value[0];
??SetCtrlData_11:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+18]
//  551 			tptr->BackUp.RvsInUpperLmt_3G = Sts->RvsInUpperLmt_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+18]
        STRB     R0,[R1, #+25]
//  552 			rval = TRUE;
        B.N      ??SetCtrlData_60
//  553 		break;
//  554 
//  555 		case Aid_RvsInLowerLmt_3G:
//  556 			Sts->RvsInLowerLmt_3G = AID_Value[0];
??SetCtrlData_12:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+19]
//  557 			tptr->BackUp.RvsInLowerLmt_3G = Sts->RvsInLowerLmt_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+19]
        STRB     R0,[R1, #+26]
//  558 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  559 		break;
//  560 
//  561 		case Aid_Rvs0OutUpperLmt_3G:
//  562 			Sts->Rvs0OutUpperLmt_3G[0] = AID_Value[0];
??SetCtrlData_13:
        ADD      R0,R4,#+73
        LDRSB    R2,[R1, R5]
        STRB     R2,[R0, #+22]
//  563 			Sts->Rvs0OutUpperLmt_3G[1] = AID_Value[1];
        LDRSB    R1,[R1, #+1]
        STRB     R1,[R0, #+23]
//  564 			tptr->BackUp.Rvs0OutUpperLmt_3G[0] = Sts->Rvs0OutUpperLmt_3G[0];
        ADDS     R1,R3,#+3
        LDRB     R2,[R0, #+22]
        STRB     R2,[R1, #+27]
//  565 			tptr->BackUp.Rvs0OutUpperLmt_3G[1] = Sts->Rvs0OutUpperLmt_3G[1];
        LDRB     R0,[R0, #+23]
        STRB     R0,[R1, #+28]
//  566 			rval = TRUE;
        B.N      ??SetCtrlData_59
//  567 		break;
//  568 
//  569 		case Aid_Rvs0OutLowerLmt_3G:
//  570 			Sts->Rvs0OutLowerLmt_3G[0] = AID_Value[0];
??SetCtrlData_14:
        ADD      R0,R4,#+73
        LDRSB    R2,[R1, R5]
        STRB     R2,[R0, #+24]
//  571 			Sts->Rvs0OutLowerLmt_3G[1] = AID_Value[1];
        LDRSB    R1,[R1, #+1]
        STRB     R1,[R0, #+25]
//  572 			tptr->BackUp.Rvs0OutLowerLmt_3G[0] = Sts->Rvs0OutLowerLmt_3G[0];
        ADDS     R1,R3,#+3
        LDRB     R2,[R0, #+24]
        STRB     R2,[R1, #+29]
//  573 			tptr->BackUp.Rvs0OutLowerLmt_3G[1] = Sts->Rvs0OutLowerLmt_3G[1];
        LDRB     R0,[R0, #+25]
        STRB     R0,[R1, #+30]
//  574 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  575 		break;
//  576 
//  577     	case Aid_FwdInPllFreqOffset_3G:
//  578 #ifdef __GT_T			
//  579 		case Aid_RvsOutPllFreqOffset_3G:
//  580 #endif
//  581 #ifdef __SUNWAVE
//  582 			TXCUCtrl->FwdInPLLOffsetFreq_3G = AID_Value[0];
//  583 			TXCUCtrl->Ctrl.FwdInPLLOffsetFreq_3G = SET;
//  584 #endif
//  585 
//  586 #ifdef __GT_T
//  587 			Sts->FwdInPllFreqOffset_3G = AID_Value[0];
//  588 			tptr->BackUp.FwdInPllFreqOffset_3G = Sts->FwdInPllFreqOffset_3G;
//  589 
//  590 			Sts->RvsOutPllFreqOffset_3G = AID_Value[0];
//  591 			tptr->BackUp.RvsOutPllFreqOffset_3G = Sts->RvsOutPllFreqOffset_3G;
//  592 			rval = TRUE;
//  593 #endif
//  594 		break;
//  595 #ifdef __SUNWAVE
//  596 		case Aid_RvsOutPllFreqOffset_3G:
//  597 			Sts->RvsOutPllFreqOffset_3G = AID_Value[0];
//  598 			tptr->BackUp.RvsOutPllFreqOffset_3G = Sts->RvsOutPllFreqOffset_3G;
//  599 			rval = TRUE;
//  600 
//  601 		break;
//  602 #endif
//  603 
//  604     	case Aid_FwdOut1PllFreqOffset_3G:
//  605 #ifdef __GT_T			
//  606 		case Aid_RvsIn1PllFreqOffset_3G:
//  607 #endif
//  608 
//  609 #ifdef __GT_T
//  610 			Sts->FwdOut1PllFreqOffset_3G = AID_Value[0];
//  611 			tptr->BackUp.FwdOut1PllFreqOffset_3G = Sts->FwdOut1PllFreqOffset_3G;
//  612 
//  613 			Sts->RvsIn1PllFreqOffset_3G = AID_Value[0];
//  614 			tptr->BackUp.RvsIn1PllFreqOffset_3G = Sts->RvsIn1PllFreqOffset_3G;
//  615 			rval = TRUE;
//  616 #endif
//  617 		break;
//  618 
//  619 #ifdef __SUNWAVE
//  620 		case Aid_RvsIn1PllFreqOffset_3G:
//  621 			Sts->RvsIn1PllFreqOffset_3G = AID_Value[0];
//  622 			tptr->BackUp.RvsIn1PllFreqOffset_3G = Sts->RvsIn1PllFreqOffset_3G;
//  623 			rval = TRUE;
//  624 		break;
//  625 #endif
//  626     	case Aid_FwdOut2PllFreqOffset_3G:
//  627 #ifdef __GT_T			
//  628 		case Aid_RvsIn2PllFreqOffset_3G:
//  629 #endif
//  630 
//  631 #ifdef __GT_T
//  632 			Sts->FwdOut2PllFreqOffset_3G = AID_Value[0];
//  633 			tptr->BackUp.FwdOut2PllFreqOffset_3G = Sts->FwdOut2PllFreqOffset_3G;
//  634 
//  635 			Sts->RvsIn2PllFreqOffset_3G = AID_Value[0];
//  636 			tptr->BackUp.RvsIn2PllFreqOffset_3G = Sts->RvsIn2PllFreqOffset_3G;
//  637 			rval = TRUE;
//  638 #endif
//  639 		break;					
//  640 
//  641 #ifdef __SUNWAVE
//  642 		case Aid_RvsIn2PllFreqOffset_3G:
//  643 			Sts->RvsIn2PllFreqOffset_3G = AID_Value[0];
//  644 			tptr->BackUp.RvsIn2PllFreqOffset_3G = Sts->RvsIn2PllFreqOffset_3G;
//  645 			rval = TRUE;
//  646 		break;
//  647 #endif
//  648 
//  649 		case Aid_FwdOutPwrOffset_3G:
//  650 			Sts->FwdOutPwrOffset_3G = AID_Value[0];
??SetCtrlData_31:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+26]
//  651 			
//  652 			tptr->BackUp.FwdOutPwrOffset_3G = Sts->FwdOutPwrOffset_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+26]
        STRB     R0,[R1, #+15]
//  653 			rval = TRUE;
??SetCtrlData_65:
        MOVS     R5,#+1
        B.N      ??SetCtrlData_51
//  654 		break;
//  655 		
//  656 		case Aid_FwdInPwrOffset_3G:
//  657 			Sts->FwdInPwrOffset_3G = AID_Value[0];
??SetCtrlData_30:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+28]
//  658 			tptr->BackUp.FwdInPwrOffset_3G = Sts->FwdInPwrOffset_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+28]
        STRB     R0,[R1, #+14]
//  659 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  660 		break;
//  661 
//  662 		case Aid_FwdPwrREPOffset_3G:
//  663 			Sts->FwdPwrREPOffset_3G = AID_Value[0];
??SetCtrlData_32:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+27]
//  664 			tptr->BackUp.FwdPwr_REPOffset_3G = Sts->FwdPwrREPOffset_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+27]
        STRB     R0,[R1, #+16]
//  665 			rval = TRUE;
        B.N      ??SetCtrlData_59
//  666 		break;
//  667 
//  668 		case Aid_Rvs0OutPwrOffset_3G:
//  669 			Sts->Rvs0OutPwrOffset_3G = AID_Value[0];
??SetCtrlData_34:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+30]
//  670 			tptr->BackUp.Rvs0OutPwrOffset_3G = Sts->Rvs0OutPwrOffset_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+30]
        STRB     R0,[R1, #+17]
//  671 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  672 		break;
//  673 		
//  674 		case Aid_RvsInPwrOffset_3G:
//  675 			Sts->RvsInPwrOffset_3G = AID_Value[0];
??SetCtrlData_33:
        ADD      R0,R4,#+73
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+29]
//  676 			tptr->BackUp.RvsInPwrOffset_3G = Sts->RvsInPwrOffset_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+29]
        STRB     R0,[R1, #+18]
//  677 			rval = TRUE;
        B.N      ??SetCtrlData_60
//  678 		break;
//  679 
//  680 		case Aid_FwdOutAttnOffset_3G:
//  681 #ifdef __SUNWAVE
//  682 			TXCUCtrl->FwdOutAttnOffset_3G = AID_Value[0];
//  683 			TXCUCtrl->Ctrl.FwdOutAttnOffset_3G = SET;
//  684 #else
//  685 			Sts->FwdOutAttnOffset_3G = AID_Value[0];
??SetCtrlData_47:
        ADD      R0,R4,#+110
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+2]
//  686 			tptr->BackUp.FwdOutAttnOffset_3G = Sts->FwdOutAttnOffset_3G;
        ADD      R1,R3,#+82
        LDRB     R0,[R0, #+2]
        STRB     R0,[R1, #+1]
//  687 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  688 #endif
//  689 		break;
//  690 
//  691 		case Aid_FwdOutAttnREPOffset_3G:
//  692 #ifdef __SUNWAVE
//  693 			TXCUCtrl->FwdOutAttnREPOffset_3G = AID_Value[0];
//  694 			TXCUCtrl->Ctrl.FwdOutAttnREPOffset_3G = SET;
//  695 #else
//  696 			Sts->FwdOutAttnREPOffset_3G = AID_Value[0];
??SetCtrlData_48:
        ADD      R0,R4,#+110
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+3]
//  697 			tptr->BackUp.FwdOutAttnREPOffset_3G = Sts->FwdOutAttnREPOffset_3G;
        ADD      R1,R3,#+82
        LDRB     R0,[R0, #+3]
        STRB     R0,[R1, #+2]
//  698 			rval = TRUE;
        B.N      ??SetCtrlData_59
//  699 #endif
//  700 		break;
//  701 
//  702 
//  703 		case Aid_FwdOutAttnTemp_3G:
//  704 #ifdef __SUNWAVE
//  705 
//  706 #else
//  707 			Sts->FwdOutAttnTemp_3G = AID_Value[0];
??SetCtrlData_49:
        ADD      R0,R4,#+110
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+6]
//  708 			tptr->BackUp.FwdOutAttnTemp_3G = Sts->FwdOutAttnTemp_3G;
        ADD      R1,R3,#+82
        LDRB     R0,[R0, #+6]
        STRB     R0,[R1, #+3]
//  709 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  710 #endif
//  711 		break;
//  712 		
//  713 		case Aid_FwdOutREPTempAttn_3G:
//  714 #ifdef __SUNWAVE
//  715 			
//  716 #else
//  717 			Sts->FwdOutREPTempAttn_3G = AID_Value[0];
??SetCtrlData_50:
        ADD      R0,R4,#+110
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+7]
//  718 			tptr->BackUp.FwdOutREPTempAttn_3G = Sts->FwdOutREPTempAttn_3G;
        ADD      R1,R3,#+82
        LDRB     R0,[R0, #+7]
        STRB     R0,[R1, #+4]
//  719 			rval = TRUE;
        B.N      ??SetCtrlData_65
//  720 #endif
//  721 		break;
//  722 		case Aid_FwdInAttnOffset_3G:
//  723 #ifdef __SUNWAVE
//  724 			TXCUCtrl->FwdInAttnOffset_3G = AID_Value[0];
//  725 			TXCUCtrl->Ctrl.FwdInAttnOffset_3G = SET;
//  726 #else
//  727 			Sts->FwdInAttnOffset_3G = AID_Value[0];
??SetCtrlData_46:
        LDRSB    R0,[R1, R5]
        STRB     R0,[R4, #+110]
//  728 			tptr->BackUp.FwdInAttnOffset_3G = Sts->FwdInAttnOffset_3G;
        LDRB     R0,[R4, #+110]
        STRB     R0,[R3, #+82]
//  729 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  730 #endif
//  731 		break;
//  732 
//  733 		case Aid_Rvs0AttnOffset_3G:
//  734 			Sts->Rvs0AttnOffset_3G = AID_Value[0];
??SetCtrlData_44:
        ADD      R0,R4,#+110
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+1]
//  735 			tptr->BackUp.Rvs0AttnOffset_3G = Sts->Rvs0AttnOffset_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+1]
        STRB     R0,[R1, #+6]
//  736 			rval = TRUE;
        B.N      ??SetCtrlData_59
//  737 		break;
//  738 
//  739 		case Aid_TotalPwrOnOff_3G:
//  740 			Sts->TotalPwrOnOff_3G = AID_Value[0];
//  741 		break;
//  742 
//  743 		case Aid_TPTL_OnOff:
//  744 			Sts->TPTL_OnOff = AID_Value[0];
??SetCtrlData_27:
        ADD      R0,R4,#+8
        LDRB     R1,[R1, #+0]
        B.N      ??SetCtrlData_64
//  745 		break;
//  746 		
//  747 		case Aid_TempOffset:
//  748 			Sts->TempOffset = AID_Value[0];
??SetCtrlData_28:
        ADD      R0,R4,#+8
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+31]
//  749 			tptr->BackUp.TempOffset = Sts->TempOffset;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+31]
        STRB     R0,[R1, #+1]
//  750 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  751 		break;
//  752         
//  753 		case Aid_FwdInAttnTemp_3G:
//  754 #ifdef __SUNWAVE
//  755 
//  756 #else
//  757 			Sts->FwdInAttnTemp_3G = AID_Value[0];
??SetCtrlData_35:
        ADD      R0,R4,#+110
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+4]
//  758 			tptr->BackUp.FwdInAttnTemp_3G = Sts->FwdInAttnTemp_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+4]
        STRB     R0,[R1, #+9]
//  759 			rval = TRUE;
        B.N      ??SetCtrlData_59
//  760 #endif			
//  761 		break;
//  762 		
//  763 		case Aid_Rvs0AttnTemp_3G:
//  764 			Sts->Rvs0AttnTemp_3G = AID_Value[0];
??SetCtrlData_36:
        ADD      R0,R4,#+110
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+5]
//  765 			tptr->BackUp.Rvs0AttnTemp_3G = Sts->Rvs0AttnTemp_3G;
        ADDS     R1,R3,#+3
        LDRB     R0,[R0, #+5]
        STRB     R0,[R1, #+7]
//  766 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  767 		break;
//  768 
//  769 
//  770 
//  771 		case Aid_FwdInPllFreqTemp_3G:
//  772 #ifdef __GT_T
//  773 		case Aid_RvsOutPllFreqTemp_3G:
//  774 #endif
//  775 			Sts->FwdInPllFreqTemp_3G.Byte.High = AID_Value[0];
??SetCtrlData_37:
        LDRH     R0,[R4, #+119]
        AND      R0,R0,#0xFF00
        LDRB     R2,[R1, #+0]
        ORRS     R0,R2,R0
        STRH     R0,[R4, #+119]
//  776 			Sts->FwdInPllFreqTemp_3G.Byte.Low = AID_Value[1];
        ADD      R0,R4,#+110
        LDRH     R2,[R0, #+8]
        AND      R2,R2,#0xFF00
        LDRB     R1,[R1, #+1]
        ORRS     R1,R1,R2
        STRH     R1,[R0, #+8]
//  777 			tptr->BackUp.FwdInPllFreqTemp_3G.Byte.High = Sts->FwdInPllFreqTemp_3G.Byte.High;
        LDRH     R1,[R3, #+37]
        AND      R1,R1,#0xFF00
        LDRH     R2,[R4, #+119]
        UXTB     R2,R2
        ORRS     R1,R2,R1
        STRH     R1,[R3, #+37]
//  778 			tptr->BackUp.FwdInPllFreqTemp_3G.Byte.Low = Sts->FwdInPllFreqTemp_3G.Byte.Low;
        LDRH     R1,[R3, #+36]
        AND      R1,R1,#0xFF00
        LDRH     R0,[R0, #+8]
        UXTB     R0,R0
        ORRS     R0,R0,R1
        STRH     R0,[R3, #+36]
//  779 #ifdef __GT_T
//  780 			Sts->RvsOutPllFreqTemp_3G.Byte.High = AID_Value[0];
//  781 			Sts->RvsOutPllFreqTemp_3G.Byte.Low = AID_Value[1];
//  782 			tptr->BackUp.RvsOutPllFreqTemp_3G.Byte.High = Sts->RvsOutPllFreqTemp_3G.Byte.High;
//  783 			tptr->BackUp.RvsOutPllFreqTemp_3G.Byte.Low = Sts->RvsOutPllFreqTemp_3G.Byte.Low;
//  784 #endif
//  785 			rval = TRUE;
        B.N      ??SetCtrlData_60
//  786 		break;
//  787 		
//  788 		case Aid_FwdOut1PllFreqTemp_3G:
//  789 #ifdef __GT_T
//  790 		case Aid_RvsIn1PllFreqTemp_3G:
//  791 #endif
//  792 			Sts->FwdOut1PllFreqTemp_3G.Byte.High = AID_Value[0];
??SetCtrlData_38:
        LDRH     R0,[R4, #+121]
        AND      R0,R0,#0xFF00
        LDRB     R2,[R1, #+0]
        ORRS     R0,R2,R0
        STRH     R0,[R4, #+121]
//  793 			Sts->FwdOut1PllFreqTemp_3G.Byte.Low = AID_Value[1];
        LDRH     R0,[R4, #+120]
        AND      R0,R0,#0xFF00
        LDRB     R1,[R1, #+1]
        ORRS     R0,R1,R0
        STRH     R0,[R4, #+120]
//  794 			tptr->BackUp.FwdOut1PllFreqTemp_3G.Byte.High = Sts->FwdOut1PllFreqTemp_3G.Byte.High;
        LDRH     R0,[R3, #+39]
        AND      R0,R0,#0xFF00
        LDRH     R1,[R4, #+121]
        UXTB     R1,R1
        ORRS     R0,R1,R0
        STRH     R0,[R3, #+39]
//  795 			tptr->BackUp.FwdOut1PllFreqTemp_3G.Byte.Low = Sts->FwdOut1PllFreqTemp_3G.Byte.Low;
        LDRH     R0,[R3, #+38]
        AND      R0,R0,#0xFF00
        LDRH     R1,[R4, #+120]
        UXTB     R1,R1
        ORRS     R0,R1,R0
        STRH     R0,[R3, #+38]
//  796 #ifdef __GT_T
//  797 			Sts->RvsIn1PllFreqTemp_3G.Byte.High = AID_Value[0];
//  798 			Sts->RvsIn1PllFreqTemp_3G.Byte.Low = AID_Value[1];
//  799 			tptr->BackUp.RvsIn1PllFreqTemp_3G.Byte.High = Sts->RvsIn1PllFreqTemp_3G.Byte.High;
//  800 			tptr->BackUp.RvsIn1PllFreqTemp_3G.Byte.Low = Sts->RvsIn1PllFreqTemp_3G.Byte.Low;
//  801 #endif
//  802 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  803 		break;
//  804 
//  805 		case Aid_FwdOut2PllFreqTemp_3G:
//  806 #ifdef	__GT_T
//  807 		case Aid_RvsIn2PllFreqTemp_3G:
//  808 #endif
//  809 			Sts->FwdOut2PllFreqTemp_3G.Byte.High = AID_Value[0];
??SetCtrlData_39:
        LDRH     R0,[R4, #+123]
        AND      R0,R0,#0xFF00
        LDRB     R2,[R1, #+0]
        ORRS     R0,R2,R0
        STRH     R0,[R4, #+123]
//  810 			Sts->FwdOut2PllFreqTemp_3G.Byte.Low = AID_Value[1];
        LDRH     R0,[R4, #+122]
        AND      R0,R0,#0xFF00
        LDRB     R1,[R1, #+1]
        ORRS     R0,R1,R0
        STRH     R0,[R4, #+122]
//  811 			tptr->BackUp.FwdOut2PllFreqTemp_3G.Byte.High = Sts->FwdOut2PllFreqTemp_3G.Byte.High;
        LDRH     R0,[R3, #+41]
        AND      R0,R0,#0xFF00
        LDRH     R1,[R4, #+123]
        UXTB     R1,R1
        ORRS     R0,R1,R0
        STRH     R0,[R3, #+41]
//  812 			tptr->BackUp.FwdOut2PllFreqTemp_3G.Byte.Low = Sts->FwdOut2PllFreqTemp_3G.Byte.Low;
        LDRH     R0,[R3, #+40]
        AND      R0,R0,#0xFF00
        LDRH     R1,[R4, #+122]
        UXTB     R1,R1
        ORRS     R0,R1,R0
        STRH     R0,[R3, #+40]
        B.N      ??SetCtrlData_51
//  813 #ifdef __GT_T
//  814 			Sts->RvsIn2PllFreqTemp_3G.Byte.High = AID_Value[0];
//  815 			Sts->RvsIn2PllFreqTemp_3G.Byte.Low = AID_Value[1];
//  816 			tptr->BackUp.RvsIn2PllFreqTemp_3G.Byte.High = Sts->RvsIn2PllFreqTemp_3G.Byte.High;
//  817 			tptr->BackUp.RvsIn2PllFreqTemp_3G.Byte.Low = Sts->RvsIn2PllFreqTemp_3G.Byte.Low;
//  818 #endif
//  819 		break;
//  820 
//  821 
//  822 		case Aid_DrvFwdAmpOnOff_3G:
//  823 			RvsOSCStep_3G = 0;
??SetCtrlData_2:
        LDR.N    R0,??SetCtrlData_0+0x4  ;; RvsOSCStep_3G
        STRB     R5,[R0, #+0]
//  824 			RvsShutCnt_3G = 0;
        LDR.N    R0,??SetCtrlData_0+0x8  ;; RvsShutCnt_3G
        STRB     R5,[R0, #+0]
//  825 			Sts->BeaconAlm.RvsOsc_3G = 0;
        ADD      R0,R4,#+8
        LDRB     R2,[R0, #+2]
        AND      R2,R2,#0xBF
        STRB     R2,[R0, #+2]
//  826 			Sts->BeaconAlm.RvsOsc_3G_LED = 0;
        LDRB     R2,[R0, #+4]
        AND      R2,R2,#0x7F
        STRB     R2,[R0, #+4]
//  827 			Sts->BeaconAlm.LocalFail_3G = 0;
        LDRB     R2,[R4, #+8]
        AND      R2,R2,#0xEF
        STRB     R2,[R4, #+8]
//  828 			Sts->DrvFwdAmpOnOff_3G = AID_Value[0];
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+17]
        B.N      ??SetCtrlData_51
//  829  		break;
//  830 
//  831 		case Aid_DrvRvsAmpOnOff_3G:
//  832 			RvsOSCStep_3G = 0;
??SetCtrlData_3:
        LDR.N    R0,??SetCtrlData_0+0x4  ;; RvsOSCStep_3G
        STRB     R5,[R0, #+0]
//  833 			RvsShutCnt_3G = 0;
        LDR.N    R0,??SetCtrlData_0+0x8  ;; RvsShutCnt_3G
        STRB     R5,[R0, #+0]
//  834 			Sts->BeaconAlm.RvsOsc_3G = 0;
        ADD      R0,R4,#+8
        LDRB     R2,[R0, #+2]
        AND      R2,R2,#0xBF
        STRB     R2,[R0, #+2]
//  835 			Sts->BeaconAlm.LocalFail_3G = 0;
        LDRB     R2,[R4, #+8]
        AND      R2,R2,#0xEF
        STRB     R2,[R4, #+8]
//  836 			Sts->BeaconAlm.RvsOsc_3G_LED = 0;
        LDRB     R2,[R0, #+4]
        AND      R2,R2,#0x7F
        STRB     R2,[R0, #+4]
//  837 			Sts->DrvRvsAmpOnOff_3G = AID_Value[0];
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+18]
        B.N      ??SetCtrlData_51
//  838  		break;
//  839 
//  840 		case Aid_CW0OnOff_3G:
//  841 			Sts->CW0OnOff_3G = AID_Value[0];
??SetCtrlData_16:
        ADD      R0,R4,#+8
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+19]
//  842 			TimerRegist(TimerCWOff, Time1Sec*10L);
        MOVW     R1,#+10000
        MOVS     R0,#+11
        BL       TimerRegist
        B.N      ??SetCtrlData_51
//  843  		break;
//  844 
//  845 		case Aid_RvsOscLvl:
//  846 			Sts->RvsOscLvl = AID_Value[0];
??SetCtrlData_45:
        ADD      R0,R4,#+123
        LDRSB    R1,[R1, R5]
        STRB     R1,[R0, #+26]
//  847 			tptr->BackUp.RvsOscLvl = Sts->RvsOscLvl;
        LDRB     R0,[R0, #+26]
        STRB     R0,[R3, #+35]
//  848 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  849 		break;
//  850 
//  851 		case Aid_RCUReset:
//  852 			if(AID_Value[0] == SET){
??SetCtrlData_17:
        LDRB     R0,[R1, #+0]
        CMP      R0,#+1
        BNE.N    ??SetCtrlData_51
//  853 				ResetCaseBackup(0x01);
        BL       ResetCaseBackup
//  854 				ResetStart();
        BL       ResetStart
        B.N      ??SetCtrlData_51
//  855 			}			
//  856 		break;
//  857 
//  858 		case Aid_AlarmMask:
//  859 			Sts->AlarmMask = AID_Value[0] & 0x01;
??SetCtrlData_29:
        LDRB     R2,[R1, #+0]
        AND      R0,R2,#0x1
        ADD      R1,R4,#+170
        STRB     R0,[R1, #+4]
//  860 			tptr->BackUp.AlarmMask = Sts->AlarmMask & 0x01;
        STRB     R0,[R3, #+121]
//  861 			rval = TRUE;
        B.N      ??SetCtrlData_52
//  862 		break;
//  863 
//  864 		case Aid_FwdAttn1_3G:
//  865 			FPGA_LED_Buff &= ~(0x07 << 0);
??SetCtrlData_42:
        LDR.N    R0,??SetCtrlData_0+0xC  ;; FPGA_LED_Buff
        LDRB     R2,[R0, #+0]
        AND      R2,R2,#0xF8
        STRB     R2,[R0, #+0]
//  866 			FPGA_LED_Buff |= (AID_Value[0] & 0x07) << 0;
        LDRB     R1,[R1, #+0]
        AND      R1,R1,#0x7
        ORRS     R1,R1,R2
        B.N      ??SetCtrlData_66
//  867 		break;
//  868 
//  869         case Aid_FwdAttn2_3G:
//  870 			FPGA_LED_Buff &= ~(0x07 << 3);
??SetCtrlData_43:
        LDR.N    R0,??SetCtrlData_0+0xC  ;; FPGA_LED_Buff
        LDRB     R2,[R0, #+0]
        AND      R2,R2,#0xC7
        STRB     R2,[R0, #+0]
//  871 			FPGA_LED_Buff |= (AID_Value[0] & 0x07) << 3;
        LDRB     R1,[R1, #+0]
        AND      R1,R1,#0x7
        ORR      R1,R2,R1, LSL #+3
??SetCtrlData_66:
        STRB     R1,[R0, #+0]
//  872 		break;
//  873 	/////////////////////////////////////////////////////////////
//  874 		//case Aid_FwdInAttn_2G:
//  875 			//Sts->FwdALCInit_2G = 0;
//  876 			//TimerRegist(Timer_ALC, Time1Sec*2L);
//  877         default:
//  878 			//if(!ItitReallyUnknown(AID_Command)) break;
//  879           
//  880           /**
//  881 			if(Ctrl && Udc2InsertCheck(1))
//  882 			{				
//  883 				if((Digital_CtrlCnt + 2 + 1 + Length) < sizeof(Digital_CtrlData))
//  884 				{
//  885 					Digital_CtrlCnt += GenAidData(AID_Command, (INT8U *)&Digital_CtrlData[Digital_CtrlCnt], (INT8U *)&AID_Value[0], Length);
//  886 				}
//  887 			}
//  888           ***/
//  889 		break;
//  890 	}
//  891   	return rval;
??SetCtrlData_51:
        MOVS     R0,R5
        POP      {R1,R4,R5,PC}    ;; return
        DATA
??SetCtrlData_0:
        DC32     BeaconSts
        DC32     RvsOSCStep_3G
        DC32     RvsShutCnt_3G
        DC32     FPGA_LED_Buff
//  892 }
//  893 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  894 INT8U AnalyzeAidData(__ProtocolPtr *nPtr, INT8U Ctrl)
//  895 {
AnalyzeAidData:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+48
//  896 	INT8U i = 0;
//  897 	INT8U A_ID[2];
//  898 	INT8U rAID_Value[40];
//  899 	INT8U Length;
//  900 
//  901 	INT16U Cnt = 0;
        MOVS     R4,#+0
//  902 	INT16U AID_Command;
//  903 	INT32U cpu_sr;
//  904 	__WRCSSIO *Recv = nPtr->WRCSRecv;
        LDR      R0,[R0, #+28]
//  905 	__BODYFRAME *BodyFrame = &Recv->BodyFrame[Recv->cBody%2];
        LDRB     R1,[R0, #+1047]
        ASRS     R2,R1,#+1
        SUB      R1,R1,R2, LSL #+1
        MOVW     R2,#+1036
        MLA      R0,R1,R2,R0
        ADD      R5,R0,#+8
//  906 
//  907 	INT8U rval = FALSE;
        MOV      R9,R4
//  908 
//  909 	if(Ctrl)
//  910 	{
//  911 #ifdef __SUNWAVE	
//  912 		TXCUSendCnt = 0;
//  913 		TXCURecvCnt = 0;
//  914 		SGCUSendCnt = 0;
//  915 		SGCURecvCnt = 0;
//  916 		PAUSendCnt = 0;
//  917 		PAURecvCnt = 0;
//  918 #endif		
//  919 	}
//  920 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOVS     R6,R0
//  921 	{
//  922 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.N    R7,??AnalyzeAidData_0  ;; 0x8006000
        MOVS     R0,R7
        BL       RoadBackuptobuffer
        MOV      R8,R0
        ADD      R10,SP,#+0
//  923 
//  924 		while(BodyFrame->SubLength > Cnt)
??AnalyzeAidData_1:
        LDRH     R1,[R5, #+1031]
        CMP      R4,R1
        BCS.N    ??AnalyzeAidData_2
//  925 		{
//  926 			A_ID[0] = (INT8U)(BodyFrame->SubData[Cnt++]);
        ADDS     R0,R4,R5
        LDRB     R0,[R0, #+7]
        STRB     R0,[SP, #+0]
        ADDS     R0,R4,#+1
        UXTH     R0,R0
//  927 			A_ID[1] = (INT8U)(BodyFrame->SubData[Cnt++]);
        ADDS     R1,R0,R5
        LDRB     R1,[R1, #+7]
        STRB     R1,[R10, #+1]
        ADDS     R3,R0,#+1
        UXTH     R3,R3
//  928 
//  929 			AID_Command = ((INT16U)(A_ID[0] << 8)& 0xff00) | ((INT16U)(A_ID[1] & 0x00ff));
        LDRB     R0,[SP, #+0]
        ORR      R0,R1,R0, LSL #+8
//  930 			Length = BodyFrame->SubData[Cnt++];
        ADDS     R1,R3,R5
        LDRB     R2,[R1, #+7]
        ADDS     R4,R3,#+1
        UXTH     R4,R4
//  931 			if( Length >= sizeof(rAID_Value)) break;
        CMP      R2,#+40
        BCS.N    ??AnalyzeAidData_2
//  932 			for (i = 0; i < Length; i++) rAID_Value[i] = (INT8U)(BodyFrame->SubData[Cnt++]);
        MOVS     R1,R2
        BEQ.N    ??AnalyzeAidData_3
        ADD      R1,SP,#+4
        MOVS     R3,R2
??AnalyzeAidData_4:
        ADD      R12,R4,R5
        LDRB     R12,[R12, #+7]
        STRB     R12,[R1], #+1
        ADDS     R4,R4,#+1
        UXTH     R4,R4
        SUBS     R3,R3,#+1
        BNE.N    ??AnalyzeAidData_4
//  933 
//  934 			rval += SetCtrlData(AID_Command, rAID_Value, Length, tptr);
??AnalyzeAidData_3:
        MOV      R3,R8
        ADD      R1,SP,#+4
        BL       SetCtrlData
        ADD      R9,R0,R9
        UXTB     R9,R9
//  935 
//  936 			if(Cnt >= BodyFrame->SubLength) break;
        LDRH     R1,[R5, #+1031]
        CMP      R4,R1
        BCC.N    ??AnalyzeAidData_1
//  937 		}
//  938 
//  939 		if(rval)
??AnalyzeAidData_2:
        CMP      R9,#+0
        BEQ.N    ??AnalyzeAidData_5
//  940 		{
//  941 			//write eeprom!!
//  942 			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+128
        MOVS     R0,R7
        BL       WriteBuffertoBackup
//  943 		}
//  944 	}
//  945 	OS_EXIT_CRITICAL();
??AnalyzeAidData_5:
        MOVS     R0,R6
        BL       OS_CPU_SR_Restore
//  946 	
//  947 	return TRUE;
        MOVS     R0,#+1
        ADD      SP,SP,#+48
        POP      {R4-R10,PC}      ;; return
        DATA
??AnalyzeAidData_0:
        DC32     0x8006000
//  948 }
//  949 
//  950 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  951 void Initialize(void)
//  952 {
Initialize:
        PUSH     {R4,LR}
//  953 	__BeaconStsStr *Sts = BeaconSts;
        LDR.N    R0,??Initialize_0  ;; BeaconSts
        LDR      R4,[R0, #+0]
//  954 
//  955 	memcpy(Sts->Flag.Data, 0, sizeof(Sts->Flag));
        MOVS     R2,#+7
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       __aeabi_memcpy
//  956 
//  957 	Sts->Flag.StsConFail = 1;
//  958 	Sts->Flag.BatteryLow = 1;
//  959 	Sts->Flag.DCFail = 1;
//  960 	Sts->Flag.ACFail = 1;
//  961 	Sts->Flag.TempUpperLmt = 1;
//  962 	Sts->Flag.DoorOpen = 1;
        LDRB     R0,[R4, #+0]
        ORR      R0,R0,#0x7E
        STRB     R0,[R4, #+0]
//  963 	Sts->Flag.LocalFail_3G = 1;
//  964 	Sts->Flag.DrvFwdAmpOnOff_3G = 1;
//  965 	Sts->Flag.DrvRvsAmpOnOff_3G = 1;
        LDRB     R0,[R4, #+1]
        ORR      R0,R0,#0x1C
        STRB     R0,[R4, #+1]
//  966 	Sts->Flag.FwdOut_REPLowerLmt_3G = 1;
//  967 	Sts->Flag.FwdOut_REPUpperLmt_3G = 1;
        LDRB     R0,[R4, #+6]
        ORR      R0,R0,#0x6
        STRB     R0,[R4, #+6]
//  968 	Sts->Flag.FwdInLowerLmt_3G = 1;
//  969 	Sts->Flag.FwdInUpperLmt_3G = 1;
//  970 	Sts->Flag.FwdOutLowerLmt_3G = 1;
//  971 	Sts->Flag.FwdOutUpperLmt_3G = 1;
        LDRB     R1,[R4, #+2]
        ORR      R1,R1,#0x78
        STRB     R1,[R4, #+2]
//  972 	Sts->Flag.RvsOutLowerLmt_3G = 1;
//  973 	Sts->Flag.RvsOutUpperLmt_3G = 1;
//  974 	Sts->Flag.RvsInLowerLmt_3G = 1;
//  975 	Sts->Flag.RvsInUpperLmt_3G = 1;
//  976 	Sts->Flag.RvsOsc_3G = 1;
        LDRB     R1,[R4, #+3]
        ORR      R1,R1,#0x7C
        STRB     R1,[R4, #+3]
//  977 	Sts->Flag.FwdAmpDCFail_3G = 1;
//  978 	Sts->Flag.FwdAmpLinkFail_3G = 1;
//  979 	Sts->Flag.FwdAmpOff_3G = 1;
//  980 	Sts->Flag.FwdAmpDevFail_3G = 1;
//  981 	Sts->Flag.FwdAmpVSWRFail_3G = 1;
//  982 	Sts->Flag.FwdAmpHighTempFail_3G = 1;
//  983 	Sts->Flag.FwdAmpOvrPwrFail_3G = 1;
        LDRB     R1,[R4, #+4]
        ORR      R1,R1,#0x7F
        STRB     R1,[R4, #+4]
//  984 
//  985 	Sts->Flag.RvsOsc_3G_LED = 1;
        LDRB     R1,[R4, #+5]
        ORR      R1,R1,#0x80
        STRB     R1,[R4, #+5]
//  986 	Sts->Flag.PwrSupplyLow = 1;
        ORR      R0,R0,#0x20
        STRB     R0,[R4, #+6]
//  987 
//  988 	Sts->Manufacture = __Gtnt;
        MOVS     R0,#+17
        STRB     R0,[R4, #+14]
//  989 	Sts->Supplier = __Gtnt;
        STRB     R0,[R4, #+15]
//  990 	Sts->AmpManufacture_3G = AmpNCL;
        MOVS     R0,#+15
        STRB     R0,[R4, #+32]
//  991 	Sts->AmpCapability_3G = 45;
        MOVS     R0,#+45
        STRB     R0,[R4, #+31]
//  992 	Sts->RepeaterType[0] = 0x01;
        MOVS     R0,#+1
        STRB     R0,[R4, #+16]
//  993 
//  994 	if( Sts->RepeaterType[1] != __COPY_OUT &&
//  995 		Sts->RepeaterType[1] != __COPY_IN &&
//  996 		Sts->RepeaterType[1] != __GEN_IN &&
//  997 		Sts->RepeaterType[1] != __GEN_OUT &&
//  998 		Sts->RepeaterType[1] != __COPY_RACK &&
//  999 		Sts->RepeaterType[1] != __GEN_RACK ) {
        LDRB     R0,[R4, #+17]
        CMP      R0,#+121
        BEQ.N    ??Initialize_1
        CMP      R0,#+120
        BEQ.N    ??Initialize_1
        CMP      R0,#+118
        BEQ.N    ??Initialize_1
        CMP      R0,#+119
        BEQ.N    ??Initialize_1
        CMP      R0,#+123
        BEQ.N    ??Initialize_1
        CMP      R0,#+122
        BEQ.N    ??Initialize_1
// 1000 
// 1001 		Sts->RepeaterType[1] = __COPY_IN;
        MOVS     R0,#+120
        STRB     R0,[R4, #+17]
// 1002 	}
// 1003 	
// 1004 	Sts->SWVer = SystemVer;
??Initialize_1:
        MOVS     R0,#+16
        STRB     R0,[R4, #+18]
// 1005 	Sts->RCUAddVer = PROGRAMVER;
        ADD      R0,R4,#+32
        MOVS     R1,#+0
        STRB     R1,[R0, #+8]
// 1006 
// 1007 	Sts->DrvFwdAmpOnOff_3G = Enable;
        STRB     R1,[R4, #+25]
// 1008 	Sts->DrvRvsAmpOnOff_3G = Enable;
        STRB     R1,[R4, #+26]
// 1009 	Sts->CW0OnOff_3G = Disable;
        MOVS     R1,#+1
        STRB     R1,[R4, #+27]
// 1010 
// 1011 	Sts->CurrFwdAttn1_3G = 0xFF;
        ADD      R1,R4,#+133
        MOV      R2,#-1
        STRB     R2,[R1, #+9]
// 1012 	Sts->CurrFwdAttn2_3G = 0xFF;
        STRB     R2,[R1, #+10]
// 1013 	Sts->CurrFwdAttn3_3G = 0xFF;
        STRB     R2,[R1, #+11]
// 1014 	Sts->CurrFwdAttn4_3G = 0xFF;
        STRB     R2,[R1, #+12]
// 1015 	
// 1016 	Sts->CurrRvsAttn1_3G = 0xFF;
        STRB     R2,[R1, #+13]
// 1017 	Sts->CurrRvsAttn2_3G = 0xFF;
        STRB     R2,[R1, #+14]
// 1018 
// 1019 	Sts->FwdInPwr_3G	 = (-60*2L);
        ADD      R2,R4,#+65
        MVN      R3,#+119
        STRB     R3,[R2, #+3]
// 1020 	Sts->TPTL_OnOff = Enable;
        MOVS     R3,#+0
        STRB     R3,[R0, #+5]
// 1021 	Sts->TotalPwrOnOff_3G = Enable;
        STRB     R3,[R0, #+6]
// 1022 	Sts->RFPathLossResult_3G = PathLossEnd;
        STRB     R3,[R1, #+19]
// 1023 	Sts->StsConFail = 0x00;
        STRB     R3,[R4, #+23]
// 1024 	Sts->FwdOutAttnInit = Sts->FwdOutAttn_3G;
        LDRB     R3,[R2, #+22]
        STRB     R3,[R4, #+170]
// 1025 	Sts->FwdOutAttnREPInit = Sts->FwdOutAttn_REP_3G;
        ADD      R3,R4,#+170
        LDRB     R12,[R2, #+23]
        STRB     R12,[R3, #+1]
// 1026 
// 1027 	if(Sts->RvsOutFA_3G >= 7) Sts->RvsOutFA_3G = 0x00;
        LDRB     R3,[R4, #+65]
        CMP      R3,#+7
        BCC.N    ??Initialize_2
        MOVS     R3,#+0
        STRB     R3,[R4, #+65]
// 1028 	if(Sts->RvsInFA1_3G >= 7) Sts->RvsInFA1_3G = 0x00;
??Initialize_2:
        LDRB     R3,[R2, #+1]
        CMP      R3,#+7
        BCC.N    ??Initialize_3
        MOVS     R3,#+0
        STRB     R3,[R2, #+1]
// 1029 	if(Sts->RvsInFA2_3G >= 7) Sts->RvsInFA2_3G = 0x00;
??Initialize_3:
        LDRB     R3,[R2, #+2]
        CMP      R3,#+7
        BCC.N    ??Initialize_4
        MOVS     R3,#+0
        STRB     R3,[R2, #+2]
// 1030 	if(Sts->FwdInFA_3G >= 7) Sts->FwdInFA_3G = 0x00;
??Initialize_4:
        LDRB     R3,[R0, #+12]
        CMP      R3,#+7
        BCC.N    ??Initialize_5
        MOVS     R3,#+0
        STRB     R3,[R0, #+12]
// 1031 	if(Sts->FwdOutFA1_3G >= 7) Sts->FwdOutFA1_3G = 0x00;
??Initialize_5:
        LDRB     R3,[R0, #+13]
        CMP      R3,#+7
        BCC.N    ??Initialize_6
        MOVS     R3,#+0
        STRB     R3,[R0, #+13]
// 1032 	if(Sts->FwdOutFA2_3G >= 7) Sts->FwdOutFA2_3G = 0x00;
??Initialize_6:
        LDRB     R3,[R0, #+14]
        CMP      R3,#+7
        BCC.N    ??Initialize_7
        MOVS     R3,#+0
        STRB     R3,[R0, #+14]
// 1033 	if(Sts->OutSwitchTime_3G.Data > 400) Sts->OutSwitchTime_3G.Data = 400;
??Initialize_7:
        LDRH     R3,[R0, #+16]
        MOVW     R12,#+401
        CMP      R3,R12
        BCC.N    ??Initialize_8
        MOV      R3,#+400
        B.N      ??Initialize_9
// 1034 	if(Sts->OutSwitchTime_3G.Data == 0) Sts->OutSwitchTime_3G.Data = 1;
??Initialize_8:
        CBNZ     R3,??Initialize_10
        MOVS     R3,#+1
??Initialize_9:
        STRH     R3,[R0, #+16]
// 1035 	if(Sts->Rvs0Gain_3G > (47*2L)) Sts->Rvs0Gain_3G = 47*2L;
??Initialize_10:
        LDRSB    R0,[R1, #+20]
        CMP      R0,#+95
        BLT.N    ??Initialize_11
        MOVS     R0,#+94
        STRB     R0,[R1, #+20]
// 1036 
// 1037 	Sts->FwdInAttn_3G = (30*2L);
??Initialize_11:
        MOVS     R0,#+60
        STRB     R0,[R2, #+24]
// 1038 
// 1039 	Sts->BeaconAlm.FwdAmpOff_3G = Enable;
        LDRB     R0,[R4, #+11]
        AND      R0,R0,#0xF7
        STRB     R0,[R4, #+11]
// 1040 	Sts->ModuleAlarm.AmpShutDn = Enable;
        LDRB     R0,[R4, #+133]
        AND      R0,R0,#0xFB
        STRB     R0,[R4, #+133]
// 1041 	Sts->BeaconAlm.FwdPllLock_3G = 0;
        LDRB     R0,[R4, #+9]
        AND      R0,R0,#0xFD
        STRB     R0,[R4, #+9]
// 1042 
// 1043 	ModuleInform->Kind = 0xB0;
        LDR.N    R0,??Initialize_0+0x4  ;; ModuleInform
        LDR      R0,[R0, #+0]
        MOVS     R1,#+176
        STRB     R1,[R0, #+0]
// 1044 	ModuleInform->SW_Verion = SystemVer;
        MOVS     R1,#+16
        STRB     R1,[R0, #+5]
// 1045 	ModuleInform->Supplier = Sts->Supplier;
        LDRB     R1,[R4, #+15]
        STRB     R1,[R0, #+3]
// 1046 	ModuleInform->Manufacture = Sts->Manufacture;	// winy_RF
        LDRB     R1,[R4, #+14]
        STRB     R1,[R0, #+4]
// 1047 	ModuleInform->Type[0] = Sts->RepeaterType[0];
        LDRB     R1,[R4, #+16]
        STRB     R1,[R0, #+1]
// 1048 	ModuleInform->Type[1] = Sts->RepeaterType[1];
        LDRB     R1,[R4, #+17]
        STRB     R1,[R0, #+2]
// 1049 }
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??Initialize_0:
        DC32     BeaconSts
        DC32     ModuleInform
// 1050 
// 1051 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1052 INT16U GenModuleInformSts(INT8U *dptr)
// 1053 {
GenModuleInformSts:
        PUSH     {R4,LR}
        MOVS     R1,R0
// 1054 	 INT8U i = 0;
// 1055 	 INT16U rlen = 0;
// 1056 
// 1057 	 dptr[rlen++] = ModuleInform->Kind; 
        LDR.N    R0,??GenModuleInformSts_0  ;; ModuleInform
        LDR      R2,[R0, #+0]
        LDRB     R3,[R2, #+0]
        STRB     R3,[R1, #+0]
// 1058 	 dptr[rlen++] = ModuleInform->Type[0];
        LDRB     R3,[R2, #+1]
        STRB     R3,[R1, #+1]
// 1059 	 dptr[rlen++] = ModuleInform->Type[1];
        LDRB     R3,[R2, #+2]
        STRB     R3,[R1, #+2]
// 1060 	 dptr[rlen++] = ModuleInform->Supplier; 
        LDRB     R3,[R2, #+3]
        STRB     R3,[R1, #+3]
// 1061 	 dptr[rlen++] = ModuleInform->Manufacture; 
        LDRB     R2,[R2, #+4]
        STRB     R2,[R1, #+4]
// 1062 	 dptr[rlen++] = BeaconSts->SWVer; 
        LDR.N    R2,??GenModuleInformSts_0+0x4  ;; BeaconSts
        LDR      R2,[R2, #+0]
        LDRB     R2,[R2, #+18]
        STRB     R2,[R1, #+5]
        MOVS     R3,#+6
// 1063 
// 1064 	 for(i = 0; i < 4; i++)
        LDR      R2,[R0, #+0]
        ADDS     R0,R2,#+6
        ADD      R12,R1,#+6
        MOV      LR,#+2
// 1065 	 {
// 1066  		 dptr[rlen++] = ModuleInform->SerialNo[i];
??GenModuleInformSts_1:
        LDRB     R4,[R0], #+1
        STRB     R4,[R12], #+2
        ADDS     R3,R3,#+1
        UXTH     R3,R3
        LDRB     R4,[R0], #+1
        STRB     R4,[R3, R1]
        ADDS     R3,R3,#+1
        UXTH     R3,R3
// 1067 	 }	 
        SUBS     LR,LR,#+1
        BNE.N    ??GenModuleInformSts_1
// 1068 
// 1069 	 for(i = 0; i < 3; i++)
// 1070 	 {
// 1071  		 dptr[rlen++] = ModuleInform->Manufacture_Date[i];
        LDRB     R0,[R2, #+10]
        STRB     R0,[R3, R1]
        ADDS     R0,R3,#+1
        UXTH     R0,R0
        LDRB     R3,[R2, #+11]
        STRB     R3,[R0, R1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     R3,[R2, #+12]
        STRB     R3,[R0, R1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
// 1072 	 }	 
// 1073 
// 1074 	 for(i = 0; i < 15; i++)
        ADD      R3,R2,#+13
        MOV      R12,#+5
// 1075 	 {
// 1076  		 dptr[rlen++] = ModuleInform->ERP_Code[i];
??GenModuleInformSts_2:
        LDRB     LR,[R3], #+1
        STRB     LR,[R0, R1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     LR,[R3], #+1
        STRB     LR,[R0, R1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     LR,[R3], #+1
        STRB     LR,[R0, R1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
// 1077 	 }	 
        SUBS     R12,R12,#+1
        BNE.N    ??GenModuleInformSts_2
// 1078 
// 1079 	 for(i = 0; i < 4; i++)
        ADDS     R2,R2,#+28
        ADDS     R3,R0,R1
        MOV      R12,#+2
// 1080 	 {
// 1081  		 dptr[rlen++] = ModuleInform->Manufacture_Mode[i];
??GenModuleInformSts_3:
        LDRB     LR,[R2], #+1
        STRB     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     LR,[R2], #+1
        STRB     LR,[R0, R1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
// 1082 	 }	 
        SUBS     R12,R12,#+1
        BNE.N    ??GenModuleInformSts_3
// 1083 	 return rlen;
        POP      {R4,PC}          ;; return
        DATA
??GenModuleInformSts_0:
        DC32     ModuleInform
        DC32     BeaconSts
// 1084 
// 1085 }
// 1086 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1087 INT16U GenModuleAutoInformSts(INT8U *dptr)
// 1088 {
GenModuleAutoInformSts:
        PUSH     {R7,LR}
        MOVS     R1,R0
// 1089 	INT8U i = 0;
// 1090 	INT16U rlen = 0;
        MOVS     R0,#+0
// 1091 
// 1092 	for(i = 0; i < sizeof(__ModuleInform); i++)
        LDR.N    R2,??GenModuleAutoInformSts_0  ;; ModuleInform
        LDR      R2,[R2, #+0]
        MOVS     R3,R1
        MOV      R12,#+16
// 1093 	{
// 1094 		dptr[rlen++] = *((INT8U *)&(ModuleInform->Kind) + i);
??GenModuleAutoInformSts_1:
        LDRB     LR,[R2], #+1
        STRB     LR,[R3], #+2
        ADDS     R0,R0,#+1
        UXTH     R0,R0
        LDRB     LR,[R2], #+1
        STRB     LR,[R0, R1]
        ADDS     R0,R0,#+1
        UXTH     R0,R0
// 1095 	}
        SUBS     R12,R12,#+1
        BNE.N    ??GenModuleAutoInformSts_1
// 1096 	/************
// 1097 	for(i = 0; i < sizeof(__ModuleInform); i++)
// 1098 	{
// 1099 		dptr[rlen++] = *((INT8U *)&(ModuleInform_2G->Kind) + i);
// 1100 	}	
// 1101 
// 1102 	for(i = 0; i < sizeof(__ModuleInform); i++)
// 1103 	{
// 1104 		dptr[rlen++] = *((INT8U *)&(ModuleInform_3G->Kind) + i);
// 1105 	}	
// 1106 	for(i = 0; i < sizeof(__ModuleInform); i++)
// 1107 	{
// 1108 		dptr[rlen++] = *((INT8U *)&(ModuleInform_WI->Kind) + i);
// 1109 	}	
// 1110 	for(i = 0; i < sizeof(__ModuleInform); i++)
// 1111 	{
// 1112 		dptr[rlen++] = *((INT8U *)&(ModuleInform_Opt->Kind) + i);
// 1113 	}	
// 1114 	****/
// 1115 	return rlen;
        POP      {R1,PC}          ;; return
        DATA
??GenModuleAutoInformSts_0:
        DC32     ModuleInform
// 1116 
// 1117 }
// 1118 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1119 void LocalMacCtrlData(__MacAddrStr *ptr)
// 1120 {
LocalMacCtrlData:
        PUSH     {R4-R6,LR}
        MOVS     R6,R0
// 1121 	INT32U cpu_sr;
// 1122 
// 1123 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOVS     R4,R0
// 1124 	{
// 1125 		INT8U i = 0;
// 1126 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.N    R5,??LocalMacCtrlData_0  ;; 0x8006000
        MOVS     R0,R5
        BL       RoadBackuptobuffer
// 1127 
// 1128 
// 1129 		for(i = 0; i < 6; i++){
// 1130 			tptr->BackUp.MacAddr[i] = ptr->MacAddr[i];
        LDRB     R1,[R6, #+0]
        STRB     R1,[R0, #+76]
        ADDS     R0,R0,#+76
        LDRB     R1,[R6, #+1]
        STRB     R1,[R0, #+1]
        LDRB     R1,[R6, #+2]
        STRB     R1,[R0, #+2]
        LDRB     R1,[R6, #+3]
        STRB     R1,[R0, #+3]
        LDRB     R1,[R6, #+4]
        STRB     R1,[R0, #+4]
        LDRB     R1,[R6, #+5]
        STRB     R1,[R0, #+5]
// 1131 		}
// 1132 
// 1133 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+128
        MOVS     R0,R5
        BL       WriteBuffertoBackup
// 1134 	}
// 1135 	OS_EXIT_CRITICAL();
        MOVS     R0,R4
        POP      {R4-R6,LR}
        B.W      OS_CPU_SR_Restore
        DATA
??LocalMacCtrlData_0:
        DC32     0x8006000
// 1136 }
// 1137 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1138 void LocalIPCtrlData(__IPAddrStr *ptr)
// 1139 {
LocalIPCtrlData:
        PUSH     {R4-R6,LR}
        MOVS     R6,R0
// 1140 	INT32U cpu_sr;
// 1141 
// 1142 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOVS     R4,R0
// 1143 	{
// 1144 		INT8U i = 0;
// 1145 		
// 1146 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.N    R5,??LocalIPCtrlData_0  ;; 0x8006000
        MOVS     R0,R5
        BL       RoadBackuptobuffer
// 1147 
// 1148 		for(i = 0; i < 4; i++){
// 1149 			tptr->BackUp.IpAddr[i] = ptr->IpAddr[i];
        LDRB     R1,[R6, #+0]
        STRB     R1,[R0, #+64]
// 1150 			tptr->BackUp.GatewayAddr[i] = ptr->GatewayAddr[i];
        ADDS     R0,R0,#+64
        LDRB     R1,[R6, #+4]
        STRB     R1,[R0, #+4]
// 1151 			tptr->BackUp.SubnetAddr[i] = ptr->SubnetAddr[i];
        LDRB     R1,[R6, #+8]
        STRB     R1,[R0, #+8]
        LDRB     R1,[R6, #+1]
        STRB     R1,[R0, #+1]
        LDRB     R1,[R6, #+5]
        STRB     R1,[R0, #+5]
        LDRB     R1,[R6, #+9]
        STRB     R1,[R0, #+9]
        LDRB     R1,[R6, #+2]
        STRB     R1,[R0, #+2]
        LDRB     R1,[R6, #+6]
        STRB     R1,[R0, #+6]
        LDRB     R1,[R6, #+10]
        STRB     R1,[R0, #+10]
        LDRB     R1,[R6, #+3]
        STRB     R1,[R0, #+3]
        LDRB     R1,[R6, #+7]
        STRB     R1,[R0, #+7]
        LDRB     R1,[R6, #+11]
        STRB     R1,[R0, #+11]
// 1152 		}
// 1153 
// 1154 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+128
        MOVS     R0,R5
        BL       WriteBuffertoBackup
// 1155 	}
// 1156 	OS_EXIT_CRITICAL();
        MOVS     R0,R4
        POP      {R4-R6,LR}
        B.W      OS_CPU_SR_Restore
        DATA
??LocalIPCtrlData_0:
        DC32     0x8006000
// 1157 }
// 1158 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1159 void Inform_CtrlDataCopy(__ModuleInformCtrl *mptr)
// 1160 {
Inform_CtrlDataCopy:
        PUSH     {R4-R6,LR}
        MOVS     R6,R0
// 1161 	INT32U cpu_sr;
// 1162 
// 1163 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOVS     R4,R0
// 1164 	{
// 1165 		INT8U i = 0;	
// 1166 		EE_BACK1 *ptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);
        LDR.N    R5,??Inform_CtrlDataCopy_0  ;; 0x8006000
        MOVS     R0,R5
        BL       RoadBackuptobuffer
// 1167 
// 1168 		//if(mptr->Flag.Bit.Kind)
// 1169 		//{
// 1170 		//	ModuleInform->Kind = mptr->Kind;
// 1171 		//	ret++;
// 1172 		//}
// 1173 
// 1174 		//if(mptr->Flag.Bit.Type)
// 1175 		//{
// 1176 		//	ModuleInform->Type[0] = mptr->Type[0];
// 1177 		//	ModuleInform->Type[1] = mptr->Type[1];
// 1178 		//	ret++;
// 1179 		//}
// 1180 
// 1181 		//if(mptr->Flag.Bit.Supplier)
// 1182 		//{
// 1183 		//	ModuleInform->Supplier = mptr->Supplier;
// 1184 		//	ret++;
// 1185 		//}
// 1186 		//if(mptr->Flag.Bit.Manufacture)
// 1187 		//{
// 1188 		//	ModuleInform->Manufacture = mptr->Manufacture;
// 1189 		//	ret++;
// 1190 		//}
// 1191 	//	if(mptr->Flag.Bit.SW_Verion)
// 1192 	//	{
// 1193 	//		ModuleInform->SW_Verion = mptr->SW_Verion;
// 1194 	//		ret++;
// 1195 	//	}
// 1196 
// 1197 		if(mptr->Flag.Bit.SerialNo)
        LDR.N    R1,??Inform_CtrlDataCopy_0+0x4  ;; ModuleInform
        LDRB     R2,[R6, #+0]
        TST      R2,#0x2
        BEQ.N    ??Inform_CtrlDataCopy_1
// 1198 		{
// 1199 			for(i = 0; i < 4; i++)
        MOVS     R2,#+0
        ADD      R3,R6,#+8
// 1200 			{
// 1201 				ModuleInform->SerialNo[i] = mptr->SerialNo[i];
??Inform_CtrlDataCopy_2:
        LDR      R12,[R1, #+0]
        ADD      R12,R2,R12
        LDRB     LR,[R3], #+1
        STRB     LR,[R12, #+6]
// 1202 			}	
        ADDS     R2,R2,#+1
        UXTB     R12,R2
        CMP      R12,#+4
        BCC.N    ??Inform_CtrlDataCopy_2
// 1203 		}
// 1204 
// 1205 		if(mptr->Flag.Bit.Manufacture_Date)
??Inform_CtrlDataCopy_1:
        LDRB     R2,[R6, #+0]
        TST      R2,#0x1
        BEQ.N    ??Inform_CtrlDataCopy_3
// 1206 		{
// 1207 			for(i = 0; i < 3; i++)
        MOVS     R2,#+0
        ADD      R3,R6,#+12
// 1208 			{
// 1209 				ModuleInform->Manufacture_Date[i] = mptr->Manufacture_Date[i];
??Inform_CtrlDataCopy_4:
        LDR      R12,[R1, #+0]
        ADD      R12,R2,R12
        LDRB     LR,[R3], #+1
        STRB     LR,[R12, #+10]
// 1210 			}	
        ADDS     R2,R2,#+1
        UXTB     R12,R2
        CMP      R12,#+3
        BCC.N    ??Inform_CtrlDataCopy_4
// 1211 		}
// 1212 
// 1213 		if(mptr->Flag.Bit.ERP_Code)
??Inform_CtrlDataCopy_3:
        LDRB     R2,[R6, #+1]
        TST      R2,#0x40
        BEQ.N    ??Inform_CtrlDataCopy_5
// 1214 		{
// 1215 			for(i = 0; i < 15 ; i ++)
        MOVS     R2,#+0
        ADD      R3,R6,#+15
// 1216 			{
// 1217 				ModuleInform->ERP_Code[i] = mptr->ERP_Code[i];
??Inform_CtrlDataCopy_6:
        LDR      R12,[R1, #+0]
        ADD      R12,R2,R12
        LDRB     LR,[R3], #+1
        STRB     LR,[R12, #+13]
// 1218 			}
        ADDS     R2,R2,#+1
        UXTB     R12,R2
        CMP      R12,#+15
        BCC.N    ??Inform_CtrlDataCopy_6
// 1219 		}
// 1220 
// 1221 		if(mptr->Flag.Bit.Manufacture_Mode)
??Inform_CtrlDataCopy_5:
        LDRB     R2,[R6, #+1]
        TST      R2,#0x20
        BEQ.N    ??Inform_CtrlDataCopy_7
// 1222 		{
// 1223 			for(i = 0; i < sizeof(ModuleInform->Manufacture_Mode); i ++)
        MOVS     R2,#+0
        ADD      R3,R6,#+30
// 1224 			{
// 1225 				ModuleInform->Manufacture_Mode[i] = mptr->Manufacture_Mode[i];
??Inform_CtrlDataCopy_8:
        LDR      R12,[R1, #+0]
        ADD      R12,R2,R12
        LDRB     LR,[R3], #+1
        STRB     LR,[R12, #+28]
// 1226 			}
        ADDS     R2,R2,#+1
        CMP      R2,#+4
        BCC.N    ??Inform_CtrlDataCopy_8
// 1227 		}
// 1228 		
// 1229 		ptr->BackUp.mInform = *ModuleInform;
??Inform_CtrlDataCopy_7:
        ADDS     R0,R0,#+89
        LDR      R1,[R1, #+0]
        MOVS     R2,#+32
        BL       __aeabi_memcpy
// 1230 
// 1231 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+128
        MOVS     R0,R5
        BL       WriteBuffertoBackup
// 1232 
// 1233 		//for(i = 0; i < sizeof(__ModuleInform); i++)
// 1234 		//{
// 1235 			//WriteEEprom(ModuleInformBp + i, *((INT8U *)ModuleInform + i));
// 1236 		//}
// 1237 	}
// 1238 	OS_EXIT_CRITICAL();
        MOVS     R0,R4
        POP      {R4-R6,LR}
        B.W      OS_CPU_SR_Restore
        Nop      
        DATA
??Inform_CtrlDataCopy_0:
        DC32     0x8006000
        DC32     ModuleInform
// 1239 }
// 1240 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1241 void LoadBackupData(void)
// 1242 {
LoadBackupData:
        PUSH     {R3-R9,LR}
// 1243 	INT32U cpu_sr;
// 1244 	INT32U mDate;
// 1245 	__BeaconStsStr *Sts = BeaconSts;
        LDR.W    R0,??LoadBackupData_0  ;; BeaconSts
        LDR      R9,[R0, #+0]
// 1246 
// 1247 	RUNLEDSEL ^= 1;
        LDR.W    R4,??LoadBackupData_0+0x4  ;; 0x40010c0c
        LDR      R0,[R4, #+0]
        EOR      R0,R0,#0x4
        STR      R0,[R4, #+0]
// 1248 
// 1249 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOVS     R5,R0
// 1250 	{
// 1251 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr);	// Load 1st Area	
        LDR.W    R8,??LoadBackupData_0+0x8  ;; 0x8006000
        MOV      R0,R8
        BL       RoadBackuptobuffer
        MOVS     R6,R0
// 1252 		INT8U iDataFlag = tptr->BackUp.IsDataFlag;
// 1253 		INT8U IsFirstFlag = tptr->BackUp.IsFirstFlag;	// 처음 생산시...인가!!
// 1254 		
// 1255 		if(iDataFlag != ISDATA)
        ADD      R7,R6,#+121
        LDRB     R0,[R6, #+2]
        CMP      R0,#+165
        BEQ.N    ??LoadBackupData_1
// 1256 		{
// 1257 			// default set!!
// 1258 	        tptr->BackUp.RepeaterType = __COPY_IN;
        ADDS     R0,R6,#+2
        MOVS     R1,#+120
        STRB     R1,[R0, #+1]
// 1259 	        tptr->BackUp.TempOffset = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+2]
// 1260 			tptr->BackUp.FwdInFA_3G = 1;
        MOVS     R1,#+1
        STRB     R1,[R0, #+3]
// 1261 			tptr->BackUp.FwdOutFA1_3G = 5;
        MOVS     R1,#+5
        STRB     R1,[R0, #+4]
// 1262 			tptr->BackUp.FwdOutFA2_3G = 6;
        MOVS     R1,#+6
        STRB     R1,[R0, #+5]
// 1263 
// 1264 			tptr->BackUp.FwdInPwrOffset_3G = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+15]
// 1265 			tptr->BackUp.RvsInPwrOffset_3G = 0;
        STRB     R1,[R0, #+19]
// 1266 			tptr->BackUp.Rvs0OutPwrOffset_3G = 0;
        STRB     R1,[R0, #+18]
// 1267 			tptr->BackUp.Rvs0AttnOffset_3G = 0;
        STRB     R1,[R0, #+7]
// 1268 			tptr->BackUp.FwdInAttnOffset_3G = 0;
        STRB     R1,[R6, #+82]
// 1269 			tptr->BackUp.FwdOutAttnOffset_3G = 0;
        ADD      R2,R6,#+82
        STRB     R1,[R2, #+1]
// 1270 			tptr->BackUp.FwdOutAttnREPOffset_3G = 0;
        STRB     R1,[R2, #+2]
// 1271 			
// 1272 			tptr->BackUp.TempUpperLmt = 70;
        MOVS     R1,#+70
        STRB     R1,[R0, #+14]
// 1273 
// 1274 			tptr->BackUp.OutSwitchTime_3G.Data = 2000*5; 
        MOVW     R1,#+10000
        STRH     R1,[R7, #+2]
// 1275 		    tptr->BackUp.OutSwitchAttnOnOff_3G = Disable;
        ADD      R1,R6,#+34
        MOVS     R2,#+1
        STRB     R2,[R1, #+21]
// 1276 
// 1277 			tptr->BackUp.FwdInPllFreqOffset_3G = 0;
        MOVS     R2,#+0
        STRB     R2,[R1, #+14]
// 1278 			tptr->BackUp.FwdOut1PllFreqOffset_3G = 0;
        STRB     R2,[R1, #+15]
// 1279 			tptr->BackUp.FwdOut2PllFreqOffset_3G = 0;
        STRB     R2,[R1, #+16]
// 1280 			tptr->BackUp.RvsIn1PllFreqOffset_3G = 0;
        STRB     R2,[R1, #+17]
// 1281 			tptr->BackUp.RvsIn2PllFreqOffset_3G = 0;
        STRB     R2,[R1, #+18]
// 1282 			tptr->BackUp.RvsOutPllFreqOffset_3G = 0;
        STRB     R2,[R1, #+19]
// 1283 
// 1284 			tptr->BackUp.FwdInAttn_3G = 0;
        STRB     R2,[R0, #+11]
// 1285 			tptr->BackUp.FwdOutAttn_3G = 0;
        STRB     R2,[R0, #+12]
// 1286 			tptr->BackUp.FwdOutAttn_REP_3G = 0;
        STRB     R2,[R0, #+13]
// 1287 			tptr->BackUp.Rvs0Attn_3G = 0;
        STRB     R2,[R0, #+6]
// 1288 			tptr->BackUp.Rvs0Gain_3G = (47*2L);
        MOVS     R2,#+94
        STRB     R2,[R7, #+1]
// 1289 
// 1290 			tptr->BackUp.FwdAmpOff_3G = Enable;
        MOVS     R2,#+0
        STRB     R2,[R6, #+34]
// 1291 			tptr->BackUp.FwdInUpperLmt_3G = (-23*2L);
        MVN      R2,#+45
        STRB     R2,[R0, #+20]
// 1292 			tptr->BackUp.FwdInLowerLmt_3G = (-29*2L);
        MVN      R2,#+57
        STRB     R2,[R0, #+21]
// 1293 
// 1294 			tptr->BackUp.FwdOutUpperLmt_3G[0] = 48;
        MOVS     R2,#+48
        STRB     R2,[R0, #+22]
// 1295 			tptr->BackUp.FwdOutUpperLmt_3G[1] = 0;
        MOVS     R2,#+0
        STRB     R2,[R0, #+23]
// 1296 
// 1297 			tptr->BackUp.FwdOutLowerLmt_3G[0] = 42;
        MOVS     R2,#+42
        STRB     R2,[R0, #+24]
// 1298 			tptr->BackUp.FwdOutLowerLmt_3G[1] = 0;
        MOVS     R2,#+0
        STRB     R2,[R0, #+25]
// 1299 		
// 1300 			tptr->BackUp.FwdOut_REPUpperLmt_3G[0] = -2;
        MVN      R2,#+1
        STRB     R2,[R1, #+23]
// 1301 			tptr->BackUp.FwdOut_REPUpperLmt_3G[1] = 0;
        MOVS     R2,#+0
        STRB     R2,[R1, #+24]
// 1302 
// 1303 			tptr->BackUp.FwdOut_REPLowerLmt_3G[0] = -8;
        MVN      R2,#+7
        STRB     R2,[R1, #+25]
// 1304 			tptr->BackUp.FwdOut_REPLowerLmt_3G[1] = 0;
        MOVS     R2,#+0
        STRB     R2,[R1, #+26]
// 1305 
// 1306 			tptr->BackUp.FwdInALCLvl = (-30*2L);
        MVN      R2,#+59
        STRB     R2,[R1, #+27]
// 1307 
// 1308 			tptr->BackUp.RvsInUpperLmt_3G = (-42*2L);
        MVN      R1,#+83
        STRB     R1,[R0, #+26]
// 1309 			tptr->BackUp.RvsInLowerLmt_3G = (-48*2L);
        MVN      R1,#+95
        STRB     R1,[R0, #+27]
// 1310 
// 1311 			tptr->BackUp.Rvs0OutUpperLmt_3G[0] = 5;
        MOVS     R1,#+5
        STRB     R1,[R0, #+28]
// 1312 			tptr->BackUp.Rvs0OutUpperLmt_3G[1] = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+29]
// 1313 
// 1314 			tptr->BackUp.Rvs0OutLowerLmt_3G[0] = -1;
        MOV      R1,#-1
        STRB     R1,[R0, #+30]
// 1315 			tptr->BackUp.Rvs0OutLowerLmt_3G[1] = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+31]
// 1316 
// 1317 			tptr->BackUp.AlarmMask = 0;
        MOVS     R0,#+0
        STRB     R0,[R6, #+121]
// 1318 
// 1319 	        tptr->BackUp.IsDataFlag = ISDATA;
        MOVS     R0,#+165
        STRB     R0,[R6, #+2]
// 1320 	RUNLEDSEL ^= 1;
        LDR      R0,[R4, #+0]
        EOR      R0,R0,#0x4
        STR      R0,[R4, #+0]
// 1321 			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+128
        MOV      R0,R8
        BL       WriteBuffertoBackup
// 1322 	RUNLEDSEL ^= 1;
        LDR      R0,[R4, #+0]
        EOR      R0,R0,#0x4
        STR      R0,[R4, #+0]
// 1323 
// 1324 			while(1);
??LoadBackupData_2:
        B.N      ??LoadBackupData_2
// 1325 		}
// 1326 
// 1327 		if(IsFirstFlag != ISFIRST)
??LoadBackupData_1:
        LDRB     R0,[R7, #+4]
        CMP      R0,#+165
        BEQ.N    ??LoadBackupData_3
// 1328 		{
// 1329 		
// 1330 			mDate = DATEtoInt(SystemDate);
        LDR.N    R0,??LoadBackupData_0+0xC  ;; `?<Constant "Nov  9 2010">`
        BL       DATEtoInt
// 1331 			tptr->BackUp.mInform.Manufacture_Date[0] = ((mDate >> 16) & 0xffff) - 2000;
        ADD      R2,R6,#+82
        LSRS     R1,R0,#+16
        SUB      R1,R1,#+2000
        STRB     R1,[R2, #+17]
// 1332 			tptr->BackUp.mInform.Manufacture_Date[1] = ((mDate >>  8) & 0xff);
        LSRS     R1,R0,#+8
        STRB     R1,[R2, #+18]
// 1333 			tptr->BackUp.mInform.Manufacture_Date[2] = ((mDate >>  0) & 0xff);
        STRB     R0,[R2, #+19]
// 1334 
// 1335 			memcpy(tptr->BackUp.IpAddr, defaultip.IPAddr, 4);
        LDR.N    R5,??LoadBackupData_0+0x10  ;; defaultip
        MOVS     R2,#+4
        ADDS     R1,R5,#+6
        ADD      R0,R6,#+64
        BL       __aeabi_memcpy
// 1336 			memcpy(tptr->BackUp.GatewayAddr, defaultip.GatewayAddr, 4);
        MOVS     R2,#+4
        ADD      R1,R5,#+10
        ADD      R0,R6,#+68
        BL       __aeabi_memcpy
// 1337 			memcpy(tptr->BackUp.SubnetAddr, defaultip.SubnetAddr, 4);
        MOVS     R2,#+4
        ADD      R1,R5,#+14
        ADD      R0,R6,#+72
        BL       __aeabi_memcpy
// 1338 			memcpy(tptr->BackUp.MacAddr, defaultip.MacAddr, 6);
        MOVS     R2,#+6
        MOVS     R1,R5
        ADD      R0,R6,#+76
        BL       __aeabi_memcpy
// 1339 	
// 1340 			tptr->BackUp.IsFirstFlag = ISFIRST;
        MOVS     R0,#+165
        STRB     R0,[R7, #+4]
// 1341 
// 1342 	RUNLEDSEL ^= 1;
        LDR      R0,[R4, #+0]
        EOR      R0,R0,#0x4
        STR      R0,[R4, #+0]
// 1343 			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOVS     R1,#+128
        MOV      R0,R8
        BL       WriteBuffertoBackup
// 1344 	RUNLEDSEL ^= 1;
        LDR      R0,[R4, #+0]
        EOR      R0,R0,#0x4
        STR      R0,[R4, #+0]
// 1345 			while(1);
??LoadBackupData_4:
        B.N      ??LoadBackupData_4
// 1346 		}
// 1347 #ifdef __PWR_BACKUP_USED
// 1348 			Sts->ResetCase = BKP_ReadBackupRegister(BKP_DR1);
// 1349 #endif
// 1350 		Sts->ResetCase = rambackup[0];
??LoadBackupData_3:
        ADD      R4,R9,#+150
        LDR.N    R0,??LoadBackupData_0+0x14  ;; rambackup
        LDR      R1,[R0, #+0]
        LDRB     R1,[R1, #+0]
        STRB     R1,[R4, #+18]
// 1351 		rambackup[0] = 0;
        LDR      R1,[R0, #+0]
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
// 1352 		destport[0]  = (rambackup[1] << 0);
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+1]
        LDR.N    R2,??LoadBackupData_0+0x18  ;; destport
        STRH     R1,[R2, #+0]
// 1353 		destport[1] |= (rambackup[2] << 8);
        LDRH     R3,[R2, #+2]
        LDRB     R12,[R0, #+2]
        ORR      R3,R3,R12, LSL #+8
        STRH     R3,[R2, #+2]
// 1354 		
// 1355 		if( destport[0] == 0xffff) destport[0] = 0;
        MOVW     R3,#+65535
        CMP      R1,R3
        BNE.N    ??LoadBackupData_5
        MOVS     R1,#+0
        STRH     R1,[R2, #+0]
// 1356 		if( (returnip[0][0] = (INT8U)rambackup[3]) == 0xff ) returnip[0][0] = 0;
??LoadBackupData_5:
        LDRB     R2,[R0, #+3]
        LDR.N    R1,??LoadBackupData_0+0x1C  ;; returnip
        STRB     R2,[R1, #+0]
        CMP      R2,#+255
        BNE.N    ??LoadBackupData_6
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
// 1357 		if( (returnip[0][1] = (INT8U)rambackup[4]) == 0xff ) returnip[0][1] = 0;
??LoadBackupData_6:
        LDRB     R2,[R0, #+4]
        STRB     R2,[R1, #+1]
        CMP      R2,#+255
        BNE.N    ??LoadBackupData_7
        MOVS     R2,#+0
        STRB     R2,[R1, #+1]
// 1358 		if( (returnip[0][2] = (INT8U)rambackup[5]) == 0xff ) returnip[0][2] = 0;
??LoadBackupData_7:
        LDRB     R2,[R0, #+5]
        STRB     R2,[R1, #+2]
        CMP      R2,#+255
        BNE.N    ??LoadBackupData_8
        MOVS     R2,#+0
        STRB     R2,[R1, #+2]
// 1359 		if( (returnip[0][3] = (INT8U)rambackup[6]) == 0xff ) returnip[0][3] = 0;
??LoadBackupData_8:
        LDRB     R0,[R0, #+6]
        STRB     R0,[R1, #+3]
        CMP      R0,#+255
        BNE.N    ??LoadBackupData_9
        MOVS     R0,#+0
        STRB     R0,[R1, #+3]
// 1360 		
// 1361 		if(Sts->ResetCase != 0x01 && Sts->ResetCase != 0x02 && Sts->ResetCase != 0x04)
??LoadBackupData_9:
        LDRB     R0,[R4, #+18]
        CMP      R0,#+1
        BEQ.N    ??LoadBackupData_10
        CMP      R0,#+2
        BEQ.N    ??LoadBackupData_10
        CMP      R0,#+4
        BEQ.N    ??LoadBackupData_10
// 1362 			Sts->ResetCase = 0x03;
        MOVS     R0,#+3
        STRB     R0,[R4, #+18]
// 1363 
// 1364 		Sts->RepeaterType[1] = tptr->BackUp.RepeaterType;
??LoadBackupData_10:
        ADDS     R0,R6,#+2
        LDRB     R1,[R0, #+1]
        STRB     R1,[R9, #+17]
// 1365 		Sts->TXCUModel = tptr->BackUp.TXCUModel;
        ADD      R2,R9,#+17
        ADD      R1,R6,#+34
        LDRB     R3,[R1, #+22]
        STRB     R3,[R2, #+24]
// 1366 		Sts->Rvs0Attn_3G = tptr->BackUp.Rvs0Attn_3G;
        LDRB     R3,[R0, #+6]
        STRB     R3,[R2, #+7]
// 1367 
// 1368 		Sts->TempOffset = tptr->BackUp.TempOffset;
        LDRB     R3,[R0, #+2]
        STRB     R3,[R2, #+22]
// 1369 		Sts->TempUpperLmt = tptr->BackUp.TempUpperLmt;
        LDRB     R3,[R0, #+14]
        STRB     R3,[R2, #+3]
// 1370 		Sts->FwdInUpperLmt_3G = tptr->BackUp.FwdInUpperLmt_3G;	
        ADD      R3,R9,#+50
        LDRB     R12,[R0, #+20]
        STRB     R12,[R3, #+19]
// 1371 		Sts->FwdInLowerLmt_3G = tptr->BackUp.FwdInLowerLmt_3G;
        LDRB     R12,[R0, #+21]
        STRB     R12,[R3, #+20]
// 1372 		Sts->FwdOutUpperLmt_3G[0] = tptr->BackUp.FwdOutUpperLmt_3G[0];
        LDRSB    R12,[R0, #+22]
        STRB     R12,[R3, #+23]
// 1373 		Sts->FwdOutUpperLmt_3G[1] = tptr->BackUp.FwdOutUpperLmt_3G[1];
        LDRSB    R12,[R0, #+23]
        STRB     R12,[R3, #+24]
// 1374 		Sts->FwdOutLowerLmt_3G[0] = tptr->BackUp.FwdOutLowerLmt_3G[0];
        LDRSB    R12,[R0, #+24]
        STRB     R12,[R3, #+25]
// 1375 		Sts->FwdOutLowerLmt_3G[1] = tptr->BackUp.FwdOutLowerLmt_3G[1];
        LDRSB    R12,[R0, #+25]
        STRB     R12,[R3, #+26]
// 1376 		Sts->FwdOut_REPUpperLmt_3G[0] = tptr->BackUp.FwdOut_REPUpperLmt_3G[0];
        LDRB     R12,[R1, #+23]
        STRB     R12,[R9, #+83]
// 1377 		Sts->FwdOut_REPUpperLmt_3G[1] = tptr->BackUp.FwdOut_REPUpperLmt_3G[1];
        ADD      R12,R9,#+83
        LDRB     LR,[R1, #+24]
        STRB     LR,[R12, #+1]
// 1378 		Sts->FwdOut_REPLowerLmt_3G[0] = tptr->BackUp.FwdOut_REPLowerLmt_3G[0];
        LDRB     LR,[R1, #+25]
        STRB     LR,[R12, #+2]
// 1379 		Sts->FwdOut_REPLowerLmt_3G[1] = tptr->BackUp.FwdOut_REPLowerLmt_3G[1];
        LDRB     LR,[R1, #+26]
        STRB     LR,[R12, #+3]
// 1380 
// 1381 		Sts->Rvs0OutUpperLmt_3G[0] = tptr->BackUp.Rvs0OutUpperLmt_3G[0];
        LDRB     LR,[R0, #+28]
        STRB     LR,[R12, #+12]
// 1382 		Sts->Rvs0OutUpperLmt_3G[1] = tptr->BackUp.Rvs0OutUpperLmt_3G[1];
        LDRB     LR,[R0, #+29]
        STRB     LR,[R12, #+13]
// 1383 		Sts->Rvs0OutLowerLmt_3G[0] = tptr->BackUp.Rvs0OutLowerLmt_3G[0];
        LDRB     LR,[R0, #+30]
        STRB     LR,[R12, #+14]
// 1384 		Sts->Rvs0OutLowerLmt_3G[1] = tptr->BackUp.Rvs0OutLowerLmt_3G[1]; 
        LDRB     LR,[R0, #+31]
        STRB     LR,[R12, #+15]
// 1385 
// 1386 		Sts->FwdInPwrOffset_3G = tptr->BackUp.FwdInPwrOffset_3G;
        LDRB     LR,[R0, #+15]
        STRB     LR,[R12, #+18]
// 1387 		Sts->RvsInPwrOffset_3G = tptr->BackUp.RvsInPwrOffset_3G;
        LDRB     LR,[R0, #+19]
        STRB     LR,[R12, #+19]
// 1388 		Sts->Rvs0OutPwrOffset_3G = tptr->BackUp.Rvs0OutPwrOffset_3G;
        LDRB     LR,[R0, #+18]
        STRB     LR,[R12, #+20]
// 1389 		Sts->Rvs0AttnOffset_3G = tptr->BackUp.Rvs0AttnOffset_3G;
        LDRSB    LR,[R0, #+7]
        STRB     LR,[R12, #+28]
// 1390 
// 1391 		Sts->FwdInFA_3G = tptr->BackUp.FwdInFA_3G;
        LDRB     LR,[R0, #+3]
        STRB     LR,[R2, #+27]
// 1392 		Sts->FwdOutFA1_3G = tptr->BackUp.FwdOutFA1_3G;
        LDRB     LR,[R0, #+4]
        STRB     LR,[R2, #+28]
// 1393 		Sts->FwdOutFA2_3G = tptr->BackUp.FwdOutFA2_3G;
        LDRB     LR,[R0, #+5]
        STRB     LR,[R2, #+29]
// 1394 
// 1395 		Sts->RvsOutFA_3G = tptr->BackUp.FwdInFA_3G;
        LDRB     LR,[R0, #+3]
        STRB     LR,[R3, #+15]
// 1396 		Sts->RvsInFA1_3G = tptr->BackUp.FwdOutFA1_3G;
        LDRB     LR,[R0, #+4]
        STRB     LR,[R3, #+16]
// 1397 		Sts->RvsInFA2_3G = tptr->BackUp.FwdOutFA2_3G;
        LDRB     LR,[R0, #+5]
        STRB     LR,[R3, #+17]
// 1398 
// 1399 		Sts->Rvs0AttnTemp_3G = tptr->BackUp.Rvs0AttnTemp_3G;
        LDRB     R3,[R0, #+8]
        STRB     R3,[R9, #+115]
// 1400 		Sts->TempUpperLmt = tptr->BackUp.TempUpperLmt;
        LDRB     R3,[R0, #+14]
        STRB     R3,[R2, #+3]
// 1401 		Sts->FwdOutPwrOffset_3G = tptr->BackUp.FwdOutPwrOffset_3G;
        LDRB     R3,[R0, #+16]
        STRB     R3,[R12, #+16]
// 1402 		Sts->FwdPwrREPOffset_3G = tptr->BackUp.FwdPwr_REPOffset_3G;
        LDRB     R3,[R0, #+17]
        STRB     R3,[R12, #+17]
// 1403 		
// 1404 		Sts->FwdAmpOff_3G = tptr->BackUp.FwdAmpOff_3G;			// 제어로 인한 ..!!! ON/OFF check..
        LDRB     R3,[R6, #+34]
        STRB     R3,[R2, #+12]
// 1405 		Sts->RvsOscLvl = tptr->BackUp.RvsOscLvl;
        ADD      R2,R9,#+118
        LDRB     R3,[R1, #+1]
        STRB     R3,[R2, #+31]
// 1406 
// 1407 		Sts->FwdInAttnTemp_3G = tptr->BackUp.FwdInAttnTemp_3G;
        LDRB     R3,[R0, #+10]
        STRB     R3,[R12, #+31]
// 1408 		Sts->FwdInAttn_3G = tptr->BackUp.FwdInAttn_3G;
        LDRSB    R3,[R0, #+11]
        STRB     R3,[R12, #+6]
// 1409 		Sts->FwdOutAttn_3G = tptr->BackUp.FwdOutAttn_3G;
        LDRB     R3,[R0, #+12]
        STRB     R3,[R12, #+4]
// 1410 		Sts->FwdOutAttn_REP_3G = tptr->BackUp.FwdOutAttn_REP_3G;
        LDRB     R3,[R0, #+13]
        STRB     R3,[R12, #+5]
// 1411 
// 1412 		Sts->FwdInPllFreqTemp_3G.Data = tptr->BackUp.FwdInPllFreqTemp_3G.Data;
        LDRH     R3,[R1, #+2]
        STRH     R3,[R9, #+118]
// 1413 		Sts->FwdOut1PllFreqTemp_3G.Data = tptr->BackUp.FwdOut1PllFreqTemp_3G.Data;
        LDRH     R3,[R1, #+4]
        STRH     R3,[R2, #+2]
// 1414 		Sts->FwdOut2PllFreqTemp_3G.Data = tptr->BackUp.FwdOut2PllFreqTemp_3G.Data;
        LDRH     R3,[R1, #+6]
        STRH     R3,[R2, #+4]
// 1415 		Sts->RvsIn1PllFreqTemp_3G.Data = tptr->BackUp.RvsIn1PllFreqTemp_3G.Data;
        LDRH     R3,[R1, #+8]
        STRH     R3,[R2, #+6]
// 1416 		Sts->RvsIn2PllFreqTemp_3G.Data = tptr->BackUp.RvsIn2PllFreqTemp_3G.Data;
        LDRH     R3,[R1, #+10]
        STRH     R3,[R2, #+8]
// 1417 		Sts->RvsOutPllFreqTemp_3G.Data = tptr->BackUp.RvsOutPllFreqTemp_3G.Data;
        LDRH     R3,[R1, #+12]
        STRH     R3,[R2, #+10]
// 1418 
// 1419 		Sts->FwdInPllFreqOffset_3G = tptr->BackUp.FwdInPllFreqOffset_3G;
        LDRB     R2,[R1, #+14]
        STRB     R2,[R12, #+21]
// 1420 		Sts->FwdOut1PllFreqOffset_3G = tptr->BackUp.FwdOut1PllFreqOffset_3G;
        LDRB     R2,[R1, #+15]
        STRB     R2,[R12, #+22]
// 1421 		Sts->FwdOut2PllFreqOffset_3G = tptr->BackUp.FwdOut2PllFreqOffset_3G;
        LDRB     R2,[R1, #+16]
        STRB     R2,[R12, #+23]
// 1422 		Sts->OutSwitchTime_3G = tptr->BackUp.OutSwitchTime_3G;
        ADD      R2,R9,#+48
        ADD      R3,R6,#+123
        LDRB     LR,[R3, #0]
        STRB     LR,[R2, #+0]
        LDRB     LR,[R3, #+1]
        STRB     LR,[R2, #+1]
// 1423 		Sts->OutSwitchAttnOnOff_3G = tptr->BackUp.OutSwitchAttnOnOff_3G & 0x01;
        LDRB     R2,[R1, #+21]
        AND      R2,R2,#0x1
        STRB     R2,[R9, #+50]
// 1424 		Sts->RvsIn1PllFreqOffset_3G = tptr->BackUp.RvsIn1PllFreqOffset_3G;
        LDRB     R2,[R1, #+17]
        STRB     R2,[R12, #+24]
// 1425 		Sts->RvsIn2PllFreqOffset_3G = tptr->BackUp.RvsIn2PllFreqOffset_3G;
        LDRB     R2,[R1, #+18]
        STRB     R2,[R12, #+25]
// 1426 		Sts->RvsOutPllFreqOffset_3G = tptr->BackUp.RvsOutPllFreqOffset_3G;
        LDRB     R2,[R1, #+19]
        STRB     R2,[R12, #+26]
// 1427 
// 1428 		Sts->FwdInAttnOffset_3G = tptr->BackUp.FwdInAttnOffset_3G;
        LDRB     R2,[R6, #+82]
        STRB     R2,[R12, #+27]
// 1429 		Sts->FwdOutAttnOffset_3G = tptr->BackUp.FwdOutAttnOffset_3G;
        ADD      R2,R6,#+82
        LDRB     R3,[R2, #+1]
        STRB     R3,[R12, #+29]
// 1430 		Sts->FwdOutAttnREPOffset_3G = tptr->BackUp.FwdOutAttnREPOffset_3G;
        LDRB     R3,[R2, #+2]
        STRB     R3,[R12, #+30]
// 1431 		Sts->FwdOutAttnTemp_3G = tptr->BackUp.FwdOutAttnTemp_3G;
        ADD      R3,R9,#+115
        LDRB     LR,[R2, #+3]
        STRB     LR,[R3, #+1]
// 1432 		Sts->FwdOutREPTempAttn_3G = tptr->BackUp.FwdOutREPTempAttn_3G;
        LDRB     R2,[R2, #+4]
        STRB     R2,[R3, #+2]
// 1433 		Sts->RvsInUpperLmt_3G = tptr->BackUp.RvsInUpperLmt_3G;
        LDRB     R2,[R0, #+26]
        STRB     R2,[R12, #+8]
// 1434 		Sts->RvsInLowerLmt_3G = tptr->BackUp.RvsInLowerLmt_3G;
        LDRB     R0,[R0, #+27]
        STRB     R0,[R12, #+9]
// 1435 		Sts->AlarmMask = tptr->BackUp.AlarmMask & 0x01;
        LDRB     R0,[R6, #+121]
        AND      R0,R0,#0x1
        STRB     R0,[R4, #+24]
// 1436 		Sts->Rvs0Gain_3G = tptr->BackUp.Rvs0Gain_3G;
        LDRSB    R0,[R7, #+1]
        STRB     R0,[R4, #+3]
// 1437 		Sts->FwdInALCLvl = tptr->BackUp.FwdInALCLvl;		
        LDRB     R0,[R1, #+27]
        STRB     R0,[R9, #+150]
// 1438 
// 1439 		*ModuleInform = tptr->BackUp.mInform;
        LDR.N    R0,??LoadBackupData_0+0x20  ;; ModuleInform
        LDR      R0,[R0, #+0]
        ADD      R1,R6,#+89
        MOVS     R2,#+32
        BL       __aeabi_memcpy
// 1440 	}	
// 1441 
// 1442 	OS_EXIT_CRITICAL();
        MOVS     R0,R5
        BL       OS_CPU_SR_Restore
// 1443 
// 1444 	SerPtr->printf("BEACON Ver[%02x].[%02x]\n",SystemVer, PROGRAMVER);
        LDR.N    R5,??LoadBackupData_0+0x24  ;; SerPtr
        LDR.N    R6,??LoadBackupData_0+0xC  ;; `?<Constant "Nov  9 2010">`
        MOVS     R2,#+0
        MOVS     R1,#+16
        ADD      R0,R6,#+12
        LDR      R3,[R5, #+0]
        LDR      R3,[R3, #+16]
        BLX      R3
// 1445 	SerPtr->printf("SystemDate[%s]\n", SystemDate);
        MOVS     R1,R6
        ADD      R0,R6,#+40
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
// 1446 	SerPtr->printf("SystemTime[%s]\n", SystemTime);
        ADD      R1,R6,#+72
        ADD      R0,R6,#+56
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
// 1447 	SerPtr->printf("Resetcase[%d]\n", Sts->ResetCase);
        LDRB     R1,[R4, #+18]
        ADD      R0,R6,#+84
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        POP      {R3-R9,LR}
        BX       R2
        Nop      
        DATA
??LoadBackupData_0:
        DC32     BeaconSts
        DC32     0x40010c0c
        DC32     0x8006000
        DC32     `?<Constant "Nov  9 2010">`
        DC32     defaultip
        DC32     rambackup
        DC32     destport
        DC32     returnip
        DC32     ModuleInform
        DC32     SerPtr
// 1448 
// 1449 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Nov  9 2010">`:
        DATA
        DC8 "Nov  9 2010"
        DC8 "BEACON Ver[%02x].[%02x]\012"
        DC8 0, 0, 0
        DC8 "SystemDate[%s]\012"
        DC8 "SystemTime[%s]\012"
        DC8 "11:33:55"
        DC8 0, 0, 0
        DC8 "Resetcase[%d]\012"
        DC8 0

        END
// 1450 
// 1451 ////////////////////////////////////////////////////////////////////////////////
// 1452 // End of Source File
// 1453 ////////////////////////
// 1454 
// 
//     4 bytes in section .data
//   100 bytes in section .rodata
// 6 480 bytes in section .text
// 
// 6 480 bytes of CODE  memory
//   100 bytes of CONST memory
//     4 bytes of DATA  memory
//
//Errors: none
//Warnings: none
