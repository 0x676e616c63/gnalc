// This PassManager is inspired by the new PassManager of LLVM.
// It also uses concept-based polymorphism, but is much simplified.
#pragma once
#ifndef GNALC_PASSES_PASS_MANAGER_HPP
#define GNALC_PASSES_PASS_MANAGER_HPP

#include "../utils/exception.hpp"
#include "../ir/base.hpp"
#include "../ir/module.hpp"
#include "../ir/function.hpp"

#include <vector>
#include <map>
#include <set>
#include <memory>
#include <string>

namespace IR
{
struct alignas(8) UniqueKey {};

template <typename IRUnitT>
class AllAnalysesOn {
public:
    static UniqueKey* ID() { return &Key; }

private:
    static UniqueKey Key;
};

template <typename IRUnitT>
UniqueKey AllAnalysesOn<IRUnitT>::Key;

extern template class AllAnalysesOn<Module>;
extern template class AllAnalysesOn<Function>;

class PreservedAnalyses {
private:
    static UniqueKey all_analyses_key;
    std::set<UniqueKey*> preserved;
    std::set<UniqueKey*> abandoned;
public:
    static PreservedAnalyses none() { return {}; }

    static PreservedAnalyses all() {
        PreservedAnalyses PA;
        PA.preserved.insert(&all_analyses_key);
        return PA;
    }

    template <typename AnalysisT>
    void preserve() { preserve(AnalysisT::ID()); }

    template <typename AnalysisT>
    void abandon() { abandon(AnalysisT::ID()); }

    void preserve(UniqueKey* ID) {
        abandoned.erase(ID);
        if (!allPreserved())
            preserved.insert(ID);
    }

    void abandon(UniqueKey* ID) {
        preserved.erase(ID);
        abandoned.insert(ID);
    }

    template <typename AnalysisSetT>
    void preserveSet() {
        preserveSet(AnalysisSetT::ID());
    }

    void preserveSet(UniqueKey* ID) {
        if (!allPreserved())
            preserved.insert(ID);
    }

    void retain(const PreservedAnalyses& arg) {
        if (arg.allPreserved()) return;
        if (allPreserved())
        {
            *this = arg;
            return;
        }

        for (auto* id : arg.abandoned)
        {
            preserved.erase(id);
            abandoned.insert(id);
        }

        for (auto* id : preserved)
            if (!arg.preserved.count(id))
                preserved.erase(id);
    }

    bool allPreserved() const {
        return abandoned.empty() && preserved.count(&all_analyses_key);
    }

    template <typename T>
    bool isPreserved() const {
        return isPreserved(T::ID());
    }

    bool isPreserved(UniqueKey* ID) const {
        return !abandoned.count(ID)
        && (preserved.count(ID) || preserved.count(&all_analyses_key));
    }
};


template <typename IRUnitT, typename AnalysisManagerT, typename... ExtraArgTs>
struct PassConcept {
    virtual ~PassConcept() = default;
    virtual PreservedAnalyses run(IRUnitT& ir_unit, AnalysisManagerT& analysis_manager,
                                  ExtraArgTs... extra_args) = 0;
};

template <typename IRUnitT, typename PassT, typename AnalysisManagerT, typename... ExtraArgTs>
struct PassModel : public PassConcept<IRUnitT, AnalysisManagerT, ExtraArgTs...> {
    explicit PassModel(PassT pass_) : pass(std::move(pass_)) { }

    PassModel(const PassModel& Arg) : pass(Arg.Pass) { }

    PassModel(PassModel&& Arg) noexcept : pass(std::move(Arg.Pass)) { }

    PreservedAnalyses run(IRUnitT& IR, AnalysisManagerT& AM,
                          ExtraArgTs&&... extra_args) override {
        return pass.run(IR, AM, std::forward<ExtraArgTs>(extra_args)...);
    }

    PassT pass;
};

template <typename IRUnitT>
struct AnalysisResultConcept {
    virtual bool invalidate(IRUnitT& unit, const PreservedAnalyses& pa) = 0;

    virtual ~AnalysisResultConcept() = default;
};

template <typename IRUnitT, typename PassT, typename ResultT>
struct AnalysisResultModel : AnalysisResultConcept<IRUnitT> {
    explicit AnalysisResultModel(ResultT Result) : result(std::move(Result)) { }

    AnalysisResultModel(const AnalysisResultModel& arg) : result(arg.Result) { }

    AnalysisResultModel(AnalysisResultModel&& arg) noexcept
        : result(std::move(arg.Result)) { }

    bool invalidate(IRUnitT& unit, const PreservedAnalyses& pa) override {
        return !pa.isPreserved<PassT>() && !pa.isPreserved<AllAnalysesOn<IRUnitT>>();
    }

    ResultT result;
};

template <typename IRUnitT, typename... ExtraArgTs>
class AnalysisManager;

template <typename IRUnitT, typename... ExtraArgTs>
struct AnalysisPassConcept {
    virtual std::unique_ptr<AnalysisResultConcept<IRUnitT>> run(IRUnitT& unit,
                                                                AnalysisManager<IRUnitT, ExtraArgTs...>& am,
                                                                ExtraArgTs&&... extra_args) = 0;
    virtual ~AnalysisPassConcept() = default;
};

template <typename IRUnitT, typename PassT, typename... ExtraArgTs>
struct AnalysisPassModel : AnalysisPassConcept<IRUnitT, ExtraArgTs...> {
    using ResultModelT = AnalysisResultModel<IRUnitT, PassT, typename PassT::Result>;
    PassT pass;

    explicit AnalysisPassModel(PassT pass_) : pass(std::move(pass_)) {
    }

    AnalysisPassModel(const AnalysisPassModel& Arg) : pass(Arg.pass) {
    }

    AnalysisPassModel(AnalysisPassModel&& Arg) noexcept : pass(std::move(Arg.pass)) {
    }

    friend void swap(AnalysisPassModel& lhs, AnalysisPassModel& rhs) noexcept {
        using std::swap;
        swap(lhs.Pass, rhs.Pass);
    }

    AnalysisPassModel& operator=(AnalysisPassModel item) {
        swap(*this, item);
        return *this;
    }

    std::unique_ptr<AnalysisResultConcept<IRUnitT>>
    run(IRUnitT& unit, AnalysisManager<IRUnitT, ExtraArgTs...>& am,
        ExtraArgTs&&... extra_args) override {
        return std::make_unique<ResultModelT>(pass.run(unit, am, std::forward<ExtraArgTs>(extra_args)...));
    }
};

template <typename DerivedT>
struct PassInfo {
};

template <typename DerivedT>
struct AnalysisInfo {
    static UniqueKey* ID() {
        static_assert(std::is_base_of<AnalysisInfo, DerivedT>::value,
                      "The template argument should be the derived type.");
        return &DerivedT::Key;
    }
};

template <typename IRUnitT, typename... ExtraArgTs>
class AnalysisManager {
public:
    using ResultConceptT = AnalysisResultConcept<IRUnitT>;
    using PassConceptT = AnalysisPassConcept<IRUnitT, ExtraArgTs...>;
private:
    // Unit -> all of its Results
    using unit_res_t = std::list<std::pair<UniqueKey*, std::unique_ptr<ResultConceptT>>>;
    using all_res_t = std::map<IRUnitT*, unit_res_t>;
    // Certain Pass -> Result
    using index_t = std::map<std::pair<UniqueKey *, IRUnitT *>, typename unit_res_t::iterator>;

    std::map<UniqueKey*, std::unique_ptr<PassConceptT>> passes;
    all_res_t results;
    index_t index;
public:
    AnalysisManager() = default;
    AnalysisManager(AnalysisManager&&) = default;
    AnalysisManager& operator=(AnalysisManager&&) noexcept = default;

    bool cache_empty() const {
        Err::gassert(results.empty() == index.empty());
        return results.empty();
    }

    void clear() {
        results.clear();
        index.clear();
    }

    template <typename PassT>
    typename PassT::Result& getResult(IRUnitT& unit, ExtraArgTs... extra_args) {
        const auto pass_id = PassT::ID();
        Err::gassert(passes.count(pass_id));

        // Try insert an empty iterator.
        // If succeeded, the result iterator is at the desired position.
        // If not, the result iterator is the cached result.
        auto [it, inserted] = index.insert(std::make_pair(
            std::make_pair(pass_id, &unit),
            typename unit_res_t::iterator()));

        if (inserted) {
            auto &pass = passes.find(pass_id)->second;
            auto &res = results[&unit];
            res.emplace_back(pass_id, pass->run(unit, *this, extra_args...));
            it->second = std::prev(res.end());
        }

        using ResultModel = AnalysisResultModel<IRUnitT, PassT, typename PassT::Result>;
        return static_cast<ResultModel&>(*it->second->second).result;
    }

    template <typename PassGetter>
    bool registerPass(PassGetter&& pass_getter) {
        using PassT = decltype(pass_getter());
        using PassModelT =
            AnalysisPassModel<IRUnitT, PassT, ExtraArgTs...>;

        auto& pass = passes[PassT::ID()];
        if (pass) return false;
        pass.reset(new PassModelT(pass_getter()));
        return true;
    }

    void invalidate(IRUnitT& unit, const PreservedAnalyses& pa) {
        if (pa.allPreserved()) return;
        auto& unit_res = results[&unit];

        for (auto it = unit_res.begin(); it != unit_res.end();)
        {
            auto pass_id = it->first;
            if (!pa.isPreserved(pass_id))
            {
                unit_res.erase(it);
                index.erase({pass_id, &unit});
            }
            else ++it;
        }
    }
};

extern template class AnalysisManager<Function>;
extern template class AnalysisManager<Module>;

using FunctionAnalysisManager = AnalysisManager<Function>;
using ModuleAnalysisManager = AnalysisManager<Module>;

template <typename IRUnitT, typename... ExtraArgTs>
class PassManager : public PassInfo<PassManager<IRUnitT, ExtraArgTs...>> {
protected:
    using PassConceptT = PassConcept<IRUnitT, AnalysisManager<IRUnitT>, ExtraArgTs...>;
    std::vector<std::unique_ptr<PassConceptT>> passes;

public:
    explicit PassManager() = default;

    PassManager(PassManager&& arg) noexcept : passes(std::move(arg.passes)) { }

    PassManager& operator=(PassManager&& rhs) noexcept {
        passes = std::move(rhs.Passes);
        return *this;
    }

    template <typename PassT>
    std::enable_if_t<!std::is_same_v<PassT, PassManager>>
    addPass(PassT&& pass) {
        using PassModelT = PassModel<IRUnitT, PassT, AnalysisManager<IRUnitT>, ExtraArgTs...>;
        // comment from LLVM:
        // Do not use make_unique or emplace_back, they cause too many template
        // instantiations, causing terrible compile times.
        passes.push_back(std::unique_ptr<PassConceptT>(
            new PassModelT(std::forward<PassT>(pass))));
    }

    template <typename PassT>
    std::enable_if_t<std::is_same_v<PassT, PassManager>>
    addPass(PassT&& pass) {
        for (auto& P : pass.passes)
            passes.push_back(std::move(P));
    }

    PreservedAnalyses run(IRUnitT& unit, AnalysisManager<IRUnitT>& am,
                          ExtraArgTs... extra_args) {
        PreservedAnalyses pa = PreservedAnalyses::all();

        for (auto& pass : passes) {
            PreservedAnalyses curr_pa = pass->run(unit, am, extra_args...);
            am.invalidate(unit, curr_pa);
            pa.retain(curr_pa);
        }

        pa.preserveSet<AllAnalysesOn<IRUnitT>>();

        return pa;
    }
};

extern template class PassManager<Function>;
extern template class PassManager<Module>;

using ModulePassManager = PassManager<Module>;
using FunctionPassManager = PassManager<Function>;

class FAMProxy : public AnalysisInfo<FAMProxy> {
private:
    FunctionAnalysisManager *fam;
public:
  class Result {
  private:
      FunctionAnalysisManager *fam;
  public:
    explicit Result(FunctionAnalysisManager &fam_) : fam(&fam_) {}

    Result(Result &&arg) noexcept : fam(arg.fam) { arg.fam = nullptr; }

    ~Result() {
      if (!fam) return;
      fam->clear();
    }

    Result &operator=(Result &&rhs) noexcept {
      fam = rhs.fam;
      rhs.fam = nullptr;
      return *this;
    }

    FunctionAnalysisManager &getManager() { return *fam; }

    bool invalidate(Module &unit, const PreservedAnalyses &pa) {
            // TODO
    }
  };

  explicit FAMProxy(FunctionAnalysisManager &fam_)
      : fam(&fam_) {}

  Result run(Module& unit, AnalysisManager<Module> & MAM) {
    return Result(*fam);
  }

private:
    friend AnalysisInfo<FAMProxy>;
    static UniqueKey Key;
};

class ModulePassWrapper : public PassInfo<ModulePassWrapper>
{
public:
    using PassConceptT = PassConcept<Function, FunctionAnalysisManager>;
    explicit ModulePassWrapper(std::unique_ptr<PassConceptT> pass_)
    : pass(std::move(pass_)) {}

    PreservedAnalyses run(Module &m, ModuleAnalysisManager &mam) {
        FunctionAnalysisManager &fam =
            mam.getResult<FAMProxy>(m).getManager();

        PreservedAnalyses pa = PreservedAnalyses::all();
        for (const auto& f : m.getFunctions()) {
            PreservedAnalyses curr_pa = pass->run(*f, fam);
            fam.invalidate(*f, curr_pa);
            pa.retain(curr_pa);
        }

        pa.preserveSet<AllAnalysesOn<Function>>();
        pa.preserve<FAMProxy>();
        return pa;
    }
private:
    std::unique_ptr<PassConceptT> pass;
};

template <typename FunctionPassT>
ModulePassWrapper make_module_pass(FunctionPassT&& pass) {
    using PassModelT = PassModel<Function, FunctionPassT, PreservedAnalyses, FunctionAnalysisManager>;
    return ModulePassWrapper(
        std::unique_ptr<ModulePassWrapper::PassConceptT>(
            new PassModelT(std::forward<FunctionPassT>(pass))));
}
}
#endif
