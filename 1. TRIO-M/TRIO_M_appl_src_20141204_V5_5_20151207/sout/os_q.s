///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:42 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\os_q.c                                             /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\os_q.c -D _MIMO_Type -lcN                          /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\os_q. /
//                    s                                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_q

        EXTERN OSEventFreeList
        EXTERN OSIntNesting
        EXTERN OSLockNesting
        EXTERN OSQFreeList
        EXTERN OSQTbl
        EXTERN OSTCBCur
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_EventTOAbort
        EXTERN OS_EventTaskRdy
        EXTERN OS_EventTaskWait
        EXTERN OS_EventWaitListInit
        EXTERN OS_MemClr
        EXTERN OS_Sched

        PUBLIC OSQAccept
        PUBLIC OSQCreate
        PUBLIC OSQDel
        PUBLIC OSQFlush
        PUBLIC OSQPend
        PUBLIC OSQPendAbort
        PUBLIC OSQPost
        PUBLIC OSQPostFront
        PUBLIC OSQPostOpt
        PUBLIC OSQQuery
        PUBLIC OS_QInit

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Source\os_q.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                        MESSAGE QUEUE MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_Q.C
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
//   29 #if (OS_Q_EN > 0) && (OS_MAX_QS > 0)
//   30 /*
//   31 *********************************************************************************************************
//   32 *                                      ACCEPT MESSAGE FROM QUEUE
//   33 *
//   34 * Description: This function checks the queue to see if a message is available.  Unlike OSQPend(),
//   35 *              OSQAccept() does not suspend the calling task if a message is not available.
//   36 *
//   37 * Arguments  : pevent        is a pointer to the event control block
//   38 *
//   39 *              perr          is a pointer to where an error message will be deposited.  Possible error
//   40 *                            messages are:
//   41 *
//   42 *                            OS_ERR_NONE         The call was successful and your task received a
//   43 *                                                message.
//   44 *                            OS_ERR_EVENT_TYPE   You didn't pass a pointer to a queue
//   45 *                            OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer
//   46 *                            OS_ERR_Q_EMPTY      The queue did not contain any messages
//   47 *
//   48 * Returns    : != (void *)0  is the message in the queue if one is available.  The message is removed
//   49 *                            from the so the next time OSQAccept() is called, the queue will contain
//   50 *                            one less entry.
//   51 *              == (void *)0  if you received a NULL pointer message
//   52 *                            if the queue is empty or,
//   53 *                            if 'pevent' is a NULL pointer or,
//   54 *                            if you passed an invalid event type
//   55 *
//   56 * Note(s)    : As of V2.60, you can now pass NULL pointers through queues.  Because of this, the argument
//   57 *              'perr' has been added to the API to tell you about the outcome of the call.
//   58 *********************************************************************************************************
//   59 */
//   60 
//   61 #if OS_Q_ACCEPT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   62 void  *OSQAccept (OS_EVENT *pevent, INT8U *perr)
//   63 {
OSQAccept:
        PUSH     {R3-R5,LR}
        MOV      R5,R0
        MOV      R4,R1
//   64     void      *pmsg;
//   65     OS_Q      *pq;
//   66 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//   67     OS_CPU_SR  cpu_sr = 0;
//   68 #endif
//   69 
//   70 
//   71 
//   72 #if OS_ARG_CHK_EN > 0
//   73     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//   74         return ((void *)0);
//   75     }
//   76     if (pevent == (OS_EVENT *)0) {               /* Validate 'pevent'                                  */
//   77         *perr = OS_ERR_PEVENT_NULL;
//   78         return ((void *)0);
//   79     }
//   80 #endif
//   81     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {/* Validate event block type                          */
        LDRB     R0,[R5, #+0]
        CMP      R0,#+2
        BEQ.N    ??OSQAccept_0
//   82         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
//   83         return ((void *)0);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//   84     }
//   85     OS_ENTER_CRITICAL();
??OSQAccept_0:
        BL       OS_CPU_SR_Save
//   86     pq = (OS_Q *)pevent->OSEventPtr;             /* Point at queue control block                       */
        LDR      R1,[R5, #+4]
//   87     if (pq->OSQEntries > 0) {                    /* See if any messages in the queue                   */
        LDRH     R2,[R1, #+22]
        CBZ      R2,??OSQAccept_1
//   88         pmsg = *pq->OSQOut++;                    /* Yes, extract oldest message from the queue         */
        LDR      R5,[R1, #+16]
        ADDS     R3,R5,#+4
        STR      R3,[R1, #+16]
        LDR      R5,[R5, #+0]
//   89         pq->OSQEntries--;                        /* Update the number of entries in the queue          */
        SUBS     R2,R2,#+1
        STRH     R2,[R1, #+22]
//   90         if (pq->OSQOut == pq->OSQEnd) {          /* Wrap OUT pointer if we are at the end of the queue */
        LDR      R2,[R1, #+16]
        LDR      R3,[R1, #+8]
        CMP      R2,R3
        BNE.N    ??OSQAccept_2
//   91             pq->OSQOut = pq->OSQStart;
        LDR      R2,[R1, #+4]
        STR      R2,[R1, #+16]
//   92         }
//   93         *perr = OS_ERR_NONE;
??OSQAccept_2:
        MOVS     R1,#+0
        B.N      ??OSQAccept_3
//   94     } else {
//   95         *perr = OS_ERR_Q_EMPTY;
??OSQAccept_1:
        MOVS     R1,#+31
//   96         pmsg  = (void *)0;                       /* Queue is empty                                     */
        MOVS     R5,#+0
??OSQAccept_3:
        STRB     R1,[R4, #+0]
//   97     }
//   98     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//   99     return (pmsg);                               /* Return message received (or NULL)                  */
        MOV      R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//  100 }
//  101 #endif
//  102 /*$PAGE*/
//  103 /*
//  104 *********************************************************************************************************
//  105 *                                        CREATE A MESSAGE QUEUE
//  106 *
//  107 * Description: This function creates a message queue if free event control blocks are available.
//  108 *
//  109 * Arguments  : start         is a pointer to the base address of the message queue storage area.  The
//  110 *                            storage area MUST be declared as an array of pointers to 'void' as follows
//  111 *
//  112 *                            void *MessageStorage[size]
//  113 *
//  114 *              size          is the number of elements in the storage area
//  115 *
//  116 * Returns    : != (OS_EVENT *)0  is a pointer to the event control clock (OS_EVENT) associated with the
//  117 *                                created queue
//  118 *              == (OS_EVENT *)0  if no event control blocks were available or an error was detected
//  119 *********************************************************************************************************
//  120 */
//  121 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  122 OS_EVENT  *OSQCreate (void **start, INT16U size)
//  123 {
OSQCreate:
        PUSH     {R4-R8,LR}
        MOV      R5,R0
        MOV      R8,R1
//  124     OS_EVENT  *pevent;
//  125     OS_Q      *pq;
//  126 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  127     OS_CPU_SR  cpu_sr = 0;
//  128 #endif
//  129 
//  130 
//  131 
//  132     if (OSIntNesting > 0) {                      /* See if called from ISR ...                         */
        LDR.N    R0,??DataTable8  ;; OSIntNesting
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSQCreate_0
//  133         return ((OS_EVENT *)0);                  /* ... can't CREATE from an ISR                       */
        B.N      ??Subroutine4_0
//  134     }
//  135     OS_ENTER_CRITICAL();
??OSQCreate_0:
        BL       OS_CPU_SR_Save
//  136     pevent = OSEventFreeList;                    /* Get next free event control block                  */
        LDR.N    R6,??DataTable7  ;; OSEventFreeList
        LDR      R1,[R6, #+0]
        MOVS     R7,R1
//  137     if (OSEventFreeList != (OS_EVENT *)0) {      /* See if pool of free ECB pool was empty             */
        BEQ.N    ??OSQCreate_1
//  138         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
        LDR      R1,[R1, #+4]
        STR      R1,[R6, #+0]
//  139     }
//  140     OS_EXIT_CRITICAL();
??OSQCreate_1:
        BL       OS_CPU_SR_Restore
//  141     if (pevent != (OS_EVENT *)0) {               /* See if we have an event control block              */
        CMP      R7,#+0
        BEQ.N    ??OSQCreate_2
//  142         OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  143         pq = OSQFreeList;                        /* Get a free queue control block                     */
        LDR.W    R1,??DataTable9  ;; OSQFreeList
        LDR      R2,[R1, #+0]
        MOV      R4,R2
//  144         if (pq != (OS_Q *)0) {                   /* Were we able to get a queue control block ?        */
        CBZ      R4,??OSQCreate_3
//  145             OSQFreeList            = OSQFreeList->OSQPtr; /* Yes, Adjust free list pointer to next free*/
        LDR      R2,[R2, #+0]
        STR      R2,[R1, #+0]
//  146             OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  147             pq->OSQStart           = start;               /*      Initialize the queue                 */
        STR      R5,[R4, #+4]
//  148             pq->OSQEnd             = &start[size];
        ADD      R0,R5,R8, LSL #+2
        STR      R0,[R4, #+8]
//  149             pq->OSQIn              = start;
        STR      R5,[R4, #+12]
//  150             pq->OSQOut             = start;
        STR      R5,[R4, #+16]
//  151             pq->OSQSize            = size;
        STRH     R8,[R4, #+20]
//  152             pq->OSQEntries         = 0;
        MOVS     R0,#+0
        STRH     R0,[R4, #+22]
//  153             pevent->OSEventType    = OS_EVENT_TYPE_Q;
        MOVS     R0,#+2
        STRB     R0,[R7, #+0]
//  154             pevent->OSEventCnt     = 0;
        MOVS     R0,#+0
        STRH     R0,[R7, #+8]
//  155             pevent->OSEventPtr     = pq;
        STR      R4,[R7, #+4]
//  156 #if OS_EVENT_NAME_SIZE > 1
//  157             pevent->OSEventName[0] = '?';                  /* Unknown name                             */
//  158             pevent->OSEventName[1] = OS_ASCII_NUL;
//  159 #endif
//  160             OS_EventWaitListInit(pevent);                 /*      Initalize the wait list              */
        MOV      R0,R7
        BL       OS_EventWaitListInit
        B.N      ??OSQCreate_2
//  161         } else {
//  162             pevent->OSEventPtr = (void *)OSEventFreeList; /* No,  Return event control block on error  */
??OSQCreate_3:
        LDR      R1,[R6, #+0]
        STR      R1,[R7, #+4]
//  163             OSEventFreeList    = pevent;
        STR      R7,[R6, #+0]
//  164             OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  165             pevent = (OS_EVENT *)0;
        MOVS     R7,#+0
??OSQCreate_2:
        Nop      
//  166         }
//  167     }
//  168     return (pevent);
        REQUIRE ?Subroutine2
        ;; // Fall through to label ?Subroutine2
//  169 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine2:
        MOV      R0,R7
        POP      {R4-R8,PC}       ;; return
//  170 /*$PAGE*/
//  171 /*
//  172 *********************************************************************************************************
//  173 *                                        DELETE A MESSAGE QUEUE
//  174 *
//  175 * Description: This function deletes a message queue and readies all tasks pending on the queue.
//  176 *
//  177 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  178 *                            queue.
//  179 *
//  180 *              opt           determines delete options as follows:
//  181 *                            opt == OS_DEL_NO_PEND   Delete the queue ONLY if no task pending
//  182 *                            opt == OS_DEL_ALWAYS    Deletes the queue even if tasks are waiting.
//  183 *                                                    In this case, all the tasks pending will be readied.
//  184 *
//  185 *              perr          is a pointer to an error code that can contain one of the following values:
//  186 *                            OS_ERR_NONE             The call was successful and the queue was deleted
//  187 *                            OS_ERR_DEL_ISR          If you tried to delete the queue from an ISR
//  188 *                            OS_ERR_INVALID_OPT      An invalid option was specified
//  189 *                            OS_ERR_TASK_WAITING     One or more tasks were waiting on the queue
//  190 *                            OS_ERR_EVENT_TYPE       If you didn't pass a pointer to a queue
//  191 *                            OS_ERR_PEVENT_NULL      If 'pevent' is a NULL pointer.
//  192 *
//  193 * Returns    : pevent        upon error
//  194 *              (OS_EVENT *)0 if the queue was successfully deleted.
//  195 *
//  196 * Note(s)    : 1) This function must be used with care.  Tasks that would normally expect the presence of
//  197 *                 the queue MUST check the return code of OSQPend().
//  198 *              2) OSQAccept() callers will not know that the intended queue has been deleted unless
//  199 *                 they check 'pevent' to see that it's a NULL pointer.
//  200 *              3) This call can potentially disable interrupts for a long time.  The interrupt disable
//  201 *                 time is directly proportional to the number of tasks waiting on the queue.
//  202 *              4) Because ALL tasks pending on the queue will be readied, you MUST be careful in
//  203 *                 applications where the queue is used for mutual exclusion because the resource(s)
//  204 *                 will no longer be guarded by the queue.
//  205 *              5) If the storage for the message queue was allocated dynamically (i.e. using a malloc()
//  206 *                 type call) then your application MUST release the memory storage by call the counterpart
//  207 *                 call of the dynamic allocation scheme used.  If the queue storage was created statically
//  208 *                 then, the storage can be reused.
//  209 *********************************************************************************************************
//  210 */
//  211 
//  212 #if OS_Q_DEL_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  213 OS_EVENT  *OSQDel (OS_EVENT *pevent, INT8U opt, INT8U *perr)
//  214 {
OSQDel:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R6,R1
        MOV      R5,R2
//  215     BOOLEAN    tasks_waiting;
//  216     OS_EVENT  *pevent_return;
//  217     OS_Q      *pq;
//  218 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  219     OS_CPU_SR  cpu_sr = 0;
//  220 #endif
//  221 
//  222 
//  223 
//  224 #if OS_ARG_CHK_EN > 0
//  225     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  226         return (pevent);
//  227     }
//  228     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  229         *perr = OS_ERR_PEVENT_NULL;
//  230         return (pevent);
//  231     }
//  232 #endif
//  233     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {          /* Validate event block type                */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+2
        BEQ.N    ??OSQDel_0
//  234         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
//  235         return (pevent);
//  236     }
??OSQDel_1:
        B.N      ?Subroutine0
//  237     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
??OSQDel_0:
        LDR.N    R0,??DataTable8  ;; OSIntNesting
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSQDel_2
//  238         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
        MOVS     R0,#+15
        B.N      ??OSQDel_1
//  239         return (pevent);
//  240     }
//  241     OS_ENTER_CRITICAL();
??OSQDel_2:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  242     if (pevent->OSEventGrp != 0) {                         /* See if any tasks waiting on queue        */
        LDRB     R0,[R4, #+10]
        SUBS     R7,R0,#+1
        SBCS     R7,R7,R7
        MVNS     R7,R7
        LSRS     R7,R7,#+31
//  243         tasks_waiting = OS_TRUE;                           /* Yes                                      */
//  244     } else {
//  245         tasks_waiting = OS_FALSE;                          /* No                                       */
//  246     }
//  247     switch (opt) {
        CBZ      R6,??OSQDel_3
        CMP      R6,#+1
        BEQ.N    ??OSQDel_4
        B.N      ??OSQDel_5
//  248         case OS_DEL_NO_PEND:                               /* Delete queue only if no task waiting     */
//  249              if (tasks_waiting == OS_FALSE) {
??OSQDel_3:
        CBNZ     R7,??OSQDel_6
//  250 #if OS_EVENT_NAME_SIZE > 1
//  251                  pevent->OSEventName[0] = '?';             /* Unknown name                             */
//  252                  pevent->OSEventName[1] = OS_ASCII_NUL;
//  253 #endif
//  254                  pq                     = (OS_Q *)pevent->OSEventPtr;  /* Return OS_Q to free list     */
        LDR      R0,[R4, #+4]
//  255                  pq->OSQPtr             = OSQFreeList;
        LDR.W    R1,??DataTable9  ;; OSQFreeList
        LDR      R2,[R1, #+0]
        STR      R2,[R0, #+0]
//  256                  OSQFreeList            = pq;
        STR      R0,[R1, #+0]
//  257                  pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  258                  pevent->OSEventPtr     = OSEventFreeList; /* Return Event Control Block to free list  */
        LDR.N    R0,??DataTable7  ;; OSEventFreeList
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  259                  pevent->OSEventCnt     = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  260                  OSEventFreeList        = pevent;          /* Get next free event control block        */
        STR      R4,[R0, #+0]
//  261                  OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  262                  *perr                  = OS_ERR_NONE;
??OSQDel_7:
        MOVS     R1,#+0
//  263                  pevent_return          = (OS_EVENT *)0;   /* Queue has been deleted                   */
        MOVS     R0,#+0
        B.N      ??OSQDel_8
//  264              } else {
//  265                  OS_EXIT_CRITICAL();
??OSQDel_6:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  266                  *perr                  = OS_ERR_TASK_WAITING;
        MOVS     R1,#+73
//  267                  pevent_return          = pevent;
        B.N      ??OSQDel_9
//  268              }
//  269              break;
//  270 
//  271         case OS_DEL_ALWAYS:                                /* Always delete the queue                  */
//  272              while (pevent->OSEventGrp != 0) {             /* Ready ALL tasks waiting for queue        */
??OSQDel_4:
        CBZ      R0,??OSQDel_10
//  273                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_OK);
??OSQDel_11:
        MOVS     R3,#+0
        MOVS     R2,#+4
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
        LDRB     R0,[R4, #+10]
        CMP      R0,#+0
        BNE.N    ??OSQDel_11
//  274              }
//  275 #if OS_EVENT_NAME_SIZE > 1
//  276              pevent->OSEventName[0] = '?';                 /* Unknown name                             */
//  277              pevent->OSEventName[1] = OS_ASCII_NUL;
//  278 #endif
//  279              pq                     = (OS_Q *)pevent->OSEventPtr;   /* Return OS_Q to free list        */
??OSQDel_10:
        LDR      R0,[R4, #+4]
//  280              pq->OSQPtr             = OSQFreeList;
        LDR.W    R1,??DataTable9  ;; OSQFreeList
        LDR      R2,[R1, #+0]
        STR      R2,[R0, #+0]
//  281              OSQFreeList            = pq;
        STR      R0,[R1, #+0]
//  282              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  283              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
        LDR.N    R0,??DataTable7  ;; OSEventFreeList
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  284              pevent->OSEventCnt     = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  285              OSEventFreeList        = pevent;              /* Get next free event control block        */
        STR      R4,[R0, #+0]
//  286              OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  287              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
        CMP      R7,#+1
        BNE.N    ??OSQDel_7
//  288                  OS_Sched();                               /* Find highest priority task ready to run  */
        BL       OS_Sched
//  289              }
//  290              *perr                  = OS_ERR_NONE;
        B.N      ??OSQDel_7
//  291              pevent_return          = (OS_EVENT *)0;       /* Queue has been deleted                   */
//  292              break;
//  293 
//  294         default:
//  295              OS_EXIT_CRITICAL();
??OSQDel_5:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  296              *perr                  = OS_ERR_INVALID_OPT;
        MOVS     R1,#+7
//  297              pevent_return          = pevent;
??OSQDel_9:
        MOV      R0,R4
??OSQDel_8:
        STRB     R1,[R5, #+0]
//  298              break;
//  299     }
//  300     return (pevent_return);
        POP      {R4-R8,PC}       ;; return
//  301 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     OSEventFreeList
//  302 #endif
//  303 
//  304 /*$PAGE*/
//  305 /*
//  306 *********************************************************************************************************
//  307 *                                             FLUSH QUEUE
//  308 *
//  309 * Description : This function is used to flush the contents of the message queue.
//  310 *
//  311 * Arguments   : none
//  312 *
//  313 * Returns     : OS_ERR_NONE         upon success
//  314 *               OS_ERR_EVENT_TYPE   If you didn't pass a pointer to a queue
//  315 *               OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer
//  316 *
//  317 * WARNING     : You should use this function with great care because, when to flush the queue, you LOOSE
//  318 *               the references to what the queue entries are pointing to and thus, you could cause
//  319 *               'memory leaks'.  In other words, the data you are pointing to that's being referenced
//  320 *               by the queue entries should, most likely, need to be de-allocated (i.e. freed).
//  321 *********************************************************************************************************
//  322 */
//  323 
//  324 #if OS_Q_FLUSH_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  325 INT8U  OSQFlush (OS_EVENT *pevent)
//  326 {
OSQFlush:
        PUSH     {R4,LR}
        MOV      R4,R0
//  327     OS_Q      *pq;
//  328 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  329     OS_CPU_SR  cpu_sr = 0;
//  330 #endif
//  331 
//  332 
//  333 
//  334 #if OS_ARG_CHK_EN > 0
//  335     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  336         return (OS_ERR_PEVENT_NULL);
//  337     }
//  338     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
//  339         return (OS_ERR_EVENT_TYPE);
//  340     }
//  341 #endif
//  342     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  343     pq             = (OS_Q *)pevent->OSEventPtr;      /* Point to queue storage structure              */
        LDR      R1,[R4, #+4]
//  344     pq->OSQIn      = pq->OSQStart;
        LDR      R2,[R1, #+4]
        STR      R2,[R1, #+12]
//  345     pq->OSQOut     = pq->OSQStart;
        LDR      R2,[R1, #+4]
        STR      R2,[R1, #+16]
//  346     pq->OSQEntries = 0;
        MOVS     R2,#+0
        STRH     R2,[R1, #+22]
//  347     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  348     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R4,PC}          ;; return
//  349 }
//  350 #endif
//  351 
//  352 /*$PAGE*/
//  353 /*
//  354 *********************************************************************************************************
//  355 *                                     PEND ON A QUEUE FOR A MESSAGE
//  356 *
//  357 * Description: This function waits for a message to be sent to a queue
//  358 *
//  359 * Arguments  : pevent        is a pointer to the event control block associated with the desired queue
//  360 *
//  361 *              timeout       is an optional timeout period (in clock ticks).  If non-zero, your task will
//  362 *                            wait for a message to arrive at the queue up to the amount of time
//  363 *                            specified by this argument.  If you specify 0, however, your task will wait
//  364 *                            forever at the specified queue or, until a message arrives.
//  365 *
//  366 *              perr          is a pointer to where an error message will be deposited.  Possible error
//  367 *                            messages are:
//  368 *
//  369 *                            OS_ERR_NONE         The call was successful and your task received a
//  370 *                                                message.
//  371 *                            OS_ERR_TIMEOUT      A message was not received within the specified 'timeout'.
//  372 *                            OS_ERR_PEND_ABORT   The wait on the queue was aborted.
//  373 *                            OS_ERR_EVENT_TYPE   You didn't pass a pointer to a queue
//  374 *                            OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer
//  375 *                            OS_ERR_PEND_ISR     If you called this function from an ISR and the result
//  376 *                                                would lead to a suspension.
//  377 *                            OS_ERR_PEND_LOCKED  If you called this function with the scheduler is locked
//  378 *
//  379 * Returns    : != (void *)0  is a pointer to the message received
//  380 *              == (void *)0  if you received a NULL pointer message or,
//  381 *                            if no message was received or,
//  382 *                            if 'pevent' is a NULL pointer or,
//  383 *                            if you didn't pass a pointer to a queue.
//  384 *
//  385 * Note(s)    : As of V2.60, this function allows you to receive NULL pointer messages.
//  386 *********************************************************************************************************
//  387 */
//  388 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  389 void  *OSQPend (OS_EVENT *pevent, INT16U timeout, INT8U *perr)
//  390 {
OSQPend:
        PUSH     {R4-R8,LR}
        MOV      R6,R0
        MOV      R4,R1
        MOV      R5,R2
//  391     void      *pmsg;
//  392     OS_Q      *pq;
//  393     INT8U      pend_stat;
//  394 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  395     OS_CPU_SR  cpu_sr = 0;
//  396 #endif
//  397 
//  398 
//  399 
//  400 #if OS_ARG_CHK_EN > 0
//  401     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//  402         return ((void *)0);
//  403     }
//  404     if (pevent == (OS_EVENT *)0) {               /* Validate 'pevent'                                  */
//  405         *perr = OS_ERR_PEVENT_NULL;
//  406         return ((void *)0);
//  407     }
//  408     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {/* Validate event block type                          */
//  409         *perr = OS_ERR_EVENT_TYPE;
//  410         return ((void *)0);
//  411     }
//  412 #endif
//  413     if (OSIntNesting > 0) {                      /* See if called from ISR ...                         */
        LDR.N    R0,??DataTable8  ;; OSIntNesting
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSQPend_0
//  414         *perr = OS_ERR_PEND_ISR;                 /* ... can't PEND from an ISR                         */
        MOVS     R0,#+2
//  415         return ((void *)0);
//  416     }
??OSQPend_1:
        B.N      ?Subroutine1
//  417     if (OSLockNesting > 0) {                     /* See if called with scheduler locked ...            */
??OSQPend_0:
        LDR.N    R0,??OSQPend_2   ;; OSLockNesting
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSQPend_3
//  418         *perr = OS_ERR_PEND_LOCKED;              /* ... can't PEND when locked                         */
        MOVS     R0,#+13
        B.N      ??OSQPend_1
//  419         return ((void *)0);
//  420     }
//  421     OS_ENTER_CRITICAL();
??OSQPend_3:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  422     pq = (OS_Q *)pevent->OSEventPtr;             /* Point at queue control block                       */
        LDR      R0,[R6, #+4]
//  423     if (pq->OSQEntries > 0) {                    /* See if any messages in the queue                   */
        LDRH     R1,[R0, #+22]
        CBZ      R1,??OSQPend_4
//  424         pmsg = *pq->OSQOut++;                    /* Yes, extract oldest message from the queue         */
        LDR      R3,[R0, #+16]
        ADDS     R2,R3,#+4
        STR      R2,[R0, #+16]
        LDR      R4,[R3, #+0]
//  425         pq->OSQEntries--;                        /* Update the number of entries in the queue          */
        SUBS     R1,R1,#+1
        STRH     R1,[R0, #+22]
//  426         if (pq->OSQOut == pq->OSQEnd) {          /* Wrap OUT pointer if we are at the end of the queue */
        LDR      R1,[R0, #+16]
        LDR      R2,[R0, #+8]
        CMP      R1,R2
        BNE.N    ??OSQPend_5
//  427             pq->OSQOut = pq->OSQStart;
        LDR      R1,[R0, #+4]
        STR      R1,[R0, #+16]
//  428         }
//  429         OS_EXIT_CRITICAL();
        B.N      ??OSQPend_5
//  430         *perr = OS_ERR_NONE;
//  431         return (pmsg);                           /* Return message received                            */
//  432     }
//  433     OSTCBCur->OSTCBStat     |= OS_STAT_Q;        /* Task will have to pend for a message to be posted  */
??OSQPend_4:
        LDR.N    R7,??OSQPend_2+0x4  ;; OSTCBCur
        LDR      R0,[R7, #+0]
        LDRB     R1,[R0, #+28]
        ORR      R1,R1,#0x4
        STRB     R1,[R0, #+28]
//  434     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
        LDR      R0,[R7, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+29]
//  435     OSTCBCur->OSTCBDly       = timeout;          /* Load timeout into TCB                              */
        LDR      R0,[R7, #+0]
        STRH     R4,[R0, #+26]
//  436     OS_EventTaskWait(pevent);                    /* Suspend task until event or timeout occurs         */
        MOV      R0,R6
        BL       OS_EventTaskWait
//  437     OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  438     OS_Sched();                                  /* Find next highest priority task ready to run       */
        BL       OS_Sched
//  439     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  440     if (OSTCBCur->OSTCBStatPend != OS_STAT_PEND_OK) { /* Was task readied because timed-out or aborted?*/
        LDR      R0,[R7, #+0]
        LDRB     R4,[R0, #+29]
        CBZ      R4,??OSQPend_6
//  441         pend_stat = OSTCBCur->OSTCBStatPend;
//  442         OS_EventTOAbort(pevent);
        MOV      R0,R6
        BL       OS_EventTOAbort
//  443         OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  444         switch (pend_stat) {
        CMP      R4,#+2
        BEQ.N    ??OSQPend_7
//  445             case OS_STAT_PEND_TO:
//  446             default:
//  447                  *perr = OS_ERR_TIMEOUT;         /*     Indicate a timeout occured                     */
        MOVS     R0,#+10
        B.N      ??OSQPend_1
//  448                  break;
//  449 
//  450             case OS_STAT_PEND_ABORT:
//  451                  *perr = OS_ERR_PEND_ABORT;      /*     Indicate that we aborted                       */
??OSQPend_7:
        MOVS     R0,#+14
        B.N      ??OSQPend_1
//  452                  break;
//  453         }
//  454         return ((void *)0);                      /*     No message received                            */
//  455     }
//  456     pmsg                    = OSTCBCur->OSTCBMsg;/* No, Extract message from TCB (Put there by QPost)  */
??OSQPend_6:
        LDR      R4,[R0, #+16]
//  457     OSTCBCur->OSTCBMsg      = (void *)0;
        MOVS     R1,#+0
        STR      R1,[R0, #+16]
//  458     OSTCBCur->OSTCBStat     = OS_STAT_RDY;
        STRB     R1,[R0, #+28]
//  459     OSTCBCur->OSTCBEventPtr = (OS_EVENT *)0;     /*     No longer waiting for event                    */
        LDR      R0,[R7, #+0]
        STR      R1,[R0, #+12]
//  460     OS_EXIT_CRITICAL();
??OSQPend_5:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  461     *perr                   = OS_ERR_NONE;
        MOVS     R0,#+0
        B.N      ?Subroutine0
        DATA
??OSQPend_2:
        DC32     OSLockNesting
        DC32     OSTCBCur
//  462     return (pmsg);                               /*     Return message received                        */
//  463 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable8:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
?Subroutine1:
        STRB     R0,[R5, #+0]
        Nop      
        REQUIRE ??Subroutine4_0
        ;; // Fall through to label ??Subroutine4_0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
??Subroutine4_0:
        MOVS     R0,#+0
        POP      {R4-R8,PC}

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        STRB     R0,[R5, #+0]
        MOV      R0,R4
        POP      {R4-R8,PC}
//  464 /*$PAGE*/
//  465 /*
//  466 *********************************************************************************************************
//  467 *                                      ABORT WAITING ON A MESSAGE QUEUE
//  468 *
//  469 * Description: This function aborts & readies any tasks currently waiting on a queue.  This function 
//  470 *              should be used to fault-abort the wait on the queue, rather than to normally signal
//  471 *              the queue via OSQPost(), OSQPostFront() or OSQPostOpt().
//  472 *
//  473 * Arguments  : pevent        is a pointer to the event control block associated with the desired queue.
//  474 *
//  475 *              opt           determines the type of ABORT performed:
//  476 *                            OS_PEND_OPT_NONE         ABORT wait for a single task (HPT) waiting on the
//  477 *                                                     queue
//  478 *                            OS_PEND_OPT_BROADCAST    ABORT wait for ALL tasks that are  waiting on the
//  479 *                                                     queue
//  480 *
//  481 *              perr          is a pointer to where an error message will be deposited.  Possible error
//  482 *                            messages are:
//  483 *
//  484 *                            OS_ERR_NONE         No tasks were     waiting on the queue.
//  485 *                            OS_ERR_PEND_ABORT   At least one task waiting on the queue was readied
//  486 *                                                and informed of the aborted wait; check return value 
//  487 *                                                for the number of tasks whose wait on the queue 
//  488 *                                                was aborted.
//  489 *                            OS_ERR_EVENT_TYPE   If you didn't pass a pointer to a queue.
//  490 *                            OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer.
//  491 *
//  492 * Returns    : == 0          if no tasks were waiting on the queue, or upon error.
//  493 *              >  0          if one or more tasks waiting on the queue are now readied and informed.
//  494 *********************************************************************************************************
//  495 */
//  496 
//  497 #if OS_Q_PEND_ABORT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  498 INT8U  OSQPendAbort (OS_EVENT *pevent, INT8U opt, INT8U *perr)
//  499 {
OSQPendAbort:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R6,R1
        MOV      R5,R2
//  500     INT8U      nbr_tasks;
//  501 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  502     OS_CPU_SR  cpu_sr = 0;
//  503 #endif
//  504 
//  505 
//  506 
//  507 #if OS_ARG_CHK_EN > 0
//  508     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  509         return (0);
//  510     }
//  511     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  512         *perr = OS_ERR_PEVENT_NULL;
//  513         return (0);
//  514     }
//  515 #endif
//  516     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {          /* Validate event block type                */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+2
        BEQ.N    ??OSQPendAbort_0
//  517         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        B.N      ?Subroutine1
//  518         return (0);
//  519     }
//  520     OS_ENTER_CRITICAL();
??OSQPendAbort_0:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  521     if (pevent->OSEventGrp != 0) {                         /* See if any task waiting on queue?        */
        LDRB     R0,[R4, #+10]
        CBZ      R0,??OSQPendAbort_1
//  522         nbr_tasks = 0;
        MOVS     R7,#+0
//  523         switch (opt) {
        CMP      R6,#+1
        BNE.N    ??OSQPendAbort_2
//  524             case OS_PEND_OPT_BROADCAST:                    /* Do we need to abort ALL waiting tasks?   */
//  525                  while (pevent->OSEventGrp != 0) {         /* Yes, ready ALL tasks waiting on queue    */
//  526                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
??OSQPendAbort_3:
        MOVS     R3,#+2
        MOVS     R2,#+4
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  527                      nbr_tasks++;
        ADDS     R7,R7,#+1
        UXTB     R7,R7
        LDRB     R0,[R4, #+10]
        CBZ      R0,??OSQPendAbort_4
        B.N      ??OSQPendAbort_3
//  528                  }
//  529                  break;
//  530                
//  531             case OS_PEND_OPT_NONE:                         /* No,  ready HPT       waiting on queue    */
//  532             default:   
//  533                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
??OSQPendAbort_2:
        MOVS     R3,#+2
        MOVS     R2,#+4
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  534                  nbr_tasks++;
        MOVS     R7,#+1
//  535                  break;
//  536         }
//  537         OS_EXIT_CRITICAL();
??OSQPendAbort_4:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  538         OS_Sched();                                        /* Find HPT ready to run                    */
        BL       OS_Sched
//  539         *perr = OS_ERR_PEND_ABORT;
        MOVS     R0,#+14
        STRB     R0,[R5, #+0]
//  540         return (nbr_tasks);
        B.N      ?Subroutine2
//  541     }
//  542     OS_EXIT_CRITICAL();
??OSQPendAbort_1:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  543     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  544     return (0);                                            /* No tasks waiting on queue                */
        POP      {R4-R8,PC}       ;; return
//  545 }
//  546 #endif
//  547 
//  548 /*$PAGE*/
//  549 /*
//  550 *********************************************************************************************************
//  551 *                                        POST MESSAGE TO A QUEUE
//  552 *
//  553 * Description: This function sends a message to a queue
//  554 *
//  555 * Arguments  : pevent        is a pointer to the event control block associated with the desired queue
//  556 *
//  557 *              pmsg          is a pointer to the message to send.
//  558 *
//  559 * Returns    : OS_ERR_NONE           The call was successful and the message was sent
//  560 *              OS_ERR_Q_FULL         If the queue cannot accept any more messages because it is full.
//  561 *              OS_ERR_EVENT_TYPE     If you didn't pass a pointer to a queue.
//  562 *              OS_ERR_PEVENT_NULL    If 'pevent' is a NULL pointer
//  563 *
//  564 * Note(s)    : As of V2.60, this function allows you to send NULL pointer messages.
//  565 *********************************************************************************************************
//  566 */
//  567 
//  568 #if OS_Q_POST_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  569 INT8U  OSQPost (OS_EVENT *pevent, void *pmsg)
//  570 {
OSQPost:
        PUSH     {R4-R6,LR}
        MOV      R6,R0
        MOV      R4,R1
//  571     OS_Q      *pq;
//  572 #if OS_CRITICAL_METHOD == 3                            /* Allocate storage for CPU status register     */
//  573     OS_CPU_SR  cpu_sr = 0;
//  574 #endif
//  575 
//  576 
//  577 
//  578 #if OS_ARG_CHK_EN > 0
//  579     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
//  580         return (OS_ERR_PEVENT_NULL);
//  581     }
//  582 #endif
//  583     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {      /* Validate event block type                    */
        LDRB     R0,[R6, #+0]
        CMP      R0,#+2
        BEQ.N    ??OSQPost_0
//  584         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R4-R6,PC}
//  585     }
//  586     OS_ENTER_CRITICAL();
??OSQPost_0:
        BL       OS_CPU_SR_Save
        MOV      R5,R0
//  587     if (pevent->OSEventGrp != 0) {                     /* See if any task pending on queue             */
        LDRB     R0,[R6, #+10]
        CBZ      R0,??OSQPost_1
//  588                                                        /* Ready highest priority task waiting on event */
//  589         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
        MOVS     R3,#+0
        MOVS     R2,#+4
        MOV      R1,R4
        MOV      R0,R6
        BL       OS_EventTaskRdy
//  590         OS_EXIT_CRITICAL();
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  591         OS_Sched();                                    /* Find highest priority task ready to run      */
        BL       OS_Sched
//  592         return (OS_ERR_NONE);
        B.N      ??OSQPost_2
//  593     }
//  594     pq = (OS_Q *)pevent->OSEventPtr;                   /* Point to queue control block                 */
??OSQPost_1:
        LDR      R0,[R6, #+4]
//  595     if (pq->OSQEntries >= pq->OSQSize) {               /* Make sure queue is not full                  */
        LDRH     R1,[R0, #+22]
        LDRH     R2,[R0, #+20]
        CMP      R1,R2
        BCC.N    ??OSQPost_3
//  596         OS_EXIT_CRITICAL();
        B.N      ?Subroutine3
//  597         return (OS_ERR_Q_FULL);
//  598     }
//  599     *pq->OSQIn++ = pmsg;                               /* Insert message into queue                    */
??OSQPost_3:
        LDR      R3,[R0, #+12]
        ADDS     R2,R3,#+4
        STR      R2,[R0, #+12]
        STR      R4,[R3, #+0]
//  600     pq->OSQEntries++;                                  /* Update the nbr of entries in the queue       */
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+22]
//  601     if (pq->OSQIn == pq->OSQEnd) {                     /* Wrap IN ptr if we are at end of queue        */
        LDR      R1,[R0, #+12]
        LDR      R2,[R0, #+8]
        CMP      R1,R2
        BNE.N    ??OSQPost_4
//  602         pq->OSQIn = pq->OSQStart;
        LDR      R1,[R0, #+4]
        STR      R1,[R0, #+12]
//  603     }
//  604     OS_EXIT_CRITICAL();
??OSQPost_4:
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  605     return (OS_ERR_NONE);
??OSQPost_2:
        MOVS     R0,#+0
        POP      {R4-R6,PC}       ;; return
//  606 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine3:
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
        MOVS     R0,#+30
        POP      {R4-R6,PC}
//  607 #endif
//  608 /*$PAGE*/
//  609 /*
//  610 *********************************************************************************************************
//  611 *                                   POST MESSAGE TO THE FRONT OF A QUEUE
//  612 *
//  613 * Description: This function sends a message to a queue but unlike OSQPost(), the message is posted at
//  614 *              the front instead of the end of the queue.  Using OSQPostFront() allows you to send
//  615 *              'priority' messages.
//  616 *
//  617 * Arguments  : pevent        is a pointer to the event control block associated with the desired queue
//  618 *
//  619 *              pmsg          is a pointer to the message to send.
//  620 *
//  621 * Returns    : OS_ERR_NONE           The call was successful and the message was sent
//  622 *              OS_ERR_Q_FULL         If the queue cannot accept any more messages because it is full.
//  623 *              OS_ERR_EVENT_TYPE     If you didn't pass a pointer to a queue.
//  624 *              OS_ERR_PEVENT_NULL    If 'pevent' is a NULL pointer
//  625 *
//  626 * Note(s)    : As of V2.60, this function allows you to send NULL pointer messages.
//  627 *********************************************************************************************************
//  628 */
//  629 
//  630 #if OS_Q_POST_FRONT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  631 INT8U  OSQPostFront (OS_EVENT *pevent, void *pmsg)
//  632 {
OSQPostFront:
        PUSH     {R4-R6,LR}
        MOV      R6,R0
        MOV      R4,R1
//  633     OS_Q      *pq;
//  634 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  635     OS_CPU_SR  cpu_sr = 0;
//  636 #endif
//  637 
//  638 
//  639 
//  640 #if OS_ARG_CHK_EN > 0
//  641     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  642         return (OS_ERR_PEVENT_NULL);
//  643     }
//  644 #endif
//  645     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
        LDRB     R0,[R6, #+0]
        CMP      R0,#+2
        BEQ.N    ??OSQPostFront_0
//  646         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R4-R6,PC}
//  647     }
//  648     OS_ENTER_CRITICAL();
??OSQPostFront_0:
        BL       OS_CPU_SR_Save
        MOV      R5,R0
//  649     if (pevent->OSEventGrp != 0) {                    /* See if any task pending on queue              */
        LDRB     R0,[R6, #+10]
        CBZ      R0,??OSQPostFront_1
//  650                                                       /* Ready highest priority task waiting on event  */
//  651         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
        MOVS     R3,#+0
        MOVS     R2,#+4
        MOV      R1,R4
        MOV      R0,R6
        BL       OS_EventTaskRdy
//  652         OS_EXIT_CRITICAL();
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  653         OS_Sched();                                   /* Find highest priority task ready to run       */
        BL       OS_Sched
//  654         return (OS_ERR_NONE);
        B.N      ??OSQPostFront_2
//  655     }
//  656     pq = (OS_Q *)pevent->OSEventPtr;                  /* Point to queue control block                  */
??OSQPostFront_1:
        LDR      R0,[R6, #+4]
//  657     if (pq->OSQEntries >= pq->OSQSize) {              /* Make sure queue is not full                   */
        LDRH     R1,[R0, #+22]
        LDRH     R2,[R0, #+20]
        CMP      R1,R2
        BCC.N    ??OSQPostFront_3
//  658         OS_EXIT_CRITICAL();
        B.N      ?Subroutine3
//  659         return (OS_ERR_Q_FULL);
//  660     }
//  661     if (pq->OSQOut == pq->OSQStart) {                 /* Wrap OUT ptr if we are at the 1st queue entry */
??OSQPostFront_3:
        LDR      R2,[R0, #+16]
        LDR      R3,[R0, #+4]
        CMP      R2,R3
        BNE.N    ??OSQPostFront_4
//  662         pq->OSQOut = pq->OSQEnd;
        LDR      R2,[R0, #+8]
        STR      R2,[R0, #+16]
//  663     }
//  664     pq->OSQOut--;
??OSQPostFront_4:
        LDR      R2,[R0, #+16]
        SUBS     R2,R2,#+4
        STR      R2,[R0, #+16]
//  665     *pq->OSQOut = pmsg;                               /* Insert message into queue                     */
        STR      R4,[R2, #+0]
//  666     pq->OSQEntries++;                                 /* Update the nbr of entries in the queue        */
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+22]
//  667     OS_EXIT_CRITICAL();
        MOV      R0,R5
        BL       OS_CPU_SR_Restore
//  668     return (OS_ERR_NONE);
??OSQPostFront_2:
        MOVS     R0,#+0
        POP      {R4-R6,PC}       ;; return
//  669 }
//  670 #endif
//  671 /*$PAGE*/
//  672 /*
//  673 *********************************************************************************************************
//  674 *                                        POST MESSAGE TO A QUEUE
//  675 *
//  676 * Description: This function sends a message to a queue.  This call has been added to reduce code size
//  677 *              since it can replace both OSQPost() and OSQPostFront().  Also, this function adds the
//  678 *              capability to broadcast a message to ALL tasks waiting on the message queue.
//  679 *
//  680 * Arguments  : pevent        is a pointer to the event control block associated with the desired queue
//  681 *
//  682 *              pmsg          is a pointer to the message to send.
//  683 *
//  684 *              opt           determines the type of POST performed:
//  685 *                            OS_POST_OPT_NONE         POST to a single waiting task
//  686 *                                                     (Identical to OSQPost())
//  687 *                            OS_POST_OPT_BROADCAST    POST to ALL tasks that are waiting on the queue
//  688 *                            OS_POST_OPT_FRONT        POST as LIFO (Simulates OSQPostFront())
//  689 *                            OS_POST_OPT_NO_SCHED     Indicates that the scheduler will NOT be invoked
//  690 *
//  691 * Returns    : OS_ERR_NONE           The call was successful and the message was sent
//  692 *              OS_ERR_Q_FULL         If the queue cannot accept any more messages because it is full.
//  693 *              OS_ERR_EVENT_TYPE     If you didn't pass a pointer to a queue.
//  694 *              OS_ERR_PEVENT_NULL    If 'pevent' is a NULL pointer
//  695 *
//  696 * Warning    : Interrupts can be disabled for a long time if you do a 'broadcast'.  In fact, the
//  697 *              interrupt disable time is proportional to the number of tasks waiting on the queue.
//  698 *********************************************************************************************************
//  699 */
//  700 
//  701 #if OS_Q_POST_OPT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  702 INT8U  OSQPostOpt (OS_EVENT *pevent, void *pmsg, INT8U opt)
//  703 {
OSQPostOpt:
        PUSH     {R3-R7,LR}
        MOV      R7,R0
        MOV      R4,R1
        MOV      R5,R2
//  704     OS_Q      *pq;
//  705 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  706     OS_CPU_SR  cpu_sr = 0;
//  707 #endif
//  708 
//  709 
//  710 
//  711 #if OS_ARG_CHK_EN > 0
//  712     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  713         return (OS_ERR_PEVENT_NULL);
//  714     }
//  715 #endif
//  716     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
        LDRB     R0,[R7, #+0]
        CMP      R0,#+2
        BEQ.N    ??OSQPostOpt_0
//  717         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R1,R4-R7,PC}
//  718     }
//  719     OS_ENTER_CRITICAL();
??OSQPostOpt_0:
        BL       OS_CPU_SR_Save
        MOV      R6,R0
//  720     if (pevent->OSEventGrp != 0x00) {                 /* See if any task pending on queue              */
        LDRB     R0,[R7, #+10]
        CBZ      R0,??OSQPostOpt_1
//  721         if ((opt & OS_POST_OPT_BROADCAST) != 0x00) {  /* Do we need to post msg to ALL waiting tasks ? */
        TST      R5,#0x1
        BEQ.N    ??OSQPostOpt_2
//  722             while (pevent->OSEventGrp != 0) {         /* Yes, Post to ALL tasks waiting on queue       */
//  723                 (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
??OSQPostOpt_3:
        MOVS     R3,#+0
        MOVS     R2,#+4
        MOV      R1,R4
        MOV      R0,R7
        BL       OS_EventTaskRdy
        LDRB     R0,[R7, #+10]
        CBZ      R0,??OSQPostOpt_4
        B.N      ??OSQPostOpt_3
//  724             }
//  725         } else {                                      /* No,  Post to HPT waiting on queue             */
//  726             (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
??OSQPostOpt_2:
        MOVS     R3,#+0
        MOVS     R2,#+4
        MOV      R1,R4
        MOV      R0,R7
        BL       OS_EventTaskRdy
//  727         }
//  728         OS_EXIT_CRITICAL();
??OSQPostOpt_4:
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
//  729         if ((opt & OS_POST_OPT_NO_SCHED) == 0) {	  /* See if scheduler needs to be invoked          */
        TST      R5,#0x4
        BNE.N    ??OSQPostOpt_5
//  730             OS_Sched();                               /* Find highest priority task ready to run       */
        BL       OS_Sched
//  731         }
//  732         return (OS_ERR_NONE);
        B.N      ??OSQPostOpt_5
//  733     }
//  734     pq = (OS_Q *)pevent->OSEventPtr;                  /* Point to queue control block                  */
??OSQPostOpt_1:
        LDR      R0,[R7, #+4]
//  735     if (pq->OSQEntries >= pq->OSQSize) {              /* Make sure queue is not full                   */
        LDRH     R1,[R0, #+22]
        LDRH     R2,[R0, #+20]
        CMP      R1,R2
        BCC.N    ??OSQPostOpt_6
//  736         OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
//  737         return (OS_ERR_Q_FULL);
        MOVS     R0,#+30
        POP      {R1,R4-R7,PC}
//  738     }
//  739     if ((opt & OS_POST_OPT_FRONT) != 0x00) {          /* Do we post to the FRONT of the queue?         */
??OSQPostOpt_6:
        TST      R5,#0x2
        BEQ.N    ??OSQPostOpt_7
//  740         if (pq->OSQOut == pq->OSQStart) {             /* Yes, Post as LIFO, Wrap OUT pointer if we ... */
        LDR      R2,[R0, #+16]
        LDR      R3,[R0, #+4]
        CMP      R2,R3
        BNE.N    ??OSQPostOpt_8
//  741             pq->OSQOut = pq->OSQEnd;                  /*      ... are at the 1st queue entry           */
        LDR      R2,[R0, #+8]
        STR      R2,[R0, #+16]
//  742         }
//  743         pq->OSQOut--;
??OSQPostOpt_8:
        LDR      R2,[R0, #+16]
        SUBS     R2,R2,#+4
        STR      R2,[R0, #+16]
//  744         *pq->OSQOut = pmsg;                           /*      Insert message into queue                */
        STR      R4,[R2, #+0]
        B.N      ??OSQPostOpt_9
//  745     } else {                                          /* No,  Post as FIFO                             */
//  746         *pq->OSQIn++ = pmsg;                          /*      Insert message into queue                */
??OSQPostOpt_7:
        LDR      R3,[R0, #+12]
        ADDS     R2,R3,#+4
        STR      R2,[R0, #+12]
        STR      R4,[R3, #+0]
//  747         if (pq->OSQIn == pq->OSQEnd) {                /*      Wrap IN ptr if we are at end of queue    */
        LDR      R2,[R0, #+12]
        LDR      R3,[R0, #+8]
        CMP      R2,R3
        BNE.N    ??OSQPostOpt_9
//  748             pq->OSQIn = pq->OSQStart;
        LDR      R2,[R0, #+4]
        STR      R2,[R0, #+12]
//  749         }
//  750     }
//  751     pq->OSQEntries++;                                 /* Update the nbr of entries in the queue        */
??OSQPostOpt_9:
        ADDS     R1,R1,#+1
        STRH     R1,[R0, #+22]
//  752     OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
//  753     return (OS_ERR_NONE);
??OSQPostOpt_5:
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}    ;; return
//  754 }
//  755 #endif
//  756 /*$PAGE*/
//  757 /*
//  758 *********************************************************************************************************
//  759 *                                        QUERY A MESSAGE QUEUE
//  760 *
//  761 * Description: This function obtains information about a message queue.
//  762 *
//  763 * Arguments  : pevent        is a pointer to the event control block associated with the desired queue
//  764 *
//  765 *              p_q_data      is a pointer to a structure that will contain information about the message
//  766 *                            queue.
//  767 *
//  768 * Returns    : OS_ERR_NONE         The call was successful and the message was sent
//  769 *              OS_ERR_EVENT_TYPE   If you are attempting to obtain data from a non queue.
//  770 *              OS_ERR_PEVENT_NULL  If 'pevent'   is a NULL pointer
//  771 *              OS_ERR_PDATA_NULL   If 'p_q_data' is a NULL pointer
//  772 *********************************************************************************************************
//  773 */
//  774 
//  775 #if OS_Q_QUERY_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  776 INT8U  OSQQuery (OS_EVENT *pevent, OS_Q_DATA *p_q_data)
//  777 {
OSQQuery:
        PUSH     {R3-R5,LR}
        MOV      R5,R0
        MOV      R4,R1
//  778     OS_Q      *pq;
//  779     INT8U      i;
//  780 #if OS_LOWEST_PRIO <= 63
//  781     INT8U     *psrc;
//  782     INT8U     *pdest;
//  783 #else
//  784     INT16U    *psrc;
//  785     INT16U    *pdest;
//  786 #endif
//  787 #if OS_CRITICAL_METHOD == 3                            /* Allocate storage for CPU status register     */
//  788     OS_CPU_SR  cpu_sr = 0;
//  789 #endif
//  790 
//  791 
//  792 
//  793 #if OS_ARG_CHK_EN > 0
//  794     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
//  795         return (OS_ERR_PEVENT_NULL);
//  796     }
//  797     if (p_q_data == (OS_Q_DATA *)0) {                  /* Validate 'p_q_data'                          */
//  798         return (OS_ERR_PDATA_NULL);
//  799     }
//  800 #endif
//  801     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {      /* Validate event block type                    */
        LDRB     R0,[R5, #+0]
        CMP      R0,#+2
        BEQ.N    ??OSQQuery_0
//  802         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}
//  803     }
//  804     OS_ENTER_CRITICAL();
??OSQQuery_0:
        BL       OS_CPU_SR_Save
//  805     p_q_data->OSEventGrp = pevent->OSEventGrp;         /* Copy message queue wait list                 */
        LDRB     R1,[R5, #+10]
        STRB     R1,[R4, #+12]
//  806     psrc                 = &pevent->OSEventTbl[0];
        ADD      R1,R5,#+11
//  807     pdest                = &p_q_data->OSEventTbl[0];
        ADD      R2,R4,#+8
//  808     for (i = 0; i < OS_EVENT_TBL_SIZE; i++) {
//  809         *pdest++ = *psrc++;
        LDRB     R3,[R1, #+0]
        STRB     R3,[R2, #+0]
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
//  810     }
//  811     pq = (OS_Q *)pevent->OSEventPtr;
        LDR      R1,[R5, #+4]
//  812     if (pq->OSQEntries > 0) {
        LDRH     R2,[R1, #+22]
        CMP      R2,#+0
        ITTE     NE 
        LDRNE    R3,[R1, #+16]
        LDRNE    R3,[R3, #+0]
        MOVEQ    R3,#+0
//  813         p_q_data->OSMsg = *pq->OSQOut;                 /* Get next message to return if available      */
//  814     } else {
//  815         p_q_data->OSMsg = (void *)0;
        STR      R3,[R4, #+0]
//  816     }
//  817     p_q_data->OSNMsgs = pq->OSQEntries;
        STRH     R2,[R4, #+4]
//  818     p_q_data->OSQSize = pq->OSQSize;
        LDRH     R1,[R1, #+20]
        STRH     R1,[R4, #+6]
//  819     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  820     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  821 }
//  822 #endif                                                 /* OS_Q_QUERY_EN                                */
//  823 
//  824 /*$PAGE*/
//  825 /*
//  826 *********************************************************************************************************
//  827 *                                      QUEUE MODULE INITIALIZATION
//  828 *
//  829 * Description : This function is called by uC/OS-II to initialize the message queue module.  Your
//  830 *               application MUST NOT call this function.
//  831 *
//  832 * Arguments   :  none
//  833 *
//  834 * Returns     : none
//  835 *
//  836 * Note(s)    : This function is INTERNAL to uC/OS-II and your application should not call it.
//  837 *********************************************************************************************************
//  838 */
//  839 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  840 void  OS_QInit (void)
//  841 {
OS_QInit:
        PUSH     {R4,LR}
//  842 #if OS_MAX_QS == 1
//  843     OSQFreeList         = &OSQTbl[0];                /* Only ONE queue!                                */
//  844     OSQFreeList->OSQPtr = (OS_Q *)0;
//  845 #endif
//  846 
//  847 #if OS_MAX_QS >= 2
//  848     INT16U  i;
//  849     OS_Q   *pq1;
//  850     OS_Q   *pq2;
//  851 
//  852 
//  853 
//  854     OS_MemClr((INT8U *)&OSQTbl[0], sizeof(OSQTbl));  /* Clear the queue table                          */
        LDR.N    R4,??OS_QInit_0  ;; OSQTbl
        MOVS     R1,#+96
        MOV      R0,R4
        BL       OS_MemClr
//  855     pq1 = &OSQTbl[0];
//  856     pq2 = &OSQTbl[1];
//  857     for (i = 0; i < (OS_MAX_QS - 1); i++) {          /* Init. list of free QUEUE control blocks        */
//  858         pq1->OSQPtr = pq2;
        ADD      R0,R4,#+24
        STR      R0,[R4, #+0]
//  859         pq1++;
//  860         pq2++;
        ADD      R0,R4,#+48
        STR      R0,[R4, #+24]
        ADD      R0,R4,#+72
        STR      R0,[R4, #+48]
//  861     }
//  862     pq1->OSQPtr = (OS_Q *)0;
        MOVS     R0,#+0
        STR      R0,[R4, #+72]
//  863     OSQFreeList = &OSQTbl[0];
        LDR.N    R0,??DataTable9  ;; OSQFreeList
        STR      R4,[R0, #+0]
//  864 #endif
//  865 }
        POP      {R4,PC}          ;; return
        DATA
??OS_QInit_0:
        DC32     OSQTbl

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable9:
        DC32     OSQFreeList

        END
//  866 #endif                                               /* OS_Q_EN                                        */
// 
// 1 220 bytes in section .text
// 
// 1 220 bytes of CODE memory
//
//Errors: none
//Warnings: none
