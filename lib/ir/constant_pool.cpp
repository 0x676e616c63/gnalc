#include "../../include/ir/constant_pool.hpp"

namespace IR
{
std::shared_ptr<ConstantI1> ConstantPool::getConst(bool val) {
    auto value = ConstantValue{val};
    auto it = pool.find(value);
    if (it == pool.end())
    {
        auto ret = std::make_shared<ConstantI1>(val);
        pool[value] = ret;
        return ret;
    }
    return std::dynamic_pointer_cast<ConstantI1>(it->second);
}

std::shared_ptr<ConstantI8> ConstantPool::getConst(char val) {
    auto value = ConstantValue{val};
    auto it = pool.find(value);
    if (it == pool.end())
    {
        auto ret = std::make_shared<ConstantI8>(val);
        pool[value] = ret;
        return ret;
    }
    return std::dynamic_pointer_cast<ConstantI8>(it->second);
}

std::shared_ptr<ConstantInt> ConstantPool::getConst(int val) {
    auto value = ConstantValue{val};
    auto it = pool.find(value);
    if (it == pool.end())
    {
        auto ret = std::make_shared<ConstantInt>(val);
        pool[value] = ret;
        return ret;
    }
    return std::dynamic_pointer_cast<ConstantInt>(it->second);
}

std::shared_ptr<ConstantFloat> ConstantPool::getConst(float val) {
    auto value = ConstantValue{val};
    auto it = pool.find(value);
    if (it == pool.end())
    {
        auto ret = std::make_shared<ConstantFloat>(val);
        pool[value] = ret;
        return ret;
    }
    return std::dynamic_pointer_cast<ConstantFloat>(it->second);
}

int ConstantPool::cleanPool() {
    int count = 0;
    for (auto it = pool.begin(); it != pool.end();) {
        if (it->second.use_count() == 1) { // 只有常量池持有引用
            it = pool.erase(it);
            count++;
        } else {
            ++it;
        }
    }
    return count;
}


ConstantPool::~ConstantPool() {
    cleanPool();
    Err::gassert(pool.empty(), "ConstantPool is not empty when destroyed.");
}
}