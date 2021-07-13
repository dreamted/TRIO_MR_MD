///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:00 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_gpio_1208.c                           /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_gpio_1208.c -D OS_INCLUDED -D         /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_gpi /
//                    o_1208.s                                                /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_gpio_1208

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        EXTERN RCC_AHB1PeriphResetCmd

        PUBLIC GPIOPortInit
        PUBLIC GPIO_DeInit
        PUBLIC GPIO_Init
        PUBLIC GPIO_PinAFConfig
        PUBLIC GPIO_PinLockConfig
        PUBLIC GPIO_ReadInputData
        PUBLIC GPIO_ReadInputDataBit
        PUBLIC GPIO_ReadOutputData
        PUBLIC GPIO_ReadOutputDataBit
        PUBLIC GPIO_ResetBits
        PUBLIC GPIO_SetBits
        PUBLIC GPIO_StructInit
        PUBLIC GPIO_ToggleBits
        PUBLIC GPIO_Write
        PUBLIC GPIO_WriteBit
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_gpio_1208.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_gpio.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7   * @brief   This file provides firmware functions to manage the following 
//    8   *          functionalities of the GPIO peripheral:           
//    9   *           - Initialization and Configuration
//   10   *           - GPIO Read and Write
//   11   *           - GPIO Alternate functions configuration
//   12   * 
//   13   *  @verbatim
//   14   *
//   15   *          ===================================================================
//   16   *                                 How to use this driver
//   17   *          ===================================================================       
//   18   *           1. Enable the GPIO AHB clock using the following function
//   19   *                RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOx, ENABLE);
//   20   *             
//   21   *           2. Configure the GPIO pin(s) using GPIO_Init()
//   22   *              Four possible configuration are available for each pin:
//   23   *                - Input: Floating, Pull-up, Pull-down.
//   24   *                - Output: Push-Pull (Pull-up, Pull-down or no Pull)
//   25   *                          Open Drain (Pull-up, Pull-down or no Pull).
//   26   *                  In output mode, the speed is configurable: 2 MHz, 25 MHz,
//   27   *                  50 MHz or 100 MHz.
//   28   *                - Alternate Function: Push-Pull (Pull-up, Pull-down or no Pull)
//   29   *                                      Open Drain (Pull-up, Pull-down or no Pull).
//   30   *                - Analog: required mode when a pin is to be used as ADC channel
//   31   *                          or DAC output.
//   32   * 
//   33   *          3- Peripherals alternate function:
//   34   *              - For ADC and DAC, configure the desired pin in analog mode using 
//   35   *                  GPIO_InitStruct->GPIO_Mode = GPIO_Mode_AN;
//   36   *              - For other peripherals (TIM, USART...):
//   37   *                 - Connect the pin to the desired peripherals' Alternate 
//   38   *                   Function (AF) using GPIO_PinAFConfig() function
//   39   *                 - Configure the desired pin in alternate function mode using
//   40   *                   GPIO_InitStruct->GPIO_Mode = GPIO_Mode_AF
//   41   *                 - Select the type, pull-up/pull-down and output speed via 
//   42   *                   GPIO_PuPd, GPIO_OType and GPIO_Speed members
//   43   *                 - Call GPIO_Init() function
//   44   *        
//   45   *          4. To get the level of a pin configured in input mode use GPIO_ReadInputDataBit()
//   46   *          
//   47   *          5. To set/reset the level of a pin configured in output mode use
//   48   *             GPIO_SetBits()/GPIO_ResetBits()
//   49   *               
//   50   *          6. During and just after reset, the alternate functions are not 
//   51   *             active and the GPIO pins are configured in input floating mode
//   52   *             (except JTAG pins).
//   53   *
//   54   *          7. The LSE oscillator pins OSC32_IN and OSC32_OUT can be used as 
//   55   *             general-purpose (PC14 and PC15, respectively) when the LSE
//   56   *             oscillator is off. The LSE has priority over the GPIO function.
//   57   *
//   58   *          8. The HSE oscillator pins OSC_IN/OSC_OUT can be used as 
//   59   *             general-purpose PH0 and PH1, respectively, when the HSE 
//   60   *             oscillator is off. The HSE has priority over the GPIO function.
//   61   *             
//   62   *  @endverbatim        
//   63   *
//   64   ******************************************************************************
//   65   * @attention
//   66   *
//   67   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   68   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   69   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   70   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   71   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   72   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   73   *
//   74   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   75   ******************************************************************************
//   76   */
//   77 
//   78 /* Includes ------------------------------------------------------------------*/
//   79 #include "stm32f2xx_gpio_1208.h"
//   80 #include "stm32f2xx_rcc_1208.h"
//   81 
//   82 /** @addtogroup STM32F2xx_StdPeriph_Driver
//   83   * @{
//   84   */
//   85 
//   86 /** @defgroup GPIO 
//   87   * @brief GPIO driver modules
//   88   * @{
//   89   */ 
//   90 
//   91 /* Private typedef -----------------------------------------------------------*/
//   92 /* Private define ------------------------------------------------------------*/
//   93 /* Private macro -------------------------------------------------------------*/
//   94 /* Private variables ---------------------------------------------------------*/
//   95 /* Private function prototypes -----------------------------------------------*/
//   96 /* Private functions ---------------------------------------------------------*/
//   97 
//   98 /** @defgroup GPIO_Private_Functions
//   99   * @{
//  100   */ 
//  101 
//  102 /** @defgroup GPIO_Group1 Initialization and Configuration
//  103  *  @brief   Initialization and Configuration
//  104  *
//  105 @verbatim   
//  106  ===============================================================================
//  107                         Initialization and Configuration
//  108  ===============================================================================  
//  109 
//  110 @endverbatim
//  111   * @{
//  112   */
//  113 
//  114 /**
//  115   * @brief  Deinitializes the GPIOx peripheral registers to their default reset values.
//  116   * @note   By default, The GPIO pins are configured in input floating mode (except JTAG pins).
//  117   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  118   * @retval None
//  119   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function GPIO_DeInit
        THUMB
//  120 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
//  121 {
GPIO_DeInit:
        PUSH     {R7,LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+8
//  122   /* Check the parameters */
//  123   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  124 
//  125   if (GPIOx == GPIOA)
        LDR.N    R1,??DataTable0  ;; 0x40020000
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_0
//  126   {
//  127     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOA, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       RCC_AHB1PeriphResetCmd
//  128     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOA, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
        B.N      ??GPIO_DeInit_1
//  129   }
//  130   else if (GPIOx == GPIOB)
??GPIO_DeInit_0:
        LDR.N    R1,??DataTable0_1  ;; 0x40020400
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_2
//  131   {
//  132     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOB, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+2
        BL       RCC_AHB1PeriphResetCmd
//  133     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOB, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+2
        B.N      ??GPIO_DeInit_1
//  134   }
//  135   else if (GPIOx == GPIOC)
??GPIO_DeInit_2:
        LDR.N    R1,??DataTable0_2  ;; 0x40020800
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_3
//  136   {
//  137     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOC, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       RCC_AHB1PeriphResetCmd
//  138     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOC, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+4
        B.N      ??GPIO_DeInit_1
//  139   }
//  140   else if (GPIOx == GPIOD)
??GPIO_DeInit_3:
        LDR.N    R1,??DataTable0_3  ;; 0x40020c00
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_4
//  141   {
//  142     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOD, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+8
        BL       RCC_AHB1PeriphResetCmd
//  143     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOD, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+8
        B.N      ??GPIO_DeInit_1
//  144   }
//  145   else if (GPIOx == GPIOE)
??GPIO_DeInit_4:
        LDR.N    R1,??DataTable0_4  ;; 0x40021000
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_5
//  146   {
//  147     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOE, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+16
        BL       RCC_AHB1PeriphResetCmd
//  148     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOE, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+16
        B.N      ??GPIO_DeInit_1
//  149   }
//  150   else if (GPIOx == GPIOF)
??GPIO_DeInit_5:
        LDR.N    R1,??DataTable0_5  ;; 0x40021400
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_6
//  151   {
//  152     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOF, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+32
        BL       RCC_AHB1PeriphResetCmd
//  153     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOF, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+32
        B.N      ??GPIO_DeInit_1
//  154   }
//  155   else if (GPIOx == GPIOG)
??GPIO_DeInit_6:
        LDR.N    R1,??DataTable0_6  ;; 0x40021800
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_7
//  156   {
//  157     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOG, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+64
        BL       RCC_AHB1PeriphResetCmd
//  158     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOG, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+64
        B.N      ??GPIO_DeInit_1
//  159   }
//  160   else if (GPIOx == GPIOH)
??GPIO_DeInit_7:
        LDR.N    R1,??DataTable0_7  ;; 0x40021c00
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_8
//  161   {
//  162     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOH, ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+128
        BL       RCC_AHB1PeriphResetCmd
//  163     RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOH, DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+128
        B.N      ??GPIO_DeInit_1
//  164   }
//  165   else
//  166   {
//  167     if (GPIOx == GPIOI)
??GPIO_DeInit_8:
        LDR.N    R1,??DataTable0_8  ;; 0x40022000
        CMP      R0,R1
        BNE.N    ??GPIO_DeInit_9
//  168     {
//  169       RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOI, ENABLE);
        MOVS     R1,#+1
        MOV      R0,#+256
        BL       RCC_AHB1PeriphResetCmd
//  170       RCC_AHB1PeriphResetCmd(RCC_AHB1Periph_GPIOI, DISABLE);
        MOVS     R1,#+0
        MOV      R0,#+256
??GPIO_DeInit_1:
        BL       RCC_AHB1PeriphResetCmd
//  171     }
//  172   }
//  173 }
??GPIO_DeInit_9:
        POP      {R0,PC}          ;; return
        CFI EndBlock cfiBlock0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     0x40020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     0x40020400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     0x40020800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     0x40020c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_4:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_5:
        DC32     0x40021400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_6:
        DC32     0x40021800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_7:
        DC32     0x40021c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_8:
        DC32     0x40022000
//  174 
//  175 /**
//  176   * @brief  Initializes the GPIOx peripheral according to the specified parameters in the GPIO_InitStruct.
//  177   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  178   * @param  GPIO_InitStruct: pointer to a GPIO_InitTypeDef structure that contains
//  179   *         the configuration information for the specified GPIO peripheral.
//  180   * @retval None
//  181   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function GPIO_Init
        THUMB
//  182 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_InitTypeDef* GPIO_InitStruct)
//  183 {
GPIO_Init:
        PUSH     {R4-R7}
        CFI R7 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
//  184   uint32_t pinpos = 0x00, pos = 0x00 , currentpin = 0x00;
        MOVS     R2,#+0
//  185 
//  186   /* Check the parameters */
//  187   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  188   assert_param(IS_GPIO_PIN(GPIO_InitStruct->GPIO_Pin));
//  189   assert_param(IS_GPIO_MODE(GPIO_InitStruct->GPIO_Mode));
//  190   assert_param(IS_GPIO_PUPD(GPIO_InitStruct->GPIO_PuPd));
//  191 
//  192   /* -------------------------Configure the port pins---------------- */
//  193   /*-- GPIO Mode Configuration --*/
//  194   for (pinpos = 0x00; pinpos < 0x10; pinpos++)
        MOVS     R3,#+0
        MOVS     R4,#+1
//  195   {
//  196     pos = ((uint32_t)0x01) << pinpos;
??GPIO_Init_0:
        LSL      R5,R4,R2
//  197     /* Get the port pins position */
//  198     currentpin = (GPIO_InitStruct->GPIO_Pin) & pos;
//  199 
//  200     if (currentpin == pos)
        LDR      R6,[R1, #+0]
        ANDS     R6,R5,R6
        CMP      R6,R5
        BNE.N    ??GPIO_Init_1
//  201     {
//  202       GPIOx->MODER  &= ~(GPIO_MODER_MODER0 << (pinpos * 2));
        MOVS     R6,#+3
        LSLS     R6,R6,R3
        MVNS     R6,R6
        LDR      R7,[R0, #+0]
        ANDS     R7,R6,R7
        STR      R7,[R0, #+0]
//  203       GPIOx->MODER |= (((uint32_t)GPIO_InitStruct->GPIO_Mode) << (pinpos * 2));
        LDR      R7,[R0, #+0]
        LDRB     R12,[R1, #+4]
        LSL      R12,R12,R3
        ORR      R7,R12,R7
        STR      R7,[R0, #+0]
//  204 
//  205       if ((GPIO_InitStruct->GPIO_Mode == GPIO_Mode_OUT) || (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_AF))
        LDRB     R7,[R1, #+4]
        CMP      R7,#+1
        BEQ.N    ??GPIO_Init_2
        CMP      R7,#+2
        BNE.N    ??GPIO_Init_3
//  206       {
//  207         /* Check Speed mode parameters */
//  208         assert_param(IS_GPIO_SPEED(GPIO_InitStruct->GPIO_Speed));
//  209 
//  210         /* Speed mode configuration */
//  211         GPIOx->OSPEEDR &= ~(GPIO_OSPEEDER_OSPEEDR0 << (pinpos * 2));
??GPIO_Init_2:
        LDR      R7,[R0, #+8]
        ANDS     R7,R6,R7
        STR      R7,[R0, #+8]
//  212         GPIOx->OSPEEDR |= ((uint32_t)(GPIO_InitStruct->GPIO_Speed) << (pinpos * 2));
        LDR      R7,[R0, #+8]
        LDRB     R12,[R1, #+5]
        LSL      R12,R12,R3
        ORR      R7,R12,R7
        STR      R7,[R0, #+8]
//  213 
//  214         /* Check Output mode parameters */
//  215         assert_param(IS_GPIO_OTYPE(GPIO_InitStruct->GPIO_OType));
//  216 
//  217         /* Output mode configuration*/
//  218         GPIOx->OTYPER  &= ~((GPIO_OTYPER_OT_0) << ((uint16_t)pinpos)) ;
        LDR      R7,[R0, #+4]
        BIC      R5,R7,R5
        STR      R5,[R0, #+4]
//  219         GPIOx->OTYPER |= (uint16_t)(((uint16_t)GPIO_InitStruct->GPIO_OType) << ((uint16_t)pinpos));
        LDR      R5,[R0, #+4]
        LDRB     R7,[R1, #+6]
        LSLS     R7,R7,R2
        UXTH     R7,R7
        ORRS     R5,R7,R5
        STR      R5,[R0, #+4]
//  220       }
//  221 
//  222       /* Pull-up Pull down resistor configuration*/
//  223       GPIOx->PUPDR &= ~(GPIO_PUPDR_PUPDR0 << ((uint16_t)pinpos * 2));
??GPIO_Init_3:
        LDR      R5,[R0, #+12]
        ANDS     R5,R6,R5
        STR      R5,[R0, #+12]
//  224       GPIOx->PUPDR |= (((uint32_t)GPIO_InitStruct->GPIO_PuPd) << (pinpos * 2));
        LDR      R5,[R0, #+12]
        LDRB     R6,[R1, #+7]
        LSLS     R6,R6,R3
        ORRS     R5,R6,R5
        STR      R5,[R0, #+12]
//  225     }
//  226   }
??GPIO_Init_1:
        ADDS     R2,R2,#+1
        ADDS     R3,R3,#+2
        CMP      R2,#+16
        BCC.N    ??GPIO_Init_0
//  227 }
        POP      {R4-R7}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  228 
//  229 /**
//  230   * @brief  Fills each GPIO_InitStruct member with its default value.
//  231   * @param  GPIO_InitStruct : pointer to a GPIO_InitTypeDef structure which will be initialized.
//  232   * @retval None
//  233   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function GPIO_StructInit
        THUMB
//  234 void GPIO_StructInit(GPIO_InitTypeDef* GPIO_InitStruct)
//  235 {
//  236   /* Reset GPIO init structure parameters values */
//  237 	GPIO_InitStruct->GPIO_Pin  = GPIO_Pin_All;
GPIO_StructInit:
        MOVW     R1,#+65535
        STR      R1,[R0, #+0]
//  238 	GPIO_InitStruct->GPIO_Mode = GPIO_Mode_IN;
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
//  239 	GPIO_InitStruct->GPIO_Speed = GPIO_Speed_2MHz;
        STRB     R1,[R0, #+5]
//  240 	GPIO_InitStruct->GPIO_OType = GPIO_OType_PP;
        STRB     R1,[R0, #+6]
//  241 	GPIO_InitStruct->GPIO_PuPd = GPIO_PuPd_NOPULL;
        STRB     R1,[R0, #+7]
//  242 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  243 
//  244 /**
//  245   * @brief  Locks GPIO Pins configuration registers.
//  246   * @note   The locked registers are GPIOx_MODER, GPIOx_OTYPER, GPIOx_OSPEEDR,
//  247   *         GPIOx_PUPDR, GPIOx_AFRL and GPIOx_AFRH.
//  248   * @note   The configuration of the locked GPIO pins can no longer be modified
//  249   *         until the next reset.
//  250   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  251   * @param  GPIO_Pin: specifies the port bit to be locked.
//  252   *          This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
//  253   * @retval None
//  254   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function GPIO_PinLockConfig
        THUMB
//  255 void GPIO_PinLockConfig(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
//  256 {
GPIO_PinLockConfig:
        SUB      SP,SP,#+4
        CFI CFA R13+4
//  257 	__IO uint32_t tmp = 0x00010000;
        MOV      R2,#+65536
        STR      R2,[SP, #+0]
//  258 
//  259 	/* Check the parameters */
//  260 	assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  261 	assert_param(IS_GPIO_PIN(GPIO_Pin));
//  262 
//  263 	tmp |= GPIO_Pin;
        LDR      R2,[SP, #+0]
        ORRS     R2,R1,R2
        STR      R2,[SP, #+0]
//  264 	/* Set LCKK bit */
//  265 	GPIOx->LCKR = tmp;
        LDR      R2,[SP, #+0]
        STR      R2,[R0, #+28]
//  266 	/* Reset LCKK bit */
//  267 	GPIOx->LCKR =  GPIO_Pin;
        STR      R1,[R0, #+28]
//  268 	/* Set LCKK bit */
//  269 	GPIOx->LCKR = tmp;
        LDR      R1,[SP, #+0]
        STR      R1,[R0, #+28]
//  270 	/* Read LCKK bit*/
//  271 	tmp = GPIOx->LCKR;
        LDR      R1,[R0, #+28]
        STR      R1,[SP, #+0]
//  272 	/* Read LCKK bit*/
//  273 	tmp = GPIOx->LCKR;
        LDR      R0,[R0, #+28]
        STR      R0,[SP, #+0]
//  274 }
        ADD      SP,SP,#+4
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  275 
//  276 /**
//  277   * @}
//  278   */
//  279 
//  280 /** @defgroup GPIO_Group2 GPIO Read and Write
//  281  *  @brief   GPIO Read and Write
//  282  *
//  283 @verbatim   
//  284  ===============================================================================
//  285                               GPIO Read and Write
//  286  ===============================================================================  
//  287 
//  288 @endverbatim
//  289   * @{
//  290   */
//  291 
//  292 /**
//  293   * @brief  Reads the specified input port pin.
//  294   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  295   * @param  GPIO_Pin: specifies the port bit to read.
//  296   *         This parameter can be GPIO_Pin_x where x can be (0..15).
//  297   * @retval The input port pin value.
//  298   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function GPIO_ReadInputDataBit
        THUMB
//  299 uint8_t GPIO_ReadInputDataBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
//  300 {
//  301   uint8_t bitstatus = 0x00;
GPIO_ReadInputDataBit:
        MOVS     R2,#+0
//  302 
//  303   /* Check the parameters */
//  304   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  305   assert_param(IS_GET_GPIO_PIN(GPIO_Pin));
//  306 
//  307   if ((GPIOx->IDR & GPIO_Pin) != (uint32_t)Bit_RESET)
        LDR      R0,[R0, #+16]
        UXTH     R0,R0
        TST      R0,R1
        IT       NE 
        MOVNE    R2,#+1
//  308   {
//  309     bitstatus = (uint8_t)Bit_SET;
//  310   }
//  311   else
//  312   {
//  313     bitstatus = (uint8_t)Bit_RESET;
//  314   }
//  315   return bitstatus;
        MOV      R0,R2
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  316 }
//  317 
//  318 /**
//  319   * @brief  Reads the specified GPIO input data port.
//  320   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  321   * @retval GPIO input data port value.
//  322   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function GPIO_ReadInputData
        THUMB
//  323 uint16_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
//  324 {
//  325   /* Check the parameters */
//  326   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  327 
//  328   return ((uint16_t)GPIOx->IDR);
GPIO_ReadInputData:
        LDR      R0,[R0, #+16]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  329 }
//  330 
//  331 /**
//  332   * @brief  Reads the specified output data port bit.
//  333   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  334   * @param  GPIO_Pin: specifies the port bit to read.
//  335   *          This parameter can be GPIO_Pin_x where x can be (0..15).
//  336   * @retval The output port pin value.
//  337   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function GPIO_ReadOutputDataBit
        THUMB
//  338 uint8_t GPIO_ReadOutputDataBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
//  339 {
//  340   uint8_t bitstatus = 0x00;
GPIO_ReadOutputDataBit:
        MOVS     R2,#+0
//  341 
//  342   /* Check the parameters */
//  343   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  344   assert_param(IS_GET_GPIO_PIN(GPIO_Pin));
//  345 
//  346   if ((GPIOx->ODR & GPIO_Pin) != (uint32_t)Bit_RESET)
        LDR      R0,[R0, #+20]
        UXTH     R0,R0
        TST      R0,R1
        IT       NE 
        MOVNE    R2,#+1
//  347   {
//  348     bitstatus = (uint8_t)Bit_SET;
//  349   }
//  350   else
//  351   {
//  352     bitstatus = (uint8_t)Bit_RESET;
//  353   }
//  354   return bitstatus;
        MOV      R0,R2
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  355 }
//  356 
//  357 /**
//  358   * @brief  Reads the specified GPIO output data port.
//  359   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  360   * @retval GPIO output data port value.
//  361   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function GPIO_ReadOutputData
        THUMB
//  362 uint16_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
//  363 {
//  364   /* Check the parameters */
//  365   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  366 
//  367   return ((uint16_t)GPIOx->ODR);
GPIO_ReadOutputData:
        LDR      R0,[R0, #+20]
        UXTH     R0,R0
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  368 }
//  369 
//  370 /**
//  371   * @brief  Sets the selected data port bits.
//  372   * @note   This functions uses GPIOx_BSRR register to allow atomic read/modify 
//  373   *         accesses. In this way, there is no risk of an IRQ occurring between
//  374   *         the read and the modify access.
//  375   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  376   * @param  GPIO_Pin: specifies the port bits to be written.
//  377   *          This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
//  378   * @retval None
//  379   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function GPIO_SetBits
        THUMB
//  380 void GPIO_SetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
//  381 {
//  382   /* Check the parameters */
//  383   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  384   assert_param(IS_GPIO_PIN(GPIO_Pin));
//  385 
//  386   GPIOx->BSRRL = GPIO_Pin;
GPIO_SetBits:
        STRH     R1,[R0, #+24]
//  387 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  388 
//  389 /**
//  390   * @brief  Clears the selected data port bits.
//  391   * @note   This functions uses GPIOx_BSRR register to allow atomic read/modify 
//  392   *         accesses. In this way, there is no risk of an IRQ occurring between
//  393   *         the read and the modify access.
//  394   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  395   * @param  GPIO_Pin: specifies the port bits to be written.
//  396   *          This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
//  397   * @retval None
//  398   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function GPIO_ResetBits
        THUMB
//  399 void GPIO_ResetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
//  400 {
//  401   /* Check the parameters */
//  402   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  403   assert_param(IS_GPIO_PIN(GPIO_Pin));
//  404 
//  405   GPIOx->BSRRH = GPIO_Pin;
GPIO_ResetBits:
        STRH     R1,[R0, #+26]
//  406 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  407 
//  408 /**
//  409   * @brief  Sets or clears the selected data port bit.
//  410   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  411   * @param  GPIO_Pin: specifies the port bit to be written.
//  412   *          This parameter can be one of GPIO_Pin_x where x can be (0..15).
//  413   * @param  BitVal: specifies the value to be written to the selected bit.
//  414   *          This parameter can be one of the BitAction enum values:
//  415   *            @arg Bit_RESET: to clear the port pin
//  416   *            @arg Bit_SET: to set the port pin
//  417   * @retval None
//  418   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function GPIO_WriteBit
        THUMB
//  419 void GPIO_WriteBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin, BitAction BitVal)
//  420 {
//  421   /* Check the parameters */
//  422   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  423   assert_param(IS_GET_GPIO_PIN(GPIO_Pin));
//  424   assert_param(IS_GPIO_BIT_ACTION(BitVal));
//  425 
//  426   if (BitVal != Bit_RESET)
GPIO_WriteBit:
        CMP      R2,#+0
        ITE      NE 
        STRHNE   R1,[R0, #+24]
        STRHEQ   R1,[R0, #+26]
//  427   {
//  428     GPIOx->BSRRL = GPIO_Pin;
        BX       LR
        CFI EndBlock cfiBlock10
//  429   }
//  430   else
//  431   {
//  432     GPIOx->BSRRH = GPIO_Pin ;
//  433   }
//  434 }
//  435 
//  436 /**
//  437   * @brief  Writes data to the specified GPIO data port.
//  438   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  439   * @param  PortVal: specifies the value to be written to the port output data register.
//  440   * @retval None
//  441   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function GPIO_Write
        THUMB
//  442 void GPIO_Write(GPIO_TypeDef* GPIOx, uint16_t PortVal)
//  443 {
//  444   /* Check the parameters */
//  445   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  446 
//  447   GPIOx->ODR = PortVal;
GPIO_Write:
        STR      R1,[R0, #+20]
//  448 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  449 
//  450 /**
//  451   * @brief  Toggles the specified GPIO pins..
//  452   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  453   * @param  GPIO_Pin: Specifies the pins to be toggled.
//  454   * @retval None
//  455   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function GPIO_ToggleBits
        THUMB
//  456 void GPIO_ToggleBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
//  457 {
//  458   /* Check the parameters */
//  459   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  460 
//  461   GPIOx->ODR ^= GPIO_Pin;
GPIO_ToggleBits:
        LDR      R2,[R0, #+20]
        EORS     R1,R1,R2
        STR      R1,[R0, #+20]
//  462 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock12
//  463 
//  464 /**
//  465   * @}
//  466   */
//  467 
//  468 /** @defgroup GPIO_Group3 GPIO Alternate functions configuration function
//  469  *  @brief   GPIO Alternate functions configuration function
//  470  *
//  471 @verbatim   
//  472  ===============================================================================
//  473                GPIO Alternate functions configuration function
//  474  ===============================================================================  
//  475 
//  476 @endverbatim
//  477   * @{
//  478   */
//  479 
//  480 /**
//  481   * @brief  Changes the mapping of the specified pin.
//  482   * @param  GPIOx: where x can be (A..I) to select the GPIO peripheral.
//  483   * @param  GPIO_PinSource: specifies the pin for the Alternate function.
//  484   *         This parameter can be GPIO_PinSourcex where x can be (0..15).
//  485   * @param  GPIO_AFSelection: selects the pin to used as Alternate function.
//  486   *          This parameter can be one of the following values:
//  487   *            @arg GPIO_AF_RTC_50Hz: Connect RTC_50Hz pin to AF0 (default after reset) 
//  488   *            @arg GPIO_AF_MCO: Connect MCO pin (MCO1 and MCO2) to AF0 (default after reset) 
//  489   *            @arg GPIO_AF_TAMPER: Connect TAMPER pins (TAMPER_1 and TAMPER_2) to AF0 (default after reset) 
//  490   *            @arg GPIO_AF_SWJ: Connect SWJ pins (SWD and JTAG)to AF0 (default after reset) 
//  491   *            @arg GPIO_AF_TRACE: Connect TRACE pins to AF0 (default after reset)
//  492   *            @arg GPIO_AF_TIM1: Connect TIM1 pins to AF1
//  493   *            @arg GPIO_AF_TIM2: Connect TIM2 pins to AF1
//  494   *            @arg GPIO_AF_TIM3: Connect TIM3 pins to AF2
//  495   *            @arg GPIO_AF_TIM4: Connect TIM4 pins to AF2
//  496   *            @arg GPIO_AF_TIM5: Connect TIM5 pins to AF2
//  497   *            @arg GPIO_AF_TIM8: Connect TIM8 pins to AF3
//  498   *            @arg GPIO_AF_TIM9: Connect TIM9 pins to AF3
//  499   *            @arg GPIO_AF_TIM10: Connect TIM10 pins to AF3
//  500   *            @arg GPIO_AF_TIM11: Connect TIM11 pins to AF3
//  501   *            @arg GPIO_AF_I2C1: Connect I2C1 pins to AF4
//  502   *            @arg GPIO_AF_I2C2: Connect I2C2 pins to AF4
//  503   *            @arg GPIO_AF_I2C3: Connect I2C3 pins to AF4
//  504   *            @arg GPIO_AF_SPI1: Connect SPI1 pins to AF5
//  505   *            @arg GPIO_AF_SPI2: Connect SPI2/I2S2 pins to AF5
//  506   *            @arg GPIO_AF_SPI3: Connect SPI3/I2S3 pins to AF6
//  507   *            @arg GPIO_AF_USART1: Connect USART1 pins to AF7
//  508   *            @arg GPIO_AF_USART2: Connect USART2 pins to AF7
//  509   *            @arg GPIO_AF_USART3: Connect USART3 pins to AF7
//  510   *            @arg GPIO_AF_UART4: Connect UART4 pins to AF8
//  511   *            @arg GPIO_AF_UART5: Connect UART5 pins to AF8
//  512   *            @arg GPIO_AF_USART6: Connect USART6 pins to AF8
//  513   *            @arg GPIO_AF_CAN1: Connect CAN1 pins to AF9
//  514   *            @arg GPIO_AF_CAN2: Connect CAN2 pins to AF9
//  515   *            @arg GPIO_AF_TIM12: Connect TIM12 pins to AF9
//  516   *            @arg GPIO_AF_TIM13: Connect TIM13 pins to AF9
//  517   *            @arg GPIO_AF_TIM14: Connect TIM14 pins to AF9
//  518   *            @arg GPIO_AF_OTG_FS: Connect OTG_FS pins to AF10
//  519   *            @arg GPIO_AF_OTG_HS: Connect OTG_HS pins to AF10
//  520   *            @arg GPIO_AF_ETH: Connect ETHERNET pins to AF11
//  521   *            @arg GPIO_AF_FSMC: Connect FSMC pins to AF12
//  522   *            @arg GPIO_AF_OTG_HS_FS: Connect OTG HS (configured in FS) pins to AF12
//  523   *            @arg GPIO_AF_SDIO: Connect SDIO pins to AF12
//  524   *            @arg GPIO_AF_DCMI: Connect DCMI pins to AF13
//  525   *            @arg GPIO_AF_EVENTOUT: Connect EVENTOUT pins to AF15
//  526   * @retval None
//  527   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function GPIO_PinAFConfig
        THUMB
//  528 void GPIO_PinAFConfig(GPIO_TypeDef* GPIOx, uint16_t GPIO_PinSource, uint8_t GPIO_AF)
//  529 {
GPIO_PinAFConfig:
        ASRS     R3,R1,#+3
        ADD      R0,R0,R3, LSL #+2
        AND      R1,R1,#0x7
        LSLS     R1,R1,#+2
        LDR      R3,[R0, #+32]
        MOV      R12,#+15
        LSL      R12,R12,R1
        BIC      R3,R3,R12
        STR      R3,[R0, #+32]
//  530   uint32_t temp = 0x00;
//  531   uint32_t temp_2 = 0x00;
//  532   
//  533   /* Check the parameters */
//  534   assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
//  535   assert_param(IS_GPIO_PIN_SOURCE(GPIO_PinSource));
//  536   assert_param(IS_GPIO_AF(GPIO_AF));
//  537   
//  538   temp = ((uint32_t)(GPIO_AF) << ((uint32_t)((uint32_t)GPIO_PinSource & (uint32_t)0x07) * 4)) ;
//  539   GPIOx->AFR[GPIO_PinSource >> 0x03] &= ~((uint32_t)0xF << ((uint32_t)((uint32_t)GPIO_PinSource & (uint32_t)0x07) * 4)) ;
//  540   temp_2 = GPIOx->AFR[GPIO_PinSource >> 0x03] | temp;
        LDR      R3,[R0, #+32]
//  541   GPIOx->AFR[GPIO_PinSource >> 0x03] = temp_2;
        LSL      R1,R2,R1
        ORRS     R1,R1,R3
        STR      R1,[R0, #+32]
//  542 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock13
//  543 
//  544 

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function GPIOPortInit
        THUMB
//  545 void GPIOPortInit(uint16_t Reg, uint8_t GPIO_AF, GPIO_TypeDef* GPIOx, uint16_t Pin_Src)
//  546 {
GPIOPortInit:
        PUSH     {R4-R7}
        CFI R7 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOV      R4,R2
//  547 	union uReg {
//  548 		u16 Data;
//  549 		struct {
//  550 			u16 MODER		:2;
//  551 			u16 OTYPER		:2;
//  552 			u16 OSPEEDR		:2;
//  553 			u16 PUPDR		:2;
//  554 		};
//  555 	} tmp;
//  556 
//  557 	tmp.Data = Reg;
//  558 
//  559 	GPIOx->MODER   &= ~(0x03 << Pin_Src*2);
        LSLS     R2,R3,#+1
        MOVS     R5,#+3
        LSLS     R5,R5,R2
        MVNS     R5,R5
        LDR      R6,[R4, #+0]
        ANDS     R6,R5,R6
        STR      R6,[R4, #+0]
//  560 	GPIOx->MODER   |=  (tmp.MODER << (Pin_Src*2));
        LDR      R6,[R4, #+0]
        AND      R7,R0,#0x3
        LSLS     R7,R7,R2
        ORRS     R6,R7,R6
        STR      R6,[R4, #+0]
//  561 
//  562 	GPIOx->OTYPER  &= ~(0x01 << Pin_Src);
        LDR      R6,[R4, #+4]
        MOVS     R7,#+1
        LSLS     R7,R7,R3
        BICS     R6,R6,R7
        STR      R6,[R4, #+4]
//  563 	GPIOx->OTYPER  |=  (tmp.OTYPER << Pin_Src);
        LDR      R6,[R4, #+4]
        UBFX     R7,R0,#+2,#+2
        LSLS     R7,R7,R3
        ORRS     R6,R7,R6
        STR      R6,[R4, #+4]
//  564 
//  565 	GPIOx->OSPEEDR &= ~(0x03 << Pin_Src*2);
        LDR      R6,[R4, #+8]
        ANDS     R6,R5,R6
        STR      R6,[R4, #+8]
//  566 	GPIOx->OSPEEDR |=  (tmp.OSPEEDR << (Pin_Src*2));
        LDR      R6,[R4, #+8]
        UBFX     R7,R0,#+4,#+2
        LSLS     R7,R7,R2
        ORRS     R6,R7,R6
        STR      R6,[R4, #+8]
//  567 
//  568 	GPIOx->PUPDR   &= ~(0x03 << Pin_Src*2);
        LDR      R6,[R4, #+12]
        ANDS     R5,R5,R6
        STR      R5,[R4, #+12]
//  569 	GPIOx->PUPDR   |=  (tmp.PUPDR << (Pin_Src*2));
        LDR      R5,[R4, #+12]
        UBFX     R0,R0,#+6,#+2
        LSLS     R0,R0,R2
        ORRS     R0,R0,R5
        STR      R0,[R4, #+12]
//  570 
//  571 	GPIO_PinAFConfig(GPIOx, Pin_Src, GPIO_AF);
        MOV      R2,R1
        MOV      R1,R3
        MOV      R0,R4
        POP      {R4-R7}
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI CFA R13+0
        B.N      GPIO_PinAFConfig
        CFI EndBlock cfiBlock14
//  572 	
//  573 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  574 
//  575 
//  576 
//  577 
//  578 /**
//  579   * @}
//  580   */ 
//  581 
//  582 /**
//  583   * @}
//  584   */
//  585 
//  586 /**
//  587   * @}
//  588   */ 
//  589 
//  590 /**
//  591   * @}
//  592   */ 
//  593 
//  594 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
// 620 bytes in section .text
// 
// 620 bytes of CODE memory
//
//Errors: none
//Warnings: none
