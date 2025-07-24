// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Generic Pass Manager used by both the SIR, IR and MIR PassManagers.
//
// Adopting design concepts from LLVM's New PassManager framework,
// this implementation maintains a lightweight structure
// appropriate for gnalc's limited pass pipeline.
//
// A key difference is our manual handling of analysis dependencies.
// Each transform pass may invalidate one or more analysis passes.
// Consequently, when a transform pass invalidates an analysis pass,
// it must also explicitly invalidate any analysis passes that depend on it.
//
// For example:
//
//              invalidate                  used by
// TransformA --------------> AnalysisA <--------------- AnalysisB
//
// Even if TransformA does not directly invalidate AnalysisB, it must still explicitly
// invalidate both AnalysisA and AnalysisB.
//

#pragma once
#ifndef GNALC_PASS_MANAGER_PASS_MANAGER_HPP
#define GNALC_PASS_MANAGER_PASS_MANAGER_HPP

#include "utils/exception.hpp"
#include "utils/logger.hpp"
#include "utils/misc.hpp"

#include <chrono>
#include <list>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <vector>

namespace PM {
class alignas(8) UniqueKey {};

class PreservedAnalyses {
private:
    static UniqueKey all_analyses_key;
    std::set<UniqueKey *> preserved;
    std::set<UniqueKey *> abandoned;

public:
    static PreservedAnalyses none() { return {}; }

    static PreservedAnalyses all() {
        PreservedAnalyses PA;
        PA.preserved.insert(&all_analyses_key);
        return PA;
    }

    template <typename AnalysisT> void preserve() { preserve(AnalysisT::ID()); }

    template <typename AnalysisT> void abandon() { abandon(AnalysisT::ID()); }

    void preserve(UniqueKey *ID) {
        abandoned.erase(ID);
        if (!allPreserved())
            preserved.insert(ID);
    }

    void abandon(UniqueKey *ID) {
        preserved.erase(ID);
        abandoned.insert(ID);
    }

    template <typename AnalysisSetT> void preserveSet() { preserveSet(AnalysisSetT::ID()); }

    void preserveSet(UniqueKey *ID) {
        if (!allPreserved())
            preserved.insert(ID);
    }

    void retain(const PreservedAnalyses &arg) {
        if (arg.allPreserved())
            return;
        if (allPreserved()) {
            *this = arg;
            return;
        }

        for (auto id : arg.abandoned) {
            preserved.erase(id);
            abandoned.insert(id);
        }

        for (auto it = preserved.begin(); it != preserved.end();) {
            if (!arg.preserved.count(*it))
                it = preserved.erase(it);
            else
                ++it;
        }
    }

    bool allPreserved() const { return abandoned.empty() && preserved.count(&all_analyses_key); }

    template <typename T> bool isPreserved() const { return isPreserved(T::ID()); }

    bool isPreserved(UniqueKey *ID) const {
        return !abandoned.count(ID) && (preserved.count(ID) || preserved.count(&all_analyses_key));
    }
};

template <typename UnitT, typename AnalysisManagerT> class PassConcept {
public:
    virtual ~PassConcept() = default;
    virtual std::string_view name() const = 0;
    virtual PreservedAnalyses run(UnitT &unit, AnalysisManagerT &manager) = 0;
};

template <typename UnitT, typename PassT, typename AnalysisManagerT>
class PassModel : public PassConcept<UnitT, AnalysisManagerT> {
public:
    explicit PassModel(PassT pass_) : pass(std::move(pass_)) {}

    PassModel(const PassModel &arg) : pass(arg.Pass) {}

    PassModel(PassModel &&arg) noexcept : pass(std::move(arg.Pass)) {}

    PreservedAnalyses run(UnitT &unit, AnalysisManagerT &manager) override { return pass.run(unit, manager); }

    std::string_view name() const override { return PassT::name(); }

    PassT pass;
};

class AnalysisResultConcept {
public:
    virtual ~AnalysisResultConcept() = default;
};

template <typename ResultT> class AnalysisResultModel : public AnalysisResultConcept {
public:
    explicit AnalysisResultModel(ResultT result_) : result(std::move(result_)) {}
    ResultT result;
};

template <typename UnitT> class AnalysisManager;

template <typename UnitT> class AnalysisPassConcept {
public:
    virtual std::unique_ptr<AnalysisResultConcept> run(UnitT &unit, AnalysisManager<UnitT> &am) = 0;
    virtual std::string_view name() const = 0;
    virtual ~AnalysisPassConcept() = default;
};

template <typename UnitT, typename PassT> class AnalysisPassModel : public AnalysisPassConcept<UnitT> {
public:
    using ResultModelT = AnalysisResultModel<typename PassT::Result>;
    PassT pass;

    explicit AnalysisPassModel(PassT pass_) : pass(std::move(pass_)) {}

    AnalysisPassModel(const AnalysisPassModel &Arg) : pass(Arg.pass) {}

    AnalysisPassModel(AnalysisPassModel &&Arg) noexcept : pass(std::move(Arg.pass)) {}

    friend void swap(AnalysisPassModel &lhs, AnalysisPassModel &rhs) noexcept {
        using std::swap;
        swap(lhs.Pass, rhs.Pass);
    }

    AnalysisPassModel &operator=(AnalysisPassModel item) {
        swap(*this, item);
        return *this;
    }

    std::string_view name() const override { return PassT::name(); }

    std::unique_ptr<AnalysisResultConcept> run(UnitT &unit, AnalysisManager<UnitT> &am) override {
        return std::make_unique<ResultModelT>(pass.run(unit, am));
    }
};

template <typename DerivedT> class PassInfo {
public:
    static std::string_view name() {
        static_assert(std::is_base_of_v<PassInfo, DerivedT>, "The template argument should be the derived type.");
        return Util::getTypeName<DerivedT>();
    }
};

template <typename DerivedT> class AnalysisInfo {
public:
    static UniqueKey *ID() {
        static_assert(std::is_base_of_v<AnalysisInfo, DerivedT>, "The template argument should be the derived type.");
        return &DerivedT::Key;
    }

    static std::string_view name() {
        static_assert(std::is_base_of_v<AnalysisInfo, DerivedT>, "The template argument should be the derived type.");
        return Util::getTypeName<DerivedT>();
    }
};

template <typename UnitT> class AnalysisManager {
public:
    using PassConceptT = AnalysisPassConcept<UnitT>;

private:
    // Unit -> all of its Results
    using unit_res_t = std::list<std::pair<UniqueKey *, std::unique_ptr<AnalysisResultConcept>>>;
    using all_res_t = std::map<UnitT *, unit_res_t>;
    // Certain Pass -> Result
    using index_t = std::map<std::pair<UniqueKey *, UnitT *>, unit_res_t::iterator>;

    std::map<UniqueKey *, std::unique_ptr<PassConceptT>> passes;
    all_res_t results;
    index_t index;
    bool is_getting_fresh_result = false;

public:
    AnalysisManager() = default;
    AnalysisManager(AnalysisManager &&) = default;
    AnalysisManager &operator=(AnalysisManager &&) noexcept = default;

    void clear() {
        results.clear();
        index.clear();
        is_getting_fresh_result = false;
    }

    template <typename PassT> typename PassT::Result &getResult(UnitT &unit) {
        if (is_getting_fresh_result)
            return getFreshResult<PassT>(unit);

        const auto pass_id = PassT::ID();
        Err::gassert(passes.count(pass_id), "No such pass registered.");

        // Try insert an empty iterator.
        // If succeeded, the result iterator is at the desired position.
        // If not, the result iterator is the cached result.
        auto [it, inserted] = index.insert(std::make_pair(std::make_pair(pass_id, &unit), unit_res_t::iterator()));

        auto &pass = passes.find(pass_id)->second;
        if (inserted) {
            auto &res = results[&unit];

            auto start = std::chrono::high_resolution_clock::now();
            res.emplace_back(pass_id, pass->run(unit, *this));
            auto end = std::chrono::high_resolution_clock::now();
            std::chrono::duration<double> duration = end - start;

            it->second = std::prev(res.end());
            Logger::logInfo("[AM]: Finished '", pass->name(), "' on '", unit.getName(),
                            "'.(elapsed time: ", duration.count(), "s)");
        } else
            Logger::logInfo("[AM]: Get cached '", pass->name(), "' on '", unit.getName(), "'");

        using ResultModel = AnalysisResultModel<typename PassT::Result>;
        return static_cast<ResultModel &>(*it->second->second).result;
    }

    template <typename PassT> typename PassT::Result &getFreshResult(UnitT &unit) {
        is_getting_fresh_result = true;
        const auto pass_id = PassT::ID();
        Err::gassert(passes.count(pass_id), "No such pass registered.");

        auto [it, inserted] = index.insert(std::make_pair(std::make_pair(pass_id, &unit), unit_res_t::iterator()));

        auto &pass = passes.find(pass_id)->second;
        auto &res = results[&unit];

        auto start = std::chrono::high_resolution_clock::now();
        res.emplace_back(pass_id, pass->run(unit, *this));
        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;

        it->second = std::prev(res.end());

        Logger::logInfo("[AM]: Finished '", pass->name(), "' on '", unit.getName(),
                        "'.(fresh result, elapsed time: ", duration.count(), "s)");
        is_getting_fresh_result = false;

        using ResultModel = AnalysisResultModel<typename PassT::Result>;
        return static_cast<ResultModel &>(*it->second->second).result;
    }

    template <typename PassGetter> bool registerPass(PassGetter &&pass_getter) {
        using PassT = decltype(pass_getter());
        using PassModelT = AnalysisPassModel<UnitT, PassT>;

        auto &pass = passes[PassT::ID()];
        if (pass)
            return false;
        pass.reset(new PassModelT(pass_getter()));
        return true;
    }

    void invalidate(UnitT &unit, const PreservedAnalyses &pa) {
        if (pa.allPreserved())
            return;

        auto &unit_res = results[&unit];

        for (auto it = unit_res.begin(); it != unit_res.end();) {
            auto pass_id = it->first;
            if (!pa.isPreserved(pass_id)) {
                it = unit_res.erase(it);
                index.erase({pass_id, &unit});
            } else
                ++it;
        }
    }
};

// Analysis Storage
// This is a helper class that hold Analysis results persistently.
// It is used to transfer Analysis results to lower representation, such as passing
// IR RangeAnalysis to MIR.
// It never invalidates any result, so client code should keep the result valid themselves.
template <typename UnitT> class AnalysisStorage {
public:
    using PassConceptT = AnalysisPassConcept<UnitT>;

private:
    // Unit -> all of its Results
    using unit_res_t = std::list<std::pair<UniqueKey *, std::unique_ptr<AnalysisResultConcept>>>;
    using all_res_t = std::map<UnitT *, unit_res_t>;
    // Certain Pass -> Result
    using index_t = std::map<std::pair<UniqueKey *, UnitT *>, unit_res_t::iterator>;

    all_res_t results;
    index_t index;

public:
    AnalysisStorage() = default;
    AnalysisStorage(AnalysisStorage &&) = default;
    AnalysisStorage &operator=(AnalysisStorage &&) noexcept = default;

    void clear() {
        results.clear();
        index.clear();
    }

    template <typename PassT> typename PassT::Result *getStoredResult(UnitT &unit) const {
        const auto pass_id = PassT::ID();
        auto it = index.find(std::make_pair(pass_id, &unit));

        if (it == index.end())
            return nullptr;

        Logger::logInfo("[AnalysisStorage]: Get stored result of '", PassT::name(), "'.");

        using ResultModel = AnalysisResultModel<typename PassT::Result>;
        return &static_cast<ResultModel &>(*it->second->second).result;
    }

    template <typename PassT> void storeResult(UnitT &unit, const typename PassT::Result &result) {
        const auto pass_id = PassT::ID();

        auto [it, inserted] = index.insert(std::make_pair(std::make_pair(pass_id, &unit), unit_res_t::iterator()));

        if (!inserted)
            Logger::logWarning("[AnalysisStorage]: Overwriting result of '", PassT::name(), "'.");

        auto &unit_res = results[&unit];
        using ResultModelT = AnalysisResultModel<typename PassT::Result>;
        unit_res.emplace_back(pass_id, std::make_unique<ResultModelT>(result));
        it->second = std::prev(unit_res.end());

        Logger::logInfo("[AnalysisStorage]: Stored result of '", PassT::name(), "'.");
    }
};

namespace detail {
template <typename T, typename U = void> struct hasGetInstCount : std::false_type {};

template <typename T>
struct hasGetInstCount<T, std::void_t<decltype(std::declval<T>().getInstCount())>> : std::true_type {};

template <typename T> constexpr bool hasGetInstCountV = hasGetInstCount<T>::value;
} // namespace detail

template <typename UnitT> class PassManager : public PassInfo<PassManager<UnitT>> {
    template <typename UnitT2> friend class FixedPointPM;

protected:
    using PassConceptT = PassConcept<UnitT, AnalysisManager<UnitT>>;
    std::vector<std::unique_ptr<PassConceptT>> passes;

public:
    explicit PassManager() = default;

    PassManager(PassManager &&arg) noexcept : passes(std::move(arg.passes)) {}

    PassManager &operator=(PassManager &&rhs) noexcept {
        passes = std::move(rhs.passes);
        return *this;
    }

    template <typename PassT> std::enable_if_t<!std::is_same_v<PassT, PassManager>> addPass(PassT &&pass) {
        using PassModelT = PassModel<UnitT, PassT, AnalysisManager<UnitT>>;
        passes.push_back(std::unique_ptr<PassConceptT>(new PassModelT(std::forward<PassT>(pass))));
    }

    template <typename PassT> std::enable_if_t<std::is_same_v<PassT, PassManager>> addPass(PassT &&pass) {
        for (auto &P : pass.passes)
            passes.push_back(std::move(P));
    }

    PreservedAnalyses run(UnitT &unit, AnalysisManager<UnitT> &am) {
        PreservedAnalyses pa = PreservedAnalyses::all();
        for (auto &pass : passes) {
            if constexpr (detail::hasGetInstCountV<UnitT>) {
                auto old_inst_cnt = unit.getInstCount();

                auto start = std::chrono::high_resolution_clock::now();
                PreservedAnalyses curr_pa = pass->run(unit, am);
                auto end = std::chrono::high_resolution_clock::now();
                std::chrono::duration<double> duration = end - start;

                am.invalidate(unit, curr_pa);
                pa.retain(curr_pa);
                auto new_inst_cnt = unit.getInstCount();
                Logger::logInfo("[PM]: Finished '", pass->name(), "' on '", unit.getName(), "'.(inst: ", old_inst_cnt,
                                " -> ", new_inst_cnt, ", elapsed time: ", duration.count(), "s",
                                curr_pa.allPreserved() ? ", identical)" : ", modified)");
            } else {
                auto start = std::chrono::high_resolution_clock::now();
                PreservedAnalyses curr_pa = pass->run(unit, am);
                auto end = std::chrono::high_resolution_clock::now();
                std::chrono::duration<double> duration = end - start;

                am.invalidate(unit, curr_pa);
                pa.retain(curr_pa);

                Logger::logInfo("[PM]: Finished '", pass->name(), "' on '", unit.getName(),
                                "'.(elapsed time: ", duration.count(), "s",
                                curr_pa.allPreserved() ? ", identical)" : ", modified)");
            }
        }

        return pa;
    }

    std::vector<std::string> getPassNames() {
        std::vector<std::string> names;
        for (auto &pass : passes)
            names.emplace_back(pass->name());
        return names;
    }

    void printPipeline() {
        std::string pipeline;
        for (const auto &pass : passes)
            pipeline += std::string{pass->name()} + ", ";
        if (!pipeline.empty()) {
            pipeline.pop_back();
            pipeline.pop_back();
        }
        Logger::logInfo("[PM]: Running pipeline: ", pipeline);
    }
};

template <typename UnitT> class FixedPointPM : public PassInfo<FixedPointPM<UnitT>> {
protected:
    using PassConceptT = PassConcept<UnitT, AnalysisManager<UnitT>>;
    // (pass, ignoring change)
    std::vector<std::pair<std::unique_ptr<PassConceptT>, bool>> passes;
    size_t threshold;
    bool threshold_explicitly_set;

public:
    explicit FixedPointPM(size_t threshold_) : threshold(threshold_), threshold_explicitly_set(true) {}

    explicit FixedPointPM() : threshold(100), threshold_explicitly_set(false) {}

    FixedPointPM(FixedPointPM &&arg) noexcept
        : passes(std::move(arg.passes)), threshold(arg.threshold),
          threshold_explicitly_set(arg.threshold_explicitly_set) {}

    FixedPointPM &operator=(FixedPointPM &&rhs) noexcept {
        passes = std::move(rhs.passes);
        return *this;
    }

    template <typename PassT>
    std::enable_if_t<!std::is_same_v<PassT, PassManager<UnitT>>> addPass(PassT &&pass, bool ignoring_change = false) {
        using PassModelT = PassModel<UnitT, PassT, AnalysisManager<UnitT>>;
        passes.push_back(
            std::make_pair(std::unique_ptr<PassConceptT>(new PassModelT(std::forward<PassT>(pass))), ignoring_change));
    }

    template <typename PassT>
    std::enable_if_t<std::is_same_v<PassT, PassManager<UnitT>>> addPass(PassT &&pass, bool ignoring_changes = false) {
        for (auto &P : pass.passes)
            passes.push_back(std::make_pair(std::move(P), ignoring_changes));
    }

    PreservedAnalyses run(UnitT &unit, AnalysisManager<UnitT> &am) {
        PreservedAnalyses pa = PreservedAnalyses::all();
        bool modified = true;
        std::string last_modified_pass;
        auto first_pass = passes.front().first->name();

        size_t round = 1;
        while (modified) {
            modified = false;
            for (auto &[pass, ignoring_change] : passes) {
                if constexpr (detail::hasGetInstCountV<UnitT>) {
                    auto old_inst_cnt = unit.getInstCount();

                    auto start = std::chrono::high_resolution_clock::now();
                    PreservedAnalyses curr_pa = pass->run(unit, am);
                    auto end = std::chrono::high_resolution_clock::now();
                    std::chrono::duration<double> duration = end - start;

                    if (!ignoring_change && !curr_pa.allPreserved()) {
                        modified = true;
                        last_modified_pass = pass->name();
                    }

                    am.invalidate(unit, curr_pa);
                    pa.retain(curr_pa);

                    auto new_inst_cnt = unit.getInstCount();
                    Logger::logInfo("[FixedPointPM] at round ", round, ": Finished '", pass->name(), "' on '",
                                    unit.getName(), "'.(inst: ", old_inst_cnt, " -> ", new_inst_cnt,
                                    ", elapsed time: ", duration.count(), "s",
                                    curr_pa.allPreserved() ? ", identical)" : ", modified)");
                } else {
                    auto start = std::chrono::high_resolution_clock::now();
                    PreservedAnalyses curr_pa = pass->run(unit, am);
                    auto end = std::chrono::high_resolution_clock::now();
                    std::chrono::duration<double> duration = end - start;

                    if (!ignoring_change && !curr_pa.allPreserved()) {
                        modified = true;
                        last_modified_pass = pass->name();
                    }

                    am.invalidate(unit, curr_pa);
                    pa.retain(curr_pa);

                    Logger::logInfo("[FixedPointPM] at round ", round, ": Finished '", pass->name(), "' on '",
                                    unit.getName(), "'.(elapsed time: ", duration.count(), "s",
                                    curr_pa.allPreserved() ? ", identical)" : ", modified)");
                }
            }
            if (++round > threshold) {
                Err::gassert(threshold_explicitly_set,
                             "Default Fixed point iteration threshold reached. Check the pipeline!"
                             " If this is intentionally, set the threshold explicitly.");
                break;
            }

            if (last_modified_pass == first_pass)
                break;
        }

        return pa;
    }

    void printPipeline() {
        std::string pipeline;
        for (const auto &[pass, ignoring_change] : passes)
            pipeline += std::string{pass->name()} + (ignoring_change ? " (ignoring change), " : ", ");
        if (!pipeline.empty()) {
            pipeline.pop_back();
            pipeline.pop_back();
        }
        Logger::logInfo("[FixedPointPM]: Running pipeline: ", pipeline);
    }
};

// Run this proxy pass to get the inner am
template <typename AnalysisManagerT, typename UnitT>
class InnerAnalysisManagerProxy : public AnalysisInfo<InnerAnalysisManagerProxy<AnalysisManagerT, UnitT>> {
public:
    class Result {
    public:
        explicit Result(AnalysisManagerT &inner_am_) : inner_am(&inner_am_) {}

        Result(Result &&arg) noexcept : inner_am(std::move(arg.inner_am)) { arg.inner_am = nullptr; }

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

        AnalysisManagerT &getManager() { return *inner_am; }

    private:
        AnalysisManagerT *inner_am;
    };

    explicit InnerAnalysisManagerProxy(AnalysisManagerT &InnerAM) : inner_am(&InnerAM) {}

    Result run(UnitT &, AnalysisManager<UnitT> &) { return Result(*inner_am); }

private:
    friend AnalysisInfo<InnerAnalysisManagerProxy<AnalysisManagerT, UnitT>>;
    static UniqueKey Key;
    AnalysisManagerT *inner_am;
};

template <typename AnalysisManagerT, typename UnitT> UniqueKey InnerAnalysisManagerProxy<AnalysisManagerT, UnitT>::Key;
} // namespace PM
#endif
