// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/inline.hpp"
#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/transforms/memoization.hpp"

namespace IR {
struct InlineCandidate {
    std::vector<pCall> call_points;
    pFunc callee;
};

bool isProfitableToInline(const Function &caller, const InlineCandidate &candidate) {
    auto &callee = *candidate.callee;
    auto &call_points = candidate.call_points;

    // Do not inline function that can be memoized
    if (isProfitableToMemoize(callee))
        return false;

    // Expand recursive call once can have better performance
    if (callee.isRecursive()) {
        if (&caller != &callee)
            return false;

        if (callee.getInstCount() * call_points.size() > Config::IR::FUNCTION_INLINE_RECURSIVE_EXPAND_THRESHOLD) {
            Logger::logDebug("[Inline]: Canceled expanding recursive function '", callee.getName(),
                             "', due to too many instructions.(", call_points.size(), " calls, with each ",
                             callee.getInstCount(), " instructions)");
            return false;
        }

        return true;
    }

    if (call_points.size() < 3)
        return true;

    if (callee.getInstCount() * call_points.size() > Config::IR::FUNCTION_INLINE_INST_THRESHOLD) {
        Logger::logDebug("[Inline]: Canceled inlining '", callee.getName(), "' into '", caller.getName(),
                         "', due to too many instructions. (", call_points.size(), " calls, with each ",
                         callee.getInstCount(), " instructions)");
        return false;
    }
    return true;
}

void doInline(Function &caller, const pCall &call) {
    static size_t name_cnt = 0;
    auto call_block = call->getParent();
    auto candidate = call->getFunc()->as<Function>();
    Err::gassert(candidate != nullptr);

    if (candidate->isRecursive())
        Logger::logDebug("[Inline]: Expanding recursive function '", candidate->getName(), "'.");
    else
        Logger::logDebug("[Inline]: Inlining function '", candidate->getName(), "' into '", caller.getName(), "'.");

    auto cloned = makeClone(candidate);

    // CALLInsts in inlined functions can not be tail call.
    for (const auto &cloned_bb : *cloned) {
        for (const auto &cloned_inst : *cloned_bb) {
            if (auto cloned_call = cloned_inst->as<CALLInst>())
                cloned_call->setTailCall(false);
        }
    }

    // Move alloca
    auto entry = caller.getBlocks().front();
    auto cloned_entry = cloned->getBlocks().front();
    cloned_entry->setName(cloned_entry->getName() + ".il.entry" + std::to_string(name_cnt++));
    std::vector<pAlloca> allocas;
    for (const auto &inst : *cloned_entry) {
        if (auto alloc = inst->as<ALLOCAInst>())
            allocas.emplace_back(alloc);
        else
            break;
    }
    for (const auto &alloc : allocas) {
        // Note that the call_block might be entry block.
        // Inserting alloca before `entry->begin()` rather than `entry->end()`
        // can make sure the alloca is in the entry block after splitting.
        moveInst(alloc, entry, entry->begin());
    }

    // Split Block
    auto after_call = std::make_shared<BasicBlock>("%il.aftercall" + std::to_string(name_cnt++));
    moveInsts(std::next(call->iter()), call_block->end(), after_call);
    Err::gassert(call_block->getInsts().back() == call);

    // Replace RETInst with BRInst
    std::vector<std::pair<pBlock, pVal>> return_info;
    for (const auto &cloned_bb : *cloned) {
        auto term = cloned_bb->getInsts().back();
        if (auto ret = term->as<RETInst>()) {
            if (!ret->isVoid())
                return_info.emplace_back(cloned_bb, ret->getRetVal());
            else
                return_info.emplace_back(cloned_bb, nullptr);
            cloned_bb->delInst(ret);
            cloned_bb->addInst(std::make_shared<BRInst>(after_call));
        }
    }

    // Set up return values and replace call
    if (!call->isVoid()) {
        if (return_info.size() > 1) {
            auto common = return_info[0].second;
            for (const auto &[bb, val] : return_info) {
                if (val != common) {
                    common = nullptr;
                    break;
                }
            }
            if (common != nullptr)
                call->replaceSelf(common);
            else {
                auto ret_phi = std::make_shared<PHIInst>("%il.phi" + std::to_string(name_cnt++), call->getType());
                for (const auto &[bb, val] : return_info)
                    ret_phi->addPhiOper(val, bb);
                call->replaceSelf(ret_phi);
                after_call->addPhiInst(ret_phi);
            }
        } else {
            Err::gassert(return_info.size() == 1);
            call->replaceSelf(return_info[0].second);
        }
    }

    // Replace CALLInst with BRInst
    // Note that after splitting, `call_block`'s end is `call`.
    call_block->delInst(call);
    call_block->addInst(std::make_shared<BRInst>(cloned_entry));

    // Replace parameters with actual arguments.
    auto actual_args = call->getArgs();
    for (const auto &param : cloned->getParams())
        param->replaceSelf(actual_args[param->getIndex()]);

    // Fix CFG
    auto original_succs = call_block->getNextBB();
    for (const auto &succ : original_succs) {
        unlinkBB(call_block, succ);
        linkBB(after_call, succ);
        for (const auto &phi : succ->phis())
            phi->replaceAllOperands(call_block, after_call);
    }
    linkBB(call_block, cloned_entry);
    for (const auto &[bb, val] : return_info)
        linkBB(bb, after_call);

    // Move blocks
    caller.addBlock(std::next(call_block->getIter()), after_call);
    moveBlocks(cloned->begin(), cloned->end(), caller.as<Function>(), std::next(call_block->getIter()));
}

PM::PreservedAnalyses InlinePass::run(Function &function, FAM &fam) {
    std::unordered_map<pFunc, InlineCandidate> candidates;
    for (const auto &bb : function) {
        for (const auto &inst : *bb) {
            if (auto call = inst->as<CALLInst>()) {
                auto callee_def = call->getFunc()->as<Function>();
                if (callee_def != nullptr) {
                    auto &candidate = candidates[callee_def];
                    candidate.call_points.emplace_back(call);
                    candidate.callee = callee_def;
                }
            }
        }
    }

    for (auto it = candidates.begin(); it != candidates.end();) {
        if (!isProfitableToInline(function, it->second))
            it = candidates.erase(it);
        else
            ++it;
    }

    if (candidates.empty())
        return PreserveAll();

    for (const auto &[callee, candidate] : candidates) {
        for (const auto &call : candidate.call_points)
            doInline(function, call);
    }

    return PreserveNone();
}

} // namespace IR
