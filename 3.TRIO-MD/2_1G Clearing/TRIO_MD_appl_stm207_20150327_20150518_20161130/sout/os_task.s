///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:38 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_task.c                                         /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_task.c -D OS_INCLUDED -D APPL_SRC -lcN         /
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
//    List file    =  C:\user\project\stm32\fw\stm207_ucos_20120825\sout\os_t /
//                    ask.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_task

        #define SHT_PROGBITS 0x1

        EXTERN OSIntNesting
        EXTERN OSLockNesting
        EXTERN OSRdyGrp
        EXTERN OSRdyTbl
        EXTERN OSRunning
        EXTERN OSTCBCur
        EXTERN OSTCBFreeList
        EXTERN OSTCBList
        EXTERN OSTCBPrioTbl
        EXTERN OSTaskCtr
        EXTERN OSTaskDelHook
        EXTERN OSTaskStkInit
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_Dummy
        EXTERN OS_FlagUnlink
        EXTERN OS_MemCopy
        EXTERN OS_Sched
        EXTERN OS_TCBInit

        PUBLIC OSTaskChangePrio
        PUBLIC OSTaskCreate
        PUBLIC OSTaskDel
        PUBLIC OSTaskDelReq
        PUBLIC OSTaskQuery
        PUBLIC OSTaskResume
        PUBLIC OSTaskSuspend

// C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\Source\os_task.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                            TASK MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_TASK.C
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
//   29 /*$PAGE*/
//   30 /*
//   31 *********************************************************************************************************
//   32 *                                        CHANGE PRIORITY OF A TASK
//   33 *
//   34 * Description: This function allows you to change the priority of a task dynamically.  Note that the new
//   35 *              priority MUST be available.
//   36 *
//   37 * Arguments  : oldp     is the old priority
//   38 *
//   39 *              newp     is the new priority
//   40 *
//   41 * Returns    : OS_ERR_NONE            is the call was successful
//   42 *              OS_ERR_PRIO_INVALID    if the priority you specify is higher that the maximum allowed
//   43 *                                     (i.e. >= OS_LOWEST_PRIO)
//   44 *              OS_ERR_PRIO_EXIST      if the new priority already exist.
//   45 *              OS_ERR_PRIO            there is no task with the specified OLD priority (i.e. the OLD task does
//   46 *                                     not exist.
//   47 *              OS_ERR_TASK_NOT_EXIST  if the task is assigned to a Mutex PIP.
//   48 *********************************************************************************************************
//   49 */
//   50 
//   51 #if OS_TASK_CHANGE_PRIO_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   52 INT8U  OSTaskChangePrio (INT8U oldprio, INT8U newprio)
//   53 {
OSTaskChangePrio:
        PUSH     {R3-R9,LR}
        MOV      R4,R0
        MOV      R5,R1
//   54 #if OS_EVENT_EN
//   55     OS_EVENT    *pevent;
//   56 #endif
//   57     OS_TCB      *ptcb;
//   58     INT8U        x;
//   59     INT8U        y;
//   60 #if OS_LOWEST_PRIO <= 63
//   61     INT8U        bitx;
//   62     INT8U        bity;
//   63 #else
//   64     INT16U       bitx;
//   65     INT16U       bity;
//   66 #endif
//   67     INT8U        y_old;
//   68 #if OS_CRITICAL_METHOD == 3
//   69     OS_CPU_SR    cpu_sr = 0;                                    /* Storage for CPU status register     */
//   70 #endif
//   71 
//   72 
//   73 
//   74 #if OS_ARG_CHK_EN > 0
//   75     if (oldprio >= OS_LOWEST_PRIO) {
//   76         if (oldprio != OS_PRIO_SELF) {
//   77             return (OS_ERR_PRIO_INVALID);
//   78         }
//   79     }
//   80     if (newprio >= OS_LOWEST_PRIO) {
//   81         return (OS_ERR_PRIO_INVALID);
//   82     }
//   83 #endif
//   84     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//   85     if (OSTCBPrioTbl[newprio] != (OS_TCB *)0) {                 /* New priority must not already exist */
        MOV      R1,R5
        LDR.W    LR,??DataTable6
        LDR      R2,[LR, R1, LSL #+2]
        CBZ.N    R2,??OSTaskChangePrio_0
//   86         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//   87         return (OS_ERR_PRIO_EXIST);
        MOVS     R0,#+40
        B.N      ??OSTaskChangePrio_1
//   88     }
//   89     if (oldprio == OS_PRIO_SELF) {                              /* See if changing self                */
??OSTaskChangePrio_0:
        CMP      R4,#+255
        BNE.N    ??OSTaskChangePrio_2
//   90         oldprio = OSTCBCur->OSTCBPrio;                          /* Yes, get priority                   */
        LDR.W    R2,??DataTable6_1
        LDR      R2,[R2, #+0]
        LDRB     R4,[R2, #+30]
//   91     }
//   92     ptcb = OSTCBPrioTbl[oldprio];
??OSTaskChangePrio_2:
        LDR      R2,[LR, R4, LSL #+2]
//   93     if (ptcb == (OS_TCB *)0) {                                  /* Does task to change exist?          */
        CBNZ.N   R2,??OSTaskChangePrio_3
//   94         OS_EXIT_CRITICAL();                                     /* No, can't change its priority!      */
        BL       OS_CPU_SR_Restore
//   95         return (OS_ERR_PRIO);
        MOVS     R0,#+41
        B.N      ??OSTaskChangePrio_1
//   96     }
//   97     if (ptcb == OS_TCB_RESERVED) {                              /* Is task assigned to Mutex           */
??OSTaskChangePrio_3:
        CMP      R2,#+1
        BNE.N    ??OSTaskChangePrio_4
//   98         OS_EXIT_CRITICAL();                                     /* No, can't change its priority!      */
        BL       OS_CPU_SR_Restore
//   99         return (OS_ERR_TASK_NOT_EXIST);
        MOVS     R0,#+67
        B.N      ??OSTaskChangePrio_1
//  100     }
//  101 #if OS_LOWEST_PRIO <= 63
//  102     y                     = (INT8U)(newprio >> 3);              /* Yes, compute new TCB fields         */
??OSTaskChangePrio_4:
        LSRS     R3,R5,#+3
//  103     x                     = (INT8U)(newprio & 0x07);
        AND      R8,R5,#0x7
//  104     bity                  = (INT8U)(1 << y);
        MOVS     R6,#+1
        LSL      R7,R6,R3
        UXTB     R7,R7
//  105     bitx                  = (INT8U)(1 << x);
        LSL      R6,R6,R8
        UXTB     R12,R6
//  106 #else
//  107     y                     = (INT8U)((newprio >> 4) & 0x0F);
//  108     x                     = (INT8U)( newprio & 0x0F);
//  109     bity                  = (INT16U)(1 << y);
//  110     bitx                  = (INT16U)(1 << x);
//  111 #endif
//  112 
//  113     OSTCBPrioTbl[oldprio] = (OS_TCB *)0;                        /* Remove TCB from old priority        */
        MOVS     R6,#+0
        STR      R6,[LR, R4, LSL #+2]
//  114     OSTCBPrioTbl[newprio] = ptcb;                               /* Place pointer to TCB @ new priority */
        STR      R2,[LR, R1, LSL #+2]
//  115     y_old                 = ptcb->OSTCBY;
        LDRB     R4,[R2, #+32]
//  116     if ((OSRdyTbl[y_old] & ptcb->OSTCBBitX) != 0) {             /* If task is ready make it not        */
        LDRB     R1,[R2, #+33]
        LDR.W    LR,??DataTable6_2
        LDRB     R6,[R4, LR]
        TST      R6,R1
        BEQ.N    ??OSTaskChangePrio_5
//  117         OSRdyTbl[y_old] &= ~ptcb->OSTCBBitX;
        BICS     R1,R6,R1
        STRB     R1,[R4, LR]
//  118         if (OSRdyTbl[y_old] == 0) {
        LDR.W    R1,??DataTable6_3
        BNE.N    ??OSTaskChangePrio_6
//  119             OSRdyGrp &= ~ptcb->OSTCBBitY;
        LDRB     R6,[R1, #+0]
        LDRB     R9,[R2, #+34]
        BIC      R6,R6,R9
        STRB     R6,[R1, #+0]
//  120         }
//  121         OSRdyGrp    |= bity;                                    /* Make new priority ready to run      */
??OSTaskChangePrio_6:
        LDRB     R6,[R1, #+0]
        ORRS     R6,R7,R6
        STRB     R6,[R1, #+0]
//  122         OSRdyTbl[y] |= bitx;
        LDRB     R1,[R3, LR]
        ORR      R1,R12,R1
        STRB     R1,[R3, LR]
//  123     }
//  124 #if OS_EVENT_EN
//  125     pevent = ptcb->OSTCBEventPtr;
??OSTaskChangePrio_5:
        LDR      R1,[R2, #+12]
//  126     if (pevent != (OS_EVENT *)0) {                              /* ... remove from event wait list     */
        CBZ.N    R1,??OSTaskChangePrio_7
//  127         pevent->OSEventTbl[y_old] &= ~ptcb->OSTCBBitX;
        ADDS     R4,R4,R1
        LDRB     LR,[R4, #+11]
        LDRB     R6,[R2, #+33]
        BIC      R6,LR,R6
        STRB     R6,[R4, #+11]
//  128         if (pevent->OSEventTbl[y_old] == 0) {
        LDRB     R4,[R4, #+11]
        CBNZ.N   R4,??OSTaskChangePrio_8
//  129             pevent->OSEventGrp &= ~ptcb->OSTCBBitY;
        LDRB     R4,[R1, #+10]
        LDRB     R6,[R2, #+34]
        BICS     R4,R4,R6
        STRB     R4,[R1, #+10]
//  130         }
//  131         pevent->OSEventGrp    |= bity;                          /* Add new priority to wait list       */
??OSTaskChangePrio_8:
        LDRB     R4,[R1, #+10]
        ORRS     R4,R7,R4
        STRB     R4,[R1, #+10]
//  132         pevent->OSEventTbl[y] |= bitx;
        ADDS     R1,R3,R1
        LDRB     R4,[R1, #+11]
        ORR      R4,R12,R4
        STRB     R4,[R1, #+11]
//  133     }
//  134 #endif
//  135     ptcb->OSTCBPrio = newprio;                                  /* Set new task priority               */
??OSTaskChangePrio_7:
        STRB     R5,[R2, #+30]
//  136     ptcb->OSTCBY    = y;
        STRB     R3,[R2, #+32]
//  137     ptcb->OSTCBX    = x;
        STRB     R8,[R2, #+31]
//  138     ptcb->OSTCBBitY = bity;
        STRB     R7,[R2, #+34]
//  139     ptcb->OSTCBBitX = bitx;
        STRB     R12,[R2, #+33]
//  140     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  141     if (OSRunning == OS_TRUE) {
        LDR.N    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        IT       EQ 
        BLEQ     OS_Sched
//  142         OS_Sched();                                             /* Find new highest priority task      */
//  143     }
//  144     return (OS_ERR_NONE);
        MOVS     R0,#+0
??OSTaskChangePrio_1:
        POP      {R1,R4-R9,PC}    ;; return
//  145 }
//  146 #endif
//  147 /*$PAGE*/
//  148 /*
//  149 *********************************************************************************************************
//  150 *                                            CREATE A TASK
//  151 *
//  152 * Description: This function is used to have uC/OS-II manage the execution of a task.  Tasks can either
//  153 *              be created prior to the start of multitasking or by a running task.  A task cannot be
//  154 *              created by an ISR.
//  155 *
//  156 * Arguments  : task     is a pointer to the task's code
//  157 *
//  158 *              p_arg    is a pointer to an optional data area which can be used to pass parameters to
//  159 *                       the task when the task first executes.  Where the task is concerned it thinks
//  160 *                       it was invoked and passed the argument 'p_arg' as follows:
//  161 *
//  162 *                           void Task (void *p_arg)
//  163 *                           {
//  164 *                               for (;;) {
//  165 *                                   Task code;
//  166 *                               }
//  167 *                           }
//  168 *
//  169 *              ptos     is a pointer to the task's top of stack.  If the configuration constant
//  170 *                       OS_STK_GROWTH is set to 1, the stack is assumed to grow downward (i.e. from high
//  171 *                       memory to low memory).  'pstk' will thus point to the highest (valid) memory
//  172 *                       location of the stack.  If OS_STK_GROWTH is set to 0, 'pstk' will point to the
//  173 *                       lowest memory location of the stack and the stack will grow with increasing
//  174 *                       memory locations.
//  175 *
//  176 *              prio     is the task's priority.  A unique priority MUST be assigned to each task and the
//  177 *                       lower the number, the higher the priority.
//  178 *
//  179 * Returns    : OS_ERR_NONE             if the function was successful.
//  180 *              OS_PRIO_EXIT            if the task priority already exist
//  181 *                                      (each task MUST have a unique priority).
//  182 *              OS_ERR_PRIO_INVALID     if the priority you specify is higher that the maximum allowed
//  183 *                                      (i.e. >= OS_LOWEST_PRIO)
//  184 *              OS_ERR_TASK_CREATE_ISR  if you tried to create a task from an ISR.
//  185 *********************************************************************************************************
//  186 */
//  187 
//  188 #if OS_TASK_CREATE_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  189 INT8U  OSTaskCreate (void (*task)(void *p_arg), void *p_arg, OS_STK *ptos, INT8U prio)
//  190 {
OSTaskCreate:
        PUSH     {R4-R9,LR}
        SUB      SP,SP,#+12
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
        MOV      R7,R3
//  191     OS_STK    *psp;
//  192     INT8U      err;
//  193 #if OS_CRITICAL_METHOD == 3                  /* Allocate storage for CPU status register               */
//  194     OS_CPU_SR  cpu_sr = 0;
//  195 #endif
//  196 
//  197 
//  198 
//  199 #if OS_ARG_CHK_EN > 0
//  200     if (prio > OS_LOWEST_PRIO) {             /* Make sure priority is within allowable range           */
//  201         return (OS_ERR_PRIO_INVALID);
//  202     }
//  203 #endif
//  204     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  205     if (OSIntNesting > 0) {                  /* Make sure we don't create the task from within an ISR  */
        LDR.N    R1,??DataTable6_5
        LDRB     R1,[R1, #+0]
        CBZ.N    R1,??OSTaskCreate_0
//  206         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  207         return (OS_ERR_TASK_CREATE_ISR);
        MOVS     R0,#+60
        B.N      ??OSTaskCreate_1
//  208     }
//  209     if (OSTCBPrioTbl[prio] == (OS_TCB *)0) { /* Make sure task doesn't already exist at this priority  */
??OSTaskCreate_0:
        MOV      R8,R7
        LDR.W    R9,??DataTable6
        LDR      R1,[R9, R8, LSL #+2]
        CBNZ.N   R1,??OSTaskCreate_2
//  210         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;/* Reserve the priority to prevent others from doing ...  */
        MOVS     R1,#+1
        STR      R1,[R9, R8, LSL #+2]
//  211                                              /* ... the same thing until task is created.              */
//  212         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  213         psp = OSTaskStkInit(task, p_arg, ptos, 0);              /* Initialize the task's stack         */
        MOVS     R3,#+0
        MOV      R2,R6
        MOV      R1,R5
        MOV      R0,R4
        BL       OSTaskStkInit
        MOV      R1,R0
//  214         err = OS_TCBInit(prio, psp, (OS_STK *)0, 0, 0, (void *)0, 0);
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
        STR      R0,[SP, #+4]
        STR      R0,[SP, #+0]
        MOVS     R3,#+0
        MOV      R2,R0
        MOV      R0,R7
        BL       OS_TCBInit
        MOVS     R4,R0
//  215         if (err == OS_ERR_NONE) {
        BNE.N    ??OSTaskCreate_3
//  216             if (OSRunning == OS_TRUE) {      /* Find highest priority task if multitasking has started */
        LDR.N    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??OSTaskCreate_4
//  217                 OS_Sched();
        BL       OS_Sched
        B.N      ??OSTaskCreate_4
//  218             }
//  219         } else {
//  220             OS_ENTER_CRITICAL();
??OSTaskCreate_3:
        BL       OS_CPU_SR_Save
//  221             OSTCBPrioTbl[prio] = (OS_TCB *)0;/* Make this priority available to others                 */
        MOVS     R1,#+0
        STR      R1,[R9, R8, LSL #+2]
//  222             OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  223         }
//  224         return (err);
??OSTaskCreate_4:
        MOV      R0,R4
        B.N      ??OSTaskCreate_1
//  225     }
//  226     OS_EXIT_CRITICAL();
??OSTaskCreate_2:
        BL       OS_CPU_SR_Restore
//  227     return (OS_ERR_PRIO_EXIST);
        MOVS     R0,#+40
??OSTaskCreate_1:
        ADD      SP,SP,#+12
        POP      {R4-R9,PC}       ;; return
//  228 }
//  229 #endif
//  230 /*$PAGE*/
//  231 /*
//  232 *********************************************************************************************************
//  233 *                                     CREATE A TASK (Extended Version)
//  234 *
//  235 * Description: This function is used to have uC/OS-II manage the execution of a task.  Tasks can either
//  236 *              be created prior to the start of multitasking or by a running task.  A task cannot be
//  237 *              created by an ISR.  This function is similar to OSTaskCreate() except that it allows
//  238 *              additional information about a task to be specified.
//  239 *
//  240 * Arguments  : task      is a pointer to the task's code
//  241 *
//  242 *              p_arg     is a pointer to an optional data area which can be used to pass parameters to
//  243 *                        the task when the task first executes.  Where the task is concerned it thinks
//  244 *                        it was invoked and passed the argument 'p_arg' as follows:
//  245 *
//  246 *                            void Task (void *p_arg)
//  247 *                            {
//  248 *                                for (;;) {
//  249 *                                    Task code;
//  250 *                                }
//  251 *                            }
//  252 *
//  253 *              ptos      is a pointer to the task's top of stack.  If the configuration constant
//  254 *                        OS_STK_GROWTH is set to 1, the stack is assumed to grow downward (i.e. from high
//  255 *                        memory to low memory).  'ptos' will thus point to the highest (valid) memory
//  256 *                        location of the stack.  If OS_STK_GROWTH is set to 0, 'ptos' will point to the
//  257 *                        lowest memory location of the stack and the stack will grow with increasing
//  258 *                        memory locations.  'ptos' MUST point to a valid 'free' data item.
//  259 *
//  260 *              prio      is the task's priority.  A unique priority MUST be assigned to each task and the
//  261 *                        lower the number, the higher the priority.
//  262 *
//  263 *              id        is the task's ID (0..65535)
//  264 *
//  265 *              pbos      is a pointer to the task's bottom of stack.  If the configuration constant
//  266 *                        OS_STK_GROWTH is set to 1, the stack is assumed to grow downward (i.e. from high
//  267 *                        memory to low memory).  'pbos' will thus point to the LOWEST (valid) memory
//  268 *                        location of the stack.  If OS_STK_GROWTH is set to 0, 'pbos' will point to the
//  269 *                        HIGHEST memory location of the stack and the stack will grow with increasing
//  270 *                        memory locations.  'pbos' MUST point to a valid 'free' data item.
//  271 *
//  272 *              stk_size  is the size of the stack in number of elements.  If OS_STK is set to INT8U,
//  273 *                        'stk_size' corresponds to the number of bytes available.  If OS_STK is set to
//  274 *                        INT16U, 'stk_size' contains the number of 16-bit entries available.  Finally, if
//  275 *                        OS_STK is set to INT32U, 'stk_size' contains the number of 32-bit entries
//  276 *                        available on the stack.
//  277 *
//  278 *              pext      is a pointer to a user supplied memory location which is used as a TCB extension.
//  279 *                        For example, this user memory can hold the contents of floating-point registers
//  280 *                        during a context switch, the time each task takes to execute, the number of times
//  281 *                        the task has been switched-in, etc.
//  282 *
//  283 *              opt       contains additional information (or options) about the behavior of the task.  The
//  284 *                        LOWER 8-bits are reserved by uC/OS-II while the upper 8 bits can be application
//  285 *                        specific.  See OS_TASK_OPT_??? in uCOS-II.H.  Current choices are:
//  286 *
//  287 *                        OS_TASK_OPT_STK_CHK      Stack checking to be allowed for the task
//  288 *                        OS_TASK_OPT_STK_CLR      Clear the stack when the task is created
//  289 *                        OS_TASK_OPT_SAVE_FP      If the CPU has floating-point registers, save them
//  290 *                                                 during a context switch.
//  291 *
//  292 * Returns    : OS_ERR_NONE             if the function was successful.
//  293 *              OS_PRIO_EXIT            if the task priority already exist
//  294 *                                      (each task MUST have a unique priority).
//  295 *              OS_ERR_PRIO_INVALID     if the priority you specify is higher that the maximum allowed
//  296 *                                      (i.e. > OS_LOWEST_PRIO)
//  297 *              OS_ERR_TASK_CREATE_ISR  if you tried to create a task from an ISR.
//  298 *********************************************************************************************************
//  299 */
//  300 /*$PAGE*/
//  301 #if OS_TASK_CREATE_EXT_EN > 0
//  302 INT8U  OSTaskCreateExt (void   (*task)(void *p_arg),
//  303                         void    *p_arg,
//  304                         OS_STK  *ptos,
//  305                         INT8U    prio,
//  306                         INT16U   id,
//  307                         OS_STK  *pbos,
//  308                         INT32U   stk_size,
//  309                         void    *pext,
//  310                         INT16U   opt)
//  311 {
//  312     OS_STK    *psp;
//  313     INT8U      err;
//  314 #if OS_CRITICAL_METHOD == 3                  /* Allocate storage for CPU status register               */
//  315     OS_CPU_SR  cpu_sr = 0;
//  316 #endif
//  317 
//  318 
//  319 
//  320 #if OS_ARG_CHK_EN > 0
//  321     if (prio > OS_LOWEST_PRIO) {             /* Make sure priority is within allowable range           */
//  322         return (OS_ERR_PRIO_INVALID);
//  323     }
//  324 #endif
//  325     OS_ENTER_CRITICAL();
//  326     if (OSIntNesting > 0) {                  /* Make sure we don't create the task from within an ISR  */
//  327         OS_EXIT_CRITICAL();
//  328         return (OS_ERR_TASK_CREATE_ISR);
//  329     }
//  330     if (OSTCBPrioTbl[prio] == (OS_TCB *)0) { /* Make sure task doesn't already exist at this priority  */
//  331         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;/* Reserve the priority to prevent others from doing ...  */
//  332                                              /* ... the same thing until task is created.              */
//  333         OS_EXIT_CRITICAL();
//  334 
//  335 #if OS_TASK_STAT_STK_CHK_EN > 0
//  336         OS_TaskStkClr(pbos, stk_size, opt);                    /* Clear the task stack (if needed)     */
//  337 #endif        
//  338 
//  339         psp = OSTaskStkInit(task, p_arg, ptos, opt);           /* Initialize the task's stack          */
//  340         err = OS_TCBInit(prio, psp, pbos, id, stk_size, pext, opt);
//  341         if (err == OS_ERR_NONE) {
//  342             if (OSRunning == OS_TRUE) {                        /* Find HPT if multitasking has started */
//  343                 OS_Sched();
//  344             }
//  345         } else {
//  346             OS_ENTER_CRITICAL();
//  347             OSTCBPrioTbl[prio] = (OS_TCB *)0;                  /* Make this priority avail. to others  */
//  348             OS_EXIT_CRITICAL();
//  349         }
//  350         return (err);
//  351     }
//  352     OS_EXIT_CRITICAL();
//  353     return (OS_ERR_PRIO_EXIST);
//  354 }
//  355 #endif
//  356 /*$PAGE*/
//  357 /*
//  358 *********************************************************************************************************
//  359 *                                            DELETE A TASK
//  360 *
//  361 * Description: This function allows you to delete a task.  The calling task can delete itself by
//  362 *              its own priority number.  The deleted task is returned to the dormant state and can be
//  363 *              re-activated by creating the deleted task again.
//  364 *
//  365 * Arguments  : prio    is the priority of the task to delete.  Note that you can explicitely delete
//  366 *                      the current task without knowing its priority level by setting 'prio' to
//  367 *                      OS_PRIO_SELF.
//  368 *
//  369 * Returns    : OS_ERR_NONE             if the call is successful
//  370 *              OS_ERR_TASK_DEL_IDLE    if you attempted to delete uC/OS-II's idle task
//  371 *              OS_ERR_PRIO_INVALID     if the priority you specify is higher that the maximum allowed
//  372 *                                      (i.e. >= OS_LOWEST_PRIO) or, you have not specified OS_PRIO_SELF.
//  373 *              OS_ERR_TASK_DEL         if the task is assigned to a Mutex PIP.   
//  374 *              OS_ERR_TASK_NOT_EXIST   if the task you want to delete does not exist.
//  375 *              OS_ERR_TASK_DEL_ISR     if you tried to delete a task from an ISR
//  376 *
//  377 * Notes      : 1) To reduce interrupt latency, OSTaskDel() 'disables' the task:
//  378 *                    a) by making it not ready
//  379 *                    b) by removing it from any wait lists
//  380 *                    c) by preventing OSTimeTick() from making the task ready to run.
//  381 *                 The task can then be 'unlinked' from the miscellaneous structures in uC/OS-II.
//  382 *              2) The function OS_Dummy() is called after OS_EXIT_CRITICAL() because, on most processors,
//  383 *                 the next instruction following the enable interrupt instruction is ignored.
//  384 *              3) An ISR cannot delete a task.
//  385 *              4) The lock nesting counter is incremented because, for a brief instant, if the current
//  386 *                 task is being deleted, the current task would not be able to be rescheduled because it
//  387 *                 is removed from the ready list.  Incrementing the nesting counter prevents another task
//  388 *                 from being schedule.  This means that an ISR would return to the current task which is
//  389 *                 being deleted.  The rest of the deletion would thus be able to be completed.
//  390 *********************************************************************************************************
//  391 */
//  392 /*$PAGE*/
//  393 #if OS_TASK_DEL_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  394 INT8U  OSTaskDel (INT8U prio)
//  395 {
OSTaskDel:
        PUSH     {R4-R8,LR}
        MOV      R7,R0
//  396 #if OS_EVENT_EN
//  397     OS_EVENT     *pevent;
//  398 #endif
//  399 #if (OS_FLAG_EN > 0) && (OS_MAX_FLAGS > 0)
//  400     OS_FLAG_NODE *pnode;
//  401 #endif
//  402     OS_TCB       *ptcb;
//  403     INT8U         y;
//  404 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  405     OS_CPU_SR     cpu_sr = 0;
//  406 #endif
//  407 
//  408 
//  409 
//  410     if (OSIntNesting > 0) {                                     /* See if trying to delete from ISR    */
        LDR.N    R0,??DataTable6_5
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSTaskDel_0
//  411         return (OS_ERR_TASK_DEL_ISR);
        MOVS     R0,#+64
        B.N      ??OSTaskDel_1
//  412     }
//  413     if (prio == OS_TASK_IDLE_PRIO) {                            /* Not allowed to delete idle task     */
??OSTaskDel_0:
        CMP      R7,#+31
        IT       EQ 
        MOVEQ    R0,#+62
//  414         return (OS_ERR_TASK_DEL_IDLE);
        BEQ.N    ??OSTaskDel_1
//  415     }
//  416 #if OS_ARG_CHK_EN > 0
//  417     if (prio >= OS_LOWEST_PRIO) {                               /* Task priority valid ?               */
//  418         if (prio != OS_PRIO_SELF) {
//  419             return (OS_ERR_PRIO_INVALID);
//  420         }
//  421     }
//  422 #endif
//  423 
//  424     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R4,R0
//  425     if (prio == OS_PRIO_SELF) {                                 /* See if requesting to delete self    */
        CMP      R7,#+255
        BNE.N    ??OSTaskDel_2
//  426         prio = OSTCBCur->OSTCBPrio;                             /* Set priority to delete to current   */
        LDR.N    R0,??DataTable6_1
        LDR      R0,[R0, #+0]
        LDRB     R7,[R0, #+30]
//  427     }
//  428     ptcb = OSTCBPrioTbl[prio];
??OSTaskDel_2:
        LDR.W    R8,??DataTable6
        LDR      R6,[R8, R7, LSL #+2]
//  429     if (ptcb == (OS_TCB *)0) {                                  /* Task to delete must exist           */
        CBNZ.N   R6,??OSTaskDel_3
//  430         OS_EXIT_CRITICAL();
        MOV      R0,R4
        BL       OS_CPU_SR_Restore
//  431         return (OS_ERR_TASK_NOT_EXIST);
        MOVS     R0,#+67
        B.N      ??OSTaskDel_1
//  432     }
//  433     if (ptcb == OS_TCB_RESERVED) {                              /* Must not be assigned to Mutex       */
??OSTaskDel_3:
        CMP      R6,#+1
        BNE.N    ??OSTaskDel_4
//  434         OS_EXIT_CRITICAL();
        MOV      R0,R4
        BL       OS_CPU_SR_Restore
//  435         return (OS_ERR_TASK_DEL);
        MOVS     R0,#+61
        B.N      ??OSTaskDel_1
//  436     }
//  437     y            =  ptcb->OSTCBY;
??OSTaskDel_4:
        LDRB     R0,[R6, #+32]
//  438     OSRdyTbl[y] &= ~ptcb->OSTCBBitX;
        LDR.N    R1,??DataTable6_2
        LDRB     R2,[R0, R1]
        LDRB     R3,[R6, #+33]
        BICS     R2,R2,R3
        STRB     R2,[R0, R1]
//  439     if (OSRdyTbl[y] == 0) {                                     /* Make task not ready                 */
        BNE.N    ??OSTaskDel_5
//  440         OSRdyGrp &= ~ptcb->OSTCBBitY;
        LDR.N    R1,??DataTable6_3
        LDRB     R2,[R1, #+0]
        LDRB     R3,[R6, #+34]
        BICS     R2,R2,R3
        STRB     R2,[R1, #+0]
//  441     }
//  442     
//  443 #if OS_EVENT_EN
//  444     pevent = ptcb->OSTCBEventPtr;
??OSTaskDel_5:
        LDR      R1,[R6, #+12]
//  445     if (pevent != (OS_EVENT *)0) {                              /* If task is waiting on event         */
        CBZ.N    R1,??OSTaskDel_6
//  446         pevent->OSEventTbl[y] &= ~ptcb->OSTCBBitX;
        ADDS     R0,R0,R1
        LDRB     R2,[R0, #+11]
        LDRB     R3,[R6, #+33]
        BICS     R2,R2,R3
        STRB     R2,[R0, #+11]
//  447         if (pevent->OSEventTbl[y] == 0) {                       /* ... remove task from ...            */
        LDRB     R0,[R0, #+11]
        CBNZ.N   R0,??OSTaskDel_6
//  448             pevent->OSEventGrp &= ~ptcb->OSTCBBitY;             /* ... event ctrl block                */
        LDRB     R0,[R1, #+10]
        LDRB     R2,[R6, #+34]
        BICS     R0,R0,R2
        STRB     R0,[R1, #+10]
//  449         }
//  450     }
//  451 #endif
//  452 
//  453 #if (OS_FLAG_EN > 0) && (OS_MAX_FLAGS > 0)
//  454     pnode = ptcb->OSTCBFlagNode;
??OSTaskDel_6:
        LDR      R0,[R6, #+20]
//  455     if (pnode != (OS_FLAG_NODE *)0) {                           /* If task is waiting on event flag    */
        CBZ.N    R0,??OSTaskDel_7
//  456         OS_FlagUnlink(pnode);                                   /* Remove from wait list               */
        BL       OS_FlagUnlink
//  457     }
//  458 #endif
//  459 
//  460     ptcb->OSTCBDly      = 0;                                    /* Prevent OSTimeTick() from updating  */
??OSTaskDel_7:
        MOVS     R0,#+0
        STRH     R0,[R6, #+26]
//  461     ptcb->OSTCBStat     = OS_STAT_RDY;                          /* Prevent task from being resumed     */
        STRB     R0,[R6, #+28]
//  462     ptcb->OSTCBStatPend = OS_STAT_PEND_OK;
        STRB     R0,[R6, #+29]
//  463     if (OSLockNesting < 255u) {                                 /* Make sure we don't context switch   */
        LDR.N    R5,??DataTable6_6
        LDRB     R0,[R5, #+0]
        CMP      R0,#+255
        ITT      NE 
        ADDNE    R0,R0,#+1
        STRBNE   R0,[R5, #+0]
//  464         OSLockNesting++;
//  465     }
//  466     OS_EXIT_CRITICAL();                                         /* Enabling INT. ignores next instruc. */
        MOV      R0,R4
        BL       OS_CPU_SR_Restore
//  467     OS_Dummy();                                                 /* ... Dummy ensures that INTs will be */
        BL       OS_Dummy
//  468     OS_ENTER_CRITICAL();                                        /* ... disabled HERE!                  */
        BL       OS_CPU_SR_Save
        MOV      R4,R0
//  469     if (OSLockNesting > 0) {                                    /* Remove context switch lock          */
        LDRB     R0,[R5, #+0]
        CBZ.N    R0,??OSTaskDel_8
//  470         OSLockNesting--;
        SUBS     R0,R0,#+1
        STRB     R0,[R5, #+0]
//  471     }
//  472     OSTaskDelHook(ptcb);                                        /* Call user defined hook              */
??OSTaskDel_8:
        MOV      R0,R6
        BL       OSTaskDelHook
//  473     OSTaskCtr--;                                                /* One less task being managed         */
        LDR.N    R0,??DataTable6_7
        LDRB     R1,[R0, #+0]
        SUBS     R1,R1,#+1
        STRB     R1,[R0, #+0]
//  474     OSTCBPrioTbl[prio] = (OS_TCB *)0;                           /* Clear old priority entry            */
        MOVS     R0,#+0
        STR      R0,[R8, R7, LSL #+2]
//  475     if (ptcb->OSTCBPrev == (OS_TCB *)0) {                       /* Remove from TCB chain               */
        LDR      R0,[R6, #+4]
        LDR      R1,[R6, #+8]
        CBNZ.N   R1,??OSTaskDel_9
//  476         ptcb->OSTCBNext->OSTCBPrev = (OS_TCB *)0;
        STR      R1,[R0, #+8]
//  477         OSTCBList                  = ptcb->OSTCBNext;
        LDR      R0,[R6, #+4]
        LDR.N    R1,??DataTable6_8
        STR      R0,[R1, #+0]
        B.N      ??OSTaskDel_10
//  478     } else {
//  479         ptcb->OSTCBPrev->OSTCBNext = ptcb->OSTCBNext;
??OSTaskDel_9:
        STR      R0,[R1, #+4]
//  480         ptcb->OSTCBNext->OSTCBPrev = ptcb->OSTCBPrev;
        LDR      R0,[R6, #+4]
        LDR      R1,[R6, #+8]
        STR      R1,[R0, #+8]
//  481     }
//  482     ptcb->OSTCBNext   = OSTCBFreeList;                          /* Return TCB to free TCB list         */
??OSTaskDel_10:
        LDR.N    R0,??DataTable6_9
        LDR      R1,[R0, #+0]
        STR      R1,[R6, #+4]
//  483     OSTCBFreeList     = ptcb;
        STR      R6,[R0, #+0]
//  484 #if OS_TASK_NAME_SIZE > 1
//  485     ptcb->OSTCBTaskName[0] = '?';                               /* Unknown name                        */
//  486     ptcb->OSTCBTaskName[1] = OS_ASCII_NUL;
//  487 #endif
//  488     OS_EXIT_CRITICAL();
        MOV      R0,R4
        BL       OS_CPU_SR_Restore
//  489     if (OSRunning == OS_TRUE) {
        LDR.N    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        IT       EQ 
        BLEQ     OS_Sched
//  490         OS_Sched();                                             /* Find new highest priority task      */
//  491     }
//  492     return (OS_ERR_NONE);
        MOVS     R0,#+0
??OSTaskDel_1:
        POP      {R4-R8,PC}       ;; return
//  493 }
//  494 #endif
//  495 /*$PAGE*/
//  496 /*
//  497 *********************************************************************************************************
//  498 *                                    REQUEST THAT A TASK DELETE ITSELF
//  499 *
//  500 * Description: This function is used to:
//  501 *                   a) notify a task to delete itself.
//  502 *                   b) to see if a task requested that the current task delete itself.
//  503 *              This function is a little tricky to understand.  Basically, you have a task that needs
//  504 *              to be deleted however, this task has resources that it has allocated (memory buffers,
//  505 *              semaphores, mailboxes, queues etc.).  The task cannot be deleted otherwise these
//  506 *              resources would not be freed.  The requesting task calls OSTaskDelReq() to indicate that
//  507 *              the task needs to be deleted.  Deleting of the task is however, deferred to the task to
//  508 *              be deleted.  For example, suppose that task #10 needs to be deleted.  The requesting task
//  509 *              example, task #5, would call OSTaskDelReq(10).  When task #10 gets to execute, it calls
//  510 *              this function by specifying OS_PRIO_SELF and monitors the returned value.  If the return
//  511 *              value is OS_ERR_TASK_DEL_REQ, another task requested a task delete.  Task #10 would look like
//  512 *              this:
//  513 *
//  514 *                   void Task(void *p_arg)
//  515 *                   {
//  516 *                       .
//  517 *                       .
//  518 *                       while (1) {
//  519 *                           OSTimeDly(1);
//  520 *                           if (OSTaskDelReq(OS_PRIO_SELF) == OS_ERR_TASK_DEL_REQ) {
//  521 *                               Release any owned resources;
//  522 *                               De-allocate any dynamic memory;
//  523 *                               OSTaskDel(OS_PRIO_SELF);
//  524 *                           }
//  525 *                       }
//  526 *                   }
//  527 *
//  528 * Arguments  : prio    is the priority of the task to request the delete from
//  529 *
//  530 * Returns    : OS_ERR_NONE            if the task exist and the request has been registered
//  531 *              OS_ERR_TASK_NOT_EXIST  if the task has been deleted.  This allows the caller to know whether
//  532 *                                     the request has been executed.
//  533 *              OS_ERR_TASK_DEL        if the task is assigned to a Mutex.
//  534 *              OS_ERR_TASK_DEL_IDLE   if you requested to delete uC/OS-II's idle task
//  535 *              OS_ERR_PRIO_INVALID    if the priority you specify is higher that the maximum allowed
//  536 *                                     (i.e. >= OS_LOWEST_PRIO) or, you have not specified OS_PRIO_SELF.
//  537 *              OS_ERR_TASK_DEL_REQ    if a task (possibly another task) requested that the running task be
//  538 *                                     deleted.
//  539 *********************************************************************************************************
//  540 */
//  541 /*$PAGE*/
//  542 #if OS_TASK_DEL_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  543 INT8U  OSTaskDelReq (INT8U prio)
//  544 {
OSTaskDelReq:
        PUSH     {R4,LR}
        MOV      R4,R0
//  545     INT8U      stat;
//  546     OS_TCB    *ptcb;
//  547 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  548     OS_CPU_SR  cpu_sr = 0;
//  549 #endif
//  550 
//  551 
//  552 
//  553     if (prio == OS_TASK_IDLE_PRIO) {                            /* Not allowed to delete idle task     */
        CMP      R4,#+31
        BNE.N    ??OSTaskDelReq_0
//  554         return (OS_ERR_TASK_DEL_IDLE);
        MOVS     R0,#+62
        POP      {R4,PC}
//  555     }
//  556 #if OS_ARG_CHK_EN > 0
//  557     if (prio >= OS_LOWEST_PRIO) {                               /* Task priority valid ?               */
//  558         if (prio != OS_PRIO_SELF) {
//  559             return (OS_ERR_PRIO_INVALID);
//  560         }
//  561     }
//  562 #endif
//  563     if (prio == OS_PRIO_SELF) {                                 /* See if a task is requesting to ...  */
??OSTaskDelReq_0:
        CMP      R4,#+255
        BNE.N    ??OSTaskDelReq_1
//  564         OS_ENTER_CRITICAL();                                    /* ... this task to delete itself      */
        BL       OS_CPU_SR_Save
//  565         stat = OSTCBCur->OSTCBDelReq;                           /* Return request status to caller     */
        LDR.N    R1,??DataTable6_1
        LDR      R1,[R1, #+0]
        LDRB     R4,[R1, #+35]
//  566         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  567         return (stat);
        MOV      R0,R4
        POP      {R4,PC}
//  568     }
//  569     OS_ENTER_CRITICAL();
??OSTaskDelReq_1:
        BL       OS_CPU_SR_Save
//  570     ptcb = OSTCBPrioTbl[prio];
        LDR.N    R1,??DataTable6
        LDR      R1,[R1, R4, LSL #+2]
//  571     if (ptcb == (OS_TCB *)0) {                                  /* Task to delete must exist           */
        CBNZ.N   R1,??OSTaskDelReq_2
//  572         OS_EXIT_CRITICAL();
        B.N      ?Subroutine0
//  573         return (OS_ERR_TASK_NOT_EXIST);                         /* Task must already be deleted        */
//  574     }
//  575     if (ptcb == OS_TCB_RESERVED) {                              /* Must NOT be assigned to a Mutex     */
??OSTaskDelReq_2:
        CMP      R1,#+1
        BNE.N    ??OSTaskDelReq_3
//  576         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  577         return (OS_ERR_TASK_DEL);
        MOVS     R0,#+61
        POP      {R4,PC}
//  578     }
//  579     ptcb->OSTCBDelReq = OS_ERR_TASK_DEL_REQ;                    /* Set flag indicating task to be DEL. */
??OSTaskDelReq_3:
        MOVS     R2,#+63
        STRB     R2,[R1, #+35]
//  580     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  581     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R4,PC}          ;; return
//  582 }
//  583 #endif
//  584 /*$PAGE*/
//  585 /*
//  586 *********************************************************************************************************
//  587 *                                        GET THE NAME OF A TASK
//  588 *
//  589 * Description: This function is called to obtain the name of a task.
//  590 *
//  591 * Arguments  : prio      is the priority of the task that you want to obtain the name from.
//  592 *
//  593 *              pname     is a pointer to an ASCII string that will receive the name of the task.  The
//  594 *                        string must be able to hold at least OS_TASK_NAME_SIZE characters.
//  595 *
//  596 *              perr      is a pointer to an error code that can contain one of the following values:
//  597 *
//  598 *                        OS_ERR_NONE                if the requested task is resumed
//  599 *                        OS_ERR_TASK_NOT_EXIST      if the task has not been created or is assigned to a Mutex
//  600 *                        OS_ERR_PRIO_INVALID        if you specified an invalid priority:
//  601 *                                                   A higher value than the idle task or not OS_PRIO_SELF.
//  602 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  603 *                        OS_ERR_NAME_GET_ISR        You called this function from an ISR
//  604 *                        
//  605 *
//  606 * Returns    : The length of the string or 0 if the task does not exist.
//  607 *********************************************************************************************************
//  608 */
//  609 
//  610 #if OS_TASK_NAME_SIZE > 1
//  611 INT8U  OSTaskNameGet (INT8U prio, INT8U *pname, INT8U *perr)
//  612 {
//  613     OS_TCB    *ptcb;
//  614     INT8U      len;
//  615 #if OS_CRITICAL_METHOD == 3                              /* Allocate storage for CPU status register   */
//  616     OS_CPU_SR  cpu_sr = 0;
//  617 #endif
//  618 
//  619 
//  620 
//  621 #if OS_ARG_CHK_EN > 0
//  622     if (perr == (INT8U *)0) {                            /* Validate 'perr'                            */
//  623         return (0);
//  624     }
//  625     if (prio > OS_LOWEST_PRIO) {                         /* Task priority valid ?                      */
//  626         if (prio != OS_PRIO_SELF) {
//  627             *perr = OS_ERR_PRIO_INVALID;                 /* No                                         */
//  628             return (0);
//  629         }
//  630     }
//  631     if (pname == (INT8U *)0) {                           /* Is 'pname' a NULL pointer?                 */
//  632         *perr = OS_ERR_PNAME_NULL;                       /* Yes                                        */
//  633         return (0);
//  634     }
//  635 #endif
//  636     if (OSIntNesting > 0) {                              /* See if trying to call from an ISR          */
//  637         *perr = OS_ERR_NAME_GET_ISR;
//  638         return (0);
//  639     }
//  640     OS_ENTER_CRITICAL();
//  641     if (prio == OS_PRIO_SELF) {                          /* See if caller desires it's own name        */
//  642         prio = OSTCBCur->OSTCBPrio;
//  643     }
//  644     ptcb = OSTCBPrioTbl[prio];
//  645     if (ptcb == (OS_TCB *)0) {                           /* Does task exist?                           */
//  646         OS_EXIT_CRITICAL();                              /* No                                         */
//  647         *perr = OS_ERR_TASK_NOT_EXIST;
//  648         return (0);
//  649     }
//  650     if (ptcb == OS_TCB_RESERVED) {                       /* Task assigned to a Mutex?                  */
//  651         OS_EXIT_CRITICAL();                              /* Yes                                        */
//  652         *perr = OS_ERR_TASK_NOT_EXIST;
//  653         return (0);
//  654     }
//  655 	len   = OS_StrCopy(pname, ptcb->OSTCBTaskName);      /* Yes, copy name from TCB                 */
//  656 
//  657 	OS_EXIT_CRITICAL();
//  658 
//  659     *perr = OS_ERR_NONE;
//  660     return (len);
//  661 }
//  662 #endif
//  663 
//  664 /*$PAGE*/
//  665 /*
//  666 *********************************************************************************************************
//  667 *                                        ASSIGN A NAME TO A TASK
//  668 *
//  669 * Description: This function is used to set the name of a task.
//  670 *
//  671 * Arguments  : prio      is the priority of the task that you want the assign a name to.
//  672 *
//  673 *              pname     is a pointer to an ASCII string that contains the name of the task.  The ASCII
//  674 *                        string must be NUL terminated.
//  675 *
//  676 *              perr       is a pointer to an error code that can contain one of the following values:
//  677 *
//  678 *                        OS_ERR_NONE                if the requested task is resumed
//  679 *                        OS_ERR_TASK_NOT_EXIST      if the task has not been created or is assigned to a Mutex
//  680 *                        OS_ERR_TASK_NAME_TOO_LONG  if the name you are giving to the task exceeds the
//  681 *                                                   storage capacity of a task name as specified by
//  682 *                                                   OS_TASK_NAME_SIZE.
//  683 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  684 *                        OS_ERR_PRIO_INVALID        if you specified an invalid priority:
//  685 *                                                   A higher value than the idle task or not OS_PRIO_SELF.
//  686 *                        OS_ERR_NAME_SET_ISR        if you called this function from an ISR
//  687 *
//  688 * Returns    : None
//  689 *********************************************************************************************************
//  690 */
//  691 #if OS_TASK_NAME_SIZE > 1
//  692 void  OSTaskNameSet (INT8U prio, INT8U *pname, INT8U *perr)
//  693 {
//  694     INT8U      len;
//  695     OS_TCB    *ptcb;
//  696 #if OS_CRITICAL_METHOD == 3                          /* Allocate storage for CPU status register       */
//  697     OS_CPU_SR  cpu_sr = 0;
//  698 #endif
//  699 
//  700 
//  701 
//  702 #if OS_ARG_CHK_EN > 0
//  703     if (perr == (INT8U *)0) {                        /* Validate 'perr'                                */
//  704         return;
//  705     }
//  706     if (prio > OS_LOWEST_PRIO) {                     /* Task priority valid ?                          */
//  707         if (prio != OS_PRIO_SELF) {
//  708             *perr = OS_ERR_PRIO_INVALID;             /* No                                             */
//  709             return;
//  710         }
//  711     }
//  712     if (pname == (INT8U *)0) {                       /* Is 'pname' a NULL pointer?                     */
//  713         *perr = OS_ERR_PNAME_NULL;                   /* Yes                                            */
//  714         return;
//  715     }
//  716 #endif
//  717     if (OSIntNesting > 0) {                          /* See if trying to call from an ISR              */
//  718         *perr = OS_ERR_NAME_SET_ISR;
//  719         return;
//  720     }
//  721     OS_ENTER_CRITICAL();
//  722     if (prio == OS_PRIO_SELF) {                      /* See if caller desires to set it's own name     */
//  723         prio = OSTCBCur->OSTCBPrio;
//  724     }
//  725     ptcb = OSTCBPrioTbl[prio];
//  726     if (ptcb == (OS_TCB *)0) {                       /* Does task exist?                               */
//  727         OS_EXIT_CRITICAL();                          /* No                                             */
//  728         *perr = OS_ERR_TASK_NOT_EXIST;
//  729         return;
//  730     }
//  731     if (ptcb == OS_TCB_RESERVED) {                   /* Task assigned to a Mutex?                      */
//  732         OS_EXIT_CRITICAL();                          /* Yes                                            */
//  733         *perr = OS_ERR_TASK_NOT_EXIST;
//  734         return;
//  735     }
//  736     len = OS_StrLen(pname);                          /* Yes, Can we fit the string in the TCB?         */
//  737     if (len > (OS_TASK_NAME_SIZE - 1)) {             /*      No                                        */
//  738         OS_EXIT_CRITICAL();
//  739         *perr = OS_ERR_TASK_NAME_TOO_LONG;
//  740         return;
//  741     }
//  742     (void)OS_StrCopy(ptcb->OSTCBTaskName, pname);    /*      Yes, copy to TCB                          */
//  743     OS_EXIT_CRITICAL();
//  744     *perr = OS_ERR_NONE;
//  745 }
//  746 #endif
//  747 
//  748 /*$PAGE*/
//  749 /*
//  750 *********************************************************************************************************
//  751 *                                        RESUME A SUSPENDED TASK
//  752 *
//  753 * Description: This function is called to resume a previously suspended task.  This is the only call that
//  754 *              will remove an explicit task suspension.
//  755 *
//  756 * Arguments  : prio     is the priority of the task to resume.
//  757 *
//  758 * Returns    : OS_ERR_NONE                if the requested task is resumed
//  759 *              OS_ERR_PRIO_INVALID        if the priority you specify is higher that the maximum allowed
//  760 *                                         (i.e. >= OS_LOWEST_PRIO)
//  761 *              OS_ERR_TASK_RESUME_PRIO    if the task to resume does not exist
//  762 *              OS_ERR_TASK_NOT_EXIST      if the task is assigned to a Mutex PIP
//  763 *              OS_ERR_TASK_NOT_SUSPENDED  if the task to resume has not been suspended
//  764 *********************************************************************************************************
//  765 */
//  766 
//  767 #if OS_TASK_SUSPEND_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  768 INT8U  OSTaskResume (INT8U prio)
//  769 {
OSTaskResume:
        PUSH     {R4,LR}
        MOV      R4,R0
//  770     OS_TCB    *ptcb;
//  771 #if OS_CRITICAL_METHOD == 3                                   /* Storage for CPU status register       */
//  772     OS_CPU_SR  cpu_sr = 0;
//  773 #endif
//  774 
//  775 
//  776 
//  777 #if OS_ARG_CHK_EN > 0
//  778     if (prio >= OS_LOWEST_PRIO) {                             /* Make sure task priority is valid      */
//  779         return (OS_ERR_PRIO_INVALID);
//  780     }
//  781 #endif
//  782     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  783     ptcb = OSTCBPrioTbl[prio];
        LDR.N    R1,??DataTable6
        LDR      R2,[R1, R4, LSL #+2]
//  784     if (ptcb == (OS_TCB *)0) {                                /* Task to suspend must exist            */
        CBNZ.N   R2,??OSTaskResume_0
//  785         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  786         return (OS_ERR_TASK_RESUME_PRIO);
        MOVS     R0,#+70
        POP      {R4,PC}
//  787     }
//  788     if (ptcb == OS_TCB_RESERVED) {                            /* See if assigned to Mutex              */
??OSTaskResume_0:
        CMP      R2,#+1
        BNE.N    ??OSTaskResume_1
//  789         OS_EXIT_CRITICAL();
        B.N      ?Subroutine0
//  790         return (OS_ERR_TASK_NOT_EXIST);
//  791     }
//  792     if ((ptcb->OSTCBStat & OS_STAT_SUSPEND) != OS_STAT_RDY) { /* Task must be suspended                */
??OSTaskResume_1:
        ADDW     R1,R2,#+26
        LDRB     R3,[R1, #+2]
        LSLS     R3,R3,#+28
        BPL.N    ??OSTaskResume_2
//  793         ptcb->OSTCBStat &= ~(INT8U)OS_STAT_SUSPEND;           /* Remove suspension                     */
        LDRB     R3,[R1, #+2]
        ANDS     R3,R3,#0xF7
        STRB     R3,[R1, #+2]
//  794         if (ptcb->OSTCBStat == OS_STAT_RDY) {                 /* See if task is now ready              */
        BNE.N    ??OSTaskResume_3
//  795             if (ptcb->OSTCBDly == 0) {
        LDRH     R2,[R2, #+26]
        CBNZ.N   R2,??OSTaskResume_3
//  796                 OSRdyGrp               |= ptcb->OSTCBBitY;    /* Yes, Make task ready to run           */
        LDR.N    R2,??DataTable6_3
        LDRB     R3,[R2, #+0]
        LDRB     R4,[R1, #+8]
        ORRS     R3,R4,R3
        STRB     R3,[R2, #+0]
        LDRB     R2,[R1, #+6]
        LDR.N    R3,??DataTable6_2
        LDRB     R4,[R2, R3]
        LDRB     R1,[R1, #+7]
        ORRS     R1,R1,R4
        STRB     R1,[R2, R3]
//  797                 OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
//  798                 OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  799                 if (OSRunning == OS_TRUE) {
        LDR.N    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??OSTaskResume_4
//  800                     OS_Sched();                               /* Find new highest priority task        */
        BL       OS_Sched
        B.N      ??OSTaskResume_4
//  801                 }
//  802             } else {
//  803                 OS_EXIT_CRITICAL();
??OSTaskResume_3:
        BL       OS_CPU_SR_Restore
//  804             }
//  805         } else {                                              /* Must be pending on event              */
//  806             OS_EXIT_CRITICAL();
//  807         }
//  808         return (OS_ERR_NONE);
??OSTaskResume_4:
        MOVS     R0,#+0
        POP      {R4,PC}
//  809     }
//  810     OS_EXIT_CRITICAL();
??OSTaskResume_2:
        BL       OS_CPU_SR_Restore
//  811     return (OS_ERR_TASK_NOT_SUSPENDED);
        MOVS     R0,#+68
        POP      {R4,PC}          ;; return
//  812 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        BL       OS_CPU_SR_Restore
        MOVS     R0,#+67
        POP      {R4,PC}
//  813 #endif
//  814 /*$PAGE*/
//  815 /*
//  816 *********************************************************************************************************
//  817 *                                             STACK CHECKING
//  818 *
//  819 * Description: This function is called to check the amount of free memory left on the specified task's
//  820 *              stack.
//  821 *
//  822 * Arguments  : prio          is the task priority
//  823 *
//  824 *              p_stk_data    is a pointer to a data structure of type OS_STK_DATA.
//  825 *
//  826 * Returns    : OS_ERR_NONE            upon success
//  827 *              OS_ERR_PRIO_INVALID    if the priority you specify is higher that the maximum allowed
//  828 *                                     (i.e. > OS_LOWEST_PRIO) or, you have not specified OS_PRIO_SELF.
//  829 *              OS_ERR_TASK_NOT_EXIST  if the desired task has not been created or is assigned to a Mutex PIP
//  830 *              OS_ERR_TASK_OPT        if you did NOT specified OS_TASK_OPT_STK_CHK when the task was created
//  831 *              OS_ERR_PDATA_NULL      if 'p_stk_data' is a NULL pointer
//  832 *********************************************************************************************************
//  833 */
//  834 #if OS_TASK_CREATE_EXT_EN > 0
//  835 INT8U  OSTaskStkChk (INT8U prio, OS_STK_DATA *p_stk_data)
//  836 {
//  837     OS_TCB    *ptcb;
//  838     OS_STK    *pchk;
//  839     INT32U     free;
//  840     INT32U     size;
//  841 #if OS_CRITICAL_METHOD == 3                            /* Allocate storage for CPU status register     */
//  842     OS_CPU_SR  cpu_sr = 0;
//  843 #endif
//  844 
//  845 
//  846 
//  847 #if OS_ARG_CHK_EN > 0
//  848     if (prio > OS_LOWEST_PRIO) {                       /* Make sure task priority is valid             */
//  849         if (prio != OS_PRIO_SELF) {
//  850             return (OS_ERR_PRIO_INVALID);
//  851         }
//  852     }
//  853     if (p_stk_data == (OS_STK_DATA *)0) {              /* Validate 'p_stk_data'                        */
//  854         return (OS_ERR_PDATA_NULL);
//  855     }
//  856 #endif
//  857     p_stk_data->OSFree = 0;                            /* Assume failure, set to 0 size                */
//  858     p_stk_data->OSUsed = 0;
//  859     OS_ENTER_CRITICAL();
//  860     if (prio == OS_PRIO_SELF) {                        /* See if check for SELF                        */
//  861         prio = OSTCBCur->OSTCBPrio;
//  862     }
//  863     ptcb = OSTCBPrioTbl[prio];
//  864     if (ptcb == (OS_TCB *)0) {                         /* Make sure task exist                         */
//  865         OS_EXIT_CRITICAL();
//  866         return (OS_ERR_TASK_NOT_EXIST);
//  867     }
//  868     if (ptcb == OS_TCB_RESERVED) {
//  869         OS_EXIT_CRITICAL();
//  870         return (OS_ERR_TASK_NOT_EXIST);
//  871     }
//  872     if ((ptcb->OSTCBOpt & OS_TASK_OPT_STK_CHK) == 0) { /* Make sure stack checking option is set       */
//  873         OS_EXIT_CRITICAL();
//  874         return (OS_ERR_TASK_OPT);
//  875     }
//  876     free = 0;
//  877     size = ptcb->OSTCBStkSize;
//  878     pchk = ptcb->OSTCBStkBottom;
//  879     OS_EXIT_CRITICAL();
//  880 #if OS_STK_GROWTH == 1
//  881     while (*pchk++ == (OS_STK)0) {                    /* Compute the number of zero entries on the stk */
//  882         free++;
//  883     }
//  884 #else
//  885     while (*pchk-- == (OS_STK)0) {
//  886         free++;
//  887     }
//  888 #endif
//  889     p_stk_data->OSFree = free * sizeof(OS_STK);           /* Compute number of free bytes on the stack */
//  890     p_stk_data->OSUsed = (size - free) * sizeof(OS_STK);  /* Compute number of bytes used on the stack */
//  891     return (OS_ERR_NONE);
//  892 }
//  893 #endif
//  894 /*$PAGE*/
//  895 /*
//  896 *********************************************************************************************************
//  897 *                                            SUSPEND A TASK
//  898 *
//  899 * Description: This function is called to suspend a task.  The task can be the calling task if the
//  900 *              priority passed to OSTaskSuspend() is the priority of the calling task or OS_PRIO_SELF.
//  901 *
//  902 * Arguments  : prio     is the priority of the task to suspend.  If you specify OS_PRIO_SELF, the
//  903 *                       calling task will suspend itself and rescheduling will occur.
//  904 *
//  905 * Returns    : OS_ERR_NONE               if the requested task is suspended
//  906 *              OS_ERR_TASK_SUSPEND_IDLE  if you attempted to suspend the idle task which is not allowed.
//  907 *              OS_ERR_PRIO_INVALID       if the priority you specify is higher that the maximum allowed
//  908 *                                        (i.e. >= OS_LOWEST_PRIO) or, you have not specified OS_PRIO_SELF.
//  909 *              OS_ERR_TASK_SUSPEND_PRIO  if the task to suspend does not exist
//  910 *              OS_ERR_TASK_NOT_EXITS     if the task is assigned to a Mutex PIP
//  911 *
//  912 * Note       : You should use this function with great care.  If you suspend a task that is waiting for
//  913 *              an event (i.e. a message, a semaphore, a queue ...) you will prevent this task from
//  914 *              running when the event arrives.
//  915 *********************************************************************************************************
//  916 */
//  917 
//  918 #if OS_TASK_SUSPEND_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  919 INT8U  OSTaskSuspend (INT8U prio)
//  920 {
OSTaskSuspend:
        PUSH     {R3-R7,LR}
        MOV      R5,R0
//  921     BOOLEAN    self;
//  922     OS_TCB    *ptcb;
//  923     INT8U      y;
//  924 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  925     OS_CPU_SR  cpu_sr = 0;
//  926 #endif
//  927 
//  928 
//  929 
//  930 #if OS_ARG_CHK_EN > 0
//  931     if (prio == OS_TASK_IDLE_PRIO) {                            /* Not allowed to suspend idle task    */
//  932         return (OS_ERR_TASK_SUSPEND_IDLE);
//  933     }
//  934     if (prio >= OS_LOWEST_PRIO) {                               /* Task priority valid ?               */
//  935         if (prio != OS_PRIO_SELF) {
//  936             return (OS_ERR_PRIO_INVALID);
//  937         }
//  938     }
//  939 #endif
//  940     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        LDR.N    R1,??DataTable6_1
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+30]
        CMP      R5,#+255
        BNE.N    ??OSTaskSuspend_0
//  941     if (prio == OS_PRIO_SELF) {                                 /* See if suspend SELF                 */
//  942         prio = OSTCBCur->OSTCBPrio;
        MOV      R5,R1
//  943         self = OS_TRUE;
??OSTaskSuspend_1:
        MOVS     R4,#+1
        B.N      ??OSTaskSuspend_2
//  944     } else if (prio == OSTCBCur->OSTCBPrio) {                   /* See if suspending self              */
??OSTaskSuspend_0:
        CMP      R5,R1
        BEQ.N    ??OSTaskSuspend_1
//  945         self = OS_TRUE;
//  946     } else {
//  947         self = OS_FALSE;                                        /* No suspending another task          */
        MOVS     R4,#+0
//  948     }
//  949     ptcb = OSTCBPrioTbl[prio];
??OSTaskSuspend_2:
        LDR.N    R1,??DataTable6
        LDR      R1,[R1, R5, LSL #+2]
//  950     if (ptcb == (OS_TCB *)0) {                                  /* Task to suspend must exist          */
        CBNZ.N   R1,??OSTaskSuspend_3
//  951         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  952         return (OS_ERR_TASK_SUSPEND_PRIO);
        MOVS     R0,#+72
        POP      {R1,R4-R7,PC}
//  953     }
//  954     if (ptcb == OS_TCB_RESERVED) {                              /* See if assigned to Mutex            */
??OSTaskSuspend_3:
        CMP      R1,#+1
        BNE.N    ??OSTaskSuspend_4
//  955         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  956         return (OS_ERR_TASK_NOT_EXIST);
        MOVS     R0,#+67
        POP      {R1,R4-R7,PC}
//  957     }
//  958     y            = ptcb->OSTCBY;
??OSTaskSuspend_4:
        ADDW     R2,R1,#+28
        LDRB     R3,[R2, #+4]
//  959     OSRdyTbl[y] &= ~ptcb->OSTCBBitX;                            /* Make task not ready                 */
        LDR.N    R5,??DataTable6_2
        LDRB     R6,[R3, R5]
        LDRB     R7,[R2, #+5]
        BICS     R6,R6,R7
        STRB     R6,[R3, R5]
//  960     if (OSRdyTbl[y] == 0) {
        BNE.N    ??OSTaskSuspend_5
//  961         OSRdyGrp &= ~ptcb->OSTCBBitY;
        LDR.N    R3,??DataTable6_3
        LDRB     R5,[R3, #+0]
        LDRB     R2,[R2, #+6]
        BIC      R2,R5,R2
        STRB     R2,[R3, #+0]
//  962     }
//  963     ptcb->OSTCBStat |= OS_STAT_SUSPEND;                         /* Status of task is 'SUSPENDED'       */
??OSTaskSuspend_5:
        LDRB     R2,[R1, #+28]
        ORR      R2,R2,#0x8
        STRB     R2,[R1, #+28]
//  964     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  965     if (self == OS_TRUE) {                                      /* Context switch only if SELF         */
        CMP      R4,#+0
        IT       NE 
        BLNE     OS_Sched
//  966         OS_Sched();                                             /* Find new highest priority task      */
//  967     }
//  968     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}    ;; return
//  969 }
//  970 #endif
//  971 /*$PAGE*/
//  972 /*
//  973 *********************************************************************************************************
//  974 *                                            QUERY A TASK
//  975 *
//  976 * Description: This function is called to obtain a copy of the desired task's TCB.
//  977 *
//  978 * Arguments  : prio         is the priority of the task to obtain information from.
//  979 *
//  980 *              p_task_data  is a pointer to where the desired task's OS_TCB will be stored.
//  981 *
//  982 * Returns    : OS_ERR_NONE            if the requested task is suspended
//  983 *              OS_ERR_PRIO_INVALID    if the priority you specify is higher that the maximum allowed
//  984 *                                     (i.e. > OS_LOWEST_PRIO) or, you have not specified OS_PRIO_SELF.
//  985 *              OS_ERR_PRIO            if the desired task has not been created
//  986 *              OS_ERR_TASK_NOT_EXIST  if the task is assigned to a Mutex PIP
//  987 *              OS_ERR_PDATA_NULL      if 'p_task_data' is a NULL pointer
//  988 *********************************************************************************************************
//  989 */
//  990 
//  991 #if OS_TASK_QUERY_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  992 INT8U  OSTaskQuery (INT8U prio, OS_TCB *p_task_data)
//  993 {
OSTaskQuery:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
//  994     OS_TCB    *ptcb;
//  995 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  996     OS_CPU_SR  cpu_sr = 0;
//  997 #endif
//  998 
//  999 
// 1000 
// 1001 #if OS_ARG_CHK_EN > 0
// 1002     if (prio > OS_LOWEST_PRIO) {                 /* Task priority valid ?                              */
// 1003         if (prio != OS_PRIO_SELF) {
// 1004             return (OS_ERR_PRIO_INVALID);
// 1005         }
// 1006     }
// 1007     if (p_task_data == (OS_TCB *)0) {            /* Validate 'p_task_data'                             */
// 1008         return (OS_ERR_PDATA_NULL);
// 1009     }
// 1010 #endif
// 1011     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R6,R0
// 1012     if (prio == OS_PRIO_SELF) {                  /* See if suspend SELF                                */
        CMP      R4,#+255
        BNE.N    ??OSTaskQuery_0
// 1013         prio = OSTCBCur->OSTCBPrio;
        LDR.N    R0,??DataTable6_1
        LDR      R0,[R0, #+0]
        LDRB     R4,[R0, #+30]
// 1014     }
// 1015     ptcb = OSTCBPrioTbl[prio];
??OSTaskQuery_0:
        LDR.N    R0,??DataTable6
        LDR      R1,[R0, R4, LSL #+2]
// 1016     if (ptcb == (OS_TCB *)0) {                   /* Task to query must exist                           */
        CBNZ.N   R1,??OSTaskQuery_1
// 1017         OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
// 1018         return (OS_ERR_PRIO);
        MOVS     R0,#+41
        POP      {R4-R6,PC}
// 1019     }
// 1020     if (ptcb == OS_TCB_RESERVED) {               /* Task to query must not be assigned to a Mutex      */
??OSTaskQuery_1:
        CMP      R1,#+1
        BNE.N    ??OSTaskQuery_2
// 1021         OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
// 1022         return (OS_ERR_TASK_NOT_EXIST);
        MOVS     R0,#+67
        POP      {R4-R6,PC}
// 1023     }
// 1024                                                  /* Copy TCB into user storage area                    */
// 1025     OS_MemCopy((INT8U *)p_task_data, (INT8U *)ptcb, sizeof(OS_TCB));
??OSTaskQuery_2:
        MOVS     R2,#+56
        MOV      R0,R5
        BL       OS_MemCopy
// 1026     OS_EXIT_CRITICAL();
        MOV      R0,R6
        BL       OS_CPU_SR_Restore
// 1027     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R4-R6,PC}       ;; return
// 1028 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     OSTCBPrioTbl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     OSTCBCur

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     OSRdyTbl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     OSRdyGrp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     OSRunning

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     OSLockNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     OSTaskCtr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     OSTCBList

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     OSTCBFreeList

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 1029 #endif
// 1030 /*$PAGE*/
// 1031 /*
// 1032 *********************************************************************************************************
// 1033 *                                        CLEAR TASK STACK
// 1034 *
// 1035 * Description: This function is used to clear the stack of a task (i.e. write all zeros)
// 1036 *
// 1037 * Arguments  : pbos     is a pointer to the task's bottom of stack.  If the configuration constant
// 1038 *                       OS_STK_GROWTH is set to 1, the stack is assumed to grow downward (i.e. from high
// 1039 *                       memory to low memory).  'pbos' will thus point to the lowest (valid) memory
// 1040 *                       location of the stack.  If OS_STK_GROWTH is set to 0, 'pbos' will point to the
// 1041 *                       highest memory location of the stack and the stack will grow with increasing
// 1042 *                       memory locations.  'pbos' MUST point to a valid 'free' data item.
// 1043 *
// 1044 *              size     is the number of 'stack elements' to clear.
// 1045 *
// 1046 *              opt      contains additional information (or options) about the behavior of the task.  The
// 1047 *                       LOWER 8-bits are reserved by uC/OS-II while the upper 8 bits can be application
// 1048 *                       specific.  See OS_TASK_OPT_??? in uCOS-II.H.
// 1049 *
// 1050 * Returns    : none
// 1051 *********************************************************************************************************
// 1052 */
// 1053 #if OS_TASK_CREATE_EXT_EN > 0
// 1054 void  OS_TaskStkClr (OS_STK *pbos, INT32U size, INT16U opt)
// 1055 {
// 1056     if ((opt & OS_TASK_OPT_STK_CHK) != 0x0000) {       /* See if stack checking has been enabled       */
// 1057         if ((opt & OS_TASK_OPT_STK_CLR) != 0x0000) {   /* See if stack needs to be cleared             */
// 1058 #if OS_STK_GROWTH == 1
// 1059             while (size > 0) {                         /* Stack grows from HIGH to LOW memory          */
// 1060                 size--;
// 1061                 *pbos++ = (OS_STK)0;                   /* Clear from bottom of stack and up!           */
// 1062             }
// 1063 #else
// 1064             while (size > 0) {                         /* Stack grows from LOW to HIGH memory          */
// 1065                 size--;
// 1066                 *pbos-- = (OS_STK)0;                   /* Clear from bottom of stack and down          */
// 1067             }
// 1068 #endif
// 1069         }
// 1070     }
// 1071 }
// 1072 
// 1073 #endif
// 
// 1 070 bytes in section .text
// 
// 1 070 bytes of CODE memory
//
//Errors: none
//Warnings: none
