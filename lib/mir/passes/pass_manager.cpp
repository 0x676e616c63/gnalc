#include "pass_manager/pass_manager.hpp"
#include "mir/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<MIR::MIRModule>;
template class AnalysisManager<MIR::MIRFunction>;

template class PassManager<MIR::MIRModule>;
template class PassManager<MIR::MIRFunction>;

template class InnerAnalysisManagerProxy<AnalysisManager<MIR::MIRFunction>, MIR::MIRModule>;
} // namespace PM