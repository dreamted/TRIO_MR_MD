/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : stm32f10x_flash.h
* Author             : MCD Application Team
* Date First Issued  : 05/21/2007
* Description        : This file contains all the functions prototypes for the
*                      FLASH firmware library.
********************************************************************************
* History:
* 05/21/2007: V0.3
********************************************************************************
* THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

// Define to prevent recursive inclusion ---------------------------------------
#ifndef __STM32F10x_FLASH_H
#define __STM32F10x_FLASH_H

//------------------------ FLASH and Option Bytes Registers --------------------
typedef struct
{
	union {
		vu32 Data;
		struct	{
			vu32 LATENCY		:3;	//rw, the ratio of the SYSCLK period to the Flash Access time
			vu32 HLFCYA			:1;	//rw, Flash Half Cycle Access Enable
			vu32 PRFTBE			:1;	//rw, Prefetch Buffer Enable
			vu32 PRFTBS			:1;	//r, Prefetch Buffer Status
		} Bit;

	} ACR;	//Flash Access Control Register

	union {
		vu32 Data;
		struct	{
			vu32 FKEYR			:32;	//w, The keys to unlock the FPEC
		} Bit;

	} KEYR;	//FPEC Key Register	

	union {
		vu32 Data;
		struct	{
			vu32 OPTKEYR		:32;	//w, The keys to unlock the OPTWRE
		}Bit;

	} OPTKEYR;	//Flash OPTKEY Register

	union {
		vu32 Data;
		struct	{
			vu32 BSY			:1;		//rw, Busy
			vu32 RESERVED1		:1;
			vu32 PGERR			:1;		//rw, Programming Error
			vu32 RESERVED2		:1;	
			vu32 WIRPRTERR		:1;		//rw, Write Protection Error
			vu32 EOP			:1;		//rw, End of operation
		} Bit;
	} SR;	//Flash Status Register

	union {
		vu32 Data;
		struct	{
			vu32 PG				:1;		//rw, Programming
			vu32 PER			:1;		//rw, Page Erase
			vu32 MER			:1;		//rw, Mass Erase
			vu32 RESERVED1		:1;		
			vu32 OPTPG			:1;		//rw, Option Byte Programming
			vu32 OPTER			:1;		//rw, Option Byte Erase			
			vu32 STRT			:1;		//rw, Start
			vu32 LOCK			:1;		//rw, Lock
			vu32 RESERVED2		:1;
			vu32 OPTWRE			:1;		//rw, Option Bytes Write Enable
			vu32 ERRIE			:1;		//rw, Error Interrupt Enable
			vu32 RESERVED3		:1;
			vu32 EOPIE			:1;		//rw, End of operation interrupt enable
		} Bit;
	} CR;	//Flash Control Register

	union {
		vu32 Data;
		struct	{
			vu32 FAR			:32;	//w, Flash Address
		} Bit;
	} AR;	//Flash Address Register

	vu32 RESERVED;

	union {
		vu32 Data;
		struct	{
			vu32 OPTERR			:1;		//r, Option Byte Error
			vu32 RDPRT			:1;		//r, Read protection
			vu32 WDG_SW			:1;		//r, SW or HW watchdog
			vu32 NRST_STOP		:1;		//r, Entering STOP mode
			vu32 NRST_STDBY		:1;		//r, Entering Stanby mode
		} Bit;
	} OBR;	//Option Byte Register

	union {
		vu32 Data;
		struct	{
			vu32 WRP			:32;	//r, Write Protect
		} Bit;
	} WRPR;	//Write Protection Register
} FLASH_TypeDef;


typedef struct
{
  vu16 RDP;
  vu16 USER;
  vu16 Data0;
  vu16 Data1;
  vu16 WRP0;
  vu16 WRP1;
  vu16 WRP2;
  vu16 WRP3;
} OB_TypeDef;

// Define to prevent recursive inclusion ---------------------------------------
#define FLASH               ((FLASH_TypeDef *) FLASH_INT_BASE)
#define OB                  ((OB_TypeDef *) OB_BASE) 

////////////////////////////////////////////////////////////////////////////////
enum
{ 
	FLASH_BUSY = 1,
	FLASH_ERROR_PG,
	FLASH_ERROR_WRP,
	FLASH_COMPLETE,
	FLASH_TIMEOUT,
	FLASH_ERRORWR
};


// ACR REGISTER

// LATENCY
#define LATENCY0				0		// FLASH Zero Latency cycle( 0 ~ 24 MHz)
#define LATENCY1				1		// FLASH One Latency cycle(24MHz ~ 48 MHz)
#define LATENCY2				2		// FLASH Two Latency cycles(48MHz ~ 72 MHz)

/* Half Cycle Enable/Disable -------------------------------------------------*/
#define FLASH_HalfCycleAccess_Enable   ((u32)0x00000008)  /* FLASH Half Cycle Enable */
#define FLASH_HalfCycleAccess_Disable  ((u32)0x00000000)  /* FLASH Half Cycle Disable */

#define IS_FLASH_HALFCYCLEACCESS_STATE(STATE) ((STATE == FLASH_HalfCycleAccess_Enable) || \
                                               (STATE == FLASH_HalfCycleAccess_Disable)) 


/* Prefetch Buffer Enable/Disable --------------------------------------------*/
#define FLASH_PrefetchBuffer_Enable    ((u32)0x00000010)  /* FLASH Prefetch Buffer Enable */
#define FLASH_PrefetchBuffer_Disable   ((u32)0x00000000)  /* FLASH Prefetch Buffer Disable */

#define IS_FLASH_PREFETCHBUFFER_STATE(STATE) ((STATE == FLASH_PrefetchBuffer_Enable) || \
                                              (STATE == FLASH_PrefetchBuffer_Disable)) 

/* Option Bytes Write Protection ---------------------------------------------*/
#define FLASH_WRProt_Pages0to3      ((u32)0x00000001) /* Write protection of page 0 to 3 */
#define FLASH_WRProt_Pages4to7      ((u32)0x00000002) /* Write protection of page 4 to 7 */
#define FLASH_WRProt_Pages8to11     ((u32)0x00000004) /* Write protection of page 8 to 11 */
#define FLASH_WRProt_Pages12to15    ((u32)0x00000008) /* Write protection of page 12 to 15 */
#define FLASH_WRProt_Pages16to19    ((u32)0x00000010) /* Write protection of page 16 to 19 */
#define FLASH_WRProt_Pages20to23    ((u32)0x00000020) /* Write protection of page 20 to 23 */
#define FLASH_WRProt_Pages24to27    ((u32)0x00000040) /* Write protection of page 24 to 27 */
#define FLASH_WRProt_Pages28to31    ((u32)0x00000080) /* Write protection of page 28 to 31 */
#define FLASH_WRProt_Pages32to35    ((u32)0x00000100) /* Write protection of page 32 to 35 */
#define FLASH_WRProt_Pages36to39    ((u32)0x00000200) /* Write protection of page 36 to 39 */
#define FLASH_WRProt_Pages40to43    ((u32)0x00000400) /* Write protection of page 40 to 43 */
#define FLASH_WRProt_Pages44to47    ((u32)0x00000800) /* Write protection of page 44 to 47 */
#define FLASH_WRProt_Pages48to51    ((u32)0x00001000) /* Write protection of page 48 to 51 */
#define FLASH_WRProt_Pages52to55    ((u32)0x00002000) /* Write protection of page 52 to 55 */
#define FLASH_WRProt_Pages56to59    ((u32)0x00004000) /* Write protection of page 56 to 59 */
#define FLASH_WRProt_Pages60to63    ((u32)0x00008000) /* Write protection of page 60 to 63 */
#define FLASH_WRProt_Pages64to67    ((u32)0x00010000) /* Write protection of page 64 to 67 */
#define FLASH_WRProt_Pages68to71    ((u32)0x00020000) /* Write protection of page 68 to 71 */
#define FLASH_WRProt_Pages72to75    ((u32)0x00040000) /* Write protection of page 72 to 75 */
#define FLASH_WRProt_Pages76to79    ((u32)0x00080000) /* Write protection of page 76 to 79 */
#define FLASH_WRProt_Pages80to83    ((u32)0x00100000) /* Write protection of page 80 to 83 */
#define FLASH_WRProt_Pages84to87    ((u32)0x00200000) /* Write protection of page 84 to 87 */
#define FLASH_WRProt_Pages88to91    ((u32)0x00400000) /* Write protection of page 88 to 91 */
#define FLASH_WRProt_Pages92to95    ((u32)0x00800000) /* Write protection of page 92 to 95 */
#define FLASH_WRProt_Pages96to99    ((u32)0x01000000) /* Write protection of page 96 to 99 */
#define FLASH_WRProt_Pages100to103  ((u32)0x02000000) /* Write protection of page 100 to 103 */
#define FLASH_WRProt_Pages104to107  ((u32)0x04000000) /* Write protection of page 104 to 107 */
#define FLASH_WRProt_Pages108to111  ((u32)0x08000000) /* Write protection of page 108 to 111 */
#define FLASH_WRProt_Pages112to115  ((u32)0x10000000) /* Write protection of page 112 to 115 */
#define FLASH_WRProt_Pages116to119  ((u32)0x20000000) /* Write protection of page 115 to 119 */
#define FLASH_WRProt_Pages120to123  ((u32)0x40000000) /* Write protection of page 120 to 123 */
#define FLASH_WRProt_Pages124to127  ((u32)0x80000000) /* Write protection of page 124 to 127 */
#define FLASH_WRProt_AllPages       ((u32)0xFFFFFFFF) /* Write protection All Pages */

#define IS_FLASH_WRPROT_PAGE(PAGE) ((PAGE != 0x00000000))


#define IS_OB_DATA_ADDRESS(ADDRESS) ((ADDRESS == 0x1FFFF804) || (ADDRESS == 0x1FFFF806))

/* Option Bytes IWatchdog ----------------------------------------------------*/
#define OB_IWDG_SW                  ((u16)0x0001)  /* Software IWDG selected */
#define OB_IWDG_HW                  ((u16)0x0000)  /* Hardware IWDG selected */

#define IS_OB_IWDG_SOURCE(SOURCE)	((SOURCE == OB_IWDG_SW) || (SOURCE == OB_IWDG_HW))

/* Option Bytes nRST_STOP ----------------------------------------------------*/
#define OB_STOP_NoRST               ((u16)0x0002) /* No reset generated when entering in STOP */
#define OB_STOP_RST                 ((u16)0x0000) /* Reset generated when entering in STOP */

#define IS_OB_STOP_SOURCE(SOURCE) ((SOURCE == OB_STOP_NoRST) || (SOURCE == OB_STOP_RST))

/* Option Bytes nRST_STDBY ---------------------------------------------------*/
#define OB_STDBY_NoRST               ((u16)0x0004) /* No reset generated when entering in STANDBY */
#define OB_STDBY_RST                 ((u16)0x0000) /* Reset generated when entering in STANDBY */

#define IS_OB_STDBY_SOURCE(SOURCE) ((SOURCE == OB_STDBY_NoRST) || (SOURCE == OB_STDBY_RST))

/* FLASH Interrupts ----------------------------------------------------------*/
#define FLASH_IT_ERROR           ((u32)0x00000400)  /* FPEC error interrupt source */
#define FLASH_IT_EOP             ((u32)0x00001000)  /* End of FLASH Operation Interrupt source */

#define IS_FLASH_IT(IT) (((IT & (u32)0xFFFFEBFF) == 0x00000000) && (IT != 0x00000000))

/* FLASH Flags ---------------------------------------------------------------*/
#define FLASH_FLAG_BSY           ((u32)0x00000001)  /* FLASH Busy flag */
#define FLASH_FLAG_EOP           ((u32)0x00000020)  /* FLASH End of Operation flag */
#define FLASH_FLAG_PGERR         ((u32)0x00000004)  /* FLASH Program error flag */
#define FLASH_FLAG_WRPRTERR      ((u32)0x00000010)  /* FLASH Write protected error flag */
#define FLASH_FLAG_OPTERR        ((u32)0x00000001)  /* FLASH Option Byte error flag */
 

/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void FLASH_HalfCycleAccessCmd(u32 FLASH_HalfCycleAccess);

void FLASH_Unlock(void);
void FLASH_Lock(void);

INT32U FLASH_pAPBK_Check(INT32U pAddr);
INT32U FLASHpAPBK_Check_Erase(void);

INT32U FLASH_ErasePage(u32 Page_Address);
INT32U FLASH_EraseAllPages(void);
INT32U FLASH_EraseOptionBytes(void);
INT32U FLASH_ProgramWord(u32 Address, u32 Data);
INT32U FLASH_ProgramHalfWord(u32 Address, u16 Data);
INT32U FLASH_ProgramOptionByteData(u32 Address, u8 Data);
INT32U FLASH_EnableWriteProtection(u32 FLASH_Pages);
INT32U FLASH_ReadOutProtection(INT32U NewState);
INT32U FLASH_UserOptionByteConfig(u16 OB_IWDG, u16 OB_STOP, u16 OB_STDBY);
INT32U FLASH_GetUserOptionByte(void);
INT32U FLASH_GetWriteProtectionOptionByte(void);
INT32U FLASH_GetReadOutProtectionStatus(void);
INT32U FLASH_GetPrefetchBufferStatus(void);
INT32U FLASH_GetFlagStatus(u16 FLASH_FLAG);
INT32U FLASH_GetStatus(void);
INT32U FLASH_WaitForLastOperation(u32 Timeout);

void FLASH_ClearFlag(u16 FLASH_FLAG);
void FLASH_ITConfig(u16 FLASH_IT, INT32U NewState);

#endif /* __STM32F10x_FLASH_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
