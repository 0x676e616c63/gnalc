#pragma once
#ifndef GNALC_IR_PASSES_PASS_MANAGER_HPP
#define GNALC_IR_PASSES_PASS_MANAGER_HPP

#include "ir/function.hpp"
#include "ir/module.hpp"
#include "pass_manager/pass_manager.hpp"

namespace PM {
extern template class AnalysisManager<IR::Module>;
extern template class AnalysisManager<IR::Function>;

extern template class PassManager<IR::Module>;
extern template class PassManager<IR::Function>;

extern template class InnerAnalysisManagerProxy<AnalysisManager<IR::Function>, IR::Module>;

extern template class AnalysisStorage<IR::Function>;
extern template class AnalysisStorage<IR::Module>;
} // namespace PM

namespace IR {
using FAM = PM::AnalysisManager<Function>;
using MAM = PM::AnalysisManager<Module>;

using MPM = PM::PassManager<Module>;
using FPM = PM::PassManager<Function>;

using FAMProxy = PM::InnerAnalysisManagerProxy<FAM, Module>;

namespace Lower {
using FAS = PM::AnalysisStorage<Function>;
using MAS = PM::AnalysisStorage<Module>;

extern FAS gFunctionAnalysisStorage;
} // namespace Lower

class ModulePassWrapper : public PM::PassInfo<ModulePassWrapper> {
public:
    using FunctionPassConceptT = PM::PassConcept<Function, FAM>;
    std::unique_ptr<FunctionPassConceptT> function_pass;

    explicit ModulePassWrapper(std::unique_ptr<FunctionPassConceptT> pass_) : function_pass(std::move(pass_)) {}

    PM::PreservedAnalyses run(Module &m, MAM &mam) const {
        FAM &fam = mam.getResult<FAMProxy>(m).getManager();

        PM::PreservedAnalyses pa = PM::PreservedAnalyses::all();
        // Keep this forward traversal. Some pass (e.g. Inline) rely on this
        for (const auto &func : m.getFunctions()) {
            // No need to skip unused functions now.
            // Note that passes (includes inline) is running in a post order of functions,
            // so there are actually no redundant pass running.
            // Actually this only makes debugging passes harder. :(
            // // Skip unused functions. (maybe inlined)
            // if (func->getUseCount() == 0 && func->getName() != "@main")
            //     continue;
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
    return ModulePassWrapper(std::unique_ptr<ModulePassWrapper::FunctionPassConceptT>(
        new FunctionPassModelT(std::forward<FunctionPassT>(pass))));
}

PM::PreservedAnalyses PreserveAll();
PM::PreservedAnalyses PreserveNone();
PM::PreservedAnalyses PreserveCFGAnalyses();
PM::PreservedAnalyses PreserveLoopAnalyses();
} // namespace IR
#endif
