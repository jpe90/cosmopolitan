/*-*- mode:c;indent-tabs-mode:nil;c-basic-offset:2;tab-width:8;coding:utf-8 -*-│
│vi: set net ft=c ts=2 sts=2 sw=2 fenc=utf-8                                :vi│
╞══════════════════════════════════════════════════════════════════════════════╡
│ Copyright 2022 Justine Alexandra Roberts Tunney                              │
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
#include "libc/calls/calls.h"
#include "libc/calls/syscall-sysv.internal.h"
#include "libc/intrin/kprintf.h"
#include "libc/log/bsd.h"
#include "libc/runtime/runtime.h"
#include "libc/stdio/stdio.h"
#include "libc/str/str.h"
#include "third_party/getopt/getopt.h"

#define USAGE \
  "\
usage: pledge.com [-h] PROG ARGS...\n\
  -h           show help\n\
\n\
unveil.com v1.o\n\
copyright 2022 justine alexandra roberts tunney\n\
https://twitter.com/justinetunney\n\
https://linkedin.com/in/jtunney\n\
https://justine.lol/pledge/\n\
https://github.com/jart\n\
\n\
this program lets you launch linux commands in a filesystem sandbox\n\
inspired by the design of openbsd's unveil() system call. Visit\n\
the https://justine.lol/pledge/ page for online documentation.\n\
\n\
"

wontreturn void usage(void) {
  write(2, USAGE, sizeof(USAGE) - 1);
  exit(1);
}

int main(int argc, char *argv[]) {
  const char *prog;
  char pathbuf[PATH_MAX];
  char *line = NULL;
  size_t size = 0;
  size_t count = 0;
  ssize_t len;
  int opt;
  const char *fields[2];

  if (!(IsLinux() || IsOpenbsd()))
    errx(1, "this program is only intended for Linux and OpenBSD");

  // parse flags
  while ((opt = getopt(argc, argv, "h")) != -1) {
    switch (opt) {
      case 'h':
      case '?':
      default:
        usage();
    }
  }
  if (optind == argc) {
    warnx("No command provided");
    usage();
  }
  if (!(prog = commandv(argv[optind], pathbuf, sizeof(pathbuf))))
    err(1, "command not found: %s", argv[optind]);

  while ((len = getline(&line, &size, stdin)) != -1) {
    count++;
    _chomp(line);

    char *tok = line;
    const char *p;
    size_t i = 0;
    while ((p = strsep(&tok, " \t")) != NULL) {
      if (*p == '\0') {
        p++;
        continue;
      }
      if (i > 1) errx(1, "<stdin>:%zu - too many fields", count);
      fields[i++] = p;
    }
    if (i != 2) errx(1, "<stdin>:%zu - malformed line", count);

    if (unveil(fields[0], fields[1]) == -1)
      err(1, "unveil(%s, %s)", fields[0], fields[1]);
  }
  free(line);
  if (ferror(stdin)) err(1, "getline");

  if (unveil(NULL, NULL) == -1) err(1, "unveil disable");

  __sys_execve(prog, argv + optind, environ);
  err(127, "execve");
}
