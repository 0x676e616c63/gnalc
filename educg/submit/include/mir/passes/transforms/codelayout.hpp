// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Code Layout Pass
//   - reorder basic blocks
// Reference:
//   - "Profile Guided Code Positioning Karl Pet& and Robert C. Hansen"
//       https://dl.acm.org/doi/pdf/10.1145/93542.93550
// TODO: Function Reorder, Function Split
#pragma once
#ifndef GNALC_MIR_TRANSFORMS_CODELAYOUT_HPP
#define GNALC_MIR_TRANSFORMS_CODELAYOUT_HPP

#include "../../MIR.hpp"
#include "../pass_manager.hpp"

namespace MIR {
class CodeLayoutPass : public PM::PassInfo<CodeLayoutPass> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

}

#endif