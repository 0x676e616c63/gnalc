#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_RANGE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_RANGE_ANALYSIS_HPP

#include "ir/base.hpp"
#include "ir/passes/pass_manager.hpp"

#include <unordered_map>
#include <optional>
#include <vector>

namespace IR {
// [ min, max )
struct Range {
    ConstantProxy min;
    ConstantProxy max;

    Range(const ConstantProxy &a) : min(a), max(a) {}
    Range(ConstantProxy min_, ConstantProxy max_) : min(std::move(min_)), max(std::move(max_)) {}

    bool overlap(const Range &item) const { return min <= item.max && max >= item.min; }

    std::optional<ConstantProxy> getExactConstant() const {
        if (min == max)
            return min;
        return std::nullopt;
    }

    std::pair<int, int> getIntRange() const { return {min.get_int(), max.get_int()}; }

    std::pair<float, float> getFloatRange() const { return {min.get_float(), max.get_float()}; }

    bool operator==(const Range &item) const { return min == item.min && max == item.max; }

    Range operator+(const Range &item) const { return {min + item.min, max + item.max}; }
    Range operator-(const Range &item) const { return {min - item.max, max - item.min}; }
    Range operator-() const { return {-max, -min}; }
    Range operator*(const Range &item) const {
        auto p = std::min(std::min(min * item.min, max * item.min), std::min(min * item.max, max * item.max));
        auto q = std::max(std::max(min * item.min, max * item.min), std::max(min * item.max, max * item.max));
        return {p, q};
    }
    Range operator/(const Range &item) const {
        auto p = std::min(std::min(min / item.min, max / item.min), std::min(min / item.max, max / item.max));
        auto q = std::max(std::max(min / item.min, max / item.min), std::max(min / item.max, max / item.max));
        return {p, q};
    }

    bool containsZero() const {
        if (auto min_ci32 = min.getConstant()->as<ConstantInt>()) {
            auto max_ci32 = max.getConstant()->as<ConstantInt>();
            return min_ci32->getVal() <= 0 && max_ci32->getVal() >= 0;
        }
        if (auto min_cf32 = min.getConstant()->as<ConstantFloat>()) {
            auto max_cf32 = max.getConstant()->as<ConstantFloat>();
            return min_cf32->getVal() <= 0.0f && max_cf32->getVal() >= 0.0f;
        }
        if (auto min_ci8 = min.getConstant()->as<ConstantI8>()) {
            auto max_ci8 = max.getConstant()->as<ConstantI8>();
            return min_ci8->getVal() <= 0 && max_ci8->getVal() >= 0;
        }
        if (auto min_ci1 = min.getConstant()->as<ConstantI1>()) {
            auto max_ci1 = max.getConstant()->as<ConstantI1>();
            return !min_ci1->getVal() || !max_ci1->getVal();
        }
        return true;
    }
};

class RangeResult {
    std::unordered_map<pVal, Range> range_map;
public:
    RangeResult() = default;

    const Range& getRange(const pVal &val) const { return range_map.at(val); }
};

class RangeAnalysis : public PM::AnalysisInfo<RangeAnalysis> {
public:
    RangeResult run(Function &f, FAM &fpm);

public:
    using Result = RangeResult;

private:
    friend AnalysisInfo<RangeAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif