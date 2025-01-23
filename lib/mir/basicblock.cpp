#include "../include/mir/basicblock.hpp"

using namespace MIR;

std::string BasicBlock::toString() {
    std::string str;
    str += getName() + ":\n";

    for (auto inst : insts) {
        str += "        ";
        str += inst->toString();
        str += '\n';
    }

    return str;
}