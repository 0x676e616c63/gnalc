// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/mir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/mir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <vector>

namespace MIR {
PM::UniqueKey MachineLoopAnalysis::Key;

void MLoop::setParent(const MLoop_p &p) { parent = p; }

MLoop::MLoop(MIRBlk *bb) {
    loop_blocks.emplace_back(bb);
    blockset.emplace(bb);
}

MLoop_p MLoop::getParent() const { return parent.lock(); }
MIRFunction_p MLoop::getParentFunction() const { return getHeader()->getFunction(); }
const std::set<const MIRBlk *> &MLoop::getBlockSet() const { return blockset; }

bool MLoop::contains(const MIRBlk *bb) const { return blockset.find(bb) != blockset.end(); }
bool MLoop::contains(const MLoop *loop) const {
    if (loop == this)
        return true;
    if (loop == nullptr)
        return false;
    return contains(loop->getParent().get());
}

MIRBlk *MLoop::getRawHeader() const { return loop_blocks.front(); }

MIRBlk *MLoop::getRawPreHeader() const {
    auto header = getRawHeader();
    MIRBlk *single_entering_block = nullptr;
    for (const auto &pred : header->preds()) {
        if (contains(pred.get()))
            continue;
        if (single_entering_block)
            return nullptr;
        single_entering_block = pred.get();
    }

    if (!single_entering_block || single_entering_block->succs().size() != 1)
        return nullptr;

    return single_entering_block;
}
bool MLoop::isLatch(const MIRBlk *bb) const {
    Err::gassert(contains(bb));
    auto header = getRawHeader();
    return std::any_of(bb->succs().begin(), bb->succs().end(), [&header](const auto &succ) { return succ.get() == header; });
}

bool MLoop::isExiting(const MIRBlk *bb) const {
    if (!contains(bb))
        return false;
    return std::any_of(bb->succs().begin(), bb->succs().end(), [this](const auto &succ) { return !contains(succ.get()); });
}

bool MLoop::isExit(const MIRBlk *bb) const {
    if (contains(bb))
        return false;
    return std::any_of(bb->preds().begin(), bb->preds().end(), [this](const auto &pred) { return contains(pred.get()); });
}

std::set<MIRBlk *> MLoop::getRawExitingBlocks() const {
    std::set<MIRBlk *> ret;
    for (const auto &bb : loop_blocks) {
        if (isExiting(bb))
            ret.emplace(bb);
    }
    return ret;
}

std::set<MIRBlk *> MLoop::getRawExitBlocks() const {
    std::set<MIRBlk *> ret;
    for (const auto &bb : loop_blocks) {
        for (const auto &candidate : bb->succs()) {
            if (!contains(candidate.get()))
                ret.emplace(candidate.get());
        }
    }
    return ret;
}

std::vector<MIRBlk *> MLoop::getRawLatches() const {
    std::vector<MIRBlk *> ret;
    std::copy_if(loop_blocks.crbegin(), loop_blocks.crend(), std::back_inserter(ret),
                 [this](const auto &bb) { return isLatch(bb); });
    return ret;
}
MIRBlk *MLoop::getRawLatch() const {
    auto latches = getRawLatches();
    if (latches.size() != 1)
        return nullptr;
    return latches[0];
}

bool MLoop::isOutermost() const { return parent.lock() == nullptr; }
bool MLoop::isInnermost() const { return sub_loops.empty(); }

MLoop_p MLoop::getOutermostLoop() {
    auto ret = shared_from_this();
    while (ret->getParent() != nullptr)
        ret = ret->getParent();
    return ret;
}

const std::vector<MLoop_p> &MLoop::getSubLoops() const { return sub_loops; }

const std::list<MIRBlk *> &MLoop::getRawBlocks() const { return loop_blocks; }

std::vector<MIRBlk_p> MLoop::getBlocks() const {
    std::vector<MIRBlk_p> ret;
    ret.reserve(blockset.size());
    for (auto r : loop_blocks)
        ret.emplace_back(r->as<MIRBlk>());
    return ret;
}

bool MLoop::hasDedicatedExits() const {
    auto exits = getExitBlocks();
    return std::all_of(exits.cbegin(), exits.cend(), [this](const auto &exit) {
        return std::all_of(exit->preds().begin(), exit->preds().end(),
                           [this](const auto &pred) { return contains(pred.get()); });
    });
}

bool MLoop::isSimplifyForm() const {
    // auto ph = getPreHeader();
    // auto latch = getLatch();
    // auto dedi = hasDedicatedExits();
    return getRawPreHeader() && getRawLatch() && hasDedicatedExits();
}

bool MLoop::isRotatedForm() const {
    auto latch = getLatch();
    return latch && isExiting(latch);
}

bool MLoop::contains(const MIRBlk_p &bb) const { return contains(bb.get()); }
bool MLoop::contains(const MLoop_p &loop) const { return contains(loop.get()); }
MIRBlk_p MLoop::getHeader() const {
    auto rh = getRawHeader();
    if (!rh)
        return nullptr;
    return rh->as<MIRBlk>();
}
MIRBlk_p MLoop::getPreHeader() const {
    auto rph = getRawPreHeader();
    if (!rph)
        return nullptr;
    return rph->as<MIRBlk>();
}
bool MLoop::isLatch(const MIRBlk_p &bb) const { return isLatch(bb.get()); }
bool MLoop::isExiting(const MIRBlk_p &bb) const { return isExiting(bb.get()); }
bool MLoop::isExit(const MIRBlk_p &bb) const { return isExit(bb.get()); }
std::set<MIRBlk_p> MLoop::getExitingBlocks() const {
    auto res = getRawExitingBlocks();
    std::set<MIRBlk_p> ret;
    for (const auto &r : res)
        ret.emplace(r->as<MIRBlk>());
    return ret;
}
std::set<MIRBlk_p> MLoop::getExitBlocks() const {
    auto res = getRawExitBlocks();
    std::set<MIRBlk_p> ret;
    for (const auto &r : res)
        ret.emplace(r->as<MIRBlk>());
    return ret;
}
std::vector<MIRBlk_p> MLoop::getLatches() const {
    auto res = getRawLatches();
    std::vector<MIRBlk_p> ret;
    ret.reserve(res.size());
    for (const auto &r : res)
        ret.emplace_back(r->as<MIRBlk>());
    return ret;
}
MIRBlk_p MLoop::getLatch() const {
    auto rl = getRawLatch();
    if (!rl)
        return nullptr;
    return rl->as<MIRBlk>();
}

MLoopInfo::iterator MLoopInfo::begin() {
    return top_level_loops.begin();
}
MLoopInfo::iterator MLoopInfo::end() {
    return top_level_loops.end();
}

MLoop_p MLoopInfo::getLoopFor(const MIRBlk *bb) const {
    auto it = loop_map.find(bb);
    if (it != loop_map.end())
        return it->second;
    return nullptr;
}

MLoop_p MLoopInfo::getLoopFor(const MIRBlk_p &bb) const { return getLoopFor(bb.get()); }

bool MLoopInfo::isLoopHeader(const MIRBlk_p &bb) const { return isLoopHeader(bb.get()); }

bool MLoopInfo::isLoopHeader(const MIRBlk *bb) const {
    auto loop = getLoopFor(bb);
    return loop && loop->getRawHeader() == bb;
}

const std::vector<MLoop_p> &MLoopInfo::topLevels() const { return top_level_loops; }

MLoopInfo MachineLoopAnalysis::run(MIRFunction &function, FAM &fam) {
    MLoopInfo info;
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    auto dom_pdfv = domtree.getDFVisitor<Util::DFVOrder::PostOrder>();

    for (const auto &node : dom_pdfv) {
        std::vector<MIRBlk *> backedges;
        for (const auto &pred : node->block()->preds()) {
            if (domtree.ADomB(node->block(), pred.get()))
                backedges.emplace_back(pred.get());
        }

        if (!backedges.empty()) {
            auto newloop = std::make_shared<MLoop>(node->raw_block());
            auto worklist = backedges;
            while (!worklist.empty()) {
                auto pred = worklist.back();
                worklist.pop_back();

                if (auto subloop = info.getLoopFor(pred)) {
                    // We've discovered it before. Get the outermost loop.
                    auto sub_outer = subloop->getOutermostLoop();
                    if (sub_outer != newloop) {
                        sub_outer->setParent(newloop);
                        for (const auto &p : sub_outer->getHeader()->preds()) {
                            if (info.getLoopFor(p.get()) != sub_outer)
                                worklist.emplace_back(p.get());
                        }
                    }
                }
                // Undiscovered block
                else {
                    info.loop_map[pred] = newloop;

                    // See if we've reached the header
                    if (pred != node->raw_block()) {
                        for (const auto &p : pred->preds())
                            worklist.emplace_back(p.get());
                    }
                }
            }
        }
    }

    // Populate all loop data
    auto cfg_pdfv = function.getDFVisitor<Util::DFVOrder::PostOrder>();
    for (const auto &bb : cfg_pdfv) {
        auto subloop = info.getLoopFor(bb);
        if (subloop && subloop->getHeader() == bb) {
            if (subloop->isOutermost())
                info.top_level_loops.emplace_back(subloop);
            else
                subloop->getParent()->sub_loops.emplace_back(subloop);

            subloop = subloop->getParent();
        }
        while (subloop != nullptr) {
            subloop->loop_blocks.emplace_back(bb.get());
            subloop->blockset.emplace(bb.get());
            subloop = subloop->getParent();
        }
    }

    return info;
}
} // namespace IR