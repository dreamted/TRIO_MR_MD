
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : usart3_vx.x.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the USART0 firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

////////////////////////////////////////////////////////////////////////////////
#ifdef ETH0_C
	#define _USR_EXT_ETH0
#else
	#define _USR_EXT_ETH0 extern
#endif

#define ETH0_CHANNEL	USE_SPI1
#define ETH1_CHANNEL	USE_SPI2


#define TCP_Server_Mode		0
#define TCP_Client_Mode		1


#define TX_RX_MAX_BUF_SIZE	4096

enum
{
	ERR_NORMAL = 0,
	ERR_CRC,
	ERR_FRAME,
	ERR_ID,
	ERR_NOT_INST,
	ERR_BOOT,
	ERR_LINK,
	ERR_DOWN = 8,
	
};


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
///////////////////////////////////////////////////////////////////////////////
#ifdef ETH0_C
////////////////////
	#define ETH0_START_STK_SIZE		300
	OS_STK Eth0TaskStk[ETH0_START_STK_SIZE];

	const __IPINFOR defaultip = { {0,0x1A,0x4B,0x63,0x81,0x81},
							{192,168,0,23},
							{192,168,0,1},
							{255,255,255,0},
							20000L,
						};

	__N_ProtocolPtr Eth0B, *Eth0 = &Eth0B;

	__N_MU_STS		N_MuStatusB, *N_MuStatus;
	__N_HU_STS		N_HuStatusB, *N_HuStatus;
	__N_RU_STS		N_RuStatusB, *N_RuStatus;

	_MU_ALARM		N_MuAlarmB, *N_MuAlarm;
	_HU_ALARM		N_HuAlarmB[HU_MAX], *N_HuAlarm[HU_MAX];
	_RU_ALARM		N_RuAlarmB[HU_MAX][HDTU_MAX], *N_RuAlarm[HU_MAX][HDTU_MAX];
	
	INT8U	UdpPadOnFlag = 0;

	INT8U	*DstAddr;
	INT16U	DstPort;

	INT8U	Nms_Crtl_Flag = 0;
	INT8U	AlarmReportStartFlag = FALSE;
	INT8U	HuBootFlag[HU_MAX] = {0,};
	INT8U	RuBootFlag[HU_MAX][HDTU_MAX] = {{0,},};

	INT8U	MuBootCnt = 0;
	INT8U	HuBootCnt[HU_MAX] = {0,};
	INT8U	RuBootCnt[HU_MAX][HDTU_MAX] = {{0,},};

////////////////////////////////////////////////////////////////////////////////
#else
////////////////////
	extern	__N_ProtocolPtr *Eth0;

	extern	__N_MU_STS		*N_MuStatus;
	extern	__N_HU_STS		*N_HuStatus;
	extern	__N_RU_STS		*N_RuStatus;
	

	extern	INT8U UdpPadOnFlag;

	extern	INT8U	Nms_Crtl_Flag;
	extern	INT8U	AlarmReportStartFlag;
	extern	INT8U	HuBootFlag[HU_MAX];
	extern	INT8U	RuBootFlag[HU_MAX][HDTU_MAX];
	
////////////////////
#endif
////////////////////////////////////////////////////////////////////////////////
_USER_SER1EXT NMS	Snms, Rnms;

_USR_EXT_ETH0 INT8U udp_rx_buf[2][2048];
_USR_EXT_ETH0 INT16U udp_rx_len[2];
_USR_EXT_ETH0 INT16U udp_rx_rcnt[2];
_USR_EXT_ETH0 INT8U returnip[2][4];
_USR_EXT_ETH0 INT16U returnport[2];
_USR_EXT_ETH0 INT8U udp_preAddr[2][4];

_USR_EXT_ETH0 INT8U Ethernet_Debug;


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
////////////////////////////////////////
#ifdef ETH0_C
////////////////////////////////////////

	void Ethenet0Init(void);
	void Ethernet0Task(void *p_arg);
	void AlarmRptFunc(void);

	signed short int ret0GetByte(void);
	void udp0PutStr(unsigned char *Str, unsigned short int Length, int iEn);
	void udp0desportcmp(SOCKET s, INT8U *pddr, INT8U *addr);
	unsigned char ret0CheckByte(unsigned short int ByteCnt, unsigned short int *Recv);


	void init_sock(INT8U nUSE, SOCKET s, uint8 protocol, uint16 port, uint8 flag, uint8 *serverip);
	void udpdesportcmp(INT32U nUSE, SOCKET s, INT8U *pddr, INT8U *addr);
	void udpSetAddr(INT32U nUSE, SOCKET s, INT8U *destaddr, INT16U destport);
	void udpPutStr(INT32U nUSE, unsigned char *Str, unsigned short int Length, int iEn, INT8U *daddr, INT16U dport);

	signed short int retGetByte(INT32U nUSE);
	unsigned char retCheckByte(INT32U nUSE, unsigned short int ByteCnt, unsigned short int *Recv);
	INT32U eLink_Check(INT32U nUSE);
	INT16U retSelect(INT32U nUSE, INT8U s, unsigned char *addr, unsigned short int *port);

	void EthernetServerMode(INT32U nUSE);
	void EthernetClientMode(INT32U nUSE);

	INT32U N_ProtocolCheck(__N_ProtocolPtr *nPtr, INT32U ResTime);
	void N_ProtocolComCheck (__N_ProtocolPtr *nPtr);
	void NmsDataAckTx(INT8U *Data, INT16U nCnt, INT8U Comm, __N_ProtocolPtr *toPtr);
	void NmsAlarmAckTx(SubIDStr TarID, INT8U *Data, INT16U nCnt, __N_ProtocolPtr *toPtr);
	void NmsDataCopy(INT8U Path, SubIDStr TarID);

	void Eth0_Control_Hu_Conv(SubIDStr DstID, __N_HU_CTRL *nPtr, __ProtocolPtr *Target);
	void Eth0_Control_Ru_Conv(SubIDStr DstID, __N_RU_CTRL *nPtr, __ProtocolPtr *Target);

	void NmsBootAlarmReport(void);
	void NmsAlarmReport(void);

	void NmsMuAlarmReport(void);
	void NmsHuAlarmReport(SubIDStr DstID);
	void NmsRuAlarmReport(SubIDStr DstID);

	void AlarmUpdateAll(void);
	void MuAlarmUpdate(void);
	void HuAlarmUpdate(SubIDStr DstID);
	void RuAlarmUpdate(SubIDStr DstID);
	
/////////////////////////////////////////////////////////////////////////////////
#else
///////////////////////
	extern	void Ethenet0Init(void);
	extern	void Ethernet0Task(void *p_arg);
	extern	INT16U retSelect(INT32U nUSE, INT8U s, unsigned char *addr, unsigned short int *port);

	extern	void NmsDataAckTx(INT8U *Data, INT16U nCnt, INT8U Comm, __N_ProtocolPtr *toPtr);
	extern	void NmsDataCopy(INT8U Path, SubIDStr TarID);

	extern	void NmsBootAlarmReport(void);
	extern	void NmsAlarmReport(void);

	extern	void AlarmUpdateAll(void);
	
#endif


void EthernetPortReset(void);
void udp0SetAddr(INT8U *destaddr, INT16U destport);
void EthernetInitSet(INT32U nUSE, INT8U Mode, INT8U TcpDebug);


////////////////////////////////////////////////////////////////////////////////
// End of Header File
////////////////////////

