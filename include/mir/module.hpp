#pragma once
#ifndef GNALC_MIR_MODULE_HPP
#define GNALC_MIR_MODULE_HPP
#include "base.hpp"
#include "constpool.hpp"
#include "function.hpp"
#include "varpool.hpp"

namespace MIR {
class Module : public Value {
private:
    std::list<std::shared_ptr<Function>> funcs;
    ConstPool constpool;

    std::vector<std::shared_ptr<GlobalObj>> GlobalVals;

public:
    Module() = delete;
    explicit Module(std::string _name);

    void addGlobal(const std::shared_ptr<GlobalObj> &_glo);

    void addFunc(const std::shared_ptr<Function> &_func);
    std::list<std::shared_ptr<Function>> &getFuncs();

    template <typename T_variant> std::shared_ptr<ConstObj> getConst(const T_variant &_val) {
        return constpool.getConstant(_val);
    }

    ConstPool &getConstPool();

    const std::vector<std::shared_ptr<GlobalObj>> &getGlobalVals() const;

    const std::list<std::shared_ptr<Function>> &getFunctions() const;

    std::string toString() const override;
};
} // namespace MIR

#endif