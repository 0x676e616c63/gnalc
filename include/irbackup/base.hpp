/**
 * @file base.hpp
 * @brief IR base class: Value User Use...
 * @todo use std::list?
 */

#ifndef GNALC_IR_BASE_HPP
#define GNALC_IR_BASE_HPP
#pragma once
#include <vector>
#include "type.hpp"


namespace IR {
    class Use;
    /**
     * @todo replace function
     */
    class Value : public Type, public Name {
    protected:
        std::vector<Use *> use_list;

    public:
        Value() = default;
        explicit Value(_type type, NameParam name = "") : Type(type), Name(std::move(name)) {}

        const std::vector<Use *> &getUseList() const;

        void addUse(Use *use);

        void delUse(Use *use);

        virtual ~Value();
    };


    /**
     * @todo find, set by value, del function
     * @todo use "use" pointer?
     */
    class User : public Value {
    protected:
        std::vector<Use> operands; // 操作数

    public:
        explicit User(_type type, NameParam name = "") : Value(type, std::move(name)) { }

        void addOperand(Value *v);

        void setOperand(unsigned i, Value *v);

        Value *getOperand(unsigned i) const;

        unsigned getNumOperands() const;

        ~User() override;
    };


    /**
     * @todo no empty warning
     */
    class Use {
    private:
        Value *val; // 指向被使用的 Value
        User *user; // 指向所属的 User

    public:
        Use(Value *v, User *u);

        void setValue(Value *v);

        void setUser(User *u);

        Value *getValue() const;

        User *getUser() const;

        ~Use();
    };
}

#endif
