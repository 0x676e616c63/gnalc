// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/if_conversion.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/target_analysis.hpp"

namespace IR {
bool isSafeAndProfitableToConvert(const pBlock &bb) {
    if (bb->getInsts().size() > Config::IR::IF_CONVERSION_DUPLICATION_THRESHOLD)
        return false;

    for (const auto &inst : *bb) {
        if (inst->is<STOREInst, LOADInst, CALLInst>())
            return false;

        if (inst->getOpcode() == OP::DIV || inst->getOpcode() == OP::SREM || inst->getOpcode() == OP::FDIV ||
            inst->getOpcode() == OP::FREM)
            return false;
    }
    return true;
}
// bb0:                                           bb0:
//   cond = cmp xxx, xxx                            br bb1
//   br cond, bb1, bb2
// bb1:                                           bb1:
//   ; something                                    ; something
//   br bb3                           --->          cond = cmp xxx, xxx
// bb3:                                             vs = select cond, v1, v0
//   val = phi [v0, bb0], [v1, bb1]                 br bb3
//                                                bb3:
//                                                    val = phi [vs, bb1]
//
//  bb0 ---> bb1 ---> bb3               bb0 ---> bb1 ---> bb3
//   |                 ^                       (select)
//   |                 |       --->
//   |-----------------
PM::PreservedAnalyses IfConversionPass::run(Function &function, FAM &fam) {
    auto& target = fam.getResult<TargetAnalysis>(function);
    if (!target->isSelectSupported())
        return PreserveAll();

    bool if_conv_cfg_modified = false;

    for (const auto &curr : function) {
        // Find the block that has single predecessor and single successor.
        if (curr->getNumPreds() != 1 || curr->getNumSuccs() != 1)
            continue;

        auto single_pred = curr->getPreBB().front();
        auto single_succ = curr->getNextBB().front();

        auto pred_br = single_pred->getBRInst();
        if (!pred_br || !pred_br->isConditional())
            continue;

        if (!pred_br->hasDest(single_succ))
            continue;
        Err::gassert(pred_br->hasDest(curr), "Invalid CFG.");

        // At this point, we've ensured the CFG is suitable for if conversion.
        // Now check if curr has any instruction that can't be duplicated, or
        // the cost of duplication exceeds the threshold.
        if (!isSafeAndProfitableToConvert(curr))
            continue;

        auto cond = pred_br->getCond();
        if (auto cond_inst = cond->as<Instruction>()) {
            // We don't do GVN-PRE on Cmp, so those cases are extremely rare.
            // (Well, I don't think it will happen.)
            if (cond_inst->getParent() != single_pred)
                Logger::logWarning("Cond '", cond_inst->getName(), "' and BRInst are in separate block.");
            // Can't be moved
            if (cond_inst->getUseCount() != 1) {
                Logger::logWarning("Cond '", cond_inst->getName(),
                                   "' has multiple uses. (possibly more than one BRInst)");
                continue;
            }

            cond_inst->getParent()->delFirstOfInst(cond_inst);
            curr->addInstBeforeTerminator(cond_inst);
        }

        auto true_in_bb = pred_br->getTrueDest() == curr ? curr : single_pred;
        auto false_in_bb = true_in_bb == curr ? single_pred : curr;

        for (const auto &phi : single_succ->phis()) {
            auto select =
                std::make_shared<SELECTInst>("%ifconv.s" + std::to_string(name_cnt++), cond,
                                             phi->getValueForBlock(true_in_bb), phi->getValueForBlock(false_in_bb));
            curr->addInstBeforeTerminator(select);
            phi->delPhiOperByBlock(single_pred);
            phi->delPhiOperByBlock(curr);
            phi->addPhiOper(select, curr);
        }

        pred_br->dropOneDest(single_succ);
        unlinkOneEdge(single_pred, single_succ);

        Logger::logDebug("[IfConv]: If-Converted '", single_pred->getName(), "', '", curr->getName(), "' and '",
                         single_succ->getName(), "'.");

        if_conv_cfg_modified = true;
    }

    name_cnt = 0;

    return if_conv_cfg_modified ? PreserveNone() : PreserveAll();
}
} // namespace IR