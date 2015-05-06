#include "node2.h"
#include <stdlib.h>
#include <string.h>	

struct symrec
{
char *ident; /* name of symbol */
tree *type; // type
struct symrec *next; /* link field */
};

typedef struct symrec symrec;

symrec *identifier;

symrec *sym_table = (symrec *)NULL;

symrec * putsym (char *sym_name, tree *sym_type)
{
symrec *ptr;
ptr = (symrec *) malloc (sizeof(symrec));
ptr->ident = (char *) malloc (strlen(sym_name)+1);
strcpy (ptr->ident,sym_name);
ptr->type = (tree *) malloc (sizeof(sym_type));
ptr->type=sym_type;
ptr->next = (struct symrec *)sym_table;
sym_table = ptr;
return ptr;
}

symrec * getsym (char *sym_name)
{
symrec *ptr;
for ( ptr = sym_table; ptr != (symrec *) NULL; ptr = (symrec *)ptr->next )
if (strcmp (ptr->ident,sym_name) == 0)
return ptr;
return 0;
}