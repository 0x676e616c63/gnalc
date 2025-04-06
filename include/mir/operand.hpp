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
    fp = r11,
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
    UnknonConstant,
};

class Operand : public Value {
private:
    OperandTrait otrait;

public:
    Operand() = delete;
    explicit Operand(OperandTrait _otrait);
    Operand(OperandTrait _otrait, std::string _name);
    OperandTrait getOperandTrait() const;

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
    explicit BindOnVirOP(RegisterBank _bank);
    BindOnVirOP(RegisterBank _bank, std::string _name);

    explicit BindOnVirOP(CoreRegister _color);
    explicit BindOnVirOP(FPURegister _color); // for PreColored

    explicit BindOnVirOP(std::string _name); // for BaseADROP

    const std::variant<CoreRegister, FPURegister> &getColor();

    template <typename T_Reg> void setColor(T_Reg newColor) { color = newColor; };

    RegisterBank getRegisterBank();

    RegisterBank getBank() const;

    std::string toString() const override;
    ~BindOnVirOP() override = default;
};

class PreColedOP : public BindOnVirOP {
public:
    PreColedOP() = delete;
    explicit PreColedOP(CoreRegister _color);
    explicit PreColedOP(FPURegister _color);

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
              const std::shared_ptr<BindOnVirOP> &_varOffset);

    int getConstOffset() const;
    void setConstOffset(int newOffset);

    BaseAddressTrait getTrait();

    void setBase(const std::shared_ptr<BindOnVirOP> &_varOffset);

    std::shared_ptr<BindOnVirOP> getBase() const;

    std::string toString() const override;
    ~BaseADROP() override = default;
};

class GlobalADROP : public BaseADROP {
private:
    std::string global_name;

public:
    GlobalADROP() = delete;
    GlobalADROP(std::string _global_name, std::string _name, int _offset,
                const std::shared_ptr<BindOnVirOP> &_varOffset);

    std::string getGloName() const;

    std::string toString() const final;
    ~GlobalADROP() override = default;
};

class StackADROP : public BaseADROP {
private:
    std::shared_ptr<FrameObj> obj;

public:
    StackADROP() = delete;
    StackADROP(std::shared_ptr<FrameObj> _obj, std::string _name, int _offset,
               const std::shared_ptr<BindOnVirOP> &_varOffset);

    std::shared_ptr<FrameObj> getObj();

    std::string toString() const final;
    ~StackADROP() override = default;
};

class ShiftOP : public Operand {
private:
    unsigned int imme;

public:
    enum class inlineShift { asr, lsl, lsr, ror, rrx } shiftCode;

    ShiftOP() = delete;
    ShiftOP(unsigned _imme, ShiftOP::inlineShift _shiftCode);

    unsigned getShiftImme() const;

    std::string toString() const final;
    ~ShiftOP() override = default;
};

class ConstantIDX : public Operand {
private:
    const std::shared_ptr<ConstObj> constant;

public:
    ConstantIDX() = delete;
    explicit ConstantIDX(const std::shared_ptr<ConstObj> &_constant);

    const std::shared_ptr<ConstObj> &getConst() const;

    std::string toString() const final;
    ~ConstantIDX() override = default;
};

/// @brief 用于存储尚未知晓的stkobj的偏移量
class UnknownConstant : public Operand {
private:
    std::shared_ptr<FrameObj> stkobj;
    int offset; // 便于结合到寻址

public:
    UnknownConstant() = delete;
    explicit UnknownConstant(const std::shared_ptr<FrameObj> &_stkobj);
    UnknownConstant(const std::shared_ptr<FrameObj> &_stkobj, int _offset);

    const std::shared_ptr<FrameObj> &getStkObj() const;

    size_t getFinalOffset() const;

    std::string toString() const final;
    ~UnknownConstant() override = default;
};

} // namespace MIR

#endif