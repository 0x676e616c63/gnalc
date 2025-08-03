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
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "ir/passes/analysis/target_analysis.hpp"
#include "ir/passes/utilities/irprinter.hpp"
#include "match/match.hpp"
#include "sir/passes/transforms/loop_annotator.hpp"

#include <vector>

using namespace Match;

namespace IR {
bool isMemoryIndependentForEachIteration(FAM *fam, LoopAAResult *loop_aa, const pLoop &loop) {
    // See if SIR has prepared this for us
    if (auto loop_attrs = loop->getHeader()->attr().get<SIR::LoopAttrs>()) {
        if (loop_attrs && loop_attrs->has(SIR::LoopAttr::NoCarriedDependency))
            return true;
    }

    // Fallback analysis
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
        auto rp = loop_aa->getBase(load->getPtr());
        for (const auto &store : stores) {
            auto wp = loop_aa->getBase(store->getPtr());
            if (rp == wp) {
                Logger::logDebug("[Para]: Find dependency between '", load->getName(), "' and '", store->getName(),
                                 "'.");
                return false;
            }
        }
    }

    for (const auto &store1 : stores) {
        auto wp1 = loop_aa->getBase(store1->getPtr());
        for (const auto &store2 : stores) {
            if (store1 == store2)
                continue;
            auto wp2 = loop_aa->getBase(store2->getPtr());
            if (wp1 == wp2) {
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

                if (call->getFunc()->hasFnAttr(FuncAttr::Sylib))
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
    bool is_signed_less_equal_cond;
    struct Reduction {
        pPhi phi;
        pVal base;
        pVal inc;
        pVal mod;
        IRBuilder update_point;
        IntrinsicID atomic_fn;
        std::unordered_set<pInst> update_insts;
    };
    std::vector<Reduction> reductions;
    pIcmp exit_icmp;
    struct ScalarGV {
        pGlobalVar gv;
        pVal inc;
        pLoad load;
        pStore store;
        pBinary update;
        IntrinsicID atomic_fn;
    };
    std::vector<ScalarGV> scalar_global_vars;

    std::vector<pAlloca> local_arrays;

    static ParallelLoopInfo fail() { return {.can_parallel = false}; }
};

const std::unordered_map<OP, IntrinsicID> AssociativeOps = {
    {OP::ADD, IntrinsicID::AtomicAdd},   {OP::MUL, IntrinsicID::AtomicMul}, {OP::AND, IntrinsicID::AtomicAnd},
    {OP::OR, IntrinsicID::AtomicOr},     {OP::XOR, IntrinsicID::AtomicXor}, {OP::FADD, IntrinsicID::AtomicFAdd},
    {OP::FMUL, IntrinsicID::AtomicFMul},
};

#define FAIL_IF(cond)                                                                                                  \
    if (cond)                                                                                                          \
        return ParallelLoopInfo::fail();
#define FAIL_IF_MSG(cond, ...)                                                                                         \
    if (cond) {                                                                                                        \
        Logger::logDebug("[Para]: ", __VA_ARGS__);                                                                     \
        return ParallelLoopInfo::fail();                                                                               \
    }

// Analyze Loop's Parallel Info
// This function doesn't modify IR, but only collects information.
ParallelLoopInfo analyzeParallelInfo(Function *func, FAM *fam, LoopAAResult *loop_aa, SCEVHandle *scev,
                                     const pTarget &target, const pLoop &top_level, bool transform_float_reduction) {
    auto header = top_level->getHeader();

    FAIL_IF(!top_level->hasSingleExit() || !top_level->isHeaderExiting());

    auto exit = *top_level->getExitBlocks().begin();
    Err::gassert(header->getBRInst()->hasDest(exit));

    auto exit_icmp = header->getBRInst()->getCond()->as<ICMPInst>();
    FAIL_IF(!exit_icmp || (exit_icmp->getCond() != ICMPOP::slt && exit_icmp->getCond() != ICMPOP::sle));

    auto cond = exit_icmp->getCond();

    auto raw_iv = exit_icmp->getLHS();
    auto iv_bound = exit_icmp->getRHS();
    if (iv_bound->is<PHIInst>())
        std::swap(raw_iv, iv_bound);

    auto iv = raw_iv->as<PHIInst>();
    if (!iv || iv->getParent() != header || iv_bound->is<PHIInst>())
        return ParallelLoopInfo::fail();

    if (auto iv_bound_inst = iv_bound->as<Instruction>()) {
        FAIL_IF_MSG(top_level->contains(iv_bound_inst->getParent()), "Skipped loop '", header->getName(),
                    "' with non-parallelizable iv bound.");
    }

    auto iv_scev = scev->getSCEVAtBlock(iv, header);
    auto iv_affine_addrec = iv_scev->getAffineAddRec();
    FAIL_IF(!iv_affine_addrec);
    auto [iv_scev_base, iv_scev_step] = *iv_affine_addrec;
    FAIL_IF(!iv_scev_step->isIRValue() || !match(iv_scev_step->getIRValue(), M::IsIntegerVal(1)));
    // FIXME: Try perform SCEV Expansion here to get the base.
    FAIL_IF_MSG(!iv_scev_base->isIRValue(), "Skipped loop '", header->getName(), "' with non-IR base iv. (TODO)");

    auto iv_base = iv_scev_base->getIRValue();
    auto trip_count = scev->getTripCount(top_level);
    if (int ci32; trip_count && trip_count->isIRValue() && match(trip_count->getIRValue(), M::Bind(ci32))) {
        FAIL_IF_MSG(ci32 < Config::IR::LOOP_PARALLEL_SMALL_TASK_THRESHOLD, "Skipped loop '", header->getName(),
                    "' with small trip count (", ci32, ").");
    }

    // Ensure Rewritable Reduction
    auto preheader = top_level->getPreHeader();
    auto latch = top_level->getLatch();
    std::vector<ParallelLoopInfo::Reduction> reductions;
    for (const auto &reduction : header->phis()) {
        if (reduction == iv)
            continue;

        FAIL_IF(reduction->getType()->isFloatingPoint() && !transform_float_reduction);

        auto reduction_base = reduction->getValueForBlock(preheader);
        auto reduction_update = reduction->getValueForBlock(latch)->as<Instruction>();
        if (!reduction_update) // Not a Reduction
            continue;

        // For nested loops, the update can be hidden behind multiple phis.
        std::unordered_set<pInst> reduction_updates;
        pPhi reduction_sub_phi = reduction;
        while (auto phi = reduction_update->as<PHIInst>()) {
            reduction_sub_phi = phi;
            reduction_updates.emplace(reduction_update);
            auto preds = phi->getParent()->getPreBB();
            FAIL_IF_MSG(preds.size() != 2, "Not LoopSimplified Form?");
            auto v1 = phi->getValueForBlock(preds.front())->as<Instruction>();
            auto v2 = phi->getValueForBlock(preds.back())->as<Instruction>();
            if (reduction == v1)
                reduction_update = v2;
            else if (reduction == v2)
                reduction_update = v1;
            else
                FAIL_IF(true);
        }
        FAIL_IF(reduction_update->getUseCount() != 1);

        // For common reduction variables, make them atomics to avoid race conditions.
        pVal inc, mod;
        OP op;
        if (auto bin = reduction_update->as<BinaryInst>()) {
            reduction_updates.emplace(bin);
            if (bin->getOpcode() == OP::SREM) {
                mod = bin->getRHS();
                bin = bin->getLHS()->as<BinaryInst>();
                FAIL_IF(!bin || bin->getOpcode() != OP::ADD);
                reduction_updates.emplace(bin);
            }
            op = bin->getOpcode();

            FAIL_IF_MSG(!AssociativeOps.count(op), "Skipped loop '", header->getName(),
                        "' with unparallelizable reduction variable. (non-associative op)");

            FAIL_IF_MSG(!target->isIntrinsicSupported(AssociativeOps.at(op)), "Skipped loop '", header->getName(),
                        "' with target-unsupported reduction intrinsic.");

            if (bin->getLHS() == reduction_sub_phi)
                inc = bin->getRHS();
            else if (bin->getRHS() == reduction_sub_phi)
                inc = bin->getLHS();
            else
                FAIL_IF(true);
        } else
            FAIL_IF_MSG(true, "Skipped loop '", header->getName(), "' with unparallelizable reduction variable. (non-binary)");

        for (const auto &inst_user : reduction->inst_users()) {
            FAIL_IF_MSG(top_level->contains(inst_user->getParent()) && !reduction_updates.count(inst_user),
                        "Skipped loop '", header->getName(), "' with multiple IVs.");
        }

        reduction_updates.emplace(reduction);
        reduction_updates.emplace(reduction_update);
        reductions.emplace_back(ParallelLoopInfo::Reduction{
            .phi = reduction,
            .base = reduction_base,
            .inc = inc,
            .mod = mod,
            .update_point = IRBuilder(reduction_update->getParent(), reduction_update->iter()),
            .atomic_fn = AssociativeOps.at(op),
            .update_insts = reduction_updates});
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
        pLoad load;
        OP op;
        if (auto bin = store->getValue()->as<BinaryInst>()) {
            op = bin->getOpcode();

            FAIL_IF_MSG(!AssociativeOps.count(op), "Skipped loop '", header->getName(),
                        "' with unparallelizable scalar global variable.(non-associative op)");

            FAIL_IF_MSG(!target->isIntrinsicSupported(AssociativeOps.at(op)), "Skipped loop '", header->getName(),
                        "' with target-unsupported scalar global variable reduction intrinsic.");

            if (match(bin->getLHS(), M::Load(M::Is(store->getPtr())))) {
                inc = bin->getRHS();
                load = bin->getLHS()->as<LOADInst>();
            } else if (match(bin->getRHS(), M::Load(M::Is(store->getPtr())))) {
                inc = bin->getLHS();
                load = bin->getRHS()->as<LOADInst>();
            } else
                FAIL_IF(true);
        } else
            FAIL_IF_MSG(true, "Skipped loop '", header->getName(), "' with unparallelizable scalar global variable.(non-binary)");

        scalar_gvs.emplace_back(ParallelLoopInfo::ScalarGV{.gv = store->getPtr()->as<GlobalVariable>(),
                                                           .inc = inc,
                                                           .load = load,
                                                           .store = store,
                                                           .update = store->getValue()->as<BinaryInst>(),
                                                           .atomic_fn = AssociativeOps.at(op)});
    }

    // Ensure local arrays can be rewritten into global arrays
    std::vector<pAlloca> local_arrays;
    std::unordered_set<pVal> inserted;
    for (const auto &block : top_level->blocks()) {
        for (const auto &inst : *block) {
            if (inst->is<LOADInst, STOREInst>()) {
                auto base = getPtrBase(getMemLocation(inst));
                FAIL_IF(!base);
                if (inserted.count(base))
                    continue;
                if (base->is<ALLOCAInst>()) {
                    local_arrays.emplace_back(base->as<ALLOCAInst>());
                    inserted.emplace(base);
                }
            }
        }
    }

    FAIL_IF(hasSylibOrRecursiveCall(func, fam, top_level));

    FAIL_IF_MSG(!isMemoryIndependentForEachIteration(fam, loop_aa, top_level), "Skipped loop '", header->getName(),
                "' with memory dependency.");

    return {.can_parallel = true,
            .header = header,
            .preheader = preheader,
            .latch = latch,
            .exit = exit,
            .iv = iv,
            .iv_base = iv_base,
            .iv_bound = iv_bound,
            .is_signed_less_equal_cond = cond == ICMPOP::sle,
            .reductions = std::move(reductions),
            .exit_icmp = exit_icmp,
            .scalar_global_vars = scalar_gvs,
            .local_arrays = local_arrays};
}

PM::PreservedAnalyses LoopParallelPass::run(Function &function, FAM &fam) {
    // Parallel functions can not be nested, so only parallelize loops in `main`.
    if (!function.hasFnAttr(FuncAttr::ProgramEntry))
        return PreserveAll();

    static constexpr auto gv_prefix = Config::IR::LOOP_PARALLEL_GLOBALVAR_NAME_PREFIX;
    static constexpr auto body_fn_prefix = Config::IR::LOOP_PARALLEL_BODY_FUNCTION_NAME_PREFIX;

    auto target = fam.getResult<TargetAnalysis>(function);
    if (!target->isIntrinsicSupported(IntrinsicID::ParallelForEntry))
        return PreserveAll();

    auto module = function.getParent();
    auto parallel_for = module->lookupIntrinsic(IntrinsicID::ParallelForEntry);

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

        auto info = analyzeParallelInfo(&function, &fam, &loop_aa, &scev, target, top_level, transform_float_reduction);
        auto [can_parallel, header, preheader, latch, exit, iv, iv_base, iv_bound, is_signed_less_equal_cond,
              reductions, exit_icmp, scalar_global_vars, local_arrays] = info;
        if (!can_parallel)
            continue;

        auto body_ret = std::make_shared<BasicBlock>("%parallel.exit");

        // Rewrite Reduction into global variables
        for (auto &[reduction, reduction_base, reduction_inc, reduction_mod, update_point, atomic_fn, upd_insts] :
             reductions) {
            static int global_var_id = 0;
            auto gv_name = gv_prefix + std::string{".reduction."} + reduction->getName().substr(1) + "." +
                           std::to_string(global_var_id++);

            auto global_var = std::make_shared<GlobalVariable>(STOCLASS::GLOBAL, reduction_base->getType(), gv_name,
                                                               GVIniter(reduction_base->getType()));
            if (reduction_base->getVTrait() == ValueTrait::CONSTANT_LITERAL)
                global_var->setIniter(GVIniter(reduction_base->getType(), reduction_base));
            else {
                IRBuilder ph_builder(preheader, preheader->getEndInsertPoint());
                (void)ph_builder.makeStore(reduction_base, global_var);
            }

            module->addGlobalVar(global_var);
            pVal exit_value;
            auto use_list = reduction->getUseList();
            for (const auto &use : use_list) {
                if (upd_insts.count(use->getUser()->as<Instruction>()))
                    continue;

                auto user = use->getUser()->as<Instruction>();
                auto user_block = user->getParent();

                Err::gassert(!top_level->contains(user_block), "Unexpected IV.");
                // We've folded all LCSSA phi, so just place the load in the exit block.
                if (!exit_value) {
                    auto ld =
                        std::make_shared<LOADInst>("%para.reduction.exit" + reduction->getName().substr(1), global_var);
                    exit->addInstAfterPhi(ld);
                    if (reduction_mod) {
                        auto mod = std::make_shared<BinaryInst>(
                            "%para.reduction.exit.mod" + reduction->getName().substr(1), OP::SREM, ld, reduction_mod);
                        exit->addInst(std::next(ld->iter()), mod);
                        exit_value = mod;
                    } else
                        exit_value = ld;
                }
                use->setValue(exit_value);
            }

            Err::gassert(reduction->getParent() == header);

            if (!reduction_mod) {
                update_point.makeCall(module->lookupIntrinsic(atomic_fn), {global_var, reduction_inc});

                for (const auto &utmp : upd_insts) {
                    if (auto phi = utmp->as<PHIInst>())
                        utmp->getParent()->delFirstOfPhiInst(phi);
                    else
                        utmp->getParent()->delFirstOfInst(utmp);
                }
                // Clear the temporary immediately since we're going to rewrite the uses
                // of outside loop values.
                upd_insts.clear();
            } else {
                // For modular addition, we have an optimized way
                IRBuilder body_builder(body_ret);
                body_builder.makeCall(module->lookupIntrinsic(atomic_fn), {global_var, reduction});
            }

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

            Logger::logDebug("[Para]: Rewritten local array '", alloc->getName(), "' into global array '",
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
        auto body_fn =
            std::make_shared<Function>(body_fn_name, std::vector{beg_param, end_param}, makeBType(IRBTYPE::VOID),
                                       &function.getConstantPool(), FuncAttr::NotBuiltin | FuncAttr::ParallelBody);
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
                                shared_arg_gv_ptr_map[operand] = {base_gv, offset};
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
        auto real_iv_bound = iv_bound;
        if (is_signed_less_equal_cond)
            real_iv_bound = ph_builder.makeAdd(iv_bound, function.getConst(1));
        ph_builder.makeCall(parallel_for, std::vector<pVal>{iv_base, real_iv_bound, body_fn});

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
            const auto &[gv, offset] = gvoffset;
            auto dest_ty = arg_inst->getType();
            pVal ptr = gv;
            if (offset != 0) {
                if (offset % gv->getVarType()->getBytes() != 0) {
                    auto i8ptr = para_builder.makeBitcast(gv, makePtrType(makeBType(IRBTYPE::I8)));
                    auto ptradd = para_builder.makeGep(i8ptr, function.getConst(static_cast<int>(offset)));
                    ptr = para_builder.makeBitcast(ptradd, dest_ty);
                } else {
                    ptr = para_builder.makeGep(
                        gv, function.getConst(static_cast<int>(offset / gv->getVarType()->getBytes())));
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
        for (const auto &[gv, inc, load, store, update, atomic_fn_id] : scalar_global_vars) {
            auto atomic_fn = module->lookupIntrinsic(atomic_fn_id);
            auto atomic_call = std::make_shared<CALLInst>(atomic_fn, std::vector<pVal>{gv, inc});

            auto block = store->getParent();
            block->addInst(store->iter(), atomic_call);
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