#include "mir-old/module.hpp"

using namespace MIR;

Module::Module(std::string _name) : Value(ValueTrait::Module, std::move(_name)) {}

void Module::addGlobal(const std::shared_ptr<GlobalObj> &_glo) { GlobalVals.emplace_back(_glo); }

void Module::addFunc(const std::shared_ptr<Function> &_func) { funcs.emplace_back(_func); }

std::list<std::shared_ptr<Function>> &Module::getFuncs() { return funcs; }

ConstPool &Module::getConstPool() { return constpool; }

const std::vector<std::shared_ptr<GlobalObj>> &Module::getGlobalVals() const { return GlobalVals; }

const std::list<std::shared_ptr<Function>> &Module::getFunctions() const { return funcs; }

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