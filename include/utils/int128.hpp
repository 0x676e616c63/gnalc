// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_UTILS_INT128_HPP

#include <algorithm>
#include <ostream>
#include <string>

#if defined(__SIZEOF_INT128__)

using int128_t = __int128;
using uint128_t = unsigned __int128;

inline std::string Int128ToString(int128_t value) {
    if (value == 0)
        return "0";
    bool neg = value < 0;
    uint128_t tmp = neg ? uint128_t(-value) : uint128_t(value);
    std::string s;
    while (tmp != 0) {
        int digit = tmp % 10;
        s.push_back(char('0' + digit));
        tmp /= 10;
    }
    if (s.empty())
        s = "0";
    if (neg)
        s.push_back('-');
    std::reverse(s.begin(), s.end());
    return s;
}

inline std::ostream &operator<<(std::ostream &os, int128_t v) { return os << Int128ToString(v); }
#else // fallback implementation
#include <climits>
#include <cstdint>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <type_traits>

class int128_t {
    friend struct std::hash<int128_t>;
    uint64_t low;
    int64_t high;

public:
    int128_t() : low(0), high(0) {}

    template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
    int128_t(T value) : low(static_cast<uint64_t>(value)), high(value < 0 ? -1 : 0) {}

    int128_t(uint64_t low, int64_t high) : low(low), high(high) {}

    int128_t operator-() const {
        uint64_t new_low = ~low + 1;
        int64_t new_high = ~high;
        if (new_low == 0) {
            new_high += 1;
        }
        return int128_t(new_low, new_high);
    }

    int128_t &operator+=(const int128_t &other) {
        uint64_t new_low = low + other.low;
        uint64_t carry = (new_low < low) ? 1 : 0;
        int64_t new_high = high + other.high + carry;
        low = new_low;
        high = new_high;
        return *this;
    }

    int128_t &operator-=(const int128_t &other) { return *this += -other; }

    int128_t operator+(const int128_t &other) const {
        int128_t result = *this;
        return result += other;
    }

    int128_t operator-(const int128_t &other) const {
        int128_t result = *this;
        return result -= other;
    }

    static void multiply64(uint64_t a, uint64_t b, uint64_t *hi, uint64_t *lo) {
        uint64_t a_lo = a & 0xFFFFFFFF;
        uint64_t a_hi = a >> 32;
        uint64_t b_lo = b & 0xFFFFFFFF;
        uint64_t b_hi = b >> 32;

        uint64_t t0 = a_lo * b_lo;
        uint64_t t1 = a_lo * b_hi;
        uint64_t t2 = a_hi * b_lo;
        uint64_t t3 = a_hi * b_hi;

        uint64_t carry = (t0 >> 32) + (t1 & 0xFFFFFFFF) + (t2 & 0xFFFFFFFF);
        *lo = t0 + (t1 << 32) + (t2 << 32);
        *hi = t3 + (t1 >> 32) + (t2 >> 32) + (carry >> 32);
    }

    int128_t operator*(const int128_t &other) const {
        if (*this == 0 || other == 0)
            return int128_t(0);
        if (*this == 1)
            return other;
        if (other == 1)
            return *this;
        if (*this == -1)
            return -other;
        if (other == -1)
            return -*this;

        bool neg = (high < 0) != (other.high < 0);
        int128_t a = (*this < 0) ? -*this : *this;
        int128_t b = (other < 0) ? -other : other;

        uint64_t a_lo = a.low;
        uint64_t a_hi = static_cast<uint64_t>(a.high);
        uint64_t b_lo = b.low;
        uint64_t b_hi = static_cast<uint64_t>(b.high);

        uint64_t hi_ll, lo_ll;
        multiply64(a_lo, b_lo, &hi_ll, &lo_ll);

        uint64_t hi_lh, lo_lh;
        multiply64(a_lo, b_hi, &hi_lh, &lo_lh);

        uint64_t hi_hl, lo_hl;
        multiply64(a_hi, b_lo, &hi_hl, &lo_hl);

        uint64_t hi_hh, lo_hh;
        multiply64(a_hi, b_hi, &hi_hh, &lo_hh);

        uint64_t r0 = lo_ll;
        uint64_t r1 = hi_ll + lo_lh + lo_hl;
        uint64_t carry = (r1 < hi_ll) ? 1 : (r1 < lo_lh ? 1 : 0);

        r1 += lo_lh;
        carry += (r1 < lo_lh) ? 1 : 0;
        r1 += lo_hl;
        carry += (r1 < lo_hl) ? 1 : 0;

        uint64_t r2 = hi_lh + hi_hl + lo_hh + carry;
        carry = (r2 < hi_lh) ? 1 : (r2 < hi_hl ? 1 : (r2 < lo_hh ? 1 : 0));

        r2 += hi_lh;
        carry += (r2 < hi_lh) ? 1 : 0;
        r2 += hi_hl;
        carry += (r2 < hi_hl) ? 1 : 0;
        r2 += lo_hh;
        carry += (r2 < lo_hh) ? 1 : 0;

        uint64_t r3 = hi_hh + carry;

        int128_t result(r0, static_cast<int64_t>((r3 << 63) | (r2 >> 1)));
        return neg ? -result : result;
    }

    bool operator==(const int128_t &other) const { return low == other.low && high == other.high; }

    bool operator<(const int128_t &other) const {
        if (high != other.high)
            return high < other.high;
        return low < other.low;
    }

    bool operator!=(const int128_t &other) const { return !(*this == other); }
    bool operator>(const int128_t &other) const { return other < *this; }
    bool operator<=(const int128_t &other) const { return !(*this > other); }
    bool operator>=(const int128_t &other) const { return !(*this < other); }

    int128_t operator<<(int shift) const {
        if (shift == 0)
            return *this;
        if (shift < 0)
            return *this >> (-shift);
        if (shift >= 128)
            return int128_t(0);

        if (shift >= 64) {
            return int128_t(0, static_cast<int64_t>(low) << (shift - 64));
        }
        return int128_t(low << shift, static_cast<int64_t>((high << shift) | (low >> (64 - shift))));
    }

    int128_t operator>>(int shift) const {
        if (shift == 0)
            return *this;
        if (shift < 0)
            return *this << (-shift);
        if (shift >= 128)
            return (high < 0) ? int128_t(-1) : int128_t(0);

        if (shift >= 64) {
            return int128_t(static_cast<uint64_t>(high >> (shift - 64)), high < 0 ? -1 : 0);
        }
        return int128_t((low >> shift) | (static_cast<uint64_t>(high) << (64 - shift)), high >> shift);
    }

    int128_t operator&(const int128_t &other) const { return int128_t(low & other.low, high & other.high); }

    int128_t operator|(const int128_t &other) const { return int128_t(low | other.low, high | other.high); }

    int128_t operator^(const int128_t &other) const { return int128_t(low ^ other.low, high ^ other.high); }

    int128_t operator~() const { return int128_t(~low, ~high); }

    int128_t &operator&=(const int128_t &other) {
        *this = *this & other;
        return *this;
    }
    int128_t &operator|=(const int128_t &other) {
        *this = *this | other;
        return *this;
    }
    int128_t &operator^=(const int128_t &other) {
        *this = *this ^ other;
        return *this;
    }
    int128_t &operator<<=(int shift) {
        *this = *this << shift;
        return *this;
    }
    int128_t &operator>>=(int shift) {
        *this = *this >> shift;
        return *this;
    }
    int128_t &operator*=(const int128_t &other) {
        *this = *this * other;
        return *this;
    }
    int128_t &operator/=(const int128_t &other) {
        *this = *this / other;
        return *this;
    }
    int128_t &operator%=(const int128_t &other) {
        *this = *this % other;
        return *this;
    }

    int128_t &operator++() {
        *this += int128_t(1);
        return *this;
    }
    int128_t operator++(int) {
        int128_t tmp = *this;
        ++*this;
        return tmp;
    }
    int128_t &operator--() {
        *this -= int128_t(1);
        return *this;
    }
    int128_t operator--(int) {
        int128_t tmp = *this;
        --*this;
        return tmp;
    }

    int128_t operator/(const int128_t &other) const { return divmod(other).first; }

    int128_t operator%(const int128_t &other) const { return divmod(other).second; }

    explicit operator bool() const { return static_cast<int>(low); }
    explicit operator char() const { return static_cast<int>(low); }
    explicit operator short() const { return static_cast<int16_t>(low); }
    explicit operator int() const { return static_cast<int>(low); }
    explicit operator long() const { return static_cast<long>(low); }
    explicit operator long long() const { return static_cast<long long>(low); }
    explicit operator unsigned char() const { return static_cast<unsigned char>(low); }
    explicit operator unsigned short() const { return static_cast<unsigned short>(low); }
    explicit operator unsigned int() const { return static_cast<unsigned int>(low); }
    explicit operator unsigned long() const { return static_cast<unsigned long>(low); }
    explicit operator unsigned long long() const { return static_cast<unsigned long long>(low); }
    explicit operator double() const {
        if (high < 0) {
            int128_t tmp = -*this;
            return -static_cast<double>(tmp);
        }
        return high * (double)(1ULL << 63) * 2 + low;
    }
    explicit operator float() const { return static_cast<float>(static_cast<double>(*this)); }

    std::string str() const {
        if (*this == 0)
            return "0";

        int128_t num = *this;
        bool is_negative = num < 0;
        if (is_negative)
            num = -num;

        std::string result;
        while (num != 0) {
            auto quot = num.divmod(10);
            result = char('0' + static_cast<uint8_t>(quot.second.low)) + result;
            num = quot.first;
        }

        return is_negative ? "-" + result : result;
    }

    std::string hex() const {
        std::stringstream ss;
        ss << "0x" << std::hex << std::setfill('0') << std::setw(16) << high << std::setw(16) << low;
        return ss.str();
    }

    bool operator!() const { return *this == int128_t(0); }
private:
    std::pair<int128_t, int128_t> divmod(const int128_t &divisor) const {
        if (divisor == 0)
            throw std::runtime_error("Division by zero");

        bool neg_quotient = (high < 0) != (divisor.high < 0);
        bool neg_remainder = high < 0;

        int128_t dividend = *this;
        if (dividend < 0)
            dividend = -dividend;

        int128_t abs_divisor = divisor;
        if (abs_divisor < 0)
            abs_divisor = -abs_divisor;

        if (dividend < abs_divisor) {
            return {0, *this};
        }

        int128_t quotient = 0;
        int128_t current = 1;
        int128_t temp = abs_divisor;

        while (!(temp.high & INT64_MIN) && temp <= dividend) {
            temp <<= 1;
            current <<= 1;
        }

        while (abs_divisor <= dividend) {
            if (dividend >= temp) {
                dividend -= temp;
                quotient = quotient | current;
            }
            temp >>= 1;
            current >>= 1;
        }

        if (neg_quotient)
            quotient = -quotient;
        if (neg_remainder)
            dividend = -dividend;

        return {quotient, dividend};
    }
};

inline std::ostream &operator<<(std::ostream &os, const int128_t &value) { return os << value.str(); }

const int128_t INT128_MIN = int128_t(0, INT64_MIN);
const int128_t INT128_MAX = int128_t(UINT64_MAX, INT64_MAX);
const int128_t UINT128_MAX = int128_t(UINT64_MAX, -1);

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator+(T lhs, const int128_t &rhs) {
    return int128_t(lhs) + rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator-(T lhs, const int128_t &rhs) {
    return int128_t(lhs) - rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator*(T lhs, const int128_t &rhs) {
    return int128_t(lhs) * rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator/(T lhs, const int128_t &rhs) {
    return int128_t(lhs) / rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator%(T lhs, const int128_t &rhs) {
    return int128_t(lhs) % rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator&(T lhs, const int128_t &rhs) {
    return int128_t(lhs) & rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator^(T lhs, const int128_t &rhs) {
    return int128_t(lhs) ^ rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
int128_t operator|(T lhs, const int128_t &rhs) {
    return int128_t(lhs) | rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
bool operator<(T lhs, const int128_t &rhs) {
    return int128_t(lhs) < rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
bool operator>(T lhs, const int128_t &rhs) {
    return int128_t(lhs) > rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
bool operator<=(T lhs, const int128_t &rhs) {
    return int128_t(lhs) <= rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
bool operator>=(T lhs, const int128_t &rhs) {
    return int128_t(lhs) >= rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
bool operator==(T lhs, const int128_t &rhs) {
    return int128_t(lhs) == rhs;
}

template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
bool operator!=(T lhs, const int128_t &rhs) {
    return int128_t(lhs) != rhs;
}

inline std::string Int128ToString(int128_t val) { return val.str(); }

// FIXME:
using uint128_t = int128_t;
#endif

template <typename T> constexpr bool isIntegralType = std::is_integral_v<T> || std::is_same_v<T, int128_t>;

template <typename T>
struct MakeUnsigned {
    using type = std::make_unsigned_t<T>;
};

template <> struct MakeUnsigned<int128_t> {
    using type = uint128_t;
};

template <typename T>
using MakeUnsignedT = typename MakeUnsigned<T>::type;

#if !defined(__SIZEOF_INT128__)
namespace std {
template<>
struct hash<int128_t> {
    size_t operator()(const int128_t& v) const noexcept {
        return hash<uint64_t>{}(v.low) ^ (hash<uint64_t>{}(static_cast<uint64_t>(v.high)) << 1);
    }
};
} // namespace std
#endif

#endif