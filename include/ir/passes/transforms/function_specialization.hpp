// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Function Specialization
// Reference:
//   - "Introducing Function Specialization, and can we enable it by default ?"
//       https://llvm.org/devmtg/2021-11/slides/2021-IntroducingFunctionSpecialisationAndCanWeEnableItByDefault.pdf
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_FUNCTION_SPECIALIZATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_FUNCTION_SPECIALIZATION_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
struct FuncSpecializationAttr : Attr::AttrInfo<FuncSpecializationAttr> {
    struct Specialization {
        // Original FormalParam -> Specialized Value
        std::map<FormalParam*, Value*> params;
        // Specialized Function
        Function* func;
    };
    std::vector<Specialization> specialized;
private:
    friend class AttrInfo<FuncSpecializationAttr>;
    static Attr::AttrKey Key;
};

class FunctionSpecializationPass : public PM::PassInfo<FunctionSpecializationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    size_t name_cnt = 0;
};
} // namespace IR
#endif
