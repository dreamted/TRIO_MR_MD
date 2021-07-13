///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:05 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\stm32f2xx_it_1208.c                                 /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\stm32f2xx_it_1208.c -D OS_INCLUDED -D APPL_SRC -lA  /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ -o           /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\out\              /
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
//                    -Oh --use_c++_inline                                    /
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_it_ /
//                    1208.s                                                  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_it_1208

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN ADC_IRQInitHandler
        EXTERN EXTI_GetITStatus
        EXTERN OSIntExit
        EXTERN OSIntNesting
        EXTERN OSTimeTick
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN USART1_IRQIntHandler
        EXTERN USART2_IRQIntHandler
        EXTERN USART3_IRQIntHandler
        EXTERN USART4_IRQIntHandler
        EXTERN USART5_IRQIntHandler
        EXTERN USART6_IRQIntHandler
        EXTERN USART7Handler

        PUBLIC ADC3_IRQHandler
        PUBLIC ADC_IRQHandler
        PUBLIC BusFaultException
        PUBLIC CAN2_RX0_IRQHandler
        PUBLIC CAN2_RX1_IRQHandler
        PUBLIC CAN2_SCE_IRQHandler
        PUBLIC CAN2_TX_IRQHandler
        PUBLIC CAN_RX1_IRQHandler
        PUBLIC CAN_SCE_IRQHandler
        PUBLIC CRYP_IRQHandler
        PUBLIC DCMI_IRQHandler
        PUBLIC DMA2_Stream0_IRQHandler
        PUBLIC DMA2_Stream1_IRQHandler
        PUBLIC DMA2_Stream2_IRQHandler
        PUBLIC DMA2_Stream3_IRQHandler
        PUBLIC DMA2_Stream4_IRQHandler
        PUBLIC DMA2_Stream5_IRQHandler
        PUBLIC DMA2_Stream6_IRQHandler
        PUBLIC DMA2_Stream7_IRQHandler
        PUBLIC DMAChannel1_IRQHandler
        PUBLIC DMAChannel2_IRQHandler
        PUBLIC DMAChannel3_IRQHandler
        PUBLIC DMAChannel4_IRQHandler
        PUBLIC DMAChannel5_IRQHandler
        PUBLIC DMAChannel6_IRQHandler
        PUBLIC DMAChannel7_IRQHandler
        PUBLIC DebugMonitor
        PUBLIC ETH_IRQHandler
        PUBLIC ETH_WKUP_IRQHandler
        PUBLIC EXTI0_IRQHandler
        PUBLIC EXTI15_10_IRQHandler
        PUBLIC EXTI1_IRQHandler
        PUBLIC EXTI2_IRQHandler
        PUBLIC EXTI3_IRQHandler
        PUBLIC EXTI4_IRQHandler
        PUBLIC EXTI9_5_IRQHandler
        PUBLIC FLASH_IRQHandler
        PUBLIC FSMC_IRQHandler
        PUBLIC HASH_RNG_IRQHandler
        PUBLIC HardFaultException
        PUBLIC I2C1_ER_IRQHandler
        PUBLIC I2C1_EV_IRQHandler
        PUBLIC I2C2_ER_IRQHandler
        PUBLIC I2C2_EV_IRQHandler
        PUBLIC I2C3_ER_IRQHandler
        PUBLIC I2C3_EV_IRQHandler
        PUBLIC MemManageException
        PUBLIC NMIException
        PUBLIC OTG_FS_IRQHandler
        PUBLIC OTG_HS_EP1_IN_IRQHandler
        PUBLIC OTG_HS_EP1_OUT_IRQHandler
        PUBLIC OTG_HS_IRQHandler
        PUBLIC OTG_HS_WKUP_IRQHandler
        PUBLIC PVD_IRQHandler
        PUBLIC PendSVC
        PUBLIC RCC_IRQHandler
        PUBLIC RTCAlarm_IRQHandler
        PUBLIC RTC_IRQHandler
        PUBLIC SDIO_IRQHandler
        PUBLIC SPI1_IRQHandler
        PUBLIC SPI2_IRQHandler
        PUBLIC SPI3_IRQHandler
        PUBLIC SVCHandler
        PUBLIC SysTickHandler
        PUBLIC TAMPER_IRQHandler
        PUBLIC TIM1_BRK_IRQHandler
        PUBLIC TIM1_CC_IRQHandler
        PUBLIC TIM1_TRG_COM_IRQHandler
        PUBLIC TIM1_UP_IRQHandler
        PUBLIC TIM2_IRQHandler
        PUBLIC TIM3_IRQHandler
        PUBLIC TIM4_IRQHandler
        PUBLIC TIM5_IRQHandler
        PUBLIC TIM6_IRQHandler
        PUBLIC TIM7_IRQHandler
        PUBLIC TIM8_BRK_IRQHandler
        PUBLIC TIM8_CC_IRQHandler
        PUBLIC TIM8_TRG_COM_IRQHandler
        PUBLIC TIM8_UP_IRQHandler
        PUBLIC UART4_IRQHandler
        PUBLIC UART5_IRQHandler
        PUBLIC USART1_IRQHandler
        PUBLIC USART2_IRQHandler
        PUBLIC USART3_IRQHandler
        PUBLIC USART6_IRQHandler
        PUBLIC USBWakeUp_IRQHandler
        PUBLIC USB_HP_CAN_TX_IRQHandler
        PUBLIC USB_LP_CAN_RX0_IRQHandler
        PUBLIC UsageFaultException
        PUBLIC WWDG_IRQHandler
        
        CFI Names cfiNames0
        CFI StackFrame CFA R13 DATA
        CFI Resource R0:32, R1:32, R2:32, R3:32, R4:32, R5:32, R6:32, R7:32
        CFI Resource R8:32, R9:32, R10:32, R11:32, R12:32, R13:32, R14:32
        CFI EndNames cfiNames0
        
        CFI Common cfiCommon0 Using cfiNames0
        CFI CodeAlign 2
        CFI DataAlign 4
        CFI ReturnAddress R14 CODE
        CFI CFA R13+0
        CFI R0 Undefined
        CFI R1 Undefined
        CFI R2 Undefined
        CFI R3 Undefined
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R12 Undefined
        CFI R14 SameValue
        CFI EndCommon cfiCommon0
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\stm32f2xx_it_1208.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    STM32F2xx_IAP/src/stm32f2xx_it.c 
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    02-May-2011
//    7   * @brief   Main Interrupt Service Routines.
//    8   *          This file provides template for all exceptions handler and 
//    9   *          peripherals interrupt service routine.
//   10   ******************************************************************************
//   11   * @attention
//   12   *
//   13   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   14   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   15   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   16   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   17   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   18   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   19   *
//   20   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   21   ******************************************************************************
//   22   */ 
//   23 
//   24 
//   25 /* Includes ------------------------------------------------------------------*/
//   26 #if defined(OS_INCLUED)
//   27 #include "includes.h"
//   28 #else
//   29 #include "stm32f2xx_1208.h"
//   30 #endif /* OS_INCLUED */
//   31 
//   32 
//   33 /** @addtogroup STM32F2xx_IAP
//   34   * @{
//   35   */
//   36 
//   37 /* Private typedef -----------------------------------------------------------*/
//   38 /* Private define ------------------------------------------------------------*/
//   39 /* Private macro -------------------------------------------------------------*/
//   40 /* Private variables ---------------------------------------------------------*/
//   41 /* Private function prototypes -----------------------------------------------*/
//   42 /* Private functions ---------------------------------------------------------*/
//   43 
//   44 /******************************************************************************/
//   45 /*            Cortex-M3 Processor Exceptions Handlers                         */
//   46 /******************************************************************************/
//   47 
//   48 /*******************************************************************************
//   49 * Function Name  : NMIException
//   50 * Description    : This function handles NMI exception.
//   51 * Input          : None
//   52 * Output         : None
//   53 * Return         : None
//   54 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function NMIException
        THUMB
//   55 void NMIException(void)
//   56 {
//   57 
//   58 }
NMIException:
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   59 
//   60 /*******************************************************************************
//   61 * Function Name  : HardFaultException
//   62 * Description    : This function handles Hard Fault exception.
//   63 * Input          : None
//   64 * Output         : None
//   65 * Return         : None
//   66 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function HardFaultException
        THUMB
//   67 void HardFaultException(void)
//   68 {
//   69 
//   70 }
HardFaultException:
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//   71 
//   72 /*******************************************************************************
//   73 * Function Name  : MemManageException
//   74 * Description    : This function handles Memory Manage exception.
//   75 * Input          : None
//   76 * Output         : None
//   77 * Return         : None
//   78 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function MemManageException
        THUMB
//   79 void MemManageException(void)
//   80 {
//   81 
//   82 }
MemManageException:
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//   83 
//   84 /*******************************************************************************
//   85 * Function Name  : BusFaultException
//   86 * Description    : This function handles Bus Fault exception.
//   87 * Input          : None
//   88 * Output         : None
//   89 * Return         : None
//   90 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function BusFaultException
        THUMB
//   91 void BusFaultException(void)
//   92 {
//   93 
//   94 }
BusFaultException:
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//   95 
//   96 /*******************************************************************************
//   97 * Function Name  : UsageFaultException
//   98 * Description    : This function handles Usage Fault exception.
//   99 * Input          : None
//  100 * Output         : None
//  101 * Return         : None
//  102 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function UsageFaultException
        THUMB
//  103 void UsageFaultException(void)
//  104 {
//  105 
//  106 }
UsageFaultException:
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  107 
//  108 /*******************************************************************************
//  109 * Function Name  : DebugMonitor
//  110 * Description    : This function handles Debug Monitor exception.
//  111 * Input          : None
//  112 * Output         : None
//  113 * Return         : None
//  114 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function DebugMonitor
        THUMB
//  115 void DebugMonitor(void)
//  116 {
//  117 
//  118 }
DebugMonitor:
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  119 
//  120 /*******************************************************************************
//  121 * Function Name  : SVCHandler
//  122 * Description    : This function handles SVCall exception.
//  123 * Input          : None
//  124 * Output         : None
//  125 * Return         : None
//  126 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function SVCHandler
        THUMB
//  127 void SVCHandler(void)
//  128 {
//  129 
//  130 }
SVCHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  131 
//  132 /*******************************************************************************
//  133 * Function Name  : PendSVC
//  134 * Description    : This function handles PendSVC exception.
//  135 * Input          : None
//  136 * Output         : None
//  137 * Return         : None
//  138 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function PendSVC
        THUMB
//  139 void PendSVC(void)
//  140 {
//  141 
//  142 }
PendSVC:
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  143 
//  144 #if !defined(OS_INCLUED)
//  145 extern void SysTickIntHandler(void);
//  146 #endif /* OS_INCLUED */
//  147 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SysTickHandler
        THUMB
//  148 void SysTickHandler(void)
//  149 {
SysTickHandler:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  150 #ifdef OS_INCLUDED
//  151 	OS_CPU_SR  cpu_sr;
//  152 
//  153 
//  154 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        BL       OS_CPU_SR_Save
//  155 	OSIntNesting++;
        LDR.N    R1,??DataTable1
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  156 	OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  157 
//  158 	OSTimeTick();												// Call uC/OS-II's OSTimeTick()
        BL       OSTimeTick
//  159 	OSIntExit();												// Tell uC/OS-II that we are leaving the ISR
        POP      {R0,LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      OSIntExit
        CFI EndBlock cfiBlock8
//  160 #else	/* OS_INCLUED */
//  161 	SysTickIntHandler();
//  162 #endif /* OS_INCLUED */
//  163 }
//  164 /*******************************************************************************
//  165 * Function Name  : WWDG_IRQHandler
//  166 * Description    : This function handles WWDG interrupt request.
//  167 * Input          : None
//  168 * Output         : None
//  169 * Return         : None
//  170 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function WWDG_IRQHandler
        THUMB
//  171 void WWDG_IRQHandler(void)
//  172 {
//  173 
//  174 }
WWDG_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  175 
//  176 
//  177 /*******************************************************************************
//  178 * Function Name  : PVD_IRQHandler
//  179 * Description    : This function handles PVD interrupt request.
//  180 * Input          : None
//  181 * Output         : None
//  182 * Return         : None
//  183 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function PVD_IRQHandler
        THUMB
//  184 void PVD_IRQHandler(void)
//  185 {
//  186 
//  187 }
PVD_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  188 
//  189 /*******************************************************************************
//  190 * Function Name  : TAMPER_IRQHandler
//  191 * Description    : This function handles Tamper interrupt request.
//  192 * Input          : None
//  193 * Output         : None
//  194 * Return         : None
//  195 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function TAMPER_IRQHandler
        THUMB
//  196 void TAMPER_IRQHandler(void)
//  197 {
//  198 
//  199 }
TAMPER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  200 
//  201 /*******************************************************************************
//  202 * Function Name  : RTC_IRQHandler
//  203 * Description    : This function handles RTC global interrupt request.
//  204 * Input          : None
//  205 * Output         : None
//  206 * Return         : None
//  207 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function RTC_IRQHandler
        THUMB
//  208 void RTC_IRQHandler(void)
//  209 {
//  210 
//  211 }
RTC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  212 
//  213 /*******************************************************************************
//  214 * Function Name  : FLASH_IRQHandler
//  215 * Description    : This function handles Flash interrupt request.
//  216 * Input          : None
//  217 * Output         : None
//  218 * Return         : None
//  219 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function FLASH_IRQHandler
        THUMB
//  220 void FLASH_IRQHandler(void)
//  221 {
//  222 
//  223 }
FLASH_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  224 
//  225 /*******************************************************************************
//  226 * Function Name  : RCC_IRQHandler
//  227 * Description    : This function handles RCC interrupt request.
//  228 * Input          : None
//  229 * Output         : None
//  230 * Return         : None
//  231 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function RCC_IRQHandler
        THUMB
//  232 void RCC_IRQHandler(void)
//  233 {
//  234 
//  235 }
RCC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  236 
//  237 
//  238 
//  239 
//  240 /*******************************************************************************
//  241 * Function Name  : EXTI0_IRQHandler
//  242 * Description    : This function handles External interrupt Line 0 request.
//  243 * Input          : None
//  244 * Output         : None
//  245 * Return         : None
//  246 *******************************************************************************/
//  247 #define EXTI0_IN		GPIOB->__B.IDR.B0
//  248 	
//  249 extern	void USART7Handler(void);
//  250 #include "stm32f2xx_exti.h"
//  251 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function EXTI0_IRQHandler
        THUMB
//  252 void EXTI0_IRQHandler(void)
//  253 {
EXTI0_IRQHandler:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  254 	INT8U tpin = GPIO_PinSource0;
//  255 	
//  256 	OS_CPU_SR  cpu_sr;
//  257 
//  258 	OS_ENTER_CRITICAL();										// Tell uC/OS-II that we are starting an ISR
        BL       OS_CPU_SR_Save
//  259 	OSIntNesting++;
        LDR.N    R1,??DataTable1
        LDRB     R2,[R1, #+0]
        ADDS     R2,R2,#+1
        STRB     R2,[R1, #+0]
//  260 	OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  261 
//  262 	if(EXTI_GetITStatus((1 << tpin)) != RESET)
        MOVS     R0,#+1
        BL       EXTI_GetITStatus
        CBZ.N    R0,??EXTI0_IRQHandler_0
//  263 	{
//  264 		EXTI->PR = (1 << tpin);
        LDR.N    R0,??DataTable1_1  ;; 0x40013c14
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
        LDR.N    R4,??DataTable1_2  ;; 0x40020410
        B.N      ??EXTI0_IRQHandler_1
//  265 		// Action Function Insert
//  266 		while(EXTI0_IN)
//  267 		{
//  268 			USART7Handler();
??EXTI0_IRQHandler_2:
        BL       USART7Handler
//  269 		}
??EXTI0_IRQHandler_1:
        LDR      R0,[R4, #+0]
        LSLS     R0,R0,#+31
        BMI.N    ??EXTI0_IRQHandler_2
//  270 	}
//  271 	OSIntExit();	
??EXTI0_IRQHandler_0:
        POP      {R4,LR}
        CFI R4 SameValue
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      OSIntExit
        CFI EndBlock cfiBlock15
//  272 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0x40013c14

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     0x40020410
//  273 
//  274 
//  275 /*******************************************************************************
//  276 * Function Name  : EXTI1_IRQHandler
//  277 * Description    : This function handles External interrupt Line 1 request.
//  278 * Input          : None
//  279 * Output         : None
//  280 * Return         : None
//  281 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function EXTI1_IRQHandler
        THUMB
//  282 void EXTI1_IRQHandler(void)
//  283 {
//  284 
//  285 }
EXTI1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  286 
//  287 /*******************************************************************************
//  288 * Function Name  : EXTI2_IRQHandler
//  289 * Description    : This function handles External interrupt Line 2 request.
//  290 * Input          : None
//  291 * Output         : None
//  292 * Return         : None
//  293 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function EXTI2_IRQHandler
        THUMB
//  294 void EXTI2_IRQHandler(void)
//  295 {
//  296 
//  297 
//  298 }
EXTI2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  299 
//  300 /*******************************************************************************
//  301 * Function Name  : EXTI3_IRQHandler
//  302 * Description    : This function handles External interrupt Line 3 request.
//  303 * Input          : None
//  304 * Output         : None
//  305 * Return         : None
//  306 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function EXTI3_IRQHandler
        THUMB
//  307 void EXTI3_IRQHandler(void)
//  308 {
//  309 
//  310 }
EXTI3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//  311 
//  312 /*******************************************************************************
//  313 * Function Name  : EXTI4_IRQHandler
//  314 * Description    : This function handles External interrupt Line 4 request.
//  315 * Input          : None
//  316 * Output         : None
//  317 * Return         : None
//  318 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function EXTI4_IRQHandler
        THUMB
//  319 void EXTI4_IRQHandler(void)
//  320 {
//  321 
//  322 }
EXTI4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//  323 
//  324 /*******************************************************************************
//  325 * Function Name  : DMAChannel1_IRQHandler
//  326 * Description    : This function handles DMA Stream 1 interrupt request.
//  327 * Input          : None
//  328 * Output         : None
//  329 * Return         : None
//  330 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function DMAChannel1_IRQHandler
        THUMB
//  331 void DMAChannel1_IRQHandler(void)
//  332 {
//  333 
//  334 }
DMAChannel1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock20
//  335 
//  336 /*******************************************************************************
//  337 * Function Name  : DMAChannel2_IRQHandler
//  338 * Description    : This function handles DMA Stream 2 interrupt request.
//  339 * Input          : None
//  340 * Output         : None
//  341 * Return         : None
//  342 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function DMAChannel2_IRQHandler
        THUMB
//  343 void DMAChannel2_IRQHandler(void)
//  344 {
//  345 
//  346 }
DMAChannel2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
//  347 
//  348 /*******************************************************************************
//  349 * Function Name  : DMAChannel3_IRQHandler
//  350 * Description    : This function handles DMA Stream 3 interrupt request.
//  351 * Input          : None
//  352 * Output         : None
//  353 * Return         : None
//  354 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function DMAChannel3_IRQHandler
        THUMB
//  355 void DMAChannel3_IRQHandler(void)
//  356 {
//  357 
//  358 }
DMAChannel3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//  359 
//  360 /*******************************************************************************
//  361 * Function Name  : DMAChannel4_IRQHandler
//  362 * Description    : This function handles DMA Stream 4 interrupt request.
//  363 * Input          : None
//  364 * Output         : None
//  365 * Return         : None
//  366 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function DMAChannel4_IRQHandler
        THUMB
//  367 void DMAChannel4_IRQHandler(void)
//  368 {
//  369 
//  370 }
DMAChannel4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock23
//  371 
//  372 /*******************************************************************************
//  373 * Function Name  : DMAChannel5_IRQHandler
//  374 * Description    : This function handles DMA Stream 5 interrupt request.
//  375 * Input          : None
//  376 * Output         : None
//  377 * Return         : None
//  378 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function DMAChannel5_IRQHandler
        THUMB
//  379 void DMAChannel5_IRQHandler(void)
//  380 {
//  381 
//  382 }
DMAChannel5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
//  383 
//  384 /*******************************************************************************
//  385 * Function Name  : DMAChannel6_IRQHandler
//  386 * Description    : This function handles DMA Stream 6 interrupt request.
//  387 * Input          : None
//  388 * Output         : None
//  389 * Return         : None
//  390 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function DMAChannel6_IRQHandler
        THUMB
//  391 void DMAChannel6_IRQHandler(void)
//  392 {
//  393 
//  394 }
DMAChannel6_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
//  395 
//  396 /*******************************************************************************
//  397 * Function Name  : DMAChannel7_IRQHandler
//  398 * Description    : This function handles DMA Stream 7 interrupt request.
//  399 * Input          : None
//  400 * Output         : None
//  401 * Return         : None
//  402 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function DMAChannel7_IRQHandler
        THUMB
//  403 void DMAChannel7_IRQHandler(void)
//  404 {
//  405 
//  406 
//  407 }
DMAChannel7_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
//  408 
//  409 /*******************************************************************************
//  410 * Function Name  : ADC_IRQHandler
//  411 * Description    : This function handles ADC global interrupt request.
//  412 * Input          : None
//  413 * Output         : None
//  414 * Return         : None
//  415 *******************************************************************************/
//  416 
//  417 extern	void ADC_IRQInitHandler(void);

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function ADC_IRQHandler
        THUMB
//  418 void ADC_IRQHandler(void)
//  419 {
//  420 	ADC_IRQInitHandler();
ADC_IRQHandler:
        B.W      ADC_IRQInitHandler
        CFI EndBlock cfiBlock27
//  421 }
//  422 
//  423 /*******************************************************************************
//  424 * Function Name  : USB_HP_CAN_TX_IRQHandler
//  425 * Description    : This function handles USB High Priority or CAN TX interrupts
//  426 *                  requests.
//  427 * Input          : None
//  428 * Output         : None
//  429 * Return         : None
//  430 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function USB_HP_CAN_TX_IRQHandler
        THUMB
//  431 void USB_HP_CAN_TX_IRQHandler(void)
//  432 {
//  433 
//  434 }
USB_HP_CAN_TX_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock28
//  435 
//  436 /*******************************************************************************
//  437 * Function Name  : USB_LP_CAN_RX0_IRQHandler
//  438 * Description    : This function handles USB Low Priority or CAN RX0 interrupts
//  439 *                  requests.
//  440 * Input          : None
//  441 * Output         : None
//  442 * Return         : None
//  443 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function USB_LP_CAN_RX0_IRQHandler
        THUMB
//  444 void USB_LP_CAN_RX0_IRQHandler(void)
//  445 {
//  446 
//  447 }
USB_LP_CAN_RX0_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock29
//  448 
//  449 /*******************************************************************************
//  450 * Function Name  : CAN_RX1_IRQHandler
//  451 * Description    : This function handles CAN RX1 interrupt request.
//  452 * Input          : None
//  453 * Output         : None
//  454 * Return         : None
//  455 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI Function CAN_RX1_IRQHandler
        THUMB
//  456 void CAN_RX1_IRQHandler(void)
//  457 {
//  458 
//  459 }
CAN_RX1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock30
//  460 
//  461 /*******************************************************************************
//  462 * Function Name  : CAN_SCE_IRQHandler
//  463 * Description    : This function handles CAN SCE interrupt request.
//  464 * Input          : None
//  465 * Output         : None
//  466 * Return         : None
//  467 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock31 Using cfiCommon0
        CFI Function CAN_SCE_IRQHandler
        THUMB
//  468 void CAN_SCE_IRQHandler(void)
//  469 {
//  470 
//  471 }
CAN_SCE_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock31
//  472 
//  473 /*******************************************************************************
//  474 * Function Name  : EXTI9_5_IRQHandler
//  475 * Description    : This function handles External lines 9 to 5 interrupt request.
//  476 * Input          : None
//  477 * Output         : None
//  478 * Return         : None
//  479 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock32 Using cfiCommon0
        CFI Function EXTI9_5_IRQHandler
        THUMB
//  480 void EXTI9_5_IRQHandler(void)
//  481 {
//  482 
//  483 }
EXTI9_5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock32
//  484 
//  485 /*******************************************************************************
//  486 * Function Name  : TIM1_BRK_IRQHandler
//  487 * Description    : This function handles TIM1 Break interrupt request.
//  488 * Input          : None
//  489 * Output         : None
//  490 * Return         : None
//  491 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock33 Using cfiCommon0
        CFI Function TIM1_BRK_IRQHandler
        THUMB
//  492 void TIM1_BRK_IRQHandler(void)
//  493 {
//  494 
//  495 }
TIM1_BRK_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock33
//  496 
//  497 /*******************************************************************************
//  498 * Function Name  : TIM1_UP_IRQHandler
//  499 * Description    : This function handles TIM1 overflow and update interrupt
//  500 *                  request.
//  501 * Input          : None
//  502 * Output         : None
//  503 * Return         : None
//  504 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock34 Using cfiCommon0
        CFI Function TIM1_UP_IRQHandler
        THUMB
//  505 void TIM1_UP_IRQHandler(void)
//  506 {
//  507 
//  508 }
TIM1_UP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock34
//  509 
//  510 /*******************************************************************************
//  511 * Function Name  : TIM1_TRG_COM_IRQHandler
//  512 * Description    : This function handles TIM1 Trigger and Commutation interrupts
//  513 *                  requests.
//  514 * Input          : None
//  515 * Output         : None
//  516 * Return         : None
//  517 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock35 Using cfiCommon0
        CFI Function TIM1_TRG_COM_IRQHandler
        THUMB
//  518 void TIM1_TRG_COM_IRQHandler(void)
//  519 {
//  520 
//  521 }
TIM1_TRG_COM_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock35
//  522 
//  523 /*******************************************************************************
//  524 * Function Name  : TIM1_CC_IRQHandler
//  525 * Description    : This function handles TIM1 capture compare interrupt request.
//  526 * Input          : None
//  527 * Output         : None
//  528 * Return         : None
//  529 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock36 Using cfiCommon0
        CFI Function TIM1_CC_IRQHandler
        THUMB
//  530 void TIM1_CC_IRQHandler(void)
//  531 {
//  532 
//  533 }
TIM1_CC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock36
//  534 
//  535 /*******************************************************************************
//  536 * Function Name  : TIM2_IRQHandler
//  537 * Description    : This function handles TIM2 global interrupt request.
//  538 * Input          : None
//  539 * Output         : None
//  540 * Return         : None
//  541 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock37 Using cfiCommon0
        CFI Function TIM2_IRQHandler
        THUMB
//  542 void TIM2_IRQHandler(void)
//  543 {
//  544 
//  545 }
TIM2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock37
//  546 
//  547 /*******************************************************************************
//  548 * Function Name  : TIM3_IRQHandler
//  549 * Description    : This function handles TIM3 global interrupt request.
//  550 * Input          : None
//  551 * Output         : None
//  552 * Return         : None
//  553 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock38 Using cfiCommon0
        CFI Function TIM3_IRQHandler
        THUMB
//  554 void TIM3_IRQHandler(void)
//  555 {
//  556 
//  557 }
TIM3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock38
//  558 
//  559 /*******************************************************************************
//  560 * Function Name  : TIM4_IRQHandler
//  561 * Description    : This function handles TIM4 global interrupt request.
//  562 * Input          : None
//  563 * Output         : None
//  564 * Return         : None
//  565 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock39 Using cfiCommon0
        CFI Function TIM4_IRQHandler
        THUMB
//  566 void TIM4_IRQHandler(void)
//  567 {
//  568 
//  569 }
TIM4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock39
//  570 
//  571 /*******************************************************************************
//  572 * Function Name  : I2C1_EV_IRQHandler
//  573 * Description    : This function handles I2C1 Event interrupt request.
//  574 * Input          : None
//  575 * Output         : None
//  576 * Return         : None
//  577 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock40 Using cfiCommon0
        CFI Function I2C1_EV_IRQHandler
        THUMB
//  578 void I2C1_EV_IRQHandler(void)
//  579 {
//  580 
//  581 }
I2C1_EV_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock40
//  582 
//  583 /*******************************************************************************
//  584 * Function Name  : I2C1_ER_IRQHandler
//  585 * Description    : This function handles I2C1 Error interrupt request.
//  586 * Input          : None
//  587 * Output         : None
//  588 * Return         : None
//  589 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock41 Using cfiCommon0
        CFI Function I2C1_ER_IRQHandler
        THUMB
//  590 void I2C1_ER_IRQHandler(void)
//  591 {
//  592 
//  593 }
I2C1_ER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock41
//  594 
//  595 /*******************************************************************************
//  596 * Function Name  : I2C2_EV_IRQHandler
//  597 * Description    : This function handles I2C2 Event interrupt request.
//  598 * Input          : None
//  599 * Output         : None
//  600 * Return         : None
//  601 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock42 Using cfiCommon0
        CFI Function I2C2_EV_IRQHandler
        THUMB
//  602 void I2C2_EV_IRQHandler(void)
//  603 {
//  604 
//  605 }
I2C2_EV_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock42
//  606 
//  607 /*******************************************************************************
//  608 * Function Name  : I2C2_ER_IRQHandler
//  609 * Description    : This function handles I2C2 Error interrupt request.
//  610 * Input          : None
//  611 * Output         : None
//  612 * Return         : None
//  613 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock43 Using cfiCommon0
        CFI Function I2C2_ER_IRQHandler
        THUMB
//  614 void I2C2_ER_IRQHandler(void)
//  615 {
//  616 
//  617 }
I2C2_ER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock43
//  618 
//  619 /*******************************************************************************
//  620 * Function Name  : SPI1_IRQHandler
//  621 * Description    : This function handles SPI1 global interrupt request.
//  622 * Input          : None
//  623 * Output         : None
//  624 * Return         : None
//  625 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock44 Using cfiCommon0
        CFI Function SPI1_IRQHandler
        THUMB
//  626 void SPI1_IRQHandler(void)
//  627 {
//  628 
//  629 }
SPI1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock44
//  630 
//  631 /*******************************************************************************
//  632 * Function Name  : SPI2_IRQHandler
//  633 * Description    : This function handles SPI2 global interrupt request.
//  634 * Input          : None
//  635 * Output         : None
//  636 * Return         : None
//  637 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock45 Using cfiCommon0
        CFI Function SPI2_IRQHandler
        THUMB
//  638 void SPI2_IRQHandler(void)
//  639 {
//  640 
//  641 }
SPI2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock45
//  642 
//  643 /*******************************************************************************
//  644 * Function Name  : USART1_IRQHandler
//  645 * Description    : This function handles USART3 global interrupt request.
//  646 * Input          : None
//  647 * Output         : None
//  648 * Return         : None
//  649 *******************************************************************************/
//  650 extern void USART1_IRQIntHandler(void);
//  651 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock46 Using cfiCommon0
        CFI Function USART1_IRQHandler
        THUMB
//  652 void USART1_IRQHandler(void)
//  653 {
//  654 	USART1_IRQIntHandler();
USART1_IRQHandler:
        B.W      USART1_IRQIntHandler
        CFI EndBlock cfiBlock46
//  655 }
//  656 
//  657 
//  658 /*******************************************************************************
//  659 * Function Name  : USART2_IRQHandler
//  660 * Description    : This function handles USART3 global interrupt request.
//  661 * Input          : None
//  662 * Output         : None
//  663 * Return         : None
//  664 *******************************************************************************/
//  665 extern void USART2_IRQIntHandler(void);
//  666 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock47 Using cfiCommon0
        CFI Function USART2_IRQHandler
        THUMB
//  667 void USART2_IRQHandler(void)
//  668 {
//  669 	USART2_IRQIntHandler();
USART2_IRQHandler:
        B.W      USART2_IRQIntHandler
        CFI EndBlock cfiBlock47
//  670 }
//  671 
//  672 /*******************************************************************************
//  673 * Function Name  : USART3_IRQHandler
//  674 * Description    : This function handles USART3 global interrupt request.
//  675 * Input          : None
//  676 * Output         : None
//  677 * Return         : None
//  678 *******************************************************************************/
//  679 extern void USART3_IRQIntHandler(void);
//  680 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock48 Using cfiCommon0
        CFI Function USART3_IRQHandler
        THUMB
//  681 void USART3_IRQHandler(void)
//  682 {
//  683 	USART3_IRQIntHandler();
USART3_IRQHandler:
        B.W      USART3_IRQIntHandler
        CFI EndBlock cfiBlock48
//  684 }
//  685 
//  686 /*******************************************************************************
//  687 * Function Name  : EXTI15_10_IRQHandler
//  688 * Description    : This function handles External lines 15 to 10 interrupt request.
//  689 * Input          : None
//  690 * Output         : None
//  691 * Return         : None
//  692 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock49 Using cfiCommon0
        CFI Function EXTI15_10_IRQHandler
        THUMB
//  693 void EXTI15_10_IRQHandler(void)
//  694 {
//  695 
//  696 }
EXTI15_10_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock49
//  697 
//  698 /*******************************************************************************
//  699 * Function Name  : RTCAlarm_IRQHandler
//  700 * Description    : This function handles RTC Alarm interrupt request.
//  701 * Input          : None
//  702 * Output         : None
//  703 * Return         : None
//  704 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock50 Using cfiCommon0
        CFI Function RTCAlarm_IRQHandler
        THUMB
//  705 void RTCAlarm_IRQHandler(void)
//  706 {
//  707 
//  708 }
RTCAlarm_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock50
//  709 
//  710 /*******************************************************************************
//  711 * Function Name  : USBWakeUp_IRQHandler
//  712 * Description    : This function handles USB WakeUp interrupt request.
//  713 * Input          : None
//  714 * Output         : None
//  715 * Return         : None
//  716 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock51 Using cfiCommon0
        CFI Function USBWakeUp_IRQHandler
        THUMB
//  717 void USBWakeUp_IRQHandler(void)
//  718 {
//  719 
//  720 }
USBWakeUp_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock51
//  721 
//  722 /*******************************************************************************
//  723 * Function Name  : TIM8_BRK_IRQHandler
//  724 * Description    : This function handles TIM8 Break interrupt request.
//  725 * Input          : None
//  726 * Output         : None
//  727 * Return         : None
//  728 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock52 Using cfiCommon0
        CFI Function TIM8_BRK_IRQHandler
        THUMB
//  729 void TIM8_BRK_IRQHandler(void)
//  730 {
//  731 }
TIM8_BRK_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock52
//  732 
//  733 /*******************************************************************************
//  734 * Function Name  : TIM8_UP_IRQHandler
//  735 * Description    : This function handles TIM8 overflow and update interrupt 
//  736 *                  request.
//  737 * Input          : None
//  738 * Output         : None
//  739 * Return         : None
//  740 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock53 Using cfiCommon0
        CFI Function TIM8_UP_IRQHandler
        THUMB
//  741 void TIM8_UP_IRQHandler(void)
//  742 {
//  743 }
TIM8_UP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock53
//  744 
//  745 /*******************************************************************************
//  746 * Function Name  : TIM8_TRG_COM_IRQHandler
//  747 * Description    : This function handles TIM8 Trigger and commutation interrupts 
//  748 *                  requests.
//  749 * Input          : None
//  750 * Output         : None
//  751 * Return         : None
//  752 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock54 Using cfiCommon0
        CFI Function TIM8_TRG_COM_IRQHandler
        THUMB
//  753 void TIM8_TRG_COM_IRQHandler(void)
//  754 {
//  755 }
TIM8_TRG_COM_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock54
//  756 
//  757 /*******************************************************************************
//  758 * Function Name  : TIM8_CC_IRQHandler
//  759 * Description    : This function handles TIM8 capture compare interrupt request.
//  760 * Input          : None
//  761 * Output         : None
//  762 * Return         : None
//  763 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock55 Using cfiCommon0
        CFI Function TIM8_CC_IRQHandler
        THUMB
//  764 void TIM8_CC_IRQHandler(void)
//  765 {
//  766 }
TIM8_CC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock55
//  767 
//  768 /*******************************************************************************
//  769 * Function Name  : ADC3_IRQHandler
//  770 * Description    : This function handles ADC3 global interrupt request.
//  771 * Input          : None
//  772 * Output         : None
//  773 * Return         : None
//  774 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock56 Using cfiCommon0
        CFI Function ADC3_IRQHandler
        THUMB
//  775 void ADC3_IRQHandler(void)
//  776 {
//  777 }
ADC3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock56
//  778 
//  779 /*******************************************************************************
//  780 * Function Name  : FSMC_IRQHandler
//  781 * Description    : This function handles FSMC global interrupt request.
//  782 * Input          : None
//  783 * Output         : None
//  784 * Return         : None
//  785 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock57 Using cfiCommon0
        CFI Function FSMC_IRQHandler
        THUMB
//  786 void FSMC_IRQHandler(void)
//  787 {
//  788 }
FSMC_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock57
//  789 
//  790 /*******************************************************************************
//  791 * Function Name  : SDIO_IRQHandler
//  792 * Description    : This function handles SDIO global interrupt request.
//  793 * Input          : None
//  794 * Output         : None
//  795 * Return         : None
//  796 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock58 Using cfiCommon0
        CFI Function SDIO_IRQHandler
        THUMB
//  797 void SDIO_IRQHandler(void)
//  798 {
//  799 }
SDIO_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock58
//  800 
//  801 /*******************************************************************************
//  802 * Function Name  : TIM5_IRQHandler
//  803 * Description    : This function handles TIM5 global interrupt request.
//  804 * Input          : None
//  805 * Output         : None
//  806 * Return         : None
//  807 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock59 Using cfiCommon0
        CFI Function TIM5_IRQHandler
        THUMB
//  808 void TIM5_IRQHandler(void)
//  809 {
//  810 }
TIM5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock59
//  811 
//  812 /*******************************************************************************
//  813 * Function Name  : SPI3_IRQHandler
//  814 * Description    : This function handles SPI3 global interrupt request.
//  815 * Input          : None
//  816 * Output         : None
//  817 * Return         : None
//  818 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock60 Using cfiCommon0
        CFI Function SPI3_IRQHandler
        THUMB
//  819 void SPI3_IRQHandler(void)
//  820 {
//  821 }
SPI3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock60
//  822 
//  823 /*******************************************************************************
//  824 * Function Name  : UART4_IRQHandler
//  825 * Description    : This function handles UART4 global interrupt request.
//  826 * Input          : None
//  827 * Output         : None
//  828 * Return         : None
//  829 *******************************************************************************/
//  830 extern void USART4_IRQIntHandler(void);
//  831 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock61 Using cfiCommon0
        CFI Function UART4_IRQHandler
        THUMB
//  832 void UART4_IRQHandler(void)
//  833 {
//  834 	USART4_IRQIntHandler();
UART4_IRQHandler:
        B.W      USART4_IRQIntHandler
        CFI EndBlock cfiBlock61
//  835 }
//  836 
//  837 /*******************************************************************************
//  838 * Function Name  : UART5_IRQHandler
//  839 * Description    : This function handles UART5 global interrupt request.
//  840 * Input          : None
//  841 * Output         : None
//  842 * Return         : None
//  843 *******************************************************************************/
//  844 extern void USART5_IRQIntHandler(void);
//  845 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock62 Using cfiCommon0
        CFI Function UART5_IRQHandler
        THUMB
//  846 void UART5_IRQHandler(void)
//  847 {
//  848 	USART5_IRQIntHandler();
UART5_IRQHandler:
        B.W      USART5_IRQIntHandler
        CFI EndBlock cfiBlock62
//  849 }
//  850 
//  851 /*******************************************************************************
//  852 * Function Name  : TIM6_IRQHandler
//  853 * Description    : This function handles TIM6 global interrupt request.
//  854 * Input          : None
//  855 * Output         : None
//  856 * Return         : None
//  857 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock63 Using cfiCommon0
        CFI Function TIM6_IRQHandler
        THUMB
//  858 void TIM6_IRQHandler(void)
//  859 {
//  860 }
TIM6_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock63
//  861 
//  862 /*******************************************************************************
//  863 * Function Name  : TIM7_IRQHandler
//  864 * Description    : This function handles TIM7 global interrupt request.
//  865 * Input          : None
//  866 * Output         : None
//  867 * Return         : None
//  868 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock64 Using cfiCommon0
        CFI Function TIM7_IRQHandler
        THUMB
//  869 void TIM7_IRQHandler(void)
//  870 {
//  871 }
TIM7_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock64
//  872 
//  873 /*******************************************************************************
//  874 * Function Name  : DMA2_Channel1_IRQHandler
//  875 * Description    : This function handles DMA2 Channel 1 interrupt request.
//  876 * Input          : None
//  877 * Output         : None
//  878 * Return         : None
//  879 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock65 Using cfiCommon0
        CFI Function DMA2_Stream0_IRQHandler
        THUMB
//  880 void DMA2_Stream0_IRQHandler(void)
//  881 {
//  882 }
DMA2_Stream0_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock65
//  883 
//  884 /*******************************************************************************
//  885 * Function Name  : DMA2_Channel2_IRQHandler
//  886 * Description    : This function handles DMA2 Channel 2 interrupt request.
//  887 * Input          : None
//  888 * Output         : None
//  889 * Return         : None
//  890 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock66 Using cfiCommon0
        CFI Function DMA2_Stream1_IRQHandler
        THUMB
//  891 void DMA2_Stream1_IRQHandler(void)
//  892 {
//  893 }
DMA2_Stream1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock66
//  894 
//  895 /*******************************************************************************
//  896 * Function Name  : DMA2_Channel3_IRQHandler
//  897 * Description    : This function handles DMA2 Channel 3 interrupt request.
//  898 * Input          : None
//  899 * Output         : None
//  900 * Return         : None
//  901 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock67 Using cfiCommon0
        CFI Function DMA2_Stream2_IRQHandler
        THUMB
//  902 void DMA2_Stream2_IRQHandler(void)
//  903 {
//  904 }
DMA2_Stream2_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock67
//  905 
//  906 /*******************************************************************************
//  907 * Function Name  : DMA2_Channel4_5_IRQHandler
//  908 * Description    : This function handles DMA2 Channel 4 and DMA2 Channel 5
//  909 *                  interrupt request.
//  910 * Input          : None
//  911 * Output         : None
//  912 * Return         : None
//  913 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock68 Using cfiCommon0
        CFI Function DMA2_Stream3_IRQHandler
        THUMB
//  914 void DMA2_Stream3_IRQHandler(void)
//  915 {
//  916 }
DMA2_Stream3_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock68
//  917 
//  918 /*******************************************************************************
//  919 * Function Name  : DMA2_Channel4_5_IRQHandler
//  920 * Description    : This function handles DMA2 Channel 4 and DMA2 Channel 5
//  921 *                  interrupt request.
//  922 * Input          : None
//  923 * Output         : None
//  924 * Return         : None
//  925 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock69 Using cfiCommon0
        CFI Function DMA2_Stream4_IRQHandler
        THUMB
//  926 void DMA2_Stream4_IRQHandler(void)
//  927 {
//  928 }
DMA2_Stream4_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock69
//  929 
//  930 
//  931 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock70 Using cfiCommon0
        CFI Function ETH_IRQHandler
        THUMB
//  932 void ETH_IRQHandler(void)
//  933 {
//  934 }
ETH_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock70
//  935 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock71 Using cfiCommon0
        CFI Function ETH_WKUP_IRQHandler
        THUMB
//  936 void ETH_WKUP_IRQHandler(void)
//  937 {
//  938 }
ETH_WKUP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock71
//  939 	
//  940 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock72 Using cfiCommon0
        CFI Function CAN2_TX_IRQHandler
        THUMB
//  941 void CAN2_TX_IRQHandler(void)
//  942 {
//  943 }
CAN2_TX_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock72
//  944 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock73 Using cfiCommon0
        CFI Function CAN2_RX0_IRQHandler
        THUMB
//  945 void CAN2_RX0_IRQHandler(void)
//  946 {
//  947 }
CAN2_RX0_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock73
//  948 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock74 Using cfiCommon0
        CFI Function CAN2_RX1_IRQHandler
        THUMB
//  949 void CAN2_RX1_IRQHandler(void)
//  950 {
//  951 }
CAN2_RX1_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock74
//  952 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock75 Using cfiCommon0
        CFI Function CAN2_SCE_IRQHandler
        THUMB
//  953 void CAN2_SCE_IRQHandler(void)
//  954 {
//  955 }
CAN2_SCE_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock75
//  956 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock76 Using cfiCommon0
        CFI Function OTG_FS_IRQHandler
        THUMB
//  957 void OTG_FS_IRQHandler(void)
//  958 {
//  959 }
OTG_FS_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock76
//  960 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock77 Using cfiCommon0
        CFI Function DMA2_Stream5_IRQHandler
        THUMB
//  961 void DMA2_Stream5_IRQHandler(void)
//  962 {
//  963 }
DMA2_Stream5_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock77
//  964 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock78 Using cfiCommon0
        CFI Function DMA2_Stream6_IRQHandler
        THUMB
//  965 void DMA2_Stream6_IRQHandler(void)
//  966 {
//  967 }
DMA2_Stream6_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock78
//  968 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock79 Using cfiCommon0
        CFI Function DMA2_Stream7_IRQHandler
        THUMB
//  969 void DMA2_Stream7_IRQHandler(void)
//  970 {
//  971 }
DMA2_Stream7_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock79
//  972 
//  973 extern	void USART6_IRQIntHandler(void);

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock80 Using cfiCommon0
        CFI Function USART6_IRQHandler
        THUMB
//  974 void USART6_IRQHandler(void)
//  975 {
//  976 	USART6_IRQIntHandler();
USART6_IRQHandler:
        B.W      USART6_IRQIntHandler
        CFI EndBlock cfiBlock80
//  977 }
//  978 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock81 Using cfiCommon0
        CFI Function I2C3_EV_IRQHandler
        THUMB
//  979 void I2C3_EV_IRQHandler(void)
//  980 {
//  981 }
I2C3_EV_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock81
//  982 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock82 Using cfiCommon0
        CFI Function I2C3_ER_IRQHandler
        THUMB
//  983 void I2C3_ER_IRQHandler(void)
//  984 {
//  985 }
I2C3_ER_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock82
//  986 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock83 Using cfiCommon0
        CFI Function OTG_HS_EP1_OUT_IRQHandler
        THUMB
//  987 void OTG_HS_EP1_OUT_IRQHandler(void)
//  988 {
//  989 }
OTG_HS_EP1_OUT_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock83
//  990 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock84 Using cfiCommon0
        CFI Function OTG_HS_EP1_IN_IRQHandler
        THUMB
//  991 void OTG_HS_EP1_IN_IRQHandler(void)
//  992 {
//  993 }
OTG_HS_EP1_IN_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock84
//  994 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock85 Using cfiCommon0
        CFI Function OTG_HS_WKUP_IRQHandler
        THUMB
//  995 void OTG_HS_WKUP_IRQHandler(void)
//  996 {
//  997 }
OTG_HS_WKUP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock85
//  998 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock86 Using cfiCommon0
        CFI Function OTG_HS_IRQHandler
        THUMB
//  999 void OTG_HS_IRQHandler(void)
// 1000 {
// 1001 }
OTG_HS_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock86
// 1002 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock87 Using cfiCommon0
        CFI Function DCMI_IRQHandler
        THUMB
// 1003 void DCMI_IRQHandler(void)
// 1004 {
// 1005 }
DCMI_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock87
// 1006 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock88 Using cfiCommon0
        CFI Function CRYP_IRQHandler
        THUMB
// 1007 void CRYP_IRQHandler(void)
// 1008 {
// 1009 }
CRYP_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock88
// 1010 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock89 Using cfiCommon0
        CFI Function HASH_RNG_IRQHandler
        THUMB
// 1011 void HASH_RNG_IRQHandler(void)
// 1012 {
// 1013 }
HASH_RNG_IRQHandler:
        BX       LR               ;; return
        CFI EndBlock cfiBlock89

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 1014 
// 1015 
// 1016 
// 1017 
// 1018 /**
// 1019   * @}
// 1020   */ 
// 1021 
// 1022 
// 1023 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 286 bytes in section .text
// 
// 286 bytes of CODE memory
//
//Errors: none
//Warnings: none
