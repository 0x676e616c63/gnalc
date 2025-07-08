// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_UTILS_SCOPE_GUARD_HPP
#define GNALC_UTILS_SCOPE_GUARD_HPP

#include <algorithm>

namespace Util {
template <typename F> class ScopeGuard {
public:
    explicit ScopeGuard(F f) : func(std::move(f)), active(true) {}
    ~ScopeGuard() {
        if (active)
            func();
    }
    void dismiss() noexcept { active = false; }

private:
    F func;
    bool active;
};

template <typename F> ScopeGuard<F> make_scope_guard(F f) { return ScopeGuard<F>(std::move(f)); }
} // namespace Util
#endif
