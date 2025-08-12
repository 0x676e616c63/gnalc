// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/loop_annotator.hpp"
#include "ir/instructions/compare.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/utils.hpp"

namespace SIR {
struct AnnotateVisitor : ContextVisitor {
    AffineAAResult* affine_aa;

    explicit AnnotateVisitor(AffineAAResult* affine_aa_) : affine_aa(affine_aa_) {}

    void visit(Context ctx, FORInst &for_inst) override {
        if (!affine_aa->hasLoopCarriedDependence(&for_inst)) {
            auto* attr = for_inst.attr().getOrAdd<LoopAttrs>();
            attr->set(LoopAttr::NoCarriedDependency);

            for_inst.appendDbgData("no-carried-dependency");
            Logger::logDebug("[LoopAnnotator]: Annotated affine for '", for_inst.getIndVar()->getName(),
                "' as NoCarriedDependency.");
        }

        ContextVisitor::visit(ctx, for_inst);
    }
};
PM::PreservedAnalyses LoopAnnotatorPass::run(LinearFunction &function, LFAM &lfam) {
    auto& affine_aa = lfam.getResult<AffineAliasAnalysis>(function);
    AnnotateVisitor visitor(&affine_aa);
    function.accept(visitor);
    return PreserveAll();
}
} // namespace SIR