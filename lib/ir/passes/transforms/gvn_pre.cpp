#include "../../../../include/ir/passes/transforms/gvn_pre.hpp"

#include "../../../../include/config/config.hpp"
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
    case GVNPREPass::Expr::ExprOp::GlobalTemp:
        os << "global-temp " << expr.ir_value->getName();
        break;
    case GVNPREPass::Expr::ExprOp::Phi:
        os << "phi " << expr.ir_value->getName();
        break;
    case GVNPREPass::Expr::ExprOp::Untracked:
        os << "untracked " << expr.ir_value->getName();
        break;
    default:
        Err::unreachable();
    }
    if (!expr.isGlobalTemp() && !expr.isPhi() && !expr.isUntracked()
        && std::dynamic_pointer_cast<Instruction>(expr.ir_value)->getParent() == nullptr) {
        os << "(gen)";
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

std::ostream& operator<<(std::ostream &os, const GVNPREPass::KindIRValSet &set) {
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

    os << "\n\nEXP_GEN: \n";
    for (const auto& [block, set] : gvnpre.exp_gen_map)
        os << "Block " << block->getName() << ": \n" << set << "\n";
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
    default:
        break;
    }
}
GVNPREPass::Expr::ExprOp GVNPREPass::Expr::getExprOpcode() const {
    return op;
}
const std::vector<GVNPREPass::ValueKind> &GVNPREPass::Expr::getExprOperands() const {
    return operands;
}
bool GVNPREPass::Expr::isUntracked() const {
    return op == ExprOp::Untracked;
}
bool GVNPREPass::Expr::isGlobalTemp() const {
    return op == ExprOp::GlobalTemp;
}
bool GVNPREPass::Expr::isPhi() const {
    return op == ExprOp::Phi;
}
std::shared_ptr<Value> GVNPREPass::Expr::getIRVal() const {
    Err::gassert(ir_value != nullptr);
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
    return ExprOp::Untracked;
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
    if (op == ExprOp::Untracked || op == ExprOp::GlobalTemp || op == ExprOp::Phi)
        return ir_value == rhs.ir_value;
    return operands == rhs.operands;
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(
    const std::shared_ptr<Value> &value, KindExprSet& exp_gen, size_t nested_expr_cnt) {
    auto e = getExprOrInsert(value, exp_gen, nested_expr_cnt);
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

GVNPREPass::Expr *GVNPREPass::NumberTable::getExprOrInsert(
    const std::shared_ptr<Value> &ir_value, KindExprSet &exp_gen, size_t nested_expr_cnt) {
    if (nested_expr_cnt > Config::IR::GVNPRE_SKIP_NESTED_EXPR_THRESHOLD) {
        Logger::logInfo("[GVN-PRE]: Skipped analysis on an Expr, nested too deeply (more than ",
            nested_expr_cnt, "). Continuing will cause a terrible compile time.");
        too_deeply_nested_expr_detected = true;
        auto expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::Untracked);
        expr->canon();
        auto pool_expr = getExprFromPool(expr);
        // Already in table
        if (expr_table.find(pool_expr) != expr_table.end())
            return pool_expr;
        // New Exp
        auto kind = getKindOrInsert(pool_expr);
        // Assume there is no phi
        exp_gen.insert(kind, pool_expr);
        return pool_expr;
    }

    std::shared_ptr<Expr> expr;
    if (isSameType(ir_value->getType(), makeBType(IRBTYPE::UNDEFINED)) || isSameType(ir_value->getType(), makeBType(IRBTYPE::VOID))) {
        return nullptr;
    }

    bool is_phi = false;
    if (ir_value->getVTrait() == ValueTrait::CONSTANT_LITERAL
        || ir_value->getVTrait() == ValueTrait::FORMAL_PARAMETER
        || ir_value->getVTrait() == ValueTrait::GLOBAL_VARIABLE
        || (std::dynamic_pointer_cast<ALLOCAInst>(ir_value) != nullptr
            && std::dynamic_pointer_cast<ALLOCAInst>(ir_value)->isArray()))
        expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::GlobalTemp);
    else {
        if (auto phi = std::dynamic_pointer_cast<PHIInst>(ir_value)) {
            expr = std::make_shared<Expr>(phi, Expr::ExprOp::Phi);
            is_phi = true;
        } else if (auto inst = std::dynamic_pointer_cast<Instruction>(ir_value)) {
            const auto &raw_operands = inst->getOperands();
            std::vector<ValueKind> operands;
            std::transform(raw_operands.begin(), raw_operands.end(),
                           std::back_inserter(operands),
                           [this, &exp_gen, &nested_expr_cnt](const auto &use) {
                               return getKindOrInsert(use->getValue(), exp_gen, nested_expr_cnt + 1);
                           });

            if (auto binary = std::dynamic_pointer_cast<BinaryInst>(ir_value)) {
                Err::gassert(operands.size() == 2);
                expr = std::make_shared<Expr>(binary, Expr::makeOP(binary->getOpcode()), std::move(operands));
            } else if (auto gep = std::dynamic_pointer_cast<GEPInst>(ir_value)) {
                Err::gassert(operands.size() > 1);
                expr = std::make_shared<Expr>(gep, Expr::ExprOp::Gep, std::move(operands));
            } else
                expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::Untracked);
        } else
            expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::Untracked);
    }

    expr->canon();
    auto pool_expr = getExprFromPool(expr);

    Err::gassert(isSameType(ir_value->getType(), pool_expr->getIRVal()->getType()));

    // Already in table
    if (expr_table.find(pool_expr) != expr_table.end())
        return pool_expr;

    // New Exp
    auto kind = getKindOrInsert(pool_expr);
    if (!is_phi)
        exp_gen.insert(kind, pool_expr);

    return pool_expr;
}

void GVNPREPass::NumberTable::setPhiKind(const std::shared_ptr<PHIInst> &phi, ValueKind kind) {
    auto expr = std::make_shared<Expr>(phi, Expr::ExprOp::Phi);
    auto pool_expr = getExprFromPool(expr);
    expr_table[pool_expr] = kind;
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
// Returns %v1 for `phi_translate(expr<%succ_val>, pred, succ)`
//
// Note that if the translated Expr doesn't exist, expr->getIRVal()->getParent() will be nullptr.
// And we DO NOT update `exp_gen` in `phi_translate`.
// When hoisted, this Inst will be added to `pred`, and the `exp_gen` will be updated.
std::shared_ptr<Value> GVNPREPass::phi_translate(Expr* expr, BasicBlock* pred, BasicBlock* succ) {
    // if the temporary is defined by a phi at the successor,
    // it returns the operand to that phi corresponding to the predecessor
    if (expr->isPhi()) {
        auto phi = std::dynamic_pointer_cast<PHIInst>(expr->getIRVal());
        Err::gassert(phi != nullptr);
        // If it is not a PHIInst in the `succ`,
        // then it comes from `pred` or earlier control flow,
        // therefore no translation is required.
        if(phi->getParent().get() != succ)
            return expr->getIRVal();
        return phi->getValueForBlock(pred->shared_from_this());
    }

    if (expr->isUntracked() || expr->isGlobalTemp())
        return expr->getIRVal();

    // To accurately determine if an expression is available in `pred`,
    // the expression must be translated.
    // Because an expression's availability might flip after translation.
    //
    //
    // Available after translation:
    //                  bb1 ------> bb3
    // bb1:
    // %gep0 = gep %0 %1
    // bb3:
    // %b = phi [ %1, %bb1 ] [ %2, %bb2 ]
    //
    // Imagine we are translating <gep %0 %b> from bb3 to bb1,
    // Before translation, <gep %0 %b> is not available in bb1.
    // After translation, <gep %0 %b> becomes <%gep %0 %1>, which is available as %gep0
    //
    //
    // Not available after translation:
    //                 bb1  ---------->  bb2 -------->    bb3
    //                                    ^                |
    //                                    |----------------|
    //
    // bb2:
    //   %1 = phi [ %a, %bb1 ] [ %3, %bb3 ]
    // bb3:
    //   %2 = add %1, 1
    //   %3 = sub %1, 1
    //
    // Imagine we are translating <%1 + 1> from bb2 to bb3,
    // Before translation, <%1 + 1> is already available in bb3 as %2
    // After translation, <%1 + 1> becomes <%3 + 1>, which is not available.

    // Make a temporarily IR::Value to get the ValueKind
    auto inst = std::dynamic_pointer_cast<Instruction>(expr->getIRVal());
    auto raw_operands = inst->getOperands();
    std::vector<std::shared_ptr<Value>> translated_operands;
    std::transform(raw_operands.begin(), raw_operands.end(),
        std::back_inserter(translated_operands),
            [this, &pred, &succ](const auto& use)
            {
                KindExprSet exp_gen_temp;
                return phi_translate(
                    table.getExprOrInsert(use->getValue(), exp_gen_temp), pred, succ);
            });

    std::shared_ptr<Instruction> translated_inst;
    if (auto binary = std::dynamic_pointer_cast<BinaryInst>(inst)) {
        Err::gassert(translated_operands.size() == 2);
        translated_inst = std::make_shared<BinaryInst>("%gvnpre.b" + std::to_string(name_cnt++),
            binary->getOpcode(), translated_operands[0], translated_operands[1]);
    }
    else if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst)) {
        auto translated_ptr = translated_operands[0];
        translated_operands.erase(translated_operands.begin());
        translated_inst = std::make_shared<GEPInst>(
            "%gvnpre.g" + std::to_string(name_cnt++), translated_ptr, translated_operands);
    }
    else Err::unreachable("Unknown inst");

    Err::gassert(isSameType(expr->getIRVal()->getType(), translated_inst->getType()),
        "Translated expression's type is different from original expression's type.");

    KindExprSet exp_gen_temp;
    auto translated_kind = table.getKindOrInsert(translated_inst, exp_gen_temp);

    // See if the `translated_inst` in `avail_out`
    if (avail_out_map[pred].contains(translated_kind)) {
        auto tinst = std::dynamic_pointer_cast<Instruction>
            (avail_out_map[pred].getValue(translated_kind));
        Err::gassert(tinst != nullptr);
        Err::gassert(isSameType(tinst->getType(), translated_inst->getType()));
        return tinst;
    }

    // If `phi_translate` generates new value, we keep them in `phi_translate_map`
    // to avoid duplicate IR::Value between multiple translating.
    // Duplicate IR::Value will cause troubles, imagine we are hoisting an expression:
    //   %a = add %1, 3
    //   %b = gep %0, %a
    // %b is nested expression, and %a will be translated twice (%a and %b's operand)
    // If both of them are generated by `phi_translate`, we should make sure
    //     expr<%b>->getIRValue().operands[1] == expr<%a>->getIRValue()
    // Otherwise, expr<%b>->getIRValue().operands[1] will be destroyed when this pass is done.
    // In other words, duplicate translation should emit the same IR::Value.

    if (phi_translate_map[pred].contains(translated_kind)) {
        auto tinst = std::dynamic_pointer_cast<Instruction>
            (phi_translate_map[pred].getValue(translated_kind));
        Err::gassert(tinst != nullptr);
        Err::gassert(isSameType(tinst->getType(), translated_inst->getType()));
        return tinst;
    }

    phi_translate_map[pred].insert(translated_kind, translated_inst);
    return translated_inst;
}

PM::PreservedAnalyses GVNPREPass::run(Function &function, FAM &fam) {
    if (function.getBlocks().size() > Config::IR::GVNPRE_SKIP_BLOCK_THRESHOLD) {
        Logger::logInfo("[GVN-PRE]: Skipped '", function.getName(),
            "', too many blocks (", function.getBlocks().size(),
            "). Continuing it will cause a terrible compile time.");
        return PM::PreservedAnalyses::all();
    }

    bool gvnpre_inst_modified = false;
    //
    // Step 1 - BuildSets
    //

    // 1. Topdown traversal of the dominator tree.
    // Build AVAIL_OUT, EXP_GEN
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    auto dfvisitor = domtree.getDFVisitor();
    for (const auto& curr : dfvisitor) {
        auto& avail_out = avail_out_map[curr->bb]; // = canon(AVAIL_IN[b] ∪ PHI_GEN(b) ∪ TMP_GEN(b))
        auto& exp_gen = exp_gen_map[curr->bb]; // temporaries and non-simple

        // inherit expressions from the dominator
        if (curr->parent)
            avail_out = avail_out_map[curr->parent->bb];

        // AVAIL_OUT
        for (const auto& phi : curr->bb->getPhiInsts()) {
            auto kind = table.getKindOrInsert(phi, exp_gen);
            avail_out.insert(kind, phi);
        }

        // AVAIL_OUT, EXP_GEN
        for (const auto& inst : *curr->bb) {
            if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                auto expr = table.getExprOrInsert(inst, exp_gen);
                auto kind = table.getKindOrInsert(expr);
                exp_gen.insert(kind, expr);
                avail_out.insert(kind, inst);

                if (table.should_quit_for_too_deeply_nested_expr()) {
                    reset();
                    return PM::PreservedAnalyses::all();
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
            // Skip the virtual root.
            if (curr->bb == nullptr)
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
                Err::gassert(succ0->getPhiCount() == 0 && succ1->getPhiCount() == 0,
                    "Critical edge should be broken before GVN-PRE.");

                for (const auto& [kind, expr] : antic_in_map[succ0]) {
                    if (antic_in_map[succ1].contains(kind))
                        curr_antic_out.insert(kind, expr);
                }
            }
            else if (succ.size() == 1) {
                // phi_translate(A[succ(b)], b, succ(b))
                auto succ0 = succ.front().get();
                for (const auto&[kind, val] : antic_in_map[succ0]) {
                    auto translated_val = phi_translate(val, curr->bb, succ0);
                    KindExprSet exp_gen_temp;
                    auto translated_expr = table.getExprOrInsert(translated_val, exp_gen_temp);
                    curr_antic_out.insert(table.getKindOrInsert(translated_expr), translated_expr);
                }
            }

            auto& antic_out = antic_out_map[curr->bb];
            modified |= (antic_out != curr_antic_out);
            antic_out = curr_antic_out;

            // Then build ANTIC_IN
            // = clean(canon_e(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))

            auto& exp_gen = exp_gen_map[curr->bb];
            AntiLeaderSet antic_in_temp;

            for (const auto& [kind, val] : antic_out)
                antic_in_temp.insert(kind, val);

            for (const auto& [kind, val] : exp_gen)
                antic_in_temp.insert(kind, val);

            // clean
            AntiLeaderSet cleaned_antic_in;
            std::set<ValueKind> killed_kinds;
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
                    if (expr->isUntracked())
                        killed_kinds.insert(kind);
                    else if (!expr->isGlobalTemp())
                        cleaned_antic_in.insert(kind, expr);
                }
            }

            auto& antic_in = antic_in_map[curr->bb];
            modified |= (antic_in != cleaned_antic_in);
            antic_in = cleaned_antic_in;
        }
    }

    // Logger::logDebug("[GVN-PRE] on '", function.getName(), "':\n", *this);
    // return PM::PreservedAnalyses::none();

    //
    // Step 2 - Insert
    //

    //
    //                 bb1  ---->   bb2
    //                               ^
    //                               |
    //      bb4  ---->  bb3 ---------
    //                   ^
    //                   |
    //                   bb5
    //
    // Initial:
    // bb5:
    //   %a1 = add %0, 1
    // bb2:
    //   %a = add %0, 1
    //
    //
    // The first round:
    // bb4:
    //   %a2 = add %0, 1
    // bb5:
    //   %a3 = add %0, 1
    // bb3:
    //   %a4 = phi [ %a3, %bb5 ] [ %a2, %bb4 ]
    // bb2:
    //   %a = add %0, 1
    //
    //
    // The second round:
    // bb1:
    //   %a1 = add %0, 1
    // bb4:
    //   %a2 = add %0, 1
    // bb5:
    //   %a3 = add %0, 1
    // bb3:
    //   %a4 = phi [ %a3, %bb5 ] [ %a2, %bb4 ]
    // bb2:
    //   %a = phi [ %a4, %bb3 ] [ %a1, %bb1 ]

    // a top-down traversal of the dominator tree
    size_t debug_logger_insert_round_cnt = 0;
    modified = true;
    while (modified) {
        modified = false;

        dfvisitor = domtree.getDFVisitor();
        for (const auto& curr : dfvisitor) {
            auto preds = curr->bb->getPreBB();
            if (preds.size() > 1) {
                auto& antic_in = antic_in_map[curr->bb];

                for (const auto& [kind_to_hoist, expr_to_hoist] : antic_in) {
                    // Note that new_set inherits from dominators, not predecessors. It is safe to use them
                    // in this block. In fact, if an expression is in new_set, it is guaranteed
                    // to exist in avail_out. Every recomputing in this block will be eliminated
                    // in the elimination phase. So just skip it.
                    // This can also be done by erasing `kind_to_hoist` from antic_in_map[curr->bb]
                    // after an expression being hoisted. But be aware that we are iterating the `antic_in`.
                    // `kind_to_hoist` is actually a const reference to an element in `antic_in`.
                    // Erasing it will invalidate `kind_to_hoist`, which is hard to debug :(
                    if (new_set_map[curr->bb].contains(kind_to_hoist))
                        continue;

                    // Pred -> available, translated kind, translated val
                    std::map<BasicBlock*, std::tuple<bool, ValueKind, std::shared_ptr<Value>>> translated;
                    bool avail_at_least_one = false;
                    for (const auto& pred : preds) {
                        auto tval = phi_translate(expr_to_hoist, pred.get(), curr->bb);
                        KindExprSet exp_gen_temp;
                        auto tkind = table.getKindOrInsert(tval, exp_gen_temp);
                        // What we care is if the translated expr is available in `pred`,
                        // so `tkind` rather than `kind_to_hoist`
                        bool is_avail_in_pred = avail_out_map[pred.get()].contains(tkind);
                        avail_at_least_one |= is_avail_in_pred;
                        translated[pred.get()] = std::make_tuple(is_avail_in_pred, tkind, tval);
                    }

                    // If the expression is available in at least one predecessor,
                    // then we insert it in predecessors where it is not available.
                    // Generating fresh temporaries, we perform the necessary insertions
                    // and create a phi to merge the predecessors' leaders.
                    // If the expression is available in at all predecessors,
                    // then we only insert a phi.
                    if (avail_at_least_one) {
                        auto phi = std::make_shared<PHIInst>("%gvnpre.p" + std::to_string(name_cnt),
                            expr_to_hoist->getIRVal()->getType());
                        for (const auto& pred : preds) {
                            auto [avail, hoisted_kind, hoisted_ir_val] = translated[pred.get()];
                            if (!avail) {
                                auto hoisted_inst = std::dynamic_pointer_cast<Instruction>(hoisted_ir_val);
                                Err::gassert(hoisted_inst != nullptr && hoisted_inst->getParent() == nullptr,
                                    "Hoisted instruction actually avail.");
                                pred->addInstBeforeTerminator(hoisted_inst);
                                auto ok = avail_out_map[pred.get()].insert(hoisted_kind, hoisted_ir_val);
                                Err::gassert(ok);
                                ok = exp_gen_map[pred.get()].insert(hoisted_kind,
                                    table.getExprOrInsert(hoisted_ir_val, exp_gen_map[pred.get()]));
                                Err::gassert(ok);

                                ok = new_set_map[pred.get()].insert(hoisted_kind, hoisted_ir_val);
                                Err::gassert(ok);

                                Logger::logDebug("[GVN-PRE] on '", function.getName(), "': '",
                                    hoisted_inst->getName(), "' hoisted to block '", pred->getName(), "'.");
                                phi->addPhiOper(hoisted_inst, pred);
                            }
                            else {
                                auto avail_inst
                                = std::dynamic_pointer_cast<Instruction>(hoisted_ir_val);
                                Err::gassert(avail_inst != nullptr && avail_inst->getParent() != nullptr,
                                    "Avail instruction not avail, and is generated by phi_translate.");
                                phi->addPhiOper(avail_inst, pred);
                            }
                        }

                        gvnpre_inst_modified = true;
                        curr->bb->addPhiInst(phi);
                        // Given that `curr` has more than one predecessor,
                        // each predecessor must only have one successor
                        // which is `curr`. (Critical edge has been removed)
                        // So we only update `curr`'s LeaderSet here, and let `curr` propagate
                        // this information to its dom children below.
                        table.setPhiKind(phi, kind_to_hoist);
                        avail_out_map[curr->bb].update(kind_to_hoist, phi);
                        new_set_map[curr->bb].update(kind_to_hoist, phi);
                        modified = true;
                    }
                }

                // Whenever we create a new computation or phi, we possibly make a new
                // value, and we at least create a new leader for that value in the given block.
                // We update that block's leader set and its new set.
                // Since this information should be propagated to other blocks
                // which the new temporaries reach, for each block we also add
                // all the expressions in its dominator's new set into the block's own leader
                // set and new set.
                DomTree::NodeDFVisitor dom_dfv{curr};
                for (const auto& dom_child : dom_dfv) {
                    // Exprs are associated with ValueKind, so they are always
                    // identical if the expression is identical.
                    // But IR::Value Leaders are not, if a hoisting happened before,
                    // the idom_child will have leaders whose ValueKind
                    // is same to its dominator but IR::Value not.
                    // So it is `update` rather than `insert`,
                    for (const auto& [kind, val] : new_set_map[dom_child->parent->bb]) {
                        avail_out_map[dom_child->bb].update(kind, val);
                        modified |= new_set_map[dom_child->bb].update(kind, val);
                    }
                }
            }
        }

        debug_logger_insert_round_cnt++;
        // Logger::logDebug("[GVN-PRE] on '", function.getName(), "' AFTER INSERT ROUND ",
        //     debug_logger_insert_round_cnt, ":\n", *this);
    }

    //
    // Step 3 - Eliminate
    //

    // For any instruction, find the leader of the target's value.
    // If it differs from that target, then there is a constant or
    // an earlier-defined temporary with the same value.
    // The current instruction can be replaced by a move from the leader to the target.

    std::set<std::shared_ptr<Instruction>> eliminated;
    for (const auto& bb : function) {
        const auto& avail_out = avail_out_map[bb.get()];
        for (const auto& inst : *bb) {
            KindExprSet exp_gen_temp;
            auto kind = table.getKindOrInsert(inst, exp_gen_temp);
            // exp_gen_temp could not have new values except for
            // expressions that are nested too deeply. ( > Config::GVNPRE_SKIP_EXPR_THRESHOLD)
            // We are not interested in them.
            if(!exp_gen_temp.empty())
                continue;
            if (kind != NotValueKind) {
                auto leader_value = avail_out.getValue(kind);
                Err::gassert(leader_value != nullptr);
                if (inst != leader_value) {
                    // The paper said there should be a move, but replaceSelf is ok.
                    // Note that
                    // 1. The `leader_value` available at this block must originate from a dominator block
                    // 2. The `inst` inherently dominates all its uses
                    // Therefore, the `leader_value` dominates all `inst`'s uses, and we can safely
                    // replace all `inst`'s uses with `leader_value`.
                    inst->replaceSelf(leader_value);
                    eliminated.emplace(inst);
                    Logger::logDebug("[GVN-PRE] on '", function.getName(), "': '",
                        inst->getName(), "' replaced with '", leader_value->getName(), "'.");
                    gvnpre_inst_modified = true;
                }
            }
        }
    }


    // After replacing, the phi might end up unused or having the same value for all predecessors.
    // If so, eliminate it.
    for (const auto& bb : function) {
        for (const auto& phi : bb->getPhiInsts()) {
            if (phi->getUseList().empty()) {
                eliminated.emplace(phi);
                continue;
            }

            auto phi_opers = phi->getPhiOpers();
            std::shared_ptr<Value> common_value = phi_opers[0].value;
            for (const auto& [v, b] : phi_opers) {
                if (common_value != v) {
                    common_value = nullptr;
                    break;
                }
            }
            if (common_value != nullptr) {
                phi->replaceSelf(common_value);
                eliminated.emplace(phi);
            }
        }
    }

    for (const auto& bb : function) {
        gvnpre_inst_modified |= bb->delInstIf([&eliminated](const auto& i) {
            return eliminated.find(i) != eliminated.end();
        });
    }

    // cleanup to release temp objects
    reset();

    if (gvnpre_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR