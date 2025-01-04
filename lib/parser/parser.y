/**
 * @todo 注：ConstExp使用的Ident必须是常量 (尚未实现检查) (语言定义中ConstExp和Exp的不同之处之一)
 * @note 一些规则可以合并，看后续想法吧
 */

%code {
#include "../../include/parser/ast.hpp"
extern std::shared_ptr<AST::CompUnit> node;
using namespace AST;
extern yy::parser::symbol_type yylex ();
extern int yylineno;
}

%code requires {
#include "ast.hpp"
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

%type <std::shared_ptr<CompUnit>> CompUnit
%type <std::shared_ptr<VarDef>> VarDefs VarDef ConstDefs ConstDef
%type <std::shared_ptr<DeclStmt>> VarDecl ConstDecl
%type <std::shared_ptr<InitVal>> ConstInitVal InitVal ConstInitVals InitVals
%type <std::shared_ptr<ArraySubscript>> ConstAS ArraySubscripts
%type <std::shared_ptr<FuncDef>> FuncDef
%type <std::shared_ptr<FuncFParam>> FuncFParam FuncFParams
%type <std::shared_ptr<FuncRParam>> FuncRParams
%type <std::shared_ptr<Exp>> Exp ConstExp LVal PrimaryExp UnaryExp MulExp AddExp RelExp EqExp LAndExp LOrExp Number
%type <std::shared_ptr<Stmt>> Decl Stmt BlockItem
%type <std::shared_ptr<CompStmt>> Block BlockItems

%%

CompileUnit: CompUnit   { node = $1; }
           ;

CompUnit: CompUnit Decl         { $1->addNode($2); $$ = $1; }
        | CompUnit FuncDef      { $1->addNode($2); $$ = $1; }
        | Decl                  { $$ = std::make_shared<CompUnit>($1); }
        | FuncDef               { $$ = std::make_shared<CompUnit>($1); }
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

Stmt: LVal Y_ASSIGN Exp Y_SEMICOLON                     { $$ = std::make_shared<BinaryOp>(BiOp::ASSIGN, $1, $3); }
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

Number: num_INT             { $$ = std::make_shared<IntLiteral>($1); }
      | num_FLOAT           { $$ = std::make_shared<FloatLiteral>($1); }
      ;

UnaryExp: PrimaryExp                    { $$ = $1; }
        | Y_ID Y_LPAR Y_RPAR            {
                                            if($1 == "starttime")
                                            {
                                                $$ = std::make_shared<CallExp>(std::make_shared<DeclRef>("_sysy_starttime"), std::make_shared<FuncRParam>(std::make_shared<IntLiteral>(yylineno)));
                                            }
                                            else if($1 == "stoptime")
                                            {
                                                $$ = std::make_shared<CallExp>(std::make_shared<DeclRef>("_sysy_stoptime"), std::make_shared<FuncRParam>(std::make_shared<IntLiteral>(yylineno)));
                                            }
                                            else
                                            {
                                                $$ = std::make_shared<CallExp>(std::make_shared<DeclRef>($1));
                                            }
                                        }
        | Y_ID Y_LPAR FuncRParams Y_RPAR { $$ = std::make_shared<CallExp>(std::make_shared<DeclRef>($1), $3); }
        | Y_ADD UnaryExp                { $$ = std::make_shared<UnaryOp>(UnOp::ADD, $2); }
        | Y_SUB UnaryExp                { $$ = std::make_shared<UnaryOp>(UnOp::SUB, $2); }
        | Y_NOT UnaryExp                { $$ = std::make_shared<UnaryOp>(UnOp::NOT, $2); }
        ;

FuncRParams: Exp                        { $$ = std::make_shared<FuncRParam>($1); }
          | Exp Y_COMMA FuncRParams     { auto p = std::make_shared<FuncRParam>($1); p->next = $3; $$ = p; }
          ;

MulExp: UnaryExp                        { $$ = $1; }
      | MulExp Y_MUL UnaryExp           { $$ = std::make_shared<BinaryOp>(BiOp::MUL, $1, $3); }
      | MulExp Y_DIV UnaryExp           { $$ = std::make_shared<BinaryOp>(BiOp::DIV, $1, $3); }
      | MulExp Y_MODULO UnaryExp        { $$ = std::make_shared<BinaryOp>(BiOp::MOD, $1, $3); }
      ;

AddExp: MulExp                  { $$ = $1; }
      | AddExp Y_ADD MulExp     { $$ = std::make_shared<BinaryOp>(BiOp::ADD, $1, $3); }
      | AddExp Y_SUB MulExp     { $$ = std::make_shared<BinaryOp>(BiOp::SUB, $1, $3); }
      ;

RelExp: AddExp                  { $$ = $1; }
      | RelExp Y_LESS AddExp    { $$ = std::make_shared<BinaryOp>(BiOp::LESS, $1, $3); }
      | RelExp Y_GREAT AddExp   { $$ = std::make_shared<BinaryOp>(BiOp::GREAT, $1, $3); }
      | RelExp Y_LESSEQ AddExp  { $$ = std::make_shared<BinaryOp>(BiOp::LESSEQ, $1, $3); }
      | RelExp Y_GREATEQ AddExp { $$ = std::make_shared<BinaryOp>(BiOp::GREATEQ, $1, $3); }
      ;

EqExp: RelExp                   { $$ = $1; }
     | EqExp Y_EQ RelExp        { $$ = std::make_shared<BinaryOp>(BiOp::EQ, $1, $3); }
     | EqExp Y_NOTEQ RelExp     { $$ = std::make_shared<BinaryOp>(BiOp::NOTEQ, $1, $3); }
     ;

LAndExp: EqExp                  { $$ = $1; }
       | LAndExp Y_AND EqExp    { $$ = std::make_shared<BinaryOp>(BiOp::AND, $1, $3); }
       ;

LOrExp: LAndExp                 { $$ = $1; }
      | LOrExp Y_OR LAndExp     { $$ = std::make_shared<BinaryOp>(BiOp::OR, $1, $3); }
      ;

%%

void setFileName(const char *name) {
  strcpy(filename, name);
  freopen(filename, "r", stdin);
}

void
yy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}
