/**
 * @brief 包含通用的Type, Name类
 */

#ifndef GNALC_IR_TYPE_H
#define GNALC_IR_TYPE_H
#pragma once
#include <string>

namespace IR {

    enum class _type { INT, FLOAT, VOID };

    using NameParam = std::string;

    /**
     * @todo 使用模板？
     */
    class Type {
        _type tp;

    public:
        explicit Type(const _type t) : tp(t) {}

        void setType(const _type t) { tp = t; }
        bool isVoid() const { return tp == _type::VOID; }
        bool isFloat() const { return tp == _type::FLOAT; }
        bool isInt() const { return tp == _type::INT; }
        _type getType() const { return tp; }
    };

    class Name {
    private:
        std::string _name;

    public:
        Name() = default;

        explicit Name(NameParam name) : _name(std::move(name)) {}

        void setName(NameParam name) { _name = std::move(name); }
        bool isName(const NameParam& name) const { return _name == name; }
        std::string getName() { return _name; }
    };
}

#endif
