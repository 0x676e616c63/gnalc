#include "pass_manager/pass_manager.hpp"
#include "mir/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<MIR_new::MIRModule>;
template class AnalysisManager<MIR_new::MIRFunction>;

template class PassManager<MIR_new::MIRModule>;
template class PassManager<MIR_new::MIRFunction>;

template class InnerAnalysisManagerProxy<AnalysisManager<MIR_new::MIRFunction>, MIR_new::MIRModule>;
} // namespace PM