// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief loop unroll pass, include Fully Unroll, Runtime Unroll(Partial Unroll)
 * @note Other relative passes: Loop Peeling, Loop Unroll and Jam
 * @note Canonicalize Induction Variables will yield better performance.
 * @ref https://yashwantsingh.in/posts/loop-unroll/
 */

#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_UNROLL_HPP

#include <utility>

#include "ir/type_alias.hpp"
#include "ir/passes/pass_manager.hpp"
#include "config/config.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

namespace IR {
enum class UnrollAttr {
    Unrolled = 1 << 0, // All unrolled loop block except fully unroll
    NoRem = 1 << 1, // No remainder partially unroll, can be unrolled again
    RemBlock = 1 << 2, // Remainder loop, don't need to unroll

    DontUnroll = 1 << 3,
};

GNALC_ENUM_OPERATOR(UnrollAttr)
using UnrollAttrs = Attr::BitFlagsAttr<UnrollAttr>;

class LoopUnrollPass : public PM::PassInfo<LoopUnrollPass> {
    static constexpr unsigned PEC = Config::IR::LOOP_UNROLLING_PEEL_COUNT; // 循环剥皮最大次数
    static constexpr unsigned PES = Config::IR::LOOP_UNROLLING_PEEL_SIZE; // 循环剥皮最大大小
    static constexpr unsigned FUS = Config::IR::LOOP_UNROLLING_FULLY_UNROLL_SIZE; // // trip_count*size 小于等于此值次数的循环可能被完全展开
    static constexpr unsigned FUC = Config::IR::LOOP_UNROLLING_FULLY_UNROLL_COUNT; // trip_count 小于等于此值次数且满足上个条件的循环将被完全展开
    static constexpr unsigned PUS = Config::IR::LOOP_UNROLLING_PARTIALLY_UNROLL_SIZE; // 部分展开后最大大小
    static constexpr unsigned PUC = Config::IR::LOOP_UNROLLING_PARTIALLY_UNROLL_COUNT; // 部分展开最大次数
    static constexpr unsigned RUS = Config::IR::LOOP_UNROLLING_RUNTIME_UNROLL_SIZE; // 运行时展开后最大大小
    static constexpr unsigned RUC = Config::IR::LOOP_UNROLLING_RUNTIME_UNROLL_COUNT; // 运行时展开最大次数
    static constexpr unsigned MPS = Config::IR::LOOP_UNROLLING_MAX_PROCESS_SIZE; // 执行展开的最大循环大小，至多为上述各个 size 的 1/2
    // TODO: Runtime Unroll 成本控制（最小展开大小等）
    static constexpr bool ENABLE_PEELING = true;
    static constexpr bool ENABLE_FULLY_UNROLL = true;
    static constexpr bool ENABLE_PARTIALLY_UNROLL = true;
    static constexpr bool ENABLE_RUNTIME_UNROLL = true;

    static unsigned unroll_name_idx; // 用于防止跑多次unroll之后value重名
    static unsigned peel_name_idx;

    struct PeelOption {
        // For peel
        bool peel = false;
        unsigned peel_count = 0;

        void disable() {
            peel = false;
        }

        void enable_peel(const unsigned _count) {
            peel = true;
            peel_count = _count;
        }
    };

    enum class UnrollType { UNDEF, FULLY, PARTIALLY, RUNTIME };
    struct UnrollOption {
        // For unroll
        bool unroll = false;
        UnrollType unroll_type = UnrollType::UNDEF;
        unsigned unroll_count = 0;

        // For remainder
        bool has_remainder = false;
        unsigned remainder = 0;
        pVal raw_boundary_value = nullptr; // Raw boundary value in main loop
        pVal new_boundary_value = nullptr; // New boundary value in main loop

        // For runtime unroll
        pBlock prologue;
        pBlock epilogue;

        // // For cost analysis
        // unsigned raw_size = 0;
        // unsigned estimated_raw_size = 0; // 预估子循环展开后的原始大小
        // unsigned estimated_unroll_size = 0;
        //
        // // Misc
        // bool is_dowhile = false;
        // pLoop loop = nullptr;

        void disable() {
            unroll = false;
            // estimated_unroll_size = raw_size;
        }

        void enable_fully(const unsigned _count) {
            unroll = true;
            unroll_type = UnrollType::FULLY;
            unroll_count = _count;
            // estimated_unroll_size = _count * raw_size;
        }

        void enable_partially(const unsigned _count) {
            unroll = true;
            unroll_type = UnrollType::PARTIALLY;
            unroll_count = _count;
            has_remainder = false;
            // estimated_unroll_size = _count * raw_size;
        }

        void set_remainder(const unsigned _remainder, const pVal& _rawbv, const pVal &_newbv) {
            Err::gassert(unroll_type == UnrollType::PARTIALLY || unroll_type == UnrollType::RUNTIME
                , "UnrollOption: set_remainder(): unroll_type is not PARTIALLY or RUNTIME.");
            has_remainder = (_remainder!=0);
            remainder = _remainder;
            raw_boundary_value = _rawbv;
            new_boundary_value = _newbv;
            // estimated_unroll_size += raw_size;
        }

        void enable_runtime(const unsigned _count, const pBlock& _prologue, const pBlock& _epilogue) {
            unroll = true;
            unroll_type = UnrollType::RUNTIME;
            unroll_count = _count;
            has_remainder = true;
            prologue = _prologue;
            epilogue = _epilogue;
        }

        [[nodiscard]] bool fully() const { return unroll_type == UnrollType::FULLY; }
        [[nodiscard]] bool partially() const { return unroll_type == UnrollType::PARTIALLY; }
        [[nodiscard]] bool runtime() const { return unroll_type == UnrollType::RUNTIME; }
    };

    void peel_analyze(const pLoop &loop, PeelOption &option, Function &FC, FAM& fam);
    void unroll_analyze(const pLoop &loop, UnrollOption &option, Function &FC, FAM &fam);
    bool peel(const pLoop &loop, const PeelOption &option, Function &func);
    bool unroll(const pLoop &loop, const UnrollOption &option, Function &func, FAM &fam);

public:
    LoopUnrollPass();
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
