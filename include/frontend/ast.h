#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "node_type.h"

#define UNDEFINED 0
typedef int token_type;
typedef struct _ast ast;
typedef struct _ast *past;
struct _ast{
   int ivalue;
   float fvalue;
   char* svalue;
   node_type nodeType;
   past left;
   past right;
   past if_cond;
   past next;
};

void yyerror(char* s);

#include "lrparser.tab.h"

void showAst(past node, int nest, bool use_blank);
void showToken(int Token);

past newAstNode(node_type type);
past lastNode(past node);
past addNode(past target, past node);

past newVarDecl(token_type type, char* id, past init_val, past arrry_subscript);
void SetDeclsType(past node, token_type type);
past newDeclStmt(past decl);
past newArraySubscripts(past delref, past subscripts);
past newInitList(past exp, past next);
past newFuncDef(token_type type, char* id, past params, past body);
past newFuncParam(token_type type, char* id, past init_val, past arrry_subscript);
past newBlock(past items);
past newBinaryOp(token_type op, past left, past right);
past newWhileStmt(past cond, past body);
past newIfStmt(past cond, past body, past else_body);
past newReturnStmt(past expr);
past newDeclRef(char* id, past para);
past newParenExp(past expr);
past newInt(int val);
past newCallExp(past funcref, past paras);
past newUnaryOp(token_type op, past expr);
past newVarRef(char* id, past para);
