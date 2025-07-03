// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief 中端寄存器，基本块的重命名
 */
#pragma once

#ifndef GNALC_IR_PASSES_TRANSFORMS_NAMENORMALIZER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_NAMENORMALIZER_HPP

#include "ir/visitor.hpp"
#include "ir/passes/pass_manager.hpp"

namespace IR {

class NameNormalizePass : public PM::PassInfo<NameNormalizePass>, public IRVisitor {
    size_t curr_idx;
    bool bb_rename;

public:
    explicit NameNormalizePass(bool bb_rename_ = true) : bb_rename(bb_rename_), curr_idx(0) {}
    void visit(Function &node) override;
    void visit(BasicBlock &node) override;
    void visit(Module &node) override;

    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR

#endif