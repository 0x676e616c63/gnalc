#pragma once
#ifndef GNALC_MIR_BASICBLOCK_HPP
#define GNALC_MIR_BASICBLOCK_HPP
#include "base.hpp"
#include "instruction.hpp"
#include <unordered_set>
#include <list>

namespace MIR {

class BasicBlock : public Value {
private:
    std::list<std::weak_ptr<BasicBlock>> pres;
    std::list<std::weak_ptr<BasicBlock>> succs;
    std::unordered_set<std::shared_ptr<BindOnVirOP>> LiveIn;
    std::unordered_set<std::shared_ptr<BindOnVirOP>> LiveOut;

    std::list<std::shared_ptr<Instruction>> insts;

public:
    BasicBlock() : Value(ValueTrait::BasicBlock){};
    explicit BasicBlock(std::string _name)
    : Value(ValueTrait::BasicBlock, std::move(_name)) {}

    unsigned int addPre(const std::shared_ptr<BasicBlock> &_pre) {
        pres.emplace_back(_pre);
        return pres.size();
    }
    unsigned int addSucc(const std::shared_ptr<BasicBlock> &_succ) {
        succs.emplace_back(_succ);
        return succs.size();
    }
    unsigned int addInst(const std::shared_ptr<Instruction>& _inst) {
        insts.emplace_back(_inst);
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

    std::list<std::weak_ptr<BasicBlock>> &getPres() { return pres; }
    std::list<std::weak_ptr<BasicBlock>> &getSuccs() { return succs; }

    std::list<std::shared_ptr<Instruction>> &getInsts() { return insts; }

    std::unordered_set<std::shared_ptr<BindOnVirOP>> &getLiveIn() {
        return LiveIn;
    }
    std::unordered_set<std::shared_ptr<BindOnVirOP>> &getLiveOut() {
        return LiveOut;
    }

    std::string toString() const;
    ~BasicBlock() override = default;
};

} // namespace MIR

#endif