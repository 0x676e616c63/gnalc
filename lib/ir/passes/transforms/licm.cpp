#include "ir/passes/transforms/licm.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

#include <algorithm>
#include <string>
#include <vector>

namespace IR {
bool isSafeToMove(const pLoop &loop, const pInst &inst, AliasAnalysisResult &aa_res, FAM &fam) {
    // Only move what we know
    // Do not hoist cmp for codegen
    if (!inst->is<BinaryInst, FNEGInst, CALLInst, LOADInst, STOREInst, GEPInst, CastInst>())
        return false;

    // If the load's memory can be modified in the loop, give up.
    if (auto load = inst->as<LOADInst>()) {
        for (const auto &bb : loop->blocks()) {
            for (const auto &killer : *bb) {
                auto modref = aa_res.getInstModRefInfo(killer, load->getPtr(), fam);
                if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
                    return false;
            }
        }
    } else if (auto call = inst->as<CALLInst>()) {
        if (isPure(fam, call))
            return true;
        if (hasSideEffect(fam, call))
            return false;

        auto rw = getCallRWInfo(fam, call);
        if (!rw.untracked && !rw.write.empty())
            return false;
        if (rw.read.empty())
            return true;

        for (const auto &read : rw.read) {
            for (const auto &bb : loop->blocks()) {
                for (const auto &killer : *bb) {
                    auto modref = aa_res.getInstModRefInfo(killer, read, fam);
                    if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
                        return false;
                }
            }
        }
        return true;
    } else if (auto store = inst->as<STOREInst>()) {
        for (const auto &bb : loop->blocks()) {
            for (const auto &killer : *bb) {
                auto modref = aa_res.getInstModRefInfo(killer, store->getPtr(), fam);
                if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef)
                    return false;
                // If there are multiple store, the sunk store might overwrite them.
                // FIXME: If we can prove this store is bound to execute after every other store,
                //        sunk it is safe.
                if (modref == ModRefInfo::Mod && killer != store)
                    return false;
            }
        }
    }
    return true;
}

bool noUseInLoop(const pLoop &loop, const pInst &inst) {
    Err::gassert(loop->contains(inst->getParent()), "The instruction is not defined in the loop.");
    return std::all_of(inst->user_begin(), inst->user_end(), [&loop](const auto &user) {
        auto user_inst = user->template as<Instruction>();
        return !loop->contains(user_inst->getParent());
    });
}

PM::PreservedAnalyses LICMPass::run(Function &function, FAM &fam) {
    auto &domtree = fam.getResult<DomTreeAnalysis>(function);
    auto &postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    auto &loop_info = fam.getResult<LoopAnalysis>(function);
    auto &aa_res = fam.getResult<AliasAnalysis>(function);

    bool licm_inst_modified = false;

    // Record the index in a Reverse Post Order Traversal.
    // This can make it easier to traverse basic blocks in a loop in a certain order.
    auto bbrpodfv = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    std::map<pBlock, size_t> rpo_index;
    for (size_t i = 0; i < bbrpodfv.size(); ++i)
        rpo_index[bbrpodfv[i]] = i;

    for (const auto &top_level : loop_info) {
        // Do a post order traversal of the loop tree, so that we can move instructions in one go.
        auto lpdfv = top_level->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : lpdfv) {
            Err::gassert(loop->isLCSSAForm(), "Expected LCSSA form in LICM.");
            auto loop_blocks = loop->getBlocks();
            //
            // Sink
            //
            if (loop->hasDedicatedExits()) {
                // Visit blocks that near the exit first
                std::sort(loop_blocks.begin(), loop_blocks.end(),
                          [&rpo_index](const auto &a, const auto &b) { return rpo_index[a] > rpo_index[b]; });
                for (const auto &bb : loop_blocks) {
                    std::set<pInst> dead_insts;
                    // Sink instructions that near the exit first
                    for (const auto &inst : Util::reverse(*bb)) {
                        if (isSafeToMove(loop, inst, aa_res, fam) && noUseInLoop(loop, inst) &&
                            loop->isAllOperandsLoopInvariant(inst)) {
                            // Sink instructions to the exit blocks that dominated by it.
                            // Keep track of the instructions we sunk.
                            // exit block -> new version
                            std::map<pBlock, pInst> sunk_insts;
                            auto exits = loop->getExitBlocks();
                            for (const auto &exit : exits) {
                                if (domtree.ADomB(bb, exit)) {
                                    auto sunk = makeClone(inst);
                                    if (inst->getType()->getTrait() == IRCTYPE::PTR)
                                        aa_res.addClonedInst(inst, sunk);
                                    sunk->setName(inst->getName() + ".licm.s" + std::to_string(name_cnt++));
                                    exit->addInstAfterPhi(sunk);
                                    sunk_insts[exit] = sunk;

                                    // Rewrite the sunk instruction's uses to keep LCSSA Form
                                    for (const auto &use : sunk->operand_uses()) {
                                        if (auto oper = use->getValue()->as<Instruction>()) {
                                            auto oper_inst_block = oper->getParent();
                                            if (loop->contains(oper_inst_block)) {
                                                // See if there is what we want already.
                                                auto avail_phi = findLCSSAPhi(oper_inst_block, oper);
                                                if (avail_phi == nullptr) {
                                                    avail_phi = std::make_shared<PHIInst>(
                                                        "%licm.p" + std::to_string(name_cnt++), oper->getType());
                                                    for (const auto &pred : exit->preds())
                                                        avail_phi->addPhiOper(oper, pred);
                                                    exit->addPhiInst(avail_phi);
                                                    if (oper->getType()->getTrait() == IRCTYPE::PTR)
                                                        aa_res.addClonedInst(oper, avail_phi);
                                                }
                                                use->setValue(avail_phi);
                                            }
                                        }
                                    }
                                    Logger::logDebug("[LICM] on '", function.getName(), "': Sunk an instruction '",
                                                     inst->getName(), "' to exit '", exit->getName(), "'.");
                                }
                            }

                            // If the instruction dominates no exit, sink them is not safe.
                            if (sunk_insts.empty())
                                continue;

                            for (const auto &user : inst->inst_users()) {
                                auto user_block = user->getParent();
                                // A quick path for most uses being in the same block
                                if (user_block == inst->getParent() || loop->contains(user_block))
                                    continue;

                                // Outside Loop Use
                                auto phi = user->as<PHIInst>();
                                Err::gassert(phi != nullptr, "Expected LCSSA form in LICM.");
                                auto exit_block = phi->getParent();
                                Err::gassert(loop->isExit(exit_block), "Expected LCSSA form in LICM.");

                                const auto &sunk = sunk_insts[exit_block];
                                Err::gassert(sunk != nullptr);

                                // Since we've ensured the exit is dedicated, the exit
                                // can not have predecessors outside loop. So any use in the exit block
                                // must be a LCSSA phi. Thus, we can safely replace it with the sunk instruction.
                                Err::gassert(isLCSSAPhi(phi, inst), "Exit is not dedicated");
                                phi->replaceSelf(sunk);
                                dead_insts.emplace(phi);
                            }
                            dead_insts.emplace(inst);
                            for (const auto &[exit, sunk] : sunk_insts) {
                                if (!sunk->is<STOREInst, CALLInst>() && sunk->getUseCount() == 0)
                                    dead_insts.emplace(sunk);
                            }
                            licm_inst_modified = true;
                        }
                    }
                    bb->delInstIf(
                        [&dead_insts](const auto &inst) { return dead_insts.find(inst) != dead_insts.end(); });
                }
            }
            //
            // Hoist
            //
            if (auto preheader = loop->getPreHeader()) {
                // Visit blocks in a topological order
                std::sort(loop_blocks.begin(), loop_blocks.end(),
                          [&rpo_index](const auto &a, const auto &b) { return rpo_index[a] < rpo_index[b]; });
                for (const auto &bb : loop_blocks) {
                    // If this block does not post dominates the preheader,
                    // hoisting them is not safe.
                    if (!postdomtree.ADomB(bb, preheader))
                        continue;
                    // Keep the topological order.
                    std::vector<pInst> to_hoist;
                    for (const auto &inst : *bb) {
                        if (isSafeToMove(loop, inst, aa_res, fam)) {
                            auto invariant = std::all_of(inst->operand_begin(), inst->operand_end(),
                                                         [&loop, to_hoist](const auto &val) {
                                                             if (auto inst = val->template as<Instruction>()) {
                                                                 auto it = std::find(to_hoist.begin(), to_hoist.end(), inst);
                                                                 if (it != to_hoist.end())
                                                                     return true;
                                                                 return !loop->contains(inst->getParent());
                                                             }
                                                             return true;
                                                         });
                            if (invariant)
                                to_hoist.emplace_back(inst);
                        }
                    }

                    for (const auto &inst : to_hoist) {
                        inst->setName(inst->getName() + ".licm.h" + std::to_string(name_cnt++));
                        auto insert_before = preheader->getTerminator()->getIter();
                        if (auto br = preheader->getBRInst()) {
                            if (br->isConditional()) {
                                if (auto cond_inst = br->getCond()->as<Instruction>()) {
                                    if (cond_inst->getParent() == preheader)
                                        insert_before = cond_inst->getIter();
                                    else
                                        Logger::logWarning("Cond '", cond_inst->getName(),
                                                           "' and BRInst are in separate block.");
                                }
                            }
                        }
                        moveInst(inst, preheader, insert_before);
                        Logger::logDebug("[LICM] on '", function.getName(), "': Hoisted an instruction '",
                                         inst->getName(), "' to basic block '", preheader->getName(), "'.");
                        licm_inst_modified = true;
                    }
                }
            }
            Err::gassert(loop->isLCSSAForm(), "LICM should preserve LCSSA form.");
        }
    }
    name_cnt = 0;
    return licm_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR
