#include "../../../../include/ir/passes/transforms/loop_elimination.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"

namespace IR {
// If all values defined in the loop have no uses outside the loop, or uses outside the loop
// can be replaced with expanded SCEVExpr, it is profitable to propagate the exit values,
// since propagating can let it useless.
bool isSafeAndProfitableToEliminate(const pLoop &loop, FAM &fam, SCEVHandle &scev) {
    // Currently we only handle loops with a single exit and exiting block.
    auto exit = loop->getExitBlocks();
    if (exit.size() != 1)
        return false;

    if (hasSideEffect(fam, loop))
        return false;

    for (const auto &block : loop->blocks()) {
        for (const auto &inst : block->all_insts()) {
            for (const auto &user : inst->inst_users()) {
                auto user_block = user->getParent();
                if (!loop->contains(user_block)) {
                    // Skip Phi. SCEVExpr can not be expanded before phi.
                    if (!user->is<PHIInst>()) {
                        auto s = scev.getSCEVAtBlock(inst, user_block);
                        if (s && s->isExpr())
                            continue;
                    }
                    return false;
                }
            }
        }
    }
    return true;
}

// If SCEV can figure out the exit values used outside the loop, replace them with expanded SCEVExpr.
// Propagating exit values can release some uses outside the loop, thus possibly
// let the loop unused and able to eliminate.
// It don't expand non-constant SCEVExpr if the `onlyConstant` is set.
bool propagateExitValues(Loop &loop, SCEVHandle &scev, bool onlyConstant) {
    bool modified = false;

    auto header = loop.getHeader();
    for (const auto &inst : header->phis()) {
        if (!isSameType(inst->getType(), makeBType(IRBTYPE::I32)))
            continue;
        auto use_list = inst->getUseList();
        for (const auto &use : use_list) {
            auto user_inst = use->getUser()->as<Instruction>();
            // Skip Phi. SCEVExpr can not be expanded before phi.
            if (user_inst->is<PHIInst>())
                continue;

            auto user_block = user_inst->getParent();
            if (loop.contains(user_block))
                continue;
            auto s = scev.getSCEVAtBlock(inst, user_block);
            if (s && s->isExpr()) {
                auto expr = s->getExpr();
                if (onlyConstant &&
                    (!expr->isIRValue() || expr->getIRValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL))
                    continue;
                auto exit_value = scev.expandSCEVExpr(expr, user_block, user_inst->getIter());
                if (exit_value != nullptr) {
                    user_inst->replaceUse(use, exit_value);
                    modified = true;
                    Logger::logDebug("[LoopElimination] at block '", user_block->getName(), "': replaced '",
                                     inst->getName(), "' with '", exit_value->getName(), "'");
                }
            }
        }
    }
    return modified;
}

bool eliminateLoop(FAM& fam, Function &func, const pLoop &loop, LoopInfo& loop_info) {
    // If there are any uses outside loop, give up.
    for (const auto &block : loop->blocks()) {
        for (const auto &inst : block->all_insts()) {
            for (const auto &user : inst->inst_users()) {
                auto user_block = user->getParent();
                if (!loop->contains(user_block))
                    return false;
            }
        }
    }

    auto exits = loop->getExitBlocks();
    auto exitings = loop->getExitingBlocks();

    if (exits.size() != 1)
        return false;

    auto exit = *exits.begin();

    auto preheader = loop->getPreHeader();
    auto header = loop->getHeader();

    auto ph_br = preheader->getBRInst();

    auto cnt = ph_br->replaceAllOperands(header, exit);
    while (cnt--) {
        unlinkBB(preheader, header);
        linkBB(preheader, exit);
    }
    std::set<pPhi> dead_phis;
    for (const auto &exiting : exitings)
        safeUnlinkBB(exiting, exit, dead_phis, UnlinkOptions::performDCE(&fam));

    exit->delInstIf(
        [&dead_phis](const auto &p) { return dead_phis.find(p->template as<PHIInst>()) != dead_phis.end(); },
        BasicBlock::DEL_MODE::PHI);

    // Release dead phi's uses
    for (const auto& phi : dead_phis)
        eliminateDeadInsts(fam, phi);

    // Log before delLoop
    {
        std::string deleted_blocks;
        for (const auto &bb : loop->blocks())
            deleted_blocks += "'" + bb->getName() + "', ";
        deleted_blocks.pop_back();
        deleted_blocks.pop_back();
        Logger::logDebug("[LoopElimination]: Retarget '", preheader->getName(), "' to '", exit->getName(), "'.");
        Logger::logDebug("[LoopElimination]: Deleted ", deleted_blocks, ".");
    }

    // Backup BlockSet since delLoop will empty it.
    auto blockset = loop->getBlockSet();
    // update LoopInfo before delBlockIf to keep the `loop->blocks()` in a valid state
    loop_info.delLoop(loop);

    func.delBlockIf([&blockset](const auto &bb) { return blockset.count(bb.get()); });

    return true;
}

// Break the backedge if it is never taken.
bool breakSingleTripRotatedLoop(FAM& fam, const pLoop &loop, SCEVHandle &scev, LoopInfo& loop_info) {
    auto latch = loop->getLatch();
    if (!loop->isExiting(latch))
        return false;

    auto exitings = loop->getExitingBlocks();
    if (exitings.size() != 1)
        return false;

    auto cnt = scev.getBackEdgeTakenCount(loop);
    // If this is a single trip rotated(do-while) loop, just break the backedge
    if (cnt && cnt->isIRValue() && match(cnt->getRawIRValue(), M::Is(0))) {
        auto header = loop->getHeader();
        for (const auto& phi : header->phis()) {
            auto use_list = phi->getUseList();
            for (const auto& use : use_list) {
                auto user = use->getUser()->as<Instruction>();
                if (!loop->contains(user->getParent())) {
                    auto [invariant, variant] = analyzeHeaderPhi(loop, phi);
                    user->replaceUse(use, variant);
                }
            }
        }

        auto latch_br = latch->getBRInst();
        Err::gassert(latch_br->isConditional());

        std::set<pPhi> dead_phis;
        auto dead_br = safeUnlinkBB(latch, header, dead_phis, UnlinkOptions::performDCE(&fam));
        Err::gassert(!dead_br);
        header->delInstIf(
            [&dead_phis](const auto &p) { return dead_phis.find(p->template as<PHIInst>()) != dead_phis.end(); },
            BasicBlock::DEL_MODE::PHI);
        // Release dead phi's uses
        for (const auto& phi : dead_phis)
            eliminateDeadInsts(fam, phi);

        loop_info.breakLoop(loop);

        Logger::logDebug("[LoopElimination]: Broke backedge from '", latch->getName(), "' to '", header->getName(),
                 "'");
        return true;
    }
    return false;
}

PM::PreservedAnalyses LoopEliminationPass::run(Function &function, FAM &fam) {
    bool loop_elim_inst_modified = false;
    bool loop_elim_cfg_modified = false;
    auto &scev = fam.getResult<SCEVAnalysis>(function);
    auto &loop_info = fam.getResult<LoopAnalysis>(function);

    // Since we might delete loops, make a temporary object.
    auto toplevels = loop_info.getTopLevelLoops();
    for (const auto &toplevel : toplevels) {
        auto rpodfv = toplevel->getDFVisitor<Util::DFVOrder::ReversePostOrder>();
        for (const auto &loop : rpodfv) {
            Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form.");
            if (breakSingleTripRotatedLoop(fam, loop, scev, loop_info)) {
                loop_elim_cfg_modified = true;
                continue;
            }

            // Expanding non-constant SCEVExpr will generate many IR Instructions,
            // which can be a pessimization if the original loop can not be eliminated.
            // Thus, we use `isSafeAndProfitableToEliminate` to see if expanding non-constant SCEVExprs
            // can lead to the elimination of the loop. If not, we only expand constants.
            // Note that propagating constant values are always profitable,
            // since they can always expose more optimization opportunities.
            if (isSafeAndProfitableToEliminate(loop, fam, scev)) {
                loop_elim_inst_modified |= propagateExitValues(*loop, scev, false);
                loop_elim_cfg_modified |= eliminateLoop(fam ,function, loop, loop_info);
            }
            else
                loop_elim_inst_modified |= propagateExitValues(*loop, scev, true);
        }
    }

    if (loop_elim_cfg_modified)
        return PreserveNone();

    return loop_elim_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR