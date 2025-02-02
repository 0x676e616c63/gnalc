#include "../../include/ir/basic_block.hpp"
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
      insts(_insts) {}

BasicBlock::BasicBlock(std::string _name,
                       std::list<std::weak_ptr<BasicBlock>> _pre_bb,
                       std::list<std::weak_ptr<BasicBlock>> _next_bb,
                       std::list<std::shared_ptr<Instruction>> _insts)
    : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED),
            ValueTrait::BASIC_BLOCK),
      insts(_insts), pre_bb(_pre_bb), next_bb(_next_bb) {}

void BasicBlock::addPreBB(const std::shared_ptr<BasicBlock> &bb) {
    pre_bb.emplace_back(bb);
}

void BasicBlock::addNextBB(const std::shared_ptr<BasicBlock> &bb) {
    next_bb.emplace_back(bb);
}

void BasicBlock::addInst(const std::shared_ptr<Instruction> &inst) {
    insts.emplace_back(inst);
    inst->setParent(shared_from_this());
}

std::list<std::shared_ptr<BasicBlock>> BasicBlock::getPreBB() const {
    return WeaktoSharedList(pre_bb);
}

std::list<std::weak_ptr<BasicBlock>> &BasicBlock::getRPreBB() { return pre_bb; }

std::list<std::shared_ptr<BasicBlock>> BasicBlock::getNextBB() const {
    return WeaktoSharedList(next_bb);
}

std::list<std::weak_ptr<BasicBlock>> &BasicBlock::getRNextBB() {
    return next_bb;
}

const std::list<std::shared_ptr<Instruction>> &BasicBlock::getInsts() const {
    return insts;
}

std::list<std::shared_ptr<Instruction>> &BasicBlock::getInsts() {
    return insts;
}

unsigned BasicBlock::getInstIndex(const std::shared_ptr<Instruction> &i) const {
    unsigned index = 0;
    for (const auto &inst : insts) {
        if (inst == i) {
            return index;
        }
        index++;
    }
    Err::error("BasicBlock::getInstIndex(): can't find target instruction");
    return 0;
}

bool BasicBlock::delFirstOfInst(const std::shared_ptr<Instruction> &inst) {
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (*it == inst) {
            inst->setParent(nullptr);
            insts.erase(it);
            return true;
        }
    }
    return false;
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

void BasicBlock::accept(IRVisitor &visitor) { visitor.visit(*this); }

BasicBlock::~BasicBlock() {}
} // namespace IR