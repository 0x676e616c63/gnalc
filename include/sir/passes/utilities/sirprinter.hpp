// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_PASSES_UTILITIES_IRPRINTER_HPP
#define GNALC_SIR_PASSES_UTILITIES_IRPRINTER_HPP

#include "ir/passes/utilities/irprinter.hpp"
#include "sir/base.hpp"
#include "sir/passes/pass_manager.hpp"

namespace SIR {
class LinearPrinterBase : public IRVisitor {
private:
    std::ostream &outStream;
    size_t indentLevel = 0;
    void indent();

protected:
    explicit LinearPrinterBase(std::ostream &outStream_)
        : outStream(outStream_) {}

    template <typename T> void write(T &&obj) { outStream << obj; }

    template <typename T> void writeln(T &&obj) { outStream << obj << std::endl; }

    template <typename... Args> void write(Args &&...args) { (outStream << ... << args); }

    template <typename... Args> void writeln(Args &&...args) {
        (outStream << ... << args);
        outStream << std::endl;
    }

    void visit(GlobalVariable &node) override;
    void visit(Instruction &node) override;
    void visit(FunctionDecl &node) override;
    void visit(LinearFunction &node) override;
    void visitCondInst(Value& value);
    void visitCondValue(Value& value, bool is_first = true);
};

class PrintLinearFunctionPass : public PM::PassInfo<PrintLinearFunctionPass>, public LinearPrinterBase {
public:
    explicit PrintLinearFunctionPass(std::ostream &outStream_)
        : LinearPrinterBase(outStream_) {}

    PM::PreservedAnalyses run(LinearFunction &unit, LFAM &manager);
};

class PrintLinearModulePass : public PM::PassInfo<PrintLinearModulePass>, public LinearPrinterBase {
public:
    explicit PrintLinearModulePass(std::ostream &outStream_) : LinearPrinterBase(outStream_) {}

    PM::PreservedAnalyses run(Module &unit, MAM &manager);
};

class PrintAffineAAPass : public PM::PassInfo<PrintAffineAAPass>, public LinearPrinterBase {
public:
    explicit PrintAffineAAPass(std::ostream &outStream_) : LinearPrinterBase(outStream_) {}

    PM::PreservedAnalyses run(LinearFunction &unit, LFAM &manager);
};
} // namespace IR

#endif
