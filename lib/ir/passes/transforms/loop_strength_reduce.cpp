// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/loop_strength_reduce.hpp"
#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "mir/tools.hpp"

namespace IR {
Attr::AttrKey LSRAttrs::Key;

bool reduceMultiply(SCEVHandle &scev, LoopInfo &loop_info) {
    bool reduced = false;
    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : looppdfv) {
            Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");
            if (loop->getExitBlocks().size() != 1)
                continue;

            for (const auto &bb : loop->blocks()) {
                auto insts = bb->getInsts();
                for (const auto &inst : insts) {
                    if (pVal x, y; match(inst, M::Mul(M::Bind(x), M::Bind(y)))) {
                        auto curr = inst;
                        // Get the root of the arithmetic tree
                        while (curr->getUseCount() == 1) {
                            auto user = curr->getSingleUser()->as<Instruction>();
                            if (!user->is<BinaryInst>())
                                break;
                            auto user_evo = scev.getSCEVAtBlock(user.get(), bb);
                            if (user_evo && user_evo->isAddRec())
                                curr = user;
                            else
                                break;
                        }
                        auto evo = scev.getSCEVAtBlock(curr.get(), bb);
                        if (evo && evo->isAddRec()) {
                            auto cost = scev.estimateExpansionCost(evo);
                            if (!cost || *cost > Config::IR::LSR_MULTIPLY_EXPANSION_THRESHOLD)
                                continue;
                            if (auto phi = scev.expandAddRec(evo)) {
                                auto use_list = curr->getUseList();
                                curr->replaceSelf(phi);
                                Logger::logDebug("[LSR]: expanded AddRec for '", curr->getName(), "'.");
                                eliminateDeadInsts(curr);

                                // FIXME: Do NOT forget all, it's time-consuming.
                                scev.forgetAll();
                                reduced = true;
                            }
                        }
                    }
                }
            }
        }
    }
    return reduced;
}

struct GepReductionKey {
    pVal ptr_base;
    int evo_base;
    int evo_step;
    const Loop *evo_loop;
};

bool operator==(const GepReductionKey &lhs, const GepReductionKey &rhs) {
    return lhs.ptr_base == rhs.ptr_base && lhs.evo_base == rhs.evo_base && lhs.evo_step == rhs.evo_step &&
           lhs.evo_loop == rhs.evo_loop;
}

struct GepReductionKeyHash {
    size_t operator()(const GepReductionKey &gep) const {
        size_t seed = std::hash<pVal>()(gep.ptr_base);
        Util::hashSeedCombine(seed, std::hash<int>()(gep.evo_base));
        Util::hashSeedCombine(seed, std::hash<int>()(gep.evo_step));
        Util::hashSeedCombine(seed, std::hash<const Loop *>()(gep.evo_loop));
        return seed;
    }
};

bool reduceGep(Function &function, SCEVHandle &scev, LoopInfo &loop_info, FAM::LazyResult<DomTreeAnalysis> &domtree) {
    std::unordered_map<GepReductionKey, std::vector<pVal>, GepReductionKeyHash> candidates;

    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : looppdfv) {
            Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");
            if (loop->getExitBlocks().size() != 1)
                continue;

            for (const auto &bb : loop->blocks()) {
                auto insts = bb->getInsts();
                for (const auto &inst : insts) {
                    if (pVal base, index; match(inst, M::Gep(M::Bind(base), M::IsIntegerVal(0), M::Bind(index)))) {
                        auto size = base->getType()->as<PtrType>()->getElmType()->getBytes();
                        // Multiply by power of two can be optimized to a shift.
                        // Don't reduce them to avoid too much phi nodes.
                        // It's a common case since size often is a power of two.
                        if (Util::isPowerOfTwo(size))
                            continue;
                        auto evo = scev.getSCEVAtBlock(index.get(), bb);
                        if (evo && evo->getConstantAffineAddRec()) {
                            auto [evo_base, evo_step] = *evo->getConstantAffineAddRec();
                            auto evo_loop = evo->getLoop();
                            auto preheader = evo_loop->getPreHeader();

                            // Don't generate gep with negative index
                            if (evo_step <= 0)
                                continue;

                            if (auto base_inst = base->as<Instruction>()) {
                                // If the base is not available in the preheader, give up.
                                // This won't miss too much opportunity since if we can hoist that
                                // to the preheader, LICM would have hoisted it already.
                                if (!domtree->ADomB(base_inst->getParent(), preheader)) {
                                    Logger::logDebug("[LSR]: Canceled reducing a gep because the"
                                                     " base is not available in the preheader.");
                                    continue;
                                }
                            }

                            auto key = GepReductionKey{
                                .ptr_base = base, .evo_base = evo_base, .evo_step = evo_step, .evo_loop = evo_loop};
                            candidates[key].emplace_back(inst);
                        }
                    }
                }
            }
        }
    }

    if (candidates.empty())
        return false;

    // Don't reduce too many geps to keep register pressure low.
    int cost = 0;
    constexpr int live_interval_weight = 1;
    constexpr int geps_weight = 2;
    constexpr int loop_depth_weight = 2;
    for (const auto &[key, geps] : candidates) {
        cost += (key.evo_loop->getInstCount() * live_interval_weight - geps.size() * geps_weight) *
                key.evo_loop->getLoopDepth() * loop_depth_weight;
    }
    if (cost >= -Config::IR::LSR_GEP_REDUCTION_COST_THRESHOLD) {
        Logger::logDebug("[LSR]: Canceled reducing geps because the cost is too high. (", cost, ")");
        return false;
    }

    Logger::logDebug("[LSR]: Reducing a bundle of geps with cost ", cost, ".");
    for (const auto &[key, geps] : candidates) {
        const auto &[ptr_base, evo_base, evo_step, evo_loop] = key;
        static size_t name_cnt = 0;
        auto phi_name = "%lsr.ptr.phi." + std::to_string(name_cnt);
        auto phi = std::make_shared<PHIInst>(phi_name, geps[0]->getType());
        auto base_gep_name = "%lsr.ptr.base." + std::to_string(name_cnt);
        auto base_gep =
            std::make_shared<GEPInst>(base_gep_name, ptr_base, function.getConst(0), function.getConst(evo_base));
        auto upd_gep_name = "%lsr.ptr.upd." + std::to_string(name_cnt);
        auto update_gep = std::make_shared<GEPInst>(upd_gep_name, phi, function.getConst(evo_step));
        ++name_cnt;

        auto preheader = evo_loop->getPreHeader();
        auto header = evo_loop->getHeader();
        auto latch = evo_loop->getLatch();

        phi->addPhiOper(base_gep, preheader);
        phi->addPhiOper(update_gep, latch);

        preheader->addInst(preheader->getEndInsertPoint(), base_gep);
        header->addPhiInst(phi);
        latch->addInst(latch->getEndInsertPoint(), update_gep);
        Logger::logDebug("[LSR]: Generated phi '", phi->getName(), "'.");

        for (const auto &gep : geps) {
            gep->replaceSelf(phi);
            Logger::logDebug("[LSR]: Reduced gep '", gep->getName(), "' with phi '", phi->getName(), "'.");
        }
    }
    return true;
}

PM::PreservedAnalyses LoopStrengthReducePass::run(Function &function, FAM &fam) {
    bool lsr_inst_modified = false;
    auto &loop_info = fam.getResult<LoopAnalysis>(function);
    auto &scev = fam.getResult<SCEVAnalysis>(function);
    auto domtree = fam.lazyGetResult<DomTreeAnalysis>(function);

    lsr_inst_modified |= reduceMultiply(scev, loop_info);
    lsr_inst_modified |= reduceGep(function, scev, loop_info, domtree);

    return lsr_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR