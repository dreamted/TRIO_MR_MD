/*
 * (c)COPYRIGHT
 * ALL RIGHT RESERVED
 *
 * FileName : socket.c
 * Last update : April. 2008
 ---------------------------------------------------------------------------------------*/
//#include "../../../../STM32F2xx_StdPeriph_Driver/stm32f2xx_conf.h"
#include "stm32f2xx_1208.h"
#include "types.h"
#include "w3150a.h"
#include "socket.h"

unsigned long int (*dprintf)( const char *format, ... ) = USART1Printf;
uint16 local_port;

/*
*********************************************************************
This Socket function initialize the channel in perticular mode, and set the port
and wait for W3150A+ done it.
And the Parameters "s" is for socket number, "protocol" is for socket protocol,
port is the source port for the socket and flag is the option for the socket.
This function return 1 for sucess else 0.
*********************************************************************
*/
void setSHAR(uint32 nUSE, uint8 * addr);
void getSHAR(uint32 nUSE, uint8 * addr);

uint8 socket(uint32 nUSE, SOCKET s, uint8 protocol, uint16 port, uint8 flag)
{
	uint8 ret;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("socket()\r\n");
#endif
	if ((protocol == Sn_MR_TCP) || (protocol == Sn_MR_UDP) || (protocol == Sn_MR_IPRAW) || (protocol == Sn_MR_MACRAW) || (protocol == Sn_MR_PPPOE))
	{
		close(nUSE, s);
		IINCHIP_WRITE(nUSE, Sn_MR(nUSE, s), protocol | flag);
		if (port != 0) {
			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 0), (uint8)((port & 0xff00) >> 8));
			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 1), (uint8)((port & 0x00ff) >> 0));
		} else {
			local_port++; // if don't set the source port, set local_port number.
			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 0), (uint8)((local_port & 0xff00) >> 8));
			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 1), (uint8)((local_port & 0x00ff) >> 0));
		}
		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_OPEN); // run sockinit Sn_CR
		/* +200804[woong]:wait to process the command... */
		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
		/* ------- */
		ret = 1;
	}
	else
	{
		ret = 0;
	}
#ifdef __DEF_IINCHIP_DBG__
	dprintf("Sn_SR = %.2x , Protocol = %.2x\r\n", IINCHIP_READ(nUSE, Sn_SR(nUSE, s)), IINCHIP_READ(nUSE, Sn_MR(nUSE, s)));
#endif
	return ret;
}
/*
*********************************************************************
This function close the socket and parameter is "s" which represent the socket number
*********************************************************************
*/

void close(uint32 nUSE, SOCKET s)
{
#ifdef __DEF_IINCHIP_DBG__
	dprintf("close()\r\n");
#endif
	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_CLOSE);

	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
	/* ------- */

	/* +2008.04[woong]: clear interrupt */	
	#ifdef __DEF_IINCHIP_INT__
      /* m2008.04 [woong] : all clear */
	       setISR(nUSE, s, 0x00);
	#else
      /* m2008.04 [woong] : all clear */
		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), 0xFF);
	#endif
	
}

/*
*********************************************************************
This function established  the connection for the channel in passive (server) mode.
This function waits for the request from the peer. The parameter "s" is the socket number
This function return 1 for success else 0.
*********************************************************************
*/

uint8 listen(uint32 nUSE, SOCKET s)
{
	uint8 ret;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("listen()\r\n");
#endif
	if (IINCHIP_READ(nUSE, Sn_SR(nUSE, s)) == SOCK_INIT)
	{
		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_LISTEN);
		/* +200804[woong]:wait to process the command... */
		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
		/* ------- */
		ret = 1;
	}
	else
	{
		ret = 0;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("Fail[invalid ip,port]\r\n");
#endif
	}
	return ret;
}


/*
*********************************************************************
This function established  the connection for the channel in Active (client) mode. 
This function waits for the untill the connection is established. The parameter "s" is the socket number
This function return 1 for success else 0.
*********************************************************************
*/

uint8 connect(uint32 nUSE, SOCKET s, uint8 * addr, uint16 port)
{
	uint8 ret;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("connect()\r\n");
#endif
	if 
		(
			((addr[0] == 0xFF) && (addr[1] == 0xFF) && (addr[2] == 0xFF) && (addr[3] == 0xFF)) ||
		 	((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) && (addr[3] == 0x00)) ||
		 	(port == 0x00) 
		) 
 	{
 		ret = 0;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("Fail[invalid ip,port]\r\n");
#endif
	}
	else
	{

		ret = 1;
		// set destination IP
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 0), addr[0]);
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 1), addr[1]);
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 2), addr[2]);
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 3), addr[3]);
		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 0),(uint8)((port & 0xff00) >> 8));
		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 1),(uint8)((port & 0x00ff) >> 0));
		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_CONNECT);
		// wait for completion
		while (IINCHIP_READ(nUSE, Sn_CR(nUSE, s)))
		{
			if (IINCHIP_READ(nUSE, Sn_SR(nUSE, s)) == SOCK_CLOSED)
			{
#ifdef __DEF_IINCHIP_DBG__
			dprintf("SOCK_CLOSED.\r\n");
#endif
				ret = 0; break;
			}
		}
	}

	return ret;
}


/*
*********************************************************************
This function used for disconnect the socket and parameter is "s" which represent the socket number
*********************************************************************
*/

void disconnect(uint32 nUSE, SOCKET s)
{
#ifdef __DEF_IINCHIP_DBG__
	dprintf("disconnect()\r\n");
#endif
	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_DISCON);
	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
	/* ------- */
}

/*
*********************************************************************
This function used to send the data in TCP mode and the parameter "s" represents
the socket number and "buf" a pointer to data and "len" is the data size to be send.
This function return 1 for success else 0.
*********************************************************************
*/

uint16 send(uint32 nUSE, SOCKET s, const uint8 * buf, uint16 len)
{
	uint8 status=0;
	uint16 ret=0;
	uint16 freesize=0;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("send()\r\n");
#endif

	if (len > getIINCHIP_TxMAX(nUSE, s)) ret = getIINCHIP_TxMAX(nUSE, s); // check size not to exceed MAX size.
	else ret = len;

	// if freebuf is available, start.
	do 
	{
		freesize = getSn_TX_FSR(nUSE, s);
		status = IINCHIP_READ(nUSE, Sn_SR(nUSE, s));
		if ((status != SOCK_ESTABLISHED) && (status != SOCK_CLOSE_WAIT)) {ret = 0; break;}
#ifdef __DEF_IINCHIP_DBG__
		dprintf("socket %d freesize(%d) empty or error\r\n", s, freesize);
#endif
	} while (freesize < ret);

	// copy data
	send_data_processing(nUSE, s, (uint8 *)buf, ret);
	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_SEND);
	/* +200804[woong]:wait to process the command... */
	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
	/* ------- */

/* +2008.04 [woong] */	
#ifdef __DEF_IINCHIP_INT__
	while ( (getISR(s) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
#else
	while ( (IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
#endif
	{
		/* m2008.04 [woong] : reduce code */
		if ( IINCHIP_READ(nUSE, Sn_SR(nUSE, s)) == SOCK_CLOSED )
		{
#ifdef __DEF_IINCHIP_DBG__
			dprintf("SOCK_CLOSED.\r\n");
#endif
			close(nUSE, s);
			return 0;
		}
  	}
/* +2008.04 [woong] */	
#ifdef __DEF_IINCHIP_INT__
  	setISR(nUSE, s, getISR(nUSE, s) & (~Sn_IR_SEND_OK));
#else
	IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_SEND_OK);
#endif
  	return ret;
}


/*
*********************************************************************
This function is an application I/F function which is used to receive the data in TCP mode.
It continues to wait for data as much as the application wants to receive and the 
parameter "s" represents the socket number and "buf" a pointer to copy the data
to be received and "len" is the data size to be read. This function return received data size
for success else -1.
*********************************************************************
*/

uint16 recv(uint32 nUSE, SOCKET s, uint8 * buf, uint16 len)
{
	uint16 ret=0;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("recv()\r\n");
#endif


	if ( len > 0 )
	{
		recv_data_processing(nUSE, s, buf, len);
		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_RECV);
		/* +200804[woong]:wait to process the command... */
		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
		/* ------- */
		ret = len;
	}
	return ret;
}

/*
*********************************************************************
This function is an application I/F function which is used to send the data for other then
TCP mode. Unlike TCP transmission, The peer's destination address and the port is needed.
and the parameter "s" represents the socket number and "buf" a pointer to the data 
and "len" is the data size to send and addr is the peer's Destination IP address and port is
the peer's destination port number. This function return send data size for success else -1.
*********************************************************************
*/
uint16 sendto(uint32 nUSE, SOCKET s, const uint8 * buf, uint16 len, uint8 * addr, uint16 port)
{
	uint16 ret = 0;
	
#ifdef __DEF_IINCHIP_DBG__
	dprintf("sendto()\r\n");
#endif
   if (len > getIINCHIP_TxMAX(nUSE, s)) ret = getIINCHIP_TxMAX(nUSE, s); // check size not to exceed MAX size.
   else ret = len;

	if
		(
		 	((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) && (addr[3] == 0x00)) ||
		 	((port == 0x00)) ||(ret == 0)
		) 
 	{
 	  /* +2008.04 [woong] : added return value */
 	  ret = 0; 
#ifdef __DEF_IINCHIP_DBG__
	dprintf("%d Fail[%.2x.%.2x.%.2x.%.2x, %.d, %d]\r\n",s, addr[0], addr[1], addr[2], addr[3] , port, len);
	dprintf("Fail[invalid ip,port]\r\n");
#endif
	}
	else
	{
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s)    ),addr[0]);
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 1),addr[1]);
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 2),addr[2]);
		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 3),addr[3]);
		
		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s)    ),(uint8)((port & 0xff00) >> 8));
		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 1),(uint8)((port & 0x00ff) >> 0));

		// copy data
		send_data_processing(nUSE, s, (uint8 *)buf, ret);
		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_SEND);
		/* +200804[woong]:wait to process the command... */
		while(IINCHIP_READ(nUSE, Sn_CR(nUSE, s)));
		/* ------- */
		//USART1Printf("IINCHIP_READ(Sn_CR(s)) == %x \n", IINCHIP_READ(Sn_CR(s)));
		
/* +2008.04 [woong] */	
#ifdef __DEF_IINCHIP_INT__
   		while ( (getISR(s) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
#else
		{
			uint32 cnt = 10;
			while  ( (IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ){
				if(cnt-- == 0) break;
				OSTimeDly(10);
			}
		}
#endif
		{
#ifdef __DEF_IINCHIP_INT__
      		if(getISR(s) & Sn_IR_TIMEOUT)
#else
			if(IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_TIMEOUT)
#endif
			{
	dprintf("send fail. %x\r\n", IINCHIP_READ(nUSE, Sn_IR(nUSE, s)));

#ifdef __DEF_IINCHIP_DBG__
				dprintf("send fail.\r\n");
#endif
/* +2008.04 [woong]: clear interrupt */
#ifdef __DEF_IINCHIP_INT__
         		setISR(nUSE, s, getISR(nUSE, s) & ~(Sn_IR_SEND_OK | Sn_IR_TIMEOUT));  /* clear SEND_OK & TIMEOUT */
#else
         		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), (Sn_IR_SEND_OK | Sn_IR_TIMEOUT)); /* clear SEND_OK & TIMEOUT */

#endif
				return 0;
			}
		}

/* +2008.04 [woong] */	
#ifdef __DEF_IINCHIP_INT__
     	setISR(nUSE, s, getISR(nUSE, s) & (~Sn_IR_SEND_OK));
#else
		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_SEND_OK);
#endif

	}
	return ret;
}


/*
*********************************************************************
This function is an application I/F function which is used to receive the data in other then
TCP mode. This function is used to receive UDP, IP_RAW and MAC_RAW mode, and handle 
the header as well. 
The parameter "s" represents the socket number and "buf" a pointer to copy the data to be 
received and "len" is the data size to read and and addr is a pointer to store the peer's 
IP address and port is a pointer to store the peer's port number.
This function return received data size for success else -1.
*********************************************************************
*/
uint16 recvfrom(uint32 nUSE, SOCKET s, uint8 *buf, uint16 len, uint8 *addr, uint16 *port)
{
	uint8 head[8];
	uint16 data_len=0;
	uint16 ptr = 0;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("recvfrom()\r\n");
#endif

	if(len > 0)
	{
		ptr = IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s));
		ptr = ((ptr & 0x00ff) << 8) + IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s) + 1);
#ifdef __DEF_IINCHIP_DBG__
		dprintf("ISR_RX: rd_ptr : %.4x\r\n", ptr);
#endif
		switch (IINCHIP_READ(nUSE, Sn_MR(nUSE, s)) & 0x07)
		{
			case Sn_MR_UDP :
				read_data(nUSE, s, (uint8 *)ptr, head, 0x08);
				ptr += 8;
				// read peer's IP address, port number.
				addr[0] = head[0];
				addr[1] = head[1];
				addr[2] = head[2];
				addr[3] = head[3];
				*port = head[4];
				*port = (*port << 8) + head[5];
				data_len = head[6];
				data_len = (data_len << 8) + head[7];
				
#ifdef __DEF_IINCHIP_DBG__
				dprintf("UDP msg arrived\r\n");
				dprintf("source Port : %d\r\n", *port);
				dprintf("source IP : %d.%d.%d.%d\r\n", addr[0], addr[1], addr[2], addr[3]);
#endif

				read_data(nUSE, s, (uint8 *)ptr, buf, data_len); // data copy.
				ptr += data_len;

	        	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s)    ),(uint8)((ptr & 0xff00) >> 8));
	        	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1),(uint8)((ptr & 0x00ff)     ));
			break;

			case Sn_MR_IPRAW :
				read_data(nUSE, s, (uint8 *)ptr, head, 0x06);
				ptr += 6;

				addr[0] = head[0];
				addr[1] = head[1];
				addr[2] = head[2];
				addr[3] = head[3];
				data_len = head[4];
				data_len = (data_len << 8) + head[5];
		
#ifdef __DEF_IINCHIP_DBG__
				dprintf("IP RAW msg arrived\r\n");
				dprintf("source IP : %d.%d.%d.%d\r\n", addr[0], addr[1], addr[2], addr[3]);
#endif
				read_data(nUSE, s, (uint8 *)ptr, buf, data_len); // data copy.
				ptr += data_len;

		        IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 0), (uint8)((ptr & 0xff00) >> 8));
	            IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1), (uint8)(ptr & 0x00ff));
			break;

			case Sn_MR_MACRAW :
				read_data(nUSE, s, (uint8*)ptr, head, 2);
				ptr+=2;
				data_len = head[0];
				data_len = (data_len<<8) + head[1] - 2;

				read_data(nUSE, s, (uint8*)ptr, buf, data_len);
				ptr += data_len;
				IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 0), (uint8)((ptr & 0xff00) >> 8));
				IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1), (uint8)(ptr & 0x00ff));
				
#ifdef __DEF_IINCHIP_DGB__
			dprintf("MAC RAW msg arrived\r\n");
			dprintf("dest mac=%.2X.%.2X.%.2X.%.2X.%.2X.%.2X\r\n",buf[0],buf[1],buf[2],buf[3],buf[4],buf[5]);
			dprintf("src  mac=%.2X.%.2X.%.2X.%.2X.%.2X.%.2X\r\n",buf[6],buf[7],buf[8],buf[9],buf[10],buf[11]);
			dprintf("type    =%.2X%.2X\r\n",buf[12],buf[13]); 
#endif			
			break;

			default:
			break;
		}
		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_RECV);
		/* +200804[woong]:wait to process the command... */
		while(IINCHIP_READ(nUSE, Sn_CR(nUSE, s)));
		/* ------- */
	}
#ifdef __DEF_IINCHIP_DBG__
	dprintf("recvfrom() end ..\r\n");
#endif
 	return data_len;
}

uint16 igmpsend(uint32 nUSE, SOCKET s, const uint8 *buf, uint16 len)
{
	uint8 status = 0;
	uint16 ret = 0;
	status = status;
#ifdef __DEF_IINCHIP_DBG__
	dprintf("igmpsend()\r\n");
#endif
	if (len > getIINCHIP_TxMAX(nUSE, s)) ret = getIINCHIP_TxMAX(nUSE, s); // check size not to exceed MAX size.
	else ret = len;

	if(ret == 0) 
 	{
		#ifdef __DEF_IINCHIP_DBG__
			dprintf("%d Fail[%d]\r\n",len);
		#endif
	}
	else
	{
		// copy data
		send_data_processing(nUSE, s, (uint8 *)buf, ret);
		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_SEND);
		/* +200804[woong]:wait to process the command... */
		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
		/* ------- */

		#ifdef __DEF_IINCHIP_INT__
   			while ( (getISR(s) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
		#else
	   		while ( (IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
		#endif
		{
			status = IINCHIP_READ(nUSE, Sn_SR(nUSE, s));
			
			#ifdef __DEF_IINCHIP_INT__
      			if(getISR(nUSE, s) & Sn_IR_TIMEOUT)
			#else
	     		if(IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_TIMEOUT)
			#endif
			{
				#ifdef __DEF_IINCHIP_DBG__
					dprintf("igmpsend fail.\r\n");
				#endif
			   /* in case of igmp, if send fails, then socket closed */
			   /* if you want change, remove this code. */
			   close(nUSE, s);
			   /* ----- */
			   
				return 0;
			}
		}
		/* +2008.04 [woong] */	
		#ifdef __DEF_IINCHIP_INT__
     		setISR(nUSE, s, getISR(nUSE, s) & (~Sn_IR_SEND_OK));
		#else
	   		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_SEND_OK);
		#endif
   }
	return ret;
}

