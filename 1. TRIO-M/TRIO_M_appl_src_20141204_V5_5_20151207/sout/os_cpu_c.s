///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:17 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Po /
//                    rts\os_cpu_c.c                                          /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Po /
//                    rts\os_cpu_c.c -D _MIMO_Type -lcN                       /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\os_cp /
//                    u_c.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_cpu_c

        PUBLIC OSInitHookBegin
        PUBLIC OSInitHookEnd
        PUBLIC OSTCBInitHook
        PUBLIC OSTaskCreateHook
        PUBLIC OSTaskDelHook
        PUBLIC OSTaskIdleHook
        PUBLIC OSTaskStatHook
        PUBLIC OSTaskStkInit
        PUBLIC OSTaskSwHook
        PUBLIC OSTimeTickHook

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uCOS-II\Ports\os_cpu_c.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                               uC/OS-II
//    4 *                                         The Real-Time Kernel
//    5 *
//    6 *
//    7 *                                (c) Copyright 2006, Micrium, Weston, FL
//    8 *                                          All Rights Reserved
//    9 *
//   10 *                                           Generic ARM Port
//   11 *
//   12 * File      : OS_CPU_C.C
//   13 * Version   : V2.84
//   14 * By        : Jean J. Labrosse
//   15 *
//   16 * For       : ARMv7M Cortex-M3
//   17 * Mode      : Thumb2
//   18 * Toolchain : IAR EWARM
//   19 *********************************************************************************************************
//   20 */
//   21 
//   22 #define  OS_CPU_GLOBALS
//   23 
//   24 #include <ucos_ii.h>
//   25 
//   26 /*
//   27 *********************************************************************************************************
//   28 *                                          LOCAL VARIABLES
//   29 *********************************************************************************************************
//   30 */
//   31 
//   32 #if OS_TMR_EN > 0
//   33 static  INT16U  OSTmrCtr;
//   34 #endif
//   35 
//   36 /*
//   37 *********************************************************************************************************
//   38 *                                       OS INITIALIZATION HOOK
//   39 *                                            (BEGINNING)
//   40 *
//   41 * Description: This function is called by OSInit() at the beginning of OSInit().
//   42 *
//   43 * Arguments  : none
//   44 *
//   45 * Note(s)    : 1) Interrupts should be disabled during this call.
//   46 *********************************************************************************************************
//   47 */
//   48 #if OS_CPU_HOOKS_EN > 0 && OS_VERSION > 203

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void  OSInitHookBegin (void)
//   50 {
//   51 #if OS_TMR_EN > 0
//   52     OSTmrCtr = 0;
//   53 #endif
//   54 }
OSInitHookBegin:
        BX       LR               ;; return
//   55 #endif
//   56 
//   57 /*
//   58 *********************************************************************************************************
//   59 *                                       OS INITIALIZATION HOOK
//   60 *                                               (END)
//   61 *
//   62 * Description: This function is called by OSInit() at the end of OSInit().
//   63 *
//   64 * Arguments  : none
//   65 *
//   66 * Note(s)    : 1) Interrupts should be disabled during this call.
//   67 *********************************************************************************************************
//   68 */
//   69 #if OS_CPU_HOOKS_EN > 0 && OS_VERSION > 203

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   70 void  OSInitHookEnd (void)
//   71 {
//   72 }
OSInitHookEnd:
        BX       LR               ;; return
//   73 #endif
//   74 
//   75 /*
//   76 *********************************************************************************************************
//   77 *                                          TASK CREATION HOOK
//   78 *
//   79 * Description: This function is called when a task is created.
//   80 *
//   81 * Arguments  : ptcb   is a pointer to the task control block of the task being created.
//   82 *
//   83 * Note(s)    : 1) Interrupts are disabled during this call.
//   84 *********************************************************************************************************
//   85 */
//   86 #if OS_CPU_HOOKS_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   87 void  OSTaskCreateHook (OS_TCB *ptcb)
//   88 {
//   89 #if OS_APP_HOOKS_EN > 0
//   90     App_TaskCreateHook(ptcb);
//   91 #else
//   92     (void)ptcb;                                                         /* Prevent compiler warning                                 */
//   93 #endif
//   94 }
OSTaskCreateHook:
        BX       LR               ;; return
//   95 #endif
//   96 
//   97 
//   98 /*
//   99 *********************************************************************************************************
//  100 *                                           TASK DELETION HOOK
//  101 *
//  102 * Description: This function is called when a task is deleted.
//  103 *
//  104 * Arguments  : ptcb   is a pointer to the task control block of the task being deleted.
//  105 *
//  106 * Note(s)    : 1) Interrupts are disabled during this call.
//  107 *********************************************************************************************************
//  108 */
//  109 #if OS_CPU_HOOKS_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  110 void  OSTaskDelHook (OS_TCB *ptcb)
//  111 {
//  112 #if OS_APP_HOOKS_EN > 0
//  113     App_TaskDelHook(ptcb);
//  114 #else
//  115     (void)ptcb;                                                         /* Prevent compiler warning                                 */
//  116 #endif
//  117 }
OSTaskDelHook:
        BX       LR               ;; return
//  118 #endif
//  119 
//  120 /*
//  121 *********************************************************************************************************
//  122 *                                             IDLE TASK HOOK
//  123 *
//  124 * Description: This function is called by the idle task.  This hook has been added to allow you to do
//  125 *              such things as STOP the CPU to conserve power.
//  126 *
//  127 * Arguments  : none
//  128 *
//  129 * Note(s)    : 1) Interrupts are enabled during this call.
//  130 *********************************************************************************************************
//  131 */
//  132 #if OS_CPU_HOOKS_EN > 0 && OS_VERSION >= 251

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  133 void  OSTaskIdleHook (void)
//  134 {
//  135 #if OS_APP_HOOKS_EN > 0
//  136     App_TaskIdleHook();
//  137 #endif
//  138 }
OSTaskIdleHook:
        BX       LR               ;; return
//  139 #endif
//  140 
//  141 /*
//  142 *********************************************************************************************************
//  143 *                                           STATISTIC TASK HOOK
//  144 *
//  145 * Description: This function is called every second by uC/OS-II's statistics task.  This allows your
//  146 *              application to add functionality to the statistics task.
//  147 *
//  148 * Arguments  : none
//  149 *********************************************************************************************************
//  150 */
//  151 
//  152 #if OS_CPU_HOOKS_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  153 void  OSTaskStatHook (void)
//  154 {
//  155 #if OS_APP_HOOKS_EN > 0
//  156     App_TaskStatHook();
//  157 #endif
//  158 }
OSTaskStatHook:
        BX       LR               ;; return
//  159 #endif
//  160 
//  161 /*
//  162 *********************************************************************************************************
//  163 *                                        INITIALIZE A TASK'S STACK
//  164 *
//  165 * Description: This function is called by either OSTaskCreate() or OSTaskCreateExt() to initialize the
//  166 *              stack frame of the task being created.  This function is highly processor specific.
//  167 *
//  168 * Arguments  : task          is a pointer to the task code
//  169 *
//  170 *              p_arg         is a pointer to a user supplied data area that will be passed to the task
//  171 *                            when the task first executes.
//  172 *
//  173 *              ptos          is a pointer to the top of stack.  It is assumed that 'ptos' points to
//  174 *                            a 'free' entry on the task stack.  If OS_STK_GROWTH is set to 1 then
//  175 *                            'ptos' will contain the HIGHEST valid address of the stack.  Similarly, if
//  176 *                            OS_STK_GROWTH is set to 0, the 'ptos' will contains the LOWEST valid address
//  177 *                            of the stack.
//  178 *
//  179 *              opt           specifies options that can be used to alter the behavior of OSTaskStkInit().
//  180 *                            (see uCOS_II.H for OS_TASK_OPT_xxx).
//  181 *
//  182 * Returns    : Always returns the location of the new top-of-stack' once the processor registers have
//  183 *              been placed on the stack in the proper order.
//  184 *
//  185 * Note(s)    : 1) Interrupts are enabled when your task starts executing.
//  186 *              2) All tasks run in Thread mode, using process stack.
//  187 *********************************************************************************************************
//  188 */
//  189 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  190 OS_STK *OSTaskStkInit (void (*task)(void *p_arg), void *p_arg, OS_STK *ptos, INT16U opt)
//  191 {
OSTaskStkInit:
        MOV      R3,R0
        MOV      R0,R2
//  192     OS_STK *stk;
//  193 
//  194 
//  195     (void)opt;                                 /* 'opt' is not used, prevent warning                     */
//  196     stk       = ptos;                          /* Load stack pointer                                     */
//  197 
//  198                                                /* Registers stacked as if auto-saved on exception        */
//  199     *(stk)    = (INT32U)0x01000000L;           /* xPSR                                                   */
        MOV      R2,#+16777216
        STR      R2,[R0, #+0]
//  200     *(--stk)  = (INT32U)task;                  /* Entry Point                                            */
        STR      R3,[R0, #-4]!
//  201     *(--stk)  = (INT32U)0xFFFFFFFEL;           /* R14 (LR) (init value will cause fault if ever used)    */
        MVN      R2,#+1
        STR      R2,[R0, #-4]!
//  202     *(--stk)  = (INT32U)0x12121212L;           /* R12                                                    */
        MOV      R2,#+303174162
        STR      R2,[R0, #-4]!
//  203     *(--stk)  = (INT32U)0x03030303L;           /* R3                                                     */
        MOV      R2,#+50529027
        STR      R2,[R0, #-4]!
//  204     *(--stk)  = (INT32U)0x02020202L;           /* R2                                                     */
        MOV      R2,#+33686018
        STR      R2,[R0, #-4]!
//  205     *(--stk)  = (INT32U)0x01010101L;           /* R1                                                     */
        MOV      R2,#+16843009
        STR      R2,[R0, #-4]!
//  206     *(--stk)  = (INT32U)p_arg;                 /* R0 : argument                                          */
        STR      R1,[R0, #-4]!
//  207 
//  208                                                /* Remaining registers saved on process stack             */
//  209     *(--stk)  = (INT32U)0x11111111L;           /* R11                                                    */
        MOV      R1,#+286331153
        STR      R1,[R0, #-4]!
//  210     *(--stk)  = (INT32U)0x10101010L;           /* R10                                                    */
        MOV      R1,#+269488144
        STR      R1,[R0, #-4]!
//  211     *(--stk)  = (INT32U)0x09090909L;           /* R9                                                     */
        MOV      R1,#+151587081
        STR      R1,[R0, #-4]!
//  212     *(--stk)  = (INT32U)0x08080808L;           /* R8                                                     */
        MOV      R1,#+134744072
        STR      R1,[R0, #-4]!
//  213     *(--stk)  = (INT32U)0x07070707L;           /* R7                                                     */
        MOV      R1,#+117901063
        STR      R1,[R0, #-4]!
//  214     *(--stk)  = (INT32U)0x06060606L;           /* R6                                                     */
        MOV      R1,#+101058054
        STR      R1,[R0, #-4]!
//  215     *(--stk)  = (INT32U)0x05050505L;           /* R5                                                     */
        MOV      R1,#+84215045
        STR      R1,[R0, #-4]!
//  216     *(--stk)  = (INT32U)0x04040404L;           /* R4                                                     */
        MOV      R1,#+67372036
        STR      R1,[R0, #-4]!
//  217 
//  218     return (stk);
        BX       LR               ;; return
//  219 }
//  220 
//  221 /*
//  222 *********************************************************************************************************
//  223 *                                           TASK SWITCH HOOK
//  224 *
//  225 * Description: This function is called when a task switch is performed.  This allows you to perform other
//  226 *              operations during a context switch.
//  227 *
//  228 * Arguments  : none
//  229 *
//  230 * Note(s)    : 1) Interrupts are disabled during this call.
//  231 *              2) It is assumed that the global pointer 'OSTCBHighRdy' points to the TCB of the task that
//  232 *                 will be 'switched in' (i.e. the highest priority task) and, 'OSTCBCur' points to the
//  233 *                 task being switched out (i.e. the preempted task).
//  234 *********************************************************************************************************
//  235 */
//  236 #if (OS_CPU_HOOKS_EN > 0) && (OS_TASK_SW_HOOK_EN > 0)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  237 void  OSTaskSwHook (void)
//  238 {
//  239 #if OS_APP_HOOKS_EN > 0
//  240     App_TaskSwHook();
//  241 #endif
//  242 }
OSTaskSwHook:
        BX       LR               ;; return
//  243 #endif
//  244 
//  245 /*
//  246 *********************************************************************************************************
//  247 *                                           OS_TCBInit() HOOK
//  248 *
//  249 * Description: This function is called by OS_TCBInit() after setting up most of the TCB.
//  250 *
//  251 * Arguments  : ptcb    is a pointer to the TCB of the task being created.
//  252 *
//  253 * Note(s)    : 1) Interrupts may or may not be ENABLED during this call.
//  254 *********************************************************************************************************
//  255 */
//  256 #if OS_CPU_HOOKS_EN > 0 && OS_VERSION > 203

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  257 void  OSTCBInitHook (OS_TCB *ptcb)
//  258 {
//  259 #if OS_APP_HOOKS_EN > 0
//  260     App_TCBInitHook(ptcb);
//  261 #else
//  262     (void)ptcb;                                                         /* Prevent compiler warning                                 */
//  263 #endif
//  264 }
OSTCBInitHook:
        BX       LR               ;; return
//  265 #endif
//  266 
//  267 
//  268 /*
//  269 *********************************************************************************************************
//  270 *                                               TICK HOOK
//  271 *
//  272 * Description: This function is called every tick.
//  273 *
//  274 * Arguments  : none
//  275 *
//  276 * Note(s)    : 1) Interrupts may or may not be ENABLED during this call.
//  277 *********************************************************************************************************
//  278 */
//  279 #if (OS_CPU_HOOKS_EN > 0) && (OS_TIME_TICK_HOOK_EN > 0)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  280 void  OSTimeTickHook (void)
//  281 {
//  282 #if OS_APP_HOOKS_EN > 0
//  283     App_TimeTickHook();
//  284 #endif
//  285 
//  286 #if OS_TMR_EN > 0
//  287     OSTmrCtr++;
//  288     if (OSTmrCtr >= (OS_TICKS_PER_SEC / OS_TMR_CFG_TICKS_PER_SEC)) {
//  289         OSTmrCtr = 0;
//  290         OSTmrSignal();
//  291     }
//  292 #endif
//  293 }
OSTimeTickHook:
        BX       LR               ;; return

        END
//  294 #endif
// 
// 142 bytes in section .text
// 
// 142 bytes of CODE memory
//
//Errors: none
//Warnings: none
