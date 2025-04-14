#pragma once
#ifndef GNALC_MIRTOOLS_TOOL_HPP
#define GNALC_MIRTOOLS_TOOL_HPP

#include "mir/instruction.hpp"
#include "enum_name.hpp"

#include <string>

namespace MIR {

constexpr int popcount_wrapper(unsigned val) { return __builtin_popcount(val); }

constexpr int clz_wrapper(unsigned val) { return __builtin_clz(val); }

constexpr int ctz_wrapper(unsigned val) { return __builtin_ctz(val); }

bool isImmCanBeEncodedInText(unsigned int);

///@note 获取一个大于imme的最小8bits位图数
int ceilEncoded(int);

bool isImmCanBeEncodedInText(float);

struct variant_const_toString {
    std::string operator()(const int &val) const;
    std::string operator()(const size_t &val) const;
    std::string operator()(const float &val) const;
};

struct variant_opcode_toString {
    std::string operator()(const OpCode &opcode) const;
    std::string operator()(const NeonOpCode &opcode) const;
};

struct variant_reg_toString {

    std::string operator()(CoreRegister emVal);
    std::string operator()(FPURegister emVal);

}; // for std::visit() when come into an enum type

// extern std::map<IR::OP, MIR::OpCode> OPmap;

///@note 般的中端的同名检查, 但是根据clang-tidy的提示去掉了const
template <typename T> std::list<std::shared_ptr<T>> WeaktoSharedList(const std::list<std::weak_ptr<T>> &weak_list) {
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