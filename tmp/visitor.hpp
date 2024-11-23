#pragma once
#ifndef __AST_VISITOR_HPP__
#define __AST_VISITOR_HPP__

#include "ast2.hpp"

namespace AST {

class Printer : public ASTVisitor {
private:
    int nest = 0;

public:
    void PrintType(dtype t) const;
    void PrintBlank() const;

    void visit(VarDef& node) override;
    void visit(DeclStmt& node) override;
    void visit(InitVal& node) override;
    void visit(ArraySubscript& node) override;
    void visit(AddExp& node) override;
};

}


#endif
