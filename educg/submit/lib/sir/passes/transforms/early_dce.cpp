// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/early_dce.hpp"

#include "../../../../include/sir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/sir/visitor.hpp"

namespace SIR {
struct DCEVisitor : ContextVisitor {
    std::vector<std::pair<IList*, LInstIter>> to_delete;
    std::unordered_set<Instruction*> dead;

    bool isAlwaysAlive(Instruction &inst) const {
        return inst.getVTrait() == ValueTrait::VOID_INSTRUCTION || inst.is<HELPERInst, CALLInst>();
    }

    bool isInstTriviallyDead(Instruction &inst) const {
        if (isAlwaysAlive(inst))
            return false;

        if (inst.getUseCount() == 0)
            return true;

        for (const auto& inst_user : inst.inst_users()) {
            if (!dead.count(inst_user.get()))
                return false;
        }

        return true;
    }

    void visit(Context ctx, Instruction &inst) override {
        // post order traversal to find more dead instructions.
        ContextVisitor::visit(ctx, inst);

        if (isInstTriviallyDead(inst)) {
            to_delete.emplace_back(ctx.iList(), ctx.iter);
            dead.emplace(&inst);
        }
        // FORInst can be optimized to dead
        else if (auto for_inst = inst.as<FORInst>()) {
            bool contains_alive_inst = false;
            for (const auto& body_inst : for_inst->getBodyInsts()) {
                if (!isInstTriviallyDead(*body_inst)) {
                    contains_alive_inst = true;
                    break;
                }
            }
            if (!contains_alive_inst) {
                to_delete.emplace_back(ctx.iList(), ctx.iter);
                dead.emplace(&inst);
                Logger::logDebug("[EarlyDCE]: Deleting dead for inst '", for_inst->getIndVar()->getName(), "'.");
            }
        }
    }
};
PM::PreservedAnalyses EarlyDCEPass::run(LinearFunction &function, LFAM &lfam) {
    DCEVisitor dce_visitor;
    function.accept(dce_visitor);

    if (dce_visitor.to_delete.empty())
        return PreserveAll();

    for (auto &[list, iter] : dce_visitor.to_delete)
        list->erase(iter);

    return PreserveNone();
}
} // namespace SIR