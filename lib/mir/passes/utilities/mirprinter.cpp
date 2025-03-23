#include "../../../../include/mir/passes/utilities/mirprinter.hpp"

using namespace MIR;

void PrintBase::visit(Module &mod) { writeln(mod.toString()); }

void PrintBase::visit(Function &func) { writeln(func.toString()); }

void PrintBase::visit(BasicBlock &blk) { writeln(blk.toString()); }

void PrintBase::visit(Instruction &inst) { writeln(inst.toString()); }

void PrintBase::visit(Operand &oper) { write(oper.toString()); }

PM::PreservedAnalyses PrintFunctionPass::run(Function &func, FAM &man) {
    visit(func);
    return PM::PreservedAnalyses::all();
}

PM::PreservedAnalyses PrintModulePass::run(Module &mod, MAM &man) {
    visit(mod);
    return PM::PreservedAnalyses::all();
}