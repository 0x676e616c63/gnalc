#pragma once
#ifndef GNALC_IR_CONSTANTPOOL_HPP
#define GNALC_IR_CONSTANTPOOL_HPP

#include <unordered_map>
#include <variant>
#include <type_traits>

#include "constant.hpp"
#include "../utils/exception.hpp"

namespace IR
{
class ConstantPool {
private:
    struct ConstantValue {
        // TODO: Array
        std::variant<int, float> value;

        bool is_int() const {return value.index() == 0;}
        bool is_float() const {return value.index() == 1;}

        int get_int() const {return std::get<int>(value);}
        float get_float() const {return std::get<float>(value);}

        std::string type_name() const {
            if (value.index() == 0)
                return "int";
            else if (value.index() == 1)
                return "float";
            return "";
        }

        bool operator==(const ConstantValue &other) const {return value == other.value;}
    };

    struct ConstantHash {
        std::size_t operator()(const ConstantValue& constant) const {
            return std::hash<std::string>()(constant.type_name())
                    ^ std::visit([](auto&& c)
                        {return std::hash<std::remove_cv_t<std::remove_reference_t<decltype(c)>>>()(c);},
                        constant.value);
        }
    };

    std::unordered_map<ConstantValue, std::shared_ptr<Value>, ConstantHash> pool;

public:
    ConstantPool() = default;

    std::shared_ptr<ConstantInt> getConst(int val) {
        auto value = ConstantValue{val};
        auto it = pool.find(value);
        if (it == pool.end())
        {
            auto ret = std::make_shared<ConstantInt>(val);
            pool[value] = ret;
            return ret;
        }
        return std::dynamic_pointer_cast<ConstantInt>(it->second);
    }

    std::shared_ptr<ConstantFloat> getConst(float val) {
        auto value = ConstantValue{val};
        auto it = pool.find(value);
        if (it == pool.end())
        {
            auto ret = std::make_shared<ConstantFloat>(val);
            pool[value] = ret;
            return ret;
        }
        return std::dynamic_pointer_cast<ConstantFloat>(it->second);
    }

    int cleanPool() {
        int count = 0;
        for (auto it = pool.begin(); it != pool.end();) {
            if (it->second.use_count() == 1) { // 只有常量池持有引用
                it = pool.erase(it);
                count++;
            } else {
                ++it;
            }
        }
        return count;
    }


    ~ConstantPool() {
        cleanPool();
        Err::gassert(pool.empty(), "ConstantPool is not empty when destroyed.");
    };
};

}



#endif