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

#define ENABLE_WEAKUSE 1

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

    IRBTYPE getType() const; // 为了和原来版本的兼容
    std::shared_ptr<Type> getTypePtr() const;

    void addUse(const std::shared_ptr<Use>& use);
    std::list<std::shared_ptr<Use>> getUseList() const;
    std::list<std::weak_ptr<Use>>& getRUseList(); // 直接返回use_list的引用，用于直接操作list

    bool delUse(const std::shared_ptr<Use>& use); // 根据Use删除匹配的use
    bool delUse(const std::shared_ptr<User>& user);
    bool delUse(NameRef name); // 根据username删除匹配use

    bool replaceUse(const std::shared_ptr<Use>& old_use, const std::shared_ptr<Use>& new_use);

    virtual void accept(class IRVisitor& visitor) = 0;
    virtual ~Value();
};


/**
 * @brief User是Use的所有者，User的Operands由Use中的val来保存
 * @todo find, set by value, del function
 */
class User : public Value, public std::enable_shared_from_this<User> {
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

#if !ENABLE_WEAKUSE
class Use : public std::enable_shared_from_this<Use> {
private:
    std::shared_ptr<Value> val; // 强引用Value
    std::weak_ptr<User> user;   // 弱引用User

public:
    Use(std::shared_ptr<Value> v, std::shared_ptr<User> u);

    // Use 设计为一次赋值
    // void setValue(const std::shared_ptr<Value>& v);
    // void setUser(const std::shared_ptr<User>& u);

    std::shared_ptr<Value> getValue() const;
    std::shared_ptr<User> getUser() const;

    ~Use();
};

#else

// WeakUse 用于Value可能循环引用的场景，v, u均为弱引用
class Use : public std::enable_shared_from_this<Use> {
private:
    std::weak_ptr<Value> val; // 弱引用Value
    std::weak_ptr<User> user;   // 弱引用User

public:
    Use(std::shared_ptr<Value> v, std::shared_ptr<User> u);

    std::shared_ptr<Value> getValue() const;
    std::shared_ptr<User> getUser() const;

    ~Use();
};
#endif

}

#endif