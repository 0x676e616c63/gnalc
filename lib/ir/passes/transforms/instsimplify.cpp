#include "../../../../include/ir/passes/transforms/instsimplify.hpp"
#include "../../../../include/ir/base.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/helpers/constant_fold.hpp"
#include "../../../../include/ir/pattern_match.hpp"

using namespace PatternMatch;
namespace IR {
PM::PreservedAnalyses InstSimplifyPass::run(Function &function, FAM &fam) {
    bool instsimplify_inst_modified = false;
    for (const auto &bb : function) {
        foldPHI(bb);
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
            if (match(inst, M::inst_add(M::val_capture(other), M::val_is_i32(0))) ||
                match(inst, M::inst_add(M::val_is_i32(0), M::val_capture(other))) ||
                match(inst, M::inst_sub(M::val_capture(other), M::val_is_i32(0)))) {
                inst->replaceSelf(other);
                instsimplify_inst_modified = true;
            }
            // A - A = 0
            else if (match(inst, M::same_operands<OP::SUB, 2>())) {
                inst->replaceSelf(function.getConstantPool().getConst(0));
                instsimplify_inst_modified = true;
            } else if (match(inst, M::same_operands<OP::FSUB, 2>())) {
                inst->replaceSelf(function.getConstantPool().getConst(0.0f));
                instsimplify_inst_modified = true;
            }
            // A * 0 = 0
            // 0 * A = 0
            // 0 / A = 0
            // 0 % A = 0
            else if (match(inst, M::inst_mul(M::value(), M::val_is_i32(0))) ||
                     match(inst, M::inst_mul(M::val_is_i32(0), M::value())) ||
                     match(inst, M::inst_div(M::val_is_i32(0), M::value())) ||
                     match(inst, M::inst_rem(M::val_is_i32(0), M::value()))) {
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

    std::vector<std::shared_ptr<Instruction>> worklist;
    auto rpodfv = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    for (const auto &bb : rpodfv) {
        for (const auto &inst : *bb) {
            if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE)
                worklist.emplace_back(inst);
        }
    }
    while (!worklist.empty()) {
        auto inst = worklist.back();
        worklist.pop_back();

        std::shared_ptr<Value> other;
        int c1 = 0, c2 = 0;
        // (c1 - x) + c2 -> (c1 + c2) - x
        if (match(inst, M::inst_add(
            M::inst_sub(M::val_capture_i32(c1), M::val_capture(other)),
            M::val_capture_i32(c2)))) {
            auto sub = std::make_shared<BinaryInst>(inst->getName(), OP::SUB,
                                                    function.getConstantPool().getConst(c1 + c2), other);
            inst->replaceSelf(sub);
            inst->getParent()->addInst(inst->getIndex(), sub);
            instsimplify_inst_modified = true;
        }
        // todo x % c1 + ((x / c1) % c2) * c1 -> x % (c1 * c2)
        // todo x - -a -> x + a

        // c1 - (x + c2) -> (c1 - c2) - x
        else if (match(inst, M::inst_sub(M::val_capture_i32(c1), M::inst_add(M::val_capture_i32(c2), M::val_capture(other)))) ||
                 match(inst, M::inst_sub(M::val_capture_i32(c1), M::inst_add(M::val_capture(other), M::val_capture_i32(c2))))) {
            auto sub = std::make_shared<BinaryInst>(inst->getName(), OP::SUB,
                                                    function.getConstantPool().getConst(c1 - c2), other);
            inst->replaceSelf(sub);
            inst->getParent()->addInst(inst->getIndex(), sub);
            instsimplify_inst_modified = true;
        }
        // todo A * B - A*C -> A * (B-C)
        // todo - (x * c)= x * -c (for float)
    }

    if (instsimplify_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        pa.preserve<LoopAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

} // namespace IR