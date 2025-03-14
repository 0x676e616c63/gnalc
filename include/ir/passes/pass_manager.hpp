#pragma once
#ifndef GNALC_IR_PASSES_PASS_MANAGER_HPP
#define GNALC_IR_PASSES_PASS_MANAGER_HPP

#include "../../ir/function.hpp"
#include "../../ir/module.hpp"
#include "../../pass_manager/pass_manager.hpp"

#include <thread>
#include <vector>
#include <mutex>

namespace PM {
extern template class AnalysisManager<IR::Module>;
extern template class AnalysisManager<IR::Function>;

extern template class PassManager<IR::Module>;
extern template class PassManager<IR::Function>;

extern template class InnerAnalysisManagerProxy<AnalysisManager<IR::Function>,
                                                IR::Module>;
} // namespace PM

namespace IR {
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
        // Keep this forward traversal. Some pass (e.g. Inline) rely on this
        for (const auto &func : m.getFunctions()) {
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

class ParallelizedModulePassWrapper : public PM::PassInfo<ParallelizedModulePassWrapper> {
public:
    using FunctionPassConceptT = PM::PassConcept<Function, FAM>;
    std::function<std::unique_ptr<FunctionPassConceptT>()> function_pass_getter;
    size_t num_threads;

    explicit ParallelizedModulePassWrapper(
        std::function<std::unique_ptr<FunctionPassConceptT>()> function_pass_getter_, size_t num_threads_)
        : function_pass_getter(std::move(function_pass_getter_)), num_threads(num_threads_) {}

    PM::PreservedAnalyses run(Module &m, MAM &mam) const {
        FAM &fam = mam.getResult<FAMProxy>(m).getManager();
        fam.initMutex();

        PM::PreservedAnalyses pa = PM::PreservedAnalyses::all();

        const auto& funcs = m.getFunctions();
        size_t nfuncs_per_worker = funcs.size() / num_threads;
        std::vector<std::thread> workers;
        std::mutex pm_mutex;
        for (size_t i = 0; i < num_threads; ++i) {
            size_t start = i * nfuncs_per_worker;
            size_t end = (i == num_threads - 1) ? funcs.size() : (i + 1) * nfuncs_per_worker;
            workers.emplace_back([this, &fam, &funcs, &pa, &pm_mutex, start, end] {
                for (size_t i = start; i < end; ++i) {
                    const auto& func = funcs[i];
                    PM::PreservedAnalyses curr_pa = function_pass_getter()->run(*func, fam);
                    pm_mutex.lock();
                    fam.invalidate(*func, curr_pa);
                    pa.retain(curr_pa);
                    pm_mutex.unlock();
                }
            });
        }

        for (auto& worker : workers)
            worker.join();

        fam.dropMutex();
        pa.preserve<FAMProxy>();
        return pa;
    }
};

template <typename FunctionPassGetter>
auto makeParallelizedModulePass(const FunctionPassGetter& pass_getter, size_t num_threads) {
    using FunctionPassT = decltype(pass_getter());
    using FunctionPassModelT = PM::PassModel<Function, FunctionPassT, FAM>;
    return ParallelizedModulePassWrapper([&pass_getter] {
        return std::unique_ptr<ParallelizedModulePassWrapper::FunctionPassConceptT>(
            new FunctionPassModelT(pass_getter()));
    }, num_threads);
}

PM::PreservedAnalyses PreserveAll();
PM::PreservedAnalyses PreserveNone();
PM::PreservedAnalyses PreserveCFGAnalyses();
PM::PreservedAnalyses PreserveLoopAnalyses();
} // namespace IR
#endif
