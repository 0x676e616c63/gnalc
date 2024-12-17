#include "../../include/ir/basic_block.hpp"
#include "../../include/ir/visitor.hpp"

namespace IR {
    BasicBlock::BasicBlock(std::string _name) 
        : Value(std::move(_name), IRTYPE::UNDEFINED) {}

    BasicBlock::BasicBlock(std::string _name, std::list<Instruction*> _insts) 
        : Value(std::move(_name), IRTYPE::UNDEFINED), insts(_insts) {}

    BasicBlock::BasicBlock(std::string _name, std::list<BasicBlock*> _pre_bb, std::list<BasicBlock*> _next_bb, std::list<Instruction*> _insts)
        : Value(std::move(_name), IRTYPE::UNDEFINED), insts(_insts), pre_bb(_pre_bb), next_bb(_next_bb) {}

    void BasicBlock::addPreBB(BasicBlock* bb) {
        pre_bb.emplace_back(bb);
    }

    void BasicBlock::addNextBB(BasicBlock* bb) {
        next_bb.emplace_back(bb);
    }

    void BasicBlock::addInst(Instruction* inst) {
        insts.emplace_back(inst);
    }

    std::list<BasicBlock*>& BasicBlock::getPreBB() {
        return pre_bb;
    }

    std::list<BasicBlock*>& BasicBlock::getNextBB() {
        return next_bb;
    }

    std::list<Instruction*>& BasicBlock::getInsts() {
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