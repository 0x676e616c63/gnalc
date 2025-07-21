// SPDX-License-Identifier: MIT

/**
 * @file base.hpp
 * @brief IR base class: Value User Use
 */

/**
 * 目前的继承结构：
 * Value
 *   |--> User
 *   |     |--> Instruction
 *   |     |--> BBArgList (not implemented currently, 25.3.27)
 *   |--> GlobalVariable
 *   |--> BasicBlock
 *   |--> FunctionDecl
 *   |--> BasicConstant<xxx>
 *   |--> FormalParam
 */

#pragma once
#ifndef GNALC_IR_BASE_HPP
#define GNALC_IR_BASE_HPP

#include "type.hpp"
#include "type_alias.hpp"
#include "utils/iterator.hpp"
#include "utils/misc.hpp"

#include <cinttypes>
#include <cstdint>
#include <iterator>
#include <list>

#ifdef GNALC_EXTENSION_GGC
namespace IRParser {
class IRPT;
}
#endif

namespace IR {
// 用于标识 IR::Value 的特征
enum class ValueTrait {
    UNDEFINED,
    CONSTANT_LITERAL,  // 常量字面量
    ORDINARY_VARIABLE, // 一般变量（包含const），也即有值的指令
    GLOBAL_VARIABLE,   // 全局变量
    FUNCTION,          // 函数
    FORMAL_PARAMETER,  // 形参（函数）
    BASIC_BLOCK,       // 基本块
    VOID_INSTRUCTION,  // 无值的指令
    CONDHELPER,        // cond中的and, or
    INDUCTION_VARIABLE,// SIR 中 FORInst 的归纳变量
    BB_FPARAM,         // 基本块形参
    BB_ARG_LIST        // 基本块实参列表
    // ...
};

// Note:
// Value 是 IR 的基本对象，所有的 Instruction，Constant 都是 Value
// User 即使用 Value 的对象，由于 Instruction 含有 Operand, 他是 User
// Use 则是串联 Value 以及 User 的对象
//
// User 内部存有 unique_ptr<Use>, 即 operands
// Value 内部存有 Use*, 即 use_list
//
// Use 存有一个 weak_ptr<Value> 和 User*
//
// 由于 Use 只存储了 裸指针 以及 weak_ptr，User 和 Value 之间并没有在内存上的所有关系。
// 两大 User, 即 Instruction 和 Constant，其内存分别由 BasicBlock 和 ConstantPool 管理
//
// Use 存 User* 而不是 weak_ptr<User> 的原因是，
// User 通常是通过 make_shared 创建，调用 User 的构造函数时，User 并未由 shared_ptr 管理，
// 所以此时还不能调用 User 的 weak_from_this/shared_from_this。
// 而存 User* 也可后面通过 Use::getUser() 中的 user->shared_from_this() 获得 shared_ptr。
// 这样延后了 shared_from_this 的调用时机，从而正确运行。
// 而 Value 则无需考虑此事，构造 User 时，Value 通常已有 shared_ptr 管理 (在 BasicBlock 或者 ConstantPool)
//
// Use 存 weak_ptr<Value> 是为了观察 Value 是否已经被释放。 由于 Value 和 User 的释放顺序是不确定的，
// User 析构时， 如果 Value 未被释放，需要调用 Value 的 delUse。而如果已经释放，则无需处理。
//
// addUse/delUse 也设为了 private，这是因为 Value 的 use_list 由 User 添加，也应当由 User 删除。

class Use : public std::enable_shared_from_this<Use> {
    friend class User;
    friend class Value;

private:
    wpVal val;
    User *user;
    Use(wpVal v, User *u);
    User *getRawUser() const;

public:
    Use() = default;
    pVal getValue() const;
    pUser getUser() const;
    void setValue(const pVal &v);
};

class Instruction;
class Value : public NameC, public std::enable_shared_from_this<Value> {
    friend class User;
    friend class Use;
#ifdef GNALC_EXTENSION_GGC
    friend class IRParser::IRPT;
#endif

private:
    std::list<Use *> use_list; // Use隶属于User
    pType vtype;               // value's type
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

    Value(std::string _name, pType _vtype, ValueTrait _vtrait);

    template <typename T> std::shared_ptr<const T> as() const {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return std::dynamic_pointer_cast<const T>(shared_from_this());
    }

    template <typename T> const T *as_raw() const {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<const T *>(this);
    }

    template <typename T> std::shared_ptr<T> as() {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return std::dynamic_pointer_cast<T>(shared_from_this());
    }

    template <typename T> T *as_raw() {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<T *>(this);
    }

    template <typename T> T &as_ref() & {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<T &>(*this);
    }

    template <typename T> const T &as_ref() const & {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<const T &>(*this);
    }

    template <typename T> T &&as_ref() && {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<T &&>(*this);
    }

    template <typename T> const T &&as_ref() const && {
        static_assert(std::is_base_of_v<Value, T>, "Expected a derived type.");
        return dynamic_cast<const T &&>(*this);
    }

    template <typename... Args> bool is() const {
        static_assert((std::is_base_of_v<Value, Args> || ...), "Expected a derived type.");
        return ((as_raw<Args>() != nullptr) || ...);
    }

    pType getType() const;

    const std::list<Use *> &getUseList() const;

    // i.e. Replace all uses with, RAUW
    void replaceSelf(const pVal &new_value) const;

    virtual void accept(class IRVisitor &visitor) { Err::not_implemented("Value::accept"); }

    // Warning: this MUST NOT be called by another clone. (Except Function::cloneImpl)
    // Note that Instruction's clone don't clone their operands.
    // Only Function's clone will return an independent function with independent instructions.
    pVal clone() const {
        auto cloned = cloneImpl();
        auto raw = cloned.get();
        Err::gassert(raw != nullptr && typeid(*raw) == typeid(*this), "Derived class should override this correctly.");
        return cloned;
    }

    virtual ~Value();

    ValueTrait getVTrait() const { return trait; }

    size_t getUseCount() const;

    template <typename DownCastUserTo = User> class UserIterator {
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
        UserIterator operator++(int) { return UseIterator{iter++}; }

        UserIterator &operator--() {
            --iter;
            return *this;
        }
        UserIterator operator--(int) { return UserIterator{iter--}; }

        bool operator==(UserIterator other) const { return iter == other.iter; }
        bool operator!=(UserIterator other) const { return iter != other.iter; }
        std::shared_ptr<DownCastUserTo> operator*() const {
            if constexpr (std::is_same_v<DownCastUserTo, User>)
                return (*iter)->getUser();
            else {
                auto ret = std::dynamic_pointer_cast<DownCastUserTo>((*iter)->getUser());
                Err::gassert(ret != nullptr, "Value::UserIterator: Cannot downcast current user to '" +
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

    auto users() const { return Util::make_iterator_range(user_begin(), user_end()); }

    auto inst_users() const { return Util::make_iterator_range(inst_user_begin(), inst_user_end()); }

    using UseIterator = decltype(use_list)::const_iterator;
    UseIterator self_uses_begin() const { return use_list.begin(); }
    UseIterator self_uses_end() const { return use_list.end(); }

    auto self_uses() const { return Util::make_iterator_range(self_uses_begin(), self_uses_end()); }

    pUser getSingleUser() const;

private:
    // PRIVATE because we want to ensure use is only modified by User.
    void addUse(Use *use);

    // Why not user:
    //   A User can have multiple identical operand,
    //   thus having multiple Uses. Though having identical Value,
    //   they are independent object, and their address is unique.
    bool delUse(Use *target);

    virtual pVal cloneImpl() const {
        Err::not_implemented("Value::cloneImpl");
        return nullptr;
    }
};

// Helper template
template <typename T>
auto makeClone(const std::shared_ptr<T> &value) -> std::enable_if_t<std::is_base_of_v<Value, T>, std::shared_ptr<T>> {
    return std::dynamic_pointer_cast<T>(value->clone());
}

/**
 * @brief User是Use的所有者，User的Operands由Use中的val来保存
 */
class User : public Value {
private:
    // operands 设为 private, 防止子类误用，因为删除 operand 需要处理 use 关系
    // operands 里的 Use 中的 val 是实际的操作数
    // 性能考虑， 使用 unique_ptr
    std::vector<std::unique_ptr<Use>> operand_uses_list;

public:
    using UseIterator = decltype(operand_uses_list)::const_iterator;
    UseIterator operand_use_begin() const;
    UseIterator operand_use_end() const;

    const auto &operand_uses() const { return operand_uses_list; }

    class OperandIterator {
    private:
        using InnerIterT = decltype(operand_uses_list)::const_iterator;
        InnerIterT iter;

    public:
        using difference_type = InnerIterT::difference_type;
        using value_type = pVal;
        using pointer = pVal *;
        using reference = pVal &;
        using iterator_category = InnerIterT::iterator_category;

        explicit OperandIterator(InnerIterT iter_);

        OperandIterator &operator++();
        OperandIterator operator++(int);
        OperandIterator &operator--();
        OperandIterator operator--(int);

        OperandIterator &operator+=(difference_type n);
        OperandIterator &operator-=(difference_type n);
        OperandIterator operator+(difference_type n) const;
        OperandIterator operator-(difference_type n) const;
        bool operator<(OperandIterator other) const;
        bool operator>(OperandIterator other) const;
        bool operator<=(OperandIterator other) const;
        bool operator>=(OperandIterator other) const;
        difference_type operator-(OperandIterator other) const;

        bool operator==(OperandIterator other) const;
        bool operator!=(OperandIterator other) const;
        pVal operator*() const;
    };

    OperandIterator operand_begin() const;
    OperandIterator operand_end() const;

    auto operands() const { return Util::make_iterator_range(operand_begin(), operand_end()); }

    User() = delete;
    ~User() override;

    User(std::string _name, pType _vtype, ValueTrait _vtrait);

    void accept(IRVisitor &visitor) override = 0;

    // In general, passes should avoid direct manipulation of operands through these
    // functions unless the intent is to perform such operations in a generic manner.
    const std::vector<std::unique_ptr<Use>> &getOperands() const;
    std::vector<Use *> getRawOperands() const;
    Use *getOperand(size_t index) const;
    void setOperand(size_t index, const pVal &val);
    void swapOperand(size_t a, size_t b);

    size_t getNumOperands() const;

    // Replace all uses of `before` with `after`, return the number of the replaced operands
    size_t replaceAllOperands(const pVal &before, const pVal &after);

protected:
    void addOperand(const pVal &v);

    bool delOperand(const pVal &v);
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
                auto ok = curr_val->delUse(it->get());
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

template <typename T> std::string toIRString(T value) { return std::to_string(value); }

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

inline std::string toIRString(const std::vector<int> &value) {
    std::string ret = "<";
    for (auto it = value.begin(); it != value.end(); ++it) {
        ret += "i32 " + toIRString(*it);
        if (it != value.end() - 1)
            ret += ", ";
    }
    ret += ">";
    return ret;
}

inline std::string toIRString(const std::vector<float> &value) {
    std::string ret = "<";
    for (auto it = value.begin(); it != value.end(); ++it) {
        ret += "float " + toIRString(*it);
        if (it != value.end() - 1)
            ret += ", ";
    }
    ret += ">";
    return ret;
}
} // namespace IR

#endif