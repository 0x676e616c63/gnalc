#include "../../../../include/ir/passes/transforms/loop_strength_reduce.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"

namespace IR {
bool propagateExitValues(Function &func, SCEVHandle &scev) {
    bool modified = false;
    for (const auto &bb : func) {
        // We might insert new instructions when expand the SCEVExpr, so `getAllInsts` before.
        auto all_insts = bb->getAllInsts();
        for (const auto &inst : all_insts) {
            if (!isSameType(inst->getType(), makeBType(IRBTYPE::I32)))
                continue;
            auto use_list = inst->getUseList();
            for (const auto &use : use_list) {
                auto user_inst = use->getUser()->as<Instruction>();
                auto user_block = user_inst->getParent();
                auto s = scev.getSCEVAtBlock(inst, user_block);
                if (s && s->isExpr()) {
                    auto expr = s->getExpr();
                    auto exit_value = expr->expand(user_block, user_inst->getIter());
                    user_inst->replaceUse(use, exit_value);
                    modified = true;
                    Logger::logDebug("[LSR] at '", func.getName(), "':'", user_block->getName(),
                                     "': replaced '", inst->getName(), "' with '", exit_value->getName(),
                                     "'");
                }
            }
        }
    }
    return modified;
}

PM::PreservedAnalyses LoopStrengthReducePass::run(Function &function, FAM &fam) {
    bool lsr_inst_modified = false;
    auto& scev = fam.getResult<SCEVAnalysis>(function);

    // First propagates exit values that are compile-time constants
    lsr_inst_modified |= propagateExitValues(function, scev);

    // Expand Peeled TREC

    return lsr_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR