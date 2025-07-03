// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Generic Pattern Match Utility for Peephole
#pragma once
#ifndef GNALC_PATTERN_MATCH_MATCH_HPP
#define GNALC_PATTERN_MATCH_MATCH_HPP

#include "utils/misc.hpp"

#include <functional>
#include <memory>
#include <type_traits>

namespace Match {
namespace detail {
// This checks if the type is a std::shared_ptr<xxx>
template <typename T>
constexpr bool IsSharedPtr = Util::is_specialization_of_v<Util::remove_cvref_t<T>, std::shared_ptr>;

// This checks if the type is a raw pointer
template <typename T> constexpr bool IsRawPtr = std::is_pointer_v<Util::remove_cvref_t<T>>;

template <typename T> constexpr bool IsPtr = IsSharedPtr<T> || IsRawPtr<T>;

// We assume client code is using pointer to polymorphic types.
// This function downcasts polymorphic pointers (raw or shared_ptr) using dynamic_cast.
template <typename To, typename From> auto ptrCast(const From &v) {
    static_assert(IsPtr<From>, "Expected a pointer.");
    if constexpr (IsSharedPtr<From>) {
        return std::dynamic_pointer_cast<To>(v);
    } else {
        return dynamic_cast<To *>(v);
    }
}

// Identity Projection
// Projection is used in xxxBind Match, for extracting elements from the matched value.
// For more details, see `ClassMatchBindIf`
struct Identity {
    template <typename T> auto operator()(T &&v) const { return std::forward<T>(v); }
};
} // namespace detail

// Entry point for pattern match
template <typename Cand, typename Pattern> bool match(const Cand &candidate, const Pattern &pattern) {
    return pattern.match(candidate);
}

template <typename Cand, typename ...Patterns>
bool match(const Cand &candidate, const Patterns &...patterns) {
    return (match(candidate, patterns) && ...);
}

// The following is generic matches, which is designed to be wrapped for IR/MIR conveniently.
// Client code can also write its own Pattern from scratch.
// A Pattern should contain a template function `match` that returns a bool,
// indicating if a pattern is matched successfully in the given value.
//
// For example, we can write a pattern to match an IR::Value with only one user, (which is
// helpful in some passes.)
//
// template <typename SubPattern> struct OneUseMatch {
//     SubPattern sub_pattern;
//
//     explicit OneUseMatch(const SubPattern &sub_pattern_) : sub_pattern(sub_pattern_) {}
//
//     template <typename T> bool match(const T &v) const {
//         auto cast = PatternMatch::detail::ptrCast<Value>(v);
//         return cast && cast->getUseCount() == 1 && sub_pattern.match(cast);
//     }
// };
//
// Using `PatternMatch::detail::ptrCast` can make the pattern supports both std::shared_ptr
// and raw pointer. After Casting, simply checks the use count and transfer to the sub_pattern.
// Note that the sub_pattern is optional, but with that, multiple nested pattern can be created.
// For example, we can match an `IR::FNEGInst` with a one use operand.
// if (match(inst, M::Fneg(M::OneUse(M::Inst()))))
//
// M::OneUse are just convenient wrappers for OneUseMatch, for example,
// template <typename T> auto OneUse(const T &sub_pattern) { return OneUseMatch(sub_pattern); }
//
// The OneUseMatch is specific to IR, so it lies in `ir/pattern_match.hpp`. Below are
// generic patterns that helps IR/MIR creates patterns easily.

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

// Class Match, binding the matched value to the given reference.
//
// The third template parameter is a projection, which is used to extract
// something from the value we matched. This enables client code extract `T` from `U`.
//
// For example, an IR Constant Projection to C++ constant types (int, float, bool, ...)
// template <typename T> struct ConstantProj {
//     template <typename U> T operator()(const U &u) { return u->getVal(); }
// };
// We matched a `IR::ConstantXXX` in a given IR::Value, and use the projection
// to project the `IR::ConstantXXX` to a C++ type.
//
//
// Client Code Example:
//
// int step_val;
// if (!match(step->getIRValue(), M::Bind(step_val)))
//
// M::Bind is a helper function specialized for IR, which is a
// wrapper for ClassMatchBind, with a projection for IR::Constant.
//
// The step->getIRValue() is a IRValue (std::shared_ptr<IR::Value>) that contains IR::Constant,
// but we can match and bind it to a C++ int&.
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
// Almost the same as ClassMatchBind, but with a predicate.
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
//
// InstInfo provides methods for getting instruction information.
//
// For example,
// struct IRInstInfo {
//     using InstType = Instruction;
//     using OpcodeType = OP;
//     struct NumOperandsGetter {
//         size_t operator()(const Instruction &inst) { return inst.getNumOperands(); }
//     };
//     struct OperandGetter {
//         auto operator()(const Instruction &inst, size_t idx) { return inst.getOperand(idx)->getValue(); }
//     };
//     struct OpcodeGetter {
//         OP operator()(const Instruction &inst) { return inst.getOpcode(); }
//     };
// };
//
// FIXME: Maybe a InstTrait/InstInfo like `GraphInfo` in `inclue/graph/graph.hpp` is better.
//
// An important behavior of InstMatch is that it matches the operands from left to right.
// This enables lazy binding in client code. For details, see `Is` in `ir/pattern_match.hpp`
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
