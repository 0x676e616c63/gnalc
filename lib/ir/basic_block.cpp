// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/basic_block.hpp"
#include "ir/visitor.hpp"
#include "utils/logger.hpp"
#include "utils/misc.hpp"

#include <list>
#include <utility>

namespace IR {
BasicBlock::BasicBlock(std::string _name)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED), ValueTrait::BASIC_BLOCK) {}

BasicBlock::BasicBlock(std::string _name, std::list<pInst> _insts)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED), ValueTrait::BASIC_BLOCK), insts(std::move(_insts)) {
    updateInstIndex();
}

BasicBlock::BasicBlock(std::string _name, std::list<wpBlock> _pre_bb, std::list<wpBlock> _next_bb,
                       std::list<pInst> _insts)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED), ValueTrait::BASIC_BLOCK), insts(std::move(_insts)),
      pre_bb(std::move(_pre_bb)), next_bb(std::move(_next_bb)) {
    updateInstIndex();
}

void BasicBlock::addInst(iterator it, const pInst &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInst. Use addPhiInst instead.");
    insts.insert(it, inst);
    inst->setParent(as<BasicBlock>());
    inst_index_valid = false;
}

void BasicBlock::addInst(size_t index, const pInst &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInst. Use addPhiInst instead.");
    index -= phi_insts.size();
    auto it = std::next(insts.begin(), static_cast<decltype(insts)::iterator::difference_type>(index));
    insts.insert(it, inst);
    inst->setParent(as<BasicBlock>());
    inst_index_valid = false;
}

void BasicBlock::addPreBB(const pBlock &bb) { pre_bb.emplace_back(bb); }

void BasicBlock::addNextBB(const pBlock &bb) { next_bb.emplace_back(bb); }
bool BasicBlock::delPreBB(const pBlock &bb) {
    for (auto it = pre_bb.begin(); it != pre_bb.end(); ++it) {
        if (it->lock() == bb) {
            pre_bb.erase(it);
            return true;
        }
    }
    return false;
}
bool BasicBlock::delNextBB(const pBlock &bb) {
    for (auto it = next_bb.begin(); it != next_bb.end(); ++it) {
        if (it->lock() == bb) {
            next_bb.erase(it);
            return true;
        }
    }
    return false;
}

void BasicBlock::addInst(const pInst &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInst. Use addPhiInst instead.");
    inst->inst_index = phi_insts.size() + insts.size();
    insts.emplace_back(inst);
    inst->setParent(as<BasicBlock>());
}

void BasicBlock::addInstAfterPhi(const pInst &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInstAfterPhi. Use addPhiInst instead.");
    insts.insert(insts.begin(), inst);
    inst->setParent(as<BasicBlock>());
    inst_index_valid = false;
}

void BasicBlock::addInstAfterAlloca(const pInst &inst) {
    auto insert_point = insts.begin();
    while (insert_point != insts.end() && (*insert_point)->getOpcode() == OP::ALLOCA)
        ++insert_point;
    addInst(insert_point, inst);
}

// FIXME: add it before BRInst's cond.
void BasicBlock::addInstBeforeTerminator(const pInst &inst) {
    Err::gassert(inst->getParent() == nullptr, "Instruction already has parent.");
    Err::gassert(inst->getOpcode() != OP::PHI, "Do not add a phi via addInstBeforeTerminator. Use addPhiInst instead.");
    auto term = getTerminator();
    Err::gassert(term->getOpcode() == OP::BR || term->getOpcode() == OP::RET);
    term->inst_index = phi_insts.size() + insts.size();
    inst->inst_index = term->inst_index - 1;
    insts.insert(std::prev(insts.end()), inst);
    inst->setParent(as<BasicBlock>());
}

std::list<pBlock> BasicBlock::getPreBB() const { return Util::WeaktoSharedList(pre_bb); }

std::list<pBlock> BasicBlock::getNextBB() const { return Util::WeaktoSharedList(next_bb); }

size_t BasicBlock::getNumPreds() const { return pre_bb.size(); }
size_t BasicBlock::getNumSuccs() const { return next_bb.size(); }

const std::list<pInst> &BasicBlock::getInsts() const { return insts; }

const std::list<pPhi> &BasicBlock::getPhiInsts() const { return phi_insts; }

std::list<pInst> BasicBlock::getAllInsts() const {
    std::list<pInst> all;
    all.insert(all.end(), phi_insts.begin(), phi_insts.end());
    all.insert(all.end(), insts.begin(), insts.end());
    return all;
}

void BasicBlock::updateInstIndex() {
    if (!inst_index_valid) {
        size_t i = 0;
        for (const auto &inst : phi_insts)
            inst->inst_index = i++;
        for (const auto &inst : insts)
            inst->inst_index = i++;
        inst_index_valid = true;
    }
}

FunctionBBIter BasicBlock::getIter() const { return std::next(parent.lock()->begin(), index); }

bool BasicBlock::delFirstOfInst(const pInst &inst) {
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (*it == inst) {
            inst->setParent(nullptr);
            insts.erase(it);
            inst_index_valid = false;
            return true;
        }
    }
    return false;
}

bool BasicBlock::delFirstOfPhiInst(const pPhi &inst) {
    for (auto it = phi_insts.begin(); it != phi_insts.end(); ++it) {
        if (*it == inst) {
            inst->setParent(nullptr);
            phi_insts.erase(it);
            inst_index_valid = false;
            return true;
        }
    }
    return false;
}

bool BasicBlock::delInst(BBInstIter iter) {
    (*iter)->setParent(nullptr);
    insts.erase(iter);
    inst_index_valid = false;
    return true;
}

bool BasicBlock::delInst(const pInst &target, const DEL_MODE mode) {
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

void BasicBlock::setBBParam(const std::vector<pVal> &params) { bb_params = params; }

const std::vector<pVal> &BasicBlock::getBBParams() const { return bb_params; }

pFunc BasicBlock::getParent() const { return parent.lock(); }
void BasicBlock::setParent(const pFunc &_parent) { parent = _parent; }

pInst BasicBlock::getTerminator() const { return insts.back(); }
pBr BasicBlock::getBRInst() const { return getTerminator()->as<BRInst>(); }
pRet BasicBlock::getRETInst() const { return getTerminator()->as<RETInst>(); }

BBInstIter BasicBlock::getEndInsertPoint() const {
    auto point = getTerminator()->iter();
    auto br = getBRInst();
    if (!br || !br->isConditional())
        return point;
    if (auto cond_inst = br->getCond()->as<Instruction>()) {
        if (cond_inst->getParent().get() != this)
            Logger::logWarning("Cond '", cond_inst->getName(), "' and BRInst are in separate block.");
        else if (cond_inst->getUseCount() != 1)
            Logger::logWarning("Cond '", cond_inst->getName(), "' has multiple uses. (possibly more than one BRInst)");
        else if (std::next(cond_inst->iter()) != point)
            Logger::logWarning("[VerifyPass]: Cond '", cond_inst->getName(), "' and BRInst are not consecutive.");
        else
            return cond_inst->iter();
    }
    return point;
}

void BasicBlock::addPhiInst(const pPhi &node) {
    phi_insts.emplace_back(node);
    node->setParent(as<BasicBlock>());
    inst_index_valid = false;
}

void BasicBlock::addInsts(iterator it, const std::vector<pInst> &insts) {
    for (const auto &inst : insts)
        addInst(it, inst);
}
void BasicBlock::addInsts(const std::vector<pInst> &insts) {
    for (const auto &inst : insts)
        addInst(inst);
}

unsigned BasicBlock::getPhiCount() const { return phi_insts.size(); }

size_t BasicBlock::getIndex() const { return index; }

void BasicBlock::accept(IRVisitor &visitor) { visitor.visit(*this); }

BasicBlock::~BasicBlock() = default;

size_t BasicBlock::getAllInstCount() const { return phi_insts.size() + insts.size(); }

pVal BasicBlock::cloneImpl() const {
    Err::not_implemented("BasicBlock::cloneImpl:"
                         "Cloning basic blocks requires manual handling of instruction dependencies."
                         "We MUST clone each Instruction individually and maintain "
                         "a value mapping (original -> cloned) for operand replacement."
                         "Direct cloning would break use-def chains in SSA form.");
    return nullptr;
}
} // namespace IR