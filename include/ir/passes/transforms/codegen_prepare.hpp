// CodeGenPrepare
//   - Break all critical edges
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_CODEGEN_PREPARE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CODEGEN_PREPARE_HPP

#include "../pass_manager.hpp"

namespace IR {
class CodeGenPreparePass : public PM::PassInfo<CodeGenPreparePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
