#include "../../../../include/ir/passes/transforms/loop_strength_reduce.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"
#include "../../../../include/ir/pattern_match.hpp"

namespace IR {
PM::PreservedAnalyses LoopStrengthReducePass::run(Function &function, FAM &fam) {
    bool lsr_inst_modified = false;
    auto& loop_info = fam.getResult<LoopAnalysis>(function);
    auto& scev = fam.getResult<SCEVAnalysis>(function);
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
                                lsr_inst_modified = true;
                            }
                        }
                    }
                }
            }
        }
    }
    return lsr_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR