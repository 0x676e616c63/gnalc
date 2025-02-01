#ifndef GNALC_MIR_MODULE_HPP
#define GNALC_MIR_MODULE_HPP
#include "function.hpp"

namespace MIR {
class Module {
private:
    std::list<std::shared_ptr<Function>> funcs;

public:
    Module() = default;

    void addFunc(const std::shared_ptr<Function> &_func) {
        funcs.emplace_back(_func);
    }

    std::list<std::shared_ptr<Function>> &getFuncs() { return funcs; }

    std::string toString();
};
} // namespace MIR

#endif