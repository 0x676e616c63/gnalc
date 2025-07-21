// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../include/parser/astprinter.hpp"
#include <iostream>

namespace AST {
void ASTPrinter::PrintType(dtype t) const {
    std::cout << "\x1b[38;5;12m"; // Blue
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
    std::cout << "\x1b[0m";
}

void ASTPrinter::PrintBlank() const {
    for (int i = 0; i < nest; i++) {
        std::cout << "| ";
    }
}

void ASTPrinter::PrintOp(BiOp op) const {
    switch (op) {
    case BiOp::ASSIGN:
        std::cout << "=";
        break;
    case BiOp::ADD:
        std::cout << "+";
        break;
    case BiOp::SUB:
        std::cout << "-";
        break;
    case BiOp::MUL:
        std::cout << "*";
        break;
    case BiOp::DIV:
        std::cout << "/";
        break;
    case BiOp::MOD:
        std::cout << "%";
        break;
    case BiOp::LESSEQ:
        std::cout << "<=";
        break;
    case BiOp::LESS:
        std::cout << "<";
        break;
    case BiOp::GREATEQ:
        std::cout << ">=";
        break;
    case BiOp::GREAT:
        std::cout << ">";
        break;
    case BiOp::NOTEQ:
        std::cout << "!=";
        break;
    case BiOp::EQ:
        std::cout << "==";
        break;
    case BiOp::AND:
        std::cout << "&&";
        break;
    case BiOp::OR:
        std::cout << "||";
        break;
    default:
        std::cout << "undefined";
    }
}

void ASTPrinter::PrintOp(UnOp op) const {
    switch (op) {
    case UnOp::NOT:
        std::cout << "!";
        break;
    case UnOp::ADD:
        std::cout << "+";
        break;
    case UnOp::SUB:
        std::cout << "-";
        break;
    default:
        std::cout << "undefined";
    }
}

// TranslationUnit:
void ASTPrinter::visit(CompUnit &node) {
    std::cout << "======================================" << std::endl;
    std::cout << "    Welcome to use gnalc compiler.    " << std::endl;
    std::cout << "           AST Printer v1.0           " << std::endl;
    std::cout << "       MADE BY SH ZHAO 24/11/24       " << std::endl;
    std::cout << "======================================" << std::endl;
    PrintBlank();
    std::cout << "TranslationUnit: " << std::endl;

    nest++;
    for (auto &n : node.getNodes()) {
        n->accept(*this);
    }
    nest--;
}

// DeclStmt: const int32
void ASTPrinter::visit(DeclStmt &node) {
    PrintBlank();
    std::cout << "DeclStmt: ";

    if (node.isConst()) {
        std::cout << "const ";
    }

    PrintType(node.getType());
    std::cout << std::endl;

    nest++;
    for (auto &v : node.getVardefs()) {
        v->accept(*this);
    }
    nest--;
}

// VarDecl: 'a' const int32[1][2]
void ASTPrinter::visit(VarDef &node) {
    PrintBlank();
    std::cout << "VarDecl: \'" << node.getId() << "\' "; // VarDef: 'a'

    if (node.isConst()) {
        std::cout << "const ";
    }

    PrintType(node.getType());

    if (node.isArray()) {
        for (auto &ss : node.getSubscripts()) {
            ss->accept(*this);
        }
    }

    std::cout << std::endl;

    if (node.isInited()) {
        nest++;
        node.getInitVal()->accept(*this);
        nest--;
    }
}

void ASTPrinter::visit(InitVal &node) {
    if (node.isList()) {
        PrintBlank();
        std::cout << "InitList:";

        if (node.isEmpty()) {
            std::cout << " EmptyList.." << std::endl;
        } else {
            std::cout << std::endl;
            nest++;
            for (auto &iv : node.getInner()) {
                iv->accept(*this);
            }
            nest--;
        }
    } else {
        node.getExp()->accept(*this);
    }
}

void ASTPrinter::visit(ArraySubscript &node) {
    fold_exp = true;
    std::cout << "[";
    node.getExp()->accept(*this);
    std::cout << "]";
    fold_exp = false;
}

// FunctionDef: 'func' int32
void ASTPrinter::visit(FuncDef &node) {
    PrintBlank();
    std::cout << "FunctionDef: \'" << node.getId() << "\' ";
    PrintType(node.getType());

    nest++;
    if (node.isEmptyParam()) {
        std::cout << " EmptyParam.." << std::endl;
    } else {
        std::cout << std::endl;
        for (auto &p : node.getParams()) {
            p->accept(*this);
        }
    }

    node.getBody()->accept(*this);
    nest--;
}

// FuncFParam: 'a' int32[][2] \n
void ASTPrinter::visit(FuncFParam &node) {
    PrintBlank();
    std::cout << "FuncFParam: \'" << node.getId() << "\' ";

    PrintType(node.getType());

    if (node.isArray()) {
        std::cout << "[]";
        if (!node.isOneDim()) { // not 1 dim
            for (auto &ss : node.getSubscripts()) {
                ss->accept(*this);
            }
        }
    }
    std::cout << std::endl;
}

// DeclRefExp: 'a' \n
void ASTPrinter::visit(DeclRef &node) {
    if (fold_exp) {
        std::cout << node.getId();
        return;
    }
    PrintBlank();
    std::cout << "DeclRefExp: \'" << node.getId() << "\'" << std::endl;
}

/**
 * a[2][1]
 * ArrayExp: 'a' [2][1]
 */
void ASTPrinter::visit(ArrayExp &node) {
    if (fold_exp) {
        std::cout << node.getId();
        for (auto &ss : node.getIndices()) {
            ss->accept(*this);
        }
        return;
    }

    PrintBlank();
    std::cout << "ArrayExp: \'" << node.getId() << "\'";

    for (auto &ss : node.getIndices()) {
        ss->accept(*this);
    }
    std::cout << std::endl;
}

/**
 * a(1, 2, 3)
 * CallExp: 'a' (1, 2, 3, )
 */
void ASTPrinter::visit(CallExp &node) {
    if (fold_exp) {
        std::cout << node.getId();
        std::cout << "(";
        if (!(node.isEmptyParam())) {
            for (auto &p : node.getParams()) {
                p->accept(*this);
                std::cout << ",";
            }
        }
        std::cout << ")";
        return;
    }

    PrintBlank();
    std::cout << "CallExp: \'" << node.getId() << "\'";

    std::cout << " (";
    if (!(node.isEmptyParam())) {
        for (auto &p : node.getParams()) {
            p->accept(*this);
            std::cout << ", ";
        }
    }
    std::cout << ")" << std::endl;
}

void ASTPrinter::visit(FuncRParam &node) {
    fold_exp = true;
    node.getExp()->accept(*this);
    fold_exp = false;
}

/**
 * 之前设计没考虑到exp要展开打印，故定义了一个fold_exp
 * true: a=1+(3-2)
 * false:
 * BinaryOp: '+'
 * |-IntLiteral 1
 * |-ParenExp
 * |-|-BinaryOp '-'
 */
void ASTPrinter::visit(BinaryOp &node) {
    if (fold_exp) {
        node.getLHS()->accept(*this);
        PrintOp(node.getOp());
        node.getRHS()->accept(*this);
        return;
    }

    PrintBlank();
    std::cout << "BinaryOp: \'";
    PrintOp(node.getOp());
    std::cout << "\'" << std::endl;

    nest++;
    node.getLHS()->accept(*this);
    node.getRHS()->accept(*this);
    nest--;
}

void ASTPrinter::visit(UnaryOp &node) {
    if (fold_exp) {
        PrintOp(node.getOp());
        node.getExp()->accept(*this);
        return;
    }

    PrintBlank();
    std::cout << "UnaryOp: \'";
    PrintOp(node.getOp());
    std::cout << "\'" << std::endl;

    nest++;
    node.getExp()->accept(*this);
    nest--;
}

void ASTPrinter::visit(ParenExp &node) {
    if (fold_exp) {
        std::cout << "(";
        node.getExp()->accept(*this);
        std::cout << ")";
        return;
    }

    PrintBlank();
    std::cout << "ParenExp:" << std::endl;

    nest++;
    node.getExp()->accept(*this);
    nest--;
}

void ASTPrinter::visit(IntLiteral &node) {
    if (fold_exp) {
        std::cout << node.getValue();
        return;
    }

    PrintBlank();
    std::cout << "IntLiteral: " << node.getValue() << std::endl;
}

void ASTPrinter::visit(FloatLiteral &node) {
    if (fold_exp) {
        std::cout << node.getValue();
        return;
    }

    PrintBlank();
    std::cout << "FloatLiteral: " << node.getValue() << std::endl;
}

void ASTPrinter::visit(CompStmt &node) {
    PrintBlank();
    std::cout << "CompStmt:" << std::endl;
    nest++;
    for (auto &item : node.getItems()) {
        item->accept(*this);
    }
    nest--;
}

void ASTPrinter::visit(IfStmt &node) {
    PrintBlank();
    std::cout << "IfStmt: ";
    if (node.hasElse()) {
        std::cout << "hasElse" << std::endl;
    } else {
        std::cout << std::endl;
    }

    nest++;
    node.getCond()->accept(*this);
    node.getBody()->accept(*this);
    if (node.hasElse()) {
        node.getElseBody()->accept(*this);
    }
    nest--;
}

void ASTPrinter::visit(WhileStmt &node) {
    PrintBlank();
    std::cout << "WhileStmt:" << std::endl;
    nest++;
    node.getCond()->accept(*this);
    node.getBody()->accept(*this);
    nest--;
}

void ASTPrinter::visit(NullStmt &node) {
    PrintBlank();
    std::cout << "NullStmt" << std::endl;
}

void ASTPrinter::visit(BreakStmt &node) {
    PrintBlank();
    std::cout << "BreakStmt" << std::endl;
}

void ASTPrinter::visit(ContinueStmt &node) {
    PrintBlank();
    std::cout << "ContinueStmt" << std::endl;
}

void ASTPrinter::visit(ReturnStmt &node) {
    PrintBlank();
    std::cout << "ReturnStmt:";
    nest++;
    if (node.isVoid()) {
        std::cout << "void" << std::endl;
    } else {
        std::cout << std::endl;
        node.getReturnVal()->accept(*this);
    }
    nest--;
}
} // namespace AST