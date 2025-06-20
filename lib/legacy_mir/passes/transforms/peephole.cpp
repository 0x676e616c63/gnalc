#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/passes/transforms/peephole.hpp"

namespace LegacyMIR {
PM::PreservedAnalyses PeepHolePass::run(Function &function, FAM &manager) { return PM::PreservedAnalyses::none(); }
} // namespace MIR
#endif