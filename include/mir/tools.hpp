// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_TOOLS_HPP
#define GNALC_MIR_TOOLS_HPP

#include "utils/exception.hpp"
#include <cstddef>
#include <memory>
#include <tuple>

#define nop (void)0

///@note 0 as arg of ctz/clz is ub

inline int popcounter_wrapper(unsigned short vic) { return __builtin_popcount(static_cast<unsigned>(vic)); }

inline int popcounter_wrapper(unsigned vic) { return __builtin_popcount(vic); }

inline int popcounter_wrapper(int vic) { return __builtin_popcount(vic); }

inline int popcounter_wrapper(unsigned long long vic) { return __builtin_popcountll(vic); }

inline int clz_wrapper(unsigned short vic) {
#if defined(__clang__)
    return vic ? __builtin_clzs(vic) : 16;
#else
    return vic ? __builtin_ctz((unsigned int)vic) : 16;
#endif
}

inline int ctz_wrapper(unsigned short vic) {
#if defined(__clang__)
    return vic ? __builtin_ctzs(vic) : 0;
#else
    return vic ? __builtin_ctz((unsigned int)vic) : 0;
#endif
}

inline int clz_wrapper(unsigned vic) { return vic ? __builtin_clz(vic) : 32; }

inline int ctz_wrapper(unsigned vic) { return vic ? __builtin_ctz(vic) : 0; }

inline int clz_wrapper(int vic) { return vic ? __builtin_clz(vic) : 32; }

inline int ctz_wrapper(int vic) { return vic ? __builtin_ctz(vic) : 0; }

inline int clz_wrapper(unsigned long long vic) { return vic ? __builtin_clzll(vic) : 64; }

inline int ctz_wrapper(unsigned long long vic) { return vic ? __builtin_ctzll(vic) : 0; }

template <typename T> T rotate_shift_right(T value, int n) {
    const int total_bits = sizeof(T) * 8;

    n = (n % total_bits + total_bits) % total_bits;
    return (value >> n) | (value << (total_bits - n));
}

template <typename T, typename U> inline bool inRange(T value, U low, U high) { return value >= low && value <= high; }

template <typename T, typename... Args> inline bool inSet(T value, const Args &...Enum) {
    static_assert(sizeof...(Args) != 0, "At least provide one Enum value");

    return ((value == Enum) || ...);
}

template <typename Tx, typename Ty, typename Tuple, std::size_t... I>
Ty inSetAndMap_impl(Tx value, const Tuple &tuple, std::index_sequence<I...>) {
    Ty result = static_cast<Ty>(0);

    (void)((value == std::get<2 * I>(tuple) ? (result = std::get<2 * I + 1>(tuple), true) : true) && ...);

    return result;
}

template <typename Tx, typename Ty, typename... Args>
inline Ty inSetAndMap(Tx value, Args &&...Enums) { /* Tx, Ty, Tx, Ty... */
    static_assert(sizeof...(Args) != 0 && sizeof...(Args) % 2 == 0, "Must provide even number of arguments");

    auto tuple = std::make_tuple(std::forward<Args>(Enums)...);
    constexpr std::size_t N = sizeof...(Args);

    return inSetAndMap_impl<Tx, Ty>(value, tuple, std::make_index_sequence<N / 2>{});
}

template <typename Tuple, std::size_t... I> bool all_equal_pairs_impl(const Tuple &tuple, std::index_sequence<I...>) {
    return ((std::get<2 * I>(tuple) == std::get<2 * I + 1>(tuple)) && ...);
}

template <typename... Args> bool all_equal_pairs(Args &&...args) {
    static_assert(sizeof...(Args) != 0 && sizeof...(Args) % 2 == 0, "Must provide even number of arguments");
    auto tuple = std::make_tuple(std::forward<Args>(args)...);
    constexpr std::size_t N = sizeof...(Args);
    return all_equal_pairs_impl(tuple, std::make_index_sequence<N / 2>{});
}

template <typename T> std::shared_ptr<T> wp2p(std::weak_ptr<T> wp) {
    if (wp.expired()) {
        // 可能是本身就没有而不是expired
        return nullptr;
    } else {
        return wp.lock();
    }
}

struct splited {
    unsigned int exp1;
    unsigned int exp2;
    enum class oper { singlePos, singleNeg, addPos, addNeg, sub, none } cul;
};

inline splited SplitTo2PowX(int multiplier) { // unsigned

    bool reverse = false;
    splited twin{};
    if (multiplier == 0) {
        Err::unreachable("mulopt: try mul with zero");
    } else if (multiplier < 0) {
        reverse = true;
        multiplier = std::abs(multiplier);
    }

    unsigned int cnt = popcounter_wrapper((unsigned int)multiplier);

    switch (cnt) {
    case 0:
        Err::todo("SpilitTo2PowX: multiplier = 0");
        break;
    case 1:
        twin.exp1 = ctz_wrapper(multiplier);
        if (reverse)
            twin.cul = splited::oper::singleNeg;
        else
            twin.cul = splited::oper::singlePos;
        break;
    case 2:
        twin.exp1 = ctz_wrapper(multiplier);
        multiplier = multiplier >> (twin.exp1 + 1);
        twin.exp2 = ctz_wrapper(multiplier) + twin.exp1 + 1;
        if (reverse)
            twin.cul = splited::oper::addNeg;
        else
            twin.cul = splited::oper::addPos;
        break;
    default:
        unsigned int leading = clz_wrapper(multiplier);
        unsigned int tailing = ctz_wrapper(multiplier);

        if (leading + tailing + cnt != 32) {
            twin.cul = splited::oper::none;
        } else {
            twin.exp2 = tailing;
            twin.exp1 = tailing + cnt;
            twin.cul = splited::oper::sub;
            if (reverse)
                std::swap(twin.exp1, twin.exp2);
        }
        break;
    }

    return twin;
}

#endif