// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_UTILS_ITERATOR_HPP
#define GNALC_UTILS_ITERATOR_HPP

#include <list>
#include <memory>
#include <type_traits>

namespace Util {
template <typename BegIterT, typename EndIterT> struct make_iterator_range {
    make_iterator_range(const BegIterT &begin, const EndIterT &end) : begin_it(begin), end_it(end) {}

    auto begin() const { return begin_it; }
    auto end() const { return end_it; }
    bool empty() const { return begin_it == end_it; }
    auto back() const { return *std::prev(end_it); }

private:
    BegIterT begin_it;
    EndIterT end_it;
};

template <typename T> struct reverse {
    using BegIterT = decltype(std::rbegin(std::declval<T>()));
    using EndIterT = decltype(std::rend(std::declval<T>()));
    explicit reverse(const T &range) : begin_it(std::rbegin(range)), end_it(std::rend(range)) {}

    auto begin() const { return begin_it; }
    auto end() const { return end_it; }

private:
    BegIterT begin_it;
    EndIterT end_it;
};

template <typename T> struct drop_front {
    using BegIterT = decltype(std::begin(std::declval<T>()));
    using EndIterT = decltype(std::end(std::declval<T>()));
    explicit drop_front(const T &range, size_t i = 1)
        : begin_it(std::next(std::begin(range), i)), end_it(std::end(range)) {}

    auto begin() const { return begin_it; }
    auto end() const { return end_it; }

private:
    BegIterT begin_it;
    EndIterT end_it;
};
} // namespace Util
#endif
