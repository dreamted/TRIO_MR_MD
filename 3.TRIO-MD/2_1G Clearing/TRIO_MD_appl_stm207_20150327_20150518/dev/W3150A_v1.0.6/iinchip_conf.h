#ifndef	_IINCHIP_CONF_H_
#define	_IINCHIP_CONF_H_

#define LITTLE_ENDIAN	//  This must be defined if system is little-endian alignment

/**
* __DEF_IINCHIP_xxx__ : define option for iinchip driver
*/
//#define __DEF_IINCHIP_DBG__ /* involve debug code in driver (socket.c) */
//#define __DEF_IINCHIP_INT__ /* involve interrupt service routine (socket.c) */
//#define __DEF_IINCHIP_PPP__ /* involve pppoe routine (socket.c) */
                            /* If it is defined, the source files(md5.h,md5.c) must be included in your project.
                               Otherwize, the source files must be removed in your project. */

#define __DEF_IINCHIP_DIRECT_MODE__ 	1
#define __DEF_IINCHIP_INDIRECT_MODE__ 	2
#define __DEF_IINCHIP_SPI_MODE__ 		3
//#define __DEF_IINCHIP_BUS__ __DEF_IINCHIP_DIRECT_MODE__
//#define __DEF_IINCHIP_BUS__ __DEF_IINCHIP_INDIRECT_MODE__
#define __DEF_IINCHIP_BUS__ __DEF_IINCHIP_SPI_MODE__ /*Enable SPI_mode*/


/**
* __DEF_IINCHIP_MAP_xxx__ : define memory map for iinchip 
*/
#define __DEF_IINCHIP_MAP_BASE__ 	0x8000
#if (__DEF_IINCHIP_BUS__ == __DEF_IINCHIP_DIRECT_MODE__)
 #define COMMON_BASE __DEF_IINCHIP_MAP_BASE__
#else
 #define COMMON_BASE 	0x0000
#endif
#define __DEF_IINCHIP_MAP_TXBUF__ (COMMON_BASE + 0x4000) /* Internal Tx buffer address of the iinchip */
#define __DEF_IINCHIP_MAP_RXBUF__ (COMMON_BASE + 0x6000) /* Internal Rx buffer address of the iinchip */

/**
* __DEF_MCU_xxx__ : define option related to MCU
*/
//#define __DEF_MCU_AVR__	//optimized to ATmega128

#ifdef __DEF_MCU_AVR__
   #include <stdio.h>
   #include <string.h>
   #include <avr/interrupt.h>
   #include <avr/io.h>

   #ifdef __DEF_IINCHIP_INT__
      // iinchip use external interrupt 4
      #define IINCHIP_ISR_DISABLE(nUSE)		(EIMSK &= ~(0x10))
      #define IINCHIP_ISR_ENABLE(nUSE)		(EIMSK |= 0x10)
      #define IINCHIP_ISR_GET(nUSE,X)		(X = EIMSK)
      #define IINCHIP_ISR_SET(nUSE,X)		(EIMSK = X)
   #else
      #define IINCHIP_ISR_DISABLE(nUSE)
      #define IINCHIP_ISR_ENABLE(nUSE)	
      #define IINCHIP_ISR_GET(nUSE,X)
      #define IINCHIP_ISR_SET(nUSE,X)
   #endif
#else
	#define IINCHIP_ISR_DISABLE(nUSE)
	#define IINCHIP_ISR_ENABLE(nUSE)  
	#define IINCHIP_ISR_GET(nUSE,X)
	#define IINCHIP_ISR_SET(nUSEX)
	
#endif

#endif
