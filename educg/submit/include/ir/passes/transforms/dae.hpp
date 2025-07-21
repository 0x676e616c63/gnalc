// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Dead Argument Elimination
// This pass tries to replace function params with Global Variables or Constants and eliminate no-use params.
// FIXME: Caller function's analysis should be invalidated. (though analyses so far do not need this)
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DAE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DAE_HPP

#include "../pass_manager.hpp"

namespace IR {
class DAEPass : public PM::PassInfo<DAEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    size_t name_cnt = 0;
};

} // namespace IR
#endif
