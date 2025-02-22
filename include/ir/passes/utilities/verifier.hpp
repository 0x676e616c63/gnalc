// Function Verify Pass
// This pass verifies:
//   - If mutual use-def is valid
//   - If CFG is consistent with control-flow instructions
//   - If PhiNode is consistent with CFG
//   - If an Instruction dominated all its uses
// Note that some check will be skipped if there is a previous error.
// Otherwise, the compiler might abort during that check.
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_VERIFIER_HPP
#define GNALC_IR_PASSES_UTILITIES_VERIFIER_HPP

#include "../pass_manager.hpp"

namespace IR {
class VerifyPass : public PM::PassInfo<VerifyPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
