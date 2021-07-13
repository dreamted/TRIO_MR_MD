///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    30/Aug/2012  21:29:30 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\main.c       /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\main.c -D    /
//                    OS_INCLUDED -D APPL_SRC -lcN                            /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\main.s       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME main

        #define SHT_PROGBITS 0x1

        EXTERN CheckSoftTimer
        EXTERN EEpromInit
        EXTERN ExpioInit
        EXTERN GPIOPortInit
        EXTERN InitSysTick
        EXTERN OSTimeDly
        EXTERN SRAM_Init
        EXTERN Ser1Init
        EXTERN TimeOverCheck
        EXTERN TimerInit
        EXTERN TimerRegist
        EXTERN pUSART1

        PUBLIC InitAFIO
        PUBLIC InitGPIO
        PUBLIC InitStm32f103
        PUBLIC LedDisplay
        PUBLIC PheripheralInit
        PUBLIC SerPtr
        PUBLIC convinfo
        PUBLIC mainTask

// D:\Work\Project\2012\NL_INBUILD\FW\MU\code\main.c
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

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute __SerStrPtr *SerPtr
SerPtr:
        DS8 4

        SECTION `.rodata`:CONST:NOROOT(2)
        DATA
// __absolute selfinfo const convinfo
convinfo:
        DC8 "DB-PICO"
        DC8 0, 0
        DC8 "NC0"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "NC1"
        DC8 0, 0, 0, 0, 0, 0
        DC8 "123456789"
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   16 
//   17 
//   18 /*******************************************************************************
//   19 * Function Name  : InitStm32f103
//   20 * Description    : Initializes the stm32_x application.
//   21 * Input          : None
//   22 * Output         : None
//   23 * Return         : None
//   24 *******************************************************************************/
//   25 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   26 void InitStm32f103(void)
//   27 {
InitStm32f103:
        PUSH     {R7,LR}
//   28 //	NVIC_DeInit();
//   29 //	InitRCC();
//   30 //	SystemInit();
//   31 
//   32 	InitAFIO();
        BL       InitAFIO
//   33 	InitGPIO();
        BL       InitGPIO
//   34 	//#ifdef __FSMC_SRAM_H
//   35 	//	FSMC_SRAM_Init();
//   36 	SRAM_Init();
        BL       SRAM_Init
//   37 	//#endif
//   38 	// Set the Vector Table base location at 0x08000000
//   39 	InitSysTick(1L);	// timer init!!(1: 1ms)
        MOVS     R0,#+1
        POP      {R1,LR}
        B.W      InitSysTick
//   40 }
//   41 
//   42 /*******************************************************************************
//   43 * Function Name  : InitRCC
//   44 * Description    : Initializes the stm32_x afio application.
//   45 * Input          : None
//   46 * Output         : None
//   47 * Return         : None
//   48 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void InitAFIO(void)
//   50 {
//   51 	// AHB1 BUS RELATED
//   52 	// GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF, GPIOG, GPIOH
//   53 	// TIM1, SPI1, USART1, ADC
//   54     RCC->__B.AHB1ENR.IOPAEN = ENABLE;
InitAFIO:
        LDR.N    R0,??DataTable4  ;; 0x40023830
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//   55     RCC->__B.AHB1ENR.IOPBEN = ENABLE;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x2
        STR      R1,[R0, #+0]
//   56     RCC->__B.AHB1ENR.IOPEEN = ENABLE;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x10
        STR      R1,[R0, #+0]
//   57     RCC->__B.AHB1ENR.IOPGEN = ENABLE;
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x40
        STR      R1,[R0, #+0]
//   58 
//   59 }
        BX       LR               ;; return
//   60 
//   61 /*******************************************************************************
//   62 * Function Name  : InitGPIO
//   63 * Description    : Initializes the stm32_x gpio application.
//   64 * Input          : None
//   65 * Output         : None
//   66 * Return         : None
//   67 *******************************************************************************/
//   68 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   69 void InitGPIO(void)
//   70 {
InitGPIO:
        PUSH     {R4-R8,LR}
//   71 	//--------------------------------------------------------------//
//   72 	// CPU - LEFT
//   73 	__PE2_PP_PP();				// S_DATA
        LDR.N    R4,??DataTable4_1  ;; 0x40021000
        MOVS     R3,#+2
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   74 	__PE3_IN_PU();				// INSERT_25
        MOVS     R3,#+3
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//   75 	__PE4_IN_PU();				// INSERT_21
        MOVS     R3,#+4
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//   76 	__PE5_IN_PU();				// INSERT_900
        MOVS     R3,#+5
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//   77 	__PE6_PP_PP();				// EX1_CTRL
        MOVS     R3,#+6
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//   78 	
//   79 	__PF6_IN_FL();				// SYNC_A_CPU
        LDR.N    R5,??DataTable4_2  ;; 0x40021400
        MOVS     R3,#+6
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       GPIOPortInit
//   80 	__PF7_IN_FL();				// SYNC_B_CPU
        MOVS     R3,#+7
        MOV      R2,R5
        MOVS     R1,#+0
        MOV      R0,R1
        BL       GPIOPortInit
//   81 
//   82 	__ADC_IN10();
        LDR.N    R5,??DataTable4_3  ;; 0x40020800
        MOVS     R3,#+0
        MOV      R2,R5
        MOV      R1,R3
        MOVS     R0,#+3
        BL       GPIOPortInit
//   83 	__ADC_IN11();
        MOVS     R3,#+1
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   84 	__ADC_IN12();
        MOVS     R3,#+2
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   85 	__ADC_IN13();
        MOVS     R3,#+3
        MOV      R2,R5
        MOVS     R1,#+0
        MOV      R0,R3
        BL       GPIOPortInit
//   86 	
//   87 	__ADC_IN0();
        LDR.N    R6,??DataTable4_4  ;; 0x40020000
        MOVS     R3,#+0
        MOV      R2,R6
        MOV      R1,R3
        MOVS     R0,#+3
        BL       GPIOPortInit
//   88 	__ADC_IN1();
        MOVS     R3,#+1
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   89 	__PA2_U2_TX();				// USART2_TX
        MOVS     R3,#+2
        MOV      R2,R6
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//   90 	__PA3_U2_RX();				// USART2_RX
        MOVS     R3,#+3
        MOV      R2,R6
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//   91 	
//   92 	__ADC_IN4();
        MOVS     R3,#+4
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   93 	__ADC_IN5();
        MOVS     R3,#+5
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   94 	__ADC_IN6();
        MOVS     R3,#+6
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   95 	__ADC_IN7();
        MOVS     R3,#+7
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   96 	__ADC_IN14();
        MOVS     R3,#+4
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   97 	__ADC_IN15();
        MOVS     R3,#+5
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       GPIOPortInit
//   98 	__ADC_IN8();
        LDR.N    R7,??DataTable4_5  ;; 0x40020400
        MOVS     R3,#+0
        MOV      R2,R7
        MOV      R1,R3
        MOVS     R0,#+3
        BL       GPIOPortInit
//   99 	__ADC_IN9();
        MOVS     R3,#+1
        MOV      R2,R7
        MOV      R1,R3
        MOVS     R0,#+3
        BL       GPIOPortInit
//  100 
//  101 	__PE12_PP_PP(); 			// ATTN_DATA
        MOVS     R3,#+12
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  102 	__PE13_PP_PP(); 			// ATTN_CLK
        MOVS     R3,#+13
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  103 		
//  104 	__PE14_IN_PD(); 			// PLL_TX_25
        MOVS     R3,#+14
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       GPIOPortInit
//  105 	__PB10_U3_TX(); 			// USART3_TX
        MOVS     R3,#+10
        MOV      R2,R7
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  106 	__PB11_U3_RX(); 			// USART3_RX
        MOVS     R3,#+11
        MOV      R2,R7
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  107 
//  108 	__PB12_IN_PD(); 			// PLL_RX_21
        MOVS     R3,#+12
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       GPIOPortInit
//  109 	__PB13_IN_PD(); 			// PLL_TX_21
        MOVS     R3,#+13
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       GPIOPortInit
//  110 	__PB14_IN_PD(); 			// PLL_RX_900
        MOVS     R3,#+14
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       GPIOPortInit
//  111 	__PB15_IN_PD(); 			// PLL_TX_900
        MOVS     R3,#+15
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       GPIOPortInit
//  112 	__PD8_IN_PD();				// PLL_RX_25
        LDR.N    R4,??DataTable4_6  ;; 0x40020c00
        MOVS     R3,#+8
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       GPIOPortInit
//  113 	
//  114 	
//  115 	//--------------------------------------------------------------//
//  116 	// CPU - RIGHT
//  117 	__PD9_IN_PD();				// nLINKLED
        MOVS     R3,#+9
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+128
        BL       GPIOPortInit
//  118 	__PD10_PP_PP(); 			// W3150RST
        MOVS     R3,#+10
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  119 
//  120 	__PG6_IN_PU();				// FAN1_ALM
        LDR.W    R8,??DataTable4_7  ;; 0x40021800
        MOVS     R3,#+6
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  121 	__PG7_IN_PU();				// DC_IN_FAIL
        MOVS     R3,#+7
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  122 	__PG8_IN_PU();				// DC_OUT_FAIL
        MOVS     R3,#+8
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  123 	
//  124 	__PC8_PP_PP();				// PWR_ON_21G
        MOVS     R3,#+8
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  125 	__PC9_PP_PP();				// PWR_ON_900M
        MOVS     R3,#+9
        MOV      R2,R5
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  126 	__PA8_PP_PP();				// PWR_ON_25G
        MOVS     R3,#+8
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  127 		
//  128 	__PA9_U1_TX();				// USART1_TX
        MOVS     R3,#+9
        MOV      R2,R6
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  129 	__PA10_U1_RX(); 			// USART1_RX
        MOVS     R3,#+10
        MOV      R2,R6
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  130 
//  131 	__PA11_IN_PU(); 			// DC_FAIL_21
        MOVS     R3,#+11
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  132 	__PA12_IN_PU(); 			// DC_FAIL_900
        MOVS     R3,#+12
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  133 	__PA13_IN_PU(); 			// DC_FAIL_25
        MOVS     R3,#+13
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  134 
//  135 	__PA14_PP_PU(); 			// SCK
        MOVS     R3,#+14
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+97
        BL       GPIOPortInit
//  136 	__PA15_PP_PP(); 			// W3150_nSS
        MOVS     R3,#+15
        MOV      R2,R6
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  137 
//  138 	__PC10_U4_TX(); 			// USART4_TX
        MOVS     R3,#+10
        MOV      R2,R5
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  139 	__PC11_U4_RX(); 			// USART4_RX
        MOVS     R3,#+11
        MOV      R2,R5
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  140 	__PC12_U5_TX(); 			// USART5_TX
        MOVS     R3,#+12
        MOV      R2,R5
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  141 	__PD2_U5_RX();				// USART5_RX
        MOVS     R3,#+2
        MOV      R2,R4
        MOVS     R1,#+7
        MOVS     R0,#+38
        BL       GPIOPortInit
//  142 	
//  143 	__PD3_PP_PP();				// DTU_RESET
        MOVS     R3,#+3
        MOV      R2,R4
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  144 	__PG10_IN_PU(); 			// DTU_BD
        MOVS     R3,#+10
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  145 
//  146 	__PG11_PP_PP(); 			// DCC_SEL01
        MOVS     R3,#+11
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  147 	__PG12_PP_PP(); 			// DCC_SEL23
        MOVS     R3,#+12
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  148 	__PG13_PP_PP(); 			// DCC_SEL45
        MOVS     R3,#+13
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  149 	__PG14_PP_PP(); 			// DCC_SEL67
        MOVS     R3,#+14
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  150 	__PG15_IN_PU(); 			// EXT1_ALM
        MOVS     R3,#+15
        MOV      R2,R8
        MOVS     R1,#+0
        MOVS     R0,#+64
        BL       GPIOPortInit
//  151 
//  152 	__PB7_PP_PP();				// EXT2
        MOVS     R3,#+7
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  153 	__PB8_PP_PP();				// EXT1
        MOVS     R3,#+8
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  154 
//  155 	__PB8_PP_PP();				// EXT2_ALM_IN
        MOVS     R3,#+8
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+33
        BL       GPIOPortInit
//  156 	
//  157 	__PB2_PP_PP();				// RUN LED
        MOVS     R3,#+2
        MOV      R2,R7
        MOVS     R1,#+0
        MOVS     R0,#+33
        POP      {R4-R8,LR}
        B.W      GPIOPortInit
//  158 
//  159 }
//  160 
//  161 
//  162 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  163 void PheripheralInit(void)
//  164 {
PheripheralInit:
        PUSH     {R7,LR}
//  165 	TimerInit();
        BL       TimerInit
//  166 //	WatchdogInit();
//  167 //	WatchdogClear();
//  168 	
//  169 	SerPtr = &pUSART1;
        LDR.N    R2,??DataTable4_8
        LDR.N    R0,??DataTable4_9
        STR      R2,[R0, #+0]
//  170 	SerPtr->init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));
        MOVS     R1,#+0
        MOV      R0,#+38400
        LDR      R2,[R2, #+0]
        BLX      R2
//  171 
//  172 	//pUSART2.init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));	// iRems 2G(LTE)
//  173 	//pUSART3.init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));	// iRems 3G(LTE)
//  174 	//pUSART4.init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));	// EXT
//  175 	//pUSART5.init(38400L, (_DATA8BIT | _1_STOP | _NONPARITY));
//  176 	//Ser6Init(Ser6Bps, Ser6LCR, (INT32U)&nGM16C550CS6);
//  177 	//KeyBuzInit (KEYSEL);
//  178 	EEpromInit();
        BL       EEpromInit
//  179 	/////////////////////////////////////////////////////////
//  180 	// Function Task recursion
//  181 	//CalendarInit();
//  182     //	DAC1Init();
//  183     //	DAC2Init();
//  184 	Ser1Init();
        BL       Ser1Init
//  185 	//iAPDInit();
//  186 	//RCSSerInit();
//  187 	ExpioInit();
        POP      {R0,LR}
        B.W      ExpioInit
//  188 	//AlcInit();
//  189 	//iRemsInit();
//  190 	//FmmiInit();
//  191 	//DnrInit();
//  192 	//Ethenet0Init();		// WRCS
//  193 	//Ethenet1Init();
//  194 	//Lis03lv02init();
//  195 	//TestInit();
//  196 	//ADCInit(TRUE);
//  197 	//ADCInit(FALSE);
//  198 	//EXTI0_Init();
//  199 	//EXTI12_Init();
//  200 }
//  201 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  202 void LedDisplay(void)
//  203 {
LedDisplay:
        PUSH     {R7,LR}
//  204 	if(TimeOverCheck(TimerLed))
        MOVS     R0,#+1
        BL       TimeOverCheck
        CBZ.N    R0,??LedDisplay_0
//  205 	{
//  206 		TimerRegist(TimerLed, Time100mSec*5L);
        MOV      R1,#+500
        MOVS     R0,#+1
        BL       TimerRegist
//  207 		RUNLEDSEL ^= 1;
        LDR.N    R0,??DataTable4_10  ;; 0x40020414
        LDR      R1,[R0, #+0]
        EOR      R1,R1,#0x4
        STR      R1,[R0, #+0]
//  208 		//if(!RUNLEDSEL)iDebugCnt = 0;
//  209         //WatchdogClear();
//  210 	}
//  211 }
??LedDisplay_0:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     0x40023830

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x40021400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x40020800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x40020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x40020400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x40020c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     0x40021800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     pUSART1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     SerPtr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     0x40020414
//  212 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  213 void  mainTask (void *p_arg)
//  214 {
mainTask:
        PUSH     {R7,LR}
//  215     (void)p_arg;
//  216 
//  217 	InitStm32f103();
        BL       InitStm32f103
//  218 	PheripheralInit();
        BL       PheripheralInit
//  219 
//  220 	TimerRegist(TimerLed, Time100mSec);
        MOVS     R1,#+100
        MOVS     R0,#+1
        BL       TimerRegist
//  221 
//  222     while(1)
//  223 	{
//  224 		CheckSoftTimer();
??mainTask_0:
        BL       CheckSoftTimer
//  225 		//ADC1_SWStart();
//  226 		OSTimeDly(1L);
        MOVS     R0,#+1
        BL       OSTimeDly
        B.N      ??mainTask_0
//  227     }
//  228 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  229  
// 
//   4 bytes in section .bss
//  52 bytes in section .rodata
// 984 bytes in section .text
// 
// 984 bytes of CODE  memory
//  52 bytes of CONST memory
//   4 bytes of DATA  memory
//
//Errors: none
//Warnings: none
