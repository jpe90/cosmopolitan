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
#include "libc/dce.h"
#include "libc/macros.internal.h"
#include "libc/sysv/consts/nr.h"
#include "libc/sysv/consts/madv.h"

	.rodata.cst4
kCombiningCharsBits:
	.long	114752 * 8
	.endobj	kCombiningCharsBits,globl,hidden
	.previous

	.initbss 400,_init_kCombiningChars
kCombiningChars:
	.zero	114752
	.endobj	kCombiningChars,globl,hidden
	.previous

	.init.start 400,_init_kCombiningChars
	push	%rsi
	mov	$1203,%edx
	call	lz4cpy
	mov	%rax,%rdi
	pop	%rsi
	add	$1208,%rsi
	.init.end 400,_init_kCombiningChars

//	o/tool/build/lz4toasm.com
//	  -o o/libc/str/CombiningChars.s
//	  -s kCombiningChars
//	  o/libc/str/CombiningChars.bin.lz4
	.initro 400,_init_kCombiningChars
kCombiningCharsLz4:
	.byte	0x1f,0x00,0x01,0x00,0x4c,0x19,0xff,0x01	#▼ ☺ L↓λ☺
	.byte	0x00,0x0f,0x30,0x00,0x0f,0x2f,0xf8,0x03	# ☼0 ☼/°♥
	.byte	0x22,0x00,0x0d,0x10,0xfe,0x49,0x00,0x23	#. ♪►■I .
	.byte	0xbf,0xb6,0x0e,0x00,0x42,0x3f,0x00,0xff	#┐╢♫ B⁇ λ
	.byte	0x17,0x39,0x00,0x00,0x5e,0x00,0x17,0x01	#↨9  ^ ↨☺
	.byte	0x28,0x00,0x92,0xc0,0xbf,0x9f,0x3d,0x00	#( Æ└┐ƒ= 
	.byte	0x00,0x00,0x80,0x02,0x86,0x00,0x17,0x07	#  Ç☻å ↨•
	.byte	0x1a,0x00,0x13,0xff,0x28,0x00,0x91,0xf8	#→ ‼λ( æ°
	.byte	0x0f,0x20,0x00,0x00,0xc0,0xfb,0xef,0x3e	#☼   └√∩>
	.byte	0x0e,0x00,0x1b,0x0e,0x8a,0x00,0x26,0xff	#♫ ←♫è &λ
	.byte	0xff,0x37,0x00,0xa2,0x14,0xfe,0x21,0xfe	#λ7 ó¶■!■
	.byte	0x00,0x0c,0x00,0x00,0x00,0x02,0x10,0x00	# ♀   ☻► 
	.byte	0x40,0x10,0x1e,0x20,0x00,0x10,0x00,0x23	#@►▲  ► .
	.byte	0x40,0x06,0x10,0x00,0x20,0x86,0x39,0x1a	#@♠►  å9→
	.byte	0x00,0x24,0x23,0x00,0x10,0x00,0x21,0xbe	# $. ► !╛
	.byte	0x21,0x20,0x00,0x13,0xfc,0x30,0x00,0x41	#!  ‼ⁿ0 A
	.byte	0x90,0x1e,0x20,0x40,0x40,0x00,0x13,0x04	#É▲ @@ ‼♦
	.byte	0x5e,0x00,0x22,0x01,0x20,0x08,0x00,0x13	#^ .☺ ◘ ‼
	.byte	0x11,0x93,0x00,0x38,0xc1,0x3d,0x60,0x60	#◄ô 8┴=``
	.byte	0x00,0x31,0x90,0x40,0x30,0x40,0x00,0x13	# 1É@0@ ‼
	.byte	0x00,0x0f,0x01,0x13,0x18,0x70,0x00,0x06	# ☼☺‼↑p ♠
	.byte	0x9f,0x00,0x27,0x04,0x5c,0x0d,0x00,0x48	#ƒ ‘♦\♪ H
	.byte	0xf2,0x07,0x80,0x7f,0x1d,0x00,0x45,0xf2	#≥•Ç⌂↔ E≥
	.byte	0x1f,0x00,0x3f,0x0d,0x00,0x43,0x03,0x00	#▼ ⁇♪ C♥ 
	.byte	0x00,0xa0,0x57,0x00,0x50,0xfe,0x7f,0xdf	# áW P■⌂▀
	.byte	0xe0,0xff,0x41,0x01,0x28,0x1f,0x40,0x2f	#αλA☺(▼@/
	.byte	0x00,0xff,0x00,0xe0,0xfd,0x66,0x00,0x00	# λ α²f  
	.byte	0x00,0xc3,0x01,0x00,0x1e,0x00,0x64,0x20	# ├☺ ▲ d
	.byte	0x00,0x20,0xcc,0x01,0x0b,0x0f,0xd2,0x01	#  ╠☺♂☼╥☺
	.byte	0x1d,0x06,0x66,0x00,0x1f,0x00,0x01,0x00	#↔♠f ▼ ☺ 
	.byte	0x62,0x13,0x1c,0x04,0x00,0x26,0x0c,0x00	#b‼∟♦ &♀ 
	.byte	0x42,0x01,0x52,0xb0,0x3f,0x40,0xfe,0x0f	#B☺R░⁇@■☼
	.byte	0xe8,0x00,0x1a,0x78,0x2e,0x00,0x26,0x60	#Φ →x. &`
	.byte	0x00,0x85,0x01,0x04,0x14,0x00,0x4f,0x87	# à☺♦¶ Oç
	.byte	0x01,0x04,0x0e,0x60,0x00,0x07,0x22,0x80	#☺♦♫` •.Ç
	.byte	0x09,0x08,0x00,0x63,0x40,0x7f,0xe5,0x1f	#○◘ c@⌂σ▼
	.byte	0xf8,0x9f,0x2a,0x01,0x05,0x8e,0x01,0x11	#°ƒ*☺♣Ä☺◄
	.byte	0x0f,0x06,0x00,0x32,0xd0,0x17,0x04,0x70	#☼♠ 2╨↨♦p
	.byte	0x02,0x01,0xd0,0x01,0x23,0x3c,0x3b,0x32	#☻☺╨☺.<;2
	.byte	0x00,0x13,0xa3,0xde,0x01,0x2f,0xf0,0xcf	# ‼ú▐☺/≡╧
	.byte	0x58,0x00,0x00,0x6f,0xf7,0xff,0xfd,0x21	#X  o≈λ²!
	.byte	0x10,0x03,0x8c,0x01,0x0c,0x1f,0xfb,0x1f	#►♥î☺♀▼√▼
	.byte	0x01,0x2e,0x52,0xf8,0x00,0x00,0x00,0x7c	#☺.R°   |
	.byte	0x0b,0x00,0x2c,0xdf,0xff,0x62,0x00,0x2f	#♂ ,▀λb /
	.byte	0x01,0x00,0x01,0x00,0xff,0x6b,0x1d,0x80	#☺ ☺ λk↔Ç
	.byte	0xff,0x01,0x1c,0x80,0xa2,0x01,0x0f,0x68	#λ☺∟Çó☺☼h
	.byte	0x00,0x32,0x19,0x3c,0x0e,0x00,0x2f,0x06	# 2↓<♫ /♠
	.byte	0x00,0x01,0x00,0xff,0xff,0xff,0xff,0xff	# ☺ λλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xb3,0x20,0x80,0xf7,0xf6,0x12,0x28	#λ│ Ç≈÷↕(
	.byte	0xc0,0x00,0xfb,0x12,0x0f,0x33,0x00,0x0c	#└ √↕☼3 ♀
	.byte	0x23,0x44,0x08,0xf4,0x11,0x0b,0x18,0x00	#.D◘⌠◄♂↑ 
	.byte	0x11,0x30,0x60,0x0f,0x11,0x03,0x70,0x0f	#◄0`☼◄♥p☼
	.byte	0x62,0xc0,0x3f,0x00,0x00,0x80,0xff,0x4c	#b└⁇  ÇλL
	.byte	0x00,0x02,0x10,0x14,0x20,0xc8,0x33,0x06	# ☻►¶ ╚3♠
	.byte	0x00,0x05,0x29,0x13,0x52,0x7e,0x66,0x00	# ♣)‼R~f 
	.byte	0x08,0x10,0xf8,0x13,0x02,0x11,0x00,0x21	#◘►°‼☻◄ !
	.byte	0x9d,0xc1,0x43,0x12,0x2f,0x30,0x40,0x7c	#¥┴C↕/0@|
	.byte	0x00,0x0a,0x2f,0x20,0x21,0x96,0x0a,0xff	# ◙/ !û◙λ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xdb,0x1f,0x40,0x60,0x1f,0x4b,0x2f,0x00	#█▼@`▼K/ 
	.byte	0x00,0x06,0x1a,0x08,0x1f,0x80,0x3f,0x00	# ♠→◘▼Ç⁇ 
	.byte	0x0c,0x1f,0x0e,0x7f,0x00,0x2c,0x1f,0x20	#♀▼♫⌂ ,▼
	.byte	0x1d,0x00,0x09,0x0e,0x3e,0x1c,0x2f,0xc0	#↔ ○♫>∟/└
	.byte	0x07,0xdd,0x01,0xbd,0x22,0x6e,0xf0,0x23	#•▌☺╜.n≡.
	.byte	0x1e,0x0f,0x1c,0x00,0x01,0x1f,0x60,0x64	#▲☼∟ ☺▼`d
	.byte	0x00,0x34,0x1f,0xf0,0x44,0x00,0x30,0x05	# 4▼≡D 0♣
	.byte	0xf4,0x20,0x0b,0x18,0x00,0x1a,0x02,0xb1	#⌠ ♂↑ →☻▒
	.byte	0x1e,0x03,0x72,0x1c,0x24,0x78,0x26,0xda	#▲♥r∟$x&┌
	.byte	0x01,0x00,0xf0,0x0c,0x33,0x80,0xef,0x1f	#☺ ≡♀3Ç∩▼
	.byte	0x2e,0x00,0x13,0x08,0x52,0x0d,0x48,0xc0	#. ‼◘R♪H└
	.byte	0x7f,0x00,0x1e,0x66,0x02,0x1f,0xd3,0xe4	#⌂ ▲f☻▼╙Σ
	.byte	0x02,0x01,0x36,0x80,0xf8,0x07,0xc0,0x20	#☻☺6Ç°•└
	.byte	0x00,0x7e,0x00,0x3f,0xc0,0x1f,0x1f,0xc7	# ~ ⁇└▼▼╟
	.byte	0x02,0x06,0x19,0x5c,0x28,0x03,0x3f,0xf8	#☻♠↓\(♥⁇°
	.byte	0x85,0x0d,0xb1,0x1c,0x0b,0x22,0xb0,0x01	#à♪▒∟♂.░☺
	.byte	0xa3,0x0d,0x04,0x30,0x00,0x19,0xa7,0xde	#ú♪♦0 ↓º▐
	.byte	0x00,0x29,0x28,0xbf,0x78,0x20,0x2f,0xbc	# )(┐x /╝
	.byte	0x0f,0x38,0x0e,0x0d,0x1f,0xff,0xf4,0x1c	#☼8♫♪▼λ⌠∟
	.byte	0x20,0x20,0xf0,0x0c,0x74,0x00,0x11,0xfe	#  ≡♀t ◄■
	.byte	0xd2,0x02,0x52,0xf8,0x79,0x80,0x00,0x7e	#╥☻R°yÇ ~
	.byte	0x4c,0x03,0x3f,0xfc,0x7f,0x03,0x4c,0x00	#L♥⁇ⁿ⌂♥L 
	.byte	0x1f,0x17,0x7f,0xb1,0x00,0x5b,0xfc,0xff	#▼↨⌂▒ [ⁿλ
	.byte	0xff,0xfc,0x6d,0x20,0x00,0x26,0x7e,0xb4	#λⁿm  &~┤
	.byte	0x21,0x00,0x1f,0xa3,0x58,0x00,0x18,0x1f	#! ▼úX ↑▼
	.byte	0x18,0x23,0x07,0xff,0xff,0x96,0x2f,0xff	#↑.•λλû/λ
	.byte	0x01,0xfb,0x0d,0xff,0xff,0xff,0xff,0xff	#☺√♪λλλλλ
	.byte	0xff,0xc9,0x04,0xf0,0x0a,0x1f,0x7f,0x1c	#λ╔♦≡◙▼⌂∟
	.byte	0x19,0x70,0x04,0x08,0x00,0x1f,0x07,0x30	#↓p♦◘ ▼•0
	.byte	0x18,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#↑λλλλλλλ
	.byte	0xff,0xff,0x96,0x2f,0x60,0x0f,0x5f,0x25	#λλû/`☼_%
	.byte	0xff,0xff,0x87,0x5d,0x03,0xf8,0xff,0xe7	#λλç]♥°λτ
	.byte	0x0f,0x30,0x34,0x05,0x66,0x37,0x0f,0xba	#☼04♣f7☼║
	.byte	0x14,0xe2,0x01,0x01,0x00,0x12,0x7f,0x2d	#¶Γ☺☺ ↕⌂-
	.byte	0x3a,0x20,0x1f,0x20,0x01,0x26,0x3f,0xf8	#: ▼ ☺&⁇°
	.byte	0xfe,0xff,0xc0,0x00,0x97,0x5f,0x7f,0xff	#■λ└ ù_⌂λ
	.byte	0xff,0xf9,0xdb,0x13,0x0e,0x0e,0x1f,0x7f	#λ∙█‼♫♫▼⌂
	.byte	0xb9,0x1a,0x24,0x0f,0xda,0x01,0xa9,0x0a	#╣→$☼┌☺⌐◙
	.byte	0xf4,0x00,0x3f,0xf0,0x07,0x00,0x01,0x00	#⌠ ⁇≡• ☺ 
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff	#λλλλλλλλ
	.byte	0xff,0xff,0xff,0xff,0x46,0x57,0x02,0x00	#λλλλFW☻ 
	.byte	0x00,0x00,0xff,0x01,0x00,0x0c,0x20,0x00	#  λ☺ ♀  
	.byte	0x1f,0xff,0x01,0x00,0x07,0x50,0xff,0xff	#▼λ☺ •Pλλ
	.byte	0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00
	.endobj	kCombiningCharsLz4,globl,hidden
	.previous
