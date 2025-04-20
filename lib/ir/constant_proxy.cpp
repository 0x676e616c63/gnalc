#include "ir/constant_proxy.hpp"
#include "ir/constant_pool.hpp"

namespace IR {
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI1 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI8 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI32 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstF32 value_) : value(std::move(value_)), pool(pool_) {}

ConstantProxy::ConstantProxy(ConstantPool *pool_, const pVal &value_) : pool(pool_) {
    if (auto ci1 = value_->as<ConstantI1>())
        value = ci1;
    else if (auto ci8 = value_->as<ConstantI8>())
        value = ci8;
    else if (auto ci32 = value_->as<ConstantInt>())
        value = ci32;
    else if (auto cf32 = value_->as<ConstantFloat>())
        value = cf32;
    else
        Err::unreachable("Not a constant");
}

ConstantProxy::ConstantProxy(ConstantPool *pool_, bool value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, char value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, int value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, float value_) : value(pool_->getConst(value_)), pool(pool_) {}

ConstantProxy ConstantProxy::operator+(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            return ConstantProxy(pool, lhs->getVal() + rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator-(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            return ConstantProxy(pool, lhs->getVal() - rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator*(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            return ConstantProxy(pool, lhs->getVal() * rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator/(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            return ConstantProxy(pool, lhs->getVal() / rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator%(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(Util::overloaded{[this](const auto &lhs, const auto &rhs) -> ConstantProxy {
                                           return ConstantProxy(pool, lhs->getVal() % rhs->getVal());
                                       },
                                       [](const pConstF32 &, const auto &) -> ConstantProxy {
                                           Err::unreachable();
                                           return ConstantProxy(nullptr, 0);
                                       },
                                       [](const auto &, const pConstF32 &) -> ConstantProxy {
                                           Err::unreachable();
                                           return ConstantProxy(nullptr, 0);
                                       },
                                       [](const pConstF32 &, const pConstF32 &) -> ConstantProxy {
                                           Err::unreachable();
                                           return ConstantProxy(nullptr, 0);
                                       }},
                      value, rhs.value);
}
ConstantProxy ConstantProxy::operator&&(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            return ConstantProxy(pool, lhs->getVal() && rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator||(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            return ConstantProxy(pool, lhs->getVal() || rhs->getVal());
        },
        value, rhs.value);
}

ConstantProxy ConstantProxy::operator&&(bool rhs) const {
    Err::gassert(value.index() == 0 && pool != nullptr);
    return ConstantProxy(pool, std::get<0>(value)->getVal() && rhs);
}

ConstantProxy ConstantProxy::operator||(bool rhs) const {
    Err::gassert(value.index() == 0 && pool != nullptr);
    return ConstantProxy(pool, std::get<0>(value)->getVal() || rhs);
}

ConstantProxy ConstantProxy::operator+(char rhs) const {
    Err::gassert(value.index() == 1 && pool != nullptr);
    return ConstantProxy(pool, std::get<1>(value)->getVal() + rhs);
}

ConstantProxy ConstantProxy::operator-(char rhs) const {
    Err::gassert(value.index() == 1 && pool != nullptr);
    return ConstantProxy(pool, std::get<1>(value)->getVal() - rhs);
}

ConstantProxy ConstantProxy::operator*(char rhs) const {
    Err::gassert(value.index() == 1 && pool != nullptr);
    return ConstantProxy(pool, std::get<1>(value)->getVal() * rhs);
}

ConstantProxy ConstantProxy::operator/(char rhs) const {
    Err::gassert(value.index() == 1 && pool != nullptr);
    return ConstantProxy(pool, std::get<1>(value)->getVal() / rhs);
}

ConstantProxy ConstantProxy::operator%(char rhs) const {
    Err::gassert(value.index() == 1 && pool != nullptr);
    return ConstantProxy(pool, std::get<1>(value)->getVal() % rhs);
}

ConstantProxy ConstantProxy::operator+(int rhs) const {
    Err::gassert(value.index() == 2 && pool != nullptr);
    return ConstantProxy(pool, std::get<2>(value)->getVal() + rhs);
}

ConstantProxy ConstantProxy::operator-(int rhs) const {
    Err::gassert(value.index() == 2 && pool != nullptr);
    return ConstantProxy(pool, std::get<2>(value)->getVal() - rhs);
}

ConstantProxy ConstantProxy::operator*(int rhs) const {
    Err::gassert(value.index() == 2 && pool != nullptr);
    return ConstantProxy(pool, std::get<2>(value)->getVal() * rhs);
}

ConstantProxy ConstantProxy::operator/(int rhs) const {
    Err::gassert(value.index() == 2 && pool != nullptr);
    return ConstantProxy(pool, std::get<2>(value)->getVal() / rhs);
}

ConstantProxy ConstantProxy::operator%(int rhs) const {
    Err::gassert(value.index() == 2 && pool != nullptr);
    return ConstantProxy(pool, std::get<2>(value)->getVal() % rhs);
}

ConstantProxy ConstantProxy::operator+(float rhs) const {
    Err::gassert(value.index() == 3 && pool != nullptr);
    return ConstantProxy(pool, std::get<3>(value)->getVal() + rhs);
}

ConstantProxy ConstantProxy::operator-(float rhs) const {
    Err::gassert(value.index() == 3 && pool != nullptr);
    return ConstantProxy(pool, std::get<3>(value)->getVal() - rhs);
}

ConstantProxy ConstantProxy::operator*(float rhs) const {
    Err::gassert(value.index() == 3 && pool != nullptr);
    return ConstantProxy(pool, std::get<3>(value)->getVal() * rhs);
}

ConstantProxy ConstantProxy::operator/(float rhs) const {
    Err::gassert(value.index() == 3 && pool != nullptr);
    return ConstantProxy(pool, std::get<3>(value)->getVal() / rhs);
}

ConstantProxy ConstantProxy::operator+() const { return *this; }

ConstantProxy ConstantProxy::operator-() const {
    return std::visit([this](const auto &val) -> ConstantProxy { return ConstantProxy(pool, -val->getVal()); }, value);
}

ConstantProxy ConstantProxy::operator!() const {
    return std::visit([this](const auto &val) -> ConstantProxy { return ConstantProxy(pool, !val->getVal()); }, value);
}

// Prefix
ConstantProxy &ConstantProxy::operator++() {
    *this =
        std::visit([this](const auto &val) -> ConstantProxy { return ConstantProxy(pool, val->getVal() + 1); }, value);
    return *this;
}

ConstantProxy &ConstantProxy::operator--() {
    *this =
        std::visit([this](const auto &val) -> ConstantProxy { return ConstantProxy(pool, val->getVal() - 1); }, value);
    return *this;
}

// Postfix
ConstantProxy ConstantProxy::operator++(int) {
    auto old = *this;
    *this =
        std::visit([this](const auto &val) -> ConstantProxy { return ConstantProxy(pool, val->getVal() + 1); }, value);
    return old;
}

ConstantProxy ConstantProxy::operator--(int) {
    auto old = *this;
    *this =
        std::visit([this](const auto &val) -> ConstantProxy { return ConstantProxy(pool, val->getVal() - 1); }, value);
    return old;
}

bool ConstantProxy::operator<(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit([this](const auto &lhs, const auto &rhs) -> bool { return lhs->getVal() < rhs->getVal(); }, value,
                      rhs.value);
}

bool ConstantProxy::operator>(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit([this](const auto &lhs, const auto &rhs) -> bool { return lhs->getVal() > rhs->getVal(); }, value,
                      rhs.value);
}

bool ConstantProxy::operator<=(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit([this](const auto &lhs, const auto &rhs) -> bool { return lhs->getVal() <= rhs->getVal(); },
                      value, rhs.value);
}

bool ConstantProxy::operator>=(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit([this](const auto &lhs, const auto &rhs) -> bool { return lhs->getVal() >= rhs->getVal(); },
                      value, rhs.value);
}

bool ConstantProxy::operator==(const ConstantProxy &rhs) const {
    Err::gassert(pool == rhs.pool);
    if (value.index() != rhs.value.index())
        return false;
    return std::visit([this](const auto &lhs, const auto &rhs) -> bool { return lhs->getVal() == rhs->getVal(); },
                      value, rhs.value);
}

bool ConstantProxy::operator==(bool rhs) const { return value.index() == 0 && std::get<0>(value)->getVal() == rhs; }

bool ConstantProxy::operator==(char rhs) const { return value.index() == 1 && std::get<1>(value)->getVal() == rhs; }

bool ConstantProxy::operator==(int rhs) const { return value.index() == 2 && std::get<2>(value)->getVal() == rhs; }

bool ConstantProxy::operator==(float rhs) const { return value.index() == 3 && std::get<3>(value)->getVal() == rhs; }
bool ConstantProxy::operator!=(const ConstantProxy &rhs) const { return !(*this == rhs); }
bool ConstantProxy::operator!=(bool rhs) const { return !(*this == rhs); }
bool ConstantProxy::operator!=(char rhs) const { return !(*this == rhs); }
bool ConstantProxy::operator!=(int rhs) const { return !(*this == rhs); }
bool ConstantProxy::operator!=(float rhs) const { return !(*this == rhs); }

bool ConstantProxy::operator>(char rhs) const {
    Err::gassert(value.index() == 1);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() > rhs; }, value);
}

bool ConstantProxy::operator>(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() > rhs; }, value);
}

bool ConstantProxy::operator>(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() > rhs; }, value);
}

bool ConstantProxy::operator<(char rhs) const {
    Err::gassert(value.index() == 1);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() < rhs; }, value);
}

bool ConstantProxy::operator<(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() < rhs; }, value);
}

bool ConstantProxy::operator<(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() < rhs; }, value);
}

bool ConstantProxy::operator>=(char rhs) const {
    Err::gassert(value.index() == 1);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() >= rhs; }, value);
}

bool ConstantProxy::operator>=(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() >= rhs; }, value);
}

bool ConstantProxy::operator>=(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() >= rhs; }, value);
}

bool ConstantProxy::operator<=(char rhs) const {
    Err::gassert(value.index() == 1);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() <= rhs; }, value);
}

bool ConstantProxy::operator<=(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() <= rhs; }, value);
}

bool ConstantProxy::operator<=(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit([&rhs](const auto &val) -> bool { return val->getVal() <= rhs; }, value);
}

pConstI1 ConstantProxy::getConstantI1() const { return std::get<0>(value); }
pConstI8 ConstantProxy::getConstantI8() const { return std::get<1>(value); }
pConstI32 ConstantProxy::getConstantInt() const { return std::get<2>(value); }
pConstF32 ConstantProxy::getConstantFloat() const { return std::get<3>(value); }
pVal ConstantProxy::getConstant() const {
    return std::visit([](auto &&v) -> pVal { return v; }, value);
}

bool ConstantProxy::get_i1() const { return std::get<0>(value)->getVal(); }
char ConstantProxy::get_i8() const { return std::get<1>(value)->getVal(); }
int ConstantProxy::get_int() const { return std::get<2>(value)->getVal(); }
float ConstantProxy::get_float() const { return std::get<3>(value)->getVal(); }

void ConstantProxy::setPool(ConstantPool *pool_) { pool = pool_; }

std::size_t ConstantProxyHash::operator()(const ConstantProxy &constant) const {
    std::string type_name;
    switch (constant.value.index()) {
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
    return std::hash<std::string>()(type_name) ^
           std::visit(
               [](auto &&c) {
                   return std::hash<
                       typename std::remove_cv_t<std::remove_reference_t<decltype(c)>>::element_type::value_type>()(
                       c->getVal());
               },
               constant.value);
}
} // namespace IR