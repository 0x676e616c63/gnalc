// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_UTILS_HPP
#define GNALC_SIR_UTILS_HPP

#include "../ir/block_utils.hpp"
#include "base.hpp"

namespace SIR {
bool isMemoryLoopInvariant(Value* val, HELPERInst* loop);
bool isLoopInvariant(Value* val, HELPERInst* loop);
bool isMemoryLoopInvariant(const pVal& val, const pHelper& loop);
bool isLoopInvariant(const pVal& val, const pHelper& loop);
}

#endif