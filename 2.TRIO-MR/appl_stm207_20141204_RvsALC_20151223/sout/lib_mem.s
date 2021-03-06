///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.21.1.52794/W32 for ARM    26/Aug/2012  04:04:40 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\user\project\stm32\fw\stm207_ucos_20120825\uC-LIB\li /
//                    b_mem.c                                                 /
//    Command line =  C:\user\project\stm32\fw\stm207_ucos_20120825\uC-LIB\li /
//                    b_mem.c -D OS_INCLUDED -D APPL_SRC -lcN                 /
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
//    List file    =  C:\user\project\stm32\fw\stm207_ucos_20120825\sout\lib_ /
//                    mem.s                                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME lib_mem

        #define SHT_PROGBITS 0x1

        PUBLIC Mem_Clr
        PUBLIC Mem_Cmp
        PUBLIC Mem_Copy
        PUBLIC Mem_Set

// C:\user\project\stm32\fw\stm207_ucos_20120825\uC-LIB\lib_mem.c
//    1 /*
//    2 *********************************************************************************************************
//    3 *                                               uC/LIB
//    4 *                                       CUSTOM LIBRARY MODULES
//    5 *
//    6 *                          (c) Copyright 2004-2007; Micrium, Inc.; Weston, FL
//    7 *
//    8 *               All rights reserved.  Protected by international copyright laws.
//    9 *
//   10 *               uC/LIB is provided in source form for FREE evaluation, for educational
//   11 *               use or peaceful research.  If you plan on using uC/LIB in a commercial
//   12 *               product you need to contact Micrium to properly license its use in your
//   13 *               product.  We provide ALL the source code for your convenience and to
//   14 *               help you experience uC/LIB.  The fact that the source code is provided
//   15 *               does NOT mean that you can use it without paying a licensing fee.
//   16 *
//   17 *               Knowledge of the source code may NOT be used to develop a similar product.
//   18 *
//   19 *               Please help us continue to provide the Embedded community with the finest
//   20 *               software available.  Your honesty is greatly appreciated.
//   21 *********************************************************************************************************
//   22 */
//   23 
//   24 /*
//   25 *********************************************************************************************************
//   26 *
//   27 *                                     STANDARD MEMORY OPERATIONS
//   28 *
//   29 * Filename      : lib_mem.c
//   30 * Version       : V1.24
//   31 * Programmer(s) : ITJ
//   32 *********************************************************************************************************
//   33 * Note(s)       : (1) NO compiler-supplied standard library functions are used in library or product software.
//   34 *
//   35 *                     (a) ALL standard library functions are implemented in the custom library modules :
//   36 *
//   37 *                         (1) \<Custom Library Directory>\lib*.*
//   38 *
//   39 *                         (2) \<Custom Library Directory>\Ports\<cpu>\<compiler>\lib*_a.*
//   40 *
//   41 *                               where
//   42 *                                       <Custom Library Directory>      directory path for custom library software
//   43 *                                       <cpu>                           directory name for specific processor (CPU)
//   44 *                                       <compiler>                      directory name for specific compiler
//   45 *
//   46 *                     (b) Product-specific library functions are implemented in individual products.
//   47 *********************************************************************************************************
//   48 */
//   49 
//   50 
//   51 /*
//   52 *********************************************************************************************************
//   53 *                                            INCLUDE FILES
//   54 *********************************************************************************************************
//   55 */
//   56 
//   57 #define    LIB_MEM_MODULE
//   58 #include  <lib_mem.h>
//   59 
//   60 
//   61 /*$PAGE*/
//   62 /*
//   63 *********************************************************************************************************
//   64 *                                            LOCAL DEFINES
//   65 *********************************************************************************************************
//   66 */
//   67 
//   68 
//   69 /*
//   70 *********************************************************************************************************
//   71 *                                           LOCAL CONSTANTS
//   72 *********************************************************************************************************
//   73 */
//   74 
//   75 
//   76 /*
//   77 *********************************************************************************************************
//   78 *                                          LOCAL DATA TYPES
//   79 *********************************************************************************************************
//   80 */
//   81 
//   82 
//   83 /*
//   84 *********************************************************************************************************
//   85 *                                            LOCAL TABLES
//   86 *********************************************************************************************************
//   87 */
//   88 
//   89 
//   90 /*
//   91 *********************************************************************************************************
//   92 *                                       LOCAL GLOBAL VARIABLES
//   93 *********************************************************************************************************
//   94 */
//   95 
//   96 
//   97 /*
//   98 *********************************************************************************************************
//   99 *                                      LOCAL FUNCTION PROTOTYPES
//  100 *********************************************************************************************************
//  101 */
//  102 
//  103 
//  104 /*
//  105 *********************************************************************************************************
//  106 *                                     LOCAL CONFIGURATION ERRORS
//  107 *********************************************************************************************************
//  108 */
//  109 
//  110 
//  111 /*$PAGE*/
//  112 /*
//  113 *********************************************************************************************************
//  114 *                                              Mem_Clr()
//  115 *
//  116 * Description : Clear data buffer (see Note #2).
//  117 *
//  118 * Argument(s) : pmem        Pointer to memory buffer to clear.
//  119 *
//  120 *               size        Number of data buffer octets to clear.
//  121 *
//  122 * Return(s)   : none.
//  123 *
//  124 * Caller(s)   : various.
//  125 *
//  126 * Note(s)     : (1) Null clears allowed (i.e. 0-octet size).
//  127 *
//  128 *                   See also 'Mem_Set()  Note #1'.
//  129 *
//  130 *               (2) Clear data by setting each data octet to 0.
//  131 *********************************************************************************************************
//  132 */
//  133 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 void  Mem_Clr (void        *pmem,
//  135                CPU_SIZE_T   size)
//  136 {
//  137     Mem_Set((void     *)pmem,
//  138             (CPU_INT08U)0,                                      /* See Note #2.                                         */
//  139             (CPU_SIZE_T)size);
Mem_Clr:
        MOV      R2,R1
        MOVS     R1,#+0
        REQUIRE Mem_Set
        ;; // Fall through to label Mem_Set
//  140 }
//  141 
//  142 
//  143 /*$PAGE*/
//  144 /*
//  145 *********************************************************************************************************
//  146 *                                              Mem_Set()
//  147 *
//  148 * Description : Fill data buffer with specified data octet.
//  149 *
//  150 * Argument(s) : pmem        Pointer to memory buffer to fill with specified data octet.
//  151 *
//  152 *               data_val    Data fill octet value.
//  153 *
//  154 *               size        Number of data buffer octets to fill.
//  155 *
//  156 * Return(s)   : none.
//  157 *
//  158 * Caller(s)   : various.
//  159 *
//  160 * Note(s)     : (1) Null sets allowed (i.e. 0-octet size).
//  161 *
//  162 *               (2) For best CPU performance, optimized to fill data buffer using 'CPU_ALIGN'-sized data words.
//  163 *
//  164 *                   (a) Since many word-aligned processors REQUIRE that multi-octet words be accessed on 
//  165 *                       word-aligned addresses, 'CPU_ALIGN'd words MUST be accessed on 'CPU_ALIGN'd addresses.
//  166 *
//  167 *               (3) Modulo arithmetic is used to determine whether a memory buffer starts on a 'CPU_ALIGN'
//  168 *                   address boundary.
//  169 *
//  170 *                   Modulo arithmetic in ANSI-C REQUIREs operations performed on integer values.  Thus, 
//  171 *                   address values MUST be cast to an appropriately-sized integer value PRIOR to any
//  172 *                   mem_align_modulo arithmetic operation.
//  173 *********************************************************************************************************
//  174 */
//  175 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  176 void  Mem_Set (void        *pmem,
//  177                CPU_INT08U   data_val,
//  178                CPU_SIZE_T   size)
//  179 {
//  180     CPU_SIZE_T   size_rem;
//  181     CPU_ALIGN    data_align;
//  182     CPU_ALIGN   *pmem_align;
//  183     CPU_INT08U  *pmem_08;
//  184     CPU_INT08U   mem_align_modulo;
//  185     CPU_INT08U   i;
//  186 
//  187 
//  188     if (size < 1) {                                             /* See Note #1.                                         */
Mem_Set:
        CBZ.N    R2,??Mem_Set_0
//  189         return;
//  190     }
//  191     if (pmem == (void *)0) {
        CBZ.N    R0,??Mem_Set_0
//  192         return;
//  193     }
//  194 
//  195 
//  196     data_align = 0;
//  197     for (i = 0; i < sizeof(CPU_ALIGN); i++) {                   /* Fill each data_align octet with data val.            */
//  198         data_align <<=  DEF_OCTET_NBR_BITS;
//  199         data_align  |= (CPU_ALIGN)data_val;
        ORR      R3,R1,R1, LSL #+8
        ORR      R3,R1,R3, LSL #+8
        ORR      R3,R1,R3, LSL #+8
//  200     }
//  201 
//  202     size_rem         = (CPU_SIZE_T)size;
//  203     mem_align_modulo = (CPU_INT08U)((CPU_ADDR)pmem % sizeof(CPU_ALIGN));    /* See Note #3.                             */
        ANDS     R12,R0,#0x3
//  204 
//  205     pmem_08 = (CPU_INT08U *)pmem;
//  206     if (mem_align_modulo != 0) {                                /* If leading octets avail,                   ...       */
        BEQ.N    ??Mem_Set_1
//  207         i = mem_align_modulo;
//  208         while ((size_rem > 0) &&                                /* ... start mem buf fill with leading octets ...       */
//  209                (i        < sizeof(CPU_ALIGN ))) {               /* ... until next CPU_ALIGN word boundary.              */
//  210            *pmem_08++ = data_val;
??Mem_Set_2:
        STRB     R1,[R0], #+1
//  211             size_rem -= sizeof(CPU_INT08U);
        SUBS     R2,R2,#+1
//  212             i++;
        ADD      R12,R12,#+1
//  213         }
        BEQ.N    ??Mem_Set_1
        UXTB     R12,R12
        CMP      R12,#+4
        BCC.N    ??Mem_Set_2
//  214     }
//  215 
//  216     pmem_align = (CPU_ALIGN *)pmem_08;                          /* See Note #2a.                                        */
??Mem_Set_1:
        CMP      R2,#+4
        BCC.N    ??Mem_Set_3
//  217     while (size_rem >= sizeof(CPU_ALIGN)) {                     /* While mem buf aligned on CPU_ALIGN word boundaries,  */
//  218        *pmem_align++ = data_align;                              /* ... fill mem buf with    CPU_ALIGN-sized data.       */
??Mem_Set_4:
        STR      R3,[R0], #+4
//  219         size_rem    -= sizeof(CPU_ALIGN);
        SUBS     R2,R2,#+4
        CMP      R2,#+4
        BCS.N    ??Mem_Set_4
//  220     }
//  221 
//  222     pmem_08 = (CPU_INT08U *)pmem_align;
??Mem_Set_3:
        CBZ.N    R2,??Mem_Set_0
//  223     while (size_rem > 0) {                                      /* Finish mem buf fill with trailing octets.            */
//  224        *pmem_08++   = data_val;
??Mem_Set_5:
        STRB     R1,[R0], #+1
//  225         size_rem   -= sizeof(CPU_INT08U);
        SUBS     R2,R2,#+1
        BNE.N    ??Mem_Set_5
??Mem_Set_0:
        BX       LR               ;; return
//  226     }
//  227 }
//  228 
//  229 
//  230 /*$PAGE*/
//  231 /*
//  232 *********************************************************************************************************
//  233 *                                             Mem_Copy()
//  234 *
//  235 * Description : Copy data octets from one buffer to another buffer.
//  236 *
//  237 * Argument(s) : pdest       Pointer to destination memory buffer.
//  238 *
//  239 *               psrc        Pointer to source      memory buffer.
//  240 *
//  241 *               size        Number of data buffer octets to copy.
//  242 *
//  243 * Return(s)   : none.
//  244 *
//  245 * Caller(s)   : various.
//  246 *
//  247 * Note(s)     : (1) Null copies allowed (i.e. 0-octet size).
//  248 *
//  249 *               (2) Memory buffers NOT checked for overlapping.
//  250 *
//  251 *               (3) For best CPU performance, optimized to fill data buffer using 'CPU_ALIGN'-sized data words.
//  252 *
//  253 *                   (a) Since many word-aligned processors REQUIRE that multi-octet words be accessed on 
//  254 *                       word-aligned addresses, 'CPU_ALIGN'd words MUST be accessed on 'CPU_ALIGN'd addresses.
//  255 *
//  256 *               (4) Modulo arithmetic is used to determine whether a memory buffer starts on a 'CPU_ALIGN'
//  257 *                   address boundary.
//  258 *
//  259 *                   Modulo arithmetic in ANSI-C REQUIREs operations performed on integer values.  Thus, 
//  260 *                   address values MUST be cast to an appropriately-sized integer value PRIOR to any
//  261 *                   mem_align_modulo arithmetic operation.
//  262 *********************************************************************************************************
//  263 */
//  264 /*$PAGE*/
//  265 #if ((!defined(uC_CFG_OPTIMIZE_ASM_EN)) || \ 
//  266      ((defined(uC_CFG_OPTIMIZE_ASM_EN)) && \ 
//  267               (uC_CFG_OPTIMIZE_ASM_EN   != DEF_ENABLED)))

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  268 void  Mem_Copy (void        *pdest,
//  269                 void        *psrc,
//  270                 CPU_SIZE_T   size)
//  271 {
//  272     CPU_SIZE_T    size_rem;
//  273     CPU_ALIGN    *pmem_align_dest;
//  274     CPU_ALIGN    *pmem_align_src;
//  275     CPU_INT08U   *pmem_08_dest;
//  276     CPU_INT08U   *pmem_08_src;
//  277     CPU_INT08U    i;
//  278     CPU_INT08U    mem_align_modulo_dest;
//  279     CPU_INT08U    mem_align_modulo_src;
//  280     CPU_BOOLEAN   mem_aligned;
//  281 
//  282 
//  283     if (size < 1) {                                             /* See Note #1.                                         */
Mem_Copy:
        CBZ.N    R2,??Mem_Copy_0
//  284         return;
//  285     }
//  286     if (pdest == (void *)0) {
        CBZ.N    R0,??Mem_Copy_0
//  287         return;
//  288     }
//  289     if (psrc  == (void *)0) {
        CBZ.N    R1,??Mem_Copy_0
//  290         return;
//  291     }
//  292 
//  293 
//  294     size_rem              = (CPU_SIZE_T  )size;
//  295 
//  296     pmem_08_dest          = (CPU_INT08U *)pdest;
//  297     pmem_08_src           = (CPU_INT08U *)psrc;
//  298                                                                 /* See Note #4.                                         */
//  299     mem_align_modulo_dest = (CPU_INT08U  )((CPU_ADDR)pmem_08_dest % sizeof(CPU_ALIGN));
        AND      R3,R0,#0x3
//  300     mem_align_modulo_src  = (CPU_INT08U  )((CPU_ADDR)pmem_08_src  % sizeof(CPU_ALIGN));
//  301 
//  302     mem_aligned           = (mem_align_modulo_dest == mem_align_modulo_src) ? DEF_YES : DEF_NO;
        AND      R12,R1,#0x3
        CMP      R3,R12
        BNE.N    ??Mem_Copy_1
//  303 
//  304     if (mem_aligned == DEF_YES) {                               /* If mem bufs' alignment offset equal, ...             */
//  305                                                                 /* ... optimize copy for mem buf alignment.             */
//  306         if (mem_align_modulo_dest != 0) {                       /* If leading octets avail,                   ...       */
        CBZ.N    R3,??Mem_Copy_2
//  307             i = mem_align_modulo_dest;
//  308             while ((size_rem   >  0) &&                         /* ... start mem buf copy with leading octets ...       */
//  309                    (i          <  sizeof(CPU_ALIGN ))) {        /* ... until next CPU_ALIGN word boundary.              */
//  310                *pmem_08_dest++ = *pmem_08_src++;
??Mem_Copy_3:
        LDRB     R12,[R1], #+1
        STRB     R12,[R0], #+1
//  311                 size_rem      -=  sizeof(CPU_INT08U);
        SUBS     R2,R2,#+1
//  312                 i++;
        ADDS     R3,R3,#+1
//  313             }
        CBZ.N    R2,??Mem_Copy_2
        UXTB     R3,R3
        CMP      R3,#+4
        BCC.N    ??Mem_Copy_3
//  314         }
//  315 
//  316         pmem_align_dest = (CPU_ALIGN *)pmem_08_dest;            /* See Note #3a.                                        */
//  317         pmem_align_src  = (CPU_ALIGN *)pmem_08_src;
??Mem_Copy_2:
        CMP      R2,#+4
        BCC.N    ??Mem_Copy_4
//  318         while (size_rem      >=  sizeof(CPU_ALIGN)) {           /* While mem bufs aligned on CPU_ALIGN word boundaries, */
//  319            *pmem_align_dest++ = *pmem_align_src++;              /* ... copy psrc to pdest with CPU_ALIGN-sized words.   */
??Mem_Copy_5:
        LDR      R3,[R1], #+4
        STR      R3,[R0], #+4
//  320             size_rem         -=  sizeof(CPU_ALIGN);
        SUBS     R2,R2,#+4
        CMP      R2,#+4
        BCS.N    ??Mem_Copy_5
//  321         }
//  322 
//  323         pmem_08_dest = (CPU_INT08U *)pmem_align_dest;
//  324         pmem_08_src  = (CPU_INT08U *)pmem_align_src;
//  325     }
//  326 
//  327     while (size_rem > 0) {                                      /* For unaligned mem bufs or trailing octets, ...       */
??Mem_Copy_4:
        CBZ.N    R2,??Mem_Copy_0
//  328        *pmem_08_dest++ = *pmem_08_src++;                        /* ... copy psrc to pdest by octets.                    */
??Mem_Copy_1:
        LDRB     R3,[R1], #+1
        STRB     R3,[R0], #+1
//  329         size_rem      -=  sizeof(CPU_INT08U);
        SUBS     R2,R2,#+1
        BNE.N    ??Mem_Copy_1
??Mem_Copy_0:
        BX       LR               ;; return
//  330     }
//  331 }
//  332 #endif
//  333 
//  334 
//  335 /*$PAGE*/
//  336 /*
//  337 *********************************************************************************************************
//  338 *                                              Mem_Cmp()
//  339 *
//  340 * Description : Verify that ALL data octets in two memory buffers are identical in sequence.
//  341 *
//  342 * Argument(s) : p1_mem      Pointer to first  memory buffer.
//  343 *
//  344 *               p2_mem      Pointer to second memory buffer.
//  345 *
//  346 *               size        Number of data buffer octets to compare.
//  347 *
//  348 * Return(s)   : DEF_YES, if 'size' number of data octets are identical in both memory buffers.
//  349 *
//  350 *               DEF_NO,  otherwise.
//  351 *
//  352 * Caller(s)   : various.
//  353 *
//  354 * Note(s)     : (1) Null compares allowed (i.e. 0-octet size); 'DEF_YES' returned to indicate identical 
//  355 *                   null compare.
//  356 *
//  357 *               (2) Many memory buffer comparisons vary ONLY in the least significant octets -- e.g. 
//  358 *                   network address buffers.  Consequently, memory buffer comparison is more efficient 
//  359 *                   if the comparison starts from the end of the memory buffers which will abort sooner 
//  360 *                   on dissimilar memory buffers that vary only in the least significant octets.
//  361 *
//  362 *               (3) For best CPU performance, optimized to fill data buffer using 'CPU_ALIGN'-sized data words.
//  363 *
//  364 *                   (a) Since many word-aligned processors REQUIRE that multi-octet words be accessed on 
//  365 *                       word-aligned addresses, 'CPU_ALIGN'd words MUST be accessed on 'CPU_ALIGN'd addresses.
//  366 *
//  367 *               (4) Modulo arithmetic is used to determine whether a memory buffer starts on a 'CPU_ALIGN'
//  368 *                   address boundary.
//  369 *
//  370 *                   Modulo arithmetic in ANSI-C REQUIREs operations performed on integer values.  Thus, 
//  371 *                   address values MUST be cast to an appropriately-sized integer value PRIOR to any
//  372 *                   mem_align_modulo arithmetic operation.
//  373 ********************************************************************************************************
//  374 */
//  375 /*$PAGE*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  376 CPU_BOOLEAN  Mem_Cmp (void        *p1_mem,
//  377                       void        *p2_mem,
//  378                       CPU_SIZE_T   size)
//  379 {
Mem_Cmp:
        PUSH     {R4-R6}
//  380     CPU_SIZE_T    size_rem;
//  381     CPU_ALIGN    *p1_mem_align;
//  382     CPU_ALIGN    *p2_mem_align;
//  383     CPU_INT08U   *p1_mem_08;
//  384     CPU_INT08U   *p2_mem_08;
//  385     CPU_INT08U    i;
//  386     CPU_INT08U    mem_align_modulo_1;
//  387     CPU_INT08U    mem_align_modulo_2;
//  388     CPU_BOOLEAN   mem_aligned;
//  389     CPU_BOOLEAN   mem_cmp;
//  390 
//  391 
//  392     if (size < 1) {                                             /* See Note #1.                                         */
        CBNZ.N   R2,??Mem_Cmp_0
//  393         return (DEF_YES);
        MOVS     R0,#+1
        B.N      ??Mem_Cmp_1
//  394     }
//  395     if (p1_mem == (void *)0) {
??Mem_Cmp_0:
        CBNZ.N   R0,??Mem_Cmp_2
//  396         return (DEF_NO);
??Mem_Cmp_3:
        MOVS     R0,#+0
        B.N      ??Mem_Cmp_1
//  397     }
//  398     if (p2_mem == (void *)0) {
??Mem_Cmp_2:
        CMP      R1,#+0
        BEQ.N    ??Mem_Cmp_3
//  399         return (DEF_NO);
//  400     }
//  401 
//  402 
//  403     mem_cmp            =  DEF_YES;
        MOVS     R3,#+1
//  404     size_rem           =  size;
//  405                                                                 /* Start @ end of mem bufs (see Note #2).               */
//  406     p1_mem_08          = (CPU_INT08U *)p1_mem + size;
        ADDS     R0,R2,R0
//  407     p2_mem_08          = (CPU_INT08U *)p2_mem + size;
        ADDS     R1,R2,R1
//  408                                                                 /* See Note #4.                                         */
//  409     mem_align_modulo_1 = (CPU_INT08U  )((CPU_ADDR)p1_mem_08 % sizeof(CPU_ALIGN));
        AND      R4,R0,#0x3
//  410     mem_align_modulo_2 = (CPU_INT08U  )((CPU_ADDR)p2_mem_08 % sizeof(CPU_ALIGN));
//  411 
//  412     mem_aligned        = (mem_align_modulo_1 == mem_align_modulo_2) ? DEF_YES : DEF_NO;
        AND      R5,R1,#0x3
        CMP      R4,R5
        BNE.N    ??Mem_Cmp_4
//  413 
//  414     if (mem_aligned == DEF_YES) {                               /* If mem bufs' alignment offset equal, ...             */
//  415                                                                 /* ... optimize cmp for mem buf alignment.              */
//  416         if (mem_align_modulo_1 != 0) {                          /* If trailing octets avail,                  ...       */
        CBZ.N    R4,??Mem_Cmp_5
//  417             i = mem_align_modulo_1;
        B.N      ??Mem_Cmp_6
//  418             while ((mem_cmp == DEF_YES) &&                      /* ... cmp mem bufs while identical &         ...       */
//  419                    (size_rem > 0)       &&                      /* ... start mem buf cmp with trailing octets ...       */
//  420                    (i        > 0)) {                            /* ... until next CPU_ALIGN word boundary.              */
??Mem_Cmp_7:
        CMP      R2,#+0
        ITT      NE 
        UXTBNE   R4,R4
        CMPNE    R4,#+0
        BEQ.N    ??Mem_Cmp_5
//  421                 p1_mem_08--;
//  422                 p2_mem_08--;
//  423                 if (*p1_mem_08 != *p2_mem_08) {                 /* If ANY data octet(s) NOT identical, cmp fails.       */
??Mem_Cmp_6:
        LDRB     R5,[R0, #-1]!
        LDRB     R6,[R1, #-1]!
        CMP      R5,R6
        IT       NE 
        MOVNE    R3,#+0
//  424                      mem_cmp = DEF_NO;
//  425                 }
//  426                 size_rem -= sizeof(CPU_INT08U);
        SUBS     R2,R2,#+1
//  427                 i--;
        SUBS     R4,R4,#+1
//  428             }
        CMP      R3,#+0
        BNE.N    ??Mem_Cmp_7
//  429         }
//  430 
//  431         if (mem_cmp == DEF_YES) {                               /* If cmp still identical, cmp aligned mem bufs.        */
//  432             p1_mem_align = (CPU_ALIGN *)p1_mem_08;              /* See Note #3a.                                        */
//  433             p2_mem_align = (CPU_ALIGN *)p2_mem_08;
//  434 
//  435             while ((mem_cmp  == DEF_YES) &&                     /* Cmp mem bufs while identical & ...                   */
//  436                    (size_rem >= sizeof(CPU_ALIGN))) {           /* ... mem bufs aligned on CPU_ALIGN word boundaries.   */
//  437                 p1_mem_align--;
//  438                 p2_mem_align--;
//  439                 if (*p1_mem_align != *p2_mem_align) {           /* If ANY data octet(s) NOT identical, cmp fails.       */
//  440                      mem_cmp = DEF_NO;
//  441                 }
//  442                 size_rem -= sizeof(CPU_ALIGN);
//  443             }
//  444 
//  445             p1_mem_08 = (CPU_INT08U *)p1_mem_align;
//  446             p2_mem_08 = (CPU_INT08U *)p2_mem_align;
//  447         }
//  448     }
//  449 
//  450     while ((mem_cmp == DEF_YES) &&                              /* Cmp mem bufs while identical ...                     */
//  451            (size_rem > 0)) {                                    /* ... for unaligned mem bufs or trailing octets.       */
//  452         p1_mem_08--;
//  453         p2_mem_08--;
//  454         if (*p1_mem_08 != *p2_mem_08) {                         /* If ANY data octet(s) NOT identical, cmp fails.       */
//  455              mem_cmp = DEF_NO;
//  456         }
//  457         size_rem -= sizeof(CPU_INT08U);
//  458     }
//  459 
//  460     return (mem_cmp);
??Mem_Cmp_8:
        MOV      R0,R3
??Mem_Cmp_1:
        POP      {R4-R6}
        BX       LR               ;; return
??Mem_Cmp_9:
        LDR      R4,[R0, #-4]!
        LDR      R5,[R1, #-4]!
        CMP      R4,R5
        IT       NE 
        MOVNE    R3,#+0
        SUBS     R2,R2,#+4
??Mem_Cmp_5:
        CBZ.N    R3,??Mem_Cmp_10
        CMP      R2,#+4
        BCS.N    ??Mem_Cmp_9
??Mem_Cmp_10:
        CMP      R3,#+0
        BEQ.N    ??Mem_Cmp_8
        CMP      R2,#+0
        BEQ.N    ??Mem_Cmp_8
??Mem_Cmp_4:
        LDRB     R4,[R0, #-1]!
        LDRB     R5,[R1, #-1]!
        CMP      R4,R5
        IT       NE 
        MOVNE    R3,#+0
        SUBS     R2,R2,#+1
        B.N      ??Mem_Cmp_10
//  461 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  462 
// 
// 274 bytes in section .text
// 
// 274 bytes of CODE memory
//
//Errors: none
//Warnings: none
