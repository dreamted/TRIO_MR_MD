#ifndef	_SOCKET_H_
#define	_SOCKET_H_

/**********************************************************
* define function of socket API 
***********************************************************/
uint8 socket(uint32 nUSE, SOCKET s, uint8 protocol, uint16 port, uint8 flag); // Opens a socket(TCP or UDP or IP_RAW mode)
void close(uint32 nUSE, SOCKET s); // Close socket
uint8 connect(uint32 nUSE, SOCKET s, uint8 * addr, uint16 port); // Establish TCP connection (Active connection)
void disconnect(uint32 nUSE, SOCKET s); // disconnect the connection
uint8 listen(uint32 nUSE, SOCKET s);	// Establish TCP connection (Passive connection)
uint16 send(uint32 nUSE, SOCKET s, const uint8 * buf, uint16 len); // Send data (TCP)
uint16 recv(uint32 nUSE, SOCKET s, uint8 * buf, uint16 len);	// Receive data (TCP)
uint16 sendto(uint32 nUSE, SOCKET s, const uint8 * buf, uint16 len, uint8 * addr, uint16 port); // Send data (UDP/IP RAW)
uint16 recvfrom(uint32 nUSE, SOCKET s, uint8 * buf, uint16 len, uint8 * addr, uint16  *port); // Receive data (UDP/IP RAW)
uint16 igmpsend(uint32 nUSE, SOCKET s, const uint8 * buf, uint16 len); // Send data (multicasting)

extern unsigned long int USART1Printf( const char *format, ...);
extern unsigned long int (*dprintf)( const char *format, ... );

#endif


/* _SOCKET_H_ */
