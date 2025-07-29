// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/loop_strength_reduce.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"
#include "../../../../include/ir/match.hpp"
#include "../../../../include/config/config.hpp"

namespace IR {
// void debug_print_scev(Function &function, FAM & fam) {
//     auto& scev = fam.getResult<SCEVAnalysis>(function);
//     const DomTree &domtree = fam.getResult<DomTreeAnalysis>(function);
//     for (const auto &bb : function) {
//         for (const auto &inst : bb->all_insts()) {
//             if (!inst->getType()->isI32())
//                 continue;
//             for (const auto &scev_block : function) {
//                 if (!domtree.ADomB(bb, scev_block))
//                     continue;
//                 auto s = scev.getSCEVAtBlock(inst, scev_block);
//                 // Since we've ensured the value is available in this block,
//                 // getSCEVAtBlock should not return nullptr.
//                 Err::gassert(s != nullptr);
//                 if (!s->isUntracked())
//                     Logger::logDebug("LSR Debug: ", inst->getName(), " at block '", scev_block->getName(), "': ", *s);
//             }
//         }
//     }
// }

PM::PreservedAnalyses LoopStrengthReducePass::run(Function &function, FAM &fam) {
    bool lsr_inst_modified = false;
    auto& loop_info = fam.getResult<LoopAnalysis>(function);
    auto& scev = fam.getResult<SCEVAnalysis>(function);
    auto domtree = fam.lazyGetResult<DomTreeAnalysis>(function);
    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : looppdfv) {
            Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");
            if (loop->getExitBlocks().size() != 1)
                continue;
            for (const auto& bb : loop->blocks()) {
                auto insts = bb->getInsts();
                for (const auto& inst : insts) {
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
                            if (!cost || *cost > Config::IR::LSR_EXPANSION_THRESHOLD)
                                continue;
                            if (auto phi = scev.expandAddRec(evo)) {
                                auto use_list = curr->getUseList();
                                curr->replaceSelf(phi);
                                Logger::logDebug("[LSR]: expanded AddRec for '", curr->getName(), "'.");
                                eliminateDeadInsts(curr);

                                // FIXME: Do NOT forget all, it's time-consuming.
                                scev.forgetAll();
                                lsr_inst_modified = true;
                                // debug_print_scev(function, fam);
                            }
                        }
                    } else if (pVal base, index;
                        match(inst, M::Gep(M::Bind(base), M::IsIntegerVal(0), M::Bind(index)))) {
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
                            auto header = evo_loop->getHeader();
                            auto latch = evo_loop->getLatch();

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

                            static size_t name_cnt = 0;
                            auto phi_name = "%lsr.ptr.phi." + std::to_string(name_cnt);
                            auto phi = std::make_shared<PHIInst>(phi_name, inst->getType());
                            auto base_gep_name = "%lsr.ptr.base." + std::to_string(name_cnt);
                            auto base_gep = std::make_shared<GEPInst>(base_gep_name, base,
                                function.getConst(0), function.getConst(evo_base));
                            auto upd_gep_name = "%lsr.ptr.upd." + std::to_string(name_cnt);
                            auto update_gep = std::make_shared<GEPInst>(upd_gep_name, phi,
                                function.getConst(evo_step));
                            ++name_cnt;

                            phi->addPhiOper(base_gep, preheader);
                            phi->addPhiOper(update_gep, latch);

                            preheader->addInst(preheader->getEndInsertPoint(), base_gep);
                            header->addPhiInst(phi);
                            latch->addInst(latch->getEndInsertPoint(), update_gep);
                            inst->replaceSelf(phi);

                            Logger::logDebug("[LSR]: Reduced gep '", inst->getName(), "'.");
                            // FIXME: Do NOT forget all, it's time-consuming.
                            scev.forgetAll();
                            lsr_inst_modified = true;
                        }
                    }
                }
            }
        }
    }
    return lsr_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR