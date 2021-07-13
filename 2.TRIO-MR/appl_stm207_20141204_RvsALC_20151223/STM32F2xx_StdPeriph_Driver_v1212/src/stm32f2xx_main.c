/*
*********************************************************************************************************
*                                              EXAMPLE CODE
*
*                          (c) Copyright 2003-2007; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*               Knowledge of the source code may NOT be used to develop a similar product.
*               Please help us continue to provide the Embedded community with the finest
*               software available.  Your honesty is greatly appreciated.
*********************************************************************************************************
*/
#define __STM32F10x_EXT_MAIN

#include "stm32f2xx_1212.h"


/*******************************************************************************
*                                                main()
*
* Description : This is the standard entry point for C code.  It is assumed that your code will call
*               main() once you have performed all necessary initialization.
*
* Arguments   : none
*
* Returns     : none
********************************************************************************/
void __RESETPRIMASK(void);

int  main (void)
{
//    CPU_IntDis();	// Disable all interrupts until we are ready to accept them
#ifndef OS_INCLUDED
	mainTask(NULL);
#else	
    OSInit();			// Initialize "uC/OS-II, The Real-Time Kernel"
	OSTaskCreate(mainTask, (void *)NULL, (OS_STK *)&MainTaskStk[OS_TASK_STK_SIZE - 1], MAIN_START_PRIO);
    OSStart();			// Start multitasking (i.e. give control to uC/OS-II)
#endif	/* OS_INCLUDED */

}

/*
*********************************************************************************************************
*                                   APPLICATION-DEFINED HOOKS
*
* Description: These functions are called by the hooks in os_cpu_c.c.
*
* Returns    : none
*********************************************************************************************************
*/
#if defined(OS_INCLUDED)


#if (OS_APP_HOOKS_EN > 0)
void  App_TaskCreateHook (OS_TCB *ptcb)
{
#if (uC_PROBE_OS_PLUGIN > 0) && (OS_PROBE_HOOKS_EN > 0)
    OSProbe_TaskCreateHook(ptcb);
#endif
}


void  App_TaskDelHook (OS_TCB *ptcb)
{
    (void)ptcb;
}

#if OS_VERSION >= 251
void  App_TaskIdleHook (void)
{
}
#endif


void  App_TaskStatHook (void)
{
}


#if OS_TASK_SW_HOOK_EN > 0
void  App_TaskSwHook (void)
{
#if (uC_PROBE_OS_PLUGIN > 0) && (OS_PROBE_HOOKS_EN > 0)
    OSProbe_TaskSwHook();
#endif
}
#endif


#if OS_VERSION >= 204
void  App_TCBInitHook (OS_TCB *ptcb)
{
    (void)ptcb;
}
#endif


#if OS_TIME_TICK_HOOK_EN > 0
void  App_TimeTickHook (void)
{
#if (uC_PROBE_OS_PLUGIN > 0) && (OS_PROBE_HOOKS_EN > 0)
    OSProbe_TickHook();
#endif
}
#endif
#endif

#endif /* OS_INCLUDED */

////////////////////////////////////////////////////////////////////////////////
// End of Sourece File

