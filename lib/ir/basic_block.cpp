#include <utility>

#include "../../include/ir/basic_block.hpp"

#include <list>

#include "../../include/ir/utilities.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {
BasicBlock::BasicBlock(std::string _name)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED),
            ValueTrait::BASIC_BLOCK) {}

BasicBlock::BasicBlock(std::string _name,
                       std::list<std::shared_ptr<Instruction>> _insts)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED),
            ValueTrait::BASIC_BLOCK),
      insts(std::move(_insts)) {
    updateInstIndex();
}

BasicBlock::BasicBlock(std::string _name,
                       std::list<std::weak_ptr<BasicBlock>> _pre_bb,
                       std::list<std::weak_ptr<BasicBlock>> _next_bb,
                       std::list<std::shared_ptr<Instruction>> _insts)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED),
            ValueTrait::BASIC_BLOCK),
      insts(std::move(_insts)),
      pre_bb(std::move(_pre_bb)), next_bb(std::move(_next_bb)) {
    updateInstIndex();
}

void BasicBlock::addInst(size_t index, const std::shared_ptr<Instruction> &inst) {
    auto it = std::next(insts.begin(),
        static_cast<decltype(insts)::iterator::difference_type>(index));
    insts.insert(it, inst);
}

void BasicBlock::addPreBB(const std::shared_ptr<BasicBlock> &bb) {
    pre_bb.emplace_back(bb);
}

void BasicBlock::addNextBB(const std::shared_ptr<BasicBlock> &bb) {
    next_bb.emplace_back(bb);
}
bool BasicBlock::delPreBB(const std::shared_ptr<BasicBlock> &bb) {
    for (auto it = pre_bb.begin(); it != pre_bb.end(); ++it) {
        if (it->lock() == bb) {
            pre_bb.erase(it);
            return true;
        }
    }
    return false;
}
bool BasicBlock::delNextBB(const std::shared_ptr<BasicBlock> &bb) {
    for (auto it = next_bb.begin(); it != next_bb.end(); ++it) {
        if (it->lock() == bb) {
            next_bb.erase(it);
            return true;
        }
    }
    return false;
}

void BasicBlock::addInst(const std::shared_ptr<Instruction> &inst) {
    inst->index = phi_insts.size() + insts.size();
    insts.emplace_back(inst);
    inst->setParent(shared_from_this());
}

void BasicBlock::addInstAfterPhi(const std::shared_ptr<Instruction> &inst) {
    insts.insert(insts.begin(), inst);
    updateInstIndex();
}

void BasicBlock::addInstBeforeTerminator(const std::shared_ptr<Instruction> &inst) {
    auto term = insts.back();
    Err::gassert(term->getOpcode() == OP::BR || term->getOpcode() == OP::RET);
    term->index = phi_insts.size() + insts.size();
    inst->index = term->index - 1;
    insts.insert(std::prev(insts.end()), term);
}

std::list<std::shared_ptr<BasicBlock>> BasicBlock::getPreBB() const {
    return WeaktoSharedList(pre_bb);
}

std::list<std::shared_ptr<BasicBlock>> BasicBlock::getNextBB() const {
    return WeaktoSharedList(next_bb);
}

const std::list<std::shared_ptr<Instruction>> &BasicBlock::getInsts() const {
    return insts;
}

const std::list<std::shared_ptr<PHIInst>> & BasicBlock::getPhiInsts() const {
    return phi_insts;
}

std::list<std::shared_ptr<Instruction>> BasicBlock::getAllInsts() const {
    std::list<std::shared_ptr<Instruction>> all;
    all.insert(all.end(), phi_insts.begin(), phi_insts.end());
    all.insert(all.end(), insts.begin(), insts.end());
    return all;
}

void BasicBlock::updateInstIndex() const {
    unsigned i = 0;
    for (const auto &inst : phi_insts) {
        inst->index = ++i;
    }
    for (const auto &inst : insts) {
        inst->index = ++i;
    }
}

bool BasicBlock::delFirstOfInst(const std::shared_ptr<Instruction> &inst) {
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (*it == inst) {
            inst->setParent(nullptr);
            insts.erase(it);
            updateInstIndex();
            return true;
        }
    }
    return false;
}

bool BasicBlock::delFirstOfPhiInst(const std::shared_ptr<PHIInst> &inst) {
    for (auto it = phi_insts.begin(); it != phi_insts.end(); ++it) {
        if (*it == inst) {
            inst->setParent(nullptr);
            phi_insts.erase(it);
            updateInstIndex();
            return true;
        }
    }
    return false;
}

bool BasicBlock::delInst(const std::shared_ptr<Instruction> &target, const DEL_MODE mode) {
    return delInstIf([&target](const auto &inst) { return inst == target; }, mode);
}

BasicBlock::const_iterator BasicBlock::cbegin() const { return insts.cbegin(); }

BasicBlock::const_iterator BasicBlock::cend() const { return insts.cend(); }

BasicBlock::iterator BasicBlock::begin() { return insts.begin(); }

BasicBlock::iterator BasicBlock::end() { return insts.end(); }

void BasicBlock::setBBParam(const std::vector<std::shared_ptr<Value>> &params) {
    bb_params = params;
}

const std::vector<std::shared_ptr<Value>> &BasicBlock::getBBParams() const {
    return bb_params;
}

std::shared_ptr<Function> BasicBlock::getParent() const {
    return parent.lock();
}
void BasicBlock::setParent(const std::shared_ptr<Function> &_parent) {
    parent = _parent;
}

void BasicBlock::addPhiInst(const std::shared_ptr<PHIInst> &node) {
    phi_insts.emplace_back(node);
    node->setParent(shared_from_this());
    updateInstIndex();
}

unsigned BasicBlock::getPhiCount() const {
    return phi_insts.size();
}

void BasicBlock::accept(IRVisitor &visitor) { visitor.visit(*this); }

BasicBlock::~BasicBlock() = default;

size_t BasicBlock::getAllInstCount() const {
    return phi_insts.size() + insts.size();
}

void linkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb) {
    prebb->addNextBB(nxtbb);
    nxtbb->addPreBB(prebb);
}

void unlinkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb) {
    bool ok = prebb->delNextBB(nxtbb);
    Err::gassert(ok);
    ok = nxtbb->delPreBB(prebb);
    Err::gassert(ok);
}

std::vector<std::shared_ptr<PHIInst>> safeUnlinkBB(const std::shared_ptr<BasicBlock> &prebb, const std::shared_ptr<BasicBlock> &nxtbb) {
    // Unlink CFG
    unlinkBB(prebb, nxtbb);

    // Break BRInst
    auto br = std::dynamic_pointer_cast<BRInst>(prebb->getInsts().back());
    Err::gassert(br != nullptr);
    if (br->isConditional()) {
        if (br->getTrueDest() == nxtbb)
            br->dropTrueDest();
        else {
            Err::gassert(br->getFalseDest() == nxtbb,
                "The given block is not a successor.");
            br->dropFalseDest();
        }
    }
    else {
        Err::gassert(br->getDest() == nxtbb, "The given block is not a successor.");
        prebb->delInst(br, BasicBlock::DEL_MODE::NON_PHI);
    }

    // Handle PHI
    // This a little tricky because when we're deleting a PHIInst's operand,
    // the result phi might only have one operand. In that case we want to
    // replace the phi with the value in that operand.
    // But when this involving multiple blocks,
    // the replacing might affect other phi in other block, thus cause a replacing propagation.
    // As the propagation goes, a phi can end up self-referenced or even empty (dead block only).
    //
    //        bb0 -- bb1
    //          \    |
    //           bb2
    //
    // bb0:
    //    %0 = phi [ %1, %bb1 ] [ %2, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %2, %bb2 ]
    // bb2:
    //    %2 = phi [ %0, %bb0 ] [ %1, %bb1 ]
    //
    // First we unlink bb1 -> bb2
    //    %2 = phi [ %0, %bb0 ],  then we want to replace %2 with %0
    // So,
    // bb0:
    //    %0 = phi [ %1, %bb1 ] [ %0, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    //
    // Then we unlink bb1 -> bb0
    //    %0 = phi [ %0, %bb2 ],  here we can't replace because that makes no sense.
    // So,
    // bb0:
    //    %0 = phi [ %0, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    //
    // Finally we unlink bb2 -> bb0,
    //    %0 = phi [], a weird empty phi occurred.
    // Note that this can only happen in dead block.
    // And we can't figure if a block is dead, because there might be dead loops.
    // So we just mark the phi as dead.
    // So,
    // bb0:
    //    %0 = phi []
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    std::vector<std::shared_ptr<PHIInst>> unused_phi;
    for (const auto& phi : nxtbb->getPhiInsts()) {
        // Delete the phi operand from the unlinked `prebb`
        if (phi->delPhiOperByBlock(prebb)) {
            // Simplify PHI
            auto opers = phi->getPhiOpers();
            if (opers.size() == 1) {
                // Only one operand, check if it is self-reference.
                // If it is self-reference, replaceSelf makes no sense.
                if (opers[0].value != phi)
                    phi->replaceSelf(opers[0].value);
                unused_phi.emplace_back(phi);
            }
            else if (opers.empty())
                unused_phi.emplace_back(phi);
        }
    }
    return unused_phi;
}
} // namespace IR