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

//	Allocates aligned memory the C++ way.
//
//	\param	%rdi is bytes to allocate
//	\param	%rsi is byte alignment
//	\param	%rdx is ignored
//	\return	new memory or NULL on OOM
_ZnamSt11align_val_tRKSt9nothrow_t:
//	operator new[](unsigned long, std::align_val_t, std::nothrow_t const&)
	nop
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	_ZnamSt11align_val_tRKSt9nothrow_t,weak
_ZnwmSt11align_val_tRKSt9nothrow_t:
//	operator new(unsigned long, std::align_val_t, std::nothrow_t const&)
	nop
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	_ZnwmSt11align_val_tRKSt9nothrow_t,weak
_ZnwmSt11align_val_t:
//	operator new(unsigned long, std::align_val_t)
	nop
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	_ZnwmSt11align_val_t,weak
_ZnamSt11align_val_t:
//	operator new[](unsigned long, std::align_val_t)
	test	%rdi,%rdi
	jnz	1f
	mov	$1,%eax
1:	mov	$__BIGGEST_ALIGNMENT__,%eax
	cmp	%rax,%rsi
	cmovb	%rax,%rsi
	xchg	%rdi,%rsi
	jmp	*hook_memalign(%rip)
	.endfn	_ZnamSt11align_val_t,weak
