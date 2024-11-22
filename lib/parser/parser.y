/**
 * @todo use variant to replace union
 * @todo 使用完整类型代替数值型的yylex返回值
 * @todo 使用变体时，必须正确构造和销毁符号。 assart
 * @todo  注：ConstExp使用的Ident必须是常量
 */

%code {

#include "../../include/parser/ast.hpp"
#include "../../include/parser/parser.hpp"
extern "C" int yylex();
using namespace AST;
// using enum yy::parser::token::token_kind_type;

}

%code requires {
#include "../../include/parser/ast.hpp"
// using namespace AST;
}

%language "C++"
%require "3.8.1"
%header "include/parser/parser.hpp"
%define api.token.raw
%define api.token.constructor
%define api.value.type variant
%define parse.assert

%token Y_INT Y_VOID Y_CONST Y_IF Y_ELSE Y_WHILE Y_BREAK Y_CONTINUE Y_RETURN Y_ADD Y_SUB Y_MUL Y_DIV Y_MODULO Y_LESS Y_LESSEQ Y_GREAT Y_GREATEQ Y_NOTEQ Y_EQ Y_NOT Y_AND Y_OR Y_ASSIGN Y_LPAR Y_RPAR Y_LBRACKET Y_RBRACKET Y_LSQUARE Y_RSQUARE Y_COMMA Y_SEMICOLON Y_FLOAT
// %type <AST::past> CompileUnit CompUnit Decl ConstDecl ConstDefs ConstDef ConstExp ConstAS ConstInitVal ConstInitVals VarDecl VarDefs VarDef InitVal InitVals FuncDef FuncFParams FuncFParam ArraySubscripts Block BlockItems BlockItem Stmt Exp LVal PrimaryExp UnaryExp FuncRParams MulExp AddExp RelExp EqExp LAndExp LOrExp
%type <AST::dtype> Type
%type <AST::num> Number
%token <AST::int32> num_INT
%token <AST::float32> num_FLOAT
%token <AST::string> Y_ID

%type <std::shared_ptr<VarDef>> VarDefs VarDef ConstDefs ConstDef
%type <std::shared_ptr<DeclStmt>> VarDecl ConstDecl Decl
%type <std::shared_ptr<InitVal>> ConstInitVal InitVal ConstInitVals InitVals
%type <std::shared_ptr<ArraySubscript>> ConstAS ArraySubscripts
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
         | ConstDef Y_COMMA ConstDefs   { $$ = $1->link($3); }
         ;

ConstDef: Y_ID Y_ASSIGN ConstInitVal            { $$ = std::make_shared<VarDef>($1, $3); }
        | Y_ID ConstAS Y_ASSIGN ConstInitVal    { $$ = std::make_shared<VarDef>($1, $2, $4); }
        ;

ConstAS: Y_LSQUARE ConstExp Y_RSQUARE             { $$ = std::make_shared<ArraySubscript>($2); }
         | Y_LSQUARE ConstExp Y_RSQUARE ConstAS   { $$ = std::make_shared<ArraySubscript>($2)->link($4); }
         ;

ConstExp: AddExp        { $$ = $1; }
        ;

ConstInitVal: ConstExp                                          { $$ = std::make_shared<InitVal>($1); }
            | Y_LBRACKET Y_RBRACKET                             { $$ = std::make_shared<InitVal>(); }
            | Y_LBRACKET ConstInitVals Y_RBRACKET               { $$ = std::make_shared<InitVal>($2); }
            ;

ConstInitVals: ConstInitVal                             { $$ = $1; }
             | ConstInitVal Y_COMMA ConstInitVals       { $$ = $1->link($3); }
             ;


VarDecl: Type VarDefs Y_SEMICOLON            { $$ = std::make_shared<DeclStmt>(false, $1, $2); }
       ;

VarDefs: VarDef                         { $$ = $1; }
       | VarDef Y_COMMA VarDefs         { $$ = $1->link($3); }
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
        | InitVal Y_COMMA InitVals      { $$ = $1->link($3); }
        ;


FuncDef: Type Y_ID Y_LPAR Y_RPAR Block              {  }
       | Type Y_ID Y_LPAR FuncFParams Y_RPAR Block   {  }
       ;

FuncFParams: FuncFParam                       {  }
          | FuncFParam Y_COMMA FuncFParams    {  }
          ;

FuncFParam: Type Y_ID                                            {  }
         | Type Y_ID Y_LSQUARE Y_RSQUARE                        {  }
         | Type Y_ID Y_LSQUARE Y_RSQUARE ArraySubscripts        {  }
         ;

ArraySubscripts: Y_LSQUARE Exp Y_RSQUARE                        { $$ = std::make_shared<ArraySubscript>($2); }
               | Y_LSQUARE Exp Y_RSQUARE ArraySubscripts        { $$ = std::make_shared<ArraySubscript>($2)->link($4); }
               ;

Block: Y_LBRACKET Y_RBRACKET            {  }
     | Y_LBRACKET BlockItems Y_RBRACKET {  }
     ;

BlockItems: BlockItem                   {  }
          | BlockItem BlockItems        {  }
          ;

BlockItem: Decl {  }
         | Stmt {  }
         ;

Stmt: LVal Y_ASSIGN Exp Y_SEMICOLON                     {  }
    | Y_SEMICOLON                                       {  }
    | Exp Y_SEMICOLON                                   {  }
    | Block                                             {  }
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt                    {  }
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt Y_ELSE Stmt        {  }
    | Y_WHILE Y_LPAR LOrExp Y_RPAR Stmt                 {  }
    | Y_BREAK Y_SEMICOLON                               {  }
    | Y_CONTINUE Y_SEMICOLON                            {  }
    | Y_RETURN Y_SEMICOLON                              {  }
    | Y_RETURN Exp Y_SEMICOLON                          {  }
    ;

Exp: AddExp     { $$ = $1; }
   ;

LVal: Y_ID                      {  }
    | Y_ID ArraySubscripts      {  }
    ;

PrimaryExp: Y_LPAR Exp Y_RPAR   {  }
          | LVal                {  }
          | Number              {  }
          ;

Number: num_INT             {  }
      | num_FLOAT           {  }
      ;

UnaryExp: PrimaryExp                    {  }
        | Y_ID Y_LPAR Y_RPAR            {  }
        | Y_ID Y_LPAR FuncRParams Y_RPAR {  }
        | Y_ADD UnaryExp                {  }
        | Y_SUB UnaryExp                {  }
        | Y_NOT UnaryExp                {  }
        ;

FuncRParams: Exp                         {  }
          | Exp Y_COMMA FuncRParams      {  }
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
