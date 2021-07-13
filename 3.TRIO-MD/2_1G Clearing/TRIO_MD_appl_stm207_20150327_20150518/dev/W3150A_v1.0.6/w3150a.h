#ifndef	_W3150A_H_
#define	_W3150A_H_

#define _EthNo		2

#include "iinchip_conf.h"
#include "types.h"


#define MR		__DEF_IINCHIP_MAP_BASE__
#define IDM_OR	((__DEF_IINCHIP_MAP_BASE__ + 0x00))
#define IDM_AR0	((__DEF_IINCHIP_MAP_BASE__ + 0x01))
#define IDM_AR1	((__DEF_IINCHIP_MAP_BASE__ + 0x02))
#define IDM_DR	((__DEF_IINCHIP_MAP_BASE__ + 0x03))

/*
* Maxmium number of socket 
*/
#define	MAX_SOCK_NUM		4

/**
 * \brief Gateway IP Register address
 */
#define GAR0				(COMMON_BASE + 0x0001)
/**
 * \brief Subnet mask Register address
 */
#define SUBR0				(COMMON_BASE + 0x0005)
/**
 * \brief Source MAC Register address
 */
#define SHAR0				(COMMON_BASE + 0x0009)
/**
 * \brief Source IP Register address
 */
#define SIPR0				(COMMON_BASE + 0x000F)
/**
 * \brief Interrupt Register
 */
#define IR					(COMMON_BASE + 0x0015)
/**
 * \brief Interrupt mask register
 */
#define wIMR				(COMMON_BASE + 0x0016)
/**
 * \brief Timeout register address
 *
 * 1 is 100us
 */
#define RTR0				(COMMON_BASE + 0x0017)
/**
 * \brief Retry count reigster
 */
#define wRCR				(COMMON_BASE + 0x0019)
/**
 * \brief Receive memory size reigster
 */
#define RMSR				(COMMON_BASE + 0x001A)
/**
 * \brief Transmit memory size reigster
 */
#define TMSR				(COMMON_BASE + 0x001B)
/**
 * \brief Authentication type register address in PPPoE mode
 */
#define PATR0				(COMMON_BASE + 0x001C)
#define PTIMER				(COMMON_BASE + 0x0028)
#define PMAGIC				(COMMON_BASE + 0x0029)

/**
 * \brief Unreachable IP register address in UDP mode
 */
#define UIPR0				(COMMON_BASE + 0x002A)
/**
 * \brief Unreachable Port register address in UDP mode
 */
#define UPORT0				(COMMON_BASE + 0x002E)

/* socket register */
#define CH_BASE				(COMMON_BASE + 0x0400)
/**
 * size of each channel register map
 */
#define CH_SIZE				0x0100
/**
 * \brief socket Mode register
 */
#define Sn_MR(nUSE, ch)		(CH_BASE + ch * CH_SIZE + 0x0000)
/**
 * \brief channel Sn_CR register
 */
#define Sn_CR(nUSE, ch)		(CH_BASE + ch * CH_SIZE + 0x0001)
/**
 * \brief channel interrupt register
 */
#define Sn_IR(nUSE, ch)		(CH_BASE + ch * CH_SIZE + 0x0002)
/**
 * \brief channel status register
 */
#define Sn_SR(nUSE, ch)		(CH_BASE + ch * CH_SIZE + 0x0003)
/**
 * \brief source port register
 */
#define Sn_PORT0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0004)
/**
 * \brief Peer MAC register address
 */
#define Sn_DHAR0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0006)
/**
 * \brief Peer IP register address
 */
#define Sn_DIPR0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x000C)
/**
 * \brief Peer port register address
 */
#define Sn_DPORT0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0010)
/**
 * \brief Maximum Segment Size(Sn_MSSR0) register address
 */
#define Sn_MSSR0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0012)
/**
 * \brief Protocol of IP Header field register in IP raw mode
 */
#define Sn_PROTO(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0014)

/* \brief IP Type of Service(TOS) Register 
 */
#define Sn_TOS(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0015)
/**
 * \brief IP Time to live(TTL) Register 
 */
#define Sn_TTL(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0016)

/**
 * \brief Transmit free memory size register
 */
#define Sn_TX_FSR0(nUSE, ch)(CH_BASE + ch * CH_SIZE + 0x0020)
/**
 * \brief Transmit memory read pointer register address
 */
#define Sn_TX_RD0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0022)
/**
 * \brief Transmit memory write pointer register address
 */
#define Sn_TX_WR0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0024)
/**
 * \brief Received data size register
 */
#define Sn_RX_RSR0(nUSE, ch)(CH_BASE + ch * CH_SIZE + 0x0026)
/**
 * \brief Read point of Receive memory
 */
#define Sn_RX_RD0(nUSE, ch)	(CH_BASE + ch * CH_SIZE + 0x0028)
/**
 * \brief Write point of Receive memory
 */
#define Sn_RX_WR0(ch)		(CH_BASE + ch * CH_SIZE + 0x002A)
/** @} */


/* MODE register values */
#define MR_RST				0x80			// reset
#define MR_PB				0x10			// ping block
#define MR_PPPOE			0x08			// enable pppoe
#define MR_LB  				0x04			// little or big endian selector in indirect mode
#define MR_AI				0x02			// auto-increment in indirect mode
#define MR_IND				0x01			// enable indirect mode

/* IR register values */
#define IR_CONFLICT			0x80			// check ip confict
#define IR_UNREACH			0x40			// get the destination unreachable message in UDP sending
#define IR_PPPoE			0x20			// get the PPPoE close message
#define IR_SOCK(ch)			(0x01 << ch)	// check socket interrupt

/* Sn_MR values */
#define Sn_MR_MULTI			0x80			// support multicating
#define Sn_MR_ND			0x20			// No Delayed Ack(TCP) flag

#define Sn_MR_CLOSE			0x00			// unused socket
#define Sn_MR_TCP			0x01			// TCP
#define Sn_MR_UDP			0x02			// UDP
#define Sn_MR_IPRAW			0x03			// IP LAYER RAW SOCK
#define Sn_MR_MACRAW		0x04			// MAC LAYER RAW SOCK
#define Sn_MR_PPPOE			0x05			// PPPoE


/* Sn_CR values */
#define Sn_CR_OPEN			0x01			// initialize or open socket
#define Sn_CR_LISTEN		0x02			// wait connection request in tcp mode(Server mode)
#define Sn_CR_CONNECT		0x04			// send connection request in tcp mode(Client mode)
#define Sn_CR_DISCON		0x08			// send closing reqeuset in tcp mode
#define Sn_CR_CLOSE			0x10			// close socket
#define Sn_CR_SEND			0x20			// updata txbuf pointer, send data
#define Sn_CR_SEND_MAC		0x21			// send data with MAC address, so without ARP process
#define Sn_CR_SEND_KEEP		0x22			// send keep alive message
#define Sn_CR_RECV			0x40			// update rxbuf pointer, recv data

#ifdef __DEF_IINCHIP_PPP__
	#define Sn_CR_PCON			0x23		// 
	#define Sn_CR_PDISCON		0x24		// 
	#define Sn_CR_PCR			0x25		// 
	#define Sn_CR_PCN			0x26		// 
	#define Sn_CR_PCJ			0x27		// 
#endif

/* Sn_IR values */
#ifdef __DEF_IINCHIP_PPP__
	#define Sn_IR_PRECV			0x80		// 
	#define Sn_IR_PFAIL			0x40		// 
	#define Sn_IR_PNEXT			0x20		// 
#endif
#define Sn_IR_SEND_OK			0x10		// complete sending
#define Sn_IR_TIMEOUT			0x08		// assert timeout
#define Sn_IR_RECV				0x04		// receiving data
#define Sn_IR_DISCON			0x02		// closed socket
#define Sn_IR_CON				0x01		// established connection

/* Sn_SR values */
#define SOCK_CLOSED				0x00		// closed
#define SOCK_INIT				0x13		// init state
#define SOCK_LISTEN				0x14		// listen state
#define SOCK_SYNSENT			0x15		// connection state
#define SOCK_SYNRECV			0x16		// connection state
#define SOCK_ESTABLISHED		0x17		// success to connect
#define SOCK_FIN_WAIT			0x18		// closing state
#define SOCK_CLOSING		   	0x1A		// closing state
#define SOCK_TIME_WAIT			0x1B		// closing state
#define SOCK_CLOSE_WAIT			0x1C		// closing state
#define SOCK_LAST_ACK			0x1D		// closing state
#define SOCK_UDP				0x22		// udp socket
#define SOCK_IPRAW			   	0x32		// ip raw mode socket
#define SOCK_MACRAW				0x42		// mac raw mode socket
#define SOCK_PPPOE				0x5F		// pppoe socket

/* IP PROTOCOL */
#define IPPROTO_IP              0           /* Dummy for IP */
#define IPPROTO_ICMP            1           /* Control message protocol */
#define IPPROTO_IGMP            2           /* Internet group management protocol */
#define IPPROTO_GGP             3           /* Gateway^2 (deprecated) */
#define IPPROTO_TCP             6           /* TCP */
#define IPPROTO_PUP             12          /* PUP */
#define IPPROTO_UDP             17          /* UDP */
#define IPPROTO_IDP             22          /* XNS idp */
#define IPPROTO_ND              77          /* UNOFFICIAL net disk protocol */
#define IPPROTO_RAW             255         /* Raw IP packet */

extern uint8 I_STATUS[_EthNo][MAX_SOCK_NUM];
extern uint32 SMASK[_EthNo][MAX_SOCK_NUM];					/* Variable for Tx buffer MASK in each channel */
extern uint32 RMASK[_EthNo][MAX_SOCK_NUM];					/* Variable for Rx buffer MASK in each channel */
extern uint16 SSIZE[_EthNo][MAX_SOCK_NUM];					/* Max Tx buffer size by each channel */
extern uint16 RSIZE[_EthNo][MAX_SOCK_NUM];					/* Max Rx buffer size by each channel */
extern uint32 SBUFBASEADDRESS[_EthNo][MAX_SOCK_NUM];		/* Tx buffer base address by each channel */
extern uint32 RBUFBASEADDRESS[_EthNo][MAX_SOCK_NUM];		/* Rx buffer base address by each channel */

/***************
#ifndef ETH0_C
typedef struct {
	uint8 MacAddr[6];
	uint8 IPAddr[4];
	uint8 GatewayAddr[4];
	uint8 SubnetAddr[4];
	uint16 nPort;
} __IPINFOR;
#endif
**************/
/*********************************************************
* iinchip access function
*********************************************************/
#if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_DIRECT_MODE__)
#define IINCHIP_READ(nUSE, addr)									\
							({	uint8 data;					\
								IINCHIP_ISR_DISABLE(nUSE);		\
								data = *((vuint8*)(addr));	\
								IINCHIP_ISR_ENABLE(nUSE);		\
								data;						})

#define IINCHIP_WRITE(nUSE, addr, data)							\
							({	IINCHIP_ISR_DISABLE(nUSE);		\
								*((vuint8*)(addr)) = data;	\
								IINCHIP_ISR_ENABLE(nUSE);	})
#define wiz_write_buf(nUSE, addr, buf, len)						\
							({	IINCHIP_ISR_DISABLE(nUSE);		\
						       	memcpy((uint8 *)addr, (uint8 *)buf, len);	\
						       	IINCHIP_ISR_ENABLE(nUSE);})
#define wiz_read_buf(nUSE, addr, buf, len)			\
							({	IINCHIP_ISR_DISABLE(nUSE);		\
								memcpy((uint8 *)buf, (uint8 *)addr, len);	\
								IINCHIP_ISR_ENABLE(nUSE); })
#else
uint8 IINCHIP_READ(uint32 nUSE, uint32 addr);
uint8 IINCHIP_WRITE(uint32 nUSE, uint32 addr, uint8 data);
uint16 wiz_write_buf(uint32 nUSE, uint32 addr,uint8* buf,uint16 len);
uint16 wiz_read_buf(uint32 nUSE, uint32 addr, uint8* buf,uint16 len);
#endif

void iinchip_init(uint32 nUSE);									// reset iinchip
void sysinit(uint32 nUSE, uint8 tx_size, uint8 rx_size);		// setting tx/rx buf size
#define getISR(nUSE, s)					(I_STATUS[nUSE][s])
#define setISR(nUSE, s, val)			(I_STATUS[nUSE][s] = val)
#define getIINCHIP_RxMAX(nUSE, s)		(RSIZE[nUSE][s])
#define getIINCHIP_TxMAX(nUSE, s)		(SSIZE[nUSE][s])
#define getIINCHIP_RxMASK(nUSE, s)		(RMASK[nUSE][s])
#define getIINCHIP_TxMASK(nUSE, s)		(SMASK[nUSE][s])
#define getIINCHIP_RxBASE(nUSE, s)		(RBUFBASEADDRESS[nUSE][s])
#define getIINCHIP_TxBASE(nUSE, s)		(SBUFBASEADDRESS[nUSE][s])

void setGAR(uint32 nUSE, uint8 * addr);							// set gateway address
void setSUBR(uint32 nUSE, uint8 * addr);						// set subnet mask address
void setSHAR(uint32 nUSE, uint8 * addr);						// set local MAC address
void setSIPR(uint32 nUSE, uint8 * addr);						// set local IP address
void setRTR(uint32 nUSE, uint16 timeout);						// set retry duration for data transmission, connection, closing ...
#define setRCR(nUSE, retry)	(IINCHIP_WRITE(nUSE, wRCR, retry))	// set retry count (above the value, assert timeout interrupt)
#define setIMR(nUSE, mask)	(IINCHIP_WRITE(nUSE, wIMR, mask))	// set interrupt mask. 
void getGAR(uint32 nUSE, uint8 *addr);
void getSUBR(uint32 nUSE, uint8 *addr);
void getSHAR(uint32 nUSE, uint8 *addr);
void getSIPR(uint32 nUSE, uint8 *addr);
void getGWIP(uint32 nUSE, uint8 *addr);

void setSn_MSS(uint32 nUSE, SOCKET s, uint16 Sn_MSSR0);								// set maximum segment size
#define setSn_PROTO(nUSE, s, proto)	(IINCHIP_WRITE(nUSE, Sn_PROTO(nUSE, s),proto))	// set IP Protocol value using IP-Raw mode
#define getSn_IR(nUSE, s)			(IINCHIP_READ(nUSE, Sn_IR(nUSE, s)))					// get socket interrupt status
#define setSn_IR(nUSE, s, val)		(IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s),val))				// set socket interrupt status
#define getSn_SR(nUSE, s)			(IINCHIP_READ(nUSE, Sn_SR(nUSE, s)))					// get socket status
uint16 getSn_TX_FSR(uint32 nUSE, SOCKET s);											// get socket TX free buf size
uint16 getSn_RX_RSR(uint32 nUSE, SOCKET s);											// get socket RX recv buf size
void setSn_DHAR(uint32 nUSE, SOCKET s, uint8 * addr);
void setSn_DIPR(uint32 nUSE, SOCKET s, uint8 * addr);
void setSn_DPORT(uint32 nUSE, SOCKET s, uint8 * addr);
void getSn_DHAR(uint32 nUSE, SOCKET s, uint8 * addr);
void getSn_DIPR(uint32 nUSE, SOCKET s, uint8 * addr);
void getSn_DPORT(uint32 nUSE, SOCKET s, uint8 * addr);
#define setSn_TTL(nUSE, s, ttl)		(IINCHIP_WRITE(nUSE, Sn_TTL(nUSE,s), ttl))

#ifdef __DEF_IINCHIP_PPP__
	uint8 pppinit(uint32 nUSE, uint8 *id, uint8 idlen, uint8 *passwd, uint8 passwdlen);
	uint8 pppterm(uint32 nUSE, uint8 *mac,uint8 *sessionid);
#endif

void send_data_processing(uint32 nUSE, SOCKET s, uint8 *data, uint16 len);
void recv_data_processing(uint32 nUSE, SOCKET s, uint8 *data, uint16 len);
void read_data(uint32 nUSE, SOCKET s, vuint8 * src, vuint8 * dst, uint16 len);
void write_data(uint32 nUSE, SOCKET s, vuint8 * src, vuint8 * dst, uint16 len);
void setMR(uint32 nUSE, uint8 val);

void ISR(uint32 nUSE);
void w3150ainit(uint32 nUSE);

extern unsigned long int (*dprintf)( const char *format, ... );
extern void ForDelay(unsigned long int count);

#endif
