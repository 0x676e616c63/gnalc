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

    std::vector<std::shared_ptr<Instruction> > worklist;
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

        std::shared_ptr<Value> x = nullptr, y = nullptr, z = nullptr, temp1 = nullptr, temp2 = nullptr, temp3 = nullptr;
        int c1 = 0, c2 = 0;
        float fc1 = -0.0f;

        // (c1 - x) + c2 -> (c1 + c2) - x
        if (match(inst, M::inst_add(
                      M::inst_sub(M::val_capture_i32(c1), M::val_capture(x)),
                      M::val_capture_i32(c2)))) {
            auto sub = std::make_shared<BinaryInst>(inst->getName(), OP::SUB,
                                                    function.getConstantPool().getConst(c1 + c2), x);
            inst->replaceSelf(sub);
            inst->getParent()->addInst(inst->getIndex(), sub);
            instsimplify_inst_modified = true;
        }
        // x % y + ((x / y) % z) * y -> x % (y * z)
        else if (match(inst, M::inst_add(M::inst_rem(M::val_capture(x), M::val_capture(y)),
                                         M::inst_mul(
                                             M::inst_rem(M::inst_div(M::val_capture(temp2), M::val_capture(temp3)),
                                                         M::val_capture(z)),
                                             M::val_capture(temp1)))) && temp1 == y && temp2 == x && y == temp3) {
            auto mul = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::MUL, y, z);
            auto rem = std::make_shared<BinaryInst>(inst->getName(), OP::REM, x, mul);
            inst->replaceSelf(rem);
            inst->getParent()->addInst(inst->getIndex(), mul);
            inst->getParent()->addInst(inst->getIndex(), rem);
            instsimplify_inst_modified = true;
        }
        // x + -x = 0
        else if (match(inst, M::inst_add(M::val_capture(x), M::inst_sub(M::val_is_i32(0), M::val_capture(temp1)))) && x
                 ==
                 temp1) {
            inst->replaceSelf(function.getConstantPool().getConst(0));
            instsimplify_inst_modified = true;
        }
        // x - -y -> x + y
        else if (match(inst, M::inst_sub(M::val_capture(x), M::inst_sub(M::val_is_i32(0), M::val_capture(y))))) {
            auto add = std::make_shared<BinaryInst>(inst->getName(), OP::ADD, x, y);
            inst->replaceSelf(add);
            inst->getParent()->addInst(inst->getIndex(), add);
            instsimplify_inst_modified = true;
        }
        // c1 - (x + c2) -> (c1 - c2) - x
        else if (match(inst, M::inst_sub(M::val_capture_i32(c1),
                                         M::inst_add(M::val_capture_i32(c2), M::val_capture(temp1)))) ||
                 match(inst, M::inst_sub(M::val_capture_i32(c1),
                                         M::inst_add(M::val_capture(temp1), M::val_capture_i32(c2))))) {
            auto sub = std::make_shared<BinaryInst>(inst->getName(), OP::SUB,
                                                    function.getConstantPool().getConst(c1 - c2), temp1);
            inst->replaceSelf(sub);
            inst->getParent()->addInst(inst->getIndex(), sub);
            instsimplify_inst_modified = true;
        }
        // x + (y - x) or (y - x) + x -> y
        else if (match(inst, M::inst_add(M::val_capture(x), M::inst_sub(M::val_capture(y), M::val_capture(temp1)))) ||
                 match(inst, M::inst_add(M::inst_sub(M::val_capture(y), M::val_capture(temp1)), M::val_capture(x))) && x
                 == temp1) {
            inst->replaceSelf(y);
            instsimplify_inst_modified = true;
        }
        // x * y - x * z -> x * (y - z)
        else if (match(inst, M::inst_sub(M::inst_mul(M::val_capture(x), M::val_capture(y)),
                                         M::inst_mul(M::val_capture(temp1), M::val_capture(z)))) && x == temp1) {
            auto sub = std::make_shared<
                BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::SUB, y, z);
            auto mul = std::make_shared<BinaryInst>(inst->getName(), OP::MUL, x, sub);
            inst->replaceSelf(mul);
            inst->getParent()->addInst(inst->getIndex(), sub);
            inst->getParent()->addInst(inst->getIndex(), mul);
            instsimplify_inst_modified = true;
        }
        // (x * x) - (y * y) -> (x + y) * (x - y)
        else if (match(inst, M::inst_sub(M::inst_mul(M::val_capture(x), M::val_capture(temp1)),
                                         M::inst_mul(M::val_capture(y), M::val_capture(temp2)))) && x == temp1 && y ==
                 temp2) {
            auto add = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::ADD, x, y);
            auto sub = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::SUB, x, y);
            auto mul = std::make_shared<BinaryInst>(inst->getName(), OP::MUL, add, sub);
            inst->replaceSelf(mul);
            inst->getParent()->addInst(inst->getIndex(), add);
            inst->getParent()->addInst(inst->getIndex(), sub);
            inst->getParent()->addInst(inst->getIndex(), mul);
            instsimplify_inst_modified = true;
        }
        // float: -x + y -> y - x
        else if (match(inst, M::inst_fadd(M::inst_fneg(M::val_capture(x)), M::val_capture(y)))) {
            auto fsub = std::make_shared<BinaryInst>(inst->getName(), OP::FSUB, y, x);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: (-x * y) + z -> z - (x * y)
        else if (match(inst, M::inst_fadd(M::inst_fmul(M::inst_fneg(M::val_capture(x)), M::val_capture(y)),
                                          M::val_capture(z)))) {
            auto fmul = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::FMUL, x, y);
            auto fsub = std::make_shared<BinaryInst>(inst->getName(), OP::FSUB, z, fmul);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fmul);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: (-x / y) + z or (x / -y) + z -> z - (x / y)
        else if (match(inst, M::inst_fadd(M::inst_fdiv(M::inst_fneg(M::val_capture(x)), M::val_capture(y)),
                                          M::val_capture(z))) ||
                 match(inst, M::inst_fadd(M::inst_fdiv(M::val_capture(x), M::inst_fneg(M::val_capture(y))),
                                          M::val_capture(z)))) {
            auto fdiv = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::FDIV, x, y);
            auto fsub = std::make_shared<BinaryInst>(inst->getName(), OP::FSUB, z, fdiv);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fdiv);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: (sitofp x) + (sitofp y) -> sitofp(x + y)
        else if (match(inst, M::inst_fadd(M::inst_sitosf(M::val_capture(x)), M::inst_sitosf(M::val_capture(y))))) {
            auto fadd = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::FADD, x, y);
            auto sitosf = std::make_shared<SITOFPInst>(inst->getName(), fadd);
            inst->replaceSelf(sitosf);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            inst->getParent()->addInst(inst->getIndex(), sitosf);
            instsimplify_inst_modified = true;
        }
        // float: -(x * c) -> x * -c
        //        -(x / c) -> x / -c
        //        -(c / x) -> -c / x
        else if (match(inst, M::inst_fneg(M::one_use(M::inst())))) {
            if (match(inst, M::inst_fneg(M::inst_fmul(M::val_capture(x), M::val_capture_f32(fc1))))) {
                auto fmul = std::make_shared<BinaryInst>(inst->getName(), OP::FMUL, x,
                                                         function.getConstantPool().getConst(-fc1));
                inst->replaceSelf(fmul);
                inst->getParent()->addInst(inst->getIndex(), fmul);
                instsimplify_inst_modified = true;
            }
            if (match(inst, M::inst_fneg(M::inst_fdiv(M::val_capture(x), M::val_capture_f32(fc1))))) {
                auto fdiv = std::make_shared<BinaryInst>(inst->getName(), OP::FDIV, x,
                                                         function.getConstantPool().getConst(-fc1));
                inst->replaceSelf(fdiv);
                inst->getParent()->addInst(inst->getIndex(), fdiv);
                instsimplify_inst_modified = true;
            }
            if (match(inst, M::inst_fneg(M::inst_fdiv(M::val_capture_f32(fc1), M::val_capture(x))))) {
                auto fdiv = std::make_shared<BinaryInst>(inst->getName(), OP::FDIV,
                                                         function.getConstantPool().getConst(-fc1), x);
                inst->replaceSelf(fdiv);
                inst->getParent()->addInst(inst->getIndex(), fdiv);
                instsimplify_inst_modified = true;
            }
        }
        // float: -(x * y) -> (-x * y)
        else if (match(inst, M::inst_fneg(M::inst_fmul(M::val_capture(x), M::val_capture(y)))) ||
                 match(inst, M::inst_fneg(M::inst_fdiv(M::val_capture(x), M::val_capture(y))))) {
            auto fneg = std::make_shared<FNEGInst>("%instsimplify.tmp" + std::to_string(name_cnt++), x);
            auto fmul = std::make_shared<BinaryInst>(inst->getName(), inst->getOpcode(), fneg, y);
            inst->replaceSelf(fmul);
            inst->getParent()->addInst(inst->getIndex(), fneg);
            inst->getParent()->addInst(inst->getIndex(), fmul);
            instsimplify_inst_modified = true;
        }
        // float: -(x / y) -> (-x / y)
        else if (match(inst, M::inst_fneg(M::inst_fdiv(M::val_capture(x), M::val_capture(y))))) {
            auto fneg = std::make_shared<FNEGInst>("%instsimplify.tmp" + std::to_string(name_cnt++), x);
            auto fdiv = std::make_shared<BinaryInst>(inst->getName(), inst->getOpcode(), fneg, y);
            inst->replaceSelf(fdiv);
            inst->getParent()->addInst(inst->getIndex(), fneg);
            inst->getParent()->addInst(inst->getIndex(), fdiv);
            instsimplify_inst_modified = true;
        }
        // float: fsub -0.0, x → fneg x
        else if (match(inst, M::inst_fsub(M::val_is_f32(-0.0f), M::val_capture(x)))) {
            auto fsub = std::make_shared<FNEGInst>(inst->getName(), x);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: x - -y -> x + y
        else if (match(inst, M::inst_fsub(M::val_capture(x), M::inst_fneg(M::val_capture(y))))) {
            auto fadd = std::make_shared<BinaryInst>(inst->getName(), OP::FADD, x, y);
            inst->replaceSelf(fadd);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            instsimplify_inst_modified = true;
        }
        // float: x - (-y * z) → x + (y * z)
        else if (match(inst, M::inst_fsub(M::val_capture(x),
                                          M::inst_fmul(M::inst_fneg(M::val_capture(y)), M::val_capture(z))))
        ) {
            auto fmul = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::FMUL, y, z);
            auto fadd = std::make_shared<BinaryInst>(inst->getName(), OP::FADD, x, fmul);
            inst->replaceSelf(fadd);
            inst->getParent()->addInst(inst->getIndex(), fmul);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            instsimplify_inst_modified = true;
        }
        // float: x - (-y / z) → x + (y / z)
        else if (match(inst, M::inst_fsub(M::val_capture(x),
                                          M::inst_fdiv(M::inst_fneg(M::val_capture(y)), M::val_capture(z))))) {
            auto fdiv = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::FDIV, y, z);
            auto fadd = std::make_shared<BinaryInst>(inst->getName(), OP::FADD, x, fdiv);
            inst->replaceSelf(fadd);
            inst->getParent()->addInst(inst->getIndex(), fdiv);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            instsimplify_inst_modified = true;
        }
        // float: (x - y) - z → x - (y + z)
        else if (match(inst, M::inst_fsub(M::inst_fsub(M::val_capture(x), M::val_capture(y)), M::val_capture(z)))) {
            auto fadd = std::make_shared<BinaryInst>("%instsimplify.tmp" + std::to_string(name_cnt++), OP::FADD, y, z);
            auto fsub = std::make_shared<BinaryInst>(inst->getName(), OP::FSUB, x, fadd);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: x + -x -> 0
        else if (match(inst, M::inst_fadd(M::val_capture(x), M::inst_fneg(M::val_capture(temp1)))) && x == temp1) {
            inst->replaceSelf(function.getConstantPool().getConst(-0.0f));
        }
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