///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:42 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\os_sem.c                                           /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\os_sem.c -D _MIMO_Type -lcN                        /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\os_se /
//                    m.s                                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_sem

        EXTERN OSEventFreeList
        EXTERN OSIntNesting
        EXTERN OSLockNesting
        EXTERN OSTCBCur
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_EventTOAbort
        EXTERN OS_EventTaskRdy
        EXTERN OS_EventTaskWait
        EXTERN OS_EventWaitListInit
        EXTERN OS_Sched

        PUBLIC OSSemAccept
        PUBLIC OSSemCreate
        PUBLIC OSSemDel
        PUBLIC OSSemPend
        PUBLIC OSSemPendAbort
        PUBLIC OSSemPost
        PUBLIC OSSemQuery
        PUBLIC OSSemSet

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Source\os_sem.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                          SEMAPHORE MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_SEM.C
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
//   25 
//   26 #include <ucos_ii.h>
//   27 #endif
//   28 
//   29 #if OS_SEM_EN > 0
//   30 /*$PAGE*/
//   31 /*
//   32 *********************************************************************************************************
//   33 *                                           ACCEPT SEMAPHORE
//   34 *
//   35 * Description: This function checks the semaphore to see if a resource is available or, if an event
//   36 *              occurred.  Unlike OSSemPend(), OSSemAccept() does not suspend the calling task if the
//   37 *              resource is not available or the event did not occur.
//   38 *
//   39 * Arguments  : pevent     is a pointer to the event control block
//   40 *
//   41 * Returns    : >  0       if the resource is available or the event did not occur the semaphore is
//   42 *                         decremented to obtain the resource.
//   43 *              == 0       if the resource is not available or the event did not occur or,
//   44 *                         if 'pevent' is a NULL pointer or,
//   45 *                         if you didn't pass a pointer to a semaphore
//   46 *********************************************************************************************************
//   47 */
//   48 
//   49 #if OS_SEM_ACCEPT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   50 INT16U  OSSemAccept (OS_EVENT *pevent)
//   51 {
OSSemAccept:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   52     INT16U     cnt;
//   53 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//   54     OS_CPU_SR  cpu_sr = 0;
//   55 #endif
//   56 
//   57 
//   58 
//   59 #if OS_ARG_CHK_EN > 0
//   60     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//   61         return (0);
//   62     }
//   63 #endif
//   64     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+3
        BEQ.N    ??OSSemAccept_0
//   65         return (0);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//   66     }
//   67     OS_ENTER_CRITICAL();
??OSSemAccept_0:
        BL       OS_CPU_SR_Save
//   68     cnt = pevent->OSEventCnt;
        LDRH     R1,[R4, #+8]
        MOVS     R5,R1
//   69     if (cnt > 0) {                                    /* See if resource is available                  */
        BEQ.N    ??OSSemAccept_1
//   70         pevent->OSEventCnt--;                         /* Yes, decrement semaphore and notify caller    */
        SUBS     R1,R1,#+1
        STRH     R1,[R4, #+8]
//   71     }
//   72     OS_EXIT_CRITICAL();
??OSSemAccept_1:
        BL       OS_CPU_SR_Restore
//   73     return (cnt);                                     /* Return semaphore count                        */
        MOV      R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//   74 }
//   75 #endif
//   76 
//   77 /*$PAGE*/
//   78 /*
//   79 *********************************************************************************************************
//   80 *                                           CREATE A SEMAPHORE
//   81 *
//   82 * Description: This function creates a semaphore.
//   83 *
//   84 * Arguments  : cnt           is the initial value for the semaphore.  If the value is 0, no resource is
//   85 *                            available (or no event has occurred).  You initialize the semaphore to a
//   86 *                            non-zero value to specify how many resources are available (e.g. if you have
//   87 *                            10 resources, you would initialize the semaphore to 10).
//   88 *
//   89 * Returns    : != (void *)0  is a pointer to the event control block (OS_EVENT) associated with the
//   90 *                            created semaphore
//   91 *              == (void *)0  if no event control blocks were available
//   92 *********************************************************************************************************
//   93 */
//   94 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   95 OS_EVENT  *OSSemCreate (INT16U cnt)
//   96 {
OSSemCreate:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   97     OS_EVENT  *pevent;
//   98 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//   99     OS_CPU_SR  cpu_sr = 0;
//  100 #endif
//  101 
//  102 
//  103 
//  104     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
        LDR.N    R0,??DataTable5  ;; OSIntNesting
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSSemCreate_0
//  105         return ((OS_EVENT *)0);                            /* ... can't CREATE from an ISR             */
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//  106     }
//  107     OS_ENTER_CRITICAL();
??OSSemCreate_0:
        BL       OS_CPU_SR_Save
//  108     pevent = OSEventFreeList;                              /* Get next free event control block        */
        LDR.N    R1,??DataTable4  ;; OSEventFreeList
        LDR      R2,[R1, #+0]
        MOVS     R5,R2
//  109     if (OSEventFreeList != (OS_EVENT *)0) {                /* See if pool of free ECB pool was empty   */
        BEQ.N    ??OSSemCreate_1
//  110         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
        LDR      R2,[R2, #+4]
        STR      R2,[R1, #+0]
//  111     }
//  112     OS_EXIT_CRITICAL();
??OSSemCreate_1:
        BL       OS_CPU_SR_Restore
//  113     if (pevent != (OS_EVENT *)0) {                         /* Get an event control block               */
        CMP      R5,#+0
        BEQ.N    ??OSSemCreate_2
//  114         pevent->OSEventType    = OS_EVENT_TYPE_SEM;
        MOVS     R0,#+3
        STRB     R0,[R5, #+0]
//  115         pevent->OSEventCnt     = cnt;                      /* Set semaphore value                      */
        STRH     R4,[R5, #+8]
//  116         pevent->OSEventPtr     = (void *)0;                /* Unlink from ECB free list                */
        MOVS     R0,#+0
        STR      R0,[R5, #+4]
//  117 #if OS_EVENT_NAME_SIZE > 1
//  118         pevent->OSEventName[0] = '?';                      /* Unknown name                             */
//  119         pevent->OSEventName[1] = OS_ASCII_NUL;
//  120 #endif
//  121         OS_EventWaitListInit(pevent);                      /* Initialize to 'nobody waiting' on sem.   */
        MOV      R0,R5
        BL       OS_EventWaitListInit
//  122     }
//  123     return (pevent);
??OSSemCreate_2:
        MOV      R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//  124 }
//  125 
//  126 /*$PAGE*/
//  127 /*
//  128 *********************************************************************************************************
//  129 *                                         DELETE A SEMAPHORE
//  130 *
//  131 * Description: This function deletes a semaphore and readies all tasks pending on the semaphore.
//  132 *
//  133 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  134 *                            semaphore.
//  135 *
//  136 *              opt           determines delete options as follows:
//  137 *                            opt == OS_DEL_NO_PEND   Delete semaphore ONLY if no task pending
//  138 *                            opt == OS_DEL_ALWAYS    Deletes the semaphore even if tasks are waiting.
//  139 *                                                    In this case, all the tasks pending will be readied.
//  140 *
//  141 *              perr          is a pointer to an error code that can contain one of the following values:
//  142 *                            OS_ERR_NONE             The call was successful and the semaphore was deleted
//  143 *                            OS_ERR_DEL_ISR          If you attempted to delete the semaphore from an ISR
//  144 *                            OS_ERR_INVALID_OPT      An invalid option was specified
//  145 *                            OS_ERR_TASK_WAITING     One or more tasks were waiting on the semaphore
//  146 *                            OS_ERR_EVENT_TYPE       If you didn't pass a pointer to a semaphore
//  147 *                            OS_ERR_PEVENT_NULL      If 'pevent' is a NULL pointer.
//  148 *
//  149 * Returns    : pevent        upon error
//  150 *              (OS_EVENT *)0 if the semaphore was successfully deleted.
//  151 *
//  152 * Note(s)    : 1) This function must be used with care.  Tasks that would normally expect the presence of
//  153 *                 the semaphore MUST check the return code of OSSemPend().
//  154 *              2) OSSemAccept() callers will not know that the intended semaphore has been deleted unless
//  155 *                 they check 'pevent' to see that it's a NULL pointer.
//  156 *              3) This call can potentially disable interrupts for a long time.  The interrupt disable
//  157 *                 time is directly proportional to the number of tasks waiting on the semaphore.
//  158 *              4) Because ALL tasks pending on the semaphore will be readied, you MUST be careful in
//  159 *                 applications where the semaphore is used for mutual exclusion because the resource(s)
//  160 *                 will no longer be guarded by the semaphore.
//  161 *********************************************************************************************************
//  162 */
//  163 
//  164 #if OS_SEM_DEL_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  165 OS_EVENT  *OSSemDel (OS_EVENT *pevent, INT8U opt, INT8U *perr)
//  166 {
OSSemDel:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R6,R1
        MOV      R5,R2
//  167     BOOLEAN    tasks_waiting;
//  168     OS_EVENT  *pevent_return;
//  169 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  170     OS_CPU_SR  cpu_sr = 0;
//  171 #endif
//  172 
//  173 
//  174 
//  175 #if OS_ARG_CHK_EN > 0
//  176     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  177         return (pevent);
//  178     }
//  179     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  180         *perr = OS_ERR_PEVENT_NULL;
//  181         return (pevent);
//  182     }
//  183 #endif
//  184     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {        /* Validate event block type                */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+3
        BEQ.N    ??OSSemDel_0
//  185         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
??OSSemDel_1:
        STRB     R0,[R5, #+0]
//  186         return (pevent);
        MOV      R0,R4
        POP      {R4-R8,PC}
//  187     }
//  188     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
??OSSemDel_0:
        LDR.N    R0,??DataTable5  ;; OSIntNesting
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSSemDel_2
//  189         *perr = OS_ERR_DEL_ISR;                             /* ... can't DELETE from an ISR             */
        MOVS     R0,#+15
        B.N      ??OSSemDel_1
//  190         return (pevent);
//  191     }
//  192     OS_ENTER_CRITICAL();
??OSSemDel_2:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  193     if (pevent->OSEventGrp != 0) {                         /* See if any tasks waiting on semaphore    */
        LDRB     R0,[R4, #+10]
        SUBS     R7,R0,#+1
        SBCS     R7,R7,R7
        MVNS     R7,R7
        LSRS     R7,R7,#+31
//  194         tasks_waiting = OS_TRUE;                           /* Yes                                      */
//  195     } else {
//  196         tasks_waiting = OS_FALSE;                          /* No                                       */
//  197     }
//  198     switch (opt) {
        CBZ      R6,??OSSemDel_3
        CMP      R6,#+1
        BEQ.N    ??OSSemDel_4
        B.N      ??OSSemDel_5
//  199         case OS_DEL_NO_PEND:                               /* Delete semaphore only if no task waiting */
//  200              if (tasks_waiting == OS_FALSE) {
??OSSemDel_3:
        CBNZ     R7,??OSSemDel_6
//  201 #if OS_EVENT_NAME_SIZE > 1
//  202                  pevent->OSEventName[0] = '?';             /* Unknown name                             */
//  203                  pevent->OSEventName[1] = OS_ASCII_NUL;
//  204 #endif
//  205                  pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  206                  pevent->OSEventPtr     = OSEventFreeList; /* Return Event Control Block to free list  */
        LDR.N    R0,??DataTable4  ;; OSEventFreeList
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  207                  pevent->OSEventCnt     = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  208                  OSEventFreeList        = pevent;          /* Get next free event control block        */
        STR      R4,[R0, #+0]
//  209                  OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  210                  *perr                  = OS_ERR_NONE;
??OSSemDel_7:
        MOVS     R1,#+0
//  211                  pevent_return          = (OS_EVENT *)0;   /* Semaphore has been deleted               */
        MOVS     R0,#+0
        B.N      ??OSSemDel_8
//  212              } else {
//  213                  OS_EXIT_CRITICAL();
??OSSemDel_6:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  214                  *perr                  = OS_ERR_TASK_WAITING;
        MOVS     R1,#+73
//  215                  pevent_return          = pevent;
        B.N      ??OSSemDel_9
//  216              }
//  217              break;
//  218 
//  219         case OS_DEL_ALWAYS:                                /* Always delete the semaphore              */
//  220              while (pevent->OSEventGrp != 0) {             /* Ready ALL tasks waiting for semaphore    */
??OSSemDel_4:
        CBZ      R0,??OSSemDel_10
//  221                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_OK);
??OSSemDel_11:
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
        LDRB     R0,[R4, #+10]
        CMP      R0,#+0
        BNE.N    ??OSSemDel_11
//  222              }
//  223 #if OS_EVENT_NAME_SIZE > 1
//  224              pevent->OSEventName[0] = '?';                 /* Unknown name                             */
//  225              pevent->OSEventName[1] = OS_ASCII_NUL;
//  226 #endif
//  227              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
??OSSemDel_10:
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  228              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
        LDR.N    R0,??DataTable4  ;; OSEventFreeList
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  229              pevent->OSEventCnt     = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  230              OSEventFreeList        = pevent;              /* Get next free event control block        */
        STR      R4,[R0, #+0]
//  231              OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  232              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
        CMP      R7,#+1
        BNE.N    ??OSSemDel_7
//  233                  OS_Sched();                               /* Find highest priority task ready to run  */
        BL       OS_Sched
//  234              }
//  235              *perr                  = OS_ERR_NONE;
        B.N      ??OSSemDel_7
//  236              pevent_return          = (OS_EVENT *)0;       /* Semaphore has been deleted               */
//  237              break;
//  238 
//  239         default:
//  240              OS_EXIT_CRITICAL();
??OSSemDel_5:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  241              *perr                  = OS_ERR_INVALID_OPT;
        MOVS     R1,#+7
//  242              pevent_return          = pevent;
??OSSemDel_9:
        MOV      R0,R4
??OSSemDel_8:
        STRB     R1,[R5, #+0]
//  243              break;
//  244     }
//  245     return (pevent_return);
        POP      {R4-R8,PC}       ;; return
//  246 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     OSEventFreeList
//  247 #endif
//  248 
//  249 /*$PAGE*/
//  250 /*
//  251 *********************************************************************************************************
//  252 *                                           PEND ON SEMAPHORE
//  253 *
//  254 * Description: This function waits for a semaphore.
//  255 *
//  256 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  257 *                            semaphore.
//  258 *
//  259 *              timeout       is an optional timeout period (in clock ticks).  If non-zero, your task will
//  260 *                            wait for the resource up to the amount of time specified by this argument.
//  261 *                            If you specify 0, however, your task will wait forever at the specified
//  262 *                            semaphore or, until the resource becomes available (or the event occurs).
//  263 *
//  264 *              perr          is a pointer to where an error message will be deposited.  Possible error
//  265 *                            messages are:
//  266 *
//  267 *                            OS_ERR_NONE         The call was successful and your task owns the resource
//  268 *                                                or, the event you are waiting for occurred.
//  269 *                            OS_ERR_TIMEOUT      The semaphore was not received within the specified
//  270 *                                                'timeout'.
//  271 *                            OS_ERR_PEND_ABORT   The wait on the semaphore was aborted.
//  272 *                            OS_ERR_EVENT_TYPE   If you didn't pass a pointer to a semaphore.
//  273 *                            OS_ERR_PEND_ISR     If you called this function from an ISR and the result
//  274 *                                                would lead to a suspension.
//  275 *                            OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer.
//  276 *                            OS_ERR_PEND_LOCKED  If you called this function when the scheduler is locked
//  277 *
//  278 * Returns    : none
//  279 *********************************************************************************************************
//  280 */
//  281 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  282 void  OSSemPend (OS_EVENT *pevent, INT16U timeout, INT8U *perr)
//  283 {
OSSemPend:
        PUSH     {R4-R8,LR}
        MOV      R6,R0
        MOV      R4,R1
        MOV      R5,R2
//  284     INT8U      pend_stat;
//  285 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  286     OS_CPU_SR  cpu_sr = 0;
//  287 #endif
//  288 
//  289 
//  290 
//  291 #if OS_ARG_CHK_EN > 0
//  292     if (perr == (INT8U *)0) {                         /* Validate 'perr'                               */
//  293         return;
//  294     }
//  295     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  296         *perr = OS_ERR_PEVENT_NULL;
//  297         return;
//  298     }
//  299 #endif
//  300     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
        LDRB     R0,[R6, #+0]
        CMP      R0,#+3
        BEQ.N    ??OSSemPend_0
//  301         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        B.N      ??OSSemPend_1
//  302         return;
//  303     }
//  304     if (OSIntNesting > 0) {                           /* See if called from ISR ...                    */
??OSSemPend_0:
        LDR.N    R0,??DataTable5  ;; OSIntNesting
        LDRB     R0,[R0, #+0]
        CBZ      R0,??OSSemPend_2
//  305         *perr = OS_ERR_PEND_ISR;                      /* ... can't PEND from an ISR                    */
        MOVS     R0,#+2
        B.N      ??OSSemPend_1
//  306         return;
//  307     }
//  308     if (OSLockNesting > 0) {                          /* See if called with scheduler locked ...       */
??OSSemPend_2:
        LDR.N    R0,??Subroutine0_0  ;; OSLockNesting
        LDRB     R0,[R0, #+0]
        CBZ      R0,??OSSemPend_3
//  309         *perr = OS_ERR_PEND_LOCKED;                   /* ... can't PEND when locked                    */
        MOVS     R0,#+13
        B.N      ??OSSemPend_1
//  310         return;
//  311     }
//  312     OS_ENTER_CRITICAL();
??OSSemPend_3:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  313     if (pevent->OSEventCnt > 0) {                     /* If sem. is positive, resource available ...   */
        LDRH     R0,[R6, #+8]
        CBZ      R0,??OSSemPend_4
//  314         pevent->OSEventCnt--;                         /* ... decrement semaphore only if positive.     */
        SUBS     R0,R0,#+1
        STRH     R0,[R6, #+8]
//  315         OS_EXIT_CRITICAL();
        B.N      ??OSSemPend_5
//  316         *perr = OS_ERR_NONE;
//  317         return;
//  318     }
//  319                                                       /* Otherwise, must wait until event occurs       */
//  320     OSTCBCur->OSTCBStat     |= OS_STAT_SEM;           /* Resource not available, pend on semaphore     */
??OSSemPend_4:
        LDR.N    R7,??Subroutine0_0+0x4  ;; OSTCBCur
        LDR      R0,[R7, #+0]
        LDRB     R1,[R0, #+28]
        ORR      R1,R1,#0x1
        STRB     R1,[R0, #+28]
//  321     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
        LDR      R0,[R7, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+29]
//  322     OSTCBCur->OSTCBDly       = timeout;               /* Store pend timeout in TCB                     */
        LDR      R0,[R7, #+0]
        STRH     R4,[R0, #+26]
//  323     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
        MOV      R0,R6
        BL       OS_EventTaskWait
//  324     OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  325     OS_Sched();                                       /* Find next highest priority task ready         */
        BL       OS_Sched
//  326     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  327     if (OSTCBCur->OSTCBStatPend != OS_STAT_PEND_OK) { /* See if we timed-out or aborted                */
        LDR      R0,[R7, #+0]
        LDRB     R4,[R0, #+29]
        CBZ      R4,??OSSemPend_6
//  328         pend_stat = OSTCBCur->OSTCBStatPend;
//  329         OS_EventTOAbort(pevent);
        MOV      R0,R6
        BL       OS_EventTOAbort
//  330         OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  331         switch (pend_stat) {
        CMP      R4,#+2
        BEQ.N    ??OSSemPend_7
//  332             case OS_STAT_PEND_TO:
//  333             default:
//  334                  *perr = OS_ERR_TIMEOUT;              /* Indicate that didn't get event within TO      */
        MOVS     R0,#+10
        B.N      ??OSSemPend_1
//  335                  break;
//  336 
//  337             case OS_STAT_PEND_ABORT:
//  338                  *perr = OS_ERR_PEND_ABORT;           /* Indicate that we aborted                      */
??OSSemPend_7:
        MOVS     R0,#+14
        B.N      ??OSSemPend_1
//  339                  break;
//  340         }
//  341         return;
//  342     }
//  343     OSTCBCur->OSTCBEventPtr = (OS_EVENT *)0;
??OSSemPend_6:
        MOVS     R1,#+0
        STR      R1,[R0, #+12]
//  344     OS_EXIT_CRITICAL();
??OSSemPend_5:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  345     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
??OSSemPend_1:
        Nop      
        REQUIRE ?Subroutine0
        ;; // Fall through to label ?Subroutine0
//  346 }

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine0:
        STRB     R0,[R5, #+0]
        POP      {R4-R8,PC}       ;; return
        Nop      
        DATA
??Subroutine0_0:
        DC32     OSLockNesting
        DC32     OSTCBCur

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     OSIntNesting
//  347 
//  348 /*$PAGE*/
//  349 /*
//  350 *********************************************************************************************************
//  351 *                                      ABORT WAITING ON A SEMAPHORE
//  352 *
//  353 * Description: This function aborts & readies any tasks currently waiting on a semaphore.  This function 
//  354 *              should be used to fault-abort the wait on the semaphore, rather than to normally signal
//  355 *              the semaphore via OSSemPost().
//  356 *
//  357 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  358 *                            semaphore.
//  359 *
//  360 *              opt           determines the type of ABORT performed:
//  361 *                            OS_PEND_OPT_NONE         ABORT wait for a single task (HPT) waiting on the
//  362 *                                                     semaphore
//  363 *                            OS_PEND_OPT_BROADCAST    ABORT wait for ALL tasks that are  waiting on the
//  364 *                                                     semaphore
//  365 *
//  366 *              perr          is a pointer to where an error message will be deposited.  Possible error
//  367 *                            messages are:
//  368 *
//  369 *                            OS_ERR_NONE         No tasks were     waiting on the semaphore.
//  370 *                            OS_ERR_PEND_ABORT   At least one task waiting on the semaphore was readied
//  371 *                                                and informed of the aborted wait; check return value 
//  372 *                                                for the number of tasks whose wait on the semaphore 
//  373 *                                                was aborted.
//  374 *                            OS_ERR_EVENT_TYPE   If you didn't pass a pointer to a semaphore.
//  375 *                            OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer.
//  376 *
//  377 * Returns    : == 0          if no tasks were waiting on the semaphore, or upon error.
//  378 *              >  0          if one or more tasks waiting on the semaphore are now readied and informed.
//  379 *********************************************************************************************************
//  380 */
//  381 
//  382 #if OS_SEM_PEND_ABORT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  383 INT8U  OSSemPendAbort (OS_EVENT *pevent, INT8U opt, INT8U *perr)
//  384 {
OSSemPendAbort:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R6,R1
        MOV      R5,R2
//  385     INT8U      nbr_tasks;
//  386 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  387     OS_CPU_SR  cpu_sr = 0;
//  388 #endif
//  389 
//  390 
//  391 
//  392 #if OS_ARG_CHK_EN > 0
//  393     if (perr == (INT8U *)0) {                         /* Validate 'perr'                               */
//  394         return (0);
//  395     }
//  396     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  397         *perr = OS_ERR_PEVENT_NULL;
//  398         return (0);
//  399     }
//  400 #endif
//  401     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+3
        BEQ.N    ??OSSemPendAbort_0
//  402         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        STRB     R0,[R5, #+0]
//  403         return (0);
        MOVS     R0,#+0
        POP      {R4-R8,PC}
//  404     }
//  405     OS_ENTER_CRITICAL();
??OSSemPendAbort_0:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  406     if (pevent->OSEventGrp != 0) {                    /* See if any task waiting on semaphore?         */
        LDRB     R0,[R4, #+10]
        CBZ      R0,??OSSemPendAbort_1
//  407         nbr_tasks = 0;
        MOVS     R7,#+0
//  408         switch (opt) {
        CMP      R6,#+1
        BNE.N    ??OSSemPendAbort_2
//  409             case OS_PEND_OPT_BROADCAST:               /* Do we need to abort ALL waiting tasks?        */
//  410                  while (pevent->OSEventGrp != 0) {    /* Yes, ready ALL tasks waiting on semaphore     */
//  411                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
??OSSemPendAbort_3:
        MOVS     R3,#+2
        MOVS     R2,#+1
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  412                      nbr_tasks++;
        ADDS     R7,R7,#+1
        UXTB     R7,R7
        LDRB     R0,[R4, #+10]
        CBZ      R0,??OSSemPendAbort_4
        B.N      ??OSSemPendAbort_3
//  413                  }
//  414                  break;
//  415                  
//  416             case OS_PEND_OPT_NONE:                    /* No,  ready HPT       waiting on semaphore     */
//  417             default:
//  418                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
??OSSemPendAbort_2:
        MOVS     R3,#+2
        MOVS     R2,#+1
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  419                  nbr_tasks++;
        MOVS     R7,#+1
//  420                  break;
//  421         }
//  422         OS_EXIT_CRITICAL();
??OSSemPendAbort_4:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  423         OS_Sched();                                   /* Find HPT ready to run                         */
        BL       OS_Sched
//  424         *perr = OS_ERR_PEND_ABORT;
        MOVS     R0,#+14
        STRB     R0,[R5, #+0]
//  425         return (nbr_tasks);
        MOV      R0,R7
        POP      {R4-R8,PC}
//  426     }
//  427     OS_EXIT_CRITICAL();
??OSSemPendAbort_1:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  428     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        B.N      ?Subroutine0
//  429     return (0);                                       /* No tasks waiting on semaphore                 */
//  430 }
//  431 #endif
//  432 
//  433 /*$PAGE*/
//  434 /*
//  435 *********************************************************************************************************
//  436 *                                         POST TO A SEMAPHORE
//  437 *
//  438 * Description: This function signals a semaphore
//  439 *
//  440 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  441 *                            semaphore.
//  442 *
//  443 * Returns    : OS_ERR_NONE         The call was successful and the semaphore was signaled.
//  444 *              OS_ERR_SEM_OVF      If the semaphore count exceeded its limit.  In other words, you have
//  445 *                                  signalled the semaphore more often than you waited on it with either
//  446 *                                  OSSemAccept() or OSSemPend().
//  447 *              OS_ERR_EVENT_TYPE   If you didn't pass a pointer to a semaphore
//  448 *              OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer.
//  449 *********************************************************************************************************
//  450 */
//  451 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  452 INT8U  OSSemPost (OS_EVENT *pevent)
//  453 {
OSSemPost:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//  454 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  455     OS_CPU_SR  cpu_sr = 0;
//  456 #endif
//  457 
//  458 
//  459 
//  460 #if OS_ARG_CHK_EN > 0
//  461     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  462         return (OS_ERR_PEVENT_NULL);
//  463     }
//  464 #endif
//  465     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+3
        BEQ.N    ??OSSemPost_0
//  466         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}
//  467     }
//  468     OS_ENTER_CRITICAL();
??OSSemPost_0:
        BL       OS_CPU_SR_Save
        MOV      R5,R0
//  469     if (pevent->OSEventGrp != 0) {                    /* See if any task waiting for semaphore         */
        LDRB     R0,[R4, #+10]
        CBZ      R0,??OSSemPost_1
//  470                                                       /* Ready HPT waiting on event                    */
//  471         (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_OK);
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  472         OS_EXIT_CRITICAL();
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  473         OS_Sched();                                   /* Find HPT ready to run                         */
        BL       OS_Sched
//  474         return (OS_ERR_NONE);
??OSSemPost_2:
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//  475     }
//  476     if (pevent->OSEventCnt < 65535u) {                /* Make sure semaphore will not overflow         */
??OSSemPost_1:
        LDRH     R0,[R4, #+8]
        MOVW     R1,#+65535
        CMP      R0,R1
        BEQ.N    ??OSSemPost_3
//  477         pevent->OSEventCnt++;                         /* Increment semaphore count to register event   */
        ADDS     R0,R0,#+1
        STRH     R0,[R4, #+8]
//  478         OS_EXIT_CRITICAL();
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  479         return (OS_ERR_NONE);
        B.N      ??OSSemPost_2
//  480     }
//  481     OS_EXIT_CRITICAL();                               /* Semaphore value has reached its maximum       */
??OSSemPost_3:
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  482     return (OS_ERR_SEM_OVF);
        MOVS     R0,#+50
        POP      {R1,R4,R5,PC}    ;; return
//  483 }
//  484 
//  485 /*$PAGE*/
//  486 /*
//  487 *********************************************************************************************************
//  488 *                                          QUERY A SEMAPHORE
//  489 *
//  490 * Description: This function obtains information about a semaphore
//  491 *
//  492 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  493 *                            semaphore
//  494 *
//  495 *              p_sem_data    is a pointer to a structure that will contain information about the
//  496 *                            semaphore.
//  497 *
//  498 * Returns    : OS_ERR_NONE         The call was successful and the message was sent
//  499 *              OS_ERR_EVENT_TYPE   If you are attempting to obtain data from a non semaphore.
//  500 *              OS_ERR_PEVENT_NULL  If 'pevent'     is a NULL pointer.
//  501 *              OS_ERR_PDATA_NULL   If 'p_sem_data' is a NULL pointer
//  502 *********************************************************************************************************
//  503 */
//  504 
//  505 #if OS_SEM_QUERY_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  506 INT8U  OSSemQuery (OS_EVENT *pevent, OS_SEM_DATA *p_sem_data)
//  507 {
OSSemQuery:
        PUSH     {R3-R5,LR}
        MOV      R5,R0
        MOV      R4,R1
//  508 #if OS_LOWEST_PRIO <= 63
//  509     INT8U     *psrc;
//  510     INT8U     *pdest;
//  511 #else
//  512     INT16U    *psrc;
//  513     INT16U    *pdest;
//  514 #endif
//  515     INT8U      i;
//  516 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  517     OS_CPU_SR  cpu_sr = 0;
//  518 #endif
//  519 
//  520 
//  521 
//  522 #if OS_ARG_CHK_EN > 0
//  523     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  524         return (OS_ERR_PEVENT_NULL);
//  525     }
//  526     if (p_sem_data == (OS_SEM_DATA *)0) {                  /* Validate 'p_sem_data'                    */
//  527         return (OS_ERR_PDATA_NULL);
//  528     }
//  529 #endif
//  530     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {        /* Validate event block type                */
        LDRB     R0,[R5, #+0]
        CMP      R0,#+3
        BEQ.N    ??OSSemQuery_0
//  531         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}
//  532     }
//  533     OS_ENTER_CRITICAL();
??OSSemQuery_0:
        BL       OS_CPU_SR_Save
//  534     p_sem_data->OSEventGrp = pevent->OSEventGrp;           /* Copy message mailbox wait list           */
        LDRB     R1,[R5, #+10]
        STRB     R1,[R4, #+6]
//  535     psrc                   = &pevent->OSEventTbl[0];
        ADD      R1,R5,#+11
//  536     pdest                  = &p_sem_data->OSEventTbl[0];
        ADDS     R2,R4,#+2
//  537     for (i = 0; i < OS_EVENT_TBL_SIZE; i++) {
//  538         *pdest++ = *psrc++;
        LDRB     R3,[R1, #+0]
        STRB     R3,[R2, #+0]
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
//  539     }
//  540     p_sem_data->OSCnt = pevent->OSEventCnt;                /* Get semaphore count                      */
        LDRH     R1,[R5, #+8]
        STRH     R1,[R4, #+0]
//  541     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  542     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  543 }
//  544 #endif                                                     /* OS_SEM_QUERY_EN                          */
//  545 
//  546 /*$PAGE*/
//  547 /*
//  548 *********************************************************************************************************
//  549 *                                              SET SEMAPHORE
//  550 *
//  551 * Description: This function sets the semaphore count to the value specified as an argument.  Typically,
//  552 *              this value would be 0.
//  553 *
//  554 *              You would typically use this function when a semaphore is used as a signaling mechanism
//  555 *              and, you want to reset the count value.
//  556 *
//  557 * Arguments  : pevent     is a pointer to the event control block
//  558 *
//  559 *              cnt        is the new value for the semaphore count.  You would pass 0 to reset the
//  560 *                         semaphore count.
//  561 *
//  562 *              perr       is a pointer to an error code returned by the function as follows:
//  563 *
//  564 *                            OS_ERR_NONE          The call was successful and the semaphore value was set.
//  565 *                            OS_ERR_EVENT_TYPE    If you didn't pass a pointer to a semaphore.
//  566 *                            OS_ERR_PEVENT_NULL   If 'pevent' is a NULL pointer.
//  567 *                            OS_ERR_TASK_WAITING  If tasks are waiting on the semaphore.
//  568 *********************************************************************************************************
//  569 */
//  570 
//  571 #if OS_SEM_SET_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  572 void  OSSemSet (OS_EVENT *pevent, INT16U cnt, INT8U *perr)
//  573 {
OSSemSet:
        PUSH     {R4-R6,LR}
        MOV      R6,R0
        MOV      R4,R1
        MOV      R5,R2
//  574 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  575     OS_CPU_SR  cpu_sr = 0;
//  576 #endif
//  577 
//  578 
//  579 
//  580 #if OS_ARG_CHK_EN > 0
//  581     if (perr == (INT8U *)0) {                         /* Validate 'perr'                               */
//  582         return;
//  583     }
//  584     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  585         *perr = OS_ERR_PEVENT_NULL;
//  586         return;
//  587     }
//  588 #endif
//  589     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
        LDRB     R0,[R6, #+0]
        CMP      R0,#+3
        BEQ.N    ??OSSemSet_0
//  590         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        STRB     R0,[R5, #+0]
//  591         return;
        POP      {R4-R6,PC}
//  592     }
//  593     OS_ENTER_CRITICAL();
??OSSemSet_0:
        BL       OS_CPU_SR_Save
//  594     *perr = OS_ERR_NONE;
        MOVS     R1,#+0
        STRB     R1,[R5, #+0]
//  595     if (pevent->OSEventCnt > 0) {                     /* See if semaphore already has a count          */
        LDRH     R1,[R6, #+8]
        CBZ      R1,??OSSemSet_1
//  596         pevent->OSEventCnt = cnt;                     /* Yes, set it to the new value specified.       */
??OSSemSet_2:
        STRH     R4,[R6, #+8]
        B.N      ??OSSemSet_3
//  597     } else {                                          /* No                                            */
//  598         if (pevent->OSEventGrp == 0) {                /*      See if task(s) waiting?                  */
??OSSemSet_1:
        LDRB     R1,[R6, #+10]
        CMP      R1,#+0
        BEQ.N    ??OSSemSet_2
//  599             pevent->OSEventCnt = cnt;                 /*      No, OK to set the value                  */
//  600         } else {
//  601             *perr              = OS_ERR_TASK_WAITING;
        MOVS     R1,#+73
        STRB     R1,[R5, #+0]
//  602         }
//  603     }
//  604     OS_EXIT_CRITICAL();
??OSSemSet_3:
        POP      {R4-R6,LR}
        B.W      OS_CPU_SR_Restore
//  605 }

        END
//  606 #endif
//  607 
//  608 #endif                                                /* OS_SEM_EN                                     */
// 
// 748 bytes in section .text
// 
// 748 bytes of CODE memory
//
//Errors: none
//Warnings: none
