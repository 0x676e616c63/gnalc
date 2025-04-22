#pragma once
#ifndef GNALC_MIR_PASSES_UTILITIES_MIRPRINTER_HPP
#define GNALC_MIR_PASSES_UTILITIES_MIRPRINTER_HPP

#include "mir/module.hpp"
#include "mir/passes/pass_manager.hpp"

#include <fstream>

namespace MIR {
class PrintBase {
private:
    std::ostream &outStream;

protected:
    explicit PrintBase(std::ostream &outStream_) : outStream(outStream_) {}

    template <typename T>
    void write(T &&obj) { outStream << obj; }
    template <typename T>
    void writeln(T &&obj) { outStream << obj << std::endl; }

    void visit(Module &);
    void visit(Function &);
    void visit(Instruction &);
    void visit(BasicBlock &);
    void visit(Operand &);
};

class PrintFunctionPass : public PM::PassInfo<PrintFunctionPass>, public PrintBase {
protected:
    Function *curr_func{};
    FAM *fam{};

public:
    explicit PrintFunctionPass(std::ostream &outStream_) : PrintBase(outStream_) {}

    PM::PreservedAnalyses run(Function &, FAM &);
};

class PrintModulePass : public PM::PassInfo<PrintModulePass>, public PrintBase {
public:
    explicit PrintModulePass(std::ostream &outStream_) : PrintBase(outStream_) {}

    PM::PreservedAnalyses run(Module &, MAM &);
};

}; // namespace MIR

#endif