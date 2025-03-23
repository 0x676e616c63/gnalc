#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>
#include <vector>

namespace IR {
PM::UniqueKey LoopAnalysis::Key;

void Loop::setParent(const pLoop &p) { parent = p; }

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
Loop::block_const_iterator Loop::block_begin() const { return loop_blocks.begin(); }
Loop::block_const_iterator Loop::block_end() const { return loop_blocks.end(); }
Loop::block_iterator Loop::block_begin() { return loop_blocks.begin(); }
Loop::block_iterator Loop::block_end() { return loop_blocks.end(); }
Loop::block_const_iterator Loop::block_cbegin() const { return loop_blocks.cbegin(); }
Loop::block_const_iterator Loop::block_cend() const { return loop_blocks.cend(); }
Loop::block_const_reverse_iterator Loop::block_rbegin() const { return loop_blocks.crbegin(); }
Loop::block_const_reverse_iterator Loop::block_rend() const { return loop_blocks.rend(); }
Loop::block_reverse_iterator Loop::block_rbegin() { return loop_blocks.rbegin(); }
Loop::block_reverse_iterator Loop::block_rend() { return loop_blocks.rend(); }
Loop::block_const_reverse_iterator Loop::block_crbegin() const { return loop_blocks.crbegin(); }
Loop::block_const_reverse_iterator Loop::block_crend() const { return loop_blocks.crend(); }

Loop::Loop(BasicBlock *bb) {
    loop_blocks.emplace_back(bb);
    blockset.emplace(bb);
}

pLoop Loop::getParent() const { return parent.lock(); }

bool Loop::contains(const BasicBlock *bb) const { return blockset.find(bb) != blockset.end(); }
bool Loop::contains(const Loop *loop) const {
    if (loop == this)
        return true;
    if (loop == nullptr)
        return false;
    return contains(loop->getParent().get());
}

BasicBlock *Loop::getRawHeader() const { return loop_blocks.front(); }

BasicBlock *Loop::getRawPreHeader() const {
    auto header = getHeader();
    BasicBlock *preheader = nullptr;
    for (const auto &pred : header->preds()) {
        if (contains(pred.get()))
            continue;
        if (preheader)
            return nullptr;
        preheader = pred.get();
    }
    return preheader;
}
bool Loop::isLatch(const BasicBlock *bb) const {
    Err::gassert(contains(bb));
    auto header = getRawHeader();
    return std::any_of(bb->succ_begin(), bb->succ_end(), [&header](const auto &succ) { return succ.get() == header; });
}

bool Loop::isExiting(const BasicBlock *bb) const {
    if (!contains(bb))
        return false;
    return std::any_of(bb->succ_begin(), bb->succ_end(), [this](const auto &succ) { return !contains(succ.get()); });
}

bool Loop::isExit(const BasicBlock *bb) const {
    if (contains(bb))
        return false;
    return std::any_of(bb->pred_begin(), bb->pred_end(), [this](const auto &pred) { return contains(pred.get()); });
}

std::set<BasicBlock *> Loop::getRawExitingBlocks() const {
    std::set<BasicBlock *> ret;
    for (const auto &bb : loop_blocks) {
        if (isExiting(bb))
            ret.emplace(bb);
    }
    return ret;
}

std::set<BasicBlock *> Loop::getRawExitBlocks() const {
    std::set<BasicBlock *> ret;
    for (const auto &bb : loop_blocks) {
        for (const auto &candidate : bb->succs()) {
            if (!contains(candidate.get()))
                ret.emplace(candidate.get());
        }
    }
    return ret;
}

std::vector<BasicBlock *> Loop::getRawLatches() const {
    std::vector<BasicBlock *> ret;
    std::copy_if(loop_blocks.crbegin(), loop_blocks.crend(), std::back_inserter(ret),
                 [this](const auto &bb) { return isLatch(bb); });
    return ret;
}
BasicBlock *Loop::getRawLatch() const {
    auto latches = getRawLatches();
    if (latches.size() != 1)
        return nullptr;
    return latches[0];
}

bool Loop::isOutermost() const { return parent.lock() == nullptr; }
bool Loop::isInnermost() const { return sub_loops.empty(); }

pLoop Loop::getOutermostLoop() {
    auto ret = shared_from_this();
    while (ret->getParent() != nullptr)
        ret = ret->getParent();
    return ret;
}

const std::vector<pLoop> &Loop::getSubLoops() const { return sub_loops; }

const std::list<BasicBlock *> &Loop::getRawBlocks() const { return loop_blocks; }

std::vector<pBlock> Loop::getBlocks() const {
    std::vector<pBlock> ret;
    ret.reserve(blockset.size());
    for (auto r : loop_blocks)
        ret.emplace_back(r->as<BasicBlock>());
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

bool Loop::hasDedicatedExits() const {
    auto exits = getExitBlocks();
    return std::all_of(exits.cbegin(), exits.cend(), [this](const auto &exit) {
        return std::all_of(exit->pred_begin(), exit->pred_end(),
                           [this](const auto &pred) { return contains(pred.get()); });
    });
}

bool Loop::isSimplifyForm() const { return getPreHeader() && getLatch() && hasDedicatedExits(); }

bool Loop::isRotatedForm() const {
    auto latch = getLatch();
    return latch && isExiting(latch);
}

bool isLCSSABlock(const Loop &loop, const BasicBlock *bb) {
    for (const auto &inst : bb->all_insts()) {
        for (const auto &use : inst->self_uses()) {
            auto user = use->getUser()->as<Instruction>();
            auto user_block = user->getParent().get();
            if (auto phi_user = user->as<PHIInst>())
                user_block = phi_user->getBlockForValue(use).get();
            // A quick path for most uses being in the same block
            if (user_block != bb && !loop.contains(user_block))
                return false;
        }
    }
    return true;
}

bool Loop::isLCSSAForm() const {
    return std::all_of(loop_blocks.cbegin(), loop_blocks.cend(),
                       [this](const BasicBlock *bb) { return isLCSSABlock(*this, bb); });
}

bool Loop::isRecursivelyLCSSAForm(const LoopInfo &loop_info) const {
    // Just check every block's the innermost loop.
    return std::all_of(loop_blocks.cbegin(), loop_blocks.cend(), [&loop_info](const BasicBlock *bb) {
        auto loop = loop_info.getLoopFor(bb);
        Err::gassert(loop != nullptr);
        return isLCSSABlock(*loop, bb);
    });
}

bool Loop::isLoopInvariant(const Value *val) const {
    if (auto inst = dynamic_cast<const Instruction *>(val))
        return !contains(inst->getParent().get());
    return true;
}

bool Loop::isAllOperandsLoopInvariant(const Instruction *inst) const {
    return std::all_of(inst->operand_begin(), inst->operand_end(),
                       [this](const auto &val) { return isLoopInvariant(val.get()); });
}

bool Loop::delBlockForCurrLoop(BasicBlock *bb) {
    auto it = std::find(loop_blocks.begin(), loop_blocks.end(), bb);
    if (it == loop_blocks.end())
        return false;
    loop_blocks.erase(it);
    blockset.erase(bb);
    return true;
}

void Loop::addBlock(BasicBlock *bb) {
    loop_blocks.emplace_back(bb);
    blockset.insert(bb);
    for (auto loop = getParent(); loop != nullptr; loop = loop->getParent())
        loop->addBlock(bb);
}

void Loop::moveToHeader(const BasicBlock *bb) {
    Err::gassert(contains(bb));
    auto it = std::find(loop_blocks.begin(), loop_blocks.end(), bb);
    Err::gassert(it != loop_blocks.end());
    if (it != loop_blocks.begin()) {
        loop_blocks.insert(loop_blocks.begin(), *it);
        loop_blocks.erase(it);
    }
}

bool Loop::contains(const pBlock &bb) const { return contains(bb.get()); }
bool Loop::contains(const pLoop &loop) const { return contains(loop.get()); }
pBlock Loop::getHeader() const { return getRawHeader()->as<BasicBlock>(); }
pBlock Loop::getPreHeader() const { return getRawPreHeader()->as<BasicBlock>(); }
bool Loop::isLatch(const pBlock &bb) const { return isLatch(bb.get()); }
bool Loop::isExiting(const pBlock &bb) const { return isExiting(bb.get()); }
bool Loop::isExit(const pBlock &bb) const { return isExit(bb.get()); }
std::set<pBlock> Loop::getExitingBlocks() const {
    auto res = getRawExitingBlocks();
    std::set<pBlock> ret;
    for (const auto &r : res)
        ret.emplace(r->as<BasicBlock>());
    return ret;
}
std::set<pBlock> Loop::getExitBlocks() const {
    auto res = getRawExitBlocks();
    std::set<pBlock> ret;
    for (const auto &r : res)
        ret.emplace(r->as<BasicBlock>());
    return ret;
}
std::vector<pBlock> Loop::getLatches() const {
    auto res = getRawLatches();
    std::vector<pBlock> ret;
    for (const auto &r : res)
        ret.emplace_back(r->as<BasicBlock>());
    return ret;
}
pBlock Loop::getLatch() const { return getRawLatch()->as<BasicBlock>(); }

bool Loop::isLoopInvariant(const pVal &val) const { return isLoopInvariant(val.get()); }
bool Loop::isAllOperandsLoopInvariant(const pInst &inst) const { return isAllOperandsLoopInvariant(inst.get()); }
void Loop::moveToHeader(const pBlock &bb) { moveToHeader(bb.get()); }

pLoop LoopInfo::getLoopFor(const BasicBlock *bb) const {
    auto it = loop_map.find(bb);
    if (it != loop_map.end())
        return it->second;
    return nullptr;
}

pLoop LoopInfo::getLoopFor(const pBlock &bb) const { return getLoopFor(bb.get()); }

bool LoopInfo::isLoopHeader(const pBlock &bb) const { return isLoopHeader(bb.get()); }

bool LoopInfo::isLoopHeader(const BasicBlock *bb) const {
    auto loop = getLoopFor(bb);
    return loop && loop->getRawHeader() == bb;
}

const std::vector<pLoop> &LoopInfo::getTopLevelLoops() const { return top_level_loops; }

bool LoopInfo::delBlock(BasicBlock *bb) {
    auto it = loop_map.find(bb);
    if (it == loop_map.end())
        return false;

    for (auto loop = it->second; loop != nullptr; loop = loop->getParent())
        loop->delBlockForCurrLoop(bb);

    loop_map.erase(bb);
    return true;
}

bool LoopInfo::delBlock(const pBlock &bb) { return delBlock(bb.get()); }
void LoopInfo::addBlock(const pLoop &loop, const pBlock &bb) { addBlock(loop, bb.get()); }

void LoopInfo::addBlock(const pLoop &loop, BasicBlock *bb) {
    auto it = loop_map.find(bb);
    if (it != loop_map.end())
        Err::gassert(it->second->contains(loop.get()), "Block is already in loop");
    loop_map[bb] = loop;
    loop->addBlock(bb);
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

    for (const auto &node : dom_pdfv) {
        std::vector<BasicBlock *> backedges;
        for (const auto &pred : node->block()->preds()) {
            if (domtree.ADomB(node->block(), pred))
                backedges.emplace_back(pred.get());
        }

        if (!backedges.empty()) {
            auto newloop = std::make_shared<Loop>(node->raw_block());
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