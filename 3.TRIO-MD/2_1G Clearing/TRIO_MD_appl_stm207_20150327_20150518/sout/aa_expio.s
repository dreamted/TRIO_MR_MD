///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    30/Aug/2012  21:29:28 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_expio.c   /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_expio.c   /
//                    -D OS_INCLUDED -D APPL_SRC -lcN                         /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\aa_expio.s   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_expio

        #define SHT_PROGBITS 0x1

        EXTERN ExpioBitRst
        EXTERN ExpioBitSet
        EXTERN ForDelay
        EXTERN MuStatus
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN tTestFlag

        PUBLIC AttnEn_Out
        PUBLIC ExpioInit
        PUBLIC ExpioPortInit
        PUBLIC ExpioSem
        PUBLIC ExpioTask
        PUBLIC HMC624AttnOut
        PUBLIC MaxAttnCheck
        PUBLIC PreAttn
        PUBLIC StatusUpdate
        PUBLIC StatustoIO
        PUBLIC TempAttn
        PUBLIC tempIndexHys

// D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_expio.c
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

        SECTION iram:DATA:REORDER:NOROOT(2)
// static __absolute OS_STK ExpioTaskStk[384]
ExpioTaskStk:
        DS8 1536

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute struct os_event *ExpioSem
ExpioSem:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(2)
// __absolute INT8U PreAttn[(enum <unnamed>)12U]
PreAttn:
        DATA
        DC8 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255
// __absolute INT8S tempIndexHys
tempIndexHys:
        DC8 0
        DC8 0, 0, 0
// __absolute INT8S TempAttn[(enum <unnamed>)12U]
TempAttn:
        DC8 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
//   14 
//   15 #include <stdlib.h>
//   16 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   17 void ExpioInit(void)
//   18 {
ExpioInit:
        PUSH     {R7,LR}
//   19 	ExpioBitSet(PWR_LED);
        MOVS     R0,#+37
        BL       ExpioBitSet
//   20 	ExpioBitRst(ALM_LED);
        MOVS     R0,#+39
        BL       ExpioBitRst
//   21 	TimerRegist(TimerRunLed, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+6
        BL       TimerRegist
//   22 	
//   23 	ExpioPortInit();
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.W    R1,??DataTable5
        STR      R0,[R1, #+0]
//   24 
//   25 	OSTaskCreate(ExpioTask, (void *)NULL, (OS_STK *)&ExpioTaskStk[EXPIO_START_STK_SIZE - 1], EXPIO_START_PRIO);
        MOVS     R3,#+2
        LDR.W    R2,??DataTable5_1
        MOVS     R1,#+0
        LDR.W    R0,??DataTable5_2
        POP      {R12,LR}
        B.W      OSTaskCreate
//   26 
//   27 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 void ExpioPortInit(void)
//   29 {
ExpioPortInit:
        PUSH     {R7,LR}
//   30 	#ifndef __FSMC_SRAM_H
//   31 		////////////////////////////////////////////////////////////////////////////
//   32 		// 반드시 gpio init 에서 --> outputmode로 변경해야 한다...
//   33 		// select 한핀은 반드시 모두다 high로 만들어줘야 한다.
//   34 		//GPIOC->ODR.Bit.ODR6 = 1;	// CS0
//   35 		//GPIOE->ODR.Bit.ODR10 = 1; // CS1
//   36 		/***
//   37 		GPIOB->ODR.Bit.ODR9 = 1;	// CS2
//   38 		GPIOB->ODR.Bit.ODR12 = 1;	// CS3
//   39 		GPIOB->ODR.Bit.ODR13 = 1;	// CS4
//   40 		GPIOB->ODR.Bit.ODR14 = 1;	// CS5
//   41 		GPIOB->ODR.Bit.ODR15 = 1;	// CS6
//   42 		GPIOC->ODR.Bit.ODR14 = 1;	// CS7
//   43 		GPIOC->ODR.Bit.ODR15 = 1;	// CS8
//   44 		GPIOA->ODR.Bit.ODR11 = 1;	// CS9
//   45 		GPIOA->ODR.Bit.ODR12 = 1;	// CS10
//   46 	***/
//   47 	#endif //__FSMC_SRAM_H
//   48 	ExpioSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.W    R1,??DataTable5
        STR      R0,[R1, #+0]
//   49 }
        POP      {R0,PC}          ;; return
//   50 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   51 void ExpioTask(void *p_arg)
//   52 {
ExpioTask:
        PUSH     {R3-R5,LR}
//   53 	INT8U	Flag = 0;
        MOVS     R4,#+0
//   54 	
//   55 	(void)p_arg;
//   56 
//   57 	////////////////////////////////
//   58 	OSTimeDly(200*EXPIO_START_PRIO);
        MOV      R0,#+400
        BL       OSTimeDly
        LDR.W    R5,??DataTable5_3
        B.N      ??ExpioTask_0
//   59 
//   60 	//SerPtr->printf("addr 0x05 = %02x \n", WriteEEprom(0x05, 0x27));
//   61 	
//   62 	while(1)
//   63 	{
//   64 		//while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
//   65 		while(!tTestFlag)
//   66 		{
//   67 			StatustoIO();
//   68 			StatusUpdate();
//   69 
//   70 			if(TimeOverCheck(TimerRunLed))
//   71 			{
//   72 				if(Flag) 	ExpioBitSet(RUN_LED);
//   73 				else		ExpioBitRst(RUN_LED);
??ExpioTask_1:
        MOVS     R0,#+38
        BL       ExpioBitRst
//   74 				Flag ^= 1;
??ExpioTask_2:
        EOR      R4,R4,#0x1
//   75 				TimerRegist(TimerRunLed, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+6
        BL       TimerRegist
//   76 			}
//   77 			OSTimeDly(50L);
??ExpioTask_3:
        MOVS     R0,#+50
??ExpioTask_4:
        BL       OSTimeDly
??ExpioTask_0:
        LDRB     R0,[R5, #+0]
        CBNZ.N   R0,??ExpioTask_5
        BL       StatustoIO
        BL       StatusUpdate
        MOVS     R0,#+6
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.N    ??ExpioTask_3
        UXTB     R0,R4
        CMP      R0,#+0
        BEQ.N    ??ExpioTask_1
        MOVS     R0,#+38
        BL       ExpioBitSet
        B.N      ??ExpioTask_2
//   78 		}
//   79 
//   80 		OSTimeDly(250L);
??ExpioTask_5:
        MOVS     R0,#+250
        B.N      ??ExpioTask_4
//   81 	}
//   82 }
//   83 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 void StatusUpdate(void)
//   85 {
StatusUpdate:
        PUSH     {R4}
//   86 	// System
//   87 	if(DC_IN_ALM_CS)		MuStatus->MuAlm.DcIn_Alarm = _Alarm;
        LDR.W    R0,??DataTable5_4
        LDR      R2,[R0, #+0]
        LDR.W    R1,??DataTable5_5  ;; 0x40021810
        LDR      R3,[R1, #+0]
        LSLS     R3,R3,#+24
        LDRB     R3,[R2, #+599]
        ITE      MI 
        ORRMI    R3,R3,#0x1
        ANDPL    R3,R3,#0xFE
//   88 	else					MuStatus->MuAlm.DcIn_Alarm = _Normal;
        STRB     R3,[R2, #+599]
//   89 	
//   90 	if(DC_OUT_ALM_CS)		MuStatus->MuAlm.DcOut_Alarm = _Alarm;
        LDR      R2,[R0, #+0]
        LDR      R3,[R1, #+0]
        LSLS     R3,R3,#+23
        LDRB     R3,[R2, #+599]
        ITE      MI 
        ORRMI    R3,R3,#0x2
        ANDPL    R3,R3,#0xFD
//   91 	else					MuStatus->MuAlm.DcOut_Alarm = _Normal;
        STRB     R3,[R2, #+599]
//   92 
//   93 	if(FAN1_ALM_CS) 		MuStatus->MuAlm.Fan_Alarm = _Alarm;
        LDR      R2,[R0, #+0]
        LDR      R1,[R1, #+0]
        LSLS     R1,R1,#+25
        LDRB     R1,[R2, #+599]
        ITE      MI 
        ORRMI    R1,R1,#0x4
        ANDPL    R1,R1,#0xFB
//   94 	else					MuStatus->MuAlm.Fan_Alarm = _Normal;
        STRB     R1,[R2, #+599]
//   95 	
//   96 /*
//   97 	if(DC_ALM_21G_CS)		MuStatus->MuAlm.DcIn_Alarm = _Alarm;
//   98 	else					MuStatus->MuAlm.DcIn_Alarm = _Normal;
//   99 
//  100 	if(DC_ALM_900M_CS)		MuStatus->MuAlm.DcIn_Alarm = _Alarm;
//  101 	else					MuStatus->MuAlm.DcIn_Alarm = _Normal;
//  102 
//  103 	if(DC_ALM_25G_CS)		MuStatus->MuAlm.DcIn_Alarm = _Alarm;
//  104 	else					MuStatus->MuAlm.DcIn_Alarm = _Normal;
//  105 */
//  106 
//  107 	// Insert
//  108 	if(INSERT_21G_CS)
        LDR      R1,[R0, #+0]
        LDR.W    R2,??DataTable5_6  ;; 0x40021010
        LDR      R3,[R2, #+0]
        LSLS     R3,R3,#+27
        ITE      MI 
        MOVMI    R3,#+1
        MOVPL    R3,#+0
//  109 	{
//  110 		MuStatus->MrfuSts[S_21G_PATH].Install = _Install;
//  111 		MuStatus->MrfuSts[M_21G_PATH].Install = _Install;
//  112 	}
//  113 	else
//  114 	{
//  115 		MuStatus->MrfuSts[S_21G_PATH].Install = _NotInstall;
        STRB     R3,[R1, #+736]
//  116 		MuStatus->MrfuSts[M_21G_PATH].Install = _NotInstall;
        LDR      R1,[R0, #+0]
        STRB     R3,[R1, #+753]
//  117 	}
//  118 
//  119 	if(INSERT_900M_CS)
        LDR      R1,[R0, #+0]
        LDR      R3,[R2, #+0]
        LSLS     R3,R3,#+26
        ITE      MI 
        MOVMI    R3,#+1
        MOVPL    R3,#+0
//  120 	{
//  121 		MuStatus->MrfuSts[S_900M_PATH].Install = _Install;
//  122 		MuStatus->MrfuSts[M_900M_PATH].Install = _Install;
//  123 	}
//  124 	else
//  125 	{
//  126 		MuStatus->MrfuSts[S_900M_PATH].Install = _NotInstall;
        STRB     R3,[R1, #+770]
//  127 		MuStatus->MrfuSts[M_900M_PATH].Install = _NotInstall;
        LDR      R1,[R0, #+0]
        STRB     R3,[R1, #+787]
//  128 	}
//  129 
//  130 	if(INSERT_25G_CS)
        LDR      R1,[R2, #+0]
        LSLS     R1,R1,#+28
        LDR      R1,[R0, #+0]
        ITE      MI 
        MOVMI    R3,#+1
        MOVPL    R3,#+0
//  131 	{
//  132 		MuStatus->MrfuSts[S_25G_PATH].Install = _Install;
//  133 		MuStatus->MrfuSts[M_25G_PATH].Install = _Install;
//  134 	}
//  135 	else
//  136 	{
//  137 		MuStatus->MrfuSts[S_25G_PATH].Install = _NotInstall;
        STRB     R3,[R1, #+804]
//  138 		MuStatus->MrfuSts[M_25G_PATH].Install = _NotInstall;
        LDR      R1,[R0, #+0]
        STRB     R3,[R1, #+821]
//  139 	}
//  140 
//  141 	// DTU
//  142 	//#define DTU_BD_CS 		GPIOG->__B.IDR.B10
//  143 
//  144 	// PLL
//  145 	if(DL_PLL_LD_21G_CS)
        LDR      R3,[R0, #+0]
        LDR.W    R1,??DataTable5_7  ;; 0x40020410
        LDR      R4,[R1, #+0]
        LSLS     R4,R4,#+18
        LDRB     R4,[R3, #+737]
        BPL.N    ??StatusUpdate_0
//  146 	{
//  147 		MuStatus->MrfuSts[S_21G_PATH].Alarm.DL_Pll = _Alarm;
        ORR      R4,R4,#0x1
        STRB     R4,[R3, #+737]
//  148 		MuStatus->MrfuSts[M_21G_PATH].Alarm.DL_Pll = _Alarm;
        LDR      R3,[R0, #+0]
        LDRB     R4,[R3, #+754]
        ORR      R4,R4,#0x1
        B.N      ??StatusUpdate_1
//  149 	}
//  150 	else
//  151 	{
//  152 		MuStatus->MrfuSts[S_21G_PATH].Alarm.DL_Pll = _Normal;
??StatusUpdate_0:
        AND      R4,R4,#0xFE
        STRB     R4,[R3, #+737]
//  153 		MuStatus->MrfuSts[M_21G_PATH].Alarm.DL_Pll = _Normal;
        LDR      R3,[R0, #+0]
        LDRB     R4,[R3, #+754]
        AND      R4,R4,#0xFE
??StatusUpdate_1:
        STRB     R4,[R3, #+754]
//  154 	}
//  155 
//  156 	if(DL_PLL_LD_900M_CS)
        LDR      R3,[R0, #+0]
        LDR      R4,[R1, #+0]
        LSLS     R4,R4,#+16
        LDRB     R4,[R3, #+771]
        BPL.N    ??StatusUpdate_2
//  157 	{
//  158 		MuStatus->MrfuSts[S_900M_PATH].Alarm.DL_Pll = _Alarm;
        ORR      R4,R4,#0x1
        STRB     R4,[R3, #+771]
//  159 		MuStatus->MrfuSts[M_900M_PATH].Alarm.DL_Pll = _Alarm;
        LDR      R3,[R0, #+0]
        LDRB     R4,[R3, #+788]
        ORR      R4,R4,#0x1
        B.N      ??StatusUpdate_3
//  160 	}
//  161 	else
//  162 	{
//  163 		MuStatus->MrfuSts[S_900M_PATH].Alarm.DL_Pll = _Normal;
??StatusUpdate_2:
        AND      R4,R4,#0xFE
        STRB     R4,[R3, #+771]
//  164 		MuStatus->MrfuSts[M_900M_PATH].Alarm.DL_Pll = _Normal;
        LDR      R3,[R0, #+0]
        LDRB     R4,[R3, #+788]
        AND      R4,R4,#0xFE
??StatusUpdate_3:
        STRB     R4,[R3, #+788]
//  165 	}
//  166 
//  167 	if(DL_PLL_LD_25G_CS)
        LDR      R3,[R0, #+0]
        LDR      R2,[R2, #+0]
        LSLS     R2,R2,#+17
        LDRB     R2,[R3, #+805]
        BPL.N    ??StatusUpdate_4
//  168 	{
//  169 		MuStatus->MrfuSts[S_25G_PATH].Alarm.DL_Pll = _Alarm;
        ORR      R2,R2,#0x1
        STRB     R2,[R3, #+805]
//  170 		MuStatus->MrfuSts[M_25G_PATH].Alarm.DL_Pll = _Alarm;
        LDR      R2,[R0, #+0]
        LDRB     R3,[R2, #+822]
        ORR      R3,R3,#0x1
        B.N      ??StatusUpdate_5
//  171 	}
//  172 	else
//  173 	{
//  174 		MuStatus->MrfuSts[S_25G_PATH].Alarm.DL_Pll = _Normal;
??StatusUpdate_4:
        AND      R2,R2,#0xFE
        STRB     R2,[R3, #+805]
//  175 		MuStatus->MrfuSts[M_25G_PATH].Alarm.DL_Pll = _Normal;
        LDR      R2,[R0, #+0]
        LDRB     R3,[R2, #+822]
        AND      R3,R3,#0xFE
??StatusUpdate_5:
        STRB     R3,[R2, #+822]
//  176 	}
//  177 
//  178 	if(UL_PLL_LD_21G_CS)
        LDR      R2,[R0, #+0]
        LDR      R3,[R1, #+0]
        LSLS     R3,R3,#+19
        LDRB     R3,[R2, #+737]
        BPL.N    ??StatusUpdate_6
//  179 	{
//  180 		MuStatus->MrfuSts[S_21G_PATH].Alarm.UL_Pll = _Alarm;
        ORR      R3,R3,#0x2
        STRB     R3,[R2, #+737]
//  181 		MuStatus->MrfuSts[M_21G_PATH].Alarm.UL_Pll = _Alarm;
        LDR      R2,[R0, #+0]
        LDRB     R3,[R2, #+754]
        ORR      R3,R3,#0x2
        B.N      ??StatusUpdate_7
//  182 	}
//  183 	else
//  184 	{
//  185 		MuStatus->MrfuSts[S_21G_PATH].Alarm.UL_Pll = _Normal;
??StatusUpdate_6:
        AND      R3,R3,#0xFD
        STRB     R3,[R2, #+737]
//  186 		MuStatus->MrfuSts[M_21G_PATH].Alarm.UL_Pll = _Normal;
        LDR      R2,[R0, #+0]
        LDRB     R3,[R2, #+754]
        AND      R3,R3,#0xFD
??StatusUpdate_7:
        STRB     R3,[R2, #+754]
//  187 	}
//  188 
//  189 	if(UL_PLL_LD_900M_CS)
        LDR      R2,[R0, #+0]
        LDR      R1,[R1, #+0]
        LSLS     R1,R1,#+17
        LDRB     R1,[R2, #+771]
        BPL.N    ??StatusUpdate_8
//  190 	{
//  191 		MuStatus->MrfuSts[S_900M_PATH].Alarm.UL_Pll = _Alarm;
        ORR      R1,R1,#0x2
        STRB     R1,[R2, #+771]
//  192 		MuStatus->MrfuSts[M_900M_PATH].Alarm.UL_Pll = _Alarm;
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+788]
        ORR      R2,R2,#0x2
        B.N      ??StatusUpdate_9
//  193 	}
//  194 	else
//  195 	{
//  196 		MuStatus->MrfuSts[S_900M_PATH].Alarm.UL_Pll = _Normal;
??StatusUpdate_8:
        AND      R1,R1,#0xFD
        STRB     R1,[R2, #+771]
//  197 		MuStatus->MrfuSts[M_900M_PATH].Alarm.UL_Pll = _Normal;
        LDR      R1,[R0, #+0]
        LDRB     R2,[R1, #+788]
        AND      R2,R2,#0xFD
??StatusUpdate_9:
        STRB     R2,[R1, #+788]
//  198 	}
//  199 
//  200 	if(UL_PLL_LD_25G_CS)
        LDR      R1,[R0, #+0]
        LDR.W    R2,??DataTable5_8  ;; 0x40020c10
        LDR      R2,[R2, #+0]
        LSLS     R2,R2,#+23
        LDRB     R2,[R1, #+805]
        BPL.N    ??StatusUpdate_10
//  201 	{
//  202 		MuStatus->MrfuSts[S_25G_PATH].Alarm.UL_Pll = _Alarm;
        ORR      R2,R2,#0x2
        STRB     R2,[R1, #+805]
//  203 		MuStatus->MrfuSts[M_25G_PATH].Alarm.UL_Pll = _Alarm;
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+822]
        ORR      R1,R1,#0x2
        B.N      ??StatusUpdate_11
//  204 	}
//  205 	else
//  206 	{
//  207 		MuStatus->MrfuSts[S_25G_PATH].Alarm.UL_Pll = _Normal;
??StatusUpdate_10:
        AND      R2,R2,#0xFD
        STRB     R2,[R1, #+805]
//  208 		MuStatus->MrfuSts[M_25G_PATH].Alarm.UL_Pll = _Normal;
        LDR      R0,[R0, #+0]
        LDRB     R1,[R0, #+822]
        AND      R1,R1,#0xFD
??StatusUpdate_11:
        STRB     R1,[R0, #+822]
//  209 	}
//  210 
//  211 }
        POP      {R4}
        BX       LR               ;; return
//  212 
//  213 
//  214 ////////////////////////////////////////////////////////////////////////////////

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  215 void StatustoIO(void)
//  216 {
StatustoIO:
        PUSH     {R4-R6,LR}
//  217 	INT8U	i = 0;
//  218 	INT8S	AttnOut = 0;
//  219 	INT8U	tindex = 0;
//  220 
//  221 	//-----------------------------------------------------------------------//
//  222 	// Power On
//  223 	if(MuStatus->MrfuSts[S_21G_PATH].Install == _ON)	PWR_ON_21G_CS = 1;
        LDR.N    R4,??DataTable5_4
        LDR      R0,[R4, #+0]
        LDR.N    R1,??DataTable5_9  ;; 0x40020814
        LDRB     R2,[R0, #+736]
        CMP      R2,#+1
        LDR      R2,[R1, #+0]
        ITTE     EQ 
        MOVEQ    R3,#+256
        ORREQ    R2,R3,R2
        BICNE    R2,R2,#0x100
//  224 	else												PWR_ON_21G_CS = 0;
        STR      R2,[R1, #+0]
//  225 
//  226 	if(MuStatus->MrfuSts[S_900M_PATH].Install == _ON)	PWR_ON_900M_CS = 1;
        LDRB     R2,[R0, #+770]
        CMP      R2,#+1
        LDR      R2,[R1, #+0]
        ITTE     EQ 
        MOVEQ    R3,#+512
        ORREQ    R2,R3,R2
        BICNE    R2,R2,#0x200
//  227 	else												PWR_ON_900M_CS = 0;
        STR      R2,[R1, #+0]
//  228 
//  229 	if(MuStatus->MrfuSts[S_25G_PATH].Install == _ON)	PWR_ON_25G_CS = 1;
        LDR.N    R1,??DataTable5_10  ;; 0x40020014
        LDRB     R2,[R0, #+804]
        CMP      R2,#+1
        LDR      R2,[R1, #+0]
        ITTE     EQ 
        MOVEQ    R3,#+256
        ORREQ    R2,R3,R2
        BICNE    R2,R2,#0x100
//  230 	else												PWR_ON_25G_CS = 0;
        STR      R2,[R1, #+0]
//  231 	
//  232 	//-----------------------------------------------------------------------//
//  233 	// Amp On/Off
//  234 	if(MuStatus->MrfuSts[S_21G_PATH].UL_Amp_OnOff == _ON)	ExpioBitSet(Amp_OnOff_S_21G_Sel);
        LDRB     R0,[R0, #+748]
        CMP      R0,#+1
        BNE.N    ??StatustoIO_0
        MOVS     R0,#+66
        BL       ExpioBitSet
        B.N      ??StatustoIO_1
//  235 	else													ExpioBitRst(Amp_OnOff_S_21G_Sel);
??StatustoIO_0:
        MOVS     R0,#+66
        BL       ExpioBitRst
//  236 
//  237 	if(MuStatus->MrfuSts[M_21G_PATH].UL_Amp_OnOff == _ON)	ExpioBitSet(Amp_OnOff_M_21G_Sel);
??StatustoIO_1:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+765]
        CMP      R0,#+1
        BNE.N    ??StatustoIO_2
        MOVS     R0,#+64
        BL       ExpioBitSet
        B.N      ??StatustoIO_3
//  238 	else													ExpioBitRst(Amp_OnOff_M_21G_Sel);
??StatustoIO_2:
        MOVS     R0,#+64
        BL       ExpioBitRst
//  239 
//  240 	if(MuStatus->MrfuSts[S_900M_PATH].UL_Amp_OnOff == _ON)	ExpioBitSet(Amp_OnOff_S_900M_Sel);
??StatustoIO_3:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+782]
        CMP      R0,#+1
        BNE.N    ??StatustoIO_4
        MOVS     R0,#+67
        BL       ExpioBitSet
        B.N      ??StatustoIO_5
//  241 	else													ExpioBitRst(Amp_OnOff_S_900M_Sel);
??StatustoIO_4:
        MOVS     R0,#+67
        BL       ExpioBitRst
//  242 
//  243 	if(MuStatus->MrfuSts[M_900M_PATH].UL_Amp_OnOff == _ON)	ExpioBitSet(Amp_OnOff_M_900M_Sel);
??StatustoIO_5:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+799]
        CMP      R0,#+1
        BNE.N    ??StatustoIO_6
        MOVS     R0,#+65
        BL       ExpioBitSet
        B.N      ??StatustoIO_7
//  244 	else													ExpioBitRst(Amp_OnOff_M_900M_Sel);
??StatustoIO_6:
        MOVS     R0,#+65
        BL       ExpioBitRst
//  245 
//  246 	if(MuStatus->MrfuSts[S_25G_PATH].UL_Amp_OnOff == _ON)	ExpioBitSet(Amp_OnOff_S_25G_Sel);
??StatustoIO_7:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+816]
        CMP      R0,#+1
        BNE.N    ??StatustoIO_8
        MOVS     R0,#+69
        BL       ExpioBitSet
        B.N      ??StatustoIO_9
//  247 	else													ExpioBitRst(Amp_OnOff_S_25G_Sel);
??StatustoIO_8:
        MOVS     R0,#+69
        BL       ExpioBitRst
//  248 
//  249 	if(MuStatus->MrfuSts[M_25G_PATH].UL_Amp_OnOff == _ON)	ExpioBitSet(Amp_OnOff_M_25G_Sel);
??StatustoIO_9:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+833]
        CMP      R0,#+1
        BNE.N    ??StatustoIO_10
        MOVS     R0,#+68
        BL       ExpioBitSet
        B.N      ??StatustoIO_11
//  250 	else													ExpioBitRst(Amp_OnOff_M_25G_Sel);
??StatustoIO_10:
        MOVS     R0,#+68
        BL       ExpioBitRst
//  251 
//  252 	//-----------------------------------------------------------------------//
//  253 	// Temp Attn
//  254 	if(MuStatus->TempCompOnOff == _ON)
??StatustoIO_11:
        LDR      R0,[R4, #+0]
        LDR.N    R5,??DataTable5_11
        LDRB     R1,[R0, #+607]
        CMP      R1,#+1
        BNE.N    ??StatustoIO_12
//  255 	{
//  256 		if(MuStatus->EnvTemp >= tempIndexHys)			tempIndexHys = MuStatus->EnvTemp;
        LDRSB    R0,[R0, #+601]
        LDRSB    R1,[R5, #+12]
        CMP      R0,R1
        BLT.N    ??StatustoIO_13
??StatustoIO_14:
        STRB     R0,[R5, #+12]
        B.N      ??StatustoIO_15
//  257 		else if(MuStatus->EnvTemp < (tempIndexHys - 1)) tempIndexHys = MuStatus->EnvTemp;
??StatustoIO_13:
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BGE.N    ??StatustoIO_15
        B.N      ??StatustoIO_14
//  258 /*
//  259 		tindex = TemptoIndex(tempIndexHys);
//  260 
//  261 		TempAttn[DL_S_21G_PATH] = vEE_TABLE->TempTable[Local_DL_S_21G_Temp].Data[tindex];
//  262 		TempAttn[UL_S_21G_PATH] = vEE_TABLE->TempTable[Local_UL_S_21G_Temp].Data[tindex];
//  263 		TempAttn[DL_M_21G_PATH] = vEE_TABLE->TempTable[Local_DL_M_21G_Temp].Data[tindex];
//  264 		TempAttn[UL_M_21G_PATH] = vEE_TABLE->TempTable[Local_UL_M_21G_Temp].Data[tindex];
//  265 
//  266 		TempAttn[DL_S_900M_PATH] = vEE_TABLE->TempTable[Local_DL_S_900M_Temp].Data[tindex];
//  267 		TempAttn[UL_S_900M_PATH] = vEE_TABLE->TempTable[Local_UL_S_900M_Temp].Data[tindex];
//  268 		TempAttn[DL_M_900M_PATH] = vEE_TABLE->TempTable[Local_DL_M_900M_Temp].Data[tindex];
//  269 		TempAttn[UL_M_900M_PATH] = vEE_TABLE->TempTable[Local_UL_M_900M_Temp].Data[tindex];
//  270 
//  271 		TempAttn[DL_S_25G_PATH] = vEE_TABLE->TempTable[Local_DL_S_25G_Temp].Data[tindex];
//  272 		TempAttn[UL_S_25G_PATH] = vEE_TABLE->TempTable[Local_UL_S_25G_Temp].Data[tindex];
//  273 		TempAttn[DL_M_25G_PATH] = vEE_TABLE->TempTable[Local_DL_M_25G_Temp].Data[tindex];
//  274 		TempAttn[UL_M_25G_PATH] = vEE_TABLE->TempTable[Local_UL_M_25G_Temp].Data[tindex];
//  275 */
//  276 	}
//  277 	else
//  278 	{
//  279 		for(i=0; i<ATTN_PATH_MAX; i++)
//  280 			TempAttn[i] = 0;
??StatustoIO_12:
        ADD      R0,R5,#+16
        MOVS     R1,#+0
        MOVS     R2,#+0
        MOV      R3,R1
        STM      R0!,{R1-R3}
//  281 	}
//  282 
//  283 	//-----------------------------------------------------------------------//
//  284 	// 21G Attn
//  285 	tindex = MuStatus->MrfuSts[S_21G_PATH].DL_Attn;
//  286 	AttnOut = tindex*2+ MuStatus->MrfuOffset[S_21G_PATH].DL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_DL_S_21G_Attn].Data[tindex];// + MuStatus->MrfuSts[S_21G_PATH].DL_Attn;
??StatustoIO_15:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+741]
        LDRSB    R0,[R0, #+892]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  287 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  288 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  289 	if(PreAttn[DL_S_21G_PATH] != AttnOut)
        LDRB     R0,[R5, #+0]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_16
//  290 	{
//  291 		HMC624AttnOut(AttnOut, DL_S_21G_PATH);
        MOVS     R1,#+0
        MOV      R0,R6
        BL       HMC624AttnOut
//  292 		PreAttn[DL_S_21G_PATH] = AttnOut;
        STRB     R6,[R5, #+0]
//  293 	}
//  294 
//  295 	tindex = MuStatus->MrfuSts[S_21G_PATH].UL_Attn;
//  296 	AttnOut = tindex*2+ MuStatus->MrfuOffset[S_21G_PATH].UL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_UL_S_21G_Attn].Data[tindex];// + MuStatus->MrfuSts[S_21G_PATH].UL_Attn;
??StatustoIO_16:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+745]
        LDRSB    R0,[R0, #+893]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  297 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  298 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  299 	if(PreAttn[UL_S_21G_PATH] != AttnOut)
        LDRB     R0,[R5, #+1]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_17
//  300 	{
//  301 		HMC624AttnOut(AttnOut, UL_S_21G_PATH);
        MOVS     R1,#+1
        MOV      R0,R6
        BL       HMC624AttnOut
//  302 		PreAttn[UL_S_21G_PATH] = AttnOut;
        STRB     R6,[R5, #+1]
//  303 	}
//  304 
//  305 	tindex = MuStatus->MrfuSts[M_21G_PATH].DL_Attn;
//  306 	AttnOut = tindex*2+ MuStatus->MrfuOffset[M_21G_PATH].DL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_DL_M_21G_Attn].Data[tindex];// + MuStatus->MrfuSts[M_21G_PATH].DL_Attn;
??StatustoIO_17:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+758]
        LDRSB    R0,[R0, #+902]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  307 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  308 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  309 	if(PreAttn[DL_M_21G_PATH] != AttnOut)
        LDRB     R0,[R5, #+2]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_18
//  310 	{
//  311 		HMC624AttnOut(AttnOut, DL_M_21G_PATH);
        MOVS     R1,#+2
        MOV      R0,R6
        BL       HMC624AttnOut
//  312 		PreAttn[DL_M_21G_PATH] = AttnOut;
        STRB     R6,[R5, #+2]
//  313 	}
//  314 
//  315 	tindex = MuStatus->MrfuSts[M_21G_PATH].UL_Attn;
//  316 	AttnOut = tindex*2+ MuStatus->MrfuOffset[M_21G_PATH].UL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_UL_M_21G_Attn].Data[tindex];// + MuStatus->MrfuSts[M_21G_PATH].UL_Attn;
??StatustoIO_18:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+762]
        LDRSB    R0,[R0, #+903]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  317 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  318 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  319 	if(PreAttn[UL_M_21G_PATH] != AttnOut)
        LDRB     R0,[R5, #+3]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_19
//  320 	{
//  321 		HMC624AttnOut(AttnOut, UL_M_21G_PATH);
        MOVS     R1,#+3
        MOV      R0,R6
        BL       HMC624AttnOut
//  322 		PreAttn[UL_M_21G_PATH] = AttnOut;
        STRB     R6,[R5, #+3]
//  323 	}
//  324 
//  325 	
//  326 	//-----------------------------------------------------------------------//
//  327 	// 900M Attn
//  328 	tindex = MuStatus->MrfuSts[S_900M_PATH].DL_Attn;
//  329 	AttnOut = tindex*2+ MuStatus->MrfuOffset[S_900M_PATH].DL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_DL_S_900M_Attn].Data[tindex];// + MuStatus->MrfuSts[S_900M_PATH].DL_Attn;
??StatustoIO_19:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+775]
        LDRSB    R0,[R0, #+912]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  330 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  331 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  332 	if(PreAttn[DL_S_900M_PATH] != AttnOut)
        LDRB     R0,[R5, #+4]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_20
//  333 	{
//  334 		HMC624AttnOut(AttnOut, DL_S_900M_PATH);
        MOVS     R1,#+4
        MOV      R0,R6
        BL       HMC624AttnOut
//  335 		PreAttn[DL_S_900M_PATH] = AttnOut;
        STRB     R6,[R5, #+4]
//  336 	}
//  337 
//  338 	tindex = MuStatus->MrfuSts[S_900M_PATH].UL_Attn;
//  339 	AttnOut = tindex*2+ MuStatus->MrfuOffset[S_900M_PATH].UL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_UL_S_900M_Attn].Data[tindex];// + MuStatus->MrfuSts[S_900M_PATH].UL_Attn;
??StatustoIO_20:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+779]
        LDRSB    R0,[R0, #+913]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  340 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  341 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  342 	if(PreAttn[UL_S_900M_PATH] != AttnOut)
        LDRB     R0,[R5, #+5]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_21
//  343 	{
//  344 		HMC624AttnOut(AttnOut, UL_S_900M_PATH);
        MOVS     R1,#+5
        MOV      R0,R6
        BL       HMC624AttnOut
//  345 		PreAttn[UL_S_900M_PATH] = AttnOut;
        STRB     R6,[R5, #+5]
//  346 	}
//  347 
//  348 	tindex = MuStatus->MrfuSts[M_900M_PATH].DL_Attn;
//  349 	AttnOut = tindex*2+ MuStatus->MrfuOffset[M_900M_PATH].DL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_DL_M_900M_Attn].Data[tindex];// + MuStatus->MrfuSts[M_900M_PATH].DL_Attn;
??StatustoIO_21:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+792]
        LDRSB    R0,[R0, #+922]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  350 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  351 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  352 	if(PreAttn[DL_M_900M_PATH] != AttnOut)
        LDRB     R0,[R5, #+6]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_22
//  353 	{
//  354 		HMC624AttnOut(AttnOut, DL_M_900M_PATH);
        MOVS     R1,#+6
        MOV      R0,R6
        BL       HMC624AttnOut
//  355 		PreAttn[DL_M_900M_PATH] = AttnOut;
        STRB     R6,[R5, #+6]
//  356 	}
//  357 
//  358 	tindex = MuStatus->MrfuSts[M_900M_PATH].UL_Attn;
//  359 	AttnOut = tindex*2+ MuStatus->MrfuOffset[M_900M_PATH].DL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_UL_M_900M_Attn].Data[tindex];// + MuStatus->MrfuSts[M_900M_PATH].UL_Attn;
??StatustoIO_22:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+796]
        LDRSB    R0,[R0, #+922]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  360 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  361 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  362 	if(PreAttn[UL_M_900M_PATH] != AttnOut)
        LDRB     R0,[R5, #+7]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_23
//  363 	{
//  364 		HMC624AttnOut(AttnOut, UL_M_900M_PATH);
        MOVS     R1,#+7
        MOV      R0,R6
        BL       HMC624AttnOut
//  365 		PreAttn[UL_M_900M_PATH] = AttnOut;
        STRB     R6,[R5, #+7]
//  366 	}
//  367 
//  368 	
//  369 	//-----------------------------------------------------------------------//
//  370 	// 25G Attn
//  371 	tindex = MuStatus->MrfuSts[S_25G_PATH].DL_Attn;
//  372 	AttnOut = tindex*2+ MuStatus->MrfuOffset[S_25G_PATH].DL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_DL_S_25G_Attn].Data[tindex];// + MuStatus->MrfuSts[S_25G_PATH].DL_Attn;
??StatustoIO_23:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+809]
        LDRSB    R0,[R0, #+932]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  373 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  374 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  375 	if(PreAttn[DL_S_25G_PATH] != AttnOut)
        LDRB     R0,[R5, #+8]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_24
//  376 	{
//  377 		HMC624AttnOut(AttnOut, DL_S_25G_PATH);
        MOVS     R1,#+8
        MOV      R0,R6
        BL       HMC624AttnOut
//  378 		PreAttn[DL_S_25G_PATH] = AttnOut;
        STRB     R6,[R5, #+8]
//  379 	}
//  380 
//  381 	tindex = MuStatus->MrfuSts[S_25G_PATH].UL_Attn;
//  382 	AttnOut = tindex*2+ MuStatus->MrfuOffset[S_25G_PATH].UL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_UL_S_25G_Attn].Data[tindex];// + MuStatus->MrfuSts[S_25G_PATH].UL_Attn;
??StatustoIO_24:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+813]
        LDRSB    R0,[R0, #+933]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  383 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  384 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  385 	if(PreAttn[UL_S_25G_PATH] != AttnOut)
        LDRB     R0,[R5, #+9]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_25
//  386 	{
//  387 		HMC624AttnOut(AttnOut, UL_S_25G_PATH);
        MOVS     R1,#+9
        MOV      R0,R6
        BL       HMC624AttnOut
//  388 		PreAttn[UL_S_25G_PATH] = AttnOut;
        STRB     R6,[R5, #+9]
//  389 	}
//  390 
//  391 	tindex = MuStatus->MrfuSts[M_25G_PATH].DL_Attn;
//  392 	AttnOut = tindex*2+ MuStatus->MrfuOffset[M_25G_PATH].DL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_DL_M_25G_Attn].Data[tindex];// + MuStatus->MrfuSts[M_25G_PATH].DL_Attn;
??StatustoIO_25:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+826]
        LDRSB    R0,[R0, #+942]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  393 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R6,#+6,R0
//  394 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  395 	if(PreAttn[DL_M_25G_PATH] != AttnOut)
        LDRB     R0,[R5, #+10]
        CMP      R0,R6
        BEQ.N    ??StatustoIO_26
//  396 	{
//  397 		HMC624AttnOut(AttnOut, DL_M_25G_PATH);
        MOVS     R1,#+10
        MOV      R0,R6
        BL       HMC624AttnOut
//  398 		PreAttn[DL_M_25G_PATH] = AttnOut;
        STRB     R6,[R5, #+10]
//  399 	}
//  400 
//  401 	tindex = MuStatus->MrfuSts[M_25G_PATH].UL_Attn;
//  402 	AttnOut = tindex*2+ MuStatus->MrfuOffset[M_25G_PATH].UL_Attn;//(INT8S)vEE_TABLE->AttnTable[Local_UL_M_25G_Attn].Data[tindex];// + MuStatus->MrfuSts[M_25G_PATH].UL_Attn;
??StatustoIO_26:
        LDR      R0,[R4, #+0]
        LDRSB    R1,[R0, #+830]
        LDRSB    R0,[R0, #+943]
        ADD      R0,R0,R1, LSL #+1
        SXTB     R0,R0
//  403 	if(AttnOut < ATTN_MIN)	AttnOut = ATTN_MIN;
        USAT     R4,#+6,R0
//  404 	if(AttnOut > ATTN_MAX)	AttnOut = ATTN_MAX;
//  405 	if(PreAttn[UL_M_25G_PATH] != AttnOut)
        LDRB     R0,[R5, #+11]
        CMP      R0,R4
        BEQ.N    ??StatustoIO_27
//  406 	{
//  407 		HMC624AttnOut(AttnOut, UL_M_25G_PATH);
        MOVS     R1,#+11
        MOV      R0,R4
        BL       HMC624AttnOut
//  408 		PreAttn[UL_M_25G_PATH] = AttnOut;
        STRB     R4,[R5, #+11]
//  409 	}
//  410 }
??StatustoIO_27:
        POP      {R4-R6,PC}       ;; return
//  411 
//  412 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  413 INT8U MaxAttnCheck(INT16S cAttn, INT16S tMax)
//  414 {
//  415 	INT8U retval = cAttn;
MaxAttnCheck:
        MOV      R2,R0
//  416 	
//  417 	if(cAttn > tMax)
        CMP      R1,R0
        IT       LT 
        MOVLT    R2,R1
//  418 	{
//  419 		retval = tMax;
        BLT.N    ??MaxAttnCheck_0
//  420 	}
//  421 	else if(cAttn < 0)
        CMP      R0,#+0
        IT       MI 
        MOVMI    R2,#+0
//  422 	{
//  423 		retval = 0;
//  424 	}
//  425 
//  426 	return retval;
??MaxAttnCheck_0:
        UXTB     R0,R2
        BX       LR               ;; return
//  427 }
//  428 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  429 void HMC624AttnOut(INT8U AttVal, INT8U Path)
//  430 {
HMC624AttnOut:
        PUSH     {R3-R7,LR}
        MOV      R6,R0
        MOV      R4,R1
//  431 	INT8S	i = 0;
//  432 
//  433 	ATTN_CLK_CS = SET;
        LDR.N    R5,??DataTable5_12  ;; 0x40021014
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x1000
        STR      R0,[R5, #+0]
//  434 	ForDelay(50);
        MOVS     R0,#+50
        BL       ForDelay
//  435 	AttnEn_Out(DISABLE, Path);
        MOV      R1,R4
        MOVS     R0,#+0
        BL       AttnEn_Out
//  436 	ForDelay(50);
        MOVS     R0,#+50
        BL       ForDelay
//  437 	
//  438 	for(i = 5; i >= 0; i--)
        MOVS     R7,#+5
//  439 	{
//  440 		ATTN_CLK_CS = RESET;
??HMC624AttnOut_0:
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0x1000
        STR      R0,[R5, #+0]
//  441 		ForDelay(50);
        MOVS     R0,#+50
        BL       ForDelay
//  442 		if((AttVal >> i) & 0x1) {ATTN_DATA_CS = RESET;}
        ASR      R0,R6,R7
        LSLS     R0,R0,#+31
        LDR      R0,[R5, #+0]
        ITE      MI 
        BICMI    R0,R0,#0x2000
        ORRPL    R0,R0,#0x2000
//  443 		else					{ATTN_DATA_CS = SET;}
        STR      R0,[R5, #+0]
//  444 		ForDelay(50);
        MOVS     R0,#+50
        BL       ForDelay
//  445 		ATTN_CLK_CS = SET;
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x1000
        STR      R0,[R5, #+0]
//  446 		ForDelay(50);
        MOVS     R0,#+50
        BL       ForDelay
//  447 	}
        SUBS     R7,R7,#+1
        SXTB     R7,R7
        CMP      R7,#+0
        BPL.N    ??HMC624AttnOut_0
//  448 	// Enable Set
//  449 	AttnEn_Out(SET_STS, Path);
        MOV      R1,R4
        MOVS     R0,#+1
        BL       AttnEn_Out
//  450 	ForDelay(50);
        MOVS     R0,#+50
        BL       ForDelay
//  451 	AttnEn_Out(RST_STS, Path);
        MOV      R1,R4
        MOVS     R0,#+0
        BL       AttnEn_Out
//  452 	ForDelay(50);
        MOVS     R0,#+50
        POP      {R1,R4-R7,LR}
        B.W      ForDelay
//  453 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     ExpioSem

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     ExpioTaskStk+0x5FC

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     ExpioTask

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     tTestFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     MuStatus

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     0x40021810

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     0x40021010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0x40020410

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     0x40020c10

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     0x40020814

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     0x40020014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     PreAttn

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     0x40021014
//  454 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  455 void AttnEn_Out(INT8U OutSts, INT8U Path)
//  456 {
//  457 	INT16U	AttEn;
//  458 
//  459 	switch(Path)
AttnEn_Out:
        CMP      R1,#+11
        BHI.N    ??AttnEn_Out_1
        TBB      [PC, R1]
        DATA
??AttnEn_Out_0:
        DC8      0x6,0x8,0xA,0xC
        DC8      0xE,0x10,0x12,0x14
        DC8      0x16,0x18,0x1A,0x1C
        THUMB
//  460 	{
//  461 		case DL_S_21G_PATH: 	AttEn = DL_Attn_En_S_21G_Sel;		break;
??AttnEn_Out_2:
        MOVS     R2,#+6
        B.N      ??AttnEn_Out_1
//  462 		case UL_S_21G_PATH: 	AttEn = UL_Attn_En_S_21G_Sel;		break;
??AttnEn_Out_3:
        MOVS     R2,#+4
        B.N      ??AttnEn_Out_1
//  463 		case DL_M_21G_PATH: 	AttEn = DL_Attn_En_M_21G_Sel;		break;
??AttnEn_Out_4:
        MOVS     R2,#+2
        B.N      ??AttnEn_Out_1
//  464 		case UL_M_21G_PATH: 	AttEn = UL_Attn_En_M_21G_Sel;		break;
??AttnEn_Out_5:
        MOVS     R2,#+0
        B.N      ??AttnEn_Out_1
//  465 
//  466 		case DL_S_900M_PATH:	AttEn = DL_Attn_En_S_900M_Sel;		break;
??AttnEn_Out_6:
        MOVS     R2,#+7
        B.N      ??AttnEn_Out_1
//  467 		case UL_S_900M_PATH:	AttEn = UL_Attn_En_S_900M_Sel;		break;
??AttnEn_Out_7:
        MOVS     R2,#+5
        B.N      ??AttnEn_Out_1
//  468 		case DL_M_900M_PATH:	AttEn = DL_Attn_En_M_900M_Sel;		break;
??AttnEn_Out_8:
        MOVS     R2,#+3
        B.N      ??AttnEn_Out_1
//  469 		case UL_M_900M_PATH:	AttEn = UL_Attn_En_M_900M_Sel;		break;
??AttnEn_Out_9:
        MOVS     R2,#+1
        B.N      ??AttnEn_Out_1
//  470 
//  471 		case DL_S_25G_PATH: 	AttEn = DL_Attn_En_S_25G_Sel;		break;
??AttnEn_Out_10:
        MOVS     R2,#+35
        B.N      ??AttnEn_Out_1
//  472 		case UL_S_25G_PATH: 	AttEn = UL_Attn_En_S_25G_Sel;		break;
??AttnEn_Out_11:
        MOVS     R2,#+34
        B.N      ??AttnEn_Out_1
//  473 		case DL_M_25G_PATH: 	AttEn = DL_Attn_En_M_25G_Sel;		break;
??AttnEn_Out_12:
        MOVS     R2,#+33
        B.N      ??AttnEn_Out_1
//  474 		case UL_M_25G_PATH: 	AttEn = UL_Attn_En_M_25G_Sel;		break;
??AttnEn_Out_13:
        MOVS     R2,#+32
//  475 	}
//  476 
//  477 	if(OutSts == SET_STS)	ExpioBitSet(AttEn);
??AttnEn_Out_1:
        CMP      R0,#+1
        UXTH     R0,R2
        BNE.N    ??AttnEn_Out_14
        B.W      ExpioBitSet
//  478 	else					ExpioBitRst(AttEn);
??AttnEn_Out_14:
        B.W      ExpioBitRst
//  479 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  480 
//  481 
//  482 ///////////////////////////////////////////////////////////////////////////////
//  483 // End of Source File
//  484 ////////////////////////
// 
//     4 bytes in section .bss
//    28 bytes in section .data
// 1 628 bytes in section .text
// 1 536 bytes in section iram
// 
// 1 628 bytes of CODE memory
// 1 568 bytes of DATA memory
//
//Errors: none
//Warnings: none
