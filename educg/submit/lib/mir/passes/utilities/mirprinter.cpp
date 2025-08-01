// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/mir/passes/utilities/mirprinter.hpp"

#include "../../../../include/mir/passes/analysis/branch_freq_analysis.hpp"

namespace MIR {
PM::PreservedAnalyses PrintFunctionPass::run(MIRFunction &func, FAM &fam) {
    writeln("Function '", func.getmSym(), "':");
    for (const auto &blk : func.blks()) {
        writeln(blk->getmSym(), ":");
        for (const auto &inst : blk->Insts()) {
            write("  ", inst->dbgDump());
            const auto& dbg = inst->getDbgData();
            if (!dbg.empty()) {
                write("        ;" + dbg[0]);
                for (size_t i = 1; i < dbg.size(); ++i)
                    write(", " + dbg[i]);
            }
            writeln("");
        }
    }
    return PM::PreservedAnalyses::all();
}

PM::PreservedAnalyses PrintBranchFreqPass::run(MIRFunction &func, FAM &fam) {
    auto& freq = fam.getResult<BranchFreqAnalysis>(func);
    writeln("Branch Frequencies:");
    for (const auto &[edge, f] : freq.edge_freqs) {
        writeln("  ", edge.src->getmSym(), " -> ", edge.dest->getmSym(), ": ", f);
    }
    return PM::PreservedAnalyses::all();
}

} // namespace IR
