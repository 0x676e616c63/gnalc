#include "../../include/ir/basic_block.hpp"
#include "../../include/utils/misc.hpp"
#include "../../include/ir/visitor.hpp"

#include <list>
#include <utility>

namespace IR {
BasicBlock::BasicBlock(std::string _name)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED), ValueTrait::BASIC_BLOCK) {}

BasicBlock::BasicBlock(std::string _name, std::list<std::shared_ptr<Instruction>> _insts)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED), ValueTrait::BASIC_BLOCK), insts(std::move(_insts)) {
    updateInstIndex();
}

BasicBlock::BasicBlock(std::string _name, std::list<std::weak_ptr<BasicBlock>> _pre_bb,
                       std::list<std::weak_ptr<BasicBlock>> _next_bb, std::list<std::shared_ptr<Instruction>> _insts)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED), ValueTrait::BASIC_BLOCK), insts(std::move(_insts)),
      pre_bb(std::move(_pre_bb)), next_bb(std::move(_next_bb)) {
    updateInstIndex();
}

void BasicBlock::addInst(iterator it, const std::shared_ptr<Instruction> &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInst. Use addPhiInst instead.");
    insts.insert(it, inst);
    inst->setParent(shared_from_this());
    updateInstIndex();
}

void BasicBlock::addInst(size_t index, const std::shared_ptr<Instruction> &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInst. Use addPhiInst instead.");
    index -= phi_insts.size();
    auto it = std::next(insts.begin(), static_cast<decltype(insts)::iterator::difference_type>(index));
    insts.insert(it, inst);
    inst->setParent(shared_from_this());
    updateInstIndex();
}

void BasicBlock::addPreBB(const std::shared_ptr<BasicBlock> &bb) { pre_bb.emplace_back(bb); }

void BasicBlock::addNextBB(const std::shared_ptr<BasicBlock> &bb) { next_bb.emplace_back(bb); }
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
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInst. Use addPhiInst instead.");
    inst->index = phi_insts.size() + insts.size();
    insts.emplace_back(inst);
    inst->setParent(shared_from_this());
}

void BasicBlock::addInstAfterPhi(const std::shared_ptr<Instruction> &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInstAfterPhi. Use addPhiInst instead.");
    insts.insert(insts.begin(), inst);
    inst->setParent(shared_from_this());
    updateInstIndex();
}

// FIXME: add it before BRInst's cond.
void BasicBlock::addInstBeforeTerminator(const std::shared_ptr<Instruction> &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInstBeforeTerminator. Use addPhiInst instead.");
    auto term = getTerminator();
    Err::gassert(term->getOpcode() == OP::BR || term->getOpcode() == OP::RET);
    term->index = phi_insts.size() + insts.size();
    inst->index = term->index - 1;
    insts.insert(std::prev(insts.end()), inst);
    inst->setParent(shared_from_this());
}

std::list<std::shared_ptr<BasicBlock>> BasicBlock::getPreBB() const { return Util::WeaktoSharedList(pre_bb); }

std::list<std::shared_ptr<BasicBlock>> BasicBlock::getNextBB() const { return Util::WeaktoSharedList(next_bb); }

size_t BasicBlock::getNumPreds() const { return pre_bb.size(); }
size_t BasicBlock::getNumSuccs() const { return next_bb.size(); }

const std::list<std::shared_ptr<Instruction>> &BasicBlock::getInsts() const { return insts; }

const std::list<std::shared_ptr<PHIInst>> &BasicBlock::getPhiInsts() const { return phi_insts; }

std::list<std::shared_ptr<Instruction>> BasicBlock::getAllInsts() const {
    std::list<std::shared_ptr<Instruction>> all;
    all.insert(all.end(), phi_insts.begin(), phi_insts.end());
    all.insert(all.end(), insts.begin(), insts.end());
    return all;
}

void BasicBlock::updateInstIndex() const {
    size_t i = 0;
    for (const auto &inst : phi_insts)
        inst->index = i++;
    for (const auto &inst : insts)
        inst->index = i++;
}

FunctionBBIter BasicBlock::getIter() const { return std::next(parent.lock()->begin(), index); }

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

BasicBlock::const_iterator BasicBlock::begin() const { return insts.begin(); }

BasicBlock::const_iterator BasicBlock::end() const { return insts.end(); }

BasicBlock::iterator BasicBlock::begin() { return insts.begin(); }

BasicBlock::iterator BasicBlock::end() { return insts.end(); }

BasicBlock::const_iterator BasicBlock::cbegin() const { return insts.cbegin(); }

BasicBlock::const_iterator BasicBlock::cend() const { return insts.cend(); }

BasicBlock::const_reverse_iterator BasicBlock::rbegin() const { return insts.rbegin(); }

BasicBlock::const_reverse_iterator BasicBlock::rend() const { return insts.rend(); }

BasicBlock::reverse_iterator BasicBlock::rbegin() { return insts.rbegin(); }

BasicBlock::reverse_iterator BasicBlock::rend() { return insts.rend(); }

BasicBlock::const_reverse_iterator BasicBlock::crbegin() const { return insts.crbegin(); }

BasicBlock::const_reverse_iterator BasicBlock::crend() const { return insts.crend(); }

BasicBlock::phi_const_iterator BasicBlock::phi_begin() const { return phi_insts.begin(); }

BasicBlock::phi_const_iterator BasicBlock::phi_end() const { return phi_insts.end(); }

BasicBlock::phi_iterator BasicBlock::phi_begin() { return phi_insts.begin(); }

BasicBlock::phi_iterator BasicBlock::phi_end() { return phi_insts.end(); }

BasicBlock::phi_const_iterator BasicBlock::phi_cbegin() const { return phi_insts.cbegin(); }

BasicBlock::phi_const_iterator BasicBlock::phi_cend() const { return phi_insts.cend(); }

void BasicBlock::setBBParam(const std::vector<std::shared_ptr<Value>> &params) { bb_params = params; }

const std::vector<std::shared_ptr<Value>> &BasicBlock::getBBParams() const { return bb_params; }

std::shared_ptr<Function> BasicBlock::getParent() const { return parent.lock(); }
void BasicBlock::setParent(const std::shared_ptr<Function> &_parent) { parent = _parent; }

std::shared_ptr<Instruction> BasicBlock::getTerminator() const { return insts.back(); }
std::shared_ptr<BRInst> BasicBlock::getBRInst() const { return std::dynamic_pointer_cast<BRInst>(getTerminator()); }
std::shared_ptr<RETInst> BasicBlock::getRETInst() const { return std::dynamic_pointer_cast<RETInst>(getTerminator()); }

void BasicBlock::addPhiInst(const std::shared_ptr<PHIInst> &node) {
    phi_insts.emplace_back(node);
    node->setParent(shared_from_this());
    updateInstIndex();
}

unsigned BasicBlock::getPhiCount() const { return phi_insts.size(); }

size_t BasicBlock::getIndex() const { return index; }

void BasicBlock::accept(IRVisitor &visitor) { visitor.visit(*this); }

BasicBlock::~BasicBlock() = default;

size_t BasicBlock::getAllInstCount() const { return phi_insts.size() + insts.size(); }

std::shared_ptr<Value> BasicBlock::cloneImpl() const {
    Err::not_implemented("BasicBlock::cloneImpl:"
                         "Cloning basic blocks requires manual handling of instruction dependencies."
                         "We MUST clone each Instruction individually and maintain "
                         "a value mapping (original -> cloned) for operand replacement."
                         "Direct cloning would break use-def chains in SSA form.");
    return nullptr;
}
} // namespace IR