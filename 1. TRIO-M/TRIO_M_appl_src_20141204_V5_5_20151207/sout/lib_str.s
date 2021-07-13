///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V5.30.2.51295/W32 for ARM    09/Jan/2012  08:12:41 /
// Copyright 1999-2009 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uC-LIB\lib /
//                    _str.c                                                  /
//    Command line =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uC-LIB\lib /
//                    _str.c -D _MIMO_Type -lcN D:\Project\TRIO\3.F_W\TRIO_ap /
//                    pl_src_20120106\sout\ -lB D:\Project\TRIO\3.F_W\TRIO_ap /
//                    pl_src_20120106\sout\ -o D:\Project\TRIO\3.F_W\TRIO_app /
//                    l_src_20120106\sout\ --endian=little --cpu=Cortex-M3    /
//                    -e --require_prototypes --warnings_are_errors           /
//                    --fpu=None --dlib_config "C:\Program Files\IAR          /
//                    Systems\Embedded Workbench                              /
//                    5.4\arm\INC\DLib_Config_Normal.h" -I                    /
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
//    List file    =  D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\sout\lib_s /
//                    tr.s                                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME lib_str

        PUBLIC Str_Cat
        PUBLIC Str_Cat_N
        PUBLIC Str_Char
        PUBLIC Str_Char_Last
        PUBLIC Str_Char_N
        PUBLIC Str_Cmp
        PUBLIC Str_Cmp_N
        PUBLIC Str_Copy
        PUBLIC Str_Copy_N
        PUBLIC Str_Len
        PUBLIC Str_Str

// D:\Project\TRIO\3.F_W\TRIO_appl_src_20120106\uC-LIB\lib_str.c
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
//   27 *                                       ASCII STRING MANAGEMENT
//   28 *
//   29 * Filename      : lib_str.c
//   30 * Version       : V1.24
//   31 * Programmer(s) : ITJ
//   32 *                 JDH
//   33 *********************************************************************************************************
//   34 * Note(s)       : (1) NO compiler-supplied standard library functions are used in library or product software.
//   35 *
//   36 *                     (a) ALL standard library functions are implemented in the custom library modules :
//   37 *
//   38 *                         (1) \<Custom Library Directory>\lib*.*
//   39 *
//   40 *                         (2) \<Custom Library Directory>\Ports\<cpu>\<compiler>\lib*_a.*
//   41 *
//   42 *                               where
//   43 *                                       <Custom Library Directory>      directory path for custom library software
//   44 *                                       <cpu>                           directory name for specific processor (CPU)
//   45 *                                       <compiler>                      directory name for specific compiler
//   46 *
//   47 *                     (b) Product-specific library functions are implemented in individual products.
//   48 *********************************************************************************************************
//   49 */
//   50 
//   51 
//   52 /*
//   53 *********************************************************************************************************
//   54 *                                            INCLUDE FILES
//   55 *********************************************************************************************************
//   56 */
//   57 
//   58 #define    LIB_STR_MODULE
//   59 #include  <lib_str.h>
//   60 
//   61 
//   62 /*$PAGE*/
//   63 /*
//   64 *********************************************************************************************************
//   65 *                                            LOCAL DEFINES
//   66 *********************************************************************************************************
//   67 */
//   68 
//   69 
//   70 /*
//   71 *********************************************************************************************************
//   72 *                                           LOCAL CONSTANTS
//   73 *********************************************************************************************************
//   74 */
//   75 
//   76 
//   77 /*
//   78 *********************************************************************************************************
//   79 *                                          LOCAL DATA TYPES
//   80 *********************************************************************************************************
//   81 */
//   82 
//   83 
//   84 /*
//   85 *********************************************************************************************************
//   86 *                                            LOCAL TABLES
//   87 *********************************************************************************************************
//   88 */
//   89 
//   90 
//   91 /*
//   92 *********************************************************************************************************
//   93 *                                       LOCAL GLOBAL VARIABLES
//   94 *********************************************************************************************************
//   95 */
//   96 
//   97 
//   98 /*
//   99 *********************************************************************************************************
//  100 *                                      LOCAL FUNCTION PROTOTYPES
//  101 *********************************************************************************************************
//  102 */
//  103 
//  104 
//  105 /*
//  106 *********************************************************************************************************
//  107 *                                     LOCAL CONFIGURATION ERRORS
//  108 *********************************************************************************************************
//  109 */
//  110 
//  111 
//  112 /*$PAGE*/
//  113 /*
//  114 *********************************************************************************************************
//  115 *                                              Str_Len()
//  116 *
//  117 * Description : Calculate length of a string.
//  118 *
//  119 * Argument(s) : pstr        Pointer to string (see Note #1).
//  120 *
//  121 * Return(s)   : Length of string; number of characters in string before terminating NULL character.
//  122 *
//  123 * Caller(s)   : various.
//  124 *
//  125 * Note(s)     : (1) String buffer NOT modified.
//  126 *
//  127 *               (2) String length calculation terminates when :
//  128 *
//  129 *                   (a) String pointer points to NULL.
//  130 *                       (1) String buffer overlaps with NULL address.
//  131 *                       (2) String length calculated for string up to but NOT beyond or including
//  132 *                           the NULL address.
//  133 *
//  134 *                   (b) Terminating NULL character found.
//  135 *                       (1) String length calculated for string up to but NOT           including
//  136 *                           the NULL character.
//  137 *********************************************************************************************************
//  138 */
//  139 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  140 CPU_SIZE_T  Str_Len (CPU_CHAR  *pstr)
//  141 {
Str_Len:
        MOV      R1,R0
//  142     CPU_SIZE_T  len;
//  143 
//  144 
//  145     len = 0;
        MOVS     R0,#+0
        B.N      ??Str_Len_0
//  146     while (( pstr != (CPU_CHAR *)0) &&                          /* Calc str len until NULL ptr (see Note #2a) ...       */
//  147            (*pstr != (CPU_CHAR  )0)) {                          /* ... or NULL char found      (see Note #2b).          */
//  148         len++;
??Str_Len_1:
        ADDS     R0,R0,#+1
//  149         pstr++;
//  150     }
??Str_Len_0:
        CBZ      R1,??Str_Len_2
        LDRB     R2,[R1], #+1
        CMP      R2,#+0
        BNE.N    ??Str_Len_1
//  151 
//  152     return (len);
??Str_Len_2:
        BX       LR               ;; return
//  153 }
//  154 
//  155 
//  156 /*$PAGE*/
//  157 /*
//  158 *********************************************************************************************************
//  159 *                                             Str_Copy()
//  160 *
//  161 * Description : Copy source string to destination string buffer.
//  162 *
//  163 * Argument(s) : pdest       Pointer to destination string buffer to receive source string copy (see Note #1).
//  164 *
//  165 *               psrc        Pointer to source      string to copy into destination string buffer.
//  166 *
//  167 * Return(s)   : Pointer to destination string, if NO errors (see Note #2).
//  168 *
//  169 *               Pointer to NULL,               otherwise.
//  170 *
//  171 * Caller(s)   : various.
//  172 *
//  173 * Note(s)     : (1) Destination buffer size NOT validated; buffer overruns MUST be prevented by caller.
//  174 *
//  175 *                   (a) Destination buffer size MUST be large enough to accommodate the entire source 
//  176 *                       string size including the terminating NULL character.
//  177 *
//  178 *               (2) String copy terminates when :
//  179 *
//  180 *                   (a) Destination/Source string pointer(s) are passed NULL pointers.
//  181 *                       (1) No string copy performed; NULL pointer returned.
//  182 *
//  183 *                   (b) Destination/Source string pointer(s) points to NULL.
//  184 *                       (1) String buffer(s) overlap with NULL address.
//  185 *                       (2) Source string copied into destination string buffer up to but NOT beyond or
//  186 *                           including the NULL address; destination string buffer properly terminated
//  187 *                           with NULL character.
//  188 *
//  189 *                   (c) Source string's terminating NULL character found.
//  190 *                       (1) Entire source string copied into destination string buffer.
//  191 *********************************************************************************************************
//  192 */
//  193 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  194 CPU_CHAR  *Str_Copy (CPU_CHAR  *pdest,
//  195                      CPU_CHAR  *psrc)
//  196 {
Str_Copy:
        PUSH     {R3,R4}
//  197     CPU_CHAR  *pstr;
//  198     CPU_CHAR  *pstr_next;
//  199 
//  200                                                                 /* Rtn NULL if str ptr(s) NULL (see Note #2a).          */
//  201     if (pdest == (CPU_CHAR *)0) {
        CMP      R0,#+0
        BNE.N    ??Str_Copy_0
//  202         return  ((CPU_CHAR *)0);
??Str_Copy_1:
        B.N      ?Subroutine2
//  203     }
//  204     if (psrc  == (CPU_CHAR *)0) {
??Str_Copy_0:
        CMP      R1,#+0
        BEQ.N    ??Str_Copy_1
//  205         return  ((CPU_CHAR *)0);
//  206     }
//  207 
//  208 
//  209     pstr      = pdest;
        MOV      R2,R0
//  210     pstr_next = pstr;
//  211     pstr_next++;
        B.N      ?Subroutine1
//  212     while (( pstr_next != (CPU_CHAR *)0) &&                     /* Copy str until NULL ptr(s) (see Note #2b) ...        */
//  213            ( psrc      != (CPU_CHAR *)0) &&
//  214            (*psrc      != (CPU_CHAR  )0)) {                     /* ... or NULL char found     (see Note #2c).           */
//  215        *pstr = *psrc;
//  216         pstr++;
//  217         pstr_next++;
//  218         psrc++;
//  219     }
//  220 
//  221    *pstr = (CPU_CHAR)0;                                         /* Append NULL char (see Note #2b2).                    */
//  222 
//  223 
//  224     return (pdest);
//  225 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine2:
        MOVS     R0,#+0
        POP      {R1,R4}
        BX       LR

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine1:
        ADDS     R3,R2,#+1
        B.N      ??Subroutine1_0
??Subroutine1_1:
        LDRB     R4,[R1], #+1
        STRB     R4,[R2], #+1
        ADDS     R3,R3,#+1
??Subroutine1_0:
        CMP      R3,#+0
        BEQ.N    ??Subroutine1_2
        CMP      R1,#+0
        BEQ.N    ??Subroutine1_2
        LDRB     R4,[R1, #+0]
        CMP      R4,#+0
        BNE.N    ??Subroutine1_1
??Subroutine1_2:
        MOVS     R1,#+0
        STRB     R1,[R2, #+0]
        POP      {R1,R4}
        BX       LR               ;; return
//  226 
//  227 
//  228 /*$PAGE*/
//  229 /*
//  230 *********************************************************************************************************
//  231 *                                            Str_Copy_N()
//  232 *
//  233 * Description : Copy source string to destination string buffer, up to a maximum number of characters.
//  234 *
//  235 * Argument(s) : pdest       Pointer to destination string buffer to receive source string copy (see Note #1).
//  236 *
//  237 *               psrc        Pointer to source      string to copy into destination string buffer.
//  238 *
//  239 *               len_max     Maximum number of characters to copy (see Note #2d).
//  240 *
//  241 * Return(s)   : Pointer to destination string, if NO errors (see Note #2).
//  242 *
//  243 *               Pointer to NULL,               otherwise.
//  244 *
//  245 * Caller(s)   : various.
//  246 *
//  247 * Note(s)     : (1) Destination buffer size NOT validated; buffer overruns MUST be prevented by caller.
//  248 *
//  249 *                   (a) Destination buffer size MUST be large enough to accommodate the entire source 
//  250 *                       string size including the terminating NULL character.
//  251 *
//  252 *               (2) String copy terminates when :
//  253 *
//  254 *                   (a) Destination/Source string pointer(s) are passed NULL pointers.
//  255 *                       (1) No string copy performed; NULL pointer returned.
//  256 *
//  257 *                   (b) Destination/Source string pointer(s) points to NULL.
//  258 *                       (1) String buffer(s) overlap with NULL address.
//  259 *                       (2) Source string copied into destination string buffer up to but NOT beyond or
//  260 *                           including the NULL address; destination string buffer properly terminated
//  261 *                           with NULL character.
//  262 *
//  263 *                   (c) Source string's terminating NULL character found.
//  264 *                       (1) Entire source string copied into destination string buffer.
//  265 *
//  266 *                   (d) 'len_max' number of characters copied.
//  267 *                       (1) 'len_max' number of characters does NOT include the terminating NULL character.
//  268 *
//  269 *                           See also Note #1a.
//  270 *********************************************************************************************************
//  271 */
//  272 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  273 CPU_CHAR  *Str_Copy_N (CPU_CHAR    *pdest,
//  274                        CPU_CHAR    *psrc,
//  275                        CPU_SIZE_T   len_max)
//  276 {
Str_Copy_N:
        PUSH     {R3-R6}
//  277     CPU_CHAR    *pstr;
//  278     CPU_CHAR    *pstr_next;
//  279     CPU_SIZE_T   len_copy;
//  280 
//  281                                                                 /* Rtn NULL if str ptr(s) NULL      (see Note #2a).     */
//  282     if (pdest == (CPU_CHAR *)0) {
        CMP      R0,#+0
        BNE.N    ??Str_Copy_N_0
//  283         return  ((CPU_CHAR *)0);
??Str_Copy_N_1:
        B.N      ?Subroutine3
//  284     }
//  285     if (psrc  == (CPU_CHAR *)0) {
??Str_Copy_N_0:
        CMP      R1,#+0
        BEQ.N    ??Str_Copy_N_1
//  286         return  ((CPU_CHAR *)0);
//  287     }
//  288 
//  289     if (len_max == (CPU_SIZE_T)0) {                             /* Rtn NULL if copy len equals zero (see Note #2d).     */
        CMP      R2,#+0
        BEQ.N    ??Str_Copy_N_1
//  290         return  ((CPU_CHAR *)0);
//  291     }
//  292 
//  293 
//  294     pstr      = pdest;
        MOV      R3,R0
//  295     pstr_next = pstr;
//  296     pstr_next++;
        B.N      ?Subroutine0
//  297     len_copy  = 0;
//  298 
//  299     while (( pstr_next != (CPU_CHAR *)0) &&                     /* Copy str until NULL ptr(s)  (see Note #2b)  ...      */
//  300            ( psrc      != (CPU_CHAR *)0) &&
//  301            (*psrc      != (CPU_CHAR  )0) &&                     /* ... or NULL char found      (see Note #2c); ...      */
//  302            ( len_copy  <  (CPU_SIZE_T)len_max)) {               /* ... or max nbr chars copied (see Note #2d).          */
//  303        *pstr = *psrc;
//  304         pstr++;
//  305         pstr_next++;
//  306         psrc++;
//  307         len_copy++;
//  308     }
//  309 
//  310    *pstr = (CPU_CHAR)0;                                         /* Append NULL char (see Note #2b2).                    */
//  311 
//  312 
//  313     return (pdest);
//  314 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine3:
        MOVS     R0,#+0
        POP      {R1,R4-R6}
        BX       LR

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
?Subroutine0:
        ADDS     R4,R3,#+1
        MOVS     R5,#+0
        B.N      ??Subroutine0_0
??Subroutine0_1:
        LDRB     R6,[R1], #+1
        STRB     R6,[R3], #+1
        ADDS     R4,R4,#+1
        ADDS     R5,R5,#+1
??Subroutine0_0:
        CMP      R4,#+0
        BEQ.N    ??Subroutine0_2
        CMP      R1,#+0
        BEQ.N    ??Subroutine0_2
        LDRB     R6,[R1, #+0]
        CMP      R6,#+0
        BEQ.N    ??Subroutine0_2
        CMP      R5,R2
        BCC.N    ??Subroutine0_1
??Subroutine0_2:
        MOVS     R1,#+0
        STRB     R1,[R3, #+0]
        POP      {R1,R4-R6}
        BX       LR               ;; return
//  315 
//  316 
//  317 /*$PAGE*/
//  318 /*
//  319 *********************************************************************************************************
//  320 *                                              Str_Cat()
//  321 *
//  322 * Description : Append concatenation string to destination string.
//  323 *
//  324 * Argument(s) : pdest       Pointer to destination   string to append concatenation  string (see Note #1).
//  325 *
//  326 *               pstr_cat    Pointer to concatenation string to append to destination string.
//  327 *
//  328 * Return(s)   : Pointer to destination string, if NO errors (see Note #2).
//  329 *
//  330 *               Pointer to NULL,               otherwise.
//  331 *
//  332 * Caller(s)   : various.
//  333 *
//  334 * Note(s)     : (1) Destination string buffer size NOT validated; buffer overruns MUST be prevented by caller.
//  335 *
//  336 *                   (a) Destination buffer size MUST be large enough to accommodate the entire concatenated
//  337 *                       string size including the terminating NULL character.
//  338 *
//  339 *               (2) String concatenation terminates when :
//  340 *
//  341 *                   (a) Destination/Concatenation string pointer(s) are passed NULL pointers.
//  342 *                       (1) No string concatenation performed; NULL pointer returned.
//  343 *
//  344 *                   (b) Destination string overlaps with NULL address.
//  345 *                       (1) No string concatenation performed; NULL pointer returned.
//  346 *
//  347 *                   (c) Destination/Concatenation string pointer(s) points to NULL.
//  348 *                       (1) String buffer(s) overlap with NULL address.
//  349 *                       (2) Concatenation string appended into destination string buffer up to but NOT
//  350 *                           beyond or including the NULL address; destination string buffer properly
//  351 *                           terminated with NULL character.
//  352 *
//  353 *                   (d) Concatenation string's terminating NULL character found.
//  354 *                       (1) Entire concatenation string appended to destination string.
//  355 *********************************************************************************************************
//  356 */
//  357 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  358 CPU_CHAR  *Str_Cat (CPU_CHAR  *pdest,
//  359                     CPU_CHAR  *pstr_cat)
//  360 {
Str_Cat:
        PUSH     {R3,R4}
//  361     CPU_CHAR  *pstr;
//  362     CPU_CHAR  *pstr_next;
//  363 
//  364                                                                 /* Rtn NULL if str ptr(s) NULL (see Note #2a).          */
//  365     if (pdest == (CPU_CHAR *)0) {
        CMP      R0,#+0
        BNE.N    ??Str_Cat_0
//  366         return  ((CPU_CHAR *)0);
??Str_Cat_1:
        B.N      ?Subroutine2
//  367     }
//  368     if (pstr_cat == (CPU_CHAR *)0) {
??Str_Cat_0:
        CMP      R1,#+0
        BEQ.N    ??Str_Cat_1
//  369         return  ((CPU_CHAR *)0);
//  370     }
//  371 
//  372 
//  373     pstr = pdest;
        MOV      R2,R0
        B.N      ??Str_Cat_2
//  374     while (( pstr != (CPU_CHAR *)0) &&                          /* Adv to end of cur dest str until NULL ptr ...        */
//  375            (*pstr != (CPU_CHAR  )0)) {                          /* ... or NULL char found..                             */
//  376         pstr++;
??Str_Cat_3:
        ADDS     R2,R2,#+1
//  377     }
        BEQ.N    ??Str_Cat_1
??Str_Cat_2:
        LDRB     R3,[R2, #+0]
        CMP      R3,#+0
        BNE.N    ??Str_Cat_3
//  378     if (pstr == (CPU_CHAR *)0) {                                /* If NULL str overrun, rtn NULL (see Note #2b).        */
//  379         return ((CPU_CHAR *)0);
//  380     }
//  381 
//  382     pstr_next = pstr;
//  383     pstr_next++;
        B.N      ?Subroutine1
//  384     while (( pstr_next != (CPU_CHAR *)0) &&                     /* Cat str until NULL ptr(s) (see Note #2c) ...         */
//  385            ( pstr_cat  != (CPU_CHAR *)0) &&
//  386            (*pstr_cat  != (CPU_CHAR  )0)) {                     /* ... or NULL char found    (see Note #2d).            */
//  387        *pstr = *pstr_cat;
//  388         pstr++;
//  389         pstr_next++;
//  390         pstr_cat++;
//  391     }
//  392 
//  393    *pstr = (CPU_CHAR)0;                                         /* Append NULL char (see Note #2c2).                    */
//  394 
//  395 
//  396     return (pdest);
//  397 }
//  398 
//  399 
//  400 /*$PAGE*/
//  401 /*
//  402 *********************************************************************************************************
//  403 *                                             Str_Cat_N()
//  404 *
//  405 * Description : Append concatenation string to destination string, up to a maximum number of characters.
//  406 *
//  407 * Argument(s) : pdest       Pointer to destination   string to append concatenation  string (see Note #1).
//  408 *
//  409 *               pstr_cat    Pointer to concatenation string to append to destination string.
//  410 *
//  411 *               len_max     Maximum number of characters to concatenate (see Note #2e).
//  412 *
//  413 * Return(s)   : Pointer to destination string, if NO errors (see Note #2).
//  414 *
//  415 *               Pointer to NULL,               otherwise.
//  416 *
//  417 * Caller(s)   : various.
//  418 *
//  419 * Note(s)     : (1) Destination string buffer size NOT validated; buffer overruns MUST be prevented by caller.
//  420 *
//  421 *                   (a) Destination buffer size MUST be large enough to accommodate the entire concatenated
//  422 *                       string size including the terminating NULL character.
//  423 *
//  424 *               (2) String concatenation terminates when :
//  425 *
//  426 *                   (a) Destination/Concatenation string pointer(s) are passed NULL pointers.
//  427 *                       (1) No string concatenation performed; NULL pointer returned.
//  428 *
//  429 *                   (b) Destination string overlaps with NULL address.
//  430 *                       (1) No string concatenation performed; NULL pointer returned.
//  431 *
//  432 *                   (c) Destination/Concatenation string pointer(s) points to NULL.
//  433 *                       (1) String buffer(s) overlap with NULL address.
//  434 *                       (2) Concatenation string appended into destination string buffer up to but NOT
//  435 *                           beyond or including the NULL address; destination string buffer properly
//  436 *                           terminated with NULL character.
//  437 *
//  438 *                   (d) Concatenation string's terminating NULL character found.
//  439 *                       (1) Entire concatenation string appended to destination string.
//  440 *
//  441 *                   (e) 'len_max' number of characters concatenated.
//  442 *                       (1) 'len_max' number of characters does NOT include the terminating NULL character.
//  443 *
//  444 *                           See also Note #1a.
//  445 *********************************************************************************************************
//  446 */
//  447 /*$PAGE*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  448 CPU_CHAR  *Str_Cat_N (CPU_CHAR    *pdest,
//  449                       CPU_CHAR    *pstr_cat,
//  450                       CPU_SIZE_T   len_max)
//  451 {
Str_Cat_N:
        PUSH     {R3-R6}
//  452     CPU_CHAR    *pstr;
//  453     CPU_CHAR    *pstr_next;
//  454     CPU_SIZE_T   len_cat;
//  455 
//  456                                                                 /* Rtn NULL if str ptr(s) NULL     (see Note #2a).      */
//  457     if (pdest == (CPU_CHAR *)0) {
        CMP      R0,#+0
        BNE.N    ??Str_Cat_N_0
//  458         return  ((CPU_CHAR *)0);
??Str_Cat_N_1:
        B.N      ?Subroutine3
//  459     }
//  460     if (pstr_cat == (CPU_CHAR *)0) {
??Str_Cat_N_0:
        CMP      R1,#+0
        BEQ.N    ??Str_Cat_N_1
//  461         return  ((CPU_CHAR *)0);
//  462     }
//  463 
//  464     if (len_max == (CPU_SIZE_T)0) {                             /* Rtn NULL if cat len equals zero (see Note #2e).      */
        CMP      R2,#+0
        BEQ.N    ??Str_Cat_N_1
//  465         return  ((CPU_CHAR *)0);
//  466     }
//  467 
//  468 
//  469     pstr = pdest;
        MOV      R3,R0
        B.N      ??Str_Cat_N_2
//  470     while (( pstr != (CPU_CHAR *)0) &&                          /* Adv to end of cur dest str until NULL ptr ...        */
//  471            (*pstr != (CPU_CHAR  )0)) {                          /* ... or NULL char found..                             */
//  472         pstr++;
??Str_Cat_N_3:
        ADDS     R3,R3,#+1
//  473     }
        BEQ.N    ??Str_Cat_N_1
??Str_Cat_N_2:
        LDRB     R4,[R3, #+0]
        CMP      R4,#+0
        BNE.N    ??Str_Cat_N_3
//  474     if (pstr == (CPU_CHAR *)0) {                                /* If NULL str overrun, rtn NULL (see Note #2b).        */
//  475         return ((CPU_CHAR *)0);
//  476     }
//  477 
//  478     pstr_next = pstr;
//  479     pstr_next++;
        B.N      ?Subroutine0
//  480     len_cat   = 0;
//  481 
//  482     while (( pstr_next != (CPU_CHAR *)0) &&                     /* Cat str until NULL ptr(s)  (see Note #2c)  ...       */
//  483            ( pstr_cat  != (CPU_CHAR *)0) &&
//  484            (*pstr_cat  != (CPU_CHAR  )0) &&                     /* ... or NULL char found     (see Note #2d); ...       */
//  485            ( len_cat   <  (CPU_SIZE_T)len_max)) {               /* ... or max nbr chars cat'd (see Note #2d).           */
//  486        *pstr = *pstr_cat;
//  487         pstr++;
//  488         pstr_next++;
//  489         pstr_cat++;
//  490         len_cat++;
//  491     }
//  492 
//  493    *pstr = (CPU_CHAR)0;                                         /* Append NULL char (see Note #2c2).                    */
//  494 
//  495 
//  496     return (pdest);
//  497 }
//  498 
//  499 
//  500 /*$PAGE*/
//  501 /*
//  502 *********************************************************************************************************
//  503 *                                              Str_Cmp()
//  504 *
//  505 * Description : Determine if two strings are identical.
//  506 *
//  507 * Argument(s) : p1_str      Pointer to first  string (see Note #1).
//  508 *
//  509 *               p2_str      Pointer to second string (see Note #1).
//  510 *
//  511 * Return(s)   : 0,              if strings are identical             (see Notes #2a, #2e, & #2f).
//  512 *
//  513 *               Negative value, if 'p1_str' is less    than 'p2_str' (see Notes #2b, #2g, & #2d).
//  514 *
//  515 *               Positive value, if 'p1_str' is greater than 'p2_str' (see Notes #2c, #2h, & #2d).
//  516 *
//  517 * Caller(s)   : various.
//  518 *
//  519 * Note(s)     : (1) String buffers NOT modified.
//  520 *
//  521 *               (2) String comparison terminates when :
//  522 *
//  523 *                   (a) BOTH string pointer(s) are passed NULL pointers.
//  524 *                       (1) NULL strings identical; return 0.
//  525 *
//  526 *                   (b) 'p1_str' passed a NULL pointer.
//  527 *                       (1) Return negative value of character pointed to by 'p2_str'.
//  528 *
//  529 *                   (c) 'p2_str' passed a NULL pointer.
//  530 *                       (1) Return positive value of character pointed to by 'p1_str'.
//  531 *
//  532 *                   (d) Non-matching characters found.
//  533 *                       (1) Return signed-integer difference of the character pointed to by 'p2_str'
//  534 *                           from the character pointed to by 'p1_str'.
//  535 *
//  536 *                   (e) Terminating NULL character found in both strings.
//  537 *                       (1) Strings identical; return 0.
//  538 *                       (2) Only one NULL character test required in conditional since previous condition
//  539 *                           tested character equality.
//  540 *
//  541 *                   (f) BOTH strings point to NULL.
//  542 *                       (1) Strings overlap with NULL address.
//  543 *                       (2) Strings identical up to but NOT beyond or including the NULL address; return 0.
//  544 *
//  545 *                   (g) 'p1_str_next' points to NULL.
//  546 *                       (1) 'p1_str' overlaps with NULL address.
//  547 *                       (2) Strings compared up to but NOT beyond or including the NULL address.
//  548 *                       (3) Return  negative value of character pointed to by 'p2_str_next'.
//  549 *
//  550 *                   (h) 'p2_str_next' points to NULL.
//  551 *                       (1) 'p2_str' overlaps with NULL address.
//  552 *                       (2) Strings compared up to but NOT beyond or including the NULL address.
//  553 *                       (3) Return  positive value of character pointed to by 'p1_str_next'.
//  554 *
//  555 *               (3) Since 16-bit signed arithmetic is performed to calculate a non-identical comparison
//  556 *                   return value, 'CPU_CHAR' native data type size MUST be 8-bit.
//  557 *********************************************************************************************************
//  558 */
//  559 /*$PAGE*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  560 CPU_INT16S  Str_Cmp (CPU_CHAR  *p1_str,
//  561                      CPU_CHAR  *p2_str)
//  562 {
Str_Cmp:
        PUSH     {R4,R5}
//  563     CPU_CHAR    *p1_str_next;
//  564     CPU_CHAR    *p2_str_next;
//  565     CPU_INT16S   cmp_val;
//  566 
//  567 
//  568     if (p1_str == (CPU_CHAR *)0) {
        CBNZ     R0,??Str_Cmp_0
//  569         if (p2_str == (CPU_CHAR *)0) {
        CMP      R1,#+0
        BEQ.N    ??Str_Cmp_1
//  570             return ((CPU_INT16S)0);                             /* If BOTH str ptrs NULL, rtn 0 (see Note #2a).         */
//  571         }
//  572         cmp_val = (CPU_INT16S)0 - (CPU_INT16S)(*p2_str);
//  573         return (cmp_val);                                       /* If p1_str NULL, rtn neg p2_str val (see Note #2b).   */
        LDRB     R1,[R1, #+0]
??Str_Cmp_2:
        RSBS     R0,R1,#+0
        B.N      ??Str_Cmp_3
//  574     }
//  575     if (p2_str == (CPU_CHAR *)0) {
??Str_Cmp_0:
        CMP      R1,#+0
        BNE.N    ??Str_Cmp_4
//  576         cmp_val = (CPU_INT16S)(*p1_str);
//  577         return (cmp_val);                                       /* If p2_str NULL, rtn pos p1_str val (see Note #2c).   */
        LDRB     R0,[R0, #+0]
        POP      {R4,R5}
        BX       LR
//  578     }
//  579 
//  580 
//  581     p1_str_next = p1_str;
//  582     p2_str_next = p2_str;
//  583     p1_str_next++;
??Str_Cmp_4:
        ADDS     R2,R0,#+1
//  584     p2_str_next++;
        ADDS     R3,R1,#+1
        B.N      ??Str_Cmp_5
//  585     while ((*p1_str      == *p2_str)       &&                   /* Cmp strs until non-matching char (see Note #2d) ..   */
//  586            (*p1_str      != (CPU_CHAR  )0) &&                   /* .. or NULL char(s)               (see Note #2e) ..   */
//  587            ( p1_str_next != (CPU_CHAR *)0) &&                   /* .. or NULL ptr(s) found (see Notes #2f, #2g, & #2h). */
//  588            ( p2_str_next != (CPU_CHAR *)0)) {
//  589         p1_str_next++;
??Str_Cmp_6:
        ADDS     R2,R2,#+1
//  590         p2_str_next++;
        ADDS     R3,R3,#+1
//  591         p1_str++;
        ADDS     R0,R0,#+1
//  592         p2_str++;
        ADDS     R1,R1,#+1
//  593     }
??Str_Cmp_5:
        LDRB     R4,[R0, #+0]
        LDRB     R5,[R1, #+0]
        CMP      R4,R5
        BNE.N    ??Str_Cmp_7
        CBZ      R4,??Str_Cmp_7
        CBZ      R2,??Str_Cmp_7
        CMP      R3,#+0
        BNE.N    ??Str_Cmp_6
//  594 
//  595 
//  596     if (*p1_str != *p2_str) {                                           /* If strs NOT identical, ...                   */
??Str_Cmp_7:
        MOV      R0,R4
        CMP      R0,R5
        BEQ.N    ??Str_Cmp_8
//  597          cmp_val = (CPU_INT16S)(*p1_str) - (CPU_INT16S)(*p2_str);       /* ... calc & rtn char diff  (see Note #2d1).   */
        SUBS     R0,R0,R5
        B.N      ??Str_Cmp_3
//  598 
//  599     } else if (*p1_str == (CPU_CHAR)0) {                                /* If NULL char(s) found, ...                   */
??Str_Cmp_8:
        CMP      R0,#+0
        BEQ.N    ??Str_Cmp_3
//  600          cmp_val = 0;                                                   /* ... strs identical; rtn 0 (see Note #2e).    */
//  601 
//  602     } else {
//  603         if (p1_str_next == (CPU_CHAR *)0) {
        CMP      R2,#+0
        BNE.N    ??Str_Cmp_9
//  604             if (p2_str_next == (CPU_CHAR *)0) {                         /* If BOTH next str ptrs NULL, ...              */
        CMP      R3,#+0
        BNE.N    ??Str_Cmp_10
//  605                 cmp_val = (CPU_INT16S)0;                                /* ... rtn 0                   (see Note #2f).  */
        MOVS     R0,#+0
        B.N      ??Str_Cmp_3
//  606             } else {                                                    /* If p1_str_next NULL, ...                     */
//  607                 cmp_val = (CPU_INT16S)0 - (CPU_INT16S)(*p2_str_next);   /* ... rtn neg p2_str_next val (see Note #2g).  */
??Str_Cmp_10:
        LDRB     R1,[R3, #+0]
        B.N      ??Str_Cmp_2
//  608             }
//  609         } else {                                                        /* If p2_str_next NULL, ...                     */
//  610             cmp_val = (CPU_INT16S)(*p1_str_next);                       /* ... rtn pos p1_str_next val (see Note #2h).  */
??Str_Cmp_9:
        LDRB     R0,[R2, #+0]
//  611         }
//  612     }
//  613 
//  614 
//  615     return (cmp_val);
??Str_Cmp_3:
        SXTH     R0,R0
??Str_Cmp_1:
        POP      {R4,R5}
        BX       LR               ;; return
//  616 }
//  617 
//  618 
//  619 /*$PAGE*/
//  620 /*
//  621 *********************************************************************************************************
//  622 *                                             Str_Cmp_N()
//  623 *
//  624 * Description : Determine if two strings are identical for up to a maximum number of characters.
//  625 *
//  626 * Argument(s) : p1_str      Pointer to first  string (see Note #1).
//  627 *
//  628 *               p2_str      Pointer to second string (see Note #1).
//  629 *
//  630 *               len_max     Maximum number of characters to compare  (see Notes #2i & #2j).
//  631 *
//  632 * Return(s)   : 0,              if strings are identical             (see Notes #2a, #2e, #2f, #2i, & #2j).
//  633 *
//  634 *               Negative value, if 'p1_str' is less    than 'p2_str' (see Notes #2b, #2g, & #2d).
//  635 *
//  636 *               Positive value, if 'p1_str' is greater than 'p2_str' (see Notes #2c, #2h, & #2d).
//  637 *
//  638 * Caller(s)   : various.
//  639 *
//  640 * Note(s)     : (1) String buffers NOT modified.
//  641 *
//  642 *               (2) String comparison terminates when :
//  643 *
//  644 *                   (a) BOTH string pointer(s) are passed NULL pointers.
//  645 *                       (1) NULL strings identical; return 0.
//  646 *
//  647 *                   (b) 'p1_str' passed a NULL pointer.
//  648 *                       (1) Return negative value of character pointed to by 'p2_str'.
//  649 *
//  650 *                   (c) 'p2_str' passed a NULL pointer.
//  651 *                       (1) Return positive value of character pointed to by 'p1_str'.
//  652 *
//  653 *                   (d) Non-matching characters found.
//  654 *                       (1) Return signed-integer difference of the character pointed to by 'p2_str'
//  655 *                           from the character pointed to by 'p1_str'.
//  656 *
//  657 *                   (e) Terminating NULL character found in both strings.
//  658 *                       (1) Strings identical; return 0.
//  659 *                       (2) Only one NULL character test required in conditional since previous condition
//  660 *                           tested character equality.
//  661 *
//  662 *                   (f) BOTH strings point to NULL.
//  663 *                       (1) Strings overlap with NULL address.
//  664 *                       (2) Strings identical up to but NOT beyond or including the NULL address; return 0.
//  665 *
//  666 *                   (g) 'p1_str_next' points to NULL.
//  667 *                       (1) 'p1_str' overlaps with NULL address.
//  668 *                       (2) Strings compared up to but NOT beyond or including the NULL address.
//  669 *                       (3) Return  negative value of character pointed to by 'p2_str_next'.
//  670 *
//  671 *                   (h) 'p2_str_next' points to NULL.
//  672 *                       (1) 'p2_str' overlaps with NULL address.
//  673 *                       (2) Strings compared up to but NOT beyond or including the NULL address.
//  674 *                       (3) Return  positive value of character pointed to by 'p1_str_next'.
//  675 *
//  676 *                   (i) 'len_max' passed a zero length.
//  677 *                       (1) Zero-length strings identical; return 0.
//  678 *
//  679 *                   (j) First 'len_max' number of characters identical.
//  680 *                       (1) Strings identical; return 0.
//  681 *
//  682 *               (3) Since 16-bit signed arithmetic is performed to calculate a non-identical comparison
//  683 *                   return value, 'CPU_CHAR' native data type size MUST be 8-bit.
//  684 *********************************************************************************************************
//  685 */
//  686 /*$PAGE*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  687 CPU_INT16S  Str_Cmp_N (CPU_CHAR    *p1_str,
//  688                        CPU_CHAR    *p2_str,
//  689                        CPU_SIZE_T   len_max)
//  690 {
Str_Cmp_N:
        PUSH     {R4-R7}
//  691     CPU_CHAR    *p1_str_next;
//  692     CPU_CHAR    *p2_str_next;
//  693     CPU_INT16S   cmp_val;
//  694     CPU_SIZE_T   cmp_len;
//  695 
//  696 
//  697     if (len_max == 0) {                                         /* If cmp len equals zero, rtn 0      (see Note #2i).   */
        CMP      R2,#+0
        BNE.N    ??Str_Cmp_N_0
//  698         return ((CPU_INT16S)0);
??Str_Cmp_N_1:
        MOVS     R0,#+0
        POP      {R4-R7}
        BX       LR
//  699     }
//  700 
//  701     if (p1_str == (CPU_CHAR *)0) {
??Str_Cmp_N_0:
        CBNZ     R0,??Str_Cmp_N_2
//  702         if (p2_str == (CPU_CHAR *)0) {
        CMP      R1,#+0
        BEQ.N    ??Str_Cmp_N_3
//  703             return ((CPU_INT16S)0);                             /* If BOTH str ptrs NULL,  rtn 0      (see Note #2a).   */
//  704         }
//  705         cmp_val = (CPU_INT16S)0 - (CPU_INT16S)(*p2_str);
//  706         return (cmp_val);                                       /* If p1_str NULL, rtn neg p2_str val (see Note #2b).   */
        LDRB     R1,[R1, #+0]
??Str_Cmp_N_4:
        RSBS     R0,R1,#+0
        B.N      ??Str_Cmp_N_5
//  707     }
//  708     if (p2_str == (CPU_CHAR *)0) {
??Str_Cmp_N_2:
        CMP      R1,#+0
        BNE.N    ??Str_Cmp_N_6
//  709         cmp_val = (CPU_INT16S)(*p1_str);
//  710         return (cmp_val);                                       /* If p2_str NULL, rtn pos p1_str val (see Note #2c).   */
        LDRB     R0,[R0, #+0]
        POP      {R4-R7}
        BX       LR
//  711     }
//  712 
//  713 
//  714     p1_str_next = p1_str;
//  715     p2_str_next = p2_str;
//  716     p1_str_next++;
??Str_Cmp_N_6:
        ADDS     R3,R0,#+1
//  717     p2_str_next++;
        ADDS     R4,R1,#+1
//  718     cmp_len     = 0;
        MOVS     R5,#+0
        B.N      ??Str_Cmp_N_7
//  719     while ((*p1_str      == *p2_str)       &&                   /* Cmp strs until non-matching char (see Note #2d) ..   */
//  720            (*p1_str      != (CPU_CHAR  )0) &&                   /* .. or NULL char(s)               (see Note #2e) ..   */
//  721            ( p1_str_next != (CPU_CHAR *)0) &&                   /* .. or NULL ptr(s) found (see Notes #2f, #2g, & #2h); */
//  722            ( p2_str_next != (CPU_CHAR *)0) &&
//  723            ( cmp_len     <  (CPU_SIZE_T)len_max)) {             /* .. or len nbr chars cmp'd        (see Note #2j).     */
//  724         p1_str_next++;
??Str_Cmp_N_8:
        ADDS     R3,R3,#+1
//  725         p2_str_next++;
        ADDS     R4,R4,#+1
//  726         p1_str++;
        ADDS     R0,R0,#+1
//  727         p2_str++;
        ADDS     R1,R1,#+1
//  728         cmp_len++;
        ADDS     R5,R5,#+1
//  729     }
??Str_Cmp_N_7:
        LDRB     R6,[R0, #+0]
        LDRB     R7,[R1, #+0]
        CMP      R6,R7
        BNE.N    ??Str_Cmp_N_9
        CBZ      R6,??Str_Cmp_N_9
        CBZ      R3,??Str_Cmp_N_9
        CBZ      R4,??Str_Cmp_N_9
        CMP      R5,R2
        BCC.N    ??Str_Cmp_N_8
//  730 
//  731 
//  732     if (cmp_len == len_max) {                                           /* If strs     identical for len nbr of chars,  */
??Str_Cmp_N_9:
        CMP      R5,R2
        BEQ.N    ??Str_Cmp_N_1
//  733         return ((CPU_INT16S)0);                                         /* ... rtn 0 (see Note #2j).                    */
//  734     }
//  735 
//  736     if (*p1_str != *p2_str) {                                           /* If strs NOT identical, ...                   */
        MOV      R0,R6
        CMP      R0,R7
        BEQ.N    ??Str_Cmp_N_10
//  737          cmp_val = (CPU_INT16S)(*p1_str) - (CPU_INT16S)(*p2_str);       /* ... calc & rtn char diff  (see Note #2d1).   */
        SUBS     R0,R0,R7
        B.N      ??Str_Cmp_N_5
//  738 
//  739     } else if (*p1_str == (CPU_CHAR)0) {                                /* If NULL char(s) found, ...                   */
??Str_Cmp_N_10:
        CMP      R0,#+0
        BEQ.N    ??Str_Cmp_N_5
//  740          cmp_val = 0;                                                   /* ... strs identical; rtn 0 (see Note #2e).    */
//  741 
//  742     } else {
//  743         if (p1_str_next == (CPU_CHAR *)0) {
        CMP      R3,#+0
        BNE.N    ??Str_Cmp_N_11
//  744             if (p2_str_next == (CPU_CHAR *)0) {                         /* If BOTH next str ptrs NULL, ...              */
        CMP      R4,#+0
        BNE.N    ??Str_Cmp_N_12
//  745                 cmp_val = (CPU_INT16S)0;                                /* ... rtn 0                   (see Note #2f).  */
        MOVS     R0,#+0
        B.N      ??Str_Cmp_N_5
//  746             } else {                                                    /* If p1_str_next NULL, ...                     */
//  747                 cmp_val = (CPU_INT16S)0 - (CPU_INT16S)(*p2_str_next);   /* ... rtn neg p2_str_next val (see Note #2g).  */
??Str_Cmp_N_12:
        LDRB     R1,[R4, #+0]
        B.N      ??Str_Cmp_N_4
//  748             }
//  749         } else {                                                        /* If p2_str_next NULL, ...                     */
//  750             cmp_val = (CPU_INT16S)(*p1_str_next);                       /* ... rtn pos p1_str_next val (see Note #2h).  */
??Str_Cmp_N_11:
        LDRB     R0,[R3, #+0]
//  751         }
//  752     }
//  753 
//  754 
//  755     return (cmp_val);
??Str_Cmp_N_5:
        SXTH     R0,R0
??Str_Cmp_N_3:
        POP      {R4-R7}
        BX       LR               ;; return
//  756 }
//  757 
//  758 
//  759 /*$PAGE*/
//  760 /*
//  761 *********************************************************************************************************
//  762 *                                             Str_Char()
//  763 *
//  764 * Description : Search string for first occurrence of specific character.
//  765 *
//  766 * Argument(s) : pstr            Pointer to string (see Note #1).
//  767 *
//  768 *               srch_char       Search character.
//  769 *
//  770 * Return(s)   : Pointer to first occurrence of search character in string, if any.
//  771 *
//  772 *               Pointer to NULL,                                           otherwise.
//  773 *
//  774 * Caller(s)   : various.
//  775 *
//  776 * Note(s)     : (1) String buffer NOT modified.
//  777 *
//  778 *               (2) String search terminates when :
//  779 *
//  780 *                   (a) String pointer passed a NULL pointer.
//  781 *                       (1) No string search performed; NULL pointer returned.
//  782 *
//  783 *                   (b) String pointer points to NULL.
//  784 *                       (1) String overlaps with NULL address.
//  785 *                       (2) String searched up to but NOT beyond or including the NULL address.
//  786 *
//  787 *                   (c) String's terminating NULL character found.
//  788 *                       (1) Search character NOT found in search string; NULL pointer returned.
//  789 *                       (2) Applicable ONLY IF search character is NOT the terminating NULL character.
//  790 *
//  791 *                   (d) Search character found.
//  792 *                       (1) Return pointer to first occurrence of search character in search string.
//  793 *********************************************************************************************************
//  794 */
//  795 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  796 CPU_CHAR  *Str_Char (CPU_CHAR  *pstr,
//  797                      CPU_CHAR   srch_char)
//  798 {
//  799     CPU_CHAR  *pstr_next;
//  800 
//  801 
//  802     if (pstr == (CPU_CHAR *)0) {                                /* Rtn NULL if srch str ptr NULL (see Note #2a).        */
Str_Char:
        CBZ      R0,??Str_Char_0
//  803         return ((CPU_CHAR *)0);
//  804     }
//  805 
//  806 
//  807     pstr_next = pstr;
//  808     pstr_next++;
        ADDS     R2,R0,#+1
        B.N      ??Str_Char_1
//  809     while (( pstr_next != (CPU_CHAR *)0) &&                     /* Srch str until NULL ptr(s) (see Note #2b) ...        */
//  810            (*pstr      != (CPU_CHAR  )0) &&                     /* ... or NULL char           (see Note #2c) ...        */
//  811            (*pstr      != (CPU_CHAR  )srch_char)) {             /* ... or srch char found     (see Note #2d).           */
//  812         pstr++;
??Str_Char_2:
        ADDS     R0,R0,#+1
//  813         pstr_next++;
        ADDS     R2,R2,#+1
//  814     }
??Str_Char_1:
        CBZ      R2,??Str_Char_3
        LDRB     R3,[R0, #+0]
        CBZ      R3,??Str_Char_3
        CMP      R3,R1
        BNE.N    ??Str_Char_2
//  815 
//  816 
//  817     if (*pstr != srch_char) {                                   /* If srch char NOT found, str points to NULL; ...      */
??Str_Char_3:
        LDRB     R2,[R0, #+0]
        CMP      R2,R1
        BEQ.N    ??Str_Char_0
//  818         return ((CPU_CHAR *)0);                                 /* ... rtn NULL (see Notes #2b & #2c).                  */
        MOVS     R0,#+0
//  819     }
//  820 
//  821     return (pstr);                                              /* Else rtn ptr to found srch char (see Note #2d).      */
??Str_Char_0:
        BX       LR               ;; return
//  822 }
//  823 
//  824 
//  825 /*$PAGE*/
//  826 /*
//  827 *********************************************************************************************************
//  828 *                                            Str_Char_N()
//  829 *
//  830 * Description : Search string for first occurrence of specific character, up to a maximum number of characters.
//  831 *
//  832 * Argument(s) : pstr            Pointer to string (see Note #1).
//  833 *
//  834 *               len_max         Maximum number of characters to search (see Notes #2e & #3).
//  835 *
//  836 *               srch_char       Search character.
//  837 *
//  838 * Return(s)   : Pointer to first occurrence of search character in string, if any.
//  839 *
//  840 *               Pointer to NULL,                                           otherwise.
//  841 *
//  842 * Caller(s)   : various.
//  843 *
//  844 * Note(s)     : (1) String buffer NOT modified.
//  845 *
//  846 *               (2) String search terminates when :
//  847 *
//  848 *                   (a) String pointer passed a NULL pointer.
//  849 *                       (1) No string search performed; NULL pointer returned.
//  850 *
//  851 *                   (b) String pointer points to NULL.
//  852 *                       (1) String overlaps with NULL address.
//  853 *                       (2) String searched up to but NOT beyond or including the NULL address.
//  854 *
//  855 *                   (c) String's terminating NULL character found.
//  856 *                       (1) Search character NOT found in search string; NULL pointer returned.
//  857 *                       (2) Applicable ONLY IF search character is NOT the terminating NULL character.
//  858 *
//  859 *                   (d) Search character found.
//  860 *                       (1) Return pointer to first occurrence of search character in search string.
//  861 *
//  862 *                   (e) 'len_max' number of characters searched.
//  863 *                       (1) 'len_max' number of characters does NOT include terminating NULL character.
//  864 *
//  865 *               (3) Ideally, the 'len_max' parameter would be the last parameter in this function's
//  866 *                   paramter list for consistency with all other custom string library functions.
//  867 *                   However, the 'len_max' parameter is ordered to comply with the standard library
//  868 *                   function's parameter list.
//  869 *********************************************************************************************************
//  870 */
//  871 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  872 CPU_CHAR  *Str_Char_N (CPU_CHAR    *pstr,
//  873                        CPU_SIZE_T   len_max,
//  874                        CPU_CHAR     srch_char)
//  875 {
Str_Char_N:
        PUSH     {R4,R5}
//  876     CPU_CHAR    *pstr_next;
//  877     CPU_SIZE_T   len_srch;
//  878 
//  879 
//  880     if (pstr == (CPU_CHAR *)0) {                                /* Rtn NULL if srch str ptr NULL    (see Note #2a).     */
        CBZ      R0,??Str_Char_N_0
//  881         return ((CPU_CHAR *)0);
//  882     }
//  883 
//  884     if (len_max == (CPU_SIZE_T)0) {                             /* Rtn NULL if srch len equals zero (see Note #2e).     */
        CBZ      R1,??Str_Char_N_1
//  885         return ((CPU_CHAR *)0);
//  886     }
//  887 
//  888 
//  889     pstr_next = pstr;
//  890     pstr_next++;
        ADDS     R3,R0,#+1
//  891     len_srch  = 0;
        MOVS     R4,#+0
        B.N      ??Str_Char_N_2
//  892     while (( pstr_next != (CPU_CHAR *)0)         &&             /* Srch str until NULL ptr(s)  (see Note #2b)  ...      */
//  893            (*pstr      != (CPU_CHAR  )0)         &&             /* ... or NULL char            (see Note #2c)  ...      */
//  894            (*pstr      != (CPU_CHAR  )srch_char) &&             /* ... or srch char found      (see Note #2d); ...      */
//  895            ( len_srch  <  (CPU_SIZE_T)len_max)) {               /* ... or max nbr chars srch'd (see Note #2e).          */
//  896         pstr++;
??Str_Char_N_3:
        ADDS     R0,R0,#+1
//  897         pstr_next++;
        ADDS     R3,R3,#+1
//  898         len_srch++;
        ADDS     R4,R4,#+1
//  899     }
??Str_Char_N_2:
        CBZ      R3,??Str_Char_N_4
        LDRB     R5,[R0, #+0]
        CBZ      R5,??Str_Char_N_4
        CMP      R5,R2
        BEQ.N    ??Str_Char_N_4
        CMP      R4,R1
        BCC.N    ??Str_Char_N_3
//  900 
//  901 
//  902     if (*pstr != srch_char) {                                   /* If srch char NOT found, str points to NULL; ...      */
??Str_Char_N_4:
        LDRB     R1,[R0, #+0]
        CMP      R1,R2
        BEQ.N    ??Str_Char_N_0
//  903         return ((CPU_CHAR *)0);                                 /* ... rtn NULL (see Notes #2b & #2c).                  */
??Str_Char_N_1:
        MOVS     R0,#+0
//  904     }
//  905 
//  906     return (pstr);                                              /* Else rtn ptr to found srch char (see Note #2d).      */
??Str_Char_N_0:
        POP      {R4,R5}
        BX       LR               ;; return
//  907 }
//  908 
//  909 
//  910 /*$PAGE*/
//  911 /*
//  912 *********************************************************************************************************
//  913 *                                           Str_Char_Last()
//  914 *
//  915 * Description : Search string for last occurrence of specific character.
//  916 *
//  917 * Argument(s) : pstr            Pointer to string (see Note #1).
//  918 *
//  919 *               srch_char       Search character.
//  920 *
//  921 * Return(s)   : Pointer to last occurrence of search character in string, if any.
//  922 *
//  923 *               Pointer to NULL,                                          otherwise.
//  924 *
//  925 * Caller(s)   : various.
//  926 *
//  927 * Note(s)     : (1) String buffer NOT modified.
//  928 *
//  929 *               (2) String search terminates when :
//  930 *
//  931 *                   (a) String pointer passed a NULL pointer.
//  932 *                       (1) No string search performed; NULL pointer returned.
//  933 *
//  934 *                   (b) String pointer points to NULL.
//  935 *                       (1) String overlaps with NULL address.
//  936 *                       (2) String searched up to but NOT beyond or including the NULL address.
//  937 *                       (3) NULL address boundary handled in Str_Len().
//  938 *
//  939 *                   (c) String searched from end to beginning.
//  940 *                       (1) Search character NOT found in search string; NULL pointer returned.
//  941 *                       (2) Applicable ONLY IF search character is NOT the terminating NULL character.
//  942 *
//  943 *                   (d) Search character found.
//  944 *                       (1) Return pointer to first occurrence of search character in search string.
//  945 *********************************************************************************************************
//  946 */
//  947 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  948 CPU_CHAR  *Str_Char_Last (CPU_CHAR  *pstr,
//  949                           CPU_CHAR   srch_char)
//  950 {
Str_Char_Last:
        PUSH     {R3-R5,LR}
        MOV      R5,R0
        MOV      R4,R1
//  951     CPU_CHAR    *pstr_next;
//  952     CPU_SIZE_T   str_len;
//  953 
//  954 
//  955     if (pstr == (CPU_CHAR *)0) {                                /* Rtn NULL if srch str ptr NULL (see Note #2a).        */
        CBZ      R5,??Str_Char_Last_0
//  956         return ((CPU_CHAR *)0);
//  957     }
//  958 
//  959 
//  960     pstr_next  = pstr;
//  961     str_len    = Str_Len(pstr);
//  962     pstr_next += str_len;
        BL       Str_Len
        ADDS     R0,R0,R5
        B.N      ??Str_Char_Last_1
//  963     while (( pstr_next != pstr) &&                              /* Srch str from end until beg (see Note #2c) ...       */
//  964            (*pstr_next != srch_char)) {                         /* ... until srch char found   (see Note #2d).          */
//  965         pstr_next--;
??Str_Char_Last_2:
        SUBS     R0,R0,#+1
//  966     }
??Str_Char_Last_1:
        CMP      R0,R5
        BEQ.N    ??Str_Char_Last_3
        LDRB     R1,[R0, #+0]
        CMP      R1,R4
        BNE.N    ??Str_Char_Last_2
//  967 
//  968 
//  969     if (*pstr_next != srch_char) {                              /* If srch char NOT found, str points to NULL; ...      */
??Str_Char_Last_3:
        LDRB     R1,[R0, #+0]
        CMP      R1,R4
        BEQ.N    ??Str_Char_Last_0
//  970         return ((CPU_CHAR *)0);                                 /* ... rtn NULL (see Notes #2b & #2c).                  */
        MOVS     R0,#+0
//  971     }
//  972 
//  973     return (pstr_next);                                         /* Else rtn ptr to found srch char (see Note #2d).      */
??Str_Char_Last_0:
        POP      {R1,R4,R5,PC}    ;; return
//  974 }
//  975 
//  976 
//  977 /*$PAGE*/
//  978 /*
//  979 *********************************************************************************************************
//  980 *                                             Str_Str()
//  981 *
//  982 * Description : Search string for first occurence of a specific search string.
//  983 *
//  984 * Argument(s) : pstr            Pointer to        string (see Note #1).
//  985 *
//  986 *               psrch_str       Pointer to search string (see Note #1).
//  987 *
//  988 * Return(s)   : Pointer to first occurrence of search string in string, if any.
//  989 *
//  990 *               Pointer to NULL,                                        otherwise.
//  991 *
//  992 * Caller(s)   : various.
//  993 *
//  994 * Note(s)     : (1) String buffers NOT modified.
//  995 *
//  996 *               (2) String search terminates when :
//  997 *
//  998 *                   (a) String pointer passed a NULL pointer.
//  999 *                       (1) No string search performed; NULL pointer returned.
// 1000 *
// 1001 *                   (b) Search string length greater than string length.
// 1002 *                       (1) No string search performed; NULL pointer returned.
// 1003 *
// 1004 *                   (c) Search string length equal to zero.
// 1005 *                       (1) NULL search string at end of string returned.
// 1006 *
// 1007 *                   (d) Entire string has been searched.
// 1008 *                       (1) Maximum size of the search is defined as the subtraction of the
// 1009 *                           search string length from the string length.
// 1010 *                       (2) Search string not found; NULL pointer returned.
// 1011 *
// 1012 *                   (e) Search string found.
// 1013 *                       (1) Search string found according to Str_Cmp_N() return value.
// 1014 *                       (2) Return pointer to first occurrence of search string in string.
// 1015 *********************************************************************************************************
// 1016 */
// 1017 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1018 CPU_CHAR  *Str_Str (CPU_CHAR  *pstr,
// 1019                     CPU_CHAR  *psrch_str)
// 1020 {
Str_Str:
        PUSH     {R3-R11,LR}
        MOV      R5,R0
        MOV      R8,R1
// 1021     CPU_SIZE_T    str_len;
// 1022     CPU_SIZE_T    srch_str_len;
// 1023     CPU_SIZE_T    srch_len;
// 1024     CPU_SIZE_T    srch_ix;
// 1025     CPU_BOOLEAN   srch_done;
// 1026     CPU_INT16S    srch_cmp;
// 1027     CPU_CHAR     *pstr_srch_ix;
// 1028 
// 1029                                                                 /* Rtn NULL if str ptr(s) NULL (see Note #2a).          */
// 1030     if (pstr == (CPU_CHAR *)0) {
        CMP      R5,#+0
        BEQ.N    ??Str_Str_0
// 1031         return ((CPU_CHAR *)0);
// 1032     }
// 1033     if (psrch_str == (CPU_CHAR *)0) {
        CMP      R8,#+0
        BNE.N    ??Str_Str_1
// 1034         return ((CPU_CHAR *)0);
??Str_Str_2:
        MOVS     R0,#+0
        POP      {R1,R4-R11,PC}
// 1035     }
// 1036 
// 1037 
// 1038     str_len      = Str_Len(pstr);
??Str_Str_1:
        BL       Str_Len
        MOV      R7,R0
// 1039     srch_str_len = Str_Len(psrch_str);
        MOV      R0,R8
        BL       Str_Len
        MOV      R9,R0
// 1040     if (srch_str_len > str_len) {                               /* If srch str len > str len, rtn NULL  (see Note #2b). */
        CMP      R7,R9
        BCC.N    ??Str_Str_2
// 1041         return ((CPU_CHAR *)0);
// 1042     }
// 1043     if (srch_str_len == 0) {                                    /* If srch str len = 0, srch str equal NULL str; ...    */
        CMP      R9,#+0
        BNE.N    ??Str_Str_3
// 1044         pstr_srch_ix = (CPU_CHAR *)(pstr + str_len);            /* ... rtn ptr to NULL str found in str (see Note #2c). */
// 1045         return (pstr_srch_ix);
        ADDS     R0,R7,R5
        POP      {R1,R4-R11,PC}
// 1046     }
// 1047 
// 1048     srch_len  = str_len - srch_str_len;                         /* Determine srch len (see Note #2d1).                  */
??Str_Str_3:
        SUB      R11,R7,R9
// 1049     srch_ix   = 0;
        MOVS     R7,#+0
// 1050     srch_done = DEF_NO;
        MOVS     R4,#+0
??Str_Str_4:
        CMP      R11,R7
        BCC.N    ??Str_Str_5
// 1051     while ((srch_done == DEF_NO) && (srch_ix <= srch_len)) {
// 1052         pstr_srch_ix = (CPU_CHAR *)(pstr + srch_ix);
        ADD      R10,R7,R5
// 1053         srch_cmp     =  Str_Cmp_N(pstr_srch_ix, psrch_str, srch_str_len);
        MOV      R2,R9
        MOV      R1,R8
        MOV      R0,R10
        BL       Str_Cmp_N
        MOV      R6,R0
// 1054         srch_done    = (srch_cmp == 0) ? DEF_YES : DEF_NO;
        CBNZ     R6,??Str_Str_6
        MOVS     R4,#+1
// 1055         srch_ix++;
??Str_Str_6:
        ADDS     R7,R7,#+1
// 1056     }
        CMP      R4,#+0
        BEQ.N    ??Str_Str_4
// 1057 
// 1058 
// 1059     if (srch_cmp != 0) {                                        /* If srch str NOT found, rtn NULL  (see Note #2d).     */
??Str_Str_5:
        CMP      R6,#+0
        BNE.N    ??Str_Str_2
// 1060         return ((CPU_CHAR *)0);
// 1061     }
// 1062 
// 1063     return (pstr_srch_ix);                                      /* Rtn ptr to srch str found in str (see Note #2e).     */
        MOV      R0,R10
??Str_Str_0:
        POP      {R1,R4-R11,PC}   ;; return
// 1064 }

        END
// 1065 
// 1066 
// 1067 /*$PAGE*/
// 1068 /*
// 1069 *********************************************************************************************************
// 1070 *                                           Str_FmtNbr_32()
// 1071 *
// 1072 * Description : Format number into a multi-digit character string.
// 1073 *
// 1074 * Argument(s) : nbr             Number                          to format (see Note #1).
// 1075 *
// 1076 *               nbr_dig         Number of integer        digits to format (see Note #2).
// 1077 *
// 1078 *               nbr_dp          Number of decimal point  digits to format.
// 1079 *
// 1080 *               lead_zeros      Prepend leading zeros    option (DEF_YES/DEF_NO) [see Note #3].
// 1081 *
// 1082 *               nul             NULL-character terminate option (DEF_YES/DEF_NO) [see Note #4].
// 1083 *
// 1084 *               pstr_fmt        Pointer to character array to return formatted number string (see Note #5).
// 1085 *
// 1086 * Return(s)   : Pointer to formatted string, if NO errors (see Note #6).
// 1087 *
// 1088 *               Pointer to NULL,             otherwise.
// 1089 *
// 1090 * Caller(s)   : various.
// 1091 *
// 1092 * Note(s)     : (1) (a) The maximum accuracy for 32-bit floating-point numbers :
// 1093 *
// 1094 *
// 1095 *                                 Maximum Accuracy            log [Internal-Base ^ (Number-Internal-Base-Digits)]
// 1096 *                           32-bit Floating-point Number  =  -----------------------------------------------------
// 1097 *                                                                             log [External-Base]
// 1098 *
// 1099 *                                                             log [2 ^ 24]
// 1100 *                                                         =  --------------
// 1101 *                                                               log [10]
// 1102 *
// 1103 *                                                         <  7.225  Base-10 Digits
// 1104 *
// 1105 *                               where
// 1106 *                                       Internal-Base                   Internal number base of floating-
// 1107 *                                                                           point numbers (i.e.  2)
// 1108 *                                       External-Base                   External number base of floating-
// 1109 *                                                                           point numbers (i.e. 10)
// 1110 *                                       Number-Internal-Base-Digits     Number of internal number base
// 1111 *                                                                           significant digits (i.e. 24)
// 1112 *
// 1113 *                   (b) Some compilers' floating-point routines MAY further reduce the maximum accuracy.
// 1114 *
// 1115 *                   (c) If the total number of digits to format ('nbr_dig + nbr_dp') is greater than the 
// 1116 *                       maximum accuracy; digits following the first, significantly-accurate digits will
// 1117 *                       be inaccurate.
// 1118 *
// 1119 *               (2) (a) If the number of digits to format ('nbr_dig') is less than the number of significant
// 1120 *                       integer digits of the number to format ('nbr'); then the most-significant digits of
// 1121 *                       the formatted number will be truncated.
// 1122 *
// 1123 *                           Example :
// 1124 *
// 1125 *                               nbr      = 23456.789
// 1126 *                               nbr_dig  = 3
// 1127 *                               nbr_dp   = 2
// 1128 *
// 1129 *                               pstr_fmt = "456.78"
// 1130 *
// 1131 *                   (b) If number to format ('nbr') is negative but the most-significant digits of the
// 1132 *                       formatted number are truncated (see Note #2a); the negative sign still prefixes
// 1133 *                       the truncated formatted number.
// 1134 *
// 1135 *                           Example :
// 1136 *
// 1137 *                               nbr      = -23456.789
// 1138 *                               nbr_dig  =  3
// 1139 *                               nbr_dp   =  2
// 1140 *
// 1141 *                               pstr_fmt = "-456.78"
// 1142 *
// 1143 *               (3) (a) Leading zeros option prepends leading '0's prior to the first non-zero digit.
// 1144 *                       The number of leading zeros is such that the total number integer digits is
// 1145 *                       equal to the requested number of integer digits to format ('nbr_dig').
// 1146 *
// 1147 *                   (b) (1) If leading zeros option DISABLED,                        ...
// 1148 *                       (2) ... number of digits to format is non-zero,              ...
// 1149 *                       (3) ... & the integer value of the number to format is zero; ...
// 1150 *                       (4) ... then one digit of '0' value is formatted.
// 1151 *
// 1152 *                           This is NOT a leading zero; but a single integer digit of '0' value.
// 1153 *
// 1154 *               (4) (a) NULL-character terminate option DISABLED prevents overwriting previous character
// 1155 *                       array formatting.
// 1156 *
// 1157 *                   (b) WARNING: Unless 'pstr_fmt' character array is pre-/post-terminated, NULL-character
// 1158 *                       terminate option DISABLED will cause character string run-on.
// 1159 *$PAGE*
// 1160 *               (5) (a) Format buffer size NOT validated; buffer overruns MUST be prevented by caller.
// 1161 *
// 1162 *                   (b) To prevent character buffer overrun :
// 1163 *
// 1164 *                           Character array size MUST be  >=  ('nbr_dig'         +
// 1165 *                                                              'nbr_dp'          +
// 1166 *                                                              1 negative sign   +
// 1167 *                                                              1 decimal point   +
// 1168 *                                                              1 'NUL' terminator)  characters
// 1169 *
// 1170 *               (6) String format terminates when :
// 1171 *
// 1172 *                   (a) Format string pointer is passed a NULL pointer.
// 1173 *                       (1) No string format performed; NULL pointer returned.
// 1174 *
// 1175 *                   (b) Number successfully formatted into character string array.
// 1176 *********************************************************************************************************
// 1177 */
// 1178 
// 1179 #if (LIB_STR_CFG_FP_EN == DEF_ENABLED)
// 1180 CPU_CHAR  *Str_FmtNbr_32 (CPU_FP32      nbr,
// 1181                           CPU_INT08U    nbr_dig,
// 1182                           CPU_INT08U    nbr_dp,
// 1183                           CPU_BOOLEAN   lead_zeros,
// 1184                           CPU_BOOLEAN   nul,
// 1185                           CPU_CHAR     *pstr_fmt)
// 1186 {
// 1187     CPU_CHAR    *pstr;
// 1188     CPU_INT08U   i;
// 1189     CPU_INT32U   dig_nbr;
// 1190     CPU_INT32U   dig_val;
// 1191     CPU_FP32     dig_exp;
// 1192     CPU_FP32     dp_exp;
// 1193 
// 1194                                                                 /* Rtn NULL if str ptr NULL (see Note #6a).             */
// 1195     if (pstr_fmt == (CPU_CHAR *)0) {
// 1196         return ((CPU_CHAR *)0);
// 1197     }
// 1198 
// 1199 
// 1200     pstr = pstr_fmt;
// 1201 
// 1202     if (nbr < 0.0) {                                            /* If nbr neg,             ...                          */
// 1203         if ((nbr_dig > 0) ||                                    /* ... &  at least one dig ...                          */
// 1204             (nbr_dp  > 0)) {                                    /* ... or at least one dp; ...                          */
// 1205              nbr     = -nbr;                                    /* ... negate nbr &        ...                          */
// 1206             *pstr++  = '-';                                     /* ... prefix with neg sign (see Note #2b).             */
// 1207         }
// 1208     }
// 1209 
// 1210     if (nbr_dig > 0) {
// 1211         dig_exp = 1.0;
// 1212         for (i = 1; i < nbr_dig; i++) {
// 1213             dig_exp *= 10.0;
// 1214         }
// 1215         for (i = nbr_dig; i > 0; i--) {                         /* Fmt str for desired nbr digs.                        */
// 1216             dig_nbr = (CPU_INT32U)(nbr / dig_exp);
// 1217             if ((dig_nbr >  0) ||                               /* If dig nbr > 0,                              ...     */
// 1218                 (nbr_dig == 1) ||                               /* ... OR exactly 1 dig to fmt,                 ...     */
// 1219                 (i       == 1) ||                               /* ... OR on one's  dig to fmt,                 ...     */
// 1220                 (lead_zeros == DEF_YES)) {                      /* ... OR lead zeros opt ENABLED (see Note #3), ...     */
// 1221                                                                 /* ... calc & fmt dig val.                              */
// 1222                  dig_val = (CPU_INT32U)(dig_nbr % 10 );
// 1223                 *pstr++  = (CPU_CHAR  )(dig_val + '0');
// 1224             }
// 1225             dig_exp /= 10.0;                                    /* Shift to next least-significant dig.                 */
// 1226         }
// 1227     }
// 1228 
// 1229     if (nbr_dp > 0) {
// 1230        *pstr++ = '.';                                           /* Append dp prior to dp conversion.                    */
// 1231         dp_exp = 10.0;
// 1232         for (i = 0; i < nbr_dp; i++) {                          /* Fmt str for desired nbr dp.                          */
// 1233             dig_nbr  = (CPU_INT32U)(nbr * dp_exp );
// 1234             dig_val  = (CPU_INT32U)(dig_nbr % 10 );
// 1235            *pstr++   = (CPU_CHAR  )(dig_val + '0');
// 1236             dp_exp  *=  10.0;                                   /* Shift to next least-significant dp.                  */
// 1237         }
// 1238     }
// 1239 
// 1240     if (nul != DEF_NO) {                                        /* If NOT DISABLED, append NULL char (see Note #4).     */
// 1241        *pstr = (CPU_CHAR)0;
// 1242     }
// 1243 
// 1244 
// 1245     return (pstr_fmt);
// 1246 }
// 1247 #endif
// 1248 
// 
// 626 bytes in section .text
// 
// 626 bytes of CODE memory
//
//Errors: none
//Warnings: none
