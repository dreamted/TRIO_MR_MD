/**
 * support MD5 for PPPoE CHAP mode
 */

#ifndef __MD5_H
#define __MD5_H

#include "types.h"

/* MD5 context. */
typedef struct {
        uint32 state[4];    /* state (ABCD)                            */
        uint32 count[2];    /* number of bits, modulo 2^64 (lsb first) */
        uint8  buffer[64];  /* input buffer                            */
      } md5_ctx;

uint32 FF(uint32 a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);
uint32 GG(uint32 a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);
uint32 HH(uint32 a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);
uint32 II(uint32 a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);

extern void md5_init(md5_ctx *context);
extern void md5_update(md5_ctx *context, uint8 *buffer, uint32 length);
extern void md5_final(uint8 result[16], md5_ctx *context);

#endif	// __md5_H
