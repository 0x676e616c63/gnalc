// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_UTILS_HPP
#define GNALC_SIR_UTILS_HPP

#include "../ir/block_utils.hpp"
#include "base.hpp"
#include "visitor.hpp"

namespace SIR {
bool isMemoryInvariantTo(Value* val, Value* item);
bool isMemoryInvariantTo(const pVal& val, const pVal& item);

bool containsInLoop(const std::unordered_set<pVal>& vals, HELPERInst* loop);

bool isUseDefInvariantTo(Value* val, HELPERInst* loop);
bool isUseDefInvariantTo(const pVal& val, const pHelper& loop);

// SIR's mem2reg is too simple, and it doesn't have a GVN.
// Thus, only comparing Value's address doesn't work in many cases, since
// there are much full redundancy.
// However, since it contains no phi, so a recursive comparison is enough.
bool isTriviallyIdentical(const pVal &lhs, const pVal &rhs);
bool isTriviallyIdentical(Value* lhs, Value* rhs);

struct CountInstVistor : Visitor {
    size_t count = 0;
    void visit(Instruction &inst) override {
        ++count;
        Visitor::visit(inst);
    }
};

bool hasNonMemorySideEffect(Instruction *inst);
bool hasNonMemorySideEffect(const pInst &inst);
} // namespace SIR

#endif