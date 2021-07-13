///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    11/Aug/2012  17:25:25 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\W3150A_ /
//                    v1.0.6\w3150a.c                                         /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\W3150A_ /
//                    v1.0.6\w3150a.c -lcN C:\user\project\FR-SSR\fw\appl_ssr /
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
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\w3150a /
//                    .s                                                      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME w3150a

        EXTERN OSTimeDly
        EXTERN SPI1Init
        EXTERN SPI2Init
        EXTERN SPI_I2S_GetFlagStatus
        EXTERN SPI_I2S_ReceiveData
        EXTERN SPI_I2S_SendData

        PUBLIC IINCHIP_READ
        PUBLIC IINCHIP_SpiSendData
        PUBLIC IINCHIP_WRITE
        PUBLIC ISR
        PUBLIC I_STATUS
        PUBLIC RBUFBASEADDRESS
        PUBLIC RMASK
        PUBLIC RSIZE
        PUBLIC SBUFBASEADDRESS
        PUBLIC SMASK
        PUBLIC SPI_BASE
        PUBLIC SSIZE
        PUBLIC getGAR
        PUBLIC getGWIP
        PUBLIC getSHAR
        PUBLIC getSIPR
        PUBLIC getSUBR
        PUBLIC getSn_DHAR
        PUBLIC getSn_DIPR
        PUBLIC getSn_DPORT
        PUBLIC getSn_RX_RSR
        PUBLIC getSn_TX_FSR
        PUBLIC iinchip_init
        PUBLIC read_data
        PUBLIC recv_data_processing
        PUBLIC send_data_processing
        PUBLIC setGAR
        PUBLIC setMR
        PUBLIC setRTR
        PUBLIC setSHAR
        PUBLIC setSIPR
        PUBLIC setSUBR
        PUBLIC setSn_DHAR
        PUBLIC setSn_DIPR
        PUBLIC setSn_DPORT
        PUBLIC setSn_MSS
        PUBLIC sysinit
        PUBLIC w3150ainit
        PUBLIC wiz_read_buf
        PUBLIC wiz_write_buf
        PUBLIC write_data

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\W3150A_v1.0.6\w3150a.c
//    1 /*
//    2  * (c)COPYRIGHT
//    3  * ALL RIGHT RESERVED
//    4  *
//    5  * FileName : w3150a.c
//    6  * Revision History :
//    7  * ----------  -------  -----------  ------------------------------------------------
//    8  * Date        version  Name         Description
//    9  * ----------  -------  -----------  ------------------------------------------------
//   10  * 08/28/2006  1.0.1    Bong       support W3150A+
//   11  * ----------  -------  -----------  ------------------------------------------------
//   12  * 11/10/2006  1.0.2    Jung        modify  iinchip_write/read function, 
//   13  *                                           	wiz_write/read_buffer function
//   14  *                                           	related spi mode I/F          
//   15  * ----------------------------------------------------------------------------------
//   16  * 11/20/2006  1.0.3    Jung        modification  iinchip_irq()
//   17  * ----------------------------------------------------------------------------------
//   18  * 12/27/2006  1.0.4    Hyung      Optimization (use macro function)
//   19  *								modify  	iinchip_write/read function,
//   20  *										 wiz_write/read_buffer function
//   21  *										 iinchip_irq function
//   22  * ----------------------------------------------------------------------------------
//   23  * 08/28/2006  1.0.5    Hyung      Bug fix( fixed "setMR" macro function relate with Indirect 
//   24  * ----------------------------------------------------------------------------------
//   25  * 04/02/2008  1.0.6    Woong     Modification of Socket Command Part
//   26  *								: Check if the appropriately performed after writing Sn_CR	
//   27  *							Modification of SPI Part
//   28  *								: SPI code changed by adding 'spi.h'.
//   29  *								: Change control type for SPI port from byte to bit.
//   30  *							Bug is Fixed in the pppinit() fuction.
//   31  *								: do not clear interrupt value, so fixed.
//   32  *		                   			Modification of ISR
//   33  *                   					: Do not exit ISR, if there is interrupt.
//   34  *							Modification of SetMR() function
//   35  *                   					: Use IINCHIP_WRITE() function in Direct or SPI mode.
//   36  * ------------------------------------------------------------------------------------------------*/
//   37 #include <stm32f10x_conf.h>
//   38 #include "w3150a.h"
//   39 #ifdef __DEF_IINCHIP_PPP__
//   40    #include "md5.h"
//   41 #endif
//   42 #if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_SPI_MODE__)
//   43 	#include "spi.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// __??Code16?? __code __interwork struct <unnamed> *SPI_BASE(uint32)
SPI_BASE:
        CBNZ.N   R0,??SPI_BASE_0
        LDR.W    R1,??DataTable7  ;; 0x40003800
        B.N      ??SPI_BASE_1
??SPI_BASE_0:
        CMP      R0,#+1
        IT       EQ 
        LDREQ.W  R1,??DataTable7_1  ;; 0x40013000
??SPI_BASE_1:
        MOV      R0,R1
        BX       LR               ;; return
//   44 #endif
//   45 

        SECTION `.bss`:DATA:NOROOT(2)
//   46 uint8 I_STATUS[_EthNo][MAX_SOCK_NUM];
I_STATUS:
        DS8 8

        SECTION `.bss`:DATA:NOROOT(2)
//   47 uint32 SMASK[_EthNo][MAX_SOCK_NUM];					/* Variable for Tx buffer MASK in each channel */
//   48 uint32 RMASK[_EthNo][MAX_SOCK_NUM];					/* Variable for Rx buffer MASK in each channel */
//   49 uint16 SSIZE[_EthNo][MAX_SOCK_NUM];					/* Max Tx buffer size by each channel */
SSIZE:
        DS8 16
//   50 uint16 RSIZE[_EthNo][MAX_SOCK_NUM];					/* Max Rx buffer size by each channel */
RSIZE:
        DS8 16
SMASK:
        DS8 32
RMASK:
        DS8 32
//   51 uint32 SBUFBASEADDRESS[_EthNo][MAX_SOCK_NUM];		/* Tx buffer base address by each channel */
SBUFBASEADDRESS:
        DS8 32

        SECTION `.bss`:DATA:NOROOT(2)
//   52 uint32 RBUFBASEADDRESS[_EthNo][MAX_SOCK_NUM];		/* Rx buffer base address by each channel */
RBUFBASEADDRESS:
        DS8 32
//   53 
//   54 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   55 void w3150ainit(uint32 nUSE)
//   56 {
w3150ainit:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   57 	////////////////////////////////////////////////////////////////////////////
//   58 	// RST port!!
//   59 	wSPI0_Init(nUSE);
        CMP      R4,#+1
        BNE.N    ??w3150ainit_0
        LDR.W    R5,??DataTable7_2  ;; 0x40010800
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0xF0000
        ORR      R0,R0,#0x30000
        STR      R0,[R5, #+0]
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0xF00000
        ORR      R0,R0,#0xB00000
        STR      R0,[R5, #+0]
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+4
        LSRS     R0,R0,#+4
        ORR      R0,R0,#0xB0000000
        STR      R0,[R5, #+0]
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0xF000000
        ORR      R0,R0,#0x4000000
        STR      R0,[R5, #+0]
        BL       SPI1Init
        LDR      R0,[R5, #+12]
        ORR      R0,R0,#0x10
        STR      R0,[R5, #+12]
        B.N      ??w3150ainit_1
??w3150ainit_0:
        CBNZ.N   R4,??w3150ainit_1
        LDR.W    R5,??DataTable7_3  ;; 0x40010c04
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0xF0000
        ORR      R0,R0,#0x30000
        STR      R0,[R5, #+0]
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0xF00000
        ORR      R0,R0,#0xB00000
        STR      R0,[R5, #+0]
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+4
        LSRS     R0,R0,#+4
        ORR      R0,R0,#0xB0000000
        STR      R0,[R5, #+0]
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0xF000000
        ORR      R0,R0,#0x4000000
        STR      R0,[R5, #+0]
        BL       SPI2Init
        LDR      R0,[R5, #+8]
        ORR      R0,R0,#0x1000
        STR      R0,[R5, #+8]
//   60 	iinchip_init(nUSE);
??w3150ainit_1:
        MOV      R0,R4
        POP      {R1,R4,R5,LR}
        B.N      iinchip_init
//   61 }
//   62 
//   63 
//   64 /*
//   65 **********************************************************
//   66 This function writes the data into W3150A registers.
//   67 **********************************************************
//   68  */
//   69 #if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   70 uint8 IINCHIP_WRITE(uint32 nUSE, uint32 addr, uint8 data)
//   71 {
IINCHIP_WRITE:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//   72 	// INDIRECT MODE I/F
//   73 	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
//   74 		IINCHIP_ISR_DISABLE(nUSE);
//   75 		*((vuint8*)IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
//   76 		*((vuint8*)IDM_AR1) = (uint8)((addr & 0x00FF) >> 0);
//   77 		*((vuint8*)IDM_DR ) = data;
//   78 		IINCHIP_ISR_ENABLE(nUSE);
//   79 	#else
//   80 		//SPI MODE I/F, m200804 [woong] : use spi.h
//   81 		IINCHIP_ISR_DISABLE(nUSE);
//   82 	
//   83 		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start
        CBNZ.N   R4,??IINCHIP_WRITE_0
        LDR.W    R0,??DataTable7_4  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x1000
        B.N      ??IINCHIP_WRITE_1
??IINCHIP_WRITE_0:
        CMP      R4,#+1
        BNE.N    ??IINCHIP_WRITE_2
        LDR.W    R0,??DataTable7_5  ;; 0x4001080c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x10
??IINCHIP_WRITE_1:
        STR      R1,[R0, #+0]
//   84 
//   85 		IINCHIP_SpiSendData(nUSE, 0xF0);
??IINCHIP_WRITE_2:
        MOVS     R1,#+240
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//   86 		IINCHIP_SpiSendData(nUSE, (addr & 0xFF00) >> 8);
        UBFX     R1,R5,#+8,#+8
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//   87 		IINCHIP_SpiSendData(nUSE, addr & 0x00FF);
        UXTB     R1,R5
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//   88 		IINCHIP_SpiSendData(nUSE, data);
        MOV      R1,R6
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//   89 
//   90 		IINCHIP_CSon(nUSE);
        CBNZ.N   R4,??IINCHIP_WRITE_3
        LDR.W    R0,??DataTable7_4  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1000
        B.N      ??IINCHIP_WRITE_4
??IINCHIP_WRITE_3:
        CMP      R4,#+1
        BNE.N    ??IINCHIP_WRITE_5
        LDR.W    R0,??DataTable7_5  ;; 0x4001080c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x10
??IINCHIP_WRITE_4:
        STR      R1,[R0, #+0]
//   91 		
//   92 		IINCHIP_ISR_ENABLE(nUSE);
//   93 	#endif
//   94 	return 1;
??IINCHIP_WRITE_5:
        MOVS     R0,#+1
        POP      {R4-R6,PC}       ;; return
//   95 }
//   96 #endif
//   97 
//   98 /*
//   99 **************************************************************
//  100 This function reads the value from W3150A registers.
//  101 **************************************************************
//  102  */
//  103 #if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  104 uint8 IINCHIP_READ(uint32 nUSE, uint32 addr)
//  105 {
IINCHIP_READ:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  106 	uint8 data;
//  107 	// INDIRECT MODE I/F
//  108 	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)   
//  109 		IINCHIP_ISR_DISABLE();
//  110 		*((vuint8*)IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
//  111 		*((vuint8*)IDM_AR1) = (uint8)(addr & 0x00FF);
//  112 		data = *((vuint8*)IDM_DR);
//  113 		IINCHIP_ISR_ENABLE(nUSE);
//  114 	#else
//  115 		//SPI MODE I/F 
//  116 		IINCHIP_ISR_DISABLE(nUSE);		
//  117 		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start
        CBNZ.N   R4,??IINCHIP_READ_0
        LDR.W    R0,??DataTable7_4  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x1000
        B.N      ??IINCHIP_READ_1
??IINCHIP_READ_0:
        CMP      R4,#+1
        BNE.N    ??IINCHIP_READ_2
        LDR.W    R0,??DataTable7_5  ;; 0x4001080c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x10
??IINCHIP_READ_1:
        STR      R1,[R0, #+0]
//  118 		IINCHIP_SpiSendData(nUSE, 0x0F);
??IINCHIP_READ_2:
        MOVS     R1,#+15
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  119 		IINCHIP_SpiSendData(nUSE, (addr & 0xFF00) >> 8);
        UBFX     R1,R5,#+8,#+8
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  120 		IINCHIP_SpiSendData(nUSE, addr & 0x00FF);		
        UXTB     R1,R5
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  121 
//  122 		data = IINCHIP_SpiRecvData(nUSE, 0);
        MOVS     R1,#+0
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
        UXTB     R0,R0
//  123 
//  124 		IINCHIP_CSon(nUSE);                          	// SPI end
        CBNZ.N   R4,??IINCHIP_READ_3
        LDR.W    R1,??DataTable7_4  ;; 0x40010c0c
        LDR      R2,[R1, #+0]
        ORR      R2,R2,#0x1000
        B.N      ??IINCHIP_READ_4
??IINCHIP_READ_3:
        CMP      R4,#+1
        BNE.N    ??IINCHIP_READ_5
        LDR.W    R1,??DataTable7_5  ;; 0x4001080c
        LDR      R2,[R1, #+0]
        ORR      R2,R2,#0x10
??IINCHIP_READ_4:
        STR      R2,[R1, #+0]
//  125 
//  126 		IINCHIP_ISR_ENABLE(nUSE);
//  127 	#endif
//  128 	
//  129 	return data;
??IINCHIP_READ_5:
        POP      {R1,R4,R5,PC}    ;; return
//  130 }
//  131 #endif
//  132 
//  133 /*
//  134 ***********************************************************
//  135 This function writes into W3150A memory(Buffer)
//  136 ***********************************************************
//  137  */
//  138 #if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  139 uint16 wiz_write_buf(uint32 nUSE, uint32 addr, uint8* buf, uint16 len)
//  140 {
wiz_write_buf:
        PUSH     {R3-R11,LR}
        MOV      R4,R0
        MOV      R9,R1
        MOV      R11,R2
        MOV      R10,R3
//  141 	uint16 idx = 0;
//  142 	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
//  143 	IINCHIP_ISR_DISABLE();
//  144 	*((vuint8 *) IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
//  145 	*((vuint8 *) IDM_AR1) = (uint8) (addr & 0x00FF);
//  146 	for (idx = 0; idx < len ; idx++) *((vuint8*)IDM_DR) = buf[idx];
//  147 	IINCHIP_ISR_ENABLE();
//  148 	#else
//  149 	//SPI MODE I/F
//  150 	// m200804 [woong] : use spi.h
//  151 	IINCHIP_ISR_DISABLE(nUSE);
//  152 
//  153 	for(idx = 0; idx < len; idx++)
        MOVS     R7,#+0
        CMP      R10,#+0
        BEQ.N    ??wiz_write_buf_0
        MOV      R8,R9
        LDR.W    R5,??DataTable7_4  ;; 0x40010c0c
        LDR.W    R6,??DataTable7_5  ;; 0x4001080c
//  154 	{
//  155 		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start 
??wiz_write_buf_1:
        CBNZ.N   R4,??wiz_write_buf_2
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0x1000
        STR      R0,[R5, #+0]
        B.N      ??wiz_write_buf_3
??wiz_write_buf_2:
        CMP      R4,#+1
        BNE.N    ??wiz_write_buf_3
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x10
        STR      R0,[R6, #+0]
//  156 
//  157 		IINCHIP_SpiSendData(nUSE, 0xF0);
??wiz_write_buf_3:
        MOVS     R1,#+240
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  158 		IINCHIP_SpiSendData(nUSE, ((addr+idx) & 0xFF00) >> 8);
        UBFX     R1,R8,#+8,#+8
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  159 		IINCHIP_SpiSendData(nUSE, (addr+idx) & 0x00FF);
        ADD      R1,R7,R9
        UXTB     R1,R1
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  160 		IINCHIP_SpiSendData(nUSE, buf[idx]);
        LDRB     R1,[R11, #+0]
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  161 
//  162 		IINCHIP_CSon(nUSE);                             // CS=0, SPI end 
        CBNZ.N   R4,??wiz_write_buf_4
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x1000
        STR      R0,[R5, #+0]
        B.N      ??wiz_write_buf_5
??wiz_write_buf_4:
        CMP      R4,#+1
        BNE.N    ??wiz_write_buf_5
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x10
        STR      R0,[R6, #+0]
//  163 	}
??wiz_write_buf_5:
        ADDS     R7,R7,#+1
        ADD      R11,R11,#+1
        ADD      R8,R8,#+1
        CMP      R7,R10
        BLT.N    ??wiz_write_buf_1
//  164 
//  165 	IINCHIP_ISR_ENABLE();
//  166 	#endif
//  167 	return len;
??wiz_write_buf_0:
        B.N      ?Subroutine0
//  168 }
//  169 #endif
//  170 
//  171 /*
//  172 ************************************************************
//  173 This function reads from W3150A memory (Buffer)
//  174 ************************************************************
//  175  */
//  176 #if (__DEF_IINCHIP_BUS__ != __DEF_IINCHIP_DIRECT_MODE__)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  177 uint16 wiz_read_buf(uint32 nUSE, uint32 addr, uint8* buf, uint16 len)
//  178 {
wiz_read_buf:
        PUSH     {R3-R11,LR}
        MOV      R4,R0
        MOV      R9,R1
        MOV      R11,R2
        MOV      R10,R3
//  179 	uint16 idx = 0;
//  180 	#if(__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
//  181 	IINCHIP_ISR_DISABLE();
//  182 	*((vuint8*)IDM_AR0) = (uint8)((addr & 0xFF00) >> 8);
//  183 	*((vuint8*)IDM_AR1) = (uint8)(addr & 0x00FF);
//  184 	for (idx = 0; idx < len ; idx++) buf[idx] = *((vuint8*)IDM_DR);
//  185 	IINCHIP_ISR_ENABLE();
//  186 	#else
//  187 	//SPI MODE I/F
//  188 	// m200804 [woong] : use spi.h
//  189 	IINCHIP_ISR_DISABLE();
//  190 
//  191 	for (idx=0; idx<len; idx++)
        MOVS     R7,#+0
        CMP      R10,#+0
        BEQ.N    ??wiz_read_buf_0
        MOV      R8,R9
        LDR.W    R5,??DataTable7_4  ;; 0x40010c0c
        LDR.W    R6,??DataTable7_5  ;; 0x4001080c
//  192     {
//  193 		IINCHIP_CSoff(nUSE);                             // CS=0, SPI start 
??wiz_read_buf_1:
        CBNZ.N   R4,??wiz_read_buf_2
        LDR      R0,[R5, #+0]
        BIC      R0,R0,#0x1000
        STR      R0,[R5, #+0]
        B.N      ??wiz_read_buf_3
??wiz_read_buf_2:
        CMP      R4,#+1
        BNE.N    ??wiz_read_buf_3
        LDR      R0,[R6, #+0]
        BIC      R0,R0,#0x10
        STR      R0,[R6, #+0]
//  194 
//  195 		IINCHIP_SpiSendData(nUSE, 0x0F);
??wiz_read_buf_3:
        MOVS     R1,#+15
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  196 		IINCHIP_SpiSendData(nUSE, ((addr+idx) & 0xFF00) >> 8);
        UBFX     R1,R8,#+8,#+8
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  197 		IINCHIP_SpiSendData(nUSE, (addr+idx) & 0x00FF);
        ADD      R1,R7,R9
        UXTB     R1,R1
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
//  198 		buf[idx] = IINCHIP_SpiRecvData(nUSE, 0);
        MOVS     R1,#+0
        MOV      R0,R4
        BL       IINCHIP_SpiSendData
        STRB     R0,[R11, #+0]
//  199 
//  200 		IINCHIP_CSon(nUSE);                             // CS=0, SPI end 	   
        CBNZ.N   R4,??wiz_read_buf_4
        LDR      R0,[R5, #+0]
        ORR      R0,R0,#0x1000
        STR      R0,[R5, #+0]
        B.N      ??wiz_read_buf_5
??wiz_read_buf_4:
        CMP      R4,#+1
        BNE.N    ??wiz_read_buf_5
        LDR      R0,[R6, #+0]
        ORR      R0,R0,#0x10
        STR      R0,[R6, #+0]
//  201 	}
??wiz_read_buf_5:
        ADDS     R7,R7,#+1
        ADD      R11,R11,#+1
        ADD      R8,R8,#+1
        CMP      R7,R10
        BLT.N    ??wiz_read_buf_1
//  202 	IINCHIP_ISR_ENABLE(nUSE);
//  203 	#endif
//  204 	return len;
??wiz_read_buf_0:
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  205 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        MOV      R0,R10
        POP      {R1,R4-R11,PC}   ;; return
//  206 #endif
//  207 
//  208 /*
//  209 *******************************************************
//  210 Socket interrupt routine
//  211 *******************************************************
//  212 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  213 void ISR(uint32 nUSE)
//  214 {
//  215 #ifdef __DEF_IINCHIP_INT__
//  216 	uint8 int_val;
//  217 	IINCHIP_ISR_DISABLE();
//  218 	int_val = IINCHIP_READ(nUSE, IR);
//  219 
//  220 	/* +200804[woong] process all of interupt */
//  221    do {
//  222    /*---*/
//  223 	if (int_val & IR_CONFLICT)
//  224 	{
//  225 		dprintf("IP conflict : %.2x\r\n", int_val);
//  226 	}
//  227 	if (int_val & IR_UNREACH)
//  228 	{
//  229 		dprintf("INT Port Unreachable : %.2x\r\n", int_val);
//  230 		dprintf("UIPR0 : %d.%d.%d.%d\r\n", IINCHIP_READ(UIPR0), IINCHIP_READ(UIPR0+1), IINCHIP_READ(UIPR0+2), IINCHIP_READ(UIPR0+3));
//  231 		dprintf("UPORT0 : %.2x %.2x\r\n", IINCHIP_READ(UPORT0), IINCHIP_READ(UPORT0+1));
//  232 	}
//  233 	
//  234    	/* +200804[woong] interrupt clear */
//  235    	IINCHIP_WRITE(IR, 0xf0); 
//  236       /*---*/
//  237 	  
//  238 	if (int_val & IR_SOCK(0))
//  239 	{
//  240    	/* +-200804[woong] save interrupt value*/
//  241    		I_STATUS[nUSE][0] |= IINCHIP_READ(Sn_IR(0)); // can be come to over two times.
//  242    		IINCHIP_WRITE(Sn_IR(0), I_STATUS[0]);
//  243       /*---*/
//  244 	}
//  245 	if (int_val & IR_SOCK(1))
//  246 	{
//  247    	/* +-200804[woong] save interrupt value*/
//  248    		I_STATUS[nUSE][1] |= IINCHIP_READ(Sn_IR(1)); // can be come to over two times.
//  249    		IINCHIP_WRITE(Sn_IR(1), I_STATUS[1]);
//  250       /*---*/
//  251 	}
//  252 	if (int_val & IR_SOCK(2))
//  253 	{
//  254    	/* +-200804[woong] save interrupt value*/
//  255    		I_STATUS[2] |= IINCHIP_READ(Sn_IR(2)); // can be come to over two times.
//  256    		IINCHIP_WRITE(Sn_IR(2), I_STATUS[2]);
//  257       /*---*/
//  258 	}
//  259 	if (int_val & IR_SOCK(3))
//  260 	{
//  261    	/* +-200804[woong] save interrupt value*/
//  262    		I_STATUS[3] |= IINCHIP_READ(Sn_IR(3)); // can be come to over two times.
//  263    		IINCHIP_WRITE(nUSE, Sn_IR(nUSE, 3), I_STATUS[nUSE][3]);
//  264       /*---*/
//  265 	}
//  266 
//  267 	/* +-200804[woong] re-read interrupt value*/
//  268    	int_val = IINCHIP_READ(nUSE, IR);
//  269 
//  270 	/* +200804[woong] if exist, contiue to process */
//  271    } while (int_val != 0x00);
//  272    /*---*/
//  273 
//  274 	IINCHIP_ISR_ENABLE(nUSE);
//  275 	
//  276 #endif
//  277 }
ISR:
        BX       LR               ;; return
//  278 
//  279 /*
//  280 ********************************************************************************
//  281  Initializes the iinchip to work in whether DIRECT or INDIRECT mode
//  282  This function is for resetting of the iinchip.
//  283 ********************************************************************************
//  284 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  285 void iinchip_init(uint32 nUSE)
//  286 {
iinchip_init:
        PUSH     {R7,LR}
//  287 ////////////////////////////////////////////////////////////////////////////////
//  288 	setMR(nUSE, MR_RST);
        MOVS     R2,#+128
        MOV      R1,#+32768
        BL       IINCHIP_WRITE
//  289 	OSTimeDly(1000L);
        MOV      R0,#+1000
        POP      {R1,LR}
        B.W      OSTimeDly
//  290 
//  291 #if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
//  292 		setMR(MR_IND | MR_AI);
//  293 	#ifdef __DEF_IINCHIP_DBG__	
//  294 			dprintf("MR value is %d \r\n", IINCHIP_READ(nUSE, MR));
//  295 	#endif	
//  296 #endif
//  297 }
//  298 
//  299 /*
//  300 ************************************************************************************
//  301 This function set the transmit & receive buffer size as per the channels is used
//  302 tx_size Tx memory size (00 - 1KByte, 01- 2KBtye, 10 - 4KByte, 11 - 8KByte)
//  303 rx_size Rx memory size (00 - 1KByte, 01- 2KBtye, 10 - 4KByte, 11 - 8KByte)
//  304 Note for TMSR and RMSR bits are as follows
//  305 bit 1-0 : memory size of channel #0 \n
//  306 bit 3-2 : memory size of channel #1 \n
//  307 bit 5-4 : memory size of channel #2 \n
//  308 bit 7-6 : memory size of channel #3 \n
//  309 Maximum memory size for Tx, Rx in the W3150 is 8K Bytes,
//  310 In the range of 8KBytes, the memory size could be allocated dynamically by each channel.
//  311 Be attentive to sum of memory size shouldn't exceed 8Kbytes
//  312 and to data transmission and receiption from non-allocated channel may cause some problems.
//  313 If the 8KBytes memory is already  assigned to centain channel, 
//  314 other 3 channels couldn't be used, for there's no available memory.
//  315 If two 4KBytes memory are assigned to two each channels, 
//  316 other 2 channels couldn't be used, for there's no available memory.
//  317 ************************************************************************************
//  318  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  319 void sysinit(uint32 nUSE, uint8 tx_size, uint8 rx_size)
//  320 {
sysinit:
        PUSH     {R0-R2,R4-R11,LR}
        MOV      R6,R0
//  321 	int16 i;
//  322 	int16 ssum,rsum;
//  323 
//  324 #ifdef __DEF_IINCHIP_DBG__
//  325 	dprintf("sysinit()\r\n"); 
//  326 #endif
//  327 
//  328 	ssum = 0;
        MOVS     R4,#+0
//  329 	rsum = 0;
        MOV      R10,R4
//  330 	
//  331 	IINCHIP_WRITE(nUSE, TMSR,tx_size); /* Set Tx memory size for each channel */
        MOV      R2,R1
        MOVS     R1,#+27
        BL       IINCHIP_WRITE
//  332 	IINCHIP_WRITE(nUSE, RMSR,rx_size);	 /* Set Rx memory size for each channel */
        LDRB     R2,[SP, #+8]
        MOVS     R1,#+26
        MOV      R0,R6
        BL       IINCHIP_WRITE
//  333 
//  334 	SBUFBASEADDRESS[nUSE][0] = (uint16)(__DEF_IINCHIP_MAP_TXBUF__);		/* Set base address of Tx memory for channel #0 */
        LSL      R12,R6,#+4
        LDR.W    R3,??DataTable7_6
        ADD      LR,R12,R3
        MOV      R0,#+16384
        STR      R0,[LR, #+96]
//  335 	RBUFBASEADDRESS[nUSE][0] = (uint16)(__DEF_IINCHIP_MAP_RXBUF__);		/* Set base address of Rx memory for channel #0 */
        LDR.W    R5,??DataTable7_7
        MOV      R0,#+24576
        STR      R0,[R12, R5]
//  336 
//  337 #ifdef __DEF_IINCHIP_DBG__
//  338 	dprintf("Channel : SEND MEM SIZE : RECV MEM SIZE\r\n");
//  339 #endif
//  340 
//  341    for (i = 0 ; i < MAX_SOCK_NUM; i++)       // Set the size, masking and base address of Tx & Rx memory by each channel
        MOVS     R0,#+0
        MOV      R1,R0
        ADD      R2,R3,R6, LSL #+3
        ADD      R3,R3,R6, LSL #+3
        ADDS     R3,R3,#+16
        ADD      R6,LR,#+32
        ADDW     R7,LR,#+64
        ADDW     LR,LR,#+96
        ADD      R12,R12,R5
        MOV      R8,#+4096
        MOVW     R9,#+8191
//  342 	{
//  343 		SSIZE[nUSE][i] = (int16)(0);
??sysinit_0:
        MOVS     R5,#+0
        STRH     R5,[R2, #+0]
//  344 		RSIZE[nUSE][i] = (int16)(0);
        STRH     R5,[R3, #+0]
//  345 		if (ssum < 8192)
        CMP      R4,#+8192
        BGE.N    ??sysinit_1
//  346 		{
//  347          switch((tx_size >> i*2) & 0x03)  // Set Tx memory size
        LDRB     R5,[SP, #+4]
        ASRS     R5,R5,R1
        ANDS     R5,R5,#0x3
        BEQ.N    ??sysinit_2
        CMP      R5,#+2
        BEQ.N    ??sysinit_3
        BCC.N    ??sysinit_4
        CMP      R5,#+3
        ITTT     EQ 
        MOVEQ    R5,#+8192
        STRHEQ   R5,[R2, #+0]
        STREQ    R9,[R6, #+0]
        B.N      ??sysinit_1
//  348 			{
//  349 			case 0:
//  350 				SSIZE[nUSE][i] = (int16)(1024);
??sysinit_2:
        MOV      R5,#+1024
        STRH     R5,[R2, #+0]
//  351 				SMASK[nUSE][i] = (uint16)(0x03FF);
        MOVW     R5,#+1023
??sysinit_5:
        B.N      ??sysinit_6
//  352 				break;
//  353 			case 1:
//  354 				SSIZE[nUSE][i] = (int16)(2048);
??sysinit_4:
        MOV      R5,#+2048
        STRH     R5,[R2, #+0]
//  355 				SMASK[nUSE][i] = (uint16)(0x07FF);
        MOVW     R5,#+2047
        B.N      ??sysinit_6
//  356 				break;
//  357 			case 2:
//  358 				SSIZE[nUSE][i] = (int16)(4096);
??sysinit_3:
        STRH     R8,[R2, #+0]
//  359 				SMASK[nUSE][i] = (uint16)(0x0FFF);
        MOVW     R5,#+4095
??sysinit_6:
        STR      R5,[R6, #+0]
//  360 				break;
//  361 			case 3:
//  362 				SSIZE[nUSE][i] = (int16)(8192);
//  363 				SMASK[nUSE][i] = (uint16)(0x1FFF);
//  364 				break;
//  365 			}
//  366 		}
//  367 		if (rsum < 8192)
??sysinit_1:
        CMP      R10,#+8192
        BGE.N    ??sysinit_7
//  368 		{
//  369          switch((rx_size >> i*2) & 0x03)     // Set Rx memory size
        LDRB     R5,[SP, #+8]
        ASRS     R5,R5,R1
        ANDS     R5,R5,#0x3
        BEQ.N    ??sysinit_8
        CMP      R5,#+2
        BEQ.N    ??sysinit_9
        BCC.N    ??sysinit_10
        CMP      R5,#+3
        ITTT     EQ 
        MOVEQ    R5,#+8192
        STRHEQ   R5,[R3, #+0]
        STREQ    R9,[R7, #+0]
        B.N      ??sysinit_7
//  370 			{
//  371 			case 0:
//  372 				RSIZE[nUSE][i] = (int16)(1024);
??sysinit_8:
        MOV      R5,#+1024
        STRH     R5,[R3, #+0]
//  373 				RMASK[nUSE][i] = (uint16)(0x03FF);
        MOVW     R5,#+1023
??sysinit_11:
        B.N      ??sysinit_12
//  374 				break;
//  375 			case 1:
//  376 				RSIZE[nUSE][i] = (int16)(2048);
??sysinit_10:
        MOV      R5,#+2048
        STRH     R5,[R3, #+0]
//  377 				RMASK[nUSE][i] = (uint16)(0x07FF);
        MOVW     R5,#+2047
        B.N      ??sysinit_12
//  378 				break;
//  379 			case 2:
//  380 				RSIZE[nUSE][i] = (int16)(4096);
??sysinit_9:
        STRH     R8,[R3, #+0]
//  381 				RMASK[nUSE][i] = (uint16)(0x0FFF);
        MOVW     R5,#+4095
??sysinit_12:
        STR      R5,[R7, #+0]
//  382 				break;
//  383 			case 3:
//  384 				RSIZE[nUSE][i] = (int16)(8192);
//  385 				RMASK[nUSE][i] = (uint16)(0x1FFF);
//  386 				break;
//  387 			}
//  388 		}
//  389 		ssum += SSIZE[nUSE][i];
??sysinit_7:
        LDRSH    R5,[R2, #+0]
        ADDS     R4,R5,R4
        SXTH     R4,R4
//  390 		rsum += RSIZE[nUSE][i];
        LDRSH    R5,[R3, #+0]
        ADD      R5,R5,R10
        SXTH     R10,R5
//  391 
//  392       if (i != 0)             // Sets base address of Tx and Rx memory for channel #1,#2,#3
        CBZ.N    R0,??sysinit_13
//  393 		{
//  394 			SBUFBASEADDRESS[nUSE][i] = SBUFBASEADDRESS[nUSE][i-1] + SSIZE[nUSE][i-1];
        LDR      R5,[LR, #-4]
        LDRH     R11,[R2, #-2]
        ADD      R5,R11,R5
        STR      R5,[LR, #+0]
//  395 			RBUFBASEADDRESS[nUSE][i] = RBUFBASEADDRESS[nUSE][i-1] + RSIZE[nUSE][i-1];
        LDR      R5,[R12, #-4]
        LDRH     R11,[R3, #-2]
        ADD      R5,R11,R5
        STR      R5,[R12, #+0]
//  396 		}
//  397 #ifdef __DEF_IINCHIP_DBG__
//  398 		dprintf("%d : %.4x : %.4x : %.4x : %.4x\r\n", i, (uint16)SBUFBASEADDRESS[nUSE][i], (uint16)RBUFBASEADDRESS[nUSE][i], SSIZE[nUSE][i], RSIZE[nUSE][i]);
//  399 #endif
//  400 	}
??sysinit_13:
        ADDS     R0,R0,#+1
        ADD      R12,R12,#+4
        ADD      LR,LR,#+4
        ADDS     R7,R7,#+4
        ADDS     R6,R6,#+4
        ADDS     R3,R3,#+2
        ADDS     R2,R2,#+2
        ADDS     R1,R1,#+2
        CMP      R0,#+4
        BLT.N    ??sysinit_0
//  401 }
        ADD      SP,SP,#+12
        POP      {R4-R11,PC}      ;; return
//  402 
//  403 /* 200804 regeneration for SPI mode*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  404 void setMR(uint32 nUSE, uint8 val)
//  405 {
//  406 
//  407 #if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_INDIRECT_MODE__)
//  408 	*((volatile uint8*)(MR)) = val;
//  409 
//  410 #else
//  411 	/* 	DIRECT ACCESS	*/
//  412 	IINCHIP_WRITE(nUSE, MR, val);
setMR:
        MOV      R2,R1
        MOV      R1,#+32768
        B.N      IINCHIP_WRITE
//  413 #endif	
//  414 }
//  415 
//  416 
//  417 /*
//  418 *********************************************************************
//  419 This function sets up gateway IP address.
//  420 "addr" is a pointer to a 4 -byte array responsible to set the Gateway IP address.
//  421 
//  422 *********************************************************************
//  423 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  424 void setGAR(uint32 nUSE, uint8 *addr)
//  425 {
setGAR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  426 	IINCHIP_WRITE(nUSE, (GAR0 + 0),addr[0]);
        LDRB     R2,[R5, #+0]
        MOVS     R1,#+1
        BL       IINCHIP_WRITE
//  427 	IINCHIP_WRITE(nUSE, (GAR0 + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        MOVS     R1,#+2
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  428 	IINCHIP_WRITE(nUSE, (GAR0 + 2),addr[2]);
        LDRB     R2,[R5, #+2]
        MOVS     R1,#+3
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  429 	IINCHIP_WRITE(nUSE, (GAR0 + 3),addr[3]);
        LDRB     R2,[R5, #+3]
        MOVS     R1,#+4
        B.N      ?Subroutine2
//  430 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  431 void getGWIP(uint32 nUSE, uint8 *addr)
getGWIP:
        PUSH     {R3-R5,LR}
        B.N      ?Subroutine4
//  432 {
//  433 	addr[0] = IINCHIP_READ(nUSE, (GAR0 + 0));
//  434 	addr[1] = IINCHIP_READ(nUSE, (GAR0 + 1));
//  435 	addr[2] = IINCHIP_READ(nUSE, (GAR0 + 2));
//  436 	addr[3] = IINCHIP_READ(nUSE, (GAR0 + 3));
//  437 }
//  438 
//  439 /*
//  440 *********************************************************************
//  441 It sets up SubnetMask address
//  442 "addr" is a pointer to a 4 -byte array responsible to set the SubnetMask address
//  443 
//  444 *********************************************************************
//  445 */
//  446 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  447 void setSUBR(uint32 nUSE, uint8 * addr)
//  448 {
setSUBR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  449 	IINCHIP_WRITE(nUSE, (SUBR0 + 0),addr[0]);
        LDRB     R2,[R5, #+0]
        MOVS     R1,#+5
        BL       IINCHIP_WRITE
//  450 	IINCHIP_WRITE(nUSE, (SUBR0 + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        MOVS     R1,#+6
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  451 	IINCHIP_WRITE(nUSE, (SUBR0 + 2),addr[2]);
        LDRB     R2,[R5, #+2]
        MOVS     R1,#+7
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  452 	IINCHIP_WRITE(nUSE, (SUBR0 + 3),addr[3]);
        LDRB     R2,[R5, #+3]
        MOVS     R1,#+8
        REQUIRE ?Subroutine2
        ;; // Fall through to label ?Subroutine2
//  453 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine2:
        MOV      R0,R4
        POP      {R3-R5,LR}
        B.N      IINCHIP_WRITE
//  454 
//  455 /*
//  456 *********************************************************************
//  457 This function sets up MAC address.
//  458 "addr" is a pointer to a 6 -byte array responsible to set the MAC address.
//  459 
//  460 *********************************************************************
//  461 */
//  462 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  463 void setSHAR(uint32 nUSE, uint8 * addr)
//  464 {
setSHAR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  465 	IINCHIP_WRITE(nUSE, (SHAR0 + 0),addr[0]);
        LDRB     R2,[R5, #+0]
        MOVS     R1,#+9
        BL       IINCHIP_WRITE
//  466 	IINCHIP_WRITE(nUSE, (SHAR0 + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        MOVS     R1,#+10
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  467 	IINCHIP_WRITE(nUSE, (SHAR0 + 2),addr[2]);
        LDRB     R2,[R5, #+2]
        MOVS     R1,#+11
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  468 	IINCHIP_WRITE(nUSE, (SHAR0 + 3),addr[3]);
        LDRB     R2,[R5, #+3]
        MOVS     R1,#+12
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  469 	IINCHIP_WRITE(nUSE, (SHAR0 + 4),addr[4]);
        LDRB     R2,[R5, #+4]
        MOVS     R1,#+13
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  470 	IINCHIP_WRITE(nUSE, (SHAR0 + 5),addr[5]);
        LDRB     R2,[R5, #+5]
        MOVS     R1,#+14
        B.N      ?Subroutine2
//  471 }
//  472 
//  473 /*
//  474 *********************************************************************
//  475 This function sets up Source IP address.
//  476 "addr" is a pointer to a 4 -byte array responsible to set the Source IP address.
//  477 
//  478 *********************************************************************
//  479 */
//  480 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  481 void setSIPR(uint32 nUSE, uint8 * addr)
//  482 {
setSIPR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  483 	IINCHIP_WRITE(nUSE, (SIPR0 + 0),addr[0]);
        LDRB     R2,[R5, #+0]
        MOVS     R1,#+15
        BL       IINCHIP_WRITE
//  484 	IINCHIP_WRITE(nUSE, (SIPR0 + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        MOVS     R1,#+16
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  485 	IINCHIP_WRITE(nUSE, (SIPR0 + 2),addr[2]);
        LDRB     R2,[R5, #+2]
        MOVS     R1,#+17
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  486 	IINCHIP_WRITE(nUSE, (SIPR0 + 3),addr[3]);
        LDRB     R2,[R5, #+3]
        MOVS     R1,#+18
        B.N      ?Subroutine2
//  487 }
//  488 
//  489 /*
//  490 *********************************************************************
//  491 This function sets up Retransmission time.
//  492 If there is no response from the peer or delay in response then retransmission 
//  493 will be there as per RTR (Retry Time-value Register)setting
//  494 
//  495 *********************************************************************
//  496 */
//  497 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  498 void setRTR(uint32 nUSE, uint16 timeout)
//  499 {
setRTR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  500 	IINCHIP_WRITE(nUSE, (RTR0 + 0), (uint8)((timeout & 0xff00) >> 8));
        LSRS     R2,R5,#+8
        MOVS     R1,#+23
        BL       IINCHIP_WRITE
//  501 	IINCHIP_WRITE(nUSE, (RTR0 + 1), (uint8)(timeout & 0x00ff));
        UXTB     R2,R5
        MOVS     R1,#+24
        B.N      ?Subroutine2
//  502 }
//  503 
//  504 /*
//  505 *********************************************************************
//  506 These below functions are used to get the Gateway, SubnetMask
//  507 and Source Hardware Address (MAC Address) and Source IP address
//  508 *********************************************************************
//  509 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  510 void getGAR(uint32 nUSE, uint8 * addr)
getGAR:
        PUSH     {R3-R5,LR}
        REQUIRE ?Subroutine4
        ;; // Fall through to label ?Subroutine4

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine4:
        MOV      R4,R0
        MOV      R5,R1
        MOVS     R1,#+1
        BL       IINCHIP_READ
        STRB     R0,[R5, #+0]
        MOVS     R1,#+2
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+1]
        MOVS     R1,#+3
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+2]
        MOVS     R1,#+4
        REQUIRE ??Subroutine6_0
        ;; // Fall through to label ??Subroutine6_0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
??Subroutine6_0:
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+3]
        POP      {R0,R4,R5,PC}    ;; return
//  511 {
//  512 	addr[0] = IINCHIP_READ(nUSE, GAR0);
//  513 	addr[1] = IINCHIP_READ(nUSE, GAR0+1);
//  514 	addr[2] = IINCHIP_READ(nUSE, GAR0+2);
//  515 	addr[3] = IINCHIP_READ(nUSE, GAR0+3);
//  516 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  517 void getSUBR(uint32 nUSE, uint8 * addr)
//  518 {
getSUBR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  519 	addr[0] = IINCHIP_READ(nUSE, SUBR0);
        MOVS     R1,#+5
        BL       IINCHIP_READ
        STRB     R0,[R5, #+0]
//  520 	addr[1] = IINCHIP_READ(nUSE, SUBR0+1);
        MOVS     R1,#+6
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+1]
//  521 	addr[2] = IINCHIP_READ(nUSE, SUBR0+2);
        MOVS     R1,#+7
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+2]
//  522 	addr[3] = IINCHIP_READ(nUSE, SUBR0+3);
        MOVS     R1,#+8
        B.N      ??Subroutine6_0
//  523 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  524 void getSHAR(uint32 nUSE, uint8 * addr)
//  525 {
getSHAR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  526 	addr[0] = IINCHIP_READ(nUSE, SHAR0);
        MOVS     R1,#+9
        BL       IINCHIP_READ
        STRB     R0,[R5, #+0]
//  527 	addr[1] = IINCHIP_READ(nUSE, SHAR0+1);
        MOVS     R1,#+10
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+1]
//  528 	addr[2] = IINCHIP_READ(nUSE, SHAR0+2);
        MOVS     R1,#+11
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+2]
//  529 	addr[3] = IINCHIP_READ(nUSE, SHAR0+3);
        MOVS     R1,#+12
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+3]
//  530 	addr[4] = IINCHIP_READ(nUSE, SHAR0+4);
        MOVS     R1,#+13
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+4]
//  531 	addr[5] = IINCHIP_READ(nUSE, SHAR0+5);
        MOVS     R1,#+14
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+5]
//  532 }
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  533 void getSIPR(uint32 nUSE, uint8 * addr)
//  534 {
getSIPR:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  535 	addr[0] = IINCHIP_READ(nUSE, SIPR0);
        MOVS     R1,#+15
        BL       IINCHIP_READ
        STRB     R0,[R5, #+0]
//  536 	addr[1] = IINCHIP_READ(nUSE, SIPR0+1);
        MOVS     R1,#+16
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+1]
//  537 	addr[2] = IINCHIP_READ(nUSE, SIPR0+2);
        MOVS     R1,#+17
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+2]
//  538 	addr[3] = IINCHIP_READ(nUSE, SIPR0+3);
        MOVS     R1,#+18
        B.N      ??Subroutine6_0
//  539 }
//  540 
//  541 
//  542 /*
//  543 *********************************************************************
//  544 These below functions are used to get the Destination Hardware Address (MAC Address),
//  545 Destination IP address and Destination Port.
//  546 *********************************************************************
//  547 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  548 void getSn_DHAR(uint32 nUSE, SOCKET s, uint8 * addr)
//  549 {
getSn_DHAR:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R2
//  550 	addr[0] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s));
        LSLS     R6,R1,#+8
        ADDW     R1,R6,#+1030
        BL       IINCHIP_READ
        STRB     R0,[R5, #+0]
//  551 	addr[1] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+1);
        ADDW     R1,R6,#+1031
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+1]
//  552 	addr[2] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+2);
        ADD      R1,R6,#+1032
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+2]
//  553 	addr[3] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+3);
        ADDW     R1,R6,#+1033
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+3]
//  554 	addr[4] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+4);
        ADDW     R1,R6,#+1034
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+4]
//  555 	addr[5] = IINCHIP_READ(nUSE, Sn_DHAR0(nUSE, s)+5);
        ADDW     R1,R6,#+1035
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+5]
//  556 }
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  557 void setSn_DHAR(uint32 nUSE, SOCKET s, uint8 * addr)
//  558 {
setSn_DHAR:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R2
//  559 	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 0),addr[0]);
        LSLS     R6,R1,#+8
        LDRB     R2,[R5, #+0]
        ADDW     R1,R6,#+1030
        BL       IINCHIP_WRITE
//  560 	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        ADDW     R1,R6,#+1031
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  561 	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 2),addr[2]);
        LDRB     R2,[R5, #+2]
        ADD      R1,R6,#+1032
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  562 	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 3),addr[3]);
        LDRB     R2,[R5, #+3]
        ADDW     R1,R6,#+1033
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  563 	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 4),addr[4]);
        LDRB     R2,[R5, #+4]
        ADDW     R1,R6,#+1034
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  564 	IINCHIP_WRITE(nUSE, (Sn_DHAR0(nUSE, s) + 5),addr[5]);
        LDRB     R2,[R5, #+5]
        ADDW     R1,R6,#+1035
        B.N      ?Subroutine3
//  565 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  566 void getSn_DIPR(uint32 nUSE, SOCKET s, uint8 * addr)
//  567 {
getSn_DIPR:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R2
//  568 	addr[0] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s));
        LSLS     R6,R1,#+8
        ADDW     R1,R6,#+1036
        BL       IINCHIP_READ
        STRB     R0,[R5, #+0]
//  569 	addr[1] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s)+1);
        ADDW     R1,R6,#+1037
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+1]
//  570 	addr[2] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s)+2);
        ADDW     R1,R6,#+1038
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+2]
//  571 	addr[3] = IINCHIP_READ(nUSE, Sn_DIPR0(nUSE, s)+3);
        ADDW     R1,R6,#+1039
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+3]
//  572 }
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  573 void setSn_DIPR(uint32 nUSE, SOCKET s, uint8 * addr)
//  574 {
setSn_DIPR:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R2
//  575 	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 0),addr[0]);
        LSLS     R6,R1,#+8
        LDRB     R2,[R5, #+0]
        ADDW     R1,R6,#+1036
        BL       IINCHIP_WRITE
//  576 	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        ADDW     R1,R6,#+1037
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  577 	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 2),addr[2]);
        LDRB     R2,[R5, #+2]
        ADDW     R1,R6,#+1038
        MOV      R0,R4
        BL       IINCHIP_WRITE
//  578 	IINCHIP_WRITE(nUSE, (Sn_DIPR0(nUSE, s) + 3),addr[3]);
        LDRB     R2,[R5, #+3]
        ADDW     R1,R6,#+1039
        REQUIRE ?Subroutine3
        ;; // Fall through to label ?Subroutine3
//  579 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine3:
        MOV      R0,R4
        POP      {R4-R6,LR}
        B.N      IINCHIP_WRITE

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  580 void getSn_DPORT(uint32 nUSE, SOCKET s, uint8 * addr)
//  581 {
getSn_DPORT:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R2
//  582 	addr[0] = IINCHIP_READ(nUSE, Sn_DPORT0(nUSE, s));
        LSLS     R6,R1,#+8
        ADD      R1,R6,#+1040
        BL       IINCHIP_READ
        STRB     R0,[R5, #+0]
//  583 	addr[1] = IINCHIP_READ(nUSE, Sn_DPORT0(nUSE, s)+1);
        ADDW     R1,R6,#+1041
        MOV      R0,R4
        BL       IINCHIP_READ
        STRB     R0,[R5, #+1]
//  584 }
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  585 void setSn_DPORT(uint32 nUSE, SOCKET s, uint8 * addr)
//  586 {
setSn_DPORT:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R2
//  587 	IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 0),addr[0]);
        LSLS     R6,R1,#+8
        LDRB     R2,[R5, #+0]
        ADD      R1,R6,#+1040
        BL       IINCHIP_WRITE
//  588 	IINCHIP_WRITE(nUSE, (Sn_DPORT0(nUSE, s) + 1),addr[1]);
        LDRB     R2,[R5, #+1]
        ADDW     R1,R6,#+1041
        B.N      ?Subroutine3
//  589 }
//  590 
//  591 /*
//  592 *********************************************************************
//  593 This sets the maximum segment size of TCP in Active Mode),
//  594 while in Passive Mode this is set by peer
//  595 *********************************************************************
//  596 */
//  597 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  598 void setSn_MSS(uint32 nUSE, SOCKET s, uint16 Sn_MSSR0)
//  599 {
setSn_MSS:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R2
//  600 	IINCHIP_WRITE(nUSE, (Sn_MSSR0(nUSE, s) + 0),(uint8)((Sn_MSSR0 & 0xff00) >> 8));
        LSLS     R6,R1,#+8
        LSRS     R2,R5,#+8
        ADDW     R1,R6,#+1042
        BL       IINCHIP_WRITE
//  601 	IINCHIP_WRITE(nUSE, (Sn_MSSR0(nUSE, s) + 1),(uint8)(Sn_MSSR0 & 0x00ff));
        UXTB     R2,R5
        ADDW     R1,R6,#+1043
        B.N      ?Subroutine3
//  602 }
//  603 
//  604 /*
//  605 *********************************************************************
//  606 This gives free buffer size of transmit buffer. This is the data size that user can transmit.
//  607 User shuold check this value first and control the size of transmitting data
//  608 *********************************************************************
//  609 */
//  610 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  611 uint16 getSn_TX_FSR(uint32 nUSE, SOCKET s) // get socket TX free buf size
//  612 {
getSn_TX_FSR:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
//  613 	uint16 val=0,val1=0;
        MOVS     R5,#+0
        LSLS     R0,R1,#+8
        ADDW     R6,R0,#+1057
        ADD      R8,R0,#+1056
        B.N      ?Subroutine5
//  614 	do
//  615 	{
//  616 		val1 = IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE, s));
//  617 		val1 = (val1 << 8) + IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE,s) + 1);
//  618       if (val1 != 0)
//  619 		{
//  620    			val = IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE, s));
//  621    			val = (val << 8) + IINCHIP_READ(nUSE, Sn_TX_FSR0(nUSE, s) + 1);
//  622 		}
//  623 	} while (val != val1);
//  624    return val;
//  625 }
//  626 
//  627 /*
//  628 *********************************************************************
//  629 This gives size of received data in receive buffer. 
//  630 *********************************************************************
//  631 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  632 uint16 getSn_RX_RSR(uint32 nUSE, SOCKET s) // get socket RX recv buf size
//  633 {
getSn_RX_RSR:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
//  634 	uint16 val = 0, val1 = 0;
        MOVS     R5,#+0
        LSLS     R0,R1,#+8
        ADDW     R6,R0,#+1063
        ADDW     R8,R0,#+1062
        REQUIRE ?Subroutine5
        ;; // Fall through to label ?Subroutine5
//  635 	do
//  636 	{
//  637 		val1 = IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s));
//  638 		val1 = (val1 << 8) + IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s) + 1);
//  639 		if(val1 != 0)
//  640 		{
//  641    			val = IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s));
//  642    			val = (val << 8) + IINCHIP_READ(nUSE, Sn_RX_RSR0(nUSE, s) + 1);
//  643 		}
//  644 	} while (val != val1);
//  645    return val;
//  646 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine5:
        MOV      R1,R8
        MOV      R0,R4
        BL       IINCHIP_READ
        MOV      R7,R0
        MOV      R1,R6
        MOV      R0,R4
        BL       IINCHIP_READ
        ADD      R0,R0,R7, LSL #+8
        UXTH     R7,R0
        CBZ.N    R7,??Subroutine5_0
        MOV      R1,R8
        MOV      R0,R4
        BL       IINCHIP_READ
        MOV      R5,R0
        MOV      R1,R6
        MOV      R0,R4
        BL       IINCHIP_READ
        ADD      R5,R0,R5, LSL #+8
        UXTH     R5,R5
??Subroutine5_0:
        CMP      R5,R7
        BNE.N    ?Subroutine5
        MOV      R0,R5
        POP      {R4-R8,PC}       ;; return
//  647 
//  648 
//  649 /*
//  650 *********************************************************************
//  651 This function is being called by send() and sendto() function also. This function read the 
//  652 Tx write pointer register and after copy the data in buffer update the Tx write pointer
//  653 register. User should read upper byte first and lower byte later to get proper value.
//  654 *********************************************************************
//  655 */
//  656 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  657 void send_data_processing(uint32 nUSE, SOCKET s, uint8 *data, uint16 len)
//  658 {
send_data_processing:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
        MOV      R9,R0
        MOV      R5,R1
        MOV      R10,R2
        MOV      R7,R3
//  659 	uint16 ptr;
//  660 	ptr = IINCHIP_READ(nUSE, Sn_TX_WR0(nUSE, s));
        LSLS     R4,R5,#+8
        ADDW     R8,R4,#+1060
        MOV      R1,R8
        BL       IINCHIP_READ
        MOV      R6,R0
        ADDW     R4,R4,#+1061
        MOV      R1,R4
        MOV      R0,R9
//  661 	ptr = ((ptr & 0x00ff) << 8) + IINCHIP_READ(nUSE, Sn_TX_WR0(nUSE, s) + 1);
        BL       IINCHIP_READ
        ADD      R0,R0,R6, LSL #+8
        UXTH     R6,R0
//  662 	write_data(nUSE, s, data, (uint8 *)(ptr), len);
        STR      R7,[SP, #+0]
        MOV      R3,R6
        MOV      R2,R10
        MOV      R1,R5
        MOV      R0,R9
        BL       write_data
//  663 	ptr += len;
        B.N      ?Subroutine1
//  664 	IINCHIP_WRITE(nUSE,  Sn_TX_WR0(nUSE, s)     , (uint8)((ptr & 0xff00) >> 8));
//  665 	IINCHIP_WRITE(nUSE, (Sn_TX_WR0(nUSE, s) + 1), (uint8) (ptr & 0x00ff)      );
//  666 }
//  667 
//  668 
//  669 /*
//  670 *********************************************************************
//  671 This function is being called by recv() also. This function read the Rx read pointer register
//  672 and after copy the data from receive buffer update the Rx write pointer register.
//  673 User should read upper byte first and lower byte later to get proper value.
//  674 *********************************************************************
//  675 */
//  676 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  677 void recv_data_processing(uint32 nUSE, SOCKET s, uint8 *data, uint16 len)
//  678 {
recv_data_processing:
        PUSH     {R4-R10,LR}
        SUB      SP,SP,#+8
        MOV      R9,R0
        MOV      R5,R1
        MOV      R10,R2
        MOV      R7,R3
//  679 	uint16 ptr;
//  680 	ptr = IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s));
        LSLS     R4,R5,#+8
        ADD      R8,R4,#+1064
        MOV      R1,R8
        BL       IINCHIP_READ
        MOV      R6,R0
        ADDW     R4,R4,#+1065
        MOV      R1,R4
        MOV      R0,R9
//  681 	ptr = ((ptr & 0x00ff) << 8) + IINCHIP_READ(nUSE, Sn_RX_RD0(nUSE, s) + 1);
        BL       IINCHIP_READ
        ADD      R0,R0,R6, LSL #+8
        UXTH     R6,R0
//  682 #ifdef __DEF_IINCHIP_DBG__
//  683 	dprintf("ISR_RX: rd_ptr : %.4x\r\n", ptr);
//  684 #endif
//  685 	read_data(nUSE, s, (uint8 *)ptr, data, len); // read data
        STR      R7,[SP, #+0]
        MOV      R3,R10
        MOV      R2,R6
        MOV      R1,R5
        MOV      R0,R9
        BL       read_data
//  686 	ptr += len;
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  687 	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 0), (uint8)((ptr & 0xff00) >> 8));
//  688 	IINCHIP_WRITE(nUSE, (Sn_RX_RD0(nUSE, s) + 1), (uint8)((ptr & 0x00ff) >> 0));
//  689 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        ADDS     R5,R7,R6
        UXTH     R5,R5
        ASRS     R2,R5,#+8
        UXTB     R2,R2
        MOV      R1,R8
        MOV      R0,R9
        BL       IINCHIP_WRITE
        UXTB     R2,R5
        MOV      R1,R4
        MOV      R0,R9
        ADD      SP,SP,#+8
        POP      {R4-R10,LR}
        B.N      IINCHIP_WRITE
//  690 
//  691 /*
//  692 *********************************************************************
//  693 This function is being used for copy the data form application buffer to Transmite
//  694 buffer of the chip. It calculate the actual physical address where one has to write
//  695 the data in transmite buffer. Here also take care of the condition while it exceed
//  696 the Tx memory uper-bound of socket.
//  697 *********************************************************************
//  698 */
//  699 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  700 void write_data(uint32 nUSE, SOCKET s, vuint8 *src, vuint8 *dst, uint16 len)
//  701 {
write_data:
        PUSH     {R4-R8,LR}
        MOV      R8,R0
        MOV      R0,R1
        MOV      R6,R2
        LDR      R4,[SP, #+24]
//  702 	uint16 size;
//  703 	uint32 dst_mask;
//  704 	uint8 *dst_ptr;
//  705 
//  706 	dst_mask = (uint32)dst & getIINCHIP_TxMASK(nUSE, s);
        LDR.N    R2,??DataTable7_6
        ADD      R1,R2,R8, LSL #+4
        ADD      R7,R1,R0, LSL #+2
        LDR      R1,[R7, #+32]
        ANDS     R3,R1,R3
//  707 	dst_ptr = (uint8 *)(getIINCHIP_TxBASE(nUSE, s) + dst_mask);
        LDR      R1,[R7, #+96]
        ADDS     R1,R3,R1
        ADD      R2,R2,R8, LSL #+3
        LDRH     R0,[R2, R0, LSL #+1]
        UXTH     R4,R4
        ADDS     R2,R4,R3
        CMP      R0,R2
        BCS.N    ??write_data_0
//  708 	
//  709 	if (dst_mask + len > getIINCHIP_TxMAX(nUSE, s)) 
//  710 	{
//  711 		size = getIINCHIP_TxMAX(nUSE, s) - dst_mask;
        SUBS     R0,R0,R3
        UXTH     R5,R0
//  712 		wiz_write_buf(nUSE, (uint32)dst_ptr, (uint8*)src, size);
        MOV      R3,R5
        MOV      R2,R6
        MOV      R0,R8
        BL       wiz_write_buf
//  713 		src += size;
//  714 		size = len - size;
//  715 		dst_ptr = (uint8 *)(getIINCHIP_TxBASE(nUSE, s));
//  716 		wiz_write_buf(nUSE, (uint32)dst_ptr, (uint8*)src, size);
        SUBS     R3,R4,R5
        UXTH     R3,R3
        ADDS     R2,R5,R6
        LDR      R1,[R7, #+96]
        B.N      ??write_data_1
//  717 	} 
//  718 	else
//  719 	{
//  720 		wiz_write_buf(nUSE, (uint32)dst_ptr, (uint8*)src, len);
??write_data_0:
        MOV      R3,R4
        MOV      R2,R6
??write_data_1:
        MOV      R0,R8
        POP      {R4-R8,LR}
        B.N      wiz_write_buf
//  721 	}
//  722 }
//  723 
//  724 /*
//  725 *********************************************************************
//  726 This function is being used for copy the data form Receive buffer of the chip to
//  727 application buffer. It calculate the actual physical address where one has to read
//  728 the data from Receive buffer. Here also take care of the condition while it exceed
//  729 the Rx memory uper-bound of socket.
//  730 *********************************************************************
//  731 */
//  732 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  733 void read_data(uint32 nUSE, SOCKET s, vuint8 * src, vuint8 * dst, uint16 len)
//  734 {
read_data:
        PUSH     {R3-R9,LR}
        MOV      R6,R0
        MOV      R7,R3
        LDR      R4,[SP, #+32]
//  735 	uint16 size;
//  736 	uint32 src_mask;
//  737 	uint8 *src_ptr;
//  738 
//  739 	src_mask = (uint32)src & getIINCHIP_RxMASK(nUSE, s);
        MOV      R9,R1
        LDR.N    R0,??DataTable7_6
        ADDS     R1,R0,R6, LSL #+4
        ADD      R1,R1,R9, LSL #+2
        LDR      R1,[R1, #+64]
        ANDS     R2,R1,R2
//  740 	src_ptr =  (uint8 *)(getIINCHIP_RxBASE(nUSE, s) + src_mask);
        LDR.N    R1,??DataTable7_7
        ADD      R8,R1,R6, LSL #+4
        LDR      R1,[R8, R9, LSL #+2]
        ADDS     R1,R2,R1
        ADD      R0,R0,R6, LSL #+3
        ADD      R0,R0,R9, LSL #+1
        LDRH     R0,[R0, #+16]
        UXTH     R4,R4
        ADDS     R3,R4,R2
        CMP      R0,R3
        BCS.N    ??read_data_0
//  741 	
//  742 	if( (src_mask + len) > getIINCHIP_RxMAX(nUSE, s) ) 
//  743 	{
//  744 		size = getIINCHIP_RxMAX(nUSE, s) - src_mask;
        SUBS     R0,R0,R2
        UXTH     R5,R0
//  745 		wiz_read_buf(nUSE, (uint32)src_ptr, (uint8*)dst, size);
        MOV      R3,R5
        MOV      R2,R7
        MOV      R0,R6
        BL       wiz_read_buf
//  746 		dst += size;
//  747 		size = len - size;
//  748 		src_ptr = (uint8 *)(getIINCHIP_RxBASE(nUSE, s));
//  749 		wiz_read_buf(nUSE, (uint32)src_ptr, (uint8*) dst,size);
        SUBS     R3,R4,R5
        UXTH     R3,R3
        ADDS     R2,R5,R7
        LDR      R1,[R8, R9, LSL #+2]
        B.N      ??read_data_1
//  750 	} 
//  751 	else
//  752 	{
//  753 		wiz_read_buf(nUSE, (uint32)src_ptr, (uint8*) dst,len);
??read_data_0:
        MOV      R3,R4
        MOV      R2,R7
??read_data_1:
        MOV      R0,R6
        ADD      SP,SP,#+4
        POP      {R4-R9,LR}
        B.N      wiz_read_buf
//  754 	}
//  755 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     0x40003800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7_1:
        DC32     0x40013000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7_2:
        DC32     0x40010800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7_3:
        DC32     0x40010c04

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7_4:
        DC32     0x40010c0c

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7_5:
        DC32     0x4001080c

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7_6:
        DC32     SSIZE

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7_7:
        DC32     RBUFBASEADDRESS
//  756 
//  757 #if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_SPI_MODE__)
//  758 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  759 uint16 IINCHIP_SpiSendData(uint32 nUSE, uint8 Comm)
//  760 {
IINCHIP_SpiSendData:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
//  761 	INT8U rtry = 0xff;
        MOVS     R6,#+255
//  762 	SPI_TypeDef *nBASE = SPI_BASE(nUSE);
        BL       SPI_BASE
//  763 	nBASE = nBASE;
//  764 	
//  765 	while(rtry-- && SPI_I2S_GetFlagStatus(SPI_BASE(nUSE), SPI_I2S_FLAG_TXE) == RESET);
??IINCHIP_SpiSendData_0:
        MOV      R0,R6
        SUBS     R6,R0,#+1
        UXTB     R0,R0
        CBZ.N    R0,??IINCHIP_SpiSendData_1
        MOV      R0,R4
        BL       SPI_BASE
        MOVS     R1,#+2
        BL       SPI_I2S_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??IINCHIP_SpiSendData_0
//  766 	// Send SPI2 data
//  767 	SPI_I2S_SendData(SPI_BASE(nUSE), Comm);
??IINCHIP_SpiSendData_1:
        MOV      R0,R4
        BL       SPI_BASE
        MOV      R1,R5
        BL       SPI_I2S_SendData
//  768 	// Wait to receive a byte
//  769   	while(rtry-- && SPI_I2S_GetFlagStatus(SPI_BASE(nUSE), SPI_I2S_FLAG_RXNE) == RESET);
??IINCHIP_SpiSendData_2:
        MOV      R0,R6
        SUBS     R6,R0,#+1
        UXTB     R0,R0
        CBZ.N    R0,??IINCHIP_SpiSendData_3
        MOV      R0,R4
        BL       SPI_BASE
        MOVS     R1,#+1
        BL       SPI_I2S_GetFlagStatus
        CMP      R0,#+0
        BEQ.N    ??IINCHIP_SpiSendData_2
//  770 	// Return the byte read from the SPI bus
//  771 	return SPI_I2S_ReceiveData(SPI_BASE(nUSE));
??IINCHIP_SpiSendData_3:
        MOV      R0,R4
        BL       SPI_BASE
        POP      {R4-R6,LR}
        B.W      SPI_I2S_ReceiveData
//  772 }

        END
//  773 #endif
//  774 
//  775 
//  776 #ifdef __DEF_IINCHIP_PPP__
//  777 
//  778 /*
//  779 * make PPPoE connection
//  780 * return :
//  781 * 1 => success to connect
//  782 * 2 => Auth fail
//  783 * 3 => timeout
//  784 * 4 => Auth type not support
//  785 */
//  786 #define PPP_OPTION_BUF_LEN 64
//  787 uint8 pppinit_in(uint32 nUSE, uint8 * id, uint8 idlen, uint8 * passwd, uint8 passwdlen);
//  788 
//  789 uint8 pppinit(uint32 nUSE, uint8 * id, uint8 idlen, uint8 * passwd, uint8 passwdlen)
//  790 {
//  791 	uint8 ret;
//  792 	uint8 isr;
//  793 	
//  794 	// PHASE0. W3150A+ PPPoE(ADSL) setup
//  795 	// enable pppoe mode
//  796 	dprintf("-- PHASE 0. W3150A+ PPPoE(ADSL) setup process --\r\n");
//  797 	dprintf("\r\n");
//  798 	setMR(nUSE, INCHIP_READ(MR) | MR_PPPOE);
//  799 
//  800 	// open socket in pppoe mode
//  801 	isr = getSn_IR(nUSE, 0);// first clear isr(0), W3150A+ at present time
//  802 	setSn_IR(nUSE, 0, isr);
//  803 	
//  804 	IINCHIP_WRITE(nUSE, PTIMER, 200); // 5sec timeout
//  805 	IINCHIP_WRITE(nUSE, PMAGIC, 0x01); // magic number
//  806 	IINCHIP_WRITE(nUSE, Sn_MR(nUSE, 0),Sn_MR_PPPOE);
//  807 	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0),Sn_CR_OPEN);
//  808 
//  809 	/* +200804[woong]:wait to process the command... */
//  810 	while( IINCHIP_READ(nUSE, Sn_CR(nUSE, 0)) );
//  811 	/* ------- */
//  812 	
//  813 	ret = pppinit_in(nUSE, id, idlen, passwd, passwdlen);
//  814 
//  815 	// close ppp connection socket
//  816 	/* m200804 [woong]*/
//  817 	close(0);
//  818 	/* --------- */
//  819 	
//  820 	return ret;
//  821 }
//  822 
//  823 uint8 pppinit_in(uint32 nUSE, uint8 * id, uint8 idlen, uint8 * passwd, uint8 passwdlen)
//  824 {
//  825 	uint8 loop_idx = 0;
//  826 	uint8 isr = 0;
//  827 	uint8 buf[PPP_OPTION_BUF_LEN];
//  828 	uint16 len;
//  829 	uint8 str[PPP_OPTION_BUF_LEN];
//  830 	uint8 str_idx,dst_idx;
//  831 
//  832    // PHASE1. PPPoE Discovery
//  833 	// start to connect pppoe connection
//  834 	dprintf("-- PHASE 1. PPPoE Discovery process --");
//  835 	dprintf(" ok\r\n");
//  836 	dprintf("\r\n");
//  837 	IINCHIP_WRITE(nUSE, Sn_CR(nUSE, 0), Sn_CR_PCON);
//  838 	/* +200804[woong]:wait to process the command... */
//  839 	while(IINCHIP_READ(nUSE, Sn_CR(nUSE, 0)));
//  840 	/* ------- */
//  841 
//  842 	wait_10ms(100);  // you should make delay function.
//  843 
//  844 	loop_idx = 0;
//  845 	//check whether PPPoE discovery end or not
//  846 	while (!(getSn_IR(nUSE, 0) & Sn_IR_PNEXT))
//  847 	{
//  848 		dprintf(".");
//  849 		if (loop_idx++ == 10) // timeout
//  850 		{
//  851 			dprintf("timeout before LCP\r\n"); 
//  852 			return 3;
//  853 		}
//  854 		wait_10ms(100);
//  855 	}
//  856 
//  857   /* +200804[woong] clear interrupt value*/
//  858    IINCHIP_WRITE(nUSE, Sn_IR(nUSE, 0), 0xff);
//  859    /*---*/
//  860    
//  861    // PHASE2. LCP process
//  862 	dprintf("-- PHASE 2. LCP process --");
//  863 		
//  864 	// send LCP Request
//  865 	{
//  866 		// Magic number option
//  867 		// option format (type value + length value + data)
//  868 	   // write magic number value
//  869 		buf[0] = 0x05; // type value
//  870 		buf[1] = 0x06; // length value
//  871 		buf[2] = 0x01; buf[3] = 0x01; buf[4] = 0x01; buf[5]= 0x01; // data
//  872 		// for MRU option, 1492 0x05d4  
//  873 		// buf[6] = 0x01; buf[7] = 0x04; buf[8] = 0x05; buf[9] = 0xD4;
//  874 	}
//  875 	send_data_processing(0, buf, 0x06);
//  876 	IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); // send request 
//  877 
//  878 	/* +200804[woong]:wait to process the command... */
//  879 	while( IINCHIP_READ(Sn_CR(0)) );
//  880 	/* ------- */
//  881 
//  882 	wait_10ms(100);
//  883 
//  884 	while (!((isr = getSn_IR(0)) & Sn_IR_PNEXT))
//  885 	{
//  886 		if (isr & Sn_IR_PRECV) // Not support option
//  887 		{
//  888 		/* +200801[bj] clear interrupt value*/
//  889 		IINCHIP_WRITE(Sn_IR(0), Sn_IR_PRECV);
//  890 		/*---*/
//  891 
//  892 		len = getSn_RX_RSR(0);
//  893 	      	if ( len > 0 )
//  894 		      	{
//  895 		      		recv_data_processing(0, str, len);
//  896 		      		IINCHIP_WRITE(Sn_CR(0),Sn_CR_RECV);
//  897 				/* +200804[woong]:wait to process the command... */
//  898 				while( IINCHIP_READ(Sn_CR(0)) );
//  899 				/* ------- */
//  900 
//  901 	   			// for debug
//  902 	   			//dprintf("LCP proc\r\n"); for (i = 0; i < len; i++) dprintf ("%02x ", str[i]); dprintf("\r\n");
//  903 	   			// get option length
//  904 	   			len = str[4]; len = ((len & 0x00ff) << 8) + str[5];
//  905 	   			len += 2;
//  906 	   			str_idx = 6; dst_idx = 0; // ppp header is 6 byte, so starts at 6.
//  907 	   			do 
//  908 	   			{
//  909 	   				if ((str[str_idx] == 0x01) || (str[str_idx] == 0x02) || (str[str_idx] == 0x03) || (str[str_idx] == 0x05))
//  910 	   				{
//  911 	   					// skip as length of support option. str_idx+1 is option's length.
//  912 	   					str_idx += str[str_idx+1];
//  913 	   				}
//  914 	   				else
//  915 	   				{
//  916 	   					// not support option , REJECT
//  917 	   					memcpy((uint8 *)(buf+dst_idx), (uint8 *)(str+str_idx), str[str_idx+1]);
//  918 	   					dst_idx += str[str_idx+1]; str_idx += str[str_idx+1];
//  919 	   				}
//  920 	   			} while (str_idx != len);
//  921 	   			// for debug
//  922 	   			// dprintf("LCP dst proc\r\n"); for (i = 0; i < dst_idx; i++) dprintf ("%02x ", dst[i]); dprintf("\r\n");
//  923 	   
//  924 	   			// send LCP REJECT packet
//  925 	   			send_data_processing(0, buf, dst_idx);
//  926 	   			IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCJ);
//  927 				/* +200804[woong]:wait to process the command... */
//  928 				while( IINCHIP_READ(Sn_CR(0)) );
//  929 				/* ------- */
//  930 
//  931 		      	}
//  932 		}
//  933 		dprintf(".");
//  934 		if (loop_idx++ == 10) // timeout
//  935 		{
//  936 			dprintf("timeout after LCP\r\n");
//  937 			return 3;
//  938 		}
//  939 		wait_10ms(100);
//  940 	}
//  941 	dprintf(" ok\r\n");
//  942 	dprintf("\r\n");
//  943 
//  944 	/* +200804[woong] clear interrupt value*/
//  945 	IINCHIP_WRITE(Sn_IR(0), 0xff);
//  946 	/*---*/
//  947 	
//  948 	dprintf("-- PHASE 3. PPPoE(ADSL) Authentication mode --\r\n");
//  949 	dprintf("Authentication protocol : %.2x %.2x, ", IINCHIP_READ(PATR0), IINCHIP_READ(PATR0+1));
//  950 
//  951 	loop_idx = 0;
//  952 	if (IINCHIP_READ(PATR0) == 0xc0 && IINCHIP_READ(PATR0+1) == 0x23)
//  953 	{
//  954 		dprintf("PAP\r\n"); // in case of adsl normally supports PAP.
//  955 		// send authentication data
//  956 		// copy (idlen + id + passwdlen + passwd)
//  957 		buf[loop_idx] = idlen; loop_idx++;
//  958 		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(id), idlen); loop_idx += idlen;
//  959 		buf[loop_idx] = passwdlen; loop_idx++;
//  960 		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(passwd), passwdlen); loop_idx += passwdlen;
//  961 		send_data_processing(0, buf, loop_idx);
//  962 		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR);
//  963 		/* +200804[woong]:wait to process the command... */
//  964 		while( IINCHIP_READ(Sn_CR(0)) );
//  965 		/* ------- */
//  966 
//  967 		wait_10ms(100);
//  968 	}
//  969 	
//  970 	else if (IINCHIP_READ(PATR0) == 0xc2 && IINCHIP_READ(PATR0+1) == 0x23)
//  971 	{
//  972 		uint8 chal_len;
//  973    		md5_ctx context;
//  974 	   	uint8  digest[16];
//  975 
//  976 		len = getSn_RX_RSR(0);
//  977    		if ( len > 0 )
//  978 	   	{
//  979 	   		recv_data_processing(0, str, len);
//  980 	   		IINCHIP_WRITE(Sn_CR(0),Sn_CR_RECV);
//  981 			/* +200804[woong]:wait to process the command... */
//  982 			while( IINCHIP_READ(Sn_CR(0)) );
//  983 			/* ------- */
//  984 
//  985 #ifdef __DEF_IINCHIP_DBG__
//  986 			dprintf("recv CHAP\r\n");
//  987 			int16 i;
//  988 			for (i = 0; i < 32; i++) dprintf ("%02x ", str[i]);
//  989 			dprintf("\r\n");
//  990 #endif
//  991 	// str is C2 23 xx CHAL_ID xx xx CHAP_LEN CHAP_DATA
//  992 	// index  0  1  2  3       4  5  6        7 ...
//  993 
//  994 	   		memset(buf,0x00,64);
//  995 	   		buf[loop_idx] = str[3]; loop_idx++; // chal_id
//  996 	   		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(passwd), passwdlen); loop_idx += passwdlen; //passwd
//  997 	   		chal_len = str[6]; // chal_id
//  998 	   		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(str+7), chal_len); loop_idx += chal_len; //challenge
//  999 			   buf[loop_idx] = 0x80;
// 1000 #ifdef __DEF_IINCHIP_DBG__
// 1001 			dprintf("CHAP proc d1\r\n");
// 1002 			//int16 i;
// 1003 			for (i = 0; i < 64; i++) dprintf ("%02x ", buf[i]);
// 1004 			dprintf("\r\n");
// 1005 #endif
// 1006 
// 1007 	   		md5_init(&context);
// 1008 	   		md5_update(&context, buf, loop_idx);
// 1009 	   		md5_final(digest, &context);
// 1010 
// 1011 #ifdef __DEF_IINCHIP_DBG__
// 1012 			dprintf("CHAP proc d1\r\n");
// 1013 			for (i = 0; i < 16; i++) dprintf ("%02x", digest[i]);
// 1014 			dprintf("\r\n");
// 1015 #endif
// 1016 	   		loop_idx = 0;
// 1017 	   		buf[loop_idx] = 16; loop_idx++; // hash_len
// 1018 	     		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(digest), 16); loop_idx += 16; // hashed value
// 1019 	     		memcpy((uint8 *)(buf+loop_idx), (uint8 *)(id), idlen); loop_idx += idlen; // id
// 1020 	   		send_data_processing(0, buf, loop_idx);
// 1021 	   		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR);
// 1022 			/* +200804[woong]:wait to process the command... */
// 1023 			while( IINCHIP_READ(Sn_CR(0)) );
// 1024 			/* ------- */
// 1025 
// 1026 	   		wait_10ms(100);
// 1027 	      }
// 1028    }
// 1029 
// 1030 	else
// 1031 	{
// 1032 		dprintf("Not support\r\n");
// 1033 #ifdef __DEF_IINCHIP_DBG__
// 1034 		dprintf("Not support PPP Auth type: %.2x%.2x\r\n",IINCHIP_READ(PATR0), IINCHIP_READ(PATR0+1));
// 1035 #endif
// 1036 		return 4;
// 1037 	}
// 1038 	dprintf("\r\n");
// 1039 
// 1040 	dprintf("-- Waiting for PPPoE server's admission --");
// 1041 	loop_idx = 0;
// 1042 	while (!((isr = getSn_IR(0)) & Sn_IR_PNEXT))
// 1043 	{
// 1044 		if (isr & Sn_IR_PFAIL)
// 1045 		{
// 1046 		   	/* +200804[woong] clear interrupt value*/
// 1047 		   	IINCHIP_WRITE(Sn_IR(0), 0xff);
// 1048 		   	/*---*/
// 1049 
// 1050 			dprintf("failed\r\nReinput id, password..\r\n");
// 1051 			return 2;
// 1052 		}
// 1053 		dprintf(".");
// 1054 		if (loop_idx++ == 10) // timeout
// 1055 		{
// 1056 		   	/* +200804[woong] clear interrupt value*/
// 1057 		   	IINCHIP_WRITE(Sn_IR(0), 0xff);
// 1058 		   	/*---*/
// 1059 
// 1060 			dprintf("timeout after PAP\r\n");
// 1061 			return 3;
// 1062 		}
// 1063 		wait_10ms(100);
// 1064 	}
// 1065 
// 1066    	/* +200804[woong] clear interrupt value*/
// 1067    	IINCHIP_WRITE(Sn_IR(0), 0xff);
// 1068    	/*---*/
// 1069 	dprintf("ok\r\n");
// 1070 	dprintf("\r\n");
// 1071 	dprintf("-- PHASE 4. IPCP process --");
// 1072 	// IP Address
// 1073 	buf[0] = 0x03; buf[1] = 0x06; buf[2] = 0x00; buf[3] = 0x00; buf[4] = 0x00; buf[5] = 0x00;
// 1074 	send_data_processing(0, buf, 6);
// 1075 	IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR);
// 1076 	/* +200804[woong]:wait to process the command... */
// 1077 	while( IINCHIP_READ(Sn_CR(0)) );
// 1078 	/* ------- */
// 1079 
// 1080 	wait_10ms(100);
// 1081 
// 1082 	loop_idx = 0;
// 1083 	while (1)
// 1084 	{
// 1085 		if (getSn_IR(0) & Sn_IR_PRECV)
// 1086 		{
// 1087 		/* +200804[woong] clear interrupt value*/
// 1088 		IINCHIP_WRITE(Sn_IR(0), 0xff);
// 1089 		/*---*/
// 1090 		len = getSn_RX_RSR(0);
// 1091 	      	if ( len > 0 )
// 1092 		      	{
// 1093 		      		recv_data_processing(0, str, len);
// 1094 		      		IINCHIP_WRITE(Sn_CR(0),Sn_CR_RECV);
// 1095 				/* +200804[woong]:wait to process the command... */
// 1096 				while( IINCHIP_READ(Sn_CR(0)) );
// 1097 				/* ------- */
// 1098 	   			//for debug
// 1099 	   			//dprintf("IPCP proc\r\n"); for (i = 0; i < len; i++) dprintf ("%02x ", str[i]); dprintf("\r\n");
// 1100 	   			str_idx = 6; dst_idx = 0;
// 1101 	   			if (str[2] == 0x03) // in case of NAK
// 1102 		   			{
// 1103 		   				do 
// 1104 		   				{
// 1105 		   					if (str[str_idx] == 0x03) // request only ip information
// 1106 		   					{
// 1107 		   						memcpy((uint8 *)(buf+dst_idx), (uint8 *)(str+str_idx), str[str_idx+1]);
// 1108 		   						dst_idx += str[str_idx+1]; str_idx += str[str_idx+1];
// 1109 		   					}
// 1110 		   					else
// 1111 		   					{
// 1112 		   						// skip byte
// 1113 		   						str_idx += str[str_idx+1];
// 1114 		   					}
// 1115 		   					// for debug
// 1116 		   					//dprintf("s: %d, d: %d, l: %d", str_idx, dst_idx, len);
// 1117 		   				} while (str_idx != len);
// 1118 		   				send_data_processing(0, buf, dst_idx);
// 1119 		   				IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); // send ipcp request
// 1120 		   				/* +200804[woong]:wait to process the command... */
// 1121 						while( IINCHIP_READ(Sn_CR(0)) );
// 1122 						/* ------- */
// 1123 		   				wait_10ms(100);
// 1124 		   				break;
// 1125 		   			}
// 1126 		      	}
// 1127 		}
// 1128 		dprintf(".");
// 1129 		if (loop_idx++ == 10) // timeout
// 1130 		{
// 1131 			dprintf("timeout after IPCP\r\n");
// 1132 			return 3;
// 1133 		}
// 1134 		wait_10ms(100);
// 1135 		send_data_processing(0, buf, 6);
// 1136 		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); //ipcp re-request
// 1137 		/* +200804[woong]:wait to process the command... */
// 1138 		while( IINCHIP_READ(Sn_CR(0)) );
// 1139 		/* ------- */
// 1140 
// 1141 	}
// 1142 
// 1143 	loop_idx = 0;
// 1144 	while (!(getSn_IR(0) & Sn_IR_PNEXT))
// 1145 	{
// 1146 		dprintf(".");
// 1147 		if (loop_idx++ == 10) // timeout
// 1148 		{
// 1149 			dprintf("timeout after IPCP NAK\r\n");
// 1150 			return 3;
// 1151 		}
// 1152 		wait_10ms(100);
// 1153 		IINCHIP_WRITE(Sn_CR(0),Sn_CR_PCR); // send ipcp request
// 1154 		/* +200804[woong]:wait to process the command... */
// 1155 		while( IINCHIP_READ(Sn_CR(0)) );
// 1156 		/* ------- */
// 1157 	}
// 1158 	/* +200804[woong] clear interrupt value*/
// 1159 	IINCHIP_WRITE(Sn_IR(0), 0xff);
// 1160 	/*---*/
// 1161 	dprintf("ok\r\n");
// 1162 	dprintf("\r\n");
// 1163 	return 1;
// 1164 	// after this function, User must save the pppoe server's mac address and pppoe session id in current connection
// 1165 }
// 1166 
// 1167 /*
// 1168 * terminate PPPoE connection
// 1169 */
// 1170 uint8 pppterm(uint8 * mac, uint8 * sessionid)
// 1171 {
// 1172 	uint16 i;
// 1173 	uint8 isr;
// 1174 #ifdef __DEF_IINCHIP_DBG__
// 1175 	dprintf("pppterm()\r\n");
// 1176 #endif
// 1177 	/* Set PPPoE bit in MR(Common Mode Register) : enable socket0 pppoe */
// 1178 	setMR(IINCHIP_READ(MR) | MR_PPPOE);
// 1179 	
// 1180 	// write pppoe server's mac address and session id 
// 1181 	// must be setted these value.
// 1182 	for (i = 0; i < 6; i++) IINCHIP_WRITE((Sn_DHAR0(0)+i),mac[i]);
// 1183 	for (i = 0; i < 2; i++) IINCHIP_WRITE((Sn_DPORT0(0)+i),sessionid[i]);
// 1184 	isr = getSn_IR(0);
// 1185 	setSn_IR(0, isr);
// 1186 	
// 1187 	//open socket in pppoe mode
// 1188 	IINCHIP_WRITE(Sn_MR(0),Sn_MR_PPPOE);
// 1189 	IINCHIP_WRITE(Sn_CR(0),Sn_CR_OPEN);
// 1190 	/* +200804[woong]:wait to process the command... */
// 1191 	while( IINCHIP_READ(Sn_CR(0)) );
// 1192 	/* ------- */
// 1193 	wait_1us(1);
// 1194 	// close pppoe connection
// 1195 	IINCHIP_WRITE(Sn_CR(0),Sn_CR_PDISCON);
// 1196 	/* +200804[woong]:wait to process the command... */
// 1197 	while( IINCHIP_READ(Sn_CR(0)) );
// 1198 	/* ------- */
// 1199 	wait_10ms(100);
// 1200 	// close socket. m200804[woong]
// 1201 	close(0);
// 1202 
// 1203 #ifdef __DEF_IINCHIP_DBG__
// 1204 	dprintf("pppterm() end ..\r\n");
// 1205 #endif
// 1206 
// 1207 	return 1;
// 1208 }
// 1209 
// 1210 
// 1211 #endif
// 
//   168 bytes in section .bss
// 2 310 bytes in section .text
// 
// 2 310 bytes of CODE memory
//   168 bytes of DATA memory
//
//Errors: none
//Warnings: none
