// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Machine Loop Invariant Code Motion
// Move loop invariant code to the loop's preheader or exits.
#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_LICM_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_LICM_HPP

#include "mir/passes/pass_manager.hpp"

namespace MIR {
class MachineLICMPass : public PM::PassInfo<MachineLICMPass> {
public:
    PM::PreservedAnalyses run(MIRFunction &function, FAM &manager);

private:
    size_t name_cnt = 0;
};

} // namespace IR
#endif
