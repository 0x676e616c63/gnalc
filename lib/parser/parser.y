%{

#include "../../include/parser/ast.hpp"
extern "C" int yylex();

using namespace AST;

%}

%code requires{
#include "../../include/parser/ast.hpp"
using namespace AST;
}

%language "C++"
%require "3.2"

%union {
        int	token;
        int32	int_value;
        float32 float_value;
        string	id_name;
        past    pAst;
};

%token Y_INT Y_VOID Y_CONST Y_IF Y_ELSE Y_WHILE Y_BREAK Y_CONTINUE Y_RETURN Y_ADD Y_SUB Y_MUL Y_DIV Y_MODULO Y_LESS Y_LESSEQ Y_GREAT Y_GREATEQ Y_NOTEQ Y_EQ Y_NOT Y_AND Y_OR Y_ASSIGN Y_LPAR Y_RPAR Y_LBRACKET Y_RBRACKET Y_LSQUARE Y_RSQUARE Y_COMMA Y_SEMICOLON Y_FLOAT
%type <pAst> CompUnit Decl ConstDecl ConstDefs ConstDef ConstExps ConstInitVal ConstInitVals VarDecl VarDecls VarDef InitVal InitVals FuncDef FuncParams FuncParam Block BlockItems BlockItem Stmt Exp LVal ArraySubscripts PrimaryExp UnaryExp CallParams MulExp AddExp RelExp EqExp LAndExp LOrExp ConstExp
%type <token> Type
%token <int_value> num_INT
%token <float_value> num_FLOAT
%token <id_name> Y_ID

%%

CompileUnit: CompUnit   { showAst($1, 0, true); }
           ;

CompUnit: Decl CompUnit         { $$ = addNode($1, $2); }
        | FuncDef CompUnit      { $$ = addNode($1, $2); }
        | Decl                  { $$ = $1; }
        | FuncDef               { $$ = $1; }
        ;

Decl: ConstDecl     { $$ = $1; }
    | VarDecl       { $$ = $1; }
    ;

ConstDecl: Y_CONST Type ConstDef Y_SEMICOLON    { SetDeclsType($3, $2); $$ = $3; }
         | Y_CONST Type ConstDefs Y_SEMICOLON   { SetDeclsType($3, $2); $$ = $3; }
         ;

ConstDefs: ConstDef Y_COMMA ConstDef    { $$ = addNode($1, $3); }
         | ConstDefs Y_COMMA ConstDef   { $$ = addNode($1, $3); }
         ;

ConstDef: Y_ID Y_ASSIGN ConstInitVal            { $$ = newVarDecl(UNDEFINED, $1, $3, NULL); }
        | Y_ID ConstExps Y_ASSIGN ConstInitVal  { $$ = newVarDecl(UNDEFINED, $1, $4, NULL); }
        ;

ConstExps: Y_LSQUARE ConstExp Y_RSQUARE             { $$ = $2; }
         | Y_LSQUARE ConstExp Y_RSQUARE ConstExps   { $$ = addNode($2, $4); } // TODO
         ;

ConstInitVal: ConstExp                                          { $$ = $1; }
            | Y_LBRACKET Y_RBRACKET                             { $$ = newInitList(NULL, NULL); }
            | Y_LBRACKET ConstInitVal Y_RBRACKET                { $$ = newInitList($2, NULL); }
            | Y_LBRACKET ConstInitVal ConstInitVals Y_RBRACKET  { $$ = newInitList($2, $3); }
            ;

ConstInitVals: Y_COMMA ConstInitVal                 { $$ = $2; }
             | Y_COMMA ConstInitVal ConstInitVals   { $$ = addNode($2, $3); }
             ;

VarDecl: Type VarDef Y_SEMICOLON            { SetDeclsType($2, $1); $$ = $2; }
       | Type VarDef VarDecls Y_SEMICOLON   { addNode($2, $3); SetDeclsType($2, $1); $$ = $2; }
       ;

VarDecls: Y_COMMA VarDef            { $$ = $2; }
        | Y_COMMA VarDef VarDecls   { $$ = addNode($2, $3); }
        ;

VarDef: Y_ID                            { $$ = newVarDecl(UNDEFINED, $1, NULL, NULL); }
      | Y_ID Y_ASSIGN InitVal           { $$ = newVarDecl(UNDEFINED, $1, $3, NULL); }
      | Y_ID ConstExps                  { $$ = newVarDecl(UNDEFINED, $1, NULL, NULL); }
      | Y_ID ConstExps Y_ASSIGN InitVal { $$ = newVarDecl(UNDEFINED, $1, $4, NULL); }
      ;

InitVal: Exp                                    { $$ = $1; }
       | Y_LBRACKET Y_RBRACKET                  { $$ = newInitList(NULL, NULL); }
       | Y_LBRACKET InitVal Y_RBRACKET          { $$ = newInitList($2, NULL); }
       | Y_LBRACKET InitVal InitVals Y_RBRACKET { $$ = newInitList($2, $3); }
       ;

InitVals: Y_COMMA InitVal           { $$ = $2; }
        | Y_COMMA InitVal InitVals  { $$ = addNode($2, $3); }
        ;

FuncDef: Type Y_ID Y_LPAR Y_RPAR Block              { $$ = newFuncDef($1, $2, NULL, $5); }
       | Type Y_ID Y_LPAR FuncParams Y_RPAR Block   { $$ = newFuncDef($1, $2, $4, $6); }
       ;

FuncParams: FuncParam                       { $$ = $1; }
          | FuncParams Y_COMMA FuncParam    { $$ = addNode($1, $3); }
          ;

FuncParam: Type Y_ID                                            { $$ = newFuncParam($1, $2, NULL, NULL); }
         | Type Y_ID Y_LSQUARE Y_RSQUARE                        { $$ = newFuncParam($1, $2, NULL, NULL); }
         | Type Y_ID ArraySubscripts                            { $$ = newFuncParam($1, $2, NULL, NULL); }
         | Type Y_ID Y_LSQUARE Y_RSQUARE ArraySubscripts        { $$ = newFuncParam($1, $2, NULL, NULL); } //TODO
         ;

Block: Y_LBRACKET BlockItems Y_RBRACKET { $$ = newBlock($2); }
     | Y_LBRACKET Y_RBRACKET            { $$ = newBlock(NULL); }
     ;

BlockItems: BlockItem                   { $$ = $1; }
          | BlockItem BlockItems        { $$ = addNode($1, $2); }
          ;

BlockItem: Decl { $$ = newDeclStmt($1); }
         | Stmt { $$ = $1; }
         ;

Stmt: LVal Y_ASSIGN Exp Y_SEMICOLON                     { $$ = newBinaryOp(Y_ASSIGN, $1, $3); }
    | Y_SEMICOLON                                       { $$ = newAstNode(NULL_STMT); }
    | Exp Y_SEMICOLON                                   { $$ = $1; }
    | Block                                             { $$ = $1; }
    | Y_WHILE Y_LPAR LOrExp Y_RPAR Stmt                 { $$ = newWhileStmt($3, $5); }
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt                    { $$ = newIfStmt($3, $5, NULL); }
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt Y_ELSE Stmt        { $$ = newIfStmt($3, $5, $7); }
    | Y_BREAK Y_SEMICOLON                               { $$ = newAstNode(BREAK_STMT); }
    | Y_CONTINUE Y_SEMICOLON                            { $$ = newAstNode(CONTINUE_STMT); }
    | Y_RETURN Exp Y_SEMICOLON                          { $$ = newReturnStmt($2); }
    | Y_RETURN Y_SEMICOLON                              { $$ = newReturnStmt(NULL); }
    ;

Exp: AddExp     { $$ = $1; }
   ;

LVal: Y_ID                      { $$ = newDeclRef($1, NULL); }
    | Y_ID ArraySubscripts      { $$ = newArraySubscripts(newDeclRef($1, NULL), $2); }
    ;

ArraySubscripts: Y_LSQUARE Exp Y_RSQUARE                        { $$ = $2; }
               | Y_LSQUARE Exp Y_RSQUARE ArraySubscripts        { $$ = addNode($2, $4); }
               ;

PrimaryExp: Y_LPAR Exp Y_RPAR   { $$ = newParenExp($2); }
          | LVal                { $$ = $1; }
          | num_INT             { $$ = newInt($1); }
          | num_FLOAT           { $$ = newInt((int)$1); }
          ;

UnaryExp: PrimaryExp                    { $$ = $1; }
        | Y_ID Y_LPAR Y_RPAR            { $$ = newCallExp(newDeclRef($1, NULL), NULL); }
        | Y_ID Y_LPAR CallParams Y_RPAR { $$ = newCallExp(newDeclRef($1, NULL), $3); }
        | Y_ADD UnaryExp                { $$ = newUnaryOp(Y_ADD, $2); }
        | Y_SUB UnaryExp                { $$ = newUnaryOp(Y_SUB, $2); }
        | Y_NOT UnaryExp                { $$ = newUnaryOp(Y_NOT, $2); }
        ;

CallParams: Exp                         { $$ = $1; }
          | Exp Y_COMMA CallParams      { $$ = addNode($1, $3);; }
          ;

MulExp: UnaryExp                        { $$ = $1; }
      | MulExp Y_MUL UnaryExp           { $$ = newBinaryOp(Y_MUL, $1, $3); }
      | MulExp Y_DIV UnaryExp           { $$ = newBinaryOp(Y_DIV, $1, $3); }
      | MulExp Y_MODULO UnaryExp        { $$ = newBinaryOp(Y_MODULO, $1, $3); }
      ;

AddExp: MulExp                  { $$ = $1; }
      | AddExp Y_ADD MulExp     { $$ = newBinaryOp(Y_ADD, $1, $3); }
      | AddExp Y_SUB MulExp     { $$ = newBinaryOp(Y_SUB, $1, $3); }
      ;

RelExp: AddExp                  { $$ = $1; }
      | AddExp Y_LESS RelExp    { $$ = newBinaryOp(Y_LESS, $1, $3); }
      | AddExp Y_GREAT RelExp   { $$ = newBinaryOp(Y_GREAT, $1, $3); }
      | AddExp Y_LESSEQ RelExp  { $$ = newBinaryOp(Y_LESSEQ, $1, $3); }
      | AddExp Y_GREATEQ RelExp { $$ = newBinaryOp(Y_GREATEQ, $1, $3); }
      ;

EqExp: RelExp                   { $$ = $1; }
     | RelExp Y_EQ EqExp        { $$ = newBinaryOp(Y_EQ, $1, $3); }
     | RelExp Y_NOTEQ EqExp     { $$ = newBinaryOp(Y_NOTEQ, $1, $3); }
     ;

LAndExp: EqExp                  { $$ = $1; }
       | EqExp Y_AND LAndExp    { $$ = newBinaryOp(Y_AND, $1, $3); }
       ;

LOrExp: LAndExp                 { $$ = $1; }
      | LAndExp Y_OR LOrExp     { $$ = newBinaryOp(Y_OR, $1, $3); }
      ;

ConstExp: AddExp        { $$ = $1; }
        ;

Type: Y_INT     { $$ = Y_INT; }
    | Y_FLOAT   { $$ = Y_FLOAT; }
    | Y_VOID    { $$ = Y_VOID; }
    ;

%%

void yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}
