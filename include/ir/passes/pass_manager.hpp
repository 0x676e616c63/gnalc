// This PassManager is inspired by the new PassManager of LLVM.
// It also uses concept-based polymorphism, but is much simplified.
#pragma once
#ifndef GNALC_IR_PASSES_PASS_MANAGER_HPP
#define GNALC_IR_PASSES_PASS_MANAGER_HPP

#include "../../ir/module.hpp"
#include "../../ir/function.hpp"
#include "../../pass_manager/pass_manager.hpp"

namespace PM
{
extern template class AnalysisManager<IR::Module>;
extern template class AnalysisManager<IR::Function>;

extern template class PassManager<IR::Module>;
extern template class PassManager<IR::Function>;

extern template class AllAnalysesOn<IR::Module>;
extern template class AllAnalysesOn<IR::Function>;

extern template class InnerAnalysisManagerProxy<AnalysisManager<IR::Function>, IR::Module>;
}

namespace IR
{
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

    PM::PreservedAnalyses run(Module & m, MAM & mam) const {
        FAM &fam = mam.getResult<FAMProxy>(m).getManager();

        PM::PreservedAnalyses pa = PM::PreservedAnalyses::all();
        for (const auto& func : m.getFunctions()) {
            PM::PreservedAnalyses curr_pa = function_pass->run(*func, fam);
            fam.invalidate(*func, curr_pa);
            pa.retain(curr_pa);
        }

        pa.preserveSet<PM::AllAnalysesOn<Function>>();
        pa.preserve<FAMProxy>();
        return pa;
    }
};

template <typename FunctionPassT>
auto makeModulePass(FunctionPassT&& pass) {
    using FunctionPassModelT = PM::PassModel<Function, FunctionPassT, FAM>;
    return ModulePassWrapper(
        std::unique_ptr<ModulePassWrapper::FunctionPassConceptT>(
            new FunctionPassModelT(std::forward<FunctionPassT>(pass))));
}
}
#endif
