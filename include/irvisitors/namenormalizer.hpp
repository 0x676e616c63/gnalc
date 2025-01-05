/**
* @brief 中端寄存器，基本块的重命名
*/

#pragma once

#ifndef GNALC_NAMENORMALIZER_HPP
#define GNALC_NAMENORMALIZER_HPP

#include "../ir/visitor.hpp"

namespace IR {

// 通过Func中的insts划分基本块
class NameNormalizer : public IRVisitor {
private:
  size_t curr_idx{0};
  bool bb_rename{false};
public:
  NameNormalizer(bool bb_rename_) : bb_rename(bb_rename_) {};
  void visit(Function& node) override;
  void visit(BasicBlock& node) override;
  void normalize(const Module& module);
};

}

#endif