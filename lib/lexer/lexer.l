/**
 * @todo mutiple comments' regular expression need to be completed
 * @attention no negative integers and floats, they are considered as unary expressions
 * @todo 通配符的yyerror()未使用，yyerror在parser.y中随便定义的，需检查和应用(MAYBE)
 */

%{

#include "parser.hpp"
#include <cstdlib> // just for atoi, atof, strtol, strtof
#define YY_DECL yy::parser::symbol_type yylex ()

%}

%option noyywrap nounput noinput

%%
[0-9]+ { return yy::parser::make_num_INT((AST::int32)atoi(yytext)); }
0[0-7]+ { return yy::parser::make_num_INT((AST::int32)strtol(yytext, NULL, 8)); }
0[xX][0-9a-fA-F]+ { return yy::parser::make_num_INT((AST::int32)strtol(yytext, NULL, 16)); }

(([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+))([eE][\+-]?[0-9]+)? { return yy::parser::make_num_FLOAT((AST::float32)atof(yytext)); }
[0-9]+[eE][\+-]?[0-9]+ { return yy::parser::make_num_FLOAT((AST::float32)atof(yytext)); }
0[xX](([0-9a-fA-F]+)|([0-9a-fA-F]+\.[0-9a-fA-F]*)|([0-9a-fA-F]*\.[0-9a-fA-F]+))[pP][\+-]?[0-9]+ { return yy::parser::make_num_FLOAT((AST::float32)strtof(yytext, NULL)); }

"int" { return yy::parser::make_Y_INT; }
"void" { return yy::parser::make_Y_VOID; }
"float" { return yy::parser::make_Y_FLOAT; }
"const" { return yy::parser::make_Y_CONST; }
"if" { return yy::parser::make_Y_IF; }
"else" { return yy::parser::make_Y_ELSE; }
"while" { return yy::parser::make_Y_WHILE; }
"break" { return yy::parser::make_Y_BREAK; }
"continue" { return yy::parser::make_Y_CONTINUE; }
"return" { return yy::parser::make_Y_RETURN; }

[a-zA-Z_][a-zA-Z0-9_]* { return yy::parser::make_Y_ID(yytext); }

"+" { return yy::parser::make_Y_ADD; }
"-" { return yy::parser::make_Y_SUB; }
"*"	{ return yy::parser::make_Y_MUL; }
"/"	{ return yy::parser::make_Y_DIV; }
"<=" { return yy::parser::make_Y_LESSEQ; }
"<"	{ return yy::parser::make_Y_LESS; }
">=" { return yy::parser::make_Y_GREATEQ; }
">"	{ return yy::parser::make_Y_GREAT; }
"!=" { return yy::parser::make_Y_NOTEQ; }
"!" { return yy::parser::make_Y_NOT; }
"&&" { return yy::parser::make_Y_AND; }
"||" { return yy::parser::make_Y_OR; }
"%"	{ return yy::parser::make_Y_MODULO; }
"==" { return yy::parser::make_Y_EQ; }
"=" { return yy::parser::make_Y_ASSIGN; }

"(" { return yy::parser::make_Y_LPAR; }
")" { return yy::parser::make_Y_RPAR; }
"{" { return yy::parser::make_Y_LBRACKET; }
"}" { return yy::parser::make_Y_RBRACKET; }
"[" { return yy::parser::make_Y_LSQUARE; }
"]" { return yy::parser::make_Y_RSQUARE; }
"," { return yy::parser::make_Y_COMMA; }
";" { return yy::parser::make_Y_SEMICOLON; }

[ \t\n] { /* ignore whitespace */ }
\/\/[^\n]*\n? { /* ignore comments */ }
\/\*.*\*\/ { /* ignore comments */ }
. { /* yyerror("invalid character"); */ }
%%

