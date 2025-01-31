#include "../../include/ir/constant_pool.hpp"

#include "../../include/utils/logger.hpp"

namespace IR
{
std::shared_ptr<ConstantI1> ConstantPool::getConst(bool val) {
    ConstantProxy proxy(this, std::make_shared<ConstantI1>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantI1();
}

std::shared_ptr<ConstantI8> ConstantPool::getConst(char val) {
    ConstantProxy proxy(this, std::make_shared<ConstantI8>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantI8();
}

std::shared_ptr<ConstantInt> ConstantPool::getConst(int val) {
    ConstantProxy proxy(this, std::make_shared<ConstantInt>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantInt();
}

std::shared_ptr<ConstantFloat> ConstantPool::getConst(float val) {
    ConstantProxy proxy(this, std::make_shared<ConstantFloat>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantFloat();
}

int ConstantPool::cleanPool() {
    int count = 0;
    for (auto it = pool.begin(); it != pool.end();) {
        if (it->getConstant().use_count() == 2) {
            // getConstant() 产生了一个临时的 shared_ptr，所以 use_count() == 2 时，才是只有常量池持有引用
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
