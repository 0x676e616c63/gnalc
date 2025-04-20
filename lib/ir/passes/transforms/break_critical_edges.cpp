#include "ir/passes/transforms/break_critical_edges.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/control.hpp"

namespace IR {
PM::PreservedAnalyses BreakCriticalEdgesPass::run(Function &function, FAM &manager) {
    return breakAllCriticalEdges(function) ? PreserveNone() : PreserveAll();
}
} // namespace IR