%code {
#include "../../include/tpo/irparsertool.hpp"
extern yyy::parser::symbol_type yylex ();
extern int yylineno;
}

%code requires {
#include "irparsertool.hpp"
}

%language "C++"
%require "3.8.1"
%header "include/tpo/parser.hpp"
%define api.token.raw
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%define api.namespace yyy

%token I_RET I_BR I_FNEG I_ADD I_FADD I_SUB I_FSUB I_MUL I_FMUL I_SDIV I_FDIV I_SREM I_FREM I_AND I_OR I_ALLOCA I_LOAD I_STORE I_GEP I_FPTOSI I_SITOFP I_ZEXT I_BITCAST I_ICMP I_FCMP I_PHI I_CALL
%token I_DEFINE I_DECLARE I_DSO_LOCAL I_GLOBAL I_CONSTANT I_ALIGN I_NOUNDEF I_LABEL I_TAIL I_TO
%token I_EQ I_NE I_SGT I_SGE I_SLT I_SLE I_OEQ I_OGT I_OGE I_OLT I_OLE I_ONE I_ORD
%token I_I1 I_I8 I_I32 I_FLOAT I_VOID I_STAR I_X I_ZEROINITER I_DOTDOTDOT
%token I_LPAR I_RPAR I_LBRACKET I_RBRACKET I_LSQUARE I_RSQUARE I_COMMA I_EQUAL
%token <std::string> I_ID I_BLKID
%token <int> IRNUM_INT
%token <float> IRNUM_FLOAT



%%

Module  : GlobalEntities {}
        ;

GlobalEntities  : GlobalEntities GlobalVariable
                | GlobalEntities FunctionDefinition
                | GlobalEntities FunctionDeclaration
                | GlobalVariable
                | FunctionDefinition
                | FunctionDeclaration
                ;

GlobalVariable  : I_ID I_EQUAL I_DSO_LOCAL Storage GVIniter I_COMMA I_ALIGN IRNUM_INT
                ;

Storage : I_CONSTANT
        | I_GLOBAL
        ;

Type    : BType
        | PtrType
        | ArrayType
        ;

BType   : I_I1
        | I_I8
        | I_I32
        | I_FLOAT
        | I_VOID
        ;

PtrType : BType I_STAR
        ;

ArrayType   : I_LSQUARE IRNUM_INT I_X Type I_RBRACKET
            ;

Constant    : IRNUM_INT
            | IRNUM_FLOAT
            ;

GVIniter    : Type I_ZEROINITER
            | Type I_LSQUARE GVIniters I_RSQUARE
            | Type Constant
            ;

GVIniters   : GVIniter
            | GVIniters I_COMMA GVIniter
            ;

FunctionDeclaration : I_DECLARE Type I_ID I_LPAR ParamList I_RPAR ;

ParamList   : ParamList I_COMMA Param
            | Param
            ;

Param   : Type I_NOUNDEF I_ID
        | Type I_NOUNDEF
        | I_DOTDOTDOT
        ;

FunctionDefinition  : I_DEFINE I_DSO_LOCAL Type I_ID I_LPAR ParamList I_RPAR I_LBRACKET BBList I_RBRACKET
                    ;

BBList  : BB
        | BBList BB
        ;

BB  : I_BLKID InstList
    ;

InstList    : Inst
            | InstList Inst
            ;

Inst    : BinaryInst
        | CastInst
        | FnegInst
        | IcmpInst
        | FcmpInst
        | RetInst
        | BrInst
        | CallInst
        | AllocaInst
        | LoadInst
        | StoreInst
        | GepInst
        | PhiInst
        ;

BinaryInst  : I_ID I_EQUAL BinaryOp Type Value I_COMMA Value
            ;

Value   : I_ID
        | Constant
        ;

BinaryOp    : I_ADD
            | I_FADD
            | I_SUB
            | I_FSUB
            | I_MUL
            | I_FMUL
            | I_DIV
            | I_FDIV
            | I_REM
            | I_FREM
            ;

FnegInst    : I_ID I_EQUAL I_FNEG Type Value
            ;

CastInst    : I_ID I_EQUAL CastOp Type Value I_TO Type
            ;

CastOp  : I_FPTOSI
        | I_SITOFP
        | I_ZEXT
        | I_BITCAST
        ;

IcmpInst    : I_ID I_EQUAL I_ICMP IcmpOp Type Value I_COMMA Value
            ;

IcmpOp  : I_EQ
        | I_NE
        | I_SGT
        | I_SGE
        | I_SLT
        | I_SLE
        ;

FcmpInst    : I_ID I_EQUAL I_FCMP FcmpOp Type Value I_COMMA Value
            ;

FcmpOp  : I_OEQ
        | I_OGT
        | I_OGE
        | I_OLT
        | I_OLE
        | I_ONE
        | I_ORD
        ;

RetInst : I_RET Type Value
        | I_RET I_VOID
        ;

BrInst  : I_BR I_LABEL I_ID
        | I_BR Type Value I_COMMA I_LABEL I_ID I_COMMA I_LABEL I_ID
        ;

CallInst    : I_CALL Type Value I_LPAR ArgList I_RPAR
            | I_ID I_EQUAL I_CALL Type Value I_LPAR ArgList I_RPAR
            | I_TAIL I_CALL Type Value I_LPAR ArgList I_RPAR
            | I_ID I_EQUAL I_TAIL I_CALL Type Value I_LPAR ArgList I_RPAR
            ;

ArgList : ArgList I_COMMA Arg
        | Arg
        ;

Arg : Type I_NOUNDEF Value
    ;

AllocaInst  : I_ID I_EQUAL I_ALLOCA Type I_COMMA I_ALIGN IRNUM_INT
            ;

LoadInst    : I_ID I_EQUAL I_LOAD Type I_COMMA Type Value I_COMMA I_ALIGN IRNUM_INT
            ;

StoreInst   : I_STORE Type Value I_COMMA Type Value I_COMMA I_ALIGN IRNUM_INT
            ;

GepInst : I_ID I_EQUAL I_GEP Type I_COMMA Type Value IndexList
        ;

IndexList   : I_COMMA Type Value
            | IndexList I_COMMA Type Value ;

PhiInst : I_ID I_EQUAL I_PHI Type PhiOpers ;

PhiOpers    : PhiOper
            | PhiOpers I_COMMA PhiOper
            ;

PhiOper : I_LSQUARE Value I_COMMA Value I_RSQUARE
        ;

%%

void setFileName(const char *name) {
  strcpy(filename, name);
  freopen(filename, "r", stdin);
}

void
yyy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}