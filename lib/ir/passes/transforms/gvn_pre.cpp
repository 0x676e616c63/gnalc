#include "../../../../include/ir/passes/transforms/gvn_pre.hpp"

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <deque>

namespace IR {
GVNPREPass::Expr::ExprOp GVNPREPass::Expr::makeOP(OP op) {
    switch (op) {
    case OP::ADD:
    case OP::FADD:
        return ExprOp::Add;
    case OP::SUB:
    case OP::FSUB:
        return ExprOp::Sub;
    case OP::MUL:
    case OP::FMUL:
        return ExprOp::Mul;
    case OP::DIV:
    case OP::FDIV:
        return ExprOp::Div;
    case OP::REM:
    case OP::FREM:
        return ExprOp::Rem;
    case OP::AND:
        return ExprOp::And;
    case OP::OR:
        return ExprOp::Or;
    default:
        Err::unreachable("Unknown OP");
    }
    return ExprOp::UNEXPECTED;
}

GVNPREPass::Expr::ExprOp GVNPREPass::Expr::makeOP(ICMPOP icmpop) {
    switch (icmpop) {
    case ICMPOP::eq:
        return ExprOp::Eq;
    case ICMPOP::ne:
        return ExprOp::Ne;
    case ICMPOP::sgt:
        return ExprOp::Gt;
    case ICMPOP::sge:
        return ExprOp::Ge;
    case ICMPOP::slt:
        return ExprOp::Lt;
    case ICMPOP::sle:
        return ExprOp::Le;
    }
    Err::unreachable("Unknown ICMPOP");
    return ExprOp::UNEXPECTED;
}

GVNPREPass::Expr::ExprOp GVNPREPass::Expr::makeOP(FCMPOP fcmpop) {
    switch (fcmpop) {
    case FCMPOP::oeq:
        return ExprOp::Eq;
    case FCMPOP::one:
        return ExprOp::Ne;
    case FCMPOP::ogt:
        return ExprOp::Gt;
    case FCMPOP::oge:
        return ExprOp::Ge;
    case FCMPOP::olt:
        return ExprOp::Lt;
    case FCMPOP::ole:
        return ExprOp::Le;
    default:
        Err::unreachable("Unknown FCMPOP");
    }
    Err::unreachable("Unknown FCMPOP");
    return ExprOp::UNEXPECTED;
}

bool GVNPREPass::Expr::operator==(const Expr &rhs) const {
    return op == rhs.op && opreands == rhs.opreands;
}
bool GVNPREPass::isExpr(const std::shared_ptr<Value> &v) {
    auto inst = std::dynamic_pointer_cast<Instruction>(v);
    return inst && (std::dynamic_pointer_cast<BinaryInst>(inst) || inst->getOpcode() == OP::ICMP || inst->getOpcode() == OP::FCMP || inst->getOpcode() == OP::GEP);
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKind(const std::shared_ptr<Value> &value) {
    auto value_it = value_table.find(value);
    if (value_it != value_table.end())
        return value_it->second;

    if (isExpr(value)) {
        auto expr = getExpr(std::dynamic_pointer_cast<Instruction>(value));
        auto expr_it = expr_table.find(expr);
        if (expr_it != expr_table.end()) {
            value_table[value] = expr_it->second;
            return expr_it->second;
        }
        value_table[value] = kind_cnt;
        expr_table[expr] = kind_cnt;
        return kind_cnt++;
    }
    // Constant or PHI
    value_table[value] = kind_cnt;
    return kind_cnt++;
}

std::shared_ptr<GVNPREPass::Expr> GVNPREPass::NumberTable::getExpr(const std::shared_ptr<Instruction> &inst) {
    Err::gassert(isExpr(inst));
    std::shared_ptr<Expr> expr;
    const auto &raw_operands = inst->getOperands();
    std::vector<ValueKind> operands;

    std::transform(raw_operands.begin(), raw_operands.end(),
                   std::back_inserter(operands),
                   [this](const auto &use) { return getKind(use->getValue()); });

    if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst))
        expr = std::make_shared<Expr>(Expr::makeOP(binary->getOpcode()), std::move(operands));
    else if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(inst))
        expr = std::make_shared<Expr>(Expr::makeOP(icmp->getCond()), std::move(operands));
    else if (auto fcmp = std::dynamic_pointer_cast<FCMPInst>(inst))
        expr = std::make_shared<Expr>(Expr::makeOP(fcmp->getCond()), std::move(operands));
    else if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst))
        expr = std::make_shared<Expr>(Expr::ExprOp::Gep, std::move(operands));
    else
        Err::unreachable("NumberTable::makeExpr(): Unknown Instruction");

    for (const auto &r : expr_pool) {
        if (*r == *expr)
            return r;
    }

    expr_pool.emplace_back(expr);
    return expr;
}

GVNPREPass::ValueSet GVNPREPass::intersect(const ValueSet &a, const ValueSet &b) {
    ValueSet ret;

    // std::map's key type is const, and the pair's copy assignment operator is implicitly deleted in Clang.
    // See: https://stackoverflow.com/questions/52639887/clang-copy-assignment-operator-is-getting-deleted-while-using-stdmap-in-libc
    // std::set_intersection(a.cbegin(), a.cend(),
    // b.cbegin(), b.cend(), ret.begin(),
    // [](const auto& lhs, const auto& rhs) { return lhs.first < rhs.first; });

    // https://en.cppreference.com/w/cpp/algorithm/set_intersection
    auto it1 = a.cbegin(), it2 = b.cbegin();
    while (it1 != a.cend() && it2 != b.cend())
    {
        if (it1->first < it2->first)
            ++it1;
        else
        {
            if (it2->first >= it1->first)
                ret.insert(it1->first, it1->second); // it1->first and it2->first are equivalent.
            ++it2;
        }
    }
    return ret;
}

// Returns the representation of a given value at `succ` block
// to the representation of it in the `pred` block.
//
// pred -------> succ
// other_pred ---^
//
// pred:
//   %v1 = 1
//   br succ
//
// succ:
//   %succ_val = phi [%v1, pred], [%v2, other_pred])
//
// Returns %v1 for `phi_translate(%succ_val, pred, succ)`
std::tuple<GVNPREPass::ValueKind, std::shared_ptr<Value>> GVNPREPass::phi_translate(
    const std::shared_ptr<Value>& value,
    const std::shared_ptr<BasicBlock>& pred,
    const std::shared_ptr<BasicBlock>& succ) {
    // if the temporary is defined by a phi at the successor,
    // it returns the operand to that phi corresponding to the predecessor
    if (auto phi = std::dynamic_pointer_cast<PHIInst>(value)) {
        auto v = phi->getValueForBlock(pred);
        return { table.getKind(v), v };
    }

    if (isExpr(value)) {
        auto inst = std::dynamic_pointer_cast<Instruction>(value);
        auto operands = inst->getOperands();
        std::vector<std::shared_ptr<Value>> translated;
        std::transform(operands.begin(), operands.end(),
            std::back_inserter(translated),
                [this, &pred, &succ](const auto& use)
                { return std::get<1>(phi_translate(use->getValue(), pred, succ)); });

        std::shared_ptr<Instruction> translated_inst;
        if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst)) {
            translated_inst = std::make_shared<BinaryInst>(binary->getName(),
                binary->getOpcode(), translated[0], translated[1]);
        }
        else if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(inst)) {
            translated_inst = std::make_shared<ICMPInst>(icmp->getName(), icmp->getCond(),
                translated[0], translated[1]);
        }
        else if (auto fcmp = std::dynamic_pointer_cast<FCMPInst>(inst)) {
            translated_inst = std::make_shared<FCMPInst>(fcmp->getName(), fcmp->getCond(),
                translated[0], translated[1]);
        }
        else if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst)) {
            translated_inst = std::make_shared<GEPInst>(gep->getName(), gep->getPtr(), translated);
        }

        auto translated_kind = table.getKind(translated_inst);
        return { translated_kind, translated_inst };
    }

    // otherwise returning the temporary
    return { table.getKind(value), value };
}

PM::PreservedAnalyses GVNPREPass::run(Function &function, FAM &fam) {
    //
    // Step 1 - BuildSets
    //

    // 1. Topdown traversal of the dominator tree.
    // Build AVAIL_OUT, EXP_GEN, PHI_GEN and TMP_GEN
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    auto dfvisitor = domtree.getDFVisitor();
    for (const auto& curr : dfvisitor) {
        auto& avail_out = avail_out_map[curr->bb]; // = canon(AVAIL_IN[b] ∪ PHI_GEN(b) ∪ TMP_GEN(b))
        auto& exp_gen = exp_gen_map[curr->bb];     // temporaries and non-simple
        auto& phi_gen = phi_gen_map[curr->bb];     // temporaries that are defined by a phi
        auto& tmp_gen = tmp_gen_map[curr->bb];     // temporaries that are defined by non-phi instructions

        // inherit expressions from the dominator
        if (curr->parent)
            avail_out = avail_out_map[curr->parent->bb];

        for (const auto& inst : *curr->bb) {
            // PHI_GEN
            if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
                auto kind = table.getKind(phi);
                phi_gen.insert(kind, phi);
                avail_out.insert(kind, inst);
            }
            // EXP_GEN
            else if (isExpr(inst))
            {
                auto kind = table.getKind(inst);
                exp_gen.insert(kind, inst);
                for (const auto& use : inst->getOperands()) {
                    auto op_kind = table.getKind(use->getValue());
                    exp_gen.insert(op_kind, use->getValue());
                }
            }
            // TMP_GEN
            else if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                auto kind = table.getKind(inst);
                tmp_gen.insert(kind, inst);
                avail_out.insert(kind, inst);
            }
        }
    }


    // 2. Calculates flow sets to determine the antileader sets
    //    and conducts the fixed-point iteration
    // Build ANTIC_IN

    // Perform top-down traversals of the post-dominator tree
    // to help fast convergence since information flows backward over the CFG.
    auto postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    bool modified = true;
    while (modified) {
        modified = false;

        dfvisitor = postdomtree.getDFVisitor();
        for (const auto& curr : dfvisitor)
        {
            // First build ANTIC_OUT
            ValueSet antic_out;
            auto succ = curr->bb->getNextBB();
            if (succ.size() == 2) {
                // {e|e ∈ ANTIC_IN[succ_0(b)] ∧ ∀ b' ∈ succ(b), ∃ e' ∈ ANTIC_IN[b'] | lookup(e) = lookup(e') }
                // Since BRInst at most have 2 destinations, it is equivalent to
                // {e|e ∈ ANTIC_IN[succ_0(b)] ∧ ∃ e' ∈ ANTIC_IN[succ_1(b)] | lookup(e) = lookup(e') }
                // where `lookup` is `getKind` in our implementation
                const auto& succ0 = succ.front();
                const auto& succ1 = succ.back();

                // Since there is no critical edges, successors should have no phi.
                // Just a consistency check
                Err::gassert(!std::any_of(succ0->cbegin(), succ0->cend(),
                    [](const auto& i){return i->getOpcode() == OP::PHI; })
                    && !std::any_of(succ1->cbegin(), succ1->cend(),
                    [](const auto& i){return i->getOpcode() == OP::PHI; }),
                    "Critical edge should be broken before GVN-PRE.");

                antic_out = intersect(antic_in_map[succ0], antic_in_map[succ1]);
            }
            else if (succ.size() == 1) {
                // phi_translate(A[succ(b)], b, succ(b))
                for (const auto&[_kind, val] : antic_in_map[succ.front()]) {
                    auto [k, v] = phi_translate(val, curr->bb, succ.front());
                    antic_out.insert(k, v);
                }
            }
            else Err::unreachable();

            // Then build ANTIC_IN
            // = clean(canon_e(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))

            auto& antic_in = antic_in_map[curr->bb];
            auto& exp_gen = exp_gen_map[curr->bb];
            auto& tmp_gen = tmp_gen_map[curr->bb];

            auto last_round_size = antic_in.size();

            for (const auto& [kind, val] : antic_out)
                antic_in.insert(kind, val);

            for (const auto& [kind, val] : exp_gen)
                antic_in.insert(kind, val);

            // TMP_GEN acts as a kill set of ANTIC_IN
            for (const auto& [kind, _val] : tmp_gen)
                antic_in.erase(kind);

            modified |= (last_round_size != antic_in.size());

        }
    }


    //
    // Step 2 - Insert
    //

    // a top-down traversal of the dominator tree
    modified = true;
    while (modified) {
        modified = false;
        dfvisitor = domtree.getDFVisitor();
        for (const auto& curr : dfvisitor) {
            auto preds = curr->bb->getPreBB();
            if (preds.size() > 1) {
                auto& antic_in = antic_in_map[curr->bb];
                for (const auto& [_kind, val] : antic_in) {
                    std::set<std::shared_ptr<BasicBlock>> available_preds;
                    for (const auto& pred : preds) {
                        auto [pred_kind, pred_val]
                            = phi_translate(val, pred, curr->bb);

                        if (avail_out_map[pred].contains(pred_kind))
                            available_preds.insert(pred);
                    }
                    // If the expression is available in at least one predecessor,
                    // then we insert it in predecessors where it is not available.
                    // Generating fresh temporaries, we perform the necessary insertions
                    // and create a phi to merge the predecessors’ leaders
                    if (!available_preds.empty()) {
                        for (const auto& pred : preds) {
                            if (available_preds.find(pred) == available_preds.end()) {

                            }
                        }
                    }
                }
            }

        }
    }

    //
    // Step 3 - Eliminate
    //

    return PM::PreservedAnalyses::none(); // FIXME, not always none
}
} // namespace IR