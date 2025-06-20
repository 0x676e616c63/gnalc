#include "mir/passes/analysis/domtree_analysis.hpp"

using namespace MIR;

PM::UniqueKey DomTreeAnalysis::Key;

DomTree DomTreeAnalysis::run(MIRFunction &f, FAM &fam) {
    detail::DomTreeBuilder builder;
    builder.entry = f.EntryBlk().get();
    builder.analyze();
    return builder.domtree;
}