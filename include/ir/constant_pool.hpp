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
        std::variant<bool, char, int, float> value;

        bool is_i1() const {return value.index() == 0;}
        bool is_i8() const {return value.index() == 1;}
        bool is_i32() const {return value.index() == 2;}
        bool is_float() const {return value.index() == 3;}

        bool get_i1() const {return std::get<bool>(value);}
        bool get_i8() const {return std::get<char>(value);}
        int get_i32() const {return std::get<int>(value);}
        float get_float() const {return std::get<float>(value);}

        std::string type_name() const {
            if (value.index() == 0)
                return "i";
            else if (value.index() == 1)
                return "i8";
            else if (value.index() == 2)
                return "i32";
            else if (value.index() == 3)
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

    std::shared_ptr<ConstantI1> getConst(bool val);

    std::shared_ptr<ConstantI8> getConst(char val);

    std::shared_ptr<ConstantInt> getConst(int val);

    std::shared_ptr<ConstantFloat> getConst(float val);

    int cleanPool();

    ~ConstantPool();
};

}



#endif