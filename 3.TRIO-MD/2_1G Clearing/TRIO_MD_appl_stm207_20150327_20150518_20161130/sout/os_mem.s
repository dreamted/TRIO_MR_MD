///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:38 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_mem.c                                          /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\S /
//                    ource\os_mem.c -D OS_INCLUDED -D APPL_SRC -lcN          /
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
//                    em.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME os_mem

        #define SHT_PROGBITS 0x1

        EXTERN OSIntNesting
        EXTERN OSMemFreeList
        EXTERN OSMemTbl
        EXTERN OS_CPU_SR_Restore
        EXTERN OS_CPU_SR_Save
        EXTERN OS_MemClr
        EXTERN OS_StrCopy
        EXTERN OS_StrLen

        PUBLIC OSMemCreate
        PUBLIC OSMemGet
        PUBLIC OSMemNameGet
        PUBLIC OSMemNameSet
        PUBLIC OSMemPut
        PUBLIC OSMemQuery
        PUBLIC OS_MemInit

// C:\user\project\stm32\fw\stm207_ucos_20120825\uCOS-II\Source\os_mem.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                                uC/OS-II
//    4 *                                          The Real-Time Kernel
//    5 *                                            MEMORY MANAGEMENT
//    6 *
//    7 *                          (c) Copyright 1992-2007, Jean J. Labrosse, Weston, FL
//    8 *                                           All Rights Reserved
//    9 *
//   10 * File    : OS_MEM.C
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
//   29 #if (OS_MEM_EN > 0) && (OS_MAX_MEM_PART > 0)
//   30 /*
//   31 *********************************************************************************************************
//   32 *                                        CREATE A MEMORY PARTITION
//   33 *
//   34 * Description : Create a fixed-sized memory partition that will be managed by uC/OS-II.
//   35 *
//   36 * Arguments   : addr     is the starting address of the memory partition
//   37 *
//   38 *               nblks    is the number of memory blocks to create from the partition.
//   39 *
//   40 *               blksize  is the size (in bytes) of each block in the memory partition.
//   41 *
//   42 *               perr     is a pointer to a variable containing an error message which will be set by
//   43 *                        this function to either:
//   44 *
//   45 *                        OS_ERR_NONE              if the memory partition has been created correctly.
//   46 *                        OS_ERR_MEM_INVALID_ADDR  if you are specifying an invalid address for the memory
//   47 *                                                 storage of the partition or, the block does not align
//   48 *                                                 on a pointer boundary
//   49 *                        OS_ERR_MEM_INVALID_PART  no free partitions available
//   50 *                        OS_ERR_MEM_INVALID_BLKS  user specified an invalid number of blocks (must be >= 2)
//   51 *                        OS_ERR_MEM_INVALID_SIZE  user specified an invalid block size
//   52 *                                                   - must be greater than the size of a pointer
//   53 *                                                   - must be able to hold an integral number of pointers
//   54 * Returns    : != (OS_MEM *)0  is the partition was created
//   55 *              == (OS_MEM *)0  if the partition was not created because of invalid arguments or, no
//   56 *                              free partition is available.
//   57 *********************************************************************************************************
//   58 */
//   59 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 OS_MEM  *OSMemCreate (void *addr, INT32U nblks, INT32U blksize, INT8U *perr)
//   61 {
OSMemCreate:
        PUSH     {R4-R8,LR}
        MOV      R4,R0
        MOV      R5,R1
        MOV      R6,R2
        MOV      R8,R3
//   62     OS_MEM    *pmem;
//   63     INT8U     *pblk;
//   64     void     **plink;
//   65     INT32U     i;
//   66 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//   67     OS_CPU_SR  cpu_sr = 0;
//   68 #endif
//   69 
//   70 
//   71 
//   72 #if OS_ARG_CHK_EN > 0              
//   73     if (perr == (INT8U *)0) {                         /* Validate 'perr'                               */
//   74         return ((OS_MEM *)0);
//   75     }
//   76     if (addr == (void *)0) {                          /* Must pass a valid address for the memory part.*/
//   77         *perr = OS_ERR_MEM_INVALID_ADDR;
//   78         return ((OS_MEM *)0);
//   79     }
//   80     if (((INT32U)addr & (sizeof(void *) - 1)) != 0){  /* Must be pointer size aligned                  */
//   81         *perr = OS_ERR_MEM_INVALID_ADDR;
//   82         return ((OS_MEM *)0);
//   83     }
//   84     if (nblks < 2) {                                  /* Must have at least 2 blocks per partition     */
//   85         *perr = OS_ERR_MEM_INVALID_BLKS;
//   86         return ((OS_MEM *)0);
//   87     }
//   88     if (blksize < sizeof(void *)) {                   /* Must contain space for at least a pointer     */
//   89         *perr = OS_ERR_MEM_INVALID_SIZE;
//   90         return ((OS_MEM *)0);
//   91     }
//   92 #endif
//   93     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//   94     pmem = OSMemFreeList;                             /* Get next free memory partition                */
        LDR.N    R1,??DataTable3
        LDR      R2,[R1, #+0]
        MOV      R7,R2
//   95     if (OSMemFreeList != (OS_MEM *)0) {               /* See if pool of free partitions was empty      */
        CBZ.N    R2,??OSMemCreate_0
//   96         OSMemFreeList = (OS_MEM *)OSMemFreeList->OSMemFreeList;
        LDR      R2,[R2, #+4]
        STR      R2,[R1, #+0]
//   97     }
//   98     OS_EXIT_CRITICAL();
??OSMemCreate_0:
        BL       OS_CPU_SR_Restore
//   99     if (pmem == (OS_MEM *)0) {                        /* See if we have a memory partition             */
        CBNZ.N   R7,??OSMemCreate_1
//  100         *perr = OS_ERR_MEM_INVALID_PART;
        MOVS     R0,#+90
        STRB     R0,[R8, #+0]
//  101         return ((OS_MEM *)0);
        MOVS     R0,#+0
        B.N      ??OSMemCreate_2
//  102     }
//  103     plink = (void **)addr;                            /* Create linked list of free memory blocks      */
??OSMemCreate_1:
        MOV      R0,R4
//  104     pblk  = (INT8U *)((INT32U)addr + blksize);
        ADDS     R1,R6,R4
//  105     for (i = 0; i < (nblks - 1); i++) {
        SUBS     R2,R5,#+1
        BEQ.N    ??OSMemCreate_3
//  106        *plink = (void *)pblk;                         /* Save pointer to NEXT block in CURRENT block   */
??OSMemCreate_4:
        STR      R1,[R0, #+0]
//  107         plink = (void **)pblk;                        /* Position to  NEXT      block                  */
        MOV      R0,R1
//  108         pblk  = (INT8U *)((INT32U)pblk + blksize);    /* Point to the FOLLOWING block                  */
        ADDS     R1,R6,R1
//  109     }
        SUBS     R2,R2,#+1
        BNE.N    ??OSMemCreate_4
//  110     *plink              = (void *)0;                  /* Last memory block points to NULL              */
??OSMemCreate_3:
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  111     pmem->OSMemAddr     = addr;                       /* Store start address of memory partition       */
        STR      R4,[R7, #+0]
//  112     pmem->OSMemFreeList = addr;                       /* Initialize pointer to pool of free blocks     */
        STR      R4,[R7, #+4]
//  113     pmem->OSMemNFree    = nblks;                      /* Store number of free blocks in MCB            */
        STR      R5,[R7, #+16]
//  114     pmem->OSMemNBlks    = nblks;
        STR      R5,[R7, #+12]
//  115     pmem->OSMemBlkSize  = blksize;                    /* Store block size of each memory blocks        */
        STR      R6,[R7, #+8]
//  116     *perr               = OS_ERR_NONE;
        STRB     R1,[R8, #+0]
//  117     return (pmem);
        MOV      R0,R7
??OSMemCreate_2:
        POP      {R4-R8,PC}       ;; return
//  118 }
//  119 /*$PAGE*/
//  120 /*
//  121 *********************************************************************************************************
//  122 *                                          GET A MEMORY BLOCK
//  123 *
//  124 * Description : Get a memory block from a partition
//  125 *
//  126 * Arguments   : pmem    is a pointer to the memory partition control block
//  127 *
//  128 *               perr    is a pointer to a variable containing an error message which will be set by this
//  129 *                       function to either:
//  130 *
//  131 *                       OS_ERR_NONE             if the memory partition has been created correctly.
//  132 *                       OS_ERR_MEM_NO_FREE_BLKS if there are no more free memory blocks to allocate to caller
//  133 *                       OS_ERR_MEM_INVALID_PMEM if you passed a NULL pointer for 'pmem'
//  134 *
//  135 * Returns     : A pointer to a memory block if no error is detected
//  136 *               A pointer to NULL if an error is detected
//  137 *********************************************************************************************************
//  138 */
//  139 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  140 void  *OSMemGet (OS_MEM *pmem, INT8U *perr)
//  141 {
OSMemGet:
        PUSH     {R4-R6,LR}
        MOV      R4,R0
        MOV      R5,R1
//  142     void      *pblk;
//  143 #if OS_CRITICAL_METHOD == 3                           /* Allocate storage for CPU status register      */
//  144     OS_CPU_SR  cpu_sr = 0;
//  145 #endif
//  146 
//  147 
//  148 
//  149 #if OS_ARG_CHK_EN > 0
//  150     if (perr == (INT8U *)0) {                         /* Validate 'perr'                               */
//  151         return ((void *)0);
//  152     }
//  153     if (pmem == (OS_MEM *)0) {                        /* Must point to a valid memory partition        */
//  154         *perr = OS_ERR_MEM_INVALID_PMEM;
//  155         return ((void *)0);
//  156     }
//  157 #endif
//  158     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  159     if (pmem->OSMemNFree > 0) {                       /* See if there are any free memory blocks       */
        LDR      R1,[R4, #+16]
        CBZ.N    R1,??OSMemGet_0
//  160         pblk                = pmem->OSMemFreeList;    /* Yes, point to next free memory block          */
        LDR      R6,[R4, #+4]
//  161         pmem->OSMemFreeList = *(void **)pblk;         /*      Adjust pointer to new free list          */
        LDR      R2,[R6, #+0]
        STR      R2,[R4, #+4]
//  162         pmem->OSMemNFree--;                           /*      One less memory block in this partition  */
        SUBS     R1,R1,#+1
        STR      R1,[R4, #+16]
//  163         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  164         *perr = OS_ERR_NONE;                          /*      No error                                 */
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
//  165         return (pblk);                                /*      Return memory block to caller            */
        MOV      R0,R6
        POP      {R4-R6,PC}
//  166     }
//  167     OS_EXIT_CRITICAL();
??OSMemGet_0:
        BL       OS_CPU_SR_Restore
//  168     *perr = OS_ERR_MEM_NO_FREE_BLKS;                  /* No,  Notify caller of empty memory partition  */
        MOVS     R0,#+93
        STRB     R0,[R5, #+0]
//  169     return ((void *)0);                               /*      Return NULL pointer to caller            */
        MOVS     R0,#+0
        POP      {R4-R6,PC}       ;; return
//  170 }
//  171 /*$PAGE*/
//  172 /*
//  173 *********************************************************************************************************
//  174 *                                   GET THE NAME OF A MEMORY PARTITION
//  175 *
//  176 * Description: This function is used to obtain the name assigned to a memory partition.
//  177 *
//  178 * Arguments  : pmem      is a pointer to the memory partition
//  179 *
//  180 *              pname     is a pointer to an ASCII string that will receive the name of the memory partition.
//  181 *
//  182 *              perr      is a pointer to an error code that can contain one of the following values:
//  183 *
//  184 *                        OS_ERR_NONE                if the name was copied to 'pname'
//  185 *                        OS_ERR_MEM_INVALID_PMEM    if you passed a NULL pointer for 'pmem'
//  186 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  187 *                        OS_ERR_NAME_GET_ISR        You called this function from an ISR
//  188 *
//  189 * Returns    : The length of the string or 0 if 'pmem' is a NULL pointer.
//  190 *********************************************************************************************************
//  191 */
//  192 
//  193 #if OS_MEM_NAME_SIZE > 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  194 INT8U  OSMemNameGet (OS_MEM *pmem, INT8U *pname, INT8U *perr)
//  195 {
OSMemNameGet:
        PUSH     {R3-R7,LR}
        MOV      R5,R0
        MOV      R6,R1
        MOV      R4,R2
//  196     INT8U      len;
//  197 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  198     OS_CPU_SR  cpu_sr = 0;
//  199 #endif
//  200 
//  201 
//  202 
//  203 #if OS_ARG_CHK_EN > 0
//  204     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//  205         return (0);
//  206     }
//  207     if (pmem == (OS_MEM *)0) {                   /* Is 'pmem' a NULL pointer?                          */
//  208         *perr = OS_ERR_MEM_INVALID_PMEM;
//  209         return (0);
//  210     }
//  211     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
//  212         *perr = OS_ERR_PNAME_NULL;
//  213         return (0);
//  214     }
//  215 #endif
//  216     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
        LDR.N    R0,??DataTable3_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??OSMemNameGet_0
//  217         *perr = OS_ERR_NAME_GET_ISR;
        MOVS     R0,#+17
        STRB     R0,[R4, #+0]
//  218         return (0);
        MOVS     R0,#+0
        POP      {R1,R4-R7,PC}
//  219     }
//  220     OS_ENTER_CRITICAL();
??OSMemNameGet_0:
        BL       OS_CPU_SR_Save
        MOV      R7,R0
//  221     len   = OS_StrCopy(pname, pmem->OSMemName);  /* Copy name from OS_MEM                              */
        ADD      R1,R5,#+20
        MOV      R0,R6
        BL       OS_StrCopy
        MOV      R5,R0
//  222     OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  223     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  224     return (len);
        MOV      R0,R5
        POP      {R1,R4-R7,PC}    ;; return
//  225 }
//  226 #endif
//  227 
//  228 /*$PAGE*/
//  229 /*
//  230 *********************************************************************************************************
//  231 *                                 ASSIGN A NAME TO A MEMORY PARTITION
//  232 *
//  233 * Description: This function assigns a name to a memory partition.
//  234 *
//  235 * Arguments  : pmem      is a pointer to the memory partition
//  236 *
//  237 *              pname     is a pointer to an ASCII string that contains the name of the memory partition.
//  238 *
//  239 *              perr      is a pointer to an error code that can contain one of the following values:
//  240 *
//  241 *                        OS_ERR_NONE                if the name was copied to 'pname'
//  242 *                        OS_ERR_MEM_INVALID_PMEM    if you passed a NULL pointer for 'pmem'
//  243 *                        OS_ERR_PNAME_NULL          You passed a NULL pointer for 'pname'
//  244 *                        OS_ERR_MEM_NAME_TOO_LONG   if the name doesn't fit in the storage area
//  245 *                        OS_ERR_NAME_SET_ISR        if you called this function from an ISR
//  246 *
//  247 * Returns    : None
//  248 *********************************************************************************************************
//  249 */
//  250 
//  251 #if OS_MEM_NAME_SIZE > 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  252 void  OSMemNameSet (OS_MEM *pmem, INT8U *pname, INT8U *perr)
//  253 {
OSMemNameSet:
        PUSH     {R3-R7,LR}
        MOV      R5,R0
        MOV      R6,R1
        MOV      R4,R2
//  254     INT8U      len;
//  255 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  256     OS_CPU_SR  cpu_sr = 0;
//  257 #endif
//  258 
//  259 
//  260 
//  261 #if OS_ARG_CHK_EN > 0
//  262     if (perr == (INT8U *)0) {                    /* Validate 'perr'                                    */
//  263         return;
//  264     }
//  265     if (pmem == (OS_MEM *)0) {                   /* Is 'pmem' a NULL pointer?                          */
//  266         *perr = OS_ERR_MEM_INVALID_PMEM;
//  267         return;
//  268     }
//  269     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
//  270         *perr = OS_ERR_PNAME_NULL;
//  271         return;
//  272     }
//  273 #endif
//  274     if (OSIntNesting > 0) {                      /* See if trying to call from an ISR                  */
        LDR.N    R0,??DataTable3_1
        LDRB     R0,[R0, #+0]
        CBZ.N    R0,??OSMemNameSet_0
//  275         *perr = OS_ERR_NAME_SET_ISR;
        MOVS     R0,#+18
        B.N      ??OSMemNameSet_1
//  276         return;
//  277     }
//  278     OS_ENTER_CRITICAL();
??OSMemNameSet_0:
        BL       OS_CPU_SR_Save
        MOV      R7,R0
//  279     len = OS_StrLen(pname);                      /* Can we fit the string in the storage area?         */
//  280     if (len > (OS_MEM_NAME_SIZE - 1)) {          /* No                                                 */
        MOV      R0,R6
        BL       OS_StrLen
        CMP      R0,#+16
        BCC.N    ??OSMemNameSet_2
//  281         OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  282         *perr = OS_ERR_MEM_NAME_TOO_LONG;
        MOVS     R0,#+99
        B.N      ??OSMemNameSet_1
//  283         return;
//  284     }
//  285     (void)OS_StrCopy(pmem->OSMemName, pname);    /* Yes, copy name to the memory partition header      */
??OSMemNameSet_2:
        MOV      R1,R6
        ADD      R0,R5,#+20
        BL       OS_StrCopy
//  286     OS_EXIT_CRITICAL();
        MOV      R0,R7
        BL       OS_CPU_SR_Restore
//  287     *perr = OS_ERR_NONE;
        MOVS     R0,#+0
??OSMemNameSet_1:
        STRB     R0,[R4, #+0]
//  288 }
        POP      {R0,R4-R7,PC}    ;; return
//  289 #endif
//  290 
//  291 /*$PAGE*/
//  292 /*
//  293 *********************************************************************************************************
//  294 *                                         RELEASE A MEMORY BLOCK
//  295 *
//  296 * Description : Returns a memory block to a partition
//  297 *
//  298 * Arguments   : pmem    is a pointer to the memory partition control block
//  299 *
//  300 *               pblk    is a pointer to the memory block being released.
//  301 *
//  302 * Returns     : OS_ERR_NONE              if the memory block was inserted into the partition
//  303 *               OS_ERR_MEM_FULL          if you are returning a memory block to an already FULL memory
//  304 *                                        partition (You freed more blocks than you allocated!)
//  305 *               OS_ERR_MEM_INVALID_PMEM  if you passed a NULL pointer for 'pmem'
//  306 *               OS_ERR_MEM_INVALID_PBLK  if you passed a NULL pointer for the block to release.
//  307 *********************************************************************************************************
//  308 */
//  309 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  310 INT8U  OSMemPut (OS_MEM *pmem, void *pblk)
//  311 {
OSMemPut:
        PUSH     {R3-R5,LR}
        MOV      R4,R0
        MOV      R5,R1
//  312 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  313     OS_CPU_SR  cpu_sr = 0;
//  314 #endif
//  315 
//  316 
//  317 
//  318 #if OS_ARG_CHK_EN > 0
//  319     if (pmem == (OS_MEM *)0) {                   /* Must point to a valid memory partition             */
//  320         return (OS_ERR_MEM_INVALID_PMEM);
//  321     }
//  322     if (pblk == (void *)0) {                     /* Must release a valid block                         */
//  323         return (OS_ERR_MEM_INVALID_PBLK);
//  324     }
//  325 #endif
//  326     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  327     if (pmem->OSMemNFree >= pmem->OSMemNBlks) {  /* Make sure all blocks not already returned          */
        LDR      R1,[R4, #+16]
        LDR      R2,[R4, #+12]
        CMP      R1,R2
        BCC.N    ??OSMemPut_0
//  328         OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  329         return (OS_ERR_MEM_FULL);
        MOVS     R0,#+94
        POP      {R1,R4,R5,PC}
//  330     }
//  331     *(void **)pblk      = pmem->OSMemFreeList;   /* Insert released block into free block list         */
??OSMemPut_0:
        LDR      R2,[R4, #+4]
        STR      R2,[R5, #+0]
//  332     pmem->OSMemFreeList = pblk;
        STR      R5,[R4, #+4]
//  333     pmem->OSMemNFree++;                          /* One more memory block in this partition            */
        ADDS     R1,R1,#+1
        STR      R1,[R4, #+16]
//  334     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  335     return (OS_ERR_NONE);                        /* Notify caller that memory block was released       */
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  336 }
//  337 /*$PAGE*/
//  338 /*
//  339 *********************************************************************************************************
//  340 *                                          QUERY MEMORY PARTITION
//  341 *
//  342 * Description : This function is used to determine the number of free memory blocks and the number of
//  343 *               used memory blocks from a memory partition.
//  344 *
//  345 * Arguments   : pmem        is a pointer to the memory partition control block
//  346 *
//  347 *               p_mem_data  is a pointer to a structure that will contain information about the memory
//  348 *                           partition.
//  349 *
//  350 * Returns     : OS_ERR_NONE               if no errors were found.
//  351 *               OS_ERR_MEM_INVALID_PMEM   if you passed a NULL pointer for 'pmem'
//  352 *               OS_ERR_MEM_INVALID_PDATA  if you passed a NULL pointer to the data recipient.
//  353 *********************************************************************************************************
//  354 */
//  355 
//  356 #if OS_MEM_QUERY_EN > 0

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  357 INT8U  OSMemQuery (OS_MEM *pmem, OS_MEM_DATA *p_mem_data)
//  358 {
OSMemQuery:
        PUSH     {R3-R5,LR}
        MOV      R5,R0
        MOV      R4,R1
//  359 #if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
//  360     OS_CPU_SR  cpu_sr = 0;
//  361 #endif
//  362 
//  363 
//  364 
//  365 #if OS_ARG_CHK_EN > 0
//  366     if (pmem == (OS_MEM *)0) {                   /* Must point to a valid memory partition             */
//  367         return (OS_ERR_MEM_INVALID_PMEM);
//  368     }
//  369     if (p_mem_data == (OS_MEM_DATA *)0) {        /* Must release a valid storage area for the data     */
//  370         return (OS_ERR_MEM_INVALID_PDATA);
//  371     }
//  372 #endif
//  373     OS_ENTER_CRITICAL();
        BL       OS_CPU_SR_Save
//  374     p_mem_data->OSAddr     = pmem->OSMemAddr;
        LDR      R1,[R5, #+0]
        STR      R1,[R4, #+0]
//  375     p_mem_data->OSFreeList = pmem->OSMemFreeList;
        LDR      R1,[R5, #+4]
        STR      R1,[R4, #+4]
//  376     p_mem_data->OSBlkSize  = pmem->OSMemBlkSize;
        LDR      R1,[R5, #+8]
        STR      R1,[R4, #+8]
//  377     p_mem_data->OSNBlks    = pmem->OSMemNBlks;
        LDR      R1,[R5, #+12]
        STR      R1,[R4, #+12]
//  378     p_mem_data->OSNFree    = pmem->OSMemNFree;
        LDR      R1,[R5, #+16]
        STR      R1,[R4, #+16]
//  379     OS_EXIT_CRITICAL();
        BL       OS_CPU_SR_Restore
//  380     p_mem_data->OSNUsed    = p_mem_data->OSNBlks - p_mem_data->OSNFree;
        LDR      R0,[R4, #+12]
        LDR      R1,[R4, #+16]
        SUBS     R0,R0,R1
        STR      R0,[R4, #+20]
//  381     return (OS_ERR_NONE);
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  382 }
//  383 #endif                                           /* OS_MEM_QUERY_EN                                    */
//  384 /*$PAGE*/
//  385 /*
//  386 *********************************************************************************************************
//  387 *                                    INITIALIZE MEMORY PARTITION MANAGER
//  388 *
//  389 * Description : This function is called by uC/OS-II to initialize the memory partition manager.  Your
//  390 *               application MUST NOT call this function.
//  391 *
//  392 * Arguments   : none
//  393 *
//  394 * Returns     : none
//  395 *
//  396 * Note(s)    : This function is INTERNAL to uC/OS-II and your application should not call it.
//  397 *********************************************************************************************************
//  398 */
//  399 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  400 void  OS_MemInit (void)
//  401 {
OS_MemInit:
        PUSH     {R4,LR}
//  402 #if OS_MAX_MEM_PART == 1
//  403     OS_MemClr((INT8U *)&OSMemTbl[0], sizeof(OSMemTbl));   /* Clear the memory partition table          */
//  404     OSMemFreeList               = (OS_MEM *)&OSMemTbl[0]; /* Point to beginning of free list           */
//  405 #if OS_MEM_NAME_SIZE > 1
//  406     OSMemFreeList->OSMemName[0] = '?';                    /* Unknown name                              */
//  407     OSMemFreeList->OSMemName[1] = OS_ASCII_NUL;
//  408 #endif
//  409 #endif
//  410 
//  411 #if OS_MAX_MEM_PART >= 2
//  412     OS_MEM  *pmem;
//  413     INT16U   i;
//  414 
//  415 
//  416     OS_MemClr((INT8U *)&OSMemTbl[0], sizeof(OSMemTbl));   /* Clear the memory partition table          */
        LDR.N    R4,??DataTable3_2
        MOVS     R1,#+180
        MOV      R0,R4
        BL       OS_MemClr
//  417     pmem = &OSMemTbl[0];                                  /* Point to memory control block (MCB)       */
        MOV      R0,R4
//  418     for (i = 0; i < (OS_MAX_MEM_PART - 1); i++) {         /* Init. list of free memory partitions      */
        ADDW     R1,R4,#+36
        MOVS     R2,#+4
//  419         pmem->OSMemFreeList = (void *)&OSMemTbl[i+1];     /* Chain list of free partitions             */
??OS_MemInit_0:
        STR      R1,[R0, #+4]
//  420 #if OS_MEM_NAME_SIZE > 1
//  421         pmem->OSMemName[0]  = '?';                        /* Unknown name                              */
        MOVS     R3,#+63
        STRB     R3,[R0, #+20]
//  422         pmem->OSMemName[1]  = OS_ASCII_NUL;
        MOVS     R3,#+0
        STRB     R3,[R0, #+21]
//  423 #endif
//  424         pmem++;
        ADDW     R0,R0,#+36
//  425     }
        ADDW     R1,R1,#+36
        SUBS     R2,R2,#+1
        BNE.N    ??OS_MemInit_0
//  426     pmem->OSMemFreeList = (void *)0;                      /* Initialize last node                      */
        STR      R3,[R0, #+4]
//  427 #if OS_MEM_NAME_SIZE > 1
//  428     pmem->OSMemName[0]  = '?';                            /* Unknown name                              */
        MOVS     R1,#+63
        STRB     R1,[R0, #+20]
//  429     pmem->OSMemName[1]  = OS_ASCII_NUL;
        STRB     R3,[R0, #+21]
//  430 #endif
//  431 
//  432     OSMemFreeList       = &OSMemTbl[0];                   /* Point to beginning of free list           */
        LDR.N    R0,??DataTable3
        STR      R4,[R0, #+0]
//  433 #endif
//  434 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     OSMemFreeList

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     OSIntNesting

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     OSMemTbl

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  435 #endif                                                    /* OS_MEM_EN                                 */
// 
// 414 bytes in section .text
// 
// 414 bytes of CODE memory
//
//Errors: none
//Warnings: none
