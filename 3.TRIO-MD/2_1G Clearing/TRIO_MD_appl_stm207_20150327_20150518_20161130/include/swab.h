/*************************************************************************
 * linux/byteorder/swab.c
 * Byte-swapping, independently from CPU endianness
 *	swabXX[ps]?(foo)
 *
 * Francois-Rene Rideau <fare@tunes.org> 19971205
 *    separated swab functions from cpu_to_XX,
 *    to clean up support for bizarre-endian architectures.
 *
 * See asm-i386/byteorder.h and suches for examples of how to provide
 * architecture-dependent optimized versions
 *
 * History
 * 2005.11.08: bizistyle, modified using Linux source to use at hms7202
 *************************************************************************/
/* casts are necessary for constants, because we never know how for sure
 * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
 */



unsigned short ___swab16(unsigned short x);
unsigned int ___swab32(unsigned int x);
//unsigned long long ___swab64(unsigned long long x);


/*************************************************************************
 * provide defaults when no architecture-specific optimization is detected
 **************************************************************************/
#define __arch__swab16(x) ___swab16(x)
#define __arch__swab32(x) ___swab32(x)
//#define __arch__swab64(x) ___swab64(x)

#define __arch__swab16p(x) __arch__swab16(*(x))
#define __arch__swab32p(x) __arch__swab32(*(x))
//#define __arch__swab64p(x) __arch__swab64(*(x))

#define __arch__swab16s(x) {do { *(x) = __arch__swab16p((x)); } while (0);}
#define __arch__swab32s(x) {do { *(x) = __arch__swab32p((x)); } while (0);}
//#define __arch__swab64s(x) {do { *(x) = __arch__swab64p((x)); } while (0);}


/********************************
 * Allow constant folding
 *******************************/

#define __swab16(x) __fswab16(x)
#define __swab32(x) __fswab32(x)
//#define __swab64(x) __fswab64(x)


unsigned short __fswab16(unsigned short x);
unsigned short __swab16p(unsigned short *x);
void __swab16s(unsigned short *addr);
unsigned int __fswab32(unsigned int x);
unsigned int __swab32p(unsigned int *x);
void __swab32s(unsigned int *addr);
//unsigned long long __fswab64(unsigned long long x);
//unsigned long long __swab64p(unsigned long long *x);
//void __swab64s(unsigned long long *addr);

////////////////////////////////////////////////////////////////

#define swab16 __swab16
#define swab32 __swab32
#define swab64 __swab64
#define swab16p __swab16p
#define swab32p __swab32p
#define swab64p __swab64p
#define swab16s __swab16s
#define swab32s __swab32s
#define swab64s __swab64s
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////
