/*
** $Id: lpcode.h $
*/

#if !defined(lpcode_h)
#define lpcode_h

#include "third_party/lua/lua.h"

#include "third_party/lpeg/lptypes.h"
#include "third_party/lpeg/lptree.h"
#include "third_party/lpeg/lpvm.h"

int tocharset (TTree *tree, Charset *cs);
int checkaux (TTree *tree, int pred);
int fixedlen (TTree *tree);
int hascaptures (TTree *tree);
int lp_gc (lua_State *L);
Instruction *compile (lua_State *L, Pattern *p);
void realloccode (lua_State *L, Pattern *p, int nsize);
int sizei (const Instruction *i);


#define PEnullable      0
#define PEnofail        1

/*
** nofail(t) implies that 't' cannot fail with any input
*/
#define nofail(t)	checkaux(t, PEnofail)

/*
** (not nullable(t)) implies 't' cannot match without consuming
** something
*/
#define nullable(t)	checkaux(t, PEnullable)



#endif
