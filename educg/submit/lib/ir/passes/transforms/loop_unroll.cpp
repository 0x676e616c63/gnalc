// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/loop_unroll.hpp"
#include "../../../../include/ir/base.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/constant.hpp"
#include "../../../../include/ir/formatter.hpp"
#include "../../../../include/ir/instruction.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/phi.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/analysis/scev.hpp"
#include "../../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../../include/ir/type_alias.hpp"
#include "../../../../include/utils/exception.hpp"
#include "../../../../include/utils/logger.hpp"
#include <algorithm>
#include <memory>
#include <vector>

#define ENABLE_NEW_RT_PATH 0

namespace IR {

unsigned LoopUnrollPass::name_idx = 0;

LoopUnrollPass::LoopUnrollPass() {
    // name_idx++;
    // 日后可添加参数选项以快速调参
}

void LoopUnrollPass::analyze(const pLoop &loop, UnrollOption &option, Function &FC, FAM& fam) {
    if (!(loop->isSimplifyForm() && loop->isLCSSAForm())) {
        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop is not SimplifyForm or LCSSAForm.");
        option.disable();
        return;
    }

    // 不展开过大循环
    unsigned inst_size = loop->getInstCount();
    if (inst_size > MPS) {
        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop is larger than MAX_PROCESS_SIZE.");
        option.disable();
        return;
    }

    // 限制多出口循环展开，暂时只处理单出口
    if (loop->getExitBlocks().size() != 1) {
        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop has multiple exits.");
        option.disable();
        return;
    }

    auto is_dowhile = loop->isExiting(loop->getLatch());

    // 不处理中间退出的循环
    if (!loop->isExiting(loop->getHeader()) && !is_dowhile) {
        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop exits from the middle.");
        option.disable();
        return;
    }

    // 不处理含调用的循环, Disable
    // for (const auto &bb : loop->blocks()) {
    //     for (const auto &inst : *bb) {
    //         if (inst->getOpcode() == OP::CALL) {
    //             Logger::logInfo("[LoopUnroll] Unroll disabled because the loop has CALLInst.");
    //             option.disable();
    //             return;
    //         }
    //     }
    // }

    auto& SCEVH = fam.getResult<SCEVAnalysis>(FC);
    // It seems the range analysis rarely enhances SCEV, but computing it is expensive.
    // auto& RNG = fam.getResult<RangeAnalysis>(FC);

    const auto trip_countE = SCEVH.getTripCount(loop);
    if (trip_countE == nullptr) {
        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop can't get trip count.");
        option.disable();
        return;
    }

    auto GetIterVarAndBoundary = [](const pLoop &_loop, pVal &_iter_variable, pVal &_boundary) -> bool {
        if (_loop->getExitingBlocks().size() == 1) {
            auto exiting_br_cond = (*_loop->getExitingBlocks().begin())->getBRInst()->getCond();
            if (exiting_br_cond->is<ICMPInst>()) {
                auto icmp = exiting_br_cond->as<ICMPInst>();
                bool lhs_is_var = !_loop->isTriviallyInvariant(icmp->getLHS());
                bool rhs_is_var = !_loop->isTriviallyInvariant(icmp->getRHS());
                if (lhs_is_var && rhs_is_var) {
                    Err::not_implemented("Both handles are variable.");
                } else if (lhs_is_var) {
                    _iter_variable = icmp->getLHS();
                    _boundary = icmp->getRHS();
                    return true;
                } else if (rhs_is_var) {
                    _iter_variable = icmp->getRHS();
                    _boundary = icmp->getLHS();
                    return true;
                } else {
                    Err::unreachable();
                }
            } else {
                Logger::logInfo("[LoopUnroll] GetIterVarAndBoundary: The loop's exit condition is not ICMPInst.");
            }
        } else {
            Err::not_implemented();
            Logger::logInfo("[LoopUnroll] GetIterVarAndBoundary: The loop has multiple exits.");
        }
        return false;
    };

    auto GetBaseValue = [](const pLoop &loop, bool is_dowhile, const pVal &iter_variable, pVal &base) -> bool {
        auto iter_inst = iter_variable->as<Instruction>();

        // For while
        if (!is_dowhile && iter_inst->getOpcode() == OP::PHI && iter_inst->getParent() == loop->getHeader()) {
            base = iter_inst->as<PHIInst>()->getValueForBlock(loop->getPreHeader());
            return true;
        }

        // For dowhile or other cases
        for (auto user : iter_variable->users()) {
            if (auto uinst = user->as<Instruction>(); uinst->getOpcode() == OP::PHI && uinst->getParent() == loop->getHeader()) {
                auto uphi = uinst->as<PHIInst>();

                // Maybe unused
                if (uphi->getPhiOpers().size() != 2) {
                    Err::error("GetBaseValue: Loop's iter variable's PHI has more than 2 incoming values!");
                    return false;
                }

                base = uphi->getValueForBlock(loop->getPreHeader());
                return true;
            }
        }

        Err::unreachable("GetBaseValue: Can't find the loop's iter variable's base.");
        return false;
    };

    auto GetExprStep = [](SCEVHandle &SH, const pVal &iter_variable, SCEVExpr* &stepE) -> bool {
        auto trecp = SH.getSCEVAtBlock(iter_variable, iter_variable->as<Instruction>()->getParent());
        if (!trecp) {
            Logger::logInfo("[LoopUnroll] GetStep: Can't get the loop's iter_variable's TREC.");
            return false;
        }
        if (!trecp->isAddRec()) {
            Logger::logInfo("[LoopUnroll] GetStep: The loop's iter_variable's TREC is not AddRec.");
            return false;
        }
        auto [_fake_baseE, _stepE] = trecp->getAffineAddRec().value();
        stepE = _stepE;
        return true;
    };

    auto GetIntegerStep = [](SCEVHandle &SH, const pVal &iter_variable, int& stepN) -> bool {
        auto trecp = SH.getSCEVAtBlock(iter_variable, iter_variable->as<Instruction>()->getParent());
        if (!trecp) {
            Logger::logInfo("[LoopUnroll] GetStep: Can't get the loop's iter_variable's TREC.");
            return false;
        }
        if (!trecp->isAddRec()) {
            Logger::logInfo("[LoopUnroll] GetStep: The loop's iter_variable's TREC is not AddRec.");
            return false;
        }
        auto [_fake_baseE, stepE] = trecp->getAffineAddRec().value();
        if (!stepE->isIRValue() || !stepE->getIRValue()->is<ConstantInt>()) {
            Logger::logInfo("[LoopUnroll] GetStep: The loop's step is not constant integer.");
            return false;
        }
        stepN = stepE->getIRValue()->as<ConstantInt>()->getVal();
        return true;
    };

    auto MaybeVectorized = [](const pLoop& loop) -> bool {
        for (auto b : loop->blocks()) {
            for (const auto& i : b->getInsts()) {
                if (i->getOpcode() == OP::STORE) {
                    return true;
                }
            }
        }
        return false;
    };

    auto calcUnrollFactor = [MaybeVectorized](const pLoop &_loop, const unsigned size, const unsigned MaxSize,
                                              const unsigned MaxCount) -> int {
        unsigned unroll_factor;
        if (MaybeVectorized(_loop)) {
            if (const auto estimated = MaxSize / size; estimated <= MaxCount) {
                if (estimated <= 2)
                    unroll_factor = estimated;
                else if (estimated <= 5)
                    unroll_factor = 4;
                else if (estimated <= 8)
                    unroll_factor = 8;
                // else if (esti <= 14)
                //     unroll_factor = 12;
                // else if (esti <= 16)
                //     unroll_factor = 16;
                else {
                    unroll_factor = estimated / 4 * 4;
                }
                Logger::logDebug("[LoopUnroll] May be vectorized, change factor, estimated: " + std::to_string(estimated)
                    , ", use: " + std::to_string(unroll_factor));
            } else {
                unroll_factor = MaxCount;
                Logger::logDebug("[LoopUnroll] May be vectorized, estimated factor >= MaxCount, use MaxCount.");
            }
        } else {
            unroll_factor = std::min(MaxSize / size, MaxCount);
            Logger::logDebug("[LoopUnroll] Can't be vectorized, use plain factor.");
        }
        return static_cast<int>(unroll_factor);
    };

    if (trip_countE->isIRValue() && trip_countE->getIRValue()->is<ConstantInt>()) {
        // 常量展开策略
        const auto trip_countN = trip_countE->getIRValue()->as<ConstantInt>()->getVal();
        Logger::logDebug("[LoopUnroll] Trip count: "+ std::to_string(trip_countN));

        if (trip_countN < 2) {
            Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's trip count < 2");
            option.disable();
            return;
        }

        // For fully unroll
        if (ENABLE_FULLY_UNROLL) {
            if (trip_countN <= FUC && trip_countN*inst_size <= FUS) {
                Logger::logInfo("[LoopUnroll] Fully unrolling: factor: " + std::to_string(trip_countN));
                option.enable_fully(trip_countN);
                return;
            }
        }

        // For partially unroll
        if (ENABLE_PARTIALLY_UNROLL) {
            // Calculate unroll factor
            auto unroll_factor = calcUnrollFactor(loop, inst_size, PUS, PUC);

            if (unroll_factor < 2) {
                Logger::logInfo("[LoopUnroll] Partially unroll disabled because the unroll_factor is less than 2.");
                option.disable();
                return;
            }
            if (trip_countN < unroll_factor) {
                Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's trip count < unroll_factor, may need to fully unroll?");
                option.disable();
                return;
            }
            
            unsigned remainder = trip_countN % unroll_factor;

            Logger::logInfo("[LoopUnroll] Partially unrolling: factor: " + std::to_string(unroll_factor) + ", remainder: " + std::to_string(remainder) + ", trip_count: " + std::to_string(trip_countN));
            option.enable_partially(unroll_factor);

            if (remainder != 0) {
                {
                    // Check if loop's exit condition is eq
                    if (auto eb = loop->getExitingBlocks(); eb.size() == 1) {
                        if (auto cd = eb.begin()->get()->getBRInst()->getCond()->as<Instruction>(); cd->getOpcode() == OP::ICMP) {
                            if (auto icmpop = cd->as<ICMPInst>()->getCond(); icmpop == ICMPOP::eq) {
                                Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's exit condition is '==' while it has remainder.");
                                option.disable();
                                return;
                            }
                        } else {
                            Err::unreachable();
                        }
                    } else {
                        Err::unreachable();
                    }
                }

                {
                    // Calculate new boundary
                    pVal iter_variable, raw_boundary_value;
                    if (!GetIterVarAndBoundary(loop, iter_variable, raw_boundary_value)) {
                        Logger::logInfo("[LoopUnroll] Unroll disabled because can't get the loop's iter_variable and boundary.");
                        option.disable();
                        return;
                    }

                    Logger::logDebug("[LoopUnroll] Get iter variable: "+ IRFormatter::formatValue(*iter_variable));
                    Logger::logDebug("[LoopUnroll] Get raw boundary value: "+ IRFormatter::formatValue(*raw_boundary_value));
                    if (!raw_boundary_value->is<ConstantInt>()) {
                        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's boundary is not constant integer.");
                        option.disable();
                        return;
                    }

                    int step;
                    if (!GetIntegerStep(SCEVH, iter_variable, step)) {
                        Logger::logInfo("[LoopUnroll] Unroll disabled because can't get the loop's iter_variable's step.");
                        option.disable();
                        return;
                    }

                    // // Just for test, remove later
                    // pVal real_base_value;
                    // if (!GetBaseValue(loop, is_dowhile, iter_variable, real_base_value)) {
                    //     Logger::logInfo("[LoopUnroll] Unroll disabled because can't get the loop's iter_variable's base.");
                    //     option.disable();
                    //     return;
                    // }
                    // if (!real_base_value->is<ConstantInt>()) {
                    //     Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's iter_variable's base is not constant integer.");
                    //     option.disable();
                    //     return;
                    // }
                    // int real_base = real_base_value->as<ConstantInt>()->getVal();

                    // const int suf = static_cast<int>(unroll_factor);
                    // if (is_dowhile) {
                    //     new_boundary_num = base + step * suf * (trip_countn / suf - 1) + (step>0?-1:1);
                    // } else {
                    //     new_boundary_num = base + step * suf * (trip_countn / suf) + (step>0?-1:1);
                    // }

                    int raw_boundary_num = raw_boundary_value->as<ConstantInt>()->getVal();
                    int new_boundary_num = raw_boundary_num - step * static_cast<int>(remainder);
                    Logger::logDebug("[LoopUnroll] Get integer step: "
                        + std::to_string(step) + ", new_boundary_num: "+ std::to_string(new_boundary_num));

                    auto new_boundary_value = FC.getConst(new_boundary_num);
                    option.set_remainder(remainder, raw_boundary_value, new_boundary_value);
                }
            }
            return;
        }

        Logger::logInfo("[LoopUnroll] Needs to fully or partially unroll but both are disabled...");
        option.disable();
        return;
    } else {
        // 变量展开策略
        if (ENABLE_RUNTIME_UNROLL) {
            // Calculate unroll factor
            int unroll_factor = calcUnrollFactor(loop, inst_size, RUS, RUC);

            if (unroll_factor < 2) {
                Logger::logInfo("[LoopUnroll] Runtime unroll disabled because the unroll_factor is less than 2.");
                option.disable();
                return;
            }
            Logger::logInfo("[LoopUnroll] Runtime unrolling: factor: " + std::to_string(unroll_factor));
            auto unroll_factorV = FC.getConst(unroll_factor);

            // Get boundary and iter variable
            pVal iter_variable, raw_boundary_value;
            if (!GetIterVarAndBoundary(loop, iter_variable, raw_boundary_value)) {
                Logger::logInfo("[LoopUnroll] Unroll disabled because can't get the loop's iter_variable and boundary.");
                option.disable();
                return;
            }
            Logger::logDebug("[LoopUnroll] Get iter variable: "+ IRFormatter::formatValue(*iter_variable));
            Logger::logDebug("[LoopUnroll] Get raw boundary value: "+ IRFormatter::formatValue(*raw_boundary_value));

            // Get step
            SCEVExpr* stepE;
            if (!GetExprStep(SCEVH, iter_variable, stepE)) {
                Logger::logInfo("[LoopUnroll] Unroll disabled because can't get the loop's iter_variable's step.");
                option.disable();
                return;
            }
            pVal stepV = nullptr;
            if (stepE->isIRValue()) {
                stepV = stepE->getIRValue();
                Logger::logDebug("[LoopUnroll] Get value step: "+ IRFormatter::formatValue(*stepV));
            }

            // // Get base value
            // pVal baseV;
            // if (!GetBaseValue(loop, is_dowhile, iter_variable, baseV)) {
            //     Logger::logInfo("[LoopUnroll] Unroll disabled because can't get the loop's iter_variable's base.");
            //     option.disable();
            //     return;
            // }
            // Logger::logDebug("[LoopUnroll] Get base: "+ IRFormatter::formatValue(*baseV))

            // For dowhile:
            //  pre_header
            //     |
            //   prolog---(if trip_count < unroll_factor)-->rem_loop's header
            //     |                                                |
            // cloned_loop---------->epilog---------->rem_loop's header's next non-exit block
            //              exitingb    |(if rem==0)
            //                         exit
            // while loop has no epilog, cloned_loop jump to rem_loop's header

            pBlock prolog = std::make_shared<BasicBlock>("rtunroll.prolog." + std::to_string(name_idx));
            pBlock epilog = std::make_shared<BasicBlock>("rtunroll.epilog." + std::to_string(name_idx));

            // prolog
            auto trip_countV = SCEVH.expandSCEVExprUnchecked(trip_countE, prolog, prolog->end());
            auto remainderV = std::make_shared<BinaryInst>("rtunroll.remainder." + std::to_string(name_idx), OP::SREM, trip_countV, unroll_factorV);
            prolog->addInst(remainderV);
            if (stepV == nullptr) {
                stepV = SCEVH.expandSCEVExprUnchecked(stepE, prolog, prolog->end());
            }
            auto stepMremV = std::make_shared<BinaryInst>("rtunroll.stepMrem." + std::to_string(name_idx), OP::MUL, stepV, remainderV);
            prolog->addInst(stepMremV);
            // new_boundary = raw_boundary - step * remainder
            auto new_boundaryV = std::make_shared<BinaryInst>("rtunroll.new_boundary." + std::to_string(name_idx), OP::SUB, raw_boundary_value, stepMremV);
            prolog->addInst(new_boundaryV);

            // tcLTuf and epilog (for dowhile)
#if ENABLE_NEW_RT_PATH
            if (is_dowhile) {
#endif
                auto trip_count_less_than_unroll_factorV = std::make_shared<ICMPInst>("rtunroll.tcLTuf." + std::to_string(name_idx),
                    ICMPOP::slt, trip_countV, unroll_factorV);
                trip_count_less_than_unroll_factorV->appendDbgData("trip_count_less_than_unroll_factor");
                prolog->addInst(trip_count_less_than_unroll_factorV);
#if ENABLE_NEW_RT_PATH
            }
#endif

            // epilog (for dowhile)
            if (is_dowhile) {
                auto rem_eq_zeroV = std::make_shared<ICMPInst>("rtunroll.remEQzero." + std::to_string(name_idx),
                    ICMPOP::eq, remainderV, FC.getConst(0));
                rem_eq_zeroV->appendDbgData("rem_eq_zero");
                epilog->addInst(rem_eq_zeroV);
            }

            option.enable_runtime(unroll_factor, prolog, epilog);
            option.set_remainder(-1, raw_boundary_value, new_boundaryV);
            return;
        }

        Logger::logInfo("[LoopUnroll] Needs to runtime unroll but disabled...");
        option.disable();
        return;
    }

    Logger::logInfo("[LoopUnroll] Unroll disabled because of some default reasons.");
    option.disable();
}

bool LoopUnrollPass::peel(const pLoop &loop, const UnrollOption &option, Function &func) {
    // TODO
    if (!option.peel) {
        return false;
    }
    return true;
}

bool LoopUnrollPass::unroll(const pLoop &loop, const UnrollOption &option, Function &func, FAM &fam) {
    if (!option.unroll) {
        return false;
    }

    if (option.unroll_count < 2) {
        return false;
    }

    if (option.fully() && option.has_remainder) {
        Err::error("unexpected arguments");
        return false;
    }
    
    if (option.runtime() && !option.has_remainder) {
        Err::error("unexpected arguments");
        return false;
    }

    if (!loop->getPreHeader()) {
        return false;
    }

    if (!loop->getLatch()) {
        return false;
    }

    // Check Attr
    if (auto unroll_attrs = loop->getHeader()->attr().get<UnrollAttrs>(); unroll_attrs != nullptr) {
        if (option.fully()) {
            // No check, fully unroll all.
        } else if (option.partially() && !option.has_remainder) {
            // No check, unroll all.
        } else if (option.partially() && option.has_remainder) {
            // Just unroll no-rem
            if (!unroll_attrs->has(UnrollAttr::NoRem)) {
                Logger::logInfo("[LoopUnroll] Unroll disabled because the loop has been unrolled while it has remainder.");
                return false;
            }
        } else if (option.runtime()) {
            // Just unroll no-rem
            if (!unroll_attrs->has(UnrollAttr::NoRem)) {
                Logger::logInfo("[LoopUnroll] Unroll disabled because the loop has been unrolled while it has remainder.");
                return false;
            }
        }
    }

    // !hasAddressTaken()

    bool is_dowhile = loop->isExiting(loop->getLatch());

    if (option.runtime() && !is_dowhile && hasSideEffect(fam, loop->getHeader())) {
        // PrintFunctionPass pfp(std::cerr);
        // pfp.run(func, fam);
        Err::error("Runtime unroll but the header " + loop->getHeader()->getName() + " has side effect.");
        return false;
    }

    name_idx++;

    const auto count = option.unroll_count;
    const auto pre_header = loop->getPreHeader();
    const auto header = loop->getHeader();
    const auto latch = loop->getLatch();
    const auto loop_blocks = loop->getBlocks();
    const auto exits = loop->getExitBlocks();

    using pB = pBlock;
    using pI = pInst;
    using BV = std::vector<pB>;
    using IV = std::vector<pI>;

    std::vector<pB> blocks;
    {
        // LOOP BLOCK DFS ON CFG
        std::set<pB> visited;
        std::stack<pB> stack;
        stack.push(header);
        while (!stack.empty()) {
            pB b = stack.top();
            stack.pop();
            if (visited.count(b)) continue;
            visited.insert(b);
            blocks.push_back(b);
            auto succb = b->getNextBB();
            for (auto it = succb.rbegin(); it != succb.rend(); ++it) {
                if (!visited.count(*it) && !exits.count(*it)) {
                    stack.push(*it);
                }
            }
        }
    }

    // 新旧BB, Inst映射，用于快速查找
    // <raw, new_vector>
    // new_vector[0] == raw
    std::map<pB, BV> BMap;
    std::map<pI, IV> IMap;

    // Return IMap[inst][i] or inst.
    auto IMapFind = [&](const pI &inst, const unsigned i) {
        auto ret = inst;
        Err::gassert(ret != nullptr, "IMapFind: inst is nullptr.");
        if (const auto it = IMap.find(inst); it != IMap.end()) {
            ret =  it->second[i];
            Err::gassert(ret != nullptr, "IMapFind: Result is nullptr.");
        }
        return ret;
    };

    auto IMapFindAndReplaceOperand = [&](const pI &inst, const pVal &rawv, const unsigned i) {
        auto result = IMapFind(rawv->as<Instruction>(), i);
        if (result != rawv) {
            inst->replaceAllOperands(rawv, result);
        }
    };

    // Return BMap[block][i] or block.
    auto BMapFind = [&](pB block, const unsigned i) {
        if (const auto it = BMap.find(block); it != BMap.end()) {
            return it->second[i];
        }
        return block;
    };

    // initialize B/IMap
    // count+1是为了容纳完全展开的while循环的最后一个header或余数循环的块
    for (const auto &bb : blocks) {
        BMap[bb] = BV(count + 1, nullptr);
        BMap[bb][0] = bb;
        for (int i = 1; i < count; i++) {
            BMap[bb][i] = std::make_shared<BasicBlock>(bb->getName() + "." + std::to_string(name_idx) + "unroll" + std::to_string(i));
        }
        BMap[bb][count] = std::make_shared<BasicBlock>(bb->getName() + "." + std::to_string(name_idx) + "remainder");
        for (const auto &inst : bb->all_insts()) {
            IMap[inst] = IV(count + 1, nullptr);
            IMap[inst][0] = inst;
        }
    }

    /// clone loop: 克隆count-1次原循环。条件，迭代等尚未优化...
    ///
    /// preHeader             preHeader
    ///     |                 Header[0]<-----
    ///   Header<---           Body[0]      |
    ///     |      |          Latch [0]     |
    ///    Body    |  ---->   Header[1]     |
    ///     |      |           ......       |
    ///   Latch-----        Latch[count-1]---
    ///
    /// latch[n]---->header[n+1]
    ///
    /// Simplified loop has only one preHeader, and the pred BB of the header is the preHeader and the latch of the loop.
    /// When unrolled, the 'latches' except the last one point to the next header.
    /// As a result, the original Header has two pred BBs: the preHeader and the last latch.
    /// The other 'headers' of the cloned part have only one pred BB -- the latch of the previous part.
    ///
    /// LCSSA loop's 'live in variable' is used in the PHI node of the header block.
    /// Since the cloned headers have only one predecessor BB, the phi of the cloned headers can be replaced with
    /// the value of the latch from the previous cloned part. The operands of the PHI node in exit blocks will be
    /// expanded with the value of the cloned exiting block.

    // clone other inst
    auto CloneNonPhiInst = [&](const pB &raw, const pB &cur, const unsigned i) {
        for (const auto &inst : *raw) {
            const auto new_inst = makeClone(inst);
            if (i == count) {
                new_inst->setName(inst->getName() + "." + std::to_string(name_idx) + "remainder");
            } else {
                new_inst->setName(inst->getName() + "." + std::to_string(name_idx) + "unroll" + std::to_string(i));
            }
            IMap[inst][i] = new_inst;
            if (inst->getOpcode() == OP::BR) {
                for (auto value : inst->operands()) {
                    if (value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        IMapFindAndReplaceOperand(new_inst, value, i);
                    } else if (value->getVTrait() == ValueTrait::BASIC_BLOCK) {
                        if (auto nv = BMapFind(value->as<BasicBlock>(), i); nv != value) {
                            new_inst->replaceAllOperands(value, nv);
                        }
                    }
                }
            } else {
                for (auto value : inst->operands()) {
                    if (value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        IMapFindAndReplaceOperand(new_inst, value, i);
                    }
                }
            }
            cur->addInst(new_inst);
        }
    };

    /// Add new phi oper(copied from raw exiting block) to the exit block's phi
    /// @p raw raw exiting block(template phi oper from raw block)
    /// @p cur new exiting block(new phi oper's "block")
    /// @p i new phi oper's "value" from the i-th time iteration
    auto ProcessExitingBlock = [&](const pB &raw, const pB &cur, const unsigned i) {
        if (loop->isExiting(raw)) {
            for (auto succ : raw->succs()) {
                if (exits.count(succ)) {
                    for (auto &phi : succ->phis()) {
                        auto pov = phi->getPhiOpers();
                        for (auto &phi_oper : pov) {
                            if (phi_oper.block == raw) {
                                if (phi_oper.value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                                    phi->addPhiOper(IMapFind(phi_oper.value->as<Instruction>(), i), cur);
                                } else if (phi_oper.value->getVTrait() == ValueTrait::BASIC_BLOCK) {
                                    Err::unreachable();
                                } else {
                                    phi->addPhiOper(phi_oper.value, cur);
                                }
                            }
                        }
                    }
                }
            }
        }
    };

    // Clone header to BMap[header][i], update exit block's phi.
    auto CloneHeaderBlock = [&](const unsigned i) {
        const auto &rh = header;     // raw header
        const auto ch = BMap[rh][i]; // current header

        // clone header's phi, replace with previous part's value
        for (auto &phi : rh->phis()) {
            auto phi_value_from_loop = phi->getValueForBlock(latch);
            // 如果原始header的phi里的value是常量的话，就无法存到IMap里面了，同时由于其user尚未创建，无法直接把常量传播
            // 故使用 phi [v, b] 形式
            const auto new_phi =
                std::make_shared<PHIInst>(phi->getName() + "." + std::to_string(name_idx) + "unroll" + std::to_string(i), phi->getType());
            IMap[phi][i] = new_phi;
            if (phi_value_from_loop->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                // Instruction情况
                new_phi->addPhiOper(IMapFind(phi_value_from_loop->as<Instruction>(), i - 1), BMap[latch][i - 1]);
            } else {
                // 其他情况：常量、全局变量
                new_phi->addPhiOper(phi_value_from_loop, BMap[latch][i - 1]);
            }
            ch->addPhiInst(new_phi);
        }

        CloneNonPhiInst(rh, ch, i);
    };

    // clone blocks, link blocks, update phi...
    for (int i = 1; i < count; i++) {
        auto raw_bb_iter = blocks.begin();

        // process header
        CloneHeaderBlock(i);

        // process other block
        ++raw_bb_iter;
        while (raw_bb_iter != blocks.end()) {
            auto rb = (*raw_bb_iter)->as<BasicBlock>(); // current raw block
            auto cb = BMap[rb][i];                      // current block

            // clone phi
            for (const auto &phi : rb->phis()) {
                auto new_phi = makeClone(phi);
                new_phi->setName(phi->getName() + "." + std::to_string(name_idx) + "unroll" + std::to_string(i));
                IMap[phi][i] = new_phi;
                cb->addPhiInst(new_phi);
            }

            CloneNonPhiInst(rb, cb, i);

            ++raw_bb_iter;
        }

        // update phi oper
        raw_bb_iter = blocks.begin();
        ++raw_bb_iter;
        while (raw_bb_iter != blocks.end()) {
            auto rb = (*raw_bb_iter)->as<BasicBlock>();
            auto cb = BMap[rb][i];
            for (const auto &phi : rb->phis()) {
                auto new_phi = IMap[phi][i];
                for (auto it = phi->operand_begin(); it != phi->operand_end(); ++it) {
                    // val, blk, val, blk...
                    auto v = *it;
                    if (v->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        IMapFindAndReplaceOperand(new_phi, v, i);
                    }
                    v = *++it;
                    new_phi->replaceAllOperands(v, BMap[v->as<BasicBlock>()][i]);
                }
            }
            ++raw_bb_iter;
        }
    }

    const auto last_latch = BMap[latch][count - 1];

    // just for one exit:
    const auto raw_loop_exiting = is_dowhile ? latch : header;
    const auto unrolled_loop_exiting = is_dowhile ? last_latch : header;
    Err::gassert(loop->getExitBlocks().size() == 1, "LoopUnroll: Multiple Exit.");
    const auto exitb = *(loop->getExitBlocks().begin());

    // clone remainder to BMap[b][count]
    if ((option.partially() && option.has_remainder) || option.runtime()) {
        // auto rem = option.remainder;

        // process header
        {
            const auto &rh = header;     // raw header
            const auto ch = BMap[rh][count]; // current header

            // clone inst and create phi
            for (auto &phi : rh->phis()) {
                const auto new_phi = std::make_shared<PHIInst>(phi->getName() + "." + std::to_string(name_idx) + "remainder", phi->getType());
                IMap[phi][count] = new_phi;
                ch->addPhiInst(new_phi);
            }
            CloneNonPhiInst(rh, ch, count);
        }

        // process other block
        auto raw_bb_iter = blocks.begin();
        ++raw_bb_iter;
        while (raw_bb_iter != blocks.end()) {
            auto rb = (*raw_bb_iter)->as<BasicBlock>(); // current raw block
            auto cb = BMap[rb][count];                      // current block

            // clone phi
            for (const auto &phi : rb->phis()) {
                auto new_phi = makeClone(phi);
                new_phi->setName(phi->getName() + "." + std::to_string(name_idx) + "remainder");
                IMap[phi][count] = new_phi;
                cb->addPhiInst(new_phi);
            }

            CloneNonPhiInst(rb, cb, count);
            ++raw_bb_iter;
        }

        // update phi oper
        raw_bb_iter = blocks.begin();
        ++raw_bb_iter;
        while (raw_bb_iter != blocks.end()) {
            auto rb = (*raw_bb_iter)->as<BasicBlock>();
            auto cb = BMap[rb][count];
            for (const auto &phi : rb->phis()) {
                auto new_phi = IMap[phi][count];
                for (auto it = phi->operand_begin(); it != phi->operand_end(); ++it) {
                    // val, blk, val, blk...
                    auto v = *it;
                    if (v->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        IMapFindAndReplaceOperand(new_phi, v, count);
                    }
                    v = *++it;
                    new_phi->replaceAllOperands(v, BMap[v->as<BasicBlock>()][count]);
                }
            }
            ++raw_bb_iter;
        }

        // add rem header's phi's phioper: from latch, from main loop's last latch(for dowhile)
        // note: in while loop: main header--->remainder's next block(skip remainder header)
        for (auto &phi : header->phis()) {
            auto rem_phi = IMap[phi][count]->as<PHIInst>();
            auto phi_value_from_latch = phi->getValueForBlock(latch);

            if (phi_value_from_latch->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                // Instruction情况
                rem_phi->addPhiOper(IMapFind(phi_value_from_latch->as<Instruction>(), count), BMap[latch][count]);
            } else {
                // 其他情况：常量、全局变量
                rem_phi->addPhiOper(phi_value_from_latch, BMap[latch][count]);
            }

            // 1. For dowhile: from last latch
            // 2. For while: skip
            // 3. For while in runtime unroll: from header
            if (is_dowhile) {
                if (phi_value_from_latch->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                    rem_phi->addPhiOper(IMapFind(phi_value_from_latch->as<Instruction>(), count-1), last_latch);
                } else {
                    rem_phi->addPhiOper(phi_value_from_latch, last_latch);
                }
            } else if (!is_dowhile && option.runtime()) {
                // 注意此处的phi_value_from_latch的parent不一定是latch, 只是latch路径上的phi_value
                if (phi_value_from_latch->getVTrait() == ValueTrait::ORDINARY_VARIABLE && phi_value_from_latch->as<Instruction>()->getParent() == header) {
                    // 如果此phi_oper的value在header中赋值，则remainder中的对应phi_oper的value应该是原header中的值
                    rem_phi->addPhiOper(phi_value_from_latch, header);
                } else {
                    rem_phi->addPhiOper(phi, header);
                }
            }
        }

        // Change main loop's iterative boundary
        auto br = unrolled_loop_exiting->getBRInst();
        if (br->isConditional()) {
            auto cond = br->getCond()->as<Instruction>();
            if (cond->getOpcode() == OP::ICMP) {
                auto icmp = cond->as<ICMPInst>();
                if (option.raw_boundary_value != option.new_boundary_value)
                    icmp->replaceAllOperands(option.raw_boundary_value, option.new_boundary_value);
                // 此处给展开循环的判断条件改为非等，防止多执行
                switch (icmp->getCond()) {
                    case ICMPOP::sge:
                        icmp->cond = ICMPOP::sgt;
                        break;
                    case ICMPOP::sle:
                        icmp->cond = ICMPOP::slt;
                        break;
                    case ICMPOP::sgt:
                    case ICMPOP::slt:
                    case ICMPOP::ne:
                        break;
                    default: // eq
                        // PrintFunctionPass pfp(std::cerr);
                        // pfp.run(func, fam);
                        // Err::unreachable("ICMPOP::eq!");
                        break;
                }
            } else {
                Err::unreachable();
            }
        } else {
            Err::unreachable();
        }
    }

    // clone last header to BMap[header][count]
    if (option.fully() && !is_dowhile) {
        CloneHeaderBlock(count);
    }

    auto DropExitbAndItsPhiOper = [&](const pB &target) {
        auto br = target->getBRInst();
        // // Delete undeleted BR Exitb, maybe useless.
        // if (br->isConditional()) {
        //     if (br->getTrueDest() == exitb) {
        //         br->dropTrueDest();
        //     } else if (br->getFalseDest() == exitb) {
        //         br->dropFalseDest();
        //     }
        // }
        for (auto &phi : exitb->phis()) {
            phi->delPhiOperByBlock(target);
        }
    };

    // 处理展开后循环内的跳转关系：丢弃内部退出跳转，更新br-->next_header or new Exiting Block(when dowhile or has remainder)
    // 1. Drop
    if (is_dowhile) {
        for (int i = 0; i < count-1; i++) {
            BMap[latch][i]->getBRInst()->dropOneDest(exitb);
        }
    } else {
        for (int i = 1; i < count; i++) {
            BMap[header][i]->getBRInst()->dropOneDest(exitb);
        }
    }
    // 2.1 Update cloned loop's latch's br
    for (int i = 0; i < count-1; i++) {
        BMap[latch][i]->getBRInst()->replaceAllOperands(BMap[header][i], BMap[header][i + 1]);
    }
    // 2.2 Update last latch's or header's br
    if (option.fully()) {
        if (is_dowhile) {
            last_latch->getBRInst()->dropOneDest(BMap[header][count-1]);
            ProcessExitingBlock(latch, last_latch, count-1);
            DropExitbAndItsPhiOper(latch);
        } else {
            header->getBRInst()->dropOneDest(exitb);
            last_latch->getBRInst()->replaceAllOperands(BMap[header][count-1], BMap[header][count]);
            // BMap[header][count]仅保留br exitb
            auto lhbr = BMap[header][count]->getBRInst();
            if (lhbr->getFalseDest() == exitb) {
                lhbr->dropTrueDest();
            } else if (lhbr->getTrueDest() == exitb) {
                lhbr->dropFalseDest();
            } else {
                Err::unreachable();
            }
            ProcessExitingBlock(header, BMap[header][count], count);
            DropExitbAndItsPhiOper(header);
        }
    } else if (option.partially() || option.runtime()) {
        last_latch->getBRInst()->replaceAllOperands(BMap[header][count-1], header);
        if (option.has_remainder && is_dowhile) {
            last_latch->getBRInst()->replaceAllOperands(exitb, BMap[header][count]);
            ProcessExitingBlock(latch, BMap[latch][count], count);
            if (option.runtime()) {
                // After that, need to replace "last_latch" with "epilog"
                ProcessExitingBlock(latch, last_latch, count-1);
            }
            DropExitbAndItsPhiOper(latch);
        } else if (option.has_remainder && !is_dowhile) {
            pB rem_header = BMap[header][count];

            if (option.partially()) {
                // Just for partially unroll
                // add phi for new remainder's header(rem header's next block in loop)
                // main header---   rem header
                //      |       |       |-------->Exit
                //     ...      --->certain blk
                pB rem_target;

                {
                    pB raw_target;
                    {
                        auto _true = header->getBRInst()->getTrueDest();
                        raw_target = _true!=exitb ? _true : header->getBRInst()->getFalseDest();
                    }
                    rem_target = BMap[raw_target][count];
                    std::unordered_set<pI> worklist;
                    {
                        for (const auto &hinst : header->all_insts()) {
                            for (const auto &user : hinst->users()) {
                                // 此处默认 User 均为 Inst
                                // if (user->getVTrait() != ValueTrait::ORDINARY_VARIABLE && user->getVTrait() != ValueTrait::VOID_INSTRUCTION)
                                //     continue;
                                auto uinst = user->as<Instruction>();
                                auto uparent = uinst->getParent();
                                if ((uparent != header && loop->contains(uparent)) || (uparent == header && uinst->getOpcode() == OP::PHI)) {
                                    worklist.insert(hinst);
                                    break;
                                }
                            }
                        }
                    }
                    // ADD NEW PHI
                    for (const auto &inst : worklist) {
                        auto new_phi = std::make_shared<PHIInst>(inst->getName() + "." + std::to_string(name_idx) + "remphi", inst->getType());
                        auto remv = IMap[inst][count];
                        // Logger::logDebug("remv: " + remv->getName() + ", new_phi: " + new_phi->getName());
                        {
                            auto ulist = remv->getUseList();
                            for (const auto &use : ulist) {
                                if (auto user = use->getUser()->as<Instruction>();
                                    user->getParent() == rem_header && user->getOpcode() != OP::PHI)
                                    continue;
                                use->setValue(new_phi);
                            }
                        }
                        new_phi->addPhiOper(remv, rem_header);
                        new_phi->addPhiOper(inst, header);
                        rem_target->addPhiInst(new_phi);

                        // UPDATE TARGET BLOCK'S PHI
                        for (auto &phi : raw_target->phis()) {
                            auto rem_phi = IMap[phi][count]->as<PHIInst>();
                            rem_phi->addPhiOper(phi->getValueForBlock(header), header);
                        }
                    }
                }

                header->getBRInst()->replaceAllOperands(exitb, rem_target);
            } else {
                // For runtime unroll
                header->getBRInst()->replaceAllOperands(exitb, rem_header);
            }

            ProcessExitingBlock(header, rem_header, count);
            DropExitbAndItsPhiOper(header);
        } else if (!option.has_remainder && is_dowhile) {
            ProcessExitingBlock(latch, last_latch, count-1);
            DropExitbAndItsPhiOper(latch);
        }
    } else {
        Err::unreachable();
    }

    // process raw header's phi node:
    // For partially or runtime: [%x, latch] --> [%xx, last_latch]
    // For fully: delete [%x, latch]
    for (const auto &phi : header->phis()) {
        if (option.partially() || option.runtime()) {
            auto phi_value_from_loop = phi->getValueForBlock(latch);
            if (phi_value_from_loop->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                IMapFindAndReplaceOperand(phi, phi_value_from_loop, count - 1);
            }
            phi->replaceAllOperands(latch, last_latch);
        } else if (option.fully()) {
            phi->delPhiOperByBlock(latch);
        } else {
            Err::unreachable();
        }
    }

    // Set block attr
    auto setUnrollAttr = [](const pB &block, const int setmode) {
        UnrollAttrs unroll_attrs{UnrollAttr::Unrolled};
        switch (setmode) {
            case 0:
                break;
            case 1:
                unroll_attrs.set(UnrollAttr::NoRem);
                break;
            case 2:
                unroll_attrs.set(UnrollAttr::RemBlock);
                break;
            default:
                Err::unreachable();
            }
        auto attrs = block->attr();
        attrs.remove<UnrollAttrs>(); // clear old
        attrs.add(unroll_attrs);
    };
    for (int i = 0; i < count; i++) { // Main loop
        if (!option.fully()) {
            for (auto &b : blocks) {
                setUnrollAttr(BMap[b][count], option.has_remainder ? 0 : 1);
            }
        }
    }
    if (!option.fully() && option.has_remainder) { // Rem Loop
        for (auto &b : blocks) {
            setUnrollAttr(BMap[b][count], 2);
        }
        if (option.runtime()) {
            setUnrollAttr(option.prologue, 0);
            setUnrollAttr(option.epilogue, 0);
        }
    }

    // add to function
    auto it_after_loop = ++std::find(func.begin(), func.end(), loop_blocks.back()->as<BasicBlock>());
    for (int i = 1; i < count; i++) {
        for (auto &b : blocks) {
            func.addBlock(it_after_loop, BMap[b][i]);
        }
    }
    if (option.fully() && !is_dowhile) {
        func.addBlock(it_after_loop, BMap[header][count]);
    } else if ((option.partially() && option.has_remainder) || option.runtime()) {
        for (auto &b : blocks) {
            func.addBlock(it_after_loop, BMap[b][count]);
        }
    }

    // process runtime unroll
    if (option.runtime()) {
        auto prolog = option.prologue;
        auto epilog = option.epilogue;
        Err::gassert(prolog != nullptr && epilog != nullptr, "LoopUnroll: Runtime unroll prolog or epilog is nullptr.");

        pB rem_header = BMap[header][count];

        // Add branch inst to prolog
#if ENABLE_NEW_RT_PATH
        if (!is_dowhile) {
            pBr prolog_br = std::make_shared<BRInst>(header);
            prolog->addInst(prolog_br);
        } else {
#endif
            pIcmp prolog_icmp = prolog->getTerminator()->as<ICMPInst>();
            pBr prolog_br = std::make_shared<BRInst>(prolog_icmp, rem_header, header);
            prolog->addInst(prolog_br);
#if ENABLE_NEW_RT_PATH
        }
#endif

        // Link prolog
        pre_header->getBRInst()->replaceAllOperands(header, prolog);
        for (auto &phi : header->phis()) {
#if ENABLE_NEW_RT_PATH
            if (is_dowhile) {
#endif
                IMap[phi][count]->as<PHIInst>()->addPhiOper(phi->getValueForBlock(pre_header), prolog);
#if ENABLE_NEW_RT_PATH
            }
#endif
            phi->replaceAllOperands(pre_header, prolog);
        }

        // add to function
        func.addBlock(std::find(func.begin(), func.end(), header), prolog);

        if (is_dowhile) {
            // Add branch inst to epilog
            pIcmp epilog_icmp = epilog->getTerminator()->as<ICMPInst>();
            pB replace_target;
            if (!is_dowhile) {
                auto _true = header->getBRInst()->getTrueDest();
                pB raw_target = _true!=exitb ? _true : header->getBRInst()->getFalseDest();
                replace_target = BMap[raw_target][count];
            } else {
                replace_target = rem_header;
            }
            pBr epilog_br = std::make_shared<BRInst>(epilog_icmp, exitb, replace_target);
            epilog->addInst(epilog_br);

            // Link epilog
            unrolled_loop_exiting->getBRInst()->replaceAllOperands(replace_target, epilog);
            for (auto &phi : replace_target->phis()) {
                phi->replaceAllOperands(unrolled_loop_exiting, epilog);
            }
            for (auto &phi : exitb->phis()) {
                phi->replaceAllOperands(unrolled_loop_exiting, epilog);
            }

            // add to function
            func.addBlock(std::find(func.begin(), func.end(), rem_header), epilog);
        }
    }

    // optimize new cfg...
    func.updateAndCheckCFG();

    return true;
}

PM::PreservedAnalyses LoopUnrollPass::run(Function &function, FAM &fam) {
    bool modified = false;
    bool last_round_modified = false;
    auto RLI = fam.getResult<LoopAnalysis>(function);

    if (RLI.getTopLevelLoops().empty()) {
        return PreserveAll();
    }

    unsigned all_loop_size = 0;
    for (auto &toploop : RLI) {
        all_loop_size += toploop->getInstCount();
    }
    Logger::logInfo("[LoopUnroll] All loop size: " + std::to_string(all_loop_size));
    if (all_loop_size > 300) {
        Logger::logInfo("[LoopUnroll] Unroll disabled because the func's loops are too big!");
        return PreserveAll();
    }

    for (auto &toploop : RLI) {
        auto dfvisitor = toploop->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (auto &rawloop : dfvisitor) {
            if (!rawloop->isInnermost()) {
                // TODO: 暂时只处理最内层循环
                continue;
            }
            auto &NLI = fam.getResult<LoopAnalysis>(function);
            auto loop = NLI.getLoopFor(rawloop->getHeader());
            UnrollOption option;
            analyze(loop, option, function, fam);
            auto peeled = peel(loop, option, function);
            auto unrolled = unroll(loop, option, function, fam);
            last_round_modified = peeled || unrolled;
            modified = modified || last_round_modified;

            if (last_round_modified)
                fam.invalidate(function, PreserveNone());
        }
    }

    return modified ? PreserveNone() : PreserveAll();
}

} // namespace IR