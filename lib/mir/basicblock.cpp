#include "mir/basicblock.hpp"
#include "mir/instructions/branch.hpp"
#include <algorithm>

using namespace MIR;

BasicBlock::BasicBlock() : Value(ValueTrait::BasicBlock) {}
BasicBlock::BasicBlock(std::string _name, bool _isContailPhi)
    : Value(ValueTrait::BasicBlock, std::move(_name)), containPhi(_isContailPhi) {}

unsigned int BasicBlock::addInst(const std::shared_ptr<Instruction> &_inst) {
    Err::gassert(_inst != nullptr, "try addInst a nullptr inst");
    insts.emplace_back(_inst);
    return insts.size();
}

unsigned int BasicBlock::addInsts_back(std::list<std::shared_ptr<Instruction>> _insts) {
    // Err::gassert(!_insts.empty(), "try addInsts_back a empty inst list");
    if (!_insts.empty())
        insts.splice(insts.end(), _insts);
    return insts.size();
}

unsigned int BasicBlock::addInsts_front(std::list<std::shared_ptr<Instruction>> _insts) {
    insts.splice(insts.begin(), _insts);
    return insts.size();
}

unsigned int BasicBlock::addInsts_beforebranch(std::string label, std::list<std::shared_ptr<Instruction>> _insts) {
    ///@note 依然假设对指定块的跳转只有一条branch

    for (auto it = insts.rbegin(); it != insts.rend(); ++it) {
        auto &inst = *it;

        if (inst->getOpCode().index() != 0 || std::get<OpCode>(inst->getOpCode()) != OpCode::B)
            continue;

        auto branch = std::dynamic_pointer_cast<branchInst>(inst);

        if (branch->getJmpTo() != label)
            continue;

        insts.splice(it.base(), _insts);
    }

    return insts.size();
}

unsigned int BasicBlock::addInsts_beforebranch(std::list<std::shared_ptr<Instruction>> _insts) {
    ///@note the last branch inst, I mean...

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

unsigned int BasicBlock::addLiveIn(const std::shared_ptr<BindOnVirOP> &_livein) {
    LiveIn.insert(_livein);
    return LiveIn.size();
}
unsigned int BasicBlock::addLiveOut(const std::shared_ptr<BindOnVirOP> &_liveout) {
    LiveOut.insert(_liveout);
    return LiveOut.size();
}

std::list<std::shared_ptr<BasicBlock>> BasicBlock::getPreds() const { return MIR::WeaktoSharedList(pres); }
std::list<std::shared_ptr<BasicBlock>> BasicBlock::getSuccs() const { return MIR::WeaktoSharedList(succs); }

unsigned int BasicBlock::addPred(const std::shared_ptr<BasicBlock> &_pre) {
    auto lambda = [&_pre](const auto &blk_ptr) {
        Err::gassert(!blk_ptr.expired(), "blk in pres already released!");
        return blk_ptr.lock() == _pre;
    };

    if (std::find_if(pres.begin(), pres.end(), lambda) == pres.end())
        pres.emplace_back(_pre);

    return pres.size();
}
unsigned int BasicBlock::addSucc(const std::shared_ptr<BasicBlock> &_succ) {
    auto lambda = [&_succ](const auto &blk_ptr) {
        Err::gassert(!blk_ptr.expired(), "blk in pres already released!");
        return blk_ptr.lock() == _succ;
    };

    if (std::find_if(succs.begin(), succs.end(), lambda) == succs.end())
        succs.emplace_back(_succ);
    return succs.size();
}

void BasicBlock::delPred(std::shared_ptr<BasicBlock> pred) {
    auto lambda = [&pred](const auto &blk_ptr) {
        Err::gassert(!blk_ptr.expired(), "blk in pres already released!");
        return blk_ptr.lock() == pred;
    };

    auto it = std::find_if(pres.begin(), pres.end(), lambda);

    Err::gassert(it != pres.end(), "cannot find corresponding blk in pres");

    pres.erase(it);
}

void BasicBlock::delSucc(std::shared_ptr<BasicBlock> succ) {
    auto lambda = [&succ](const auto &blk_ptr) {
        Err::gassert(!blk_ptr.expired(), "blk in succs already released!");
        return blk_ptr.lock() == succ;
    };

    auto it = std::find_if(succs.begin(), succs.end(), lambda);

    Err::gassert(it != succs.end(), "cannot find corresponding blk in succs");

    succs.erase(it);
}

void BasicBlock::delPred_try(std::shared_ptr<BasicBlock> pred) {
    auto lambda = [&pred](const auto &blk_ptr) {
        Err::gassert(!blk_ptr.expired(), "blk in pres already released!");
        return blk_ptr.lock() == pred;
    };

    auto it = std::find_if(pres.begin(), pres.end(), lambda);

    if (it != pres.end())
        pres.erase(it);
}

void BasicBlock::delSucc_try(std::shared_ptr<BasicBlock> succ) {
    auto lambda = [&succ](const auto &blk_ptr) {
        Err::gassert(!blk_ptr.expired(), "blk in succs already released!");
        return blk_ptr.lock() == succ;
    };

    auto it = std::find_if(succs.begin(), succs.end(), lambda);

    if (it != succs.end())
        succs.erase(it);
}

std::list<std::shared_ptr<Instruction>> &BasicBlock::getInsts() { return insts; }

const std::list<std::shared_ptr<Instruction>> &BasicBlock::getInsts() const { return insts; }

std::unordered_set<std::shared_ptr<BindOnVirOP>> &BasicBlock::getLiveIn() { return LiveIn; }
std::unordered_set<std::shared_ptr<BindOnVirOP>> &BasicBlock::getLiveOut() { return LiveOut; }

void BasicBlock::delInst(std::shared_ptr<Instruction> inst) {
    auto it =
        std::find_if(insts.begin(), insts.end(), [&inst](const auto &another_inst) { return another_inst == inst; });

    Err::gassert(it != insts.end(), "cannot find corresponding inst in blk insts");

    insts.erase(it);
}

std::string BasicBlock::toString() const {
    std::string str;
    str += getName() + ":\n";

    for (const auto &inst : insts) {
        str += "        ";
        str += inst->toString();
    }

    return str;
}

std::string BasicBlock::toString_debug(liveSet liveIn, liveSet liveOut) const {
    std::string str;

    str += getName() + ":\n";

    str += "        liveIn:";
    for (const auto &op : liveIn) {
        if (auto precoloredop = std::dynamic_pointer_cast<PreColedOP>(op)) {
            if (precoloredop->getBank() == RegisterBank::gpr)
                str += " $" + enum_name(std::get<CoreRegister>(precoloredop->getColor())) + ',';
            else if (precoloredop->getBank() == RegisterBank::spr)
                str += " $" + enum_name(std::get<FPURegister>(precoloredop->getColor())) + ',';
            else
                Err::todo("dpr, qpr todo...");
        } else
            str += ' ' + op->getName() + ',';
    }
    str += '\n';

    for (const auto &inst : insts) {
        str += "            ";
        str += inst->toString();
    }

    str += "        liveOut:";

    for (const auto &op : liveOut) {
        if (auto precoloredop = std::dynamic_pointer_cast<PreColedOP>(op)) {
            if (precoloredop->getBank() == RegisterBank::gpr)
                str += " $" + enum_name(std::get<CoreRegister>(precoloredop->getColor())) + ',';
            else if (precoloredop->getBank() == RegisterBank::spr)
                str += " $" + enum_name(std::get<FPURegister>(precoloredop->getColor())) + ',';
            else
                Err::todo("dpr, qpr todo...");
        } else
            str += ' ' + op->getName() + ',';
    }
    str += '\n';

    return str;
}