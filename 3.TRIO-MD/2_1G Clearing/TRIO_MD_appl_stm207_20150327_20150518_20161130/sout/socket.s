///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    11/Aug/2012  17:25:21 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\W3150A_ /
//                    v1.0.6\socket.c                                         /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\W3150A_ /
//                    v1.0.6\socket.c -lcN C:\user\project\FR-SSR\fw\appl_ssr /
//                    _20120717\sout\ -lB C:\user\project\FR-SSR\fw\appl_ssr_ /
//                    20120717\sout\ -o C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\sout\ --endian=little --cpu=Cortex-M3 -e         /
//                    --require_prototypes --fpu=None --dlib_config           /
//                    "C:\compiler\ewarm 5.5\arm\INC\DLib_Config_Normal.h"    /
//                    -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\include\ /
//                     -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\lib_stm /
//                    32\inc\ -I C:\user\project\FR-SSR\fw\appl_ssr_20120717\ /
//                    lib_stm32\src\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uC-CPU\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uC-LIB\ -I C:\user\project\FR-SSR\fw\appl_ssr_20 /
//                    120717\uCOS-II\Ports\ -I C:\user\project\FR-SSR\fw\appl /
//                    _ssr_20120717\uCOS-II\Source\ -I                        /
//                    C:\user\project\FR-SSR\fw\appl_ssr_20120717\uC-Probe\   /
//                    -I "C:\compiler\ewarm 5.5\arm\INC\" -Oh                 /
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\socket /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME socket

        EXTERN IINCHIP_READ
        EXTERN IINCHIP_WRITE
        EXTERN OSTimeDly
        EXTERN SSIZE
        EXTERN USART1Printf
        EXTERN getSn_TX_FSR
        EXTERN read_data
        EXTERN recv_data_processing
        EXTERN send_data_processing

        PUBLIC close
        PUBLIC connect
        PUBLIC disconnect
        PUBLIC dprintf
        PUBLIC igmpsend
        PUBLIC listen
        PUBLIC local_port
        PUBLIC recv
        PUBLIC recvfrom
        PUBLIC send
        PUBLIC sendto
        PUBLIC socket

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\W3150A_v1.0.6\socket.c
//    1 /*
//    2  * (c)COPYRIGHT
//    3  * ALL RIGHT RESERVED
//    4  *
//    5  * FileName : socket.c
//    6  * Last update : April. 2008
//    7  ---------------------------------------------------------------------------------------*/
//    8 #include <stm32f10x_conf.h> 
//    9 #include "types.h"
//   10 #include "w3150a.h"
//   11 #include "socket.h"
//   12 

        SECTION `.data`:DATA:NOROOT(2)
//   13 unsigned long int (*dprintf)( const char *format, ... ) = USART1Printf;
dprintf:
        DATA
        DC32 USART1Printf

        SECTION `.bss`:DATA:NOROOT(1)
//   14 uint16 local_port;
local_port:
        DS8 2
//   15 
//   16 /*
//   17 *********************************************************************
//   18 This Socket function initialize the channel in perticular mode, and set the port
//   19 and wait for W3150A+ done it.
//   20 And the Parameters "s" is for socket number, "protocol" is for socket protocol,
//   21 port is the source port for the socket and flag is the option for the socket.
//   22 This function return 1 for sucess else 0.
//   23 *********************************************************************
//   24 */
//   25 void setSHAR(uint32 nUSE, uint8 * addr);
//   26 void getSHAR(uint32 nUSE, uint8 * addr);
//   27 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 uint8 socket(uint32 nUSE, SOCKET s, uint8 protocol, uint16 port, uint8 flag)
//   29 {
socket:
        PUSH     {R4-R8,LR}
        MOV      R8,R0
        MOV      R6,R1
        MOV      R7,R2
        MOV      R5,R3
        LDR      R4,[SP, #+24]
//   30 	uint8 ret;
//   31 #ifdef __DEF_IINCHIP_DBG__
//   32 	dprintf("socket()\r\n");
//   33 #endif
//   34 	if ((protocol == Sn_MR_TCP) || (protocol == Sn_MR_UDP) || (protocol == Sn_MR_IPRAW) || (protocol == Sn_MR_MACRAW) || (protocol == Sn_MR_PPPOE))
        CMP      R7,#+1
        BEQ.N    ??socket_0
        CMP      R7,#+2
        BEQ.N    ??socket_0
        CMP      R7,#+3
        BEQ.N    ??socket_0
        CMP      R7,#+4
        BEQ.N    ??socket_0
        CMP      R7,#+5
        BNE.N    ??socket_1
//   35 	{
//   36 		close(nUSE, s);
??socket_0:
        BL       close
//   37 		IINCHIP_WRITE(nUSE, Sn_MR(nUSE, s), protocol | flag);
        LSLS     R6,R6,#+8
        ORR      R2,R4,R7
        ADD      R1,R6,#+1024
        MOV      R0,R8
        BL       IINCHIP_WRITE
        ADDW     R4,R6,#+1029
        ADDW     R1,R6,#+1028
        CBZ.N    R5,??socket_2
//   38 		if (port != 0) {
//   39 			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 0), (uint8)((port & 0xff00) >> 8));
        LSRS     R2,R5,#+8
        MOV      R0,R8
        BL       IINCHIP_WRITE
//   40 			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 1), (uint8)((port & 0x00ff) >> 0));
        UXTB     R2,R5
        B.N      ??socket_3
//   41 		} else {
//   42 			local_port++; // if don't set the source port, set local_port number.
??socket_2:
        LDR.W    R7,??DataTable3
        LDRH     R0,[R7, #+0]
        ADDS     R0,R0,#+1
        STRH     R0,[R7, #+0]
//   43 			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 0), (uint8)((local_port & 0xff00) >> 8));
        LSLS     R0,R0,#+16
        LSRS     R2,R0,#+24
        MOV      R0,R8
        BL       IINCHIP_WRITE
//   44 			IINCHIP_WRITE(nUSE, (Sn_PORT0(nUSE, s) + 1), (uint8)((local_port & 0x00ff) >> 0));
        LDRH     R2,[R7, #+0]
        UXTB     R2,R2
??socket_3:
        MOV      R1,R4
        MOV      R0,R8
        BL       IINCHIP_WRITE
        ADDW     R4,R6,#+1025
        MOVS     R2,#+1
        MOV      R1,R4
        MOV      R0,R8
//   45 		}
//   46 		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_OPEN); // run sockinit Sn_CR
        BL       IINCHIP_WRITE
//   47 		/* +200804[woong]:wait to process the command... */
//   48 		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
??socket_4:
        MOV      R1,R4
        MOV      R0,R8
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??socket_4
//   49 		/* ------- */
//   50 		ret = 1;
        MOVS     R0,#+1
        B.N      ??socket_5
//   51 	}
//   52 	else
//   53 	{
//   54 		ret = 0;
??socket_1:
        MOVS     R0,#+0
//   55 	}
//   56 #ifdef __DEF_IINCHIP_DBG__
//   57 	dprintf("Sn_SR = %.2x , Protocol = %.2x\r\n", IINCHIP_READ(nUSE, Sn_SR(nUSE, s)), IINCHIP_READ(nUSE, Sn_MR(nUSE, s)));
//   58 #endif
//   59 	return ret;
??socket_5:
        POP      {R4-R8,PC}       ;; return
//   60 }
//   61 /*
//   62 *********************************************************************
//   63 This function close the socket and parameter is "s" which represent the socket number
//   64 *********************************************************************
//   65 */
//   66 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 void close(uint32 nUSE, SOCKET s)
//   68 {
close:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
//   69 #ifdef __DEF_IINCHIP_DBG__
//   70 	dprintf("close()\r\n");
//   71 #endif
//   72 	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_CLOSE);
        LSLS     R5,R1,#+8
        ADDW     R6,R5,#+1025
        MOVS     R2,#+16
        MOV      R1,R6
        BL       IINCHIP_WRITE
//   73 
//   74 	/* +200804[woong]:wait to process the command... */
//   75 	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
??close_0:
        MOV      R1,R6
        MOV      R0,R4
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??close_0
//   76 	/* ------- */
//   77 
//   78 	/* +2008.04[woong]: clear interrupt */	
//   79 	#ifdef __DEF_IINCHIP_INT__
//   80       /* m2008.04 [woong] : all clear */
//   81 	       setISR(nUSE, s, 0x00);
//   82 	#else
//   83       /* m2008.04 [woong] : all clear */
//   84 		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), 0xFF);
        MOVS     R2,#+255
        ADDW     R1,R5,#+1026
        MOV      R0,R4
        POP      {R4-R6,LR}
        B.W      IINCHIP_WRITE
//   85 	#endif
//   86 	
//   87 }
//   88 
//   89 /*
//   90 *********************************************************************
//   91 This function established  the connection for the channel in passive (server) mode.
//   92 This function waits for the request from the peer. The parameter "s" is the socket number
//   93 This function return 1 for success else 0.
//   94 *********************************************************************
//   95 */
//   96 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   97 uint8 listen(uint32 nUSE, SOCKET s)
//   98 {
listen:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   99 	uint8 ret;
//  100 #ifdef __DEF_IINCHIP_DBG__
//  101 	dprintf("listen()\r\n");
//  102 #endif
//  103 	if (IINCHIP_READ(nUSE, Sn_SR(nUSE, s)) == SOCK_INIT)
        LSLS     R5,R1,#+8
        ADDW     R1,R5,#+1027
        BL       IINCHIP_READ
        CMP      R0,#+19
        BNE.N    ??listen_0
//  104 	{
//  105 		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_LISTEN);
        ADDW     R5,R5,#+1025
        MOVS     R2,#+2
        MOV      R1,R5
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  106 		/* +200804[woong]:wait to process the command... */
//  107 		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
??listen_1:
        MOV      R1,R5
        MOV      R0,R4
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??listen_1
//  108 		/* ------- */
//  109 		ret = 1;
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}
//  110 	}
//  111 	else
//  112 	{
//  113 		ret = 0;
??listen_0:
        MOVS     R0,#+0
//  114 #ifdef __DEF_IINCHIP_DBG__
//  115 	dprintf("Fail[invalid ip,port]\r\n");
//  116 #endif
//  117 	}
//  118 	return ret;
        POP      {R1,R4,R5,PC}    ;; return
//  119 }
//  120 
//  121 
//  122 /*
//  123 *********************************************************************
//  124 This function established  the connection for the channel in Active (client) mode. 
//  125 This function waits for the untill the connection is established. The parameter "s" is the socket number
//  126 This function return 1 for success else 0.
//  127 *********************************************************************
//  128 */
//  129 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  130 uint8 connect(uint32 nUSE, SOCKET s, uint8 * addr, uint16 port)
//  131 {
connect:
        PUSH     {R4-R8,LR}
        MOV      R8,R0
        MOV      R5,R2
        MOV      R6,R3
//  132 	uint8 ret;
//  133 #ifdef __DEF_IINCHIP_DBG__
//  134 	dprintf("connect()\r\n");
//  135 #endif
//  136 	if 
//  137 		(
//  138 			((addr[0] == 0xFF) && (addr[1] == 0xFF) && (addr[2] == 0xFF) && (addr[3] == 0xFF)) ||
//  139 		 	((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) && (addr[3] == 0x00)) ||
//  140 		 	(port == 0x00) 
//  141 		) 
        LDRB     R2,[R5, #+0]
        CMP      R2,#+255
        BNE.N    ??connect_0
        LDRB     R0,[R5, #+1]
        CMP      R0,#+255
        BNE.N    ??connect_1
        LDRB     R0,[R5, #+2]
        CMP      R0,#+255
        BNE.N    ??connect_1
        LDRB     R0,[R5, #+3]
        CMP      R0,#+255
        BNE.N    ??connect_1
        B.N      ??connect_2
??connect_0:
        CBNZ.N   R2,??connect_1
        LDRB     R0,[R5, #+1]
        CBNZ.N   R0,??connect_1
        LDRB     R0,[R5, #+2]
        CBNZ.N   R0,??connect_1
        LDRB     R0,[R5, #+3]
        CBZ.N    R0,??connect_2
??connect_1:
        CBNZ.N   R6,??connect_3
//  142  	{
//  143  		ret = 0;
??connect_2:
        MOVS     R7,#+0
        B.N      ??connect_4
//  144 #ifdef __DEF_IINCHIP_DBG__
//  145 	dprintf("Fail[invalid ip,port]\r\n");
//  146 #endif
//  147 	}
//  148 	else
//  149 	{
//  150 
//  151 		ret = 1;
??connect_3:
        MOVS     R7,#+1
//  152 		// set destination IP
//  153 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 0), addr[0]);
        LSLS     R4,R1,#+8
        ADDW     R1,R4,#+1036
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  154 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 1), addr[1]);
        LDRB     R2,[R5, #+1]
        ADDW     R1,R4,#+1037
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  155 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 2), addr[2]);
        LDRB     R2,[R5, #+2]
        ADDW     R1,R4,#+1038
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  156 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 3), addr[3]);
        LDRB     R2,[R5, #+3]
        ADDW     R1,R4,#+1039
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  157 		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 0),(uint8)((port & 0xff00) >> 8));
        LSRS     R2,R6,#+8
        ADD      R1,R4,#+1040
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  158 		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 1),(uint8)((port & 0x00ff) >> 0));
        UXTB     R2,R6
        ADDW     R1,R4,#+1041
        MOV      R0,R8
        BL       IINCHIP_WRITE
        ADDW     R5,R4,#+1025
        MOVS     R2,#+4
        MOV      R1,R5
        MOV      R0,R8
//  159 		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_CONNECT);
        BL       IINCHIP_WRITE
        ADDW     R6,R4,#+1027
        B.N      ??connect_5
//  160 		// wait for completion
//  161 		while (IINCHIP_READ(nUSE, Sn_CR(nUSE, s)))
//  162 		{
//  163 			if (IINCHIP_READ(nUSE, Sn_SR(nUSE, s)) == SOCK_CLOSED)
??connect_6:
        MOV      R1,R6
        MOV      R0,R8
        BL       IINCHIP_READ
        CMP      R0,#+0
        BEQ.N    ??connect_2
//  164 			{
//  165 #ifdef __DEF_IINCHIP_DBG__
//  166 			dprintf("SOCK_CLOSED.\r\n");
//  167 #endif
//  168 				ret = 0; break;
//  169 			}
//  170 		}
??connect_5:
        MOV      R1,R5
        MOV      R0,R8
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??connect_6
//  171 	}
//  172 
//  173 	return ret;
??connect_4:
        MOV      R0,R7
        POP      {R4-R8,PC}       ;; return
//  174 }
//  175 
//  176 
//  177 /*
//  178 *********************************************************************
//  179 This function used for disconnect the socket and parameter is "s" which represent the socket number
//  180 *********************************************************************
//  181 */
//  182 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  183 void disconnect(uint32 nUSE, SOCKET s)
//  184 {
disconnect:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//  185 #ifdef __DEF_IINCHIP_DBG__
//  186 	dprintf("disconnect()\r\n");
//  187 #endif
//  188 	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_DISCON);
        LSLS     R0,R1,#+8
        ADDW     R5,R0,#+1025
        MOVS     R2,#+8
        MOV      R1,R5
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  189 	/* +200804[woong]:wait to process the command... */
//  190 	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
??disconnect_0:
        MOV      R1,R5
        MOV      R0,R4
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??disconnect_0
//  191 	/* ------- */
//  192 }
        POP      {R0,R4,R5,PC}    ;; return
//  193 
//  194 /*
//  195 *********************************************************************
//  196 This function used to send the data in TCP mode and the parameter "s" represents
//  197 the socket number and "buf" a pointer to data and "len" is the data size to be send.
//  198 This function return 1 for success else 0.
//  199 *********************************************************************
//  200 */
//  201 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  202 uint16 send(uint32 nUSE, SOCKET s, const uint8 * buf, uint16 len)
//  203 {
send:
        PUSH     {R3-R11,LR}
        MOV      R4,R0
        MOV      R8,R1
        MOV      R9,R2
        MOV      R7,R8
        LDR.W    R0,??DataTable3_1
        ADD      R0,R0,R4, LSL #+3
        LDRH     R5,[R0, R7, LSL #+1]
        CMP      R5,R3
        IT       CS 
        MOVCS    R5,R3
//  204 	uint8 status=0;
//  205 	uint16 ret=0;
//  206 	uint16 freesize=0;
//  207 #ifdef __DEF_IINCHIP_DBG__
//  208 	dprintf("send()\r\n");
//  209 #endif
//  210 
//  211 	if (len > getIINCHIP_TxMAX(nUSE, s)) ret = getIINCHIP_TxMAX(nUSE, s); // check size not to exceed MAX size.
//  212 	else ret = len;
//  213 
//  214 	// if freebuf is available, start.
//  215 	do 
//  216 	{
//  217 		freesize = getSn_TX_FSR(nUSE, s);
??send_0:
        MOV      R1,R8
        MOV      R0,R4
        BL       getSn_TX_FSR
        MOV      R11,R0
//  218 		status = IINCHIP_READ(nUSE, Sn_SR(nUSE, s));
        LSLS     R6,R7,#+8
        ADDW     R10,R6,#+1027
        MOV      R1,R10
        MOV      R0,R4
        BL       IINCHIP_READ
//  219 		if ((status != SOCK_ESTABLISHED) && (status != SOCK_CLOSE_WAIT)) {ret = 0; break;}
        CMP      R0,#+23
        BEQ.N    ??send_1
        CMP      R0,#+28
        IT       NE 
        MOVNE    R5,#+0
        BNE.N    ??send_2
//  220 #ifdef __DEF_IINCHIP_DBG__
//  221 		dprintf("socket %d freesize(%d) empty or error\r\n", s, freesize);
//  222 #endif
//  223 	} while (freesize < ret);
??send_1:
        CMP      R11,R5
        BCC.N    ??send_0
//  224 
//  225 	// copy data
//  226 	send_data_processing(nUSE, s, (uint8 *)buf, ret);
??send_2:
        MOV      R3,R5
        MOV      R2,R9
        MOV      R1,R8
        MOV      R0,R4
        BL       send_data_processing
        ADDW     R9,R6,#+1025
        MOVS     R2,#+32
        MOV      R1,R9
        MOV      R0,R4
//  227 	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_SEND);
        BL       IINCHIP_WRITE
//  228 	/* +200804[woong]:wait to process the command... */
//  229 	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
??send_3:
        MOV      R1,R9
        MOV      R0,R4
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??send_3
??send_4:
        ADDW     R9,R6,#+1026
        MOV      R1,R9
        MOV      R0,R4
//  230 	/* ------- */
//  231 
//  232 /* +2008.04 [woong] */	
//  233 #ifdef __DEF_IINCHIP_INT__
//  234 	while ( (getISR(s) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
//  235 #else
//  236 	while ( (IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
        BL       IINCHIP_READ
        LSLS     R0,R0,#+27
        BMI.N    ??send_5
//  237 #endif
//  238 	{
//  239 		/* m2008.04 [woong] : reduce code */
//  240 		if ( IINCHIP_READ(nUSE, Sn_SR(nUSE, s)) == SOCK_CLOSED )
        MOV      R1,R10
        MOV      R0,R4
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??send_4
//  241 		{
//  242 #ifdef __DEF_IINCHIP_DBG__
//  243 			dprintf("SOCK_CLOSED.\r\n");
//  244 #endif
//  245 			close(nUSE, s);
        MOV      R1,R8
        MOV      R0,R4
        BL       close
//  246 			return 0;
        MOVS     R0,#+0
        B.N      ??send_6
//  247 		}
//  248   	}
//  249 /* +2008.04 [woong] */	
//  250 #ifdef __DEF_IINCHIP_INT__
//  251   	setISR(nUSE, s, getISR(nUSE, s) & (~Sn_IR_SEND_OK));
//  252 #else
//  253 	IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_SEND_OK);
??send_5:
        MOVS     R2,#+16
        MOV      R1,R9
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  254 #endif
//  255   	return ret;
        MOV      R0,R5
??send_6:
        POP      {R1,R4-R11,PC}   ;; return
//  256 }
//  257 
//  258 
//  259 /*
//  260 *********************************************************************
//  261 This function is an application I/F function which is used to receive the data in TCP mode.
//  262 It continues to wait for data as much as the application wants to receive and the 
//  263 parameter "s" represents the socket number and "buf" a pointer to copy the data
//  264 to be received and "len" is the data size to be read. This function return received data size
//  265 for success else -1.
//  266 *********************************************************************
//  267 */
//  268 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  269 uint16 recv(uint32 nUSE, SOCKET s, uint8 * buf, uint16 len)
//  270 {
recv:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R3
//  271 	uint16 ret=0;
        MOVS     R0,#+0
//  272 #ifdef __DEF_IINCHIP_DBG__
//  273 	dprintf("recv()\r\n");
//  274 #endif
//  275 
//  276 
//  277 	if ( len > 0 )
        CBZ.N    R6,??recv_0
//  278 	{
//  279 		recv_data_processing(nUSE, s, buf, len);
        MOV      R0,R4
        BL       recv_data_processing
//  280 		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_RECV);
        LSLS     R0,R5,#+8
        ADDW     R5,R0,#+1025
        MOVS     R2,#+64
        MOV      R1,R5
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  281 		/* +200804[woong]:wait to process the command... */
//  282 		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
??recv_1:
        MOV      R1,R5
        MOV      R0,R4
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??recv_1
//  283 		/* ------- */
//  284 		ret = len;
        MOV      R0,R6
//  285 	}
//  286 	return ret;
??recv_0:
        POP      {R4-R6,PC}       ;; return
//  287 }
//  288 
//  289 /*
//  290 *********************************************************************
//  291 This function is an application I/F function which is used to send the data for other then
//  292 TCP mode. Unlike TCP transmission, The peer's destination address and the port is needed.
//  293 and the parameter "s" represents the socket number and "buf" a pointer to the data 
//  294 and "len" is the data size to send and addr is the peer's Destination IP address and port is
//  295 the peer's destination port number. This function return send data size for success else -1.
//  296 *********************************************************************
//  297 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  298 uint16 sendto(uint32 nUSE, SOCKET s, const uint8 * buf, uint16 len, uint8 * addr, uint16 port)
//  299 {
sendto:
        PUSH     {R4-R10,LR}
        MOV      R8,R0
        MOV      R9,R1
        MOV      R10,R2
        MOV      R6,R3
        LDR      R5,[SP, #+32]
        LDR      R4,[SP, #+36]
        LDR.N    R0,??DataTable3_1
        ADD      R0,R0,R8, LSL #+3
        LDRH     R0,[R0, R1, LSL #+1]
        CMP      R0,R6
        IT       CC 
        MOVCC    R6,R0
//  300 	uint16 ret = 0;
//  301 	
//  302 #ifdef __DEF_IINCHIP_DBG__
//  303 	dprintf("sendto()\r\n");
//  304 #endif
//  305    if (len > getIINCHIP_TxMAX(nUSE, s)) ret = getIINCHIP_TxMAX(nUSE, s); // check size not to exceed MAX size.
//  306    else ret = len;
//  307 
//  308 	if
//  309 		(
//  310 		 	((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) && (addr[3] == 0x00)) ||
//  311 		 	((port == 0x00)) ||(ret == 0)
//  312 		) 
        LDRB     R2,[R5, #+0]
        CBNZ.N   R2,??sendto_0
        LDRB     R0,[R5, #+1]
        CBNZ.N   R0,??sendto_0
        LDRB     R0,[R5, #+2]
        CBNZ.N   R0,??sendto_0
        LDRB     R0,[R5, #+3]
        CBZ.N    R0,??sendto_1
??sendto_0:
        UXTH     R4,R4
        CBZ.N    R4,??sendto_1
        CBNZ.N   R6,??sendto_2
//  313  	{
//  314  	  /* +2008.04 [woong] : added return value */
//  315  	  ret = 0; 
??sendto_1:
        MOVS     R6,#+0
        B.N      ??sendto_3
//  316 #ifdef __DEF_IINCHIP_DBG__
//  317 	dprintf("%d Fail[%.2x.%.2x.%.2x.%.2x, %.d, %d]\r\n",s, addr[0], addr[1], addr[2], addr[3] , port, len);
//  318 	dprintf("Fail[invalid ip,port]\r\n");
//  319 #endif
//  320 	}
//  321 	else
//  322 	{
//  323 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s)    ),addr[0]);
??sendto_2:
        LSLS     R7,R1,#+8
        ADDW     R1,R7,#+1036
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  324 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        ADDW     R1,R7,#+1037
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  325 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 2),addr[2]);
        LDRB     R2,[R5, #+2]
        ADDW     R1,R7,#+1038
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  326 		IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 3),addr[3]);
        LDRB     R2,[R5, #+3]
        ADDW     R1,R7,#+1039
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  327 		
//  328 		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s)    ),(uint8)((port & 0xff00) >> 8));
        LSRS     R2,R4,#+8
        ADD      R1,R7,#+1040
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  329 		IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 1),(uint8)((port & 0x00ff) >> 0));
        UXTB     R2,R4
        ADDW     R1,R7,#+1041
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  330 
//  331 		// copy data
//  332 		send_data_processing(nUSE, s, (uint8 *)buf, ret);
        MOV      R3,R6
        MOV      R2,R10
        MOV      R1,R9
        MOV      R0,R8
        BL       send_data_processing
        ADDW     R4,R7,#+1025
        MOVS     R2,#+32
        MOV      R1,R4
        MOV      R0,R8
//  333 		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_SEND);
        BL       IINCHIP_WRITE
//  334 		/* +200804[woong]:wait to process the command... */
//  335 		while(IINCHIP_READ(nUSE, Sn_CR(nUSE, s)));
??sendto_4:
        MOV      R1,R4
        MOV      R0,R8
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??sendto_4
//  336 		/* ------- */
//  337 		//USART1Printf("IINCHIP_READ(Sn_CR(s)) == %x \n", IINCHIP_READ(Sn_CR(s)));
//  338 		
//  339 /* +2008.04 [woong] */	
//  340 #ifdef __DEF_IINCHIP_INT__
//  341    		while ( (getISR(s) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
//  342 #else
//  343 		{
//  344 			uint32 cnt = 10;
        MOVS     R4,#+10
        ADDW     R9,R7,#+1026
        B.N      ??sendto_5
//  345 			while  ( (IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ){
//  346 				if(cnt-- == 0) break;
??sendto_6:
        SUBS     R4,R4,#+1
//  347 				OSTimeDly(10);
        MOVS     R0,#+10
        BL       OSTimeDly
??sendto_5:
        MOV      R1,R9
        MOV      R0,R8
        BL       IINCHIP_READ
        LSLS     R0,R0,#+27
        BMI.N    ??sendto_7
        CMP      R4,#+0
        BNE.N    ??sendto_6
//  348 			}
//  349 		}
//  350 #endif
//  351 		{
//  352 #ifdef __DEF_IINCHIP_INT__
//  353       		if(getISR(s) & Sn_IR_TIMEOUT)
//  354 #else
//  355 			if(IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_TIMEOUT)
??sendto_7:
        MOV      R1,R9
        MOV      R0,R8
        BL       IINCHIP_READ
        LSLS     R0,R0,#+28
        BPL.N    ??sendto_8
//  356 #endif
//  357 			{
//  358 	dprintf("send fail. %x\r\n", IINCHIP_READ(nUSE, Sn_IR(nUSE, s)));
        MOV      R1,R9
        MOV      R0,R8
        BL       IINCHIP_READ
        MOV      R1,R0
        LDR.N    R0,??DataTable3_2
        LDR.N    R2,??DataTable3_3
        LDR      R2,[R2, #+0]
        BLX      R2
//  359 
//  360 #ifdef __DEF_IINCHIP_DBG__
//  361 				dprintf("send fail.\r\n");
//  362 #endif
//  363 /* +2008.04 [woong]: clear interrupt */
//  364 #ifdef __DEF_IINCHIP_INT__
//  365          		setISR(nUSE, s, getISR(nUSE, s) & ~(Sn_IR_SEND_OK | Sn_IR_TIMEOUT));  /* clear SEND_OK & TIMEOUT */
//  366 #else
//  367          		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), (Sn_IR_SEND_OK | Sn_IR_TIMEOUT)); /* clear SEND_OK & TIMEOUT */
        MOVS     R2,#+24
        MOV      R1,R9
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  368 
//  369 #endif
//  370 				return 0;
        MOVS     R0,#+0
        B.N      ??sendto_9
//  371 			}
//  372 		}
//  373 
//  374 /* +2008.04 [woong] */	
//  375 #ifdef __DEF_IINCHIP_INT__
//  376      	setISR(nUSE, s, getISR(nUSE, s) & (~Sn_IR_SEND_OK));
//  377 #else
//  378 		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_SEND_OK);
??sendto_8:
        MOVS     R2,#+16
        MOV      R1,R9
        MOV      R0,R8
        BL       IINCHIP_WRITE
//  379 #endif
//  380 
//  381 	}
//  382 	return ret;
??sendto_3:
        MOV      R0,R6
??sendto_9:
        POP      {R4-R10,PC}      ;; return
//  383 }
//  384 
//  385 
//  386 /*
//  387 *********************************************************************
//  388 This function is an application I/F function which is used to receive the data in other then
//  389 TCP mode. This function is used to receive UDP, IP_RAW and MAC_RAW mode, and handle 
//  390 the header as well. 
//  391 The parameter "s" represents the socket number and "buf" a pointer to copy the data to be 
//  392 received and "len" is the data size to read and and addr is a pointer to store the peer's 
//  393 IP address and port is a pointer to store the peer's port number.
//  394 This function return received data size for success else -1.
//  395 *********************************************************************
//  396 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  397 uint16 recvfrom(uint32 nUSE, SOCKET s, uint8 *buf, uint16 len, uint8 *addr, uint16 *port)
//  398 {
recvfrom:
        PUSH     {R2,R4-R11,LR}
        SUB      SP,SP,#+16
        MOV      R10,R0
        MOV      R6,R1
        LDR      R7,[SP, #+56]
//  399 	uint8 head[8];
//  400 	uint16 data_len=0;
        MOVS     R4,#+0
//  401 	uint16 ptr = 0;
//  402 #ifdef __DEF_IINCHIP_DBG__
//  403 	dprintf("recvfrom()\r\n");
//  404 #endif
//  405 
//  406 	if(len > 0)
        CMP      R3,#+0
        BEQ.W    ??recvfrom_0
//  407 	{
//  408 		ptr = IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s));
        LSL      R11,R6,#+8
        ADD      R8,R11,#+1064
        MOV      R1,R8
        BL       IINCHIP_READ
        MOV      R5,R0
        ADDW     R9,R11,#+1065
        MOV      R1,R9
        MOV      R0,R10
//  409 		ptr = ((ptr & 0x00ff) << 8) + IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s) + 1);
        BL       IINCHIP_READ
        ADD      R0,R0,R5, LSL #+8
        UXTH     R5,R0
//  410 #ifdef __DEF_IINCHIP_DBG__
//  411 		dprintf("ISR_RX: rd_ptr : %.4x\r\n", ptr);
//  412 #endif
//  413 		switch (IINCHIP_READ(nUSE, Sn_MR(nUSE, s)) & 0x07)
        ADD      R1,R11,#+1024
        MOV      R0,R10
        BL       IINCHIP_READ
        AND      R0,R0,#0x7
        CMP      R0,#+2
        BEQ.N    ??recvfrom_1
        CMP      R0,#+3
        BEQ.N    ??recvfrom_2
        CMP      R0,#+4
        BEQ.N    ??recvfrom_3
        B.N      ??recvfrom_4
//  414 		{
//  415 			case Sn_MR_UDP :
//  416 				read_data(nUSE, s, (uint8 *)ptr, head, 0x08);
??recvfrom_1:
        MOVS     R0,#+8
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,R5
        MOV      R1,R6
        MOV      R0,R10
        BL       read_data
//  417 				ptr += 8;
        ADD      R0,R5,#+8
        UXTH     R5,R0
//  418 				// read peer's IP address, port number.
//  419 				addr[0] = head[0];
        LDRB     R0,[SP, #+4]
        STRB     R0,[R7, #+0]
//  420 				addr[1] = head[1];
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        STRB     R1,[R7, #+1]
//  421 				addr[2] = head[2];
        LDRB     R1,[R0, #+2]
        STRB     R1,[R7, #+2]
//  422 				addr[3] = head[3];
        LDRB     R1,[R0, #+3]
        STRB     R1,[R7, #+3]
//  423 				*port = head[4];
        LDRB     R1,[R0, #+4]
        LDR      R2,[SP, #+60]
        STRH     R1,[R2, #+0]
//  424 				*port = (*port << 8) + head[5];
        LDRB     R2,[R0, #+5]
        ADD      R1,R2,R1, LSL #+8
        LDR      R2,[SP, #+60]
        STRH     R1,[R2, #+0]
//  425 				data_len = head[6];
//  426 				data_len = (data_len << 8) + head[7];
        LDRB     R1,[R0, #+6]
        LDRB     R0,[R0, #+7]
??recvfrom_5:
        ADD      R0,R0,R1, LSL #+8
        UXTH     R4,R0
//  427 				
//  428 #ifdef __DEF_IINCHIP_DBG__
//  429 				dprintf("UDP msg arrived\r\n");
//  430 				dprintf("source Port : %d\r\n", *port);
//  431 				dprintf("source IP : %d.%d.%d.%d\r\n", addr[0], addr[1], addr[2], addr[3]);
//  432 #endif
//  433 
//  434 				read_data(nUSE, s, (uint8 *)ptr, buf, data_len); // data copy.
        STR      R4,[SP, #+0]
        LDR      R3,[SP, #+16]
        MOV      R2,R5
        MOV      R1,R6
        MOV      R0,R10
        BL       read_data
//  435 				ptr += data_len;
        ADDS     R5,R4,R5
        UXTH     R6,R5
//  436 
//  437 	        	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s)    ),(uint8)((ptr & 0xff00) >> 8));
        B.N      ??recvfrom_6
//  438 	        	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1),(uint8)((ptr & 0x00ff)     ));
//  439 			break;
//  440 
//  441 			case Sn_MR_IPRAW :
//  442 				read_data(nUSE, s, (uint8 *)ptr, head, 0x06);
??recvfrom_2:
        MOVS     R0,#+6
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,R5
        MOV      R1,R6
        MOV      R0,R10
        BL       read_data
//  443 				ptr += 6;
        ADDS     R0,R5,#+6
        UXTH     R5,R0
//  444 
//  445 				addr[0] = head[0];
        LDRB     R0,[SP, #+4]
        STRB     R0,[R7, #+0]
//  446 				addr[1] = head[1];
        ADD      R0,SP,#+4
        LDRB     R1,[R0, #+1]
        STRB     R1,[R7, #+1]
//  447 				addr[2] = head[2];
        LDRB     R1,[R0, #+2]
        STRB     R1,[R7, #+2]
//  448 				addr[3] = head[3];
        LDRB     R1,[R0, #+3]
        STRB     R1,[R7, #+3]
//  449 				data_len = head[4];
//  450 				data_len = (data_len << 8) + head[5];
        LDRB     R1,[R0, #+4]
        LDRB     R0,[R0, #+5]
        B.N      ??recvfrom_5
//  451 		
//  452 #ifdef __DEF_IINCHIP_DBG__
//  453 				dprintf("IP RAW msg arrived\r\n");
//  454 				dprintf("source IP : %d.%d.%d.%d\r\n", addr[0], addr[1], addr[2], addr[3]);
//  455 #endif
//  456 				read_data(nUSE, s, (uint8 *)ptr, buf, data_len); // data copy.
//  457 				ptr += data_len;
//  458 
//  459 		        IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 0), (uint8)((ptr & 0xff00) >> 8));
//  460 	            IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1), (uint8)(ptr & 0x00ff));
//  461 			break;
//  462 
//  463 			case Sn_MR_MACRAW :
//  464 				read_data(nUSE, s, (uint8*)ptr, head, 2);
??recvfrom_3:
        MOVS     R0,#+2
        STR      R0,[SP, #+0]
        ADD      R3,SP,#+4
        MOV      R2,R5
        MOV      R1,R6
        MOV      R0,R10
        BL       read_data
//  465 				ptr+=2;
        ADDS     R7,R5,#+2
        UXTH     R7,R7
//  466 				data_len = head[0];
//  467 				data_len = (data_len<<8) + head[1] - 2;
        LDRB     R0,[SP, #+4]
        LDRB     R1,[SP, #+5]
        ADD      R0,R1,R0, LSL #+8
        SUBS     R0,R0,#+2
        UXTH     R4,R0
//  468 
//  469 				read_data(nUSE, s, (uint8*)ptr, buf, data_len);
        STR      R4,[SP, #+0]
        LDR      R3,[SP, #+16]
        MOV      R2,R7
        MOV      R1,R6
        MOV      R0,R10
        BL       read_data
//  470 				ptr += data_len;
        ADDS     R0,R4,R7
        UXTH     R6,R0
//  471 				IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 0), (uint8)((ptr & 0xff00) >> 8));
??recvfrom_6:
        ASRS     R2,R6,#+8
        UXTB     R2,R2
        MOV      R1,R8
        MOV      R0,R10
        BL       IINCHIP_WRITE
//  472 				IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1), (uint8)(ptr & 0x00ff));
        UXTB     R2,R6
        MOV      R1,R9
        MOV      R0,R10
        BL       IINCHIP_WRITE
??recvfrom_4:
        ADDW     R11,R11,#+1025
        MOVS     R2,#+64
        MOV      R1,R11
        MOV      R0,R10
//  473 				
//  474 #ifdef __DEF_IINCHIP_DGB__
//  475 			dprintf("MAC RAW msg arrived\r\n");
//  476 			dprintf("dest mac=%.2X.%.2X.%.2X.%.2X.%.2X.%.2X\r\n",buf[0],buf[1],buf[2],buf[3],buf[4],buf[5]);
//  477 			dprintf("src  mac=%.2X.%.2X.%.2X.%.2X.%.2X.%.2X\r\n",buf[6],buf[7],buf[8],buf[9],buf[10],buf[11]);
//  478 			dprintf("type    =%.2X%.2X\r\n",buf[12],buf[13]); 
//  479 #endif			
//  480 			break;
//  481 
//  482 			default:
//  483 			break;
//  484 		}
//  485 		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s), Sn_CR_RECV);
        BL       IINCHIP_WRITE
//  486 		/* +200804[woong]:wait to process the command... */
//  487 		while(IINCHIP_READ(nUSE, Sn_CR(nUSE, s)));
??recvfrom_7:
        MOV      R1,R11
        MOV      R0,R10
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??recvfrom_7
//  488 		/* ------- */
//  489 	}
//  490 #ifdef __DEF_IINCHIP_DBG__
//  491 	dprintf("recvfrom() end ..\r\n");
//  492 #endif
//  493  	return data_len;
??recvfrom_0:
        MOV      R0,R4
        ADD      SP,SP,#+20
        POP      {R4-R11,PC}      ;; return
//  494 }
//  495 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  496 uint16 igmpsend(uint32 nUSE, SOCKET s, const uint8 *buf, uint16 len)
//  497 {
igmpsend:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R3
        MOV      R7,R5
        LDR.N    R0,??DataTable3_1
        ADD      R0,R0,R4, LSL #+3
        LDRH     R0,[R0, R7, LSL #+1]
        CMP      R0,R6
        IT       CC 
        MOVCC    R6,R0
//  498 	uint8 status = 0;
//  499 	uint16 ret = 0;
//  500 	status = status;
//  501 #ifdef __DEF_IINCHIP_DBG__
//  502 	dprintf("igmpsend()\r\n");
//  503 #endif
//  504 	if (len > getIINCHIP_TxMAX(nUSE, s)) ret = getIINCHIP_TxMAX(nUSE, s); // check size not to exceed MAX size.
//  505 	else ret = len;
//  506 
//  507 	if(ret == 0) 
        CBZ.N    R6,??igmpsend_0
//  508  	{
//  509 		#ifdef __DEF_IINCHIP_DBG__
//  510 			dprintf("%d Fail[%d]\r\n",len);
//  511 		#endif
//  512 	}
//  513 	else
//  514 	{
//  515 		// copy data
//  516 		send_data_processing(nUSE, s, (uint8 *)buf, ret);
        MOV      R3,R6
        MOV      R0,R4
        BL       send_data_processing
//  517 		IINCHIP_WRITE(nUSE, Sn_CR(nUSE, s),Sn_CR_SEND);
        LSLS     R7,R7,#+8
        ADDW     R8,R7,#+1025
        MOVS     R2,#+32
        MOV      R1,R8
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  518 		/* +200804[woong]:wait to process the command... */
//  519 		while( IINCHIP_READ(nUSE, Sn_CR(nUSE, s)) );
??igmpsend_1:
        MOV      R1,R8
        MOV      R0,R4
        BL       IINCHIP_READ
        CMP      R0,#+0
        BNE.N    ??igmpsend_1
??igmpsend_2:
        ADDW     R8,R7,#+1026
        MOV      R1,R8
        MOV      R0,R4
//  520 		/* ------- */
//  521 
//  522 		#ifdef __DEF_IINCHIP_INT__
//  523    			while ( (getISR(s) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
//  524 		#else
//  525 	   		while ( (IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_SEND_OK) != Sn_IR_SEND_OK ) 
        BL       IINCHIP_READ
        LSLS     R0,R0,#+27
        BMI.N    ??igmpsend_3
//  526 		#endif
//  527 		{
//  528 			status = IINCHIP_READ(nUSE, Sn_SR(nUSE, s));
        ADDW     R1,R7,#+1027
        MOV      R0,R4
        BL       IINCHIP_READ
//  529 			
//  530 			#ifdef __DEF_IINCHIP_INT__
//  531       			if(getISR(nUSE, s) & Sn_IR_TIMEOUT)
//  532 			#else
//  533 	     		if(IINCHIP_READ(nUSE, Sn_IR(nUSE, s)) & Sn_IR_TIMEOUT)
        MOV      R1,R8
        MOV      R0,R4
        BL       IINCHIP_READ
        LSLS     R0,R0,#+28
        BPL.N    ??igmpsend_2
//  534 			#endif
//  535 			{
//  536 				#ifdef __DEF_IINCHIP_DBG__
//  537 					dprintf("igmpsend fail.\r\n");
//  538 				#endif
//  539 			   /* in case of igmp, if send fails, then socket closed */
//  540 			   /* if you want change, remove this code. */
//  541 			   close(nUSE, s);
        MOV      R1,R5
        MOV      R0,R4
        BL       close
//  542 			   /* ----- */
//  543 			   
//  544 				return 0;
        MOVS     R0,#+0
        B.N      ??igmpsend_4
//  545 			}
//  546 		}
//  547 		/* +2008.04 [woong] */	
//  548 		#ifdef __DEF_IINCHIP_INT__
//  549      		setISR(nUSE, s, getISR(nUSE, s) & (~Sn_IR_SEND_OK));
//  550 		#else
//  551 	   		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, s), Sn_IR_SEND_OK);
??igmpsend_3:
        MOVS     R2,#+16
        MOV      R1,R8
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  552 		#endif
//  553    }
//  554 	return ret;
??igmpsend_0:
        MOV      R0,R6
??igmpsend_4:
        POP      {R4-R8,PC}       ;; return
//  555 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     local_port

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3_1:
        DC32     SSIZE

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3_2:
        DC32     `?<Constant "send fail. %x\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3_3:
        DC32     dprintf

        SECTION `.rodata`:CONST:NOROOT(2)
`?<Constant "send fail. %x\\r\\n">`:
        DATA
        DC8 "send fail. %x\015\012"

        END
//  556 
// 
//     2 bytes in section .bss
//     4 bytes in section .data
//    16 bytes in section .rodata
// 1 404 bytes in section .text
// 
// 1 404 bytes of CODE  memory
//    16 bytes of CONST memory
//     6 bytes of DATA  memory
//
//Errors: none
//Warnings: none
