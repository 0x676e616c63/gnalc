#include "../../../../include/ir/passes/transforms/instsimplify.hpp"
#include "../../../../include/ir/base.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/helpers/constant_fold.hpp"
#include "../../../../include/ir/pattern_match.hpp"

using namespace PatternMatch;
namespace IR {
PM::PreservedAnalyses InstSimplifyPass::run(Function &function, FAM &fam) {
    bool instsimplify_inst_modified = false;
    for (const auto &bb : function) {
        for (const auto &inst : *bb) {
            // Fold Constant
            auto fold = foldConstant(function.getConstantPool(), inst);
            if (fold != inst) {
                inst->replaceSelf(fold);
                continue;
            }
            // Peephole
            std::shared_ptr<Value> other;
            // A + 0 -> A
            // 0 + A -> A
            // A - 0 -> A
            if (match(inst, M::add(M::value(other), M::ci32(0)))
                || match(inst, M::add(M::ci32(0), M::value(other)))
                || match(inst, M::sub(M::value(other), M::ci32(0)))) {
                inst->replaceSelf(other);
                instsimplify_inst_modified = true;
            }
            // A * 0 = 0
            // 0 * A = 0
            // 0 / A = 0
            // 0 % A = 0
            else if (match(inst, M::mul(M::value(), M::ci32(0)))
                || match(inst, M::mul(M::ci32(0), M::value()))
                || match(inst, M::div(M::ci32(0), M::value()))
                || match(inst, M::rem(M::ci32(0), M::value()))) {
                inst->replaceSelf(function.getConstantPool().getConst(0));
                instsimplify_inst_modified = true;
            }
            // icmp A, A -> true/false
            else if (match(inst, M::same_operands<OP::ICMP, 2>())) {
                auto icmp = std::dynamic_pointer_cast<ICMPInst>(inst);
                auto ci1true = function.getConstantPool().getConst(true);
                auto ci1false = function.getConstantPool().getConst(false);
                switch (icmp->getCond()) {
                case ICMPOP::eq:
                case ICMPOP::sge:
                case ICMPOP::sle:
                    inst->replaceSelf(ci1true);
                    instsimplify_inst_modified = true;
                    break;
                case ICMPOP::ne:
                case ICMPOP::sgt:
                case ICMPOP::slt:
                    inst->replaceSelf(ci1false);
                    instsimplify_inst_modified = true;
                    break;
                }
            }
            // fcmp A, A -> true/false
            else if (match(inst, M::same_operands<OP::FCMP, 2>())) {
                auto fcmp = std::dynamic_pointer_cast<FCMPInst>(inst);
                auto ci1true = function.getConstantPool().getConst(true);
                auto ci1false = function.getConstantPool().getConst(false);
                switch (fcmp->getCond()) {
                case FCMPOP::oeq:
                case FCMPOP::oge:
                case FCMPOP::ole:
                    inst->replaceSelf(ci1true);
                    instsimplify_inst_modified = true;
                    break;
                case FCMPOP::one:
                case FCMPOP::ogt:
                case FCMPOP::olt:
                    inst->replaceSelf(ci1false);
                    instsimplify_inst_modified = true;
                    break;
                default:
                    break;
                }
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