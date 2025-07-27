// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_CODE_SINK_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CODE_SINK_HPP

#include "../pass_manager.hpp"

namespace IR {
class CodeSinkPass : public PM::PassInfo<CodeSinkPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
