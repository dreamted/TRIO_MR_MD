///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    30/Aug/2012  21:29:27 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_test.c    /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_test.c    /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\aa_test.s    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_test

        #define SHT_PROGBITS 0x1

        EXTERN DownLoadBootingJump
        EXTERN DownloadFlagClr
        EXTERN ExpioBitRst
        EXTERN ExpioBitSet
        EXTERN ForDelay
        EXTERN HMC624AttnOut
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN ReadEEprom
        EXTERN SerPtr
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN WriteEEprom
        EXTERN iUser_Value2
        EXTERN strcpy
        EXTERN strlen

        PUBLIC AdInputStatus
        PUBLIC AdcPrintf
        PUBLIC COMTestFunc
        PUBLIC CurrentInputStatus
        PUBLIC DigitalInputDiplay
        PUBLIC HwTestOutFunc
        PUBLIC KeyProc
        PUBLIC OnCommand
        PUBLIC PrevData
        PUBLIC PrevRDCnt
        PUBLIC PrevWRCnt
        PUBLIC PrintLogo
        PUBLIC PrintStar
        PUBLIC PromptOut
        PUBLIC SysPath
        PUBLIC TestInit
        PUBLIC TestTask
        PUBLIC WaringMssageReturn
        PUBLIC dCycle
        PUBLIC dGetHex
        PUBLIC htob
        PUBLIC returnmsgTest
        PUBLIC tDisplay
        PUBLIC tIndex
        PUBLIC tRevData
        PUBLIC tTestFlag
        PUBLIC testResult
        PUBLIC tinputSts
        PUBLIC tinputStsOld
        PUBLIC `vstr`
        PUBLIC vstrval

// D:\Work\Project\2012\NL_INBUILD\FW\MU\code\aa_test.c
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
//   11 #define TEST_C
//   12 
//   13 #include "../include/main.h"

        SECTION iram:DATA:REORDER:NOROOT(2)
// static __absolute OS_STK TestTaskStk[256]
TestTaskStk:
        DS8 1024

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute char tIndex
tIndex:
        DS8 1
// __absolute INT8S PrevWRCnt
PrevWRCnt:
        DS8 1
// __absolute INT8S PrevRDCnt
PrevRDCnt:
        DS8 1
        DS8 1
// __absolute INT8U PrevData[5][30]
PrevData:
        DS8 152

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute INT8U tRevData[30]
tRevData:
        DS8 32

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
// __absolute INT8U tTestFlag
tTestFlag:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
// __absolute INT8U SysPath
SysPath:
        DS8 1

        SECTION `.data`:DATA:REORDER:NOROOT(2)
// __absolute unsigned char const *testResult[4]
testResult:
        DATA
        DC32 `?<Constant "NON TESTED">`, `?<Constant "    TESTED">`
        DC32 `?<Constant "NON TESTED">`, `?<Constant "NON TESTED">`

        SECTION `.data`:DATA:REORDER:NOROOT(2)
// __absolute _inputStsStr tinputSts
tinputSts:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __absolute _inputStsStr tinputStsOld
tinputStsOld:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __absolute char const *tDisplay[8]
tDisplay:
        DC32 `?<Constant "GPO0   :">`, `?<Constant "GPO1   :">`
        DC32 `?<Constant "GPO2   :">`, `?<Constant "GPO3   :">`
        DC32 `?<Constant "GPO4   :">`, `?<Constant "GPO5   :">`
        DC32 `?<Constant "GPO6   :">`, `?<Constant "GPO7   :">`
//   14 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   15 void TestInit(void)
//   16 {
//   17 	
//   18 	OSTaskCreate(TestTask, (void *)NULL, (OS_STK *)&TestTaskStk[TEST_START_STK_SIZE - 1], TEST_START_PRIO);
TestInit:
        MOVS     R3,#+7
        LDR.W    R2,??DataTable70_5
        MOVS     R1,#+0
        LDR.W    R0,??DataTable70_6
        B.W      OSTaskCreate
//   19 }
//   20 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   21 void TestTask(void *p_arg)
//   22 {
TestTask:
        PUSH     {R3-R7,LR}
//   23 	INT16U nCnt = 0;
//   24 	nCnt = nCnt;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//   25 	p_arg = p_arg;
//   26 
//   27 
//   28 	tTestFlag = FALSE;
        LDR.W    R4,??DataTable70_7
        STRB     R0,[R4, #+0]
//   29 	
//   30 	OSTimeDly(TEST_START_PRIO*100L);
        MOV      R0,#+700
        BL       OSTimeDly
        LDR.W    R5,??DataTable70_8
        LDR.W    R6,??DataTable70_9
        LDR.W    R7,??DataTable70_10
//   31 	
//   32 	while(1)
//   33 	{
//   34 		if(iUser_Value2 == __ChangeDebug)
??TestTask_0:
        LDRB     R0,[R7, #+0]
        CMP      R0,#+13
        BNE.N    ??TestTask_0
//   35 		{
//   36 			PrintLogo();
        BL       PrintLogo
//   37 			PromptOut();
        BL       PromptOut
//   38 			tTestFlag = TRUE;
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
//   39 	
//   40 			while(iUser_Value2 == __ChangeDebug)
        LDRB     R0,[R7, #+0]
        CMP      R0,#+13
        BNE.N    ??TestTask_0
//   41 			//while(1)
//   42 			{
//   43 				if(SerPtr->CheckByte(1, &nCnt))
??TestTask_1:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R6, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CBZ.N    R0,??TestTask_2
//   44 				{
//   45 					KeyProc(SerPtr->RxGetByte(), OnCommand);
        LDR      R0,[R6, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        MOV      R1,R5
        UXTB     R0,R0
        BL       KeyProc
//   46 				}
//   47 
//   48 				OSTimeDly(10L);
??TestTask_2:
        MOVS     R0,#+10
        BL       OSTimeDly
//   49 				
//   50 				if(TimeOverCheck(Timer_DebugCnt))
        MOVS     R0,#+5
        BL       TimeOverCheck
        LDRB     R0,[R7, #+0]
        CMP      R0,#+13
        BEQ.N    ??TestTask_1
        B.N      ??TestTask_0
//   51 				{
//   52 					//DownLoadBootingJump();
//   53 				}
//   54 			}
//   55 		}
//   56 	}
//   57 }
//   58 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   59 void KeyProc( char sbuf, void (*func)(void))
//   60 {
KeyProc:
        PUSH     {R4-R8,LR}
        MOV      R4,R1
//   61 	INT16U nSize = sizeof(tRevData);
//   62 
//   63 	tRevData[tIndex%nSize] = sbuf;
        LDR.W    R5,??DataTable70_11
        LDRB     R1,[R5, #+0]
        MOV      R8,#+30
        SDIV     R2,R1,R8
        RSB      R3,R2,R2, LSL #+4
        SUB      R2,R1,R3, LSL #+1
        LDR.W    R7,??DataTable70_12
        STRB     R0,[R2, R7]
//   64 	if( tRevData[tIndex%nSize] == 0x0D )			// Enter 입력
        CMP      R0,#+13
        BNE.N    ??KeyProc_0
//   65 	{
//   66 		SerPtr->PutToBuffer('\r');
        LDR.W    R6,??DataTable70_9
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   67 		SerPtr->PutToBuffer('\n');
        MOVS     R0,#+10
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   68 		tRevData[tIndex%nSize] = '\0';
        LDRB     R0,[R5, #+0]
        SDIV     R1,R0,R8
        RSB      R2,R1,R1, LSL #+4
        SUB      R1,R0,R2, LSL #+1
        MOVS     R2,#+0
        STRB     R2,[R1, R7]
//   69 
//   70 		if(tIndex != 0)
        CBZ.N    R0,??KeyProc_1
//   71 		{
//   72 			strcpy((char *)PrevData[PrevWRCnt++], (const char *)tRevData);
        LDRSB    R0,[R5, #+1]
        ADDS     R1,R0,#+1
        STRB     R1,[R5, #+1]
        MOV      R1,R7
        RSB      R2,R0,R0, LSL #+4
        ADD      R0,R5,R2, LSL #+1
        ADDS     R0,R0,#+4
        BL       strcpy
//   73 			PrevWRCnt %= 5;
        LDRSB    R0,[R5, #+1]
        MOVS     R1,#+5
        SDIV     R1,R0,R1
        ADD      R1,R1,R1, LSL #+2
        SUBS     R0,R0,R1
        STRB     R0,[R5, #+1]
//   74 		}
//   75 		PrevRDCnt = PrevWRCnt;
??KeyProc_1:
        LDRB     R0,[R5, #+1]
        STRB     R0,[R5, #+2]
//   76 		func();
        BLX      R4
//   77 		tIndex = 0;
        B.N      ??KeyProc_2
//   78 
//   79 		return;
//   80 	}
//   81 	else if( tRevData[tIndex%nSize] == 0x08 )		// Back Space
??KeyProc_0:
        CMP      R0,#+8
        BNE.N    ??KeyProc_3
//   82 	{
//   83 		if (tIndex == 0)
        CMP      R1,#+0
        BEQ.N    ??KeyProc_4
//   84 			return;
//   85 
//   86 		SerPtr->PutToBuffer(0x08);
        LDR.W    R4,??DataTable70_9
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   87 		SerPtr->PutToBuffer(' ');
        MOVS     R0,#+32
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   88 		SerPtr->PutToBuffer(0x08);
        MOVS     R0,#+8
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   89 		tIndex--;
        LDRB     R0,[R5, #+0]
        SUBS     R0,R0,#+1
        B.N      ??KeyProc_5
//   90 
//   91 		return;
//   92 	}
//   93 	else if( tRevData[tIndex%nSize] == 0x09 )		// tab
??KeyProc_3:
        CMP      R0,#+9
        BNE.N    ??KeyProc_6
//   94 	{
//   95 		while(tIndex)
        CMP      R1,#+0
        LDR.W    R4,??DataTable70_9
        BEQ.N    ??KeyProc_7
//   96 		{
//   97 			SerPtr->PutToBuffer(0x08);
??KeyProc_8:
        MOVS     R0,#+8
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   98 			SerPtr->PutToBuffer(' ');
        MOVS     R0,#+32
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   99 			SerPtr->PutToBuffer(0x08);
        MOVS     R0,#+8
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//  100 			tIndex--;
        LDRB     R0,[R5, #+0]
        SUBS     R0,R0,#+1
        STRB     R0,[R5, #+0]
        UXTB     R0,R0
        CMP      R0,#+0
        BNE.N    ??KeyProc_8
//  101 		}
//  102 
//  103 		PrevRDCnt--;
??KeyProc_7:
        LDRB     R0,[R5, #+2]
        SUBS     R0,R0,#+1
        STRB     R0,[R5, #+2]
//  104 		if(PrevRDCnt < 0) PrevRDCnt = 4;
        SXTB     R0,R0
        CMP      R0,#+0
        ITT      MI 
        MOVMI    R0,#+4
        STRBMI   R0,[R5, #+2]
//  105 		strcpy((char *)tRevData, (const char *)PrevData[PrevRDCnt]);
        LDRSB    R0,[R5, #+2]
        RSB      R1,R0,R0, LSL #+4
        ADD      R0,R5,R1, LSL #+1
        ADDS     R1,R0,#+4
        MOV      R0,R7
        BL       strcpy
//  106 
//  107 		SerPtr->printf("%s", PrevData[PrevRDCnt]);
        LDRSB    R0,[R5, #+2]
        RSB      R1,R0,R0, LSL #+4
        ADD      R0,R5,R1, LSL #+1
        ADDS     R1,R0,#+4
        ADR.N    R0,??DataTable64  ;; 0x25, 0x73, 0x00, 0x00
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  108 		tIndex = strlen((const char *)PrevData[PrevRDCnt]);
        LDRSB    R0,[R5, #+2]
        RSB      R1,R0,R0, LSL #+4
        ADD      R0,R5,R1, LSL #+1
        ADDS     R0,R0,#+4
        BL       strlen
        B.N      ??KeyProc_5
//  109 
//  110 		return;
//  111 	}
//  112 	
//  113 	SerPtr->PutToBuffer(tRevData[tIndex%nSize]);			// 입력 키 출력
??KeyProc_6:
        LDR.W    R1,??DataTable70_9
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//  114 
//  115 	if(++tIndex >= nSize) tIndex = 0;
        LDRB     R0,[R5, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R5, #+0]
        UXTB     R0,R0
        CMP      R0,#+30
        BCC.N    ??KeyProc_4
??KeyProc_2:
        MOVS     R0,#+0
??KeyProc_5:
        STRB     R0,[R5, #+0]
??KeyProc_4:
        POP      {R4-R8,PC}       ;; return
//  116 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable64:
        DC8      0x25, 0x73, 0x00, 0x00
//  117 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  118 INT8U htob(INT8U hex)
//  119 {
//  120 	INT8U i;
//  121 	
//  122 	if (hex >= '0' && hex <= '9') i=hex-'0';
htob:
        SUB      R1,R0,#+48
        UXTB     R1,R1
        CMP      R1,#+10
        BCC.N    ??htob_0
//  123 	else if ( hex >= 'A' && hex <= 'F' )i=hex-'A'+10;
        SUB      R1,R0,#+65
        UXTB     R1,R1
        CMP      R1,#+6
        ITE      CC 
        SUBCC    R1,R0,#+55
        SUBCS    R1,R0,#+87
//  124 	else i=hex-'a'+10;
//  125 	
//  126 	return i;
??htob_0:
        UXTB     R0,R1
        BX       LR               ;; return
//  127 }
//  128 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  129 INT8U dGetHex (INT8U Data_H, INT8U Data_L)
//  130 {
dGetHex:
        PUSH     {R3-R5,LR}
        MOV      R4,R1
//  131 	INT8U i;
//  132 	
//  133 	i=htob( Data_H );
        BL       htob
        MOV      R5,R0
//  134 	i=htob( Data_L )+(i<<4);
//  135 	return i;
        MOV      R0,R4
        BL       htob
        ADD      R0,R0,R5, LSL #+4
        UXTB     R0,R0
        POP      {R1,R4,R5,PC}    ;; return
//  136 }
//  137 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  138 void OnCommand ( void )
//  139 {
OnCommand:
        PUSH     {R4-R6,LR}
//  140 	INT8U	tdata = TRUE;
//  141 	INT8U	DebugAdd;
//  142 	INT8S	DebugData;
//  143 	
//  144    	switch(tRevData[0])
        LDR.W    R5,??DataTable70_12
        LDRB     R0,[R5, #+0]
        CMP      R0,#+63
        BEQ.W    ??OnCommand_0
        CMP      R0,#+65
        BEQ.W    ??OnCommand_1
        CMP      R0,#+71
        BEQ.W    ??OnCommand_2
        CMP      R0,#+77
        BEQ.W    ??OnCommand_3
        CMP      R0,#+80
        BEQ.N    ??OnCommand_4
        CMP      R0,#+82
        BEQ.W    ??OnCommand_5
        CMP      R0,#+83
        BEQ.N    ??OnCommand_6
        CMP      R0,#+87
        BEQ.W    ??OnCommand_7
        CMP      R0,#+97
        BEQ.W    ??OnCommand_1
        CMP      R0,#+103
        BEQ.W    ??OnCommand_2
        CMP      R0,#+109
        BEQ.N    ??OnCommand_3
        CMP      R0,#+112
        BEQ.N    ??OnCommand_4
        CMP      R0,#+114
        BEQ.W    ??OnCommand_5
        CMP      R0,#+115
        BEQ.N    ??OnCommand_6
        CMP      R0,#+119
        BEQ.W    ??OnCommand_7
        B.N      ??OnCommand_8
//  145    	{
//  146    		case 'P':
//  147 		case 'p':
//  148 			if(tRevData[1] == '1')
??OnCommand_4:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+49
        BNE.N    ??OnCommand_9
//  149 			{
//  150 				SerPtr->printf("\n 2.1G PATH..........\n");
        ADR.W    R0,`?<Constant "\\n 2.1G PATH..........\\n">`
        LDR.W    R1,??DataTable70_9
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  151 				SysPath = 0;
        LDR.W    R0,??DataTable70_13
        MOVS     R1,#+0
??OnCommand_10:
        STRB     R1,[R0, #+0]
        B.N      ??OnCommand_8
//  152 			}
//  153 			else if(tRevData[1] == '2')
??OnCommand_9:
        CMP      R0,#+50
        BNE.N    ??OnCommand_11
//  154 			{
//  155 				SerPtr->printf("\n 900M PATH..........\n");
        ADR.W    R0,`?<Constant "\\n 900M PATH..........\\n">`
        LDR.W    R1,??DataTable70_9
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  156 				SysPath = 1;
        LDR.W    R0,??DataTable70_13
        MOVS     R1,#+1
        B.N      ??OnCommand_10
//  157 			}
//  158 			else if(tRevData[1] == '3')
??OnCommand_11:
        CMP      R0,#+51
        BNE.W    ??OnCommand_8
//  159 			{
//  160 				SerPtr->printf("\n 2.5G PATH..........\n");
        ADR.W    R0,`?<Constant "\\n 2.5G PATH..........\\n">`
        LDR.W    R1,??DataTable70_9
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  161 				SysPath = 2;
        LDR.W    R0,??DataTable70_13
        MOVS     R1,#+2
        B.N      ??OnCommand_10
//  162 			}
//  163 			break;
//  164 			
//  165 		case 'S':
//  166 		case 's':
//  167 			if((tRevData[1] == 'O')||(tRevData[1] == 'o'))
??OnCommand_6:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+79
        BEQ.N    ??OnCommand_12
        CMP      R0,#+111
        BNE.N    ??OnCommand_13
//  168 			{
//  169 				if(SysPath==0)
??OnCommand_12:
        LDR.W    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.W    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_14
//  170 				{
//  171 					SerPtr->printf("\n 2.1G SISO AMP ON(High)...\n");
        ADR.W    R0,`?<Constant "\\n 2.1G SISO AMP ON(Hi...">`
        BLX      R2
//  172 					ExpioBitSet(Amp_OnOff_S_21G_Sel);
        MOVS     R0,#+66
??OnCommand_15:
        BL       ExpioBitSet
        B.N      ??OnCommand_8
//  173 				}
//  174 				else if(SysPath==1)
??OnCommand_14:
        CMP      R0,#+1
        BNE.N    ??OnCommand_16
//  175 				{
//  176 					SerPtr->printf("\n 900M SISO AMP ON(High)...\n");
        ADR.W    R0,`?<Constant "\\n 900M SISO AMP ON(Hi...">`
        BLX      R2
//  177 					ExpioBitSet(Amp_OnOff_S_900M_Sel);
        MOVS     R0,#+67
        B.N      ??OnCommand_15
//  178 				}
//  179 				else
//  180 				{
//  181 					SerPtr->printf("\n 2.5G SISO AMP ON(High)...\n");
??OnCommand_16:
        ADR.W    R0,`?<Constant "\\n 2.5G SISO AMP ON(Hi...">`
        BLX      R2
//  182 					ExpioBitSet(Amp_OnOff_S_25G_Sel);
        MOVS     R0,#+69
        B.N      ??OnCommand_15
//  183 				}
//  184 			}
//  185 			else if((tRevData[1] == 'F')||(tRevData[1] == 'f'))
??OnCommand_13:
        CMP      R0,#+70
        BEQ.N    ??OnCommand_17
        CMP      R0,#+102
        BNE.W    ??OnCommand_8
//  186 			{
//  187 				if(SysPath==0)
??OnCommand_17:
        LDR.W    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.W    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_18
//  188 				{
//  189 					SerPtr->printf("\n 2.1G SISO AMP OFF(Low)...\n");
        ADR.W    R0,`?<Constant "\\n 2.1G SISO AMP OFF(L...">`
        BLX      R2
//  190 					ExpioBitRst(Amp_OnOff_S_21G_Sel);
        MOVS     R0,#+66
??OnCommand_19:
        BL       ExpioBitRst
        B.N      ??OnCommand_8
//  191 				}
//  192 				else if(SysPath==1)
??OnCommand_18:
        CMP      R0,#+1
        BNE.N    ??OnCommand_20
//  193 				{
//  194 					SerPtr->printf("\n 900M SISO AMP OFF(Low)...\n");
        ADR.W    R0,`?<Constant "\\n 900M SISO AMP OFF(L...">`
        BLX      R2
//  195 					ExpioBitRst(Amp_OnOff_S_900M_Sel);
        MOVS     R0,#+67
        B.N      ??OnCommand_19
//  196 				}
//  197 				else
//  198 				{
//  199 					SerPtr->printf("\n 2.1G SISO AMP OFF(Low)...\n");
??OnCommand_20:
        ADR.W    R0,`?<Constant "\\n 2.1G SISO AMP OFF(L...">`
        BLX      R2
//  200 					ExpioBitRst(Amp_OnOff_S_25G_Sel);
        MOVS     R0,#+69
        B.N      ??OnCommand_19
//  201 				}
//  202 			}
//  203 		break;
//  204 
//  205 		case 'M':
//  206 		case 'm':
//  207 			if((tRevData[1] == 'O')||(tRevData[1] == 'o'))
??OnCommand_3:
        LDRB     R0,[R5, #+1]
        CMP      R0,#+79
        BEQ.N    ??OnCommand_21
        CMP      R0,#+111
        BNE.N    ??OnCommand_22
//  208 			{
//  209 				if(SysPath==0)
??OnCommand_21:
        LDR.W    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.W    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_23
//  210 				{
//  211 					SerPtr->printf("\n 2.1G MIMO AMP ON(High)...\n");
        ADR.W    R0,`?<Constant "\\n 2.1G MIMO AMP ON(Hi...">`
        BLX      R2
//  212 					ExpioBitSet(Amp_OnOff_M_21G_Sel);
        MOVS     R0,#+64
        B.N      ??OnCommand_15
//  213 				}
//  214 				else if(SysPath==1)
??OnCommand_23:
        CMP      R0,#+1
        BNE.N    ??OnCommand_24
//  215 				{
//  216 					SerPtr->printf("\n 900M MIMO AMP ON(High)...\n");
        ADR.W    R0,`?<Constant "\\n 900M MIMO AMP ON(Hi...">`
        BLX      R2
//  217 					ExpioBitSet(Amp_OnOff_M_900M_Sel);
        MOVS     R0,#+65
        B.N      ??OnCommand_15
//  218 				}
//  219 				else
//  220 				{
//  221 					SerPtr->printf("\n 2.5G MIMO AMP ON(High)...\n");
??OnCommand_24:
        ADR.W    R0,`?<Constant "\\n 2.5G MIMO AMP ON(Hi...">`
        BLX      R2
//  222 					ExpioBitSet(Amp_OnOff_M_25G_Sel);
        MOVS     R0,#+68
        B.N      ??OnCommand_15
//  223 				}
//  224 			}
//  225 			else if((tRevData[1] == 'F')||(tRevData[1] == 'f'))
??OnCommand_22:
        CMP      R0,#+70
        BEQ.N    ??OnCommand_25
        CMP      R0,#+102
        BNE.W    ??OnCommand_8
//  226 			{
//  227 				if(SysPath==0)
??OnCommand_25:
        LDR.W    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.W    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_26
//  228 				{
//  229 					SerPtr->printf("\n 2.1G MIMO AMP OFF(Low)...\n");
        ADR.W    R0,`?<Constant "\\n 2.1G MIMO AMP OFF(L...">`
        BLX      R2
//  230 					ExpioBitRst(Amp_OnOff_M_21G_Sel);
        MOVS     R0,#+64
        B.N      ??OnCommand_19
//  231 				}
//  232 				else if(SysPath==1)
??OnCommand_26:
        CMP      R0,#+1
        BNE.N    ??OnCommand_27
//  233 				{
//  234 					SerPtr->printf("\n 900M MIMO AMP OFF(Low)...\n");
        ADR.W    R0,`?<Constant "\\n 900M MIMO AMP OFF(L...">`
        BLX      R2
//  235 					ExpioBitRst(Amp_OnOff_M_900M_Sel);
        MOVS     R0,#+65
        B.N      ??OnCommand_19
//  236 				}
//  237 				else
//  238 				{
//  239 					SerPtr->printf("\n 2.1G MIMO AMP OFF(Low)...\n");
??OnCommand_27:
        ADR.W    R0,`?<Constant "\\n 2.1G MIMO AMP OFF(L...">`
        BLX      R2
//  240 					ExpioBitRst(Amp_OnOff_M_25G_Sel);
        MOVS     R0,#+68
        B.N      ??OnCommand_19
//  241 				}
//  242 			}
//  243 		break;
//  244 
//  245 		case 'A':
//  246 		case 'a':
//  247 			DebugData =	((tRevData[3]-0x30)*10)+(tRevData[4]-0x30);
??OnCommand_1:
        LDRSB    R0,[R5, #+3]
        ADD      R1,R0,R0, LSL #+2
        LDRSB    R0,[R5, #+4]
        ADD      R0,R0,R1, LSL #+1
        SUBS     R0,R0,#+16
        SXTB     R0,R0
//  248 			if(DebugData < 0)	DebugData = 0;
        USAT     R4,#+6,R0
//  249 			if(DebugData > 63)	DebugData = 63;
//  250 			
//  251 			if((tRevData[1] == 'T')||(tRevData[1] == 't'))
        LDRB     R0,[R5, #+1]
        CMP      R0,#+84
        BEQ.N    ??OnCommand_28
        CMP      R0,#+116
        BNE.N    ??OnCommand_29
//  252 			{
//  253 				if((tRevData[2] == 'S')||(tRevData[2] == 's'))
??OnCommand_28:
        LDRB     R0,[R5, #+2]
        CMP      R0,#+83
        BEQ.N    ??OnCommand_30
        CMP      R0,#+115
        BNE.N    ??OnCommand_31
//  254 				{
//  255 					if(SysPath==0)
??OnCommand_30:
        LDR.W    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.W    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_32
//  256 					{
//  257 						SerPtr->printf("\n 2.1G SISO TX Attn = %d\n", DebugData);
        MOV      R1,R4
        ADR.W    R0,`?<Constant "\\n 2.1G SISO TX Attn =...">`
        BLX      R2
//  258 						HMC624AttnOut(DebugData, DL_S_21G_PATH);
        MOVS     R1,#+0
??OnCommand_33:
        MOV      R0,R4
        BL       HMC624AttnOut
        B.N      ??OnCommand_8
//  259 					}
//  260 					else if(SysPath==1)
??OnCommand_32:
        CMP      R0,#+1
        MOV      R1,R4
        BNE.N    ??OnCommand_34
//  261 					{
//  262 						SerPtr->printf("\n 900M SISO TX Attn = %d\n", DebugData);
        ADR.W    R0,`?<Constant "\\n 900M SISO TX Attn =...">`
        BLX      R2
//  263 						HMC624AttnOut(DebugData, DL_S_900M_PATH);
        MOVS     R1,#+4
        B.N      ??OnCommand_33
//  264 					}
//  265 					else
//  266 					{
//  267 						SerPtr->printf("\n 2.5G SISO TX Attn = %d\n", DebugData);
??OnCommand_34:
        ADR.W    R0,`?<Constant "\\n 2.5G SISO TX Attn =...">`
        BLX      R2
//  268 						HMC624AttnOut(DebugData, DL_S_25G_PATH);
        MOVS     R1,#+8
        B.N      ??OnCommand_33
//  269 					}
//  270 				}
//  271 				else if((tRevData[2] == 'M')||(tRevData[2] == 'm'))
??OnCommand_31:
        CMP      R0,#+77
        BEQ.N    ??OnCommand_35
        CMP      R0,#+109
        BNE.W    ??OnCommand_8
//  272 				{
//  273 					if(SysPath==0)
??OnCommand_35:
        LDR.W    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.W    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_36
//  274 					{
//  275 						SerPtr->printf("\n 2.1G MIMO TX Attn = %d\n", DebugData);
        MOV      R1,R4
        ADR.W    R0,`?<Constant "\\n 2.1G MIMO TX Attn =...">`
        BLX      R2
//  276 						HMC624AttnOut(DebugData, DL_M_21G_PATH);
        MOVS     R1,#+2
        B.N      ??OnCommand_33
//  277 					}
//  278 					else if(SysPath==1)
??OnCommand_36:
        CMP      R0,#+1
        MOV      R1,R4
        BNE.N    ??OnCommand_37
//  279 					{
//  280 						SerPtr->printf("\n 900M MIMO TX Attn = %d\n", DebugData);
        ADR.W    R0,`?<Constant "\\n 900M MIMO TX Attn =...">`
        BLX      R2
//  281 						HMC624AttnOut(DebugData, DL_M_900M_PATH);
        MOVS     R1,#+6
        B.N      ??OnCommand_33
//  282 					}
//  283 					else
//  284 					{
//  285 						SerPtr->printf("\n 2.5G MIMO TX Attn = %d\n", DebugData);
??OnCommand_37:
        ADR.W    R0,`?<Constant "\\n 2.5G MIMO TX Attn =...">`
        BLX      R2
//  286 						HMC624AttnOut(DebugData, DL_M_25G_PATH);
        MOVS     R1,#+10
        B.N      ??OnCommand_33
//  287 					}
//  288 				}
//  289 			}
//  290 			else if((tRevData[1] == 'R')||(tRevData[1] == 'r'))
??OnCommand_29:
        CMP      R0,#+82
        BEQ.N    ??OnCommand_38
        CMP      R0,#+114
        BNE.N    ??OnCommand_8
//  291 			{
//  292 				if((tRevData[2] == 'S')||(tRevData[2] == 's'))
??OnCommand_38:
        LDRB     R0,[R5, #+2]
        CMP      R0,#+83
        BEQ.N    ??OnCommand_39
        CMP      R0,#+115
        BNE.N    ??OnCommand_40
//  293 				{
//  294 					if(SysPath==0)
??OnCommand_39:
        LDR.N    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.N    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_41
//  295 					{
//  296 						SerPtr->printf("\n 2.1G SISO RX Attn = %d\n", DebugData);
        MOV      R1,R4
        ADR.W    R0,`?<Constant "\\n 2.1G SISO RX Attn =...">`
        BLX      R2
//  297 						HMC624AttnOut(DebugData, UL_S_21G_PATH);
        MOVS     R1,#+1
        B.N      ??OnCommand_33
//  298 					}
//  299 					else if(SysPath==1)
??OnCommand_41:
        CMP      R0,#+1
        MOV      R1,R4
        BNE.N    ??OnCommand_42
//  300 					{
//  301 						SerPtr->printf("\n 900M SISO RX Attn = %d\n", DebugData);
        ADR.W    R0,`?<Constant "\\n 900M SISO RX Attn =...">`
        BLX      R2
//  302 						HMC624AttnOut(DebugData, UL_S_900M_PATH);
        MOVS     R1,#+5
        B.N      ??OnCommand_33
//  303 					}
//  304 					else
//  305 					{
//  306 						SerPtr->printf("\n 2.5G SISO RX Attn = %d\n", DebugData);
??OnCommand_42:
        ADR.W    R0,`?<Constant "\\n 2.5G SISO RX Attn =...">`
        BLX      R2
//  307 						HMC624AttnOut(DebugData, UL_S_25G_PATH);
        MOVS     R1,#+9
        B.N      ??OnCommand_33
//  308 					}
//  309 				}
//  310 				else if((tRevData[2] == 'M')||(tRevData[2] == 'm'))
??OnCommand_40:
        CMP      R0,#+77
        BEQ.N    ??OnCommand_43
        CMP      R0,#+109
        BNE.N    ??OnCommand_8
//  311 				{
//  312 					if(SysPath==0)
??OnCommand_43:
        LDR.N    R5,??DataTable70_9
        LDR      R0,[R5, #+0]
        LDR      R2,[R0, #+16]
        LDR.N    R0,??DataTable70_13
        LDRB     R0,[R0, #+0]
        CBNZ.N   R0,??OnCommand_44
//  313 					{
//  314 						SerPtr->printf("\n 2.1G MIMO RX Attn = %d\n", DebugData);
        MOV      R1,R4
        ADR.W    R0,`?<Constant "\\n 2.1G MIMO RX Attn =...">`
        BLX      R2
//  315 						HMC624AttnOut(DebugData, UL_M_21G_PATH);
        MOVS     R1,#+3
        B.N      ??OnCommand_33
//  316 					}
//  317 					else if(SysPath==1)
??OnCommand_44:
        CMP      R0,#+1
        MOV      R1,R4
        BNE.N    ??OnCommand_45
//  318 					{
//  319 						SerPtr->printf("\n 900M MIMO RX Attn = %d\n", DebugData);
        ADR.W    R0,`?<Constant "\\n 900M MIMO RX Attn =...">`
        BLX      R2
//  320 						HMC624AttnOut(DebugData, UL_M_900M_PATH);
        MOVS     R1,#+7
        B.N      ??OnCommand_33
//  321 					}
//  322 					else
//  323 					{
//  324 						SerPtr->printf("\n 2.5G MIMO RX Attn = %d\n", DebugData);
??OnCommand_45:
        ADR.W    R0,`?<Constant "\\n 2.5G MIMO RX Attn =...">`
        BLX      R2
//  325 						HMC624AttnOut(DebugData, UL_M_25G_PATH);
        MOVS     R1,#+11
        B.N      ??OnCommand_33
//  326 					}
//  327 				}
//  328 			}
//  329 		break;
//  330 
//  331 		case 'r':
//  332 		case 'R':
//  333 			
//  334 			DebugAdd	=	dGetHex(tRevData[3],tRevData[4]);
??OnCommand_5:
        LDRB     R1,[R5, #+4]
        LDRB     R0,[R5, #+3]
        BL       dGetHex
        MOV      R6,R0
//  335 			
//  336 			if(tRevData[1] == '1')
        LDRB     R0,[R5, #+1]
        CMP      R0,#+49
        BNE.N    ??OnCommand_8
//  337 			{
//  338 				SerPtr->printf("\n Eeprom 1 Read Address[%x] : [%x]\n", DebugAdd, ReadEEprom(DebugAdd));
        MOV      R0,R6
        BL       ReadEEprom
        MOV      R2,R0
        MOV      R1,R6
        ADR.W    R0,`?<Constant "\\n Eeprom 1 Read Addre...">`
        LDR.N    R3,??DataTable70_9
        LDR      R3,[R3, #+0]
??OnCommand_46:
        LDR      R3,[R3, #+16]
        BLX      R3
        B.N      ??OnCommand_8
//  339 			}
//  340 		break;
//  341 
//  342 		case 'w':
//  343 		case 'W':
//  344 			
//  345 			DebugAdd	=	dGetHex(tRevData[3],tRevData[4]);
??OnCommand_7:
        LDRB     R1,[R5, #+4]
        LDRB     R0,[R5, #+3]
        BL       dGetHex
        MOV      R6,R0
//  346 			DebugData	=	dGetHex(tRevData[6],tRevData[7]);
        LDRB     R1,[R5, #+7]
        LDRB     R0,[R5, #+6]
        BL       dGetHex
        SXTB     R4,R0
//  347 			
//  348 			if(tRevData[1] == '1')
        LDRB     R0,[R5, #+1]
        CMP      R0,#+49
        BNE.N    ??OnCommand_8
//  349 			{
//  350 				SerPtr->printf("\n Eeprom 1 Write Address[%x] -> [%x]\n", DebugAdd, DebugData);
        LDR.N    R5,??DataTable70_9
        MOV      R2,R4
        MOV      R1,R6
        ADR.W    R0,`?<Constant "\\n Eeprom 1 Write Addr...">`
        LDR      R3,[R5, #+0]
        LDR      R3,[R3, #+16]
        BLX      R3
//  351 				WriteEEprom(DebugAdd, DebugData);
        UXTB     R1,R4
        MOV      R0,R6
        BL       WriteEEprom
//  352 				SerPtr->printf(" Eeprom 1 Read Address[%x] : [%x]\n", DebugAdd, ReadEEprom(DebugAdd));
        MOV      R0,R6
        BL       ReadEEprom
        MOV      R2,R0
        MOV      R1,R6
        ADR.W    R0,`?<Constant " Eeprom 1 Read Addres...">`
        LDR      R3,[R5, #+0]
        B.N      ??OnCommand_46
//  353 			}
//  354 		break;
//  355 		
//  356 		case 'G':
//  357 		case 'g':
//  358 			DownloadFlagClr();
??OnCommand_2:
        BL       DownloadFlagClr
//  359 			ForDelay(20L);
        MOVS     R0,#+20
        BL       ForDelay
//  360 			DownLoadBootingJump();
        BL       DownLoadBootingJump
//  361 		break;
        B.N      ??OnCommand_8
//  362 
//  363 		case '?':
//  364 			PrintLogo();
??OnCommand_0:
        BL       PrintLogo
//  365 		break;
//  366 
//  367         default:
//  368 		break;
//  369 
//  370 	}
//  371 	PromptOut();
??OnCommand_8:
        POP      {R4-R6,LR}
        B.N      PromptOut
//  372 
//  373 }
//  374 
//  375 /*
//  376 void OnCommand ( void )
//  377 {
//  378 	INT8U	tdata = TRUE;
//  379 	INT8S	DebugData;
//  380 	
//  381    	switch(tRevData[0])
//  382    	{
//  383 		case 'S':
//  384 		case 's':
//  385 			if((tRevData[1] == 'O')||(tRevData[1] == 'o'))
//  386 			{
//  387 				SerPtr->printf("\n 2.1G SISO AMP ON(High)...\n");
//  388 				ExpioBitSet(Amp_OnOff_S_21G_Sel);
//  389 			}
//  390 			else if((tRevData[1] == 'F')||(tRevData[1] == 'f'))
//  391 			{
//  392 				SerPtr->printf("\n 2.1G SISO AMP OFF(Low)...\n");
//  393 				ExpioBitRst(Amp_OnOff_S_21G_Sel);
//  394 			}
//  395 		break;
//  396 
//  397 		case 'M':
//  398 		case 'm':
//  399 			if((tRevData[1] == 'O')||(tRevData[1] == 'o'))
//  400 			{
//  401 				SerPtr->printf("\n 2.1G MIMO AMP ON(High)...\n");
//  402 				ExpioBitSet(Amp_OnOff_M_21G_Sel);
//  403 			}
//  404 			else if((tRevData[1] == 'F')||(tRevData[1] == 'f'))
//  405 			{
//  406 				SerPtr->printf("\n 2.1G MIMO AMP OFF(Low)...\n");
//  407 				ExpioBitRst(Amp_OnOff_M_21G_Sel);
//  408 			}
//  409 		break;
//  410 
//  411 		case 'A':
//  412 		case 'a':
//  413 
//  414 		break;
//  415 		
//  416 		case 'G':
//  417 		case 'g':
//  418 			//DownloadFlagClr();
//  419 			ForDelay(20L);
//  420 			//DownLoadBootingJump();
//  421 		break;
//  422 
//  423 		case '?':
//  424 			PrintLogo();
//  425 		break;
//  426 
//  427         default:
//  428 		break;
//  429 
//  430 	}
//  431 	PromptOut();
//  432 
//  433 }
//  434 */
//  435 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  436 void AdInputStatus(void)
//  437 {
AdInputStatus:
        PUSH     {R7,LR}
//  438 ////////////////////////////////////////////////////////////////////////////////
//  439 	PrintStar();
        BL       PrintStar
//  440 	{
//  441 		INT16S Data, tmpx;
//  442 /*
//  443 
//  444 		Data = AdctoVolt5opamp(ADC_AVR[adcRVSPWRdect1][0]);
//  445 		SerPtr->printf(STARMSG);
//  446 		SerPtr->printf("RVS PWR 4G : %d.%03d[V]\n", Data/1000, Data%1000);
//  447 
//  448 
//  449 		Data = AdctoVolt33V(ADC_AVR[adcEnvTemp][0]);
//  450 		tmpx = ReadEnvTempTable(ADC_AVR[adcEnvTemp][0]);
//  451 		SerPtr->printf(STARMSG);
//  452 		SerPtr->printf("TEMP       : %d.%03d[V], %d.%d['C]\n", Data/1000, Data%1000, tmpx/10, abs(Data%10));
//  453 */
//  454 
//  455 		OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
//  456 	}
//  457 	PrintStar();
        BL       PrintStar
//  458 	SerPtr->printf("\n\n");
        ADR.N    R0,??DataTable70  ;; 0x0A, 0x0A, 0x00, 0x00
        LDR.N    R1,??DataTable70_9
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        POP      {R2,LR}
        BX       R1
//  459 }
//  460 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  461 void AdcPrintf(char *sptr, INT16U rawData, INT8U is_5V)
//  462 {
AdcPrintf:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R5,R1
//  463 	INT16U Data=0;
//  464 //	if(is_5V) 	Data = AdctoVolt5opamp(rawData);
//  465 //	else		Data = AdctoVolt33V(rawData);
//  466 	
//  467 	SerPtr->printf(STARMSG);
        LDR.N    R6,??DataTable70_9
        ADR.N    R0,??DataTable70_1  ;; 0x2A, 0x20, 0x00, 0x00
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  468 	SerPtr->printf("%s: %d.%d[V], [raw:%04d]", sptr, Data/10, Data%10, rawData);
        STR      R5,[SP, #+0]
        MOVS     R3,#+0
        MOVS     R2,#+0
        MOV      R1,R4
        ADR.W    R0,`?<Constant "%s: %d.%d[V], [raw:%04d]">`
        LDR      R4,[R6, #+0]
        LDR      R4,[R4, #+16]
        BLX      R4
//  469 	SerPtr->printf(ENTMSG);
        ADR.N    R0,??DataTable70_2  ;; "\n"
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+16]
        POP      {R2-R6,LR}
        BX       R1
//  470 }
//  471 
//  472 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  473 void COMTestFunc(void)
//  474 {
//  475 /*
//  476 	INT16U Recv;
//  477 
//  478 	//
//  479 	pUSART2.BuffClear();
//  480 	pUSART4.BuffClear();
//  481 	
//  482 	pUSART2.PutToBuffer('b');
//  483 	pUSART2.PutToBuffer('i');
//  484 	pUSART2.PutToBuffer('z');
//  485 	pUSART2.PutToBuffer('i');
//  486 
//  487 	OSTimeDly(10L);
//  488 	pUSART1.printf(" 통신시험 iRems2G(TX)->EXT(RX)    [SER2-SER4] 시험:");
//  489 
//  490 	if(pUSART4.CheckByte(4, &Recv))
//  491 	{
//  492 		if( pUSART4.RxGetByte() == 'b' &&
//  493 			pUSART4.RxGetByte() == 'i' &&
//  494 			pUSART4.RxGetByte() == 'z' &&
//  495 			pUSART4.RxGetByte() == 'i')
//  496 		{
//  497 			 pUSART1.printf("[SUCCESS EXT(RX)  ]: %d\n", Recv);
//  498 		}
//  499 		else pUSART1.printf("[FAIL    EXT(RX)  ]: %d\n", Recv); 
//  500 	}
//  501 	    else pUSART1.printf("[FAIL    EXT(RX)  ]: %d\n", Recv);
//  502 	//
//  503 
//  504 	pUSART3.BuffClear();
//  505 	pUSART2.BuffClear();
//  506 
//  507 	pUSART3.PutToBuffer('c');
//  508 	pUSART3.PutToBuffer('b');
//  509 	pUSART3.PutToBuffer('b');
//  510 	pUSART3.PutToBuffer('i');
//  511 
//  512 	OSTimeDly(10L);
//  513 	pUSART1.printf(" 통신시험 iRems3G(TX)->iRems4G(RX)[SER3-SER2] 시험:");
//  514 
//  515 	if(pUSART2.CheckByte(4, &Recv))
//  516 	{
//  517 		if( pUSART2.RxGetByte() == 'c' &&
//  518 			pUSART2.RxGetByte() == 'b' &&
//  519 			pUSART2.RxGetByte() == 'b' &&
//  520 			pUSART2.RxGetByte() == 'i')
//  521 		{
//  522 			 pUSART1.printf("[SUCCESS REMS_4G  ]: %d\n", Recv);
//  523 		}
//  524 		else pUSART1.printf("[FAIL    REMS_4G  ]: %d\n", Recv); 
//  525 	}
//  526 		else pUSART1.printf("[FAIL    REMS_4G  ]: %d\n", Recv);
//  527 
//  528 	//
//  529 	pUSART4.BuffClear();
//  530 	pUSART5.BuffClear();
//  531 	
//  532 	pUSART4.PutToBuffer('b');
//  533 	pUSART4.PutToBuffer('i');
//  534 	pUSART4.PutToBuffer('z');
//  535 	pUSART4.PutToBuffer('i');
//  536 
//  537 	OSTimeDly(10L);
//  538 	pUSART1.printf(" 통신시험 iRems4G(TX)-> FPGA(RX)  [SER4-SER5] 시험:");
//  539 
//  540 	if(pUSART5.CheckByte(4, &Recv))
//  541 	{
//  542 		if( pUSART5.RxGetByte() == 'b' &&
//  543 			pUSART5.RxGetByte() == 'i' &&
//  544 			pUSART5.RxGetByte() == 'z' &&
//  545 			pUSART5.RxGetByte() == 'i')
//  546 		{
//  547 			 pUSART1.printf("[SUCCESS FPGA     ]: %d\n", Recv);
//  548 		}
//  549 		else pUSART1.printf("[FAIL    FPGA     ]: %d\n", Recv); 
//  550 	}
//  551 	    else pUSART1.printf("[FAIL    FPAG     ]: %d\n", Recv);
//  552 
//  553 	//
//  554 	pUSART5.BuffClear();
//  555 	pUSART3.BuffClear();
//  556 
//  557 	pUSART5.PutToBuffer('c');
//  558 	pUSART5.PutToBuffer('b');
//  559 	pUSART5.PutToBuffer('b');
//  560 	pUSART5.PutToBuffer('i');
//  561 
//  562 	OSTimeDly(10L);
//  563 	pUSART1.printf(" 통신시험 FPGA(TX)->iRems3G(RX)   [SER5-SER3] 시험:");
//  564 
//  565 	if(pUSART3.CheckByte(4, &Recv))
//  566 	{
//  567 		if( pUSART3.RxGetByte() == 'c' &&
//  568 			pUSART3.RxGetByte() == 'b' &&
//  569 			pUSART3.RxGetByte() == 'b' &&
//  570 			pUSART3.RxGetByte() == 'i')
//  571 		{
//  572 			 pUSART1.printf("[SUCCESS REMS_3G  ]: %d\n", Recv);
//  573 		}
//  574 		else pUSART1.printf("[FAIL    REMS_3G  ]: %d\n", Recv); 
//  575 	}
//  576 		else pUSART1.printf("[FAIL    REMS_3G  ]: %d\n", Recv);
//  577 
//  578 	pUSART1.printf(ENTMSG);
//  579 */	
//  580 }
COMTestFunc:
        BX       LR               ;; return
//  581 
//  582 
//  583 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  584 void CurrentInputStatus(INT8U vcheck)
//  585 {
//  586 	INT8U tcnt = 0;
//  587 	INT8U tval = FALSE;
//  588     tcnt = tcnt;
//  589 
//  590 	if(!vcheck)PrintStar();
CurrentInputStatus:
        CBZ.N    R0,??CurrentInputStatus_0
        BX       LR
??CurrentInputStatus_0:
        PUSH     {R7,LR}
        BL       PrintStar
//  591 	{
//  592 		
//  593 	}
//  594 	
//  595 	if(!vcheck)PrintStar();
        BL       PrintStar
//  596 	if(vcheck)
//  597 	{
//  598 		if(tval) SerPtr->printf("\n");
//  599 	}
//  600 }
        POP      {R0,PC}          ;; return
//  601 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  602 INT32U dCycle = 0;
dCycle:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  603 INT32U vstrval = 0;
vstrval:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  604 INT8S vstr[64];
`vstr`:
        DS8 64
//  605 
//  606 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  607 void HwTestOutFunc(INT32U *nFlag)
//  608 {
//  609 	INT32U MaxValue = 0xFFFF;
//  610 	INT8U Data = *nFlag;
//  611 
//  612     MaxValue = MaxValue;
HwTestOutFunc:
        MOVW     R1,#+65535
//  613     Data = Data;
//  614 	
//  615 	switch(Data)
        LDR      R2,[R0, #+0]
        MOV      R3,R2
        UXTB     R2,R2
        CMP      R2,#+1
        IT       EQ 
        MOVEQ    R1,#+1
//  616 	{
//  617 		case 0:
//  618 //			_4G_NORLED = 1;
//  619 		break;
//  620 		
//  621 		case 1:
//  622 			MaxValue = Data;
//  623 			//BuzzShort();
//  624 		break;
//  625 	}	
//  626 	*nFlag = *nFlag + 1;
        ADDS     R2,R3,#+1
//  627 
//  628 	if(*nFlag >= MaxValue) *nFlag = 0;
        CMP      R2,R1
        IT       CS 
        MOVCS    R2,#+0
        STR      R2,[R0, #+0]
//  629 
//  630 }
        BX       LR               ;; return
//  631 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  632 INT32U DigitalInputDiplay(INT8U num, INT8U ival,
//  633 							INT8U *fmsg, INT8U *emsg,
//  634 							INT8U vcheck)
//  635 {
DigitalInputDiplay:
        PUSH     {R3-R8,R10,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R1,R2
        MOV      R6,R3
        LDR      R0,[SP, #+32]
//  636 	INT32U temp = FALSE;
        MOVS     R7,#+0
//  637 	INT8U *currentptr = (INT8U *)&tinputSts;
//  638 	INT8U *beforeptr = (INT8U *)&tinputStsOld;
//  639 
//  640 	// first
//  641 	if(!vcheck)
        CBNZ.N   R0,??DigitalInputDiplay_0
//  642 	{
//  643 		if(fmsg != NULL) SerPtr->printf("%s", fmsg);	// start // phase mssage
        CBZ.N    R1,??DigitalInputDiplay_0
        ADR.N    R0,??DataTable70_3  ;; 0x25, 0x73, 0x00, 0x00
        LDR.N    R2,??DataTable70_9
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        LDR.N    R0,??DataTable70_14
        STRB     R5,[R4, R0]
//  644 	}
//  645 
//  646 	currentptr[num] = ival;
//  647 
//  648 	{
//  649 
//  650 		if( (vcheck && (beforeptr[num] != currentptr[num]) ) )
//  651 		{
//  652 			SerPtr->printf("%02d. ", num);
//  653 			SerPtr->printf("%s", tDisplay[num]);
//  654 			{
//  655 				if(ival) SerPtr->printf(OFFMSG);
//  656 				else	 SerPtr->printf(ONMSG);
//  657 			}
//  658 			temp = TRUE;
//  659 		}
//  660 		else if(!vcheck)
//  661 		{
//  662 			SerPtr->printf("%s", tDisplay[num]);
??DigitalInputDiplay_1:
        LDR.W    R8,??DataTable70_9
        LDR.N    R0,??DataTable70_14
        ADD      R0,R0,R4, LSL #+2
        LDR      R1,[R0, #+64]
        ADR.N    R0,??DataTable70_3  ;; 0x25, 0x73, 0x00, 0x00
        LDR      R2,[R8, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        LDR      R0,[R8, #+0]
        LDR      R1,[R0, #+16]
        CMP      R5,#+0
        ITE      NE 
        ADRNE.W  R0,`?<Constant "[OFF]">`
        ADREQ.W  R0,`?<Constant "[ON ]">`
//  663 			{
//  664 				if(ival) SerPtr->printf(OFFMSG);
        B.N      ??DigitalInputDiplay_2
//  665 				else	 SerPtr->printf(ONMSG);
//  666 			}
//  667 		}
??DigitalInputDiplay_0:
        LDR.W    R10,??DataTable70_14
        STRB     R5,[R4, R10]
        CMP      R0,#+0
        BEQ.N    ??DigitalInputDiplay_1
        ADD      R0,R4,R10
        LDRB     R0,[R0, #+32]
        CMP      R0,R5
        BEQ.N    ??DigitalInputDiplay_3
        LDR.N    R6,??DataTable70_9
        MOV      R1,R4
        ADR.W    R0,`?<Constant "%02d. ">`
        LDR      R2,[R6, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        ADD      R0,R10,R4, LSL #+2
        LDR      R1,[R0, #+64]
        ADR.N    R0,??DataTable70_3  ;; 0x25, 0x73, 0x00, 0x00
        LDR      R2,[R6, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        LDR      R0,[R6, #+0]
        LDR      R1,[R0, #+16]
        CMP      R5,#+0
        ITE      NE 
        ADRNE.W  R0,`?<Constant "[OFF]">`
        ADREQ.W  R0,`?<Constant "[ON ]">`
        BLX      R1
        MOVS     R7,#+1
//  668 	}
//  669 
//  670 ////////////////////////////////////////////////////////////////////////////////
//  671 	if(vcheck)
//  672 	{
//  673 		if(temp)
//  674 		{
//  675 			OSTimeDly(1L);
??DigitalInputDiplay_4:
        MOVS     R0,#+1
        BL       OSTimeDly
//  676 			SerPtr->printf(ENTMSG);
        ADR.N    R0,??DataTable70_2  ;; "\n"
        LDR.N    R1,??DataTable70_9
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
        B.N      ??DigitalInputDiplay_3
//  677 		}
//  678 	}
??DigitalInputDiplay_2:
        BLX      R1
//  679 	else
//  680 	{
//  681 		if(emsg)
        CMP      R6,#+0
        BNE.N    ??DigitalInputDiplay_4
//  682 		{
//  683 			OSTimeDly(1L);
//  684 			SerPtr->printf(ENTMSG);
//  685 		}
//  686 	}
//  687 
//  688 	beforeptr[num] = currentptr[num];
??DigitalInputDiplay_3:
        LDR.N    R2,??DataTable70_14
        ADDS     R0,R4,R2
        LDRB     R1,[R4, R2]
        STRB     R1,[R0, #+32]
//  689 	return (INT32U)temp;
        MOV      R0,R7
        POP      {R1,R4-R8,R10,PC}  ;; return
//  690 }
//  691 
//  692 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  693 INT8U returnmsgTest(char *str)
//  694 {
returnmsgTest:
        PUSH     {R7,LR}
//  695 	SerPtr->printf("%s이 수행되어 있습니다. 계속 진행하시겠습니까?[Y]es, [C]ancel\n", str);
        MOV      R1,R0
        ADR.W    R0,`?<Constant "%s\\300\\314 \\274\\366\\307\\340\\265\\30`
        LDR.N    R2,??DataTable70_9
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  696 	return WaringMssageReturn();
        POP      {R0,LR}
        REQUIRE WaringMssageReturn
        ;; // Fall through to label WaringMssageReturn
//  697 }
//  698 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  699 INT8U WaringMssageReturn(void)
//  700 {
WaringMssageReturn:
        PUSH     {R3-R5,LR}
//  701 	INT16U nCnt;
//  702 
//  703 	TimerRegist(TimerTest, Time1Sec*5L);
        MOVW     R5,#+5000
        MOV      R1,R5
        MOVS     R0,#+3
        BL       TimerRegist
        LDR.N    R4,??DataTable70_9
        B.N      ??WaringMssageReturn_0
//  704 
//  705 	while(1)
//  706 	{
//  707 		if(TimeOverCheck(TimerTest))
//  708 		{
//  709 			TimerRegist(TimerTest, Time1Sec*5L);
//  710 			return TRUE;
//  711 		}
//  712 		if(SerPtr->CheckByte(1, &nCnt))
//  713 		{
//  714 			nCnt = SerPtr->RxGetByte();
//  715 			if(nCnt == 'C' || nCnt == 'c')
//  716 			{
//  717 				SerPtr->printf("CANCEL TEST \n");
//  718 				return FALSE;
//  719 			}
//  720 			else return TRUE;
//  721 		}
//  722 		OSTimeDly(10L);
??WaringMssageReturn_1:
        MOVS     R0,#+10
        BL       OSTimeDly
??WaringMssageReturn_0:
        MOVS     R0,#+3
        BL       TimeOverCheck
        CBZ.N    R0,??WaringMssageReturn_2
        MOV      R1,R5
        MOVS     R0,#+3
        BL       TimerRegist
        B.N      ??WaringMssageReturn_3
??WaringMssageReturn_2:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WaringMssageReturn_1
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        STRH     R0,[SP, #+0]
        LDRH     R0,[SP, #+0]
        CMP      R0,#+67
        BEQ.N    ??WaringMssageReturn_4
        CMP      R0,#+99
        BNE.N    ??WaringMssageReturn_3
??WaringMssageReturn_4:
        ADR.W    R0,`?<Constant "CANCEL TEST \\n">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
??WaringMssageReturn_3:
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}    ;; return
//  723 	}
//  724 }
//  725 
//  726 /*
//  727 void PrintLogo(void)
//  728 {
//  729 
//  730 	SerPtr->printf("\n\n");
//  731 	PrintStar();
//  732 	SerPtr->printf("*\n");
//  733 	SerPtr->printf("* %s [VER:%d.%d]\n", BoardTestMode, (SystemVer >> 4 & 0x0f), (SystemVer >> 0 & 0x0f));
//  734 	SerPtr->printf("*    -COMMAND 1st-\n");
//  735 	SerPtr->printf("*  ?        : help(this message)\n");
//  736 	SerPtr->printf("*  I        : INPUT Test          [%s]\n", testResult[0x03 & SavetoTestBackup(InputTest, NULL, NULL)]);
//  737 	SerPtr->printf("*  O        : OUTPUT Test         [%s]\n", testResult[0x03 & SavetoTestBackup(OutputTest,  NULL, NULL)]);
//  738 	SerPtr->printf("*  A        : ANALOG DECT         [%s]\n", testResult[0x03 & SavetoTestBackup(ADCTest, 	NULL, NULL)]);
//  739 	SerPtr->printf("*  C        : SERIAL[UART]        [%s]\n", testResult[0x03 & SavetoTestBackup(CommTest, NULL, NULL)]);
//  740 	SerPtr->printf("*  G        : compulsory boot/#,\n");
//  741 	
//  742 	PrintStar();
//  743 }
//  744 */
//  745 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  746 void PrintLogo(void)
//  747 {
PrintLogo:
        PUSH     {R4,LR}
//  748 	SerPtr->printf("\n\n");
        LDR.N    R4,??DataTable70_9
        ADR.N    R0,??DataTable70  ;; 0x0A, 0x0A, 0x00, 0x00
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  749 	PrintStar();
        BL       PrintStar
//  750 	SerPtr->printf("*\n");
        ADR.N    R0,??DataTable70_4  ;; 0x2A, 0x0A, 0x00, 0x00
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  751 	SerPtr->printf("*  ?               : help(this message)\n");
        ADR.W    R0,`?<Constant "*  ?               : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  752 	SerPtr->printf("*  SO              : 2.1G SISO AMP On\n");
        ADR.W    R0,`?<Constant "*  SO              : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  753 	SerPtr->printf("*  SF              : 2.1G SISO AMP Off\n");
        ADR.W    R0,`?<Constant "*  SF              : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  754 	SerPtr->printf("*  MO              : 2.1G MIMO AMP On\n");
        ADR.W    R0,`?<Constant "*  MO              : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  755 	SerPtr->printf("*  MF              : 2.1G MIMO AMP Off\n");
        ADR.W    R0,`?<Constant "*  MF              : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  756 	SerPtr->printf("*  A[T/R][S/M][00] : 2.1G Attn\n");
        ADR.W    R0,`?<Constant "*  A[T/R][S/M][00] : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  757 	SerPtr->printf("*   [T/R]          : T->TX, R->RX\n");	
        ADR.W    R0,`?<Constant "*   [T/R]          : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  758 	SerPtr->printf("*        [S/M]     : S->SISO, M->MIMO\n");	
        ADR.W    R0,`?<Constant "*        [S/M]     : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  759 	SerPtr->printf("*             [00] : Attn Value (1=0.5dB)\n");	
        ADR.W    R0,`?<Constant "*             [00] : ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  760 	SerPtr->printf("*  ex) ATS30 -> 2.1G SISO TX ATTN 15.0dB \n");
        ADR.W    R0,`?<Constant "*  ex) ATS30 -> 2.1G ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  761 	SerPtr->printf("*  ex) ARM03 -> 2.1G MIMO RX ATTN 1.5dB \n");
        ADR.W    R0,`?<Constant "*  ex) ARM03 -> 2.1G ...">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  762 	
//  763 	PrintStar();
        POP      {R4,LR}
        REQUIRE PrintStar
        ;; // Fall through to label PrintStar
//  764 }
//  765 
//  766 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  767 void PrintStar(void)
//  768 {
//  769 	SerPtr->printf("*******************************************************************************\n");
PrintStar:
        ADR.W    R0,`?<Constant "*********************...">`
        B.N      ?Subroutine0
//  770 }
//  771 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  772 void PromptOut(void)
//  773 {
//  774 	SerPtr->printf("STM3>>");
PromptOut:
        ADR.W    R0,`?<Constant "STM3>>">`
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  775 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        LDR.N    R1,??DataTable70_9
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BX       R1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70:
        DC8      0x0A, 0x0A, 0x00, 0x00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_1:
        DC8      0x2A, 0x20, 0x00, 0x00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_2:
        DC8      "\n",0x0,0x0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_3:
        DC8      0x25, 0x73, 0x00, 0x00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_4:
        DC8      0x2A, 0x0A, 0x00, 0x00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_5:
        DC32     TestTaskStk+0x3FC

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_6:
        DC32     TestTask

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_7:
        DC32     tTestFlag

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_8:
        DC32     OnCommand

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_9:
        DC32     SerPtr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_10:
        DC32     iUser_Value2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_11:
        DC32     tIndex

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_12:
        DC32     tRevData

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_13:
        DC32     SysPath

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable70_14:
        DC32     tinputSts

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G PATH..........\\n">`:
        DC8 "\012 2.1G PATH..........\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M PATH..........\\n">`:
        DC8 "\012 900M PATH..........\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.5G PATH..........\\n">`:
        DC8 "\012 2.5G PATH..........\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G SISO AMP ON(Hi...">`:
        DC8 "\012 2.1G SISO AMP ON(High)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M SISO AMP ON(Hi...">`:
        DC8 "\012 900M SISO AMP ON(High)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.5G SISO AMP ON(Hi...">`:
        DC8 "\012 2.5G SISO AMP ON(High)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G SISO AMP OFF(L...">`:
        DC8 "\012 2.1G SISO AMP OFF(Low)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M SISO AMP OFF(L...">`:
        DC8 "\012 900M SISO AMP OFF(Low)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G MIMO AMP ON(Hi...">`:
        DC8 "\012 2.1G MIMO AMP ON(High)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M MIMO AMP ON(Hi...">`:
        DC8 "\012 900M MIMO AMP ON(High)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.5G MIMO AMP ON(Hi...">`:
        DC8 "\012 2.5G MIMO AMP ON(High)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G MIMO AMP OFF(L...">`:
        DC8 "\012 2.1G MIMO AMP OFF(Low)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M MIMO AMP OFF(L...">`:
        DC8 "\012 900M MIMO AMP OFF(Low)...\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G SISO TX Attn =...">`:
        DC8 "\012 2.1G SISO TX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M SISO TX Attn =...">`:
        DC8 "\012 900M SISO TX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.5G SISO TX Attn =...">`:
        DC8 "\012 2.5G SISO TX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G MIMO TX Attn =...">`:
        DC8 "\012 2.1G MIMO TX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M MIMO TX Attn =...">`:
        DC8 "\012 900M MIMO TX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.5G MIMO TX Attn =...">`:
        DC8 "\012 2.5G MIMO TX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G SISO RX Attn =...">`:
        DC8 "\012 2.1G SISO RX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M SISO RX Attn =...">`:
        DC8 "\012 900M SISO RX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.5G SISO RX Attn =...">`:
        DC8 "\012 2.5G SISO RX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.1G MIMO RX Attn =...">`:
        DC8 "\012 2.1G MIMO RX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 900M MIMO RX Attn =...">`:
        DC8 "\012 900M MIMO RX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n 2.5G MIMO RX Attn =...">`:
        DC8 "\012 2.5G MIMO RX Attn = %d\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n Eeprom 1 Read Addre...">`:
        DC8 "\012 Eeprom 1 Read Address[%x] : [%x]\012"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "\\n Eeprom 1 Write Addr...">`:
        DC8 "\012 Eeprom 1 Write Address[%x] -> [%x]\012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant " Eeprom 1 Read Addres...">`:
        DC8 " Eeprom 1 Read Address[%x] : [%x]\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "%s: %d.%d[V], [raw:%04d]">`:
        DC8 "%s: %d.%d[V], [raw:%04d]"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "%02d. ">`:
        DC8 "%02d. "
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "[OFF]">`:
        DC8 "[OFF]"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "[ON ]">`:
        DC8 "[ON ]"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "%s\\300\\314 \\274\\366\\307\\340\\265\\30`:
        DC8 25H, 73H, 0C0H, 0CCH, 20H, 0BCH, 0F6H, 0C7H
        DC8 0E0H, 0B5H, 0C7H, 0BEH, 0EEH, 20H, 0C0H, 0D6H
        DC8 0BDH, 0C0H, 0B4H, 0CFH, 0B4H, 0D9H, 2EH, 20H
        DC8 0B0H, 0E8H, 0BCH, 0D3H, 20H, 0C1H, 0F8H, 0C7H
        DC8 0E0H, 0C7H, 0CFH, 0BDH, 0C3H, 0B0H, 0DAH, 0BDH
        DC8 0C0H, 0B4H, 0CFH, 0B1H, 0EEH, 3FH, 5BH, 59H
        DC8 5DH, 65H, 73H, 2CH, 20H, 5BH, 43H, 5DH
        DC8 61H, 6EH, 63H, 65H, 6CH, 0AH, 0
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "CANCEL TEST \\n">`:
        DC8 "CANCEL TEST \012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  ?               : ...">`:
        DC8 "*  ?               : help(this message)\012"
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  SO              : ...">`:
        DC8 "*  SO              : 2.1G SISO AMP On\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  SF              : ...">`:
        DC8 "*  SF              : 2.1G SISO AMP Off\012"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  MO              : ...">`:
        DC8 "*  MO              : 2.1G MIMO AMP On\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  MF              : ...">`:
        DC8 "*  MF              : 2.1G MIMO AMP Off\012"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  A[T/R][S/M][00] : ...">`:
        DC8 "*  A[T/R][S/M][00] : 2.1G Attn\012"

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*   [T/R]          : ...">`:
        DC8 "*   [T/R]          : T->TX, R->RX\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*        [S/M]     : ...">`:
        DC8 "*        [S/M]     : S->SISO, M->MIMO\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*             [00] : ...">`:
        DC8 "*             [00] : Attn Value (1=0.5dB)\012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  ex) ATS30 -> 2.1G ...">`:
        DC8 "*  ex) ATS30 -> 2.1G SISO TX ATTN 15.0dB \012"
        DC8 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*  ex) ARM03 -> 2.1G ...">`:
        DC8 "*  ex) ARM03 -> 2.1G MIMO RX ATTN 1.5dB \012"
        DC8 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "*********************...">`:
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH
        DC8 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 2AH, 0AH
        DC8 0
        DC8 0, 0, 0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
`?<Constant "STM3>>">`:
        DC8 "STM3>>"
        DC8 0

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "NON TESTED">`:
        DC8 "NON TESTED"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "    TESTED">`:
        DC8 "    TESTED"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO0   :">`:
        DC8 "GPO0   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO1   :">`:
        DC8 "GPO1   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO2   :">`:
        DC8 "GPO2   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO3   :">`:
        DC8 "GPO3   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO4   :">`:
        DC8 "GPO4   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO5   :">`:
        DC8 "GPO5   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO6   :">`:
        DC8 "GPO6   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "GPO7   :">`:
        DC8 "GPO7   :"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "%s">`:
        DC8 "%s"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "\\n\\n">`:
        DC8 "\012\012"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "* ">`:
        DC8 "* "
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
`?<Constant "\\n">`:
        DC8 "\012"

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
`?<Constant "*\\n">`:
        DC8 "*\012"
        DC8 0

        END
//  776 
//  777 
//  778 
//  779 
//  780 
//  781 ///////////////////////////////////////////////////////////////////////////////
//  782 // End of Source File
//  783 ////////////////////////
//  784 
// 
//   262 bytes in section .bss
//   112 bytes in section .data
//   138 bytes in section .rodata
// 3 504 bytes in section .text
// 1 024 bytes in section iram
// 
// 3 504 bytes of CODE  memory
//   138 bytes of CONST memory
// 1 398 bytes of DATA  memory
//
//Errors: none
//Warnings: 3
