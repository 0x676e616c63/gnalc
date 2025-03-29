#pragma once
#ifndef GNALC_MIR_BASICBLOCK_HPP
#define GNALC_MIR_BASICBLOCK_HPP
#include "../mirtools/tool.hpp"
#include "base.hpp"
#include "instruction.hpp"
#include <list>
#include <unordered_set>

namespace MIR {

class BasicBlock : public Value {
private:
    std::list<std::weak_ptr<BasicBlock>> pres;
    std::list<std::weak_ptr<BasicBlock>> succs;
    std::unordered_set<std::shared_ptr<BindOnVirOP>> LiveIn;
    std::unordered_set<std::shared_ptr<BindOnVirOP>> LiveOut;

    std::list<std::shared_ptr<Instruction>> insts;

public:
    const bool containPhi{};
    bool isRetBlk = false;

    BasicBlock() : Value(ValueTrait::BasicBlock) {}
    BasicBlock(std::string _name, bool _isContailPhi)
        : Value(ValueTrait::BasicBlock, std::move(_name)), containPhi(_isContailPhi) {}

    unsigned int addInst(const std::shared_ptr<Instruction> &_inst) {
        Err::gassert(_inst != nullptr, "try addInst a nullptr inst");
        insts.emplace_back(_inst);
        return insts.size();
    }

    unsigned int addInsts_back(std::list<std::shared_ptr<Instruction>> _insts) {
        // Err::gassert(!_insts.empty(), "try addInsts_back a empty inst list");
        if (!_insts.empty())
            insts.splice(insts.end(), _insts);
        return insts.size();
    }

    unsigned int addInsts_front(std::list<std::shared_ptr<Instruction>> _insts) {
        Err::gassert(!_insts.empty(), "try addInsts_front a empty inst list");
        insts.splice(insts.begin(), _insts);
        return insts.size();
    }

    unsigned int addInsts_beforebranch(std::list<std::shared_ptr<Instruction>> _insts) {
        ///@note the last branch inst

        Err::gassert(!_insts.empty(), "try addInsts_beforebranch a empty inst list");

        auto branch = insts.back(); // b, b{cond}, bl, bx, RET ...

        Err::gassert(std::get<OpCode>(branch->getOpCode()) == OpCode::B ||
                         std::get<OpCode>(branch->getOpCode()) == OpCode::BL ||
                         std::get<OpCode>(branch->getOpCode()) == OpCode::BX_RET ||
                         std::get<OpCode>(branch->getOpCode()) == OpCode::BX_SET_SWI ||
                         std::get<OpCode>(branch->getOpCode()) == OpCode::BLX ||
                         std::get<OpCode>(branch->getOpCode()) == OpCode::RET,
                     "blk branch inst corrupted");

        insts.splice(std::prev(insts.end()), _insts);
        return insts.size();
    }

    unsigned int addLiveIn(const std::shared_ptr<BindOnVirOP> &_livein) {
        LiveIn.insert(_livein);
        return LiveIn.size();
    }
    unsigned int addLiveOut(const std::shared_ptr<BindOnVirOP> &_liveout) {
        LiveOut.insert(_liveout);
        return LiveOut.size();
    }

    std::list<std::shared_ptr<BasicBlock>> getPreds() const { return MIR::WeaktoSharedList(pres); }
    std::list<std::shared_ptr<BasicBlock>> getSuccs() const { return MIR::WeaktoSharedList(succs); }

    unsigned int addPred(const std::shared_ptr<BasicBlock> &_pre);
    unsigned int addSucc(const std::shared_ptr<BasicBlock> &_succ);

    void delPred(std::shared_ptr<BasicBlock> pred);
    void delSucc(std::shared_ptr<BasicBlock> succ);

    void delPred_try(std::shared_ptr<BasicBlock> pred);
    void delSucc_try(std::shared_ptr<BasicBlock> succ);

    std::list<std::shared_ptr<Instruction>> &getInsts() { return insts; }

    const std::list<std::shared_ptr<Instruction>> &getInsts() const { return insts; }

    std::unordered_set<std::shared_ptr<BindOnVirOP>> &getLiveIn() { return LiveIn; }
    std::unordered_set<std::shared_ptr<BindOnVirOP>> &getLiveOut() { return LiveOut; }

    void delInst(std::shared_ptr<Instruction>);

    std::string toString() const override;

    using liveSet = std::unordered_set<std::shared_ptr<Operand>>;
    std::string toString_debug(liveSet liveIn, liveSet liveOut) const;

    ~BasicBlock() override = default;
};

} // namespace MIR

#endif