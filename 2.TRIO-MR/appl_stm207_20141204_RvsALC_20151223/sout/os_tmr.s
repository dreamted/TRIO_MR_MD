///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:39 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_tmr.c                                          /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_tmr.c -D OS_INCLUDED -D APPL_SRC -lcN          /
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
//                    mr.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_tmr

        #define SHT_PROGBITS 0x1



        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\Source\os_tmr.c
//    1 /*
//    2 ************************************************************************************************************************
//    3 *                                                      uC/OS-III
//    4 *                                                 The Real-Time Kernel
//    5 *
//    6 *                                     (c) Copyright 2005-2007, Micrium, Weston, FL
//    7 *                                                  All Rights Reserved
//    8 *
//    9 *                                                   TIMER MANAGEMENT
//   10 *
//   11 * File    : OS_TMR.C
//   12 * By      : Jean J. Labrosse
//   13 * Version : V2.85
//   14 *
//   15 * LICENSING TERMS:
//   16 * ---------------
//   17 *   uC/OS-II is provided in source form for FREE evaluation, for educational use or for peaceful research.  
//   18 * If you plan on using  uC/OS-II  in a commercial product you need to contact Micri?m to properly license 
//   19 * its use in your product. We provide ALL the source code for your convenience and to help you experience 
//   20 * uC/OS-II.   The fact that the  source is provided does  NOT  mean that you can use it without  paying a 
//   21 * licensing fee.
//   22 ************************************************************************************************************************
//   23 */
//   24 
//   25 
//   26 #include <ucos_ii.h>
//   27 
//   28 /*
//   29 ************************************************************************************************************************
//   30 *                                                        NOTES
//   31 *
//   32 * 1) Your application MUST define the following #define constants:
//   33 *
//   34 *    OS_TASK_TMR_PRIO          The priority of the Timer management task
//   35 *    OS_TASK_TMR_STK_SIZE      The size     of the Timer management task's stack
//   36 *
//   37 * 2) You must call OSTmrSignal() to notify the Timer management task that it's time to update the timers.
//   38 ************************************************************************************************************************
//   39 */
//   40 
//   41 /*
//   42 ************************************************************************************************************************
//   43 *                                                     CONSTANTS
//   44 ************************************************************************************************************************
//   45 */
//   46 
//   47 #define  OS_TMR_LINK_DLY       0
//   48 #define  OS_TMR_LINK_PERIODIC  1
//   49 
//   50 /*
//   51 ************************************************************************************************************************
//   52 *                                                  LOCAL PROTOTYPES
//   53 ************************************************************************************************************************
//   54 */
//   55 
//   56 #if OS_TMR_EN > 0
//   57 static  OS_TMR  *OSTmr_Alloc         (void);
//   58 static  void     OSTmr_Free          (OS_TMR *ptmr);
//   59 static  void     OSTmr_InitTask      (void);
//   60 static  void     OSTmr_Link          (OS_TMR *ptmr, INT8U type);
//   61 static  void     OSTmr_Unlink        (OS_TMR *ptmr);
//   62 static  void     OSTmr_Lock          (void);
//   63 static  void     OSTmr_Unlock        (void);
//   64 static  void     OSTmr_Task          (void   *p_arg);
//   65 #endif
//   66 
//   67 /*$PAGE*/
//   68 /*
//   69 ************************************************************************************************************************
//   70 *                                                   CREATE A TIMER
//   71 *
//   72 * Description: This function is called by your application code to create a timer.
//   73 *
//   74 * Arguments  : dly           Initial delay.
//   75 *                            If the timer is configured for ONE-SHOT mode, this is the timeout used
//   76 *                            If the timer is configured for PERIODIC mode, this is the first timeout to wait for
//   77 *                               before the timer starts entering periodic mode
//   78 *
//   79 *              period        The 'period' being repeated for the timer.
//   80 *                               If you specified 'OS_TMR_OPT_PERIODIC' as an option, when the timer expires, it will
//   81 *                               automatically restart with the same period.
//   82 *
//   83 *              opt           Specifies either:
//   84 *                               OS_TMR_OPT_ONE_SHOT       The timer counts down only once
//   85 *                               OS_TMR_OPT_PERIODIC       The timer counts down and then reloads itself
//   86 *
//   87 *              callback      Is a pointer to a callback function that will be called when the timer expires.  The
//   88 *                               callback function must be declared as follows:
//   89 *
//   90 *                               void MyCallback (OS_TMR *ptmr, void *p_arg);
//   91 *
//   92 *              callback_arg  Is an argument (a pointer) that is passed to the callback function when it is called.
//   93 *
//   94 *              pname         Is a pointer to an ASCII string that is used to name the timer.  Names are useful for
//   95 *                               debugging.  The length of the ASCII string for the name can be as big as:
//   96 *
//   97 *                               OS_TMR_CFG_NAME_SIZE and should be found in OS_CFG.H
//   98 *
//   99 *              perr          Is a pointer to an error code.  '*perr' will contain one of the following:
//  100 *                               OS_ERR_NONE
//  101 *                               OS_ERR_TMR_INVALID_DLY     you specified an invalid delay
//  102 *                               OS_ERR_TMR_INVALID_PERIOD  you specified an invalid period
//  103 *                               OS_ERR_TMR_INVALID_OPT     you specified an invalid option
//  104 *                               OS_ERR_TMR_ISR             if the call was made from an ISR
//  105 *                               OS_ERR_TMR_NON_AVAIL       if there are no free timers from the timer pool
//  106 *                               OS_ERR_TMR_NAME_TOO_LONG   if the timer name is too long to fit
//  107 *
//  108 * Returns    : A pointer to an OS_TMR data structure.  
//  109 *              This is the 'handle' that your application will use to reference the timer created.
//  110 ************************************************************************************************************************
//  111 */
//  112 
//  113 #if OS_TMR_EN > 0
//  114 OS_TMR  *OSTmrCreate (INT32U           dly,
//  115                       INT32U           period,
//  116                       INT8U            opt,
//  117                       OS_TMR_CALLBACK  callback,
//  118                       void            *callback_arg,
//  119                       INT8U           *pname,
//  120                       INT8U           *perr)
//  121 {
//  122     OS_TMR   *ptmr;
//  123 #if OS_TMR_CFG_NAME_SIZE > 0
//  124     INT8U     len;
//  125 #endif
//  126 
//  127 
//  128 #if OS_ARG_CHK_EN > 0
//  129     if (perr == (INT8U *)0) {                               /* Validate arguments                                     */
//  130         return ((OS_TMR *)0);
//  131     }
//  132     switch (opt) {
//  133         case OS_TMR_OPT_PERIODIC:
//  134              if (period == 0) {
//  135                  *perr = OS_ERR_TMR_INVALID_PERIOD;
//  136                  return ((OS_TMR *)0);
//  137              }
//  138              break;
//  139 
//  140         case OS_TMR_OPT_ONE_SHOT:
//  141              if (dly == 0) {
//  142                  *perr = OS_ERR_TMR_INVALID_DLY;
//  143                  return ((OS_TMR *)0);
//  144              }
//  145              break;
//  146 
//  147         default:
//  148              *perr = OS_ERR_TMR_INVALID_OPT;
//  149              return ((OS_TMR *)0);
//  150     }
//  151 #endif
//  152     if (OSIntNesting > 0) {                                 /* See if trying to call from an ISR                      */
//  153         *perr  = OS_ERR_TMR_ISR;
//  154         return ((OS_TMR *)0);
//  155     }
//  156     OSTmr_Lock();
//  157     ptmr = OSTmr_Alloc();                                   /* Obtain a timer from the free pool                      */
//  158     if (ptmr == (OS_TMR *)0) {
//  159         OSTmr_Unlock();
//  160         *perr = OS_ERR_TMR_NON_AVAIL;
//  161         return ((OS_TMR *)0);
//  162     }
//  163     ptmr->OSTmrState       = OS_TMR_STATE_STOPPED;          /* Indicate that timer is not running yet                 */
//  164     ptmr->OSTmrDly         = dly;
//  165     ptmr->OSTmrPeriod      = period;
//  166     ptmr->OSTmrOpt         = opt;
//  167     ptmr->OSTmrCallback    = callback;
//  168     ptmr->OSTmrCallbackArg = callback_arg;
//  169 #if OS_TMR_CFG_NAME_SIZE > 0
//  170     if (pname !=(INT8U *)0) {
//  171         len = OS_StrLen(pname);                             /* Copy timer name                                        */
//  172         if (len < OS_TMR_CFG_NAME_SIZE) {
//  173             (void)OS_StrCopy(ptmr->OSTmrName, pname);
//  174         } else {
//  175 #if OS_TMR_CFG_NAME_SIZE > 1
//  176             ptmr->OSTmrName[0] = '#';                       /* Invalid size specified                                 */
//  177             ptmr->OSTmrName[1] = OS_ASCII_NUL;
//  178 #endif
//  179             *perr              = OS_ERR_TMR_NAME_TOO_LONG;
//  180             OSTmr_Unlock();
//  181             return (ptmr);
//  182         }
//  183     }
//  184 #endif
//  185     OSTmr_Unlock();
//  186     *perr = OS_ERR_NONE;
//  187     return (ptmr);
//  188 }
//  189 #endif
//  190 
//  191 /*$PAGE*/
//  192 /*
//  193 ************************************************************************************************************************
//  194 *                                                   DELETE A TIMER
//  195 *
//  196 * Description: This function is called by your application code to delete a timer.
//  197 *
//  198 * Arguments  : ptmr          Is a pointer to the timer to stop and delete.
//  199 *
//  200 *              perr          Is a pointer to an error code.  '*perr' will contain one of the following:
//  201 *                               OS_ERR_NONE
//  202 *                               OS_ERR_TMR_INVALID        'ptmr'  is a NULL pointer
//  203 *                               OS_ERR_TMR_INVALID_TYPE   'ptmr'  is not pointing to an OS_TMR
//  204 *                               OS_ERR_TMR_ISR            if the function was called from an ISR
//  205 *                               OS_ERR_TMR_INACTIVE       if the timer was not created
//  206 *                               OS_ERR_TMR_INVALID_STATE  the timer is in an invalid state
//  207 *
//  208 * Returns    : OS_TRUE       If the call was successful
//  209 *              OS_FALSE      If not
//  210 ************************************************************************************************************************
//  211 */
//  212 
//  213 #if OS_TMR_EN > 0
//  214 BOOLEAN  OSTmrDel (OS_TMR  *ptmr,
//  215                    INT8U   *perr)
//  216 {
//  217 #if OS_ARG_CHK_EN > 0
//  218     if (perr == (INT8U *)0) {                               /* Validate arguments                                     */
//  219         return (OS_FALSE);
//  220     }
//  221     if (ptmr == (OS_TMR *)0) {
//  222         *perr = OS_ERR_TMR_INVALID;
//  223         return (OS_FALSE);
//  224     }
//  225 #endif
//  226     if (ptmr->OSTmrType != OS_TMR_TYPE) {                   /* Validate timer structure                               */
//  227         *perr = OS_ERR_TMR_INVALID_TYPE;
//  228         return (OS_FALSE);
//  229     }
//  230     if (OSIntNesting > 0) {                                 /* See if trying to call from an ISR                      */
//  231         *perr  = OS_ERR_TMR_ISR;
//  232         return (OS_FALSE);
//  233     }
//  234     OSTmr_Lock();
//  235     switch (ptmr->OSTmrState) {
//  236         case OS_TMR_STATE_RUNNING:
//  237              OSTmr_Unlink(ptmr);                            /* Remove from current wheel spoke                        */
//  238              OSTmr_Free(ptmr);                              /* Return timer to free list of timers                    */
//  239              OSTmr_Unlock();
//  240              *perr = OS_ERR_NONE;
//  241              return (OS_TRUE);
//  242 
//  243         case OS_TMR_STATE_STOPPED:                          /* Timer has not started or ...                           */
//  244         case OS_TMR_STATE_COMPLETED:                        /* ... timer has completed the ONE-SHOT time              */
//  245              OSTmr_Free(ptmr);                              /* Return timer to free list of timers                    */
//  246              OSTmr_Unlock();
//  247              *perr = OS_ERR_NONE;
//  248              return (OS_TRUE);
//  249 
//  250         case OS_TMR_STATE_UNUSED:                           /* Already deleted                                        */
//  251              OSTmr_Unlock();
//  252              *perr = OS_ERR_TMR_INACTIVE;
//  253              return (OS_FALSE);
//  254 
//  255         default:
//  256              OSTmr_Unlock();
//  257              *perr = OS_ERR_TMR_INVALID_STATE;
//  258              return (OS_FALSE);
//  259     }
//  260 }
//  261 #endif
//  262 
//  263 /*$PAGE*/
//  264 /*
//  265 ************************************************************************************************************************
//  266 *                                             GET THE NAME OF A TIMER
//  267 *
//  268 * Description: This function is called to obtain the name of a timer.
//  269 *
//  270 * Arguments  : ptmr          Is a pointer to the timer to obtain the name for
//  271 *
//  272 *              pdest         Is a pointer to where the name of the timer will be placed.  It is the caller's responsibility
//  273 *                            to ensure that he has sufficient storage in the destination, i.e. at least OS_TMR_CFG_NAME_SIZE
//  274 *
//  275 *              perr          Is a pointer to an error code.  '*perr' will contain one of the following:
//  276 *                               OS_ERR_NONE               The call was successful
//  277 *                               OS_ERR_TMR_INVALID_DEST   'pdest' is a NULL pointer
//  278 *                               OS_ERR_TMR_INVALID        'ptmr'  is a NULL pointer
//  279 *                               OS_ERR_TMR_INVALID_TYPE   'ptmr'  is not pointing to an OS_TMR
//  280 *                               OS_ERR_NAME_GET_ISR       if the call was made from an ISR
//  281 *                               OS_ERR_TMR_INACTIVE       'ptmr'  points to a timer that is not active
//  282 *                               OS_ERR_TMR_INVALID_STATE  the timer is in an invalid state
//  283 *
//  284 * Returns    : The length of the string or 0 if the timer does not exist.
//  285 ************************************************************************************************************************
//  286 */
//  287 
//  288 #if OS_TMR_EN > 0 && OS_TMR_CFG_NAME_SIZE > 0
//  289 INT8U  OSTmrNameGet (OS_TMR  *ptmr,
//  290                      INT8U   *pdest,
//  291                      INT8U   *perr)
//  292 {
//  293     INT8U  len;
//  294 
//  295 
//  296 #if OS_ARG_CHK_EN > 0
//  297     if (perr == (INT8U *)0) {
//  298         return (0);
//  299     }
//  300     if (pdest == (INT8U *)0) {
//  301         *perr = OS_ERR_TMR_INVALID_DEST;
//  302         return (0);
//  303     }
//  304     if (ptmr == (OS_TMR *)0) {
//  305         *perr = OS_ERR_TMR_INVALID;
//  306         return (0);
//  307     }
//  308 #endif
//  309     if (ptmr->OSTmrType != OS_TMR_TYPE) {              /* Validate timer structure                                    */
//  310         *perr = OS_ERR_TMR_INVALID_TYPE;
//  311         return (0);
//  312     }
//  313     if (OSIntNesting > 0) {                            /* See if trying to call from an ISR                           */
//  314         *perr = OS_ERR_NAME_GET_ISR;
//  315         return (0);
//  316     }
//  317     OSTmr_Lock();
//  318     switch (ptmr->OSTmrState) {
//  319         case OS_TMR_STATE_RUNNING:
//  320         case OS_TMR_STATE_STOPPED:
//  321         case OS_TMR_STATE_COMPLETED:
//  322              len   = OS_StrCopy(pdest, ptmr->OSTmrName);
//  323              OSTmr_Unlock();
//  324              *perr = OS_ERR_NONE;
//  325              return (len);
//  326 
//  327         case OS_TMR_STATE_UNUSED:                      /* Timer is not allocated                                      */
//  328              OSTmr_Unlock();
//  329              *perr = OS_ERR_TMR_INACTIVE;
//  330              return (0);
//  331 
//  332         default:
//  333              OSTmr_Unlock();
//  334              *perr = OS_ERR_TMR_INVALID_STATE;
//  335              return (0);
//  336     }
//  337 }
//  338 #endif
//  339 
//  340 /*$PAGE*/
//  341 /*
//  342 ************************************************************************************************************************
//  343 *                                    GET HOW MUCH TIME IS LEFT BEFORE A TIMER EXPIRES
//  344 *
//  345 * Description: This function is called to get the number of ticks before a timer times out.
//  346 *
//  347 * Arguments  : ptmr          Is a pointer to the timer to obtain the remaining time from.
//  348 *
//  349 *              perr          Is a pointer to an error code.  '*perr' will contain one of the following:
//  350 *                               OS_ERR_NONE
//  351 *                               OS_ERR_TMR_INVALID        'ptmr' is a NULL pointer
//  352 *                               OS_ERR_TMR_INVALID_TYPE   'ptmr'  is not pointing to an OS_TMR
//  353 *                               OS_ERR_TMR_ISR            if the call was made from an ISR
//  354 *                               OS_ERR_TMR_INACTIVE       'ptmr' points to a timer that is not active
//  355 *                               OS_ERR_TMR_INVALID_STATE  the timer is in an invalid state
//  356 *
//  357 * Returns    : The time remaining for the timer to expire.  The time represents 'timer' increments.  In other words, if
//  358 *              OSTmr_Task() is signaled every 1/10 of a second then the returned value represents the number of 1/10 of
//  359 *              a second remaining before the timer expires.
//  360 ************************************************************************************************************************
//  361 */
//  362 
//  363 #if OS_TMR_EN > 0
//  364 INT32U  OSTmrRemainGet (OS_TMR  *ptmr,
//  365                         INT8U   *perr)
//  366 {
//  367     INT32U  remain;
//  368 
//  369 
//  370 #if OS_ARG_CHK_EN > 0
//  371     if (perr == (INT8U *)0) {
//  372         return (0);
//  373     }
//  374     if (ptmr == (OS_TMR *)0) {
//  375         *perr = OS_ERR_TMR_INVALID;
//  376         return (0);
//  377     }
//  378 #endif
//  379     if (ptmr->OSTmrType != OS_TMR_TYPE) {              /* Validate timer structure                                    */
//  380         *perr = OS_ERR_TMR_INVALID_TYPE;
//  381         return (0);
//  382     }
//  383     if (OSIntNesting > 0) {                            /* See if trying to call from an ISR                           */
//  384         *perr = OS_ERR_TMR_ISR;
//  385         return (0);
//  386     }
//  387     OSTmr_Lock();
//  388     switch (ptmr->OSTmrState) {
//  389         case OS_TMR_STATE_RUNNING:
//  390              remain = ptmr->OSTmrMatch - OSTmrTime;    /* Determine how much time is left to timeout                  */
//  391              OSTmr_Unlock();
//  392              *perr  = OS_ERR_NONE;
//  393              return (remain);
//  394 
//  395         case OS_TMR_STATE_STOPPED:                     /* It's assumed that the timer has not started yet             */
//  396              switch (ptmr->OSTmrOpt) {
//  397                  case OS_TMR_OPT_PERIODIC:
//  398                       if (ptmr->OSTmrDly == 0) {
//  399                           remain = ptmr->OSTmrPeriod;
//  400                       } else {
//  401                           remain = ptmr->OSTmrDly;
//  402                       }
//  403                       OSTmr_Unlock();
//  404                       *perr  = OS_ERR_NONE;
//  405                       break;
//  406 
//  407                  case OS_TMR_OPT_ONE_SHOT:
//  408                  default:
//  409                       remain = ptmr->OSTmrDly;
//  410                       OSTmr_Unlock();
//  411                       *perr  = OS_ERR_NONE;
//  412                       break;
//  413              }
//  414              return (remain);
//  415 
//  416         case OS_TMR_STATE_COMPLETED:                   /* Only ONE-SHOT that timed out can be in this state           */
//  417              OSTmr_Unlock();
//  418              *perr = OS_ERR_NONE;
//  419              return (0);
//  420 
//  421         case OS_TMR_STATE_UNUSED:
//  422              OSTmr_Unlock();
//  423              *perr = OS_ERR_TMR_INACTIVE;
//  424              return (0);
//  425 
//  426         default:
//  427              OSTmr_Unlock();
//  428              *perr = OS_ERR_TMR_INVALID_STATE;
//  429              return (0);
//  430     }
//  431 }
//  432 #endif
//  433 
//  434 /*$PAGE*/
//  435 /*
//  436 ************************************************************************************************************************
//  437 *                                    FIND OUT WHAT STATE A TIMER IS IN
//  438 *
//  439 * Description: This function is called to determine what state the timer is in:
//  440 *
//  441 *                  OS_TMR_STATE_UNUSED     the timer has not been created
//  442 *                  OS_TMR_STATE_STOPPED    the timer has been created but has not been started or has been stopped
//  443 *                  OS_TMR_COMPLETED        the timer is in ONE-SHOT mode and has completed it's timeout
//  444 *                  OS_TMR_RUNNING          the timer is currently running
//  445 *
//  446 * Arguments  : ptmr          Is a pointer to the desired timer
//  447 *
//  448 *              perr          Is a pointer to an error code.  '*perr' will contain one of the following:
//  449 *                               OS_ERR_NONE
//  450 *                               OS_ERR_TMR_INVALID        'ptmr' is a NULL pointer
//  451 *                               OS_ERR_TMR_INVALID_TYPE   'ptmr'  is not pointing to an OS_TMR
//  452 *                               OS_ERR_TMR_ISR            if the call was made from an ISR
//  453 *                               OS_ERR_TMR_INACTIVE       'ptmr' points to a timer that is not active
//  454 *                               OS_ERR_TMR_INVALID_STATE  if the timer is not in a valid state
//  455 *
//  456 * Returns    : The current state of the timer (see description).
//  457 ************************************************************************************************************************
//  458 */
//  459 
//  460 #if OS_TMR_EN > 0
//  461 INT8U  OSTmrStateGet (OS_TMR  *ptmr,
//  462                       INT8U   *perr)
//  463 {
//  464     INT8U  state;
//  465 
//  466 
//  467 #if OS_ARG_CHK_EN > 0
//  468     if (perr == (INT8U *)0) {
//  469         return (0);
//  470     }
//  471     if (ptmr == (OS_TMR *)0) {
//  472         *perr = OS_ERR_TMR_INVALID;
//  473         return (0);
//  474     }
//  475 #endif
//  476     if (ptmr->OSTmrType != OS_TMR_TYPE) {              /* Validate timer structure                                    */
//  477         *perr = OS_ERR_TMR_INVALID_TYPE;
//  478         return (0);
//  479     }
//  480     if (OSIntNesting > 0) {                            /* See if trying to call from an ISR                           */
//  481         *perr = OS_ERR_TMR_ISR;
//  482         return (0);
//  483     }
//  484     OSTmr_Lock();
//  485     state = ptmr->OSTmrState;
//  486     switch (state) {
//  487         case OS_TMR_STATE_UNUSED:   
//  488         case OS_TMR_STATE_STOPPED:  
//  489         case OS_TMR_STATE_COMPLETED:
//  490         case OS_TMR_STATE_RUNNING:  
//  491              *perr = OS_ERR_NONE;
//  492              break;
//  493              
//  494         default:
//  495              *perr = OS_ERR_TMR_INVALID_STATE;
//  496              break;
//  497     }
//  498     OSTmr_Unlock();
//  499     return (state);
//  500 }
//  501 #endif
//  502 
//  503 /*$PAGE*/
//  504 /*
//  505 ************************************************************************************************************************
//  506 *                                                   START A TIMER
//  507 *
//  508 * Description: This function is called by your application code to start a timer.
//  509 *
//  510 * Arguments  : ptmr          Is a pointer to an OS_TMR
//  511 *
//  512 *              perr          Is a pointer to an error code.  '*perr' will contain one of the following:
//  513 *                               OS_ERR_NONE
//  514 *                               OS_ERR_TMR_INVALID
//  515 *                               OS_ERR_TMR_INVALID_TYPE    'ptmr'  is not pointing to an OS_TMR
//  516 *                               OS_ERR_TMR_ISR             if the call was made from an ISR
//  517 *                               OS_ERR_TMR_INACTIVE        if the timer was not created
//  518 *                               OS_ERR_TMR_INVALID_STATE   the timer is in an invalid state
//  519 *
//  520 * Returns    : OS_TRUE    if the timer was started
//  521 *              OS_FALSE   if an error was detected
//  522 ************************************************************************************************************************
//  523 */
//  524 
//  525 #if OS_TMR_EN > 0
//  526 BOOLEAN  OSTmrStart (OS_TMR   *ptmr,
//  527                      INT8U    *perr)
//  528 {
//  529 #if OS_ARG_CHK_EN > 0
//  530     if (perr == (INT8U *)0) {                               /* Validate arguments                                     */
//  531         return (OS_FALSE);
//  532     }
//  533     if (ptmr == (OS_TMR *)0) {
//  534         *perr = OS_ERR_TMR_INVALID;
//  535         return (OS_FALSE);
//  536     }
//  537 #endif
//  538     if (ptmr->OSTmrType != OS_TMR_TYPE) {                   /* Validate timer structure                               */
//  539         *perr = OS_ERR_TMR_INVALID_TYPE;
//  540         return (OS_FALSE);
//  541     }
//  542     if (OSIntNesting > 0) {                                 /* See if trying to call from an ISR                      */
//  543         *perr  = OS_ERR_TMR_ISR;
//  544         return (OS_FALSE);
//  545     }
//  546     OSTmr_Lock();
//  547     switch (ptmr->OSTmrState) {
//  548         case OS_TMR_STATE_RUNNING:                          /* Restart the timer                                      */
//  549              OSTmr_Unlink(ptmr);                            /* ... Stop the timer                                     */
//  550              OSTmr_Link(ptmr, OS_TMR_LINK_DLY);             /* ... Link timer to timer wheel                          */
//  551              OSTmr_Unlock();
//  552              *perr = OS_ERR_NONE;
//  553              return (OS_TRUE);
//  554 
//  555         case OS_TMR_STATE_STOPPED:                          /* Start the timer                                        */
//  556         case OS_TMR_STATE_COMPLETED:
//  557              OSTmr_Link(ptmr, OS_TMR_LINK_DLY);             /* ... Link timer to timer wheel                          */
//  558              OSTmr_Unlock();
//  559              *perr = OS_ERR_NONE;
//  560              return (OS_TRUE);
//  561 
//  562         case OS_TMR_STATE_UNUSED:                           /* Timer not created                                      */
//  563              OSTmr_Unlock();
//  564              *perr = OS_ERR_TMR_INACTIVE;
//  565              return (OS_FALSE);
//  566 
//  567         default:
//  568              OSTmr_Unlock();
//  569              *perr = OS_ERR_TMR_INVALID_STATE;
//  570              return (OS_FALSE);
//  571     }
//  572 }
//  573 #endif
//  574 
//  575 /*$PAGE*/
//  576 /*
//  577 ************************************************************************************************************************
//  578 *                                                   STOP A TIMER
//  579 *
//  580 * Description: This function is called by your application code to stop a timer.
//  581 *
//  582 * Arguments  : ptmr          Is a pointer to the timer to stop.
//  583 *
//  584 *              opt           Allows you to specify an option to this functions which can be:
//  585 *
//  586 *                               OS_TMR_OPT_NONE          Do nothing special but stop the timer
//  587 *                               OS_TMR_OPT_CALLBACK      Execute the callback function, pass it the callback argument
//  588 *                                                        specified when the timer was created.
//  589 *                               OS_TMR_OPT_CALLBACK_ARG  Execute the callback function, pass it the callback argument
//  590 *                                                        specified in THIS function call
//  591 *
//  592 *              callback_arg  Is a pointer to a 'new' callback argument that can be passed to the callback function
//  593 *                               instead of the timer's callback argument.  In other words, use 'callback_arg' passed in
//  594 *                               THIS function INSTEAD of ptmr->OSTmrCallbackArg
//  595 *
//  596 *              perr          Is a pointer to an error code.  '*perr' will contain one of the following:
//  597 *                               OS_ERR_NONE
//  598 *                               OS_ERR_TMR_INVALID         'ptmr' is a NULL pointer
//  599 *                               OS_ERR_TMR_INVALID_TYPE    'ptmr'  is not pointing to an OS_TMR
//  600 *                               OS_ERR_TMR_ISR             if the function was called from an ISR
//  601 *                               OS_ERR_TMR_INACTIVE        if the timer was not created
//  602 *                               OS_ERR_TMR_INVALID_OPT     if you specified an invalid option for 'opt'
//  603 *                               OS_ERR_TMR_STOPPED         if the timer was already stopped
//  604 *                               OS_ERR_TMR_INVALID_STATE   the timer is in an invalid state
//  605 *                               OS_ERR_TMR_NO_CALLBACK     if the timer does not have a callback function defined
//  606 *
//  607 * Returns    : OS_TRUE       If we stopped the timer (if the timer is already stopped, we also return OS_TRUE)
//  608 *              OS_FALSE      If not
//  609 ************************************************************************************************************************
//  610 */
//  611 
//  612 #if OS_TMR_EN > 0
//  613 BOOLEAN  OSTmrStop (OS_TMR  *ptmr,
//  614                     INT8U    opt,
//  615                     void    *callback_arg,
//  616                     INT8U   *perr)
//  617 {
//  618     OS_TMR_CALLBACK  pfnct;
//  619 
//  620 
//  621 #if OS_ARG_CHK_EN > 0
//  622     if (perr == (INT8U *)0) {                                     /* Validate arguments                               */
//  623         return (OS_FALSE);
//  624     }
//  625     if (ptmr == (OS_TMR *)0) {
//  626         *perr = OS_ERR_TMR_INVALID;
//  627         return (OS_FALSE);
//  628     }
//  629 #endif
//  630     if (ptmr->OSTmrType != OS_TMR_TYPE) {                         /* Validate timer structure                         */
//  631         *perr = OS_ERR_TMR_INVALID_TYPE;
//  632         return (OS_FALSE);
//  633     }
//  634     if (OSIntNesting > 0) {                                       /* See if trying to call from an ISR                */
//  635         *perr  = OS_ERR_TMR_ISR;
//  636         return (OS_FALSE);
//  637     }
//  638     OSTmr_Lock();
//  639     switch (ptmr->OSTmrState) {
//  640         case OS_TMR_STATE_RUNNING:
//  641              OSTmr_Unlink(ptmr);                                  /* Remove from current wheel spoke                  */
//  642              *perr = OS_ERR_NONE;
//  643              switch (opt) {
//  644                  case OS_TMR_OPT_CALLBACK:
//  645                       pfnct = ptmr->OSTmrCallback;                /* Execute callback function if available ...       */
//  646                       if (pfnct != (OS_TMR_CALLBACK)0) {
//  647                           (*pfnct)((void *)ptmr, ptmr->OSTmrCallbackArg);  /* Use callback arg when timer was created */
//  648                       } else {
//  649                           *perr = OS_ERR_TMR_NO_CALLBACK;
//  650                       }
//  651                       break;
//  652 
//  653                  case OS_TMR_OPT_CALLBACK_ARG:
//  654                       pfnct = ptmr->OSTmrCallback;                /* Execute callback function if available ...       */
//  655                       if (pfnct != (OS_TMR_CALLBACK)0) {
//  656                           (*pfnct)((void *)ptmr, callback_arg);   /* ... using the 'callback_arg' provided in call    */
//  657                       } else {
//  658                           *perr = OS_ERR_TMR_NO_CALLBACK;
//  659                       }
//  660                       break;
//  661 
//  662                  case OS_TMR_OPT_NONE:
//  663                       break;
//  664 
//  665                  default:
//  666                      *perr = OS_ERR_TMR_INVALID_OPT;
//  667                      break;
//  668              }
//  669              OSTmr_Unlock();
//  670              return (OS_TRUE);
//  671 
//  672         case OS_TMR_STATE_COMPLETED:                              /* Timer has already completed the ONE-SHOT or ...  */
//  673         case OS_TMR_STATE_STOPPED:                                /* ... timer has not started yet.                   */
//  674              OSTmr_Unlock();
//  675              *perr = OS_ERR_TMR_STOPPED;
//  676              return (OS_TRUE);
//  677 
//  678         case OS_TMR_STATE_UNUSED:                                 /* Timer was not created                            */
//  679              OSTmr_Unlock();
//  680              *perr = OS_ERR_TMR_INACTIVE;
//  681              return (OS_FALSE);
//  682 
//  683         default:
//  684              OSTmr_Unlock();
//  685              *perr = OS_ERR_TMR_INVALID_STATE;
//  686              return (OS_FALSE);
//  687     }
//  688 }
//  689 #endif
//  690 
//  691 /*$PAGE*/
//  692 /*
//  693 ************************************************************************************************************************
//  694 *                                      SIGNAL THAT IT'S TIME TO UPDATE THE TIMERS
//  695 *
//  696 * Description: This function is typically called by the ISR that occurs at the timer tick rate and is used to signal to
//  697 *              OSTmr_Task() that it's time to update the timers.
//  698 *
//  699 * Arguments  : none
//  700 *
//  701 * Returns    : OS_ERR_NONE         The call was successful and the timer task was signaled.
//  702 *              OS_ERR_SEM_OVF      If OSTmrSignal() was called more often than OSTmr_Task() can handle the timers.  
//  703 *                                  This would indicate that your system is heavily loaded.
//  704 *              OS_ERR_EVENT_TYPE   Unlikely you would get this error because the semaphore used for signaling is created 
//  705 *                                  by uC/OS-II.
//  706 *              OS_ERR_PEVENT_NULL  Again, unlikely you would ever get this error because the semaphore used for signaling 
//  707 *                                  is created by uC/OS-II.
//  708 ************************************************************************************************************************
//  709 */
//  710 
//  711 #if OS_TMR_EN > 0
//  712 INT8U  OSTmrSignal (void)
//  713 {
//  714     INT8U  err;
//  715 
//  716 
//  717     err = OSSemPost(OSTmrSemSignal);
//  718     return (err);
//  719 }
//  720 #endif
//  721 
//  722 /*$PAGE*/
//  723 /*
//  724 ************************************************************************************************************************
//  725 *                                               ALLOCATE AND FREE A TIMER
//  726 *
//  727 * Description: This function is called to allocate a timer.
//  728 *
//  729 * Arguments  : none
//  730 *
//  731 * Returns    : a pointer to a timer if one is available
//  732 ************************************************************************************************************************
//  733 */
//  734 
//  735 #if OS_TMR_EN > 0
//  736 static  OS_TMR  *OSTmr_Alloc (void)
//  737 {
//  738     OS_TMR *ptmr;
//  739 
//  740 
//  741     if (OSTmrFreeList == (OS_TMR *)0) {
//  742         return ((OS_TMR *)0);
//  743     }
//  744     ptmr            = (OS_TMR *)OSTmrFreeList;
//  745     OSTmrFreeList   = (OS_TMR *)ptmr->OSTmrNext;
//  746     ptmr->OSTmrNext = (OS_TCB *)0;
//  747     ptmr->OSTmrPrev = (OS_TCB *)0;
//  748     OSTmrUsed++;
//  749     OSTmrFree--;
//  750     return (ptmr);
//  751 }
//  752 #endif
//  753 
//  754 
//  755 /*
//  756 ************************************************************************************************************************
//  757 *                                             RETURN A TIMER TO THE FREE LIST
//  758 *
//  759 * Description: This function is called to return a timer object to the free list of timers.
//  760 *
//  761 * Arguments  : ptmr     is a pointer to the timer to free
//  762 *
//  763 * Returns    : none
//  764 ************************************************************************************************************************
//  765 */
//  766 
//  767 #if OS_TMR_EN > 0
//  768 static  void  OSTmr_Free (OS_TMR *ptmr)
//  769 {
//  770     ptmr->OSTmrState       = OS_TMR_STATE_UNUSED;      /* Clear timer object fields                                   */
//  771     ptmr->OSTmrOpt         = OS_TMR_OPT_NONE;
//  772     ptmr->OSTmrPeriod      = 0;
//  773     ptmr->OSTmrMatch       = 0;
//  774     ptmr->OSTmrCallback    = (OS_TMR_CALLBACK)0;
//  775     ptmr->OSTmrCallbackArg = (void *)0;
//  776 #if OS_TMR_CFG_NAME_SIZE > 1
//  777     ptmr->OSTmrName[0]     = '?';                      /* Unknown name                                                */
//  778     ptmr->OSTmrName[1]     = OS_ASCII_NUL;
//  779 #endif
//  780 
//  781     ptmr->OSTmrPrev        = (OS_TCB *)0;              /* Chain timer to free list                                    */
//  782     ptmr->OSTmrNext        = OSTmrFreeList;
//  783     OSTmrFreeList          = ptmr;
//  784 
//  785     OSTmrUsed--;                                       /* Update timer object statistics                              */
//  786     OSTmrFree++;
//  787 }
//  788 #endif
//  789 
//  790 /*$PAGE*/
//  791 /*
//  792 ************************************************************************************************************************
//  793 *                                                    INITIALIZATION
//  794 *                                          INITIALIZE THE FREE LIST OF TIMERS
//  795 *
//  796 * Description: This function is called by OSInit() to initialize the free list of OS_TMRs.
//  797 *
//  798 * Arguments  : none
//  799 *
//  800 * Returns    : none
//  801 ************************************************************************************************************************
//  802 */
//  803 
//  804 #if OS_TMR_EN > 0
//  805 void  OSTmr_Init (void)
//  806 {
//  807 #if OS_EVENT_NAME_SIZE > 10
//  808     INT8U    err;
//  809 #endif
//  810     INT16U   i;
//  811     OS_TMR  *ptmr1;
//  812     OS_TMR  *ptmr2;
//  813 
//  814 
//  815     OS_MemClr((INT8U *)&OSTmrTbl[0],      sizeof(OSTmrTbl));            /* Clear all the TMRs                         */
//  816     OS_MemClr((INT8U *)&OSTmrWheelTbl[0], sizeof(OSTmrWheelTbl));       /* Clear the timer wheel                      */
//  817 
//  818     ptmr1 = &OSTmrTbl[0];
//  819     ptmr2 = &OSTmrTbl[1];
//  820     for (i = 0; i < (OS_TMR_CFG_MAX - 1); i++) {                        /* Init. list of free TMRs                    */
//  821         ptmr1->OSTmrType    = OS_TMR_TYPE;
//  822         ptmr1->OSTmrState   = OS_TMR_STATE_UNUSED;                      /* Indicate that timer is inactive            */
//  823         ptmr1->OSTmrNext    = (void *)ptmr2;                            /* Link to next timer                         */
//  824 #if OS_TMR_CFG_NAME_SIZE > 1
//  825         ptmr1->OSTmrName[0] = '?';                                      /* Unknown name                               */
//  826         ptmr1->OSTmrName[1] = OS_ASCII_NUL;
//  827 #endif
//  828         ptmr1++;
//  829         ptmr2++;
//  830     }
//  831     ptmr1->OSTmrType    = OS_TMR_TYPE;
//  832     ptmr1->OSTmrState   = OS_TMR_STATE_UNUSED;                          /* Indicate that timer is inactive            */
//  833     ptmr1->OSTmrNext    = (void *)0;                                    /* Last OS_TMR                                */
//  834 #if OS_TMR_CFG_NAME_SIZE > 1
//  835     ptmr1->OSTmrName[0] = '?';                                          /* Unknown name                               */
//  836     ptmr1->OSTmrName[1] = OS_ASCII_NUL;
//  837 #endif
//  838     OSTmrTime           = 0;
//  839     OSTmrUsed           = 0;
//  840     OSTmrFree           = OS_TMR_CFG_MAX;
//  841     OSTmrFreeList       = &OSTmrTbl[0];
//  842     OSTmrSem            = OSSemCreate(1);
//  843     OSTmrSemSignal      = OSSemCreate(0);
//  844 
//  845 #if OS_EVENT_NAME_SIZE > 18
//  846     OSEventNameSet(OSTmrSem,       (INT8U *)"uC/OS-II TmrLock",   &err);/* Assign names to semaphores                 */
//  847 #else
//  848 #if OS_EVENT_NAME_SIZE > 10
//  849     OSEventNameSet(OSTmrSem,       (INT8U *)"OS-TmrLock",         &err);
//  850 #endif
//  851 #endif
//  852 
//  853 #if OS_EVENT_NAME_SIZE > 18
//  854     OSEventNameSet(OSTmrSemSignal, (INT8U *)"uC/OS-II TmrSignal", &err);
//  855 #else
//  856 #if OS_EVENT_NAME_SIZE > 10
//  857     OSEventNameSet(OSTmrSemSignal, (INT8U *)"OS-TmrSig",          &err);
//  858 #endif
//  859 #endif
//  860 
//  861     OSTmr_InitTask();
//  862 }
//  863 #endif
//  864 
//  865 /*$PAGE*/
//  866 /*
//  867 ************************************************************************************************************************
//  868 *                                          INITIALIZE THE TIMER MANAGEMENT TASK
//  869 *
//  870 * Description: This function is called by OSTmrInit() to create the timer management task.
//  871 *
//  872 * Arguments  : none
//  873 *
//  874 * Returns    : none
//  875 ************************************************************************************************************************
//  876 */
//  877 
//  878 #if OS_TMR_EN > 0
//  879 static  void  OSTmr_InitTask (void)
//  880 {
//  881 #if OS_TASK_NAME_SIZE > 6
//  882     INT8U  err;
//  883 #endif
//  884 
//  885 
//  886 #if OS_TASK_CREATE_EXT_EN > 0
//  887     #if OS_STK_GROWTH == 1
//  888     (void)OSTaskCreateExt(OSTmr_Task,
//  889                           (void *)0,                                       /* No arguments passed to OSTmrTask()      */
//  890                           &OSTmrTaskStk[OS_TASK_TMR_STK_SIZE - 1],         /* Set Top-Of-Stack                        */
//  891                           OS_TASK_TMR_PRIO,
//  892                           OS_TASK_TMR_ID,
//  893                           &OSTmrTaskStk[0],                                /* Set Bottom-Of-Stack                     */
//  894                           OS_TASK_TMR_STK_SIZE,
//  895                           (void *)0,                                       /* No TCB extension                        */
//  896                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);      /* Enable stack checking + clear stack     */
//  897     #else
//  898     (void)OSTaskCreateExt(OSTmr_Task,
//  899                           (void *)0,                                       /* No arguments passed to OSTmrTask()      */
//  900                           &OSTmrTaskStk[0],                                /* Set Top-Of-Stack                        */
//  901                           OS_TASK_TMR_PRIO,
//  902                           OS_TASK_TMR_ID,
//  903                           &OSTmrTaskStk[OS_TASK_TMR_STK_SIZE - 1],         /* Set Bottom-Of-Stack                     */
//  904                           OS_TASK_TMR_STK_SIZE,
//  905                           (void *)0,                                       /* No TCB extension                        */
//  906                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);      /* Enable stack checking + clear stack     */
//  907     #endif
//  908 #else
//  909     #if OS_STK_GROWTH == 1
//  910     (void)OSTaskCreate(OSTmr_Task,
//  911                        (void *)0,
//  912                        &OSTmrTaskStk[OS_TASK_TMR_STK_SIZE - 1],
//  913                        OS_TASK_TMR_PRIO);
//  914     #else
//  915     (void)OSTaskCreate(OSTmr_Task,
//  916                        (void *)0,
//  917                        &OSTmrTaskStk[0],
//  918                        OS_TASK_TMR_PRIO);
//  919     #endif
//  920 #endif
//  921 
//  922 #if OS_TASK_NAME_SIZE > 12
//  923     OSTaskNameSet(OS_TASK_TMR_PRIO, (INT8U *)"uC/OS-II Tmr", &err);
//  924 #else
//  925 #if OS_TASK_NAME_SIZE > 6
//  926     OSTaskNameSet(OS_TASK_TMR_PRIO, (INT8U *)"OS-Tmr", &err);
//  927 #endif
//  928 #endif
//  929 }
//  930 #endif
//  931 
//  932 /*$PAGE*/
//  933 /*
//  934 ************************************************************************************************************************
//  935 *                                         INSERT A TIMER INTO THE TIMER WHEEL
//  936 *
//  937 * Description: This function is called to insert the timer into the timer wheel.  The timer is always inserted at the
//  938 *              beginning of the list.
//  939 *
//  940 * Arguments  : ptmr          Is a pointer to the timer to insert.
//  941 *
//  942 *              type          Is either:
//  943 *                               OS_TMR_LINK_PERIODIC    Means to re-insert the timer after a period expired
//  944 *                               OS_TMR_LINK_DLY         Means to insert    the timer the first time
//  945 *
//  946 * Returns    : none
//  947 ************************************************************************************************************************
//  948 */
//  949 
//  950 #if OS_TMR_EN > 0
//  951 static  void  OSTmr_Link (OS_TMR *ptmr, INT8U type)
//  952 {
//  953     OS_TMR       *ptmr1;
//  954     OS_TMR_WHEEL *pspoke;
//  955     INT16U        spoke;
//  956 
//  957 
//  958     ptmr->OSTmrState = OS_TMR_STATE_RUNNING;
//  959     if (type == OS_TMR_LINK_PERIODIC) {                            /* Determine when timer will expire                */
//  960         ptmr->OSTmrMatch = ptmr->OSTmrPeriod + OSTmrTime;
//  961     } else {
//  962         if (ptmr->OSTmrDly == 0) {
//  963             ptmr->OSTmrMatch = ptmr->OSTmrPeriod + OSTmrTime;
//  964         } else {
//  965             ptmr->OSTmrMatch = ptmr->OSTmrDly    + OSTmrTime;
//  966         }
//  967     }
//  968     spoke  = (INT16U)(ptmr->OSTmrMatch % OS_TMR_CFG_WHEEL_SIZE);
//  969     pspoke = &OSTmrWheelTbl[spoke];
//  970 
//  971     if (pspoke->OSTmrFirst == (OS_TMR *)0) {                       /* Link into timer wheel                           */
//  972         pspoke->OSTmrFirst   = ptmr;
//  973         ptmr->OSTmrNext      = (OS_TMR *)0;
//  974         pspoke->OSTmrEntries = 1;
//  975     } else {
//  976         ptmr1                = pspoke->OSTmrFirst;                 /* Point to first timer in the spoke               */
//  977         pspoke->OSTmrFirst   = ptmr;
//  978         ptmr->OSTmrNext      = (void *)ptmr1;
//  979         ptmr1->OSTmrPrev     = (void *)ptmr;
//  980         pspoke->OSTmrEntries++;
//  981     }
//  982     ptmr->OSTmrPrev = (void *)0;                                   /* Timer always inserted as first node in list     */
//  983 }
//  984 #endif
//  985 
//  986 /*$PAGE*/
//  987 /*
//  988 ************************************************************************************************************************
//  989 *                                         REMOVE A TIMER FROM THE TIMER WHEEL
//  990 *
//  991 * Description: This function is called to remove the timer from the timer wheel.
//  992 *
//  993 * Arguments  : ptmr          Is a pointer to the timer to remove.
//  994 *
//  995 * Returns    : none
//  996 ************************************************************************************************************************
//  997 */
//  998 
//  999 #if OS_TMR_EN > 0
// 1000 static  void  OSTmr_Unlink (OS_TMR *ptmr)
// 1001 {
// 1002     OS_TMR        *ptmr1;
// 1003     OS_TMR        *ptmr2;
// 1004     OS_TMR_WHEEL  *pspoke;
// 1005     INT16U         spoke;
// 1006 
// 1007 
// 1008     spoke  = (INT16U)(ptmr->OSTmrMatch % OS_TMR_CFG_WHEEL_SIZE);
// 1009     pspoke = &OSTmrWheelTbl[spoke];
// 1010 
// 1011     if (pspoke->OSTmrFirst == ptmr) {                       /* See if timer to remove is at the beginning of list     */
// 1012         ptmr1              = (OS_TMR *)ptmr->OSTmrNext;
// 1013         pspoke->OSTmrFirst = (void *)ptmr1;
// 1014         if (ptmr1 != (OS_TMR *)0) {
// 1015             ptmr1->OSTmrPrev = (void *)0;
// 1016         }
// 1017     } else {
// 1018         ptmr1            = (OS_TMR *)ptmr->OSTmrPrev;       /* Remove timer from somewhere in the list                */
// 1019         ptmr2            = (OS_TMR *)ptmr->OSTmrNext;
// 1020         ptmr1->OSTmrNext = ptmr2;
// 1021         if (ptmr2 != (OS_TMR *)0) {
// 1022             ptmr2->OSTmrPrev = (void *)ptmr1;
// 1023         }
// 1024     }
// 1025     ptmr->OSTmrState = OS_TMR_STATE_STOPPED;
// 1026     ptmr->OSTmrNext  = (void *)0;
// 1027     ptmr->OSTmrPrev  = (void *)0;
// 1028     pspoke->OSTmrEntries--;
// 1029 }
// 1030 #endif
// 1031 
// 1032 /*$PAGE*/
// 1033 /*
// 1034 ************************************************************************************************************************
// 1035 *                                       TIMER MANAGER DATA STRUCTURE LOCKING MECHANISM
// 1036 *
// 1037 * Description: These functions are used to gain exclusive access to timer management data structures.
// 1038 *
// 1039 * Arguments  : none
// 1040 *
// 1041 * Returns    : none
// 1042 ************************************************************************************************************************
// 1043 */
// 1044 
// 1045 #if OS_TMR_EN > 0
// 1046 static  void  OSTmr_Lock (void)
// 1047 {
// 1048     INT8U  err;
// 1049 
// 1050 
// 1051     OSSemPend(OSTmrSem, 0, &err);
// 1052     (void)err;
// 1053 }
// 1054 #endif
// 1055 
// 1056 
// 1057 
// 1058 #if OS_TMR_EN > 0
// 1059 static  void  OSTmr_Unlock (void)
// 1060 {
// 1061     (void)OSSemPost(OSTmrSem);
// 1062 }
// 1063 #endif
// 1064 
// 1065 /*$PAGE*/
// 1066 /*
// 1067 ************************************************************************************************************************
// 1068 *                                                 TIMER MANAGEMENT TASK
// 1069 *
// 1070 * Description: This task is created by OSTmrInit().
// 1071 *
// 1072 * Arguments  : none
// 1073 *
// 1074 * Returns    : none
// 1075 ************************************************************************************************************************
// 1076 */
// 1077 
// 1078 #if OS_TMR_EN > 0
// 1079 static  void  OSTmr_Task (void *p_arg)
// 1080 {
// 1081     INT8U            err;
// 1082     OS_TMR          *ptmr;
// 1083     OS_TMR          *ptmr_next;
// 1084     OS_TMR_CALLBACK  pfnct;
// 1085     OS_TMR_WHEEL    *pspoke;
// 1086     INT16U           spoke;
// 1087 
// 1088 
// 1089     (void)p_arg;                                                 /* Not using 'p_arg', prevent compiler warning       */
// 1090     for (;;) {
// 1091         OSSemPend(OSTmrSemSignal, 0, &err);                      /* Wait for signal indicating time to update timers  */
// 1092         OSTmr_Lock();
// 1093         OSTmrTime++;                                             /* Increment the current time                        */
// 1094         spoke  = (INT16U)(OSTmrTime % OS_TMR_CFG_WHEEL_SIZE);    /* Position on current timer wheel entry             */
// 1095         pspoke = &OSTmrWheelTbl[spoke];
// 1096         ptmr   = pspoke->OSTmrFirst;
// 1097         while (ptmr != (OS_TMR *)0) {
// 1098             ptmr_next = (OS_TMR *)ptmr->OSTmrNext;               /* Point to next timer to update because current ... */
// 1099                                                                  /* ... timer could get unlinked from the wheel.      */
// 1100             if (OSTmrTime == ptmr->OSTmrMatch) {                 /* Process each timer that expires                   */
// 1101                 pfnct = ptmr->OSTmrCallback;                     /* Execute callback function if available            */
// 1102                 if (pfnct != (OS_TMR_CALLBACK)0) {
// 1103                     (*pfnct)((void *)ptmr, ptmr->OSTmrCallbackArg);
// 1104                 }
// 1105                 OSTmr_Unlink(ptmr);                              /* Remove from current wheel spoke                   */
// 1106                 if (ptmr->OSTmrOpt == OS_TMR_OPT_PERIODIC) {
// 1107                     OSTmr_Link(ptmr, OS_TMR_LINK_PERIODIC);      /* Recalculate new position of timer in wheel        */
// 1108                 } else {
// 1109                     ptmr->OSTmrState = OS_TMR_STATE_COMPLETED;   /* Indicate that the timer has completed             */
// 1110                 }
// 1111             }
// 1112             ptmr = ptmr_next;
// 1113         }
// 1114         OSTmr_Unlock();
// 1115     }
// 1116 }
// 1117 #endif
// 
// 
// 0 bytes of memory
//
//Errors: none
//Warnings: none
