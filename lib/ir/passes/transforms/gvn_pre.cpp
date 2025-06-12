#include "ir/passes/transforms/gvn_pre.hpp"
#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

#include <algorithm>

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
        os << "v" << expr.operands[0] << " & v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Or:
        os << "v" << expr.operands[0] << " | v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Xor:
        os << "v" << expr.operands[0] << " ^ v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Shl:
        os << "v" << expr.operands[0] << " << v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::LShr:
        os << "v" << expr.operands[0] << " l>> v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::AShr:
        os << "v" << expr.operands[0] << " a>> v" << expr.operands[1];
        break;
    case GVNPREPass::Expr::ExprOp::Fptosi:
        os << "fptosi " << "v" << expr.operands[0];
        break;
    case GVNPREPass::Expr::ExprOp::Sitofp:
        os << "sitofp " << "v" << expr.operands[0];
        break;
    case GVNPREPass::Expr::ExprOp::Zext:
        os << "zext " << "v" << expr.operands[0] << " to " << expr.ir_value->getType()->toString();
        break;
    case GVNPREPass::Expr::ExprOp::Sext:
        os << "sext " << "v" << expr.operands[0] << " to " << expr.ir_value->getType()->toString();
        break;
    case GVNPREPass::Expr::ExprOp::Bitcast:
        os << "bitcast " << "v" << expr.operands[0] << " to " << expr.ir_value->getType()->toString();
        break;
    case GVNPREPass::Expr::ExprOp::PureFuncCall:
        os << "pure-func-call " << expr.ir_value->as<CALLInst>()->getFuncName() << "(";
        for (auto it = expr.operands.begin(); it != expr.operands.end(); ++it) {
            os << "v" << *it;
            if (std::next(it) != expr.operands.end())
                os << ", ";
        }
        os << ")";
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
    case GVNPREPass::Expr::ExprOp::LocalTemp:
        os << "local-temp " << expr.ir_value->getName();
        break;
    case GVNPREPass::Expr::ExprOp::Phi:
        os << "phi " << expr.ir_value->getName();
        break;
    default:
        Err::unreachable();
    }
    if (!expr.isLocalTemp() && !expr.isGlobalTemp() && !expr.isPhi() &&
        expr.ir_value->as<Instruction>()->getParent() == nullptr) {
        os << "(gen)";
    }
    return os;
}

std::ostream &operator<<(std::ostream &os, const GVNPREPass::NumberTable &table) {
    if (table.empty()) {
        os << "  <empty>\n";
        return os;
    }
    std::map<GVNPREPass::ValueKind, std::vector<GVNPREPass::Expr *>> temp;
    for (const auto &[expr, kind] : table.expr_table)
        temp[kind].emplace_back(expr);
    for (const auto &[kind, exprs] : temp) {
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

std::ostream &operator<<(std::ostream &os, const GVNPREPass::KindIRValSet &set) {
    if (set.empty()) {
        os << "  <empty>\n";
        return os;
    }
    for (const auto &[kind, ir_val] : set.values)
        os << "  v" << kind << ": " << ir_val->getName() << "\n";
    return os;
}

std::ostream &operator<<(std::ostream &os, const GVNPREPass::KindExprSet &set) {
    if (set.empty()) {
        os << "  <empty>\n";
        return os;
    }
    for (const auto &[kind, expr] : set.values)
        os << "  v" << kind << ": " << *expr << "\n";
    return os;
}

std::ostream &operator<<(std::ostream &os, const GVNPREPass &gvnpre) {
    os << "Number table: \n" << gvnpre.table << "\n";

    os << "\n\nAVAIL_OUT: \n";
    for (const auto &[block, set] : gvnpre.avail_out_map)
        os << "Block " << block->getName() << " AVAIL_OUT: \n" << set << "\n";

    os << "\n\nANTIC_IN: \n";
    for (const auto &[block, set] : gvnpre.antic_in_map)
        os << "Block " << block->getName() << " ANTIC_IN: \n" << set << "\n";

    os << "\n\nANTIC_OUT: \n";
    for (const auto &[block, set] : gvnpre.antic_out_map)
        os << "Block " << block->getName() << " ANTIC_OUT: \n" << set << "\n";

    os << "\n\nEXP_GEN: \n";
    for (const auto &[block, set] : gvnpre.exp_gen_map)
        os << "Block " << block->getName() << " EXP_GEN: \n" << set << "\n";
    return os;
}

void GVNPREPass::Expr::canon() {
    switch (op) {
    case ExprOp::Add:
    case ExprOp::Mul:
        std::sort(operands.begin(), operands.end());
        break;
    default:
        break;
    }
}
GVNPREPass::Expr::ExprOp GVNPREPass::Expr::getExprOpcode() const { return op; }
const std::vector<GVNPREPass::ValueKind> &GVNPREPass::Expr::getExprOperands() const { return operands; }
bool GVNPREPass::Expr::isGlobalTemp() const { return op == ExprOp::GlobalTemp; }
bool GVNPREPass::Expr::isLocalTemp() const { return op == ExprOp::LocalTemp; }
bool GVNPREPass::Expr::isPhi() const { return op == ExprOp::Phi; }
Value *GVNPREPass::Expr::getIRVal() const {
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
    case OP::UREM:
    case OP::SREM:
    case OP::FREM:
        return ExprOp::Rem;
    case OP::AND:
        return ExprOp::And;
    case OP::OR:
        return ExprOp::Or;
    case OP::XOR:
        return ExprOp::Xor;
    case OP::SHL:
        return ExprOp::Shl;
    case OP::LSHR:
        return ExprOp::LShr;
    case OP::ASHR:
        return ExprOp::AShr;
    default:
        Err::unreachable("Unknown OP");
    }
    return ExprOp::Add;
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

    if (op == ExprOp::Sext || op == ExprOp::Zext || op == ExprOp::Bitcast) {
        if (!isSameType(ir_value->getType(), rhs.ir_value->getType()))
            return false;
    } else if (op == ExprOp::PureFuncCall) {
        if (ir_value->as<CALLInst>()->getFunc() != rhs.ir_value->as<CALLInst>()->getFunc())
            return false;
    } else if (op == ExprOp::LocalTemp || op == ExprOp::GlobalTemp)
        return ir_value == rhs.ir_value;
    else if (op == ExprOp::Phi) {
        if (operands.size() != rhs.operands.size())
            return false;
        if (operands.empty())
            return isIdenticalPhi(ir_value->as<PHIInst>(), rhs.ir_value->as<PHIInst>());

        // Different phi's operand layout might differ, for example:
        //   %a = phi [ 0, %bb1 ] [ 1, %bb2 ]
        //   %b = phi [ 0, %bb2 ] [ 1, %bb1 ]
        // We can not only compare their operands
        auto phi = ir_value->as<PHIInst>();
        auto rhs_phi = rhs.ir_value->as<PHIInst>();
        if (phi->getParent() != rhs_phi->getParent())
            return false;
        size_t i = 0;
        for (const auto &[val, bb] : phi->incomings()) {
            size_t j = 0;
            for (const auto &[rhs_val, rhs_bb] : rhs_phi->incomings()) {
                if (bb == rhs_bb) {
                    if (operands[i] != rhs.operands[j])
                        return false;
                    break;
                }
                ++j;
            }
            ++i;
        }
        return true;
    }

    return operands == rhs.operands;
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(Value *value, KindExprSet &exp_gen,
                                                               size_t nested_expr_cnt) {
    auto e = getExprOrInsert(value, exp_gen, nested_expr_cnt);
    if (e == nullptr)
        return NotValueKind;
    return getKindOrInsert(e);
}
GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(Value *value, size_t nested_expr_cnt) {
    KindExprSet exp_gen_tmp;
    return getKindOrInsert(value, exp_gen_tmp, nested_expr_cnt);
}

GVNPREPass::ValueKind GVNPREPass::NumberTable::getKindOrInsert(Expr *expr) {
    if (expr == nullptr)
        return NotValueKind;
    auto it = expr_table.find(expr);
    if (it != expr_table.end())
        return it->second;

    if (expr->isPhi() && !expr->getExprOperands().empty()) {
        ValueKind common = expr->getExprOperands()[0];
        bool is_common = true;
        for (const auto &k : expr->getExprOperands()) {
            if (k != common) {
                is_common = false;
                break;
            }
        }
        if (is_common)
            return expr_table[expr] = common;
    }

    expr_table[expr] = kind_cnt;
    return kind_cnt++;
}

GVNPREPass::Expr *GVNPREPass::NumberTable::getExprOrInsert(Value *ir_value, KindExprSet &exp_gen,
                                                           size_t nested_expr_cnt) {
    auto it = get_expr_cache.find(ir_value);
    if (it != get_expr_cache.end())
        return it->second;

    if (nested_expr_cnt > Config::IR::GVNPRE_SKIP_NESTED_EXPR_THRESHOLD) {
        Logger::logInfo("[GVN-PRE]: Skipped analysis on an Expr, nested too deeply (more than ", nested_expr_cnt,
                        "). Continuing will cause a terrible compile time.");
        too_deeply_nested_expr_detected = true;
        return get_expr_cache[ir_value] = nullptr;
    }

    std::shared_ptr<Expr> expr;
    if (ir_value->getType()->isUndef() || ir_value->getType()->isVoid()) {
        return get_expr_cache[ir_value] = nullptr;
    }

    if (ir_value->getVTrait() == ValueTrait::CONSTANT_LITERAL ||
        ir_value->getVTrait() == ValueTrait::FORMAL_PARAMETER || ir_value->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
        ir_value->getVTrait() == ValueTrait::FUNCTION ||
        (ir_value->is<ALLOCAInst>() && ir_value->as<ALLOCAInst>()->isArray()))
        expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::GlobalTemp);
    else if (ir_value->is<LOADInst>() || (ir_value->is<CALLInst>() && !isPure(*fam, ir_value->as<CALLInst>())))
        expr = std::make_shared<Expr>(ir_value, Expr::ExprOp::LocalTemp);
    else {
        if (auto phi = ir_value->as_raw<PHIInst>()) {
            static std::vector<PHIInst *> visited_phis;

            if (std::any_of(visited_phis.begin(), visited_phis.end(),
                            [&phi](const auto &visited) { return visited == phi; })) {
                expr = std::make_shared<Expr>(phi, Expr::ExprOp::Phi);
            } else {
                std::vector<ValueKind> operands;
                visited_phis.emplace_back(phi);
                for (const auto &[val, bb] : phi->incomings()) {
                    // Phi's incomings' EXP_GEN should not be inserted into current `exp_gen`.
                    auto kind = getKindOrInsert(val.get(), nested_expr_cnt + 1);
                    if (kind == NotValueKind)
                        return nullptr;
                    operands.emplace_back(kind);
                }
                visited_phis.pop_back();
                expr = std::make_shared<Expr>(phi, Expr::ExprOp::Phi, std::move(operands));
            }
        } else if (auto inst = ir_value->as_raw<Instruction>()) {
            std::vector<ValueKind> operands;
            operands.reserve(inst->getNumOperands());
            for (const auto &operand : inst->operands()) {
                auto kind = getKindOrInsert(operand.get(), exp_gen, nested_expr_cnt + 1);
                if (kind == NotValueKind)
                    return nullptr;
                operands.emplace_back(kind);
            }
            if (auto binary = ir_value->as_raw<BinaryInst>()) {
                Err::gassert(operands.size() == 2);
                expr = std::make_shared<Expr>(binary, Expr::makeOP(binary->getOpcode()), std::move(operands));
            } else if (auto gep = ir_value->as_raw<GEPInst>()) {
                Err::gassert(operands.size() > 1);
                expr = std::make_shared<Expr>(gep, Expr::ExprOp::Gep, std::move(operands));
            } else if (auto sitofp = ir_value->as_raw<SITOFPInst>()) {
                Err::gassert(operands.size() == 1);
                expr = std::make_shared<Expr>(sitofp, Expr::ExprOp::Sitofp, std::move(operands));
            } else if (auto fptosi = ir_value->as_raw<FPTOSIInst>()) {
                Err::gassert(operands.size() == 1);
                expr = std::make_shared<Expr>(fptosi, Expr::ExprOp::Fptosi, std::move(operands));
            } else if (auto zext = ir_value->as_raw<ZEXTInst>()) {
                Err::gassert(operands.size() == 1);
                expr = std::make_shared<Expr>(zext, Expr::ExprOp::Zext, std::move(operands));
            } else if (auto sext = ir_value->as_raw<SEXTInst>()) {
                Err::gassert(operands.size() == 1);
                expr = std::make_shared<Expr>(sext, Expr::ExprOp::Sext, std::move(operands));
            } else if (auto bitcast = ir_value->as_raw<BITCASTInst>()) {
                Err::gassert(operands.size() == 1);
                expr = std::make_shared<Expr>(bitcast, Expr::ExprOp::Bitcast, std::move(operands));
            } else if (auto call = ir_value->as_raw<CALLInst>()) {
                // We've ensured this before
                Err::gassert(isPure(*fam, call));
                expr = std::make_shared<Expr>(call, Expr::ExprOp::PureFuncCall, std::move(operands));
            } else
                return get_expr_cache[ir_value] = nullptr;
        } else
            return get_expr_cache[ir_value] = nullptr;
    }

    expr->canon();
    auto pool_expr = getExprFromPool(expr);
    get_expr_cache[ir_value] = pool_expr;
    Err::gassert(isSameType(ir_value->getType(), pool_expr->getIRVal()->getType()));

    // Already in table
    if (expr_table.find(pool_expr) != expr_table.end())
        return pool_expr;

    // New Exp
    auto kind = getKindOrInsert(pool_expr);
    if (!ir_value->is<PHIInst>())
        exp_gen.insert(kind, pool_expr);

    return pool_expr;
}

GVNPREPass::Expr *GVNPREPass::NumberTable::getExprOrInsert(Value *inst, size_t nested_expr_cnt) {
    KindExprSet exp_gen_tmp;
    return getExprOrInsert(inst, exp_gen_tmp, nested_expr_cnt);
}

void GVNPREPass::NumberTable::setPhiKind(PHIInst *phi, ValueKind kind) {
    invalidateExprCache(phi);
    auto expr = getExprOrInsert(phi);
    expr_table[expr] = kind;
}

void GVNPREPass::NumberTable::invalidateExprCache(Value *v) { get_expr_cache.erase(v); }

GVNPREPass::Expr *GVNPREPass::NumberTable::getExprFromPool(const std::shared_ptr<Expr> &item) {
    auto it = expr_pool.find(item);
    if (it != expr_pool.end())
        return it->get();
    expr_pool.emplace(item);
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
Value *GVNPREPass::phiTranslate(Expr *expr, BasicBlock *pred, BasicBlock *succ) {
    if (expr->isGlobalTemp())
        return expr->getIRVal();

    // Local Temps are not always available in the predecessor block.
    // If they are not available, give up, since we can't duplicate them.
    if (expr->isLocalTemp()) {
        auto temp_block = expr->getIRVal()->as<Instruction>()->getParent().get();
        if (domtree->ADomB(temp_block, pred))
            return expr->getIRVal();
        return nullptr;
    }

    // if the temporary is defined by a phi at the successor,
    // it returns the operand to that phi corresponding to the predecessor
    if (expr->isPhi()) {
        auto phi = expr->getIRVal()->as<PHIInst>();
        Err::gassert(phi != nullptr);
        // If it is not a PHIInst in the `succ`,
        // then it comes from `pred` or its predecessors,
        // therefore no translation is required. But check if it is available.
        if (phi->getParent().get() != succ) {
            if (domtree->ADomB(phi->getParent().get(), pred))
                return expr->getIRVal();
            return nullptr;
        }
        return phi->getValueForBlock(pred->as<BasicBlock>()).get();
    }

    // To accurately determine if an expression is available in `pred`,
    // the expression must be translated.
    // Because an expression's availability might flip after translation.
    //
    //
    // Available after translation:
    //                  bb1 ------> bb3
    // bb1:
    //   %gep0 = gep %0 %1
    // bb3:
    //   %b = phi [ %1, %bb1 ] [ %2, %bb2 ]
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

    // This operation is time-consuming, so we cache the result.
    auto cache_key = std::make_tuple(expr, pred, succ);
    auto it = phi_translate_cache.find(cache_key);
    if (it != phi_translate_cache.end())
        return it->second;

    // Make a temporarily IR::Value to get the ValueKind
    auto inst = expr->getIRVal()->as<Instruction>();
    std::vector<pVal> translated_operands;
    translated_operands.reserve(inst->getNumOperands());

    for (const auto &operand : inst->operands()) {
        auto v = phiTranslate(table.getExprOrInsert(operand.get()), pred, succ);
        if (v == nullptr)
            return phi_translate_cache[cache_key] = nullptr;
        translated_operands.emplace_back(v->as<Value>());
    }

    pInst translated_inst;
    if (auto binary = inst->as<BinaryInst>()) {
        Err::gassert(translated_operands.size() == 2);
        translated_inst = std::make_shared<BinaryInst>("%gvnpre.b" + std::to_string(name_cnt++), binary->getOpcode(),
                                                       translated_operands[0], translated_operands[1]);
    } else if (auto gep = inst->as<GEPInst>()) {
        auto translated_ptr = translated_operands[0];
        translated_operands.erase(translated_operands.begin());
        translated_inst =
            std::make_shared<GEPInst>("%gvnpre.g" + std::to_string(name_cnt++), translated_ptr, translated_operands);
    } else if (auto fptosi = inst->as<FPTOSIInst>()) {
        Err::gassert(translated_operands.size() == 1);
        translated_inst =
            std::make_shared<FPTOSIInst>("%gvnpre.f2i" + std::to_string(name_cnt++), translated_operands[0]);
    } else if (auto sitofp = inst->as<SITOFPInst>()) {
        Err::gassert(translated_operands.size() == 1);
        translated_inst =
            std::make_shared<SITOFPInst>("%gvnpre.i2f" + std::to_string(name_cnt++), translated_operands[0]);
    } else if (auto zext = inst->as<ZEXTInst>()) {
        Err::gassert(translated_operands.size() == 1);
        translated_inst = std::make_shared<ZEXTInst>("%gvnpre.ze" + std::to_string(name_cnt++), translated_operands[0],
                                                     zext->getType()->as<BType>()->getInner());
    } else if (auto sext = inst->as<SEXTInst>()) {
        Err::gassert(translated_operands.size() == 1);
        translated_inst = std::make_shared<SEXTInst>("%gvnpre.se" + std::to_string(name_cnt++), translated_operands[0],
                                                     sext->getType()->as<BType>()->getInner());
    } else if (auto bitcast = inst->as<BITCASTInst>()) {
        Err::gassert(translated_operands.size() == 1);
        translated_inst = std::make_shared<BITCASTInst>("%gvnpre.bc" + std::to_string(name_cnt++),
                                                        translated_operands[0], bitcast->getType());
    } else if (auto pure_func_call = inst->as<CALLInst>()) {
        Err::gassert(isPure(*fam, pure_func_call));
        auto func = translated_operands[0]->as<FunctionDecl>();
        Err::gassert(func == pure_func_call->getFunc());
        translated_operands.erase(translated_operands.begin());
        auto num_args = pure_func_call->getFunc()->getType()->as<FunctionType>()->getParams().size();
        Err::gassert(translated_operands.size() == num_args);

        translated_inst =
            std::make_shared<CALLInst>("%gvnpre.c" + std::to_string(name_cnt++), func, translated_operands);
    } else
        Err::unreachable("Unknown inst");

    phi_translate_gen.emplace_back(translated_inst);
    Err::gassert(isSameType(expr->getIRVal()->getType(), translated_inst->getType()),
                 "Translated expression's type is different from original expression's type.");

    auto translated_kind = table.getKindOrInsert(translated_inst.get());

    // The translated instruction might contain some blackbox registers.
    // If so, drop it.
    if (translated_kind == NotValueKind)
        return phi_translate_cache[cache_key] = nullptr;

    // See if the `translated_inst` in `avail_out`
    if (avail_out_map[pred].contains(translated_kind)) {
        auto tinst = avail_out_map[pred].getValue(translated_kind);
        Err::gassert(tinst != nullptr);
        Err::gassert(isSameType(tinst->getType(), translated_inst->getType()));
        phi_translate_cache[cache_key] = tinst;
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
        auto tinst = phi_translate_map[pred].getValue(translated_kind);
        Err::gassert(tinst != nullptr);
        Err::gassert(isSameType(tinst->getType(), translated_inst->getType()));
        phi_translate_cache[cache_key] = tinst;
        return tinst;
    }

    phi_translate_map[pred].insert(translated_kind, translated_inst.get());
    phi_translate_cache[cache_key] = translated_inst.get();
    return translated_inst.get();
}

void GVNPREPass::invalidatePhiTranslateCache() { phi_translate_cache.clear(); }

PM::PreservedAnalyses GVNPREPass::run(Function &function, FAM &fam) {
    this->fam = &fam;
    table.setFAM(&fam);

    if (function.getBlocks().size() > Config::IR::GVNPRE_SKIP_BLOCK_THRESHOLD) {
        Logger::logInfo("[GVN-PRE]: Skipped '", function.getName(), "', too many blocks (", function.getBlocks().size(),
                        "). Continuing it will cause a terrible compile time.");
        return PreserveAll();
    }

    bool gvnpre_folded_phi = false;
    bool gvnpre_hoisted_inst = false;
    bool gvnpre_replaced_value = false;

    // Fold LCSSA Phi for phi_translate
    for (const auto &bb : function)
        gvnpre_folded_phi = foldPHI(bb, /* preserve_lcssa */ false);

    //
    // Step 1 - BuildSets
    //

    // 1. Topdown traversal of the dominator tree.
    // Build AVAIL_OUT, EXP_GEN
    domtree = &fam.getResult<DomTreeAnalysis>(function);
    auto dfvisitor = domtree->getDFVisitor();
    for (const auto &curr : dfvisitor) {
        auto &avail_out = avail_out_map[curr->raw_block()]; // = canon(AVAIL_IN[b] ∪ PHI_GEN(b) ∪ TMP_GEN(b))
        auto &exp_gen = exp_gen_map[curr->raw_block()];     // temporaries and non-simple

        // inherit expressions from the dominator
        if (curr->parent())
            avail_out = avail_out_map[curr->raw_parent()->raw_block()];

        // AVAIL_OUT
        for (const auto &phi : curr->raw_block()->phis()) {
            auto kind = table.getKindOrInsert(phi.get(), exp_gen);
            if (kind != NotValueKind)
                avail_out.insert(kind, phi.get());

            if (table.shouldQuitForTooDeeplyNestedExpr()) {
                reset();
                return PreserveAll();
            }
        }

        // AVAIL_OUT, EXP_GEN
        for (const auto &inst : *curr->raw_block()) {
            if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                auto expr = table.getExprOrInsert(inst.get(), exp_gen);
                auto kind = table.getKindOrInsert(expr);
                if (kind != NotValueKind) {
                    exp_gen.insert(kind, expr);
                    avail_out.insert(kind, inst.get());
                }

                if (table.shouldQuitForTooDeeplyNestedExpr()) {
                    reset();
                    return PreserveAll();
                }
            }
        }
    }

    // 2. Calculates flow sets to determine the antileader sets
    //    and conducts the fixed-point iteration
    // Build ANTIC_IN

    // Perform top-down traversals of the post-dominator tree
    // to help fast convergence since information flows backward over the CFG.
    postdomtree = &fam.getResult<PostDomTreeAnalysis>(function);
    auto pdfvisitor = postdomtree->getDFVisitor();
    bool modified = true;
    while (modified) {
        modified = false;

        for (const auto &curr : pdfvisitor) {
            // Skip the virtual root.
            if (curr->block() == nullptr)
                continue;

            // First build ANTIC_OUT
            AntiLeaderSet curr_antic_out;
            auto succ = curr->block()->getNextBB();
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

                for (const auto &[kind, expr] : antic_in_map[succ0]) {
                    if (antic_in_map[succ1].contains(kind))
                        curr_antic_out.insert(kind, expr);
                }
            } else if (succ.size() == 1) {
                // phi_translate(A[succ(b)], b, succ(b))
                auto succ0 = succ.front().get();
                for (const auto &[kind, val] : antic_in_map[succ0]) {
                    auto translated_val = phiTranslate(val, curr->raw_block(), succ0);
                    if (translated_val != nullptr) {
                        auto translated_expr = table.getExprOrInsert(translated_val);
                        curr_antic_out.insert(table.getKindOrInsert(translated_expr), translated_expr);
                    }
                }
            }

            auto &antic_out = antic_out_map[curr->raw_block()];
            modified |= (antic_out != curr_antic_out);
            antic_out = curr_antic_out;

            // Then build ANTIC_IN
            // = clean(canon_e(ANTIC_OUT[b] ∪ EXP_GEN[b] − TMP_GEN(b)))

            auto &exp_gen = exp_gen_map[curr->raw_block()];
            AntiLeaderSet antic_in_temp;

            // Note that we MUST merge EXP_GEN first to keep the topological order in ANTIC_IN.
            //
            // EXP_GEN is the expressions generated within the basic block, and it might be
            // used in the successors. Therefore, the expressions in EXP_GEN can be used
            // in the ANTIC_OUT. So merge EXP_GEN first.
            for (const auto &[kind, val] : exp_gen)
                antic_in_temp.insert(kind, val);

            for (const auto &[kind, val] : antic_out)
                antic_in_temp.insert(kind, val);

            // clean
            AntiLeaderSet cleaned_antic_in;
            for (const auto &[kind, expr] : antic_in_temp) {
                if (!expr->isGlobalTemp() && !expr->isLocalTemp())
                    cleaned_antic_in.insert(kind, expr);
            }

            auto &antic_in = antic_in_map[curr->raw_block()];
            modified |= (antic_in != cleaned_antic_in);
            antic_in = cleaned_antic_in;
        }

        // Logger::logDebug("[GVN-PRE] on '", function.getName(), "':\n", *this);
        // Logger::logDebug(".........................................xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    }

    if (enable_debug_output)
        Logger::logDebug("[GVN-PRE] on '", function.getName(), "':\n", *this);

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
    //                  bb5
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

    std::vector<pPhi> inserted_phis;

    LoopInfo *loop_info = nullptr;
    if (disable_PRE_on_loop_backedge)
        loop_info = &fam.getResult<LoopAnalysis>(function);

    // a top-down traversal of the dominator tree
    size_t debug_logger_insert_round_cnt = 0;
    modified = true;
    while (modified) {
        modified = false;
        for (const auto &curr : dfvisitor) {
            bool curr_is_loop_header = loop_info && loop_info->isLoopHeader(curr->raw_block());
            auto preds = curr->raw_block()->getPreBB();
            if (preds.size() > 1) {
                auto &antic_in = antic_in_map[curr->raw_block()];

                for (const auto &[kind_to_hoist, expr_to_hoist] : antic_in) {
                    static int debug = 0;
                    ++debug;
                    // Note that new_set inherits from dominators, not predecessors. It is safe to use them
                    // in this block. In fact, if an expression is in new_set, it is guaranteed
                    // to exist in avail_out. Every recomputing in this block will be eliminated
                    // in the elimination phase. So just skip it.
                    // This can also be done by erasing `kind_to_hoist` from antic_in_map[curr->bb]
                    // after an expression being hoisted. But be aware that we are iterating the `antic_in`.
                    // `kind_to_hoist` is actually a const reference to an element in `antic_in`.
                    // Erasing it will invalidate `kind_to_hoist`, which is hard to debug :(
                    if (new_set_map[curr->raw_block()].contains(kind_to_hoist))
                        continue;

                    // Pred -> available, translated kind, translated val
                    std::map<BasicBlock *, std::tuple<bool, ValueKind, Value *>> translated;
                    bool avail_in_at_least_one_pred = false;
                    bool unavail_in_at_least_one_pred = false;
                    bool killed = false;
                    for (const auto &pred : preds) {
                        auto tval = phiTranslate(expr_to_hoist, pred.get(), curr->raw_block());
                        if (tval == nullptr) {
                            killed = true;
                            break;
                        }
                        auto tkind = table.getKindOrInsert(tval);
                        // What we care is if the translated expr is available in `pred`,
                        // so `tkind` rather than `kind_to_hoist`
                        // A translated value's kind doesn't necessarily be the same as
                        // the original expr's kind. The difference is solved by phiTranslate.
                        bool is_avail_in_pred = avail_out_map[pred.get()].contains(tkind);
                        avail_in_at_least_one_pred |= is_avail_in_pred;
                        unavail_in_at_least_one_pred |= !is_avail_in_pred;
                        translated[pred.get()] = std::make_tuple(is_avail_in_pred, tkind, tval);
                    }

                    if (killed)
                        continue;

                    if (disable_PRE_on_loop_backedge && curr_is_loop_header) {
                        // For a typical rotated loop:
                        //
                        //                     (critical)
                        //                    |----------|
                        //                    |          |
                        //                    V          |
                        //  PreHeader ---> Header ---> Latch
                        //      |                        |
                        //      v                        |
                        //     Exit  <--------------------
                        //
                        // After the critical edge has been removed:
                        //                        (New Latch)
                        //                      |<-- bb0 <-|
                        //                   (*)|          |
                        //                      V          |
                        //    PreHeader ---> Header ---> Old Latch
                        //        |                        |
                        //        v                        |
                        //       Exit  <--------------------
                        //
                        //  Or for a simple self-loop:
                        //
                        //             (critical)
                        //             |--------                                      (*) |- bb0 <-
                        //             V       |   (after break critical edges)           V       |
                        //    Ph --> Header ---|   >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Ph --> Header ---|
                        //             |                                                  |
                        //             V                                                  V
                        //            Exit                                              Exit
                        //
                        // If we perform PRE on bb0 -> Header (*) edge, instructions will be
                        // hoisted to bb0, which will let bb0 can not be eliminated afterward.
                        // This, however, let a loop becomes a middle-exiting loop, or produces
                        // more BRInst, which can be a pessimization.
                        // So we provide an option to disable such PRE.
                        if (unavail_in_at_least_one_pred)
                            continue;
                    }

                    // Hoisting an instruction shall hoist its operands first,
                    // we try to achieve this by hoisting them in a topological order.
                    // However, it is not guaranteed that one's operands is always available
                    // at this block at this point.
                    // For example:
                    //
                    //   A        E
                    //   |        |
                    //   V        V
                    //   B <----- D <----- F
                    //   |
                    //   V
                    //   C
                    //
                    // E:
                    //   %gep.e = xxx
                    //   %bc.e = bitcast %gep.e to i32*
                    // F:
                    //   %gep.f = xxx
                    //   %bc.f = bitcast %gep.f to i32*
                    // D:
                    //   %bc.d.phi = phi [%bc.e, %E], [%bc.f, %F]
                    // C:
                    //   %gep.c = xxx
                    //   %bc.c = bitcast %gep.c to i32*
                    //
                    // All the gep.x and bc.x are the same.
                    //
                    // In this case, there exits partial redundancy in D -> B -> C,
                    // where the gep/bc are computed twice. To eliminate it, we might want to
                    // hoist the gep/bc to A, and create a phi in B to merge them.
                    //
                    // However, because D only has one phi of bitcast, which means only bitcast is directly
                    // available in D. (Or in AVAIL_OUT[D]).
                    // And when we try to hoist the gep at this point, we find they are
                    // not available both in A and D. So the gep can NOT be hoisted.
                    // Thus, we can NOT hoist the bitcast to A , since its operands, the gep,
                    // is not directly available in D.
                    //
                    // This doesn't mean we can not eliminate such redundancy.
                    // The idea comes from: one instruction available means all operands available. The
                    // only thing we need is to create some phi nodes.
                    // Though the bitcast is not directly available (Not in AVAIL_OUT[D]) at this point.
                    // It is in ANTIC_IN[D], and after a few rounds of insertion, a phi will be created
                    // in D to merge the two bitcasts in E and F.
                    //
                    // Therefore, if we find one's operands is not in AVAIL_OUT[curr],
                    // wait it and try again later.
                    if (unavail_in_at_least_one_pred) {
                        // unavail_in_at_least_one_pred means we need insertion, and have to check the
                        // operands
                        auto should_skip = [&] {
                            for (const auto &pred : preds) {
                                auto pred_avail = avail_out_map[pred.get()];
                                auto [avail, hoisted_kind, hoisted_ir_val] = translated[pred.get()];
                                if (!avail) {
                                    auto inst = hoisted_ir_val->as<Instruction>();
                                    auto &operand_uses = inst->getOperands();
                                    for (const auto &oper_use : operand_uses) {
                                        if (auto oper_inst = oper_use->getValue()->as<Instruction>()) {
                                            if (oper_inst->getParent() == nullptr) {
                                                auto oper_kind = table.getKindOrInsert(oper_inst.get());
                                                if (!pred_avail.contains(oper_kind))
                                                    return true;
                                            }
                                        }
                                    }
                                }
                            }
                            return false;
                        }();

                        if (should_skip)
                            continue;
                    }

                    // If the expression is available in at least one predecessor,
                    // then we insert it in predecessors where it is not available.
                    // Generating fresh temporaries, we perform the necessary insertions
                    // and create a phi to merge the predecessors' leaders.
                    // If the expression is available in all predecessors,
                    // then we only insert a phi.
                    if (avail_in_at_least_one_pred) {
                        auto phi = std::make_shared<PHIInst>("%gvnpre.p" + std::to_string(name_cnt++),
                                                             expr_to_hoist->getIRVal()->getType());
                        for (const auto &pred : preds) {
                            auto [avail, hoisted_kind, hoisted_ir_val] = translated[pred.get()];
                            if (!avail) {
                                auto hoisted_inst = hoisted_ir_val->as<Instruction>();
                                Err::gassert(hoisted_inst != nullptr && hoisted_inst->getParent() == nullptr,
                                             "Hoisted instruction actually avail.");

                                // Because we're hoisting instructions in the topological order,
                                // one's operands must be hoisted before itself.
                                // However, after several insertion round, many anticipated instructions
                                // might be available due to insertion in one's dominators.
                                // To avoid duplicate insertion, we won't hoist an instruction if
                                // it is available (in new_set particularly). Because a newer version
                                // is available in certain dominator.
                                // Thus, some hoisted instructions that have uses to such unhoisted
                                // instructions must be fixed here.
                                //
                                // IOW, phiTranslated instructions might contain out of date
                                // operand dependency to instructions generated by phiTranslate,
                                // which should be redirected to the one in avail_out[pred].
                                //
                                // For example,
                                //   %a = gep %b, %c, %d
                                //   %e = gep %a, %f, %g
                                // Imagine we are hoisting %a and %e. And %a is already available
                                // in certain dominator in previous insertion round.
                                // We start from hoisting %a, and find it is in the new_set[curr], thus skipping %a.
                                // Then, we hoist %e. We use phiTranslate to get the representation of %e
                                // in the pred, and got the one that phiTranslated have cached in `phi_translate_map`
                                // (Note that phiTranslate have two cache, one for correctness and one for
                                // performance, in `phi_translate_map` and `phi_translate_cache` respectively.
                                // See `phiTranslate` for details.)
                                // The cached instruction, however, can have operands that are also
                                // generated by phiTranslate. And if that operand is available now (in new_set[curr]),
                                // replace it with the available one.
                                //
                                // Note that the value in new_set[curr] is bound to be in avail_out[pred],
                                // since the values inserted in dominator of the current block must be
                                // available in all its predecessors.
                                //
                                // FIXME: fix phiTranslate to get rid of such 'out of date'
                                auto pred_avail = avail_out_map[pred.get()];
                                std::function<void(pInst &)> fix_operands;
                                fix_operands = [&](pInst &to_fix) {
                                    auto &operand_uses = to_fix->getOperands();
                                    for (const auto &oper_use : operand_uses) {
                                        if (auto oper_inst = oper_use->getValue()->as<Instruction>()) {
                                            if (oper_inst->getParent() == nullptr) {
                                                auto oper_kind = table.getKindOrInsert(oper_inst.get());
                                                Err::gassert(pred_avail.contains(oper_kind),
                                                             "Hoisting an instruction before its operands.");
                                                auto fixed_oper = pred_avail.getValue(oper_kind);
                                                if (auto fixed_oper_inst = fixed_oper->as<Instruction>())
                                                    fix_operands(fixed_oper_inst);
                                                oper_use->setValue(fixed_oper->as<Value>());
                                            }
                                        }
                                    }
                                };
                                fix_operands(hoisted_inst);

                                pred->addInstBeforeTerminator(hoisted_inst);
                                invalidatePhiTranslateCache();
                                auto ok = avail_out_map[pred.get()].insert(hoisted_kind, hoisted_ir_val);
                                Err::gassert(ok);
                                ok = exp_gen_map[pred.get()].insert(
                                    hoisted_kind, table.getExprOrInsert(hoisted_ir_val, exp_gen_map[pred.get()]));
                                Err::gassert(ok);

                                ok = new_set_map[pred.get()].insert(hoisted_kind, hoisted_ir_val);
                                Err::gassert(ok);

                                Logger::logDebug("[GVN-PRE] on '", function.getName(), "': '", hoisted_inst->getName(),
                                                 "' hoisted to block '", pred->getName(), "'.");
                                phi->addPhiOper(hoisted_inst, pred);
                            } else {
                                auto avail_inst = hoisted_ir_val->as<Instruction>();
                                Err::gassert(avail_inst != nullptr && avail_inst->getParent() != nullptr,
                                             "Avail instruction not avail, and is generated by phi_translate.");
                                phi->addPhiOper(avail_inst, pred);
                            }
                        }

                        // Given that `curr` has more than one predecessor,
                        // each predecessor must only have one successor
                        // which is `curr`. (Critical edge has been removed)
                        // So we only update `curr`'s LeaderSet here, and let `curr` propagate
                        // this information to its dom children below.
                        if (auto common_value = getCommonValue(phi)) {
                            avail_out_map[curr->raw_block()].update(kind_to_hoist, common_value.get());
                            new_set_map[curr->raw_block()].update(kind_to_hoist, common_value.get());
                        } else {
                            gvnpre_hoisted_inst = true;
                            curr->raw_block()->addPhiInst(phi);
                            invalidatePhiTranslateCache();
                            inserted_phis.emplace_back(phi);
                            table.setPhiKind(phi.get(), kind_to_hoist);
                            avail_out_map[curr->raw_block()].update(kind_to_hoist, phi.get());
                            new_set_map[curr->raw_block()].update(kind_to_hoist, phi.get());
                        }
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
                auto dom_dfv = curr->getDFVisitor();
                for (const auto &dom_child : dom_dfv) {
                    // Exprs are associated with ValueKind, so they are always
                    // identical if the expression is identical.
                    // But IR::Value Leaders are not, if a hoisting happened before,
                    // the idom_child will have leaders whose ValueKind
                    // is same to its dominator but IR::Value not.
                    // So it is `update` rather than `insert`,
                    for (const auto &[kind, val] : new_set_map[dom_child->parent()->raw_block()]) {
                        avail_out_map[dom_child->raw_block()].update(kind, val);
                        modified |= new_set_map[dom_child->raw_block()].update(kind, val);
                    }
                }
            }
        }

        debug_logger_insert_round_cnt++;
        if (enable_debug_output) {
            Logger::logDebug("[GVN-PRE] on '", function.getName(), "' AFTER INSERT ROUND ",
                             debug_logger_insert_round_cnt, ":\n", *this);
        }
    }

    //
    // Step 3 - Eliminate
    //

    // For any instruction, find the leader of the target's value.
    // If it differs from that target, then there is a constant or
    // an earlier-defined temporary with the same value.
    // The current instruction can be replaced by a move from the leader to the target.

    std::vector<pInst> eliminated;
    for (const auto &bb : function) {
        const auto &avail_out = avail_out_map[bb.get()];
        for (const auto &inst : *bb) {
            KindExprSet exp_gen_temp;
            auto kind = table.getKindOrInsert(inst.get(), exp_gen_temp);
            // exp_gen_temp could not have new values except for
            // expressions that are nested too deeply. ( > Config::GVNPRE_SKIP_EXPR_THRESHOLD)
            // We are not interested in them.
            if (!exp_gen_temp.empty())
                continue;
            if (kind != NotValueKind) {
                auto leader_value = avail_out.getValue(kind)->as<Value>();
                if (leader_value != nullptr && inst != leader_value) {
                    // The paper said there should be a move, but replaceSelf is ok.
                    // Note that
                    // 1. The `leader_value` available at this block must originate from a dominator block
                    // 2. The `inst` inherently dominates all its uses
                    // Therefore, the `leader_value` dominates all `inst`'s uses, and we can safely
                    // replace all `inst`'s uses with `leader_value`.
                    inst->replaceSelf(leader_value);
                    eliminated.emplace_back(inst);
                    Logger::logDebug("[GVN-PRE] on '", function.getName(), "': '", inst->getName(), "' replaced with '",
                                     leader_value->getName(), "'.");
                    gvnpre_replaced_value = true;
                }
            }
        }
    }

    // After replacing, the phi might end up having the same value for all predecessors.
    for (const auto &phi : inserted_phis) {
        if (auto common = getCommonValue(phi)) {
            phi->replaceSelf(common);
            eliminated.emplace_back(phi);
        }
    }

    // If we disabled PRE on loop backedge, some insertions will be redundant,
    // since the original algorithm is broken.
    // Any insertions are to satisfy the anticipation in the successors, but the
    // successor might cannot do PRE due to backedge.
    // For example (extended from the previous one):
    //
    //                                       (New Latch)
    //                      A              |<-- bb0 <-|
    //                      |           (*)|          |
    //                      V              V          |
    //         B  ----> PreHeader ---> Header ---> Old Latch
    //                      |                        |
    //                      v                        |
    //                     Exit  <--------------------
    //
    // If Header needs something that is available in A and B,
    // but not directly available in PreHeader and totally unavailable in bb0.
    // Typically, GVN-PRE will:
    //   1. Insert a Phi in the PreHeader to merge the available value from A and B.
    //   2. Hoist the computation in the Header to bb0.
    //   3. Insert a Phi in the Header to merge the phi inserted in step 1
    //      and the computation hoisted in step 2.
    // But if we disabled PRE on backedge, step 2 and 3 will not happen.
    // Thus, the phi inserted in step 1 is fully redundant.
    //
    // So we eliminate the redundant phi.
    if (disable_PRE_on_loop_backedge) {
        std::vector<pInst> worklist;
        worklist.reserve(inserted_phis.size());
        for (const auto &phi : inserted_phis)
            worklist.emplace_back(phi);
        eliminateDeadInsts(worklist);
        auto all_removed = [&] {
            for (const auto &inst : inserted_phis) {
                if (inst->getParent() != nullptr)
                    return false;
            }
            return true;
        }();
        if (all_removed)
            gvnpre_hoisted_inst = false;
    }

    eliminateDeadInsts(eliminated, &fam);

    // cleanup to release temp objects
    reset();

    if (gvnpre_folded_phi || gvnpre_replaced_value || gvnpre_hoisted_inst)
        return PreserveCFGAnalyses();
    return PreserveAll();
}
} // namespace IR
