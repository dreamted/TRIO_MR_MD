
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : exlib.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define ETH0_C

#include "../dev/W3150A_v1.0.6/types.h"
#include "../dev/W3150A_v1.0.6/socket.h"
#include "../dev/W3150A_v1.0.6/w3150a.h"

#include "../include/main.h"

//#define DBG_ETH0_OUT
#define DBG_ETH1_OUT

void Ethenet0Init(void)
{
	INT8U	i,j,k;
	
	Eth0->CheckByte = ret0CheckByte;
	Eth0->RxGetByte = ret0GetByte;
	Eth0->PutStr = udp0PutStr;
	Eth0->TxCheckByte = NULL;
	Eth0->BuffClear = NULL;

	Eth0->TimerRx = TimerudpRx;

	Eth0->Recv = &Rnms;
	Eth0->Send = &Snms;

	Eth0->OSSem = OSSemCreate(1);

	// Mem Allocation
	N_MuStatus	= &N_MuStatusB;
	N_HuStatus	= &N_HuStatusB;
	N_RuStatus	= &N_RuStatusB;

	N_MuAlarm	= &N_MuAlarmB;
	for(i=0; i<HU_MAX; i++)
	{
		N_HuAlarm[i]	= &N_HuAlarmB[i];
		for(j=0; j<HDTU_MAX; j++)
		{
			N_RuAlarm[i][j]	= &N_RuAlarmB[i][j];
		}
	}

	// Buf Clear
	for(i=0; i<sizeof(_MU_ALARM); i++)
	{
		*((INT8U*)N_MuAlarm+i) = 0;
	}
	for(i=0; i<HU_MAX; i++)
	{
		for(j=0; j<sizeof(_HU_ALARM); j++)
		{
			*((INT8U*)N_HuAlarm[i]+j) = 0;
		}
	}
	for(i=0; i<HU_MAX; i++)
	{
		for(j=0; j<HDTU_MAX; j++)
		{
			for(k=0; k<sizeof(_RU_ALARM); k++)
			{
				*((INT8U*)N_RuAlarm[i][j]+k) = 0;
			}
		}
	}
	
	for(i=0; i<HU_MAX; i++)
	{
		HuBootFlag[i] = 0;
		HuBootCnt[i] = 0;
		for(j=0; j<HDTU_MAX; j++)
		{
			RuBootFlag[i][j] = 0;
			RuBootCnt[i][j] = 0;
		}
	}
	
////////////////////////////////////////////////////////////////////////////////
	EthernetPortReset();
	
	OSTaskCreate(Ethernet0Task, (void *)NULL, (OS_STK *)&Eth0TaskStk[ETH0_START_STK_SIZE - 1], ETH_START_PRIO);
}

// UDP CASE !!(SERVER)
void Ethernet0Task(void *p_arg)
{
	INT8U s = 0;
	INT8U nUSE = ETH0_CHANNEL;
	INT8U len;
	INT8U	uTemp[2];
	
	__N_ProtocolPtr *nPtr = Eth0;
	
	OSTimeDly(100L*ETH_START_PRIO);
	EthernetInitSet(nUSE, Sn_MR_UDP, TRUE);
	
	udp0SetAddr(returnip[nUSE], returnport[nUSE]);
		
	while(1)
	{
		if(eLink_Check(nUSE) && !tTestFlag)
		{
			while(eLink_Check(nUSE) && !tTestFlag)
			{
				//StsCheckConnectionRst(nPtr);
				
				OSTimeDly(300L);
			}
			EthernetInitSet(nUSE, Sn_MR_UDP, FALSE);
			OSTimeDly(1000L);
		}

		while(!AlarmReportStartFlag)
		{
			TimerRegist(TimerAlarmChk, Time1Sec);
			OSTimeDly(300L);
		}
		
		//while(!eLink_Check(nUSE) && !tTestFlag && ((DownLoadGiveupTimerSet(NULL)==0)||(DownLoadGiveupTimerSet(NULL)==(INT32U)Eth0)) )
		while(!eLink_Check(nUSE) && !tTestFlag )
		{
			if( (len = retSelect(nUSE, s, returnip[nUSE], &returnport[nUSE])))
			{
				INT16U Recv;
                
                len = len;

			    while(nPtr->CheckByte(1, &Recv))
				{
					if(N_ProtocolCheck(nPtr, Time1Sec))
					{
						returnport[0] = IpSts->Server_Port;
						udp0SetAddr(returnip[nUSE], returnport[nUSE]);

						if((DownLoadGiveupTimerSet(NULL)!=0)&&(DownLoadGiveupTimerSet(NULL)!=(INT32U)Eth0))
						{
							uTemp[0] = ERR_DOWN;
							NmsDataAckTx((INT8U*)uTemp, 1, N_Error_CMD, nPtr);
						}
						else	N_ProtocolComCheck(nPtr);
					}
				}
			
			}

			//-----------------------------------------------------------------------//
			// Alarm Report
			if(AlarmReportStartFlag)
			{
				if(TimeOverCheck(TimerAlarmChk))
				{
					// Boot Alarm Check
					NmsBootAlarmReport();

					// Alarm Check
					NmsAlarmReport();
					TimerRegist(TimerAlarmChk, Time1Sec);
				}
			}
			
			OSTimeDly(200L);
		}
		OSTimeDly(300L);
	}
}

INT16U retSelect(INT32U nUSE, SOCKET s, unsigned char *addr, unsigned short int *port)
{
	INT16U len = 0;
	INT8U err;
	
	OSSemPend(Eth0->OSSem, 0, &err);
	if ((IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_RECV )) // check interrupt register
	{
		// clear interrupt register
		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_RECV);

		if ((len = getSn_RX_RSR(nUSE, s)) > 0)			// check Rx data
		{
			if (len > TX_RX_MAX_BUF_SIZE) len = TX_RX_MAX_BUF_SIZE; 	//if Rx data size is lager than TX_RX_MAX_BUF_SIZE
																		//the data size to read is MAX_BUF_SIZE.
			len = recvfrom(nUSE, 0, udp_rx_buf[nUSE], len,(u_char *)returnip[nUSE], &returnport[nUSE]); //read the received data
			udp_rx_len[nUSE] = len;
			udp_rx_rcnt[nUSE] = 0;
		}
	}
/*
#ifdef DBG_ETH0_OUT
	//SerPtr->printf("len: %d\n", len);
	if(len)
	{
		int i;
		for(i = 0; i < len; i++) SerPtr->printf("%02x ", udp_rx_buf[nUSE][i]);
		SerPtr->printf("\n", len);
			
	}
#endif
*/
	OSSemPost(Eth0->OSSem);

	return len;
}

unsigned char ret0CheckByte(unsigned short int ByteCnt, unsigned short int *Recv)
{
	return (retCheckByte(ETH0_CHANNEL, ByteCnt, Recv));
}

signed short int ret0GetByte(void)
{
	return (retGetByte(ETH0_CHANNEL));
}

void udp0SetAddr(INT8U *destaddr, INT16U destport)
{
	udpSetAddr(ETH0_CHANNEL, 0, destaddr, destport);
}

void udp0PutStr(unsigned char *Str, unsigned short int Length, int iEn)
{
	udpPutStr(ETH0_CHANNEL, Str, Length, iEn, DstAddr, DstPort);
}

void udp0desportcmp(SOCKET s, INT8U *pddr, INT8U *addr)
{
	udpdesportcmp(ETH0_CHANNEL, s, pddr, addr);
}

unsigned char retCheckByte(INT32U nUSE, unsigned short int ByteCnt, unsigned short int *Recv)
{

	INT16U rval = 0;
	INT8U err;
	
	OSSemPend(Eth0->OSSem, 0, &err);

	*Recv = 0;
	
	if(udp_rx_rcnt[nUSE] >= TX_RX_MAX_BUF_SIZE || udp_rx_rcnt[nUSE] >= udp_rx_len[nUSE]){

		udp_rx_len[nUSE] = 0;
	}
	else
	{
		*Recv = (udp_rx_len[nUSE] - udp_rx_rcnt[nUSE]);
		if(*Recv >= ByteCnt) rval = TRUE;
	}
/*
#ifdef DBG_ETH0_OUT
	SerPtr->printf("Recv: %d, rval: %d \n", *Recv, rval);
#endif
*/
	OSSemPost(Eth0->OSSem);

	return rval;
}

signed short int retGetByte(INT32U nUSE)
{
	INT8U rval = 0;
	INT8U err;
	
	OSSemPend(Eth0->OSSem, 0, &err);

	rval = udp_rx_buf[nUSE][udp_rx_rcnt[nUSE]++];

	OSSemPost(Eth0->OSSem);
/*
#ifdef DBG_ETH0_OUT
	SerPtr->printf("rval: %02x \n", rval & 0xff);
#endif
*/
	return rval & 0xff;
}


void udpSetAddr(INT32U nUSE, SOCKET s, INT8U *destaddr, INT16U destport)
{
	
	INT8U err;
	OSSemPend(Eth0->OSSem, 0, &err);

	if(nUSE == ETH0_CHANNEL)
	{
    	DstAddr = destaddr;
		DstPort = destport;

		rambackup[1] = (INT8U)(destport >> 0);
		rambackup[2] = (INT8U)(destport >> 8);
		rambackup[3] = (INT8U)(destaddr[0]);
		rambackup[4] = (INT8U)(destaddr[1]);
		rambackup[5] = (INT8U)(destaddr[2]);
		rambackup[6] = (INT8U)(destaddr[3]);
	}
	else
	{
    	DstAddr = destaddr;
		DstPort = destport;
	}
	OSSemPost(Eth0->OSSem);
}

void udpdesportcmp(INT32U nUSE, SOCKET s, INT8U *pddr, INT8U *addr)
{
	INT32U i = 0;
//	INT16U nPort;
	INT8U IsItSame = TRUE;
	
	for(i = 0; i < 4; i++)
	{
		if(pddr[i] != addr[i]) IsItSame = FALSE;
	}

	if(IsItSame == FALSE)
	{		
		for(i = 0; i < 4; i++) pddr[i] = addr[i];
//		if(nUSE == ETH0_CHANNEL)	nPort = IpSts->Server_Port;
//		else						nPort = IpSts->Server_Port;

///		init_sock(nUSE, s, Sn_MR_UDP, nPort, 0, (INT8U)NULL);
	}
}

void udpPutStr(INT32U nUSE, unsigned char *Str, unsigned short int Length, int iEn, INT8U *daddr, INT16U dport)
{
	INT8U err;
		
	if(eLink_Check(nUSE)) return;
	
	OSSemPend(Eth0->OSSem, 0, &err);
/*
#ifdef DBG_ETH0_OUT
	SerPtr->printf("IPAddr: %d.%d.%d.%d\n", 
		daddr[0],
		daddr[1],
		daddr[2],
		daddr[3]);
	
	SerPtr->printf("Port: %d\n", dport);
	{
		int i = 0;
		SerPtr->printf("[TX] ");

		for(i = 0; i < Length; i++) SerPtr->printf("%02x ", Str[i]);
		SerPtr->printf("\n");
	}
#endif
*/	
	udpdesportcmp(nUSE, 0, udp_preAddr[nUSE], daddr);
	
	if(sendto(nUSE, 0, Str, Length,(u_char *)daddr, dport) == 0); //send the received data

	OSSemPost(Eth0->OSSem);

}



void EthernetServerMode(INT32U nUSE)
{
	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0), Sn_CR_CLOSE);
	OSTimeDly(2000L);
	EthernetInitSet(nUSE, TCP_Server_Mode, FALSE);
	if (Ethernet_Debug) USART1Printf("Server로 전환\n");
}

void EthernetClientMode(INT32U nUSE)
{
	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0),Sn_CR_CLOSE);
	OSTimeDly(2000L);
	EthernetInitSet(nUSE, TCP_Client_Mode, FALSE);
	if (Ethernet_Debug) USART1Printf("Client로 전환\n");
}


void EthernetPortReset(void)
{
	W3150RST = 1;
	OSTimeDly(100L);
	W3150RST = 0;
	OSTimeDly(100L);
	W3150RST = 1;
}

void EthernetInitSet(INT32U nUSE, INT8U Mode, INT8U TcpDebug)
{
	INT8U tmp[6];
	INT16U nPort;
	INT8U err0 = 0;
//	INT8U err1 = 0;

	
	OSSemPend(Eth0->OSSem, 0, &err0);
	
	W3150RST = 1;
		
	w3150ainit(nUSE);

	if(nUSE == ETH0_CHANNEL) 	setGAR(nUSE, IpSts->Server_Gw);
	else					 	setGAR(nUSE, IpSts->Server_Gw);	

	getGWIP(nUSE, tmp);
	if (TcpDebug)
	{
		SerPtr->printf("nUSE CHANNEL: %d\n", nUSE); 
		SerPtr->printf("GatewayAddr: %d.%d.%d.%d\n", 
					tmp[0],
					tmp[1],
					tmp[2],
					tmp[3]);
	}
	
	setSHAR(nUSE, IpSts->MacAddress);
	getSHAR(nUSE, tmp);
	if (TcpDebug)
	{
		SerPtr->printf("MacAddr: %x[%x].%x[%x].%x[%x].%x[%x].%x[%x].%x[%x]\n", 
					tmp[0],IpSts->MacAddress[0],
					tmp[1],IpSts->MacAddress[1],
					tmp[2],IpSts->MacAddress[2],
					tmp[3],IpSts->MacAddress[3],
					tmp[4],IpSts->MacAddress[4],
					tmp[5],IpSts->MacAddress[5]);
	}
	if(nUSE == ETH0_CHANNEL)	setSUBR(nUSE, IpSts->Server_Sub);
	else						setSUBR(nUSE, IpSts->Server_Sub);
	getSUBR(nUSE, tmp);
	if (TcpDebug)
	{
		SerPtr->printf("SubnetAddr: %d.%d.%d.%d\n", 
			tmp[0],
			tmp[1],
			tmp[2],
			tmp[3]);
	}
	if(nUSE == ETH0_CHANNEL)	setSIPR(nUSE, IpSts->Rep_Ip);
	else						setSIPR(nUSE, IpSts->Rep_Ip);
	getSIPR(nUSE, tmp);

	if (TcpDebug)
	{
		SerPtr->printf("IPAddr: %d.%d.%d.%d\n", 
			tmp[0],
			tmp[1],
			tmp[2],
			tmp[3]);
	}
	sysinit(nUSE, 0x55, 0x55);

	if(nUSE == ETH0_CHANNEL)	nPort = IpSts->Rep_Port;
	else						nPort = IpSts->Rep_Port;

	init_sock(nUSE, 0, Sn_MR_UDP, nPort, 0, (INT8U)NULL);

	OSSemPost(Eth0->OSSem);
	
	OSTimeDly(1000L);
}

void init_sock(INT8U nUSE, SOCKET s, uint8 protocol, uint16 port, uint8 flag, uint8 *serverip) 
{
	// sflag: 1: clent mode, 0: server mode
	socket(nUSE, s, protocol, port, flag);	/* Create a new socket */

	if(protocol == Sn_MR_TCP)
	{
		if (serverip != NULL)
		{
		
			if (connect(nUSE, s, serverip, port) == 0) {
				socket(nUSE, s, Sn_MR_TCP, port, flag);	/* Create a new socket */
				listen(nUSE, s);           				/* Server Mode */
			}
		}
		else
		{
			listen(nUSE, s);           			/* Server Mode */
		}
	}
}

INT32U eLink_Check(INT32U nUSE)
{
	INT32U rval = FALSE;

         if(nUSE == ETH0_CHANNEL) 	rval = GPIOD->__B.IDR.B9;
//	else if(nUSE == ETH1_CHANNEL)	rval = GPIOA->IDR.B0;
	
	return rval;

}

//=======================================================================//
INT32U N_ProtocolCheck(__N_ProtocolPtr *nPtr, INT32U ResTime)
{
	INT16U nCnt;
	INT16U i = 0, n = 0;
	INT32U RetVal;
	INT8U Data;
	
	NMS *Recv = nPtr->Recv;

	TimerRegist(nPtr->TimerRx, ResTime);
	Recv->Command = NULLcomm;	// RX Command Clear

	//====================//
	// Sync Check 4 bytes //
	//======================================================================//
	n = 4;
	
	RetVal = FALSE;
	while (RetVal == FALSE)
	{
		if(TimeOverCheck(nPtr->TimerRx)) return FALSE;

		if(nPtr->CheckByte(1, &nCnt))
		{
			Data = nPtr->RxGetByte();
			
			if(N_STX == Data/*nPtr->RxGetByte()*/)
			{
				Recv->Sync = N_STX;
				RetVal = TRUE;
			}
		}
		else OSTimeDly(100L);
	}
	
	TimerRegist(nPtr->TimerRx, Time1Sec);

	//======================//
	// Header Check 5 bytes //
	//======================================================================//
	n = 19;
	while ( !nPtr->CheckByte(n, &nCnt) )
	{
		if (TRUE == TimeOverCheck(nPtr->TimerRx) ) return(FALSE);
		OSTimeDly(100L);
	}
	Recv->R_Code		= nPtr->RxGetByte();
	for(i=0; i<10; i++)
		Recv->RepeaterID[i]	= nPtr->RxGetByte();
	Recv->P_ID[0]		= nPtr->RxGetByte();
	Recv->P_ID[1]		= nPtr->RxGetByte();
	Recv->DstID.MuID	= nPtr->RxGetByte();
	Recv->DstID.HuID	= nPtr->RxGetByte();
	Recv->DstID.RuID	= nPtr->RxGetByte();
	Recv->Command		= nPtr->RxGetByte();
	Recv->DataLength[0]   = nPtr->RxGetByte();
	Recv->DataLength[1]   = nPtr->RxGetByte();
	Recv->SubDataLength = (((INT16U)Recv->DataLength[0])<<8) + (((INT16U)Recv->DataLength[1])&0xff);
	n = Recv->SubDataLength;
	
	//====================//
	// Data Check n bytes //
	//======================================================================//
	if ( n > BODYSIZEMAX ) return(FALSE);

	while ( !nPtr->CheckByte(n + 2, &nCnt) )
	{
		if(TimeOverCheck(nPtr->TimerRx)) return(FALSE);
		OSTimeDly(100L);
	}
	for(i = 0; i < n+2; i++ )	Recv->Data[i] = nPtr->RxGetByte();

	// ETX
	Recv->Data[i] = nPtr->RxGetByte();	

	if(Recv->Data[i]!=ETX)	return	FALSE;

/*
#ifdef DBG_ETH1_OUT
	if(nPtr == Eth0)
	{
		pUSART1.printf("\n\n Eth0 RX[%d] = ",  nPtr->Recv->SubDataLength+23);
		for(i=0; i<nPtr->Recv->SubDataLength+23; i++)
			pUSART1.printf("%02x ", *((INT8U *)nPtr->Recv + i));
	}
#endif
*/
	//===========//
	// CRC Check //
	//======================================================================//
	Recv->Crc = Crc16Calc( &Recv->R_Code, n + 19, NULL);
/*
#ifdef DBG_ETH1_OUT
	pUSART1.printf("%04x [%02x][%02x]", Recv->Crc, Recv->Data[n+0], Recv->Data[n+1]);
#endif
*/
	if ( (INT8U)(Recv->Crc>>8)	!= Recv->Data[n+0] ) RetVal = FALSE;
	if ( (INT8U)(Recv->Crc) 	!= Recv->Data[n+1] ) RetVal = FALSE;
	//======================================================================//
	if ( RetVal == FALSE )
	{
		INT8U	uTemp[2];

		uTemp[0] = ERR_CRC;
		NmsDataAckTx((INT8U*)uTemp, 1, N_Error_CMD, nPtr);
		return FALSE;
	}
	return TRUE;
}

//=======================================================================//
void N_ProtocolComCheck (__N_ProtocolPtr *nPtr)
{
	INT8U	PathChk = 0;
	INT8U	uTemp[2];

	__ProtocolPtr *TarPtr;
	
	NMS *Recv = nPtr->Recv;

	PathChk = ID_Check(Recv->DstID);
	
	if(PathChk == MY_PATH)
	{
		switch(Recv->Command)
		{
			//-----------------------------------------------------------------------//
			case N_Status_CMD:
				NmsDataCopy(MU_PATH, Recv->DstID);
				NmsDataAckTx((INT8U*)N_MuStatus, sizeof(__N_MU_STS), N_Status_CMD, nPtr);
			break;

			case N_Control_CMD:
				if(Recv->SubDataLength != sizeof(__N_MU_CTRL)) break;

				N_SetDnrCtrlData((__N_MU_CTRL*)Recv->Data);
				NmsDataCopy(MU_PATH, Recv->DstID);
				NmsDataAckTx((INT8U*)N_MuStatus, sizeof(__N_MU_STS), N_Control_CMD, nPtr);
			break;

			case N_Alarm_CMD:
				MuStatus->MuAlm.Reset_Alarm = 0;
				MuStatus->ResetReason = 0;

				MuBootCnt = 0;
			break;

			//-----------------------------------------------------------------------//
			case N_DownloadCMD:
			case N_DownloadCMDConfirm:
			case N_DownLoadData:
			case N_DownLoadDataConfirm:
				DownLoadGiveupTimerSet((INT32U)nPtr);
				WRCS_DownloadFunc(nPtr);
			break;

			//-----------------------------------------------------------------------//
			default:
				uTemp[0] = ERR_FRAME;
				NmsDataAckTx((INT8U*)uTemp, 1, N_Error_CMD, nPtr);
			break;
		}
	}	
	else if(PathChk == HU_PATH)
	{
		if(!InstallCheck(Recv->DstID, HU_PATH))
		{
			uTemp[0] = ERR_NOT_INST;
			NmsDataAckTx((INT8U*)uTemp, 1, N_Error_CMD, nPtr);
			return;
		}
		
		switch(Recv->Command)
		{
			//-----------------------------------------------------------------------//
			case N_Status_CMD:
				NmsDataCopy(HU_PATH, Recv->DstID);
				NmsDataAckTx((INT8U*)N_HuStatus, sizeof(__N_HU_STS), N_Status_CMD, nPtr);
			break;

			case N_Control_CMD:
				if(Recv->SubDataLength != sizeof(__N_HU_CTRL)) break;

				GetHuCommand();
				
				if((Recv->DstID.HuID==0)||(Recv->DstID.HuID==1))		TarPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Recv->DstID.HuID==2)||(Recv->DstID.HuID==3))	TarPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Recv->DstID.HuID==4)||(Recv->DstID.HuID==5))	TarPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Recv->DstID.HuID==6)||(Recv->DstID.HuID==7))	TarPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				MuxControl(Recv->DstID.HuID);
				Eth0_Control_Hu_Conv(Recv->DstID, (__N_HU_CTRL*)Recv->Data, TarPtr);

				if(ProtocolCheck(TarPtr, (Time1Sec*2)))
				{
					HuProtocolComCheck(TarPtr, nPtr);
				}
				EndHuCommand();
			break;

			case N_Alarm_CMD:
				//SerPtr->printf("\nHu Alarm ACK [%x][%x][%x]", Recv->DstID.MuID, Recv->DstID.HuID, Recv->DstID.RuID);
				HuBootFlag[Recv->DstID.HuID] = 0;
				HuBootCnt[Recv->DstID.HuID] = 0;
			break;

			//-----------------------------------------------------------------------//
			case N_DownloadCMD:
			case N_DownloadCMDConfirm:
			case N_DownLoadData:
			case N_DownLoadDataConfirm:
				GetHuCommand();
				
				if((Recv->DstID.HuID==0)||(Recv->DstID.HuID==1))		TarPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Recv->DstID.HuID==2)||(Recv->DstID.HuID==3))	TarPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Recv->DstID.HuID==4)||(Recv->DstID.HuID==5))	TarPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Recv->DstID.HuID==6)||(Recv->DstID.HuID==7))	TarPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				MuxControl(Recv->DstID.HuID);
				SioDataAckTx(MyID, Recv->DstID, (INT8U*)Recv->Data, Recv->SubDataLength, Recv->Command, TarPtr);

				if(ProtocolCheck(TarPtr, (Time1Sec*2)))
				{
					HuProtocolComCheck(TarPtr, nPtr);
				}
				EndHuCommand();
			break;

			//-----------------------------------------------------------------------//
		}
	}
	else if(PathChk == RU_PATH)
	{
		if(!InstallCheck(Recv->DstID, RU_PATH))
		{
			uTemp[0] = ERR_NOT_INST;
			NmsDataAckTx((INT8U*)uTemp, 1, N_Error_CMD, nPtr);
			return;
		}
		
		switch(Recv->Command)
		{
			//-----------------------------------------------------------------------//
			case N_Status_CMD:
				NmsDataCopy(RU_PATH, Recv->DstID);
				NmsDataAckTx((INT8U*)N_RuStatus, sizeof(__N_RU_STS), N_Status_CMD, nPtr);
			break;

			case N_Control_CMD:
				if(Recv->SubDataLength != sizeof(__N_RU_CTRL)) break;

				GetHuCommand();
				
				if((Recv->DstID.HuID==0)||(Recv->DstID.HuID==1))		TarPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Recv->DstID.HuID==2)||(Recv->DstID.HuID==3))	TarPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Recv->DstID.HuID==4)||(Recv->DstID.HuID==5))	TarPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Recv->DstID.HuID==6)||(Recv->DstID.HuID==7))	TarPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				MuxControl(Recv->DstID.HuID);
				Eth0_Control_Ru_Conv(Recv->DstID, (__N_RU_CTRL*)Recv->Data, TarPtr);

				if(ProtocolCheck(TarPtr, (Time1Sec*6)))
				{
					HuProtocolComCheck(TarPtr, nPtr);
				}
				EndHuCommand();
			break;

			case N_Alarm_CMD:
				//SerPtr->printf("\nRu Alarm ACK [%x][%x][%x]", Recv->DstID.MuID, Recv->DstID.HuID, Recv->DstID.RuID);
				RuBootFlag[Recv->DstID.HuID][((Recv->DstID.RuID>>4)&0x0F)] = 0;
				RuBootCnt[Recv->DstID.HuID][((Recv->DstID.RuID>>4)&0x0F)] = 0;
			break;

			//-----------------------------------------------------------------------//
			case N_DownloadCMD:
			case N_DownloadCMDConfirm:
			case N_DownLoadData:
			case N_DownLoadDataConfirm:
				GetHuCommand();
				
				if((Recv->DstID.HuID==0)||(Recv->DstID.HuID==1))		TarPtr = (__ProtocolPtr *)Hu_Ser2Ser;
				else if((Recv->DstID.HuID==2)||(Recv->DstID.HuID==3))	TarPtr = (__ProtocolPtr *)Hu_Ser3Ser;
				else if((Recv->DstID.HuID==4)||(Recv->DstID.HuID==5))	TarPtr = (__ProtocolPtr *)Hu_Ser5Ser;
				else if((Recv->DstID.HuID==6)||(Recv->DstID.HuID==7))	TarPtr = (__ProtocolPtr *)Hu_Ser6Ser;

				MuxControl(Recv->DstID.HuID);
				SioDataAckTx(MyID, Recv->DstID, (INT8U*)Recv->Data, Recv->SubDataLength, Recv->Command, TarPtr);

				if(ProtocolCheck(TarPtr, (Time1Sec*6)))
				{
					HuProtocolComCheck(TarPtr, nPtr);
				}
				EndHuCommand();
			break;

			//-----------------------------------------------------------------------//
		}
	}
	else
	{
		uTemp[0] = ERR_NOT_INST;
		NmsDataAckTx((INT8U*)uTemp, 1, N_Error_CMD, nPtr);
	}
}

void NmsDataAckTx(INT8U *Data, INT16U nCnt, INT8U Comm, __N_ProtocolPtr *toPtr)
{
//	INT8U	err = 0;
	INT16U	i = 0;
	
	NMS *Send = toPtr->Send;
	NMS *Recv = toPtr->Recv;
	
//	OSSemPend(toPtr->OSSem, 0, &err );

	if( nCnt > BODYSIZEMAX ) {
//		OSSemPost(toPtr->OSSem);
		return;
	}

	Send->Sync			= N_STX;
	Send->R_Code		= Recv->R_Code;
	for(i=0; i<10; i++)
		Send->RepeaterID[i] = MuStatus->RepeaterID[i];
	Send->P_ID[0]		= Recv->P_ID[0];
	Send->P_ID[1]		= Recv->P_ID[1];
	
	Send->DstID.MuID	= Recv->DstID.MuID;
	Send->DstID.HuID	= Recv->DstID.HuID;
	Send->DstID.RuID	= Recv->DstID.RuID;
	Send->Command		= Comm;
	Send->SubDataLength = nCnt;
	Send->DataLength[0] = (INT8U)(Send->SubDataLength>>8);
	Send->DataLength[1] = (INT8U)(Send->SubDataLength&0xff);

	for(i=0; i<nCnt && i < BODYSIZEMAX; i++)
		Send->Data[i]	= *((INT8U *)Data + i);
	
	Send->Crc = Crc16Calc((INT8U*)&Send->R_Code, i+19, NULL);
	Send->Data[i++] = (INT8U)(Send->Crc>>8);
	Send->Data[i++] = (INT8U)(Send->Crc);
	Send->Data[i++] = ETX; 

	toPtr->PutStr((INT8U *)Send, nCnt+23, ENABLE);


//	OSSemPost(toPtr->OSSem);	


/*
#ifdef DBG_ETH1_OUT
	if(toPtr == Eth0)
	{
		SerPtr->printf("\n Eth0 TX[%d] = ", Send->SubDataLength+15);
		for(i=0; i<Send->SubDataLength+15; i++)
			SerPtr->printf("%02x ", *((INT8U *)Send + i));
	}
#endif
*/
}

void NmsAlarmAckTx(SubIDStr TarID, INT8U *Data, INT16U nCnt, __N_ProtocolPtr *toPtr)
{
	INT16U	i = 0;
	
	NMS *Send = toPtr->Send;
	NMS *Recv = toPtr->Recv;
	
	if( nCnt > BODYSIZEMAX )	return;
	
	Send->Sync			= N_STX;
	Send->R_Code		= Recv->R_Code;
	for(i=0; i<10; i++)
		Send->RepeaterID[i] = MuStatus->RepeaterID[i];
	Send->P_ID[0]		= Recv->P_ID[0];
	Send->P_ID[1]		= Recv->P_ID[1];
	
	Send->DstID.MuID	= TarID.MuID;
	Send->DstID.HuID	= TarID.HuID;
	Send->DstID.RuID	= TarID.RuID;
	Send->Command		= N_Alarm_CMD;
	Send->SubDataLength = nCnt;
	Send->DataLength[0] = (INT8U)(Send->SubDataLength>>8);
	Send->DataLength[1] = (INT8U)(Send->SubDataLength&0xff);

	for(i=0; i<nCnt && i < BODYSIZEMAX; i++)
		Send->Data[i]	= *((INT8U *)Data + i);
	
	Send->Crc = Crc16Calc((INT8U*)&Send->R_Code, i+19, NULL);
	Send->Data[i++] = (INT8U)(Send->Crc>>8);
	Send->Data[i++] = (INT8U)(Send->Crc);
	Send->Data[i++] = ETX; 

	toPtr->PutStr((INT8U *)Send, nCnt+23, ENABLE);


#ifdef DBG_ETH1_OUT
	if(toPtr == Eth0)
	{
		SerPtr->printf("\n Eth0 TX[%d] = ", Send->SubDataLength);
		for(i=0; i<Send->SubDataLength+23; i++)
			SerPtr->printf("%02x ", *((INT8U *)Send + i));
	}
#endif

}


void NmsDataCopy(INT8U Path, SubIDStr TarID)
{
	INT16U	i, j, k;
	INT8U	BrID, RuID;
	INT8U	uVal = 0;

	switch(Path)
	{
		case MU_PATH:
			
			//-----------------------------------------------------------------------//
			// System
			N_MuStatus->MakerID			= MuStatus->MakerID;
			N_MuStatus->ProgramVer[0]	= MuStatus->ProgramVer[0];
			N_MuStatus->ProgramVer[1]	= MuStatus->ProgramVer[1];
			N_MuStatus->DtuVer			= MuStatus->DtuVer;
			for(i=0; i<10; i++)
				N_MuStatus->RepeaterID[i]	= MuStatus->RepeaterID[i];
			
			//-----------------------------------------------------------------------//
			// HU Install
			for(i=0; i<HU_MAX; i++)
			{
				if(SysInfo->Hu_Install[i] != _NotInstall)	BitSet(N_MuStatus->Hu_Inst, N_Hu1_Bit+i);
				else										BitRst(N_MuStatus->Hu_Inst, N_Hu1_Bit+i);
			}
			
			// HU-RU Install
			for(i=0; i<MDTU_MAX; i++)
			{
				for(j=0; j<HDTU_MAX; j++)
				{
					uVal = j%2; 
					
					for(k=0; k<HU_RU_MAX; k++)
					{
						if(SysInfo->Hu_Ru[i].Ru_Install[j][k] !=_NotInstall)
								BitSet(N_MuStatus->Hu_Ru_Inst[i][(j/2)], N_Br1_Ru1_Bit+(uVal*4)+k);
						else	BitRst(N_MuStatus->Hu_Ru_Inst[i][(j/2)], N_Br1_Ru1_Bit+(uVal*4)+k);
					}
				}
			}
			
			// MU-RU Install
			for(i=0; i<MDTU_MAX; i++)
			{
				for(j=0; j<MU_RU_MAX; j++)
				{
					if(SysInfo->Mu_Ru_Install[i][j]==_Install)
							BitSet(N_MuStatus->Mu_Ru_Install[i], N_Ru1_Bit+j);
					else	BitRst(N_MuStatus->Mu_Ru_Install[i], N_Ru1_Bit+j);
				}
			}
						
			//-----------------------------------------------------------------------//
			// System
			N_MuStatus->MuAlm.Data[0] = MuStatus->MuAlm.Data[0]&0x5D;
			N_MuStatus->MuAlm.Data[1] = MuStatus->MuAlm.Data[1]&0x0F;

			N_MuStatus->EnvTemp			= MuStatus->EnvTemp;
			N_MuStatus->FanTemp			= MuStatus->FanTemp;
			N_MuStatus->FanMode			= MuStatus->FanMode;
			
			// MDTU
			for(i=0; i<MDTU_MAX; i++)
			{
				N_MuStatus->MdtuSts[i].Install		= MuStatus->MdtuSts[i].Install;
				N_MuStatus->MdtuSts[i].Alarm.Data	= MuStatus->MdtuSts[i].Alarm.Data&0x03;
				N_MuStatus->MdtuSts[i].PD_Power		= MuStatus->MdtuSts[i].PD_Power;
				N_MuStatus->MdtuSts[i].LD_Power		= MuStatus->MdtuSts[i].LD_Power;
				N_MuStatus->MdtuSts[i].BIP			= MuStatus->MdtuSts[i].BIP;
				N_MuStatus->MdtuSts[i].OpticSum 	= MuStatus->MdtuSts[i].OpticSum;
			}
			
			// MRFU
			for(i=0; i<RFU_MAX; i++)
			{
				N_MuStatus->MrfuSts[i].Install		= MuStatus->MrfuSts[i].Install;
				N_MuStatus->MrfuSts[i].Alarm.Data	= MuStatus->MrfuSts[i].Alarm.Data&0x9F;
				N_MuStatus->MrfuSts[i].DL_OutPower	= swab16(MuStatus->MrfuSts[i].DL_OutPower);
				N_MuStatus->MrfuSts[i].DL_Attn		= MuStatus->MrfuSts[i].DL_Attn;
				N_MuStatus->MrfuSts[i].DL_ALC_High	= MuStatus->MrfuSts[i].DL_ALC_High;
				N_MuStatus->MrfuSts[i].DL_Alc_OnOffH	= MuStatus->MrfuSts[i].DL_Alc_OnOffH;
				N_MuStatus->MrfuSts[i].UL_OutPower	= swab16(MuStatus->MrfuSts[i].UL_OutPower);
				N_MuStatus->MrfuSts[i].UL_Attn	 	= MuStatus->MrfuSts[i].UL_Attn;
				N_MuStatus->MrfuSts[i].UL_ALC_High	= MuStatus->MrfuSts[i].UL_ALC_High;
				N_MuStatus->MrfuSts[i].UL_Alc_OnOffH	= MuStatus->MrfuSts[i].UL_Alc_OnOffH;
				N_MuStatus->MrfuSts[i].UL_SD_Limit	= MuStatus->MrfuSts[i].UL_SD_Limit;
				N_MuStatus->MrfuSts[i].UL_SD_OnOff	= MuStatus->MrfuSts[i].UL_SD_OnOff;
				N_MuStatus->MrfuSts[i].UL_Amp_OnOff	= MuStatus->MrfuSts[i].UL_Amp_OnOff;
				N_MuStatus->MrfuSts[i].UL_SD_Count	= Sd_Count[i];//MuStatus->MrfuSts[i].Alarm.UL_SD_Alarm_C;
			}

			// CFR
			for(i=0; i<RFU_MAX; i++)
			{
				N_MuStatus->Cfr_Select[i].Data		= MuStatus->CfrSts[i].Cfr_Select.Data;
			}

			N_MuStatus->AlarmMask = MuStatus->AlarmMask;
			N_MuStatus->ResetReason = 0;
			N_MuStatus->MuAlm.Reset_Alarm = _Normal;
/*
			if(MuStatus->MuAlm.Reset_Alarm == _Alarm)
			{
				N_MuStatus->MuAlm.Data[0] = 0;
				N_MuStatus->MuAlm.Data[1] = 0;
				N_MuStatus->MuAlm.Reset_Alarm = _Alarm;
			}
*/			
			break;

		case HU_PATH:
			//-----------------------------------------------------------------------//
			// System
			N_HuStatus->MakerID			= HuStatus[TarID.HuID]->MakerID;
			N_HuStatus->ProgramVer[0]	= HuStatus[TarID.HuID]->ProgramVer[0];
			N_HuStatus->ProgramVer[1]	= HuStatus[TarID.HuID]->ProgramVer[1];
			N_HuStatus->DtuVer			= HuStatus[TarID.HuID]->DtuVer;
			for(i=0; i<10; i++)
				N_HuStatus->RepeaterID[i]	= HuStatus[TarID.HuID]->RepeaterID[i];
			
			//-----------------------------------------------------------------------//
			// System
			N_HuStatus->HuAlm.Data[0] = HuStatus[TarID.HuID]->HuAlm.Data[0]&0xDF;
			N_HuStatus->HuAlm.Data[1] = HuStatus[TarID.HuID]->HuAlm.Data[1];

			N_HuStatus->EnvTemp			= HuStatus[TarID.HuID]->EnvTemp;

			// HDTU
			N_HuStatus->Mu_HdtuSts.Install	= HuStatus[TarID.HuID]->Mu_HdtuSts.Install;
			N_HuStatus->Mu_HdtuSts.Alarm.Data	= HuStatus[TarID.HuID]->Mu_HdtuSts.Alarm.Data&0x03;
			N_HuStatus->Mu_HdtuSts.PD_Power		= HuStatus[TarID.HuID]->Mu_HdtuSts.PD_Power;
			N_HuStatus->Mu_HdtuSts.LD_Power		= HuStatus[TarID.HuID]->Mu_HdtuSts.LD_Power;
			N_HuStatus->Mu_HdtuSts.BIP			= HuStatus[TarID.HuID]->Mu_HdtuSts.BIP;
			N_HuStatus->Mu_HdtuSts.OpticSum 	= HuStatus[TarID.HuID]->Mu_HdtuSts.OpticSum;
			
			for(i=0; i<HDTU_MAX; i++)
			{
				N_HuStatus->HdtuSts[i].Install		= HuStatus[TarID.HuID]->HdtuSts[i].Install;
				N_HuStatus->HdtuSts[i].Alarm.Data	= HuStatus[TarID.HuID]->HdtuSts[i].Alarm.Data&0x03;
				N_HuStatus->HdtuSts[i].PD_Power		= HuStatus[TarID.HuID]->HdtuSts[i].PD_Power;
				N_HuStatus->HdtuSts[i].LD_Power		= HuStatus[TarID.HuID]->HdtuSts[i].LD_Power;
				N_HuStatus->HdtuSts[i].BIP			= HuStatus[TarID.HuID]->HdtuSts[i].BIP;
				N_HuStatus->HdtuSts[i].OpticSum 	= HuStatus[TarID.HuID]->HdtuSts[i].OpticSum;
			}
			
			N_HuStatus->AlarmMask = HuStatus[TarID.HuID]->AlarmMask;
			N_HuStatus->HuAlm.Reset_Alarm = _Normal;
			N_HuStatus->ResetReason = 0;
			/*
			if(HuBootFlag[TarID.HuID] != 0)
			{
				N_HuStatus->HuAlm.Data[0] = 0;
				N_HuStatus->HuAlm.Data[1] = 0;
				
				N_HuStatus->ResetReason = HuBootFlag[TarID.HuID];
				N_HuStatus->HuAlm.Reset_Alarm = _Alarm;
			}
			else	N_HuStatus->ResetReason = HuStatus[TarID.HuID]->ResetReason;
			*/
			break;

		case RU_PATH:
			BrID = (TarID.RuID>>4)&0x0F;
			RuID = TarID.RuID&0x0F;
			if(RuID > 0)	RuID = 0;
			
			//-----------------------------------------------------------------------//
			// System
			N_RuStatus->MakerID			= RuBuf[TarID.HuID][BrID][RuID]->MakerID;
			N_RuStatus->ProgramVer[0]	= RuBuf[TarID.HuID][BrID][RuID]->ProgramVer[0];
			N_RuStatus->ProgramVer[1]	= RuBuf[TarID.HuID][BrID][RuID]->ProgramVer[1];
			N_RuStatus->DtuVer			= RuBuf[TarID.HuID][BrID][RuID]->DtuVer;
			for(i=0; i<10; i++)
				N_RuStatus->RepeaterID[i]	= RuBuf[TarID.HuID][BrID][RuID]->RepeaterID[i];
			
			//-----------------------------------------------------------------------//
			// System
			N_RuStatus->RuAlm.Data[0] 	= RuBuf[TarID.HuID][BrID][RuID]->RuAlm.Data[0]&0xD1;
			N_RuStatus->RuAlm.Data[1]	= RuBuf[TarID.HuID][BrID][RuID]->RuAlm.Data[1]&0x0F;
			N_RuStatus->RuAlm.S_VSWR_Alarm	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[0].Alarm.VSWR_Alarm;
			N_RuStatus->RuAlm.M_VSWR_Alarm	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[1].Alarm.VSWR_Alarm;

			N_RuStatus->EnvTemp			= RuBuf[TarID.HuID][BrID][RuID]->EnvTemp;
			
			// RDTU
			for(i=0; i<RDTU_MAX; i++)
			{
				N_RuStatus->RdtuSts[i].Install		= RuBuf[TarID.HuID][BrID][RuID]->RdtuSts[i].Install;
				N_RuStatus->RdtuSts[i].Alarm.Data	= RuBuf[TarID.HuID][BrID][RuID]->RdtuSts[i].Alarm.Data&0x03;
				N_RuStatus->RdtuSts[i].PD_Power		= RuBuf[TarID.HuID][BrID][RuID]->RdtuSts[i].PD_Power;
				N_RuStatus->RdtuSts[i].LD_Power		= RuBuf[TarID.HuID][BrID][RuID]->RdtuSts[i].LD_Power;
				N_RuStatus->RdtuSts[i].BIP			= RuBuf[TarID.HuID][BrID][RuID]->RdtuSts[i].BIP;
			}
			
			// Optic Common
			N_RuStatus->Optic_Switch	= 0;
			N_RuStatus->IR_UL_Sum		= 0;
			N_RuStatus->DL_Delay_21G	= swab16(RuBuf[TarID.HuID][BrID][RuID]->DL_Delay_21G);
			N_RuStatus->UL_Delay_21G	= swab16(RuBuf[TarID.HuID][BrID][RuID]->UL_Delay_21G);
			N_RuStatus->DL_Delay_900M	= swab16(RuBuf[TarID.HuID][BrID][RuID]->DL_Delay_900M);
			N_RuStatus->UL_Delay_900M	= swab16(RuBuf[TarID.HuID][BrID][RuID]->UL_Delay_900M);
			N_RuStatus->DL_Delay_25G	= swab16(RuBuf[TarID.HuID][BrID][RuID]->DL_Delay_25G);
			N_RuStatus->UL_Delay_25G	= swab16(RuBuf[TarID.HuID][BrID][RuID]->UL_Delay_25G);
			
			// RRFU
			for(i=0; i<RFU_MAX; i++)
			{
				N_RuStatus->RrfuSts[i].Install				= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Install;
				N_RuStatus->RrfuSts[i].Alarm.DL_Pll			= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Alarm.DL_Pll;
				N_RuStatus->RrfuSts[i].Alarm.UL_Pll			= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Alarm.UL_Pll;
				N_RuStatus->RrfuSts[i].Alarm.DL_OutLimitH_Alarm	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Alarm.DL_OutLimitH_Alarm;
				N_RuStatus->RrfuSts[i].Alarm.UL_OverInput	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Alarm.UL_OverInput;
				N_RuStatus->RrfuSts[i].Alarm.Tsync_Alarm	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Alarm.Tsync_Alarm;
				N_RuStatus->RrfuSts[i].Alarm.DL_SD_Alarm	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Alarm.DL_SD_Alarm;
				N_RuStatus->RrfuSts[i].Alarm.UL_SD_Alarm	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].Alarm.UL_SD_Alarm;
								
				N_RuStatus->RrfuSts[i].DL_OutPower		= swab16(RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_OutPower);
				N_RuStatus->RrfuSts[i].DL_Attn			= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_Attn;
				N_RuStatus->RrfuSts[i].DL_ALC_High		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_ALC_High;
				N_RuStatus->RrfuSts[i].DL_Alc_OnOffH 	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_Alc_OnOffH;
				N_RuStatus->RrfuSts[i].DL_Amp_OnOff 	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_Amp_OnOff;

				N_RuStatus->RrfuSts[i].UL_InPower 		= swab16(RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_InPower);
				N_RuStatus->RrfuSts[i].UL_Attn 			= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_Attn;
				N_RuStatus->RrfuSts[i].UL_Amp_OnOff 	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_Amp_OnOff;
				
				N_RuStatus->RrfuSts[i].DL_SD_Limit 		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_SD_Limit;
				N_RuStatus->RrfuSts[i].DL_SD_OnOff 		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_SD_OnOff;
				N_RuStatus->RrfuSts[i].UL_SD_Limit 		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_SD_Limit;
				N_RuStatus->RrfuSts[i].UL_SD_OnOff 		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_SD_OnOff;

				N_RuStatus->RrfuSts[i].UL_ALC_High 		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_ALC_High;
				N_RuStatus->RrfuSts[i].UL_Alc_OnOffH 	= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_Alc_OnOffH;
				
				N_RuStatus->RrfuSts[i].DL_SD_Count		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].DL_SD_Count;
				N_RuStatus->RrfuSts[i].UL_SD_Count		= RuBuf[TarID.HuID][BrID][RuID]->RrfuSts[i].UL_SD_Count;
			}
			
			N_RuStatus->AlarmMask = RuBuf[TarID.HuID][BrID][RuID]->AlarmMask;
			N_RuStatus->ResetReason = 0;
			N_RuStatus->RuAlm.Reset_Alarm = _Normal;
			/*	
			if(RuBootFlag[TarID.HuID][BrID] != 0)
			{
				N_RuStatus->RuAlm.Data[0] = 0;
				N_RuStatus->RuAlm.Data[1] = 0;
				
				N_RuStatus->ResetReason = RuBootFlag[TarID.HuID][BrID];
				N_RuStatus->RuAlm.Reset_Alarm = _Alarm;
			}
			else	N_RuStatus->ResetReason = RuBuf[TarID.HuID][BrID][RuID]->ResetReason;
			*/
			break;
	}
}

void Eth0_Control_Hu_Conv(SubIDStr DstID, __N_HU_CTRL *nPtr, __ProtocolPtr *Target)
{
	INT16U	i = 0;
	
	__HU_CTRL	CtrlB, *Ctrl = &CtrlB;

	for(i=0; i<sizeof(__HU_CTRL); i++)
	{
		*((INT8U*)Ctrl+i) = 0;
	}

	// Reset
	if(nPtr->CtrlFlag.System.Reset == 1)
	{
		SioDataAckTx(MyID, DstID, NULL, 0, ResetRQST, Target);
		OSTimeDly(100L);
		return;
	}

	// System
	if(nPtr->CtrlFlag.System.AlarmMask == 1)
	{
		Ctrl->CtrlFlag.System.AlarmMask = 1;
		Ctrl->AlarmMask = nPtr->AlarmMask;
	}
	
	// HDTU
	if(nPtr->CtrlFlag.Mu_Hdtu.OpticSum == 1)
	{
		Ctrl->CtrlFlag.Mu_Hdtu.OpticSum = 1;
		Ctrl->Mu_HdtuSts.OpticSum = nPtr->Mu_OpticSum;
	}

	for(i=0; i<HDTU_MAX; i++)
	{
		if(nPtr->CtrlFlag.Hdtu[i].OpticSum == 1)
		{
			Ctrl->CtrlFlag.Hdtu[i].OpticSum = 1;
			Ctrl->HdtuSts[i].OpticSum = nPtr->OpticSum[i];
		}
	}

	SioDataAckTx(MyID, DstID, (INT8U*)Ctrl, sizeof(__HU_CTRL), ControlRQST, Target);
}

void Eth0_Control_Ru_Conv(SubIDStr DstID, __N_RU_CTRL *nPtr, __ProtocolPtr *Target)
{
	INT16U	i = 0;
		
	__RU_CTRL	CtrlB, *Ctrl = &CtrlB;
	
	for(i=0; i<sizeof(__RU_CTRL); i++)
	{
		*((INT8U*)Ctrl+i) = 0;
	}

	// Reset
	if(nPtr->CtrlFlag.System.Reset == 1)
	{
		SioDataAckTx(MyID, DstID, NULL, 0, ResetRQST, Target);
		OSTimeDly(100L);
		return;
	}

	// System
	if(nPtr->CtrlFlag.System.AlarmMask == 1)
	{
		Ctrl->CtrlFlag.System.AlarmMask = 1;
		Ctrl->AlarmMask = nPtr->AlarmMask;
	}

	// Common
	//if(nPtr->CtrlFlag.OptCommon.Optic_Switch == 1)
	//if(nPtr->CtrlFlag.OptCommon.IR_UL_Sum == 1)
	if(nPtr->CtrlFlag.OptCommon.DL_Delay_21G == 1)
	{
		Ctrl->CtrlFlag.RdtuCommon.DL_Delay_21G = 1;
		Ctrl->DL_Delay_21G = swab16(nPtr->DL_Delay_21G);
	}
	if(nPtr->CtrlFlag.OptCommon.UL_Delay_21G == 1)
	{
		Ctrl->CtrlFlag.RdtuCommon.UL_Delay_21G = 1;
		Ctrl->UL_Delay_21G = swab16(nPtr->UL_Delay_21G);
	}

	if(nPtr->CtrlFlag.OptCommon.DL_Delay_900M == 1)
	{
		Ctrl->CtrlFlag.RdtuCommon.DL_Delay_900M = 1;
		Ctrl->DL_Delay_900M = swab16(nPtr->DL_Delay_900M);
	}
	if(nPtr->CtrlFlag.OptCommon.UL_Delay_900M == 1)
	{
		Ctrl->CtrlFlag.RdtuCommon.UL_Delay_900M = 1;
		Ctrl->UL_Delay_900M = swab16(nPtr->UL_Delay_900M);
	}

	if(nPtr->CtrlFlag.OptCommon.DL_Delay_25G == 1)
	{
		Ctrl->CtrlFlag.RdtuCommon.DL_Delay_25G = 1;
		Ctrl->DL_Delay_25G = swab16(nPtr->DL_Delay_25G);
	}
	if(nPtr->CtrlFlag.OptCommon.UL_Delay_25G == 1)
	{
		Ctrl->CtrlFlag.RdtuCommon.UL_Delay_25G = 1;
		Ctrl->UL_Delay_25G = swab16(nPtr->UL_Delay_25G);
	}
			
	// Rrfu
	for(i=0; i<RFU_MAX; i++)
	{
		if(nPtr->CtrlFlag.Rrfu[i].DL_Amp_OnOff == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].DL_Amp_OnOff = 1;
			Ctrl->RrfuSts[i].DL_Amp_OnOff = nPtr->RrfuSts[i].DL_Amp_OnOff;
		}

		if(nPtr->CtrlFlag.Rrfu[i].DL_Attn == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].DL_Attn = 1;
			Ctrl->RrfuSts[i].DL_Attn = nPtr->RrfuSts[i].DL_Attn;
		}

		if(nPtr->CtrlFlag.Rrfu[i].DL_ALC_High == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].DL_ALC_High = 1;
			Ctrl->RrfuSts[i].DL_ALC_High = nPtr->RrfuSts[i].DL_ALC_High;
		}

		if(nPtr->CtrlFlag.Rrfu[i].DL_Alc_OnOffH == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].DL_Alc_OnOffH = 1;
			Ctrl->RrfuSts[i].DL_Alc_OnOffH = nPtr->RrfuSts[i].DL_Alc_OnOffH;
		}

		if(nPtr->CtrlFlag.Rrfu[i].UL_Amp_OnOff == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].UL_Amp_OnOff = 1;
			Ctrl->RrfuSts[i].UL_Amp_OnOff = nPtr->RrfuSts[i].UL_Amp_OnOff;
		}

		if(nPtr->CtrlFlag.Rrfu[i].DL_Amp_OnOff == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].DL_Amp_OnOff = 1;
			Ctrl->RrfuSts[i].DL_Amp_OnOff = nPtr->RrfuSts[i].DL_Amp_OnOff;
		}

		if(nPtr->CtrlFlag.Rrfu[i].UL_Attn == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].UL_Attn = 1;
			Ctrl->RrfuSts[i].UL_Attn = nPtr->RrfuSts[i].UL_Attn;
		}
		
		if(nPtr->CtrlFlag.Rrfu[i].DL_SD_Limit == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].DL_SD_Limit = 1;
			Ctrl->RrfuSts[i].DL_SD_Limit = nPtr->RrfuSts[i].DL_SD_Limit;
		}

		if(nPtr->CtrlFlag.Rrfu[i].DL_SD_OnOff == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].DL_SD_OnOff = 1;
			Ctrl->RrfuSts[i].DL_SD_OnOff = nPtr->RrfuSts[i].DL_SD_OnOff;
		}

		if(nPtr->CtrlFlag.Rrfu[i].UL_SD_Limit == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].UL_SD_Limit = 1;
			Ctrl->RrfuSts[i].UL_SD_Limit = nPtr->RrfuSts[i].UL_SD_Limit;
		}

		if(nPtr->CtrlFlag.Rrfu[i].UL_SD_OnOff == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].UL_SD_OnOff = 1;
			Ctrl->RrfuSts[i].UL_SD_OnOff = nPtr->RrfuSts[i].UL_SD_OnOff;
		}

		if(nPtr->CtrlFlag.Rrfu[i].UL_ALC_High == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].UL_ALC_High = 1;
			Ctrl->RrfuSts[i].UL_ALC_High = nPtr->RrfuSts[i].UL_ALC_High;
		}

		if(nPtr->CtrlFlag.Rrfu[i].UL_Alc_OnOffH == 1)
		{
			Ctrl->CtrlFlag.Rrfu[i].UL_Alc_OnOffH = 1;
			Ctrl->RrfuSts[i].UL_Alc_OnOffH = nPtr->RrfuSts[i].UL_Alc_OnOffH;
		}
		
	}
	SioDataAckTx(MyID, DstID, (INT8U*)Ctrl, sizeof(__RU_CTRL), ControlRQST, Target);
}


//==============================================================================//
void NmsBootAlarmReport(void)
{
	INT8U	i, j;
	SubIDStr TarID;
	
	//-----------------------------------------------------------------------//
	// Mu Boot Alarm
	if(MuStatus->MuAlm.Reset_Alarm)
	{
		if(MuBootCnt++>=3)
		{
			// Mu Reset Reason Clear
			MuStatus->MuAlm.Reset_Alarm = 0;
			MuStatus->ResetReason = 0;

			MuBootCnt = 0;
		}
		else
		{
			NmsDataCopy(MU_PATH, MyID);
			N_MuStatus->MuAlm.Data[0] = 0;
			N_MuStatus->MuAlm.Data[1] = 0;

			N_MuStatus->ResetReason = MuStatus->ResetReason;
			N_MuStatus->MuAlm.Reset_Alarm = _Alarm;
			
			//SerPtr->printf("\nMu Reset Reason=%d ",N_MuStatus->ResetReason);
			if(!eLink_Check(ETH0_CHANNEL))
				NmsAlarmAckTx(MyID, (INT8U*)N_MuStatus, sizeof(__N_MU_STS), Eth0);

			// Mu Reset Reason Clear
			//MuStatus->MuAlm.Reset_Alarm = 0;
			//MuStatus->ResetReason = 0;
		}
	}

	//-----------------------------------------------------------------------//
	// Hu Boot Alarm
	for(i=0; i<HU_MAX; i++)
	{
		TarID.MuID = 0x00;
		TarID.HuID = i;
		TarID.RuID = 0xFF;
		
		if(!InstallCheck(TarID, HU_PATH)) continue;
		
		if(HuBootFlag[i]!=0)
		{
			if(HuBootCnt[i]++>=3)
			{
				// Hu Reset Reason Clear
				HuBootFlag[i] = 0;
				HuBootCnt[i] = 0;
			}
			else
			{
				NmsDataCopy(HU_PATH, TarID);

				N_HuStatus->HuAlm.Data[0] = 0;
				N_HuStatus->HuAlm.Data[1] = 0;
				
				N_HuStatus->ResetReason = HuBootFlag[i];
				N_HuStatus->HuAlm.Reset_Alarm = _Alarm;
				
				//SerPtr->printf("\nHu Reset Reason=%d ",N_HuStatus->ResetReason);
				if(!eLink_Check(ETH0_CHANNEL))
					NmsAlarmAckTx(TarID, (INT8U*)N_HuStatus, sizeof(__N_HU_STS), Eth0);

				// Hu Reset Reason Clear
				//HuBootFlag[i] = 0;
			}
		}
	}

	//-----------------------------------------------------------------------//
	// Ru Boot Alarm
	for(i=0; i<HU_MAX; i++)
	{
		for(j=0; j<HDTU_MAX; j++)
		{
			TarID.MuID = 0x00;
			TarID.HuID = i;
			TarID.RuID = ((j<<4)&0xF0);
			
			if(!InstallCheck(TarID, RU_PATH)) continue;
			
			if(RuBootFlag[i][j]!=0)
			{
				if(HuBootCnt[i]++>=3)
				{
					// Ru Reset Reason Clear
					RuBootFlag[i][j] = 0;
					RuBootFlag[i][j] = 0;
				}
				else
				{
					NmsDataCopy(RU_PATH, TarID);

					N_RuStatus->RuAlm.Data[0] = 0;
					N_RuStatus->RuAlm.Data[1] = 0;
					
					N_RuStatus->ResetReason = RuBootFlag[i][j];
					N_RuStatus->RuAlm.Reset_Alarm = _Alarm;

					//SerPtr->printf("\nRu Reset Reason=%d ",N_RuStatus->ResetReason);
					if(!eLink_Check(ETH0_CHANNEL))
						NmsAlarmAckTx(TarID, (INT8U*)N_RuStatus, sizeof(__N_RU_STS), Eth0);

					// Ru Reset Reason Clear
					//RuBootFlag[i][j] = 0;
				}
			}
		}
	}
}

//==============================================================================//
void NmsAlarmReport(void)
{
	INT8U	i, j;
	SubIDStr TarID;
	
	//-----------------------------------------------------------------------//
	// Mu Alarm
	NmsMuAlarmReport();

	//-----------------------------------------------------------------------//
	// Hu Alarm
	for(i=0; i<HU_MAX; i++)
	{
		TarID.MuID = 0x00;
		TarID.HuID = i;
		TarID.RuID = 0xFF;
		
		if(!InstallCheck(TarID, HU_PATH)) continue;
		
		NmsHuAlarmReport(TarID);
	}

	//-----------------------------------------------------------------------//
	// Ru Alarm
	for(i=0; i<HU_MAX; i++)
	{
		for(j=0; j<HDTU_MAX; j++)
		{
			TarID.MuID = 0x00;
			TarID.HuID = i;
			TarID.RuID = ((j<<4)&0xF0);
			
			if(!InstallCheck(TarID, RU_PATH)) continue;
			
			NmsRuAlarmReport(TarID);
		}
	}
}

//-----------------------------------------------------------------------//
// MU
void NmsMuAlarmReport(void)
{
	INT8U	i;
	INT8U	FlagChk = 0;

	// Alarm Flag Check
	N_MuAlarm->AlarmFlag.System.Data = N_MuAlarm->Alarm.System.Data ^ N_MuAlarm->Old_Alarm.System.Data;
	N_MuAlarm->Old_Alarm.System.Data = N_MuAlarm->Alarm.System.Data;
	for(i=0; i<MDTU_MAX; i++)
	{
		N_MuAlarm->AlarmFlag.Opt[i].Data = N_MuAlarm->Alarm.Opt[i].Data ^ N_MuAlarm->Old_Alarm.Opt[i].Data;
		N_MuAlarm->Old_Alarm.Opt[i].Data = N_MuAlarm->Alarm.Opt[i].Data;
	}
	for(i=0; i<RFU_MAX; i++)
	{
		N_MuAlarm->AlarmFlag.Rf[i].Data = N_MuAlarm->Alarm.Rf[i].Data ^ N_MuAlarm->Old_Alarm.Rf[i].Data;
		N_MuAlarm->Old_Alarm.Rf[i].Data = N_MuAlarm->Alarm.Rf[i].Data;
	}

	// Alarm Mask
	if(MuStatus->AlarmMask == 1)	return;
	// Connection Check
	if(eLink_Check(ETH0_CHANNEL))	return;

	// Alarm Report OK
	if(N_MuAlarm->AlarmFlag.System.Data != 0)		FlagChk++;
	for(i=0; i<MDTU_MAX; i++)
		if(N_MuAlarm->AlarmFlag.Opt[i].Data != 0)	FlagChk++;
	for(i=0; i<RFU_MAX; i++)
		if(N_MuAlarm->AlarmFlag.Rf[i].Data != 0)	FlagChk++;	
	if(FlagChk != 0)
	{
		NmsDataCopy(MU_PATH, MyID);
		NmsAlarmAckTx(MyID, (INT8U*)N_MuStatus, sizeof(__N_MU_STS), Eth0);
	}
}

//-----------------------------------------------------------------------//
// HU
void NmsHuAlarmReport(SubIDStr DstID)
{
	INT8U	i;
	INT8U	FlagChk = 0;
	INT8U	HuID;

	HuID = DstID.HuID;

	// Alarm Flag Check
	N_HuAlarm[HuID]->AlarmFlag.System.Data = N_HuAlarm[HuID]->Alarm.System.Data ^ N_HuAlarm[HuID]->Old_Alarm.System.Data;
	N_HuAlarm[HuID]->Old_Alarm.System.Data = N_HuAlarm[HuID]->Alarm.System.Data;
	N_HuAlarm[HuID]->AlarmFlag.MuOpt.Data = N_HuAlarm[HuID]->Alarm.MuOpt.Data ^ N_HuAlarm[HuID]->Old_Alarm.MuOpt.Data;
	N_HuAlarm[HuID]->Old_Alarm.MuOpt.Data = N_HuAlarm[HuID]->Alarm.MuOpt.Data;
	for(i=0; i<HDTU_MAX; i++)
	{
		N_HuAlarm[HuID]->AlarmFlag.Opt[i].Data = N_HuAlarm[HuID]->Alarm.Opt[i].Data ^ N_HuAlarm[HuID]->Old_Alarm.Opt[i].Data;
		N_HuAlarm[HuID]->Old_Alarm.Opt[i].Data = N_HuAlarm[HuID]->Alarm.Opt[i].Data;
	}
	
	// Alarm Mask
	if(HuStatus[HuID]->AlarmMask == 1)	return;
	// Connection Check
	if(eLink_Check(ETH0_CHANNEL))	return;

	// Alarm Report OK
	if(N_HuAlarm[HuID]->AlarmFlag.System.Data != 0)		FlagChk++;
	if(N_HuAlarm[HuID]->AlarmFlag.MuOpt.Data != 0)		FlagChk++;
	for(i=0; i<HDTU_MAX; i++)
		if(N_HuAlarm[HuID]->AlarmFlag.Opt[i].Data != 0)	FlagChk++;
	
	if(FlagChk != 0)
	{
		NmsDataCopy(HU_PATH, DstID);
		NmsAlarmAckTx(DstID, (INT8U*)N_HuStatus, sizeof(__N_HU_STS), Eth0);
	}
}

//-----------------------------------------------------------------------//
// RU
void NmsRuAlarmReport(SubIDStr DstID)
{
	INT8U	i;
	INT8U	FlagChk = 0;
	INT8U	HuID, BrID, RuID;

	HuID = DstID.HuID;
	BrID = (DstID.RuID>>4)&0x0F;
	RuID = DstID.RuID&0x0F;

	// Alarm Flag Check
	N_RuAlarm[HuID][BrID]->AlarmFlag.System.Data = N_RuAlarm[HuID][BrID]->Alarm.System.Data ^ N_RuAlarm[HuID][BrID]->Old_Alarm.System.Data;
	N_RuAlarm[HuID][BrID]->Old_Alarm.System.Data = N_RuAlarm[HuID][BrID]->Alarm.System.Data;
	for(i=0; i<RDTU_MAX; i++)
	{
		N_RuAlarm[HuID][BrID]->AlarmFlag.Opt[i].Data = N_RuAlarm[HuID][BrID]->Alarm.Opt[i].Data ^ N_RuAlarm[HuID][BrID]->Old_Alarm.Opt[i].Data;
		N_RuAlarm[HuID][BrID]->Old_Alarm.Opt[i].Data = N_RuAlarm[HuID][BrID]->Alarm.Opt[i].Data;
	}
	for(i=0; i<RFU_MAX; i++)
	{
		N_RuAlarm[HuID][BrID]->AlarmFlag.Rf[i].Data = N_RuAlarm[HuID][BrID]->Alarm.Rf[i].Data ^ N_RuAlarm[HuID][BrID]->Old_Alarm.Rf[i].Data;
		N_RuAlarm[HuID][BrID]->Old_Alarm.Rf[i].Data = N_RuAlarm[HuID][BrID]->Alarm.Rf[i].Data;
	}
	
	// Alarm Mask
	if(RuBuf[HuID][BrID][RuID]->AlarmMask == 1)	return;
	// Connection Check
	if(eLink_Check(ETH0_CHANNEL))	return;

	// Alarm Report OK
	if(N_RuAlarm[HuID][BrID]->AlarmFlag.System.Data != 0)		FlagChk++;
	for(i=0; i<RDTU_MAX; i++)
		if(N_RuAlarm[HuID][BrID]->AlarmFlag.Opt[i].Data != 0)	FlagChk++;
	for(i=0; i<RFU_MAX; i++)
		if(N_RuAlarm[HuID][BrID]->AlarmFlag.Rf[i].Data != 0)	FlagChk++;
	
	if(FlagChk != 0)
	{
		NmsDataCopy(RU_PATH, DstID);
		NmsAlarmAckTx(DstID, (INT8U*)N_RuStatus, sizeof(__N_RU_STS), Eth0);
	}
}

//==============================================================================//
void AlarmUpdateAll(void)
{
	INT8U	i, j;
	SubIDStr TarID;
	
	//-----------------------------------------------------------------------//
	// Mu Alarm
	MuAlarmUpdate();

	//-----------------------------------------------------------------------//
	// Hu Alarm
	for(i=0; i<HU_MAX; i++)
	{
		TarID.MuID = 0x00;
		TarID.HuID = i;
		TarID.RuID = 0xFF;
		
		if(!InstallCheck(TarID, HU_PATH)) continue;
		
		HuAlarmUpdate(TarID);
	}

	//-----------------------------------------------------------------------//
	// Ru Alarm
	for(i=0; i<HU_MAX; i++)
	{
		for(j=0; j<HDTU_MAX; j++)
		{
			TarID.MuID = 0x00;
			TarID.HuID = i;
			TarID.RuID = ((j<<4)&0xF0);
			
			if(!InstallCheck(TarID, RU_PATH)) continue;
			
			RuAlarmUpdate(TarID);
		}
	}
}

void MuAlarmUpdate(void)
{
	INT8U	i=0;

	// System
	N_MuAlarm->Alarm.System.DcIn_Alarm		= MuStatus->MuAlm.DcIn_Alarm;
	N_MuAlarm->Alarm.System.DcOut_Alarm		= MuStatus->MuAlm.DcOut_Alarm;
	N_MuAlarm->Alarm.System.Fan_Alarm		= MuStatus->MuAlm.Fan_Alarm;
	N_MuAlarm->Alarm.System.TempH_Alarm		= MuStatus->MuAlm.TempH_Alarm;
	N_MuAlarm->Alarm.System.DtuSts_Alarm	= MuStatus->MuAlm.DtuSts_Alarm;
	N_MuAlarm->Alarm.System.DtuLink_Alarm	= MuStatus->MuAlm.DtuLink_Alarm;

	// Opt
	for(i=0; i<MDTU_MAX; i++)
	{
		N_MuAlarm->Alarm.Opt[i].Pd_Alarm		= MuStatus->MdtuSts[i].Alarm.Pd_Alarm;
		N_MuAlarm->Alarm.Opt[i].Ld_Alarm		= MuStatus->MdtuSts[i].Alarm.Ld_Alarm;
	}

	// RF
	for(i=0; i<RFU_MAX; i++)
	{
		N_MuAlarm->Alarm.Rf[i].DL_Pll				= MuStatus->MrfuSts[i].Alarm.DL_Pll;
		N_MuAlarm->Alarm.Rf[i].UL_Pll				= MuStatus->MrfuSts[i].Alarm.UL_Pll;
		N_MuAlarm->Alarm.Rf[i].DL_OutLimitH_Alarm	= MuStatus->MrfuSts[i].Alarm.DL_OutLimitH_Alarm;
		N_MuAlarm->Alarm.Rf[i].UL_OutLimitH_Alarm	= MuStatus->MrfuSts[i].Alarm.UL_OutLimitH_Alarm;
		N_MuAlarm->Alarm.Rf[i].UL_SD_Alarm			= MuStatus->MrfuSts[i].Alarm.UL_SD_Alarm;
		N_MuAlarm->Alarm.Rf[i].Tsync_Alarm			= MuStatus->MrfuSts[i].Alarm.Tsync_Alarm;
	}
}

void HuAlarmUpdate(SubIDStr DstID)
{
	INT8U	i=0;
	INT8U	HuID;

	HuID = DstID.HuID;

	// System
	N_HuAlarm[HuID]->Alarm.System.Dc_Alarm		= HuStatus[HuID]->HuAlm.Dc_Alarm;
	N_HuAlarm[HuID]->Alarm.System.PsuFan_Alarm	= HuStatus[HuID]->HuAlm.PsuFan_Alarm;
	N_HuAlarm[HuID]->Alarm.System.DtuFan1_Alarm	= HuStatus[HuID]->HuAlm.DtuFan1_Alarm;
	N_HuAlarm[HuID]->Alarm.System.DtuFan2_Alarm	= HuStatus[HuID]->HuAlm.DtuFan2_Alarm;
	N_HuAlarm[HuID]->Alarm.System.TempH_Alarm	= HuStatus[HuID]->HuAlm.TempH_Alarm;
	N_HuAlarm[HuID]->Alarm.System.DtuSts_Alarm	= HuStatus[HuID]->HuAlm.DtuSts_Alarm;
	N_HuAlarm[HuID]->Alarm.System.DtuLink_Alarm	= HuStatus[HuID]->HuAlm.DtuLink_Alarm;
	if(SysInfo->Hu_Install[HuID] == SYS_LINK_FAIL)	N_HuAlarm[HuID]->Alarm.System.LinkFail = _Alarm;
	else											N_HuAlarm[HuID]->Alarm.System.LinkFail = _Normal;

	// MuOpt
	N_HuAlarm[HuID]->Alarm.MuOpt.Pd_Alarm		= HuStatus[HuID]->Mu_HdtuSts.Alarm.Pd_Alarm;
	N_HuAlarm[HuID]->Alarm.MuOpt.Ld_Alarm		= HuStatus[HuID]->Mu_HdtuSts.Alarm.Ld_Alarm;
	
	// Opt
	for(i=0; i<HDTU_MAX; i++)
	{
		N_HuAlarm[HuID]->Alarm.Opt[i].Pd_Alarm	= HuStatus[HuID]->HdtuSts[i].Alarm.Pd_Alarm;
		N_HuAlarm[HuID]->Alarm.Opt[i].Ld_Alarm	= HuStatus[HuID]->HdtuSts[i].Alarm.Ld_Alarm;
	}
}

void RuAlarmUpdate(SubIDStr DstID)
{
	INT8U	i=0;
	INT8U	HuID, BrID, RuID;

	HuID = DstID.HuID;
	BrID = (DstID.RuID>>4)&0x0F;
	RuID = DstID.RuID&0x0F;

	// System
	N_RuAlarm[HuID][BrID]->Alarm.System.DcIn_Alarm		= RuBuf[HuID][BrID][RuID]->RuAlm.DcIn_Alarm;
	N_RuAlarm[HuID][BrID]->Alarm.System.TempH_Alarm		= RuBuf[HuID][BrID][RuID]->RuAlm.TempH_Alarm;
	N_RuAlarm[HuID][BrID]->Alarm.System.DtuSts_Alarm	= RuBuf[HuID][BrID][RuID]->RuAlm.DtuSts_Alarm;
	N_RuAlarm[HuID][BrID]->Alarm.System.DtuLink_Alarm	= RuBuf[HuID][BrID][RuID]->RuAlm.DtuLink_Alarm;

	// VSWR
	N_RuAlarm[HuID][BrID]->Alarm.System.S_VSWR_Alarm	= RuBuf[HuID][BrID][RuID]->RrfuSts[0].Alarm.VSWR_Alarm;
	N_RuAlarm[HuID][BrID]->Alarm.System.M_VSWR_Alarm	= RuBuf[HuID][BrID][RuID]->RrfuSts[1].Alarm.VSWR_Alarm;
	
	if(SysInfo->Hu_Ru[HuID].Ru_Install[BrID][RuID] == SYS_LINK_FAIL)	N_RuAlarm[HuID][BrID]->Alarm.System.LinkFail = _Alarm;
	else																N_RuAlarm[HuID][BrID]->Alarm.System.LinkFail = _Normal;
	
	// Opt
	for(i=0; i<RDTU_MAX; i++)
	{
		N_RuAlarm[HuID][BrID]->Alarm.Opt[i].Pd_Alarm		= RuBuf[HuID][BrID][RuID]->RdtuSts[i].Alarm.Pd_Alarm;
		N_RuAlarm[HuID][BrID]->Alarm.Opt[i].Ld_Alarm		= RuBuf[HuID][BrID][RuID]->RdtuSts[i].Alarm.Ld_Alarm;
	}

	// RF
	for(i=0; i<RFU_MAX; i++)
	{
		N_RuAlarm[HuID][BrID]->Alarm.Rf[i].DL_Pll			= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.DL_Pll;
		N_RuAlarm[HuID][BrID]->Alarm.Rf[i].UL_Pll			= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.UL_Pll;
		N_RuAlarm[HuID][BrID]->Alarm.Rf[i].DL_OutLimitH_Alarm		= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.DL_OutLimitH_Alarm;
		N_RuAlarm[HuID][BrID]->Alarm.Rf[i].UL_OverInput		= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.UL_OverInput;
		N_RuAlarm[HuID][BrID]->Alarm.Rf[i].Tsync_Alarm		= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.Tsync_Alarm;
		N_RuAlarm[HuID][BrID]->Alarm.Rf[i].DL_SD_Alarm		= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.DL_SD_Alarm;
		N_RuAlarm[HuID][BrID]->Alarm.Rf[i].UL_SD_Alarm		= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.UL_SD_Alarm;
		//N_RuAlarm[HuID][BrID]->Alarm.Rf[i].UL_Fire_Alarm	= RuBuf[HuID][BrID][RuID]->RrfuSts[i].Alarm.UL_Fire_Alarm;
	}
}


//=======================================================================//
// End of Source File
//=======================================================================//


