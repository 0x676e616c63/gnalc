// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_PARALLEL_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_PARALLEL_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
enum class ParallelAttr {
    NoParallel = 1 << 0,
    Parallelized = 1 << 1
};
GNALC_ENUM_OPERATOR(ParallelAttr)
using ParallelAttrs = Attr::BitFlagsAttr<ParallelAttr>;

class LoopParallelPass : public PM::PassInfo<LoopParallelPass> {
public:
    explicit LoopParallelPass(bool parallel_debug_message_ = false)
        : parallel_debug_message(parallel_debug_message_) {}

    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    static constexpr bool transform_float_reduction = false;
    static constexpr bool transform_local_reduction = false;
    static constexpr bool transform_scalar_gv = false;
    static constexpr bool conservative_dependency_test = false;

    bool parallel_debug_message = false;
    size_t name_cnt = 0;
};

} // namespace IR
#endif
