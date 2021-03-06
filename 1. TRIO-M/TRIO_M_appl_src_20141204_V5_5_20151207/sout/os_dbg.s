///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:41 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Po /
//                    rts\os_dbg.c                                            /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Po /
//                    rts\os_dbg.c -D _MIMO_Type -lcN                         /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -lB  /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\ -o   /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\      /
//                    --endian=little --cpu=Cortex-M3 -e                      /
//                    --require_prototypes --warnings_are_errors --fpu=None   /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.4\arm\INC\DLib_Config_Normal.h" -I          /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\include\   /
//                    -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\lib_stm /
//                    32\inc\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106 /
//                    \lib_stm32\src\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_ /
//                    20120106\uC-CPU\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src /
//                    _20120106\uC-LIB\ -I D:\Project\TRIO\3.F_W\TRIO_appl_sr /
//                    c_20120106\uCOS-II\Ports\ -I                            /
//                    D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\ -I D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\u /
//                    C-Probe\ -I "C:\Program Files\IAR Systems\Embedded      /
//                    Workbench 5.4\arm\INC\" -Oh                             /
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\os_db /
//                    g.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_dbg

        PUBLIC OSDebugEn

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Ports\os_dbg.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                               uC/OS-II
//    4 *                                         The Real-Time Kernel
//    5 *                                          DEBUGGER CONSTANTS
//    6 *
//    7 *                                (c) Copyright 2006, Micrium, Weston, FL
//    8 *                                          All Rights Reserved
//    9 *
//   10 *                                           ARM Cortex-M3 Port
//   11 *
//   12 * File      : OS_DBG.C
//   13 * Version   : V2.84
//   14 * By        : Jean J. Labrosse
//   15 *
//   16 * For       : ARMv7M Cortex-M3
//   17 * Mode      : Thumb2
//   18 * Toolchain : IAR EWARM
//   19 *********************************************************************************************************
//   20 */
//   21 
//   22 
//   23 #include <ucos_ii.h>
//   24 
//   25 #define  OS_COMPILER_OPT  __root
//   26 
//   27 /*
//   28 *********************************************************************************************************
//   29 *                                             DEBUG DATA
//   30 *********************************************************************************************************
//   31 */
//   32 

        SECTION `.rodata`:CONST:ROOT(1)
//   33 OS_COMPILER_OPT  INT16U  const  OSDebugEn          = OS_DEBUG_EN;                /* Debug constants are defined below   */
OSDebugEn:
        DATA
        DC16 0

        END
//   34 
//   35 #if OS_DEBUG_EN > 0
//   36 
//   37 OS_COMPILER_OPT  INT32U  const  OSEndiannessTest   = 0x12345678L;                /* Variable to test CPU endianness     */
//   38 
//   39 OS_COMPILER_OPT  INT16U  const  OSEventMax         = OS_MAX_EVENTS;              /* Number of event control blocks      */
//   40 OS_COMPILER_OPT  INT16U  const  OSEventNameSize    = OS_EVENT_NAME_SIZE;         /* Size (in bytes) of event names      */
//   41 OS_COMPILER_OPT  INT16U  const  OSEventEn          = OS_EVENT_EN;
//   42 #if (OS_EVENT_EN > 0) && (OS_MAX_EVENTS > 0)
//   43 OS_COMPILER_OPT  INT16U  const  OSEventSize        = sizeof(OS_EVENT);           /* Size in Bytes of OS_EVENT           */
//   44 OS_COMPILER_OPT  INT16U  const  OSEventTblSize     = sizeof(OSEventTbl);         /* Size of OSEventTbl[] in bytes       */
//   45 #else
//   46 OS_COMPILER_OPT  INT16U  const  OSEventSize        = 0;
//   47 OS_COMPILER_OPT  INT16U  const  OSEventTblSize     = 0;
//   48 #endif
//   49 
//   50 OS_COMPILER_OPT  INT16U  const  OSFlagEn           = OS_FLAG_EN;
//   51 #if (OS_FLAG_EN > 0) && (OS_MAX_FLAGS > 0)
//   52 OS_COMPILER_OPT  INT16U  const  OSFlagGrpSize      = sizeof(OS_FLAG_GRP);        /* Size in Bytes of OS_FLAG_GRP        */
//   53 OS_COMPILER_OPT  INT16U  const  OSFlagNodeSize     = sizeof(OS_FLAG_NODE);       /* Size in Bytes of OS_FLAG_NODE       */
//   54 OS_COMPILER_OPT  INT16U  const  OSFlagWidth        = sizeof(OS_FLAGS);           /* Width (in bytes) of OS_FLAGS        */
//   55 #else
//   56 OS_COMPILER_OPT  INT16U  const  OSFlagGrpSize      = 0;
//   57 OS_COMPILER_OPT  INT16U  const  OSFlagNodeSize     = 0;
//   58 OS_COMPILER_OPT  INT16U  const  OSFlagWidth        = 0;
//   59 #endif
//   60 OS_COMPILER_OPT  INT16U  const  OSFlagMax          = OS_MAX_FLAGS;
//   61 OS_COMPILER_OPT  INT16U  const  OSFlagNameSize     = OS_FLAG_NAME_SIZE;          /* Size (in bytes) of flag names       */
//   62 
//   63 OS_COMPILER_OPT  INT16U  const  OSLowestPrio       = OS_LOWEST_PRIO;
//   64 
//   65 OS_COMPILER_OPT  INT16U  const  OSMboxEn           = OS_MBOX_EN;
//   66 
//   67 OS_COMPILER_OPT  INT16U  const  OSMemEn            = OS_MEM_EN;
//   68 OS_COMPILER_OPT  INT16U  const  OSMemMax           = OS_MAX_MEM_PART;            /* Number of memory partitions         */
//   69 OS_COMPILER_OPT  INT16U  const  OSMemNameSize      = OS_MEM_NAME_SIZE;           /* Size (in bytes) of partition names  */
//   70 #if (OS_MEM_EN > 0) && (OS_MAX_MEM_PART > 0)
//   71 OS_COMPILER_OPT  INT16U  const  OSMemSize          = sizeof(OS_MEM);             /* Mem. Partition header sine (bytes)  */
//   72 OS_COMPILER_OPT  INT16U  const  OSMemTblSize       = sizeof(OSMemTbl);
//   73 #else
//   74 OS_COMPILER_OPT  INT16U  const  OSMemSize          = 0;
//   75 OS_COMPILER_OPT  INT16U  const  OSMemTblSize       = 0;
//   76 #endif
//   77 OS_COMPILER_OPT  INT16U  const  OSMutexEn          = OS_MUTEX_EN;
//   78 
//   79 OS_COMPILER_OPT  INT16U  const  OSPtrSize          = sizeof(void *);             /* Size in Bytes of a pointer          */
//   80 
//   81 OS_COMPILER_OPT  INT16U  const  OSQEn              = OS_Q_EN;
//   82 OS_COMPILER_OPT  INT16U  const  OSQMax             = OS_MAX_QS;                  /* Number of queues                    */
//   83 #if (OS_Q_EN > 0) && (OS_MAX_QS > 0)
//   84 OS_COMPILER_OPT  INT16U  const  OSQSize            = sizeof(OS_Q);               /* Size in bytes of OS_Q structure     */
//   85 #else
//   86 OS_COMPILER_OPT  INT16U  const  OSQSize            = 0;
//   87 #endif
//   88 
//   89 OS_COMPILER_OPT  INT16U  const  OSRdyTblSize       = OS_RDY_TBL_SIZE;            /* Number of bytes in the ready table  */
//   90 
//   91 OS_COMPILER_OPT  INT16U  const  OSSemEn            = OS_SEM_EN;
//   92 
//   93 OS_COMPILER_OPT  INT16U  const  OSStkWidth         = sizeof(OS_STK);             /* Size in Bytes of a stack entry      */
//   94 
//   95 OS_COMPILER_OPT  INT16U  const  OSTaskCreateEn     = OS_TASK_CREATE_EN;
//   96 OS_COMPILER_OPT  INT16U  const  OSTaskCreateExtEn  = OS_TASK_CREATE_EXT_EN;
//   97 OS_COMPILER_OPT  INT16U  const  OSTaskDelEn        = OS_TASK_DEL_EN;
//   98 OS_COMPILER_OPT  INT16U  const  OSTaskIdleStkSize  = OS_TASK_IDLE_STK_SIZE;
//   99 OS_COMPILER_OPT  INT16U  const  OSTaskProfileEn    = OS_TASK_PROFILE_EN;
//  100 OS_COMPILER_OPT  INT16U  const  OSTaskMax          = OS_MAX_TASKS + OS_N_SYS_TASKS;  /* Total max. number of tasks      */
//  101 OS_COMPILER_OPT  INT16U  const  OSTaskNameSize     = OS_TASK_NAME_SIZE;              /* Size (in bytes) of task names   */
//  102 OS_COMPILER_OPT  INT16U  const  OSTaskStatEn       = OS_TASK_STAT_EN;
//  103 OS_COMPILER_OPT  INT16U  const  OSTaskStatStkSize  = OS_TASK_STAT_STK_SIZE;
//  104 OS_COMPILER_OPT  INT16U  const  OSTaskStatStkChkEn = OS_TASK_STAT_STK_CHK_EN;
//  105 OS_COMPILER_OPT  INT16U  const  OSTaskSwHookEn     = OS_TASK_SW_HOOK_EN;
//  106 
//  107 OS_COMPILER_OPT  INT16U  const  OSTCBPrioTblMax    = OS_LOWEST_PRIO + 1;         /* Number of entries in OSTCBPrioTbl[] */
//  108 OS_COMPILER_OPT  INT16U  const  OSTCBSize          = sizeof(OS_TCB);             /* Size in Bytes of OS_TCB             */
//  109 OS_COMPILER_OPT  INT16U  const  OSTicksPerSec      = OS_TICKS_PER_SEC;
//  110 OS_COMPILER_OPT  INT16U  const  OSTimeTickHookEn   = OS_TIME_TICK_HOOK_EN;
//  111 OS_COMPILER_OPT  INT16U  const  OSVersionNbr       = OS_VERSION;
//  112 
//  113 #endif
//  114 
//  115 /*$PAGE*/
//  116 /*
//  117 *********************************************************************************************************
//  118 *                                             DEBUG DATA
//  119 *                            TOTAL DATA SPACE (i.e. RAM) USED BY uC/OS-II
//  120 *********************************************************************************************************
//  121 */
//  122 #if OS_DEBUG_EN > 0
//  123 
//  124 OS_COMPILER_OPT  INT16U  const  OSDataSize = sizeof(OSCtxSwCtr)
//  125 #if (OS_EVENT_EN > 0) && (OS_MAX_EVENTS > 0)
//  126                                            + sizeof(OSEventFreeList)
//  127                                            + sizeof(OSEventTbl)
//  128 #endif
//  129 #if (OS_VERSION >= 251) && (OS_FLAG_EN > 0) && (OS_MAX_FLAGS > 0)
//  130                                            + sizeof(OSFlagTbl)
//  131                                            + sizeof(OSFlagFreeList)
//  132 #endif
//  133 #if OS_TASK_STAT_EN > 0
//  134                                            + sizeof(OSCPUUsage)
//  135                                            + sizeof(OSIdleCtrMax)
//  136                                            + sizeof(OSIdleCtrRun)
//  137                                            + sizeof(OSStatRdy)
//  138                                            + sizeof(OSTaskStatStk)
//  139 #endif
//  140 #if OS_TICK_STEP_EN > 0
//  141                                            + sizeof(OSTickStepState)
//  142 #endif
//  143 #if (OS_MEM_EN > 0) && (OS_MAX_MEM_PART > 0)
//  144                                            + sizeof(OSMemFreeList)
//  145                                            + sizeof(OSMemTbl)
//  146 #endif
//  147 #if (OS_Q_EN > 0) && (OS_MAX_QS > 0)
//  148                                            + sizeof(OSQFreeList)
//  149                                            + sizeof(OSQTbl)
//  150 #endif
//  151 #if OS_TIME_GET_SET_EN > 0   
//  152                                            + sizeof(OSTime)
//  153 #endif
//  154                                            + sizeof(OSIntNesting)
//  155                                            + sizeof(OSLockNesting)
//  156                                            + sizeof(OSPrioCur)
//  157                                            + sizeof(OSPrioHighRdy)
//  158                                            + sizeof(OSRdyGrp)
//  159                                            + sizeof(OSRdyTbl)
//  160                                            + sizeof(OSRunning)
//  161                                            + sizeof(OSTaskCtr)
//  162                                            + sizeof(OSIdleCtr)
//  163                                            + sizeof(OSTaskIdleStk)
//  164                                            + sizeof(OSTCBCur)
//  165                                            + sizeof(OSTCBFreeList)
//  166                                            + sizeof(OSTCBHighRdy)
//  167                                            + sizeof(OSTCBList)
//  168                                            + sizeof(OSTCBPrioTbl)
//  169                                            + sizeof(OSTCBTbl);
//  170 
//  171 #endif
//  172 
//  173 /*$PAGE*/
//  174 /*
//  175 *********************************************************************************************************
//  176 *                                       OS DEBUG INITIALIZAZTION
//  177 *
//  178 * Description: This function is used to make sure that debug variables that are unused in the application
//  179 *              are not optimized away.  This function might not be necessary for all compilers.  In this
//  180 *              case, you should simply DELETE the code in this function while still leaving the declaration
//  181 *              of the function itself.
//  182 *
//  183 * Arguments  : none
//  184 *
//  185 * Returns    : none
//  186 *
//  187 * Note(s)    : (1) This code doesn't do anything, it simply prevents the compiler from optimizing out
//  188 *                  the 'const' variables which are declared in this file.
//  189 *********************************************************************************************************
//  190 */
//  191 
//  192 #if OS_VERSION >= 270 && OS_DEBUG_EN > 0
//  193 void  OSDebugInit (void)
//  194 {
//  195     void  *ptemp;
//  196 
//  197     
//  198     ptemp = (void *)&OSDebugEn;
//  199 
//  200     ptemp = (void *)&OSEndiannessTest;
//  201 
//  202     ptemp = (void *)&OSEventMax;
//  203     ptemp = (void *)&OSEventNameSize;
//  204     ptemp = (void *)&OSEventEn;
//  205     ptemp = (void *)&OSEventSize;
//  206     ptemp = (void *)&OSEventTblSize;
//  207 
//  208     ptemp = (void *)&OSFlagEn;
//  209     ptemp = (void *)&OSFlagGrpSize;
//  210     ptemp = (void *)&OSFlagNodeSize;
//  211     ptemp = (void *)&OSFlagWidth;
//  212     ptemp = (void *)&OSFlagMax;
//  213     ptemp = (void *)&OSFlagNameSize;
//  214 
//  215     ptemp = (void *)&OSLowestPrio;
//  216 
//  217     ptemp = (void *)&OSMboxEn;
//  218 
//  219     ptemp = (void *)&OSMemEn;
//  220     ptemp = (void *)&OSMemMax;
//  221     ptemp = (void *)&OSMemNameSize;
//  222     ptemp = (void *)&OSMemSize;
//  223     ptemp = (void *)&OSMemTblSize;
//  224 
//  225     ptemp = (void *)&OSMutexEn;
//  226 
//  227     ptemp = (void *)&OSPtrSize;
//  228 
//  229     ptemp = (void *)&OSQEn;
//  230     ptemp = (void *)&OSQMax;
//  231     ptemp = (void *)&OSQSize;
//  232 
//  233     ptemp = (void *)&OSRdyTblSize;
//  234 
//  235     ptemp = (void *)&OSSemEn;
//  236 
//  237     ptemp = (void *)&OSStkWidth;
//  238 
//  239     ptemp = (void *)&OSTaskCreateEn;
//  240     ptemp = (void *)&OSTaskCreateExtEn;
//  241     ptemp = (void *)&OSTaskDelEn;
//  242     ptemp = (void *)&OSTaskIdleStkSize;
//  243     ptemp = (void *)&OSTaskProfileEn;
//  244     ptemp = (void *)&OSTaskMax;
//  245     ptemp = (void *)&OSTaskNameSize;
//  246     ptemp = (void *)&OSTaskStatEn;
//  247     ptemp = (void *)&OSTaskStatStkSize;
//  248     ptemp = (void *)&OSTaskStatStkChkEn;
//  249     ptemp = (void *)&OSTaskSwHookEn;
//  250 
//  251     ptemp = (void *)&OSTCBPrioTblMax;
//  252     ptemp = (void *)&OSTCBSize;
//  253 
//  254     ptemp = (void *)&OSTicksPerSec;
//  255     ptemp = (void *)&OSTimeTickHookEn;
//  256 
//  257     ptemp = (void *)&OSVersionNbr;
//  258 
//  259     ptemp = (void *)&OSDataSize;
//  260 
//  261     ptemp = ptemp;                             /* Prevent compiler warning for 'ptemp' not being used! */
//  262 }
//  263 #endif
// 
// 2 bytes in section .rodata
// 
// 2 bytes of CONST memory
//
//Errors: none
//Warnings: none
