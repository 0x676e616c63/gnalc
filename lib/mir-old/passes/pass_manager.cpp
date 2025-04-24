#include "pass_manager/pass_manager.hpp"
#include "mir-old/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<MIR::Module>;
template class AnalysisManager<MIR::Function>;

template class PassManager<MIR::Module>;
template class PassManager<MIR::Function>;

template class InnerAnalysisManagerProxy<AnalysisManager<MIR::Function>, MIR::Module>;
} // namespace PM