#include "../../../include/pass_manager/pass_manager.hpp"
#include "../../../include/ir/passes/pass_manager.hpp"

namespace PM {
template class AnalysisManager<IR::Module>;
template class AnalysisManager<IR::Function>;

template class PassManager<IR::Module>;
template class PassManager<IR::Function>;

template class AllAnalysesOn<IR::Module>;
template class AllAnalysesOn<IR::Function>;

template class InnerAnalysisManagerProxy<AnalysisManager<IR::Function>, IR::Module>;
}