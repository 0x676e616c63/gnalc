#pragma once
#ifndef GNALC_MIR_OPERAND_HPP
#define GNALC_MIR_OPERAND_HPP
#include "base.hpp"
#include "misc.hpp"
#include <string>
#include <utility>
#include <variant>

namespace MIR {

enum class CoreRegister {
    none = -1,
    r0,
    r1,
    r2,
    r3,
    r4,
    r5,
    r6,
    r7,
    r8,
    r9,
    r10,
    r11,
    r12,
    r13,
    r14,
    r15,
    ip = r12,
    sp = r13,
    lr = r14,
    pc = r15
};

enum class FPURegister {
    none = -1,
    s0,
    s1,
    s2,
    s3,
    s4,
    s5,
    s6,
    s7,
    s8,
    s9,
    s10,
    s11,
    s12,
    s13,
    s14,
    s15,
    s16,
    s17,
    s18,
    s19,
    s20,
    s21,
    s22,
    s23,
    s24,
    s25,
    s26,
    s27,
    s28,
    s29,
    s30,
    s31
};

enum class RegisterBank {
    gpr,
    spr, /* 32 bits */
    dpr, /* 64 bits */
    qpr, /* 128 bits*/
};

enum class OperandTrait {
    PreColored,
    BindOnVirRegister,
    BaseAddress,
    ShiftImme,
    ConstantPoolValue,
};

class Operand : public Value {
private:
    OperandTrait otrait;

public:
    Operand() = delete;
    explicit Operand(OperandTrait _otrait) : Value(ValueTrait::Operand), otrait(_otrait) {}
    Operand(OperandTrait _otrait, std::string _name) : Value(ValueTrait::Operand, std::move(_name)), otrait(_otrait) {}
    OperandTrait getOperandTrait() const { return otrait; }

    std::string toString() const override = 0;
    ~Operand() override = default;
};

class BindOnVirOP : public Operand {
private:
protected:
    std::variant<CoreRegister, FPURegister> color;
    RegisterBank bank;

public:
    BindOnVirOP() = delete;
    explicit BindOnVirOP(RegisterBank _bank) : Operand(OperandTrait::BindOnVirRegister), bank(_bank) {}
    BindOnVirOP(RegisterBank _bank, std::string _name)
        : Operand(OperandTrait::BindOnVirRegister, std::move(_name)), bank(_bank) {
        if (bank == RegisterBank::gpr) {
            color = CoreRegister::none;
        } else if (bank == RegisterBank::spr) {
            color = FPURegister::none;
        }
        ///@todo dpr, qpr
    }

    explicit BindOnVirOP(CoreRegister _color)
        : Operand(OperandTrait::PreColored), bank(RegisterBank::gpr), color(_color) {}
    explicit BindOnVirOP(FPURegister _color)
        : Operand(OperandTrait::PreColored), bank(RegisterBank::spr), color(_color) {} // for PreColored

    explicit BindOnVirOP(std::string _name)
        : Operand(OperandTrait::BaseAddress, std::move(_name)), bank(RegisterBank::gpr), color(CoreRegister::none) {
    } // for BaseADROP

    const std::variant<CoreRegister, FPURegister> &getColor() { return color; };

    template <typename T_Reg> void setColor(T_Reg newColor) { color = newColor; }

    RegisterBank getRegisterBank() { return bank; }

    RegisterBank getBank() const { return bank; }

    std::string toString() const override;
    ~BindOnVirOP() override = default;
};

class PreColedOP : public BindOnVirOP {
public:
    PreColedOP() = delete;
    explicit PreColedOP(CoreRegister _color) : BindOnVirOP(_color) {}
    explicit PreColedOP(FPURegister _color) : BindOnVirOP(_color) {}

    std::string toString() const final;
    ~PreColedOP() override = default;
};

enum class BaseAddressTrait {
    // 两种trait主要是加载基址寄存器的方法不一样
    Global,
    Local,
    Runtime, // phi汇合不确定是哪种指针, 模糊处理
};

class BaseADROP : public BindOnVirOP {
private:
    BaseAddressTrait btrait;

protected:
    /// @note 加constOffset是为了和llc的mir在形式上兼容的同时, 尽量使用[rx,
    /// #imm]简化指令条数
    /// @note Addri时, 该条指令将被折叠, imme加在constOffset上
    /// @note 最后codegen时, 需要判断constOffset的大小
    int constOffset = 0;

    /// @brief 单向的依赖, 若无额外的依赖, 则设置为其自身(方便寄存器分配)
    std::weak_ptr<BindOnVirOP> varOffset; // base

public:
    BaseADROP() = delete;
    BaseADROP(BaseAddressTrait _btrait, std::string _name, int _constOffset,
              const std::shared_ptr<BindOnVirOP> &_varOffset)
        : BindOnVirOP(std::move(_name)), btrait(_btrait), constOffset(_constOffset), varOffset(_varOffset) {}

    int getConstOffset() const { return constOffset; }
    void setConstOffset(int newOffset) { constOffset = newOffset; }

    BaseAddressTrait getTrait() { return btrait; }

    void setBase(const std::shared_ptr<BindOnVirOP> &_varOffset) { varOffset = _varOffset; }

    std::shared_ptr<BindOnVirOP> getBase() const {
        if (!varOffset.expired()) {
            return varOffset.lock();
        } else {
            return nullptr;
        }
    }

    std::string toString() const override;
    ~BaseADROP() override = default;
};

class GlobalADROP : public BaseADROP {
private:
    std::string global_name;

public:
    GlobalADROP() = delete;
    GlobalADROP(std::string _global_name, std::string _name, int _offset,
                const std::shared_ptr<BindOnVirOP> &_varOffset)
        : BaseADROP(BaseAddressTrait::Global, std::move(_name), _offset, _varOffset),
          global_name(std::move(_global_name)){};

    std::string getGloName() const { return global_name; }

    std::string toString() const final;
    ~GlobalADROP() override = default;
};

class StackADROP : public BaseADROP {
private:
    std::shared_ptr<FrameObj> obj;

public:
    StackADROP() = delete;
    StackADROP(std::shared_ptr<FrameObj> _obj, std::string _name, int _offset,
               const std::shared_ptr<BindOnVirOP> &_varOffset)
        : BaseADROP(BaseAddressTrait::Local, std::move(_name), _offset, _varOffset), obj(std::move(_obj)) {}

    std::shared_ptr<FrameObj> getObj() { return obj; }

    std::string toString() const final;
    ~StackADROP() override = default;
};

class ShiftOP : public Operand {
private:
    unsigned int imme;

public:
    enum class inlineShift { asr, lsl, lsr, ror, rrx } shiftCode;

    ShiftOP() = delete;
    ShiftOP(unsigned _imme, ShiftOP::inlineShift _shiftCode)
        : imme(_imme), shiftCode(_shiftCode), Operand(OperandTrait::ShiftImme) {}

    unsigned getShiftImme() const { return imme; }

    std::string toString() const final;
    ~ShiftOP() override = default;
};

class ConstantIDX : public Operand {
private:
    const std::shared_ptr<ConstObj> constant;

public:
    ConstantIDX() = delete;
    explicit ConstantIDX(const std::shared_ptr<ConstObj> &_constant)
        : Operand(OperandTrait::ConstantPoolValue), constant(_constant) {}

    const std::shared_ptr<ConstObj> &getConst() const { return constant; }

    std::string toString() const final;
    ~ConstantIDX() override = default;
};

} // namespace MIR

#endif