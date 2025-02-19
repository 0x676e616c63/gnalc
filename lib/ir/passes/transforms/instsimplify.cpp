#include "../../../../include/ir/base.hpp"
#include "../../../../include/ir/pattern_match.hpp"
#include "../../../../include/ir/passes/transforms/instsimplify.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

using namespace PatternMatch;
namespace IR {
PM::PreservedAnalyses InstSimplifyPass::run(Function &function, FAM &fam) {
    bool instsimplify_inst_modified = false;

    for (const auto& bb : function) {
        for (const auto& inst : *bb) {
            std::shared_ptr<Value> other;
            if (match(inst, M::add(M::value(other), M::ci32(0)))
                || match(inst, M::add(M::ci32(0), M::value(other)))) {
                inst->replaceSelf(other);
                instsimplify_inst_modified = true;
            }
            else if (match(inst, M::mul(M::value(), M::ci32(0)))
                || match(inst, M::mul(M::ci32(0), M::value()))) {
                inst->replaceSelf(function.getConstantPool().getConst(0));
                instsimplify_inst_modified = true;
            }
            // To be continued
        }
    }

    if (instsimplify_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

} // namespace IR