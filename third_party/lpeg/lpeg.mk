#-*-mode:makefile-gmake;indent-tabs-mode:t;tab-width:8;coding:utf-8-*-┐
#───vi: set et ft=make ts=8 tw=8 fenc=utf-8 :vi───────────────────────┘

# i think we want to copy lua's makefile as a third party dep
# then make lua dep on this
# but we need re.lua in the base .lua dir
# we need clp lua files in .lua dir
# so we need to see how the .lua dir is made.. maybe from redbean?

PKGS += THIRD_PARTY_LPEG

THIRD_PARTY_LPEG_ARTIFACTS += THIRD_PARTY_LPEG_A
THIRD_PARTY_LPEG = $(THIRD_PARTY_LPEG_A_DEPS) $(THIRD_PARTY_LPEG_A)
THIRD_PARTY_LPEG_A = o/$(MODE)/third_party/lpeg/lpeg.a
THIRD_PARTY_LPEG_A_FILES := $(wildcard third_party/lpeg/*)
THIRD_PARTY_LPEG_A_HDRS = $(filter %.h,$(THIRD_PARTY_LPEG_A_FILES))
THIRD_PARTY_LPEG_A_SRCS = $(filter %.c,$(THIRD_PARTY_LPEG_A_FILES))
THIRD_PARTY_LPEG_A_OBJS = $(THIRD_PARTY_LPEG_A_SRCS:%.c=o/$(MODE)/%.o)

THIRD_PARTY_LPEG_A_CHECKS =				\
	$(THIRD_PARTY_LPEG_A).pkg				\
	$(THIRD_PARTY_LPEG_A_HDRS:%=o/$(MODE)/%.ok)

# Ripped this straight from lua like a ****ing idiot
THIRD_PARTY_LPEG_A_DIRECTDEPS =						\
	LIBC_CALLS							\
	LIBC_FMT							\
	LIBC_INTRIN							\
	LIBC_MEM							\
	LIBC_NEXGEN32E							\
	LIBC_RUNTIME							\
	LIBC_STDIO							\
	LIBC_STR							\
	LIBC_SYSV							\
	LIBC_LOG							\
	LIBC_TIME							\
	LIBC_X								\
	LIBC_TINYMATH							\
	NET_HTTP							\
	THIRD_PARTY_DOUBLECONVERSION					\
	THIRD_PARTY_GDTOA						\
	THIRD_PARTY_LUA						\

THIRD_PARTY_LPEG_A_DEPS :=					\
	$(call uniq,$(foreach x,$(THIRD_PARTY_LPEG_A_DIRECTDEPS),$($(x))))

$(THIRD_PARTY_LPEG_A):					\
		third_party/lpeg/				\
		$(THIRD_PARTY_LPEG_A).pkg			\
		$(THIRD_PARTY_LPEG_A_OBJS)

o/$(MODE)/third_party/lpeg/lpvm.o: private			\
		OVERRIDE_CFLAGS +=				\
			-DSTACK_FRAME_UNLIMITED

$(THIRD_PARTY_LPEG_A).pkg:					\
		$(THIRD_PARTY_LPEG_A_OBJS)			\
		$(foreach x,$(THIRD_PARTY_LPEG_A_DIRECTDEPS),$($(x)_A).pkg)

$(THIRD_PARTY_LPEG_A_OBJS): private			\
		OVERRIDE_CFLAGS +=				\
			-ffunction-sections			\
			-fdata-sections

THIRD_PARTY_LPEG_LIBS = $(foreach x,$(THIRD_PARTY_LPEG_ARTIFACTS),$($(x)))
THIRD_PARTY_LPEG_SRCS = $(foreach x,$(THIRD_PARTY_LPEG_ARTIFACTS),$($(x)_SRCS))
THIRD_PARTY_LPEG_HDRS = $(foreach x,$(THIRD_PARTY_LPEG_ARTIFACTS),$($(x)_HDRS))
THIRD_PARTY_LPEG_CHECKS = $(foreach x,$(THIRD_PARTY_LPEG_ARTIFACTS),$($(x)_CHECKS))
THIRD_PARTY_LPEG_OBJS = $(foreach x,$(THIRD_PARTY_LPEG_ARTIFACTS),$($(x)_OBJS))
$(THIRD_PARTY_LPEG_OBJS): third_party/lpeg/lpeg.mk

.PHONY: o/$(MODE)/third_party/lpeg
o/$(MODE)/third_party/lpeg: $(THIRD_PARTY_LPEG_CHECKS)
