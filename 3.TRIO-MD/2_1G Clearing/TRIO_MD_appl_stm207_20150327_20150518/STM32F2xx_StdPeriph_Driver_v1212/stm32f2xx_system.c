/**
  ******************************************************************************
  * @file    system_stm32f2xx.c
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    18-April-2011
  * @brief   CMSIS Cortex-M3 Device Peripheral Access Layer System Source File.
  *          This file contains the system clock configuration for STM32F2xx devices,
  *          and is generated by the clock configuration tool
  *          "STM32f2xx_Clock_Configuration_V1.0.0.xls"
  *             
  * 1.  This file provides two functions and one global variable to be called from 
  *     user application:
  *      - SystemInit(): Setups the system clock (System clock source, PLL Multiplier
  *                      and Divider factors, AHB/APBx prescalers and Flash settings),
  *                      depending on the configuration made in the clock xls tool. 
  *                      This function is called at startup just after reset and 
  *                      before branch to main program. This call is made inside
  *                      the "startup_stm32f2xx.s" file.
  *
  *      - SystemCoreClock variable: Contains the core clock (HCLK), it can be used
  *                                  by the user application to setup the SysTick 
  *                                  timer or configure other parameters.
  *                                     
  *      - SystemCoreClockUpdate(): Updates the variable SystemCoreClock and must
  *                                 be called whenever the core clock is changed
  *                                 during program execution.
  *
  * 2. After each device reset the HSI (16 MHz) is used as system clock source.
  *    Then SystemInit() function is called, in "startup_stm32f2xx.s" file, to
  *    configure the system clock before to branch to main program.
  *
  * 3. If the system clock source selected by user fails to startup, the SystemInit()
  *    function will do nothing and HSI still used as system clock source. User can 
  *    add some code to deal with this issue inside the SetSysClock() function.
  *
  * 4. The default value of HSE crystal is set to 25MHz, refer to "HSE_VALUE" define
  *    in "stm32f2xx.h" file. When HSE is used as system clock source, directly or
  *    through PLL, and you are using different crystal you have to adapt the HSE
  *    value to your own configuration.
  *
  * 5. This file configures the system clock as follows:
  *=============================================================================
  *=============================================================================
  *        Supported STM32F2xx device revision    | Rev B and Y
  *-----------------------------------------------------------------------------
  *        System Clock source                    | PLL (HSE)
  *-----------------------------------------------------------------------------
  *        SYSCLK(Hz)                             | 120000000
  *-----------------------------------------------------------------------------
  *        HCLK(Hz)                               | 120000000
  *-----------------------------------------------------------------------------
  *        AHB Prescaler                          | 1
  *-----------------------------------------------------------------------------
  *        APB1 Prescaler                         | 4
  *-----------------------------------------------------------------------------
  *        APB2 Prescaler                         | 2
  *-----------------------------------------------------------------------------
  *        HSE Frequency(Hz)                      | 25000000
  *-----------------------------------------------------------------------------
  *        PLL_M                                  | 25
  *-----------------------------------------------------------------------------
  *        PLL_N                                  | 240
  *-----------------------------------------------------------------------------
  *        PLL_P                                  | 2
  *-----------------------------------------------------------------------------
  *        PLL_Q                                  | 5
  *-----------------------------------------------------------------------------
  *        PLLI2S_N                               | NA
  *-----------------------------------------------------------------------------
  *        PLLI2S_R                               | NA
  *-----------------------------------------------------------------------------
  *        I2S input clock                        | NA
  *-----------------------------------------------------------------------------
  *        VDD(V)                                 | 3.3
  *-----------------------------------------------------------------------------
  *        Flash Latency(WS)                      | 3
  *-----------------------------------------------------------------------------
  *        Prefetch Buffer                        | ON
  *-----------------------------------------------------------------------------
  *        Instruction cache                      | ON
  *-----------------------------------------------------------------------------
  *        Data cache                             | ON
  *-----------------------------------------------------------------------------
  *        Require 48MHz for USB OTG FS,          | Enabled
  *        SDIO and RNG clock                     |
  *-----------------------------------------------------------------------------
  *=============================================================================
  ****************************************************************************** 
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************  
  */

/** @addtogroup CMSIS
  * @{
  */

/** @addtogroup stm32f2xx_system
  * @{
  */  
  
/** @addtogroup STM32F2xx_System_Private_Includes
  * @{
  */
#include "stm32f2xx_1212.h"
/**
  * @}
  */

/** @addtogroup STM32F2xx_System_Private_TypesDefinitions
  * @{
  */

/**
  * @}
  */

/** @addtogroup STM32F2xx_System_Private_Defines
  * @{
  */

/*!< Uncomment the following line if you need to use external SRAM mounted
     on STM322xG_EVAL board as data memory  */
/* #define DATA_IN_ExtSRAM */

/**
  * @}
  */

/** @addtogroup STM32F2xx_System_Private_Macros
  * @{
  */

/**
  * @}
  */

/** @addtogroup STM32F2xx_System_Private_Variables
  * @{
  */

  uint32_t SystemCoreClock = 120000000;

  __I uint8_t AHBPrescTable[16] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 6, 7, 8, 9};

/**
  * @}
  */



/** @addtogroup STM32F2xx_System_Private_Functions
  * @{
  */

/**
  * @brief  Setup the microcontroller system
  *         Initialize the Embedded Flash Interface, the PLL and update the 
  *         SystemFrequency variable.
  * @param  None
  * @retval None
  */

void SystemInit(void)
{
	/* Reset the RCC clock configuration to the default reset state ------------*/
	/* Set HSION bit */
	/* Reset HSEON, CSSON and PLLON bits */
	RCC->CR &= (uint32_t)0xFEF6FFFF;

	/* Reset PLLCFGR register */
	RCC->PLLCFGR = 0x24003010;

	/* Reset HSEBYP bit */
	RCC->CR &= (uint32_t)0xFFFBFFFF;

	/* Disable all interrupts */
	RCC->CIR = 0x00000000;

#ifdef DATA_IN_ExtSRAM
  	SystemInit_ExtMemCtl(); 
#endif /* DATA_IN_ExtSRAM */
	/* Configure the System clock source, PLL Multiplier and Divider factors, 
    	AHB/APBx prescalers and Flash settings ----------------------------------*/
#ifdef OS_INCLUDED
	SetSysClock(TRUE);//SetSysClock(TRUE);
#else
	SetSysClock(FALSE);
#endif /* OS_INCLUDED */
  	/* Configure the Vector Table location add offset address ------------------*/
#ifdef VECT_TAB_SRAM
	SCB->VTOR = SRAM_BASE | VECT_TAB_OFFSET; 	/* Vector Table Relocation in Internal SRAM */
#else
	#ifndef OS_INCLUDED
		SCB->VTOR = FLASH_BASE | VECT_TAB_OFFSET; 	/* Vector Table Relocation in Internal FLASH */
	#else
		__iar_program_start();
	#endif /* OS_INCLUDED */
#endif /* VECT_TAB_SRAM */

}

/**
  * @brief  Update SystemCoreClock variable according to Clock Register Values.
  *         The SystemCoreClock variable contains the core clock (HCLK), it can
  *         be used by the user application to setup the SysTick timer or configure
  *         other parameters.
  *           
  * @note   Each time the core clock (HCLK) changes, this function must be called
  *         to update SystemCoreClock variable value. Otherwise, any configuration
  *         based on this variable will be incorrect.         
  *     
  * @note   - The system frequency computed by this function is not the real 
  *           frequency in the chip. It is calculated based on the predefined 
  *           constant and the selected clock source:
  *             
  *           - If SYSCLK source is HSI, SystemCoreClock will contain the HSI_VALUE(*)
  *                                              
  *           - If SYSCLK source is HSE, SystemCoreClock will contain the HSE_VALUE(**)
  *                          
  *           - If SYSCLK source is PLL, SystemCoreClock will contain the HSE_VALUE(**) 
  *             or HSI_VALUE(*) multiplied/divided by the PLL factors.
  *         
  *         (*) HSI_VALUE is a constant defined in stm32f2xx.h file (default value
  *             16 MHz) but the real value may vary depending on the variations
  *             in voltage and temperature.   
  *    
  *         (**) HSE_VALUE is a constant defined in stm32f2xx.h file (default value
  *              25 MHz), user has to ensure that HSE_VALUE is same as the real
  *              frequency of the crystal used. Otherwise, this function may
  *              have wrong result.
  *                
  *         - The result of this function could be not correct when using fractional
  *           value for HSE crystal.
  *     
  * @param  None
  * @retval None
  */
void SystemCoreClockUpdate(void)
{
	uint32_t tmp = 0, pllvco = 0, pllp = 2, pllsource = 0, pllm = 2;
  
	/* Get SYSCLK source -------------------------------------------------------*/
	tmp = RCC->CFGR & RCC_CFGR_SWS;

	switch (tmp)
	{
		case 0x00:  /* HSI used as system clock source */
		  SystemCoreClock = HSI_VALUE;
		  break;
		case 0x04:  /* HSE used as system clock source */
		  SystemCoreClock = HSE_VALUE;
		  break;
		case 0x08:  /* PLL used as system clock source */

		  /* PLL_VCO = (HSE_VALUE or HSI_VALUE / PLL_M) * PLL_N
		     SYSCLK = PLL_VCO / PLL_P
		     */    
		  pllsource = (RCC->PLLCFGR & RCC_PLLCFGR_PLLSRC) >> 22;
		  pllm = RCC->PLLCFGR & RCC_PLLCFGR_PLLM;
		  
		  if (pllsource != 0)
		  {
		    /* HSE used as PLL clock source */
		    pllvco = (HSE_VALUE / pllm) * ((RCC->PLLCFGR & RCC_PLLCFGR_PLLN) >> 6);
		  }
		  else
		  {
		    /* HSI used as PLL clock source */
		    pllvco = (HSI_VALUE / pllm) * ((RCC->PLLCFGR & RCC_PLLCFGR_PLLN) >> 6);      
		  }

		  pllp = (((RCC->PLLCFGR & RCC_PLLCFGR_PLLP) >>16) + 1 ) *2;
		  SystemCoreClock = pllvco/pllp;
		  break;
		default:
		  SystemCoreClock = HSI_VALUE;
		  break;
	}
	/* Compute HCLK frequency --------------------------------------------------*/
	/* Get HCLK prescaler */
	tmp = AHBPrescTable[((RCC->CFGR & RCC_CFGR_HPRE) >> 4)];
	/* HCLK frequency */
	SystemCoreClock >>= tmp;
}

/**
  * @brief  Configures the System clock source, PLL Multiplier and Divider factors, 
  *         AHB/APBx prescalers and Flash settings
  * @Note   This function should be called only once the RCC clock configuration  
  *         is reset to the default reset state (done in SystemInit() function).   
  * @param  None
  * @retval None
  */
u8 SetSysClock(u8 IsItHSE)
{
/******************************************************************************/
/*            PLL (clocked by HSE) used as System clock source                */
/******************************************************************************/
	__IO uint32_t StartUpCounter = 0, HSEStatus = 0x01;

	vu32 PLLM = 0;
	
  	/* Enable HSE */
	if(IsItHSE)
	{
		RCC->CR |= ((uint32_t)RCC_CR_HSEON);

		/* Wait till HSE is ready and if Time out is reached exit */
		do
		{
			HSEStatus = RCC->CR & RCC_CR_HSERDY;
			StartUpCounter++;
		} while((HSEStatus == 0) && (StartUpCounter != HSE_STARTUP_TIMEOUT));

		if ((RCC->CR & RCC_CR_HSERDY) != RESET)	IsItHSE = SET;
		else									IsItHSE = RESET;
	}
	else{

	}

	if(IsItHSE)
	{
		PLLM = HSE_VALUE/1000000;

	}
	else
	{
		PLLM = HSI_VALUE/1000000;
	}

	{
	    /* HCLK = SYSCLK / 1*/
	    RCC->CFGR |= RCC_CFGR_HPRE_DIV1;
	      
	    /* PCLK2 = HCLK / 2*/
	    RCC->CFGR |= RCC_CFGR_PPRE2_DIV2;
	    
	    /* PCLK1 = HCLK / 4*/
	    RCC->CFGR |= RCC_CFGR_PPRE1_DIV4;

	    /* Configure the main PLL */
	    RCC->__B.PLLCFGR.PLLP = (PLL_P >> 1)-1;
	    RCC->__B.PLLCFGR.PLLM = PLLM;
	    RCC->__B.PLLCFGR.PLLN = PLL_N;
	    RCC->__B.PLLCFGR.PLLQ = PLL_Q;
	    RCC->__B.PLLCFGR.PLLSRC = IsItHSE;

	    /* Enable the main PLL */
	    RCC->CR |= RCC_CR_PLLON;

	    /* Wait till the main PLL is ready */
	    while((RCC->CR & RCC_CR_PLLRDY) == 0)
	    {
	    }
	   
	    /* Configure Flash prefetch, Instruction cache, Data cache and wait state */
	    FLASH->ACR = FLASH_ACR_PRFTEN | FLASH_ACR_ICEN | FLASH_ACR_DCEN | FLASH_ACR_LATENCY_3WS;

	    /* Select the main PLL as system clock source */
	    RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_SW));
	    RCC->CFGR |= RCC_CFGR_SW_PLL;

	    /* Wait till the main PLL is used as system clock source */
	    while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS ) != RCC_CFGR_SWS_PLL);
	    {

	    }
	}
	/* LSI ON to use watchdog */
	RCC->__B.CSR.LSION = ENABLE;
	/* Wait till LSI is ready */
	while(!RCC->__B.CSR.LSIRDY){};

    return IsItHSE;
}
#if 0

/**
  * @brief  Setup the external memory controller. Called in startup_stm32f2xx.s
  *         before jump to __main
  * @param  None
  * @retval None
  */
#ifdef DATA_IN_ExtSRAM
/**
  * @brief  Setup the external memory controller.
  *         Called in startup_stm32f2xx.s before jump to main.
  *         This function configures the external SRAM mounted on STM322xG_EVAL board
  *         This SRAM will be used as program data memory (including heap and stack).
  * @param  None
  * @retval None
  */
void SystemInit_ExtMemCtl(void)
{
/*-- GPIOs Configuration -----------------------------------------------------*/
/*
 +-------------------+--------------------+------------------+------------------+
 +                       SRAM pins assignment                                  +
 +-------------------+--------------------+------------------+------------------+
 | PD0  <-> FSMC_D2  | PE0  <-> FSMC_NBL0 | PF0  <-> FSMC_A0 | PG0 <-> FSMC_A10 |
 | PD1  <-> FSMC_D3  | PE1  <-> FSMC_NBL1 | PF1  <-> FSMC_A1 | PG1 <-> FSMC_A11 |
 | PD4  <-> FSMC_NOE | PE7  <-> FSMC_D4   | PF2  <-> FSMC_A2 | PG2 <-> FSMC_A12 |
 | PD5  <-> FSMC_NWE | PE8  <-> FSMC_D5   | PF3  <-> FSMC_A3 | PG3 <-> FSMC_A13 |
 | PD8  <-> FSMC_D13 | PE9  <-> FSMC_D6   | PF4  <-> FSMC_A4 | PG4 <-> FSMC_A14 |
 | PD9  <-> FSMC_D14 | PE10 <-> FSMC_D7   | PF5  <-> FSMC_A5 | PG5 <-> FSMC_A15 |
 | PD10 <-> FSMC_D15 | PE11 <-> FSMC_D8   | PF12 <-> FSMC_A6 | PG9 <-> FSMC_NE2 |
 | PD11 <-> FSMC_A16 | PE12 <-> FSMC_D9   | PF13 <-> FSMC_A7 |------------------+
 | PD12 <-> FSMC_A17 | PE13 <-> FSMC_D10  | PF14 <-> FSMC_A8 | 
 | PD14 <-> FSMC_D0  | PE14 <-> FSMC_D11  | PF15 <-> FSMC_A9 | 
 | PD15 <-> FSMC_D1  | PE15 <-> FSMC_D12  |------------------+
 +-------------------+--------------------+
*/
   /* Enable GPIOD, GPIOE, GPIOF and GPIOG interface clock */
  RCC->AHB1ENR   = 0x00000078;
  
  /* Connect PDx pins to FSMC Alternate function */
  GPIOD->AFR[0]  = 0x00cc00cc;
  GPIOD->AFR[1]  = 0xcc0ccccc;
  /* Configure PDx pins in Alternate function mode */  
  GPIOD->MODER   = 0xa2aa0a0a;
  /* Configure PDx pins speed to 100 MHz */  
  GPIOD->OSPEEDR = 0xf3ff0f0f;
  /* Configure PDx pins Output type to push-pull */  
  GPIOD->OTYPER  = 0x00000000;
  /* No pull-up, pull-down for PDx pins */ 
  GPIOD->PUPDR   = 0x00000000;

  /* Connect PEx pins to FSMC Alternate function */
  GPIOE->AFR[0]  = 0xc00000cc;
  GPIOE->AFR[1]  = 0xcccccccc;
  /* Configure PEx pins in Alternate function mode */ 
  GPIOE->MODER   = 0xaaaa800a;
  /* Configure PEx pins speed to 100 MHz */ 
  GPIOE->OSPEEDR = 0xffffc00f;
  /* Configure PEx pins Output type to push-pull */  
  GPIOE->OTYPER  = 0x00000000;
  /* No pull-up, pull-down for PEx pins */ 
  GPIOE->PUPDR   = 0x00000000;

  /* Connect PFx pins to FSMC Alternate function */
  GPIOF->AFR[0]  = 0x00cccccc;
  GPIOF->AFR[1]  = 0xcccc0000;
  /* Configure PFx pins in Alternate function mode */   
  GPIOF->MODER   = 0xaa000aaa;
  /* Configure PFx pins speed to 100 MHz */ 
  GPIOF->OSPEEDR = 0xff000fff;
  /* Configure PFx pins Output type to push-pull */  
  GPIOF->OTYPER  = 0x00000000;
  /* No pull-up, pull-down for PFx pins */ 
  GPIOF->PUPDR   = 0x00000000;

  /* Connect PGx pins to FSMC Alternate function */
  GPIOG->AFR[0]  = 0x00cccccc;
  GPIOG->AFR[1]  = 0x000000c0;
  /* Configure PGx pins in Alternate function mode */ 
  GPIOG->MODER   = 0x00080aaa;
  /* Configure PGx pins speed to 100 MHz */ 
  GPIOG->OSPEEDR = 0x000c0fff;
  /* Configure PGx pins Output type to push-pull */  
  GPIOG->OTYPER  = 0x00000000;
  /* No pull-up, pull-down for PGx pins */ 
  GPIOG->PUPDR   = 0x00000000;
  
/*-- FSMC Configuration ------------------------------------------------------*/
  /* Enable the FSMC interface clock */
  RCC->AHB3ENR         = 0x00000001;

  /* Configure and enable Bank1_SRAM2 */
  FSMC_Bank1->BTCR[2]  = 0x00001015;
  FSMC_Bank1->BTCR[3]  = 0x00010400;
  FSMC_Bank1E->BWTR[2] = 0x0fffffff;
/*
  Bank1_SRAM2 is configured as follow:

  p.FSMC_AddressSetupTime = 0;
  p.FSMC_AddressHoldTime = 0;
  p.FSMC_DataSetupTime = 4;
  p.FSMC_BusTurnAroundDuration = 1;
  p.FSMC_CLKDivision = 0;
  p.FSMC_DataLatency = 0;
  p.FSMC_AccessMode = FSMC_AccessMode_A;

  FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM2;
  FSMC_NORSRAMInitStructure.FSMC_DataAddressMux = FSMC_DataAddressMux_Disable;
  FSMC_NORSRAMInitStructure.FSMC_MemoryType = FSMC_MemoryType_PSRAM;
  FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_16b;
  FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_AsynchronousWait = FSMC_AsynchronousWait_Disable;  
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
  FSMC_NORSRAMInitStructure.FSMC_WrapMode = FSMC_WrapMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
  FSMC_NORSRAMInitStructure.FSMC_WriteOperation = FSMC_WriteOperation_Enable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignal = FSMC_WaitSignal_Disable;
  FSMC_NORSRAMInitStructure.FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WriteBurst = FSMC_WriteBurst_Disable;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct = &p;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct = &p;
*/
  
}
#endif /* DATA_IN_ExtSRAM */

#endif

//#ifdef DATA_IN_ExtSRAM
/**
  * @brief  Setup the external memory controller.
  *         Called in startup_stm32f2xx.s before jump to main.
  *         This function configures the external SRAM mounted on STM322xG_EVAL board
  *         This SRAM will be used as program data memory (including heap and stack).
  * @param  None
  * @retval None
  */
void SystemInit_ExtMemCtl(void)
{
	RCC_TypeDef *pRCC = RCC;
	
	/*-- GPIOs Configuration -----------------------------------------------------*/
	/*
	 +-------------------+--------------------+------------------+------------------+
	 +                       SRAM pins assignment                                  +
	 +-------------------+--------------------+------------------+------------------+
	 | PD0  <-> FSMC_D2  | PE0  <-> FSMC_NBL0 | PF0  <-> FSMC_A0 | PG0 <-> FSMC_A10 |
	 | PD1  <-> FSMC_D3  | PE1  <-> FSMC_NBL1 | PF1  <-> FSMC_A1 | PG1 <-> FSMC_A11 |
	 | PD4  <-> FSMC_NOE | PE7  <-> FSMC_D4   | PF2  <-> FSMC_A2 | PG2 <-> FSMC_A12 |
	 | PD5  <-> FSMC_NWE | PE8  <-> FSMC_D5   | PF3  <-> FSMC_A3 | PG3 <-> FSMC_A13 |
	 | PD7  <-> FSMC_NE1
	 | PD8  <-> FSMC_D13 | PE9  <-> FSMC_D6   | PF4  <-> FSMC_A4 | PG4 <-> FSMC_A14 |
	 | PD9  <-> FSMC_D14 | PE10 <-> FSMC_D7   | PF5  <-> FSMC_A5 | PG5 <-> FSMC_A15 |
	 | PD10 <-> FSMC_D15 | PE11 <-> FSMC_D8   | PF12 <-> FSMC_A6 | PG9 <-> FSMC_NE2 |
	 | PD11 <-> FSMC_A16 | PE12 <-> FSMC_D9   | PF13 <-> FSMC_A7 |------------------+
	 | PD12 <-> FSMC_A17 | PE13 <-> FSMC_D10  | PF14 <-> FSMC_A8 | 
	 | PD13 <-> FSMC_A18
	 | PD14 <-> FSMC_D0  | PE14 <-> FSMC_D11  | PF15 <-> FSMC_A9 | 
	 | PD15 <-> FSMC_D1  | PE15 <-> FSMC_D12  |------------------+
	 +-------------------+--------------------+
	*/
 	/* Enable GPIOD, GPIOE, GPIOF and GPIOG interface clock */
	//RCC->AHB1ENR   = 0x00000078;
	pRCC->__B.AHB1ENR.IOPDEN = SET;
	pRCC->__B.AHB1ENR.IOPEEN = SET;
	pRCC->__B.AHB1ENR.IOPFEN = SET;
	pRCC->__B.AHB1ENR.IOPGEN = SET;

	// DATA BUS DEFINITION
	__PD14_FSMC_D0();
	__PD15_FSMC_D1();
	__PD0_FSMC_D2();
	__PD1_FSMC_D3();

	__PE7_FSMC_D4();
	__PE8_FSMC_D5();
	__PE9_FSMC_D6();
	__PE10_FSMC_D7();

  	// NOE/NWE DEFINITION
  	__PD4_FSMC_nOE();
	__PD5_FSMC_nWE();


	// ADDRESS DEFINITON
	__PF0_FSMC_A0();
	__PF1_FSMC_A1();
	__PF2_FSMC_A2();
	__PF3_FSMC_A3();

	__PF4_FSMC_A4();
	__PF5_FSMC_A5();
	__PF12_FSMC_A6();
	__PF13_FSMC_A7();
	
	__PF14_FSMC_A8();
	__PF15_FSMC_A9();
	__PG0_FSMC_A10();
	__PG1_FSMC_A11();

	__PG2_FSMC_A12();
	__PG3_FSMC_A13();
	__PG4_FSMC_A14();
	__PG5_FSMC_A15();

	__PD11_FSMC_A16();
	__PD12_FSMC_A17();
	__PD13_FSMC_A18();

	__PG9_IN_PU();	// NE2
	__PG12_IN_PU(); // NE4
	//RAM CE
	__PD7_FSMC_NE1();
	
#ifdef DATA_IN_ExtSRAM2
		__PG10_FSMC_NE3();
#else
		__PG10_IN_PU(); // NE3;
#endif
  	/* Connect PDx pins to FSMC Alternate function */
	//GPIOD->AFR[0]  = 0x00cc00cc;
  	//GPIOD->AFR[1]  = 0xcc0ccccc;
	/* Configure PDx pins in Alternate function mode */  
	//GPIOD->MODER   = 0xa2aa0a0a;
	/* Configure PDx pins speed to 100 MHz */  
	//GPIOD->OSPEEDR = 0xf3ff0f0f;
	/* Configure PDx pins Output type to push-pull */  
	//GPIOD->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PDx pins */ 
	//GPIOD->PUPDR   = 0x00000000;

	/* Connect PEx pins to FSMC Alternate function */
	//GPIOE->AFR[0]  = 0xc00000cc;
	//GPIOE->AFR[1]  = 0xcccccccc;
	/* Configure PEx pins in Alternate function mode */ 
	//GPIOE->MODER   = 0xaaaa800a;
	/* Configure PEx pins speed to 100 MHz */ 
	//GPIOE->OSPEEDR = 0xffffc00f;
	/* Configure PEx pins Output type to push-pull */  
	//GPIOE->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PEx pins */ 
	//GPIOE->PUPDR   = 0x00000000;

	/* Connect PFx pins to FSMC Alternate function */
	//GPIOF->AFR[0]  = 0x00cccccc;
	//GPIOF->AFR[1]  = 0xcccc0000;
	/* Configure PFx pins in Alternate function mode */   
	//GPIOF->MODER   = 0xaa000aaa;
	/* Configure PFx pins speed to 100 MHz */ 
	//GPIOF->OSPEEDR = 0xff000fff;
	/* Configure PFx pins Output type to push-pull */  
	//GPIOF->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PFx pins */ 
	//GPIOF->PUPDR   = 0x00000000;

	/* Connect PGx pins to FSMC Alternate function */
	//GPIOG->AFR[0]  = 0x00cccccc;
	//GPIOG->AFR[1]  = 0x000000c0;
	/* Configure PGx pins in Alternate function mode */ 
	//GPIOG->MODER   = 0x00080aaa;
	/* Configure PGx pins speed to 100 MHz */ 
	//GPIOG->OSPEEDR = 0x000c0fff;
	/* Configure PGx pins Output type to push-pull */  
	//GPIOG->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PGx pins */ 
	//GPIOG->PUPDR   = 0x00000000;
  
	/*-- FSMC Configuration ------------------------------------------------------*/
	/* Enable the FSMC interface clock */
	//RCC->AHB3ENR         = 0x00000001;
	pRCC->__B.AHB3ENR.FSMCEN = SET;

	/* Configure and enable Bank1_SRAM2 */
	//FSMC_Bank1->BTCR[2]  = 0x00001015;
	//FSMC_Bank1->BTCR[3]  = 0x00010400;
	//FSMC_Bank1E->BWTR[2] = 0x0fffffff;

	/* Bank1_SRAM1 is configured as follow: */
	{
		FSMC_NORSRAMInitTypeDef FSMC_NORSRAMInitStructure;
		FSMC_NORSRAMTimingInitTypeDef p; 


		p.FSMC_AddressSetupTime = 3;		// 0~15, 1 ~= 16ns
		p.FSMC_AddressHoldTime = 1;			// 1~15,
		p.FSMC_DataSetupTime = 7;			// 1~255
		p.FSMC_BusTurnAroundDuration = 1; 	// 0~15
		p.FSMC_CLKDivision = 2;				// 64MHz
		p.FSMC_DataLatency = 2;
		p.FSMC_AccessMode = FSMC_AccessMode_A;

		FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM1;
		FSMC_NORSRAMInitStructure.FSMC_DataAddressMux = FSMC_DataAddressMux_Disable;
		FSMC_NORSRAMInitStructure.FSMC_MemoryType = FSMC_MemoryType_SRAM;
		FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
		FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_AsynchronousWait = FSMC_AsynchronousWait_Disable;  
		FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
		FSMC_NORSRAMInitStructure.FSMC_WrapMode = FSMC_WrapMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
		FSMC_NORSRAMInitStructure.FSMC_WriteOperation = FSMC_WriteOperation_Enable;
		FSMC_NORSRAMInitStructure.FSMC_WaitSignal = FSMC_WaitSignal_Disable;
		FSMC_NORSRAMInitStructure.FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_WriteBurst = FSMC_WriteBurst_Disable;
		FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct = &p;
		FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct = &p;


		FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure);
		/*!< Enable FSMC Bank1_SRAM2 Bank */
		FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM1, ENABLE); 
#ifdef DATA_IN_ExtSRAM2
		FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM3;
		FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure);
		/*!< Enable FSMC Bank1_SRAM3 Bank */
		FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM3, ENABLE); 
#endif
  	}
  
}

void SystemInit_PSRAM0Ctl(void)
{
	RCC_TypeDef *pRCC = RCC;
	
	/*-- GPIOs Configuration -----------------------------------------------------*/
	/*
	 +-------------------+--------------------+------------------+------------------+
	 +                       SRAM pins assignment                                  +
	 +-------------------+--------------------+------------------+------------------+
	 | PD0  <-> FSMC_D2  | PE0  <-> FSMC_NBL0 | PF0  <-> FSMC_A0 | PG0 <-> FSMC_A10 |
	 | PD1  <-> FSMC_D3  | PE1  <-> FSMC_NBL1 | PF1  <-> FSMC_A1 | PG1 <-> FSMC_A11 |
	 | PD4  <-> FSMC_NOE | PE7  <-> FSMC_D4   | PF2  <-> FSMC_A2 | PG2 <-> FSMC_A12 |
	 | PD5  <-> FSMC_NWE | PE8  <-> FSMC_D5   | PF3  <-> FSMC_A3 | PG3 <-> FSMC_A13 |
	 | PD7  <-> FSMC_NE1
	 | PD8  <-> FSMC_D13 | PE9  <-> FSMC_D6   | PF4  <-> FSMC_A4 | PG4 <-> FSMC_A14 |
	 | PD9  <-> FSMC_D14 | PE10 <-> FSMC_D7   | PF5  <-> FSMC_A5 | PG5 <-> FSMC_A15 |
	 | PD10 <-> FSMC_D15 | PE11 <-> FSMC_D8   | PF12 <-> FSMC_A6 | PG9 <-> FSMC_NE2 |
	 | PD11 <-> FSMC_A16 | PE12 <-> FSMC_D9   | PF13 <-> FSMC_A7 |------------------+
	 | PD12 <-> FSMC_A17 | PE13 <-> FSMC_D10  | PF14 <-> FSMC_A8 | 
	 | PD13 <-> FSMC_A18
	 | PD14 <-> FSMC_D0  | PE14 <-> FSMC_D11  | PF15 <-> FSMC_A9 | 
	 | PD15 <-> FSMC_D1  | PE15 <-> FSMC_D12  |------------------+
	 +-------------------+--------------------+
	*/
 	/* Enable GPIOD, GPIOE, GPIOF and GPIOG interface clock */
	//RCC->AHB1ENR   = 0x00000078;
	pRCC->__B.AHB1ENR.IOPDEN = SET;
	pRCC->__B.AHB1ENR.IOPEEN = SET;
	pRCC->__B.AHB1ENR.IOPFEN = SET;
	pRCC->__B.AHB1ENR.IOPGEN = SET;

	// DATA BUS DEFINITION
	__PD14_FSMC_D0();
	__PD15_FSMC_D1();
	__PD0_FSMC_D2();
	__PD1_FSMC_D3();

	__PE7_FSMC_D4();
	__PE8_FSMC_D5();
	__PE9_FSMC_D6();
	__PE10_FSMC_D7();
	__PE11_FSMC_D8();
	__PE12_FSMC_D9();
	__PE13_FSMC_D10();
	__PE14_FSMC_D11();
	__PE15_FSMC_D12();

	__PD8_FSMC_D13();
	__PD9_FSMC_D14();
	__PD10_FSMC_D15();

  	// NOE/NWE DEFINITION
  	__PD4_FSMC_nOE();
	__PD5_FSMC_nWE();


	// ADDRESS DEFINITON
	__PF0_FSMC_A0();
	__PF1_FSMC_A1();
	__PF2_FSMC_A2();
	__PF3_FSMC_A3();

	__PF4_FSMC_A4();
	__PF5_FSMC_A5();
	__PF12_FSMC_A6();
	__PF13_FSMC_A7();
	
	__PF14_FSMC_A8();
	__PF15_FSMC_A9();
	__PG0_FSMC_A10();
	__PG1_FSMC_A11();

	__PG2_FSMC_A12();
	__PG3_FSMC_A13();
	__PG4_FSMC_A14();
	__PG5_FSMC_A15();

	__PD11_FSMC_A16();
	__PD12_FSMC_A17();
	__PD13_FSMC_A18();

	__PE3_FSMC_A19();
	__PE4_FSMC_A20();
	__PE5_FSMC_A21();




//	__PG9_IN_PU();	// NE2
	__PG12_IN_PU(); // NE4
	//RAM CE
	__PG9_FSMC_NE2();

  	/* Connect PDx pins to FSMC Alternate function */
	//GPIOD->AFR[0]  = 0x00cc00cc;
  	//GPIOD->AFR[1]  = 0xcc0ccccc;
	/* Configure PDx pins in Alternate function mode */  
	//GPIOD->MODER   = 0xa2aa0a0a;
	/* Configure PDx pins speed to 100 MHz */  
	//GPIOD->OSPEEDR = 0xf3ff0f0f;
	/* Configure PDx pins Output type to push-pull */  
	//GPIOD->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PDx pins */ 
	//GPIOD->PUPDR   = 0x00000000;

	/* Connect PEx pins to FSMC Alternate function */
	//GPIOE->AFR[0]  = 0xc00000cc;
	//GPIOE->AFR[1]  = 0xcccccccc;
	/* Configure PEx pins in Alternate function mode */ 
	//GPIOE->MODER   = 0xaaaa800a;
	/* Configure PEx pins speed to 100 MHz */ 
	//GPIOE->OSPEEDR = 0xffffc00f;
	/* Configure PEx pins Output type to push-pull */  
	//GPIOE->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PEx pins */ 
	//GPIOE->PUPDR   = 0x00000000;

	/* Connect PFx pins to FSMC Alternate function */
	//GPIOF->AFR[0]  = 0x00cccccc;
	//GPIOF->AFR[1]  = 0xcccc0000;
	/* Configure PFx pins in Alternate function mode */   
	//GPIOF->MODER   = 0xaa000aaa;
	/* Configure PFx pins speed to 100 MHz */ 
	//GPIOF->OSPEEDR = 0xff000fff;
	/* Configure PFx pins Output type to push-pull */  
	//GPIOF->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PFx pins */ 
	//GPIOF->PUPDR   = 0x00000000;

	/* Connect PGx pins to FSMC Alternate function */
	//GPIOG->AFR[0]  = 0x00cccccc;
	//GPIOG->AFR[1]  = 0x000000c0;
	/* Configure PGx pins in Alternate function mode */ 
	//GPIOG->MODER   = 0x00080aaa;
	/* Configure PGx pins speed to 100 MHz */ 
	//GPIOG->OSPEEDR = 0x000c0fff;
	/* Configure PGx pins Output type to push-pull */  
	//GPIOG->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PGx pins */ 
	//GPIOG->PUPDR   = 0x00000000;
  
	/*-- FSMC Configuration ------------------------------------------------------*/
	/* Enable the FSMC interface clock */
	//RCC->AHB3ENR         = 0x00000001;
	pRCC->__B.AHB3ENR.FSMCEN = SET;

	/* Configure and enable Bank1_SRAM2 */
	//FSMC_Bank1->BTCR[2]  = 0x00001015;
	//FSMC_Bank1->BTCR[3]  = 0x00010400;
	//FSMC_Bank1E->BWTR[2] = 0x0fffffff;

	/* Bank1_SRAM1 is configured as follow: */
	{
		FSMC_NORSRAMInitTypeDef FSMC_NORSRAMInitStructure;
		FSMC_NORSRAMTimingInitTypeDef p; 


		p.FSMC_AddressSetupTime 		= 3;		// 0~15, 1 ~= 16ns
		p.FSMC_AddressHoldTime 			= 1;			// 1~15,
		p.FSMC_DataSetupTime 			= 7;			// 1~255
		p.FSMC_BusTurnAroundDuration 	= 1; 	// 0~15
		p.FSMC_CLKDivision 				= 2;				// 64MHz
		p.FSMC_DataLatency 				= 2;
		p.FSMC_AccessMode 				= FSMC_AccessMode_A;

		FSMC_NORSRAMInitStructure.FSMC_Bank 			= FSMC_Bank1_NORSRAM2;
		FSMC_NORSRAMInitStructure.FSMC_DataAddressMux 	= FSMC_DataAddressMux_Disable;
		FSMC_NORSRAMInitStructure.FSMC_MemoryType 		= FSMC_MemoryType_PSRAM;
		FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth 	= FSMC_MemoryDataWidth_16b;
		FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode 	= FSMC_BurstAccessMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_AsynchronousWait = FSMC_AsynchronousWait_Disable;  
		FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity 	= FSMC_WaitSignalPolarity_Low;
		FSMC_NORSRAMInitStructure.FSMC_WrapMode 			= FSMC_WrapMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive 	= FSMC_WaitSignalActive_BeforeWaitState;
		FSMC_NORSRAMInitStructure.FSMC_WriteOperation 		= FSMC_WriteOperation_Enable;
		FSMC_NORSRAMInitStructure.FSMC_WaitSignal 			= FSMC_WaitSignal_Disable;
		FSMC_NORSRAMInitStructure.FSMC_ExtendedMode 		= FSMC_ExtendedMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_WriteBurst 			= FSMC_WriteBurst_Disable;
		FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct = &p;
		FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct 	= &p;



		FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM2;
		FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure);
		/*!< Enable FSMC Bank1_SRAM3 Bank */
		FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM2, ENABLE); 
  	}
  
}



void SystemInit_PSRAM1Ctl(void)
{
	RCC_TypeDef *pRCC = RCC;
	
	/*-- GPIOs Configuration -----------------------------------------------------*/
	/*
	 +-------------------+--------------------+------------------+------------------+
	 +                       SRAM pins assignment                                  +
	 +-------------------+--------------------+------------------+------------------+
	 | PD0  <-> FSMC_D2  | PE0  <-> FSMC_NBL0 | PF0  <-> FSMC_A0 | PG0 <-> FSMC_A10 |
	 | PD1  <-> FSMC_D3  | PE1  <-> FSMC_NBL1 | PF1  <-> FSMC_A1 | PG1 <-> FSMC_A11 |
	 | PD4  <-> FSMC_NOE | PE7  <-> FSMC_D4   | PF2  <-> FSMC_A2 | PG2 <-> FSMC_A12 |
	 | PD5  <-> FSMC_NWE | PE8  <-> FSMC_D5   | PF3  <-> FSMC_A3 | PG3 <-> FSMC_A13 |
	 | PD7  <-> FSMC_NE1
	 | PD8  <-> FSMC_D13 | PE9  <-> FSMC_D6   | PF4  <-> FSMC_A4 | PG4 <-> FSMC_A14 |
	 | PD9  <-> FSMC_D14 | PE10 <-> FSMC_D7   | PF5  <-> FSMC_A5 | PG5 <-> FSMC_A15 |
	 | PD10 <-> FSMC_D15 | PE11 <-> FSMC_D8   | PF12 <-> FSMC_A6 | PG9 <-> FSMC_NE2 |
	 | PD11 <-> FSMC_A16 | PE12 <-> FSMC_D9   | PF13 <-> FSMC_A7 |------------------+
	 | PD12 <-> FSMC_A17 | PE13 <-> FSMC_D10  | PF14 <-> FSMC_A8 | 
	 | PD13 <-> FSMC_A18
	 | PD14 <-> FSMC_D0  | PE14 <-> FSMC_D11  | PF15 <-> FSMC_A9 | 
	 | PD15 <-> FSMC_D1  | PE15 <-> FSMC_D12  |------------------+
	 +-------------------+--------------------+
	*/
 	/* Enable GPIOD, GPIOE, GPIOF and GPIOG interface clock */
	//RCC->AHB1ENR   = 0x00000078;
	pRCC->__B.AHB1ENR.IOPDEN = SET;
	pRCC->__B.AHB1ENR.IOPEEN = SET;
	pRCC->__B.AHB1ENR.IOPFEN = SET;
	pRCC->__B.AHB1ENR.IOPGEN = SET;

	// DATA BUS DEFINITION
	__PD14_FSMC_D0();
	__PD15_FSMC_D1();
	__PD0_FSMC_D2();
	__PD1_FSMC_D3();

	__PE7_FSMC_D4();
	__PE8_FSMC_D5();
	__PE9_FSMC_D6();
	__PE10_FSMC_D7();
	__PE11_FSMC_D8();
	__PE12_FSMC_D9();
	__PE13_FSMC_D10();
	__PE14_FSMC_D11();
	__PE15_FSMC_D12();

	__PD8_FSMC_D13();
	__PD9_FSMC_D14();
	__PD10_FSMC_D15();

  	// NOE/NWE DEFINITION
  	__PD4_FSMC_nOE();
	__PD5_FSMC_nWE();


	// ADDRESS DEFINITON
	__PF0_FSMC_A0();
	__PF1_FSMC_A1();
	__PF2_FSMC_A2();
	__PF3_FSMC_A3();

	__PF4_FSMC_A4();
	__PF5_FSMC_A5();
	__PF12_FSMC_A6();
	__PF13_FSMC_A7();
	
	__PF14_FSMC_A8();
	__PF15_FSMC_A9();
	__PG0_FSMC_A10();
	__PG1_FSMC_A11();

	__PG2_FSMC_A12();
	__PG3_FSMC_A13();
	__PG4_FSMC_A14();
	__PG5_FSMC_A15();

	__PD11_FSMC_A16();
	__PD12_FSMC_A17();
	__PD13_FSMC_A18();

	__PE3_FSMC_A19();
	__PE4_FSMC_A20();
	__PE5_FSMC_A21();




//	__PG9_IN_PU();	// NE2
	__PG12_IN_PU(); // NE4
	//RAM CE
	__PG9_FSMC_NE2();

  	/* Connect PDx pins to FSMC Alternate function */
	//GPIOD->AFR[0]  = 0x00cc00cc;
  	//GPIOD->AFR[1]  = 0xcc0ccccc;
	/* Configure PDx pins in Alternate function mode */  
	//GPIOD->MODER   = 0xa2aa0a0a;
	/* Configure PDx pins speed to 100 MHz */  
	//GPIOD->OSPEEDR = 0xf3ff0f0f;
	/* Configure PDx pins Output type to push-pull */  
	//GPIOD->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PDx pins */ 
	//GPIOD->PUPDR   = 0x00000000;

	/* Connect PEx pins to FSMC Alternate function */
	//GPIOE->AFR[0]  = 0xc00000cc;
	//GPIOE->AFR[1]  = 0xcccccccc;
	/* Configure PEx pins in Alternate function mode */ 
	//GPIOE->MODER   = 0xaaaa800a;
	/* Configure PEx pins speed to 100 MHz */ 
	//GPIOE->OSPEEDR = 0xffffc00f;
	/* Configure PEx pins Output type to push-pull */  
	//GPIOE->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PEx pins */ 
	//GPIOE->PUPDR   = 0x00000000;

	/* Connect PFx pins to FSMC Alternate function */
	//GPIOF->AFR[0]  = 0x00cccccc;
	//GPIOF->AFR[1]  = 0xcccc0000;
	/* Configure PFx pins in Alternate function mode */   
	//GPIOF->MODER   = 0xaa000aaa;
	/* Configure PFx pins speed to 100 MHz */ 
	//GPIOF->OSPEEDR = 0xff000fff;
	/* Configure PFx pins Output type to push-pull */  
	//GPIOF->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PFx pins */ 
	//GPIOF->PUPDR   = 0x00000000;

	/* Connect PGx pins to FSMC Alternate function */
	//GPIOG->AFR[0]  = 0x00cccccc;
	//GPIOG->AFR[1]  = 0x000000c0;
	/* Configure PGx pins in Alternate function mode */ 
	//GPIOG->MODER   = 0x00080aaa;
	/* Configure PGx pins speed to 100 MHz */ 
	//GPIOG->OSPEEDR = 0x000c0fff;
	/* Configure PGx pins Output type to push-pull */  
	//GPIOG->OTYPER  = 0x00000000;
	/* No pull-up, pull-down for PGx pins */ 
	//GPIOG->PUPDR   = 0x00000000;
  
	/*-- FSMC Configuration ------------------------------------------------------*/
	/* Enable the FSMC interface clock */
	//RCC->AHB3ENR         = 0x00000001;
	pRCC->__B.AHB3ENR.FSMCEN = SET;

	/* Configure and enable Bank1_SRAM2 */
	//FSMC_Bank1->BTCR[2]  = 0x00001015;
	//FSMC_Bank1->BTCR[3]  = 0x00010400;
	//FSMC_Bank1E->BWTR[2] = 0x0fffffff;

	/* Bank1_SRAM1 is configured as follow: */
	{
		FSMC_NORSRAMInitTypeDef FSMC_NORSRAMInitStructure;
		FSMC_NORSRAMTimingInitTypeDef p; 


		p.FSMC_AddressSetupTime 		= 3;		// 0~15, 1 ~= 16ns
		p.FSMC_AddressHoldTime 			= 1;			// 1~15,
		p.FSMC_DataSetupTime 			= 7;			// 1~255
		p.FSMC_BusTurnAroundDuration 	= 1; 	// 0~15
		p.FSMC_CLKDivision 				= 2;				// 64MHz
		p.FSMC_DataLatency 				= 2;
		p.FSMC_AccessMode 				= FSMC_AccessMode_A;

		FSMC_NORSRAMInitStructure.FSMC_Bank 			= FSMC_Bank1_NORSRAM3;
		FSMC_NORSRAMInitStructure.FSMC_DataAddressMux 	= FSMC_DataAddressMux_Disable;
		FSMC_NORSRAMInitStructure.FSMC_MemoryType 		= FSMC_MemoryType_PSRAM;
		FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth 	= FSMC_MemoryDataWidth_16b;
		FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode 	= FSMC_BurstAccessMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_AsynchronousWait = FSMC_AsynchronousWait_Disable;  
		FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity 	= FSMC_WaitSignalPolarity_Low;
		FSMC_NORSRAMInitStructure.FSMC_WrapMode 			= FSMC_WrapMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive 	= FSMC_WaitSignalActive_BeforeWaitState;
		FSMC_NORSRAMInitStructure.FSMC_WriteOperation 		= FSMC_WriteOperation_Enable;
		FSMC_NORSRAMInitStructure.FSMC_WaitSignal 			= FSMC_WaitSignal_Disable;
		FSMC_NORSRAMInitStructure.FSMC_ExtendedMode 		= FSMC_ExtendedMode_Disable;
		FSMC_NORSRAMInitStructure.FSMC_WriteBurst 			= FSMC_WriteBurst_Disable;
		FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct = &p;
		FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct 	= &p;



		FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM3;
		FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure);
		/*!< Enable FSMC Bank1_SRAM3 Bank */
		FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM3, ENABLE); 
  	}
  
}


//#endif /* DATA_IN_ExtSRAM */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
