%code {
#include "../../include/ggc/irparsertool.hpp"
extern yyy::parser::symbol_type yylex ();
extern int yylineno;
IR::Module& inode = IRParser::IRGenerator::get_module();
using namespace IRParser;
using namespace IR;
IRPT tool;
}

%code requires {
#include "irparsertool.hpp"
}

%language "C++"
%require "3.8.1"
%header "../../include/ggc/irparser.hpp"
%define api.token.raw
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%define api.namespace {yyy}
/* %define parse.trace */

%token I_RET I_BR I_FNEG I_ADD I_FADD I_SUB I_FSUB I_MUL I_FMUL I_DIV I_FDIV I_REM I_FREM I_AND I_OR I_ALLOCA I_LOAD I_STORE I_GEP I_FPTOSI I_SITOFP I_ZEXT I_BITCAST I_ICMP I_FCMP I_PHI I_CALL
%token I_DEFINE I_DECLARE I_DSO_LOCAL I_GLOBAL I_CONSTANT I_ALIGN I_NOUNDEF I_LABEL I_TAIL I_TO
%token I_EQ I_NE I_SGT I_SGE I_SLT I_SLE I_OEQ I_OGT I_OGE I_OLT I_OLE I_ONE I_ORD
%token I_I1 I_I8 I_I32 I_FLOAT I_VOID I_STAR I_X I_ZEROINITER I_DOTDOTDOT
%token I_LPAR I_RPAR I_LBRACKET I_RBRACKET I_LSQUARE I_RSQUARE I_COMMA I_EQUAL
%token <std::string> I_ID I_BLKID
%token <int> IRNUM_INT
%token <float> IRNUM_FLOAT

%type <pGlobalVar> GlobalVariable
%type <pFuncDecl> FunctionDeclaration
%type <pFunc> FunctionDefinition
%type <STOCLASS> Storage
%type <pType> Type BType PtrType ArrayType DeclParam RETType
%type <std::vector<pType>> DeclParamList
%type <pVal> Constant Value Arg TypeValue
%type <std::vector<pVal>> ArgList IndexList
%type <GVIniter> GVIniter
%type <std::vector<GVIniter>> GVIniters
%type <std::vector<pFormalParam>> DefParamList
%type <pFormalParam> DefParam
%type <std::vector<pBlock>> BBList
%type <pBlock> BB
%type <std::list<pInst>> InstList
%type <pInst> Inst BinaryInst FnegInst CastInst IcmpInst FcmpInst RetInst BrInst CallInst AllocaInst LoadInst StoreInst GepInst PhiInst
%type <OP> BinaryOp
%type <ICMPOP> IcmpOp
%type <FCMPOP> FcmpOp
%type <std::vector<std::pair<pVal, pBlock>>> PhiOpers
%type <std::pair<pVal, pBlock>> PhiOper

%%

Module  : GlobalEntities {}
        ;

GlobalEntities  : GlobalEntities GlobalVariable         { inode.addGlobalVar($2); }
                | GlobalEntities FunctionDefinition     { inode.addFunction($2); }
                | GlobalEntities FunctionDeclaration    { inode.addFunctionDecl($2); }
                | GlobalVariable                        { inode.addGlobalVar($1); }
                | FunctionDefinition                    { inode.addFunction($1); }
                | FunctionDeclaration                   { inode.addFunctionDecl($1); }
                ;

GlobalVariable  : I_ID I_EQUAL I_DSO_LOCAL Storage GVIniter I_COMMA I_ALIGN IRNUM_INT   { $$ = tool.newGV($4, $5.getIniterType(), $1, $5, $8); }
                ;

Storage : I_CONSTANT    { $$ = STOCLASS::CONSTANT; }
        | I_GLOBAL      { $$ = STOCLASS::GLOBAL; }
        ;

Type    : BType     { $$ = $1; }
        | PtrType   { $$ = $1; }
        | ArrayType { $$ = $1; }
        ;

BType   : I_I1      { $$ = makeBType(IRBTYPE::I1); }
        | I_I8      { $$ = makeBType(IRBTYPE::I8); }
        | I_I32     { $$ = makeBType(IRBTYPE::I32); }
        | I_FLOAT   { $$ = makeBType(IRBTYPE::FLOAT); }
        | I_VOID    { $$ = makeBType(IRBTYPE::VOID); }
        ;

PtrType : Type I_STAR   { $$ = makePtrType($1); }
        ;

ArrayType   : I_LSQUARE IRNUM_INT I_X Type I_RSQUARE   { $$ = makeArrayType($4, $2); }
            ;

Constant    : IRNUM_INT     { $$ = inode.getConst(int($1)); }
            | IRNUM_FLOAT   { $$ = inode.getConst(float($1)); }
            ;

GVIniter    : Type I_ZEROINITER                     { $$ = GVIniter($1); }
            | Type I_LSQUARE GVIniters I_RSQUARE    { $$ = GVIniter($1, $3); }
            | Type Constant                         { $$ = GVIniter($1, $2); }
            ;

GVIniters   : GVIniter                      { $$ = { $1 }; }
            | GVIniters I_COMMA GVIniter    { $$ = $1; $$.emplace_back($3); }
            ;

FunctionDeclaration : I_DECLARE Type I_ID I_LPAR DeclParamList I_RPAR               { $$ = tool.newFuncDecl($3, $5, $2); }
                    | I_DECLARE Type I_ID I_LPAR DeclParamList I_COMMA I_DOTDOTDOT I_RPAR   { $$ = tool.newFuncDecl($3, $5, $2, true); }
                    | I_DECLARE Type I_ID I_LPAR I_RPAR                             { $$ = tool.newFuncDecl($3, {}, $2); }
                    | I_DECLARE Type I_ID I_LPAR I_DOTDOTDOT I_RPAR                 { $$ = tool.newFuncDecl($3, {}, $2, true); }
                    ;

DeclParamList   : DeclParamList I_COMMA DeclParam   { $$ = $1; $$.emplace_back($3); }
                | DeclParam                         { $$ = { $1 }; }
                ;

DeclParam   : Type I_NOUNDEF    { $$ = $1; }
            ;

DefParamList    : DefParamList I_COMMA DefParam { $$ = $1; $$.emplace_back($3); }
                | DefParam                      { $$ = { $1 }; }
                ;

DefParam    : Type I_NOUNDEF I_ID   { $$ = tool.vmake<FormalParam>($3, $3, $1, 0); }
            ;

FunctionDefinition  : I_DEFINE I_DSO_LOCAL Type I_ID I_LPAR DefParamList I_RPAR I_LBRACKET BBList I_RBRACKET    { $$ = tool.newFunc($4, $6, $3, &inode.getConstantPool(), $9); }
                    | I_DEFINE I_DSO_LOCAL Type I_ID I_LPAR I_RPAR I_LBRACKET BBList I_RBRACKET                 { $$ = tool.newFunc($4, {}, $3, &inode.getConstantPool(), $8); }
                    ;

BBList  : BB            { $$ = { $1 }; }
        | BBList BB     { $$ = $1; $$.emplace_back($2); }
        ;

BB  : I_BLKID InstList  { $$ = tool.newBB($1, $2); }
    ;

InstList    : Inst          { $$ = { $1 }; }
            | InstList Inst { $$ = $1; $$.emplace_back($2); }
            ;

Inst    : BinaryInst    { $$ = $1; }
        | CastInst      { $$ = $1; }
        | FnegInst      { $$ = $1; }
        | IcmpInst      { $$ = $1; }
        | FcmpInst      { $$ = $1; }
        | RetInst       { $$ = $1; }
        | BrInst        { $$ = $1; }
        | CallInst      { $$ = $1; }
        | AllocaInst    { $$ = $1; }
        | LoadInst      { $$ = $1; }
        | StoreInst     { $$ = $1; }
        | GepInst       { $$ = $1; }
        | PhiInst       { $$ = $1; }
        ;

BinaryInst  : I_ID I_EQUAL BinaryOp Type Value I_COMMA Value    { $$ = tool.vmake<BinaryInst>($1, $1, $3, $5, $7); }
            ;

TypeValue   : Type I_ID                     { $$ = tool.getV($2); }
            | I_I1 IRNUM_INT                { $$ = inode.getConst(bool($2)); }
            | I_I8 IRNUM_INT                { $$ = inode.getConst(char($2)); }
            | I_I32 IRNUM_INT               { $$ = inode.getConst(int($2)); }
            | I_FLOAT IRNUM_FLOAT           { $$ = inode.getConst(float($2)); }
            ;

Value   : I_ID      { $$ = tool.getV($1); }
        | Constant  { $$ = $1; }
        ;

BinaryOp    : I_ADD     { $$ = OP::ADD; }
            | I_FADD    { $$ = OP::FADD; }
            | I_SUB     { $$ = OP::SUB; }
            | I_FSUB    { $$ = OP::FSUB; }
            | I_MUL     { $$ = OP::MUL; }
            | I_FMUL    { $$ = OP::FMUL; }
            | I_DIV     { $$ = OP::DIV; }
            | I_FDIV    { $$ = OP::FDIV; }
            | I_REM     { $$ = OP::REM; }
            | I_FREM    { $$ = OP::FREM; }
            ;

FnegInst    : I_ID I_EQUAL I_FNEG TypeValue     { $$ = tool.vmake<FNEGInst>($1, $1, $4); }
            ;

CastInst    : I_ID I_EQUAL I_FPTOSI Type Value I_TO Type    { $$ = tool.vmake<FPTOSIInst>($1, $1, $5); }
            | I_ID I_EQUAL I_SITOFP Type Value I_TO Type    { $$ = tool.vmake<SITOFPInst>($1, $1, $5); }
            | I_ID I_EQUAL I_ZEXT TypeValue I_TO Type       { $$ = tool.vmake<ZEXTInst>($1, $1, $4, toBType($6)->getInner()); }
            | I_ID I_EQUAL I_BITCAST TypeValue I_TO Type    { $$ = tool.vmake<BITCASTInst>($1, $1, $4, $6); }
            ;

IcmpInst    : I_ID I_EQUAL I_ICMP IcmpOp Type Value I_COMMA Value   { $$ = tool.vmake<ICMPInst>($1, $1, $4, $6, $8); }
            ;

IcmpOp  : I_EQ  { $$ = ICMPOP::eq; }
        | I_NE  { $$ = ICMPOP::ne; }
        | I_SGT { $$ = ICMPOP::sgt; }
        | I_SGE { $$ = ICMPOP::sge; }
        | I_SLT { $$ = ICMPOP::slt; }
        | I_SLE { $$ = ICMPOP::sle; }
        ;

FcmpInst    : I_ID I_EQUAL I_FCMP FcmpOp Type Value I_COMMA Value   { $$ = tool.vmake<FCMPInst>($1, $1, $4, $6, $8); }
            ;

FcmpOp  : I_OEQ { $$ = FCMPOP::oeq; }
        | I_OGT { $$ = FCMPOP::ogt; }
        | I_OGE { $$ = FCMPOP::oge; }
        | I_OLT { $$ = FCMPOP::olt; }
        | I_OLE { $$ = FCMPOP::ole; }
        | I_ONE { $$ = FCMPOP::one; }
        | I_ORD { $$ = FCMPOP::ord; }
        ;

RetInst : I_RET RETType Value   { $$ = tool.make<RETInst>($3); }
        | I_RET I_VOID          { $$ = tool.make<RETInst>(); }
        ;

RETType : I_I32     { $$ = makeBType(IRBTYPE::I32); }
        | I_FLOAT   { $$ = makeBType(IRBTYPE::FLOAT); }
        ;

BrInst  : I_BR I_LABEL I_ID                                         { $$ = tool.make<BRInst>(tool.getB($3)); }
        | I_BR TypeValue I_COMMA I_LABEL I_ID I_COMMA I_LABEL I_ID  { $$ = tool.make<BRInst>($2, tool.getB($5), tool.getB($8)); }
        ;

CallInst    : I_CALL Type I_ID I_LPAR ArgList I_RPAR                        { $$ = tool.make<CALLInst>(tool.getF($3), $5); }
            | I_ID I_EQUAL I_CALL Type I_ID I_LPAR ArgList I_RPAR           { $$ = tool.vmake<CALLInst>($1, $1, tool.getF($5), $7); }
            | I_TAIL I_CALL Type I_ID I_LPAR ArgList I_RPAR                 { $$ = tool.make<CALLInst>(tool.getF($4), $6); }
            | I_ID I_EQUAL I_TAIL I_CALL Type I_ID I_LPAR ArgList I_RPAR    { $$ = tool.vmake<CALLInst>($1, $1, tool.getF($6), $8); }
            ;

ArgList : ArgList I_COMMA Arg   { $$ = $1; $$.emplace_back($3); }
        | Arg                   { $$ = { $1 }; }
        |                       { $$ = {}; }
        ;

Arg : I_I1 I_NOUNDEF IRNUM_INT      { $$ = inode.getConst(bool($3)); }
    | I_I8 I_NOUNDEF IRNUM_INT      { $$ = inode.getConst(char($3)); }
    | I_I32 I_NOUNDEF IRNUM_INT     { $$ = inode.getConst(int($3)); }
    | I_FLOAT I_NOUNDEF IRNUM_FLOAT { $$ = inode.getConst(float($3)); }
    | I_I1 I_NOUNDEF I_ID           { $$ = tool.getV($3); }
    | I_I8 I_NOUNDEF I_ID           { $$ = tool.getV($3); }
    | I_I32 I_NOUNDEF I_ID          { $$ = tool.getV($3); }
    | I_FLOAT I_NOUNDEF I_ID        { $$ = tool.getV($3); }
    | PtrType I_NOUNDEF I_ID        { $$ = tool.getV($3); }
    | ArrayType I_NOUNDEF I_ID      { $$ = tool.getV($3); }
    ;

AllocaInst  : I_ID I_EQUAL I_ALLOCA Type I_COMMA I_ALIGN IRNUM_INT  { $$ = tool.vmake<ALLOCAInst>($1, $1, $4, $7); }
            ;

LoadInst    : I_ID I_EQUAL I_LOAD Type I_COMMA TypeValue I_COMMA I_ALIGN IRNUM_INT  { $$ = tool.vmake<LOADInst>($1, $1, $6, $9); }
            ;

StoreInst   : I_STORE TypeValue I_COMMA TypeValue I_COMMA I_ALIGN IRNUM_INT { $$ = tool.make<STOREInst>($2, $4, $7); }
            ;

GepInst : I_ID I_EQUAL I_GEP Type I_COMMA TypeValue IndexList   { $$ = tool.vmake<GEPInst>($1, $1, $6, $7); }
        ;

IndexList   : I_COMMA Type Value            { $$ = { $3 }; }
            | IndexList I_COMMA Type Value  { $$ = $1; $$.emplace_back($4); }
            ;

PhiInst : I_ID I_EQUAL I_PHI Type PhiOpers  { $$ = tool.newPhi($1, $4, $5); }
        ;

PhiOpers    : PhiOper                   { $$ = { $1 }; }
            | PhiOpers I_COMMA PhiOper  { $$ = $1; $$.emplace_back($3); }
            ;

PhiOper : I_LSQUARE Value I_COMMA I_ID I_RSQUARE    { $$ = std::make_pair($2, tool.getB($4)); }
        ;

%%

/* void setFileName(const char *name) {
  strcpy(filename, name);
  freopen(filename, "r", stdin);
} */

void
yyy::parser::error (const std::string& msg) { 
      std::cerr << "Error: " << msg << std::endl; 
}