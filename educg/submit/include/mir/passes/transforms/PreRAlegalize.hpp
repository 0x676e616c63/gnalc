// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifndef GNALC_MIR_PASSES_PRERALEGALIZE_HPP
#define GNALC_MIR_PASSES_PRERALEGALIZE_HPP

#include "../pass_manager.hpp"

namespace MIR {

class PreRAlegalize : public PM::PassInfo<PreRAlegalize> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

///@todo need put in a fam
void preLegalizeFuncImpl(MIRFunction &, CodeGenContext &);

}; // namespace MIR_new

#endif