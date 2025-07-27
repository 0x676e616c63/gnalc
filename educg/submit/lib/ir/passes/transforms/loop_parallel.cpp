// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/loop_parallel.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/irbuilder.hpp"
#include "../../../../include/ir/match.hpp"
#include "../../../../include/ir/passes/analysis/basic_alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"
#include "../../../../include/ir/passes/analysis/target_analysis.hpp"
#include "../../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../../include/match/match.hpp"

#include <vector>

using namespace Match;

namespace IR {
bool isMemoryIndependentForEachIteration(FAM *fam, LoopAAResult *loop_aa, const pLoop &loop) {
    std::vector<pLoad> loads;
    std::vector<pStore> stores;
    for (const auto &block : loop->blocks()) {
        for (const auto &inst : *block) {
            if (auto call = inst->as<CALLInst>()) {
                if (hasSideEffect(*fam, call)) {
                    Logger::logDebug("[Para]: Find call to a function with side effect ('", call->getFuncName(), "'.");
                    return false;
                }
            } else if (auto load = inst->as<LOADInst>()) {
                // Skip scalar global variables, we've checked them before
                if (auto gv = load->getPtr()->as<GlobalVariable>()) {
                    if (!gv->isArray())
                        continue;
                }
                loads.emplace_back(load);
            } else if (auto store = inst->as<STOREInst>()) {
                if (auto gv = store->getPtr()->as<GlobalVariable>()) {
                    if (!gv->isArray())
                        continue;
                }
                stores.emplace_back(store);
            }
        }
    }

    // For MustAlias and NoAlias, they can't have loop-carried dependencies.
    for (const auto &load : loads) {
        for (const auto &store : stores) {
            auto alias = loop_aa->getAliasInfo(load->getPtr(), store->getPtr());
            if (alias == AliasInfo::MayAlias) {
                Logger::logDebug("[Para]: Find dependency between '", load->getName(), "' and '", store->getName(),
                                 "'.");
                return false;
            }
        }
    }

    for (const auto &store1 : stores) {
        for (const auto &store2 : stores) {
            if (store1 == store2)
                continue;

            auto alias = loop_aa->getAliasInfo(store1->getPtr(), store2->getPtr());
            if (alias == AliasInfo::MayAlias) {
                Logger::logDebug("[Para]: Find dependency between '", store1->getName(), "' and '", store2->getName(),
                                 "'.");
                return false;
            }
        }
    }
    return true;
}
bool hasSylibOrRecursiveCall(Function *func, FAM *fam, const pLoop &loop) {
    for (const auto &block : loop->blocks()) {
        for (const auto &inst : *block) {
            if (auto call = inst->as<CALLInst>()) {
                if (call->getFunc().get() == func)
                    return true;

                if (call->getFunc()->hasFnAttr(FuncAttr::isSylib))
                    return true;

                auto callee_def = call->getFunc()->as<Function>();
                if (!callee_def)
                    continue;
                auto &basic_aa = fam->getResult<BasicAliasAnalysis>(*callee_def);
                if (basic_aa.hasSylibCall())
                    return true;
            }
        }
    }
    return false;
}
void rewriteSelfUsesInLoop(const pLoop &loop, const pVal &val, const pVal &to) {
    std::vector<Use *> uses_to_rewrite;
    for (auto use : val->self_uses()) {
        auto user_block = use->getUser()->as<Instruction>()->getParent();
        if (loop->contains(user_block))
            uses_to_rewrite.emplace_back(use);
    }
    for (auto use : uses_to_rewrite)
        use->setValue(to);
}
bool hasUsesInsideLoop(const pLoop &loop, const pVal &val) {
    for (const auto &inst_user : val->inst_users()) {
        if (loop->contains(inst_user->getParent()))
            return true;
    }
    return false;
}
bool hasUsesOutsideLoop(const pLoop &loop, const pVal &val) {
    for (const auto &inst_user : val->inst_users()) {
        if (!loop->contains(inst_user->getParent()))
            return true;
    }
    return false;
}
struct ParallelLoopInfo {
    bool can_parallel;
    pBlock header, preheader, latch, exit;
    pPhi iv;
    pVal iv_base, iv_bound;
    struct Reduction {
        pPhi phi;
        pVal base;
        pVal inc;
        IRBuilder update_point;
        std::unordered_set<pInst> to_del;
    };
    std::vector<Reduction> reductions;
    pIcmp exit_icmp;
    struct ScalarGV {
        pGlobalVar gv;
        pVal inc;
        pLoad load;
        pStore store;
        pBinary update;
    };
    std::vector<ScalarGV> scalar_global_vars;

    std::vector<pAlloca> local_arrays;

    static ParallelLoopInfo fail() { return {.can_parallel = false}; }
};

// Analyze Loop's Parallel Info
// This function doesn't modify IR, but only collects information.
ParallelLoopInfo analyzeParallelInfo(Function *func, FAM *fam, LoopAAResult *loop_aa, SCEVHandle *scev,
                                     const pLoop &top_level, bool transform_float_reduction) {
    if (top_level->isRotatedForm()) {
        Logger::logDebug("[Para]: Skipped rotated loop '", top_level->getHeader()->getName(), "'.");
        return ParallelLoopInfo::fail();
    }

    if (top_level->getExitingBlocks().size() != 1) {
        Logger::logDebug("[Para]: Skipped loop '", top_level->getHeader()->getName(), "' with multiple exit blocks.");
        return ParallelLoopInfo::fail();
    }

    auto header = top_level->getHeader();
    if (header != *top_level->getExitingBlocks().begin()) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-header exiting block.");
        return ParallelLoopInfo::fail();
    }

    auto exit = *top_level->getExitBlocks().begin();
    Err::gassert(header->getBRInst()->hasDest(exit));

    auto exit_icmp = header->getBRInst()->getCond()->as<ICMPInst>();
    if (!exit_icmp) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-icmp exit condition.");
        return ParallelLoopInfo::fail();
    }
    if (exit_icmp->getCond() != ICMPOP::slt) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-slt exit condition.");
        return ParallelLoopInfo::fail();
    }

    auto raw_iv = exit_icmp->getLHS();
    auto iv_bound = exit_icmp->getRHS();
    if (iv_bound->is<PHIInst>())
        std::swap(raw_iv, iv_bound);

    auto iv = raw_iv->as<PHIInst>();
    if (!iv || iv->getParent() != header || iv_bound->is<PHIInst>()) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with complex icmp exit cond.");
        return ParallelLoopInfo::fail();
    }

    if (auto iv_bound_inst = iv_bound->as<Instruction>()) {
        if (top_level->contains(iv_bound_inst->getParent())) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-loop-invariant iv bound.");
            return ParallelLoopInfo::fail();
        }
    }

    auto iv_scev = scev->getSCEVAtBlock(iv, header);
    auto iv_affine_addrec = iv_scev->getAffineAddRec();
    if (!iv_affine_addrec) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-affine iv.");
        return ParallelLoopInfo::fail();
    }
    auto [iv_scev_base, iv_scev_step] = *iv_affine_addrec;
    if (!iv_scev_step->isIRValue() || !match(iv_scev_step->getIRValue(), M::Is(1))) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-1 step iv.");
        return ParallelLoopInfo::fail();
    }
    if (!iv_scev_base->isIRValue()) {
        // FIXME: Perform SCEV Expansion here.
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-IR base iv. (TODO)");
        return ParallelLoopInfo::fail();
    }
    auto iv_base = iv_scev_base->getIRValue();

    auto trip_count = scev->getTripCount(top_level);
    if (int ci32; trip_count && trip_count->isIRValue() && match(trip_count->getIRValue(), M::Bind(ci32))) {
        if (ci32 < Config::IR::LOOP_PARALLEL_SMALL_TASK_THRESHOLD) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with small trip count (", ci32, ").");
            return ParallelLoopInfo::fail();
        }
    }

    if (hasUsesOutsideLoop(top_level, iv)) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with iv uses outside loop.");
        return ParallelLoopInfo::fail();
    }

    // Ensure Rewritable Reduction
    auto preheader = top_level->getPreHeader();
    auto latch = top_level->getLatch();
    std::vector<ParallelLoopInfo::Reduction> reductions;
    for (const auto &reduction : header->phis()) {
        if (reduction == iv)
            continue;

        if (hasUsesInsideLoop(top_level, reduction)) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with multiple IVs.");
            return ParallelLoopInfo::fail();
        }

        if (reduction->getType()->isFloatingPoint() && !transform_float_reduction) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with float reduction.");
            return ParallelLoopInfo::fail();
        }

        auto reduction_base = reduction->getValueForBlock(preheader);
        if (reduction_base->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-constant reduction base.");
            return ParallelLoopInfo::fail();
        }

        auto reduction_update = reduction->getValueForBlock(latch)->as<Instruction>();
        if (!reduction_update) // Not a Reduction
            continue;
        // For nested loops, the update can be hidden behind multiple phis.
        // FIXME: Enhance SCEV to handle this. Currently we manually analyze the inner loop phis.
        std::unordered_set<pInst> reduction_del;
        pPhi reduction_sub_phi = reduction;
        while (auto phi = reduction_update->as<PHIInst>()) {
            reduction_sub_phi = phi;
            reduction_del.emplace(reduction_update);
            auto preds = phi->getParent()->getPreBB();
            if (preds.size() != 2) {
                Logger::logDebug("[Para]: Skipped loop '", header->getName(),
                                 "' with complex reduction update.(sub loop is not simplified)");
                return ParallelLoopInfo::fail();
            }
            auto v1 = phi->getValueForBlock(preds.front())->as<Instruction>();
            auto v2 = phi->getValueForBlock(preds.back())->as<Instruction>();
            if (reduction == v1)
                reduction_update = v2;
            else if (reduction == v2)
                reduction_update = v1;
            else {
                Logger::logDebug("[Para]: Skipped loop '", header->getName(),
                                 "' with complex reduction update.(unexpected phi)");
                return ParallelLoopInfo::fail();
            }
        }

        pVal inc;
        if (reduction_update->getUseCount() != 1 ||
            !match(reduction_update, M::Add(M::Is(reduction_sub_phi), M::Bind(inc)),
                   M::Add(M::Bind(inc), M::Is(reduction_sub_phi)), M::Fadd(M::Is(reduction_sub_phi), M::Bind(inc)),
                   M::Fadd(M::Bind(inc), M::Is(reduction_sub_phi)))) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with complex reduction update.");
            return ParallelLoopInfo::fail();
        }
        reduction_del.emplace(reduction);
        reduction_del.emplace(reduction_update);
        reductions.emplace_back(ParallelLoopInfo::Reduction{
            .phi = reduction,
            .base = reduction_base,
            .inc = inc,
            .update_point = IRBuilder(reduction_update->getParent(), reduction_update->iter()),
            .to_del = reduction_del});
    }

    // Ensure resolvable data racing in scalar global variables
    // We don't add mutexes for global variables.
    // But try to turn it into an atomic operation.
    std::vector<pStore> scalar_gv_stores;
    for (const auto &block : top_level->blocks()) {
        for (const auto &inst : *block) {
            if (auto store = inst->as<STOREInst>()) {
                if (auto gv = store->getPtr()->as<GlobalVariable>()) {
                    // Arrays will be checked by memory dependency analysis
                    // in isMemoryIndependentForEachIteration.
                    // Besides, they can't be atomic and are always non-resolvable for us.
                    if (!gv->isArray()) {
                        if (getElm(gv->getType())->isI32() || getElm(gv->getType())->isF32()) {
                            scalar_gv_stores.emplace_back(store);
                        }
                    }
                }
            }
        }
    }
    std::vector<ParallelLoopInfo::ScalarGV> scalar_gvs;
    for (const auto &store : scalar_gv_stores) {
        pVal inc;
        if (match(store->getValue(), M::Add(M::Bind(inc), M::Load(M::Is(store->getPtr()))),
                  M::Add(M::Load(M::Is(store->getPtr())), M::Bind(inc)),
                  M::Fadd(M::Bind(inc), M::Load(M::Is(store->getPtr()))),
                  M::Fadd(M::Load(M::Is(store->getPtr())), M::Bind(inc)))) {
            auto binary = store->getValue()->as<BinaryInst>();
            auto load = binary->getLHS()->as<LOADInst>();
            if (!load)
                load = binary->getRHS()->as<LOADInst>();

            Err::gassert(load != nullptr, "Bad update.");
            if (binary->getUseCount() != 1 || load->getUseCount() != 1) {
                Logger::logDebug("[Para]: Skipped loop '", header->getName(),
                                 "' with non-trivial scalar global variable update. (not one use)");
                return ParallelLoopInfo::fail();
            }
            scalar_gvs.emplace_back(ParallelLoopInfo::ScalarGV{.gv = store->getPtr()->as<GlobalVariable>(),
                                                               .inc = inc,
                                                               .load = load,
                                                               .store = store,
                                                               .update = binary});
        } else {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(),
                             "' with non-trivial scalar global variable update. (complex update)");
            return ParallelLoopInfo::fail();
        }
    }

    // Ensure local arrays can be rewritten into global arrays
    std::vector<pAlloca> local_arrays;
    for (const auto &block : top_level->blocks()) {
        for (const auto &inst : *block) {
            if (inst->is<LOADInst, STOREInst>()) {
                auto base = getPtrBase(getMemLocation(inst));
                if (!base) {
                    Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' due to untracked memory access");
                    return ParallelLoopInfo::fail();
                }
                if (base->is<ALLOCAInst>())
                    local_arrays.emplace_back(base->as<ALLOCAInst>());
            }
        }
    }

    if (hasSylibOrRecursiveCall(func, fam, top_level)) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with sylib or recursive call.");
        return ParallelLoopInfo::fail();
    }

    if (!isMemoryIndependentForEachIteration(fam, loop_aa, top_level)) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with memory dependency.");
        return ParallelLoopInfo::fail();
    }

    return {.can_parallel = true,
            .header = header,
            .preheader = preheader,
            .latch = latch,
            .exit = exit,
            .iv = iv,
            .iv_base = iv_base,
            .iv_bound = iv_bound,
            .reductions = std::move(reductions),
            .exit_icmp = exit_icmp,
            .scalar_global_vars = scalar_gvs,
            .local_arrays = local_arrays};
}

PM::PreservedAnalyses LoopParallelPass::run(Function &function, FAM &fam) {
    // Parallel functions can not be nested, so only parallelize loops in `main`.
    if (!function.hasFnAttr(FuncAttr::isProgramEntry))
        return PreserveAll();

    static constexpr auto parallel_for_name = Config::IR::LOOP_PARALLEL_FOR_FUNCTION_NAME;
    static constexpr auto atomic_add_i32_name = Config::IR::LOOP_PARALLEL_ATOMIC_ADD_I32;
    static constexpr auto atomic_add_f32_name = Config::IR::LOOP_PARALLEL_ATOMIC_ADD_F32;
    static constexpr auto gv_prefix = Config::IR::LOOP_PARALLEL_GLOBALVAR_NAME_PREFIX;
    static constexpr auto body_fn_prefix = Config::IR::LOOP_PARALLEL_BODY_FUNCTION_NAME_PREFIX;

    auto &target = fam.getResult<TargetAnalysis>(function);
    if (!target->isIntrinsicSupported(parallel_for_name))
        return PreserveAll();

    auto module = function.getParent();
    auto parallel_for = module->lookupFunction(parallel_for_name);
    auto atomic_add_i32 = module->lookupFunction(atomic_add_i32_name);
    auto atomic_add_f32 = module->lookupFunction(atomic_add_f32_name);

    bool loop_parallel_inst_modified = false;
    bool loop_parallel_cfg_modified = false;

    // Compute the reverse post order, this can let the
    // block layout in body function be more reasonable.
    auto bbrpodfv = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    std::map<pBlock, size_t> rpo_index;
    for (size_t i = 0; i < bbrpodfv.size(); ++i)
        rpo_index[bbrpodfv[i]] = i;

    // Fold PHI first
    for (const auto &block : function.getBlocks()) {
        if (foldPHI(block->as<BasicBlock>())) {
            fam.invalidate(function, PreserveCFGAnalyses());
            loop_parallel_inst_modified = true;
        }
    }

    auto &loop_info = fam.getResult<LoopAnalysis>(function);
    auto &scev = fam.getResult<SCEVAnalysis>(function);
    auto &loop_aa = fam.getResult<LoopAliasAnalysis>(function);

    // Only parallel top-level loops
    // Top-level loops are disjoint, so iterating it directly is fine.
    for (const auto &top_level : loop_info) {
        Err::gassert(top_level->isSimplifyForm(), "Expected LoopSimplifiedForm.");

        auto info = analyzeParallelInfo(&function, &fam, &loop_aa, &scev, top_level, transform_float_reduction);
        auto [can_parallel, header, preheader, latch, exit, iv, iv_base, iv_bound, reductions, exit_icmp,
              scalar_global_vars, local_arrays] = info;
        if (!can_parallel)
            continue;

        // Rewrite Reduction into global variables
        for (auto &[reduction, reduction_base, reduction_inc, update_point, tmps] : reductions) {
            static int global_var_id = 0;
            auto gv_name = gv_prefix + std::string{".reduction."} + reduction->getName().substr(1) + "." +
                           std::to_string(global_var_id++);
            auto global_var = std::make_shared<GlobalVariable>(STOCLASS::GLOBAL, reduction_base->getType(), gv_name,
                                                               GVIniter(reduction_base->getType(), reduction_base));
            module->addGlobalVar(global_var);
            pLoad exit_value;
            auto use_list = reduction->getUseList();
            for (const auto &use : use_list) {
                if (tmps.count(use->getUser()->as<Instruction>()))
                    continue;

                auto user = use->getUser()->as<Instruction>();
                auto user_block = user->getParent();

                if (!top_level->contains(user_block)) {
                    // We've folded all LCSSA phi, so just place the load in the exit block.
                    if (!exit_value) {
                        exit_value =
                            std::make_shared<LOADInst>("%para.reduction.exit" + reduction->getName(), global_var);
                        exit->addInstAfterPhi(exit_value);
                    }
                    use->setValue(exit_value);
                } else {
                    auto ld = std::make_shared<LOADInst>("%para.reduction.loop" + reduction->getName(), global_var);
                    user_block->addInst(user->iter(), ld);
                    use->setValue(ld);
                }
            }

            auto atomic_fn = reduction_inc->getType()->isI32() ? atomic_add_i32 : atomic_add_f32;
            update_point.makeCall(atomic_fn, {global_var, reduction_inc});

            Err::gassert(reduction->getParent() == header);
            // Clear the temporary immediately since we're going to rewrite the uses
            // of outside loop values.
            for (const auto &utmp : tmps) {
                if (auto phi = utmp->as<PHIInst>())
                    utmp->getParent()->delFirstOfPhiInst(phi);
                else
                    utmp->getParent()->delFirstOfInst(utmp);
            }
            tmps.clear();

            Logger::logDebug("[Para]: Rewritten reduction '", reduction->getName(), "' into Global Variable '",
                             global_var->getName(), "'.");
        }

        // Rewrite local arrays to global arrays
        for (const auto &alloc : local_arrays) {
            static int global_var_id = 0;
            auto gv_name =
                gv_prefix + std::string{".array."} + alloc->getName().substr(1) + "." + std::to_string(global_var_id++);
            auto global_var = std::make_shared<GlobalVariable>(STOCLASS::GLOBAL, alloc->getBaseType(), gv_name,
                                                               GVIniter(alloc->getBaseType()), alloc->getAlign());
            module->addGlobalVar(global_var);
            alloc->replaceSelf(global_var);
            auto entry = function.getBlocks().front();
            entry->delFirstOfInst(alloc);

            Logger::logDebug("[Para]: Rewritten local array '", alloc->getName(), "' into Global Array '",
                             global_var->getName(), "'.");
        }
        local_arrays.clear();

        // Extract the loop to a new function
        size_t body_fn_name_cnt = 0;
        auto body_fn_name = body_fn_prefix + std::string{"."} + function.getName().substr(1) + "." +
                            top_level->getHeader()->getName().substr(1) + "." + std::to_string(body_fn_name_cnt++);
        // using Task = void (*)(int32_t beg, int32_t end);
        auto beg_param = std::make_shared<FormalParam>("%gnalc_parallel_body_fn_beg", makeBType(IRBTYPE::I32), 0);
        auto end_param = std::make_shared<FormalParam>("%gnalc_parallel_body_fn_end", makeBType(IRBTYPE::I32), 1);
        auto body_fn = std::make_shared<Function>(body_fn_name, std::vector{beg_param, end_param},
                                                  makeBType(IRBTYPE::VOID), &function.getConstantPool(),
                                                  FuncAttr::NotBuiltin | FuncAttr::ParallelBody);
        module->addFunction(body_fn);

        // Collect all shared values and rewrite them as global variables.
        // We call the shared values as arguments for convenience, since they should be passed as
        // function arguments if we have a more flexible parallelization method.

        // Arguments are transformed into global variables
        std::unordered_map<pVal, pGlobalVar> shared_arg_gv_map;
        // Simple optimization when the shared arguments is
        // a pointer to a global variable with constant offset.
        // See comments below.
        std::unordered_map<pVal, std::tuple<pGlobalVar, size_t>> shared_arg_gv_ptr_map;
        for (const auto &block : top_level->blocks()) {
            for (const auto &inst : block->all_insts()) {
                // Skip iv and exit_icmp, their uses will be rewritten manually afterward.
                if (inst == iv || inst == exit_icmp)
                    continue;

                // Skip rewritten Reduction
                // Note that not all phis are Reduction, this is only a quick path for
                // most common cases, since Reduction need rewritten must be a phi in the header.
                if (block == header.get() && inst->is<PHIInst>()) {
                    auto it = std::find_if(reductions.begin(), reductions.end(),
                                           [&](const auto &val) { return val.phi == inst; });
                    if (it != reductions.end())
                        continue;
                }

                for (auto operand : inst->operands()) {
                    // Skip operands that are still available
                    // even when the loop is moved the body function
                    switch (operand->getVTrait()) {
                    case ValueTrait::GLOBAL_VARIABLE:
                    case ValueTrait::CONSTANT_LITERAL:
                    case ValueTrait::FUNCTION:
                    case ValueTrait::BASIC_BLOCK:
                        continue;
                    default:
                        break;
                    }

                    // For constant offsets pointer to (like gep 0, 0) from global variables,
                    // just gep + bitcast them in body function instead of using load/store from another
                    // temporary global var.
                    if (operand->getType()->is<PtrType>()) {
                        if (auto opt = loop_aa.getBaseAndOffset(operand)) {
                            auto [base, offset] = *opt;
                            if (auto base_gv = base->as<GlobalVariable>()) {
                                shared_arg_gv_ptr_map[operand] = { base_gv, offset };
                                continue;
                            }
                        }
                    }

                    // Skip processed operands
                    if (shared_arg_gv_map.count(operand))
                        continue;

                    if (auto operand_inst = operand->as<Instruction>()) {
                        if (top_level->contains(operand_inst->getParent()))
                            continue;
                        // Since we've rewritten some Reductions before, some instructions
                        // might become dead, so uses in them might be invalid.
                        if (operand_inst->getParent() == nullptr) {
                            Logger::logDebug("[Para]: Still has temporary holding the uses for '",
                                             operand_inst->getName(), "'?");
                            continue;
                        }
                    }

                    Err::gassert(operand->is<Instruction, FormalParam>(), "Unexpected operand type.");

                    // Now we got one, turn it into a global variable.
                    static size_t global_var_id = 0;
                    auto gv_name = gv_prefix + std::string{".arg."} + function.getName().substr(1) + "." +
                                   operand->getName().substr(1) + "." + std::to_string(global_var_id++);
                    auto gv = std::make_shared<GlobalVariable>(STOCLASS::GLOBAL, operand->getType(), gv_name,
                                                               GVIniter(operand->getType()));
                    module->addGlobalVar(gv);
                    shared_arg_gv_map[operand] = gv;

                    Logger::logDebug("[Para]: Stored argument '", operand->getName(), "' to global variable '", gv_name,
                                     "'");
                }
            }
        }

        // Rewrite iv_base and iv_bound
        auto ok = iv->replaceAllOperands(iv_base, beg_param);
        Err::gassert(ok == 1);
        ok = exit_icmp->replaceAllOperands(iv_bound, end_param);
        Err::gassert(ok == 1);

        // Setup CFG in original function
        ok = preheader->getBRInst()->replaceAllOperands(header, exit);
        Err::gassert(ok == 1 && !preheader->getBRInst()->isConditional(), "Bad CFG");
        // Fix exit's phis
        for (const auto &phi : exit->phis())
            phi->replaceAllOperands(header, preheader);

        IRBuilder ph_builder(preheader, preheader->getEndInsertPoint());
        // Store arguments
        for (const auto &[arg_inst, gv] : shared_arg_gv_map)
            (void)ph_builder.makeStore(arg_inst, gv);
        // Call the parallel for with the body function
        ph_builder.makeCall(parallel_for, std::vector<pVal>{iv_base, iv_bound, body_fn});

        // Setup CFG in the body function
        auto body_entry = std::make_shared<BasicBlock>("%parallel.entry");

        // Load arguments in entry and rewrite uses of them
        IRBuilder para_builder(body_entry);
        for (const auto &[arg_inst, gv] : shared_arg_gv_map) {
            auto ld = para_builder.makeLoad(gv);
            ld->appendDbgData("from=" + arg_inst->getName());
            rewriteSelfUsesInLoop(top_level, arg_inst, ld);
        }

        // Rewrite uses of pointers to global variables
        for (const auto &[arg_inst, gvoffset] : shared_arg_gv_ptr_map) {
            const auto& [gv, offset] = gvoffset;
            auto dest_ty = arg_inst->getType();
            pVal ptr = gv;
            if (offset != 0) {
                if (offset % gv->getVarType()->getBytes() != 0) {
                    auto i8ptr = para_builder.makeBitcast(gv, makePtrType(makeBType(IRBTYPE::I8)));
                    auto ptradd = para_builder.makeGep(i8ptr, function.getConst(static_cast<int>(offset)));
                    ptr = para_builder.makeBitcast(ptradd, dest_ty);
                }
                else {
                    ptr = para_builder.makeGep(gv, function.getConst(static_cast<int>(offset / gv->getVarType()->getBytes())));
                }
            }
            if (!isSameType(ptr, arg_inst))
                ptr = para_builder.makeBitcast(ptr, arg_inst->getType());
            rewriteSelfUsesInLoop(top_level, arg_inst, ptr);
        }

        // Move blocks
        std::vector<pBlock> blocks_to_move;
        for (const auto &block : top_level->blocks())
            blocks_to_move.emplace_back(block->as<BasicBlock>());
        std::sort(blocks_to_move.begin(), blocks_to_move.end(),
                  [&](const pBlock &a, const pBlock &b) { return rpo_index[a] < rpo_index[b]; });
        for (const auto &block : blocks_to_move)
            moveBlock(block, body_fn);

        Err::gassert(header->getParent() == body_fn, "Bad CFG");
        body_entry->addInst(std::make_shared<BRInst>(header));

        // Fix header's phis
        for (const auto &phi : header->phis())
            phi->replaceAllOperands(preheader, body_entry);

        auto body_ret = std::make_shared<BasicBlock>("%parallel.exit");
        ok = header->getBRInst()->replaceAllOperands(exit, body_ret);
        Err::gassert(ok == 1, "Bad CFG");
        body_ret->addInst(std::make_shared<RETInst>());

        body_fn->addBlockAsEntry(body_entry);
        body_fn->addBlock(body_ret);

        function.updateCFG();
        body_fn->updateCFG();

        // At this point, we've successfully extracted the loop and fixed up the control flow.
        // Now fix data racing. Data racing can happen when a global variable is written in the loop
        // Currently we don't add mutexes for global variables. But try to turn it into an
        // atomic operation.
        for (const auto &[gv, inc, load, store, update] : scalar_global_vars) {
            Err::gassert(transform_float_reduction || inc->getType()->isI32(), "Bad analyzeParallelInfo.");
            auto atomic_fn = inc->getType()->isI32() ? atomic_add_i32 : atomic_add_f32;
            auto atomic_add = std::make_shared<CALLInst>(atomic_fn, std::vector<pVal>{gv, inc});

            auto block = store->getParent();
            block->addInst(store->iter(), atomic_add);
            block->delFirstOfInst(store);
            block->delFirstOfInst(load);
            block->delFirstOfInst(update);
        }

        Logger::logDebug("[Para]: Parallelized loop '", header->getName(), "' to '", body_fn->getName(), "'.");

        if (parallel_debug_message) {
            std::cerr << "Body function: \n";
            IRPrinter printer(std::cerr, true);
            body_fn->accept(printer);
            std::cerr << std::flush;
        }

        loop_parallel_cfg_modified = true;
    }

    if (loop_parallel_cfg_modified)
        return PreserveNone();

    if (loop_parallel_inst_modified)
        return PreserveCFGAnalyses();

    return PreserveAll();
}
} // namespace IR