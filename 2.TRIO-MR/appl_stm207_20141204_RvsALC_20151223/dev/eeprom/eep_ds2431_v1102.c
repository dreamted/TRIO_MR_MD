/*******************************************************************************
 *
 * This module contains the function STM32F10x EEPROM(DS2431) related, a function
 * that is called before the 'main' function of the program.  Normally
 * timer initializations - such as setting the prefered timer interrupt
 * level or setting the watchdog - can be performed here.
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2011- bizistyle(bgyoon@naver.com), All rights reserved.
 *
 * $Revision: 2011.02 $
 * $Revision date: 2008.06
 ******************************************************************************/

//#define DS2431_DBG_MSG

#include "stm32f10x_conf.h"
#include "eep_ds2431_v1102.h"



void DS2431Init(void)
{
	SetDS2431OutMode(PSU_DS2431);
	SetDS2431DATA(PSU_DS2431);
}


INT8U RstDS2431(INT8U nUSE)
{
	INT8S cnt = 100;
	INT32U cpu_sr;

	OS_ENTER_CRITICAL();

	SetDS2431DATA(nUSE);	// Drives DQ SET
	Delay_1us(tREC);

	RstDS2431DATA(nUSE);	// Drives DQ RESET
	Delay_1us(tRSTL);

	SetDS2431DATA(nUSE);	// Drives DQ SET
	Delay_1us(tMSP);

	cnt = ReadDS2431DATA(nUSE) ^ 1;

	Delay_1us(tREC*2L);
	OS_EXIT_CRITICAL();
	GPIOB->ODR.B2 ^= 1;
	return cnt;
}


void WriteBit_DS2431(INT8U nUSE, INT8U Bit)
{
	SetDS2431DATA(nUSE);
	Delay_1us(tREC);

	// Active Low Check
	RstDS2431DATA(nUSE);
	Delay_1us(tW1L); 

    if(Bit) SetDS2431DATA(nUSE);

	Delay_1us(tSLOT-tW1L); // Complete the time slot and 10us recovery
	SetDS2431DATA(nUSE);  
}

void WriteByte_DS2431(INT8U nUSE, INT8U Data)
{
    INT32U i = 0;
#if OS_CRITICAL_METHOD == 3
	OS_CPU_SR  cpu_sr = 0;
#endif	
	OS_ENTER_CRITICAL();

    // Loop to write each bit in the byte, LS-bit first
    for (i = 0; i < 8; i++)
    {
		WriteBit_DS2431(nUSE, Data & 0x01);
		Data >>= 1;
    }
	OS_EXIT_CRITICAL();
}

INT8S ReadBit_DS2431(INT8U nUSE)
{
    INT8U result = 0;
	INT8U i = 0;
	
	//SetDS2431OutMode(nUSE);
	SetDS2431DATA(nUSE);
	Delay_1us(tREC);		// Complete the time slot and 10us recovery

	RstDS2431DATA(nUSE);
	Delay_1us(tRL);			// Complete the time slot and 10us recovery

	SetDS2431DATA(nUSE);
	Delay_1us(tMSR);

	for(; i < 12; i++)
	{
		if(!(result = (ReadDS2431DATA(nUSE) & 0x01))) break;
  		Delay_1us(tMSR);
	}

	for(; i < 12; i++)
	{
  		Delay_1us(tMSR);
	}
    return result;
}


INT16S ReadByte_DS2431(INT8U nUSE)
{
	INT8S rval[8];
    INT16S i, result = 0;
#if OS_CRITICAL_METHOD == 3
	OS_CPU_SR  cpu_sr = 0;
#endif	
	OS_ENTER_CRITICAL();

    for (i = 0; i < 8; i++)
    {
		result = (result >> 1);
		
		rval[i] = ReadBit_DS2431(nUSE);
		if(rval[i]) result |= 0x80;
	}
    OS_EXIT_CRITICAL();

    return result & 0xff;
}



INT8S WriteDS2431(INT8U nUSE, INT16U Addr, INT8U Data)
{
#ifdef DS2431_DBG_MSG
		INT16U mac_crc16 = 0;
#endif
	INT8U i = 0;
	INT8U tmpaddr = Addr%8;
	INT8U tmpData[8];
	INT8U ES, CHK;
	INT16U wAddr;	// writed Addr
	
	ReadDS2431Ptr(nUSE, Addr, tmpData);
	tmpData[tmpaddr] = Data;
	
	if(!RstDS2431(nUSE)) return -1;
	WriteByte_DS2431(nUSE, ID_CHIP_COMM_SKIP_ROM); 		// Write Command
	WriteByte_DS2431(nUSE, ID_CHIP_COMM_WRITE_SCRATCHPAD); // Write Command
	WriteByte_DS2431(nUSE, (Addr & ~0x07));
	WriteByte_DS2431(nUSE, ID_CHIP_ADDRESS_HI);

	WriteByte_DS2431(nUSE, tmpData[i++]);
	WriteByte_DS2431(nUSE, tmpData[i++]);
	WriteByte_DS2431(nUSE, tmpData[i++]);
	WriteByte_DS2431(nUSE, tmpData[i++]);

	WriteByte_DS2431(nUSE, tmpData[i++]);
	WriteByte_DS2431(nUSE, tmpData[i++]);
	WriteByte_DS2431(nUSE, tmpData[i++]);
	WriteByte_DS2431(nUSE, tmpData[i++]);

// read CRC16 of the MAC
#ifdef DS2431_DBG_MSG
	{
		INT8U tmp;
		tmp = ReadByte_DS2431(nUSE);
		pUSART1.printf("1. tmp %02x \n", tmp); 
		mac_crc16 = tmp;
		tmp = ReadByte_DS2431(nUSE);
		pUSART1.printf("2. tmp %02x \n", tmp); 
		
		mac_crc16 |= (((INT16U)tmp << 8) & 0xff00);
		pUSART1.printf("3. mac_crc16_1 %x, %x\n", mac_crc16, i); 
	}
#else
	ReadByte_DS2431(nUSE);
	ReadByte_DS2431(nUSE);
#endif

	if(!RstDS2431(nUSE)) return -1;
	
	WriteByte_DS2431(nUSE, ID_CHIP_COMM_SKIP_ROM); 		// Write Command
	WriteByte_DS2431(nUSE, ID_CHIP_COMM_READ_SCRATCHPAD); // Write Command

	wAddr = 0;
	wAddr  |= (INT16U)ReadByte_DS2431(nUSE) << 0; // TA1
	wAddr  |= (INT16U)ReadByte_DS2431(nUSE) << 8; // TA2
	ES  = ReadByte_DS2431(nUSE); //  ES

	for(i = 0; i < 8; i++) tmpData[i] = ReadByte_DS2431(nUSE);
	
#ifdef DS2431_DBG_MSG
	pUSART1.printf("4. wAddr   = %04x, ES   = %02x \n", wAddr, ES);
	pUSART1.printf("5. tmpData = %04x, Data = %02x \n", tmpData[tmpaddr], Data);
#endif

	// read CRC16 of the MAC
#ifdef DS2431_DBG_MSG
		{
			INT8U tmp;
			tmp = ReadByte_DS2431(nUSE);
			pUSART1.printf("6. tmp %02x \n", tmp); 
			mac_crc16 = tmp;
			tmp = ReadByte_DS2431(nUSE);
			pUSART1.printf("7. tmp %02x \n", tmp); 
			
			mac_crc16 |= (((INT16U)tmp << 8) & 0xff00);
			pUSART1.printf("8. mac_crc16_1 %x, %x\n", mac_crc16, i); 
		}
#else
		ReadByte_DS2431(nUSE);
		ReadByte_DS2431(nUSE);
#endif

	////////////////////////////////////////////////////////////////////////////
    if(!RstDS2431(nUSE)) return -1;		// Reset the 1-Wire bus

    WriteByte_DS2431(nUSE, ID_CHIP_COMM_SKIP_ROM); 			// Write Command
    WriteByte_DS2431(nUSE, ID_CHIP_COMM_COPY_SCRATCHPAD); 	// Write Command   
    WriteByte_DS2431(nUSE, (wAddr >> 0) & 0xff); // TA1
    WriteByte_DS2431(nUSE, (wAddr >> 8) & 0xff); // TA2
    WriteByte_DS2431(nUSE, ES); // 
    OSTimeDly(20);				// 복사 함수가 완료될 때까지 12.5ms 대기

	CHK = (INT8U)ReadByte_DS2431(nUSE);

#ifdef DS2431_DBG_MSG    	
    pUSART1.printf("9. CHK = %02x \n", CHK);
#endif

	if(CHK != 0xAA)
	{
 		pUSART1.printf("10. WRITE ERROR!, PLEASE RETRY \n");
 		return -1;
	}
	else return  TRUE;

}

INT16S ReadDS2431Ptr(INT8U nUSE, INT16U Addr, INT8U *Data)
{
    INT8U i = 0;
	INT8U tAddr = Addr%8;
	
	if(!RstDS2431(nUSE)) return -1;

    WriteByte_DS2431(nUSE, ID_CHIP_COMM_SKIP_ROM); 		// Write Command
    WriteByte_DS2431(nUSE, ID_CHIP_COMM_READ_MEMORY); 	// Write Command   
    WriteByte_DS2431(nUSE, ((Addr & ~0x07) & 0xff)); 	// TA1, TA2
    WriteByte_DS2431(nUSE, ID_CHIP_ADDRESS_HI); // 		TA1, TA2
    
    for(i = 0 ; i < 8 ;i++)
    {
    	Data[i] = ReadByte_DS2431(nUSE);
		#ifdef DS2431_DBG_MSG    	
		    pUSART1.printf("2. Data[%d]=%x\n\r",i,Data[i]);
		#endif   
    }
    return (INT16S)(Data[tAddr] & 0xff);
}


INT16S ReadDS2431(INT8U nUSE, INT16U Addr)
{
	INT8U Data;  
	if(!RstDS2431(nUSE)) return -1;

	
    WriteByte_DS2431(nUSE, ID_CHIP_COMM_SKIP_ROM); 		// Write Command
    WriteByte_DS2431(nUSE, ID_CHIP_COMM_READ_MEMORY); 	// Write Command   
    WriteByte_DS2431(nUSE, (Addr >> 0)); // TA1, TA2
    WriteByte_DS2431(nUSE, (Addr >> 8)); // TA1, TA2

    Data = ReadByte_DS2431(nUSE);

    return ((INT16U)Data & 0xff);
}


/*============================================================================*/
void SetDS2431InMode(INT8U nUSE)
{
	if(nUSE == USE_DEV0) GPIOA->CNF.B12 =  __PA12_IN_FL;
}

void SetDS2431OutMode(INT8U nUSE)
{
	if(nUSE == USE_DEV0) GPIOA->CNF.B12 =  __PA12_OU_OD;

}

void SetDS2431DATA(INT8U nUSE)
{
	if(nUSE == USE_DEV0) GPIOA->ODR.B12 = 1;
}

void RstDS2431DATA(INT8U nUSE)
{
	if(nUSE == USE_DEV0) GPIOA->ODR.B12 = 0;
}


INT32U ReadDS2431DATA(INT8U nUSE)
{
	if(nUSE == USE_DEV0) nUSE = GPIOA->IDR.B12;

	return nUSE;
}

void Delay_1us(INT32U us)
{
//	INT32U i = 0;
	INT32S tmp = (us * 8)-14;
	if(tmp < 0) tmp = 0;
	// us == 0 ==>
	// us == 1 ==>
	// us == 2 ==>
	while(tmp--)
	{
	}
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////


