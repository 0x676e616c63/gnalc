/**
 * @todo 注：ConstExp使用的Ident必须是常量 (尚未实现检查) (语言定义中ConstExp和Exp的不同之处之一)
 * @note 一些规则可以合并，看后续想法吧
 */

%code {
#include "ast2.hpp"
#include "parser.hpp"
extern std::shared_ptr<AST::DeclStmt> node;
using namespace AST;
extern yy::parser::symbol_type yylex ();
}

%code requires {
#include "ast2.hpp"
using namespace AST;
}

%language "C++"
%require "3.8.1"
%header "include/parser/parser.hpp"
%define api.token.raw
%define api.token.constructor
%define api.value.type variant
%define parse.assert

%token Y_INT Y_VOID Y_CONST Y_IF Y_ELSE Y_WHILE Y_BREAK Y_CONTINUE Y_RETURN Y_ADD Y_SUB Y_MUL Y_DIV Y_MODULO Y_LESS Y_LESSEQ Y_GREAT Y_GREATEQ Y_NOTEQ Y_EQ Y_NOT Y_AND Y_OR Y_ASSIGN Y_LPAR Y_RPAR Y_LBRACKET Y_RBRACKET Y_LSQUARE Y_RSQUARE Y_COMMA Y_SEMICOLON Y_FLOAT
%token <AST::int32> num_INT
%token <AST::float32> num_FLOAT
%token <AST::string> Y_ID

%type <AST::dtype> Type
%type <std::shared_ptr<AST::num>> Number

%type <std::shared_ptr<VarDef>> VarDefs VarDef ConstDefs ConstDef
%type <std::shared_ptr<DeclStmt>> VarDecl ConstDecl Decl
%type <std::shared_ptr<InitVal>> ConstInitVal InitVal ConstInitVals InitVals
%type <std::shared_ptr<ArraySubscript>> ConstAS ArraySubscripts
%type <std::shared_ptr<FuncDef>> FuncDef
%type <std::shared_ptr<FuncFParam>> FuncFParam FuncFParams
%type <std::shared_ptr<AddExp>> AddExp Exp ConstExp

%%

CompileUnit: CompUnit   { return $1; }
           ;

CompUnit: Decl CompUnit         {  }
        | FuncDef CompUnit      {  }
        | Decl                  {  }
        | FuncDef               {  }
        ;


Decl: ConstDecl     { $$ = $1; }
    | VarDecl       { $$ = $1; }
    ;

Type: Y_INT     { $$ = dtype::INT; }
    | Y_FLOAT   { $$ = dtype::FLOAT; }
    | Y_VOID    { $$ = dtype::VOID; }
    ;


ConstDecl: Y_CONST Type ConstDefs Y_SEMICOLON    { $$ = std::make_shared<DeclStmt>(true, $2, $3); }
         ;

ConstDefs: ConstDef                     { $$ = $1; }
         | ConstDef Y_COMMA ConstDefs   { $1->next = $3; $$ = $1; }
         ;

ConstDef: Y_ID Y_ASSIGN ConstInitVal            { $$ = std::make_shared<VarDef>($1, $3); }
        | Y_ID ConstAS Y_ASSIGN ConstInitVal    { $$ = std::make_shared<VarDef>($1, $2, $4); }
        ;

ConstAS: Y_LSQUARE ConstExp Y_RSQUARE             { $$ = std::make_shared<ArraySubscript>($2); }
         | Y_LSQUARE ConstExp Y_RSQUARE ConstAS   { auto p = std::make_shared<ArraySubscript>($2); p->next = $4; $$ = p; }
         ;

ConstExp: AddExp        { $$ = $1; }
        ;

ConstInitVal: ConstExp                                          { $$ = std::make_shared<InitVal>($1); }
            | Y_LBRACKET Y_RBRACKET                             { $$ = std::make_shared<InitVal>(); }
            | Y_LBRACKET ConstInitVals Y_RBRACKET               { $$ = std::make_shared<InitVal>($2); }
            ;

ConstInitVals: ConstInitVal                             { $$ = $1; }
             | ConstInitVal Y_COMMA ConstInitVals       { $1->next = $3; $$ = $1; }
             ;


VarDecl: Type VarDefs Y_SEMICOLON            { $$ = std::make_shared<DeclStmt>(false, $1, $2); }
       ;

VarDefs: VarDef                         { $$ = $1; }
       | VarDef Y_COMMA VarDefs         { $1->next = $3; $$ = $1; }
       ;

VarDef: Y_ID                            { $$ = std::make_shared<VarDef>($1); }
      | Y_ID ConstAS                    { $$ = std::make_shared<VarDef>($1, $2); }
      | Y_ID Y_ASSIGN InitVal           { $$ = std::make_shared<VarDef>($1, $3); }
      | Y_ID ConstAS Y_ASSIGN InitVal   { $$ = std::make_shared<VarDef>($1, $2, $4); }
      ;

InitVal: Exp                                    { $$ = std::make_shared<InitVal>($1); }
       | Y_LBRACKET Y_RBRACKET                  { $$ = std::make_shared<InitVal>(); }
       | Y_LBRACKET InitVals Y_RBRACKET         { $$ = std::make_shared<InitVal>($2); }
       ;

InitVals: InitVal                       { $$ = $1; }
        | InitVal Y_COMMA InitVals      { $1->next = $3; $$ = $1; }
        ;


FuncDef: Type Y_ID Y_LPAR Y_RPAR Block                  { $$ = std::make_shared<FuncDef>($1, $2, $5); }
       | Type Y_ID Y_LPAR FuncFParams Y_RPAR Block      { $$ = std::make_shared<FuncDef>($1, $2, $4, $6); }
       ;

FuncFParams: FuncFParam                       { $$ = $1; }
          | FuncFParam Y_COMMA FuncFParams    { $1->next = $3; $$ = $1; }
          ;

FuncFParam: Type Y_ID                                           { $$ = std::make_shared<FuncFParam>($1, $2); }
         | Type Y_ID Y_LSQUARE Y_RSQUARE                        { $$ = std::make_shared<FuncFParam>($1, $2, true); }
         | Type Y_ID Y_LSQUARE Y_RSQUARE ArraySubscripts        { $$ = std::make_shared<FuncFParam>($1, $2, $5); }
         ;

ArraySubscripts: Y_LSQUARE Exp Y_RSQUARE                        { $$ = std::make_shared<ArraySubscript>($2); }
               | Y_LSQUARE Exp Y_RSQUARE ArraySubscripts        { auto p = std::make_shared<ArraySubscript>($2); p->next = $4; $$ = p; }
               ;

Block: Y_LBRACKET Y_RBRACKET            { $$ = std::make_shared<CompStmt>(); }
     | Y_LBRACKET BlockItems Y_RBRACKET { $$ = $2; }
     ;

BlockItems: BlockItem                   { $$ = std::make_shared<CompStmt>($1); }
          | BlockItems BlockItem        { $1->addItem($2); $$ = $1; }
          ;

BlockItem: Decl { $$ = $1; }
         | Stmt { $$ = $1; }
         ;

Stmt: LVal Y_ASSIGN Exp Y_SEMICOLON                     {  }
    | Y_SEMICOLON                                       { $$ = std::make_shared<NullStmt>(); }
    | Exp Y_SEMICOLON                                   { $$ = $1; }
    | Block                                             { $$ = $1; }
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt                    { $$ = std::make_shared<IfStmt>($3, $5); }
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt Y_ELSE Stmt        { $$ = std::make_shared<IfStmt>($3, $5, $7); }
    | Y_WHILE Y_LPAR LOrExp Y_RPAR Stmt                 { $$ = std::make_shared<WhileStmt>($3, $5); }
    | Y_BREAK Y_SEMICOLON                               { $$ = std::make_shared<BreakStmt>(); }
    | Y_CONTINUE Y_SEMICOLON                            { $$ = std::make_shared<ContinueStmt>(); }
    | Y_RETURN Y_SEMICOLON                              { $$ = std::make_shared<ReturnStmt>(); }
    | Y_RETURN Exp Y_SEMICOLON                          { $$ = std::make_shared<ReturnStmt>($2); }
    ;

Exp: AddExp     { $$ = $1; }
   ;

LVal: Y_ID                      { $$ = std::make_shared<DeclRef>($1); }
    | Y_ID ArraySubscripts      { $$ = std::make_shared<ArrayExp>(std::make_shared<DeclRef>($1), $2); }
    ;

PrimaryExp: Y_LPAR Exp Y_RPAR   { $$ = std::make_shared<ParenExp>($2); }
          | LVal                { $$ = $1; }
          | Number              { $$ = $1; }
          ;

Number: num_INT             { $$ = std::make_shared<num>($1); }
      | num_FLOAT           { $$ = std::make_shared<num>($1); }
      ;

UnaryExp: PrimaryExp                    { $$ = $1; }
        | Y_ID Y_LPAR Y_RPAR            { $$ = std::make_shared<CallExp>(std::make_shared<DeclRef>($1)); }
        | Y_ID Y_LPAR FuncRParams Y_RPAR { $$ = std::make_shared<CallExp>(std::make_shared<DeclRef>($1), $3); }
        | Y_ADD UnaryExp                {  }
        | Y_SUB UnaryExp                {  }
        | Y_NOT UnaryExp                {  }
        ;

FuncRParams: Exp                        { $$ = std::shared_ptr<FuncRParams>($1); }
          | Exp Y_COMMA FuncRParams     { $1->next = $3; $$ = $1; }
          ;

MulExp: UnaryExp                        {  }
      | MulExp Y_MUL UnaryExp           {  }
      | MulExp Y_DIV UnaryExp           {  }
      | MulExp Y_MODULO UnaryExp        {  }
      ;

AddExp: MulExp                  {  }
      | AddExp Y_ADD MulExp     {  }
      | AddExp Y_SUB MulExp     {  }
      ;

RelExp: AddExp                  {  }
      | RelExp Y_LESS AddExp    {  }
      | RelExp Y_GREAT AddExp   {  }
      | RelExp Y_LESSEQ AddExp  {  }
      | RelExp Y_GREATEQ AddExp {  }
      ;

EqExp: RelExp                   {  }
     | EqExp Y_EQ RelExp        {  }
     | EqExp Y_NOTEQ RelExp     {  }
     ;

LAndExp: EqExp                  {  }
       | LAndExp Y_AND EqExp    {  }
       ;

LOrExp: LAndExp                 {  }
      | LorExp Y_OR LAndExp     {  }
      ;

%%

void yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}
