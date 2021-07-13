///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    30/Aug/2012  21:29:29 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_protocol. /
//                    c                                                       /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_protocol. /
//                    c -D OS_INCLUDED -D APPL_SRC -lcN                       /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -lB         /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -o          /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\             /
//                    --endian=little --cpu=Cortex-M3 -e --fpu=None           /
//                    --dlib_config "C:\Programming\IAR Systems\Embedded      /
//                    Workbench 6.0\arm\INC\c\DLib_Config_Normal.h" -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\include\ -I       /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\..\..\STM32F2xx_S /
//                    tdPeriph_Driver\ -I D:\Work\Project\2012\NL_INBUILD\FW\ /
//                    MU\..\..\STM32F2xx_StdPeriph_Driver\inc\ -I             /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-CPU\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-LIB\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Ports\    /
//                    -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Source /
//                    \ -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-Probe\    /
//                    -Oh --use_c++_inline --require_prototypes               /
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\aa_protocol. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_protocol

        #define SHT_PROGBITS 0x1

        EXTERN HuStatus
        EXTERN MuStatus
        EXTERN RuStatus
        EXTERN SerPtr

        PUBLIC DefaultBackup
        PUBLIC Initialize
        PUBLIC LoadBackupData
        PUBLIC NmsResetCase
        PUBLIC SetDnrCtrlData
        PUBLIC StatusInitialize
        PUBLIC rambackup

// D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_protocol.c
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
//   16 
//   17 #include "../include/main.h"

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute INT8U *rambackup
rambackup:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
// __absolute INT8U NmsResetCase
NmsResetCase:
        DS8 1
//   18 
//   19 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//   20 
//   21 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   22 void Initialize(void)
//   23 {
Initialize:
        PUSH     {R4,LR}
//   24 	StatusInitialize();	// buffer init
        BL       StatusInitialize
//   25 	LoadBackupData();	// default setting!!
//   26  	//LoadTable();		// eeprom을 사용하지 않으면 필요없다.
//   27 
//   28 ////////////////////////////////////////////////////////////////////////////////////
//   29 	SerPtr->printf("NL SOFTBANK In-Building Ver[%02x].[%02x]\n", SystemVer, PROGRAMVER);
        LDR.W    R4,??DataTable7
        MOVS     R2,#+0
        MOVS     R1,#+1
        ADR.W    R0,`?<Constant "NL SOFTBANK In-Buildi...">`
        LDR      R3,[R4, #+0]
        LDR      R3,[R3, #+16]
        BLX      R3
//   30 	SerPtr->printf("SystemDate[%s]\n", SystemDate);
        ADR.W    R1,`?<Constant "Aug 30 2012">`
        ADR.W    R0,`?<Constant "SystemDate[%s]\\n">`
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//   31 	SerPtr->printf("SystemTime[%s]\n", SystemTime);
        ADR.W    R1,`?<Constant "21:29:28">`
        ADR.W    R0,`?<Constant "SystemTime[%s]\\n">`
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        POP      {R4,LR}
        BX       R2
//   32 }
//   33 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   34 void StatusInitialize(void)
//   35 {
StatusInitialize:
        PUSH     {R4,R5}
//   36 	INT16U	i;
//   37 
//   38 	for(i=0; i<sizeof(__MU_STS); i++)
        MOVS     R1,#+0
        MOVW     R2,#+966
        LDR.W    R0,??DataTable7_1
        MOVS     R4,#+0
//   39 	{
//   40 		*((INT8U*)MuStatus+i) = 0;
??StatusInitialize_0:
        LDR      R3,[R0, #+0]
        STRB     R4,[R1, R3]
//   41 	}
        ADDS     R1,R1,#+1
        CMP      R1,R2
        BCC.N    ??StatusInitialize_0
//   42 	for(i=0; i<sizeof(__HU_STS); i++)
        MOVS     R1,#+0
        MOVW     R2,#+765
        LDR.W    R3,??DataTable7_2
        MOV      R5,R1
//   43 	{
//   44 		*((INT8U*)HuStatus+i) = 0;
??StatusInitialize_1:
        LDR      R4,[R3, #+0]
        STRB     R5,[R1, R4]
//   45 	}
        ADDS     R1,R1,#+1
        CMP      R1,R2
        BCC.N    ??StatusInitialize_1
//   46 	for(i=0; i<sizeof(__RU_STS); i++)
        MOVS     R1,#+0
        LDR.W    R2,??DataTable7_3
        MOV      R4,R1
//   47 	{
//   48 		*((INT8U*)RuStatus+i) = 0;
??StatusInitialize_2:
        LDR      R3,[R2, #+0]
        STRB     R4,[R1, R3]
//   49 	}
        ADDS     R1,R1,#+1
        MOV      R3,#+860
        CMP      R1,R3
        BCC.N    ??StatusInitialize_2
//   50 
//   51 	// Init Value
//   52 	MuStatus->SystemIns.MakerID 		= 0x2C;
        LDR      R1,[R0, #+0]
        MOVS     R2,#+44
        STRB     R2,[R1, #+0]
//   53 	MuStatus->SystemIns.ProgramVer[0]	= SystemVer;
        LDR      R1,[R0, #+0]
        MOVS     R2,#+1
        STRB     R2,[R1, #+1]
//   54 	MuStatus->SystemIns.ProgramVer[1]	= PROGRAMVER;
        LDR      R1,[R0, #+0]
        STRB     R4,[R1, #+2]
//   55 
//   56 	//-----------------------------------------------------------------------//
//   57 	// MU Install
//   58 	MuStatus->SystemIns.Mu_Install = 1;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+14]
//   59 	
//   60 	// HU Install
//   61 	MuStatus->SystemIns.Hu_Install[0] = 1;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+15]
//   62 
//   63 	// HU-RU Install
//   64 	MuStatus->SystemIns.Hu1_Ru.Br1_Ru_Install[0] = 1;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+23]
//   65 	
//   66 	// MU-RU Install
//   67 	for(i=0; i<MDTU_MAX; i++)
        MOVS     R1,#+0
        MOVS     R2,#+8
//   68 	{
//   69 		MuStatus->SystemIns.Mu_Ru_Install[i][0] = 0;
??StatusInitialize_3:
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+535]
//   70 		MuStatus->SystemIns.Mu_Ru_Install[i][1] = 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+536]
//   71 		MuStatus->SystemIns.Mu_Ru_Install[i][2] = 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+537]
//   72 		MuStatus->SystemIns.Mu_Ru_Install[i][3] = 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+538]
//   73 		MuStatus->SystemIns.Mu_Ru_Install[i][4] = 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+539]
//   74 		MuStatus->SystemIns.Mu_Ru_Install[i][5] = 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+540]
//   75 		MuStatus->SystemIns.Mu_Ru_Install[i][6] = 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+541]
//   76 		MuStatus->SystemIns.Mu_Ru_Install[i][7] = 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+542]
//   77 	}
        ADDS     R1,R1,#+8
        SUBS     R2,R2,#+1
        BNE.N    ??StatusInitialize_3
//   78 			
//   79 	// System
//   80 	MuStatus->TempLimitH		= 50;
        LDR      R1,[R0, #+0]
        MOVS     R2,#+50
        STRB     R2,[R1, #+602]
//   81 	MuStatus->TempLimitL		= 0;
        LDR      R1,[R0, #+0]
        STRB     R4,[R1, #+603]
//   82 
//   83 	MuStatus->FanTemp			= 50;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+604]
//   84 	MuStatus->FanMode			= _OFF;
        LDR      R1,[R0, #+0]
        STRB     R4,[R1, #+605]
//   85 	MuStatus->FanOnOff			= _OFF;
        LDR      R1,[R0, #+0]
        STRB     R4,[R1, #+606]
//   86 	MuStatus->TempCompOnOff 	= _OFF;
        LDR      R1,[R0, #+0]
        STRB     R4,[R1, #+607]
//   87 
//   88 	for(i=0; i<10; i++)
        MOVS     R1,#+0
//   89 		MuStatus->SystemIns.RepeaterID[i]		= 0x31+i;
??StatusInitialize_4:
        LDR      R2,[R0, #+0]
        ADDS     R2,R1,R2
        ADD      R3,R1,#+49
        STRB     R3,[R2, #+4]
        ADDS     R1,R1,#+1
        CMP      R1,#+10
        BLT.N    ??StatusInitialize_4
//   90 	
//   91 	// MDTU
//   92 	for(i=0; i<MDTU_MAX; i++)
        MOVS     R1,#+0
        MOVS     R2,#+8
//   93 	{
//   94 		MuStatus->MdtuSts[i].PD_LimitL			= 0;
??StatusInitialize_5:
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+612]
//   95 		MuStatus->MdtuSts[i].LD_LimitL			= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+613]
//   96 		MuStatus->MdtuSts[i].OpticSum			= _OFF;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+615]
//   97 
//   98 		MuStatus->MdtuSts[i].FaFilter_21G		= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+616]
//   99 		MuStatus->MdtuSts[i].FaOnOff_21G.Data	= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+617]
//  100 		MuStatus->MdtuSts[i].FaFilter_900M		= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+618]
//  101 		MuStatus->MdtuSts[i].FaOnOff_900M.Data	= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+619]
//  102 		MuStatus->MdtuSts[i].FaFilter_25G		= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+620]
//  103 		MuStatus->MdtuSts[i].FaOnOff_25G.Data	= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+621]
//  104 
//  105 		MuStatus->MdtuSts[i].PD_Offset			= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+622]
//  106 		MuStatus->MdtuSts[i].LD_Offset			= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+623]
//  107 	}
        ADDS     R1,R1,#+16
        SUBS     R2,R2,#+1
        BNE.N    ??StatusInitialize_5
//  108 
//  109 	for(i=0; i<RFU_MAX; i++)
        MOVS     R1,#+0
        MOVS     R2,#+6
//  110 	{
//  111 		MuStatus->MrfuSts[i].DL_OutLimitH	= 0;
??StatusInitialize_6:
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+740]
//  112 		MuStatus->MrfuSts[i].DL_Attn		= 30;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        MOVS     R4,#+30
        STRB     R4,[R3, #+741]
//  113 
//  114 		MuStatus->MrfuSts[i].UL_OutLimitH	= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R5,[R3, #+744]
//  115 		MuStatus->MrfuSts[i].UL_Attn		= 30;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+745]
//  116 		MuStatus->MrfuSts[i].UL_ALC_High	= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        MOVS     R4,#+0
        STRB     R4,[R3, #+746]
//  117 		MuStatus->MrfuSts[i].UL_Alc_OnOffH	= _OFF;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+747]
//  118 		MuStatus->MrfuSts[i].UL_Amp_OnOff	= _OFF;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+748]
//  119 		
//  120 		MuStatus->MrfuSts[i].DL_SD_Limit	= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+749]
//  121 		MuStatus->MrfuSts[i].DL_SD_OnOff	= _OFF;;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+750]
//  122 
//  123 		MuStatus->MrfuSts[i].UL_SD_Limit	= 0;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+751]
//  124 		MuStatus->MrfuSts[i].UL_SD_OnOff	= _OFF;
        LDR      R3,[R0, #+0]
        ADDS     R3,R1,R3
        STRB     R4,[R3, #+752]
//  125 	}
        ADDS     R1,R1,#+17
        SUBS     R2,R2,#+1
        BNE.N    ??StatusInitialize_6
//  126 
//  127 	MuStatus->Tsync_Auto		= _OFF;
        LDR      R1,[R0, #+0]
        MOVS     R2,#+0
        STRB     R2,[R1, #+838]
//  128 	MuStatus->Tsync_Manual		= _OFF;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+839]
//  129 	MuStatus->Tsync_OnOff_S 	= _OFF;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+840]
//  130 	MuStatus->Tsync_OnOff_M 	= _OFF;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+841]
//  131 	MuStatus->Tsync_Offset_S	= 0;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+842]
//  132 	MuStatus->Tsync_Offset_M	= 0;
        LDR      R1,[R0, #+0]
        STRB     R2,[R1, #+843]
//  133 	
//  134 	for(i=0; i<RFU_MAX; i++)
        MOV      R1,R2
        MOVS     R3,#+6
//  135 	{
//  136 		// CFR/TX 출력
//  137 		MuStatus->CfrSts[i].Cfr_Enable.Data = _OFF;
??StatusInitialize_7:
        LDR      R4,[R0, #+0]
        ADDS     R4,R1,R4
        STRB     R5,[R4, #+844]
//  138 		MuStatus->CfrSts[i].Cfr_OnOff.Data	= _OFF;
        LDR      R4,[R0, #+0]
        ADDS     R4,R1,R4
        STRB     R5,[R4, #+845]
//  139 
//  140 		MuStatus->CfrSts[i].Cfr_Select		= 0;
        LDR      R4,[R0, #+0]
        ADDS     R4,R1,R4
        STRB     R5,[R4, #+846]
//  141 		MuStatus->CfrSts[i].Limit_OnOff 	= _OFF;
        LDR      R4,[R0, #+0]
        ADDS     R4,R1,R4
        STRB     R5,[R4, #+847]
//  142 
//  143 		// Offset
//  144 		MuStatus->MrfuOffset[i].DL_Attn 	= 0;
        LDR      R4,[R0, #+0]
        ADDS     R4,R2,R4
        STRB     R5,[R4, #+892]
//  145 		MuStatus->MrfuOffset[i].UL_Attn 	= 0;
        LDR      R4,[R0, #+0]
        ADDS     R4,R2,R4
        STRB     R5,[R4, #+893]
//  146 
//  147 		MuStatus->MrfuOffset[i].DL_Pwr_Offset	= 0;
        LDR      R4,[R0, #+0]
        ADDS     R4,R2,R4
        STRH     R5,[R4, #+894]
//  148 		MuStatus->MrfuOffset[i].UL_Pwr_Offset	= 0;
        STRH     R5,[R4, #+896]
//  149 	}
        ADDS     R2,R2,#+10
        ADDS     R1,R1,#+8
        SUBS     R3,R3,#+1
        BNE.N    ??StatusInitialize_7
//  150 }
        POP      {R4,R5}
        BX       LR               ;; return
//  151 
//  152 
//  153 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  154 void LoadBackupData(void)
//  155 {
//  156 /*
//  157 	INT16U	i;
//  158 	INT32U cpu_sr;
//  159 
//  160 	RUNLEDSEL ^= 1;
//  161 
//  162 	OS_ENTER_CRITICAL();
//  163 	{
//  164 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area
//  165 
//  166 		//-----------------------------------------------------------------------//	
//  167 		// HU Install
//  168 		MuStatus->SystemIns.Hu_Install[0] = (INT8U)tptr->BackUp.Hu_Install.Hu1_Bit;
//  169 		MuStatus->SystemIns.Hu_Install[1] = (INT8U)tptr->BackUp.Hu_Install.Hu2_Bit;
//  170 		MuStatus->SystemIns.Hu_Install[2] = (INT8U)tptr->BackUp.Hu_Install.Hu3_Bit;
//  171 		MuStatus->SystemIns.Hu_Install[3] = (INT8U)tptr->BackUp.Hu_Install.Hu4_Bit;
//  172 		MuStatus->SystemIns.Hu_Install[4] = (INT8U)tptr->BackUp.Hu_Install.Hu5_Bit;
//  173 		MuStatus->SystemIns.Hu_Install[5] = (INT8U)tptr->BackUp.Hu_Install.Hu6_Bit;
//  174 		MuStatus->SystemIns.Hu_Install[6] = (INT8U)tptr->BackUp.Hu_Install.Hu7_Bit;
//  175 		MuStatus->SystemIns.Hu_Install[7] = (INT8U)tptr->BackUp.Hu_Install.Hu8_Bit;
//  176 		
//  177 		// MU-RU Install
//  178 		for(i=0; i<MDTU_MAX; i++)
//  179 		{
//  180 			MuStatus->SystemIns.Mu_Ru_Install[i][0] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru1_Bit;
//  181 			MuStatus->SystemIns.Mu_Ru_Install[i][1] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru2_Bit;
//  182 			MuStatus->SystemIns.Mu_Ru_Install[i][2] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru3_Bit;
//  183 			MuStatus->SystemIns.Mu_Ru_Install[i][3] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru4_Bit;
//  184 			MuStatus->SystemIns.Mu_Ru_Install[i][4] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru5_Bit;
//  185 			MuStatus->SystemIns.Mu_Ru_Install[i][5] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru6_Bit;
//  186 			MuStatus->SystemIns.Mu_Ru_Install[i][6] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru7_Bit;
//  187 			MuStatus->SystemIns.Mu_Ru_Install[i][7] = (INT8U)tptr->BackUp.MuRu_Install[i].Ru8_Bit;
//  188 		}
//  189 				
//  190 		// System
//  191 		MuStatus->TempLimitH		= tptr->BackUp.TempLimitH;
//  192 		MuStatus->TempLimitL		= tptr->BackUp.TempLimitL;
//  193 
//  194 		MuStatus->FanTemp			= tptr->BackUp.FanTemp;
//  195 		MuStatus->FanMode			= tptr->BackUp.FanMode;
//  196 		MuStatus->FanOnOff			= tptr->BackUp.FanOnOff;
//  197 		MuStatus->TempCompOnOff		= tptr->BackUp.TempCompOnOff;
//  198 
//  199 		for(i=0; i<10; i++)
//  200 			MuStatus->SystemIns.RepeaterID[i]		= tptr->BackUp.RepeaterID[i];
//  201 		
//  202 		// MDTU
//  203 		for(i=0; i<MDTU_MAX; i++)
//  204 		{
//  205 			MuStatus->MdtuSts[i].PD_LimitL			= tptr->BackUp.MdtuSts[i].PD_LimitL;
//  206 			MuStatus->MdtuSts[i].LD_LimitL			= tptr->BackUp.MdtuSts[i].LD_LimitL;
//  207 			MuStatus->MdtuSts[i].OpticSum			= tptr->BackUp.MdtuSts[i].OpticSum;
//  208 
//  209 			MuStatus->MdtuSts[i].FaFilter_21G		= tptr->BackUp.MdtuSts[i].FaFilter_21G;
//  210 			MuStatus->MdtuSts[i].FaOnOff_21G.Data	= tptr->BackUp.MdtuSts[i].FaOnOff_21G.Data;
//  211 			MuStatus->MdtuSts[i].FaFilter_900M		= tptr->BackUp.MdtuSts[i].FaFilter_900M;
//  212 			MuStatus->MdtuSts[i].FaOnOff_900M.Data	= tptr->BackUp.MdtuSts[i].FaOnOff_900M.Data;
//  213 			MuStatus->MdtuSts[i].FaFilter_25G		= tptr->BackUp.MdtuSts[i].FaFilter_25G;
//  214 			MuStatus->MdtuSts[i].FaOnOff_25G.Data	= tptr->BackUp.MdtuSts[i].FaOnOff_25G.Data;
//  215 
//  216 			MuStatus->MdtuSts[i].PD_Offset			= tptr->BackUp.MdtuSts[i].PD_Offset;
//  217 			MuStatus->MdtuSts[i].LD_Offset			= tptr->BackUp.MdtuSts[i].LD_Offset;
//  218 		}
//  219 
//  220 		for(i=0; i<RFU_MAX; i++)
//  221 		{
//  222 			MuStatus->MrfuSts[i].DL_OutLimitH	= tptr->BackUp.MrfuSts[i].DL_OutLimitH;
//  223 			MuStatus->MrfuSts[i].DL_Attn		= tptr->BackUp.MrfuSts[i].DL_Attn;
//  224 
//  225 			MuStatus->MrfuSts[i].UL_OutLimitH	= tptr->BackUp.MrfuSts[i].UL_OutLimitH;
//  226 			MuStatus->MrfuSts[i].UL_Attn		= tptr->BackUp.MrfuSts[i].UL_Attn;
//  227 			MuStatus->MrfuSts[i].UL_ALC_High	= tptr->BackUp.MrfuSts[i].UL_ALC_High;
//  228 			MuStatus->MrfuSts[i].UL_Alc_OnOffH	= tptr->BackUp.MrfuSts[i].UL_Alc_OnOffH;
//  229 			MuStatus->MrfuSts[i].UL_Amp_OnOff	= tptr->BackUp.MrfuSts[i].UL_Amp_OnOff;
//  230 			
//  231 			MuStatus->MrfuSts[i].DL_SD_Limit	= tptr->BackUp.MrfuSts[i].DL_SD_Limit;
//  232 			MuStatus->MrfuSts[i].DL_SD_OnOff	= tptr->BackUp.MrfuSts[i].DL_SD_OnOff;
//  233 
//  234 			MuStatus->MrfuSts[i].UL_SD_Limit	= tptr->BackUp.MrfuSts[i].UL_SD_Limit;
//  235 			MuStatus->MrfuSts[i].UL_SD_OnOff	= tptr->BackUp.MrfuSts[i].UL_SD_OnOff;
//  236 		}
//  237 
//  238 		MuStatus->Tsync_Auto		= tptr->BackUp.Tsync_Auto;
//  239 		MuStatus->Tsync_Manual		= tptr->BackUp.Tsync_Manual;
//  240 		MuStatus->Tsync_OnOff_S		= tptr->BackUp.Tsync_OnOff_S;
//  241 		MuStatus->Tsync_OnOff_M		= tptr->BackUp.Tsync_OnOff_M;
//  242 		MuStatus->Tsync_Offset_S	= tptr->BackUp.Tsync_Offset_S;
//  243 		MuStatus->Tsync_Offset_M	= tptr->BackUp.Tsync_Offset_M;
//  244 		
//  245 		for(i=0; i<RFU_MAX; i++)
//  246 		{
//  247 			// CFR/TX 출력
//  248 			MuStatus->CfrSts[i].Cfr_Enable.Data	= tptr->BackUp.CfrSts[i].Cfr_Enable.Data;
//  249 			MuStatus->CfrSts[i].Cfr_OnOff.Data	= tptr->BackUp.CfrSts[i].Cfr_OnOff.Data;
//  250 
//  251 			MuStatus->CfrSts[i].Cfr_Select		= tptr->BackUp.CfrSts[i].Cfr_Select;
//  252 			MuStatus->CfrSts[i].Limit_OnOff		= tptr->BackUp.CfrSts[i].Limit_OnOff;
//  253 
//  254 			// Offset
//  255 			MuStatus->MrfuOffset[i].DL_Attn 	= tptr->BackUp.MrfuOffset[i].DL_Attn;
//  256 			MuStatus->MrfuOffset[i].UL_Attn 	= tptr->BackUp.MrfuOffset[i].UL_Attn;
//  257 
//  258 			MuStatus->MrfuOffset[i].DL_Pwr_Offset 	= tptr->BackUp.MrfuOffset[i].DL_Pwr_Offset;
//  259 			MuStatus->MrfuOffset[i].UL_Pwr_Offset 	= tptr->BackUp.MrfuOffset[i].UL_Pwr_Offset;
//  260 		}
//  261 	}
//  262 	OS_EXIT_CRITICAL();
//  263 */
//  264 }       
LoadBackupData:
        BX       LR               ;; return
//  265 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  266 void DefaultBackup(INT8U isRst)
//  267 {
//  268 /*
//  269 
//  270 	INT8U	i=0, j=0;
//  271 	INT32U	cpu_sr;
//  272 
//  273 
//  274 	OS_ENTER_CRITICAL();
//  275 	{
//  276 		EE_BACK1 *tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // Load 1st Area
//  277 
//  278 		// default set!!
//  279 //		tptr->BackUp.FwdAttn_4G = 30;
//  280 
//  281 		
//  282 
//  283 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
//  284 	}
//  285 	OS_EXIT_CRITICAL();
//  286 
//  287 	OS_ENTER_CRITICAL();
//  288 	{
//  289 		EE_TABLE *tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // Load 1st Area
//  290 
//  291 		for(j=0; j<12; j++)
//  292 		{
//  293 			tptr->AttnTable[i].limit = 0;
//  294 			tptr->AttnTable[i].nsize = AttnTBL_Size;
//  295 			
//  296 			for(i=0; i<AttnTBL_Size; i++)
//  297 				tptr->AttnTable[j].Data[i] = i*2;
//  298 
//  299 			if(j==6)	OSTimeDly(100);
//  300 		}
//  301 
//  302 		for(j=0; j<12; j++)
//  303 		{
//  304 			tptr->TempTable[i].limit = -10;
//  305 			tptr->TempTable[i].nsize = TempTBL_Size;
//  306 			
//  307 			for(i=0; i<TempTBL_Size; i++)
//  308 				tptr->TempTable[j].Data[i] = 0;
//  309 
//  310 			if(j==6)	OSTimeDly(100);
//  311 		}
//  312 
//  313 		WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
//  314 	}
//  315 	////////////////////////////////////////////////////////////////////////////////
//  316 	while(isRst);
//  317 */
//  318 
//  319 }
DefaultBackup:
        BX       LR               ;; return
//  320 
//  321 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  322 INT8U SetDnrCtrlData(__MU_CTRL *ptr)
//  323 {
SetDnrCtrlData:
        PUSH     {R4-R8,LR}
//  324 	INT8U	i = 0;
//  325 
//  326 	__MU_STS	*Sts = MuStatus;
        LDR.W    R1,??DataTable7_1
        LDR      R4,[R1, #+0]
//  327 
//  328 	//---------------------------------------------------------------------//
//  329 	// Hu Install
//  330 	if(ptr->CtrlFlag.Hu_Install.Hu1_Bit)
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+31
        BPL.N    ??SetDnrCtrlData_0
//  331 	{
//  332 		Sts->SystemIns.Hu_Install[0] = ptr->Hu_Install.Hu1_Bit;
        LDRB     R1,[R0, #+79]
        AND      R1,R1,#0x1
        STRB     R1,[R4, #+15]
//  333 	}
//  334 
//  335 	if(ptr->CtrlFlag.Hu_Install.Hu2_Bit)
??SetDnrCtrlData_0:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+30
        BPL.N    ??SetDnrCtrlData_1
//  336 	{
//  337 		Sts->SystemIns.Hu_Install[1] = ptr->Hu_Install.Hu2_Bit;
        LDRB     R1,[R0, #+79]
        UBFX     R1,R1,#+1,#+1
        STRB     R1,[R4, #+16]
//  338 	}
//  339 
//  340 	if(ptr->CtrlFlag.Hu_Install.Hu3_Bit)
??SetDnrCtrlData_1:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+29
        BPL.N    ??SetDnrCtrlData_2
//  341 	{
//  342 		Sts->SystemIns.Hu_Install[2] = ptr->Hu_Install.Hu3_Bit;
        LDRB     R1,[R0, #+79]
        UBFX     R1,R1,#+2,#+1
        STRB     R1,[R4, #+17]
//  343 	}
//  344 
//  345 	if(ptr->CtrlFlag.Hu_Install.Hu4_Bit)
??SetDnrCtrlData_2:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+28
        BPL.N    ??SetDnrCtrlData_3
//  346 	{
//  347 		Sts->SystemIns.Hu_Install[3] = ptr->Hu_Install.Hu4_Bit;
        LDRB     R1,[R0, #+79]
        UBFX     R1,R1,#+3,#+1
        STRB     R1,[R4, #+18]
//  348 	}
//  349 
//  350 	if(ptr->CtrlFlag.Hu_Install.Hu5_Bit)
??SetDnrCtrlData_3:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+27
        BPL.N    ??SetDnrCtrlData_4
//  351 	{
//  352 		Sts->SystemIns.Hu_Install[4] = ptr->Hu_Install.Hu5_Bit;
        LDRB     R1,[R0, #+79]
        UBFX     R1,R1,#+4,#+1
        STRB     R1,[R4, #+19]
//  353 	}
//  354 
//  355 	if(ptr->CtrlFlag.Hu_Install.Hu6_Bit)
??SetDnrCtrlData_4:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+26
        BPL.N    ??SetDnrCtrlData_5
//  356 	{
//  357 		Sts->SystemIns.Hu_Install[5] = ptr->Hu_Install.Hu6_Bit;
        LDRB     R1,[R0, #+79]
        UBFX     R1,R1,#+5,#+1
        STRB     R1,[R4, #+20]
//  358 	}
//  359 
//  360 	if(ptr->CtrlFlag.Hu_Install.Hu7_Bit)
??SetDnrCtrlData_5:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+25
        BPL.N    ??SetDnrCtrlData_6
//  361 	{
//  362 		Sts->SystemIns.Hu_Install[6] = ptr->Hu_Install.Hu7_Bit;
        LDRB     R1,[R0, #+79]
        UBFX     R1,R1,#+6,#+1
        STRB     R1,[R4, #+21]
//  363 	}
//  364 
//  365 	if(ptr->CtrlFlag.Hu_Install.Hu8_Bit)
??SetDnrCtrlData_6:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??SetDnrCtrlData_7
//  366 	{
//  367 		Sts->SystemIns.Hu_Install[7] = ptr->Hu_Install.Hu8_Bit;
        LDRB     R1,[R0, #+79]
        LSRS     R1,R1,#+7
        STRB     R1,[R4, #+22]
//  368 	}
//  369 
//  370 	//---------------------------------------------------------------------//
//  371 	// Mu-Ru Install
//  372 	for(i=0; i<MDTU_MAX; i++)
??SetDnrCtrlData_7:
        MOV      R1,R0
        MOV      R2,R4
        MOVS     R3,#+8
//  373 	{
//  374 		if(ptr->CtrlFlag.MuRu_Install[i].Ru1_Bit)
??SetDnrCtrlData_8:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+31
        BPL.N    ??SetDnrCtrlData_9
//  375 		{
//  376 			Sts->SystemIns.Mu_Ru_Install[i][0] = ptr->MuRu_Install[i].Ru1_Bit;
        LDRB     R5,[R1, #+80]
        AND      R5,R5,#0x1
        STRB     R5,[R2, #+535]
//  377 		}
//  378 		if(ptr->CtrlFlag.MuRu_Install[i].Ru2_Bit)
??SetDnrCtrlData_9:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+30
        BPL.N    ??SetDnrCtrlData_10
//  379 		{
//  380 			Sts->SystemIns.Mu_Ru_Install[i][1] = ptr->MuRu_Install[i].Ru2_Bit;
        LDRB     R5,[R1, #+80]
        UBFX     R5,R5,#+1,#+1
        ADDW     R6,R2,#+535
        STRB     R5,[R6, #+1]
//  381 		}
//  382 		if(ptr->CtrlFlag.MuRu_Install[i].Ru3_Bit)
??SetDnrCtrlData_10:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+29
        BPL.N    ??SetDnrCtrlData_11
//  383 		{
//  384 			Sts->SystemIns.Mu_Ru_Install[i][2] = ptr->MuRu_Install[i].Ru3_Bit;
        LDRB     R5,[R1, #+80]
        UBFX     R5,R5,#+2,#+1
        ADDW     R6,R2,#+535
        STRB     R5,[R6, #+2]
//  385 		}
//  386 		if(ptr->CtrlFlag.MuRu_Install[i].Ru4_Bit)
??SetDnrCtrlData_11:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+28
        BPL.N    ??SetDnrCtrlData_12
//  387 		{
//  388 			Sts->SystemIns.Mu_Ru_Install[i][3] = ptr->MuRu_Install[i].Ru4_Bit;
        LDRB     R5,[R1, #+80]
        UBFX     R5,R5,#+3,#+1
        ADDW     R6,R2,#+535
        STRB     R5,[R6, #+3]
//  389 		}
//  390 		if(ptr->CtrlFlag.MuRu_Install[i].Ru5_Bit)
??SetDnrCtrlData_12:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+27
        BPL.N    ??SetDnrCtrlData_13
//  391 		{
//  392 			Sts->SystemIns.Mu_Ru_Install[i][4] = ptr->MuRu_Install[i].Ru5_Bit;
        LDRB     R5,[R1, #+80]
        UBFX     R5,R5,#+4,#+1
        ADDW     R6,R2,#+535
        STRB     R5,[R6, #+4]
//  393 		}
//  394 		if(ptr->CtrlFlag.MuRu_Install[i].Ru6_Bit)
??SetDnrCtrlData_13:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+26
        BPL.N    ??SetDnrCtrlData_14
//  395 		{
//  396 			Sts->SystemIns.Mu_Ru_Install[i][5] = ptr->MuRu_Install[i].Ru6_Bit;
        LDRB     R5,[R1, #+80]
        UBFX     R5,R5,#+5,#+1
        ADDW     R6,R2,#+535
        STRB     R5,[R6, #+5]
//  397 		}
//  398 		if(ptr->CtrlFlag.MuRu_Install[i].Ru7_Bit)
??SetDnrCtrlData_14:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+25
        BPL.N    ??SetDnrCtrlData_15
//  399 		{
//  400 			Sts->SystemIns.Mu_Ru_Install[i][6] = ptr->MuRu_Install[i].Ru7_Bit;
        LDRB     R5,[R1, #+80]
        UBFX     R5,R5,#+6,#+1
        ADDW     R6,R2,#+535
        STRB     R5,[R6, #+6]
//  401 		}
//  402 		if(ptr->CtrlFlag.MuRu_Install[i].Ru8_Bit)
??SetDnrCtrlData_15:
        LDRB     R5,[R1, #+1]
        LSLS     R5,R5,#+24
        BPL.N    ??SetDnrCtrlData_16
//  403 		{
//  404 			Sts->SystemIns.Mu_Ru_Install[i][7] = ptr->MuRu_Install[i].Ru8_Bit;
        ADDW     R5,R2,#+535
        LDRB     R6,[R1, #+80]
        LSRS     R6,R6,#+7
        STRB     R6,[R5, #+7]
//  405 		}
//  406 	}
??SetDnrCtrlData_16:
        ADDS     R2,R2,#+8
        ADDS     R1,R1,#+1
        SUBS     R3,R3,#+1
        BNE.N    ??SetDnrCtrlData_8
//  407 
//  408 	//---------------------------------------------------------------------//
//  409 	// System
//  410 	if(ptr->CtrlFlag.System.TempLimitH)
        LDRB     R1,[R0, #+9]
        LSLS     R1,R1,#+31
        ITT      MI 
        LDRBMI   R1,[R0, #+88]
        STRBMI   R1,[R4, #+602]
//  411 	{
//  412 		Sts->TempLimitH		= ptr->TempLimitH;
//  413 	}
//  414 	if(ptr->CtrlFlag.System.TempLimitL)
        LDRB     R1,[R0, #+9]
        LSLS     R1,R1,#+30
        ITT      MI 
        LDRBMI   R1,[R0, #+89]
        STRBMI   R1,[R4, #+603]
//  415 	{
//  416 		Sts->TempLimitL		= ptr->TempLimitL;
//  417 	}
//  418 	if(ptr->CtrlFlag.System.FanTemp)
        LDRB     R1,[R0, #+9]
        LSLS     R1,R1,#+29
        ITT      MI 
        LDRBMI   R1,[R0, #+90]
        STRBMI   R1,[R4, #+604]
//  419 	{
//  420 		Sts->FanTemp			= ptr->FanTemp;
//  421 	}
//  422 	if(ptr->CtrlFlag.System.FanMode)
        LDRB     R1,[R0, #+9]
        LSLS     R1,R1,#+28
        ITT      MI 
        LDRBMI   R1,[R0, #+91]
        STRBMI   R1,[R4, #+605]
//  423 	{
//  424 		Sts->FanMode			= ptr->FanMode;
//  425 	}
//  426 	if(ptr->CtrlFlag.System.FanOnOff)
        LDRB     R1,[R0, #+9]
        LSLS     R1,R1,#+27
        ITT      MI 
        LDRBMI   R1,[R0, #+92]
        STRBMI   R1,[R4, #+606]
//  427 	{
//  428 		Sts->FanOnOff			= ptr->FanOnOff;
//  429 	}
//  430 	if(ptr->CtrlFlag.System.TempCompOnOff)
        LDRB     R1,[R0, #+9]
        LSLS     R1,R1,#+26
        ITT      MI 
        LDRBMI   R1,[R0, #+93]
        STRBMI   R1,[R4, #+607]
//  431 	{
//  432 		Sts->TempCompOnOff		= ptr->TempCompOnOff;
//  433 	}
//  434 	if(ptr->CtrlFlag.System.RepeaterID)
        LDRB     R1,[R0, #+9]
        LSLS     R1,R1,#+24
        BPL.N    ??SetDnrCtrlData_17
//  435 	{
//  436 		for(i=0; i<10; i++)
        MOV      R1,R4
        MOV      R2,R0
        MOVS     R3,#+10
//  437 			Sts->SystemIns.RepeaterID[i]		= ptr->RepeaterID[i];
??SetDnrCtrlData_18:
        LDRB     R5,[R2, #+94]
        STRB     R5,[R1, #+4]
        ADDS     R2,R2,#+1
        ADDS     R1,R1,#+1
        SUBS     R3,R3,#+1
        BNE.N    ??SetDnrCtrlData_18
//  438 	}
//  439 
//  440 	//---------------------------------------------------------------------//
//  441 	// MDTU
//  442 	for(i=0; i<MDTU_MAX; i++)
??SetDnrCtrlData_17:
        MOV      R1,R0
        MOV      R2,R0
        MOV      R3,R4
        MOVS     R5,#+8
//  443 	{
//  444 		if(ptr->CtrlFlag.Mdtu[i].PD_LimitL)
??SetDnrCtrlData_19:
        LDRB     R6,[R1, #+10]
        LSLS     R6,R6,#+31
        ITT      MI 
        LDRBMI   R6,[R2, #+104]
        STRBMI   R6,[R3, #+612]
//  445 		{
//  446 			Sts->MdtuSts[i].PD_LimitL			= ptr->MdtuSts[i].PD_LimitL;
//  447 		}
//  448 		if(ptr->CtrlFlag.Mdtu[i].LD_LimitL)
        LDRB     R6,[R1, #+10]
        LSLS     R6,R6,#+30
        BPL.N    ??SetDnrCtrlData_20
//  449 		{
//  450 			Sts->MdtuSts[i].LD_LimitL			= ptr->MdtuSts[i].LD_LimitL;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+1]
        STRB     R7,[R6, #+1]
//  451 		}
//  452 		if(ptr->CtrlFlag.Mdtu[i].OpticSum)
??SetDnrCtrlData_20:
        LDRB     R6,[R1, #+10]
        LSLS     R6,R6,#+29
        BPL.N    ??SetDnrCtrlData_21
//  453 		{
//  454 			Sts->MdtuSts[i].OpticSum			= ptr->MdtuSts[i].OpticSum;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+2]
        STRB     R7,[R6, #+3]
//  455 		}
//  456 
//  457 		if(ptr->CtrlFlag.Mdtu[i].FaFilter_21G)
??SetDnrCtrlData_21:
        LDRB     R6,[R1, #+11]
        LSLS     R6,R6,#+31
        BPL.N    ??SetDnrCtrlData_22
//  458 		{
//  459 			Sts->MdtuSts[i].FaFilter_21G		= ptr->MdtuSts[i].FaFilter_21G;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+3]
        STRB     R7,[R6, #+4]
//  460 		}
//  461 		if(ptr->CtrlFlag.Mdtu[i].Fa1_21G)
??SetDnrCtrlData_22:
        LDRB     R6,[R1, #+11]
        LSLS     R6,R6,#+30
        BPL.N    ??SetDnrCtrlData_23
//  462 		{
//  463 			Sts->MdtuSts[i].FaOnOff_21G.Fa1_Bit = ptr->MdtuSts[i].FaOnOff_21G.Fa1_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+4]
        LDRB     R12,[R6, #+5]
        BFI      R12,R7,#+0,#+1
        STRB     R12,[R6, #+5]
//  464 		}
//  465 		if(ptr->CtrlFlag.Mdtu[i].Fa2_21G)
??SetDnrCtrlData_23:
        LDRB     R6,[R1, #+11]
        LSLS     R6,R6,#+29
        BPL.N    ??SetDnrCtrlData_24
//  466 		{
//  467 			Sts->MdtuSts[i].FaOnOff_21G.Fa2_Bit = ptr->MdtuSts[i].FaOnOff_21G.Fa2_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+4]
        LSRS     R7,R7,#+1
        LDRB     R12,[R6, #+5]
        BFI      R12,R7,#+1,#+1
        STRB     R12,[R6, #+5]
//  468 		}
//  469 		if(ptr->CtrlFlag.Mdtu[i].Fa3_21G)
??SetDnrCtrlData_24:
        LDRB     R6,[R1, #+11]
        LSLS     R6,R6,#+28
        BPL.N    ??SetDnrCtrlData_25
//  470 		{
//  471 			Sts->MdtuSts[i].FaOnOff_21G.Fa3_Bit = ptr->MdtuSts[i].FaOnOff_21G.Fa3_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+4]
        LSRS     R7,R7,#+2
        LDRB     R12,[R6, #+5]
        BFI      R12,R7,#+2,#+1
        STRB     R12,[R6, #+5]
//  472 		}
//  473 		if(ptr->CtrlFlag.Mdtu[i].Fa4_21G)
??SetDnrCtrlData_25:
        LDRB     R6,[R1, #+11]
        LSLS     R6,R6,#+27
        BPL.N    ??SetDnrCtrlData_26
//  474 		{
//  475 			Sts->MdtuSts[i].FaOnOff_21G.Fa4_Bit = ptr->MdtuSts[i].FaOnOff_21G.Fa4_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+4]
        LSRS     R7,R7,#+3
        LDRB     R12,[R6, #+5]
        BFI      R12,R7,#+3,#+1
        STRB     R12,[R6, #+5]
//  476 		}
//  477 
//  478 		if(ptr->CtrlFlag.Mdtu[i].FaFilter_900M)
??SetDnrCtrlData_26:
        LDRB     R6,[R1, #+12]
        LSLS     R6,R6,#+31
        BPL.N    ??SetDnrCtrlData_27
//  479 		{
//  480 			Sts->MdtuSts[i].FaFilter_900M		= ptr->MdtuSts[i].FaFilter_900M;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+5]
        STRB     R7,[R6, #+6]
//  481 		}
//  482 		if(ptr->CtrlFlag.Mdtu[i].Fa1_900M)
??SetDnrCtrlData_27:
        LDRB     R6,[R1, #+12]
        LSLS     R6,R6,#+30
        BPL.N    ??SetDnrCtrlData_28
//  483 		{
//  484 			Sts->MdtuSts[i].FaOnOff_900M.Fa1_Bit = ptr->MdtuSts[i].FaOnOff_900M.Fa1_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+6]
        LDRB     R12,[R6, #+7]
        BFI      R12,R7,#+0,#+1
        STRB     R12,[R6, #+7]
//  485 		}
//  486 		if(ptr->CtrlFlag.Mdtu[i].Fa2_900M)
??SetDnrCtrlData_28:
        LDRB     R6,[R1, #+12]
        LSLS     R6,R6,#+29
        BPL.N    ??SetDnrCtrlData_29
//  487 		{
//  488 			Sts->MdtuSts[i].FaOnOff_900M.Fa2_Bit = ptr->MdtuSts[i].FaOnOff_900M.Fa2_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+6]
        LSRS     R7,R7,#+1
        LDRB     R12,[R6, #+7]
        BFI      R12,R7,#+1,#+1
        STRB     R12,[R6, #+7]
//  489 		}
//  490 		if(ptr->CtrlFlag.Mdtu[i].Fa3_900M)
??SetDnrCtrlData_29:
        LDRB     R6,[R1, #+12]
        LSLS     R6,R6,#+28
        BPL.N    ??SetDnrCtrlData_30
//  491 		{
//  492 			Sts->MdtuSts[i].FaOnOff_900M.Fa3_Bit = ptr->MdtuSts[i].FaOnOff_900M.Fa3_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+6]
        LSRS     R7,R7,#+2
        LDRB     R12,[R6, #+7]
        BFI      R12,R7,#+2,#+1
        STRB     R12,[R6, #+7]
//  493 		}
//  494 
//  495 		if(ptr->CtrlFlag.Mdtu[i].FaFilter_25G)
??SetDnrCtrlData_30:
        LDRB     R6,[R1, #+13]
        LSLS     R6,R6,#+31
        BPL.N    ??SetDnrCtrlData_31
//  496 		{
//  497 			Sts->MdtuSts[i].FaFilter_25G		= ptr->MdtuSts[i].FaFilter_25G;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+7]
        STRB     R7,[R6, #+8]
//  498 		}
//  499 		if(ptr->CtrlFlag.Mdtu[i].Fa1_25G)
??SetDnrCtrlData_31:
        LDRB     R6,[R1, #+13]
        LSLS     R6,R6,#+30
        BPL.N    ??SetDnrCtrlData_32
//  500 		{
//  501 			Sts->MdtuSts[i].FaOnOff_25G.Fa1_Bit = ptr->MdtuSts[i].FaOnOff_25G.Fa1_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+8]
        LDRB     R12,[R6, #+9]
        BFI      R12,R7,#+0,#+1
        STRB     R12,[R6, #+9]
//  502 		}
//  503 		if(ptr->CtrlFlag.Mdtu[i].Fa2_25G)
??SetDnrCtrlData_32:
        LDRB     R6,[R1, #+13]
        LSLS     R6,R6,#+29
        BPL.N    ??SetDnrCtrlData_33
//  504 		{
//  505 			Sts->MdtuSts[i].FaOnOff_25G.Fa2_Bit = ptr->MdtuSts[i].FaOnOff_25G.Fa2_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+8]
        LSRS     R7,R7,#+1
        LDRB     R12,[R6, #+9]
        BFI      R12,R7,#+1,#+1
        STRB     R12,[R6, #+9]
//  506 		}
//  507 		if(ptr->CtrlFlag.Mdtu[i].Fa3_25G)
??SetDnrCtrlData_33:
        LDRB     R6,[R1, #+13]
        LSLS     R6,R6,#+28
        BPL.N    ??SetDnrCtrlData_34
//  508 		{
//  509 			Sts->MdtuSts[i].FaOnOff_25G.Fa3_Bit = ptr->MdtuSts[i].FaOnOff_25G.Fa3_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+8]
        LSRS     R7,R7,#+2
        LDRB     R12,[R6, #+9]
        BFI      R12,R7,#+2,#+1
        STRB     R12,[R6, #+9]
//  510 		}
//  511 		if(ptr->CtrlFlag.Mdtu[i].Fa4_25G)
??SetDnrCtrlData_34:
        LDRB     R6,[R1, #+13]
        LSLS     R6,R6,#+27
        BPL.N    ??SetDnrCtrlData_35
//  512 		{
//  513 			Sts->MdtuSts[i].FaOnOff_25G.Fa4_Bit = ptr->MdtuSts[i].FaOnOff_25G.Fa4_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+8]
        LSRS     R7,R7,#+3
        LDRB     R12,[R6, #+9]
        BFI      R12,R7,#+3,#+1
        STRB     R12,[R6, #+9]
//  514 		}
//  515 		if(ptr->CtrlFlag.Mdtu[i].Fa5_25G)
??SetDnrCtrlData_35:
        LDRB     R6,[R1, #+13]
        LSLS     R6,R6,#+26
        BPL.N    ??SetDnrCtrlData_36
//  516 		{
//  517 			Sts->MdtuSts[i].FaOnOff_25G.Fa5_Bit = ptr->MdtuSts[i].FaOnOff_25G.Fa5_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+8]
        LSRS     R7,R7,#+4
        LDRB     R12,[R6, #+9]
        BFI      R12,R7,#+4,#+1
        STRB     R12,[R6, #+9]
//  518 		}
//  519 		if(ptr->CtrlFlag.Mdtu[i].Fa6_25G)
??SetDnrCtrlData_36:
        LDRB     R6,[R1, #+13]
        LSLS     R6,R6,#+25
        BPL.N    ??SetDnrCtrlData_37
//  520 		{
//  521 			Sts->MdtuSts[i].FaOnOff_25G.Fa6_Bit = ptr->MdtuSts[i].FaOnOff_25G.Fa6_Bit;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+8]
        LSRS     R7,R7,#+5
        LDRB     R12,[R6, #+9]
        BFI      R12,R7,#+5,#+1
        STRB     R12,[R6, #+9]
//  522 		}
//  523 		
//  524 		if(ptr->CtrlFlag.Mdtu[i].PD_Offset)
??SetDnrCtrlData_37:
        LDRB     R6,[R1, #+10]
        LSLS     R6,R6,#+28
        BPL.N    ??SetDnrCtrlData_38
//  525 		{	
//  526 			Sts->MdtuSts[i].PD_Offset			= ptr->MdtuSts[i].PD_Offset;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+9]
        STRB     R7,[R6, #+10]
//  527 		}
//  528 		if(ptr->CtrlFlag.Mdtu[i].LD_Offset)
??SetDnrCtrlData_38:
        LDRB     R6,[R1, #+10]
        LSLS     R6,R6,#+27
        BPL.N    ??SetDnrCtrlData_39
//  529 		{
//  530 			Sts->MdtuSts[i].LD_Offset			= ptr->MdtuSts[i].LD_Offset;
        ADDW     R6,R3,#+612
        ADD      R7,R2,#+104
        LDRB     R7,[R7, #+10]
        STRB     R7,[R6, #+11]
//  531 		}
//  532 	}
??SetDnrCtrlData_39:
        ADDS     R3,R3,#+16
        ADDW     R2,R2,#+11
        ADDS     R1,R1,#+4
        SUBS     R5,R5,#+1
        BNE.W    ??SetDnrCtrlData_19
//  533 
//  534 	//---------------------------------------------------------------------//
//  535 	// MRUF
//  536 	for(i=0; i<RFU_MAX; i++)
        MOV      R1,R0
        MOV      R2,R0
        MOV      R3,R4
        MOVS     R5,#+6
//  537 	{
//  538 		if(ptr->CtrlFlag.Mrfu[i].DL_OutLimitH)
??SetDnrCtrlData_40:
        LDRB     R6,[R1, #+42]
        LSLS     R6,R6,#+31
        ITT      MI 
        LDRBMI   R6,[R2, #+192]
        STRBMI   R6,[R3, #+740]
//  539 		{
//  540 			Sts->MrfuSts[i].DL_OutLimitH	= ptr->MrfuSts[i].DL_OutLimitH;
//  541 		}
//  542 		if(ptr->CtrlFlag.Mrfu[i].DL_Attn)
        LDRB     R6,[R1, #+42]
        LSLS     R6,R6,#+30
        BPL.N    ??SetDnrCtrlData_41
//  543 		{
//  544 			Sts->MrfuSts[i].DL_Attn		= ptr->MrfuSts[i].DL_Attn;
        ADDW     R6,R3,#+740
        ADD      R7,R2,#+192
        LDRB     R7,[R7, #+1]
        STRB     R7,[R6, #+1]
//  545 		}
//  546 		if(ptr->CtrlFlag.Mrfu[i].UL_OutLimitH)
??SetDnrCtrlData_41:
        LDRB     R6,[R1, #+42]
        LSLS     R6,R6,#+29
        BPL.N    ??SetDnrCtrlData_42
//  547 		{
//  548 			Sts->MrfuSts[i].UL_OutLimitH	= ptr->MrfuSts[i].UL_OutLimitH;
        ADDW     R6,R3,#+740
        ADD      R7,R2,#+192
        LDRB     R7,[R7, #+2]
        STRB     R7,[R6, #+4]
//  549 		}
//  550 		if(ptr->CtrlFlag.Mrfu[i].UL_Attn)
??SetDnrCtrlData_42:
        LDRB     R6,[R1, #+42]
        LSLS     R6,R6,#+28
        BPL.N    ??SetDnrCtrlData_43
//  551 		{
//  552 			Sts->MrfuSts[i].UL_Attn		= ptr->MrfuSts[i].UL_Attn;
        ADDW     R6,R3,#+740
        ADD      R7,R2,#+192
        LDRB     R7,[R7, #+3]
        STRB     R7,[R6, #+5]
//  553 		}
//  554 		if(ptr->CtrlFlag.Mrfu[i].UL_ALC_High)
??SetDnrCtrlData_43:
        LDRB     R6,[R1, #+42]
        LSLS     R6,R6,#+27
        BPL.N    ??SetDnrCtrlData_44
//  555 		{
//  556 			Sts->MrfuSts[i].UL_ALC_High	= ptr->MrfuSts[i].UL_ALC_High;
        ADDW     R6,R3,#+740
        ADD      R7,R2,#+192
        LDRB     R7,[R7, #+4]
        STRB     R7,[R6, #+6]
//  557 		}
//  558 		if(ptr->CtrlFlag.Mrfu[i].UL_Alc_OnOffH)
??SetDnrCtrlData_44:
        LDRB     R6,[R1, #+42]
        LSLS     R6,R6,#+26
        BPL.N    ??SetDnrCtrlData_45
//  559 		{
//  560 			Sts->MrfuSts[i].UL_Alc_OnOffH	= ptr->MrfuSts[i].UL_Alc_OnOffH;
        ADDW     R6,R3,#+740
        ADD      R7,R2,#+192
        LDRB     R7,[R7, #+5]
        STRB     R7,[R6, #+7]
//  561 		}
//  562 		if(ptr->CtrlFlag.Mrfu[i].UL_Amp_OnOff)
??SetDnrCtrlData_45:
        LDRB     R6,[R1, #+42]
        LSLS     R6,R6,#+25
        BPL.N    ??SetDnrCtrlData_46
//  563 		{
//  564 			Sts->MrfuSts[i].UL_Amp_OnOff	= ptr->MrfuSts[i].UL_Amp_OnOff;
        ADDW     R6,R3,#+740
        ADD      R7,R2,#+192
        LDRB     R7,[R7, #+6]
        STRB     R7,[R6, #+8]
//  565 		}
//  566 		
//  567 		if(ptr->CtrlFlag.Mrfu[i].DL_SD_Limit)
??SetDnrCtrlData_46:
        ADDW     R6,R1,#+42
        LDRB     R7,[R6, #+1]
        LSLS     R7,R7,#+31
        BPL.N    ??SetDnrCtrlData_47
//  568 		{
//  569 			Sts->MrfuSts[i].DL_SD_Limit	= ptr->MrfuSts[i].DL_SD_Limit;
        ADDW     R7,R3,#+740
        ADD      R12,R2,#+192
        LDRB     R12,[R12, #+7]
        STRB     R12,[R7, #+9]
//  570 		}
//  571 		if(ptr->CtrlFlag.Mrfu[i].DL_SD_OnOff)
??SetDnrCtrlData_47:
        LDRB     R7,[R6, #+1]
        LSLS     R7,R7,#+30
        BPL.N    ??SetDnrCtrlData_48
//  572 		{
//  573 			Sts->MrfuSts[i].DL_SD_OnOff	= ptr->MrfuSts[i].DL_SD_OnOff;
        ADDW     R7,R3,#+740
        ADD      R12,R2,#+192
        LDRB     R12,[R12, #+8]
        STRB     R12,[R7, #+10]
//  574 		}
//  575 		if(ptr->CtrlFlag.Mrfu[i].UL_SD_Limit)
??SetDnrCtrlData_48:
        LDRB     R7,[R6, #+1]
        LSLS     R7,R7,#+29
        BPL.N    ??SetDnrCtrlData_49
//  576 		{
//  577 			Sts->MrfuSts[i].UL_SD_Limit	= ptr->MrfuSts[i].UL_SD_Limit;
        ADDW     R7,R3,#+740
        ADD      R12,R2,#+192
        LDRB     R12,[R12, #+9]
        STRB     R12,[R7, #+11]
//  578 		}
//  579 		if(ptr->CtrlFlag.Mrfu[i].UL_SD_OnOff)
??SetDnrCtrlData_49:
        LDRB     R6,[R6, #+1]
        LSLS     R6,R6,#+28
        BPL.N    ??SetDnrCtrlData_50
//  580 		{
//  581 			Sts->MrfuSts[i].UL_SD_OnOff	= ptr->MrfuSts[i].UL_SD_OnOff;
        ADDW     R6,R3,#+740
        ADD      R7,R2,#+192
        LDRB     R7,[R7, #+10]
        STRB     R7,[R6, #+12]
//  582 		}
//  583 	}
??SetDnrCtrlData_50:
        ADDW     R3,R3,#+17
        ADDW     R2,R2,#+11
        ADDS     R1,R1,#+2
        SUBS     R5,R5,#+1
        BNE.N    ??SetDnrCtrlData_40
//  584 
//  585 	if(ptr->CtrlFlag.Mrfu25G.Tsync_Auto)
        LDRB     R1,[R0, #+54]
        LSLS     R1,R1,#+31
        ITT      MI 
        LDRBMI   R1,[R0, #+258]
        STRBMI   R1,[R4, #+838]
//  586 	{
//  587 		Sts->Tsync_Auto		= ptr->Tsync_Auto;
//  588 	}
//  589 	if(ptr->CtrlFlag.Mrfu25G.Tsync_Manual)
        LDRB     R1,[R0, #+54]
        LSLS     R1,R1,#+30
        ITT      MI 
        LDRBMI   R1,[R0, #+259]
        STRBMI   R1,[R4, #+839]
//  590 	{
//  591 		Sts->Tsync_Manual		= ptr->Tsync_Manual;
//  592 	}
//  593 	if(ptr->CtrlFlag.Mrfu25G.Tsync_OnOff_S)
        LDRB     R1,[R0, #+54]
        LSLS     R1,R1,#+29
        ITT      MI 
        LDRBMI   R1,[R0, #+260]
        STRBMI   R1,[R4, #+840]
//  594 	{
//  595 		Sts->Tsync_OnOff_S		= ptr->Tsync_OnOff_S;
//  596 	}
//  597 	if(ptr->CtrlFlag.Mrfu25G.Tsync_OnOff_M)
        LDRB     R1,[R0, #+54]
        LSLS     R1,R1,#+28
        ITT      MI 
        LDRBMI   R1,[R0, #+261]
        STRBMI   R1,[R4, #+841]
//  598 	{
//  599 		Sts->Tsync_OnOff_M		= ptr->Tsync_OnOff_M;
//  600 	}
//  601 	if(ptr->CtrlFlag.Mrfu25G.Tsync_Offset_S)
        LDRB     R1,[R0, #+54]
        LSLS     R1,R1,#+27
        ITT      MI 
        LDRBMI   R1,[R0, #+262]
        STRBMI   R1,[R4, #+842]
//  602 	{
//  603 		Sts->Tsync_Offset_S	= ptr->Tsync_Offset_S;
//  604 	}
//  605 	if(ptr->CtrlFlag.Mrfu25G.Tsync_Offset_M)
        LDRB     R1,[R0, #+54]
        LSLS     R1,R1,#+26
        ITT      MI 
        LDRBMI   R1,[R0, #+263]
        STRBMI   R1,[R4, #+843]
//  606 	{
//  607 		Sts->Tsync_Offset_M	= ptr->Tsync_Offset_M;
//  608 	}
//  609 
//  610 	//---------------------------------------------------------------------//
//  611 	for(i=0; i<RFU_MAX; i++)
        MOV      R1,R0
        MOV      R2,R0
        MOV      R3,R0
        MOV      R5,R4
        MOVS     R6,#+6
//  612 	{
//  613 		// CFR/TX 출력
//  614 		if(ptr->CtrlFlag.Crf[i].Fa1_En)
??SetDnrCtrlData_51:
        LDRB     R7,[R1, #+55]
        LSLS     R7,R7,#+31
        BPL.N    ??SetDnrCtrlData_52
//  615 		{
//  616 			Sts->CfrSts[i].Cfr_Enable.Fa1_Bit = ptr->CfrSts[i].Cfr_Enable.Fa1_Bit;
        LDRB     R7,[R2, #+264]
        LDRB     R12,[R4, #+844]
        BFI      R12,R7,#+0,#+1
        STRB     R12,[R4, #+844]
//  617 		}
//  618 		if(ptr->CtrlFlag.Crf[i].Fa2_En)
??SetDnrCtrlData_52:
        LDRB     R7,[R1, #+55]
        LSLS     R7,R7,#+30
        BPL.N    ??SetDnrCtrlData_53
//  619 		{
//  620 			Sts->CfrSts[i].Cfr_Enable.Fa2_Bit = ptr->CfrSts[i].Cfr_Enable.Fa2_Bit;
        LDRB     R7,[R2, #+264]
        LSRS     R7,R7,#+1
        LDRB     R12,[R4, #+844]
        BFI      R12,R7,#+1,#+1
        STRB     R12,[R4, #+844]
//  621 		}
//  622 		if(ptr->CtrlFlag.Crf[i].Fa3_En)
??SetDnrCtrlData_53:
        LDRB     R7,[R1, #+55]
        LSLS     R7,R7,#+29
        BPL.N    ??SetDnrCtrlData_54
//  623 		{
//  624 			Sts->CfrSts[i].Cfr_Enable.Fa3_Bit = ptr->CfrSts[i].Cfr_Enable.Fa3_Bit;
        LDRB     R7,[R2, #+264]
        LSRS     R7,R7,#+2
        LDRB     R12,[R4, #+844]
        BFI      R12,R7,#+2,#+1
        STRB     R12,[R4, #+844]
//  625 		}
//  626 		if(ptr->CtrlFlag.Crf[i].Fa4_En)
??SetDnrCtrlData_54:
        LDRB     R7,[R1, #+55]
        LSLS     R7,R7,#+28
        BPL.N    ??SetDnrCtrlData_55
//  627 		{
//  628 			Sts->CfrSts[i].Cfr_Enable.Fa4_Bit = ptr->CfrSts[i].Cfr_Enable.Fa4_Bit;
        LDRB     R7,[R2, #+264]
        LSRS     R7,R7,#+3
        LDRB     R12,[R4, #+844]
        BFI      R12,R7,#+3,#+1
        STRB     R12,[R4, #+844]
//  629 		}
//  630 		if(ptr->CtrlFlag.Crf[i].Fa5_En)
??SetDnrCtrlData_55:
        LDRB     R7,[R1, #+55]
        LSLS     R7,R7,#+27
        BPL.N    ??SetDnrCtrlData_56
//  631 		{
//  632 			Sts->CfrSts[i].Cfr_Enable.Fa5_Bit = ptr->CfrSts[i].Cfr_Enable.Fa5_Bit;
        LDRB     R7,[R2, #+264]
        LSRS     R7,R7,#+4
        LDRB     R12,[R4, #+844]
        BFI      R12,R7,#+4,#+1
        STRB     R12,[R4, #+844]
//  633 		}
//  634 		if(ptr->CtrlFlag.Crf[i].Fa6_En)
??SetDnrCtrlData_56:
        LDRB     R7,[R1, #+55]
        LSLS     R7,R7,#+26
        BPL.N    ??SetDnrCtrlData_57
//  635 		{
//  636 			Sts->CfrSts[i].Cfr_Enable.Fa6_Bit = ptr->CfrSts[i].Cfr_Enable.Fa6_Bit;
        LDRB     R7,[R2, #+264]
        LSRS     R7,R7,#+5
        LDRB     R12,[R4, #+844]
        BFI      R12,R7,#+5,#+1
        STRB     R12,[R4, #+844]
//  637 		}
//  638 
//  639 		if(ptr->CtrlFlag.Crf[i].Fa1_OnOff)
??SetDnrCtrlData_57:
        ADDW     R7,R1,#+55
        LDRB     R12,[R7, #+1]
        LSLS     R12,R12,#+31
        BPL.N    ??SetDnrCtrlData_58
//  640 		{
//  641 			Sts->CfrSts[i].Cfr_OnOff.Fa1_Bit = ptr->CfrSts[i].Cfr_OnOff.Fa1_Bit;
        ADDW     R12,R4,#+844
        ADDW     LR,R2,#+264
        LDRB     LR,[LR, #+1]
        LDRB     R8,[R12, #+1]
        BFI      R8,LR,#+0,#+1
        STRB     R8,[R12, #+1]
//  642 		}
//  643 		if(ptr->CtrlFlag.Crf[i].Fa2_OnOff)
??SetDnrCtrlData_58:
        LDRB     R12,[R7, #+1]
        LSLS     R12,R12,#+30
        BPL.N    ??SetDnrCtrlData_59
//  644 		{
//  645 			Sts->CfrSts[i].Cfr_OnOff.Fa2_Bit = ptr->CfrSts[i].Cfr_OnOff.Fa2_Bit;
        ADDW     R12,R4,#+844
        ADDW     LR,R2,#+264
        LDRB     LR,[LR, #+1]
        LSR      LR,LR,#+1
        LDRB     R8,[R12, #+1]
        BFI      R8,LR,#+1,#+1
        STRB     R8,[R12, #+1]
//  646 		}
//  647 		if(ptr->CtrlFlag.Crf[i].Fa3_OnOff)
??SetDnrCtrlData_59:
        LDRB     R12,[R7, #+1]
        LSLS     R12,R12,#+29
        BPL.N    ??SetDnrCtrlData_60
//  648 		{
//  649 			Sts->CfrSts[i].Cfr_OnOff.Fa3_Bit = ptr->CfrSts[i].Cfr_OnOff.Fa3_Bit;
        ADDW     R12,R4,#+844
        ADDW     LR,R2,#+264
        LDRB     LR,[LR, #+1]
        LSR      LR,LR,#+2
        LDRB     R8,[R12, #+1]
        BFI      R8,LR,#+2,#+1
        STRB     R8,[R12, #+1]
//  650 		}
//  651 		if(ptr->CtrlFlag.Crf[i].Fa4_OnOff)
??SetDnrCtrlData_60:
        LDRB     R12,[R7, #+1]
        LSLS     R12,R12,#+28
        BPL.N    ??SetDnrCtrlData_61
//  652 		{
//  653 			Sts->CfrSts[i].Cfr_OnOff.Fa4_Bit = ptr->CfrSts[i].Cfr_OnOff.Fa4_Bit;
        ADDW     R12,R4,#+844
        ADDW     LR,R2,#+264
        LDRB     LR,[LR, #+1]
        LSR      LR,LR,#+3
        LDRB     R8,[R12, #+1]
        BFI      R8,LR,#+3,#+1
        STRB     R8,[R12, #+1]
//  654 		}
//  655 		if(ptr->CtrlFlag.Crf[i].Fa5_OnOff)
??SetDnrCtrlData_61:
        LDRB     R12,[R7, #+1]
        LSLS     R12,R12,#+27
        BPL.N    ??SetDnrCtrlData_62
//  656 		{
//  657 			Sts->CfrSts[i].Cfr_OnOff.Fa5_Bit = ptr->CfrSts[i].Cfr_OnOff.Fa5_Bit;
        ADDW     R12,R4,#+844
        ADDW     LR,R2,#+264
        LDRB     LR,[LR, #+1]
        LSR      LR,LR,#+4
        LDRB     R8,[R12, #+1]
        BFI      R8,LR,#+4,#+1
        STRB     R8,[R12, #+1]
//  658 		}
//  659 		if(ptr->CtrlFlag.Crf[i].Fa6_OnOff)
??SetDnrCtrlData_62:
        LDRB     R12,[R7, #+1]
        LSLS     R12,R12,#+26
        BPL.N    ??SetDnrCtrlData_63
//  660 		{
//  661 			Sts->CfrSts[i].Cfr_OnOff.Fa6_Bit = ptr->CfrSts[i].Cfr_OnOff.Fa6_Bit;
        ADDW     R12,R4,#+844
        ADDW     LR,R2,#+264
        LDRB     LR,[LR, #+1]
        LSR      LR,LR,#+5
        LDRB     R8,[R12, #+1]
        BFI      R8,LR,#+5,#+1
        STRB     R8,[R12, #+1]
//  662 		}
//  663 		
//  664 		if(ptr->CtrlFlag.Crf[i].Cfr_Select)
??SetDnrCtrlData_63:
        LDRB     R12,[R7, #+2]
        LSLS     R12,R12,#+31
        BPL.N    ??SetDnrCtrlData_64
//  665 		{
//  666 			Sts->CfrSts[i].Cfr_Select		= ptr->CfrSts[i].Cfr_Select;
        ADDW     R12,R4,#+844
        ADDW     LR,R2,#+264
        LDRB     LR,[LR, #+2]
        STRB     LR,[R12, #+2]
//  667 		}
//  668 		if(ptr->CtrlFlag.Crf[i].Limit_OnOff)
??SetDnrCtrlData_64:
        LDRB     R7,[R7, #+2]
        LSLS     R7,R7,#+30
        BPL.N    ??SetDnrCtrlData_65
//  669 		{
//  670 			Sts->CfrSts[i].Limit_OnOff		= ptr->CfrSts[i].Limit_OnOff;
        ADDW     R7,R4,#+844
        ADDW     R12,R2,#+264
        LDRB     R12,[R12, #+3]
        STRB     R12,[R7, #+3]
//  671 		}
//  672 
//  673 		// Offset
//  674 		if(ptr->CtrlFlag.Offset[i].DL_Attn)
??SetDnrCtrlData_65:
        LDRB     R7,[R0, #+73]
        LSLS     R7,R7,#+31
        ITT      MI 
        LDRBMI   R7,[R3, #+288]
        STRBMI   R7,[R5, #+892]
//  675 		{
//  676 			Sts->MrfuOffset[i].DL_Attn 	= ptr->MrfuOffset[i].DL_Attn;
//  677 		}
//  678 		if(ptr->CtrlFlag.Offset[i].UL_Attn)
        LDRB     R7,[R0, #+73]
        LSLS     R7,R7,#+30
        BPL.N    ??SetDnrCtrlData_66
//  679 		{
//  680 			Sts->MrfuOffset[i].UL_Attn 	= ptr->MrfuOffset[i].UL_Attn;
        ADDW     R7,R5,#+892
        ADDW     R12,R3,#+288
        LDRB     R12,[R12, #+1]
        STRB     R12,[R7, #+1]
//  681 		}
//  682 		if(ptr->CtrlFlag.Offset[i].DL_Pwr_Offset)
??SetDnrCtrlData_66:
        LDRB     R7,[R0, #+73]
        LSLS     R7,R7,#+29
        BPL.N    ??SetDnrCtrlData_67
//  683 		{
//  684 			Sts->MrfuOffset[i].DL_Pwr_Offset 	= ptr->MrfuOffset[i].DL_Pwr_Offset;
        ADDW     R7,R5,#+892
        ADDW     R12,R3,#+288
        LDRH     R12,[R12, #+2]
        STRH     R12,[R7, #+2]
//  685 		}
//  686 		if(ptr->CtrlFlag.Offset[i].UL_Pwr_Offset)
??SetDnrCtrlData_67:
        LDRB     R7,[R0, #+73]
        LSLS     R7,R7,#+28
        BPL.N    ??SetDnrCtrlData_68
//  687 		{
//  688 			Sts->MrfuOffset[i].UL_Pwr_Offset 	= ptr->MrfuOffset[i].UL_Pwr_Offset;
        ADDW     R7,R5,#+892
        ADDW     R12,R3,#+288
        LDRH     R12,[R12, #+4]
        STRH     R12,[R7, #+4]
//  689 		}
//  690 	}
??SetDnrCtrlData_68:
        ADDW     R5,R5,#+10
        ADDS     R4,R4,#+8
        ADDW     R3,R3,#+6
        ADDS     R2,R2,#+4
        ADDW     R1,R1,#+3
        ADDS     R0,R0,#+1
        SUBS     R6,R6,#+1
        BNE.W    ??SetDnrCtrlData_51
//  691 
//  692   	return 1;
        MOVS     R0,#+1
        POP      {R4-R8,PC}       ;; return
//  693 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     SerPtr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_1:
        DC32     MuStatus

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_2:
        DC32     HuStatus

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_3:
        DC32     RuStatus

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "NL SOFTBANK In-Buildi...">`:
        DC8 "NL SOFTBANK In-Building Ver[%02x].[%02x]\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "SystemDate[%s]\\n">`:
        DC8 "SystemDate[%s]\012"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "Aug 30 2012">`:
        DC8 "Aug 30 2012"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "SystemTime[%s]\\n">`:
        DC8 "SystemTime[%s]\012"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "21:29:28">`:
        DC8 "21:29:28"
        DC8 0, 0, 0

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  694 
//  695 
//  696 ////////////////////////////////////////////////////////////////////////////////
//  697 // End of Source File
//  698 ////////////////////////
//  699 
// 
//     5 bytes in section .bss
// 2 578 bytes in section .text
// 
// 2 578 bytes of CODE memory
//     5 bytes of DATA memory
//
//Errors: none
//Warnings: none
