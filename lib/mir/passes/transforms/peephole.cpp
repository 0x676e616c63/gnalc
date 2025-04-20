#include "mir/passes/transforms/peephole.hpp"

namespace MIR {
PM::PreservedAnalyses PeepHolePass::run(Function &function, FAM &manager) {
    return PM::PreservedAnalyses::none();
}
} // namespace MIR
