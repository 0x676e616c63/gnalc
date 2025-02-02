/**
 * @brief 中端寄存器，基本块的重命名
 */

#pragma once

#ifndef GNALC_IR_PASSES_TRANSFORMS_NAMENORMALIZER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_NAMENORMALIZER_HPP

#include "../../visitor.hpp"
#include "../pass_manager.hpp"

namespace IR {

class NameNormalizePass : public PM::PassInfo<NameNormalizePass>,
                          public IRVisitor {
private:
    size_t curr_idx{0};
    bool bb_rename{false};

public:
    explicit NameNormalizePass(bool bb_rename_) : bb_rename(bb_rename_) {};
    void visit(Function &node) override;
    void visit(BasicBlock &node) override;

    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR

#endif