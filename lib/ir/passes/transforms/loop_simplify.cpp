#include "../../../../include/ir/passes/transforms/loop_simplify.hpp"

#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses LoopSimplifyPass::run(Function &function, FAM &fam) {
    bool loop_simplify_cfg_modified = false;

    auto loop_info = fam.getResult<LoopAnalysis>(function);
    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();

        for (const auto &loop : looppdfv) {
            auto header = loop->getHeader()->shared_from_this();
            bool curr_loop_changed = false;
            // Ensure a preheader
            auto preheader = loop->getPreHeader();
            if (!preheader) {
                auto new_preheader = std::make_shared<BasicBlock>("%ls.ph" + std::to_string(name_cnt++));
                auto preds = header->getPreBB();
                for (const auto &pred : preds) {
                    if (!loop->contains(pred.get())) {
                        auto br = pred->getBRInst();
                        Err::gassert(br != nullptr);
                        br->replaceOperand(header, new_preheader);
                        unlinkBB(pred, header);
                        linkBB(pred, new_preheader);
                    }
                }
                new_preheader->addInst(std::make_shared<BRInst>(header));
                linkBB(new_preheader, header);

                for (const auto &phi : header->getPhiInsts()) {
                    auto phi_operands = phi->getPhiOpers();
                    auto new_phi = std::make_shared<PHIInst>("%ls.phi" + std::to_string(name_cnt++), phi->getType());
                    for (const auto &[val, bb] : phi_operands) {
                        if (loop->contains(bb.get()))
                            continue;
                        phi->delPhiOperByBlock(bb);
                        new_phi->addPhiOper(val, bb);
                    }
                    phi->addPhiOper(new_phi, new_preheader);
                    new_preheader->addPhiInst(new_phi);
                }
                foldPHI(new_preheader);
                function.addBlock(header->getIter(), new_preheader);
                if (!loop->isOutermost())
                    loop->getParent()->addBlock(new_preheader.get());
                preheader = new_preheader.get();
                curr_loop_changed = true;
            }

            // Ensure a single backedge (which implies that there is a single latch)
            auto latch = loop->getLatch();
            if (!latch) {
                auto new_latch = std::make_shared<BasicBlock>("%ls.latch" + std::to_string(name_cnt++));
                new_latch->addInst(std::make_shared<BRInst>(header));
                linkBB(new_latch, header);
                auto latches = loop->getLatches();
                Err::gassert(!latches.empty());
                for (const auto &raw_old_latch : latches) {
                    auto old_latch = raw_old_latch->shared_from_this();
                    auto br = old_latch->getBRInst();
                    Err::gassert(br != nullptr);
                    br->replaceOperand(header, new_latch);
                    unlinkBB(old_latch, header);
                    linkBB(old_latch, new_latch);
                }
                for (const auto &phi : header->getPhiInsts()) {
                    auto phi_operands = phi->getPhiOpers();
                    auto new_phi = std::make_shared<PHIInst>("%ls.phi" + std::to_string(name_cnt++), phi->getType());
                    for (const auto &[val, bb] : phi_operands) {
                        if (bb.get() == preheader)
                            continue;
                        phi->delPhiOperByBlock(bb);
                        new_phi->addPhiOper(val, bb);
                    }
                    new_latch->addPhiInst(new_phi);
                    phi->addPhiOper(new_phi, new_latch);
                }
                foldPHI(new_latch);
                function.addBlock(std::next(latches.back()->getIter()), new_latch);
                loop->addBlock(new_latch.get());
                latch = new_latch.get();
                curr_loop_changed = true;
            }

            // Ensure dedicated exits.
            // That is, no exit block for the loop has a predecessor
            // that is outside the loop. This implies that all exit blocks
            // are dominated by the loop header.
            auto exits = loop->getExitBlocks();
            for (const auto &raw_exit : exits) {
                auto exit = raw_exit->shared_from_this();
                std::vector<std::shared_ptr<BasicBlock>> in_loop_preds;
                bool is_dedicated = true;
                auto exit_preds = exit->getPreBB();
                for (const auto &ep : exit_preds) {
                    if (loop->contains(ep.get()))
                        in_loop_preds.emplace_back(ep);
                    else
                        is_dedicated = false;
                }

                Err::gassert(!in_loop_preds.empty(), "Exit block doesn't have predecessors in loop.");

                if (!is_dedicated) {
                    auto new_exit = std::make_shared<BasicBlock>("%ls.exit" + std::to_string(name_cnt++));
                    new_exit->addInst(std::make_shared<BRInst>(exit));
                    linkBB(new_exit, exit);
                    for (const auto &in_loop_pred : in_loop_preds) {
                        auto br = in_loop_pred->getBRInst();
                        br->replaceOperand(exit, new_exit);
                        unlinkBB(in_loop_pred, exit);
                        linkBB(in_loop_pred, new_exit);
                    }
                    for (const auto &phi : exit->getPhiInsts()) {
                        auto phi_operands = phi->getPhiOpers();
                        auto new_phi =
                            std::make_shared<PHIInst>("%ls.phi" + std::to_string(name_cnt++), phi->getType());
                        for (const auto &[val, bb] : phi_operands) {
                            if (!loop->contains(bb.get()))
                                continue;
                            phi->delPhiOperByBlock(bb);
                            new_phi->addPhiOper(val, bb);
                        }
                        phi->addPhiOper(new_phi, new_exit);
                        new_exit->addPhiInst(new_phi);
                    }
                    foldPHI(new_exit);
                    function.addBlock(std::next(exit->getIter()), new_exit);

                    auto exit_loop = loop_info.getLoopFor(exit.get());
                    if (exit_loop)
                        exit_loop->addBlock(new_exit.get());
                    curr_loop_changed = true;
                }
            }

            loop_simplify_cfg_modified |= curr_loop_changed;
        }
    }

    name_cnt = 0;

    if (loop_simplify_cfg_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<LoopAnalysis>();
        return pa;
    }

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    pa.preserve<LoopAnalysis>();
    return pa;
}

} // namespace IR