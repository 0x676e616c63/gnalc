// Fold constant
#pragma once
#ifndef GNALC_IR_PASSES_HELPER_CONSTANT_FOLD_HPP
#define GNALC_IR_PASSES_HELPER_CONSTANT_FOLD_HPP

#include "../../base.hpp"
#include "../../basic_block.hpp"
#include "../../function.hpp"

namespace IR {
std::shared_ptr<Value> foldConstant(ConstantPool &cpool, const std::shared_ptr<Value> &raw);
} // namespace IR
#endif
