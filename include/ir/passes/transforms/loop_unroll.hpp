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

// 之后放到config
constexpr unsigned LOOP_UNROLLING_PEEL_COUNT = 10; // 循环剥皮最大次数
constexpr unsigned LOOP_UNROLLING_FULLY_UNROLL_SIZE = 400; // trip_count * size 小于此值次数的循环将被完全展开
constexpr unsigned LOOP_UNROLLING_FULLY_UNROLL_COUNT = 8; // trip_count小于此值次数的循环将被完全展开
constexpr unsigned LOOP_UNROLLING_RUNTIME_UNROLL_SIZE = 200; // 运行时展开后最大大小
constexpr unsigned LOOP_UNROLLING_RUNTIME_UNROLL_COUNT = 8; // 运行时展开最大次数
constexpr unsigned LOOP_UNROLLING_PARTIALLY_UNROLL_SIZE = 200;
constexpr unsigned LOOP_UNROLLING_PARTIALLY_UNROLL_COUNT = 8;
constexpr unsigned LOOP_UNROLLING_MAX_PROCESS_SIZE = 100; // 最大循环大小，超过此值的循环将不被展开，至少为上述size的1/2

namespace IR {
class LoopUnrollPass : public PM::PassInfo<LoopUnrollPass> {
    enum class UnrollType { FULLY, PARTIALLY, RUNTIME };
    struct UnrollOption {
        bool peel;
        unsigned peel_count;
        bool unroll;
        UnrollType unroll_type;
        unsigned unroll_count;
        bool has_remainder;
        unsigned remainder;

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

        void enable_partially(const unsigned _count, const unsigned _remainder = 0) {
            unroll = true;
            unroll_type = UnrollType::PARTIALLY;
            unroll_count = _count;
            has_remainder = (_remainder!=0);
            remainder = _remainder;
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
