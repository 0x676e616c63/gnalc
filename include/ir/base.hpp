/**
 * @file base.hpp
 * @brief IR base class: Value User Use...
 * 
 * @attention 指针问题
 */

/**
 * 目前的继承结构：
 * Value -> User -> Instruction
 *   |---> GlobalVariable
 *   |--> BasicBlock
 *   |--> Function
 */

#pragma once
#ifndef IR_BASE_HPP
#define IR_BASE_HPP

#include <list>
#include "type.hpp"


namespace IR {

class Value;
class User;
class Use;

/**
 * @todo replace use function
 */
class Value : public TypeC, public NameC {
protected:
    std::list<Use*> use_list; // Use隶属于User, 故暂时使用普通指针

public:
    Value() = default;
    Value(std::string _name, IRTYPE _type, int length = -1);

    void addUse(Use* use);
    std::list<Use*>& getUseList() const;
    void delUseByUse(Use* use); // 根据Use删除所有匹配的use；由于Use归User所有，故理论上说通过User删除可以转换为通过Use删除
    void delUseByName(NameRef name); // 根据name删除所有匹配的use

    ~Value();
};


/**
 * @brief User是Use的所有者，User的Operands由Use中的val来保存
 * 
 * @todo find, set by value, del function
 * @todo use "use" pointer? 目前不用，因为USE隶属于USER
 */
class User : public Value {
protected:
    std::list<Use> operands; // 操作数实际是Use中的val

public:
    User() = default;
    User(std::string _name, IRTYPE _type, int length = -1);

    void addOperand(Value *v); // 构造一个use
    std::list<Use>& getOperands() const;
    void delOperandByValue(Value *v);
    void delOperandByName(NameRef name);

    ~User();
};


/**
 * @todo no empty warning
 */
class Use {
private:
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

#endif