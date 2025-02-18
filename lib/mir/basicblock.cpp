#include "../../include/mir/basicblock.hpp"

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