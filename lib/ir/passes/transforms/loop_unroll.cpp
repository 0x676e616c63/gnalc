#include "ir/passes/transforms/loop_unroll.hpp"
#include "ir/base.hpp"
#include "ir/block_utils.hpp"
#include "ir/formatter.hpp"
#include "ir/instruction.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "utils/exception.hpp"
#include <algorithm>


namespace IR {
void LoopUnrollPass::analyze(const pLoop &loop, UnrollOption &option, LoopInfo& LI, Function &FC, DomTree &DT) {
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

    auto SCEVH = SCEVHandle(&FC, &LI, &DT);
    const auto TC = SCEVH.getTripCount(loop);
    if (TC == nullptr) {
        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop can't get trip count.");
        option.disable();
        return;
    }

    if (TC->isIRValue() && TC->getIRValue()->is<ConstantInt>()) {
        // 常量展开策略
        const auto trip_countn = TC->getIRValue()->as<ConstantInt>()->getVal();

        /// TODO: Fully unroll when trip_count == 1?
        if (trip_countn < 2) {
            Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's trip count < 2");
            option.disable();
            return;
        }

        // For fully unroll
        if (ENABLE_FULLY_UNROLL) {
            if (trip_countn <= FUC && trip_countn*inst_size <= FUS) {
                Logger::logInfo("[LoopUnroll] Fully unrolling: factor: " + std::to_string(trip_countn));
                option.enable_fully(trip_countn);
                return;
            }
        }

        // For partially unroll
        if (ENABLE_PARTIALLY_UNROLL) {
            // Calculate unroll factor
            /// TODO: May need optimize
            auto unroll_factor = PUS / inst_size;
            if (unroll_factor == 0) {
                Logger::logInfo("[LoopUnroll] Unroll disabled because the unroll_factor is 0!");
                option.disable();
                return;
            }
            unroll_factor = std::min(unroll_factor, PUC);
            unsigned remainder = trip_countn % unroll_factor;

            if (trip_countn < unroll_factor) {
                Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's trip count < unroll_factor, may need to fully unroll?");
                option.disable();
                return;
            }

            Logger::logInfo("[LoopUnroll] Partially unrolling: factor: " + std::to_string(unroll_factor) + ", remainder: " + std::to_string(remainder) + ", trip_count: " + std::to_string(trip_countn));
            option.enable_partially(unroll_factor);

            if (remainder != 0) {
                {
                    // Check if loop's exit condition is eq or ne
                    if (auto eb = loop->getExitingBlocks(); eb.size() == 1) {
                        if (auto cd = eb.begin()->get()->getBRInst()->getCond()->as<Instruction>(); cd->getOpcode() == OP::ICMP) {
                            if (auto icmpop = cd->as<ICMPInst>()->getCond(); icmpop == ICMPOP::eq || icmpop == ICMPOP::ne) {
                                Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's exit condition is '==' or '!=' while it has remainder.");
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
                    /// TODO: Why need both boundray+-1 and >= to >(or <= to <)?
                    pVal iter_variable, raw_boundary_value;
                    if (loop->getExitingBlocks().size() == 1) {
                        auto exiting_br_cond = (*loop->getExitingBlocks().begin())->getBRInst()->getCond();
                        if (exiting_br_cond->is<ICMPInst>()) {
                            auto icmp = exiting_br_cond->as<ICMPInst>();
                            bool lhs_is_var = !loop->isLoopInvariant(icmp->getLHS());
                            bool rhs_is_var = !loop->isLoopInvariant(icmp->getRHS());
                            if (lhs_is_var && rhs_is_var) {
                                Err::not_implemented("Both handles are variable.");
                            } else if (lhs_is_var) {
                                iter_variable = icmp->getLHS();
                                raw_boundary_value = icmp->getRHS();
                            } else if (rhs_is_var) {
                                iter_variable = icmp->getRHS();
                                raw_boundary_value = icmp->getLHS();
                            } else {
                                Err::unreachable();
                            }
                        } else {
                            Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's exit condition is not ICMPInst.");
                            option.disable();
                            return;
                        }
                    } else {
                        Err::not_implemented();
                        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop has multiple exits.");
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

                    auto trecp = SCEVH.getSCEVAtBlock(iter_variable, iter_variable->as<Instruction>()->getParent());
                    if (!trecp) {
                        Logger::logInfo("[LoopUnroll] Unroll disabled because can't get the loop's iter_variable's TREC.");
                        option.disable();
                        return;
                    }
                    if (!trecp->isAddRec()) {
                        Logger::logInfo("[LoopUnroll] Unroll disabled because the loop's iter_variable's TREC is not AddRec.");
                        option.disable();
                        return;
                    }

                    auto [base, step] = trecp->getConstantAffineAddRec().value();
                    int new_boundary_num;
                    if (loop->isExiting(loop->getLatch())) {
                        new_boundary_num = base + step * unroll_factor * (trip_countn / unroll_factor - 1) + (step>0?-1:1);
                    } else {
                        new_boundary_num = base + step * unroll_factor * (trip_countn / unroll_factor) + (step>0?-1:1);
                    }
                    Logger::logDebug("[LoopUnroll] Get base: "+ std::to_string(base) + ", step: "+ std::to_string(step) + ", new_boundary_num: "+ std::to_string(new_boundary_num));
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
            // TODO
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

bool LoopUnrollPass::unroll(const pLoop &loop, const UnrollOption &option, Function &func) {
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

    if (!loop->getPreHeader()) {
        return false;
    }

    if (!loop->getLatch()) {
        return false;
    }

    // !hasAddressTaken()

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
            BMap[bb][i] = std::make_shared<BasicBlock>(bb->getName() + ".unroll" + std::to_string(i));
        }
        BMap[bb][count] = std::make_shared<BasicBlock>(bb->getName() + ".remainder");
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
                new_inst->setName(inst->getName() + ".remainder");
            } else {
                new_inst->setName(inst->getName() + ".unroll" + std::to_string(i));
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

    // process exiting block, update exit block's phi
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
                std::make_shared<PHIInst>(phi->getName() + ".unroll" + std::to_string(i), phi->getType());
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
                new_phi->setName(phi->getName() + ".unroll" + std::to_string(i));
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

    bool is_dowhile = loop->isExiting(loop->getLatch());
    const auto last_latch = BMap[latch][count - 1];

    // just for one exit:
    const auto raw_loop_exiting = is_dowhile ? latch : header;
    const auto unrolled_loop_exiting = is_dowhile ? last_latch : header;
    Err::gassert(loop->getExitBlocks().size() == 1, "LoopUnroll: Multiple Exit.");
    const auto exitb = *(loop->getExitBlocks().begin());

    // clone remainder to BMap[b][count]
    // 此处只处理常量部分展开的余数循环
    if (option.partially() && option.has_remainder) {
        auto rem = option.remainder;

        // process header
        {
            const auto &rh = header;     // raw header
            const auto ch = BMap[rh][count]; // current header

            // clone inst and create phi
            for (auto &phi : rh->phis()) {
                const auto new_phi = std::make_shared<PHIInst>(phi->getName() + ".remainder", phi->getType());
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
                new_phi->setName(phi->getName() + ".remainder");
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

        // add rem header's phi's phioper: from latch, from raw header or last latch(if is dowhile)
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

            // 1. For dowhile: from last loop
            // 2. For while: from frist loop's phi
            if (is_dowhile) {
                if (phi_value_from_latch->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                    rem_phi->addPhiOper(IMapFind(phi_value_from_latch->as<Instruction>(), count-1), last_latch);
                } else {
                    rem_phi->addPhiOper(phi_value_from_latch, last_latch);
                }
            } else {
                rem_phi->addPhiOper(phi, header);
            }
        }

        // Change loop's iterative boundary
        auto br = unrolled_loop_exiting->getBRInst();
        if (br->isConditional()) {
            auto cond = br->getCond()->as<Instruction>();
            if (cond->getOpcode() == OP::ICMP) {
                auto icmp = cond->as<ICMPInst>();
                if (option.raw_boundary_value != option.new_boundary_value)
                    icmp->replaceAllOperands(option.raw_boundary_value, option.new_boundary_value);
                // 此处给展开循环的判断条件改为非等，防止多执行
                switch (icmp->getCond()) {
                    case ICMPOP::sgt:
                    case ICMPOP::sge:
                        icmp->cond = ICMPOP::sgt;
                        break;
                    case ICMPOP::slt:
                    case ICMPOP::sle:
                        icmp->cond = ICMPOP::slt;
                        break;
                    default:
                        Err::unreachable();
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
        if (br->isConditional()) {
            if (br->getTrueDest() == exitb) {
                br->dropTrueDest();
            } else if (br->getFalseDest() == exitb) {
                br->dropFalseDest();
            } else {
                /// TODO: Somewhere I dropped, Somewhere not, it may needs to be fixed.
                // Err::unreachable();
            }
        } else {
            //// TODO: Somewhere I dropped, Somewhere not, it may needs to be fixed.
            // Err::unreachable();
        }
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
    } else if (option.partially()) {
        last_latch->getBRInst()->replaceAllOperands(BMap[header][count-1], header);
        if (option.has_remainder && is_dowhile) {
            last_latch->getBRInst()->replaceAllOperands(exitb, BMap[header][count]);
            ProcessExitingBlock(latch, BMap[latch][count], count);
            DropExitbAndItsPhiOper(latch);
        } else if (option.has_remainder && !is_dowhile) {
            header->getBRInst()->replaceAllOperands(exitb, BMap[header][count]);
            ProcessExitingBlock(header, BMap[header][count], count);
            DropExitbAndItsPhiOper(header);
        } else if (!option.has_remainder && is_dowhile) {
            ProcessExitingBlock(latch, last_latch, count-1);
            DropExitbAndItsPhiOper(latch);
        }
    } else {
        Err::not_implemented();
    }

    // process raw header's phi node:
    // For partially: [%x, latch] --> [%xx, last_latch]
    // For fully: delete [%x, latch]
    for (const auto &phi : header->phis()) {
        if (option.partially()) {
            auto phi_value_from_loop = phi->getValueForBlock(latch);
            IMapFindAndReplaceOperand(phi, phi_value_from_loop, count - 1);
            phi->replaceAllOperands(latch, last_latch);
        } else if (option.fully()) {
            phi->delPhiOperByBlock(latch);
        } else {
            Err::not_implemented();
        }
    }

    // add to function
    auto it_after_loop = ++std::find(func.begin(), func.end(), blocks.back()->as<BasicBlock>());
    for (int i = 1; i < count; i++) {
        for (auto &b : blocks) {
            func.addBlock(it_after_loop, BMap[b][i]);
        }
    }
    if (option.fully() && !is_dowhile) {
        func.addBlock(it_after_loop, BMap[header][count]);
    } else if (option.partially() && option.has_remainder) {
        for (auto &b : blocks) {
            func.addBlock(it_after_loop, BMap[b][count]);
        }
    }

    // process runtime unroll

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
    Logger::logInfo("[LoopUnroll] All loop size: "+std::to_string(all_loop_size));
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
            LoopInfo NLI;
            if (last_round_modified) {
                NLI = fam.getFreshResult<LoopAnalysis>(function);
            } else {
                NLI = fam.getResult<LoopAnalysis>(function);
            }
            auto loop = NLI.getLoopFor(rawloop->getHeader());
            auto &DT = fam.getResult<DomTreeAnalysis>(function);
            UnrollOption option;
            analyze(loop, option, NLI, function, DT);
            auto peeled = peel(loop, option, function);
            auto unrolled = unroll(loop, option, function);
            last_round_modified = peeled || unrolled;
            modified = modified || last_round_modified;
        }
    }

    return modified ? PreserveNone() : PreserveAll();
}

} // namespace IR