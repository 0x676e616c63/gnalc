#include "../../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../../include/ir/formatter.hpp"

#include "../../../../include/ir/passes/analysis/live_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
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
    for (const auto& inst : node.getPhiInsts())
        inst->Instruction::accept(*this);
    for (const auto& inst : node.getInsts())
        inst->Instruction::accept(*this);
    writeln("");
}

PM::PreservedAnalyses PrintFunctionPass::run(Function &func, FAM &fam) {
    if (printLiveInfo)
        liveness = fam.getResult<LiveAnalysis>(func);

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

PM::PreservedAnalyses PrintLoopPass::run(Function &func, FAM &fam) {
    auto loop_info = fam.getResult<LoopAnalysis>(func);
    const auto& top_levels = loop_info.getTopLevelLoops();

    auto print_loop = [this] (const std::shared_ptr<Loop>& loop) {
        writeln("Loop Depth: " + std::to_string(loop->getLoopDepth()));
        auto preheader = loop->getPreHeader();
        if (preheader) {
            writeln("PreHeader: ");
            preheader->accept(*this);
        }
        writeln("Header: ");
        loop->getHeader()->accept(*this);

        auto latches = loop->getLatches();
        for (const auto& latch : latches) {
            writeln("Latch: ");
            latch->accept(*this);
        }

        auto exits = loop->getExitBlocks();
        for (const auto& exit : exits) {
            writeln("Exit: ");
            exit->accept(*this);
        }
    };

    writeln("Printing Loops: ");
    for (const auto& loop : top_levels) {
        print_loop(loop);
        for (size_t i = 0; i < loop->getSubLoops().size(); ++i) {
            writeln("SubLoop " + std::to_string(i) + ": ");
            print_loop(loop->getSubLoops()[i]);
        }
        writeln("----------");
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR
