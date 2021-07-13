///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:32:30 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\adcFu /
//                    nc.c                                                    /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\adcFu /
//                    nc.c -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_appl /
//                    _src_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl /
//                    _src_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_ /
//                    src_20120109\sout\ --endian=little --cpu=Cortex-M3 -e   /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\adcFu /
//                    nc.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME adcFunc

        EXTERN ADC_Select
        EXTERN CPU_SR_Restore
        EXTERN CPU_SR_Save
        EXTERN ForDelay
        EXTERN NVIC_Init
        EXTERN OSIntExit
        EXTERN OSIntNesting
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_ddiv
        EXTERN __aeabi_dmul
        EXTERN __aeabi_ui2d
        EXTERN iAdcIndex

        PUBLIC ADC1_SWStart
        PUBLIC ADCChannelSEL
        PUBLIC ADCIndex
        PUBLIC ADCIndex1
        PUBLIC ADCInit
        PUBLIC ADCSubIndex
        PUBLIC ADCSubIndex1
        PUBLIC ADC_AVR
        PUBLIC ADC_AVR1
        PUBLIC ADC_ChannelDisable
        PUBLIC ADC_ChannelEnable
        PUBLIC ADC_DATA
        PUBLIC ADC_DATA1
        PUBLIC ADC_IRQHandler
        PUBLIC ADC_SUM
        PUBLIC ADC_SUM1
        PUBLIC ADC_Start
        PUBLIC ADC_Start2
        PUBLIC ADC_WRCNT
        PUBLIC ADC_WRCNT1
        PUBLIC ASTART
        PUBLIC ASTART1
        PUBLIC AdcEn
        PUBLIC AdctoVolt33V
        PUBLIC AdctoVolt5opamp
        PUBLIC AutoGetAdcValue
        PUBLIC GetAdcValue
        PUBLIC GetAdcValueInt
        PUBLIC Get_AdcValue
        PUBLIC ReadEnvTempTable
        PUBLIC SelectSort
        PUBLIC SelectSortSum
        PUBLIC Select_Sort
        PUBLIC SwapData
        PUBLIC chkADCStart
        PUBLIC chkADC_AVG
        PUBLIC chkADC_AVG1
        PUBLIC chkADC_AVG2
        PUBLIC tADCIndex1

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\adcFunc.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_adc.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V1.0
//    5 * Date               : 10/08/2007
//    6 * Description        : This file provides all the ADC firmware functions.
//    7 ********************************************************************************/
//    8 #define ADC_C
//    9 
//   10 // Includes ////////////////////////////////////////////////////////////////////
//   11 #include "../include/main.h"

        SECTION iram:DATA:NOROOT(2)
// INT16U __data ADC_DATA1[34]
ADC_DATA1:
        DS8 68

        SECTION iram:DATA:NOROOT(2)
// INT32U __data ADC_SUM1[34]
ADC_SUM1:
        DS8 136

        SECTION iram:DATA:NOROOT(2)
// INT16U __data ADC_AVR1[34][10]
ADC_AVR1:
        DS8 680

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data ADC_Start2
ADC_Start2:
        DATA
        DC8 10

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data ASTART
ASTART:
        DS8 1
// INT8U __data ADCIndex
ADCIndex:
        DS8 1
        DS8 2
// INT16U __data ADC_DATA[34]
ADC_DATA:
        DS8 68
// AdcChanelEn __data AdcEn
AdcEn:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// INT32U __data ADC_SUM[34]
ADC_SUM:
        DS8 136

        SECTION `.data`:DATA:NOROOT(0)
// INT8U __data ADCIndex1
ADCIndex1:
        DATA
        DC8 9

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data tADCIndex1
tADCIndex1:
        DS8 1
// INT8U __data chkADC_AVG
chkADC_AVG:
        DS8 1
// INT8U __data ADC_Start
ADC_Start:
        DS8 1
// INT8U __data chkADCStart
chkADCStart:
        DS8 1
// INT8U __data ADC_WRCNT[17]
ADC_WRCNT:
        DS8 20
// INT16U __data ADC_AVR[34][10]
ADC_AVR:
        DS8 680

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data ADCSubIndex
ADCSubIndex:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data ASTART1
ASTART1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(2)
// INT8U __data ADC_WRCNT1[17]
ADC_WRCNT1:
        DS8 20

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data ADCSubIndex1
ADCSubIndex1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkADC_AVG1
chkADC_AVG1:
        DS8 1

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data chkADC_AVG2
chkADC_AVG2:
        DS8 1
//   12 
//   13 #define ADC_AVER
//   14 
//   15 //#include "stm32f10x_conf.h"
//   16 //#include "../include/AdcFunc.h"
//   17 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   18 void ADCInit(int INT_EN)
//   19 {
ADCInit:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
//   20 	INT32U cpu_sr;
//   21 	
//   22 	ADC_TypeDef *ADCx = ADC1;
//   23 
//   24 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R5,R0
//   25 
//   26 	AdcEn.Data = 0;
        LDR.W    R0,??DataTable16  ;; ASTART
        MOVS     R1,#+0
        STR      R1,[R0, #+72]
//   27 	ADCIndex = 0;
        STRB     R1,[R0, #+1]
//   28 	ASTART = 0;
        STRB     R1,[R0, #+0]
//   29 	ADCx->SQR1.L = 0;	// 1EA
        LDR.N    R6,??DataTable5  ;; 0x40012404
        LDR      R0,[R6, #+40]
        BIC      R0,R0,#0xF00000
        STR      R0,[R6, #+40]
//   30 	ADCx->SQR3.SQ1 = 0; // Start Zer0
        LDR      R0,[R6, #+48]
        MOVS     R1,#+31
        BICS     R0,R0,R1
        STR      R0,[R6, #+48]
//   31 
//   32 	NVIC_Init(ADC_IRQChannel, INT_EN);
        MOV      R1,R4
        MOVS     R0,#+18
        BL       NVIC_Init
//   33 	
//   34 	// ADC1 regular channel14 configuration
//   35 	ADCx->SMPR1.Data = 0x00FFFFFF;		// ADC_SampleTime_239Cycles5
        MVN      R0,#-16777216
        STR      R0,[R6, #+8]
//   36 	ADCx->SMPR2.Data = 0x3FFFFFFF;		// ADC_SampleTime_239Cycles5
        MVN      R0,#-1073741824
        STR      R0,[R6, #+12]
//   37 
//   38 	// ADC1 configuration
//   39 	ADCx->CR1.DUALMOD = __dMODE_INDEPENDENT;
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0xF0000
        STR      R0,[R6, #+0]
//   40 	ADCx->CR1.SCAN = DISABLE;
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x100
        STR      R0,[R6, #+0]
//   41 	ADCx->CR1.EOCIE = INT_EN;		// interrupt enable
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x20
        LSLS     R1,R4,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STR      R0,[R6, #+0]
//   42 	ADCx->CR2.CONT = DISABLE;
        LDR      R0,[R6, #+4]
        BIC      R0,R0,#0x2
        STR      R0,[R6, #+4]
//   43 	ADCx->CR2.ALIGN = __ALI_Right;
        LDR      R0,[R6, #+4]
        BIC      R0,R0,#0x800
        STR      R0,[R6, #+4]
//   44 	ADCx->CR2.EXTSEL = __SWSTART;
        LDR      R0,[R6, #+4]
        ORR      R0,R0,#0xE0000
        STR      R0,[R6, #+4]
//   45 	ADCx->CR2.DMAMODE = DISABLE;
        LDR      R0,[R6, #+4]
        BIC      R0,R0,#0x100
        STR      R0,[R6, #+4]
//   46 	ADCx->CR2.EXTTRIG = ENABLE;
        LDR      R0,[R6, #+4]
        ORR      R0,R0,#0x100000
        STR      R0,[R6, #+4]
//   47 	ADCx->CR2.TSVREFE = ENABLE; 	// temperature sensor enable
        LDR      R0,[R6, #+4]
        ORR      R0,R0,#0x800000
        STR      R0,[R6, #+4]
//   48 	ADCx->CR2.ADON = ENABLE;		// Enable ADC1
        LDR      R0,[R6, #+4]
        ORR      R0,R0,#0x1
        STR      R0,[R6, #+4]
//   49 
//   50 	// Enable ADC1 reset calibaration register
//   51 	{
//   52 		INT16U rtry = 0xffff;
        MOVW     R0,#+65535
        MOV      R1,R0
//   53 	
//   54 		ADCx->CR2.RSTCAL = SET;
        LDR      R2,[R6, #+4]
        ORR      R2,R2,#0x8
        STR      R2,[R6, #+4]
//   55 		while((rtry--) && ADCx->CR2.RSTCAL);
??ADCInit_0:
        MOV      R2,R1
        ADDS     R1,R0,R2
        UXTH     R2,R2
        CBZ      R2,??ADCInit_1
        LDR      R2,[R6, #+4]
        TST      R2,#0x8
        BNE.N    ??ADCInit_0
//   56 	}
//   57 	// Start ADC1 calibaration
//   58 	{
//   59 		INT16U rtry = 0xffff;
??ADCInit_1:
        MOV      R1,R0
//   60 	
//   61 		ADCx->CR2.CAL = SET;
        LDR      R2,[R6, #+4]
        ORR      R2,R2,#0x4
        STR      R2,[R6, #+4]
//   62 		while((rtry--) && ADCx->CR2.CAL);
??ADCInit_2:
        MOV      R2,R1
        ADDS     R1,R0,R2
        UXTH     R2,R2
        CBZ      R2,??ADCInit_3
        LDR      R2,[R6, #+4]
        TST      R2,#0x4
        BNE.N    ??ADCInit_2
//   63 	}
//   64 	// Start ADC1 Software Conversion
//   65 	//ADCx->CR2.Bit.SWSTART = INT_EN;//INT_EN;		// ADC1->CONVERTER START
//   66 
//   67 	ADCChannelSEL();
??ADCInit_3:
        BL       ADCChannelSEL
//   68 	OS_EXIT_CRITICAL();
        MOV      R0,R5
        POP      {R4-R6,LR}
        B.W      OS_CPU_SR_Restore
//   69 }
//   70 
//   71 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   72 void ADCChannelSEL(void)
//   73 {
//   74 	ADC_ChannelEnable(ADC_Channel_0);
ADCChannelSEL:
        LDR.W    R0,??DataTable16  ;; ASTART
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+72]
//   75 	ADC_ChannelEnable(ADC_Channel_1);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x2
        STR      R1,[R0, #+72]
//   76 	ADC_ChannelEnable(ADC_Channel_2);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x4
        STR      R1,[R0, #+72]
//   77 	ADC_ChannelEnable(ADC_Channel_3);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x8
        STR      R1,[R0, #+72]
//   78 	ADC_ChannelEnable(ADC_Channel_4);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x10
        STR      R1,[R0, #+72]
//   79 	ADC_ChannelEnable(ADC_Channel_5);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x20
        STR      R1,[R0, #+72]
//   80 	ADC_ChannelEnable(ADC_Channel_6);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x40
        STR      R1,[R0, #+72]
//   81 	ADC_ChannelEnable(ADC_Channel_7);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+72]
//   82 	ADC_ChannelEnable(ADC_Channel_8);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x100
        STR      R1,[R0, #+72]
//   83 	ADC_ChannelEnable(ADC_Channel_9);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x200
        STR      R1,[R0, #+72]
//   84 	ADC_ChannelEnable(ADC_Channel_10);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x400
        STR      R1,[R0, #+72]
//   85 	ADC_ChannelEnable(ADC_Channel_11);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x800
        STR      R1,[R0, #+72]
//   86 	ADC_ChannelEnable(ADC_Channel_12);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x1000
        STR      R1,[R0, #+72]
//   87 	ADC_ChannelEnable(ADC_Channel_13);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x2000
        STR      R1,[R0, #+72]
//   88 	ADC_ChannelEnable(ADC_Channel_14);	
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x4000
        STR      R1,[R0, #+72]
//   89 	ADC_ChannelEnable(ADC_Channel_15);
        LDR      R1,[R0, #+72]
        ORR      R1,R1,#0x8000
        STR      R1,[R0, #+72]
//   90 }
        BX       LR               ;; return
//   91 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 void ADC_ChannelEnable(INT8U channel)
//   93 {
//   94 	AdcEn.Data |= (1 << channel);
ADC_ChannelEnable:
        LDR.W    R1,??DataTable16  ;; ASTART
        LDR      R2,[R1, #+72]
        MOVS     R3,#+1
        LSL      R0,R3,R0
        ORRS     R0,R0,R2
        STR      R0,[R1, #+72]
//   95 }
        BX       LR               ;; return
//   96 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   97 void ADC_ChannelDisable(INT8U channel)
//   98 {
//   99 	AdcEn.Data &= ~(1 << channel);
ADC_ChannelDisable:
        LDR.W    R1,??DataTable16  ;; ASTART
        LDR      R2,[R1, #+72]
        MOVS     R3,#+1
        LSL      R0,R3,R0
        MVNS     R0,R0
        ANDS     R0,R0,R2
        STR      R0,[R1, #+72]
//  100 }
        BX       LR               ;; return
//  101 
//  102 
//  103 /*******************************************************************************
//  104 * Function Name  : GetAdcValue
//  105 * Description    : get ADC Value directly(only case no_interrupt mode
//  106 *                  group channel.
//  107 * Input          : - channel: where x can be 1 or 2 to select the ADC channel
//  108 * Output         : None
//  109 * Return         : - direct ADCx channel 12 bit value
//  110 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  111 void ADC1_SWStart(void)
//  112 {
ADC1_SWStart:
        PUSH     {R4,R5}
        SUB      SP,SP,#+8
//  113 	int i = 0;
//  114 
//  115 #ifndef ADC_AVER
//  116 	while(ASTART);
//  117 	ForDelay(1);
//  118 #endif
//  119 	if(ADC1->CR1.EOCIE)
        LDR.N    R0,??DataTable5  ;; 0x40012404
        LDR      R1,[R0, #+0]
        STR      R1,[SP, #+0]
        LDR.W    R1,??DataTable16  ;; ASTART
        LDRB     R2,[R1, #+1]
        LDR      R3,[SP, #+0]
        TST      R3,#0x20
        BEQ.N    ??ADC1_SWStart_0
//  120 	{
//  121 		for(i = 0; i < __ADCMAX ; i++)
        MOVS     R3,#+0
        MOVS     R4,#+17
//  122 		{
//  123 			ADCIndex++;
//  124 			ADCIndex %= __ADCMAX;
??ADC1_SWStart_1:
        ADDS     R2,R2,#+1
        UXTB     R2,R2
        SDIV     R5,R2,R4
        MLS      R2,R5,R4,R2
//  125 
//  126 			if((AdcEn.Data >> ADCIndex) & 0x01 )
        LDR      R5,[R1, #+72]
        LSRS     R5,R5,R2
        TST      R5,#0x1
        BNE.N    ??ADC1_SWStart_2
//  127 			{
//  128 #ifndef ADC_AVER
//  129 				ADC_WRCNT[ADCIndex]++;
//  130 				ADC_WRCNT[ADCIndex] %= __ADCAVR;
//  131 #endif
//  132 				break;
//  133 			}
//  134 		}
        ADDS     R3,R3,#+1
        CMP      R3,#+17
        BLT.N    ??ADC1_SWStart_1
//  135 		ADC1->SQR3.SQ1 = ADCIndex;
??ADC1_SWStart_2:
        LDR      R3,[R0, #+48]
        MOVS     R4,#+31
        BICS     R3,R3,R4
        UXTB     R2,R2
        AND      R4,R2,#0x1F
        ORRS     R3,R4,R3
        STR      R3,[R0, #+48]
//  136 		ADC1->CR2.SWSTART = ENABLE;
        LDR      R3,[R0, #+4]
        ORR      R3,R3,#0x400000
        STR      R3,[R0, #+4]
??ADC1_SWStart_0:
        STRB     R2,[R1, #+1]
//  137 	}
//  138 }
        POP      {R0,R1,R4,R5}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x40012404
//  139 
//  140 
//  141 /*******************************************************************************
//  142 * Function Name  : GetAdcValue
//  143 * Description    : get ADC Value directly(only case no_interrupt mode
//  144 *                  group channel.
//  145 * Input          : - channel: where x can be 1 or 2 to select the ADC channel
//  146 * Output         : None
//  147 * Return         : - direct ADCx channel 12 bit value
//  148 *******************************************************************************/
//  149 #if 0
//  150 void AutoGetAdcValue(void)
//  151 {
//  152 	int i = 0, tmp;
//  153 	i = i;
//  154 //	for(i = 0; i < 3; i++)
//  155 	{
//  156 		if(++ADCIndex >= __ADCMAX) ADCIndex = 0;
//  157 
//  158 		if((AdcEn.Data >> ADCIndex) & 0x01 )
//  159 		{
//  160 			if(++(ADC_WRCNT[ADCIndex]) >= __ADCAVR ) ADC_WRCNT[ADCIndex] = 0;
//  161 			if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  162 			{
//  163 				ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = tmp;
//  164 			}
//  165 		}
//  166 	}
//  167 }
//  168 #endif
//  169 
//  170 #if 1
//  171 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  172 void AutoGetAdcValue(void)
//  173 {
AutoGetAdcValue:
        PUSH     {R3-R5,LR}
//  174 
//  175 //	int i = 0, tmp;
//  176 //    i = i;
//  177 //	INT8U tCnt;
//  178 	int tmp;
//  179 //	INT16S Data;
//  180 #if 0
//  181 	if(++ADCIndex > __ADCMAX)
//  182 	{
//  183 		ADCIndex = ADC_Start;
//  184 
//  185 		if( ++iAdcIndex > 3) 
//  186 		{
//  187 			iAdcIndex = 0;
//  188 			chkADC_AVG = SET;
//  189 		}
//  190 		chkADCStart = 0;
//  191 		ADC_Select(iAdcIndex);
//  192 
//  193 //		SerPtr->printf("0: iAdcIndex[%d]\n",iAdcIndex);		
//  194 	}
//  195 
//  196 	
//  197 	if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  198 	{
//  199 //		ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex]] = tmp;
//  200 //		ADC_DATA[ADCIndex] = tmp;
//  201 		if( iAdcIndex == 0)
//  202 		{
//  203 			ADC_AVR[ADCIndex][0] = tmp;
//  204 
//  205 			if( ADCIndex > __ADC1MAX)
//  206 			{
//  207 //				if(ADCIndex == 11) 	SerPtr->printf("1: iAdcIndex[%d][%d]:[%d]\n",iAdcIndex,ADCIndex,ADC_AVR[ADCIndex][0]);		
//  208 			}
//  209 		}
//  210 		else
//  211 		{
//  212 			if( ADCIndex <= __ADC1MAX)
//  213 			{
//  214 				ADC_AVR[ADCIndex][0] = tmp;
//  215 //				SerPtr->printf("2: iAdcIndex[%d][%d]:[%d]\n",iAdcIndex,ADCIndex,ADC_AVR[ADCIndex][0]);		
//  216 			}
//  217 			else if( ADCIndex <= __ADC2MAX)
//  218 			{
//  219 				tADCIndex1 = ADCIndex +iAdcIndex*6;
//  220 				ADC_AVR[tADCIndex1][0] = tmp;
//  221 //				if(ADCIndex == 11)  SerPtr->printf("3: iAdcIndex[%d][%d][%d]:[%d]\n",iAdcIndex,ADCIndex,tADCIndex1,ADC_AVR[tADCIndex1][0]);		
//  222 //				SerPtr->printf("3: iAdcIndex[%d][%d][%d]:[%d]\n",iAdcIndex,ADCIndex,tADCIndex1,ADC_AVR[tADCIndex1][0]); 	  
//  223 
//  224 			}
//  225 		}
//  226 	}
//  227 	if(chkADC_AVG)
//  228 	{
//  229 		int i = 0;
//  230 
//  231 		for(i = ADC_Start; i <= __ADC_MAX; i++)
//  232 		{
//  233 			ADC_DATA1[i] = ADC_AVR[i][0];
//  234 		}
//  235 
//  236 		chkADC_AVG = RESET;
//  237 	}
//  238 #endif
//  239 
//  240 #if 1
//  241 //	int i = 0;
//  242 
//  243 //	for(i = 0; i < 4; i++)
//  244 	{
//  245 		if(++ADCIndex > __ADCMAX)
        LDR.W    R5,??DataTable16  ;; ASTART
        LDRB     R0,[R5, #+1]
        ADDS     R0,R0,#+1
        STRB     R0,[R5, #+1]
        UXTB     R0,R0
        CMP      R0,#+18
        BCC.N    ??AutoGetAdcValue_0
//  246 		{
//  247 			ADCIndex = ADC_Start;
        LDR.N    R4,??AutoGetAdcValue_1  ;; tADCIndex1
        LDRB     R0,[R4, #+2]
        STRB     R0,[R5, #+1]
//  248 
//  249 			if( ++iAdcIndex > 3) 
        LDR.N    R1,??AutoGetAdcValue_1+0x4  ;; iAdcIndex
        LDRB     R0,[R1, #+0]
        ADDS     R0,R0,#+1
        STRB     R0,[R1, #+0]
        UXTB     R0,R0
        CMP      R0,#+4
        BCC.N    ??AutoGetAdcValue_2
//  250 			{
//  251 				iAdcIndex = 0;
        MOVS     R0,#+0
        STRB     R0,[R1, #+0]
//  252 	//			chkADC_AVG = SET;
//  253 			}
//  254 
//  255 			chkADCStart = 0;
??AutoGetAdcValue_2:
        MOVS     R0,#+0
        STRB     R0,[R4, #+3]
//  256 			ADC_Select(iAdcIndex);
        LDRB     R0,[R1, #+0]
        BL       ADC_Select
//  257 	//		SerPtr->printf("0: iAdcIndex[%d]\n",iAdcIndex);		
//  258 		}
//  259 		
//  260 		if((AdcEn.Data >> ADCIndex) & 0x01 )
??AutoGetAdcValue_0:
        LDRB     R0,[R5, #+1]
        LDR      R1,[R5, #+72]
        LSRS     R1,R1,R0
        TST      R1,#0x1
        BEQ.W    ??AutoGetAdcValue_3
//  261 		{
//  262 			if(++(ADC_WRCNT[ADCIndex]) >= __ADCAVR ) 
        LDR.N    R4,??AutoGetAdcValue_1  ;; tADCIndex1
        ADDS     R1,R0,R4
        LDRB     R2,[R1, #+4]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+4]
        UXTB     R2,R2
        CMP      R2,#+10
        BCC.N    ??AutoGetAdcValue_4
//  263 			{
//  264 				ADC_WRCNT[ADCIndex] = 0;
        MOVS     R2,#+0
        STRB     R2,[R1, #+4]
//  265 				
//  266 				chkADC_AVG = SET;
        MOVS     R1,#+1
        STRB     R1,[R4, #+1]
//  267 			}
//  268 			
//  269 			if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
??AutoGetAdcValue_4:
        BL       GetAdcValue
        CMP      R0,#+0
        BMI.N    ??AutoGetAdcValue_5
//  270 			{
//  271 		//		ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex]] = tmp;
//  272 		//		ADC_DATA[ADCIndex] = tmp;
//  273 				if( iAdcIndex == 0)
        LDRB     R2,[R5, #+1]
        LDR.N    R1,??AutoGetAdcValue_1+0x4  ;; iAdcIndex
        LDRB     R1,[R1, #+0]
        CBNZ     R1,??AutoGetAdcValue_6
//  274 				{
//  275 					ADC_AVR[ADCIndex][ADC_WRCNT[ADCIndex] ] = tmp;
??AutoGetAdcValue_7:
        ADDS     R1,R2,R4
        LDRB     R1,[R1, #+4]
        B.N      ??AutoGetAdcValue_8
//  276 
//  277 					if( ADCIndex > __ADC1MAX)
//  278 					{
//  279 		//				if(ADCIndex == 11) 	SerPtr->printf("1: iAdcIndex[%d][%d]:[%d]\n",iAdcIndex,ADCIndex,ADC_AVR[ADCIndex][0]);		
//  280 					}
//  281 				}
//  282 				else
//  283 				{
//  284 					if( ADCIndex <= __ADC1MAX)
??AutoGetAdcValue_6:
        CMP      R2,#+10
        BCC.N    ??AutoGetAdcValue_7
//  285 					{
//  286 						ADC_AVR[ADCIndex][ADC_WRCNT[ADCIndex] ] = tmp;
//  287 		//				SerPtr->printf("2: iAdcIndex[%d][%d]:[%d]\n",iAdcIndex,ADCIndex,ADC_AVR[ADCIndex][0]);		
//  288 					}
//  289 					else if( ADCIndex <= __ADC2MAX)
        CMP      R2,#+16
        BCS.N    ??AutoGetAdcValue_5
//  290 					{
//  291 						tADCIndex1 = ADCIndex +iAdcIndex*6;
        MOVS     R3,#+6
        MLA      R1,R1,R3,R2
        STRB     R1,[R4, #+0]
//  292 						ADC_AVR[tADCIndex1][ADC_WRCNT[ADCIndex] ] = tmp;
        ADDS     R1,R2,R4
        LDRB     R1,[R1, #+4]
        LDRB     R2,[R4, #+0]
??AutoGetAdcValue_8:
        MOVS     R3,#+20
        MLA      R2,R2,R3,R4
        ADD      R1,R2,R1, LSL #+1
        STRH     R0,[R1, #+24]
//  293 		//				if(ADCIndex == 11)  SerPtr->printf("3: iAdcIndex[%d][%d][%d]:[%d]\n",iAdcIndex,ADCIndex,tADCIndex1,ADC_AVR[tADCIndex1][0]);		
//  294 					}
//  295 				}
//  296 			}
//  297 			#if 1
//  298 			if(chkADC_AVG)
??AutoGetAdcValue_5:
        LDRB     R0,[R4, #+1]
        CMP      R0,#+0
        BEQ.W    ??AutoGetAdcValue_3
//  299 			{
//  300 #if 0
//  301 
//  302 				int i = 0;
//  303 				for(i = ADC_Start; i <= __ADC_MAX; i++)
//  304 				{
//  305 //					ADC_DATA1[i] = ADC_AVR[i][0];
//  306 					ADC_DATA1[i]  = SelectSortSum(ADC_AVR[i],__ADCAVR,7,ADC_MinSum);
//  307 				}
//  308 #endif				
//  309 #if 1
//  310 
//  311 				ADC_DATA1[FwdAgcAvgVolt_2G]  = SelectSortSum(ADC_AVR[FwdAgcAvgVolt_2G],__ADCAVR,7,ADC_MinSum);
        LDR.W    R5,??DataTable17  ;; ADC_DATA1
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+24
        BL       SelectSortSum
        STRH     R0,[R5, #+0]
//  312 				ADC_DATA1[FwdAgcPeakVolt_2G]  = SelectSortSum(ADC_AVR[FwdAgcPeakVolt_2G],__ADCAVR,7,ADC_PeakSum);
        MOVS     R3,#+1
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+44
        BL       SelectSortSum
        STRH     R0,[R5, #+2]
//  313 				ADC_DATA1[FwdAgcAvgVolt_LTE]  = SelectSortSum(ADC_AVR[FwdAgcAvgVolt_LTE],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+64
        BL       SelectSortSum
        STRH     R0,[R5, #+4]
//  314 				ADC_DATA1[FwdAgcPeakVolt_LTE]  = SelectSortSum(ADC_AVR[FwdAgcPeakVolt_LTE],__ADCAVR,7,ADC_PeakSum);
        MOVS     R3,#+1
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+84
        BL       SelectSortSum
        STRH     R0,[R5, #+6]
//  315 				ADC_DATA1[FwdAgcAvgVolt_LTE_A]  = SelectSortSum(ADC_AVR[FwdAgcAvgVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+124
        BL       SelectSortSum
        STRH     R0,[R5, #+10]
//  316 				ADC_DATA1[FwdAgcPeakVolt_LTE_A]  = SelectSortSum(ADC_AVR[FwdAgcPeakVolt_LTE_A],__ADCAVR,7,ADC_PeakSum);
        MOVS     R3,#+1
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+144
        BL       SelectSortSum
        STRH     R0,[R5, #+12]
//  317 				ADC_DATA1[FwdOutAvgVolt_3G]  = SelectSortSum(ADC_AVR[FwdOutAvgVolt_3G],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+224
        BL       SelectSortSum
        STRH     R0,[R5, #+20]
//  318 				ADC_DATA1[FwdOutPeakVolt_3G]  = SelectSortSum(ADC_AVR[FwdOutPeakVolt_3G],__ADCAVR,7,ADC_PeakSum);
        MOVS     R3,#+1
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+244
        BL       SelectSortSum
        STRH     R0,[R5, #+22]
//  319 				ADC_DATA1[Fwd1AgcAvgVolt_LTE]  = SelectSortSum(ADC_AVR[Fwd1AgcAvgVolt_LTE],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+164
        BL       SelectSortSum
        STRH     R0,[R5, #+14]
//  320 				ADC_DATA1[Fwd1AgcPeakVolt_LTE]  = SelectSortSum(ADC_AVR[Fwd1AgcPeakVolt_LTE],__ADCAVR,7,ADC_PeakSum);
        MOVS     R3,#+1
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+184
        BL       SelectSortSum
        STRH     R0,[R5, #+16]
//  321 				ADC_DATA1[Fwd1AgcAvgVolt_LTE_A]  = SelectSortSum(ADC_AVR[Fwd1AgcAvgVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+204
        BL       SelectSortSum
        STRH     R0,[R5, #+18]
//  322 				ADC_DATA1[Fwd1AgcPeakVolt_LTE_A]  = SelectSortSum(ADC_AVR[Fwd1AgcPeakVolt_LTE_A],__ADCAVR,7,ADC_PeakSum);
        MOVS     R3,#+1
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+264
        BL       SelectSortSum
        STRH     R0,[R5, #+24]
//  323 				ADC_DATA1[FwdOutAvgVolt_Common]  = SelectSortSum(ADC_AVR[FwdOutAvgVolt_Common],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+104
        BL       SelectSortSum
        STRH     R0,[R5, #+8]
//  324 				ADC_DATA1[RvsInVolt_2G]  = SelectSortSum(ADC_AVR[RvsInVolt_2G],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+284
        BL       SelectSortSum
        STRH     R0,[R5, #+26]
//  325 				ADC_DATA1[RvsInVolt_3G]  = SelectSortSum(ADC_AVR[RvsInVolt_3G],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+304
        BL       SelectSortSum
        STRH     R0,[R5, #+28]
//  326 				ADC_DATA1[Rvs1InVolt_LTE]  = SelectSortSum(ADC_AVR[Rvs1InVolt_LTE],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+324
        BL       SelectSortSum
        STRH     R0,[R5, #+30]
//  327 				ADC_DATA1[FwdInVolt_Common]  = SelectSortSum(ADC_AVR[FwdInVolt_Common],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+344
        BL       SelectSortSum
        STRH     R0,[R5, #+32]
//  328 				ADC_DATA1[Curr_Temp]  = SelectSortSum(ADC_AVR[Curr_Temp],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+364
        BL       SelectSortSum
        STRH     R0,[R5, #+34]
//  329 				ADC_DATA1[Fwd1InVolt_LTE]  = SelectSortSum(ADC_AVR[Fwd1InVolt_LTE],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+384
        BL       SelectSortSum
        STRH     R0,[R5, #+36]
//  330 				ADC_DATA1[RvsInVolt_LTE_A]  = SelectSortSum(ADC_AVR[RvsInVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+404
        BL       SelectSortSum
        STRH     R0,[R5, #+38]
//  331 				ADC_DATA1[RvsOutVolt_Common]  = SelectSortSum(ADC_AVR[RvsOutVolt_Common],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+424
        BL       SelectSortSum
        STRH     R0,[R5, #+40]
//  332 				ADC_DATA1[Rvs1InVolt_LTE_A]  = SelectSortSum(ADC_AVR[Rvs1InVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+444
        BL       SelectSortSum
        STRH     R0,[R5, #+42]
//  333 				ADC_DATA1[FwdInVolt_LTE_A]  = SelectSortSum(ADC_AVR[FwdInVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+464
        BL       SelectSortSum
        STRH     R0,[R5, #+44]
//  334 				ADC_DATA1[PSUDCVolt]  = SelectSortSum(ADC_AVR[PSUDCVolt],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+484
        BL       SelectSortSum
        STRH     R0,[R5, #+46]
//  335 				ADC_DATA1[Fwd1InVolt_LTE_A]  = SelectSortSum(ADC_AVR[Fwd1InVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+504
        BL       SelectSortSum
        STRH     R0,[R5, #+48]
//  336 				ADC_DATA1[RvsOutVolt_LTE_A]  = SelectSortSum(ADC_AVR[RvsOutVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+524
        BL       SelectSortSum
        STRH     R0,[R5, #+50]
//  337 				ADC_DATA1[RvsInVolt_LTE]  = SelectSortSum(ADC_AVR[RvsInVolt_LTE],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+544
        BL       SelectSortSum
        STRH     R0,[R5, #+52]
//  338 				ADC_DATA1[Rvs1OutVolt_LTE]  = SelectSortSum(ADC_AVR[Rvs1OutVolt_LTE],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+564
        BL       SelectSortSum
        STRH     R0,[R5, #+54]
//  339 				ADC_DATA1[FwdInVolt_3G]  = SelectSortSum(ADC_AVR[FwdInVolt_3G],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+584
        BL       SelectSortSum
        STRH     R0,[R5, #+56]
//  340 				ADC_DATA1[DCOutVolt]  = SelectSortSum(ADC_AVR[DCOutVolt],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+604
        BL       SelectSortSum
        STRH     R0,[R5, #+58]
//  341 				ADC_DATA1[RvsInVolt_Common]  = SelectSortSum(ADC_AVR[RvsInVolt_Common],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+624
        BL       SelectSortSum
        STRH     R0,[R5, #+60]
//  342 				ADC_DATA1[SpVolt]  = SelectSortSum(ADC_AVR[SpVolt],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+644
        BL       SelectSortSum
        STRH     R0,[R5, #+62]
//  343 				ADC_DATA1[RvsOutVolt_3G]  = SelectSortSum(ADC_AVR[RvsOutVolt_3G],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+664
        BL       SelectSortSum
        STRH     R0,[R5, #+64]
//  344 				ADC_DATA1[Rvs1OutVolt_LTE_A]  = SelectSortSum(ADC_AVR[Rvs1OutVolt_LTE_A],__ADCAVR,7,ADC_MinSum);
        MOVS     R3,#+2
        MOVS     R2,#+7
        MOVS     R1,#+10
        ADD      R0,R4,#+684
        BL       SelectSortSum
        ADD      R1,R5,#+64
        STRH     R0,[R1, #+2]
//  345 
//  346 
//  347 #endif
//  348 
//  349 
//  350 #if 0
//  351 				{
//  352 					ADC_DATA1[FwdAgcAvgVolt_2G]  = SelectSortSum(ADC_AVR[i],__ADCAVR,2,ADC_AvgSum);\ 
//  353 				}
//  354 #endif
//  355 				chkADC_AVG = RESET;
        MOVS     R0,#+0
        STRB     R0,[R4, #+1]
//  356 			}
//  357 			#endif
//  358 		}
//  359 	}
//  360 #endif
//  361 
//  362 #if 0
//  363 //	if(chkADCStart) return;
//  364 
//  365 	if(++ADCIndex >= __ADC2MAX)
//  366 	{
//  367 		ADCIndex = ADC_Start;
//  368 
//  369 		if(chkADCStart)
//  370 		{
//  371 			if( ++iAdcIndex > 3) 
//  372 			{
//  373 				iAdcIndex = 0;
//  374 				chkADC_AVG = SET;
//  375 			}
//  376 
//  377 			chkADCStart = 0;
//  378 
//  379 			ADC_Select(iAdcIndex);
//  380 		}
//  381 //		if(iAdcIndex == 0) OSTimeDly(10L);
//  382 
//  383 		SerPtr->printf("0: iAdcIndex[%d]\n",iAdcIndex);		
//  384 	}
//  385 	
//  386 	if( ADCIndex < __ADC1MAX)
//  387 	{
//  388 		if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  389 		{
//  390 //			ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex]] = tmp;
//  391 			ADC_AVR[ADCIndex][0] = tmp;
//  392 //			ADC_DATA[ADCIndex] = tmp;
//  393 		}
//  394 #if 0
//  395 		{
//  396 			INT16S Data;
//  397 
//  398 			Data = AdctoVolt33V(ADC_AVR[ADCIndex][0]);
//  399 			SerPtr->printf("1: ADCIndex[%d]  : %d.%03d[V]\n", ADCIndex,Data/1000, Data%1000);
//  400 		}
//  401 #endif
//  402 		
//  403 //		SerPtr->printf("0: ADCIndex[%d]ADC_DATA[%d]\n",ADCIndex,ADC_DATA[ADCIndex]);
//  404 
//  405 	}
//  406 //	else if( ADCIndex <=__ADC2MAX)
//  407 	else
//  408 	{
//  409 		tADCIndex1 = ADCIndex +iAdcIndex*6;
//  410 
//  411 		if(chkADCStart== 0)
//  412 		{
//  413 			if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  414 			{
//  415 	//			ADC_DATA[tADCIndex1] = tmp;
//  416 				ADC_AVR[tADCIndex1][0] = tmp;
//  417 			}
//  418 		}
//  419 		if(ADCIndex == 15)
//  420 		{
//  421 			chkADCStart = 1;
//  422 
//  423 		
//  424 //			ForDelay(1000);
//  425 //			OSTimeDly(1L);
//  426 		}
//  427 		
//  428 		#if 1
//  429 //		if(ADCIndex == 11)
//  430 		{
//  431 			INT16S Data;
//  432 			Data = AdctoVolt33V(ADC_AVR[tADCIndex1][0]);
//  433 			SerPtr->printf("2: ADCIndex[%d][%d] : %d.%03d[V]\n", ADCIndex,tADCIndex1,Data/1000, Data%1000);
//  434 		}
//  435 		#endif
//  436 //		SerPtr->printf("1: ADCIndex[%d][%d]ADC_DATA[%d]\n",ADCIndex,tADCIndex1,ADC_DATA[ADCIndex]);
//  437 	}
//  438 
//  439 	if(chkADC_AVG)
//  440 	{
//  441 		int i = 0;
//  442 
//  443 		for(i = ADC_Start; i <= __ADC_MAX; i++)
//  444 		{
//  445 			ADC_DATA[i]	= ADC_AVR[i][0];
//  446 		}
//  447 
//  448 		chkADC_AVG = RESET;
//  449 
//  450 //		AdInputStatus();
//  451 	}
//  452 #endif
//  453 
//  454 //////
//  455 	#if 0
//  456 	{
//  457 		if(++ADCIndex >= __ADC1MAX) ADCIndex = ADC_Start;
//  458 		if((AdcEn.Data >> ADCIndex) & 0x01 )
//  459 		{
//  460 			if(++(ADC_WRCNT[ADCIndex]) >= __ADCAVR ) 
//  461 			{
//  462 				ADC_WRCNT[ADCIndex] = 0;
//  463 				chkADC_AVG = SET;
//  464 			}
//  465 			
//  466 			if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  467 			{
//  468 				ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex]] = tmp;
//  469 //				SerPtr->printf("0: ADCIndex[%d]chkADC_AVG[%d]\n",ADCIndex,chkADC_AVG);
//  470 //				SerPtr->printf("0: ADCIndex[%d] ADC_WRCNT[%d]\n",ADCIndex,ADC_WRCNT1[ADCIndex1]);
//  471 
//  472 			}
//  473 		}
//  474 
//  475 
//  476 
//  477 //		SerPtr->printf("i[%d]ADCIndex[%d]ADC_WRCNT[%d]:tmp[%d][%d]\n",i,ADCIndex,ADC_WRCNT[ADCIndex],
//  478 //			tmp,ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] );
//  479 	}
//  480 	
//  481 	if(chkADC_AVG)
//  482 	{
//  483 		for(i = ADC_Start; i <= __ADCMAX; i++)
//  484 		{
//  485 			ADC_DATA[i] 			= SelectSortSum(ADC_AVR[i],__ADCAVR,2,ADC_AvgSum);
//  486 		}
//  487 		chkADC_AVG = RESET;
//  488 		
//  489 //		SerPtr->printf("1: ADCIndex[%d]chkADC_AVG[%d]\n",ADCIndex,chkADC_AVG);
//  490 	}
//  491 
//  492 
//  493 ///////////////////////////////////////////////////////////
//  494 	{
//  495 		if(++ADCIndex1 >= __ADCMAX) 
//  496 		{
//  497 			ADCIndex1 = ADC_Start2;
//  498 			
//  499 			iAdcIndex = iAdcIndex + 1;
//  500 			ADC_Select(iAdcIndex);
//  501 			if( iAdcIndex > 3) iAdcIndex = 0;
//  502 
//  503 //			SerPtr->printf("2: ADCIndex1[%d][%d] \n",ADCIndex1,tADCIndex1);
//  504 		}
//  505 
//  506 
//  507 		if((AdcEn.Data >> ADCIndex1) & 0x01 )
//  508 		{
//  509 			if(++(ADC_WRCNT1[ADCIndex1]) >= __ADCAVR ) 
//  510 			{
//  511 				ADC_WRCNT1[ADCIndex1] = 0;
//  512 				chkADC_AVG1++;
//  513 			}
//  514 
//  515 			if( (tmp = GetAdcValue(ADCIndex1)) >= 0 )
//  516 			{
//  517 				tADCIndex1 = ADCIndex1 +iAdcIndex*6;
//  518 
//  519 				ADC_AVR1[tADCIndex1][ ADC_WRCNT1[ADCIndex1] ] = tmp;
//  520 				
//  521 				SerPtr->printf("3: ADCIndex1[%d][%d] ADC_WRCNT1[%d]\n",ADCIndex1,tADCIndex1,ADC_WRCNT1[ADCIndex1]);
//  522 			}
//  523 		}
//  524 
//  525 //		SerPtr->printf("i[%d]ADCIndex[%d]ADC_WRCNT[%d]:tmp[%d][%d]\n",i,ADCIndex,ADC_WRCNT[ADCIndex],
//  526 //			tmp,ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] );
//  527 	}
//  528 	
//  529 	if(chkADC_AVG1 == 3 )
//  530 	{
//  531 		for(i = ADC_Start2; i <= __ADCMAX; i++)
//  532 		{
//  533 			ADC_DATA1[i] 			= SelectSortSum(ADC_AVR[i],__ADCAVR,2,ADC_AvgSum);
//  534 		}
//  535 		chkADC_AVG1 = RESET;
//  536 		
//  537 		SerPtr->printf("4: ADCIndex1[%d]chkADC_AVG1[%d]:ADC_DATA1[%d][%d]\n",ADCIndex1,chkADC_AVG1,i,ADC_DATA1[i]);
//  538 	}
//  539 	#endif
//  540 }
??AutoGetAdcValue_3:
        POP      {R0,R4,R5,PC}    ;; return
        Nop      
        DATA
??AutoGetAdcValue_1:
        DC32     tADCIndex1
        DC32     iAdcIndex
//  541 
//  542 
//  543 
//  544 
//  545 #endif
//  546 
//  547 #if 0
//  548 
//  549 void AutoGetAdcValue(void)
//  550 {
//  551 
//  552 	int i = 0, tmp;
//  553     i = i;
//  554 	INT8U tCnt;
//  555 
//  556 	for(i = 0; i < 2; i++)  ///Test 필요 
//  557 	{
//  558 		if(++ADCIndex >= __ADCMAX) ADCIndex = ADC_Start;
//  559 		if((AdcEn.Data >> ADCIndex) & 0x01 )
//  560 		{
//  561 //			SerPtr->printf("0 : ADCIndex[%d][%d],[%d]\n",ADCIndex,ADC_WRCNT[ADCIndex],iAdcIndex );
//  562 
//  563 			if(++(ADC_WRCNT[ADCIndex]) >= __ADCAVR ) 
//  564 			{
//  565 				if(ADCIndex < 10)
//  566 				{
//  567 					tCnt = ADCIndex;
//  568 					chkADC_AVG[tCnt] = SET;
//  569 				}
//  570 				else
//  571 				{
//  572 					tCnt = ADCIndex + iAdcIndex*6;
//  573 					chkADC_AVG[tCnt] = SET;
//  574 				}
//  575 				
//  576 //				SerPtr->printf("1 : iAdcIndex[%d][%d] :ADCIndex[%d]\n",ADCIndex,tCnt,iAdcIndex);
//  577 //				if( ADC_WRCNT[15])
//  578 				if(ADCIndex == 15)
//  579 				{
//  580 					iAdcIndex = iAdcIndex + 1;
//  581 					if( iAdcIndex > 3) iAdcIndex = 0;
//  582 					ADC_Select(iAdcIndex);
//  583 					SerPtr->printf("2: iAdcIndex[%d][%d],\n",ADCIndex,iAdcIndex);
//  584 				}
//  585 				ADC_WRCNT[ADCIndex] = 0;
//  586 			}
//  587 			
//  588 			if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  589 			{
//  590 //				ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex]] = tmp;
//  591 
//  592 				if(ADCIndex < 10)
//  593 				{
//  594 //					tCnt = ADCIndex;
//  595 
//  596 					ADC_AVR[ADCIndex][tCnt] = tmp;
//  597 				}
//  598 				else
//  599 				{
//  600 //					tCnt = ADCIndex + iAdcIndex*6;
//  601 					ADC_AVR[ADCIndex][tCnt] = tmp;
//  602 				}
//  603 
//  604 				SerPtr->printf("3: ADC[%d][%d]:[%d],\n",ADCIndex,tCnt,ADC_AVR[ADCIndex][tCnt]);
//  605 			}
//  606 
//  607 
//  608 			for(i = ADC_Start; i <= __ADC_MAX; i++)
//  609 			{
//  610 				if(chkADC_AVG[i])
//  611 				{
//  612 //					ADC_DATA[i] 			= SelectSortSum(ADC_AVR[i],__ADCAVR,2,ADC_AvgSum);
//  613 					chkADC_AVG[i] = RESET;
//  614 					ADC_DATA[i] 			= ADC_AVR[i][0];
//  615 					SerPtr->printf("chkADC_AVG[%d][%d]:[%d],\n",i,chkADC_AVG[i],ADC_DATA[i]);
//  616 				}
//  617 			}
//  618 
//  619 
//  620 			
//  621 
//  622 #if 0
//  623 	if(chkADC_AVG1)
//  624 	{
//  625 		for(i = ADC_Start; i <= __ADCMAX; i++)
//  626 		{
//  627 			ADC_DATA[i] 			= SelectSortSum(ADC_AVR[i],__ADCAVR,2,ADC_AvgSum);
//  628 		}
//  629 		chkADC_AVG1 = RESET;
//  630 	}
//  631 #endif
//  632 
//  633 
//  634 #if 0
//  635 			{
//  636 				switch(ADCIndex)
//  637 				{
//  638 					case 0 :
//  639 					case 1 :
//  640 					case 2 :
//  641 					case 3 :
//  642 					case 4 :
//  643 					case 5 :
//  644 					case 6 :
//  645 					case 7 :
//  646 					case 8 :
//  647 					case 9 :
//  648 					case 10 :
//  649 						if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  650 						{
//  651 							int temp = 0;
//  652 
//  653 							temp = ADCIndex+ iAdcIndex;
//  654 
//  655 			//				ADC_AVR1[ADCIndex][ADC_WRCNT[ADCIndex]][iAdcIndex] = tmp;
//  656 							ADC_AVR[ADCIndex][ADC_WRCNT[temp]] = tmp;
//  657 						}
//  658 					break;
//  659 					case 11 :
//  660 					case 12 :
//  661 					case 13 :
//  662 					case 14 :
//  663 					case 15 :
//  664 					case 16 :
//  665 						if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  666 						{
//  667 							int temp = 0;
//  668 							temp = ADCIndex+ iAdcIndex;
//  669 							ADC_AVR[ADCIndex][ADC_WRCNT[temp]] = tmp;
//  670 							if(ADCIndex == 16) iAdcIndex++;
//  671 						}
//  672 					break;
//  673 					case 17 :
//  674 					case 18 :
//  675 					case 19 :
//  676 					case 20 :
//  677 					case 21 :
//  678 					case 22 :
//  679 						if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  680 						{
//  681 							int temp = 0;
//  682 							temp = ADCIndex+ iAdcIndex;
//  683 							ADC_AVR[ADCIndex][ADC_WRCNT[temp]] = tmp;
//  684 							if(ADCIndex == 16) iAdcIndex++;
//  685 						}
//  686 					break;
//  687 						
//  688 					case 23 :
//  689 					case 24 :
//  690 					case 25 :
//  691 					case 26 :
//  692 					case 27 :
//  693 					case 28 :
//  694 						if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  695 						{
//  696 							int temp = 0;
//  697 							temp = ADCIndex+ iAdcIndex;
//  698 							ADC_AVR[ADCIndex][ADC_WRCNT[temp]] = tmp;
//  699 							if(ADCIndex == 16) iAdcIndex++;
//  700 						}
//  701 					break;
//  702 						
//  703 					case 29 :
//  704 					case 30 :
//  705 					case 31 :
//  706 					case 32 :
//  707 					case 33 :
//  708 					case 34 :
//  709 						if( (tmp = GetAdcValue(ADCIndex)) >= 0 )
//  710 						{
//  711 							int temp = 0;
//  712 							temp = ADCIndex+ iAdcIndex;
//  713 							ADC_AVR[ADCIndex][ADC_WRCNT[temp]] = tmp;
//  714 							if(ADCIndex == 16) iAdcIndex = 0;
//  715 						}
//  716 					break;
//  717 				}
//  718 
//  719 			}
//  720 
//  721 
//  722 #endif
//  723 ////////////////
//  724 		}
//  725 
//  726 //		SerPtr->printf("i[%d]ADCIndex[%d]ADC_WRCNT[%d]:tmp[%d][%d]\n",i,ADCIndex,ADC_WRCNT[ADCIndex],
//  727 //			tmp,ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] );
//  728 	}
//  729 
//  730 
//  731 }
//  732 
//  733 
//  734 
//  735 
//  736 #endif
//  737 
//  738 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  739 INT16U GetAdcValue(INT8U channel)
//  740 {
//  741 	if(!ADC1->CR2.ADON) return 0;
GetAdcValue:
        LDR.N    R1,??DataTable11  ;; 0x40012400
        LDR      R2,[R1, #+8]
        TST      R2,#0x1
        BNE.N    ??GetAdcValue_0
??GetAdcValue_1:
        MOVS     R0,#+0
        BX       LR
//  742 	if(!ADC1->CR1.EOCIE)
??GetAdcValue_0:
        LDR      R2,[R1, #+4]
        TST      R2,#0x20
        BNE.N    ??GetAdcValue_1
//  743 	{
//  744 		ADC1->SQR3.SQ1 = channel;
        LDR      R2,[R1, #+52]
        MOVS     R3,#+31
        BICS     R2,R2,R3
        AND      R3,R0,#0x1F
        ORRS     R2,R3,R2
        STR      R2,[R1, #+52]
//  745 		ADC1->CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
        LDR      R2,[R1, #+8]
        ORR      R2,R2,#0x400000
        STR      R2,[R1, #+8]
//  746 		
//  747 		while(!ADC1->SR.EOC);
??GetAdcValue_2:
        LDR      R2,[R1, #+0]
        TST      R2,#0x2
        BEQ.N    ??GetAdcValue_2
        LDR.N    R2,??DataTable16  ;; ASTART
        ADD      R0,R2,R0, LSL #+1
        LDR      R1,[R1, #+76]
        STRH     R1,[R0, #+4]
//  748 		ADC_DATA[channel] = ADC1->DR;
//  749 		return ADC_DATA[channel];
        LDRH     R0,[R0, #+4]
        BX       LR               ;; return
//  750 	}
//  751 	return 0;
//  752 }
//  753 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  754 INT16S Get_AdcValue(INT8U channel)
//  755 {
//  756 	//if(!ADC1->CR2.ADON) return 0;
//  757 	if(!ADC1->CR1.EOCIE)
Get_AdcValue:
        LDR.N    R1,??DataTable11  ;; 0x40012400
        LDR      R2,[R1, #+4]
        TST      R2,#0x20
        BNE.N    ??Get_AdcValue_0
//  758 	{
//  759 		ADC1->SQR3.SQ1 = channel;
        LDR      R2,[R1, #+52]
        MOVS     R3,#+31
        BICS     R2,R2,R3
        AND      R0,R0,#0x1F
        ORRS     R0,R0,R2
        STR      R0,[R1, #+52]
//  760 		ADC1->CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
        LDR      R0,[R1, #+8]
        ORR      R0,R0,#0x400000
        STR      R0,[R1, #+8]
//  761 		
//  762 		while(!ADC1->SR.EOC);
??Get_AdcValue_1:
        LDR      R0,[R1, #+0]
        TST      R0,#0x2
        BEQ.N    ??Get_AdcValue_1
//  763 		ADC1->SR.EOC = 0;
        LDR      R0,[R1, #+0]
        BIC      R0,R0,#0x2
        STR      R0,[R1, #+0]
//  764 		return ADC1->DR;
        LDR      R0,[R1, #+76]
        SXTH     R0,R0
        BX       LR
//  765 	}
//  766 	return -1;
??Get_AdcValue_0:
        MOV      R0,#-1
        BX       LR               ;; return
//  767 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable11:
        DC32     0x40012400
//  768 
//  769 
//  770 #if 0
//  771 INT16S GetAdcValue(INT8U channel)
//  772 {
//  773 	//if(!ADC1->CR2.ADON) return 0;
//  774 	if(!ADC1->CR1.EOCIE)
//  775 	{
//  776 		ADC1->SQR3.SQ1 = channel;
//  777 		ADC1->CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
//  778 		
//  779 		while(!ADC1->SR.EOC);
//  780 		ADC1->SR.EOC = 0;
//  781 		return ADC1->DR;
//  782 	}
//  783 	return -1;
//  784 }
//  785 #endif
//  786 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  787 void GetAdcValueInt(INT8U channel)
//  788 {
GetAdcValueInt:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        LDR.N    R5,??DataTable16  ;; ASTART
//  789 	while(ASTART){ForDelay(1);}
        LDRB     R0,[R5, #+0]
        CBZ      R0,??GetAdcValueInt_0
??GetAdcValueInt_1:
        MOVS     R0,#+1
        BL       ForDelay
        LDRB     R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??GetAdcValueInt_1
//  790 	ForDelay(1);
??GetAdcValueInt_0:
        MOVS     R0,#+1
        BL       ForDelay
//  791 	ASTART = 1;
        MOVS     R0,#+1
        STRB     R0,[R5, #+0]
//  792 	ADC1->SQR3.SQ1 = channel;
        LDR.N    R0,??GetAdcValueInt_2  ;; 0x40012408
        LDR      R1,[R0, #+44]
        MOVS     R2,#+31
        BICS     R1,R1,R2
        AND      R2,R4,#0x1F
        ORRS     R1,R2,R1
        STR      R1,[R0, #+44]
//  793 	ADC1->CR2.SWSTART = ENABLE;		// ADC1->CONVERTER START
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x400000
        STR      R1,[R0, #+0]
//  794 }
        POP      {R0,R4,R5,PC}    ;; return
        Nop      
        DATA
??GetAdcValueInt_2:
        DC32     0x40012408
//  795 
//  796 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  797 INT16U AdctoVolt33V(INT16U Data)
//  798 {
AdctoVolt33V:
        PUSH     {R7,LR}
//  799 	double RetVal;
//  800 
//  801 	RetVal = ((((double)Data)*3300.0) / (1 << 12));
//  802     return (INT16U)RetVal;
        BL       __aeabi_ui2d
        MOVS     R2,#+0
        LDR.N    R3,??DataTable18  ;; 0x40a9c800
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.N    R3,??DataTable19  ;; 0x40b00000
        BL       __aeabi_ddiv
        BL       __aeabi_d2iz
        UXTH     R0,R0
        POP      {R1,PC}          ;; return
//  803 }
//  804 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  805 INT16U AdctoVolt5opamp(INT16U Data)
//  806 {
AdctoVolt5opamp:
        PUSH     {R3-R5,LR}
//  807 	double RetVal;
//  808 
//  809 	RetVal = (((((double)Data)*33*(665 + 340)) / (1 << 12))/(665.0));
        BL       __aeabi_ui2d
        MOVS     R2,#+0
        LDR.N    R3,??AdctoVolt5opamp_0  ;; 0x40408000
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.N    R3,??AdctoVolt5opamp_0+0x4  ;; 0x408f6800
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.N    R3,??DataTable19  ;; 0x40b00000
        BL       __aeabi_ddiv
        MOVS     R2,#+0
        LDR.N    R3,??AdctoVolt5opamp_0+0x8  ;; 0x4084c800
        BL       __aeabi_ddiv
        MOV      R4,R0
        MOV      R5,R1
//  810 
//  811 	if((int)(RetVal*100) >= 5) RetVal += 1;
        MOVS     R0,#+0
        LDR.N    R1,??AdctoVolt5opamp_0+0xC  ;; 0x40590000
        MOV      R2,R4
        MOV      R3,R5
        BL       __aeabi_dmul
        BL       __aeabi_d2iz
        CMP      R0,#+5
        BLT.N    ??AdctoVolt5opamp_1
        MOVS     R0,#+0
        LDR.N    R1,??AdctoVolt5opamp_0+0x10  ;; 0x3ff00000
        MOV      R2,R4
        MOV      R3,R5
        BL       __aeabi_dadd
        MOV      R4,R0
        MOV      R5,R1
//  812     return (INT16U)RetVal;
??AdctoVolt5opamp_1:
        MOV      R0,R4
        MOV      R1,R5
        BL       __aeabi_d2iz
        UXTH     R0,R0
        POP      {R1,R4,R5,PC}    ;; return
        Nop      
        DATA
??AdctoVolt5opamp_0:
        DC32     0x40408000
        DC32     0x408f6800
        DC32     0x4084c800
        DC32     0x40590000
        DC32     0x3ff00000
//  813 }
//  814 
//  815 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  816 void SwapData(INT16U *a, INT16U *b)
//  817 {
//  818 	INT16U temp = *a;
SwapData:
        LDRH     R2,[R0, #+0]
//  819 
//  820 	*a = *b;
        LDRH     R3,[R1, #+0]
        STRH     R3,[R0, #+0]
//  821 	
//  822 	*b = temp;
        STRH     R2,[R1, #+0]
//  823 }
        BX       LR               ;; return
//  824 
//  825 //#define GARBAGENO	2		// 버리는 값...
//  826 //#define GARBAGENO	10		// 버리는 값...
//  827 #define GARBAGENO	2		// 버리는 값...
//  828 // 
//  829 /*******************************************************************************
//  830 * Function Name  : ADC_IRQHandler
//  831 * Description    : 각 ADC값들을내림차순으로 정리하여, 낮은수치 몇개를 정리하여 높은수로만 평균값함..
//  832 *				   GARBAGENO: 버리는 낮은 값들.. 1이면 낮은값 1개를 버린다.
//  833 *
//  834 *					이 함수는 인터럽트 내에서 average를 취하지 않을 때,
//  835 *					메인 호출 함수 내에서 호출하여 사용한다.
//  836 * Input          : - aptr: 각 Channel의 ADC DATA들...(ADC_AVR)
//  837 * Output         : None
//  838 * Return         : 높은수 값들의 평균값.
//  839 * Example		 : ADC_DATA[ADC_Channel_0] = SelectSort(ADC_AVR[ADC_Channel_0]);
//  840 *******************************************************************************/
//  841 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  842 INT16U SelectSort(INT16U *aptr)
//  843 {
SelectSort:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+24
//  844 	INT16U tbuf[__ADCAVR];
//  845 	int sum = 0;
        MOVS     R5,#+0
//  846 	int i , j ;
//  847 
//  848 	for(i = 0; i < __ADCAVR; i++)
        ADD      R1,SP,#+0
        MOVS     R2,#+5
//  849 	{
//  850 		tbuf[i] = aptr[i];
??SelectSort_0:
        LDRH     R3,[R0], #+2
        STRH     R3,[R1, #+0]
//  851 		sum += tbuf[i];
        LDRH     R3,[R1], #+2
        ADDS     R3,R3,R5
        LDRH     R4,[R0], #+2
        STRH     R4,[R1, #+0]
        LDRH     R4,[R1], #+2
        ADDS     R5,R4,R3
//  852 	}
        SUBS     R2,R2,#+1
        BNE.N    ??SelectSort_0
//  853 
//  854 	for(i = 0 ; i < __ADCAVR - 1; i++)
        MOVS     R6,#+0
        ADD      R7,SP,#+0
//  855 	{
//  856 		for(j = i+1; j < __ADCAVR ; j++ )
??SelectSort_1:
        ADD      R0,SP,#+0
        ADD      R0,R0,R6, LSL #+1
        ADDS     R4,R0,#+2
        RSB      R0,R6,#+10
        SUB      R8,R0,#+1
//  857 		{
//  858 			if(tbuf[i] > tbuf[j])
??SelectSort_2:
        LDRH     R0,[R4, #+0]
        LDRH     R1,[R7, #+0]
        CMP      R0,R1
        BCS.N    ??SelectSort_3
//  859 			{
//  860 				SwapData( &tbuf[i] , &tbuf[j]) ;
        MOV      R1,R4
        MOV      R0,R7
        BL       SwapData
//  861 			}
//  862 		}
??SelectSort_3:
        ADDS     R4,R4,#+2
        SUBS     R8,R8,#+1
        BNE.N    ??SelectSort_2
//  863  	}
        ADDS     R6,R6,#+1
        ADDS     R7,R7,#+2
        CMP      R6,#+9
        BLT.N    ??SelectSort_1
//  864 	for(i = 0; i < GARBAGENO; i++)
//  865 	{
//  866 		sum -= tbuf[i];
//  867 	}
//  868 
//  869 	return (INT16U)(sum/(__ADCAVR-GARBAGENO));
        LDRH     R0,[SP, #+0]
        SUBS     R0,R5,R0
        LDRH     R1,[SP, #+2]
        SUBS     R0,R0,R1
        ASRS     R1,R0,#+2
        ADD      R0,R0,R1, LSR #+29
        LSLS     R0,R0,#+13
        LSRS     R0,R0,#+16
        ADD      SP,SP,#+24
        POP      {R4-R8,PC}       ;; return
//  870 }
//  871 
//  872 ////////////////////////////////////////////////
//  873 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  874 INT16U Select_Sort(INT16U *aptr,INT8U NUM,INT8U Index)
//  875 {
Select_Sort:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+20
        MOV      R11,R2
//  876 	INT16U tbuf[__ADCAVR];
//  877 	int sum = 0;
        MOV      R10,#+0
//  878 	int i , j ;
//  879 	int tmp = 0;
//  880 	
//  881 	for(i = 0; i < NUM; i++)
        CBZ      R1,??Select_Sort_0
        ADD      R2,SP,#+0
        MOV      R3,R1
//  882 	{
//  883 		tbuf[i] = aptr[i];
??Select_Sort_1:
        LDRH     R4,[R0], #+2
        STRH     R4,[R2], #+2
//  884 	}
        SUBS     R3,R3,#+1
        BNE.N    ??Select_Sort_1
//  885 
//  886 	for(i = 0 ; i < NUM - 1; i++)
??Select_Sort_0:
        MOV      R8,R10
        MOV      R4,R1
        SUBS     R6,R4,#+1
        CMP      R6,#+1
        BLT.N    ??Select_Sort_2
        ADD      R7,SP,#+0
//  887 	{
//  888 		for(j = i+1; j < NUM ; j++ )
??Select_Sort_3:
        ADD      R8,R8,#+1
        MOV      R9,R8
        CMP      R8,R4
        BGE.N    ??Select_Sort_4
        ADD      R0,SP,#+0
        ADD      R5,R0,R9, LSL #+1
//  889 		{
//  890 			if(tbuf[i] < tbuf[j])
??Select_Sort_5:
        LDRH     R0,[R7, #+0]
        LDRH     R1,[R5, #+0]
        CMP      R0,R1
        BCS.N    ??Select_Sort_6
//  891 			{
//  892 				SwapData( &tbuf[i] , &tbuf[j]) ;
        MOV      R1,R5
        MOV      R0,R7
        BL       SwapData
//  893 			}
//  894 		}
??Select_Sort_6:
        ADD      R9,R9,#+1
        ADDS     R5,R5,#+2
        CMP      R9,R4
        BLT.N    ??Select_Sort_5
//  895  	}
??Select_Sort_4:
        ADDS     R7,R7,#+2
        CMP      R8,R6
        BLT.N    ??Select_Sort_3
//  896 	for(i =  0; i < (NUM - Index); i++)
??Select_Sort_2:
        SUB      R0,R4,R11
        CMP      R0,#+1
        BLT.N    ??Select_Sort_7
        ADD      R1,SP,#+0
        MOV      R2,R0
//  897 	{
//  898 		sum += tbuf[i];
??Select_Sort_8:
        LDRH     R3,[R1], #+2
        ADD      R10,R3,R10
//  899 	}
        SUBS     R2,R2,#+1
        BNE.N    ??Select_Sort_8
//  900 	tmp = (INT16U)(sum/(NUM-Index));
//  901 
//  902 	return tmp;
??Select_Sort_7:
        SDIV     R0,R10,R0
        UXTH     R0,R0
        ADD      SP,SP,#+20
        POP      {R4-R11,PC}      ;; return
//  903 }
//  904 #if 1
//  905 ///NUM = 10, Index = 2

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  906 INT16U SelectSortSum(INT16U *aptr,INT8U NUM,INT8U Index,INT8U Type)
//  907 {
SelectSortSum:
        PUSH     {R3-R7,R9-R11,LR}
        PUSH     {R0,R2,R3}
        MOV      R4,R1
//  908 	int Sum = 0;
        MOV      R11,#+0
//  909 	int i , j ;
//  910 
//  911 	int CurrAvg = 0;
        MOVS     R6,#+0
//  912 	
//  913 	for(i = 0 ; i < NUM ; i++)
        MOV      R5,R11
        CBZ      R4,??SelectSortSum_0
        MOV      R7,R0
//  914 	{
//  915 		for(j = i+1; j < NUM ; j++ )
??SelectSortSum_1:
        ADDS     R5,R5,#+1
        MOV      R9,R5
        CMP      R5,R4
        BGE.N    ??SelectSortSum_2
        LDR      R0,[SP, #+0]
        ADD      R10,R0,R9, LSL #+1
//  916 		{
//  917 			if(aptr[i] > aptr[j])
??SelectSortSum_3:
        LDRH     R0,[R10, #+0]
        LDRH     R1,[R7, #+0]
        CMP      R0,R1
        BCS.N    ??SelectSortSum_4
//  918 			{
//  919 				SwapData( &aptr[i] , &aptr[j]) ;
        MOV      R1,R10
        MOV      R0,R7
        BL       SwapData
//  920 			}
//  921 //			ForDelay(1);
//  922 		}
??SelectSortSum_4:
        ADD      R9,R9,#+1
        ADD      R10,R10,#+2
        CMP      R9,R4
        BLT.N    ??SelectSortSum_3
//  923 //		ForDelay(1);
//  924 	}
??SelectSortSum_2:
        ADDS     R7,R7,#+2
        CMP      R5,R4
        BLT.N    ??SelectSortSum_1
//  925 
//  926 	for(i = 0; i < NUM; i++)
//  927 	{
//  928 //		SerPtr->printf("AD 2 :[%d][%d]\n",i,aptr[i]);
//  929 	}
//  930 
//  931 
//  932 	
//  933 	if(Type == ADC_AvgSum)
??SelectSortSum_0:
        LDRB     R0,[SP, #+8]
        CBNZ     R0,??SelectSortSum_5
//  934 	{
//  935 		for(i =  Index; i < (NUM - Index); i++)
        LDRB     R0,[SP, #+4]
        MOV      R5,R0
        SUBS     R1,R4,R0
        CMP      R0,R1
        BGE.N    ??SelectSortSum_6
        LDR      R2,[SP, #+0]
        ADD      R2,R2,R5, LSL #+1
//  936 		{
//  937 			Sum += aptr[i];
??SelectSortSum_7:
        LDRH     R3,[R2], #+2
        ADD      R11,R3,R11
//  938 		}
        ADDS     R5,R5,#+1
        CMP      R5,R1
        BLT.N    ??SelectSortSum_7
//  939 		CurrAvg = (INT16U)(Sum/(NUM-(Index*2)));
??SelectSortSum_6:
        SUB      R0,R4,R0, LSL #+1
??SelectSortSum_8:
        SDIV     R6,R11,R0
        UXTH     R6,R6
//  940 //		ForDelay(1);
//  941 	}
//  942 	else if(Type == ADC_PeakSum)
//  943 	{
//  944 		for(i =  0; i < (NUM - Index); i++)
//  945 		{
//  946 			Sum += aptr[i];
//  947 		}
//  948 		CurrAvg = (INT16U)(Sum/(NUM-Index));
//  949 //		ForDelay(1);
//  950 	}
//  951 	else if(Type == ADC_MinSum)
//  952 	{
//  953 		for(i = (NUM - 1); i > (Index -1); i--)
//  954 		{
//  955 			Sum += aptr[i];
//  956 		}
//  957 		CurrAvg = (INT16U)(Sum/(NUM-Index));
//  958 //		ForDelay(1);
//  959 	}
//  960 	return (INT16U)CurrAvg;
??SelectSortSum_9:
        MOV      R0,R6
        ADD      SP,SP,#+16
        POP      {R4-R7,R9-R11,PC}  ;; return
??SelectSortSum_5:
        CMP      R0,#+1
        BNE.N    ??SelectSortSum_10
        LDRB     R0,[SP, #+4]
        SUBS     R1,R4,R0
        CMP      R1,#+1
        BLT.N    ??SelectSortSum_11
        LDR      R0,[SP, #+0]
??SelectSortSum_12:
        LDRH     R2,[R0], #+2
        ADD      R11,R2,R11
        SUBS     R1,R1,#+1
        BNE.N    ??SelectSortSum_12
??SelectSortSum_11:
        LDRB     R0,[SP, #+4]
        SUBS     R0,R4,R0
        B.N      ??SelectSortSum_8
??SelectSortSum_10:
        CMP      R0,#+2
        BNE.N    ??SelectSortSum_9
        SUBS     R5,R4,#+1
        LDRB     R0,[SP, #+4]
        SUBS     R0,R0,#+1
        CMP      R0,R5
        BGE.N    ??SelectSortSum_11
        LDR      R1,[SP, #+0]
        ADD      R1,R1,R5, LSL #+1
??SelectSortSum_13:
        LDRH     R2,[R1], #-2
        ADD      R11,R2,R11
        SUBS     R5,R5,#+1
        CMP      R0,R5
        BGE.N    ??SelectSortSum_11
        B.N      ??SelectSortSum_13
//  961 }
//  962 #endif
//  963 
//  964 
//  965 /*******************************************************************************
//  966 * Function Name  : ADC_IRQHandler
//  967 * Description    : Enables or disables the selected ADC software start conversion .
//  968 * Input          : - ADCx: where x can be 1, 2 or 3 to select the ADC peripheral.
//  969 *                  - NewState: new state of the selected ADC software start conversion.
//  970 *                    This parameter can be: ENABLE or DISABLE.
//  971 * Output         : None
//  972 * Return         : None
//  973 *******************************************************************************/
//  974 #if 0
//  975 void ADC_IRQHandler(void)
//  976 {
//  977 	INT32U cpu_sr;
//  978 
//  979 	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
//  980 	OSIntNesting++;
//  981 	CPU_CRITICAL_EXIT();
//  982 
//  983 	//ADC1->CR2.Bit.SWSTART = 0;		// ADC1->CONVERTER START
//  984 	//ADC1->SR.Bit.EOC = 0;
//  985 	
//  986 	ADC_SUM[ADCIndex] -= ADC_AVR[ADCIndex][ADCSubIndex];
//  987 	// Get injected channel10 and channel11 converted value
//  988 	ADC_AVR[ADCIndex][ADCSubIndex] = ADC1->DR;
//  989 	ADC_SUM[ADCIndex] += ADC_AVR[ADCIndex][ADCSubIndex];
//  990 	ADC_DATA[ADCIndex] = ADC_SUM[ADCIndex]/__ADCAVR;
//  991 
//  992 	if(++ADCIndex >= __ADCMAX )
//  993 	{
//  994 		if(++ADCSubIndex >= __ADCAVR ) ADCSubIndex = 0;
//  995 		ADCIndex = 0;
//  996 	}
//  997 	if(DAC->CR.B.EN1 && (ADCIndex == 4)) ADCIndex++; //USART1PutChar('1');}
//  998 	if(DAC->CR.B.EN2 && (ADCIndex == 5)) ADCIndex++; //USART1PutChar('2');}
//  999 
// 1000 	//if(ADCIndex == 4 || ADCIndex == 5)USART1PutChar('2');
// 1001 	ADC1->SQR3.SQ1 = ADCIndex;
// 1002 	//ADC1->CR2.Bit.SWSTART = SET;		// ADC1->CONVERTER START
// 1003 	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
// 1004 }
// 1005 #endif
// 1006 #if 1

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1007 void ADC_IRQHandler(void)
// 1008 {
ADC_IRQHandler:
        PUSH     {R4,LR}
// 1009 
// 1010 	INT32U cpu_sr;
// 1011 
// 1012 	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
        BL       CPU_SR_Save
// 1013 	OSIntNesting++;
        LDR.N    R1,??ADC_IRQHandler_0  ;; OSIntNesting
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
// 1014 	CPU_CRITICAL_EXIT();
        BL       CPU_SR_Restore
// 1015 #ifdef ADC_AVER
// 1016 	// Get injected channel10 and channel11 converted value
// 1017 	ADC_SUM[ADCIndex] -= ADC_DATA[ADCIndex];
// 1018 	ADC_SUM[ADCIndex] += ADC1->DR;
        LDR.N    R0,??DataTable16  ;; ASTART
        LDRB     R1,[R0, #+1]
        ADD      R0,R0,R1, LSL #+1
        LDR.N    R2,??ADC_IRQHandler_0+0x4  ;; ADC_SUM
        LDR      R3,[R2, R1, LSL #+2]
        LDRH     R4,[R0, #+4]
        SUBS     R3,R3,R4
        LDR.N    R4,??ADC_IRQHandler_0+0x8  ;; 0x4001244c
        LDR      R4,[R4, #+0]
        ADDS     R3,R4,R3
        STR      R3,[R2, R1, LSL #+2]
// 1019     ADC_DATA[ADCIndex] = ADC_SUM[ADCIndex]/__ADCAVR;
        MOVS     R1,#+10
        UDIV     R1,R3,R1
        STRH     R1,[R0, #+4]
// 1020 #else
// 1021 	ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = ADC1->DR;
// 1022 	ASTART = 0;
// 1023 #endif
// 1024 	OSIntExit();											// Tell uC/OS-II that we are leaving the ISR
        POP      {R4,LR}
        B.W      OSIntExit
        Nop      
        DATA
??ADC_IRQHandler_0:
        DC32     OSIntNesting
        DC32     ADC_SUM
        DC32     0x4001244c
// 1025 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable16:
        DC32     ASTART
// 1026 #endif
// 1027 
// 1028 #if 0
// 1029 int  ReadEnvTempTable(void)
// 1030 {
// 1031 	int __tC = ((ADC_DATA[ADC_Channel_16]*33*100*10)/((1<<12)-1));
// 1032 
// 1033 	__tC = (14000 - __tC);
// 1034 	__tC = (__tC*1000)/4478 + 250;
// 1035 
// 1036 	return __tC;
// 1037 }
// 1038 #endif
// 1039 #if 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1040 int ReadEnvTempTable(int channel)
// 1041 {
ReadEnvTempTable:
        PUSH     {R7,LR}
// 1042 //	INT32S tmpx10 = AdctoVolt33V(ADC_DATA[channel]);
// 1043 	INT32S tmpx10 = AdctoVolt33V(ADC_DATA1[channel]);
// 1044 
// 1045 	tmpx10 = (tmpx10 - 500);
// 1046 
// 1047 	return tmpx10;	// 10배 값이 return 된다. 
        LDR.N    R1,??DataTable17  ;; ADC_DATA1
        LDRH     R0,[R1, R0, LSL #+1]
        BL       __aeabi_ui2d
        MOVS     R2,#+0
        LDR.N    R3,??DataTable18  ;; 0x40a9c800
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.N    R3,??DataTable19  ;; 0x40b00000
        BL       __aeabi_ddiv
        BL       __aeabi_d2iz
        UXTH     R0,R0
        SUB      R0,R0,#+500
        POP      {R1,PC}          ;; return
// 1048 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     ADC_DATA1

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable18:
        DC32     0x40a9c800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable19:
        DC32     0x40b00000

        END
// 1049 #endif
// 1050 
// 1051 /******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
// 
//   941 bytes in section .bss
//     2 bytes in section .data
// 2 120 bytes in section .text
//   884 bytes in section iram
// 
// 2 120 bytes of CODE memory
// 1 827 bytes of DATA memory
//
//Errors: none
//Warnings: none
