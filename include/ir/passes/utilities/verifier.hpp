// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Function Verify Pass
// This pass verifies:
//   - If mutual use-def is valid
//   - If all instructions' parent pointer is valid
//   - If CFG is consistent with control-flow instructions
//   - If PhiNode is consistent with CFG
//   - If an Instruction dominated all its uses
// Note that some check will be skipped if there is a previous error.
// Otherwise, the compiler might abort during that check.
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_VERIFIER_HPP
#define GNALC_IR_PASSES_UTILITIES_VERIFIER_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class VerifyPass : public PM::PassInfo<VerifyPass> {
private:
    bool abort_when_verify_failed;
    bool abort_when_warning_raised;

public:
    explicit VerifyPass(bool abort_when_verify_failed_ = false, bool abort_when_warning_raised_ = false)
        : abort_when_verify_failed(abort_when_verify_failed_), abort_when_warning_raised(abort_when_warning_raised_) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
