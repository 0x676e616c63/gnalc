#pragma once
#ifndef GNALC_MIR_PASSES_PASS_MANAGER_HPP
#define GNALC_MIR_PASSES_PASS_MANAGER_HPP

#include "../../pass_manager/pass_manager.hpp"
#include "mir/MIR.hpp"

namespace PM {
extern template class AnalysisManager<MIR::MIRModule>;
extern template class AnalysisManager<MIR::MIRFunction>;

extern template class PassManager<MIR::MIRModule>;
extern template class PassManager<MIR::MIRFunction>;

extern template class InnerAnalysisManagerProxy<AnalysisManager<MIR::MIRFunction>, MIR::MIRModule>;
} // namespace PM

namespace MIR {

using FAM = PM::AnalysisManager<MIRFunction>;
using MAM = PM::AnalysisManager<MIRModule>;

using MPM = PM::PassManager<MIRModule>;
using FPM = PM::PassManager<MIRFunction>;

using FAMProxy = PM::InnerAnalysisManagerProxy<FAM, MIRModule>;

class ModulePassWrapper : public PM::PassInfo<ModulePassWrapper> {
public:
    using FunctionPassConceptT = PM::PassConcept<MIRFunction, FAM>;
    std::unique_ptr<FunctionPassConceptT> function_pass;

    explicit ModulePassWrapper(std::unique_ptr<FunctionPassConceptT> pass_) : function_pass(std::move(pass_)) {}

    PM::PreservedAnalyses run(MIRModule &m, MAM &mam) const {
        FAM &fam = mam.getResult<FAMProxy>(m).getManager();

        PM::PreservedAnalyses pa = PM::PreservedAnalyses::all();
        for (const auto &func : m.funcs()) {
            PM::PreservedAnalyses curr_pa = function_pass->run(*func, fam);
            fam.invalidate(*func, curr_pa);
            pa.retain(curr_pa);
        }

        pa.preserve<FAMProxy>();
        return pa;
    }
};

template <typename FunctionPassT> auto makeModulePass(FunctionPassT &&pass) {
    using FunctionPassModelT = PM::PassModel<MIRFunction, FunctionPassT, FAM>;
    return ModulePassWrapper(std::unique_ptr<ModulePassWrapper::FunctionPassConceptT>(
        new FunctionPassModelT(std::forward<FunctionPassT>(pass))));
}
} // namespace MIR_new
#endif
