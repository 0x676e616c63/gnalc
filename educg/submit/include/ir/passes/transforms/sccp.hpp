// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Sparse Conditional Constant Propagation, making use of the generic one in
// `sparse_propagation.hpp`
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_SCCP_HPP
#define GNALC_IR_PASSES_TRANSFORMS_SCCP_HPP

#include "../pass_manager.hpp"

// TODO: make it inter procedural.
// Maybe split it into an analysis pass and two transform pass (one inter procedural)
namespace IR {
class SCCPPass : public PM::PassInfo<SCCPPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
