///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.50.0.51878/W32 for ARM    23/Aug/2012  00:33:44 /
// Copyright (C) 1999-2010 IAR Systems AB.                                    /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\ad9362\ /
//                    AD9362_v1207.c                                          /
//    Command line =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\ad9362\ /
//                    AD9362_v1207.c -lcN C:\user\project\FR-SSR\fw\appl_ssr_ /
//                    20120717\sout\ -lB C:\user\project\FR-SSR\fw\appl_ssr_2 /
//                    0120717\sout\ -o C:\user\project\FR-SSR\fw\appl_ssr_201 /
//                    20717\sout\ --endian=little --cpu=Cortex-M3 -e          /
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
//    List file    =  C:\user\project\FR-SSR\fw\appl_ssr_20120717\sout\AD9362 /
//                    _v1207.s                                                /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME AD9362_v1207

        EXTERN OSTimeDly
        EXTERN ReadFPGAs
        EXTERN SerPtr
        EXTERN WriteFPGAs
        EXTERN __aeabi_d2uiz
        EXTERN __aeabi_ddiv
        EXTERN __aeabi_dmul
        EXTERN __aeabi_dsub
        EXTERN __aeabi_f2d
        EXTERN __aeabi_f2uiz
        EXTERN __aeabi_fdiv
        EXTERN __aeabi_fmul
        EXTERN __aeabi_fsub
        EXTERN __aeabi_ui2d
        EXTERN __aeabi_ui2f
        EXTERN __aeabi_ul2d
        EXTERN __aeabi_uldivmod

        PUBLIC AD8362BPPLLWrite
        PUBLIC AD9362BPPLLCtrl
        PUBLIC AD9362CLKSelect
        PUBLIC AD9362DCXOSet
        PUBLIC AD9362GetRssi
        PUBLIC AD9362InOutSelect
        PUBLIC AD9362Init
        PUBLIC AD9362InitSet
        PUBLIC AD9362Rx1GainSet
        PUBLIC AD9362Rx2GainSet
        PUBLIC AD9362RxEnable
        PUBLIC AD9362RxFilterConf
        PUBLIC AD9362RxFilterGain
        PUBLIC AD9362RxFilterSet
        PUBLIC AD9362RxLOPLLCtrl
        PUBLIC AD9362SetAddr
        PUBLIC AD9362Tx12AllSel
        PUBLIC AD9362Tx1AttnSet
        PUBLIC AD9362Tx2AttnSet
        PUBLIC AD9362TxAttnUpdateEn
        PUBLIC AD9362TxEnable
        PUBLIC AD9362TxFilterConf
        PUBLIC AD9362TxFilterSet
        PUBLIC AD9362TxLOPLLCtrl
        PUBLIC AD9362TxOn
        PUBLIC ReadAD9362
        PUBLIC WriteAD9362

// C:\user\project\FR-SSR\fw\appl_ssr_20120717\dev\ad9362\AD9362_v1207.c
//    1 /*!
//    2 *********************************************************************************************************
//    3 *              	- AD9362 CODE
//    4 *
//    5 *              	-(c) Copyright 2007-2012;
//    6 *
//    7 *              	-All rights reserved.  Protected by international copyright laws.
//    8 *              	-Knowledge of the source code may NOT be used to develop a similar product.
//    9 *              	-Please help us continue to provide the Embedded community with the finest
//   10 *              	-software available.  Your honesty is greatly appreciated.
//   11 *
//   12 * 				-file 		: iapd.c
//   13 * 				-author		: Yoon Byong-Gyu, bgyoon@naver.com
//   14 * 				-date		: 2012.05.
//   15 *********************************************************************************************************
//   16 */
//   17 #define AD9362_C
//   18 
//   19 #include "../include/main.h"

        SECTION `.rodata`:CONST:NOROOT(2)
// __absolute unsigned short const AD9362SetAddr[2547]
AD9362SetAddr:
        DATA
        DC16 991, 661, 678, 680, 658, 659, 660, 683, 684, 9, 69, 70, 72, 73, 74
        DC16 75, 78, 67, 66, 65, 68, 63, 63, 76, 77, 77, 2, 3, 4, 10, 101, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96
        DC16 97, 98, 101, 100, 100, 96, 97, 98, 101, 100, 100, 96, 97, 98, 101
        DC16 100, 100, 101, 245, 246, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240
        DC16 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241
        DC16 242, 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242
        DC16 245, 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245
        DC16 244, 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244
        DC16 244, 240, 241, 242, 245, 244, 244, 240, 241, 242, 245, 244, 244
        DC16 240, 241, 242, 245, 244, 244, 245, 16, 17, 18, 6, 7, 24, 25, 26
        DC16 27, 35, 38, 48, 49, 50, 51, 11, 12, 13, 15, 28, 29, 53, 54, 58, 32
        DC16 39, 40, 41, 42, 43, 44, 45, 46, 47, 609, 673, 584, 648, 582, 646
        DC16 585, 649, 571, 635, 579, 643, 573, 637, 21, 20, 19, 573, 637, 570
        DC16 569, 578, 568, 581, 593, 592, 571, 574, 575, 576, 634, 633, 642
        DC16 632, 645, 657, 656, 635, 638, 639, 640, 563, 564, 565, 562, 561, 5
        DC16 627, 628, 629, 626, 625, 5, 319, 312, 313, 314, 315, 319, 316, 316
        DC16 312, 313, 314, 315, 319, 316, 316, 312, 313, 314, 315, 319, 316
        DC16 316, 312, 313, 314, 315, 319, 316, 316, 312, 313, 314, 315, 319
        DC16 316, 316, 312, 313, 314, 315, 319, 316, 316, 312, 313, 314, 315
        DC16 319, 316, 316, 312, 313, 314, 315, 319, 316, 316, 312, 313, 314
        DC16 315, 319, 316, 316, 312, 313, 314, 315, 319, 316, 316, 312, 313
        DC16 314, 315, 319, 316, 316, 312, 313, 314, 315, 319, 316, 316, 312
        DC16 313, 314, 315, 319, 316, 316, 312, 313, 314, 315, 319, 316, 316
        DC16 312, 313, 314, 315, 319, 316, 316, 312, 313, 314, 315, 319, 316
        DC16 316, 319, 316, 316, 319, 311, 304, 305, 306, 307, 311, 308, 308
        DC16 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308
        DC16 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311
        DC16 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307
        DC16 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306
        DC16 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305
        DC16 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304
        DC16 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308
        DC16 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308
        DC16 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311
        DC16 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307
        DC16 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306
        DC16 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305
        DC16 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304
        DC16 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308
        DC16 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308
        DC16 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311
        DC16 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307
        DC16 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306
        DC16 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305
        DC16 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304
        DC16 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308
        DC16 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308
        DC16 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311
        DC16 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307
        DC16 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306
        DC16 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305
        DC16 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304
        DC16 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308
        DC16 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308
        DC16 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311
        DC16 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307
        DC16 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306
        DC16 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305
        DC16 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304
        DC16 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308
        DC16 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308
        DC16 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311
        DC16 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307
        DC16 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306
        DC16 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305
        DC16 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304
        DC16 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308
        DC16 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308
        DC16 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307, 311
        DC16 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306, 307
        DC16 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305, 306
        DC16 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304, 305
        DC16 306, 307, 311, 308, 308, 304, 305, 306, 307, 311, 308, 308, 304
        DC16 305, 306, 307, 311, 308, 308, 311, 308, 308, 311, 250, 251, 252
        DC16 253, 254, 256, 260, 261, 263, 264, 265, 266, 267, 268, 269, 270
        DC16 276, 282, 129, 507, 508, 504, 505, 469, 448, 482, 483, 22, 482
        DC16 483, 214, 215, 202, 22, 202, 475, 477, 479, 476, 478, 210, 209
        DC16 208, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523
        DC16 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536
        DC16 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549
        DC16 550, 551, 160, 163, 161, 169, 162, 165, 166, 170, 164, 174, 403
        DC16 400, 404, 22, 389, 390, 391, 395, 392, 393, 22, 22, 360, 366, 362
        DC16 363, 361, 395, 18, 19, 21, 115, 116, 117, 118, 336, 337, 338, 339
        DC16 340, 341, 342, 343, 344, 348, 2, 3
        DC8 0, 0
        DC8 "3G TX AD9362 INIT END\012"
        DC8 0
        DC8 "3G RX AD9362 INIT END\012"
        DC8 0
        DC8 "4G TX AD9362 INIT END\012"
        DC8 0
        DC8 "4G RX AD9362 INIT END\012"
        DC8 0
//   20 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   21 INT8U AD9362Init(INT8U ch, INT8U IsItReset)
//   22 {
AD9362Init:
        PUSH     {R7,LR}
//   23 
//   24 	union __ADDR_0x000{
//   25 		INT8U Data;
//   26 		struct{
//   27 			INT8U SoftRst		:1; 	// 0: NORMAL,	1: RESET
//   28 			INT8U SPIType		:1; 	// 0: 4-Wire,	1: 3-Wire
//   29 			INT8U LSBFirst		:1; 	// 0: MSB,		1: LSB
//   30 		};
//   31 	} tmp;
//   32 
//   33 	tmp.SoftRst = IsItReset;
//   34 	tmp.SPIType = RESET;
//   35 	tmp.LSBFirst = RESET;
        AND      R1,R1,#0x1
        STRB     R1,[SP, #+0]
//   36 
//   37 	WriteFPGAs(ch, ADDR_SPICONF, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        BL       WriteFPGAs
//   38 
//   39 	return tmp.Data;
        B.W      ?Subroutine0
//   40 }
//   41 
//   42 //#define AD9362_DEBUG
//   43 
//   44 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   45 void AD9362InitSet(INT8U ch, INT8U type)
//   46 {
AD9362InitSet:
        PUSH     {R3-R11,LR}
        MOV      R4,R0
//   47 	INT8U *ptr;
//   48 	INT16U i = 0;
//   49 	INT8U rRegData = 0;
        MOV      R9,#+0
        CBZ.N    R4,??AD9362InitSet_0
        CMP      R4,#+2
        BEQ.N    ??AD9362InitSet_1
        BCC.N    ??AD9362InitSet_2
        CMP      R4,#+3
        BEQ.N    ??AD9362InitSet_3
        B.N      ??AD9362InitSet_4
//   50 	
//   51 	switch(ch)
//   52 	{
//   53 		case SPI_3G_TX_CH:
//   54 			ptr = (INT8U *)vEE_3G_TX;
??AD9362InitSet_0:
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_1  ;; 0x8006800
        B.N      ??AD9362InitSet_5
//   55 		break;
//   56 
//   57 		case SPI_3G_RX_CH:
//   58 			ptr = (INT8U *)vEE_3G_RX;
??AD9362InitSet_2:
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_2  ;; 0x8006000
        B.N      ??AD9362InitSet_5
//   59 		break;
//   60 
//   61 		case SPI_4G_TX_CH:
//   62 			     if(type == LTE_10MHz)	ptr = (INT8U *)vEE_4G_TX_10MHz;
??AD9362InitSet_1:
        CBNZ.N   R1,??AD9362InitSet_6
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_3  ;; 0x8005800
        B.N      ??AD9362InitSet_5
//   63 			else if(type == LTE_15MHz)	ptr = (INT8U *)vEE_4G_TX_15MHz;
??AD9362InitSet_6:
        CMP      R1,#+1
        BNE.N    ??AD9362InitSet_7
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_4  ;; 0x8004800
        B.N      ??AD9362InitSet_5
//   64 			else if(type == LTE_20MHz)	ptr = (INT8U *)vEE_4G_TX_20MHz;
??AD9362InitSet_7:
        CMP      R1,#+2
        BNE.N    ??AD9362InitSet_4
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_5  ;; 0x8003800
        B.N      ??AD9362InitSet_5
//   65 		break;
//   66 
//   67 		case SPI_4G_RX_CH:
//   68 			     if(type == LTE_10MHz)	ptr = (INT8U *)vEE_4G_RX_10MHz;
??AD9362InitSet_3:
        CBNZ.N   R1,??AD9362InitSet_8
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_6  ;; 0x8005000
        B.N      ??AD9362InitSet_5
//   69 			else if(type == LTE_15MHz)	ptr = (INT8U *)vEE_4G_RX_15MHz;
??AD9362InitSet_8:
        CMP      R1,#+1
        BNE.N    ??AD9362InitSet_9
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_7  ;; 0x8004000
        B.N      ??AD9362InitSet_5
//   70 			else if(type == LTE_20MHz)	ptr = (INT8U *)vEE_4G_RX_20MHz;
??AD9362InitSet_9:
        CMP      R1,#+2
        BNE.N    ??AD9362InitSet_4
        LDR.W    R0,??DataTable2  ;; 0x1ffff7e0
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+28
        ADD      R0,R0,R0, LSR #+31
        ASRS     R0,R0,#+1
        LDR.W    R1,??DataTable2_8  ;; 0x8003000
??AD9362InitSet_5:
        ADD      R10,R1,R0, LSL #+10
//   71 		break;
//   72 	}
//   73 
//   74 	
//   75 	for(i = 0; i < sizeAD9362Set; i++)
??AD9362InitSet_4:
        MOV      R11,R9
        LDR.W    R8,??DataTable2_9
        MOV      R5,R8
//   76 	{
//   77 		if(AD9362SetAddr[i] != 0x064 && AD9362SetAddr[i] != 0x0F4)
??AD9362InitSet_10:
        LDRH     R0,[R5, #+0]
        CMP      R0,#+100
        BEQ.N    ??AD9362InitSet_11
        CMP      R0,#+244
        BEQ.N    ??AD9362InitSet_11
//   78 		{
//   79 			if(AD9362SetAddr[i] == 0x0A3)
        CMP      R0,#+163
        BNE.N    ??AD9362InitSet_12
//   80 			{
//   81 				WriteAD9362(ch, AD9362SetAddr[i], rRegData & 0xc0);
        AND      R0,R9,#0xC0
        STRB     R0,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+163
        B.N      ??AD9362InitSet_13
//   82 #ifdef AD9362_DEBUG
//   83 				SerPtr->printf("SPIWrite   %03x,%02x\n", AD9362SetAddr[i], rRegData & 0xc0);
//   84 #endif
//   85 			}
//   86 			else {
//   87 				WriteAD9362(ch, AD9362SetAddr[i], *ptr);
??AD9362InitSet_12:
        LDRB     R0,[R10, #+0]
        STRB     R0,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        LDRH     R1,[R5, #+0]
??AD9362InitSet_13:
        MOV      R0,R4
        BL       WriteFPGAs
//   88 #ifdef AD9362_DEBUG
//   89 				SerPtr->printf("SPIWrite   %03x,%02x\n", AD9362SetAddr[i], *ptr);
//   90 #endif
//   91 			}
//   92 			ptr++;
        ADD      R10,R10,#+1
        B.N      ??AD9362InitSet_14
//   93 		}
//   94 		else{
//   95 			WriteAD9362(ch, AD9362SetAddr[i], 0x00);
??AD9362InitSet_11:
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        LDRH     R1,[R5, #+0]
        MOV      R0,R4
        BL       WriteFPGAs
//   96 #ifdef AD9362_DEBUG
//   97 			SerPtr->printf("SPIWrite   %03x,%02x\n", AD9362SetAddr[i], 0x00);
//   98 #endif
//   99 		}
//  100 		
//  101 		switch(i)
??AD9362InitSet_14:
        MOVS     R0,R11
        BEQ.N    ??AD9362InitSet_15
        SUBS     R0,R0,#+9
        BEQ.N    ??AD9362InitSet_15
        SUBS     R0,R0,#+16
        BEQ.N    ??AD9362InitSet_16
        SUBS     R0,R0,#+4
        BEQ.N    ??AD9362InitSet_15
        SUBS     R0,R0,#+1
        BEQ.N    ??AD9362InitSet_17
        MOVW     R1,#+769
        SUBS     R0,R0,R1
        BEQ.N    ??AD9362InitSet_15
        SUBS     R0,R0,#+2
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,R1
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+5
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+10
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+6
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+2
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+11
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+14
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+3
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+1
        BEQ.N    ??AD9362InitSet_18
        SUBS     R0,R0,#+1
        BEQ.N    ??AD9362InitSet_19
        SUBS     R0,R0,#+11
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+11
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+12
        BEQ.W    ??AD9362InitSet_20
        SUBS     R0,R0,#+117
        BEQ.N    ??AD9362InitSet_17
        MOVW     R1,#+642
        SUBS     R0,R0,R1
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+19
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+4
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+5
        BEQ.W    ??AD9362InitSet_21
        SUBS     R0,R0,#+2
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+2
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+2
        BEQ.W    ??AD9362InitSet_22
        SUBS     R0,R0,#+1
        BEQ.W    ??AD9362InitSet_23
        SUBS     R0,R0,#+5
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+3
        BEQ.W    ??AD9362InitSet_24
        SUBS     R0,R0,#+40
        BEQ.W    ??AD9362InitSet_25
        SUBS     R0,R0,#+10
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+4
        BEQ.W    ??AD9362InitSet_26
        SUBS     R0,R0,#+7
        BEQ.W    ??AD9362InitSet_27
        SUBS     R0,R0,#+1
        BEQ.W    ??AD9362InitSet_28
        SUBS     R0,R0,#+9
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+4
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+10
        BEQ.N    ??AD9362InitSet_17
        SUBS     R0,R0,#+2
        BEQ.N    ??AD9362InitSet_17
        B.N      ??AD9362InitSet_29
//  102 		{
//  103 			case 0:
//  104 			case 9:
//  105         	case 29:
//  106 			case 799:
//  107 				OSTimeDly(20);
??AD9362InitSet_15:
        MOVS     R0,#+20
??AD9362InitSet_30:
        BL       OSTimeDly
        B.N      ??AD9362InitSet_29
//  108 #ifdef AD9362_DEBUG
//  109 				SerPtr->printf("wait 20ms\n");
//  110 #endif
//  111 			break;
//  112 
//  113 			case 30:
//  114 			case 801:
//  115 			case 1570:
//  116 			case 1575:
//  117 			case 1585:			// Setup AuxADC
//  118 			case 1591:			// Setup Control Outs
//  119 			case 1593:			// Setup GPO
//  120 			case 1604:
//  121 			case 1618:
//  122 			case 1621:
//  123 			case 1634:
//  124 			case 1645:
//  125 			case 1774:
//  126 			case 2416:
//  127 			case 2435:
//  128 			case 2439:
//  129 			case 2446:
//  130 			case 2448:
//  131 			case 2456:
//  132 			case 2509:
//  133 			case 2530:
//  134 			case 2534:
//  135 			case 2544:
//  136 			case 2546:
//  137 				OSTimeDly(1);	// wait 1ms
??AD9362InitSet_17:
        MOVS     R0,#+1
        B.N      ??AD9362InitSet_30
//  138 #ifdef AD9362_DEBUG
//  139 				if(i == 1593) SerPtr->printf("// Setup GPO\n");
//  140 				if(i == 1634) SerPtr->printf("// Setup Synthesizer \n");
//  141 				if(i == 1774) SerPtr->printf("// Program Rx Gain Tables with GainTable800MHz.csv \n");
//  142 				if(i == 2416) SerPtr->printf("// Setup Rx Manual Gain Registers \n");
//  143 				if(i == 2435) SerPtr->printf("// RX Baseband Filter Tuning (Real BW: 7.000000 MHz) 3dB Filter \n");
//  144 				if(i == 2446) SerPtr->printf("// TX Baseband Filter Tuning (Real BW: 7.000000 MHz) 3dB Filter \n");
//  145 				if(i == 2456) SerPtr->printf("// TX Secondary Filter Calibration Setup:  Real Bandwidth \n");
//  146 				if(i == 2530) SerPtr->printf("// Set Tx Attenuation: Tx1: 10.00 dB,  Tx2: 10.00 dB \n");
//  147 				if(i == 2534) SerPtr->printf("// Setup RSSI and Power Measurement Duration Registers \n");
//  148 				if(i == 2546) SerPtr->printf("// END\n");
//  149 				
//  150 				SerPtr->printf("wait 1ms\n");
//  151 #endif
//  152 			break;
//  153 			
//  154 			case 25:
//  155 			{
//  156 				INT8U ret = TRUE;
??AD9362InitSet_16:
        MOVS     R6,#+1
//  157 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_31:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.W    ??AD9362InitSet_29
//  158 				INT8U tmp;
//  159 #ifdef AD9362_DEBUG
//  160 				if(i == 25)	SerPtr->printf("wait 0x05E lock\n");
//  161 #endif
//  162 				while(ret && cnt--)
//  163 				{
//  164 					tmp = ReadAD9362(ch, 0x05E);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+94
        MOV      R0,R4
        BL       ReadFPGAs
//  165 					if(BitRead(tmp, 7)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+24
        IT       MI 
        MOVMI    R6,#+0
//  166 					OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
//  167 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_31
        B.N      ??AD9362InitSet_29
//  168 			}
//  169 			break;
//  170 
//  171 			case 1622:
//  172 			{
//  173 				INT8U ret = TRUE;
??AD9362InitSet_18:
        MOVS     R6,#+1
//  174 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_32:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.W    ??AD9362InitSet_29
//  175 				INT8U tmp;
//  176 #ifdef AD9362_DEBUG
//  177 				if(i == 1622)	SerPtr->printf("wait 0x244 lock\n");
//  178 #endif
//  179 				while(ret && cnt--)
//  180 				{
//  181 					tmp = ReadAD9362(ch, 0x244);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOV      R1,#+580
        MOV      R0,R4
        BL       ReadFPGAs
//  182 					if(BitRead(tmp, 7)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+24
        IT       MI 
        MOVMI    R6,#+0
//  183 					OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
//  184 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_32
        B.N      ??AD9362InitSet_29
//  185 			}
//  186 			break;
//  187 
//  188 			case 1623:
//  189 			{
//  190 				INT8U ret = TRUE;
??AD9362InitSet_19:
        MOVS     R6,#+1
//  191 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_33:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.W    ??AD9362InitSet_29
//  192 				INT8U tmp;
//  193 #ifdef AD9362_DEBUG
//  194 				SerPtr->printf("wait 0x284 lock\n");
//  195 				SerPtr->printf("Setup Synthesizer\n");
//  196 #endif
//  197 				while(ret && cnt--)
//  198 				{
//  199 					tmp = ReadAD9362(ch, 0x284);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOV      R1,#+644
        MOV      R0,R4
        BL       ReadFPGAs
//  200 					if(BitRead(tmp, 7)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+24
        IT       MI 
        MOVMI    R6,#+0
//  201 					OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
//  202 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_33
        B.N      ??AD9362InitSet_29
//  203 			}
//  204 			break;
//  205 
//  206 			case 1657:
//  207 			{
//  208 				INT8U ret = TRUE;
??AD9362InitSet_20:
        MOVS     R6,#+1
//  209 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_34:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CBZ.N    R0,??AD9362InitSet_35
//  210 				INT8U tmp;
//  211 #ifdef AD9362_DEBUG
//  212 				SerPtr->printf("wait 0x247[1] lock\n");
//  213 #endif
//  214 				while(ret && cnt--)
//  215 				{
//  216 					tmp = ReadAD9362(ch, 0x247);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+583
        MOV      R0,R4
        BL       ReadFPGAs
//  217 					if(BitRead(tmp, 1)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+30
        IT       MI 
        MOVMI    R6,#+0
//  218 					OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
//  219 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_34
//  220 			}
//  221 			{
//  222 				INT8U ret = TRUE;
??AD9362InitSet_35:
        MOVS     R6,#+1
//  223 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_36:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.W    ??AD9362InitSet_29
//  224 				INT8U tmp;
//  225 #ifdef AD9362_DEBUG
//  226 				SerPtr->printf("wait 0x287[1] lock\n");
//  227 #endif
//  228 				while(ret && cnt--)
//  229 				{
//  230 					tmp = ReadAD9362(ch, 0x287);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+647
        MOV      R0,R4
        BL       ReadFPGAs
//  231 					if(BitRead(tmp, 1)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+30
        IT       MI 
        MOVMI    R6,#+0
//  232 					OSTimeDly(200L);
        MOVS     R0,#+200
        BL       OSTimeDly
//  233 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_36
        B.N      ??AD9362InitSet_29
//  234 			}
//  235 #ifdef AD9362_DEBUG
//  236 				SerPtr->printf("// Program Mixer GM Sub-table \n");
//  237 #endif
//  238 
//  239 			break;
//  240 			case 2444:
//  241 			{
//  242 				INT8U ret = TRUE;
??AD9362InitSet_21:
        MOVS     R6,#+1
//  243 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_37:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.W    ??AD9362InitSet_29
//  244 				INT8U tmp;
//  245 #ifdef AD9362_DEBUG
//  246 				SerPtr->printf("(Done when 0x016[7]==0)\n");
//  247 #endif
//  248 				while(ret && cnt--)
//  249 				{
//  250 					tmp = ReadAD9362(ch, 0x016);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+22
        MOV      R0,R4
        BL       ReadFPGAs
//  251 					if(!BitRead(tmp, 7)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+24
        IT       PL 
        MOVPL    R6,#+0
//  252 					OSTimeDly(10);
        MOVS     R0,#+10
        BL       OSTimeDly
//  253 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_37
        B.N      ??AD9362InitSet_29
//  254 			}
//  255 			break;
//  256 			case 2450:
//  257 			{
//  258 				INT8U ret = TRUE;
??AD9362InitSet_22:
        MOVS     R6,#+1
//  259 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_38:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.W    ??AD9362InitSet_29
//  260 				INT8U tmp;
//  261 #ifdef AD9362_DEBUG
//  262 				SerPtr->printf("(Done when 0x016[6]==0)\n");
//  263 #endif
//  264 				while(ret && cnt--)
//  265 				{
//  266 					tmp = ReadAD9362(ch, 0x016);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+22
        MOV      R0,R4
        BL       ReadFPGAs
//  267 					if(!BitRead(tmp, 6)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+25
        IT       PL 
        MOVPL    R6,#+0
//  268 					OSTimeDly(10);
        MOVS     R0,#+10
        BL       OSTimeDly
//  269 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_38
        B.N      ??AD9362InitSet_29
//  270 			}		
//  271 			break;
//  272 			case 2451:
//  273 #ifdef AD9362_DEBUG
//  274 				if(i == 2451) SerPtr->printf("// RX TIA Setup:  Setup values scale based on RxBBF calibration \n");
//  275 #endif
//  276 				{
//  277 					INT8U tmp = 0;
//  278 					tmp = ReadAD9362(ch, 0x1EB);
??AD9362InitSet_23:
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+491
        MOV      R0,R4
        BL       ReadFPGAs
//  279                     tmp = tmp;
//  280 #ifdef AD9362_DEBUG
//  281 					SerPtr->printf("// Read RXBBF C3(MSB) = %02x\n", tmp);
//  282 #endif
//  283 					tmp = ReadAD9362(ch, 0x1EC);
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        MOV      R1,#+492
        MOV      R0,R4
        BL       ReadFPGAs
//  284 #ifdef AD9362_DEBUG
//  285 					SerPtr->printf("// Read RXBBF C3(LSB) = %02x\n", tmp);
//  286 #endif
//  287 					tmp = ReadAD9362(ch, 0x1E6);
        MOVS     R3,#+1
        ADD      R2,SP,#+2
??AD9362InitSet_39:
        MOV      R1,#+486
        MOV      R0,R4
        BL       ReadFPGAs
//  288 #ifdef AD9362_DEBUG
//  289 					SerPtr->printf("// Read RXBBF R2346 = %02x\n", tmp);
//  290 #endif
//  291 				}
        B.N      ??AD9362InitSet_29
//  292 			break;
//  293 
//  294 			case 2459:
//  295 				{
//  296 					INT8U tmp = 0;
//  297 					tmp = ReadAD9362(ch, 0x1EB);
??AD9362InitSet_24:
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+491
        MOV      R0,R4
        BL       ReadFPGAs
//  298                     tmp = tmp;
//  299 #ifdef AD9362_DEBUG
//  300 					SerPtr->printf("// Read RXBBF C3(MSB) = %02x\n", tmp);
//  301 #endif
//  302 					tmp = ReadAD9362(ch, 0x1EC);
        MOVS     R3,#+1
        ADD      R2,SP,#+2
        MOV      R1,#+492
        MOV      R0,R4
        BL       ReadFPGAs
//  303 #ifdef AD9362_DEBUG
//  304 					SerPtr->printf("// Read RXBBF C3(LSB) = %02x\n", tmp);
//  305 #endif
//  306 					tmp = ReadAD9362(ch, 0x1E6);
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        B.N      ??AD9362InitSet_39
//  307 #ifdef AD9362_DEBUG
//  308 					SerPtr->printf("// Read RXBBF R2346 = %02x\n", tmp);
//  309 #endif
//  310 				}
//  311 #ifdef AD9362_DEBUG
//  312 				if(i == 2459) SerPtr->printf("// ADC Setup:  Tune ADC Performance based on RX analog filter tune \n");
//  313 #endif
//  314 			break;
//  315 
//  316 			case 2499:
//  317 				//if(i == 2499) SerPtr->printf("// Tx Quadrature Calibration Settings \n");
//  318 				rRegData = ReadAD9362(ch, 0x0A3);
??AD9362InitSet_25:
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+163
        MOV      R0,R4
        BL       ReadFPGAs
        LDRB     R9,[SP, #+0]
        B.N      ??AD9362InitSet_29
//  319 			break;
//  320 
//  321 			case 2513:
//  322 			{
//  323 				INT8U ret = TRUE;
??AD9362InitSet_26:
        MOVS     R6,#+1
//  324 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_40:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ.N    ??AD9362InitSet_29
//  325 				INT8U tmp;
//  326 #ifdef AD9362_DEBUG
//  327 				SerPtr->printf("(Done when 0x016[0]==0)\n");
//  328 #endif
//  329 				while(ret && cnt--)
//  330 				{
//  331 					tmp = ReadAD9362(ch, 0x016);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+22
        MOV      R0,R4
        BL       ReadFPGAs
//  332 					if(!BitRead(tmp, 0)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+31
        IT       PL 
        MOVPL    R6,#+0
//  333 					OSTimeDly(10);
        MOVS     R0,#+10
        BL       OSTimeDly
//  334 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_40
        B.N      ??AD9362InitSet_29
//  335 			}
//  336 			break;
//  337 			
//  338 			case 2520:
//  339 			{
//  340 				INT8U ret = TRUE;
??AD9362InitSet_27:
        MOVS     R6,#+1
//  341 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_41:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CBZ.N    R0,??AD9362InitSet_29
//  342 				INT8U tmp;
//  343 #ifdef AD9362_DEBUG
//  344 				SerPtr->printf("(Done when 0x016[1]==0)\n");
//  345 #endif
//  346 				while(ret && cnt--)
//  347 				{
//  348 					tmp = ReadAD9362(ch, 0x016);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+22
        MOV      R0,R4
        BL       ReadFPGAs
//  349 					if(!BitRead(tmp, 1)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+30
        IT       PL 
        MOVPL    R6,#+0
//  350 					OSTimeDly(10);
        MOVS     R0,#+10
        BL       OSTimeDly
//  351 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_41
        B.N      ??AD9362InitSet_29
//  352 			}
//  353 			break;
//  354 			
//  355 			case 2521:
//  356 			{
//  357 				INT8U ret = TRUE;
??AD9362InitSet_28:
        MOVS     R6,#+1
//  358 				INT8U cnt = 20;
        MOVS     R7,#+20
??AD9362InitSet_42:
        MOV      R0,R7
        SUBS     R7,R0,#+1
        UXTB     R0,R0
        CBZ.N    R0,??AD9362InitSet_29
//  359 				INT8U tmp;
//  360 #ifdef AD9362_DEBUG
//  361 				SerPtr->printf("(Done when 0x016[4]==0)\n");
//  362 #endif
//  363 				while(ret && cnt--)
//  364 				{
//  365 					tmp = ReadAD9362(ch, 0x016);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+22
        MOV      R0,R4
        BL       ReadFPGAs
//  366 					if(!BitRead(tmp, 4)) ret = FALSE;
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+27
        IT       PL 
        MOVPL    R6,#+0
//  367 					OSTimeDly(10);
        MOVS     R0,#+10
        BL       OSTimeDly
//  368 				}
        CMP      R6,#+0
        BNE.N    ??AD9362InitSet_42
//  369 			}
//  370 			break;
//  371 
//  372 		}
//  373 			
//  374 	}
??AD9362InitSet_29:
        ADD      R11,R11,#+1
        ADDS     R5,R5,#+2
        MOVW     R0,#+2547
        CMP      R11,R0
        BCC.W    ??AD9362InitSet_10
//  375 	switch(ch)
        CBZ.N    R4,??AD9362InitSet_43
        CMP      R4,#+2
        BEQ.N    ??AD9362InitSet_44
        BCC.N    ??AD9362InitSet_45
        CMP      R4,#+3
        BEQ.N    ??AD9362InitSet_46
        B.N      ??AD9362InitSet_47
//  376 	{
//  377 		case SPI_3G_TX_CH:
//  378 			SerPtr->printf("3G TX AD9362 INIT END\n");
??AD9362InitSet_43:
        MOVW     R0,#+5096
        B.N      ??AD9362InitSet_48
//  379 		break;
//  380 
//  381 		case SPI_3G_RX_CH:
//  382 			SerPtr->printf("3G RX AD9362 INIT END\n");
??AD9362InitSet_45:
        ADD      R0,R8,#+5120
        B.N      ??AD9362InitSet_49
//  383 		break;
//  384 
//  385 		case SPI_4G_TX_CH:
//  386 			SerPtr->printf("4G TX AD9362 INIT END\n");
??AD9362InitSet_44:
        MOVW     R0,#+5144
        B.N      ??AD9362InitSet_48
//  387 		break;
//  388 
//  389 		case SPI_4G_RX_CH:
//  390 			SerPtr->printf("4G RX AD9362 INIT END\n");
??AD9362InitSet_46:
        MOVW     R0,#+5168
??AD9362InitSet_48:
        ADD      R0,R0,R8
??AD9362InitSet_49:
        LDR.W    R1,??DataTable2_10
        LDR      R1,[R1, #+0]
        LDR      R1,[R1, #+16]
        BLX      R1
//  391 		break;
//  392 	}
//  393 	
//  394 	OSTimeDly(20L);
??AD9362InitSet_47:
        MOVS     R0,#+20
        BL       OSTimeDly
//  395 }
        POP      {R0,R4-R11,PC}   ;; return
//  396 
//  397 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  398 INT8U AD9362TxOn(INT8U ch, INT8U TxOn)
//  399 {
AD9362TxOn:
        PUSH     {LR}
        SUB      SP,SP,#+12
//  400 	union __ADDR_0x014{
//  401 		INT8U Data;
//  402 		struct{
//  403 			INT8U ToAlert		:1;
//  404 			INT8U AutoGainLock	:1;
//  405 			INT8U ForceAlertSts	:1;
//  406 			INT8U LvlMode		:1;
//  407 			
//  408 			INT8U EnENSMpin		:1;
//  409 			INT8U TxOn			:1;
//  410 			INT8U RxOn			:1;
//  411 			INT8U EnRxDataPort	:1;
//  412 			
//  413 		};
//  414 	} tmp;
//  415 	tmp.Data = 0x09;
//  416 	tmp.TxOn = TxOn;
        UBFX     R1,R1,#+0,#+1
        LSLS     R1,R1,#+5
        ORR      R1,R1,#0x9
        STRB     R1,[SP, #+0]
//  417 	WriteAD9362(ch, ADDR_ENSMCFG1, tmp.Data);
        STRB     R1,[SP, #+4]
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOVS     R1,#+20
        BL       WriteFPGAs
//  418     
//  419     return tmp.Data;
        LDRB     R0,[SP, #+0]
        ADD      SP,SP,#+12
        POP      {PC}             ;; return
//  420 }
//  421 
//  422 
//  423 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  424 INT8U AD9362TxEnable(INT8U ch, INT8U Tx1En, INT8U Tx2En)
//  425 {
AD9362TxEnable:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//  426 	union __ADDR_0x002{
//  427 		INT8U Data;
//  428 		struct{
//  429 			INT8U TxFIREn		:2;
//  430 			INT8U THB1En		:1;
//  431 			INT8U THB2En		:1;
//  432 			
//  433 			INT8U THB3En		:2;
//  434 			INT8U Tx1En			:1;
//  435 			INT8U Tx2En			:1;
//  436 		};
//  437 	} tmp;
//  438 
//  439 	ReadFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        BL       ReadFPGAs
//  440 
//  441 	tmp.Tx1En = Tx1En;
//  442 	tmp.Tx2En = Tx2En;
        LDRB     R0,[SP, #+0]
        AND      R0,R0,#0xBF
        UBFX     R1,R5,#+0,#+1
        ORR      R0,R0,R1, LSL #+6
        AND      R0,R0,#0x7F
        UBFX     R1,R6,#+0,#+1
        ORR      R0,R0,R1, LSL #+7
        STRB     R0,[SP, #+0]
//  443 
//  444 	WriteFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        B.N      ?Subroutine1
//  445 
//  446 	return tmp.Data;
//  447 }
//  448 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  449 INT8U AD9362TxFilterSet(INT8U ch, INT8U THB3En, INT8U THB2En, INT8U THB1En, INT8U TxFIREn)
//  450 {
AD9362TxFilterSet:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R8,R0
        MOV      R6,R1
        MOV      R7,R2
        MOV      R5,R3
        LDR      R4,[SP, #+32]
//  451 	union __ADDR_0x002{
//  452 		INT8U Data;
//  453 		struct{
//  454 			INT8U TxFIREn		:2;
//  455 			INT8U THB1En		:1;
//  456 			INT8U THB2En		:1;
//  457 			
//  458 			INT8U THB3En		:2;
//  459 			INT8U Tx1En			:1;
//  460 			INT8U Tx2En			:1;
//  461 			
//  462 		};
//  463 	} tmp;
//  464 
//  465 	ReadFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        BL       ReadFPGAs
//  466 
//  467 	tmp.TxFIREn = TxFIREn;
//  468 	tmp.THB1En = THB1En;
//  469 	tmp.THB2En = THB2En;
//  470 	tmp.THB3En = THB3En;
        LDRB     R0,[SP, #+0]
        BFI      R0,R4,#+0,#+2
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xFB
        LSLS     R1,R5,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xF7
        LSLS     R1,R7,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xCF
        LSLS     R1,R6,#+4
        AND      R1,R1,#0x30
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
//  471 
//  472 	WriteFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        B.N      ?Subroutine2
//  473 
//  474 	return tmp.Data;
//  475 }
//  476 
//  477 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  478 INT8U AD9362RxEnable(INT8U ch, INT8U Rx1En, INT8U Rx2En)
//  479 {
AD9362RxEnable:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//  480 	union __ADDR_0x003{
//  481 		INT8U Data;
//  482 		struct{
//  483 			INT8U RxFIREn		:2;
//  484 			INT8U RHB1En		:1;
//  485 			INT8U RHB2En		:1;
//  486 			
//  487 			INT8U RHB3En		:2;
//  488 			INT8U Rx1En			:1;
//  489 			INT8U Rx2En			:1;
//  490 		};
//  491 	} tmp;
//  492 	
//  493 	ReadFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+3
        BL       ReadFPGAs
//  494 
//  495 	tmp.Rx1En = Rx1En;
//  496 	tmp.Rx2En = Rx2En;
        LDRB     R0,[SP, #+0]
        AND      R0,R0,#0xBF
        UBFX     R1,R5,#+0,#+1
        ORR      R0,R0,R1, LSL #+6
        AND      R0,R0,#0x7F
        UBFX     R1,R6,#+0,#+1
        ORR      R0,R0,R1, LSL #+7
        STRB     R0,[SP, #+0]
//  497 
//  498 	WriteFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+3
        REQUIRE ?Subroutine1
        ;; // Fall through to label ?Subroutine1
//  499 
//  500 	return tmp.Data;
//  501 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        MOV      R0,R4
        BL       WriteFPGAs
        LDRB     R0,[SP, #+0]
        POP      {R1,R2,R4-R6,PC}  ;; return
//  502 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  503 INT8U AD9362RxFilterSet(INT8U ch, INT8U RHB3En, INT8U RHB2En, INT8U RHB1En, INT8U RxFIREn)
//  504 {
AD9362RxFilterSet:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+8
        MOV      R8,R0
        MOV      R6,R1
        MOV      R7,R2
        MOV      R5,R3
        LDR      R4,[SP, #+32]
//  505 	union __ADDR_0x003{
//  506 		INT8U Data;
//  507 		struct{
//  508 			INT8U RxFIREn		:2;
//  509 			INT8U RHB1En		:1;
//  510 			INT8U RHB2En		:1;
//  511 			
//  512 			INT8U RHB3En		:2;
//  513 			INT8U Rx1En 		:1;
//  514 			INT8U Rx2En 		:1;
//  515 		};
//  516 	} tmp;
//  517 	
//  518 	ReadFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+3
        BL       ReadFPGAs
//  519 
//  520 	tmp.RxFIREn = RxFIREn;
//  521 	tmp.RHB1En = RHB1En;
//  522 	tmp.RHB2En = RHB2En;
//  523 	tmp.RHB3En = RHB3En;
        LDRB     R0,[SP, #+0]
        BFI      R0,R4,#+0,#+2
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xFB
        LSLS     R1,R5,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xF7
        LSLS     R1,R7,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xCF
        LSLS     R1,R6,#+4
        AND      R1,R1,#0x30
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
//  524 
//  525 	WriteFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+3
        REQUIRE ?Subroutine2
        ;; // Fall through to label ?Subroutine2
//  526 
//  527 	return tmp.Data;
//  528 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine2:
        MOV      R0,R8
        BL       WriteFPGAs
        LDRB     R0,[SP, #+0]
        POP      {R1,R2,R4-R8,PC}  ;; return
//  529 
//  530 
//  531 
//  532 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  533 INT8U AD9362InOutSelect(INT8U ch, INT8U Tx_AEn,
//  534 								  INT8U Rx_ANEn, INT8U Rx_APEn,
//  535 								  INT8U Rx_BNEn, INT8U Rx_BPEn,
//  536 								  INT8U Rx_CNEn, INT8U Rx_CPEn)
//  537 {
AD9362InOutSelect:
        PUSH     {R3-R11,LR}
        MOV      R8,R0
        MOV      R9,R1
        MOV      R11,R2
        MOV      R10,R3
        LDR      R7,[SP, #+40]
        LDR      R6,[SP, #+44]
        LDR      R4,[SP, #+48]
        LDR      R5,[SP, #+52]
//  538 	union __ADDR_0x004{
//  539 		INT8U Data;
//  540 		struct{
//  541 			INT8U Rx_ANEn		:1;
//  542 			INT8U Rx_APEn		:1;
//  543 			INT8U Rx_BNEn		:1;
//  544 			INT8U Rx_BPEn		:1;
//  545 			
//  546 			INT8U Rx_CNEn		:1;
//  547 			INT8U Rx_CPEn		:1;
//  548 			INT8U Tx_2AEn		:1;
//  549 		};
//  550 	} tmp;
//  551 	
//  552 	ReadFPGAs(ch, ADDR_INPUTSEL, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+4
        BL       ReadFPGAs
//  553 
//  554 	tmp.Rx_ANEn = Rx_ANEn;
//  555 	tmp.Rx_APEn = Rx_APEn;
//  556 	tmp.Rx_BNEn = Rx_BNEn;
//  557 	tmp.Rx_BPEn = Rx_BPEn;
//  558 	tmp.Rx_CNEn = Rx_CNEn;
//  559 	tmp.Rx_CPEn = Rx_CPEn;
//  560 	
//  561 	tmp.Tx_2AEn = Tx_AEn;
        UBFX     R0,R11,#+0,#+1
        LDRB     R1,[SP, #+0]
        BFI      R1,R0,#+0,#+1
        STRB     R1,[SP, #+0]
        AND      R0,R1,#0xFD
        LSL      R1,R10,#+1
        AND      R1,R1,#0x2
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xFB
        LSLS     R1,R7,#+2
        AND      R1,R1,#0x4
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xF7
        LSLS     R1,R6,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xEF
        LSLS     R1,R4,#+4
        AND      R1,R1,#0x10
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xDF
        LSLS     R1,R5,#+5
        AND      R1,R1,#0x20
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xBF
        LSL      R1,R9,#+6
        AND      R1,R1,#0x40
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
//  562 
//  563 	WriteFPGAs(ch, ADDR_INPUTSEL, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+4
        MOV      R0,R8
        BL       WriteFPGAs
//  564 
//  565 	return tmp.Data;
        LDRB     R0,[SP, #+0]
        POP      {R1,R4-R11,PC}   ;; return
//  566 }
//  567 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  568 void AD9362CLKSelect(INT8U ch, INT8U type)
//  569 {
AD9362CLKSelect:
        PUSH     {R2-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
//  570 	{
//  571 		union __ADDR_0x009{
//  572 			INT8U Data;
//  573 			struct{
//  574 				INT8U BBPLLEn			:1;
//  575 				INT8U DCXOEn			:1;
//  576 				INT8U DigPwrUp			:1;
//  577 				INT8U BBPLLForceLock	:1;
//  578 				
//  579 				INT8U XOBypass			:1;
//  580 				INT8U BypassBBPLL		:1;
//  581 			};
//  582 		} tmp;
//  583 		
//  584 		ReadFPGAs(ch, ADDR_CLKEN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+9
        BL       ReadFPGAs
//  585 
//  586 		tmp.BBPLLEn = SET;
        LDRB     R0,[SP, #+0]
        ORR      R0,R0,#0x1
        STRB     R0,[SP, #+0]
//  587 		if(type == XTALN)
        CBNZ.N   R5,??AD9362CLKSelect_0
//  588 		{
//  589 			tmp.DCXOEn = SET;
//  590 			tmp.XOBypass = SET;
        ORR      R0,R0,#0x12
        B.N      ??AD9362CLKSelect_1
//  591 		}
//  592 		else if(type == REFCLK)
??AD9362CLKSelect_0:
        CMP      R5,#+1
        IT       EQ 
        ANDEQ    R0,R0,#0xED
//  593 		{
//  594 			tmp.DCXOEn = RESET;
//  595 			tmp.XOBypass = RESET;
        BEQ.N    ??AD9362CLKSelect_1
//  596 		}
//  597 		else if(type == DCXOCLK)
        CMP      R5,#+2
        BNE.N    ??AD9362CLKSelect_2
//  598 		{
//  599 			tmp.DCXOEn = SET;
//  600 			tmp.XOBypass = RESET;
        AND      R0,R0,#0xEF
        STRB     R0,[SP, #+0]
        ORR      R0,R0,#0x2
??AD9362CLKSelect_1:
        STRB     R0,[SP, #+0]
//  601 		}
//  602 		WriteFPGAs(ch, ADDR_CLKEN, &tmp.Data, 1);
??AD9362CLKSelect_2:
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+9
        MOV      R0,R4
        BL       WriteFPGAs
//  603 	}
//  604 
//  605 	{
//  606 		union __ADDR_0x2AB{
//  607 			INT8U Data;
//  608 			struct{
//  609 				INT8U RxRefDiv			:1;
//  610 				INT8U RxrefRstBar		:1;
//  611 				INT8U RefclkPwrDn		:1;
//  612 			};
//  613 		} tmp;
//  614 		
//  615 		ReadFPGAs(ch, ADDR_REFDIV1, &tmp.Data, 1);
        MOVW     R6,#+683
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOV      R1,R6
        MOV      R0,R4
        BL       ReadFPGAs
//  616 
//  617 			 if(type == XTALN) 	tmp.RefclkPwrDn = SET;
        CBZ.N    R5,??AD9362CLKSelect_3
//  618 		else if(type == REFCLK) tmp.RefclkPwrDn = RESET;
        CMP      R5,#+1
        ITT      EQ 
        LDRBEQ   R0,[SP, #+4]
        ANDEQ    R0,R0,#0xFB
        BEQ.N    ??AD9362CLKSelect_4
//  619 		else if(type == DCXOCLK)tmp.RefclkPwrDn = SET;
        CMP      R5,#+2
        BNE.N    ??AD9362CLKSelect_5
??AD9362CLKSelect_3:
        LDRB     R0,[SP, #+4]
        ORR      R0,R0,#0x4
??AD9362CLKSelect_4:
        STRB     R0,[SP, #+4]
//  620 
//  621 		WriteFPGAs(ch, ADDR_REFDIV1, &tmp.Data, 1);
??AD9362CLKSelect_5:
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        B.N      ?Subroutine3
//  622 	}
//  623 }
//  624 
//  625 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  626 INT8U AD8362BPPLLWrite(INT8U ch, INT32U fLo)
//  627 {
AD8362BPPLLWrite:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+24
        MOV      R4,R0
        MOV      R5,R1
//  628 	{
//  629 #define BPPLLx1			0x00
//  630 #define BPPLLd2			0x01
//  631 #define BPPLLd4			0x02
//  632 #define BPPLLx2			0x03
//  633 
//  634 		union __ADDR_0x045{
//  635 			INT8U Data;
//  636 			struct{
//  637 				INT8U RefClkSclaer		:2;
//  638 				INT8U PFDClkEdge		:1;
//  639 				INT8U PFDRstDelay		:2;
//  640 				
//  641 				INT8U RefClkInv			:1;
//  642 				INT8U FBClkInv			:1;
//  643 				INT8U PLLFBInv			:1;
//  644 			};
//  645 		} tmp;
//  646 		
//  647 		ReadFPGAs(ch, ADDR_BBCLKCTRL, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+12
        MOVS     R1,#+69
        BL       ReadFPGAs
//  648 		tmp.RefClkSclaer = BPPLLx2;
        LDRB     R0,[SP, #+12]
        ORR      R0,R0,#0x3
        STRB     R0,[SP, #+12]
//  649 		WriteFPGAs(ch, ADDR_BBCLKCTRL, &tmp.Data, 1);	// Set BBPLL reflclk scale to REFCLK * 2
        MOVS     R3,#+1
        ADD      R2,SP,#+12
        MOVS     R1,#+69
        MOV      R0,R4
        BL       WriteFPGAs
//  650 	}
//  651 
//  652 	WriteAD9362(ch, 0x046, 0x03);	// Set BBPLL Loop Filter Charge Pump current
        MOVS     R0,#+3
        STRB     R0,[SP, #+21]
        MOVS     R3,#+1
        ADD      R2,SP,#+21
        MOVS     R1,#+70
        MOV      R0,R4
        BL       WriteFPGAs
//  653 	WriteAD9362(ch, 0x048, 0xE8);	// Set BBPLL Loop Filter C1, R1
        MOVS     R0,#+232
        STRB     R0,[SP, #+20]
        MOVS     R3,#+1
        ADD      R2,SP,#+20
        MOVS     R1,#+72
        MOV      R0,R4
        BL       WriteFPGAs
//  654 	WriteAD9362(ch, 0x049, 0x5B);	// Set BBPLL Loop Filter R2, C2, C1
        MOVS     R0,#+91
        STRB     R0,[SP, #+11]
        MOVS     R3,#+1
        ADD      R2,SP,#+11
        MOVS     R1,#+73
        MOV      R0,R4
        BL       WriteFPGAs
//  655 	WriteAD9362(ch, 0x04A, 0x35);	// Set BBPLL Loop Filter C3,R2
        MOVS     R0,#+53
        STRB     R0,[SP, #+10]
        MOVS     R3,#+1
        ADD      R2,SP,#+10
        MOVS     R1,#+74
        MOV      R0,R4
        BL       WriteFPGAs
//  656 	WriteAD9362(ch, 0x04B, 0xE0);	// Allow calibration to occur and set cal count to 1024 for max accuracy
        MOVS     R0,#+224
        STRB     R0,[SP, #+9]
        MOVS     R3,#+1
        ADD      R2,SP,#+9
        MOVS     R1,#+75
        MOV      R0,R4
        BL       WriteFPGAs
//  657 	WriteAD9362(ch, 0x04E, 0x10);	// Set calibration clock to REFCLK/4 for more accuracy
        MOVS     R0,#+16
        STRB     R0,[SP, #+8]
        MOVS     R3,#+1
        ADD      R2,SP,#+8
        MOVS     R1,#+78
        MOV      R0,R4
        BL       WriteFPGAs
//  658 	{
//  659 		unsigned long int PLL_INT = 0;
//  660 		unsigned long int PLL_MOD = 0;
//  661 		
//  662 		INT8U tmp;
//  663 		
//  664 		PLL_INT = fLo/AD9362BPPRefClk;
        LDR.N    R0,??DataTable2_11  ;; 0x3a98000
        UDIV     R6,R5,R0
//  665 		PLL_MOD = (unsigned int)((((float)fLo / (float)AD9362BPPRefClk) - (float)PLL_INT)* 2088960); 
        MOV      R0,R5
        BL       __aeabi_ui2f
        LDR.N    R1,??DataTable2_12  ;; 0x4c6a6000
        BL       __aeabi_fdiv
        MOV      R5,R0
        MOV      R0,R6
        BL       __aeabi_ui2f
        MOV      R1,R0
        MOV      R0,R5
        BL       __aeabi_fsub
        LDR.N    R1,??DataTable2_13  ;; 0x49ff0000
        BL       __aeabi_fmul
        BL       __aeabi_f2uiz
        MOV      R5,R0
//  666 //		tmp1	= ((float)fLo / (float)AD9362BPPRefClk);
//  667 //		SerPtr->printf("%d, %d %f, \n", PLL_INT, PLL_MOD, tmp1);
//  668 		tmp = PLL_INT;
        STRB     R6,[SP, #+0]
//  669 		WriteFPGAs(ch, ADDR_BBINT, &tmp, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+68
        MOV      R0,R4
        BL       WriteFPGAs
//  670 		tmp = (PLL_MOD >> 16) & 0xff;
        UBFX     R0,R5,#+16,#+8
        STRB     R0,[SP, #+0]
//  671 		WriteFPGAs(ch, ADDR_BBMOD1, &tmp, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+65
        MOV      R0,R4
        BL       WriteFPGAs
//  672 		tmp = (PLL_MOD >> 8) & 0xff;
        UBFX     R0,R5,#+8,#+8
        STRB     R0,[SP, #+0]
//  673 		WriteFPGAs(ch, ADDR_BBMOD2, &tmp, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+66
        MOV      R0,R4
        BL       WriteFPGAs
//  674 		tmp = (PLL_MOD >> 0) & 0xff;
        STRB     R5,[SP, #+0]
//  675 		WriteFPGAs(ch, ADDR_BBMOD3, &tmp, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+67
        MOV      R0,R4
        BL       WriteFPGAs
//  676 
//  677 	}
//  678 
//  679 	{
//  680 		union __ADDR_0x03F{
//  681 			INT8U Data;
//  682 			struct{
//  683 				INT8U BBPLLRstBar		:1;
//  684 				INT8U BBPLLSDMBypass	:1;
//  685 				INT8U InitBBFOCAL		:1;
//  686 				INT8U BBPLLSDMClkEnBar	:1;
//  687 				
//  688 				INT8U SDMSIFData		:4;
//  689 			};
//  690 		} tmp;
//  691 		
//  692 		ReadFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOVS     R1,#+63
        MOV      R0,R4
        BL       ReadFPGAs
//  693 		tmp.BBPLLRstBar = SET;
//  694 		tmp.InitBBFOCAL = SET;
        LDRB     R0,[SP, #+4]
        ORR      R0,R0,#0x5
        STRB     R0,[SP, #+4]
//  695 		WriteFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1);	// Start BBPLL Calibration
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOVS     R1,#+63
        MOV      R0,R4
        BL       WriteFPGAs
//  696 
//  697 		ReadFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOVS     R1,#+63
        MOV      R0,R4
        BL       ReadFPGAs
//  698 		tmp.InitBBFOCAL = RESET;
        LDRB     R0,[SP, #+4]
        AND      R0,R0,#0xFB
        STRB     R0,[SP, #+4]
//  699 		WriteFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1); 	// Clear BBPLL start calibration bit
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOVS     R1,#+63
        MOV      R0,R4
        BL       WriteFPGAs
//  700 	}
//  701 
//  702 	WriteAD9362(ch, 0x04C, 0x86);	// Increase BBPLL KV and phase margin
        MOVS     R0,#+134
        STRB     R0,[SP, #+3]
        MOVS     R3,#+1
        ADD      R2,SP,#+3
        MOVS     R1,#+76
        MOV      R0,R4
        BL       WriteFPGAs
//  703 	WriteAD9362(ch, 0x04D, 0x01);	// Increase BBPLL KV and phase margin
        MOVS     R0,#+1
        STRB     R0,[SP, #+2]
        MOVS     R3,#+1
        ADD      R2,SP,#+2
        MOVS     R1,#+77
        MOV      R0,R4
        BL       WriteFPGAs
//  704 	WriteAD9362(ch, 0x04D, 0x05);	// Increase BBPLL KV and phase margin
        MOVS     R0,#+5
        STRB     R0,[SP, #+1]
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        MOVS     R1,#+77
        MOV      R0,R4
        BL       WriteFPGAs
//  705 
//  706 	{
//  707 		union __ADDR_0x05E{
//  708 			INT8U Data;
//  709 			struct{
//  710 				INT8U 				:7;
//  711 				INT8U BBPLLLock		:1;
//  712 			};
//  713 		} tmp;
//  714 		INT8U rtry = 100;
        MOVS     R5,#+100
//  715 		
//  716 		tmp.BBPLLLock = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+16]
        B.N      ??AD8362BPPLLWrite_0
//  717 		while(!tmp.BBPLLLock && rtry--)
//  718 		{
//  719 			ReadFPGAs(ch, 0x05E, &tmp.Data, 1); // Check BBPLL locked status  (0x05E[7]==1 is locked)
??AD8362BPPLLWrite_1:
        MOVS     R3,#+1
        ADD      R2,SP,#+16
        MOVS     R1,#+94
        MOV      R0,R4
        BL       ReadFPGAs
//  720 			OSTimeDly(100L);
        MOVS     R0,#+100
        BL       OSTimeDly
//  721 		}
??AD8362BPPLLWrite_0:
        LDRB     R0,[SP, #+16]
        LSLS     R0,R0,#+24
        BMI.N    ??AD8362BPPLLWrite_2
        MOV      R0,R5
        SUBS     R5,R0,#+1
        UXTB     R0,R0
        CMP      R0,#+0
        BNE.N    ??AD8362BPPLLWrite_1
//  722 
//  723 		return tmp.BBPLLLock;
??AD8362BPPLLWrite_2:
        LDRB     R0,[SP, #+16]
        LSRS     R0,R0,#+7
        ADD      SP,SP,#+24
        POP      {R4-R6,PC}       ;; return
//  724 	}
//  725 }
//  726 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  727 INT8U AD9362RxLOPLLCtrl(INT8U ch, INT64U fLo, INT32U offset)
//  728 {
AD9362RxLOPLLCtrl:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+12
        MOV      R5,R0
        MOV      R6,R2
        MOV      R9,R3
        LDR      R7,[SP, #+40]
//  729 	unsigned long long int FrfVCO;
//  730 	unsigned int Fref = AD9362RefClk;
        LDR.N    R4,??DataTable2_14  ;; 0x1d4c000
//  731 	unsigned int VCODivider = 0;	
//  732 	int i = 0;
//  733 	INT8U multiplier = 0;
//  734 
//  735 
//  736 	VCODivider = (ReadAD9362(ch, ADDR_RFPLLDIVIDER) & 0x03);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+5
        BL       ReadFPGAs
//  737 
//  738 	for(i = 0, multiplier = 1; i < VCODivider + 1; i++)
        MOVS     R0,#+1
        LDRB     R1,[SP, #+0]
        AND      R1,R1,#0x3
        ADDS     R1,R1,#+1
//  739 	{
//  740 		multiplier = multiplier*2;		
??AD9362RxLOPLLCtrl_0:
        LSLS     R0,R0,#+1
//  741 	}
        SUBS     R1,R1,#+1
        BNE.N    ??AD9362RxLOPLLCtrl_0
//  742 
//  743 	FrfVCO = fLo*multiplier;
        MOV      R3,R9
        UXTB     R0,R0
        UMULL    R8,R9,R0,R6
        MLA      R9,R0,R3,R9
//  744 
//  745 	{
//  746 		INT8U A_Div = 0;
        MOVS     R6,#+0
//  747 		union __ADDR_0x2AB {
//  748 			INT8U Data;
//  749 			struct {
//  750 				INT8U RxRefDiv1			:1;
//  751 				INT8U RxRefRstBar		:1;
//  752 				INT8U RefClkInPwrDn		:1;
//  753 			};
//  754 		} A_2AB;
//  755 
//  756 		union __ADDR_0x2AC {
//  757 			INT8U Data;
//  758 			struct {
//  759 				INT8U TxRefFBDelay		:2;
//  760 				INT8U TxRefDiv			:2;
//  761 
//  762 				INT8U TxRefRstBar		:1;
//  763 				INT8U RxRefFBDelay		:2;
//  764 				INT8U RxRefDiv0			:1;
//  765 			};
//  766 		} A_2AC;
//  767 
//  768 		A_2AB.Data = ReadAD9362(ch, ADDR_REFDIV1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+683
        MOV      R0,R5
        BL       ReadFPGAs
//  769 		A_2AC.Data = ReadAD9362(ch, ADDR_REFDIV2);
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        MOV      R1,#+684
        MOV      R0,R5
        BL       ReadFPGAs
        LDRB     R0,[SP, #+1]
        STRB     R0,[SP, #+8]
//  770 
//  771 		if(A_2AB.RxRefDiv1) BitSet(A_Div, 1);
        LDRB     R0,[SP, #+0]
        LSLS     R0,R0,#+31
        IT       MI 
        MOVMI    R6,#+2
//  772 		if(A_2AC.RxRefDiv0) BitSet(A_Div, 0);
        LDRB     R0,[SP, #+8]
        LSLS     R0,R0,#+24
        IT       MI 
        ORRMI    R6,R6,#0x1
//  773 
//  774 		     if(A_Div == 0)	Fref = Fref * 1;
        CBZ.N    R6,??AD9362RxLOPLLCtrl_1
//  775 		else if(A_Div == 1)	Fref = Fref / 2;
        CMP      R6,#+1
        IT       EQ 
        LDREQ.N  R4,??DataTable2_15  ;; 0xea6000
        BEQ.N    ??AD9362RxLOPLLCtrl_1
//  776 		else if(A_Div == 2)	Fref = Fref / 4;
        CMP      R6,#+2
        ITE      EQ 
        LDREQ.N  R4,??DataTable2_16  ;; 0x753000
        LDRNE.N  R4,??DataTable2_11  ;; 0x3a98000
//  777 		else				Fref = Fref * 2;
//  778 		
//  779 	}
//  780 
//  781 	{
//  782 		unsigned long int PLL_INT = 0;
//  783 		unsigned long int PLL_MOD = 0;
//  784 		
//  785 		PLL_INT = FrfVCO/Fref;
??AD9362RxLOPLLCtrl_1:
        MOV      R0,R8
        MOV      R1,R9
        MOV      R2,R4
        MOVS     R3,#+0
        BL       __aeabi_uldivmod
        MOV      R6,R0
//  786 		PLL_MOD = (unsigned int)((((double)FrfVCO / (double)Fref) - (float)PLL_INT)* 8388593);
//  787 		PLL_MOD += offset;
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ul2d
        MOV      R8,R0
        MOV      R9,R1
        MOV      R0,R4
        BL       __aeabi_ui2d
        MOV      R2,R0
        MOV      R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        MOV      R4,R0
        MOV      R9,R1
        MOV      R0,R6
        BL       __aeabi_ui2f
        BL       __aeabi_f2d
        MOV      R2,R0
        MOV      R3,R1
        MOV      R0,R4
        MOV      R1,R9
        BL       __aeabi_dsub
        MOV      R2,#+1073741824
        LDR.N    R3,??DataTable2_17  ;; 0x415ffffc
        BL       __aeabi_dmul
        BL       __aeabi_d2uiz
        ADDS     R4,R7,R0
//  788 
//  789 		WriteAD9362(ch, ADDR_RXFRAC0, (PLL_MOD >>  0) & 0xff);
        STRB     R4,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+563
        MOV      R0,R5
        BL       WriteFPGAs
//  790 		WriteAD9362(ch, ADDR_RXFRAC1, (PLL_MOD >>  8)& 0xff);
        UBFX     R0,R4,#+8,#+8
        STRB     R0,[SP, #+1]
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        MOV      R1,#+564
        MOV      R0,R5
        BL       WriteFPGAs
//  791 		WriteAD9362(ch, ADDR_RXFRAC2, (PLL_MOD >> 16) & 0xff);
        UBFX     R0,R4,#+16,#+8
        STRB     R0,[SP, #+4]
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOVW     R1,#+565
        MOV      R0,R5
        BL       WriteFPGAs
//  792 		
//  793 		WriteAD9362(ch, ADDR_RXINT1, (PLL_INT >> 8) & 0xff);
        UBFX     R0,R6,#+8,#+8
        STRB     R0,[SP, #+3]
        MOVS     R3,#+1
        ADD      R2,SP,#+3
        MOVW     R1,#+562
        MOV      R0,R5
        BL       WriteFPGAs
//  794 		WriteAD9362(ch, ADDR_RXINT0, (PLL_INT >> 0) & 0xff);
        STRB     R6,[SP, #+2]
        MOVS     R3,#+1
        ADD      R2,SP,#+2
        MOVW     R1,#+561
        MOV      R0,R5
        BL       WriteFPGAs
//  795 
//  796 	//SerPtr->printf("PLL_INT = %d \n", PLL_INT);
//  797 	//SerPtr->printf("0x231 = %02x, 0x232 = %02x \n", PLL_INT & 0xFF, (PLL_INT >> 8) & 0x07); 
//  798 	//SerPtr->printf("0x233 = %02x, 0x234 = %02x 0x235 = %02x\n", PLL_MOD & 0xFF, (PLL_MOD >> 8) & 0xFF, (PLL_MOD >> 16)& 0xFF); 
//  799 
//  800 	}
//  801 
//  802 	{
//  803 		INT8U tmp = 0;
//  804 		INT8U rtry = 100;
        MOVS     R4,#+100
        MOVW     R6,#+583
        B.N      ?Subroutine4
//  805 		
//  806 		while(rtry--)
//  807 		{
//  808 			tmp = ReadAD9362(ch, 0x247); // Check BBPLL locked status  (0x05E[7]==1 is locked)
//  809 			if(BitRead(tmp, 1)) break;
//  810 			OSTimeDly(20L);
//  811 		}
//  812 		return (!BitRead(tmp, 1));
//  813 	}
//  814 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     0x1ffff7e0

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_1:
        DC32     0x8006800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_2:
        DC32     0x8006000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_3:
        DC32     0x8005800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_4:
        DC32     0x8004800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_5:
        DC32     0x8003800

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_6:
        DC32     0x8005000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_7:
        DC32     0x8004000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_8:
        DC32     0x8003000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_9:
        DC32     AD9362SetAddr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_10:
        DC32     SerPtr

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_11:
        DC32     0x3a98000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_12:
        DC32     0x4c6a6000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_13:
        DC32     0x49ff0000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_14:
        DC32     0x1d4c000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_15:
        DC32     0xea6000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_16:
        DC32     0x753000

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2_17:
        DC32     0x415ffffc
//  815 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  816 INT8U AD9362TxLOPLLCtrl(INT8U ch, INT64U fLo, INT32U offset)
//  817 {
AD9362TxLOPLLCtrl:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+12
        MOV      R5,R0
        MOV      R6,R2
        MOV      R9,R3
        LDR      R7,[SP, #+40]
//  818 
//  819 	unsigned long long int FrfVCO;
//  820 	unsigned int Fref = AD9362RefClk;
        LDR.N    R4,??AD9362TxLOPLLCtrl_0  ;; 0x1d4c000
//  821 	unsigned int VCODivider = ((ReadAD9362(ch, ADDR_RFPLLDIVIDER) >> 4) & 0x03);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+5
        BL       ReadFPGAs
//  822 	
//  823 	int i = 0;
//  824 	INT8U multiplier = 0;
//  825 	
//  826 	for(i = 0, multiplier = 1; i < VCODivider + 1; i++)
        MOVS     R0,#+1
        LDRB     R1,[SP, #+0]
        ASRS     R1,R1,#+4
        AND      R1,R1,#0x3
        ADDS     R1,R1,#+1
//  827 	{
//  828 		multiplier = multiplier*2;		
??AD9362TxLOPLLCtrl_1:
        LSLS     R0,R0,#+1
//  829 	}
        SUBS     R1,R1,#+1
        BNE.N    ??AD9362TxLOPLLCtrl_1
//  830 
//  831 	FrfVCO = fLo*multiplier;
        MOV      R3,R9
        UXTB     R0,R0
        UMULL    R8,R9,R0,R6
        MLA      R9,R0,R3,R9
//  832 
//  833 	{
//  834 		INT8U A_Div = 0;
//  835 
//  836 		union __ADDR_0x2AC {
//  837 			INT8U Data;
//  838 			struct {
//  839 				INT8U TxRefFBDelay		:2;
//  840 				INT8U TxRefDiv			:2;
//  841 
//  842 				INT8U TxRefRstBar		:1;
//  843 				INT8U RxRefFBDelay		:2;
//  844 				INT8U RxRefDiv0			:1;
//  845 			};
//  846 		} A_2AC;
//  847 
//  848 		A_2AC.Data = ReadAD9362(ch, ADDR_REFDIV2);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOV      R1,#+684
        MOV      R0,R5
        BL       ReadFPGAs
//  849 
//  850 		A_Div = A_2AC.TxRefDiv;
        LDRB     R0,[SP, #+0]
        UBFX     R0,R0,#+2,#+2
//  851 		
//  852 		     if(A_Div == 0)	Fref = Fref * 1;
        CBZ.N    R0,??AD9362TxLOPLLCtrl_2
//  853 		else if(A_Div == 1)	Fref = Fref / 2;
        CMP      R0,#+1
        IT       EQ 
        LDREQ.N  R4,??AD9362TxLOPLLCtrl_0+0x4  ;; 0xea6000
        BEQ.N    ??AD9362TxLOPLLCtrl_2
//  854 		else if(A_Div == 2)	Fref = Fref / 4;
        CMP      R0,#+2
        ITE      EQ 
        LDREQ.N  R4,??AD9362TxLOPLLCtrl_0+0x8  ;; 0x753000
        LDRNE.N  R4,??AD9362TxLOPLLCtrl_0+0xC  ;; 0x3a98000
//  855 		else				Fref = Fref * 2;
//  856 		
//  857 	}
//  858 
//  859 	{
//  860 		unsigned long int PLL_INT = 0;
//  861 		unsigned long int PLL_MOD = 0;
//  862 		
//  863 		PLL_INT = FrfVCO/Fref;
??AD9362TxLOPLLCtrl_2:
        MOV      R0,R8
        MOV      R1,R9
        MOV      R2,R4
        MOVS     R3,#+0
        BL       __aeabi_uldivmod
        MOV      R6,R0
//  864 		PLL_MOD = (unsigned int)((((double)FrfVCO / (double)Fref) - (float)PLL_INT)* 8388593);
//  865 		PLL_MOD += offset;
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ul2d
        MOV      R8,R0
        MOV      R9,R1
        MOV      R0,R4
        BL       __aeabi_ui2d
        MOV      R2,R0
        MOV      R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_ddiv
        MOV      R4,R0
        MOV      R9,R1
        MOV      R0,R6
        BL       __aeabi_ui2f
        BL       __aeabi_f2d
        MOV      R2,R0
        MOV      R3,R1
        MOV      R0,R4
        MOV      R1,R9
        BL       __aeabi_dsub
        MOV      R2,#+1073741824
        LDR.N    R3,??AD9362TxLOPLLCtrl_0+0x10  ;; 0x415ffffc
        B.N      ??AD9362TxLOPLLCtrl_3
        DATA
??AD9362TxLOPLLCtrl_0:
        DC32     0x1d4c000
        DC32     0xea6000
        DC32     0x753000
        DC32     0x3a98000
        DC32     0x415ffffc
        THUMB
??AD9362TxLOPLLCtrl_3:
        BL       __aeabi_dmul
        BL       __aeabi_d2uiz
        ADDS     R4,R7,R0
//  866 		
//  867 		WriteAD9362(ch, ADDR_TXFRAC0, (PLL_MOD >>  0) & 0xff);
        STRB     R4,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+627
        MOV      R0,R5
        BL       WriteFPGAs
//  868 		WriteAD9362(ch, ADDR_TXFRAC1, (PLL_MOD >>  8)& 0xff);
        UBFX     R0,R4,#+8,#+8
        STRB     R0,[SP, #+4]
        MOVS     R3,#+1
        ADD      R2,SP,#+4
        MOV      R1,#+628
        MOV      R0,R5
        BL       WriteFPGAs
//  869 		WriteAD9362(ch, ADDR_TXFRAC2, (PLL_MOD >> 16) & 0xff);
        UBFX     R0,R4,#+16,#+8
        STRB     R0,[SP, #+3]
        MOVS     R3,#+1
        ADD      R2,SP,#+3
        MOVW     R1,#+629
        MOV      R0,R5
        BL       WriteFPGAs
//  870 		
//  871 		WriteAD9362(ch, ADDR_TXINT1, (PLL_INT >> 8) & 0xff);
        UBFX     R0,R6,#+8,#+8
        STRB     R0,[SP, #+2]
        MOVS     R3,#+1
        ADD      R2,SP,#+2
        MOVW     R1,#+626
        MOV      R0,R5
        BL       WriteFPGAs
//  872 		WriteAD9362(ch, ADDR_TXINT0, (PLL_INT >> 0) & 0xff);
        STRB     R6,[SP, #+1]
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        MOVW     R1,#+625
        MOV      R0,R5
        BL       WriteFPGAs
//  873 	}
//  874 
//  875 	{
//  876 		INT8U tmp = 0;
//  877 		INT8U rtry = 100;
        MOVS     R4,#+100
        MOVW     R6,#+647
        REQUIRE ?Subroutine4
        ;; // Fall through to label ?Subroutine4
//  878 		
//  879 		while(rtry--)
//  880 		{
//  881 			tmp = ReadAD9362(ch, 0x287); // Check BBPLL locked status  (0x05E[7]==1 is locked)
//  882 			if(BitRead(tmp, 1)) break;
//  883 			OSTimeDly(20L);
//  884 		}
//  885 		return (!BitRead(tmp, 1));
//  886 	}
//  887 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine4:
        SUBS     R4,R4,#+1
        UXTB     R4,R4
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOV      R1,R6
        MOV      R0,R5
        BL       ReadFPGAs
        LDRB     R7,[SP, #+0]
        LSLS     R0,R7,#+30
        BMI.N    ??Subroutine4_0
        MOVS     R0,#+20
        BL       OSTimeDly
        CMP      R4,#+0
        BNE.N    ?Subroutine4
??Subroutine4_0:
        ASRS     R0,R7,#+1
        AND      R0,R0,#0x1
        EOR      R0,R0,#0x1
        ADD      SP,SP,#+12
        POP      {R4-R9,PC}       ;; return
//  888 
//  889 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  890 void AD9362BPPLLCtrl(INT8U ch, INT8U ADCDiv, INT8U DACDiv2En)
//  891 {
AD9362BPPLLCtrl:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//  892 	union __ADDR_0x00A{
//  893 		INT8U Data;
//  894 		struct{
//  895 			INT8U BBPLLDiv			:3;
//  896 			INT8U DACDiv2En			:1;
//  897 			
//  898 			INT8U CLKOutEn			:1;
//  899 			INT8U CLKOutSel			:3;
//  900 		};
//  901 	} tmp;
//  902 	
//  903 	ReadFPGAs(ch, ADDR_BPPLL, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+10
        BL       ReadFPGAs
//  904 
//  905 	tmp.BBPLLDiv = ADCDiv;
//  906 	tmp.DACDiv2En = DACDiv2En;
        LDRB     R0,[SP, #+0]
        BFI      R0,R5,#+0,#+3
        STRB     R0,[SP, #+0]
        AND      R0,R0,#0xF7
        LSLS     R1,R6,#+3
        AND      R1,R1,#0x8
        ORRS     R0,R1,R0
        STRB     R0,[SP, #+0]
//  907 
//  908 	WriteFPGAs(ch, ADDR_BPPLL, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+10
        B.N      ??Subroutine3_0
//  909 
//  910 }
//  911 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  912 void AD9362RxFilterConf(INT8U ch, INT8U NoOfTabs)
//  913 {
AD9362RxFilterConf:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  914 	union __ADDR_0x0F5{
//  915 		INT8U Data;
//  916 		struct{
//  917 			INT8U 					:1;
//  918 			INT8U StarRxClk 		:1;
//  919 			INT8U WriteRx			:1;
//  920 			INT8U Rx1Sel			:1;
//  921 
//  922 			INT8U Rx2Sel			:1;
//  923 			INT8U NoOfTabs			:3;
//  924 		};
//  925 	} tmp;
//  926 
//  927 	ReadFPGAs(ch, ADDR_RXFILTER, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+245
        BL       ReadFPGAs
//  928 
//  929 	tmp.NoOfTabs = NoOfTabs;
        LDRB     R0,[SP, #+0]
        BFI      R0,R5,#+5,#+3
        STRB     R0,[SP, #+0]
//  930 
//  931 	WriteFPGAs(ch, ADDR_RXFILTER, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+245
        B.N      ?Subroutine5
//  932 	
//  933 
//  934 }
//  935 
//  936 
//  937 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  938 void AD9362RxFilterGain(INT8U ch, INT8U Gain)
//  939 {
AD9362RxFilterGain:
        PUSH     {R7,LR}
//  940 	union __ADDR_0x0F6{
//  941 		INT8U Data;
//  942 		struct{
//  943 			INT8U Gain			:2;
//  944 		};
//  945 	} tmp;
//  946 
//  947 	tmp.Data = 0;
//  948 	
//  949 	tmp.Gain = Gain;
        AND      R1,R1,#0x3
        STRB     R1,[SP, #+0]
//  950 
//  951 	WriteFPGAs(ch, ADDR_RXFILTERGAIN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+246
        B.N      ?Subroutine6
//  952 }
//  953 
//  954 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  955 void AD9362TxFilterConf(INT8U ch, INT8U NoOfTabs, INT8U Gain)
//  956 {
AD9362TxFilterConf:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  957 	union __ADDR_0x065{
//  958 		INT8U Data;
//  959 		struct{
//  960 			INT8U Gain				:1;
//  961 			INT8U StarTxClk			:1;
//  962 			INT8U WriteTx			:1;
//  963 			INT8U Tx1Sel			:1;
//  964 
//  965 			INT8U Tx2Sel			:1;
//  966 			INT8U NoOfTabs			:3;
//  967 		};
//  968 	} tmp;
//  969 
//  970 	ReadFPGAs(ch, ADDR_TXFILTER, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+101
        BL       ReadFPGAs
//  971 
//  972 	tmp.NoOfTabs = NoOfTabs;
        LDRB     R0,[SP, #+0]
        BFI      R0,R5,#+5,#+3
        STRB     R0,[SP, #+0]
//  973 
//  974 	WriteFPGAs(ch, ADDR_TXFILTER, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+101
        REQUIRE ?Subroutine5
        ;; // Fall through to label ?Subroutine5
//  975 	
//  976 
//  977 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine5:
        MOV      R0,R4
        BL       WriteFPGAs
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  978 void AD9362DCXOSet(INT8U ch, INT8U Coarse, INT16U Fine)
//  979 {
AD9362DCXOSet:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+8
        MOV      R4,R0
        MOV      R5,R2
//  980 	INT8U tmp;
//  981 
//  982 	tmp = Coarse;
        STRB     R1,[SP, #+0]
//  983 	//SerPtr->printf("1. %02x \n", tmp);
//  984 	WriteFPGAs(ch, ADDR_DCXOCOAR, &tmp, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+658
        BL       WriteFPGAs
//  985 
//  986 	tmp = (Fine >> 5);
        UBFX     R0,R5,#+5,#+8
        STRB     R0,[SP, #+0]
//  987 	//SerPtr->printf("2. %02x \n", tmp);
//  988 	WriteFPGAs(ch, ADDR_DCXOFINE2, &tmp, 1);
        MOVW     R6,#+659
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOV      R1,R6
        MOV      R0,R4
        BL       WriteFPGAs
//  989 	
//  990 	tmp = (Fine >> 0) & 0x1f;
        AND      R0,R5,#0x1F
        STRB     R0,[SP, #+0]
//  991 	//SerPtr->printf("3. %02x \n", tmp);
//  992 	WriteFPGAs(ch, ADDR_DCXOFINE2, &tmp, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        REQUIRE ?Subroutine3
        ;; // Fall through to label ?Subroutine3
//  993 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine3:
        MOV      R1,R6
??Subroutine3_0:
        MOV      R0,R4
        BL       WriteFPGAs
        POP      {R0,R1,R4-R6,PC}  ;; return
//  994 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  995 void AD9362Rx1GainSet(INT8U ch, INT8U gain)
//  996 {
AD9362Rx1GainSet:
        PUSH     {R7,LR}
//  997 	INT8U tmp = gain + 5;	
//  998 	WriteAD9362(ch, ADDR_RX1MANGAIN, tmp);
        ADDS     R1,R1,#+5
        STRB     R1,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVW     R1,#+265
        REQUIRE ?Subroutine6
        ;; // Fall through to label ?Subroutine6
//  999 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine6:
        BL       WriteFPGAs
        POP      {R0,PC}          ;; return
// 1000 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1001 void AD9362Rx2GainSet(INT8U ch, INT8U gain)
// 1002 {
AD9362Rx2GainSet:
        PUSH     {R7,LR}
// 1003 	INT8U tmp = gain + 5;	
// 1004 	WriteAD9362(ch, ADDR_RX2MANGAIN, tmp);
        ADDS     R1,R1,#+5
        STRB     R1,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOV      R1,#+268
        B.N      ?Subroutine6
// 1005 }
// 1006 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1007 void AD9362Tx1AttnSet(INT8U ch, INT16U Tx1Attn)	// 0.25/dB
// 1008 {
AD9362Tx1AttnSet:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
// 1009 
// 1010 	WriteAD9362(ch, ADDR_TX1ATTN0, (Tx1Attn >> 0) & 0xff);
        STRB     R5,[SP, #+1]
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        MOVS     R1,#+115
        BL       WriteFPGAs
// 1011 	WriteAD9362(ch, ADDR_TX1ATTN1, (Tx1Attn >> 8) & 0x01);
        UBFX     R0,R5,#+8,#+1
        STRB     R0,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+116
        B.N      ?Subroutine5
// 1012 }
// 1013 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1014 void AD9362Tx2AttnSet(INT8U ch, INT16U Tx2Attn)	// 0.25/dB
// 1015 {
AD9362Tx2AttnSet:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
// 1016 
// 1017 	WriteAD9362(ch, ADDR_TX2ATTN0, (Tx2Attn >> 0) & 0xff);
        STRB     R5,[SP, #+1]
        MOVS     R3,#+1
        ADD      R2,SP,#+1
        MOVS     R1,#+117
        BL       WriteFPGAs
// 1018 	WriteAD9362(ch, ADDR_TX2ATTN1, (Tx2Attn >> 8) & 0x01);
        UBFX     R0,R5,#+8,#+1
        STRB     R0,[SP, #+0]
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+118
        B.N      ?Subroutine5
// 1019 }
// 1020 
// 1021 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1022 INT8U AD9362GetRssi(INT8U ch, INT8U isItRx2)
// 1023 {
AD9362GetRssi:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
// 1024 	INT16U Addr = ADDR_RX1POWER;
        MOVW     R4,#+353
// 1025 	if(isItRx2) Addr =  ADDR_RX2POWER;
        CBZ.N    R1,??AD9362GetRssi_0
        MOVW     R4,#+355
// 1026 
// 1027 	return (ReadAD9362(ch, Addr));
??AD9362GetRssi_0:
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOV      R1,R4
        BL       ReadFPGAs
        LDRB     R0,[SP, #+0]
        POP      {R1,R2,R4,PC}    ;; return
// 1028 }
// 1029 
// 1030 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1031 void AD9362Tx12AllSel(INT8U ch, INT8U Tx1TTx2)
// 1032 {
AD9362Tx12AllSel:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
// 1033 	union __ADDR_0x079{
// 1034 		INT8U Data;
// 1035 		struct{
// 1036 			INT8U Tx1Attn			:5;
// 1037 			INT8U TPCModeTx1		:1;
// 1038 			INT8U Tx1TTx2			:1;
// 1039 		};
// 1040 	} tmp;
// 1041 
// 1042 	ReadFPGAs(ch, ADDR_TX1DIGATTN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+121
        BL       ReadFPGAs
// 1043 
// 1044 	tmp.Tx1TTx2 = Tx1TTx2;
        UBFX     R0,R5,#+0,#+1
        LDRB     R1,[SP, #+0]
        BFI      R1,R0,#+6,#+1
        STRB     R1,[SP, #+0]
// 1045 
// 1046 	WriteFPGAs(ch, ADDR_TX1DIGATTN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+121
        B.N      ?Subroutine5
// 1047 }
// 1048 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1049 void AD9362TxAttnUpdateEn(INT8U ch, INT8U iEn)
// 1050 {
AD9362TxAttnUpdateEn:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
// 1051 	union __ADDR_0x07C{
// 1052 		INT8U Data;
// 1053 		struct{
// 1054 			INT8U Tx2Attn			:5;
// 1055 			INT8U TPCModeTx2		:1;
// 1056 			INT8U UpdateTPAttn		:1;
// 1057 		};
// 1058 	} tmp;
// 1059 
// 1060 	ReadFPGAs(ch, ADDR_TX2DIGATTN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+124
        BL       ReadFPGAs
// 1061 
// 1062 	tmp.UpdateTPAttn = iEn;
        UBFX     R0,R5,#+0,#+1
        LDRB     R1,[SP, #+0]
        BFI      R1,R0,#+6,#+1
        STRB     R1,[SP, #+0]
// 1063 
// 1064 	WriteFPGAs(ch, ADDR_TX2DIGATTN, &tmp.Data, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        MOVS     R1,#+124
        B.N      ?Subroutine5
// 1065 }
// 1066 
// 1067 
// 1068 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1069 void WriteAD9362(INT8U OPCODE, INT16U ADDR, INT8U DATA)
// 1070 {
WriteAD9362:
        PUSH     {R2,LR}
// 1071 	WriteFPGAs(OPCODE, ADDR, (INT8U *)&DATA, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        B.N      ?Subroutine6
// 1072 }
// 1073 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1074 INT8U ReadAD9362(INT8U OPCODE, INT16U ADDR)
// 1075 {
ReadAD9362:
        PUSH     {R7,LR}
// 1076 	INT8U DATA;
// 1077 	
// 1078 	ReadFPGAs(OPCODE, ADDR, (INT8U *)&DATA, 1);
        MOVS     R3,#+1
        ADD      R2,SP,#+0
        BL       ReadFPGAs
// 1079 
// 1080 	return DATA;
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
// 1081 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        LDRB     R0,[SP, #+0]
        POP      {R1,PC}          ;; return

        END
// 1082 
// 1083 //////////////////////////////////////////////////////////////////////////////
// 1084 // End of Source File
// 1085 ////////////////////////
// 1086 
// 
// 5 192 bytes in section .rodata
// 3 566 bytes in section .text
// 
// 3 566 bytes of CODE  memory
// 5 192 bytes of CONST memory
//
//Errors: none
//Warnings: none
