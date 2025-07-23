// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_UTILS_HPP
#define GNALC_SIR_UTILS_HPP

#include "ir/block_utils.hpp"
#include "sir/base.hpp"

namespace SIR {
bool isMemoryInvariantTo(Value* val, Value* item);
bool isMemoryInvariantTo(const pVal& val, const pVal& item);

bool isLoopInvariant(Value* val, HELPERInst* loop);
bool isLoopInvariant(const pVal& val, const pHelper& loop);

// SIR's mem2reg is too simple, and it doesn't have a GVN.
// Thus, only comparing Value's address doesn't work in many cases, since
// there are much full redundancy.
// However, it contains no phi, so a recursive comparison is enough.
bool isTriviallyIdentical(const pVal &lhs, const pVal &rhs);
} // namespace SIR

#endif