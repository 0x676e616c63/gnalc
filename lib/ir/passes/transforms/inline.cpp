#include "../../../../include/ir/passes/transforms/inline.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
// FIXME: Inline Cost Calculation
bool shouldBeInlined(const Function &fn) {
    for (const auto& bb : fn) {
        for (const auto& inst : *bb) {
            if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                if (call->getFunc().get() == &fn)
                    return false;
            }
        }
    }
    if (fn.getInstCount() > Config::IR::FUNCTION_INLINE_INST_THRESHOLD)
        return false;
    return true;
}

PM::PreservedAnalyses InlinePass::run(Function &function, FAM &fam) {
    bool inline_cfg_modified = false;

    std::vector<std::shared_ptr<CALLInst>> to_inline;
    for (const auto& bb : function) {
        for (const auto& inst : *bb) {
            if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                auto callee_def = std::dynamic_pointer_cast<Function>(call->getFunc());
                if (callee_def != nullptr && shouldBeInlined(*callee_def))
                    to_inline.emplace_back(call);
            }
        }
    }

    for (const auto& call : to_inline) {
        auto call_block = call->getParent();
        auto candidate = std::dynamic_pointer_cast<Function>(call->getFunc());
        Err::gassert(candidate != nullptr);
        auto cloned = makeClone(candidate);

        // Move alloca
        auto entry = function.getBlocks().front();
        auto cloned_entry = cloned->getBlocks().front();
        cloned_entry->setName(cloned_entry->getName() + ".inline.entry" + std::to_string(name_cnt++));
        std::vector<std::shared_ptr<ALLOCAInst>> allocas;
        for (const auto& inst : *cloned_entry) {
            if (auto alloc = std::dynamic_pointer_cast<ALLOCAInst>(inst))
                allocas.emplace_back(alloc);
            else
                break;
        }
        for (const auto& alloc : allocas) {
            // Note that the call_block might be entry block.
            // Inserting alloca before `entry->begin()` rather than `entry->end()`
            // can make sure the alloca is in the entry block after splitting.
            moveInst(alloc, entry, entry->begin());
        }

        // Split Block
        auto after_call = std::make_shared<BasicBlock>("%inline.aftercall" + std::to_string(name_cnt++));
        moveInsts(std::next(call->getIter()), call_block->end(), after_call);
        Err::gassert(call_block->getInsts().back() == call);

        // Replace RETInst with BRInst
        std::vector<std::pair<std::shared_ptr<BasicBlock>, std::shared_ptr<Value>>> return_info;
        for (const auto& cloned_bb : *cloned) {
            auto term = cloned_bb->getInsts().back();
            if (auto ret = std::dynamic_pointer_cast<RETInst>(term)) {
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
                for (const auto& [bb, val] : return_info) {
                    if (val != common) {
                        common = nullptr;
                        break;
                    }
                }
                if (common != nullptr)
                    call->replaceSelf(common);
                else
                {
                    auto ret_phi = std::make_shared<PHIInst>(
                        "%inline.phi" + std::to_string(name_cnt++), call->getType());
                    for (const auto& [bb, val] : return_info)
                        ret_phi->addPhiOper(val, bb);
                    call->replaceSelf(ret_phi);
                    after_call->addPhiInst(ret_phi);
                }
            }
            else {
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
        for (const auto& param : cloned->getParams())
            param->replaceSelf(actual_args[param->getIndex()]);

        // Fix CFG
        auto original_succs = call_block->getNextBB();
        for (const auto& succ : original_succs) {
            unlinkBB(call_block, succ);
            linkBB(after_call, succ);
            for (const auto& phi : succ->phis())
                phi->replaceAllOperands(call_block, after_call);
        }
        linkBB(call_block, cloned_entry);
        for (const auto& [bb, val] : return_info)
            linkBB(bb, after_call);

        // Move blocks
        function.addBlock(std::next(call_block->getIter()), after_call);
        moveBlocks(cloned->begin(), cloned->end(),
            function.as<Function>(), std::next(call_block->getIter()));
        inline_cfg_modified = true;
    }

    name_cnt = 0;

    return inline_cfg_modified ? PreserveNone() : PreserveAll();
}

} // namespace IR
