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
#include <set>
#include <iterator>

#include <cinttypes>
#include <cstdint>

#include "type.hpp"
#include "../utils/misc.hpp"

namespace IR {
class Value;
class User;
class Use;

// 用于标识 IR::Value 的特征
enum class ValueTrait {
    UNDEFINED,
    CONSTANT_LITERAL,  // 常量字面量
    ORDINARY_VARIABLE, // 一般变量（包含const）
    GLOBAL_VARIABLE,   // 全局变量
    FUNCTION,          // 函数
    FORMAL_PARAMETER,  // 形参（函数）
    BASIC_BLOCK,       // 基本块
    VOID_INSTRUCTION,  // 无值的指令
    CONDHELPER,        // cond中的and, or
    BB_FPARAM,         // 基本块形参
    BB_ARG_LIST        // 基本块实参列表
    // ...
};

// Note:
// Value 是 IR 的基本对象，所有的 Instruction，Constant 都是 Value
// User 即使用 Value 的对象，由于 Instruction 含有 Operand, 他是 User
// Use 则是串联 Value 以及 User 的对象
//
// User 内部存有 shared_ptr<Use>, 即 operands
// Value 内部存有 weak_ptr<Use>, 即 use_list
//
// Use 存有一个 std::weak_ptr<Value> 和 User*
//
// 由于 Use 只存储了 裸指针 以及 weak_ptr，User 和 Value 之间并没有在内存上的所有关系。
// 两大 User, 即 Instruction 和 Constant，其内存分别由 BasicBlock 和 ConstantPool 管理
//
// 这样设计 Use 是为了方便转换出 shared_ptr
// Use 存 User* 而不是 weak_ptr<User> 的原因是，
// User 通常是通过 make_shared 创建，调用 User 的构造函数时，User 并未由 shared_ptr 管理，
// 所以此时还不能调用 User 的 weak_from_this/shared_from_this。
// 而存 User* 也可后面通过 Use::getUser() 中的 user->shared_from_this() 获得 shared_ptr。
// 这样延后了 shared_from_this 的调用时机，从而正确运行。
// 而 Value 则无需考虑此事，构造 User 时，Value 通常已有 shared_ptr 管理 (在 BasicBlock 或者 ConstantPool)
//
// 值得注意的是，Use 的构造函数设为了 private，
// 这是因为 User 通过 make_shared 构造 Use 时，需要添加 Use 的 weak_ptr 到 Value 的 use_list
// 而调用 Use 的构造函数时，Use 并没有 shared_ptr 管理，不能调用
// weak_from_this/shared_from_this， 需要稍后调用 Use::init() 再添加。
// 设为 private 可以防止其他地方误用，该构造函数只应当被 User 调用，并由它调用 Use::init().
//
// addUse/delUse 也设为了 private，这是因为 Value 的 use_list 由 User 添加，也应当由 User 删除。
//
// TODO:
// Value 存 weak_ptr<Use> 起初是为了避免循环引用，但现在看来似乎改为
// shared_ptr<Use> 也无妨, 因为 Use 只存了 weak_ptr<Value>。
// 但是 weak_ptr<Use> 确实也没啥大问题，而且还能避免 User 忘记删除 Value 的 use_list，
// 因为这样会导致该 weak_ptr<Use> expired。
// 所以暂时不改也没问题。
//


class Use : public std::enable_shared_from_this<Use> {
    friend class User;
    friend class Value;

private:
    std::weak_ptr<Value> val;
    User *user;

    // PRIVATE because we want to ensure the use is inited.
    Use(std::weak_ptr<Value> v, User *u);
    void init();

    // PRIVATE because only Value::delUse(User*) should invoke this.
    // Because getUser() will call User::shared_from_this,
    // but when User is being destructed, that won't work.
    User *getRawUser() const;

public:
    std::shared_ptr<Value> getValue() const;
    std::shared_ptr<User> getUser() const;
};

class Instruction;
class Value : public NameC {
    friend class User;
    friend class Use;

private:
    std::list<std::weak_ptr<Use>> use_list; // Use隶属于User
    std::shared_ptr<Type> vtype;            // value's type
    ValueTrait trait = ValueTrait::UNDEFINED;

public:
    Value() = delete;
    // Every Value's address is unique, and is owned by BasicBlock/ConstantPool.
    // So there's no copy or move constructor, which can be confusing when implicit invoked.
    // If the instruction really needs a copy, use `clone()`;
    Value(const Value &other) = delete;
    Value &operator=(const Value &other) = delete;
    Value(Value &&other) = delete;
    Value &operator=(Value &&other) = delete;

    Value(std::string _name, std::shared_ptr<Type> _vtype, ValueTrait _vtrait);

    std::shared_ptr<Type> getType() const;

    std::list<std::shared_ptr<Use>> getUseList() const;
    std::list<std::weak_ptr<Use>> &getRUseList();

    // i.e. Replace all uses with, RAUW
    void replaceSelf(const std::shared_ptr<Value> &new_value) const;

    virtual void accept(class IRVisitor &visitor) {
        Err::not_implemented("Value::accept");
    }

    // Warning: this MUST NOT be called by another clone. (Except Function::cloneImpl)
    // Note that Instruction's clone only don't clone their operands.
    // Only Function's clone will return an independent function with independent instructions.
    std::shared_ptr<Value> clone() const {
        auto cloned = cloneImpl();
        auto raw = cloned.get();
        Err::gassert(raw != nullptr && typeid(*raw) == typeid(*this),
            "Derived class should override this correctly.");
        return cloned;
    }

    virtual ~Value();

    ValueTrait getVTrait() const { return trait; }

    size_t getUseCount() const;

    template <typename DownCastUserTo = User>
    class UserIterator {
    private:
        using InnerIterT = decltype(use_list)::const_iterator;
        InnerIterT iter;

    public:
        using difference_type = InnerIterT::difference_type;
        using value_type = std::shared_ptr<DownCastUserTo>;
        using pointer = std::shared_ptr<DownCastUserTo> *;
        using reference = std::shared_ptr<DownCastUserTo> &;
        using iterator_category = InnerIterT::iterator_category;

        explicit UserIterator(InnerIterT iter_) : iter(iter_) {}

        UserIterator &operator++() {
            ++iter;
            return *this;
        }
        UserIterator operator++(int) {
            return UseIterator{iter++};
        }

        UserIterator &operator--() {
            --iter;
            return *this;
        }
        UserIterator operator--(int) {
            return UserIterator{iter--};
        }

        bool operator==(UserIterator other) const { return iter == other.iter; }
        bool operator!=(UserIterator other) const { return iter != other.iter; }
        std::shared_ptr<DownCastUserTo> operator*() const {
            if constexpr(std::is_same_v<DownCastUserTo, User>)
                return iter->lock()->getUser();
            else {
                auto ret = std::dynamic_pointer_cast<DownCastUserTo>(iter->lock()->getUser());
                Err::gassert(ret != nullptr,
                    "Value::UserIterator: Cannot downcast current user to '" +
                    std::string{Util::getTypeName<DownCastUserTo>()} + "'.");
                return ret;
            }
        }
    };

    UserIterator<> user_begin() const;
    UserIterator<> user_end() const;

    // Currently all users are instructions
    UserIterator<Instruction> inst_user_begin() const;
    UserIterator<Instruction> inst_user_end() const;

    auto users() const {
        return Util::make_iterator_range(user_begin(), user_end());
    }

    auto inst_users() const {
        return Util::make_iterator_range(inst_user_begin(), inst_user_end());
    }

    class UseIterator {
    private:
        using InnerIterT = decltype(use_list)::const_iterator;
        InnerIterT iter;

    public:
        using difference_type = InnerIterT::difference_type;
        using value_type = std::shared_ptr<Use>;
        using pointer = std::shared_ptr<Use>*;
        using reference = std::shared_ptr<Use>&;
        using iterator_category = InnerIterT::iterator_category;

        explicit UseIterator(InnerIterT iter_);

        UseIterator &operator++();
        UseIterator operator++(int);
        UseIterator &operator--();
        UseIterator operator--(int);

        bool operator==(UseIterator other) const;
        bool operator!=(UseIterator other) const;
        std::shared_ptr<Use> operator*() const;
    };

    UseIterator self_uses_begin() const;
    UseIterator self_uses_end() const;

    auto self_uses() const {
        return Util::make_iterator_range(self_uses_begin(), self_uses_end());
    }

    std::shared_ptr<User> getSingleUser() const;

private:
    // PRIVATE because we want to ensure use is only modified by User.
    void addUse(const std::weak_ptr<Use> &use);

    // Why not user:
    //   A User can have multiple identical operand,
    //   thus having multiple Uses. Though having identical Value,
    //   they are independent object, and their address is unique.
    bool delUse(const std::shared_ptr<Use> &target);

    virtual std::shared_ptr<Value> cloneImpl() const {
        Err::not_implemented("Value::cloneImpl");
        return nullptr;
    }
};

// Helper template
template <typename T>
auto makeClone(const std::shared_ptr<T>& value)
    -> std::enable_if_t<std::is_base_of_v<Value, T>, std::shared_ptr<T>>
{
    return std::dynamic_pointer_cast<T>(value->clone());
}

/**
 * @brief User是Use的所有者，User的Operands由Use中的val来保存
 */
class User : public Value, public std::enable_shared_from_this<User> {
private:
    // operands 设为 private, 防止子类误用，因为删除 operand 需要处理 use 关系
    // operands 里的 Use 中的 val 是实际的操作数
    std::vector<std::shared_ptr<Use>> operand_uses_list;

public:
    using UseIterator = decltype(operand_uses_list)::const_iterator;
    UseIterator operand_use_begin() const;
    UseIterator operand_use_end() const;

    auto operand_uses() const {
        return Util::make_iterator_range(operand_use_begin(), operand_use_end());
    }

    class OperandIterator {
    private:
        using InnerIterT = decltype(operand_uses_list)::const_iterator;
        InnerIterT iter;

    public:
        using difference_type = InnerIterT::difference_type;
        using value_type = std::shared_ptr<Value>;
        using pointer = std::shared_ptr<Value>*;
        using reference = std::shared_ptr<Value>&;
        using iterator_category = InnerIterT::iterator_category;

        explicit OperandIterator(InnerIterT iter_);

        OperandIterator &operator++();
        OperandIterator operator++(int);
        OperandIterator &operator--();
        OperandIterator operator--(int);

        OperandIterator& operator+=(difference_type n);
        OperandIterator& operator-=(difference_type n);
        OperandIterator operator+(difference_type n) const;
        OperandIterator operator-(difference_type n) const;
        bool operator<(OperandIterator other) const;
        bool operator>(OperandIterator other) const;
        bool operator<=(OperandIterator other) const;
        bool operator>=(OperandIterator other) const;
        difference_type operator-(OperandIterator other) const;

        bool operator==(OperandIterator other) const;
        bool operator!=(OperandIterator other) const;
        std::shared_ptr<Value> operator*() const;
    };

    OperandIterator operand_begin() const;
    OperandIterator operand_end() const;

    auto operands() const {
        return Util::make_iterator_range(operand_begin(), operand_end());
    }

    User() = delete;
    ~User() override;

    User(std::string _name, std::shared_ptr<Type> _vtype, ValueTrait _vtrait);

    void accept(IRVisitor &visitor) override = 0;

    // In general, passes should avoid direct manipulation of operands through these
    // functions unless the intent is to perform such operations in a generic manner.
    const std::vector<std::shared_ptr<Use>> &getOperands() const;
    const std::shared_ptr<Use> &getOperand(size_t index) const;
    void setOperand(size_t index, const std::shared_ptr<Value> &val);
    void swapOperand(size_t a, size_t b);

    bool replaceOperand(const std::shared_ptr<Value> &before, const std::shared_ptr<Value> &after);

    size_t getNumOperands() const;

    // Note:
    // Replace Use shouldn't compare Use's user/value.
    // Considering: %0 = gep ptr %a, i32 %b, i32 %b
    //              %0 operands: <use0: %a> <use1: %b> <use2: %b>
    //              %b use_list:  <use1: %0> <use2: %0>
    // If we only care about Use's user/value, we might end up with:
    //              %0 operands: <use0: %a> <use1: %b>
    //              %b use_list:  <use2: %0>
    bool replaceUse(const std::shared_ptr<Use> &old_use, const std::shared_ptr<Value> &new_use);

protected:
    void addOperand(const std::shared_ptr<Value> &v);

    bool delOperand(const std::shared_ptr<Value> &v);
    bool delOperand(NameRef name);
    bool delOperand(size_t index);

    // Delete what makes pred(value) == true, and release the Use-def relation.
    // Returns true if deleted.
    template <typename Pred> bool delOperandIf(Pred pred) {
        bool found = false;
        for (auto it = operand_uses_list.begin(); it != operand_uses_list.end();) {
            auto curr_val = (*it)->getValue();
            // `curr_val` can be nullptr if the operands have been destroyed,
            // but that shouldn't happen when the User is alive.
            // But in `~User()`, that is ok.
            Err::gassert(curr_val != nullptr, "User's operands has been destroyed unexpectedly.");
            if (pred(curr_val)) {
                auto ok = curr_val->delUse(*it);
                Err::gassert(ok);
                it = operand_uses_list.erase(it);
                found = true;
            } else {
                ++it;
            }
        }
        return found;
    }
};

template <typename T> std::string toIRString(T value) {
    return std::to_string(value);
}

// Maybe there is some historical reasons :(
// See https://llvm.org/docs/LangRef.html and https://groups.google.com/g/llvm-dev/c/IlqV3TbSk6M?pli=1
// A Useful Tool: https://www.h-schmidt.net/FloatConverter/IEEE754.html
// More info about how llvm check our output float:
//     LLParser: https://github.com/llvm/llvm-project/blob/main/llvm/lib/AsmParser/LLParser.cpp#L6140
//     ConstantFP::isValueValidForType: https://github.com/llvm/llvm-project/blob/main/llvm/lib/IR/Constants.cpp#L1611
//     IEEEFloat::convert: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Support/APFloat.cpp#L2533
// That's hard to port, orz, so we just convert all float to the hexadecimal form.
template <> inline std::string toIRString(float value) {
    char buf[32];
    auto d = static_cast<double>(value);
    sprintf(buf, "0x%016" PRIX64, *reinterpret_cast<uint64_t *>(&d));
    return buf;
}

inline std::string toIRString(const std::string &value) { return value; }
} // namespace IR

#endif