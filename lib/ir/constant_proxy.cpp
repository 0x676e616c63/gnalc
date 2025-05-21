#include "ir/constant_proxy.hpp"
#include "ir/constant_pool.hpp"

namespace IR {
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI1 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI8 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI32 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstF32 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI32Vec value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstF32Vec value_) : value(std::move(value_)), pool(pool_) {}

ConstantProxy::ConstantProxy(ConstantPool *pool_, const pVal &value_) : pool(pool_) {
    if (auto ci1 = value_->as<ConstantI1>())
        value = ci1;
    else if (auto ci8 = value_->as<ConstantI8>())
        value = ci8;
    else if (auto ci32 = value_->as<ConstantInt>())
        value = ci32;
    else if (auto cf32 = value_->as<ConstantFloat>())
        value = cf32;
    else if (auto vec_ci32 = value_->as<ConstantIntVector>())
        value = vec_ci32;
    else if (auto vec_cf32 = value_->as<ConstantFloatVector>())
        value = vec_cf32;
    else
        Err::unreachable("Not a constant");
}

ConstantProxy::ConstantProxy(ConstantPool *pool_, bool value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, char value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, int value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, float value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, const std::vector<int> &value_)
    : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, const std::vector<float> &value_)
    : value(pool_->getConst(value_)), pool(pool_) {}

template <typename T, typename U> constexpr auto isTypeMatchedImpl() {
    using TT = Util::remove_cvref_t<T>;
    using UU = Util::remove_cvref_t<U>;
    return std::is_same_v<TT, UU>;
}

template <typename T> constexpr auto isVecTypeImpl() {
    using TT = Util::remove_cvref_t<T>;
    return std::is_same_v<TT, pConstI32Vec> || std::is_same_v<TT, pConstF32Vec>;
}

template <typename T> constexpr auto isFloatTypeImpl() {
    using TT = Util::remove_cvref_t<T>;
    return std::is_same_v<TT, pConstF32> || std::is_same_v<TT, pConstF32Vec>;
}

#define isTypeMatched(a, b) isTypeMatchedImpl<decltype(a), decltype(b)>()
#define isVecType(a) isVecTypeImpl<decltype(a)>()
#define isFloatType(a) isFloatTypeImpl<decltype(a)>()

ConstantProxy ConstantProxy::operator+(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else if constexpr (isVecType(lhs)) {
                Err::gassert(lhs->size() == rhs->size());
                auto ret = lhs->getVector();
                for (size_t i = 0; i < ret.size(); ++i)
                    ret[i] += (*rhs)[i];
                return ConstantProxy(pool, ret);
            } else
                return ConstantProxy(pool, lhs->getVal() + rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator-(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else if constexpr (isVecType(lhs)) {
                Err::gassert(lhs->size() == rhs->size());
                auto ret = lhs->getVector();
                for (size_t i = 0; i < ret.size(); ++i)
                    ret[i] -= (*rhs)[i];
                return ConstantProxy(pool, ret);
            } else
                return ConstantProxy(pool, lhs->getVal() - rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator*(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else if constexpr (isVecType(lhs)) {
                Err::gassert(lhs->size() == rhs->size());
                auto ret = lhs->getVector();
                for (size_t i = 0; i < ret.size(); ++i)
                    ret[i] *= (*rhs)[i];
                return ConstantProxy(pool, ret);
            } else
                return ConstantProxy(pool, lhs->getVal() * rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator/(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else if constexpr (isVecType(lhs)) {
                Err::gassert(lhs->size() == rhs->size());
                auto ret = lhs->getVector();
                for (size_t i = 0; i < ret.size(); ++i)
                    ret[i] /= (*rhs)[i];
                return ConstantProxy(pool, ret);
            } else
                return ConstantProxy(pool, lhs->getVal() / rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator%(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs) || isFloatType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else if constexpr (isVecType(lhs)) {
                Err::gassert(lhs->size() == rhs->size());
                auto ret = lhs->getVector();
                for (size_t i = 0; i < ret.size(); ++i)
                    ret[i] %= (*rhs)[i];
                return ConstantProxy(pool, ret);
            } else
                return ConstantProxy(pool, lhs->getVal() % rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator&&(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs) || isVecType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, lhs->getVal() && rhs->getVal());
        },
        value, rhs.value);
}

ConstantProxy ConstantProxy::operator||(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs) || isVecType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
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
    return std::visit(
        [this](const auto &val) -> ConstantProxy {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, -val->getVal());
        },
        value);
}

ConstantProxy ConstantProxy::operator!() const {
    return std::visit(
        [this](const auto &val) -> ConstantProxy {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, !val->getVal());
        },
        value);
}

// Prefix
ConstantProxy &ConstantProxy::operator++() {
    *this = std::visit(
        [this](const auto &val) -> ConstantProxy {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, val->getVal() + 1);
        },
        value);
    return *this;
}

ConstantProxy &ConstantProxy::operator--() {
    *this = std::visit(
        [this](const auto &val) -> ConstantProxy {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, val->getVal() - 1);
        },
        value);
    return *this;
}

// Postfix
ConstantProxy ConstantProxy::operator++(int) {
    auto old = *this;
    *this = std::visit(
        [this](const auto &val) -> ConstantProxy {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, val->getVal() + 1);
        },
        value);
    return old;
}

ConstantProxy ConstantProxy::operator--(int) {
    auto old = *this;
    *this = std::visit(
        [this](const auto &val) -> ConstantProxy {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, val->getVal() - 1);
        },
        value);
    return old;
}

bool ConstantProxy::operator<(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> bool {
            if constexpr (!isTypeMatched(lhs, rhs) || isVecType(lhs)) {
                Err::unreachable();
                return false;
            } else
                return lhs->getVal() < rhs->getVal();
        },
        value, rhs.value);
}

bool ConstantProxy::operator>(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> bool {
            if constexpr (!isTypeMatched(lhs, rhs) || isVecType(lhs)) {
                Err::unreachable();
                return false;
            } else
                return lhs->getVal() > rhs->getVal();
        },
        value, rhs.value);
}

bool ConstantProxy::operator<=(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> bool {
            if constexpr (!isTypeMatched(lhs, rhs) || isVecType(lhs)) {
                Err::unreachable();
                return false;
            } else
                return lhs->getVal() <= rhs->getVal();
        },
        value, rhs.value);
}

bool ConstantProxy::operator>=(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> bool {
            if constexpr (!isTypeMatched(lhs, rhs) || isVecType(lhs)) {
                Err::unreachable();
                return false;
            } else
                return lhs->getVal() >= rhs->getVal();
        },
        value, rhs.value);
}

bool ConstantProxy::operator==(const ConstantProxy &rhs) const {
    Err::gassert(pool == rhs.pool);
    if (value.index() != rhs.value.index())
        return false;
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> bool {
            if constexpr (!isTypeMatched(lhs, rhs)) {
                Err::unreachable();
                return false;
            } else if constexpr(isVecType(lhs))
                return lhs->getVector() == rhs->getVector();
            else
                return lhs->getVal() == rhs->getVal();
        },
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
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() > rhs;
        },
        value);
}

bool ConstantProxy::operator>(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() > rhs;
        },
        value);
}

bool ConstantProxy::operator>(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() > rhs;
        },
        value);
}

bool ConstantProxy::operator<(char rhs) const {
    Err::gassert(value.index() == 1);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() < rhs;
        },
        value);
}

bool ConstantProxy::operator<(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() < rhs;
        },
        value);
}

bool ConstantProxy::operator<(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() < rhs;
        },
        value);
}

bool ConstantProxy::operator>=(char rhs) const {
    Err::gassert(value.index() == 1);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() >= rhs;
        },
        value);
}

bool ConstantProxy::operator>=(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() >= rhs;
        },
        value);
}

bool ConstantProxy::operator>=(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() >= rhs;
        },
        value);
}

bool ConstantProxy::operator<=(char rhs) const {
    Err::gassert(value.index() == 1);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() <= rhs;
        },
        value);
}

bool ConstantProxy::operator<=(int rhs) const {
    Err::gassert(value.index() == 2);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() <= rhs;
        },
        value);
}

bool ConstantProxy::operator<=(float rhs) const {
    Err::gassert(value.index() == 3);
    return std::visit(
        [&rhs](const auto &val) -> bool {
            if constexpr (isVecType(val)) {
                Err::unreachable();
                return false;
            } else
                return val->getVal() <= rhs;
        },
        value);
}

#undef isTypeMatched
#undef isVecType
#undef isFloatType

pConstI1 ConstantProxy::getConstantI1() const { return std::get<0>(value); }
pConstI8 ConstantProxy::getConstantI8() const { return std::get<1>(value); }
pConstI32 ConstantProxy::getConstantInt() const { return std::get<2>(value); }
pConstF32 ConstantProxy::getConstantFloat() const { return std::get<3>(value); }
pConstI32Vec ConstantProxy::getConstantIntVector() const { return std::get<4>(value); }
pConstF32Vec ConstantProxy::getConstantFloatVector() const { return std::get<5>(value); }

pVal ConstantProxy::getConstant() const {
    return std::visit([](auto &&v) -> pVal { return v; }, value);
}

bool ConstantProxy::get_i1() const { return std::get<0>(value)->getVal(); }
char ConstantProxy::get_i8() const { return std::get<1>(value)->getVal(); }
int ConstantProxy::get_int() const { return std::get<2>(value)->getVal(); }
float ConstantProxy::get_float() const { return std::get<3>(value)->getVal(); }
std::vector<int> ConstantProxy::get_i32_vector() const { return std::get<4>(value)->getVector(); }
std::vector<float> ConstantProxy::get_f32_vector() const { return std::get<5>(value)->getVector(); }

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
    case 4:
        type_name = "i32vec";
        break;
    case 5:
        type_name = "f32vec";
        break;
    default:
        Err::unreachable();
    }
    size_t seed = std::hash<std::string>()(type_name);
    Util::hashSeedCombine(
        seed, std::visit(Util::overloaded{[](auto &&c) {
                                              return std::hash<typename std::remove_cv_t<
                                                  std::remove_reference_t<decltype(c)>>::element_type::value_type>()(
                                                  c->getVal());
                                          },
                                          [](const pConstI32Vec &c) { return Util::vectorHash(c->getVector()); },
                                          [](const pConstF32Vec &c) { return Util::vectorHash(c->getVector()); }},
                         constant.value));
    return seed;
}
} // namespace IR