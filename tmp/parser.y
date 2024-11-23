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
%header
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
%type <std::shared_ptr<ArraySubscript>> ConstAS
%type <std::shared_ptr<AddExp>> AddExp Exp ConstExp

%%

Decl: ConstDecl     { node = $1; }
    | VarDecl       { node = $1; }
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

Number: num_INT             { $$ = std::make_shared<num>($1); }
      | num_FLOAT           { $$ = std::make_shared<num>($1); }
      ;

Exp : AddExp      { $$ = $1; }
    ;

AddExp: Number              { $$ = std::make_shared<AddExp>($1); }
      ;

%%

void
yy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}
