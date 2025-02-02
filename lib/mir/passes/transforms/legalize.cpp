#include "../../../../include/mir/passes/transforms/legalize.hpp"

namespace MIR {
PM::PreservedAnalyses LegalizePass::run(Function &function, FAM &manager) {
    return PM::PreservedAnalyses::none();
}
} // namespace MIR
