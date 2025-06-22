#ifdef GNALC_EXTENSION_ARMv7
#include "pass_manager/pass_manager.hpp"
#include "legacy_mir/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<LegacyMIR::Module>;
template class AnalysisManager<LegacyMIR::Function>;

template class PassManager<LegacyMIR::Module>;
template class PassManager<LegacyMIR::Function>;

template class InnerAnalysisManagerProxy<AnalysisManager<LegacyMIR::Function>, LegacyMIR::Module>;
} // namespace PM
#endif