#pragma once
#ifndef GNALC_MIRTOOLS_TOOL_HPP
#define GNALC_MIRTOOLS_TOOL_HPP

#include "../../include/ir/instruction.hpp"
#include "../../include/mir/instruction.hpp"
#include "enum_name.hpp"

#include <map>
#include <string>
#include <variant>

namespace MIR {

struct variant_toString {
    std::string operator()(int val) { return std::to_string(val); }
    std::string operator()(size_t val) { return std::to_string(val); }
    std::string operator()(float val) { return std::to_string(val); }
};

struct variant_visitor {

    template <typename T_enum>
    std::string operator()(T_enum emVal) {
        return enum_name(emVal);
    }

}; // for std::visit() when come into an enum type

// extern std::map<IR::OP, MIR::OpCode> OPmap;

constexpr int popcount_wrapper(unsigned val) {
    return __builtin_popcount(val);
}

constexpr int clz_wrapper(unsigned val) {
    return __builtin_clz(val);
}

constexpr int ctz_wrapper(unsigned val) {
    return __builtin_ctz(val);
}

///@note 般的中端的同名检查, 但是根据clang-tidy的提示去掉了const
template <typename T>
std::list<std::shared_ptr<T>>
WeaktoSharedList(const std::list<std::weak_ptr<T>> &weak_list) {
    std::list<std::shared_ptr<T>> shared_list;
    for (const auto &weakp : weak_list) {
        auto sharedp = weakp.lock();
        if (sharedp) {
            shared_list.push_back(sharedp);
        } else {
            Err::error("WeaktoSharedList(): element is expired.");
        }
    }
    return shared_list;
}

} // namespace MIR

#endif