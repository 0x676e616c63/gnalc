// Fold constant
#pragma once
#ifndef GNALC_IR_PASSES_HELPER_CONSTANT_FOLD_HPP
#define GNALC_IR_PASSES_HELPER_CONSTANT_FOLD_HPP

#include "../../base.hpp"
#include "../../basic_block.hpp"
#include "../../function.hpp"

namespace IR {
pVal foldConstant(ConstantPool &cpool, const pVal &raw);
} // namespace IR
#endif
