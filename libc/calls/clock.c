/*-*- mode:c;indent-tabs-mode:nil;c-basic-offset:2;tab-width:8;coding:utf-8 -*-│
│vi: set net ft=c ts=2 sts=2 sw=2 fenc=utf-8                                :vi│
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
#include "libc/calls/struct/timespec.h"
#include "libc/dce.h"
#include "libc/fmt/conv.h"
#include "libc/nt/accounting.h"
#include "libc/nt/runtime.h"
#include "libc/nt/synchronization.h"
#include "libc/sysv/consts/clock.h"
#include "libc/time/time.h"

/**
 * Returns how much CPU program has consumed on time-sharing system.
 *
 * @return value that can be divided by CLOCKS_PER_SEC, or -1 w/ errno
 * @see clock_gettime()
 */
int64_t clock(void) {
  struct timespec ts;
  struct NtFileTime creation_time, exit_time, kernel_time, user_time;
  int64_t proc, total;
  // polyfill on Windows where CLOCK_PROCESS_CPUTIME_ID may be not available
  if (IsWindows() && CLOCK_PROCESS_CPUTIME_ID == -1) {
    proc = GetCurrentProcess();
    if (!GetProcessTimes(proc, &creation_time, &exit_time, &kernel_time,
                         &user_time))
      return -1;
    total = ReadFileTime(kernel_time) + ReadFileTime(user_time);
    ts = WindowsDurationToTimeSpec(total);
  } else if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts) == -1) {
    return -1;
  }
  return ts.tv_sec * CLOCKS_PER_SEC +
         ts.tv_nsec / (1000000000 / CLOCKS_PER_SEC);
}
