///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    23/Aug/2012  00:33:43 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_Tab /
//                    le.c                                                    /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_Tab /
//                    le.c -lcN C:\user\project\FR-SSR\fw\appl_ssr_20120717\s /
//                    out\ -lB C:\user\project\FR-SSR\fw\appl_ssr_20120717\so /
//                    ut\ -o C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout /
//                    \ --endian=little --cpu=Cortex-M3 -e                    /
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
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\aa_Tab /
//                    le.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME aa_Table

        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN RoadBackuptobuffer
        EXTERN SioDataAckTx
        EXTERN WriteBuffertoBackup
        EXTERN WriteEEprom

        PUBLIC DefaultTableSet
        PUBLIC LoadTable
        PUBLIC ReadPwrTableAscending
        PUBLIC ReadPwrTableRmt
        PUBLIC Response_Table
        PUBLIC TableIndexBackup
        PUBLIC m_PLL_TEMP_3G
        PUBLIC m_PLL_TEMP_LTE
        PUBLIC m_RX_ATTN_3G
        PUBLIC m_RX_ATTN_LTE
        PUBLIC m_RX_TABLE_3G
        PUBLIC m_RX_TABLE_LTE
        PUBLIC m_RX_TEMP_ATTN_3G
        PUBLIC m_RX_TEMP_ATTN_LTE
        PUBLIC m_SLEEP_TABLE_3G
        PUBLIC m_SLEEP_TABLE_LTE
        PUBLIC m_TX_ATTN_3G
        PUBLIC m_TX_ATTN_LTE
        PUBLIC m_TX_TABLE_3G
        PUBLIC m_TX_TABLE_LTE
        PUBLIC m_TX_TEMP_ATTN_3G
        PUBLIC m_TX_TEMP_ATTN_LTE
        PUBLIC tmplimit

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\code\aa_Table.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : fsmc_sram.h
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.2
//    5 * Date               : 07/11/2008
//    6 * Description        : Header for fsmc_sram.c file.
//    7 ********************************************************************************
//    8 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//    9 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   10 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   11 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   12 * CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   13 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   14 *******************************************************************************/
//   15 #define TABLE_C
//   16 
//   17 #include "../include/main.h"

        SECTION `.rodata`:CONST:NOROOT(2)
// __absolute unsigned short const m_RX_TABLE_3G[66]
m_RX_TABLE_3G:
        DATA
        DC16 65526, 62, 0, 13, 26, 40, 53, 67, 80, 93, 107, 120, 134, 147, 160
        DC16 174, 187, 201, 214, 227, 241, 254, 268, 281, 294, 308, 321, 335
        DC16 348, 361, 375, 385, 395, 405, 415, 424, 434, 444, 454, 464, 474
        DC16 485, 496, 507, 518, 529, 539, 550, 561, 572, 583, 592, 602, 611
        DC16 621, 630, 640, 649, 658, 668, 677, 682, 684, 699, 716, 727
// __absolute unsigned short const m_SLEEP_TABLE_3G[33]
m_SLEEP_TABLE_3G:
        DC16 65526, 62, 35, 37, 38, 42, 44, 47, 50, 55, 59, 63, 68, 73, 78, 83
        DC16 88, 91, 91, 91, 91, 91, 91, 91, 91, 91, 91, 91, 91, 91, 91, 91, 91
        DC8 0, 0
// __absolute unsigned short const m_TX_TABLE_3G[33]
m_TX_TABLE_3G:
        DC16 65526, 62, 41, 46, 51, 57, 62, 68, 77, 86, 95, 104, 114, 129, 144
        DC16 159, 174, 189, 215, 241, 267, 293, 319, 355, 397, 444, 454, 463
        DC16 473, 483, 492, 502, 512
        DC8 0, 0
// __absolute unsigned short const m_RX_TABLE_LTE[66]
m_RX_TABLE_LTE:
        DC16 65526, 62, 0, 12, 24, 36, 49, 61, 73, 86, 98, 110, 122, 135, 147
        DC16 159, 172, 184, 196, 209, 221, 233, 245, 258, 270, 282, 295, 307
        DC16 319, 332, 344, 355, 366, 377, 387, 398, 409, 420, 431, 442, 453
        DC16 463, 474, 484, 495, 505, 515, 526, 536, 547, 557, 566, 575, 584
        DC16 593, 602, 611, 620, 629, 637, 646, 654, 654, 669, 681, 696
// __absolute unsigned short const m_SLEEP_TABLE_LTE[33]
m_SLEEP_TABLE_LTE:
        DC16 65526, 62, 34, 36, 37, 38, 40, 42, 45, 47, 50, 54, 57, 61, 65, 70
        DC16 75, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77
        DC8 0, 0
// __absolute unsigned short const m_TX_TABLE_LTE[32]
m_TX_TABLE_LTE:
        DC16 65526, 62, 50, 57, 64, 71, 78, 85, 96, 108, 119, 131, 143, 161
        DC16 180, 198, 217, 236, 270, 303, 337, 371, 405, 451, 503, 562, 599
        DC16 635, 672, 709, 745, 782
// __absolute unsigned short const m_TX_ATTN_LTE[34]
m_TX_ATTN_LTE:
        DC16 65526, 62, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28
        DC16 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62
// __absolute unsigned short const m_RX_ATTN_LTE[34]
m_RX_ATTN_LTE:
        DC16 65526, 62, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28
        DC16 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62
// __absolute unsigned short const m_TX_ATTN_3G[34]
m_TX_ATTN_3G:
        DC16 65526, 62, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28
        DC16 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62
// __absolute unsigned short const m_RX_ATTN_3G[34]
m_RX_ATTN_3G:
        DC16 65526, 62, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28
        DC16 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62
// __absolute unsigned short const m_TX_TEMP_ATTN_LTE[48]
m_TX_TEMP_ATTN_LTE:
        DC16 65526, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0
// __absolute unsigned short const m_RX_TEMP_ATTN_LTE[48]
m_RX_TEMP_ATTN_LTE:
        DC16 65526, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0
// __absolute unsigned short const m_TX_TEMP_ATTN_3G[48]
m_TX_TEMP_ATTN_3G:
        DC16 65526, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0
// __absolute unsigned short const m_RX_TEMP_ATTN_3G[48]
m_RX_TEMP_ATTN_3G:
        DC16 65526, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0
// __absolute unsigned short const m_PLL_TEMP_LTE[48]
m_PLL_TEMP_LTE:
        DC16 65526, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0
// __absolute unsigned short const m_PLL_TEMP_3G[46]
m_PLL_TEMP_3G:
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC16 0, 0

        SECTION `.bss`:DATA:NOROOT(0)
// __absolute INT8U tmplimit
tmplimit:
        DS8 1
//   18 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   19 void LoadTable(void)
//   20 {
//   21 /*********************
//   22 	INT32U i = 0;
//   23 	INT8U *dptr = (INT8U *)OutputTable;
//   24 
//   25 	for(i = 0; i < sizeof(__OutputTable); i++)
//   26 	{
//   27 		*dptr++ = ReadEEprom(TableBp + i);
//   28 	}
//   29 
//   30 	dptr = (INT8U *)AttnTable;
//   31 
//   32 	for(i = 0; i < sizeof(AttnTable); i++)
//   33 	{
//   34 		*dptr++ = ReadEEprom(AttnTableBp + i);
//   35 	}
//   36 *********************/	
//   37 }
LoadTable:
        BX       LR               ;; return
//   38 
//   39 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   40 void Response_Table(__ProtocolPtr *nPtr)
//   41 {
Response_Table:
        PUSH     {R2-R10,LR}
        MOV      R4,R0
//   42 	INT8S tIndex = 0;
//   43 	INT32U i = 0;
//   44 	INT32U tbllen = TableMAX62*2L;		//, mlen = 0;
//   45 	
//   46 	SIO *Recv = nPtr->Recv;
        LDR      R5,[R4, #+36]
//   47 	SIO *Send = nPtr->Send;
        LDR      R6,[R4, #+40]
//   48 
//   49 	INT8U *tblptr;
//   50 	
//   51 	INT32U cpu_sr;
//   52 
//   53 	//Comm = rBodyFrame->Command;
//   54 	tIndex = Recv->Data[0];
        LDRSB    R7,[R5, #+9]
//   55 
//   56 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//   57 
//   58 	if(tIndex == 22 || tIndex == 23)
        CMP      R7,#+22
        BEQ.N    ??Response_Table_1
        CMP      R7,#+23
        BNE.N    ??Response_Table_2
//   59 	{
//   60 		EE_BACK1 *tptr;
//   61 
//   62 		tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // load flash data!!
??Response_Table_1:
        LDR.W    R10,??DataTable2  ;; 0x8006000
        MOV      R0,R10
        BL       RoadBackuptobuffer
//   63 
//   64 		switch(tIndex)
        CMP      R7,#+22
        BEQ.N    ??Response_Table_3
        CMP      R7,#+23
        IT       EQ 
        ADDWEQ   R9,R0,#+196
        B.N      ??Response_Table_4
//   65 		{
//   66 			case 22:
//   67 				tblptr = (INT8U *)tptr->BackUp.TempPllTable1;
??Response_Table_3:
        ADDW     R9,R0,#+68
//   68 			break;
//   69 
//   70 			case 23:
//   71 				tblptr = (INT8U *)tptr->BackUp.TempPllTable2;
//   72 			break;
//   73 		}
//   74 		
//   75 		if(Recv->Command == DTableStsRQST)
??Response_Table_4:
        LDRB     R0,[R5, #+6]
        CMP      R0,#+180
        BNE.N    ??Response_Table_5
//   76 		{
//   77 			Send->Command = DTableStsRSPS;
??Response_Table_6:
        MOVS     R0,#+181
        STRB     R0,[R6, #+6]
        B.N      ??Response_Table_7
//   78 		}
//   79 		else if(Recv->Command == DTableSetRQST)
//   80 		{
//   81 			Send->Command = DTableSetRSPS;
//   82 			for(i = 0; i < tbllen; i++) tblptr[i] = Recv->Data[i+1];
//   83 			WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_TABLE));
//   84 		}
//   85 	}
//   86 	else {
//   87 		EE_TABLE *tptr;
//   88 
//   89 		tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // load flash data!!
??Response_Table_2:
        LDR.W    R10,??DataTable2_1  ;; 0x8005800
        MOV      R0,R10
        BL       RoadBackuptobuffer
//   90 
//   91 		switch(tIndex)
        CMP      R7,#+21
        BHI.N    ??Response_Table_8
        TBB      [PC, R7]
        DATA
??Response_Table_0:
        DC8      0xB,0x68,0x3B,0x68
        DC8      0x3E,0x68,0x41,0x68
        DC8      0x44,0x47,0x68,0x68
        DC8      0x4A,0x4D,0x50,0x53
        DC8      0x56,0x59,0x5C,0x5F
        DC8      0x62,0x65
        THUMB
//   92 		{
//   93 			case 0:
//   94 				tblptr = (INT8U *)tptr->Table.FwdPowerTable1;
??Response_Table_9:
        ADD      R9,R0,#+2
//   95 			break;
//   96 
//   97 			case 2:
//   98 				tblptr = (INT8U *)tptr->Table.RvsPowerTable1;
//   99 			break;
//  100 			
//  101 			case 4:
//  102 				tblptr = (INT8U *)tptr->Table.FwdPowerTable2;
//  103 			break;
//  104 
//  105 			case 6:
//  106 				tblptr = (INT8U *)tptr->Table.RvsPowerTable2;
//  107 			break;
//  108 
//  109 			case 8:
//  110 				tblptr = (INT8U *)tptr->Table.FwdTempAttnTable;
//  111 			break;
//  112 
//  113 			case 9:
//  114 				tblptr = (INT8U *)tptr->Table.RvsTempAttnTable;
//  115 			break;
//  116 
//  117 			case 12:
//  118 				tblptr = (INT8U *)tptr->Table.FwdAttnTable1;
//  119 			break;
//  120 
//  121 			case 13:
//  122 				tblptr = (INT8U *)tptr->Table.FwdAttnTable2;
//  123 			break;
//  124 
//  125 			case 14:
//  126 				tblptr = (INT8U *)tptr->Table.RvsRssiTable1;
//  127 			break;
//  128 			
//  129 			case 15:
//  130 				tblptr = (INT8U *)tptr->Table.RvsRssiTable2;
//  131 			break;
//  132 
//  133 			case 16:
//  134 				tblptr = (INT8U *)tptr->Table.FwdTempAttnTable2;
//  135 			break;
//  136 
//  137 			case 17:
//  138 				tblptr = (INT8U *)tptr->Table.RvsTempAttnTable2;
//  139 			break;
//  140 
//  141 			case 18:
//  142 				tblptr = (INT8U *)tptr->Table.RvsAttnTable1;
//  143 			break;
//  144 			
//  145 			case 19:
//  146 				tblptr = (INT8U *)tptr->Table.RvsAttnTable2;
//  147 			break;
//  148 
//  149 			case 20:
//  150 				tblptr = (INT8U *)tptr->Table.SleepLimitTable1;
//  151 			break;
//  152 			
//  153 			case 21:
//  154 				tblptr = (INT8U *)tptr->Table.SleepLimitTable2;
//  155 			break;
//  156 
//  157 			default: OS_EXIT_CRITICAL(); return;
//  158 		}
//  159 
//  160 		if(Recv->Command == DTableStsRQST)
??Response_Table_10:
        LDRB     R0,[R5, #+6]
        CMP      R0,#+180
        BEQ.N    ??Response_Table_6
//  161 		{
//  162 			Send->Command = DTableStsRSPS;
//  163 		}
//  164 		else if(Recv->Command == DTableSetRQST)
??Response_Table_5:
        CMP      R0,#+182
        BNE.N    ??Response_Table_7
//  165 		{
//  166 			Send->Command = DTableSetRSPS;
        MOVS     R0,#+183
        STRB     R0,[R6, #+6]
//  167 			for(i = 0; i < tbllen; i++) tblptr[i] = Recv->Data[i+1];
        MOV      R0,R9
        MOV      R1,R5
        MOVS     R2,#+124
??Response_Table_11:
        LDRB     R3,[R1, #+10]
        STRB     R3,[R0], #+1
        ADDS     R1,R1,#+1
        SUBS     R2,R2,#+1
        BNE.N    ??Response_Table_11
//  168 			WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
        MOVW     R1,#+2052
        MOV      R0,R10
        BL       WriteBuffertoBackup
//  169 		}
//  170 	}
//  171 
//  172 	Send->Data[0] = Recv->Data[0];
??Response_Table_7:
        LDRB     R0,[R5, #+9]
        STRB     R0,[R6, #+9]
//  173 	for(i = 0; i < tbllen; i++) Send->Data[i+1] = tblptr[i];
        MOV      R0,R6
        MOVS     R1,#+124
??Response_Table_12:
        LDRB     R2,[R9], #+1
        STRB     R2,[R0, #+10]
        ADDS     R0,R0,#+1
        SUBS     R1,R1,#+1
        BNE.N    ??Response_Table_12
//  174 
//  175 	OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  176 
//  177 	SioDataAckTx(Recv->SUBID1, Recv->SUBID2,(INT8U *)Send->Data, tbllen + 1, Send->Command, nPtr);
        STR      R4,[SP, #+4]
        LDRB     R0,[R6, #+6]
        STR      R0,[SP, #+0]
        MOVS     R3,#+125
        ADD      R2,R6,#+9
        LDRB     R1,[R5, #+5]
        LDRB     R0,[R5, #+4]
        BL       SioDataAckTx
//  178 }
??Response_Table_13:
        POP      {R0,R1,R4-R10,PC}  ;; return
??Response_Table_14:
        ADDW     R9,R0,#+130
        B.N      ??Response_Table_10
??Response_Table_15:
        ADDW     R9,R0,#+258
        B.N      ??Response_Table_10
??Response_Table_16:
        ADDW     R9,R0,#+386
        B.N      ??Response_Table_10
??Response_Table_17:
        ADDW     R9,R0,#+514
        B.N      ??Response_Table_10
??Response_Table_18:
        ADDW     R9,R0,#+642
        B.N      ??Response_Table_10
??Response_Table_19:
        ADDW     R9,R0,#+770
        B.N      ??Response_Table_10
??Response_Table_20:
        ADDW     R9,R0,#+898
        B.N      ??Response_Table_10
??Response_Table_21:
        ADDW     R9,R0,#+1026
        B.N      ??Response_Table_10
??Response_Table_22:
        ADDW     R9,R0,#+1154
        B.N      ??Response_Table_10
??Response_Table_23:
        ADDW     R9,R0,#+1282
        B.N      ??Response_Table_10
??Response_Table_24:
        ADDW     R9,R0,#+1410
        B.N      ??Response_Table_10
??Response_Table_25:
        ADDW     R9,R0,#+1538
        B.N      ??Response_Table_10
??Response_Table_26:
        ADDW     R9,R0,#+1666
        B.N      ??Response_Table_10
??Response_Table_27:
        ADDW     R9,R0,#+1794
        B.N      ??Response_Table_10
??Response_Table_28:
        ADDW     R9,R0,#+1922
        B.N      ??Response_Table_10
??Response_Table_8:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
        B.N      ??Response_Table_13
//  179 
//  180 // sptr(setup ptr)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  181 void TableIndexBackup(INT16U EEADDR, INT32U sptr, INT32U len)
//  182 {
TableIndexBackup:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//  183 
//  184 	INT32U i = 0;
//  185 	INT8U *ptr = ((INT8U *)sptr);
//  186 	INT8U verify = 0;
//  187 	
//  188 	for(i = 0; i < len; i++) 
        MOVS     R7,#+0
        CBZ.N    R6,??TableIndexBackup_0
//  189 	{
//  190 		verify = *ptr;
??TableIndexBackup_1:
        LDRB     R8,[R5, #+0]
//  191 		if(verify != (INT8U)WriteEEprom(EEADDR++, *ptr++))
        LDRB     R1,[R5], #+1
        UXTH     R0,R4
        BL       WriteEEprom
        ADDS     R4,R4,#+1
        UXTB     R0,R0
        CMP      R8,R0
        BNE.N    ??TableIndexBackup_0
//  192 		{
//  193 			#ifdef Debug_Mode
//  194 				Ser1Printf("error\n");
//  195 			#endif
//  196 			return;
//  197 		}
//  198 	}
        ADDS     R7,R7,#+1
        CMP      R7,R6
        BCC.N    ??TableIndexBackup_1
??TableIndexBackup_0:
        POP      {R4-R8,PC}       ;; return
//  199 }
//  200 
//  201 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  202 void DefaultTableSet(INT8U tmpMaker)
//  203 {
DefaultTableSet:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+28
//  204 	INT8U i = 0;
//  205 	INT32U cpu_sr;
//  206 	
//  207 	OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        STR      R0,[SP, #+24]
        LDR.N    R0,??DataTable2_1  ;; 0x8005800
//  208 
//  209 	{
//  210 		EE_TABLE *tptr;
//  211 
//  212 		tptr = (EE_TABLE *)RoadBackuptobuffer(vEE_TABLEAddr); // load flash data!!
//  213 
//  214 		for(i = 0; i < TableMAX62 + 2; i++)
        BL       RoadBackuptobuffer
        LDR.W    R8,??DataTable2_2
        ADDW     R1,R8,#+468
        STR      R1,[SP, #+20]
        ADDW     R1,R8,#+268
        STR      R1,[SP, #+16]
        ADDW     R1,R8,#+200
        STR      R1,[SP, #+12]
        STR      R8,[SP, #+8]
        ADDW     R1,R8,#+804
        STR      R1,[SP, #+4]
        ADDW     R1,R8,#+900
        STR      R1,[SP, #+0]
        ADDW     R1,R8,#+532
        ADDW     R2,R8,#+668
        ADDW     R3,R8,#+996
        ADDW     R9,R8,#+1092
        ADDW     R10,R8,#+600
        ADDW     R11,R8,#+736
        ADDW     R12,R8,#+400
        ADDW     LR,R8,#+132
        MOVS     R4,#+64
//  215 		{
//  216 			tptr->Table.FwdPowerTable1[i] = (INT16U)m_TX_TABLE_LTE[i];
??DefaultTableSet_0:
        ADD      R5,SP,#+20
        LDR      R7,[R5, #+0]
        ADDS     R6,R7,#+2
        STR      R6,[R5, #+0]
        LDRH     R5,[R7, #+0]
        STRH     R5,[R0, #+2]
//  217 			tptr->Table.RvsPowerTable1[i] = (INT16U)m_RX_TABLE_LTE[i];
        ADD      R5,SP,#+16
        LDR      R7,[R5, #+0]
        ADDS     R6,R7,#+2
        STR      R6,[R5, #+0]
        LDRH     R5,[R7, #+0]
        STRH     R5,[R0, #+130]
//  218 			tptr->Table.FwdPowerTable2[i] = (INT16U)m_TX_TABLE_3G[i];
        ADD      R5,SP,#+12
        LDR      R7,[R5, #+0]
        ADDS     R6,R7,#+2
        STR      R6,[R5, #+0]
        LDRH     R5,[R7, #+0]
        STRH     R5,[R0, #+258]
//  219 			tptr->Table.RvsPowerTable2[i] = (INT16U)m_RX_TABLE_3G[i];
        ADD      R5,SP,#+8
        LDR      R7,[R5, #+0]
        ADDS     R6,R7,#+2
        STR      R6,[R5, #+0]
        LDRH     R5,[R7, #+0]
        STRH     R5,[R0, #+386]
//  220 			tptr->Table.FwdTempAttnTable[i] = (INT16U)m_TX_TEMP_ATTN_LTE[i];
        ADD      R5,SP,#+4
        LDR      R7,[R5, #+0]
        ADDS     R6,R7,#+2
        STR      R6,[R5, #+0]
        LDRSH    R5,[R7, #+0]
        STRH     R5,[R0, #+514]
//  221 			tptr->Table.RvsTempAttnTable[i] = (INT16U)m_RX_TEMP_ATTN_LTE[i];
        ADD      R5,SP,#+0
        LDR      R7,[R5, #+0]
        ADDS     R6,R7,#+2
        STR      R6,[R5, #+0]
        LDRSH    R5,[R7, #+0]
        STRH     R5,[R0, #+642]
//  222 
//  223 			tptr->Table.FwdAttnTable1[i] = (INT16U)m_TX_ATTN_LTE[i];
        LDRSH    R5,[R1], #+2
        STRH     R5,[R0, #+770]
//  224 			tptr->Table.FwdAttnTable2[i] = (INT16U)m_TX_ATTN_3G[i];
        LDRSH    R5,[R2], #+2
        STRH     R5,[R0, #+898]
//  225 			
//  226 			tptr->Table.FwdTempAttnTable2[i] = (INT16U)m_TX_TEMP_ATTN_3G[i];
        LDRSH    R5,[R3], #+2
        STRH     R5,[R0, #+1282]
//  227 			tptr->Table.RvsTempAttnTable2[i] = (INT16U)m_RX_TEMP_ATTN_3G[i];
        LDRSH    R5,[R9], #+2
        STRH     R5,[R0, #+1410]
//  228 			
//  229 			tptr->Table.RvsAttnTable1[i] = (INT16U)m_RX_ATTN_LTE[i];
        LDRSH    R5,[R10], #+2
        STRH     R5,[R0, #+1538]
//  230 			tptr->Table.RvsAttnTable2[i] = (INT16U)m_RX_ATTN_3G[i];
        LDRSH    R5,[R11], #+2
        STRH     R5,[R0, #+1666]
//  231 
//  232 			tptr->Table.SleepLimitTable1[i] = (INT16U)m_SLEEP_TABLE_LTE[i];
        LDRH     R5,[R12], #+2
        STRH     R5,[R0, #+1794]
//  233 			tptr->Table.SleepLimitTable2[i] = (INT16U)m_SLEEP_TABLE_3G[i];
        LDRH     R5,[LR], #+2
        STRH     R5,[R0, #+1922]
//  234 		}
        ADDS     R0,R0,#+2
        SUBS     R4,R4,#+1
        BNE.N    ??DefaultTableSet_0
//  235 
//  236 		WriteBuffertoBackup(vEE_TABLEAddr, sizeof(EE_TABLE));
        MOVW     R1,#+2052
        LDR.N    R0,??DataTable2_1  ;; 0x8005800
        BL       WriteBuffertoBackup
//  237 	}
//  238 	{
//  239 		EE_BACK1 *tptr;
//  240 
//  241 		tptr = (EE_BACK1 *)RoadBackuptobuffer(vEE_BACK1Addr); // load flash data!!
//  242 
//  243 		for(i = 0; i < TableMAX62 + 2; i++){
        LDR.N    R5,??DataTable2  ;; 0x8006000
        MOV      R0,R5
        BL       RoadBackuptobuffer
        ADDW     R1,R8,#+1188
        ADDW     R2,R8,#+1284
        MOVS     R3,#+64
//  244 			tptr->BackUp.TempPllTable1[i] = (INT16U)m_PLL_TEMP_LTE[i];
??DefaultTableSet_1:
        LDRH     R6,[R1], #+2
        STRH     R6,[R0, #+68]
//  245 			tptr->BackUp.TempPllTable2[i] = (INT16U)m_PLL_TEMP_3G[i];
        LDRH     R6,[R2], #+2
        STRH     R6,[R0, #+196]
//  246 		}
        ADDS     R0,R0,#+2
        SUBS     R3,R3,#+1
        BNE.N    ??DefaultTableSet_1
//  247 		WriteBuffertoBackup(vEE_BACK1Addr, sizeof(EE_BACK1));
        MOV      R1,#+340
        MOV      R0,R5
        BL       WriteBuffertoBackup
//  248 
//  249 	}
//  250 	OS_EXIT_CRITICAL();
        LDR      R0,[SP, #+24]
        ADD      SP,SP,#+28
        POP      {R4-R11,LR}
        B.W      OS_CPU_SR_Restore
//  251 }
//  252 
//  253 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  254 INT32S ReadPwrTableRmt(INT32U AdcValue, INT8S tIndex, INT8U roundingoff, INT8U *isminval)
//  255 {
//  256   return 0;
ReadPwrTableRmt:
        MOVS     R0,#+0
        BX       LR               ;; return
//  257 }
//  258 
//  259 #if 0
//  260 INT32S ReadPwrTable(INT32U AdcValue, INT8S tIndex, INT8U roundingoff, INT8U *isminval)
//  261 {
//  262 	INT16U *table =(INT16U *)(&vEE_TABLE->Table + tIndex*TableMAX62);
//  263 	INT32S i = 0, j = 0;
//  264 	INT16U *dptr = table->Data;
//  265 	INT32S limit = table->limit;
//  266 	INT32S nsize = table->nsize;
//  267 	INT32S rvalx10;
//  268 
//  269 //	if	((tIndex == 2 )||(tIndex == 3 ))
//  270 //	{
//  271 //		rvalx10 = (limit/1)*10L;
//  272 
//  273 //	}
//  274 //	else
//  275 //	{
//  276 		rvalx10 = (limit/2)*10L;
//  277 //	}
//  278 
//  279 	*isminval = FALSE;
//  280 	
//  281 	for(i = 0; i < nsize && i < TableMAX62; i++)
//  282 	{
//  283 		if(AdcValue >= dptr[i]) break;
//  284 	}
//  285 
//  286 	if(i == nsize || i == TableMAX62)
//  287 	{
//  288 		if(nsize != 0) i--;
//  289 		*isminval = TRUE;
//  290 	}
//  291 
//  292 	rvalx10 = rvalx10 - (i*10L);
//  293 
//  294 	if(i != 0 && *isminval == FALSE)
//  295 	{
//  296 		INT32U stepx10 = ((dptr[i-1] - dptr[i])*10L)/10L;
//  297 		INT32U tmp;
//  298 		
//  299 		for(j = 0; j < 10; j++)
//  300 		{
//  301 			tmp = (dptr[i]*10 + j*stepx10);
//  302 			if(tmp >= (AdcValue*10L)) break;			
//  303 		}		
//  304 		if(roundingoff == TRUE)// 반올림..
//  305 		{
//  306 			     if(j >= 8)  j = 10;
//  307 			else if(j >= 3)  j = 5;
//  308 			else			 j = 0;
//  309 		}		
//  310 	}
//  311 	
//  312 	return (rvalx10 + j)*2L;
//  313 }
//  314 #endif
//  315 
//  316 // KT CASE !!

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  317 INT32S ReadPwrTableAscending(INT32U AdcValue, INT8S tIndex, INT8U roundingoff, INT8U *isminval)//, INT16S limit, INT16U nsize)
//  318 {
ReadPwrTableAscending:
        PUSH     {R4-R8,LR}
//  319 	INT16U *dptr =((INT16U *)&vEE_TABLE->Table + tIndex*(TableMAX62+2));
        LDR.N    R4,??DataTable2_3  ;; 0x8005802
        ADD      R5,R4,R1, LSL #+7
//  320 	INT32S i = 0, j = 0;
        MOVS     R1,#+0
//  321 	INT32S rvalx10 = 0;
//  322 	INT16S limit = 0;
//  323 	INT16U nsize = 0;
//  324 
//  325 	*isminval = FALSE;
        STRB     R1,[R3, #+0]
//  326 
//  327 	limit = (INT16S)dptr[0];
//  328 	nsize = dptr[1];
        LDRH     R6,[R5, #+2]
//  329     
//  330     rvalx10 = limit*10L;
        MOVS     R4,#+10
        LDRSH    R7,[R5, R1]
        MULS     R7,R4,R7
//  331    
//  332 	for(i = 0; i < nsize && i < TableMAX62; i++)
        MOV      R12,R1
        ADD      LR,R5,#+4
        B.N      ??ReadPwrTableAscending_0
??ReadPwrTableAscending_1:
        ADD      R12,R12,#+1
??ReadPwrTableAscending_0:
        CMP      R12,R6
        BGE.N    ??ReadPwrTableAscending_2
        CMP      R12,#+62
        BGE.N    ??ReadPwrTableAscending_2
//  333 	{
//  334 		if(AdcValue < dptr[i + (2)]) break;
        LDRH     R8,[LR], #+2
        CMP      R0,R8
        BCS.N    ??ReadPwrTableAscending_1
//  335 	}
//  336 
//  337 	if(i == 0)
??ReadPwrTableAscending_2:
        CMP      R12,#+0
        ITT      EQ 
        MOVEQ    LR,#+1
        STRBEQ   LR,[R3, #+0]
//  338 	{
//  339 		*isminval = TRUE;
//  340 	}
//  341 
//  342 	rvalx10 = rvalx10 + (i*10L);
        MLA      R3,R4,R12,R7
//  343 
//  344 	if( (i != TableMAX62 && i != nsize) && i != 0)
        CMP      R12,#+62
        BEQ.N    ??ReadPwrTableAscending_3
        CMP      R12,R6
        BEQ.N    ??ReadPwrTableAscending_3
        CMP      R12,#+0
        BEQ.N    ??ReadPwrTableAscending_3
//  345 	{
//  346 		INT32U stepx10 = ((dptr[i + (2)] - dptr[i-1 + (2)])*10L)/10L;
        ADD      R5,R5,R12, LSL #+1
        LDRH     R6,[R5, #+4]
        LDRH     R7,[R5, #+2]
        SUBS     R6,R6,R7
        MULS     R6,R4,R6
        SDIV     R6,R6,R4
//  347 		INT32U tmp;
//  348 
//  349 		for(j = 0; j < 10; j++)
        MULS     R0,R4,R0
//  350 		{
//  351 			tmp = (dptr[i + (2)]*10 - j*stepx10);
//  352 			if((AdcValue*10L) > tmp ) break;			
??ReadPwrTableAscending_4:
        LDRH     R7,[R5, #+4]
        MULS     R7,R4,R7
        MLS      R7,R6,R1,R7
        CMP      R7,R0
        BCC.N    ??ReadPwrTableAscending_5
//  353 		}
        ADDS     R1,R1,#+1
        CMP      R1,#+10
        BLT.N    ??ReadPwrTableAscending_4
//  354 			
//  355 		if(roundingoff == TRUE)// 반올림..
??ReadPwrTableAscending_5:
        CMP      R2,#+1
        BNE.N    ??ReadPwrTableAscending_3
//  356 		{
//  357 			     if(j >= 8)  j = 10;
        CMP      R1,#+8
        IT       GE 
        MOVGE    R1,#+10
        BGE.N    ??ReadPwrTableAscending_3
//  358 			else if(j >= 3)  j = 5;
        CMP      R1,#+3
        ITE      GE 
        MOVGE    R1,#+5
        MOVLT    R1,#+0
//  359 			else			 j = 0;
//  360 		}		
//  361 	}
//  362 
//  363 	return (rvalx10 - j);
??ReadPwrTableAscending_3:
        SUBS     R0,R3,R1
        POP      {R4-R8,PC}       ;; return
//  364 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     0x8006000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_1:
        DC32     0x8005800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_2:
        DC32     m_RX_TABLE_3G

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_3:
        DC32     0x8005802

        END
//  365 
//  366 ////////////////////////////////////////////////////////////////////////////////
//  367 // End of Source File
//  368 /////////////////////
//  369 
// 
//     1 byte  in section .bss
// 1 376 bytes in section .rodata
//   836 bytes in section .text
// 
//   836 bytes of CODE  memory
// 1 376 bytes of CONST memory
//     1 byte  of DATA  memory
//
//Errors: none
//Warnings: none
