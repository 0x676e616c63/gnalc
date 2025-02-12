#pragma once
#ifndef GNALC_MIR_CONSTPOOL_HPP
#include "misc.hpp"
#include "operand.hpp"
#include <unordered_map>

namespace MIR {

class ConstPool {
private:
    struct ConstVal {
        std::variant<int, float, std::string> value;

        unsigned int getType() const { return value.index(); }

        bool operator==(const ConstVal &another) const {
            return another.value == value;
        }
    };

    struct ConstPoolHash {
        static size_t
        variant_hash(const std::variant<int, float, std::string> &val) {
            return std::hash<
                std::remove_cv_t<std::remove_reference_t<decltype(val)>>>()(
                val);
        }

        size_t operator()(const ConstVal &constant) const {
            return std::hash<unsigned int>()(constant.getType()) ^
                   std::visit(variant_hash, constant.value);
        }
    };

    std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash> pool;

public:
    ConstPool() = default;

    template <typename T_variant>
    std::shared_ptr<ConstObj> getConstant(const T_variant &);

    ~ConstPool() = default;
};
} // namespace MIR

#endif