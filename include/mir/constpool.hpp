#pragma once
#ifndef GNALC_MIR_CONSTPOOL_HPP
#define GNALC_MIR_CONSTPOOL_HPP
#include "misc.hpp"
#include "operand.hpp"
#include <unordered_map>

namespace MIR {

class ConstPool {
private:
    class ConstVal {
    public:
        ConstVal() = delete;
        explicit ConstVal(const std::string &imme) : value(imme) {}
        explicit ConstVal(int imme) : value(imme) {}
        explicit ConstVal(float imme) : value(imme) {}
        explicit ConstVal(bool imme) : value(imme) {}
        explicit ConstVal(char imme) : value(imme) {}

        std::variant<std::string, int, float, bool, char> value;

        unsigned int getType() const { return value.index(); }

        bool operator==(const ConstVal &another) const {
            return another.value == value;
        }
    };

    struct ConstPoolHash {
        static size_t variant_hash(
            const std::variant<std::string, int, float, bool, char> &val) {
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

    std::shared_ptr<ConstObj> getConstant(const std::string &imme);

    template <typename T_variant> /* int, float, char, bool */
    std::shared_ptr<ConstObj> getConstant(T_variant imme) {
        ConstVal temp(imme);

        auto it = pool.find(temp);
        if (it == pool.end()) {
            std::shared_ptr<ConstObj> constant =
                std::make_shared<ConstObj>(pool.size(), imme);
            it = pool.emplace(temp, constant).first;
        }

        return it->second;
    }

    ~ConstPool() = default;
};
} // namespace MIR

#endif