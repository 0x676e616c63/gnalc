#include "ir/constant_proxy.hpp"
#include "ir/constant_pool.hpp"

#include <type_traits>

namespace IR {
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI1 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI8 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI32 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI64 value_) : value(std::move(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, pConstI128 value_) : value(std::move(value_)), pool(pool_) {}
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
    else if (auto ci64 = value_->as<ConstantI64>())
        value = ci64;
    else if (auto ci128 = value_->as<ConstantI128>())
        value = ci128;
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
ConstantProxy::ConstantProxy(ConstantPool *pool_, int64_t value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, int128_t value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, float value_) : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, const std::vector<int> &value_)
    : value(pool_->getConst(value_)), pool(pool_) {}
ConstantProxy::ConstantProxy(ConstantPool *pool_, const std::vector<float> &value_)
    : value(pool_->getConst(value_)), pool(pool_) {}

template <typename T, typename U> constexpr auto isTypeMatchedImpl() {
    using TT = typename Util::remove_cvref_t<T>::element_type::inner_type;
    using UU = typename Util::remove_cvref_t<U>::element_type::inner_type;
    return (isIntegralType<TT> && isIntegralType<UU>) ||
           (std::is_floating_point_v<TT> && std::is_floating_point_v<UU>) || (std::is_same_v<TT, UU>);
}

template <typename T> constexpr auto isVecTypeImpl() {
    using TT = Util::remove_cvref_t<T>;
    return std::is_same_v<TT, pConstI32Vec> || std::is_same_v<TT, pConstF32Vec>;
}

template <typename T> constexpr auto isFloatTypeImpl() {
    using TT = Util::remove_cvref_t<T>;
    return std::is_same_v<TT, pConstF32> || std::is_same_v<TT, pConstF32Vec>;
}

template <typename T> constexpr auto isBoolTypeImpl() {
    using TT = Util::remove_cvref_t<T>;
    return std::is_same_v<TT, pConstI1>;
}

template <typename T> constexpr auto isInt128Impl() {
    using TT = Util::remove_cvref_t<T>;
    return std::is_same_v<TT, pConstI128>;
}

#define isTypeMatched(a, b) isTypeMatchedImpl<decltype(a), decltype(b)>()
#define isInt128(a) isInt128Impl<decltype(a)>()
#define isVecType(a) isVecTypeImpl<decltype(a)>()
#define isFloatType(a) isFloatTypeImpl<decltype(a)>()
#define isBoolType(a) isBoolTypeImpl<decltype(a)>()

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
ConstantProxy ConstantProxy::operator^(const ConstantProxy &rhs) const {
    Err::gassert(value.index() == rhs.value.index() && pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs) || isVecType(lhs) || isFloatType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, lhs->getVal() ^ rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::operator<<(const ConstantProxy &rhs) const {
    Err::gassert(pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (isInt128(rhs) || !isTypeMatched(lhs, rhs) || isVecType(lhs) || isFloatType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, lhs->getVal() << rhs->getVal());
        },
        value, rhs.value);
}
ConstantProxy ConstantProxy::lshr(const ConstantProxy &rhs) const {
    Err::gassert(pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (isInt128(rhs) || !isTypeMatched(lhs, rhs) || isVecType(lhs) || isFloatType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else {
                if constexpr (!isBoolType(lhs)) {
                    using T = Util::remove_cvref_t<decltype(lhs->getVal())>;
                    auto unsigned_val = static_cast<MakeUnsignedT<T>>(lhs->getVal());
                    return ConstantProxy(pool, static_cast<T>(unsigned_val >> rhs->getVal()));
                }
                return ConstantProxy(pool, lhs->getVal() >> rhs->getVal());
            }
        },
        value, rhs.value);
}

ConstantProxy ConstantProxy::ashr(const ConstantProxy &rhs) const {
    Err::gassert(pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (isInt128(rhs) || !isTypeMatched(lhs, rhs) || isVecType(lhs) || isFloatType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else
                return ConstantProxy(pool, lhs->getVal() >> rhs->getVal());
        },
        value, rhs.value);
}

ConstantProxy ConstantProxy::urem(const ConstantProxy &rhs) const {
    Err::gassert(pool == rhs.pool && pool != nullptr);
    return std::visit(
        [this](const auto &lhs, const auto &rhs) -> ConstantProxy {
            if constexpr (!isTypeMatched(lhs, rhs) || isFloatType(lhs)) {
                Err::unreachable();
                return ConstantProxy(nullptr, 0);
            } else if constexpr (isVecType(lhs)) {
                Err::gassert(lhs->size() == rhs->size());
                auto ret = lhs->getVector();
                for (size_t i = 0; i < ret.size(); ++i) {
                    using T = Util::remove_cvref_t<decltype(ret[i])>;
                    auto unsigned_val = static_cast<MakeUnsignedT<T>>(ret[i]);
                    auto unsigned_rhs = static_cast<MakeUnsignedT<T>>((*rhs)[i]);
                    ret[i] = static_cast<T>(unsigned_val % unsigned_rhs);
                }
                return ConstantProxy(pool, ret);
            } else {
                if constexpr (!isBoolType(lhs)) {
                    using T = Util::remove_cvref_t<decltype(lhs->getVal())>;
                    auto unsigned_val = static_cast<MakeUnsignedT<T>>(lhs->getVal());
                    auto unsigned_rhs = static_cast<MakeUnsignedT<T>>(rhs->getVal());
                    return ConstantProxy(pool, static_cast<T>(unsigned_val % unsigned_rhs));
                }
                return ConstantProxy(pool, lhs->getVal() % rhs->getVal());
            }
        },
        value, rhs.value);
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
            } else if constexpr (isVecType(lhs))
                return lhs->getVector() == rhs->getVector();
            else
                return lhs->getVal() == rhs->getVal();
        },
        value, rhs.value);
}
bool ConstantProxy::operator!=(const ConstantProxy &rhs) const { return !(*this == rhs); }
bool ConstantProxy::operator==(bool rhs) const { return value.index() == 0 && rhs == get_i1(); }
bool ConstantProxy::operator==(char rhs) const { return value.index() == 1 && rhs == get_i8(); }
bool ConstantProxy::operator==(int rhs) const { return value.index() == 2 && rhs == get_int(); }
bool ConstantProxy::operator==(int64_t rhs) const { return value.index() == 3 && rhs == get_i64(); }
bool ConstantProxy::operator==(int128_t rhs) const { return value.index() == 4 && rhs == get_i128(); }
bool ConstantProxy::operator==(float rhs) const { return value.index() == 5 && rhs == get_float(); }

#undef isTypeMatched
#undef isVecType
#undef isFloatType

pConstI1 ConstantProxy::getConstantI1() const { return std::get<0>(value); }
pConstI8 ConstantProxy::getConstantI8() const { return std::get<1>(value); }
pConstI32 ConstantProxy::getConstantInt() const { return std::get<2>(value); }
pConstI64 ConstantProxy::getConstantI64() const { return std::get<3>(value); }
pConstI128 ConstantProxy::getConstantI128() const { return std::get<4>(value); }
pConstF32 ConstantProxy::getConstantFloat() const { return std::get<5>(value); }
pConstI32Vec ConstantProxy::getConstantIntVector() const { return std::get<6>(value); }
pConstF32Vec ConstantProxy::getConstantFloatVector() const { return std::get<7>(value); }

pVal ConstantProxy::getConstant() const {
    return std::visit([](auto &&v) -> pVal { return v; }, value);
}

bool ConstantProxy::get_i1() const { return std::get<0>(value)->getVal(); }
char ConstantProxy::get_i8() const { return std::get<1>(value)->getVal(); }
int ConstantProxy::get_int() const { return std::get<2>(value)->getVal(); }
int64_t ConstantProxy::get_i64() const { return std::get<3>(value)->getVal(); }
int128_t ConstantProxy::get_i128() const { return std::get<4>(value)->getVal(); }
float ConstantProxy::get_float() const { return std::get<5>(value)->getVal(); }
std::vector<int> ConstantProxy::get_i32_vector() const { return std::get<6>(value)->getVector(); }
std::vector<float> ConstantProxy::get_f32_vector() const { return std::get<7>(value)->getVector(); }

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
        type_name = "i64";
        break;
    case 4:
        type_name = "i128";
        break;
    case 5:
        type_name = "f32";
        break;
    case 6:
        type_name = "i32vec";
        break;
    case 7:
        type_name = "f32vec";
        break;
    default:
        Err::unreachable();
    }
    size_t seed = std::hash<std::string>()(type_name);
    Util::hashSeedCombine(
        seed,
        std::visit(Util::overloaded{
                       [](auto &&c) {
                           return std::hash<typename Util::remove_cvref_t<decltype(c)>::element_type::inner_type>()(
                               c->getVal());
                       },
                       [](const pConstI32Vec &c) { return Util::vectorHash(c->getVector()); },
                       [](const pConstF32Vec &c) { return Util::vectorHash(c->getVector()); }},
                   constant.value));
    return seed;
}
} // namespace IR