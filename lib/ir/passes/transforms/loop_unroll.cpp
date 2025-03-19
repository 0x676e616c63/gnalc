#include "../../../../include/ir/passes/transforms/loop_unroll.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/block_utils.hpp"

#include <algorithm>


namespace IR {
LoopUnrollPass::ULI LoopUnrollPass::unroll_analyze(const std::shared_ptr<Loop>& loop) {
    // TODO
    return {UM::FULLY, 4, false};
}

bool LoopUnrollPass::peel_loop(const std::shared_ptr<Loop> &loop) {
    // TODO
    return false;
}

bool LoopUnrollPass::unroll_loop(const std::shared_ptr<Loop> &loop, const int count, bool partially, bool has_remainder, Function &func) {
    if (count < 2)
        return false;

    if (!partially && has_remainder)
        Err::error("unexpected arguments");

    if (!loop->getPreHeader())
        return false;

    if (!loop->getLatch())
        return false;

    // !hasAddressTaken() ?

    auto pre_header = loop->getPreHeader()->shared_from_this();
    auto header = loop->getHeader()->shared_from_this();
    auto latch = loop->getLatch()->shared_from_this();
    auto blocks = loop->getBlocks();
    auto exits = loop->getExitBlocks();

    using pB = std::shared_ptr<BasicBlock>;
    using pI = std::shared_ptr<Instruction>;
    using BV = std::vector<pB>;
    using IV = std::vector<pI>;

    // 新旧BB, Inst映射，用于快速查找
    // <raw, new_vector>
    // new_vector[0] == raw
    std::map<pB, BV> BMap;
    std::map<pI, IV> IMap;

    auto IMapFind = [&](pI inst, const int i) {
        if (const auto it = IMap.find(inst); it != IMap.end()) {
            return it->second[i];
        }
        return inst;
    };

    auto BMapFind = [&](pB block, const int i) {
        if (const auto it = BMap.find(block); it != BMap.end()) {
            return it->second[i];
        }
        return block;
    };

    auto CloneNonPhiInst = [&](const pB& raw, const pB& cur, const int i) {
        // clone other inst
        for (const auto& inst : *raw) {
            const auto new_inst = std::dynamic_pointer_cast<Instruction>(inst->clone());
            new_inst->setName(inst->getName()+".unroll"+std::to_string(i));
            IMap[inst][i] = new_inst;
            if (inst->getOpcode() == OP::BR)
                for (auto value : inst->operands()) {
                    if (value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        new_inst->replaceAllOperands(value, IMapFind(std::dynamic_pointer_cast<Instruction>(value), i));
                    } else if (value->getVTrait() == ValueTrait::BASIC_BLOCK) {
                        new_inst->replaceAllOperands(value, BMapFind(std::dynamic_pointer_cast<BasicBlock>(value), i));
                    }
                }
            else
                for (auto value : inst->operands()) {
                    if (value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        new_inst->replaceAllOperands(value, IMapFind(std::dynamic_pointer_cast<Instruction>(value), i));
                    }
                }
            cur->addInst(new_inst);
        }
    };

    auto ProcessExitingBlock = [&](const pB& raw, const pB& cur, const int i) {
        // process exiting block
        if (loop->isExiting(raw.get())) {
            for (auto succ : raw->succs()) {
                if (exits.count(succ.get())) {
                    linkBB(cur, succ);
                    for (auto& phi : succ->phis()) {
                        auto pov = phi->getPhiOpers();
                        for (auto& phi_oper : pov) {
                            if (phi_oper.block == raw) {
                                if (phi_oper.value->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                                    phi->addPhiOper(IMapFind(std::dynamic_pointer_cast<Instruction>(phi_oper.value), i), cur);
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

    // initialize B/IMap
    for (const auto& bb : blocks) {
        BMap[bb->shared_from_this()] = BV(count, nullptr);
        BMap[bb->shared_from_this()][0] = bb->shared_from_this();
        for (int i = 1; i < count; i++) {
            BMap[bb->shared_from_this()][i] = std::make_shared<BasicBlock>(bb->getName()+".unroll"+std::to_string(i));
        }
        for (auto& inst : bb->getAllInsts()) {
            IMap[inst] = IV(count, nullptr);
            IMap[inst][0] = inst;
        }
    }

    // preHeader             preHeader
    //     |                 Header[0]<-----
    //   Header<---           Body[0]      |
    //     |      |          Latch [0]     |
    //    Body    |  ---->   Header[1]     |
    //     |      |           ......       |
    //   Latch-----        Latch[count-1]---
    //
    // latch[n]---->header[n+1]
    //
    // Simplified loop has only one preHeader, and the pred BB of the header is the preHeader and the latch of the loop.
    // When unrolled, the 'latches' except the last one point to the next header.
    // As a result, the original Header has two pred BBs: the preHeader and the last latch.
    // The other 'headers' of the cloned part have only one pred BB -- the latch of the previous part.
    //
    // LCSSA loop's 'live in variable' is used in the PHI node of the header block.
    // Since the cloned headers have only one predecessor BB, the phi of the cloned headers can be replaced with
    // the value of the latch from the previous cloned part. The operands of the PHI node in exit blocks will be
    // expanded with the value of the cloned exiting block.

    // process raw loop
    // 断开了latch[0]->header[0]的cfg边, 添加了latch[count-1]->header[0]
    unlinkBB(latch, header);
    linkBB(BMap[latch][count-1], header);

    // clone blocks, link blocks, update phi...
    for (int i = 1; i < count; i++) {
        auto raw_bb_iter = loop->block_begin();

        // process header
        {
            Err::gassert(header.get() == *raw_bb_iter, "First raw_bb_iter is not the header!");
            auto rh = (*raw_bb_iter)->shared_from_this(); // current raw header
            auto ch = BMap[rh][i]; // current header

            // latch[n-1]-->header[i]
            linkBB(BMap[latch][i-1], ch);

            // clone header's phi, replace with previous part's value
            for (auto& phi : rh->phis()) {
                auto phi_value_from_loop = phi->getValueForBlock(latch);
                // 如果原始header的phi里的value是常量的话，就无法存到IMap里面了，同时由于其user尚未创建，无法直接把常量传播
                // 故使用 phi [v, b] 形式
                const auto new_phi = std::make_shared<PHIInst>(phi->getName()+".unroll"+std::to_string(i), phi->getType());
                IMap[phi][i] = new_phi;
                if (phi_value_from_loop->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                    // Instruction情况
                    new_phi->addPhiOper(IMapFind(std::dynamic_pointer_cast<Instruction>(phi_value_from_loop), i-1), BMap[latch][i-1]);
                } else {
                    // 其他情况：常量、全局变量
                    new_phi->addPhiOper(phi_value_from_loop, BMap[latch][i-1]);
                }
                ch->addPhiInst(new_phi);
            }

            CloneNonPhiInst(rh, ch, i);
            ProcessExitingBlock(rh, ch, i);
        }

        // process other block
        ++raw_bb_iter;
        while (raw_bb_iter != loop->block_end()) {
            auto rb = (*raw_bb_iter)->shared_from_this(); // current raw block
            auto cb = BMap[rb][i]; // current block

            // link pred BB
            for (auto pred : rb->preds()) {
                linkBB(BMap[pred][i], cb);
            }

            // clone phi
            for (const auto& phi : rb->phis()) {
                auto new_phi = std::dynamic_pointer_cast<PHIInst>(phi->clone());
                new_phi->setName(phi->getName()+".unroll"+std::to_string(i));
                IMap[phi][i] = new_phi;
                for (auto it = phi->operand_begin(); it != phi->operand_end(); ++it) {
                    // val, blk, val, blk...
                    auto v = *it;
                    if (v->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        phi->replaceAllOperands(v, IMapFind(std::dynamic_pointer_cast<Instruction>(v), i));
                    }
                    v = *++it;
                    phi->replaceAllOperands(v, BMap[std::dynamic_pointer_cast<BasicBlock>(v)][i]);
                }
                cb->addPhiInst(new_phi);
            }

            CloneNonPhiInst(rb, cb, i);
            ProcessExitingBlock(rb, cb, i);

            ++raw_bb_iter;
        }
    }

    // 修改latch的br
    for (int i = 0; i < count-1; i++)
        BMap[latch][i]->getBRInst()->replaceAllOperands(BMap[header][i], BMap[header][i+1]);
    BMap[latch][count-1]->getBRInst()->replaceAllOperands(BMap[header][count-1], header);

    // process raw header's phi node
    for (const auto& phi : header->phis()) {
        auto phi_value_from_loop = phi->getValueForBlock(latch);
        phi->replaceAllOperands(phi_value_from_loop, IMapFind(std::dynamic_pointer_cast<Instruction>(phi_value_from_loop), count-1));
        phi->replaceAllOperands(latch, BMap[latch][count-1]);
    }

    // add to function
    auto it_after_loop = ++std::find(func.begin(), func.end(), blocks.back()->shared_from_this());
    for (int i = 1; i < count; i++) {
        for (auto & b : blocks) {
            func.addBlock(it_after_loop, BMap[b->shared_from_this()][i]);
        }
    }

    // process runtime unroll

    // process reminder

    // optimize new cfg

    return true;
}

PM::PreservedAnalyses LoopUnrollPass::run(Function &function, FAM &fam) {
    bool modified = false;
    const auto &LI = fam.getResult<LoopAnalysis>(function);

    if (LI.getTopLevelLoops().empty())
        return PreserveAll();

    // TODO: 改为逆后序
    for (auto &loop : LI) {
        if (!(loop->isSimplifyForm() && loop->isLCSSAForm()))
            continue;

        const auto info = unroll_analyze(loop);
        if (info.um == UM::DISABLE)
            continue;

        modified = unroll_loop(loop, info.count, info.um == UM::PARTIALLY, info.has_remainder, function);
    }

    return modified ? PreserveNone() : PreserveAll();
}

} // namespace IR