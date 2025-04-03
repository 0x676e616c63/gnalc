/**
 * @brief IR/DebugMessage/SCEV Printer
 */
#pragma once
#ifndef GNALC_PASSES_UTILITIES_IRPRINTER_HPP
#define GNALC_PASSES_UTILITIES_IRPRINTER_HPP

#include "ir/visitor.hpp"
#include "ir/passes/pass_manager.hpp"

#include <ostream>

namespace IR {
class IRFormatter;

class PrinterBase : public IRVisitor {
private:
    std::ostream &outStream;

protected:
    explicit PrinterBase(std::ostream &outStream_)
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
    void visit(Function &node) override;
    void visit(BasicBlock &node) override;
};

class PrintFunctionPass : public PM::PassInfo<PrintFunctionPass>, public PrinterBase {
public:
    explicit PrintFunctionPass(std::ostream &outStream_)
        : PrinterBase(outStream_) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintModulePass : public PM::PassInfo<PrintModulePass>, public PrinterBase {
public:
    explicit PrintModulePass(std::ostream &outStream_) : PrinterBase(outStream_) {}

    PM::PreservedAnalyses run(Module &unit, MAM &manager);
};

class PrintLoopPass : public PM::PassInfo<PrintLoopPass>, public PrinterBase {
public:
    explicit PrintLoopPass(std::ostream &outStream_) : PrinterBase(outStream_) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintDebugMessagePass : public PM::PassInfo<PrintDebugMessagePass>, public PrinterBase {
private:
    std::string message;

public:
    explicit PrintDebugMessagePass(std::ostream &outStream_, std::string message_)
        : PrinterBase(outStream_), message(std::move(message_)) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintSCEVPass : public PM::PassInfo<PrintSCEVPass>, public PrinterBase {
public:
    explicit PrintSCEVPass(std::ostream &outStream_) : PrinterBase(outStream_) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};
} // namespace IR

#endif
