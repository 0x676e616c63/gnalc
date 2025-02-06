#include "../../../../include/ir/passes/transforms/gvn_pre.hpp"

namespace IR {
PM::PreservedAnalyses GVNPREPass::run(Function &function, FAM &fam) {
    return PM::PreservedAnalyses::none();
}

} // namespace IR