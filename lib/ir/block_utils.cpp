#include "../../include/ir/block_utils.hpp"
#include "../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../include/ir/instructions/memory.hpp"
#include "../../include/utils/logger.hpp"

#include <algorithm>
#include <list>
#include <utility>

namespace IR {
void linkBB(const pBlock &prebb, const pBlock &nxtbb) {
    prebb->addNextBB(nxtbb);
    nxtbb->addPreBB(prebb);
}

void unlinkBB(const pBlock &prebb, const pBlock &nxtbb) {
    bool ok = prebb->delNextBB(nxtbb);
    Err::gassert(ok);
    ok = nxtbb->delPreBB(prebb);
    Err::gassert(ok);
}

bool safeUnlinkBB(const pBlock &prebb, const pBlock &nxtbb, std::set<pPhi> &dead_phis, UnlinkOptions options) {
    bool need_to_remove_br = false;
    // Unlink CFG
    unlinkBB(prebb, nxtbb);

    // Break BRInst
    auto br = prebb->getBRInst();
    Err::gassert(br != nullptr);
    if (br->isConditional()) {
        auto cond_inst = br->getCond()->as<Instruction>();
        if (br->getTrueDest() == nxtbb)
            br->dropTrueDest();
        else {
            Err::gassert(br->getFalseDest() == nxtbb, "The given block is not a successor.");
            br->dropFalseDest();
        }
        if (options.perform_dce && cond_inst)
            eliminateDeadInsts(std::move(cond_inst), options.fam);
    } else {
        Err::gassert(br->getDest() == nxtbb, "The given block is not a successor.");
        // Well, the block has no successor, this might because we are deleting unreachable blocks.
        // Anyway, tell the caller about it.
        need_to_remove_br = true;
    }

    // Handle PHI
    // This a little tricky because when we're deleting a PHIInst's operand,
    // the result phi might only have one operand. In that case we want to
    // replace the phi with the value in that operand.
    // But when this involving multiple blocks,
    // the replacing might affect other phi in other block, thus cause a replacing propagation.
    // As the propagation goes, a phi can end up self-referenced or even empty (dead block only).
    //
    //        bb0 -- bb1
    //          \    |
    //           bb2
    //
    // bb0:
    //    %0 = phi [ %1, %bb1 ] [ %2, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %2, %bb2 ]
    // bb2:
    //    %2 = phi [ %0, %bb0 ] [ %1, %bb1 ]
    //
    // First we unlink bb1 -> bb2
    //    %2 = phi [ %0, %bb0 ],  then we want to replace %2 with %0
    // So,
    // bb0:
    //    %0 = phi [ %1, %bb1 ] [ %0, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    //
    // Then we unlink bb1 -> bb0
    //    %0 = phi [ %0, %bb2 ],  here we can't replace because that makes no sense.
    // So,
    // bb0:
    //    %0 = phi [ %0, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    //
    // Finally we unlink bb2 -> bb0,
    //    %0 = phi [], a weird empty phi occurred.
    // Note that this can only happen in dead block.
    // And we can't figure if a block is dead, because there might be dead loops.
    // So we just mark the phi as dead.
    // So,
    // bb0:
    //    %0 = phi []
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    for (const auto &phi : nxtbb->phis()) {
        // Delete the phi operand from the unlinked `prebb`
        auto phi_opers = phi->getPhiOpers();
        for (const auto &[v, b] : phi_opers) {
            if (b == prebb) {
                auto ok = phi->delPhiOperByBlock(prebb);
                Err::gassert(ok);
                // Simplify PHI
                auto opers = phi->getPhiOpers();
                if (opers.size() == 1) {
                    // Only one operand, check if it is self-reference.
                    // If it is self-reference, replaceSelf makes no sense.
                    if (opers[0].value != phi)
                        phi->replaceSelf(opers[0].value);
                    dead_phis.emplace(phi);
                } else if (opers.empty())
                    dead_phis.emplace(phi);

                if (options.perform_dce) {
                    if (auto inst = v->as<Instruction>())
                        eliminateDeadInsts(std::move(inst), options.fam);
                }
                break;
            }
        }
    }
    return need_to_remove_br;
}

void moveBlock(const pBlock &bb, const pFunc &new_func, FunctionBBIter location) {
    Err::gassert(bb->getParent() != new_func, "Function not changed");
    bb->getParent()->delFirstOfBlock(bb);
    new_func->addBlock(location, bb);
}
void moveBlocks(FunctionBBIter beg, FunctionBBIter end, const pFunc &new_func, FunctionBBIter location) {
    std::vector<pBlock> tmp{beg, end};
    for (const auto &bb : tmp)
        moveBlock(bb, new_func, location);
}
void moveBlock(const pBlock &bb, const pFunc &new_func) { moveBlock(bb, new_func, new_func->end()); }
void moveBlocks(FunctionBBIter beg, FunctionBBIter end, const pFunc &new_func) {
    moveBlocks(beg, end, new_func, new_func->end());
}

void foldPHI(const pBlock &bb, bool preserve_lcssa) {
    std::set<pInst> dead_phis;
    for (const auto &phi : bb->phis()) {
        if (phi->getUseCount() == 0) {
            dead_phis.emplace(phi);
            continue;
        }
        auto phi_opers = phi->getPhiOpers();
        Err::gassert(!phi_opers.empty());
        if (preserve_lcssa && phi_opers.size() == 1)
            continue;
        pVal common_value = phi_opers[0].value;
        for (const auto &[v, b] : phi_opers) {
            if (common_value != v) {
                common_value = nullptr;
                break;
            }
        }
        if (common_value != nullptr) {
            if (common_value == phi)
                Logger::logWarning("IR::foldPHI: Skipped self-reference phi.");
            else {
                phi->replaceSelf(common_value);
                dead_phis.emplace(phi);
            }
        }
    }
    bb->delInstIf([&dead_phis](const auto &inst) { return dead_phis.find(inst) != dead_phis.end(); },
                  BasicBlock::DEL_MODE::PHI);
}

void removeIdenticalPhi(const pBlock &bb) {
    using ValBBPair = std::pair<pVal, pBlock>;
    std::vector<std::pair<pPhi, std::vector<ValBBPair>>> phi_info;
    for (const auto &phi : bb->phis()) {
        phi_info.emplace_back(phi, std::vector<ValBBPair>{});
        for (const auto &[v, b] : phi->incomings())
            phi_info.back().second.emplace_back(v, b);
        std::sort(phi_info.back().second.begin(), phi_info.back().second.end());
    }

    std::set<pInst> dead_phis;
    for (size_t i = 0; i < phi_info.size(); ++i) {
        if (dead_phis.count(phi_info[i].first))
            continue;
        for (size_t j = i + 1; j < phi_info.size(); ++j) {
            if (phi_info[i].second == phi_info[j].second) {
                phi_info[j].first->replaceSelf(phi_info[i].first);
                dead_phis.emplace(phi_info[j].first);
            }
        }
    }
    bb->delInstIf([&dead_phis](const auto &inst) { return dead_phis.find(inst) != dead_phis.end(); },
                  BasicBlock::DEL_MODE::PHI);
}

pBlock breakCriticalEdge(const pBlock &pred, const pBlock &succ) {
    {
        bool ok = false;
        for (const auto &s : pred->succs()) {
            if (s == succ) {
                ok = true;
                break;
            }
        }
        Err::gassert(ok, "There is no edge between '" + pred->getName() + "' and '" + succ->getName() + "'.");
    }

    if (pred->getNumSuccs() == 1 || succ->getNumPreds() == 1)
        return nullptr;

    // Create a new block
    auto new_block = std::make_shared<BasicBlock>(pred->getName() + "_bce_" + succ->getName());
    pred->getParent()->addBlock(succ->getIter(), new_block);

    // CFG
    unlinkBB(pred, succ);
    linkBB(pred, new_block);
    linkBB(new_block, succ);

    // BRInst
    auto br = pred->getBRInst();
    Err::gassert(br != nullptr);
    bool ok = br->replaceAllOperands(succ, new_block);
    Err::gassert(ok);
    new_block->addInst(std::make_shared<BRInst>(succ));

    // PHI
    for (const auto &phi : succ->phis()) {
        ok = phi->replaceAllOperands(pred, new_block);
        Err::gassert(ok);
    }

    return new_block;
}
bool breakAllCriticalEdges(const Function &function) {
    bool modified = false;
    auto dfv = function.getDFVisitor();
    for (const auto &curr : dfv) {
        auto nextbbs = curr->getNextBB();
        if (nextbbs.size() <= 1)
            continue;
        for (const auto &succ : nextbbs) {
            auto newbb = breakCriticalEdge(curr, succ);
            modified |= (newbb != nullptr);
        }
    }
    return modified;
}

bool isLCSSAPhi(const pPhi &phi, pVal target_val) {
    auto phi_opers = phi->getPhiOpers();
    Err::gassert(!phi_opers.empty());
    if (target_val == nullptr)
        target_val = phi_opers[0].value;
    for (const auto &[val, bb] : phi_opers) {
        if (val != target_val)
            return false;
    }
    return true;
}
pPhi findLCSSAPhi(const pBlock &block, const pVal &value) {
    for (const auto &phi : block->phis()) {
        if (isLCSSAPhi(phi, value))
            return phi;
    }
    return nullptr;
}

bool eliminateDeadInsts(std::vector<pInst>& worklist, FAM *fam) {
    std::set<pInst> visited;
    bool modified = false;
    while (!worklist.empty()) {
        auto inst = worklist.back();
        worklist.pop_back();
        visited.emplace(inst);

        size_t alive_user_cnt = 0;
        for (const auto& user : inst->inst_users()) {
            if (user->getParent() != nullptr)
                ++alive_user_cnt;
        }

        if (alive_user_cnt == 0) {
            if (fam) {
                if (auto call = inst->as<CALLInst>()) {
                    if (hasSideEffect(*fam, call))
                        continue;
                }
            }

            if (inst->is<STOREInst>())
                continue;

            if (inst->getParent())
                inst->getParent()->delInst(inst);

            modified = true;
            for (const auto &operand : inst->operands()) {
                if (auto i = operand->as<Instruction>()) {
                    if (visited.find(i) == visited.end())
                        worklist.emplace_back(i);
                }
            }
        }
    }
    return modified;
}

bool eliminateDeadInsts(pInst inst, FAM *fam) {
    std::vector worklist{ std::move(inst) };
    return eliminateDeadInsts(worklist, fam);
}

bool eliminateDeadInsts(const std::set<pPhi>& dead_phis, FAM *fam) {
    std::vector<pInst> worklist{ dead_phis.begin(), dead_phis.end() };
    return eliminateDeadInsts(worklist, fam);
}

std::tuple<Value *, Value *> analyzeHeaderPhi(const Loop *loop, const PHIInst *header_phi) {
    auto phi_opers = header_phi->getPhiOpers();
    Err::gassert(phi_opers.size() == 2, "Expected LoopSimplified Form");
    auto invariant = phi_opers[0].value.get();
    auto variant = phi_opers[1].value.get();
    if (!loop->isLoopInvariant(invariant))
        std::swap(invariant, variant);
    Err::gassert(loop->isLoopInvariant(invariant) && !loop->isLoopInvariant(variant),
                 "Expected LoopSimplified Form");
    return std::make_tuple(invariant, variant);
}

std::tuple<pVal, pVal> analyzeHeaderPhi(const pLoop &loop, const pPhi &header_phi) {
    auto [invariant, variant] = analyzeHeaderPhi(loop.get(), header_phi.get());
    return std::make_tuple(invariant->as<Value>(), variant->as<Value>());
}
} // namespace IR