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

namespace IR {

class Value;
class User;
class Use;

// // Specific Value Type: 用于标识特殊类型的VALUE对象
// enum class SVT {
//     NORMAL,
//     FUNCPARAM,
//     CONSTANT
//     // ...
// };

/**
 * @todo replace use function
 * @attention use_list的添加在use的构造过程中完成!!!
 */
class Value : public NameC {
protected:
    std::list<std::weak_ptr<Use>> use_list; // Use隶属于User
    std::shared_ptr<Type> vtype; // value's type
    // SVT svt;
public:
    Value() = delete;
    Value(std::string _name, std::shared_ptr<Type> _vtype);

    std::shared_ptr<Type> getType() const;

    void addUse(const std::weak_ptr<Use>& use);

    std::list<std::shared_ptr<Use>> getUseList() const;
    std::list<std::weak_ptr<Use>>& getRUseList();

    bool delUse(const std::shared_ptr<Use>& use); // 根据Use删除匹配的use
    bool delUse(Use* use); // For Use's Destructor
    bool delUse(User* user);
    bool delUse(NameRef name); // 根据username删除匹配use

    void cleanExpired();

    bool replaceUse(const std::shared_ptr<Use>& old_use, const std::shared_ptr<Use>& new_use);

    virtual void accept(class IRVisitor& visitor) { Err::not_implemented("Value::accept"); }
    virtual ~Value();
};


/**
 * @brief User是Use的所有者，User的Operands由Use中的val来保存
 * @todo find, set by value, del function
 */
class User : public Value {
protected:
    std::list<std::shared_ptr<Use>> operands; // 操作数实际是Use中的val

public:
    User() = delete;
    User(std::string _name, std::shared_ptr<Type> _vtype);

    void addOperand(const std::shared_ptr<Value>& v);

    std::list<std::shared_ptr<Use>>& getOperands();
    const std::list<std::shared_ptr<Use>>& getOperands() const;

    bool delOperand(const std::shared_ptr<Value>& v);
    bool delOperand(NameRef name);

    bool replaceUse(const std::shared_ptr<Value>& old_val, const std::shared_ptr<Value>& new_val);

    virtual void accept(IRVisitor& visitor) override = 0;
    ~User() override;
};

class Use: public std::enable_shared_from_this<Use> {
    friend void User::addOperand(const std::shared_ptr<Value>& v);
    friend bool User::replaceUse(const std::shared_ptr<Value>& old_val, const std::shared_ptr<Value>& new_val);
private:
    std::weak_ptr<Value> val;
    User* user;

    // PRIVATE because we want to ensure the use is inited.
    Use(std::weak_ptr<Value> v, User* u);
    void init();
public:
    std::shared_ptr<Value> getValue() const;
    User* getUser() const;

    ~Use();
};
}

#endif