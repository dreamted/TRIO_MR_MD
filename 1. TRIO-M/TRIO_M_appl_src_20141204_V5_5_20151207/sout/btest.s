///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:35 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\btest /
//                    .c                                                      /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\btest /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\btest /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME btest

        EXTERN ADC_AVR
        EXTERN ADC_DATA1
        EXTERN AdctoVolt33V
        EXTERN AdctoVolt5opamp
        EXTERN AttnCS0Val
        EXTERN AttnCS1Val
        EXTERN AttnCS2Val
        EXTERN CheckSWConf
        EXTERN DisableWriteAT24C64
        EXTERN DownLoadBootingJump
        EXTERN DownloadFlagClr
        EXTERN ForDelay
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ReadAT24C64
        EXTERN RoadBackuptobuffer
        EXTERN SerPtr
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN WriteAT24C64
        EXTERN WriteBuffertoBackup
        EXTERN __aeabi_memcpy4
        EXTERN iUser_Value2
        EXTERN pPCA9555BitRst
        EXTERN pPCA9555BitSet
        EXTERN pPCA9555Str
        EXTERN pUSART1
        EXTERN pUSART4

        PUBLIC AdInputStatus
        PUBLIC AdcPrintf
        PUBLIC COMTestFunc
        PUBLIC CurrentInputStatus
        PUBLIC DigitalInputDiplay
        PUBLIC HwTestOutFunc
        PUBLIC KeyProc
        PUBLIC OnCommand
        PUBLIC PrintLogo
        PUBLIC PrintStar
        PUBLIC PromptOut
        PUBLIC TestInit
        PUBLIC TestTask
        PUBLIC WaringMssageReturn
        PUBLIC comtstcnt
        PUBLIC returnmsgTest
        PUBLIC tDisplay
        PUBLIC tIndex
        PUBLIC tRevData
        PUBLIC tTest
        PUBLIC tTestFlag
        PUBLIC testResult
        PUBLIC tinputSts
        PUBLIC tinputStsOld
        PUBLIC tmpAddr
        PUBLIC vstr
        PUBLIC vstrval

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\btest.c
//    1 
//    2 /*********************************************
//    3 * File Name          : exlib.c
//    4 * Author             : 
//    5 * Date First Issued  : 02/01/2008
//    6 * Description        : This file provides all the port/input/update firmware functions.
//    7 * $Revision: 0.1 $
//    8 * $Revision date: 2008.01.__
//    9 ********************************************************************************/
//   10 
//   11 #define TEST_C
//   12 
//   13 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// static OS_STK __data TestTaskStk[256]
TestTaskStk:
        DS8 1024

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data tTestFlag
tTestFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// _inputStsStr __data tinputStsOld
tinputStsOld:
        DS8 52
//   14 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   15 void TestInit(void)
//   16 {
//   17 	OSTaskCreate(TestTask, (void *)NULL, (OS_STK *)&TestTaskStk[TEST_START_STK_SIZE - 1], TEST_START_PRIO);
TestInit:
        MOVS     R3,#+5
        LDR.N    R2,??TestInit_0  ;; TestTaskStk + 1020
        MOVS     R1,#+0
        LDR.N    R0,??TestInit_0+0x4  ;; TestTask
        B.W      OSTaskCreate
        DATA
??TestInit_0:
        DC32     TestTaskStk + 1020
        DC32     TestTask
//   18 }
//   19 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   20 void TestTask(void *p_arg)
//   21 {
TestTask:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
//   22 	INT16U nCnt = 0;
//   23 	nCnt = nCnt;
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//   24 	p_arg = p_arg;
//   25 
//   26 	tTestFlag = FALSE;
        LDR.N    R4,??TestTask_0  ;; tTestFlag
        STRB     R0,[R4, #+0]
//   27 	
//   28 	OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
        LDR.W    R5,??DataTable21  ;; SerPtr
        LDR.N    R6,??TestTask_0+0x4  ;; iUser_Value2
        B.N      ??TestTask_1
//   29 
//   30 	while(1)
//   31 	{
//   32 		if(CheckSWConf() == 0x05 || iUser_Value2 == __ChangeDebug)
//   33 		{
//   34 			PrintLogo();
//   35 			PromptOut();
//   36 			
//   37 			while(CheckSWConf() == 0x05 || iUser_Value2 == __ChangeDebug)
//   38 			{
//   39 				if(SerPtr->CheckByte(1, &nCnt))
??TestTask_2:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CBZ      R0,??TestTask_3
//   40 				{
//   41 					KeyProc(SerPtr->RxGetByte());
        LDR      R0,[R5, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        UXTB     R0,R0
        BL       KeyProc
//   42 				}
//   43 				tTestFlag = TRUE;
??TestTask_3:
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
//   44 
//   45 				if(TimeOverCheck(Timer_DebugCnt))
        MOVS     R0,#+8
        BL       TimeOverCheck
        CBZ      R0,??TestTask_4
//   46 				{
//   47 					iUser_Value2 = 0;
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
//   48 				}
//   49 				OSTimeDly(10L);
??TestTask_4:
        MOVS     R0,#+10
        BL       OSTimeDly
//   50 			}
??TestTask_5:
        BL       CheckSWConf
        CMP      R0,#+5
        BEQ.N    ??TestTask_2
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BEQ.N    ??TestTask_2
//   51 		}
//   52 
//   53 		tTestFlag = FALSE;
??TestTask_6:
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//   54 		OSTimeDly(100L*5L);
        MOV      R0,#+500
        BL       OSTimeDly
??TestTask_1:
        BL       CheckSWConf
        CMP      R0,#+5
        BEQ.N    ??TestTask_7
        LDRB     R0,[R6, #+0]
        CMP      R0,#+13
        BNE.N    ??TestTask_6
??TestTask_7:
        BL       PrintLogo
        BL       PromptOut
        B.N      ??TestTask_5
        DATA
??TestTask_0:
        DC32     tTestFlag
        DC32     iUser_Value2
//   55 	}
//   56 }
//   57 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   58 void KeyProc( char sbuf )
//   59 {
KeyProc:
        PUSH     {R4-R6,LR}
//   60 	INT16U nSize = sizeof(tRevData);
//   61 
//   62 	tRevData[tIndex%nSize] = sbuf;
        LDR.W    R4,??DataTable17  ;; tIndex
        LDRB     R1,[R4, #+0]
        MOVS     R5,#+50
        SDIV     R2,R1,R5
        MLS      R2,R2,R5,R1
        ADDS     R2,R2,R4
        STRB     R0,[R2, #+4]
//   63 	if( tRevData[tIndex%nSize] == 0x0D )			// Enter 입력
        CMP      R0,#+13
        BNE.N    ??KeyProc_0
//   64 	{
//   65 		SerPtr->PutToBuffer('\r');
        LDR.W    R6,??DataTable21  ;; SerPtr
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   66 		SerPtr->PutToBuffer('\n');
        MOVS     R0,#+10
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   67 		tRevData[tIndex%nSize] = '\0';
        LDRB     R0,[R4, #+0]
        SDIV     R1,R0,R5
        MLS      R0,R1,R5,R0
        ADDS     R0,R0,R4
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
//   68 		OnCommand();
        BL       OnCommand
//   69 		tIndex = 0;
        B.N      ??KeyProc_1
//   70 		return;
//   71 	}
//   72 	else if( tRevData[tIndex%nSize] == 0x08 )		// Back Space
??KeyProc_0:
        CMP      R0,#+8
        BNE.N    ??KeyProc_2
//   73 	{
//   74 		if (tIndex == 0)
        CBZ      R1,??KeyProc_3
//   75 			return;
//   76 
//   77 		SerPtr->PutToBuffer(0x08);
        LDR.W    R6,??DataTable21  ;; SerPtr
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   78 		SerPtr->PutToBuffer(' ');
        MOVS     R0,#+32
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   79 		SerPtr->PutToBuffer(0x08);
        MOVS     R0,#+8
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   80 		tIndex--;
        LDRB     R0,[R4, #+0]
        SUBS     R0,R0,#+1
        B.N      ??KeyProc_4
//   81 
//   82 		return;
//   83 	}
//   84 	SerPtr->PutToBuffer(tRevData[tIndex%nSize]);			// 입력 키 출력
??KeyProc_2:
        LDR.W    R1,??DataTable21  ;; SerPtr
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+24]
        BLX      R1
//   85 	if(++tIndex >= nSize) tIndex = 0;
        LDRB     R0,[R4, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+0]
        UXTB     R0,R0
        CMP      R0,#+50
        BCC.N    ??KeyProc_3
??KeyProc_1:
        MOVS     R0,#+0
??KeyProc_4:
        STRB     R0,[R4, #+0]
??KeyProc_3:
        POP      {R4-R6,PC}       ;; return
//   86 }

        SECTION `.data`:DATA:NOROOT(2)
// char __data tIndex
tIndex:
        DATA
        DC8 0
        DC8 0, 0, 0
// INT8U __data tRevData[50]
tRevData:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   87 
//   88 INT16U tmpAddr = 0;
tmpAddr:
        DC16 0
        DC8 0, 0
// tstStr __data tTest
tTest:
        DC8 0, 0, 0, 0
// unsigned char const *__data testResult[2]
testResult:
        DC32 `?<Constant "NON TESTED">`, `?<Constant "    TESTED">`

        SECTION `.data`:DATA:NOROOT(2)
// _inputStsStr __data tinputSts
tinputSts:
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// char const *__data tDisplay[6]
tDisplay:
        DC32 `?<Constant "PLL_Alarm_Common1 :">`
        DC32 `?<Constant "PLL_Alarm_Common  :">`
        DC32 `?<Constant "PLL_Alarm_LTE1    :">`
        DC32 `?<Constant "PLL_Alarm_LTE_A1  :">`
        DC32 `?<Constant "AC_Alarm          :">`
        DC32 `?<Constant "Insert            :">`
//   89 //#define EEP_TEST_ADDR	128
//   90 #define EEP_TEST_ADDR	64
//   91 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   92 void OnCommand ( void )
//   93 {
OnCommand:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+12
//   94 	INT8U tdata = TRUE;
//   95 
//   96     tdata = tdata;
//   97     
//   98    	switch(tRevData[0])
        LDR.W    R4,??DataTable17  ;; tIndex
        LDRB     R0,[R4, #+4]
        CMP      R0,#+63
        BEQ.W    ??OnCommand_0
        CMP      R0,#+65
        BEQ.W    ??OnCommand_1
        CMP      R0,#+67
        BEQ.W    ??OnCommand_2
        CMP      R0,#+70
        BEQ.N    ??OnCommand_3
        CMP      R0,#+71
        BEQ.W    ??OnCommand_4
        CMP      R0,#+73
        BEQ.W    ??OnCommand_5
        CMP      R0,#+79
        BEQ.W    ??OnCommand_6
        CMP      R0,#+82
        BEQ.N    ??OnCommand_7
        CMP      R0,#+97
        BEQ.W    ??OnCommand_1
        CMP      R0,#+99
        BEQ.W    ??OnCommand_2
        CMP      R0,#+102
        BEQ.N    ??OnCommand_3
        CMP      R0,#+103
        BEQ.W    ??OnCommand_4
        CMP      R0,#+105
        BEQ.W    ??OnCommand_5
        CMP      R0,#+111
        BEQ.N    ??OnCommand_6
        CMP      R0,#+114
        BEQ.N    ??OnCommand_7
        B.N      ??OnCommand_8
//   99    	{
//  100    		case 'f':	// rtc
//  101 		case 'F':
//  102 			{
//  103 				INT8U IsitSucc = 0;
//  104 				INT16U i = 0;
//  105 				
//  106 				for(i = 0; i <	EEP_TEST_ADDR; i++)
??OnCommand_3:
        MOVS     R7,#+0
        LDR.W    R5,??DataTable21  ;; SerPtr
        LDR.W    R8,??OnCommand_9+0x4  ;; `?<Constant "AT24C64 Error Write F...">`
//  107 				{
//  108 					if(WriteAT24C64(i, i+1) < 0)
??OnCommand_10:
        ADDS     R6,R7,#+1
        UXTB     R1,R6
        UXTH     R0,R7
        BL       WriteAT24C64
        CMP      R0,#+0
        BPL.N    ??OnCommand_11
//  109 					{
//  110 						SerPtr->printf("AT24C64 Error Write Function ADDR[%d] \n", i);
        UXTH     R1,R7
        MOV      R0,R8
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  111 						break;
        B.N      ??OnCommand_12
//  112 					}
//  113 					tmpAddr = ReadAT24C64(i);
??OnCommand_11:
        UXTH     R0,R7
        BL       ReadAT24C64
        STRH     R0,[R4, #+56]
        LDR      R0,[R5, #+0]
        LDR      R3,[R0, #+16]
        LDRH     R0,[R4, #+56]
        MOV      R2,R0
        UXTB     R0,R0
        UXTB     R1,R6
        CMP      R0,R1
        BEQ.N    ??OnCommand_13
//  114 					if((INT8U)tmpAddr != (INT8U)(i + 1))
//  115 					{
//  116 						SerPtr->printf("AT24C64 Error Read Function ADDR[%d] = %d \n", i, tmpAddr);
        UXTH     R1,R7
        ADD      R0,R8,#+40
        BLX      R3
//  117 						break;
        B.N      ??OnCommand_12
//  118 					}
//  119 					else
//  120 					{
//  121 						SerPtr->printf("AT24C64 Read Data[%d] = %d \n", i, tmpAddr);
??OnCommand_13:
        MOV      R1,R7
        ADD      R0,R8,#+84
        BLX      R3
//  122 					}
//  123 					ForDelay(10);
        MOVS     R0,#+10
        BL       ForDelay
//  124 				}
        ADDS     R7,R7,#+1
        UXTH     R0,R7
        CMP      R0,#+64
        BCC.N    ??OnCommand_10
//  125 				if(i == EEP_TEST_ADDR) IsitSucc++;
??OnCommand_12:
        UXTH     R7,R7
        CMP      R7,#+64
??OnCommand_14:
        BNE.W    ??OnCommand_8
//  126 
//  127 			////////////////////////////////////////////////////////////////////////////////
//  128 				if(IsitSucc == 1)
//  129 				{
//  130 					INT32U cpu_sr;
//  131 
//  132 					OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
//  133 					OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R7,R0
//  134 					{
//  135 						EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
        LDR.W    R6,??OnCommand_9+0x8  ;; 0x8006800
        MOV      R0,R6
        BL       RoadBackuptobuffer
//  136 
//  137 						tTest.Output = TRUE;
        LDR      R1,[R4, #+60]
        ORR      R1,R1,#0x1
        STR      R1,[R4, #+60]
//  138 
//  139 						ptr->eepromBp = tTestOK;
        MOVS     R1,#+90
        STRB     R1,[R0, #+6]
//  140 						WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1)); 								
        MOVW     R1,#+1954
        MOV      R0,R6
        BL       WriteBuffertoBackup
//  141 					}
//  142 					OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  143 					SerPtr->printf("\n\nSUCCESS EEPROM TEST\n");
        ADD      R0,R8,#+116
        LDR      R1,[R5, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
        B.N      ??OnCommand_8
//  144 				}
//  145 			}
//  146 
//  147 
//  148 		break;
//  149 
//  150 		case 'r':	// rtc
//  151 		case 'R':
//  152 			{
//  153 				INT8U IsitSucc = 0;
//  154 				INT16U i = 0;
//  155 
//  156 				DisableWriteAT24C64();
??OnCommand_7:
        BL       DisableWriteAT24C64
//  157 				
//  158 				for(i = 0; i <	EEP_TEST_ADDR; i++)
        MOVS     R7,#+0
        LDR.W    R5,??DataTable21  ;; SerPtr
        LDR.W    R8,??OnCommand_9+0x4  ;; `?<Constant "AT24C64 Error Write F...">`
//  159 				{
//  160 					tmpAddr = ReadAT24C64(i);
??OnCommand_15:
        UXTH     R0,R7
        BL       ReadAT24C64
        STRH     R0,[R4, #+56]
//  161 					{
//  162 						SerPtr->printf("AT24C64 Read Data[%d] = %d \n", i, tmpAddr);
        MOV      R2,R0
        MOV      R1,R7
        ADD      R0,R8,#+84
        LDR      R3,[R5, #+0]
        LDR      R3,[R3, #+16]
        BLX      R3
//  163 					}
//  164 					
//  165 					ForDelay(10);
        MOVS     R0,#+10
        BL       ForDelay
//  166 				}
        ADDS     R7,R7,#+1
        UXTH     R0,R7
        CMP      R0,#+64
        BCC.N    ??OnCommand_15
//  167 				if(i == EEP_TEST_ADDR) IsitSucc++;
        B.N      ??OnCommand_14
//  168 
//  169 			////////////////////////////////////////////////////////////////////////////////
//  170 				if(IsitSucc == 1)
//  171 				{
//  172 					INT32U cpu_sr;
//  173 
//  174 					OSTimeDly(10L);
//  175 					OS_ENTER_CRITICAL();
//  176 					{
//  177 						EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
//  178 
//  179 						tTest.Output = TRUE;
//  180 
//  181 						ptr->eepromBp = tTestOK;
//  182 						WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1)); 								
//  183 					}
//  184 					OS_EXIT_CRITICAL();
//  185 					SerPtr->printf("\n\nSUCCESS EEPROM TEST\n");
//  186 				}
//  187 			}
//  188 		break;
//  189 
//  190 
//  191 		case '?':
//  192 			PrintLogo();
??OnCommand_0:
        BL       PrintLogo
        B.N      ??OnCommand_8
//  193 		break;
//  194 		case 'O':
//  195 		case 'o':
//  196 			{
//  197 				char *tstmsg = "Dig Output";
//  198 				
//  199 				if(tTest.Output)
??OnCommand_6:
        LDR.W    R8,??OnCommand_9+0x4  ;; `?<Constant "AT24C64 Error Write F...">`
        ADD      R7,R8,#+140
        LDR      R0,[R4, #+60]
        TST      R0,#0x1
        BEQ.N    ??OnCommand_16
//  200 				{
//  201 					tdata = returnmsgTest(tstmsg);
//  202 				}
//  203 				if(tdata)
        MOV      R0,R7
        BL       returnmsgTest
        CMP      R0,#+0
        BEQ.W    ??OnCommand_8
//  204 				{
//  205 					INT32U nFlag = 0;
??OnCommand_16:
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  206 					INT16U nCnt;
//  207 	
//  208 					SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);
        LDR.W    R5,??DataTable21  ;; SerPtr
        MOV      R1,R7
        ADD      R0,R8,#+152
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  209 	
//  210 					TimerRegist(TimerTest, Time1Sec*60L*5L);
        LDR.N    R1,??OnCommand_9+0xC  ;; 0x493e0
        MOVS     R0,#+3
        BL       TimerRegist
        B.N      ??OnCommand_17
//  211 	
//  212 					while(1)
//  213 					{
//  214 						HwTestOutFunc(&nFlag);
//  215 	
//  216 						if(TimeOverCheck(TimerTest))
//  217 						{
//  218 							SerPtr->printf("%s test TimeOut\n", tstmsg);
//  219 							TimerRegist(TimerTest, Time1Sec);
//  220 							break;
//  221 						}
//  222 						if(SerPtr->CheckByte(1, &nCnt))
//  223 						{
//  224 							nCnt = SerPtr->RxGetByte();
//  225 							if(nCnt == 'C' || nCnt == 'c')
//  226 							{
//  227 								SerPtr->printf("%s test Canceled\n", tstmsg);
//  228 								break;
//  229 							}
//  230 							else if(nCnt == 'F' || nCnt == 'f')
//  231 							{
//  232 								INT32U cpu_sr;
//  233 
//  234 								OS_ENTER_CRITICAL();
//  235 								{
//  236 									EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
//  237 
//  238 									tTest.Output = TRUE;
//  239 
//  240 									ptr->OutputTestBp = tTestOK;
//  241 									WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));									
//  242 								}
//  243 								OS_EXIT_CRITICAL();
//  244 								SerPtr->printf("%s test Finished\n", tstmsg);
//  245 								break;
//  246 							}
//  247 						}
//  248 
//  249 						OSTimeDly(300L);
??OnCommand_18:
        MOV      R0,#+300
        BL       OSTimeDly
??OnCommand_17:
        ADD      R0,SP,#+4
        BL       HwTestOutFunc
        MOVS     R0,#+3
        BL       TimeOverCheck
        CBZ      R0,??OnCommand_19
        MOV      R1,R7
        ADD      R0,R8,#+188
??OnCommand_20:
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        MOV      R1,#+1000
        MOVS     R0,#+3
        BL       TimerRegist
        B.N      ??OnCommand_8
??OnCommand_19:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??OnCommand_18
        LDR      R0,[R5, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        STRH     R0,[SP, #+0]
        LDRH     R0,[SP, #+0]
        CMP      R0,#+67
        BEQ.N    ??OnCommand_21
        CMP      R0,#+99
        BNE.N    ??OnCommand_22
??OnCommand_21:
        MOV      R1,R7
        ADD      R0,R8,#+208
??OnCommand_23:
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        B.N      ??OnCommand_8
??OnCommand_22:
        CMP      R0,#+70
        BEQ.N    ??OnCommand_24
        CMP      R0,#+102
        BNE.N    ??OnCommand_18
??OnCommand_24:
        BL       OS_CPU_SR_Save
        MOV      R9,R0
        LDR.N    R6,??OnCommand_9+0x8  ;; 0x8006800
        MOV      R0,R6
        BL       RoadBackuptobuffer
        LDR      R1,[R4, #+60]
        ORR      R1,R1,#0x1
        STR      R1,[R4, #+60]
        MOVS     R1,#+90
        STRB     R1,[R0, #+2]
        MOVW     R1,#+1954
        MOV      R0,R6
        BL       WriteBuffertoBackup
        MOV      R0,R9
        BL       OS_CPU_SR_Restore
        MOV      R1,R7
        ADD      R0,R8,#+228
        B.N      ??OnCommand_23
//  250 					}
//  251 				}
//  252 			}
//  253 		break;
//  254 		
//  255 		case 'A':
//  256 		case 'a':
//  257 		{
//  258 			char *tstmsg = "ADC/RAM";
//  259 			if(tTest.Analogin)
??OnCommand_1:
        LDR.W    R8,??OnCommand_9+0x4  ;; `?<Constant "AT24C64 Error Write F...">`
        ADD      R7,R8,#+248
        LDR      R0,[R4, #+60]
        TST      R0,#0x8
        BEQ.N    ??OnCommand_25
//  260 			{
//  261 				tdata = returnmsgTest(tstmsg);
//  262 			}
//  263 			if(tdata)
        MOV      R0,R7
        BL       returnmsgTest
        CMP      R0,#+0
        BEQ.W    ??OnCommand_8
//  264 			{
//  265 				INT16U nCnt;
//  266 
//  267 				SerPtr->printf("\n* [%s] TEST START TimeOut 5 Min]\n", tstmsg);
??OnCommand_25:
        LDR.W    R5,??DataTable21  ;; SerPtr
        MOV      R1,R7
        ADD      R0,R8,#+256
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  268 
//  269 				TimerRegist(TimerTest, Time1Sec*60L*5L);
        LDR.N    R1,??OnCommand_9+0xC  ;; 0x493e0
        MOVS     R0,#+3
        BL       TimerRegist
        B.N      ??OnCommand_26
//  270 
//  271 				while(1)
//  272 				{
//  273 					AdInputStatus();
//  274 
//  275 					if(TimeOverCheck(TimerTest))
//  276 					{
//  277 						SerPtr->printf("%s Test TimeOut\n", tstmsg);
//  278 
//  279 						TimerRegist(TimerTest, Time1Sec);
//  280 						break;
//  281 					}
//  282 					if(SerPtr->CheckByte(1, &nCnt))
//  283 					{
//  284 						nCnt = SerPtr->RxGetByte();
//  285 						if(nCnt == 'c' || nCnt == 'C')
//  286 						{
//  287 							SerPtr->printf("%s Test Canceled\n", tstmsg);
//  288 							break;
//  289 						}
//  290 						else if(nCnt == 'f' || nCnt == 'F')
//  291 						{
//  292 							INT32U cpu_sr;
//  293 							OS_ENTER_CRITICAL();
//  294 							{
//  295 								EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
//  296 
//  297 								tTest.Analogin = TRUE;
//  298 								ptr->AnalogTestBp = tTestOK;
//  299 								WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
//  300 							}
//  301 							OS_EXIT_CRITICAL();
//  302 							SerPtr->printf("%s Test Finished\n", tstmsg);
//  303 							break;
//  304 						}
//  305 					}
//  306 					OSTimeDly(2000L);
??OnCommand_27:
        MOV      R0,#+2000
        BL       OSTimeDly
??OnCommand_26:
        BL       AdInputStatus
        MOVS     R0,#+3
        BL       TimeOverCheck
        CBZ      R0,??OnCommand_28
??OnCommand_29:
        MOV      R1,R7
        ADD      R0,R8,#+292
        B.N      ??OnCommand_20
??OnCommand_28:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??OnCommand_27
        LDR      R0,[R5, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        STRH     R0,[SP, #+0]
        LDRH     R0,[SP, #+0]
        CMP      R0,#+99
        BEQ.N    ??OnCommand_30
        CMP      R0,#+67
        BNE.N    ??OnCommand_31
??OnCommand_30:
        MOV      R1,R7
        ADD      R0,R8,#+312
        B.N      ??OnCommand_23
??OnCommand_31:
        CMP      R0,#+102
        BEQ.N    ??OnCommand_32
        CMP      R0,#+70
        BNE.N    ??OnCommand_27
??OnCommand_32:
        BL       OS_CPU_SR_Save
        MOV      R9,R0
        LDR.N    R6,??OnCommand_9+0x8  ;; 0x8006800
        MOV      R0,R6
        BL       RoadBackuptobuffer
        LDR      R1,[R4, #+60]
        ORR      R1,R1,#0x8
        STR      R1,[R4, #+60]
        MOVS     R1,#+90
        STRB     R1,[R0, #+5]
??OnCommand_33:
        MOVW     R1,#+1954
        MOV      R0,R6
        BL       WriteBuffertoBackup
        MOV      R0,R9
        BL       OS_CPU_SR_Restore
        MOV      R1,R7
        ADD      R0,R8,#+332
??OnCommand_34:
        B.N      ??OnCommand_23
//  307 					/////////////////////////////////////////////////////////////
//  308 				}
//  309 			}
//  310 		}
//  311 		break;
//  312 
//  313 
//  314 		case 'I':
//  315 		case 'i':
//  316 		{
//  317 			char *tstmsg = "Dig Input";
//  318 			if(tTest.Input)
??OnCommand_5:
        LDR.W    R8,??OnCommand_9+0x4  ;; `?<Constant "AT24C64 Error Write F...">`
        ADD      R7,R8,#+352
        LDR      R0,[R4, #+60]
        TST      R0,#0x2
        BEQ.N    ??OnCommand_35
//  319 			{
//  320 				tdata = returnmsgTest(tstmsg);
//  321 			}
//  322 			if(tdata)
        MOV      R0,R7
        BL       returnmsgTest
        CMP      R0,#+0
        BEQ.W    ??OnCommand_8
//  323 			{
//  324 				INT16U nCnt;
//  325 
//  326 				SerPtr->printf("\n* [%s TEST START TimeOut 5 Min]\n", tstmsg);
??OnCommand_35:
        LDR.W    R5,??DataTable21  ;; SerPtr
        MOV      R1,R7
        ADD      R0,R8,#+364
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  327 				TimerRegist(TimerTest, Time1Sec*60L*5L);
        LDR.N    R1,??OnCommand_9+0xC  ;; 0x493e0
        MOVS     R0,#+3
        BL       TimerRegist
//  328 
//  329 				CurrentInputStatus(0);
        MOVS     R0,#+0
        BL       CurrentInputStatus
//  330 				tinputStsOld = tinputSts;
        LDR.N    R0,??DataTable11  ;; tinputStsOld
        LDR.N    R1,??DataTable12  ;; tinputSts
        MOVS     R2,#+52
        BL       __aeabi_memcpy4
        B.N      ??OnCommand_36
//  331 
//  332 				while(1)
//  333 				{
//  334 					CurrentInputStatus(1);
//  335 
//  336 					if(TimeOverCheck(TimerTest))
//  337 					{
//  338 						SerPtr->printf("%s Test TimeOut\n", tstmsg);
//  339 						TimerRegist(TimerTest, Time1Sec);
//  340 						break;
//  341 					}
//  342 					if(SerPtr->CheckByte(1, &nCnt))
//  343 					{
//  344 						nCnt = SerPtr->RxGetByte();
//  345 						if(nCnt == 'c' || nCnt == 'C')
//  346 						{
//  347 							SerPtr->printf("%s Test Canceled\n", tstmsg);
//  348 							break;
//  349 						}
//  350 						else if(nCnt == 'f' || nCnt == 'F')
//  351 						{
//  352 							INT32U cpu_sr;
//  353 
//  354 							OS_ENTER_CRITICAL();
//  355 							{
//  356 								EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
//  357 								
//  358 								tTest.Input = TRUE;
//  359 								ptr->InputTestBp = tTestOK;
//  360 								WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
//  361 							}
//  362 							OS_EXIT_CRITICAL();
//  363 							SerPtr->printf("%s Test Finished\n", tstmsg);
//  364 							break;
//  365 						}
//  366 					}
//  367 					OSTimeDly(300L);
??OnCommand_37:
        MOV      R0,#+300
        BL       OSTimeDly
??OnCommand_36:
        MOVS     R0,#+1
        BL       CurrentInputStatus
        MOVS     R0,#+3
        BL       TimeOverCheck
        CMP      R0,#+0
        BNE.N    ??OnCommand_29
??OnCommand_38:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??OnCommand_37
        LDR      R0,[R5, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        STRH     R0,[SP, #+0]
        LDRH     R0,[SP, #+0]
        CMP      R0,#+99
        BEQ.N    ??OnCommand_30
        CMP      R0,#+67
        BNE.N    ??OnCommand_39
??OnCommand_40:
        B.N      ??OnCommand_30
??OnCommand_39:
        CMP      R0,#+102
        BEQ.N    ??OnCommand_41
        CMP      R0,#+70
        BNE.N    ??OnCommand_37
??OnCommand_41:
        BL       OS_CPU_SR_Save
        MOV      R9,R0
        LDR.N    R6,??OnCommand_9+0x8  ;; 0x8006800
        MOV      R0,R6
        BL       RoadBackuptobuffer
        LDR      R1,[R4, #+60]
        ORR      R1,R1,#0x2
        STR      R1,[R4, #+60]
        MOVS     R1,#+90
        STRB     R1,[R0, #+3]
        B.N      ??OnCommand_33
//  368 					/////////////////////////////////////////////////////////////
//  369 				}
//  370 			}
//  371 		}				
//  372 		break;
//  373 
//  374 		case 'C':
//  375 		case 'c':
//  376 			{
//  377 				char *tstmsg = "COM";
??OnCommand_2:
        ADR.N    R7,??OnCommand_9  ;; "COM"
//  378 				if(tTest.Comm)
        LDR      R0,[R4, #+60]
        TST      R0,#0x4
        BEQ.N    ??OnCommand_42
//  379 				{
//  380 					tdata = returnmsgTest(tstmsg);
//  381 				}
//  382 				if(tdata)
        MOV      R0,R7
        BL       returnmsgTest
        CMP      R0,#+0
        BEQ.N    ??OnCommand_8
//  383 				{
//  384 					INT16U nCnt;
//  385 //					INT32U nFlag = 0;
//  386 					
//  387 					SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);
??OnCommand_42:
        LDR.W    R5,??DataTable21  ;; SerPtr
        LDR.W    R8,??OnCommand_9+0x4  ;; `?<Constant "AT24C64 Error Write F...">`
        MOV      R1,R7
        ADD      R0,R8,#+152
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  388 	
//  389 					TimerRegist(TimerTest, Time1Sec*60L*5L);
        LDR.N    R1,??OnCommand_9+0xC  ;; 0x493e0
        MOVS     R0,#+3
        BL       TimerRegist
        B.N      ??OnCommand_43
//  390 	
//  391 					while(1)
//  392 					{
//  393 						COMTestFunc();
//  394 
//  395 //						HwTestOutFunc(&nFlag);
//  396 						if(TimeOverCheck(TimerTest))
//  397 						{
//  398 							SerPtr->printf("%s test Test TimeOut\n", tstmsg);
//  399 							TimerRegist(TimerTest, Time1Sec);
//  400 							break;
//  401 						}
//  402 	
//  403 						if(SerPtr->CheckByte(1, &nCnt))
//  404 						{
//  405 							nCnt = SerPtr->RxGetByte();
//  406 							if(nCnt == 'C' || nCnt == 'c')
//  407 							{
//  408 								SerPtr->printf("%s test Test Canceled\n", tstmsg);
//  409 								break;
//  410 							}
//  411 							else if(nCnt == 'F' || nCnt == 'f')
//  412 							{
//  413 								INT32U cpu_sr;
//  414 
//  415 								OS_ENTER_CRITICAL();
//  416 								{
//  417 									EE_TABLE1 *ptr = (EE_TABLE1 *)RoadBackuptobuffer(vEE_TABLE1Addr);
//  418 									tTest.Comm = TRUE;
//  419 									ptr->COMTestBp = tTestOK;
//  420 									WriteBuffertoBackup(vEE_TABLE1Addr, sizeof(EE_TABLE1));
//  421 								}
//  422 								OS_EXIT_CRITICAL();
//  423 								SerPtr->printf("%s Test Test Finished\n", tstmsg);
//  424 								break;
//  425 							}
//  426 						}
//  427 						OSTimeDly(2000L);
??OnCommand_44:
        MOV      R0,#+2000
        BL       OSTimeDly
??OnCommand_43:
        BL       COMTestFunc
        MOVS     R0,#+3
        BL       TimeOverCheck
        CBZ      R0,??OnCommand_45
        MOV      R1,R7
        ADD      R0,R8,#+400
        B.N      ??OnCommand_20
??OnCommand_45:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??OnCommand_44
        LDR      R0,[R5, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        STRH     R0,[SP, #+0]
        LDRH     R0,[SP, #+0]
        CMP      R0,#+67
        BEQ.N    ??OnCommand_46
        CMP      R0,#+99
        BNE.N    ??OnCommand_47
??OnCommand_46:
        MOV      R1,R7
        ADD      R0,R8,#+424
        B.N      ??OnCommand_23
??OnCommand_47:
        CMP      R0,#+70
        BEQ.N    ??OnCommand_48
        CMP      R0,#+102
        BNE.N    ??OnCommand_44
??OnCommand_48:
        BL       OS_CPU_SR_Save
        MOV      R9,R0
        LDR.N    R6,??OnCommand_9+0x8  ;; 0x8006800
        MOV      R0,R6
        BL       RoadBackuptobuffer
        LDR      R1,[R4, #+60]
        ORR      R1,R1,#0x4
        STR      R1,[R4, #+60]
        MOVS     R1,#+90
        STRB     R1,[R0, #+4]
        MOVW     R1,#+1954
        MOV      R0,R6
        BL       WriteBuffertoBackup
        MOV      R0,R9
        BL       OS_CPU_SR_Restore
        MOV      R1,R7
        ADD      R0,R8,#+448
        B.N      ??OnCommand_23
//  428 					}
//  429 				}
//  430 			}
//  431 		break;
//  432 		
//  433 		case 'G':
//  434 		case 'g':
//  435 			DownloadFlagClr();
??OnCommand_4:
        BL       DownloadFlagClr
//  436 			ForDelay(20L);
        MOVS     R0,#+20
        BL       ForDelay
//  437 			DownLoadBootingJump();
        BL       DownLoadBootingJump
//  438 		break;
//  439 		
//  440 		case 'E':
//  441 		case 'e':
//  442 		break;
//  443 
//  444     	default:
//  445 		break;
//  446 
//  447 	}
//  448 	PromptOut();
??OnCommand_8:
        BL       PromptOut
//  449 }
        ADD      SP,SP,#+12
        POP      {R4-R9,PC}       ;; return
        Nop      
        DATA
??OnCommand_9:
        DC8      "COM"
        DC32     `?<Constant "AT24C64 Error Write F...">`
        DC32     0x8006800
        DC32     0x493e0

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable11:
        DC32     tinputStsOld

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable12:
        DC32     tinputSts
//  450 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  451 void AdcPrintf(char *sptr, INT16U rawData, INT8U is_5V)
//  452 {
AdcPrintf:
        PUSH     {R3-R7,LR}
        MOV      R5,R0
        MOV      R4,R1
//  453 	INT16U Data;
//  454 	if(is_5V) 	Data = AdctoVolt5opamp(rawData);
        CMP      R2,#+0
        MOV      R0,R4
        BEQ.N    ??AdcPrintf_0
        BL       AdctoVolt5opamp
        B.N      ??AdcPrintf_1
//  455 	else		Data = AdctoVolt33V(rawData);
??AdcPrintf_0:
        BL       AdctoVolt33V
??AdcPrintf_1:
        MOV      R7,R0
//  456 	
//  457 	SerPtr->printf(STARMSG);
        LDR.W    R6,??DataTable21  ;; SerPtr
        ADR.N    R0,??AdcPrintf_2  ;; 0x2A, 0x20, 0x00, 0x00
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  458 	SerPtr->printf("%s: %d.%d[V], [raw:%04d]", sptr, Data/10, Data%10, rawData);
        MOVS     R0,#+10
        SDIV     R2,R7,R0
        PUSH     {R4,LR}
        MLS      R3,R2,R0,R7
        MOV      R1,R5
        LDR.N    R0,??AdcPrintf_2+0x8  ;; `?<Constant "%s: %d.%d[V], [raw:%04d]">`
        LDR      R4,[R6, #+0]
        LDR      R4,[R4, #+16]
        BLX      R4
        ADD      SP,SP,#+8
//  459 	SerPtr->printf(ENTMSG);
        ADR.N    R0,??AdcPrintf_2+0x4  ;; "\n"
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+16]
        POP      {R2,R4-R7,LR}
        BX       R1
        DATA
??AdcPrintf_2:
        DC8      0x2A, 0x20, 0x00, 0x00
        DC8      "\n",+0,+0
        DC32     `?<Constant "%s: %d.%d[V], [raw:%04d]">`
//  460 }
//  461 
//  462 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  463 INT8U returnmsgTest(char *str)
//  464 {
returnmsgTest:
        PUSH     {R7,LR}
//  465 	SerPtr->printf("%s이 수행되어 있습니다. 계속 진행하시겠습니까?[Y]es, [C]ancel\n", str);
        MOV      R1,R0
        LDR.N    R0,??WaringMssageReturn_0  ;; `?<Constant "%s\\300\\314 \\274\\366\\307\\340\\265\\30`
        LDR.W    R2,??DataTable21  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  466 	return WaringMssageReturn();
        POP      {R0,LR}
        REQUIRE WaringMssageReturn
        ;; // Fall through to label WaringMssageReturn
//  467 }
//  468 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  469 INT8U WaringMssageReturn(void)
//  470 {
WaringMssageReturn:
        PUSH     {R3-R5,LR}
//  471 	INT16U nCnt;
//  472 
//  473 	TimerRegist(TimerTest, Time1Sec*5L);
        MOVW     R5,#+5000
        MOV      R1,R5
        MOVS     R0,#+3
        BL       TimerRegist
        LDR.W    R4,??DataTable21  ;; SerPtr
        B.N      ??WaringMssageReturn_1
//  474 
//  475 	while(1)
//  476 	{
//  477 		if(TimeOverCheck(TimerTest))
//  478 		{
//  479 			TimerRegist(TimerTest, Time1Sec*5L);
//  480 			return TRUE;
//  481 		}
//  482 		if(SerPtr->CheckByte(1, &nCnt))
//  483 		{
//  484 			nCnt = SerPtr->RxGetByte();
//  485 			if(nCnt == 'C' || nCnt == 'c')
//  486 			{
//  487 				SerPtr->printf("CANCEL TEST \n");
//  488 				return FALSE;
//  489 			}
//  490 			else return TRUE;
//  491 		}
//  492 		OSTimeDly(10L);
??WaringMssageReturn_2:
        MOVS     R0,#+10
        BL       OSTimeDly
??WaringMssageReturn_1:
        MOVS     R0,#+3
        BL       TimeOverCheck
        CBZ      R0,??WaringMssageReturn_3
        MOV      R1,R5
        MOVS     R0,#+3
        BL       TimerRegist
        B.N      ??WaringMssageReturn_4
??WaringMssageReturn_3:
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+4]
        BLX      R2
        CMP      R0,#+0
        BEQ.N    ??WaringMssageReturn_2
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+8]
        BLX      R0
        STRH     R0,[SP, #+0]
        LDRH     R0,[SP, #+0]
        CMP      R0,#+67
        BEQ.N    ??WaringMssageReturn_5
        CMP      R0,#+99
        BNE.N    ??WaringMssageReturn_4
??WaringMssageReturn_5:
        LDR.N    R0,??WaringMssageReturn_0+0x4  ;; `?<Constant "CANCEL TEST \\n">`
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
??WaringMssageReturn_4:
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}    ;; return
        DATA
??WaringMssageReturn_0:
        DC32     `?<Constant "%s\\300\\314 \\274\\366\\307\\340\\265\\30`
        DC32     `?<Constant "CANCEL TEST \\n">`
//  493 	}
//  494 }
//  495 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  496 void PrintLogo(void)
//  497 {
PrintLogo:
        PUSH     {R3-R7,LR}
//  498 	EE_TABLE1 *ptr = vEE_TABLE1;
//  499 
//  500 	
//  501 	if(ptr->OutputTestBp == tTestOK)		tTest.Output = TRUE;
        LDR.N    R4,??DataTable17  ;; tIndex
        LDR.N    R0,??Subroutine0_0+0x4  ;; 0x8006802
        LDRB     R1,[R0, #+0]
        CMP      R1,#+90
        LDR      R1,[R4, #+60]
        ITEE     EQ 
        ORREQ    R1,R1,#0x1
        MOVNE    R2,#+1
        BICNE    R1,R1,R2
//  502 	else									tTest.Output = FALSE;
        STR      R1,[R4, #+60]
//  503 
//  504 	if(ptr->InputTestBp == tTestOK)  		tTest.Input = TRUE;
        LDRB     R1,[R0, #+1]
        CMP      R1,#+90
        LDR      R1,[R4, #+60]
        ITE      EQ 
        ORREQ    R1,R1,#0x2
        BICNE    R1,R1,#0x2
//  505 	else									tTest.Input = FALSE;
        STR      R1,[R4, #+60]
//  506 
//  507 	if(ptr->COMTestBp == tTestOK)  			tTest.Comm = TRUE;
        LDRB     R1,[R0, #+2]
        CMP      R1,#+90
        LDR      R1,[R4, #+60]
        ITE      EQ 
        ORREQ    R1,R1,#0x4
        BICNE    R1,R1,#0x4
//  508 	else								    tTest.Comm = FALSE;
        STR      R1,[R4, #+60]
//  509 
//  510 	if(ptr->AnalogTestBp == tTestOK)  		tTest.Analogin = TRUE;
        LDRB     R1,[R0, #+3]
        CMP      R1,#+90
        LDR      R1,[R4, #+60]
        ITE      EQ 
        ORREQ    R1,R1,#0x8
        BICNE    R1,R1,#0x8
//  511 	else								    tTest.Analogin = FALSE;
        STR      R1,[R4, #+60]
//  512 
//  513 	if(ptr->eepromBp == tTestOK)  			tTest.eeprom = TRUE;
        LDRB     R0,[R0, #+4]
        CMP      R0,#+90
        LDR      R0,[R4, #+60]
        ITE      EQ 
        ORREQ    R0,R0,#0x10
        BICNE    R0,R0,#0x10
//  514 	else								    tTest.eeprom = FALSE;
        STR      R0,[R4, #+60]
//  515 
//  516 	SerPtr->printf("\n\n");
        LDR.W    R5,??DataTable21  ;; SerPtr
        ADR.N    R0,??Subroutine0_0  ;; 0x0A, 0x0A, 0x00, 0x00
        LDR      R1,[R5, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  517 	PrintStar();
        BL       PrintStar
//  518 	SerPtr->printf("* %s VER:%d.%d\n", BoardTestMode, (SystemVer >> 4)& 0x0f,  SystemVer & 0x0f);
        LDR.N    R6,??Subroutine0_0+0x8  ;; `?<Constant "* %s VER:%d.%d\\n">`
        MOVS     R3,#+1
        MOVS     R2,#+0
        ADD      R1,R6,#+16
        MOV      R0,R6
        LDR      R7,[R5, #+0]
        LDR      R7,[R7, #+16]
        BLX      R7
//  519 
//  520 	SerPtr->printf("    -COMMAND 1st-\n");
        ADD      R0,R6,#+48
        LDR      R1,[R5, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  521 	SerPtr->printf("*  ?        : help(this message)\n");
        ADD      R0,R6,#+68
        LDR      R1,[R5, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  522     SerPtr->printf("*  C        : com test              [%s]\n", testResult[tTest.Comm]);
        LDR      R0,[R4, #+60]
        AND      R0,R0,#0x4
        LSRS     R0,R0,#+2
        ADD      R0,R4,R0, LSL #+2
        LDR      R1,[R0, #+64]
        ADD      R0,R6,#+104
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  523 	SerPtr->printf("*  O        : output test           [%s]\n", testResult[tTest.Output]);
        LDR      R0,[R4, #+60]
        AND      R0,R0,#0x1
        ADD      R0,R4,R0, LSL #+2
        LDR      R1,[R0, #+64]
        ADD      R0,R6,#+148
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  524 	SerPtr->printf("*  I        : input test            [%s]\n", testResult[tTest.Input]);
        LDR      R0,[R4, #+60]
        AND      R0,R0,#0x2
        LSRS     R0,R0,#+1
        ADD      R0,R4,R0, LSL #+2
        LDR      R1,[R0, #+64]
        ADD      R0,R6,#+192
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  525     SerPtr->printf("*  A        : ADC/RAM               [%s]\n", testResult[tTest.Analogin]);
        LDR      R0,[R4, #+60]
        AND      R0,R0,#0x8
        LSRS     R0,R0,#+3
        ADD      R0,R4,R0, LSL #+2
        LDR      R1,[R0, #+64]
        ADD      R0,R6,#+236
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  526     SerPtr->printf("*  F        : EERROM                [%s]\n", testResult[tTest.eeprom]);
        LDR      R0,[R4, #+60]
        AND      R0,R0,#0x10
        LSRS     R0,R0,#+4
        ADD      R0,R4,R0, LSL #+2
        LDR      R1,[R0, #+64]
        ADD      R0,R6,#+280
        LDR      R2,[R5, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
//  527 	SerPtr->printf("*  G        : compulsory boot(eeprom)\n");
        ADD      R0,R6,#+324
        LDR      R1,[R5, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  528 	PrintStar();
        POP      {R0,R4-R7,LR}
        Nop      
        REQUIRE PrintStar
        ;; // Fall through to label PrintStar
//  529 }
//  530 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  531 void PrintStar(void)
//  532 {
//  533 	SerPtr->printf("*******************************************************************************\n");
PrintStar:
        LDR.N    R0,??Subroutine0_0+0xC  ;; `?<Constant "*********************...">`
        Nop      
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  534 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine0:
        LDR.W    R1,??DataTable21  ;; SerPtr
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BX       R1
        Nop      
        DATA
??Subroutine0_0:
        DC8      0x0A, 0x0A, 0x00, 0x00
        DC32     0x8006802
        DC32     `?<Constant "* %s VER:%d.%d\\n">`
        DC32     `?<Constant "*********************...">`

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     tIndex
//  535 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  536 void PromptOut(void)
//  537 {
//  538 	SerPtr->printf("TRIO >>");
PromptOut:
        LDR.N    R0,??PromptOut_0  ;; `?<Constant "TRIO >>">`
        B.N      ?Subroutine0
        DATA
??PromptOut_0:
        DC32     `?<Constant "TRIO >>">`
//  539 }
//  540 
//  541 

        SECTION `.bss`:DATA:NOROOT(2)
//  542 INT32U comtstcnt = 0;
comtstcnt:
        DS8 4
//  543 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  544 void COMTestFunc(void)
//  545 {
COMTestFunc:
        PUSH     {R3-R7,LR}
//  546 	INT16U Recv;
//  547 
//  548 	{
//  549 		pUSART1.printf(STARMSG);
        LDR.N    R4,??COMTestFunc_0+0x8  ;; pUSART1
        ADR.N    R0,??COMTestFunc_0  ;; 0x2A, 0x20, 0x00, 0x00
        LDR      R1,[R4, #+16]
        BLX      R1
//  550 		pUSART1.printf("통신시험 Ser4[MODEM] 시험을 체크하여 주세요     ");
        LDR.N    R5,??COMTestFunc_0+0xC  ;; `?<Constant "\\305\\353\\275\\305\\275\\303\\307\\350 S`
        MOV      R0,R5
        LDR      R1,[R4, #+16]
        BLX      R1
//  551 		pUSART4.BuffClear();
        LDR.N    R7,??COMTestFunc_0+0x10  ;; pUSART4
        LDR      R0,[R7, #+32]
        BLX      R0
//  552 		pUSART4.PutToBuffer(comtstcnt & 0x0f);		
        LDR.N    R6,??COMTestFunc_0+0x14  ;; comtstcnt
        LDR      R0,[R6, #+0]
        AND      R0,R0,#0xF
        LDR      R1,[R7, #+24]
        BLX      R1
//  553 
//  554 		OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
//  555 
//  556 		if(pUSART4.CheckByte(1, &Recv))
        ADD      R1,SP,#+0
        MOVS     R0,#+1
        LDR      R2,[R7, #+4]
        BLX      R2
        CBZ      R0,??COMTestFunc_1
//  557 		{
//  558 			if( pUSART4.RxGetByte() == (comtstcnt & 0x0f)// &&
//  559 				//pUSART3.RxGetByte() == 'b' &&
//  560 				//pUSART3.RxGetByte() == 'i' &&
//  561 				//pUSART3.RxGetByte() == 'z' &&
//  562 				//pUSART3.RxGetByte() == 'i'
//  563 				)
        LDR      R0,[R7, #+8]
        BLX      R0
        LDR      R1,[R4, #+16]
        LDR      R2,[R6, #+0]
        AND      R2,R2,#0xF
        CMP      R0,R2
        ITE      NE 
        ADDNE    R0,R5,#+60
        ADDEQ    R0,R5,#+52
//  564 						pUSART1.printf("[OK]");
        BLX      R1
        B.N      ??COMTestFunc_2
//  565 			else		pUSART1.printf("[FAIL 1]");
//  566 		}
//  567 		else pUSART1.printf("[FAIL 2]: %d", Recv);
??COMTestFunc_1:
        LDRH     R1,[SP, #+0]
        ADD      R0,R5,#+72
        LDR      R2,[R4, #+16]
        BLX      R2
//  568 		pUSART1.printf(ENTMSG);
??COMTestFunc_2:
        ADR.N    R5,??COMTestFunc_0+0x4  ;; "\n"
        MOV      R0,R5
        LDR      R1,[R4, #+16]
        BLX      R1
//  569 	}
//  570 		
//  571 
//  572 	pUSART1.printf(ENTMSG);
        MOV      R0,R5
        LDR      R1,[R4, #+16]
        BLX      R1
//  573 	pUSART1.printf(ENTMSG);
        MOV      R0,R5
        LDR      R1,[R4, #+16]
        BLX      R1
//  574 	comtstcnt++;
        LDR      R0,[R6, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[R6, #+0]
//  575 }
        POP      {R0,R4-R7,PC}    ;; return
        DATA
??COMTestFunc_0:
        DC8      0x2A, 0x20, 0x00, 0x00
        DC8      "\n",+0,+0
        DC32     pUSART1
        DC32     `?<Constant "\\305\\353\\275\\305\\275\\303\\307\\350 S`
        DC32     pUSART4
        DC32     comtstcnt
//  576 
//  577 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  578 void AdInputStatus(void)
//  579 {
AdInputStatus:
        PUSH     {R3-R11,LR}
//  580 ////////////////////////////////////////////////////////////////////////////////
//  581 	PrintStar();
        BL       PrintStar
//  582 	{
//  583 //		INT16S Data, tmpx;
//  584 //        INT16S Data;
//  585 //        INT16S tmpx;
//  586 
//  587 //		INT8U	i;
//  588 #if 0
//  589 		ADC_DATA[11] = ADC_AVR[11][0];
//  590 		ADC_DATA[17] = ADC_AVR[17][0];
//  591 		ADC_DATA[23] = ADC_AVR[23][0];
//  592 		ADC_DATA[29] = ADC_AVR[29][0];
//  593 #endif
//  594 #if 1
//  595 		SerPtr->printf("10: iAdcIndex[%d]:[%d][%d]\n",10,ADC_DATA1[10],ADC_AVR[10][0]); 	
        LDR.N    R4,??DataTable21  ;; SerPtr
        LDR.W    R8,??AdInputStatus_0+0x8  ;; `?<Constant "10: iAdcIndex[%d]:[%d...">`
        LDR.N    R7,??AdInputStatus_0+0xC  ;; ADC_DATA1
        LDR.N    R6,??AdInputStatus_0+0x10  ;; ADC_AVR
        LDRH     R3,[R6, #+200]
        LDRH     R2,[R7, #+20]
        MOVS     R1,#+10
        MOV      R0,R8
        LDR      R5,[R4, #+0]
        LDR      R12,[R5, #+16]
        BLX      R12
//  596 		SerPtr->printf("16: iAdcIndex[%d]:[%d][%d]\n",16,ADC_DATA1[16],ADC_AVR[16][0]); 	
        ADD      R0,R6,#+280
        STR      R0,[SP, #+0]
        ADDS     R7,R7,#+20
        LDRH     R3,[R0, #+40]
        LDRH     R2,[R7, #+12]
        MOVS     R1,#+16
        ADD      R0,R8,#+28
        LDR      R5,[R4, #+0]
        LDR      R12,[R5, #+16]
        BLX      R12
//  597 		SerPtr->printf("22: iAdcIndex[%d]:[%d][%d]\n",22,ADC_DATA1[22],ADC_AVR[22][0]); 	
        LDRH     R3,[R6, #+440]
        LDRH     R2,[R7, #+24]
        MOVS     R1,#+22
        ADD      R0,R8,#+56
        LDR      R5,[R4, #+0]
        LDR      R12,[R5, #+16]
        BLX      R12
//  598 		SerPtr->printf("28: iAdcIndex[%d]:[%d][%d]\n",28,ADC_DATA1[28],ADC_AVR[28][0]);	
        ADD      R11,R6,#+520
        LDRH     R3,[R11, #+40]
        LDRH     R2,[R7, #+36]
        MOVS     R1,#+28
        ADD      R0,R8,#+84
        LDR      R5,[R4, #+0]
        LDR      R12,[R5, #+16]
        BLX      R12
//  599 	
//  600 
//  601 
//  602 		SerPtr->printf("11: iAdcIndex[%d]:[%d][%d]\n",11,ADC_DATA1[11],ADC_AVR[11][0]); 	
        ADD      R5,R6,#+200
        LDRH     R3,[R5, #+20]
        LDRH     R2,[R7, #+2]
        MOVS     R1,#+11
        ADD      R0,R8,#+112
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  603 		SerPtr->printf("17: iAdcIndex[%d]:[%d][%d]\n",17,ADC_DATA1[17],ADC_AVR[17][0]); 	
        LDR      R0,[SP, #+0]
        LDRH     R3,[R0, #+60]
        LDRH     R2,[R7, #+14]
        MOVS     R1,#+17
        ADD      R0,R8,#+140
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  604 		SerPtr->printf("23: iAdcIndex[%d]:[%d][%d]\n",23,ADC_DATA1[23],ADC_AVR[23][0]); 	
        ADD      R10,R6,#+440
        LDRH     R3,[R10, #+20]
        LDRH     R2,[R7, #+26]
        MOVS     R1,#+23
        ADD      R0,R8,#+168
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  605 		SerPtr->printf("29: iAdcIndex[%d]:[%d][%d]\n",29,ADC_DATA1[29],ADC_AVR[29][0]);	
        LDRH     R3,[R11, #+60]
        LDRH     R2,[R7, #+38]
        MOVS     R1,#+29
        ADD      R0,R8,#+196
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  606 
//  607 		SerPtr->printf("12: iAdcIndex[%d]:[%d][%d]\n",12,ADC_DATA1[12],ADC_AVR[12][0]); 	
        LDRH     R3,[R5, #+40]
        LDRH     R2,[R7, #+4]
        MOVS     R1,#+12
        ADD      R0,R8,#+224
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  608 		SerPtr->printf("18: iAdcIndex[%d]:[%d][%d]\n",18,ADC_DATA1[18],ADC_AVR[18][0]); 	
        LDRH     R3,[R6, #+360]
        LDRH     R2,[R7, #+16]
        MOVS     R1,#+18
        ADD      R0,R8,#+252
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  609 		SerPtr->printf("24: iAdcIndex[%d]:[%d][%d]\n",24,ADC_DATA1[24],ADC_AVR[24][0]); 	
        LDRH     R3,[R10, #+40]
        LDRH     R2,[R7, #+28]
        MOVS     R1,#+24
        ADD      R0,R8,#+280
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  610 		SerPtr->printf("30: iAdcIndex[%d]:[%d][%d]\n",30,ADC_DATA1[30],ADC_AVR[30][0]);	
        LDRH     R3,[R6, #+600]
        LDRH     R2,[R7, #+40]
        MOVS     R1,#+30
        ADD      R0,R8,#+308
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  611 #endif	
//  612 
//  613 
//  614 #if 1
//  615 		SerPtr->printf("13: iAdcIndex[%d]:[%d][%d]\n",13,ADC_DATA1[13],ADC_AVR[13][0]); 	
        LDRH     R3,[R5, #+60]
        LDRH     R2,[R7, #+6]
        MOVS     R1,#+13
        ADD      R0,R8,#+336
        LDR      R5,[R4, #+0]
        LDR      R12,[R5, #+16]
        BLX      R12
//  616 		SerPtr->printf("19: iAdcIndex[%d]:[%d][%d]\n",19,ADC_DATA1[19],ADC_AVR[19][0]); 	
        ADD      R9,R6,#+360
        LDRH     R3,[R9, #+20]
        LDRH     R2,[R7, #+18]
        MOVS     R1,#+19
        ADD      R0,R8,#+364
        LDR      R5,[R4, #+0]
        LDR      R12,[R5, #+16]
        BLX      R12
//  617 		SerPtr->printf("25: iAdcIndex[%d]:[%d][%d]\n",25,ADC_DATA1[25],ADC_AVR[25][0]); 	
        LDRH     R3,[R10, #+60]
        LDRH     R2,[R7, #+30]
        MOVS     R1,#+25
        ADD      R0,R8,#+392
        LDR      R5,[R4, #+0]
        LDR      R12,[R5, #+16]
        BLX      R12
//  618 		SerPtr->printf("31: iAdcIndex[%d]:[%d][%d]\n",31,ADC_DATA1[31],ADC_AVR[31][0]);	
        ADD      R5,R6,#+600
        LDRH     R3,[R5, #+20]
        LDRH     R2,[R7, #+42]
        MOVS     R1,#+31
        ADD      R0,R8,#+420
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  619 
//  620 		SerPtr->printf("14: iAdcIndex[%d]:[%d][%d]\n",14,ADC_DATA1[14],ADC_AVR[14][0]); 	
        LDRH     R3,[R6, #+280]
        LDRH     R2,[R7, #+8]
        MOVS     R1,#+14
        ADD      R0,R8,#+448
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  621 		SerPtr->printf("20: iAdcIndex[%d]:[%d][%d]\n",20,ADC_DATA1[20],ADC_AVR[20][0]); 	
        LDRH     R3,[R9, #+40]
        LDRH     R2,[R7, #+20]
        MOVS     R1,#+20
        ADD      R0,R8,#+476
        LDR      R12,[R4, #+0]
        LDR      R12,[R12, #+16]
        BLX      R12
//  622 		SerPtr->printf("26: iAdcIndex[%d]:[%d][%d]\n",26,ADC_DATA1[26],ADC_AVR[26][0]); 	
        LDRH     R3,[R6, #+520]
        LDRH     R2,[R7, #+32]
        MOVS     R1,#+26
        ADD      R0,R8,#+504
        LDR      R6,[R4, #+0]
        LDR      R6,[R6, #+16]
        BLX      R6
//  623 		SerPtr->printf("32: iAdcIndex[%d]:[%d][%d]\n",32,ADC_DATA1[32],ADC_AVR[32][0]);	
        LDRH     R3,[R5, #+40]
        LDRH     R2,[R7, #+44]
        MOVS     R1,#+32
        ADD      R0,R8,#+532
        LDR      R6,[R4, #+0]
        LDR      R6,[R6, #+16]
        BLX      R6
//  624 #endif		
//  625 #if 1
//  626 
//  627 		SerPtr->printf("15: iAdcIndex[%d]:[%d][%d]\n",15,ADC_DATA1[15],ADC_AVR[15][0]); 	
        LDR      R0,[SP, #+0]
        LDRH     R3,[R0, #+20]
        LDRH     R2,[R7, #+10]
        MOVS     R1,#+15
        ADD      R0,R8,#+560
        LDR      R6,[R4, #+0]
        LDR      R6,[R6, #+16]
        BLX      R6
//  628 		SerPtr->printf("21: iAdcIndex[%d]:[%d][%d]\n",21,ADC_DATA1[21],ADC_AVR[21][0]); 	
        LDRH     R3,[R9, #+60]
        LDRH     R2,[R7, #+22]
        MOVS     R1,#+21
        ADD      R0,R8,#+588
        LDR      R6,[R4, #+0]
        LDR      R6,[R6, #+16]
        BLX      R6
//  629 		SerPtr->printf("27: iAdcIndex[%d]:[%d][%d]\n",27,ADC_DATA1[27],ADC_AVR[27][0]); 	
        LDRH     R3,[R11, #+20]
        LDRH     R2,[R7, #+34]
        MOVS     R1,#+27
        ADD      R0,R8,#+616
        LDR      R6,[R4, #+0]
        LDR      R6,[R6, #+16]
        BLX      R6
//  630 		SerPtr->printf("33: iAdcIndex[%d]:[%d][%d]\n",33,ADC_DATA1[33],ADC_AVR[33][0]);	
        LDRH     R3,[R5, #+60]
        LDRH     R2,[R7, #+46]
        MOVS     R1,#+33
        ADD      R0,R8,#+644
        LDR      R5,[R4, #+0]
        LDR      R8,[R5, #+16]
        BLX      R8
//  631 #endif		
//  632 
//  633 
//  634 
//  635 
//  636 
//  637 #if 0
//  638 		Data = AdctoVolt33V(ADC_DATA[Curr_Temp]);
//  639 		tmpx = ReadEnvTempTable(Curr_Temp);
//  640 		SerPtr->printf(STARMSG);
//  641 		SerPtr->printf("TEMP: %d.%03d[V], %d.%d['C]\n", Data/1000, Data%1000, tmpx/10, abs(Data%10));
//  642 #endif		
//  643 
//  644 #if 0
//  645 #if 0
//  646 		Data = AdctoVolt33V(ADC_DATA[0]);
//  647 		SerPtr->printf(STARMSG);
//  648 		SerPtr->printf("DET0  : %d.%03d[V]\n", Data/1000, Data%1000);
//  649 
//  650 		Data = AdctoVolt33V(ADC_DATA[1]);
//  651 		SerPtr->printf(STARMSG);
//  652 		SerPtr->printf("DET1  : %d.%03d[V]\n", Data/1000, Data%1000);
//  653 
//  654 		Data = AdctoVolt33V(ADC_DATA[2]);
//  655 		SerPtr->printf(STARMSG);
//  656 		SerPtr->printf("DET2 : %d.%03d[V]\n", Data/1000, Data%1000);
//  657 
//  658 
//  659 		Data = AdctoVolt33V(ADC_DATA[3]);
//  660 		SerPtr->printf(STARMSG);
//  661 		SerPtr->printf("DET3 : %d.%03d[V]\n", Data/1000, Data%1000);
//  662 
//  663 
//  664 		Data = AdctoVolt33V(ADC_DATA[4]);
//  665 		SerPtr->printf(STARMSG);
//  666 		SerPtr->printf("DET4 : %d.%03d[V]\n", Data/1000, Data%1000);
//  667 
//  668 
//  669 		Data = AdctoVolt33V(ADC_DATA[5]);
//  670 		SerPtr->printf(STARMSG);
//  671 		SerPtr->printf("DET5 : %d.%03d[V]\n", Data/1000, Data%1000);
//  672 
//  673 		Data = AdctoVolt33V(ADC_DATA[6]);
//  674 		SerPtr->printf(STARMSG);
//  675 		SerPtr->printf("DET6 : %d.%03d[V]\n", Data/1000, Data%1000);
//  676 
//  677 		Data = AdctoVolt33V(ADC_DATA[7]);
//  678 		SerPtr->printf(STARMSG);
//  679 		SerPtr->printf("DET7 : %d.%03d[V]\n", Data/1000, Data%1000);
//  680 
//  681 		Data = AdctoVolt33V(ADC_DATA[8]);
//  682 		SerPtr->printf(STARMSG);
//  683 		SerPtr->printf("DET8 : %d.%03d[V]\n", Data/1000, Data%1000);
//  684 
//  685 
//  686 		Data = AdctoVolt33V(ADC_DATA[9]);
//  687 		SerPtr->printf(STARMSG);
//  688 		SerPtr->printf("DET9 : %d.%03d[V]\n", Data/1000, Data%1000);
//  689 #endif
//  690 		Data = AdctoVolt33V(ADC_DATA[10]);
//  691 		SerPtr->printf(STARMSG);
//  692 		SerPtr->printf("DET10 : %d.%03d[V]\n", Data/1000, Data%1000);
//  693 
//  694 		Data = AdctoVolt33V(ADC_DATA[11]);
//  695 		SerPtr->printf(STARMSG);
//  696 		SerPtr->printf("DET11  : %d.%03d[V]\n", Data/1000, Data%1000);
//  697 
//  698 		Data = AdctoVolt33V(ADC_DATA[12]);
//  699 		SerPtr->printf(STARMSG);
//  700 		SerPtr->printf("DET12 : %d.%03d[V]\n", Data/1000, Data%1000);
//  701 
//  702 
//  703 		Data = AdctoVolt33V(ADC_DATA[13]);
//  704 		SerPtr->printf(STARMSG);
//  705 		SerPtr->printf("DET13 : %d.%03d[V]\n", Data/1000, Data%1000);
//  706 
//  707 
//  708 		Data = AdctoVolt33V(ADC_DATA[14]);
//  709 		SerPtr->printf(STARMSG);
//  710 		SerPtr->printf("DET14 : %d.%03d[V]\n", Data/1000, Data%1000);
//  711 
//  712 
//  713 		Data = AdctoVolt33V(ADC_DATA[15]);
//  714 		SerPtr->printf(STARMSG);
//  715 		SerPtr->printf("DET15 : %d.%03d[V]\n", Data/1000, Data%1000);
//  716 
//  717 
//  718 		Data = AdctoVolt33V(ADC_DATA[16]);
//  719 		SerPtr->printf(STARMSG);
//  720 		SerPtr->printf("DET16 : %d.%03d[V]\n", Data/1000, Data%1000);
//  721 
//  722 		Data = AdctoVolt33V(ADC_DATA[17]);
//  723 		SerPtr->printf(STARMSG);
//  724 		SerPtr->printf("DET17 : %d.%03d[V]\n", Data/1000, Data%1000);
//  725 
//  726 		Data = AdctoVolt33V(ADC_DATA[18]);
//  727 		SerPtr->printf(STARMSG);
//  728 		SerPtr->printf("DET18 : %d.%03d[V]\n", Data/1000, Data%1000);
//  729 
//  730 
//  731 		Data = AdctoVolt33V(ADC_DATA[19]);
//  732 		SerPtr->printf(STARMSG);
//  733 		SerPtr->printf("DET19 : %d.%03d[V]\n", Data/1000, Data%1000);
//  734 
//  735 ///
//  736 
//  737 		Data = AdctoVolt33V(ADC_DATA[20]);
//  738 		SerPtr->printf(STARMSG);
//  739 		SerPtr->printf("DET20  : %d.%03d[V]\n", Data/1000, Data%1000);
//  740 
//  741 		Data = AdctoVolt33V(ADC_DATA[21]);
//  742 		SerPtr->printf(STARMSG);
//  743 		SerPtr->printf("DET21  : %d.%03d[V]\n", Data/1000, Data%1000);
//  744 
//  745 		Data = AdctoVolt33V(ADC_DATA[22]);
//  746 		SerPtr->printf(STARMSG);
//  747 		SerPtr->printf("DET22 : %d.%03d[V]\n", Data/1000, Data%1000);
//  748 
//  749 
//  750 		Data = AdctoVolt33V(ADC_DATA[23]);
//  751 		SerPtr->printf(STARMSG);
//  752 		SerPtr->printf("DET23 : %d.%03d[V]\n", Data/1000, Data%1000);
//  753 
//  754 
//  755 		Data = AdctoVolt33V(ADC_DATA[24]);
//  756 		SerPtr->printf(STARMSG);
//  757 		SerPtr->printf("DET24 : %d.%03d[V]\n", Data/1000, Data%1000);
//  758 
//  759 
//  760 		Data = AdctoVolt33V(ADC_DATA[25]);
//  761 		SerPtr->printf(STARMSG);
//  762 		SerPtr->printf("DET25 : %d.%03d[V]\n", Data/1000, Data%1000);
//  763 
//  764 		Data = AdctoVolt33V(ADC_DATA[26]);
//  765 		SerPtr->printf(STARMSG);
//  766 		SerPtr->printf("DET26 : %d.%03d[V]\n", Data/1000, Data%1000);
//  767 
//  768 		Data = AdctoVolt33V(ADC_DATA[27]);
//  769 		SerPtr->printf(STARMSG);
//  770 		SerPtr->printf("DET27 : %d.%03d[V]\n", Data/1000, Data%1000);
//  771 
//  772 		Data = AdctoVolt33V(ADC_DATA[28]);
//  773 		SerPtr->printf(STARMSG);
//  774 		SerPtr->printf("DET28 : %d.%03d[V]\n", Data/1000, Data%1000);
//  775 
//  776 
//  777 		Data = AdctoVolt33V(ADC_DATA[29]);
//  778 		SerPtr->printf(STARMSG);
//  779 		SerPtr->printf("DET29 : %d.%03d[V]\n", Data/1000, Data%1000);
//  780 
//  781 		Data = AdctoVolt33V(ADC_DATA[30]);
//  782 		SerPtr->printf(STARMSG);
//  783 		SerPtr->printf("DET30  : %d.%03d[V]\n", Data/1000, Data%1000);
//  784 
//  785 		Data = AdctoVolt33V(ADC_DATA[31]);
//  786 		SerPtr->printf(STARMSG);
//  787 		SerPtr->printf("DET31  : %d.%03d[V]\n", Data/1000, Data%1000);
//  788 
//  789 		Data = AdctoVolt33V(ADC_DATA[32]);
//  790 		SerPtr->printf(STARMSG);
//  791 		SerPtr->printf("DET32 : %d.%03d[V]\n", Data/1000, Data%1000);
//  792 
//  793 
//  794 		Data = AdctoVolt33V(ADC_DATA[33]);
//  795 		SerPtr->printf(STARMSG);
//  796 		SerPtr->printf("DET33 : %d.%03d[V]\n", Data/1000, Data%1000);
//  797 #endif
//  798 
//  799 #if 0
//  800 		i = 0;
//  801 		ADC_Select(i);
//  802 //		OSTimeDly(5);
//  803 		GetAdcValue(ADC_Channel_11);	// 
//  804 //		OSTimeDly(5);
//  805 		
//  806 		Data = AdctoVolt33V(ADC_DATA[11]);
//  807 		SerPtr->printf(STARMSG);
//  808 		SerPtr->printf("DET11[%d]  : %d.%03d[V]\n",i ,Data/1000, Data%1000);
//  809 
//  810 		i = 1;
//  811 		ADC_Select(i);
//  812 		GetAdcValue(ADC_Channel_11);	// 
//  813 		Data = AdctoVolt33V(ADC_DATA[11]);
//  814 		SerPtr->printf(STARMSG);
//  815 		SerPtr->printf("DET11[%d]  : %d.%03d[V]\n",i ,Data/1000, Data%1000);
//  816 
//  817 		
//  818 		i = 2;
//  819 		ADC_Select(i);
//  820 		GetAdcValue(ADC_Channel_11);	// 
//  821 		
//  822 		Data = AdctoVolt33V(ADC_DATA[11]);
//  823 		SerPtr->printf(STARMSG);
//  824 		SerPtr->printf("DET11[%d]  : %d.%03d[V]\n",i ,Data/1000, Data%1000);
//  825 
//  826 		i = 3;
//  827 		ADC_Select(i);
//  828 		GetAdcValue(ADC_Channel_11);	// 
//  829 		Data = AdctoVolt33V(ADC_DATA[11]);
//  830 		SerPtr->printf(STARMSG);
//  831 		SerPtr->printf("DET11[%d]  : %d.%03d[V]\n",i ,Data/1000, Data%1000);
//  832 
//  833 #if 1
//  834 		Data = AdctoVolt33V(ADC_DATA[ADC_Channel_15]);
//  835 		tmpx = ReadEnvTempTable(ADC_Channel_15);
//  836 		SerPtr->printf(STARMSG);
//  837 		SerPtr->printf("TEMP: %d.%03d[V], %d.%d['C]\n", Data/1000, Data%1000, tmpx/10, abs(Data%10));
//  838 #endif
//  839 #endif
//  840 		SerPtr->printf(STARMSG);
        ADR.N    R0,??AdInputStatus_0  ;; 0x2A, 0x20, 0x00, 0x00
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  841 	    
//  842 		OSTimeDly(10L);
        MOVS     R0,#+10
        BL       OSTimeDly
//  843 	}
//  844 	PrintStar();
        BL       PrintStar
//  845 	SerPtr->printf("\n\n");
        ADR.N    R0,??AdInputStatus_0+0x4  ;; 0x0A, 0x0A, 0x00, 0x00
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+16]
        POP      {R2,R4-R11,LR}
        BX       R1
        DATA
??AdInputStatus_0:
        DC8      0x2A, 0x20, 0x00, 0x00
        DC8      0x0A, 0x0A, 0x00, 0x00
        DC32     `?<Constant "10: iAdcIndex[%d]:[%d...">`
        DC32     ADC_DATA1
        DC32     ADC_AVR
//  846 }
//  847 
//  848 
//  849 #if 0
//  850 ******************************************************************************* 
//  851 * DET11[0]  : 1.124[V]                                                          
//  852 * DET11[1]  : 0.855[V][17]                                                          
//  853 * DET11[2]  : 2.656[V][23]                                                          
//  854 * DET11[3]  : 0.000[V][29]                                                          
//  855 * ******************************************************************************
//  856 
//  857 #endif

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  858 void CurrentInputStatus(INT8U vcheck)
//  859 {
CurrentInputStatus:
        PUSH     {R4-R10,LR}
        MOVS     R8,R0
//  860 	INT8U tcnt = 0;
//  861 	INT8U tval = FALSE;
//  862     tcnt = tcnt;
//  863 
//  864 	if(!vcheck)PrintStar();
        BNE.N    ??CurrentInputStatus_0
        BL       PrintStar
//  865 	{
//  866 		tval += DigitalInputDiplay(tcnt++, PLL_Alarm_Common1, STARMSG, NULL, vcheck);
??CurrentInputStatus_0:
        ADR.N    R5,??CurrentInputStatus_1  ;; 0x2A, 0x20, 0x00, 0x00
        PUSH     {R8,LR}
        MOVS     R3,#+0
        MOV      R2,R5
        LDR.N    R0,??CurrentInputStatus_1+0xC  ;; 0x40010808
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x1000
        LSRS     R1,R0,#+12
        MOVS     R0,#+0
        BL       DigitalInputDiplay
        ADD      SP,SP,#+8
        UXTB     R6,R0
//  867 		tval += DigitalInputDiplay(tcnt++, PLL_Alarm_Common, PHAMSG, NULL, vcheck);
        ADR.W    R9,??CurrentInputStatus_1+0x4  ;; 0x2C, 0x20, 0x00, 0x00
        LDR.N    R4,??CurrentInputStatus_1+0x10  ;; 0x40010c08
        PUSH     {R8,LR}
        MOVS     R3,#+0
        MOV      R2,R9
        LDR      R0,[R4, #+0]
        AND      R0,R0,#0x1000
        LSRS     R1,R0,#+12
        MOVS     R0,#+1
        BL       DigitalInputDiplay
        ADD      SP,SP,#+8
        ADDS     R0,R0,R6
        UXTB     R10,R0
//  868 		tval += DigitalInputDiplay(tcnt++, PLL_Alarm_LTE1, PHAMSG, ENTMSG, vcheck);
        ADR.N    R6,??CurrentInputStatus_1+0x8  ;; "\n"
        LDR.N    R7,??CurrentInputStatus_1+0x14  ;; 0x40011008
        PUSH     {R8,LR}
        MOV      R3,R6
        MOV      R2,R9
        LDR      R0,[R7, #+0]
        AND      R0,R0,#0x100
        LSRS     R1,R0,#+8
        MOVS     R0,#+2
        BL       DigitalInputDiplay
        ADD      SP,SP,#+8
        ADD      R0,R0,R10
        UXTB     R10,R0
//  869 
//  870 		tval += DigitalInputDiplay(tcnt++, PLL_Alarm_LTE_A1, STARMSG, NULL, vcheck);
        PUSH     {R8,LR}
        MOVS     R3,#+0
        MOV      R2,R5
        LDR      R0,[R7, #+0]
        AND      R0,R0,#0x80
        LSRS     R1,R0,#+7
        MOVS     R0,#+3
        BL       DigitalInputDiplay
        ADD      SP,SP,#+8
        ADD      R0,R0,R10
        UXTB     R5,R0
//  871 		tval += DigitalInputDiplay(tcnt++, AC_Alarm, PHAMSG, NULL, vcheck);
        PUSH     {R8,LR}
        MOVS     R3,#+0
        MOV      R2,R9
        LDR      R0,[R4, #+0]
        AND      R0,R0,#0x4000
        LSRS     R1,R0,#+14
        MOVS     R0,#+4
        BL       DigitalInputDiplay
        ADD      SP,SP,#+8
        ADDS     R0,R0,R5
        UXTB     R4,R0
//  872 		tval += DigitalInputDiplay(tcnt++, RRTYPE, PHAMSG, ENTMSG, vcheck);
        PUSH     {R8,LR}
        MOV      R3,R6
        MOV      R2,R9
        LDR      R0,[R7, #+0]
        AND      R0,R0,#0x40
        LSRS     R1,R0,#+6
        MOVS     R0,#+5
        BL       DigitalInputDiplay
        ADD      SP,SP,#+8
        ADDS     R0,R0,R4
        UXTB     R0,R0
//  873 	}
//  874 
//  875 	if(!vcheck)PrintStar();
        CMP      R8,#+0
        BNE.N    ??CurrentInputStatus_2
        POP      {R4-R10,LR}
        B.N      PrintStar
//  876 	if(vcheck)
//  877 	{
//  878 		if(tval) SerPtr->printf("\n");
??CurrentInputStatus_2:
        CMP      R0,#+0
        BEQ.N    ??CurrentInputStatus_3
        MOV      R0,R6
        LDR.N    R1,??DataTable21  ;; SerPtr
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  879 	}
//  880 }
??CurrentInputStatus_3:
        POP      {R4-R10,PC}      ;; return
        DATA
??CurrentInputStatus_1:
        DC8      0x2A, 0x20, 0x00, 0x00
        DC8      0x2C, 0x20, 0x00, 0x00
        DC8      "\n",+0,+0
        DC32     0x40010808
        DC32     0x40010c08
        DC32     0x40011008

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable21:
        DC32     SerPtr
//  881 

        SECTION `.bss`:DATA:NOROOT(2)
//  882 INT32U vstrval = 0;
vstrval:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
//  883 INT8S vstr[64];
vstr:
        DS8 64
//  884 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  885 void HwTestOutFunc(INT32U *nFlag)
//  886 {
HwTestOutFunc:
        PUSH     {R0,R4-R11,LR}
        SUB      SP,SP,#+8
//  887 	INT32U MaxValue = 0xFFFF;
//  888 	INT8U Data = *nFlag;
//  889 
//  890     MaxValue = MaxValue;
        MOVW     R0,#+65535
        STR      R0,[SP, #+4]
//  891     Data = Data;
        LDR      R0,[SP, #+8]
        LDRB     R0,[R0, #+0]
        STR      R0,[SP, #+0]
//  892 
//  893 ///////////////////////////////////////////////////////////
//  894 //	Dig_Reset	
//  895 	_Normal_LED_2G		= 0;
        LDR.N    R4,??HwTestOutFunc_1  ;; 0x4001140c
        LDR      R0,[R4, #+0]
        BIC      R0,R0,#0x10
        STR      R0,[R4, #+0]
//  896 	_Alarm_LED_2G		= 0;
        LDR      R0,[R4, #+0]
        BIC      R0,R0,#0x8
        STR      R0,[R4, #+0]
//  897 	_Normal_LED_3G		= 0;
        MVN      R0,#+16384
        LDR.W    R11,??HwTestOutFunc_1+0x4  ;; 0x4001080c
        LDR      R1,[R11, #+0]
        ANDS     R1,R0,R1
        STR      R1,[R11, #+0]
//  898 	_Alarm_LED_3G		= 0;
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x80
        STR      R1,[R4, #+0]
//  899 	_Normal_LED_LTE 	= 0;
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x40
        STR      R1,[R4, #+0]
//  900 	_Alarm_LED_LTE		= 0;
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x20
        STR      R1,[R4, #+0]
//  901 	_Normal_LED_LTE_A	= 0;
        LDR.W    R10,??HwTestOutFunc_1+0x8  ;; 0x4001100c
        LDR      R1,[R10, #+0]
        ANDS     R0,R0,R1
        STR      R0,[R10, #+0]
//  902 	_Alarm_LED_LTE_A	= 0;
        MVN      R0,#+8192
        LDR      R1,[R11, #+0]
        ANDS     R1,R0,R1
        STR      R1,[R11, #+0]
//  903 	_Normal_LED_LTE1	= 0;
        LDR.N    R5,??HwTestOutFunc_1+0xC  ;; 0x40010c0c
        LDR      R1,[R5, #+0]
        BIC      R1,R1,#0x200
        STR      R1,[R5, #+0]
//  904 	_Alarm_LED_LTE1 	= 0;
        MVN      R1,#+32768
        LDR      R2,[R10, #+0]
        ANDS     R2,R1,R2
        STR      R2,[R10, #+0]
//  905 	_Normal_LED_LTE_A1	= 0;
        LDR.N    R6,??HwTestOutFunc_1+0x10  ;; 0x4001180c
        LDR      R2,[R6, #+0]
        BIC      R2,R2,#0x2
        STR      R2,[R6, #+0]
//  906 	_Alarm_LED_LTE_A1	= 0;
        LDR      R2,[R6, #+0]
        MOVS     R3,#+1
        BICS     R2,R2,R3
        STR      R2,[R6, #+0]
//  907 	FwdAmpOnOff_2G		= 0;
        MVN      R2,#+4096
        LDR      R3,[R6, #+0]
        ANDS     R3,R2,R3
        STR      R3,[R6, #+0]
//  908 	Fwd0AmpOnOff_LTE	= 0;
        LDR      R3,[R6, #+0]
        ANDS     R3,R0,R3
        STR      R3,[R6, #+0]
//  909 	Fwd0Amp1OnOff_LTE_A	= 0;
        LDR      R3,[R5, #+0]
        ANDS     R1,R1,R3
        STR      R1,[R5, #+0]
//  910 	Fwd0Amp2OnOff_LTE_A	= 0;
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x100
        STR      R1,[R4, #+0]
//  911 	FwdAmp1OnOff_3G		= 0;
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x200
        STR      R1,[R4, #+0]
//  912 	FwdAmp2OnOff_3G		= 0;
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x400
        STR      R1,[R4, #+0]
//  913 	Fwd1Amp1OnOff_LTE	= 0;
        LDR      R1,[R4, #+0]
        BIC      R1,R1,#0x800
        STR      R1,[R4, #+0]
//  914 	Fwd1Amp2OnOff_LTE	= 0;
        LDR      R1,[R4, #+0]
        ANDS     R1,R2,R1
        STR      R1,[R4, #+0]
//  915 	Fwd1AmpOnOff_LTE_A	= 0;
        LDR      R1,[R4, #+0]
        ANDS     R0,R0,R1
        STR      R0,[R4, #+0]
//  916 	SMS_PWR = 0;
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x800
        STR      R0,[R6, #+0]
        LDR.N    R7,??HwTestOutFunc_1+0x14  ;; pPCA9555Str
        LDR      R2,[R7, #+0]
        LDR.N    R1,??HwTestOutFunc_1+0x18  ;; AttnCS0Val
        MOVS     R0,#+40
//  917 
//  918 	PCA9555BitRst(_15M_Switch_LTE,	&AttnCS0Val); 
        BL       pPCA9555BitRst
//  919 	PCA9555BitRst(PLL_ENABLE,		&AttnCS1Val); 
        LDR.W    R8,??HwTestOutFunc_1+0x1C  ;; AttnCS1Val
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+25
        BL       pPCA9555BitRst
//  920 	PCA9555BitRst(Sp_En0,		&AttnCS1Val); 
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+57
        BL       pPCA9555BitRst
//  921 	PCA9555BitRst(Sp_En1,		&AttnCS1Val); 
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+49
        BL       pPCA9555BitRst
//  922 	PCA9555BitRst(Sp_En2,		&AttnCS1Val); 
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+41
        BL       pPCA9555BitRst
//  923 	PCA9555BitRst(Sp_En3,		&AttnCS1Val); 
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+33
        BL       pPCA9555BitRst
//  924 	PCA9555BitRst(Sp_En4,		&AttnCS0Val); 
        LDR      R2,[R7, #+0]
        LDR.N    R1,??HwTestOutFunc_1+0x18  ;; AttnCS0Val
        MOVS     R0,#+56
        BL       pPCA9555BitRst
//  925 	PCA9555BitRst(Sp_En5,		&AttnCS0Val); 
        LDR      R2,[R7, #+0]
        LDR.N    R1,??HwTestOutFunc_1+0x18  ;; AttnCS0Val
        MOVS     R0,#+48
        BL       pPCA9555BitRst
//  926 	PCA9555BitRst(Sp_En6,		&AttnCS2Val); 
        LDR.W    R9,??HwTestOutFunc_1+0x20  ;; AttnCS2Val
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+58
        BL       pPCA9555BitRst
//  927 	PCA9555BitRst(Sp_En7,		&AttnCS2Val); 
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+50
        BL       pPCA9555BitRst
//  928 	PCA9555BitRst(Sp_En8,		&AttnCS2Val); 
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+42
        BL       pPCA9555BitRst
//  929 	PCA9555BitRst(Sp_En9,		&AttnCS2Val); 
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+34
        BL       pPCA9555BitRst
//  930 
//  931 	switch(Data)
        ADD      R0,SP,#+0
        LDRB     R0,[R0, #+0]
        CMP      R0,#+33
        BHI.W    ??HwTestOutFunc_2
        TBB      [PC, R0]
        DATA
??HwTestOutFunc_0:
        DC8      +17,+22,+26,+33
        DC8      +37,+41,+45,+52
        DC8      +57,+62,+67,+72
        DC8      +76,+80,+84,+88
        DC8      +92,+96,+100,+104
        DC8      +108,+112,+118,+122
        DC8      +126,+130,+134,+138
        DC8      +144,+148,+152,+156
        DC8      +160,+164
        THUMB
//  932 	{
//  933 		case 0:
//  934 			_Normal_LED_2G		= 1;
??HwTestOutFunc_3:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x10
??HwTestOutFunc_4:
        STR      R0,[R4, #+0]
        B.N      ??HwTestOutFunc_2
//  935 		break;
//  936 		
//  937 		case 1:
//  938 			_Alarm_LED_2G		= 1;
??HwTestOutFunc_5:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x8
        B.N      ??HwTestOutFunc_4
//  939 		break;
//  940 		
//  941 		case 2:
//  942 			_Normal_LED_3G		= 1;
??HwTestOutFunc_6:
        LDR      R0,[R11, #+0]
        ORR      R0,R0,#0x4000
??HwTestOutFunc_7:
        STR      R0,[R11, #+0]
        B.N      ??HwTestOutFunc_2
//  943 		break;
//  944 		
//  945 		case 3:
//  946 			_Alarm_LED_3G		= 1;
??HwTestOutFunc_8:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x80
        B.N      ??HwTestOutFunc_4
//  947 		break;			
//  948 		
//  949 		case 4:
//  950 			_Normal_LED_LTE 	= 1;
??HwTestOutFunc_9:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x40
??HwTestOutFunc_10:
        B.N      ??HwTestOutFunc_4
//  951 		break;
//  952 		
//  953 		case 5:
//  954 			_Alarm_LED_LTE		= 1;
??HwTestOutFunc_11:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x20
        B.N      ??HwTestOutFunc_4
//  955 		break;			
//  956 		
//  957 		case 6:
//  958 			_Normal_LED_LTE_A	= 1;
??HwTestOutFunc_12:
        LDR      R0,[R10, #+0]
        ORR      R0,R0,#0x4000
??HwTestOutFunc_13:
        STR      R0,[R10, #+0]
        B.N      ??HwTestOutFunc_2
//  959 		break;
//  960 		
//  961 		case 7:
//  962 			_Alarm_LED_LTE_A	= 1;
??HwTestOutFunc_14:
        LDR      R0,[R11, #+0]
        ORR      R0,R0,#0x2000
        B.N      ??HwTestOutFunc_7
//  963 		break;	
//  964 		
//  965 		case 8:
//  966 			_Normal_LED_LTE1	= 1;
??HwTestOutFunc_15:
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x200
??HwTestOutFunc_16:
        STR      R0,[R5, #+0]
        B.N      ??HwTestOutFunc_2
//  967 		break;
//  968 		
//  969 		case 9:
//  970 			_Alarm_LED_LTE1 	= 1;
??HwTestOutFunc_17:
        LDR      R0,[R10, #+0]
        ORR      R0,R0,#0x8000
        B.N      ??HwTestOutFunc_13
//  971 		break;			
//  972 		
//  973 		case 10:
//  974 			_Normal_LED_LTE_A1	= 1;
??HwTestOutFunc_18:
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x2
??HwTestOutFunc_19:
        STR      R0,[R6, #+0]
        B.N      ??HwTestOutFunc_2
//  975 		break;
//  976 		
//  977 		case 11:
//  978 			_Alarm_LED_LTE_A1	= 1;
??HwTestOutFunc_20:
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x1
        B.N      ??HwTestOutFunc_19
//  979 		break;	
//  980 		
//  981 		case 12:
//  982 			FwdAmpOnOff_2G		= 1;
??HwTestOutFunc_21:
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x1000
        B.N      ??HwTestOutFunc_19
//  983 		break;
//  984 		
//  985 		case 13:
//  986 			Fwd0AmpOnOff_LTE	= 1;
??HwTestOutFunc_22:
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x2000
        B.N      ??HwTestOutFunc_19
//  987 		
//  988 		break;
//  989 		
//  990 		case 14:
//  991 			Fwd0Amp1OnOff_LTE_A = 1;
??HwTestOutFunc_23:
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x8000
        B.N      ??HwTestOutFunc_16
//  992 		break;
//  993 		
//  994 		case 15:
//  995 			Fwd0Amp2OnOff_LTE_A = 1;
??HwTestOutFunc_24:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x100
        B.N      ??HwTestOutFunc_4
//  996 		break;
//  997 		
//  998 		case 16:
//  999 			FwdAmp1OnOff_3G 	= 1;
??HwTestOutFunc_25:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x200
        B.N      ??HwTestOutFunc_4
// 1000 		break;
// 1001 		
// 1002 		case 17:
// 1003 			FwdAmp2OnOff_3G 	= 1;
??HwTestOutFunc_26:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x400
        B.N      ??HwTestOutFunc_4
// 1004 		break;
// 1005 		
// 1006 		case 18:
// 1007 			Fwd1Amp1OnOff_LTE	= 1;
??HwTestOutFunc_27:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x800
        B.N      ??HwTestOutFunc_4
// 1008 		break;
// 1009 		
// 1010 		case 19:
// 1011 			Fwd1Amp2OnOff_LTE	= 1;
??HwTestOutFunc_28:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1000
        B.N      ??HwTestOutFunc_4
// 1012 		break;
// 1013 		
// 1014 		case 20:
// 1015 			Fwd1AmpOnOff_LTE_A	= 1;
??HwTestOutFunc_29:
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x2000
        B.N      ??HwTestOutFunc_4
// 1016 		break;
// 1017 
// 1018 		case 21:
// 1019 			PCA9555BitSet(_15M_Switch_LTE,&AttnCS0Val); 
??HwTestOutFunc_30:
        LDR      R2,[R7, #+0]
        LDR.N    R1,??HwTestOutFunc_1+0x18  ;; AttnCS0Val
        MOVS     R0,#+40
??HwTestOutFunc_31:
        BL       pPCA9555BitSet
        B.N      ??HwTestOutFunc_2
// 1020 		break;
// 1021 		
// 1022 		case 22:
// 1023 			PCA9555BitSet(PLL_ENABLE,&AttnCS1Val); 
??HwTestOutFunc_32:
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+25
        B.N      ??HwTestOutFunc_31
// 1024 		break;
// 1025 
// 1026 		case 23:
// 1027 			PCA9555BitSet(Sp_En0,		&AttnCS1Val); 
??HwTestOutFunc_33:
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+57
??HwTestOutFunc_34:
        B.N      ??HwTestOutFunc_31
// 1028 		break;
// 1029 
// 1030 		case 24:
// 1031 			PCA9555BitSet(Sp_En1,		&AttnCS1Val); 
??HwTestOutFunc_35:
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+49
        B.N      ??HwTestOutFunc_31
// 1032 		break;
// 1033 
// 1034 		case 25:
// 1035 			PCA9555BitSet(Sp_En2,		&AttnCS1Val); 
??HwTestOutFunc_36:
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+41
        B.N      ??HwTestOutFunc_31
// 1036 		break;
// 1037 
// 1038 		case 26:
// 1039 			PCA9555BitSet(Sp_En3,		&AttnCS1Val); 
??HwTestOutFunc_37:
        LDR      R2,[R7, #+0]
        MOV      R1,R8
        MOVS     R0,#+33
        B.N      ??HwTestOutFunc_31
// 1040 		break;
// 1041 
// 1042 		case 27:
// 1043 			PCA9555BitSet(Sp_En4,		&AttnCS0Val); 
??HwTestOutFunc_38:
        LDR      R2,[R7, #+0]
        LDR.N    R1,??HwTestOutFunc_1+0x18  ;; AttnCS0Val
        MOVS     R0,#+56
??HwTestOutFunc_39:
        BL       pPCA9555BitSet
        B.N      ??HwTestOutFunc_2
// 1044 		break;
// 1045 
// 1046 		case 28:
// 1047 			PCA9555BitSet(Sp_En5,		&AttnCS0Val); 
??HwTestOutFunc_40:
        LDR      R2,[R7, #+0]
        LDR.N    R1,??HwTestOutFunc_1+0x18  ;; AttnCS0Val
        MOVS     R0,#+48
        B.N      ??HwTestOutFunc_31
// 1048 		break;
// 1049 
// 1050 		case 29:
// 1051 			PCA9555BitSet(Sp_En6,		&AttnCS2Val); 
??HwTestOutFunc_41:
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+58
        B.N      ??HwTestOutFunc_31
// 1052 		break;
// 1053 
// 1054 		case 30:
// 1055 			PCA9555BitSet(Sp_En7,		&AttnCS2Val); 
??HwTestOutFunc_42:
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+50
        B.N      ??HwTestOutFunc_31
// 1056 		break;
// 1057 
// 1058 		case 31:
// 1059 			PCA9555BitSet(Sp_En8,		&AttnCS2Val); 
??HwTestOutFunc_43:
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+42
        B.N      ??HwTestOutFunc_39
// 1060 		break;
// 1061 
// 1062 		case 32:
// 1063 			PCA9555BitSet(Sp_En9,		&AttnCS2Val); 
??HwTestOutFunc_44:
        LDR      R2,[R7, #+0]
        MOV      R1,R9
        MOVS     R0,#+34
        B.N      ??HwTestOutFunc_31
// 1064 		break;
// 1065 
// 1066  		case 33:
// 1067 			MaxValue = Data;
??HwTestOutFunc_45:
        LDR      R0,[SP, #+0]
        STR      R0,[SP, #+4]
// 1068 			//BuzzShort();
// 1069 		break;
// 1070 	}
// 1071 	*nFlag = *nFlag + 1;
??HwTestOutFunc_2:
        LDR      R0,[SP, #+8]
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR      R1,[SP, #+8]
        STR      R0,[R1, #+0]
// 1072 
// 1073 	if(*nFlag >= MaxValue) *nFlag = 0;
        LDR      R1,[SP, #+4]
        CMP      R0,R1
        BCC.N    ??HwTestOutFunc_46
        LDR      R0,[SP, #+8]
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
// 1074 
// 1075 }
??HwTestOutFunc_46:
        ADD      SP,SP,#+12
        POP      {R4-R11,PC}      ;; return
        Nop      
        DATA
??HwTestOutFunc_1:
        DC32     0x4001140c
        DC32     0x4001080c
        DC32     0x4001100c
        DC32     0x40010c0c
        DC32     0x4001180c
        DC32     pPCA9555Str
        DC32     AttnCS0Val
        DC32     AttnCS1Val
        DC32     AttnCS2Val
// 1076 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1077 INT32U DigitalInputDiplay(INT8U num, INT8U ival,
// 1078 							INT8U *fmsg, INT8U *emsg,
// 1079 							INT8U vcheck)
// 1080 {
DigitalInputDiplay:
        PUSH     {R3-R8,R10,LR}
        MOV      R6,R0
        MOV      R5,R1
        MOV      R1,R2
        MOV      R8,R3
        LDR      R4,[SP, #+32]
// 1081 	INT32U temp = FALSE;
        MOV      R10,#+0
// 1082 	INT8U *currentptr = (INT8U *)&tinputSts;
// 1083 	INT8U *beforeptr = (INT8U *)&tinputStsOld;
// 1084 
// 1085 	// first
// 1086 	if(!vcheck)
        CBNZ     R4,??DigitalInputDiplay_0
// 1087 	{
// 1088 		if(fmsg != NULL) SerPtr->printf("%s", fmsg);	// start // phase mssage
        CBZ      R1,??DigitalInputDiplay_0
        ADR.N    R0,??DigitalInputDiplay_1  ;; 0x25, 0x73, 0x00, 0x00
        LDR.N    R2,??DigitalInputDiplay_1+0x8  ;; SerPtr
        LDR      R2,[R2, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
// 1089 	}
// 1090 
// 1091 	currentptr[num] = ival;
??DigitalInputDiplay_0:
        LDR.N    R7,??DigitalInputDiplay_1+0xC  ;; tinputSts
        STRB     R5,[R6, R7]
// 1092 
// 1093 	{
// 1094 		if( (vcheck && (beforeptr[num] != currentptr[num]) ) )
        CBZ      R4,??DigitalInputDiplay_2
        LDR.N    R0,??DigitalInputDiplay_1+0x10  ;; tinputStsOld
        LDRB     R0,[R6, R0]
        CMP      R0,R5
        BEQ.N    ??DigitalInputDiplay_3
// 1095 		{
// 1096 			SerPtr->printf("%02d. ", num);
        LDR.W    R8,??DigitalInputDiplay_1+0x14  ;; `?<Constant "%02d. ">`
        LDR.N    R4,??DigitalInputDiplay_1+0x8  ;; SerPtr
        MOV      R1,R6
        MOV      R0,R8
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
// 1097 			SerPtr->printf("%s", tDisplay[num]);
        ADD      R0,R7,R6, LSL #+2
        LDR      R1,[R0, #+52]
        ADR.N    R0,??DigitalInputDiplay_1  ;; 0x25, 0x73, 0x00, 0x00
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        LDR      R0,[R4, #+0]
        LDR      R1,[R0, #+16]
        CMP      R5,#+0
        ITE      NE 
        ADDNE    R0,R8,#+8
        ADDEQ    R0,R8,#+16
// 1098 			{
// 1099 				if(ival) SerPtr->printf(OFFMSG);
// 1100 				else	 SerPtr->printf(ONMSG);
        BLX      R1
// 1101 			}
// 1102 			temp = TRUE;
        MOV      R10,#+1
// 1103 		}
// 1104 		else if(!vcheck)
// 1105 		{
// 1106 			SerPtr->printf("%s", tDisplay[num]);
// 1107 			{
// 1108 				if(ival) SerPtr->printf(OFFMSG);
// 1109 				else	 SerPtr->printf(ONMSG);
// 1110 			}
// 1111 		}
// 1112 	}
// 1113 
// 1114 ////////////////////////////////////////////////////////////////////////////////
// 1115 	if(vcheck)
// 1116 	{
// 1117 		if(temp)
// 1118 		{
// 1119 			OSTimeDly(1L);
??DigitalInputDiplay_4:
        MOVS     R0,#+1
        BL       OSTimeDly
// 1120 			SerPtr->printf(ENTMSG);
        ADR.N    R0,??DigitalInputDiplay_1+0x4  ;; "\n"
        LDR.N    R1,??DigitalInputDiplay_1+0x8  ;; SerPtr
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
        B.N      ??DigitalInputDiplay_3
// 1121 		}
// 1122 	}
??DigitalInputDiplay_2:
        LDR.N    R4,??DigitalInputDiplay_1+0x8  ;; SerPtr
        ADD      R0,R7,R6, LSL #+2
        LDR      R1,[R0, #+52]
        ADR.N    R0,??DigitalInputDiplay_1  ;; 0x25, 0x73, 0x00, 0x00
        LDR      R2,[R4, #+0]
        LDR      R2,[R2, #+16]
        BLX      R2
        LDR      R0,[R4, #+0]
        LDR      R1,[R0, #+16]
        LDR.N    R2,??DigitalInputDiplay_1+0x14  ;; `?<Constant "%02d. ">`
        CMP      R5,#+0
        ITE      NE 
        ADDNE    R0,R2,#+8
        ADDEQ    R0,R2,#+16
        BLX      R1
// 1123 	else
// 1124 	{
// 1125 		if(emsg)
        CMP      R8,#+0
        BNE.N    ??DigitalInputDiplay_4
// 1126 		{
// 1127 			OSTimeDly(1L);
// 1128 			SerPtr->printf(ENTMSG);
// 1129 		}
// 1130 	}
// 1131 
// 1132 	beforeptr[num] = currentptr[num];
??DigitalInputDiplay_3:
        LDRB     R0,[R6, R7]
        LDR.N    R1,??DigitalInputDiplay_1+0x10  ;; tinputStsOld
        STRB     R0,[R6, R1]
// 1133 	return (INT32U)temp;
        MOV      R0,R10
        POP      {R1,R4-R8,R10,PC}  ;; return
        Nop      
        DATA
??DigitalInputDiplay_1:
        DC8      0x25, 0x73, 0x00, 0x00
        DC8      "\n",+0,+0
        DC32     SerPtr
        DC32     tinputSts
        DC32     tinputStsOld
        DC32     `?<Constant "%02d. ">`
// 1134 }

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "NON TESTED">`:
        DATA
        DC8 "NON TESTED"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "    TESTED">`:
        DATA
        DC8 "    TESTED"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "PLL_Alarm_Common1 :">`:
        DATA
        DC8 "PLL_Alarm_Common1 :"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "PLL_Alarm_Common  :">`:
        DATA
        DC8 "PLL_Alarm_Common  :"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "PLL_Alarm_LTE1    :">`:
        DATA
        DC8 "PLL_Alarm_LTE1    :"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "PLL_Alarm_LTE_A1  :">`:
        DATA
        DC8 "PLL_Alarm_LTE_A1  :"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AC_Alarm          :">`:
        DATA
        DC8 "AC_Alarm          :"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "Insert            :">`:
        DATA
        DC8 "Insert            :"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "AT24C64 Error Write F...">`:
        DATA
        DC8 "AT24C64 Error Write Function ADDR[%d] \012"
        DC8 "AT24C64 Error Read Function ADDR[%d] = %d \012"
        DC8 "AT24C64 Read Data[%d] = %d \012"
        DC8 0, 0, 0
        DC8 "\012\012SUCCESS EEPROM TEST\012"
        DC8 0
        DC8 "Dig Output"
        DC8 0
        DC8 "\012* [%s TEST START TimeOut 5Min]\012"
        DC8 0, 0, 0
        DC8 "%s test TimeOut\012"
        DC8 0, 0, 0
        DC8 "%s test Canceled\012"
        DC8 0, 0
        DC8 "%s test Finished\012"
        DC8 0, 0
        DC8 "ADC/RAM"
        DC8 "\012* [%s] TEST START TimeOut 5 Min]\012"
        DC8 0
        DC8 "%s Test TimeOut\012"
        DC8 0, 0, 0
        DC8 "%s Test Canceled\012"
        DC8 0, 0
        DC8 "%s Test Finished\012"
        DC8 0, 0
        DC8 "Dig Input"
        DC8 0, 0
        DC8 "\012* [%s TEST START TimeOut 5 Min]\012"
        DC8 0, 0
        DC8 "%s test Test TimeOut\012"
        DC8 0, 0
        DC8 "%s test Test Canceled\012"
        DC8 0
        DC8 "%s Test Test Finished\012"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "COM"

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "* "
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "%s: %d.%d[V], [raw:%04d]">`:
        DATA
        DC8 "%s: %d.%d[V], [raw:%04d]"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(1)
        DATA
        DC8 "\012"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "%s\\300\\314 \\274\\366\\307\\340\\265\\30`:
        DATA
        DC8 25H, 73H, 0C0H, 0CCH, 20H, 0BCH, 0F6H, 0C7H
        DC8 0E0H, 0B5H, 0C7H, 0BEH, 0EEH, 20H, 0C0H, 0D6H
        DC8 0BDH, 0C0H, 0B4H, 0CFH, 0B4H, 0D9H, 2EH, 20H
        DC8 0B0H, 0E8H, 0BCH, 0D3H, 20H, 0C1H, 0F8H, 0C7H
        DC8 0E0H, 0C7H, 0CFH, 0BDH, 0C3H, 0B0H, 0DAH, 0BDH
        DC8 0C0H, 0B4H, 0CFH, 0B1H, 0EEH, 3FH, 5BH, 59H
        DC8 5DH, 65H, 73H, 2CH, 20H, 5BH, 43H, 5DH
        DC8 61H, 6EH, 63H, 65H, 6CH, 0AH, 0
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "CANCEL TEST \\n">`:
        DATA
        DC8 "CANCEL TEST \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "\012\012"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "* %s VER:%d.%d\\n">`:
        DATA
        DC8 "* %s VER:%d.%d\012"
        DC8 "TRIO-M MCU CTRL TEST PROGRAM"
        DC8 0, 0, 0
        DC8 "    -COMMAND 1st-\012"
        DC8 0
        DC8 "*  ?        : help(this message)\012"
        DC8 0, 0
        DC8 "*  C        : com test              [%s]\012"
        DC8 0, 0
        DC8 "*  O        : output test           [%s]\012"
        DC8 0, 0
        DC8 "*  I        : input test            [%s]\012"
        DC8 0, 0
        DC8 "*  A        : ADC/RAM               [%s]\012"
        DC8 0, 0
        DC8 "*  F        : EERROM                [%s]\012"
        DC8 0, 0
        DC8 "*  G        : compulsory boot(eeprom)\012"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "*********************...">`:
        DATA
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

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "TRIO >>">`:
        DATA
        DC8 "TRIO >>"

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "\\305\\353\\275\\305\\275\\303\\307\\350 S`:
        DATA
        DC8 "\305\353\275\305\275\303\307\350 Ser4[MODEM] \275\303\307\350\300\273 \303\274\305\251\307\317\277\251 \301\326\274\274\277\344     "
        DC8 0, 0, 0
        DC8 "[OK]"
        DC8 0, 0, 0
        DC8 "[FAIL 1]"
        DC8 0, 0, 0
        DC8 "[FAIL 2]: %d"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "10: iAdcIndex[%d]:[%d...">`:
        DATA
        DC8 "10: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "16: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "22: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "28: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "11: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "17: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "23: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "29: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "12: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "18: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "24: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "30: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "13: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "19: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "25: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "31: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "14: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "20: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "26: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "32: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "15: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "21: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "27: iAdcIndex[%d]:[%d][%d]\012"
        DC8 "33: iAdcIndex[%d]:[%d][%d]\012"

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 ", "
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
        DC8 "%s"
        DC8 0

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "%02d. ">`:
        DATA
        DC8 "%02d. "
        DC8 0
        DC8 "[OFF]"
        DC8 0, 0
        DC8 "[ON ]"
        DC8 0, 0

        END
// 1135 
// 1136 ///////////////////////////////////////////////////////////////////////////////
// 1137 // End of Source File
// 1138 ////////////////////////
// 1139 
// 
// 1 149 bytes in section .bss
//   148 bytes in section .data
// 1 986 bytes in section .rodata
// 3 860 bytes in section .text
// 
// 3 860 bytes of CODE  memory
// 1 986 bytes of CONST memory
// 1 297 bytes of DATA  memory
//
//Errors: none
//Warnings: none
