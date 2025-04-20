#pragma once
#ifndef GNALC_IR_CONSTANTPOOL_HPP
#define GNALC_IR_CONSTANTPOOL_HPP

#include "constant.hpp"
#include "constant_proxy.hpp"

#include <unordered_set>


namespace IR {
class ConstantPool {
private:
    // Note:
    //   - ConstantProxy is a ValuePtr's wrapper.
    //   - `ConstantProxyHash` and `operator==` only deals with its inner value.
    // Therefore:
    // Set<Proxy> == Set<Pair<Literal, ValuePtr>> == Map<Literal, ValuePtr>
    std::unordered_set<ConstantProxy, ConstantProxyHash> pool;

public:
    ConstantPool() = default;

    pConstI1 getConst(bool val);
    pConstI8 getConst(char val);
    pConstI32 getConst(int val);
    pConstF32 getConst(float val);

    int cleanPool();

    ~ConstantPool();
};

} // namespace IR

#endif