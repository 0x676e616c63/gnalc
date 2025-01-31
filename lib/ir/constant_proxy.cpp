#include "../../include/ir/constant_proxy.hpp"
#include "../../include/ir/constant_pool.hpp"

namespace IR
{
ConstantProxy::ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantI1> value_)
    : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantI8> value_)
    : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantInt> value_)
    : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool* pool_, std::shared_ptr<ConstantFloat> value_)
    : value(std::move(value_)), pool(pool_) {}

ConstantProxy::ConstantProxy(ConstantPool* pool_, const std::shared_ptr<Value>& value_)
    : pool(pool_) {
    if (auto ci1 = std::dynamic_pointer_cast<ConstantI1>(value_))
        value = ci1;
    else if (auto ci8 = std::dynamic_pointer_cast<ConstantI8>(value_))
        value = ci8;
    else if (auto ci32 = std::dynamic_pointer_cast<ConstantInt>(value_))
        value = ci32;
    else if (auto cf32 = std::dynamic_pointer_cast<ConstantFloat>(value_))
        value = cf32;
    else
        Err::unreachable("Not a constant");
}

ConstantProxy::ConstantProxy(ConstantPool* pool_, bool value_)
    : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool* pool_, char value_)
    : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool* pool_, int value_)
    : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool* pool_, float value_)
    : value(pool_->getConst(value_)), pool(pool_) {}

ConstantProxy ConstantProxy::operator+(const ConstantProxy& rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit([this](const auto& lhs, const auto& rhs) -> ConstantProxy
                               { return ConstantProxy(pool, lhs->getVal() + rhs->getVal()); },
                               value, rhs.value);
}
ConstantProxy ConstantProxy::operator-(const ConstantProxy& rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit([this](const auto& lhs, const auto& rhs) -> ConstantProxy
                               { return ConstantProxy(pool, lhs->getVal() - rhs->getVal()); },
                               value, rhs.value);
}
ConstantProxy ConstantProxy::operator*(const ConstantProxy& rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit([this](const auto& lhs, const auto& rhs) -> ConstantProxy
                               { return ConstantProxy(pool, lhs->getVal() * rhs->getVal()); },
                               value, rhs.value);
}
ConstantProxy ConstantProxy::operator/(const ConstantProxy& rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit([this](const auto& lhs, const auto& rhs) -> ConstantProxy
                               { return ConstantProxy(pool, lhs->getVal() / rhs->getVal()); },
                               value, rhs.value);
}
ConstantProxy ConstantProxy::operator%(const ConstantProxy& rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(Util::overloaded{
        [this](const auto& lhs, const auto& rhs) -> ConstantProxy
                           { return ConstantProxy(pool, lhs->getVal() % rhs->getVal()); },
        [](const std::shared_ptr<ConstantFloat>&, const auto&) -> ConstantProxy { Err::unreachable(); return ConstantProxy(nullptr, 0); },
        [](const auto&, const std::shared_ptr<ConstantFloat>&) -> ConstantProxy { Err::unreachable(); return ConstantProxy(nullptr, 0); },
        [](const std::shared_ptr<ConstantFloat>&, const std::shared_ptr<ConstantFloat>&) -> ConstantProxy { Err::unreachable(); return ConstantProxy(nullptr, 0); }
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator&&(const ConstantProxy& rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit([this](const auto& lhs, const auto& rhs) -> ConstantProxy
                               { return ConstantProxy(pool, lhs->getVal() && rhs->getVal()); },
                               value, rhs.value);
}
ConstantProxy ConstantProxy::operator||(const ConstantProxy& rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit([this](const auto& lhs, const auto& rhs) -> ConstantProxy
                               { return ConstantProxy(pool, lhs->getVal() || rhs->getVal()); },
                               value, rhs.value);
}

bool ConstantProxy::operator==(const ConstantProxy& rhs) const {
    return value.index() == rhs.value.index() && std::visit(
        [this](const auto& lhs, const auto& rhs) -> bool
                        { return lhs->getVal() == rhs->getVal(); },
                        value, rhs.value);
}

std::shared_ptr<ConstantI1> ConstantProxy::getConstantI1() const { return std::get<0>(value); }
std::shared_ptr<ConstantI8> ConstantProxy::getConstantI8() const { return std::get<1>(value); }
std::shared_ptr<ConstantInt> ConstantProxy::getConstantInt() const { return std::get<2>(value); }
std::shared_ptr<ConstantFloat> ConstantProxy::getConstantFloat() const { return std::get<3>(value); }
std::shared_ptr<Value> ConstantProxy::getConstant() const { return std::visit([](auto&& v) -> std::shared_ptr<Value> { return v; }, value); }

void ConstantProxy::setPool(ConstantPool* pool_) {
    pool = pool_;
}

std::size_t ConstantProxyHash::operator()(const ConstantProxy& constant) const {
    std::string type_name;
    switch (constant.value.index())
    {
    case 0:
        type_name = "i1";
        break;
    case 1:
        type_name = "i8";
        break;
    case 2:
        type_name = "i32";
        break;
    case 3:
        type_name = "f32";
        break;
    default:
        Err::unreachable();
    }
    return std::hash<std::string>()(type_name)
            ^ std::visit([](auto&& c)
                { return std::hash<typename std::remove_cv_t<std::remove_reference_t<decltype(c)>>::element_type::value_type>()(c->getVal()); },
                constant.value);
}
}