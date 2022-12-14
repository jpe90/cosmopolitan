#ifndef COSMOPOLITAN_LIBC_SYSV_CONSTS_TCPOPT_H_
#define COSMOPOLITAN_LIBC_SYSV_CONSTS_TCPOPT_H_

#define TCPOPT_EOL            0
#define TCPOPT_NOP            1
#define TCPOPT_MAXSEG         2
#define TCPOPT_WINDOW         3
#define TCPOPT_SACK_PERMITTED 4
#define TCPOPT_SACK           5
#define TCPOPT_TIMESTAMP      8

#define TCPOLEN_SACK_PERMITTED 2
#define TCPOLEN_WINDOW         3
#define TCPOLEN_MAXSEG         4
#define TCPOLEN_TIMESTAMP      10

#endif /* COSMOPOLITAN_LIBC_SYSV_CONSTS_TCPOPT_H_ */
