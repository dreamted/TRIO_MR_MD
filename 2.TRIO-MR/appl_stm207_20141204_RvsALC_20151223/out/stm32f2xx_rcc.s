///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    29/Oct/2012  10:52:04 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_rcc.c                                 /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Dri /
//                    ver\src\stm32f2xx_rcc.c -D OS_INCLUDED -D APPL_SRC -lA  /
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
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\out\stm32f2xx_rcc /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f2xx_rcc

        RTMODEL "__SystemLibrary", "DLib"
        RTMODEL "__dlib_file_descriptor", "0"
        RTMODEL "__dlib_full_locale_support", "0"
        AAPCS BASE,INTERWORK
        PRESERVE8
        REQUIRE8

        #define SHT_PROGBITS 0x1

        PUBLIC RCC_AHB1PeriphClockCmd
        PUBLIC RCC_AHB1PeriphClockLPModeCmd
        PUBLIC RCC_AHB1PeriphResetCmd
        PUBLIC RCC_AHB2PeriphClockCmd
        PUBLIC RCC_AHB2PeriphClockLPModeCmd
        PUBLIC RCC_AHB2PeriphResetCmd
        PUBLIC RCC_AHB3PeriphClockCmd
        PUBLIC RCC_AHB3PeriphClockLPModeCmd
        PUBLIC RCC_AHB3PeriphResetCmd
        PUBLIC RCC_APB1PeriphClockCmd
        PUBLIC RCC_APB1PeriphClockLPModeCmd
        PUBLIC RCC_APB1PeriphResetCmd
        PUBLIC RCC_APB2PeriphClockCmd
        PUBLIC RCC_APB2PeriphClockLPModeCmd
        PUBLIC RCC_APB2PeriphResetCmd
        PUBLIC RCC_AdjustHSICalibrationValue
        PUBLIC RCC_BackupResetCmd
        PUBLIC RCC_ClearFlag
        PUBLIC RCC_ClearITPendingBit
        PUBLIC RCC_ClockSecuritySystemCmd
        PUBLIC RCC_DeInit
        PUBLIC RCC_GetClocksFreq
        PUBLIC RCC_GetFlagStatus
        PUBLIC RCC_GetITStatus
        PUBLIC RCC_GetSYSCLKSource
        PUBLIC RCC_HCLKConfig
        PUBLIC RCC_HSEConfig
        PUBLIC RCC_HSICmd
        PUBLIC RCC_I2SCLKConfig
        PUBLIC RCC_ITConfig
        PUBLIC RCC_LSEConfig
        PUBLIC RCC_LSICmd
        PUBLIC RCC_MCO1Config
        PUBLIC RCC_MCO2Config
        PUBLIC RCC_PCLK1Config
        PUBLIC RCC_PCLK2Config
        PUBLIC RCC_PLLCmd
        PUBLIC RCC_PLLConfig
        PUBLIC RCC_PLLI2SCmd
        PUBLIC RCC_PLLI2SConfig
        PUBLIC RCC_RTCCLKCmd
        PUBLIC RCC_RTCCLKConfig
        PUBLIC RCC_SYSCLKConfig
        PUBLIC RCC_WaitForHSEStartUp
        
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
        
// D:\Work\Project\2012\NL_INBUILD\STM32F2xx_StdPeriph_Driver\src\stm32f2xx_rcc.c
//    1 /**
//    2   ******************************************************************************
//    3   * @file    stm32f2xx_rcc.c
//    4   * @author  MCD Application Team
//    5   * @version V1.0.0
//    6   * @date    18-April-2011
//    7   * @brief   This file provides firmware functions to manage the following 
//    8   *          functionalities of the Reset and clock control (RCC) peripheral:           
//    9   *           - Internal/external clocks, PLL, CSS and MCO configuration
//   10   *           - System, AHB and APB busses clocks configuration
//   11   *           - Peripheral clocks configuration
//   12   *           - Interrupts and flags management
//   13   *
//   14   *  @verbatim
//   15   *               
//   16   *          ===================================================================
//   17   *                               RCC specific features
//   18   *          ===================================================================
//   19   *    
//   20   *          After reset the device is running from Internal High Speed oscillator 
//   21   *          (HSI 16MHz) with Flash 0 wait state, Flash prefetch buffer, D-Cache 
//   22   *          and I-Cache are disabled, and all peripherals are off except internal
//   23   *          SRAM, Flash and JTAG.
//   24   *           - There is no prescaler on High speed (AHB) and Low speed (APB) busses;
//   25   *             all peripherals mapped on these busses are running at HSI speed.
//   26   *       	  - The clock for all peripherals is switched off, except the SRAM and FLASH.
//   27   *           - All GPIOs are in input floating state, except the JTAG pins which
//   28   *             are assigned to be used for debug purpose.
//   29   *        
//   30   *          Once the device started from reset, the user application has to:        
//   31   *           - Configure the clock source to be used to drive the System clock
//   32   *             (if the application needs higher frequency/performance)
//   33   *           - Configure the System clock frequency and Flash settings  
//   34   *           - Configure the AHB and APB busses prescalers
//   35   *           - Enable the clock for the peripheral(s) to be used
//   36   *           - Configure the clock source(s) for peripherals which clocks are not
//   37   *             derived from the System clock (I2S, RTC, ADC, USB OTG FS/SDIO/RNG)      
//   38   *                        
//   39   *  @endverbatim
//   40   *    
//   41   ******************************************************************************
//   42   * @attention
//   43   *
//   44   * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//   45   * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
//   46   * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
//   47   * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
//   48   * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
//   49   * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   50   *
//   51   * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
//   52   ******************************************************************************
//   53   */
//   54 
//   55 /* Includes ------------------------------------------------------------------*/
//   56 #include "stm32f2xx_rcc_1208.h"
//   57 
//   58 /** @addtogroup STM32F2xx_StdPeriph_Driver
//   59   * @{
//   60   */
//   61 
//   62 /** @defgroup RCC 
//   63   * @brief RCC driver modules
//   64   * @{
//   65   */ 
//   66 
//   67 /* Private typedef -----------------------------------------------------------*/
//   68 /* Private define ------------------------------------------------------------*/
//   69 /* ------------ RCC registers bit address in the alias region ----------- */
//   70 #define RCC_OFFSET                (RCC_BASE - PERIPH_BASE)
//   71 /* --- CR Register ---*/
//   72 /* Alias word address of HSION bit */
//   73 #define CR_OFFSET                 (RCC_OFFSET + 0x00)
//   74 #define HSION_BitNumber           0x00
//   75 #define CR_HSION_BB               (PERIPH_BB_BASE + (CR_OFFSET * 32) + (HSION_BitNumber * 4))
//   76 /* Alias word address of CSSON bit */
//   77 #define CSSON_BitNumber           0x13
//   78 #define CR_CSSON_BB               (PERIPH_BB_BASE + (CR_OFFSET * 32) + (CSSON_BitNumber * 4))
//   79 /* Alias word address of PLLON bit */
//   80 #define PLLON_BitNumber           0x18
//   81 #define CR_PLLON_BB               (PERIPH_BB_BASE + (CR_OFFSET * 32) + (PLLON_BitNumber * 4))
//   82 /* Alias word address of PLLI2SON bit */
//   83 #define PLLI2SON_BitNumber        0x1A
//   84 #define CR_PLLI2SON_BB            (PERIPH_BB_BASE + (CR_OFFSET * 32) + (PLLI2SON_BitNumber * 4))
//   85 
//   86 /* --- CFGR Register ---*/
//   87 /* Alias word address of I2SSRC bit */
//   88 #define CFGR_OFFSET               (RCC_OFFSET + 0x08)
//   89 #define I2SSRC_BitNumber          0x17
//   90 #define CFGR_I2SSRC_BB            (PERIPH_BB_BASE + (CFGR_OFFSET * 32) + (I2SSRC_BitNumber * 4))
//   91 
//   92 /* --- BDCR Register ---*/
//   93 /* Alias word address of RTCEN bit */
//   94 #define BDCR_OFFSET               (RCC_OFFSET + 0x70)
//   95 #define RTCEN_BitNumber           0x0F
//   96 #define BDCR_RTCEN_BB             (PERIPH_BB_BASE + (BDCR_OFFSET * 32) + (RTCEN_BitNumber * 4))
//   97 /* Alias word address of BDRST bit */
//   98 #define BDRST_BitNumber           0x10
//   99 #define BDCR_BDRST_BB             (PERIPH_BB_BASE + (BDCR_OFFSET * 32) + (BDRST_BitNumber * 4))
//  100 /* --- CSR Register ---*/
//  101 /* Alias word address of LSION bit */
//  102 #define CSR_OFFSET                (RCC_OFFSET + 0x74)
//  103 #define LSION_BitNumber           0x00
//  104 #define CSR_LSION_BB              (PERIPH_BB_BASE + (CSR_OFFSET * 32) + (LSION_BitNumber * 4))
//  105 /* ---------------------- RCC registers bit mask ------------------------ */
//  106 /* CFGR register bit mask */
//  107 #define CFGR_MCO2_RESET_MASK      ((uint32_t)0x07FFFFFF)
//  108 #define CFGR_MCO1_RESET_MASK      ((uint32_t)0xF89FFFFF)
//  109 
//  110 /* RCC Flag Mask */
//  111 #define FLAG_MASK                 ((uint8_t)0x1F)
//  112 
//  113 /* CR register byte 3 (Bits[23:16]) base address */
//  114 #define CR_BYTE3_ADDRESS          ((uint32_t)0x40023802)
//  115 
//  116 /* CIR register byte 2 (Bits[15:8]) base address */
//  117 #define CIR_BYTE2_ADDRESS         ((uint32_t)(RCC_BASE + 0x0C + 0x01))
//  118 
//  119 /* CIR register byte 3 (Bits[23:16]) base address */
//  120 #define CIR_BYTE3_ADDRESS         ((uint32_t)(RCC_BASE + 0x0C + 0x02))
//  121 
//  122 /* BDCR register base address */
//  123 #define BDCR_ADDRESS              (PERIPH_BASE + BDCR_OFFSET)
//  124 
//  125 /* Private macro -------------------------------------------------------------*/
//  126 /* Private variables ---------------------------------------------------------*/

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//  127 static __I uint8_t APBAHBPrescTable[16] = {0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9};
APBAHBPrescTable:
        DATA
        DC8 0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9
//  128 
//  129 /* Private function prototypes -----------------------------------------------*/
//  130 /* Private functions ---------------------------------------------------------*/
//  131 
//  132 /** @defgroup RCC_Private_Functions
//  133   * @{
//  134   */ 
//  135 
//  136 /** @defgroup RCC_Group1 Internal and external clocks, PLL, CSS and MCO configuration functions
//  137  *  @brief   Internal and external clocks, PLL, CSS and MCO configuration functions 
//  138  *
//  139 @verbatim   
//  140  ===============================================================================
//  141       Internal/external clocks, PLL, CSS and MCO configuration functions
//  142  ===============================================================================  
//  143 
//  144   This section provide functions allowing to configure the internal/external clocks,
//  145   PLLs, CSS and MCO pins.
//  146   
//  147   1. HSI (high-speed internal), 16 MHz factory-trimmed RC used directly or through
//  148      the PLL as System clock source.
//  149 
//  150   2. LSI (low-speed internal), 32 KHz low consumption RC used as IWDG and/or RTC
//  151      clock source.
//  152 
//  153   3. HSE (high-speed external), 4 to 26 MHz crystal oscillator used directly or
//  154      through the PLL as System clock source. Can be used also as RTC clock source.
//  155 
//  156   4. LSE (low-speed external), 32 KHz oscillator used as RTC clock source.   
//  157 
//  158   5. PLL (clocked by HSI or HSE), featuring two different output clocks:
//  159       - The first output is used to generate the high speed system clock (up to 120 MHz)
//  160       - The second output is used to generate the clock for the USB OTG FS (48 MHz),
//  161         the random analog generator (<=48 MHz) and the SDIO (<= 48 MHz).
//  162 
//  163   6. PLLI2S (clocked by HSI or HSE), used to generate an accurate clock to achieve 
//  164      high-quality audio performance on the I2S interface.
//  165   
//  166   7. CSS (Clock security system), once enable and if a HSE clock failure occurs 
//  167      (HSE used directly or through PLL as System clock source), the System clock
//  168      is automatically switched to HSI and an interrupt is generated if enabled. 
//  169      The interrupt is linked to the Cortex-M3 NMI (Non-Maskable Interrupt) 
//  170      exception vector.   
//  171 
//  172   8. MCO1 (microcontroller clock output), used to output HSI, LSE, HSE or PLL
//  173      clock (through a configurable prescaler) on PA8 pin.
//  174 
//  175   9. MCO2 (microcontroller clock output), used to output HSE, PLL, SYSCLK or PLLI2S
//  176      clock (through a configurable prescaler) on PC9 pin.
//  177 
//  178 @endverbatim
//  179   * @{
//  180   */
//  181 
//  182 /**
//  183   * @brief  Resets the RCC clock configuration to the default reset state.
//  184   * @note   The default reset state of the clock configuration is given below:
//  185   *            - HSI ON and used as system clock source
//  186   *            - HSE, PLL and PLLI2S OFF
//  187   *            - AHB, APB1 and APB2 prescaler set to 1.
//  188   *            - CSS, MCO1 and MCO2 OFF
//  189   *            - All interrupts disabled
//  190   * @note   This function doesn't modify the configuration of the
//  191   *            - Peripheral clocks
//  192   *            - LSI, LSE and RTC clocks 
//  193   * @param  None
//  194   * @retval None
//  195   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function RCC_DeInit
        THUMB
//  196 void RCC_DeInit(void)
//  197 {
//  198   /* Set HSION bit */
//  199   RCC->CR |= (uint32_t)0x00000001;
RCC_DeInit:
        LDR.W    R0,??DataTable39  ;; 0x40023800
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//  200 
//  201   /* Reset CFGR register */
//  202   RCC->CFGR = 0x00000000;
        MOVS     R1,#+0
        STR      R1,[R0, #+8]
//  203 
//  204   /* Reset HSEON, CSSON and PLLON bits */
//  205   RCC->CR &= (uint32_t)0xFEF6FFFF;
        LDR      R1,[R0, #+0]
        LDR.N    R2,??DataTable39_1  ;; 0xfef6ffff
        ANDS     R1,R2,R1
        STR      R1,[R0, #+0]
//  206 
//  207   /* Reset PLLCFGR register */
//  208   RCC->PLLCFGR = 0x24003010;
        LDR.N    R1,??DataTable39_2  ;; 0x24003010
        STR      R1,[R0, #+4]
//  209 
//  210   /* Reset HSEBYP bit */
//  211   RCC->CR &= (uint32_t)0xFFFBFFFF;
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x40000
        STR      R1,[R0, #+0]
//  212 
//  213   /* Disable all interrupts */
//  214   RCC->CIR = 0x00000000;
        MOVS     R1,#+0
        STR      R1,[R0, #+12]
//  215 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//  216 
//  217 /**
//  218   * @brief  Configures the External High Speed oscillator (HSE).
//  219   * @note   After enabling the HSE (RCC_HSE_ON or RCC_HSE_Bypass), the application
//  220   *         software should wait on HSERDY flag to be set indicating that HSE clock
//  221   *         is stable and can be used to clock the PLL and/or system clock.
//  222   * @note   HSE state can not be changed if it is used directly or through the
//  223   *         PLL as system clock. In this case, you have to select another source
//  224   *         of the system clock then change the HSE state (ex. disable it).
//  225   * @note   The HSE is stopped by hardware when entering STOP and STANDBY modes.  
//  226   * @note   This function reset the CSSON bit, so if the Clock security system(CSS)
//  227   *         was previously enabled you have to enable it again after calling this
//  228   *         function.    
//  229   * @param  RCC_HSE: specifies the new state of the HSE.
//  230   *          This parameter can be one of the following values:
//  231   *            @arg RCC_HSE_OFF: turn OFF the HSE oscillator, HSERDY flag goes low after
//  232   *                              6 HSE oscillator clock cycles.
//  233   *            @arg RCC_HSE_ON: turn ON the HSE oscillator
//  234   *            @arg RCC_HSE_Bypass: HSE oscillator bypassed with external clock
//  235   * @retval None
//  236   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function RCC_HSEConfig
        THUMB
//  237 void RCC_HSEConfig(uint8_t RCC_HSE)
//  238 {
//  239   /* Check the parameters */
//  240   assert_param(IS_RCC_HSE(RCC_HSE));
//  241 
//  242   /* Reset HSEON and HSEBYP bits before configuring the HSE ------------------*/
//  243   *(__IO uint8_t *) CR_BYTE3_ADDRESS = RCC_HSE_OFF;
RCC_HSEConfig:
        LDR.N    R1,??DataTable39_3  ;; 0x40023802
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
//  244 
//  245   /* Set the new HSE configuration -------------------------------------------*/
//  246   *(__IO uint8_t *) CR_BYTE3_ADDRESS = RCC_HSE;
        STRB     R0,[R1, #+0]
//  247 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  248 
//  249 /**
//  250   * @brief  Waits for HSE start-up.
//  251   * @note   This functions waits on HSERDY flag to be set and return SUCCESS if 
//  252   *         this flag is set, otherwise returns ERROR if the timeout is reached 
//  253   *         and this flag is not set. The timeout value is defined by the constant
//  254   *         HSE_STARTUP_TIMEOUT in stm32f2xx.h file. You can tailor it depending
//  255   *         on the HSE crystal used in your application. 
//  256   * @param  None
//  257   * @retval An ErrorStatus enumeration value:
//  258   *          - SUCCESS: HSE oscillator is stable and ready to use
//  259   *          - ERROR: HSE oscillator not yet ready
//  260   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function RCC_WaitForHSEStartUp
        THUMB
//  261 ErrorStatus RCC_WaitForHSEStartUp(void)
//  262 {
RCC_WaitForHSEStartUp:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
//  263   __IO uint32_t startupcounter = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  264   ErrorStatus status = ERROR;
        MOVS     R4,#+0
//  265   FlagStatus hsestatus = RESET;
//  266   /* Wait till HSE is ready and if Time out is reached exit */
//  267   do
//  268   {
//  269     hsestatus = RCC_GetFlagStatus(RCC_FLAG_HSERDY);
??RCC_WaitForHSEStartUp_0:
        MOVS     R0,#+49
        BL       RCC_GetFlagStatus
//  270     startupcounter++;
        LDR      R1,[SP, #+0]
        ADDS     R1,R1,#+1
        STR      R1,[SP, #+0]
//  271   } while((startupcounter != HSE_STARTUP_TIMEOUT) && (hsestatus == RESET));
        LDR      R1,[SP, #+0]
        CMP      R1,#+1280
        BEQ.N    ??RCC_WaitForHSEStartUp_1
        CMP      R0,#+0
        BEQ.N    ??RCC_WaitForHSEStartUp_0
//  272 
//  273   if (RCC_GetFlagStatus(RCC_FLAG_HSERDY) != RESET)
??RCC_WaitForHSEStartUp_1:
        MOVS     R0,#+49
        BL       RCC_GetFlagStatus
        CBZ.N    R0,??RCC_WaitForHSEStartUp_2
//  274   {
//  275     status = SUCCESS;
        MOVS     R4,#+1
//  276   }
//  277   else
//  278   {
//  279     status = ERROR;
//  280   }
//  281   return (status);
??RCC_WaitForHSEStartUp_2:
        MOV      R0,R4
        POP      {R1,R2,R4,PC}    ;; return
        CFI EndBlock cfiBlock2
//  282 }
//  283 
//  284 /**
//  285   * @brief  Adjusts the Internal High Speed oscillator (HSI) calibration value.
//  286   * @note   The calibration is used to compensate for the variations in voltage
//  287   *         and temperature that influence the frequency of the internal HSI RC.
//  288   * @param  HSICalibrationValue: specifies the calibration trimming value.
//  289   *         This parameter must be a number between 0 and 0x1F.
//  290   * @retval None
//  291   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function RCC_AdjustHSICalibrationValue
        THUMB
//  292 void RCC_AdjustHSICalibrationValue(uint8_t HSICalibrationValue)
//  293 {
//  294   uint32_t tmpreg = 0;
//  295   /* Check the parameters */
//  296   assert_param(IS_RCC_CALIBRATION_VALUE(HSICalibrationValue));
//  297 
//  298   tmpreg = RCC->CR;
RCC_AdjustHSICalibrationValue:
        LDR.N    R1,??DataTable39  ;; 0x40023800
        LDR      R2,[R1, #+0]
//  299 
//  300   /* Clear HSITRIM[4:0] bits */
//  301   tmpreg &= ~RCC_CR_HSITRIM;
//  302 
//  303   /* Set the HSITRIM[4:0] bits according to HSICalibrationValue value */
//  304   tmpreg |= (uint32_t)HSICalibrationValue << 3;
//  305 
//  306   /* Store the new value */
//  307   RCC->CR = tmpreg;
        BIC      R2,R2,#0xF8
        B.N      ?Subroutine0
        CFI EndBlock cfiBlock3
//  308 }
//  309 
//  310 /**
//  311   * @brief  Enables or disables the Internal High Speed oscillator (HSI).
//  312   * @note   The HSI is stopped by hardware when entering STOP and STANDBY modes.
//  313   *         It is used (enabled by hardware) as system clock source after startup
//  314   *         from Reset, wakeup from STOP and STANDBY mode, or in case of failure
//  315   *         of the HSE used directly or indirectly as system clock (if the Clock
//  316   *         Security System CSS is enabled).             
//  317   * @note   HSI can not be stopped if it is used as system clock source. In this case,
//  318   *         you have to select another source of the system clock then stop the HSI.  
//  319   * @note   After enabling the HSI, the application software should wait on HSIRDY
//  320   *         flag to be set indicating that HSI clock is stable and can be used as
//  321   *         system clock source.  
//  322   * @param  NewState: new state of the HSI.
//  323   *          This parameter can be: ENABLE or DISABLE.
//  324   * @note   When the HSI is stopped, HSIRDY flag goes low after 6 HSI oscillator
//  325   *         clock cycles.  
//  326   * @retval None
//  327   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function RCC_HSICmd
        THUMB
//  328 void RCC_HSICmd(FunctionalState NewState)
//  329 {
//  330   /* Check the parameters */
//  331   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  332 
//  333   *(__IO uint32_t *) CR_HSION_BB = (uint32_t)NewState;
RCC_HSICmd:
        LDR.N    R1,??DataTable39_4  ;; 0x42470000
        STR      R0,[R1, #+0]
//  334 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4
//  335 
//  336 /**
//  337   * @brief  Configures the External Low Speed oscillator (LSE).
//  338   * @note   As the LSE is in the Backup domain and write access is denied to
//  339   *         this domain after reset, you have to enable write access using 
//  340   *         PWR_BackupAccessCmd(ENABLE) function before to configure the LSE
//  341   *         (to be done once after reset).  
//  342   * @note   After enabling the LSE (RCC_LSE_ON or RCC_LSE_Bypass), the application
//  343   *         software should wait on LSERDY flag to be set indicating that LSE clock
//  344   *         is stable and can be used to clock the RTC.
//  345   * @param  RCC_LSE: specifies the new state of the LSE.
//  346   *          This parameter can be one of the following values:
//  347   *            @arg RCC_LSE_OFF: turn OFF the LSE oscillator, LSERDY flag goes low after
//  348   *                              6 LSE oscillator clock cycles.
//  349   *            @arg RCC_LSE_ON: turn ON the LSE oscillator
//  350   *            @arg RCC_LSE_Bypass: LSE oscillator bypassed with external clock
//  351   * @retval None
//  352   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function RCC_LSEConfig
        THUMB
//  353 void RCC_LSEConfig(uint8_t RCC_LSE)
//  354 {
//  355   /* Check the parameters */
//  356   assert_param(IS_RCC_LSE(RCC_LSE));
//  357 
//  358   /* Reset LSEON and LSEBYP bits before configuring the LSE ------------------*/
//  359   /* Reset LSEON bit */
//  360   *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_OFF;
RCC_LSEConfig:
        LDR.N    R1,??DataTable39_5  ;; 0x40023870
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
//  361 
//  362   /* Reset LSEBYP bit */
//  363   *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_OFF;
        STRB     R2,[R1, #+0]
//  364 
//  365   /* Configure LSE (RCC_LSE_OFF is already covered by the code section above) */
//  366   switch (RCC_LSE)
        CMP      R0,#+1
        BEQ.N    ??RCC_LSEConfig_0
        CMP      R0,#+4
        BNE.N    ??RCC_LSEConfig_1
//  367   {
//  368     case RCC_LSE_ON:
//  369       /* Set LSEON bit */
//  370       *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_ON;
//  371       break;
//  372     case RCC_LSE_Bypass:
//  373       /* Set LSEBYP and LSEON bits */
//  374       *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_Bypass | RCC_LSE_ON;
        MOVS     R0,#+5
??RCC_LSEConfig_0:
        STRB     R0,[R1, #+0]
//  375       break;
//  376     default:
//  377       break;
//  378   }
//  379 }
??RCC_LSEConfig_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  380 
//  381 /**
//  382   * @brief  Enables or disables the Internal Low Speed oscillator (LSI).
//  383   * @note   After enabling the LSI, the application software should wait on 
//  384   *         LSIRDY flag to be set indicating that LSI clock is stable and can
//  385   *         be used to clock the IWDG and/or the RTC.
//  386   * @note   LSI can not be disabled if the IWDG is running.  
//  387   * @param  NewState: new state of the LSI.
//  388   *          This parameter can be: ENABLE or DISABLE.
//  389   * @note   When the LSI is stopped, LSIRDY flag goes low after 6 LSI oscillator
//  390   *         clock cycles. 
//  391   * @retval None
//  392   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function RCC_LSICmd
        THUMB
//  393 void RCC_LSICmd(FunctionalState NewState)
//  394 {
//  395   /* Check the parameters */
//  396   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  397 
//  398   *(__IO uint32_t *) CSR_LSION_BB = (uint32_t)NewState;
RCC_LSICmd:
        LDR.N    R1,??DataTable39_6  ;; 0x42470e80
        STR      R0,[R1, #+0]
//  399 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  400 
//  401 /**
//  402   * @brief  Configures the main PLL clock source, multiplication and division factors.
//  403   * @note   This function must be used only when the main PLL is disabled.
//  404   *  
//  405   * @param  RCC_PLLSource: specifies the PLL entry clock source.
//  406   *          This parameter can be one of the following values:
//  407   *            @arg RCC_PLLSource_HSI: HSI oscillator clock selected as PLL clock entry
//  408   *            @arg RCC_PLLSource_HSE: HSE oscillator clock selected as PLL clock entry
//  409   * @note   This clock source (RCC_PLLSource) is common for the main PLL and PLLI2S.  
//  410   *  
//  411   * @param  PLLM: specifies the division factor for PLL VCO input clock
//  412   *          This parameter must be a number between 0 and 63.
//  413   * @note   You have to set the PLLM parameter correctly to ensure that the VCO input
//  414   *         frequency ranges from 1 to 2 MHz. It is recommended to select a frequency
//  415   *         of 2 MHz to limit PLL jitter.
//  416   *  
//  417   * @param  PLLN: specifies the multiplication factor for PLL VCO output clock
//  418   *          This parameter must be a number between 192 and 432.
//  419   * @note   You have to set the PLLN parameter correctly to ensure that the VCO
//  420   *         output frequency is between 192 and 432 MHz.
//  421   *   
//  422   * @param  PLLP: specifies the division factor for main system clock (SYSCLK)
//  423   *          This parameter must be a number in the range {2, 4, 6, or 8}.
//  424   * @note   You have to set the PLLP parameter correctly to not exceed 120 MHz on
//  425   *         the System clock frequency.
//  426   *  
//  427   * @param  PLLQ: specifies the division factor for OTG FS, SDIO and RNG clocks
//  428   *          This parameter must be a number between 4 and 15.
//  429   * @note   If the USB OTG FS is used in your application, you have to set the
//  430   *         PLLQ parameter correctly to have 48 MHz clock for the USB. However,
//  431   *         the SDIO and RNG need a frequency lower than or equal to 48 MHz to work
//  432   *         correctly.
//  433   *   
//  434   * @retval None
//  435   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function RCC_PLLConfig
        THUMB
//  436 void RCC_PLLConfig(uint32_t RCC_PLLSource, uint32_t PLLM, uint32_t PLLN, uint32_t PLLP, uint32_t PLLQ)
//  437 {
RCC_PLLConfig:
        SUB      SP,SP,#+4
        CFI CFA R13+4
        LDR      R12,[SP, #+4]
//  438   /* Check the parameters */
//  439   assert_param(IS_RCC_PLL_SOURCE(RCC_PLLSource));
//  440   assert_param(IS_RCC_PLLM_VALUE(PLLM));
//  441   assert_param(IS_RCC_PLLN_VALUE(PLLN));
//  442   assert_param(IS_RCC_PLLP_VALUE(PLLP));
//  443   assert_param(IS_RCC_PLLQ_VALUE(PLLQ));
//  444 
//  445   RCC->PLLCFGR = PLLM | (PLLN << 6) | (((PLLP >> 1) -1) << 16) | (RCC_PLLSource) |
//  446                  (PLLQ << 24);
        SUBS     R3,R3,#+2
        LSLS     R3,R3,#+15
        LSRS     R3,R3,#+16
        ORR      R1,R1,R2, LSL #+6
        ORR      R1,R1,R12, LSL #+24
        ORRS     R0,R0,R1
        ORRS     R0,R0,R3, LSL #+16
        LDR.N    R1,??DataTable39_7  ;; 0x40023804
        STR      R0,[R1, #+0]
//  447 }
        ADD      SP,SP,#+4
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  448 
//  449 /**
//  450   * @brief  Enables or disables the main PLL.
//  451   * @note   After enabling the main PLL, the application software should wait on 
//  452   *         PLLRDY flag to be set indicating that PLL clock is stable and can
//  453   *         be used as system clock source.
//  454   * @note   The main PLL can not be disabled if it is used as system clock source
//  455   * @note   The main PLL is disabled by hardware when entering STOP and STANDBY modes.
//  456   * @param  NewState: new state of the main PLL. This parameter can be: ENABLE or DISABLE.
//  457   * @retval None
//  458   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function RCC_PLLCmd
        THUMB
//  459 void RCC_PLLCmd(FunctionalState NewState)
//  460 {
//  461   /* Check the parameters */
//  462   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  463   *(__IO uint32_t *) CR_PLLON_BB = (uint32_t)NewState;
RCC_PLLCmd:
        LDR.N    R1,??DataTable39_8  ;; 0x42470060
        STR      R0,[R1, #+0]
//  464 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  465 
//  466 /**
//  467   * @brief  Configures the PLLI2S clock multiplication and division factors.
//  468   *   
//  469   * @note   PLLI2S is available only in Silicon RevisionB and RevisionY.    
//  470   * @note   This function must be used only when the PLLI2S is disabled.
//  471   * @note   PLLI2S clock source is common with the main PLL (configured in 
//  472   *         RCC_PLLConfig function )  
//  473   *             
//  474   * @param  PLLI2SN: specifies the multiplication factor for PLLI2S VCO output clock
//  475   *          This parameter must be a number between 192 and 432.
//  476   * @note   You have to set the PLLI2SN parameter correctly to ensure that the VCO 
//  477   *         output frequency is between 192 and 432 MHz.
//  478   *    
//  479   * @param  PLLI2SR: specifies the division factor for I2S clock
//  480   *          This parameter must be a number between 2 and 7.
//  481   * @note   You have to set the PLLI2SR parameter correctly to not exceed 192 MHz
//  482   *         on the I2S clock frequency.
//  483   *   
//  484   * @retval None
//  485   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function RCC_PLLI2SConfig
        THUMB
//  486 void RCC_PLLI2SConfig(uint32_t PLLI2SN, uint32_t PLLI2SR)
//  487 {
//  488   /* Check the parameters */
//  489   assert_param(IS_RCC_PLLI2SN_VALUE(PLLI2SN));
//  490   assert_param(IS_RCC_PLLI2SR_VALUE(PLLI2SR));
//  491 
//  492   RCC->PLLI2SCFGR = (PLLI2SN << 6) | (PLLI2SR << 28);
RCC_PLLI2SConfig:
        LSLS     R1,R1,#+28
        ORR      R0,R1,R0, LSL #+6
        LDR.N    R1,??DataTable39_9  ;; 0x40023884
        STR      R0,[R1, #+0]
//  493 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  494 
//  495 /**
//  496   * @brief  Enables or disables the PLLI2S.
//  497   * @note   PLLI2S is available only in RevisionB and RevisionY 
//  498   * @note   The PLLI2S is disabled by hardware when entering STOP and STANDBY modes.  
//  499   * @param  NewState: new state of the PLLI2S. This parameter can be: ENABLE or DISABLE.
//  500   * @retval None
//  501   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function RCC_PLLI2SCmd
        THUMB
//  502 void RCC_PLLI2SCmd(FunctionalState NewState)
//  503 {
//  504   /* Check the parameters */
//  505   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  506   *(__IO uint32_t *) CR_PLLI2SON_BB = (uint32_t)NewState;
RCC_PLLI2SCmd:
        LDR.N    R1,??DataTable39_10  ;; 0x42470068
        STR      R0,[R1, #+0]
//  507 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  508 
//  509 /**
//  510   * @brief  Enables or disables the Clock Security System.
//  511   * @note   If a failure is detected on the HSE oscillator clock, this oscillator
//  512   *         is automatically disabled and an interrupt is generated to inform the
//  513   *         software about the failure (Clock Security System Interrupt, CSSI),
//  514   *         allowing the MCU to perform rescue operations. The CSSI is linked to 
//  515   *         the Cortex-M3 NMI (Non-Maskable Interrupt) exception vector.  
//  516   * @param  NewState: new state of the Clock Security System.
//  517   *         This parameter can be: ENABLE or DISABLE.
//  518   * @retval None
//  519   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function RCC_ClockSecuritySystemCmd
        THUMB
//  520 void RCC_ClockSecuritySystemCmd(FunctionalState NewState)
//  521 {
//  522   /* Check the parameters */
//  523   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  524   *(__IO uint32_t *) CR_CSSON_BB = (uint32_t)NewState;
RCC_ClockSecuritySystemCmd:
        LDR.N    R1,??DataTable39_11  ;; 0x4247004c
        STR      R0,[R1, #+0]
//  525 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  526 
//  527 /**
//  528   * @brief  Selects the clock source to output on MCO1 pin(PA8).
//  529   * @note   PA8 should be configured in alternate function mode.
//  530   * @param  RCC_MCO1Source: specifies the clock source to output.
//  531   *          This parameter can be one of the following values:
//  532   *            @arg RCC_MCO1Source_HSI: HSI clock selected as MCO1 source
//  533   *            @arg RCC_MCO1Source_LSE: LSE clock selected as MCO1 source
//  534   *            @arg RCC_MCO1Source_HSE: HSE clock selected as MCO1 source
//  535   *            @arg RCC_MCO1Source_PLLCLK: main PLL clock selected as MCO1 source
//  536   * @param  RCC_MCO1Div: specifies the MCO1 prescaler.
//  537   *          This parameter can be one of the following values:
//  538   *            @arg RCC_MCO1Div_1: no division applied to MCO1 clock
//  539   *            @arg RCC_MCO1Div_2: division by 2 applied to MCO1 clock
//  540   *            @arg RCC_MCO1Div_3: division by 3 applied to MCO1 clock
//  541   *            @arg RCC_MCO1Div_4: division by 4 applied to MCO1 clock
//  542   *            @arg RCC_MCO1Div_5: division by 5 applied to MCO1 clock
//  543   * @retval None
//  544   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function RCC_MCO1Config
        THUMB
//  545 void RCC_MCO1Config(uint32_t RCC_MCO1Source, uint32_t RCC_MCO1Div)
//  546 {
//  547   uint32_t tmpreg = 0;
//  548   
//  549   /* Check the parameters */
//  550   assert_param(IS_RCC_MCO1SOURCE(RCC_MCO1Source));
//  551   assert_param(IS_RCC_MCO1DIV(RCC_MCO1Div));  
//  552 
//  553   tmpreg = RCC->CFGR;
RCC_MCO1Config:
        LDR.N    R2,??DataTable39_12  ;; 0x40023808
        LDR      R3,[R2, #+0]
//  554 
//  555   /* Clear MCO1[1:0] and MCO1PRE[2:0] bits */
//  556   tmpreg &= CFGR_MCO1_RESET_MASK;
//  557 
//  558   /* Select MCO1 clock source and prescaler */
//  559   tmpreg |= RCC_MCO1Source | RCC_MCO1Div;
//  560 
//  561   /* Store the new value */
//  562   RCC->CFGR = tmpreg;  
        BIC      R3,R3,#0x7600000
        ORRS     R0,R0,R3
        B.N      ?Subroutine1
        CFI EndBlock cfiBlock12
//  563 }
//  564 
//  565 /**
//  566   * @brief  Selects the clock source to output on MCO2 pin(PC9).
//  567   * @note   PC9 should be configured in alternate function mode.
//  568   * @param  RCC_MCO2Source: specifies the clock source to output.
//  569   *          This parameter can be one of the following values:
//  570   *            @arg RCC_MCO2Source_SYSCLK: System clock (SYSCLK) selected as MCO2 source
//  571   *            @arg RCC_MCO2Source_PLLI2SCLK: PLLI2S clock selected as MCO2 source
//  572   *            @arg RCC_MCO2Source_HSE: HSE clock selected as MCO2 source
//  573   *            @arg RCC_MCO2Source_PLLCLK: main PLL clock selected as MCO2 source
//  574   * @param  RCC_MCO2Div: specifies the MCO2 prescaler.
//  575   *          This parameter can be one of the following values:
//  576   *            @arg RCC_MCO2Div_1: no division applied to MCO2 clock
//  577   *            @arg RCC_MCO2Div_2: division by 2 applied to MCO2 clock
//  578   *            @arg RCC_MCO2Div_3: division by 3 applied to MCO2 clock
//  579   *            @arg RCC_MCO2Div_4: division by 4 applied to MCO2 clock
//  580   *            @arg RCC_MCO2Div_5: division by 5 applied to MCO2 clock
//  581   * @retval None
//  582   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function RCC_MCO2Config
        THUMB
//  583 void RCC_MCO2Config(uint32_t RCC_MCO2Source, uint32_t RCC_MCO2Div)
//  584 {
//  585   uint32_t tmpreg = 0;
//  586   
//  587   /* Check the parameters */
//  588   assert_param(IS_RCC_MCO2SOURCE(RCC_MCO2Source));
//  589   assert_param(IS_RCC_MCO2DIV(RCC_MCO2Div));
//  590   
//  591   tmpreg = RCC->CFGR;
RCC_MCO2Config:
        LDR.N    R2,??DataTable39_12  ;; 0x40023808
        LDR      R3,[R2, #+0]
//  592   
//  593   /* Clear MCO2 and MCO2PRE[2:0] bits */
//  594   tmpreg &= CFGR_MCO2_RESET_MASK;
//  595 
//  596   /* Select MCO2 clock source and prescaler */
//  597   tmpreg |= RCC_MCO2Source | RCC_MCO2Div;
//  598 
//  599   /* Store the new value */
//  600   RCC->CFGR = tmpreg;  
        LSLS     R3,R3,#+5
        ORRS     R0,R0,R3, LSR #+5
        CFI EndBlock cfiBlock13
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  601 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine1:
        ORRS     R0,R1,R0
        STR      R0,[R2, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  602 
//  603 /**
//  604   * @}
//  605   */
//  606 
//  607 /** @defgroup RCC_Group2 System AHB and APB busses clocks configuration functions
//  608  *  @brief   System, AHB and APB busses clocks configuration functions
//  609  *
//  610 @verbatim   
//  611  ===============================================================================
//  612              System, AHB and APB busses clocks configuration functions
//  613  ===============================================================================  
//  614 
//  615   This section provide functions allowing to configure the System, AHB, APB1 and 
//  616   APB2 busses clocks.
//  617   
//  618   1. Several clock sources can be used to drive the System clock (SYSCLK): HSI,
//  619      HSE and PLL.
//  620      The AHB clock (HCLK) is derived from System clock through configurable prescaler
//  621      and used to clock the CPU, memory and peripherals mapped on AHB bus (DMA, GPIO...).
//  622      APB1 (PCLK1) and APB2 (PCLK2) clocks are derived from AHB clock through 
//  623      configurable prescalers and used to clock the peripherals mapped on these busses.
//  624      You can use "RCC_GetClocksFreq()" function to retrieve the frequencies of these clocks.  
//  625 
//  626 @note All the peripheral clocks are derived from the System clock (SYSCLK) except:
//  627        - I2S: the I2S clock can be derived either from a specific PLL (PLLI2S) or
//  628           from an external clock mapped on the I2S_CKIN pin. 
//  629           You have to use RCC_I2SCLKConfig() function to configure this clock. 
//  630        - RTC: the RTC clock can be derived either from the LSI, LSE or HSE clock
//  631           divided by 2 to 31. You have to use RCC_RTCCLKConfig() and RCC_RTCCLKCmd()
//  632           functions to configure this clock. 
//  633        - USB OTG FS, SDIO and RTC: USB OTG FS require a frequency equal to 48 MHz
//  634           to work correctly, while the SDIO require a frequency equal or lower than
//  635           to 48. This clock is derived of the main PLL through PLLQ divider.
//  636        - IWDG clock which is always the LSI clock.
//  637        
//  638   2. The maximum frequency of the SYSCLK and HCLK is 120 MHz, PCLK2 60 MHz and PCLK1 30 MHz.
//  639      Depending on the device voltage range, the maximum frequency should be 
//  640      adapted accordingly:
//  641  +-------------------------------------------------------------------------------------+     
//  642  | Latency       |                HCLK clock frequency (MHz)                           |
//  643  |               |---------------------------------------------------------------------|     
//  644  |               | voltage range  | voltage range  | voltage range   | voltage range   |
//  645  |               | 2.7 V - 3.6 V  | 2.4 V - 2.7 V  | 2.1 V - 2.4 V   | 1.8 V - 2.1 V   |
//  646  |---------------|----------------|----------------|-----------------|-----------------|              
//  647  |0WS(1CPU cycle)|0 < HCLK <= 30  |0 < HCLK <= 24  |0 < HCLK <= 18   |0 < HCLK <= 16   |
//  648  |---------------|----------------|----------------|-----------------|-----------------|   
//  649  |1WS(2CPU cycle)|30 < HCLK <= 60 |24 < HCLK <= 48 |18 < HCLK <= 36  |16 < HCLK <= 32  | 
//  650  |---------------|----------------|----------------|-----------------|-----------------|   
//  651  |2WS(3CPU cycle)|60 < HCLK <= 90 |48 < HCLK <= 72 |36 < HCLK <= 54  |32 < HCLK <= 48  |
//  652  |---------------|----------------|----------------|-----------------|-----------------| 
//  653  |3WS(4CPU cycle)|90 < HCLK <= 120|72 < HCLK <= 96 |54 < HCLK <= 72  |48 < HCLK <= 64  |
//  654  |---------------|----------------|----------------|-----------------|-----------------| 
//  655  |4WS(5CPU cycle)|      NA        |96 < HCLK <= 120|72 < HCLK <= 90  |64 < HCLK <= 80  |
//  656  |---------------|----------------|----------------|-----------------|-----------------| 
//  657  |5WS(6CPU cycle)|      NA        |      NA        |90 < HCLK <= 108 |80 < HCLK <= 96  | 
//  658  |---------------|----------------|----------------|-----------------|-----------------| 
//  659  |6WS(7CPU cycle)|      NA        |      NA        |108 < HCLK <= 120|96 < HCLK <= 112 | 
//  660  |---------------|----------------|----------------|-----------------|-----------------| 
//  661  |7WS(8CPU cycle)|      NA        |     NA         |     NA          |112 < HCLK <= 120| 
//  662  +-------------------------------------------------------------------------------------+    
//  663 
//  664 
//  665 @endverbatim
//  666   * @{
//  667   */
//  668 
//  669 /**
//  670   * @brief  Configures the system clock (SYSCLK).
//  671   * @note   The HSI is used (enabled by hardware) as system clock source after
//  672   *         startup from Reset, wake-up from STOP and STANDBY mode, or in case
//  673   *         of failure of the HSE used directly or indirectly as system clock
//  674   *         (if the Clock Security System CSS is enabled).
//  675   * @note   A switch from one clock source to another occurs only if the target
//  676   *         clock source is ready (clock stable after startup delay or PLL locked). 
//  677   *         If a clock source which is not yet ready is selected, the switch will
//  678   *         occur when the clock source will be ready. 
//  679   *         You can use RCC_GetSYSCLKSource() function to know which clock is
//  680   *         currently used as system clock source. 
//  681   * @param  RCC_SYSCLKSource: specifies the clock source used as system clock.
//  682   *          This parameter can be one of the following values:
//  683   *            @arg RCC_SYSCLKSource_HSI:    HSI selected as system clock source
//  684   *            @arg RCC_SYSCLKSource_HSE:    HSE selected as system clock source
//  685   *            @arg RCC_SYSCLKSource_PLLCLK: PLL selected as system clock source
//  686   * @retval None
//  687   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function RCC_SYSCLKConfig
        THUMB
//  688 void RCC_SYSCLKConfig(uint32_t RCC_SYSCLKSource)
//  689 {
//  690   uint32_t tmpreg = 0;
//  691 
//  692   /* Check the parameters */
//  693   assert_param(IS_RCC_SYSCLK_SOURCE(RCC_SYSCLKSource));
//  694 
//  695   tmpreg = RCC->CFGR;
RCC_SYSCLKConfig:
        LDR.N    R1,??DataTable39_12  ;; 0x40023808
        LDR      R2,[R1, #+0]
//  696 
//  697   /* Clear SW[1:0] bits */
//  698   tmpreg &= ~RCC_CFGR_SW;
//  699 
//  700   /* Set SW[1:0] bits according to RCC_SYSCLKSource value */
//  701   tmpreg |= RCC_SYSCLKSource;
//  702 
//  703   /* Store the new value */
//  704   RCC->CFGR = tmpreg;
        LSRS     R2,R2,#+2
        ORRS     R0,R0,R2, LSL #+2
        STR      R0,[R1, #+0]
//  705 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  706 
//  707 /**
//  708   * @brief  Returns the clock source used as system clock.
//  709   * @param  None
//  710   * @retval The clock source used as system clock. The returned value can be one
//  711   *         of the following:
//  712   *              - 0x00: HSI used as system clock
//  713   *              - 0x04: HSE used as system clock
//  714   *              - 0x08: PLL used as system clock
//  715   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function RCC_GetSYSCLKSource
        THUMB
//  716 uint8_t RCC_GetSYSCLKSource(void)
//  717 {
//  718   return ((uint8_t)(RCC->CFGR & RCC_CFGR_SWS));
RCC_GetSYSCLKSource:
        LDR.N    R0,??DataTable39_12  ;; 0x40023808
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0xC
        BX       LR               ;; return
        CFI EndBlock cfiBlock16
//  719 }
//  720 
//  721 /**
//  722   * @brief  Configures the AHB clock (HCLK).
//  723   * @note   Depending on the device voltage range, the software has to set correctly
//  724   *         these bits to ensure that HCLK not exceed the maximum allowed frequency
//  725   *         (for more details refer to section above
//  726   *           "CPU, AHB and APB busses clocks configuration functions")
//  727   * @param  RCC_SYSCLK: defines the AHB clock divider. This clock is derived from 
//  728   *         the system clock (SYSCLK).
//  729   *          This parameter can be one of the following values:
//  730   *            @arg RCC_SYSCLK_Div1: AHB clock = SYSCLK
//  731   *            @arg RCC_SYSCLK_Div2: AHB clock = SYSCLK/2
//  732   *            @arg RCC_SYSCLK_Div4: AHB clock = SYSCLK/4
//  733   *            @arg RCC_SYSCLK_Div8: AHB clock = SYSCLK/8
//  734   *            @arg RCC_SYSCLK_Div16: AHB clock = SYSCLK/16
//  735   *            @arg RCC_SYSCLK_Div64: AHB clock = SYSCLK/64
//  736   *            @arg RCC_SYSCLK_Div128: AHB clock = SYSCLK/128
//  737   *            @arg RCC_SYSCLK_Div256: AHB clock = SYSCLK/256
//  738   *            @arg RCC_SYSCLK_Div512: AHB clock = SYSCLK/512
//  739   * @retval None
//  740   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function RCC_HCLKConfig
        THUMB
//  741 void RCC_HCLKConfig(uint32_t RCC_SYSCLK)
//  742 {
//  743   uint32_t tmpreg = 0;
//  744   
//  745   /* Check the parameters */
//  746   assert_param(IS_RCC_HCLK(RCC_SYSCLK));
//  747 
//  748   tmpreg = RCC->CFGR;
RCC_HCLKConfig:
        LDR.N    R1,??DataTable39_12  ;; 0x40023808
        LDR      R2,[R1, #+0]
//  749 
//  750   /* Clear HPRE[3:0] bits */
//  751   tmpreg &= ~RCC_CFGR_HPRE;
//  752 
//  753   /* Set HPRE[3:0] bits according to RCC_SYSCLK value */
//  754   tmpreg |= RCC_SYSCLK;
//  755 
//  756   /* Store the new value */
//  757   RCC->CFGR = tmpreg;
        BIC      R2,R2,#0xF0
        B.N      ?Subroutine2
        CFI EndBlock cfiBlock17
//  758 }
//  759 
//  760 
//  761 /**
//  762   * @brief  Configures the Low Speed APB clock (PCLK1).
//  763   * @param  RCC_HCLK: defines the APB1 clock divider. This clock is derived from 
//  764   *         the AHB clock (HCLK).
//  765   *          This parameter can be one of the following values:
//  766   *            @arg RCC_HCLK_Div1:  APB1 clock = HCLK
//  767   *            @arg RCC_HCLK_Div2:  APB1 clock = HCLK/2
//  768   *            @arg RCC_HCLK_Div4:  APB1 clock = HCLK/4
//  769   *            @arg RCC_HCLK_Div8:  APB1 clock = HCLK/8
//  770   *            @arg RCC_HCLK_Div16: APB1 clock = HCLK/16
//  771   * @retval None
//  772   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function RCC_PCLK1Config
        THUMB
//  773 void RCC_PCLK1Config(uint32_t RCC_HCLK)
//  774 {
//  775   uint32_t tmpreg = 0;
//  776 
//  777   /* Check the parameters */
//  778   assert_param(IS_RCC_PCLK(RCC_HCLK));
//  779 
//  780   tmpreg = RCC->CFGR;
RCC_PCLK1Config:
        LDR.N    R1,??DataTable39_12  ;; 0x40023808
        LDR      R2,[R1, #+0]
//  781 
//  782   /* Clear PPRE1[2:0] bits */
//  783   tmpreg &= ~RCC_CFGR_PPRE1;
//  784 
//  785   /* Set PPRE1[2:0] bits according to RCC_HCLK value */
//  786   tmpreg |= RCC_HCLK;
//  787 
//  788   /* Store the new value */
//  789   RCC->CFGR = tmpreg;
        BIC      R2,R2,#0x1C00
        CFI EndBlock cfiBlock18
        REQUIRE ?Subroutine2
        ;; // Fall through to label ?Subroutine2
//  790 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine2:
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock19
//  791 
//  792 /**
//  793   * @brief  Configures the High Speed APB clock (PCLK2).
//  794   * @param  RCC_HCLK: defines the APB2 clock divider. This clock is derived from 
//  795   *         the AHB clock (HCLK).
//  796   *          This parameter can be one of the following values:
//  797   *            @arg RCC_HCLK_Div1:  APB2 clock = HCLK
//  798   *            @arg RCC_HCLK_Div2:  APB2 clock = HCLK/2
//  799   *            @arg RCC_HCLK_Div4:  APB2 clock = HCLK/4
//  800   *            @arg RCC_HCLK_Div8:  APB2 clock = HCLK/8
//  801   *            @arg RCC_HCLK_Div16: APB2 clock = HCLK/16
//  802   * @retval None
//  803   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function RCC_PCLK2Config
        THUMB
//  804 void RCC_PCLK2Config(uint32_t RCC_HCLK)
//  805 {
//  806   uint32_t tmpreg = 0;
//  807 
//  808   /* Check the parameters */
//  809   assert_param(IS_RCC_PCLK(RCC_HCLK));
//  810 
//  811   tmpreg = RCC->CFGR;
RCC_PCLK2Config:
        LDR.N    R1,??DataTable39_12  ;; 0x40023808
        LDR      R2,[R1, #+0]
//  812 
//  813   /* Clear PPRE2[2:0] bits */
//  814   tmpreg &= ~RCC_CFGR_PPRE2;
//  815 
//  816   /* Set PPRE2[2:0] bits according to RCC_HCLK value */
//  817   tmpreg |= RCC_HCLK << 3;
//  818 
//  819   /* Store the new value */
//  820   RCC->CFGR = tmpreg;
        BIC      R2,R2,#0xE000
        CFI EndBlock cfiBlock20
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  821 }

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI NoFunction
        THUMB
?Subroutine0:
        ORR      R0,R2,R0, LSL #+3
        STR      R0,[R1, #+0]
        BX       LR               ;; return
        CFI EndBlock cfiBlock21
//  822 
//  823 /**
//  824   * @brief  Returns the frequencies of different on chip clocks; SYSCLK, HCLK, 
//  825   *         PCLK1 and PCLK2.       
//  826   * 
//  827   * @note   The system frequency computed by this function is not the real 
//  828   *         frequency in the chip. It is calculated based on the predefined 
//  829   *         constant and the selected clock source:
//  830   * @note     If SYSCLK source is HSI, function returns values based on HSI_VALUE(*)
//  831   * @note     If SYSCLK source is HSE, function returns values based on HSE_VALUE(**)
//  832   * @note     If SYSCLK source is PLL, function returns values based on HSE_VALUE(**) 
//  833   *           or HSI_VALUE(*) multiplied/divided by the PLL factors.         
//  834   * @note     (*) HSI_VALUE is a constant defined in stm32f2xx.h file (default value
//  835   *               16 MHz) but the real value may vary depending on the variations
//  836   *               in voltage and temperature.
//  837   * @note     (**) HSE_VALUE is a constant defined in stm32f2xx.h file (default value
//  838   *                25 MHz), user has to ensure that HSE_VALUE is same as the real
//  839   *                frequency of the crystal used. Otherwise, this function may
//  840   *                have wrong result.
//  841   *                
//  842   * @note   The result of this function could be not correct when using fractional
//  843   *         value for HSE crystal.
//  844   *   
//  845   * @param  RCC_Clocks: pointer to a RCC_ClocksTypeDef structure which will hold
//  846   *          the clocks frequencies.
//  847   *     
//  848   * @note   This function can be used by the user application to compute the 
//  849   *         baudrate for the communication peripherals or configure other parameters.
//  850   * @note   Each time SYSCLK, HCLK, PCLK1 and/or PCLK2 clock changes, this function
//  851   *         must be called to update the structure's field. Otherwise, any
//  852   *         configuration based on this function will be incorrect.
//  853   *    
//  854   * @retval None
//  855   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function RCC_GetClocksFreq
        THUMB
//  856 void RCC_GetClocksFreq(RCC_ClocksTypeDef* RCC_Clocks)
//  857 {
//  858   uint32_t tmp = 0, presc = 0, pllvco = 0, pllp = 2, pllsource = 0, pllm = 2;
//  859 
//  860   /* Get SYSCLK source -------------------------------------------------------*/
//  861   tmp = RCC->CFGR & RCC_CFGR_SWS;
RCC_GetClocksFreq:
        LDR.N    R1,??DataTable39_7  ;; 0x40023804
        LDR      R2,[R1, #+4]
//  862 
//  863   switch (tmp)
        AND      R2,R2,#0xC
        CMP      R2,#+4
        BEQ.N    ??RCC_GetClocksFreq_0
        CMP      R2,#+8
        BEQ.N    ??RCC_GetClocksFreq_1
//  864   {
//  865     case 0x00:  /* HSI used as system clock source */
//  866       RCC_Clocks->SYSCLK_Frequency = HSI_VALUE;
        LDR.N    R2,??DataTable39_13  ;; 0xf42400
//  867       break;
        B.N      ??RCC_GetClocksFreq_2
//  868     case 0x04:  /* HSE used as system clock  source */
//  869       RCC_Clocks->SYSCLK_Frequency = HSE_VALUE;
??RCC_GetClocksFreq_0:
        LDR.N    R2,??DataTable39_14  ;; 0x17d7840
//  870       break;
        B.N      ??RCC_GetClocksFreq_2
//  871     case 0x08:  /* PLL used as system clock  source */
//  872 
//  873       /* PLL_VCO = (HSE_VALUE or HSI_VALUE / PLLM) * PLLN
//  874          SYSCLK = PLL_VCO / PLLP
//  875          */    
//  876       pllsource = (RCC->PLLCFGR & RCC_PLLCFGR_PLLSRC) >> 22;
??RCC_GetClocksFreq_1:
        LDR      R2,[R1, #+0]
//  877       pllm = RCC->PLLCFGR & RCC_PLLCFGR_PLLM;
        LDR      R3,[R1, #+0]
        AND      R3,R3,#0x3F
//  878       
//  879       if (pllsource != 0)
        LSLS     R2,R2,#+9
        ITE      MI 
        LDRMI.N  R2,??DataTable39_14  ;; 0x17d7840
        LDRPL.N  R2,??DataTable39_13  ;; 0xf42400
//  880       {
//  881         /* HSE used as PLL clock source */
//  882         pllvco = (HSE_VALUE / pllm) * ((RCC->PLLCFGR & RCC_PLLCFGR_PLLN) >> 6);
//  883       }
//  884       else
//  885       {
//  886         /* HSI used as PLL clock source */
//  887         pllvco = (HSI_VALUE / pllm) * ((RCC->PLLCFGR & RCC_PLLCFGR_PLLN) >> 6);      
        UDIV     R2,R2,R3
        LDR      R3,[R1, #+0]
        UBFX     R3,R3,#+6,#+9
        MULS     R2,R3,R2
//  888       }
//  889 
//  890       pllp = (((RCC->PLLCFGR & RCC_PLLCFGR_PLLP) >>16) + 1 ) *2;
        LDR      R3,[R1, #+0]
//  891       RCC_Clocks->SYSCLK_Frequency = pllvco/pllp;
        UBFX     R3,R3,#+16,#+2
        ADDS     R3,R3,#+1
        LSLS     R3,R3,#+1
        UDIV     R2,R2,R3
//  892       break;
??RCC_GetClocksFreq_2:
        STR      R2,[R0, #+0]
//  893     default:
//  894       RCC_Clocks->SYSCLK_Frequency = HSI_VALUE;
//  895       break;
//  896   }
//  897   /* Compute HCLK, PCLK1 and PCLK2 clocks frequencies ------------------------*/
//  898 
//  899   /* Get HCLK prescaler */
//  900   tmp = RCC->CFGR & RCC_CFGR_HPRE;
        LDR      R3,[R1, #+4]
//  901   tmp = tmp >> 4;
//  902   presc = APBAHBPrescTable[tmp];
//  903   /* HCLK clock frequency */
//  904   RCC_Clocks->HCLK_Frequency = RCC_Clocks->SYSCLK_Frequency >> presc;
        LDR.N    R2,??DataTable39_15
        LDR      R12,[R0, #+0]
        UBFX     R3,R3,#+4,#+4
        LDRB     R3,[R3, R2]
        LSR      R3,R12,R3
        STR      R3,[R0, #+4]
//  905 
//  906   /* Get PCLK1 prescaler */
//  907   tmp = RCC->CFGR & RCC_CFGR_PPRE1;
        LDR      R3,[R1, #+4]
//  908   tmp = tmp >> 10;
//  909   presc = APBAHBPrescTable[tmp];
//  910   /* PCLK1 clock frequency */
//  911   RCC_Clocks->PCLK1_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
        LDR      R12,[R0, #+4]
        UBFX     R3,R3,#+10,#+3
        LDRB     R3,[R3, R2]
        LSR      R3,R12,R3
        STR      R3,[R0, #+8]
//  912 
//  913   /* Get PCLK2 prescaler */
//  914   tmp = RCC->CFGR & RCC_CFGR_PPRE2;
        LDR      R1,[R1, #+4]
//  915   tmp = tmp >> 13;
//  916   presc = APBAHBPrescTable[tmp];
//  917   /* PCLK2 clock frequency */
//  918   RCC_Clocks->PCLK2_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
        LDR      R3,[R0, #+4]
        UBFX     R1,R1,#+13,#+3
        LDRB     R1,[R1, R2]
        LSR      R1,R3,R1
        STR      R1,[R0, #+12]
//  919 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock22
//  920 
//  921 /**
//  922   * @}
//  923   */
//  924 
//  925 /** @defgroup RCC_Group3 Peripheral clocks configuration functions
//  926  *  @brief   Peripheral clocks configuration functions 
//  927  *
//  928 @verbatim   
//  929  ===============================================================================
//  930                    Peripheral clocks configuration functions
//  931  ===============================================================================  
//  932 
//  933   This section provide functions allowing to configure the Peripheral clocks. 
//  934   
//  935   1. The RTC clock which is derived from the LSI, LSE or HSE clock divided by 2 to 31.
//  936      
//  937   2. After restart from Reset or wakeup from STANDBY, all peripherals are off
//  938      except internal SRAM, Flash and JTAG. Before to start using a peripheral you
//  939      have to enable its interface clock. You can do this using RCC_AHBPeriphClockCmd()
//  940      , RCC_APB2PeriphClockCmd() and RCC_APB1PeriphClockCmd() functions.
//  941 
//  942   3. To reset the peripherals configuration (to the default state after device reset)
//  943      you can use RCC_AHBPeriphResetCmd(), RCC_APB2PeriphResetCmd() and 
//  944      RCC_APB1PeriphResetCmd() functions.
//  945      
//  946   4. To further reduce power consumption in SLEEP mode the peripheral clocks can
//  947      be disabled prior to executing the WFI or WFE instructions. You can do this
//  948      using RCC_AHBPeriphClockLPModeCmd(), RCC_APB2PeriphClockLPModeCmd() and
//  949      RCC_APB1PeriphClockLPModeCmd() functions.  
//  950 
//  951 @endverbatim
//  952   * @{
//  953   */
//  954 
//  955 /**
//  956   * @brief  Configures the RTC clock (RTCCLK).
//  957   * @note   As the RTC clock configuration bits are in the Backup domain and write
//  958   *         access is denied to this domain after reset, you have to enable write
//  959   *         access using PWR_BackupAccessCmd(ENABLE) function before to configure
//  960   *         the RTC clock source (to be done once after reset).    
//  961   * @note   Once the RTC clock is configured it can't be changed unless the  
//  962   *         Backup domain is reset using RCC_BackupResetCmd() function, or by
//  963   *         a Power On Reset (POR).
//  964   *    
//  965   * @param  RCC_RTCCLKSource: specifies the RTC clock source.
//  966   *          This parameter can be one of the following values:
//  967   *            @arg RCC_RTCCLKSource_LSE: LSE selected as RTC clock
//  968   *            @arg RCC_RTCCLKSource_LSI: LSI selected as RTC clock
//  969   *            @arg RCC_RTCCLKSource_HSE_Divx: HSE clock divided by x selected
//  970   *                                            as RTC clock, where x:[2,31]
//  971   *  
//  972   * @note   If the LSE or LSI is used as RTC clock source, the RTC continues to
//  973   *         work in STOP and STANDBY modes, and can be used as wakeup source.
//  974   *         However, when the HSE clock is used as RTC clock source, the RTC
//  975   *         cannot be used in STOP and STANDBY modes.    
//  976   * @note   The maximum input clock frequency for RTC is 1MHz (when using HSE as
//  977   *         RTC clock source).
//  978   *  
//  979   * @retval None
//  980   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function RCC_RTCCLKConfig
        THUMB
//  981 void RCC_RTCCLKConfig(uint32_t RCC_RTCCLKSource)
//  982 {
//  983   uint32_t tmpreg = 0;
//  984 
//  985   /* Check the parameters */
//  986   assert_param(IS_RCC_RTCCLK_SOURCE(RCC_RTCCLKSource));
//  987 
//  988   if ((RCC_RTCCLKSource & 0x00000300) == 0x00000300)
RCC_RTCCLKConfig:
        LDR.N    R1,??DataTable39_12  ;; 0x40023808
        MOV      R2,#+768
        ANDS     R2,R2,R0
        MOV      R3,#+768
        CMP      R2,R3
        BNE.N    ??RCC_RTCCLKConfig_0
//  989   { /* If HSE is selected as RTC clock source, configure HSE division factor for RTC clock */
//  990     tmpreg = RCC->CFGR;
        LDR      R2,[R1, #+0]
//  991 
//  992     /* Clear RTCPRE[4:0] bits */
//  993     tmpreg &= ~RCC_CFGR_RTCPRE;
//  994 
//  995     /* Configure HSE division factor for RTC clock */
//  996     tmpreg |= (RCC_RTCCLKSource & 0xFFFFCFF);
//  997 
//  998     /* Store the new value */
//  999     RCC->CFGR = tmpreg;
        BIC      R2,R2,#0x1F0000
        LDR.N    R3,??DataTable39_16  ;; 0xffffcff
        ANDS     R3,R3,R0
        ORRS     R2,R3,R2
        STR      R2,[R1, #+0]
// 1000   }
// 1001     
// 1002   /* Select the RTC clock source */
// 1003   RCC->BDCR |= (RCC_RTCCLKSource & 0x00000FFF);
??RCC_RTCCLKConfig_0:
        LDR      R2,[R1, #+104]
        LSLS     R0,R0,#+20
        ORRS     R0,R2,R0, LSR #+20
        STR      R0,[R1, #+104]
// 1004 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock23
// 1005 
// 1006 /**
// 1007   * @brief  Enables or disables the RTC clock.
// 1008   * @note   This function must be used only after the RTC clock source was selected
// 1009   *         using the RCC_RTCCLKConfig function.
// 1010   * @param  NewState: new state of the RTC clock. This parameter can be: ENABLE or DISABLE.
// 1011   * @retval None
// 1012   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function RCC_RTCCLKCmd
        THUMB
// 1013 void RCC_RTCCLKCmd(FunctionalState NewState)
// 1014 {
// 1015   /* Check the parameters */
// 1016   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1017 
// 1018   *(__IO uint32_t *) BDCR_RTCEN_BB = (uint32_t)NewState;
RCC_RTCCLKCmd:
        LDR.N    R1,??DataTable39_17  ;; 0x42470e3c
        STR      R0,[R1, #+0]
// 1019 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock24
// 1020 
// 1021 /**
// 1022   * @brief  Forces or releases the Backup domain reset.
// 1023   * @note   This function resets the RTC peripheral (including the backup registers)
// 1024   *         and the RTC clock source selection in RCC_CSR register.
// 1025   * @note   The BKPSRAM is not affected by this reset.    
// 1026   * @param  NewState: new state of the Backup domain reset.
// 1027   *          This parameter can be: ENABLE or DISABLE.
// 1028   * @retval None
// 1029   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function RCC_BackupResetCmd
        THUMB
// 1030 void RCC_BackupResetCmd(FunctionalState NewState)
// 1031 {
// 1032   /* Check the parameters */
// 1033   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1034   *(__IO uint32_t *) BDCR_BDRST_BB = (uint32_t)NewState;
RCC_BackupResetCmd:
        LDR.N    R1,??DataTable39_18  ;; 0x42470e40
        STR      R0,[R1, #+0]
// 1035 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock25
// 1036 
// 1037 /**
// 1038   * @brief  Configures the I2S clock source (I2SCLK).
// 1039   *
// 1040   * @note   This function must be called before enabling the I2S APB clock.
// 1041   * @note   This function applies only to Silicon RevisionB and RevisionY.
// 1042   *
// 1043   * @param  RCC_I2SCLKSource: specifies the I2S clock source.
// 1044   *          This parameter can be one of the following values:
// 1045   *            @arg RCC_I2S2CLKSource_PLLI2S: PLLI2S clock used as I2S clock source
// 1046   *            @arg RCC_I2S2CLKSource_Ext: External clock mapped on the I2S_CKIN pin
// 1047   *                                        used as I2S clock source
// 1048   * @retval None
// 1049   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function RCC_I2SCLKConfig
        THUMB
// 1050 void RCC_I2SCLKConfig(uint32_t RCC_I2SCLKSource)
// 1051 {
// 1052   /* Check the parameters */
// 1053   assert_param(IS_RCC_I2SCLK_SOURCE(RCC_I2SCLKSource));
// 1054 
// 1055   *(__IO uint32_t *) CFGR_I2SSRC_BB = RCC_I2SCLKSource;
RCC_I2SCLKConfig:
        LDR.N    R1,??DataTable39_19  ;; 0x4247015c
        STR      R0,[R1, #+0]
// 1056 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock26
// 1057 
// 1058 /**
// 1059   * @brief  Enables or disables the AHB1 peripheral clock.
// 1060   * @note   After reset, the peripheral clock (used for registers read/write access)
// 1061   *         is disabled and the application software has to enable this clock before 
// 1062   *         using it.   
// 1063   * @param  RCC_AHBPeriph: specifies the AHB1 peripheral to gates its clock.
// 1064   *          This parameter can be any combination of the following values:
// 1065   *            @arg RCC_AHB1Periph_GPIOA:       GPIOA clock
// 1066   *            @arg RCC_AHB1Periph_GPIOB:       GPIOB clock 
// 1067   *            @arg RCC_AHB1Periph_GPIOC:       GPIOC clock
// 1068   *            @arg RCC_AHB1Periph_GPIOD:       GPIOD clock
// 1069   *            @arg RCC_AHB1Periph_GPIOE:       GPIOE clock
// 1070   *            @arg RCC_AHB1Periph_GPIOF:       GPIOF clock
// 1071   *            @arg RCC_AHB1Periph_GPIOG:       GPIOG clock
// 1072   *            @arg RCC_AHB1Periph_GPIOG:       GPIOG clock
// 1073   *            @arg RCC_AHB1Periph_GPIOI:       GPIOI clock
// 1074   *            @arg RCC_AHB1Periph_CRC:         CRC clock
// 1075   *            @arg RCC_AHB1Periph_BKPSRAM:     BKPSRAM interface clock
// 1076   *            @arg RCC_AHB1Periph_DMA1:        DMA1 clock
// 1077   *            @arg RCC_AHB1Periph_DMA2:        DMA2 clock
// 1078   *            @arg RCC_AHB1Periph_ETH_MAC:     Ethernet MAC clock
// 1079   *            @arg RCC_AHB1Periph_ETH_MAC_Tx:  Ethernet Transmission clock
// 1080   *            @arg RCC_AHB1Periph_ETH_MAC_Rx:  Ethernet Reception clock
// 1081   *            @arg RCC_AHB1Periph_ETH_MAC_PTP: Ethernet PTP clock
// 1082   *            @arg RCC_AHB1Periph_OTG_HS:      USB OTG HS clock
// 1083   *            @arg RCC_AHB1Periph_OTG_HS_ULPI: USB OTG HS ULPI clock
// 1084   * @param  NewState: new state of the specified peripheral clock.
// 1085   *          This parameter can be: ENABLE or DISABLE.
// 1086   * @retval None
// 1087   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function RCC_AHB1PeriphClockCmd
        THUMB
// 1088 void RCC_AHB1PeriphClockCmd(uint32_t RCC_AHB1Periph, FunctionalState NewState)
// 1089 {
// 1090   /* Check the parameters */
// 1091   assert_param(IS_RCC_AHB1_CLOCK_PERIPH(RCC_AHB1Periph));
// 1092 
// 1093   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1094   if (NewState != DISABLE)
RCC_AHB1PeriphClockCmd:
        LDR.N    R2,??DataTable39_20  ;; 0x40023830
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1095   {
// 1096     RCC->AHB1ENR |= RCC_AHB1Periph;
// 1097   }
// 1098   else
// 1099   {
// 1100     RCC->AHB1ENR &= ~RCC_AHB1Periph;
        STR      R0,[R2, #+0]
// 1101   }
// 1102 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock27
// 1103 
// 1104 /**
// 1105   * @brief  Enables or disables the AHB2 peripheral clock.
// 1106   * @note   After reset, the peripheral clock (used for registers read/write access)
// 1107   *         is disabled and the application software has to enable this clock before 
// 1108   *         using it. 
// 1109   * @param  RCC_AHBPeriph: specifies the AHB2 peripheral to gates its clock.
// 1110   *          This parameter can be any combination of the following values:
// 1111   *            @arg RCC_AHB2Periph_DCMI:   DCMI clock
// 1112   *            @arg RCC_AHB2Periph_CRYP:   CRYP clock
// 1113   *            @arg RCC_AHB2Periph_HASH:   HASH clock
// 1114   *            @arg RCC_AHB2Periph_RNG:    RNG clock
// 1115   *            @arg RCC_AHB2Periph_OTG_FS: USB OTG FS clock
// 1116   * @param  NewState: new state of the specified peripheral clock.
// 1117   *          This parameter can be: ENABLE or DISABLE.
// 1118   * @retval None
// 1119   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function RCC_AHB2PeriphClockCmd
        THUMB
// 1120 void RCC_AHB2PeriphClockCmd(uint32_t RCC_AHB2Periph, FunctionalState NewState)
// 1121 {
// 1122   /* Check the parameters */
// 1123   assert_param(IS_RCC_AHB2_PERIPH(RCC_AHB2Periph));
// 1124   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1125 
// 1126   if (NewState != DISABLE)
RCC_AHB2PeriphClockCmd:
        LDR.N    R2,??DataTable39_21  ;; 0x40023834
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1127   {
// 1128     RCC->AHB2ENR |= RCC_AHB2Periph;
// 1129   }
// 1130   else
// 1131   {
// 1132     RCC->AHB2ENR &= ~RCC_AHB2Periph;
        STR      R0,[R2, #+0]
// 1133   }
// 1134 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock28
// 1135 
// 1136 /**
// 1137   * @brief  Enables or disables the AHB3 peripheral clock.
// 1138   * @note   After reset, the peripheral clock (used for registers read/write access)
// 1139   *         is disabled and the application software has to enable this clock before 
// 1140   *         using it. 
// 1141   * @param  RCC_AHBPeriph: specifies the AHB3 peripheral to gates its clock.
// 1142   *          This parameter must be: RCC_AHB3Periph_FSMC
// 1143   * @param  NewState: new state of the specified peripheral clock.
// 1144   *          This parameter can be: ENABLE or DISABLE.
// 1145   * @retval None
// 1146   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function RCC_AHB3PeriphClockCmd
        THUMB
// 1147 void RCC_AHB3PeriphClockCmd(uint32_t RCC_AHB3Periph, FunctionalState NewState)
// 1148 {
// 1149   /* Check the parameters */
// 1150   assert_param(IS_RCC_AHB3_PERIPH(RCC_AHB3Periph));  
// 1151   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1152 
// 1153   if (NewState != DISABLE)
RCC_AHB3PeriphClockCmd:
        LDR.N    R2,??DataTable39_22  ;; 0x40023838
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1154   {
// 1155     RCC->AHB3ENR |= RCC_AHB3Periph;
// 1156   }
// 1157   else
// 1158   {
// 1159     RCC->AHB3ENR &= ~RCC_AHB3Periph;
        STR      R0,[R2, #+0]
// 1160   }
// 1161 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock29
// 1162 
// 1163 /**
// 1164   * @brief  Enables or disables the Low Speed APB (APB1) peripheral clock.
// 1165   * @note   After reset, the peripheral clock (used for registers read/write access)
// 1166   *         is disabled and the application software has to enable this clock before 
// 1167   *         using it. 
// 1168   * @param  RCC_APB1Periph: specifies the APB1 peripheral to gates its clock.
// 1169   *          This parameter can be any combination of the following values:
// 1170   *            @arg RCC_APB1Periph_TIM2:   TIM2 clock
// 1171   *            @arg RCC_APB1Periph_TIM3:   TIM3 clock
// 1172   *            @arg RCC_APB1Periph_TIM4:   TIM4 clock
// 1173   *            @arg RCC_APB1Periph_TIM5:   TIM5 clock
// 1174   *            @arg RCC_APB1Periph_TIM6:   TIM6 clock
// 1175   *            @arg RCC_APB1Periph_TIM7:   TIM7 clock
// 1176   *            @arg RCC_APB1Periph_TIM12:  TIM12 clock
// 1177   *            @arg RCC_APB1Periph_TIM13:  TIM13 clock
// 1178   *            @arg RCC_APB1Periph_TIM14:  TIM14 clock
// 1179   *            @arg RCC_APB1Periph_WWDG:   WWDG clock
// 1180   *            @arg RCC_APB1Periph_SPI2:   SPI2 clock
// 1181   *            @arg RCC_APB1Periph_SPI3:   SPI3 clock
// 1182   *            @arg RCC_APB1Periph_USART2: USART2 clock
// 1183   *            @arg RCC_APB1Periph_USART3: USART3 clock
// 1184   *            @arg RCC_APB1Periph_UART4:  UART4 clock
// 1185   *            @arg RCC_APB1Periph_UART5:  UART5 clock
// 1186   *            @arg RCC_APB1Periph_I2C1:   I2C1 clock
// 1187   *            @arg RCC_APB1Periph_I2C2:   I2C2 clock
// 1188   *            @arg RCC_APB1Periph_I2C3:   I2C3 clock
// 1189   *            @arg RCC_APB1Periph_CAN1:   CAN1 clock
// 1190   *            @arg RCC_APB1Periph_CAN2:   CAN2 clock
// 1191   *            @arg RCC_APB1Periph_PWR:    PWR clock
// 1192   *            @arg RCC_APB1Periph_DAC:    DAC clock
// 1193   * @param  NewState: new state of the specified peripheral clock.
// 1194   *          This parameter can be: ENABLE or DISABLE.
// 1195   * @retval None
// 1196   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI Function RCC_APB1PeriphClockCmd
        THUMB
// 1197 void RCC_APB1PeriphClockCmd(uint32_t RCC_APB1Periph, FunctionalState NewState)
// 1198 {
// 1199   /* Check the parameters */
// 1200   assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));  
// 1201   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1202 
// 1203   if (NewState != DISABLE)
RCC_APB1PeriphClockCmd:
        LDR.N    R2,??DataTable39_23  ;; 0x40023840
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1204   {
// 1205     RCC->APB1ENR |= RCC_APB1Periph;
// 1206   }
// 1207   else
// 1208   {
// 1209     RCC->APB1ENR &= ~RCC_APB1Periph;
        STR      R0,[R2, #+0]
// 1210   }
// 1211 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock30
// 1212 
// 1213 /**
// 1214   * @brief  Enables or disables the High Speed APB (APB2) peripheral clock.
// 1215   * @note   After reset, the peripheral clock (used for registers read/write access)
// 1216   *         is disabled and the application software has to enable this clock before 
// 1217   *         using it.
// 1218   * @param  RCC_APB2Periph: specifies the APB2 peripheral to gates its clock.
// 1219   *          This parameter can be any combination of the following values:
// 1220   *            @arg RCC_APB2Periph_TIM1:   TIM1 clock
// 1221   *            @arg RCC_APB2Periph_TIM8:   TIM8 clock
// 1222   *            @arg RCC_APB2Periph_USART1: USART1 clock
// 1223   *            @arg RCC_APB2Periph_USART6: USART6 clock
// 1224   *            @arg RCC_APB2Periph_ADC1:   ADC1 clock
// 1225   *            @arg RCC_APB2Periph_ADC2:   ADC2 clock
// 1226   *            @arg RCC_APB2Periph_ADC3:   ADC3 clock
// 1227   *            @arg RCC_APB2Periph_SDIO:   SDIO clock
// 1228   *            @arg RCC_APB2Periph_SPI1:   SPI1 clock
// 1229   *            @arg RCC_APB2Periph_SYSCFG: SYSCFG clock
// 1230   *            @arg RCC_APB2Periph_TIM9:   TIM9 clock
// 1231   *            @arg RCC_APB2Periph_TIM10:  TIM10 clock
// 1232   *            @arg RCC_APB2Periph_TIM11:  TIM11 clock
// 1233   * @param  NewState: new state of the specified peripheral clock.
// 1234   *          This parameter can be: ENABLE or DISABLE.
// 1235   * @retval None
// 1236   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock31 Using cfiCommon0
        CFI Function RCC_APB2PeriphClockCmd
        THUMB
// 1237 void RCC_APB2PeriphClockCmd(uint32_t RCC_APB2Periph, FunctionalState NewState)
// 1238 {
// 1239   /* Check the parameters */
// 1240   assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
// 1241   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1242 
// 1243   if (NewState != DISABLE)
RCC_APB2PeriphClockCmd:
        LDR.N    R2,??DataTable39_24  ;; 0x40023844
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1244   {
// 1245     RCC->APB2ENR |= RCC_APB2Periph;
// 1246   }
// 1247   else
// 1248   {
// 1249     RCC->APB2ENR &= ~RCC_APB2Periph;
        STR      R0,[R2, #+0]
// 1250   }
// 1251 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock31
// 1252 
// 1253 /**
// 1254   * @brief  Forces or releases AHB1 peripheral reset.
// 1255   * @param  RCC_AHB1Periph: specifies the AHB1 peripheral to reset.
// 1256   *          This parameter can be any combination of the following values:
// 1257   *            @arg RCC_AHB1Periph_GPIOA:   GPIOA clock
// 1258   *            @arg RCC_AHB1Periph_GPIOB:   GPIOB clock 
// 1259   *            @arg RCC_AHB1Periph_GPIOC:   GPIOC clock
// 1260   *            @arg RCC_AHB1Periph_GPIOD:   GPIOD clock
// 1261   *            @arg RCC_AHB1Periph_GPIOE:   GPIOE clock
// 1262   *            @arg RCC_AHB1Periph_GPIOF:   GPIOF clock
// 1263   *            @arg RCC_AHB1Periph_GPIOG:   GPIOG clock
// 1264   *            @arg RCC_AHB1Periph_GPIOG:   GPIOG clock
// 1265   *            @arg RCC_AHB1Periph_GPIOI:   GPIOI clock
// 1266   *            @arg RCC_AHB1Periph_CRC:     CRC clock
// 1267   *            @arg RCC_AHB1Periph_DMA1:    DMA1 clock
// 1268   *            @arg RCC_AHB1Periph_DMA2:    DMA2 clock
// 1269   *            @arg RCC_AHB1Periph_ETH_MAC: Ethernet MAC clock
// 1270   *            @arg RCC_AHB1Periph_OTG_HS:  USB OTG HS clock
// 1271   *                  
// 1272   * @param  NewState: new state of the specified peripheral reset.
// 1273   *          This parameter can be: ENABLE or DISABLE.
// 1274   * @retval None
// 1275   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock32 Using cfiCommon0
        CFI Function RCC_AHB1PeriphResetCmd
        THUMB
// 1276 void RCC_AHB1PeriphResetCmd(uint32_t RCC_AHB1Periph, FunctionalState NewState)
// 1277 {
// 1278   /* Check the parameters */
// 1279   assert_param(IS_RCC_AHB1_RESET_PERIPH(RCC_AHB1Periph));
// 1280   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1281 
// 1282   if (NewState != DISABLE)
RCC_AHB1PeriphResetCmd:
        LDR.N    R2,??DataTable39_25  ;; 0x40023810
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1283   {
// 1284     RCC->AHB1RSTR |= RCC_AHB1Periph;
// 1285   }
// 1286   else
// 1287   {
// 1288     RCC->AHB1RSTR &= ~RCC_AHB1Periph;
        STR      R0,[R2, #+0]
// 1289   }
// 1290 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock32
// 1291 
// 1292 /**
// 1293   * @brief  Forces or releases AHB2 peripheral reset.
// 1294   * @param  RCC_AHB2Periph: specifies the AHB2 peripheral to reset.
// 1295   *          This parameter can be any combination of the following values:
// 1296   *            @arg RCC_AHB2Periph_DCMI:   DCMI clock
// 1297   *            @arg RCC_AHB2Periph_CRYP:   CRYP clock
// 1298   *            @arg RCC_AHB2Periph_HASH:   HASH clock
// 1299   *            @arg RCC_AHB2Periph_RNG:    RNG clock
// 1300   *            @arg RCC_AHB2Periph_OTG_FS: USB OTG FS clock
// 1301   * @param  NewState: new state of the specified peripheral reset.
// 1302   *          This parameter can be: ENABLE or DISABLE.
// 1303   * @retval None
// 1304   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock33 Using cfiCommon0
        CFI Function RCC_AHB2PeriphResetCmd
        THUMB
// 1305 void RCC_AHB2PeriphResetCmd(uint32_t RCC_AHB2Periph, FunctionalState NewState)
// 1306 {
// 1307   /* Check the parameters */
// 1308   assert_param(IS_RCC_AHB2_PERIPH(RCC_AHB2Periph));
// 1309   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1310 
// 1311   if (NewState != DISABLE)
RCC_AHB2PeriphResetCmd:
        LDR.N    R2,??DataTable39_26  ;; 0x40023814
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1312   {
// 1313     RCC->AHB2RSTR |= RCC_AHB2Periph;
// 1314   }
// 1315   else
// 1316   {
// 1317     RCC->AHB2RSTR &= ~RCC_AHB2Periph;
        STR      R0,[R2, #+0]
// 1318   }
// 1319 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock33
// 1320 
// 1321 /**
// 1322   * @brief  Forces or releases AHB3 peripheral reset.
// 1323   * @param  RCC_AHB3Periph: specifies the AHB3 peripheral to reset.
// 1324   *          This parameter must be: RCC_AHB3Periph_FSMC
// 1325   * @param  NewState: new state of the specified peripheral reset.
// 1326   *          This parameter can be: ENABLE or DISABLE.
// 1327   * @retval None
// 1328   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock34 Using cfiCommon0
        CFI Function RCC_AHB3PeriphResetCmd
        THUMB
// 1329 void RCC_AHB3PeriphResetCmd(uint32_t RCC_AHB3Periph, FunctionalState NewState)
// 1330 {
// 1331   /* Check the parameters */
// 1332   assert_param(IS_RCC_AHB3_PERIPH(RCC_AHB3Periph));
// 1333   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1334 
// 1335   if (NewState != DISABLE)
RCC_AHB3PeriphResetCmd:
        LDR.N    R2,??DataTable39_27  ;; 0x40023818
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1336   {
// 1337     RCC->AHB3RSTR |= RCC_AHB3Periph;
// 1338   }
// 1339   else
// 1340   {
// 1341     RCC->AHB3RSTR &= ~RCC_AHB3Periph;
        STR      R0,[R2, #+0]
// 1342   }
// 1343 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock34
// 1344 
// 1345 /**
// 1346   * @brief  Forces or releases Low Speed APB (APB1) peripheral reset.
// 1347   * @param  RCC_APB1Periph: specifies the APB1 peripheral to reset.
// 1348   *          This parameter can be any combination of the following values:
// 1349   *            @arg RCC_APB1Periph_TIM2:   TIM2 clock
// 1350   *            @arg RCC_APB1Periph_TIM3:   TIM3 clock
// 1351   *            @arg RCC_APB1Periph_TIM4:   TIM4 clock
// 1352   *            @arg RCC_APB1Periph_TIM5:   TIM5 clock
// 1353   *            @arg RCC_APB1Periph_TIM6:   TIM6 clock
// 1354   *            @arg RCC_APB1Periph_TIM7:   TIM7 clock
// 1355   *            @arg RCC_APB1Periph_TIM12:  TIM12 clock
// 1356   *            @arg RCC_APB1Periph_TIM13:  TIM13 clock
// 1357   *            @arg RCC_APB1Periph_TIM14:  TIM14 clock
// 1358   *            @arg RCC_APB1Periph_WWDG:   WWDG clock
// 1359   *            @arg RCC_APB1Periph_SPI2:   SPI2 clock
// 1360   *            @arg RCC_APB1Periph_SPI3:   SPI3 clock
// 1361   *            @arg RCC_APB1Periph_USART2: USART2 clock
// 1362   *            @arg RCC_APB1Periph_USART3: USART3 clock
// 1363   *            @arg RCC_APB1Periph_UART4:  UART4 clock
// 1364   *            @arg RCC_APB1Periph_UART5:  UART5 clock
// 1365   *            @arg RCC_APB1Periph_I2C1:   I2C1 clock
// 1366   *            @arg RCC_APB1Periph_I2C2:   I2C2 clock
// 1367   *            @arg RCC_APB1Periph_I2C3:   I2C3 clock
// 1368   *            @arg RCC_APB1Periph_CAN1:   CAN1 clock
// 1369   *            @arg RCC_APB1Periph_CAN2:   CAN2 clock
// 1370   *            @arg RCC_APB1Periph_PWR:    PWR clock
// 1371   *            @arg RCC_APB1Periph_DAC:    DAC clock
// 1372   * @param  NewState: new state of the specified peripheral reset.
// 1373   *          This parameter can be: ENABLE or DISABLE.
// 1374   * @retval None
// 1375   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock35 Using cfiCommon0
        CFI Function RCC_APB1PeriphResetCmd
        THUMB
// 1376 void RCC_APB1PeriphResetCmd(uint32_t RCC_APB1Periph, FunctionalState NewState)
// 1377 {
// 1378   /* Check the parameters */
// 1379   assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
// 1380   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1381   if (NewState != DISABLE)
RCC_APB1PeriphResetCmd:
        LDR.N    R2,??DataTable39_28  ;; 0x40023820
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1382   {
// 1383     RCC->APB1RSTR |= RCC_APB1Periph;
// 1384   }
// 1385   else
// 1386   {
// 1387     RCC->APB1RSTR &= ~RCC_APB1Periph;
        STR      R0,[R2, #+0]
// 1388   }
// 1389 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock35
// 1390 
// 1391 /**
// 1392   * @brief  Forces or releases High Speed APB (APB2) peripheral reset.
// 1393   * @param  RCC_APB2Periph: specifies the APB2 peripheral to reset.
// 1394   *          This parameter can be any combination of the following values:
// 1395   *            @arg RCC_APB2Periph_TIM1:   TIM1 clock
// 1396   *            @arg RCC_APB2Periph_TIM8:   TIM8 clock
// 1397   *            @arg RCC_APB2Periph_USART1: USART1 clock
// 1398   *            @arg RCC_APB2Periph_USART6: USART6 clock
// 1399   *            @arg RCC_APB2Periph_ADC1:   ADC1 clock
// 1400   *            @arg RCC_APB2Periph_ADC2:   ADC2 clock
// 1401   *            @arg RCC_APB2Periph_ADC3:   ADC3 clock
// 1402   *            @arg RCC_APB2Periph_SDIO:   SDIO clock
// 1403   *            @arg RCC_APB2Periph_SPI1:   SPI1 clock
// 1404   *            @arg RCC_APB2Periph_SYSCFG: SYSCFG clock
// 1405   *            @arg RCC_APB2Periph_TIM9:   TIM9 clock
// 1406   *            @arg RCC_APB2Periph_TIM10:  TIM10 clock
// 1407   *            @arg RCC_APB2Periph_TIM11:  TIM11 clock
// 1408   * @param  NewState: new state of the specified peripheral reset.
// 1409   *          This parameter can be: ENABLE or DISABLE.
// 1410   * @retval None
// 1411   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock36 Using cfiCommon0
        CFI Function RCC_APB2PeriphResetCmd
        THUMB
// 1412 void RCC_APB2PeriphResetCmd(uint32_t RCC_APB2Periph, FunctionalState NewState)
// 1413 {
// 1414   /* Check the parameters */
// 1415   assert_param(IS_RCC_APB2_RESET_PERIPH(RCC_APB2Periph));
// 1416   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1417   if (NewState != DISABLE)
RCC_APB2PeriphResetCmd:
        LDR.N    R2,??DataTable39_29  ;; 0x40023824
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1418   {
// 1419     RCC->APB2RSTR |= RCC_APB2Periph;
// 1420   }
// 1421   else
// 1422   {
// 1423     RCC->APB2RSTR &= ~RCC_APB2Periph;
        STR      R0,[R2, #+0]
// 1424   }
// 1425 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock36
// 1426 
// 1427 /**
// 1428   * @brief  Enables or disables the AHB1 peripheral clock during Low Power (Sleep) mode.
// 1429   * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
// 1430   *         power consumption.
// 1431   * @note   After wakeup from SLEEP mode, the peripheral clock is enabled again.
// 1432   * @note   By default, all peripheral clocks are enabled during SLEEP mode.
// 1433   * @param  RCC_AHBPeriph: specifies the AHB1 peripheral to gates its clock.
// 1434   *          This parameter can be any combination of the following values:
// 1435   *            @arg RCC_AHB1Periph_GPIOA:       GPIOA clock
// 1436   *            @arg RCC_AHB1Periph_GPIOB:       GPIOB clock 
// 1437   *            @arg RCC_AHB1Periph_GPIOC:       GPIOC clock
// 1438   *            @arg RCC_AHB1Periph_GPIOD:       GPIOD clock
// 1439   *            @arg RCC_AHB1Periph_GPIOE:       GPIOE clock
// 1440   *            @arg RCC_AHB1Periph_GPIOF:       GPIOF clock
// 1441   *            @arg RCC_AHB1Periph_GPIOG:       GPIOG clock
// 1442   *            @arg RCC_AHB1Periph_GPIOG:       GPIOG clock
// 1443   *            @arg RCC_AHB1Periph_GPIOI:       GPIOI clock
// 1444   *            @arg RCC_AHB1Periph_CRC:         CRC clock
// 1445   *            @arg RCC_AHB1Periph_BKPSRAM:     BKPSRAM interface clock
// 1446   *            @arg RCC_AHB1Periph_DMA1:        DMA1 clock
// 1447   *            @arg RCC_AHB1Periph_DMA2:        DMA2 clock
// 1448   *            @arg RCC_AHB1Periph_ETH_MAC:     Ethernet MAC clock
// 1449   *            @arg RCC_AHB1Periph_ETH_MAC_Tx:  Ethernet Transmission clock
// 1450   *            @arg RCC_AHB1Periph_ETH_MAC_Rx:  Ethernet Reception clock
// 1451   *            @arg RCC_AHB1Periph_ETH_MAC_PTP: Ethernet PTP clock
// 1452   *            @arg RCC_AHB1Periph_OTG_HS:      USB OTG HS clock
// 1453   *            @arg RCC_AHB1Periph_OTG_HS_ULPI: USB OTG HS ULPI clock
// 1454   * @param  NewState: new state of the specified peripheral clock.
// 1455   *          This parameter can be: ENABLE or DISABLE.
// 1456   * @retval None
// 1457   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock37 Using cfiCommon0
        CFI Function RCC_AHB1PeriphClockLPModeCmd
        THUMB
// 1458 void RCC_AHB1PeriphClockLPModeCmd(uint32_t RCC_AHB1Periph, FunctionalState NewState)
// 1459 {
// 1460   /* Check the parameters */
// 1461   assert_param(IS_RCC_AHB1_LPMODE_PERIPH(RCC_AHB1Periph));
// 1462   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1463   if (NewState != DISABLE)
RCC_AHB1PeriphClockLPModeCmd:
        LDR.N    R2,??DataTable39_30  ;; 0x40023850
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1464   {
// 1465     RCC->AHB1LPENR |= RCC_AHB1Periph;
// 1466   }
// 1467   else
// 1468   {
// 1469     RCC->AHB1LPENR &= ~RCC_AHB1Periph;
        STR      R0,[R2, #+0]
// 1470   }
// 1471 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock37
// 1472 
// 1473 /**
// 1474   * @brief  Enables or disables the AHB2 peripheral clock during Low Power (Sleep) mode.
// 1475   * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
// 1476   *           power consumption.
// 1477   * @note   After wakeup from SLEEP mode, the peripheral clock is enabled again.
// 1478   * @note   By default, all peripheral clocks are enabled during SLEEP mode.
// 1479   * @param  RCC_AHBPeriph: specifies the AHB2 peripheral to gates its clock.
// 1480   *          This parameter can be any combination of the following values:
// 1481   *            @arg RCC_AHB2Periph_DCMI:   DCMI clock
// 1482   *            @arg RCC_AHB2Periph_CRYP:   CRYP clock
// 1483   *            @arg RCC_AHB2Periph_HASH:   HASH clock
// 1484   *            @arg RCC_AHB2Periph_RNG:    RNG clock
// 1485   *            @arg RCC_AHB2Periph_OTG_FS: USB OTG FS clock  
// 1486   * @param  NewState: new state of the specified peripheral clock.
// 1487   *          This parameter can be: ENABLE or DISABLE.
// 1488   * @retval None
// 1489   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock38 Using cfiCommon0
        CFI Function RCC_AHB2PeriphClockLPModeCmd
        THUMB
// 1490 void RCC_AHB2PeriphClockLPModeCmd(uint32_t RCC_AHB2Periph, FunctionalState NewState)
// 1491 {
// 1492   /* Check the parameters */
// 1493   assert_param(IS_RCC_AHB2_PERIPH(RCC_AHB2Periph));
// 1494   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1495   if (NewState != DISABLE)
RCC_AHB2PeriphClockLPModeCmd:
        LDR.N    R2,??DataTable39_31  ;; 0x40023854
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1496   {
// 1497     RCC->AHB2LPENR |= RCC_AHB2Periph;
// 1498   }
// 1499   else
// 1500   {
// 1501     RCC->AHB2LPENR &= ~RCC_AHB2Periph;
        STR      R0,[R2, #+0]
// 1502   }
// 1503 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock38
// 1504 
// 1505 /**
// 1506   * @brief  Enables or disables the AHB3 peripheral clock during Low Power (Sleep) mode.
// 1507   * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
// 1508   *         power consumption.
// 1509   * @note   After wakeup from SLEEP mode, the peripheral clock is enabled again.
// 1510   * @note   By default, all peripheral clocks are enabled during SLEEP mode.
// 1511   * @param  RCC_AHBPeriph: specifies the AHB3 peripheral to gates its clock.
// 1512   *          This parameter must be: RCC_AHB3Periph_FSMC
// 1513   * @param  NewState: new state of the specified peripheral clock.
// 1514   *          This parameter can be: ENABLE or DISABLE.
// 1515   * @retval None
// 1516   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock39 Using cfiCommon0
        CFI Function RCC_AHB3PeriphClockLPModeCmd
        THUMB
// 1517 void RCC_AHB3PeriphClockLPModeCmd(uint32_t RCC_AHB3Periph, FunctionalState NewState)
// 1518 {
// 1519   /* Check the parameters */
// 1520   assert_param(IS_RCC_AHB3_PERIPH(RCC_AHB3Periph));
// 1521   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1522   if (NewState != DISABLE)
RCC_AHB3PeriphClockLPModeCmd:
        LDR.N    R2,??DataTable39_32  ;; 0x40023858
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1523   {
// 1524     RCC->AHB3LPENR |= RCC_AHB3Periph;
// 1525   }
// 1526   else
// 1527   {
// 1528     RCC->AHB3LPENR &= ~RCC_AHB3Periph;
        STR      R0,[R2, #+0]
// 1529   }
// 1530 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock39
// 1531 
// 1532 /**
// 1533   * @brief  Enables or disables the APB1 peripheral clock during Low Power (Sleep) mode.
// 1534   * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
// 1535   *         power consumption.
// 1536   * @note   After wakeup from SLEEP mode, the peripheral clock is enabled again.
// 1537   * @note   By default, all peripheral clocks are enabled during SLEEP mode.
// 1538   * @param  RCC_APB1Periph: specifies the APB1 peripheral to gates its clock.
// 1539   *          This parameter can be any combination of the following values:
// 1540   *            @arg RCC_APB1Periph_TIM2:   TIM2 clock
// 1541   *            @arg RCC_APB1Periph_TIM3:   TIM3 clock
// 1542   *            @arg RCC_APB1Periph_TIM4:   TIM4 clock
// 1543   *            @arg RCC_APB1Periph_TIM5:   TIM5 clock
// 1544   *            @arg RCC_APB1Periph_TIM6:   TIM6 clock
// 1545   *            @arg RCC_APB1Periph_TIM7:   TIM7 clock
// 1546   *            @arg RCC_APB1Periph_TIM12:  TIM12 clock
// 1547   *            @arg RCC_APB1Periph_TIM13:  TIM13 clock
// 1548   *            @arg RCC_APB1Periph_TIM14:  TIM14 clock
// 1549   *            @arg RCC_APB1Periph_WWDG:   WWDG clock
// 1550   *            @arg RCC_APB1Periph_SPI2:   SPI2 clock
// 1551   *            @arg RCC_APB1Periph_SPI3:   SPI3 clock
// 1552   *            @arg RCC_APB1Periph_USART2: USART2 clock
// 1553   *            @arg RCC_APB1Periph_USART3: USART3 clock
// 1554   *            @arg RCC_APB1Periph_UART4:  UART4 clock
// 1555   *            @arg RCC_APB1Periph_UART5:  UART5 clock
// 1556   *            @arg RCC_APB1Periph_I2C1:   I2C1 clock
// 1557   *            @arg RCC_APB1Periph_I2C2:   I2C2 clock
// 1558   *            @arg RCC_APB1Periph_I2C3:   I2C3 clock
// 1559   *            @arg RCC_APB1Periph_CAN1:   CAN1 clock
// 1560   *            @arg RCC_APB1Periph_CAN2:   CAN2 clock
// 1561   *            @arg RCC_APB1Periph_PWR:    PWR clock
// 1562   *            @arg RCC_APB1Periph_DAC:    DAC clock
// 1563   * @param  NewState: new state of the specified peripheral clock.
// 1564   *          This parameter can be: ENABLE or DISABLE.
// 1565   * @retval None
// 1566   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock40 Using cfiCommon0
        CFI Function RCC_APB1PeriphClockLPModeCmd
        THUMB
// 1567 void RCC_APB1PeriphClockLPModeCmd(uint32_t RCC_APB1Periph, FunctionalState NewState)
// 1568 {
// 1569   /* Check the parameters */
// 1570   assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
// 1571   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1572   if (NewState != DISABLE)
RCC_APB1PeriphClockLPModeCmd:
        LDR.N    R2,??DataTable39_33  ;; 0x40023860
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1573   {
// 1574     RCC->APB1LPENR |= RCC_APB1Periph;
// 1575   }
// 1576   else
// 1577   {
// 1578     RCC->APB1LPENR &= ~RCC_APB1Periph;
        STR      R0,[R2, #+0]
// 1579   }
// 1580 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock40
// 1581 
// 1582 /**
// 1583   * @brief  Enables or disables the APB2 peripheral clock during Low Power (Sleep) mode.
// 1584   * @note   Peripheral clock gating in SLEEP mode can be used to further reduce
// 1585   *         power consumption.
// 1586   * @note   After wakeup from SLEEP mode, the peripheral clock is enabled again.
// 1587   * @note   By default, all peripheral clocks are enabled during SLEEP mode.
// 1588   * @param  RCC_APB2Periph: specifies the APB2 peripheral to gates its clock.
// 1589   *          This parameter can be any combination of the following values:
// 1590   *            @arg RCC_APB2Periph_TIM1:   TIM1 clock
// 1591   *            @arg RCC_APB2Periph_TIM8:   TIM8 clock
// 1592   *            @arg RCC_APB2Periph_USART1: USART1 clock
// 1593   *            @arg RCC_APB2Periph_USART6: USART6 clock
// 1594   *            @arg RCC_APB2Periph_ADC1:   ADC1 clock
// 1595   *            @arg RCC_APB2Periph_ADC2:   ADC2 clock
// 1596   *            @arg RCC_APB2Periph_ADC3:   ADC3 clock
// 1597   *            @arg RCC_APB2Periph_SDIO:   SDIO clock
// 1598   *            @arg RCC_APB2Periph_SPI1:   SPI1 clock
// 1599   *            @arg RCC_APB2Periph_SYSCFG: SYSCFG clock
// 1600   *            @arg RCC_APB2Periph_TIM9:   TIM9 clock
// 1601   *            @arg RCC_APB2Periph_TIM10:  TIM10 clock
// 1602   *            @arg RCC_APB2Periph_TIM11:  TIM11 clock
// 1603   * @param  NewState: new state of the specified peripheral clock.
// 1604   *          This parameter can be: ENABLE or DISABLE.
// 1605   * @retval None
// 1606   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock41 Using cfiCommon0
        CFI Function RCC_APB2PeriphClockLPModeCmd
        THUMB
// 1607 void RCC_APB2PeriphClockLPModeCmd(uint32_t RCC_APB2Periph, FunctionalState NewState)
// 1608 {
// 1609   /* Check the parameters */
// 1610   assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
// 1611   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1612   if (NewState != DISABLE)
RCC_APB2PeriphClockLPModeCmd:
        LDR.N    R2,??DataTable39_34  ;; 0x40023864
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1613   {
// 1614     RCC->APB2LPENR |= RCC_APB2Periph;
// 1615   }
// 1616   else
// 1617   {
// 1618     RCC->APB2LPENR &= ~RCC_APB2Periph;
        STR      R0,[R2, #+0]
// 1619   }
// 1620 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock41
// 1621 
// 1622 /**
// 1623   * @}
// 1624   */
// 1625 
// 1626 /** @defgroup RCC_Group4 Interrupts and flags management functions
// 1627  *  @brief   Interrupts and flags management functions 
// 1628  *
// 1629 @verbatim   
// 1630  ===============================================================================
// 1631                    Interrupts and flags management functions
// 1632  ===============================================================================  
// 1633 
// 1634 @endverbatim
// 1635   * @{
// 1636   */
// 1637 
// 1638 /**
// 1639   * @brief  Enables or disables the specified RCC interrupts.
// 1640   * @param  RCC_IT: specifies the RCC interrupt sources to be enabled or disabled.
// 1641   *          This parameter can be any combination of the following values:
// 1642   *            @arg RCC_IT_LSIRDY: LSI ready interrupt
// 1643   *            @arg RCC_IT_LSERDY: LSE ready interrupt
// 1644   *            @arg RCC_IT_HSIRDY: HSI ready interrupt
// 1645   *            @arg RCC_IT_HSERDY: HSE ready interrupt
// 1646   *            @arg RCC_IT_PLLRDY: main PLL ready interrupt
// 1647   *            @arg RCC_IT_PLLI2SRDY: PLLI2S ready interrupt  
// 1648   * @param  NewState: new state of the specified RCC interrupts.
// 1649   *          This parameter can be: ENABLE or DISABLE.
// 1650   * @retval None
// 1651   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock42 Using cfiCommon0
        CFI Function RCC_ITConfig
        THUMB
// 1652 void RCC_ITConfig(uint8_t RCC_IT, FunctionalState NewState)
// 1653 {
// 1654   /* Check the parameters */
// 1655   assert_param(IS_RCC_IT(RCC_IT));
// 1656   assert_param(IS_FUNCTIONAL_STATE(NewState));
// 1657   if (NewState != DISABLE)
RCC_ITConfig:
        LDR.N    R2,??DataTable39_35  ;; 0x4002380d
        CMP      R1,#+0
        LDRB     R1,[R2, #+0]
        ITE      NE 
        ORRNE    R0,R0,R1
        BICEQ    R0,R1,R0
// 1658   {
// 1659     /* Perform Byte access to RCC_CIR[14:8] bits to enable the selected interrupts */
// 1660     *(__IO uint8_t *) CIR_BYTE2_ADDRESS |= RCC_IT;
// 1661   }
// 1662   else
// 1663   {
// 1664     /* Perform Byte access to RCC_CIR[14:8] bits to disable the selected interrupts */
// 1665     *(__IO uint8_t *) CIR_BYTE2_ADDRESS &= (uint8_t)~RCC_IT;
        STRB     R0,[R2, #+0]
// 1666   }
// 1667 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock42
// 1668 
// 1669 /**
// 1670   * @brief  Checks whether the specified RCC flag is set or not.
// 1671   * @param  RCC_FLAG: specifies the flag to check.
// 1672   *          This parameter can be one of the following values:
// 1673   *            @arg RCC_FLAG_HSIRDY: HSI oscillator clock ready
// 1674   *            @arg RCC_FLAG_HSERDY: HSE oscillator clock ready
// 1675   *            @arg RCC_FLAG_PLLRDY: main PLL clock ready
// 1676   *            @arg RCC_FLAG_PLLI2SRDY: PLLI2S clock ready
// 1677   *            @arg RCC_FLAG_LSERDY: LSE oscillator clock ready
// 1678   *            @arg RCC_FLAG_LSIRDY: LSI oscillator clock ready
// 1679   *            @arg RCC_FLAG_BORRST: POR/PDR or BOR reset
// 1680   *            @arg RCC_FLAG_PINRST: Pin reset
// 1681   *            @arg RCC_FLAG_PORRST: POR/PDR reset
// 1682   *            @arg RCC_FLAG_SFTRST: Software reset
// 1683   *            @arg RCC_FLAG_IWDGRST: Independent Watchdog reset
// 1684   *            @arg RCC_FLAG_WWDGRST: Window Watchdog reset
// 1685   *            @arg RCC_FLAG_LPWRRST: Low Power reset
// 1686   * @retval The new state of RCC_FLAG (SET or RESET).
// 1687   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock43 Using cfiCommon0
        CFI Function RCC_GetFlagStatus
        THUMB
// 1688 FlagStatus RCC_GetFlagStatus(uint8_t RCC_FLAG)
// 1689 {
// 1690   uint32_t tmp = 0;
// 1691   uint32_t statusreg = 0;
// 1692   FlagStatus bitstatus = RESET;
RCC_GetFlagStatus:
        MOVS     R1,#+0
// 1693 
// 1694   /* Check the parameters */
// 1695   assert_param(IS_RCC_FLAG(RCC_FLAG));
// 1696 
// 1697   /* Get the RCC register index */
// 1698   tmp = RCC_FLAG >> 5;
        LSRS     R2,R0,#+5
// 1699   if (tmp == 1)               /* The flag to check is in CR register */
        LDR.N    R3,??DataTable39  ;; 0x40023800
        CMP      R2,#+1
        IT       EQ 
        LDREQ    R2,[R3, #+0]
// 1700   {
// 1701     statusreg = RCC->CR;
        BEQ.N    ??RCC_GetFlagStatus_0
// 1702   }
// 1703   else if (tmp == 2)          /* The flag to check is in BDCR register */
        CMP      R2,#+2
        ITE      EQ 
        LDREQ    R2,[R3, #+112]
        LDRNE    R2,[R3, #+116]
// 1704   {
// 1705     statusreg = RCC->BDCR;
// 1706   }
// 1707   else                       /* The flag to check is in CSR register */
// 1708   {
// 1709     statusreg = RCC->CSR;
// 1710   }
// 1711 
// 1712   /* Get the flag position */
// 1713   tmp = RCC_FLAG & FLAG_MASK;
// 1714   if ((statusreg & ((uint32_t)1 << tmp)) != (uint32_t)RESET)
??RCC_GetFlagStatus_0:
        MOVS     R3,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R3,R0
        TST      R2,R0
        IT       NE 
        MOVNE    R1,#+1
// 1715   {
// 1716     bitstatus = SET;
// 1717   }
// 1718   else
// 1719   {
// 1720     bitstatus = RESET;
// 1721   }
// 1722   /* Return the flag status */
// 1723   return bitstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock43
// 1724 }
// 1725 
// 1726 /**
// 1727   * @brief  Clears the RCC reset flags.
// 1728   *         The reset flags are: RCC_FLAG_PINRST, RCC_FLAG_PORRST,  RCC_FLAG_SFTRST,
// 1729   *         RCC_FLAG_IWDGRST, RCC_FLAG_WWDGRST, RCC_FLAG_LPWRRST
// 1730   * @param  None
// 1731   * @retval None
// 1732   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock44 Using cfiCommon0
        CFI Function RCC_ClearFlag
        THUMB
// 1733 void RCC_ClearFlag(void)
// 1734 {
// 1735   /* Set RMVF bit to clear the reset flags */
// 1736   RCC->CSR |= RCC_CSR_RMVF;
RCC_ClearFlag:
        LDR.N    R0,??DataTable39_36  ;; 0x40023874
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1000000
        STR      R1,[R0, #+0]
// 1737 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock44
// 1738 
// 1739 /**
// 1740   * @brief  Checks whether the specified RCC interrupt has occurred or not.
// 1741   * @param  RCC_IT: specifies the RCC interrupt source to check.
// 1742   *          This parameter can be one of the following values:
// 1743   *            @arg RCC_IT_LSIRDY: LSI ready interrupt
// 1744   *            @arg RCC_IT_LSERDY: LSE ready interrupt
// 1745   *            @arg RCC_IT_HSIRDY: HSI ready interrupt
// 1746   *            @arg RCC_IT_HSERDY: HSE ready interrupt
// 1747   *            @arg RCC_IT_PLLRDY: main PLL ready interrupt
// 1748   *            @arg RCC_IT_PLLI2SRDY: PLLI2S ready interrupt  
// 1749   *            @arg RCC_IT_CSS: Clock Security System interrupt
// 1750   * @retval The new state of RCC_IT (SET or RESET).
// 1751   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock45 Using cfiCommon0
        CFI Function RCC_GetITStatus
        THUMB
// 1752 ITStatus RCC_GetITStatus(uint8_t RCC_IT)
// 1753 {
// 1754   ITStatus bitstatus = RESET;
RCC_GetITStatus:
        MOVS     R1,#+0
// 1755 
// 1756   /* Check the parameters */
// 1757   assert_param(IS_RCC_GET_IT(RCC_IT));
// 1758 
// 1759   /* Check the status of the specified RCC interrupt */
// 1760   if ((RCC->CIR & RCC_IT) != (uint32_t)RESET)
        LDR.N    R2,??DataTable39_37  ;; 0x4002380c
        LDR      R2,[R2, #+0]
        UXTB     R2,R2
        TST      R2,R0
        IT       NE 
        MOVNE    R1,#+1
// 1761   {
// 1762     bitstatus = SET;
// 1763   }
// 1764   else
// 1765   {
// 1766     bitstatus = RESET;
// 1767   }
// 1768   /* Return the RCC_IT status */
// 1769   return  bitstatus;
        MOV      R0,R1
        BX       LR               ;; return
        CFI EndBlock cfiBlock45
// 1770 }
// 1771 
// 1772 /**
// 1773   * @brief  Clears the RCC's interrupt pending bits.
// 1774   * @param  RCC_IT: specifies the interrupt pending bit to clear.
// 1775   *          This parameter can be any combination of the following values:
// 1776   *            @arg RCC_IT_LSIRDY: LSI ready interrupt
// 1777   *            @arg RCC_IT_LSERDY: LSE ready interrupt
// 1778   *            @arg RCC_IT_HSIRDY: HSI ready interrupt
// 1779   *            @arg RCC_IT_HSERDY: HSE ready interrupt
// 1780   *            @arg RCC_IT_PLLRDY: main PLL ready interrupt
// 1781   *            @arg RCC_IT_PLLI2SRDY: PLLI2S ready interrupt  
// 1782   *            @arg RCC_IT_CSS: Clock Security System interrupt
// 1783   * @retval None
// 1784   */

        SECTION `.text`:CODE:NOROOT(1)
        CFI Block cfiBlock46 Using cfiCommon0
        CFI Function RCC_ClearITPendingBit
        THUMB
// 1785 void RCC_ClearITPendingBit(uint8_t RCC_IT)
// 1786 {
// 1787   /* Check the parameters */
// 1788   assert_param(IS_RCC_CLEAR_IT(RCC_IT));
// 1789 
// 1790   /* Perform Byte access to RCC_CIR[23:16] bits to clear the selected interrupt
// 1791      pending bits */
// 1792   *(__IO uint8_t *) CIR_BYTE3_ADDRESS = RCC_IT;
RCC_ClearITPendingBit:
        LDR.N    R1,??DataTable39_38  ;; 0x4002380e
        STRB     R0,[R1, #+0]
// 1793 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock46

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39:
        DC32     0x40023800

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_1:
        DC32     0xfef6ffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_2:
        DC32     0x24003010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_3:
        DC32     0x40023802

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_4:
        DC32     0x42470000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_5:
        DC32     0x40023870

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_6:
        DC32     0x42470e80

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_7:
        DC32     0x40023804

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_8:
        DC32     0x42470060

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_9:
        DC32     0x40023884

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_10:
        DC32     0x42470068

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_11:
        DC32     0x4247004c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_12:
        DC32     0x40023808

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_13:
        DC32     0xf42400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_14:
        DC32     0x17d7840

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_15:
        DC32     APBAHBPrescTable

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_16:
        DC32     0xffffcff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_17:
        DC32     0x42470e3c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_18:
        DC32     0x42470e40

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_19:
        DC32     0x4247015c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_20:
        DC32     0x40023830

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_21:
        DC32     0x40023834

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_22:
        DC32     0x40023838

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_23:
        DC32     0x40023840

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_24:
        DC32     0x40023844

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_25:
        DC32     0x40023810

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_26:
        DC32     0x40023814

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_27:
        DC32     0x40023818

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_28:
        DC32     0x40023820

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_29:
        DC32     0x40023824

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_30:
        DC32     0x40023850

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_31:
        DC32     0x40023854

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_32:
        DC32     0x40023858

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_33:
        DC32     0x40023860

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_34:
        DC32     0x40023864

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_35:
        DC32     0x4002380d

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_36:
        DC32     0x40023874

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_37:
        DC32     0x4002380c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable39_38:
        DC32     0x4002380e

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 1794 
// 1795 /**
// 1796   * @}
// 1797   */ 
// 1798 
// 1799 /**
// 1800   * @}
// 1801   */ 
// 1802 
// 1803 /**
// 1804   * @}
// 1805   */ 
// 1806 
// 1807 /**
// 1808   * @}
// 1809   */ 
// 1810 
// 1811 /******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
// 
//    16 bytes in section .data
// 1 006 bytes in section .text
// 
// 1 006 bytes of CODE memory
//    16 bytes of DATA memory
//
//Errors: none
//Warnings: none
