/**
 * @todo 修改为cpp特性
 * @attention In the past, ast.cpp used functions in string.h.
 * @attention In the past, ast.cpp used malloc and free functions in stdlib.h.
 */

#pragma once
#ifndef PARSER_AST_H
#define PARSER_AST_H

#include <cstdio>
#include <cstdint>
#include <string>
#include <cstdlib>
#include <cstring>
#include "node_type.hpp"
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
// #include <stdint.h>

extern "C" {
#include "../lexer/datatype.h"
// #include "token.h"
}

#define UNDEFINED 0

#ifdef __cplusplus
namespace AST {
#endif

#ifdef __cplusplus
using ast = struct _ast;
using past = struct _ast*;
using token_type = int; // yylex的返回值为int，故暂时将token_type定义为int
using node_type = enum _node_type;
// using int32 = int32_t;
// using float32 = float;
using string = std::string;   


struct _ast
{
   int32 ivalue;
   float32 fvalue;
   string svalue;
   node_type nodeType;
   past left;
   past right;
   past if_cond;
   past next;
   void *data; // for future use
};

#else
typedef int token_type;
typedef struct _ast ast;
typedef struct _ast *past;

struct _ast{
   int32_t ivalue;
   float fvalue;
   char* svalue;
   node_type nodeType;
   past left;
   past right;
   past if_cond;
   past next;
   void *data; // for future use
};
#endif

// void yyerror(char* s); // declared in token.h

// #include "lrparser.tab.h"

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

#ifdef __cplusplus
}
#endif


#endif