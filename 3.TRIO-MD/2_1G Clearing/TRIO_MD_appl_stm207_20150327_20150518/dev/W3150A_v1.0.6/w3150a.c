/*
 * (c)COPYRIGHT
 * ALL RIGHT RESERVED
 *
 * FileName : w3150a.c
 * Revision History :
 * ----------  -------  -----------  ------------------------------------------------
 * Date        version  Name         Description
 * ----------  -------  -----------  ------------------------------------------------
 * 08/28/2006  1.0.1    Bong       support W3150A+
 * ----------  -------  -----------  ------------------------------------------------
 * 11/10/2006  1.0.2    Jung        modify  iinchip_write/read function, 
 *                                           	wiz_write/read_buffer function
 *                                           	related spi mode I/F          
 * ----------------------------------------------------------------------------------
 * 11/20/2006  1.0.3    Jung        modification  iinchip_irq()
 * ----------------------------------------------------------------------------------
 * 12/27/2006  1.0.4    Hyung      Optimization (use macro function)
 *								modify  	iinchip_write/read function,
 *										 wiz_write/read_buffer function
 *										 iinchip_irq function
 * ----------------------------------------------------------------------------------
 * 08/28/2006  1.0.5    Hyung      Bug fix( fixed "setMR" macro function relate with Indirect 
 * ----------------------------------------------------------------------------------
 * 04/02/2008  1.0.6    Woong     Modification of Socket Command Part
 *								: Check if the appropriately performed after writing Sn_CR	
 *							Modification of SPI Part
 *								: SPI code changed by adding 'spi.h'.
 *								: Change control type for SPI port from byte to bit.
 *							Bug is Fixed in the pppinit() fuction.
 *								: do not clear interrupt value, so fixed.
 *		                   			Modification of ISR
 *                   					: Do not exit ISR, if there is interrupt.
 *							Modification of SetMR() function
 *                   					: Use IINCHIP_WRITE() function in Direct or SPI mode.
 * ------------------------------------------------------------------------------------------------*/
//#include "../../../../STM32F2xx_StdPeriph_Driver/stm32f2xx_conf.h"
#include "stm32f2xx_1208.h"
#include "w3150a.h"
#ifdef __DEF_IINCHIP_PPP__
   #include "md5.h"
#endif
#if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_SPI_MODE__)
	#include "spi.h"
#endif

uint8 I_STATUS[_EthNo][MAX_SOCK_NUM];
uint32 SMASK[_EthNo][MAX_SOCK_NUM];					/* Variable for Tx buffer MASK in each channel */
uint32 RMASK[_EthNo][MAX_SOCK_NUM];					/* Variable for Rx buffer MASK in each channel */
uint16 SSIZE[_EthNo][MAX_SOCK_NUM];					/* Max Tx buffer size by each channel */
uint16 RSIZE[_EthNo][MAX_SOCK_NUM];					/* Max Rx buffer size by each channel */
uint32 SBUFBASEADDRESS[_EthNo][MAX_SOCK_NUM];		/* Tx buffer base address by each channel */
uint32 RBUFBASEADDRESS[_EthNo][MAX_SOCK_NUM];		/* Rx buffer base address by each channel */


void w3150ainit(uint32 nUSE)
{
	////////////////////////////////////////////////////////////////////////////
	// RST port!!
	wSPI0_Init(nUSE);
	iinchip_init(nUSE);
}


/*
**********************************************************
This function writes the data into W3150A registers.
**********************************************************
 */
#if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)
uint8 IINCHIP_WRITE(uint32 nUSE, uint32 addr, uint8 data)
{
	// INDIRECT MODE I/F
	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
		IINCHIP_ISR_DISABLE(nUSE);
		*((vuint8*)IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
		*((vuint8*)IDM_AR1) = (uint8)((addr & 0x00FF) >> 0);
		*((vuint8*)IDM_DR ) = data;
		IINCHIP_ISR_ENABLE(nUSE);
	#else
		//SPI MODE I/F, m200804 [woong] : use spi.h
		IINCHIP_ISR_DISABLE(nUSE);
	
		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start

		IINCHIP_SpiSendData(nUSE, 0xF0);
		IINCHIP_SpiSendData(nUSE, (addr & 0xFF00) >> 8);
		IINCHIP_SpiSendData(nUSE, addr & 0x00FF);
		IINCHIP_SpiSendData(nUSE, data);

		IINCHIP_CSon(nUSE);
		
		IINCHIP_ISR_ENABLE(nUSE);
	#endif
	return 1;
}
#endif

/*
**************************************************************
This function reads the value from W3150A registers.
**************************************************************
 */
#if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)
uint8 IINCHIP_READ(uint32 nUSE, uint32 addr)
{
	uint8 data;
	// INDIRECT MODE I/F
	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)   
		IINCHIP_ISR_DISABLE();
		*((vuint8*)IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
		*((vuint8*)IDM_AR1) = (uint8)(addr & 0x00FF);
		data = *((vuint8*)IDM_DR);
		IINCHIP_ISR_ENABLE(nUSE);
	#else
		//SPI MODE I/F 
		IINCHIP_ISR_DISABLE(nUSE);		
		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start
		IINCHIP_SpiSendData(nUSE, 0x0F);
		IINCHIP_SpiSendData(nUSE, (addr & 0xFF00) >> 8);
		IINCHIP_SpiSendData(nUSE, addr & 0x00FF);		

		data = IINCHIP_SpiRecvData(nUSE, 0);

		IINCHIP_CSon(nUSE);                          	// SPI end

		IINCHIP_ISR_ENABLE(nUSE);
	#endif
	
	return data;
}
#endif

/*
***********************************************************
This function writes into W3150A memory(Buffer)
***********************************************************
 */
#if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)
uint16 wiz_write_buf(uint32 nUSE, uint32 addr, uint8* buf, uint16 len)
{
	uint16 idx = 0;
	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
	IINCHIP_ISR_DISABLE();
	*((vuint8 *) IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
	*((vuint8 *) IDM_AR1) = (uint8) (addr & 0x00FF);
	for (idx = 0; idx < len ; idx++) *((vuint8*)IDM_DR) = buf[idx];
	IINCHIP_ISR_ENABLE();
	#else
	//SPI MODE I/F
	// m200804 [woong] : use spi.h
	IINCHIP_ISR_DISABLE(nUSE);

	for(idx = 0; idx < len; idx++)
	{
		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start 

		IINCHIP_SpiSendData(nUSE, 0xF0);
		IINCHIP_SpiSendData(nUSE, ((addr+idx) & 0xFF00) >> 8);
		IINCHIP_SpiSendData(nUSE, (addr+idx) & 0x00FF);
		IINCHIP_SpiSendData(nUSE, buf[idx]);

		IINCHIP_CSon(nUSE);                             // CS=0, SPI end 
	}

	IINCHIP_ISR_ENABLE();
	#endif
	return len;
}
#endif

/*
************************************************************
This function reads from W3150A memory (Buffer)
************************************************************
 */
#if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)
uint16 wiz_read_buf(uint32 nUSE, uint32 addr, uint8* buf, uint16 len)
{
	uint16 idx = 0;
	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
	IINCHIP_ISR_DISABLE();
	*((vuint8*)IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
	*((vuint8*)IDM_AR1) = (uint8)(addr & 0x00FF);
	for (idx = 0; idx < len ; idx++) buf[idx] = *((vuint8*)IDM_DR);
	IINCHIP_ISR_ENABLE();
	#else
	//SPI MODE I/F
	// m200804 [woong] : use spi.h
	IINCHIP_ISR_DISABLE();

	for (idx=0; idx<len; idx++)
    {
		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start 

		IINCHIP_SpiSendData(nUSE, 0x0F);
		IINCHIP_SpiSendData(nUSE, ((addr+idx) & 0xFF00) >> 8);
		IINCHIP_SpiSendData(nUSE, (addr+idx) & 0x00FF);
		buf[idx] = IINCHIP_SpiRecvData(nUSE, 0);

		IINCHIP_CSon(nUSE);                             // CS=0, SPI end 	   
	}
	IINCHIP_ISR_ENABLE(nUSE);
	#endif
	return len;
}
#endif

/*
*******************************************************
Socket interrupt routine
*******************************************************
*/
void ISR(uint32 nUSE)
{
#ifdef __DEF_IINCHIP_INT__
	uint8 int_val;
	IINCHIP_ISR_DISABLE();
	int_val = IINCHIP_READ(nUSE, IR);

	/* +200804[woong] process all of interupt */
   do {
   /*---*/
	if (int_val & IR_CONFLICT)
	{
		dprintf("IP conflict : %.2x\r\n", int_val);
	}
	if (int_val & IR_UNREACH)
	{
		dprintf("INT Port Unreachable : %.2x\r\n", int_val);
		dprintf("UIPR0 : %d.%d.%d.%d\r\n", IINCHIP_READ(UIPR0), IINCHIP_READ(UIPR0+1), IINCHIP_READ(UIPR0+2), IINCHIP_READ(UIPR0+3));
		dprintf("UPORT0 : %.2x %.2x\r\n", IINCHIP_READ(UPORT0), IINCHIP_READ(UPORT0+1));
	}
	
   	/* +200804[woong] interrupt clear */
   	IINCHIP_WRITE(IR, 0xf0); 
      /*---*/
	  
	if (int_val & IR_SOCK(0))
	{
   	/* +-200804[woong] save interrupt value*/
   		I_STATUS[nUSE][0] |= IINCHIP_READ(Sn_IR(0)); // can be come to over two times.
   		IINCHIP_WRITE(Sn_IR(0), I_STATUS[0]);
      /*---*/
	}
	if (int_val & IR_SOCK(1))
	{
   	/* +-200804[woong] save interrupt value*/
   		I_STATUS[nUSE][1] |= IINCHIP_READ(Sn_IR(1)); // can be come to over two times.
   		IINCHIP_WRITE(Sn_IR(1), I_STATUS[1]);
      /*---*/
	}
	if (int_val & IR_SOCK(2))
	{
   	/* +-200804[woong] save interrupt value*/
   		I_STATUS[2] |= IINCHIP_READ(Sn_IR(2)); // can be come to over two times.
   		IINCHIP_WRITE(Sn_IR(2), I_STATUS[2]);
      /*---*/
	}
	if (int_val & IR_SOCK(3))
	{
   	/* +-200804[woong] save interrupt value*/
   		I_STATUS[3] |= IINCHIP_READ(Sn_IR(3)); // can be come to over two times.
   		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, 3), I_STATUS[nUSE][3]);
      /*---*/
	}

	/* +-200804[woong] re-read interrupt value*/
   	int_val = IINCHIP_READ(nUSE, IR);

	/* +200804[woong] if exist, contiue to process */
   } while (int_val != 0x00);
   /*---*/

	IINCHIP_ISR_ENABLE(nUSE);
	
#endif
}

/*
********************************************************************************
 Initializes the iinchip to work in whether DIRECT or INDIRECT mode
 This function is for resetting of the iinchip.
********************************************************************************
*/
void iinchip_init(uint32 nUSE)
{
////////////////////////////////////////////////////////////////////////////////
	setMR(nUSE, MR_RST);
	OSTimeDly(1000L);

#if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
		setMR(MR_IND | MR_AI);
	#ifdef __DEF_IINCHIP_DBG__	
			dprintf("MR value is %d \r\n", IINCHIP_READ(nUSE, MR));
	#endif	
#endif
}

/*
************************************************************************************
This function set the transmit & receive buffer size as per the channels is used
tx_size Tx memory size (00 - 1KByte, 01- 2KBtye, 10 - 4KByte, 11 - 8KByte)
rx_size Rx memory size (00 - 1KByte, 01- 2KBtye, 10 - 4KByte, 11 - 8KByte)
Note for TMSR and RMSR bits are as follows
bit 1-0 : memory size of channel #0 \n
bit 3-2 : memory size of channel #1 \n
bit 5-4 : memory size of channel #2 \n
bit 7-6 : memory size of channel #3 \n
Maximum memory size for Tx, Rx in the W3150 is 8K Bytes,
In the range of 8KBytes, the memory size could be allocated dynamically by each channel.
Be attentive to sum of memory size shouldn't exceed 8Kbytes
and to data transmission and receiption from non-allocated channel may cause some problems.
If the 8KBytes memory is already  assigned to centain channel, 
other 3 channels couldn't be used, for there's no available memory.
If two 4KBytes memory are assigned to two each channels, 
other 2 channels couldn't be used, for there's no available memory.
************************************************************************************
 */
void sysinit(uint32 nUSE, uint8 tx_size, uint8 rx_size)
{
	int16 i;
	int16 ssum,rsum;

#ifdef __DEF_IINCHIP_DBG__
	dprintf("sysinit()\r\n"); 
#endif

	ssum = 0;
	rsum = 0;
	
	IINCHIP_WRITE(nUSE, TMSR,tx_size); /* Set Tx memory size for each channel */
	IINCHIP_WRITE(nUSE, RMSR,rx_size);	 /* Set Rx memory size for each channel */

	SBUFBASEADDRESS[nUSE][0] = (uint16)(__DEF_IINCHIP_MAP_TXBUF__);		/* Set base address of Tx memory for channel #0 */
	RBUFBASEADDRESS[nUSE][0] = (uint16)(__DEF_IINCHIP_MAP_RXBUF__);		/* Set base address of Rx memory for channel #0 */

#ifdef __DEF_IINCHIP_DBG__
	dprintf("Channel : SEND MEM SIZE : RECV MEM SIZE\r\n");
#endif

   for (i = 0 ; i < MAX_SOCK_NUM; i++)       // Set the size, masking and base address of Tx & Rx memory by each channel
	{
		SSIZE[nUSE][i] = (int16)(0);
		RSIZE[nUSE][i] = (int16)(0);
		if (ssum < 8192)
		{
         switch((tx_size >> i*2) & 0x03)  // Set Tx memory size
			{
			case 0:
				SSIZE[nUSE][i] = (int16)(1024);
				SMASK[nUSE][i] = (uint16)(0x03FF);
				break;
			case 1:
				SSIZE[nUSE][i] = (int16)(2048);
				SMASK[nUSE][i] = (uint16)(0x07FF);
				break;
			case 2:
				SSIZE[nUSE][i] = (int16)(4096);
				SMASK[nUSE][i] = (uint16)(0x0FFF);
				break;
			case 3:
				SSIZE[nUSE][i] = (int16)(8192);
				SMASK[nUSE][i] = (uint16)(0x1FFF);
				break;
			}
		}
		if (rsum < 8192)
		{
         switch((rx_size >> i*2) & 0x03)     // Set Rx memory size
			{
			case 0:
				RSIZE[nUSE][i] = (int16)(1024);
				RMASK[nUSE][i] = (uint16)(0x03FF);
				break;
			case 1:
				RSIZE[nUSE][i] = (int16)(2048);
				RMASK[nUSE][i] = (uint16)(0x07FF);
				break;
			case 2:
				RSIZE[nUSE][i] = (int16)(4096);
				RMASK[nUSE][i] = (uint16)(0x0FFF);
				break;
			case 3:
				RSIZE[nUSE][i] = (int16)(8192);
				RMASK[nUSE][i] = (uint16)(0x1FFF);
				break;
			}
		}
		ssum += SSIZE[nUSE][i];
		rsum += RSIZE[nUSE][i];

      if (i != 0)             // Sets base address of Tx and Rx memory for channel #1,#2,#3
		{
			SBUFBASEADDRESS[nUSE][i] = SBUFBASEADDRESS[nUSE][i-1] + SSIZE[nUSE][i-1];
			RBUFBASEADDRESS[nUSE][i] = RBUFBASEADDRESS[nUSE][i-1] + RSIZE[nUSE][i-1];
		}
#ifdef __DEF_IINCHIP_DBG__
		dprintf("%d : %.4x : %.4x : %.4x : %.4x\r\n", i, (uint16)SBUFBASEADDRESS[nUSE][i], (uint16)RBUFBASEADDRESS[nUSE][i], SSIZE[nUSE][i], RSIZE[nUSE][i]);
#endif
	}
}

/* 200804 regeneration for SPI mode*/
void setMR(uint32 nUSE, uint8 val)
{

#if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
	*((volatile uint8*)(MR)) = val;

#else
	/* 	DIRECT ACCESS	*/
	IINCHIP_WRITE(nUSE, MR, val);
#endif	
}


/*
*********************************************************************
This function sets up gateway IP address.
"addr" is a pointer to a 4 -byte array responsible to set the Gateway IP address.

*********************************************************************
*/
void setGAR(uint32 nUSE, uint8 *addr)
{
	IINCHIP_WRITE(nUSE, (GAR0 + 0),addr[0]);
	IINCHIP_WRITE(nUSE, (GAR0 + 1),addr[1]);
	IINCHIP_WRITE(nUSE, (GAR0 + 2),addr[2]);
	IINCHIP_WRITE(nUSE, (GAR0 + 3),addr[3]);
}
void getGWIP(uint32 nUSE, uint8 *addr)
{
	addr[0] = IINCHIP_READ(nUSE, (GAR0 + 0));
	addr[1] = IINCHIP_READ(nUSE, (GAR0 + 1));
	addr[2] = IINCHIP_READ(nUSE, (GAR0 + 2));
	addr[3] = IINCHIP_READ(nUSE, (GAR0 + 3));
}

/*
*********************************************************************
It sets up SubnetMask address
"addr" is a pointer to a 4 -byte array responsible to set the SubnetMask address

*********************************************************************
*/

void setSUBR(uint32 nUSE, uint8 * addr)
{
	IINCHIP_WRITE(nUSE, (SUBR0 + 0),addr[0]);
	IINCHIP_WRITE(nUSE, (SUBR0 + 1),addr[1]);
	IINCHIP_WRITE(nUSE, (SUBR0 + 2),addr[2]);
	IINCHIP_WRITE(nUSE, (SUBR0 + 3),addr[3]);
}

/*
*********************************************************************
This function sets up MAC address.
"addr" is a pointer to a 6 -byte array responsible to set the MAC address.

*********************************************************************
*/

void setSHAR(uint32 nUSE, uint8 * addr)
{
	IINCHIP_WRITE(nUSE, (SHAR0 + 0),addr[0]);
	IINCHIP_WRITE(nUSE, (SHAR0 + 1),addr[1]);
	IINCHIP_WRITE(nUSE, (SHAR0 + 2),addr[2]);
	IINCHIP_WRITE(nUSE, (SHAR0 + 3),addr[3]);
	IINCHIP_WRITE(nUSE, (SHAR0 + 4),addr[4]);
	IINCHIP_WRITE(nUSE, (SHAR0 + 5),addr[5]);
}

/*
*********************************************************************
This function sets up Source IP address.
"addr" is a pointer to a 4 -byte array responsible to set the Source IP address.

*********************************************************************
*/

void setSIPR(uint32 nUSE, uint8 * addr)
{
	IINCHIP_WRITE(nUSE, (SIPR0 + 0),addr[0]);
	IINCHIP_WRITE(nUSE, (SIPR0 + 1),addr[1]);
	IINCHIP_WRITE(nUSE, (SIPR0 + 2),addr[2]);
	IINCHIP_WRITE(nUSE, (SIPR0 + 3),addr[3]);
}

/*
*********************************************************************
This function sets up Retransmission time.
If there is no response from the peer or delay in response then retransmission 
will be there as per RTR (Retry Time-value Register)setting

*********************************************************************
*/

void setRTR(uint32 nUSE, uint16 timeout)
{
	IINCHIP_WRITE(nUSE, (RTR0 + 0), (uint8)((timeout & 0xff00) >> 8));
	IINCHIP_WRITE(nUSE, (RTR0 + 1), (uint8)(timeout & 0x00ff));
}

/*
*********************************************************************
These below functions are used to get the Gateway, SubnetMask
and Source Hardware Address (MAC Address) and Source IP address
*********************************************************************
*/
void getGAR(uint32 nUSE, uint8 * addr)
{
	addr[0] = IINCHIP_READ(nUSE, GAR0);
	addr[1] = IINCHIP_READ(nUSE, GAR0+1);
	addr[2] = IINCHIP_READ(nUSE, GAR0+2);
	addr[3] = IINCHIP_READ(nUSE, GAR0+3);
}
void getSUBR(uint32 nUSE, uint8 * addr)
{
	addr[0] = IINCHIP_READ(nUSE, SUBR0);
	addr[1] = IINCHIP_READ(nUSE, SUBR0+1);
	addr[2] = IINCHIP_READ(nUSE, SUBR0+2);
	addr[3] = IINCHIP_READ(nUSE, SUBR0+3);
}
void getSHAR(uint32 nUSE, uint8 * addr)
{
	addr[0] = IINCHIP_READ(nUSE, SHAR0);
	addr[1] = IINCHIP_READ(nUSE, SHAR0+1);
	addr[2] = IINCHIP_READ(nUSE, SHAR0+2);
	addr[3] = IINCHIP_READ(nUSE, SHAR0+3);
	addr[4] = IINCHIP_READ(nUSE, SHAR0+4);
	addr[5] = IINCHIP_READ(nUSE, SHAR0+5);
}
void getSIPR(uint32 nUSE, uint8 * addr)
{
	addr[0] = IINCHIP_READ(nUSE, SIPR0);
	addr[1] = IINCHIP_READ(nUSE, SIPR0+1);
	addr[2] = IINCHIP_READ(nUSE, SIPR0+2);
	addr[3] = IINCHIP_READ(nUSE, SIPR0+3);
}


/*
*********************************************************************
These below functions are used to get the Destination Hardware Address (MAC Address),
Destination IP address and Destination Port.
*********************************************************************
*/
void getSn_DHAR(uint32 nUSE, SOCKET s, uint8 * addr)
{
	addr[0] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s));
	addr[1] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+1);
	addr[2] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+2);
	addr[3] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+3);
	addr[4] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+4);
	addr[5] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+5);
}
void setSn_DHAR(uint32 nUSE, SOCKET s, uint8 * addr)
{
	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 0),addr[0]);
	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 1),addr[1]);
	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 2),addr[2]);
	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 3),addr[3]);
	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 4),addr[4]);
	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 5),addr[5]);
}
void getSn_DIPR(uint32 nUSE, SOCKET s, uint8 * addr)
{
	addr[0] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s));
	addr[1] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s)+1);
	addr[2] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s)+2);
	addr[3] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s)+3);
}
void setSn_DIPR(uint32 nUSE, SOCKET s, uint8 * addr)
{
	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 0),addr[0]);
	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 1),addr[1]);
	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 2),addr[2]);
	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 3),addr[3]);
}
void getSn_DPORT(uint32 nUSE, SOCKET s, uint8 * addr)
{
	addr[0] = IINCHIP_READ(nUSE, Sn_DPORT0(nUSE, s));
	addr[1] = IINCHIP_READ(nUSE, Sn_DPORT0(nUSE, s)+1);
}
void setSn_DPORT(uint32 nUSE, SOCKET s, uint8 * addr)
{
	IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 0),addr[0]);
	IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 1),addr[1]);
}

/*
*********************************************************************
This sets the maximum segment size of TCP in Active Mode),
while in Passive Mode this is set by peer
*********************************************************************
*/

void setSn_MSS(uint32 nUSE, SOCKET s, uint16 Sn_MSSR0)
{
	IINCHIP_WRITE(nUSE, (Sn_MSSR0(nUSE, s) + 0),(uint8)((Sn_MSSR0 & 0xff00) >> 8));
	IINCHIP_WRITE(nUSE, (Sn_MSSR0(nUSE, s) + 1),(uint8)(Sn_MSSR0 & 0x00ff));
}

/*
*********************************************************************
This gives free buffer size of transmit buffer. This is the data size that user can transmit.
User shuold check this value first and control the size of transmitting data
*********************************************************************
*/

uint16 getSn_TX_FSR(uint32 nUSE, SOCKET s) // get socket TX free buf size
{
	uint16 val=0,val1=0;
	do
	{
		val1 = IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE, s));
		val1 = (val1 << 8) + IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE,s) + 1);
      if (val1 != 0)
		{
   			val = IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE, s));
   			val = (val << 8) + IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE, s) + 1);
		}
	} while (val != val1);
   return val;
}

/*
*********************************************************************
This gives size of received data in receive buffer. 
*********************************************************************
*/
uint16 getSn_RX_RSR(uint32 nUSE, SOCKET s) // get socket RX recv buf size
{
	uint16 val = 0, val1 = 0;
	do
	{
		val1 = IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s));
		val1 = (val1 << 8) + IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s) + 1);
		if(val1 != 0)
		{
   			val = IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s));
   			val = (val << 8) + IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s) + 1);
		}
	} while (val != val1);
   return val;
}


/*
*********************************************************************
This function is being called by send() and sendto() function also. This function read the 
Tx write pointer register and after copy the data in buffer update the Tx write pointer
register. User should read upper byte first and lower byte later to get proper value.
*********************************************************************
*/

void send_data_processing(uint32 nUSE, SOCKET s, uint8 *data, uint16 len)
{
	uint16 ptr;
	ptr = IINCHIP_READ(nUSE, Sn_TX_WR0(nUSE, s));
	ptr = ((ptr & 0x00ff) << 8) + IINCHIP_READ(nUSE, Sn_TX_WR0(nUSE, s) + 1);
	write_data(nUSE, s, data, (uint8 *)(ptr), len);
	ptr += len;
	IINCHIP_WRITE(nUSE,  Sn_TX_WR0(nUSE, s)     , (uint8)((ptr & 0xff00) >> 8));
	IINCHIP_WRITE(nUSE, (Sn_TX_WR0(nUSE, s) + 1), (uint8) (ptr & 0x00ff)      );
}


/*
*********************************************************************
This function is being called by recv() also. This function read the Rx read pointer register
and after copy the data from receive buffer update the Rx write pointer register.
User should read upper byte first and lower byte later to get proper value.
*********************************************************************
*/

void recv_data_processing(uint32 nUSE, SOCKET s, uint8 *data, uint16 len)
{
	uint16 ptr;
	ptr = IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s));
	ptr = ((ptr & 0x00ff) << 8) + IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s) + 1);
#ifdef __DEF_IINCHIP_DBG__
	dprintf("ISR_RX: rd_ptr : %.4x\r\n", ptr);
#endif
	read_data(nUSE, s, (uint8 *)ptr, data, len); // read data
	ptr += len;
	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 0), (uint8)((ptr & 0xff00) >> 8));
	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1), (uint8)((ptr & 0x00ff) >> 0));
}

/*
*********************************************************************
This function is being used for copy the data form application buffer to Transmite
buffer of the chip. It calculate the actual physical address where one has to write
the data in transmite buffer. Here also take care of the condition while it exceed
the Tx memory uper-bound of socket.
*********************************************************************
*/

void write_data(uint32 nUSE, SOCKET s, vuint8 *src, vuint8 *dst, uint16 len)
{
	uint16 size;
	uint32 dst_mask;
	uint8 *dst_ptr;

	dst_mask = (uint32)dst & getIINCHIP_TxMASK(nUSE, s);
	dst_ptr = (uint8 *)(getIINCHIP_TxBASE(nUSE, s) + dst_mask);
	
	if (dst_mask + len > getIINCHIP_TxMAX(nUSE, s)) 
	{
		size = getIINCHIP_TxMAX(nUSE, s) - dst_mask;
		wiz_write_buf(nUSE, (uint32)dst_ptr, (uint8*)src, size);
		src += size;
		size = len - size;
		dst_ptr = (uint8 *)(getIINCHIP_TxBASE(nUSE, s));
		wiz_write_buf(nUSE, (uint32)dst_ptr, (uint8*)src, size);
	} 
	else
	{
		wiz_write_buf(nUSE, (uint32)dst_ptr, (uint8*)src, len);
	}
}

/*
*********************************************************************
This function is being used for copy the data form Receive buffer of the chip to
application buffer. It calculate the actual physical address where one has to read
the data from Receive buffer. Here also take care of the condition while it exceed
the Rx memory uper-bound of socket.
*********************************************************************
*/

void read_data(uint32 nUSE, SOCKET s, vuint8 * src, vuint8 * dst, uint16 len)
{
	uint16 size;
	uint32 src_mask;
	uint8 *src_ptr;

	src_mask = (uint32)src & getIINCHIP_RxMASK(nUSE, s);
	src_ptr =  (uint8 *)(getIINCHIP_RxBASE(nUSE, s) + src_mask);
	
	if( (src_mask + len) > getIINCHIP_RxMAX(nUSE, s) ) 
	{
		size = getIINCHIP_RxMAX(nUSE, s) - src_mask;
		wiz_read_buf(nUSE, (uint32)src_ptr, (uint8*)dst, size);
		dst += size;
		size = len - size;
		src_ptr = (uint8 *)(getIINCHIP_RxBASE(nUSE, s));
		wiz_read_buf(nUSE, (uint32)src_ptr, (uint8*) dst,size);
	} 
	else
	{
		wiz_read_buf(nUSE, (uint32)src_ptr, (uint8*) dst,len);
	}
}

#if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_SPI_MODE__)

uint16 IINCHIP_SpiSendData(uint32 nUSE, uint8 Comm)
{
	INT8U rtry = 0xff;
	SPI_TypeDef *nBASE = SPI_BASE(nUSE);
	nBASE = nBASE;
	
	while(rtry-- && SPI_I2S_GetFlagStatus(SPI_BASE(nUSE), SPI_I2S_FLAG_TXE) == RESET);
	// Send SPI2 data
	SPI_I2S_SendData(SPI_BASE(nUSE), Comm);
	// Wait to receive a byte
  	while(rtry-- && SPI_I2S_GetFlagStatus(SPI_BASE(nUSE), SPI_I2S_FLAG_RXNE) == RESET);
	// Return the byte read from the SPI bus
	return SPI_I2S_ReceiveData(SPI_BASE(nUSE));
}
#endif


#ifdef __DEF_IINCHIP_PPP__

/*
* make PPPoE connection
* return :
* 1 => success to connect
* 2 => Auth fail
* 3 => timeout
* 4 => Auth type not support
*/
#define PPP_OPTION_BUF_LEN 64
uint8 pppinit_in(uint32 nUSE, uint8 * id, uint8 idlen, uint8 * passwd, uint8 passwdlen);

uint8 pppinit(uint32 nUSE, uint8 * id, uint8 idlen, uint8 * passwd, uint8 passwdlen)
{
	uint8 ret;
	uint8 isr;
	
	// PHASE0. W3150A+ PPPoE(ADSL) setup
	// enable pppoe mode
	dprintf("-- PHASE 0. W3150A+ PPPoE(ADSL) setup process --\r\n");
	dprintf("\r\n");
	setMR(nUSE, INCHIP_READ(MR) | MR_PPPOE);

	// open socket in pppoe mode
	isr = getSn_IR(nUSE, 0);// first clear isr(0), W3150A+ at present time
	setSn_IR(nUSE, 0, isr);
	
	IINCHIP_WRITE(nUSE, PTIMER, 200); // 5sec timeout
	IINCHIP_WRITE(nUSE, PMAGIC, 0x01); // magic number
	IINCHIP_WRITE(nUSE, Sn_MR(nUSE, 0),Sn_MR_PPPOE);
	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0),Sn_CR_OPEN);

	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, 0)) );
	/* ------- */
	
	ret = pppinit_in(nUSE, id, idlen, passwd, passwdlen);

	// close ppp connection socket
	/* m200804 [woong]*/
	close(0);
	/* --------- */
	
	return ret;
}

uint8 pppinit_in(uint32 nUSE, uint8 * id, uint8 idlen, uint8 * passwd, uint8 passwdlen)
{
	uint8 loop_idx = 0;
	uint8 isr = 0;
	uint8 buf[PPP_OPTION_BUF_LEN];
	uint16 len;
	uint8 str[PPP_OPTION_BUF_LEN];
	uint8 str_idx,dst_idx;

   // PHASE1. PPPoE Discovery
	// start to connect pppoe connection
	dprintf("-- PHASE 1. PPPoE Discovery process --");
	dprintf(" ok\r\n");
	dprintf("\r\n");
	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0), Sn_CR_PCON);
	/* +200804[woong]:wait to process the command... */
	while(IINCHIP_READ(nUSE, Sn_CR(nUSE, 0)));
	/* ------- */

	wait_10ms(100);  // you should make delay function.

	loop_idx = 0;
	//check whether PPPoE discovery end or not
	while (!(getSn_IR(nUSE, 0) & Sn_IR_PNEXT))
	{
		dprintf(".");
		if (loop_idx++ == 10) // timeout
		{
			dprintf("timeout before LCP\r\n"); 
			return 3;
		}
		wait_10ms(100);
	}

  /* +200804[woong] clear interrupt value*/
   IINCHIP_WRITE(nUSE, Sn_IR(nUSE, 0), 0xff);
   /*---*/
   
   // PHASE2. LCP process
	dprintf("-- PHASE 2. LCP process --");
		
	// send LCP Request
	{
		// Magic number option
		// option format (type value + length value + data)
	   // write magic number value
		buf[0] = 0x05; // type value
		buf[1] = 0x06; // length value
		buf[2] = 0x01; buf[3] = 0x01; buf[4] = 0x01; buf[5]= 0x01; // data
		// for MRU option, 1492 0x05d4  
		// buf[6] = 0x01; buf[7] = 0x04; buf[8] = 0x05; buf[9] = 0xD4;
	}
	send_data_processing(0, buf, 0x06);
	IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); // send request 

	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(Sn_CR(0)) );
	/* ------- */

	wait_10ms(100);

	while (!((isr = getSn_IR(0)) & Sn_IR_PNEXT))
	{
		if (isr & Sn_IR_PRECV) // Not support option
		{
		/* +200801[bj] clear interrupt value*/
		IINCHIP_WRITE(Sn_IR(0), Sn_IR_PRECV);
		/*---*/

		len = getSn_RX_RSR(0);
	      	if ( len > 0 )
		      	{
		      		recv_data_processing(0, str, len);
		      		IINCHIP_WRITE(Sn_CR(0),Sn_CR_RECV);
				/* +200804[woong]:wait to process the command... */
				while( IINCHIP_READ(Sn_CR(0)) );
				/* ------- */

	   			// for debug
	   			//dprintf("LCP proc\r\n"); for (i = 0; i < len; i++) dprintf ("%02x ", str[i]); dprintf("\r\n");
	   			// get option length
	   			len = str[4]; len = ((len & 0x00ff) << 8) + str[5];
	   			len += 2;
	   			str_idx = 6; dst_idx = 0; // ppp header is 6 byte, so starts at 6.
	   			do 
	   			{
	   				if ((str[str_idx] == 0x01) || (str[str_idx] == 0x02) || (str[str_idx] == 0x03) || (str[str_idx] == 0x05))
	   				{
	   					// skip as length of support option. str_idx+1 is option's length.
	   					str_idx += str[str_idx+1];
	   				}
	   				else
	   				{
	   					// not support option , REJECT
	   					memcpy((uint8 *)(buf+dst_idx), (uint8 *)(str+str_idx), str[str_idx+1]);
	   					dst_idx += str[str_idx+1]; str_idx += str[str_idx+1];
	   				}
	   			} while (str_idx != len);
	   			// for debug
	   			// dprintf("LCP dst proc\r\n"); for (i = 0; i < dst_idx; i++) dprintf ("%02x ", dst[i]); dprintf("\r\n");
	   
	   			// send LCP REJECT packet
	   			send_data_processing(0, buf, dst_idx);
	   			IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCJ);
				/* +200804[woong]:wait to process the command... */
				while( IINCHIP_READ(Sn_CR(0)) );
				/* ------- */

		      	}
		}
		dprintf(".");
		if (loop_idx++ == 10) // timeout
		{
			dprintf("timeout after LCP\r\n");
			return 3;
		}
		wait_10ms(100);
	}
	dprintf(" ok\r\n");
	dprintf("\r\n");

	/* +200804[woong] clear interrupt value*/
	IINCHIP_WRITE(Sn_IR(0), 0xff);
	/*---*/
	
	dprintf("-- PHASE 3. PPPoE(ADSL) Authentication mode --\r\n");
	dprintf("Authentication protocol : %.2x %.2x, ", IINCHIP_READ(PATR0), IINCHIP_READ(PATR0+1));

	loop_idx = 0;
	if (IINCHIP_READ(PATR0) == 0xc0 && IINCHIP_READ(PATR0+1) == 0x23)
	{
		dprintf("PAP\r\n"); // in case of adsl normally supports PAP.
		// send authentication data
		// copy (idlen + id + passwdlen + passwd)
		buf[loop_idx] = idlen; loop_idx++;
		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(id), idlen); loop_idx += idlen;
		buf[loop_idx] = passwdlen; loop_idx++;
		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(passwd), passwdlen); loop_idx += passwdlen;
		send_data_processing(0, buf, loop_idx);
		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR);
		/* +200804[woong]:wait to process the command... */
		while( IINCHIP_READ(Sn_CR(0)) );
		/* ------- */

		wait_10ms(100);
	}
	
	else if (IINCHIP_READ(PATR0) == 0xc2 && IINCHIP_READ(PATR0+1) == 0x23)
	{
		uint8 chal_len;
   		md5_ctx context;
	   	uint8  digest[16];

		len = getSn_RX_RSR(0);
   		if ( len > 0 )
	   	{
	   		recv_data_processing(0, str, len);
	   		IINCHIP_WRITE(Sn_CR(0),Sn_CR_RECV);
			/* +200804[woong]:wait to process the command... */
			while( IINCHIP_READ(Sn_CR(0)) );
			/* ------- */

#ifdef __DEF_IINCHIP_DBG__
			dprintf("recv CHAP\r\n");
			int16 i;
			for (i = 0; i < 32; i++) dprintf ("%02x ", str[i]);
			dprintf("\r\n");
#endif
	// str is C2 23 xx CHAL_ID xx xx CHAP_LEN CHAP_DATA
	// index  0  1  2  3       4  5  6        7 ...

	   		memset(buf,0x00,64);
	   		buf[loop_idx] = str[3]; loop_idx++; // chal_id
	   		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(passwd), passwdlen); loop_idx += passwdlen; //passwd
	   		chal_len = str[6]; // chal_id
	   		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(str+7), chal_len); loop_idx += chal_len; //challenge
			   buf[loop_idx] = 0x80;
#ifdef __DEF_IINCHIP_DBG__
			dprintf("CHAP proc d1\r\n");
			//int16 i;
			for (i = 0; i < 64; i++) dprintf ("%02x ", buf[i]);
			dprintf("\r\n");
#endif

	   		md5_init(&context);
	   		md5_update(&context, buf, loop_idx);
	   		md5_final(digest, &context);

#ifdef __DEF_IINCHIP_DBG__
			dprintf("CHAP proc d1\r\n");
			for (i = 0; i < 16; i++) dprintf ("%02x", digest[i]);
			dprintf("\r\n");
#endif
	   		loop_idx = 0;
	   		buf[loop_idx] = 16; loop_idx++; // hash_len
	     		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(digest), 16); loop_idx += 16; // hashed value
	     		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(id), idlen); loop_idx += idlen; // id
	   		send_data_processing(0, buf, loop_idx);
	   		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR);
			/* +200804[woong]:wait to process the command... */
			while( IINCHIP_READ(Sn_CR(0)) );
			/* ------- */

	   		wait_10ms(100);
	      }
   }

	else
	{
		dprintf("Not support\r\n");
#ifdef __DEF_IINCHIP_DBG__
		dprintf("Not support PPP Auth type: %.2x%.2x\r\n",IINCHIP_READ(PATR0), IINCHIP_READ(PATR0+1));
#endif
		return 4;
	}
	dprintf("\r\n");

	dprintf("-- Waiting for PPPoE server's admission --");
	loop_idx = 0;
	while (!((isr = getSn_IR(0)) & Sn_IR_PNEXT))
	{
		if (isr & Sn_IR_PFAIL)
		{
		   	/* +200804[woong] clear interrupt value*/
		   	IINCHIP_WRITE(Sn_IR(0), 0xff);
		   	/*---*/

			dprintf("failed\r\nReinput id, password..\r\n");
			return 2;
		}
		dprintf(".");
		if (loop_idx++ == 10) // timeout
		{
		   	/* +200804[woong] clear interrupt value*/
		   	IINCHIP_WRITE(Sn_IR(0), 0xff);
		   	/*---*/

			dprintf("timeout after PAP\r\n");
			return 3;
		}
		wait_10ms(100);
	}

   	/* +200804[woong] clear interrupt value*/
   	IINCHIP_WRITE(Sn_IR(0), 0xff);
   	/*---*/
	dprintf("ok\r\n");
	dprintf("\r\n");
	dprintf("-- PHASE 4. IPCP process --");
	// IP Address
	buf[0] = 0x03; buf[1] = 0x06; buf[2] = 0x00; buf[3] = 0x00; buf[4] = 0x00; buf[5] = 0x00;
	send_data_processing(0, buf, 6);
	IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR);
	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(Sn_CR(0)) );
	/* ------- */

	wait_10ms(100);

	loop_idx = 0;
	while (1)
	{
		if (getSn_IR(0) & Sn_IR_PRECV)
		{
		/* +200804[woong] clear interrupt value*/
		IINCHIP_WRITE(Sn_IR(0), 0xff);
		/*---*/
		len = getSn_RX_RSR(0);
	      	if ( len > 0 )
		      	{
		      		recv_data_processing(0, str, len);
		      		IINCHIP_WRITE(Sn_CR(0),Sn_CR_RECV);
				/* +200804[woong]:wait to process the command... */
				while( IINCHIP_READ(Sn_CR(0)) );
				/* ------- */
	   			//for debug
	   			//dprintf("IPCP proc\r\n"); for (i = 0; i < len; i++) dprintf ("%02x ", str[i]); dprintf("\r\n");
	   			str_idx = 6; dst_idx = 0;
	   			if (str[2] == 0x03) // in case of NAK
		   			{
		   				do 
		   				{
		   					if (str[str_idx] == 0x03) // request only ip information
		   					{
		   						memcpy((uint8 *)(buf+dst_idx), (uint8 *)(str+str_idx), str[str_idx+1]);
		   						dst_idx += str[str_idx+1]; str_idx += str[str_idx+1];
		   					}
		   					else
		   					{
		   						// skip byte
		   						str_idx += str[str_idx+1];
		   					}
		   					// for debug
		   					//dprintf("s: %d, d: %d, l: %d", str_idx, dst_idx, len);
		   				} while (str_idx != len);
		   				send_data_processing(0, buf, dst_idx);
		   				IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); // send ipcp request
		   				/* +200804[woong]:wait to process the command... */
						while( IINCHIP_READ(Sn_CR(0)) );
						/* ------- */
		   				wait_10ms(100);
		   				break;
		   			}
		      	}
		}
		dprintf(".");
		if (loop_idx++ == 10) // timeout
		{
			dprintf("timeout after IPCP\r\n");
			return 3;
		}
		wait_10ms(100);
		send_data_processing(0, buf, 6);
		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); //ipcp re-request
		/* +200804[woong]:wait to process the command... */
		while( IINCHIP_READ(Sn_CR(0)) );
		/* ------- */

	}

	loop_idx = 0;
	while (!(getSn_IR(0) & Sn_IR_PNEXT))
	{
		dprintf(".");
		if (loop_idx++ == 10) // timeout
		{
			dprintf("timeout after IPCP NAK\r\n");
			return 3;
		}
		wait_10ms(100);
		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); // send ipcp request
		/* +200804[woong]:wait to process the command... */
		while( IINCHIP_READ(Sn_CR(0)) );
		/* ------- */
	}
	/* +200804[woong] clear interrupt value*/
	IINCHIP_WRITE(Sn_IR(0), 0xff);
	/*---*/
	dprintf("ok\r\n");
	dprintf("\r\n");
	return 1;
	// after this function, User must save the pppoe server's mac address and pppoe session id in current connection
}

/*
* terminate PPPoE connection
*/
uint8 pppterm(uint8 * mac, uint8 * sessionid)
{
	uint16 i;
	uint8 isr;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("pppterm()\r\n");
#endif
	/* Set PPPoE bit in MR(Common Mode Register) : enable socket0 pppoe */
	setMR(IINCHIP_READ(MR) | MR_PPPOE);
	
	// write pppoe server's mac address and session id 
	// must be setted these value.
	for (i = 0; i < 6; i++) IINCHIP_WRITE((Sn_DHAR0(0)+i),mac[i]);
	for (i = 0; i < 2; i++) IINCHIP_WRITE((Sn_DPORT0(0)+i),sessionid[i]);
	isr = getSn_IR(0);
	setSn_IR(0, isr);
	
	//open socket in pppoe mode
	IINCHIP_WRITE(Sn_MR(0),Sn_MR_PPPOE);
	IINCHIP_WRITE(Sn_CR(0),Sn_CR_OPEN);
	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(Sn_CR(0)) );
	/* ------- */
	wait_1us(1);
	// close pppoe connection
	IINCHIP_WRITE(Sn_CR(0),Sn_CR_PDISCON);
	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(Sn_CR(0)) );
	/* ------- */
	wait_10ms(100);
	// close socket. m200804[woong]
	close(0);

#ifdef __DEF_IINCHIP_DBG__
	dprintf("pppterm() end ..\r\n");
#endif

	return 1;
}


#endif
