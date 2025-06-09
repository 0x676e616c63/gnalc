#include "ir/constant_pool.hpp"
#include "utils/logger.hpp"

namespace IR {
pConstI1 ConstantPool::getConst(bool val) {
    ConstantProxy proxy(this, std::make_shared<ConstantI1>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantI1();
}

pConstI8 ConstantPool::getConst(char val) {
    ConstantProxy proxy(this, std::make_shared<ConstantI8>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantI8();
}

pConstI32 ConstantPool::getConst(int val) {
    ConstantProxy proxy(this, std::make_shared<ConstantInt>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantInt();
}

pConstI64 ConstantPool::getConst(int64_t val) {
    ConstantProxy proxy(this, std::make_shared<ConstantI64>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantI64();
}

// pConstI32 ConstantPool::getConst(__int128 val) {
//     ConstantProxy proxy(this, std::make_shared<ConstantI128>(val));
//     auto [it, inserted] = pool.insert(proxy);
//     return it->getConstantInt();
// }

pConstF32 ConstantPool::getConst(float val) {
    ConstantProxy proxy(this, std::make_shared<ConstantFloat>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantFloat();
}

pConstI32Vec ConstantPool::getConst(const std::vector<int> &val) {
    ConstantProxy proxy(this, std::make_shared<ConstantIntVector>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantIntVector();
}

pConstF32Vec ConstantPool::getConst(const std::vector<float> &val) {
    ConstantProxy proxy(this, std::make_shared<ConstantFloatVector>(val));
    auto [it, inserted] = pool.insert(proxy);
    return it->getConstantFloatVector();
}

int ConstantPool::cleanPool() {
    int count = 0;
    for (auto it = pool.begin(); it != pool.end();) {
        if (it->getConstant().use_count() == 2) {
            // getConstant() 产生了一个临时的 shared_ptr，所以 use_count() == 2
            // 时，才是只有常量池持有引用
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
} // namespace IR
