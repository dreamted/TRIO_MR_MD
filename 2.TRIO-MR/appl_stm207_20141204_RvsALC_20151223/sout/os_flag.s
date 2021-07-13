///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:37 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_flag.c                                         /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_flag.c -D OS_INCLUDED -D APPL_SRC -lcN         /
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
//    List file    =  C:\user\project\stm32\fw\stm207_ucos_20120825\sout\os_f /
//                    lag.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_flag

        #define SHT_PROGBITS 0x1

        EXTERN OSFlagFreeList
        EXTERN OSFlagTbl
        EXTERN OSIntNesting
        EXTERN OSLockNesting
        EXTERN OSRdyGrp
        EXTERN OSRdyTbl
        EXTERN OSTCBCur
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_MemClr
        EXTERN OS_Sched
        EXTERN OS_StrCopy
        EXTERN OS_StrLen

        PUBLIC OSFlagAccept
        PUBLIC OSFlagCreate
        PUBLIC OSFlagDel
        PUBLIC OSFlagNameGet
        PUBLIC OSFlagNameSet
        PUBLIC OSFlagPend
        PUBLIC OSFlagPendGetFlagsRdy
        PUBLIC OSFlagPost
        PUBLIC OSFlagQuery
        PUBLIC OS_FlagInit
        PUBLIC OS_FlagUnlink

// C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\Source\os_flag.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                         EVENT FLAG  MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 2001-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_FLAG.C
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
//   29 #if (OS_FLAG_EN > 0) && (OS_MAX_FLAGS > 0)
//   30 /*
//   31 *********************************************************************************************************
//   32 *                                            LOCAL PROTOTYPES
//   33 *********************************************************************************************************
//   34 */
//   35 
//   36 static  void     OS_FlagBlock(OS_FLAG_GRP *pgrp, OS_FLAG_NODE *pnode, OS_FLAGS flags, INT8U wait_type, INT16U timeout);
//   37 static  BOOLEAN  OS_FlagTaskRdy(OS_FLAG_NODE *pnode, OS_FLAGS flags_rdy);
//   38 
//   39 /*$PAGE*/
//   40 /*
//   41 *********************************************************************************************************
//   42 *                              CHECK THE STATUS OF FLAGS IN AN EVENT FLAG GROUP
//   43 *
//   44 * Description: This function is called to check the status of a combination of bits to be set or cleared
//   45 *              in an event flag group.  Your application can check for ANY bit to be set/cleared or ALL
//   46 *              bits to be set/cleared.
//   47 *
//   48 *              This call does not block if the desired flags are not present.
//   49 *
//   50 * Arguments  : pgrp          is a pointer to the desired event flag group.
//   51 *
//   52 *              flags         Is a bit pattern indicating which bit(s) (i.e. flags) you wish to check.
//   53 *                            The bits you want are specified by setting the corresponding bits in
//   54 *                            'flags'.  e.g. if your application wants to wait for bits 0 and 1 then
//   55 *                            'flags' would contain 0x03.
//   56 *
//   57 *              wait_type     specifies whether you want ALL bits to be set/cleared or ANY of the bits
//   58 *                            to be set/cleared.
//   59 *                            You can specify the following argument:
//   60 *
//   61 *                            OS_FLAG_WAIT_CLR_ALL   You will check ALL bits in 'flags' to be clear (0)
//   62 *                            OS_FLAG_WAIT_CLR_ANY   You will check ANY bit  in 'flags' to be clear (0)
//   63 *                            OS_FLAG_WAIT_SET_ALL   You will check ALL bits in 'flags' to be set   (1)
//   64 *                            OS_FLAG_WAIT_SET_ANY   You will check ANY bit  in 'flags' to be set   (1)
//   65 *
//   66 *                            NOTE: Add OS_FLAG_CONSUME if you want the event flag to be 'consumed' by
//   67 *                                  the call.  Example, to wait for any flag in a group AND then clear
//   68 *                                  the flags that are present, set 'wait_type' to:
//   69 *
//   70 *                                  OS_FLAG_WAIT_SET_ANY + OS_FLAG_CONSUME
//   71 *
//   72 *              perr          is a pointer to an error code and can be:
//   73 *                            OS_ERR_NONE               No error
//   74 *                            OS_ERR_EVENT_TYPE         You are not pointing to an event flag group
//   75 *                            OS_ERR_FLAG_WAIT_TYPE     You didn't specify a proper 'wait_type' argument.
//   76 *                            OS_ERR_FLAG_INVALID_PGRP  You passed a NULL pointer instead of the event flag
//   77 *                                                      group handle.
//   78 *                            OS_ERR_FLAG_NOT_RDY       The desired flags you are waiting for are not
//   79 *                                                      available.
//   80 *
//   81 * Returns    : The flags in the event flag group that made the task ready or, 0 if a timeout or an error
//   82 *              occurred.
//   83 *
//   84 * Called from: Task or ISR
//   85 *
//   86 * Note(s)    : 1) IMPORTANT, the behavior of this function has changed from PREVIOUS versions.  The
//   87 *                 function NOW returns the flags that were ready INSTEAD of the current state of the
//   88 *                 event flags.
//   89 *********************************************************************************************************
//   90 */
//   91 
//   92 #if OS_FLAG_ACCEPT_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 OS_FLAGS  OSFlagAccept (OS_FLAG_GRP *pgrp, OS_FLAGS flags, INT8U wait_type, INT8U *perr)
//   94 {
OSFlagAccept:
        PUSH     {R4-R8,LR}
        MOV      R5,R0
        MOV      R8,R1
        MOV      R6,R2
        MOV      R4,R3
//   95     OS_FLAGS      flags_rdy;
//   96     INT8U         result;
//   97     BOOLEAN       consume;
//   98 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//   99     OS_CPU_SR     cpu_sr = 0;
//  100 #endif
//  101 
//  102 
//  103 
//  104 #if OS_ARG_CHK_EN > 0
//  105     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  106         return ((OS_FLAGS)0);
//  107     }
//  108     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
//  109         *perr = OS_ERR_FLAG_INVALID_PGRP;
//  110         return ((OS_FLAGS)0);
//  111     }
//  112 #endif
//  113     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event block type                */
        LDRB     R0,[R5, #+0]
        CMP      R0,#+5
        ITTT     NE 
        MOVNE    R0,#+1
        STRBNE   R0,[R4, #+0]
        MOVNE    R0,#+0
//  114         *perr = OS_ERR_EVENT_TYPE;
//  115         return ((OS_FLAGS)0);
        BNE.N    ??OSFlagAccept_0
//  116     }
//  117     result = (INT8U)(wait_type & OS_FLAG_CONSUME);
//  118     if (result != (INT8U)0) {                              /* See if we need to consume the flags      */
        LSLS     R0,R6,#+24
        ITTE     MI 
        ANDMI    R6,R6,#0x7F
        MOVMI    R7,#+1
        MOVPL    R7,#+0
//  119         wait_type &= ~OS_FLAG_CONSUME;
//  120         consume    = OS_TRUE;
//  121     } else {
//  122         consume    = OS_FALSE;
//  123     }
//  124 /*$PAGE*/
//  125     *perr = OS_ERR_NONE;                                   /* Assume NO error until proven otherwise.  */
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  126     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  127     switch (wait_type) {
        CBZ.N    R6,??OSFlagAccept_1
        CMP      R6,#+2
        BEQ.N    ??OSFlagAccept_2
        BCC.N    ??OSFlagAccept_3
        CMP      R6,#+3
        BEQ.N    ??OSFlagAccept_4
        B.N      ??OSFlagAccept_5
//  128         case OS_FLAG_WAIT_SET_ALL:                         /* See if all required flags are set        */
//  129              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);     /* Extract only the bits we want   */
??OSFlagAccept_2:
        LDRH     R1,[R5, #+8]
        AND      R6,R8,R1
//  130              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
        CMP      R6,R8
        BNE.N    ??OSFlagAccept_6
//  131                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
??OSFlagAccept_7:
        CBZ.N    R7,??OSFlagAccept_8
//  132                      pgrp->OSFlagFlags &= ~flags_rdy;      /* Clear ONLY the flags that we wanted      */
        BICS     R1,R1,R6
??OSFlagAccept_9:
        STRH     R1,[R5, #+8]
        B.N      ??OSFlagAccept_8
//  133                  }
//  134              } else {
//  135                  *perr = OS_ERR_FLAG_NOT_RDY;
//  136              }
//  137              OS_EXIT_CRITICAL();
//  138              break;
//  139 
//  140         case OS_FLAG_WAIT_SET_ANY:
//  141              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);     /* Extract only the bits we want   */
??OSFlagAccept_4:
        LDRH     R1,[R5, #+8]
        ANDS     R6,R8,R1
//  142              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag set                      */
        BNE.N    ??OSFlagAccept_7
??OSFlagAccept_6:
        MOVS     R1,#+112
        STRB     R1,[R4, #+0]
??OSFlagAccept_8:
        BL       OS_CPU_SR_Restore
        B.N      ??OSFlagAccept_10
//  143                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
//  144                      pgrp->OSFlagFlags &= ~flags_rdy;      /* Clear ONLY the flags that we got         */
//  145                  }
//  146              } else {
//  147                  *perr = OS_ERR_FLAG_NOT_RDY;
//  148              }
//  149              OS_EXIT_CRITICAL();
//  150              break;
//  151 
//  152 #if OS_FLAG_WAIT_CLR_EN > 0
//  153         case OS_FLAG_WAIT_CLR_ALL:                         /* See if all required flags are cleared    */
//  154              flags_rdy = (OS_FLAGS)(~pgrp->OSFlagFlags & flags);  /* Extract only the bits we want     */
??OSFlagAccept_1:
        LDRH     R1,[R5, #+8]
        BIC      R6,R8,R1
//  155              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
        CMP      R6,R8
        BNE.N    ??OSFlagAccept_6
//  156                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
??OSFlagAccept_11:
        CMP      R7,#+0
        BEQ.N    ??OSFlagAccept_8
//  157                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we wanted        */
        ORRS     R1,R6,R1
        B.N      ??OSFlagAccept_9
//  158                  }
//  159              } else {
//  160                  *perr = OS_ERR_FLAG_NOT_RDY;
//  161              }
//  162              OS_EXIT_CRITICAL();
//  163              break;
//  164 
//  165         case OS_FLAG_WAIT_CLR_ANY:
//  166              flags_rdy = (OS_FLAGS)(~pgrp->OSFlagFlags & flags); /* Extract only the bits we want      */
??OSFlagAccept_3:
        LDRH     R1,[R5, #+8]
        BICS     R6,R8,R1
//  167              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag cleared                  */
        BNE.N    ??OSFlagAccept_11
        B.N      ??OSFlagAccept_6
//  168                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
//  169                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we got           */
//  170                  }
//  171              } else {
//  172                  *perr = OS_ERR_FLAG_NOT_RDY;
//  173              }
//  174              OS_EXIT_CRITICAL();
//  175              break;
//  176 #endif
//  177 
//  178         default:
//  179              OS_EXIT_CRITICAL();
??OSFlagAccept_5:
        BL       OS_CPU_SR_Restore
//  180              flags_rdy = (OS_FLAGS)0;
        MOVS     R6,#+0
//  181              *perr     = OS_ERR_FLAG_WAIT_TYPE;
        MOVS     R0,#+111
        STRB     R0,[R4, #+0]
//  182              break;
//  183     }
//  184     return (flags_rdy);
??OSFlagAccept_10:
        MOV      R0,R6
??OSFlagAccept_0:
        POP      {R4-R8,PC}       ;; return
//  185 }
//  186 #endif
//  187 
//  188 /*$PAGE*/
//  189 /*
//  190 *********************************************************************************************************
//  191 *                                           CREATE AN EVENT FLAG
//  192 *
//  193 * Description: This function is called to create an event flag group.
//  194 *
//  195 * Arguments  : flags         Contains the initial value to store in the event flag group.
//  196 *
//  197 *              perr          is a pointer to an error code which will be returned to your application:
//  198 *                               OS_ERR_NONE               if the call was successful.
//  199 *                               OS_ERR_CREATE_ISR         if you attempted to create an Event Flag from an
//  200 *                                                         ISR.
//  201 *                               OS_ERR_FLAG_GRP_DEPLETED  if there are no more event flag groups
//  202 *
//  203 * Returns    : A pointer to an event flag group or a NULL pointer if no more groups are available.
//  204 *
//  205 * Called from: Task ONLY
//  206 *********************************************************************************************************
//  207 */
//  208 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  209 OS_FLAG_GRP  *OSFlagCreate (OS_FLAGS flags, INT8U *perr)
//  210 {
OSFlagCreate:
        PUSH     {R4-R6,LR}
        MOV      R5,R0
        MOV      R4,R1
//  211     OS_FLAG_GRP *pgrp;
//  212 #if OS_CRITICAL_METHOD == 3                         /* Allocate storage for CPU status register        */
//  213     OS_CPU_SR    cpu_sr = 0;
//  214 #endif
//  215 
//  216 
//  217 
//  218 #if OS_ARG_CHK_EN > 0
//  219     if (perr == (INT8U *)0) {                       /* Validate 'perr'                                 */
//  220         return ((OS_FLAG_GRP *)0);
//  221     }
//  222 #endif
//  223     if (OSIntNesting > 0) {                         /* See if called from ISR ...                      */
        LDR.W    R0,??DataTable8
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSFlagCreate_0
//  224         *perr = OS_ERR_CREATE_ISR;                  /* ... can't CREATE from an ISR                    */
        MOVS     R0,#+16
        STRB     R0,[R4, #+0]
//  225         return ((OS_FLAG_GRP *)0);
        MOVS     R0,#+0
        POP      {R4-R6,PC}
//  226     }
//  227     OS_ENTER_CRITICAL();
??OSFlagCreate_0:
        BL       OS_CPU_SR_Save
//  228     pgrp = OSFlagFreeList;                          /* Get next free event flag                        */
        LDR.W    R1,??DataTable8_1
        LDR      R2,[R1, #+0]
        MOVS     R6,R2
//  229     if (pgrp != (OS_FLAG_GRP *)0) {                 /* See if we have event flag groups available      */
        BEQ.N    ??OSFlagCreate_1
//  230                                                     /* Adjust free list                                */
//  231         OSFlagFreeList       = (OS_FLAG_GRP *)OSFlagFreeList->OSFlagWaitList;
        LDR      R2,[R2, #+4]
        STR      R2,[R1, #+0]
//  232         pgrp->OSFlagType     = OS_EVENT_TYPE_FLAG;  /* Set to event flag group type                    */
        MOVS     R1,#+5
        STRB     R1,[R6, #+0]
//  233         pgrp->OSFlagFlags    = flags;               /* Set to desired initial value                    */
        STRH     R5,[R6, #+8]
//  234         pgrp->OSFlagWaitList = (void *)0;           /* Clear list of tasks waiting on flags            */
        MOVS     R1,#+0
        STR      R1,[R6, #+4]
//  235 #if OS_FLAG_NAME_SIZE > 1
//  236         pgrp->OSFlagName[0]  = '?';
        MOVS     R1,#+63
        STRB     R1,[R6, #+10]
//  237         pgrp->OSFlagName[1]  = OS_ASCII_NUL;
        MOVS     R1,#+0
        STRB     R1,[R6, #+11]
//  238 #endif
//  239         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  240         *perr                = OS_ERR_NONE;
        MOVS     R0,#+0
        B.N      ??OSFlagCreate_2
//  241     } else {
//  242         OS_EXIT_CRITICAL();
??OSFlagCreate_1:
        BL       OS_CPU_SR_Restore
//  243         *perr                = OS_ERR_FLAG_GRP_DEPLETED;
        MOVS     R0,#+114
??OSFlagCreate_2:
        STRB     R0,[R4, #+0]
//  244     }
//  245     return (pgrp);                                  /* Return pointer to event flag group              */
        MOV      R0,R6
        POP      {R4-R6,PC}       ;; return
//  246 }
//  247 
//  248 /*$PAGE*/
//  249 /*
//  250 *********************************************************************************************************
//  251 *                                     DELETE AN EVENT FLAG GROUP
//  252 *
//  253 * Description: This function deletes an event flag group and readies all tasks pending on the event flag
//  254 *              group.
//  255 *
//  256 * Arguments  : pgrp          is a pointer to the desired event flag group.
//  257 *
//  258 *              opt           determines delete options as follows:
//  259 *                            opt == OS_DEL_NO_PEND   Deletes the event flag group ONLY if no task pending
//  260 *                            opt == OS_DEL_ALWAYS    Deletes the event flag group even if tasks are
//  261 *                                                    waiting.  In this case, all the tasks pending will be
//  262 *                                                    readied.
//  263 *
//  264 *              perr          is a pointer to an error code that can contain one of the following values:
//  265 *                            OS_ERR_NONE               The call was successful and the event flag group was
//  266 *                                                      deleted
//  267 *                            OS_ERR_DEL_ISR            If you attempted to delete the event flag group from
//  268 *                                                      an ISR
//  269 *                            OS_ERR_FLAG_INVALID_PGRP  If 'pgrp' is a NULL pointer.
//  270 *                            OS_ERR_EVENT_TYPE         If you didn't pass a pointer to an event flag group
//  271 *                            OS_ERR_INVALID_OPT        An invalid option was specified
//  272 *                            OS_ERR_TASK_WAITING       One or more tasks were waiting on the event flag
//  273 *                                                      group.
//  274 *
//  275 * Returns    : pgrp          upon error
//  276 *              (OS_EVENT *)0 if the event flag group was successfully deleted.
//  277 *
//  278 * Note(s)    : 1) This function must be used with care.  Tasks that would normally expect the presence of
//  279 *                 the event flag group MUST check the return code of OSFlagAccept() and OSFlagPend().
//  280 *              2) This call can potentially disable interrupts for a long time.  The interrupt disable
//  281 *                 time is directly proportional to the number of tasks waiting on the event flag group.
//  282 *********************************************************************************************************
//  283 */
//  284 
//  285 #if OS_FLAG_DEL_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  286 OS_FLAG_GRP  *OSFlagDel (OS_FLAG_GRP *pgrp, INT8U opt, INT8U *perr)
//  287 {
OSFlagDel:
        PUSH     {R3-R9,LR}
        MOV      R4,R0
        MOV      R8,R1
        MOV      R5,R2
//  288     BOOLEAN       tasks_waiting;
//  289     OS_FLAG_NODE *pnode;
//  290     OS_FLAG_GRP  *pgrp_return;
//  291 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  292     OS_CPU_SR     cpu_sr = 0;
//  293 #endif
//  294 
//  295 
//  296 
//  297 #if OS_ARG_CHK_EN > 0
//  298     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  299         return (pgrp);
//  300     }
//  301     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
//  302         *perr = OS_ERR_FLAG_INVALID_PGRP;
//  303         return (pgrp);
//  304     }
//  305 #endif
//  306     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
        LDR.W    R0,??DataTable8
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSFlagDel_0
//  307         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
        MOVS     R0,#+15
        B.N      ??OSFlagDel_1
//  308         return (pgrp);
//  309     }
//  310     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event group type                */
??OSFlagDel_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+5
        IT       NE 
        MOVNE    R0,#+1
//  311         *perr = OS_ERR_EVENT_TYPE;
        BNE.N    ??OSFlagDel_1
//  312         return (pgrp);
//  313     }
//  314     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R9,R0
//  315     if (pgrp->OSFlagWaitList != (void *)0) {               /* See if any tasks waiting on event flags  */
        LDR      R7,[R4, #+4]
        CMP      R7,#+0
        ITE      NE 
        MOVNE    R6,#+1
        MOVEQ    R6,#+0
//  316         tasks_waiting = OS_TRUE;                           /* Yes                                      */
//  317     } else {
//  318         tasks_waiting = OS_FALSE;                          /* No                                       */
//  319     }
//  320     switch (opt) {
        CMP      R8,#+0
        BEQ.N    ??OSFlagDel_2
        CMP      R8,#+1
        BEQ.N    ??OSFlagDel_3
        B.N      ??OSFlagDel_4
//  321         case OS_DEL_NO_PEND:                               /* Delete group if no task waiting          */
//  322              if (tasks_waiting == OS_FALSE) {
??OSFlagDel_2:
        CBNZ.N   R6,??OSFlagDel_5
//  323 #if OS_FLAG_NAME_SIZE > 1
//  324                  pgrp->OSFlagName[0]  = '?';               /* Unknown name                             */
        MOVS     R0,#+63
        STRB     R0,[R4, #+10]
//  325                  pgrp->OSFlagName[1]  = OS_ASCII_NUL;
        MOVS     R0,#+0
        STRB     R0,[R4, #+11]
//  326 #endif
//  327                  pgrp->OSFlagType     = OS_EVENT_TYPE_UNUSED;
        STRB     R0,[R4, #+0]
//  328                  pgrp->OSFlagWaitList = (void *)OSFlagFreeList; /* Return group to free list           */
        LDR.W    R0,??DataTable8_1
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  329                  pgrp->OSFlagFlags    = (OS_FLAGS)0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  330                  OSFlagFreeList       = pgrp;
        STR      R4,[R0, #+0]
//  331                  OS_EXIT_CRITICAL();
        MOV      R0,R9
        BL       OS_CPU_SR_Restore
//  332                  *perr                = OS_ERR_NONE;
??OSFlagDel_6:
        MOVS     R0,#+0
//  333                  pgrp_return          = (OS_FLAG_GRP *)0;  /* Event Flag Group has been deleted        */
        MOVS     R4,#+0
        B.N      ??OSFlagDel_1
//  334              } else {
//  335                  OS_EXIT_CRITICAL();
??OSFlagDel_5:
        BL       OS_CPU_SR_Restore
//  336                  *perr                = OS_ERR_TASK_WAITING;
        MOVS     R0,#+73
//  337                  pgrp_return          = pgrp;
        B.N      ??OSFlagDel_1
//  338              }
//  339              break;
//  340 
//  341         case OS_DEL_ALWAYS:                                /* Always delete the event flag group       */
//  342              pnode = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
//  343              while (pnode != (OS_FLAG_NODE *)0) {          /* Ready ALL tasks waiting for flags        */
??OSFlagDel_3:
        CBZ.N    R7,??OSFlagDel_7
//  344                  (void)OS_FlagTaskRdy(pnode, (OS_FLAGS)0);
??OSFlagDel_8:
        MOVS     R1,#+0
        MOV      R0,R7
        BL       OS_FlagTaskRdy
//  345                  pnode = (OS_FLAG_NODE *)pnode->OSFlagNodeNext;
        LDR      R7,[R7, #+0]
        CMP      R7,#+0
        BNE.N    ??OSFlagDel_8
//  346              }
//  347 #if OS_FLAG_NAME_SIZE > 1
//  348              pgrp->OSFlagName[0]  = '?';                   /* Unknown name                             */
??OSFlagDel_7:
        MOVS     R0,#+63
        STRB     R0,[R4, #+10]
//  349              pgrp->OSFlagName[1]  = OS_ASCII_NUL;
        MOVS     R0,#+0
        STRB     R0,[R4, #+11]
//  350 #endif
//  351              pgrp->OSFlagType     = OS_EVENT_TYPE_UNUSED;
        STRB     R0,[R4, #+0]
//  352              pgrp->OSFlagWaitList = (void *)OSFlagFreeList;/* Return group to free list                */
        LDR.W    R0,??DataTable8_1
        LDR      R1,[R0, #+0]
        STR      R1,[R4, #+4]
//  353              pgrp->OSFlagFlags    = (OS_FLAGS)0;
        MOVS     R1,#+0
        STRH     R1,[R4, #+8]
//  354              OSFlagFreeList       = pgrp;
        STR      R4,[R0, #+0]
//  355              OS_EXIT_CRITICAL();
        MOV      R0,R9
        BL       OS_CPU_SR_Restore
//  356              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
        CMP      R6,#+0
        BEQ.N    ??OSFlagDel_6
//  357                  OS_Sched();                               /* Find highest priority task ready to run  */
        BL       OS_Sched
//  358              }
//  359              *perr = OS_ERR_NONE;
        B.N      ??OSFlagDel_6
//  360              pgrp_return          = (OS_FLAG_GRP *)0;      /* Event Flag Group has been deleted        */
//  361              break;
//  362 
//  363         default:
//  364              OS_EXIT_CRITICAL();
??OSFlagDel_4:
        BL       OS_CPU_SR_Restore
//  365              *perr                = OS_ERR_INVALID_OPT;
        MOVS     R0,#+7
//  366              pgrp_return          = pgrp;
//  367              break;
??OSFlagDel_1:
        STRB     R0,[R5, #+0]
//  368     }
//  369     return (pgrp_return);
        MOV      R0,R4
        POP      {R1,R4-R9,PC}    ;; return
//  370 }
//  371 #endif
//  372 /*$PAGE*/
//  373 /*
//  374 *********************************************************************************************************
//  375 *                                 GET THE NAME OF AN EVENT FLAG GROUP
//  376 *
//  377 * Description: This function is used to obtain the name assigned to an event flag group
//  378 *
//  379 * Arguments  : pgrp      is a pointer to the event flag group.
//  380 *
//  381 *              pname     is a pointer to an ASCII string that will receive the name of the event flag
//  382 *                        group.  The string must be able to hold at least OS_FLAG_NAME_SIZE characters.
//  383 *
//  384 *              perr      is a pointer to an error code that can contain one of the following values:
//  385 *
//  386 *                        OS_ERR_NONE                if the requested task is resumed
//  387 *                        OS_ERR_EVENT_TYPE          if 'pevent' is not pointing to an event flag group
//  388 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  389 *                        OS_ERR_FLAG_INVALID_PGRP   if you passed a NULL pointer for 'pgrp'
//  390 *                        OS_ERR_NAME_GET_ISR        if you called this function from an ISR
//  391 *
//  392 * Returns    : The length of the string or 0 if the 'pgrp' is a NULL pointer.
//  393 *********************************************************************************************************
//  394 */
//  395 
//  396 #if OS_FLAG_NAME_SIZE > 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  397 INT8U  OSFlagNameGet (OS_FLAG_GRP *pgrp, INT8U *pname, INT8U *perr)
//  398 {
OSFlagNameGet:
        PUSH     {R3-R7,LR}
        MOV      R5,R0
        MOV      R6,R1
        MOV      R4,R2
//  399     INT8U      len;
//  400 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  401     OS_CPU_SR  cpu_sr = 0;
//  402 #endif
//  403 
//  404 
//  405 
//  406 #if OS_ARG_CHK_EN > 0
//  407     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//  408         return (0);
//  409     }
//  410     if (pgrp == (OS_FLAG_GRP *)0) {              /* Is 'pgrp' a NULL pointer?                          */
//  411         *perr = OS_ERR_FLAG_INVALID_PGRP;
//  412         return (0);
//  413     }
//  414     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
//  415         *perr = OS_ERR_PNAME_NULL;
//  416         return (0);
//  417     }
//  418 #endif
//  419     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
        LDR.W    R0,??DataTable8
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSFlagNameGet_0
//  420         *perr = OS_ERR_NAME_GET_ISR;
        MOVS     R0,#+17
??OSFlagNameGet_1:
        STRB     R0,[R4, #+0]
//  421         return (0);
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}
//  422     }
//  423     OS_ENTER_CRITICAL();
??OSFlagNameGet_0:
        BL       OS_CPU_SR_Save
        MOV      R7,R0
//  424     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {
        LDRB     R0,[R5, #+0]
        CMP      R0,#+5
        BEQ.N    ??OSFlagNameGet_2
//  425         OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  426         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        B.N      ??OSFlagNameGet_1
//  427         return (0);
//  428     }
//  429     len   = OS_StrCopy(pname, pgrp->OSFlagName); /* Copy name from OS_FLAG_GRP                         */
??OSFlagNameGet_2:
        ADD      R1,R5,#+10
        MOV      R0,R6
        BL       OS_StrCopy
        MOV      R5,R0
//  430     OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  431     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  432     return (len);
        MOV      R0,R5
        POP      {R1,R4-R7,PC}    ;; return
//  433 }
//  434 #endif
//  435 
//  436 /*$PAGE*/
//  437 /*
//  438 *********************************************************************************************************
//  439 *                                 ASSIGN A NAME TO AN EVENT FLAG GROUP
//  440 *
//  441 * Description: This function assigns a name to an event flag group.
//  442 *
//  443 * Arguments  : pgrp      is a pointer to the event flag group.
//  444 *
//  445 *              pname     is a pointer to an ASCII string that will be used as the name of the event flag
//  446 *                        group.  The string must be able to hold at least OS_FLAG_NAME_SIZE characters.
//  447 *
//  448 *              perr      is a pointer to an error code that can contain one of the following values:
//  449 *
//  450 *                        OS_ERR_NONE                if the requested task is resumed
//  451 *                        OS_ERR_EVENT_TYPE          if 'pevent' is not pointing to an event flag group
//  452 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  453 *                        OS_ERR_FLAG_INVALID_PGRP   if you passed a NULL pointer for 'pgrp'
//  454 *                        OS_ERR_NAME_SET_ISR        if you called this function from an ISR
//  455 *
//  456 * Returns    : None
//  457 *********************************************************************************************************
//  458 */
//  459 
//  460 #if OS_FLAG_NAME_SIZE > 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  461 void  OSFlagNameSet (OS_FLAG_GRP *pgrp, INT8U *pname, INT8U *perr)
//  462 {
OSFlagNameSet:
        PUSH     {R3-R7,LR}
        MOV      R5,R0
        MOV      R6,R1
        MOV      R4,R2
//  463     INT8U      len;
//  464 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  465     OS_CPU_SR  cpu_sr = 0;
//  466 #endif
//  467 
//  468 
//  469 
//  470 #if OS_ARG_CHK_EN > 0
//  471     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//  472         return;
//  473     }
//  474     if (pgrp == (OS_FLAG_GRP *)0) {              /* Is 'pgrp' a NULL pointer?                          */
//  475         *perr = OS_ERR_FLAG_INVALID_PGRP;
//  476         return;
//  477     }
//  478     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
//  479         *perr = OS_ERR_PNAME_NULL;
//  480         return;
//  481     }
//  482 #endif
//  483     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
        LDR.N    R0,??DataTable8
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSFlagNameSet_0
//  484         *perr = OS_ERR_NAME_SET_ISR;
        MOVS     R0,#+18
        B.N      ??OSFlagNameSet_1
//  485         return;
//  486     }
//  487     OS_ENTER_CRITICAL();
??OSFlagNameSet_0:
        BL       OS_CPU_SR_Save
        MOV      R7,R0
//  488     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {
        LDRB     R0,[R5, #+0]
        CMP      R0,#+5
        BEQ.N    ??OSFlagNameSet_2
//  489         OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  490         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        B.N      ??OSFlagNameSet_1
//  491         return;
//  492     }
//  493     len = OS_StrLen(pname);                      /* Can we fit the string in the storage area?         */
//  494     if (len > (OS_FLAG_NAME_SIZE - 1)) {         /* No                                                 */
??OSFlagNameSet_2:
        MOV      R0,R6
        BL       OS_StrLen
        CMP      R0,#+16
        BCC.N    ??OSFlagNameSet_3
//  495         OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  496         *perr = OS_ERR_FLAG_NAME_TOO_LONG;
        MOVS     R0,#+115
        B.N      ??OSFlagNameSet_1
//  497         return;
//  498     }
//  499     (void)OS_StrCopy(pgrp->OSFlagName, pname);   /* Yes, copy name from OS_FLAG_GRP                    */
??OSFlagNameSet_3:
        MOV      R1,R6
        ADD      R0,R5,#+10
        BL       OS_StrCopy
//  500     OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  501     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
??OSFlagNameSet_1:
        STRB     R0,[R4, #+0]
//  502     return;
        POP      {R0,R4-R7,PC}    ;; return
//  503 }
//  504 #endif
//  505 
//  506 /*$PAGE*/
//  507 /*
//  508 *********************************************************************************************************
//  509 *                                        WAIT ON AN EVENT FLAG GROUP
//  510 *
//  511 * Description: This function is called to wait for a combination of bits to be set in an event flag
//  512 *              group.  Your application can wait for ANY bit to be set or ALL bits to be set.
//  513 *
//  514 * Arguments  : pgrp          is a pointer to the desired event flag group.
//  515 *
//  516 *              flags         Is a bit pattern indicating which bit(s) (i.e. flags) you wish to wait for.
//  517 *                            The bits you want are specified by setting the corresponding bits in
//  518 *                            'flags'.  e.g. if your application wants to wait for bits 0 and 1 then
//  519 *                            'flags' would contain 0x03.
//  520 *
//  521 *              wait_type     specifies whether you want ALL bits to be set or ANY of the bits to be set.
//  522 *                            You can specify the following argument:
//  523 *
//  524 *                            OS_FLAG_WAIT_CLR_ALL   You will wait for ALL bits in 'mask' to be clear (0)
//  525 *                            OS_FLAG_WAIT_SET_ALL   You will wait for ALL bits in 'mask' to be set   (1)
//  526 *                            OS_FLAG_WAIT_CLR_ANY   You will wait for ANY bit  in 'mask' to be clear (0)
//  527 *                            OS_FLAG_WAIT_SET_ANY   You will wait for ANY bit  in 'mask' to be set   (1)
//  528 *
//  529 *                            NOTE: Add OS_FLAG_CONSUME if you want the event flag to be 'consumed' by
//  530 *                                  the call.  Example, to wait for any flag in a group AND then clear
//  531 *                                  the flags that are present, set 'wait_type' to:
//  532 *
//  533 *                                  OS_FLAG_WAIT_SET_ANY + OS_FLAG_CONSUME
//  534 *
//  535 *              timeout       is an optional timeout (in clock ticks) that your task will wait for the
//  536 *                            desired bit combination.  If you specify 0, however, your task will wait
//  537 *                            forever at the specified event flag group or, until a message arrives.
//  538 *
//  539 *              perr          is a pointer to an error code and can be:
//  540 *                            OS_ERR_NONE               The desired bits have been set within the specified
//  541 *                                                      'timeout'.
//  542 *                            OS_ERR_PEND_ISR           If you tried to PEND from an ISR
//  543 *                            OS_ERR_FLAG_INVALID_PGRP  If 'pgrp' is a NULL pointer.
//  544 *                            OS_ERR_EVENT_TYPE         You are not pointing to an event flag group
//  545 *                            OS_ERR_TIMEOUT            The bit(s) have not been set in the specified
//  546 *                                                      'timeout'.
//  547 *                            OS_ERR_PEND_ABORT         The wait on the flag was aborted.
//  548 *                            OS_ERR_FLAG_WAIT_TYPE     You didn't specify a proper 'wait_type' argument.
//  549 *
//  550 * Returns    : The flags in the event flag group that made the task ready or, 0 if a timeout or an error
//  551 *              occurred.
//  552 *
//  553 * Called from: Task ONLY
//  554 *
//  555 * Note(s)    : 1) IMPORTANT, the behavior of this function has changed from PREVIOUS versions.  The
//  556 *                 function NOW returns the flags that were ready INSTEAD of the current state of the
//  557 *                 event flags.
//  558 *********************************************************************************************************
//  559 */
//  560 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  561 OS_FLAGS  OSFlagPend (OS_FLAG_GRP *pgrp, OS_FLAGS flags, INT8U wait_type, INT16U timeout, INT8U *perr)
//  562 {
OSFlagPend:
        PUSH     {R3-R11,LR}
        SUB      SP,SP,#+24
        MOV      R4,R0
        MOV      R9,R1
        MOV      R10,R2
        LDR      R5,[SP, #+64]
//  563     OS_FLAG_NODE  node;
//  564     OS_FLAGS      flags_rdy;
//  565     INT8U         result;
//  566     INT8U         pend_stat;
//  567     BOOLEAN       consume;
//  568 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  569     OS_CPU_SR     cpu_sr = 0;
//  570 #endif
//  571 
//  572 
//  573 
//  574 #if OS_ARG_CHK_EN > 0
//  575     if (perr == (INT8U *)0) {                              /* Validate 'perr'                          */
//  576         return ((OS_FLAGS)0);
//  577     }
//  578     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
//  579         *perr = OS_ERR_FLAG_INVALID_PGRP;
//  580         return ((OS_FLAGS)0);
//  581     }
//  582 #endif
//  583     if (OSIntNesting > 0) {                                /* See if called from ISR ...               */
        LDR.N    R0,??DataTable8
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSFlagPend_0
//  584         *perr = OS_ERR_PEND_ISR;                           /* ... can't PEND from an ISR               */
        MOVS     R0,#+2
??OSFlagPend_1:
        STRB     R0,[R5, #+0]
//  585         return ((OS_FLAGS)0);
        MOVS     R0,#+0
        B.N      ??OSFlagPend_2
//  586     }
//  587     if (OSLockNesting > 0) {                               /* See if called with scheduler locked ...  */
??OSFlagPend_0:
        LDR.N    R0,??DataTable8_2
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSFlagPend_3
//  588         *perr = OS_ERR_PEND_LOCKED;                        /* ... can't PEND when locked               */
        MOVS     R0,#+13
        B.N      ??OSFlagPend_1
//  589         return ((OS_FLAGS)0);
//  590     }
//  591     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event block type                */
??OSFlagPend_3:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+5
        BEQ.N    ??OSFlagPend_4
//  592         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        B.N      ??OSFlagPend_1
//  593         return ((OS_FLAGS)0);
//  594     }
//  595     result = (INT8U)(wait_type & OS_FLAG_CONSUME);
//  596     if (result != (INT8U)0) {                             /* See if we need to consume the flags      */
??OSFlagPend_4:
        LSLS     R0,R10,#+24
        ITTE     MI 
        ANDMI    R10,R10,#0x7F
        MOVMI    R11,#+1
        MOVPL    R11,#+0
//  597         wait_type &= ~(INT8U)OS_FLAG_CONSUME;
//  598         consume    = OS_TRUE;
//  599     } else {
//  600         consume    = OS_FALSE;
//  601     }
//  602 /*$PAGE*/
//  603     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  604     switch (wait_type) {
        MOV      R7,R10
        CMP      R7,#+0
        BEQ.N    ??OSFlagPend_5
        CMP      R7,#+2
        BEQ.N    ??OSFlagPend_6
        BCC.N    ??OSFlagPend_7
        CMP      R7,#+3
        BEQ.N    ??OSFlagPend_8
        B.N      ??OSFlagPend_9
//  605         case OS_FLAG_WAIT_SET_ALL:                         /* See if all required flags are set        */
//  606              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);   /* Extract only the bits we want     */
??OSFlagPend_6:
        LDRH     R0,[R4, #+8]
        AND      R6,R9,R0
//  607              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
        CMP      R6,R9
        BNE.N    ??OSFlagPend_10
//  608                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
??OSFlagPend_11:
        CMP      R11,#+0
        BEQ.N    ??OSFlagPend_12
//  609                      pgrp->OSFlagFlags &= ~flags_rdy;      /* Clear ONLY the flags that we wanted      */
        BICS     R0,R0,R6
??OSFlagPend_13:
        STRH     R0,[R4, #+8]
//  610                  }
//  611                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
??OSFlagPend_12:
        LDR.N    R0,??DataTable8_3
        LDR      R0,[R0, #+0]
        STRH     R6,[R0, #+24]
//  612                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
        B.N      ??OSFlagPend_14
//  613                  *perr                   = OS_ERR_NONE;
//  614                  return (flags_rdy);
//  615              } else {                                      /* Block task until events occur or timeout */
//  616                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
//  617                  OS_EXIT_CRITICAL();
//  618              }
//  619              break;
//  620 
//  621         case OS_FLAG_WAIT_SET_ANY:
//  622              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);    /* Extract only the bits we want    */
??OSFlagPend_8:
        LDRH     R0,[R4, #+8]
        ANDS     R6,R9,R0
//  623              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag set                      */
        BNE.N    ??OSFlagPend_11
??OSFlagPend_10:
        LDRH     R0,[SP, #+24]
        STR      R0,[SP, #+0]
        MOV      R3,R10
        MOV      R2,R9
        ADD      R1,SP,#+4
        MOV      R0,R4
        BL       OS_FlagBlock
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  624                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
//  625                      pgrp->OSFlagFlags &= ~flags_rdy;      /* Clear ONLY the flags that we got         */
//  626                  }
//  627                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
//  628                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
//  629                  *perr                   = OS_ERR_NONE;
//  630                  return (flags_rdy);
//  631              } else {                                      /* Block task until events occur or timeout */
//  632                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
//  633                  OS_EXIT_CRITICAL();
//  634              }
//  635              break;
//  636 
//  637 #if OS_FLAG_WAIT_CLR_EN > 0
//  638         case OS_FLAG_WAIT_CLR_ALL:                         /* See if all required flags are cleared    */
//  639              flags_rdy = (OS_FLAGS)(~pgrp->OSFlagFlags & flags);  /* Extract only the bits we want     */
//  640              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
//  641                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
//  642                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we wanted        */
//  643                  }
//  644                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
//  645                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
//  646                  *perr                   = OS_ERR_NONE;
//  647                  return (flags_rdy);
//  648              } else {                                      /* Block task until events occur or timeout */
//  649                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
//  650                  OS_EXIT_CRITICAL();
//  651              }
//  652              break;
//  653 
//  654         case OS_FLAG_WAIT_CLR_ANY:
//  655              flags_rdy = (OS_FLAGS)(~pgrp->OSFlagFlags & flags); /* Extract only the bits we want      */
//  656              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag cleared                  */
//  657                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
//  658                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we got           */
//  659                  }
//  660                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
//  661                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
//  662                  *perr                   = OS_ERR_NONE;
//  663                  return (flags_rdy);
//  664              } else {                                      /* Block task until events occur or timeout */
//  665                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
//  666                  OS_EXIT_CRITICAL();
//  667              }
//  668              break;
//  669 #endif
//  670 
//  671         default:
//  672              OS_EXIT_CRITICAL();
//  673              flags_rdy = (OS_FLAGS)0;
//  674              *perr      = OS_ERR_FLAG_WAIT_TYPE;
//  675              return (flags_rdy);
//  676     }
//  677 /*$PAGE*/
//  678     OS_Sched();                                            /* Find next HPT ready to run               */
        BL       OS_Sched
//  679     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  680     if (OSTCBCur->OSTCBStatPend != OS_STAT_PEND_OK) {      /* Have we timed-out or aborted?            */
        LDR.N    R6,??DataTable8_3
        LDR      R0,[R6, #+0]
        LDRB     R10,[R0, #+29]
        CMP      R10,#+0
        BNE.N    ??OSFlagPend_15
//  681         pend_stat                = OSTCBCur->OSTCBStatPend;
//  682         OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
//  683         OS_FlagUnlink(&node);
//  684         OSTCBCur->OSTCBStat      = OS_STAT_RDY;            /* Yes, make task ready-to-run              */
//  685         OS_EXIT_CRITICAL();
//  686         flags_rdy                = (OS_FLAGS)0;
//  687         switch (pend_stat) {
//  688             case OS_STAT_PEND_TO:
//  689             default:
//  690                  *perr = OS_ERR_TIMEOUT;                    /* Indicate that we timed-out waiting       */
//  691                  break;
//  692 
//  693             case OS_STAT_PEND_ABORT:
//  694                  *perr = OS_ERR_PEND_ABORT;                 /* Indicate that we aborted   waiting       */
//  695                  break;
//  696         }
//  697         return (flags_rdy);
//  698     }
//  699     flags_rdy = OSTCBCur->OSTCBFlagsRdy;
        LDRH     R6,[R0, #+24]
//  700     if (consume == OS_TRUE) {                              /* See if we need to consume the flags      */
        CMP      R11,#+0
        BEQ.N    ??OSFlagPend_14
//  701         switch (wait_type) {
        CMP      R7,#+1
        BLS.N    ??OSFlagPend_16
        SUBS     R7,R7,#+2
        CMP      R7,#+1
        BHI.N    ??OSFlagPend_9
//  702             case OS_FLAG_WAIT_SET_ALL:
//  703             case OS_FLAG_WAIT_SET_ANY:                     /* Clear ONLY the flags we got              */
//  704                  pgrp->OSFlagFlags &= ~flags_rdy;
        LDRH     R0,[R4, #+8]
        BICS     R0,R0,R6
        B.N      ??OSFlagPend_17
??OSFlagPend_5:
        LDRH     R0,[R4, #+8]
        BIC      R6,R9,R0
        CMP      R6,R9
        BNE.N    ??OSFlagPend_10
??OSFlagPend_18:
        CMP      R11,#+0
        BEQ.N    ??OSFlagPend_12
        ORRS     R0,R6,R0
        B.N      ??OSFlagPend_13
??OSFlagPend_7:
        LDRH     R0,[R4, #+8]
        BICS     R6,R9,R0
        BNE.N    ??OSFlagPend_18
        B.N      ??OSFlagPend_10
??OSFlagPend_9:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
        MOVS     R0,#+111
        B.N      ??OSFlagPend_1
??OSFlagPend_15:
        MOVS     R1,#+0
        STRB     R1,[R0, #+29]
        ADD      R0,SP,#+4
        BL       OS_FlagUnlink
        LDR      R0,[R6, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+28]
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
        CMP      R10,#+2
        ITE      EQ 
        MOVEQ    R0,#+14
        MOVNE    R0,#+10
        B.N      ??OSFlagPend_1
//  705                  break;
//  706 
//  707 #if OS_FLAG_WAIT_CLR_EN > 0
//  708             case OS_FLAG_WAIT_CLR_ALL:
//  709             case OS_FLAG_WAIT_CLR_ANY:                     /* Set   ONLY the flags we got              */
//  710                  pgrp->OSFlagFlags |=  flags_rdy;
??OSFlagPend_16:
        LDRH     R0,[R4, #+8]
        ORRS     R0,R6,R0
??OSFlagPend_17:
        STRH     R0,[R4, #+8]
//  711                  break;
//  712 #endif
//  713             default:
//  714                  OS_EXIT_CRITICAL();
//  715                  *perr = OS_ERR_FLAG_WAIT_TYPE;
//  716                  return ((OS_FLAGS)0);
//  717         }
//  718     }
//  719     OS_EXIT_CRITICAL();
??OSFlagPend_14:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  720     *perr = OS_ERR_NONE;                                   /* Event(s) must have occurred              */
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  721     return (flags_rdy);
        MOV      R0,R6
??OSFlagPend_2:
        ADD      SP,SP,#+28
        POP      {R4-R11,PC}      ;; return
//  722 }
//  723 /*$PAGE*/
//  724 /*
//  725 *********************************************************************************************************
//  726 *                               GET FLAGS WHO CAUSED TASK TO BECOME READY
//  727 *
//  728 * Description: This function is called to obtain the flags that caused the task to become ready to run.
//  729 *              In other words, this function allows you to tell "Who done it!".
//  730 *
//  731 * Arguments  : None
//  732 *
//  733 * Returns    : The flags that caused the task to be ready.
//  734 *
//  735 * Called from: Task ONLY
//  736 *********************************************************************************************************
//  737 */
//  738 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  739 OS_FLAGS  OSFlagPendGetFlagsRdy (void)
//  740 {
OSFlagPendGetFlagsRdy:
        PUSH     {R4,LR}
//  741     OS_FLAGS      flags;
//  742 #if OS_CRITICAL_METHOD == 3                                /* Allocate storage for CPU status register */
//  743     OS_CPU_SR     cpu_sr = 0;
//  744 #endif
//  745 
//  746 
//  747 
//  748     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  749     flags = OSTCBCur->OSTCBFlagsRdy;
        LDR.N    R1,??DataTable8_3
        LDR      R1,[R1, #+0]
        LDRH     R4,[R1, #+24]
//  750     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  751     return (flags);
        MOV      R0,R4
        POP      {R4,PC}          ;; return
//  752 }
//  753 
//  754 /*$PAGE*/
//  755 /*
//  756 *********************************************************************************************************
//  757 *                                         POST EVENT FLAG BIT(S)
//  758 *
//  759 * Description: This function is called to set or clear some bits in an event flag group.  The bits to
//  760 *              set or clear are specified by a 'bit mask'.
//  761 *
//  762 * Arguments  : pgrp          is a pointer to the desired event flag group.
//  763 *
//  764 *              flags         If 'opt' (see below) is OS_FLAG_SET, each bit that is set in 'flags' will
//  765 *                            set the corresponding bit in the event flag group.  e.g. to set bits 0, 4
//  766 *                            and 5 you would set 'flags' to:
//  767 *
//  768 *                                0x31     (note, bit 0 is least significant bit)
//  769 *
//  770 *                            If 'opt' (see below) is OS_FLAG_CLR, each bit that is set in 'flags' will
//  771 *                            CLEAR the corresponding bit in the event flag group.  e.g. to clear bits 0,
//  772 *                            4 and 5 you would specify 'flags' as:
//  773 *
//  774 *                                0x31     (note, bit 0 is least significant bit)
//  775 *
//  776 *              opt           indicates whether the flags will be:
//  777 *                                set     (OS_FLAG_SET) or
//  778 *                                cleared (OS_FLAG_CLR)
//  779 *
//  780 *              perr          is a pointer to an error code and can be:
//  781 *                            OS_ERR_NONE                The call was successfull
//  782 *                            OS_ERR_FLAG_INVALID_PGRP   You passed a NULL pointer
//  783 *                            OS_ERR_EVENT_TYPE          You are not pointing to an event flag group
//  784 *                            OS_ERR_FLAG_INVALID_OPT    You specified an invalid option
//  785 *
//  786 * Returns    : the new value of the event flags bits that are still set.
//  787 *
//  788 * Called From: Task or ISR
//  789 *
//  790 * WARNING(s) : 1) The execution time of this function depends on the number of tasks waiting on the event
//  791 *                 flag group.
//  792 *              2) The amount of time interrupts are DISABLED depends on the number of tasks waiting on
//  793 *                 the event flag group.
//  794 *********************************************************************************************************
//  795 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  796 OS_FLAGS  OSFlagPost (OS_FLAG_GRP *pgrp, OS_FLAGS flags, INT8U opt, INT8U *perr)
//  797 {
OSFlagPost:
        PUSH     {R4-R8,LR}
        MOV      R6,R0
        MOV      R7,R1
        MOV      R5,R2
        MOV      R4,R3
//  798     OS_FLAG_NODE *pnode;
//  799     BOOLEAN       sched;
//  800     OS_FLAGS      flags_cur;
//  801     OS_FLAGS      flags_rdy;
//  802     BOOLEAN       rdy;
//  803 #if OS_CRITICAL_METHOD == 3                          /* Allocate storage for CPU status register       */
//  804     OS_CPU_SR     cpu_sr = 0;
//  805 #endif
//  806 
//  807 
//  808 
//  809 #if OS_ARG_CHK_EN > 0
//  810     if (perr == (INT8U *)0) {                        /* Validate 'perr'                                */
//  811         return ((OS_FLAGS)0);
//  812     }
//  813     if (pgrp == (OS_FLAG_GRP *)0) {                  /* Validate 'pgrp'                                */
//  814         *perr = OS_ERR_FLAG_INVALID_PGRP;
//  815         return ((OS_FLAGS)0);
//  816     }
//  817 #endif
//  818     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {    /* Make sure we are pointing to an event flag grp */
        LDRB     R0,[R6, #+0]
        CMP      R0,#+5
        BEQ.N    ??OSFlagPost_0
//  819         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
??OSFlagPost_1:
        STRB     R0,[R4, #+0]
//  820         return ((OS_FLAGS)0);
        MOVS     R0,#+0
        B.N      ??OSFlagPost_2
//  821     }
//  822 /*$PAGE*/
//  823     OS_ENTER_CRITICAL();
??OSFlagPost_0:
        BL       OS_CPU_SR_Save
        MOV      R8,R0
//  824     switch (opt) {
        CBZ.N    R5,??OSFlagPost_3
        CMP      R5,#+1
        BEQ.N    ??OSFlagPost_4
        B.N      ??OSFlagPost_5
//  825         case OS_FLAG_CLR:
//  826              pgrp->OSFlagFlags &= ~flags;            /* Clear the flags specified in the group         */
??OSFlagPost_3:
        LDRH     R0,[R6, #+8]
        BICS     R0,R0,R7
??OSFlagPost_6:
        STRH     R0,[R6, #+8]
//  827              break;
//  828 
//  829         case OS_FLAG_SET:
//  830              pgrp->OSFlagFlags |=  flags;            /* Set   the flags specified in the group         */
//  831              break;
//  832 
//  833         default:
//  834              OS_EXIT_CRITICAL();                     /* INVALID option                                 */
//  835              *perr = OS_ERR_FLAG_INVALID_OPT;
//  836              return ((OS_FLAGS)0);
//  837     }
//  838     sched = OS_FALSE;                                /* Indicate that we don't need rescheduling       */
        MOVS     R7,#+0
//  839     pnode = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
        LDR      R5,[R6, #+4]
        B.N      ??OSFlagPost_7
??OSFlagPost_4:
        LDRH     R0,[R6, #+8]
        ORRS     R0,R7,R0
        B.N      ??OSFlagPost_6
??OSFlagPost_5:
        BL       OS_CPU_SR_Restore
        MOVS     R0,#+113
        B.N      ??OSFlagPost_1
//  840     while (pnode != (OS_FLAG_NODE *)0) {             /* Go through all tasks waiting on event flag(s)  */
//  841         switch (pnode->OSFlagNodeWaitType) {
//  842             case OS_FLAG_WAIT_SET_ALL:               /* See if all req. flags are set for current node */
//  843                  flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
??OSFlagPost_8:
        LDRH     R0,[R5, #+16]
        LDRH     R1,[R6, #+8]
        ANDS     R1,R0,R1
//  844                  if (flags_rdy == pnode->OSFlagNodeFlags) {
        CMP      R1,R0
        BNE.N    ??OSFlagPost_9
//  845                      rdy = OS_FlagTaskRdy(pnode, flags_rdy);  /* Make task RTR, event(s) Rx'd          */
//  846                      if (rdy == OS_TRUE) {
??OSFlagPost_10:
        MOV      R0,R5
        BL       OS_FlagTaskRdy
        CMP      R0,#+1
        IT       EQ 
        MOVEQ    R7,#+1
//  847                          sched = OS_TRUE;                     /* When done we will reschedule          */
//  848                      }
//  849                  }
//  850                  break;
//  851 
//  852             case OS_FLAG_WAIT_SET_ANY:               /* See if any flag set                            */
//  853                  flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
//  854                  if (flags_rdy != (OS_FLAGS)0) {
//  855                      rdy = OS_FlagTaskRdy(pnode, flags_rdy);  /* Make task RTR, event(s) Rx'd          */
//  856                      if (rdy == OS_TRUE) {
//  857                          sched = OS_TRUE;                     /* When done we will reschedule          */
//  858                      }
//  859                  }
//  860                  break;
//  861 
//  862 #if OS_FLAG_WAIT_CLR_EN > 0
//  863             case OS_FLAG_WAIT_CLR_ALL:               /* See if all req. flags are set for current node */
//  864                  flags_rdy = (OS_FLAGS)(~pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
//  865                  if (flags_rdy == pnode->OSFlagNodeFlags) {
//  866                      rdy = OS_FlagTaskRdy(pnode, flags_rdy);  /* Make task RTR, event(s) Rx'd          */
//  867                      if (rdy == OS_TRUE) {
//  868                          sched = OS_TRUE;                     /* When done we will reschedule          */
//  869                      }
//  870                  }
//  871                  break;
//  872 
//  873             case OS_FLAG_WAIT_CLR_ANY:               /* See if any flag set                            */
//  874                  flags_rdy = (OS_FLAGS)(~pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
//  875                  if (flags_rdy != (OS_FLAGS)0) {
//  876                      rdy = OS_FlagTaskRdy(pnode, flags_rdy);  /* Make task RTR, event(s) Rx'd          */
//  877                      if (rdy == OS_TRUE) {
//  878                          sched = OS_TRUE;                     /* When done we will reschedule          */
//  879                      }
//  880                  }
//  881                  break;
//  882 #endif
//  883             default:
//  884                  OS_EXIT_CRITICAL();
//  885                  *perr = OS_ERR_FLAG_WAIT_TYPE;
//  886                  return ((OS_FLAGS)0);
//  887         }
//  888         pnode = (OS_FLAG_NODE *)pnode->OSFlagNodeNext; /* Point to next task waiting for event flag(s) */
??OSFlagPost_9:
        LDR      R5,[R5, #+0]
??OSFlagPost_7:
        CBZ.N    R5,??OSFlagPost_11
        LDRB     R0,[R5, #+18]
        CBZ.N    R0,??OSFlagPost_12
        CMP      R0,#+2
        BEQ.N    ??OSFlagPost_8
        BCC.N    ??OSFlagPost_13
        CMP      R0,#+3
        BNE.N    ??OSFlagPost_14
        LDRH     R0,[R6, #+8]
        LDRH     R1,[R5, #+16]
        ANDS     R1,R1,R0
??OSFlagPost_15:
        BEQ.N    ??OSFlagPost_9
        B.N      ??OSFlagPost_10
??OSFlagPost_12:
        LDRH     R0,[R5, #+16]
        LDRH     R1,[R6, #+8]
        BIC      R1,R0,R1
        CMP      R1,R0
        BNE.N    ??OSFlagPost_9
        B.N      ??OSFlagPost_10
??OSFlagPost_13:
        LDRH     R0,[R6, #+8]
        LDRH     R1,[R5, #+16]
        BICS     R1,R1,R0
        B.N      ??OSFlagPost_15
??OSFlagPost_14:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
        MOVS     R0,#+111
        B.N      ??OSFlagPost_1
//  889     }
//  890     OS_EXIT_CRITICAL();
??OSFlagPost_11:
        MOV      R0,R8
        BL       OS_CPU_SR_Restore
//  891     if (sched == OS_TRUE) {
        CBZ.N    R7,??OSFlagPost_16
//  892         OS_Sched();
        BL       OS_Sched
//  893     }
//  894     OS_ENTER_CRITICAL();
??OSFlagPost_16:
        BL       OS_CPU_SR_Save
//  895     flags_cur = pgrp->OSFlagFlags;
        LDRH     R6,[R6, #+8]
//  896     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  897     *perr     = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  898     return (flags_cur);
        MOV      R0,R6
??OSFlagPost_2:
        POP      {R4-R8,PC}       ;; return
//  899 }
//  900 /*$PAGE*/
//  901 /*
//  902 *********************************************************************************************************
//  903 *                                           QUERY EVENT FLAG
//  904 *
//  905 * Description: This function is used to check the value of the event flag group.
//  906 *
//  907 * Arguments  : pgrp         is a pointer to the desired event flag group.
//  908 *
//  909 *              perr          is a pointer to an error code returned to the called:
//  910 *                            OS_ERR_NONE                The call was successfull
//  911 *                            OS_ERR_FLAG_INVALID_PGRP   You passed a NULL pointer
//  912 *                            OS_ERR_EVENT_TYPE          You are not pointing to an event flag group
//  913 *
//  914 * Returns    : The current value of the event flag group.
//  915 *
//  916 * Called From: Task or ISR
//  917 *********************************************************************************************************
//  918 */
//  919 
//  920 #if OS_FLAG_QUERY_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  921 OS_FLAGS  OSFlagQuery (OS_FLAG_GRP *pgrp, INT8U *perr)
//  922 {
OSFlagQuery:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  923     OS_FLAGS   flags;
//  924 #if OS_CRITICAL_METHOD == 3                       /* Allocate storage for CPU status register          */
//  925     OS_CPU_SR  cpu_sr = 0;
//  926 #endif
//  927 
//  928 
//  929 
//  930 #if OS_ARG_CHK_EN > 0
//  931     if (perr == (INT8U *)0) {                     /* Validate 'perr'                                   */
//  932         return ((OS_FLAGS)0);
//  933     }
//  934     if (pgrp == (OS_FLAG_GRP *)0) {               /* Validate 'pgrp'                                   */
//  935         *perr = OS_ERR_FLAG_INVALID_PGRP;
//  936         return ((OS_FLAGS)0);
//  937     }
//  938 #endif
//  939     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) { /* Validate event block type                         */
        LDRB     R0,[R4, #+0]
        CMP      R0,#+5
        BEQ.N    ??OSFlagQuery_0
//  940         *perr = OS_ERR_EVENT_TYPE;
        MOVS     R0,#+1
        STRB     R0,[R5, #+0]
//  941         return ((OS_FLAGS)0);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}
//  942     }
//  943     OS_ENTER_CRITICAL();
??OSFlagQuery_0:
        BL       OS_CPU_SR_Save
//  944     flags = pgrp->OSFlagFlags;
        LDRH     R4,[R4, #+8]
//  945     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  946     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  947     return (flags);                               /* Return the current value of the event flags       */
        MOV      R0,R4
        POP      {R1,R4,R5,PC}    ;; return
//  948 }
//  949 #endif
//  950 
//  951 /*$PAGE*/
//  952 /*
//  953 *********************************************************************************************************
//  954 *                         SUSPEND TASK UNTIL EVENT FLAG(s) RECEIVED OR TIMEOUT OCCURS
//  955 *
//  956 * Description: This function is internal to uC/OS-II and is used to put a task to sleep until the desired
//  957 *              event flag bit(s) are set.
//  958 *
//  959 * Arguments  : pgrp          is a pointer to the desired event flag group.
//  960 *
//  961 *              pnode         is a pointer to a structure which contains data about the task waiting for
//  962 *                            event flag bit(s) to be set.
//  963 *
//  964 *              flags         Is a bit pattern indicating which bit(s) (i.e. flags) you wish to check.
//  965 *                            The bits you want are specified by setting the corresponding bits in
//  966 *                            'flags'.  e.g. if your application wants to wait for bits 0 and 1 then
//  967 *                            'flags' would contain 0x03.
//  968 *
//  969 *              wait_type     specifies whether you want ALL bits to be set/cleared or ANY of the bits
//  970 *                            to be set/cleared.
//  971 *                            You can specify the following argument:
//  972 *
//  973 *                            OS_FLAG_WAIT_CLR_ALL   You will check ALL bits in 'mask' to be clear (0)
//  974 *                            OS_FLAG_WAIT_CLR_ANY   You will check ANY bit  in 'mask' to be clear (0)
//  975 *                            OS_FLAG_WAIT_SET_ALL   You will check ALL bits in 'mask' to be set   (1)
//  976 *                            OS_FLAG_WAIT_SET_ANY   You will check ANY bit  in 'mask' to be set   (1)
//  977 *
//  978 *              timeout       is the desired amount of time that the task will wait for the event flag
//  979 *                            bit(s) to be set.
//  980 *
//  981 * Returns    : none
//  982 *
//  983 * Called by  : OSFlagPend()  OS_FLAG.C
//  984 *
//  985 * Note(s)    : This function is INTERNAL to uC/OS-II and your application should not call it.
//  986 *********************************************************************************************************
//  987 */
//  988 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  989 static  void  OS_FlagBlock (OS_FLAG_GRP *pgrp, OS_FLAG_NODE *pnode, OS_FLAGS flags, INT8U wait_type, INT16U timeout)
//  990 {
OS_FlagBlock:
        PUSH     {R4-R7}
        LDR      R4,[SP, #+16]
//  991     OS_FLAG_NODE  *pnode_next;
//  992     INT8U          y;
//  993 
//  994 
//  995     OSTCBCur->OSTCBStat      |= OS_STAT_FLAG;
        LDR.N    R5,??DataTable8_3
        LDR      R6,[R5, #+0]
        LDRB     R7,[R6, #+28]
        ORR      R7,R7,#0x20
        STRB     R7,[R6, #+28]
//  996     OSTCBCur->OSTCBStatPend   = OS_STAT_PEND_OK;
        LDR      R6,[R5, #+0]
        MOVS     R7,#+0
        STRB     R7,[R6, #+29]
//  997     OSTCBCur->OSTCBDly        = timeout;              /* Store timeout in task's TCB                   */
        LDR      R6,[R5, #+0]
        STRH     R4,[R6, #+26]
//  998 #if OS_TASK_DEL_EN > 0
//  999     OSTCBCur->OSTCBFlagNode   = pnode;                /* TCB to link to node                           */
        STR      R1,[R6, #+20]
// 1000 #endif
// 1001     pnode->OSFlagNodeFlags    = flags;                /* Save the flags that we need to wait for       */
        STRH     R2,[R1, #+16]
// 1002     pnode->OSFlagNodeWaitType = wait_type;            /* Save the type of wait we are doing            */
        STRB     R3,[R1, #+18]
// 1003     pnode->OSFlagNodeTCB      = (void *)OSTCBCur;     /* Link to task's TCB                            */
        LDR      R2,[R5, #+0]
        STR      R2,[R1, #+8]
// 1004     pnode->OSFlagNodeNext     = pgrp->OSFlagWaitList; /* Add node at beginning of event flag wait list */
        LDR      R3,[R0, #+4]
        STR      R3,[R1, #+0]
// 1005     pnode->OSFlagNodePrev     = (void *)0;
        STR      R7,[R1, #+4]
// 1006     pnode->OSFlagNodeFlagGrp  = (void *)pgrp;         /* Link to Event Flag Group                      */
        STR      R0,[R1, #+12]
// 1007     pnode_next                = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
        LDR      R3,[R0, #+4]
// 1008     if (pnode_next != (void *)0) {                    /* Is this the first NODE to insert?             */
        CBZ.N    R3,??OS_FlagBlock_0
// 1009         pnode_next->OSFlagNodePrev = pnode;           /* No, link in doubly linked list                */
        STR      R1,[R3, #+4]
// 1010     }
// 1011     pgrp->OSFlagWaitList = (void *)pnode;
??OS_FlagBlock_0:
        STR      R1,[R0, #+4]
// 1012 
// 1013     y            =  OSTCBCur->OSTCBY;                 /* Suspend current task until flag(s) received   */
        LDRB     R0,[R2, #+32]
// 1014     OSRdyTbl[y] &= ~OSTCBCur->OSTCBBitX;
        ADD      R1,R2,#+32
        LDR.N    R2,??DataTable8_4
        LDRB     R3,[R0, R2]
        LDRB     R4,[R1, #+1]
        BICS     R3,R3,R4
        STRB     R3,[R0, R2]
// 1015     if (OSRdyTbl[y] == 0x00) {
        BNE.N    ??OS_FlagBlock_1
// 1016         OSRdyGrp &= ~OSTCBCur->OSTCBBitY;
        LDR.N    R0,??DataTable8_5
        LDRB     R2,[R0, #+0]
        LDRB     R1,[R1, #+2]
        BIC      R1,R2,R1
        STRB     R1,[R0, #+0]
// 1017     }
// 1018 }
??OS_FlagBlock_1:
        POP      {R4-R7}
        BX       LR               ;; return
// 1019 
// 1020 /*$PAGE*/
// 1021 /*
// 1022 *********************************************************************************************************
// 1023 *                                    INITIALIZE THE EVENT FLAG MODULE
// 1024 *
// 1025 * Description: This function is called by uC/OS-II to initialize the event flag module.  Your application
// 1026 *              MUST NOT call this function.  In other words, this function is internal to uC/OS-II.
// 1027 *
// 1028 * Arguments  : none
// 1029 *
// 1030 * Returns    : none
// 1031 *
// 1032 * WARNING    : You MUST NOT call this function from your code.  This is an INTERNAL function to uC/OS-II.
// 1033 *********************************************************************************************************
// 1034 */
// 1035 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1036 void  OS_FlagInit (void)
// 1037 {
OS_FlagInit:
        PUSH     {R4,LR}
// 1038 #if OS_MAX_FLAGS == 1
// 1039     OSFlagFreeList                 = (OS_FLAG_GRP *)&OSFlagTbl[0];  /* Only ONE event flag group!      */
// 1040     OSFlagFreeList->OSFlagType     = OS_EVENT_TYPE_UNUSED;
// 1041     OSFlagFreeList->OSFlagWaitList = (void *)0;
// 1042     OSFlagFreeList->OSFlagFlags    = (OS_FLAGS)0;
// 1043 #if OS_FLAG_NAME_SIZE > 1
// 1044     OSFlagFreeList->OSFlagName[0]  = '?';
// 1045     OSFlagFreeList->OSFlagName[1]  = OS_ASCII_NUL;
// 1046 #endif
// 1047 #endif
// 1048 
// 1049 #if OS_MAX_FLAGS >= 2
// 1050     INT16U       i;
// 1051     OS_FLAG_GRP *pgrp1;
// 1052     OS_FLAG_GRP *pgrp2;
// 1053 
// 1054 
// 1055     OS_MemClr((INT8U *)&OSFlagTbl[0], sizeof(OSFlagTbl));           /* Clear the flag group table      */
        LDR.N    R4,??DataTable8_6
        MOVS     R1,#+140
        MOV      R0,R4
        BL       OS_MemClr
// 1056     pgrp1 = &OSFlagTbl[0];
        MOV      R0,R4
// 1057     pgrp2 = &OSFlagTbl[1];
        ADDW     R1,R4,#+28
// 1058     for (i = 0; i < (OS_MAX_FLAGS - 1); i++) {                      /* Init. list of free EVENT FLAGS  */
        MOVS     R2,#+4
// 1059         pgrp1->OSFlagType     = OS_EVENT_TYPE_UNUSED;
??OS_FlagInit_0:
        MOVS     R3,#+0
        STRB     R3,[R0], #+4
// 1060         pgrp1->OSFlagWaitList = (void *)pgrp2;
        STR      R1,[R0], #+6
// 1061 #if OS_FLAG_NAME_SIZE > 1
// 1062         pgrp1->OSFlagName[0]  = '?';                                /* Unknown name                    */
        MOVS     R3,#+63
        STRB     R3,[R0], #+1
// 1063         pgrp1->OSFlagName[1]  = OS_ASCII_NUL;
        MOVS     R3,#+0
        STRB     R3,[R0], #+17
// 1064 #endif
// 1065         pgrp1++;
// 1066         pgrp2++;
        ADDW     R1,R1,#+28
// 1067     }
        SUBS     R2,R2,#+1
        BNE.N    ??OS_FlagInit_0
// 1068     pgrp1->OSFlagType     = OS_EVENT_TYPE_UNUSED;
        STRB     R3,[R0, #+0]
// 1069     pgrp1->OSFlagWaitList = (void *)0;
        STR      R3,[R0, #+4]
// 1070 #if OS_FLAG_NAME_SIZE > 1
// 1071     pgrp1->OSFlagName[0]  = '?';                                    /* Unknown name                    */
        MOVS     R1,#+63
        STRB     R1,[R0, #+10]
// 1072     pgrp1->OSFlagName[1]  = OS_ASCII_NUL;
        STRB     R3,[R0, #+11]
// 1073 #endif
// 1074     OSFlagFreeList        = &OSFlagTbl[0];
        LDR.N    R0,??DataTable8_1
        STR      R4,[R0, #+0]
// 1075 #endif
// 1076 }
        POP      {R4,PC}          ;; return
// 1077 
// 1078 /*$PAGE*/
// 1079 /*
// 1080 *********************************************************************************************************
// 1081 *                              MAKE TASK READY-TO-RUN, EVENT(s) OCCURRED
// 1082 *
// 1083 * Description: This function is internal to uC/OS-II and is used to make a task ready-to-run because the
// 1084 *              desired event flag bits have been set.
// 1085 *
// 1086 * Arguments  : pnode         is a pointer to a structure which contains data about the task waiting for
// 1087 *                            event flag bit(s) to be set.
// 1088 *
// 1089 *              flags_rdy     contains the bit pattern of the event flags that cause the task to become
// 1090 *                            ready-to-run.
// 1091 *
// 1092 * Returns    : OS_TRUE       If the task has been placed in the ready list and thus needs scheduling
// 1093 *              OS_FALSE      The task is still not ready to run and thus scheduling is not necessary
// 1094 *
// 1095 * Called by  : OSFlagsPost() OS_FLAG.C
// 1096 *
// 1097 * Note(s)    : 1) This function assumes that interrupts are disabled.
// 1098 *              2) This function is INTERNAL to uC/OS-II and your application should not call it.
// 1099 *********************************************************************************************************
// 1100 */
// 1101 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1102 static  BOOLEAN  OS_FlagTaskRdy (OS_FLAG_NODE *pnode, OS_FLAGS flags_rdy)
// 1103 {
OS_FlagTaskRdy:
        PUSH     {R4,LR}
// 1104     OS_TCB   *ptcb;
// 1105     BOOLEAN   sched;
// 1106 
// 1107 
// 1108     ptcb                 = (OS_TCB *)pnode->OSFlagNodeTCB; /* Point to TCB of waiting task             */
        LDR      R3,[R0, #+8]
// 1109     ptcb->OSTCBDly       = 0;
        ADD      R2,R3,#+24
        MOVS     R4,#+0
        STRH     R4,[R2, #+2]
// 1110     ptcb->OSTCBFlagsRdy  = flags_rdy;
        STRH     R1,[R3, #+24]
// 1111     ptcb->OSTCBStat     &= ~(INT8U)OS_STAT_FLAG;
        LDRB     R1,[R2, #+4]
        AND      R1,R1,#0xDF
        STRB     R1,[R2, #+4]
// 1112     ptcb->OSTCBStatPend  = OS_STAT_PEND_OK;
        STRB     R4,[R2, #+5]
// 1113     if (ptcb->OSTCBStat == OS_STAT_RDY) {                  /* Task now ready?                          */
        LDRB     R1,[R2, #+4]
        CBNZ.N   R1,??OS_FlagTaskRdy_0
// 1114         OSRdyGrp               |= ptcb->OSTCBBitY;         /* Put task into ready list                 */
        LDR.N    R1,??DataTable8_5
        LDRB     R3,[R1, #+0]
        LDRB     R4,[R2, #+10]
        ORRS     R3,R4,R3
        STRB     R3,[R1, #+0]
        LDRB     R1,[R2, #+8]
        LDR.N    R3,??DataTable8_4
        LDRB     R4,[R1, R3]
        LDRB     R2,[R2, #+9]
        ORRS     R2,R2,R4
        STRB     R2,[R1, R3]
// 1115         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
// 1116         sched                   = OS_TRUE;
        MOVS     R4,#+1
// 1117     } else {
// 1118         sched                   = OS_FALSE;
// 1119     }
// 1120     OS_FlagUnlink(pnode);
??OS_FlagTaskRdy_0:
        BL       OS_FlagUnlink
// 1121     return (sched);
        MOV      R0,R4
        POP      {R4,PC}          ;; return
// 1122 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_1:
        DC32     OSFlagFreeList

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_2:
        DC32     OSLockNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_3:
        DC32     OSTCBCur

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_4:
        DC32     OSRdyTbl

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_5:
        DC32     OSRdyGrp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_6:
        DC32     OSFlagTbl
// 1123 
// 1124 /*$PAGE*/
// 1125 /*
// 1126 *********************************************************************************************************
// 1127 *                                  UNLINK EVENT FLAG NODE FROM WAITING LIST
// 1128 *
// 1129 * Description: This function is internal to uC/OS-II and is used to unlink an event flag node from a
// 1130 *              list of tasks waiting for the event flag.
// 1131 *
// 1132 * Arguments  : pnode         is a pointer to a structure which contains data about the task waiting for
// 1133 *                            event flag bit(s) to be set.
// 1134 *
// 1135 * Returns    : none
// 1136 *
// 1137 * Called by  : OS_FlagTaskRdy() OS_FLAG.C
// 1138 *              OSFlagPend()     OS_FLAG.C
// 1139 *              OSTaskDel()      OS_TASK.C
// 1140 *
// 1141 * Note(s)    : 1) This function assumes that interrupts are disabled.
// 1142 *              2) This function is INTERNAL to uC/OS-II and your application should not call it.
// 1143 *********************************************************************************************************
// 1144 */
// 1145 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1146 void  OS_FlagUnlink (OS_FLAG_NODE *pnode)
// 1147 {
// 1148 #if OS_TASK_DEL_EN > 0
// 1149     OS_TCB       *ptcb;
// 1150 #endif
// 1151     OS_FLAG_GRP  *pgrp;
// 1152     OS_FLAG_NODE *pnode_prev;
// 1153     OS_FLAG_NODE *pnode_next;
// 1154 
// 1155 
// 1156     pnode_prev = (OS_FLAG_NODE *)pnode->OSFlagNodePrev;
OS_FlagUnlink:
        LDR      R1,[R0, #+4]
// 1157     pnode_next = (OS_FLAG_NODE *)pnode->OSFlagNodeNext;
        LDR      R2,[R0, #+0]
// 1158     if (pnode_prev == (OS_FLAG_NODE *)0) {                      /* Is it first node in wait list?      */
        CBNZ.N   R1,??OS_FlagUnlink_0
// 1159         pgrp                 = (OS_FLAG_GRP *)pnode->OSFlagNodeFlagGrp;
// 1160         pgrp->OSFlagWaitList = (void *)pnode_next;              /*      Update list for new 1st node   */
        LDR      R1,[R0, #+12]
        STR      R2,[R1, #+4]
// 1161         if (pnode_next != (OS_FLAG_NODE *)0) {
        CBZ.N    R2,??OS_FlagUnlink_1
// 1162             pnode_next->OSFlagNodePrev = (OS_FLAG_NODE *)0;     /*      Link new 1st node PREV to NULL */
        MOVS     R1,#+0
        B.N      ??OS_FlagUnlink_2
// 1163         }
// 1164     } else {                                                    /* No,  A node somewhere in the list   */
// 1165         pnode_prev->OSFlagNodeNext = pnode_next;                /*      Link around the node to unlink */
??OS_FlagUnlink_0:
        STR      R2,[R1, #+0]
// 1166         if (pnode_next != (OS_FLAG_NODE *)0) {                  /*      Was this the LAST node?        */
        CBZ.N    R2,??OS_FlagUnlink_1
// 1167             pnode_next->OSFlagNodePrev = pnode_prev;            /*      No, Link around current node   */
??OS_FlagUnlink_2:
        STR      R1,[R2, #+4]
// 1168         }
// 1169     }
// 1170 #if OS_TASK_DEL_EN > 0
// 1171     ptcb                = (OS_TCB *)pnode->OSFlagNodeTCB;
// 1172     ptcb->OSTCBFlagNode = (OS_FLAG_NODE *)0;
??OS_FlagUnlink_1:
        LDR      R0,[R0, #+8]
        MOVS     R1,#+0
        STR      R1,[R0, #+20]
// 1173 #endif
// 1174 }
        BX       LR               ;; return

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 1175 #endif
// 
// 1 360 bytes in section .text
// 
// 1 360 bytes of CODE memory
//
//Errors: none
//Warnings: none
