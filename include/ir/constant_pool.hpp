#pragma once
#ifndef GNALC_IR_CONSTANTPOOL_HPP
#define GNALC_IR_CONSTANTPOOL_HPP

#include <unordered_set>

#include "constant.hpp"
#include "constant_proxy.hpp"
#include "../utils/exception.hpp"

namespace IR
{
class ConstantPool {
private:
    // Set<Proxy, ProxyHash> 可以看作 Set<Pair<Literal, ValuePtr>, PairHash>
    // 也就是 Map<Literal, ValuePtr, LiteralHash>
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

}



#endif