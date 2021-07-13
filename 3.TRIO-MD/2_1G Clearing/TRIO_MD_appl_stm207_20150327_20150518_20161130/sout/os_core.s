///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:41 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_core.c                                         /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_core.c -D OS_INCLUDED -D APPL_SRC -lcN         /
//                    C:\user\project\stm32\fw\stm207_ucos_20120825\sout\     /
//                    -lB C:\user\project\stm32\fw\stm207_ucos_20120825\sout\ /
//                     -o C:\user\project\stm32\fw\stm207_ucos_20120825\sout\ /
//                     --endian=little --cpu=Cortex-M3 -e --fpu=None          /
//                    --dlib_config "C:\compiler\ewarm                        /
//                    6.2\arm\INC\c\DLib_Config_Normal.h" -I                  /
//                    C:\user\project\stm32\fw\stm207_ucos_20120825\include\  /
//                    -I C:\user\project\stm32\fw\stm207_ucos_20120825\..\..\ /
//                    ..\stm32\STM32F2xx_StdPeriph_Driver\ -I                 /
//                    C:\user\project\stm32\fw\stm207_ucos_20120825\..\..\..\ /
//                    stm32\STM32F2xx_StdPeriph_Driver\inc\ -I                /
//                    C:\user\project\stm32\fw\stm207_ucos_20120825\uC-CPU\   /
//                    -I C:\user\project\stm32\fw\stm207_ucos_20120825\uC-LIB /
//                    \ -I C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS /
//                    -II\Ports\ -I C:\user\project\stm32\fw\stm207_ucos_2012 /
//                    0825\uCOS-II\Source\ -I C:\user\project\stm32\fw\stm207 /
//                    _ucos_20120825\uC-Probe\ -Oh --use_c++_inline           /
//                    --require_prototypes                                    /
//    List file    =  C:\user\project\stm32\fw\stm207_ucos_20120825\sout\os_c /
//                    ore.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_core

        #define SHT_PROGBITS 0x1

        EXTERN LedDisplay
        EXTERN OSCtxSw
        EXTERN OSInitHookBegin
        EXTERN OSInitHookEnd
        EXTERN OSIntCtxSw
        EXTERN OSStartHighRdy
        EXTERN OSTCBInitHook
        EXTERN OSTaskCreate
        EXTERN OSTaskCreateHook
        EXTERN OSTaskIdleHook
        EXTERN OSTimeTickHook
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_FlagInit
        EXTERN OS_MemInit
        EXTERN OS_QInit
        EXTERN __aeabi_memclr

        PUBLIC OSCtxSwCtr
        PUBLIC OSEventFreeList
        PUBLIC OSEventTbl
        PUBLIC OSFlagFreeList
        PUBLIC OSFlagTbl
        PUBLIC OSIdleCtr
        PUBLIC OSInit
        PUBLIC OSIntEnter
        PUBLIC OSIntExit
        PUBLIC OSIntNesting
        PUBLIC OSLockNesting
        PUBLIC OSMemFreeList
        PUBLIC OSMemTbl
        PUBLIC OSPrioCur
        PUBLIC OSPrioHighRdy
        PUBLIC OSQFreeList
        PUBLIC OSQTbl
        PUBLIC OSRdyGrp
        PUBLIC OSRdyTbl
        PUBLIC OSRunning
        PUBLIC OSSchedLock
        PUBLIC OSSchedUnlock
        PUBLIC OSStart
        PUBLIC OSTCBCur
        PUBLIC OSTCBFreeList
        PUBLIC OSTCBHighRdy
        PUBLIC OSTCBList
        PUBLIC OSTCBPrioTbl
        PUBLIC OSTCBTbl
        PUBLIC OSTaskCtr
        PUBLIC OSTaskIdleStk
        PUBLIC OSTickStepState
        PUBLIC OSTime
        PUBLIC OSTimeTick
        PUBLIC OSUnMapTbl
        PUBLIC OSVersion
        PUBLIC OS_Dummy
        PUBLIC OS_EventTOAbort
        PUBLIC OS_EventTaskRdy
        PUBLIC OS_EventTaskWait
        PUBLIC OS_EventWaitListInit
        PUBLIC OS_MemClr
        PUBLIC OS_MemCopy
        PUBLIC OS_Sched
        PUBLIC OS_StrCopy
        PUBLIC OS_StrLen
        PUBLIC OS_TCBInit
        PUBLIC OS_TaskIdle

// C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\Source\os_core.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                             CORE FUNCTIONS
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_CORE.C
//   11 * By      : Jean J. Labrosse
//   12 * Version : V2.85
//   13 *
//   14 * LICENSING TERMS:
//   15 * ---------------
//   16 *   uC/OS-II is provided in source form for FREE evaluation, for educational use or for peaceful research.  
//   17 * If you plan on using  uC/OS-II  in a commercial product you need to contact Micriµm to properly license 
//   18 * its use in your product. We provide ALL the source code for your convenience and to help you experience 
//   19 * uC/OS-II.   The fact that the  source is provided does  NOT  mean that you can use it without  paying a 
//   20 * licensing fee.
//   21 *********************************************************************************************************
//   22 */
//   23 
//   24 #ifndef  OS_MASTER_FILE
//   25 #define  OS_GLOBALS
//   26 
//   27 #include <ucos_ii.h>

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute INT8U OSIntNesting
OSIntNesting:
        DS8 1
// __absolute INT8U OSLockNesting
OSLockNesting:
        DS8 1
// __absolute INT8U OSPrioCur
OSPrioCur:
        DS8 1
// __absolute INT8U OSPrioHighRdy
OSPrioHighRdy:
        DS8 1
// __absolute INT8U OSRdyGrp
OSRdyGrp:
        DS8 1
// __absolute BOOLEAN OSRunning
OSRunning:
        DS8 1
// __absolute INT8U OSTaskCtr
OSTaskCtr:
        DS8 1
// __absolute INT8U OSTickStepState
OSTickStepState:
        DS8 1
// __absolute INT8U OSRdyTbl[4]
OSRdyTbl:
        DS8 4
// __absolute INT32U OSCtxSwCtr
OSCtxSwCtr:
        DS8 4
// __absolute INT32U volatile OSIdleCtr
OSIdleCtr:
        DS8 4
// __absolute struct os_tcb *OSTCBCur
OSTCBCur:
        DS8 4
// __absolute struct os_tcb *OSTCBFreeList
OSTCBFreeList:
        DS8 4
// __absolute struct os_tcb *OSTCBHighRdy
OSTCBHighRdy:
        DS8 4
// __absolute struct os_tcb *OSTCBList
OSTCBList:
        DS8 4
// __absolute INT32U volatile OSTime
OSTime:
        DS8 4

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute OS_EVENT OSEventTbl[20]
OSEventTbl:
        DS8 320
// __absolute struct os_event *OSEventFreeList
OSEventFreeList:
        DS8 4
// __absolute OS_STK OSTaskIdleStk[128]
OSTaskIdleStk:
        DS8 512
// __absolute OS_TCB OSTCBTbl[17U]
OSTCBTbl:
        DS8 952

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute OS_FLAG_GRP OSFlagTbl[5]
OSFlagTbl:
        DS8 140

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute struct os_flag_grp *OSFlagFreeList
OSFlagFreeList:
        DS8 4

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute struct os_tcb *OSTCBPrioTbl[32]
OSTCBPrioTbl:
        DS8 128

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute struct os_mem *OSMemFreeList
OSMemFreeList:
        DS8 4

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute OS_MEM OSMemTbl[5]
OSMemTbl:
        DS8 180

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute OS_Q *OSQFreeList
OSQFreeList:
        DS8 4

        SECTION iram:DATA:REORDER:NOROOT(2)
// __absolute OS_Q OSQTbl[4]
OSQTbl:
        DS8 96
//   28 #endif
//   29 
//   30 /*
//   31 *********************************************************************************************************
//   32 *                                       PRIORITY RESOLUTION TABLE
//   33 *
//   34 * Note: Index into table is bit pattern to resolve highest priority
//   35 *       Indexed value corresponds to highest priority bit position (i.e. 0..7)
//   36 *********************************************************************************************************
//   37 */
//   38 
//   39 INT8U  const  OSUnMapTbl[256] = {
//   40     0, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x00 to 0x0F                             */
//   41     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x10 to 0x1F                             */
//   42     5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x20 to 0x2F                             */
//   43     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x30 to 0x3F                             */
//   44     6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x40 to 0x4F                             */
//   45     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x50 to 0x5F                             */
//   46     5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x60 to 0x6F                             */
//   47     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x70 to 0x7F                             */
//   48     7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x80 to 0x8F                             */
//   49     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x90 to 0x9F                             */
//   50     5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xA0 to 0xAF                             */
//   51     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xB0 to 0xBF                             */
//   52     6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xC0 to 0xCF                             */
//   53     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xD0 to 0xDF                             */
//   54     5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xE0 to 0xEF                             */
//   55     4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0        /* 0xF0 to 0xFF                             */
//   56 };
//   57 
//   58 /*$PAGE*/
//   59 /*
//   60 *********************************************************************************************************
//   61 *                                       FUNCTION PROTOTYPES
//   62 *********************************************************************************************************
//   63 */
//   64 
//   65 static  void  OS_InitEventList(void);
//   66 
//   67 static  void  OS_InitMisc(void);
//   68 
//   69 static  void  OS_InitRdyList(void);
//   70 
//   71 static  void  OS_InitTaskIdle(void);
//   72 
//   73 #if OS_TASK_STAT_EN > 0
//   74 static  void  OS_InitTaskStat(void);
//   75 #endif
//   76 
//   77 static  void  OS_InitTCBList(void);
//   78 
//   79 static  void  OS_SchedNew(void);
//   80 
//   81 /*$PAGE*/
//   82 /*
//   83 *********************************************************************************************************
//   84 *                         GET THE NAME OF A SEMAPHORE, MUTEX, MAILBOX or QUEUE
//   85 *
//   86 * Description: This function is used to obtain the name assigned to a semaphore, mutex, mailbox or queue.
//   87 *
//   88 * Arguments  : pevent    is a pointer to the event group.  'pevent' can point either to a semaphore,
//   89 *                        a mutex, a mailbox or a queue.  Where this function is concerned, the actual
//   90 *                        type is irrelevant.
//   91 *
//   92 *              pname     is a pointer to an ASCII string that will receive the name of the semaphore,
//   93 *                        mutex, mailbox or queue.  The string must be able to hold at least
//   94 *                        OS_EVENT_NAME_SIZE characters.
//   95 *
//   96 *              perr      is a pointer to an error code that can contain one of the following values:
//   97 *
//   98 *                        OS_ERR_NONE                if the name was copied to 'pname'
//   99 *                        OS_ERR_EVENT_TYPE          if 'pevent' is not pointing to the proper event
//  100 *                                                   control block type.
//  101 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  102 *                        OS_ERR_PEVENT_NULL         if you passed a NULL pointer for 'pevent'
//  103 *
//  104 * Returns    : The length of the string or 0 if the 'pevent' is a NULL pointer.
//  105 *********************************************************************************************************
//  106 */
//  107 
//  108 #if OS_EVENT_EN && (OS_EVENT_NAME_SIZE > 1)
//  109 INT8U  OSEventNameGet (OS_EVENT *pevent, INT8U *pname, INT8U *perr)
//  110 {
//  111     INT8U      len;
//  112 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  113     OS_CPU_SR  cpu_sr = 0;
//  114 #endif
//  115 
//  116 
//  117 
//  118 #if OS_ARG_CHK_EN > 0
//  119     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//  120         return (0);
//  121     }
//  122     if (pevent == (OS_EVENT *)0) {               /* Is 'pevent' a NULL pointer?                        */
//  123         *perr = OS_ERR_PEVENT_NULL;
//  124         return (0);
//  125     }
//  126     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
//  127         *perr = OS_ERR_PNAME_NULL;
//  128         return (0);
//  129     }
//  130 #endif
//  131     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
//  132         *perr  = OS_ERR_NAME_GET_ISR;
//  133         return (0);
//  134     }
//  135     switch (pevent->OSEventType) {
//  136         case OS_EVENT_TYPE_SEM:
//  137         case OS_EVENT_TYPE_MUTEX:
//  138         case OS_EVENT_TYPE_MBOX:
//  139         case OS_EVENT_TYPE_Q:
//  140              break;
//  141 
//  142         default:
//  143              *perr = OS_ERR_EVENT_TYPE;
//  144              return (0);
//  145     }
//  146     OS_ENTER_CRITICAL();
//  147     len   = OS_StrCopy(pname, pevent->OSEventName);   /* Copy name from OS_EVENT                       */
//  148     OS_EXIT_CRITICAL();
//  149     *perr = OS_ERR_NONE;
//  150     return (len);
//  151 }
//  152 #endif
//  153 
//  154 /*$PAGE*/
//  155 /*
//  156 *********************************************************************************************************
//  157 *                         ASSIGN A NAME TO A SEMAPHORE, MUTEX, MAILBOX or QUEUE
//  158 *
//  159 * Description: This function assigns a name to a semaphore, mutex, mailbox or queue.
//  160 *
//  161 * Arguments  : pevent    is a pointer to the event group.  'pevent' can point either to a semaphore,
//  162 *                        a mutex, a mailbox or a queue.  Where this function is concerned, it doesn't
//  163 *                        matter the actual type.
//  164 *
//  165 *              pname     is a pointer to an ASCII string that will be used as the name of the semaphore,
//  166 *                        mutex, mailbox or queue.  The string must be able to hold at least
//  167 *                        OS_EVENT_NAME_SIZE characters.
//  168 *
//  169 *              perr      is a pointer to an error code that can contain one of the following values:
//  170 *
//  171 *                        OS_ERR_NONE                if the requested task is resumed
//  172 *                        OS_ERR_EVENT_TYPE          if 'pevent' is not pointing to the proper event
//  173 *                                                   control block type.
//  174 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  175 *                        OS_ERR_PEVENT_NULL         if you passed a NULL pointer for 'pevent'
//  176 *                        OS_ERR_NAME_SET_ISR        if you called this function from an ISR
//  177 *
//  178 * Returns    : None
//  179 *********************************************************************************************************
//  180 */
//  181 
//  182 #if OS_EVENT_EN && (OS_EVENT_NAME_SIZE > 1)
//  183 void  OSEventNameSet (OS_EVENT *pevent, INT8U *pname, INT8U *perr)
//  184 {
//  185     INT8U      len;
//  186 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  187     OS_CPU_SR  cpu_sr = 0;
//  188 #endif
//  189 
//  190 
//  191 
//  192 #if OS_ARG_CHK_EN > 0
//  193     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//  194         return;
//  195     }
//  196     if (pevent == (OS_EVENT *)0) {               /* Is 'pevent' a NULL pointer?                        */
//  197         *perr = OS_ERR_PEVENT_NULL;
//  198         return;
//  199     }
//  200     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
//  201         *perr = OS_ERR_PNAME_NULL;
//  202         return;
//  203     }
//  204 #endif
//  205     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
//  206         *perr = OS_ERR_NAME_SET_ISR;
//  207         return;
//  208     }
//  209     switch (pevent->OSEventType) {
//  210         case OS_EVENT_TYPE_SEM:
//  211         case OS_EVENT_TYPE_MUTEX:
//  212         case OS_EVENT_TYPE_MBOX:
//  213         case OS_EVENT_TYPE_Q:
//  214              break;
//  215 
//  216         default:
//  217              *perr = OS_ERR_EVENT_TYPE;
//  218              return;
//  219     }
//  220     OS_ENTER_CRITICAL();
//  221     len = OS_StrLen(pname);                           /* Can we fit the string in the storage area?    */
//  222     if (len > (OS_EVENT_NAME_SIZE - 1)) {             /* No                                            */
//  223         OS_EXIT_CRITICAL();
//  224         *perr = OS_ERR_EVENT_NAME_TOO_LONG;
//  225         return;
//  226     }
//  227     (void)OS_StrCopy(pevent->OSEventName, pname);     /* Yes, copy name to the event control block     */
//  228     OS_EXIT_CRITICAL();
//  229     *perr = OS_ERR_NONE;
//  230 }
//  231 #endif
//  232 
//  233 /*$PAGE*/
//  234 /*
//  235 *********************************************************************************************************
//  236 *                                             INITIALIZATION
//  237 *
//  238 * Description: This function is used to initialize the internals of uC/OS-II and MUST be called prior to
//  239 *              creating any uC/OS-II object and, prior to calling OSStart().
//  240 *
//  241 * Arguments  : none
//  242 *
//  243 * Returns    : none
//  244 *********************************************************************************************************
//  245 */
//  246 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  247 void  OSInit (void)
//  248 {
OSInit:
        PUSH     {R3-R5,LR}
//  249     OSInitHookBegin();                                           /* Call port specific initialization code   */
        BL       OSInitHookBegin
//  250 
//  251     OS_InitMisc();                                               /* Initialize miscellaneous variables       */
        LDR.W    R5,??DataTable14
        MOVS     R0,#+0
        STR      R0,[R5, #+36]
        STRB     R0,[R5, #+0]
        STRB     R0,[R5, #+1]
        STRB     R0,[R5, #+6]
        STRB     R0,[R5, #+5]
        STR      R0,[R5, #+12]
        STR      R0,[R5, #+16]
//  252 
//  253     OS_InitRdyList();                                            /* Initialize the Ready List                */
        STRB     R0,[R5, #+4]
        ADD      R0,R5,#+8
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        STRB     R1,[R5, #+2]
        STRB     R1,[R5, #+3]
        STR      R1,[R5, #+28]
        STR      R1,[R5, #+20]
//  254 
//  255     OS_InitTCBList();                                            /* Initialize the free list of OS_TCBs      */
        LDR.W    R4,??DataTable14_1
        MOV      R1,#+952
        ADDW     R0,R4,#+836
        BL       OS_MemClr
        MOVS     R1,#+128
        LDR.W    R0,??DataTable14_2
        BL       OS_MemClr
        ADDW     R0,R4,#+836
        MOV      R2,R0
        ADDW     R3,R4,#+892
        MOVS     R1,#+2
??OSInit_0:
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        STR      R3,[R2, #+4]
        ADDW     R2,R2,#+56
        ADDW     R3,R3,#+56
        SUBS     R1,R1,#+1
        BNE.N    ??OSInit_0
        MOVS     R1,#+0
        STR      R1,[R2, #+4]
        STR      R1,[R5, #+32]
        STR      R0,[R5, #+24]
//  256 
//  257     OS_InitEventList();                                          /* Initialize the free list of OS_EVENTs    */
        MOV      R1,#+320
        MOV      R0,R4
        BL       OS_MemClr
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
        ADD      R0,R4,#+16
        STR      R0,[R4, #+4]
        ADD      R2,R4,#+32
        MOVS     R1,#+3
        MOVS     R3,#+0
??OSInit_1:
        STRB     R3,[R0], #+4
        STR      R2,[R0], #+12
        ADDS     R2,R2,#+16
        STRB     R3,[R0], #+4
        STR      R2,[R0], #+12
        ADDS     R2,R2,#+16
        STRB     R3,[R0], #+4
        STR      R2,[R0], #+12
        ADDS     R2,R2,#+16
        STRB     R3,[R0], #+4
        STR      R2,[R0], #+12
        ADDS     R2,R2,#+16
        STRB     R3,[R0], #+4
        STR      R2,[R0], #+12
        ADDS     R2,R2,#+16
        STRB     R3,[R0], #+4
        STR      R2,[R0], #+12
        ADDS     R2,R2,#+16
        SUBS     R1,R1,#+1
        BNE.N    ??OSInit_1
        STRB     R3,[R0, #+0]
        STR      R3,[R0, #+4]
        STR      R4,[R4, #+320]
//  258 
//  259 #if (OS_FLAG_EN > 0) && (OS_MAX_FLAGS > 0)
//  260     OS_FlagInit();                                               /* Initialize the event flag structures     */
        BL       OS_FlagInit
//  261 #endif
//  262 
//  263 #if (OS_MEM_EN > 0) && (OS_MAX_MEM_PART > 0)
//  264     OS_MemInit();                                                /* Initialize the memory manager            */
        BL       OS_MemInit
//  265 #endif
//  266 
//  267 #if (OS_Q_EN > 0) && (OS_MAX_QS > 0)
//  268     OS_QInit();                                                  /* Initialize the message queue structures  */
        BL       OS_QInit
//  269 #endif
//  270 
//  271     OS_InitTaskIdle();                                           /* Create the Idle Task                     */
        MOVS     R3,#+31
        ADDW     R2,R4,#+832
        MOVS     R1,#+0
        LDR.W    R0,??DataTable14_3
        BL       OSTaskCreate
//  272 #if OS_TASK_STAT_EN > 0
//  273     OS_InitTaskStat();                                           /* Create the Statistic Task                */
//  274 #endif
//  275 
//  276 #if OS_TMR_EN > 0
//  277     OSTmr_Init();                                                /* Initialize the Timer Manager             */
//  278 #endif
//  279 
//  280     OSInitHookEnd();                                             /* Call port specific init. code            */
        POP      {R0,R4,R5,LR}
        B.W      OSInitHookEnd
//  281 
//  282 #if OS_DEBUG_EN > 0
//  283     OSDebugInit();
//  284 #endif
//  285 }
//  286 /*$PAGE*/
//  287 /*
//  288 *********************************************************************************************************
//  289 *                                              ENTER ISR
//  290 *
//  291 * Description: This function is used to notify uC/OS-II that you are about to service an interrupt
//  292 *              service routine (ISR).  This allows uC/OS-II to keep track of interrupt nesting and thus
//  293 *              only perform rescheduling at the last nested ISR.
//  294 *
//  295 * Arguments  : none
//  296 *
//  297 * Returns    : none
//  298 *
//  299 * Notes      : 1) This function should be called ith interrupts already disabled
//  300 *              2) Your ISR can directly increment OSIntNesting without calling this function because
//  301 *                 OSIntNesting has been declared 'global'.
//  302 *              3) You MUST still call OSIntExit() even though you increment OSIntNesting directly.
//  303 *              4) You MUST invoke OSIntEnter() and OSIntExit() in pair.  In other words, for every call
//  304 *                 to OSIntEnter() at the beginning of the ISR you MUST have a call to OSIntExit() at the
//  305 *                 end of the ISR.
//  306 *              5) You are allowed to nest interrupts up to 255 levels deep.
//  307 *              6) I removed the OS_ENTER_CRITICAL() and OS_EXIT_CRITICAL() around the increment because
//  308 *                 OSIntEnter() is always called with interrupts disabled.
//  309 *********************************************************************************************************
//  310 */
//  311 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  312 void  OSIntEnter (void)
//  313 {
//  314     if (OSRunning == OS_TRUE) {
OSIntEnter:
        LDR.W    R0,??DataTable14
        LDRB     R1,[R0, #+5]
        CMP      R1,#+1
        BNE.N    ??OSIntEnter_0
//  315         if (OSIntNesting < 255u) {
        LDRB     R1,[R0, #+0]
        CMP      R1,#+255
        ITT      NE 
        ADDNE    R1,R1,#+1
        STRBNE   R1,[R0, #+0]
//  316             OSIntNesting++;                      /* Increment ISR nesting level                        */
//  317         }
//  318     }
//  319 }
??OSIntEnter_0:
        BX       LR               ;; return
//  320 /*$PAGE*/
//  321 /*
//  322 *********************************************************************************************************
//  323 *                                               EXIT ISR
//  324 *
//  325 * Description: This function is used to notify uC/OS-II that you have completed serviving an ISR.  When
//  326 *              the last nested ISR has completed, uC/OS-II will call the scheduler to determine whether
//  327 *              a new, high-priority task, is ready to run.
//  328 *
//  329 * Arguments  : none
//  330 *
//  331 * Returns    : none
//  332 *
//  333 * Notes      : 1) You MUST invoke OSIntEnter() and OSIntExit() in pair.  In other words, for every call
//  334 *                 to OSIntEnter() at the beginning of the ISR you MUST have a call to OSIntExit() at the
//  335 *                 end of the ISR.
//  336 *              2) Rescheduling is prevented when the scheduler is locked (see OS_SchedLock())
//  337 *********************************************************************************************************
//  338 */
//  339 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  340 void  OSIntExit (void)
//  341 {
OSIntExit:
        PUSH     {R3-R5,LR}
//  342 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  343     OS_CPU_SR  cpu_sr = 0;
//  344 #endif
//  345 
//  346 
//  347 
//  348     if (OSRunning == OS_TRUE) {
        LDR.W    R4,??DataTable14
        LDRB     R0,[R4, #+5]
        CMP      R0,#+1
        BNE.N    ??OSIntExit_0
//  349         OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R5,R0
//  350         if (OSIntNesting > 0) {                            /* Prevent OSIntNesting from wrapping       */
        LDRB     R0,[R4, #+0]
        CBZ.N    R0,??OSIntExit_1
//  351             OSIntNesting--;
        SUBS     R0,R0,#+1
        STRB     R0,[R4, #+0]
//  352         }
//  353         if (OSIntNesting == 0) {                           /* Reschedule only if all ISRs complete ... */
//  354             if (OSLockNesting == 0) {                      /* ... and not locked.                      */
??OSIntExit_1:
        LDRB     R0,[R4, #+0]
        LDRB     R1,[R4, #+1]
        ORRS     R0,R1,R0
        BNE.N    ??OSIntExit_2
//  355                 OS_SchedNew();
        BL       OS_SchedNew
//  356                 if (OSPrioHighRdy != OSPrioCur) {          /* No Ctx Sw if current task is highest rdy */
        LDRB     R0,[R4, #+3]
        LDRB     R1,[R4, #+2]
        CMP      R0,R1
        BEQ.N    ??OSIntExit_2
//  357                     OSTCBHighRdy  = OSTCBPrioTbl[OSPrioHighRdy];
        LDR.W    R1,??DataTable14_2
        LDR      R0,[R1, R0, LSL #+2]
        STR      R0,[R4, #+28]
//  358 #if OS_TASK_PROFILE_EN > 0
//  359                     OSTCBHighRdy->OSTCBCtxSwCtr++;         /* Inc. # of context switches to this task  */
        LDR      R1,[R0, #+36]
        ADDS     R1,R1,#+1
        STR      R1,[R0, #+36]
//  360 #endif
//  361                     OSCtxSwCtr++;                          /* Keep track of the number of ctx switches */
        LDR      R0,[R4, #+12]
        ADDS     R0,R0,#+1
        STR      R0,[R4, #+12]
//  362                     OSIntCtxSw();                          /* Perform interrupt level ctx switch       */
        BL       OSIntCtxSw
//  363                 }
//  364             }
//  365         }
//  366         OS_EXIT_CRITICAL();
??OSIntExit_2:
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  367     }
//  368 }
??OSIntExit_0:
        POP      {R0,R4,R5,PC}    ;; return
//  369 /*$PAGE*/
//  370 /*
//  371 *********************************************************************************************************
//  372 *                                          PREVENT SCHEDULING
//  373 *
//  374 * Description: This function is used to prevent rescheduling to take place.  This allows your application
//  375 *              to prevent context switches until you are ready to permit context switching.
//  376 *
//  377 * Arguments  : none
//  378 *
//  379 * Returns    : none
//  380 *
//  381 * Notes      : 1) You MUST invoke OSSchedLock() and OSSchedUnlock() in pair.  In other words, for every
//  382 *                 call to OSSchedLock() you MUST have a call to OSSchedUnlock().
//  383 *********************************************************************************************************
//  384 */
//  385 
//  386 #if OS_SCHED_LOCK_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  387 void  OSSchedLock (void)
//  388 {
OSSchedLock:
        PUSH     {R4,LR}
//  389 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  390     OS_CPU_SR  cpu_sr = 0;
//  391 #endif
//  392 
//  393 
//  394 
//  395     if (OSRunning == OS_TRUE) {                  /* Make sure multitasking is running                  */
        LDR.W    R4,??DataTable14
        LDRB     R0,[R4, #+5]
        CMP      R0,#+1
        BNE.N    ??OSSchedLock_0
//  396         OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  397         if (OSIntNesting == 0) {                 /* Can't call from an ISR                             */
        LDRB     R1,[R4, #+0]
        CBNZ.N   R1,??OSSchedLock_1
//  398             if (OSLockNesting < 255u) {          /* Prevent OSLockNesting from wrapping back to 0      */
        LDRB     R1,[R4, #+1]
        CMP      R1,#+255
        ITT      NE 
        ADDNE    R1,R1,#+1
        STRBNE   R1,[R4, #+1]
//  399                 OSLockNesting++;                 /* Increment lock nesting level                       */
//  400             }
//  401         }
//  402         OS_EXIT_CRITICAL();
??OSSchedLock_1:
        BL       OS_CPU_SR_Restore
//  403     }
//  404 }
??OSSchedLock_0:
        POP      {R4,PC}          ;; return
//  405 #endif
//  406 
//  407 /*$PAGE*/
//  408 /*
//  409 *********************************************************************************************************
//  410 *                                          ENABLE SCHEDULING
//  411 *
//  412 * Description: This function is used to re-allow rescheduling.
//  413 *
//  414 * Arguments  : none
//  415 *
//  416 * Returns    : none
//  417 *
//  418 * Notes      : 1) You MUST invoke OSSchedLock() and OSSchedUnlock() in pair.  In other words, for every
//  419 *                 call to OSSchedLock() you MUST have a call to OSSchedUnlock().
//  420 *********************************************************************************************************
//  421 */
//  422 
//  423 #if OS_SCHED_LOCK_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  424 void  OSSchedUnlock (void)
//  425 {
OSSchedUnlock:
        PUSH     {R4,LR}
//  426 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  427     OS_CPU_SR  cpu_sr = 0;
//  428 #endif
//  429 
//  430 
//  431 
//  432     if (OSRunning == OS_TRUE) {                            /* Make sure multitasking is running        */
        LDR.N    R4,??DataTable14
        LDRB     R0,[R4, #+5]
        CMP      R0,#+1
        BNE.N    ??OSSchedUnlock_0
//  433         OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  434         if (OSLockNesting > 0) {                           /* Do not decrement if already 0            */
        LDRB     R1,[R4, #+1]
        CBZ.N    R1,??OSSchedUnlock_1
//  435             OSLockNesting--;                               /* Decrement lock nesting level             */
        SUBS     R1,R1,#+1
        STRB     R1,[R4, #+1]
//  436             if (OSLockNesting == 0) {                      /* See if scheduler is enabled and ...      */
        UXTB     R1,R1
        CBNZ.N   R1,??OSSchedUnlock_1
//  437                 if (OSIntNesting == 0) {                   /* ... not in an ISR                        */
        LDRB     R1,[R4, #+0]
        CBNZ.N   R1,??OSSchedUnlock_1
//  438                     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  439                     OS_Sched();                            /* See if a HPT is ready                    */
        POP      {R4,LR}
        B.N      OS_Sched
//  440                 } else {
//  441                     OS_EXIT_CRITICAL();
//  442                 }
//  443             } else {
//  444                 OS_EXIT_CRITICAL();
//  445             }
//  446         } else {
//  447             OS_EXIT_CRITICAL();
??OSSchedUnlock_1:
        BL       OS_CPU_SR_Restore
//  448         }
//  449     }
//  450 }
??OSSchedUnlock_0:
        POP      {R4,PC}          ;; return
//  451 #endif
//  452 
//  453 /*$PAGE*/
//  454 /*
//  455 *********************************************************************************************************
//  456 *                                          START MULTITASKING
//  457 *
//  458 * Description: This function is used to start the multitasking process which lets uC/OS-II manages the
//  459 *              task that you have created.  Before you can call OSStart(), you MUST have called OSInit()
//  460 *              and you MUST have created at least one task.
//  461 *
//  462 * Arguments  : none
//  463 *
//  464 * Returns    : none
//  465 *
//  466 * Note       : OSStartHighRdy() MUST:
//  467 *                 a) Call OSTaskSwHook() then,
//  468 *                 b) Set OSRunning to OS_TRUE.
//  469 *                 c) Load the context of the task pointed to by OSTCBHighRdy.
//  470 *                 d_ Execute the task.
//  471 *********************************************************************************************************
//  472 */
//  473 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  474 void  OSStart (void)
//  475 {
OSStart:
        PUSH     {R4,LR}
//  476     if (OSRunning == OS_FALSE) {
        LDR.N    R4,??DataTable14
        LDRB     R0,[R4, #+5]
        CBNZ.N   R0,??OSStart_0
//  477         OS_SchedNew();                               /* Find highest priority's task priority number   */
        BL       OS_SchedNew
//  478         OSPrioCur     = OSPrioHighRdy;
        LDRB     R0,[R4, #+3]
        STRB     R0,[R4, #+2]
//  479         OSTCBHighRdy  = OSTCBPrioTbl[OSPrioHighRdy]; /* Point to highest priority task ready to run    */
        LDR.N    R1,??DataTable14_2
        LDR      R0,[R1, R0, LSL #+2]
        STR      R0,[R4, #+28]
//  480         OSTCBCur      = OSTCBHighRdy;
        STR      R0,[R4, #+20]
//  481         OSStartHighRdy();                            /* Execute target specific code to start task     */
        BL       OSStartHighRdy
//  482     }
//  483 }
??OSStart_0:
        POP      {R4,PC}          ;; return
//  484 /*$PAGE*/
//  485 /*
//  486 *********************************************************************************************************
//  487 *                                        STATISTICS INITIALIZATION
//  488 *
//  489 * Description: This function is called by your application to establish CPU usage by first determining
//  490 *              how high a 32-bit counter would count to in 1 second if no other tasks were to execute
//  491 *              during that time.  CPU usage is then determined by a low priority task which keeps track
//  492 *              of this 32-bit counter every second but this time, with other tasks running.  CPU usage is
//  493 *              determined by:
//  494 *
//  495 *                                             OSIdleCtr
//  496 *                 CPU Usage (%) = 100 * (1 - ------------)
//  497 *                                            OSIdleCtrMax
//  498 *
//  499 * Arguments  : none
//  500 *
//  501 * Returns    : none
//  502 *********************************************************************************************************
//  503 */
//  504 
//  505 #if OS_TASK_STAT_EN > 0
//  506 void  OSStatInit (void)
//  507 {
//  508 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  509     OS_CPU_SR  cpu_sr = 0;
//  510 #endif
//  511 
//  512 
//  513 
//  514     OSTimeDly(2);                                /* Synchronize with clock tick                        */
//  515     OS_ENTER_CRITICAL();
//  516     OSIdleCtr    = 0L;                           /* Clear idle counter                                 */
//  517     OS_EXIT_CRITICAL();
//  518     OSTimeDly(OS_TICKS_PER_SEC / 10);            /* Determine MAX. idle counter value for 1/10 second  */
//  519     OS_ENTER_CRITICAL();
//  520     OSIdleCtrMax = OSIdleCtr;                    /* Store maximum idle counter count in 1/10 second    */
//  521     OSStatRdy    = OS_TRUE;
//  522     OS_EXIT_CRITICAL();
//  523 }
//  524 #endif
//  525 /*$PAGE*/
//  526 /*
//  527 *********************************************************************************************************
//  528 *                                         PROCESS SYSTEM TICK
//  529 *
//  530 * Description: This function is used to signal to uC/OS-II the occurrence of a 'system tick' (also known
//  531 *              as a 'clock tick').  This function should be called by the ticker ISR but, can also be
//  532 *              called by a high priority task.
//  533 *
//  534 * Arguments  : none
//  535 *
//  536 * Returns    : none
//  537 *********************************************************************************************************
//  538 */
//  539 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  540 void  OSTimeTick (void)
//  541 {
OSTimeTick:
        PUSH     {R3-R5,LR}
//  542     OS_TCB    *ptcb;
//  543 #if OS_TICK_STEP_EN > 0
//  544     BOOLEAN    step;
//  545 #endif
//  546 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register     */
//  547     OS_CPU_SR  cpu_sr = 0;
//  548 #endif
//  549 
//  550 
//  551 
//  552 #if OS_TIME_TICK_HOOK_EN > 0
//  553     OSTimeTickHook();                                      /* Call user definable hook                     */
        BL       OSTimeTickHook
//  554 #endif
//  555 #if OS_TIME_GET_SET_EN > 0
//  556     OS_ENTER_CRITICAL();                                   /* Update the 32-bit tick counter               */
        BL       OS_CPU_SR_Save
//  557     OSTime++;
        LDR.N    R4,??DataTable14
        LDR      R1,[R4, #+36]
        ADDS     R1,R1,#+1
        STR      R1,[R4, #+36]
//  558     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  559 #endif
//  560     if (OSRunning == OS_TRUE) {
        LDRB     R0,[R4, #+5]
        CMP      R0,#+1
        BNE.N    ??OSTimeTick_0
//  561 #if OS_TICK_STEP_EN > 0
//  562         switch (OSTickStepState) {                         /* Determine whether we need to process a tick  */
        LDRB     R0,[R4, #+7]
        CBZ.N    R0,??OSTimeTick_1
        CMP      R0,#+2
        BEQ.N    ??OSTimeTick_2
        BCC.N    ??OSTimeTick_0
        B.N      ??OSTimeTick_3
//  563             case OS_TICK_STEP_DIS:                         /* Yes, stepping is disabled                    */
//  564                  step = OS_TRUE;
//  565                  break;
//  566 
//  567             case OS_TICK_STEP_WAIT:                        /* No,  waiting for uC/OS-View to set ...       */
//  568                  step = OS_FALSE;                          /*      .. OSTickStepState to OS_TICK_STEP_ONCE */
//  569                  break;
//  570 
//  571             case OS_TICK_STEP_ONCE:                        /* Yes, process tick once and wait for next ... */
//  572                  step            = OS_TRUE;                /*      ... step command from uC/OS-View        */
//  573                  OSTickStepState = OS_TICK_STEP_WAIT;
??OSTimeTick_2:
        MOVS     R0,#+1
        B.N      ??OSTimeTick_4
//  574                  break;
//  575 
//  576             default:                                       /* Invalid case, correct situation              */
//  577                  step            = OS_TRUE;
//  578                  OSTickStepState = OS_TICK_STEP_DIS;
??OSTimeTick_3:
        MOVS     R0,#+0
??OSTimeTick_4:
        STRB     R0,[R4, #+7]
//  579                  break;
//  580         }
//  581         if (step == OS_FALSE) {                            /* Return if waiting for step command           */
//  582             return;
//  583         }
//  584 #endif
//  585         ptcb = OSTCBList;                                  /* Point at first TCB in TCB list               */
??OSTimeTick_1:
        LDR      R5,[R4, #+32]
//  586         while (ptcb->OSTCBPrio != OS_TASK_IDLE_PRIO) {     /* Go through all TCBs in TCB list              */
        LDRB     R0,[R5, #+30]
        CMP      R0,#+31
        BEQ.N    ??OSTimeTick_0
//  587             OS_ENTER_CRITICAL();
??OSTimeTick_5:
        BL       OS_CPU_SR_Save
//  588             if (ptcb->OSTCBDly != 0) {                     /* No, Delayed or waiting for event with TO     */
        ADDS     R1,R5,#+4
        LDRH     R2,[R1, #+22]
        CBZ.N    R2,??OSTimeTick_6
//  589                 if (--ptcb->OSTCBDly == 0) {               /* Decrement nbr of ticks to end of delay       */
        SUBS     R2,R2,#+1
        STRH     R2,[R1, #+22]
        UXTH     R2,R2
        CBNZ.N   R2,??OSTimeTick_6
//  590                                                            /* Check for timeout                            */
//  591                     if ((ptcb->OSTCBStat & OS_STAT_PEND_ANY) != OS_STAT_RDY) {
        LDRB     R2,[R1, #+24]
        MOVS     R3,#+55
        TST      R2,R3
        ITTTE    NE 
        ANDNE    R2,R2,#0xC8
        STRBNE   R2,[R1, #+24]
        MOVNE    R2,#+1
        MOVEQ    R2,#+0
//  592                         ptcb->OSTCBStat  &= ~(INT8U)OS_STAT_PEND_ANY;          /* Yes, Clear status flag   */
//  593                         ptcb->OSTCBStatPend = OS_STAT_PEND_TO;                 /* Indicate PEND timeout    */
//  594                     } else {
//  595                         ptcb->OSTCBStatPend = OS_STAT_PEND_OK;
        STRB     R2,[R1, #+25]
//  596                     }
//  597 
//  598                     if ((ptcb->OSTCBStat & OS_STAT_SUSPEND) == OS_STAT_RDY) {  /* Is task suspended?       */
        LDRB     R2,[R1, #+24]
        LSLS     R2,R2,#+28
        BMI.N    ??OSTimeTick_6
//  599                         OSRdyGrp               |= ptcb->OSTCBBitY;             /* No,  Make ready          */
        LDRB     R2,[R4, #+4]
        LDRB     R3,[R1, #+30]
        ORRS     R2,R3,R2
        STRB     R2,[R4, #+4]
//  600                         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
        LDRB     R2,[R1, #+28]
        ADDS     R2,R2,R4
        LDRB     R3,[R2, #+8]
        LDRB     R1,[R1, #+29]
        ORRS     R1,R1,R3
        STRB     R1,[R2, #+8]
//  601                     }
//  602                 }
//  603             }
//  604             ptcb = ptcb->OSTCBNext;                        /* Point at next TCB in TCB list                */
??OSTimeTick_6:
        LDR      R5,[R5, #+4]
//  605             OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
        LDRB     R0,[R5, #+30]
        CMP      R0,#+31
        BNE.N    ??OSTimeTick_5
??OSTimeTick_0:
        POP      {R0,R4,R5,PC}    ;; return
//  606         }
//  607     }
//  608 }
//  609 
//  610 /*$PAGE*/
//  611 /*
//  612 *********************************************************************************************************
//  613 *                                             GET VERSION
//  614 *
//  615 * Description: This function is used to return the version number of uC/OS-II.  The returned value
//  616 *              corresponds to uC/OS-II's version number multiplied by 100.  In other words, version 2.00
//  617 *              would be returned as 200.
//  618 *
//  619 * Arguments  : none
//  620 *
//  621 * Returns    : the version number of uC/OS-II multiplied by 100.
//  622 *********************************************************************************************************
//  623 */
//  624 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  625 INT16U  OSVersion (void)
//  626 {
//  627     return (OS_VERSION);
OSVersion:
        MOVW     R0,#+285
        BX       LR               ;; return
//  628 }
//  629 
//  630 /*$PAGE*/
//  631 /*
//  632 *********************************************************************************************************
//  633 *                                            DUMMY FUNCTION
//  634 *
//  635 * Description: This function doesn't do anything.  It is called by OSTaskDel().
//  636 *
//  637 * Arguments  : none
//  638 *
//  639 * Returns    : none
//  640 *********************************************************************************************************
//  641 */
//  642 
//  643 #if OS_TASK_DEL_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  644 void  OS_Dummy (void)
//  645 {
//  646 }
OS_Dummy:
        BX       LR               ;; return
//  647 #endif
//  648 
//  649 /*$PAGE*/
//  650 /*
//  651 *********************************************************************************************************
//  652 *                             MAKE TASK READY TO RUN BASED ON EVENT OCCURING
//  653 *
//  654 * Description: This function is called by other uC/OS-II services and is used to ready a task that was
//  655 *              waiting for an event to occur.
//  656 *
//  657 * Arguments  : pevent      is a pointer to the event control block corresponding to the event.
//  658 *
//  659 *              pmsg        is a pointer to a message.  This pointer is used by message oriented services
//  660 *                          such as MAILBOXEs and QUEUEs.  The pointer is not used when called by other
//  661 *                          service functions.
//  662 *
//  663 *              msk         is a mask that is used to clear the status byte of the TCB.  For example,
//  664 *                          OSSemPost() will pass OS_STAT_SEM, OSMboxPost() will pass OS_STAT_MBOX etc.
//  665 *
//  666 *              pend_stat   is used to indicate the readied task's pending status:
//  667 *
//  668 *                          OS_STAT_PEND_OK      Task ready due to a post (or delete), not a timeout or
//  669 *                                               an abort.
//  670 *                          OS_STAT_PEND_ABORT   Task ready due to an abort.
//  671 *
//  672 * Returns    : none
//  673 *
//  674 * Note       : This function is INTERNAL to uC/OS-II and your application should not call it.
//  675 *********************************************************************************************************
//  676 */
//  677 #if OS_EVENT_EN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  678 INT8U  OS_EventTaskRdy (OS_EVENT *pevent, void *pmsg, INT8U msk, INT8U pend_stat)
//  679 {
OS_EventTaskRdy:
        PUSH     {R4-R7,LR}
//  680     OS_TCB  *ptcb;
//  681     INT8U    x;
//  682     INT8U    y;
//  683     INT8U    prio;
//  684 #if OS_LOWEST_PRIO <= 63
//  685     INT8U    bitx;
//  686     INT8U    bity;
//  687 #else
//  688     INT16U   bitx;
//  689     INT16U   bity;
//  690     INT16U  *ptbl;
//  691 #endif
//  692 
//  693 
//  694 #if OS_LOWEST_PRIO <= 63
//  695     y     = OSUnMapTbl[pevent->OSEventGrp];             /* Find HPT waiting for message                */
        ADR.W    R4,OSUnMapTbl
        LDRB     R5,[R0, #+10]
        LDRB     R5,[R5, R4]
//  696     bity  = (INT8U)(1 << y);
        MOVS     R7,#+1
        LSL      R6,R7,R5
        UXTB     R6,R6
//  697     x     = OSUnMapTbl[pevent->OSEventTbl[y]];
        ADD      R12,R5,R0
        LDRB     LR,[R12, #+11]
        LDRB     R4,[LR, R4]
//  698     bitx  = (INT8U)(1 << x);
        LSLS     R7,R7,R4
        UXTB     R7,R7
//  699     prio  = (INT8U)((y << 3) + x);                      /* Find priority of task getting the msg       */
        ADD      R4,R4,R5, LSL #+3
//  700 #else
//  701     if ((pevent->OSEventGrp & 0xFF) != 0) {             /* Find HPT waiting for message                */
//  702         y = OSUnMapTbl[pevent->OSEventGrp & 0xFF];
//  703     } else {
//  704         y = OSUnMapTbl[(pevent->OSEventGrp >> 8) & 0xFF] + 8;
//  705     }
//  706     bity = (INT16U)(1 << y);
//  707     ptbl = &pevent->OSEventTbl[y];
//  708     if ((*ptbl & 0xFF) != 0) {
//  709         x = OSUnMapTbl[*ptbl & 0xFF];
//  710     } else {
//  711         x = OSUnMapTbl[(*ptbl >> 8) & 0xFF] + 8;
//  712     }
//  713     bitx = (INT16U)(1 << x);
//  714     prio = (INT8U)((y << 4) + x);                       /* Find priority of task getting the msg       */
//  715 #endif
//  716 
//  717     pevent->OSEventTbl[y] &= ~bitx;                     /* Remove this task from the waiting list      */
        BIC      LR,LR,R7
        STRB     LR,[R12, #+11]
//  718     if (pevent->OSEventTbl[y] == 0) {
        LDRB     R12,[R12, #+11]
        CMP      R12,#+0
        BNE.N    ??OS_EventTaskRdy_0
//  719         pevent->OSEventGrp &= ~bity;                    /* Clr group bit if this was only task pending */
        LDRB     R12,[R0, #+10]
        BIC      R12,R12,R6
        STRB     R12,[R0, #+10]
//  720     }
//  721     ptcb                 =  OSTCBPrioTbl[prio];         /* Point to this task's OS_TCB                 */
??OS_EventTaskRdy_0:
        UXTB     R4,R4
        LDR.N    R0,??DataTable14_2
        LDR      R0,[R0, R4, LSL #+2]
//  722     ptcb->OSTCBDly       =  0;                          /* Prevent OSTimeTick() from readying task     */
        MOV      R12,#+0
        STRH     R12,[R0, #+26]
//  723     ptcb->OSTCBEventPtr  = (OS_EVENT *)0;               /* Unlink ECB from this task                   */
        STR      R12,[R0, #+12]
//  724 #if ((OS_Q_EN > 0) && (OS_MAX_QS > 0)) || (OS_MBOX_EN > 0)
//  725     ptcb->OSTCBMsg       =  pmsg;                       /* Send message directly to waiting task       */
        STR      R1,[R0, #+16]
//  726 #else
//  727     pmsg                 =  pmsg;                       /* Prevent compiler warning if not used        */
//  728 #endif
//  729     ptcb->OSTCBStatPend  =  pend_stat;                  /* Set pend status of post or abort            */
        STRB     R3,[R0, #+29]
//  730     ptcb->OSTCBStat     &= ~msk;                        /* Clear bit associated with event type        */
        LDRB     R1,[R0, #+28]
        BICS     R1,R1,R2
        STRB     R1,[R0, #+28]
//  731     if (ptcb->OSTCBStat ==  OS_STAT_RDY) {              /* See if task is ready (could be susp'd)      */
        BNE.N    ??OS_EventTaskRdy_1
//  732         OSRdyGrp        |=  bity;                       /* Put task in the ready to run list           */
        LDR.N    R0,??DataTable14
        LDRB     R1,[R0, #+4]
        ORRS     R1,R6,R1
        STRB     R1,[R0, #+4]
//  733         OSRdyTbl[y]     |=  bitx;
        ADDS     R0,R5,R0
        LDRB     R1,[R0, #+8]
        ORRS     R1,R7,R1
        STRB     R1,[R0, #+8]
//  734     }
//  735     return (prio);
??OS_EventTaskRdy_1:
        MOV      R0,R4
        POP      {R4-R7,PC}       ;; return
//  736 }
//  737 #endif
//  738 /*$PAGE*/
//  739 /*
//  740 *********************************************************************************************************
//  741 *                                   MAKE TASK WAIT FOR EVENT TO OCCUR
//  742 *
//  743 * Description: This function is called by other uC/OS-II services to suspend a task because an event has
//  744 *              not occurred.
//  745 *
//  746 * Arguments  : pevent   is a pointer to the event control block for which the task will be waiting for.
//  747 *
//  748 * Returns    : none
//  749 *
//  750 * Note       : This function is INTERNAL to uC/OS-II and your application should not call it.
//  751 *********************************************************************************************************
//  752 */
//  753 #if OS_EVENT_EN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  754 void  OS_EventTaskWait (OS_EVENT *pevent)
//  755 {
OS_EventTaskWait:
        PUSH     {R4,R5}
//  756     INT8U  y;
//  757 
//  758 
//  759     OSTCBCur->OSTCBEventPtr =  pevent;            /* Store pointer to event control block in TCB       */
        LDR.N    R1,??DataTable14
        LDR      R2,[R1, #+20]
        STR      R0,[R2, #+12]
//  760     y                       =  OSTCBCur->OSTCBY;  /* Task no longer ready                              */
        ADDW     R2,R2,#+12
        LDRB     R3,[R2, #+20]
//  761     OSRdyTbl[y]            &= ~OSTCBCur->OSTCBBitX;
        ADDS     R3,R3,R1
        LDRB     R4,[R3, #+8]
        LDRB     R5,[R2, #+21]
        BICS     R4,R4,R5
        STRB     R4,[R3, #+8]
//  762     if (OSRdyTbl[y] == 0) {
        BNE.N    ??OS_EventTaskWait_0
//  763         OSRdyGrp &= ~OSTCBCur->OSTCBBitY;         /* Clear event grp bit if this was only task pending */
        LDRB     R3,[R1, #+4]
        LDRB     R4,[R2, #+22]
        BICS     R3,R3,R4
        STRB     R3,[R1, #+4]
//  764     }
//  765     pevent->OSEventTbl[OSTCBCur->OSTCBY] |= OSTCBCur->OSTCBBitX;          /* Put task in waiting list  */
??OS_EventTaskWait_0:
        LDRB     R3,[R2, #+20]
        ADDS     R3,R3,R0
        LDRB     R4,[R3, #+11]
        LDRB     R2,[R2, #+21]
        ORRS     R2,R2,R4
        STRB     R2,[R3, #+11]
//  766     pevent->OSEventGrp                   |= OSTCBCur->OSTCBBitY;
        LDRB     R2,[R0, #+10]
        LDR      R1,[R1, #+20]
        LDRB     R1,[R1, #+34]
        ORRS     R1,R1,R2
        STRB     R1,[R0, #+10]
//  767 }
        POP      {R4,R5}
        BX       LR               ;; return
//  768 #endif
//  769 /*$PAGE*/
//  770 /*
//  771 *********************************************************************************************************
//  772 *                          MAKE TASK READY TO RUN BASED ON EVENT TIMEOUT OR ABORT
//  773 *
//  774 * Description: This function is called by other uC/OS-II services to make a task ready to run because a
//  775 *              timeout or abort occurred.
//  776 *
//  777 * Arguments  : pevent   is a pointer to the event control block which is readying a task.
//  778 *
//  779 * Returns    : none
//  780 *
//  781 * Note       : This function is INTERNAL to uC/OS-II and your application should not call it.
//  782 *********************************************************************************************************
//  783 */
//  784 #if OS_EVENT_EN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  785 void  OS_EventTOAbort (OS_EVENT *pevent)
//  786 {
//  787     INT8U  y;
//  788 
//  789 
//  790     y                       =  OSTCBCur->OSTCBY;
OS_EventTOAbort:
        LDR.N    R1,??DataTable14
        LDR      R2,[R1, #+20]
        LDRB     R3,[R2, #+32]
//  791     pevent->OSEventTbl[y]  &= ~OSTCBCur->OSTCBBitX;    /* Remove task from wait list                   */
        ADDS     R3,R3,R0
        LDRB     R12,[R3, #+11]
        LDRB     R2,[R2, #+33]
        BIC      R2,R12,R2
        STRB     R2,[R3, #+11]
//  792     if (pevent->OSEventTbl[y] == 0x00) {
        LDRB     R2,[R3, #+11]
        CBNZ.N   R2,??OS_EventTOAbort_0
//  793         pevent->OSEventGrp &= ~OSTCBCur->OSTCBBitY;
        LDRB     R2,[R0, #+10]
        LDR      R3,[R1, #+20]
        LDRB     R3,[R3, #+34]
        BICS     R2,R2,R3
        STRB     R2,[R0, #+10]
//  794     }
//  795     OSTCBCur->OSTCBStatPend =  OS_STAT_PEND_OK;        /* Clear pend status                            */
??OS_EventTOAbort_0:
        LDR      R0,[R1, #+20]
        MOVS     R2,#+0
        STRB     R2,[R0, #+29]
//  796     OSTCBCur->OSTCBStat     =  OS_STAT_RDY;            /* Set status to ready                          */
        LDR      R0,[R1, #+20]
        STRB     R2,[R0, #+28]
//  797     OSTCBCur->OSTCBEventPtr = (OS_EVENT *)0;           /* No longer waiting for event                  */
        LDR      R0,[R1, #+20]
        STR      R2,[R0, #+12]
//  798 }
        BX       LR               ;; return
//  799 #endif
//  800 /*$PAGE*/
//  801 /*
//  802 *********************************************************************************************************
//  803 *                                 INITIALIZE EVENT CONTROL BLOCK'S WAIT LIST
//  804 *
//  805 * Description: This function is called by other uC/OS-II services to initialize the event wait list.
//  806 *
//  807 * Arguments  : pevent    is a pointer to the event control block allocated to the event.
//  808 *
//  809 * Returns    : none
//  810 *
//  811 * Note       : This function is INTERNAL to uC/OS-II and your application should not call it.
//  812 *********************************************************************************************************
//  813 */
//  814 #if OS_EVENT_EN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  815 void  OS_EventWaitListInit (OS_EVENT *pevent)
//  816 {
//  817 #if OS_LOWEST_PRIO <= 63
//  818     INT8U  *ptbl;
//  819 #else
//  820     INT16U *ptbl;
//  821 #endif
//  822     INT8U   i;
//  823 
//  824 
//  825     pevent->OSEventGrp = 0;                      /* No task waiting on event                           */
OS_EventWaitListInit:
        MOVS     R1,#+0
        STRB     R1,[R0, #+10]
//  826     ptbl               = &pevent->OSEventTbl[0];
//  827 
//  828     for (i = 0; i < OS_EVENT_TBL_SIZE; i++) {
//  829         *ptbl++ = 0;
        MOVS     R1,#+4
        ADDS     R0,R0,#+11
        B.W      __aeabi_memclr
//  830     }
//  831 }
//  832 #endif
//  833 /*$PAGE*/
//  834 /*
//  835 *********************************************************************************************************
//  836 *                                             INITIALIZATION
//  837 *                           INITIALIZE THE FREE LIST OF EVENT CONTROL BLOCKS
//  838 *
//  839 * Description: This function is called by OSInit() to initialize the free list of event control blocks.
//  840 *
//  841 * Arguments  : none
//  842 *
//  843 * Returns    : none
//  844 *********************************************************************************************************
//  845 */
//  846 
//  847 static  void  OS_InitEventList (void)
//  848 {
//  849 #if OS_EVENT_EN && (OS_MAX_EVENTS > 0)
//  850 #if (OS_MAX_EVENTS > 1)
//  851     INT16U     i;
//  852     OS_EVENT  *pevent1;
//  853     OS_EVENT  *pevent2;
//  854 
//  855 
//  856     OS_MemClr((INT8U *)&OSEventTbl[0], sizeof(OSEventTbl)); /* Clear the event table                   */
//  857     pevent1 = &OSEventTbl[0];
//  858     pevent2 = &OSEventTbl[1];
//  859     for (i = 0; i < (OS_MAX_EVENTS - 1); i++) {             /* Init. list of free EVENT control blocks */
//  860         pevent1->OSEventType    = OS_EVENT_TYPE_UNUSED;
//  861         pevent1->OSEventPtr     = pevent2;
//  862 #if OS_EVENT_NAME_SIZE > 1
//  863         pevent1->OSEventName[0] = '?';                      /* Unknown name                            */
//  864         pevent1->OSEventName[1] = OS_ASCII_NUL;
//  865 #endif
//  866         pevent1++;
//  867         pevent2++;
//  868     }
//  869     pevent1->OSEventType            = OS_EVENT_TYPE_UNUSED;
//  870     pevent1->OSEventPtr             = (OS_EVENT *)0;
//  871 #if OS_EVENT_NAME_SIZE > 1
//  872     pevent1->OSEventName[0]         = '?';
//  873     pevent1->OSEventName[1]         = OS_ASCII_NUL;
//  874 #endif
//  875     OSEventFreeList                 = &OSEventTbl[0];
//  876 #else
//  877     OSEventFreeList                 = &OSEventTbl[0];       /* Only have ONE event control block       */
//  878     OSEventFreeList->OSEventType    = OS_EVENT_TYPE_UNUSED;
//  879     OSEventFreeList->OSEventPtr     = (OS_EVENT *)0;
//  880 #if OS_EVENT_NAME_SIZE > 1
//  881     OSEventFreeList->OSEventName[0] = '?';                  /* Unknown name                            */
//  882     OSEventFreeList->OSEventName[1] = OS_ASCII_NUL;
//  883 #endif
//  884 #endif
//  885 #endif
//  886 }
//  887 /*$PAGE*/
//  888 /*
//  889 *********************************************************************************************************
//  890 *                                             INITIALIZATION
//  891 *                                    INITIALIZE MISCELLANEOUS VARIABLES
//  892 *
//  893 * Description: This function is called by OSInit() to initialize miscellaneous variables.
//  894 *
//  895 * Arguments  : none
//  896 *
//  897 * Returns    : none
//  898 *********************************************************************************************************
//  899 */
//  900 
//  901 static  void  OS_InitMisc (void)
//  902 {
//  903 #if OS_TIME_GET_SET_EN > 0
//  904     OSTime        = 0L;                                    /* Clear the 32-bit system clock            */
//  905 #endif
//  906 
//  907     OSIntNesting  = 0;                                     /* Clear the interrupt nesting counter      */
//  908     OSLockNesting = 0;                                     /* Clear the scheduling lock counter        */
//  909 
//  910     OSTaskCtr     = 0;                                     /* Clear the number of tasks                */
//  911 
//  912     OSRunning     = OS_FALSE;                              /* Indicate that multitasking not started   */
//  913 
//  914     OSCtxSwCtr    = 0;                                     /* Clear the context switch counter         */
//  915     OSIdleCtr     = 0L;                                    /* Clear the 32-bit idle counter            */
//  916 
//  917 #if OS_TASK_STAT_EN > 0
//  918     OSIdleCtrRun  = 0L;
//  919     OSIdleCtrMax  = 0L;
//  920     OSStatRdy     = OS_FALSE;                              /* Statistic task is not ready              */
//  921 #endif
//  922 }
//  923 /*$PAGE*/
//  924 /*
//  925 *********************************************************************************************************
//  926 *                                             INITIALIZATION
//  927 *                                       INITIALIZE THE READY LIST
//  928 *
//  929 * Description: This function is called by OSInit() to initialize the Ready List.
//  930 *
//  931 * Arguments  : none
//  932 *
//  933 * Returns    : none
//  934 *********************************************************************************************************
//  935 */
//  936 
//  937 static  void  OS_InitRdyList (void)
//  938 {
//  939     INT8U    i;
//  940 #if OS_LOWEST_PRIO <= 63
//  941     INT8U   *prdytbl;
//  942 #else
//  943     INT16U  *prdytbl;
//  944 #endif
//  945 
//  946 
//  947     OSRdyGrp      = 0;                                     /* Clear the ready list                     */
//  948     prdytbl       = &OSRdyTbl[0];
//  949     for (i = 0; i < OS_RDY_TBL_SIZE; i++) {
//  950         *prdytbl++ = 0;
//  951     }
//  952 
//  953     OSPrioCur     = 0;
//  954     OSPrioHighRdy = 0;
//  955 
//  956     OSTCBHighRdy  = (OS_TCB *)0;
//  957     OSTCBCur      = (OS_TCB *)0;
//  958 }
//  959 
//  960 /*$PAGE*/
//  961 /*
//  962 *********************************************************************************************************
//  963 *                                             INITIALIZATION
//  964 *                                         CREATING THE IDLE TASK
//  965 *
//  966 * Description: This function creates the Idle Task.
//  967 *
//  968 * Arguments  : none
//  969 *
//  970 * Returns    : none
//  971 *********************************************************************************************************
//  972 */
//  973 
//  974 static  void  OS_InitTaskIdle (void)
//  975 {
//  976 #if OS_TASK_NAME_SIZE > 7
//  977     INT8U  err;
//  978 #endif
//  979 
//  980 
//  981 #if OS_TASK_CREATE_EXT_EN > 0
//  982     #if OS_STK_GROWTH == 1
//  983     (void)OSTaskCreateExt(OS_TaskIdle,
//  984                           (void *)0,                                 /* No arguments passed to OS_TaskIdle() */
//  985                           &OSTaskIdleStk[OS_TASK_IDLE_STK_SIZE - 1], /* Set Top-Of-Stack                     */
//  986                           OS_TASK_IDLE_PRIO,                         /* Lowest priority level                */
//  987                           OS_TASK_IDLE_ID,
//  988                           &OSTaskIdleStk[0],                         /* Set Bottom-Of-Stack                  */
//  989                           OS_TASK_IDLE_STK_SIZE,
//  990                           (void *)0,                                 /* No TCB extension                     */
//  991                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);/* Enable stack checking + clear stack  */
//  992     #else
//  993     (void)OSTaskCreateExt(OS_TaskIdle,
//  994                           (void *)0,                                 /* No arguments passed to OS_TaskIdle() */
//  995                           &OSTaskIdleStk[0],                         /* Set Top-Of-Stack                     */
//  996                           OS_TASK_IDLE_PRIO,                         /* Lowest priority level                */
//  997                           OS_TASK_IDLE_ID,
//  998                           &OSTaskIdleStk[OS_TASK_IDLE_STK_SIZE - 1], /* Set Bottom-Of-Stack                  */
//  999                           OS_TASK_IDLE_STK_SIZE,
// 1000                           (void *)0,                                 /* No TCB extension                     */
// 1001                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);/* Enable stack checking + clear stack  */
// 1002     #endif
// 1003 #else
// 1004     #if OS_STK_GROWTH == 1
// 1005     (void)OSTaskCreate(OS_TaskIdle,
// 1006                        (void *)0,
// 1007                        &OSTaskIdleStk[OS_TASK_IDLE_STK_SIZE - 1],
// 1008                        OS_TASK_IDLE_PRIO);
// 1009     #else
// 1010     (void)OSTaskCreate(OS_TaskIdle,
// 1011                        (void *)0,
// 1012                        &OSTaskIdleStk[0],
// 1013                        OS_TASK_IDLE_PRIO);
// 1014     #endif
// 1015 #endif
// 1016 
// 1017 #if OS_TASK_NAME_SIZE > 14
// 1018     OSTaskNameSet(OS_TASK_IDLE_PRIO, (INT8U *)"uC/OS-II Idle", &err);
// 1019 #else
// 1020 #if OS_TASK_NAME_SIZE > 7
// 1021     OSTaskNameSet(OS_TASK_IDLE_PRIO, (INT8U *)"OS-Idle", &err);
// 1022 #endif
// 1023 #endif
// 1024 }
// 1025 /*$PAGE*/
// 1026 /*
// 1027 *********************************************************************************************************
// 1028 *                                             INITIALIZATION
// 1029 *                                      CREATING THE STATISTIC TASK
// 1030 *
// 1031 * Description: This function creates the Statistic Task.
// 1032 *
// 1033 * Arguments  : none
// 1034 *
// 1035 * Returns    : none
// 1036 *********************************************************************************************************
// 1037 */
// 1038 
// 1039 #if OS_TASK_STAT_EN > 0
// 1040 static  void  OS_InitTaskStat (void)
// 1041 {
// 1042 #if OS_TASK_NAME_SIZE > 7
// 1043     INT8U  err;
// 1044 #endif
// 1045 
// 1046 
// 1047 #if OS_TASK_CREATE_EXT_EN > 0
// 1048     #if OS_STK_GROWTH == 1
// 1049     (void)OSTaskCreateExt(OS_TaskStat,
// 1050                           (void *)0,                                   /* No args passed to OS_TaskStat()*/
// 1051                           &OSTaskStatStk[OS_TASK_STAT_STK_SIZE - 1],   /* Set Top-Of-Stack               */
// 1052                           OS_TASK_STAT_PRIO,                           /* One higher than the idle task  */
// 1053                           OS_TASK_STAT_ID,
// 1054                           &OSTaskStatStk[0],                           /* Set Bottom-Of-Stack            */
// 1055                           OS_TASK_STAT_STK_SIZE,
// 1056                           (void *)0,                                   /* No TCB extension               */
// 1057                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);  /* Enable stack checking + clear  */
// 1058     #else
// 1059     (void)OSTaskCreateExt(OS_TaskStat,
// 1060                           (void *)0,                                   /* No args passed to OS_TaskStat()*/
// 1061                           &OSTaskStatStk[0],                           /* Set Top-Of-Stack               */
// 1062                           OS_TASK_STAT_PRIO,                           /* One higher than the idle task  */
// 1063                           OS_TASK_STAT_ID,
// 1064                           &OSTaskStatStk[OS_TASK_STAT_STK_SIZE - 1],   /* Set Bottom-Of-Stack            */
// 1065                           OS_TASK_STAT_STK_SIZE,
// 1066                           (void *)0,                                   /* No TCB extension               */
// 1067                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);  /* Enable stack checking + clear  */
// 1068     #endif
// 1069 #else
// 1070     #if OS_STK_GROWTH == 1
// 1071     (void)OSTaskCreate(OS_TaskStat,
// 1072                        (void *)0,                                      /* No args passed to OS_TaskStat()*/
// 1073                        &OSTaskStatStk[OS_TASK_STAT_STK_SIZE - 1],      /* Set Top-Of-Stack               */
// 1074                        OS_TASK_STAT_PRIO);                             /* One higher than the idle task  */
// 1075     #else
// 1076     (void)OSTaskCreate(OS_TaskStat,
// 1077                        (void *)0,                                      /* No args passed to OS_TaskStat()*/
// 1078                        &OSTaskStatStk[0],                              /* Set Top-Of-Stack               */
// 1079                        OS_TASK_STAT_PRIO);                             /* One higher than the idle task  */
// 1080     #endif
// 1081 #endif
// 1082 
// 1083 #if OS_TASK_NAME_SIZE > 14
// 1084     OSTaskNameSet(OS_TASK_STAT_PRIO, (INT8U *)"uC/OS-II Stat", &err);
// 1085 #else
// 1086 #if OS_TASK_NAME_SIZE > 7
// 1087     OSTaskNameSet(OS_TASK_STAT_PRIO, (INT8U *)"OS-Stat", &err);
// 1088 #endif
// 1089 #endif
// 1090 }
// 1091 #endif
// 1092 /*$PAGE*/
// 1093 /*
// 1094 *********************************************************************************************************
// 1095 *                                             INITIALIZATION
// 1096 *                            INITIALIZE THE FREE LIST OF TASK CONTROL BLOCKS
// 1097 *
// 1098 * Description: This function is called by OSInit() to initialize the free list of OS_TCBs.
// 1099 *
// 1100 * Arguments  : none
// 1101 *
// 1102 * Returns    : none
// 1103 *********************************************************************************************************
// 1104 */
// 1105 
// 1106 static  void  OS_InitTCBList (void)
// 1107 {
// 1108     INT8U    i;
// 1109     OS_TCB  *ptcb1;
// 1110     OS_TCB  *ptcb2;
// 1111 
// 1112 
// 1113     OS_MemClr((INT8U *)&OSTCBTbl[0],     sizeof(OSTCBTbl));      /* Clear all the TCBs                 */
// 1114     OS_MemClr((INT8U *)&OSTCBPrioTbl[0], sizeof(OSTCBPrioTbl));  /* Clear the priority table           */
// 1115     ptcb1 = &OSTCBTbl[0];
// 1116     ptcb2 = &OSTCBTbl[1];
// 1117     for (i = 0; i < (OS_MAX_TASKS + OS_N_SYS_TASKS - 1); i++) {  /* Init. list of free TCBs            */
// 1118         ptcb1->OSTCBNext = ptcb2;
// 1119 #if OS_TASK_NAME_SIZE > 1
// 1120         ptcb1->OSTCBTaskName[0] = '?';                           /* Unknown name                       */
// 1121         ptcb1->OSTCBTaskName[1] = OS_ASCII_NUL;
// 1122 #endif
// 1123         ptcb1++;
// 1124         ptcb2++;
// 1125     }
// 1126     ptcb1->OSTCBNext = (OS_TCB *)0;                              /* Last OS_TCB                        */
// 1127 #if OS_TASK_NAME_SIZE > 1
// 1128     ptcb1->OSTCBTaskName[0] = '?';                               /* Unknown name                       */
// 1129     ptcb1->OSTCBTaskName[1] = OS_ASCII_NUL;
// 1130 #endif
// 1131     OSTCBList               = (OS_TCB *)0;                       /* TCB lists initializations          */
// 1132     OSTCBFreeList           = &OSTCBTbl[0];
// 1133 }
// 1134 /*$PAGE*/
// 1135 /*
// 1136 *********************************************************************************************************
// 1137 *                                        CLEAR A SECTION OF MEMORY
// 1138 *
// 1139 * Description: This function is called by other uC/OS-II services to clear a contiguous block of RAM.
// 1140 *
// 1141 * Arguments  : pdest    is the start of the RAM to clear (i.e. write 0x00 to)
// 1142 *
// 1143 *              size     is the number of bytes to clear.
// 1144 *
// 1145 * Returns    : none
// 1146 *
// 1147 * Notes      : 1) This function is INTERNAL to uC/OS-II and your application should not call it.
// 1148 *              2) Note that we can only clear up to 64K bytes of RAM.  This is not an issue because none
// 1149 *                 of the uses of this function gets close to this limit.
// 1150 *              3) The clear is done one byte at a time since this will work on any processor irrespective
// 1151 *                 of the alignment of the destination.
// 1152 *********************************************************************************************************
// 1153 */
// 1154 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1155 void  OS_MemClr (INT8U *pdest, INT16U size)
// 1156 {
OS_MemClr:
        CBZ.N    R1,??OS_MemClr_0
// 1157     while (size > 0) {
// 1158         *pdest++ = (INT8U)0;
??OS_MemClr_1:
        MOVS     R2,#+0
        STRB     R2,[R0], #+1
// 1159         size--;
        SUBS     R1,R1,#+1
// 1160     }
        UXTH     R1,R1
        CMP      R1,#+0
        BNE.N    ??OS_MemClr_1
// 1161 }
??OS_MemClr_0:
        BX       LR               ;; return
// 1162 /*$PAGE*/
// 1163 /*
// 1164 *********************************************************************************************************
// 1165 *                                        COPY A BLOCK OF MEMORY
// 1166 *
// 1167 * Description: This function is called by other uC/OS-II services to copy a block of memory from one
// 1168 *              location to another.
// 1169 *
// 1170 * Arguments  : pdest    is a pointer to the 'destination' memory block
// 1171 *
// 1172 *              psrc     is a pointer to the 'source'      memory block
// 1173 *
// 1174 *              size     is the number of bytes to copy.
// 1175 *
// 1176 * Returns    : none
// 1177 *
// 1178 * Notes      : 1) This function is INTERNAL to uC/OS-II and your application should not call it.  There is
// 1179 *                 no provision to handle overlapping memory copy.  However, that's not a problem since this
// 1180 *                 is not a situation that will happen.
// 1181 *              2) Note that we can only copy up to 64K bytes of RAM
// 1182 *              3) The copy is done one byte at a time since this will work on any processor irrespective
// 1183 *                 of the alignment of the source and destination.
// 1184 *********************************************************************************************************
// 1185 */
// 1186 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1187 void  OS_MemCopy (INT8U *pdest, INT8U *psrc, INT16U size)
// 1188 {
OS_MemCopy:
        CBZ.N    R2,??OS_MemCopy_0
// 1189     while (size > 0) {
// 1190         *pdest++ = *psrc++;
??OS_MemCopy_1:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
// 1191         size--;
        SUBS     R2,R2,#+1
// 1192     }
        UXTH     R2,R2
        CMP      R2,#+0
        BNE.N    ??OS_MemCopy_1
// 1193 }
??OS_MemCopy_0:
        BX       LR               ;; return
// 1194 /*$PAGE*/
// 1195 /*
// 1196 *********************************************************************************************************
// 1197 *                                              SCHEDULER
// 1198 *
// 1199 * Description: This function is called by other uC/OS-II services to determine whether a new, high
// 1200 *              priority task has been made ready to run.  This function is invoked by TASK level code
// 1201 *              and is not used to reschedule tasks from ISRs (see OSIntExit() for ISR rescheduling).
// 1202 *
// 1203 * Arguments  : none
// 1204 *
// 1205 * Returns    : none
// 1206 *
// 1207 * Notes      : 1) This function is INTERNAL to uC/OS-II and your application should not call it.
// 1208 *              2) Rescheduling is prevented when the scheduler is locked (see OS_SchedLock())
// 1209 *********************************************************************************************************
// 1210 */
// 1211 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1212 void  OS_Sched (void)
// 1213 {
OS_Sched:
        PUSH     {R3-R5,LR}
// 1214 #if OS_CRITICAL_METHOD == 3                            /* Allocate storage for CPU status register     */
// 1215     OS_CPU_SR  cpu_sr = 0;
// 1216 #endif
// 1217 
// 1218 
// 1219 
// 1220     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R4,R0
// 1221     if (OSIntNesting == 0) {                           /* Schedule only if all ISRs done and ...       */
// 1222         if (OSLockNesting == 0) {                      /* ... scheduler is not locked                  */
        LDR.N    R5,??DataTable14
        LDRB     R0,[R5, #+0]
        LDRB     R1,[R5, #+1]
        ORRS     R0,R1,R0
        BNE.N    ??OS_Sched_0
// 1223             OS_SchedNew();
        BL       OS_SchedNew
// 1224             if (OSPrioHighRdy != OSPrioCur) {          /* No Ctx Sw if current task is highest rdy     */
        LDRB     R0,[R5, #+3]
        LDRB     R1,[R5, #+2]
        CMP      R0,R1
        BEQ.N    ??OS_Sched_0
// 1225                 OSTCBHighRdy = OSTCBPrioTbl[OSPrioHighRdy];
        LDR.N    R1,??DataTable14_2
        LDR      R0,[R1, R0, LSL #+2]
        STR      R0,[R5, #+28]
// 1226 #if OS_TASK_PROFILE_EN > 0
// 1227                 OSTCBHighRdy->OSTCBCtxSwCtr++;         /* Inc. # of context switches to this task      */
        LDR      R1,[R0, #+36]
        ADDS     R1,R1,#+1
        STR      R1,[R0, #+36]
// 1228 #endif
// 1229                 OSCtxSwCtr++;                          /* Increment context switch counter             */
        LDR      R0,[R5, #+12]
        ADDS     R0,R0,#+1
        STR      R0,[R5, #+12]
// 1230                 OS_TASK_SW();                          /* Perform a context switch                     */
        BL       OSCtxSw
// 1231             }
// 1232         }
// 1233     }
// 1234     OS_EXIT_CRITICAL();
??OS_Sched_0:
        MOV      R0,R4
        POP      {R1,R4,R5,LR}
        B.W      OS_CPU_SR_Restore
// 1235 }
// 1236 
// 1237 
// 1238 /*
// 1239 *********************************************************************************************************
// 1240 *                              FIND HIGHEST PRIORITY TASK READY TO RUN
// 1241 *
// 1242 * Description: This function is called by other uC/OS-II services to determine the highest priority task
// 1243 *              that is ready to run.  The global variable 'OSPrioHighRdy' is changed accordingly.
// 1244 *
// 1245 * Arguments  : none
// 1246 *
// 1247 * Returns    : none
// 1248 *
// 1249 * Notes      : 1) This function is INTERNAL to uC/OS-II and your application should not call it.
// 1250 *              2) Interrupts are assumed to be disabled when this function is called.
// 1251 *********************************************************************************************************
// 1252 */
// 1253 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1254 static  void  OS_SchedNew (void)
// 1255 {
// 1256 #if OS_LOWEST_PRIO <= 63                         /* See if we support up to 64 tasks                   */
// 1257     INT8U   y;
// 1258 
// 1259 
// 1260     y             = OSUnMapTbl[OSRdyGrp];
OS_SchedNew:
        LDR.N    R0,??DataTable14
        ADR.W    R1,OSUnMapTbl
        LDRB     R2,[R0, #+4]
        LDRB     R2,[R2, R1]
// 1261     OSPrioHighRdy = (INT8U)((y << 3) + OSUnMapTbl[OSRdyTbl[y]]);
        ADDS     R3,R2,R0
        LDRB     R3,[R3, #+8]
        LDRB     R1,[R3, R1]
        ADD      R1,R1,R2, LSL #+3
        STRB     R1,[R0, #+3]
// 1262 #else                                            /* We support up to 256 tasks                         */
// 1263     INT8U   y;
// 1264     INT16U *ptbl;
// 1265 
// 1266 
// 1267     if ((OSRdyGrp & 0xFF) != 0) {
// 1268         y = OSUnMapTbl[OSRdyGrp & 0xFF];
// 1269     } else {
// 1270         y = OSUnMapTbl[(OSRdyGrp >> 8) & 0xFF] + 8;
// 1271     }
// 1272     ptbl = &OSRdyTbl[y];
// 1273     if ((*ptbl & 0xFF) != 0) {
// 1274         OSPrioHighRdy = (INT8U)((y << 4) + OSUnMapTbl[(*ptbl & 0xFF)]);
// 1275     } else {
// 1276         OSPrioHighRdy = (INT8U)((y << 4) + OSUnMapTbl[(*ptbl >> 8) & 0xFF] + 8);
// 1277     }
// 1278 #endif
// 1279 }
        BX       LR               ;; return
// 1280 
// 1281 /*$PAGE*/
// 1282 /*
// 1283 *********************************************************************************************************
// 1284 *                                        COPY AN ASCII STRING
// 1285 *
// 1286 * Description: This function is called by other uC/OS-II services to copy an ASCII string from a 'source'
// 1287 *              string to a 'destination' string.
// 1288 *
// 1289 * Arguments  : pdest    is a pointer to the string that will be receiving the copy.  Note that there MUST
// 1290 *                       be sufficient space in the destination storage area to receive this string.
// 1291 *
// 1292 *              psrc     is a pointer to the source string.  The source string MUST NOT be greater than
// 1293 *                       254 characters.
// 1294 *
// 1295 * Returns    : The size of the string (excluding the NUL terminating character)
// 1296 *
// 1297 * Notes      : 1) This function is INTERNAL to uC/OS-II and your application should not call it.
// 1298 *********************************************************************************************************
// 1299 */
// 1300 
// 1301 #if (OS_EVENT_NAME_SIZE > 1) || (OS_FLAG_NAME_SIZE > 1) || (OS_MEM_NAME_SIZE > 1) || (OS_TASK_NAME_SIZE > 1) || (OS_TMR_CFG_NAME_SIZE > 1)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1302 INT8U  OS_StrCopy (INT8U *pdest, INT8U *psrc)
// 1303 {
// 1304     INT8U  len;
// 1305 
// 1306 
// 1307     len = 0;
OS_StrCopy:
        MOVS     R2,#+0
        B.N      ??OS_StrCopy_0
// 1308     while (*psrc != OS_ASCII_NUL) {
// 1309         *pdest++ = *psrc++;
??OS_StrCopy_1:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
// 1310         len++;
        ADDS     R2,R2,#+1
// 1311     }
??OS_StrCopy_0:
        LDRB     R3,[R1, #+0]
        CMP      R3,#+0
        BNE.N    ??OS_StrCopy_1
// 1312     *pdest = OS_ASCII_NUL;
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
// 1313     return (len);
        UXTB     R0,R2
        BX       LR               ;; return
// 1314 }
// 1315 #endif
// 1316 /*$PAGE*/
// 1317 /*
// 1318 *********************************************************************************************************
// 1319 *                                DETERMINE THE LENGTH OF AN ASCII STRING
// 1320 *
// 1321 * Description: This function is called by other uC/OS-II services to determine the size of an ASCII string
// 1322 *              (excluding the NUL character).
// 1323 *
// 1324 * Arguments  : psrc     is a pointer to the string for which we need to know the size.
// 1325 *
// 1326 * Returns    : The size of the string (excluding the NUL terminating character)
// 1327 *
// 1328 * Notes      : 1) This function is INTERNAL to uC/OS-II and your application should not call it.
// 1329 *              2) The string to check must be less than 255 characters long.
// 1330 *********************************************************************************************************
// 1331 */
// 1332 
// 1333 #if (OS_EVENT_NAME_SIZE > 1) || (OS_FLAG_NAME_SIZE > 1) || (OS_MEM_NAME_SIZE > 1) || (OS_TASK_NAME_SIZE > 1) || (OS_TMR_CFG_NAME_SIZE > 1)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1334 INT8U  OS_StrLen (INT8U *psrc)
// 1335 {
// 1336     INT8U  len;
// 1337 
// 1338 
// 1339     len = 0;
OS_StrLen:
        MOVS     R1,#+0
// 1340     while (*psrc != OS_ASCII_NUL) {
        LDRB     R2,[R0, #+0]
        CBZ.N    R2,??OS_StrLen_0
// 1341         psrc++;
// 1342         len++;
??OS_StrLen_1:
        ADDS     R1,R1,#+1
        LDRB     R2,[R0, #+1]!
        CMP      R2,#+0
        BNE.N    ??OS_StrLen_1
// 1343     }
// 1344     return (len);
??OS_StrLen_0:
        UXTB     R0,R1
        BX       LR               ;; return
// 1345 }
// 1346 #endif
// 1347 /*$PAGE*/
// 1348 /*
// 1349 *********************************************************************************************************
// 1350 *                                              IDLE TASK
// 1351 *
// 1352 * Description: This task is internal to uC/OS-II and executes whenever no other higher priority tasks
// 1353 *              executes because they are ALL waiting for event(s) to occur.
// 1354 *
// 1355 * Arguments  : none
// 1356 *
// 1357 * Returns    : none
// 1358 *
// 1359 * Note(s)    : 1) OSTaskIdleHook() is called after the critical section to ensure that interrupts will be
// 1360 *                 enabled for at least a few instructions.  On some processors (ex. Philips XA), enabling
// 1361 *                 and then disabling interrupts didn't allow the processor enough time to have interrupts
// 1362 *                 enabled before they were disabled again.  uC/OS-II would thus never recognize
// 1363 *                 interrupts.
// 1364 *              2) This hook has been added to allow you to do such things as STOP the CPU to conserve
// 1365 *                 power.
// 1366 *********************************************************************************************************
// 1367 */
// 1368 extern void LedDisplay(void);
// 1369 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1370 void  OS_TaskIdle (void *p_arg)
// 1371 {
OS_TaskIdle:
        PUSH     {R4,LR}
// 1372 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
// 1373     OS_CPU_SR  cpu_sr = 0;
// 1374 #endif
// 1375 
// 1376 
// 1377 
// 1378     (void)p_arg;                                 /* Prevent compiler warning for not using 'parg'      */
// 1379     for (;;) {
// 1380         OS_ENTER_CRITICAL();
??OS_TaskIdle_0:
        BL       OS_CPU_SR_Save
        MOV      R4,R0
// 1381         OSIdleCtr++;
        LDR.N    R0,??DataTable14
        LDR      R1,[R0, #+16]
        ADDS     R1,R1,#+1
        STR      R1,[R0, #+16]
// 1382 		LedDisplay();
        BL       LedDisplay
// 1383         OS_EXIT_CRITICAL();
        MOV      R0,R4
        BL       OS_CPU_SR_Restore
// 1384         OSTaskIdleHook();                        /* Call user definable HOOK                           */
        BL       OSTaskIdleHook
        B.N      ??OS_TaskIdle_0
// 1385     }
// 1386 }
// 1387 /*$PAGE*/
// 1388 /*
// 1389 *********************************************************************************************************
// 1390 *                                            STATISTICS TASK
// 1391 *
// 1392 * Description: This task is internal to uC/OS-II and is used to compute some statistics about the
// 1393 *              multitasking environment.  Specifically, OS_TaskStat() computes the CPU usage.
// 1394 *              CPU usage is determined by:
// 1395 *
// 1396 *                                          OSIdleCtr
// 1397 *                 OSCPUUsage = 100 * (1 - ------------)     (units are in %)
// 1398 *                                         OSIdleCtrMax
// 1399 *
// 1400 * Arguments  : parg     this pointer is not used at this time.
// 1401 *
// 1402 * Returns    : none
// 1403 *
// 1404 * Notes      : 1) This task runs at a priority level higher than the idle task.  In fact, it runs at the
// 1405 *                 next higher priority, OS_TASK_IDLE_PRIO-1.
// 1406 *              2) You can disable this task by setting the configuration #define OS_TASK_STAT_EN to 0.
// 1407 *              3) You MUST have at least a delay of 2/10 seconds to allow for the system to establish the
// 1408 *                 maximum value for the idle counter.
// 1409 *********************************************************************************************************
// 1410 */
// 1411 
// 1412 #if OS_TASK_STAT_EN > 0
// 1413 void  OS_TaskStat (void *p_arg)
// 1414 {
// 1415     INT32U     run;
// 1416     INT32U     max;
// 1417     INT8S      usage;
// 1418 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
// 1419     OS_CPU_SR  cpu_sr = 0;
// 1420 #endif
// 1421 
// 1422 
// 1423 
// 1424     p_arg = p_arg;                               /* Prevent compiler warning for not using 'parg'      */
// 1425     while (OSStatRdy == OS_FALSE) {
// 1426         OSTimeDly(2 * OS_TICKS_PER_SEC / 10);    /* Wait until statistic task is ready                 */
// 1427     }
// 1428     max = OSIdleCtrMax / 100L;
// 1429     for (;;) {
// 1430         OS_ENTER_CRITICAL();
// 1431         OSIdleCtrRun = OSIdleCtr;                /* Obtain the of the idle counter for the past second */
// 1432         run          = OSIdleCtr;
// 1433         OSIdleCtr    = 0L;                       /* Reset the idle counter for the next second         */
// 1434         OS_EXIT_CRITICAL();
// 1435         if (max > 0L) {
// 1436             usage = (INT8S)(100L - run / max);
// 1437             if (usage >= 0) {                    /* Make sure we don't have a negative percentage      */
// 1438                 OSCPUUsage = usage;
// 1439             } else {
// 1440                 OSCPUUsage = 0;
// 1441             }
// 1442         } else {
// 1443             OSCPUUsage = 0;
// 1444             max        = OSIdleCtrMax / 100L;
// 1445         }
// 1446         OSTaskStatHook();                        /* Invoke user definable hook                         */
// 1447 #if (OS_TASK_STAT_STK_CHK_EN > 0) && (OS_TASK_CREATE_EXT_EN > 0)
// 1448         OS_TaskStatStkChk();                     /* Check the stacks for each task                     */
// 1449 #endif
// 1450         OSTimeDly(OS_TICKS_PER_SEC / 10);        /* Accumulate OSIdleCtr for the next 1/10 second      */
// 1451     }
// 1452 }
// 1453 #endif
// 1454 /*$PAGE*/
// 1455 /*
// 1456 *********************************************************************************************************
// 1457 *                                      CHECK ALL TASK STACKS
// 1458 *
// 1459 * Description: This function is called by OS_TaskStat() to check the stacks of each active task.
// 1460 *
// 1461 * Arguments  : none
// 1462 *
// 1463 * Returns    : none
// 1464 *********************************************************************************************************
// 1465 */
// 1466 
// 1467 #if (OS_TASK_STAT_STK_CHK_EN > 0) && (OS_TASK_CREATE_EXT_EN > 0)
// 1468 void  OS_TaskStatStkChk (void)
// 1469 {
// 1470     OS_TCB      *ptcb;
// 1471     OS_STK_DATA  stk_data;
// 1472     INT8U        err;
// 1473     INT8U        prio;
// 1474 
// 1475 
// 1476     for (prio = 0; prio <= OS_TASK_IDLE_PRIO; prio++) {
// 1477         err = OSTaskStkChk(prio, &stk_data);
// 1478         if (err == OS_ERR_NONE) {
// 1479             ptcb = OSTCBPrioTbl[prio];
// 1480             if (ptcb != (OS_TCB *)0) {                               /* Make sure task 'ptcb' is ...   */
// 1481                 if (ptcb != OS_TCB_RESERVED) {                       /* ... still valid.               */
// 1482 #if OS_TASK_PROFILE_EN > 0
// 1483                     #if OS_STK_GROWTH == 1
// 1484                     ptcb->OSTCBStkBase = ptcb->OSTCBStkBottom + ptcb->OSTCBStkSize;
// 1485                     #else
// 1486                     ptcb->OSTCBStkBase = ptcb->OSTCBStkBottom - ptcb->OSTCBStkSize;
// 1487                     #endif
// 1488                     ptcb->OSTCBStkUsed = stk_data.OSUsed;            /* Store the number of bytes used */
// 1489 #endif
// 1490                 }
// 1491             }
// 1492         }
// 1493     }
// 1494 }
// 1495 #endif
// 1496 /*$PAGE*/
// 1497 /*
// 1498 *********************************************************************************************************
// 1499 *                                            INITIALIZE TCB
// 1500 *
// 1501 * Description: This function is internal to uC/OS-II and is used to initialize a Task Control Block when
// 1502 *              a task is created (see OSTaskCreate() and OSTaskCreateExt()).
// 1503 *
// 1504 * Arguments  : prio          is the priority of the task being created
// 1505 *
// 1506 *              ptos          is a pointer to the task's top-of-stack assuming that the CPU registers
// 1507 *                            have been placed on the stack.  Note that the top-of-stack corresponds to a
// 1508 *                            'high' memory location is OS_STK_GROWTH is set to 1 and a 'low' memory
// 1509 *                            location if OS_STK_GROWTH is set to 0.  Note that stack growth is CPU
// 1510 *                            specific.
// 1511 *
// 1512 *              pbos          is a pointer to the bottom of stack.  A NULL pointer is passed if called by
// 1513 *                            'OSTaskCreate()'.
// 1514 *
// 1515 *              id            is the task's ID (0..65535)
// 1516 *
// 1517 *              stk_size      is the size of the stack (in 'stack units').  If the stack units are INT8Us
// 1518 *                            then, 'stk_size' contains the number of bytes for the stack.  If the stack
// 1519 *                            units are INT32Us then, the stack contains '4 * stk_size' bytes.  The stack
// 1520 *                            units are established by the #define constant OS_STK which is CPU
// 1521 *                            specific.  'stk_size' is 0 if called by 'OSTaskCreate()'.
// 1522 *
// 1523 *              pext          is a pointer to a user supplied memory area that is used to extend the task
// 1524 *                            control block.  This allows you to store the contents of floating-point
// 1525 *                            registers, MMU registers or anything else you could find useful during a
// 1526 *                            context switch.  You can even assign a name to each task and store this name
// 1527 *                            in this TCB extension.  A NULL pointer is passed if called by OSTaskCreate().
// 1528 *
// 1529 *              opt           options as passed to 'OSTaskCreateExt()' or,
// 1530 *                            0 if called from 'OSTaskCreate()'.
// 1531 *
// 1532 * Returns    : OS_ERR_NONE         if the call was successful
// 1533 *              OS_ERR_TASK_NO_MORE_TCB  if there are no more free TCBs to be allocated and thus, the task cannot
// 1534 *                                  be created.
// 1535 *
// 1536 * Note       : This function is INTERNAL to uC/OS-II and your application should not call it.
// 1537 *********************************************************************************************************
// 1538 */
// 1539 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1540 INT8U  OS_TCBInit (INT8U prio, OS_STK *ptos, OS_STK *pbos, INT16U id, INT32U stk_size, void *pext, INT16U opt)
// 1541 {
OS_TCBInit:
        PUSH     {R3-R7,LR}
        MOV      R6,R0
        MOV      R7,R1
// 1542     OS_TCB    *ptcb;
// 1543 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
// 1544     OS_CPU_SR  cpu_sr = 0;
// 1545 #endif
// 1546 
// 1547 
// 1548 
// 1549     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
// 1550     ptcb = OSTCBFreeList;                                  /* Get a free TCB from the free TCB list    */
        LDR.N    R4,??DataTable14
        LDR      R5,[R4, #+24]
// 1551     if (ptcb != (OS_TCB *)0) {
        CMP      R5,#+0
        BEQ.N    ??OS_TCBInit_0
// 1552         OSTCBFreeList        = ptcb->OSTCBNext;            /* Update pointer to free TCB list          */
        LDR      R1,[R5, #+4]
        STR      R1,[R4, #+24]
// 1553         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
// 1554         ptcb->OSTCBStkPtr    = ptos;                       /* Load Stack pointer in TCB                */
        STR      R7,[R5, #+0]
// 1555         ptcb->OSTCBPrio      = prio;                       /* Load task priority into TCB              */
        STRB     R6,[R5, #+30]
// 1556         ptcb->OSTCBStat      = OS_STAT_RDY;                /* Task is ready to run                     */
        MOVS     R0,#+0
        STRB     R0,[R5, #+28]
// 1557         ptcb->OSTCBStatPend  = OS_STAT_PEND_OK;            /* Clear pend status                        */
        STRB     R0,[R5, #+29]
// 1558         ptcb->OSTCBDly       = 0;                          /* Task is not delayed                      */
        STRH     R0,[R5, #+26]
// 1559 
// 1560 #if OS_TASK_CREATE_EXT_EN > 0
// 1561         ptcb->OSTCBExtPtr    = pext;                       /* Store pointer to TCB extension           */
// 1562         ptcb->OSTCBStkSize   = stk_size;                   /* Store stack size                         */
// 1563         ptcb->OSTCBStkBottom = pbos;                       /* Store pointer to bottom of stack         */
// 1564         ptcb->OSTCBOpt       = opt;                        /* Store task options                       */
// 1565         ptcb->OSTCBId        = id;                         /* Store task ID                            */
// 1566 #else
// 1567         pext                 = pext;                       /* Prevent compiler warning if not used     */
// 1568         stk_size             = stk_size;
// 1569         pbos                 = pbos;
// 1570         opt                  = opt;
// 1571         id                   = id;
// 1572 #endif
// 1573 
// 1574 #if OS_TASK_DEL_EN > 0
// 1575         ptcb->OSTCBDelReq    = OS_ERR_NONE;
        STRB     R0,[R5, #+35]
// 1576 #endif
// 1577 
// 1578 #if OS_LOWEST_PRIO <= 63
// 1579         ptcb->OSTCBY         = (INT8U)(prio >> 3);         /* Pre-compute X, Y, BitX and BitY          */
        LSRS     R0,R6,#+3
        STRB     R0,[R5, #+32]
// 1580         ptcb->OSTCBBitY      = (INT8U)(1 << ptcb->OSTCBY);
        MOVS     R1,#+1
        LSL      R0,R1,R0
        STRB     R0,[R5, #+34]
// 1581         ptcb->OSTCBX         = (INT8U)(prio & 0x07);
        AND      R0,R6,#0x7
        STRB     R0,[R5, #+31]
// 1582         ptcb->OSTCBBitX      = (INT8U)(1 << ptcb->OSTCBX);
        LSL      R0,R1,R0
        STRB     R0,[R5, #+33]
// 1583 #else
// 1584         ptcb->OSTCBY         = (INT8U)((prio >> 4) & 0xFF);/* Pre-compute X, Y, BitX and BitY          */
// 1585         ptcb->OSTCBBitY      = (INT16U)(1 << ptcb->OSTCBY);
// 1586         ptcb->OSTCBX         = (INT8U)(prio & 0x0F);
// 1587         ptcb->OSTCBBitX      = (INT16U)(1 << ptcb->OSTCBX);
// 1588 #endif
// 1589 
// 1590 #if OS_EVENT_EN
// 1591         ptcb->OSTCBEventPtr  = (OS_EVENT *)0;              /* Task is not pending on an event          */
        MOVS     R0,#+0
        STR      R0,[R5, #+12]
// 1592 #endif
// 1593 
// 1594 #if (OS_FLAG_EN > 0) && (OS_MAX_FLAGS > 0) && (OS_TASK_DEL_EN > 0)
// 1595         ptcb->OSTCBFlagNode  = (OS_FLAG_NODE *)0;          /* Task is not pending on an event flag     */
        STR      R0,[R5, #+20]
// 1596 #endif
// 1597 
// 1598 #if (OS_MBOX_EN > 0) || ((OS_Q_EN > 0) && (OS_MAX_QS > 0))
// 1599         ptcb->OSTCBMsg       = (void *)0;                  /* No message received                      */
        STR      R0,[R5, #+16]
// 1600 #endif
// 1601 
// 1602 #if OS_TASK_PROFILE_EN > 0
// 1603         ptcb->OSTCBCtxSwCtr    = 0L;                       /* Initialize profiling variables           */
        STR      R0,[R5, #+36]
// 1604         ptcb->OSTCBCyclesStart = 0L;
        STR      R0,[R5, #+44]
// 1605         ptcb->OSTCBCyclesTot   = 0L;
        STR      R0,[R5, #+40]
// 1606         ptcb->OSTCBStkBase     = (OS_STK *)0;
        STR      R0,[R5, #+48]
// 1607         ptcb->OSTCBStkUsed     = 0L;
        STR      R0,[R5, #+52]
// 1608 #endif
// 1609 
// 1610 #if OS_TASK_NAME_SIZE > 1
// 1611         ptcb->OSTCBTaskName[0] = '?';                      /* Unknown name at task creation            */
// 1612         ptcb->OSTCBTaskName[1] = OS_ASCII_NUL;
// 1613 #endif
// 1614 
// 1615         OSTCBInitHook(ptcb);
        MOV      R0,R5
        BL       OSTCBInitHook
// 1616 
// 1617         OSTaskCreateHook(ptcb);                            /* Call user defined hook                   */
        MOV      R0,R5
        BL       OSTaskCreateHook
// 1618 
// 1619         OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
// 1620         OSTCBPrioTbl[prio] = ptcb;
        LDR.N    R1,??DataTable14_2
        STR      R5,[R1, R6, LSL #+2]
// 1621         ptcb->OSTCBNext    = OSTCBList;                    /* Link into TCB chain                      */
        LDR      R1,[R4, #+32]
        STR      R1,[R5, #+4]
// 1622         ptcb->OSTCBPrev    = (OS_TCB *)0;
        MOVS     R1,#+0
        STR      R1,[R5, #+8]
// 1623         if (OSTCBList != (OS_TCB *)0) {
        LDR      R1,[R4, #+32]
        CBZ.N    R1,??OS_TCBInit_1
// 1624             OSTCBList->OSTCBPrev = ptcb;
        STR      R5,[R1, #+8]
// 1625         }
// 1626         OSTCBList               = ptcb;
??OS_TCBInit_1:
        STR      R5,[R4, #+32]
// 1627         OSRdyGrp               |= ptcb->OSTCBBitY;         /* Make task ready to run                   */
        LDRB     R1,[R4, #+4]
        LDRB     R2,[R5, #+34]
        ORRS     R1,R2,R1
        STRB     R1,[R4, #+4]
// 1628         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
        LDRB     R1,[R5, #+32]
        ADDS     R1,R1,R4
        LDRB     R2,[R1, #+8]
        LDRB     R3,[R5, #+33]
        ORRS     R2,R3,R2
        STRB     R2,[R1, #+8]
// 1629         OSTaskCtr++;                                       /* Increment the #tasks counter             */
        LDRB     R1,[R4, #+6]
        ADDS     R1,R1,#+1
        STRB     R1,[R4, #+6]
// 1630         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
// 1631         return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}
// 1632     }
// 1633     OS_EXIT_CRITICAL();
??OS_TCBInit_0:
        BL       OS_CPU_SR_Restore
// 1634     return (OS_ERR_TASK_NO_MORE_TCB);
        MOVS     R0,#+66
        POP      {R1,R4-R7,PC}    ;; return
// 1635 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_1:
        DC32     OSEventTbl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_2:
        DC32     OSTCBPrioTbl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_3:
        DC32     OS_TaskIdle

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
OSUnMapTbl:
        DC8 0, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1
        DC8 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0
        DC8 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2
        DC8 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0
        DC8 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1
        DC8 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 7, 0, 1, 0, 2, 0, 1, 0, 3, 0
        DC8 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5
        DC8 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0
        DC8 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1
        DC8 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0
        DC8 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2
        DC8 0, 1, 0

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
// 1 572 bytes in section .text
// 2 384 bytes in section iram
// 
// 1 572 bytes of CODE memory
// 2 384 bytes of DATA memory
//
//Errors: none
//Warnings: none
