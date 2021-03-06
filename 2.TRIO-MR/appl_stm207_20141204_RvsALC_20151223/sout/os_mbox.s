///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:40 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_mbox.c                                         /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_mbox.c -D OS_INCLUDED -D APPL_SRC -lcN         /
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
//                    box.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_mbox

        #define SHT_PROGBITS 0x1

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

        PUBLIC OSMboxAccept
        PUBLIC OSMboxCreate
        PUBLIC OSMboxDel
        PUBLIC OSMboxPend
        PUBLIC OSMboxPendAbort
        PUBLIC OSMboxPost
        PUBLIC OSMboxPostOpt
        PUBLIC OSMboxQuery

// C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\Source\os_mbox.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                       MESSAGE MAILBOX MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_MBOX.C
//   11 * By      : Jean J. Labrosse
//   12 * Version : V2.85
//   13 *
//   14 * LICENSING TERMS:
//   15 * ---------------
//   16 *   uC/OS-II is provided in source form for FREE evaluation, for educational use or for peaceful research.  
//   17 * If you plan on using  uC/OS-II  in a commercial product you need to contact Micri?m to properly license 
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
//   29 #if OS_MBOX_EN > 0
//   30 /*
//   31 *********************************************************************************************************
//   32 *                                     ACCEPT MESSAGE FROM MAILBOX
//   33 *
//   34 * Description: This function checks the mailbox to see if a message is available.  Unlike OSMboxPend(),
//   35 *              OSMboxAccept() does not suspend the calling task if a message is not available.
//   36 *
//   37 * Arguments  : pevent        is a pointer to the event control block
//   38 *
//   39 * Returns    : != (void *)0  is the message in the mailbox if one is available.  The mailbox is cleared
//   40 *                            so the next time OSMboxAccept() is called, the mailbox will be empty.
//   41 *              == (void *)0  if the mailbox is empty or,
//   42 *                            if 'pevent' is a NULL pointer or,
//   43 *                            if you didn't pass the proper event pointer.
//   44 *********************************************************************************************************
//   45 */
//   46 
//   47 #if OS_MBOX_ACCEPT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   48 void  *OSMboxAccept (OS_EVENT *pevent)
//   49 {
OSMboxAccept:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   50     void      *pmsg;
//   51 #if OS_CRITICAL_METHOD == 3                               /* Allocate storage for CPU status register  */
//   52     OS_CPU_SR  cpu_sr = 0;
//   53 #endif
//   54 
//   55 
//   56 
//   57 #if OS_ARG_CHK_EN > 0
//   58     if (pevent == (OS_EVENT *)0) {                        /* Validate 'pevent'                         */
//   59         return ((void *)0);
//   60     }
//   61 #endif
//   62     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {      /* Validate event block type                 */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??OSMboxAccept_0
//   63         return ((void *)0);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//   64     }
//   65     OS_ENTER_CRITICAL();
??OSMboxAccept_0:
        BL       OS_CPU_SR_Save
//   66     pmsg               = pevent->OSEventPtr;
        LDR      R5,[R4, #+4]
//   67     pevent->OSEventPtr = (void *)0;                       /* Clear the mailbox                         */
        MOVS     R1,#+0
        STR      R1,[R4, #+4]
//   68     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//   69     return (pmsg);                                        /* Return the message received (or NULL)     */
        MOV      R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//   70 }
//   71 #endif
//   72 /*$PAGE*/
//   73 /*
//   74 *********************************************************************************************************
//   75 *                                        CREATE A MESSAGE MAILBOX
//   76 *
//   77 * Description: This function creates a message mailbox if free event control blocks are available.
//   78 *
//   79 * Arguments  : pmsg          is a pointer to a message that you wish to deposit in the mailbox.  If
//   80 *                            you set this value to the NULL pointer (i.e. (void *)0) then the mailbox
//   81 *                            will be considered empty.
//   82 *
//   83 * Returns    : != (OS_EVENT *)0  is a pointer to the event control clock (OS_EVENT) associated with the
//   84 *                                created mailbox
//   85 *              == (OS_EVENT *)0  if no event control blocks were available
//   86 *********************************************************************************************************
//   87 */
//   88 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   89 OS_EVENT  *OSMboxCreate (void *pmsg)
//   90 {
OSMboxCreate:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
//   91     OS_EVENT  *pevent;
//   92 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//   93     OS_CPU_SR  cpu_sr = 0;
//   94 #endif
//   95 
//   96 
//   97 
//   98     if (OSIntNesting > 0) {                      /* See if called from ISR ...                         */
        LDR.N    R0,??DataTable2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSMboxCreate_0
//   99         return ((OS_EVENT *)0);                  /* ... can't CREATE from an ISR                       */
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//  100     }
//  101     OS_ENTER_CRITICAL();
??OSMboxCreate_0:
        BL       OS_CPU_SR_Save
//  102     pevent = OSEventFreeList;                    /* Get next free event control block                  */
        LDR.N    R1,??DataTable2_1
        LDR      R2,[R1, #+0]
        MOVS     R5,R2
//  103     if (OSEventFreeList != (OS_EVENT *)0) {      /* See if pool of free ECB pool was empty             */
        ITT      NE 
        LDRNE    R2,[R2, #+4]
        STRNE    R2,[R1, #+0]
//  104         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
//  105     }
//  106     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  107     if (pevent != (OS_EVENT *)0) {
        CMP      R5,#+0
        BEQ.N    ??OSMboxCreate_1
//  108         pevent->OSEventType    = OS_EVENT_TYPE_MBOX;
        MOVS     R0,#+1
        STRB     R0,[R5, #+0]
//  109         pevent->OSEventCnt     = 0;
        MOVS     R0,#+0
        STRH     R0,[R5, #+8]
//  110         pevent->OSEventPtr     = pmsg;           /* Deposit message in event control block             */
        STR      R4,[R5, #+4]
//  111 #if OS_EVENT_NAME_SIZE > 1
//  112         pevent->OSEventName[0] = '?';
//  113         pevent->OSEventName[1] = OS_ASCII_NUL;
//  114 #endif
//  115         OS_EventWaitListInit(pevent);
        MOV      R0,R5
        BL       OS_EventWaitListInit
//  116     }
//  117     return (pevent);                             /* Return pointer to event control block              */
??OSMboxCreate_1:
        MOV      R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//  118 }
//  119 /*$PAGE*/
//  120 /*
//  121 *********************************************************************************************************
//  122 *                                         DELETE A MAIBOX
//  123 *
//  124 * Description: This function deletes a mailbox and readies all tasks pending on the mailbox.
//  125 *
//  126 * Arguments  : pevent        is a pointer to the event control block associated with the desired
//  127 *                            mailbox.
//  128 *
//  129 *              opt           determines delete options as follows:
//  130 *                            opt == OS_DEL_NO_PEND   Delete the mailbox ONLY if no task pending
//  131 *                            opt == OS_DEL_ALWAYS    Deletes the mailbox even if tasks are waiting.
//  132 *                                                    In this case, all the tasks pending will be readied.
//  133 *
//  134 *              perr          is a pointer to an error code that can contain one of the following values:
//  135 *                            OS_ERR_NONE             The call was successful and the mailbox was deleted
//  136 *                            OS_ERR_DEL_ISR          If you attempted to delete the mailbox from an ISR
//  137 *                            OS_ERR_INVALID_OPT      An invalid option was specified
//  138 *                            OS_ERR_TASK_WAITING     One or more tasks were waiting on the mailbox
//  139 *                            OS_ERR_EVENT_TYPE       If you didn't pass a pointer to a mailbox
//  140 *                            OS_ERR_PEVENT_NULL      If 'pevent' is a NULL pointer.
//  141 *
//  142 * Returns    : pevent        upon error
//  143 *              (OS_EVENT *)0 if the mailbox was successfully deleted.
//  144 *
//  145 * Note(s)    : 1) This function must be used with care.  Tasks that would normally expect the presence of
//  146 *                 the mailbox MUST check the return code of OSMboxPend().
//  147 *              2) OSMboxAccept() callers will not know that the intended mailbox has been deleted!
//  148 *              3) This call can potentially disable interrupts for a long time.  The interrupt disable
//  149 *                 time is directly proportional to the number of tasks waiting on the mailbox.
//  150 *              4) Because ALL tasks pending on the mailbox will be readied, you MUST be careful in
//  151 *                 applications where the mailbox is used for mutual exclusion because the resource(s)
//  152 *                 will no longer be guarded by the mailbox.
//  153 *********************************************************************************************************
//  154 */
//  155 
//  156 #if OS_MBOX_DEL_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  157 OS_EVENT  *OSMboxDel (OS_EVENT *pevent, INT8U opt, INT8U *perr)
//  158 {
OSMboxDel:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R6,R1
        MOV      R5,R2
//  159     BOOLEAN    tasks_waiting;
//  160     OS_EVENT  *pevent_return;
//  161 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  162     OS_CPU_SR  cpu_sr = 0;
//  163 #endif
//  164 
//  165 
//  166 
//  167 #if OS_ARG_CHK_EN > 0
//  168     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  169         return (pevent);
//  170     }
//  171     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  172         *perr = OS_ERR_PEVENT_NULL;
//  173         return (pevent);
//  174     }
//  175 #endif
//  176     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        IT       NE 
        MOVNE    R0,#+1
//  177         *perr = OS_ERR_EVENT_TYPE;
        BNE.N    ??OSMboxDel_0
//  178         return (pevent);
//  179     }
//  180     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
        LDR.N    R0,??DataTable2
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMboxDel_1
//  181         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
        MOVS     R0,#+15
        B.N      ??OSMboxDel_0
//  182         return (pevent);
//  183     }
//  184     OS_ENTER_CRITICAL();
??OSMboxDel_1:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  185     if (pevent->OSEventGrp != 0) {                         /* See if any tasks waiting on mailbox      */
        LDRB     R0,[R4, #+10]
        SUBS     R7,R0,#+1
        SBCS     R7,R7,R7
        MVNS     R1,R7
        LSRS     R7,R1,#+31
//  186         tasks_waiting = OS_TRUE;                           /* Yes                                      */
//  187     } else {
//  188         tasks_waiting = OS_FALSE;                          /* No                                       */
//  189     }
//  190     switch (opt) {
        CBZ.N    R6,??OSMboxDel_2
        CMP      R6,#+1
        BEQ.N    ??OSMboxDel_3
        B.N      ??OSMboxDel_4
//  191         case OS_DEL_NO_PEND:                               /* Delete mailbox only if no task waiting   */
//  192              if (tasks_waiting == OS_FALSE) {
??OSMboxDel_2:
        CBNZ.N   R7,??OSMboxDel_5
//  193 #if OS_EVENT_NAME_SIZE > 1
//  194                  pevent->OSEventName[0] = '?';             /* Unknown name                             */
//  195                  pevent->OSEventName[1] = OS_ASCII_NUL;
//  196 #endif
//  197                  pevent->OSEventType = OS_EVENT_TYPE_UNUSED;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  198                  pevent->OSEventPtr  = OSEventFreeList;    /* Return Event Control Block to free list  */
        LDR.N    R0,??DataTable2_1
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  199                  pevent->OSEventCnt  = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  200                  OSEventFreeList     = pevent;             /* Get next free event control block        */
        STR      R4,[R0, #+0]
//  201                  OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  202                  *perr               = OS_ERR_NONE;
??OSMboxDel_6:
        MOVS     R0,#+0
//  203                  pevent_return       = (OS_EVENT *)0;      /* Mailbox has been deleted                 */
        MOVS     R4,#+0
        B.N      ??OSMboxDel_0
//  204              } else {
//  205                  OS_EXIT_CRITICAL();
??OSMboxDel_5:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  206                  *perr               = OS_ERR_TASK_WAITING;
        MOVS     R0,#+73
//  207                  pevent_return       = pevent;
        B.N      ??OSMboxDel_0
//  208              }
//  209              break;
//  210 
//  211         case OS_DEL_ALWAYS:                                /* Always delete the mailbox                */
//  212              while (pevent->OSEventGrp != 0) {             /* Ready ALL tasks waiting for mailbox      */
??OSMboxDel_3:
        CBZ.N    R0,??OSMboxDel_7
//  213                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_OK);
??OSMboxDel_8:
        MOVS     R3,#+0
        MOVS     R2,#+2
        MOVS     R1,#+0
        MOV      R0,R4
        BL       OS_EventTaskRdy
        LDRB     R0,[R4, #+10]
        CMP      R0,#+0
        BNE.N    ??OSMboxDel_8
//  214              }
//  215 #if OS_EVENT_NAME_SIZE > 1
//  216              pevent->OSEventName[0] = '?';                 /* Unknown name                             */
//  217              pevent->OSEventName[1] = OS_ASCII_NUL;
//  218 #endif
//  219              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
??OSMboxDel_7:
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  220              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
        LDR.N    R0,??DataTable2_1
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  221              pevent->OSEventCnt     = 0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  222              OSEventFreeList        = pevent;              /* Get next free event control block        */
        STR      R4,[R0, #+0]
//  223              OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  224              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
        CMP      R7,#+0
        BEQ.N    ??OSMboxDel_6
//  225                  OS_Sched();                               /* Find highest priority task ready to run  */
        BL       OS_Sched
//  226              }
//  227              *perr         = OS_ERR_NONE;
        B.N      ??OSMboxDel_6
//  228              pevent_return = (OS_EVENT *)0;                /* Mailbox has been deleted                 */
//  229              break;
//  230 
//  231         default:
//  232              OS_EXIT_CRITICAL();
??OSMboxDel_4:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  233              *perr         = OS_ERR_INVALID_OPT;
        MOVS     R0,#+7
//  234              pevent_return = pevent;
//  235              break;
??OSMboxDel_0:
        STRB     R0,[R5, #+0]
//  236     }
//  237     return (pevent_return);
        MOV      R0,R4
        POP      {R4-R8,PC}       ;; return
//  238 }
//  239 #endif
//  240 
//  241 /*$PAGE*/
//  242 /*
//  243 *********************************************************************************************************
//  244 *                                      PEND ON MAILBOX FOR A MESSAGE
//  245 *
//  246 * Description: This function waits for a message to be sent to a mailbox
//  247 *
//  248 * Arguments  : pevent        is a pointer to the event control block associated with the desired mailbox
//  249 *
//  250 *              timeout       is an optional timeout period (in clock ticks).  If non-zero, your task will
//  251 *                            wait for a message to arrive at the mailbox up to the amount of time
//  252 *                            specified by this argument.  If you specify 0, however, your task will wait
//  253 *                            forever at the specified mailbox or, until a message arrives.
//  254 *
//  255 *              perr          is a pointer to where an error message will be deposited.  Possible error
//  256 *                            messages are:
//  257 *
//  258 *                            OS_ERR_NONE         The call was successful and your task received a
//  259 *                                                message.
//  260 *                            OS_ERR_TIMEOUT      A message was not received within the specified 'timeout'.
//  261 *                            OS_ERR_PEND_ABORT   The wait on the mailbox was aborted.
//  262 *                            OS_ERR_EVENT_TYPE   Invalid event type
//  263 *                            OS_ERR_PEND_ISR     If you called this function from an ISR and the result
//  264 *                                                would lead to a suspension.
//  265 *                            OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer
//  266 *                            OS_ERR_PEND_LOCKED  If you called this function when the scheduler is locked
//  267 *
//  268 * Returns    : != (void *)0  is a pointer to the message received
//  269 *              == (void *)0  if no message was received or,
//  270 *                            if 'pevent' is a NULL pointer or,
//  271 *                            if you didn't pass the proper pointer to the event control block.
//  272 *********************************************************************************************************
//  273 */
//  274 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  275 void  *OSMboxPend (OS_EVENT *pevent, INT16U timeout, INT8U *perr)
//  276 {
OSMboxPend:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R7,R1
        MOV      R5,R2
//  277     void      *pmsg;
//  278     INT8U      pend_stat;
//  279 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  280     OS_CPU_SR  cpu_sr = 0;
//  281 #endif
//  282 
//  283 
//  284 
//  285 #if OS_ARG_CHK_EN > 0
//  286     if (perr == (INT8U *)0) {                         /* Validate 'perr'                               */
//  287         return ((void *)0);
//  288     }
//  289     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  290         *perr = OS_ERR_PEVENT_NULL;
//  291         return ((void *)0);
//  292     }
//  293 #endif
//  294     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??OSMboxPend_0
//  295         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
??OSMboxPend_1:
        STRB     R0,[R5, #+0]
//  296         return ((void *)0);
        MOVS     R0,#+0
        B.N      ??OSMboxPend_2
//  297     }
//  298     if (OSIntNesting > 0) {                           /* See if called from ISR ...                    */
??OSMboxPend_0:
        LDR.N    R0,??DataTable2
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMboxPend_3
//  299         *perr = OS_ERR_PEND_ISR;                      /* ... can't PEND from an ISR                    */
        MOVS     R0,#+2
        B.N      ??OSMboxPend_1
//  300         return ((void *)0);
//  301     }
//  302     if (OSLockNesting > 0) {                          /* See if called with scheduler locked ...       */
??OSMboxPend_3:
        LDR.N    R0,??DataTable2_2
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMboxPend_4
//  303         *perr = OS_ERR_PEND_LOCKED;                   /* ... can't PEND when locked                    */
        MOVS     R0,#+13
        B.N      ??OSMboxPend_1
//  304         return ((void *)0);
//  305     }
//  306     OS_ENTER_CRITICAL();
??OSMboxPend_4:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  307     pmsg = pevent->OSEventPtr;
        LDR      R6,[R4, #+4]
//  308     if (pmsg != (void *)0) {                          /* See if there is already a message             */
        CBZ.N    R6,??OSMboxPend_5
//  309         pevent->OSEventPtr = (void *)0;               /* Clear the mailbox                             */
        MOVS     R0,#+0
        STR      R0,[R4, #+4]
//  310         OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  311         *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  312         return (pmsg);                                /* Return the message received (or NULL)         */
        MOV      R0,R6
        B.N      ??OSMboxPend_2
//  313     }
//  314     OSTCBCur->OSTCBStat     |= OS_STAT_MBOX;          /* Message not available, task will pend         */
??OSMboxPend_5:
        LDR.N    R6,??DataTable2_3
        LDR      R0,[R6, #+0]
        LDRB     R1,[R0, #+28]
        ORR      R1,R1,#0x2
        STRB     R1,[R0, #+28]
//  315     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
        LDR      R0,[R6, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+29]
//  316     OSTCBCur->OSTCBDly       = timeout;               /* Load timeout in TCB                           */
        LDR      R0,[R6, #+0]
        STRH     R7,[R0, #+26]
//  317     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
        MOV      R0,R4
        BL       OS_EventTaskWait
//  318     OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  319     OS_Sched();                                       /* Find next highest priority task ready to run  */
        BL       OS_Sched
//  320     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  321     if (OSTCBCur->OSTCBStatPend != OS_STAT_PEND_OK) { /* See if we weren't given the message           */
        LDR      R0,[R6, #+0]
        LDRB     R7,[R0, #+29]
        CBZ.N    R7,??OSMboxPend_6
//  322         pend_stat = OSTCBCur->OSTCBStatPend;
//  323         OS_EventTOAbort(pevent);                      /* Timed out, Make task ready                    */
        MOV      R0,R4
        BL       OS_EventTOAbort
//  324         OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  325         switch (pend_stat) {
        CMP      R7,#+2
        ITE      EQ 
        MOVEQ    R0,#+14
        MOVNE    R0,#+10
//  326             case OS_STAT_PEND_TO:
//  327             default:
//  328                  *perr = OS_ERR_TIMEOUT;              /* Indicate that a timeout occured               */
//  329                  break;
        B.N      ??OSMboxPend_1
//  330 
//  331             case OS_STAT_PEND_ABORT:
//  332                  *perr = OS_ERR_PEND_ABORT;           /* Indicate that we aborted                      */
//  333                  break;
//  334         }
//  335         return ((void *)0);                           /* Return a NULL message                         */
//  336     }
//  337     pmsg                    = OSTCBCur->OSTCBMsg;
??OSMboxPend_6:
        LDR      R4,[R0, #+16]
//  338     OSTCBCur->OSTCBMsg      = (void *)0;              /* Yes, clear message received                   */
        MOVS     R1,#+0
        STR      R1,[R0, #+16]
//  339     OSTCBCur->OSTCBStat     = OS_STAT_RDY;
        STRB     R1,[R0, #+28]
//  340     OSTCBCur->OSTCBEventPtr = (OS_EVENT *)0;          /* No longer waiting for event                   */
        LDR      R0,[R6, #+0]
        STR      R1,[R0, #+12]
//  341     OS_EXIT_CRITICAL();
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  342     *perr                   = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  343     return (pmsg);                                    /* Return the message received                   */
        MOV      R0,R4
??OSMboxPend_2:
        POP      {R4-R8,PC}       ;; return
//  344 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     OSEventFreeList

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     OSLockNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     OSTCBCur
//  345 /*$PAGE*/
//  346 /*
//  347 *********************************************************************************************************
//  348 *                                      ABORT WAITING ON A MESSAGE MAILBOX
//  349 *
//  350 * Description: This function aborts & readies any tasks currently waiting on a mailbox.  This function 
//  351 *              should be used to fault-abort the wait on the mailbox, rather than to normally signal
//  352 *              the mailbox via OSMboxPost() or OSMboxPostOpt().
//  353 *
//  354 * Arguments  : pevent        is a pointer to the event control block associated with the desired mailbox.
//  355 *
//  356 *              opt           determines the type of ABORT performed:
//  357 *                            OS_PEND_OPT_NONE         ABORT wait for a single task (HPT) waiting on the
//  358 *                                                     mailbox
//  359 *                            OS_PEND_OPT_BROADCAST    ABORT wait for ALL tasks that are  waiting on the
//  360 *                                                     mailbox
//  361 *
//  362 *              perr          is a pointer to where an error message will be deposited.  Possible error
//  363 *                            messages are:
//  364 *
//  365 *                            OS_ERR_NONE         No tasks were     waiting on the mailbox.
//  366 *                            OS_ERR_PEND_ABORT   At least one task waiting on the mailbox was readied
//  367 *                                                and informed of the aborted wait; check return value 
//  368 *                                                for the number of tasks whose wait on the mailbox 
//  369 *                                                was aborted.
//  370 *                            OS_ERR_EVENT_TYPE   If you didn't pass a pointer to a mailbox.
//  371 *                            OS_ERR_PEVENT_NULL  If 'pevent' is a NULL pointer.
//  372 *
//  373 * Returns    : == 0          if no tasks were waiting on the mailbox, or upon error.
//  374 *              >  0          if one or more tasks waiting on the mailbox are now readied and informed.
//  375 *********************************************************************************************************
//  376 */
//  377 
//  378 #if OS_MBOX_PEND_ABORT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  379 INT8U  OSMboxPendAbort (OS_EVENT *pevent, INT8U opt, INT8U *perr)
//  380 {
OSMboxPendAbort:
        PUSH     {R4-R8,LR}
        MOV      R5,R0
        MOV      R6,R1
        MOV      R4,R2
//  381     INT8U      nbr_tasks;
//  382 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  383     OS_CPU_SR  cpu_sr = 0;
//  384 #endif
//  385 
//  386 
//  387 
//  388 #if OS_ARG_CHK_EN > 0
//  389     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  390         return (0);
//  391     }
//  392     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  393         *perr = OS_ERR_PEVENT_NULL;
//  394         return (0);
//  395     }
//  396 #endif
//  397     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
        LDRB     R0,[R5, #+0]
        CMP      R0,#+1
        ITTT     NE 
        MOVNE    R0,#+1
        STRBNE   R0,[R4, #+0]
        MOVNE    R0,#+0
//  398         *perr = OS_ERR_EVENT_TYPE;
//  399         return (0);
        BNE.N    ??OSMboxPendAbort_0
//  400     }
//  401     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  402     if (pevent->OSEventGrp != 0) {                         /* See if any task waiting on mailbox?      */
        LDRB     R0,[R5, #+10]
        CBZ.N    R0,??OSMboxPendAbort_1
//  403         nbr_tasks = 0;
        MOVS     R7,#+0
//  404         switch (opt) {
        CMP      R6,#+1
        BNE.N    ??OSMboxPendAbort_2
//  405             case OS_PEND_OPT_BROADCAST:                    /* Do we need to abort ALL waiting tasks?   */
//  406                  while (pevent->OSEventGrp != 0) {         /* Yes, ready ALL tasks waiting on mailbox  */
//  407                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
??OSMboxPendAbort_3:
        MOVS     R3,#+2
        MOVS     R2,#+2
        MOVS     R1,#+0
        MOV      R0,R5
        BL       OS_EventTaskRdy
//  408                      nbr_tasks++;
        ADDS     R7,R7,#+1
        LDRB     R0,[R5, #+10]
        CMP      R0,#+0
        BNE.N    ??OSMboxPendAbort_3
        B.N      ??OSMboxPendAbort_4
//  409                  }
//  410                  break;
//  411              
//  412             case OS_PEND_OPT_NONE:                         /* No,  ready HPT       waiting on mailbox  */
//  413             default:    
//  414                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
??OSMboxPendAbort_2:
        MOVS     R3,#+2
        MOVS     R2,#+2
        MOV      R1,R7
        MOV      R0,R5
        BL       OS_EventTaskRdy
//  415                  nbr_tasks++;
        MOVS     R7,#+1
//  416                  break;
//  417         }
//  418         OS_EXIT_CRITICAL();
??OSMboxPendAbort_4:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  419         OS_Sched();                                        /* Find HPT ready to run                    */
        BL       OS_Sched
//  420         *perr = OS_ERR_PEND_ABORT;
        MOVS     R0,#+14
        STRB     R0,[R4, #+0]
//  421         return (nbr_tasks);
        UXTB     R0,R7
        B.N      ??OSMboxPendAbort_0
//  422     }
//  423     OS_EXIT_CRITICAL();
??OSMboxPendAbort_1:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  424     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  425     return (0);                                            /* No tasks waiting on mailbox              */
??OSMboxPendAbort_0:
        POP      {R4-R8,PC}       ;; return
//  426 }
//  427 #endif
//  428 
//  429 /*$PAGE*/
//  430 /*
//  431 *********************************************************************************************************
//  432 *                                       POST MESSAGE TO A MAILBOX
//  433 *
//  434 * Description: This function sends a message to a mailbox
//  435 *
//  436 * Arguments  : pevent        is a pointer to the event control block associated with the desired mailbox
//  437 *
//  438 *              pmsg          is a pointer to the message to send.  You MUST NOT send a NULL pointer.
//  439 *
//  440 * Returns    : OS_ERR_NONE          The call was successful and the message was sent
//  441 *              OS_ERR_MBOX_FULL     If the mailbox already contains a message.  You can can only send one
//  442 *                                   message at a time and thus, the message MUST be consumed before you
//  443 *                                   are allowed to send another one.
//  444 *              OS_ERR_EVENT_TYPE    If you are attempting to post to a non mailbox.
//  445 *              OS_ERR_PEVENT_NULL   If 'pevent' is a NULL pointer
//  446 *              OS_ERR_POST_NULL_PTR If you are attempting to post a NULL pointer
//  447 *
//  448 * Note(s)    : 1) HPT means Highest Priority Task
//  449 *********************************************************************************************************
//  450 */
//  451 
//  452 #if OS_MBOX_POST_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  453 INT8U  OSMboxPost (OS_EVENT *pevent, void *pmsg)
//  454 {
OSMboxPost:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
//  455 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  456     OS_CPU_SR  cpu_sr = 0;
//  457 #endif
//  458 
//  459 
//  460 
//  461 #if OS_ARG_CHK_EN > 0
//  462     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  463         return (OS_ERR_PEVENT_NULL);
//  464     }
//  465     if (pmsg == (void *)0) {                          /* Make sure we are not posting a NULL pointer   */
//  466         return (OS_ERR_POST_NULL_PTR);
//  467     }
//  468 #endif
//  469     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??OSMboxPost_0
//  470         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R4-R6,PC}
//  471     }
//  472     OS_ENTER_CRITICAL();
??OSMboxPost_0:
        BL       OS_CPU_SR_Save
        MOV      R6,R0
//  473     if (pevent->OSEventGrp != 0) {                    /* See if any task pending on mailbox            */
        LDRB     R0,[R4, #+10]
        CBZ.N    R0,??OSMboxPost_1
//  474                                                       /* Ready HPT waiting on event                    */
//  475         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
        MOVS     R3,#+0
        MOVS     R2,#+2
        MOV      R1,R5
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  476         OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
//  477         OS_Sched();                                   /* Find highest priority task ready to run       */
        BL       OS_Sched
//  478         return (OS_ERR_NONE);
        B.N      ??OSMboxPost_2
//  479     }
//  480     if (pevent->OSEventPtr != (void *)0) {            /* Make sure mailbox doesn't already have a msg  */
??OSMboxPost_1:
        LDR      R0,[R4, #+4]
        CBZ.N    R0,??OSMboxPost_3
//  481         OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
//  482         return (OS_ERR_MBOX_FULL);
        MOVS     R0,#+20
        POP      {R4-R6,PC}
//  483     }
//  484     pevent->OSEventPtr = pmsg;                        /* Place message in mailbox                      */
??OSMboxPost_3:
        STR      R5,[R4, #+4]
//  485     OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
//  486     return (OS_ERR_NONE);
??OSMboxPost_2:
        MOVS     R0,#+0
        POP      {R4-R6,PC}       ;; return
//  487 }
//  488 #endif
//  489 
//  490 /*$PAGE*/
//  491 /*
//  492 *********************************************************************************************************
//  493 *                                       POST MESSAGE TO A MAILBOX
//  494 *
//  495 * Description: This function sends a message to a mailbox
//  496 *
//  497 * Arguments  : pevent        is a pointer to the event control block associated with the desired mailbox
//  498 *
//  499 *              pmsg          is a pointer to the message to send.  You MUST NOT send a NULL pointer.
//  500 *
//  501 *              opt           determines the type of POST performed:
//  502 *                            OS_POST_OPT_NONE         POST to a single waiting task
//  503 *                                                     (Identical to OSMboxPost())
//  504 *                            OS_POST_OPT_BROADCAST    POST to ALL tasks that are waiting on the mailbox
//  505 *
//  506 *                            OS_POST_OPT_NO_SCHED     Indicates that the scheduler will NOT be invoked
//  507 *
//  508 * Returns    : OS_ERR_NONE          The call was successful and the message was sent
//  509 *              OS_ERR_MBOX_FULL     If the mailbox already contains a message.  You can can only send one
//  510 *                                   message at a time and thus, the message MUST be consumed before you
//  511 *                                   are allowed to send another one.
//  512 *              OS_ERR_EVENT_TYPE    If you are attempting to post to a non mailbox.
//  513 *              OS_ERR_PEVENT_NULL   If 'pevent' is a NULL pointer
//  514 *              OS_ERR_POST_NULL_PTR If you are attempting to post a NULL pointer
//  515 *
//  516 * Note(s)    : 1) HPT means Highest Priority Task
//  517 *
//  518 * Warning    : Interrupts can be disabled for a long time if you do a 'broadcast'.  In fact, the
//  519 *              interrupt disable time is proportional to the number of tasks waiting on the mailbox.
//  520 *********************************************************************************************************
//  521 */
//  522 
//  523 #if OS_MBOX_POST_OPT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  524 INT8U  OSMboxPostOpt (OS_EVENT *pevent, void *pmsg, INT8U opt)
//  525 {
OSMboxPostOpt:
        PUSH     {R3-R7,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
//  526 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  527     OS_CPU_SR  cpu_sr = 0;
//  528 #endif
//  529 
//  530 
//  531 
//  532 #if OS_ARG_CHK_EN > 0
//  533     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
//  534         return (OS_ERR_PEVENT_NULL);
//  535     }
//  536     if (pmsg == (void *)0) {                          /* Make sure we are not posting a NULL pointer   */
//  537         return (OS_ERR_POST_NULL_PTR);
//  538     }
//  539 #endif
//  540     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??OSMboxPostOpt_0
//  541         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R1,R4-R7,PC}
//  542     }
//  543     OS_ENTER_CRITICAL();
??OSMboxPostOpt_0:
        BL       OS_CPU_SR_Save
        MOV      R7,R0
//  544     if (pevent->OSEventGrp != 0) {                    /* See if any task pending on mailbox            */
        LDRB     R0,[R4, #+10]
        CBZ.N    R0,??OSMboxPostOpt_1
//  545         if ((opt & OS_POST_OPT_BROADCAST) != 0x00) {  /* Do we need to post msg to ALL waiting tasks ? */
        LSLS     R0,R6,#+31
        BPL.N    ??OSMboxPostOpt_2
//  546             while (pevent->OSEventGrp != 0) {         /* Yes, Post to ALL tasks waiting on mailbox     */
//  547                 (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
??OSMboxPostOpt_3:
        MOVS     R3,#+0
        MOVS     R2,#+2
        MOV      R1,R5
        MOV      R0,R4
        BL       OS_EventTaskRdy
        LDRB     R0,[R4, #+10]
        CMP      R0,#+0
        BNE.N    ??OSMboxPostOpt_3
        B.N      ??OSMboxPostOpt_4
//  548             }
//  549         } else {                                      /* No,  Post to HPT waiting on mbox              */
//  550             (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
??OSMboxPostOpt_2:
        MOVS     R3,#+0
        MOVS     R2,#+2
        MOV      R1,R5
        MOV      R0,R4
        BL       OS_EventTaskRdy
//  551         }
//  552         OS_EXIT_CRITICAL();
??OSMboxPostOpt_4:
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  553         if ((opt & OS_POST_OPT_NO_SCHED) == 0) {	  /* See if scheduler needs to be invoked          */
        LSLS     R0,R6,#+29
        BMI.N    ??OSMboxPostOpt_5
//  554             OS_Sched();                               /* Find HPT ready to run                         */
        BL       OS_Sched
//  555         }
//  556         return (OS_ERR_NONE);
        B.N      ??OSMboxPostOpt_5
//  557     }
//  558     if (pevent->OSEventPtr != (void *)0) {            /* Make sure mailbox doesn't already have a msg  */
??OSMboxPostOpt_1:
        LDR      R0,[R4, #+4]
        CBZ.N    R0,??OSMboxPostOpt_6
//  559         OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  560         return (OS_ERR_MBOX_FULL);
        MOVS     R0,#+20
        POP      {R1,R4-R7,PC}
//  561     }
//  562     pevent->OSEventPtr = pmsg;                        /* Place message in mailbox                      */
??OSMboxPostOpt_6:
        STR      R5,[R4, #+4]
//  563     OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  564     return (OS_ERR_NONE);
??OSMboxPostOpt_5:
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}    ;; return
//  565 }
//  566 #endif
//  567 
//  568 /*$PAGE*/
//  569 /*
//  570 *********************************************************************************************************
//  571 *                                        QUERY A MESSAGE MAILBOX
//  572 *
//  573 * Description: This function obtains information about a message mailbox.
//  574 *
//  575 * Arguments  : pevent        is a pointer to the event control block associated with the desired mailbox
//  576 *
//  577 *              p_mbox_data   is a pointer to a structure that will contain information about the message
//  578 *                            mailbox.
//  579 *
//  580 * Returns    : OS_ERR_NONE         The call was successful and the message was sent
//  581 *              OS_ERR_EVENT_TYPE   If you are attempting to obtain data from a non mailbox.
//  582 *              OS_ERR_PEVENT_NULL  If 'pevent'      is a NULL pointer
//  583 *              OS_ERR_PDATA_NULL   If 'p_mbox_data' is a NULL pointer
//  584 *********************************************************************************************************
//  585 */
//  586 
//  587 #if OS_MBOX_QUERY_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  588 INT8U  OSMboxQuery (OS_EVENT *pevent, OS_MBOX_DATA *p_mbox_data)
//  589 {
OSMboxQuery:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  590     INT8U      i;
//  591 #if OS_LOWEST_PRIO <= 63
//  592     INT8U     *psrc;
//  593     INT8U     *pdest;
//  594 #else
//  595     INT16U    *psrc;
//  596     INT16U    *pdest;
//  597 #endif
//  598 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  599     OS_CPU_SR  cpu_sr = 0;
//  600 #endif
//  601 
//  602 
//  603 
//  604 #if OS_ARG_CHK_EN > 0
//  605     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
//  606         return (OS_ERR_PEVENT_NULL);
//  607     }
//  608     if (p_mbox_data == (OS_MBOX_DATA *)0) {                /* Validate 'p_mbox_data'                   */
//  609         return (OS_ERR_PDATA_NULL);
//  610     }
//  611 #endif
//  612     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??OSMboxQuery_0
//  613         return (OS_ERR_EVENT_TYPE);
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}
//  614     }
//  615     OS_ENTER_CRITICAL();
??OSMboxQuery_0:
        BL       OS_CPU_SR_Save
//  616     p_mbox_data->OSEventGrp = pevent->OSEventGrp;          /* Copy message mailbox wait list           */
        LDRB     R1,[R4, #+10]
        STRB     R1,[R5, #+8]
//  617     psrc                    = &pevent->OSEventTbl[0];
        ADDW     R1,R4,#+11
//  618     pdest                   = &p_mbox_data->OSEventTbl[0];
        ADDS     R2,R5,#+4
//  619     for (i = 0; i < OS_EVENT_TBL_SIZE; i++) {
//  620         *pdest++ = *psrc++;
        LDRB     R3,[R1, #+0]
        STRB     R3,[R2, #+0]
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
        LDRB     R3,[R1, #+1]!
        STRB     R3,[R2, #+1]!
//  621     }
//  622     p_mbox_data->OSMsg = pevent->OSEventPtr;               /* Get message from mailbox                 */
        LDR      R1,[R4, #+4]
        STR      R1,[R5, #+0]
//  623     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  624     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  625 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  626 #endif                                                     /* OS_MBOX_QUERY_EN                         */
//  627 #endif                                                     /* OS_MBOX_EN                               */
// 
// 802 bytes in section .text
// 
// 802 bytes of CODE memory
//
//Errors: none
//Warnings: none
