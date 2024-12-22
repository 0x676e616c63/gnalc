#include "../../include/ir/basic_block.hpp"
#include "../../include/ir/visitor.hpp"
#include "../../include/ir/utilities.hpp"

namespace IR {
    BasicBlock::BasicBlock(std::string _name)
        : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED)) {}

    BasicBlock::BasicBlock(std::string _name, std::list<std::shared_ptr<Instruction>> _insts)
        : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED)), insts(_insts) {}

    BasicBlock::BasicBlock(std::string _name, std::list<std::weak_ptr<BasicBlock>> _pre_bb, std::list<std::weak_ptr<BasicBlock>> _next_bb, std::list<std::shared_ptr<Instruction>> _insts)
        : Value(std::move(_name), makeBType(IRBTYPE::UNDEFINED)), insts(_insts), pre_bb(_pre_bb), next_bb(_next_bb) {}

    void BasicBlock::addPreBB(const std::shared_ptr<BasicBlock>& bb) {
        pre_bb.emplace_back(bb);
    }

    void BasicBlock::addNextBB(const std::shared_ptr<BasicBlock>& bb) {
        next_bb.emplace_back(bb);
    }

    void BasicBlock::addInst(const std::shared_ptr<Instruction>& inst) {
        insts.emplace_back(inst);
    }

    auto BasicBlock::getPreBB() const {
        return WeaktoSharedList(pre_bb);
    }

    auto& BasicBlock::getRPreBB() {
        return pre_bb;
    }

    auto BasicBlock::getNextBB() const {
        return WeaktoSharedList(next_bb);
    }

    auto& BasicBlock::getRNextBB() {
        return next_bb;
    }

    const auto& BasicBlock::getInsts() const {
        return insts;
    }

    auto& BasicBlock::getInsts() {
        return insts;
    }

    auto& BasicBlock::getLiveIn() {
        return livein;
    }

    auto& BasicBlock::getLiveOut() {
        return liveout;
    }

    void BasicBlock::accept(IRVisitor& visitor)
    { visitor.visit(*this); }

    BasicBlock::~BasicBlock() {
    }
}