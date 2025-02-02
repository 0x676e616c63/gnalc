#include "../../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../../include/ir/formatter.hpp"

#include "../../../../include/ir/passes/analysis/live_analysis.hpp"
#include "../../../../include/utils/logger.hpp"

namespace IR {
void PrinterBase::visit(GlobalVariable &node) {
    writeln(IRFormatter::formatGV(node));
}

void PrinterBase::visit(FunctionDecl &node) {
    write(IRFormatter::formatFuncDecl(node));
}

void PrinterBase::visit(Instruction &node) {
    if (printLiveInfo) {
        write("  ; livein:");
        for (auto &val : liveness.getLiveIn(&node))
            write(" " + val->getName());
        writeln("");
        write("  ; liveout:");
        for (auto &val : liveness.getLiveOut(&node))
            write(" " + val->getName());
        writeln("");
    }

    // It seems there is no nested scope, so it is a fixed indent.
    write("  ");

    writeln(IRFormatter::formatInst(node));
}

void PrinterBase::visit(Function &node) {
    write(IRFormatter::formatFunc(node));
    writeln(" {");

    for (auto &blk : node.getBlocks())
        blk->accept(*this);

    writeln("}");
}

void PrinterBase::visit(BasicBlock &node) {
    if (printLiveInfo) {
        write("; livein:");
        for (auto &val : liveness.getLiveIn(&node))
            write(" " + val->getName());
        writeln("");
        write("; liveout:");
        for (auto &val : liveness.getLiveOut(&node))
            write(" " + val->getName());
        writeln("");
    }

    write(IRFormatter::formatBB(node));
    writeln(":");
    for (auto &inst : node.getInsts())
        inst->Instruction::accept(*this);
    writeln("");
}

PM::PreservedAnalyses PrintFunctionPass::run(Function &func, FAM &fam) {
    if (printLiveInfo)
        liveness = fam.getResult<LiveAnalyser>(func);

    func.accept(*this);
    return PM::PreservedAnalyses::all();
}

PM::PreservedAnalyses PrintModulePass::run(Module &module, MAM &mam) {
    if (printLiveInfo)
        Err::todo("FIXME: Module's printLiveInfo not available");

    writeln("; Module: " + module.getName());
    writeln("");

    for (auto &gv : module.getGlobalVars())
        gv->accept(*this);

    writeln("");

    for (auto &func : module.getFunctions()) {
        func->accept(*this);
        writeln("");
    }

    for (auto &func_decl : module.getFunctionDecls()) {
        func_decl->accept(*this);
        writeln("");
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR
