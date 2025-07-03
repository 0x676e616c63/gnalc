// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Contextual Value Range Analysis
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_RANGE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_RANGE_ANALYSIS_HPP

#include "ir/base.hpp"
#include "ir/passes/pass_manager.hpp"

#include <cmath>
#include <optional>
#include <unordered_map>
#include <vector>

namespace IR {
template <typename T>
using bigger_t =
    std::conditional_t<std::is_same_v<T, int32_t>, int64_t, std::conditional_t<std::is_same_v<T, float>, double, void>>;

template <typename T, typename U> constexpr U getMin() {
    if constexpr (std::is_same_v<T, int32_t>)
        return std::numeric_limits<T>::min();
    else if constexpr (std::is_same_v<T, float>)
        return -std::numeric_limits<T>::infinity();
    else
        return std::numeric_limits<T>::min();
}

template <typename T, typename U> constexpr U getMax() {
    if constexpr (std::is_same_v<T, int32_t>)
        return static_cast<U>(std::numeric_limits<T>::max());
    else if constexpr (std::is_same_v<T, float>)
        return std::numeric_limits<T>::infinity();
    else
        return static_cast<U>(std::numeric_limits<T>::max());
}

// [ min, max ]
// FIXME: More Precise operator
template <typename T> struct Range {

    using U = bigger_t<T>;
    using Bigger = U;

    static constexpr U MAX = getMax<T, U>();
    static constexpr U MIN = getMin<T, U>();

    U min;
    U max;

    Range() : min(MIN), max(MAX) {}
    explicit Range(U a) : min(a), max(a) {}
    Range(U min_, U max_) : min(min_), max(max_) {
        if constexpr (std::is_floating_point_v<T>) {
            if (std::isnan(min) || std::isnan(max)) {
                min = MIN;
                max = MAX;
                return;
            }
        }

        if (min < MIN)
            min = MIN;
        if (max > MAX)
            max = MAX;

        Err::gassert(min_ <= max_, "Invalid Range");
        //
        // // Debug
        // if ((min < -2000000000 && min != MIN) || (max > 2000000000 && max != MAX))
        //     Logger::logWarning("[RangeAnalysis]: Huge range detected.");
        // if ((min > 2000000000) || (max < -2000000000))
        //     Logger::logWarning("[RangeAnalysis]: Bad range detected.");
    }

    bool overlaps(const Range &item) const { return min <= item.max && max >= item.min; }

    std::optional<T> getExact() const {
        if (min == MIN || max == MAX || min == MAX || max == MIN)
            return std::nullopt;

        if (min == max)
            return min;

        return std::nullopt;
    }

    bool operator==(const Range &item) const { return min == item.min && max == item.max; }
    bool operator!=(const Range &range) const { return !(*this == range); }

    Range operator+(const Range &item) const {
        U ret_min, ret_max;
        if (min == MIN || item.min == MIN)
            ret_min = MIN;
        else
            ret_min = min + item.min;

        if (max == MAX || item.max == MAX)
            ret_max = MAX;
        else
            ret_max = max + item.max;
        return Range(ret_min, ret_max);
    }

    Range operator-(const Range &item) const {
        U ret_min, ret_max;
        if (min == MIN || item.max == MAX)
            ret_min = MIN;
        else
            ret_min = min - item.max;

        if (max == MAX || item.min == MIN)
            ret_max = MAX;
        else
            ret_max = max - item.min;

        return Range(ret_min, ret_max);
    }

    Range operator*(const Range &item) const {
        if ((min == 0 && max == 0) || (item.min == 0 && item.max == 0))
            return Range(0, 0);

        auto safe_mult = [](U a, U b) -> U {
            if (a == MIN) {
                if (b == MIN) return MAX;
                if (b == MAX) return MIN;
                if (b == 0)   return 0;
                if (b > 0)   return MIN; 
                if (b < 0)   return MAX; 
            }
            if (a == MAX) {
                if (b == MIN) return MIN;
                if (b == MAX) return MAX;
                if (b == 0)   return 0;
                if (b > 0)   return MAX; 
                if (b < 0)   return MIN; 
            }
            if (b == MIN) {
                if (a == 0)   return 0;
                if (a > 0)   return MIN; 
                if (a < 0)   return MAX; 
            }
            if (b == MAX) {
                if (a == 0)   return 0;
                if (a > 0)   return MAX; 
                if (a < 0)   return MIN; 
            }
            return a * b;
        };

        U vals[4] = {
            safe_mult(min, item.min),
            safe_mult(min, item.max),
            safe_mult(max, item.min),
            safe_mult(max, item.max)
        };

        U new_min = vals[0];
        U new_max = vals[0];
        for (int i = 1; i < 4; i++) {
            new_min = std::min(new_min, vals[i]);
            new_max = std::max(new_max, vals[i]);
        }
        return Range(new_min, new_max);
    }

Range operator/(const Range &item) const {
        if (item.min <= 0 && item.max >= 0) {
            if (min == 0 && max == 0)
                return Range(0, 0);
            return Range(MIN, MAX);
        }

        auto safe_div = [&](U x, U y) -> std::vector<U> {
            std::vector<U> results;
            bool xInf = (x == MIN || x == MAX);
            bool yInf = (y == MIN || y == MAX);

            if (xInf && yInf) {
                int sign_x = (x == MIN ? -1 : +1);
                int sign_y = (y == MIN ? -1 : +1);
                int s = sign_x * sign_y;
                if (s > 0) {
                    results.push_back(0);
                    results.push_back(MAX);
                } else {
                    results.push_back(MIN);
                    results.push_back(0);
                }
                return results;
            }

            if (xInf && !yInf) {
                int sign_x = (x == MIN ? -1 : +1);
                int sign_y = (y < 0 ? -1 : +1);
                int s = sign_x * sign_y;
                results.push_back((s > 0) ? MAX : MIN);
                return results;
            }

            if (!xInf && yInf) {
                results.push_back((T)0);
                return results;
            }

            results.push_back(x / y);
            return results;
        };

        std::vector<T> candidates;

        {
            auto tmp = safe_div(min, item.min);
            candidates.insert(candidates.end(), tmp.begin(), tmp.end());
        }
        {
            auto tmp = safe_div(min, item.max);
            candidates.insert(candidates.end(), tmp.begin(), tmp.end());
        }
        {
            auto tmp = safe_div(max, item.min);
            candidates.insert(candidates.end(), tmp.begin(), tmp.end());
        }
        {
            auto tmp = safe_div(max, item.max);
            candidates.insert(candidates.end(), tmp.begin(), tmp.end());
        }

        T new_min = candidates.front();
        T new_max = candidates.front();
        for (int i = 1; i < candidates.size(); i++) {
            new_min = std::min(new_min, candidates[i]);
            new_max = std::max(new_max, candidates[i]);
        }
        return Range(new_min, new_max);
    }

    Range operator%(const Range &item) const {
        if (min == 0 && max == 0)
        return Range(0, 0);

        if (item.containsZero() || min == MIN || max == MAX || item.min == MIN || item.max == MAX)
            return Range(MIN, MAX);

        if (item.min > 0) {
            if (min >= 0)
                return Range(0, item.max - 1);

            if (max <= 0)
                return Range(-(item.max - 1), 0);

            T m = item.max - 1;
            return Range(-m, m);
        }

        if (item.max < 0) {
            T abs_max = -item.min;
            if (min >= 0)
                return Range(0, abs_max - 1);
            if (max <= 0)
                return Range(-(abs_max - 1), 0);
            return Range(-(abs_max - 1), abs_max - 1);
        }
        return Range(MIN, MAX);
    }

    Range operator-() const {
        U ret_min, ret_max;
        if (max == MAX)
            ret_min = MIN;
        else
            ret_min = -max;

        if (min == MIN)
            ret_max = MAX;
        else
            ret_max = -min;
        return Range(ret_min, ret_max);
    }

    // TODO
    Range operator&(const Range &item) const {
        return Range();
    }
    Range operator|(const Range &item) const {
        return Range();
    }
    Range operator^(const Range &item) const {
        return Range();
    }
    Range urem(const Range &item) const {
        return Range();
    }
    Range lshr(const Range &item) const {
        return Range();
    }
    Range ashr(const Range &item) const {
        return Range();
    }
    Range shl(const Range &item) const {
        return Range();
    }

    bool containsZero() const { return min <= T(0) && max >= T(0); }

    bool merge(const Range &item) {
        if (*this == item || contains(item))
            return false;
        min = (std::min)(min, item.min);
        max = (std::max)(max, item.max);
        return true;
    }
    bool intersect(const Range &item) {
        if (*this == item || item.contains(*this))
            return false;
        min = (std::max)(min, item.min);
        max = (std::min)(max, item.max);

        if (min > max) {
            min = MIN;
            max = MAX;
        }
        return true;
    }
    bool contains(const Range &item) const { return min <= item.min && max >= item.max; }

    friend std::ostream &operator<<(std::ostream &os, const Range<T> &item) {
        if (item.min == MIN)
            os << "(-inf, ";
        else
            os << "[" << item.min << ", ";

        if (item.max == MAX)
            os << "inf)";
        else
            os << item.max << ")";
        return os;
    }

    bool isFull() const { return min == MIN && max == MAX; }
};
template <typename T> Range<T> merge(const Range<T> &a, const Range<T> &b) {
    return Range<T>((std::min)(a.min, b.min), (std::max)(a.max, b.max));
}

template <typename T> Range<T> intersect(const Range<T> &a, const Range<T> &b) {
    return Range<T>((std::max)(a.min, b.min), (std::min)(a.max, b.max));
}

template <typename To, typename From> Range<To> range_cast(const Range<From> &range) {
    using BiggerTo = bigger_t<To>;
    using BiggerFrom = bigger_t<From>;
    BiggerTo ret_min;
    BiggerTo ret_max;
    if (range.min == Range<From>::MIN || range.min <= static_cast<BiggerFrom>(Range<To>::MIN))
        ret_min = Range<To>::MIN;
    else
        ret_min = static_cast<To>(range.min);

    if (range.max == Range<From>::MAX || range.max >= static_cast<BiggerFrom>(Range<To>::MAX))
        ret_max = Range<To>::MAX;
    else
        ret_max = static_cast<To>(range.max);

    return Range<To>(ret_min, ret_max);
}

template <typename T> struct ContextualRange {
    friend class RangeResult;

private:
    std::unordered_map<BasicBlock *, Range<T>> context_map;
    Range<T> global;

    bool updateGlobal(const Range<T> &range) {
        if (range.isFull())
            return false;
        if (global.intersect(range)) {
            for (auto &[bb, range] : context_map)
                range.intersect(global);
            return true;
        }
        return false;
    }

    bool updateContextual(const Range<T> &range, BasicBlock *bb) {
        if (range.isFull())
            return false;
        if (range.contains(global))
            return false;

        return context_map[bb].intersect(range);
    }

    bool mergeGlobal(const Range<T> &range) {
        if (global.merge(range)) {
            for (auto &[bb, range] : context_map)
                range.merge(global);
            return true;
        }
        return false;
    }

    bool mergeContextual(const Range<T> &range, BasicBlock *bb) { return context_map[bb].merge(range); }

public:
    ContextualRange() = default;
    const Range<T> &getContextual(BasicBlock *bb) const {
        auto it = context_map.find(bb);
        if (it == context_map.end())
            return global;
        return it->second;
    }
    const Range<T> &getGlobal() const { return global; }
};

using IRng = Range<int>;
using ICtxRng = ContextualRange<int>;
using FRng = Range<float>;
using FCtxRng = ContextualRange<float>;

class RangeResult {
    friend class RangeAnalysis;

    std::unordered_map<Value *, ICtxRng> int_range_map;
    std::unordered_map<Value *, FCtxRng> float_range_map;

public:
    RangeResult() = default;

    IRng getIntRange(Value *val) const;
    IRng getIntRange(const pVal &val) const;

    IRng getIntRange(Value *val, BasicBlock *bb) const;
    IRng getIntRange(const pVal &val, const pBlock &bb) const;
    FRng getFloatRange(Value *val) const;
    FRng getFloatRange(const pVal &val) const;

    FRng getFloatRange(Value *val, BasicBlock *bb) const;
    FRng getFloatRange(const pVal &val, const pBlock &bb) const;

    bool knownNonNegative(Value *val) const;
    bool knownNonNegative(const pVal &val) const;
    bool knownNonNegative(Value *val, BasicBlock *bb) const;
    bool knownNonNegative(const pVal &val, const pBlock &bb) const;

private:
    bool update(Value *val, const IRng &range);
    bool update(Value *val, const IRng &range, BasicBlock *bb);

    bool update(Value *val, const FRng &range);
    bool update(Value *val, const FRng &range, BasicBlock *bb);

    bool merge(Value *val, const IRng &range);
    bool merge(Value *val, const IRng &range, BasicBlock *bb);

    bool merge(Value *val, const FRng &range);
    bool merge(Value *val, const FRng &range, BasicBlock *bb);
};

class RangeAnalysis : public PM::AnalysisInfo<RangeAnalysis> {
public:
    RangeResult run(Function &f, FAM &fpm);

private:
    void analyzeArgument(RangeResult &res, Function *func, FAM *fam);
    void analyzeGlobal(RangeResult &res, Function *func, FAM *fam);
    void analyzeContextual(RangeResult &res, Function *func, FAM *fam);

public:
    using Result = RangeResult;

private:
    friend AnalysisInfo<RangeAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif