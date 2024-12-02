/**
 * @file value.h
 * @brief IR base class: Value User Use...
 * @todo use std::list?
 * 
 * @attention 指针问题
 */

/**
 * 目前设计的继承结构：
 * Value -> User -> Instruction
 *   |---> GlobalVariable
 *   |--> BasicBlock
 *   |--> Function
 */

#pragma once
#include <vector>
#include <list>
#include "type.hpp"


namespace IR {

class Value;
class User;
class Use;

/**
 * @todo replace function
 */
class Value : public Type, public Name {
protected:
    std::list<Use*> use_list;

public:
    Value(_type type = UNDEFINED, NameParam name = "") : Type(type), Name(name) {}

    std::list<Use*>& getUseList();
    void addUse(Use* use);
    void delUse(Use* use); // 删除所有匹配的use

    virtual ~Value();
};


/**
 * @todo find, set by value, del function
 * @todo use "use" pointer? 目前不用，因为USE隶属于USER
 */
class User : public Value {
protected:
    std::vector<Use> operands; // 操作数

public:
    User(_type type, NameParam name = "") : Value(type, name) {}

    void addOperand(Value *v); // 构造一个use
    std::vector<Use>& getOperands();
    void delOperand(Value *v);

    virtual ~User() {}
};


/**
 * @todo no empty warning
 */
class Use {
private:
    // 以下两个值都不隶属于 Use，Use 隶属于 User
    Value *val;   // 指向被使用的 Value
    User *user;   // 指向所属的 User

public:
    Use(Value *v, User *u);

    void setValue(Value *v);
    void setUser(User *u);
    Value* getValue() const;
    User* getUser() const;

    ~Use();
};
}
