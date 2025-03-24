#include "../../include/mir/module.hpp"

using namespace MIR;

std::string Module::toString() const {
    std::string str;

    ///@brief globalobj
    str += "GlobalValues:\n";
    for (const auto &it : GlobalVals) {
        str += it->toString();
        str += "\n";
    }

    ///@brief constobj
    str += "ConstValues:\n";

    for (auto it = constpool.cbegin(); it != constpool.cend(); ++it) {
        str += (*it)->toString();
        str += "\n";
    }

    ///@brief functions
    // for (const auto &func : funcs) {
    //     str += "\n---\n";
    //     str += func->toString();
    //     str += '\n';
    // }

    for (const auto &func : funcs) {
        str += "\n---\n";
        str += func->toString_Debug();
        str += '\n';
    }
    return str;
}