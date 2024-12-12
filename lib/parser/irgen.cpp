#include "../../include/parser/visitor.hpp"
#include "../../include/ir/module.hpp"

namespace AST {
    void IRGenerator::visit(CompUnit& node) {
        for (auto& n : node.getNodes()) {
            n->accept(*this);
        }
    }

    // DeclStmt: const int32
    void IRGenerator::visit(DeclStmt& node) {
        for (auto& v : node.getVardefs()) {
            v->accept(*this);
        }
    }

    // VarDecl: 'a' const int32[1][2]
    void IRGenerator::visit(VarDef& node) {
        if (node.isArray()) {
            for (auto& ss : node.getSubscripts()) {
                ss->accept(*this);
            }
        }

        if (node.isInited())
        {
            node.accept(*this);
            // module.registerSymbol(node.getId(), nullptr);
        }
        else {
            // module.registerSymbol(node.getId(), nullptr);
        }
    }

    void IRGenerator::visit(InitVal& node) {
        if (node.isList()) {
            if (!node.isEmpty()) {
                for (auto& iv : node.getInner()) {
                    iv->accept(*this);
                }
            }
        } else {
            node.getExp()->accept(*this);
        }
    }

    void IRGenerator::visit(ArraySubscript& node) {
        node.getExp()->accept(*this);
    }

    // FunctionDef: 'func' int32
    void IRGenerator::visit(FuncDef& node) {
        if (!node.isEmptyParam()) {
            for (auto& p : node.getParams()) {
                p->accept(*this);
            }
        }
        node.getBody()->accept(*this);
    }

    // FuncFParam: 'a' int32[][2] \n
    void IRGenerator::visit(FuncFParam& node) {
        if (node.isArray() && !node.isOneDim()) {
            for (auto& ss : node.getSubscripts()) {
                ss->accept(*this);
            }
        }
    }

    // DeclRefExp: 'a' \n
    void IRGenerator::visit(DeclRef& node) {
    }

    // a[2][1]
    // ArrayExp: 'a' [2][1]
    void IRGenerator::visit(ArrayExp& node) {
        for (auto& ss : node.getIndices()) {
            ss->accept(*this);
        }
    }

    // a(1, 2, 3)
    // CallExp: 'a' (1, 2, 3, )
    void IRGenerator::visit(CallExp& node) {
        if (!node.isEmptyParam()) {
            for (auto& p : node.getParams()) {
                p->accept(*this);
            }
        }
    }

    void IRGenerator::visit(FuncRParam& node) {
        node.getExp()->accept(*this);
    }

    void IRGenerator::visit(BinaryOp& node) {
        node.getLHS()->accept(*this);
        node.getRHS()->accept(*this);
    }

    void IRGenerator::visit(UnaryOp& node) {
        node.getExp()->accept(*this);
    }

    void IRGenerator::visit(ParenExp& node) {
        node.getExp()->accept(*this);
    }

    void IRGenerator::visit(IntLiteral& node) {
    }

    void IRGenerator::visit(FloatLiteral& node) {
    }

    void IRGenerator::visit(CompStmt& node) {
        for (auto& item : node.getItems()) {
            item->accept(*this);
        }
    }

    void IRGenerator::visit(IfStmt& node) {
        node.getCond()->accept(*this);
        node.getBody()->accept(*this);
        if(node.hasElse()) {
            node.getElseBody()->accept(*this);
        }
    }

    void IRGenerator::visit(WhileStmt& node) {
        node.getCond()->accept(*this);
        node.getBody()->accept(*this);
    }

    void IRGenerator::visit(NullStmt& node) {
    }

    void IRGenerator::visit(BreakStmt& node) {
    }

    void IRGenerator::visit(ContinueStmt& node) {
    }

    void IRGenerator::visit(ReturnStmt& node) {
        if (!node.isVoid()) {
            node.getReturnVal()->accept(*this);
        }
    }
}