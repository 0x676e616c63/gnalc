// Contextual Value Range Analysis
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_RANGE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_RANGE_ANALYSIS_HPP

#include "ir/base.hpp"
#include "ir/passes/pass_manager.hpp"

#include <optional>
#include <unordered_map>
#include <vector>

namespace IR {
// [ min, max )
template <typename T> struct Range {
    static constexpr auto MAX = std::numeric_limits<T>::max();
    static constexpr auto MIN = std::numeric_limits<T>::min();

    T min;
    T max;

    Range() : min(MIN), max(MAX) {}
    Range(T a) : min(a), max(a) {}
    Range(T min_, T max_) : min(min_), max(max_) {}

    bool overlap(const Range &item) const { return min <= item.max && max >= item.min; }

    std::optional<T> getExact() const {
        if (min == max)
            return min;
        return std::nullopt;
    }

    bool operator==(const Range &item) const { return min == item.min && max == item.max; }

    Range operator+(const Range &item) const {
        T ret_min, ret_max;
        if (min == MIN || item.min == MIN)
            ret_min = MIN;
        else
            ret_min = min + item.min;

        if (max == MAX || item.max == MAX)
            ret_max = MAX;
        else
            ret_max = max + item.max;
        return {ret_min, ret_max};
    }

    Range operator-(const Range &item) const {
        T ret_min, ret_max;
        if (min == MIN || item.max == MAX)
            ret_min = MIN;
        else
            ret_min = min - item.max;

        if (max == MAX || item.min == MIN)
            ret_max = MAX;
        else
            ret_max = max - item.min;

        return {ret_min, ret_max};
    }

    Range operator*(const Range &item) const {
        if ((min == 0 && max == 0) || (item.min == 0 && item.max == 0))
            return {0, 0};
        if (min == MIN || max == MAX || item.min == MIN || item.max == MAX) {
            if (min == MIN) {
                if (item.min > 0)
                    return {MIN, (max == MAX) ? MAX : max * item.max};
                if (item.max < 0)
                    return {(max == MAX) ? MIN : max * item.min, MAX};
            }
            if (max == MAX) {
                if (item.min > 0)
                    return {(min == MIN) ? MIN : min * item.min, MAX};
                if (item.max < 0)
                    return {MIN, (min == MIN) ? MAX : max * item.max};
            }
            if (item.min == MIN) {
                if (min > 0)
                    return {MIN, (item.max == MAX) ? MAX : max * item.max};
                if (max < 0)
                    return {(item.max == MAX) ? MIN : min * item.min, MAX};
            }
            if (item.max == MAX) {
                if (min > 0)
                    return {(item.min == MIN) ? MIN : min * item.min, MAX};
                if (max < 0)
                    return {MIN, (item.min == MIN) ? MAX : max * item.max};
            }

            return {MIN, MAX};
        }

        auto p = (std::min)((std::min)(min * item.min, max * item.min), (std::min)(min * item.max, max * item.max));
        auto q = (std::max)((std::max)(min * item.min, max * item.min), (std::max)(min * item.max, max * item.max));
        return {p, q};
    }
    Range operator/(const Range &item) const {
        if (min == 0 && max == 0)
            return {0, 0};

        if ((item.min <= 0 && item.max >= 0) || min == MIN || max == MAX || item.min == MIN || item.max == MAX)
            return {MIN, MAX};

        auto p = (std::min)((std::min)(min / item.min, max / item.min), (std::min)(min / item.max, max / item.max));
        auto q = (std::max)((std::max)(min / item.min, max / item.min), (std::max)(min / item.max, max / item.max));
        return {p, q};
    }

    Range operator%(const Range &item) const {
        if ((min == 0 && max == 0) || (min == 1 && max == 1))
            return {0, 0};

        if (item.containsZero() || min == MIN || max == MAX || item.min == MIN || item.max == MAX) {
            return {MIN, MAX};
        }

        if (item.min > 0) {
            if (min >= 0)
                return {0, item.max}; // [0, b)

            if (max <= 0)
                return {-(item.max - 1), 1}; // [-(b-1), 1)

            T m = item.max - 1;
            return {-m, m + 1}; // [-m, m+1) -> [-m, m]
        }

        if (item.max < 0) {
            T abs_max = -item.min;
            if (min >= 0)
                return {0, abs_max + 1}; // [0, |dmin|+1)
            if (max <= 0)
                return {-(abs_max - 1), 1};   // [-(|dmin|-1), 1)
            return {-(abs_max - 1), abs_max}; // [-(|dmin|-1), |dmin|)
        }
        return {MIN, MAX};
    }

    Range operator-() const {
        T ret_min, ret_max;
        if (max == MAX)
            ret_min = MIN;
        else
            ret_min = -(max - 1);

        if (min == MIN)
            ret_max = MAX;
        else
            ret_max = -min + 1;
        return {ret_min, ret_max};
    }

    bool containsZero() const { return min <= T(0) && max >= T(0); }

    bool merge(const Range &item) {
        if (*this == item)
            return false;
        min = (std::min)(min, item.min);
        max = (std::max)(max, item.max);
        return true;
    }
    bool intersect(const Range &item) {
        if (*this == item)
            return false;
        min = (std::max)(min, item.min);
        max = (std::min)(max, item.max);
        return true;
    }
    bool contains(const Range &item) { return min <= item.min && max >= item.max; }

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
};
template <typename T> Range<T> merge(const Range<T> &a, const Range<T> &b) {
    return {(std::min)(a.min, b.min), (std::max)(a.max, b.max)};
}

template <typename T> Range<T> intersect(const Range<T> &a, const Range<T> &b) {
    return {(std::max)(a.min, b.min), (std::min)(a.max, b.max)};
}

template <typename T> struct ContextualRange {
    friend class RangeResult;

private:
    std::unordered_map<BasicBlock *, Range<T>> context_map;
    Range<T> global;

    bool updateGlobal(const Range<T> &range) {
        if (global.intersect(range)) {
            for (auto &[bb, range] : context_map)
                range.intersect(global);
            return true;
        }
        return false;
    }

    bool updateContextual(const Range<T> &range, BasicBlock *bb) {
        if (global.contains(range))
            return false;

        return context_map[bb].intersect(range);
    }

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

class RangeResult {
    friend class RangeAnalysis;

    std::unordered_map<Value *, ContextualRange<int>> int_range_map;
    std::unordered_map<Value *, ContextualRange<float>> float_range_map;
public:
    RangeResult() = default;

    Range<int> getIntRange(Value *val) const {
        if (auto ci32 = val->as<ConstantInt>())
            return Range<int>(ci32->getVal());
        if (auto ci1 = val->as<ConstantI1>())
            return Range<int>(ci1->getVal());
        if (auto ci8 = val->as<ConstantI8>())
            return Range<int>(ci8->getVal());
        auto it = int_range_map.find(val);
        if (it == int_range_map.end())
            return Range<int>();
        return it->second.getGlobal();
    }
    Range<int> getIntRange(const pVal &val) const { return getIntRange(val.get()); }

    Range<int> getIntRange(Value *val, BasicBlock *bb) const {
        if (auto ci32 = val->as<ConstantInt>())
            return Range<int>(ci32->getVal());
        if (auto ci1 = val->as<ConstantI1>())
            return Range<int>(ci1->getVal());
        if (auto ci8 = val->as<ConstantI8>())
            return Range<int>(ci8->getVal());
        auto it = int_range_map.find(val);
        if (it == int_range_map.end())
            return Range<int>();
        return it->second.getContextual(bb);
    }
    Range<int> getIntRange(const pVal &val, const pBlock &bb) const { return getIntRange(val.get(), bb.get()); }

    Range<float> getFloatRange(Value *val) const {
        if (auto ci32 = val->as<ConstantFloat>())
            return Range<float>(ci32->getVal());

        auto it = float_range_map.find(val);
        if (it == float_range_map.end())
            return Range<float>();
        return it->second.getGlobal();
    }
    Range<float> getFloatRange(const pVal &val) const { return getFloatRange(val.get()); }

    Range<float> getFloatRange(Value *val, BasicBlock *bb) const {
        if (auto ci32 = val->as<ConstantFloat>())
            return Range<float>(ci32->getVal());

        auto it = float_range_map.find(val);
        if (it == float_range_map.end())
            return Range<float>();
        return it->second.getContextual(bb);
    }
    Range<float> getFloatRange(const pVal &val, const pBlock &bb) const { return getFloatRange(val.get(), bb.get()); }

private:
    bool update(Value *val, const Range<int> &range) { return int_range_map[val].updateGlobal(range); }
    bool update(Value *val, const Range<int> &range, BasicBlock *bb) {
        if (auto inst = val->as_raw<Instruction>()) {
            if (inst->getParent().get() == bb) {
                return update(inst, range);
            }
        }
        return int_range_map[val].updateContextual(range, bb);
    }

    bool update(Value *val, const Range<float> &range) { return float_range_map[val].updateGlobal(range); }
    bool update(Value *val, const Range<float> &range, BasicBlock *bb) {
        if (auto inst = val->as_raw<Instruction>()) {
            if (inst->getParent().get() == bb) {
                return update(inst, range);
            }
        }
        return float_range_map[val].updateContextual(range, bb);
    }
};

class RangeAnalysis : public PM::AnalysisInfo<RangeAnalysis> {
public:
    RangeResult run(Function &f, FAM &fpm);

private:
    void analyzeArgument(RangeResult& res, Function* func, FAM* fam);
    void analyzeGlobal(RangeResult& res, Function* func, FAM* fam);
    void analyzeContextual(RangeResult& res, Function* func, FAM* fam);

public:
    using Result = RangeResult;

private:
    friend AnalysisInfo<RangeAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif