/**
 * @brief 将IR结构输出为.ll文件
 */

#pragma once
#ifndef GNALC_PASSES_UTILITIES_IRPRINTER_HPP
#define GNALC_PASSES_UTILITIES_IRPRINTER_HPP

#include "../../visitor.hpp"
#include "../pass_manager.hpp"

#include <fstream>
#include <iostream>

#include "../analysis/live_analysis.hpp"

namespace IR {
class IRFormatter;

// FIXME: module's printLiveInfo not available
class PrinterBase : public IRVisitor {
private:
    std::ostream &outStream;

protected:
    Liveness liveness;
    bool printLiveInfo;

protected:
    explicit PrinterBase(std::ostream &outStream_, bool printLiveInfo_ = false)
        : outStream(outStream_), printLiveInfo(printLiveInfo_) {}

    template <typename T>
    void write(T &&obj) { outStream << obj; }

    template <typename T>
    void writeln(T &&obj) {
        outStream << obj << std::endl;
    }

    template <typename ...Args>
    void write(Args&& ...args) {
        (outStream << ... << args);
    }

    template <typename ...Args>
    void writeln(Args&& ...args) {
        (outStream << ... << args);
        outStream << std::endl;
    }

    void visit(GlobalVariable &node) override;
    void visit(Instruction &node) override;
    void visit(FunctionDecl &node) override;
    void visit(Function &node) override;
    void visit(BasicBlock &node) override;
};

class PrintFunctionPass : public PM::PassInfo<PrintFunctionPass>,
                          public PrinterBase {
public:
    explicit PrintFunctionPass(std::ostream &outStream_,
                               bool printLiveInfo_ = false)
        : PrinterBase(outStream_, printLiveInfo_) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};

class PrintModulePass : public PM::PassInfo<PrintModulePass>,
                        public PrinterBase {
public:
    explicit PrintModulePass(std::ostream &outStream_)
        : PrinterBase(outStream_, false) {}

    PM::PreservedAnalyses run(Module &unit, MAM &manager);
};

class PrintLoopPass : public PM::PassInfo<PrintLoopPass>, public PrinterBase {
public:
    explicit PrintLoopPass(std::ostream &outStream_)
        : PrinterBase(outStream_, false) {}

    PM::PreservedAnalyses run(Function &unit, FAM &manager);
};
} // namespace IR

#endif
