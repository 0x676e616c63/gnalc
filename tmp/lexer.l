/**
 * @todo mutiple comments' regular expression need to be completed
 * @attention no negative integers and floats, they are considered as unary expressions
 */

%{

#include "parser.hpp"
#include <cstdlib>
#define YY_DECL yy::parser::symbol_type yylex ()

%}

%option noyywrap nounput noinput

%%
[0-9]+ { return yy::parser::make_num_INT((AST::int32)atoi(yytext)); }

(([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+))([eE][\+-]?[0-9]+)? { return yy::parser::make_num_FLOAT((AST::float32)atof(yytext)); }

"int" { return yy::parser::make_Y_INT(); }
"void" { return yy::parser::make_Y_VOID(); }
"float" { return yy::parser::make_Y_FLOAT(); }
"const" { return yy::parser::make_Y_CONST(); }

[a-zA-Z_][a-zA-Z0-9_]* { return yy::parser::make_Y_ID(yytext); }

"=" { return yy::parser::make_Y_ASSIGN(); }

"(" { return yy::parser::make_Y_LPAR(); }
")" { return yy::parser::make_Y_RPAR(); }
"{" { return yy::parser::make_Y_LBRACKET(); }
"}" { return yy::parser::make_Y_RBRACKET(); }
"[" { return yy::parser::make_Y_LSQUARE(); }
"]" { return yy::parser::make_Y_RSQUARE(); }
"," { return yy::parser::make_Y_COMMA(); }
";" { return yy::parser::make_Y_SEMICOLON(); }

[ \t\n] { /* ignore whitespace */ }
\/\/[^\n]*\n? { /* ignore comments */ }
\/\*.*\*\/ { /* ignore comments */ }
. { /* yyerror("invalid character"); */ }
%%

