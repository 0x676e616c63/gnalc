// Generic Pattern Match Utility for Peephole
#pragma once
#ifndef GNALC_PATTERN_MATCH_PATTERN_MATCH_HPP
#define GNALC_PATTERN_MATCH_PATTERN_MATCH_HPP

#include "utils/misc.hpp"

#include <functional>
#include <memory>
#include <type_traits>

namespace PatternMatch {
namespace detail {
template <typename T>
constexpr bool IsSharedPtr = Util::is_specialization_of_v<Util::remove_cvref_t<T>, std::shared_ptr>;

template <typename T> constexpr bool IsRawPtr = std::is_pointer_v<Util::remove_cvref_t<T>>;

template <typename T> constexpr bool IsPtr = IsSharedPtr<T> || IsRawPtr<T>;

template <typename To, typename From> auto ptrCast(const From &v) {
    static_assert(IsPtr<From>, "Expected a pointer.");
    if constexpr (IsSharedPtr<From>) {
        return std::dynamic_pointer_cast<To>(v);
    } else {
        return dynamic_cast<To *>(v);
    }
}

struct Identity {
    template <typename T> auto operator()(T &&v) const { return std::forward<T>(v); }
};
} // namespace detail

template <typename Cand, typename Pattern> bool match(const Cand &candidate, const Pattern &pattern) {
    return pattern.match(candidate);
}

// Class Match, match a certain class using dynamic_cast/std::dynamic_pointer_cast
template <typename Class> struct ClassMatch {
    template <typename T> bool match(const T &v) const { return detail::ptrCast<Class>(v) != nullptr; }
};

// Classes Match, match certain classes
template <typename... Classes> struct ClassesMatch {
    template <typename T> bool match(const T &v) const { return (ClassMatch<Classes>{}.match(v) || ...); }
};

// Class Match, with a predicate
template <typename Class> struct ClassMatchIf {
    std::function<bool(const Class &)> pred;

    explicit ClassMatchIf(const std::function<bool(const Class &)> &pred_) : pred(pred_) {}

    template <typename T> bool match(const T &v) const {
        auto cast = detail::ptrCast<Class>(v);
        return cast && pred(*cast);
    }
};

// Class Match, binding the matched value.
template <typename Class, typename ResultT, typename Proj = detail::Identity> struct ClassMatchBind {
    ResultT &result;

    explicit ClassMatchBind(ResultT &result_) : result(result_) {}

    template <typename T> bool match(const T &v) const {
        auto cast = detail::ptrCast<Class>(v);
        if (!cast)
            return false;
        result = Proj()(cast);
        return true;
    }
};

// Class Match, with a predicate and binding the matched value.
template <typename Class, typename ResultT, typename Proj = detail::Identity> struct ClassMatchBindIf {
    ResultT &result;
    std::function<bool(const Class &)> pred;

    explicit ClassMatchBindIf(const std::function<bool(const Class &)> &pred_, ResultT &result_)
        : pred(pred_), result(result_) {}

    template <typename T> bool match(const T &v) const {
        auto cast = detail::ptrCast<Class>(v);
        if (!cast)
            return false;
        result = Proj()(cast);
        return pred(*cast);
    }
};

// Generic Instruction Match, matching instructions' opcode and operands
// Requirement:
//   InstInfo should have `OpcodeType`, `InstType`, `NumOperandsGetter`, `OperandGetter`, `OpcodeGetter`
template <typename InstInfo, typename InstInfo::OpcodeType opcode, typename... OperandPatterns> struct InstMatch {
    using BaseInstType = typename InstInfo::InstType;
    using NumOperandsGetter = typename InstInfo::NumOperandsGetter;
    using OperandGetter = typename InstInfo::OperandGetter;
    using OpcodeGetter = typename InstInfo::OpcodeGetter;

    std::tuple<OperandPatterns...> operand_patterns;

    explicit InstMatch(const OperandPatterns &...ops) : operand_patterns(ops...) {}

    template <size_t curr, size_t end>
    std::enable_if_t<curr != end, bool> matchOperands(const BaseInstType &candidate) const {
        // Note that we must match `curr` first, and then `curr + 1`
        // In other words, the order of matching should be from left to right.
        // IR::M::Is relies on this behavior, see comments in `ir/pattern_match.hpp`
        return matchOperands<curr, curr>(candidate) && matchOperands<curr + 1, end>(candidate);
    }

    template <size_t curr, size_t end>
    std::enable_if_t<curr == end, bool> matchOperands(const BaseInstType &candidate) const {
        return std::get<curr>(operand_patterns).match(OperandGetter()(candidate, curr));
    }

    template <typename T> bool match(const T &v) const {
        if (auto inst = detail::ptrCast<BaseInstType>(v)) {
            return OpcodeGetter()(*inst) == opcode && NumOperandsGetter()(*inst) == sizeof...(OperandPatterns) &&
                   matchOperands<0, sizeof...(OperandPatterns) - 1>(*inst);
        }
        return false;
    }
};
} // namespace PatternMatch

#endif // PATTERN_MATCH_HPP
