#include "../../include/mir/function.hpp"

using namespace MIR;

std::string MIR::FunctionInfo::toString() const {
    std::string str;

    str += "maxalignment: " + std::to_string(maxAlignment) + '\n';

    if (hasTailCall.first)
        str += "hasTailCall: true - " + '@' +
               hasTailCall.second.lock()->getName() + '\n';
    else
        str += "hasTailCall: false\n";

    str += "stackobjs: \n";
    for (const auto& obj : StackObjs) {
        str += obj->toString();
        str += '\n';
    }

    str += "constreferance: \n";
    for (const auto& Const : ConstPool) {
        str += Const->toString();
        str += '\n';
    }

    str += "liveins: \n";
    for (const auto& arg : LiveIns) {
        str += arg->toString();
        str += '\n';
    }

    return str;
}

std::string MIR::Function::toString() const {
    std::string str;

    str += "name: " + getName() + '\n';

    str += info.toString();

    str += "body:\n";

    for (const auto& basicblock : blocks) {
        str += "    ";
        str += basicblock->toString();
        str += '\n';
    }

    return str;
}