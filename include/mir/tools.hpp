#pragma once
#ifndef GNALC_ARMV8_MIR_TOOLS_HPP
#define GNALC_ARMV8_MIR_TOOLS_HPP

#include <cstddef>

int popcounter_wrapper(unsigned short vic) { return __builtin_popcount(static_cast<unsigned>(vic)); }

int popcounter_wrapper(unsigned vic) { return __builtin_popcount(vic); }

int popcounter_wrapper(unsigned long long vic) { return __builtin_popcountll(vic); }

int clz_wrapper(unsigned short vic) { return __builtin_clzs(vic); }

int ctz_wrapper(unsigned short vic) { return __builtin_ctzs(vic); }

int clz_wrapper(unsigned vic) { return __builtin_clz(vic); }

int ctz_wrapper(unsigned vic) { return __builtin_ctz(vic); }

int clz_wrapper(unsigned long long vic) { return __builtin_clzll(vic); }

int ctz_wrapper(unsigned long long vic) { return __builtin_ctzll(vic); }

template <typename T> T rotate_shift_right(T value, int n) {
    const int total_bits = sizeof(T) * 8;

    n = (n % total_bits + total_bits) % total_bits;

    return (value >> n) | (value << (total_bits - n));
}

#endif