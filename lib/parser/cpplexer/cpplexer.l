/**
 * @brief 词法分析器
 * @todo line 34: in lex++, yytext is a string? origin: strdup(yytext)
 * @todo mutiple comments' regular expression need to be completed
 * @attention no negative integers and floats, they are considered as unary expressions
 */

%{

#include "../../include/parser/token.hpp"

%}

%option c++
%option noyywrap

%%
[0-9]+ { yylval.int_value = (int32)atoi(yytext); return num_INT; }
(([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+))([eE]-?[0-9]+)? { yylval.float_value = (float32)atof(yytext); return num_FLOAT; }
[0-9]+[eE]-?[0-9]+ { yylval.float_value = (float32)atof(yytext); return num_FLOAT; }
0x[0-9a-fA-F]+ { yylval.int_value = (int32)strtol(yytext, NULL, 16); return num_INT; }

"int" { return Y_INT; }
"void" { return Y_VOID; }
"float" { return Y_FLOAT; }
"const" { return Y_CONST; }
"if" { return Y_IF; }
"else" { return Y_ELSE; }
"while" { return Y_WHILE; }
"break" { return Y_BREAK; }
"continue" { return Y_CONTINUE; }
"return" { return Y_RETURN; }

[a-zA-Z_][a-zA-Z0-9_]* { yylval.id_name = yytext; return Y_ID; }

"+" { return Y_ADD; }
"-" { return Y_SUB; }
"*"	{ return Y_MUL; }
"/"	{ return Y_DIV; }
"<=" { return Y_LESSEQ; }
"<"	{ return Y_LESS; }
">=" { return Y_GREATEQ; }
">"	{ return Y_GREAT; }
"!=" { return Y_NOTEQ; }
"!" { return Y_NOT; }
"&&" { return Y_AND; }
"||" { return Y_OR; }
"%"	{ return Y_MODULO; }
"==" { return Y_EQ; }
"=" { return Y_ASSIGN; }

"(" { return Y_LPAR; }
")" { return Y_RPAR; }
"{" { return Y_LBRACKET; }
"}" { return Y_RBRACKET; }
"[" { return Y_LSQUARE; }
"]" { return Y_RSQUARE; }
"," { return Y_COMMA; }
";" { return Y_SEMICOLON; }

[ \t\n] { /* ignore whitespace */ }
\/\/[^\n]*\n? { /* ignore comments */ }
\/\*.*\*\/ { /* ignore comments */ }
. { yyerror("invalid character"); }
%%


// int yywrap()
// {
// 	return 1;
// }
