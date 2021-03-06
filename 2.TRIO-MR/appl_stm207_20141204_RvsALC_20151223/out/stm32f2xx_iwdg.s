///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:00 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_iwdg.c                                /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_iwdg.c -D OS_INCLUDED -D APPL_SRC     /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_iwd /
//                    g.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_iwdg

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        PUBLIC IWDG_Enable
        PUBLIC IWDG_GetFlagStatus
        PUBLIC IWDG_ReloadCounter
        PUBLIC IWDG_SetPrescaler
        PUBLIC IWDG_SetReload
        PUBLIC IWDG_WriteAccessCmd
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_iwdg.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_iwdg.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7   * @brief   This file provides firmware functions to manage the following 
//    8   *          functionalities of the Independent watchdog (IWDG) peripheral:           
//    9   *           - Prescaler and Counter configuration
//   10   *           - IWDG activation
//   11   *           - Flag management
//   12   *
//   13   *  @verbatim  
//   14   *  
//   15   *          ===================================================================
//   16   *                                     IWDG features
//   17   *          ===================================================================
//   18   *    
//   19   *          The IWDG can be started by either software or hardware (configurable
//   20   *          through option byte).
//   21   *            
//   22   *          The IWDG is clocked by its own dedicated low-speed clock (LSI) and
//   23   *          thus stays active even if the main clock fails.
//   24   *          Once the IWDG is started, the LSI is forced ON and cannot be disabled
//   25   *          (LSI cannot be disabled too), and the counter starts counting down from 
//   26   *          the reset value of 0xFFF. When it reaches the end of count value (0x000)
//   27   *          a system reset is generated.
//   28   *          The IWDG counter should be reloaded at regular intervals to prevent
//   29   *          an MCU reset.
//   30   *                           
//   31   *          The IWDG is implemented in the VDD voltage domain that is still functional
//   32   *          in STOP and STANDBY mode (IWDG reset can wake-up from STANDBY).          
//   33   *            
//   34   *          IWDGRST flag in RCC_CSR register can be used to inform when a IWDG
//   35   *          reset occurs.
//   36   *            
//   37   *          Min-max timeout value @32KHz (LSI): ~125us / ~32.7s
//   38   *          The IWDG timeout may vary due to LSI frequency dispersion. STM32F2xx
//   39   *          devices provide the capability to measure the LSI frequency (LSI clock
//   40   *          connected internally to TIM5 CH4 input capture). The measured value
//   41   *          can be used to have an IWDG timeout with an acceptable accuracy. 
//   42   *          For more information, please refer to the STM32F2xx Reference manual
//   43   *          
//   44   *                            
//   45   *          ===================================================================
//   46   *                                 How to use this driver
//   47   *          ===================================================================
//   48   *          1. Enable write access to IWDG_PR and IWDG_RLR registers using
//   49   *             IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable) function
//   50   *               
//   51   *          2. Configure the IWDG prescaler using IWDG_SetPrescaler() function
//   52   *            
//   53   *          3. Configure the IWDG counter value using IWDG_SetReload() function.
//   54   *             This value will be loaded in the IWDG counter each time the counter
//   55   *             is reloaded, then the IWDG will start counting down from this value.
//   56   *            
//   57   *          4. Start the IWDG using IWDG_Enable() function, when the IWDG is used
//   58   *             in software mode (no need to enable the LSI, it will be enabled
//   59   *             by hardware)
//   60   *             
//   61   *          5. Then the application program must reload the IWDG counter at regular
//   62   *             intervals during normal operation to prevent an MCU reset, using
//   63   *             IWDG_ReloadCounter() function.      
//   64   *          
//   65   *  @endverbatim
//   66   *    
//   67   ******************************************************************************
//   68   * @attention
//   69   *
//   70   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   71   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   72   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   73   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   74   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   75   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   76   *
//   77   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   78   ******************************************************************************
//   79   */
//   80 
//   81 /* Includes ------------------------------------------------------------------*/
//   82 #include "stm32f2xx_iwdg.h"
//   83 
//   84 /** @addtogroup STM32F2xx_StdPeriph_Driver
//   85   * @{
//   86   */
//   87 
//   88 /** @defgroup IWDG 
//   89   * @brief IWDG driver modules
//   90   * @{
//   91   */ 
//   92 
//   93 /* Private typedef -----------------------------------------------------------*/
//   94 /* Private define ------------------------------------------------------------*/
//   95 
//   96 /* KR register bit mask */
//   97 #define KR_KEY_RELOAD    ((uint16_t)0xAAAA)
//   98 #define KR_KEY_ENABLE    ((uint16_t)0xCCCC)
//   99 
//  100 /* Private macro -------------------------------------------------------------*/
//  101 /* Private variables ---------------------------------------------------------*/
//  102 /* Private function prototypes -----------------------------------------------*/
//  103 /* Private functions ---------------------------------------------------------*/
//  104 
//  105 /** @defgroup IWDG_Private_Functions
//  106   * @{
//  107   */
//  108 
//  109 /** @defgroup IWDG_Group1 Prescaler and Counter configuration functions
//  110  *  @brief   Prescaler and Counter configuration functions
//  111  *
//  112 @verbatim   
//  113  ===============================================================================
//  114                   Prescaler and Counter configuration functions
//  115  ===============================================================================  
//  116 
//  117 @endverbatim
//  118   * @{
//  119   */
//  120 
//  121 /**
//  122   * @brief  Enables or disables write access to IWDG_PR and IWDG_RLR registers.
//  123   * @param  IWDG_WriteAccess: new state of write access to IWDG_PR and IWDG_RLR registers.
//  124   *          This parameter can be one of the following values:
//  125   *            @arg IWDG_WriteAccess_Enable: Enable write access to IWDG_PR and IWDG_RLR registers
//  126   *            @arg IWDG_WriteAccess_Disable: Disable write access to IWDG_PR and IWDG_RLR registers
//  127   * @retval None
//  128   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function IWDG_WriteAccessCmd
        THUMB
//  129 void IWDG_WriteAccessCmd(uint16_t IWDG_WriteAccess)
//  130 {
//  131   /* Check the parameters */
//  132   assert_param(IS_IWDG_WRITE_ACCESS(IWDG_WriteAccess));
//  133   IWDG->KR = IWDG_WriteAccess;
IWDG_WriteAccessCmd:
        LDR.N    R1,??DataTable5  ;; 0x40003000
        STR      R0,[R1, #+0]
//  134 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//  135 
//  136 /**
//  137   * @brief  Sets IWDG Prescaler value.
//  138   * @param  IWDG_Prescaler: specifies the IWDG Prescaler value.
//  139   *          This parameter can be one of the following values:
//  140   *            @arg IWDG_Prescaler_4: IWDG prescaler set to 4
//  141   *            @arg IWDG_Prescaler_8: IWDG prescaler set to 8
//  142   *            @arg IWDG_Prescaler_16: IWDG prescaler set to 16
//  143   *            @arg IWDG_Prescaler_32: IWDG prescaler set to 32
//  144   *            @arg IWDG_Prescaler_64: IWDG prescaler set to 64
//  145   *            @arg IWDG_Prescaler_128: IWDG prescaler set to 128
//  146   *            @arg IWDG_Prescaler_256: IWDG prescaler set to 256
//  147   * @retval None
//  148   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function IWDG_SetPrescaler
        THUMB
//  149 void IWDG_SetPrescaler(uint8_t IWDG_Prescaler)
//  150 {
//  151   /* Check the parameters */
//  152   assert_param(IS_IWDG_PRESCALER(IWDG_Prescaler));
//  153   IWDG->PR = IWDG_Prescaler;
IWDG_SetPrescaler:
        LDR.N    R1,??DataTable5_1  ;; 0x40003004
        STR      R0,[R1, #+0]
//  154 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  155 
//  156 /**
//  157   * @brief  Sets IWDG Reload value.
//  158   * @param  Reload: specifies the IWDG Reload value.
//  159   *          This parameter must be a number between 0 and 0x0FFF.
//  160   * @retval None
//  161   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function IWDG_SetReload
        THUMB
//  162 void IWDG_SetReload(uint16_t Reload)
//  163 {
//  164   /* Check the parameters */
//  165   assert_param(IS_IWDG_RELOAD(Reload));
//  166   IWDG->RLR = Reload;
IWDG_SetReload:
        LDR.N    R1,??DataTable5_2  ;; 0x40003008
        STR      R0,[R1, #+0]
//  167 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  168 
//  169 /**
//  170   * @brief  Reloads IWDG counter with value defined in the reload register
//  171   *         (write access to IWDG_PR and IWDG_RLR registers disabled).
//  172   * @param  None
//  173   * @retval None
//  174   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function IWDG_ReloadCounter
        THUMB
//  175 void IWDG_ReloadCounter(void)
//  176 {
//  177   IWDG->KR = KR_KEY_RELOAD;
IWDG_ReloadCounter:
        LDR.N    R0,??DataTable5  ;; 0x40003000
        MOVW     R1,#+43690
        STR      R1,[R0, #+0]
//  178 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  179 
//  180 /**
//  181   * @}
//  182   */
//  183 
//  184 /** @defgroup IWDG_Group2 IWDG activation function
//  185  *  @brief   IWDG activation function 
//  186  *
//  187 @verbatim   
//  188  ===============================================================================
//  189                           IWDG activation function
//  190  ===============================================================================  
//  191 
//  192 @endverbatim
//  193   * @{
//  194   */
//  195 
//  196 /**
//  197   * @brief  Enables IWDG (write access to IWDG_PR and IWDG_RLR registers disabled).
//  198   * @param  None
//  199   * @retval None
//  200   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function IWDG_Enable
        THUMB
//  201 void IWDG_Enable(void)
//  202 {
//  203   IWDG->KR = KR_KEY_ENABLE;
IWDG_Enable:
        LDR.N    R0,??DataTable5  ;; 0x40003000
        MOVW     R1,#+52428
        STR      R1,[R0, #+0]
//  204 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  205 
//  206 /**
//  207   * @}
//  208   */
//  209 
//  210 /** @defgroup IWDG_Group3 Flag management function 
//  211  *  @brief  Flag management function  
//  212  *
//  213 @verbatim   
//  214  ===============================================================================
//  215                             Flag management function 
//  216  ===============================================================================  
//  217 
//  218 @endverbatim
//  219   * @{
//  220   */
//  221 
//  222 /**
//  223   * @brief  Checks whether the specified IWDG flag is set or not.
//  224   * @param  IWDG_FLAG: specifies the flag to check.
//  225   *          This parameter can be one of the following values:
//  226   *            @arg IWDG_FLAG_PVU: Prescaler Value Update on going
//  227   *            @arg IWDG_FLAG_RVU: Reload Value Update on going
//  228   * @retval The new state of IWDG_FLAG (SET or RESET).
//  229   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function IWDG_GetFlagStatus
        THUMB
//  230 FlagStatus IWDG_GetFlagStatus(uint16_t IWDG_FLAG)
//  231 {
//  232   FlagStatus bitstatus = RESET;
IWDG_GetFlagStatus:
        MOVS     R1,#+0
//  233   /* Check the parameters */
//  234   assert_param(IS_IWDG_FLAG(IWDG_FLAG));
//  235   if ((IWDG->SR & IWDG_FLAG) != (uint32_t)RESET)
        LDR.N    R2,??DataTable5_3  ;; 0x4000300c
        LDR      R2,[R2, #+0]
        UXTH     R2,R2
        TST      R2,R0
        IT       NE 
        MOVNE    R1,#+1
//  236   {
//  237     bitstatus = SET;
//  238   }
//  239   else
//  240   {
//  241     bitstatus = RESET;
//  242   }
//  243   /* Return the flag status */
//  244   return bitstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  245 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x40003000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     0x40003004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     0x40003008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     0x4000300c

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  246 
//  247 /**
//  248   * @}
//  249   */
//  250 
//  251 /**
//  252   * @}
//  253   */
//  254 
//  255 /**
//  256   * @}
//  257   */
//  258 
//  259 /**
//  260   * @}
//  261   */
//  262 
//  263 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 72 bytes in section .text
// 
// 72 bytes of CODE memory
//
//Errors: none
//Warnings: none
