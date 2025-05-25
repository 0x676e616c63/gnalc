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
template <typename T>
struct Range {
    static constexpr auto MAX = std::numeric_limits<T>::max();
    static constexpr auto MIN = std::numeric_limits<T>::min();

    T min;
    T max;

    Range(): min(MIN), max(MAX) {}
    Range(T a) : min(a), max(a) {}
    Range(T min_, T max_) : min(min_), max(max_) {}

    bool overlap(const Range &item) const { return min <= item.max && max >= item.min; }

    std::optional<T> getExact() const {
        if (min == max)
            return min;
        return std::nullopt;
    }

    bool operator==(const Range &item) const { return min == item.min && max == item.max; }

    Range operator+(const Range &item) const { return {min + item.min, max + item.max}; }
    Range operator-(const Range &item) const { return {min - item.max, max - item.min}; }
    Range operator-() const { return {-max, -min}; }
    Range operator*(const Range &item) const {
        auto p = (std::min)((std::min)(min * item.min, max * item.min), (std::min)(min * item.max, max * item.max));
        auto q = (std::max)((std::max)(min * item.min, max * item.min), (std::max)(min * item.max, max * item.max));
        return {p, q};
    }
    Range operator/(const Range &item) const {
        auto p = (std::min)((std::min)(min / item.min, max / item.min), (std::min)(min / item.max, max / item.max));
        auto q = (std::max)((std::max)(min / item.min, max / item.min), (std::max)(min / item.max, max / item.max));
        return {p, q};
    }
    Range operator%(const Range &item) const {
        // FIXME: Precise
        return Range();
    }

    bool containsZero() const {
        return min <= T(0) && max >= T(0);
    }

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
    bool contains(const Range &item) {
        return min <= item.min && max >= item.max;
    }
};
template  <typename T>
Range<T> merge(const Range<T> &a, const Range<T> &b) {
    return {(std::min)(a.min, b.min), (std::max)(a.max, b.max)};
}

template <typename T>
Range<T> intersect(const Range<T> &a, const Range<T> &b){
    return {(std::max)(a.min, b.min), (std::min)(a.max, b.max)};
}

template <typename T>
struct ContextualRange {
    friend class RangeResult;
private:
    std::unordered_map<BasicBlock*, Range<T>> context_map;
    Range<T> global;

    bool updateGlobal(const Range<T> &range) {
        if (global.intersect(range)) {
            for (auto &[bb, range] : context_map)
                range.intersect(global);
            return true;
        }
        return false;
    }

    bool updateContextual(const Range<T> &range, BasicBlock* bb) {
        if (global.contains(range))
            return false;

        return context_map[bb].intersect(range);
    }
public:
    const Range<T>& getContextual(BasicBlock* bb) const {
        auto it = context_map.find(bb);
        if (it == context_map.end())
            return global;
        return it->second;
    }
    const Range<T>& getGlobal() const {
        return global;
    }
};

class RangeResult {
    friend class RangeAnalysis;

    std::unordered_map<Value*, ContextualRange<int>> int_range_map;
    std::unordered_map<Value*, ContextualRange<float>> float_range_map;
public:
    RangeResult() = default;

    const Range<int>& getIntRange(Value* val) const {
        return int_range_map.at(val).getGlobal();
    }
    const Range<int>& getIntRange(const pVal &val) const {
        return getIntRange(val.get());
    }

    const Range<int>& getIntRange(Value* val, BasicBlock* bb) const {
        return int_range_map.at(val).getContextual(bb);
    }
    const Range<int>& getIntRange(const pVal &val, const pBlock& bb) const {
        return getIntRange(val.get(), bb.get());
    }

    const Range<float>& getFloatRange(Value* val) const {
        return float_range_map.at(val).getGlobal();
    }
    const Range<float>& getFloatRange(const pVal &val) const {
        return getFloatRange(val.get());
    }

    const Range<float>& getFloatRange(Value* val, BasicBlock* bb) const {
        return float_range_map.at(val).getContextual(bb);
    }
    const Range<float>& getFloatRange(const pVal &val, const pBlock& bb) const {
        return getFloatRange(val.get(), bb.get());
    }

private:
    bool update(Value* val, const Range<int> &range) {
        return int_range_map[val].updateGlobal(range);
    }
    bool update(Value* val, const Range<int> &range, BasicBlock* bb) {
        if (auto inst = val->as_raw<Instruction>()) {
            if (inst->getParent().get() == bb) {
                return update(inst, range);
            }
        }
        return int_range_map[val].updateContextual(range, bb);
    }

    bool update(Value* val, const Range<float> &range) {
        return float_range_map[val].updateGlobal(range);
    }
    bool update(Value* val, const Range<float> &range, BasicBlock* bb) {
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
    FAM * fam;
    Function * func;
    RangeResult res;
    void analyzeArgument();
    void analyzeGlobal();
    void analyzeContextual();
public:
    using Result = RangeResult;

private:
    friend AnalysisInfo<RangeAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif