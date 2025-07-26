// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/code_sink.hpp"

#include "ir/passes/analysis/alias_analysis.hpp"

#include <vector>

namespace IR {
bool processBlock(const pBlock &block, FAM &fam) {
    bool changed = true;
    std::unordered_set<pInst> moved;
    while (changed) {
        changed = false;

        for (auto it = block->rbegin(); it != block->rend(); ++it) {
            const auto& inst = *it;

            if (moved.count(inst) || hasSideEffect(fam, inst))
                continue;

            auto earliest_user = [&]()->pInst {
                pInst ret = nullptr;
                size_t index = std::numeric_limits<size_t>::max();
                for (const auto& user : inst->inst_users()) {
                    if (user->getParent() != block || user->getOpcode() == OP::PHI)
                        continue;
                    if (user->getIndex() < index) {
                        ret = user;
                        index = user->getIndex();
                    }
                }
                return ret;
            }();

            if (earliest_user == nullptr)
                continue;

            auto found_non_operand_between_curr_and_earliest_user = [&]()->bool {
                for (auto iter = std::next(inst->iter()); iter != earliest_user->iter(); ++iter) {
                    bool also_an_operand = false;
                    for (const auto& user : (*iter)->inst_users()) {
                        if (user == earliest_user) {
                            also_an_operand = true;
                            break;
                        }
                    }
                    if (!also_an_operand)
                        return true;
                }
                return false;
            }();

            if (!found_non_operand_between_curr_and_earliest_user)
                continue;

            auto mem_holder = *it;
            block->delInst(std::prev(it.base()));
            block->addInst(earliest_user->iter(), mem_holder);
            moved.emplace(mem_holder);
            Logger::logDebug("[CodeSink]: Moved '", mem_holder->getName(), "' right before '", earliest_user->getName(), "'.");
            changed = true;
            break;
        }
    }
    return !moved.empty();
}
PM::PreservedAnalyses CodeSinkPass::run(Function &function, FAM &fam) {
    bool code_sink_inst_modified = false;
    for (const auto &block : function)
        code_sink_inst_modified |= processBlock(block, fam);
    return code_sink_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR