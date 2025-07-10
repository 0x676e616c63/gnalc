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
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "ir/match.hpp"
#include "match/match.hpp"
#include "utils/logger.hpp"

#include <deque>
#include <string>

namespace IR {
PM::UniqueKey RangeAnalysis::Key;

IRng RangeResult::getIntRange(Value *val) const {
    if (auto ci32 = val->as<ConstantInt>())
        return IRng(ci32->getVal());
    if (auto ci1 = val->as<ConstantI1>())
        return IRng(ci1->getVal());
    if (auto ci8 = val->as<ConstantI8>())
        return IRng(ci8->getVal());
    auto it = int_range_map.find(val);
    if (it == int_range_map.end())
        return IRng();
    return it->second.getGlobal();
}
IRng RangeResult::getIntRange(const pVal &val) const { return getIntRange(val.get()); }

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
    return it->second.getContextual(bb);
}
IRng RangeResult::getIntRange(const pVal &val, const pBlock &bb) const { return getIntRange(val.get(), bb.get()); }

FRng RangeResult::getFloatRange(Value *val) const {
    if (auto ci32 = val->as<ConstantFloat>())
        return FRng(ci32->getVal());

    auto it = float_range_map.find(val);
    if (it == float_range_map.end())
        return FRng();
    return it->second.getGlobal();
}
FRng RangeResult::getFloatRange(const pVal &val) const { return getFloatRange(val.get()); }

FRng RangeResult::getFloatRange(Value *val, BasicBlock *bb) const {
    if (auto ci32 = val->as<ConstantFloat>())
        return FRng(ci32->getVal());

    auto it = float_range_map.find(val);
    if (it == float_range_map.end())
        return FRng();
    return it->second.getContextual(bb);
}
FRng RangeResult::getFloatRange(const pVal &val, const pBlock &bb) const { return getFloatRange(val.get(), bb.get()); }

bool RangeResult::knownNonNegative(Value *val) const {
    if (auto ci32 = val->as<ConstantInt>())
        return ci32->getVal() >= 0;
    if (auto ci8 = val->as<ConstantI8>())
        return ci8->getVal() >= 0;
    if (auto ci1 = val->as<ConstantI1>())
        return true;
    if (auto cf32 = val->as<ConstantFloat>())
        return cf32->getVal() >= 0.0f;

    if (isSameType(val->getType(), makeBType(IRBTYPE::I32))) {
        auto rng = getIntRange(val);
        if (rng.min != IRng::MIN && rng.min >= 0)
            return true;
    }
    if (isSameType(val->getType(), makeBType(IRBTYPE::FLOAT))) {
        auto rng = getFloatRange(val);
        if (rng.min != FRng::MIN && rng.min >= 0.0f)
            return true;
    }
    return false;
}
bool RangeResult::knownNonNegative(const pVal &val) const { return knownNonNegative(val.get()); }
bool RangeResult::knownNonNegative(Value *val, BasicBlock *bb) const {
    if (auto ci32 = val->as<ConstantInt>())
        return ci32->getVal() >= 0;
    if (auto ci8 = val->as<ConstantI8>())
        return ci8->getVal() >= 0;
    if (auto ci1 = val->as<ConstantI1>())
        return true;
    if (auto cf32 = val->as<ConstantFloat>())
        return cf32->getVal() >= 0.0f;

    if (isSameType(val->getType(), makeBType(IRBTYPE::I32))) {
        auto rng = getIntRange(val, bb);
        if (rng.min != IRng::MIN && rng.min >= 0)
            return true;
    }
    if (isSameType(val->getType(), makeBType(IRBTYPE::FLOAT))) {
        auto rng = getFloatRange(val, bb);
        if (rng.min != FRng::MIN && rng.min >= 0.0f)
            return true;
    }
    return false;
}
bool RangeResult::knownNonNegative(const pVal &val, const pBlock &bb) const {
    return knownNonNegative(val.get(), bb.get());
}

bool RangeResult::update(Value *val, const IRng &range) { return int_range_map[val].updateGlobal(range); }
bool RangeResult::update(Value *val, const IRng &range, BasicBlock *bb) {
    if (auto inst = val->as_raw<Instruction>()) {
        if (inst->getParent().get() == bb) {
            return update(inst, range);
        }
    }
    return int_range_map[val].updateContextual(range, bb);
}

bool RangeResult::update(Value *val, const FRng &range) { return float_range_map[val].updateGlobal(range); }
bool RangeResult::update(Value *val, const FRng &range, BasicBlock *bb) {
    if (auto inst = val->as_raw<Instruction>()) {
        if (inst->getParent().get() == bb) {
            return update(inst, range);
        }
    }
    return float_range_map[val].updateContextual(range, bb);
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

void RangeAnalysis::analyzeArgument(RangeResult &res, Function *func, FAM *fam) {
    if (func->isRecursive())
        return;

    for (const auto &inst_user : func->inst_users()) {
        auto call = inst_user->as<CALLInst>();
        Err::gassert(call != nullptr);
        if (call->getFunc().get() != func)
            continue;
        auto caller_func = call->getParent()->getParent();
        if (caller_func.get() != func) {
            const auto caller_res = fam->getResult<RangeAnalysis>(*caller_func);
            auto actual_args = call->getArgs();
            for (const auto &fp : func->getParams()) {
                if (fp->getType()->is<BType>()) {
                    auto btype = fp->getType()->as<BType>()->getInner();
                    if (btype == IRBTYPE::I32)
                        res.merge(fp.get(), caller_res.getIntRange(actual_args[fp->getIndex()], call->getParent()));
                    else if (btype == IRBTYPE::FLOAT)
                        res.merge(fp.get(), caller_res.getFloatRange(actual_args[fp->getIndex()], call->getParent()));
                    else
                        Err::unreachable();
                }
            }
        }
    }
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

    auto updateInt = [&](Value *v, const IRng &rng) {
        if (!v->is<Instruction>())
            return;

        if (res.update(v, rng))
            propagateToUsers(v);
    };

    auto updateFloat = [&](Value *v, const FRng &rng) {
        if (!v->is<Instruction>())
            return;

        if (res.update(v, rng))
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
                    updateInt(binary, lrng + rrng);
                else if (binary->getOpcode() == OP::SUB)
                    updateInt(binary, lrng - rrng);
                else if (binary->getOpcode() == OP::MUL)
                    updateInt(binary, lrng * rrng);
                else if (binary->getOpcode() == OP::DIV)
                    updateInt(binary, lrng / rrng);
                else if (binary->getOpcode() == OP::SREM)
                    updateInt(binary, lrng % rrng);
                else if (binary->getOpcode() == OP::UREM)
                    updateInt(binary, lrng.urem(rrng));
                else if (binary->getOpcode() == OP::SHL)
                    updateInt(binary, lrng.shl(rrng));
                else if (binary->getOpcode() == OP::LSHR)
                    updateInt(binary, lrng.lshr(rrng));
                else if (binary->getOpcode() == OP::ASHR)
                    updateInt(binary, lrng.ashr(rrng));
                else if (binary->getOpcode() == OP::AND)
                    updateInt(binary, lrng & rrng);
                else if (binary->getOpcode() == OP::OR)
                    updateInt(binary, lrng | rrng);
                else if (binary->getOpcode() == OP::XOR)
                    updateInt(binary, lrng ^ rrng);
                else
                    Err::unreachable();
            } else if (is_float) {
                auto lrng = res.getFloatRange(binary->getLHS());
                auto rrng = res.getFloatRange(binary->getRHS());
                if (binary->getOpcode() == OP::FADD)
                    updateFloat(binary, lrng + rrng);
                else if (binary->getOpcode() == OP::FSUB)
                    updateFloat(binary, lrng - rrng);
                else if (binary->getOpcode() == OP::FMUL)
                    updateFloat(binary, lrng * rrng);
                else if (binary->getOpcode() == OP::FDIV)
                    updateFloat(binary, lrng / rrng);
                else if (binary->getOpcode() == OP::FREM)
                    updateFloat(binary, lrng % rrng);
                else
                    Err::unreachable();
            }
        } else if (auto fneg = inst->as_raw<FNEGInst>()) {
            const auto &vrng = res.getFloatRange(fneg->getVal());
            updateFloat(fneg, -vrng);
        } else if (auto fptosi = inst->as_raw<FPTOSIInst>()) {
            const auto &vrng = res.getFloatRange(fptosi->getOVal());
            updateInt(fptosi, range_cast<int>(vrng));
        } else if (auto sitofp = inst->as_raw<SITOFPInst>()) {
            const auto &vrng = res.getIntRange(sitofp->getOVal());
            updateFloat(sitofp, range_cast<float>(vrng));
        } else if (auto zext = inst->as_raw<ZEXTInst>()) {
            const auto &vrng = res.getIntRange(zext->getOVal());
            updateInt(zext, vrng);
        } else if (auto sext = inst->as_raw<SEXTInst>()) {
            const auto &vrng = res.getIntRange(sext->getOVal());
            updateInt(sext, vrng);
        } else if (auto phi = inst->as_raw<PHIInst>()) {
            auto phi_opers = phi->getPhiOpers();
            if (is_int) {
                auto base = res.getIntRange(phi_opers[0].value);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getIntRange(phi_opers[i].value));
                updateInt(phi, base);
            } else if (is_float) {
                auto base = res.getFloatRange(phi_opers[0].value);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getFloatRange(phi_opers[i].value));
                updateFloat(phi, base);
            }
        } else if (auto select = inst->as_raw<SELECTInst>()) {
            if (is_int) {
                auto trng = res.getIntRange(select->getTrueVal());
                auto frng = res.getIntRange(select->getFalseVal());
                updateInt(select, merge(trng, frng));
            } else if (is_float) {
                auto trng = res.getFloatRange(select->getTrueVal());
                auto frng = res.getFloatRange(select->getFalseVal());
                updateFloat(select, merge(trng, frng));
            }
        } else if (auto call = inst->as_raw<CALLInst>()) {
            if (is_int && call->getFunc()->hasAttr(FuncAttr::PromoteFromChar))
                updateInt(call, IRng(0, 256));
            else {
                if (is_int)
                    updateInt(call, IRng());
                else if (is_float)
                    updateFloat(call, FRng());
            }
        } else if (inst->is<ICMPInst, FCMPInst>())
            updateInt(inst, IRng(0, 2));
        else {
            if (is_btype) {
                if (is_int)
                    updateInt(inst, IRng());
                else if (is_float)
                    updateFloat(inst, FRng());
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
    auto updateContextualInt = [&](Value *v, BasicBlock *bb, const IRng &rng) {
        if (!v->is<Instruction>())
            return false;

        auto domdfv = domtree[bb]->getBFVisitor();
        bool modified = false;
        for (auto &node : domdfv)
            modified |= res.update(v, rng, node->raw_block());

        if (modified)
            propagateToDomUsers(v, bb);
        return modified;
    };

    auto updateContextualFloat = [&](Value *v, BasicBlock *bb, const FRng &rng) {
        if (!v->is<Instruction>())
            return false;

        auto domdfv = domtree[bb]->getBFVisitor();
        bool modified = false;
        for (auto &node : domdfv)
            modified |= res.update(v, rng, node->raw_block());

        if (modified)
            propagateToDomUsers(v, bb);
        return modified;
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

        bool is_btype = inst->getType()->is<BType>();
        bool is_int = is_btype && inst->getType()->isI32();
        bool is_float = is_btype && inst->getType()->isF32();

        // Check SCEV
        // FIXME: SCEV cannot figure out complex induction variables, since its goal
        //        is to compute the exact formula of the expression.
        //        For induction variables that are not computable by SCEV, we still have
        //        methods to determine whether it is non-negative.
        //        For example, writing a SCEV-like algorithm that only figures out whether
        //        its expression is non-negative, rather than getting a `Untracked` result too early.
        // TODO: Extend SCEV or implement it in place.
        if (is_int) {
            auto analyzeSCEVExpr = [](SCEVExpr *expr) {
                if (!expr->isIRValue())
                    return IRng();
                if (int c; match(expr->getIRValue(), M::Bind(c)))
                    return IRng(c);
                return IRng();
            };

            auto analyzeAddRec = [&scev, &bb, &res](TREC *trec) {
                if (auto constant_addrec = trec->getConstantAffineAddRec()) {
                    auto [base, step] = *constant_addrec;
                    if (auto trip_count = scev.getTripCount(trec->getLoop())) {
                        int c;
                        if (trip_count->isIRValue() && match(trip_count->getIRValue(), M::Bind(c))) {
                            auto m = static_cast<IRng::Bigger>(base) +
                                     static_cast<IRng::Bigger>(step) * static_cast<IRng::Bigger>(c);
                            if (step > 0)
                                return IRng(base, m);
                            return IRng(m, base);
                        }
                    } else {
                        if (step > 0)
                            return IRng(base, IRng::MAX);
                        return IRng(IRng::MIN, base);
                    }
                } else if (auto addrec = trec->getAffineAddRec()) {
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
                if (updateContextualInt(inst, bb, analyzeSCEVExpr(trec->getExpr())))
                    continue;
            } else if (trec->isAddRec()) {
                if (updateContextualInt(inst, bb, analyzeAddRec(trec)))
                    continue;
            } else if (trec->isPeeled()) {
                int first_ci;
                if (trec->getFirst()->isIRValue() && match(trec->getFirst()->getIRValue(), M::Bind(first_ci))) {
                    if (auto trip_count = scev.getTripCount(trec->getLoop())) {
                        int trip_cnt_ci;
                        if (trip_count->isIRValue() && match(trip_count->getIRValue(), M::Bind(trip_cnt_ci))) {
                            if (trip_cnt_ci > 1) {
                                auto rest = trec->getRest();
                                if (rest->isExpr()) {
                                    auto rng = analyzeSCEVExpr(rest->getExpr());
                                    if (updateContextualInt(inst, bb, merge(IRng(first_ci), rng)))
                                        continue;
                                } else if (rest->isAddRec()) {
                                    auto rng = analyzeAddRec(rest);
                                    if (updateContextualInt(inst, bb, merge(IRng(first_ci), rng)))
                                        continue;
                                }
                            }
                        }
                    }
                }
            }
        }

        if (auto binary = inst->as_raw<BinaryInst>()) {
            if (is_int) {
                auto lrng = res.getIntRange(binary->getLHS().get(), bb);
                auto rrng = res.getIntRange(binary->getRHS().get(), bb);
                if (binary->getOpcode() == OP::ADD)
                    updateContextualInt(binary, bb, lrng + rrng);
                else if (binary->getOpcode() == OP::SUB)
                    updateContextualInt(binary, bb, lrng - rrng);
                else if (binary->getOpcode() == OP::MUL)
                    updateContextualInt(binary, bb, lrng * rrng);
                else if (binary->getOpcode() == OP::DIV)
                    updateContextualInt(binary, bb, lrng / rrng);
                else if (binary->getOpcode() == OP::SREM)
                    updateContextualInt(binary, bb, lrng % rrng);
                else if (binary->getOpcode() == OP::UREM)
                    updateContextualInt(binary, bb, lrng.urem(rrng));
                else if (binary->getOpcode() == OP::SHL)
                    updateContextualInt(binary, bb, lrng.shl(rrng));
                else if (binary->getOpcode() == OP::LSHR)
                    updateContextualInt(binary, bb, lrng.lshr(rrng));
                else if (binary->getOpcode() == OP::ASHR)
                    updateContextualInt(binary, bb, lrng.ashr(rrng));
                else if (binary->getOpcode() == OP::AND)
                    updateContextualInt(binary, bb, lrng & rrng);
                else if (binary->getOpcode() == OP::OR)
                    updateContextualInt(binary, bb, lrng | rrng);
                else if (binary->getOpcode() == OP::XOR)
                    updateContextualInt(binary, bb, lrng ^ rrng);
                else
                    Err::unreachable();
            } else if (is_float) {
                auto lrng = res.getFloatRange(binary->getLHS().get(), bb);
                auto rrng = res.getFloatRange(binary->getRHS().get(), bb);
                if (binary->getOpcode() == OP::FADD)
                    updateContextualFloat(binary, bb, lrng + rrng);
                else if (binary->getOpcode() == OP::FSUB)
                    updateContextualFloat(binary, bb, lrng - rrng);
                else if (binary->getOpcode() == OP::FMUL)
                    updateContextualFloat(binary, bb, lrng * rrng);
                else if (binary->getOpcode() == OP::FDIV)
                    updateContextualFloat(binary, bb, lrng / rrng);
                else if (binary->getOpcode() == OP::FREM)
                    updateContextualFloat(binary, bb, lrng % rrng);
                else
                    Err::unreachable();
            }
        } else if (auto fneg = inst->as_raw<FNEGInst>()) {
            const auto &vrng = res.getFloatRange(fneg->getVal().get(), bb);
            updateContextualFloat(fneg, bb, -vrng);
        } else if (auto fptosi = inst->as_raw<FPTOSIInst>()) {
            const auto &vrng = res.getFloatRange(fptosi->getOVal().get(), bb);
            updateContextualInt(fptosi, bb, range_cast<int>(vrng));
        } else if (auto sitofp = inst->as_raw<SITOFPInst>()) {
            const auto &vrng = res.getIntRange(sitofp->getOVal().get(), bb);
            updateContextualFloat(sitofp, bb, range_cast<float>(vrng));
        } else if (auto zext = inst->as_raw<ZEXTInst>()) {
            const auto &vrng = res.getIntRange(zext->getOVal().get(), bb);
            updateContextualInt(zext, bb, vrng);
        } else if (auto sext = inst->as_raw<SEXTInst>()) {
            const auto &vrng = res.getIntRange(sext->getOVal().get(), bb);
            updateContextualInt(sext, bb, vrng);
        } else if (auto phi = inst->as_raw<PHIInst>()) {
            auto phi_opers = phi->getPhiOpers();
            if (is_int) {
                auto base = res.getIntRange(phi_opers[0].value, phi_opers[0].block);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getIntRange(phi_opers[i].value, phi_opers[i].block));
                updateContextualInt(phi, bb, base);
            } else if (is_float) {
                auto base = res.getFloatRange(phi_opers[0].value, phi_opers[0].block);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getFloatRange(phi_opers[i].value, phi_opers[i].block));
                updateContextualFloat(phi, bb, base);
            }
        } else if (auto select = inst->as_raw<SELECTInst>()) {
            if (is_int) {
                auto trng = res.getIntRange(select->getTrueVal().get(), bb);
                auto frng = res.getIntRange(select->getFalseVal().get(), bb);
                updateContextualInt(select, bb, merge(trng, frng));
            } else if (is_float) {
                auto trng = res.getFloatRange(select->getTrueVal().get(), bb);
                auto frng = res.getFloatRange(select->getFalseVal().get(), bb);
                updateContextualFloat(select, bb, merge(trng, frng));
            }
        } else if (auto icmp = inst->as_raw<ICMPInst>()) {
            auto lhs = icmp->getLHS().get();
            auto rhs = icmp->getRHS().get();
            auto lrng = res.getIntRange(lhs, bb);
            auto rrng = res.getIntRange(rhs, bb);

            for (auto inst_user : icmp->inst_users()) {
                if (auto user_br = inst_user->as_raw<BRInst>()) {
                    auto truebb = user_br->getTrueDest().get();
                    auto falsebb = user_br->getFalseDest().get();

                    bool truebb_can_set = truebb->getNumPreds() == 1;
                    bool falsebb_can_set = falsebb->getNumPreds() == 1;

                    auto tryUpdateTrue = [&](Value *val, const IRng &rng) {
                        if (truebb_can_set)
                            updateContextualInt(val, truebb, rng);
                    };
                    auto tryUpdateFalse = [&](Value *val, const IRng &rng) {
                        if (falsebb_can_set)
                            updateContextualInt(val, falsebb, rng);
                    };

                    switch (icmp->getCond()) {
                    case ICMPOP::eq:
                        tryUpdateTrue(lhs, rrng);
                        tryUpdateTrue(rhs, lrng);
                        break;
                    case ICMPOP::ne:
                        tryUpdateFalse(lhs, rrng);
                        tryUpdateFalse(rhs, lrng);
                        break;
                    case ICMPOP::slt:
                        // lhs < rhs
                        if (rrng.max != IRng::MAX)
                            tryUpdateTrue(lhs, IRng(IRng::MIN, rrng.max - 1));
                        if (lrng.min != IRng::MIN)
                            tryUpdateTrue(rhs, IRng(lrng.min + 1, IRng::MAX));

                        // lhs >= rhs
                        if (rrng.min != IRng::MIN)
                            tryUpdateFalse(lhs, IRng(rrng.min, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryUpdateFalse(rhs, IRng(IRng::MIN, lrng.max));
                        break;
                    case ICMPOP::sle:
                        // lhs <= rhs
                        if (rrng.max != IRng::MAX)
                            tryUpdateTrue(lhs, IRng(IRng::MIN, rrng.max));
                        if (lrng.min != IRng::MIN)
                            tryUpdateTrue(rhs, IRng(lrng.min, IRng::MAX));

                        // lhs > rhs
                        if (rrng.min != IRng::MIN)
                            tryUpdateFalse(lhs, IRng(rrng.min + 1, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryUpdateFalse(rhs, IRng(IRng::MIN, lrng.max - 1));
                        break;
                    case ICMPOP::sgt:
                        // lhs > rhs
                        if (rrng.min != IRng::MIN)
                            tryUpdateTrue(lhs, IRng(rrng.min + 1, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryUpdateTrue(rhs, IRng(IRng::MIN, lrng.max - 1));

                        // lhs <= rhs
                        if (rrng.max != IRng::MAX)
                            tryUpdateFalse(lhs, IRng(IRng::MIN, rrng.max));
                        if (lrng.min != IRng::MIN)
                            tryUpdateFalse(rhs, IRng(lrng.min, IRng::MAX));
                        break;
                    case ICMPOP::sge:
                        // lhs >= rhs
                        if (rrng.min != IRng::MIN)
                            tryUpdateTrue(lhs, IRng(rrng.min, IRng::MAX));
                        if (lrng.max != IRng::MAX)
                            tryUpdateTrue(rhs, IRng(IRng::MIN, lrng.max));

                        // lhs < rhs
                        if (rrng.max != IRng::MAX)
                            tryUpdateFalse(lhs, IRng(IRng::MIN, rrng.max - 1));
                        if (lrng.min != IRng::MIN)
                            tryUpdateFalse(rhs, IRng(lrng.min + 1, IRng::MAX));
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

            for (auto inst_user : fcmp->inst_users()) {
                if (auto user_br = inst_user->as_raw<BRInst>()) {
                    auto truebb = user_br->getTrueDest().get();
                    auto falsebb = user_br->getFalseDest().get();
                    bool truebb_can_set = truebb->getNumPreds() == 1;
                    bool falsebb_can_set = falsebb->getNumPreds() == 1;

                    auto tryUpdateTrue = [&](Value *val, const FRng &rng) {
                        if (truebb_can_set)
                            updateContextualFloat(val, truebb, rng);
                    };
                    auto tryUpdateFalse = [&](Value *val, const FRng &rng) {
                        if (falsebb_can_set)
                            updateContextualFloat(val, falsebb, rng);
                    };

                    switch (fcmp->getCond()) {
                    case FCMPOP::oeq:
                        tryUpdateTrue(lhs, rrng);
                        tryUpdateTrue(rhs, lrng);
                        break;
                    case FCMPOP::one:
                        tryUpdateFalse(lhs, rrng);
                        tryUpdateFalse(rhs, lrng);
                        break;
                    case FCMPOP::olt:
                        // lhs < rhs
                        if (rrng.max != FRng::MAX)
                            tryUpdateTrue(lhs, FRng(FRng::MIN, rrng.max - 0.01));
                        if (lrng.min != FRng::MIN)
                            tryUpdateTrue(rhs, FRng(lrng.min + 0.01, FRng::MAX));

                        // lhs >= rhs
                        if (rrng.min != FRng::MIN)
                            tryUpdateFalse(lhs, FRng(rrng.min, FRng::MAX));
                        if (lrng.max != FRng::MAX)
                            tryUpdateFalse(rhs, FRng(FRng::MIN, lrng.max));
                        break;
                    case FCMPOP::ole:
                        // lhs <= rhs
                        if (rrng.max != FRng::MAX)
                            tryUpdateTrue(lhs, FRng(FRng::MIN, rrng.max));
                        if (lrng.min != FRng::MIN)
                            tryUpdateTrue(rhs, FRng(lrng.min, FRng::MAX));

                        // lhs > rhs
                        if (rrng.min != FRng::MIN)
                            tryUpdateFalse(lhs, FRng(rrng.min + 0.01, FRng::MAX));
                        if (lrng.max != FRng::MAX)
                            tryUpdateFalse(rhs, FRng(FRng::MIN, lrng.max - 0.01));
                        break;
                    case FCMPOP::ogt:
                        // lhs > rhs
                        if (rrng.min != FRng::MIN)
                            tryUpdateTrue(lhs, FRng(rrng.min + 0.01, FRng::MAX));
                        if (lrng.max != FRng::MAX)
                            tryUpdateTrue(rhs, FRng(FRng::MIN, lrng.max - 0.01));

                        // lhs <= rhs
                        if (rrng.max != FRng::MAX)
                            tryUpdateFalse(lhs, FRng(FRng::MIN, rrng.max));
                        if (lrng.min != FRng::MIN)
                            tryUpdateFalse(rhs, FRng(lrng.min, FRng::MAX));
                        break;
                    case FCMPOP::oge:
                        // lhs >= rhs
                        if (rrng.min != FRng::MIN)
                            tryUpdateTrue(lhs, FRng(rrng.min, FRng::MAX));
                        if (lrng.max != FRng::MAX)
                            tryUpdateTrue(rhs, FRng(FRng::MIN, lrng.max));

                        // lhs < rhs
                        if (rrng.max != FRng::MAX)
                            tryUpdateFalse(lhs, FRng(FRng::MIN, rrng.max - 0.01));
                        if (lrng.min != FRng::MIN)
                            tryUpdateFalse(rhs, FRng(lrng.min + 0.01, FRng::MAX));
                        break;
                    default:
                        Err::unreachable();
                    }
                }
            }
        } else if (auto gep = inst->as_raw<GEPInst>()) {
            auto idxs = gep->getIdxs();
            for (const auto &idx : idxs) {
                if (idx->is<Instruction>())
                    updateContextualInt(idx.get(), bb, IRng(0, IRng::MAX));
            }
        }
    }
}

RangeResult RangeAnalysis::run(Function &function, FAM &manager) {
    RangeResult res;
    analyzeArgument(res, &function, &manager);
    analyzeGlobal(res, &function, &manager);
    analyzeContextual(res, &function, &manager);
    return res;
}
} // namespace IR