/**
 * @brief New Type for future refactor
 */

#pragma once
#ifndef GNALC_IR_TYPE_HPP
#define GNALC_IR_TYPE_HPP

#include <memory>
#include <string>
#include <vector>

namespace IR
{
enum class BuiltinType {
    I1,
    I32,
    FLOAT,
    VOID,
    PTR,
    UNDEFINED
};

enum class TypeTrait {
    Array,
    Basic
};

class Type {
public:
    virtual ~Type() = default;
    virtual TypeTrait getTrait() const = 0;
    virtual std::string getTypeName() const = 0;
};

class ArrayType : public Type {
    std::shared_ptr<Type> element_type;
    size_t size;

public:
    ArrayType(std::shared_ptr<Type> element_type, size_t size)
        : element_type(element_type), size(size) {}

    TypeTrait getTrait() const override {
        return TypeTrait::Array;
    }

    std::string getTypeName() const override {
        return "[ " + std::to_string(size) + " x " + element_type->getTypeName() +" ]";
    }
};

class BasicType : public Type {
    BuiltinType type;
public:
    BasicType(BuiltinType type_)
        : type(type_) {}

    TypeTrait getTrait() const override {
        return TypeTrait::Basic;
    }

    std::string getTypeName() const override {
        switch (type) {
        case BuiltinType::I1:
            return "i1";
        case BuiltinType::I32:
            return "i32";
        case BuiltinType::FLOAT:
            return "f32";
        case BuiltinType::VOID:
            return "void";
        case BuiltinType::PTR:
            return "ptr";
        case BuiltinType::UNDEFINED:
            return "undefined";
        }
    }
};
}
#endif