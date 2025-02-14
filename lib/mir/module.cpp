#include "../../include/mir/module.hpp"

using namespace MIR;

std::string Module::toString() const {
    std::string str;
    for (const auto &f : funcs) {
        str += f->toString() + '\n';
    }
    return str;
}