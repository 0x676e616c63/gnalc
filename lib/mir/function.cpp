#include "../../include/mir/function.hpp"

using namespace MIR;

std::string FunctionInfo::toString() const {
    std::string str;

    str += "maxalignment: " + std::to_string(maxAlignment) + '\n';

    if (hasTailCall.first)
        str += "hasTailCall: true - @" + hasTailCall.second.lock()->getName() + '\n';
    else
        str += "hasTailCall: false\n";

    str += "stackobjs: \n";
    for (const auto &obj : StackObjs) {
        str += obj->toString();
        str += '\n';
    }

    str += "spilltimes: " + std::to_string(spilltimes) + '\n';

    return str;
}

std::string Function::toString() const {
    std::string str;

    str += "name: " + getName() + '\n';

    str += info.toString();

    str += "body:\n";

    for (const auto &basicblock : blocks) {
        str += "    ";
        str += basicblock->toString() + '\n';
    }

    return str;
}
