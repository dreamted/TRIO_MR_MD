///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:44 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\expio /
//                    .c                                                      /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\expio /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\expio /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME expio

        EXTERN AlarmCheck_TRIO
        EXTERN AttnOutBufferInit
        EXTERN ChkAlarm
        EXTERN DownLoadBootingJump
        EXTERN DownLoadGiveupTimerSet
        EXTERN ForDelay
        EXTERN FwdAGCCheckFunction
        EXTERN OSSemCreate
        EXTERN OSTaskCreate
        EXTERN OSTimeDly
        EXTERN ResetCaseBackup
        EXTERN RvsALCCheckFunction
        EXTERN ShutDownCheck
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN iDebugCnt
        EXTERN iRepeaterType
        EXTERN pPCA9555BitRst
        EXTERN pPCA9555BitSet
        EXTERN pPCA9555Str
        EXTERN pPCASetConfiguration
        EXTERN pPCASetPortData
        EXTERN tAttAccu
        EXTERN tDnrSts
        EXTERN tTestFlag

        PUBLIC ADC_Select
        PUBLIC AttChange
        PUBLIC AttnCS0Val
        PUBLIC AttnCS1Val
        PUBLIC AttnCS2Val
        PUBLIC AttnDataOutput
        PUBLIC BlinkFlag
        PUBLIC ChangeLvltoValue
        PUBLIC ChkAttChange
        PUBLIC Chk_Factory_default
        PUBLIC Chk_Reset
        PUBLIC CurrBandSelect_15M
        PUBLIC CurrExtRxAttn
        PUBLIC CurrExtTxAttn
        PUBLIC CurrFwd1Attn1_LTE
        PUBLIC CurrFwd1Attn1_LTE_A
        PUBLIC CurrFwd1Attn2_LTE
        PUBLIC CurrFwd1Attn2_LTE_A
        PUBLIC CurrFwdAttn1_2G
        PUBLIC CurrFwdAttn1_3G
        PUBLIC CurrFwdAttn1_Common
        PUBLIC CurrFwdAttn1_LTE
        PUBLIC CurrFwdAttn1_LTE_A
        PUBLIC CurrFwdAttn2_2G
        PUBLIC CurrFwdAttn2_3G
        PUBLIC CurrFwdAttn2_LTE
        PUBLIC CurrFwdAttn2_LTE_A
        PUBLIC CurrFwdGain_LTE
        PUBLIC CurrFwdInAttn_2G
        PUBLIC CurrFwdInAttn_LTE
        PUBLIC CurrFwdOutALCAAttn_LTE
        PUBLIC CurrModemRxAttn
        PUBLIC CurrRvs0Attn_LTE
        PUBLIC CurrRvs0InNFAttn_LTE
        PUBLIC CurrRvs0OutNFAttn_LTE
        PUBLIC CurrRvs1Attn1_LTE
        PUBLIC CurrRvs1Attn1_LTE_A
        PUBLIC CurrRvs1Attn2_LTE
        PUBLIC CurrRvs1Attn2_LTE_A
        PUBLIC CurrRvs1Attn3_LTE
        PUBLIC CurrRvs1Attn3_LTE_A
        PUBLIC CurrRvs1Attn4_LTE
        PUBLIC CurrRvs1Attn4_LTE_A
        PUBLIC CurrRvs1Attn_LTE
        PUBLIC CurrRvs1InNFAttn_LTE
        PUBLIC CurrRvs1OutNFAttn_LTE
        PUBLIC CurrRvsAttn1_2G
        PUBLIC CurrRvsAttn1_3G
        PUBLIC CurrRvsAttn1_Common
        PUBLIC CurrRvsAttn1_LTE
        PUBLIC CurrRvsAttn1_LTE_A
        PUBLIC CurrRvsAttn2_2G
        PUBLIC CurrRvsAttn2_3G
        PUBLIC CurrRvsAttn2_LTE
        PUBLIC CurrRvsAttn2_LTE_A
        PUBLIC CurrRvsAttn3_2G
        PUBLIC CurrRvsAttn3_3G
        PUBLIC CurrRvsAttn3_LTE
        PUBLIC CurrRvsAttn3_LTE_A
        PUBLIC CurrRvsAttn4_3G
        PUBLIC CurrRvsAttn4_LTE
        PUBLIC CurrRvsAttn4_LTE_A
        PUBLIC CurrRx0Attn0
        PUBLIC CurrRx0Attn1
        PUBLIC CurrRx1Attn0
        PUBLIC CurrRx1Attn1
        PUBLIC CurrTxAttn0
        PUBLIC CurrTxAttn1
        PUBLIC DnLEDFlag
        PUBLIC DnrCheckID
        PUBLIC ExpioInit
        PUBLIC ExpioPortInit
        PUBLIC ExpioSem
        PUBLIC ExpioTask
        PUBLIC F_RESET_IN_Read
        PUBLIC FrontLEDDisplay
        PUBLIC FrontLEDSet
        PUBLIC LEDStatus
        PUBLIC LED_Test
        PUBLIC LowPwrAlarm_2G
        PUBLIC LowPwrAlarm_3G
        PUBLIC LowPwrAlarm_LTE
        PUBLIC LowPwrAlarm_LTE1
        PUBLIC LowPwrAlarm_LTE_A
        PUBLIC LowPwrAlarm_LTE_A1
        PUBLIC MinMaxAttnCheck
        PUBLIC PeriodCnt
        PUBLIC Period_Check
        PUBLIC ResetCnt
        PUBLIC ResetStart
        PUBLIC RmtCheckID
        PUBLIC StatustoIO
        PUBLIC TimerRelatedOperation
        PUBLIC TotalAlarm_2G
        PUBLIC TotalAlarm_3G
        PUBLIC TotalAlarm_Common
        PUBLIC TotalAlarm_LTE
        PUBLIC TotalAlarm_LTE1
        PUBLIC TotalAlarm_LTE_A
        PUBLIC TotalAlarm_LTE_A1
        PUBLIC TypeCheck
        PUBLIC dptr
        PUBLIC iDebug_Mode
        PUBLIC iResetCnt
        PUBLIC pPCA9555Port_Init

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\expio.c
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
//   11 #define EXPIO_C
//   12 
//   13 #include "../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data LEDStatus[(enum <unnamed>)8U]
LEDStatus:
        DS8 8
// INT8U __data DnLEDFlag
DnLEDFlag:
        DS8 1
        DS8 3
// _PCA9555Reg __data AttnCS0Val
AttnCS0Val:
        DS8 4
// _PCA9555Reg __data AttnCS1Val
AttnCS1Val:
        DS8 4
// _PCA9555Reg __data AttnCS2Val
AttnCS2Val:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// static OS_STK __data ExpioTaskStk[256]
ExpioTaskStk:
        DS8 1024

        SECTION `.bss`:DATA:NOROOT(2)
// struct os_event *__data ExpioSem
ExpioSem:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data BlinkFlag
BlinkFlag:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data ResetCnt
ResetCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT8U __data Chk_Reset
Chk_Reset:
        DS8 1
// INT8U __data CurrFwdAttn1_2G
CurrFwdAttn1_2G:
        DS8 1
// INT8U __data CurrFwdAttn2_2G
CurrFwdAttn2_2G:
        DS8 1
// INT8U __data CurrRvsAttn1_2G
CurrRvsAttn1_2G:
        DS8 1
// INT8U __data CurrRvsAttn2_2G
CurrRvsAttn2_2G:
        DS8 1
// INT8U __data CurrRvsAttn3_2G
CurrRvsAttn3_2G:
        DS8 1
// INT8U __data CurrFwdAttn1_LTE
CurrFwdAttn1_LTE:
        DS8 1
// INT8U __data CurrFwdAttn2_LTE
CurrFwdAttn2_LTE:
        DS8 1
// INT8U __data CurrRvsAttn1_LTE
CurrRvsAttn1_LTE:
        DS8 1
// INT8U __data CurrRvsAttn2_LTE
CurrRvsAttn2_LTE:
        DS8 1
// INT8U __data CurrRvsAttn3_LTE
CurrRvsAttn3_LTE:
        DS8 1
// INT8U __data CurrFwdAttn1_LTE_A
CurrFwdAttn1_LTE_A:
        DS8 1
// INT8U __data CurrFwdAttn2_LTE_A
CurrFwdAttn2_LTE_A:
        DS8 1
// INT8U __data CurrRvsAttn1_LTE_A
CurrRvsAttn1_LTE_A:
        DS8 1
// INT8U __data CurrRvsAttn2_LTE_A
CurrRvsAttn2_LTE_A:
        DS8 1
// INT8U __data CurrRvsAttn3_LTE_A
CurrRvsAttn3_LTE_A:
        DS8 1
// INT8U __data CurrRvsAttn4_LTE_A
CurrRvsAttn4_LTE_A:
        DS8 1
// INT8U __data CurrFwdAttn1_3G
CurrFwdAttn1_3G:
        DS8 1
// INT8U __data CurrFwdAttn2_3G
CurrFwdAttn2_3G:
        DS8 1
// INT8U __data CurrRvsAttn1_3G
CurrRvsAttn1_3G:
        DS8 1
// INT8U __data CurrRvsAttn2_3G
CurrRvsAttn2_3G:
        DS8 1
// INT8U __data CurrRvsAttn3_3G
CurrRvsAttn3_3G:
        DS8 1
// INT8U __data CurrRvsAttn4_3G
CurrRvsAttn4_3G:
        DS8 1
// INT8U __data CurrFwdAttn1_Common
CurrFwdAttn1_Common:
        DS8 1
// INT8U __data CurrRvsAttn1_Common
CurrRvsAttn1_Common:
        DS8 1
// INT8U __data CurrFwd1Attn1_LTE
CurrFwd1Attn1_LTE:
        DS8 1
// INT8U __data CurrFwd1Attn2_LTE
CurrFwd1Attn2_LTE:
        DS8 1
// INT8U __data CurrRvs1Attn1_LTE
CurrRvs1Attn1_LTE:
        DS8 1
// INT8U __data CurrRvs1Attn2_LTE
CurrRvs1Attn2_LTE:
        DS8 1
// INT8U __data CurrRvs1Attn3_LTE
CurrRvs1Attn3_LTE:
        DS8 1
// INT8U __data CurrRvs1Attn4_LTE
CurrRvs1Attn4_LTE:
        DS8 1
// INT8U __data CurrFwd1Attn1_LTE_A
CurrFwd1Attn1_LTE_A:
        DS8 1
// INT8U __data CurrFwd1Attn2_LTE_A
CurrFwd1Attn2_LTE_A:
        DS8 1
// INT8U __data CurrRvs1Attn1_LTE_A
CurrRvs1Attn1_LTE_A:
        DS8 1
// INT8U __data CurrRvs1Attn2_LTE_A
CurrRvs1Attn2_LTE_A:
        DS8 1
// INT8U __data CurrRvs1Attn3_LTE_A
CurrRvs1Attn3_LTE_A:
        DS8 1
// INT8U __data CurrRvs1Attn4_LTE_A
CurrRvs1Attn4_LTE_A:
        DS8 1
// INT8U __data CurrBandSelect_15M
CurrBandSelect_15M:
        DS8 1
// INT16U __data TotalAlarm_Common
TotalAlarm_Common:
        DS8 2
// INT16U __data TotalAlarm_LTE_A
TotalAlarm_LTE_A:
        DS8 2
// INT16U __data TotalAlarm_3G
TotalAlarm_3G:
        DS8 2
// INT16U __data TotalAlarm_LTE1
TotalAlarm_LTE1:
        DS8 2
// INT16U __data TotalAlarm_LTE_A1
TotalAlarm_LTE_A1:
        DS8 2
// INT16U __data LowPwrAlarm_2G
LowPwrAlarm_2G:
        DS8 2
// INT16U __data LowPwrAlarm_3G
LowPwrAlarm_3G:
        DS8 2
// INT16U __data LowPwrAlarm_LTE
LowPwrAlarm_LTE:
        DS8 2
// INT16U __data LowPwrAlarm_LTE_A
LowPwrAlarm_LTE_A:
        DS8 2
// INT16U __data LowPwrAlarm_LTE1
LowPwrAlarm_LTE1:
        DS8 2
// INT16U __data LowPwrAlarm_LTE_A1
LowPwrAlarm_LTE_A1:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data Chk_Factory_default
Chk_Factory_default:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iResetCnt
iResetCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data TotalAlarm_2G
TotalAlarm_2G:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(1)
// INT16U __data TotalAlarm_LTE
TotalAlarm_LTE:
        DS8 2

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data PeriodCnt
PeriodCnt:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data ChkAttChange
ChkAttChange:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrFwdInAttn_2G
CurrFwdInAttn_2G:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrFwdInAttn_LTE
CurrFwdInAttn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRvs0Attn_LTE
CurrRvs0Attn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRvs1Attn_LTE
CurrRvs1Attn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRvs0InNFAttn_LTE
CurrRvs0InNFAttn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRvs0OutNFAttn_LTE
CurrRvs0OutNFAttn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRvs1InNFAttn_LTE
CurrRvs1InNFAttn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRvs1OutNFAttn_LTE
CurrRvs1OutNFAttn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrFwdOutALCAAttn_LTE
CurrFwdOutALCAAttn_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrFwdGain_LTE
CurrFwdGain_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrTxAttn0
CurrTxAttn0:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrTxAttn1
CurrTxAttn1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrExtTxAttn
CurrExtTxAttn:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRx0Attn1
CurrRx0Attn1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRx0Attn0
CurrRx0Attn0:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrExtRxAttn
CurrExtRxAttn:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrModemRxAttn
CurrModemRxAttn:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRx1Attn1
CurrRx1Attn1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8S __data CurrRx1Attn0
CurrRx1Attn0:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data CurrRvsAttn4_LTE
CurrRvsAttn4_LTE:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT8S __data dptr[10]
dptr:
        DS8 12

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data DnrCheckID
DnrCheckID:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data RmtCheckID
RmtCheckID:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT32U __data iDebug_Mode
iDebug_Mode:
        DS8 4
//   14 
//   15 #include <stdlib.h>
//   16 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   17 void ExpioInit(void)
//   18 {
//   19 
//   20 //	ExpioPortInit();
//   21 	OSTaskCreate(ExpioTask, (void *)NULL, (OS_STK *)&ExpioTaskStk[EXPIO_START_STK_SIZE - 1], EXPIO_START_PRIO);
ExpioInit:
        MOVS     R3,#+1
        LDR.N    R2,??ExpioInit_0  ;; ExpioTaskStk + 1020
        MOVS     R1,#+0
        LDR.N    R0,??ExpioInit_0+0x4  ;; ExpioTask
        B.W      OSTaskCreate
        DATA
??ExpioInit_0:
        DC32     ExpioTaskStk + 1020
        DC32     ExpioTask
//   22 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   23 void ExpioPortInit(void)
//   24 {
ExpioPortInit:
        PUSH     {R7,LR}
//   25 	#ifndef __FSMC_SRAM_H
//   26 		////////////////////////////////////////////////////////////////////////////
//   27 		// 반드시 gpio init 에서 --> outputmode로 변경해야 한다...
//   28 		// select 한핀은 반드시 모두다 high로 만들어줘야 한다.
//   29 		//GPIOC->ODR.Bit.ODR6 = 1;	// CS0
//   30 		//GPIOE->ODR.Bit.ODR10 = 1; // CS1
//   31 		/***
//   32 		GPIOB->ODR.Bit.ODR9 = 1;	// CS2
//   33 		GPIOB->ODR.Bit.ODR12 = 1;	// CS3
//   34 		GPIOB->ODR.Bit.ODR13 = 1;	// CS4
//   35 		GPIOB->ODR.Bit.ODR14 = 1;	// CS5
//   36 		GPIOB->ODR.Bit.ODR15 = 1;	// CS6
//   37 		GPIOC->ODR.Bit.ODR14 = 1;	// CS7
//   38 		GPIOC->ODR.Bit.ODR15 = 1;	// CS8
//   39 		GPIOA->ODR.Bit.ODR11 = 1;	// CS9
//   40 		GPIOA->ODR.Bit.ODR12 = 1;	// CS10
//   41 	***/
//   42 	#endif //__FSMC_SRAM_H
//   43 	ExpioSem = OSSemCreate(1);
        MOVS     R0,#+1
        BL       OSSemCreate
        LDR.N    R1,??ExpioPortInit_0  ;; ExpioSem
        STR      R0,[R1, #+0]
//   44 }
        POP      {R0,PC}          ;; return
        Nop      
        DATA
??ExpioPortInit_0:
        DC32     ExpioSem
//   45 
//   46 extern u32 CurrINT;
//   47 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   48 void ExpioTask(void *p_arg)
//   49 {
ExpioTask:
        PUSH     {R3-R5,LR}
//   50 	(void)p_arg;
//   51 
//   52 	TimerRegist(TimerLEDBlink, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+7
        BL       TimerRegist
//   53 	TimerRegist(Timer_AttnOut, Time1Sec*10L);
        MOVW     R1,#+10000
        MOVS     R0,#+9
        BL       TimerRegist
//   54 	TimerRegist(Timer_Period, Time1Sec*1L);
        MOV      R1,#+1000
        MOVS     R0,#+10
        BL       TimerRegist
//   55 	TimerRegist(Timer_AlarmInit, Time1Sec*5L);
        MOVW     R1,#+5000
        MOVS     R0,#+11
        BL       TimerRegist
//   56 
//   57 
//   58 	pPCA9555Port_Init(0);
        MOVS     R0,#+0
        BL       pPCA9555Port_Init
//   59 //	LED_Test();
//   60 	ADC_Select(0);
        MOVS     R0,#+0
        BL       ADC_Select
//   61 	TypeCheck();
        BL       TypeCheck
//   62 	OSTimeDly(500L);
        MOV      R0,#+500
        BL       OSTimeDly
//   63 
//   64 	pPCASetPortData(Attn_CS0, (0),pPCA9555Str);
        LDR.N    R4,??DataTable0  ;; pPCA9555Str
        LDR      R2,[R4, #+0]
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       pPCASetPortData
//   65 	pPCASetPortData(Attn_CS1, (0),pPCA9555Str);
        LDR      R2,[R4, #+0]
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       pPCASetPortData
//   66 	pPCASetPortData(Attn_CS2, (0),pPCA9555Str);
        LDR      R2,[R4, #+0]
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       pPCASetPortData
//   67 
//   68 	SMS_PWR = 0;
        LDR.W    R0,??DataTable11  ;; 0x4001180c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x800
        STR      R1,[R0, #+0]
        LDR.N    R4,??ExpioTask_0  ;; tTestFlag
        LDR.N    R5,??DataTable4  ;; LEDStatus
        B.N      ??ExpioTask_1
//   69 
//   70  	while(1)
//   71 	{
//   72 		while((DownLoadGiveupTimerSet(NULL)))
//   73 #if 0			
//   74 		{
//   75 //			AutoGetAdcValue();
//   76 			OSTimeDly(20L);
//   77 		}
//   78 #endif
//   79 		{
//   80 			if(DnLEDFlag)
//   81 			{
//   82 				FrontLEDSet(LED_SUMSel_2G, LEDAlmON);
//   83 				FrontLEDSet(LED_SUMSel_3G, LEDAlmON);
//   84 				FrontLEDSet(LED_SUMSel_LTE, LEDAlmON);
//   85 				FrontLEDSet(LED_SUMSel_LTE_A, LEDAlmON);
//   86 				FrontLEDSet(LED_SUMSel_LTE1, LEDAlmON);
//   87 				FrontLEDSet(LED_SUMSel_LTE_A1, LEDAlmON);
//   88 			}
//   89 			else
//   90 			{
//   91 				FrontLEDSet(LED_SUMSel_2G, LEDNorON);
??ExpioTask_2:
        MOVS     R1,#+0
        STR      R1,[R5, #+0]
//   92 				FrontLEDSet(LED_SUMSel_3G, LEDNorON);
//   93 				FrontLEDSet(LED_SUMSel_LTE, LEDNorON);
//   94 				FrontLEDSet(LED_SUMSel_LTE_A, LEDNorON);
//   95 				FrontLEDSet(LED_SUMSel_LTE1, LEDNorON);
        STRH     R1,[R5, #+4]
//   96 				FrontLEDSet(LED_SUMSel_LTE_A1, LEDNorON);
//   97 			}
//   98 
//   99 			DnLEDFlag ^= 1;
??ExpioTask_3:
        EOR      R0,R0,#0x1
        STRB     R0,[R5, #+8]
//  100 			FrontLEDDisplay();
        BL       FrontLEDDisplay
//  101 
//  102 			OSTimeDly(1000L);
        MOV      R0,#+1000
??ExpioTask_4:
        BL       OSTimeDly
??ExpioTask_1:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBZ      R0,??ExpioTask_5
        LDRB     R0,[R5, #+8]
        CMP      R0,#+0
        BEQ.N    ??ExpioTask_2
        MOVS     R1,#+2
        STRB     R1,[R5, #+0]
        STRB     R1,[R5, #+1]
        STRB     R1,[R5, #+2]
        STRB     R1,[R5, #+3]
        STRB     R1,[R5, #+4]
        STRB     R1,[R5, #+5]
//  103 		}
        B.N      ??ExpioTask_3
//  104 
//  105 
//  106 		while(!DownLoadGiveupTimerSet(NULL) && !tTestFlag)
//  107 		{
//  108 			TimerRelatedOperation();
??ExpioTask_6:
        BL       TimerRelatedOperation
//  109 			StatustoIO();
        BL       StatustoIO
//  110 			Period_Check();
        BL       Period_Check
//  111 			OSTimeDly(50L);
        MOVS     R0,#+50
        BL       OSTimeDly
//  112 		}
??ExpioTask_5:
        MOVS     R0,#+0
        BL       DownLoadGiveupTimerSet
        CBNZ     R0,??ExpioTask_7
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??ExpioTask_6
//  113 		OSTimeDly(500L);
??ExpioTask_7:
        MOV      R0,#+500
        B.N      ??ExpioTask_4
        DATA
??ExpioTask_0:
        DC32     tTestFlag
//  114 	}
//  115 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable0:
        DC32     pPCA9555Str
//  116 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  117 void ResetStart(void)
//  118 {
//  119 	TimerRegist(TimerReset, Time1Sec);
ResetStart:
        MOV      R1,#+1000
        MOVS     R0,#+17
        B.W      TimerRegist
//  120 }
//  121 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  122 INT8U F_RESET_IN_Read(void)
//  123 {
//  124     return 0;
F_RESET_IN_Read:
        MOVS     R0,#+0
        BX       LR               ;; return
//  125 }
//  126 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  127 void Period_Check(void)
//  128 {
Period_Check:
        PUSH     {R4,LR}
//  129 	if(!TimeOverCheck(Timer_Period)) return;
        MOVS     R0,#+10
        BL       TimeOverCheck
        CBZ      R0,??Period_Check_0
//  130 	TimerRegist(Timer_Period, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+10
        BL       TimerRegist
//  131 
//  132 	ShutDownCheck();
        BL       ShutDownCheck
//  133 	AlarmCheck_TRIO();
        BL       AlarmCheck_TRIO
//  134 	FrontLEDDisplay();
        BL       FrontLEDDisplay
//  135 
//  136 //	AutoGetAdcValue();
//  137 
//  138 	FwdAGCCheckFunction();
        BL       FwdAGCCheckFunction
//  139 
//  140 	if(++PeriodCnt > 2)
        LDR.N    R4,??Period_Check_1  ;; PeriodCnt
        LDRB     R0,[R4, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R4, #+0]
        UXTB     R0,R0
        CMP      R0,#+3
        BCC.N    ??Period_Check_2
//  141 	{
//  142 		RvsALCCheckFunction();
        BL       RvsALCCheckFunction
//  143 		PeriodCnt = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  144 	}
//  145 
//  146 	if(TimeOverCheck(Timer_AlarmInit))
??Period_Check_2:
        MOVS     R0,#+11
        BL       TimeOverCheck
        CBZ      R0,??Period_Check_0
//  147 	{
//  148 		ChkAlarm = SET;
        LDR.N    R0,??Period_Check_1+0x4  ;; ChkAlarm
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
??Period_Check_0:
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??Period_Check_1:
        DC32     PeriodCnt
        DC32     ChkAlarm
//  149 	}
//  150 }
//  151 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  152 INT8S MinMaxAttnCheck(INT16S cAttn, INT16S tMax, INT16S tMin)
//  153 {
//  154 	INT8S retval = cAttn;
//  155 	
//  156 	if(cAttn > tMax)
MinMaxAttnCheck:
        CMP      R1,R0
        BGE.N    ??MinMaxAttnCheck_0
//  157 	{
//  158 		retval = tMax;
        MOV      R0,R1
        B.N      ??MinMaxAttnCheck_1
//  159 	}
//  160 	else if(cAttn < tMin)
??MinMaxAttnCheck_0:
        CMP      R0,R2
        BGE.N    ??MinMaxAttnCheck_1
//  161 	{
//  162 		retval = tMin;
        MOV      R0,R2
//  163 	}
//  164 	
//  165 	return retval;
??MinMaxAttnCheck_1:
        SXTB     R0,R0
        BX       LR               ;; return
//  166 }
//  167 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  168 void FrontLEDSet(INT8U tindex, INT8U tstatus)
//  169 {
//  170 	LEDStatus[tindex%LED_SelMax] = tstatus;
FrontLEDSet:
        ASRS     R2,R0,#+3
        SUB      R0,R0,R2, LSL #+3
        LDR.N    R2,??DataTable4  ;; LEDStatus
        STRB     R1,[R0, R2]
//  171 }
        BX       LR               ;; return
//  172  

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  173 void FrontLEDDisplay(void)
//  174 {
FrontLEDDisplay:
        PUSH     {R3-R9,LR}
//  175 	INT16U i = 0;
//  176 
//  177 	if(!TimeOverCheck(TimerLEDBlink)) return;
        MOVS     R0,#+7
        BL       TimeOverCheck
        CMP      R0,#+0
        BEQ.W    ??FrontLEDDisplay_6
//  178 	TimerRegist(TimerLEDBlink, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+7
        BL       TimerRegist
//  179 
//  180 	for(i = 0; i < 6; i++)
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4  ;; LEDStatus
        MVN      R2,#+8192
        MVN      R3,#+32768
        MVN      R8,#+16384
        LDR.N    R5,??DataTable5  ;; 0x4001140c
        LDR.N    R6,??FrontLEDDisplay_7  ;; 0x4001080c
        LDR.N    R7,??FrontLEDDisplay_7+0x4  ;; 0x4001100c
        LDR.W    R12,??DataTable6  ;; 0x40010c0c
        LDR.W    LR,??DataTable11  ;; 0x4001180c
//  181 	{
//  182 		switch(LEDStatus[i])
??FrontLEDDisplay_8:
        LDRB     R4,[R1, #+0]
        CMP      R4,#+1
        BEQ.N    ??FrontLEDDisplay_9
        BCC.N    ??FrontLEDDisplay_10
        CMP      R4,#+3
        BEQ.W    ??FrontLEDDisplay_11
        BCC.N    ??FrontLEDDisplay_12
        CMP      R4,#+5
        BEQ.W    ??FrontLEDDisplay_13
        BCC.W    ??FrontLEDDisplay_14
//  183 		{
//  184         	default:
//  185 			case LEDNorON:
//  186 				switch(i)
??FrontLEDDisplay_10:
        UXTH     R4,R0
        CMP      R4,#+5
        BHI.W    ??FrontLEDDisplay_15
        TBH      [PC, R4, LSL #+1]
        DATA
??FrontLEDDisplay_0:
        DC16     +6,+15,+23,+31
        DC16     +39,+49
        THUMB
//  187 				{
//  188 					case LED_SUMSel_2G:
//  189 						_Normal_LED_2G 		= 1;
??FrontLEDDisplay_16:
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x10
??FrontLEDDisplay_17:
        STR      R4,[R5, #+0]
//  190 						_Alarm_LED_2G  		= 0;
        LDR      R4,[R5, #+0]
        BIC      R4,R4,#0x8
??FrontLEDDisplay_18:
        STR      R4,[R5, #+0]
        B.N      ??FrontLEDDisplay_15
//  191 					break;
//  192 						
//  193 					case LED_SUMSel_3G:
//  194 						_Normal_LED_3G 		= 1;
??FrontLEDDisplay_19:
        LDR      R4,[R6, #+0]
        ORR      R4,R4,#0x4000
??FrontLEDDisplay_20:
        STR      R4,[R6, #+0]
//  195 						_Alarm_LED_3G		= 0;
        LDR      R4,[R5, #+0]
        BIC      R4,R4,#0x80
        B.N      ??FrontLEDDisplay_18
//  196 					break;
//  197 
//  198 					case LED_SUMSel_LTE:
//  199 						_Normal_LED_LTE 	= 1;
??FrontLEDDisplay_21:
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x40
??FrontLEDDisplay_22:
        STR      R4,[R5, #+0]
//  200 						_Alarm_LED_LTE  	= 0;
        LDR      R4,[R5, #+0]
        BIC      R4,R4,#0x20
??FrontLEDDisplay_23:
        B.N      ??FrontLEDDisplay_18
//  201 					break;
//  202 
//  203 					case LED_SUMSel_LTE_A:
//  204 						_Normal_LED_LTE_A	= 1;
??FrontLEDDisplay_24:
        LDR      R4,[R7, #+0]
        ORR      R4,R4,#0x4000
??FrontLEDDisplay_25:
        STR      R4,[R7, #+0]
//  205 						_Alarm_LED_LTE_A	= 0;
        LDR      R4,[R6, #+0]
        ANDS     R4,R2,R4
??FrontLEDDisplay_26:
        STR      R4,[R6, #+0]
        B.N      ??FrontLEDDisplay_15
//  206 					break;
//  207 					
//  208 					case LED_SUMSel_LTE1:
//  209 						_Normal_LED_LTE1 	= 1;
??FrontLEDDisplay_27:
        LDR      R4,[R12, #+0]
        ORR      R4,R4,#0x200
??FrontLEDDisplay_28:
        STR      R4,[R12, #+0]
//  210 						_Alarm_LED_LTE1 	= 0;
        LDR      R4,[R7, #+0]
        ANDS     R4,R3,R4
??FrontLEDDisplay_29:
        STR      R4,[R7, #+0]
        B.N      ??FrontLEDDisplay_15
//  211 					break;
//  212 					
//  213 					case LED_SUMSel_LTE_A1:
//  214 						_Normal_LED_LTE_A1	= 1;
??FrontLEDDisplay_30:
        LDR      R4,[LR, #+0]
        ORR      R4,R4,#0x2
??FrontLEDDisplay_31:
        STR      R4,[LR, #+0]
//  215 						_Alarm_LED_LTE_A1	= 0;
        LDR      R4,[LR, #+0]
        MOV      R9,#+1
        BIC      R4,R4,R9
        B.N      ??FrontLEDDisplay_32
//  216 					break;
//  217 				}
//  218 			break;
//  219 
//  220 			case LEDNorONOFF:
//  221 				switch(i)
??FrontLEDDisplay_9:
        UXTH     R4,R0
        CMP      R4,#+5
        BHI.W    ??FrontLEDDisplay_15
        TBB      [PC, R4]
        DATA
??FrontLEDDisplay_1:
        DC8      +3,+106,+7,+11
        DC8      +15,+20
        THUMB
//  222 				{
//  223 					case LED_SUMSel_2G:
//  224 						_Normal_LED_2G 		= 0;
??FrontLEDDisplay_33:
        LDR      R4,[R5, #+0]
        BIC      R4,R4,#0x10
        B.N      ??FrontLEDDisplay_17
//  225 						_Alarm_LED_2G  		= 0;
//  226 					break;
//  227 						
//  228 					case LED_SUMSel_3G:
//  229 						_Normal_LED_3G 		= 0;
//  230 						_Alarm_LED_3G		= 0;
//  231 					break;
//  232 
//  233 					case LED_SUMSel_LTE:
//  234 						_Normal_LED_LTE 	= 0;
??FrontLEDDisplay_34:
        LDR      R4,[R5, #+0]
        BIC      R4,R4,#0x40
        B.N      ??FrontLEDDisplay_22
//  235 						_Alarm_LED_LTE  	= 0;
//  236 					break;
//  237 
//  238 					case LED_SUMSel_LTE_A:
//  239 						_Normal_LED_LTE_A	= 0;
??FrontLEDDisplay_35:
        LDR      R4,[R7, #+0]
        AND      R4,R8,R4
        B.N      ??FrontLEDDisplay_25
//  240 						_Alarm_LED_LTE_A	= 0;
//  241 					break;
//  242 					
//  243 					case LED_SUMSel_LTE1:
//  244 						_Normal_LED_LTE1 	= 0;
??FrontLEDDisplay_36:
        LDR      R4,[R12, #+0]
        BIC      R4,R4,#0x200
        B.N      ??FrontLEDDisplay_28
//  245 						_Alarm_LED_LTE1 	= 0;
//  246 					break;
//  247 					
//  248 					case LED_SUMSel_LTE_A1:
//  249 						_Normal_LED_LTE_A1	= 0;
??FrontLEDDisplay_37:
        LDR      R4,[LR, #+0]
        BIC      R4,R4,#0x2
        B.N      ??FrontLEDDisplay_31
//  250 						_Alarm_LED_LTE_A1	= 0;
//  251 					break;
//  252 				}
//  253 			break;
//  254 			
//  255 			case LEDAlmON:
//  256 				switch(i)
??FrontLEDDisplay_12:
        UXTH     R4,R0
        CMP      R4,#+5
        BHI.W    ??FrontLEDDisplay_15
        TBB      [PC, R4]
        DATA
??FrontLEDDisplay_2:
        DC8      +3,+55,+11,+19
        DC8      +27,+37
        THUMB
//  257 				{
//  258 					case LED_SUMSel_2G:
//  259 						_Normal_LED_2G 		= 0;
??FrontLEDDisplay_38:
        LDR      R4,[R5, #+0]
        BIC      R4,R4,#0x10
??FrontLEDDisplay_39:
        STR      R4,[R5, #+0]
//  260 						_Alarm_LED_2G  		= 1;
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x8
        B.N      ??FrontLEDDisplay_18
//  261 					break;
//  262 						
//  263 					case LED_SUMSel_3G:
//  264 						_Normal_LED_3G 		= 0;
//  265 						_Alarm_LED_3G		= 1;
//  266 					break;
//  267 
//  268 					case LED_SUMSel_LTE:
//  269 						_Normal_LED_LTE 	= 0;
??FrontLEDDisplay_40:
        LDR      R4,[R5, #+0]
        BIC      R4,R4,#0x40
        STR      R4,[R5, #+0]
//  270 						_Alarm_LED_LTE  	= 1;
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x20
        B.N      ??FrontLEDDisplay_18
//  271 					break;
//  272 
//  273 					case LED_SUMSel_LTE_A:
//  274 						_Normal_LED_LTE_A	= 0;
??FrontLEDDisplay_41:
        LDR      R4,[R7, #+0]
        AND      R4,R8,R4
??FrontLEDDisplay_42:
        STR      R4,[R7, #+0]
//  275 						_Alarm_LED_LTE_A	= 1;
        LDR      R4,[R6, #+0]
        ORR      R4,R4,#0x2000
        B.N      ??FrontLEDDisplay_26
//  276 					break;
//  277 					
//  278 					case LED_SUMSel_LTE1:
//  279 						_Normal_LED_LTE1 	= 0;
??FrontLEDDisplay_43:
        LDR      R4,[R12, #+0]
        BIC      R4,R4,#0x200
??FrontLEDDisplay_44:
        STR      R4,[R12, #+0]
//  280 						_Alarm_LED_LTE1 	= 1;
        LDR      R4,[R7, #+0]
        ORR      R4,R4,#0x8000
        B.N      ??FrontLEDDisplay_29
//  281 					break;
//  282 					
//  283 					case LED_SUMSel_LTE_A1:
//  284 						_Normal_LED_LTE_A1	= 0;
??FrontLEDDisplay_45:
        LDR      R4,[LR, #+0]
        BIC      R4,R4,#0x2
        B.N      ??FrontLEDDisplay_46
//  285 						_Alarm_LED_LTE_A1	= 1;
//  286 					break;
//  287 				}
//  288 			break;
//  289 			case LEDAlmONOFF:
//  290 				switch(i)
??FrontLEDDisplay_11:
        UXTH     R4,R0
        CMP      R4,#+5
        BHI.N    ??FrontLEDDisplay_15
        ADR      R9,??FrontLEDDisplay_3
        LDRSB    R9,[R9, R4]
        ADD      R9,R9,R9
        ADD      PC,PC,R9
        Nop      
        DATA
??FrontLEDDisplay_3:
        DC8      +207,+3,+215,+223
        DC8      +231,+241
        THUMB
??FrontLEDDisplay_47:
        LDR      R4,[R6, #+0]
        AND      R4,R8,R4
        STR      R4,[R6, #+0]
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x80
        B.N      ??FrontLEDDisplay_18
//  291 				{
//  292 					case LED_SUMSel_2G:
//  293 						_Normal_LED_2G 		= 0;
//  294 						_Alarm_LED_2G  		= 1;
//  295 					break;
//  296 						
//  297 					case LED_SUMSel_3G:
//  298 						_Normal_LED_3G 		= 0;
//  299 						_Alarm_LED_3G		= 1;
//  300 					break;
//  301 
//  302 					case LED_SUMSel_LTE:
//  303 						_Normal_LED_LTE 	= 0;
//  304 						_Alarm_LED_LTE  	= 1;
//  305 					break;
//  306 
//  307 					case LED_SUMSel_LTE_A:
//  308 						_Normal_LED_LTE_A	= 0;
//  309 						_Alarm_LED_LTE_A	= 1;
//  310 					break;
//  311 					
//  312 					case LED_SUMSel_LTE1:
//  313 						_Normal_LED_LTE1 	= 0;
//  314 						_Alarm_LED_LTE1 	= 1;
//  315 					break;
//  316 					
//  317 					case LED_SUMSel_LTE_A1:
//  318 						_Normal_LED_LTE_A1	= 0;
//  319 						_Alarm_LED_LTE_A1	= 1;
//  320 					break;
//  321 
//  322 				}
//  323 			break;
//  324 			case LEDAllOFF:
//  325 				switch(i)
??FrontLEDDisplay_14:
        UXTH     R4,R0
        CMP      R4,#+5
        BHI.N    ??FrontLEDDisplay_15
        ADR      R9,??FrontLEDDisplay_4
        LDRSB    R9,[R9, R4]
        ADD      R9,R9,R9
        ADD      PC,PC,R9
        DATA
??FrontLEDDisplay_4:
        DC8      +155,+2,+159,+163
        DC8      +167,+172
        THUMB
??FrontLEDDisplay_48:
        LDR      R4,[R6, #+0]
        AND      R4,R8,R4
        B.N      ??FrontLEDDisplay_20
//  326 				{
//  327 					case LED_SUMSel_2G:
//  328 						_Normal_LED_2G 		= 0;
//  329 						_Alarm_LED_2G  		= 0;
//  330 					break;
//  331 						
//  332 					case LED_SUMSel_3G:
//  333 						_Normal_LED_3G 		= 0;
//  334 						_Alarm_LED_3G		= 0;
//  335 					break;
//  336 
//  337 					case LED_SUMSel_LTE:
//  338 						_Normal_LED_LTE 	= 0;
//  339 						_Alarm_LED_LTE  	= 0;
//  340 					break;
//  341 
//  342 					case LED_SUMSel_LTE_A:
//  343 						_Normal_LED_LTE_A	= 0;
//  344 						_Alarm_LED_LTE_A	= 0;
//  345 					break;
//  346 					
//  347 					case LED_SUMSel_LTE1:
//  348 						_Normal_LED_LTE1 	= 0;
//  349 						_Alarm_LED_LTE1 	= 0;
//  350 					break;
//  351 					
//  352 					case LED_SUMSel_LTE_A1:
//  353 						_Normal_LED_LTE_A1	= 0;
//  354 						_Alarm_LED_LTE_A1	= 0;
//  355 					break;
//  356 
//  357 				}
//  358 			break;
//  359 			
//  360 			case LEDAllON:
//  361 				switch(i)
??FrontLEDDisplay_13:
        UXTH     R4,R0
        CMP      R4,#+5
        BHI.N    ??FrontLEDDisplay_15
        TBB      [PC, R4]
        DATA
??FrontLEDDisplay_5:
        DC8      +3,+7,+15,+23
        DC8      +27,+32
        THUMB
//  362 				{
//  363 					case LED_SUMSel_2G:
//  364 						_Normal_LED_2G 		= 1;
??FrontLEDDisplay_49:
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x10
        B.N      ??FrontLEDDisplay_39
//  365 						_Alarm_LED_2G  		= 1;
//  366 					break;
//  367 						
//  368 					case LED_SUMSel_3G:
//  369 						_Normal_LED_3G 		= 1;
??FrontLEDDisplay_50:
        LDR      R4,[R6, #+0]
        ORR      R4,R4,#0x4000
        STR      R4,[R6, #+0]
//  370 						_Alarm_LED_3G		= 1;
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x80
        B.N      ??FrontLEDDisplay_18
//  371 					break;
//  372 
//  373 					case LED_SUMSel_LTE:
//  374 						_Normal_LED_LTE 	= 1;
??FrontLEDDisplay_51:
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x40
        STR      R4,[R5, #+0]
//  375 						_Alarm_LED_LTE  	= 1;
        LDR      R4,[R5, #+0]
        ORR      R4,R4,#0x20
        B.N      ??FrontLEDDisplay_18
//  376 					break;
//  377 
//  378 					case LED_SUMSel_LTE_A:
//  379 						_Normal_LED_LTE_A	= 1;
??FrontLEDDisplay_52:
        LDR      R4,[R7, #+0]
        ORR      R4,R4,#0x4000
        B.N      ??FrontLEDDisplay_42
//  380 						_Alarm_LED_LTE_A	= 1;
//  381 					break;
//  382 					
//  383 					case LED_SUMSel_LTE1:
//  384 						_Normal_LED_LTE1 	= 1;
??FrontLEDDisplay_53:
        LDR      R4,[R12, #+0]
        ORR      R4,R4,#0x200
        B.N      ??FrontLEDDisplay_44
//  385 						_Alarm_LED_LTE1 	= 1;
//  386 					break;
//  387 					
//  388 					case LED_SUMSel_LTE_A1:
//  389 						_Normal_LED_LTE_A1	= 1;
??FrontLEDDisplay_54:
        LDR      R4,[LR, #+0]
        ORR      R4,R4,#0x2
??FrontLEDDisplay_46:
        STR      R4,[LR, #+0]
//  390 						_Alarm_LED_LTE_A1	= 1;
        LDR      R4,[LR, #+0]
        ORR      R4,R4,#0x1
??FrontLEDDisplay_32:
        STR      R4,[LR, #+0]
//  391 					break;
//  392 
//  393 				}
//  394 			break;
//  395 
//  396 
//  397 			
//  398 		}
//  399 	}
??FrontLEDDisplay_15:
        ADDS     R0,R0,#+1
        ADDS     R1,R1,#+1
        UXTH     R4,R0
        CMP      R4,#+6
        BCC.W    ??FrontLEDDisplay_8
??FrontLEDDisplay_6:
        POP      {R0,R4-R9,PC}    ;; return
        DATA
??FrontLEDDisplay_7:
        DC32     0x4001080c
        DC32     0x4001100c
//  400 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     LEDStatus

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x4001140c

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0x40010c0c
//  401  

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  402 void ADC_Select(INT8U Index)
//  403 {
//  404 	switch(Index)
ADC_Select:
        CMP      R0,#+0
        BEQ.N    ??ADC_Select_0
        CMP      R0,#+2
        BEQ.N    ??ADC_Select_1
        BCC.N    ??ADC_Select_2
        CMP      R0,#+3
        BEQ.N    ??ADC_Select_3
        BX       LR
//  405 	{
//  406 		case 0 :
//  407 			ADC_Sel0	= 0;
??ADC_Select_0:
        LDR.N    R0,??DataTable11  ;; 0x4001180c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x10
??ADC_Select_4:
        STR      R1,[R0, #+0]
//  408 			ADC_Sel1	= 0;
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x20
        B.N      ??ADC_Select_5
//  409 		break;
//  410 
//  411 		case 1 :
//  412 			ADC_Sel0	= 1;
??ADC_Select_2:
        LDR.N    R0,??DataTable11  ;; 0x4001180c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x10
        B.N      ??ADC_Select_4
//  413 			ADC_Sel1	= 0;
//  414 		break;
//  415 		
//  416 		case 2 :
//  417 			ADC_Sel0	= 0;
??ADC_Select_1:
        LDR.N    R0,??DataTable11  ;; 0x4001180c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x10
        B.N      ??ADC_Select_6
//  418 			ADC_Sel1	= 1;
//  419 		break;
//  420 
//  421 		case 3 :
//  422 			ADC_Sel0	= 1;
??ADC_Select_3:
        LDR.N    R0,??DataTable11  ;; 0x4001180c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x10
??ADC_Select_6:
        STR      R1,[R0, #+0]
//  423 			ADC_Sel1	= 1;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x20
??ADC_Select_5:
        STR      R1,[R0, #+0]
//  424 		break;
//  425 	}
//  426 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable11:
        DC32     0x4001180c
//  427 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  428 void ChangeLvltoValue(INT16S CurLvl, INT16S *PreLvl, INT16S *Cnt, INT16S *Value, INT8S MaxCnt)
//  429 {
ChangeLvltoValue:
        PUSH     {R4,R5}
        LDRSB    R4,[SP, #+8]
//  430 	if(*Value != CurLvl)
        LDRSH    R5,[R3, #+0]
        CMP      R5,R0
        BEQ.N    ??ChangeLvltoValue_0
//  431 	{
//  432 		if(*PreLvl == CurLvl)
        LDRSH    R5,[R1, #+0]
        CMP      R5,R0
        BNE.N    ??ChangeLvltoValue_1
//  433 		{
//  434 			*Cnt = *Cnt + 1;
        LDRH     R1,[R2, #+0]
        ADDS     R1,R1,#+1
        STRH     R1,[R2, #+0]
//  435 			if(*Cnt >= MaxCnt)
        SXTH     R1,R1
        CMP      R1,R4
        BLT.N    ??ChangeLvltoValue_2
//  436 			{
//  437 				*Value = CurLvl;
        STRH     R0,[R3, #+0]
//  438 				*Cnt = 0;
        B.N      ??ChangeLvltoValue_0
//  439 			}
//  440 		}
//  441 		else
//  442 		{
//  443 			*PreLvl = CurLvl;
??ChangeLvltoValue_1:
        STRH     R0,[R1, #+0]
//  444 			*Cnt = 0;
//  445 		}
//  446 	}
//  447 	else *Cnt = 0;
??ChangeLvltoValue_0:
        MOVS     R0,#+0
        STRH     R0,[R2, #+0]
//  448 }
??ChangeLvltoValue_2:
        POP      {R4,R5}
        BX       LR               ;; return
//  449 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  450 void AttChange(void)
//  451 {
AttChange:
        PUSH     {R3-R11,LR}
//  452 	INT8S tmpAtt_2G = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  453 	INT8S tmpAtt_LTE = 0;
        MOV      R11,R0
//  454 
//  455 	__Dnr_Sts  *Sts = tDnrSts;
        LDR.W    R0,??AttChange_0  ;; tDnrSts
        LDR      R8,[R0, #+0]
//  456 	
//  457 	///////////////////////// CDMA
//  458 
//  459 	if(Sts->AGCOnOff_2G == Enable)
        ADD      R9,R8,#+70
        LDRB     R0,[R9, #+24]
        CMP      R0,#+0
        BNE.N    ??AttChange_1
//  460 	{
//  461 		if(Sts->FwdAgcAttn_2G <= DIGATTENMAX_2G)	
        ADD      R7,R8,#+462
        LDRSB    R0,[R7, #+2]
        CMP      R0,#+51
        BGE.N    ??AttChange_2
//  462 		{
//  463 			Sts->FwdAttn1_2G = Sts->FwdAgcAttn_2G;
        MOV      R1,R0
        B.N      ??AttChange_3
//  464 		}
//  465 		else
//  466 		{
//  467 			tmpAtt_2G = Sts->FwdAttn1_2G - AGCATTENMAX_2G;
??AttChange_2:
        LDRSB    R1,[R8, #+162]
        SUBS     R1,R1,#+50
        STRB     R1,[SP, #+0]
//  468 			Sts->FwdAttn1_2G = AGCATTENMAX_2G;
        MOVS     R1,#+50
//  469 		}
//  470 
//  471 
//  472 		Sts->FwdAttn2_2G = DIGATTENMAX_2G - Sts->FwdAttn1_2G;
??AttChange_3:
        RSB      R2,R1,#+50
//  473 
//  474 
//  475 
//  476 		if(Sts->FwdAgcAttn_2G > AGCATTENMAX_2G)	
        CMP      R0,#+51
        BLT.N    ??AttChange_4
//  477 		{
//  478 			Sts->RvsAttn2_2G = Sts->FwdAgcAttn_2G - AGCATTENMAX_2G;
??AttChange_5:
        SUB      R3,R0,#+50
//  479 			Sts->RvsAttn3_2G = AGCATTENMAX_2G;
        MOVS     R0,#+50
        B.N      ??AttChange_6
//  480 		}
//  481 		else
//  482 		{
//  483 			Sts->RvsAttn2_2G = 0;
??AttChange_4:
        MOVS     R3,#+0
//  484 			Sts->RvsAttn3_2G = Sts->FwdAgcAttn_2G;
??AttChange_6:
        ADD      R5,R8,#+162
        STRB     R0,[R5, #+6]
        STRB     R3,[R5, #+5]
        STRB     R2,[R5, #+1]
        STRB     R1,[R8, #+162]
//  485 		}
//  486 		
//  487 		Sts->RvsAttn1_2G = Sts->RvsAlcAttn_2G;
        ADD      R0,R8,#+462
        LDRB     R0,[R0, #+6]
        STRB     R0,[R5, #+4]
//  488 		Sts->RvsAttn2_2G = Sts->RvsAttn2_2G + Sts->RvsGainBalance_2G;
        LDRB     R0,[R5, #+5]
        LDRB     R1,[R9, #+3]
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+5]
//  489 
//  490 	}
//  491 	else
//  492 	{
//  493 		if(ChkAttChange == RESET)
//  494 		{
//  495 			Sts->FwdAgcAttn_2G = Sts->FwdGainAttn_2G;
//  496 
//  497 			if(Sts->FwdGainAttn_2G <= DIGATTENMAX_2G)	
//  498 			{
//  499 				Sts->FwdAttn1_2G = Sts->FwdGainAttn_2G;
//  500 			}
//  501 			else
//  502 			{
//  503 				tmpAtt_2G = Sts->FwdAttn1_2G - AGCATTENMAX_2G;
//  504 				Sts->FwdAttn1_2G = AGCATTENMAX_2G;
//  505 			}
//  506 			
//  507 			Sts->FwdAttn2_2G = DIGATTENMAX_2G - Sts->FwdAttn1_2G;	
//  508 
//  509 			
//  510 			if(Sts->RvsGainAttn_2G > AGCATTENMAX_2G)	
//  511 			{
//  512 				Sts->RvsAttn2_2G = Sts->RvsGainAttn_2G - AGCATTENMAX_2G;
//  513 				Sts->RvsAttn3_2G = AGCATTENMAX_2G;
//  514 			}
//  515 			else
//  516 			{
//  517 				Sts->RvsAttn2_2G = 0;
//  518 				Sts->RvsAttn3_2G = Sts->RvsGainAttn_2G;
//  519 			}
//  520 			
//  521 			Sts->RvsAttn1_2G = Sts->RvsAlcAttn_2G;
//  522 			Sts->RvsAttn2_2G = Sts->RvsAttn2_2G + Sts->RvsGainBalance_2G;
//  523 		}
//  524 	}
//  525 
//  526 	Sts->FwdAttn2_2G = Sts->FwdAttn2_2G + Sts->FwdGainOffset_2G + Sts->FwdTemp_2G;
??AttChange_7:
        ADD      R10,R8,#+207
        ADD      R5,R8,#+162
        LDRB     R0,[R5, #+1]
        LDRB     R1,[R10, #+2]
        LDRSB    R2,[R10, #+6]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+1]
//  527 	Sts->RvsAttn1_2G = Sts->RvsAttn1_2G + Sts->RvsGainOffset_2G + Sts->RvsTemp_2G;
        LDRB     R0,[R5, #+4]
        LDRB     R1,[R10, #+3]
        LDRSB    R2,[R10, #+7]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+4]
//  528 	Sts->RvsAttn2_2G = Sts->RvsAttn2_2G + Sts->FwdFixAttn_2G;
        ADDW     R4,R8,#+870
        LDRB     R0,[R5, #+5]
        LDRB     R1,[R4, #+12]
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+5]
//  529 
//  530 	
//  531 	Sts->FwdAttn1_2G = MinMaxAttnCheck(Sts->FwdAttn1_2G, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R8, #+162]
        BL       MinMaxAttnCheck
        STRB     R0,[R8, #+162]
//  532 	Sts->FwdAttn2_2G = MinMaxAttnCheck(Sts->FwdAttn2_2G, DIGATTENMAX,ATTENMIN);
        MOV      R2,R11
        MOVS     R1,#+63
        LDRB     R0,[R5, #+1]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+1]
//  533 	Sts->RvsAttn1_2G = MinMaxAttnCheck(Sts->RvsAttn1_2G, DIGATTENMAX,ATTENMIN);
        MOV      R2,R11
        MOVS     R1,#+63
        LDRB     R0,[R5, #+4]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+4]
//  534 	Sts->RvsAttn2_2G = MinMaxAttnCheck(Sts->RvsAttn2_2G, DIGATTENMAX,ATTENMIN);
        MOV      R2,R11
        MOVS     R1,#+63
        LDRB     R0,[R5, #+5]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+5]
//  535 	Sts->RvsAttn3_2G = MinMaxAttnCheck(Sts->RvsAttn3_2G, DIGATTENMAX,ATTENMIN);
        MOV      R2,R11
        MOVS     R1,#+63
        LDRB     R0,[R5, #+6]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+6]
//  536 	/////////////////////////	LTE
//  537 
//  538 	if(Sts->AGCOnOff_LTE == Enable)
        LDRB     R0,[R9, #+27]
        CMP      R0,#+0
        BNE.N    ??AttChange_8
//  539 	{
//  540 		if(Sts->FwdAgcAttn_LTE <= DIGATTENMAX_2G)	
        ADD      R7,R8,#+462
        LDRSB    R0,[R7, #+3]
        ADD      R6,R8,#+430
        CMP      R0,#+51
        BGE.N    ??AttChange_9
//  541 		{
//  542 			Sts->FwdAttn1_LTE = Sts->FwdAgcAttn_LTE;
        MOV      R1,R0
        B.N      ??AttChange_10
//  543 		}
??AttChange_1:
        LDR.W    R0,??AttChange_0+0x4  ;; ChkAttChange
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??AttChange_7
        LDRB     R1,[R8, #+870]
        ADD      R0,R8,#+462
        STRB     R1,[R0, #+2]
        CMP      R1,#+51
        BCC.N    ??AttChange_11
        LDRSB    R0,[R8, #+162]
        SUBS     R0,R0,#+50
        STRB     R0,[SP, #+0]
        MOVS     R1,#+50
??AttChange_11:
        RSB      R2,R1,#+50
        ADDW     R4,R8,#+870
        LDRB     R0,[R4, #+1]
        CMP      R0,#+51
        BCC.N    ??AttChange_4
        B.N      ??AttChange_5
//  544 		else
//  545 		{
//  546 			tmpAtt_LTE = Sts->FwdAttn1_LTE - AGCATTENMAX_LTE;
??AttChange_9:
        LDRSB    R1,[R6, #+8]
        SUB      R11,R1,#+50
//  547 			Sts->FwdAttn1_LTE = AGCATTENMAX_LTE;
        MOVS     R1,#+50
??AttChange_10:
        STRB     R1,[R6, #+8]
//  548 		}
//  549 
//  550 		Sts->FwdAttn2_LTE = DIGATTENMAX_2G - Sts->FwdAttn1_LTE;
        LDRB     R1,[R6, #+8]
        RSB      R1,R1,#+50
        STRB     R1,[R6, #+9]
//  551 
//  552 		if(Sts->FwdAgcAttn_LTE > AGCATTENMAX_2G)	
        CMP      R0,#+51
        BLT.N    ??AttChange_12
//  553 		{
//  554 			Sts->RvsAttn2_LTE = Sts->FwdAgcAttn_LTE - AGCATTENMAX_2G;
        SUBS     R0,R0,#+50
        STRB     R0,[R6, #+13]
//  555 			Sts->RvsAttn3_LTE = AGCATTENMAX_LTE;
        MOVS     R0,#+50
        B.N      ??AttChange_13
//  556 		}
//  557 		else
//  558 		{
//  559 			Sts->RvsAttn2_LTE = 0;
??AttChange_12:
        MOVS     R1,#+0
        STRB     R1,[R6, #+13]
//  560 			Sts->RvsAttn3_LTE = Sts->FwdAgcAttn_LTE;
??AttChange_13:
        STRB     R0,[R6, #+14]
//  561 		}
//  562 		
//  563 		if(Sts->RvsAlcAttn_LTE > DIGATTENMAX_2G)	
        LDRSB    R0,[R7, #+7]
        CMP      R0,#+51
        ITTE     GE 
        SUBGE    R1,R0,#+50
        MOVGE    R0,#+50
        MOVLT    R1,#+0
//  564 		{
//  565 			Sts->RvsAttn1_LTE = Sts->RvsAlcAttn_LTE - DIGATTENMAX_2G;
//  566 			Sts->RvsAttn2_LTE = DIGATTENMAX_2G;
//  567 		}
//  568 		else
//  569 		{
//  570 			Sts->RvsAttn1_LTE = 0;
//  571 			Sts->RvsAttn2_LTE = Sts->RvsAlcAttn_LTE;
        STRB     R0,[R6, #+13]
        STRB     R1,[R6, #+12]
//  572 		}
//  573 
//  574 		Sts->RvsAttn3_LTE = Sts->RvsAttn3_LTE + Sts->RvsGainBalance_LTE;
        LDRB     R0,[R6, #+14]
        LDRB     R1,[R9, #+6]
        ADDS     R0,R1,R0
        STRB     R0,[R6, #+14]
        B.N      ??AttChange_14
//  575 
//  576 	}
//  577 	else
//  578 	{
//  579 		if(ChkAttChange == RESET)
??AttChange_8:
        LDR.W    R0,??AttChange_0+0x4  ;; ChkAttChange
        LDRB     R0,[R0, #+0]
        CBNZ     R0,??AttChange_14
//  580 		{
//  581 			Sts->FwdAgcAttn_LTE = Sts->FwdGainAttn_LTE;
        ADD      R7,R8,#+462
        LDRSB    R0,[R4, #+4]
        STRB     R0,[R7, #+3]
//  582 
//  583 			if(Sts->FwdAgcAttn_LTE <= DIGATTENMAX_2G)	
        ADD      R6,R8,#+430
        CMP      R0,#+51
        BLT.N    ??AttChange_15
//  584 			{
//  585 				Sts->FwdAttn1_LTE = Sts->FwdAgcAttn_LTE;
//  586 			}
//  587 			else
//  588 			{
//  589 				tmpAtt_LTE = Sts->FwdAttn1_LTE - AGCATTENMAX_LTE;
        LDRSB    R0,[R6, #+8]
        SUB      R11,R0,#+50
//  590 				Sts->FwdAttn1_LTE = AGCATTENMAX_LTE;
        MOVS     R0,#+50
??AttChange_15:
        STRB     R0,[R6, #+8]
//  591 			}
//  592 
//  593 			
//  594 			Sts->FwdAttn2_LTE = DIGATTENMAX_2G - Sts->FwdAttn1_LTE;
        LDRB     R0,[R6, #+8]
        RSB      R0,R0,#+50
        STRB     R0,[R6, #+9]
//  595 			
//  596 
//  597 			if(Sts->RvsGainAttn_LTE > AGCATTENMAX_LTE) 
        LDRB     R0,[R4, #+5]
        CMP      R0,#+51
        ITTE     CS 
        SUBCS    R1,R0,#+50
        MOVCS    R0,#+50
        MOVCC    R1,#+0
//  598 			{
//  599 				Sts->RvsAttn2_LTE = Sts->RvsGainAttn_LTE- AGCATTENMAX_LTE;
//  600 				Sts->RvsAttn3_LTE = AGCATTENMAX_LTE;
//  601 			}
//  602 			else
//  603 			{
//  604 				Sts->RvsAttn2_LTE = 0;
//  605 				Sts->RvsAttn3_LTE = Sts->RvsGainAttn_LTE;
        STRB     R0,[R6, #+14]
//  606 			}
//  607 			
//  608 			Sts->RvsAttn1_LTE = Sts->RvsAlcAttn_LTE;
        LDRB     R0,[R7, #+7]
        STRB     R0,[R6, #+12]
//  609 			Sts->RvsAttn2_LTE = Sts->RvsAttn2_LTE + Sts->RvsGainBalance_LTE;
        LDRB     R0,[R9, #+6]
        ADDS     R0,R0,R1
        STRB     R0,[R6, #+13]
//  610 		}
//  611 	}
//  612 
//  613 #if 1
//  614 	if(tmpAtt_2G > tmpAtt_LTE)
??AttChange_14:
        LDRSB    R0,[SP, #+0]
        SXTB     R11,R11
        CMP      R11,R0
        BGE.N    ??AttChange_16
//  615 	{
//  616 		Sts->FwdAttn3_Common = tmpAtt_2G;
        LDRB     R11,[SP, #+0]
//  617 	}
//  618 	else
//  619 	{
//  620 		Sts->FwdAttn3_Common = tmpAtt_LTE;
??AttChange_16:
        ADD      R6,R8,#+430
        STRB     R11,[R6, #+6]
//  621 	}
//  622 
//  623 	if(Sts->FwdAttn2_Common > Sts->FwdAttn3_Common)
        LDRB     R0,[R6, #+6]
        LDRB     R1,[R6, #+4]
        CMP      R0,R1
        BCS.N    ??AttChange_17
        MOV      R0,R1
??AttChange_17:
        ADD      R1,R8,#+430
        STRB     R0,[R1, #+0]
//  624 	{
//  625 		Sts->FwdAttn1_Common = Sts->FwdAttn2_Common;
//  626 	}
//  627 	else
//  628 	{
//  629 		Sts->FwdAttn1_Common = Sts->FwdAttn3_Common;
//  630 	}
//  631 #endif
//  632 
//  633 	
//  634 	Sts->FwdAttn2_LTE = Sts->FwdAttn2_LTE + Sts->FwdGainOffset_LTE + Sts->FwdTemp_LTE;
        ADD      R7,R8,#+462
        LDRB     R0,[R6, #+9]
        LDRB     R1,[R6, #+30]
        LDRSB    R2,[R7, #+39]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R6, #+9]
//  635 	Sts->RvsAttn1_LTE = Sts->RvsAttn1_LTE + Sts->RvsGainOffset_LTE + Sts->RvsTemp_LTE;
        LDRB     R0,[R6, #+12]
        LDRB     R1,[R6, #+31]
        LDRSB    R2,[R7, #+40]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R6, #+12]
//  636 	Sts->RvsAttn2_LTE = Sts->RvsAttn2_LTE + Sts->FwdFixAttn_LTE;
        LDRB     R0,[R6, #+13]
        LDRB     R1,[R4, #+13]
        ADDS     R0,R1,R0
        STRB     R0,[R6, #+13]
//  637 
//  638 	Sts->FwdAttn1_LTE = MinMaxAttnCheck(Sts->FwdAttn1_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+8]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+8]
//  639 	Sts->FwdAttn2_LTE = MinMaxAttnCheck(Sts->FwdAttn2_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+9]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+9]
//  640 	Sts->RvsAttn1_LTE = MinMaxAttnCheck(Sts->RvsAttn1_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+12]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+12]
//  641 	Sts->RvsAttn2_LTE = MinMaxAttnCheck(Sts->RvsAttn2_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+13]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+13]
//  642 	Sts->RvsAttn3_LTE = MinMaxAttnCheck(Sts->RvsAttn3_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+14]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+14]
//  643 
//  644 	/////////////////////////	LTE-A
//  645 	if(Sts->AGCOnOff_2G == Enable)
        LDRB     R0,[R9, #+24]
        CMP      R0,#+0
        BNE.N    ??AttChange_18
//  646 	{
//  647 		if(Sts->FwdAgcAttn_LTE_A > DIGATTENMAX_LTE_A)	
        LDRSB    R0,[R7, #+4]
        CMP      R0,#+51
        BLT.N    ??AttChange_19
//  648 		{
//  649 			Sts->FwdAttn1_LTE_A = Sts->FwdAgcAttn_LTE_A - DIGATTENMAX_LTE_A;
        SUB      R1,R0,#+50
//  650 			Sts->FwdAttn2_LTE_A = DIGATTENMAX_2G;
        MOVS     R2,#+50
//  651 		}
//  652 		else
//  653 		{
//  654 			Sts->FwdAttn1_LTE_A = 0;
//  655 			Sts->FwdAttn2_LTE_A = Sts->FwdAgcAttn_LTE_A;
//  656 		}
//  657 		
//  658 		if(Sts->FwdAgcAttn_LTE_A > AGCATTENMAX_LTE_A)	
        CMP      R0,#+61
        BLT.N    ??AttChange_20
//  659 		{
//  660 			Sts->RvsAttn3_LTE_A = Sts->FwdAgcAttn_LTE_A - AGCATTENMAX_LTE_A;
??AttChange_21:
        SUB      R3,R0,#+60
//  661 			Sts->RvsAttn4_LTE_A = AGCATTENMAX_LTE_A;
        MOVS     R0,#+60
        B.N      ??AttChange_22
//  662 		}
??AttChange_19:
        MOVS     R1,#+0
        MOV      R2,R0
//  663 		else
//  664 		{
//  665 			Sts->RvsAttn3_LTE_A = 0;
??AttChange_20:
        MOVS     R3,#+0
//  666 			Sts->RvsAttn4_LTE_A = Sts->FwdAgcAttn_LTE_A;
??AttChange_22:
        STRB     R0,[R6, #+18]
        STRB     R3,[R6, #+17]
        STRB     R2,[R6, #+11]
        STRB     R1,[R6, #+10]
//  667 		}
//  668 		
//  669 		
//  670 		if(Sts->RvsAlcAttn_LTE_A > DIGATTENMAX_LTE_A)	
        LDRSB    R0,[R7, #+8]
        CMP      R0,#+51
        ITTE     GE 
        SUBGE    R1,R0,#+50
        MOVGE    R0,#+50
        MOVLT    R1,#+0
//  671 		{
//  672 			Sts->RvsAttn1_LTE_A = Sts->RvsAlcAttn_LTE_A - DIGATTENMAX_LTE_A;
//  673 			Sts->RvsAttn2_LTE_A = DIGATTENMAX_LTE_A;
//  674 		}
//  675 		else
//  676 		{
//  677 			Sts->RvsAttn1_LTE_A = 0;
//  678 			Sts->RvsAttn2_LTE_A = Sts->RvsAlcAttn_LTE_A;
        STRB     R0,[R6, #+16]
        STRB     R1,[R6, #+15]
//  679 		}
//  680 		
//  681 		Sts->RvsAttn3_LTE_A = Sts->RvsAttn3_LTE_A + Sts->RvsGainBalance_LTE_A;
        LDRB     R0,[R6, #+17]
        LDRB     R1,[R9, #+9]
        ADDS     R0,R1,R0
        STRB     R0,[R6, #+17]
//  682 	}
//  683 	else
//  684 	{
//  685 		if(ChkAttChange == RESET)
//  686 		{
//  687 			Sts->FwdAgcAttn_LTE_A = Sts->FwdGainAttn_LTE_A;
//  688 
//  689 			if(Sts->FwdAgcAttn_LTE_A > DIGATTENMAX_LTE_A)	
//  690 			{
//  691 				Sts->FwdAttn1_LTE_A = Sts->FwdAgcAttn_LTE_A - DIGATTENMAX_LTE_A;
//  692 				Sts->FwdAttn2_LTE_A = DIGATTENMAX_2G;
//  693 			}
//  694 			else
//  695 			{
//  696 				Sts->FwdAttn1_LTE_A = 0;
//  697 				Sts->FwdAttn2_LTE_A = Sts->FwdAgcAttn_LTE_A;
//  698 			}
//  699 			
//  700 			if(Sts->RvsGainAttn_LTE_A > AGCATTENMAX_LTE_A)	
//  701 			{
//  702 				Sts->RvsAttn3_LTE_A = Sts->RvsGainAttn_LTE_A - AGCATTENMAX_LTE_A;
//  703 				Sts->RvsAttn4_LTE_A = AGCATTENMAX_LTE_A;
//  704 			}
//  705 			else
//  706 			{
//  707 				Sts->RvsAttn3_LTE_A = 0;
//  708 				Sts->RvsAttn4_LTE_A = Sts->RvsGainAttn_LTE_A;
//  709 			}
//  710 			
//  711 			
//  712 			if(Sts->RvsAlcAttn_LTE_A > DIGATTENMAX_LTE_A)	
//  713 			{
//  714 				Sts->RvsAttn1_LTE_A = Sts->RvsAlcAttn_LTE_A - DIGATTENMAX_LTE_A;
//  715 				Sts->RvsAttn2_LTE_A = DIGATTENMAX_LTE_A;
//  716 			}
//  717 			else
//  718 			{
//  719 				Sts->RvsAttn1_LTE_A = 0;
//  720 				Sts->RvsAttn2_LTE_A = Sts->RvsAlcAttn_LTE_A;
//  721 			}
//  722 			
//  723 			Sts->RvsAttn3_LTE_A = Sts->RvsAttn3_LTE_A + Sts->RvsGainBalance_LTE_A;
//  724 
//  725 
//  726 		}
//  727 	}
//  728 	Sts->FwdAttn2_LTE_A = Sts->FwdAttn2_LTE_A + Sts->FwdGainOffset_LTE_A + Sts->FwdTemp_LTE_A;
??AttChange_23:
        LDRB     R0,[R6, #+11]
        ADD      R1,R8,#+462
        LDRB     R1,[R1, #+0]
        LDRSB    R2,[R7, #+41]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R6, #+11]
//  729 	Sts->RvsAttn3_LTE_A = Sts->RvsAttn3_LTE_A + Sts->RvsGainOffset_LTE_A + Sts->RvsTemp_LTE_A;
        LDRB     R0,[R6, #+17]
        LDRB     R1,[R7, #+1]
        LDRSB    R2,[R7, #+42]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R6, #+17]
//  730 
//  731 	Sts->FwdAttn1_LTE_A	= MinMaxAttnCheck(Sts->FwdAttn1_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+10]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+10]
//  732 	Sts->FwdAttn2_LTE_A	= MinMaxAttnCheck(Sts->FwdAttn2_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+11]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+11]
//  733 	Sts->RvsAttn1_LTE_A	= MinMaxAttnCheck(Sts->RvsAttn1_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+15]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+15]
//  734 	Sts->RvsAttn2_LTE_A	= MinMaxAttnCheck(Sts->RvsAttn2_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+16]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+16]
//  735 	Sts->RvsAttn3_LTE_A = MinMaxAttnCheck(Sts->RvsAttn3_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+17]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+17]
//  736 	Sts->RvsAttn4_LTE_A = MinMaxAttnCheck(Sts->RvsAttn4_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R6, #+18]
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+18]
//  737 
//  738  	/////////////////////////	WCDMA
//  739 
//  740 	if(Sts->AGCOnOff_3G == Enable)
        LDRB     R0,[R9, #+23]
        CMP      R0,#+0
        BNE.N    ??AttChange_24
//  741 	{
//  742 		if(Sts->FwdAgcAttn_3G > DIGATTENMAX_3G) 
        LDRSB    R0,[R7, #+5]
        CMP      R0,#+51
        BLT.N    ??AttChange_25
//  743 		{
//  744 			Sts->FwdAttn1_3G = Sts->FwdAgcAttn_3G - DIGATTENMAX_2G;
        SUB      R1,R0,#+50
//  745 			Sts->FwdAttn2_3G = DIGATTENMAX_2G;
        MOVS     R2,#+50
//  746 		}
//  747 		else
//  748 		{
//  749 			Sts->FwdAttn1_3G = 0;
//  750 			Sts->FwdAttn2_3G = Sts->FwdAgcAttn_3G;
//  751 		}
//  752 		
//  753 		if(Sts->FwdAgcAttn_3G > AGCATTENMAX_3G)	
        CMP      R0,#+61
        BLT.N    ??AttChange_26
//  754 		{
//  755 			Sts->RvsAttn3_3G = Sts->FwdAgcAttn_3G - AGCATTENMAX_3G;
??AttChange_27:
        SUB      R3,R0,#+60
//  756 			Sts->RvsAttn4_3G = AGCATTENMAX_3G;
        MOVS     R0,#+60
        B.N      ??AttChange_28
//  757 		}
??AttChange_18:
        LDR.W    R0,??AttChange_0+0x4  ;; ChkAttChange
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??AttChange_23
        LDRSB    R0,[R4, #+6]
        STRB     R0,[R7, #+4]
        MOV      R2,R0
        CMP      R2,#+51
        ITTE     GE 
        SUBGE    R1,R2,#+50
        MOVGE    R2,#+50
        MOVLT    R1,#+0
        LDRB     R0,[R4, #+7]
        CMP      R0,#+61
        BCC.N    ??AttChange_20
        B.N      ??AttChange_21
??AttChange_25:
        MOVS     R1,#+0
        MOV      R2,R0
//  758 		else
//  759 		{
//  760 			Sts->RvsAttn3_3G = 0;
??AttChange_26:
        MOVS     R3,#+0
//  761 			Sts->RvsAttn4_3G = Sts->FwdAgcAttn_3G;
??AttChange_28:
        STRB     R0,[R5, #+11]
        STRB     R3,[R5, #+10]
        STRB     R2,[R5, #+3]
        STRB     R1,[R5, #+2]
//  762 		}
//  763 		
//  764 		
//  765 		if(Sts->RvsAlcAttn_3G > DIGATTENMAX_3G) 
        LDRSB    R0,[R7, #+9]
        CMP      R0,#+51
        ITTE     GE 
        SUBGE    R1,R0,#+50
        MOVGE    R0,#+50
        MOVLT    R1,#+0
//  766 		{
//  767 			Sts->RvsAttn1_3G = Sts->RvsAlcAttn_3G - DIGATTENMAX_3G;
//  768 			Sts->RvsAttn2_3G = DIGATTENMAX_3G;
//  769 		}
//  770 		else
//  771 		{
//  772 			Sts->RvsAttn1_3G = 0;
//  773 			Sts->RvsAttn2_3G = Sts->RvsAlcAttn_3G;
        STRB     R0,[R5, #+9]
        STRB     R1,[R5, #+8]
//  774 		}
//  775 		
//  776 		Sts->RvsAttn3_3G = Sts->RvsAttn3_3G + Sts->RvsGainBalance_3G;
        LDRB     R0,[R5, #+10]
        LDRB     R1,[R8, #+70]
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+10]
//  777 	}
//  778 	else
//  779 	{
//  780 		if(ChkAttChange == RESET)
//  781 		{
//  782 			Sts->FwdAgcAttn_3G = Sts->FwdGainAttn_3G;
//  783 
//  784 			if(Sts->FwdAgcAttn_3G > DIGATTENMAX_3G) 
//  785 			{
//  786 				Sts->FwdAttn1_3G = Sts->FwdAgcAttn_3G - DIGATTENMAX_2G;
//  787 				Sts->FwdAttn2_3G = DIGATTENMAX_2G;
//  788 			}
//  789 			else
//  790 			{
//  791 				Sts->FwdAttn1_3G = 0;
//  792 				Sts->FwdAttn2_3G = Sts->FwdAgcAttn_3G;
//  793 			}
//  794 			
//  795 			if(Sts->RvsGainAttn_3G > AGCATTENMAX_3G)	
//  796 			{
//  797 				Sts->RvsAttn3_3G = Sts->RvsGainAttn_3G - AGCATTENMAX_3G;
//  798 				Sts->RvsAttn4_3G = AGCATTENMAX_3G;
//  799 			}
//  800 			else
//  801 			{
//  802 				Sts->RvsAttn3_3G = 0;
//  803 				Sts->RvsAttn4_3G = Sts->RvsGainAttn_3G;
//  804 			}
//  805 			
//  806 			
//  807 			if(Sts->RvsAlcAttn_3G > DIGATTENMAX_3G) 
//  808 			{
//  809 				Sts->RvsAttn1_3G = Sts->RvsAlcAttn_3G - DIGATTENMAX_3G;
//  810 				Sts->RvsAttn2_3G = DIGATTENMAX_3G;
//  811 			}
//  812 			else
//  813 			{
//  814 				Sts->RvsAttn1_3G = 0;
//  815 				Sts->RvsAttn2_3G = Sts->RvsAlcAttn_3G;
//  816 			}
//  817 			
//  818 			Sts->RvsAttn3_3G = Sts->RvsAttn3_3G + Sts->RvsGainBalance_3G;
//  819 
//  820 		}
//  821 	}
//  822 
//  823 	Sts->FwdAttn2_3G = Sts->FwdAttn2_3G + Sts->FwdGainOffset_3G + Sts->FwdTemp_3G;
??AttChange_29:
        LDRB     R0,[R5, #+3]
        LDRB     R1,[R8, #+207]
        LDRSB    R2,[R10, #+4]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+3]
//  824 	Sts->RvsAttn3_3G = Sts->RvsAttn3_3G + Sts->RvsGainOffset_3G + Sts->RvsTemp_3G;
        LDRB     R0,[R5, #+10]
        LDRB     R1,[R10, #+1]
        LDRSB    R2,[R10, #+5]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R5, #+10]
//  825 
//  826 	Sts->FwdAttn1_3G = MinMaxAttnCheck(Sts->FwdAttn1_3G, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R5, #+2]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+2]
//  827 	Sts->FwdAttn2_3G = MinMaxAttnCheck(Sts->FwdAttn2_3G, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R5, #+3]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+3]
//  828 	Sts->RvsAttn1_3G = MinMaxAttnCheck(Sts->RvsAttn1_3G, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R5, #+8]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+8]
//  829 	Sts->RvsAttn2_3G = MinMaxAttnCheck(Sts->RvsAttn2_3G, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R5, #+9]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+9]
//  830 	Sts->RvsAttn3_3G = MinMaxAttnCheck(Sts->RvsAttn3_3G, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R5, #+10]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+10]
//  831 	Sts->RvsAttn4_3G = MinMaxAttnCheck(Sts->RvsAttn4_3G, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R5, #+11]
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+11]
//  832 
//  833 	
//  834 
//  835 #ifdef _MIMO_Type     
//  836 	///////////////////////// LTE1
//  837 
//  838 	if(Sts->AGC1OnOff_LTE_A == Enable)
        LDRB     R0,[R8, #+102]
        CMP      R0,#+0
        BNE.N    ??AttChange_30
//  839 	{
//  840 		if(Sts->Fwd1AgcAttn_LTE > DIGATTENMAX_LTE1) 
        ADDW     R7,R8,#+765
        LDRB     R0,[R7, #+28]
        CMP      R0,#+51
        BCC.N    ??AttChange_31
//  841 		{
//  842 			Sts->Fwd1Attn1_LTE = Sts->Fwd1AgcAttn_LTE - DIGATTENMAX_LTE1;
        SUB      R1,R0,#+50
//  843 			Sts->Fwd1Attn2_LTE = DIGATTENMAX_LTE1;
        MOVS     R2,#+50
//  844 		}
//  845 		else
//  846 		{
//  847 			Sts->Fwd1Attn1_LTE = 0;
//  848 			Sts->Fwd1Attn2_LTE = Sts->Fwd1AgcAttn_LTE;
//  849 		}
//  850 		
//  851 		if(Sts->Fwd1AgcAttn_LTE > AGCATTENMAX_LTE_A)	
        CMP      R0,#+61
        BCC.N    ??AttChange_32
//  852 		{
//  853 			Sts->Rvs1Attn3_LTE = Sts->Fwd1AgcAttn_LTE - AGCATTENMAX_LTE_A;
??AttChange_33:
        SUB      R3,R0,#+60
//  854 			Sts->Rvs1Attn4_LTE = AGCATTENMAX_LTE_A;
        MOVS     R0,#+60
        B.N      ??AttChange_34
//  855 		}
??AttChange_24:
        LDR.W    R0,??AttChange_0+0x4  ;; ChkAttChange
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??AttChange_29
        LDRSB    R0,[R4, #+2]
        STRB     R0,[R7, #+5]
        MOV      R2,R0
        CMP      R2,#+51
        ITTE     GE 
        SUBGE    R1,R2,#+50
        MOVGE    R2,#+50
        MOVLT    R1,#+0
        LDRB     R0,[R4, #+3]
        CMP      R0,#+61
        BCC.N    ??AttChange_26
        B.N      ??AttChange_27
??AttChange_31:
        MOVS     R1,#+0
        MOV      R2,R0
//  856 		else
//  857 		{
//  858 			Sts->Rvs1Attn3_LTE = 0;
??AttChange_32:
        MOVS     R3,#+0
//  859 			Sts->Rvs1Attn4_LTE = Sts->Fwd1AgcAttn_LTE;
??AttChange_34:
        STRB     R0,[R7, #+7]
        STRB     R3,[R7, #+6]
        STRB     R2,[R7, #+1]
        STRB     R1,[R8, #+765]
//  860 		}
//  861 		
//  862 		
//  863 		if(Sts->Rvs1AlcAttn_LTE > DIGATTENMAX_LTE1) 
        LDRB     R0,[R7, #+30]
        CMP      R0,#+51
        ITTE     CS 
        SUBCS    R1,R0,#+50
        MOVCS    R0,#+50
        MOVCC    R1,#+0
//  864 		{
//  865 			Sts->Rvs1Attn1_LTE = Sts->Rvs1AlcAttn_LTE - DIGATTENMAX_LTE1;
//  866 			Sts->Rvs1Attn2_LTE = DIGATTENMAX_LTE1;
//  867 		}
//  868 		else
//  869 		{
//  870 			Sts->Rvs1Attn1_LTE = 0;
//  871 			Sts->Rvs1Attn2_LTE = Sts->Rvs1AlcAttn_LTE;
        STRB     R0,[R7, #+5]
        STRB     R1,[R7, #+4]
//  872 		}
//  873 		
//  874 		Sts->Rvs1Attn3_LTE = Sts->Rvs1Attn3_LTE + Sts->Rvs1GainBalance_LTE;
        LDRB     R0,[R7, #+6]
        LDRB     R1,[R8, #+673]
        ADDS     R0,R1,R0
        STRB     R0,[R7, #+6]
//  875 
//  876 	}
//  877 	else
//  878 	{
//  879 		if(ChkAttChange == RESET)
//  880 		{
//  881 			Sts->Fwd1AgcAttn_LTE = Sts->Fwd1GainAttn_LTE;
//  882 
//  883 			if(Sts->Fwd1AgcAttn_LTE > DIGATTENMAX_LTE1) 
//  884 			{
//  885 				Sts->Fwd1Attn1_LTE = Sts->Fwd1AgcAttn_LTE - DIGATTENMAX_LTE1;
//  886 				Sts->Fwd1Attn2_LTE = DIGATTENMAX_LTE1;
//  887 			}
//  888 			else
//  889 			{
//  890 				Sts->Fwd1Attn1_LTE = 0;
//  891 				Sts->Fwd1Attn2_LTE = Sts->Fwd1AgcAttn_LTE;
//  892 			}
//  893 			
//  894 			if(Sts->Rvs1GainAttn_LTE > AGCATTENMAX_LTE_A)	
//  895 			{
//  896 				Sts->Rvs1Attn3_LTE = Sts->Rvs1GainAttn_LTE - AGCATTENMAX_LTE_A;
//  897 				Sts->Rvs1Attn4_LTE = AGCATTENMAX_LTE_A;
//  898 			}
//  899 			else
//  900 			{
//  901 				Sts->Rvs1Attn3_LTE = 0;
//  902 				Sts->Rvs1Attn4_LTE = Sts->Rvs1GainAttn_LTE;
//  903 			}
//  904 			
//  905 			if(Sts->Rvs1AlcAttn_LTE > DIGATTENMAX_LTE1) 
//  906 			{
//  907 				Sts->Rvs1Attn1_LTE = Sts->Rvs1AlcAttn_LTE - DIGATTENMAX_LTE1;
//  908 				Sts->Rvs1Attn2_LTE = DIGATTENMAX_LTE1;
//  909 			}
//  910 			else
//  911 			{
//  912 				Sts->Rvs1Attn1_LTE = 0;
//  913 				Sts->Rvs1Attn2_LTE = Sts->Rvs1AlcAttn_LTE;
//  914 			}
//  915 			
//  916 			Sts->Rvs1Attn3_LTE = Sts->Rvs1Attn3_LTE + Sts->Rvs1GainBalance_LTE;
//  917 
//  918 
//  919 		}
//  920 	}
//  921 	
//  922 	Sts->Fwd1Attn2_LTE = Sts->Fwd1Attn2_LTE + Sts->Fwd1GainOffset_LTE + Sts->Fwd1Temp_LTE;
??AttChange_35:
        ADDW     R7,R8,#+765
        LDRB     R0,[R7, #+1]
        LDRB     R1,[R7, #+24]
        LDRSB    R2,[R7, #+50]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R7, #+1]
//  923 	Sts->Rvs1Attn1_LTE = Sts->Rvs1Attn1_LTE + Sts->Rvs1GainOffset_LTE + Sts->Rvs1Temp_LTE;
        LDRB     R0,[R7, #+4]
        LDRB     R1,[R7, #+25]
        LDRSB    R2,[R7, #+51]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R7, #+4]
//  924 
//  925 
//  926 	Sts->Fwd1Attn1_LTE	= MinMaxAttnCheck(Sts->Fwd1Attn1_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R8, #+765]
        BL       MinMaxAttnCheck
        STRB     R0,[R8, #+765]
//  927 	Sts->Fwd1Attn2_LTE	= MinMaxAttnCheck(Sts->Fwd1Attn2_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+1]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+1]
//  928 	Sts->Rvs1Attn1_LTE	= MinMaxAttnCheck(Sts->Rvs1Attn1_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+4]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+4]
//  929 	Sts->Rvs1Attn2_LTE	= MinMaxAttnCheck(Sts->Rvs1Attn2_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+5]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+5]
//  930 	Sts->Rvs1Attn3_LTE 	= MinMaxAttnCheck(Sts->Rvs1Attn3_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+6]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+6]
//  931 	Sts->Rvs1Attn4_LTE 	= MinMaxAttnCheck(Sts->Rvs1Attn4_LTE, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+7]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+7]
//  932 
//  933 	///////////////////////// LTE-A1
//  934 
//  935 	if(Sts->AGC1OnOff_LTE_A== Enable)
        LDRB     R0,[R8, #+102]
        CMP      R0,#+0
        BNE.W    ??AttChange_36
//  936 	{
//  937 		if(Sts->Fwd1AgcAttn_LTE_A > DIGATTENMAX_LTE_A1) 
        LDRB     R0,[R7, #+29]
        CMP      R0,#+51
        BCC.N    ??AttChange_37
//  938 		{
//  939 			Sts->Fwd1Attn1_LTE_A = Sts->Fwd1AgcAttn_LTE_A - DIGATTENMAX_LTE_A1;
        SUB      R1,R0,#+50
//  940 			Sts->Fwd1Attn2_LTE_A = DIGATTENMAX_LTE_A1;
        MOVS     R2,#+50
//  941 		}
//  942 		else
//  943 		{
//  944 			Sts->Fwd1Attn1_LTE_A = 0;
//  945 			Sts->Fwd1Attn2_LTE_A = Sts->Fwd1AgcAttn_LTE_A;
//  946 		}
//  947 		
//  948 		if(Sts->Fwd1AgcAttn_LTE_A > AGCATTENMAX_LTE_A)	
        CMP      R0,#+61
        BCC.N    ??AttChange_38
//  949 		{
//  950 			Sts->Rvs1Attn3_LTE_A = Sts->Fwd1AgcAttn_LTE_A - AGCATTENMAX_LTE_A;
??AttChange_39:
        SUB      R3,R0,#+60
//  951 			Sts->Rvs1Attn4_LTE_A = AGCATTENMAX_LTE_A;
        MOVS     R0,#+60
        B.N      ??AttChange_40
//  952 		}
??AttChange_30:
        LDR.W    R0,??AttChange_0+0x4  ;; ChkAttChange
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??AttChange_35
        LDRB     R2,[R4, #+8]
        ADDW     R7,R8,#+765
        STRB     R2,[R7, #+28]
        CMP      R2,#+51
        ITTE     CS 
        SUBCS    R1,R2,#+50
        MOVCS    R2,#+50
        MOVCC    R1,#+0
        LDRB     R0,[R4, #+9]
        CMP      R0,#+61
        BCC.N    ??AttChange_32
        B.N      ??AttChange_33
??AttChange_37:
        MOVS     R1,#+0
        MOV      R2,R0
//  953 		else
//  954 		{
//  955 			Sts->Rvs1Attn3_LTE_A = 0;
??AttChange_38:
        MOVS     R3,#+0
//  956 			Sts->Rvs1Attn4_LTE_A = Sts->Fwd1AgcAttn_LTE_A;
??AttChange_40:
        STRB     R0,[R7, #+11]
        STRB     R3,[R7, #+10]
        STRB     R2,[R7, #+3]
        STRB     R1,[R7, #+2]
//  957 		}
//  958 		
//  959 		
//  960 		if(Sts->Rvs1AlcAttn_LTE_A > DIGATTENMAX_LTE_A1) 
        LDRB     R0,[R7, #+31]
        CMP      R0,#+51
        ITTE     CS 
        SUBCS    R1,R0,#+50
        MOVCS    R0,#+50
        MOVCC    R1,#+0
//  961 		{
//  962 			Sts->Rvs1Attn1_LTE_A = Sts->Rvs1AlcAttn_LTE_A - DIGATTENMAX_LTE_A1;
//  963 			Sts->Rvs1Attn2_LTE_A = DIGATTENMAX_LTE_A1;
//  964 		}
//  965 		else
//  966 		{
//  967 			Sts->Rvs1Attn1_LTE_A = 0;
//  968 			Sts->Rvs1Attn2_LTE_A = Sts->Rvs1AlcAttn_LTE_A;
        STRB     R0,[R7, #+9]
        STRB     R1,[R7, #+8]
//  969 		}
//  970 		
//  971 		Sts->Rvs1Attn3_LTE_A = Sts->Rvs1Attn3_LTE_A + Sts->Rvs1GainBalance_LTE_A;
        LDRB     R0,[R7, #+10]
        ADDW     R1,R8,#+673
        LDRB     R1,[R1, #+3]
        ADDS     R0,R1,R0
        STRB     R0,[R7, #+10]
//  972 
//  973 	}
//  974 	else
//  975 	{
//  976 		if(ChkAttChange == RESET)
//  977 		{
//  978 			Sts->Fwd1AgcAttn_LTE_A = Sts->Fwd1GainAttn_LTE_A;
//  979 			
//  980 			if(Sts->Fwd1AgcAttn_LTE_A > DIGATTENMAX_LTE_A1) 
//  981 			{
//  982 				Sts->Fwd1Attn1_LTE_A = Sts->Fwd1AgcAttn_LTE_A - DIGATTENMAX_LTE_A1;
//  983 				Sts->Fwd1Attn2_LTE_A = DIGATTENMAX_LTE_A1;
//  984 			}
//  985 			else
//  986 			{
//  987 				Sts->Fwd1Attn1_LTE_A = 0;
//  988 				Sts->Fwd1Attn2_LTE_A = Sts->Fwd1AgcAttn_LTE_A;
//  989 			}
//  990 			
//  991 			if(Sts->Rvs1GainAttn_LTE_A > AGCATTENMAX_LTE_A)	
//  992 			{
//  993 				Sts->Rvs1Attn3_LTE_A = Sts->Rvs1GainAttn_LTE_A - AGCATTENMAX_LTE_A;
//  994 				Sts->Rvs1Attn4_LTE_A = AGCATTENMAX_LTE_A;
//  995 			}
//  996 			else
//  997 			{
//  998 				Sts->Rvs1Attn3_LTE_A = 0;
//  999 				Sts->Rvs1Attn4_LTE_A = Sts->Rvs1GainAttn_LTE_A;
// 1000 			}
// 1001 			
// 1002 			
// 1003 			if(Sts->Rvs1AlcAttn_LTE_A > DIGATTENMAX_LTE_A1) 
// 1004 			{
// 1005 				Sts->Rvs1Attn1_LTE_A = Sts->Rvs1AlcAttn_LTE_A - DIGATTENMAX_LTE_A1;
// 1006 				Sts->Rvs1Attn2_LTE_A = DIGATTENMAX_LTE_A1;
// 1007 			}
// 1008 			else
// 1009 			{
// 1010 				Sts->Rvs1Attn1_LTE_A = 0;
// 1011 				Sts->Rvs1Attn2_LTE_A = Sts->Rvs1AlcAttn_LTE_A;
// 1012 			}
// 1013 			
// 1014 			Sts->Rvs1Attn3_LTE_A = Sts->Rvs1Attn3_LTE_A + Sts->Rvs1GainBalance_LTE_A;
// 1015 		}
// 1016 	}
// 1017 	
// 1018 	Sts->Fwd1Attn2_LTE_A = Sts->Fwd1Attn2_LTE_A + Sts->Fwd1GainOffset_LTE_A + Sts->Fwd1Temp_LTE_A;
??AttChange_41:
        LDRB     R0,[R7, #+3]
        LDRB     R1,[R7, #+26]
        LDRSB    R2,[R7, #+52]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R7, #+3]
// 1019 	Sts->Rvs1Attn3_LTE_A = Sts->Rvs1Attn3_LTE_A + Sts->Rvs1GainOffset_LTE_A + Sts->Rvs1Temp_LTE_A;
        LDRB     R0,[R7, #+10]
        LDRB     R1,[R7, #+27]
        LDRSB    R2,[R7, #+53]
        ADDS     R1,R2,R1
        ADDS     R0,R1,R0
        STRB     R0,[R7, #+10]
// 1020 
// 1021 	Sts->Fwd1Attn1_LTE_A	= MinMaxAttnCheck(Sts->Fwd1Attn1_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+2]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+2]
// 1022 	Sts->Fwd1Attn2_LTE_A	= MinMaxAttnCheck(Sts->Fwd1Attn2_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+3]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+3]
// 1023 	Sts->Rvs1Attn1_LTE_A	= MinMaxAttnCheck(Sts->Rvs1Attn1_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+8]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+8]
// 1024 	Sts->Rvs1Attn2_LTE_A	= MinMaxAttnCheck(Sts->Rvs1Attn2_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+9]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+9]
// 1025 	Sts->Rvs1Attn3_LTE_A 	= MinMaxAttnCheck(Sts->Rvs1Attn3_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+10]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+10]
// 1026 	Sts->Rvs1Attn4_LTE_A 	= MinMaxAttnCheck(Sts->Rvs1Attn4_LTE_A, DIGATTENMAX,ATTENMIN);
        MOVS     R2,#+0
        MOVS     R1,#+63
        LDRB     R0,[R7, #+11]
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+11]
// 1027 
// 1028 #endif  
// 1029 
// 1030 //////////////////////////////////
// 1031 #if 1
// 1032 	{
// 1033 	INT8S AttTemp = 0;
// 1034 	INT8S AccuAttTemp = 0;
        MOVS     R4,#+0
// 1035 	
// 1036 		AttTemp = Sts->FwdAttn1_2G;
        LDRSB    R0,[R8, #+162]
// 1037 #ifdef __1stType
// 1038 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn1_2G].Data[AttTemp];
        LDR.W    R9,??AttChange_0+0x8  ;; tAttAccu
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_42
        LDR.W    R1,??AttChange_0+0xC  ;; 0x800695c
        LDRSB    R4,[R0, R1]
// 1039 #else
// 1040 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn1_2G.Data[AttTemp];
// 1041 #endif
// 1042 		AttTemp = AttTemp + AccuAttTemp;
// 1043 		Sts->CurrFwdAttn1_2G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_42:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+12]
// 1044 		Sts->AttValue.FwdAttn1_2G = Sts->CurrFwdAttn1_2G;
        LDRB     R0,[R5, #+12]
        STRB     R0,[R8, #+341]
// 1045 
// 1046 		AttTemp = Sts->FwdAttn2_2G;
        LDRSB    R0,[R5, #+1]
// 1047 #ifdef __1stType
// 1048 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn2_2G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_43
        LDR.W    R1,??AttChange_0+0x10  ;; 0x800699f
        LDRSB    R4,[R0, R1]
// 1049 #else
// 1050 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn2_2G.Data[AttTemp];
// 1051 #endif
// 1052 		AttTemp = AttTemp + AccuAttTemp;
// 1053 		Sts->CurrFwdAttn2_2G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_43:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+13]
// 1054 		Sts->AttValue.FwdAttn2_2G = Sts->CurrFwdAttn2_2G;
        ADDW     R10,R8,#+341
        LDRB     R0,[R5, #+13]
        STRB     R0,[R10, #+1]
// 1055 
// 1056 
// 1057 		AttTemp = Sts->RvsAttn1_2G;
        LDRSB    R0,[R5, #+4]
// 1058 #ifdef __1stType
// 1059 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn1_2G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_44
        LDR.W    R1,??AttChange_0+0x14  ;; 0x80069e2
        LDRSB    R4,[R0, R1]
// 1060 #else
// 1061 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn1_2G.Data[AttTemp];
// 1062 #endif
// 1063 		AttTemp = AttTemp + AccuAttTemp;
// 1064 		Sts->CurrRvsAttn1_2G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_44:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+16]
// 1065 		Sts->AttValue.RvsAttn1_2G = Sts->CurrRvsAttn1_2G;
        LDRB     R0,[R5, #+16]
        STRB     R0,[R10, #+4]
// 1066 
// 1067 
// 1068 		AttTemp = Sts->RvsAttn2_2G;
        LDRSB    R0,[R5, #+5]
// 1069 #ifdef __1stType
// 1070 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn2_2G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_45
        LDR.W    R1,??AttChange_0+0x18  ;; 0x8006a25
        LDRSB    R4,[R0, R1]
// 1071 #else
// 1072 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn2_2G.Data[AttTemp];
// 1073 #endif
// 1074 		AttTemp = AttTemp + AccuAttTemp;
// 1075 		Sts->CurrRvsAttn2_2G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_45:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+17]
// 1076 		Sts->AttValue.RvsAttn2_2G = Sts->CurrRvsAttn2_2G;
        LDRB     R0,[R5, #+17]
        STRB     R0,[R10, #+5]
// 1077 
// 1078 
// 1079 		AttTemp = Sts->RvsAttn3_2G;
        LDRSB    R0,[R5, #+6]
// 1080 #ifdef __1stType
// 1081 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn3_2G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_46
        LDR.W    R1,??AttChange_0+0x1C  ;; 0x8006a68
        LDRSB    R4,[R0, R1]
// 1082 #else
// 1083 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn3_2G.Data[AttTemp];
// 1084 #endif
// 1085 		AttTemp = AttTemp + AccuAttTemp;
// 1086 		Sts->CurrRvsAttn3_2G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_46:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+18]
// 1087 		Sts->AttValue.RvsAttn3_2G = Sts->CurrRvsAttn3_2G;
        LDRB     R0,[R5, #+18]
        STRB     R0,[R10, #+6]
// 1088 		
// 1089 	///////////////////////////
// 1090 		AttTemp = Sts->FwdAttn1_LTE;
        LDRSB    R0,[R6, #+8]
// 1091 #ifdef __1stType
// 1092 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn1_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_47
        LDR.W    R1,??AttChange_0+0x20  ;; 0x8006aab
        LDRSB    R4,[R0, R1]
// 1093 #else
// 1094 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn1_LTE.Data[AttTemp];
// 1095 #endif
// 1096 		AttTemp = AttTemp + AccuAttTemp;
// 1097 		Sts->CurrFwdAttn1_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_47:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+19]
// 1098 		Sts->AttValue.FwdAttn1_LTE = Sts->CurrFwdAttn1_LTE;
        LDRB     R0,[R6, #+19]
        STRB     R0,[R10, #+9]
// 1099 
// 1100 
// 1101 		AttTemp = Sts->FwdAttn2_LTE;
        LDRSB    R0,[R6, #+9]
// 1102 #ifdef __1stType
// 1103 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn2_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_48
        LDR.W    R1,??AttChange_0+0x24  ;; 0x8006aee
        LDRSB    R4,[R0, R1]
// 1104 #else
// 1105 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn2_LTE.Data[AttTemp];
// 1106 #endif
// 1107 		AttTemp = AttTemp + AccuAttTemp;
// 1108 		Sts->CurrFwdAttn2_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_48:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+20]
// 1109 		Sts->AttValue.FwdAttn2_LTE = Sts->CurrFwdAttn2_LTE;
        LDRB     R0,[R6, #+20]
        STRB     R0,[R10, #+10]
// 1110 
// 1111 		AttTemp = Sts->RvsAttn1_LTE;
        LDRSB    R0,[R6, #+12]
// 1112 #ifdef __1stType
// 1113 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn1_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_49
        LDR.W    R1,??AttChange_0+0x28  ;; 0x8006b31
        LDRSB    R4,[R0, R1]
// 1114 #else
// 1115 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn1_LTE.Data[AttTemp];
// 1116 #endif
// 1117 		AttTemp = AttTemp + AccuAttTemp;
// 1118 		Sts->CurrRvsAttn1_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_49:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+23]
// 1119 		Sts->AttValue.RvsAttn1_LTE = Sts->CurrRvsAttn1_LTE;
        LDRB     R0,[R6, #+23]
        STRB     R0,[R10, #+13]
// 1120 
// 1121 
// 1122 		AttTemp = Sts->RvsAttn2_LTE;
        LDRSB    R0,[R6, #+13]
// 1123 #ifdef __1stType
// 1124 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn2_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_50
        LDR.W    R1,??AttChange_0+0x2C  ;; 0x8006b74
        LDRSB    R4,[R0, R1]
// 1125 #else
// 1126 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn2_LTE.Data[AttTemp];
// 1127 #endif
// 1128 		AttTemp = AttTemp + AccuAttTemp;
// 1129 		Sts->CurrRvsAttn2_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_50:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+24]
// 1130 		Sts->AttValue.RvsAttn2_LTE = Sts->CurrRvsAttn2_LTE;
        LDRB     R0,[R6, #+24]
        STRB     R0,[R10, #+14]
// 1131 
// 1132 
// 1133 		AttTemp = Sts->RvsAttn3_LTE;
        LDRSB    R0,[R6, #+14]
// 1134 #ifdef __1stType
// 1135 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn3_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_51
        LDR.W    R1,??AttChange_0+0x30  ;; 0x8006bb7
        LDRSB    R4,[R0, R1]
// 1136 #else
// 1137 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn3_LTE.Data[AttTemp];
// 1138 #endif
// 1139 		AttTemp = AttTemp + AccuAttTemp;
// 1140 		Sts->CurrRvsAttn3_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_51:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+25]
// 1141 		Sts->AttValue.RvsAttn3_LTE = Sts->CurrRvsAttn3_LTE;
        LDRB     R0,[R6, #+25]
        STRB     R0,[R10, #+15]
// 1142 		
// 1143 	//////////////////// LTE-A
// 1144 		AttTemp = Sts->FwdAttn1_LTE_A;
        LDRSB    R0,[R6, #+10]
// 1145 #ifdef __1stType
// 1146 			if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn1_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_52
        LDR.W    R1,??AttChange_0+0x34  ;; 0x8006bfa
        LDRSB    R4,[R0, R1]
// 1147 #else
// 1148 			if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn1_LTE_A.Data[AttTemp];
// 1149 #endif
// 1150 		AttTemp = AttTemp + AccuAttTemp;
// 1151 		Sts->CurrFwdAttn1_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_52:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+21]
// 1152 		Sts->AttValue.FwdAttn1_LTE_A = Sts->CurrFwdAttn1_LTE_A;
        LDRB     R0,[R6, #+21]
        STRB     R0,[R10, #+18]
// 1153 
// 1154 
// 1155 		AttTemp = Sts->FwdAttn2_LTE_A;
        LDRSB    R0,[R6, #+11]
// 1156 #ifdef __1stType
// 1157 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn2_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_53
        LDR.W    R1,??AttChange_0+0x38  ;; 0x8006c3d
        LDRSB    R4,[R0, R1]
// 1158 #else
// 1159 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn2_LTE_A.Data[AttTemp];
// 1160 #endif
// 1161 		AttTemp = AttTemp + AccuAttTemp;
// 1162 		Sts->CurrFwdAttn2_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_53:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+22]
// 1163 		Sts->AttValue.FwdAttn2_LTE_A = Sts->CurrFwdAttn2_LTE_A ;
        LDRB     R0,[R6, #+22]
        STRB     R0,[R10, #+19]
// 1164 
// 1165 
// 1166 		AttTemp = Sts->RvsAttn1_LTE_A;
        LDRSB    R0,[R6, #+15]
// 1167 #ifdef __1stType
// 1168 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn1_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_54
        LDR.W    R1,??AttChange_0+0x3C  ;; 0x8006c80
        LDRSB    R4,[R0, R1]
// 1169 #else
// 1170 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn1_LTE_A.Data[AttTemp];
// 1171 #endif
// 1172 		AttTemp = AttTemp + AccuAttTemp;
// 1173 		Sts->CurrRvsAttn1_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_54:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+26]
// 1174 		Sts->AttValue.RvsAttn1_LTE_A = Sts->CurrRvsAttn1_LTE_A;
        LDRB     R0,[R6, #+26]
        STRB     R0,[R10, #+22]
// 1175 
// 1176 
// 1177 		AttTemp = Sts->RvsAttn2_LTE_A;
        LDRSB    R0,[R6, #+16]
// 1178 #ifdef __1stType
// 1179 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn2_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_55
        LDR.W    R1,??AttChange_0+0x40  ;; 0x8006cc3
        LDRSB    R4,[R0, R1]
// 1180 #else
// 1181 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn2_LTE_A.Data[AttTemp];
// 1182 #endif
// 1183 		AttTemp = AttTemp + AccuAttTemp;
// 1184 		Sts->CurrRvsAttn2_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_55:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+27]
// 1185 		Sts->AttValue.RvsAttn2_LTE_A = Sts->CurrRvsAttn2_LTE_A;
        LDRB     R0,[R6, #+27]
        STRB     R0,[R10, #+23]
// 1186 
// 1187 
// 1188 		AttTemp = Sts->RvsAttn3_LTE_A;
        LDRSB    R0,[R6, #+17]
// 1189 #ifdef __1stType
// 1190 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn3_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_56
        LDR.W    R1,??AttChange_0+0x44  ;; 0x8006d06
        LDRSB    R4,[R0, R1]
// 1191 #else
// 1192 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn3_LTE_A.Data[AttTemp];
// 1193 #endif
// 1194 		AttTemp = AttTemp + AccuAttTemp;
// 1195 		Sts->CurrRvsAttn3_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_56:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+28]
// 1196 		Sts->AttValue.RvsAttn3_LTE_A = Sts->CurrRvsAttn3_LTE_A;
        LDRB     R0,[R6, #+28]
        STRB     R0,[R10, #+24]
// 1197 
// 1198 
// 1199 		AttTemp = Sts->RvsAttn4_LTE_A;
        LDRSB    R0,[R6, #+18]
// 1200 #ifdef __1stType
// 1201 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn4_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_57
        LDR.W    R1,??AttChange_0+0x48  ;; 0x8006d49
        LDRSB    R4,[R0, R1]
// 1202 #else
// 1203 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn4_LTE_A.Data[AttTemp];
// 1204 #endif
// 1205 		AttTemp = AttTemp + AccuAttTemp;
// 1206 		Sts->CurrRvsAttn4_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_57:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+29]
// 1207 		Sts->AttValue.RvsAttn4_LTE_A = Sts->CurrRvsAttn4_LTE_A;
        LDRB     R0,[R6, #+29]
        STRB     R0,[R10, #+25]
// 1208 
// 1209 
// 1210 	//////////////////////////////////WCDMA
// 1211 		AttTemp = Sts->FwdAttn1_3G;
        LDRSB    R0,[R5, #+2]
// 1212 #ifdef __1stType
// 1213 			if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn1_3G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_58
        LDR.W    R1,??AttChange_0+0x4C  ;; 0x8006d8c
        LDRSB    R4,[R0, R1]
// 1214 #else
// 1215 			if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn1_3G.Data[AttTemp];
// 1216 #endif
// 1217 		AttTemp = AttTemp + AccuAttTemp;
// 1218 		Sts->CurrFwdAttn1_3G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_58:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+14]
// 1219 		Sts->AttValue.FwdAttn1_3G = Sts->CurrFwdAttn1_3G;
        LDRB     R0,[R5, #+14]
        STRB     R0,[R10, #+27]
// 1220 
// 1221 
// 1222 		AttTemp = Sts->FwdAttn2_3G;
        LDRSB    R0,[R5, #+3]
// 1223 #ifdef __1stType
// 1224 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn2_3G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_59
        LDR.W    R1,??AttChange_0+0x50  ;; 0x8006dcf
        LDRSB    R4,[R0, R1]
// 1225 #else
// 1226 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn2_3G.Data[AttTemp];
// 1227 #endif
// 1228 		AttTemp = AttTemp + AccuAttTemp;
// 1229 		Sts->CurrFwdAttn2_3G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_59:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+15]
// 1230 		Sts->AttValue.FwdAttn2_3G = Sts->CurrFwdAttn2_3G;
        LDRB     R0,[R5, #+15]
        STRB     R0,[R10, #+28]
// 1231 
// 1232 		AttTemp = Sts->RvsAttn1_3G;
        LDRSB    R0,[R5, #+8]
// 1233 #ifdef __1stType
// 1234 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn1_3G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_60
        LDR.W    R1,??AttChange_0+0x54  ;; 0x8006e12
        LDRSB    R4,[R0, R1]
// 1235 #else
// 1236 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn1_3G.Data[AttTemp];
// 1237 #endif
// 1238 		AttTemp = AttTemp + AccuAttTemp;
// 1239 		Sts->CurrRvsAttn1_3G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_60:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+19]
// 1240 		Sts->AttValue.RvsAttn1_3G = Sts->CurrRvsAttn1_3G;
        LDRB     R0,[R5, #+19]
        STRB     R0,[R10, #+31]
// 1241 
// 1242 
// 1243 		AttTemp = Sts->RvsAttn2_3G;
        LDRSB    R0,[R5, #+9]
// 1244 #ifdef __1stType
// 1245 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn2_3G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_61
        LDR.N    R1,??AttChange_0+0x58  ;; 0x8006e55
        LDRSB    R4,[R0, R1]
// 1246 #else
// 1247 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn2_3G.Data[AttTemp];
// 1248 #endif
// 1249 		AttTemp = AttTemp + AccuAttTemp;
// 1250 		Sts->CurrRvsAttn2_3G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_61:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+20]
// 1251 		Sts->AttValue.RvsAttn2_3G = Sts->CurrRvsAttn2_3G;
        LDRB     R0,[R5, #+20]
        STRB     R0,[R8, #+373]
// 1252 
// 1253 		AttTemp = Sts->RvsAttn3_3G;
        LDRSB    R0,[R5, #+10]
// 1254 #ifdef __1stType
// 1255 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn3_3G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_62
        LDR.N    R1,??AttChange_0+0x5C  ;; 0x8006e98
        LDRSB    R4,[R0, R1]
// 1256 #else
// 1257 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn3_3G.Data[AttTemp];
// 1258 #endif
// 1259 		AttTemp = AttTemp + AccuAttTemp;
// 1260 		Sts->CurrRvsAttn3_3G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_62:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+21]
// 1261 		Sts->AttValue.RvsAttn3_3G = Sts->CurrRvsAttn3_3G;
        ADDW     R10,R8,#+373
        LDRB     R0,[R5, #+21]
        STRB     R0,[R10, #+1]
// 1262 
// 1263 		AttTemp = Sts->RvsAttn4_3G;
        LDRSB    R0,[R5, #+11]
// 1264 #ifdef __1stType
// 1265 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn4_3G].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_63
        LDR.N    R1,??AttChange_0+0x60  ;; 0x8006edb
        LDRSB    R4,[R0, R1]
// 1266 #else
// 1267 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn4_3G.Data[AttTemp];
// 1268 #endif
// 1269 		AttTemp = AttTemp + AccuAttTemp;
// 1270 		Sts->CurrRvsAttn4_3G = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_63:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R5, #+22]
// 1271 		Sts->AttValue.RvsAttn4_3G = Sts->CurrRvsAttn4_3G;
        LDRB     R0,[R5, #+22]
        STRB     R0,[R10, #+2]
// 1272 	//////////////////// Common
// 1273 		AttTemp = Sts->FwdAttn1_Common;
        ADD      R0,R8,#+430
        LDRSB    R0,[R0, #+0]
// 1274 #ifdef __1stType
// 1275 		if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_FwdAttn1_Common].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_64
        LDR.N    R1,??AttChange_0+0x64  ;; 0x8006f1e
        LDRSB    R4,[R0, R1]
// 1276 #else
// 1277 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->FwdAttn1_Common.Data[AttTemp];
// 1278 #endif
// 1279 		AttTemp = AttTemp + AccuAttTemp;
// 1280 		Sts->CurrFwdAttn1_Common = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_64:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+2]
// 1281 		Sts->AttValue.FwdAttn1_Common = Sts->CurrFwdAttn1_Common;
        LDRB     R0,[R6, #+2]
        STRB     R0,[R10, #+4]
// 1282 
// 1283 		AttTemp = Sts->RvsAttn1_Common;
        LDRSB    R0,[R6, #+1]
// 1284 #ifdef __1stType
// 1285 			if(tAttAccu)AccuAttTemp = vEE_TABLE1->_AttnTbl[Local_RvsAttn1_Common].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_65
        LDR.N    R1,??AttChange_0+0x68  ;; 0x8006f61
        LDRSB    R4,[R0, R1]
// 1286 #else
// 1287 			if(tAttAccu)AccuAttTemp = AttnOffsetTable->RvsAttn1_Common.Data[AttTemp];
// 1288 #endif
// 1289 		AttTemp = AttTemp + AccuAttTemp;
// 1290 		Sts->CurrRvsAttn1_Common = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_65:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R6, #+3]
// 1291 		Sts->AttValue.RvsAttn1_Common = Sts->CurrRvsAttn1_Common;
        LDRB     R0,[R6, #+3]
        STRB     R0,[R10, #+7]
// 1292 		
// 1293 //#endif	
// 1294 
// 1295 
// 1296 	//////////////////// LTE1
// 1297 		AttTemp = Sts->Fwd1Attn1_LTE;
        LDRSB    R0,[R8, #+765]
// 1298 #ifdef __1stType
// 1299 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Fwd1Attn1_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_66
        LDR.N    R1,??AttChange_0+0x6C  ;; 0x80064d4
        LDRSB    R4,[R0, R1]
// 1300 #else
// 1301 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Fwd1Attn1_LTE.Data[AttTemp];
// 1302 #endif
// 1303 		AttTemp = AttTemp + AccuAttTemp;
// 1304 		Sts->CurrFwd1Attn1_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_66:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+12]
// 1305 		Sts->Att1Value.Fwd1Attn1_LTE = Sts->CurrFwd1Attn1_LTE;
        LDRB     R0,[R7, #+12]
        STRB     R0,[R8, #+725]
// 1306 
// 1307 
// 1308 		AttTemp = Sts->Fwd1Attn2_LTE;
        LDRSB    R0,[R7, #+1]
// 1309 #ifdef __1stType
// 1310 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Fwd1Attn2_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_67
        LDR.N    R1,??AttChange_0+0x70  ;; 0x8006517
        LDRSB    R4,[R0, R1]
// 1311 #else
// 1312 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Fwd1Attn2_LTE.Data[AttTemp];
// 1313 #endif
// 1314 		AttTemp = AttTemp + AccuAttTemp;
// 1315 		Sts->CurrFwd1Attn2_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_67:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+13]
// 1316 		Sts->Att1Value.Fwd1Attn2_LTE = Sts->CurrFwd1Attn2_LTE;
        ADDW     R10,R8,#+725
        LDRB     R0,[R7, #+13]
        STRB     R0,[R10, #+1]
// 1317 
// 1318 		AttTemp = Sts->Rvs1Attn1_LTE;
        LDRSB    R0,[R7, #+4]
// 1319 #ifdef __1stType
// 1320 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn1_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_68
        LDR.N    R1,??AttChange_0+0x74  ;; 0x800655a
        LDRSB    R4,[R0, R1]
// 1321 #else
// 1322 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn1_LTE.Data[AttTemp];
// 1323 #endif
// 1324 		AttTemp = AttTemp + AccuAttTemp;
// 1325 		Sts->CurrRvs1Attn1_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_68:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+16]
// 1326 		Sts->Att1Value.Rvs1Attn1_LTE = Sts->CurrRvs1Attn1_LTE;
        LDRB     R0,[R7, #+16]
        STRB     R0,[R10, #+4]
// 1327 
// 1328 
// 1329 		AttTemp = Sts->Rvs1Attn2_LTE;
        LDRSB    R0,[R7, #+5]
// 1330 #ifdef __1stType
// 1331 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn2_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_69
        LDR.N    R1,??AttChange_0+0x78  ;; 0x800659d
        LDRSB    R4,[R0, R1]
// 1332 #else
// 1333 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn2_LTE.Data[AttTemp];
// 1334 #endif
// 1335 		AttTemp = AttTemp + AccuAttTemp;
// 1336 		Sts->CurrRvs1Attn2_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_69:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+17]
// 1337 		Sts->Att1Value.Rvs1Attn2_LTE = Sts->CurrRvs1Attn2_LTE;
        LDRB     R0,[R7, #+17]
        STRB     R0,[R10, #+5]
// 1338 
// 1339 
// 1340 		AttTemp = Sts->Rvs1Attn3_LTE;
        LDRSB    R0,[R7, #+6]
// 1341 #ifdef __1stType
// 1342 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn3_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_70
        LDR.N    R1,??AttChange_0+0x7C  ;; 0x80065e0
        LDRSB    R4,[R0, R1]
// 1343 #else
// 1344 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn3_LTE.Data[AttTemp];
// 1345 #endif
// 1346 		AttTemp = AttTemp + AccuAttTemp;
// 1347 		Sts->CurrRvs1Attn3_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_70:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+18]
// 1348 		Sts->Att1Value.Rvs1Attn3_LTE = Sts->CurrRvs1Attn3_LTE;
        LDRB     R0,[R7, #+18]
        STRB     R0,[R10, #+6]
// 1349 
// 1350 
// 1351 		AttTemp = Sts->Rvs1Attn4_LTE;
        LDRSB    R0,[R7, #+7]
// 1352 #ifdef __1stType
// 1353 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn4_LTE].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_71
        LDR.N    R1,??AttChange_0+0x80  ;; 0x8006623
        LDRSB    R4,[R0, R1]
// 1354 #else
// 1355 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn4_LTE.Data[AttTemp];
// 1356 #endif
// 1357 		AttTemp = AttTemp + AccuAttTemp;
// 1358 		Sts->CurrRvs1Attn4_LTE = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_71:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+19]
// 1359 		Sts->Att1Value.Rvs1Attn4_LTE = Sts->CurrRvs1Attn4_LTE;
        LDRB     R0,[R7, #+19]
        STRB     R0,[R10, #+7]
// 1360 
// 1361 
// 1362 	//////////////////// LTE-A1 
// 1363 		AttTemp = Sts->Fwd1Attn1_LTE_A;
        LDRSB    R0,[R7, #+2]
// 1364 #ifdef __1stType
// 1365 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Fwd1Attn1_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_72
        LDR.N    R1,??AttChange_0+0x84  ;; 0x8006666
        LDRSB    R4,[R0, R1]
// 1366 #else
// 1367 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Fwd1Attn1_LTE_A.Data[AttTemp];
// 1368 #endif
// 1369 		AttTemp = AttTemp + AccuAttTemp;
// 1370 		Sts->CurrFwd1Attn1_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_72:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+14]
// 1371 		Sts->Att1Value.Fwd1Attn1_LTE_A = Sts->CurrFwd1Attn1_LTE_A;
        LDRB     R0,[R7, #+14]
        STRB     R0,[R10, #+8]
// 1372 
// 1373 
// 1374 		AttTemp = Sts->Fwd1Attn2_LTE_A;
        LDRSB    R0,[R7, #+3]
// 1375 #ifdef __1stType
// 1376 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Fwd1Attn2_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_73
        LDR.N    R1,??AttChange_0+0x88  ;; 0x80066a9
        LDRSB    R4,[R0, R1]
// 1377 #else
// 1378 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Fwd1Attn2_LTE_A.Data[AttTemp];
// 1379 #endif
// 1380 		AttTemp = AttTemp + AccuAttTemp;
// 1381 		Sts->CurrFwd1Attn2_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_73:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+15]
// 1382 		Sts->Att1Value.Fwd1Attn2_LTE_A = Sts->CurrFwd1Attn2_LTE_A;
        LDRB     R0,[R7, #+15]
        STRB     R0,[R10, #+9]
// 1383 
// 1384 		AttTemp = Sts->Rvs1Attn1_LTE_A;
        LDRSB    R0,[R7, #+8]
// 1385 #ifdef __1stType
// 1386 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn1_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_74
        LDR.N    R1,??AttChange_0+0x8C  ;; 0x80066ec
        LDRSB    R4,[R0, R1]
// 1387 #else
// 1388 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn1_LTE_A.Data[AttTemp];
// 1389 #endif
// 1390 		AttTemp = AttTemp + AccuAttTemp;
// 1391 		Sts->CurrRvs1Attn1_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_74:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+20]
// 1392 		Sts->Att1Value.Rvs1Attn1_LTE_A = Sts->CurrRvs1Attn1_LTE_A;
        LDRB     R0,[R7, #+20]
        STRB     R0,[R10, #+12]
// 1393 
// 1394 
// 1395 		AttTemp = Sts->Rvs1Attn2_LTE_A;
        LDRSB    R0,[R7, #+9]
// 1396 #ifdef __1stType
// 1397 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn2_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_75
        LDR.N    R1,??AttChange_0+0x90  ;; 0x800672f
        LDRSB    R4,[R0, R1]
// 1398 #else
// 1399 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn2_LTE_A.Data[AttTemp];
// 1400 #endif
// 1401 		AttTemp = AttTemp + AccuAttTemp;
// 1402 		Sts->CurrRvs1Attn2_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_75:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+21]
// 1403 		Sts->Att1Value.Rvs1Attn2_LTE_A = Sts->CurrRvs1Attn2_LTE_A;
        LDRB     R0,[R7, #+21]
        STRB     R0,[R10, #+13]
// 1404 
// 1405 
// 1406 		AttTemp = Sts->Rvs1Attn3_LTE_A;
        LDRSB    R0,[R7, #+10]
// 1407 #ifdef __1stType
// 1408 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn3_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_76
        LDR.N    R1,??AttChange_0+0x94  ;; 0x8006772
        LDRSB    R4,[R0, R1]
// 1409 #else
// 1410 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn3_LTE_A.Data[AttTemp];
// 1411 #endif
// 1412 		AttTemp = AttTemp + AccuAttTemp;
// 1413 		Sts->CurrRvs1Attn3_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_76:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+22]
// 1414 		Sts->Att1Value.Rvs1Attn3_LTE_A = Sts->CurrRvs1Attn3_LTE_A;
        LDRB     R0,[R7, #+22]
        STRB     R0,[R10, #+14]
// 1415 
// 1416 
// 1417 		AttTemp = Sts->Rvs1Attn4_LTE_A;
        LDRSB    R0,[R7, #+11]
// 1418 #ifdef __1stType
// 1419 		if(tAttAccu)AccuAttTemp = vEE_BACK1->_Attn1Tbl[Local_Rvs1Attn4_LTE_A].Data[AttTemp];
        LDRB     R1,[R9, #+0]
        CBZ      R1,??AttChange_77
        LDR.N    R1,??AttChange_0+0x98  ;; 0x80067b5
        LDRSB    R4,[R0, R1]
// 1420 #else
// 1421 		if(tAttAccu)AccuAttTemp = AttnOffsetTable->Rvs1Attn4_LTE_A.Data[AttTemp];
// 1422 #endif
// 1423 		AttTemp = AttTemp + AccuAttTemp;
// 1424 		Sts->CurrRvs1Attn4_LTE_A = MinMaxAttnCheck(AttTemp, DIGATTENMAX,ATTENMIN);
??AttChange_77:
        MOVS     R2,#+0
        MOVS     R1,#+63
        ADDS     R0,R4,R0
        SXTB     R0,R0
        BL       MinMaxAttnCheck
        STRB     R0,[R7, #+23]
// 1425 		Sts->Att1Value.Rvs1Attn4_LTE_A = Sts->CurrRvs1Attn4_LTE_A;
        LDRB     R0,[R7, #+23]
        STRB     R0,[R10, #+15]
// 1426 	}
// 1427 #endif
// 1428 #if 1
// 1429 	if(tAttAccu == 0)
        LDRB     R0,[R9, #+0]
        CMP      R0,#+0
        BNE.N    ??AttChange_78
// 1430 	{
// 1431 		Sts->CurrFwdAttn1_2G = Sts->FwdAttn1_2G;
        LDRB     R0,[R8, #+162]
        STRB     R0,[R5, #+12]
// 1432 		Sts->CurrFwdAttn2_2G = Sts->FwdAttn2_2G;
        LDRB     R0,[R5, #+1]
        STRB     R0,[R5, #+13]
// 1433 		Sts->CurrRvsAttn1_2G = Sts->RvsAttn1_2G;
        LDRB     R0,[R5, #+4]
        STRB     R0,[R5, #+16]
// 1434 		Sts->CurrRvsAttn2_2G = Sts->RvsAttn2_2G;
        LDRB     R0,[R5, #+5]
        STRB     R0,[R5, #+17]
// 1435 		Sts->CurrRvsAttn3_2G = Sts->RvsAttn3_2G;
        LDRB     R0,[R5, #+6]
        STRB     R0,[R5, #+18]
// 1436 
// 1437 		Sts->CurrFwdAttn1_3G = Sts->FwdAttn1_3G;
        LDRB     R0,[R5, #+2]
        STRB     R0,[R5, #+14]
// 1438 		Sts->CurrFwdAttn2_3G = Sts->FwdAttn2_3G;
        LDRB     R0,[R5, #+3]
        STRB     R0,[R5, #+15]
// 1439 		Sts->CurrRvsAttn1_3G = Sts->RvsAttn1_3G;
        LDRB     R0,[R5, #+8]
        STRB     R0,[R5, #+19]
// 1440 		Sts->CurrRvsAttn2_3G = Sts->RvsAttn2_3G;
        LDRB     R0,[R5, #+9]
        STRB     R0,[R5, #+20]
// 1441 		Sts->CurrRvsAttn3_3G = Sts->RvsAttn3_3G;
        LDRB     R0,[R5, #+10]
        STRB     R0,[R5, #+21]
// 1442 
// 1443 		Sts->CurrFwdAttn1_LTE = Sts->FwdAttn1_LTE;
        LDRB     R0,[R6, #+8]
        STRB     R0,[R6, #+19]
// 1444 		Sts->CurrFwdAttn2_LTE = Sts->FwdAttn2_LTE;
        LDRB     R0,[R6, #+9]
        STRB     R0,[R6, #+20]
// 1445 		Sts->CurrRvsAttn1_LTE = Sts->RvsAttn1_LTE;
        LDRB     R0,[R6, #+12]
        STRB     R0,[R6, #+23]
// 1446 		Sts->CurrRvsAttn2_LTE = Sts->RvsAttn2_LTE;
        LDRB     R0,[R6, #+13]
        STRB     R0,[R6, #+24]
// 1447 		Sts->CurrRvsAttn3_LTE = Sts->RvsAttn3_LTE;
        LDRB     R0,[R6, #+14]
        STRB     R0,[R6, #+25]
// 1448 
// 1449 		Sts->CurrFwdAttn1_LTE_A = Sts->FwdAttn1_LTE_A;
        LDRB     R0,[R6, #+10]
        STRB     R0,[R6, #+21]
// 1450 		Sts->CurrFwdAttn2_LTE_A = Sts->FwdAttn2_LTE_A;
        LDRB     R0,[R6, #+11]
        STRB     R0,[R6, #+22]
// 1451 		Sts->CurrRvsAttn1_LTE_A = Sts->RvsAttn1_LTE_A;
        LDRB     R0,[R6, #+15]
        STRB     R0,[R6, #+26]
// 1452 		Sts->CurrRvsAttn2_LTE_A = Sts->RvsAttn2_LTE_A;
        LDRB     R0,[R6, #+16]
        STRB     R0,[R6, #+27]
// 1453 		Sts->CurrRvsAttn3_LTE_A = Sts->RvsAttn3_LTE_A;
        LDRB     R0,[R6, #+17]
        STRB     R0,[R6, #+28]
// 1454 		Sts->CurrRvsAttn4_LTE_A = Sts->RvsAttn4_LTE_A;
        LDRB     R0,[R6, #+18]
        STRB     R0,[R6, #+29]
// 1455 
// 1456 		Sts->CurrFwd1Attn1_LTE = Sts->Fwd1Attn1_LTE;
        LDRB     R0,[R8, #+765]
        STRB     R0,[R7, #+12]
// 1457 		Sts->CurrFwd1Attn2_LTE = Sts->Fwd1Attn2_LTE;
        LDRB     R0,[R7, #+1]
        STRB     R0,[R7, #+13]
// 1458 		Sts->CurrRvs1Attn1_LTE = Sts->Rvs1Attn1_LTE;
        LDRB     R0,[R7, #+4]
        STRB     R0,[R7, #+16]
// 1459 		Sts->CurrRvs1Attn2_LTE = Sts->Rvs1Attn2_LTE;
        LDRB     R0,[R7, #+5]
        STRB     R0,[R7, #+17]
// 1460 		Sts->CurrRvs1Attn3_LTE = Sts->Rvs1Attn3_LTE;
        LDRB     R0,[R7, #+6]
        STRB     R0,[R7, #+18]
// 1461 		Sts->CurrRvs1Attn4_LTE = Sts->Rvs1Attn4_LTE;
        LDRB     R0,[R7, #+7]
        STRB     R0,[R7, #+19]
// 1462 		
// 1463 		Sts->CurrFwd1Attn1_LTE_A = Sts->Fwd1Attn1_LTE_A;
        LDRB     R0,[R7, #+2]
        STRB     R0,[R7, #+14]
// 1464 		Sts->CurrFwd1Attn2_LTE_A = Sts->Fwd1Attn2_LTE_A;
        LDRB     R0,[R7, #+3]
        STRB     R0,[R7, #+15]
// 1465 		Sts->CurrRvs1Attn1_LTE_A = Sts->Rvs1Attn1_LTE_A;
        LDRB     R0,[R7, #+8]
        STRB     R0,[R7, #+20]
// 1466 		Sts->CurrRvs1Attn2_LTE_A = Sts->Rvs1Attn2_LTE_A;
        LDRB     R0,[R7, #+9]
        STRB     R0,[R7, #+21]
// 1467 		Sts->CurrRvs1Attn3_LTE_A = Sts->Rvs1Attn3_LTE_A;
        LDRB     R0,[R7, #+10]
        STRB     R0,[R7, #+22]
// 1468 		Sts->CurrRvs1Attn4_LTE_A = Sts->Rvs1Attn4_LTE_A;
        LDRB     R0,[R7, #+11]
        STRB     R0,[R7, #+23]
// 1469 
// 1470 		Sts->CurrFwdAttn1_Common = Sts->FwdAttn1_Common;
        ADD      R0,R8,#+430
        LDRB     R0,[R0, #+0]
        STRB     R0,[R6, #+2]
// 1471 		Sts->CurrRvsAttn1_Common = Sts->RvsAttn1_Common;
        LDRB     R0,[R6, #+1]
        STRB     R0,[R6, #+3]
// 1472 	}
// 1473 #endif
// 1474 
// 1475 }
??AttChange_78:
        POP      {R0,R4-R11,PC}   ;; return
??AttChange_36:
        LDR.N    R0,??AttChange_0+0x4  ;; ChkAttChange
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??AttChange_41
        LDRB     R2,[R4, #+10]
        STRB     R2,[R7, #+29]
        CMP      R2,#+51
        ITTE     CS 
        SUBCS    R1,R2,#+50
        MOVCS    R2,#+50
        MOVCC    R1,#+0
        LDRB     R0,[R4, #+11]
        CMP      R0,#+61
        BCC.W    ??AttChange_38
        B.N      ??AttChange_39
        Nop      
        DATA
??AttChange_0:
        DC32     tDnrSts
        DC32     ChkAttChange
        DC32     tAttAccu
        DC32     0x800695c
        DC32     0x800699f
        DC32     0x80069e2
        DC32     0x8006a25
        DC32     0x8006a68
        DC32     0x8006aab
        DC32     0x8006aee
        DC32     0x8006b31
        DC32     0x8006b74
        DC32     0x8006bb7
        DC32     0x8006bfa
        DC32     0x8006c3d
        DC32     0x8006c80
        DC32     0x8006cc3
        DC32     0x8006d06
        DC32     0x8006d49
        DC32     0x8006d8c
        DC32     0x8006dcf
        DC32     0x8006e12
        DC32     0x8006e55
        DC32     0x8006e98
        DC32     0x8006edb
        DC32     0x8006f1e
        DC32     0x8006f61
        DC32     0x80064d4
        DC32     0x8006517
        DC32     0x800655a
        DC32     0x800659d
        DC32     0x80065e0
        DC32     0x8006623
        DC32     0x8006666
        DC32     0x80066a9
        DC32     0x80066ec
        DC32     0x800672f
        DC32     0x8006772
        DC32     0x80067b5
// 1476 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1477 void StatustoIO(void)
// 1478 {
StatustoIO:
        PUSH     {R4-R8,LR}
// 1479 #if 1
// 1480 //	INT8S GainAtt = 0;
// 1481 	INT8S AttTemp = 0;
// 1482 
// 1483 //    GainAtt = GainAtt;
// 1484     AttTemp = AttTemp;
// 1485 	__Dnr_Sts  *Sts = tDnrSts;
        LDR.W    R0,??StatustoIO_0  ;; tDnrSts
        LDR      R8,[R0, #+0]
// 1486 
// 1487 /////////////////////////////////////////////////////////// 2G Fwd
// 1488 #ifdef __ATTTest
// 1489 	AttChange();
        BL       AttChange
// 1490 #endif
// 1491 
// 1492 	if(CurrFwdAttn1_2G != Sts->CurrFwdAttn1_2G)
        ADD      R5,R8,#+143
        LDRB     R0,[R5, #+31]
        LDR.W    R6,??StatustoIO_0+0x4  ;; Chk_Reset
        LDRB     R1,[R6, #+1]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_1
// 1493 	{
// 1494 		CurrFwdAttn1_2G = Sts->CurrFwdAttn1_2G;
        STRB     R0,[R6, #+1]
// 1495 		AttnDataOutput(_FwdAttn1_2G_SEL, Sts->CurrFwdAttn1_2G);
        LDRB     R1,[R5, #+31]
        MOVS     R0,#+0
        BL       AttnDataOutput
// 1496 	}
// 1497 
// 1498 	if(CurrFwdAttn2_2G != Sts->CurrFwdAttn2_2G)
??StatustoIO_1:
        LDRB     R0,[R8, #+175]
        LDRB     R1,[R6, #+2]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_2
// 1499 	{
// 1500 		CurrFwdAttn2_2G = Sts->CurrFwdAttn2_2G;
        STRB     R0,[R6, #+2]
// 1501 		AttnDataOutput(_FwdAttn2_2G_SEL, Sts->CurrFwdAttn2_2G);
        LDRB     R1,[R8, #+175]
        MOVS     R0,#+1
        BL       AttnDataOutput
// 1502 	}
// 1503 
// 1504 	if(CurrRvsAttn1_2G != Sts->CurrRvsAttn1_2G)
??StatustoIO_2:
        ADD      R7,R8,#+175
        LDRB     R0,[R7, #+3]
        LDRB     R1,[R6, #+3]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_3
// 1505 	{
// 1506 		CurrRvsAttn1_2G = Sts->CurrRvsAttn1_2G;
        STRB     R0,[R6, #+3]
// 1507 		AttnDataOutput(_RvsAttn1_2G_SEL, Sts->RvsAttn1_2G);
        LDRB     R1,[R5, #+23]
        MOVS     R0,#+2
        BL       AttnDataOutput
// 1508 	}
// 1509 
// 1510 	if(CurrRvsAttn2_2G != Sts->CurrRvsAttn2_2G)
??StatustoIO_3:
        LDRB     R0,[R7, #+4]
        LDRB     R1,[R6, #+4]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_4
// 1511 	{
// 1512 		CurrRvsAttn2_2G = Sts->CurrRvsAttn2_2G;
        STRB     R0,[R6, #+4]
// 1513 		AttnDataOutput(_RvsAttn2_2G_SEL, Sts->CurrRvsAttn2_2G);
        LDRB     R1,[R7, #+4]
        MOVS     R0,#+3
        BL       AttnDataOutput
// 1514 	}
// 1515 
// 1516 	if(CurrRvsAttn3_2G != Sts->CurrRvsAttn3_2G)
??StatustoIO_4:
        LDRB     R0,[R7, #+5]
        LDRB     R1,[R6, #+5]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_5
// 1517 	{
// 1518 		CurrRvsAttn3_2G = Sts->CurrRvsAttn3_2G;
        STRB     R0,[R6, #+5]
// 1519 		AttnDataOutput(_RvsAttn3_2G_SEL, Sts->CurrRvsAttn3_2G);
        LDRB     R1,[R7, #+5]
        MOVS     R0,#+4
        BL       AttnDataOutput
// 1520 	}
// 1521 /////////////////////////////////////////////////////////// LTE Fwd
// 1522 
// 1523 	if(CurrFwdAttn1_LTE!= Sts->CurrFwdAttn1_LTE)
??StatustoIO_5:
        ADD      R5,R8,#+432
        LDRB     R0,[R5, #+17]
        LDRB     R1,[R6, #+6]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_6
// 1524 	{
// 1525 		CurrFwdAttn1_LTE= Sts->CurrFwdAttn1_LTE;
        STRB     R0,[R6, #+6]
// 1526 		AttnDataOutput(_FwdAttn1_LTE_SEL, Sts->CurrFwdAttn1_LTE);
        LDRB     R1,[R5, #+17]
        MOVS     R0,#+5
        BL       AttnDataOutput
// 1527 	}
// 1528 
// 1529 	if(CurrFwdAttn2_LTE != Sts->CurrFwdAttn2_LTE)
??StatustoIO_6:
        LDRB     R0,[R5, #+18]
        LDRB     R1,[R6, #+7]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_7
// 1530 	{
// 1531 		CurrFwdAttn2_LTE = Sts->CurrFwdAttn2_LTE;
        STRB     R0,[R6, #+7]
// 1532 		AttnDataOutput(_FwdAttn2_LTE_SEL, Sts->CurrFwdAttn2_LTE);
        LDRB     R1,[R5, #+18]
        MOVS     R0,#+6
        BL       AttnDataOutput
// 1533 	}
// 1534 
// 1535 	if(CurrRvsAttn1_LTE != Sts->CurrRvsAttn1_LTE)
??StatustoIO_7:
        LDRB     R0,[R5, #+21]
        LDRB     R1,[R6, #+8]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_8
// 1536 	{
// 1537 		CurrRvsAttn1_LTE = Sts->CurrRvsAttn1_LTE;
        STRB     R0,[R6, #+8]
// 1538 		AttnDataOutput(_RvsAttn1_LTE_SEL, Sts->CurrRvsAttn1_LTE);
        LDRB     R1,[R5, #+21]
        MOVS     R0,#+7
        BL       AttnDataOutput
// 1539 	}
// 1540 
// 1541 	if(CurrRvsAttn2_LTE != Sts->CurrRvsAttn2_LTE)
??StatustoIO_8:
        LDRB     R0,[R5, #+22]
        LDRB     R1,[R6, #+9]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_9
// 1542 	{
// 1543 		CurrRvsAttn2_LTE = Sts->CurrRvsAttn2_LTE;
        STRB     R0,[R6, #+9]
// 1544 		AttnDataOutput(_RvsAttn2_LTE_SEL, Sts->CurrRvsAttn2_LTE);
        LDRB     R1,[R5, #+22]
        MOVS     R0,#+8
        BL       AttnDataOutput
// 1545 	}
// 1546 
// 1547 	if(CurrRvsAttn3_LTE != Sts->CurrRvsAttn3_LTE)
??StatustoIO_9:
        LDRB     R0,[R5, #+23]
        LDRB     R1,[R6, #+10]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_10
// 1548 	{
// 1549 		CurrRvsAttn3_LTE = Sts->CurrRvsAttn3_LTE;
        STRB     R0,[R6, #+10]
// 1550 		AttnDataOutput(_RvsAttn3_LTE_SEL, Sts->CurrRvsAttn3_LTE);
        LDRB     R1,[R5, #+23]
        MOVS     R0,#+9
        BL       AttnDataOutput
// 1551 	}
// 1552 /////////////////////////////////////////////////////////// LTE-A
// 1553 
// 1554 	if(CurrFwdAttn1_LTE_A!= Sts->CurrFwdAttn1_LTE_A)
??StatustoIO_10:
        LDRB     R0,[R5, #+19]
        LDRB     R1,[R6, #+11]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_11
// 1555 	{
// 1556 		CurrFwdAttn1_LTE_A = Sts->CurrFwdAttn1_LTE_A;
        STRB     R0,[R6, #+11]
// 1557 		AttnDataOutput(_FwdAttn1_LTE_A_SEL, Sts->CurrFwdAttn1_LTE_A);
        LDRB     R1,[R5, #+19]
        MOVS     R0,#+10
        BL       AttnDataOutput
// 1558 	}
// 1559 	if(CurrFwdAttn2_LTE_A != Sts->CurrFwdAttn2_LTE_A)
??StatustoIO_11:
        LDRB     R0,[R5, #+20]
        LDRB     R1,[R6, #+12]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_12
// 1560 	{
// 1561 		CurrFwdAttn2_LTE_A = Sts->CurrFwdAttn2_LTE_A;
        STRB     R0,[R6, #+12]
// 1562 		AttnDataOutput(_FwdAttn2_LTE_A_SEL, Sts->CurrFwdAttn2_LTE_A);
        LDRB     R1,[R5, #+20]
        MOVS     R0,#+11
        BL       AttnDataOutput
// 1563 	}
// 1564 	
// 1565 	if(CurrRvsAttn1_LTE_A != Sts->CurrRvsAttn1_LTE_A)
??StatustoIO_12:
        LDRB     R0,[R5, #+24]
        LDRB     R1,[R6, #+13]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_13
// 1566 	{
// 1567 		CurrRvsAttn1_LTE_A = Sts->CurrRvsAttn1_LTE_A;
        STRB     R0,[R6, #+13]
// 1568 		AttnDataOutput(_RvsAttn1_LTE_A_SEL, Sts->CurrRvsAttn1_LTE_A);
        LDRB     R1,[R5, #+24]
        MOVS     R0,#+12
        BL       AttnDataOutput
// 1569 	}
// 1570 	
// 1571 	if(CurrRvsAttn2_LTE_A != Sts->CurrRvsAttn2_LTE_A)
??StatustoIO_13:
        LDRB     R0,[R5, #+25]
        LDRB     R1,[R6, #+14]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_14
// 1572 	{
// 1573 		CurrRvsAttn2_LTE_A = Sts->CurrRvsAttn2_LTE_A;
        STRB     R0,[R6, #+14]
// 1574 		AttnDataOutput(_RvsAttn2_LTE_A_SEL, Sts->CurrRvsAttn2_LTE_A);
        LDRB     R1,[R5, #+25]
        MOVS     R0,#+13
        BL       AttnDataOutput
// 1575 	}
// 1576 
// 1577 	if(CurrRvsAttn3_LTE_A != Sts->CurrRvsAttn3_LTE_A)
??StatustoIO_14:
        LDRB     R0,[R5, #+26]
        LDRB     R1,[R6, #+15]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_15
// 1578 	{
// 1579 		CurrRvsAttn3_LTE_A = Sts->CurrRvsAttn3_LTE_A;
        STRB     R0,[R6, #+15]
// 1580 		AttnDataOutput(_RvsAttn3_LTE_A_SEL, Sts->CurrRvsAttn3_LTE_A);
        LDRB     R1,[R5, #+26]
        MOVS     R0,#+14
        BL       AttnDataOutput
// 1581 	}
// 1582 
// 1583 	if(CurrRvsAttn4_LTE_A != Sts->CurrRvsAttn4_LTE_A)
??StatustoIO_15:
        LDRB     R0,[R5, #+27]
        LDRB     R1,[R6, #+16]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_16
// 1584 	{
// 1585 		CurrRvsAttn4_LTE_A = Sts->CurrRvsAttn4_LTE_A;
        STRB     R0,[R6, #+16]
// 1586 		AttnDataOutput(_RvsAttn4_LTE_A_SEL, Sts->CurrRvsAttn4_LTE_A);
        LDRB     R1,[R5, #+27]
        MOVS     R0,#+15
        BL       AttnDataOutput
// 1587 	}
// 1588 
// 1589 	/////////////////////////////////////////////////////////// 3G
// 1590 
// 1591 	if(CurrFwdAttn1_3G!= Sts->CurrFwdAttn1_3G)
??StatustoIO_16:
        LDRB     R0,[R7, #+1]
        LDRB     R1,[R6, #+17]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_17
// 1592 	{
// 1593 		CurrFwdAttn1_3G = Sts->CurrFwdAttn1_3G;
        STRB     R0,[R6, #+17]
// 1594 		AttnDataOutput(_FwdAttn1_3G_SEL, Sts->CurrFwdAttn1_3G);
        LDRB     R1,[R7, #+1]
        MOVS     R0,#+16
        BL       AttnDataOutput
// 1595 	}
// 1596 
// 1597 	if(CurrFwdAttn2_3G != Sts->CurrFwdAttn2_3G)
??StatustoIO_17:
        LDRB     R0,[R7, #+2]
        LDRB     R1,[R6, #+18]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_18
// 1598 	{
// 1599 		CurrFwdAttn2_3G = Sts->CurrFwdAttn2_3G;
        STRB     R0,[R6, #+18]
// 1600 		AttnDataOutput(_FwdAttn2_3G_SEL, Sts->CurrFwdAttn2_3G);
        LDRB     R1,[R7, #+2]
        MOVS     R0,#+17
        BL       AttnDataOutput
// 1601 //		SerPtr->printf(" CurrFwdAttn2_3G:[%d][%x]\n",Sts->FwdAttn2_3G,AttnCS2Val.Data);
// 1602 	}
// 1603 
// 1604 	if(CurrRvsAttn1_3G != Sts->CurrRvsAttn1_3G)
??StatustoIO_18:
        LDRB     R0,[R7, #+6]
        LDRB     R1,[R6, #+19]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_19
// 1605 	{
// 1606 		CurrRvsAttn1_3G = Sts->CurrRvsAttn1_3G;
        STRB     R0,[R6, #+19]
// 1607 		AttnDataOutput(_RvsAttn1_3G_SEL, Sts->CurrRvsAttn1_3G);
        LDRB     R1,[R7, #+6]
        MOVS     R0,#+18
        BL       AttnDataOutput
// 1608 	}
// 1609 	
// 1610 	if(CurrRvsAttn2_3G != Sts->CurrRvsAttn2_3G)
??StatustoIO_19:
        LDRB     R0,[R7, #+7]
        LDRB     R1,[R6, #+20]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_20
// 1611 	{
// 1612 		CurrRvsAttn2_3G = Sts->CurrRvsAttn2_3G;
        STRB     R0,[R6, #+20]
// 1613 		AttnDataOutput(_RvsAttn2_3G_SEL, Sts->CurrRvsAttn2_3G);
        LDRB     R1,[R7, #+7]
        MOVS     R0,#+19
        BL       AttnDataOutput
// 1614 	}
// 1615 
// 1616 	if(CurrRvsAttn3_3G != Sts->CurrRvsAttn3_3G)
??StatustoIO_20:
        LDRB     R0,[R7, #+8]
        LDRB     R1,[R6, #+21]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_21
// 1617 	{
// 1618 		CurrRvsAttn3_3G = Sts->CurrRvsAttn3_3G;
        STRB     R0,[R6, #+21]
// 1619 		AttnDataOutput(_RvsAttn3_3G_SEL, Sts->CurrRvsAttn3_3G);
        LDRB     R1,[R7, #+8]
        MOVS     R0,#+20
        BL       AttnDataOutput
// 1620 	}
// 1621 
// 1622 	if(CurrRvsAttn4_3G != Sts->CurrRvsAttn4_3G)
??StatustoIO_21:
        LDRB     R0,[R7, #+9]
        LDRB     R1,[R6, #+22]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_22
// 1623 	{
// 1624 		CurrRvsAttn4_3G = Sts->CurrRvsAttn4_3G;
        STRB     R0,[R6, #+22]
// 1625 		AttnDataOutput(_RvsAttn4_3G_SEL, Sts->CurrRvsAttn4_3G);
        LDRB     R1,[R7, #+9]
        MOVS     R0,#+21
        BL       AttnDataOutput
// 1626 	}
// 1627 
// 1628 /////////////////////////////////////////////////////////// CDMA/LTE
// 1629 
// 1630 	if(CurrFwdAttn1_Common!= Sts->CurrFwdAttn1_Common)
??StatustoIO_22:
        LDRB     R0,[R8, #+432]
        LDRB     R1,[R6, #+23]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_23
// 1631 	{
// 1632 		CurrFwdAttn1_Common = Sts->CurrFwdAttn1_Common;
        STRB     R0,[R6, #+23]
// 1633 		AttnDataOutput(_FwdAttn1_Common_SEL, Sts->CurrFwdAttn1_Common);
        LDRB     R1,[R8, #+432]
        MOVS     R0,#+22
        BL       AttnDataOutput
// 1634 	}
// 1635 
// 1636 	if(CurrRvsAttn1_Common!= Sts->CurrRvsAttn1_Common)
??StatustoIO_23:
        LDRB     R0,[R5, #+1]
        LDRB     R1,[R6, #+24]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_24
// 1637 	{
// 1638 		CurrRvsAttn1_Common = Sts->CurrRvsAttn1_Common;
        STRB     R0,[R6, #+24]
// 1639 		AttnDataOutput(_RvsAttn1_Common_SEL, Sts->CurrRvsAttn1_Common);
        LDRB     R1,[R5, #+1]
        MOVS     R0,#+23
        BL       AttnDataOutput
// 1640 	}
// 1641 
// 1642 
// 1643 #ifdef _MIMO_Type
// 1644 /////////////////////////////////////////////////////////// LTE
// 1645 	if(CurrFwd1Attn1_LTE!= Sts->CurrFwd1Attn1_LTE)
??StatustoIO_24:
        ADDW     R7,R8,#+765
        LDRB     R0,[R7, #+12]
        LDRB     R1,[R6, #+25]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_25
// 1646 	{
// 1647 		CurrFwd1Attn1_LTE = Sts->CurrFwd1Attn1_LTE;
        STRB     R0,[R6, #+25]
// 1648 		AttnDataOutput(_Fwd1Attn1_LTE_SEL, Sts->Fwd1Attn1_LTE);
        LDRB     R1,[R8, #+765]
        MOVS     R0,#+24
        BL       AttnDataOutput
// 1649 //		SerPtr->printf(" CurrFwd1Attn1_LTE:[%d][%x]\n",Sts->Fwd1Attn1_LTE,AttnCS2Val.Data);
// 1650 	}
// 1651 	
// 1652 	if(CurrFwd1Attn2_LTE != Sts->CurrFwd1Attn2_LTE)
??StatustoIO_25:
        LDRB     R0,[R7, #+13]
        LDRB     R1,[R6, #+26]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_26
// 1653 	{
// 1654 		CurrFwd1Attn2_LTE = Sts->CurrFwd1Attn2_LTE;
        STRB     R0,[R6, #+26]
// 1655 		AttnDataOutput(_Fwd1Attn2_LTE_SEL, Sts->CurrFwd1Attn2_LTE);
        LDRB     R1,[R7, #+13]
        MOVS     R0,#+25
        BL       AttnDataOutput
// 1656 	}
// 1657 	
// 1658 	if(CurrRvs1Attn1_LTE != Sts->CurrRvs1Attn1_LTE)
??StatustoIO_26:
        LDRB     R0,[R7, #+16]
        LDRB     R1,[R6, #+27]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_27
// 1659 	{
// 1660 		CurrRvs1Attn1_LTE = Sts->CurrRvs1Attn1_LTE;
        STRB     R0,[R6, #+27]
// 1661 		AttnDataOutput(_Rvs1Attn1_LTE_SEL, Sts->CurrRvs1Attn1_LTE);
        LDRB     R1,[R7, #+16]
        MOVS     R0,#+26
        BL       AttnDataOutput
// 1662 	}
// 1663 	
// 1664 	if(CurrRvs1Attn2_LTE != Sts->CurrRvs1Attn2_LTE)
??StatustoIO_27:
        LDRB     R0,[R7, #+17]
        LDRB     R1,[R6, #+28]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_28
// 1665 	{
// 1666 		CurrRvs1Attn2_LTE = Sts->CurrRvs1Attn2_LTE;
        STRB     R0,[R6, #+28]
// 1667 		AttnDataOutput(_Rvs1Attn2_LTE_SEL, Sts->CurrRvs1Attn2_LTE);
        LDRB     R1,[R7, #+17]
        MOVS     R0,#+27
        BL       AttnDataOutput
// 1668 	}
// 1669 
// 1670 	if(CurrRvs1Attn3_LTE != Sts->CurrRvs1Attn3_LTE)
??StatustoIO_28:
        LDRB     R0,[R7, #+18]
        LDRB     R1,[R6, #+29]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_29
// 1671 	{
// 1672 		CurrRvs1Attn3_LTE = Sts->CurrRvs1Attn3_LTE;
        STRB     R0,[R6, #+29]
// 1673 		AttnDataOutput(_Rvs1Attn3_LTE_SEL, Sts->CurrRvs1Attn3_LTE);
        LDRB     R1,[R7, #+18]
        MOVS     R0,#+28
        BL       AttnDataOutput
// 1674 	}
// 1675 	
// 1676 	if(CurrRvs1Attn4_LTE != Sts->CurrRvs1Attn4_LTE)
??StatustoIO_29:
        LDRB     R0,[R7, #+19]
        LDRB     R1,[R6, #+30]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_30
// 1677 	{
// 1678 		CurrRvs1Attn4_LTE = Sts->CurrRvs1Attn4_LTE;
        STRB     R0,[R6, #+30]
// 1679 		AttnDataOutput(_Rvs1Attn4_LTE_SEL, Sts->CurrRvs1Attn4_LTE);
        LDRB     R1,[R7, #+19]
        MOVS     R0,#+29
        BL       AttnDataOutput
// 1680 	}
// 1681 
// 1682 /////////////////////////////////////////////////////////// LTE-A
// 1683 
// 1684 	if(CurrFwd1Attn1_LTE_A!= Sts->CurrFwd1Attn1_LTE_A)
??StatustoIO_30:
        LDRB     R0,[R7, #+14]
        LDRB     R1,[R6, #+31]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_31
// 1685 	{
// 1686 		CurrFwd1Attn1_LTE_A = Sts->CurrFwd1Attn1_LTE_A;
        STRB     R0,[R6, #+31]
// 1687 		AttnDataOutput(_Fwd1Attn1_LTE_A_SEL, Sts->CurrFwd1Attn1_LTE_A);
        LDRB     R1,[R7, #+14]
        MOVS     R0,#+30
        BL       AttnDataOutput
// 1688 	}
// 1689 
// 1690 	if(CurrFwd1Attn2_LTE_A != Sts->CurrFwd1Attn2_LTE_A)
??StatustoIO_31:
        LDRB     R0,[R7, #+15]
        LDRB     R1,[R6, #+32]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_32
// 1691 	{
// 1692 		CurrFwd1Attn2_LTE_A = Sts->CurrFwd1Attn2_LTE_A;
        STRB     R0,[R6, #+32]
// 1693 		AttnDataOutput(_Fwd1Attn2_LTE_A_SEL, Sts->CurrFwd1Attn2_LTE_A);
        LDRB     R1,[R7, #+15]
        MOVS     R0,#+31
        BL       AttnDataOutput
// 1694 	}
// 1695 
// 1696 	if(CurrRvs1Attn1_LTE_A != Sts->CurrRvs1Attn1_LTE_A)
??StatustoIO_32:
        LDRB     R0,[R7, #+20]
        ADD      R5,R6,#+32
        LDRB     R1,[R5, #+1]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_33
// 1697 	{
// 1698 		CurrRvs1Attn1_LTE_A = Sts->CurrRvs1Attn1_LTE_A;
        STRB     R0,[R5, #+1]
// 1699 		AttnDataOutput(_Rvs1Attn1_LTE_A_SEL, Sts->CurrRvs1Attn1_LTE_A);
        LDRB     R1,[R7, #+20]
        MOVS     R0,#+32
        BL       AttnDataOutput
// 1700 	}
// 1701 
// 1702 	if(CurrRvs1Attn2_LTE_A != Sts->CurrRvs1Attn2_LTE_A)
??StatustoIO_33:
        LDRB     R0,[R7, #+21]
        LDRB     R1,[R5, #+2]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_34
// 1703 	{
// 1704 		CurrRvs1Attn2_LTE_A = Sts->CurrRvs1Attn2_LTE_A;
        STRB     R0,[R5, #+2]
// 1705 		AttnDataOutput(_Rvs1Attn2_LTE_A_SEL, Sts->CurrRvs1Attn2_LTE_A);
        LDRB     R1,[R7, #+21]
        MOVS     R0,#+33
        BL       AttnDataOutput
// 1706 	}
// 1707 
// 1708 	if(CurrRvs1Attn3_LTE_A != Sts->CurrRvs1Attn3_LTE_A)
??StatustoIO_34:
        LDRB     R0,[R7, #+22]
        LDRB     R1,[R5, #+3]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_35
// 1709 	{
// 1710 		CurrRvs1Attn3_LTE_A = Sts->CurrRvs1Attn3_LTE_A;
        STRB     R0,[R5, #+3]
// 1711 		AttnDataOutput(_Rvs1Attn3_LTE_A_SEL, Sts->CurrRvs1Attn3_LTE_A);
        LDRB     R1,[R7, #+22]
        MOVS     R0,#+34
        BL       AttnDataOutput
// 1712 	}
// 1713 	
// 1714 	if(CurrRvs1Attn4_LTE_A != Sts->CurrRvs1Attn4_LTE_A)
??StatustoIO_35:
        LDRB     R0,[R7, #+23]
        LDRB     R1,[R5, #+4]
        CMP      R1,R0
        BEQ.N    ??StatustoIO_36
// 1715 	{
// 1716 		CurrRvs1Attn4_LTE_A = Sts->CurrRvs1Attn4_LTE_A;
        STRB     R0,[R5, #+4]
// 1717 		AttnDataOutput(_Rvs1Attn4_LTE_A_SEL, Sts->CurrRvs1Attn4_LTE_A);
        LDRB     R1,[R7, #+23]
        MOVS     R0,#+35
        BL       AttnDataOutput
// 1718 	}
// 1719 #endif
// 1720 ////////////////////////////////////////////////////////////////////////////////
// 1721 
// 1722 	if(Chk_Reset)
??StatustoIO_36:
        LDRB     R0,[R6, #+0]
        CBZ      R0,??StatustoIO_37
// 1723 	{
// 1724 		ResetCaseBackup(0x01);
        MOVS     R0,#+1
        BL       ResetCaseBackup
// 1725 		OSTimeDly(1000L);
        MOV      R0,#+1000
        BL       OSTimeDly
// 1726 		DownLoadBootingJump();
        BL       DownLoadBootingJump
// 1727 		Chk_Reset = RESET;
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
// 1728 	}
// 1729     
// 1730 #if 0
// 1731 	if(Chk_ShipFactorydefault)
// 1732 	{
// 1733 		DefaultValueSet();
// 1734 		OSTimeDly(1000L);
// 1735 		Chk_ShipFactorydefault = RESET;
// 1736 	}
// 1737 	else if(Chk_TestFactorydefault)
// 1738 	{
// 1739 		TestDefaultValueSet();
// 1740 		DefaultTableSet();
// 1741 		OSTimeDly(1000L);
// 1742 		Chk_TestFactorydefault = RESET;
// 1743 	}
// 1744 #endif
// 1745 	if(Sts->AmpOnOff_3G == Enable)		
??StatustoIO_37:
        LDR.N    R0,??StatustoIO_0+0x8  ;; 0x4001140c
        LDRB     R1,[R8, #+83]
        CMP      R1,#+0
        LDR      R1,[R0, #+0]
        BNE.N    ??StatustoIO_38
// 1746 	{
// 1747 		FwdAmp1OnOff_3G = 1;
        ORR      R1,R1,#0x200
        STR      R1,[R0, #+0]
// 1748 		FwdAmp2OnOff_3G = 1;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x400
        B.N      ??StatustoIO_39
// 1749 	}
// 1750 	else
// 1751 	{
// 1752 		FwdAmp1OnOff_3G = 0;
??StatustoIO_38:
        BIC      R1,R1,#0x200
        STR      R1,[R0, #+0]
// 1753 		FwdAmp2OnOff_3G = 0;
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x400
??StatustoIO_39:
        STR      R1,[R0, #+0]
// 1754 	}
// 1755 
// 1756 	if(Sts->AmpOnOff_Common == Enable)		
        ADD      R6,R8,#+83
        LDR.N    R7,??StatustoIO_0+0xC  ;; 0x4001180c
        LDRB     R1,[R6, #+1]
        CMP      R1,#+0
        LDR      R1,[R7, #+0]
        BNE.N    ??StatustoIO_40
// 1757 	{
// 1758 		FwdAmpOnOff_2G = 1;
        ORR      R1,R1,#0x1000
        STR      R1,[R7, #+0]
// 1759 		Fwd0AmpOnOff_LTE = 1;
        LDR      R1,[R7, #+0]
        ORR      R1,R1,#0x2000
        B.N      ??StatustoIO_41
// 1760 	}
// 1761 	else
// 1762 	{
// 1763 		FwdAmpOnOff_2G = 0;
??StatustoIO_40:
        BIC      R1,R1,#0x1000
        STR      R1,[R7, #+0]
// 1764 		Fwd0AmpOnOff_LTE = 0;
        LDR      R1,[R7, #+0]
        BIC      R1,R1,#0x2000
??StatustoIO_41:
        STR      R1,[R7, #+0]
// 1765 	}
// 1766 
// 1767 
// 1768 	if(Sts->AmpOnOff_LTE_A == Enable)
        LDR.N    R1,??StatustoIO_0+0x10  ;; 0x40010c0c
        LDRB     R2,[R6, #+2]
        CMP      R2,#+0
        LDR      R2,[R1, #+0]
        BNE.N    ??StatustoIO_42
// 1769 	{
// 1770 		Fwd0Amp1OnOff_LTE_A = 1;
        ORR      R2,R2,#0x8000
        STR      R2,[R1, #+0]
// 1771 		Fwd0Amp2OnOff_LTE_A = 1;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x100
        B.N      ??StatustoIO_43
// 1772 	}
// 1773 	else
// 1774 	{
// 1775 		Fwd0Amp1OnOff_LTE_A = 0;
??StatustoIO_42:
        BIC      R2,R2,#0x8000
        STR      R2,[R1, #+0]
// 1776 		Fwd0Amp2OnOff_LTE_A = 0;
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x100
??StatustoIO_43:
        STR      R1,[R0, #+0]
// 1777 	}
// 1778 
// 1779 	#ifdef _MIMO_Type
// 1780 	
// 1781 	if(Sts->Amp1OnOff_LTE_A == Enable)
        LDRB     R1,[R8, #+677]
        CMP      R1,#+0
        LDR      R1,[R0, #+0]
        ITE      EQ 
        ORREQ    R1,R1,#0x2000
        BICNE    R1,R1,#0x2000
// 1782 	{
// 1783 		Fwd1AmpOnOff_LTE_A = 1;
// 1784 	}
// 1785 	else
// 1786 	{
// 1787 		Fwd1AmpOnOff_LTE_A = 0;
        STR      R1,[R0, #+0]
// 1788 	}
// 1789 	
// 1790 	if(Sts->Amp1OnOff_LTE == Enable)
        ADDW     R4,R8,#+677
        LDRB     R1,[R4, #+1]
        CMP      R1,#+0
        LDR      R1,[R0, #+0]
        BNE.N    ??StatustoIO_44
// 1791 	{
// 1792 		Fwd1Amp1OnOff_LTE = 1;
        ORR      R1,R1,#0x800
        STR      R1,[R0, #+0]
// 1793 		Fwd1Amp2OnOff_LTE = 1;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1000
        B.N      ??StatustoIO_45
// 1794 	}
// 1795 	else
// 1796 	{
// 1797 		Fwd1Amp1OnOff_LTE = 0;
??StatustoIO_44:
        BIC      R1,R1,#0x800
        STR      R1,[R0, #+0]
// 1798 		Fwd1Amp2OnOff_LTE = 0;
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x1000
??StatustoIO_45:
        STR      R1,[R0, #+0]
// 1799 	}
// 1800 
// 1801 	#endif
// 1802 
// 1803 	if( CurrBandSelect_15M != Sts->BandSelect_15M)
        LDRB     R1,[R6, #+3]
        LDRB     R0,[R5, #+5]
        CMP      R0,R1
        BEQ.N    ??StatustoIO_46
// 1804 	{
// 1805 		if(Sts->BandSelect_15M == Enable)  	PCA9555BitSet(_15M_Switch_LTE,&AttnCS0Val); 	
        LDR.N    R0,??StatustoIO_0+0x14  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R0,??StatustoIO_0+0x18  ;; LEDStatus
        CMP      R1,#+0
        ADD      R1,R0,#+12
        BNE.N    ??StatustoIO_47
        MOVS     R0,#+40
        BL       pPCA9555BitSet
        B.N      ??StatustoIO_46
// 1806 		else								PCA9555BitRst(_15M_Switch_LTE,&AttnCS0Val); 							
??StatustoIO_47:
        MOVS     R0,#+40
        BL       pPCA9555BitRst
// 1807 	}
// 1808 
// 1809 	if(Sts->ModemOnOff == Enable)	SMS_PWR = 0;
??StatustoIO_46:
        LDRB     R0,[R8, #+143]
        CMP      R0,#+0
        LDR      R0,[R7, #+0]
        ITE      EQ 
        BICEQ    R0,R0,#0x800
        ORRNE    R0,R0,#0x800
// 1810 	else							SMS_PWR = 1;
        STR      R0,[R7, #+0]
// 1811 
// 1812 	if((Sts->ShunDown_Step_2G)&&(Sts->AmpOnOff_Common == Disable)) 		TotalAlarm_Common = SET;
        LDRB     R0,[R8, #+864]
        CBZ      R0,??StatustoIO_48
        LDRB     R0,[R6, #+1]
        CMP      R0,#+1
        BEQ.N    ??StatustoIO_49
// 1813 	else 																TotalAlarm_Common = RESET;
??StatustoIO_48:
        MOVS     R0,#+0
??StatustoIO_49:
        STRH     R0,[R5, #+6]
// 1814 
// 1815 
// 1816 	if((Sts->ShunDown_Step_3G)&&(Sts->AmpOnOff_3G == Disable)) 			TotalAlarm_3G = SET;
        ADD      R0,R8,#+864
        LDRB     R1,[R0, #+1]
        CBZ      R1,??StatustoIO_50
        LDRB     R1,[R8, #+83]
        CMP      R1,#+1
        BEQ.N    ??StatustoIO_51
// 1817 	else 																TotalAlarm_3G = RESET;
??StatustoIO_50:
        MOVS     R1,#+0
??StatustoIO_51:
        STRH     R1,[R5, #+10]
// 1818 
// 1819 	if((Sts->ShunDown_Step_LTE_A)&&(Sts->AmpOnOff_LTE_A == Disable))	TotalAlarm_LTE_A = SET;
        LDRB     R1,[R0, #+3]
        CBZ      R1,??StatustoIO_52
        LDRB     R1,[R6, #+2]
        CMP      R1,#+1
        BEQ.N    ??StatustoIO_53
// 1820 	else																TotalAlarm_LTE_A = RESET;
??StatustoIO_52:
        MOVS     R1,#+0
??StatustoIO_53:
        STRH     R1,[R5, #+8]
// 1821 
// 1822 	if((Sts->ShunDown_Step_LTE_A1)&&(Sts->Amp1OnOff_LTE_A == Disable)) 	TotalAlarm_LTE_A1 = SET;
        LDRB     R1,[R0, #+5]
        CBZ      R1,??StatustoIO_54
        LDRB     R1,[R8, #+677]
        CMP      R1,#+1
        BEQ.N    ??StatustoIO_55
// 1823 	else																TotalAlarm_LTE_A1 = RESET;
??StatustoIO_54:
        MOVS     R1,#+0
??StatustoIO_55:
        STRH     R1,[R5, #+14]
// 1824 
// 1825 
// 1826 	if((Sts->ShunDown_Step_LTE1)&&(Sts->Amp1OnOff_LTE == Disable))		TotalAlarm_LTE1 = SET;
        LDRB     R0,[R0, #+4]
        CBZ      R0,??StatustoIO_56
        LDRB     R0,[R4, #+1]
        CMP      R0,#+1
        BEQ.N    ??StatustoIO_57
// 1827 	else																TotalAlarm_LTE1 = RESET;
??StatustoIO_56:
        MOVS     R0,#+0
??StatustoIO_57:
        STRH     R0,[R5, #+12]
// 1828 
// 1829 
// 1830 	if(TotalAlarm_Common)	
        LDR.N    R0,??StatustoIO_0+0x18  ;; LEDStatus
        LDRH     R1,[R5, #+6]
        CBZ      R1,??StatustoIO_58
// 1831 	{
// 1832 		FrontLEDSet(LED_SUMSel_2G, LEDAlmON);
        MOVS     R1,#+2
        STRB     R1,[R0, #+0]
// 1833 		FrontLEDSet(LED_SUMSel_LTE, LEDAlmON);
        B.N      ??StatustoIO_59
// 1834 	}
// 1835 	else				
// 1836 	{
// 1837 		if(LowPwrAlarm_2G)
??StatustoIO_58:
        LDRH     R1,[R5, #+16]
        CBZ      R1,??StatustoIO_60
// 1838 		{
// 1839 			FrontLEDSet(LED_SUMSel_2G, LEDAllON);
        MOVS     R1,#+5
// 1840 		}
// 1841 		else
// 1842 		{
// 1843 			FrontLEDSet(LED_SUMSel_2G, LEDNorON);
??StatustoIO_60:
        STRB     R1,[R0, #+0]
// 1844 		}
// 1845 
// 1846 		if(LowPwrAlarm_LTE)
        LDRH     R1,[R5, #+20]
        CBZ      R1,??StatustoIO_59
// 1847 		{
// 1848 			FrontLEDSet(LED_SUMSel_LTE, LEDAllON);
        MOVS     R1,#+5
// 1849 		}
// 1850 		else
// 1851 		{
// 1852 			FrontLEDSet(LED_SUMSel_LTE, LEDNorON);
??StatustoIO_59:
        STRB     R1,[R0, #+2]
// 1853 		}
// 1854 
// 1855 	}
// 1856 
// 1857 	if(TotalAlarm_LTE_A)	
        LDRH     R1,[R5, #+8]
        CBZ      R1,??StatustoIO_61
// 1858 	{
// 1859 		FrontLEDSet(LED_SUMSel_LTE_A, LEDAlmON);
        MOVS     R1,#+2
        B.N      ??StatustoIO_62
// 1860 	}
// 1861 	else					
// 1862 	{
// 1863 		if(LowPwrAlarm_LTE_A)
??StatustoIO_61:
        LDRH     R1,[R5, #+22]
        CBZ      R1,??StatustoIO_62
// 1864 		{
// 1865 			FrontLEDSet(LED_SUMSel_LTE_A, LEDAllON);
        MOVS     R1,#+5
// 1866 		}
// 1867 		else
// 1868 		{
// 1869 			FrontLEDSet(LED_SUMSel_LTE_A, LEDNorON);
??StatustoIO_62:
        STRB     R1,[R0, #+3]
// 1870 		}
// 1871 	}
// 1872 
// 1873 	if(TotalAlarm_3G)	
        LDRH     R1,[R5, #+10]
        CBZ      R1,??StatustoIO_63
// 1874 	{
// 1875 		FrontLEDSet(LED_SUMSel_3G, LEDAlmON);
        MOVS     R1,#+2
        B.N      ??StatustoIO_64
// 1876 	}
// 1877 	else					
// 1878 	{
// 1879 		if(LowPwrAlarm_3G)
??StatustoIO_63:
        LDRH     R1,[R5, #+18]
        CBZ      R1,??StatustoIO_64
// 1880 		{
// 1881 			FrontLEDSet(LED_SUMSel_3G, LEDAllON);
        MOVS     R1,#+5
// 1882 		}
// 1883 		else
// 1884 		{
// 1885 			FrontLEDSet(LED_SUMSel_3G, LEDNorON);
??StatustoIO_64:
        STRB     R1,[R0, #+1]
// 1886 		}
// 1887 	}
// 1888 
// 1889 	if(TotalAlarm_LTE_A1)	
        LDRH     R1,[R5, #+14]
        CBZ      R1,??StatustoIO_65
// 1890 	{
// 1891 		FrontLEDSet(LED_SUMSel_LTE_A1, LEDAlmON);
        MOVS     R1,#+2
        B.N      ??StatustoIO_66
// 1892 	}
// 1893 	else					
// 1894 	{
// 1895 		if(LowPwrAlarm_LTE_A1)
??StatustoIO_65:
        LDRH     R1,[R5, #+26]
        CBZ      R1,??StatustoIO_66
// 1896 		{
// 1897 			FrontLEDSet(LED_SUMSel_LTE_A1, LEDAllON);
        MOVS     R1,#+5
// 1898 		}
// 1899 		else
// 1900 		{
// 1901 			FrontLEDSet(LED_SUMSel_LTE_A1, LEDNorON);
??StatustoIO_66:
        STRB     R1,[R0, #+5]
// 1902 		}
// 1903 	}
// 1904 
// 1905 	if(TotalAlarm_LTE1)	
        LDRH     R1,[R5, #+12]
        CBZ      R1,??StatustoIO_67
// 1906 	{
// 1907 		FrontLEDSet(LED_SUMSel_LTE1, LEDAlmON);
        MOVS     R1,#+2
        B.N      ??StatustoIO_68
// 1908 	}
// 1909 	else					
// 1910 	{
// 1911 		if(LowPwrAlarm_LTE1)
??StatustoIO_67:
        LDRH     R1,[R5, #+24]
        CBZ      R1,??StatustoIO_68
// 1912 		{
// 1913 			FrontLEDSet(LED_SUMSel_LTE1, LEDAllON);
        MOVS     R1,#+5
// 1914 		}
// 1915 		else
// 1916 		{
// 1917 			FrontLEDSet(LED_SUMSel_LTE1, LEDNorON);
??StatustoIO_68:
        STRB     R1,[R0, #+4]
// 1918 		}
// 1919 	}
// 1920 
// 1921 #endif
// 1922 }
        POP      {R4-R8,PC}       ;; return
        DATA
??StatustoIO_0:
        DC32     tDnrSts
        DC32     Chk_Reset
        DC32     0x4001140c
        DC32     0x4001180c
        DC32     0x40010c0c
        DC32     pPCA9555Str
        DC32     LEDStatus
// 1923 
// 1924 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1925 void AttnDataOutput(unsigned short int Sel, unsigned char Data)
// 1926 {
AttnDataOutput:
        PUSH     {R3-R7,LR}
        MOV      R4,R0
// 1927 	INT8U i = 0;
// 1928 
// 1929 	Data = (~Data )& 0x3f;
        MVNS     R0,R1
        AND      R5,R0,#0x3F
// 1930 //	Data = Data & 0x3f;
// 1931 
// 1932 
// 1933 	_ATTN_DATA = 0;
        LDR.W    R6,??AttnDataOutput_2  ;; 0x4001180c
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x80
        STR      R0,[R6, #+0]
// 1934 	_ATTN_CLK = 0;
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x100
        STR      R0,[R6, #+0]
// 1935 	
// 1936 	for(i = 0; i < 6; i++)
        MOVS     R7,#+6
// 1937 	{
// 1938 		if (Data & 0x20)		_ATTN_DATA = 1;
??AttnDataOutput_3:
        TST      R5,#0x20
        LDR      R0,[R6, #+0]
        ITE      NE 
        ORRNE    R0,R0,#0x80
        BICEQ    R0,R0,#0x80
// 1939 		else					_ATTN_DATA = 0;
        STR      R0,[R6, #+0]
// 1940 		
// 1941 		Data = Data << 1;
        LSLS     R5,R5,#+1
// 1942 		ForDelay(50L);
        MOVS     R0,#+50
        BL       ForDelay
// 1943 		_ATTN_CLK = 1;
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x100
        STR      R0,[R6, #+0]
// 1944 		ForDelay(50L);
        MOVS     R0,#+50
        BL       ForDelay
// 1945 		_ATTN_CLK = 0;
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x100
        STR      R0,[R6, #+0]
// 1946 	}
        SUBS     R7,R7,#+1
        BNE.N    ??AttnDataOutput_3
// 1947 
// 1948 	_ATTN_DATA = 0;	///////
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x80
        STR      R0,[R6, #+0]
// 1949 	
// 1950 	if(iRepeaterType == _TRIO_M)
        LDR.W    R0,??AttnDataOutput_2+0x4  ;; iRepeaterType
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.W    ??AttnDataOutput_4
// 1951 	{
// 1952 		switch(Sel)
        CMP      R4,#+23
        BHI.W    ??AttnDataOutput_5
        TBB      [PC, R4]
        DATA
??AttnDataOutput_0:
        DC8      +12,+19,+26,+33
        DC8      +40,+47,+54,+61
        DC8      +68,+75,+82,+89
        DC8      +96,+103,+110,+117
        DC8      +124,+131,+138,+145
        DC8      +152,+159,+166,+173
        THUMB
// 1953 		{
// 1954 			case _FwdAttn1_2G_SEL:			PCA9555BitSet(Fwd_Agc_Att2_2G,&AttnCS1Val); 		break;
??AttnDataOutput_6:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+65
        B.N      ??AttnDataOutput_7
// 1955 			case _FwdAttn2_2G_SEL:			PCA9555BitSet(Fwd_Agc_Att3_2G,&AttnCS1Val); 		break;
??AttnDataOutput_8:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+73
        B.N      ??AttnDataOutput_7
// 1956 			case _RvsAttn1_2G_SEL:			PCA9555BitSet(Rvs_Alc_Att2_2G,&AttnCS1Val); 		break;
??AttnDataOutput_9:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+105
        B.N      ??AttnDataOutput_7
// 1957 			case _RvsAttn2_2G_SEL:			PCA9555BitSet(Rvs_Agc_Att3_2G,&AttnCS0Val); 		break;
??AttnDataOutput_10:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+104
        B.N      ??AttnDataOutput_7
// 1958 			case _RvsAttn3_2G_SEL:			PCA9555BitSet(Rvs_Agc_Att4_2G,&AttnCS0Val); 		break;
??AttnDataOutput_11:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+112
        B.N      ??AttnDataOutput_7
// 1959 			
// 1960 			case _FwdAttn1_LTE_SEL: 		PCA9555BitSet(Fwd0_Agc_Att2_LTE,&AttnCS1Val);	break;
??AttnDataOutput_12:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+81
        B.N      ??AttnDataOutput_7
// 1961 			case _FwdAttn2_LTE_SEL: 		PCA9555BitSet(Fwd0_Agc_Att3_LTE,&AttnCS1Val);	break;
??AttnDataOutput_13:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+89
        B.N      ??AttnDataOutput_7
// 1962 			case _RvsAttn1_LTE_SEL: 		PCA9555BitSet(Rvs0_Alc_Att2_LTE,&AttnCS1Val);		break;
??AttnDataOutput_14:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+113
        B.N      ??AttnDataOutput_7
// 1963 			case _RvsAttn2_LTE_SEL: 		PCA9555BitSet(Rvs_Agc_Att3_LTE,&AttnCS0Val);		break;
??AttnDataOutput_15:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+120
        B.N      ??AttnDataOutput_7
// 1964 			case _RvsAttn3_LTE_SEL: 		PCA9555BitSet(Rvs_Agc_Att4_LTE,&AttnCS0Val);		break;
??AttnDataOutput_16:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+0
        B.N      ??AttnDataOutput_7
// 1965 
// 1966 
// 1967 			case _FwdAttn1_LTE_A_SEL:		PCA9555BitSet(Fwd0_Agc_Att1_LTE_A,&AttnCS0Val); 	break;
??AttnDataOutput_17:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+88
        B.N      ??AttnDataOutput_7
// 1968 			case _FwdAttn2_LTE_A_SEL:		PCA9555BitSet(Fwd0_Agc_Att2_LTE_A,&AttnCS0Val); 	break;
??AttnDataOutput_18:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+96
        B.N      ??AttnDataOutput_7
// 1969 			case _RvsAttn1_LTE_A_SEL:		PCA9555BitSet(Rvs0_Alc_Att1_LTE_A,&AttnCS1Val); 	break;
??AttnDataOutput_19:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+121
        B.N      ??AttnDataOutput_7
// 1970 			case _RvsAttn2_LTE_A_SEL:		PCA9555BitSet(Rvs0_Alc_Att2_LTE_A,&AttnCS1Val); 	break;
??AttnDataOutput_20:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+1
        B.N      ??AttnDataOutput_7
// 1971 			case _RvsAttn3_LTE_A_SEL:		PCA9555BitSet(Rvs_Agc_Att3_LTE_A,&AttnCS0Val);	break;
??AttnDataOutput_21:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+8
        B.N      ??AttnDataOutput_7
// 1972 			case _RvsAttn4_LTE_A_SEL:		PCA9555BitSet(Rvs_Agc_Att4_LTE_A,&AttnCS0Val);	break;
??AttnDataOutput_22:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+16
        B.N      ??AttnDataOutput_7
// 1973 
// 1974 			case _FwdAttn1_3G_SEL:			PCA9555BitSet(Fwd_Agc_Att1_3G,&AttnCS0Val); 		break;
??AttnDataOutput_23:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+72
        B.N      ??AttnDataOutput_7
// 1975 			case _FwdAttn2_3G_SEL:			PCA9555BitSet(Fwd_Agc_Att2_3G,&AttnCS0Val); 		break;
??AttnDataOutput_24:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+80
        B.N      ??AttnDataOutput_7
// 1976 			case _RvsAttn1_3G_SEL:			PCA9555BitSet(Rvs_Alc_Att1_3G,&AttnCS1Val); 		break;
??AttnDataOutput_25:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+9
        B.N      ??AttnDataOutput_7
// 1977 			case _RvsAttn2_3G_SEL:			PCA9555BitSet(Rvs_Alc_Att2_3G,&AttnCS1Val); 		break;
??AttnDataOutput_26:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+17
        B.N      ??AttnDataOutput_7
// 1978 			case _RvsAttn3_3G_SEL:			PCA9555BitSet(Rvs_Agc_Att3_3G,&AttnCS0Val); 		break;
??AttnDataOutput_27:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+24
        B.N      ??AttnDataOutput_7
// 1979 			case _RvsAttn4_3G_SEL:			PCA9555BitSet(Rvs_Agc_Att4_3G,&AttnCS0Val); 		break;
??AttnDataOutput_28:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+32
        B.N      ??AttnDataOutput_7
// 1980 			
// 1981 			case _FwdAttn1_Common_SEL:		PCA9555BitSet(Fwd_Alc_Att1_Common,&AttnCS0Val); 	break;
??AttnDataOutput_29:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+64
        B.N      ??AttnDataOutput_7
// 1982 			case _RvsAttn1_Common_SEL:		PCA9555BitSet(Rvs_Alc_Att1_Common,&AttnCS1Val); 	break;
??AttnDataOutput_30:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+97
??AttnDataOutput_7:
        BL       pPCA9555BitSet
// 1983 		}
// 1984 
// 1985 		ForDelay(100L);
??AttnDataOutput_5:
        MOVS     R0,#+100
        BL       ForDelay
// 1986 
// 1987 		PCA9555BitRst(Fwd_Agc_Att2_2G,&AttnCS1Val); 		
        LDR.W    R4,??AttnDataOutput_2+0x14  ;; LEDStatus
        LDR.W    R5,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+65
        BL       pPCA9555BitRst
// 1988 		PCA9555BitRst(Fwd_Agc_Att3_2G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+73
        BL       pPCA9555BitRst
// 1989 		PCA9555BitRst(Rvs_Alc_Att2_2G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+105
        BL       pPCA9555BitRst
// 1990 		PCA9555BitRst(Rvs_Agc_Att3_2G,&AttnCS0Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+104
        BL       pPCA9555BitRst
// 1991 		PCA9555BitRst(Rvs_Agc_Att4_2G,&AttnCS0Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+112
        BL       pPCA9555BitRst
// 1992 
// 1993 		PCA9555BitRst(Fwd0_Agc_Att2_LTE,&AttnCS1Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+81
        BL       pPCA9555BitRst
// 1994 		PCA9555BitRst(Fwd0_Agc_Att3_LTE,&AttnCS1Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+89
        BL       pPCA9555BitRst
// 1995 
// 1996 		PCA9555BitRst(Rvs0_Alc_Att2_LTE,&AttnCS1Val);		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+113
        BL       pPCA9555BitRst
// 1997 		PCA9555BitRst(Rvs_Agc_Att3_LTE,&AttnCS0Val);		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+120
        BL       pPCA9555BitRst
// 1998 		PCA9555BitRst(Rvs_Agc_Att4_LTE,&AttnCS0Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+0
        BL       pPCA9555BitRst
// 1999 
// 2000 		PCA9555BitRst(Fwd0_Agc_Att1_LTE_A,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+88
        BL       pPCA9555BitRst
// 2001 		PCA9555BitRst(Fwd0_Agc_Att2_LTE_A,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+96
        BL       pPCA9555BitRst
// 2002 		PCA9555BitRst(Rvs0_Alc_Att1_LTE_A,&AttnCS1Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+121
        BL       pPCA9555BitRst
// 2003 		PCA9555BitRst(Rvs0_Alc_Att2_LTE_A,&AttnCS1Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+1
        BL       pPCA9555BitRst
// 2004 		PCA9555BitRst(Rvs_Agc_Att3_LTE_A,&AttnCS0Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+8
        BL       pPCA9555BitRst
// 2005 		PCA9555BitRst(Rvs_Agc_Att4_LTE_A,&AttnCS0Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+16
        BL       pPCA9555BitRst
// 2006 
// 2007 		PCA9555BitRst(Fwd_Agc_Att1_3G,&AttnCS0Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+72
        BL       pPCA9555BitRst
// 2008 		PCA9555BitRst(Fwd_Agc_Att2_3G,&AttnCS0Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+80
        BL       pPCA9555BitRst
// 2009 		PCA9555BitRst(Rvs_Alc_Att1_3G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+9
        BL       pPCA9555BitRst
// 2010 		PCA9555BitRst(Rvs_Alc_Att2_3G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+17
        BL       pPCA9555BitRst
// 2011 		PCA9555BitRst(Rvs_Agc_Att3_3G,&AttnCS0Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+24
        BL       pPCA9555BitRst
// 2012 		PCA9555BitRst(Rvs_Agc_Att4_3G,&AttnCS0Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+32
        BL       pPCA9555BitRst
// 2013 
// 2014 		PCA9555BitRst(Fwd_Alc_Att1_Common,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+64
        BL       pPCA9555BitRst
// 2015 		PCA9555BitRst(Rvs_Alc_Att1_Common,&AttnCS1Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+97
        B.N      ??AttnDataOutput_31
// 2016 	}
// 2017 	else
// 2018 	{
// 2019 		switch(Sel)
??AttnDataOutput_4:
        CMP      R4,#+35
        BHI.W    ??AttnDataOutput_32
        TBB      [PC, R4]
        DATA
??AttnDataOutput_1:
        DC8      +18,+25,+32,+38
        DC8      +43,+48,+53,+58
        DC8      +63,+68,+73,+78
        DC8      +83,+88,+93,+98
        DC8      +103,+108,+113,+118
        DC8      +123,+128,+133,+138
        DC8      +143,+148,+153,+158
        DC8      +163,+168,+173,+178
        DC8      +183,+188,+193,+198
        THUMB
// 2020 		{
// 2021 			case _FwdAttn1_2G_SEL:			PCA9555BitSet(Fwd_Agc_Att2_2G,&AttnCS1Val); 		break;
??AttnDataOutput_33:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+65
        B.N      ??AttnDataOutput_34
// 2022 			case _FwdAttn2_2G_SEL:			PCA9555BitSet(Fwd_Agc_Att3_2G,&AttnCS1Val); 		break;
??AttnDataOutput_35:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.W    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+73
        B.N      ??AttnDataOutput_34
// 2023 			case _RvsAttn1_2G_SEL:			PCA9555BitSet(Rvs_Alc_Att2_2G,&AttnCS1Val); 		break;
??AttnDataOutput_36:
        LDR.W    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+105
        B.N      ??AttnDataOutput_34
// 2024 			case _RvsAttn2_2G_SEL:			PCA9555BitSet(MM_Rvs_Agc_Att3_2G,&AttnCS1Val); 		break;
??AttnDataOutput_37:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+33
        B.N      ??AttnDataOutput_34
// 2025 			case _RvsAttn3_2G_SEL:			PCA9555BitSet(MM_Rvs_Agc_Att4_2G,&AttnCS1Val); 		break;
??AttnDataOutput_38:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+41
        B.N      ??AttnDataOutput_34
// 2026 			
// 2027 			case _FwdAttn1_LTE_SEL: 		PCA9555BitSet(Fwd0_Agc_Att2_LTE,&AttnCS1Val);		break;
??AttnDataOutput_39:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+81
        B.N      ??AttnDataOutput_34
// 2028 			case _FwdAttn2_LTE_SEL: 		PCA9555BitSet(Fwd0_Agc_Att3_LTE,&AttnCS1Val);		break;
??AttnDataOutput_40:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+89
        B.N      ??AttnDataOutput_34
// 2029 			case _RvsAttn1_LTE_SEL: 		PCA9555BitSet(Rvs0_Alc_Att2_LTE,&AttnCS1Val);		break;
??AttnDataOutput_41:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+113
        B.N      ??AttnDataOutput_34
// 2030 			case _RvsAttn2_LTE_SEL: 		PCA9555BitSet(MM_Rvs_Agc_Att3_LTE,&AttnCS1Val);		break;
??AttnDataOutput_42:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+49
        B.N      ??AttnDataOutput_34
// 2031 			case _RvsAttn3_LTE_SEL: 		PCA9555BitSet(MM_Rvs_Agc_Att4_LTE,&AttnCS1Val);		break;
??AttnDataOutput_43:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+57
        B.N      ??AttnDataOutput_34
// 2032 	
// 2033 	
// 2034 			case _FwdAttn1_LTE_A_SEL:		PCA9555BitSet(Fwd0_Agc_Att1_LTE_A,&AttnCS0Val); 	break;
??AttnDataOutput_44:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+88
        B.N      ??AttnDataOutput_34
// 2035 			case _FwdAttn2_LTE_A_SEL:		PCA9555BitSet(Fwd0_Agc_Att2_LTE_A,&AttnCS0Val); 	break;
??AttnDataOutput_45:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+96
        B.N      ??AttnDataOutput_34
// 2036 			case _RvsAttn1_LTE_A_SEL:		PCA9555BitSet(Rvs0_Alc_Att1_LTE_A,&AttnCS1Val); 	break;
??AttnDataOutput_46:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+121
        B.N      ??AttnDataOutput_34
// 2037 			case _RvsAttn2_LTE_A_SEL:		PCA9555BitSet(Rvs0_Alc_Att2_LTE_A,&AttnCS1Val); 	break;
??AttnDataOutput_47:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+1
        B.N      ??AttnDataOutput_34
// 2038 			case _RvsAttn3_LTE_A_SEL:		PCA9555BitSet(Rvs_Agc_Att3_LTE_A,&AttnCS0Val);		break;
??AttnDataOutput_48:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+8
        B.N      ??AttnDataOutput_34
// 2039 			case _RvsAttn4_LTE_A_SEL:		PCA9555BitSet(Rvs_Agc_Att4_LTE_A,&AttnCS0Val);		break;
??AttnDataOutput_49:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+16
        B.N      ??AttnDataOutput_34
// 2040 	
// 2041 			case _FwdAttn1_3G_SEL:			PCA9555BitSet(Fwd_Agc_Att1_3G,&AttnCS0Val); 		break;
??AttnDataOutput_50:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+72
        B.N      ??AttnDataOutput_34
// 2042 			case _FwdAttn2_3G_SEL:			PCA9555BitSet(Fwd_Agc_Att2_3G,&AttnCS0Val); 		break;///xxxxxxxxx
??AttnDataOutput_51:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+80
        B.N      ??AttnDataOutput_34
// 2043 			case _RvsAttn1_3G_SEL:			PCA9555BitSet(Rvs_Alc_Att1_3G,&AttnCS1Val); 		break;
??AttnDataOutput_52:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+9
        B.N      ??AttnDataOutput_34
// 2044 			case _RvsAttn2_3G_SEL:			PCA9555BitSet(Rvs_Alc_Att2_3G,&AttnCS1Val); 		break;
??AttnDataOutput_53:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+17
        B.N      ??AttnDataOutput_34
// 2045 			case _RvsAttn3_3G_SEL:			PCA9555BitSet(Rvs_Agc_Att3_3G,&AttnCS0Val); 		break;
??AttnDataOutput_54:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+24
        B.N      ??AttnDataOutput_34
// 2046 			case _RvsAttn4_3G_SEL:			PCA9555BitSet(Rvs_Agc_Att4_3G,&AttnCS0Val); 		break;
??AttnDataOutput_55:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+32
        B.N      ??AttnDataOutput_34
// 2047 			
// 2048 			case _FwdAttn1_Common_SEL:		PCA9555BitSet(Fwd_Alc_Att1_Common,&AttnCS0Val); 	break;
??AttnDataOutput_56:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+64
        B.N      ??AttnDataOutput_34
// 2049 			case _RvsAttn1_Common_SEL:		PCA9555BitSet(Rvs_Alc_Att1_Common,&AttnCS1Val); 	break;
??AttnDataOutput_57:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0xC  ;; LEDStatus + 16
        MOVS     R0,#+97
        B.N      ??AttnDataOutput_34
// 2050 
// 2051 			case _Fwd1Attn1_LTE_SEL:		PCA9555BitSet(MM_Fwd1_Agc_Att1_LTE,&AttnCS2Val);	break;
??AttnDataOutput_58:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+66
        B.N      ??AttnDataOutput_34
// 2052 			case _Fwd1Attn2_LTE_SEL:		PCA9555BitSet(MM_Fwd1_Agc_Att2_LTE,&AttnCS2Val);	break;
??AttnDataOutput_59:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+74
        B.N      ??AttnDataOutput_34
// 2053 			case _Rvs1Attn1_LTE_SEL:		PCA9555BitSet(MM_Rvs1_Alc_Att1_LTE,&AttnCS0Val);	break;
??AttnDataOutput_60:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+104
        B.N      ??AttnDataOutput_34
// 2054 			case _Rvs1Attn2_LTE_SEL:		PCA9555BitSet(MM_Rvs1_Alc_Att2_LTE,&AttnCS0Val);	break;
??AttnDataOutput_61:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x10  ;; LEDStatus + 12
        MOVS     R0,#+112
        B.N      ??AttnDataOutput_34
// 2055 			case _Rvs1Attn3_LTE_SEL:		PCA9555BitSet(MM_Rvs1_Agc_Att3_LTE,&AttnCS2Val);	break;
??AttnDataOutput_62:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+98
        B.N      ??AttnDataOutput_34
// 2056 			case _Rvs1Attn4_LTE_SEL:		PCA9555BitSet(MM_Rvs1_Agc_Att4_LTE,&AttnCS2Val);	break;
??AttnDataOutput_63:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+106
        B.N      ??AttnDataOutput_34
// 2057 #if 1	
// 2058 			case _Fwd1Attn1_LTE_A_SEL:		PCA9555BitSet(MM_Fwd1_Agc_Att1_LTE_A,&AttnCS2Val);	break; //////확인 필요xxxxx
??AttnDataOutput_64:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+82
        B.N      ??AttnDataOutput_34
// 2059 			case _Fwd1Attn2_LTE_A_SEL:		PCA9555BitSet(MM_Fwd1_Agc_Att2_LTE_A,&AttnCS2Val); 	break;
??AttnDataOutput_65:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+90
        B.N      ??AttnDataOutput_34
// 2060 #endif
// 2061 #if 1	
// 2062 
// 2063 			case _Rvs1Attn1_LTE_A_SEL:		PCA9555BitSet(MM_Rvs1_Alc_Att1_LTE_A,&AttnCS2Val); 	break;
??AttnDataOutput_66:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+120
        B.N      ??AttnDataOutput_34
// 2064 			case _Rvs1Attn2_LTE_A_SEL:		PCA9555BitSet(MM_Rvs1_Alc_Att2_LTE_A,&AttnCS2Val); 	break;
??AttnDataOutput_67:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+0
        B.N      ??AttnDataOutput_34
// 2065 			case _Rvs1Attn3_LTE_A_SEL:		PCA9555BitSet(MM_Rvs1_Agc_Att3_LTE_A,&AttnCS2Val); 	break;
??AttnDataOutput_68:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+114
        B.N      ??AttnDataOutput_34
// 2066 			case _Rvs1Attn4_LTE_A_SEL:		PCA9555BitSet(MM_Rvs1_Agc_Att4_LTE_A,&AttnCS2Val); 	break;
??AttnDataOutput_69:
        LDR.N    R0,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R0, #+0]
        LDR.N    R1,??AttnDataOutput_2+0x18  ;; LEDStatus + 20
        MOVS     R0,#+122
??AttnDataOutput_34:
        BL       pPCA9555BitSet
// 2067 #endif			
// 2068 		}
// 2069 	
// 2070 		ForDelay(100L);
??AttnDataOutput_32:
        MOVS     R0,#+100
        BL       ForDelay
// 2071 		
// 2072 		PCA9555BitRst(Fwd_Agc_Att2_2G,&AttnCS1Val); 		
        LDR.N    R4,??AttnDataOutput_2+0x14  ;; LEDStatus
        LDR.N    R5,??AttnDataOutput_2+0x8  ;; pPCA9555Str
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+65
        BL       pPCA9555BitRst
// 2073 		PCA9555BitRst(Fwd_Agc_Att3_2G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+73
        BL       pPCA9555BitRst
// 2074 		PCA9555BitRst(Rvs_Alc_Att2_2G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+105
        BL       pPCA9555BitRst
// 2075 		PCA9555BitRst(MM_Rvs_Agc_Att3_2G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+33
        BL       pPCA9555BitRst
// 2076 		PCA9555BitRst(MM_Rvs_Agc_Att4_2G,&AttnCS1Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+41
        BL       pPCA9555BitRst
// 2077 		
// 2078 		PCA9555BitRst(Fwd0_Agc_Att2_LTE,&AttnCS1Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+81
        BL       pPCA9555BitRst
// 2079 		PCA9555BitRst(Fwd0_Agc_Att3_LTE,&AttnCS1Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+89
        BL       pPCA9555BitRst
// 2080 		
// 2081 		PCA9555BitRst(Rvs0_Alc_Att2_LTE,&AttnCS1Val);		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+113
        BL       pPCA9555BitRst
// 2082 		PCA9555BitRst(MM_Rvs_Agc_Att3_LTE,&AttnCS1Val);		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+49
        BL       pPCA9555BitRst
// 2083 		PCA9555BitRst(MM_Rvs_Agc_Att4_LTE,&AttnCS1Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+57
        BL       pPCA9555BitRst
// 2084 		
// 2085 		PCA9555BitRst(Fwd0_Agc_Att1_LTE_A,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+88
        BL       pPCA9555BitRst
// 2086 		PCA9555BitRst(Fwd0_Agc_Att2_LTE_A,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+96
        BL       pPCA9555BitRst
// 2087 		PCA9555BitRst(Rvs0_Alc_Att1_LTE_A,&AttnCS1Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+121
        BL       pPCA9555BitRst
// 2088 		PCA9555BitRst(Rvs0_Alc_Att2_LTE_A,&AttnCS1Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+1
        BL       pPCA9555BitRst
// 2089 		PCA9555BitRst(Rvs_Agc_Att3_LTE_A,&AttnCS0Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+8
        BL       pPCA9555BitRst
// 2090 		PCA9555BitRst(Rvs_Agc_Att4_LTE_A,&AttnCS0Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+16
        BL       pPCA9555BitRst
// 2091 		
// 2092 		PCA9555BitRst(Fwd_Agc_Att1_3G,&AttnCS0Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+72
        BL       pPCA9555BitRst
// 2093 		PCA9555BitRst(Fwd_Agc_Att2_3G,&AttnCS0Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+80
        BL       pPCA9555BitRst
// 2094 		PCA9555BitRst(Rvs_Alc_Att1_3G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+9
        BL       pPCA9555BitRst
// 2095 		PCA9555BitRst(Rvs_Alc_Att2_3G,&AttnCS1Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+17
        BL       pPCA9555BitRst
// 2096 		PCA9555BitRst(Rvs_Agc_Att3_3G,&AttnCS0Val); 		
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+24
        BL       pPCA9555BitRst
// 2097 		PCA9555BitRst(Rvs_Agc_Att4_3G,&AttnCS0Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+32
        BL       pPCA9555BitRst
// 2098 		
// 2099 		PCA9555BitRst(Fwd_Alc_Att1_Common,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+64
        BL       pPCA9555BitRst
// 2100 		PCA9555BitRst(Rvs_Alc_Att1_Common,&AttnCS1Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+16
        MOVS     R0,#+97
        BL       pPCA9555BitRst
// 2101 
// 2102 		PCA9555BitRst(MM_Fwd1_Agc_Att1_LTE,&AttnCS2Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+66
        BL       pPCA9555BitRst
// 2103 		PCA9555BitRst(MM_Fwd1_Agc_Att2_LTE,&AttnCS2Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+74
        BL       pPCA9555BitRst
// 2104 		PCA9555BitRst(MM_Rvs1_Alc_Att1_LTE,&AttnCS0Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+104
        BL       pPCA9555BitRst
// 2105 		PCA9555BitRst(MM_Rvs1_Alc_Att2_LTE,&AttnCS0Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+112
        BL       pPCA9555BitRst
// 2106 		PCA9555BitRst(MM_Rvs1_Agc_Att3_LTE,&AttnCS2Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+98
        BL       pPCA9555BitRst
// 2107 		PCA9555BitRst(MM_Rvs1_Agc_Att4_LTE,&AttnCS2Val);	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+106
        BL       pPCA9555BitRst
// 2108 
// 2109 #if 1
// 2110 		PCA9555BitRst(MM_Fwd1_Agc_Att1_LTE_A,&AttnCS2Val); 
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+82
        BL       pPCA9555BitRst
// 2111 		PCA9555BitRst(MM_Fwd1_Agc_Att2_LTE_A,&AttnCS2Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+90
        BL       pPCA9555BitRst
// 2112 #endif		
// 2113 #if 1		
// 2114 
// 2115 		PCA9555BitRst(MM_Rvs1_Alc_Att1_LTE_A,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+120
        BL       pPCA9555BitRst
// 2116 		PCA9555BitRst(MM_Rvs1_Alc_Att2_LTE_A,&AttnCS0Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+12
        MOVS     R0,#+0
        BL       pPCA9555BitRst
// 2117 		PCA9555BitRst(MM_Rvs1_Agc_Att3_LTE_A,&AttnCS2Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+114
        BL       pPCA9555BitRst
// 2118 		PCA9555BitRst(MM_Rvs1_Agc_Att4_LTE_A,&AttnCS2Val); 	
        LDR      R2,[R5, #+0]
        ADD      R1,R4,#+20
        MOVS     R0,#+122
??AttnDataOutput_31:
        POP      {R3-R7,LR}
        B.W      pPCA9555BitRst
        DATA
??AttnDataOutput_2:
        DC32     0x4001180c
        DC32     iRepeaterType
        DC32     pPCA9555Str
        DC32     LEDStatus + 16
        DC32     LEDStatus + 12
        DC32     LEDStatus
        DC32     LEDStatus + 20
// 2119 #endif		
// 2120 	}
// 2121 }
// 2122 
// 2123  
// 2124 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2125 void TimerRelatedOperation(void)
// 2126 {
TimerRelatedOperation:
        PUSH     {R7,LR}
// 2127 	if(TimeOverCheck(Timer_AttnOut))
        MOVS     R0,#+9
        BL       TimeOverCheck
        CBZ      R0,??TimerRelatedOperation_0
// 2128 	{
// 2129 		AttnOutBufferInit();
        BL       AttnOutBufferInit
// 2130 		
// 2131 		TimerRegist(Timer_AttnOut, Time1Sec*5L); // 500msec 뒤에 다시 Attn!!
        MOVW     R1,#+5000
        MOVS     R0,#+9
        BL       TimerRegist
// 2132 		
// 2133 		iDebugCnt = 0; 
        LDR.N    R0,??TimerRelatedOperation_1  ;; iDebugCnt
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
// 2134 	}
// 2135 }
??TimerRelatedOperation_0:
        POP      {R0,PC}          ;; return
        DATA
??TimerRelatedOperation_1:
        DC32     iDebugCnt
// 2136 
// 2137 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2138 void TypeCheck(void)
// 2139 {
// 2140  
// 2141 	__Dnr_Sts	*Sts = tDnrSts;
TypeCheck:
        LDR.N    R0,??TypeCheck_0  ;; tDnrSts
        LDR      R0,[R0, #+0]
// 2142 
// 2143 	if((RRTYPE == SET))
        LDR.N    R1,??TypeCheck_0+0x4  ;; 0x40011008
        LDR      R1,[R1, #+0]
        AND      R1,R1,#0x40
        LSRS     R1,R1,#+6
        CMP      R1,#+1
        BNE.N    ??TypeCheck_1
// 2144 	{
// 2145 		Sts->RepeaterType[0]	 = hibyte(TRIO_M_TYPE);
        MOVS     R1,#+2
        STRB     R1,[R0, #+29]
// 2146 		Sts->RepeaterType[1]	 = lobyte(TRIO_M_TYPE);
        MOVS     R1,#+90
        STRB     R1,[R0, #+30]
// 2147 
// 2148 		iRepeaterType = _TRIO_M;
        MOVS     R0,#+0
        B.N      ??TypeCheck_2
// 2149 	}
// 2150 	else 
// 2151 	{
// 2152 		Sts->RepeaterType[0]	 = hibyte(TRIO_MM_TYPE);
??TypeCheck_1:
        MOVS     R1,#+2
        STRB     R1,[R0, #+29]
// 2153 		Sts->RepeaterType[1]	 = lobyte(TRIO_MM_TYPE);
        MOVS     R1,#+92
        STRB     R1,[R0, #+30]
// 2154 
// 2155 		iRepeaterType = _TRIO_MM;
        MOVS     R0,#+1
??TypeCheck_2:
        LDR.N    R1,??TypeCheck_0+0x8  ;; iRepeaterType
        STRB     R0,[R1, #+0]
// 2156 	}	 
// 2157 }
        BX       LR               ;; return
        Nop      
        DATA
??TypeCheck_0:
        DC32     tDnrSts
        DC32     0x40011008
        DC32     iRepeaterType
// 2158 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 2159 void pPCA9555Port_Init(INT8U tIndex)
// 2160 {
pPCA9555Port_Init:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
// 2161 	_PCA9555Reg Reg;
// 2162 	Reg.Data = tIndex;	// Output  0
        STRH     R0,[SP, #+0]
// 2163 
// 2164 	PCASetConfiguration(Attn_CS0,Reg);
        LDR.N    R4,??pPCA9555Port_Init_0  ;; pPCA9555Str
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+0
        BL       pPCASetConfiguration
// 2165 	PCASetConfiguration(Attn_CS1,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+1
        BL       pPCASetConfiguration
// 2166 	PCASetConfiguration(Attn_CS2,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+2
        BL       pPCASetConfiguration
// 2167 
// 2168 	PCASetConfiguration(Attn_CS0,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+0
        BL       pPCASetConfiguration
// 2169 	PCASetConfiguration(Attn_CS1,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+1
        BL       pPCASetConfiguration
// 2170 	PCASetConfiguration(Attn_CS2,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+2
        BL       pPCASetConfiguration
// 2171 
// 2172 	PCASetConfiguration(Attn_CS0,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+0
        BL       pPCASetConfiguration
// 2173 	PCASetConfiguration(Attn_CS0,Reg);		
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+0
        BL       pPCASetConfiguration
// 2174 	
// 2175 	PCASetConfiguration(Attn_CS1,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+1
        BL       pPCASetConfiguration
// 2176 	PCASetConfiguration(Attn_CS1,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+1
        BL       pPCASetConfiguration
// 2177 
// 2178 	PCASetConfiguration(Attn_CS2,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+2
        BL       pPCASetConfiguration
// 2179 	PCASetConfiguration(Attn_CS2,Reg);
        LDR      R2,[R4, #+0]
        LDR      R1,[SP, #+0]
        MOVS     R0,#+2
        ADD      SP,SP,#+8
        POP      {R4,LR}
        B.W      pPCASetConfiguration
        DATA
??pPCA9555Port_Init_0:
        DC32     pPCA9555Str
// 2180 }
// 2181 
// 2182 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2183 void LED_Test(void)
// 2184 {
// 2185 #if 0
// 2186 	FrontLEDSet(LED_SUMSel_2G, LEDAlmON);
// 2187 	FrontLEDSet(LED_SUMSel_3G, LEDAlmON);
// 2188 	FrontLEDSet(LED_SUMSel_LTE, LEDAlmON);
// 2189 	FrontLEDSet(LED_SUMSel_LTE_A, LEDAlmON);
// 2190 	FrontLEDSet(LED_SUMSel_LTE1, LEDAlmON);
// 2191 	FrontLEDSet(LED_SUMSel_LTE_A1, LEDAlmON);
// 2192 
// 2193 	OSTimeDly(500L);	
// 2194 	FrontLEDSet(LED_SUMSel_2G, LEDNorON);
// 2195 	FrontLEDSet(LED_SUMSel_3G, LEDNorON);
// 2196 	FrontLEDSet(LED_SUMSel_LTE, LEDNorON);
// 2197 	FrontLEDSet(LED_SUMSel_LTE_A, LEDNorON);
// 2198 	FrontLEDSet(LED_SUMSel_LTE1, LEDNorON);
// 2199 	FrontLEDSet(LED_SUMSel_LTE_A1, LEDNorON);
// 2200 
// 2201 	OSTimeDly(500L);	
// 2202 
// 2203 	FrontLEDSet(LED_SUMSel_2G, LEDAlmON);
// 2204 	FrontLEDSet(LED_SUMSel_3G, LEDAlmON);
// 2205 	FrontLEDSet(LED_SUMSel_LTE, LEDAlmON);
// 2206 	FrontLEDSet(LED_SUMSel_LTE_A, LEDAlmON);
// 2207 	FrontLEDSet(LED_SUMSel_LTE1, LEDAlmON);
// 2208 	FrontLEDSet(LED_SUMSel_LTE_A1, LEDAlmON);
// 2209 
// 2210 	OSTimeDly(500L);	
// 2211 
// 2212 	FrontLEDSet(LED_SUMSel_2G, LEDNorON);
// 2213 	FrontLEDSet(LED_SUMSel_3G, LEDNorON);
// 2214 	FrontLEDSet(LED_SUMSel_LTE, LEDNorON);
// 2215 	FrontLEDSet(LED_SUMSel_LTE_A, LEDNorON);
// 2216 	FrontLEDSet(LED_SUMSel_LTE1, LEDNorON);
// 2217 	FrontLEDSet(LED_SUMSel_LTE_A1, LEDNorON);
// 2218 
// 2219 	OSTimeDly(500L);	
// 2220 
// 2221 	FrontLEDSet(LED_SUMSel_2G, LEDAlmON);
// 2222 	FrontLEDSet(LED_SUMSel_3G, LEDAlmON);
// 2223 	FrontLEDSet(LED_SUMSel_LTE, LEDAlmON);
// 2224 	FrontLEDSet(LED_SUMSel_LTE_A, LEDAlmON);
// 2225 	FrontLEDSet(LED_SUMSel_LTE1, LEDAlmON);
// 2226 	FrontLEDSet(LED_SUMSel_LTE_A1, LEDAlmON);
// 2227 
// 2228 	OSTimeDly(500L);	
// 2229 	FrontLEDSet(LED_SUMSel_2G, LEDNorON);
// 2230 	FrontLEDSet(LED_SUMSel_3G, LEDNorON);
// 2231 	FrontLEDSet(LED_SUMSel_LTE, LEDNorON);
// 2232 	FrontLEDSet(LED_SUMSel_LTE_A, LEDNorON);
// 2233 	FrontLEDSet(LED_SUMSel_LTE1, LEDNorON);
// 2234 	FrontLEDSet(LED_SUMSel_LTE_A1, LEDNorON);
// 2235 #endif
// 2236 	#if 0
// 2237 
// 2238 	pPCASetPortData(Attn_CS0, (0),pPCA9555Str);
// 2239 	pPCASetPortData(Attn_CS1, (0),pPCA9555Str);
// 2240 	pPCASetPortData(Attn_CS2, (0),pPCA9555Str);
// 2241 	
// 2242 	OSTimeDly(1000L);	
// 2243 		PCA9555SetData(AttnCS0_SEL0, ~(0), &LEDCSVal);
// 2244 		PCA9555SetData(AttnCS0_SEL1, ~(0), &LEDCSVal);
// 2245 		PCA9555SetData(AttnCS1_SEL0, ~(0), &LEDCSVal);
// 2246 		PCA9555SetData(AttnCS1_SEL1, ~(0), &LEDCSVal);
// 2247 	
// 2248 		PCA9555SetData(AttnCS2_SEL0, ~(0), &LEDCSVal);
// 2249 		PCA9555SetData(AttnCS2_SEL1, ~(0), &LEDCSVal);
// 2250 	#endif		
// 2251 //	AttnDataOutput(_FwdAttn1_2G_SEL, 		(0));
// 2252 //	OSTimeDly(1000L);	
// 2253 //	AttnDataOutput(_FwdAttn1_2G_SEL, 		~(0));
// 2254 
// 2255 #if 0
// 2256 	pPCASetPortData(Attn_CS1, (0),pPCA9555Str);
// 2257 	OSTimeDly(500L);
// 2258 	PCA9555SetData(AttnCS1_SEL1, ~(0), &LEDCSVal);
// 2259 
// 2260 	pPCASetPortData(Attn_CS2, (0),pPCA9555Str);
// 2261 	OSTimeDly(500L);
// 2262 	PCA9555SetData(AttnCS2_SEL1, ~(0), &LEDCSVal);
// 2263 
// 2264 	pPCASetPortData(Attn_CS0, (0),pPCA9555Str);
// 2265 	OSTimeDly(500L);
// 2266 	PCA9555SetData(AttnCS0_SEL0, ~(0), &LEDCSVal);
// 2267 	PCA9555SetData(AttnCS0_SEL1, ~(0), &LEDCSVal);
// 2268 #endif
// 2269 
// 2270 
// 2271 	OSTimeDly(500L);
LED_Test:
        MOV      R0,#+500
        B.W      OSTimeDly
// 2272 }

        END
// 2273 
// 2274 
// 2275 ///////////////////////////////////////////////////////////////////////////////
// 2276 // End of Source File
// 2277 ////////////////////////
// 
// 1 160 bytes in section .bss
// 7 246 bytes in section .text
// 
// 7 246 bytes of CODE memory
// 1 160 bytes of DATA memory
//
//Errors: none
//Warnings: none
