///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:40 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\extint /
//                    \extint_v0903.c                                         /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\extint /
//                    \extint_v0903.c -D _MIMO_Type -lcN                      /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120106\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120106\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120106\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\extin /
//                    t_v0903.s                                               /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME extint_v0903

        EXTERN EXTI_GetITStatus
        EXTERN EXTI_Init
        EXTERN F_RESET_IN_Read
        EXTERN NVIC_Init
        EXTERN OSIntExit
        EXTERN OSIntNesting
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN ResetStart

        PUBLIC CurrINT
        PUBLIC EXTI0_IRQHandler
        PUBLIC EXTI0_Init
        PUBLIC EXTI12_Init
        PUBLIC EXTI15_10_IRQHandler
        PUBLIC EXTI1_IRQHandler
        PUBLIC EXTI1_Init
        PUBLIC EXTI2_IRQHandler
        PUBLIC EXTI2_Init
        PUBLIC EXTI3_IRQHandler
        PUBLIC EXTI3_Init
        PUBLIC EXTI4_IRQHandler
        PUBLIC EXTI4_Init
        PUBLIC EXTI5_Init
        PUBLIC EXTI6_Init
        PUBLIC EXTI7_Init
        PUBLIC EXTI9_5_IRQHandler

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\dev\extint\extint_v0903.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_exti.c
//    3 * Author             : MCD Application Team
//    4 * Date First Issued  : 09/29/2006
//    5 * Description        : This file provides all the EXTI firmware functions.
//    6 ********************************************************************************
//    7 * History:
//    8 * 05/21/2007: V0.3
//    9 * 04/02/2007: V0.2
//   10 * 02/05/2007: V0.1
//   11 * 09/29/2006: V0.01
//   12 ********************************************************************************
//   13 * THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   14 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   15 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   16 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   17 * CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   18 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   19 *******************************************************************************/
//   20 
//   21 /* Includes ------------------------------------------------------------------*/
//   22 #include "stm32f10x_conf.h"
//   23 #include "extint_v0903.h"
//   24 
//   25 /* Private typedef -----------------------------------------------------------*/
//   26 /* Private define ------------------------------------------------------------*/
//   27 #define EXTI_LineNone    ((u32)0x00000)  /* No interrupt selected */
//   28 
//   29 /* Private macro -------------------------------------------------------------*/
//   30 /* Private variables ---------------------------------------------------------*/
//   31 /* Private function prototypes -----------------------------------------------*/
//   32 /* Private functions ---------------------------------------------------------*/
//   33 extern unsigned char USART1PutChar(unsigned char Data);
//   34 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   35 void EXTI0_Init(void)
//   36 {
EXTI0_Init:
        PUSH     {R7,LR}
//   37 	INT8U tport = GPIO_PortSrcGPIOB;
//   38 //	INT8U trigger = EXTI_RisingEdge;
//   39 	
//   40 	INT8U trigger = EXTI_FallingEdge;
//   41 	// PORT SEL
//   42 	NVIC_Init(EXTI0_IRQChannel, ENABLE);	
        MOVS     R1,#+1
        MOVS     R0,#+6
        B.N      ?Subroutine0
//   43 	EXTI_Init(tport, GPIO_PinSrc12, trigger);
//   44 }
//   45 
//   46 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   47 void EXTI1_Init(void)
//   48 {
EXTI1_Init:
        PUSH     {R7,LR}
//   49 	INT8U tport = GPIO_PortSrcGPIOB;
//   50 //	INT8U trigger = EXTI_RisingEdge;
//   51 	
//   52 	INT8U trigger = EXTI_FallingEdge;
//   53 	// PORT SEL
//   54 	NVIC_Init(EXTI1_IRQChannel, ENABLE);	
        MOVS     R1,#+1
        MOVS     R0,#+7
        B.N      ?Subroutine0
//   55 	EXTI_Init(tport, GPIO_PinSrc12, trigger);
//   56 }
//   57 
//   58 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   59 void EXTI2_Init(void)
//   60 {
EXTI2_Init:
        PUSH     {R7,LR}
//   61 	INT8U tport = GPIO_PortSrcGPIOB;
//   62 //	INT8U trigger = EXTI_RisingEdge;
//   63 	
//   64 	INT8U trigger = EXTI_FallingEdge;
//   65 	// PORT SEL
//   66 	NVIC_Init(EXTI2_IRQChannel, ENABLE);	
        MOVS     R1,#+1
        MOVS     R0,#+8
        B.N      ?Subroutine0
//   67 	EXTI_Init(tport, GPIO_PinSrc12, trigger);
//   68 
//   69 	
//   70 }
//   71 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   72 void EXTI3_Init(void)
//   73 {
EXTI3_Init:
        PUSH     {R7,LR}
//   74 	INT8U tport = GPIO_PortSrcGPIOB;
//   75 //	INT8U trigger = EXTI_RisingEdge;
//   76 	
//   77 	INT8U trigger = EXTI_FallingEdge;
//   78 	// PORT SEL
//   79 	NVIC_Init(EXTI3_IRQChannel, ENABLE);	
        MOVS     R1,#+1
        MOVS     R0,#+9
        B.N      ?Subroutine0
//   80 	EXTI_Init(tport, GPIO_PinSrc12, trigger);
//   81 	
//   82 }
//   83 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 void EXTI4_Init(void)
//   85 {
EXTI4_Init:
        PUSH     {R7,LR}
//   86 	INT8U tport = GPIO_PortSrcGPIOC;
//   87 	INT8U trigger = EXTI_RisingEdge;
//   88 	
//   89 	// PORT SEL
//   90 	NVIC_Init(EXTI4_IRQChannel, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+10
        BL       NVIC_Init
//   91 	EXTI_Init(tport, GPIO_PinSrc4, trigger);
        MOVS     R2,#+8
        MOVS     R1,#+4
        MOVS     R0,#+2
        B.N      ??Subroutine4_0
//   92 }
//   93 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   94 void EXTI5_Init(void)
//   95 {
EXTI5_Init:
        PUSH     {R7,LR}
//   96 	INT8U tport = GPIO_PortSrcGPIOC;
//   97 	INT8U trigger = EXTI_RisingEdge;
//   98 	
//   99 	// PORT SEL
//  100 	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+23
        BL       NVIC_Init
//  101 	EXTI_Init(tport, GPIO_PinSrc5, trigger);
        MOVS     R2,#+8
        MOVS     R1,#+5
        MOVS     R0,#+2
        B.N      ??Subroutine4_0
//  102 }
//  103 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  104 void EXTI6_Init(void)
//  105 {
EXTI6_Init:
        PUSH     {R7,LR}
//  106 	INT8U tport = GPIO_PortSrcGPIOB;
//  107 	INT8U trigger = EXTI_RisingEdge;
//  108 	
//  109 	// PORT SEL
//  110 	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+23
        BL       NVIC_Init
//  111 	EXTI_Init(tport, GPIO_PinSrc6, trigger);
        MOVS     R2,#+8
        MOVS     R1,#+6
        B.N      ??Subroutine3_0
//  112 }
//  113 
//  114 /*******************************************************************************
//  115 * Function Name  : EXTI7_Init
//  116 * Description    : Initializes the EXTI peripheral according to the specified
//  117 *                  parameters in the EXTI_InitStruct.
//  118 * Input          : - tport   : pointer to a EXTI_InitTypeDef structure
//  119 *                  - tpin    : 
//  120 *				   - trigger :
//  121 * Output         : None
//  122 * Return         : None
//  123 *******************************************************************************/
//  124 #define EXTI7_PORT		GPIO_PortSrcGPIOA
//  125 
//  126 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  127 void EXTI7_Init(void)
//  128 {
EXTI7_Init:
        PUSH     {R7,LR}
//  129 	INT8U trigger = EXTI_RisingEdge;
//  130 	
//  131 	// PORT SEL
//  132 	NVIC_Init(EXTI9_5_IRQChannel, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+23
        BL       NVIC_Init
//  133 	EXTI_Init(EXTI7_PORT, GPIO_PinSrc7, trigger);
        MOVS     R2,#+8
        MOVS     R1,#+7
        MOVS     R0,#+0
        B.N      ??Subroutine4_0
//  134 }
//  135 
//  136 #define EXTI12_PORT		GPIO_PortSrcGPIOB
//  137 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  138 void EXTI12_Init(void)
//  139 {
EXTI12_Init:
        PUSH     {R7,LR}
//  140 //	INT8U trigger = EXTI_FallingEdge;
//  141 //	INT8U trigger = EXTI_RisingEdge;
//  142 	INT8U trigger = EXTI_Rising_FallingEdge;
//  143 
//  144 	// PORT SEL
//  145 	NVIC_Init(EXTI15_10_IRQChannel, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+40
        BL       NVIC_Init
//  146 	EXTI_Init(EXTI12_PORT, GPIO_PinSrc12, trigger);
        MOVS     R2,#+16
        B.N      ??Subroutine2_0
//  147 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine0:
        BL       NVIC_Init
        MOVS     R2,#+12
        Nop      
        REQUIRE ??Subroutine2_0
        ;; // Fall through to label ??Subroutine2_0

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
??Subroutine2_0:
        MOVS     R1,#+12
        Nop      
        REQUIRE ??Subroutine3_0
        ;; // Fall through to label ??Subroutine3_0

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
??Subroutine3_0:
        MOVS     R0,#+1
        Nop      
        REQUIRE ??Subroutine4_0
        ;; // Fall through to label ??Subroutine4_0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
??Subroutine4_0:
        POP      {R3,LR}
        B.W      EXTI_Init
//  148 
//  149 /*******************************************************************************
//  150 * Function Name  : EXTI0_IRQHandler
//  151 * Description    : This function handles External interrupt Line 0 request.
//  152 * Input          : None
//  153 * Output         : None
//  154 * Return         : None
//  155 *******************************************************************************/

        SECTION `.bss`:DATA:NOROOT(2)
//  156 u32 CurrINT = 0;
CurrINT:
        DS8 4
//  157 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  158 void EXTI0_IRQHandler(void)
//  159 {
EXTI0_IRQHandler:
        PUSH     {R7,LR}
//  160 	INT8U tpin = GPIO_PinSrc12;
//  161 
//  162 	OS_CPU_SR  cpu_sr;
//  163 
//  164 
//  165 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        B.N      ?Subroutine1
//  166 	OSIntNesting++;
//  167 	OS_EXIT_CRITICAL();
//  168 
//  169 	if(EXTI_GetITStatus((1 << tpin)) != RESET)
//  170 	{
//  171 		EXTI->PR = (1 << tpin);
//  172 	}
//  173 	OSIntExit();	
//  174 
//  175 }
//  176 
//  177 
//  178 /*******************************************************************************
//  179 * Function Name  : EXTI1_IRQHandler
//  180 * Description    : This function handles External interrupt Line 1 request.
//  181 * Input          : None
//  182 * Output         : None
//  183 * Return         : None
//  184 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  185 void EXTI1_IRQHandler(void)
//  186 {
EXTI1_IRQHandler:
        PUSH     {R7,LR}
//  187 	INT8U tpin = GPIO_PinSrc12;
//  188 
//  189 	OS_CPU_SR  cpu_sr;
//  190 
//  191 
//  192 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        B.N      ?Subroutine1
//  193 	OSIntNesting++;
//  194 	OS_EXIT_CRITICAL();
//  195 
//  196 	if(EXTI_GetITStatus((1 << tpin)) != RESET)
//  197 	{
//  198 		EXTI->PR = (1 << tpin);
//  199 	}
//  200 	OSIntExit();	
//  201 }
//  202 
//  203 
//  204 /*******************************************************************************
//  205 * Function Name  : EXTI2_IRQHandler
//  206 * Description    : This function handles External interrupt Line 2 request.
//  207 * Input          : None
//  208 * Output         : None
//  209 * Return         : None
//  210 *******************************************************************************/
//  211 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  212 void EXTI2_IRQHandler(void)
//  213 {
EXTI2_IRQHandler:
        PUSH     {R7,LR}
//  214 	INT8U tpin = GPIO_PinSrc12;
//  215 
//  216 	OS_CPU_SR  cpu_sr;
//  217 
//  218 
//  219 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        B.N      ?Subroutine1
//  220 	OSIntNesting++;
//  221 	OS_EXIT_CRITICAL();
//  222 
//  223 	if(EXTI_GetITStatus((1 << tpin)) != RESET)
//  224 	{
//  225 		EXTI->PR = (1 << tpin);
//  226 	}
//  227 	OSIntExit();	
//  228 }
//  229 //F_RESET_IN
//  230 
//  231 /*******************************************************************************
//  232 * Function Name  : EXTI3_IRQHandler
//  233 * Description    : This function handles External interrupt Line 3 request.
//  234 * Input          : None
//  235 * Output         : None
//  236 * Return         : None
//  237 *******************************************************************************/
//  238 
//  239 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  240 void EXTI3_IRQHandler(void)
//  241 {
EXTI3_IRQHandler:
        PUSH     {R7,LR}
        Nop      
//  242 	INT8U tpin = GPIO_PinSrc12;
//  243 
//  244 	OS_CPU_SR  cpu_sr;
//  245 
//  246 
//  247 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        BL       OS_CPU_SR_Save
        LDR.N    R1,??DataTable8  ;; OSIntNesting
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
        BL       OS_CPU_SR_Restore
        MOV      R0,#+4096
        BL       EXTI_GetITStatus
        CBZ      R0,??Subroutine1_0
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+4096
        STR      R1,[R0, #+0]
??Subroutine1_0:
        POP      {R0,LR}
        B.W      OSIntExit
//  248 	OSIntNesting++;
//  249 	OS_EXIT_CRITICAL();
//  250 
//  251 	if(EXTI_GetITStatus((1 << tpin)) != RESET)
//  252 	{
//  253 		EXTI->PR = (1 << tpin);
//  254 	}
//  255 	OSIntExit();	
//  256 }
//  257 
//  258 
//  259 
//  260 /*******************************************************************************
//  261 * Function Name  : EXTI4_IRQHandler
//  262 * Description    : This function handles External interrupt Line 4 request.
//  263 * Input          : None
//  264 * Output         : None
//  265 * Return         : None
//  266 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  267 void EXTI4_IRQHandler(void)
//  268 {
EXTI4_IRQHandler:
        PUSH     {R7,LR}
//  269 	INT8U tpin = GPIO_PinSrc12;
//  270 
//  271 	OS_CPU_SR  cpu_sr;
//  272 
//  273 
//  274 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        B.N      ?Subroutine1
//  275 	OSIntNesting++;
//  276 	OS_EXIT_CRITICAL();
//  277 
//  278 	if(EXTI_GetITStatus((1 << tpin)) != RESET)
//  279 	{
//  280 		EXTI->PR = (1 << tpin);
//  281 	}
//  282 	OSIntExit();	
//  283 }
//  284 
//  285 
//  286 /*******************************************************************************
//  287 * Function Name  : EXTI9_5_IRQHandler
//  288 * Description    : This function handles External lines 9 to 5 interrupt request.
//  289 * Input          : None
//  290 * Output         : None
//  291 * Return         : None
//  292 *******************************************************************************/
//  293 #define EXTI5_IN		GPIOA->IDR.Bit.IDR7
//  294 void ResetStart(void);
//  295 INT8U F_RESET_IN_Read(void);
//  296 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  297 void EXTI9_5_IRQHandler(void)
//  298 {
EXTI9_5_IRQHandler:
        PUSH     {R7,LR}
//  299 	OS_CPU_SR  cpu_sr;
//  300 
//  301 
//  302 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        BL       OS_CPU_SR_Save
//  303 	OSIntNesting++;
        LDR.N    R1,??DataTable8  ;; OSIntNesting
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  304 	OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  305 
//  306 	if(EXTI_GetITStatus((1 << GPIO_PinSrc5)) != RESET)
        MOVS     R0,#+32
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI9_5_IRQHandler_0
//  307 	{
//  308 		EXTI->PR = (1 << GPIO_PinSrc5);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOVS     R1,#+32
        B.N      ??EXTI9_5_IRQHandler_1
//  309 	}
//  310 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc6)) != RESET)
??EXTI9_5_IRQHandler_0:
        MOVS     R0,#+64
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI9_5_IRQHandler_2
//  311 	{
//  312 #if 1
//  313 		if(F_RESET_IN_Read())	CurrINT = 1;		// High
        BL       F_RESET_IN_Read
        CMP      R0,#+0
        ITE      NE 
        MOVNE    R0,#+1
        MOVEQ    R0,#+2
//  314 		else					CurrINT = 2;		// LOW
        LDR.N    R1,??EXTI9_5_IRQHandler_3  ;; CurrINT
        STR      R0,[R1, #+0]
//  315 
//  316 		ResetStart();
        BL       ResetStart
//  317 #endif
//  318 
//  319 
//  320 		EXTI->PR = (1 << GPIO_PinSrc6);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOVS     R1,#+64
        B.N      ??EXTI9_5_IRQHandler_1
//  321 	}
//  322 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc7)) != RESET)
??EXTI9_5_IRQHandler_2:
        MOVS     R0,#+128
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI9_5_IRQHandler_4
//  323 	{
//  324 		EXTI->PR = (1 << GPIO_PinSrc7);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOVS     R1,#+128
        B.N      ??EXTI9_5_IRQHandler_1
//  325 
//  326 	}
//  327 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc8)) != RESET)
??EXTI9_5_IRQHandler_4:
        MOV      R0,#+256
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI9_5_IRQHandler_5
//  328 	{
//  329 		EXTI->PR = (1 << GPIO_PinSrc8);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+256
        B.N      ??EXTI9_5_IRQHandler_1
//  330 	}
//  331 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc9)) != RESET)
??EXTI9_5_IRQHandler_5:
        MOV      R0,#+512
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI9_5_IRQHandler_6
//  332 	{
//  333 		EXTI->PR = (1 << GPIO_PinSrc9);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+512
??EXTI9_5_IRQHandler_1:
        STR      R1,[R0, #+0]
//  334 	}
//  335 
//  336 	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
??EXTI9_5_IRQHandler_6:
        B.N      ??Subroutine1_0
        Nop      
        DATA
??EXTI9_5_IRQHandler_3:
        DC32     CurrINT
//  337 }
//  338 
//  339 
//  340 /*******************************************************************************
//  341 * Function Name  : EXTI15_10_IRQHandler
//  342 * Description    : This function handles External lines 15 to 10 interrupt request.
//  343 * Input          : None
//  344 * Output         : None
//  345 * Return         : None
//  346 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  347 void EXTI15_10_IRQHandler(void)
//  348 {
EXTI15_10_IRQHandler:
        PUSH     {R7,LR}
//  349 	OS_CPU_SR  cpu_sr;
//  350 
//  351 
//  352 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        BL       OS_CPU_SR_Save
//  353 	OSIntNesting++;
        LDR.N    R1,??DataTable8  ;; OSIntNesting
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  354 	OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  355 
//  356 	if(EXTI_GetITStatus((1 << GPIO_PinSrc10)) != RESET)
        MOV      R0,#+1024
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI15_10_IRQHandler_0
//  357 	{
//  358 		EXTI->PR = (1 << GPIO_PinSrc10);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+1024
        B.N      ??EXTI15_10_IRQHandler_1
//  359 	}
//  360 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc11)) != RESET)
??EXTI15_10_IRQHandler_0:
        MOV      R0,#+2048
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI15_10_IRQHandler_2
//  361 	{
//  362 		EXTI->PR = (1 << GPIO_PinSrc11);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+2048
        B.N      ??EXTI15_10_IRQHandler_1
//  363 	}
//  364 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc12)) != RESET)
??EXTI15_10_IRQHandler_2:
        MOV      R0,#+4096
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI15_10_IRQHandler_3
//  365 	{
//  366 #if 0
//  367 		if(F_RESET_IN_Read())  	CurrINT = 1;		// High
//  368 		else 					CurrINT = 2;		// LOW
//  369 
//  370 		ResetStart();
//  371 #endif
//  372 		EXTI->PR = (1 << GPIO_PinSrc12);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+4096
        B.N      ??EXTI15_10_IRQHandler_1
//  373 
//  374 	}
//  375 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc13)) != RESET)
??EXTI15_10_IRQHandler_3:
        MOV      R0,#+8192
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI15_10_IRQHandler_4
//  376 	{
//  377 		EXTI->PR = (1 << GPIO_PinSrc13);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+8192
        B.N      ??EXTI15_10_IRQHandler_1
//  378 	}
//  379 	else if(EXTI_GetITStatus((1 << GPIO_PinSrc14)) != RESET)
??EXTI15_10_IRQHandler_4:
        MOV      R0,#+16384
        BL       EXTI_GetITStatus
        CBZ      R0,??EXTI15_10_IRQHandler_5
//  380 	{
//  381 		EXTI->PR = (1 << GPIO_PinSrc14);
        LDR.N    R0,??DataTable13  ;; 0x40010414
        MOV      R1,#+16384
??EXTI15_10_IRQHandler_1:
        STR      R1,[R0, #+0]
//  382 	}
//  383 
//  384 	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
??EXTI15_10_IRQHandler_5:
        B.N      ??Subroutine1_0
//  385 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13:
        DC32     0x40010414

        END
//  386 
//  387 
//  388 
//  389 
//  390 /* Configure EXTI Line9 to generate an interrupt on falling edge */  
//  391 /**
//  392 EXTI_InitStructure.EXTI_Line = EXTI_Line9;
//  393 EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
//  394 EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;
//  395 EXTI_InitStructure.EXTI_LineCmd = ENABLE;
//  396 EXTI_Init(&EXTI_InitStructure);
//  397 **/
//  398 // Generate software interrupt: simulate a falling edge applied on EXTI line 9
//  399 /********
//  400 void EXTI_Init(EXTI_InitTypeDef* EXTI_InitStruct)
//  401 {
//  402 	// Check the parameters
//  403 	// assert(IS_EXTI_MODE(EXTI_InitStruct->EXTI_Mode));
//  404 	// assert(IS_EXTI_TRIGGER(EXTI_InitStruct->EXTI_Trigger));
//  405 	// assert(IS_EXTI_LINE(EXTI_InitStruct->EXTI_Line));  
//  406 	// assert(IS_FUNCTIONAL_STATE(EXTI_InitStruct->EXTI_LineCmd));
//  407 	 
//  408 	if (EXTI_InitStruct->EXTI_LineCmd != DISABLE)
//  409 	{
//  410 	    *(u32 *)(EXTI_BASE + (u32)EXTI_InitStruct->EXTI_Mode)|= EXTI_InitStruct->EXTI_Line;
//  411 
//  412 	    // Clear Rising Falling edge configuration
//  413 	    EXTI->RTSR &= ~EXTI_InitStruct->EXTI_Line;
//  414 	    EXTI->FTSR &= ~EXTI_InitStruct->EXTI_Line;
//  415 	    
//  416 	    // Select the trigger for the selected external interrupts 
//  417 	    if (EXTI_InitStruct->EXTI_Trigger == EXTI_Rising_FallingEdge)
//  418 	    {
//  419 	      // Rising Falling edge
//  420 	      EXTI->RTSR |= EXTI_InitStruct->EXTI_Line;
//  421 	      EXTI->FTSR |= EXTI_InitStruct->EXTI_Line;
//  422 	    }
//  423 	    else
//  424 	    {
//  425 	    	*(u32 *)(EXTI_BASE + (u32)EXTI_InitStruct->EXTI_Trigger)|= EXTI_InitStruct->EXTI_Line;
//  426 	    }
//  427 	}
//  428 	else
//  429 	{
//  430 		// Disable the selected external lines
//  431 		// *(u32 *)(EXTI_BASE + (u32)EXTI_InitStruct->EXTI_Mode)&= ~EXTI_InitStruct->EXTI_Line;
//  432 	}
//  433 }
//  434 ****/
//  435 
//  436 
//  437 
//  438 /******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
//  439 
// 
//   4 bytes in section .bss
// 444 bytes in section .text
// 
// 444 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
