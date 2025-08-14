// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/codegen_prepare.hpp"
#include "ir/block_utils.hpp"
#include "ir/passes/analysis/target_analysis.hpp"
#include "ir/passes/transforms/cfgsimplify.hpp"

namespace IR {
// bb0:
//   ... before ...
//   a = select cond, true_val, false_val
//   ... after ...
//
//      <to>
//
// bb0_front:
//   ... before ...
//   br cond, true_bb, false_bb
// true_bb:
//   br bb0_behind
// false_bb:
//   br bb0_behind
// bb0_behind:
//   a' = phi [ true_val, true_bb ], [ false_val, false_bb ]
void expandSelect(Function &func, const pSelect &select) {
    auto bb_front = select->getParent();
    auto bb_behind = std::make_shared<BasicBlock>(bb_front->getName() + ".behind");

    auto true_bb = std::make_shared<BasicBlock>(bb_front->getName() + ".true");
    auto false_bb = std::make_shared<BasicBlock>(bb_front->getName() + ".false");

    bb_front->setName(bb_front->getName() + ".front");

    true_bb->addInst(std::make_shared<BRInst>(bb_behind));
    false_bb->addInst(std::make_shared<BRInst>(bb_behind));

    moveInsts(std::next(select->iter()), bb_front->end(), bb_behind);

    bb_front->addInst(std::make_shared<BRInst>(select->getCond(), true_bb, false_bb));

    auto sel_phi = std::make_shared<PHIInst>(select->getName() + ".phi", select->getType());
    sel_phi->addPhiOper(select->getTrueVal(), true_bb);
    sel_phi->addPhiOper(select->getFalseVal(), false_bb);
    bb_behind->addPhiInst(sel_phi);
    select->replaceSelf(sel_phi);
    bb_front->delFirstOfInst(select);

    func.addBlock(std::next(bb_front->getIter()), bb_behind);
    func.addBlock(bb_behind->getIter(), true_bb);
    func.addBlock(true_bb->getIter(), false_bb);

    auto old_succs = bb_front->getNextBB();
    for (const auto &succ : old_succs) {
        for (const auto &old_phi : succ->phis())
            old_phi->replaceAllOperands(bb_front, bb_behind);
        unlinkOneEdge(bb_front, succ);
        linkBB(bb_behind, succ);
    }

    linkBB(bb_front, true_bb);
    linkBB(bb_front, false_bb);
    linkBB(true_bb, bb_behind);
    linkBB(false_bb, bb_behind);

    // Try sink true_val and false_val to true_bb and false_bb respectively.
    auto trySinkToBlock = [&](const pVal &val, const pBlock &bb) {
        auto inst = val->as<Instruction>();
        if (!inst)
            return;

        // Try to move the inst and all its operands to the block.
        auto candidates = collectOperandInsts(inst);
        candidates.emplace_back(inst);

        std::sort(candidates.begin(), candidates.end(),
                  [](const pInst &a, const pInst &b) { return a->getIndex() > b->getIndex(); });

        std::vector<pInst> to_sink;
        for (const auto &cand : candidates) {
            if (auto cand_inst = cand->as<Instruction>()) {
                if (cand_inst->is<PHIInst>() || cand_inst->getParent() != bb_front)
                    continue;

                bool safe_to_sink = true;
                for (const auto &use : cand_inst->self_uses()) {
                    auto user = use->getUser()->as<Instruction>();
                    if (user == select || (user == sel_phi && sel_phi->getBlockForValue(use) == bb))
                        continue;
                    if (std::find(to_sink.begin(), to_sink.end(), user) == to_sink.end()) {
                        safe_to_sink = false;
                        break;
                    }
                }

                if (safe_to_sink)
                    to_sink.push_back(cand_inst);
            }
        }

        std::sort(to_sink.begin(), to_sink.end(),
                  [](const pInst &a, const pInst &b) { return a->getIndex() < b->getIndex(); });
        for (const auto &i : to_sink) {
            bool ok = bb_front->delFirstOfInst(i);
            Err::gassert(ok, "Sink what?");
            bb->addInstBeforeTerminator(i);

            Logger::logDebug("[CodeGenPrePare]: Sunk instruction '", i->getName(), "' to block '", bb->getName(), "'.");
        }
    };
    trySinkToBlock(select->getTrueVal(), true_bb);
    trySinkToBlock(select->getFalseVal(), false_bb);

    Logger::logDebug("[CodeGenPrePare]: Expanded select '", select->getName(), "'.");
}

PM::PreservedAnalyses CodeGenPreparePass::run(Function &function, FAM &fam) {
    auto &target = fam.getResult<TargetAnalysis>(function);

    if (!target->isSelectSupported()) {
        std::vector<pSelect> candidates;
        for (const auto &bb : function) {
            for (const auto &inst : *bb) {
                if (auto sel = inst->as<SELECTInst>())
                    candidates.push_back(sel);
            }
        }

        for (const auto &sel : candidates)
            expandSelect(function, sel);

        if (!candidates.empty()) {
            CFGSimplifyPass cfg_simplify;
            cfg_simplify.run(function, fam);
        }
    }

    breakAllCriticalEdges(function);
    // Since this is the last IR Pass, preserving analysis is unnecessary.
    return PreserveNone();
}

} // namespace IR