#include "../../include/ir/basic_block.hpp"
#include "../../include/ir/visitor.hpp"
#include "../../include/ir/utilities.hpp"

namespace IR {
    BasicBlock::BasicBlock(std::string _name)
        : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED)) { setTrait(ValueTrait::BASIC_BLOCK); }

    BasicBlock::BasicBlock(std::string _name, std::list<std::shared_ptr<Instruction>> _insts)
        : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED)), insts(_insts) { setTrait(ValueTrait::BASIC_BLOCK); }

    BasicBlock::BasicBlock(std::string _name, std::list<std::weak_ptr<BasicBlock>> _pre_bb, std::list<std::weak_ptr<BasicBlock>> _next_bb, std::list<std::shared_ptr<Instruction>> _insts)
        : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED)), insts(_insts), pre_bb(_pre_bb), next_bb(_next_bb) { setTrait(ValueTrait::BASIC_BLOCK); }

    void BasicBlock::addPreBB(const std::shared_ptr<BasicBlock>& bb) {
        pre_bb.emplace_back(bb);
    }

    void BasicBlock::addNextBB(const std::shared_ptr<BasicBlock>& bb) {
        next_bb.emplace_back(bb);
    }

    void BasicBlock::addInst(const std::shared_ptr<Instruction>& inst) {
        insts.emplace_back(inst);
        inst->setParent(shared_from_this());
    }

    std::list<std::shared_ptr<BasicBlock>> BasicBlock::getPreBB() const {
        return WeaktoSharedList(pre_bb);
    }

    std::list<std::weak_ptr<BasicBlock>>& BasicBlock::getRPreBB() {
        return pre_bb;
    }

    std::list<std::shared_ptr<BasicBlock>> BasicBlock::getNextBB() const {
        return WeaktoSharedList(next_bb);
    }

    std::list<std::weak_ptr<BasicBlock>>& BasicBlock::getRNextBB() {
        return next_bb;
    }

    const std::list<std::shared_ptr<Instruction>>& BasicBlock::getInsts() const {
        return insts;
    }

    std::list<std::shared_ptr<Instruction>>& BasicBlock::getInsts() {
        return insts;
    }

    std::unordered_set<std::shared_ptr<Value>>& BasicBlock::getLiveIn() {
        return livein;
    }

    std::unordered_set<std::shared_ptr<Value>>& BasicBlock::getLiveOut() {
        return liveout;
    }

    void BasicBlock::accept(IRVisitor& visitor)
    { visitor.visit(*this); }

    BasicBlock::~BasicBlock() {
    }
}