///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:04 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_exti.c                                /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_exti.c -D OS_INCLUDED -D APPL_SRC     /
//                    -lA D:\Work\Project\2012\NL_INBUILD\FW\MU\out\ -o       /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_ext /
//                    i.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_exti

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        PUBLIC EXTI_ClearFlag
        PUBLIC EXTI_ClearITPendingBit
        PUBLIC EXTI_DeInit
        PUBLIC EXTI_GenerateSWInterrupt
        PUBLIC EXTI_GetFlagStatus
        PUBLIC EXTI_GetITStatus
        PUBLIC EXTI_Init
        PUBLIC EXTI_StructInit
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_exti.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_exti.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7   * @brief   This file provides firmware functions to manage the following 
//    8   *          functionalities of the EXTI peripheral:           
//    9   *           - Initialization and Configuration
//   10   *           - Interrupts and flags management
//   11   *
//   12   *  @verbatim  
//   13   *  
//   14   *          ===================================================================
//   15   *                                     EXTI features
//   16   *          ===================================================================
//   17   *    
//   18   *          External interrupt/event lines are mapped as following:
//   19   *            1- All available GPIO pins are connected to the 16 external 
//   20   *               interrupt/event lines from EXTI0 to EXTI15.
//   21   *            2- EXTI line 16 is connected to the PVD Output
//   22   *            3- EXTI line 17 is connected to the RTC Alarm event
//   23   *            4- EXTI line 18 is connected to the USB OTG FS Wakeup from suspend event                                    
//   24   *            5- EXTI line 19 is connected to the Ethernet Wakeup event
//   25   *            6- EXTI line 20 is connected to the USB OTG HS (configured in FS) Wakeup event 
//   26   *            7- EXTI line 21 is connected to the RTC Tamper and Time Stamp events                                               
//   27   *            8- EXTI line 22 is connected to the RTC Wakeup event
//   28   *        
//   29   *          ===================================================================
//   30   *                                 How to use this driver
//   31   *          ===================================================================  
//   32   *              
//   33   *          In order to use an I/O pin as an external interrupt source, follow
//   34   *          steps below:
//   35   *            1- Configure the I/O in input mode using GPIO_Init()
//   36   *            2- Select the input source pin for the EXTI line using SYSCFG_EXTILineConfig()
//   37   *            3- Select the mode(interrupt, event) and configure the trigger 
//   38   *               selection (Rising, falling or both) using EXTI_Init()
//   39   *            4- Configure NVIC IRQ channel mapped to the EXTI line using NVIC_Init()
//   40   *   
//   41   *  @note  SYSCFG APB clock must be enabled to get write access to SYSCFG_EXTICRx
//   42   *         registers using RCC_APB2PeriphClockCmd(RCC_APB2Periph_SYSCFG, ENABLE);
//   43   *          
//   44   *  @endverbatim                  
//   45   *
//   46   ******************************************************************************
//   47   * @attention
//   48   *
//   49   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   50   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   51   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   52   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   53   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   54   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   55   *
//   56   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   57   ******************************************************************************
//   58   */
//   59 
//   60 /* Includes ------------------------------------------------------------------*/
//   61 #include "stm32f2xx_exti.h"
//   62 
//   63 /** @addtogroup STM32F2xx_StdPeriph_Driver
//   64   * @{
//   65   */
//   66 
//   67 /** @defgroup EXTI 
//   68   * @brief EXTI driver modules
//   69   * @{
//   70   */
//   71 
//   72 /* Private typedef -----------------------------------------------------------*/
//   73 /* Private define ------------------------------------------------------------*/
//   74 
//   75 #define EXTI_LINENONE    ((uint32_t)0x00000)  /* No interrupt selected */
//   76 
//   77 /* Private macro -------------------------------------------------------------*/
//   78 /* Private variables ---------------------------------------------------------*/
//   79 /* Private function prototypes -----------------------------------------------*/
//   80 /* Private functions ---------------------------------------------------------*/
//   81 
//   82 /** @defgroup EXTI_Private_Functions
//   83   * @{
//   84   */
//   85 
//   86 /** @defgroup EXTI_Group1 Initialization and Configuration functions
//   87  *  @brief   Initialization and Configuration functions 
//   88  *
//   89 @verbatim   
//   90  ===============================================================================
//   91                   Initialization and Configuration functions
//   92  ===============================================================================  
//   93 
//   94 @endverbatim
//   95   * @{
//   96   */
//   97 
//   98 /**
//   99   * @brief  Deinitializes the EXTI peripheral registers to their default reset values.
//  100   * @param  None
//  101   * @retval None
//  102   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function EXTI_DeInit
        THUMB
//  103 void EXTI_DeInit(void)
//  104 {
//  105   EXTI->IMR = 0x00000000;
EXTI_DeInit:
        LDR.N    R0,??DataTable5  ;; 0x40013c00
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  106   EXTI->EMR = 0x00000000;
        STR      R1,[R0, #+4]
//  107   EXTI->RTSR = 0x00000000;
        STR      R1,[R0, #+8]
//  108   EXTI->FTSR = 0x00000000;
        STR      R1,[R0, #+12]
//  109   EXTI->PR = 0x007FFFFF;
        LDR.N    R1,??DataTable5_1  ;; 0x7fffff
        STR      R1,[R0, #+20]
//  110 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//  111 
//  112 /**
//  113   * @brief  Initializes the EXTI peripheral according to the specified
//  114   *         parameters in the EXTI_InitStruct.
//  115   * @param  EXTI_InitStruct: pointer to a EXTI_InitTypeDef structure
//  116   *         that contains the configuration information for the EXTI peripheral.
//  117   * @retval None
//  118   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function EXTI_Init
        THUMB
//  119 void EXTI_Init(EXTI_InitTypeDef* EXTI_InitStruct)
//  120 {
EXTI_Init:
        PUSH     {R4,R5}
        CFI R5 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  121   uint32_t tmp = 0;
//  122 
//  123   /* Check the parameters */
//  124   assert_param(IS_EXTI_MODE(EXTI_InitStruct->EXTI_Mode));
//  125   assert_param(IS_EXTI_TRIGGER(EXTI_InitStruct->EXTI_Trigger));
//  126   assert_param(IS_EXTI_LINE(EXTI_InitStruct->EXTI_Line));  
//  127   assert_param(IS_FUNCTIONAL_STATE(EXTI_InitStruct->EXTI_LineCmd));
//  128 
//  129   tmp = (uint32_t)EXTI_BASE;
//  130      
//  131   if (EXTI_InitStruct->EXTI_LineCmd != DISABLE)
        LDR      R1,[R0, #+0]
        MVNS     R3,R1
        LDR.N    R1,??DataTable5  ;; 0x40013c00
        LDRB     R2,[R0, #+6]
        CBZ.N    R2,??EXTI_Init_0
//  132   {
//  133     /* Clear EXTI line configuration */
//  134     EXTI->IMR &= ~EXTI_InitStruct->EXTI_Line;
        MOV      R2,R1
        LDR      R4,[R2, #+0]
        ANDS     R3,R3,R4
        STR      R3,[R2, #+0]
//  135     EXTI->EMR &= ~EXTI_InitStruct->EXTI_Line;
        LDR      R3,[R2, #+4]
        LDR      R4,[R0, #+0]
        BICS     R3,R3,R4
        STR      R3,[R2, #+4]
//  136     
//  137     tmp += EXTI_InitStruct->EXTI_Mode;
        LDRB     R3,[R0, #+4]
        ADDS     R4,R1,R3
//  138 
//  139     *(__IO uint32_t *) tmp |= EXTI_InitStruct->EXTI_Line;
        LDR      R3,[R4, #+0]
        LDR      R5,[R0, #+0]
        ORRS     R3,R5,R3
        STR      R3,[R4, #+0]
//  140 
//  141     /* Clear Rising Falling edge configuration */
//  142     EXTI->RTSR &= ~EXTI_InitStruct->EXTI_Line;
        LDR      R3,[R2, #+8]
        LDR      R4,[R0, #+0]
        BICS     R3,R3,R4
        STR      R3,[R2, #+8]
//  143     EXTI->FTSR &= ~EXTI_InitStruct->EXTI_Line;
        LDR      R3,[R2, #+12]
        LDR      R4,[R0, #+0]
        BICS     R3,R3,R4
        STR      R3,[R2, #+12]
//  144     
//  145     /* Select the trigger for the selected external interrupts */
//  146     if (EXTI_InitStruct->EXTI_Trigger == EXTI_Trigger_Rising_Falling)
        LDRB     R3,[R0, #+5]
        LDR      R5,[R0, #+0]
        CMP      R3,#+16
        BNE.N    ??EXTI_Init_1
//  147     {
//  148       /* Rising Falling edge */
//  149       EXTI->RTSR |= EXTI_InitStruct->EXTI_Line;
        LDR      R1,[R2, #+8]
        ORRS     R1,R5,R1
        STR      R1,[R2, #+8]
//  150       EXTI->FTSR |= EXTI_InitStruct->EXTI_Line;
        LDR      R1,[R2, #+12]
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,R1
        STR      R0,[R2, #+12]
        B.N      ??EXTI_Init_2
//  151     }
//  152     else
//  153     {
//  154       tmp = (uint32_t)EXTI_BASE;
//  155       tmp += EXTI_InitStruct->EXTI_Trigger;
??EXTI_Init_1:
        ADDS     R4,R1,R3
//  156 
//  157       *(__IO uint32_t *) tmp |= EXTI_InitStruct->EXTI_Line;
        LDR      R0,[R4, #+0]
        ORRS     R0,R5,R0
        B.N      ??EXTI_Init_3
//  158     }
//  159   }
//  160   else
//  161   {
//  162     tmp += EXTI_InitStruct->EXTI_Mode;
??EXTI_Init_0:
        LDRB     R0,[R0, #+4]
        ADDS     R4,R1,R0
//  163 
//  164     /* Disable the selected external lines */
//  165     *(__IO uint32_t *) tmp &= ~EXTI_InitStruct->EXTI_Line;
        LDR      R0,[R4, #+0]
        ANDS     R0,R3,R0
??EXTI_Init_3:
        STR      R0,[R4, #+0]
//  166   }
//  167 }
??EXTI_Init_2:
        POP      {R4,R5}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  168 
//  169 /**
//  170   * @brief  Fills each EXTI_InitStruct member with its reset value.
//  171   * @param  EXTI_InitStruct: pointer to a EXTI_InitTypeDef structure which will
//  172   *         be initialized.
//  173   * @retval None
//  174   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function EXTI_StructInit
        THUMB
//  175 void EXTI_StructInit(EXTI_InitTypeDef* EXTI_InitStruct)
//  176 {
//  177   EXTI_InitStruct->EXTI_Line = EXTI_LINENONE;
EXTI_StructInit:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  178   EXTI_InitStruct->EXTI_Mode = EXTI_Mode_Interrupt;
        STRB     R1,[R0, #+4]
//  179   EXTI_InitStruct->EXTI_Trigger = EXTI_Trigger_Falling;
        MOVS     R1,#+12
        STRB     R1,[R0, #+5]
//  180   EXTI_InitStruct->EXTI_LineCmd = DISABLE;
        MOVS     R1,#+0
        STRB     R1,[R0, #+6]
//  181 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  182 
//  183 /**
//  184   * @brief  Generates a Software interrupt on selected EXTI line.
//  185   * @param  EXTI_Line: specifies the EXTI line on which the software interrupt
//  186   *         will be generated.
//  187   *         This parameter can be any combination of EXTI_Linex where x can be (0..22)
//  188   * @retval None
//  189   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function EXTI_GenerateSWInterrupt
        THUMB
//  190 void EXTI_GenerateSWInterrupt(uint32_t EXTI_Line)
//  191 {
//  192   /* Check the parameters */
//  193   assert_param(IS_EXTI_LINE(EXTI_Line));
//  194   
//  195   EXTI->SWIER |= EXTI_Line;
EXTI_GenerateSWInterrupt:
        LDR.N    R1,??DataTable5_2  ;; 0x40013c10
        LDR      R2,[R1, #+0]
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  196 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  197 
//  198 /**
//  199   * @}
//  200   */
//  201 
//  202 /** @defgroup EXTI_Group2 Interrupts and flags management functions
//  203  *  @brief   Interrupts and flags management functions 
//  204  *
//  205 @verbatim   
//  206  ===============================================================================
//  207                   Interrupts and flags management functions
//  208  ===============================================================================  
//  209 
//  210 @endverbatim
//  211   * @{
//  212   */
//  213 
//  214 /**
//  215   * @brief  Checks whether the specified EXTI line flag is set or not.
//  216   * @param  EXTI_Line: specifies the EXTI line flag to check.
//  217   *          This parameter can be EXTI_Linex where x can be(0..22)
//  218   * @retval The new state of EXTI_Line (SET or RESET).
//  219   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function EXTI_GetFlagStatus
        THUMB
//  220 FlagStatus EXTI_GetFlagStatus(uint32_t EXTI_Line)
//  221 {
//  222   FlagStatus bitstatus = RESET;
EXTI_GetFlagStatus:
        MOVS     R1,#+0
//  223   /* Check the parameters */
//  224   assert_param(IS_GET_EXTI_LINE(EXTI_Line));
//  225   
//  226   if ((EXTI->PR & EXTI_Line) != (uint32_t)RESET)
        LDR.N    R2,??DataTable5_3  ;; 0x40013c14
        LDR      R2,[R2, #+0]
        TST      R2,R0
        IT       NE 
        MOVNE    R1,#+1
//  227   {
//  228     bitstatus = SET;
//  229   }
//  230   else
//  231   {
//  232     bitstatus = RESET;
//  233   }
//  234   return bitstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  235 }
//  236 
//  237 /**
//  238   * @brief  Clears the EXTI's line pending flags.
//  239   * @param  EXTI_Line: specifies the EXTI lines flags to clear.
//  240   *          This parameter can be any combination of EXTI_Linex where x can be (0..22)
//  241   * @retval None
//  242   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function EXTI_ClearFlag
        THUMB
//  243 void EXTI_ClearFlag(uint32_t EXTI_Line)
//  244 {
//  245   /* Check the parameters */
//  246   assert_param(IS_EXTI_LINE(EXTI_Line));
//  247   
//  248   EXTI->PR = EXTI_Line;
EXTI_ClearFlag:
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock5
//  249 }
//  250 
//  251 /**
//  252   * @brief  Checks whether the specified EXTI line is asserted or not.
//  253   * @param  EXTI_Line: specifies the EXTI line to check.
//  254   *          This parameter can be EXTI_Linex where x can be(0..22)
//  255   * @retval The new state of EXTI_Line (SET or RESET).
//  256   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function EXTI_GetITStatus
        THUMB
//  257 ITStatus EXTI_GetITStatus(uint32_t EXTI_Line)
//  258 {
//  259   ITStatus bitstatus = RESET;
EXTI_GetITStatus:
        MOVS     R1,#+0
//  260   uint32_t enablestatus = 0;
//  261   /* Check the parameters */
//  262   assert_param(IS_GET_EXTI_LINE(EXTI_Line));
//  263   
//  264   enablestatus =  EXTI->IMR & EXTI_Line;
        LDR.N    R2,??DataTable5  ;; 0x40013c00
        LDR      R3,[R2, #+0]
        ANDS     R3,R0,R3
//  265   if (((EXTI->PR & EXTI_Line) != (uint32_t)RESET) && (enablestatus != (uint32_t)RESET))
        LDR      R2,[R2, #+20]
        TST      R2,R0
        BEQ.N    ??EXTI_GetITStatus_0
        CBZ.N    R3,??EXTI_GetITStatus_0
//  266   {
//  267     bitstatus = SET;
        MOVS     R1,#+1
//  268   }
//  269   else
//  270   {
//  271     bitstatus = RESET;
//  272   }
//  273   return bitstatus;
??EXTI_GetITStatus_0:
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  274 }
//  275 
//  276 /**
//  277   * @brief  Clears the EXTI's line pending bits.
//  278   * @param  EXTI_Line: specifies the EXTI lines to clear.
//  279   *          This parameter can be any combination of EXTI_Linex where x can be (0..22)
//  280   * @retval None
//  281   */

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  282 void EXTI_ClearITPendingBit(uint32_t EXTI_Line)
//  283 {
//  284   /* Check the parameters */
//  285   assert_param(IS_EXTI_LINE(EXTI_Line));
//  286   
//  287   EXTI->PR = EXTI_Line;
EXTI_ClearITPendingBit:
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        LDR.N    R1,??DataTable5_3  ;; 0x40013c14
        STR      R0,[R1, #+0]
//  288 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x40013c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     0x7fffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     0x40013c10

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     0x40013c14

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  289 
//  290 /**
//  291   * @}
//  292   */
//  293 
//  294 /**
//  295   * @}
//  296   */
//  297 
//  298 /**
//  299   * @}
//  300   */
//  301 
//  302 /**
//  303   * @}
//  304   */
//  305 
//  306 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 208 bytes in section .text
// 
// 208 bytes of CODE memory
//
//Errors: none
//Warnings: none
