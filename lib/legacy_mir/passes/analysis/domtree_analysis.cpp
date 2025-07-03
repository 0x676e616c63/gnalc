// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/passes/analysis/domtree_analysis.hpp"

namespace LegacyMIR {
PM::UniqueKey DomTreeAnalysis::Key;

DomTree DomTreeAnalysis::run(Function &f, FAM &fam) {
    detail::DomTreeBuilder builder;
    builder.entry = f.getBlocks().front().get();
    builder.analyze();
    return builder.domtree;
}
} // namespace MIR

#endif