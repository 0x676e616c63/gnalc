/**
 * @brief AST Visitor
 */
#ifndef GNALC_AST_VISITOR_HPP
#define GNALC_AST_VISITOR_HPP
#pragma once


#include "ast.hpp"
#include "ir/module.hpp"

namespace AST {

class Printer : public ASTVisitor {
private:
    int nest = 0;
    bool fold_exp = false;

public:
    void PrintType(dtype t) const;
    void PrintBlank() const;
    void PrintOp(BiOp op) const;
    void PrintOp(UnOp op) const;

    void visit(CompUnit& node) override;
    void visit(VarDef& node) override;
    void visit(DeclStmt& node) override;
    void visit(InitVal& node) override;
    void visit(ArraySubscript& node) override;
    void visit(FuncDef& node) override;
    void visit(FuncFParam& node) override;
    void visit(DeclRef& node) override;
    void visit(ArrayExp& node) override;
    void visit(CallExp& node) override;
    void visit(FuncRParam& node) override;
    void visit(BinaryOp& node) override;
    void visit(UnaryOp& node) override;
    void visit(ParenExp& node) override;
    void visit(IntLiteral& node) override;
    void visit(FloatLiteral& node) override;
    void visit(CompStmt& node) override;
    void visit(IfStmt& node) override;
    void visit(WhileStmt& node) override;
    void visit(NullStmt& node) override;
    void visit(BreakStmt& node) override;
    void visit(ContinueStmt& node) override;
    void visit(ReturnStmt& node) override;
};

class IRGenerator : public ASTVisitor {
    IR::Module module;
    IR::Value curr_val;
public:
    IRGenerator() = default;
    void visit(CompUnit& node) override;
    void visit(VarDef& node) override;
    void visit(DeclStmt& node) override;
    void visit(InitVal& node) override;
    void visit(ArraySubscript& node) override;
    void visit(FuncDef& node) override;
    void visit(FuncFParam& node) override;
    void visit(DeclRef& node) override;
    void visit(ArrayExp& node) override;
    void visit(CallExp& node) override;
    void visit(FuncRParam& node) override;
    void visit(BinaryOp& node) override;
    void visit(UnaryOp& node) override;
    void visit(ParenExp& node) override;
    void visit(IntLiteral& node) override;
    void visit(FloatLiteral& node) override;
    void visit(CompStmt& node) override;
    void visit(IfStmt& node) override;
    void visit(WhileStmt& node) override;
    void visit(NullStmt& node) override;
    void visit(BreakStmt& node) override;
    void visit(ContinueStmt& node) override;
    void visit(ReturnStmt& node) override;
};

}


#endif
