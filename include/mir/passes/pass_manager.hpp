#pragma once
#ifndef GNALC_MIR_PASSES_PASS_MANAGER_HPP
#define GNALC_MIR_PASSES_PASS_MANAGER_HPP

#include "../../mir/function.hpp"
#include "../../mir/module.hpp"
#include "../../pass_manager/pass_manager.hpp"

namespace PM {
extern template class AnalysisManager<MIR::Module>;
extern template class AnalysisManager<MIR::Function>;

extern template class PassManager<MIR::Module>;
extern template class PassManager<MIR::Function>;

extern template class InnerAnalysisManagerProxy<AnalysisManager<MIR::Function>,
                                                MIR::Module>;
} // namespace PM

namespace MIR {
using FAM = PM::AnalysisManager<Function>;
using MAM = PM::AnalysisManager<Module>;

using MPM = PM::PassManager<Module>;
using FPM = PM::PassManager<Function>;

using FAMProxy = PM::InnerAnalysisManagerProxy<FAM, Module>;

class ModulePassWrapper : public PM::PassInfo<ModulePassWrapper> {
public:
    using FunctionPassConceptT = PM::PassConcept<Function, FAM>;
    std::unique_ptr<FunctionPassConceptT> function_pass;

    explicit ModulePassWrapper(std::unique_ptr<FunctionPassConceptT> pass_)
        : function_pass(std::move(pass_)) {}

    PM::PreservedAnalyses run(Module &m, MAM &mam) const {
        FAM &fam = mam.getResult<FAMProxy>(m).getManager();

        PM::PreservedAnalyses pa = PM::PreservedAnalyses::all();
        for (const auto &func : m.getFuncs()) {
            PM::PreservedAnalyses curr_pa = function_pass->run(*func, fam);
            fam.invalidate(*func, curr_pa);
            pa.retain(curr_pa);
        }

        pa.preserve<FAMProxy>();
        return pa;
    }
};

template <typename FunctionPassT> auto makeModulePass(FunctionPassT &&pass) {
    using FunctionPassModelT = PM::PassModel<Function, FunctionPassT, FAM>;
    return ModulePassWrapper(
        std::unique_ptr<ModulePassWrapper::FunctionPassConceptT>(
            new FunctionPassModelT(std::forward<FunctionPassT>(pass))));
}
} // namespace MIR
#endif
