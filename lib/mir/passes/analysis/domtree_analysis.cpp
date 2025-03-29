#include "../../../../include/mir/passes/analysis/domtree_analysis.hpp"

namespace MIR {
PM::UniqueKey DomTreeAnalysis::Key;

DomTree DomTreeAnalysis::run(Function &f, FAM &fam) {
    detail::DomTreeBuilder builder;
    builder.entry = f.getBlocks().front().get();
    builder.analyze();
    return builder.domtree;
}
} // namespace MIR
