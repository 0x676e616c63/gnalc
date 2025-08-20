// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/analysis/range_analysis.hpp"

#include "config/config.hpp"
#include "ir/base.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "legacy_mir/instructions/copy.hpp"
#include "match/match.hpp"
#include "utils/logger.hpp"

#include <deque>
#include <string>

namespace IR {
PM::UniqueKey RangeAnalysis::Key;

IRng RangeResult::getIntRange(Value *val, BasicBlock *bb) const {
    if (auto ci32 = val->as<ConstantInt>())
        return IRng(ci32->getVal());
    if (auto ci1 = val->as<ConstantI1>())
        return IRng(ci1->getVal());
    if (auto ci8 = val->as<ConstantI8>())
        return IRng(ci8->getVal());
    auto it = int_range_map.find(val);
    if (it == int_range_map.end())
        return IRng();
    if (bb)
        return it->second.getContextual(bb);
    return it->second.getGlobal();
}
IRng RangeResult::getIntRange(const pVal &val, const pBlock &bb) const { return getIntRange(val.get(), bb.get()); }

FRng RangeResult::getFloatRange(Value *val, BasicBlock *bb) const {
    if (auto ci32 = val->as<ConstantFloat>())
        return FRng(ci32->getVal());

    auto it = float_range_map.find(val);
    if (it == float_range_map.end())
        return FRng();
    if (bb)
        return it->second.getContextual(bb);
    return it->second.getGlobal();
}
FRng RangeResult::getFloatRange(const pVal &val, const pBlock &bb) const { return getFloatRange(val.get(), bb.get()); }

IRng RangeResult::getIntRange(Value *val, ICtxRng::Edge edge) const {
    if (auto ci32 = val->as<ConstantInt>())
        return IRng(ci32->getVal());
    if (auto ci1 = val->as<ConstantI1>())
        return IRng(ci1->getVal());
    if (auto ci8 = val->as<ConstantI8>())
        return IRng(ci8->getVal());
    auto it = int_range_map.find(val);
    if (it == int_range_map.end())
        return IRng();
    return it->second.getEdge(edge);
}
IRng RangeResult::getIntRange(const pVal &val, ICtxRng::Edge edge) const { return getIntRange(val.get(), edge); }
FRng RangeResult::getFloatRange(Value *val, FCtxRng::Edge edge) const {
    if (auto ci32 = val->as<ConstantFloat>())
        return FRng(ci32->getVal());

    auto it = float_range_map.find(val);
    if (it == float_range_map.end())
        return FRng();
    return it->second.getEdge(edge);
}
FRng RangeResult::getFloatRange(const pVal &val, FCtxRng::Edge edge) const { return getFloatRange(val.get(), edge); }

bool RangeResult::knownNonNegative(Value *val, BasicBlock *bb) const {
    if (auto ci32 = val->as<ConstantInt>())
        return ci32->getVal() >= 0;
    if (auto ci8 = val->as<ConstantI8>())
        return ci8->getVal() >= 0;
    if (auto ci1 = val->as<ConstantI1>())
        return true;
    if (auto cf32 = val->as<ConstantFloat>())
        return cf32->getVal() >= 0.0f;

    if (val->getType()->isInteger()) {
        auto rng = getIntRange(val, bb);
        if (rng.min != IRng::MIN && rng.min >= 0)
            return true;
    }
    if (val->getType()->isFloatingPoint()) {
        auto rng = getFloatRange(val, bb);
        if (rng.min != FRng::MIN && rng.min >= 0.0f)
            return true;
    }
    return false;
}
bool RangeResult::knownNonNegative(const pVal &val, const pBlock &bb) const {
    return knownNonNegative(val.get(), bb.get());
}

bool RangeResult::knownNonNegative(Value *val, BasicBlockEdge edge) const {
    if (auto ci32 = val->as<ConstantInt>())
        return ci32->getVal() >= 0;
    if (auto ci8 = val->as<ConstantI8>())
        return ci8->getVal() >= 0;
    if (auto ci1 = val->as<ConstantI1>())
        return true;
    if (auto cf32 = val->as<ConstantFloat>())
        return cf32->getVal() >= 0.0f;

    if (val->getType()->isInteger()) {
        auto rng = getIntRange(val, edge);
        if (rng.min != IRng::MIN && rng.min >= 0)
            return true;
    }
    if (val->getType()->isFloatingPoint()) {
        auto rng = getFloatRange(val, edge);
        if (rng.min != FRng::MIN && rng.min >= 0.0f)
            return true;
    }
    return false;
}

bool RangeResult::knownNonNegative(const pVal &val, BasicBlockEdge edge) const {
    return knownNonNegative(val.get(), edge);
}

bool RangeResult::intersect(Value *val, const IRng &range) { return int_range_map[val].intersectGlobal(range); }
bool RangeResult::intersect(Value *val, const IRng &range, BasicBlock *bb) {
    if (auto inst = val->as_raw<Instruction>()) {
        if (inst->getParent().get() == bb) {
            return intersect(inst, range);
        }
    }
    return int_range_map[val].intersectContextual(range, bb);
}

bool RangeResult::intersect(Value *val, const FRng &range) { return float_range_map[val].intersectGlobal(range); }
bool RangeResult::intersect(Value *val, const FRng &range, BasicBlock *bb) {
    if (auto inst = val->as_raw<Instruction>()) {
        if (inst->getParent().get() == bb) {
            return intersect(inst, range);
        }
    }
    return float_range_map[val].intersectContextual(range, bb);
}

bool RangeResult::intersect(Value *val, const IRng &range, ICtxRng::Edge edge) {
    return int_range_map[val].intersectEdge(range, edge);
}
bool RangeResult::intersect(Value *val, const FRng &range, FCtxRng::Edge edge) {
    return float_range_map[val].intersectEdge(range, edge);
}

bool RangeResult::merge(Value *val, const IRng &range) { return int_range_map[val].mergeGlobal(range); }
bool RangeResult::merge(Value *val, const IRng &range, BasicBlock *bb) {
    if (auto inst = val->as_raw<Instruction>()) {
        if (inst->getParent().get() == bb) {
            return merge(inst, range);
        }
    }
    return int_range_map[val].mergeContextual(range, bb);
}

bool RangeResult::merge(Value *val, const FRng &range) { return float_range_map[val].mergeGlobal(range); }
bool RangeResult::merge(Value *val, const FRng &range, BasicBlock *bb) {
    if (auto inst = val->as_raw<Instruction>()) {
        if (inst->getParent().get() == bb) {
            return merge(inst, range);
        }
    }
    return float_range_map[val].mergeContextual(range, bb);
}

void RangeAnalysis::analyzeCallSites(RangeResult &res, Function *func, FAM *fam) {
    if (func->isRecursive())
        return;

    auto unique_retval = [&]() -> Value * {
        if (func->getRetType()->isVoid())
            return nullptr;

        Value *retval = nullptr;
        for (const auto &bb : *func) {
            for (const auto &inst : *bb) {
                if (auto ret = inst->as<RETInst>()) {
                    if (retval)
                        return nullptr;
                    retval = ret->getRetVal().get();
                }
            }
        }
        if (!retval)
            Logger::logWarning("Non-void function '", func->getName(), "' has no return value");
        return retval;
    }();

    bool initial_range_set = false;
    for (const auto &inst_user : func->inst_users()) {
        auto call = inst_user->as<CALLInst>();
        Err::gassert(call != nullptr);
        if (call->getFunc().get() != func)
            continue;
        auto caller_func = call->getParent()->getParent();
        if (caller_func.get() != func) {
            const auto caller_res = fam->getResult<RangeAnalysis>(*caller_func);
            auto actual_args = call->getArgs();

            if (!initial_range_set) {
                initial_range_set = true;
                if (unique_retval) {
                    if (unique_retval->getType()->isInteger())
                        res.intersect(unique_retval, caller_res.getIntRange(call, call->getParent()));
                    else if (unique_retval->getType()->isFloatingPoint())
                        res.intersect(unique_retval, caller_res.getFloatRange(call, call->getParent()));
                }
                for (const auto &fp : func->getParams()) {
                    if (fp->getType()->isInteger())
                        res.intersect(fp.get(), caller_res.getIntRange(actual_args[fp->getIndex()], call->getParent()));
                    else if (fp->getType()->isFloatingPoint())
                        res.intersect(fp.get(),
                                      caller_res.getFloatRange(actual_args[fp->getIndex()], call->getParent()));
                }
            } else {
                if (unique_retval) {
                    if (unique_retval->getType()->isInteger())
                        res.merge(unique_retval, caller_res.getIntRange(call, call->getParent()));
                    else if (unique_retval->getType()->isFloatingPoint())
                        res.merge(unique_retval, caller_res.getFloatRange(call, call->getParent()));
                }
                for (const auto &fp : func->getParams()) {
                    if (fp->getType()->isInteger())
                        res.merge(fp.get(), caller_res.getIntRange(actual_args[fp->getIndex()], call->getParent()));
                    else if (fp->getType()->isFloatingPoint())
                        res.merge(fp.get(), caller_res.getFloatRange(actual_args[fp->getIndex()], call->getParent()));
                }
            }
        }
    }
}

std::tuple<unsigned, unsigned, unsigned> countOperSign(RangeResult &res, PHIInst *phi) {
    unsigned known_negative = 0;
    unsigned zero = 0;
    unsigned known_positive = 0;
    auto phi_bb = phi->getParent().get();
    if (phi->getType()->isInteger()) {
        for (const auto &[val, bb] : phi->incomings()) {
            auto rng = res.getIntRange(val, BasicBlockEdge{bb.get(), phi_bb});
            if (rng.min > 0)
                known_positive++;
            if (rng.max < 0)
                known_negative++;
            if (rng.min == 0 && rng.max == 0)
                zero++;
        }
    } else if (phi->getType()->isFloatingPoint()) {
        for (const auto &[val, bb] : phi->incomings()) {
            auto rng = res.getFloatRange(val, BasicBlockEdge{bb.get(), phi_bb});
            if (rng.min > 0.0f)
                known_positive++;
            if (rng.max < 0.0f)
                known_negative++;
            if (rng.min == 0.0f && rng.max == 0.0f)
                zero++;
        }
    }
    return {known_negative, zero, known_positive};
}

enum class PhiOperSign { Same, PositiveIfPositive, NegativeIfNegative, Determined, Unknown };
PhiOperSign analyzePhiOperSign(RangeResult &res, PHIInst *phi, Value *oper, BasicBlock *oper_bb = nullptr) {
    BasicBlockEdge edge = {oper_bb, phi->getParent().get()};
    if (phi->getType()->isInteger()) {
        auto rng = res.getIntRange(oper, edge);
        if (rng.min >= 0 || rng.max <= 0)
            return PhiOperSign::Determined;
    } else if (phi->getType()->isFloatingPoint()) {
        auto rng = res.getFloatRange(oper, edge);
        if (rng.min >= 0.0f || rng.max <= 0.0f)
            return PhiOperSign::Determined;
    }

    auto binary = oper->as<BinaryInst>();
    if (!binary)
        return PhiOperSign::Unknown;

    auto lhs = binary->getLHS().get();
    auto rhs = binary->getRHS().get();

    if ((lhs != phi && rhs != phi) || (lhs == phi && rhs == phi))
        return PhiOperSign::Unknown;

    auto opcode = binary->getOpcode();
    auto non_phi_oper = lhs == phi ? rhs : lhs;

    if (res.knownNonNegative(non_phi_oper, edge)) {
        if (opcode == OP::MUL || opcode == OP::SDIV || opcode == OP::UDIV || opcode == OP::FMUL || opcode == OP::FDIV)
            return PhiOperSign::Same;

        if (opcode == OP::ADD || opcode == OP::FADD)
            return PhiOperSign::PositiveIfPositive;

        if ((opcode == OP::SUB || opcode == OP::FSUB) && non_phi_oper == rhs)
            return PhiOperSign::NegativeIfNegative;
    }
    return PhiOperSign::Unknown;
}

enum class PhiSign { NonNegative, NonPositive, Zero, Unknown };
PhiSign analyzePhiSign(RangeResult &res, PHIInst *phi) {
    auto [negative, zero, positive] = countOperSign(res, phi);
    if (negative == 0 && positive == 0 && zero == 0)
        return PhiSign::Unknown;

    for (const auto &[val, bb] : phi->incomings()) {
        switch (analyzePhiOperSign(res, phi, val.get(), bb.get())) {
        case PhiOperSign::Same:
        case PhiOperSign::Determined:
            continue;
        case PhiOperSign::Unknown:
            return PhiSign::Unknown;
        case PhiOperSign::PositiveIfPositive:
            if (negative != 0)
                return PhiSign::Unknown;
            break;
        case PhiOperSign::NegativeIfNegative:
            if (positive != 0)
                return PhiSign::Unknown;
            break;
        default:
            Err::unreachable();
        }
    }

    if (negative == 0)
        return PhiSign::NonNegative;

    if (positive == 0)
        return PhiSign::NonPositive;

    return PhiSign::Zero;
}

void RangeAnalysis::analyzeGlobal(RangeResult &res, Function *func, FAM *fam) {
    auto bbdfv = func->getDFVisitor();

    std::unordered_map<Instruction *, int> process_cnt;
    std::deque<Instruction *> worklist;
    std::unordered_set<Instruction *> in_worklist;

    for (const auto &bb : bbdfv) {
        for (const auto &inst : *bb) {
            worklist.emplace_back(inst.get());
            in_worklist.emplace(inst.get());
        }
    }

    auto propagateToUsers = [&](const Value *v) {
        for (const auto &user : v->inst_users()) {
            if (!in_worklist.count(user.get()) &&
                process_cnt[user.get()] < Config::IR::RANGE_ANALYSIS_MAX_PROCESS_CNT) {
                worklist.push_back(user.get());
                in_worklist.emplace(user.get());
            }
        }
    };

    std::function<void(Value *, const IRng &)> intersectInt;
    intersectInt = [&](Value *v, const IRng &rng) {
        if (!v->is<Instruction, FormalParam>())
            return;

        // Backward propagation to operands
        if (auto binary = v->as_raw<BinaryInst>()) {
            if (binary->getOpcode() == OP::MUL || binary->getOpcode() == OP::SDIV || binary->getOpcode() == OP::SREM) {
                if (res.knownNonNegative(v)) {
                    if (res.knownNonNegative(binary->getLHS().get()))
                        intersectInt(binary->getRHS().get(), IRng(0, IRng::MAX));
                    if (res.knownNonNegative(binary->getRHS().get()))
                        intersectInt(binary->getLHS().get(), IRng(0, IRng::MAX));
                }
            }
        }

        if (res.intersect(v, rng))
            propagateToUsers(v);
    };

    std::function<void(Value *, const FRng &)> intersectFloat;
    intersectFloat = [&](Value *v, const FRng &rng) {
        if (!v->is<Instruction, FormalParam>())
            return;

        // Backward propagation to operands
        if (auto binary = v->as_raw<BinaryInst>()) {
            if (binary->getOpcode() == OP::FMUL || binary->getOpcode() == OP::FDIV || binary->getOpcode() == OP::FREM) {
                if (res.knownNonNegative(v)) {
                    if (res.knownNonNegative(binary->getLHS().get()))
                        intersectFloat(binary->getRHS().get(), FRng(0.0f, FRng::MAX));
                    if (res.knownNonNegative(binary->getRHS().get()))
                        intersectFloat(binary->getLHS().get(), FRng(0.0f, FRng::MAX));
                }
            }
        }

        if (res.intersect(v, rng))
            propagateToUsers(v);
    };
    // Instructions
    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();
        in_worklist.erase(inst);
        ++process_cnt[inst];

        bool is_btype = inst->getType()->is<BType>();
        bool is_int = is_btype && inst->getType()->isI32();
        bool is_float = is_btype && inst->getType()->isF32();

        if (auto binary = inst->as_raw<BinaryInst>()) {
            if (is_int) {
                auto lrng = res.getIntRange(binary->getLHS());
                auto rrng = res.getIntRange(binary->getRHS());
                if (binary->getOpcode() == OP::ADD)
                    intersectInt(binary, lrng + rrng);
                else if (binary->getOpcode() == OP::SUB)
                    intersectInt(binary, lrng - rrng);
                else if (binary->getOpcode() == OP::MUL)
                    intersectInt(binary, lrng * rrng);
                else if (binary->getOpcode() == OP::SDIV || binary->getOpcode() == OP::UDIV)
                    intersectInt(binary, lrng / rrng);
                else if (binary->getOpcode() == OP::SREM)
                    intersectInt(binary, lrng % rrng);
                else if (binary->getOpcode() == OP::UREM)
                    intersectInt(binary, lrng.urem(rrng));
                else if (binary->getOpcode() == OP::SHL)
                    intersectInt(binary, lrng.shl(rrng));
                else if (binary->getOpcode() == OP::LSHR)
                    intersectInt(binary, lrng.lshr(rrng));
                else if (binary->getOpcode() == OP::ASHR)
                    intersectInt(binary, lrng.ashr(rrng));
                else if (binary->getOpcode() == OP::AND)
                    intersectInt(binary, lrng & rrng);
                else if (binary->getOpcode() == OP::OR)
                    intersectInt(binary, lrng | rrng);
                else if (binary->getOpcode() == OP::XOR)
                    intersectInt(binary, lrng ^ rrng);
                else
                    Err::unreachable();
            } else if (is_float) {
                auto lrng = res.getFloatRange(binary->getLHS());
                auto rrng = res.getFloatRange(binary->getRHS());
                if (binary->getOpcode() == OP::FADD)
                    intersectFloat(binary, lrng + rrng);
                else if (binary->getOpcode() == OP::FSUB)
                    intersectFloat(binary, lrng - rrng);
                else if (binary->getOpcode() == OP::FMUL)
                    intersectFloat(binary, lrng * rrng);
                else if (binary->getOpcode() == OP::FDIV)
                    intersectFloat(binary, lrng / rrng);
                else if (binary->getOpcode() == OP::FREM)
                    intersectFloat(binary, lrng % rrng);
                else
                    Err::unreachable();
            }
        } else if (auto fneg = inst->as_raw<FNEGInst>()) {
            const auto &vrng = res.getFloatRange(fneg->getVal());
            intersectFloat(fneg, -vrng);
        } else if (auto fptosi = inst->as_raw<FPTOSIInst>()) {
            const auto &vrng = res.getFloatRange(fptosi->getOVal());
            intersectInt(fptosi, range_cast<int>(vrng));
        } else if (auto sitofp = inst->as_raw<SITOFPInst>()) {
            const auto &vrng = res.getIntRange(sitofp->getOVal());
            intersectFloat(sitofp, range_cast<float>(vrng));
        } else if (auto zext = inst->as_raw<ZEXTInst>()) {
            const auto &vrng = res.getIntRange(zext->getOVal());
            intersectInt(zext, vrng);
        } else if (auto sext = inst->as_raw<SEXTInst>()) {
            const auto &vrng = res.getIntRange(sext->getOVal());
            intersectInt(sext, vrng);
        } else if (auto phi = inst->as_raw<PHIInst>()) {
            auto phi_opers = phi->getPhiOpers();
            auto phi_sign = analyzePhiSign(res, phi);
            if (is_int) {
                auto base = res.getIntRange(phi_opers[0].value);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getIntRange(phi_opers[i].value));

                switch (phi_sign) {
                case PhiSign::Zero:
                    base.intersect(IRng(0, 0));
                    break;
                case PhiSign::NonNegative:
                    base.intersect(IRng(0, IRng::MAX));
                    break;
                case PhiSign::NonPositive:
                    base.intersect(IRng(IRng::MIN, 0));
                    break;
                case PhiSign::Unknown:
                    break;
                default:
                    Err::unreachable();
                }

                intersectInt(phi, base);
            } else if (is_float) {
                auto base = res.getFloatRange(phi_opers[0].value);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getFloatRange(phi_opers[i].value));

                switch (phi_sign) {
                case PhiSign::Zero:
                    base.intersect(FRng(0.0f, 0.0f));
                    break;
                case PhiSign::NonNegative:
                    base.intersect(FRng(0.0f, FRng::MAX));
                    break;
                case PhiSign::NonPositive:
                    base.intersect(FRng(FRng::MIN, 0.0f));
                    break;
                case PhiSign::Unknown:
                    break;
                default:
                    Err::unreachable();
                }

                intersectFloat(phi, base);
            }
        } else if (auto select = inst->as_raw<SELECTInst>()) {
            if (is_int) {
                auto trng = res.getIntRange(select->getTrueVal());
                auto frng = res.getIntRange(select->getFalseVal());
                intersectInt(select, merge(trng, frng));
            } else if (is_float) {
                auto trng = res.getFloatRange(select->getTrueVal());
                auto frng = res.getFloatRange(select->getFalseVal());
                intersectFloat(select, merge(trng, frng));
            }
        } else if (auto call = inst->as_raw<CALLInst>()) {
            if (is_int && call->getFunc()->hasFnAttr(FuncAttr::PromoteFromChar))
                intersectInt(call, IRng(0, 256));
            else {
                if (is_int)
                    intersectInt(call, IRng());
                else if (is_float)
                    intersectFloat(call, FRng());
            }
        } else if (inst->is<ICMPInst, FCMPInst>())
            intersectInt(inst, IRng(0, 1));
        else {
            if (is_btype) {
                if (is_int)
                    intersectInt(inst, IRng());
                else if (is_float)
                    intersectFloat(inst, FRng());
            }
        }
    }
}

void RangeAnalysis::analyzeContextual(RangeResult &res, Function *func, FAM *fam) {
    auto bbdfv = func->getDFVisitor();
    auto &domtree = fam->getResult<DomTreeAnalysis>(*func);

    std::unordered_map<std::pair<Instruction *, BasicBlock *>, int, Util::PairHash> process_cnt;
    std::deque<std::pair<Instruction *, BasicBlock *>> worklist;
    std::unordered_set<std::pair<Instruction *, BasicBlock *>, Util::PairHash> in_worklist;

    for (const auto &bb : bbdfv) {
        for (const auto &inst : *bb) {
            if (inst->is<GEPInst, ICMPInst, FCMPInst>()) {
                worklist.emplace_back(inst.get(), bb.get());
                in_worklist.emplace(inst.get(), bb.get());
            }
        }
        // Induction variables
        for (const auto &phi : bb->phis()) {
            worklist.emplace_back(phi.get(), bb.get());
            in_worklist.emplace(phi.get(), bb.get());
        }
    }

    auto propagateToDomUsers = [&](Value *v, BasicBlock *bb) {
        for (const auto &user : v->inst_users()) {
            if (!domtree.ADomB(bb, user->getParent().get()))
                continue;

            auto key = std::make_pair(user.get(), user->getParent().get());
            if (!in_worklist.count(key) && process_cnt[key] < Config::IR::RANGE_ANALYSIS_MAX_PROCESS_CNT) {
                worklist.emplace_back(key);
                in_worklist.emplace(key);
            }
        }
    };

    std::function<bool(Value *, BasicBlock *, const IRng &)> intersectContextualInt;
    intersectContextualInt = [&](Value *v, BasicBlock *bb, const IRng &rng) {
        if (!v->is<Instruction, FormalParam>())
            return false;

        auto domdfv = domtree[bb]->getBFVisitor();
        bool modified = false;
        for (auto &node : domdfv)
            modified |= res.intersect(v, rng, node->raw_block());

        // Backward propagation to operands
        if (auto binary = v->as_raw<BinaryInst>()) {
            if (binary->getOpcode() == OP::MUL || binary->getOpcode() == OP::SDIV || binary->getOpcode() == OP::SREM) {
                if (res.knownNonNegative(v, bb)) {
                    if (res.knownNonNegative(binary->getLHS().get(), bb))
                        intersectContextualInt(binary->getRHS().get(), bb, IRng(0, IRng::MAX));
                    if (res.knownNonNegative(binary->getRHS().get(), bb))
                        intersectContextualInt(binary->getLHS().get(), bb, IRng(0, IRng::MAX));
                }
            }
        }

        if (modified)
            propagateToDomUsers(v, bb);
        return modified;
    };

    std::function<bool(Value *, BasicBlock *, const FRng &)> intersectContextualFloat;
    intersectContextualFloat = [&](Value *v, BasicBlock *bb, const FRng &rng) {
        if (!v->is<Instruction, FormalParam>())
            return false;

        auto domdfv = domtree[bb]->getBFVisitor();
        bool modified = false;
        for (auto &node : domdfv)
            modified |= res.intersect(v, rng, node->raw_block());

        // Backward propagation to operands
        if (auto binary = v->as_raw<BinaryInst>()) {
            if (binary->getOpcode() == OP::FMUL || binary->getOpcode() == OP::FDIV || binary->getOpcode() == OP::FREM) {
                if (res.knownNonNegative(v, bb)) {
                    if (res.knownNonNegative(binary->getLHS().get(), bb))
                        intersectContextualFloat(binary->getRHS().get(), bb, FRng(0.0f, FRng::MAX));
                    if (res.knownNonNegative(binary->getRHS().get(), bb))
                        intersectContextualFloat(binary->getLHS().get(), bb, FRng(0.0f, FRng::MAX));
                }
            }
        }

        if (modified)
            propagateToDomUsers(v, bb);
        return modified;
    };

    auto intersectEdgeInt = [&](Value *v, const ICtxRng::Edge &edge, const IRng &rng) {
        if (!v->is<Instruction, FormalParam>())
            return false;
        return res.intersect(v, rng, edge);
    };

    auto intersectEdgeFloat = [&](Value *v, const FCtxRng::Edge &edge, const FRng &rng) {
        if (!v->is<Instruction, FormalParam>())
            return false;
        return res.intersect(v, rng, edge);
    };

    auto &scev = fam->getResult<SCEVAnalysis>(*func);
    while (!worklist.empty()) {
        auto pair = worklist.front();
        worklist.pop_front();
        in_worklist.erase(pair);
        ++process_cnt[pair];

        // lambda captured structured bindings are a C++20 extension [-Wc++20-extensions]
        auto inst = pair.first;
        auto bb = pair.second;

        bool is_int = inst->getType()->isInteger();
        bool is_float = inst->getType()->isFloatingPoint();

        // Check SCEV
        // FIXME: SCEV cannot figure out complex induction variables, since its goal
        //        is to compute the exact formula of the expression.
        //        For induction variables that are not computable by SCEV, we still have
        //        methods to determine whether it is non-negative.
        //        For example, writing a SCEV-like algorithm that only figures out whether
        //        its expression is non-negative, rather than getting a `Untracked` result too early.
        // TODO: Extend SCEV or implement it in place.
        if (inst->getType()->isI32()) {
            auto analyzeSCEVExpr = [](SCEVExpr *expr) {
                if (!expr->isIRValue())
                    return IRng();
                if (int c; match(expr->getIRValue(), M::Bind(c)))
                    return IRng(c);
                return IRng();
            };

            auto analyzeAddRec = [&scev, &bb, &res](TREC *trec) {
                // For constant affine addrec, at least one bound can be determined.
                if (auto constant_addrec = trec->getConstantAffineAddRec()) {
                    auto [base, step] = *constant_addrec;

                    // If the trip count can be statically determined, compute a more precise range.
                    if (auto trip_count = scev.getTripCount(trec->getLoop())) {
                        int c;
                        if (trip_count->isIRValue() && match(trip_count->getIRValue(), M::Bind(c))) {
                            auto m = static_cast<IRng::Bigger>(base) +
                                     static_cast<IRng::Bigger>(step) * static_cast<IRng::Bigger>(c);
                            if (step > 0)
                                return IRng(base, m);
                            return IRng(m, base);
                        }
                    }

                    // Fallback: unknown trip count
                    if (step > 0)
                        return IRng(base, IRng::MAX);
                    return IRng(IRng::MIN, base);
                }

                // Fallback: affine addrec, see if they are non-negative
                if (auto addrec = trec->getAffineAddRec()) {
                    auto [base, step] = *addrec;
                    if (base->isIRValue() && step->isIRValue()) {
                        if (res.knownNonNegative(base->getRawIRValue(), bb) &&
                            res.knownNonNegative(step->getRawIRValue(), bb)) {
                            return IRng(0, IRng::MAX);
                        }
                    }
                }
                return IRng();
            };

            auto trec = scev.getSCEVAtBlock(inst, bb);
            if (trec->isExpr()) {
                if (intersectContextualInt(inst, bb, analyzeSCEVExpr(trec->getExpr())))
                    continue;
            } else if (trec->isAddRec()) {
                if (intersectContextualInt(inst, bb, analyzeAddRec(trec)))
                    continue;
            }
        }

        if (auto binary = inst->as_raw<BinaryInst>()) {
            if (is_int) {
                auto lrng = res.getIntRange(binary->getLHS().get(), bb);
                auto rrng = res.getIntRange(binary->getRHS().get(), bb);
                if (binary->getOpcode() == OP::ADD)
                    intersectContextualInt(binary, bb, lrng + rrng);
                else if (binary->getOpcode() == OP::SUB)
                    intersectContextualInt(binary, bb, lrng - rrng);
                else if (binary->getOpcode() == OP::MUL)
                    intersectContextualInt(binary, bb, lrng * rrng);
                else if (binary->getOpcode() == OP::SDIV || binary->getOpcode() == OP::UDIV)
                    intersectContextualInt(binary, bb, lrng / rrng);
                else if (binary->getOpcode() == OP::SREM)
                    intersectContextualInt(binary, bb, lrng % rrng);
                else if (binary->getOpcode() == OP::UREM)
                    intersectContextualInt(binary, bb, lrng.urem(rrng));
                else if (binary->getOpcode() == OP::SHL)
                    intersectContextualInt(binary, bb, lrng.shl(rrng));
                else if (binary->getOpcode() == OP::LSHR)
                    intersectContextualInt(binary, bb, lrng.lshr(rrng));
                else if (binary->getOpcode() == OP::ASHR)
                    intersectContextualInt(binary, bb, lrng.ashr(rrng));
                else if (binary->getOpcode() == OP::AND)
                    intersectContextualInt(binary, bb, lrng & rrng);
                else if (binary->getOpcode() == OP::OR)
                    intersectContextualInt(binary, bb, lrng | rrng);
                else if (binary->getOpcode() == OP::XOR)
                    intersectContextualInt(binary, bb, lrng ^ rrng);
                else
                    Err::unreachable();
            } else if (is_float) {
                auto lrng = res.getFloatRange(binary->getLHS().get(), bb);
                auto rrng = res.getFloatRange(binary->getRHS().get(), bb);
                if (binary->getOpcode() == OP::FADD)
                    intersectContextualFloat(binary, bb, lrng + rrng);
                else if (binary->getOpcode() == OP::FSUB)
                    intersectContextualFloat(binary, bb, lrng - rrng);
                else if (binary->getOpcode() == OP::FMUL)
                    intersectContextualFloat(binary, bb, lrng * rrng);
                else if (binary->getOpcode() == OP::FDIV)
                    intersectContextualFloat(binary, bb, lrng / rrng);
                else if (binary->getOpcode() == OP::FREM)
                    intersectContextualFloat(binary, bb, lrng % rrng);
                else
                    Err::unreachable();
            }
        } else if (auto fneg = inst->as_raw<FNEGInst>()) {
            const auto &vrng = res.getFloatRange(fneg->getVal().get(), bb);
            intersectContextualFloat(fneg, bb, -vrng);
        } else if (auto fptosi = inst->as_raw<FPTOSIInst>()) {
            const auto &vrng = res.getFloatRange(fptosi->getOVal().get(), bb);
            intersectContextualInt(fptosi, bb, range_cast<int>(vrng));
        } else if (auto sitofp = inst->as_raw<SITOFPInst>()) {
            const auto &vrng = res.getIntRange(sitofp->getOVal().get(), bb);
            intersectContextualFloat(sitofp, bb, range_cast<float>(vrng));
        } else if (auto zext = inst->as_raw<ZEXTInst>()) {
            const auto &vrng = res.getIntRange(zext->getOVal().get(), bb);
            intersectContextualInt(zext, bb, vrng);
        } else if (auto sext = inst->as_raw<SEXTInst>()) {
            const auto &vrng = res.getIntRange(sext->getOVal().get(), bb);
            intersectContextualInt(sext, bb, vrng);
        } else if (auto phi = inst->as_raw<PHIInst>()) {
            auto phi_opers = phi->getPhiOpers();
            auto phi_sign = analyzePhiSign(res, phi);

            if (is_int) {
                auto base = res.getIntRange(phi_opers[0].value, phi_opers[0].block);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getIntRange(phi_opers[i].value, phi_opers[i].block));

                switch (phi_sign) {
                case PhiSign::Zero:
                    base.intersect(IRng(0, 0));
                    break;
                case PhiSign::NonNegative:
                    base.intersect(IRng(0, IRng::MAX));
                    break;
                case PhiSign::NonPositive:
                    base.intersect(IRng(IRng::MIN, 0));
                    break;
                case PhiSign::Unknown:
                    break;
                default:
                    Err::unreachable();
                }

                intersectContextualInt(phi, bb, base);
            } else if (is_float) {
                auto base = res.getFloatRange(phi_opers[0].value, phi_opers[0].block);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getFloatRange(phi_opers[i].value, phi_opers[i].block));

                switch (phi_sign) {
                case PhiSign::Zero:
                    base.intersect(FRng(0.0f, 0.0f));
                    break;
                case PhiSign::NonNegative:
                    base.intersect(FRng(0.0f, FRng::MAX));
                    break;
                case PhiSign::NonPositive:
                    base.intersect(FRng(FRng::MIN, 0.0f));
                    break;
                case PhiSign::Unknown:
                    break;
                default:
                    Err::unreachable();
                }

                intersectContextualFloat(phi, bb, base);
            }
        } else if (auto select = inst->as_raw<SELECTInst>()) {
            if (is_int) {
                auto trng = res.getIntRange(select->getTrueVal().get(), bb);
                auto frng = res.getIntRange(select->getFalseVal().get(), bb);
                intersectContextualInt(select, bb, merge(trng, frng));
            } else if (is_float) {
                auto trng = res.getFloatRange(select->getTrueVal().get(), bb);
                auto frng = res.getFloatRange(select->getFalseVal().get(), bb);
                intersectContextualFloat(select, bb, merge(trng, frng));
            }
        } else if (auto icmp = inst->as_raw<ICMPInst>()) {
            auto lhs = icmp->getLHS().get();
            auto rhs = icmp->getRHS().get();
            auto lrng = res.getIntRange(lhs, bb);
            auto rrng = res.getIntRange(rhs, bb);
            auto icmp_bb = icmp->getParent().get();

            for (auto inst_user : icmp->inst_users()) {
                if (auto user_br = inst_user->as_raw<BRInst>()) {
                    auto truebb = user_br->getTrueDest().get();
                    auto falsebb = user_br->getFalseDest().get();

                    bool truebb_can_set = truebb->getNumPreds() == 1;
                    bool falsebb_can_set = falsebb->getNumPreds() == 1;

                    auto tryIntersectTrue = [&](Value *val, const IRng &rng) {
                        intersectEdgeInt(val, BasicBlockEdge{icmp_bb, truebb}, rng);
                        if (truebb_can_set)
                            intersectContextualInt(val, truebb, rng);
                    };
                    auto tryIntersectFalse = [&](Value *val, const IRng &rng) {
                        intersectEdgeInt(val, BasicBlockEdge{icmp_bb, falsebb}, rng);
                        if (falsebb_can_set)
                            intersectContextualInt(val, falsebb, rng);
                    };

                    switch (icmp->getCond()) {
                    case ICMPOP::eq:
                        tryIntersectTrue(lhs, rrng);
                        tryIntersectTrue(rhs, lrng);
                        break;
                    case ICMPOP::ne:
                        tryIntersectFalse(lhs, rrng);
                        tryIntersectFalse(rhs, lrng);
                        break;
                    case ICMPOP::slt:
                        // lhs < rhs
                        if (rrng.max != IRng::MAX)
                            tryIntersectTrue(lhs, IRng(IRng::MIN, rrng.max - 1));
                        if (lrng.min != IRng::MIN)
                            tryIntersectTrue(rhs, IRng(lrng.min + 1, IRng::MAX));

                        // lhs >= rhs
                        if (rrng.min != IRng::MIN)
                            tryIntersectFalse(lhs, IRng(rrng.min, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryIntersectFalse(rhs, IRng(IRng::MIN, lrng.max));
                        break;
                    case ICMPOP::sle:
                        // lhs <= rhs
                        if (rrng.max != IRng::MAX)
                            tryIntersectTrue(lhs, IRng(IRng::MIN, rrng.max));
                        if (lrng.min != IRng::MIN)
                            tryIntersectTrue(rhs, IRng(lrng.min, IRng::MAX));

                        // lhs > rhs
                        if (rrng.min != IRng::MIN)
                            tryIntersectFalse(lhs, IRng(rrng.min + 1, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryIntersectFalse(rhs, IRng(IRng::MIN, lrng.max - 1));
                        break;
                    case ICMPOP::sgt:
                        // lhs > rhs
                        if (rrng.min != IRng::MIN)
                            tryIntersectTrue(lhs, IRng(rrng.min + 1, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryIntersectTrue(rhs, IRng(IRng::MIN, lrng.max - 1));

                        // lhs <= rhs
                        if (rrng.max != IRng::MAX)
                            tryIntersectFalse(lhs, IRng(IRng::MIN, rrng.max));
                        if (lrng.min != IRng::MIN)
                            tryIntersectFalse(rhs, IRng(lrng.min, IRng::MAX));
                        break;
                    case ICMPOP::sge:
                        // lhs >= rhs
                        if (rrng.min != IRng::MIN)
                            tryIntersectTrue(lhs, IRng(rrng.min, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryIntersectTrue(rhs, IRng(IRng::MIN, lrng.max));

                        // lhs < rhs
                        if (rrng.max != IRng::MAX)
                            tryIntersectFalse(lhs, IRng(IRng::MIN, rrng.max - 1));
                        if (lrng.min != IRng::MIN)
                            tryIntersectFalse(rhs, IRng(lrng.min + 1, IRng::MAX));
                        break;
                    default:
                        Err::unreachable();
                    }
                }
            }
        } else if (auto fcmp = inst->as_raw<FCMPInst>()) {
            auto lhs = fcmp->getLHS().get();
            auto rhs = fcmp->getRHS().get();
            auto lrng = res.getFloatRange(lhs, bb);
            auto rrng = res.getFloatRange(rhs, bb);
            auto fcmp_bb = fcmp->getParent().get();

            for (auto inst_user : fcmp->inst_users()) {
                if (auto user_br = inst_user->as_raw<BRInst>()) {
                    auto truebb = user_br->getTrueDest().get();
                    auto falsebb = user_br->getFalseDest().get();
                    bool truebb_can_set = truebb->getNumPreds() == 1;
                    bool falsebb_can_set = falsebb->getNumPreds() == 1;

                    auto tryIntersectTrue = [&](Value *val, const FRng &rng) {
                        intersectEdgeFloat(val, {fcmp_bb, truebb}, rng);
                        if (truebb_can_set)
                            intersectContextualFloat(val, truebb, rng);
                    };
                    auto tryIntersectFalse = [&](Value *val, const FRng &rng) {
                        intersectEdgeFloat(val, {fcmp_bb, falsebb}, rng);
                        if (falsebb_can_set)
                            intersectContextualFloat(val, falsebb, rng);
                    };

                    switch (fcmp->getCond()) {
                    case FCMPOP::oeq:
                        tryIntersectTrue(lhs, rrng);
                        tryIntersectTrue(rhs, lrng);
                        break;
                    case FCMPOP::one:
                        tryIntersectFalse(lhs, rrng);
                        tryIntersectFalse(rhs, lrng);
                        break;
                    default:
                        break;
                    }
                }
            }
        } else if (auto gep = inst->as_raw<GEPInst>()) {
            auto idxs = gep->getIdxs();
            for (const auto &idx : idxs) {
                if (idx->is<Instruction>())
                    intersectContextualInt(idx.get(), bb, IRng(0, IRng::MAX));
            }
        }
    }
}

RangeResult RangeAnalysis::run(Function &function, FAM &manager) {
    RangeResult res;
    analyzeCallSites(res, &function, &manager);
    analyzeGlobal(res, &function, &manager);
    analyzeContextual(res, &function, &manager);
    return res;
}
} // namespace IR