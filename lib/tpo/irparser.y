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

Module  : GlobalEntities
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

/// TODO:

Inst : Assignment_Inst
            | Non_assignment_Inst ;

Assignment_Inst : Binary_assignment
                       | Unary_assignment
                       | Cast_assignment
                       | Alloca_assignment
                       | Load_assignment
                       | Call_assignment
                       | Phi_assignment
                       | Gep_assignment
                       | Icmp_assignment
                       | Fcmp_assignment ;

Binary_assignment : I_ID I_EQUAL I_ADD Type Value I_COMMA Value
                  | I_ID I_EQUAL I_SUB Type Value I_COMMA Value
                  | I_ID I_EQUAL I_MUL Type Value I_COMMA Value
                  | I_ID I_EQUAL I_FADD Type Value I_COMMA Value
                  | I_ID I_EQUAL I_FSUB Type Value I_COMMA Value
                  | I_ID I_EQUAL I_FMUL Type Value I_COMMA Value
                  | I_ID I_EQUAL I_SDIV Type Value I_COMMA Value
                  | I_ID I_EQUAL I_FDIV Type Value I_COMMA Value
                  | I_ID I_EQUAL I_SREM Type Value I_COMMA Value
                  | I_ID I_EQUAL I_FREM Type Value I_COMMA Value
                  | I_ID I_EQUAL I_AND Type Value I_COMMA Value
                  | I_ID I_EQUAL I_OR Type Value I_COMMA Value ;

Unary_assignment : I_ID I_EQUAL I_FNEG Type Value ;

Cast_assignment : I_ID I_EQUAL I_ZEXT Type Value I_TO Type
                | I_ID I_EQUAL I_FPTOSI Type Value I_TO Type
                | I_ID I_EQUAL I_SITOFP Type Value I_TO Type
                | I_ID I_EQUAL I_BITCAST Type Value I_TO Type ;

Alloca_assignment : I_ID I_EQUAL I_ALLOCA Type ;

Load_assignment : I_ID I_EQUAL I_LOAD Type I_COMMA Value ;

Call_assignment : I_ID I_EQUAL I_CALL Type I_ID I_LPAR Arg_list I_RPAR ;

Phi_assignment : I_ID I_EQUAL I_PHI Type Phi_list ;

Phi_list : Phi_pair
         | Phi_list I_COMMA Phi_pair ;

Phi_pair : I_LSQUARE Value I_COMMA I_ID I_RSQUARE ;

Gep_assignment : I_ID I_EQUAL I_GEP Type I_COMMA Value I_COMMA Index_list ;

Index_list : Value
           | Index_list I_COMMA Value ;

Icmp_assignment : I_ID I_EQUAL I_ICMP Icmp_pred Type Value I_COMMA Value ;

Icmp_pred : I_EQ
          | I_NE
          | I_SGT
          | I_SGE
          | I_SLT
          | I_SLE ;

Fcmp_assignment : I_ID I_EQUAL I_FCMP Fcmp_pred Type Value I_COMMA Value ;

Fcmp_pred : I_OEQ
          | I_OGT
          | I_OGE
          | I_OLT
          | I_OLE
          | I_ONE
          | I_ORD ;

Non_assignment_Inst : Store_Inst
                           | Void_call ;

Store_Inst : I_STORE Type Value I_COMMA Value ;

Void_call : I_CALL I_VOID I_ID I_LPAR Arg_list I_RPAR ;

Arg_list : /* Empty */
         | Arg_list I_COMMA Value ;

Value : I_ID
      | Constant ;

Constant : IRNUM_INT
         | IRNUM_FLOAT ;

Terminator : Ret_Inst
           | Br_Inst ;

Ret_Inst : I_RET Type Value
                | I_RET I_VOID ;

Br_Inst : I_BR I_LABEL I_ID
               | I_BR Type Value I_COMMA I_LABEL I_ID I_COMMA I_LABEL I_ID ;

%%

void setFileName(const char *name) {
  strcpy(filename, name);
  freopen(filename, "r", stdin);
}

void
yyy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}