///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:45 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\main. /
//                    c                                                       /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\main. /
//                    c -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\sout\ -o D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120109\sout\ --endian=little --cpu=Cortex-M3 -e      /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\main. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME main

        EXTERN ADCInit
        EXTERN ADC_Init
        EXTERN AT24C64Init
        EXTERN AutoGetAdcValue
        EXTERN CheckSoftTimer
        EXTERN ExpioInit
        EXTERN FSMC_SRAM_Init
        EXTERN NVIC_DeInit
        EXTERN OSTimeDly
        EXTERN PCA9555_Init
        EXTERN RCC_WaitForHSEStartUp
        EXTERN RstpPCA9555SCL
        EXTERN RstpPCA9555SDA
        EXTERN SetpPCA9555SCL
        EXTERN SetpPCA9555SDA
        EXTERN TestInit
        EXTERN TimeOverCheck
        EXTERN TimerRegist
        EXTERN Tmr_TickInit
        EXTERN WRCS_SerInit
        EXTERN WatchdogClear
        EXTERN WatchdogInit
        EXTERN pPCA9555Str
        EXTERN pUSART1
        EXTERN pUSART4

        PUBLIC InitAFIO
        PUBLIC InitGPIO
        PUBLIC InitRCC
        PUBLIC InitStm32f103
        PUBLIC LedDisplay
        PUBLIC MainTaskStk
        PUBLIC PheripheralInit
        PUBLIC Ser4Ptr
        PUBLIC SerPtr
        PUBLIC convinfo
        PUBLIC iAdcIndex
        PUBLIC mainTask

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\code\main.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                              EXAMPLE CODE
//    4 *
//    5 *                          (c) Copyright 2003-2007; Micrium, Inc.; Weston, FL
//    6 *
//    7 *               All rights reserved.  Protected by international copyright laws.
//    8 *               Knowledge of the source code may NOT be used to develop a similar product.
//    9 *               Please help us continue to provide the Embedded community with the finest
//   10 *               software available.  Your honesty is greatly appreciated.
//   11 *********************************************************************************************************
//   12 */
//   13 #define MAIN_C
//   14 
//   15 #include "../include/main.h"

        SECTION iram:DATA:NOROOT(2)
// OS_STK __data MainTaskStk[64]
MainTaskStk:
        DS8 256

        SECTION `.bss`:DATA:NOROOT(2)
// __SerStrPtr *__data SerPtr
SerPtr:
        DS8 4

        SECTION `.bss`:DATA:NOROOT(2)
// __SerStrPtr *__data Ser4Ptr
Ser4Ptr:
        DS8 4

        SECTION `.rodata`:CONST:NOROOT(2)
// selfinfo const __data convinfo
convinfo:
        DATA
        DC8 "TRIO-M"
        DC8 0, 0, 0
        DC8 "NC0"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "NC1"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "123456789"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.bss`:DATA:NOROOT(0)
// INT8U __data iAdcIndex
iAdcIndex:
        DS8 1
//   16 
//   17 
//   18 
//   19 /*******************************************************************************
//   20 * Function Name  : InitStm32f103
//   21 * Description    : Initializes the stm32_x application.
//   22 * Input          : None
//   23 * Output         : None
//   24 * Return         : None
//   25 *******************************************************************************/
//   26 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   27 void InitStm32f103(void)
//   28 {
InitStm32f103:
        PUSH     {R7,LR}
//   29 	NVIC_DeInit();
        BL       NVIC_DeInit
//   30 	InitRCC();
        BL       InitRCC
//   31 	InitAFIO();
        BL       InitAFIO
//   32 	InitGPIO();
        BL       InitGPIO
//   33 	#ifdef __FSMC_SRAM_H
//   34 		FSMC_SRAM_Init();
        BL       FSMC_SRAM_Init
//   35 	#endif
//   36 	// Set the Vector Table base location at 0x08000000
//   37 	Tmr_TickInit(1L);	// timer init!!(1: 1ms)
        MOVS     R0,#+1
        POP      {R1,LR}
        B.W      Tmr_TickInit
//   38 }
//   39 
//   40 /*******************************************************************************
//   41 * Function Name  : InitRCC
//   42 * Description    : Initializes the stm32_x rcc application.
//   43 * Input          : None
//   44 * Output         : None
//   45 * Return         : None
//   46 *******************************************************************************/
//   47 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   48 void InitRCC(void)
//   49 {
InitRCC:
        PUSH     {R3-R9,LR}
//   50 	INT16U tmpcnt = 0xffff;
//   51 	// SYSCLK, HCLK, PCLK2 and PCLK1 configuration
//   52 	// RCC system reset(for debug purpose)
//   53 	// RCC_DeInit();
//   54 	// Enable HSE, Wait till HSE is ready
//   55 
//   56 	RCC->CFGR.Data = 0;
        LDR.N    R4,??InitRCC_0   ;; 0x40021000
        MOVS     R0,#+0
        STR      R0,[R4, #+4]
//   57 
//   58 #ifdef HSE_USED
//   59 	if(RCC_WaitForHSEStartUp(1))
        MVN      R5,#+3932160
        MVN      R6,#+16777216
        LDR.N    R7,??InitRCC_0+0x4  ;; 0x40022000
        MVN      R8,#+49152
        MVN      R9,#+14336
        MOVS     R0,#+1
        BL       RCC_WaitForHSEStartUp
        CMP      R0,#+0
        LDR      R0,[R4, #+4]
        BIC      R0,R0,#0xF0
        STR      R0,[R4, #+4]
        LDR      R0,[R4, #+4]
        AND      R0,R9,R0
        STR      R0,[R4, #+4]
        LDR      R0,[R4, #+4]
        BIC      R0,R0,#0x700
        STR      R0,[R4, #+4]
        LDR      R0,[R4, #+4]
        AND      R0,R8,R0
        STR      R0,[R4, #+4]
        LDR      R0,[R7, #+0]
        BEQ.N    ??InitRCC_1
//   60 #else 
//   61 	if(RCC_WaitForHSEStartUp(0))
//   62 #endif
//   63 	{
//   64 		u32 tmpreg;
//   65 
//   66 		// SYSTEM BUS CLOCK SELECTION
//   67 		RCC->CFGR.HPRE = __SYSCLK1;
        MOVS     R1,#+7
        BICS     R0,R0,R1
        ORR      R0,R0,#0x1
        STR      R0,[R7, #+0]
//   68 		RCC->CFGR.PPRE2 = __HCLK1;
//   69 		RCC->CFGR.PPRE1 = __HCLK1;
//   70 
//   71 		RCC->CFGR.ADCPRE = __PCLK22;	// ADCCLK = PCLK2/2 --> 36/2: 18MHz
//   72 
//   73 		// Flash 1 wait state
//   74 #if   (SYSCLK	>= (48000000L))
//   75 		FLASH->ACR.Bit.LATENCY = LATENCY2;
//   76 #elif (SYSCLK	>= (24000000L))
//   77 		FLASH->ACR.Bit.LATENCY = LATENCY1;
//   78 #else
//   79 		FLASH->ACR.Bit.LATENCY = LATENCY0;
//   80 #endif
//   81 		FLASH->ACR.Bit.PRFTBE = ENABLE;
        LDR      R0,[R7, #+0]
        ORR      R0,R0,#0x10
        STR      R0,[R7, #+0]
//   82 
//   83 		RCC->CR.PLLON = DISABLE; // Enable PLL
        LDR      R0,[R4, #+0]
        ANDS     R0,R6,R0
        STR      R0,[R4, #+0]
//   84 		// CLOCK SOURCE SELECTION
//   85 		// PLLCLK = 8MHZ * 9 = 72 MHz
//   86 		RCC->CFGR.PLLMUL = __PLLMUL9;
        LDR      R0,[R4, #+4]
        ANDS     R0,R5,R0
        ORR      R0,R0,#0x1C0000
        STR      R0,[R4, #+4]
//   87 		RCC->CFGR.PLLSRC = __HSESRC;
        LDR      R0,[R4, #+4]
        ORR      R0,R0,#0x10000
        STR      R0,[R4, #+4]
//   88 		RCC->CFGR.PLLXTPRE = __HSESRC2; // HSE CLK(8Mhz)/2 = 4 MHZ
        LDR      R0,[R4, #+4]
        ORR      R0,R0,#0x20000
        STR      R0,[R4, #+4]
//   89 
//   90 		RCC->CR.PLLON = ENABLE; // Enable PLL
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1000000
        STR      R0,[R4, #+0]
//   91 
//   92 		tmpcnt = 0xffff;
        MOVW     R0,#+65535
        MOV      R1,R0
//   93 		
//   94 		// Wait till PLL is ready
//   95 		do {
//   96 			tmpreg = RCC->CR.PLLRDY;
??InitRCC_2:
        LDR      R2,[R4, #+0]
        AND      R2,R2,#0x2000000
        LSRS     R2,R2,#+25
//   97 		}
//   98 		while(!tmpreg && tmpcnt--);
        BNE.N    ??InitRCC_3
        MOV      R2,R1
        ADDS     R1,R0,R2
        UXTH     R2,R2
        CMP      R2,#+0
        BNE.N    ??InitRCC_2
//   99 		
//  100 		RCC->CFGR.SW = __SW_PLL; // Select PLL as system clock source
??InitRCC_3:
        LDR      R1,[R4, #+4]
        MOVS     R2,#+3
        BICS     R1,R1,R2
        ORR      R1,R1,#0x2
        STR      R1,[R4, #+4]
//  101 		// Wait till PLL is used as system clock source
//  102 		tmpcnt = 0xffff;
        MOV      R1,R0
//  103 
//  104 		do {
//  105 			tmpreg = RCC->CFGR.SWS;
??InitRCC_4:
        LDR      R2,[R4, #+4]
        AND      R2,R2,#0xC
        LSRS     R2,R2,#+2
//  106 		}
//  107 		while(tmpreg != __SW_PLL && tmpcnt--);
        CMP      R2,#+2
        BEQ.N    ??InitRCC_5
        MOV      R2,R1
        ADDS     R1,R0,R2
        UXTH     R2,R2
        CMP      R2,#+0
        BNE.N    ??InitRCC_4
        POP      {R0,R4-R9,PC}
//  108 
//  109 	}
//  110 	else
//  111 	{
//  112 		/* Add here some code to deal with this error */
//  113 		u32 tmpreg;
//  114 
//  115 		RCC->CFGR.HPRE = __SYSCLK1;
??InitRCC_1:
        MOVS     R1,#+7
        BICS     R0,R0,R1
        ORR      R0,R0,#0x1
        STR      R0,[R7, #+0]
//  116 		RCC->CFGR.PPRE2 = __HCLK1;
//  117 		RCC->CFGR.PPRE1 = __HCLK1;
//  118 
//  119 		RCC->CFGR.ADCPRE = __PCLK22;	// ADCCLK = PCLK2/2 --> 36/2: 18MHz
//  120 
//  121 		// Flash 1 wait state
//  122 #if	  (SYSCLK	>= (48000000L))
//  123 		FLASH->ACR.Bit.LATENCY = LATENCY2;
//  124 #elif (SYSCLK	>= (24000000L))
//  125 		FLASH->ACR.Bit.LATENCY = LATENCY1;
//  126 #else
//  127 		FLASH->ACR.Bit.LATENCY = LATENCY0;
//  128 #endif
//  129 		FLASH->ACR.Bit.PRFTBE = ENABLE;
        LDR      R0,[R7, #+0]
        ORR      R0,R0,#0x10
        STR      R0,[R7, #+0]
//  130 		
//  131 		// CLOCK SOURCE SELECTION
//  132 		// CASE 101: PLLCLK = 8MHZ * 4 = 32 MHz
//  133 		////////////////////////////////////////////////////////////////////////
//  134 		// 
//  135 		RCC->CR.PLLON = DISABLE; // Enable PLL
        LDR      R0,[R4, #+0]
        ANDS     R0,R6,R0
        STR      R0,[R4, #+0]
//  136 		
//  137 #if	  (SYSCLK	>  8000000L)
//  138 		RCC->CFGR.PLLMUL = ((SYSCLK/4000000L) - 2);
        LDR      R0,[R4, #+4]
        ANDS     R0,R5,R0
        ORR      R0,R0,#0x1C0000
        STR      R0,[R4, #+4]
//  139 
//  140 		RCC->CR.PLLON = ENABLE; // Enable PLL
        LDR      R0,[R4, #+0]
        ORR      R0,R0,#0x1000000
        STR      R0,[R4, #+0]
//  141 
//  142 		// Wait till PLL is ready
//  143 		do {
//  144 			tmpreg = RCC->CR.PLLRDY;
??InitRCC_6:
        LDR      R0,[R4, #+0]
        AND      R0,R0,#0x2000000
        LSRS     R0,R0,#+25
//  145 		}
//  146 		while(!tmpreg);
        BEQ.N    ??InitRCC_6
//  147 
//  148 		RCC->CFGR.SW = __SW_PLL; // Select PLL as system clock source
        LDR      R0,[R4, #+4]
        MOVS     R1,#+3
        BICS     R0,R0,R1
        ORR      R0,R0,#0x2
        STR      R0,[R4, #+4]
//  149 		// Wait till PLL is used as system clock source
//  150 		do {
//  151 			tmpreg = RCC->CFGR.SWS;
??InitRCC_7:
        LDR      R0,[R4, #+4]
        AND      R0,R0,#0xC
        LSRS     R0,R0,#+2
//  152 		}
//  153 		while(tmpreg != __SW_PLL);
        CMP      R0,#+2
        BNE.N    ??InitRCC_7
//  154 #else
//  155 		RCC->CFGR.SW = __SW_HSI; // Select PLL as system clock source
//  156 		// Wait till PLL is used as system clock source
//  157 		do {
//  158 			tmpreg = RCC->CFGR.SWS;
//  159 		}
//  160 		while(tmpreg != __SW_HSI);
//  161 
//  162 #if	  (SYSCLK	>  4000000L)
//  163 			RCC->CFGR.HPRE = __SYSCLK1;
//  164 #else
//  165 			RCC->CFGR.HPRE = __SYSCLK2;
//  166 #endif
//  167 #endif
//  168 	}
//  169 }
??InitRCC_5:
        POP      {R0,R4-R9,PC}    ;; return
        DATA
??InitRCC_0:
        DC32     0x40021000
        DC32     0x40022000
//  170 
//  171 
//  172 /*******************************************************************************
//  173 * Function Name  : InitRCC
//  174 * Description    : Initializes the stm32_x afio application.
//  175 * Input          : None
//  176 * Output         : None
//  177 * Return         : None
//  178 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  179 void InitAFIO(void)
//  180 {
//  181 	// APB2 BUS RELATED
//  182 	// EXTI_WAKEUP, GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF, GPIOE
//  183 	// TIM1, SPI1, TIM8, USART1, ADC1,2,3
//  184 	RCC->APB2ENR.Data |= ( __IOPAEN | __IOPBEN | __IOPCEN | __IOPDEN | __IOPEEN |
//  185 						  __AFIOEN | __ADC1EN | __TIM1EN | __SPI1EN
//  186 						);
InitAFIO:
        LDR.N    R0,??InitAFIO_0  ;; 0x40021018
        LDR      R1,[R0, #+0]
        MOVW     R2,#+6781
        ORRS     R1,R2,R1
        STR      R1,[R0, #+0]
//  187 	// APB1 BUS RELATED
//  188 	// PWREN, BKPEN
//  189 	// TIM2, TIM3, TIM4, TIM5, TIM6, TIM7, 
//  190 	// USART2, USART3, SPI2
//  191 	// I2C1, I2C2, bxCAN, USB20, SRAM512B, WWDB
//  192 	RCC->APB1ENR.Data |= (__USART3EN);
        LDR      R1,[R0, #+4]
        ORR      R1,R1,#0x40000
        STR      R1,[R0, #+4]
//  193 
//  194 	// RELATED PORT
//  195 	// 1. PB4/JNTRST
//  196 	// 2. PB3/JTDO/TRACESWO
//  197 	// 3. PA15/JTCK/SWCLK
//  198 	// 4. PA13/JTMS/SWDIO
//  199 
//  200 	AFIO->MAPR.SWJ_CFG = __SWJ_RMAP_DISABLE;
        LDR.N    R0,??InitAFIO_0+0x4  ;; 0x40010004
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x7000000
        ORR      R1,R1,#0x4000000
        STR      R1,[R0, #+0]
//  201 	AFIO->MAPR.PD01_REMAP = 1;
        ORR      R1,R1,#0x8000
        STR      R1,[R0, #+0]
//  202 	
//  203 }
        BX       LR               ;; return
        Nop      
        DATA
??InitAFIO_0:
        DC32     0x40021018
        DC32     0x40010004
//  204 
//  205 /*******************************************************************************
//  206 * Function Name  : InitGPIO
//  207 * Description    : Initializes the stm32_x gpio application.
//  208 * Input          : None
//  209 * Output         : None
//  210 * Return         : None
//  211 *******************************************************************************/
//  212 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  213 void InitGPIO(void)
//  214 {
InitGPIO:
        PUSH     {R3-R6}
//  215 
//  216 ////////////////////////////////////////////////////////////////////////////////////
//  217 //Port A Initiallization
//  218 	GPIOA->CNF.B0 = __ADC_IN0;
        LDR.W    R0,??InitGPIO_0  ;; 0x40010800
        LDR      R1,[R0, #+0]
        MOVS     R2,#+15
        BICS     R1,R1,R2
        STR      R1,[R0, #+0]
//  219 	GPIOA->CNF.B1 = __ADC_IN1;
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF0
        STR      R1,[R0, #+0]
//  220 	GPIOA->CNF.B2 = __ADC_IN2; 
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0xF00
        STR      R1,[R0, #+0]
//  221 	GPIOA->CNF.B3 = __ADC_IN3; 
        MVN      R1,#+61440
        LDR      R2,[R0, #+0]
        ANDS     R2,R1,R2
        STR      R2,[R0, #+0]
//  222 	GPIOA->CNF.B4 = __ADC_IN4;
        MVN      R2,#+983040
        LDR      R3,[R0, #+0]
        ANDS     R3,R2,R3
        STR      R3,[R0, #+0]
//  223 	GPIOA->CNF.B5 = __ADC_IN5; 
        MVN      R3,#+15728640
        LDR      R4,[R0, #+0]
        ANDS     R4,R3,R4
        STR      R4,[R0, #+0]
//  224 	GPIOA->CNF.B6 = __ADC_IN6;
        MVN      R4,#+251658240
        LDR      R5,[R0, #+0]
        ANDS     R5,R4,R5
        STR      R5,[R0, #+0]
//  225 	GPIOA->CNF.B7 = __ADC_IN7;
        LDR      R5,[R0, #+0]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        STR      R5,[R0, #+0]
//  226 
//  227 
//  228 	GPIOA->CNF.B8 = __PA8_IN_PU;
        LDR      R5,[R0, #+4]
        MOVS     R6,#+15
        BICS     R5,R5,R6
        ORR      R5,R5,#0x8
        STR      R5,[R0, #+4]
//  229 	GPIOA->ODR.B8 = SET;				// PULL-UP	
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x100
        STR      R5,[R0, #+12]
//  230 
//  231 	GPIOA->CNF.B9 = __USART1_TX;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0xB0
        STR      R5,[R0, #+4]
//  232 	GPIOA->CNF.B10 = __USART1_RX;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0x400
        STR      R5,[R0, #+4]
//  233 
//  234 
//  235 	GPIOA->CNF.B11 = __PA11_IN_PU;
        LDR      R5,[R0, #+4]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x8000
        STR      R5,[R0, #+4]
//  236 	GPIOA->ODR.B11 = SET;				// PULL-UP	
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x800
        STR      R5,[R0, #+12]
//  237 
//  238 	GPIOA->CNF.B12 = __PA12_IN_PU;
        LDR      R5,[R0, #+4]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x80000
        STR      R5,[R0, #+4]
//  239 	GPIOA->ODR.B12 = SET;				// PULL-UP	
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x1000
        STR      R5,[R0, #+12]
//  240 
//  241 	GPIOA->CNF.B13 = __PA13_OU_PP;		// DIP SW ID1
        LDR      R5,[R0, #+4]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x300000
        STR      R5,[R0, #+4]
//  242 	GPIOA->ODR.B13 = SET;				// PULL-UP	
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x2000
        STR      R5,[R0, #+12]
//  243 
//  244 	GPIOA->CNF.B14 = __PA14_OU_PP;		// DIP SW ID2
        LDR      R5,[R0, #+4]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x3000000
        STR      R5,[R0, #+4]
//  245 	GPIOA->ODR.B14 = SET;				// PULL-UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x4000
        STR      R5,[R0, #+12]
//  246 
//  247 	GPIOA->CNF.B15 = __PA15_IN_PU;		// DIP SW ID0
        LDR      R5,[R0, #+4]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x80000000
        STR      R5,[R0, #+4]
//  248 	GPIOA->ODR.B15 = SET;				// PULL-UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x8000
        STR      R5,[R0, #+12]
//  249 
//  250 	//Port A Initialization End
//  251 	//Port B Initialization
//  252 	/////////////////////////
//  253 	GPIOB->CNF.B0 = __ADC_IN8;
        LDR.W    R0,??InitGPIO_0+0x4  ;; 0x40010c00
        LDR      R5,[R0, #+0]
        BICS     R5,R5,R6
        STR      R5,[R0, #+0]
//  254 	GPIOB->CNF.B1 = __ADC_IN9; 
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF0
        STR      R5,[R0, #+0]
//  255 
//  256 	GPIOB->CNF.B2 = __PB2_OU_PP;
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0x300
        STR      R5,[R0, #+0]
//  257 
//  258 	GPIOB->CNF.B3 = __PB3_IN_PU;
        LDR      R5,[R0, #+0]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x8000
        STR      R5,[R0, #+0]
//  259 	GPIOB->ODR.B3 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x8
        STR      R5,[R0, #+12]
//  260 
//  261 	GPIOB->CNF.B4 = __PB4_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x30000
        STR      R5,[R0, #+0]
//  262 
//  263 	GPIOB->CNF.B5 = __PB5_IN_PU;
        LDR      R5,[R0, #+0]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x800000
        STR      R5,[R0, #+0]
//  264 	GPIOB->ODR.B5 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x20
        STR      R5,[R0, #+12]
//  265 
//  266 	GPIOB->CNF.B6 = __PB6_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x3000000
        STR      R5,[R0, #+0]
//  267 	GPIOB->ODR.B6 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x40
        STR      R5,[R0, #+12]
//  268 //////////////////////////////////////////////////
//  269 
//  270 
//  271 
//  272 /////////////////////////////////////////////////////////////////////////////////////
//  273 #ifndef __FSMC_SRAM_H
//  274 	GPIOB->CNF.B7 = __PB7_IN_FL;		// __NADV
//  275 #else
//  276 	GPIOB->CNF.B7 = __PB8_OU_PP;
        LDR      R5,[R0, #+0]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x30000000
        STR      R5,[R0, #+0]
//  277 	GPIOB->ODR.B7 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x80
        STR      R5,[R0, #+12]
//  278 
//  279 #endif
//  280 
//  281 	GPIOB->CNF.B8 = __PB8_IN_PU;
        LDR      R5,[R0, #+4]
        BICS     R5,R5,R6
        ORR      R5,R5,#0x8
        STR      R5,[R0, #+4]
//  282 	GPIOB->ODR.B8 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x100
        STR      R5,[R0, #+12]
//  283 	
//  284 	GPIOB->CNF.B9 = __PB9_OU_PP;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0x30
        STR      R5,[R0, #+4]
//  285 	GPIOB->ODR.B9 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x200
        STR      R5,[R0, #+12]
//  286 
//  287 	GPIOB->CNF.B10 = __USART3_TX;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0xB00
        STR      R5,[R0, #+4]
//  288 	GPIOB->ODR.B10 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x400
        STR      R5,[R0, #+12]
//  289 
//  290 	GPIOB->CNF.B11 = __USART3_RX;
        LDR      R5,[R0, #+4]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x4000
        STR      R5,[R0, #+4]
//  291 
//  292 	GPIOB->CNF.B12 = __PB12_IN_PU;
        LDR      R5,[R0, #+4]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x80000
        STR      R5,[R0, #+4]
//  293 	GPIOB->ODR.B12 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x1000
        STR      R5,[R0, #+12]
//  294 	// PULL_UP
//  295 	GPIOB->CNF.B13 = __PB13_IN_PU;
        LDR      R5,[R0, #+4]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x800000
        STR      R5,[R0, #+4]
//  296 	GPIOB->ODR.B13 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x2000
        STR      R5,[R0, #+12]
//  297 	
//  298 	GPIOB->CNF.B14 = __PB14_IN_PU;
        LDR      R5,[R0, #+4]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x8000000
        STR      R5,[R0, #+4]
//  299 	GPIOB->ODR.B14 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x4000
        STR      R5,[R0, #+12]
//  300 
//  301 	GPIOB->CNF.B15 = __PB15_OU_PP;
        LDR      R5,[R0, #+4]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x30000000
        STR      R5,[R0, #+4]
//  302 	GPIOB->ODR.B15 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x8000
        STR      R5,[R0, #+12]
//  303 	
//  304 
//  305 ///////////////////////////////////////////
//  306 	
//  307 //Port B Initialization End
//  308 
//  309 	GPIOC->CNF.B0 = __ADC_IN10;
        LDR.N    R0,??InitGPIO_0+0x8  ;; 0x40011000
        LDR      R5,[R0, #+0]
        BICS     R5,R5,R6
        STR      R5,[R0, #+0]
//  310 	GPIOC->CNF.B1 = __ADC_IN11; ///////
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF0
        STR      R5,[R0, #+0]
//  311 	GPIOC->CNF.B2 = __ADC_IN12; 
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF00
        STR      R5,[R0, #+0]
//  312 	GPIOC->CNF.B3 = __ADC_IN13; 
        LDR      R5,[R0, #+0]
        ANDS     R5,R1,R5
        STR      R5,[R0, #+0]
//  313 	GPIOC->CNF.B4 = __ADC_IN14; 
        LDR      R5,[R0, #+0]
        ANDS     R5,R2,R5
        STR      R5,[R0, #+0]
//  314 	GPIOC->CNF.B5 = __ADC_IN15; 
        LDR      R5,[R0, #+0]
        ANDS     R5,R3,R5
        STR      R5,[R0, #+0]
//  315 
//  316 
//  317 	///
//  318 	GPIOC->CNF.B6 = __PC6_IN_PU;
        LDR      R5,[R0, #+0]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x8000000
        STR      R5,[R0, #+0]
//  319 	GPIOC->ODR.B6 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x40
        STR      R5,[R0, #+12]
//  320 
//  321 	GPIOC->CNF.B7 = __PC7_IN_PU;
        LDR      R5,[R0, #+0]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x80000000
        STR      R5,[R0, #+0]
//  322 	GPIOC->ODR.B7 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x80
        STR      R5,[R0, #+12]
//  323 
//  324 	GPIOC->CNF.B8 = __PC8_IN_PU;
        LDR      R5,[R0, #+4]
        BICS     R5,R5,R6
        ORR      R5,R5,#0x8
        STR      R5,[R0, #+4]
//  325 	GPIOC->ODR.B8 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x100
        STR      R5,[R0, #+12]
//  326 
//  327 	GPIOC->CNF.B9 = __PC9_OU_PP;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0x30
        STR      R5,[R0, #+4]
//  328 	GPIOC->ODR.B9 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x200
        STR      R5,[R0, #+12]
//  329 	
//  330 	GPIOC->CNF.B10 = __USART4_TX;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0xB00
        STR      R5,[R0, #+4]
//  331 	GPIOC->CNF.B11 = __USART4_RX;
        LDR      R5,[R0, #+4]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x4000
        STR      R5,[R0, #+4]
//  332 
//  333 	GPIOC->CNF.B12 = __PC12_IN_PU;
        LDR      R5,[R0, #+4]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x80000
        STR      R5,[R0, #+4]
//  334 	GPIOC->ODR.B12 = SET;				// PULL_UP		
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x1000
        STR      R5,[R0, #+12]
//  335 
//  336 	GPIOC->CNF.B13 = __PC13_IN_FL;
        LDR      R5,[R0, #+4]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x400000
        STR      R5,[R0, #+4]
//  337 
//  338 	GPIOC->CNF.B14 = __PC14_OU_PP;
        LDR      R5,[R0, #+4]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x2000000
        STR      R5,[R0, #+4]
//  339 	GPIOC->ODR.B14 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x4000
        STR      R5,[R0, #+12]
//  340 	GPIOC->CNF.B15 = __PC15_OU_PP;
        LDR      R5,[R0, #+4]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x20000000
        STR      R5,[R0, #+4]
//  341 	GPIOC->ODR.B15 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x8000
        STR      R5,[R0, #+12]
//  342 
//  343 	//Port C Initialization End
//  344 
//  345 	//Port D Initialization
//  346 
//  347 #ifndef	__FSMC_SRAM_H
//  348 	GPIOD->CNF.B0 = __PD0_OU_PP;		// __FAD2
//  349 	GPIOD->CNF.B1 = __PD1_OU_PP;		// __FAD3 
//  350 #else
//  351 	GPIOD->CNF.B0 = __PD0_IN_PU;
        LDR.N    R0,??InitGPIO_0+0xC  ;; 0x40011400
        LDR      R5,[R0, #+0]
        BICS     R5,R5,R6
        ORR      R5,R5,#0x8
        STR      R5,[R0, #+0]
//  352 	GPIOD->ODR.B0 = SET;		
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x1
        STR      R5,[R0, #+12]
//  353 	GPIOD->CNF.B1 = __PD1_IN_PU;
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0x80
        STR      R5,[R0, #+0]
//  354 	GPIOD->ODR.B1 = SET;		
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x2
        STR      R5,[R0, #+12]
//  355 #endif
//  356 	GPIOD->CNF.B2 = __PD2_OU_PP;
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0x300
        STR      R5,[R0, #+0]
//  357 	GPIOD->ODR.B2 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x4
        STR      R5,[R0, #+12]
//  358 
//  359 	GPIOD->CNF.B3 = __PD3_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x3000
        STR      R5,[R0, #+0]
//  360 	GPIOD->ODR.B3 = SET;				// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x8
        STR      R5,[R0, #+12]
//  361 #ifndef	__FSMC_SRAM_H
//  362 	GPIOD->CNF.B4 = __PD4_IN_FL;		// __NOE
//  363 	GPIOD->CNF.B5 = __PD5_IN_FL;		// __NWE
//  364 #else
//  365 	GPIOD->CNF.B4 = __PD4_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x30000
        STR      R5,[R0, #+0]
//  366 	GPIOD->ODR.B4 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x10
        STR      R5,[R0, #+12]
//  367 
//  368 	GPIOD->CNF.B5 = __PD5_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x300000
        STR      R5,[R0, #+0]
//  369 	GPIOD->ODR.B5 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x20
        STR      R5,[R0, #+12]
//  370 #endif
//  371 	GPIOD->CNF.B6 = __PD6_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x3000000
        STR      R5,[R0, #+0]
//  372 	GPIOD->ODR.B6 = SET;				// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x40
        STR      R5,[R0, #+12]
//  373 #ifndef __FSMC_SRAM_H
//  374 	GPIOD->CNF.B7 = __PD7_IN_FL;		// __NCE
//  375 #else
//  376 	GPIOD->CNF.B7 = __PD7_OU_PP;
        LDR      R5,[R0, #+0]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x30000000
        STR      R5,[R0, #+0]
//  377 	GPIOD->ODR.B7 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x80
        STR      R5,[R0, #+12]
//  378 #endif
//  379 
//  380 	GPIOD->CNF.B8 = __PD8_OU_PP;
        LDR      R5,[R0, #+4]
        BICS     R5,R5,R6
        ORR      R5,R5,#0x3
        STR      R5,[R0, #+4]
//  381 	GPIOD->ODR.B8 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x100
        STR      R5,[R0, #+12]
//  382 
//  383 
//  384 #ifndef __EXT_RAM_USED
//  385 {
//  386 
//  387 #ifndef __UPPER_DATA_USED
//  388 	GPIOD->CNF.B9 = __PD9_OU_PP;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0x30
        STR      R5,[R0, #+4]
//  389 	GPIOD->ODR.B9 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x200
        STR      R5,[R0, #+12]
//  390 
//  391 	GPIOD->CNF.B10 = __PD10_OU_PP;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0x300
        STR      R5,[R0, #+4]
//  392 	GPIOD->ODR.B10 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x400
        STR      R5,[R0, #+12]
//  393 
//  394 	GPIOD->CNF.B11 = __PD11_OU_PP;
        LDR      R5,[R0, #+4]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x3000
        STR      R5,[R0, #+4]
//  395 	GPIOD->ODR.B11 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x800
        STR      R5,[R0, #+12]
//  396 
//  397 	GPIOD->CNF.B12 = __PD12_OU_PP;
        LDR      R5,[R0, #+4]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x30000
        STR      R5,[R0, #+4]
//  398 	GPIOD->ODR.B12 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x1000
        STR      R5,[R0, #+12]
//  399 
//  400 	GPIOD->CNF.B13 = __PD13_OU_PP;
        LDR      R5,[R0, #+4]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x300000
        STR      R5,[R0, #+4]
//  401 	GPIOD->ODR.B13 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x2000
        STR      R5,[R0, #+12]
//  402 
//  403 	GPIOD->CNF.B14 = __PD14_OU_PP;
        LDR      R5,[R0, #+4]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x3000000
        STR      R5,[R0, #+4]
//  404 	GPIOD->ODR.B14 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x4000
        STR      R5,[R0, #+12]
//  405 	GPIOD->CNF.B15 = __PD15_OU_PP;
        LDR      R5,[R0, #+4]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x30000000
        STR      R5,[R0, #+4]
//  406 	GPIOD->ODR.B15 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x8000
        STR      R5,[R0, #+12]
//  407 #endif
//  408 	GPIOD->CNF.B11 = __PD11_OU_PP;		// __FA16
        LDR      R5,[R0, #+4]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x3000
        STR      R5,[R0, #+4]
//  409 	GPIOD->CNF.B12 = __PD12_OU_PP;		// __FA17
        LDR      R5,[R0, #+4]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x30000
        STR      R5,[R0, #+4]
//  410 	GPIOD->CNF.B13 = __PD13_OU_PP;		// __FA18
        LDR      R5,[R0, #+4]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x300000
        STR      R5,[R0, #+4]
//  411 
//  412 #ifndef	__FSMC_SRAM_H
//  413 	GPIOD->CNF.B14 = __PD14_OU_PP;		// __FAD0
//  414 	GPIOD->CNF.B15 = __PD15_OU_PP;		// __FAD1
//  415 #endif
//  416 }
//  417 #else
//  418 
//  419 #endif
//  420 
//  421 	//Port D Initialization End
//  422 	//Port E Initialization
//  423 	GPIOE->CNF.B0 = __PE0_OU_PP;
        LDR.N    R0,??InitGPIO_0+0x10  ;; 0x40011800
        LDR      R5,[R0, #+0]
        BICS     R5,R5,R6
        ORR      R5,R5,#0x3
        STR      R5,[R0, #+0]
//  424 	GPIOE->ODR.B0 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x1
        STR      R5,[R0, #+12]
//  425 
//  426 	GPIOE->CNF.B1 = __PE1_OU_PP;
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0x30
        STR      R5,[R0, #+0]
//  427 	GPIOE->ODR.B1 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x2
        STR      R5,[R0, #+12]
//  428 	
//  429 	GPIOE->CNF.B2 = __PE2_IN_FL;
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0x400
        STR      R5,[R0, #+0]
//  430 
//  431 #ifndef __EXT_RAM_USED
//  432 {
//  433 #ifndef __FSMC_SRAM_H	
//  434 	GPIOE->CNF.B3 = __PE3_OU_PP;		// __FA19
//  435 	GPIOE->CNF.B4 = __PE4_OU_PP;		// __FA20
//  436 	GPIOE->CNF.B5 = __PE5_IN_FL;		// __FA21
//  437 	GPIOE->CNF.B6 = __PE6_IN_FL;		// __FA22
//  438 
//  439 	GPIOE->CNF.B7 = __PE7_OU_PP;		// __FAD4
//  440 	GPIOE->CNF.B8 = __PE8_OU_PP;		// __FAD5
//  441 	GPIOE->CNF.B9 = __PE9_OU_PP;		// __FAD6
//  442 	GPIOE->CNF.B10 = __PE10_IN_FL;		// __FAD7
//  443 #endif
//  444 
//  445 #ifndef __UPPER_DATA_USED
//  446 	GPIOE->CNF.B0 = __PE0_OU_PP;
        LDR      R5,[R0, #+0]
        BICS     R5,R5,R6
        ORR      R5,R5,#0x3
        STR      R5,[R0, #+0]
//  447 	GPIOE->ODR.B0 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x1
        STR      R5,[R0, #+12]
//  448 	
//  449 	GPIOE->CNF.B1 = __PE1_OU_PP;
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0x30
        STR      R5,[R0, #+0]
//  450 	GPIOE->ODR.B1 = SET;				// PULL_UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x2
        STR      R5,[R0, #+12]
//  451 
//  452 	GPIOE->CNF.B2 = __PE2_OU_PP;
        LDR      R5,[R0, #+0]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0x300
        STR      R5,[R0, #+0]
//  453 	GPIOE->ODR.B2 = SET;				// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x4
        STR      R5,[R0, #+12]
//  454 
//  455 	GPIOE->CNF.B3 = __PE3_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R1,R5
        ORR      R5,R5,#0x3000
        STR      R5,[R0, #+0]
//  456 	GPIOE->ODR.B3 = SET;				// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x8
        STR      R5,[R0, #+12]
//  457 
//  458 	GPIOE->CNF.B4 = __PE4_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R2,R5
        ORR      R5,R5,#0x30000
        STR      R5,[R0, #+0]
//  459 	GPIOE->ODR.B4 = SET;		
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x10
        STR      R5,[R0, #+12]
//  460 
//  461 	GPIOE->CNF.B5 = __PE5_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R3,R5
        ORR      R5,R5,#0x300000
        STR      R5,[R0, #+0]
//  462 	GPIOE->ODR.B5 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x20
        STR      R5,[R0, #+12]
//  463 
//  464 	GPIOE->CNF.B6 = __PE6_OU_PP;
        LDR      R5,[R0, #+0]
        ANDS     R5,R4,R5
        ORR      R5,R5,#0x3000000
        STR      R5,[R0, #+0]
//  465 	GPIOE->ODR.B6 = SET;
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x40
        STR      R5,[R0, #+12]
//  466 
//  467 	GPIOE->CNF.B7 = __PE7_OU_PP;
        LDR      R5,[R0, #+0]
        LSLS     R5,R5,#+4
        LSRS     R5,R5,#+4
        ORR      R5,R5,#0x30000000
        STR      R5,[R0, #+0]
//  468 	GPIOE->ODR.B7 = SET;			// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x80
        STR      R5,[R0, #+12]
//  469 
//  470 	GPIOE->CNF.B8 = __PE8_OU_PP;
        LDR      R5,[R0, #+4]
        BICS     R5,R5,R6
        ORR      R5,R5,#0x3
        STR      R5,[R0, #+4]
//  471 	GPIOE->ODR.B8 = SET;			// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x100
        STR      R5,[R0, #+12]
//  472 
//  473 	GPIOE->CNF.B9 = __PE9_OU_PP;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF0
        ORR      R5,R5,#0x30
        STR      R5,[R0, #+4]
//  474 	GPIOE->ODR.B9 = SET;				// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x200
        STR      R5,[R0, #+12]
//  475 
//  476 	GPIOE->CNF.B10 = __PE10_OU_PP;
        LDR      R5,[R0, #+4]
        BIC      R5,R5,#0xF00
        ORR      R5,R5,#0x300
        STR      R5,[R0, #+4]
//  477 	GPIOE->ODR.B10 = SET;				// PULL UP
        LDR      R5,[R0, #+12]
        ORR      R5,R5,#0x400
        STR      R5,[R0, #+12]
//  478 
//  479 	GPIOE->CNF.B11 = __PE11_OU_PP;
        LDR      R5,[R0, #+4]
        ANDS     R1,R1,R5
        ORR      R1,R1,#0x3000
        STR      R1,[R0, #+4]
//  480 	GPIOE->ODR.B11 = SET;				// PULL UP
        LDR      R1,[R0, #+12]
        ORR      R1,R1,#0x800
        STR      R1,[R0, #+12]
//  481 
//  482 
//  483 	GPIOE->CNF.B12 = __PE12_OU_PP;
        LDR      R1,[R0, #+4]
        ANDS     R1,R2,R1
        ORR      R1,R1,#0x30000
        STR      R1,[R0, #+4]
//  484 	GPIOE->ODR.B12 = SET;				// PULL UP
        LDR      R1,[R0, #+12]
        ORR      R1,R1,#0x1000
        STR      R1,[R0, #+12]
//  485 
//  486 	GPIOE->CNF.B13 = __PE13_OU_PP;
        LDR      R1,[R0, #+4]
        ANDS     R1,R3,R1
        ORR      R1,R1,#0x300000
        STR      R1,[R0, #+4]
//  487 	GPIOE->ODR.B13 = SET;				// PULL UP
        LDR      R1,[R0, #+12]
        ORR      R1,R1,#0x2000
        STR      R1,[R0, #+12]
//  488 
//  489 	GPIOE->CNF.B14 = __PE14_OU_PP;
        LDR      R1,[R0, #+4]
        ANDS     R1,R4,R1
        ORR      R1,R1,#0x3000000
        STR      R1,[R0, #+4]
//  490 	GPIOE->ODR.B14 = SET;				// PULL UP
        LDR      R1,[R0, #+12]
        ORR      R1,R1,#0x4000
        STR      R1,[R0, #+12]
//  491 
//  492 	GPIOE->CNF.B15 = __PE15_OU_PP;
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
        ORR      R1,R1,#0x30000000
        STR      R1,[R0, #+4]
//  493 	GPIOE->ODR.B15 = SET;				// PULL UP
        LDR      R1,[R0, #+12]
        ORR      R1,R1,#0x8000
        STR      R1,[R0, #+12]
//  494 #endif
//  495 }
//  496 #else
//  497 
//  498 #endif
//  499 
//  500 
//  501 
//  502 	//Port E Initialization End
//  503 }
        POP      {R0,R4-R6}
        BX       LR               ;; return
        DATA
??InitGPIO_0:
        DC32     0x40010800
        DC32     0x40010c00
        DC32     0x40011000
        DC32     0x40011400
        DC32     0x40011800
//  504 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  505 void PheripheralInit(void)
//  506 {
PheripheralInit:
        PUSH     {R7,LR}
//  507 	WatchdogInit();
        BL       WatchdogInit
//  508 	WatchdogClear();
        BL       WatchdogClear
//  509 
//  510 	SerPtr = &pUSART1;
        LDR.N    R2,??PheripheralInit_0  ;; pUSART1
        LDR.N    R0,??PheripheralInit_0+0x4  ;; SerPtr
        STR      R2,[R0, #+0]
//  511 	SerPtr->init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));
        MOVS     R1,#+16
        MOV      R0,#+38400
        LDR      R2,[R2, #+0]
        BLX      R2
//  512 	pUSART4.init(115200L, (_DATA8BIT | _1_STOP | _NONPARITY));	
        MOVS     R1,#+16
        MOV      R0,#+115200
        LDR.N    R2,??PheripheralInit_0+0x8  ;; pUSART4
        LDR      R2,[R2, #+0]
        BLX      R2
//  513 
//  514 	AT24C64Init();
        BL       AT24C64Init
//  515 
//  516 	/////////////////////////////////////////////////////////
//  517  	// Function Task recursion
//  518 	WRCS_SerInit();
        BL       WRCS_SerInit
//  519 
//  520 	_PCA9555Init();
        LDR.N    R0,??PheripheralInit_0+0xC  ;; RstpPCA9555SDA
        PUSH     {R0,LR}
        LDR.N    R3,??PheripheralInit_0+0x10  ;; SetpPCA9555SDA
        LDR.N    R2,??PheripheralInit_0+0x14  ;; RstpPCA9555SCL
        LDR.N    R1,??PheripheralInit_0+0x18  ;; SetpPCA9555SCL
        LDR.N    R0,??PheripheralInit_0+0x1C  ;; pPCA9555Str
        LDR      R0,[R0, #+0]
        BL       PCA9555_Init
        ADD      SP,SP,#+8
//  521 //	FskInit();
//  522 
//  523 //	SmsInit();	
//  524 	
//  525 	ExpioInit();
        BL       ExpioInit
//  526 	ADCInit(FALSE);
        MOVS     R0,#+0
        BL       ADCInit
//  527 	ADC_Init();
        BL       ADC_Init
//  528 	TestInit();
        POP      {R0,LR}
        B.W      TestInit
        DATA
??PheripheralInit_0:
        DC32     pUSART1
        DC32     SerPtr
        DC32     pUSART4
        DC32     RstpPCA9555SDA
        DC32     SetpPCA9555SDA
        DC32     RstpPCA9555SCL
        DC32     SetpPCA9555SCL
        DC32     pPCA9555Str
//  529 }
//  530 
//  531 extern const  INTVECT_ELEM  AppVectTbl[];
//  532 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  533 void LedDisplay(void)
//  534 {
LedDisplay:
        PUSH     {R7,LR}
//  535 	if(TimeOverCheck(TimerLed))
        MOVS     R0,#+1
        BL       TimeOverCheck
        CBZ      R0,??LedDisplay_0
//  536 	{
//  537 		TimerRegist(TimerLed, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+1
        BL       TimerRegist
//  538 		
//  539 		RUNLEDSEL ^= 1;
        LDR.N    R0,??LedDisplay_1  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        EOR      R1,R1,#0x4
        STR      R1,[R0, #+0]
//  540 	}
//  541 }
??LedDisplay_0:
        POP      {R0,PC}          ;; return
        DATA
??LedDisplay_1:
        DC32     0x40010c0c
//  542 
//  543 extern u32 CurrINT;

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  544 void  mainTask (void *p_arg)
//  545 {
mainTask:
        PUSH     {R7,LR}
//  546     (void)p_arg;
//  547 
//  548 	InitStm32f103();
        BL       InitStm32f103
//  549 	PheripheralInit();
        BL       PheripheralInit
//  550 
//  551 	TimerRegist(TimerLed, Time100mSec);
        MOVS     R1,#+100
        MOVS     R0,#+1
        BL       TimerRegist
//  552  
//  553     while(1)
//  554 	{
//  555 		LedDisplay();
??mainTask_0:
        BL       LedDisplay
//  556 		CheckSoftTimer();
        BL       CheckSoftTimer
//  557 
//  558 		AutoGetAdcValue();
        BL       AutoGetAdcValue
//  559 		OSTimeDly(1L);
        MOVS     R0,#+1
        BL       OSTimeDly
        B.N      ??mainTask_0
//  560     }
//  561 }

        END
//  562  
// 
//     9 bytes in section .bss
//    52 bytes in section .rodata
// 1 946 bytes in section .text
//   256 bytes in section iram
// 
// 1 946 bytes of CODE  memory
//    52 bytes of CONST memory
//   265 bytes of DATA  memory
//
//Errors: none
//Warnings: none
