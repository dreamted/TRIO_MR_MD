///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      22/Nov/2010  17:57:51 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\expio /
//                    .c                                                      /
//    Command line =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\expio /
//                    .c -lcN C:\user\project\HK-DEI\fw\appl_rcub_20101101\so /
//                    ut\ -lB C:\user\project\HK-DEI\fw\appl_rcub_20101101\so /
//                    ut\ -o C:\user\project\HK-DEI\fw\appl_rcub_20101101\sou /
//                    t\ --endian=little --cpu=Cortex-M3 -e                   /
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
//    List file    =  C:\user\project\HK-DEI\fw\appl_rcub_20101101\sout\expio /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME expio

        EXTERN DnrSts
        EXTERN DownLoadBootingJump
        EXTERN ExpioBitRst
        EXTERN ExpioBitSet
        EXTERN KeyDetecting
        EXTERN KeyPadOnFlag
        EXTERN LcdWriting
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN SerialPadOnFlag
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN UdpPadOnFlag
        EXTERN WRCS_DownLoadGiveupTimerSet
        EXTERN tTestFlag

        PUBLIC AlarmCheck
        PUBLIC AttnBufferInit
        PUBLIC AttnDataOutput
        PUBLIC BlinkFlag
        PUBLIC ExpioInit
        PUBLIC ExpioPortInit
        PUBLIC ExpioSem
        PUBLIC ExpioTask
        PUBLIC FrontLEDDisplay
        PUBLIC FrontLEDSet
        PUBLIC FrontLEDStausOut
        PUBLIC LEDStatus
        PUBLIC MaxAttnCheck
        PUBLIC StatusUpdate
        PUBLIC StatustoIO

// C:\user\project\HK-DEI\fw\appl_rcub_20101101\code\expio.c
//    1 
//    2 /******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
//    3 * File Name          : exlib.c
//    4 * Author             : Yoon Byong-Gyu(bgyoon@naver.com)
//    5 * Date First Issued  : 02/01/2008
//    6 * Description        : This file provides all the port/input/update firmware functions.
//    7 * $Revision: 0.1 $
//    8 * $Revision date: 2008.01.__
//    9 ********************************************************************************/
//   10 
//   11 #define EXPIO_C
//   12 
//   13 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// struct os_event *__data ExpioSem
ExpioSem:
        DS8 4
        DS8 1024

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data LEDStatus[(enum <unnamed>)4U]
LEDStatus:
        DS8 4
// INT8U __data BlinkFlag
BlinkFlag:
        DS8 1
//   14 
//   15 #include <stdlib.h>
//   16 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   17 void ExpioInit(void)
//   18 {
ExpioInit:
        PUSH     {R4,LR}
//   19 
//   20 	ExpioPortInit();
        LDR.N    R4,??DataTable1  ;; ExpioSem
        MOVS     R0,#+1
        BL       OSSemCreate
        STR      R0,[R4, #+0]
//   21 
//   22 	OSTaskCreate(ExpioTask, (void *)NULL, (OS_STK *)&ExpioTaskStk[EXPIO_START_STK_SIZE - 1], EXPIO_START_PRIO);
        MOVS     R3,#+2
        ADD      R2,R4,#+1024
        MOVS     R1,#+0
        LDR.N    R0,??ExpioInit_0  ;; ExpioTask
        POP      {R4,LR}
        B.W      OSTaskCreate
        Nop      
        DATA
??ExpioInit_0:
        DC32     ExpioTask
//   23 
//   24 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   25 void ExpioPortInit(void)
//   26 {
ExpioPortInit:
        PUSH     {R7,LR}
//   27 	#ifndef __FSMC_SRAM_H
//   28 		////////////////////////////////////////////////////////////////////////////
//   29 		// 반드시 gpio init 에서 --> outputmode로 변경해야 한다...
//   30 		// select 한핀은 반드시 모두다 high로 만들어줘야 한다.
//   31 		//GPIOC->ODR.Bit.ODR6 = 1;	// CS0
//   32 		//GPIOE->ODR.Bit.ODR10 = 1; // CS1
//   33 		/***
//   34 		GPIOB->ODR.Bit.ODR9 = 1;	// CS2
//   35 		GPIOB->ODR.Bit.ODR12 = 1;	// CS3
//   36 		GPIOB->ODR.Bit.ODR13 = 1;	// CS4
//   37 		GPIOB->ODR.Bit.ODR14 = 1;	// CS5
//   38 		GPIOB->ODR.Bit.ODR15 = 1;	// CS6
//   39 		GPIOC->ODR.Bit.ODR14 = 1;	// CS7
//   40 		GPIOC->ODR.Bit.ODR15 = 1;	// CS8
//   41 		GPIOA->ODR.Bit.ODR11 = 1;	// CS9
//   42 		GPIOA->ODR.Bit.ODR12 = 1;	// CS10
//   43 	***/
//   44 	#endif //__FSMC_SRAM_H
//   45 	ExpioSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.N    R1,??DataTable1  ;; ExpioSem
        STR      R0,[R1, #+0]
//   46 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable1:
        DC32     ExpioSem
//   47 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   48 void ExpioTask(void *p_arg)
//   49 {
ExpioTask:
        PUSH     {R3-R5,LR}
//   50 	(void)p_arg;
//   51 
//   52 	////////////////////////////////
//   53 	TimerRegist(TimerLEDBlink, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+23
        BL       TimerRegist
//   54 	TimerRegist(Timer_ALC, Time100mSec*10L);
        MOV      R1,#+1000
        MOVS     R0,#+16
        BL       TimerRegist
//   55 
//   56 	DU0_RESET = 0;
        LDR.N    R4,??ExpioTask_0  ;; 0x40010c0c
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        BICS     R0,R0,R1
        STR      R0,[R4, #+0]
//   57 	DU1_RESET = 0;
        LDR      R0,[R4, #+0]
        MOVS     R1,#+2
        BICS     R0,R0,R1
        STR      R0,[R4, #+0]
//   58 	DU2_RESET = 0;
        LDR.N    R5,??ExpioTask_0+0x4  ;; 0x4001100c
        LDR      R0,[R5, #+0]
        MOVS     R1,#+1
        BICS     R0,R0,R1
        STR      R0,[R5, #+0]
//   59 	ITU_RESET = 0;
        LDR      R0,[R5, #+0]
        MOVS     R1,#+2
        BICS     R0,R0,R1
        STR      R0,[R5, #+0]
//   60 	
//   61 	OSTimeDly(700*2L);
        MOV      R0,#+1400
        BL       OSTimeDly
//   62 
//   63 	DU0_RESET = 1;
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R4, #+0]
//   64 	DU1_RESET = 1;
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x2
        STR      R0,[R4, #+0]
//   65 	DU2_RESET = 1;
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x1
        STR      R0,[R5, #+0]
//   66 	ITU_RESET = 1;
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x2
        STR      R0,[R5, #+0]
        LDR.N    R4,??ExpioTask_0+0x8  ;; tTestFlag
        B.N      ??ExpioTask_1
//   67 
//   68 	while(1)
//   69 	{
//   70 		while(!WRCS_DownLoadGiveupTimerSet(NULL) && !tTestFlag)
//   71 		{
//   72 /////////////////////////////////////////////////////////////
//   73 			AlarmCheck();
??ExpioTask_2:
        BL       AlarmCheck
//   74 			StatusUpdate();
        BL       StatusUpdate
//   75 			StatustoIO();
//   76 			LcdWriting();
        BL       LcdWriting
//   77 			KeyDetecting();
        BL       KeyDetecting
//   78 			OSTimeDly(20L);
??ExpioTask_3:
        MOVS     R0,#+20
        BL       OSTimeDly
//   79 		}
??ExpioTask_1:
        MOVS     R0,#+0
        BL       WRCS_DownLoadGiveupTimerSet
        CBNZ     R0,??ExpioTask_4
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??ExpioTask_2
//   80 		OSTimeDly(20L);
??ExpioTask_4:
        B.N      ??ExpioTask_3
        DATA
??ExpioTask_0:
        DC32     0x40010c0c
        DC32     0x4001100c
        DC32     tTestFlag
//   81 	}
//   82 }
//   83 
//   84 #define INSERT_ALL
//   85 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   86 void StatusUpdate(void)
//   87 {
StatusUpdate:
        PUSH     {R7,LR}
//   88 	INT8U i = 0;
//   89 	__DnrStsStr *Sts;
//   90 
//   91 	
//   92 	for(i = 0; i < DnrMaxID; i++)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4  ;; DnrSts
        LDR.N    R2,??DataTable5  ;; 0x40011008
//   93 	{
//   94 		Sts = &DnrSts[i];
//   95 #ifdef INSERT_ALL	// to test
//   96 		BitSet(Sts->DnrInstall[0], mInstall);
??StatusUpdate_0:
        LDRB     R12,[R1, #+149]
        ORR      R12,R12,#0x4
        STRB     R12,[R1, #+149]
//   97 		BitSet(Sts->DnrInstall[1], mInstall);
        ADD      R12,R1,#+149
        LDRB     LR,[R12, #+1]
        ORR      LR,LR,#0x4
        STRB     LR,[R12, #+1]
//   98 		BitSet(Sts->DnrInstall[2], mInstall);
        LDRB     LR,[R12, #+2]
        ORR      LR,LR,#0x4
        STRB     LR,[R12, #+2]
//   99 		//BitSet(Sts->ITUInstall, mInstall);
//  100 		if(ITU_INSERT)	BitRst(Sts->ITUInstall, mInstall);
        LDR      R12,[R2, #+0]
        TST      R12,#0x80
        BEQ.N    ??StatusUpdate_1
        LDRB     R12,[R1, #+197]
        AND      R12,R12,#0xFB
        STRB     R12,[R1, #+197]
        B.N      ??StatusUpdate_2
//  101 		else			BitSet(Sts->ITUInstall, mInstall);
??StatusUpdate_1:
        LDRB     R12,[R1, #+197]
        ORR      R12,R12,#0x4
        STRB     R12,[R1, #+197]
//  102 #else
//  103 		if(DU0_INSERT) 	BitRst(Sts->DnrInstall[0], mInstall);
//  104 		else			BitSet(Sts->DnrInstall[0], mInstall);
//  105 
//  106 		if(DU1_INSERT)	BitRst(Sts->DnrInstall[1], mInstall);
//  107 		else			BitSet(Sts->DnrInstall[1], mInstall);
//  108 
//  109 		if(DU2_INSERT)	BitRst(Sts->DnrInstall[2], mInstall);
//  110 		else			BitSet(Sts->DnrInstall[2], mInstall);
//  111 
//  112 		if(ITU_INSERT)	BitRst(Sts->ITUInstall, mInstall);
//  113 		else			BitSet(Sts->ITUInstall, mInstall);
//  114 
//  115 #endif
//  116 
//  117 	}
??StatusUpdate_2:
        ADDS     R0,R0,#+1
        ADDS     R1,R1,#+201
        UXTB     R3,R0
        CMP      R3,#+3
        BCC.N    ??StatusUpdate_0
//  118 ////////////////////////////////////////////////////////////////////////////////
//  119 }
        POP      {R0,PC}          ;; return
//  120 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  121 void AlarmCheck(void)
//  122 {
AlarmCheck:
        PUSH     {R3-R9,LR}
//  123 	INT8U i = 0;
//  124 	INT8U AlmSts = 0;
//  125 	__DnrStsStr *Sts;
//  126 	
//  127 	for(i = 0; i < DnrMaxID; i++)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4  ;; DnrSts
        LDR.N    R2,??AlarmCheck_0  ;; UdpPadOnFlag
        LDR.N    R3,??AlarmCheck_0+0x4  ;; KeyPadOnFlag
        LDR.W    R12,??AlarmCheck_0+0x8  ;; SerialPadOnFlag
        LDR.W    LR,??DataTable5  ;; 0x40011008
        LDR.N    R4,??AlarmCheck_0+0xC  ;; 0x40010c08
        LDR.N    R5,??AlarmCheck_0+0x10  ;; 0x40010808
//  128 	{
//  129 		Sts = &DnrSts[i];
//  130 
//  131 
//  132 		if(BitRead(Sts->DnrInstall[0], mInstall))
??AlarmCheck_1:
        ADD      R7,R1,#+148
        LDRB     R8,[R7, #+1]
        TST      R8,#0x4
        BEQ.N    ??AlarmCheck_2
//  133 		{
//  134 			AlmSts = RESET;
//  135 			if(DU0_FAIL)AlmSts = SET;
        LDR      R9,[R5, #+0]
        TST      R9,#0x800
        BEQ.N    ??AlarmCheck_2
//  136 
//  137 			if(!AlmSts) BitRst(Sts->DnrInstall[0], mSumAlarm);
//  138 			else		BitSet(Sts->DnrInstall[0], mSumAlarm);
        ORR      R8,R8,#0x2
        STRB     R8,[R7, #+1]
        B.N      ??AlarmCheck_3
??AlarmCheck_2:
        AND      R8,R8,#0xFD
        STRB     R8,[R7, #+1]
//  139 		}
//  140 		else
//  141 		{
//  142 			BitRst(Sts->DnrInstall[0], mSumAlarm);
//  143 		}
//  144 
//  145 		if(BitRead(Sts->DnrInstall[1], mInstall))
??AlarmCheck_3:
        LDRB     R8,[R7, #+2]
        TST      R8,#0x4
        BEQ.N    ??AlarmCheck_4
//  146 		{
//  147 			AlmSts = RESET;
//  148 			if(DU1_FAIL)AlmSts = SET;
        LDR      R9,[R4, #+0]
        TST      R9,#0x20
        BEQ.N    ??AlarmCheck_4
//  149 
//  150 			if(!AlmSts) BitRst(Sts->DnrInstall[1], mSumAlarm);
//  151 			else		BitSet(Sts->DnrInstall[1], mSumAlarm);
        ORR      R8,R8,#0x2
        STRB     R8,[R7, #+2]
        B.N      ??AlarmCheck_5
??AlarmCheck_4:
        AND      R8,R8,#0xFD
        STRB     R8,[R7, #+2]
//  152 		}
//  153 		else
//  154 		{
//  155 			BitRst(Sts->DnrInstall[1], mSumAlarm);
//  156 		}
//  157 
//  158 		if(BitRead(Sts->DnrInstall[2], mInstall))
??AlarmCheck_5:
        LDRB     R8,[R7, #+3]
        TST      R8,#0x4
        BEQ.N    ??AlarmCheck_6
//  159 		{
//  160 			AlmSts = RESET;
//  161 			if(DU2_FAIL)AlmSts = SET;
        LDR      R9,[R4, #+0]
        TST      R9,#0x100
        BEQ.N    ??AlarmCheck_6
//  162 
//  163 			if(!AlmSts) BitRst(Sts->DnrInstall[2], mSumAlarm);
//  164 			else		BitSet(Sts->DnrInstall[2], mSumAlarm);
        ORR      R8,R8,#0x2
        STRB     R8,[R7, #+3]
        B.N      ??AlarmCheck_7
??AlarmCheck_6:
        AND      R8,R8,#0xFD
        STRB     R8,[R7, #+3]
//  165 		}
//  166 		else
//  167 		{
//  168 			BitRst(Sts->DnrInstall[2], mSumAlarm);
//  169 		}
//  170 
//  171 
//  172 		if(BitRead(Sts->ITUInstall, mInstall))
??AlarmCheck_7:
        LDRB     R7,[R1, #+197]
        TST      R7,#0x4
        BEQ.N    ??AlarmCheck_8
//  173 		{
//  174 			AlmSts = RESET;
//  175 			if(ITU_FAIL)AlmSts = SET;
        LDR      R8,[LR, #+0]
        TST      R8,#0x40
        BEQ.N    ??AlarmCheck_8
//  176 
//  177 			if(!AlmSts) BitRst(Sts->ITUInstall, mSumAlarm);
//  178 			else		BitSet(Sts->ITUInstall, mSumAlarm);
        ORR      R7,R7,#0x2
        STRB     R7,[R1, #+197]
        B.N      ??AlarmCheck_9
??AlarmCheck_8:
        AND      R7,R7,#0xFD
        STRB     R7,[R1, #+197]
//  179 		}
//  180 		else
//  181 		{
//  182 			BitRst(Sts->ITUInstall, mSumAlarm);
//  183 		}
//  184 
//  185 /**
//  186 	INT32S tlimit;
//  187 	INT32S cval;
//  188 	INT8U AlmSts = 0;
//  189 
//  190 	__BeaconStsStr *Sts = BeaconSts;
//  191 
//  192 	if(TimeOverCheck(TimerCWOff))
//  193 	{
//  194 		Sts->CW0OnOff_3G = Disable;
//  195 	}
//  196 	////////////////////////////////////////////////////////////////////////////
//  197 
//  198 	
//  199 	AlmSts = 0;
//  200 	if(Sts->RvsInFA1_3G != 0x00) AlmSts++;
//  201 	if(Sts->RvsInFA2_3G != 0x00) AlmSts++;
//  202 	Sts->FANo_3G = AlmSts;
//  203 
//  204 	if(Sts->FANo_3G >= 2) 	Sts->IntUse.FAAttnSet = (3*2L);
//  205 	else					Sts->IntUse.FAAttnSet = 0;
//  206 
//  207 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  208 // FWD AMP OFF CASE
//  209 	if(Sts->RepeaterType[1] == __COPY_RACK || Sts->RepeaterType[1] == __GEN_RACK)
//  210 	{
//  211 		Sts->ModuleAlarm.AmpShutDn = Enable;
//  212 		Sts->BeaconAlm.FwdAmpOff_3G = Enable;
//  213 		
//  214 		Sts->AmpOffCase_3G = PauUsrOff; // __USER
//  215 		Sts->BeaconAlm.FwdAmpDCFail_3G = RESET;
//  216 	}
//  217 	else 
//  218 	{
//  219 		if(Sts->FwdAmpOff_3G == Disable)
//  220 		{
//  221 			Sts->AmpOffCase_3G = PauUsrOff;	// __USER
//  222 			
//  223 			Sts->ModuleAlarm.AmpShutDn = Disable;
//  224 			Sts->BeaconAlm.FwdAmpOff_3G = Disable;
//  225 		}
//  226 		else
//  227 		{
//  228 			AlmSts = FALSE;
//  229 			
//  230 			if(Sts->BeaconAlm.PwrSupplyLow)
//  231 			{
//  232 				Sts->AmpOffCase_3G = PauDcFail;
//  233 				Sts->BeaconAlm.FwdAmpDCFail_3G = SET;
//  234 				AlmSts = TRUE;
//  235 			}
//  236 			else
//  237 			{
//  238 				if(Sts->ModuleAlarm.ModuleInsertFail)
//  239 				{
//  240 					Sts->AmpOffCase_3G = PauPllUnlock;
//  241 					AlmSts = TRUE;
//  242 				}
//  243 				else
//  244 				{
//  245 					AlmSts = TRUE;
//  246 					
//  247 				 	     if(Sts->BeaconAlm.FwdAmpHighTempFail_3G)			Sts->AmpOffCase_3G = PauHighTemp;
//  248 					else if(Sts->BeaconAlm.FwdAmpOvrPwrFail_3G)				Sts->AmpOffCase_3G = PauOvrPwr;
//  249 					else if(Sts->BeaconAlm.FwdAmpVSWRFail_3G)				Sts->AmpOffCase_3G = PauVswr;
//  250 					else if(Sts->BeaconAlm.RvsOsc_3G || RvsOSCStep_3G >= 2)	Sts->AmpOffCase_3G = PauDevAutoShutDn;
//  251 					else if(Sts->BeaconAlm.LocalFail_3G)
//  252 					{
//  253 						Sts->AmpOffCase_3G = PauPllUnlock;
//  254 						if(Sts->BeaconAlm.RvsOsc_3G_LED) AlmSts = FALSE;	// if Rvs OSC 과정중이면 일단 ShutDown 무시한다.
//  255 					}
//  256 					else
//  257 					{
//  258 						AlmSts = FALSE;
//  259 						Sts->AmpOffCase_3G = PauUnknown;
//  260 					}
//  261 				}
//  262 				Sts->BeaconAlm.FwdAmpDCFail_3G = RESET;
//  263 				// SHUTDOWN STATUS
//  264 				if(AlmSts == TRUE)
//  265 				{
//  266 					Sts->ModuleAlarm.AmpShutDn = Disable;
//  267 					Sts->BeaconAlm.FwdAmpOff_3G = Disable;
//  268 				}
//  269 				else
//  270 				{
//  271 					Sts->ModuleAlarm.AmpShutDn = Enable;
//  272 					Sts->BeaconAlm.FwdAmpOff_3G = Enable;
//  273 				}
//  274 			}
//  275 		}
//  276 	}
//  277 ////////////////////////////////////////////////////////////////////////////////
//  278 	if(Sts->DrvFwdAmpOnOff_3G == Disable)
//  279 	{
//  280 		Sts->BeaconAlm.DrvFwdAmpOnOff_3G = Disable;
//  281 	}
//  282 	else
//  283 	{
//  284 		AlmSts = 0;
//  285 
//  286 		if(RvsOSCStep_3G >= 2) AlmSts++;
//  287 		AlmSts += Sts->BeaconAlm.RvsOsc_3G;
//  288 		AlmSts += Sts->BeaconAlm.PwrSupplyLow;
//  289 		if(!Sts->BeaconAlm.RvsOsc_3G_LED) AlmSts += Sts->BeaconAlm.LocalFail_3G; // if Rvs OSC 과정중이면 일단 ShutDown 무시한다.
//  290 
//  291 		if(AlmSts)
//  292 		{
//  293 			Sts->BeaconAlm.DrvFwdAmpOnOff_3G = Disable;
//  294 		}
//  295 		else
//  296 		{
//  297 			Sts->BeaconAlm.DrvFwdAmpOnOff_3G = Enable;
//  298 		}
//  299 	}
//  300 
//  301 	// Rvs drive amp
//  302 	if(Sts->DrvRvsAmpOnOff_3G == Disable)
//  303 	{
//  304 		Sts->BeaconAlm.DrvRvsAmpOnOff_3G = Disable;
//  305 	}
//  306 	else
//  307 	{
//  308 		AlmSts = 0;
//  309 
//  310 		if(RvsOSCStep_3G >= 2) AlmSts++;
//  311 		AlmSts += Sts->BeaconAlm.RvsOsc_3G;
//  312 		AlmSts += Sts->BeaconAlm.PwrSupplyLow;
//  313 		if(!Sts->BeaconAlm.RvsOsc_3G_LED) AlmSts += Sts->BeaconAlm.LocalFail_3G; // if Rvs OSC 과정중이면 일단 ShutDown 무시한다.
//  314 
//  315 		if(AlmSts)
//  316 		{
//  317 			Sts->BeaconAlm.DrvRvsAmpOnOff_3G = Disable;
//  318 		}
//  319 		else
//  320 		{
//  321 			Sts->BeaconAlm.DrvRvsAmpOnOff_3G = Enable;
//  322 		}
//  323 	}
//  324 
//  325 	if(Sts->CurrentTemp >= Sts->TempUpperLmt) 	Sts->BeaconAlm.TempUpperLmt = SET;
//  326 	else										Sts->BeaconAlm.TempUpperLmt = RESET;
//  327 
//  328 		
//  329 	if(Sts->RepeaterType[1] == __COPY_RACK || Sts->RepeaterType[1] == __GEN_RACK)
//  330 	{
//  331 		Sts->BeaconAlm.FwdOut_REPUpperLmt_3G = RESET;
//  332 		Sts->BeaconAlm.FwdOut_REPLowerLmt_3G = RESET;
//  333 	}
//  334 	else
//  335 	{
//  336 		cval = Sts->FwdPwrREP_3G[0]*10 + Sts->FwdPwrREP_3G[1];
//  337 		tlimit = Sts->FwdOut_REPUpperLmt_3G[0]*10 + Sts->FwdOut_REPUpperLmt_3G[1];
//  338 		
//  339 		// 출력 상한
//  340 		if(Sts->FwdOutAttn_REP_3G >= ALCMaxAttn && cval >= tlimit)
//  341 		{
//  342 			Sts->BeaconAlm.FwdOut_REPUpperLmt_3G = SET;
//  343 		}
//  344 		else {
//  345 			Sts->BeaconAlm.FwdOut_REPUpperLmt_3G = RESET;
//  346 		}
//  347 
//  348 		// 출력 하한..
//  349 		cval = Sts->FwdPwrREP_3G[0]*10 + Sts->FwdPwrREP_3G[1];
//  350 		tlimit = Sts->FwdOut_REPLowerLmt_3G[0]*10 + Sts->FwdOut_REPLowerLmt_3G[1];
//  351 
//  352 			 if(cval <= tlimit) 	Sts->BeaconAlm.FwdOut_REPLowerLmt_3G = SET;
//  353 		else if(cval > tlimit + 20)	Sts->BeaconAlm.FwdOut_REPLowerLmt_3G = RESET;
//  354 	}
//  355 
//  356 	
//  357 	{
//  358 		cval = Sts->FwdPwr_3G[0]*10 + Sts->FwdPwr_3G[1];
//  359 		tlimit = Sts->FwdOutUpperLmt_3G[0]*10 + Sts->FwdOutUpperLmt_3G[1];
//  360 		
//  361 		if(Sts->FwdOutAttn_3G >= ALCMaxAttn && cval >= tlimit)	Sts->BeaconAlm.FwdOutUpperLmt_3G = SET;
//  362 		else 													Sts->BeaconAlm.FwdOutUpperLmt_3G = RESET;
//  363 
//  364 		// 출력 하한.
//  365 		cval = Sts->FwdPwr_3G[0]*10 + Sts->FwdPwr_3G[1];
//  366 		tlimit = Sts->FwdOutLowerLmt_3G[0]*10 + Sts->FwdOutLowerLmt_3G[1];
//  367 		//SerPtr->printf("cval: %d, tlimit: %d\n", cval, tlimit);
//  368 
//  369 			  if(cval <= tlimit)	Sts->BeaconAlm.FwdOutLowerLmt_3G = SET;
//  370 		else if(cval > tlimit + 20)	Sts->BeaconAlm.FwdOutLowerLmt_3G = RESET;
//  371 	}
//  372 
//  373 ////////////////////////////////////////////////////////////////////////////////////////////////
//  374 	{
//  375 		cval = Sts->FwdInPwr_3G;
//  376 		tlimit = Sts->FwdInUpperLmt_3G;
//  377 	
//  378 			 if(cval >= tlimit)		Sts->BeaconAlm.FwdInUpperLmt_3G = SET;
//  379 		else if(cval < tlimit - 4)	Sts->BeaconAlm.FwdInUpperLmt_3G = RESET;
//  380 
//  381 		tlimit = Sts->FwdInLowerLmt_3G;
//  382 
//  383 			 if(cval <= tlimit)		Sts->BeaconAlm.FwdInLowerLmt_3G = SET;
//  384 		else if(cval > tlimit + 4)	Sts->BeaconAlm.FwdInLowerLmt_3G = RESET;
//  385 
//  386 		cval = Sts->RvsInPwr_3G;
//  387 		tlimit = Sts->RvsInUpperLmt_3G;
//  388 
//  389 			 if(cval >= tlimit)		Sts->BeaconAlm.RvsInUpperLmt_3G = SET;
//  390 		else if(cval < tlimit - 4)	Sts->BeaconAlm.RvsInUpperLmt_3G = RESET;
//  391 
//  392 		tlimit = Sts->RvsInLowerLmt_3G;
//  393 
//  394 		if(cval <= tlimit)			Sts->BeaconAlm.RvsInLowerLmt_3G = SET;
//  395 		else if(cval > tlimit + 4)	Sts->BeaconAlm.RvsInLowerLmt_3G = RESET;
//  396 
//  397 		
//  398 		cval = Sts->Rvs0OutPwr_3G[0]*10 + Sts->Rvs0OutPwr_3G[1];
//  399 		tlimit = Sts->Rvs0OutUpperLmt_3G[0]*10 + Sts->Rvs0OutUpperLmt_3G[1];
//  400 
//  401 			 if(cval >= tlimit)		Sts->BeaconAlm.RvsOutUpperLmt_3G = SET;
//  402 		else if(cval < tlimit - 20)	Sts->BeaconAlm.RvsOutUpperLmt_3G = RESET;
//  403 
//  404 		tlimit = Sts->Rvs0OutLowerLmt_3G[0]*10 + Sts->Rvs0OutLowerLmt_3G[1];
//  405 
//  406 			 if(cval <= tlimit)		Sts->BeaconAlm.RvsOutLowerLmt_3G = SET;
//  407 		else if(cval > tlimit + 20) Sts->BeaconAlm.RvsOutLowerLmt_3G = RESET;
//  408 	}
//  409 
//  410 **/
//  411 ////////////////////////////////////////////////////////////////////////////////
//  412 /**
//  413 	if(Sts->TPTL_OnOff == Enable)
//  414 	{
//  415 		INT8S tindex = 0;
//  416 		
//  417 		// Hysterisys !!
//  418 			 if(Sts->CurrentTemp >= tempIndexHys)		tempIndexHys = Sts->CurrentTemp;
//  419 		else if(Sts->CurrentTemp < (tempIndexHys - 1))	tempIndexHys = Sts->CurrentTemp;
//  420 
//  421 		tindex = TemptoIndex(tempIndexHys);
//  422         tindex = tindex;
//  423 
//  424 		Sts->FwdInAttnTemp_3G = vEE_TABLE->AttnTempTable[Local_FwdInTempAttn_3G].Data[tindex];
//  425 		Sts->FwdOutAttnTemp_3G = vEE_TABLE->AttnTempTable[Local_FwdOutTempAttn_3G].Data[tindex];
//  426 		Sts->FwdOutREPTempAttn_3G = vEE_TABLE->AttnTempTable[Local_FwdOutRepTempAttn_3G].Data[tindex];;
//  427 		Sts->Rvs0AttnTemp_3G = vEE_TABLE->AttnTempTable[Local_RvsTempAttn_3G].Data[tindex];
//  428 
//  429 		Sts->FwdInPllFreqTemp_3G.Data = vEE_TABLE1->PllTempTable[Local_FwdInPllFreq_3G].Data[tindex];
//  430 		Sts->FwdOut1PllFreqTemp_3G.Data = vEE_TABLE1->PllTempTable[Local_FwdOut1PllFreq_3G].Data[tindex];
//  431 		Sts->FwdOut2PllFreqTemp_3G.Data = vEE_TABLE1->PllTempTable[Local_FwdOut2PllFreq_3G].Data[tindex];
//  432 		Sts->RvsIn1PllFreqTemp_3G.Data = Sts->FwdOut1PllFreqTemp_3G.Data;
//  433 		Sts->RvsIn2PllFreqTemp_3G.Data = Sts->FwdOut2PllFreqTemp_3G.Data;
//  434 		Sts->RvsOutPllFreqTemp_3G.Data = Sts->FwdInPllFreqTemp_3G.Data;
//  435 	}
//  436 	**/
//  437 
//  438 		// KEY PAD, PC SERIAL ON CHECK
//  439 		if(SerialPadOnFlag)	BitSet(Sts->StsConFail, SerConnect);
??AlarmCheck_9:
        LDRB     R7,[R12, #+0]
        CBZ      R7,??AlarmCheck_10
        LDRB     R7,[R1, #+148]
        ORR      R7,R7,#0x1
        STRB     R7,[R1, #+148]
        B.N      ??AlarmCheck_11
//  440 		else				BitRst(Sts->StsConFail, SerConnect);
??AlarmCheck_10:
        LDRB     R7,[R1, #+148]
        AND      R7,R7,#0xFE
        STRB     R7,[R1, #+148]
//  441 
//  442 		if(KeyPadOnFlag)	BitSet(Sts->StsConFail, KeyConnect);
??AlarmCheck_11:
        LDRB     R7,[R3, #+0]
        CBZ      R7,??AlarmCheck_12
        LDRB     R7,[R1, #+148]
        ORR      R7,R7,#0x2
        STRB     R7,[R1, #+148]
        B.N      ??AlarmCheck_13
//  443 		else				BitRst(Sts->StsConFail, KeyConnect);
??AlarmCheck_12:
        LDRB     R7,[R1, #+148]
        AND      R7,R7,#0xFD
        STRB     R7,[R1, #+148]
//  444 
//  445 		if(UdpPadOnFlag)	BitSet(Sts->StsConFail, WrcsConnect);
??AlarmCheck_13:
        LDRB     R7,[R2, #+0]
        CBZ      R7,??AlarmCheck_14
        LDRB     R7,[R1, #+148]
        ORR      R7,R7,#0x4
        STRB     R7,[R1, #+148]
        B.N      ??AlarmCheck_15
//  446 		else				BitRst(Sts->StsConFail, WrcsConnect);
??AlarmCheck_14:
        LDRB     R7,[R1, #+148]
        AND      R7,R7,#0xFB
        STRB     R7,[R1, #+148]
//  447 
//  448 		if(Sts->StsConFail & 0x03) 	Sts->DnrAlm.StsConFail = SET;
??AlarmCheck_15:
        LDRB     R7,[R1, #+148]
        TST      R7,#0x3
        LDRB     R7,[R1, #+5]
        ITTEE    EQ 
        ANDEQ    R7,R7,#0x7F
        STRBEQ   R7,[R1, #+5]
        ORRNE    R7,R7,#0x80
        STRBNE   R7,[R1, #+5]
//  449 		else						Sts->DnrAlm.StsConFail = RESET;
//  450 
//  451 	}
        ADDS     R0,R0,#+1
        ADDS     R1,R1,#+201
        UXTB     R6,R0
        CMP      R6,#+3
        BCC.W    ??AlarmCheck_1
//  452 	if(TimeOverCheck(TimerReset)) DownLoadBootingJump();
        MOVS     R0,#+21
        BL       TimeOverCheck
        CBZ      R0,??AlarmCheck_16
        BL       DownLoadBootingJump
//  453 
//  454 }
??AlarmCheck_16:
        POP      {R0,R4-R9,PC}    ;; return
        DATA
??AlarmCheck_0:
        DC32     UdpPadOnFlag
        DC32     KeyPadOnFlag
        DC32     SerialPadOnFlag
        DC32     0x40010c08
        DC32     0x40010808

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     DnrSts

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x40011008
//  455 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  456 void StatustoIO(void)
//  457 {
//  458 
//  459 }
StatustoIO:
        BX       LR               ;; return
//  460 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  461 void AttnBufferInit(void)
//  462 {
//  463 
//  464 
//  465 }
AttnBufferInit:
        BX       LR               ;; return
//  466 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  467 INT8U MaxAttnCheck(INT16S cAttn, INT16S tMax)
//  468 {
//  469 	INT8U retval = cAttn;
//  470 	
//  471 	if(cAttn > tMax)
MaxAttnCheck:
        CMP      R1,R0
        BGE.N    ??MaxAttnCheck_0
//  472 	{
//  473 		retval = tMax;
        MOVS     R0,R1
        B.N      ??MaxAttnCheck_1
//  474 	}
//  475 	else if(cAttn < 0)
??MaxAttnCheck_0:
        CMP      R0,#+0
        IT       MI 
//  476 	{
//  477 		retval = 0;
        MOVMI    R0,#+0
//  478 	}
//  479 
//  480 	return retval;
??MaxAttnCheck_1:
        UXTB     R0,R0
        BX       LR               ;; return
//  481 }
//  482 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  483 void FrontLEDStausOut(void)
//  484 {
//  485 
//  486 	INT8U rval = 0;
//  487 /**************	__BeaconStsStr *Sts = BeaconSts;
//  488 
//  489 	rval += Sts->BeaconAlm.BatteryLow;
//  490 	rval += Sts->BeaconAlm.DCFail;
//  491 	rval += Sts->BeaconAlm.ACFail;
//  492 	rval += Sts->BeaconAlm.TempUpperLmt;
//  493 	rval += Sts->BeaconAlm.DrvRvsAmpOnOff_3G;
//  494 	rval += Sts->BeaconAlm.DrvFwdAmpOnOff_3G;
//  495 	rval += Sts->BeaconAlm.LocalFail_3G;
//  496 	rval += Sts->BeaconAlm.FwdPllLock_3G;
//  497 	rval += Sts->BeaconAlm.FwdOutLowerLmt_3G;
//  498 	rval += Sts->BeaconAlm.FwdOutUpperLmt_3G;
//  499 	rval += Sts->BeaconAlm.FwdInLowerLmt_3G;
//  500 	rval += Sts->BeaconAlm.FwdInUpperLmt_3G;
//  501 	rval += Sts->BeaconAlm.RvsOutLowerLmt_3G;
//  502 	rval += Sts->BeaconAlm.RvsOutUpperLmt_3G;
//  503 	rval += Sts->BeaconAlm.RvsInLowerLmt_3G;
//  504 	rval += Sts->BeaconAlm.RvsInUpperLmt_3G;
//  505 	rval += Sts->BeaconAlm.RvsOsc_3G;
//  506 	rval += Sts->BeaconAlm.FwdAmpDevFail_3G;
//  507 	rval += Sts->BeaconAlm.FwdAmpDCFail_3G;
//  508 	rval += Sts->BeaconAlm.FwdAmpOff_3G;
//  509 	rval += Sts->BeaconAlm.FwdAmpVSWRFail_3G;
//  510 	rval += Sts->BeaconAlm.FwdAmpHighTempFail_3G;
//  511 	rval += Sts->BeaconAlm.FwdAmpOvrPwrFail_3G;
//  512 	//rval += Sts->BeaconAlm.SnifferpathLost;
//  513 	rval += Sts->BeaconAlm.FwdOut_REPLowerLmt_3G;
//  514 	rval += Sts->BeaconAlm.FwdOut_REPUpperLmt_3G;
//  515 	//rval += Sts->BeaconAlm.SyncFail;
//  516 	rval += Sts->BeaconAlm.PwrSupplyLow;
//  517 	//rval += Sts->BeaconAlm.SWoadingFail;
//  518 ***************/
//  519 	if(rval)	FrontLEDSet(LED_SUMSel, LEDAlmON);
//  520 	else		FrontLEDSet(LED_SUMSel, LEDNorON);
FrontLEDStausOut:
        LDR.N    R0,??DataTable8  ;; LEDStatus
        MOVS     R1,#+0
        STRB     R1,[R0, #+2]
//  521 
//  522 }
        BX       LR               ;; return
//  523 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  524 void FrontLEDSet(INT8U tindex, INT8U tstatus)
//  525 {
//  526 	LEDStatus[tindex%12] = tstatus;
FrontLEDSet:
        MOVS     R2,#+12
        SDIV     R3,R0,R2
        MLS      R0,R3,R2,R0
        LDR.N    R2,??DataTable8  ;; LEDStatus
        STRB     R1,[R0, R2]
//  527 
//  528 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  529 void FrontLEDDisplay(void)
//  530 {
FrontLEDDisplay:
        PUSH     {R4-R6,LR}
//  531 	INT16U i = 0;
//  532 
//  533 	if(!TimeOverCheck(TimerLEDBlink)) return;
        MOVS     R0,#+23
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.W    ??FrontLEDDisplay_0
//  534 	TimerRegist(TimerLEDBlink, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+23
        BL       TimerRegist
//  535 	BlinkFlag ^= 1;
        LDR.N    R4,??DataTable8  ;; LEDStatus
        LDRB     R0,[R4, #+4]
        EOR      R0,R0,#0x1
        STRB     R0,[R4, #+4]
//  536 
//  537 	for(i = 0; i < LED_SelMax; i++)
        MOVS     R6,#+0
        MOVS     R5,R4
//  538 	{
//  539 		
//  540 		switch(LEDStatus[i])
??FrontLEDDisplay_1:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_2
        CMP      R0,#+2
        BEQ.N    ??FrontLEDDisplay_3
        CMP      R0,#+3
        BEQ.N    ??FrontLEDDisplay_4
        CMP      R0,#+4
        BEQ.N    ??FrontLEDDisplay_5
//  541 		{
//  542         	default:
//  543 			case LEDNorON:
//  544 				switch(i)
        UXTH     R0,R6
        CBZ      R0,??FrontLEDDisplay_6
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_7
        CMP      R0,#+2
        BEQ.N    ??FrontLEDDisplay_8
        B.N      ??FrontLEDDisplay_9
//  545 				{
//  546 					case LED_PWRSel:
//  547 						ExpioBitSet(LED0_G_Sel);
??FrontLEDDisplay_6:
        MOVS     R0,#+33
        BL       ExpioBitSet
//  548 						ExpioBitRst(LED0_R_Sel);
        MOVS     R0,#+32
        B.N      ??FrontLEDDisplay_10
//  549 					break;
//  550 					
//  551 					case LED_RUNSel:
//  552 						ExpioBitSet(LED1_G_Sel);
??FrontLEDDisplay_7:
        MOVS     R0,#+35
        BL       ExpioBitSet
//  553 						ExpioBitRst(LED1_R_Sel);
        MOVS     R0,#+34
        B.N      ??FrontLEDDisplay_10
//  554 					break;
//  555 					
//  556 					case LED_SUMSel:
//  557 						ExpioBitSet(LED2_G_Sel);
??FrontLEDDisplay_8:
        MOVS     R0,#+37
        BL       ExpioBitSet
//  558 						ExpioBitRst(LED2_R_Sel);
        MOVS     R0,#+36
        B.N      ??FrontLEDDisplay_10
//  559 					break;
//  560 
//  561 					case LED_TxSel:
//  562 						//ExpioBitSet(LED3_G_Sel);
//  563 						//ExpioBitRst(LED3_R_Sel);
//  564 					break;
//  565 
//  566 				}
//  567 			break;
//  568 
//  569 			case LEDNorONOFF:
//  570 				switch(i)
??FrontLEDDisplay_2:
        UXTH     R0,R6
        CBZ      R0,??FrontLEDDisplay_11
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_12
        CMP      R0,#+2
        BEQ.N    ??FrontLEDDisplay_13
        B.N      ??FrontLEDDisplay_9
//  571 				{
//  572 					case LED_PWRSel:
//  573 						if(BlinkFlag) 	ExpioBitSet(LED0_G_Sel);
??FrontLEDDisplay_11:
        LDRB     R0,[R4, #+4]
        CBZ      R0,??FrontLEDDisplay_14
        MOVS     R0,#+33
        BL       ExpioBitSet
        B.N      ??FrontLEDDisplay_15
//  574 						else			ExpioBitRst(LED0_G_Sel);
??FrontLEDDisplay_14:
        MOVS     R0,#+33
        BL       ExpioBitRst
//  575 						ExpioBitRst(LED0_R_Sel);
??FrontLEDDisplay_15:
        MOVS     R0,#+32
        B.N      ??FrontLEDDisplay_10
//  576 					break;
//  577 					
//  578 					case LED_RUNSel:
//  579 						if(BlinkFlag) 	ExpioBitSet(LED1_G_Sel);
??FrontLEDDisplay_12:
        LDRB     R0,[R4, #+4]
        CBZ      R0,??FrontLEDDisplay_16
        MOVS     R0,#+35
        BL       ExpioBitSet
        B.N      ??FrontLEDDisplay_17
//  580 						else			ExpioBitRst(LED1_G_Sel);
??FrontLEDDisplay_16:
        MOVS     R0,#+35
        BL       ExpioBitRst
//  581 						ExpioBitRst(LED1_R_Sel);
??FrontLEDDisplay_17:
        MOVS     R0,#+34
        B.N      ??FrontLEDDisplay_10
//  582 					break;
//  583 					
//  584 					case LED_SUMSel:
//  585 						if(BlinkFlag) 	ExpioBitSet(LED2_G_Sel);
??FrontLEDDisplay_13:
        LDRB     R0,[R4, #+4]
        CBZ      R0,??FrontLEDDisplay_18
        MOVS     R0,#+37
        BL       ExpioBitSet
        B.N      ??FrontLEDDisplay_19
//  586 						else			ExpioBitRst(LED2_G_Sel);
??FrontLEDDisplay_18:
        MOVS     R0,#+37
        BL       ExpioBitRst
//  587 						ExpioBitRst(LED2_R_Sel);
??FrontLEDDisplay_19:
        MOVS     R0,#+36
        B.N      ??FrontLEDDisplay_10
//  588 					break;
//  589 
//  590 					case LED_TxSel:
//  591 						//if(BlinkFlag) 	ExpioBitSet(LED3_G_Sel);
//  592 						//else			ExpioBitRst(LED3_G_Sel);
//  593 						//ExpioBitRst(LED3_R_Sel);
//  594 					break;
//  595 
//  596 				}
//  597 			break;
//  598 			
//  599 			case LEDAlmON:
//  600 				switch(i)
??FrontLEDDisplay_3:
        UXTH     R0,R6
        CBZ      R0,??FrontLEDDisplay_20
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_21
        CMP      R0,#+2
        BEQ.N    ??FrontLEDDisplay_22
        B.N      ??FrontLEDDisplay_9
//  601 				{
//  602 					case LED_PWRSel:
//  603 						ExpioBitSet(LED0_R_Sel);
??FrontLEDDisplay_20:
        MOVS     R0,#+32
        BL       ExpioBitSet
//  604 						ExpioBitRst(LED0_G_Sel);
        MOVS     R0,#+33
        B.N      ??FrontLEDDisplay_10
//  605 					break;
//  606 					case LED_RUNSel:
//  607 						ExpioBitSet(LED1_R_Sel);
??FrontLEDDisplay_21:
        MOVS     R0,#+34
        BL       ExpioBitSet
//  608 						ExpioBitRst(LED1_G_Sel);
        MOVS     R0,#+35
        B.N      ??FrontLEDDisplay_10
//  609 					break;
//  610 					case LED_SUMSel:
//  611 						ExpioBitSet(LED2_R_Sel);
??FrontLEDDisplay_22:
        MOVS     R0,#+36
        BL       ExpioBitSet
//  612 						ExpioBitRst(LED2_G_Sel);
        MOVS     R0,#+37
        B.N      ??FrontLEDDisplay_10
//  613 					break;
//  614 					case LED_TxSel:
//  615 						//ExpioBitSet(LED3_R_Sel);
//  616 						//ExpioBitRst(LED3_G_Sel);
//  617 					break;
//  618 				}
//  619 			break;
//  620 			case LEDAlmONOFF:
//  621 				switch(i)
??FrontLEDDisplay_4:
        UXTH     R0,R6
        CBZ      R0,??FrontLEDDisplay_23
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_24
        CMP      R0,#+2
        BEQ.N    ??FrontLEDDisplay_25
        B.N      ??FrontLEDDisplay_9
//  622 				{
//  623 					case LED_PWRSel:
//  624 						if(BlinkFlag) 	ExpioBitSet(LED0_R_Sel);
??FrontLEDDisplay_23:
        LDRB     R0,[R4, #+4]
        CBZ      R0,??FrontLEDDisplay_26
        MOVS     R0,#+32
        BL       ExpioBitSet
        B.N      ??FrontLEDDisplay_27
//  625 						else			ExpioBitRst(LED0_R_Sel);
??FrontLEDDisplay_26:
        MOVS     R0,#+32
        BL       ExpioBitRst
//  626 						ExpioBitRst(LED0_G_Sel);
??FrontLEDDisplay_27:
        MOVS     R0,#+33
        B.N      ??FrontLEDDisplay_10
//  627 					break;
//  628 					case LED_RUNSel:
//  629 						if(BlinkFlag) 	ExpioBitSet(LED1_R_Sel);
??FrontLEDDisplay_24:
        LDRB     R0,[R4, #+4]
        CBZ      R0,??FrontLEDDisplay_28
        MOVS     R0,#+34
        BL       ExpioBitSet
        B.N      ??FrontLEDDisplay_29
//  630 						else			ExpioBitRst(LED1_R_Sel);
??FrontLEDDisplay_28:
        MOVS     R0,#+34
        BL       ExpioBitRst
//  631 						ExpioBitRst(LED1_G_Sel);
??FrontLEDDisplay_29:
        MOVS     R0,#+35
        B.N      ??FrontLEDDisplay_10
//  632 					break;					
//  633 					case LED_SUMSel:
//  634 						if(BlinkFlag) 	ExpioBitSet(LED2_R_Sel);
??FrontLEDDisplay_25:
        LDRB     R0,[R4, #+4]
        CBZ      R0,??FrontLEDDisplay_30
        MOVS     R0,#+36
        BL       ExpioBitSet
        B.N      ??FrontLEDDisplay_31
//  635 						else			ExpioBitRst(LED2_R_Sel);
??FrontLEDDisplay_30:
        MOVS     R0,#+36
        BL       ExpioBitRst
//  636 						ExpioBitRst(LED2_G_Sel);
??FrontLEDDisplay_31:
        MOVS     R0,#+37
        B.N      ??FrontLEDDisplay_10
//  637 					break;
//  638 					case LED_TxSel:
//  639 						//if(BlinkFlag) 	ExpioBitSet(LED3_R_Sel);
//  640 						//else			ExpioBitRst(LED3_R_Sel);
//  641 						//ExpioBitRst(LED3_G_Sel);
//  642 					break;
//  643 				}
//  644 			break;
//  645 			
//  646 			case LEDAllOFF:
//  647 				switch(i)
??FrontLEDDisplay_5:
        UXTH     R0,R6
        CBZ      R0,??FrontLEDDisplay_32
        CMP      R0,#+1
        BEQ.N    ??FrontLEDDisplay_33
        CMP      R0,#+2
        BNE.N    ??FrontLEDDisplay_9
//  648 				{
//  649 					case LED_PWRSel:
//  650 						ExpioBitRst(LED0_R_Sel);
??FrontLEDDisplay_32:
        MOVS     R0,#+32
        BL       ExpioBitRst
//  651 						ExpioBitRst(LED0_G_Sel);
        MOVS     R0,#+33
        B.N      ??FrontLEDDisplay_10
//  652 					break;
//  653 					case LED_SUMSel:
//  654 						ExpioBitRst(LED0_R_Sel);
//  655 						ExpioBitRst(LED0_G_Sel);
//  656 					break;
//  657 					case LED_RUNSel:
//  658 						ExpioBitRst(LED2_R_Sel);
??FrontLEDDisplay_33:
        MOVS     R0,#+36
        BL       ExpioBitRst
//  659 						ExpioBitRst(LED2_G_Sel);
        MOVS     R0,#+37
??FrontLEDDisplay_10:
        BL       ExpioBitRst
//  660 					break;
//  661 					case LED_TxSel:
//  662 						//ExpioBitRst(LED3_R_Sel);
//  663 						//ExpioBitRst(LED3_G_Sel);
//  664 					break;
//  665 				}
//  666 			break;
//  667 		}
//  668 	}
??FrontLEDDisplay_9:
        ADDS     R6,R6,#+1
        ADDS     R5,R5,#+1
        UXTH     R0,R6
        CMP      R0,#+4
        BCC.W    ??FrontLEDDisplay_1
??FrontLEDDisplay_0:
        POP      {R4-R6,PC}       ;; return
//  669 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     LEDStatus
//  670 
//  671 
//  672 //#define PE_4302_USED
//  673 //#define HMC_264_USED
//  674 #define HMC_542_USED
//  675 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  676 void AttnDataOutput(unsigned short int Sel, unsigned char Data)
//  677 {
//  678 #if 0 
//  679 	INT8U i = 0;
//  680 	
//  681 #ifdef HMC_264_USED
//  682 	i = i;
//  683     /************
//  684 	Data = (~Data )& 0x3f;
//  685 
//  686 	__ATTN_DATA = 0;
//  687 	__ATTN_CLK = 0;
//  688 	
//  689 	for(i = 0; i < 6; i++)
//  690 	{
//  691 		if (Data & 0x20) 	__ATTN_DATA = 1;
//  692 		else 				__ATTN_DATA = 0;
//  693 		Data = Data << 1;
//  694 		ForDelay(50L);
//  695 		__ATTN_CLK = 1;
//  696 		ForDelay(50L);
//  697 		__ATTN_CLK = 0;
//  698 	}
//  699 	__ATTN_DATA = 0;
//  700 
//  701 	switch(Sel)
//  702 	{
//  703 	    case __DDR_Rx0Att_2G:			__2G_ATTN_EN0_RX = 1;			break;
//  704 	    case __DDR_Rx0Att_3G:			__3G_ATTN_EN0_RX = 1;			break;
//  705 	    case __DDR_Rx0AttOffset_2G:		__2G_ATTN_EN_RX_User = 1;		break;
//  706 	    case __DDR_Rx0AttOffset_3G:		__3G_ATTN_EN_RX_User = 1;		break;
//  707 //	    case __DDR_Rx0Att_2G_Ext:		__ATTN_EN1_Rx0Att_2G = 1;		break;
//  708 //	    case __DDR_Rx0Att_3G_Ext:		__ATTN_EN1_Rx0Att_3G = 1;		break;
//  709 	}
//  710 
//  711 	ForDelay(100L);
//  712 	__2G_ATTN_EN0_RX = 0;
//  713 	__3G_ATTN_EN0_RX = 0;
//  714 	__2G_ATTN_EN_RX_User = 0;
//  715 	__3G_ATTN_EN_RX_User = 0;
//  716 //	__ATTN_EN1_Rx0Att_2G = 0;
//  717 //	__ATTN_EN1_Rx0Att_3G = 0;
//  718     
//  719     ************/
//  720 #elif defined(HMC_542_USED)
//  721 	Data = (~Data )& 0x3f;
//  722 
//  723 	ExpioBitRst(ATTN_DATASel);
//  724 	ExpioBitRst(ATTN_CLKSel);
//  725 	
//  726 	for(i = 0; i < 8; i++)
//  727 	{
//  728 		if (Data & 0x20) 	ExpioBitSet(ATTN_DATASel);
//  729 		else 				ExpioBitRst(ATTN_DATASel);
//  730 		Data = Data << 1;
//  731 
//  732 		ForDelay(ATTN_DELAY);
//  733 		ExpioBitSet(ATTN_CLKSel);
//  734 		ForDelay(ATTN_DELAY);
//  735 		ExpioBitRst(ATTN_CLKSel);
//  736 	}
//  737 
//  738 	switch(Sel)
//  739 	{
//  740 		case __index_TxAttn1_3G:	ExpioBitSet(FWD_ATTN_EN1Sel);	break;
//  741 		case __index_TxAttn2_3G:	ExpioBitSet(FWD_ATTN_EN2Sel);	break;
//  742 		case __index_NodeBAttn_3G:	ExpioBitSet(Fwd_NODEBSel);		break;
//  743 		case __index_RepAttn_3G:	ExpioBitSet(Fwd_REPSel);		break;
//  744 		case __index_RxAttn_3G:		ExpioBitSet(RvsAttnEn2Sel);		break;
//  745 		case __index_RxTempAttn_3G:	ExpioBitSet(RvsAttnEn1Sel);		break;
//  746 	}
//  747 
//  748 	ForDelay(ATTN_DELAY);
//  749 	
//  750 	ExpioBitRst(FWD_ATTN_EN1Sel);
//  751 	ExpioBitRst(FWD_ATTN_EN2Sel);
//  752 	ExpioBitRst(RvsAttnEn1Sel);
//  753 	ExpioBitRst(RvsAttnEn2Sel);
//  754 	ExpioBitRst(Fwd_NODEBSel);
//  755 	ExpioBitRst(Fwd_REPSel);
//  756 
//  757 #elif defined(PE_4302_USED)
//  758 
//  759 	Data = Data & 0x3f;
//  760 
//  761 	ExpioBitRst(ATTN_DATASel);
//  762 	ExpioBitRst(ATTN_CLKSel);
//  763 
//  764 	for(i = 0; i < 6; i++)
//  765 	{
//  766 		if (Data & 0x20) ExpioBitSet(ATTN_DATASel);
//  767 		else			 ExpioBitRst(ATTN_DATASel);
//  768 
//  769 		Data = Data << 1;
//  770 		ForDelay(ATTN_DELAY);
//  771 		ExpioBitSet(ATTN_CLKSel);
//  772 		ForDelay(ATTN_DELAY);
//  773 		ExpioBitRst(ATTN_CLKSel);
//  774 	}
//  775 
//  776 	switch(Sel)
//  777 	{
//  778 		case __index_RxAttn_3G:		ExpioBitSet(ATTN_EN1Sel);	break;
//  779 		case __index_RxTempAttn_3G:	ExpioBitSet(ATTN_EN2Sel);	break;
//  780 	}
//  781 	
//  782 	ForDelay(ATTN_DELAY);
//  783 	ExpioBitRst(ATTN_EN1Sel);
//  784 	ExpioBitRst(ATTN_EN2Sel);
//  785 
//  786 #endif
//  787 #endif
//  788 }
AttnDataOutput:
        BX       LR               ;; return

        END
//  789 
//  790 ///////////////////////////////////////////////////////////////////////////////
//  791 // End of Source File
//  792 ////////////////////////
// 
// 1 033 bytes in section .bss
// 1 058 bytes in section .text
// 
// 1 058 bytes of CODE memory
// 1 033 bytes of DATA memory
//
//Errors: none
//Warnings: none
