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
#ifndef GNALC_IR_BASE_HPP
#define GNALC_IR_BASE_HPP

#include <list>
#include "type.hpp"
#include "visitor.hpp"

namespace IR {

class Value;
class User;
class Use;

/**
 * @todo replace use function
 * @attention use_list的添加在use的构造过程中完成!!!
 */
class Value : public TypeC, public NameC {
protected:
    // use_list的顺序应该没有太大影响
    std::list<Use*> use_list; // Use隶属于User, 故暂时使用普通指针
                            // 利用Use中的User*找到User
public:
    Value() = default;
    Value(std::string _name, IRTYPE _type);

    void addUse(Use* use);
    std::list<Use*>& getUseList(); // 暂时不用const，由其实现一些修改功能

    /// @todo 可重载为一个函数名
    void delUseByUse(Use* use); // 根据Use删除所有匹配的use；由于Use归User所有，故理论上说通过User删除可以转换为通过Use删除
    void delUseByUser(User* user);
    void delUseByName(NameRef name); // 根据username删除匹配的第一个use

    void replaceUseByUse(Use* old_use, Use* new_use);

    virtual void accept(class IRVisitor& visitor) = 0;
    virtual ~Value();
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
    User(std::string _name, IRTYPE _type);

    void addOperand(Value *v); // 构造一个use
    std::list<Use>& getOperands();

    /// @todo 可重载为一个函数名
    void delOperandByValue(Value *v);
    void delOperandByName(NameRef name);

    virtual void accept(class IRVisitor& visitor) = 0;
    ~User() override;
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