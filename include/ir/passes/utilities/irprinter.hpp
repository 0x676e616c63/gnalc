// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief IR/DebugMessage/SCEV/Range Printer
 */
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_IRPRINTER_HPP
#define GNALC_IR_PASSES_UTILITIES_IRPRINTER_HPP

#include "ir/visitor.hpp"
#include "ir/passes/pass_manager.hpp"

#include <ostream>

namespace IR {
class IRFormatter;

class IRPrinter : public IRVisitor {
private:
    std::ostream &outStream;
    bool withIndent;

public:
    explicit IRPrinter(std::ostream &outStream_, bool withIndent_ = false)
        : outStream(outStream_), withIndent(withIndent_) {}

    void visit(GlobalVariable &node) override;
    void visit(Instruction &node) override;
    void visit(FunctionDecl &node) override;
    void visit(Function &node) override;
    void visit(BasicBlock &node) override;
protected:
    template <typename T> void write(T &&obj) { outStream << obj; }

    template <typename T> void writeln(T &&obj) { outStream << obj << std::endl; }

    template <typename... Args> void write(Args &&...args) { (outStream << ... << args); }

    template <typename... Args> void writeln(Args &&...args) {
        (outStream << ... << args);
        outStream << std::endl;
    }
};

class PrintFunctionPass : public PM::PassInfo<PrintFunctionPass>, public IRPrinter {
public:
    explicit PrintFunctionPass(std::ostream &outStream_)
        : IRPrinter(outStream_, true) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintModulePass : public PM::PassInfo<PrintModulePass>, public IRPrinter {
public:
    explicit PrintModulePass(std::ostream &outStream_) : IRPrinter(outStream_, true) {}

    PM::PreservedAnalyses run(Module &unit, MAM &manager);

    void visit(Module &node) override;
};

class PrintLoopPass : public PM::PassInfo<PrintLoopPass>, public IRPrinter {
public:
    explicit PrintLoopPass(std::ostream &outStream_) : IRPrinter(outStream_, true) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintDebugMessagePass : public PM::PassInfo<PrintDebugMessagePass>, public IRPrinter {
private:
    std::string message;

public:
    explicit PrintDebugMessagePass(std::ostream &outStream_, std::string message_)
        : IRPrinter(outStream_, true), message(std::move(message_)) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintSCEVPass : public PM::PassInfo<PrintSCEVPass>, public IRPrinter {
public:
    explicit PrintSCEVPass(std::ostream &outStream_) : IRPrinter(outStream_, true) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintRangePass : public PM::PassInfo<PrintRangePass>, public IRPrinter {
public:
    explicit PrintRangePass(std::ostream &outStream_) : IRPrinter(outStream_, true) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintLoopAAPass: public PM::PassInfo<PrintLoopAAPass>, public IRPrinter {
public:
    explicit PrintLoopAAPass(std::ostream &outStream_) : IRPrinter(outStream_, true) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};
} // namespace IR

#endif
