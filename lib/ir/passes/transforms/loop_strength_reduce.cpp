#include "../../../../include/ir/passes/transforms/loop_strength_reduce.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"

namespace IR {
bool propagateConstantExitValues(Function &func, SCEVHandle &scev) {
    bool modified = false;
    for (const auto &bb : func) {
        for (const auto &inst : bb->all_insts()) {
            if (!isSameType(inst->getType(), makeBType(IRBTYPE::I32)))
                continue;
            auto use_list = inst->getUseList();
            for (const auto &use : use_list) {
                auto user_inst = use->getUser()->as<Instruction>();
                auto user_block = user_inst->getParent();
                auto s = scev.getSCEVAtBlock(inst, user_block);
                if (s && s->isExpr()) {
                    auto expr = s->getExpr();
                    if (expr->isIRValue() && expr->getIRValue()->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
                        user_inst->replaceUse(use, expr->getIRValue());
                        modified = true;
                        Logger::logDebug("[LSR] at '", func.getName(), "':'", user_block->getName(),
                                         "': replaced '", inst->getName(), "' with '", expr->getIRValue()->getName(),
                                         "'");
                    }
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
    lsr_inst_modified |= propagateConstantExitValues(function, scev);

    // Expand Peeled TREC

    return lsr_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR