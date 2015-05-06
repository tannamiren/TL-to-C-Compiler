%{
	#include <stdio.h>
	#include "symtable.h"
	#include <string.h>
	#include <stdlib.h>
int x=1;

 /*-------------------------------------------------------------------------
Install identifier & check if previously defined.
-------------------------------------------------------------------------*/
static int install ( char *sym_name, tree *sym_type )
{
symrec *s;
s = getsym (sym_name);
if (s == 0)
{s = putsym (sym_name, sym_type);
return 1;}
else { 
printf( "ERROR: ^%s is already defined\n", sym_name );
return 0;
}
}
 
/*-------------------------------------------------------------------------
If identifier is defined, generate code
-------------------------------------------------------------------------*/
/*static void context_check( enum code_ops operation, char *sym_name )
{ symrec *identifier;
identifier = getsym( sym_name );
if ( identifier == 0 )
{ errors++;
printf( "%s", sym_name );
printf( "%s\n", " is an undeclared identifier" );
}
else gen_code( operation, identifier->offset );
}
*/


static tree *make_oneNode (tree *l) {
	//printf("\n----in make one node----");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= one_node;
	factor1T->body.oneNode.left = (tree*)malloc( sizeof(tree));
	factor1T->body.oneNode.left= l;

	return factor1T;
}
static tree *make_oneNodeCondition (tree *l) {
	//printf("\n----in make one node----");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= one_node_condition;
	factor1T->body.oneNode.left = (tree*)malloc( sizeof(tree));
	factor1T->body.oneNode.left= l;

	return factor1T;
}
static tree *make_oneNode_lprp (tree *l) {
	//printf("\n----in make one node lprp----");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= one_node_lprp;
	factor1T->body.oneNode.left = (tree*)malloc( sizeof(tree));
	factor1T->body.oneNode.left= l;

	return factor1T;
}
static tree *make_oneNode_writeInt (char *wr, tree *l ) {
	//printf("\n----in make one nod writeInt----");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= one_node_writeint;
	factor1T->body.oneNode_writeInt.writeint= (char*)malloc(strlen(wr)+1);
	strcpy(factor1T->body.oneNode_writeInt.writeint, wr);
	factor1T->body.oneNode_writeInt.left = (tree*)malloc( sizeof(tree));
	factor1T->body.oneNode_writeInt.left= l;

	return factor1T;
}
static tree *make_oneNodeElse (tree *l) {
	//printf("\n----in make one node else ----");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= one_node_else;
	factor1T->body.oneNode.left = (tree*)malloc( sizeof(tree));
	factor1T->body.oneNode.left= l;

	return factor1T;
}

static tree *make_oneNodeIntBool (char* l) {
	//printf("\n In make one Node Int Bool -- %s", l);
	tree *factor1T2= (tree*) malloc (sizeof(tree));
	factor1T2->nodetype= int_node;
	factor1T2->body.typeIntStruct.typeint= (char*)malloc(strlen(l)+1);
	strcpy(factor1T2->body.typeIntStruct.typeint, l);
	return factor1T2;
}

static tree *make_oneNodeBool (char* l) {
	//printf("\n In make one Node Bool -- %s", l);
	tree *factor1T2= (tree*) malloc (sizeof(tree));
	factor1T2->nodetype= bool_node;
	factor1T2->body.a_BOOL= (char*)malloc(strlen(l)+1);
	strcpy(factor1T2->body.a_BOOL, l);
	return factor1T2;
}

static tree *make_twoNode (tree *l, tree* r) {
	//printf("\n In Make two node ");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= two_node;
	factor1T->body.twoNode.left = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNode.left= l;
	factor1T->body.twoNode.right = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNode.right= r;

	return factor1T;
}
static tree *make_twoNodeWhile (tree *l, tree* r) {
	//printf("\n In Make two node while ");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= two_node_while;
	factor1T->body.twoNode.left = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNode.left= l;
	factor1T->body.twoNode.right = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNode.right= r;

	return factor1T;
}
static tree *make_twoNodeStmtSeq (tree *l, char s, tree* r) {
	//printf("\n In Make two node StmtSeq ");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= two_node_stmt_seq;
	factor1T->body.twoNodeStmtSeq.sc=s; 
	factor1T->body.twoNodeStmtSeq.left = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNodeStmtSeq.left= l;
	factor1T->body.twoNodeStmtSeq.right = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNodeStmtSeq.right= r;

	return factor1T;

}

static tree *make_twoNodeOperation ( tree *l,char *o,  tree* r) {
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= two_node_operation;
	factor1T->body.twoNodeOperation.op= (char*)malloc(strlen(o)+1);
	strcpy(factor1T->body.twoNodeOperation.op, o);
	//printf("In Make Two Node Operation %s", factor1T->body.twoNodeOperation.op);
	factor1T->body.twoNodeOperation.left = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNodeOperation.left= l;
	factor1T->body.twoNodeOperation.right = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNodeOperation.right= r;

	return factor1T;
}
static tree *make_twoNodeOperationC ( tree *l,char o,  tree* r) {
	
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= two_node_operationC;
	//factor1T->body.twoNodeOperation.op= (char*)malloc(strlen(o)+1);
	//strcpy(factor1T->body.twoNodeOperation.op, o);
	factor1T->body.twoNodeOperationC.op= o;
	//printf("\n In make op parameter: %c", o);
	//printf("\nIn Make Two Node Operation %c", factor1T->body.twoNodeOperationC.op);
	factor1T->body.twoNodeOperationC.left = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNodeOperationC.left= l;
	factor1T->body.twoNodeOperationC.right = (tree*)malloc( sizeof(tree));
	factor1T->body.twoNodeOperationC.right= r;

	return factor1T;
}

static tree *make_twoNodeIdent (char *l, tree* r) {
	//printf("\n In Make two node Ident");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= two_node_ident;
	factor1T->body.twoNodeIdent.left= (char*)malloc(strlen(l)+1);
	strcpy(factor1T->body.twoNodeIdent.left, l);
	factor1T->body.twoNodeIdent.right = (tree*)malloc( sizeof(tree));
	//printf("\n---------------in maketwonodeident----------");
	factor1T->body.twoNodeIdent.right= r;
	return factor1T;
}
static tree *make_twoNodeIdentAsgn (char *l, char* a, tree* r) {
	//printf("\n In Make two node Ident Assign");
	
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= two_node_ident_asgn;
	factor1T->body.twoNodeIdentAsgn.left= (char*)malloc(strlen(l)+1);
	strcpy(factor1T->body.twoNodeIdentAsgn.left, l);
	factor1T->body.twoNodeIdentAsgn.asgn= (char*)malloc(strlen(a)+1);
	strcpy(factor1T->body.twoNodeIdentAsgn.asgn, a);
	factor1T->body.twoNodeIdentAsgn.right = (tree*)malloc( sizeof(tree));
	//printf("\n---------------in maketwonodeident----------");
	factor1T->body.twoNodeIdentAsgn.right= r;
	return factor1T;
}
static tree *make_oneNodeIdentAsgnReadInt (char* l, char* a, char *r) {
	//printf(" \nIn make one node ident ReadInt  -- %s", l);
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= one_node_ident_asgn_readint;
	factor1T->body.oneNodeIdentAsgnReadInt.left= (char*)malloc(strlen(l)+1);
	strcpy(factor1T->body.oneNodeIdentAsgnReadInt.left, l);
	factor1T->body.oneNodeIdentAsgnReadInt.asgn= (char*)malloc(strlen(a)+1);
	strcpy(factor1T->body.oneNodeIdentAsgnReadInt.asgn, a);
	factor1T->body.oneNodeIdentAsgnReadInt.right= (char*)malloc(strlen(r)+1);
	strcpy(factor1T->body.oneNodeIdentAsgnReadInt.right, r);
	
	return factor1T;
}

static tree *make_threeNodeIf (tree *l, tree *r, tree *c) {
	//printf("\n In Make Three Node If ");
	
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= three_node;
	factor1T->body.threeNode.left = (tree*)malloc( sizeof(tree));
	factor1T->body.threeNode.left= l;
	factor1T->body.threeNode.right = (tree*)malloc( sizeof(tree));
	factor1T->body.threeNode.right= r;
	factor1T->body.threeNode.center = (tree*)malloc( sizeof(tree));
	factor1T->body.threeNode.center= c;

	return factor1T;
}

static tree *make_threeNodeDeclarations (char* l, tree *r, tree *c) {
	if(l != NULL){
	//printf("\n In make three Node Declarations  -- %s", l);
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= declaration_node;
	factor1T->body.threeNodeDeclaration.left= (char*)malloc(strlen(l)+1);
	strcpy(factor1T->body.threeNodeDeclaration.left, l);
	factor1T->body.threeNodeDeclaration.right = (tree*)malloc( sizeof(tree));
	factor1T->body.threeNodeDeclaration.right= r;
	factor1T->body.threeNodeDeclaration.center = (tree*)malloc( sizeof(tree));
	factor1T->body.threeNodeDeclaration.center= c;

	return factor1T;}
	return NULL ;
}

static tree *make_oneNodeIdent (char* l) {
//printf(" \nIn make one node ident -- %s", l);
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= ident_node;
	factor1T->body.identStruct.ident= (char*)malloc(strlen(l)+1);
	strcpy(factor1T->body.identStruct.ident, l);

	return factor1T;
}
static tree *make_oneNodeNumber (int l) {
//printf("\n In Make one node Number ");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= num_node;
	factor1T->body.a_number= (int)malloc(sizeof(l)+1);
	factor1T->body.a_number= l;

	return factor1T;
}
static tree *make_oneNodeBoollit (char* l) {
//printf("\n In Make one node Boolit ");
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= boolit_node;
	factor1T->body.boollitStruct.bool_lit= (char*)malloc(strlen(l)+1);
	strcpy(factor1T->body.boollitStruct.bool_lit, l);
	
	return factor1T;
}
static tree *make_oneNodeNum (int l) {
//printf("\nin make number: %lu",l);
	tree *factor1T= (tree*) malloc (sizeof(tree));
	factor1T->nodetype= num_node;
//	factor1T->body.numStruct.num= (int)malloc(sizeof(l)+1);
	factor1T->body.numStruct.num= l;
	
	return factor1T;}
static void printtree (tree *t) {
   if (t)
     switch (t->nodetype)
     {
case one_node:
        printtree (t->body.oneNode.left);
	//free(t->body.oneNode.left);
	//free(t);
	break;
case one_node_condition:
        printtree (t->body.oneNode.left);
	//free(t->body.oneNode.left);
	//free(t);
	break;

case one_node_lprp:
       printf("\n( ");
        printtree (t->body.oneNode.left);
        printf("\n )");
	//free(t->body.oneNode.left);
	//free(t);
	break;

case one_node_else:
	if(t->body.oneNode.left != NULL){
	printf("\nelse ");
        printtree (t->body.oneNode.left); }
        //free(t->body.oneNode.left);
	//free(t);
	break;

case one_node_writeint:
        printf("\nin onenodewriteint writeInt")	; //,t->body.oneNode_writeInt.writeint);
        printtree (t->body.oneNode_writeInt.left);
	//free(t->body.oneNode_writeInt.writeint);
	//free(t->body.oneNode_writeInt.left);
	//free(t);
	break;

case two_node:
        printtree (t->body.twoNode.left);
        printtree (t->body.twoNode.right);
        //free(t->body.twoNode.left);
//free(t->body.twoNode.right);
	//free(t);
	break;

case two_node_while:
        printf("\nwhile");
        printtree (t->body.twoNode.left);
        printtree (t->body.twoNode.right);
        //free(t->body.twoNode.right);
        //free(t->body.twoNode.left);
	//free(t);
	break;

case two_node_ident:
        printf ("\ntwo node ident: %s", t->body.twoNodeIdent.left);
	printtree (t->body.twoNodeIdent.right);
        //free(t->body.twoNodeIdent.right);
	//free(t->body.twoNodeIdent.left);
	//free(t);
	break;

case ident_node:
        printf ("\none node ident: %s", t->body.identStruct.ident);
	//free(t->body.identStruct.ident);
	//free(t);
	break;

case one_node_ident_asgn_readint:
        printf ("\none node ident read int: %s", t->body.oneNodeIdentAsgnReadInt.left);
        printf ("\none node ident read int: :=");//, t->body.oneNodeIdentAsgnReadInt.asgn);
        printf ("\none node ident read int: READINT");//, t->body.oneNodeIdentAsgnReadInt.right);
	//free(t->body.oneNodeIdentAsgnReadInt.right);
	//free(t->body.oneNodeIdentAsgnReadInt.left);
	//free(t->body.oneNodeIdentAsgnReadInt.asgn);
	//free(t);
	break;

case num_node:
        printf ("\n In Number Node : %lu", t->body.numStruct.num);
	//free(t);
	break;

case three_node:
        printf("\nif ");
        printtree (t->body.threeNode.left);
        printtree (t->body.threeNode.right);
	printtree (t->body.threeNode.center);
	//free(t->body.threeNode.left);
	//free(t->body.threeNode.right);
	//free(t->body.threeNode.center);
	//free(t);
	break;      

case declaration_node:
if(t != NULL){
	printf ("\nIn declaration %s", t->body.threeNodeDeclaration.left);
	printtree (t->body.threeNodeDeclaration.right);
	printtree (t->body.threeNodeDeclaration.center); }
	//free(t->body.threeNodeDeclaration.center);
	//free(t->body.threeNodeDeclaration.left);
	//free(t->body.threeNodeDeclaration.right);
	//free(t);
	break;      
      
case two_node_operation:
	printf ("\ntwo node operation: %s", t->body.twoNodeOperation.op);
	printtree (t->body.twoNodeOperation.left);
	printtree (t->body.twoNodeOperation.right);
	//free(t->body.twoNodeOperation.right);
	//free(t->body.twoNodeOperation.left);
	//free(t->body.twoNodeOperation.op);
	//free(t);
	break;      

case two_node_stmt_seq:
	if(t->body.twoNodeStmtSeq.right != NULL && t->body.twoNodeStmtSeq.left != NULL && t->body.twoNodeStmtSeq.sc != '\0'){
	printtree (t->body.twoNodeStmtSeq.left);
        printf ("\ntwo node operation stmt seq: %c", t->body.twoNodeStmtSeq.sc);
	printtree (t->body.twoNodeStmtSeq.right);}
	//free(t->body.twoNodeStmtSeq.right);
	//free(t->body.twoNodeStmtSeq.left);
	//free(t);
	break;      

case two_node_ident_asgn:
        printf ("\ntwo node ident: %s", t->body.twoNodeIdentAsgn.left);
	printf ("\ntwo node ident: :=");
	printtree (t->body.twoNodeIdentAsgn.right);
	//free(t->body.twoNodeIdentAsgn.right);
	//free(t->body.twoNodeIdentAsgn.left);
	//free(t->body.twoNodeIdentAsgn.asgn);
	//free(t);
	break;      

case two_node_operationC:
	printtree (t->body.twoNodeOperationC.left);
        printf ("\ntwo node operation: %c", t->body.twoNodeOperationC.op);
	printtree (t->body.twoNodeOperationC.right);
	//free(t->body.twoNodeOperationC.right);
	//free(t->body.twoNodeOperationC.left);
	//free(t);
	break;      

case int_node:
        printf ("\n Type Int Node : %s", t->body.typeIntStruct.typeint);
	//free(t->body.typeIntStruct.typeint);
	//free(t);
	break;

case boolit_node:
        printf ("\n%s", t->body.boollitStruct.bool_lit);
	//free(t->body.boollitStruct.bool_lit);
	//free(t);
	break;
       	
     }
 }

static void genCode (tree *t) {

	switch(t->nodetype){
	  case one_node:
	  if(t->body.oneNode.left != NULL){
//		printf("in one node");
		genCode (t->body.oneNode.left);}
		break;
	  case one_node_condition:
	  if(t->body.oneNode.left != NULL){
//		printf("in one node");
		genCode (t->body.oneNode.left);}
		break;
	  case two_node:
		if(t->body.twoNode.left != NULL && t->body.twoNode.left->nodetype == 34){
			printf("\n#include <stdio.h>");
			printf("\nint main(int argc, char *argv[]){\n");
//			printf("\n before left");
			genCode (t->body.twoNode.left);
//			printf("\n after left");
			printf("\n");
			if(t->body.twoNode.right != NULL){
//			printf("\n in if");
				genCode (t->body.twoNode.right);
//			printf("\n before exiting out of if");
			}
//			printf("\n out of if");
		printf("\nreturn 0;");
		printf("\n}\n");
		}
		/*if(t->body.twoNode.right != NULL && t->body.twoNode.right->nodetype == 30){
			genCode (t->body.twoNode.left);
			//genCode (t->body.twoNode.right);
		}*/
		break;
	 case two_node_stmt_seq:
		if(t->body.twoNodeStmtSeq.left != (tree *)NULL && t->body.twoNodeStmtSeq.right != (tree *)NULL)
		{
//			printf("\nin two node stmt seq before left");
			genCode(t->body.twoNodeStmtSeq.left);
			if(t->body.twoNodeStmtSeq.left->nodetype != 47){
//			printf("\nin two node stmt seq before sc");
			printf("%c",t->body.twoNodeStmtSeq.sc); }
//			printf("\nin two node stmt seq after left before right");
			genCode(t->body.twoNodeStmtSeq.right);
//			printf("\nin two node stmt seq after right");
			break;
		}
		else if(t->body.twoNodeStmtSeq.left != (tree *)NULL && t->body.twoNodeStmtSeq.right == (tree *)NULL)
		{
//			printf("\ncalled here");
			genCode(t->body.twoNodeStmtSeq.left);
			printf("%c",t->body.twoNodeStmtSeq.sc); 
			break;
		}
		else
			break;
	
	case declaration_node:
	//	 printf("\nentered declaration node ");
			genCode(t->body.threeNodeDeclaration.right);
	//	printf("\nafter right node called and before int printed");
			printf("  %s;\n", t->body.threeNodeDeclaration.left );
	//	printf("\nafter int printed and before center called");
		if( strcmpi(t->body.threeNodeDeclaration.left,"true")!=0 && strcmpi(t->body.threeNodeDeclaration.left,"false")!=0)  
		{
		if(	install(t->body.threeNodeDeclaration.left, t->body.threeNodeDeclaration.right ) == 0)
				exit (0);


				if(t->body.threeNodeDeclaration.center != NULL){
				genCode(t->body.threeNodeDeclaration.center);}
		}	
		else
		{
		printf("\nERROR ^Identifier cannot be boolean Constants");  
		exit (0);
		}
		break;	
	

	case one_node_ident_asgn_readint:
		//		printf("in one node ident asgn");
			{
			symrec *ptr;
						printf("scanf(\"%%d\",&");
						printf("%s",t->body.oneNodeIdentAsgnReadInt.left);
						printf(")");
						
						if((ptr=getsym(t->body.oneNodeIdentAsgnReadInt.left))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
						{

						}
						else
						{printf("\nERROR: ^Identifier %s is not an Integer", t->body.oneNodeIdentAsgnReadInt.left);
						exit (0);	}
					}
			}
		
		

		break;
	case two_node_ident_asgn:

//		printf("\nbefore two node ident asgn left");
		printf("\n%s",t->body.twoNodeIdentAsgn.left);
//		printf("\nbefore two node ident asgn asgn");
		printf("= ");
//		printf("\nbefore two node ident asgn right");
		genCode(t->body.twoNodeIdentAsgn.right);
		
		if( t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.twoNodeOperationC.op=='-' || t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.twoNodeOperationC.op=='+' )
		{
		symrec *ptr;
					
		ptr=getsym(t->body.twoNodeIdentAsgn.left);
			if(ptr->type->nodetype!=int_node)
			{
				printf("\nERROR: ^%s Not of Integer Type", t->body.twoNodeIdentAsgn.left);			
				exit (0);	
			}
		}
		else if(t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.op=='*' || t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.op=='/'  || t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.op=='%' )
		{

		symrec *ptr;
					
		ptr=getsym(t->body.twoNodeIdentAsgn.left);
			if(ptr->type->nodetype!=int_node)
			{
				printf("\nERROR: ^%s Not of Integer Type", t->body.twoNodeIdentAsgn.left);			
				exit (0);	
			}
		





		} else if(t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype==ident_node 
			|| t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype==num_node){
			symrec *ptr;
			symrec *ptrRight;

			ptr=getsym(t->body.twoNodeIdentAsgn.left);
			if(t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype==ident_node)
				ptrRight= getsym(t->body.twoNodeIdentAsgn.right->body.oneNode.left->body.oneNode.left->body.oneNode.left->body.identStruct.ident);
			if(ptr->type->nodetype!=ptrRight->type->nodetype)
			{
				printf("\nERROR: ^%s Illegal assignment using boolean operand.", t->body.twoNodeIdentAsgn.left);			
				exit (0);	
			}
			
			
			}

		
		
		break;
	 case int_node:
		printf("int");
		break;
     case bool_node:
		printf("bool");
		break;
	case one_node_writeint:
		{		printf("\nprintf(\"%%d\",");
		int flag1=0;

		genCode(t->body.oneNode_writeInt.left);
		printf(")");
//		printf("\n---------------%d", t->body.oneNode_writeInt.left->nodetype);
//		printf("\n---------------%d", t->body.oneNode_writeInt.left->body.oneNode.left->nodetype);
//		printf("\n---------------%d", t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->nodetype);
//		printf("\n---------------%d", t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.left->nodetype);
//		printf("\n---------------%d", t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.right->nodetype);
		
//		printf("\n---------------%s",t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->body.identStruct.ident);

		if(t->body.oneNode_writeInt.left->body.oneNode.left->nodetype==two_node_operationC){
			if(t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.left->nodetype!= ident_node || t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.left->nodetype!= num_node){ 
				symrec *ptr;
							
						if(t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.left->nodetype== num_node)
						flag1 =0;
						else{
							if((ptr=getsym(t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.left->body.identStruct.ident))!=(symrec *)0)
							{
							if(ptr->type->nodetype==int_node)
								flag1 =0;
							else
								flag1 =1;
								
							}
							}
						
				}
				else
							flag1=1;
		if(flag1!=0)
			{printf("\nERROR: ^Attempt to print non integer value");		
			exit (0);}

//checking right
flag1=0;
if(t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.right->nodetype!= ident_node || t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.right->nodetype!= num_node){ 
				symrec *ptr;
							
						if(t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.right->nodetype== num_node)
						flag1 =0;
						else{
							if((ptr=getsym(t->body.oneNode_writeInt.left->body.oneNode.left->body.twoNodeOperationC.right->body.identStruct.ident))!=(symrec *)0)
							{
							if(ptr->type->nodetype==int_node)
								flag1 =0;
							else
								flag1 =1;
								
							}
							}
						
				}
				else
							flag1=1;
		if(flag1!=0)
			{printf("\nERROR: ^Attempt to print non integer value");		
			exit (0);}



		}
		else if(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->nodetype==two_node_operationC){
			if(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.left->nodetype!= ident_node || t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.left->nodetype!= num_node){ 
				symrec *ptr;
							
						if(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.left->nodetype== num_node)
						flag1 =0;
						else{
							if((ptr=getsym(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.left->body.identStruct.ident))!=(symrec *)0)
							{
							if(ptr->type->nodetype==int_node)
								flag1 =0;
							else
								flag1 =1;
								
							}
							}
						
				}
				else
							flag1=1;
		if(flag1!=0)
			{printf("\nERROR: ^Attempt to print non integer value");		
			exit (0);}

//checking right
flag1=0;
if(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.right->nodetype!= ident_node || t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.right->nodetype!= num_node){ 
				symrec *ptr;
							
						if(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.right->nodetype== num_node)
						flag1 =0;
						else{
							if((ptr=getsym(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.twoNodeOperationC.right->body.identStruct.ident))!=(symrec *)0)
							{
							if(ptr->type->nodetype==int_node)
								flag1 =0;
							else
								flag1 =1;
								
							}
							}
						
				}
				else
							flag1=1;
		if(flag1!=0)
			{printf("\nERROR: ^Attempt to print non integer value");		
			exit (0);}
		}
		else {
	//flag1=0;
		if(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype!= ident_node || t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype!= num_node){ 
			symrec *ptr;
						
					if(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== num_node)
					flag1 =0;
					else{
						if((ptr=getsym(t->body.oneNode_writeInt.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag1 =0;
						else
							flag1 =1;
							
						}
						}
					
			}
			else
						flag1=1;
					



			if(flag1!=0)
			{printf("\nERROR: ^Attempt to print non integer value");		
			exit (0);}		


		}

}
		break;	
    case two_node_operationC:
//		printf("\nin operation C before left");
	{
	
	int flag1 = 0;
	int flag2 = 0;
	int level =0;
	
		//	char variable = "t->body.twoNodeOperationC.left" ;
			
		//	variable = variable + "->oneNode.left";
	
		// t->body.twoNodeOperationC.left work for OP3
		// t->body.twoNodeOperationC.left->oneNode.left->
		
		//printf("First operator %c",t->body.twoNodeOperationC.op);
		if( t->body.twoNodeOperationC.op == '+' || t->body.twoNodeOperationC.op == '-'){ 
			level=0;
			//printf("Type ---%d",t->body.twoNodeOperationC.left->body.oneNode.left->nodetype);
				if(t->body.twoNodeOperationC.right->body.oneNode.left->nodetype==two_node_operationC){  
				//printf("------------1");
			//	if(t->body.twoNodeOperationC.left->body.oneNode.left->nodetype==two_node_operationC)
				//		printf("Helllooo -----------%d",t->body.twoNodeOperationC.left->body.oneNode.left->nodetype );
				genCode(t->body.twoNodeOperationC.left); 
				flag1=2;	}			
					else if( t->body.twoNodeOperationC.left->body.oneNode.left->nodetype== ident_node || t->body.twoNodeOperationC.left->body.oneNode.left->nodetype== num_node)
					{
					//printf("Helllooo 1-----------");
					symrec *ptr;
						
					if(t->body.twoNodeOperationC.left->body.oneNode.left->nodetype== num_node)
					flag1 =0;
					else{
						if((ptr=getsym(t->body.twoNodeOperationC.left->body.oneNode.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag1 =0;
						else
							flag1 =1;
							
						}
						}
					}		
					else
						flag1=1;
					
					
					}
					else if(t->body.twoNodeOperationC.op == '%' || t->body.twoNodeOperationC.op == '/' || t->body.twoNodeOperationC.op == '*') { 
					level=1;
					//printf("\nHelllooo -----------%d", t->body.twoNodeOperationC.left->nodetype);
					if(t->body.twoNodeOperationC.left->nodetype==one_node){
					//printf("------------2");		
					
					//if(t->body.twoNodeOperationC.left->body.oneNode.left->nodetype==two_node_operationC)
					{
					//printf("------------2");		
					genCode(t->body.twoNodeOperationC.left); flag1=2;} }				
					else if( t->body.twoNodeOperationC.left->nodetype== ident_node || t->body.twoNodeOperationC.left->nodetype== num_node) // || t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== ident_node || t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== num_node )
					{
					symrec *ptr;
						
					if(t->body.twoNodeOperationC.left->nodetype== num_node )//|| t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== num_node)
					flag1 =0;
					else {
						if((ptr=getsym(t->body.twoNodeOperationC.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag1 =0;
						else
							flag1 =1;
							
						} 
						
						/*else if((ptr=getsym(t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag1 =0;
						else
							flag1 =1;
							
						}*/



					}	}
					} else if(t->body.twoNodeOperationC.op == '>' || t->body.twoNodeOperationC.op == '=' || t->body.twoNodeOperationC.op == 'c' || t->body.twoNodeOperationC.op == '<' || t->body.twoNodeOperationC.op == '#' || t->body.twoNodeOperationC.op == '7' )
						{
						level=2;
						if(t->body.twoNodeOperationC.left->nodetype==one_node || t->body.twoNodeOperationC.left->nodetype==two_node_operationC){
					//if(t->body.twoNodeOperationC.left->body.oneNode.left->nodetype==two_node_operationC)
					{	genCode(t->body.twoNodeOperationC.left); flag1=2;}	}			
					else if( t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->nodetype== ident_node || t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->nodetype== num_node) // || t->body.twoNodeOperationC.left->body.oneNode.left->nodetype== ident_node || t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== num_node )
					{
					symrec *ptr;
						
					if(t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->nodetype== num_node )//|| t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== num_node)
					flag1 =0;
					else {
						if((ptr=getsym(t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag1 =0;
						else
							flag1 =1;
							
						} 
						
						/*else if((ptr=getsym(t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag1 =0;
						else
							flag1 =1;
							
						}*/



					}
					}


						}
					
					if(flag1==0)
					genCode(t->body.twoNodeOperationC.left);
					else if(flag1==1){
					if(level==0)
					printf("\nError: ^%s Operand is not an integer value ", t->body.twoNodeOperationC.left->body.identStruct.ident);
					if(level==1)
					printf("\nError: ^ %s Operand is not an integer value ", t->body.twoNodeOperationC.left->body.oneNode.left->body.identStruct.ident);
					if(level==2)
					printf("\nError: ^%s Operand is not an integer value ", t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.identStruct.ident);
					
					exit (0);
					
					}
					
					
	

	//	genCode(t->body.twoNodeOperationC.left);
//		printf("\nin operation C before op");
		if(t->body.twoNodeOperationC.op == 'c')
			printf(" <= ");
		else if(t->body.twoNodeOperationC.op == '7')
			printf(" >= ");
		else if(t->body.twoNodeOperationC.op == '=')
			printf(" == ");
		else if(t->body.twoNodeOperationC.op == '#')
			printf(" != ");
		else
			printf(" %c ", t->body.twoNodeOperationC.op);
//		printf("\nin operation C before right");
		
		int level2=0;	
		if( t->body.twoNodeOperationC.op == '+' || t->body.twoNodeOperationC.op == '-'){ 
					level2=0;
				if(t->body.twoNodeOperationC.right->nodetype==two_node_operationC){  
				//printf("------------ I am here 3");
					{	genCode(t->body.twoNodeOperationC.right); flag2=2;}	}			
					else if( t->body.twoNodeOperationC.right->body.oneNode.left->nodetype== ident_node || t->body.twoNodeOperationC.right->body.oneNode.left->nodetype== num_node)
					{
					symrec *ptr;
					//	printf("I am herer too 4");
					if(t->body.twoNodeOperationC.right->body.oneNode.left->nodetype== num_node)
					flag2 =0;
					else{
						if((ptr=getsym(t->body.twoNodeOperationC.right->body.oneNode.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag2 =0;
						else
							flag2 =1;
							
						}
						}
					}		
					else
						flag2=1;
					/*
					if(flag2==0)
					genCode(t->body.twoNodeOperationC.right);
					else {
					printf("\nError: ^%s Operand is not an integer value", t->body.twoNodeOperationC.right->body.oneNode.left->body.identStruct.ident);
					exit (0);
					}
					*/
					
					}
					else if(t->body.twoNodeOperationC.op == '%' || t->body.twoNodeOperationC.op == '/' || t->body.twoNodeOperationC.op == '*') { 
					level2=1;
					//printf("\nChecking right %d", t->body.twoNodeOperationC.right->nodetype);
					if(t->body.twoNodeOperationC.right->nodetype==one_node ){
					//	if(t->body.twoNodeOperationC.right->body.oneNode.left->nodetype==two_node_operationC)
					{	genCode(t->body.twoNodeOperationC.right); flag2=2;}	}			
					else if( t->body.twoNodeOperationC.right->nodetype== ident_node || t->body.twoNodeOperationC.right->nodetype== num_node)
					{
					symrec *ptr;
						
					if(t->body.twoNodeOperationC.right->nodetype== num_node)
					flag2 =0;
					else{
						if((ptr=getsym(t->body.twoNodeOperationC.right->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag2 =0;
						else
							flag2 =1;
							
						}
						}
					}	
					}	
					else if(t->body.twoNodeOperationC.op == '>' || t->body.twoNodeOperationC.op == '=' || t->body.twoNodeOperationC.op == 'c' || t->body.twoNodeOperationC.op == '<' || t->body.twoNodeOperationC.op == '#' || t->body.twoNodeOperationC.op == '7' )
						{
						level2=2;
					if( t->body.twoNodeOperationC.right->nodetype==two_node_operationC || t->body.twoNodeOperationC.right->body.oneNode.left->nodetype==two_node_operationC){
		//		if(t->body.twoNodeOperationC.right->body.oneNode.left->nodetype==two_node_operationC)
					{	
					
					genCode(t->body.twoNodeOperationC.right); 
					flag2=2;
					}	
					}			
					else if( t->body.twoNodeOperationC.right->body.oneNode.left->body.oneNode.left->nodetype== ident_node || t->body.twoNodeOperationC.right->body.oneNode.left->body.oneNode.left->nodetype== num_node) // || t->body.twoNodeOperationC.left->body.oneNode.left->nodetype== ident_node || t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== num_node )
					{
					symrec *ptr;
						
					if(t->body.twoNodeOperationC.right->body.oneNode.left->body.oneNode.left->nodetype== num_node )//|| t->body.twoNodeOperationC.left->body.oneNode.left->body.oneNode.left->body.oneNode.left->nodetype== num_node)
					flag1 =0;
					else {
						if((ptr=getsym(t->body.twoNodeOperationC.right->body.oneNode.left->body.oneNode.left->body.identStruct.ident))!=(symrec *)0)
						{
						if(ptr->type->nodetype==int_node)
							flag2 =0;
						else
							flag2 =1;
							
						} 
						
						



					}
					}


						}
					
					
					if(flag2==0)
					{genCode(t->body.twoNodeOperationC.right);break;}
					else {
					if(level2==0)
					printf("\nError: ^%s Operand is not an integer value ", t->body.twoNodeOperationC.right->body.identStruct.ident);
					if(level2==1)
					printf("\nError: ^%s Operand is not an integer value ", t->body.twoNodeOperationC.right->body.oneNode.left->body.identStruct.ident);
					if(level2==2)
					printf("\nError: ^%s Operand is not an integer value ", t->body.twoNodeOperationC.right->body.oneNode.left->body.oneNode.left->body.identStruct.ident);
					
					exit (0);
					}
					
		
		
		
		
	}
		
		
		//genCode(t->body.twoNodeOperationC.right);
		break;
	case num_node:
	printf("%lu", t->body.a_number);
	if( t->body.a_number >=0 && !t->body.a_number <= 2147483647)
	{
	}else
	{
	printf("\nERROR: ^ Number %lu outside of range", t->body.a_number);
	exit (0);
	
	}
	
				break;
	case ident_node:
		printf("%s", t->body.identStruct.ident);
		break;
	case two_node_while:
		printf("\nwhile( ");
//		printf("before two node left");
		genCode(t->body.twoNode.left);
	//	printf("after two node left");
		printf(" ) {\n");
	
		if(t->body.twoNode.left->body.twoNodeOperationC.op == '=' || t->body.twoNode.left->body.twoNodeOperationC.op == '#' || t->body.twoNode.left->body.twoNodeOperationC.op == '<' ||t->body.twoNode.left->body.twoNodeOperationC.op == '>' ||t->body.twoNode.left->body.twoNodeOperationC.op == 'c'|| t->body.twoNode.left->body.twoNodeOperationC.op == '7')
		{
		}
		else{
		printf("\n Boolean operators required inside conditional statement");
		exit (0);
		}
		genCode(t->body.twoNode.right);
		printf("\n}");



		break;
	case three_node:
		printf("\n if( ");
		genCode(t->body.threeNode.left);
		printf(") {\n");
		genCode(t->body.threeNode.right);
		printf("\n}");
		if(t->body.threeNode.center != NULL ){
		genCode(t->body.threeNode.center);}
		break;
	case one_node_else:
		if(t->body.oneNode.left != NULL){
		printf("\n else { \n");
		genCode(t->body.oneNode.left);
		printf("\n}");}
		break;
	case one_node_lprp:
		printf("\n ( ");
		genCode(t->body.oneNode.left);
		printf("\n ) ");
		break;	
	case boolit_node:
		printf(" %s ", t->body.boollitStruct.bool_lit);
		break;
	}
 }

 
%}

%union {
   unsigned long a_number;	char *b_boollit;		char *i_ident;		char a_LP;
   char a_RP;		char *a_ASGN;		char a_SC;		char a_OP2;
   char a_OP3;		char a_OP4;		char *a_program;	char *a_IF;
   char *a_THEN;	char *a_ELSE;				
   char *a_WHILE;	char *a_DO;		char *a_VAR;		char *a_AS;
   char *a_INT;		char *a_BOOL;		char *a_writeInt;	char *a_READINT;
   char *a_begin;	char *a_end;		char *a_var;
   char *a_as;   tree* a_tree;}
%start input
%token <a_begin> beg
%token <a_program> P_PROGRAM
%token <a_var> A_VAR
%token <a_as> A_AS
%token <a_end> A_END
%token <a_INT> INT
%token <a_SC> SC
%token <b_boollit> boollit		
%token <a_LP> LP
%token <a_RP> RP
%token <a_ASGN> ASGN
%token <a_IF> IF
%token <a_THEN> THEN
%token <a_ELSE> ELSE
%token <a_WHILE> WHILE
%token <a_DO> DO
%token <a_BOOL> BOOL
%token <a_writeInt> WRITEINT
%token <a_READINT> READINT
%token <i_ident> ident
%token <a_number> num			
%left <a_OP4> OP4
%left <a_OP3> OP3
%left <a_OP2> OP2
%type <a_tree> program declarations type statementSequence statement assignment ifStatement elseClause whileStatement writeInt expression simpleExpression term factor
%% 
input : program  {genCode($1);}  
        
program : P_PROGRAM declarations beg statementSequence A_END {$$=make_twoNode($2, $4);}
	;
declarations : A_VAR ident A_AS type SC declarations { $$=make_threeNodeDeclarations($2, $4, $6);}
              | /* empty */ { $$=make_threeNodeDeclarations((char *) NULL, (tree *)NULL, (tree *)NULL);}
	      ;
type : INT {$$=make_oneNodeIntBool($1); }
	| BOOL {$$=make_oneNodeBool($1);}
	;
statementSequence : statement SC statementSequence  {$$=make_twoNodeStmtSeq($1, $2, $3);}
        | /* empty */   { $$=make_twoNodeStmtSeq((tree *)NULL, (char) '\0', (tree *)NULL);}
		    ;
statement : assignment {$$=make_oneNode ($1);}
            | ifStatement {$$=make_oneNodeCondition ($1);}
            | whileStatement {$$=make_oneNodeCondition ($1);}
            | writeInt {$$=make_oneNode ($1);}
		;
assignment : ident ASGN expression {$$=make_twoNodeIdentAsgn ($1, $2, $3);}	
             | ident ASGN READINT {$$=make_oneNodeIdentAsgnReadInt ($1, $2, $3);}	
	     ;
ifStatement : IF expression THEN statementSequence elseClause A_END {$$=make_threeNodeIf($2, $4, $5);}	
		;
elseClause : ELSE statementSequence {$$=make_oneNodeElse( $2);}	
             | /* empty */ { $$=make_oneNodeElse((tree *)NULL);}
	      ;
whileStatement : WHILE expression DO statementSequence A_END {$$=make_twoNodeWhile ($2, $4);}	
		;
writeInt : WRITEINT expression {$$=make_oneNode_writeInt ($1, $2);}	
		;
expression : simpleExpression {$$=make_oneNode ($1);}
             | simpleExpression OP4 simpleExpression {$$=make_twoNodeOperationC ($1,$2, $3);}
		;
simpleExpression : term OP3 term {$$=make_twoNodeOperationC($1,$2, $3);}
                   | term {$$=make_oneNode ($1);}
		   ;
term : factor OP2 factor {$$=make_twoNodeOperationC ($1,$2, $3); }
       | factor {$$=make_oneNode ($1);}
       ;
factor : ident {$$=make_oneNodeIdent($1);}
         | num {$$=make_oneNodeNum($1);}
         | boollit {$$=make_oneNodeBoollit($1);}
         | LP expression RP {$$=make_oneNode_lprp($2);}	
	;
%%
// int main (void) {return yyparse();}

extern int yylex();
extern int yyparse();
extern FILE *yyin;

main() {
	// open a file handle to a particular file:
	FILE *myfile = fopen("test.txt", "r");
	// make sure it is valid:
	if (!myfile) {
		printf("failed!\n");
		return -1;
	}
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
	
}
 void yyerror (char *s) {fprintf (stderr, "%s\n", s);}
