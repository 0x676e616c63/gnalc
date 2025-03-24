%{

#include "ggc/irparser.hpp"
#include <cstdlib> // just for atoi, atof, strtol, strtof
#define YY_DECL yyy::parser::symbol_type yylex ()

%}

%option noyywrap nounput noinput
%option yylineno

%%

";"[^\n]*       { /* ignore comments */ }
[ \t\n]         { /* ignore whitespace */ }

[-a-zA-Z$._0-9]*[^\n]":"    { return yyy::parser::make_I_BLKID(yytext); }
[%@][-a-zA-Z$._0-9]*        { return yyy::parser::make_I_ID(yytext); }

0|([1-9][0-9]*) { return yyy::parser::make_IRNUM_INT((int)atoi(yytext)); }
0[0-7]+ { return yyy::parser::make_IRNUM_INT((int)strtol(yytext, NULL, 8)); }
0[xX][0-9a-fA-F]+ { return yyy::parser::make_IRNUM_INT((int)strtol(yytext, NULL, 16)); }

(([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+))([eE][\+-]?[0-9]+)? { return yyy::parser::make_IRNUM_FLOAT((float)atof(yytext)); }
[0-9]+[eE][\+-]?[0-9]+ { return yyy::parser::make_IRNUM_FLOAT((float)atof(yytext)); }
0[xX](([0-9a-fA-F]+)|([0-9a-fA-F]+\.[0-9a-fA-F]*)|([0-9a-fA-F]*\.[0-9a-fA-F]+))[pP][\+-]?[0-9]+ { return yyy::parser::make_IRNUM_FLOAT((float)strtof(yytext, NULL)); }

"ret"           { return yyy::parser::make_I_RET(); }
"br"            { return yyy::parser::make_I_BR(); }
"fneg"          { return yyy::parser::make_I_FNEG(); }
"add"           { return yyy::parser::make_I_ADD(); }
"fadd"          { return yyy::parser::make_I_FADD(); }
"sub"           { return yyy::parser::make_I_SUB(); }
"fsub"          { return yyy::parser::make_I_FSUB(); }
"mul"           { return yyy::parser::make_I_MUL(); }
"fmul"          { return yyy::parser::make_I_FMUL(); }
"sdiv"          { return yyy::parser::make_I_DIV(); }
"fdiv"          { return yyy::parser::make_I_FDIV(); }
"srem"          { return yyy::parser::make_I_REM(); }
"frem"          { return yyy::parser::make_I_FREM(); }
"and"           { return yyy::parser::make_I_AND(); }
"or"            { return yyy::parser::make_I_OR(); }
"alloca"        { return yyy::parser::make_I_ALLOCA(); }
"load"          { return yyy::parser::make_I_LOAD(); }
"store"         { return yyy::parser::make_I_STORE(); }
"getelementptr" { return yyy::parser::make_I_GEP(); }
"fptosi"        { return yyy::parser::make_I_FPTOSI(); }
"sitofp"        { return yyy::parser::make_I_SITOFP(); }
"zext"          { return yyy::parser::make_I_ZEXT(); }
"bitcast"       { return yyy::parser::make_I_BITCAST(); }
"icmp"          { return yyy::parser::make_I_ICMP(); }
"fcmp"          { return yyy::parser::make_I_FCMP(); }
"phi"           { return yyy::parser::make_I_PHI(); }
"call"          { return yyy::parser::make_I_CALL(); }

"define"        { return yyy::parser::make_I_DEFINE(); }
"declare"       { return yyy::parser::make_I_DECLARE(); }
"dso_local"     { return yyy::parser::make_I_DSO_LOCAL(); }
"global"        { return yyy::parser::make_I_GLOBAL(); }
"constant"      { return yyy::parser::make_I_CONSTANT(); }
"align"         { return yyy::parser::make_I_ALIGN(); }
"noundef"       { return yyy::parser::make_I_NOUNDEF(); }
"label"         { return yyy::parser::make_I_LABEL(); }
"tail"          { return yyy::parser::make_I_TAIL(); }
"to"            { return yyy::parser::make_I_TO(); }

"eq"            { return yyy::parser::make_I_EQ(); }
"ne"            { return yyy::parser::make_I_NE(); }
"sgt"           { return yyy::parser::make_I_SGT(); }
"sge"           { return yyy::parser::make_I_SGE(); }
"slt"           { return yyy::parser::make_I_SLT(); }
"sle"           { return yyy::parser::make_I_SLE(); }

"oeq"           { return yyy::parser::make_I_OEQ(); }
"ogt"           { return yyy::parser::make_I_OGT(); }
"oge"           { return yyy::parser::make_I_OGE(); }
"olt"           { return yyy::parser::make_I_OLT(); }
"ole"           { return yyy::parser::make_I_OLE(); }
"one"           { return yyy::parser::make_I_ONE(); }
"ord"           { return yyy::parser::make_I_ORD(); }

"i1"            { return yyy::parser::make_I_I1(); }
"i8"            { return yyy::parser::make_I_I8(); }
"i32"           { return yyy::parser::make_I_I32(); }
"float"         { return yyy::parser::make_I_FLOAT(); }
"void"          { return yyy::parser::make_I_VOID(); }
"*"             { return yyy::parser::make_I_STAR(); }
"x"             { return yyy::parser::make_I_X(); }

"zeroinitializer"   { return yyy::parser::make_I_ZEROINITER(); }
"..."           { return yyy::parser::make_I_DOTDOTDOT(); /* VAArg */ }

"(" { return yyy::parser::make_I_LPAR(); }
")" { return yyy::parser::make_I_RPAR(); }
"{" { return yyy::parser::make_I_LBRACKET(); }
"}" { return yyy::parser::make_I_RBRACKET(); }
"[" { return yyy::parser::make_I_LSQUARE(); }
"]" { return yyy::parser::make_I_RSQUARE(); }
"," { return yyy::parser::make_I_COMMA(); }
"=" { return yyy::parser::make_I_EQUAL(); }

. { /* yyerror("invalid character"); */ }
%%
