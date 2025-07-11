// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/loop_parallel.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/irbuilder.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "ir/passes/analysis/target_analysis.hpp"
#include "match/match.hpp"

#include <vector>

using namespace Match;

namespace IR {
bool isMemoryIndependentForEachIteration(const pLoop &loop) {
    // TODO
    return true;
}
bool hasSylibOrRecursiveCall(Function *func, FAM *fam, const pLoop &loop) {
    for (const auto &block : loop->blocks()) {
        for (const auto &inst : *block) {
            if (auto call = inst->as<CALLInst>()) {
                if (call->getFunc().get() == func)
                    return true;

                if (call->getFunc()->hasAttr(FuncAttr::isSylib))
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
    struct GIV {
        pPhi giv;
        pVal base;
        pBinary update;
        pVal inc;
    };
    std::vector<GIV> givs;
    pIcmp exit_icmp;
    struct ScalarGV {
        pGlobalVar gv;
        pVal inc;
        pLoad load;
        pStore store;
        pBinary update;
    };
    std::vector<ScalarGV> scalar_global_vars;

    static ParallelLoopInfo fail() { return {.can_parallel = false}; }
};
ParallelLoopInfo analyzeParallelInfo(Function *func, FAM *fam, SCEVHandle *scev, const pLoop &top_level) {
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

    // Ensure Rewritable GIV
    auto preheader = top_level->getPreHeader();
    auto latch = top_level->getLatch();
    std::vector<ParallelLoopInfo::GIV> givs;
    for (const auto &giv : header->phis()) {
        if (giv == iv)
            continue;

        if (!hasUsesOutsideLoop(top_level, giv))
            continue;

        auto giv_base = giv->getValueForBlock(preheader);
        auto giv_update = giv->getValueForBlock(latch)->as<Instruction>();

        if (!giv_update) // Not a GIV
            continue;

        if (giv_base->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with non-constant giv base.");
            return ParallelLoopInfo::fail();
        }

        pVal inc;
        if (giv_update->getUseCount() != 1 ||
            !match(giv_update, M::Add(M::Is(giv), M::Bind(inc)), M::Add(M::Bind(inc), M::Is(giv)),
                   M::Fadd(M::Is(giv), M::Bind(inc)), M::Fadd(M::Bind(inc), M::Is(giv)))) {
            Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with complex giv update.");
            return ParallelLoopInfo::fail();
        }
        givs.emplace_back(
            ParallelLoopInfo::GIV{.giv = giv, .base = giv_base, .update = giv_update->as<BinaryInst>(), .inc = inc});
    }

    // Ensure resolvable data racing in scalar global variables
    // We don't add mutexes for global variables.
    // But try to turn it into an atomic operation.
    std::vector<pStore> scalar_gv_stores;
    for (const auto &block : top_level->blocks()) {
        for (const auto &inst : *block) {
            if (auto store = inst->as<STOREInst>()) {
                if (auto gv = store->getPtr()->as<GlobalVariable>()) {
                    // Arrays has been guaranteed by memory
                    // dependency analysis in isMemoryIndependentForEachIteration.
                    // Besides, they can't be atomic and is non-resolveable for us.
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

    if (hasSylibOrRecursiveCall(func, fam, top_level)) {
        Logger::logDebug("[Para]: Skipped loop '", header->getName(), "' with sylib or recursive call.");
        return ParallelLoopInfo::fail();
    }

    if (!isMemoryIndependentForEachIteration(top_level)) {
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
            .givs = std::move(givs),
            .exit_icmp = exit_icmp,
            .scalar_global_vars = scalar_gvs};
}

PM::PreservedAnalyses LoopParallelPass::run(Function &function, FAM &fam) {
    // Parallel functions can not be nested, so only parallelize loops in `main`.
    if (!function.hasAttr(FuncAttr::isProgramEntry))
        return PreserveAll();

    static constexpr auto parallel_for_name = Config::IR::LOOP_PARALLEL_FOR_FUNCTION_NAME;
    static constexpr auto atomic_add_i32_name = Config::IR::LOOP_PARALLEL_ATOMIC_ADD_I32;
    static constexpr auto atomic_add_f32_name = Config::IR::LOOP_PARALLEL_ATOMIC_ADD_F32;
    static constexpr auto gv_prefix = Config::IR::LOOP_PARALLEL_GLOBALVAR_NAME_PREFIX;
    static constexpr auto body_fn_prefix = Config::IR::LOOP_PARALLEL_BODY_FUNCTION_NAME_PREFIX;

    auto &target = fam.getResult<TargetAnalysis>(function);
    if (!target->isLibCallSupported(parallel_for_name))
        return PreserveAll();

    auto module = function.getParent();
    auto parallel_for = module->lookupFunction(parallel_for_name);
    auto atomic_add_i32 = module->lookupFunction(atomic_add_i32_name);
    auto atomic_add_f32 = module->lookupFunction(atomic_add_f32_name);

    bool loop_parallel_inst_modified = false;
    bool loop_parallel_cfg_modified = false;

    auto &scev = fam.getResult<SCEVAnalysis>(function);
    auto &loop_info = fam.getResult<LoopAnalysis>(function);

    // Fold PHI first
    for (const auto &block : function.getBlocks())
        loop_parallel_inst_modified |= foldPHI(block->as<BasicBlock>());

    // Only parallel top-level loops
    // Top-level loops are disjoint, so iterating it directly is fine.
    for (const auto &top_level : loop_info) {
        Err::gassert(top_level->isSimplifyForm(), "Expected LoopSimplifiedForm.");

        auto info = analyzeParallelInfo(&function, &fam, &scev, top_level);
        auto [can_parallel, header, preheader, latch, exit, iv, iv_base, iv_bound, givs, exit_icmp,
              scalar_global_vars] = info;
        if (!can_parallel)
            continue;

        // Rewrite GIV into global variables
        for (const auto &[giv, giv_base, giv_update, giv_inc] : givs) {
            auto global_var = std::make_shared<GlobalVariable>(
                STOCLASS::GLOBAL, giv_base->getType(), gv_prefix + std::string{".giv."} + giv->getName().substr(1),
                GVIniter(giv_base->getType(), giv_base));
            module->addGlobalVar(global_var);
            pLoad loop_value;
            pLoad exit_value;
            auto use_list = giv->getUseList();
            for (const auto &use : use_list) {
                if (use->getUser() == giv_update)
                    continue;

                auto user = use->getUser()->as<Instruction>();
                auto user_block = user->getParent();

                if (!top_level->contains(user_block)) {
                    // We've folded all LCSSA phi, so just place the load in the exit block.
                    if (!exit_value) {
                        exit_value = std::make_shared<LOADInst>("%para.giv.exit" + giv->getName(), global_var);
                        exit->addInstAfterPhi(exit_value);
                    }
                    use->setValue(exit_value);
                } else {
                    if (!loop_value) {
                        loop_value = std::make_shared<LOADInst>("%para.giv.loop" + giv->getName(), global_var);
                        header->addInstAfterPhi(loop_value);
                    }
                    use->setValue(loop_value);
                }
            }

            auto atomic_fn = giv_inc->getType()->isI32() ? atomic_add_i32 : atomic_add_f32;
            latch->addInstBeforeTerminator(
                std::make_shared<CALLInst>(atomic_fn, std::vector<pVal>{global_var, giv_inc}));

            Err::gassert(giv->getParent() == header);
            header->delFirstOfPhiInst(giv);
            giv_update->getParent()->delFirstOfInst(giv_update);
        }

        // Instruction that has uses after loop must be available
        // in the exiting blocks (at this point the only exiting block is the header),
        // since we have dedicated exits.
        // Find all of them and rewrite them to global variables.
        for (const auto &inst : header->phis()) {
            for (const auto &use : inst->self_uses()) {
                auto user_block = use->getUser()->as<Instruction>()->getParent();
                if (top_level->contains(user_block))
                    continue;
            }
        }

        // Extract the loop to a new function
        size_t body_fn_name_cnt = 0;
        auto body_fn_name = body_fn_prefix + std::string{"."} + function.getName().substr(1) + "." +
                            top_level->getHeader()->getName().substr(1) + "." + std::to_string(body_fn_name_cnt++);
        // using Task = void (*)(int32_t beg, int32_t end);
        auto beg_param = std::make_shared<FormalParam>("%gnalc_parallel_body_fn_beg", makeBType(IRBTYPE::I32), 0);
        auto end_param = std::make_shared<FormalParam>("%gnalc_parallel_body_fn_end", makeBType(IRBTYPE::I32), 1);
        auto body_fn = std::make_shared<Function>(body_fn_name, std::vector{beg_param, end_param},
                                                  makeBType(IRBTYPE::VOID), &function.getConstantPool(),
                                                  std::unordered_set{FuncAttr::NotBuiltin, FuncAttr::ParallelBody});
        module->addFunction(body_fn);

        // Collect all arguments
        std::unordered_map<pVal, pGlobalVar> shared_arg_gv_map;
        for (const auto &block : top_level->blocks()) {
            for (const auto &inst : block->all_insts()) {
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

                    // Skip processed operands
                    if (shared_arg_gv_map.count(operand))
                        continue;

                    // Skip iv base, bound and iv, they'll be replaced with FormalParams
                    if (operand == iv_base || operand == iv_bound || operand->is<PHIInst>())
                        continue;

                    if (auto operand_inst = operand->as<Instruction>()) {
                        if (top_level->contains(operand_inst->getParent()))
                            continue;
                    }

                    Err::gassert(operand->is<Instruction, FormalParam>(), "Unexpected operand type.");

                    // Now we got one, turn it into a global variable.
                    static size_t arg_name_cnt = 0;
                    auto gv_name = gv_prefix + std::string{".arg."} + function.getName().substr(1) + "." +
                                   operand->getName().substr(1) + "." + std::to_string(arg_name_cnt++);
                    auto gv = std::make_shared<GlobalVariable>(STOCLASS::GLOBAL, operand->getType(), gv_name,
                                                               GVIniter(operand->getType()));
                    module->addGlobalVar(gv);
                    shared_arg_gv_map[operand] = gv;
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
        IRBuilder parallel_entry_builder(body_entry);
        for (const auto &[arg_inst, gv] : shared_arg_gv_map) {
            auto ld = parallel_entry_builder.makeLoad(gv);
            ld->appendDbgData("from=" + arg_inst->getName());
            rewriteSelfUsesInLoop(top_level, arg_inst, ld);
        }

        // Move blocks
        for (const auto &block : top_level->blocks())
            moveBlock(block->as<BasicBlock>(), body_fn);

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
            auto atomic_fn = inc->getType()->isI32() ? atomic_add_i32 : atomic_add_f32;
            auto atomic_add = std::make_shared<CALLInst>(atomic_fn, std::vector<pVal>{gv, inc});

            auto block = store->getParent();
            block->addInst(store->iter(), atomic_add);
            block->delFirstOfInst(store);
            block->delFirstOfInst(load);
            block->delFirstOfInst(update);
        }

        Logger::logDebug("[Para]: Parallelized loop '", header->getName(), "' to '", body_fn->getName(), "'.");
        loop_parallel_cfg_modified = true;
    }

    if (loop_parallel_cfg_modified)
        return PreserveNone();

    if (loop_parallel_inst_modified)
        return PreserveCFGAnalyses();

    return PreserveAll();
}
} // namespace IR