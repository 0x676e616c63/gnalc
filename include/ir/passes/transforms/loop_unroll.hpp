/**
 * @brief loop unroll pass, include Fully Unroll, Runtime Unroll(Partial Unroll)
 * @note Other relative passes: Loop Peeling, Loop Unroll and Jam
 * @note Canonicalize Induction Variables will yield better performance.
 * @ref https://yashwantsingh.in/posts/loop-unroll/
 */

#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP

#include "ir/passes/pass_manager.hpp"
#include "config/config.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

namespace IR {
class LoopUnrollPass : public PM::PassInfo<LoopUnrollPass> {
    static constexpr unsigned PEC = Config::IR::LOOP_UNROLLING_PEEL_COUNT;
    static constexpr unsigned FUS = -1;
    static constexpr unsigned FUC = -1;
    static constexpr unsigned PUS = Config::IR::LOOP_UNROLLING_PARTIALLY_UNROLL_SIZE;
    static constexpr unsigned PUC = Config::IR::LOOP_UNROLLING_PARTIALLY_UNROLL_COUNT;
    static constexpr unsigned RUS = Config::IR::LOOP_UNROLLING_RUNTIME_UNROLL_SIZE;
    static constexpr unsigned RUC = Config::IR::LOOP_UNROLLING_RUNTIME_UNROLL_COUNT;
    static constexpr unsigned MPS = -1;
    static constexpr bool ENABLE_PEELING = false;
    static constexpr bool ENABLE_FULLY_UNROLL = false;
    static constexpr bool ENABLE_PARTIALLY_UNROLL = true;
    static constexpr bool ENABLE_RUNTIME_UNROLL = false;

    enum class UnrollType { FULLY, PARTIALLY, RUNTIME };
    struct UnrollOption {
        bool peel = false;
        unsigned peel_count = 0;
        bool unroll = false;
        UnrollType unroll_type;
        unsigned unroll_count = 0;
        bool has_remainder = false;
        unsigned remainder = 0;
        pVal new_trip_countv; // For partially unroll with remainder, new trip count value in unroll loop
        pVal raw_trip_countv; // For constant trip count, raw trip count value in original loop

        void disable() {
            peel = false;
            unroll = false;
        }

        void enable_peel(const unsigned _count) {
            peel = true;
            peel_count = _count;
        }

        void enable_fully(const unsigned _count) {
            unroll = true;
            unroll_type = UnrollType::FULLY;
            unroll_count = _count;
        }

        void enable_partially(const unsigned _count) {
            unroll = true;
            unroll_type = UnrollType::PARTIALLY;
            unroll_count = _count;
            has_remainder = false;
        }

        void set_remainder(const unsigned _remainder, const pVal _new_trip_countv) {
            Err::gassert(unroll_type == UnrollType::PARTIALLY, "UnrollOption: set_remainder(): unroll_type is not PARTIALLY.");
            has_remainder = (_remainder!=0);
            remainder = _remainder;
            new_trip_countv = _new_trip_countv;
        }

        void enable_runtime(const unsigned _count) {
            unroll = true;
            unroll_type = UnrollType::RUNTIME;
            unroll_count = _count;
            has_remainder = true;
        }

        bool fully() const { return unroll_type == UnrollType::FULLY; }
        bool partially() const { return unroll_type == UnrollType::PARTIALLY; }
        bool runtime() const { return unroll_type == UnrollType::RUNTIME; }
    };

    void analyze(const pLoop &loop, UnrollOption &option, LoopInfo& LI, Function &func, DomTree &DT);
    bool peel(const pLoop &loop, const UnrollOption &option, Function &func);
    bool unroll(const pLoop &loop, const UnrollOption &option, Function &func);

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
