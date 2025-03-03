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
            std::shared_ptr<Value> x;
            // x + 0 -> x
            // 0 + x -> x
            // x - 0 -> x
            if (match(inst, M::Add(M::VBind(x), M::Is(0))) || match(inst, M::Add(M::Is(0), M::VBind(x))) ||
                match(inst, M::Sub(M::VBind(x), M::Is(0)))) {
                inst->replaceSelf(x);
                instsimplify_inst_modified = true;
            }
            // x - x = 0
            else if (match(inst, M::Sub(M::VBind(x), M::Is(x)))) {
                inst->replaceSelf(function.getConst(0));
                instsimplify_inst_modified = true;
            } else if (match(inst, M::Fsub(M::VBind(x), M::Is(x)))) {
                inst->replaceSelf(function.getConst(0.0f));
                instsimplify_inst_modified = true;
            }
            // x * 0 = 0
            // 0 * x = 0
            // 0 / x = 0
            // 0 % x = 0
            else if (match(inst, M::Mul(M::Val(), M::Is(0))) || match(inst, M::Mul(M::Is(0), M::Val())) ||
                     match(inst, M::Div(M::Is(0), M::Val())) || match(inst, M::Rem(M::Is(0), M::Val()))) {
                inst->replaceSelf(function.getConst(0));
                instsimplify_inst_modified = true;
            }
            // icmp x, x -> true/false
            else if (match(inst, M::Icmp(M::VBind(x), M::Is(x)))) {
                auto icmp = std::dynamic_pointer_cast<ICMPInst>(inst);
                auto ci1true = function.getConst(true);
                auto ci1false = function.getConst(false);
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
            // fcmp x, x -> true/false
            else if (match(inst, M::Fcmp(M::VBind(x), M::Is(x)))) {
                auto fcmp = std::dynamic_pointer_cast<FCMPInst>(inst);
                auto ci1true = function.getConst(true);
                auto ci1false = function.getConst(false);
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

        std::shared_ptr<Value> x, y, z;
        int c1 = 0, c2 = 0;
        float fc1 = -0.0f;

        // (c1 - x) + c2 -> (c1 + c2) - x
        if (match(inst, M::Add(M::Sub(M::I32Bind(c1), M::VBind(x)), M::I32Bind(c2)))) {
            auto sub = std::make_shared<BinaryInst>(getTmp(), OP::SUB,
                                                    function.getConst(c1 + c2), x);
            inst->replaceSelf(sub);
            inst->getParent()->addInst(inst->getIndex(), sub);
            instsimplify_inst_modified = true;
        }
        // x % y + ((x / y) % z) * y -> x % (y * z)
        else if (match(inst, M::Add(M::Rem(M::VBind(x), M::VBind(y)), // x % y +
                                    M::Mul(M::Rem(M::Div(M::Is(x), M::Is(y)), M::VBind(z)),
                                           M::Is(y))))) { // ((x / y) % z) * y
            auto mul = std::make_shared<BinaryInst>(getTmp(), OP::MUL, y, z);
            auto rem = std::make_shared<BinaryInst>(getTmp(), OP::REM, x, mul);
            inst->replaceSelf(rem);
            inst->getParent()->addInst(inst->getIndex(), mul);
            inst->getParent()->addInst(inst->getIndex(), rem);
            instsimplify_inst_modified = true;
        }
        // x + -x = 0
        else if (match(inst, M::Add(M::VBind(x), M::Sub(M::Is(0), M::Is(x))))) {
            inst->replaceSelf(function.getConst(0));
            instsimplify_inst_modified = true;
        }
        // x - -y -> x + y
        else if (match(inst, M::Sub(M::VBind(x), M::Sub(M::Is(0), M::VBind(y))))) {
            auto add = std::make_shared<BinaryInst>(getTmp(), OP::ADD, x, y);
            inst->replaceSelf(add);
            inst->getParent()->addInst(inst->getIndex(), add);
            instsimplify_inst_modified = true;
        }
        // c1 - (x + c2) -> (c1 - c2) - x
        else if (match(inst, M::Sub(M::I32Bind(c1), M::Add(M::VBind(x), M::I32Bind(c2)))) ||
                 match(inst, M::Sub(M::I32Bind(c1), M::Add(M::I32Bind(c2), M::VBind(x))))) {
            auto sub = std::make_shared<BinaryInst>(getTmp(), OP::SUB,
                                                    function.getConst(c1 - c2), x);
            inst->replaceSelf(sub);
            inst->getParent()->addInst(inst->getIndex(), sub);
            instsimplify_inst_modified = true;
        }
        // x + (y - x) or (y - x) + x -> y
        else if (match(inst, M::Add(M::VBind(x), M::Sub(M::VBind(y), M::Is(x)))) ||
                 match(inst, M::Add(M::Sub(M::VBind(y), M::VBind(x)), M::Is(x)))) {
            inst->replaceSelf(y);
            instsimplify_inst_modified = true;
        }
        // x * y - x * z -> x * (y - z)
        else if (match(inst, M::Sub(M::Mul(M::VBind(x), M::VBind(y)), M::Mul(M::Is(x), M::VBind(z))))) {
            auto sub = std::make_shared<BinaryInst>(getTmp(), OP::SUB, y, z);
            auto mul = std::make_shared<BinaryInst>(getTmp(), OP::MUL, x, sub);
            inst->replaceSelf(mul);
            inst->getParent()->addInst(inst->getIndex(), sub);
            inst->getParent()->addInst(inst->getIndex(), mul);
            instsimplify_inst_modified = true;
        }
        // (x * x) - (y * y) -> (x + y) * (x - y)
        else if (match(inst, M::Sub(M::Mul(M::VBind(x), M::Is(x)), M::Mul(M::VBind(y), M::Is(y))))) {
            auto add = std::make_shared<BinaryInst>(getTmp(), OP::ADD, x, y);
            auto sub = std::make_shared<BinaryInst>(getTmp(), OP::SUB, x, y);
            auto mul = std::make_shared<BinaryInst>(getTmp(), OP::MUL, add, sub);
            inst->replaceSelf(mul);
            inst->getParent()->addInst(inst->getIndex(), add);
            inst->getParent()->addInst(inst->getIndex(), sub);
            inst->getParent()->addInst(inst->getIndex(), mul);
            instsimplify_inst_modified = true;
        }
        // float: -x + y -> y - x
        else if (match(inst, M::Fadd(M::Fneg(M::VBind(x)), M::VBind(y)))) {
            auto fsub = std::make_shared<BinaryInst>(getTmp(), OP::FSUB, y, x);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: (-x * y) + z -> z - (x * y)
        else if (match(inst, M::Fadd(M::Fmul(M::Fneg(M::VBind(x)), M::VBind(y)), M::VBind(z)))) {
            auto fmul = std::make_shared<BinaryInst>(getTmp(), OP::FMUL, x, y);
            auto fsub = std::make_shared<BinaryInst>(getTmp(), OP::FSUB, z, fmul);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fmul);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: (-x / y) + z or (x / -y) + z -> z - (x / y)
        else if (match(inst, M::Fadd(M::Fdiv(M::Fneg(M::VBind(x)), M::VBind(y)), M::VBind(z))) ||
                 match(inst, M::Fadd(M::Fdiv(M::VBind(x), M::Fneg(M::VBind(y))), M::VBind(z)))) {
            auto fdiv = std::make_shared<BinaryInst>(getTmp(), OP::FDIV, x, y);
            auto fsub = std::make_shared<BinaryInst>(getTmp(), OP::FSUB, z, fdiv);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fdiv);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: (sitofp x) + (sitofp y) -> sitofp(x + y)
        else if (match(inst, M::Fadd(M::Sitofp(M::VBind(x)), M::Sitofp(M::VBind(y))))) {
            auto fadd = std::make_shared<BinaryInst>(getTmp(), OP::FADD, x, y);
            auto sitofp = std::make_shared<SITOFPInst>(getTmp(), fadd);
            inst->replaceSelf(sitofp);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            inst->getParent()->addInst(inst->getIndex(), sitofp);
            instsimplify_inst_modified = true;
        }
        // float: -(x * c) -> x * -c
        //        -(x / c) -> x / -c
        //        -(c / x) -> -c / x
        else if (match(inst, M::Fneg(M::OneUse(M::Inst())))) {
            if (match(inst, M::Fneg(M::Fmul(M::VBind(x), M::F32Bind(fc1))))) {
                auto fmul = std::make_shared<BinaryInst>(getTmp(),
                    OP::FMUL, x, function.getConst(-fc1));
                inst->replaceSelf(fmul);
                inst->getParent()->addInst(inst->getIndex(), fmul);
                instsimplify_inst_modified = true;
            }
            if (match(inst, M::Fneg(M::Fdiv(M::VBind(x), M::F32Bind(fc1))))) {
                auto fdiv = std::make_shared<BinaryInst>(getTmp(),
                    OP::FDIV, x, function.getConst(-fc1));
                inst->replaceSelf(fdiv);
                inst->getParent()->addInst(inst->getIndex(), fdiv);
                instsimplify_inst_modified = true;
            }
            if (match(inst, M::Fneg(M::Fdiv(M::F32Bind(fc1), M::VBind(x))))) {
                auto fdiv = std::make_shared<BinaryInst>(getTmp(),
                    OP::FDIV, function.getConst(-fc1), x);
                inst->replaceSelf(fdiv);
                inst->getParent()->addInst(inst->getIndex(), fdiv);
                instsimplify_inst_modified = true;
            }
        }
        // float: -(x * y) -> (-x * y) or -(x / y)  -> (-x / y)
        else if (match(inst, M::Fneg(M::Fmul(M::VBind(x), M::VBind(y)))) ||
                 match(inst, M::Fneg(M::Fdiv(M::VBind(x), M::VBind(y))))) {
            auto fneg = std::make_shared<FNEGInst>(getTmp(), x);
            auto fbin = std::make_shared<BinaryInst>(getTmp(), inst->getOpcode(), fneg, y);
            inst->replaceSelf(fbin);
            inst->getParent()->addInst(inst->getIndex(), fneg);
            inst->getParent()->addInst(inst->getIndex(), fbin);
            instsimplify_inst_modified = true;
        }
        // float: fsub -0.0, x → fneg x
        else if (match(inst, M::Fsub(M::Is(-0.0f), M::VBind(x)))) {
            auto fsub = std::make_shared<FNEGInst>(getTmp(), x);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: x - (-y) -> x + y
        else if (match(inst, M::Fsub(M::VBind(x), M::Fneg(M::VBind(y))))) {
            auto fadd = std::make_shared<BinaryInst>(getTmp(), OP::FADD, x, y);
            inst->replaceSelf(fadd);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            instsimplify_inst_modified = true;
        }
        // float: x - (-y * z) -> x + (y * z)
        else if (match(inst, M::Fsub(M::VBind(x), M::Fmul(M::Fneg(M::VBind(y)), M::VBind(z))))) {
            auto fmul = std::make_shared<BinaryInst>(getTmp(), OP::FMUL, y, z);
            auto fadd = std::make_shared<BinaryInst>(getTmp(), OP::FADD, x, fmul);
            inst->replaceSelf(fadd);
            inst->getParent()->addInst(inst->getIndex(), fmul);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            instsimplify_inst_modified = true;
        }
        // float: x - (-y / z) -> x + (y / z)
        else if (match(inst, M::Fsub(M::VBind(x), M::Fdiv(M::Fneg(M::VBind(y)), M::VBind(z))))) {
            auto fdiv = std::make_shared<BinaryInst>(getTmp(), OP::FDIV, y, z);
            auto fadd = std::make_shared<BinaryInst>(getTmp(), OP::FADD, x, fdiv);
            inst->replaceSelf(fadd);
            inst->getParent()->addInst(inst->getIndex(), fdiv);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            instsimplify_inst_modified = true;
        }
        // float: (x - y) - z → x - (y + z)
        else if (match(inst, M::Fsub(M::Fsub(M::VBind(x), M::VBind(y)), M::VBind(z)))) {
            auto fadd = std::make_shared<BinaryInst>(getTmp(), OP::FADD, y, z);
            auto fsub = std::make_shared<BinaryInst>(getTmp(), OP::FSUB, x, fadd);
            inst->replaceSelf(fsub);
            inst->getParent()->addInst(inst->getIndex(), fadd);
            inst->getParent()->addInst(inst->getIndex(), fsub);
            instsimplify_inst_modified = true;
        }
        // float: x + -x -> 0
        else if (match(inst, M::Fadd(M::VBind(x), M::Fneg(M::Is(x))))) {
            inst->replaceSelf(function.getConst(-0.0f));
            instsimplify_inst_modified = true;
        }
    }

    name_cnt = 0;

    if (instsimplify_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        pa.preserve<LoopAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}
std::string InstSimplifyPass::getTmp() {
    return "%instsim" + std::to_string(name_cnt++);
}
} // namespace IR