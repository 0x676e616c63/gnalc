// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// CodeGenPrepare
//   - Convert select to branch if target not supported
//   - Break all critical edges
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_CODEGEN_PREPARE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CODEGEN_PREPARE_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class CodeGenPreparePass : public PM::PassInfo<CodeGenPreparePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
