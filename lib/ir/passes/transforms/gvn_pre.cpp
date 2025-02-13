#include "../../../../include/ir/passes/transforms/gvn_pre.hpp"

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <deque>

namespace IR {
void GVNPREPass::Expr::canon() {
    switch (op) {
    case ExprOp::Add:
    case ExprOp::Mul:
    case ExprOp::And:
    case ExprOp::Or:
    std::sort(opreands.begin(), opreands.end());
        break;
    default: break;
    }
}
const std::vector<GVNPREPass::ValueKind> &GVNPREPass::Expr::getOpers() const {
    return opreands;
}
bool GVNPREPass::Expr::is_simple() const {
    return op != ExprOp::UntrackedInst;
}
std::shared_ptr<Value> GVNPREPass::Expr::getIRVal() const {
    return ir_value;
}
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

// GVNPREPass::Expr::ExprOp GVNPREPass::Expr::makeOP(ICMPOP icmpop) {
//     switch (icmpop) {
//     case ICMPOP::eq:
//         return ExprOp::Eq;
//     case ICMPOP::ne:
//         return ExprOp::Ne;
//     case ICMPOP::sgt:
//         return ExprOp::Gt;
//     case ICMPOP::sge:
//         return ExprOp::Ge;
//     case ICMPOP::slt:
//         return ExprOp::Lt;
//     case ICMPOP::sle:
//         return ExprOp::Le;
//     }
//     Err::unreachable("Unknown ICMPOP");
//     return ExprOp::UNEXPECTED;
// }
//
// GVNPREPass::Expr::ExprOp GVNPREPass::Expr::makeOP(FCMPOP fcmpop) {
//     switch (fcmpop) {
//     case FCMPOP::oeq:
//         return ExprOp::Eq;
//     case FCMPOP::one:
//         return ExprOp::Ne;
//     case FCMPOP::ogt:
//         return ExprOp::Gt;
//     case FCMPOP::oge:
//         return ExprOp::Ge;
//     case FCMPOP::olt:
//         return ExprOp::Lt;
//     case FCMPOP::ole:
//         return ExprOp::Le;
//     default:
//         Err::unreachable("Unknown FCMPOP");
//     }
//     Err::unreachable("Unknown FCMPOP");
//     return ExprOp::UNEXPECTED;
// }

bool GVNPREPass::Expr::operator==(const Expr &rhs) const {
    Err::gassert(op != ExprOp::UNEXPECTED);
    if (op != rhs.op || opreands != rhs.opreands)
        return false;
    if (op == ExprOp::UntrackedInst || op == ExprOp::Constant)
        return ir_value == rhs.ir_value;
    return true;
}

void GVNPREPass::NumberTable::clear() {
    expr_table.clear();
    kind_cnt = 0;
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(const std::shared_ptr<Value> &value) {
    return getKindOrInsert(getExprOrInsert(value));
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(Expr *expr){
    auto it = expr_table.find(expr);
    if (it != expr_table.end())
        return it->second;

    expr_table[expr] = kind_cnt;
    return kind_cnt++;
}

GVNPREPass::Expr* GVNPREPass::NumberTable::getExprOrInsert(const std::shared_ptr<Value> &ir_value) {
    std::shared_ptr<Expr> expr;
    if (ir_value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
        if (auto binary = std::dynamic_pointer_cast<BinaryInst>(ir_value)) {
            expr = std::make_shared<Expr>(binary, Expr::makeOP(binary->getOpcode()),
                std::vector{ getKindOrInsert(binary->getLHS()), getKindOrInsert(binary->getRHS()) });
        }
        else if (auto gep = std::dynamic_pointer_cast<GEPInst>(ir_value)) {
            const auto &raw_operands = gep->getOperands();
            std::vector<ValueKind> operands;
            std::transform(raw_operands.begin(), raw_operands.end(),
                           std::back_inserter(operands),
                           [this](const auto &use) { return getKindOrInsert(use->getValue()); });
            expr = std::make_shared<Expr>(gep, Expr::ExprOp::Gep, std::move(operands));
        }
        else if (auto phi = std::dynamic_pointer_cast<PHIInst>(ir_value))
            expr = std::make_shared<Expr>(phi, Expr::ExprOp::Phi);
        else
            expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::UntrackedInst);
    }
    else if (ir_value->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
        expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::Constant);
    }
    else Err::unreachable("Not Expr");

    expr->canon();

    for (const auto &r : expr_pool) {
        if (*r == *expr) {
            getKindOrInsert(r.get());
            return r.get();
        }
    }

    expr_pool.emplace_back(expr);
    getKindOrInsert(expr.get());
    return expr.get();
}

GVNPREPass::AntiLeaderSet GVNPREPass::intersect(const AntiLeaderSet &a, const AntiLeaderSet &b) {
    AntiLeaderSet ret;

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
// Note that this functions might generate a new Inst for the pred block.
// And the Inst's owner is Expr. If hoisted, the Inst will be added to the pred block.
GVNPREPass::Expr* GVNPREPass::phi_translate(
    Expr* expr,
    BasicBlock* pred,
    BasicBlock* succ) {
    // if the temporary is defined by a phi at the successor,
    // it returns the operand to that phi corresponding to the predecessor
    if (auto phi = std::dynamic_pointer_cast<PHIInst>(expr->getIRVal())) {
        auto v = phi->getValueForBlock(pred->shared_from_this());
        auto e = table.getExprOrInsert(v);
        return e;
    }

    if (!expr->is_simple()) {
        auto inst = std::dynamic_pointer_cast<Instruction>(expr->getIRVal());
        auto operands = inst->getOperands();
        std::vector<std::shared_ptr<Value>> translated;
        std::transform(operands.begin(), operands.end(),
            std::back_inserter(translated),
                [this, &pred, &succ](const auto& use)
                { return phi_translate(table.getExprOrInsert(use->getValue()), pred, succ)->getIRVal(); });

        std::shared_ptr<Instruction> translated_inst;
        auto kind = table.getKindOrInsert(expr);
        if (avail_out_map[pred].contains(kind)) {
            translated_inst = std::dynamic_pointer_cast<Instruction>(avail_out_map[pred].getValue(kind));
            Err::gassert(translated_inst != nullptr);
        }
        else {
            if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst)) {
                translated_inst = std::make_shared<BinaryInst>(binary->getName(),
                    binary->getOpcode(), translated[0], translated[1]);
            }
            else if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst)) {
                translated_inst = std::make_shared<GEPInst>(gep->getName(), gep->getPtr(), translated);
            }
            else Err::unreachable("Unknown inst");
        }

        auto translated_expr = table.getExprOrInsert(translated_inst);
        return translated_expr;
    }

    // otherwise returning the temporary
    return expr;
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
        auto& exp_gen = exp_gen_map[curr->bb]; // temporaries and non-simple
        auto& phi_gen = phi_gen_map[curr->bb]; // temporaries that are defined by a phi
        auto& tmp_gen = tmp_gen_map[curr->bb]; // temporaries that are defined by non-phi instructions

        // inherit expressions from the dominator
        if (curr->parent)
            avail_out = avail_out_map[curr->parent->bb];

        for (const auto& inst : *curr->bb) {
            // PHI_GEN
            if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
                auto kind = table.getKindOrInsert(phi);
                phi_gen.insert(kind, phi);
                avail_out.insert(kind, inst);
            }
            // EXP_GEN
            else if (std::dynamic_pointer_cast<BinaryInst>(inst) || inst->getOpcode() == OP::GEP)
            {
                auto expr = table.getExprOrInsert(inst);
                auto kind = table.getKindOrInsert(expr);
                exp_gen.insert(kind, expr);
            }
            // TMP_GEN
            else if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                tmp_gen.insert(inst);
                avail_out.insert(table.getKindOrInsert(inst), inst);
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
            AntiLeaderSet antic_out;
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

                antic_out = intersect(antic_in_map[succ0.get()], antic_in_map[succ1.get()]);
            }
            else if (succ.size() == 1) {
                // phi_translate(A[succ(b)], b, succ(b))
                for (const auto&[kind, val] : antic_in_map[succ.front().get()]) {
                    auto translated = phi_translate(val, curr->bb, succ.front().get());
                    antic_out.insert(kind, translated);
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
            for (const auto& val : tmp_gen)
                antic_in.erase(table.getKindOrInsert(val));

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

                for (const auto& [kind, expr_to_hoist] : antic_in) {
                    // BasicBlock -> Available?/translated expr
                    std::map<BasicBlock*, std::tuple<bool, Expr*>> translated;
                    bool avail_at_least_one = false;
                    bool all_available = true;
                    for (const auto& pred : preds) {
                        auto pred_expr = phi_translate(expr_to_hoist, pred.get(), curr->bb);
                        bool avail = avail_out_map[pred.get()].contains(kind);
                        avail_at_least_one |= avail;
                        all_available &= avail;
                        translated[pred.get()] = std::make_tuple(avail, pred_expr);
                    }

                    // If the expression is available in at least one predecessor,
                    // then we insert it in predecessors where it is not available.
                    // Generating fresh temporaries, we perform the necessary insertions
                    // and create a phi to merge the predecessors' leaders
                    if (avail_at_least_one && !all_available) {
                        auto phi = std::make_shared<PHIInst>("%hoist-from-" + curr->bb->getName(),
                            expr_to_hoist->getIRVal()->getType());
                        for (const auto& pred : preds) {
                            auto [avail, hoisted_expr] = translated[pred.get()];
                            auto hoisted_inst = std::dynamic_pointer_cast<Instruction>(
                                hoisted_expr->getIRVal());
                            if (!avail) {
                                Err::gassert(hoisted_inst != nullptr);
                                pred->addInstBeforeTerminator(hoisted_inst);
                                auto ok = avail_out_map[pred.get()].insert(kind, hoisted_inst);
                                Err::gassert(ok);
                                ok = exp_gen_map[pred.get()].insert(kind, hoisted_expr);
                                Err::gassert(ok);
                                modified = true;
                            }
                            phi->addPhiOper(hoisted_inst, pred);
                        }
                        curr->bb->addPhiInst(phi);
                    }
                }

                // Whenever we create a new computation or phi, we possibly make a new
                // value, and we at least create a new leader for that value in the given block.
                // We update that block's leader set and its new set.
                // Since this information should be propagated to other blocks
                // which the new temporaries reach, for each block we also add
                // all the expressions in its dominator's new set into the block's own leader
                // set and new set.
                auto dom_exp_gen = exp_gen_map[curr->bb];
                // Here we only handle the idom child, and let the propagation fly.
                // In the next round, the "idom" will become to "dom" and handle its idoms.
                for (const auto& idom_child : curr->children) {
                    for (const auto& [kind, expr] : dom_exp_gen) {
                        exp_gen_map[idom_child->bb].insert(kind, expr);
                        avail_out_map[idom_child->bb].insert(kind, expr->getIRVal());
                    }
                }
            }
        }
    }

    //
    // Step 3 - Eliminate
    //

    // For any instruction, find the leader of the target's value.
    // If it differs from that target, then there is a constant or
    // an earlier-defined temporary with the same value

    std::set<std::shared_ptr<Instruction>> eliminated_insts;
    for (const auto& bb : function) {
        for (const auto& inst : *bb) {
            auto kind = table.getKindOrInsert(inst);
            auto& avail_out = avail_out_map[bb.get()];
            if (avail_out.contains(kind)) {
                inst->replaceSelf(avail_out.getValue(kind));
                bb->delInst(inst);
                eliminated_insts.insert(inst);
            }
        }
    }

    // cleanup to release temp objects
    table.clear();

    avail_out_map.clear();
    antic_in_map.clear();
    exp_gen_map.clear();
    phi_gen_map.clear();
    tmp_gen_map.clear();
    return PM::PreservedAnalyses::none(); // FIXME, not always none
}
} // namespace IR