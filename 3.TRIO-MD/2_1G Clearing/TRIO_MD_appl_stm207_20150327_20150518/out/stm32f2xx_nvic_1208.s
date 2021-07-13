///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:01 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_nvic_1208.c                           /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_nvic_1208.c -D OS_INCLUDED -D         /
//                    APPL_SRC -lA D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ /
//                     -o D:\Work\Project\2012\NL_INBUILD\FW\MU\out\          /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_nvi /
//                    c_1208.s                                                /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_nvic_1208

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN __BASEPRICONFIG
        EXTERN __GetBASEPRI
        EXTERN __RESETFAULTMASK
        EXTERN __RESETPRIMASK
        EXTERN __SETFAULTMASK
        EXTERN __SETPRIMASK
        EXTERN __aeabi_memclr4

        PUBLIC NVIC_BASEPRICONFIG
        PUBLIC NVIC_ClearIRQChannelPendingBit
        PUBLIC NVIC_ClearSystemHandlerPendingBit
        PUBLIC NVIC_DeInit
        PUBLIC NVIC_GetBASEPRI
        PUBLIC NVIC_GetCPUID
        PUBLIC NVIC_GetCurrentActiveHandler
        PUBLIC NVIC_GetCurrentPendingIRQChannel
        PUBLIC NVIC_GetFaultAddress
        PUBLIC NVIC_GetFaultHandlerSources
        PUBLIC NVIC_GetIRQChannelActiveBitStatus
        PUBLIC NVIC_GetIRQChannelPendingBitStatus
        PUBLIC NVIC_GetSystemHandlerActiveBitStatus
        PUBLIC NVIC_GetSystemHandlerPendingBitStatus
        PUBLIC NVIC_Init
        PUBLIC NVIC_PriorityGroupConfig
        PUBLIC NVIC_RESETFAULTMASK
        PUBLIC NVIC_RESETPRIMASK
        PUBLIC NVIC_SCBDeInit
        PUBLIC NVIC_SETFAULTMASK
        PUBLIC NVIC_SETPRIMASK
        PUBLIC NVIC_SetIRQChannelPendingBit
        PUBLIC NVIC_SetSystemHandlerPendingBit
        PUBLIC NVIC_SetVectorTable
        PUBLIC NVIC_StructInit
        PUBLIC NVIC_SystemHandlerConfig
        PUBLIC NVIC_SystemHandlerPriorityConfig
        PUBLIC NVIC_SystemLPConfig
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_nvic_1208.c
//    1 /******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_nvic.c
//    3 * Author             : MCD Application Team
//    4 * Date First Issued  : 09/29/2006
//    5 * Description        : This file provides all the NVIC firmware functions.
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
//   22 #include "stm32f2xx_nvic_1208.h"
//   23 
//   24 /* Private typedef -----------------------------------------------------------*/
//   25 /* Private define ------------------------------------------------------------*/
//   26 /* Private macro -------------------------------------------------------------*/
//   27 /* Private variables ---------------------------------------------------------*/
//   28 /* Private function prototypes -----------------------------------------------*/
//   29 /* Private functions ---------------------------------------------------------*/
//   30 
//   31 /*******************************************************************************
//   32 * Function Name  : NVIC_DeInit
//   33 * Description    : Deinitializes the NVIC peripheral registers to their default
//   34 *                  reset values.
//   35 * Input          : None
//   36 * Output         : None
//   37 * Return         : None
//   38 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function NVIC_DeInit
        THUMB
//   39 void NVIC_DeInit(void)
//   40 {
//   41 	u32 index = 0;
//   42 
//   43 	for(index = 0; index < 15; index++)
NVIC_DeInit:
        LDR.N    R0,??DataTable19  ;; 0xe000e180
        LDR.N    R1,??DataTable19_1  ;; 0xe000e280
        MOVS     R2,#+3
        MOVW     R3,#+65535
//   44 	{
//   45 		NVIC->__B.ICER[index] = 0xFFFF;
??NVIC_DeInit_0:
        STRH     R3,[R0], #+2
//   46 		NVIC->__B.ICPR[index] = 0xFFFF;
        STR      R3,[R1], #+4
        STRH     R3,[R0], #+2
        STR      R3,[R1], #+4
        STRH     R3,[R0], #+2
        STR      R3,[R1], #+4
        STRH     R3,[R0], #+2
        STR      R3,[R1], #+4
        STRH     R3,[R0], #+2
        STR      R3,[R1], #+4
//   47 	}
        SUBS     R2,R2,#+1
        BNE.N    ??NVIC_DeInit_0
//   48 
//   49 	for(index = 0; index < 240; index++)
//   50 	{
//   51 	 	NVIC->IP[index] = 0x00000000;
        MOVS     R1,#+240
        LDR.N    R0,??DataTable19_2  ;; 0xe000e400
        B.W      __aeabi_memclr4
        CFI EndBlock cfiBlock0
//   52 	} 
//   53 }
//   54 
//   55 /*******************************************************************************
//   56 * Function Name  : NVIC_SCBDeInit
//   57 * Description    : Deinitializes the SCB peripheral registers to their default 
//   58 *                  reset values.
//   59 * Input          : None
//   60 * Output         : None
//   61 * Return         : None
//   62 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function NVIC_SCBDeInit
        THUMB
//   63 void NVIC_SCBDeInit(void)
//   64 {
NVIC_SCBDeInit:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//   65 	u32 index = 0x00;
//   66 
//   67 	SCB->ICSR = 0x0A000000;
        LDR.N    R0,??DataTable19_3  ;; 0xe000ed04
        MOV      R1,#+167772160
        STR      R1,[R0, #+0]
//   68 	SCB->VTOR = 0x00000000;
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//   69 	SCB->AIRCR = AIRC_VECTKEY_MASK;
        LDR.N    R1,??DataTable19_4  ;; 0x5fa0000
        STR      R1,[R0, #+8]
//   70 	SCB->SCR = 0x00000000;
        MOVS     R1,#+0
        STR      R1,[R0, #+12]
//   71 	SCB->CCR = 0x00000000;
        STR      R1,[R0, #+16]
//   72 	for(index = 0; index < 24; index++)
//   73 	{
//   74 	 	SCB->SHP[index] = 0;
        LDR.N    R4,??DataTable19_5  ;; 0xe000ed18
        MOVS     R1,#+24
        MOV      R0,R4
        BL       __aeabi_memclr4
//   75 	}
//   76 	SCB->SHCSR = 0x00000000;
        MOVS     R0,#+0
        STR      R0,[R4, #+12]
//   77 	SCB->CFSR = 0xFFFFFFFF;
        MOV      R0,#-1
        STR      R0,[R4, #+16]
//   78 	SCB->HFSR = 0xFFFFFFFF;
        STR      R0,[R4, #+20]
//   79   	SCB->DFSR = 0xFFFFFFFF;
        STR      R0,[R4, #+24]
//   80 }
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock1
//   81 
//   82 /*******************************************************************************
//   83 * @brief  Configures the priority grouping: pre-emption priority and subpriority.
//   84 * @param  NVIC_PriorityGroup: specifies the priority grouping bits length. 
//   85 *	This parameter can be one of the following values:
//   86 *	  @arg NVIC_PriorityGroup_0: 0 bits for pre-emption priority
//   87 *								 4 bits for subpriority
//   88 *	  @arg NVIC_PriorityGroup_1: 1 bits for pre-emption priority
//   89 *								 3 bits for subpriority
//   90 *	  @arg NVIC_PriorityGroup_2: 2 bits for pre-emption priority
//   91 *								 2 bits for subpriority
//   92 *	  @arg NVIC_PriorityGroup_3: 3 bits for pre-emption priority
//   93 *								 1 bits for subpriority
//   94 *	  @arg NVIC_PriorityGroup_4: 4 bits for pre-emption priority
//   95 *								 0 bits for subpriority
//   96 * @note   When the NVIC_PriorityGroup_0 is selected, IRQ pre-emption is no more possible. 
//   97 *		  The pending IRQ priority will be managed only by the subpriority. 
//   98 * @retval None
//   99 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function NVIC_PriorityGroupConfig
        THUMB
//  100 void NVIC_PriorityGroupConfig(u32 NVIC_PriorityGroup)
//  101 {
//  102 	/* Check the parameters */
//  103 	assert(IS_NVIC_PRIORITY_GROUP(NVIC_PriorityGroup));
//  104 
//  105 	/* Set the PRIGROUP[10:8] bits according to NVIC_PriorityGroup value */
//  106 	SCB->AIRCR = AIRC_VECTKEY_MASK | NVIC_PriorityGroup;
NVIC_PriorityGroupConfig:
        LDR.N    R1,??DataTable19_4  ;; 0x5fa0000
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable19_6  ;; 0xe000ed0c
        STR      R0,[R1, #+0]
//  107 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  108 
//  109 /*******************************************************************************
//  110 * Function Name  : NVIC_Init
//  111 * Description    : Initializes the NVIC peripheral according to the specified
//  112 *                  parameters in the NVIC_InitStruct.
//  113 * Input          : - NVIC_InitStruct: pointer to a NVIC_InitTypeDef structure
//  114 *                    that contains the configuration information for the
//  115 *                    specified NVIC peripheral.
//  116 * Output         : None
//  117 * Return         : None
//  118 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function NVIC_Init
        THUMB
//  119 void NVIC_Init(u32 NVIC_IRQChannel, u32 NVIC_IRQChannelCmd)
//  120 {
//  121 	if(NVIC_IRQChannelCmd == ENABLE)
NVIC_Init:
        MOVS     R2,#+1
        AND      R3,R0,#0x1F
        LSLS     R2,R2,R3
        LSRS     R0,R0,#+5
        CMP      R1,#+1
        ITE      EQ 
        LDREQ.N  R1,??DataTable19_7  ;; 0xe000e100
        LDRNE.N  R1,??DataTable19  ;; 0xe000e180
//  122 	{
//  123 		// Enable the Selected IRQ Channels ----------------------------------------
//  124 		NVIC->ISER[(NVIC_IRQChannel >> 0x05)] = (u32)0x01 << (NVIC_IRQChannel & (u8)0x1F);
//  125 	}
//  126 	else
//  127 	{
//  128 		// Disable the Selected IRQ Channels ---------------------------------------
//  129 		NVIC->ICER[(NVIC_IRQChannel >> 0x05)] = (u32)0x01 << (NVIC_IRQChannel & (u8)0x1F);
        STR      R2,[R1, R0, LSL #+2]
//  130 	}
//  131 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  132 
//  133 #if 0
//  134 void NVIC_Init(NVIC_InitTypeDef* NVIC_InitStruct)
//  135 {
//  136   uint8_t tmppriority = 0x00, tmppre = 0x00, tmpsub = 0x0F;
//  137   
//  138   /* Check the parameters */
//  139   assert_param(IS_FUNCTIONAL_STATE(NVIC_InitStruct->NVIC_IRQChannelCmd));
//  140   assert_param(IS_NVIC_PREEMPTION_PRIORITY(NVIC_InitStruct->NVIC_IRQChannelPreemptionPriority));  
//  141   assert_param(IS_NVIC_SUB_PRIORITY(NVIC_InitStruct->NVIC_IRQChannelSubPriority));
//  142     
//  143   if (NVIC_InitStruct->NVIC_IRQChannelCmd != DISABLE)
//  144   {
//  145     /* Compute the Corresponding IRQ Priority --------------------------------*/    
//  146     tmppriority = (0x700 - ((SCB->AIRCR) & (uint32_t)0x700))>> 0x08;
//  147     tmppre = (0x4 - tmppriority);
//  148     tmpsub = tmpsub >> tmppriority;
//  149 
//  150     tmppriority = NVIC_InitStruct->NVIC_IRQChannelPreemptionPriority << tmppre;
//  151     tmppriority |=  (uint8_t)(NVIC_InitStruct->NVIC_IRQChannelSubPriority & tmpsub);
//  152         
//  153     tmppriority = tmppriority << 0x04;
//  154         
//  155     NVIC->IP[NVIC_InitStruct->NVIC_IRQChannel] = tmppriority;
//  156     
//  157     /* Enable the Selected IRQ Channels --------------------------------------*/
//  158     NVIC->ISER[NVIC_InitStruct->NVIC_IRQChannel >> 0x05] =
//  159       (uint32_t)0x01 << (NVIC_InitStruct->NVIC_IRQChannel & (uint8_t)0x1F);
//  160   }
//  161   else
//  162   {
//  163     /* Disable the Selected IRQ Channels -------------------------------------*/
//  164     NVIC->ICER[NVIC_InitStruct->NVIC_IRQChannel >> 0x05] =
//  165       (uint32_t)0x01 << (NVIC_InitStruct->NVIC_IRQChannel & (uint8_t)0x1F);
//  166   }
//  167 }
//  168 #endif
//  169 
//  170 /*******************************************************************************
//  171 * Function Name  : NVIC_StructInit
//  172 * Description    : Fills each NVIC_InitStruct member with its default value.
//  173 * Input          : - NVIC_InitStruct: pointer to a NVIC_InitTypeDef structure which
//  174 *                    will be initialized.
//  175 * Output         : None
//  176 * Return         : None
//  177 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function NVIC_StructInit
        THUMB
//  178 void NVIC_StructInit(NVIC_InitTypeDef* NVIC_InitStruct)
//  179 {
//  180 	/* NVIC_InitStruct members default value */
//  181 	NVIC_InitStruct->NVIC_IRQChannel = 0x00;
NVIC_StructInit:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  182 	NVIC_InitStruct->NVIC_IRQChannelPreemptionPriority = 0x00;
        STRB     R1,[R0, #+1]
//  183 	NVIC_InitStruct->NVIC_IRQChannelSubPriority = 0x00;
        STRB     R1,[R0, #+2]
//  184 	NVIC_InitStruct->NVIC_IRQChannelCmd = DISABLE;
        STRB     R1,[R0, #+3]
//  185 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  186 
//  187 /*******************************************************************************
//  188 * Function Name  : NVIC_SETPRIMASK
//  189 * Description    : Enables the PRIMASK priority: Raises the execution priority to 0.
//  190 * Input          : None
//  191 * Output         : None
//  192 * Return         : None
//  193 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function NVIC_SETPRIMASK
        THUMB
//  194 void NVIC_SETPRIMASK(void)
//  195 {
//  196 	__SETPRIMASK();
NVIC_SETPRIMASK:
        B.W      __SETPRIMASK
        CFI EndBlock cfiBlock5
//  197 }
//  198 
//  199 /*******************************************************************************
//  200 * Function Name  : NVIC_RESETPRIMASK
//  201 * Description    : Disables the PRIMASK priority.
//  202 * Input          : None
//  203 * Output         : None
//  204 * Return         : None
//  205 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function NVIC_RESETPRIMASK
        THUMB
//  206 void NVIC_RESETPRIMASK(void)
//  207 {
//  208 	__RESETPRIMASK();
NVIC_RESETPRIMASK:
        B.W      __RESETPRIMASK
        CFI EndBlock cfiBlock6
//  209 }
//  210 
//  211 /*******************************************************************************
//  212 * Function Name  : NVIC_SETFAULTMASK
//  213 * Description    : Enables the FAULTMASK priority: Raises the execution priority to -1.
//  214 * Input          : None
//  215 * Output         : None
//  216 * Return         : None
//  217 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function NVIC_SETFAULTMASK
        THUMB
//  218 void NVIC_SETFAULTMASK(void)
//  219 {
//  220 	__SETFAULTMASK();
NVIC_SETFAULTMASK:
        B.W      __SETFAULTMASK
        CFI EndBlock cfiBlock7
//  221 }
//  222 
//  223 /*******************************************************************************
//  224 * Function Name  : NVIC_RESETFAULTMASK
//  225 * Description    : Disables the FAULTMASK priority.
//  226 * Input          : None
//  227 * Output         : None
//  228 * Return         : None
//  229 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function NVIC_RESETFAULTMASK
        THUMB
//  230 void NVIC_RESETFAULTMASK(void)
//  231 {
//  232 	__RESETFAULTMASK();
NVIC_RESETFAULTMASK:
        B.W      __RESETFAULTMASK
        CFI EndBlock cfiBlock8
//  233 }
//  234 
//  235 /*******************************************************************************
//  236 * Function Name  : NVIC_BASEPRICONFIG
//  237 * Description    : The execution priority can be changed from 15 (lowest 
//  238                    configurable priority) to 1.
//  239 * Input          : None
//  240 * Output         : None
//  241 * Return         : None
//  242 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function NVIC_BASEPRICONFIG
        THUMB
//  243 void NVIC_BASEPRICONFIG(u32 NewPriority)
//  244 {
//  245 	/* Check the parameters */
//  246 	assert(IS_NVIC_BASE_PRI(NewPriority));
//  247   
//  248 	__BASEPRICONFIG(NewPriority << 0x04);
NVIC_BASEPRICONFIG:
        LSLS     R0,R0,#+4
        B.W      __BASEPRICONFIG
        CFI EndBlock cfiBlock9
//  249 }
//  250 
//  251 /*******************************************************************************
//  252 * Function Name  : NVIC_GetBASEPRI
//  253 * Description    : Returns the BASEPRI mask value.
//  254 * Input          : None
//  255 * Output         : None
//  256 * Return         : BASEPRI register value
//  257 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function NVIC_GetBASEPRI
        THUMB
//  258 u32 NVIC_GetBASEPRI(void)
//  259 {
//  260 	return (__GetBASEPRI());
NVIC_GetBASEPRI:
        B.W      __GetBASEPRI
        CFI EndBlock cfiBlock10
//  261 }
//  262 
//  263 /*******************************************************************************
//  264 * Function Name  : NVIC_GetCurrentPendingIRQChannel
//  265 * Description    : Returns the current pending IRQ channel identifier.
//  266 * Input          : None
//  267 * Output         : None
//  268 * Return         : Pending IRQ Channel Identifier.
//  269 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function NVIC_GetCurrentPendingIRQChannel
        THUMB
//  270 u16 NVIC_GetCurrentPendingIRQChannel(void)
//  271 {
//  272 	return ((u16)((SCB->ICSR & (u32)0x003FF000) >> 0x0C));
NVIC_GetCurrentPendingIRQChannel:
        LDR.N    R0,??DataTable19_3  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+10
        LSRS     R0,R0,#+22
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  273 }
//  274 
//  275 /*******************************************************************************
//  276 * Function Name  : NVIC_GetIRQChannelPendingBitStatus
//  277 * Description    : Checks whether the specified IRQ Channel pending bit is set
//  278 *                  or not.
//  279 * Input          : - NVIC_IRQChannel: specifies the interrupt pending bit to check.
//  280 * Output         : None
//  281 * Return         : The new state of IRQ Channel pending bit(SET or RESET).
//  282 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function NVIC_GetIRQChannelPendingBitStatus
        THUMB
//  283 INT32U NVIC_GetIRQChannelPendingBitStatus(u8 NVIC_IRQChannel)
//  284 {
//  285 	INT32U pendingirqstatus = RESET;
NVIC_GetIRQChannelPendingBitStatus:
        MOVS     R1,#+0
//  286 	u32 tmp = 0x00;
//  287 
//  288 	/* Check the parameters */
//  289 	assert(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  290 
//  291 	tmp = ((u32)0x01 << (NVIC_IRQChannel & (u32)0x1F));
        MOVS     R2,#+1
        AND      R3,R0,#0x1F
        LSLS     R2,R2,R3
//  292 
//  293 	if (((NVIC->ISPR[(NVIC_IRQChannel >> 0x05)]) & tmp) == tmp)
        ASRS     R0,R0,#+5
        LDR.N    R3,??DataTable19_8  ;; 0xe000e200
        LDR      R0,[R3, R0, LSL #+2]
        ANDS     R0,R2,R0
        CMP      R0,R2
        IT       EQ 
        MOVEQ    R1,#+1
//  294 	{
//  295 		pendingirqstatus = SET;
//  296 	}
//  297 	else
//  298 	{
//  299 		pendingirqstatus = RESET;
//  300 	}
//  301 	return pendingirqstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  302 }
//  303 
//  304 /*******************************************************************************
//  305 * Function Name  : NVIC_SetIRQChannelPendingBit
//  306 * Description    : Sets the NVIC’s interrupt pending bit.
//  307 * Input          : - NVIC_IRQChannel: specifies the interrupt pending bit to Set.
//  308 * Output         : None
//  309 * Return         : None
//  310 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function NVIC_SetIRQChannelPendingBit
        THUMB
//  311 void NVIC_SetIRQChannelPendingBit(u8 NVIC_IRQChannel)
//  312 {
//  313   /* Check the parameters */
//  314   assert(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  315   
//  316   *(u32*)0xE000EF00 = (u32)NVIC_IRQChannel;
NVIC_SetIRQChannelPendingBit:
        LDR.N    R1,??DataTable19_9  ;; 0xe000ef00
        STR      R0,[R1, #+0]
//  317 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  318 
//  319 /*******************************************************************************
//  320 * Function Name  : NVIC_ClearIRQChannelPendingBit
//  321 * Description    : Clears the NVIC’s interrupt pending bit.
//  322 * Input          : - NVIC_IRQChannel: specifies the interrupt pending bit to clear.
//  323 * Output         : None
//  324 * Return         : None
//  325 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function NVIC_ClearIRQChannelPendingBit
        THUMB
//  326 void NVIC_ClearIRQChannelPendingBit(u8 NVIC_IRQChannel)
//  327 {
//  328     /* Check the parameters */
//  329     assert(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  330     NVIC->ICPR[(NVIC_IRQChannel >> 0x05)] = (u32)0x01 << (NVIC_IRQChannel & (u32)0x1F);
NVIC_ClearIRQChannelPendingBit:
        ASRS     R1,R0,#+5
        LDR.N    R2,??DataTable19_1  ;; 0xe000e280
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R3,R0
        STR      R0,[R2, R1, LSL #+2]
//  331 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  332 
//  333 /*******************************************************************************
//  334 * Function Name  : NVIC_GetCurrentActiveHandler
//  335 * Description    : Returns the current active Handler (IRQ Channel and
//  336 *                  SystemHandler) identifier.
//  337 * Input          : None
//  338 * Output         : None
//  339 * Return         : Active Handler Identifier.
//  340 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function NVIC_GetCurrentActiveHandler
        THUMB
//  341 u16 NVIC_GetCurrentActiveHandler(void)
//  342 {
//  343 	return ((u16)(SCB->ICSR & (u32)0x3FF));
NVIC_GetCurrentActiveHandler:
        LDR.N    R0,??DataTable19_3  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+22
        LSRS     R0,R0,#+22
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  344 }
//  345 
//  346 /*******************************************************************************
//  347 * Function Name  : NVIC_GetIRQChannelActiveBitStatus
//  348 * Description    : Checks whether the specified IRQ Channel active bit is set
//  349 *                  or not.
//  350 * Input          : - NVIC_IRQChannel: specifies the interrupt active bit to check.
//  351 * Output         : None
//  352 * Return         : The new state of IRQ Channel active bit(SET or RESET).
//  353 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function NVIC_GetIRQChannelActiveBitStatus
        THUMB
//  354 INT32U NVIC_GetIRQChannelActiveBitStatus(u8 NVIC_IRQChannel)
//  355 {
//  356     INT32U activeirqstatus = RESET;
NVIC_GetIRQChannelActiveBitStatus:
        MOVS     R1,#+0
//  357     u32 tmp = 0x00;
//  358 
//  359     /* Check the parameters */
//  360     assert(IS_NVIC_IRQ_CHANNEL(NVIC_IRQChannel));
//  361   
//  362     tmp = ((u32)0x01 << (NVIC_IRQChannel & (u32)0x1F));
        MOVS     R2,#+1
        AND      R3,R0,#0x1F
        LSLS     R2,R2,R3
//  363 
//  364     if (((NVIC->IABR[(NVIC_IRQChannel >> 0x05)]) & tmp) == tmp )
        ASRS     R0,R0,#+5
        LDR.N    R3,??DataTable19_10  ;; 0xe000e300
        LDR      R0,[R3, R0, LSL #+2]
        ANDS     R0,R2,R0
        CMP      R0,R2
        IT       EQ 
        MOVEQ    R1,#+1
//  365     {
//  366         activeirqstatus = SET;
//  367     }
//  368     else
//  369     {
//  370         activeirqstatus = RESET;
//  371     }
//  372     return activeirqstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  373 }
//  374 
//  375 /*******************************************************************************
//  376 * Function Name  : NVIC_GetCPUID
//  377 * Description    : Returns the ID number, the version number and the implementation
//  378 *                  details of the Cortex-M3 core.
//  379 * Input          : None
//  380 * Output         : None
//  381 * Return         : CPU ID.
//  382 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function NVIC_GetCPUID
        THUMB
//  383 u32 NVIC_GetCPUID(void)
//  384 {
//  385 	return (SCB->CPUID);
NVIC_GetCPUID:
        LDR.N    R0,??DataTable19_11  ;; 0xe000ed00
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock17
//  386 }
//  387 
//  388 
//  389 /*******************************************************************************
//  390   * @brief  Sets the vector table location and Offset.
//  391   * @param  NVIC_VectTab: specifies if the vector table is in RAM or FLASH memory.
//  392   *   This parameter can be one of the following values:
//  393   *     @arg NVIC_VectTab_RAM: Vector Table in internal SRAM.
//  394   *     @arg NVIC_VectTab_FLASH: Vector Table in internal FLASH.
//  395   * @param  Offset: Vector Table base offset field. This value must be a multiple of 0x200.
//  396   * @retval None
//  397   *****************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function NVIC_SetVectorTable
        THUMB
//  398 void NVIC_SetVectorTable(u32 Addr)
//  399 {
//  400 	SCB->VTOR = Addr & 0x3FFFFF80;
NVIC_SetVectorTable:
        LDR.N    R1,??DataTable19_12  ;; 0x3fffff80
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable19_13  ;; 0xe000ed08
        STR      R0,[R1, #+0]
//  401 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock18
//  402 
//  403 /*******************************************************************************
//  404   * @brief	Selects the condition for the system to enter low power mode.
//  405   * @param	LowPowerMode: Specifies the new mode for the system to enter low power mode.
//  406   *   This parameter can be one of the following values:
//  407   * 	@arg NVIC_LP_SEVONPEND: Low Power SEV on Pend.
//  408   * 	@arg NVIC_LP_SLEEPDEEP: Low Power DEEPSLEEP request.
//  409   * 	@arg NVIC_LP_SLEEPONEXIT: Low Power Sleep on Exit.
//  410   * @param	NewState: new state of LP condition. This parameter can be: ENABLE or DISABLE.
//  411   * @retval None
//  412   *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function NVIC_SystemLPConfig
        THUMB
//  413 void NVIC_SystemLPConfig(u8 LowPowerMode, INT32U NewState)
//  414 {
//  415 	/* Check the parameters */
//  416 	assert(IS_NVIC_LP(LowPowerMode));
//  417 	assert(IS_FUNCTIONAL_STATE(NewState));  
//  418 
//  419 	if (NewState != DISABLE)
NVIC_SystemLPConfig:
        LDR.N    R2,??DataTable19_14  ;; 0xe000ed10
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
//  420 	{
//  421 		SCB->SCR |= LowPowerMode;
//  422 	}
//  423 	else
//  424 	{
//  425 		SCB->SCR &= (u32)(~(u32)LowPowerMode);
        STR      R0,[R2, #+0]
//  426 	}
//  427 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//  428 
//  429 /*******************************************************************************
//  430 * Function Name  : NVIC_SystemHandlerConfig
//  431 * Description    : Enables or disables the specified System Handlers.
//  432 * Input          : - SystemHandler: specifies the system handler to be enabled
//  433 *                    or disabled.
//  434 *                    This parameter can be one of the following values:
//  435 *                       - SystemHandler_MemoryManage
//  436 *                       - SystemHandler_BusFault
//  437 *                       - SystemHandler_UsageFault
//  438 *                  - NewState: new state of  specified System Handlers.
//  439 *                    This parameter can be: ENABLE or DISABLE.
//  440 * Output         : None
//  441 * Return         : None
//  442 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function NVIC_SystemHandlerConfig
        THUMB
//  443 void NVIC_SystemHandlerConfig(u32 SystemHandler, INT32U NewState)
//  444 {
//  445 	u32 tmpreg = 0x00;
//  446 
//  447 	/* Check the parameters */
//  448 	assert(IS_CONFIG_SYSTEM_HANDLER(SystemHandler));
//  449 	assert(IS_FUNCTIONAL_STATE(NewState)); 
//  450 
//  451 	tmpreg =  (u32)0x01 << (SystemHandler & (u32)0x1F);
NVIC_SystemHandlerConfig:
        MOVS     R2,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R2,R0
//  452 
//  453 	if (NewState != DISABLE)
        LDR.N    R2,??DataTable19_15  ;; 0xe000ed24
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
//  454 	{
//  455 		SCB->SHCSR |= tmpreg;
//  456 	}
//  457 	else
//  458 	{
//  459 		SCB->SHCSR &= ~tmpreg;
        STR      R0,[R2, #+0]
//  460 	}
//  461 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock20
//  462 
//  463 /*******************************************************************************
//  464 * Function Name  : NVIC_SystemHandlerPriorityConfig
//  465 * Description    : Configures the specified System Handlers priority.
//  466 * Input          : - SystemHandler: specifies the system handler to be
//  467 *                    enabled or disabled.
//  468 *                    This parameter can be one of the following values:
//  469 *                       - SystemHandler_MemoryManage
//  470 *                       - SystemHandler_BusFault
//  471 *                       - SystemHandler_UsageFault
//  472 *                       - SystemHandler_SVCall
//  473 *                       - SystemHandler_DebugMonitor
//  474 *                       - SystemHandler_PSV
//  475 *                       - SystemHandler_SysTick
//  476 *                  - SystemHandlerPreemptionPriority: new priority group of the
//  477 *                    specified system handlers.
//  478 *                  - SystemHandlerSubPriority: new sub priority of the specified
//  479 *                    system handlers.
//  480 * Output         : None
//  481 * Return         : None
//  482 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function NVIC_SystemHandlerPriorityConfig
        THUMB
//  483 void NVIC_SystemHandlerPriorityConfig(u32 SystemHandler, u8 SystemHandlerPreemptionPriority,
//  484                                       u8 SystemHandlerSubPriority)
//  485 {
NVIC_SystemHandlerPriorityConfig:
        PUSH     {R4-R7}
        CFI R7 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  486   u32 tmp1 = 0x00, tmp2 = 0xFF, handlermask = 0x00;
//  487   u32 tmppriority = 0x00;
//  488 
//  489   /* Check the parameters */
//  490   assert(IS_PRIORITY_SYSTEM_HANDLER(SystemHandler));	//	SystemHandler_SysTick 0x02C39A
//  491   assert(IS_NVIC_PREEMPTION_PRIORITY(SystemHandlerPreemptionPriority));  
//  492   assert(IS_NVIC_SUB_PRIORITY(SystemHandlerSubPriority));
//  493     
//  494   tmppriority = (0x700 - (SCB->AIRCR & (u32)0x700))>> 0x08;
        LDR.N    R3,??DataTable19_6  ;; 0xe000ed0c
        LDR      R3,[R3, #+0]
        AND      R3,R3,#0x700
        RSB      R3,R3,#+1792
        LSRS     R3,R3,#+8
//  495   tmp1 = (0x4 - tmppriority);
//  496   tmp2 = tmp2 >> tmppriority;
//  497     
//  498   tmppriority = (u32)SystemHandlerPreemptionPriority << tmp1;
//  499   tmppriority |=  SystemHandlerSubPriority & tmp2;
//  500 
//  501   tmppriority = tmppriority << 0x04;
//  502   tmp1 = SystemHandler & (u32)0xC0;
//  503   tmp1 = tmp1 >> 0x06; 
        UBFX     R4,R0,#+6,#+2
//  504   tmp2 = (SystemHandler >> 0x08) & (u32)0x03;
        UBFX     R0,R0,#+8,#+2
//  505   tmppriority = tmppriority << (tmp2 * 0x08);
//  506   handlermask = (u32)0xFF << (tmp2 * 0x08);
//  507   
//  508   SCB->__B.SHP[tmp1] &= ~handlermask;
        LSLS     R0,R0,#+3
        MOVS     R7,#+255
        LDR.N    R5,??DataTable19_5  ;; 0xe000ed18
        LDR      R6,[R5, R4, LSL #+2]
        LSL      R12,R7,R0
        BIC      R6,R6,R12
        STR      R6,[R5, R4, LSL #+2]
//  509   SCB->__B.SHP[tmp1] |= tmppriority;
        LDR      R6,[R5, R4, LSL #+2]
        RSB      R12,R3,#+4
        LSL      R1,R1,R12
        LSR      R3,R7,R3
        ANDS     R2,R3,R2
        ORRS     R1,R2,R1
        LSLS     R1,R1,#+4
        LSL      R0,R1,R0
        ORRS     R0,R0,R6
        STR      R0,[R5, R4, LSL #+2]
//  510 }
        POP      {R4-R7}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
//  511 
//  512 /*******************************************************************************
//  513 * Function Name  : NVIC_GetSystemHandlerPendingBitStatus
//  514 * Description    : Checks whether the specified System handlers pending bit is
//  515 *                  set or not.
//  516 * Input          : - SystemHandler: specifies the system handler pending bit to
//  517 *                    check.
//  518 *                    This parameter can be one of the following values:
//  519 *                       - SystemHandler_MemoryManage
//  520 *                       - SystemHandler_BusFault
//  521 *                       - SystemHandler_SVCall
//  522 * Output         : None
//  523 * Return         : The new state of System Handler pending bit(SET or RESET).
//  524 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function NVIC_GetSystemHandlerPendingBitStatus
        THUMB
//  525 INT32U NVIC_GetSystemHandlerPendingBitStatus(u32 SystemHandler)
//  526 {
//  527 	INT32U bitstatus  = RESET;
NVIC_GetSystemHandlerPendingBitStatus:
        MOVS     R1,#+0
//  528 	u32 tmp = 0x00, tmppos = 0x00;
//  529 
//  530 	/* Check the parameters */
//  531 	assert(IS_GET_PENDING_SYSTEM_HANDLER(SystemHandler));
//  532 
//  533 	tmppos = (SystemHandler >> 0x0A);
//  534 	tmppos &= (u32)0x0F;
//  535 
//  536 	tmppos = (u32)0x01 << tmppos;
        MOVS     R2,#+1
        LSRS     R0,R0,#+10
        AND      R0,R0,#0xF
        LSL      R0,R2,R0
//  537 
//  538 	tmp = SCB->SHCSR & tmppos;
        LDR.N    R2,??DataTable19_15  ;; 0xe000ed24
        LDR      R2,[R2, #+0]
//  539 
//  540 	if (tmp == tmppos)
        ANDS     R2,R0,R2
        CMP      R2,R0
        IT       EQ 
        MOVEQ    R1,#+1
//  541 	{
//  542 		bitstatus = SET;
//  543 	}
//  544 	else
//  545 	{
//  546 		bitstatus = RESET;
//  547 	}
//  548 	return bitstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//  549 }
//  550 
//  551 /*******************************************************************************
//  552 * Function Name  : NVIC_SetSystemHandlerPendingBit
//  553 * Description    : Sets System Handler pending bit.
//  554 * Input          : - SystemHandler: specifies the system handler pending bit
//  555 *                    to be set.
//  556 *                    This parameter can be one of the following values:
//  557 *                       - SystemHandler_NMI
//  558 *                       - SystemHandler_PSV
//  559 *                       - SystemHandler_SysTick
//  560 * Output         : None
//  561 * Return         : None
//  562 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function NVIC_SetSystemHandlerPendingBit
        THUMB
//  563 void NVIC_SetSystemHandlerPendingBit(u32 SystemHandler)
//  564 {
//  565 	u32 tmp = 0x00;
//  566 
//  567 	/* Check the parameters */
//  568 	assert(IS_SET_PENDING_SYSTEM_HANDLER(SystemHandler));
//  569 
//  570 	/* Get the System Handler pending bit position */
//  571 	tmp = SystemHandler & (u32)0x1F;
//  572 	/* Set the corresponding System Handler pending bit */
//  573 	SCB->ICSR |= ((u32)0x01 << tmp);
NVIC_SetSystemHandlerPendingBit:
        LDR.N    R1,??DataTable19_3  ;; 0xe000ed04
        LDR      R2,[R1, #+0]
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock23
//  574 }
//  575 
//  576 /*******************************************************************************
//  577 * Function Name  : NVIC_ClearSystemHandlerPendingBit
//  578 * Description    : Clears System Handler pending bit.
//  579 * Input          : - SystemHandler: specifies the system handler pending bit to
//  580 *                    be clear.
//  581 *                    This parameter can be one of the following values:
//  582 *                       - SystemHandler_PSV
//  583 *                       - SystemHandler_SysTick
//  584 * Output         : None
//  585 * Return         : None
//  586 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function NVIC_ClearSystemHandlerPendingBit
        THUMB
//  587 void NVIC_ClearSystemHandlerPendingBit(u32 SystemHandler)
//  588 {
//  589 	u32 tmp = 0x00;
//  590 
//  591 	/* Check the parameters */
//  592 	assert(IS_CLEAR_SYSTEM_HANDLER(SystemHandler));
//  593 
//  594 	/* Get the System Handler pending bit position */
//  595 	tmp = SystemHandler & (u32)0x1F;
//  596 	/* Clear the corresponding System Handler pending bit */
//  597 	SCB->ICSR |= ((u32)0x01 << (tmp - 0x01));
NVIC_ClearSystemHandlerPendingBit:
        LDR.N    R1,??DataTable19_3  ;; 0xe000ed04
        LDR      R2,[R1, #+0]
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        SUBS     R0,R0,#+1
        CFI EndBlock cfiBlock24
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  598 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        LSL      R0,R3,R0
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
//  599 
//  600 /*******************************************************************************
//  601 * Function Name  : NVIC_GetSystemHandlerActiveBitStatus
//  602 * Description    : Checks whether the specified System handlers active bit is
//  603 *                  set or not.
//  604 * Input          : - SystemHandler: specifies the system handler active bit to
//  605 *                    check.
//  606 *                    This parameter can be one of the following values:
//  607 *                       - SystemHandler_MemoryManage
//  608 *                       - SystemHandler_BusFault
//  609 *                       - SystemHandler_UsageFault
//  610 *                       - SystemHandler_SVCall
//  611 *                       - SystemHandler_DebugMonitor
//  612 *                       - SystemHandler_PSV
//  613 *                       - SystemHandler_SysTick
//  614 * Output         : None
//  615 * Return         : The new state of System Handler active bit(SET or RESET).
//  616 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function NVIC_GetSystemHandlerActiveBitStatus
        THUMB
//  617 INT32U NVIC_GetSystemHandlerActiveBitStatus(u32 SystemHandler)
//  618 {
//  619 	INT32U bitstatus  = RESET;
NVIC_GetSystemHandlerActiveBitStatus:
        MOVS     R1,#+0
//  620 
//  621 	u32 tmp = 0x00, tmppos = 0x00;
//  622 
//  623 	/* Check the parameters */
//  624 	assert(IS_GET_ACTIVE_SYSTEM_HANDLER(SystemHandler));
//  625 
//  626 	tmppos = (SystemHandler >> 0x0E) & (u32)0x0F;
//  627 
//  628 	tmppos = (u32)0x01 << tmppos;
        MOVS     R2,#+1
        LSRS     R0,R0,#+14
        AND      R0,R0,#0xF
        LSL      R0,R2,R0
//  629 
//  630 	tmp = SCB->SHCSR & tmppos;
        LDR.N    R2,??DataTable19_15  ;; 0xe000ed24
        LDR      R2,[R2, #+0]
//  631 
//  632 	if (tmp == tmppos)
        ANDS     R2,R0,R2
        CMP      R2,R0
        IT       EQ 
        MOVEQ    R1,#+1
//  633 	{
//  634 		bitstatus = SET;
//  635 	}
//  636 	else
//  637 	{
//  638 		bitstatus = RESET;
//  639 	}
//  640 	return bitstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
//  641 }
//  642 
//  643 /*******************************************************************************
//  644 * Function Name  : NVIC_GetFaultHandlerSources
//  645 * Description    : Returns the system fault handlers sources.
//  646 * Input          : - SystemHandler: specifies the system handler to get its fault
//  647 *                    sources.
//  648 *                    This parameter can be one of the following values:
//  649 *                       - SystemHandler_HardFault
//  650 *                       - SystemHandler_MemoryManage
//  651 *                       - SystemHandler_BusFault
//  652 *                       - SystemHandler_UsageFault
//  653 *                       - SystemHandler_DebugMonitor
//  654 * Output         : None
//  655 * Return         : Source of the fault handler.
//  656 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function NVIC_GetFaultHandlerSources
        THUMB
//  657 u32 NVIC_GetFaultHandlerSources(u32 SystemHandler)
//  658 {
//  659 	u32 faultsources = 0x00;
//  660 	u32 tmpreg = 0x00, tmppos = 0x00;
//  661 
//  662 	/* Check the parameters */
//  663 	assert(IS_FAULT_SOURCE_SYSTEM_HANDLER(SystemHandler));
//  664 
//  665 	tmpreg = (SystemHandler >> 0x12) & (u32)0x03;
NVIC_GetFaultHandlerSources:
        UBFX     R1,R0,#+18,#+2
//  666 	tmppos = (SystemHandler >> 0x14) & (u32)0x03;
        UBFX     R0,R0,#+20,#+2
//  667 
//  668 	if (tmpreg == 0x00)
        LDR.N    R2,??DataTable19_16  ;; 0xe000ed28
        MOVS     R3,R1
        BNE.N    ??NVIC_GetFaultHandlerSources_0
//  669 	{
//  670 		faultsources = SCB->HFSR;
        LDR      R0,[R2, #+4]
        BX       LR
//  671 	}
//  672 	else if (tmpreg == 0x01)
??NVIC_GetFaultHandlerSources_0:
        CMP      R1,#+1
        BNE.N    ??NVIC_GetFaultHandlerSources_1
//  673 	{
//  674 		faultsources = SCB->CFSR >> (tmppos * 0x08);
        LDR      R1,[R2, #+0]
        LSLS     R2,R0,#+3
        LSRS     R1,R1,R2
//  675 		if (tmppos != 0x02)
        CMP      R0,#+2
        ITE      NE 
        ANDNE    R0,R1,#0xF
        UXTBEQ   R0,R1
//  676 		{
//  677 	  		faultsources &= (u32)0x0F;
        BX       LR
//  678 		}
//  679 		else
//  680 		{
//  681 	  		faultsources &= (u32)0xFF;
//  682 		}
//  683 	}
//  684 	else
//  685 	{
//  686 		faultsources = SCB->DFSR;
??NVIC_GetFaultHandlerSources_1:
        LDR      R0,[R2, #+8]
//  687 	}
//  688 	return faultsources;
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
//  689 }
//  690 
//  691 /*******************************************************************************
//  692 * Function Name  : NVIC_GetFaultAddress
//  693 * Description    : Returns the address of the location that generated a fault
//  694 *                  handler.
//  695 * Input          : - SystemHandler: specifies the system handler to get its
//  696 *                    fault address.
//  697 *                    This parameter can be one of the following values:
//  698 *                       - SystemHandler_MemoryManage
//  699 *                       - SystemHandler_BusFault
//  700 * Output         : None
//  701 * Return         : Fault address.
//  702 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function NVIC_GetFaultAddress
        THUMB
//  703 u32 NVIC_GetFaultAddress(u32 SystemHandler)
//  704 {
//  705 	u32 faultaddress = 0x00;
//  706 	u32 tmp = 0x00;
//  707 
//  708 	/* Check the parameters */
//  709 	assert(IS_FAULT_ADDRESS_SYSTEM_HANDLER(SystemHandler));
//  710 
//  711 	tmp = (SystemHandler >> 0x16) & (u32)0x01;
//  712 
//  713 	if (tmp == 0x00)
NVIC_GetFaultAddress:
        LDR.N    R1,??DataTable19_17  ;; 0xe000ed34
        LSLS     R0,R0,#+9
        ITE      PL 
        LDRPL    R0,[R1, #+0]
        LDRMI    R0,[R1, #+4]
//  714 	{
//  715 		faultaddress = SCB->MMFAR;
        BX       LR
        CFI EndBlock cfiBlock28
//  716 	}
//  717 	else
//  718 	{
//  719 		faultaddress = SCB->BFAR;
//  720 	}
//  721 	return faultaddress;
//  722 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_1:
        DC32     0xe000e280

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_2:
        DC32     0xe000e400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_3:
        DC32     0xe000ed04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_4:
        DC32     0x5fa0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_5:
        DC32     0xe000ed18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_6:
        DC32     0xe000ed0c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_7:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_8:
        DC32     0xe000e200

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_9:
        DC32     0xe000ef00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_10:
        DC32     0xe000e300

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_11:
        DC32     0xe000ed00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_12:
        DC32     0x3fffff80

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_13:
        DC32     0xe000ed08

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_14:
        DC32     0xe000ed10

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_15:
        DC32     0xe000ed24

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_16:
        DC32     0xe000ed28

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19_17:
        DC32     0xe000ed34

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  723 
//  724 /******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
// 
// 656 bytes in section .text
// 
// 656 bytes of CODE memory
//
//Errors: none
//Warnings: none
