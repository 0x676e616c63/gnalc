#include "../../include/parser/visitor.hpp"
#include "../../include/parser/ast.hpp"
#include <iostream>

namespace AST {
    void Printer::PrintType(dtype t) const {
        switch (t) {
            case dtype::INT:
                std::cout << "int32";
                break;
            case dtype::FLOAT:
                std::cout << "float32";
                break;
            case dtype::VOID:
                std::cout << "void";
                break;
            default:
                std::cout << "undefined";
        }
    }

    void Printer::PrintBlank() const {
        for (int i = 0; i < nest; i++) {
            std::cout << "  ";
        }
    }

    // DeclStmt: const int32
    void Printer::visit(DeclStmt& node) {
        PrintBlank();
        std::cout << "DeclStmt: ";

        if (node.isConst()) {
            std::cout << "const ";
        }

        PrintType(node.getType());
        std::cout << std::endl;

        nest++;
        for (auto& v : node.getVardefs()) {
            v->accept(*this);
        }
        nest--;
    }

    // VarDecl: 'a' const int32[1][2]
    void Printer::visit(VarDef& node) {
        PrintBlank();
        std::cout << "VarDecl: \'" << node.getId() << "\' "; // VarDef: 'a'

        if (node.isConst()) {
            std::cout << "const ";
        }

        PrintType(node.getType());

        if (node.isArray()) {
            for (auto& ss : node.getSubscripts()) {
                ss->accept(*this);
        }
        }

        std::cout << std::endl;

        if (node.isInited()) {
            nest++;
            for (auto& iv : node.getInitVals()) {
                iv->accept(*this);
            }
            nest--;
        }
    }

    void Printer::visit(InitVal& node) {
        PrintBlank();
        if (node.isList()) {
            std::cout << "InitList:";

            if (node.isEmpty()) {
                std::cout << " EmptyList.." << std::endl;
            } else {
                std::cout << std::endl;
                nest++;
                for (auto& iv : node.getInner()) {
                    iv->accept(*this);
                }
                nest--;
            }
        } else {
            node.getExp()->accept(*this);
            std::cout << std::endl;
        }
    }

    void Printer::visit(ArraySubscript& node) {
        std::cout << "[";
        node.getExp()->accept(*this);
        std::cout << "]";
    }

    void Printer::visit(AddExp& node) {
        node.getNum()->printNum();
    }
}