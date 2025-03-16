#include "../../include/mir/basicblock.hpp"
#include <algorithm>

using namespace MIR;

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
        str += ' ' + op->getName() + ',';
    }
    str += '\n';

    return str;
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

void BasicBlock::delInst(std::shared_ptr<Instruction> inst) {
    auto it =
        std::find_if(insts.begin(), insts.end(), [&inst](const auto &another_inst) { return another_inst == inst; });

    Err::gassert(it != insts.end(), "cannot find corresponding inst in blk insts");

    insts.erase(it);
}