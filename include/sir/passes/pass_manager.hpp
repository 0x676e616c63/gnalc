#pragma once
#ifndef GNALC_SIR_PASSES_PASS_MANAGER_HPP
#define GNALC_SIR_PASSES_PASS_MANAGER_HPP

#include "sir/base.hpp"
#include "pass_manager/pass_manager.hpp"

namespace PM {
extern template class AnalysisManager<IR::LinearFunction>;
extern template class PassManager<IR::LinearFunction>;
extern template class InnerAnalysisManagerProxy<AnalysisManager<IR::LinearFunction>, IR::Module>;
} // namespace PM

namespace SIR {
using LFAM = PM::AnalysisManager<LinearFunction>;
using LFPM = PM::PassManager<LinearFunction>;
using LFAMProxy = PM::InnerAnalysisManagerProxy<LFAM, Module>;

class LinearModulePassWrapper : public PM::PassInfo<LinearModulePassWrapper> {
public:
    using LFPassConceptT = PM::PassConcept<LinearFunction, LFAM>;
    std::unique_ptr<LFPassConceptT> function_pass;

    explicit LinearModulePassWrapper(std::unique_ptr<LFPassConceptT> pass_) : function_pass(std::move(pass_)) {}

    PM::PreservedAnalyses run(Module &m, MAM &mam) const {
        LFAM &lfam = mam.getResult<LFAMProxy>(m).getManager();

        PM::PreservedAnalyses pa = PM::PreservedAnalyses::all();
        for (const auto &func : m.getLinearFunctions()) {
            PM::PreservedAnalyses curr_pa = function_pass->run(func->as_ref<LinearFunction>(), lfam);
            lfam.invalidate(func->as_ref<LinearFunction>(), curr_pa);
            pa.retain(curr_pa);
        }

        pa.preserve<LFAMProxy>();
        return pa;
    }
};

template <typename LFPassT> auto makeLinearModulePass(LFPassT &&pass) {
    using LFPassModelT = PM::PassModel<LinearFunction, LFPassT, LFAM>;
    return LinearModulePassWrapper(std::unique_ptr<LinearModulePassWrapper::LFPassConceptT>(
        new LFPassModelT(std::forward<LFPassT>(pass))));
}
} // namespace IR
#endif
