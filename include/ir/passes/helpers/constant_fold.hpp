// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Fold constant
#pragma once
#ifndef GNALC_IR_PASSES_HELPER_CONSTANT_FOLD_HPP
#define GNALC_IR_PASSES_HELPER_CONSTANT_FOLD_HPP

#include "ir/base.hpp"
#include "ir/basic_block.hpp"
#include "ir/function.hpp"

namespace IR {
// Returns a constant, or the same value if failed.
// It does NOT perform any substitution.
pVal foldConstant(ConstantPool &cpool, const pVal &raw);
} // namespace IR
#endif
