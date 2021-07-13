
#include "../include/main.h"

 
unsigned short ___swab16(unsigned short x)
{
	unsigned short int __x = (x);
	return ((unsigned short)((((unsigned short)(__x) & (unsigned short)0x00ffU) << 8) | (((unsigned short)(__x) & (unsigned short)0xff00U) >> 8) ));
}

unsigned int ___swab32(unsigned int x)
{
	unsigned int __x = (x);
	return ((unsigned int)(
				(((unsigned int)(__x) & (unsigned int)0x000000ffUL) << 24) |
				(((unsigned int)(__x) & (unsigned int)0x0000ff00UL) <<  8) |
				(((unsigned int)(__x) & (unsigned int)0x00ff0000UL) >>  8) |
				(((unsigned int)(__x) & (unsigned int)0xff000000UL) >> 24) ));
}

/**
unsigned long long ___swab64(unsigned long long x)
{
	unsigned long long __x = (x);
	return ((unsigned long long)(
				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x00000000000000ffULL) << 56) |
				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x000000000000ff00ULL) << 40) |
				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x0000000000ff0000ULL) << 24) |
				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x00000000ff000000ULL) <<  8) |
	    		(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x000000ff00000000ULL) >>  8) |
				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x0000ff0000000000ULL) >> 24) |
				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0x00ff000000000000ULL) >> 40) |
				(unsigned long long)(((unsigned long long)(__x) & (unsigned long long)0xff00000000000000ULL) >> 56) ));
}
**/


unsigned short __fswab16(unsigned short x)
{
	return __arch__swab16(x);
}

unsigned short __swab16p(unsigned short *x)
{
	return __arch__swab16p(x);
}

void __swab16s(unsigned short *addr)
{
	__arch__swab16s(addr);
}

unsigned int __fswab32(unsigned int x)
{
	return __arch__swab32(x);
}

unsigned int __swab32p(unsigned int *x)
{
	return __arch__swab32p(x);
}

void __swab32s(unsigned int *addr)
{
	__arch__swab32s(addr);
}

/**
unsigned long long __fswab64(unsigned long long x)
{

	unsigned int h = x >> 32;
    unsigned int l = x & ((1ULL<<32)-1);

        return (((unsigned long long)__swab32(l)) << 32) | ((unsigned long long)(__swab32(h)));
}
**/
/**
unsigned long long __swab64p(unsigned long long *x)
{
	return __arch__swab64p(x);
}
**/
/**
void __swab64s(unsigned long long *addr)
{
	__arch__swab64s(addr);
}
**/
////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

