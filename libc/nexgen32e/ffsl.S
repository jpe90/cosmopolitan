/*-*- mode:unix-assembly; indent-tabs-mode:t; tab-width:8; coding:utf-8     -*-│
│vi: set et ft=asm ts=8 tw=8 fenc=utf-8                                     :vi│
╞══════════════════════════════════════════════════════════════════════════════╡
│ Copyright 2020 Justine Alexandra Roberts Tunney                              │
│                                                                              │
│ Permission to use, copy, modify, and/or distribute this software for         │
│ any purpose with or without fee is hereby granted, provided that the         │
│ above copyright notice and this permission notice appear in all copies.      │
│                                                                              │
│ THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL                │
│ WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED                │
│ WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE             │
│ AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL         │
│ DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR        │
│ PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER               │
│ TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR             │
│ PERFORMANCE OF THIS SOFTWARE.                                                │
╚─────────────────────────────────────────────────────────────────────────────*/
#include "libc/macros.internal.h"

//	Finds lowest set bit in word.
//
//	      uint32 𝑥   bsf(𝑥) tzcnt(𝑥)   ffs(𝑥)   bsr(𝑥) lzcnt(𝑥)
//	    0x00000000      wut       32        0      wut       32
//	    0x00000001        0        0        1        0       31
//	    0x80000001        0        0        1       31        0
//	    0x80000000       31       31       32       31        0
//	    0x00000010        4        4        5        4       27
//	    0x08000010        4        4        5       27        4
//	    0x08000000       27       27       28       27        4
//	    0xffffffff        0        0        1       31        0
//
//	@param	rdi is the input number
//	@return	number in range [1,64] or 0 if no bits set
//	@see	also treasure trove of nearly identical functions
//	@asyncsignalsafe
ffsl:	.leafprologue
	.profilable
	or	$-1,%edx
	bsf	%rdi,%rax
	cmovz	%edx,%eax
	inc	%eax
	.leafepilogue
	.endfn	ffsl,globl
	.alias	ffsl,ffsll
