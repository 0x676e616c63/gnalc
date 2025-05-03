#include "ir/passes/transforms/loop_simplify.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

namespace IR {
PM::PreservedAnalyses LoopSimplifyPass::run(Function &function, FAM &fam) {
    bool loop_simplify_cfg_modified = false;

    auto &loop_info = fam.getResult<LoopAnalysis>(function);
    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();

        for (const auto &loop : looppdfv) {
            auto header = loop->getHeader();
            bool curr_loop_changed = false;
            // Ensure a preheader
            auto preheader = loop->getPreHeader();
            if (!preheader) {
                auto new_preheader = std::make_shared<BasicBlock>("%ls.ph" + std::to_string(name_cnt++));
                auto header_preds = header->getPreBB();
                bool ph_linked = false;
                for (const auto &pred : header_preds) {
                    if (!loop->contains(pred)) {
                        auto br = pred->getBRInst();
                        Err::gassert(br != nullptr);
                        br->replaceAllOperands(header, new_preheader);
                        unlinkBB(pred, header);
                        linkBB(pred, new_preheader);
                        ph_linked = true;
                    }
                }
                Err::gassert(ph_linked, "Invalid Loop Header.");
                new_preheader->addInst(std::make_shared<BRInst>(header));
                linkBB(new_preheader, header);

                for (const auto &phi : header->phis()) {
                    auto phi_opers = phi->getPhiOpers();
                    auto new_phi = std::make_shared<PHIInst>("%ls.phi" + std::to_string(name_cnt++), phi->getType());
                    for (const auto &[val, bb] : phi_opers) {
                        if (loop->contains(bb))
                            continue;
                        phi->delPhiOperByBlock(bb);
                        new_phi->addPhiOper(val, bb);
                    }
                    phi->addPhiOper(new_phi, new_preheader);
                    new_preheader->addPhiInst(new_phi);
                }
                foldPHI(new_preheader);
                function.addBlock(header->getIter(), new_preheader);
                auto& new_dom = fam.getFreshResult<DomTreeAnalysis>(function);
                loop_info.discoverNonHeaderBlock(new_preheader, new_dom);
                preheader = new_preheader;
                curr_loop_changed = true;
            }

            // Ensure a single backedge (which implies that there is a single latch)
            auto latch = loop->getLatch();
            if (!latch) {
                auto new_latch = std::make_shared<BasicBlock>("%ls.latch" + std::to_string(name_cnt++));
                new_latch->addInst(std::make_shared<BRInst>(header));
                linkBB(new_latch, header);
                auto latches = loop->getLatches();
                Err::gassert(!latches.empty(), "Invalid loop with no latches.");
                for (const auto &old_latch : latches) {
                    auto br = old_latch->getBRInst();
                    Err::gassert(br != nullptr);
                    br->replaceAllOperands(header, new_latch);
                    unlinkBB(old_latch, header);
                    linkBB(old_latch, new_latch);
                }
                for (const auto &phi : header->phis()) {
                    auto phi_opers = phi->getPhiOpers();
                    auto new_phi = std::make_shared<PHIInst>("%ls.phi" + std::to_string(name_cnt++), phi->getType());
                    for (const auto &[val, bb] : phi_opers) {
                        if (bb == preheader)
                            continue;
                        phi->delPhiOperByBlock(bb);
                        new_phi->addPhiOper(val, bb);
                    }
                    new_latch->addPhiInst(new_phi);
                    phi->addPhiOper(new_phi, new_latch);
                }
                foldPHI(new_latch);
                function.addBlock(std::next(latches.back()->getIter()), new_latch);
                auto& new_dom = fam.getFreshResult<DomTreeAnalysis>(function);
                loop_info.discoverNonHeaderBlock(new_latch, new_dom);
                latch = new_latch;
                curr_loop_changed = true;
            }

            // Ensure dedicated exits.
            // That is, no exit block for the loop has a predecessor
            // that is outside the loop. This implies that all exit blocks
            // are dominated by the loop header.
            auto exits = loop->getExitBlocks();
            for (const auto &exit : exits) {
                std::vector<pBlock> in_loop_preds;
                bool is_dedicated = true;
                for (const auto &ep : exit->preds()) {
                    if (loop->contains(ep))
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
                        br->replaceAllOperands(exit, new_exit);
                        unlinkBB(in_loop_pred, exit);
                        linkBB(in_loop_pred, new_exit);
                    }
                    for (const auto &phi : exit->phis()) {
                        auto phi_opers = phi->getPhiOpers();
                        auto new_phi =
                            std::make_shared<PHIInst>("%ls.phi" + std::to_string(name_cnt++), phi->getType());
                        for (const auto &[val, bb] : phi_opers) {
                            if (!loop->contains(bb))
                                continue;
                            phi->delPhiOperByBlock(bb);
                            new_phi->addPhiOper(val, bb);
                        }
                        phi->addPhiOper(new_phi, new_exit);
                        new_exit->addPhiInst(new_phi);
                    }
                    foldPHI(new_exit);
                    function.addBlock(std::next(exit->getIter()), new_exit);
                    auto& new_dom = fam.getFreshResult<DomTreeAnalysis>(function);
                    loop_info.discoverNonHeaderBlock(new_exit, new_dom);
                    curr_loop_changed = true;
                }
            }
            Err::gassert(loop->isSimplifyForm(), "Failed to simplify a loop.");
            loop_simplify_cfg_modified |= curr_loop_changed;
        }
    }

    name_cnt = 0;

    if (loop_simplify_cfg_modified) {
        PM::PreservedAnalyses pa;
        // We get a fresh domtree after each modification of CFG,
        // so the domtree is still valid.
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<LoopAnalysis>();
        return pa;
    }

    return PreserveAll();
}

} // namespace IR