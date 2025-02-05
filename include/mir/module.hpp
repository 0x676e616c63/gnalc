#ifndef GNALC_MIR_MODULE_HPP
#define GNALC_MIR_MODULE_HPP
#include "constpool.hpp"
#include "function.hpp"
#include "varpool.hpp"

namespace MIR {
class Module {
private:
    std::list<std::shared_ptr<Function>> funcs;
    ConstPool constpool;

    std::vector<std::shared_ptr<GlobalObj>> GlobalVals;

public:
    Module() = default;

    void addGlobal(const std::shared_ptr<GlobalObj> &_glo) {
        GlobalVals.emplace_back(_glo);
    }

    void addFunc(const std::shared_ptr<Function> &_func) {
        funcs.emplace_back(_func);
    }

    std::list<std::shared_ptr<Function>> &getFuncs() { return funcs; }

    template <typename T_variant>
    std::shared_ptr<ConstObj> getConst(const T_variant &_val) {
        constpool.getConstant(_val);
    }

    ConstPool &getConstPool() { return constpool; }

    std::string toString();
};
} // namespace MIR

#endif