// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Analysis Storer Pass
// This pass stores analysis result to Lower::gFunctionAnalysisStorage.
// It is used to transfer analysis result to MIR.
#pragma once
#ifndef GNALC_IR_PASSES_UTILITIES_ANALYSIS_STORER_HPP
#define GNALC_IR_PASSES_UTILITIES_ANALYSIS_STORER_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
template<typename ...Passes>
class StoreAnalysisPass : public PM::PassInfo<StoreAnalysisPass<Passes...>> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager) {
        (store_analysis_helper<Passes>(function, manager), ...);
        return PreserveAll();
    }

private:
    template <typename PassT>
    static void store_analysis_helper(Function &function, FAM &manager) {
        Lower::gFunctionAnalysisStorage.storeResult<PassT>(function, manager.getResult<PassT>(function));
    }
};
} // namespace IR
#endif
