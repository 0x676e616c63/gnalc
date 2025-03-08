#include "../../../../include/ir/passes/transforms/break_critical_edges.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/block_utils.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses BreakCriticalEdgesPass::run(Function &function, FAM &manager) {
    bool bce_cfg_modified = false;

    auto dfv = function.getDFVisitor();
    for (const auto& curr : dfv) {
        auto nextbbs = curr->getNextBB();
        if (nextbbs.size() <= 1) continue;
        for (const auto& succ : nextbbs) {
            auto newbb = breakCriticalEdge(curr, succ);
            bce_cfg_modified |= (newbb != nullptr);
        }
    }

    if (bce_cfg_modified)
        return PM::PreservedAnalyses::none();

    return PM::PreservedAnalyses::all();
}
} // namespace IR