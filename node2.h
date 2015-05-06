 enum treetype {program_node, declarations_node, type_node, stmtSeq_node, stmt_node, 
	 assign1_node, assign2_node, ifStmt_node, elseClause_node, whileStmt_node, 
	 writeInt_node, exp1_node, exp2_node, simpleExp1_node, simpleExp2_node, term1_node, 
	 term2_node, factor1_node, factor2_node, number_node, bool_lit_node, SOK_node, progK_node, beginK_node, endK_node,
	 varK_node, asK_node, ident_node, num_node, one_node, two_node, three_node, int_node, boolit_node, declaration_node, 
	 two_node_ident, bool_node, two_node_operation, two_node_operationC, two_node_stmt_seq, two_node_ident_asgn, one_node_ident_asgn, 
	 one_node_ident_asgn_readint, one_node_else, two_node_while, one_node_writeint, one_node_lprp, one_node_condition};

 typedef struct tree {
   enum treetype nodetype;
   union {
//     struct {struct tree *declarations, *statementSeq, begin[5],program[10], end[10]; char programC[10]; } program;
       struct {struct tree *declarationsProgram, *statementSeqProgram, *beginP, *programP, *endP; } program;
	 struct {struct tree *type,*ident; char *var; char *as; char sc; } declarations;
     struct {struct tree *term1; char *simpleExp2;} simpleExp2;
     struct {struct tree *term1, *term2; char op3; char *simpleExp1;} simpleExp1;
     struct {struct tree *simpleExp1, *simpleExp2; char op4; char *simpleExp;} exp2;
     struct {struct tree *exp1;  char *exp;} exp1;
     struct {struct tree *exp; char *writeInt; char *writeIntC;} writeInt;
     struct {struct tree *exp, *stmtSeq; char *While, *Do, *end;char *whileStmt;} whileStmt;
     struct {struct tree *stmtSeq; char *elseClause; char *elseClauseC; } elseClause;
     struct {struct tree *exp, *stmtSeq, *elseClause; char *If, *then, *end; char *ifStmt; } ifStmt;
     struct {char asgn; char *ident, *assign2, *readInt; } assign2;
     struct {struct tree *exp; char asgn; char *assign, *ident; } assign1;
     struct {struct tree *assign, *ifStmt, *whileStmt, *writeInt; char *stmt; } stmt;
     struct {struct tree *stmt; char sc; char *stmtSeqC; } stmtSeq;
     struct {char *Int, *Bool; char *typeC; } type;
     struct {struct tree *factor1, *factor2; char op2; char *factor1C;  } term1;
     struct {struct tree *factor2; char *factor2C;  } term2;
     struct {char ident[10], bool_lit[10]; int a_number; char *factor1; } factor1;
     struct {struct tree *exp; char lp, rp;char *factor1; } factor2;
	 struct { char *ident;	 } identStruct;
	 struct { int num;	 } numStruct;
	 struct { char *bool_lit;	 } boollitStruct;
	 struct { char *typeint;	 } typeIntStruct;
	 struct {struct tree *left;} oneNode;
	 struct {struct tree *left; char *writeint;} oneNode_writeInt;
	 struct {struct tree *left, *right;} twoNode;
	 struct {struct tree *left, *right;char sc;} twoNodeStmtSeq;
	 struct {struct tree *right;char *left;char *asgn;} twoNodeIdentAsgn;
	 struct {char *left; char *right;char *asgn;} oneNodeIdentAsgnReadInt;
	 struct {struct tree *right; char *left;} twoNodeIdent;
	 struct {char *right; char *left;} twoNodeIdentType;
	 struct {struct tree *left, *right, *center;} threeNode;
	 struct {char *left;struct tree *right, *center;} threeNodeDeclaration;
	 struct {char *op; struct tree *right, *left;} twoNodeOperation;
	 struct {char op; struct tree *right, *left;} twoNodeOperationC;
//		struct {char *progK; } programStruct;
//		struct {char *beginK; } beginStruct;
//		struct {char *endK; } endStruct;
//		struct { char *varK; } beginStruct;
//		struct {char *asK; } endStruct;


//     int a_number;
//     char[] an_identifier;
//     char[] a_bool_lit;
//     char[] a_sok;
//	 char a_SC;
//	 char []a_PROGRAM;

	char *_begin;
	char *a_program;
	char *_end;
	char *_var;
	char *_as;
   char *b_boollit;
   char *i_ident;
   char *a_PROGRAM;
   char *a_IF;
   char *a_THEN;
   char *a_ELSE;
   char *a_BEGIN;
   char *a_END;
   char *a_WHILE;
   char *a_DO;
   char *a_VAR;
   char *a_AS;
   char *a_INT;
   char *a_BOOL;
   char *a_writeInt;
   char *a_READINT;
   int a_number;
//   char boollit[10];
//   char ident[10];
   char a_LP;
   char a_RP;
   char *a_ASGN;
   char a_SC;
   char *a_OP2;
   char *a_OP3;
   char *a_OP4;
/*   char a_PROGRAM[10];
   char a_IF[10];
   char a_THEN[10];
   char a_ELSE[10];
   char a_BEGIN[5];
   char a_END[10];
   char a_WHILE[10];
   char a_DO[10];
   char a_VAR[10];
   char a_AS[10];
   char a_INT[10];
   char a_BOOL[10];
   char a_writeInt[10];
   char a_READINT[10];*/
   } body;
 } tree;