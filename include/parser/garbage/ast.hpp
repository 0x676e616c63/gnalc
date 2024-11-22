/**
 * @todo 修改为cpp特性
 * @attention In the past, ast.cpp used functions in string.h.
 * @attention In the past, ast.cpp used malloc and free functions in stdlib.h.
 */

#pragma once
#ifndef PARSER_AST_H
#define PARSER_AST_H

#include <cstdio>
#include <cstdlib>
#include "node_type.hpp"
#include "basetype.hpp"

// extern "C" {
// #include "../lexer/datatype.h"
// // #include "token.h"
// }

namespace AST {

using ast = struct _ast;
using past = struct _ast*;
using node_type = enum _node_type;

/**
 * @brief AST base structure
 */
struct _ast
{
protected:
    node_type nodeType; // 只在构造函数中赋值，在getNodeType()中访问
public:
    past left;
    past right;
    past next;
    _ast(node_type type, past left = nullptr, past right = nullptr, past next = nullptr) 
        : nodeType(type), left(left), right(right), next(next) {};

    node_type getNodeType() { return nodeType; }
    virtual void visit(int nest) = 0; // should be override

    ~_ast() = default;
};

/**
 * @todo setdeclstype func (need?)
 */
struct VarDecl : public ast
{
protected:
    dtype _type = dtype::UNDEFINED;
    string id;

public:
    // left: array_subscript, right: init_val; in parser.y:67:constdef
    VarDecl(string id, past array_subscript, past init_val)
        : id(id), ast(VAR_DECL, array_subscript, init_val) {};

    // VarDecl(dtype&& type, string id, past array_subscript, past init_val)
    //     : type(type), id(id), ast(VAR_DECL, array_subscript, init_val) {};

    dtype getType() { return _type; }
    string getId() { return id; }
    void setType(dtype t) { _type = t; if (auto* nextDecl = dynamic_cast<VarDecl*>(this->next)) nextDecl->setType(t);}

    void print(int nest);
   
};

struct DeclStmt : public ast
{

    void print(int nest) override ;
};

// need edited
struct ArraySubscripts : public ast
{
    // ArraySubscripts(past declRef, past subscripts)
    //     : declRef(declRef), subscripts(subscripts), ast(ARRAY_SUBSCRIPT_EXPR, declRef, subscripts) {};

    void print(int nest) override ;
};

struct InitList : public ast
{
};

struct FuncDef : public ast
{
};

struct FuncParam : public ast
{
};

struct Block : public ast
{
};

struct BinaryOp : public ast
{
};

struct WhileStmt : public ast
{
    WhileStmt(past cond, past body) : ast(WHILE_STMT, cond, body) {};

    void print(int nest) override ;
};

struct IfStmt : public ast
{
};

struct ReturnStmt : public ast
{
    ReturnStmt(past expr) : ast(RETURN_STMT, expr) {};

    void print(int nest) override ;
};

struct DeclRef : public ast
{
};

struct CallExp : public ast
{
};

struct UnaryOp : public ast
{
};

struct VarRef : public ast
{
};

// void showAst(past node, int nest, bool use_blank);
// void showToken(int Token);

// past newAstNode(node_type type);
// past lastNode(past node);
// past addNode(past target, past node);

// past newVarDecl(token_type type, char* id, past init_val, past arrry_subscript);
// void SetDeclsType(past node, token_type type);
// past newDeclStmt(past decl);
// past newArraySubscripts(past delref, past subscripts);
// past newInitList(past exp, past next);
// past newFuncDef(token_type type, char* id, past params, past body);
// past newFuncParam(token_type type, char* id, past init_val, past arrry_subscript);
// past newBlock(past items);
// past newBinaryOp(token_type op, past left, past right);
// past newWhileStmt(past cond, past body);
// past newIfStmt(past cond, past body, past else_body);
// past newReturnStmt(past expr);
// past newDeclRef(char* id, past para);
// past newParenExp(past expr);
// past newInt(int val);
// past newCallExp(past funcref, past paras);
// past newUnaryOp(token_type op, past expr);
// past newVarRef(char* id, past para);

// void yyerror(char* s); // declared in token.h

}

#endif