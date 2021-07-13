///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:43 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\os_time.c                                          /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\So /
//                    urce\os_time.c -D _MIMO_Type -lcN                       /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\os_ti /
//                    me.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_time

        EXTERN OSIntNesting
        EXTERN OSRdyGrp
        EXTERN OSRdyTbl
        EXTERN OSTCBCur
        EXTERN OSTCBPrioTbl
        EXTERN OSTime
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_Sched

        PUBLIC OSTimeDly
        PUBLIC OSTimeDlyHMSM
        PUBLIC OSTimeDlyResume
        PUBLIC OSTimeGet
        PUBLIC OSTimeSet

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Source\os_time.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                             TIME MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_TIME.C
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
//   29 /*
//   30 *********************************************************************************************************
//   31 *                                DELAY TASK 'n' TICKS   (n from 0 to 65535)
//   32 *
//   33 * Description: This function is called to delay execution of the currently running task until the
//   34 *              specified number of system ticks expires.  This, of course, directly equates to delaying
//   35 *              the current task for some time to expire.  No delay will result If the specified delay is
//   36 *              0.  If the specified delay is greater than 0 then, a context switch will result.
//   37 *
//   38 * Arguments  : ticks     is the time delay that the task will be suspended in number of clock 'ticks'.
//   39 *                        Note that by specifying 0, the task will not be delayed.
//   40 *
//   41 * Returns    : none
//   42 *********************************************************************************************************
//   43 */
//   44 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   45 void  OSTimeDly (INT16U ticks)
//   46 {
OSTimeDly:
        PUSH     {R3-R7,LR}
        MOV      R4,R0
//   47     INT8U      y;
//   48 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//   49     OS_CPU_SR  cpu_sr = 0;
//   50 #endif
//   51 
//   52 
//   53 
//   54     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
        LDR.N    R0,??DataTable3  ;; OSIntNesting
        LDRB     R0,[R0, #+0]
        CBNZ     R0,??OSTimeDly_0
//   55         return;
//   56     }
//   57     if (ticks > 0) {                             /* 0 means no delay!                                  */
        CBZ      R4,??OSTimeDly_0
//   58         OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//   59         y            =  OSTCBCur->OSTCBY;        /* Delay current task                                 */
        LDR.N    R1,??OSTimeDly_1  ;; OSTCBCur
        LDR      R1,[R1, #+0]
        ADD      R2,R1,#+26
        LDRB     R3,[R2, #+6]
//   60         OSRdyTbl[y] &= ~OSTCBCur->OSTCBBitX;
        LDR.N    R5,??DataTable5  ;; OSRdyTbl
        LDRB     R6,[R3, R5]
        LDRB     R7,[R2, #+7]
        MVNS     R7,R7
        ANDS     R6,R7,R6
        STRB     R6,[R3, R5]
//   61         if (OSRdyTbl[y] == 0) {
        BNE.N    ??OSTimeDly_2
//   62             OSRdyGrp &= ~OSTCBCur->OSTCBBitY;
        LDR.N    R3,??DataTable4  ;; OSRdyGrp
        LDRB     R5,[R3, #+0]
        LDRB     R2,[R2, #+8]
        MVNS     R2,R2
        ANDS     R2,R2,R5
        STRB     R2,[R3, #+0]
//   63         }
//   64         OSTCBCur->OSTCBDly = ticks;              /* Load ticks in TCB                                  */
??OSTimeDly_2:
        STRH     R4,[R1, #+26]
//   65         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//   66         OS_Sched();                              /* Find next task to run!                             */
        BL       OS_Sched
??OSTimeDly_0:
        POP      {R0,R4-R7,PC}    ;; return
        DATA
??OSTimeDly_1:
        DC32     OSTCBCur
//   67     }
//   68 }
//   69 /*$PAGE*/
//   70 /*
//   71 *********************************************************************************************************
//   72 *                                     DELAY TASK FOR SPECIFIED TIME
//   73 *
//   74 * Description: This function is called to delay execution of the currently running task until some time
//   75 *              expires.  This call allows you to specify the delay time in HOURS, MINUTES, SECONDS and
//   76 *              MILLISECONDS instead of ticks.
//   77 *
//   78 * Arguments  : hours     specifies the number of hours that the task will be delayed (max. is 255)
//   79 *              minutes   specifies the number of minutes (max. 59)
//   80 *              seconds   specifies the number of seconds (max. 59)
//   81 *              milli     specifies the number of milliseconds (max. 999)
//   82 *
//   83 * Returns    : OS_ERR_NONE
//   84 *              OS_ERR_TIME_INVALID_MINUTES
//   85 *              OS_ERR_TIME_INVALID_SECONDS
//   86 *              OS_ERR_TIME_INVALID_MS
//   87 *              OS_ERR_TIME_ZERO_DLY
//   88 *              OS_ERR_TIME_DLY_ISR
//   89 *
//   90 * Note(s)    : The resolution on the milliseconds depends on the tick rate.  For example, you can't do
//   91 *              a 10 mS delay if the ticker interrupts every 100 mS.  In this case, the delay would be
//   92 *              set to 0.  The actual delay is rounded to the nearest tick.
//   93 *********************************************************************************************************
//   94 */
//   95 
//   96 #if OS_TIME_DLY_HMSM_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   97 INT8U  OSTimeDlyHMSM (INT8U hours, INT8U minutes, INT8U seconds, INT16U ms)
//   98 {
OSTimeDlyHMSM:
        PUSH     {R4-R6,LR}
//   99     INT32U ticks;
//  100     INT16U loops;
//  101 
//  102 
//  103     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
        LDR.N    R4,??DataTable3  ;; OSIntNesting
        LDRB     R4,[R4, #+0]
        CMP      R4,#+0
        BEQ.N    ??OSTimeDlyHMSM_0
//  104         return (OS_ERR_TIME_DLY_ISR);
        MOVS     R0,#+85
        POP      {R4-R6,PC}
//  105     }
//  106 #if OS_ARG_CHK_EN > 0
//  107     if (hours == 0) {
//  108         if (minutes == 0) {
//  109             if (seconds == 0) {
//  110                 if (ms == 0) {
//  111                     return (OS_ERR_TIME_ZERO_DLY);
//  112                 }
//  113             }
//  114         }
//  115     }
//  116     if (minutes > 59) {
//  117         return (OS_ERR_TIME_INVALID_MINUTES);    /* Validate arguments to be within range              */
//  118     }
//  119     if (seconds > 59) {
//  120         return (OS_ERR_TIME_INVALID_SECONDS);
//  121     }
//  122     if (ms > 999) {
//  123         return (OS_ERR_TIME_INVALID_MS);
//  124     }
//  125 #endif
//  126                                                  /* Compute the total number of clock ticks required.. */
//  127                                                  /* .. (rounded to the nearest tick)                   */
//  128     ticks = ((INT32U)hours * 3600L + (INT32U)minutes * 60L + (INT32U)seconds) * OS_TICKS_PER_SEC
//  129           + OS_TICKS_PER_SEC * ((INT32U)ms + 500L / OS_TICKS_PER_SEC) / 1000L;
??OSTimeDlyHMSM_0:
        MOV      R4,#+1000
        MOV      R5,#+3600
        MOVS     R6,#+60
        MULS     R1,R1,R6
        MLA      R0,R0,R5,R1
        ADDS     R0,R2,R0
        MUL      R1,R3,R4
        UDIV     R1,R1,R4
        MLA      R0,R0,R4,R1
//  130     loops = (INT16U)(ticks >> 16);               /* Compute the integral number of 65536 tick delays   */
        LSRS     R4,R0,#+16
//  131     ticks = ticks & 0xFFFFL;                     /* Obtain  the fractional number of ticks             */
//  132     OSTimeDly((INT16U)ticks);
        UXTH     R0,R0
        BL       OSTimeDly
        MOVW     R5,#+65535
        B.N      ??OSTimeDlyHMSM_1
//  133     while (loops > 0) {
//  134         OSTimeDly((INT16U)32768u);
??OSTimeDlyHMSM_2:
        MOV      R0,#+32768
        BL       OSTimeDly
//  135         OSTimeDly((INT16U)32768u);
        MOV      R0,#+32768
        BL       OSTimeDly
//  136         loops--;
        ADDS     R4,R5,R4
        UXTH     R4,R4
//  137     }
??OSTimeDlyHMSM_1:
        MOVS     R0,R4
        BNE.N    ??OSTimeDlyHMSM_2
//  138     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R4-R6,PC}       ;; return
//  139 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable3:
        DC32     OSIntNesting
//  140 #endif
//  141 /*$PAGE*/
//  142 /*
//  143 *********************************************************************************************************
//  144 *                                         RESUME A DELAYED TASK
//  145 *
//  146 * Description: This function is used resume a task that has been delayed through a call to either
//  147 *              OSTimeDly() or OSTimeDlyHMSM().  Note that you can call this function to resume a
//  148 *              task that is waiting for an event with timeout.  This would make the task look
//  149 *              like a timeout occurred.
//  150 *
//  151 *              Also, you cannot resume a task that has called OSTimeDlyHMSM() with a combined time that
//  152 *              exceeds 65535 clock ticks.  In other words, if the clock tick runs at 100 Hz then, you will
//  153 *              not be able to resume a delayed task that called OSTimeDlyHMSM(0, 10, 55, 350) or higher:
//  154 *
//  155 *                  (10 Minutes * 60 + 55 Seconds + 0.35) * 100 ticks/second.
//  156 *
//  157 * Arguments  : prio                      specifies the priority of the task to resume
//  158 *
//  159 * Returns    : OS_ERR_NONE               Task has been resumed
//  160 *              OS_ERR_PRIO_INVALID       if the priority you specify is higher that the maximum allowed
//  161 *                                        (i.e. >= OS_LOWEST_PRIO)
//  162 *              OS_ERR_TIME_NOT_DLY       Task is not waiting for time to expire
//  163 *              OS_ERR_TASK_NOT_EXIST     The desired task has not been created or has been assigned to a Mutex.
//  164 *********************************************************************************************************
//  165 */
//  166 
//  167 #if OS_TIME_DLY_RESUME_EN > 0

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  168 INT8U  OSTimeDlyResume (INT8U prio)
//  169 {
OSTimeDlyResume:
        PUSH     {R4,LR}
        MOV      R4,R0
//  170     OS_TCB    *ptcb;
//  171 #if OS_CRITICAL_METHOD == 3                                    /* Storage for CPU status register      */
//  172     OS_CPU_SR  cpu_sr = 0;
//  173 #endif
//  174 
//  175 
//  176 
//  177     if (prio >= OS_LOWEST_PRIO) {
        CMP      R4,#+31
        BCC.N    ??OSTimeDlyResume_0
//  178         return (OS_ERR_PRIO_INVALID);
        MOVS     R0,#+42
        POP      {R4,PC}
//  179     }
//  180     OS_ENTER_CRITICAL();
??OSTimeDlyResume_0:
        BL       OS_CPU_SR_Save
//  181     ptcb = OSTCBPrioTbl[prio];                                 /* Make sure that task exist            */
        LDR.N    R1,??OSTimeDlyResume_1  ;; OSTCBPrioTbl
        LDR      R1,[R1, R4, LSL #+2]
//  182     if (ptcb == (OS_TCB *)0) {
        CBNZ     R1,??OSTimeDlyResume_2
//  183         OS_EXIT_CRITICAL();
??OSTimeDlyResume_3:
        BL       OS_CPU_SR_Restore
//  184         return (OS_ERR_TASK_NOT_EXIST);                        /* The task does not exist              */
        MOVS     R0,#+67
        POP      {R4,PC}
//  185     }
//  186     if (ptcb == OS_TCB_RESERVED) {
??OSTimeDlyResume_2:
        CMP      R1,#+1
        BEQ.N    ??OSTimeDlyResume_3
//  187         OS_EXIT_CRITICAL();
//  188         return (OS_ERR_TASK_NOT_EXIST);                        /* The task does not exist              */
//  189     }
//  190     if (ptcb->OSTCBDly == 0) {                                 /* See if task is delayed               */
        LDRH     R2,[R1, #+26]
        CBNZ     R2,??OSTimeDlyResume_4
//  191         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  192         return (OS_ERR_TIME_NOT_DLY);                          /* Indicate that task was not delayed   */
        MOVS     R0,#+80
        POP      {R4,PC}
//  193     }
//  194 
//  195     ptcb->OSTCBDly = 0;                                        /* Clear the time delay                 */
??OSTimeDlyResume_4:
        MOVS     R2,#+0
        STRH     R2,[R1, #+26]
//  196     if ((ptcb->OSTCBStat & OS_STAT_PEND_ANY) != OS_STAT_RDY) {
        ADDS     R1,R1,#+26
        LDRB     R2,[R1, #+2]
        BICS     R2,R2,#0xC8
        BEQ.N    ??OSTimeDlyResume_5
//  197         ptcb->OSTCBStat     &= ~OS_STAT_PEND_ANY;              /* Yes, Clear status flag               */
        LDRB     R2,[R1, #+2]
        BIC      R2,R2,#0x37
        STRB     R2,[R1, #+2]
//  198         ptcb->OSTCBStatPend  =  OS_STAT_PEND_TO;               /* Indicate PEND timeout                */
        MOVS     R2,#+1
        B.N      ??OSTimeDlyResume_6
//  199     } else {
//  200         ptcb->OSTCBStatPend  =  OS_STAT_PEND_OK;
??OSTimeDlyResume_5:
        MOVS     R2,#+0
??OSTimeDlyResume_6:
        STRB     R2,[R1, #+3]
//  201     }
//  202     if ((ptcb->OSTCBStat & OS_STAT_SUSPEND) == OS_STAT_RDY) {  /* Is task suspended?                   */
        LDRB     R2,[R1, #+2]
        TST      R2,#0x8
        BNE.N    ??OSTimeDlyResume_7
//  203         OSRdyGrp               |= ptcb->OSTCBBitY;             /* No,  Make ready                      */
        LDR.N    R2,??DataTable4  ;; OSRdyGrp
        LDRB     R3,[R2, #+0]
        LDRB     R4,[R1, #+8]
        ORRS     R3,R4,R3
        STRB     R3,[R2, #+0]
        LDRB     R2,[R1, #+6]
        LDR.N    R3,??DataTable5  ;; OSRdyTbl
        LDRB     R4,[R2, R3]
        LDRB     R1,[R1, #+7]
        ORRS     R1,R1,R4
        STRB     R1,[R2, R3]
//  204         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
//  205         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  206         OS_Sched();                                            /* See if this is new highest priority  */
        BL       OS_Sched
        B.N      ??OSTimeDlyResume_8
//  207     } else {
//  208         OS_EXIT_CRITICAL();                                    /* Task may be suspended                */
??OSTimeDlyResume_7:
        BL       OS_CPU_SR_Restore
//  209     }
//  210     return (OS_ERR_NONE);
??OSTimeDlyResume_8:
        MOVS     R0,#+0
        POP      {R4,PC}          ;; return
        Nop      
        DATA
??OSTimeDlyResume_1:
        DC32     OSTCBPrioTbl
//  211 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable4:
        DC32     OSRdyGrp

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     OSRdyTbl
//  212 #endif
//  213 /*$PAGE*/
//  214 /*
//  215 *********************************************************************************************************
//  216 *                                         GET CURRENT SYSTEM TIME
//  217 *
//  218 * Description: This function is used by your application to obtain the current value of the 32-bit
//  219 *              counter which keeps track of the number of clock ticks.
//  220 *
//  221 * Arguments  : none
//  222 *
//  223 * Returns    : The current value of OSTime
//  224 *********************************************************************************************************
//  225 */
//  226 
//  227 #if OS_TIME_GET_SET_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  228 INT32U  OSTimeGet (void)
//  229 {
OSTimeGet:
        PUSH     {R4,LR}
//  230     INT32U     ticks;
//  231 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  232     OS_CPU_SR  cpu_sr = 0;
//  233 #endif
//  234 
//  235 
//  236 
//  237     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  238     ticks = OSTime;
        LDR.N    R1,??DataTable7  ;; OSTime
        LDR      R4,[R1, #+0]
//  239     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  240     return (ticks);
        MOV      R0,R4
        POP      {R4,PC}          ;; return
//  241 }
//  242 #endif
//  243 
//  244 /*
//  245 *********************************************************************************************************
//  246 *                                            SET SYSTEM CLOCK
//  247 *
//  248 * Description: This function sets the 32-bit counter which keeps track of the number of clock ticks.
//  249 *
//  250 * Arguments  : ticks      specifies the new value that OSTime needs to take.
//  251 *
//  252 * Returns    : none
//  253 *********************************************************************************************************
//  254 */
//  255 
//  256 #if OS_TIME_GET_SET_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  257 void  OSTimeSet (INT32U ticks)
//  258 {
OSTimeSet:
        PUSH     {R4,LR}
        MOV      R4,R0
//  259 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  260     OS_CPU_SR  cpu_sr = 0;
//  261 #endif
//  262 
//  263 
//  264 
//  265     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  266     OSTime = ticks;
        LDR.N    R1,??DataTable7  ;; OSTime
        STR      R4,[R1, #+0]
//  267     OS_EXIT_CRITICAL();
        POP      {R4,LR}
        B.W      OS_CPU_SR_Restore
//  268 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     OSTime

        END
//  269 #endif
// 
// 340 bytes in section .text
// 
// 340 bytes of CODE memory
//
//Errors: none
//Warnings: none
