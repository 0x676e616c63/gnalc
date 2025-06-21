#pragma once
#ifndef GNALC_MIR_BASICBLOCK_HPP
#define GNALC_MIR_BASICBLOCK_HPP
#include "base.hpp"
#include "instruction.hpp"
#include "mirtoolsA32/tool.hpp"
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

    BasicBlock();
    BasicBlock(std::string _name, bool _isContailPhi);

    unsigned int addInst(const std::shared_ptr<Instruction> &_inst);

    unsigned int addInsts_back(std::list<std::shared_ptr<Instruction>> _insts);

    unsigned int addInsts_front(std::list<std::shared_ptr<Instruction>> _insts);

    unsigned int addInsts_beforebranch(std::string, std::list<std::shared_ptr<Instruction>>);

    unsigned int addInsts_beforebranch(std::list<std::shared_ptr<Instruction>> _insts);

    unsigned int addLiveIn(const std::shared_ptr<BindOnVirOP> &_livein);

    unsigned int addLiveOut(const std::shared_ptr<BindOnVirOP> &_liveout);

    std::list<std::shared_ptr<BasicBlock>> getPreds() const;
    std::list<std::shared_ptr<BasicBlock>> getSuccs() const;

    unsigned int addPred(const std::shared_ptr<BasicBlock> &_pre);
    unsigned int addSucc(const std::shared_ptr<BasicBlock> &_succ);

    void delPred(std::shared_ptr<BasicBlock> pred);
    void delSucc(std::shared_ptr<BasicBlock> succ);

    void delPred_try(std::shared_ptr<BasicBlock> pred);
    void delSucc_try(std::shared_ptr<BasicBlock> succ);

    std::list<std::shared_ptr<Instruction>> &getInsts();

    const std::list<std::shared_ptr<Instruction>> &getInsts() const;

    std::unordered_set<std::shared_ptr<BindOnVirOP>> &getLiveIn();

    std::unordered_set<std::shared_ptr<BindOnVirOP>> &getLiveOut();

    void delInst(std::shared_ptr<Instruction>);

    std::string toString() const override;

    using liveSet = std::unordered_set<std::shared_ptr<Operand>>;
    std::string toString_debug(liveSet liveIn, liveSet liveOut) const;

    ~BasicBlock() override = default;
};

} // namespace MIR

#endif