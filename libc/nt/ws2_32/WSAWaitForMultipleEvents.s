.include "o/libc/nt/codegen.inc"
.imp	ws2_32,__imp_WSAWaitForMultipleEvents,WSAWaitForMultipleEvents,124

	.text.windows
__WSAWaitForMultipleEvents:
	push	%rbp
	mov	%rsp,%rbp
	.profilable
	mov	__imp_WSAWaitForMultipleEvents(%rip),%rax
	jmp	__sysv2nt6
	.endfn	__WSAWaitForMultipleEvents,globl
	.previous
