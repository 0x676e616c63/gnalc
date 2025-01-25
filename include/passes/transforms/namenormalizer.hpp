/**
* @brief 中端寄存器，基本块的重命名
*/

#pragma once

#ifndef GNALC_PASSES_TRANSFORMS_NAMENORMALIZER_HPP
#define GNALC_PASSES_TRANSFORMS_NAMENORMALIZER_HPP

#include "../../ir/visitor.hpp"
#include "../pass_manager.hpp"

namespace IR {

class NameNormalizePass : public PassInfo<NameNormalizePass>, public IRVisitor {
private:
  size_t curr_idx{0};
  bool bb_rename{false};
public:
  explicit NameNormalizePass(bool bb_rename_) : bb_rename(bb_rename_) {};
  void visit(Function& node) override;
  void visit(BasicBlock& node) override;

  PreservedAnalyses run(Function &function, FunctionAnalysisManager &manager);
};

}

#endif