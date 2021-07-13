///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:36 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_mutex.c                                        /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_mutex.c -D OS_INCLUDED -D APPL_SRC -lcN        /
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
//    List file    =  C:\user\project\stm32\fw\stm207_ucos_20120825\sout\os_m /
//                    utex.s                                                  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_mutex

        #define SHT_PROGBITS 0x1

        EXTERN OSEventFreeList
        EXTERN OSIntNesting
        EXTERN OSLockNesting
        EXTERN OSRdyGrp
        EXTERN OSRdyTbl
        EXTERN OSTCBCur
        EXTERN OSTCBPrioTbl
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_EventTOAbort
        EXTERN OS_EventTaskRdy
        EXTERN OS_EventTaskWait
        EXTERN OS_EventWaitListInit
        EXTERN OS_Sched

        PUBLIC OSMutexAccept
        PUBLIC OSMutexCreate
        PUBLIC OSMutexDel
        PUBLIC OSMutexPend
        PUBLIC OSMutexPost
        PUBLIC OSMutexQuery

// C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\Source\os_mutex.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                  MUTUAL EXCLUSION SEMAPHORE MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_MUTEX.C
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
//   29 
//   30 #if OS_MUTEX_EN > 0
//   31 /*
//   32 *********************************************************************************************************
//   33 *                                            LOCAL CONSTANTS
//   34 *********************************************************************************************************
//   35 */
//   36 
//   37 #define  OS_MUTEX_KEEP_LOWER_8   (INT16U)0x00FFu
//   38 #define  OS_MUTEX_KEEP_UPPER_8   (INT16U)0xFF00u
//   39 
//   40 #define  OS_MUTEX_AVAILABLE      (INT16U)0x00FFu
//   41 
//   42 /*
//   43 *********************************************************************************************************
//   44 *                                            LOCAL CONSTANTS
//   45 *********************************************************************************************************
//   46 */
//   47 
//   48 static  void  OSMutex_RdyAtPrio(OS_TCB *ptcb, INT8U prio);
//   49 
//   50 /*$PAGE*/
//   51 /*
//   52 *********************************************************************************************************
//   53 *                                   ACCEPT MUTUAL EXCLUSION SEMAPHORE
//   54 *
//   55 * Description: This  function checks the mutual exclusion semaphore to see if a resource is available.
//   56 *              Unlike OSMutexPend(), OSMutexAccept() does not suspend the calling task if the resource is
//   57 *              not available or the event did not occur.
//   58 *
//   59 * Arguments  : pevent     is a pointer to the event control block
//   60 *
//   61 *              perr       is a pointer to an error code which will be returned to your application:
//   62 *                            OS_ERR_NONE         if the call was successful.
//   63 *                            OS_ERR_EVENT_TYPE   if 'pevent' is not a pointer to a mutex
//   64 *                            OS_ERR_PEVENT_NULL  'pevent' is a NULL pointer
//   65 *                            OS_ERR_PEND_ISR     if you called this function from an ISR
//   66 *                            OS_ERR_PIP_LOWER    If the priority of the task that owns the Mutex is
//   67 *                                                HIGHER (i.e. a lower number) than the PIP.  This error
//   68 *                                                indicates that you did not set the PIP higher (lower
//   69 *                                                number) than ALL the tasks that compete for the Mutex.
//   70 *                                                Unfortunately, this is something that could not be
//   71 *                                                detected when the Mutex is created because we don't know
//   72 *                                                what tasks will be using the Mutex.
//   73 *
//   74 * Returns    : == OS_TRUE    if the resource is available, the mutual exclusion semaphore is acquired
//   75 *              == OS_FALSE   a) if the resource is not available
//   76 *                            b) you didn't pass a pointer to a mutual exclusion semaphore
//   77 *                            c) you called this function from an ISR
//   78 *
//   79 * Warning(s) : This function CANNOT be called from an ISR because mutual exclusion semaphores are
//   80 *              intended to be used by tasks only.
//   81 *********************************************************************************************************
//   82 */
//   83 
//   84 #if OS_MUTEX_ACCEPT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   85 BOOLEAN  OSMutexAccept (OS_EVENT *pevent, INT8U *perr)
//   86 {
OSMutexAccept:
        PUSH     {R4-R6,LR}
        MOV      R5,R0
        MOV      R4,R1
//   87     INT8U      pip;                                    /* Priority Inheritance Priority (PIP)          */
//   88 #if OS_CRITICAL_METHOD == 3                            /* Allocate storage for CPU status register     */
//   89     OS_CPU_SR  cpu_sr = 0;
//   90 #endif
//   91 
//   92 
//   93 
//   94 #if OS_ARG_CHK_EN > 0
//   95     if (perr == (INT8U *)0) {                          /* Validate 'perr'                              */
//   96         return (OS_FALSE);
//   97     }
//   98     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
//   99         *perr = OS_ERR_PEVENT_NULL;
//  100         return (OS_FALSE);
//  101     }
//  102 #endif
//  103     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {  /* Validate event block type                    */
        LDRB     R0,[R5, #+0]
        CMP      R0,#+4
        BEQ.N    ??OSMutexAccept_0
//  104         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
??OSMutexAccept_1:
        STRB     R0,[R4, #+0]
//  105         return (OS_FALSE);
        MOVS     R0,#+0
        POP      {R4-R6,PC}
//  106     }
//  107     if (OSIntNesting > 0) {                            /* Make sure it's not called from an ISR        */
??OSMutexAccept_0:
        LDR.W    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        IT       NE 
        MOVNE    R0,#+2
//  108         *perr = OS_ERR_PEND_ISR;
        BNE.N    ??OSMutexAccept_1
//  109         return (OS_FALSE);
//  110     }
//  111     OS_ENTER_CRITICAL();                               /* Get value (0 or 1) of Mutex                  */
        BL       OS_CPU_SR_Save
//  112     pip = (INT8U)(pevent->OSEventCnt >> 8);            /* Get PIP from mutex                           */
        LDRH     R1,[R5, #+8]
        LSRS     R2,R1,#+8
//  113     if ((pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8) == OS_MUTEX_AVAILABLE) {
        UXTB     R1,R1
        CMP      R1,#+255
        BNE.N    ??OSMutexAccept_2
//  114         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;   /*      Mask off LSByte (Acquire Mutex)         */
        LDRH     R1,[R5, #+8]
        AND      R1,R1,#0xFF00
        STRH     R1,[R5, #+8]
//  115         pevent->OSEventCnt |= OSTCBCur->OSTCBPrio;     /*      Save current task priority in LSByte    */
        LDR.W    R3,??DataTable5_1
        LDR      R3,[R3, #+0]
        LDRB     R6,[R3, #+30]
        ORRS     R1,R6,R1
        STRH     R1,[R5, #+8]
//  116         pevent->OSEventPtr  = (void *)OSTCBCur;        /*      Link TCB of task owning Mutex           */
        STR      R3,[R5, #+4]
//  117         if (OSTCBCur->OSTCBPrio <= pip) {              /*      PIP 'must' have a SMALLER prio ...      */
        LDRB     R1,[R3, #+30]
        CMP      R2,R1
        BCC.N    ??OSMutexAccept_3
//  118             OS_EXIT_CRITICAL();                        /*      ... than current task!                  */
        BL       OS_CPU_SR_Restore
//  119             *perr = OS_ERR_PIP_LOWER;
        MOVS     R0,#+120
        B.N      ??OSMutexAccept_4
//  120         } else {
//  121             OS_EXIT_CRITICAL();
??OSMutexAccept_3:
        BL       OS_CPU_SR_Restore
//  122             *perr = OS_ERR_NONE;
        MOVS     R0,#+0
??OSMutexAccept_4:
        STRB     R0,[R4, #+0]
//  123         }
//  124         return (OS_TRUE);
        MOVS     R0,#+1
        POP      {R4-R6,PC}
//  125     }
//  126     OS_EXIT_CRITICAL();
??OSMutexAccept_2:
        BL       OS_CPU_SR_Restore
//  127     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  128     return (OS_FALSE);
        POP      {R4-R6,PC}       ;; return
//  129 }
//  130 #endif
//  131 
//  132 /*$PAGE*/
//  133 /*
//  134 *********************************************************************************************************
//  135 *                                  CREATE A MUTUAL EXCLUSION SEMAPHORE
//  136 *
//  137 * Description: This function creates a mutual exclusion semaphore.
//  138 *
//  139 * Arguments  : prio          is the priority to use when accessing the mutual exclusion semaphore.  In
//  140 *                            other words, when the semaphore is acquired and a higher priority task
//  141 *                            attempts to obtain the semaphore then the priority of the task owning the
//  142 *                            semaphore is raised to this priority.  It is assumed that you will specify
//  143 *                            a priority that is LOWER in value than ANY of the tasks competing for the
//  144 *                            mutex.
//  145 *
//  146 *              perr          is a pointer to an error code which will be returned to your application:
//  147 *                               OS_ERR_NONE         if the call was successful.
//  148 *                               OS_ERR_CREATE_ISR   if you attempted to create a MUTEX from an ISR
//  149 *                               OS_ERR_PRIO_EXIST   if a task at the priority inheritance priority
//  150 *                                                   already exist.
//  151 *                               OS_ERR_PEVENT_NULL  No more event control blocks available.
//  152 *                               OS_ERR_PRIO_INVALID if the priority you specify is higher that the
//  153 *                                                   maximum allowed (i.e. > OS_LOWEST_PRIO)
//  154 *
//  155 * Returns    : != (void *)0  is a pointer to the event control clock (OS_EVENT) associated with the
//  156 *                            created mutex.
//  157 *              == (void *)0  if an error is detected.
//  158 *
//  159 * Note(s)    : 1) The LEAST significant 8 bits of '.OSEventCnt' are used to hold the priority number
//  160 *                 of the task owning the mutex or 0xFF if no task owns the mutex.
//  161 *
//  162 *              2) The MOST  significant 8 bits of '.OSEventCnt' are used to hold the priority number
//  163 *                 to use to reduce priority inversion.
//  164 *********************************************************************************************************
//  165 */
//  166 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  167 OS_EVENT  *OSMutexCreate (INT8U prio, INT8U *perr)
//  168 {
OSMutexCreate:
        PUSH     {R3-R7,LR}
        MOV      R4,R0
        MOV      R5,R1
//  169     OS_EVENT  *pevent;
//  170 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  171     OS_CPU_SR  cpu_sr = 0;
//  172 #endif
//  173 
//  174 
//  175 
//  176 #if OS_ARG_CHK_EN > 0
//  177     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  178         return ((OS_EVENT *)0);
//  179     }
//  180     if (prio >= OS_LOWEST_PRIO) {                          /* Validate PIP                             */
//  181         *perr = OS_ERR_PRIO_INVALID;
//  182         return ((OS_EVENT *)0);
//  183     }
//  184 #endif
//  185     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
        LDR.W    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSMutexCreate_0
//  186         *perr = OS_ERR_CREATE_ISR;                         /* ... can't CREATE mutex from an ISR       */
        MOVS     R0,#+16
//  187         return ((OS_EVENT *)0);
//  188     }
??OSMutexCreate_1:
        B.N      ?Subroutine0
//  189     OS_ENTER_CRITICAL();
??OSMutexCreate_0:
        BL       OS_CPU_SR_Save
//  190     if (OSTCBPrioTbl[prio] != (OS_TCB *)0) {               /* Mutex priority must not already exist    */
        MOV      R1,R4
        LDR.W    R2,??DataTable5_2
        LDR      R3,[R2, R1, LSL #+2]
        CBZ.N    R3,??OSMutexCreate_2
//  191         OS_EXIT_CRITICAL();                                /* Task already exist at priority ...       */
        BL       OS_CPU_SR_Restore
//  192         *perr = OS_ERR_PRIO_EXIST;                         /* ... inheritance priority                 */
        MOVS     R0,#+40
        B.N      ??OSMutexCreate_1
//  193         return ((OS_EVENT *)0);
//  194     }
//  195     OSTCBPrioTbl[prio] = OS_TCB_RESERVED;                  /* Reserve the table entry                  */
??OSMutexCreate_2:
        MOVS     R3,#+1
        STR      R3,[R2, R1, LSL #+2]
//  196     pevent             = OSEventFreeList;                  /* Get next free event control block        */
        LDR.W    R3,??DataTable5_3
        LDR      R7,[R3, #+0]
        MOVS     R6,R7
//  197     if (pevent == (OS_EVENT *)0) {                         /* See if an ECB was available              */
        BNE.N    ??OSMutexCreate_3
//  198         OSTCBPrioTbl[prio] = (OS_TCB *)0;                  /* No, Release the table entry              */
        MOVS     R3,#+0
        STR      R3,[R2, R1, LSL #+2]
//  199         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  200         *perr              = OS_ERR_PEVENT_NULL;           /* No more event control blocks             */
        MOVS     R0,#+4
        B.N      ?Subroutine0
//  201         return (pevent);
//  202     }
//  203     OSEventFreeList        = (OS_EVENT *)OSEventFreeList->OSEventPtr;   /* Adjust the free list        */
??OSMutexCreate_3:
        LDR      R1,[R7, #+4]
        STR      R1,[R3, #+0]
//  204     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  205     pevent->OSEventType    = OS_EVENT_TYPE_MUTEX;
        MOVS     R0,#+4
        STRB     R0,[R7, #+0]
//  206     pevent->OSEventCnt     = (INT16U)((INT16U)prio << 8) | OS_MUTEX_AVAILABLE; /* Resource is avail.   */
        LSLS     R0,R4,#+8
        ORR      R0,R0,#0xFF
        STRH     R0,[R7, #+8]
//  207     pevent->OSEventPtr     = (void *)0;                                 /* No task owning the mutex    */
        MOVS     R0,#+0
        STR      R0,[R7, #+4]
//  208 #if OS_EVENT_NAME_SIZE > 1
//  209     pevent->OSEventName[0] = '?';
//  210     pevent->OSEventName[1] = OS_ASCII_NUL;
//  211 #endif
//  212     OS_EventWaitListInit(pevent);
        MOV      R0,R7
        BL       OS_EventWaitListInit
//  213     *perr                  = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  214     return (pevent);
        MOV      R0,R7
        POP      {R1,R4-R7,PC}    ;; return
//  215 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        STRB     R0,[R5, #+0]
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}
//  216 
//  217 /*$PAGE*/
//  218 /*
//  219 *********************************************************************************************************
//  220 *                                          DELETE A MUTEX
//  221 *
//  222 * Description: This function deletes a mutual exclusion semaphore and readies all tasks pending on the it.
//  223 *
//  224 * Arguments  : pevent        is a pointer to the event control block associated with the desired mutex.
//  225 *
//  226 *              opt           determines delete options as follows:
//  227 *                            opt == OS_DEL_NO_PEND   Delete mutex ONLY if no task pending
//  228 *                            opt == OS_DEL_ALWAYS    Deletes the mutex even if tasks are waiting.
//  229 *                                                    In this case, all the tasks pending will be readied.
//  230 *
//  231 *              perr          is a pointer to an error code that can contain one of the following values:
//  232 *                            OS_ERR_NONE             The call was successful and the mutex was deleted
//  233 *                            OS_ERR_DEL_ISR          If you attempted to delete the MUTEX from an ISR
//  234 *                            OS_ERR_INVALID_OPT      An invalid option was specified
//  235 *                            OS_ERR_TASK_WAITING     One or more tasks were waiting on the mutex
//  236 *                            OS_ERR_EVENT_TYPE       If you didn't pass a pointer to a mutex
//  237 *                            OS_ERR_PEVENT_NULL      If 'pevent' is a NULL pointer.
//  238 *
//  239 * Returns    : pevent        upon error
//  240 *              (OS_EVENT *)0 if the mutex was successfully deleted.
//  241 *
//  242 * Note(s)    : 1) This function must be used with care.  Tasks that would normally expect the presence of
//  243 *                 the mutex MUST check the return code of OSMutexPend().
//  244 *
//  245 *              2) This call can potentially disable interrupts for a long time.  The interrupt disable
//  246 *                 time is directly proportional to the number of tasks waiting on the mutex.
//  247 *
//  248 *              3) Because ALL tasks pending on the mutex will be readied, you MUST be careful because the
//  249 *                 resource(s) will no longer be guarded by the mutex.
//  250 *
//  251 *              4) IMPORTANT: In the 'OS_DEL_ALWAYS' case, we assume that the owner of the Mutex (if there
//  252 *                            is one) is ready-to-run and is thus NOT pending on another kernel object or
//  253 *                            has delayed itself.  In other words, if a task owns the mutex being deleted,
//  254 *                            that task will be made ready-to-run at its original priority.
//  255 *********************************************************************************************************
//  256 */
//  257 
//  258 #if OS_MUTEX_DEL_EN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  259 OS_EVENT  *OSMutexDel (OS_EVENT *pevent, INT8U opt, INT8U *perr)
//  260 {
OSMutexDel:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R6,R1
        MOV      R5,R2
//  261     BOOLEAN    tasks_waiting;
//  262     OS_EVENT  *pevent_return;
//  263     INT8U      pip;                                        /* Priority inheritance priority            */
//  264     INT8U      prio;
//  265     OS_TCB    *ptcb;
//  266 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  267     OS_CPU_SR  cpu_sr = 0;
//  268 #endif
//  269 
//  270 
//  271 
//  272 #if OS_ARG_CHK_EN > 0
//  273     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  274         return (pevent);
//  275     }
//  276     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  277         *perr = OS_ERR_PEVENT_NULL;
//  278         return (pevent);
//  279     }
//  280 #endif
//  281     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+4
        BEQ.N    ??OSMutexDel_0
//  282         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
??OSMutexDel_1:
        STRB     R0,[R5, #+0]
//  283         return (pevent);
        MOV      R0,R4
        B.N      ??OSMutexDel_2
//  284     }
//  285     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
??OSMutexDel_0:
        LDR.W    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMutexDel_3
//  286         *perr = OS_ERR_DEL_ISR;                             /* ... can't DELETE from an ISR             */
        MOVS     R0,#+15
        B.N      ??OSMutexDel_1
//  287         return (pevent);
//  288     }
//  289     OS_ENTER_CRITICAL();
??OSMutexDel_3:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  290     if (pevent->OSEventGrp != 0) {                         /* See if any tasks waiting on mutex        */
        LDRB     R0,[R4, #+10]
        SUBS     R7,R0,#+1
        SBCS     R7,R7,R7
        MVNS     R7,R7
        LSRS     R7,R7,#+31
//  291         tasks_waiting = OS_TRUE;                           /* Yes                                      */
//  292     } else {
//  293         tasks_waiting = OS_FALSE;                          /* No                                       */
//  294     }
//  295     switch (opt) {
        CBZ.N    R6,??OSMutexDel_4
        CMP      R6,#+1
        BEQ.N    ??OSMutexDel_5
        B.N      ??OSMutexDel_6
//  296         case OS_DEL_NO_PEND:                               /* DELETE MUTEX ONLY IF NO TASK WAITING --- */
//  297              if (tasks_waiting == OS_FALSE) {
??OSMutexDel_4:
        CBNZ.N   R7,??OSMutexDel_7
//  298 #if OS_EVENT_NAME_SIZE > 1
//  299                  pevent->OSEventName[0] = '?';             /* Unknown name                             */
//  300                  pevent->OSEventName[1] = OS_ASCII_NUL;
//  301 #endif
//  302                  pip                 = (INT8U)(pevent->OSEventCnt >> 8);
//  303                  OSTCBPrioTbl[pip]   = (OS_TCB *)0;        /* Free up the PIP                          */
        LDRH     R0,[R4, #+8]
        LSLS     R0,R0,#+16
        LSRS     R0,R0,#+24
        LDR.W    R1,??DataTable5_2
        MOVS     R2,#+0
        STR      R2,[R1, R0, LSL #+2]
//  304                  pevent->OSEventType = OS_EVENT_TYPE_UNUSED;
        STRB     R2,[R4, #+0]
//  305                  pevent->OSEventPtr  = OSEventFreeList;    /* Return Event Control Block to free list  */
        LDR.W    R0,??DataTable5_3
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  306                  pevent->OSEventCnt  = 0;
        STRH     R2,[R4, #+8]
//  307                  OSEventFreeList     = pevent;
        STR      R4,[R0, #+0]
//  308                  OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  309                  *perr               = OS_ERR_NONE;
??OSMutexDel_8:
        MOVS     R1,#+0
//  310                  pevent_return       = (OS_EVENT *)0;      /* Mutex has been deleted                   */
        MOVS     R0,#+0
        B.N      ??OSMutexDel_9
//  311              } else {
//  312                  OS_EXIT_CRITICAL();
??OSMutexDel_7:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  313                  *perr               = OS_ERR_TASK_WAITING;
        MOVS     R1,#+73
//  314                  pevent_return       = pevent;
        B.N      ??OSMutexDel_10
//  315              }
//  316              break;
//  317 
//  318         case OS_DEL_ALWAYS:                                /* ALWAYS DELETE THE MUTEX ---------------- */
//  319              pip  = (INT8U)(pevent->OSEventCnt >> 8);                     /* Get PIP of mutex          */
//  320              prio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);  /* Get owner's original prio */
??OSMutexDel_5:
        LDRH     R2,[R4, #+8]
        MOV      R0,R2
//  321              ptcb = (OS_TCB *)pevent->OSEventPtr;
        LDR      R1,[R4, #+4]
//  322              if (ptcb != (OS_TCB *)0) {                    /* See if any task owns the mutex           */
        CMP      R1,#+0
        BEQ.N    ??OSMutexDel_11
//  323                  if (ptcb->OSTCBPrio == pip) {             /* See if original prio was changed         */
        LDRB     R3,[R1, #+30]
        CMP      R3,R2, LSR #+8
        BNE.N    ??OSMutexDel_11
//  324                      OSMutex_RdyAtPrio(ptcb, prio);        /* Yes, Restore the task's original prio    */
        LDRB     R3,[R1, #+32]
        LDR.W    R2,??DataTable5_4
        LDRB     R12,[R3, R2]
        LDRB     LR,[R1, #+33]
        BICS     R12,R12,LR
        STRB     R12,[R3, R2]
        LDR.W    R3,??DataTable5_5
        BNE.N    ??OSMutexDel_12
        LDRB     R12,[R3, #+0]
        LDRB     LR,[R1, #+34]
        BIC      R12,R12,LR
        STRB     R12,[R3, #+0]
??OSMutexDel_12:
        STRB     R0,[R1, #+30]
        UBFX     R12,R0,#+3,#+3
        STRB     R12,[R1, #+32]
        AND      LR,R0,#0x7
        STRB     LR,[R1, #+31]
        LSL      R12,R6,R12
        STRB     R12,[R1, #+34]
        LSL      R6,R6,LR
        STRB     R6,[R1, #+33]
        LDRB     R6,[R3, #+0]
        ORR      R6,R12,R6
        STRB     R6,[R3, #+0]
        LDRB     R3,[R1, #+32]
        LDRB     R6,[R3, R2]
        LDRB     LR,[R1, #+33]
        ORR      R6,LR,R6
        STRB     R6,[R3, R2]
        UXTB     R0,R0
        LDR.N    R2,??DataTable5_2
        STR      R1,[R2, R0, LSL #+2]
//  325                  }
//  326              }
//  327              while (pevent->OSEventGrp != 0) {             /* Ready ALL tasks waiting for mutex        */
??OSMutexDel_11:
        LDRB     R0,[R4, #+10]
        CBZ.N    R0,??OSMutexDel_13
//  328                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MUTEX, OS_STAT_PEND_OK);
??OSMutexDel_14:
        MOVS     R3,#+0
        MOVS     R2,#+16
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
        LDRB     R0,[R4, #+10]
        CMP      R0,#+0
        BNE.N    ??OSMutexDel_14
//  329              }
//  330 #if OS_EVENT_NAME_SIZE > 1
//  331              pevent->OSEventName[0] = '?';                 /* Unknown name                             */
//  332              pevent->OSEventName[1] = OS_ASCII_NUL;
//  333 #endif
//  334              pip                 = (INT8U)(pevent->OSEventCnt >> 8);
//  335              OSTCBPrioTbl[pip]   = (OS_TCB *)0;            /* Free up the PIP                          */
??OSMutexDel_13:
        LDRH     R0,[R4, #+8]
        LSLS     R0,R0,#+16
        LSRS     R0,R0,#+24
        LDR.N    R1,??DataTable5_2
        MOVS     R2,#+0
        STR      R2,[R1, R0, LSL #+2]
//  336              pevent->OSEventType = OS_EVENT_TYPE_UNUSED;
        STRB     R2,[R4, #+0]
//  337              pevent->OSEventPtr  = OSEventFreeList;        /* Return Event Control Block to free list  */
        LDR.N    R0,??DataTable5_3
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  338              pevent->OSEventCnt  = 0;
        STRH     R2,[R4, #+8]
//  339              OSEventFreeList     = pevent;                 /* Get next free event control block        */
        STR      R4,[R0, #+0]
//  340              OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  341              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
        CMP      R7,#+0
        BEQ.N    ??OSMutexDel_8
//  342                  OS_Sched();                               /* Find highest priority task ready to run  */
        BL       OS_Sched
//  343              }
//  344              *perr         = OS_ERR_NONE;
        B.N      ??OSMutexDel_8
//  345              pevent_return = (OS_EVENT *)0;                /* Mutex has been deleted                   */
//  346              break;
//  347 
//  348         default:
//  349              OS_EXIT_CRITICAL();
??OSMutexDel_6:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  350              *perr         = OS_ERR_INVALID_OPT;
        MOVS     R1,#+7
//  351              pevent_return = pevent;
??OSMutexDel_10:
        MOV      R0,R4
//  352              break;
??OSMutexDel_9:
        STRB     R1,[R5, #+0]
//  353     }
//  354     return (pevent_return);
??OSMutexDel_2:
        POP      {R4-R8,PC}       ;; return
//  355 }
//  356 #endif
//  357 
//  358 /*$PAGE*/
//  359 /*
//  360 *********************************************************************************************************
//  361 *                                  PEND ON MUTUAL EXCLUSION SEMAPHORE
//  362 *
//  363 * Description: This function waits for a mutual exclusion semaphore.
//  364 *
//  365 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  366 *                            mutex.
//  367 *
//  368 *              timeout       is an optional timeout period (in clock ticks).  If non-zero, your task will
//  369 *                            wait for the resource up to the amount of time specified by this argument.
//  370 *                            If you specify 0, however, your task will wait forever at the specified
//  371 *                            mutex or, until the resource becomes available.
//  372 *
//  373 *              perr          is a pointer to where an error message will be deposited.  Possible error
//  374 *                            messages are:
//  375 *                               OS_ERR_NONE        The call was successful and your task owns the mutex
//  376 *                               OS_ERR_TIMEOUT     The mutex was not available within the specified 'timeout'.
//  377 *                               OS_ERR_PEND_ABORT  The wait on the mutex was aborted.
//  378 *                               OS_ERR_EVENT_TYPE  If you didn't pass a pointer to a mutex
//  379 *                               OS_ERR_PEVENT_NULL 'pevent' is a NULL pointer
//  380 *                               OS_ERR_PEND_ISR    If you called this function from an ISR and the result
//  381 *                                                  would lead to a suspension.
//  382 *                               OS_ERR_PIP_LOWER   If the priority of the task that owns the Mutex is
//  383 *                                                  HIGHER (i.e. a lower number) than the PIP.  This error
//  384 *                                                  indicates that you did not set the PIP higher (lower
//  385 *                                                  number) than ALL the tasks that compete for the Mutex.
//  386 *                                                  Unfortunately, this is something that could not be
//  387 *                                                  detected when the Mutex is created because we don't know
//  388 *                                                  what tasks will be using the Mutex.
//  389 *                               OS_ERR_PEND_LOCKED If you called this function when the scheduler is locked
//  390 *
//  391 * Returns    : none
//  392 *
//  393 * Note(s)    : 1) The task that owns the Mutex MUST NOT pend on any other event while it owns the mutex.
//  394 *
//  395 *              2) You MUST NOT change the priority of the task that owns the mutex
//  396 *********************************************************************************************************
//  397 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  398 void  OSMutexPend (OS_EVENT *pevent, INT16U timeout, INT8U *perr)
//  399 {
OSMutexPend:
        PUSH     {R3-R9,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//  400     INT8U      pip;                                        /* Priority Inheritance Priority (PIP)      */
//  401     INT8U      mprio;                                      /* Mutex owner priority                     */
//  402     BOOLEAN    rdy;                                        /* Flag indicating task was ready           */
//  403     OS_TCB    *ptcb;
//  404     OS_EVENT  *pevent2;
//  405     INT8U      y;
//  406     INT8U      pend_stat;
//  407 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  408     OS_CPU_SR  cpu_sr = 0;
//  409 #endif
//  410 
//  411 
//  412 
//  413 #if OS_ARG_CHK_EN > 0
//  414     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  415         return;
//  416     }
//  417     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  418         *perr = OS_ERR_PEVENT_NULL;
//  419         return;
//  420     }
//  421 #endif
//  422     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+4
        IT       NE 
        MOVNE    R0,#+1
//  423         *perr = OS_ERR_EVENT_TYPE;
        BNE.W    ??OSMutexPend_0
//  424         return;
//  425     }
//  426     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMutexPend_1
//  427         *perr = OS_ERR_PEND_ISR;                           /* ... can't PEND from an ISR               */
        MOVS     R0,#+2
        B.N      ??OSMutexPend_0
//  428         return;
//  429     }
//  430     if (OSLockNesting > 0) {                               /* See if called with scheduler locked ...  */
??OSMutexPend_1:
        LDR.N    R0,??DataTable5_6
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMutexPend_2
//  431         *perr = OS_ERR_PEND_LOCKED;                        /* ... can't PEND when locked               */
        MOVS     R0,#+13
        B.N      ??OSMutexPend_0
//  432         return;
//  433     }
//  434     OS_ENTER_CRITICAL();                                
??OSMutexPend_2:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  435     pip = (INT8U)(pevent->OSEventCnt >> 8);                /* Get PIP from mutex                       */
        LDRH     R0,[R4, #+8]
        LSRS     R1,R0,#+8
//  436                                                            /* Is Mutex available?                      */
//  437     if ((INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8) == OS_MUTEX_AVAILABLE) {
        LDR.N    R7,??DataTable5_1
        UXTB     R2,R0
        CMP      R2,#+255
        BNE.N    ??OSMutexPend_3
//  438         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;       /* Yes, Acquire the resource                */
        AND      R0,R0,#0xFF00
        STRH     R0,[R4, #+8]
//  439         pevent->OSEventCnt |= OSTCBCur->OSTCBPrio;         /*      Save priority of owning task        */
        LDR      R2,[R7, #+0]
        LDRB     R3,[R2, #+30]
        ORRS     R0,R3,R0
        STRH     R0,[R4, #+8]
//  440         pevent->OSEventPtr  = (void *)OSTCBCur;            /*      Point to owning task's OS_TCB       */
        STR      R2,[R4, #+4]
//  441         if (OSTCBCur->OSTCBPrio <= pip) {                  /*      PIP 'must' have a SMALLER prio ...  */
        LDRB     R0,[R2, #+30]
        CMP      R1,R0
        MOV      R0,R8
        BLT.W    ??OSMutexPend_4
//  442             OS_EXIT_CRITICAL();                            /*      ... than current task!              */
        BL       OS_CPU_SR_Restore
//  443             *perr = OS_ERR_PIP_LOWER;
        MOVS     R0,#+120
        B.N      ??OSMutexPend_0
//  444         } else {
//  445             OS_EXIT_CRITICAL();
//  446             *perr = OS_ERR_NONE;
//  447         }
//  448         return;
//  449     }
//  450     mprio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);  /* No, Get priority of mutex owner   */
//  451     ptcb  = (OS_TCB *)(pevent->OSEventPtr);                       /*     Point to TCB of mutex owner   */
??OSMutexPend_3:
        LDR      R2,[R4, #+4]
//  452     if (ptcb->OSTCBPrio > pip) {                                  /*     Need to promote prio of owner?*/
        LDRB     R3,[R2, #+30]
        CMP      R1,R3
        BGE.N    ??OSMutexPend_5
//  453         if (mprio > OSTCBCur->OSTCBPrio) {
        LDR      R3,[R7, #+0]
        LDRB     R3,[R3, #+30]
        UXTB     R0,R0
        CMP      R3,R0
        BCS.N    ??OSMutexPend_5
//  454             y = ptcb->OSTCBY;
        LDRB     LR,[R2, #+32]
//  455             if ((OSRdyTbl[y] & ptcb->OSTCBBitX) != 0) {           /*     See if mutex owner is ready   */
        LDR.N    R3,??DataTable5_4
        LDRB     R9,[LR, R3]
        LDRB     R12,[R2, #+33]
        TST      R9,R12
        BEQ.N    ??OSMutexPend_6
        BICS     R0,R9,R12
        STRB     R0,[LR, R3]
//  456                 OSRdyTbl[y] &= ~ptcb->OSTCBBitX;                  /*     Yes, Remove owner from Rdy ...*/
//  457                 if (OSRdyTbl[y] == 0) {                           /*          ... list at current prio */
        BNE.N    ??OSMutexPend_7
//  458                     OSRdyGrp &= ~ptcb->OSTCBBitY;
        LDR.N    R0,??DataTable5_5
        LDRB     R12,[R0, #+0]
        LDRB     LR,[R2, #+34]
        BIC      R12,R12,LR
        STRB     R12,[R0, #+0]
//  459                 }
//  460                 rdy = OS_TRUE;
??OSMutexPend_7:
        MOVS     R0,#+1
        B.N      ??OSMutexPend_8
//  461             } else {
//  462                 pevent2 = ptcb->OSTCBEventPtr;
??OSMutexPend_6:
        LDR      R0,[R2, #+12]
//  463                 if (pevent2 != (OS_EVENT *)0) {                   /* Remove from event wait list       */
        CBZ.N    R0,??OSMutexPend_9
//  464                     if ((pevent2->OSEventTbl[ptcb->OSTCBY] &= ~ptcb->OSTCBBitX) == 0) {
        ADD      LR,LR,R0
        LDRB     R9,[LR, #+11]
        BIC      R12,R9,R12
        STRB     R12,[LR, #+11]
        LDRB     R12,[R2, #+32]
        ADD      R12,R12,R0
        LDRB     R12,[R12, #+11]
        CMP      R12,#+0
        BNE.N    ??OSMutexPend_9
//  465                         pevent2->OSEventGrp &= ~ptcb->OSTCBBitY;
        LDRB     R12,[R0, #+10]
        LDRB     LR,[R2, #+34]
        BIC      R12,R12,LR
        STRB     R12,[R0, #+10]
//  466                     }
//  467                 }
//  468                 rdy = OS_FALSE;                            /* No                                       */
??OSMutexPend_9:
        MOVS     R0,#+0
//  469             }
//  470             ptcb->OSTCBPrio = pip;                         /* Change owner task prio to PIP            */
??OSMutexPend_8:
        STRB     R1,[R2, #+30]
//  471 #if OS_LOWEST_PRIO <= 63
//  472             ptcb->OSTCBY    = (INT8U)( ptcb->OSTCBPrio >> 3);
        LSR      LR,R1,#+3
        STRB     LR,[R2, #+32]
//  473             ptcb->OSTCBX    = (INT8U)( ptcb->OSTCBPrio & 0x07);
        AND      R12,R1,#0x7
        STRB     R12,[R2, #+31]
//  474             ptcb->OSTCBBitY = (INT8U)(1 << ptcb->OSTCBY);
        MOV      R9,#+1
        LSL      LR,R9,LR
        STRB     LR,[R2, #+34]
//  475             ptcb->OSTCBBitX = (INT8U)(1 << ptcb->OSTCBX);
        LSL      R12,R9,R12
        STRB     R12,[R2, #+33]
//  476 #else
//  477             ptcb->OSTCBY    = (INT8U)((ptcb->OSTCBPrio >> 4) & 0xFF);
//  478             ptcb->OSTCBX    = (INT8U)( ptcb->OSTCBPrio & 0x0F);
//  479             ptcb->OSTCBBitY = (INT16U)(1 << ptcb->OSTCBY);
//  480             ptcb->OSTCBBitX = (INT16U)(1 << ptcb->OSTCBX);
//  481 #endif
//  482             if (rdy == OS_TRUE) {                          /* If task was ready at owner's priority ...*/
        CBZ.N    R0,??OSMutexPend_10
//  483                 OSRdyGrp               |= ptcb->OSTCBBitY; /* ... make it ready at new priority.       */
        LDR.N    R0,??DataTable5_5
        LDRB     R12,[R0, #+0]
        LDRB     LR,[R2, #+34]
        ORR      R12,LR,R12
        STRB     R12,[R0, #+0]
//  484                 OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
        LDRB     R0,[R2, #+32]
        LDRB     R12,[R0, R3]
        LDRB     LR,[R2, #+33]
        ORR      R12,LR,R12
        STRB     R12,[R0, R3]
        B.N      ??OSMutexPend_11
//  485             } else {
//  486                 pevent2 = ptcb->OSTCBEventPtr;
??OSMutexPend_10:
        LDR      R0,[R2, #+12]
//  487                 if (pevent2 != (OS_EVENT *)0) {            /* Add to event wait list                   */
        CBZ.N    R0,??OSMutexPend_11
//  488                     pevent2->OSEventGrp               |= ptcb->OSTCBBitY;
        LDRB     R3,[R0, #+10]
        LDRB     R12,[R2, #+34]
        ORR      R3,R12,R3
        STRB     R3,[R0, #+10]
//  489                     pevent2->OSEventTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
        LDRB     R3,[R2, #+32]
        ADDS     R0,R3,R0
        LDRB     R3,[R0, #+11]
        LDRB     R12,[R2, #+33]
        ORR      R3,R12,R3
        STRB     R3,[R0, #+11]
//  490                 }
//  491             }
//  492             OSTCBPrioTbl[pip] = ptcb;
??OSMutexPend_11:
        LDR.N    R0,??DataTable5_2
        STR      R2,[R0, R1, LSL #+2]
//  493         }
//  494     }
//  495     OSTCBCur->OSTCBStat     |= OS_STAT_MUTEX;         /* Mutex not available, pend current task        */
??OSMutexPend_5:
        LDR      R0,[R7, #+0]
        LDRB     R1,[R0, #+28]
        ORR      R1,R1,#0x10
        STRB     R1,[R0, #+28]
//  496     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
        LDR      R0,[R7, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+29]
//  497     OSTCBCur->OSTCBDly       = timeout;               /* Store timeout in current task's TCB           */
        LDR      R0,[R7, #+0]
        STRH     R5,[R0, #+26]
//  498     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
        MOV      R0,R4
        BL       OS_EventTaskWait
//  499     OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  500     OS_Sched();                                       /* Find next highest priority task ready         */
        BL       OS_Sched
//  501     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  502     if (OSTCBCur->OSTCBStatPend != OS_STAT_PEND_OK) { /* See if we timed out during the pend           */
        LDR      R0,[R7, #+0]
        LDRB     R5,[R0, #+29]
        CBZ.N    R5,??OSMutexPend_12
//  503         pend_stat = OSTCBCur->OSTCBStatPend;
//  504         OS_EventTOAbort(pevent);
        MOV      R0,R4
        BL       OS_EventTOAbort
//  505         OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  506         switch (pend_stat) {
        CMP      R5,#+2
        ITE      EQ 
        MOVEQ    R0,#+14
        MOVNE    R0,#+10
//  507             case OS_STAT_PEND_TO:
//  508             default:
//  509                  *perr = OS_ERR_TIMEOUT;              /* Indicate that we didn't get mutex within TO   */
        B.N      ??OSMutexPend_0
//  510                  break;
//  511 
//  512             case OS_STAT_PEND_ABORT:
//  513                  *perr = OS_ERR_PEND_ABORT;           /* Indicate that we aborted getting mutex        */
//  514                  break;
//  515         }
//  516         return;
//  517     }
//  518     OSTCBCur->OSTCBEventPtr = (OS_EVENT *)0;
??OSMutexPend_12:
        MOVS     R1,#+0
        STR      R1,[R0, #+12]
//  519     OS_EXIT_CRITICAL();
        MOV      R0,R8
??OSMutexPend_4:
        BL       OS_CPU_SR_Restore
//  520     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
??OSMutexPend_0:
        STRB     R0,[R6, #+0]
//  521 }
        POP      {R0,R4-R9,PC}    ;; return
//  522 /*$PAGE*/
//  523 /*
//  524 *********************************************************************************************************
//  525 *                                  POST TO A MUTUAL EXCLUSION SEMAPHORE
//  526 *
//  527 * Description: This function signals a mutual exclusion semaphore
//  528 *
//  529 * Arguments  : pevent              is a pointer to the event control block associated with the desired
//  530 *                                  mutex.
//  531 *
//  532 * Returns    : OS_ERR_NONE             The call was successful and the mutex was signaled.
//  533 *              OS_ERR_EVENT_TYPE       If you didn't pass a pointer to a mutex
//  534 *              OS_ERR_PEVENT_NULL      'pevent' is a NULL pointer
//  535 *              OS_ERR_POST_ISR         Attempted to post from an ISR (not valid for MUTEXes)
//  536 *              OS_ERR_NOT_MUTEX_OWNER  The task that did the post is NOT the owner of the MUTEX.
//  537 *              OS_ERR_PIP_LOWER        If the priority of the new task that owns the Mutex is
//  538 *                                      HIGHER (i.e. a lower number) than the PIP.  This error
//  539 *                                      indicates that you did not set the PIP higher (lower
//  540 *                                      number) than ALL the tasks that compete for the Mutex.
//  541 *                                      Unfortunately, this is something that could not be
//  542 *                                      detected when the Mutex is created because we don't know
//  543 *                                      what tasks will be using the Mutex.
//  544 *********************************************************************************************************
//  545 */
//  546 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  547 INT8U  OSMutexPost (OS_EVENT *pevent)
//  548 {
OSMutexPost:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
//  549     INT8U      pip;                                   /* Priority inheritance priority                 */
//  550     INT8U      prio;
//  551 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  552     OS_CPU_SR  cpu_sr = 0;
//  553 #endif
//  554 
//  555 
//  556 
//  557     if (OSIntNesting > 0) {                           /* See if called from ISR ...                    */
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMutexPost_0
//  558         return (OS_ERR_POST_ISR);                     /* ... can't POST mutex from an ISR              */
        MOVS     R0,#+5
        B.N      ??OSMutexPost_1
//  559     }
//  560 #if OS_ARG_CHK_EN > 0
//  561     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  562         return (OS_ERR_PEVENT_NULL);
//  563     }
//  564 #endif
//  565     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) { /* Validate event block type                     */
??OSMutexPost_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+4
        IT       NE 
        MOVNE    R0,#+1
//  566         return (OS_ERR_EVENT_TYPE);
        BNE.N    ??OSMutexPost_1
//  567     }
//  568     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  569     pip  = (INT8U)(pevent->OSEventCnt >> 8);          /* Get priority inheritance priority of mutex    */
        LDRH     R0,[R4, #+8]
        LSRS     R6,R0,#+8
//  570     prio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);  /* Get owner's original priority      */
        UXTB     R0,R0
//  571     if (OSTCBCur != (OS_TCB *)pevent->OSEventPtr) {   /* See if posting task owns the MUTEX            */
        LDR.N    R1,??DataTable5_1
        LDR      R3,[R1, #+0]
        LDR      R1,[R4, #+4]
        CMP      R3,R1
        BEQ.N    ??OSMutexPost_2
//  572         OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  573         return (OS_ERR_NOT_MUTEX_OWNER);
        MOVS     R0,#+100
        B.N      ??OSMutexPost_1
//  574     }
//  575     if (OSTCBCur->OSTCBPrio == pip) {                 /* Did we have to raise current task's priority? */
??OSMutexPost_2:
        LDRB     R1,[R3, #+30]
        CMP      R1,R6
        BNE.N    ??OSMutexPost_3
//  576         OSMutex_RdyAtPrio(OSTCBCur, prio);            /* Restore the task's original priority          */
        LDRB     R7,[R3, #+32]
        ADD      R1,R3,#+32
        LDR.N    R2,??DataTable5_4
        LDRB     R5,[R7, R2]
        LDRB     LR,[R1, #+1]
        BICS     R5,R5,LR
        STRB     R5,[R7, R2]
        LDR.N    R7,??DataTable5_5
        BNE.N    ??OSMutexPost_4
        LDRB     R5,[R7, #+0]
        LDRB     LR,[R1, #+2]
        BIC      R5,R5,LR
        STRB     R5,[R7, #+0]
??OSMutexPost_4:
        STRB     R0,[R3, #+30]
        UBFX     R12,R0,#+3,#+3
        STRB     R12,[R3, #+32]
        AND      LR,R0,#0x7
        STRB     LR,[R3, #+31]
        MOVS     R5,#+1
        LSL      R12,R5,R12
        STRB     R12,[R1, #+2]
        LSL      R5,R5,LR
        STRB     R5,[R1, #+1]
        LDRB     R5,[R7, #+0]
        ORR      R5,R12,R5
        STRB     R5,[R7, #+0]
        LDRB     R7,[R3, #+32]
        LDRB     R5,[R7, R2]
        LDRB     R1,[R1, #+1]
        ORRS     R1,R1,R5
        STRB     R1,[R7, R2]
        LDR.N    R1,??DataTable5_2
        STR      R3,[R1, R0, LSL #+2]
//  577     }
//  578     OSTCBPrioTbl[pip] = OS_TCB_RESERVED;              /* Reserve table entry                           */
??OSMutexPost_3:
        LDR.N    R7,??DataTable5_2
        MOVS     R0,#+1
        STR      R0,[R7, R6, LSL #+2]
//  579     if (pevent->OSEventGrp != 0) {                    /* Any task waiting for the mutex?               */
        LDRB     R0,[R4, #+10]
        CBZ.N    R0,??OSMutexPost_5
//  580                                                       /* Yes, Make HPT waiting for mutex ready         */
//  581         prio                = OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MUTEX, OS_STAT_PEND_OK);
        MOVS     R3,#+0
        MOVS     R2,#+16
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  582         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;  /*      Save priority of mutex's new owner       */
//  583         pevent->OSEventCnt |= prio;
        LDRH     R2,[R4, #+8]
        BFI      R2,R0,#+0,#+8
        STRH     R2,[R4, #+8]
//  584         pevent->OSEventPtr  = OSTCBPrioTbl[prio];     /*      Link to new mutex owner's OS_TCB         */
        LDR      R1,[R7, R0, LSL #+2]
        STR      R1,[R4, #+4]
//  585         if (prio <= pip) {                            /*      PIP 'must' have a SMALLER prio ...       */
        CMP      R6,R0
        MOV      R0,R8
        BLT.N    ??OSMutexPost_6
//  586             OS_EXIT_CRITICAL();                       /*      ... than current task!                   */
        BL       OS_CPU_SR_Restore
//  587             OS_Sched();                               /*      Find highest priority task ready to run  */
        BL       OS_Sched
//  588             return (OS_ERR_PIP_LOWER);
        MOVS     R0,#+120
        B.N      ??OSMutexPost_1
//  589         } else {
//  590             OS_EXIT_CRITICAL();
??OSMutexPost_6:
        BL       OS_CPU_SR_Restore
//  591             OS_Sched();                               /*      Find highest priority task ready to run  */
        BL       OS_Sched
//  592             return (OS_ERR_NONE);
        B.N      ??OSMutexPost_7
//  593         }
//  594     }
//  595     pevent->OSEventCnt |= OS_MUTEX_AVAILABLE;         /* No,  Mutex is now available                   */
??OSMutexPost_5:
        LDRH     R0,[R4, #+8]
        ORR      R0,R0,#0xFF
        STRH     R0,[R4, #+8]
//  596     pevent->OSEventPtr  = (void *)0;
        MOVS     R0,#+0
        STR      R0,[R4, #+4]
//  597     OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  598     return (OS_ERR_NONE);
??OSMutexPost_7:
        MOVS     R0,#+0
??OSMutexPost_1:
        POP      {R4-R8,PC}       ;; return
//  599 }
//  600 /*$PAGE*/
//  601 /*
//  602 *********************************************************************************************************
//  603 *                                     QUERY A MUTUAL EXCLUSION SEMAPHORE
//  604 *
//  605 * Description: This function obtains information about a mutex
//  606 *
//  607 * Arguments  : pevent          is a pointer to the event control block associated with the desired mutex
//  608 *
//  609 *              p_mutex_data    is a pointer to a structure that will contain information about the mutex
//  610 *
//  611 * Returns    : OS_ERR_NONE          The call was successful and the message was sent
//  612 *              OS_ERR_QUERY_ISR     If you called this function from an ISR
//  613 *              OS_ERR_PEVENT_NULL   If 'pevent'       is a NULL pointer
//  614 *              OS_ERR_PDATA_NULL    If 'p_mutex_data' is a NULL pointer
//  615 *              OS_ERR_EVENT_TYPE    If you are attempting to obtain data from a non mutex.
//  616 *********************************************************************************************************
//  617 */
//  618 
//  619 #if OS_MUTEX_QUERY_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  620 INT8U  OSMutexQuery (OS_EVENT *pevent, OS_MUTEX_DATA *p_mutex_data)
//  621 {
OSMutexQuery:
        PUSH     {R3-R5,LR}
        MOV      R5,R0
        MOV      R4,R1
//  622     INT8U      i;
//  623 #if OS_LOWEST_PRIO <= 63
//  624     INT8U     *psrc;
//  625     INT8U     *pdest;
//  626 #else
//  627     INT16U    *psrc;
//  628     INT16U    *pdest;
//  629 #endif
//  630 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  631     OS_CPU_SR  cpu_sr = 0;
//  632 #endif
//  633 
//  634 
//  635 
//  636     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
        LDR.N    R0,??DataTable5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSMutexQuery_0
//  637         return (OS_ERR_QUERY_ISR);                         /* ... can't QUERY mutex from an ISR        */
        MOVS     R0,#+6
        POP      {R1,R4,R5,PC}
//  638     }
//  639 #if OS_ARG_CHK_EN > 0
//  640     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  641         return (OS_ERR_PEVENT_NULL);
//  642     }
//  643     if (p_mutex_data == (OS_MUTEX_DATA *)0) {              /* Validate 'p_mutex_data'                  */
//  644         return (OS_ERR_PDATA_NULL);
//  645     }
//  646 #endif
//  647     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
??OSMutexQuery_0:
        LDRB     R0,[R5, #+0]
        CMP      R0,#+4
        BEQ.N    ??OSMutexQuery_1
//  648         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}
//  649     }
//  650     OS_ENTER_CRITICAL();
??OSMutexQuery_1:
        BL       OS_CPU_SR_Save
//  651     p_mutex_data->OSMutexPIP  = (INT8U)(pevent->OSEventCnt >> 8);
        LDRH     R1,[R5, #+8]
        LSRS     R1,R1,#+8
        STRB     R1,[R4, #+7]
//  652     p_mutex_data->OSOwnerPrio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);
        LDRH     R1,[R5, #+8]
        STRB     R1,[R4, #+6]
//  653     if (p_mutex_data->OSOwnerPrio == 0xFF) {
        LDRB     R1,[R4, #+6]
        CMP      R1,#+255
        ITE      EQ 
        MOVEQ    R1,#+1
        MOVNE    R1,#+0
//  654         p_mutex_data->OSValue = OS_TRUE;
//  655     } else {
//  656         p_mutex_data->OSValue = OS_FALSE;
        STRB     R1,[R4, #+5]
//  657     }
//  658     p_mutex_data->OSEventGrp  = pevent->OSEventGrp;        /* Copy wait list                           */
        LDRB     R1,[R5, #+10]
        STRB     R1,[R4, #+4]
//  659     psrc                      = &pevent->OSEventTbl[0];
        ADDW     R1,R5,#+11
//  660     pdest                     = &p_mutex_data->OSEventTbl[0];
//  661     for (i = 0; i < OS_EVENT_TBL_SIZE; i++) {
//  662         *pdest++ = *psrc++;
        LDRB     R2,[R1, #+0]
        STRB     R2,[R4, #+0]
        LDRB     R2,[R1, #+1]!
        STRB     R2,[R4, #+1]!
        LDRB     R2,[R1, #+1]!
        STRB     R2,[R4, #+1]!
        LDRB     R2,[R1, #+1]!
        STRB     R2,[R4, #+1]!
//  663     }
//  664     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  665     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  666 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     OSTCBCur

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     OSTCBPrioTbl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     OSEventFreeList

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     OSRdyTbl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     OSRdyGrp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     OSLockNesting

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  667 #endif                                                     /* OS_MUTEX_QUERY_EN                        */
//  668 
//  669 /*$PAGE*/
//  670 /*
//  671 *********************************************************************************************************
//  672 *                                RESTORE A TASK BACK TO ITS ORIGINAL PRIORITY
//  673 *
//  674 * Description: This function makes a task ready at the specified priority
//  675 *
//  676 * Arguments  : ptcb            is a pointer to OS_TCB of the task to make ready
//  677 *
//  678 *              prio            is the desired priority
//  679 *
//  680 * Returns    : none
//  681 *********************************************************************************************************
//  682 */
//  683 
//  684 static  void  OSMutex_RdyAtPrio (OS_TCB *ptcb, INT8U prio)
//  685 {
//  686     INT8U   y;
//  687 
//  688 
//  689     y            =  ptcb->OSTCBY;                          /* Remove owner from ready list at 'pip'    */
//  690     OSRdyTbl[y] &= ~ptcb->OSTCBBitX;
//  691     if (OSRdyTbl[y] == 0) {
//  692         OSRdyGrp &= ~ptcb->OSTCBBitY;
//  693     }
//  694     ptcb->OSTCBPrio         = prio;
//  695 #if OS_LOWEST_PRIO <= 63
//  696     ptcb->OSTCBY            = (INT8U)((prio >> (INT8U)3) & (INT8U)0x07);
//  697     ptcb->OSTCBX            = (INT8U) (prio & (INT8U)0x07);
//  698     ptcb->OSTCBBitY         = (INT8U)(1 << ptcb->OSTCBY);
//  699     ptcb->OSTCBBitX         = (INT8U)(1 << ptcb->OSTCBX);
//  700 #else
//  701     ptcb->OSTCBY            = (INT8U)((prio >> (INT8U)4) & (INT8U)0x0F);
//  702     ptcb->OSTCBX            = (INT8U) (prio & (INT8U)0x0F);
//  703     ptcb->OSTCBBitY         = (INT16U)(1 << ptcb->OSTCBY);
//  704     ptcb->OSTCBBitX         = (INT16U)(1 << ptcb->OSTCBX);
//  705 #endif
//  706     OSRdyGrp               |= ptcb->OSTCBBitY;             /* Make task ready at original priority     */
//  707     OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
//  708     OSTCBPrioTbl[prio]      = ptcb;
//  709 }
//  710 
//  711 
//  712 #endif                                                     /* OS_MUTEX_EN                              */
// 
// 1 350 bytes in section .text
// 
// 1 350 bytes of CODE memory
//
//Errors: none
//Warnings: none
