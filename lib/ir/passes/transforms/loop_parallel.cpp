#include "ir/passes/transforms/loop_parallel.hpp"
#include "ir/block_utils.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses LoopParallelPass::run(Function &function, FAM &fam) {
    return PreserveAll();
}
} // namespace IR