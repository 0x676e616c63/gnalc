// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_STACKGENERATE_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_STACKGENERATE_HPP

#include "mir/passes/pass_manager.hpp"

namespace MIR {

class StackGenerate : public PM::PassInfo<StackGenerate> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class StackGenerateImpl {
private:
    MIRFunction *mfunc;

public:
    void impl(MIRFunction &, FAM &);
};
}; // namespace MIR_new

#endif