#-*-mode:makefile-gmake;indent-tabs-mode:t;tab-width:8;coding:utf-8-*-┐
#───vi: set et ft=make ts=8 tw=8 fenc=utf-8 :vi───────────────────────┘

PKGS += THIRD_PARTY_CLP

THIRD_PARTY_CLP_SRCS = $(THIRD_PARTY_CLP_A_SRCS)
THIRD_PARTY_CLP_HDRS = $(THIRD_PARTY_CLP_A_HDRS)
THIRD_PARTY_CLP_INCS = $(THIRD_PARTY_CLP_A_INCS)
THIRD_PARTY_CLP_BINS = $(THIRD_PARTY_CLP_COMS) $(THIRD_PARTY_CLP_COMS:%=%.dbg)
THIRD_PARTY_CLP_COMS = o/$(MODE)/third_party/clp/clp.com

THIRD_PARTY_CLP_ARTIFACTS += THIRD_PARTY_CLP_A
THIRD_PARTY_CLP = $(THIRD_PARTY_CLP_A_DEPS) $(THIRD_PARTY_CLP_A)
THIRD_PARTY_CLP_A = o/$(MODE)/third_party/clp/clp.a
THIRD_PARTY_CLP_A_FILES := $(wildcard third_party/clp/*)
THIRD_PARTY_CLP_A_HDRS = $(filter %.h,$(THIRD_PARTY_CLP_A_FILES))
THIRD_PARTY_CLP_A_INCS = $(filter %.inc,$(THIRD_PARTY_CLP_A_FILES))
THIRD_PARTY_CLP_A_SRCS = $(filter %.c,$(THIRD_PARTY_CLP_A_FILES))
THIRD_PARTY_CLP_A_OBJS = $(THIRD_PARTY_CLP_A_SRCS:%.c=o/$(MODE)/%.o)

THIRD_PARTY_CLP_A_DIRECTDEPS =							\
	LIBC_CALLS								\
	LIBC_FMT								\
	LIBC_INTRIN								\
	LIBC_MEM								\
	LIBC_NEXGEN32E								\
	LIBC_RUNTIME								\
	LIBC_STDIO								\
	LIBC_STR								\
	LIBC_SYSV								\
	LIBC_LOG								\
	LIBC_X									\
	THIRD_PARTY_GDTOA							\
	THIRD_PARTY_LUA								\
	THIRD_PARTY_GETOPT							\

THIRD_PARTY_CLP_A_DEPS :=							\
	$(call uniq,$(foreach x,$(THIRD_PARTY_CLP_A_DIRECTDEPS),$($(x))))

THIRD_PARTY_CLP_A_CHECKS =							\
	$(THIRD_PARTY_CLP_A).pkg						\
	$(THIRD_PARTY_CLP_A_HDRS:%=o/$(MODE)/%.ok)

$(THIRD_PARTY_CLP_A):								\
		third_party/clp/						\
		$(THIRD_PARTY_CLP_A).pkg					\
		$(THIRD_PARTY_CLP_A_OBJS)

CLP_STANDARD_ASSETS =								\
	$(wildcard third_party/clp/.lua/*)

CLP_STANDARD_ASSETS_ZIP =							\
	$(COMPILE) -AZIP -T$@							\
	o/$(MODE)/third_party/zip/zip.com -b$(TMPDIR) -9qj $@			\
	$(CLP_STANDARD_ASSETS)


$(THIRD_PARTY_CLP_A).pkg:							\
		$(THIRD_PARTY_CLP_A_OBJS)					\
		$(foreach x,$(THIRD_PARTY_CLP_A_DIRECTDEPS),$($(x)_A).pkg)

THIRD_PARTY_CLP_STANDARD_ASSETS =						\
	$(wildcard .lua/*)							\
	$(wildcard .lua/lexers/*)						\
	$(wildcard .lua/themes/*)						\

THIRD_PARTY_CLP_STANDARD_ASSETS_ZIP =						\
	$(COMPILE) -AZIP -T$@							\
	o/$(MODE)/third_party/zip/zip.com -b$(TMPDIR) -9q $@			\
	$(THIRD_PARTY_CLP_STANDARD_ASSETS)

o/$(MODE)/third_party/clp/clp.com.dbg:						\
		$(THIRD_PARTY_CLP)						\
		o/$(MODE)/third_party/clp/main.o				\
		$(CRT)								\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

o/$(MODE)/third_party/clp/clp.com:						\
		o/$(MODE)/third_party/clp/clp.com.dbg				\
		o/$(MODE)/third_party/zip/zip.com				\
		o/$(MODE)/tool/build/symtab.com					\
		$(THIRD_PARTY_CLP_STANDARD_ASSETS)
	@$(MAKE_OBJCOPY)
	@$(MAKE_SYMTAB_CREATE)
	@$(MAKE_SYMTAB_ZIP)
	@$(THIRD_PARTY_CLP_STANDARD_ASSETS_ZIP)

THIRD_PARTY_CLP_LIBS = $(foreach x,$(THIRD_PARTY_CLP_ARTIFACTS),$($(x)))
THIRD_PARTY_CLP_SRCS = $(foreach x,$(THIRD_PARTY_CLP_ARTIFACTS),$($(x)_SRCS))
THIRD_PARTY_CLP_CHECKS = $(foreach x,$(THIRD_PARTY_CLP_ARTIFACTS),$($(x)_CHECKS))
THIRD_PARTY_CLP_OBJS = $(foreach x,$(THIRD_PARTY_CLP_ARTIFACTS),$($(x)_OBJS))

$(THIRD_PARTY_CLP_OBJS): $(BUILD_FILES) third_party/clp/clp.mk

.PHONY: o/$(MODE)/third_party/clp
o/$(MODE)/third_party/clp:							\
		$(THIRD_PARTY_CLP_BINS)						\
		$(THIRD_PARTY_CLP_CHECKS)					\

