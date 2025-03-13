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