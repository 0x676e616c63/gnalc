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
            if (match(inst, M::inst_add(M::value(other), M::value_ci32(0)))
                || match(inst, M::inst_add(M::value_ci32(0), M::value(other)))
                || match(inst, M::inst_sub(M::value(other), M::value_ci32(0)))) {
                inst->replaceSelf(other);
                instsimplify_inst_modified = true;
            }
            // A - A = 0
            else if (match(inst, M::same_operands<OP::SUB, 2>())) {
                inst->replaceSelf(function.getConstantPool().getConst(0));
                instsimplify_inst_modified = true;
            }
            else if (match(inst, M::same_operands<OP::FSUB, 2>())) {
                inst->replaceSelf(function.getConstantPool().getConst(0.0f));
                instsimplify_inst_modified = true;
            }
            // A * 0 = 0
            // 0 * A = 0
            // 0 / A = 0
            // 0 % A = 0
            else if (match(inst, M::inst_mul(M::value(), M::value_ci32(0)))
                || match(inst, M::inst_mul(M::value_ci32(0), M::value()))
                || match(inst, M::inst_div(M::value_ci32(0), M::value()))
                || match(inst, M::inst_rem(M::value_ci32(0), M::value()))) {
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

        std::deque<std::shared_ptr<Instruction>> worklist;
        auto dfVisitor=function.getDFVisitor();
    for (const auto & bb:dfVisitor) {
        for (const auto& inst:*bb) {
            switch (inst->getOpcode()) {
            case OP::BR:
            case OP::CALL:
            case OP::RET:
                //todo add more OPcode
                break;
                default:worklist.emplace_back(inst);
                break;
            }
        }
    }
    while (!worklist.empty()) {
        std::shared_ptr<Value> other;
        int c1=0,c2=0;
         auto inst=worklist.front();
            // add (sub c1 x) c2 ->sub (c1 + c2) x
            if (match(inst,M::inst_add(M::inst_sub(M::value_ci32(c1),M::value(other)),M::value_ci32(c2)))) {
                auto sub=std::make_shared<BinaryInst>(inst->getName(),OP::SUB,function.getConstantPool().getConst(c1+c2),other);
                inst->replaceSelf(sub);
                inst->getParent()->addInst(inst->getIndex(),sub);
            }
            // add (zext (add x -1)) 1 -> zext x (x !=0)
            else if (match(inst,M::inst_add(M::inst_add(M::inst_zext(M::value(other)),M::value_ci32(-1)),M::value_ci32(1)))) {
                //todo check for  zero
                inst->replaceSelf(other);
            }
            // zext(false) + c -> c
            else if (match(inst,M::inst_add(M::inst_zext(M::value_ci1(false)),M::value_ci32(c1)))) {
                inst->replaceSelf(function.getConstantPool().getConst(c1));
            }
            // zext(true) + c -> c + 1
            else if (match(inst,M::inst_add(M::inst_zext(M::value_ci1(true)),M::value_ci32(c1)))) {
                inst->replaceSelf(function.getConstantPool().getConst(c1+1));
            }

            // todo x % c1 + ((x / c1) % c2) * c1 -> x % (c1 * c2)
            // todo x - -a -> x + a

            // c1 - (x + c2) -> (c1 - c2) - x
            else if (match(inst,M::inst_sub(M::value_ci32(c1),M::inst_add(M::value_ci32(c2),M::value(other))))||
                match(inst,M::inst_sub(M::value_ci32(c1),M::inst_add(M::value(other),M::value_ci32(c2))))) {
                auto sub=std::make_shared<BinaryInst>(inst->getName(),OP::SUB,function.getConstantPool().getConst(c1-c2),other);
                inst->replaceSelf(sub);
                inst->getParent()->addInst(inst->getIndex(),sub);
            }
            // todo A * B - A*C -> A * (B-C)
            // todo - (x * c)= x * -c (for float)



        worklist.pop_front();
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