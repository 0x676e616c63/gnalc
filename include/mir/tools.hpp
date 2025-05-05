#pragma once
#ifndef GNALC_ARMV8_MIR_TOOLS_HPP
#define GNALC_ARMV8_MIR_TOOLS_HPP

#include <cstddef>
#include <tuple>

inline int popcounter_wrapper(unsigned short vic) { return __builtin_popcount(static_cast<unsigned>(vic)); }

inline int popcounter_wrapper(unsigned vic) { return __builtin_popcount(vic); }

inline int popcounter_wrapper(unsigned long long vic) { return __builtin_popcountll(vic); }

inline int clz_wrapper(unsigned short vic) { return __builtin_clzs(vic); }

inline int ctz_wrapper(unsigned short vic) { return __builtin_ctzs(vic); }

inline int clz_wrapper(unsigned vic) { return __builtin_clz(vic); }

inline int ctz_wrapper(unsigned vic) { return __builtin_ctz(vic); }

inline int clz_wrapper(unsigned long long vic) { return __builtin_clzll(vic); }

inline int ctz_wrapper(unsigned long long vic) { return __builtin_ctzll(vic); }

template <typename T> T rotate_shift_right(T value, int n) {
    const int total_bits = sizeof(T) * 8;

    n = (n % total_bits + total_bits) % total_bits;

    return (value >> n) | (value << (total_bits - n));
}

template <typename T> inline bool inRange(T value, T low, T high) { return value >= low && value <= high; }

template <typename Tuple, std::size_t... I> bool all_equal_pairs_impl(const Tuple &tuple, std::index_sequence<I...>) {
    return ((std::get<2 * I>(tuple) == std::get<2 * I + 1>(tuple)) && ...);
}

template <typename... Args> bool all_equal_pairs(Args &&...args) {
    static_assert(sizeof...(Args) % 2 == 0, "Must provide even number of arguments");
    auto tuple = std::make_tuple(std::forward<Args>(args)...);
    constexpr std::size_t N = sizeof...(Args);
    return all_equal_pairs_impl(tuple, std::make_index_sequence<N / 2>{});
}

#endif