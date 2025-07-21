// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Inst Simplify Pass
// Common peephole optimizations on Instructions through algebraic simplification and strength reduction
//
// Note that this pass would destroy the LCSSA form unless `preserve_lcssa` is set.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP

#include "../../instructions/memory.hpp"
#include "../pass_manager.hpp"

namespace IR {
class InstSimplifyPass : public PM::PassInfo<InstSimplifyPass> {
public:
    explicit InstSimplifyPass(bool preserve_lcssa_ = false) : preserve_lcssa(preserve_lcssa_) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);

private:
    bool preserve_lcssa;
    size_t name_cnt = 0;
    FAM *fam;
    Function *func;
    std::string getTmpName();
    bool foldBinary(const pPhi &phi);
    bool foldGEP(const pPhi &phi);
    bool foldLoad(const pPhi &phi);
    bool isLoadSuitableForSinking(const pLoad &load) const;
};

} // namespace IR
#endif
