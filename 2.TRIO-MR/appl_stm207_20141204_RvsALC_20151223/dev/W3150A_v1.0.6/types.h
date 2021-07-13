#ifndef _TYPE_H_
#define _TYPE_H_

typedef char int8;				 		// The 8-bit signed data type.
typedef volatile char vint8;			// The volatile 8-bit signed data type.
typedef unsigned char uint8;			// The 8-bit unsigned data type.
typedef volatile unsigned char vuint8;	// The volatile 8-bit unsigned data type.
typedef short int int16;				// The 16-bit signed data type.
typedef volatile short int vint16;		// The volatile 16-bit signed data type.
typedef unsigned short int uint16;		// The 16-bit unsigned data type.
typedef volatile unsigned int vuint16;	// The volatile 16-bit unsigned data type.
typedef long int32;						// The 32-bit signed data type.
typedef volatile long vint32;			// The volatile 32-bit signed data type.
typedef unsigned long uint32;			// The 32-bit unsigned data type.
typedef volatile unsigned long vuint32;	// The volatile 32-bit unsigned data type.

typedef uint8			u_char;		/* 8-bit value */
typedef uint8 			SOCKET;
typedef uint16			u_short;	/* 16-bit value */
typedef uint16			u_int;		/* 16-bit value */
typedef uint32			u_long;		/* 32-bit value */

typedef union _un_l2cval {
	u_long	lVal;
	u_char	cVal[4];
}un_l2cval;

typedef union _un_i2cval {
	u_int	iVal;
	u_char	cVal[2];
}un_i2cval;

#endif		/* _TYPE_H_ */
////////////////////////////////////////////////////////////////////////////////
// End of Header file

