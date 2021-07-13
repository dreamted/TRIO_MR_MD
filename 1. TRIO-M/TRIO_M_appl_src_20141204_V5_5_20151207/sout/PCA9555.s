///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  16:00:27 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\dev\iobus\ /
//                    PCA9555.c                                               /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\dev\iobus\ /
//                    PCA9555.c -D _MIMO_Type -lcN                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120109\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120109\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120109\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\sout\PCA95 /
//                    55.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME PCA9555

        EXTERN ForDelay

        PUBLIC ACKpPCA9555
        PUBLIC NACKpPCA9555
        PUBLIC PCA9555_Init
        PUBLIC Read_pPCA9555_8Addr_16Data
        PUBLIC ReadpPCA9555Data
        PUBLIC ReadpPCA9555SDA
        PUBLIC RstpPCA9555SCL
        PUBLIC RstpPCA9555SDA
        PUBLIC SetpPCA9555SCL
        PUBLIC SetpPCA9555SDA
        PUBLIC SetpPCA9555SDAInMode
        PUBLIC SetpPCA9555SDAOutMode
        PUBLIC StartpPCA9555
        PUBLIC StoppPCA9555
        PUBLIC Write_pPCA9555_8Addr_16Data
        PUBLIC WritepPCA9555Data
        PUBLIC _pPCA9555BitSet
        PUBLIC pAttnVal0
        PUBLIC pAttnVal0B
        PUBLIC pAttnVal1
        PUBLIC pAttnVal1B
        PUBLIC pAttnVal2
        PUBLIC pAttnVal2B
        PUBLIC pLEDCSVal0
        PUBLIC pLEDCSVal0B
        PUBLIC pLEDCSVal1
        PUBLIC pLEDCSVal1B
        PUBLIC pPCA9555BitRead
        PUBLIC pPCA9555BitRst
        PUBLIC pPCA9555BitSet
        PUBLIC pPCA9555ReadData
        PUBLIC pPCA9555SetData
        PUBLIC pPCA9555Str
        PUBLIC pPCA9555StrB
        PUBLIC pPCAReadPortData
        PUBLIC pPCASetConfiguration
        PUBLIC pPCASetPortData

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120109\dev\iobus\PCA9555.c
//    1 #define PCA9555_C
//    2 
//    3 #include "../../include/main.h"

        SECTION `.bss`:DATA:NOROOT(2)
// _PCA9555Str __data pPCA9555StrB
pPCA9555StrB:
        DS8 24

        SECTION `.data`:DATA:NOROOT(2)
// _pPCA9555Str __data pPCA9555Str
pPCA9555Str:
        DATA
        DC32 pPCA9555StrB

        SECTION `.bss`:DATA:NOROOT(2)
// _PCA9555Reg __data pLEDCSVal0B
pLEDCSVal0B:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
// _PCA9555Reg *__data pLEDCSVal0
pLEDCSVal0:
        DATA
        DC32 pLEDCSVal0B

        SECTION `.bss`:DATA:NOROOT(2)
// _PCA9555Reg __data pLEDCSVal1B
pLEDCSVal1B:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
// _PCA9555Reg *__data pLEDCSVal1
pLEDCSVal1:
        DATA
        DC32 pLEDCSVal1B

        SECTION `.bss`:DATA:NOROOT(2)
// _PCA9555Reg __data pAttnVal0B
pAttnVal0B:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
// _PCA9555Reg *__data pAttnVal0
pAttnVal0:
        DATA
        DC32 pAttnVal0B

        SECTION `.bss`:DATA:NOROOT(2)
// _PCA9555Reg __data pAttnVal1B
pAttnVal1B:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
// _PCA9555Reg *__data pAttnVal1
pAttnVal1:
        DATA
        DC32 pAttnVal1B

        SECTION `.bss`:DATA:NOROOT(2)
// _PCA9555Reg __data pAttnVal2B
pAttnVal2B:
        DS8 4

        SECTION `.data`:DATA:NOROOT(2)
// _PCA9555Reg *__data pAttnVal2
pAttnVal2:
        DATA
        DC32 pAttnVal2B
//    4 
//    5 
//    6 //#define pPCA9555_debug
//    7 #define CLKDELAY	ForDelay(10)
//    8 
//    9 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   10 void PCA9555_Init(_pPCA9555Str ptr, 
//   11 						void (*SetClk)(), void (*RstClk)(), 
//   12 							void (*SetData)(), void (*RstData)())
//   13 {
PCA9555_Init:
        PUSH     {R3-R6}
        LDR      R4,[SP, #+16]
//   14 	// Port Initialization
//   15 	GPIOB->CNF.B6= __PB6_OU_PP; 	//__I2C1_SCL;	
        LDR.N    R5,??DataTable2  ;; 0x40010c00
        LDR      R6,[R5, #+0]
        BIC      R6,R6,#0xF000000
        ORR      R6,R6,#0x3000000
        STR      R6,[R5, #+0]
//   16 	GPIOB->CNF.B7 = __PB7_IN_FL; 	//__I2C1_SDA;
        LDR      R6,[R5, #+0]
        LSLS     R6,R6,#+4
        LSRS     R6,R6,#+4
        ORR      R6,R6,#0x40000000
        STR      R6,[R5, #+0]
//   17 
//   18 //	GPIOB->CNF.B7 = __PB7_OU_PP; 	//__I2C1_SDA;
//   19 
//   20     ptr->SetClk = SetClk;
        STR      R1,[R0, #+8]
//   21     ptr->RstClk = RstClk;
        STR      R2,[R0, #+12]
//   22     ptr->SetData = SetData;
        STR      R3,[R0, #+16]
//   23     ptr->RstData = RstData;
        STR      R4,[R0, #+20]
//   24 	
//   25 	RstpPCA9555SCL();
        POP      {R0,R4-R6}
        B.N      RstpPCA9555SCL
//   26 }
//   27  

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   28 void pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
pPCA9555BitSet:
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine0:
        PUSH     {R3-R6}
        LSRS     R3,R0,#+6
        UXTH     R3,R3
        LDRB     R4,[R3, R1]
        MOVS     R5,#+1
        LSRS     R6,R0,#+3
        AND      R6,R6,#0x7
        LSLS     R5,R5,R6
        ORRS     R4,R5,R4
        REQUIRE ??Subroutine3_0
        ;; // Fall through to label ??Subroutine3_0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
??Subroutine3_0:
        STRB     R4,[R3, R1]
        MOV      R3,R2
        LDRH     R2,[R1, #+0]
        MOVS     R1,#+2
        AND      R0,R0,#0x7
        LSLS     R0,R0,#+1
        ORR      R0,R0,#0x40
        ADD      SP,SP,#+4
        POP      {R4-R6}
        B.N      Write_pPCA9555_8Addr_16Data
//   29 {
//   30 	INT16U	dAddr = Bitaddr%8;
//   31 	INT16U	pSel = (Bitaddr/8)/8;
//   32 	INT16U	BitNumber = (Bitaddr/8)%8;
//   33 
//   34 	BitSet(pVal->pData[pSel].Data, BitNumber);
//   35 	pPCASetPortData(dAddr, pVal->Data,ptr);
//   36 	
//   37 //	SerPtr->printf(" 0 :Bitaddr[%d][%x]\n",Bitaddr, pVal->Data);
//   38 }
//   39 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   40 void pPCA9555BitRst(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
//   41 {
pPCA9555BitRst:
        PUSH     {R3-R6}
//   42 	INT16U	dAddr = Bitaddr%8;
//   43 	INT16U	pSel = (Bitaddr/8)/8;
        LSRS     R3,R0,#+6
        UXTH     R3,R3
//   44 	INT16U	BitNumber = (Bitaddr/8)%8;
//   45 
//   46 	BitRst(pVal->pData[pSel].Data, BitNumber);
        LDRB     R4,[R3, R1]
        MOVS     R5,#+1
        LSRS     R6,R0,#+3
        AND      R6,R6,#0x7
        LSLS     R5,R5,R6
        MVNS     R5,R5
        ANDS     R4,R5,R4
        B.N      ??Subroutine3_0
//   47 	pPCASetPortData(dAddr, pVal->Data,ptr);
//   48 
//   49 //	SerPtr->printf(" 1: Bitaddr[%d][%x]\n",Bitaddr, pVal->Data);
//   50 }
//   51 
//   52 ////////////////////////////////////////////////////////////////////////

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   53 void _pPCA9555BitSet(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
_pPCA9555BitSet:
        B.N      ?Subroutine0
//   54 {
//   55 	INT16U	dAddr = Bitaddr%8;
//   56 	INT16U	pSel = (Bitaddr/8)/8;
//   57 	INT16U	BitNumber = (Bitaddr/8)%8;
//   58 
//   59 	BitSet(pVal->pData[pSel].Data, BitNumber);
//   60 	pPCASetPortData(dAddr, pVal->Data,ptr);
//   61 	
//   62 //	SerPtr->printf(" 0 :Bitaddr[%d][%x]\n",Bitaddr, pVal->Data);
//   63 }
//   64 
//   65 #if 0
//   66 void _pPCA9555BitRst(INT32U Bitaddr, _PCA9555Reg pVal, _pPCA9555Str ptr)
//   67 {
//   68 	INT16U	dAddr = Bitaddr%8;
//   69 	INT16U	pSel = (Bitaddr/8)/8;
//   70 	INT16U	BitNumber = (Bitaddr/8)%8;
//   71 
//   72 	BitRst(pVal->pData[pSel].Data, BitNumber);
//   73 	pPCASetPortData(dAddr, pVal->Data,ptr);
//   74 
//   75 //	SerPtr->printf(" 1: Bitaddr[%d][%x]\n",Bitaddr, pVal->Data);
//   76 }
//   77 #endif
//   78 
//   79 ////////////////////////////////////////////////////////////////////////
//   80 
//   81 
//   82 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   83 void pPCA9555SetData(INT32U pSel, INT8U Data, _PCA9555Reg *pVal, _pPCA9555Str ptr)
//   84 {
pPCA9555SetData:
        PUSH     {R3,R4}
//   85 	INT16U	dAddr = pSel%8;
//   86 
//   87 	pSel = (pSel/8)/8;
//   88 	pVal->pData[pSel].Data = Data;	
        LSRS     R4,R0,#+6
        STRB     R1,[R4, R2]
//   89 	pPCASetPortData(dAddr, pVal->Data,ptr);
        LDRH     R2,[R2, #+0]
        MOVS     R1,#+2
        AND      R0,R0,#0x7
        LSLS     R0,R0,#+1
        ORR      R0,R0,#0x40
        ADD      SP,SP,#+4
        POP      {R4}
        B.N      Write_pPCA9555_8Addr_16Data
//   90 }
//   91 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 INT8U pPCA9555BitRead(INT32U Bitaddr, _PCA9555Reg *pVal, _pPCA9555Str ptr)
//   93 {
pPCA9555BitRead:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//   94 	INT16U	dAddr = Bitaddr%8;
//   95 	INT16U	pSel = (Bitaddr/8)/8;
//   96 	INT16U	BitNumber = (Bitaddr/8)%8;
//   97 
//   98 	pVal->Data = pPCAReadPortData(dAddr,ptr);
        MOVS     R1,#+0
        AND      R0,R4,#0x7
        LSLS     R0,R0,#+1
        ORR      R0,R0,#0x40
        BL       Read_pPCA9555_8Addr_16Data
        STRH     R0,[R5, #+0]
//   99 	return (BitRead(pVal->pData[pSel].Data, BitNumber));
        LSRS     R0,R4,#+6
        UXTH     R0,R0
        LDRB     R0,[R0, R5]
        LSRS     R1,R4,#+3
        AND      R1,R1,#0x7
        LSRS     R0,R0,R1
        AND      R0,R0,#0x1
        POP      {R1,R4,R5,PC}    ;; return
//  100 }
//  101 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  102 INT8U pPCA9555ReadData(INT32U pSel, _PCA9555Reg *pVal, _pPCA9555Str ptr)
//  103 {
pPCA9555ReadData:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  104 	INT16U	dAddr = pSel%8;
//  105 
//  106 	pSel = (pSel/8)/8;
//  107 	pVal->Data = pPCAReadPortData(dAddr,ptr);
        MOVS     R1,#+0
        AND      R0,R4,#0x7
        LSLS     R0,R0,#+1
        ORR      R0,R0,#0x40
        BL       Read_pPCA9555_8Addr_16Data
        STRH     R0,[R5, #+0]
//  108 	return pVal->pData[pSel].Data;
        LSRS     R0,R4,#+6
        LDRB     R0,[R0, R5]
        POP      {R1,R4,R5,PC}    ;; return
//  109 }
//  110 ////////////////////////////

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  111 void pPCASetConfiguration(INT8U DevAddr, _PCA9555Reg Reg, _pPCA9555Str ptr)
//  112 {
pPCASetConfiguration:
        SUB      SP,SP,#+4
        PUSH     {R1}
//  113 	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _ConfigPort0, Reg.Data, ptr);
        MOV      R3,R2
        LDRH     R2,[SP, #+0]
        MOVS     R1,#+6
        LSLS     R0,R0,#+1
        ORR      R0,R0,#0x40
        UXTB     R0,R0
        ADD      SP,SP,#+8
        B.N      Write_pPCA9555_8Addr_16Data
//  114 //	SerPtr->printf("pPCASetConfiguration: %x %x %x \n", DevAddr,ptr->addr,ptr->DevAddr);
//  115 
//  116 //	Write_pPCA9555_8Addr_16Data(ptr->addr | (ptr->DevAddr << 1), _ConfigPort0, Reg.Data, ptr);
//  117 }
//  118 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  119 void pPCASetPortData(INT8U DevAddr, INT16U Data,_pPCA9555Str ptr)
//  120 {
//  121 	Write_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _OutputPort0, Data, ptr);
pPCASetPortData:
        MOV      R3,R2
        MOV      R2,R1
        MOVS     R1,#+2
        LSLS     R0,R0,#+1
        ORR      R0,R0,#0x40
        UXTB     R0,R0
        B.N      Write_pPCA9555_8Addr_16Data
//  122 //	Write_pPCA9555_8Addr_16Data(ptr->addr | (ptr->DevAddr << 1), _OutputPort0, Data, ptr);
//  123 }
//  124 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 INT16U pPCAReadPortData(INT16U DevAddr,_pPCA9555Str ptr)
//  126 {
//  127 	return Read_pPCA9555_8Addr_16Data(PCA9555Addr | (DevAddr << 1), _InputPort0, ptr);
pPCAReadPortData:
        MOV      R2,R1
        MOVS     R1,#+0
        LSLS     R0,R0,#+1
        ORR      R0,R0,#0x40
        UXTB     R0,R0
        B.N      Read_pPCA9555_8Addr_16Data
//  128 //	return Read_pPCA9555_8Addr_16Data(ptr->addr | (ptr->DevAddr << 1), _InputPort0, ptr);
//  129 }
//  130 
//  131 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  132 INT16U Write_pPCA9555_8Addr_16Data(INT8U DevAddr, INT8U Command, INT16U Data, _pPCA9555Str ptr)
//  133 {
Write_pPCA9555_8Addr_16Data:
        PUSH     {R3-R9,LR}
        MOV      R8,R1
        MOV      R5,R2
        MOV      R4,R3
//  134 	INT8U cnt = pPCAWrTry;
        MOVS     R6,#+3
        LSRS     R7,R5,#+8
        AND      R9,R0,#0xFE
//  135 	// Start Condition
//  136 	// Write Protection Disable, Allows normal write operation
//  137 	// 
//  138 	// output 1(SDATA)
//  139 	// START Conditon making
//  140 //	SerPtr->printf("0 : Write_pPCA9555_8Addr_16Data: %x %x %x \n", DevAddr,Command,Data);
//  141 
//  142 	while(cnt--)
??Write_pPCA9555_8Addr_16Data_0:
        MOV      R0,R6
        CBZ      R0,??Write_pPCA9555_8Addr_16Data_1
        SUBS     R0,R6,#+1
        UXTB     R6,R0
//  143 	{
//  144 
//  145 //////////Start
//  146 		StartpPCA9555(ptr);
        MOV      R0,R4
        BL       StartpPCA9555
//  147 		
//  148 		WritepPCA9555Data(DevAddr & (~0x01),ptr);
        MOV      R1,R4
        MOV      R0,R9
        BL       WritepPCA9555Data
//  149 		#ifndef pPCA9555_debug
//  150 			if(ACKpPCA9555(ptr)) continue;
        MOV      R0,R4
        BL       ACKpPCA9555
        CMP      R0,#+0
        BNE.N    ??Write_pPCA9555_8Addr_16Data_0
//  151 		#else
//  152 		{
//  153 			INT8U _Ack = ACKpPCA9555(ptr);
//  154 			SerPtr->printf("ACK: %d \n", _Ack);
//  155 		}
//  156 		#endif
//  157 		WritepPCA9555Data((INT8U)(Command     ),ptr);
        MOV      R1,R4
        MOV      R0,R8
        BL       WritepPCA9555Data
//  158 		#ifndef pPCA9555_debug
//  159 			if(ACKpPCA9555(ptr)) continue;
        MOV      R0,R4
        BL       ACKpPCA9555
        CMP      R0,#+0
        BNE.N    ??Write_pPCA9555_8Addr_16Data_0
//  160 		#else
//  161 		{
//  162 			INT8U _Ack = ACKpPCA9555(ptr);
//  163 			SerPtr->printf("ACK: %d \n", _Ack);
//  164 		}
//  165 		#endif
//  166 		WritepPCA9555Data((INT8U)(Data >> 8),ptr);
        MOV      R1,R4
        MOV      R0,R7
        BL       WritepPCA9555Data
//  167 		#ifndef pPCA9555_debug
//  168 			if(ACKpPCA9555(ptr)) continue;
        MOV      R0,R4
        BL       ACKpPCA9555
        CMP      R0,#+0
        BNE.N    ??Write_pPCA9555_8Addr_16Data_0
//  169 		#else
//  170 		{
//  171 			INT8U _Ack = ACKpPCA9555(ptr);
//  172 			SerPtr->printf("ACK: %d \n", _Ack);
//  173 		}
//  174 		#endif
//  175 
//  176 		WritepPCA9555Data((INT8U)(Data >> 0),ptr);
        MOV      R1,R4
        UXTB     R0,R5
        BL       WritepPCA9555Data
//  177 		#ifndef pPCA9555_debug
//  178 			if(ACKpPCA9555(ptr)) continue;
        MOV      R0,R4
        BL       ACKpPCA9555
        CMP      R0,#+0
        BNE.N    ??Write_pPCA9555_8Addr_16Data_0
//  179 		#else
//  180 		{
//  181 			INT8U _Ack = ACKpPCA9555(ptr);
//  182 			SerPtr->printf("ACK: %d \n", _Ack);
//  183 		}
//  184 		#endif
//  185 
//  186 		//////////Stop
//  187 
//  188 		StoppPCA9555(ptr);
        MOV      R0,R4
        BL       StoppPCA9555
//  189 //		SerPtr->printf("1: Write_pPCA9555_8Addr_16Data \n");
//  190 
//  191 		return TRUE;
        MOVS     R0,#+1
//  192 	}
//  193 	return FALSE;
??Write_pPCA9555_8Addr_16Data_1:
        POP      {R1,R4-R9,PC}    ;; return
//  194 }
//  195 
//  196 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  197 INT16U Read_pPCA9555_8Addr_16Data(INT8U DevAddr, INT16U Command, _pPCA9555Str ptr)
//  198 {
Read_pPCA9555_8Addr_16Data:
        PUSH     {R4-R6,LR}
        MOV      R5,R0
        MOV      R6,R1
        MOV      R4,R2
//  199 	INT16U rVal = 0;
//  200 	
//  201 	// Device Address Writing
//  202 	StartpPCA9555(ptr);
        MOV      R0,R4
        BL       StartpPCA9555
//  203 	WritepPCA9555Data(DevAddr & (~0x01),ptr);
        MOV      R1,R4
        AND      R0,R5,#0xFE
        BL       WritepPCA9555Data
//  204 	#ifndef pPCA9555_debug
//  205 		ACKpPCA9555(ptr);
        MOV      R0,R4
        BL       ACKpPCA9555
//  206 	#else
//  207 	{
//  208 		INT8U _Ack = ACKpPCA9555(ptr);
//  209 		SerPtr->printf("ACK: %d \n", _Ack);
//  210 	}
//  211 	#endif
//  212 
//  213 	WritepPCA9555Data((INT8U)(Command),ptr);
        MOV      R1,R4
        UXTB     R0,R6
        BL       WritepPCA9555Data
//  214 	#ifndef pPCA9555_debug
//  215 		ACKpPCA9555(ptr);
        MOV      R0,R4
        BL       ACKpPCA9555
//  216 	#else
//  217 	{
//  218 		INT8U _Ack = ACKpPCA9555(ptr);
//  219 		SerPtr->printf("ACK: %d \n", _Ack);
//  220 	}
//  221 	#endif
//  222 	
//  223 	StartpPCA9555((ptr));
        MOV      R0,R4
        BL       StartpPCA9555
//  224 	WritepPCA9555Data(DevAddr | 0x01,ptr);
        MOV      R1,R4
        ORR      R0,R5,#0x1
        BL       WritepPCA9555Data
//  225 	#ifndef pPCA9555_debug
//  226 		ACKpPCA9555(ptr);
        MOV      R0,R4
        BL       ACKpPCA9555
//  227 	#else
//  228 	{
//  229 		INT8U _Ack = ACKpPCA9555(ptr);
//  230 		SerPtr->printf("ACK: %d \n", _Ack);
//  231 	}
//  232 	#endif	
//  233 	rVal = (rVal << 8) | ReadpPCA9555Data(ptr);
        MOV      R0,R4
        BL       ReadpPCA9555Data
        MOV      R5,R0
//  234 	rVal = (rVal << 8) | ReadpPCA9555Data(ptr);
        MOV      R0,R4
        BL       ReadpPCA9555Data
        ORR      R5,R0,R5, LSL #+8
//  235 
//  236 	#ifndef pPCA9555_debug
//  237 		ACKpPCA9555(ptr);
        MOV      R0,R4
        BL       ACKpPCA9555
//  238 	#else
//  239 	{
//  240 		INT8U _Ack = ACKpPCA9555(ptr);
//  241 		SerPtr->printf("ACK: %d \n", _Ack);
//  242 	}
//  243 	#endif	
//  244 
//  245 	NACKpPCA9555(ptr);
        MOV      R0,R4
        BL       NACKpPCA9555
//  246  	StoppPCA9555(ptr);
        MOV      R0,R4
        BL       StoppPCA9555
//  247 
//  248 	return rVal;
        MOV      R0,R5
        POP      {R4-R6,PC}       ;; return
//  249 }
//  250 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  251 void WritepPCA9555Data(INT8U Data, _pPCA9555Str ptr)
//  252 {
WritepPCA9555Data:
        PUSH     {R4-R6,LR}
        MOV      R5,R0
        MOV      R4,R1
//  253 	INT8U i = 0;
//  254 
//  255  	SetpPCA9555SDAOutMode();
        BL       SetpPCA9555SDAOutMode
//  256 
//  257 	ptr->RstClk();
        LDR      R0,[R4, #+12]
        BLX      R0
//  258 	
//  259 	for(i = 0; i < 8; i++)
        MOVS     R6,#+8
//  260 	{
//  261 		if((Data & 0x80)) 	ptr->SetData();
??WritepPCA9555Data_0:
        TST      R5,#0x80
        BEQ.N    ??WritepPCA9555Data_1
        LDR      R0,[R4, #+16]
        BLX      R0
        B.N      ??WritepPCA9555Data_2
//  262 		else				ptr->RstData();
??WritepPCA9555Data_1:
        LDR      R0,[R4, #+20]
        BLX      R0
//  263 
//  264 		ptr->SetClk();
??WritepPCA9555Data_2:
        LDR      R0,[R4, #+8]
        BLX      R0
//  265 		ptr->RstClk();
        LDR      R0,[R4, #+12]
        BLX      R0
//  266 
//  267 		Data <<= 1;
        LSLS     R5,R5,#+1
//  268 	}
        SUBS     R6,R6,#+1
        BNE.N    ??WritepPCA9555Data_0
//  269 }
        POP      {R4-R6,PC}       ;; return
//  270 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  271 INT8U ReadpPCA9555Data(_pPCA9555Str ptr)
//  272 {
ReadpPCA9555Data:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
//  273 	INT8U Data = 0, i = 0;
        MOVS     R5,#+0
//  274 
//  275 	SetpPCA9555SDAInMode();
        BL       SetpPCA9555SDAInMode
//  276 
//  277 	for(i = 0; i < 8; i++)
        MOVS     R6,#+8
//  278 	{
//  279         Data = (Data << 1);
??ReadpPCA9555Data_0:
        LSLS     R5,R5,#+25
        LSRS     R5,R5,#+24
//  280 		ptr->SetClk();
        LDR      R0,[R4, #+8]
        BLX      R0
//  281 
//  282         if(ReadpPCA9555SDA())	Data |= 0x01;
        BL       ReadpPCA9555SDA
        CBZ      R0,??ReadpPCA9555Data_1
        ORR      R5,R5,#0x1
//  283 
//  284 		ptr->RstClk();
??ReadpPCA9555Data_1:
        LDR      R0,[R4, #+12]
        BLX      R0
//  285 	}	
        SUBS     R6,R6,#+1
        BNE.N    ??ReadpPCA9555Data_0
//  286 	return Data;
        MOV      R0,R5
        POP      {R4-R6,PC}       ;; return
//  287 }
//  288 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  289 void StartpPCA9555(_pPCA9555Str ptr)
//  290 {
StartpPCA9555:
        PUSH     {R4,LR}
        MOV      R4,R0
//  291 	// START Conditon making
//  292  	SetpPCA9555SDAOutMode();
        BL       SetpPCA9555SDAOutMode
//  293 
//  294 	ptr->SetData();
        LDR      R0,[R4, #+16]
        BLX      R0
//  295 	ptr->SetClk();
        LDR      R0,[R4, #+8]
        BLX      R0
//  296 	ptr->RstData();
        LDR      R0,[R4, #+20]
        BLX      R0
//  297 	ptr->RstClk();
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  298 
//  299 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        LDR      R0,[R4, #+12]
        POP      {R4,LR}
        BX       R0
//  300 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  301 void StoppPCA9555(_pPCA9555Str ptr)
//  302 {
StoppPCA9555:
        PUSH     {R4,LR}
        MOV      R4,R0
//  303 	// STOP
//  304  	SetpPCA9555SDAOutMode();
        BL       SetpPCA9555SDAOutMode
//  305 	
//  306 	ptr->RstData();
        LDR      R0,[R4, #+20]
        BLX      R0
//  307 	ptr->SetClk();
        LDR      R0,[R4, #+8]
        BLX      R0
//  308 	ptr->SetData();
        LDR      R0,[R4, #+16]
        POP      {R4,LR}
        BX       R0
//  309 }
//  310 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  311 INT8U ACKpPCA9555(_pPCA9555Str ptr)
//  312 {
ACKpPCA9555:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//  313 	INT8U Data;
//  314 
//  315  	SetpPCA9555SDAInMode();
        BL       SetpPCA9555SDAInMode
//  316 	// ACK Check
//  317 	ptr->SetClk();
        LDR      R0,[R4, #+8]
        BLX      R0
//  318 	Data = ReadpPCA9555SDA();
        BL       ReadpPCA9555SDA
        MOV      R5,R0
//  319 	ptr->RstClk();
        LDR      R0,[R4, #+12]
        BLX      R0
//  320 	return Data;
        MOV      R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//  321 }
//  322 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  323 void NACKpPCA9555(_pPCA9555Str ptr)
//  324 {
NACKpPCA9555:
        PUSH     {R4,LR}
        MOV      R4,R0
//  325 	// NACK
//  326  	SetpPCA9555SDAOutMode();
        BL       SetpPCA9555SDAOutMode
//  327 	
//  328 	ptr->SetData();
        LDR      R0,[R4, #+16]
        BLX      R0
//  329 	ptr->SetClk();
        LDR      R0,[R4, #+8]
        BLX      R0
//  330 	ptr->RstClk();	
        B.N      ?Subroutine1
//  331 }
//  332 
//  333 ////////////////////////////////////////////////////////////////////////////////
//  334 // Default Read/Write, Access F31xx Series
//  335 //////////////////////////////////////////
//  336 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  337 void SetpPCA9555SDAInMode(void)
//  338 {
//  339 #if 1
//  340 	GPIOB->CNF.B7 = __PB7_IN_PU; 
SetpPCA9555SDAInMode:
        LDR.N    R0,??DataTable2  ;; 0x40010c00
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
        ORR      R1,R1,#0x80000000
        STR      R1,[R0, #+0]
//  341 //	GPIOB->ODR.B7 = SET;
//  342 #endif	
//  343 }
        BX       LR               ;; return
//  344 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  345 void SetpPCA9555SDAOutMode(void)
//  346 {
//  347 	GPIOB->CNF.B7 = __PB7_OU_PP; 
SetpPCA9555SDAOutMode:
        LDR.N    R0,??DataTable2  ;; 0x40010c00
        LDR      R1,[R0, #+0]
        LSLS     R1,R1,#+4
        LSRS     R1,R1,#+4
        ORR      R1,R1,#0x30000000
        STR      R1,[R0, #+0]
//  348 //	GPIOB->ODR.B6 = SET;
//  349 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     0x40010c00
//  350 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  351 void SetpPCA9555SDA(void)
//  352 {
//  353 	_PCA9555_DATA= 1;
SetpPCA9555SDA:
        LDR.N    R0,??DataTable6  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        B.N      ?Subroutine2
//  354 	CLKDELAY;
//  355 }
//  356 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  357 void RstpPCA9555SDA(void)
//  358 {
//  359 	_PCA9555_DATA= 0;
RstpPCA9555SDA:
        LDR.N    R0,??DataTable6  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x80
        B.N      ?Subroutine2
//  360 	CLKDELAY;
//  361 }
//  362 
//  363 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  364 void SetpPCA9555SCL(void)
//  365 {
//  366 	_PCA9555_CLK = 1;
SetpPCA9555SCL:
        LDR.N    R0,??DataTable6  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x40
        REQUIRE ?Subroutine2
        ;; // Fall through to label ?Subroutine2
//  367 	CLKDELAY;
//  368 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine2:
        STR      R1,[R0, #+0]
        MOVS     R0,#+10
        B.W      ForDelay
//  369 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  370 void RstpPCA9555SCL(void)
//  371 {
//  372 	_PCA9555_CLK = 0;
RstpPCA9555SCL:
        LDR.N    R0,??DataTable6  ;; 0x40010c0c
        LDR      R1,[R0, #+0]
        BIC      R1,R1,#0x40
        B.N      ?Subroutine2
//  373 	CLKDELAY;
//  374 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable6:
        DC32     0x40010c0c
//  375 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  376 INT8U ReadpPCA9555SDA(void)
//  377 {
ReadpPCA9555SDA:
        PUSH     {R7,LR}
//  378 	CLKDELAY;
        MOVS     R0,#+10
        BL       ForDelay
//  379 	return(GPIOB->IDR.B7);
        LDR.N    R0,??ReadpPCA9555SDA_0  ;; 0x40010c08
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x80
        LSRS     R0,R0,#+7
        POP      {R1,PC}          ;; return
        DATA
??ReadpPCA9555SDA_0:
        DC32     0x40010c08
//  380 }

        END
//  381 
//  382 ////////////////////////////////////////////////////////////////////////////////
//  383 // End of Source File
//  384 /////////////////////
//  385 
// 
//  44 bytes in section .bss
//  24 bytes in section .data
// 784 bytes in section .text
// 
// 784 bytes of CODE memory
//  68 bytes of DATA memory
//
//Errors: none
//Warnings: none
