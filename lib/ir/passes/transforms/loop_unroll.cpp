#include "ir/passes/transforms/loop_unroll.hpp"
#include "ir/base.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"
#include "utils/exception.hpp"
#include <algorithm>


namespace IR {
void LoopUnrollPass::analyze(const pLoop &loop, UnrollOption &option, LoopInfo& LI, Function &FC, DomTree &DT) {
    if (!(loop->isSimplifyForm() && loop->isLCSSAForm())) {
        option.disable();
        return;
    }

    // 不展开过大循环
    unsigned inst_size = 0;
    for (const auto &bb : loop->blocks()) {
        inst_size += bb->getAllInstCount();
    }
    if (inst_size > LOOP_UNROLLING_MAX_PROCESS_SIZE) {
        option.disable();
        return;
    }

    // 限制多出口循环展开，暂时只处理单出口
    if (loop->getExitBlocks().size() != 1) {
        option.disable();
        return;
    }

    // TODO: 不处理含调用的循环

    auto SCEVH = SCEVHandle(&FC, &LI, &DT);
    const auto TC = SCEVH.getTripCount(loop);
    if (TC == nullptr) {
        option.disable();
        return;
    }

    if (TC->isIRValue() && TC->getIRValue()->is<ConstantInt>()) {
        // 常量展开策略
        const auto trip_count = TC->getIRValue()->as<ConstantInt>()->getVal();
        if (trip_count <= LOOP_UNROLLING_FULLY_UNROLL_COUNT && trip_count * inst_size <= LOOP_UNROLLING_MAX_PROCESS_SIZE) {
            option.enable_fully(trip_count);
            return;
        }
        const auto count1 = LOOP_UNROLLING_PARTIALLY_UNROLL_SIZE / inst_size;
        if (count1 <= LOOP_UNROLLING_PARTIALLY_UNROLL_COUNT) {
            option.enable_partially(count1, trip_count % count1);
            return;
        }
        option.enable_partially(LOOP_UNROLLING_PARTIALLY_UNROLL_COUNT, trip_count % LOOP_UNROLLING_PARTIALLY_UNROLL_COUNT);
        return;
    } else {
        // 变量展开策略

    }


    // TODO
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

    // todo: need?
    if (!loop->getPreHeader()) {
        return false;
    }

    if (!loop->getLatch()) {
        return false;
    }

    // !hasAddressTaken() ?

    const auto count = option.unroll_count;
    const auto pre_header = loop->getPreHeader();
    const auto header = loop->getHeader();
    const auto latch = loop->getLatch();
    const auto &blocks = loop->getBlocks();
    const auto exits = loop->getExitBlocks();

    using pB = pBlock;
    using pI = pInst;
    using BV = std::vector<pB>;
    using IV = std::vector<pI>;

    // 新旧BB, Inst映射，用于快速查找
    // <raw, new_vector>
    // new_vector[0] == raw
    std::map<pB, BV> BMap;
    std::map<pI, IV> IMap;

    // Return IMap[inst][i] or inst.
    auto IMapFind = [&](pI inst, const unsigned i) {
        if (const auto it = IMap.find(inst); it != IMap.end()) {
            return it->second[i];
        }
        return inst;
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
        for (int i = 1; i < count + 1; i++) {
            BMap[bb][i] = std::make_shared<BasicBlock>(bb->getName() + ".unroll" + std::to_string(i));
        }
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

    // process raw loop
    // 断开了latch[0]->header[0]的cfg边, 添加了latch[count-1]->header[0]
    // 之后统一 updateCFG()
    // const auto &last_latch = BMap[latch][count - 1];
    // unlinkBB(latch, header);
    // linkBB(last_latch, header);

    // clone other inst
    auto CloneNonPhiInst = [&](const pB &raw, const pB &cur, const unsigned i) {
        for (const auto &inst : *raw) {
            const auto new_inst = makeClone(inst);
            new_inst->setName(inst->getName() + ".unroll" + std::to_string(i));
            IMap[inst][i] = new_inst;
            if (inst->getOpcode() == OP::BR) {
                for (auto value : inst->operands()) {
                    if (value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        new_inst->replaceAllOperands(value, IMapFind(value->as<Instruction>(), i));
                    } else if (value->getVTrait() == ValueTrait::BASIC_BLOCK) {
                        if (auto nv = BMapFind(value->as<BasicBlock>(), i); nv != value) {
                            new_inst->replaceAllOperands(value, nv);
                        }
                    }
                }
            } else {
                for (auto value : inst->operands()) {
                    if (value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        new_inst->replaceAllOperands(value, IMapFind(value->as<Instruction>(), i));
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
                    // linkBB(cur, succ);
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

        // latch[n-1]-->header[i]
        // linkBB(BMap[latch][i - 1], ch);

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
        // ProcessExitingBlock(rh, ch, i);
    };

    // clone blocks, link blocks, update phi...
    for (int i = 1; i < count; i++) {
        auto raw_bb_iter = loop->block_begin();

        // process header
        CloneHeaderBlock(i);

        // process other block
        ++raw_bb_iter;
        while (raw_bb_iter != loop->block_end()) {
            auto rb = (*raw_bb_iter)->as<BasicBlock>(); // current raw block
            auto cb = BMap[rb][i];                      // current block

            // link pred BB
            // for (auto pred : rb->preds()) {
            //     linkBB(BMap[pred][i], cb);
            // }

            // clone phi
            for (const auto &phi : rb->phis()) {
                auto new_phi = makeClone(phi);
                new_phi->setName(phi->getName() + ".unroll" + std::to_string(i));
                IMap[phi][i] = new_phi;
                for (auto it = phi->operand_begin(); it != phi->operand_end(); ++it) {
                    // val, blk, val, blk...
                    auto v = *it;
                    if (v->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        new_phi->replaceAllOperands(v, IMapFind(v->as<Instruction>(), i));
                    }
                    v = *++it;
                    new_phi->replaceAllOperands(v, BMap[v->as<BasicBlock>()][i]);
                }
                cb->addPhiInst(new_phi);
            }

            CloneNonPhiInst(rb, cb, i);
            // ProcessExitingBlock(rb, cb, i);

            ++raw_bb_iter;
        }
    }

    bool is_dowhile = loop->isExiting(loop->getLatch());
    const auto last_latch = BMap[latch][count - 1];

    // just for one exit:
    const auto exiting = is_dowhile ? latch : header;
    Err::gassert(loop->getExitBlocks().size() == 1, "LoopUnroll: Multiple Exit.");
    const auto exitb = *(loop->getExitBlocks().begin());

    // clone remiander to BMap[b][count]
    // 此处只处理常量部分展开的余数循环，尚未修改迭代变量！
    if (option.partially() && option.has_remainder) {
        auto rem = option.remainder;
        auto raw_bb_iter = loop->block_begin();

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
        ++raw_bb_iter;
        while (raw_bb_iter != loop->block_end()) {
            auto rb = (*raw_bb_iter)->as<BasicBlock>(); // current raw block
            auto cb = BMap[rb][count];                      // current block

            // clone phi
            for (const auto &phi : rb->phis()) {
                auto new_phi = makeClone(phi);
                new_phi->setName(phi->getName() + ".remainder");
                IMap[phi][count] = new_phi;
                for (auto it = phi->operand_begin(); it != phi->operand_end(); ++it) {
                    // val, blk, val, blk...
                    auto v = *it;
                    if (v->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        new_phi->replaceAllOperands(v, IMapFind(v->as<Instruction>(), count));
                    }
                    v = *++it;
                    new_phi->replaceAllOperands(v, BMap[v->as<BasicBlock>()][count]);
                }
                cb->addPhiInst(new_phi);
            }

            CloneNonPhiInst(rb, cb, count);
            ++raw_bb_iter;
        }

        auto rem_pre_header = is_dowhile ? last_latch : header;
        unsigned rem_pre_header_count = is_dowhile ? count-1 : 0;
        // add rem header's phi's phioper: from latch, from raw header or last latch(if is dowhile)
        for (auto &phi : header->phis()) {
            auto rem_phi = IMap[phi][count]->as<PHIInst>();
            auto phi_value_from_latch = phi->getValueForBlock(latch);
            auto phi_value_from_ph = phi->getValueForBlock(pre_header); // rem loop's preheader in raw loop

            if (phi_value_from_latch->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                // Instruction情况
                rem_phi->addPhiOper(IMapFind(phi_value_from_latch->as<Instruction>(), count), BMap[latch][count]);
            } else {
                // 其他情况：常量、全局变量
                rem_phi->addPhiOper(phi_value_from_latch, BMap[latch][count]);
            }

            if (phi_value_from_ph->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                rem_phi->addPhiOper(IMapFind(phi_value_from_ph->as<Instruction>(), rem_pre_header_count), rem_pre_header);
            } else {
                rem_phi->addPhiOper(phi_value_from_ph, rem_pre_header);
            }
        }

        ProcessExitingBlock(exiting, BMap[exiting][count], count);
    }

    // clone last header to BMap[header][count]
    if (option.fully() && !is_dowhile) {
        CloneHeaderBlock(count);
    }


    // 处理展开后循环内的跳转关系：丢弃内部退出跳转，更新br-->next_header or new Exiting Block(when dowhile or has remiander)
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
    // 2. Update
    for (int i = 0; i < count-1; i++) {
        BMap[latch][i]->getBRInst()->replaceAllOperands(BMap[header][i], BMap[header][i + 1]);
    }
    if (option.fully()) {
        if (is_dowhile) {
            BMap[latch][count-1]->getBRInst()->replaceAllOperands(BMap[header][count-1], exitb);
        } else {
            BMap[latch][count-1]->getBRInst()->replaceAllOperands(BMap[header][count-1], BMap[header][count]);
            BMap[latch][count]->getBRInst()->replaceAllOperands(BMap[header][count], exitb);
        }
    } else if (option.partially()) {
        BMap[latch][count-1]->getBRInst()->replaceAllOperands(BMap[header][count-1], header);
    } else {
        Err::not_implemented();
    }


    // 针对特定展开策略进行分支优化
    // if (option.fully()) {
    //     if (is_dowhile) {

    //     }
    // } else if (option.partially()) {

    // } else if (option.runtime()) {

    // } else {
    //     Err::unreachable();
    // }

    // Fully Unroll
    // if (option.fully()) {
    //     if (is_dowhile) {
    //         last_latch->getBRInst()->dropOneDest(header);
    //     } else {
    //         CloneHeaderBlock(count);
    //         BMap[header][count]->getBRInst()->dropTrueDest();
    //     }
    // }

    // 修改latches的br: br header --> br next_header; last_latch特殊处理
    // ATTENTION: 此步之后修改了原loop的inst
    // for (int i = 0; i < count - 1; i++) {
    //     BMap[latch][i]->getBRInst()->replaceAllOperands(BMap[header][i], BMap[header][i + 1]);
    // }
    // if (option.partially()) {
    //     last_latch->getBRInst()->replaceAllOperands(BMap[header][count - 1], header);
    // } else if (option.fully() && !is_dowhile) {
    //     last_latch->getBRInst()->replaceAllOperands(BMap[header][count - 1], BMap[header][count]);
    // }

    // process raw header's phi node:
    // For partially: [%x, latch] --> [%xx, last_latch]
    // For fully: delete [%x, latch]
    for (const auto &phi : header->phis()) {
        if (option.partially()) {
            auto phi_value_from_loop = phi->getValueForBlock(latch);
            phi->replaceAllOperands(phi_value_from_loop, IMapFind(phi_value_from_loop->as<Instruction>(), count - 1));
            phi->replaceAllOperands(latch, last_latch);
        } else {
            phi->delPhiOperByBlock(latch);
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
    }

    // process runtime unroll

    // optimize new cfg
    func.updateAndCheckCFG();

    return true;
}

PM::PreservedAnalyses LoopUnrollPass::run(Function &function, FAM &fam) {
    bool modified = false;
    auto &LI = fam.getResult<LoopAnalysis>(function);

    if (LI.getTopLevelLoops().empty()) {
        return PreserveAll();
    }

    // TODO: 改为逆后序
    for (auto &loop : LI) {
        auto &DT = fam.getFreshResult<DomTreeAnalysis>(function);
        UnrollOption option;
        analyze(loop, option, LI, function, DT);
        auto peeled = peel(loop, option, function);
        auto unrolled = unroll(loop, option, function);
        modified = modified || peeled || unrolled;
    }

    return modified ? PreserveNone() : PreserveAll();
}

} // namespace IR