%code {
#include "ir.hpp"
extern std::shared_ptr<IR::Module> irnode;
extern yyy::parser::symbol_type yylex ();
extern int yylineno;
}

%code requires {
#include "ir.hpp"
}

%language "C++"
%require "3.8.1"
%header "include/parser/parser.hpp"
%define api.token.raw
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%define api.namespace yyy

%token I_RET I_BR I_FNEG I_ADD I_FADD I_SUB I_FSUB I_MUL I_FMUL I_SDIV I_FDIV I_SREM I_FREM I_AND I_OR I_ALLOCA I_LOAD I_STORE I_GEP I_FPTOSI I_SITOFP I_ZEXT I_BITCAST I_ICMPA I_FCMPA I_PHI I_CALL
%token I_DEFINE I_DECLARE I_DSO_LOCAL I_GLOBAL I_CONSTANT I_ALIGN I_NOUNDEF I_LABEL I_TAIL I_TO
%token I_EQ I_NE I_SGT I_SGE I_SLT I_SLE I_OEQ I_OGT I_OGE I_OLT I_OLE I_ONE I_ORD
%token I_I1 I_I8 I_I32 I_FLOAT I_VOID I_STAR
%token I_LPAR I_RPAR I_LBRACKET I_RBRACKET I_LSQUARE I_RSQUARE I_COMMA I_EQUAL
%token <std::string> I_ID I_BLKID
%token <int> irnum_INT
%token <float> irnum_FLOAT

