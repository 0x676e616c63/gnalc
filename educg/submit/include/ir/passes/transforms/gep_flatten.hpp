// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Flatten getelementptr to arithmetic instructions
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_GEP_FLATTEN_HPP
#define GNALC_IR_PASSES_TRANSFORMS_GEP_FLATTEN_HPP

#include "../pass_manager.hpp"

namespace IR {
class GEPFlattenPass : public PM::PassInfo<GEPFlattenPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
