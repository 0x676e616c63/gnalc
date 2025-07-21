// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../include/ir/constant_pool.hpp"
#include "../../include/utils/logger.hpp"

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

pVal ConstantPool::getZero(const pType &type) {
    if (auto btype = type->as<BType>()) {
        switch (btype->getInner()) {
        case IRBTYPE::I1:
            return getConst(false);
        case IRBTYPE::I8:
            return getConst(static_cast<char>(0));
        case IRBTYPE::I32:
            return getConst(0);
        case IRBTYPE::I64:
            return getConst(static_cast<int64_t>(0));
        case IRBTYPE::FLOAT:
            return getConst(0.0f);
        default:
            Err::unreachable("Not a Constant Type.");
        }
    }

    if (auto vec_ty = type->as<VectorType>()) {
        auto elm_ty = vec_ty->getElmType();
        if (auto btype = elm_ty->as<BType>()) {
            switch (btype->getInner()) {
            case IRBTYPE::I32:
                return getConst(std::vector<int>(vec_ty->getVectorSize(), 0));
            case IRBTYPE::FLOAT:
                return getConst(std::vector<float>(vec_ty->getVectorSize(), 0.0f));
            case IRBTYPE::I1:
            case IRBTYPE::I8:
            case IRBTYPE::I64:
                Err::not_implemented("Vector of such integer types not supported yet");
            default:
                Err::unreachable("Not a Constant Type.");
            }
        }
        Err::not_implemented("Vector of complex types not supported yet.");
    }

    Err::unreachable("Not a Constant Type");
    return nullptr;
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
