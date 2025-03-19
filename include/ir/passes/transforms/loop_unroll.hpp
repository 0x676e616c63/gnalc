/**
 * @brief loop unroll pass, include Fully Unroll, Runtime Unroll(Partial Unroll)
 * @note Other relative passes: Loop Peeling, Loop Unroll and Jam
 * @note Canonicalize Induction Variables will yield better performance.
 * @ref https://yashwantsingh.in/posts/loop-unroll/
 */

#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP

#include "../pass_manager.hpp"
// #include "../../../config/config.hpp"

// 之后放到config
// constexpr auto LOOP_UNROLLING_PEELING_COUNT = 5;
constexpr auto LOOP_UNROLLING_FULLY_UNROLL_THRESHOLD = 10;
constexpr auto LOOP_UNROLLING_RUNTIME_UNROLL_COUNT = 5;
// MAY NEED UNROLL COST THRESHOLD

namespace IR {
    class Loop;

    class LoopUnrollPass : public PM::PassInfo<LoopUnrollPass> {
    static constexpr auto fut = LOOP_UNROLLING_FULLY_UNROLL_THRESHOLD; // 完全展开阈值，小于此值次数的循环将被完全展开
    static constexpr auto rui = LOOP_UNROLLING_RUNTIME_UNROLL_COUNT; // 运行时展开（部分展开）强度

    // UNROLL MODE
    enum class UM {
        DISABLE,
        FULLY,
        PARTIALLY
    };

    // UNROLL LOOP INFO
    struct ULI {
        UM um;
        int count; // 展开次数
        bool has_remainder; // （仅用于运行时展开）是否有余数
        // TODO ...
    };

    ULI unroll_analyze(const std::shared_ptr<Loop>& loop);
    bool peel_loop(const std::shared_ptr<Loop> &loop); // 如果一个循环被剥离，则会被标记为不再检查进一步展开
    bool unroll_loop(const std::shared_ptr<Loop> &loop, int count, bool partially, bool has_remainder, Function &func);
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
