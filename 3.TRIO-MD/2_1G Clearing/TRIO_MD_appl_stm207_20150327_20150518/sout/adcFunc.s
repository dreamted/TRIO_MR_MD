///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    23/Aug/2012  00:33:41 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\adcFun /
//                    c.c                                                     /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\adcFun /
//                    c.c -lcN C:\user\project\FR-SSR\fw\appl_ssr_20120717\so /
//                    ut\ -lB C:\user\project\FR-SSR\fw\appl_ssr_20120717\sou /
//                    t\ -o C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\ /
//                     --endian=little --cpu=Cortex-M3 -e                     /
//                    --require_prototypes --fpu=None --dlib_config           /
//                    "C:\compiler\ewarm 5.5\arm\INC\DLib_Config_Normal.h"    /
//                    -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\include\ /
//                     -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\lib_stm /
//                    32\inc\ -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\ /
//                    lib_stm32\src\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uC-CPU\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uC-LIB\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uCOS-II\Ports\ -I C:\user\project\FR-SSR\fw\appl /
//                    _ssr_20120717\uCOS-II\Source\ -I                        /
//                    C:\user\project\FR-SSR\fw\appl_ssr_20120717\uC-Probe\   /
//                    -I "C:\compiler\ewarm 5.5\arm\INC\" -Oh                 /
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\adcFun /
//                    c.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME adcFunc

        EXTERN CPU_SR_Restore
        EXTERN CPU_SR_Save
        EXTERN NVIC_Init
        EXTERN OSIntExit
        EXTERN OSIntNesting
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save

        PUBLIC ADC1_SWStart
        PUBLIC ADCIndex
        PUBLIC ADCInit
        PUBLIC ADCSTART
        PUBLIC ADC_AVR
        PUBLIC ADC_AVR_VALUE0
        PUBLIC ADC_AVR_VALUE1
        PUBLIC ADC_AVR_VALUE15
        PUBLIC ADC_AVR_VALUE4
        PUBLIC ADC_AVR_VALUE5
        PUBLIC ADC_ChannelEnable
        PUBLIC ADC_CheckFinish
        PUBLIC ADC_DATA
        PUBLIC ADC_IRQHandler
        PUBLIC ADC_SUM
        PUBLIC ADC_WRCNT
        PUBLIC ASTART
        PUBLIC AdcEn
        PUBLIC AdctoVolt33V
        PUBLIC AdctoVolt5opamp
        PUBLIC ReadEnvTempTable
        PUBLIC SelectSort
        PUBLIC SelectSortMax
        PUBLIC SwapData

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\adcFunc.c
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

        SECTION `.rodata`:CONST:NOROOT(2)
// __absolute INT32U const AdcEn
AdcEn:
        DATA
        DC32 32819

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT16U ADC_AVR_VALUE0[150]
ADC_AVR_VALUE0:
        DS8 300

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT16U ADC_AVR_VALUE1[150]
ADC_AVR_VALUE1:
        DS8 300

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT16U ADC_AVR_VALUE4[150]
ADC_AVR_VALUE4:
        DS8 300

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT16U ADC_AVR_VALUE5[150]
ADC_AVR_VALUE5:
        DS8 300

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT16U ADC_AVR_VALUE15[150]
ADC_AVR_VALUE15:
        DS8 300

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT16U ADC_DATA[16]
ADC_DATA:
        DS8 32

        SECTION `.bss`:DATA:NOROOT(2)
// __absolute INT32U ADC_SUM[16]
ADC_SUM:
        DS8 64

        SECTION `.data`:DATA:NOROOT(2)
// __absolute INT8U ADCIndex
ADCIndex:
        DATA
        DC8 0
// __absolute INT8U ASTART
ASTART:
        DC8 0
        DC8 0, 0
// __absolute INT8U ADCSTART[16]
ADCSTART:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __absolute INT16U ADC_WRCNT[16]
ADC_WRCNT:
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
// __absolute unsigned short *__data ADC_AVR[16]
ADC_AVR:
        DC32 ADC_AVR_VALUE0, ADC_AVR_VALUE1, 0H, 0H, ADC_AVR_VALUE4
        DC32 ADC_AVR_VALUE5, 0H, 0H, 0H, 0H, 0H, 0H, 0H, 0H, 0H
        DC32 ADC_AVR_VALUE15
//   12 
//   13 #define ADC_AUTO_SCAN_ONE_TIME
//   14 //#define ADC_AVER
//   15 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   16 void ADCInit(int INT_EN)
//   17 {
ADCInit:
        PUSH     {R4-R6,LR}
        MOV      R6,R0
//   18 	INT32U cpu_sr;
//   19 	
//   20 	ADC_TypeDef *ADCx = ADC1;
//   21 
//   22 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R4,R0
//   23 
//   24 	ADCIndex = 0;
        LDR.N    R0,??DataTable4
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   25 	ASTART = 0;
        STRB     R1,[R0, #+1]
//   26 
//   27 	ADCx->SQR1.L = 0;	// 1EA
        LDR.N    R5,??DataTable4_1  ;; 0x40012404
        LDR      R0,[R5, #+40]
        BIC      R0,R0,#0xF00000
        STR      R0,[R5, #+40]
//   28 	ADCx->SQR3.SQ1 = 0; // Start Zer0
        LDR      R0,[R5, #+48]
        LSRS     R0,R0,#+5
        LSLS     R0,R0,#+5
        STR      R0,[R5, #+48]
//   29 
//   30 	NVIC_Init(ADC_IRQChannel, INT_EN);
        MOV      R1,R6
        MOVS     R0,#+18
        BL       NVIC_Init
//   31 	
//   32 	// ADC1 regular channel14 configuration
//   33 	ADCx->SMPR1.Data = 0x00FFFFFF;		// ADC_SampleTime_239Cycles5
        MVN      R0,#-16777216
        STR      R0,[R5, #+8]
//   34 	ADCx->SMPR2.Data = 0x3FFFFFFF;		// ADC_SampleTime_239Cycles5
        MVN      R0,#-1073741824
        STR      R0,[R5, #+12]
//   35 
//   36 	// ADC1 configuration
//   37 	ADCx->CR1.DUALMOD = __dMODE_INDEPENDENT;
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0xF0000
        STR      R0,[R5, #+0]
//   38 	ADCx->CR1.SCAN = DISABLE;
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0x100
        STR      R0,[R5, #+0]
//   39 	ADCx->CR1.EOCIE = INT_EN;		// interrupt enable
        LDR      R0,[R5, #+0]
        BFI      R0,R6,#+5,#+1
        STR      R0,[R5, #+0]
//   40 	ADCx->CR2.CONT = DISABLE;
        LDR      R0,[R5, #+4]
        BIC      R0,R0,#0x2
        STR      R0,[R5, #+4]
//   41 	ADCx->CR2.ALIGN = __ALI_Right;
        LDR      R0,[R5, #+4]
        BIC      R0,R0,#0x800
        STR      R0,[R5, #+4]
//   42 	ADCx->CR2.EXTSEL = __SWSTART;
        LDR      R0,[R5, #+4]
        ORR      R0,R0,#0xE0000
        STR      R0,[R5, #+4]
//   43 	ADCx->CR2.DMAMODE = DISABLE;
        LDR      R0,[R5, #+4]
        BIC      R0,R0,#0x100
        STR      R0,[R5, #+4]
//   44 	ADCx->CR2.EXTTRIG = ENABLE;
        LDR      R0,[R5, #+4]
        ORR      R0,R0,#0x100000
        STR      R0,[R5, #+4]
//   45 	ADCx->CR2.TSVREFE = ENABLE; 	// temperature sensor enable
        LDR      R0,[R5, #+4]
        ORR      R0,R0,#0x800000
        STR      R0,[R5, #+4]
//   46 	ADCx->CR2.ADON = ENABLE;		// Enable ADC1
        LDR      R0,[R5, #+4]
        ORR      R0,R0,#0x1
        STR      R0,[R5, #+4]
//   47 
//   48 	// Enable ADC1 reset calibaration register
//   49 	{
//   50 		INT16U rtry = 0xffff;
        MOVW     R0,#+65535
        MOV      R1,R0
//   51 	
//   52 		ADCx->CR2.RSTCAL = SET;
        LDR      R2,[R5, #+4]
        ORR      R2,R2,#0x8
        STR      R2,[R5, #+4]
//   53 		while((rtry--) && ADCx->CR2.RSTCAL);
??ADCInit_0:
        MOV      R2,R1
        SUBS     R1,R2,#+1
        UXTH     R2,R2
        CBZ.N    R2,??ADCInit_1
        LDR      R2,[R5, #+4]
        LSLS     R2,R2,#+28
        BMI.N    ??ADCInit_0
//   54 	}
//   55 	// Start ADC1 calibaration
//   56 	{
//   57 		INT16U rtry = 0xffff;
//   58 	
//   59 		ADCx->CR2.CAL = SET;
??ADCInit_1:
        LDR      R1,[R5, #+4]
        ORR      R1,R1,#0x4
        STR      R1,[R5, #+4]
//   60 		while((rtry--) && ADCx->CR2.CAL);
??ADCInit_2:
        MOV      R1,R0
        SUBS     R0,R1,#+1
        UXTH     R1,R1
        CBZ.N    R1,??ADCInit_3
        LDR      R1,[R5, #+4]
        LSLS     R1,R1,#+29
        BMI.N    ??ADCInit_2
//   61 	}
//   62 	// Start ADC1 Software Conversion
//   63 	OS_EXIT_CRITICAL();
??ADCInit_3:
        MOV      R0,R4
        POP      {R4-R6,LR}
        B.W      OS_CPU_SR_Restore
//   64 }
//   65 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   66 INT8U ADC_CheckFinish(INT8U channel)
//   67 {
//   68 	//SerPtr->printf("c111: %d, ADCSTART = %d\n", channel, ADCSTART[channel]);
//   69 	if(ADCSTART[channel] == ADCFINISH) return TRUE;
ADC_CheckFinish:
        LDR.N    R1,??DataTable4
        ADDS     R0,R0,R1
        LDRB     R0,[R0, #+4]
        CMP      R0,#+2
        BNE.N    ??ADC_CheckFinish_0
        MOVS     R0,#+1
        BX       LR
//   70 	return FALSE;
??ADC_CheckFinish_0:
        MOVS     R0,#+0
        BX       LR               ;; return
//   71 }
//   72 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   73 void ADC_ChannelEnable(INT8U channel)
//   74 {
//   75 	ADCSTART[channel] = ADCIDLE;
ADC_ChannelEnable:
        LDR.N    R1,??DataTable4
        ADDS     R0,R0,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
//   76 }
        BX       LR               ;; return
//   77 
//   78 
//   79 /*******************************************************************************
//   80 * Function Name  : ADC1_SWStart
//   81 * Description    : get ADC Value directly(only case no_interrupt mode
//   82 *                  group channel.
//   83 * Input          : - channel: where x can be 1 or 2 to select the ADC channel
//   84 * Output         : None
//   85 * Return         : - direct ADCx channel 12 bit value
//   86 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   87 void ADC1_SWStart(void)
//   88 {
ADC1_SWStart:
        PUSH     {R4-R7}
//   89 #ifdef ADC_AUTO_SCAN_ONE_TIME
//   90 
//   91     int i;
//   92 
//   93 	if(ADC1->CR1.EOCIE && ASTART == RESET)
        LDR.N    R0,??DataTable4_1  ;; 0x40012404
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+26
        BPL.N    ??ADC1_SWStart_0
        LDR.N    R1,??DataTable4
        LDRB     R2,[R1, #+1]
        CBNZ.N   R2,??ADC1_SWStart_0
//   94 	{
//   95 		for(i = 0; i < __ADCMAX ; i++)
        MOVS     R3,#+0
        MOVW     R4,#+32819
//   96 		{
//   97 			ADCIndex++;
//   98 			ADCIndex %= __ADCMAX;
??ADC1_SWStart_1:
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        AND      R2,R2,#0xF
        STRB     R2,[R1, #+0]
//   99 
//  100 			if(((AdcEn >> ADCIndex) & 0x01) && ADCSTART[ADCIndex] == ADCIDLE)
        LSR      R5,R4,R2
        LSLS     R5,R5,#+31
        BPL.N    ??ADC1_SWStart_2
        ADDS     R6,R2,R1
        LDRB     R7,[R6, #+4]
        CBNZ.N   R7,??ADC1_SWStart_2
//  101 			{
//  102 				ADC_WRCNT[ADCIndex] = 0;
        ADD      R3,R1,R2, LSL #+1
        MOVS     R4,#+0
        STRH     R4,[R3, #+20]
//  103 				ASTART = SET;
        MOVS     R3,#+1
        STRB     R3,[R1, #+1]
//  104 
//  105 				ADCSTART[ADCIndex] = ADCING;
        STRB     R3,[R6, #+4]
//  106 				ADC1->SQR3.SQ1 = ADCIndex;
        LDR      R1,[R0, #+48]
        BFI      R1,R2,#+0,#+5
        STR      R1,[R0, #+48]
//  107 				ADC1->CR2.SWSTART = ENABLE;
        LDR      R1,[R0, #+4]
        ORR      R1,R1,#0x400000
        STR      R1,[R0, #+4]
//  108 				break;
        B.N      ??ADC1_SWStart_0
//  109 			}
//  110 		}
??ADC1_SWStart_2:
        ADDS     R3,R3,#+1
        CMP      R3,#+16
        BLT.N    ??ADC1_SWStart_1
//  111 	}
//  112 
//  113 #else    /////////////////////////////////////// #else(ADC_AUTO_SCAN_ONE_TIME)
//  114 	int i = 0;
//  115 
//  116 #ifndef ADC_AVER
//  117 	while(ASTART){ ForDelay(1); }
//  118 #endif
//  119 	if(ADC1->CR1.EOCIE)
//  120 	{
//  121 		for(i = 0; i < __ADCMAX	; i++)
//  122 		{
//  123 			ADCIndex++;
//  124 			ADCIndex %= __ADCMAX;
//  125 
//  126 			if((AdcEn.Data >> ADCIndex) & 0x01 )
//  127 			{
//  128 #ifndef ADC_AVER
//  129 				ADC_WRCNT[ADCIndex]++;
//  130 				ADC_WRCNT[ADCIndex] %= __ADCAVR;
//  131 #endif
//  132 				break;
//  133 			}
//  134 		}
//  135 		ADC1->SQR3.SQ1 = ADCIndex;
//  136 		ADC1->CR2.SWSTART = ENABLE;
//  137 	}
//  138 #endif	/////////////////////////////////////// #endif(ADC_AUTO_SCAN_ONE_TIME)
//  139 	
//  140 }
??ADC1_SWStart_0:
        POP      {R4-R7}
        BX       LR               ;; return
//  141 
//  142 
//  143 // Return Value는 1000배가 곱한 값이다. ex) 3.403[V]->3403 return 됨..
//  144 // 12bit Value
//  145 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  146 INT16U AdctoVolt33V(INT16U Data)
//  147 {
//  148 	INT32U RetVal;
//  149 
//  150 	RetVal = (((Data)*3300) / (1 << 12));
//  151     return (INT16U)RetVal;
AdctoVolt33V:
        MOVW     R1,#+3300
        MULS     R0,R1,R0
        ASRS     R1,R0,#+11
        ADD      R0,R0,R1, LSR #+20
        B.N      ?Subroutine0
//  152 }
//  153 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  154 INT16U AdctoVolt5opamp(INT16U Data)
//  155 {
//  156 	INT32U  RetVal;
//  157 
//  158 	RetVal = ( (((INT32U)(Data)*3300)/665 )*(665 + 340))/(1 << 12);
//  159 
//  160     return (INT16U)RetVal;
AdctoVolt5opamp:
        MOVW     R1,#+3300
        MULS     R0,R1,R0
        MOVW     R1,#+665
        UDIV     R0,R0,R1
        MOVW     R1,#+1005
        MULS     R0,R1,R0
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  161 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        LSLS     R0,R0,#+4
        LSRS     R0,R0,#+16
        BX       LR               ;; return
//  162 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  163 void SwapData(INT16U *a, INT16U *b)
//  164 {
//  165 	INT16U temp = *a;
SwapData:
        LDRH     R2,[R0, #+0]
//  166 
//  167 	*a = *b;
        LDRH     R3,[R1, #+0]
        STRH     R3,[R0, #+0]
//  168 	
//  169 	*b = temp;
        STRH     R2,[R1, #+0]
//  170 }
        BX       LR               ;; return
//  171 
//  172 
//  173 //
//  174 
//  175 /*******************************************************************************
//  176 * Function Name  : ADC_IRQHandler
//  177 * Description    : 각 ADC값들을내림차순으로 정리하여, 낮은수치 몇개를 정리하여 높은수로만 평균값함..
//  178 *				   GARBAGENO: 버리는 낮은 값들.. 1이면 낮은값 1개를 버린다.
//  179 *
//  180 *					이 함수는 인터럽트 내에서 average를 취하지 않을 때,
//  181 *					메인 호출 함수 내에서 호출하여 사용한다.
//  182 * Input          : - aptr: 각 Channel의 ADC DATA들...(ADC_AVR)
//  183 * Output         : None
//  184 * Return         : 높은수 값들의 평균값.
//  185 * Example		 : ADC_DATA[ADC_Channel_0] = SelectSort(ADC_AVR[ADC_Channel_0]);
//  186 *******************************************************************************/
//  187 
//  188 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  189 INT16U SelectSortMax(INT16U *aptr, INT16U nlen)
//  190 {
SelectSortMax:
        PUSH     {R4-R10,LR}
        MOV      R8,R0
        MOV      R7,R1
//  191 	int i, j ;
//  192 
//  193 	if(nlen > __ADCAVR) nlen = __ADCAVR;
        CMP      R7,#+151
        IT       CS 
        MOVCS    R7,#+150
//  194 
//  195 	for(i = 0 ; i < nlen - 1; i++)
        MOV      R10,#+0
        SUBS     R5,R7,#+1
        CMP      R5,#+1
        BLT.N    ??SelectSortMax_0
        MOV      R6,R8
//  196 	{
//  197 
//  198 		for(j = i+1; j < nlen; j++ )
??SelectSortMax_1:
        ADD      R10,R10,#+1
        MOV      R9,R10
        CMP      R10,R7
        BGE.N    ??SelectSortMax_2
        ADD      R4,R8,R9, LSL #+1
//  199 		{
//  200 			if(aptr[i] > aptr[j])
??SelectSortMax_3:
        LDRH     R0,[R4, #+0]
        LDRH     R1,[R6, #+0]
        CMP      R0,R1
        BCS.N    ??SelectSortMax_4
//  201 			{
//  202 				SwapData( &aptr[i] , &aptr[j]) ;
        MOV      R1,R4
        MOV      R0,R6
        BL       SwapData
//  203 			}
//  204 		}
??SelectSortMax_4:
        ADD      R9,R9,#+1
        ADDS     R4,R4,#+2
        CMP      R9,R7
        BLT.N    ??SelectSortMax_3
//  205  	}
??SelectSortMax_2:
        ADDS     R6,R6,#+2
        CMP      R10,R5
        BLT.N    ??SelectSortMax_1
//  206 	return aptr[nlen-1];
??SelectSortMax_0:
        ADD      R0,R8,R7, LSL #+1
        LDRH     R0,[R0, #-2]
        POP      {R4-R10,PC}      ;; return
//  207 }
//  208 
//  209 
//  210 /*******************************************************************************
//  211 * Function Name  : ADC_IRQHandler
//  212 * Description    : 각 ADC값들을내림차순으로 정리하여, 낮은수치 몇개를 정리하여 높은수로만 평균값함..
//  213 *				   GARBAGENO: 버리는 낮은 값들.. 1이면 낮은값 1개를 버린다.
//  214 *
//  215 *					이 함수는 인터럽트 내에서 average를 취하지 않을 때,
//  216 *					메인 호출 함수 내에서 호출하여 사용한다.
//  217 * Input          : - aptr: 각 Channel의 ADC DATA들...(ADC_AVR)
//  218 * Output         : None
//  219 * Return         : 높은수 값들의 평균값.
//  220 * Example		 : ADC_DATA[ADC_Channel_0] = SelectSort(ADC_AVR[ADC_Channel_0]);
//  221 *******************************************************************************/
//  222 
//  223 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 INT16U SelectSort(INT16U *aptr, INT16U MAXGARBAGENO, INT16U MINGARBAGENO, INT16U nlen)
//  225 {
SelectSort:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+308
        MOV      R5,R1
        MOV      R8,R2
//  226 	int sum = 0;
        MOV      R9,#+0
//  227 	int i , j ;
//  228 	INT32U sumtotal;
//  229 	INT16U tbuf[__ADCAVR];
//  230 
//  231 	if(nlen > __ADCAVR) nlen = __ADCAVR;
        CMP      R3,#+151
        IT       CS 
        MOVCS    R3,#+150
        BCS.N    ??SelectSort_0
//  232 
//  233 	for(i = 0; i < nlen; i++)
        CBZ.N    R3,??SelectSort_1
??SelectSort_0:
        ADD      R1,SP,#+4
        MOV      R2,R3
//  234 	{
//  235 		tbuf[i] = aptr[i];
??SelectSort_2:
        LDRH     R4,[R0], #+2
        STRH     R4,[R1], #+2
//  236 		sumtotal += aptr[i]; 
//  237 	}
        SUBS     R2,R2,#+1
        BNE.N    ??SelectSort_2
//  238 
//  239 	for(i = 0 ; i < nlen - 1; i++)
??SelectSort_1:
        MOV      R11,R9
        MOV      R4,R3
        SUBS     R0,R4,#+1
        STR      R0,[SP, #+0]
        CMP      R0,#+1
        BLT.N    ??SelectSort_3
        ADD      R6,SP,#+4
//  240 	{
//  241 
//  242 		for(j = i+1; j < nlen; j++ )
??SelectSort_4:
        ADD      R11,R11,#+1
        MOV      R10,R11
        CMP      R11,R4
        BGE.N    ??SelectSort_5
        ADD      R0,SP,#+4
        ADD      R7,R0,R10, LSL #+1
//  243 		{
//  244 			if(tbuf[i] > tbuf[j])
??SelectSort_6:
        LDRH     R0,[R7, #+0]
        LDRH     R1,[R6, #+0]
        CMP      R0,R1
        BCS.N    ??SelectSort_7
//  245 			{
//  246 				SwapData( &tbuf[i] , &tbuf[j]) ;
        MOV      R1,R7
        MOV      R0,R6
        BL       SwapData
//  247 			}
//  248 		}
??SelectSort_7:
        ADD      R10,R10,#+1
        ADDS     R7,R7,#+2
        CMP      R10,R4
        BLT.N    ??SelectSort_6
//  249  	}
??SelectSort_5:
        ADDS     R6,R6,#+2
        LDR      R0,[SP, #+0]
        CMP      R11,R0
        BLT.N    ??SelectSort_4
//  250 
//  251 	for(i = MINGARBAGENO; i < nlen - MAXGARBAGENO; i++)
??SelectSort_3:
        MOV      R0,R8
        SUBS     R1,R4,R5
        CMP      R8,R1
        BGE.N    ??SelectSort_8
        ADD      R2,SP,#+4
        ADD      R2,R2,R0, LSL #+1
//  252 	{
//  253 		sum += tbuf[i];
??SelectSort_9:
        LDRH     R3,[R2], #+2
        ADD      R9,R3,R9
//  254 	}
        ADDS     R0,R0,#+1
        CMP      R0,R1
        BLT.N    ??SelectSort_9
//  255 
//  256 	return (INT16U)(sum/(nlen-MAXGARBAGENO-MINGARBAGENO));
??SelectSort_8:
        SUB      R0,R1,R8
        SDIV     R0,R9,R0
        UXTH     R0,R0
        ADD      SP,SP,#+308
        POP      {R4-R11,PC}      ;; return
//  257 }
//  258 
//  259 
//  260 /*******************************************************************************
//  261 * Function Name  : ADC_IRQHandler
//  262 * Description    : Enables or disables the selected ADC software start conversion .
//  263 * Input          : - ADCx: where x can be 1, 2 or 3 to select the ADC peripheral.
//  264 *                  - NewState: new state of the selected ADC software start conversion.
//  265 *                    This parameter can be: ENABLE or DISABLE.
//  266 * Output         : None
//  267 * Return         : None
//  268 *******************************************************************************/
//  269 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  270 void ADC_IRQHandler(void)
//  271 {
ADC_IRQHandler:
        PUSH     {R4-R6,LR}
//  272 
//  273 	INT32U cpu_sr;
//  274 
//  275 	CPU_CRITICAL_ENTER();										// Tell uC/OS-II that we are starting an ISR
        BL       CPU_SR_Save
//  276 	OSIntNesting++;
        LDR.N    R1,??DataTable4_2
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  277 	CPU_CRITICAL_EXIT();
        BL       CPU_SR_Restore
//  278 #ifdef ADC_AUTO_SCAN_ONE_TIME
//  279 
//  280 	ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = ADC1->DR;
        LDR.N    R0,??DataTable4
        LDRB     R1,[R0, #+0]
        ADD      R2,R0,R1, LSL #+1
        LDR.N    R3,??DataTable4_3  ;; 0x40012408
        LDRH     R4,[R2, #+20]
        ADD      R5,R0,R1, LSL #+2
        LDR      R5,[R5, #+52]
        LDR      R6,[R3, #+68]
        STRH     R6,[R5, R4, LSL #+1]
//  281 
//  282 	if(++ADC_WRCNT[ADCIndex] >= __ADCAVR)
        LDRH     R4,[R2, #+20]
        ADDS     R4,R4,#+1
        STRH     R4,[R2, #+20]
        UXTH     R4,R4
        CMP      R4,#+150
        BCC.N    ??ADC_IRQHandler_0
//  283 	{
//  284 		ADC_WRCNT[ADCIndex] = 0;
        MOVS     R3,#+0
        STRH     R3,[R2, #+20]
//  285 		ADCSTART[ADCIndex] = ADCFINISH;
        ADDS     R1,R1,R0
        MOVS     R2,#+2
        STRB     R2,[R1, #+4]
//  286 		ASTART = FALSE;
        STRB     R3,[R0, #+1]
        B.N      ??ADC_IRQHandler_1
//  287 	}
//  288 	else{
//  289 		ADC1->CR2.SWSTART = ENABLE;
??ADC_IRQHandler_0:
        LDR      R0,[R3, #+0]
        ORR      R0,R0,#0x400000
        STR      R0,[R3, #+0]
//  290 	}
//  291 
//  292 #else /////////////////////////////////////// #else(ADC_AUTO_SCAN_ONE_TIME)
//  293 
//  294 	
//  295 #ifdef ADC_AVER
//  296 	// Get injected channel10 and channel11 converted value
//  297 	ADC_SUM[ADCIndex] -= ADC_DATA[ADCIndex];
//  298 	ADC_SUM[ADCIndex] += ADC1->DR;
//  299 	ADC_DATA[ADCIndex] = ADC_SUM[ADCIndex]/__ADCAVR;
//  300 #else
//  301 	ADC_AVR[ADCIndex][ ADC_WRCNT[ADCIndex] ] = ADC1->DR;
//  302 	ASTART = 0;
//  303 #endif
//  304 
//  305 #endif /////////////////////////////////////// #endif(ADC_AUTO_SCAN_ONE_TIME)
//  306 
//  307 	OSIntExit();											// Tell uC/OS-II that we are leaving the ISR
??ADC_IRQHandler_1:
        POP      {R4-R6,LR}
        B.W      OSIntExit
//  308 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     ADCIndex

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4_1:
        DC32     0x40012404

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4_2:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4_3:
        DC32     0x40012408
//  309 
//  310 
//  311 
//  312 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  313 int ReadEnvTempTable(int Adcvalue)
//  314 {
//  315 //#ifdef ADC_AVER
//  316 	INT32S tmpx10 = AdctoVolt33V(Adcvalue);
//  317 //#else
//  318 //	INT32S tmpx10 = AdctoVolt33V(ADC_AVR[channel][0]);
//  319 //#endif
//  320 	tmpx10 = (tmpx10 - 500);
//  321 
//  322 	return tmpx10;	// 10배 값이 return 된다. 
ReadEnvTempTable:
        UXTH     R0,R0
        MOVW     R1,#+3300
        MULS     R0,R1,R0
        ASRS     R1,R0,#+11
        ADD      R0,R0,R1, LSR #+20
        LSLS     R0,R0,#+4
        LSRS     R0,R0,#+16
        SUB      R0,R0,#+500
        BX       LR               ;; return
//  323 }

        END
//  324 
//  325 
//  326 /******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
//  327 
// 
// 1 596 bytes in section .bss
//   116 bytes in section .data
//     4 bytes in section .rodata
//   716 bytes in section .text
// 
//   716 bytes of CODE  memory
//     4 bytes of CONST memory
// 1 712 bytes of DATA  memory
//
//Errors: none
//Warnings: none
