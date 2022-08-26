/*-*- mode:c;indent-tabs-mode:nil;c-basic-offset:2;tab-width:8;coding:utf-8 -*-│
│vi: set net ft=c ts=2 sts=2 sw=2 fenc=utf-8                                :vi│
╚─────────────────────────────────────────────────────────────────────────────*/
#include "libc/fmt/conv.h"
#include "libc/log/log.h"
#include "libc/stdio/append.internal.h"
#include "libc/str/str.h"
#include "libc/sysv/consts/exit.h"
#include "third_party/lua/lrepl.h"
#include "third_party/lua/lualib.h"
#include "third_party/getopt/getopt.h"

static lua_State *globalL = NULL;
static const char *progname = "clp";

static bool using_highlight_line;
static bool overrides_filetype;
static bool list_overrides;

static char *overriding_filetype;
static int highlight_line;
static char *filename;

static long ParseInt(const char *s) {
  return strtol(s, 0, 0);
}

static void usage () {
  lua_writestringerror("%s: ", progname);
  lua_writestringerror(
  "usage: %s [options] [file]\n"
  "Available options are:\n"
  "  -l       list types of filetypes that can be forced       \n"
  "  -t       force a language's syntax for highlighting a file\n"
  "  -h       Highlight a non-blank line		       \n"
  ,
  progname);
}

static void ProgramOverrideFiletype(const char *ft) {
  overrides_filetype = true;
  overriding_filetype = ft;
}

static void ProgramHighlightLine(int line) {
  using_highlight_line = true;
  highlight_line = line;
}

static char *GetDefaultLuaPath(void) {
  char *s = 0;
  appends(&s, "/zip/.lua/?.lua;/zip/.lua/?/init.lua");
  return s;
}

static void LuaStart(lua_State *L) {
  g_lua_path_default = GetDefaultLuaPath();
  luaL_openlibs(L);
  luaL_getsubtable(L, LUA_REGISTRYINDEX, "_PRELOAD");
  int luaopen_lpeg(lua_State *L);
  lua_pushcfunction(L, luaopen_lpeg);
  lua_setfield(L, -2, "lpeg");
  lua_pop(L, 1);
}

static void GetOpts(int argc, char *argv[]) {
  int opt;
   while ((opt = getopt(argc, argv, "lt:h:")) != -1) {
    switch (opt) {
    case 'l':
            list_overrides = true;
            break;
    case 't':
            printf("optrg %s\n",optarg);
            ProgramOverrideFiletype(optarg);
            break;
    case 'h':
            ProgramHighlightLine(ParseInt(optarg));
            break;
    default:
            usage();
    }
  }
}

static int pmain (lua_State *L) {
  int argc = (int)lua_tointeger(L, 1);
  char **argv = (char **)lua_touserdata(L, 2);
  int script;
  LuaStart(L);
  int status = 0;
  GetOpts(argc,argv);
  int i = -1;
  // filename omitted
  if(optind >= argc) {
          usage();
          return 1;
  };
  filename = argv[optind];
  lua_getglobal(L, "require");
  lua_pushstring(L, "clp");
  status = lua_pcall(L, 1, 1, 0);
  if (status != 0)
          fprintf(stderr, "%s\n", lua_tostring(L, -1));
  lua_getglobal(L, "main");
  lua_newtable(L);
  lua_pushliteral(L, "filename");
  lua_pushstring(L, filename);
  lua_settable(L, -3);
  if(using_highlight_line) {
          lua_pushliteral(L, "highlight_line");
          lua_pushinteger(L, highlight_line);
          lua_settable(L, -3);
  }
  if(overrides_filetype) {
          lua_pushliteral(L, "overriding_filetype");
          lua_pushstring(L, overriding_filetype);
          lua_settable(L, -3);
  }
  status = lua_pcall(L, 1, 0, 0);
  if (status != 0) {
          fprintf(stderr, "%s\n", lua_tostring(L, -1));
          return 1;
  }
  lua_pushboolean(L, 1);  /* signal no errors */
  return 1;
}

int main (int argc, char **argv) {
  lua_State *L;
  int status, result;
  L = luaL_newstate();  /* create state */
  if (L == NULL) {
    lua_l_message(argv[0], "cannot create state: not enough memory");
    return EXIT_FAILURE;
  }
  lua_pushcfunction(L, &pmain);  /* to call 'pmain' in protected mode */
  lua_pushinteger(L, argc);  /* 1st argument */
  lua_pushlightuserdata(L, argv); /* 2nd argument */
  status = lua_pcall(L, 2, 1, 0);  /* do the call */
  result = lua_toboolean(L, -1);  /* get result */
  lua_report(L, status);
  lua_close(L);
  return (result && status == LUA_OK) ? EXIT_SUCCESS : EXIT_FAILURE;
}
