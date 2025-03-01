#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <vector>

namespace IR {
PM::UniqueKey LoopAnalysis::Key;

void Loop::setParent(const std::shared_ptr<Loop> &p) { parent = p; }

Loop::const_iterator Loop::begin() const { return sub_loops.begin(); }
Loop::const_iterator Loop::end() const { return sub_loops.end(); }
Loop::iterator Loop::begin() { return sub_loops.begin(); }
Loop::iterator Loop::end() { return sub_loops.end(); }
Loop::const_iterator Loop::cbegin() const { return sub_loops.cbegin(); }
Loop::const_iterator Loop::cend() const { return sub_loops.cend(); }
Loop::const_reverse_iterator Loop::rbegin() const { return sub_loops.rbegin(); }
Loop::const_reverse_iterator Loop::rend() const { return sub_loops.rend(); }
Loop::reverse_iterator Loop::rbegin() { return sub_loops.rbegin(); }
Loop::reverse_iterator Loop::rend() { return sub_loops.rend(); }
Loop::const_reverse_iterator Loop::crbegin() const { return sub_loops.crbegin(); }
Loop::const_reverse_iterator Loop::crend() const { return sub_loops.crend(); }

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

std::vector<BasicBlock *> Loop::getExitBlocks() const {
    std::vector<BasicBlock*> ret;
    for (const auto& bb : blocks) {
        auto succs = bb->getNextBB();
        for (const auto& candidate : succs) {
            if (!contains(candidate.get()))
                ret.emplace_back(candidate.get());
        }
    }
    return ret;
}

std::vector<BasicBlock *> Loop::getLatches() const {
    std::vector<BasicBlock *> ret;
    std::copy_if(blocks.crbegin(), blocks.crend(), std::back_inserter(ret),
                 [this](const auto &bb) { return isLatch(bb); });
    return ret;
}
BasicBlock *Loop::getLatch() const {
    auto latches = getLatches();
    if (latches.size() != 1)
        return nullptr;
    return latches[0];
}

bool Loop::isOutermost() const {
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

const std::vector<std::shared_ptr<Loop>> &Loop::getSubLoops() const { return sub_loops; }

const std::vector<BasicBlock *> &Loop::getBlocks() const { return blocks; }

size_t Loop::getLoopDepth() const {
    size_t ret = 0;

    auto curr = shared_from_this();
    while (curr->getParent() != nullptr) {
        curr = curr->getParent();
        ++ret;
    }

    return ret;
}
bool Loop::delBlock(const BasicBlock *bb) {
    auto it = std::find(blocks.begin(), blocks.end(), bb);
    if (it == blocks.end())
        return false;
    blocks.erase(it);
    blockset.erase(bb);
    return true;
}

void Loop::addBlock(BasicBlock *bb) {
    blocks.emplace_back(bb);
    blockset.insert(bb);
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

LoopInfo::const_iterator LoopInfo::begin() const { return top_level_loops.begin(); }
LoopInfo::const_iterator LoopInfo::end() const { return top_level_loops.end(); }
LoopInfo::iterator LoopInfo::begin() { return top_level_loops.begin(); }
LoopInfo::iterator LoopInfo::end() { return top_level_loops.end(); }
LoopInfo::const_iterator LoopInfo::cbegin() const { return top_level_loops.cbegin(); }
LoopInfo::const_iterator LoopInfo::cend() const { return top_level_loops.cend(); }
LoopInfo::const_reverse_iterator LoopInfo::rbegin() const { return top_level_loops.rbegin(); }
LoopInfo::const_reverse_iterator LoopInfo::rend() const { return top_level_loops.rend(); }
LoopInfo::reverse_iterator LoopInfo::rbegin() { return top_level_loops.rbegin(); }
LoopInfo::reverse_iterator LoopInfo::rend() { return top_level_loops.rend(); }
LoopInfo::const_reverse_iterator LoopInfo::crbegin() const { return top_level_loops.crbegin(); }
LoopInfo::const_reverse_iterator LoopInfo::crend() const { return top_level_loops.crend(); }

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
                    auto sub_outer  = subloop->getOutermostLoop();
                    if (sub_outer != newloop) {
                        sub_outer->setParent(newloop);
                        auto sub_preds = sub_outer->getHeader()->getPreBB();
                        for (const auto& p : sub_preds) {
                            if (info.getLoopFor(p.get()) != sub_outer)
                                worklist.emplace_back(p.get());
                        }
                    }
                }
                // Undiscovered block
                else {
                    info.loop_map[pred] = newloop;

                    // See if we've reached the header
                    if (pred != node->bb) {
                        auto inner_preds = pred->getPreBB();
                        for (const auto& p : inner_preds)
                            worklist.emplace_back(p.get());
                    }
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
                subloop->getParent()->sub_loops.emplace_back(subloop);

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