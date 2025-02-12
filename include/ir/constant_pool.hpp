#pragma once
#ifndef GNALC_IR_CONSTANTPOOL_HPP
#define GNALC_IR_CONSTANTPOOL_HPP

#include <unordered_set>

#include "../utils/exception.hpp"
#include "constant.hpp"
#include "constant_proxy.hpp"

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

    std::shared_ptr<ConstantI1> getConst(bool val);

    std::shared_ptr<ConstantI8> getConst(char val);

    std::shared_ptr<ConstantInt> getConst(int val);

    std::shared_ptr<ConstantFloat> getConst(float val);

    int cleanPool();

    ~ConstantPool();
};

} // namespace IR

#endif