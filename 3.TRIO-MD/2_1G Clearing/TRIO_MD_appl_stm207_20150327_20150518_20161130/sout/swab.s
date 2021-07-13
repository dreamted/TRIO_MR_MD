///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    30/Aug/2012  21:29:27 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\swab.c       /
//    Command line =  D:\Work\Project\2012\NL_INBUILD\FW\MU\code\swab.c -D    /
//                    OS_INCLUDED -D APPL_SRC -lcN                            /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -lB         /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\ -o          /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\             /
//                    --endian=little --cpu=Cortex-M3 -e --fpu=None           /
//                    --dlib_config "C:\Programming\IAR Systems\Embedded      /
//                    Workbench 6.0\arm\INC\c\DLib_Config_Normal.h" -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\include\ -I       /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\..\..\STM32F2xx_S /
//                    tdPeriph_Driver\ -I D:\Work\Project\2012\NL_INBUILD\FW\ /
//                    MU\..\..\STM32F2xx_StdPeriph_Driver\inc\ -I             /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-CPU\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-LIB\ -I        /
//                    D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Ports\    /
//                    -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uCOS-II\Source /
//                    \ -I D:\Work\Project\2012\NL_INBUILD\FW\MU\uC-Probe\    /
//                    -Oh --use_c++_inline --require_prototypes               /
//    List file    =  D:\Work\Project\2012\NL_INBUILD\FW\MU\sout\swab.s       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME swab

        #define SHT_PROGBITS 0x1

        PUBLIC ___swab16
        PUBLIC ___swab32
        PUBLIC __fswab16
        PUBLIC __fswab32
        PUBLIC __swab16p
        PUBLIC __swab16s
        PUBLIC __swab32p
        PUBLIC __swab32s

// D:\Work\Project\2012\NL_INBUILD\FW\MU\code\swab.c
//    1 
//    2 #include "../include/main.h"
//    3 
//    4  

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    5 unsigned short ___swab16(unsigned short x)
//    6 {
//    7 	unsigned short int __x = (x);
//    8 	return ((unsigned short)((((unsigned short)(__x) & (unsigned short)0x00ffU) << 8) | (((unsigned short)(__x) & (unsigned short)0xff00U) >> 8) ));
___swab16:
        B.N      ?Subroutine0
//    9 }
//   10 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   11 unsigned int ___swab32(unsigned int x)
//   12 {
//   13 	unsigned int __x = (x);
//   14 	return ((unsigned int)(
//   15 				(((unsigned int)(__x) & (unsigned int)0x000000ffUL) << 24) |
//   16 				(((unsigned int)(__x) & (unsigned int)0x0000ff00UL) <<  8) |
//   17 				(((unsigned int)(__x) & (unsigned int)0x00ff0000UL) >>  8) |
//   18 				(((unsigned int)(__x) & (unsigned int)0xff000000UL) >> 24) ));
___swab32:
        AND      R1,R0,#0xFF00
        LSLS     R1,R1,#+8
        ORR      R1,R1,R0, LSL #+24
        LSRS     R2,R0,#+8
        AND      R2,R2,#0xFF00
        ORRS     R1,R2,R1
        ORR      R0,R1,R0, LSR #+24
        BX       LR               ;; return
//   19 }
//   20 
//   21 /**
//   22 unsigned long long ___swab64(unsigned long long x)
//   23 {
//   24 	unsigned long long __x = (x);
//   25 	return ((unsigned long long)(
//   26 				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x00000000000000ffULL) << 56) |
//   27 				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x000000000000ff00ULL) << 40) |
//   28 				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x0000000000ff0000ULL) << 24) |
//   29 				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x00000000ff000000ULL) <<  8) |
//   30 	    		(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x000000ff00000000ULL) >>  8) |
//   31 				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x0000ff0000000000ULL) >> 24) |
//   32 				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x00ff000000000000ULL) >> 40) |
//   33 				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0xff00000000000000ULL) >> 56) ));
//   34 }
//   35 **/
//   36 
//   37 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   38 unsigned short __fswab16(unsigned short x)
//   39 {
//   40 	return __arch__swab16(x);
__fswab16:
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        LSRS     R1,R0,#+8
        ORR      R0,R1,R0, LSL #+8
        UXTH     R0,R0
        BX       LR               ;; return
//   41 }
//   42 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   43 unsigned short __swab16p(unsigned short *x)
//   44 {
//   45 	return __arch__swab16p(x);
__swab16p:
        LDRH     R0,[R0, #+0]
        B.N      ?Subroutine0
//   46 }
//   47 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   48 void __swab16s(unsigned short *addr)
//   49 {
//   50 	__arch__swab16s(addr);
__swab16s:
        LDRH     R1,[R0, #+0]
        LSRS     R2,R1,#+8
        ORR      R1,R2,R1, LSL #+8
        STRH     R1,[R0, #+0]
//   51 }
        BX       LR               ;; return
//   52 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   53 unsigned int __fswab32(unsigned int x)
//   54 {
//   55 	return __arch__swab32(x);
__fswab32:
        B.N      ___swab32
//   56 }
//   57 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   58 unsigned int __swab32p(unsigned int *x)
//   59 {
//   60 	return __arch__swab32p(x);
__swab32p:
        LDR      R0,[R0, #+0]
        B.N      ___swab32
//   61 }
//   62 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   63 void __swab32s(unsigned int *addr)
//   64 {
__swab32s:
        PUSH     {R4,LR}
        MOV      R4,R0
//   65 	__arch__swab32s(addr);
        LDR      R0,[R4, #+0]
        BL       ___swab32
        STR      R0,[R4, #+0]
//   66 }
        POP      {R4,PC}          ;; return

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//   67 
//   68 /**
//   69 unsigned long long __fswab64(unsigned long long x)
//   70 {
//   71 
//   72 	unsigned int h = x >> 32;
//   73     unsigned int l = x & ((1ULL<<32)-1);
//   74 
//   75         return (((unsigned long long)__swab32(l)) << 32) | ((unsigned long long)(__swab32(h)));
//   76 }
//   77 **/
//   78 /**
//   79 unsigned long long __swab64p(unsigned long long *x)
//   80 {
//   81 	return __arch__swab64p(x);
//   82 }
//   83 **/
//   84 /**
//   85 void __swab64s(unsigned long long *addr)
//   86 {
//   87 	__arch__swab64s(addr);
//   88 }
//   89 **/
//   90 ////////////////////////////////////////////////////////////////////////////////
//   91 // End of Source File
//   92 /////////////////////
//   93 
// 
// 72 bytes in section .text
// 
// 72 bytes of CODE memory
//
//Errors: none
//Warnings: none
