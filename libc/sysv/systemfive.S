/*-*- mode:unix-assembly; indent-tabs-mode:t; tab-width:8; coding:utf-8     -*-│
│vi: set et ft=asm ts=8 sw=8 fenc=utf-8                                     :vi│
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
#include "libc/calls/strace.internal.h"
#include "libc/dce.h"
#include "libc/macros.internal.h"
#include "libc/nexgen32e/macros.h"
#include "libc/sysv/consts/nr.h"

/*                                           ▄▄▄
                       ▄▄▄                    ▀▓▓▒▄
                     ▄▓▒▒░                      ▀▓▒▒▒▄
                   ▄▓▓▓▒▀              ▄▄▄▄      ▒▓▒▒░▒▄
                  ▄▓▓▓▒▓        ▄▄▓██▓▓▓▓▒▒▒▒▓▓▄▄▓▓▒▒▒░░▒
                  ▓▓▓▓▒▒▒▄▄  ░▒█▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒░░▒░
                  ██▓▓▓▒▒░░▒▒▒▒▓▓▓▓▓▓▒▓▒░▒▒░▀▒▒▒▒░▀░▒▒▒░▒
                  ▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▓▓▒▒▒░▒▒░░  ░▒▒░  ░▒▒▒▒
                   ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒░░    ░▒▒  ░ ▀▒▒
                     ▀▓▓█▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒░░   ░░░▓░ ▓░░░▒
                       ▀▀█▓███▓▓▓▓▓▒▒░░░▒░░  ░█▓░█▓░█▓▓▄▒░
                          ░▓██▓▓▓▓▓▒▒░░░▒░░  ░████▓▒▓█▓▀░▀▄
                          ░▓██▓▓▓▓▓▒▒▒░░░▒░░  ▒██▓▒▒▒▒▒▒░░░▒
                           ████▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░▒▓▓▒░░░░▒░░░▒░ ░░░░░
                           ░▓███▓▓▓▓▓▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░ ░░░░░   ░
                             ▓███▓▓▓▓▓▒▓▒▒▒▒░░░░░░░░░▒▓▒▒░▀ ░░░  ░░░░░
                              ▀▒██▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▀▀░    ░░░░░░░░░     ░
                                 ▓▓▓▓▓▓▓▒▓▒▒▒▒▓▓▓▒▀░ ░░░░░▄░░░  ░░░  ░░░░░░
                                 ▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓     █▓▒░░▒░░░░ ░░░░░░░░
                                ▄▓▓▓▒▒▒▒▒░░░░░░░▒▄▄▄░▒▓▓▒▒░▀░
                               ░▓█▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒░░░▒  besiyata
                               ▓▓█▓▓▒▓▓▓▒▒▒░░░░░░▒▓▓▓▓▒▒▒▒▒░   dishmaya
                               ▓▓█▓▓▓▓▓▓▒▒▒░░░░░░░▒▓▓▒▀▀▀
                               ▓▓██▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▀
                                █▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀
                               ▒▓▓▓▓▀░░▒▓▓▓▓▓▓▓▓▒▒░░▒
                              ▄▓▓▀░░░▄▓▓▓▓▒▒▒▒▒░░░░▄░
                             ▄███▄▄▓▓▓▓▓▓▓▒▒▒▒▒░░▒▒░
                           ▄▓▓▓█▓█▓▓███▓▓▓▓▓▓▓▓▓▓▓░
                       ▄░▓▓▓▓▓▓▀▒▓▓▓▒▒▓▒░░░▒▓▒░░░▓
               ▄▄▄░▒▓▓▓▓▓▓░▀▀   ▓▓▒░▓▒▒▒▒▒▒▒▒▒▒▄░░▀▀░░ ▄▄▄▄
     ▄▄▄▒▒▓▓█▓▓▓▓▓▀▀▀▀▀        ▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▀░░▀░░▒▒▒░░░   ░░░░░
  ▄▓▓▓▒▀▀                      ▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▓░░░       ▒▒▒░░░░░░░░▒
  █▓▓▒      ▄▄▄                  ▀▓▒▓▒▒▒▓▓▓▓▓▓▒▒▒░░░░░░░░░▒▒░░░░░░░
   ▀▓▓▓▓▒▄▄▒▒▒▒▒▒▄▄                    ▀▀▀▀░░▒▒▒▒░░░░░░
       ▀▀▀▓▓▓▓▒▒▒▒▒▓▓▄▄
╔────────────────────────────────────────────────────────────────────────────│─╗
│ cosmopolitan § bell system five » system call support                    ─╬─│┼
╚────────────────────────────────────────────────────────────────────────────│*/

	.initbss 300,_init_systemfive
__hostos:
	.quad	0
	.endobj	__hostos,globl,hidden

//	Performs System Five System Call.
//
//	Cosmopolitan is designed to delegate all function calls into the
//	Linux, FreeBSD, OpenBSD, and XNU kernels via this function, with
//	few exceptions. This function should generally only be called by
//	generated thunks in the libc/sysv/syscalls/ directory.
//
//	It's safe to call this function on Windows, where it will always
//	return -1 with errno == ENOSYS. Further note that -1 is the only
//	return value that means error, a common anti-pattern is to check
//	for values less than 0 (which is more problematic on 32-bit).
//
//	It is important to consider that system calls are one order of a
//	magnitude more expensive than normal function calls. For example
//	getpid() on Linux usually takes 500ns, and cached i/o calls will
//	take 1µs or more. So we don't need to inline them like Chromium.
//
//	Another thing to consider is that BSDs only loosely follow the
//	System Five ABI for the SYSCALL instruction. For example Linux
//	always follows the six argument limit but the FreeBSD sendfile
//	system call accepts a seventh argument that is passed on stack
//	and OpenBSD modifies functions like mmap so that the sixth arg
//	is passed on the stack. There's also the carry flag convention
//	that XNU, FreeBSD, and OpenBSD inherited from 386BSD aka Jolix
//
//	@param	%rax function ordinal supplied by jump slot
//	@param	%rdi,%rsi,%rdx,%rcx,%r8,%r9 and rest on stack
//	@return	%rax:%rdx is result, or -1 w/ errno on error
//	@clob	%rcx,%r10,%r11
//	@see	syscalls.sh
__systemfive:
	.quad	0
	.endobj	__systemfive,globl,hidden
__pid:	.quad	0
	.endobj	__pid,globl,hidden
	.previous

	.privileged
.Lanchorpoint:
#if SupportsLinux() || SupportsMetal()
systemfive_linux:
	and	$0xfff,%eax
	cmp	$0xfff,%eax
	je	systemfive_enosys	# never taken branches cost nothing
	mov	%rcx,%r10		# syscall instruction clobbers %rcx
	push	%rbp			# linux never reads args from stack
	mov	%rsp,%rbp		# having frame will help backtraces
	syscall				# this is known as a context switch
	pop	%rbp			# next we check to see if it failed
	cmp	$-4095,%rax		# system five nexgen32e abi § a.2.1
	jae	systemfive_error	# encodes errno as neg return value
	ret
	.endfn	systemfive_linux,globl,hidden
systemfive_error:
	neg	%eax
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	systemfive_error,globl,hidden
#endif
systemfive_errno:
	xchg	%eax,%ecx
	.errno
	mov	%ecx,(%rax)		# normalize to c library convention
	push	$-1			# negative one is only error result
	pop	%rax			# the push pop is to save code size
	ret
	.endfn	systemfive_errno,globl,hidden
systemfive_enosys:
	mov	ENOSYS(%rip),%eax
	jmp	systemfive_errno
	.endfn	systemfive_enosys,globl,hidden
#if SupportsNetbsd()
systemfive_netbsd:
	shr	$4*13,%rax
	jmp	systemfive_bsdscrub
	.endfn	systemfive_netbsd,globl,hidden
#endif
#if SupportsOpenbsd()
systemfive_openbsd:
	shr	$4*10,%rax
	jmp	systemfive_bsdscrub
	.endfn	systemfive_openbsd,globl,hidden
#endif
#if SupportsFreebsd()
systemfive_freebsd:
	shr	$4*7,%rax
	movzwl	%ax,%eax
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	systemfive_freebsd,globl,hidden
#endif
#if SupportsBsd()
systemfive_bsdscrub:
	and	$0xfff,%eax
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	systemfive_bsdscrub,globl,hidden
systemfive_bsd:
	cmp	$0xfff,%ax
	je	systemfive_enosys
	mov	%rcx,%r10
	push	%rbx
	push	32(%rsp)
	push	24(%rsp)
	push	16(%rsp)
	mov	%rax,%rbx		# save ordinal for SIGSYS crash report
	syscall				# bsd will need arg on stack sometimes
	pop	%rbx
	pop	%rbx
	pop	%rbx
	pop	%rbx
	jc	systemfive_errno	# bsd sets carry flag if %rax is errno
	ret
	.endfn	systemfive_bsd
#endif
#if SupportsXnu()
systemfive_xnu:
//	0x?????????2153???		# how syscalls.sh encodes xnu ordinals
//	           │└┴┴┐
//	           │   ├┬┐
//	0x0000000002000153		# how xnu wants ordinals to be encoded
	mov	%eax,%r11d
	and	$0x0f000000,%r11d
	shl	$8,%eax
	shr	$20,%eax
	or	%r11d,%eax
	jmp	systemfive_bsd
	.endfn	systemfive_xnu,globl,hidden
#endif
	.previous

//	Initializes System Five system call support.
//
//	  (1) Extracts parameters passed by kernel
//	  (2) Detects OS without issuing system calls
//	  (3) Unpacks magnums from libc/sysv/consts.sh
//	  (4) Replaces stack with one we control
//
//	@param	%r15 is auxv
//	@note	OpenBSD devs: let us know if you start using auxv
	.init.start 300,_init_systemfive
	push	%rbx
	push	%rsi
//	Detect the operating system.
	mov	(%rdi),%eax			# __hostos
#if SupportsWindows() || SupportsXnu() || SupportsFreebsd()
//	set by	libc/ape.S		for XNU
//	set by	libc/crt/crt.S		for XNU/FreeBSD
//	set by	libc/nt/winmain.greg.c	for New Technology
	test	%eax,%eax
	jnz	_init_systemfive_detected	# os is already known
#endif
#if SupportsOpenbsd()
	cmpq	$0,(%r15)			# OpenBSD has no auxv
	jnz	0f
	mov	$OPENBSD,%al
	jmp	_init_systemfive_detected
0:
#endif
#if SupportsNetbsd()
	xor	%ecx,%ecx
0:	cmpq	$2014,(%r15,%rcx,8)		# NetBSD's AT_EXECFN
	jne	1f
	mov	$NETBSD,%al
	jmp	_init_systemfive_detected
1:	cmpq	$0,(%r15,%rcx,8)
	lea	2(%ecx),%ecx
	jnz	0b
2:
#endif
	mov	$LINUX,%al
_init_systemfive_detected:
	stosq	#→ __hostos
	bsr	%eax,%eax
	mov	$_init_systemfive_jmptab,%ebx
	movzbl	(%rbx,%rax),%eax
	lea	(%rbx,%rax),%eax
	jmp	*%rax
_init_systemfive_jmptab:
	.byte	_init_systemfive_linux-_init_systemfive_jmptab
	.byte	_init_systemfive_metal-_init_systemfive_jmptab
	.byte	_init_systemfive_windows-_init_systemfive_jmptab
	.byte	_init_systemfive_xnu-_init_systemfive_jmptab
	.byte	_init_systemfive_openbsd-_init_systemfive_jmptab
	.byte	_init_systemfive_freebsd-_init_systemfive_jmptab
	.byte	_init_systemfive_netbsd-_init_systemfive_jmptab
	.endobj	_init_systemfive_jmptab
_init_systemfive_linux:
#if SupportsLinux()
	pushb	systemfive_linux-.Lanchorpoint
	mov	$syscon_linux,%esi
	jmp	_init_systemfive_os
#endif
	.endfn	_init_systemfive_linux
_init_systemfive_metal:
#if SupportsMetal()
	pushb	systemfive_enosys-.Lanchorpoint
	mov	$syscon_linux,%esi
	jmp	_init_systemfive_os
#endif
	.endfn	_init_systemfive_metal
_init_systemfive_windows:
#if SupportsWindows()
	pushb	systemfive_enosys-.Lanchorpoint
	mov	$syscon_windows,%esi
	jmp	_init_systemfive_os
#endif
	.endfn	_init_systemfive_windows
_init_systemfive_xnu:
#if SupportsXnu()
	pushb	systemfive_xnu-.Lanchorpoint
	mov	$syscon_xnu,%esi
	jmp	_init_systemfive_os
#endif
	.endfn	_init_systemfive_xnu
_init_systemfive_openbsd:
#if SupportsOpenbsd()
	pushb	systemfive_openbsd-.Lanchorpoint
	mov	$syscon_openbsd,%esi
	jmp	_init_systemfive_os
#endif
	.endfn	_init_systemfive_openbsd
_init_systemfive_freebsd:
#if SupportsFreebsd()
	pushb	systemfive_freebsd-.Lanchorpoint
	mov	$syscon_freebsd,%esi
	jmp	_init_systemfive_os
#endif
	.endfn	_init_systemfive_freebsd
_init_systemfive_netbsd:
#if SupportsNetbsd()
	pushb	systemfive_netbsd-.Lanchorpoint
	mov	$syscon_netbsd,%esi
//	𝑠𝑙𝑖𝑑𝑒
#endif
	.endfn	_init_systemfive_netbsd
_init_systemfive_os:
	pop	%rax
	add	$.Lanchorpoint,%eax
	stosq	#→ __systemfive
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	_init_systemfive_os
_init_systemfive_magnums:
	push	%rdi
	mov	$syscon_start,%edi
2:	cmp	$syscon_end,%edi
	jnb	5f
	xor	%ebx,%ebx
	xor	%ecx,%ecx
	xor	%edx,%edx
3:	lodsb						# decodes uleb128
	movzbl	%al,%edx
	and	$127,%dl
	shl	%cl,%rdx
	or	%rdx,%rbx
	add	$7,%cl
	test	$128,%al
	jnz	3b
	xchg	%rbx,%rax
	stosq
#ifdef SYSDEBUG
	inc	%r8d
#endif
	jmp	2b
5:	nop
#ifdef SYSDEBUG
	push	%rdi
	push	%rsi
	push	%r8
	call	__describe_os
	mov	%rax,%rdx
	pop	%r8
	.weak	__stracef
	ezlea	__stracef,ax
	test	%rax,%rax
	jz	5f
	ezlea	.Llog,di
	mov	%r8d,%esi
	call	*%rax
5:	pop	%rsi
	pop	%rdi
#endif /* DEBUGSYS */
	pop	%rdi
	pop	%rsi
	pop	%rbx
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	_init_systemfive_magnums
#if SupportsSystemv()
_init_systemfive_pid:
	ezlea	__hostos,cx
	mov	(%rcx),%al
	mov	(%rdi),%eax
	testb	$WINDOWS|METAL,(%rcx)
	jnz	1f
	mov	__NR_getpid,%eax
	syscall
1:	stosq
	.endfn	_init_systemfive_pid
#endif
#if SupportsSystemv() && !defined(TINY)
_init_systemfive_syscall:
	mov	__NR_msyscall,%eax			# syscall origin protect
	cmp	$0xfff,%ax				# openbsd is pretty cool
	jae	_init_systemfive_done
	push	%rdi
	push	%rsi
	.weak	__privileged_addr
	.weak	__privileged_size
	mov	$__privileged_addr,%edi
	mov	$__privileged_size,%esi
	syscall
	pop	%rsi
	pop	%rdi
//	𝑠𝑙𝑖𝑑𝑒
#endif /* TINY */
_init_systemfive_done:
	nop
	.init.end 300,_init_systemfive,globl,hidden

//	Sections for varint encoded magic numbers.
//
//	These sections are all ordered by (group_name, constant_name).
//	They're populated by modules simply referencing the symbols.
//
//	@see libc/sysv/consts.sh
//	@see libc/sysv/consts/syscon_h
	.section .piro.bss.sort.syscon.1,"aw",@nobits
	.align	8
syscon_start:/*
	...decentralized quadwords...
	*/.previous
	.section .piro.bss.sort.syscon.3,"aw",@nobits
syscon_end:
	.previous
	.type	syscon_start,@object
	.type	syscon_end,@object
	.globl	syscon_start
	.globl	syscon_end
#if SupportsLinux() || SupportsMetal()
	.section .sort.rodata.syscon.linux.1,"a",@progbits
	.align	1
syscon_linux:/*
	...decentralized leb128...
	*/.previous
	.type	syscon_linux,@object
	.globl	syscon_linux
#endif
#if SupportsXnu()
	.section .sort.rodata.syscon.xnu.1,"a",@progbits
	.align	1
syscon_xnu:/*
	...decentralized leb128...
	*/.previous
	.type	syscon_xnu,@object
	.globl	syscon_xnu
#endif
#if SupportsFreebsd()
	.section .sort.rodata.syscon.freebsd.1,"a",@progbits
	.align	1
syscon_freebsd:/*
	...decentralized leb128...
	*/.previous
	.type	syscon_freebsd,@object
	.globl	syscon_freebsd
#endif
#if SupportsOpenbsd()
	.section .sort.rodata.syscon.openbsd.1,"a",@progbits
	.align	1
syscon_openbsd:/*
	...decentralized leb128...
	*/.previous
	.type	syscon_openbsd,@object
	.globl	syscon_openbsd
#endif
#if SupportsNetbsd()
	.section .sort.rodata.syscon.netbsd.1,"a",@progbits
	.align	1
syscon_netbsd:/*
	...decentralized leb128...
	*/.previous
	.type	syscon_netbsd,@object
	.globl	syscon_netbsd
#endif
#if SupportsWindows()
	.section .sort.rodata.syscon.windows.1,"a",@progbits
	.align	1
syscon_windows:/*
	...decentralized leb128...
	*/.previous
	.type	syscon_windows,@object
	.globl	syscon_windows
#endif

#ifdef SYSDEBUG
	.rodata.str1.1
.Llog:	.ascii	STRACE_PROLOGUE
	.ascii	"bell system five system call support"
	.asciz	" %'u magnums loaded on %s\n"
	.previous
#endif /* DEBUGSYS */
