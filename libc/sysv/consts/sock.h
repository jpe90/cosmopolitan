#ifndef COSMOPOLITAN_LIBC_SYSV_CONSTS_SOCK_H_
#define COSMOPOLITAN_LIBC_SYSV_CONSTS_SOCK_H_
#include "libc/runtime/symbolic.h"
#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

extern const int SOCK_CLOEXEC;
extern const int SOCK_DCCP;
extern const int SOCK_DGRAM;
extern const int SOCK_NONBLOCK;
extern const int SOCK_PACKET;
extern const int SOCK_RAW;
extern const int SOCK_RDM;
extern const int SOCK_SEQPACKET;
extern const int SOCK_STREAM;

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */

#define SOCK_CLOEXEC SYMBOLIC(SOCK_CLOEXEC)
#define SOCK_DCCP SYMBOLIC(SOCK_DCCP)
#define SOCK_DGRAM LITERALLY(2)
#define SOCK_NONBLOCK SYMBOLIC(SOCK_NONBLOCK)
#define SOCK_PACKET SYMBOLIC(SOCK_PACKET)
#define SOCK_RAW LITERALLY(3)
#define SOCK_RDM LITERALLY(4)
#define SOCK_SEQPACKET LITERALLY(5)
#define SOCK_STREAM LITERALLY(1)

#endif /* COSMOPOLITAN_LIBC_SYSV_CONSTS_SOCK_H_ */
