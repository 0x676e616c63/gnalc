// This PassManager is inspired by the new PassManager of LLVM.
// It also uses concept-based polymorphism, but is much simplified.
#pragma once
#ifndef GNALC_PASS_MANAGER_PASS_MANAGER_HPP
#define GNALC_PASS_MANAGER_PASS_MANAGER_HPP

#include "../utils/exception.hpp"

#include <vector>
#include <map>
#include <set>
#include <memory>
#include <list>
#include <string>

namespace PM
{
class alignas(8) UniqueKey {};

template <typename UnitT>
class AllAnalysesOn {
public:
    static UniqueKey* ID() { return &Key; }

private:
    static UniqueKey Key;
};

template <typename UnitT>
UniqueKey AllAnalysesOn<UnitT>::Key;

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

template <typename UnitT, typename AnalysisManagerT, typename... ExtraArgTs>
class PassConcept {
public:
    virtual ~PassConcept() = default;
    virtual PreservedAnalyses run(UnitT& unit, AnalysisManagerT& manager, ExtraArgTs... args) = 0;
};

template <typename UnitT, typename PassT, typename AnalysisManagerT, typename... ExtraArgTs>
class PassModel : public PassConcept<UnitT, AnalysisManagerT, ExtraArgTs...> {
public:
    explicit PassModel(PassT pass_) : pass(std::move(pass_)) { }

    PassModel(const PassModel& arg) : pass(arg.Pass) { }

    PassModel(PassModel&& arg) noexcept : pass(std::move(arg.Pass)) { }

    PreservedAnalyses run(UnitT& unit, AnalysisManagerT& manager, ExtraArgTs&&... args) override {
        return pass.run(unit, manager, std::forward<ExtraArgTs>(args)...);
    }

    PassT pass;
};

class AnalysisResultConcept { };

template <typename ResultT>
class AnalysisResultModel : public AnalysisResultConcept {
public:
    explicit AnalysisResultModel(ResultT result_) : result(std::move(result_)) {}
    ResultT result;
};

template <typename UnitT, typename... ExtraArgTs>
class AnalysisManager;

template <typename UnitT, typename... ExtraArgTs>
class AnalysisPassConcept {
public:
    virtual std::unique_ptr<AnalysisResultConcept> run(UnitT& unit,
                                                                AnalysisManager<UnitT, ExtraArgTs...>& am,
                                                                ExtraArgTs&&... extra_args) = 0;
    virtual ~AnalysisPassConcept() = default;
};

template <typename UnitT, typename PassT, typename... ExtraArgTs>
class AnalysisPassModel : public AnalysisPassConcept<UnitT, ExtraArgTs...> {
public:
    using ResultModelT = AnalysisResultModel<typename PassT::Result>;
    PassT pass;

    explicit AnalysisPassModel(PassT pass_) : pass(std::move(pass_)) { }

    AnalysisPassModel(const AnalysisPassModel& Arg) : pass(Arg.pass) { }

    AnalysisPassModel(AnalysisPassModel&& Arg) noexcept : pass(std::move(Arg.pass)) { }

    friend void swap(AnalysisPassModel& lhs, AnalysisPassModel& rhs) noexcept {
        using std::swap;
        swap(lhs.Pass, rhs.Pass);
    }

    AnalysisPassModel& operator=(AnalysisPassModel item) {
        swap(*this, item);
        return *this;
    }

    std::unique_ptr<AnalysisResultConcept> run(UnitT& unit, AnalysisManager<UnitT, ExtraArgTs...>& am,
        ExtraArgTs&&... extra_args) override {
        return std::make_unique<ResultModelT>(pass.run(unit, am, std::forward<ExtraArgTs>(extra_args)...));
    }
};

template <typename DerivedT>
class PassInfo {};

template <typename DerivedT>
class AnalysisInfo {
public:
    static UniqueKey* ID() {
        static_assert(std::is_base_of<AnalysisInfo, DerivedT>::value,
                      "The template argument should be the derived type.");
        return &DerivedT::Key;
    }
};

template <typename UnitT, typename... ExtraArgTs>
class AnalysisManager {
public:
    using PassConceptT = AnalysisPassConcept<UnitT, ExtraArgTs...>;
private:
    // Unit -> all of its Results
    using unit_res_t = std::list<std::pair<UniqueKey*, std::unique_ptr<AnalysisResultConcept>>>;
    using all_res_t = std::map<UnitT*, unit_res_t>;
    // Certain Pass -> Result
    using index_t = std::map<std::pair<UniqueKey *, UnitT *>, typename unit_res_t::iterator>;

    std::map<UniqueKey*, std::unique_ptr<PassConceptT>> passes;
    all_res_t results;
    index_t index;
public:
    AnalysisManager() = default;
    AnalysisManager(AnalysisManager&&) = default;
    AnalysisManager& operator=(AnalysisManager&&) noexcept = default;

    void clear() {
        results.clear();
        index.clear();
    }

    template <typename PassT>
    typename PassT::Result& getResult(UnitT& unit, ExtraArgTs&&... extra_args) {
        const auto pass_id = PassT::ID();
        Err::gassert(passes.count(pass_id), "No such pass registered.");

        // Try insert an empty iterator.
        // If succeeded, the result iterator is at the desired position.
        // If not, the result iterator is the cached result.
        auto [it, inserted] = index.insert(std::make_pair(
            std::make_pair(pass_id, &unit),
            typename unit_res_t::iterator()));

        if (inserted) {
            auto &pass = passes.find(pass_id)->second;
            auto &res = results[&unit];
            res.emplace_back(pass_id, pass->run(unit, *this, std::forward<ExtraArgTs>(extra_args)...));
            it->second = std::prev(res.end());
        }

        using ResultModel = AnalysisResultModel<typename PassT::Result>;
        return static_cast<ResultModel&>(*it->second->second).result;
    }

    template <typename PassGetter>
    bool registerPass(PassGetter&& pass_getter) {
        using PassT = decltype(pass_getter());
        using PassModelT =
            AnalysisPassModel<UnitT, PassT, ExtraArgTs...>;

        auto& pass = passes[PassT::ID()];
        if (pass) return false;
        pass.reset(new PassModelT(pass_getter()));
        return true;
    }

    void invalidate(UnitT& unit, const PreservedAnalyses& pa) {
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

template <typename UnitT, typename... ExtraArgTs>
class PassManager : public PassInfo<PassManager<UnitT, ExtraArgTs...>> {
protected:
    using PassConceptT = PassConcept<UnitT, AnalysisManager<UnitT>, ExtraArgTs...>;
    std::vector<std::unique_ptr<PassConceptT>> passes;

public:
    explicit PassManager() = default;

    PassManager(PassManager&& arg) noexcept : passes(std::move(arg.passes)) { }

    PassManager& operator=(PassManager&& rhs) noexcept {
        passes = std::move(rhs.passes);
        return *this;
    }

    template <typename PassT>
    std::enable_if_t<!std::is_same_v<PassT, PassManager>>
    addPass(PassT&& pass) {
        using PassModelT = PassModel<UnitT, PassT, AnalysisManager<UnitT>, ExtraArgTs...>;
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

    PreservedAnalyses run(UnitT& unit, AnalysisManager<UnitT>& am, ExtraArgTs&&... extra_args) {
        PreservedAnalyses pa = PreservedAnalyses::all();

        for (auto& pass : passes) {
            PreservedAnalyses curr_pa = pass->run(unit, am, std::forward<ExtraArgTs>(extra_args)...);
            am.invalidate(unit, curr_pa);
            pa.retain(curr_pa);
        }

        pa.preserveSet<AllAnalysesOn<UnitT>>();

        return pa;
    }
};

// Run this proxy pass to get the inner am
template <typename AnalysisManagerT, typename UnitT, typename... ExtraArgTs>
class InnerAnalysisManagerProxy
    : public AnalysisInfo<InnerAnalysisManagerProxy<AnalysisManagerT, UnitT, ExtraArgTs...>> {
public:
  class Result {
  public:
    explicit Result(AnalysisManagerT &inner_am_) : inner_am(&inner_am_) {}

    Result(Result &&arg) noexcept
      : inner_am(std::move(arg.inner_am)) {
      arg.inner_am = nullptr;
    }

    ~Result() {
      if (!inner_am)
        return;
      inner_am->clear();
    }

    Result &operator=(Result &&rhs) noexcept {
      inner_am = rhs.inner_am;
      rhs.inner_am = nullptr;
      return *this;
    }

    AnalysisManagerT& getManager() { return *inner_am; }

  private:
    AnalysisManagerT *inner_am;
  };

  explicit InnerAnalysisManagerProxy(AnalysisManagerT &InnerAM)
      : inner_am(&InnerAM) {}

  Result run(UnitT &, AnalysisManager<UnitT, ExtraArgTs...> &, ExtraArgTs&&...) {
    return Result(*inner_am);
  }

private:
  friend AnalysisInfo<InnerAnalysisManagerProxy<AnalysisManagerT, UnitT, ExtraArgTs...>>;
  static UniqueKey Key;
  AnalysisManagerT *inner_am;
};

template <typename AnalysisManagerT, typename UnitT, typename... ExtraArgTs>
UniqueKey InnerAnalysisManagerProxy<AnalysisManagerT, UnitT, ExtraArgTs...>::Key;
}
#endif
