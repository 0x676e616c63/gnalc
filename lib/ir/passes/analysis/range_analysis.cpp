#include "ir/passes/analysis/range_analysis.hpp"
#include "ir/base.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "ir/pattern_match.hpp"
#include "pattern_match/pattern_match.hpp"
#include "utils/logger.hpp"

#include <deque>
#include <string>

using namespace PatternMatch;
namespace IR {
PM::UniqueKey RangeAnalysis::Key;

struct InstBBPairHash {
    using InstBBPair = std::pair<Instruction *, BasicBlock *>;
    size_t operator()(const InstBBPair &a) const {
        size_t hash = std::hash<Instruction *>{}(a.first);
        Util::hashSeedCombine(hash, std::hash<BasicBlock *>{}(a.second));
        return hash;
    }
};

void RangeAnalysis::analyzeArgument(RangeResult &res, Function *func, FAM *fam) {
    auto is_recursive = [&]  {
        for (const auto &inst_user : func->inst_users()) {
            auto call = inst_user->as<CALLInst>();
            Err::gassert(call != nullptr);
            auto caller_func = call->getParent()->getParent();
            if (caller_func.get() == func)
                return true;
        }
        return false;
    }();

    if (is_recursive)
        return;

    for (const auto &inst_user : func->inst_users()) {
        auto call = inst_user->as<CALLInst>();
        Err::gassert(call != nullptr);
        auto caller_func = call->getParent()->getParent();
        if (caller_func.get() != func) {
            const auto caller_res = fam->getResult<RangeAnalysis>(*caller_func);
            auto actual_args = call->getArgs();
            for (const auto &fp : func->getParams()) {
                if (fp->getType()->is<BType>()) {
                    auto btype = fp->getType()->as<BType>()->getInner();
                    if (btype == IRBTYPE::I32)
                        res.update(fp.get(), caller_res.getIntRange(actual_args[fp->getIndex()]));
                    else if (btype == IRBTYPE::FLOAT)
                        res.update(fp.get(), caller_res.getFloatRange(actual_args[fp->getIndex()]));
                    else
                        Err::unreachable();
                }
            }
        }
    }
}

void RangeAnalysis::analyzeGlobal(RangeResult &res, Function *func, FAM *fam) {
    auto bbdfv = func->getDFVisitor();

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
            if (!in_worklist.count(user.get())) {
                worklist.push_back(user.get());
                in_worklist.emplace(user.get());
            }
        }
    };

    auto updateInt = [&](Value *v, const Range<int> &rng) {
        if (res.update(v, rng))
            propagateToUsers(v);
    };

    auto updateFloat = [&](Value *v, const Range<float> &rng) {
        if (res.update(v, rng))
            propagateToUsers(v);
    };
    // Instructions
    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();

        bool is_btype = inst->getType()->is<BType>();
        bool is_int = is_btype && inst->getType()->as<BType>()->getInner() == IRBTYPE::I32;

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
                else if (binary->getOpcode() == OP::REM)
                    updateInt(binary, lrng % rrng);
                else
                    Err::unreachable();
            } else {
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
            updateInt(fptosi, Range(static_cast<int>(vrng.min), static_cast<int>(vrng.max)));
        } else if (auto sitofp = inst->as_raw<SITOFPInst>()) {
            const auto &vrng = res.getIntRange(sitofp->getOVal());
            updateFloat(sitofp, Range(static_cast<float>(vrng.min), static_cast<float>(vrng.max)));
        } else if (auto zext = inst->as_raw<ZEXTInst>()) {
            const auto &vrng = res.getIntRange(zext->getOVal());
            updateInt(zext, vrng);
        } else if (auto phi = inst->as_raw<PHIInst>()) {
            auto phi_opers = phi->getPhiOpers();
            if (is_int) {
                auto base = res.getIntRange(phi_opers[0].value);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getIntRange(phi_opers[i].value));
                updateInt(phi, base);
            } else {
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
            } else {
                auto trng = res.getFloatRange(select->getTrueVal());
                auto frng = res.getFloatRange(select->getFalseVal());
                updateFloat(select, merge(trng, frng));
            }
        } else if (auto call = inst->as_raw<CALLInst>()) {
            if (is_int && call->getFunc()->hasAttr(FuncAttr::PromoteFromChar))
                updateInt(call, Range<int>(0, 256));
            else {
                if (is_int)
                    updateInt(call, Range<int>());
                else
                    updateFloat(call, Range<float>());
            }
        } else if (inst->is<ICMPInst, FCMPInst>())
            updateInt(inst, Range<int>(0, 1));
        else {
            if (is_btype) {
                if (is_int)
                    updateInt(inst, Range<int>());
                else
                    updateFloat(inst, Range<float>());
            }
        }
    }
}

void RangeAnalysis::analyzeContextual(RangeResult &res, Function *func, FAM *fam) {
    auto bbdfv = func->getDFVisitor();
    auto &domtree = fam->getResult<DomTreeAnalysis>(*func);

    std::deque<std::pair<Instruction *, BasicBlock *>> worklist;
    std::unordered_set<std::pair<Instruction *, BasicBlock *>, InstBBPairHash> in_worklist;

    for (const auto &bb : bbdfv) {
        for (const auto &inst : *bb) {
            if (inst->is<GEPInst, ICMPInst, FCMPInst>())
                worklist.emplace_back(inst.get(), bb.get());
        }
    }

    auto propagateToDomUsers = [&](Value *v, BasicBlock *bb) {
        for (const auto &user : v->inst_users()) {
            if (!domtree.ADomB(bb, user->getParent().get()))
                continue;

            auto key = std::make_pair(user.get(), user->getParent().get());
            if (!in_worklist.count(key)) {
                worklist.emplace_back(key);
                in_worklist.emplace(key);
            }
        }
    };
    auto updateContextualInt = [&](Value *v, BasicBlock *bb, const Range<int> &rng) {
        auto domdfv = domtree[bb]->getBFVisitor();
        bool modified = false;
        for (auto &node : domdfv)
            modified |= res.update(v, rng, node->raw_block());

        if (modified)
            propagateToDomUsers(v, bb);
        return modified;
    };

    auto updateContextualFloat = [&](Value *v, BasicBlock *bb, const Range<float> &rng) {
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
        auto [inst, bb] = worklist.front();
        worklist.pop_front();

        bool is_btype = inst->getType()->is<BType>();
        bool is_int = is_btype && inst->getType()->as<BType>()->getInner() == IRBTYPE::I32;

        // Check SCEV
        if (is_int) {
            auto analyzeSCEVExpr = [](SCEVExpr *expr) {
                if (!expr->isIRValue())
                    return Range<int>();
                if (int c; match(expr->getIRValue(), M::Bind(c)))
                    return Range(c);
                return Range<int>();
            };

            auto analyzeAddRec = [&scev](TREC *trec) {
                if (auto addrec = trec->getConstantAffineAddRec()) {
                    auto [base, step] = *addrec;
                    if (auto trip_count = scev.getTripCount(trec->getLoop())) {
                        int c;
                        if (trip_count->isIRValue() && match(trip_count->getIRValue(), M::Bind(c))) {
                            if (step > 0)
                                return Range(base, base + step * c);
                            return Range(base + step * c, base);
                        }
                    } else {
                        if (step > 0)
                            return Range(base, Range<int>::MAX);
                        return Range(Range<int>::MIN, base);
                    }
                }
                return Range<int>();
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
                                    if (updateContextualInt(inst, bb, merge(Range(first_ci), rng)))
                                        continue;
                                } else if (rest->isAddRec()) {
                                    auto rng = analyzeAddRec(rest);
                                    if (updateContextualInt(inst, bb, merge(Range(first_ci), rng)))
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
                else if (binary->getOpcode() == OP::REM)
                    updateContextualInt(binary, bb, lrng % rrng);
                else
                    Err::unreachable();
            } else {
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
            updateContextualInt(fptosi, bb, Range(static_cast<int>(vrng.min), static_cast<int>(vrng.max)));
        } else if (auto sitofp = inst->as_raw<SITOFPInst>()) {
            const auto &vrng = res.getIntRange(sitofp->getOVal().get(), bb);
            updateContextualFloat(sitofp, bb, Range(static_cast<float>(vrng.min), static_cast<float>(vrng.max)));
        } else if (auto zext = inst->as_raw<ZEXTInst>()) {
            const auto &vrng = res.getIntRange(zext->getOVal().get(), bb);
            updateContextualInt(zext, bb, vrng);
        } else if (auto phi = inst->as_raw<PHIInst>()) {
            auto phi_opers = phi->getPhiOpers();
            if (is_int) {
                auto base = res.getIntRange(phi_opers[0].value, phi_opers[0].block);
                for (size_t i = 1; i < phi_opers.size(); i++)
                    base = merge(base, res.getIntRange(phi_opers[i].value, phi_opers[i].block));
                updateContextualInt(phi, bb, base);
            } else {
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
            } else {
                auto trng = res.getFloatRange(select->getTrueVal().get(), bb);
                auto frng = res.getFloatRange(select->getFalseVal().get(), bb);
                updateContextualFloat(select, bb, merge(trng, frng));
            }
        } else if (auto icmp = inst->as_raw<ICMPInst>()) {
            auto lhs = icmp->getLHS().get();
            auto rhs = icmp->getRHS().get();
            auto lrng = res.getIntRange(lhs, bb);
            auto rrng = res.getIntRange(rhs, bb);

            if (icmp->getUseCount() != 1)
                Logger::logWarning("ICMPInst has multiple users");

            for (auto inst_user : icmp->inst_users()) {
                if (auto user_br = inst_user->as_raw<BRInst>()) {
                    auto truebb = user_br->getTrueDest().get();
                    auto falsebb = user_br->getFalseDest().get();
                    if (!domtree.ADomB(icmp->getParent().get(), truebb) || truebb->getNumPreds() != 1)
                        continue;

                    switch (icmp->getCond()) {
                    case ICMPOP::eq:
                        updateContextualInt(lhs, truebb, rrng);
                        updateContextualInt(rhs, truebb, lrng);
                        break;
                    case ICMPOP::ne:
                        updateContextualInt(lhs, falsebb, rrng);
                        updateContextualInt(rhs, falsebb, lrng);
                        break;
                    case ICMPOP::slt:
                        // lhs < rhs
                        updateContextualInt(lhs, truebb, Range(Range<int>::MIN, rrng.min));
                        updateContextualInt(rhs, truebb, Range(lrng.max, Range<int>::MAX));

                        // lhs >= rhs
                        if (rrng.max == Range<int>::MAX || rrng.max == Range<int>::MIN)
                            updateContextualInt(lhs, falsebb, Range(rrng.max, Range<int>::MAX));
                        else
                            updateContextualInt(lhs, falsebb, Range(rrng.max - 1, Range<int>::MAX));

                        if (lrng.min == Range<int>::MAX || lrng.min == Range<int>::MIN)
                            updateContextualInt(rhs, falsebb, Range(Range<int>::MIN, lrng.min));
                        else
                            updateContextualInt(rhs, falsebb, Range(Range<int>::MIN, lrng.min + 1));
                        break;
                    case ICMPOP::sle:
                        // lhs <= rhs
                        if (rrng.min == Range<int>::MAX || rrng.min == Range<int>::MIN)
                            updateContextualInt(lhs, truebb, Range(Range<int>::MIN, rrng.min));
                        else
                            updateContextualInt(lhs, truebb, Range(Range<int>::MIN, rrng.min + 1));
                        if (lrng.max == Range<int>::MAX || lrng.max == Range<int>::MIN)
                            updateContextualInt(rhs, truebb, Range(lrng.max, Range<int>::MAX));
                        else
                            updateContextualInt(rhs, truebb, Range(lrng.max - 1, Range<int>::MAX));

                        // lhs > rhs
                        updateContextualInt(lhs, falsebb, Range(rrng.max, Range<int>::MAX));
                        updateContextualInt(rhs, falsebb, Range(Range<int>::MIN, lrng.min));
                        break;
                    case ICMPOP::sgt:
                        // lhs > rhs
                        updateContextualInt(lhs, truebb, Range(rrng.max, Range<int>::MAX));
                        updateContextualInt(rhs, truebb, Range(Range<int>::MIN, lrng.min));

                        // lhs <= rhs
                        if (rrng.min == Range<int>::MAX || rrng.min == Range<int>::MIN)
                            updateContextualInt(lhs, falsebb, Range(Range<int>::MIN, rrng.min));
                        else
                            updateContextualInt(lhs, falsebb, Range(Range<int>::MIN, rrng.min + 1));
                        if (lrng.max == Range<int>::MAX || lrng.max == Range<int>::MIN)
                            updateContextualInt(rhs, falsebb, Range(lrng.max, Range<int>::MAX));
                        else
                            updateContextualInt(rhs, falsebb, Range(lrng.max - 1, Range<int>::MAX));
                        break;
                    case ICMPOP::sge:
                        // lhs >= rhs
                        if (rrng.max == Range<int>::MAX || rrng.max == Range<int>::MIN)
                            updateContextualInt(lhs, truebb, Range(rrng.max, Range<int>::MAX));
                        else
                            updateContextualInt(lhs, truebb, Range(rrng.max - 1, Range<int>::MAX));

                        if (lrng.min == Range<int>::MAX || lrng.min == Range<int>::MIN)
                            updateContextualInt(rhs, truebb, Range(Range<int>::MIN, lrng.min));
                        else
                            updateContextualInt(rhs, truebb, Range(Range<int>::MIN, lrng.min + 1));

                        //  lhs < rhs
                        updateContextualInt(lhs, falsebb, Range(Range<int>::MIN, rrng.min));
                        updateContextualInt(rhs, falsebb, Range(lrng.max, Range<int>::MAX));
                        break;
                    default:
                        Err::unreachable();
                    }
                }
            }
        }
        // else if (auto fcmp = inst->as_raw<FCMPInst>()) {
        //     auto lhs = fcmp->getLHS().get();
        //     auto rhs = fcmp->getRHS().get();
        //     auto lrng = res.getFloatRange(lhs, bb);
        //     auto rrng = res.getFloatRange(rhs, bb);
        //
        //     if (fcmp->getUseCount() != 1)
        //         Logger::logWarning("FCMPInst has multiple users");
        //
        //     for (auto inst_user : fcmp->inst_users()) {
        //         if (auto user_br = inst_user->as_raw<BRInst>()) {
        //             auto truebb = user_br->getTrueDest().get();
        //             auto falsebb = user_br->getFalseDest().get();
        //             if (!domtree.ADomB(fcmp->getParent().get(), truebb) || truebb->getNumPreds() != 1)
        //                 continue;
        //
        //             switch (fcmp->getCond()) {
        //             case FCMPOP::oeq:
        //                 updateContextualFloat(lhs, truebb, rrng);
        //                 updateContextualFloat(rhs, truebb, lrng);
        //                 break;
        //             case FCMPOP::one:
        //                 updateContextualFloat(lhs, falsebb, rrng);
        //                 updateContextualFloat(rhs, falsebb, lrng);
        //                 break;
        //             case FCMPOP::olt:
        //                 // lhs < rhs
        //                 updateContextualFloat(lhs, truebb, Range(Range<float>::MIN, rrng.min));
        //                 updateContextualFloat(rhs, truebb, Range(lrng.max, Range<float>::MAX));
        //
        //                 // lhs >= rhs
        //                 updateContextualFloat(lhs, falsebb, Range(rrng.max - 1, Range<float>::MAX));
        //                 updateContextualFloat(rhs, falsebb, Range(Range<float>::MIN, lrng.min + 1));
        //                 break;
        //             case FCMPOP::ole:
        //                 // lhs <= rhs
        //                 updateContextualFloat(lhs, truebb, Range(Range<float>::MIN, rrng.min + 1));
        //                 updateContextualFloat(rhs, truebb, Range(lrng.max - 1, Range<float>::MAX));
        //
        //                 // lhs > rhs
        //                 updateContextualFloat(lhs, falsebb, Range(rrng.max, Range<float>::MAX));
        //                 updateContextualFloat(rhs, falsebb, Range(Range<float>::MIN, lrng.min));
        //                 break;
        //             case FCMPOP::ogt:
        //                 // lhs > rhs
        //                 updateContextualFloat(lhs, truebb, Range(rrng.max, Range<float>::MAX));
        //                 updateContextualFloat(rhs, truebb, Range(Range<float>::MIN, lrng.min));
        //
        //                 // lhs <= rhs
        //                 updateContextualFloat(lhs, falsebb, Range(Range<float>::MIN, rrng.min + 1));
        //                 updateContextualFloat(rhs, falsebb, Range(lrng.max - 1, Range<float>::MAX));
        //                 break;
        //             case FCMPOP::oge:
        //                 // lhs >= rhs
        //                 updateContextualFloat(lhs, truebb, Range(rrng.max - 1, Range<float>::MAX));
        //                 updateContextualFloat(rhs, truebb, Range(Range<float>::MIN, lrng.min + 1));
        //
        //                 //  lhs < rhs
        //                 updateContextualFloat(lhs, falsebb, Range(Range<float>::MIN, rrng.min));
        //                 updateContextualFloat(rhs, falsebb, Range(lrng.max, Range<float>::MAX));
        //                 break;
        //             default:
        //                 Err::unreachable();
        //             }
        //         }
        //     }
        // }
        else if (auto gep = inst->as_raw<GEPInst>()) {
            auto idxs = gep->getIdxs();
            for (const auto &idx : idxs)
                updateContextualInt(idx.get(), bb, Range(0, Range<int>::MAX));
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