%{
static char findname (char *yytext) {return yytext [0];}
#include "node2.h"
#include "prjt2b.tab.h"
#include <string.h>
unsigned long i=0;
%}
%%option noyywrap
[\t]		;
[ ]		;
[\n]			;
%.*			;
program			{ yylval.a_program=(char*)malloc(strlen(yytext)+1);yylval.a_program= (char *) strdup(yytext); yylval.a_program=malloc(strlen(yytext)+1); yylval.a_program=yytext; return P_PROGRAM;}
if			{ yylval.a_IF=(char*)malloc(strlen(yytext)+1);yylval.a_IF= (char *) strdup(yytext);yylval.a_IF=yytext;return IF;}
then			{ yylval.a_THEN=(char*)malloc(strlen(yytext)+1);yylval.a_THEN= (char *) strdup(yytext);yylval.a_THEN= yytext;return THEN;}
else			{ yylval.a_ELSE=(char*)malloc(strlen(yytext)+1);yylval.a_ELSE= (char *) strdup(yytext);yylval.a_ELSE= yytext;return ELSE;}
begin			{ yylval.a_begin=(char*)malloc(strlen(yytext)+1);yylval.a_begin= (char *) strdup(yytext);yylval.a_begin= yytext;return beg;}
end			{yylval.a_end=(char*)malloc(strlen(yytext)+1);yylval.a_end= (char *) strdup(yytext); yylval.a_end= yytext;return A_END;}
while			{ yylval.a_WHILE=(char*)malloc(strlen(yytext)+1);yylval.a_WHILE= (char *) strdup(yytext);yylval.a_WHILE= yytext;return WHILE;}
do			{yylval.a_DO=(char*)malloc(strlen(yytext)+1);yylval.a_DO= (char *) strdup(yytext); yylval.a_DO= yytext;return DO;}
as			{ yylval.a_AS=(char*)malloc(strlen(yytext)+1);yylval.a_AS= (char *) strdup(yytext);return A_AS;}
int			{ yylval.a_INT=(char*)malloc(strlen(yytext)+1); yylval.a_INT= (char *) strdup(yytext);return INT;}
bool			{ yylval.a_BOOL=(char*)malloc(strlen(yytext)+1);yylval.a_BOOL= (char *) strdup(yytext);yylval.a_BOOL= yytext;return BOOL;}
writeInt		{ yylval.a_writeInt=(char*)malloc(strlen(yytext)+1);yylval.a_writeInt= (char *) strdup(yytext);yylval.a_writeInt= yytext;return WRITEINT;}
readInt			{ yylval.a_READINT=(char*)malloc(strlen(yytext)+1);yylval.a_READINT= (char *) strdup(yytext);yylval.a_READINT= yytext;return READINT;}
true			{ yylval.b_boollit=(char*)malloc(strlen(yytext)+1);yylval.b_boollit= (char *) strdup(yytext);yylval.b_boollit= yytext;return boollit;}
false			{ yylval.b_boollit=(char*)malloc(strlen(yytext)+1);yylval.b_boollit= (char *) strdup(yytext);yylval.b_boollit= yytext;return boollit;}
var			{ yylval.a_var=(char*)malloc(strlen(yytext)+1);yylval.a_var= (char *) strdup(yytext);return A_VAR;}
div			{ yylval.a_OP2='/';return OP2;/*yylval.a_OP2=(char*)malloc(strlen(yytext)+1); yylval.a_OP2= (char *) strdup(yytext);yylval.a_OP2= yytext;return OP2;*/}
mod			{ yylval.a_OP2='%';return OP2;/*yylval.a_OP2=(char*)malloc(strlen(yytext)+1); yylval.a_OP2= (char *) strdup(yytext);yylval.a_OP2= yytext;return OP2;*/}
[A-Z][A-Z0-9]*		{ yylval.i_ident=(char*)malloc(strlen(yytext)+1); yylval.i_ident= (char *) strdup(yytext);return ident;}
0			{yylval.a_number = atol(yytext);return num;}
[1-9][0-9]*		{yylval.a_number = atol(yytext);return num;/*(int)malloc(sizeof(atol(yytext))+1);yylval.a_number=atoi(strdup(yytext)); printf("\n%din lex number: \n", yylval.a_number);return num;*/}
;			{ yylval.a_SC=';';return SC;/*(char*)malloc(strlen(yytext)+1);yylval.a_SC= (char *) strdup(yytext); yylval.a_SC= yytext; */}
:=			{ yylval.a_ASGN=(char*)malloc(strlen(yytext)+1); yylval.a_ASGN= (char *) strdup(yytext);yylval.a_ASGN= yytext;return ASGN;}
\(			{ yylval.a_LP= '(';return LP;}
\)			{ yylval.a_RP= ')';return RP;}
\*			{ yylval.a_OP2='*';return OP2;/*yylval.a_OP2=(char*)malloc(strlen(yytext)+1); yylval.a_OP2= (char *) strdup(yytext);yylval.a_OP2= yytext;printf("In lex %s", yylval.a_OP2); return OP2;*/}
\+			{ yylval.a_OP3='+';return OP3;/*yylval.a_OP3=(char*)malloc(strlen(yytext)+1); yylval.a_OP3= (char *) strdup(yytext);yylval.a_OP3= yytext;return OP3;*/}
\-			{ yylval.a_OP3='-';return OP3;/*yylval.a_OP3=(char*)malloc(strlen(yytext)+1); yylval.a_OP3= (char *) strdup(yytext);yylval.a_OP3= yytext;return OP3;*/}
=			{ yylval.a_OP4='=';return OP4;/*yylval.a_OP4=(char*)malloc(strlen(yytext)+1); yylval.a_OP4= (char *) strdup(yytext);yylval.a_OP4= yytext;return OP4;*/}
!=			{ yylval.a_OP4='#';return OP4;/*yylval.a_OP4=(char*)malloc(strlen(yytext)+1); yylval.a_OP4= (char *) strdup(yytext);yylval.a_OP4= yytext;return OP4;*/}
\<			{ yylval.a_OP4='<';return OP4;/*yylval.a_OP4=(char*)malloc(strlen(yytext)+1); yylval.a_OP4= (char *) strdup(yytext);yylval.a_OP4= yytext;return OP4;*/}
\>			{ yylval.a_OP4='>';return OP4;/*yylval.a_OP4=(char*)malloc(strlen(yytext)+1); yylval.a_OP4= (char *) strdup(yytext);yylval.a_OP4= yytext;return OP4;*/}
\<=			{yylval.a_OP4='c';return OP4;/*yylval.a_OP4=(char*)malloc(strlen(yytext)+1); yylval.a_OP4= (char *) strdup(yytext); yylval.a_OP4= yytext;return OP4;*/}
\>=			{yylval.a_OP4='7';return OP4;/*yylval.a_OP4=(char*)malloc(strlen(yytext)+1); yylval.a_OP4= (char *) strdup(yytext); yylval.a_OP4= yytext;return OP4;*/}
%%
int yywrap (void) {return 1;}