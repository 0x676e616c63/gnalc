#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <vector>

namespace IR {
PM::UniqueKey LoopAnalysis::Key;

void Loop::setParent(const std::shared_ptr<Loop> &p) {
    parent = p;
}

Loop::Loop(BasicBlock *bb) {
    blocks.emplace_back(bb);
    blockset.emplace(bb);
}

std::shared_ptr<Loop> Loop::getParent() const {
    return parent.lock();
}

bool Loop::contains(const BasicBlock *bb) const {
    return blockset.find(bb) != blockset.end();
}

BasicBlock *Loop::getHeader() const {
    return blocks[0];
}

BasicBlock *Loop::getPreHeader() const {
    auto header = getHeader();
    auto pres = header->getPreBB();
    if (pres.size() != 1)
        return nullptr;
    if (pres.front()->getNextBB().size() != 1)
        return nullptr;
    return pres.front().get();
}
bool Loop::isLatch(const BasicBlock *bb) const {
    Err::gassert(contains(bb));
    auto header = getHeader();
    auto succs = bb->getNextBB();
    return std::any_of(succs.cbegin(), succs.cend(), [&header](const auto& succ) {
        return succ.get() == header;
    });
}

bool Loop::isExit(const BasicBlock *bb) const {
    auto succs = bb->getNextBB();
    return std::any_of(succs.cbegin(), succs.cend(), [this](const auto& succ) {
        return !contains(succ.get());
    });
}

std::vector<BasicBlock *> Loop::getExitBlocks() const {
    std::vector<BasicBlock*> ret;
    std::copy_if(blocks.cbegin(), blocks.cend(), std::back_inserter(ret),
        [this](const auto& bb) { return isExit(bb); });
    return ret;
}

std::vector<BasicBlock *> Loop::getLatches() const {
    std::vector<BasicBlock*> ret;
    std::copy_if(blocks.cbegin(), blocks.cend(), std::back_inserter(ret),
        [this](const auto& bb) { return isLatch(bb); });
    return ret;
}

bool Loop::isOutermost() const {
    Err::gassert(!parent.expired());
    return parent.lock() == nullptr;
}
bool Loop::isInnermost() const {
    return sub_loops.empty();
}

std::shared_ptr<Loop> Loop::getOutermostLoop() {
    auto ret = shared_from_this();
    while (ret->getParent() != nullptr)
        ret = ret->getParent();
    return ret;
}

size_t Loop::getLoopDepth() const {
    size_t ret = 0;

    auto curr = shared_from_this();
    while (curr->getParent() != nullptr) {
        curr = curr->getParent();
        ++ret;
    }

    return ret;
}

std::shared_ptr<Loop> LoopInfo::getLoopFor(const BasicBlock *bb) const {
    auto it = loop_map.find(bb);
    if (it != loop_map.end())
        return it->second;
    return nullptr;
}

bool LoopInfo::isLoopHeader(const BasicBlock *bb) const {
    auto loop = getLoopFor(bb);
    return loop && loop->getHeader() == bb;
}

const std::vector<std::shared_ptr<Loop>> &LoopInfo::getTopLevelLoops() const {
    return top_level_loops;
}

LoopInfo LoopAnalysis::run(Function &function, FAM &fam) {
    LoopInfo info;
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    auto dom_pdfv = domtree.getDFVisitor<Util::DFVOrder::PostOrder>();

    for (const auto& node : dom_pdfv) {
        std::vector<BasicBlock*> backedges;
        auto preds = node->bb->getPreBB();
        for (const auto& pred : preds) {
            if (domtree.ADomB(node->bb, pred.get()))
                backedges.emplace_back(pred.get());
        }

        if (!backedges.empty()) {
            auto newloop = std::make_shared<Loop>(node->bb);
            auto worklist = backedges;
            while (!worklist.empty()) {
                auto pred = worklist.back();
                worklist.pop_back();

                if (auto subloop = info.getLoopFor(pred)) {
                    // We've discovered it before. Get the outermost loop.
                    subloop = subloop->getOutermostLoop();
                    if (subloop == newloop)
                        continue;

                    subloop->setParent(newloop);
                    auto subheader_preds = subloop->getHeader()->getPreBB();
                    for (const auto& p : subheader_preds) {
                        if (info.getLoopFor(p.get()) != subloop)
                            worklist.emplace_back(p.get());
                    }
                }
                // Undiscovered block
                else {
                    info.loop_map[pred] = newloop;

                    // We've reached the header
                    if (pred == node->bb)
                        continue;

                    auto inner_preds = pred->getPreBB();
                    for (const auto& p : inner_preds)
                        worklist.emplace_back(p.get());
                }
            }
        }
    }

    // Populate all loop data
    auto cfg_pdfv = function.getDFVisitor<Util::DFVOrder::PostOrder>();
    for (const auto& bb : cfg_pdfv) {
        auto subloop = info.getLoopFor(bb.get());
        if (subloop && subloop->getHeader() == bb.get()) {
            if (subloop->isOutermost())
                info.top_level_loops.emplace_back(subloop);
            else
                subloop->getParent()->sub_loops.emplace_back(subloop.get());

            subloop = subloop->getParent();
        }
        while (subloop != nullptr) {
            subloop->blocks.emplace_back(bb.get());
            subloop->blockset.emplace(bb.get());
            subloop = subloop->getParent();
        }
    }

    return info;
}
} // namespace IR