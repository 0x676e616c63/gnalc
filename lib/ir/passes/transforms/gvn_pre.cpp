#include "../../../../include/ir/passes/transforms/gvn_pre.hpp"

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <deque>

namespace IR {
std::ostream &operator<<(std::ostream &os, const GVNPREPass::Expr &expr) {
    switch (expr.op) {
    case GVNPREPass::Expr::ExprOp::Add:
        os << "v" << expr.operands[0] << " + v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Sub:
        os << "v" << expr.operands[0] << " - v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Mul:
        os << "v" << expr.operands[0] << " * v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Div:
        os << "v" << expr.operands[0] << " / v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Rem:
        os << "v" << expr.operands[0] << " % v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::And:
        os << "v" << expr.operands[0] << " && v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Or:
        os << "v" << expr.operands[0] << " || v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Gep:
        os << "gep ";
        for (auto it = expr.operands.begin(); it != expr.operands.end(); ++it) {
            os << "v" << *it;
            if (std::next(it) != expr.operands.end())
                os << ", ";
        }
        break;
    case GVNPREPass::Expr::ExprOp::Constant:
        os << "constant " << expr.ir_value->getName();
        break;
    case GVNPREPass::Expr::ExprOp::Phi:
        os << "phi " << expr.ir_value->getName();
        break;
    case GVNPREPass::Expr::ExprOp::Reg:
        os << "reg " << expr.ir_value->getName();
        break;
    default:
        Err::unreachable();
    }
    return os;
}

std::ostream& operator<<(std::ostream &os, const GVNPREPass::NumberTable &table) {
    if (table.empty()) {
        os << "  <empty>\n";
        return os;
    }
    std::map<GVNPREPass::ValueKind, std::vector<GVNPREPass::Expr*>> temp;
    for (const auto& [expr, kind] : table.expr_table)
        temp[kind].emplace_back(expr);
    for (const auto& [kind, exprs] : temp) {
        os << "  v" << kind << ": ";
        for (auto it = exprs.begin(); it != exprs.end(); ++it) {
            os << **it;
            if (std::next(it) != exprs.end())
                os << ", ";
        }
        os << "\n";
    }
    return os;
}

std::ostream& operator<<(std::ostream &os, const GVNPREPass::KindTempSet &set) {
    if (set.empty()) {
        os << "  <empty>\n";
        return os;
    }
    for (const auto& [kind, ir_val] : set.values)
        os << "  v" << kind << ": " << ir_val->getName() << "\n";
    return os;
}

std::ostream& operator<<(std::ostream &os, const GVNPREPass::KindExprSet &set) {
    if (set.empty()) {
        os << "  <empty>\n";
        return os;
    }
    for (const auto& [kind, expr] : set.values)
        os << "  v" << kind << ": " << *expr << "\n";
    return os;
}

std::ostream& operator<<(std::ostream &os, const GVNPREPass & gvnpre) {
    os << "Number table: \n" << gvnpre.table << "\n";

    os << "\n\nAVAIL_OUT: \n";
    for (const auto& [block, set] : gvnpre.avail_out_map)
        os << "Block " << block->getName() << ": \n" << set << "\n";

    os << "\n\nANTIC_IN: \n";
    for (const auto& [block, set] : gvnpre.antic_in_map)
        os << "Block " << block->getName() << ": \n" << set << "\n";

    os << "\n\nANTIC_OUT: \n";
    for (const auto& [block, set] : gvnpre.antic_out_map)
        os << "Block " << block->getName() << ": \n" << set << "\n";

    os << "\n\nPHI_GEN: \n";
    for (const auto& [block, set] : gvnpre.phi_gen_map)
        os << "Block " << block->getName() << ": \n" << set << "\n";

    os << "\n\nEXP_GEN: \n";
    for (const auto& [block, set] : gvnpre.exp_gen_map)
        os << "Block " << block->getName() << ": \n" << set << "\n";

    os << "\n\nTMP_GEN: \n";
    for (const auto& [block, set] : gvnpre.tmp_gen_map) {
        os << "Block " << block->getName() << ": \n  ";
        if (set.empty())
            os << "<empty>";
        else {
            for (auto it = set.begin(); it != set.end(); ++it) {
                os << (*it)->getName();
                if (std::next(it) != set.end())
                    os << ", ";
            }
        }
        os << "\n";
    }
    return os;
}


void GVNPREPass::Expr::canon() {
    switch (op) {
    case ExprOp::Add:
    case ExprOp::Mul:
    case ExprOp::And:
    case ExprOp::Or:
    std::sort(operands.begin(), operands.end());
        break;
    default: break;
    }
}
const std::vector<GVNPREPass::ValueKind> &GVNPREPass::Expr::getExprOperands() const {
    return operands;
}
bool GVNPREPass::Expr::isReg() const {
    return op == ExprOp::Reg;
}
bool GVNPREPass::Expr::isConstant() const {
    return op == ExprOp::Constant;
}

bool GVNPREPass::Expr::isPhi() const {
    return op == ExprOp::Phi;
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
    if (op != rhs.op)
        return false;
    if (op == ExprOp::Reg || op == ExprOp::Constant || op == ExprOp::Phi)
        return ir_value == rhs.ir_value;
    return operands == rhs.operands;
}

void GVNPREPass::NumberTable::clear() {
    expr_table.clear();
    kind_cnt = 0;
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(const std::shared_ptr<Value> &value, KindExprSet& exp_gen, std::set<ValueKind> & added_exps) {
    auto e = getExprOrInsert(value, exp_gen, added_exps);
    if (e == nullptr) return NotValueKind;
    return getKindOrInsert(e);
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(Expr *expr) {
    if (expr == nullptr)
        return NotValueKind;
    auto it = expr_table.find(expr);
    if (it != expr_table.end())
        return it->second;

    expr_table[expr] = kind_cnt;
    return kind_cnt++;
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(const std::shared_ptr<Value> &value, KindExprSet &exp_gen) {
    std::set<ValueKind> added_exps;
    return getKindOrInsert(value, exp_gen, added_exps);
}
GVNPREPass::Expr *GVNPREPass::NumberTable::getExprOrInsert(const std::shared_ptr<Value> &inst, KindExprSet &exp_gen) {
    std::set<ValueKind> added_exps;
    return getExprOrInsert(inst, exp_gen, added_exps);
}

GVNPREPass::Expr *GVNPREPass::NumberTable::getExprOrInsert(const std::shared_ptr<Value> &ir_value, KindExprSet &exp_gen, std::set<ValueKind> &added_exps) {
    std::shared_ptr<Expr> expr;
    if (isSameType(ir_value->getType(), makeBType(IRBTYPE::UNDEFINED)) || isSameType(ir_value->getType(), makeBType(IRBTYPE::VOID))) {
        return nullptr;
    }

    bool is_phi = false;
    if (ir_value->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::Constant);
    else if (auto binary = std::dynamic_pointer_cast<BinaryInst>(ir_value)) {
        expr = std::make_shared<Expr>(binary, Expr::makeOP(binary->getOpcode()),
                                      std::vector{
                                          getKindOrInsert(binary->getLHS(), exp_gen, added_exps),
                                          getKindOrInsert(binary->getRHS(), exp_gen, added_exps)});
    } else if (auto gep = std::dynamic_pointer_cast<GEPInst>(ir_value)) {
        const auto &raw_operands = gep->getOperands();
        std::vector<ValueKind> operands;
        std::transform(raw_operands.begin(), raw_operands.end(),
                       std::back_inserter(operands),
                       [this, &exp_gen, &added_exps](const auto &use) {
                           return getKindOrInsert(use->getValue(), exp_gen, added_exps);
                       });
        expr = std::make_shared<Expr>(gep, Expr::ExprOp::Gep, std::move(operands));
    } else if (auto phi = std::dynamic_pointer_cast<PHIInst>(ir_value)) {
        expr = std::make_shared<Expr>(phi, Expr::ExprOp::Phi);
        is_phi = true;
    } else
        expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::Reg);

    expr->canon();
    auto pool_expr = getExprFromPool(expr);
    auto kind = getKindOrInsert(pool_expr);
    if (!is_phi && added_exps.find(kind) == added_exps.end()) {
        exp_gen.insert(kind, pool_expr);
        added_exps.insert(kind);
    }

    return pool_expr;
}

GVNPREPass::Expr *GVNPREPass::NumberTable::getExprFromPool(const std::shared_ptr<Expr> &item) {
    for (const auto &r : expr_pool) {
        if (*r == *item) {
            return r.get();
        }
    }
    expr_pool.emplace_back(item);
    return item.get();
}

GVNPREPass::KindExprSet intersect(const GVNPREPass::KindExprSet &a, const GVNPREPass::KindExprSet &b) {
    GVNPREPass::KindExprSet ret;
    std::set_intersection(
        a.cbegin(), a.cend(),
        b.cbegin(), b.cend(), std::back_inserter(ret.values),
        [](const auto& lhs, const auto& rhs) { return lhs.first < rhs.first; });
    return ret;
}

// Translate from the representation of a given value at `succ` block
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
//   %succ_val = phi [%v1, pred], [%v2, other_pred]
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
    if (expr->isPhi()) {
        auto phi = std::dynamic_pointer_cast<PHIInst>(expr->getIRVal());
        Err::gassert(phi != nullptr);
        // If it is not a PHIInst in the `succ`,
        // then it comes from `pred` or earlier control flow,
        // therefore no translation is required.
        if(phi->getParent().get() != succ)
            return expr;
        auto v = phi->getValueForBlock(pred->shared_from_this());
        auto e = table.getExprOrInsert(v, exp_gen_map[succ]);
        return e;
    }

    if (expr->isReg() || expr->isConstant())
        return expr;

    std::shared_ptr<Instruction> translated_inst;
    auto kind = table.getKindOrInsert(expr);
    if (avail_out_map[pred].contains(kind)) {
        translated_inst = std::dynamic_pointer_cast<Instruction>(avail_out_map[pred].getValue(kind));
        Err::gassert(translated_inst != nullptr);
    }
    else {
        auto inst = std::dynamic_pointer_cast<Instruction>(expr->getIRVal());
        auto raw_operands = inst->getOperands();
        std::vector<std::shared_ptr<Value>> translated_operands;
        std::transform(raw_operands.begin(), raw_operands.end(),
            std::back_inserter(translated_operands),
                [this, &pred, &succ](const auto& use)
                {
                    return phi_translate(table.getExprOrInsert(use->getValue(),
                        exp_gen_map[succ]), pred, succ)->getIRVal();
                });

        if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst)) {
            Err::gassert(translated_operands.size() == 2);
            translated_inst = std::make_shared<BinaryInst>("%gvnpre.binary",
                binary->getOpcode(), translated_operands[0], translated_operands[1]);
        }
        else if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst)) {
            auto translated_ptr = translated_operands[0];
            translated_operands.erase(translated_operands.begin());
            translated_inst = std::make_shared<GEPInst>(
                "%gvnpre.gep", translated_ptr, translated_operands);
        }
        else Err::unreachable("Unknown inst");
    }

    return table.getExprOrInsert(translated_inst, exp_gen_map[succ]);
}

std::shared_ptr<Instruction> cloneInstForHoisting(const std::shared_ptr<Instruction> &inst) {
    if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst)) {
        return std::make_shared<BinaryInst>("%gvnpre.clone" + inst->getName(),
            binary->getOpcode(), binary->getLHS(), binary->getRHS());
    }
    if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst)) {
        return std::make_shared<GEPInst>("%gvnpre.clone" + gep->getName(),
            gep->getPtr(), gep->getIdxs());
    }
    Err::unreachable("Unknown inst");
    return nullptr;
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

        // PHI_GEN
        for (const auto& phi : curr->bb->getPhiInsts()) {
            auto kind = table.getKindOrInsert(phi, exp_gen);
            phi_gen.insert(kind, phi);
            avail_out.insert(kind, phi);
        }

        // AVAIL_OUT, EXP_GEN, TMP_GEN
        for (const auto& inst : *curr->bb) {
            if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE)
            {
                tmp_gen.insert(inst);
                auto expr = table.getExprOrInsert(inst, exp_gen);
                if (expr != nullptr) {
                    auto kind = table.getKindOrInsert(expr);
                    exp_gen.insert(kind, expr);
                    avail_out.insert(kind, inst);
                }
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
            if (curr->bb == nullptr) // Skip the virtual root.
                continue;

            // First build ANTIC_OUT
            AntiLeaderSet curr_antic_out;
            auto succ = curr->bb->getNextBB();
            if (succ.size() == 2) {
                // {e|e ∈ ANTIC_IN[succ_0(b)] ∧ ∀ b' ∈ succ(b), ∃ e' ∈ ANTIC_IN[b'] | lookup(e) = lookup(e') }
                // Since BRInst at most have 2 destinations, it is equivalent to
                // {e|e ∈ ANTIC_IN[succ_0(b)] ∧ ∃ e' ∈ ANTIC_IN[succ_1(b)] | lookup(e) = lookup(e') }
                // where `lookup` is `getKind` in our implementation
                auto succ0 = succ.front().get();
                auto succ1 = succ.back().get();

                // Since there is no critical edges, successors should have no phi.
                // Just a consistency check
                Err::gassert(!std::any_of(succ0->cbegin(), succ0->cend(),
                    [](const auto& i){ return i->getOpcode() == OP::PHI; })
                    && !std::any_of(succ1->cbegin(), succ1->cend(),
                    [](const auto& i){ return i->getOpcode() == OP::PHI; }),
                    "Critical edge should be broken before GVN-PRE.");

                curr_antic_out = intersect(antic_in_map[succ0], antic_in_map[succ1]);
            }
            else if (succ.size() == 1) {
                // phi_translate(A[succ(b)], b, succ(b))
                auto succ0 = succ.front().get();
                for (const auto&[kind, val] : antic_in_map[succ0]) {
                    auto translated = phi_translate(val, curr->bb, succ0);
                    curr_antic_out.insert(kind, translated);
                }
            }

            auto& antic_out = antic_out_map[curr->bb];
            modified |= (antic_out != curr_antic_out);
            antic_out = curr_antic_out;

            // Then build ANTIC_IN
            // = clean(canon_e(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))

            auto& antic_in = antic_in_map[curr->bb];
            auto& exp_gen = exp_gen_map[curr->bb];
            auto& tmp_gen = tmp_gen_map[curr->bb];
            AntiLeaderSet antic_in_temp;

            for (const auto& [kind, val] : antic_out)
                antic_in_temp.insert(kind, val);

            for (const auto& [kind, val] : exp_gen)
                antic_in_temp.insert(kind, val);

            // TMP_GEN acts as a kill set of ANTIC_IN
            std::set<ValueKind> killed_kinds;
            AntiLeaderSet cleaned_antic_in;
            for (const auto& [kind, expr] : antic_in_temp) {
                bool operand_got_killed = false;
                for (auto operand : expr->getExprOperands()) {
                    if (killed_kinds.find(operand) != killed_kinds.end()) {
                        killed_kinds.insert(kind);
                        operand_got_killed = true;
                        break;
                    }
                }
                if (!operand_got_killed) {
                    if (expr->isReg() && tmp_gen.find(expr->getIRVal()) != tmp_gen.end()) {
                        killed_kinds.insert(kind);
                    }
                    // Globally-defined temporaries.
                    else if (expr->isConstant()
                        || (expr->isReg() && expr->getIRVal()->getVTrait() == ValueTrait::GLOBAL_VARIABLE)) {
                        killed_kinds.insert(kind);
                    }
                    else
                        cleaned_antic_in.insert(kind, expr);
                }
            }

            modified |= (antic_in != cleaned_antic_in);
            antic_in = cleaned_antic_in;
        }
    }

    Logger::logDebug("[GVN-PRE] on '", function.getName(), "':\n", *this);
    // return PM::PreservedAnalyses::none();

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
                        bool is_avail_in_pred = avail_out_map[pred.get()].contains(kind);
                        avail_at_least_one |= is_avail_in_pred;
                        all_available &= is_avail_in_pred;
                        translated[pred.get()] = std::make_tuple(is_avail_in_pred, pred_expr);
                    }

                    // If the expression is available in at least one predecessor,
                    // then we insert it in predecessors where it is not available.
                    // Generating fresh temporaries, we perform the necessary insertions
                    // and create a phi to merge the predecessors' leaders
                    if (avail_at_least_one && !all_available) {
                        auto phi = std::make_shared<PHIInst>("%gvnpre-phi",
                            expr_to_hoist->getIRVal()->getType());
                        for (const auto& pred : preds) {
                            auto [avail, hoisted_expr] = translated[pred.get()];
                            auto hoisted_inst =
                                cloneInstForHoisting(std::dynamic_pointer_cast<Instruction>(
                                    hoisted_expr->getIRVal()));
                            if (!avail) {
                                Err::gassert(hoisted_inst != nullptr);
                                pred->addInstBeforeTerminator(hoisted_inst);
                                auto ok = avail_out_map[pred.get()].insert(kind, hoisted_inst);
                                Err::gassert(ok);
                                ok = exp_gen_map[pred.get()].insert(kind, hoisted_expr);
                                Err::gassert(ok);
                                modified = true;
                                Logger::logDebug("[GVN-PRE] on '", function.getName(), "': '",
                                    hoisted_inst->getName(), "' hoisted to block '", pred->getName(), "'.");
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

    std::set<std::shared_ptr<Instruction>> eliminated;
    for (const auto& bb : function) {
        for (const auto& inst : *bb) {
            KindExprSet exp_gen_temp;
            auto kind = table.getKindOrInsert(inst, exp_gen_temp);
            if (kind != NotValueKind) {
                auto& avail_out = avail_out_map[bb.get()];
                if (avail_out.contains(kind)) {
                    auto leader_value = avail_out.getValue(kind);
                    if (inst != leader_value) {
                        inst->replaceSelf(leader_value);
                        eliminated.emplace(inst);
                        Logger::logDebug("[GVN-PRE] on '", function.getName(), "': '",
                            inst->getName(), "' replaced with '", leader_value->getName(), "'.");
                    }
                }
            }
        }
    }
    for (const auto& bb : function) {
        bb->delInstIf([&eliminated](const auto& i) {
            return eliminated.find(i) != eliminated.end();
        });
    }

    // cleanup to release temp objects
    table.clear();

    avail_out_map.clear();
    antic_in_map.clear();
    antic_out_map.clear();
    exp_gen_map.clear();
    phi_gen_map.clear();
    tmp_gen_map.clear();
    return PM::PreservedAnalyses::none(); // FIXME, not always none
}
} // namespace IR