#pragma once
#ifndef _GNALC_MIR_OPERAND_HPP
#define _GNALC_MIR_OPERAND_HPP
#include "base.hpp"
#include "basicblock.hpp"
#include <string>
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
    gprnopc,
    /* gpr but no pc */ spr, /* 32 bits */
    dpr,                     /* 64 bits */

};

enum class OperandTrait {
    PreColored,
    BindOnVirRegister,
    BaseAddress,
    ShiftImme,
    ConstantPoolValue,
    JmpLabel,
};

class Operand : public Value {
private:
    OperandTrait otrait;

public:
    Operand() = delete;
    Operand(OperandTrait _otrait)
        : Value(ValueTrait::Operand), otrait(_otrait){};
    Operand(OperandTrait _otrait, std::string _name)
        : Value(ValueTrait::Operand, _name), otrait(_otrait){};
    OperandTrait getOperandTrait() { return otrait; };

    virtual std::string toString() = 0;
    ~Operand() = default;
};

class PreColedOP : public Operand {
private:
    std::variant<CoreRegister, FPURegister> color;

public:
    PreColedOP() = delete;
    PreColedOP(CoreRegister _color)
        : Operand(OperandTrait::PreColored), color(_color){};
    PreColedOP(FPURegister _color)
        : Operand(OperandTrait::PreColored), color(_color){};

    std::string toString() final;
    ~PreColedOP() = default;
};

class BindOnVirOP : public Operand {
private:
    RegisterBank bank;
    std::variant<CoreRegister, FPURegister> color;

public:
    BindOnVirOP() = delete;
    BindOnVirOP(RegisterBank _bank)
        : Operand(OperandTrait::BindOnVirRegister), bank(_bank){};
    BindOnVirOP(RegisterBank _bank, std::string _name)
        : Operand(OperandTrait::BindOnVirRegister, _name), bank(_bank){};
    BindOnVirOP(std::string _name)
        : Operand(OperandTrait::BaseAddress, _name),
          bank(RegisterBank::gpr){}; // for BaseADROP

    const std::variant<CoreRegister, FPURegister> &getColor() { return color; };
    void setColor(unsigned int newColor);

    virtual std::string toString();
    ~BindOnVirOP() = default;
};

enum class BaseAddressTrait {
    // 两种trait主要是加载基址寄存器的方法不一样
    Global,
    Local,
};

class BaseADROP : public BindOnVirOP {
private:
    BaseAddressTrait btrait;
    /// @note 加constOffset是为了和llc的mir在形式上兼容的同时, 尽量使用[rx,
    /// #imm]简化指令条数
    /// @note Addri时, 该条指令将被折叠, imme加在constOffset上
    /// @note 最后codegen时, 需要判断constOffset的大小
    unsigned int constOffset = 0;

public:
    BaseADROP() = delete;
    BaseADROP(BaseAddressTrait _btrait, std::string _name)
        : BindOnVirOP(_name), btrait(_btrait){};

    unsigned int getConstOffset() { return constOffset; };
    void setConstOffset(unsigned int newOffset) { constOffset = newOffset; };

    virtual std::string toString() = 0;
    ~BaseADROP() = default;
};

class GlobalADROP : public BaseADROP {
private:
    std::string global_name;

public:
    GlobalADROP() = delete;
    GlobalADROP(std::string _global_name, std::string _name)
        : BaseADROP(BaseAddressTrait::Global, _name),
          global_name(_global_name){};

    std::string toString() final;
    ~GlobalADROP() = default;
};

class StackADROP : public BaseADROP {
private:
    unsigned int idx;

public:
    StackADROP() = delete;
    StackADROP(unsigned int _idx, std::string _name)
        : BaseADROP(BaseAddressTrait::Local, _name), idx(_idx){};

    std::string toString() final;
    ~StackADROP() = default;
};

class ShiftOP : public Operand {
private:
    unsigned int imme;
    enum class inlineShift { asr, lsl, lsr, ror, rrx } shiftCode;

public:
    ShiftOP() = delete;
    ShiftOP(unsigned _imme, ShiftOP::inlineShift _shiftCode)
        : imme(_imme), shiftCode(_shiftCode),
          Operand(OperandTrait::ShiftImme){};

    std::string toString() final;
    ~ShiftOP() = default;
};

class ConstantIDX : public Operand {
private:
    unsigned int idx; // 常量池的索引

public:
    ConstantIDX() = delete;
    ConstantIDX(unsigned int _idx)
        : Operand(OperandTrait::ConstantPoolValue), idx(_idx){};

    std::string toString() final;
    ~ConstantIDX() = default;
};

} // namespace MIR

#endif