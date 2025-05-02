#pragma once
#ifndef GNALC_MIR_INSTRUCTION_HPP
#define GNALC_MIR_INSTRUCTION_HPP

#include "operand.hpp"

#include <memory>

namespace MIR {

enum class OpCode {
    MOV, // 最后codgen的时候再替换movw/movt
    MVN,

    STR, // strd(需要8字节对齐), str, strh, strb
    LDR, // ldrd(同上), ldr, ldrh, ldrb

    NEG,

    ADD,
    SUB,
    RSB,
    ORR,
    AND,
    EOR,
    ORN,
    BIC, // 低位清零
    ASR,
    LSL,
    LSR,
    ROR /*向右循环移*/,
    RRX /*带拓展的向右循环移*/,

    MUL,
    DIV,
    SDIV /* SDIV */,

    MLA /* Rd = Rn + (Rm * Rs) */,
    MLS /* Rd = Rn - (Rm * Rs) */,
    SMMUL, /* Rd = (Rm *Rs)[63:32] */
    SMMLA, /* Rd = Rn + (Rm * Rs)[63:32] */
    SMMLS, /* Rd = Rn - (Rm * Rs)[63:32] */

    SMULL /* SMULL RdLo, RdHi, Rm, Rs */,

    SWI /* =SYSCALL */,

    B,
    BX_RET,
    BX_SET_SWI,
    BL,  // 30
    BLX, // 31

    CMP,
    CMN,
    TST,
    TEQ,

    PUSH,
    POP,
    VPUSH,
    VPOP,
    COPY,
    PHI,
    RET, // 具体ret方法将视情况而定
};

enum class NeonOpCode {
    VMOV, // VMOVT, VMOVW

    VSTR,
    VLDR,
    VSTX,
    VLDX,
    VADD,
    VSUB,
    VMUL,
    VDIV,

    VADDV,
    VMAXV,
    VMINV, /* reductions */

    VNEG,

    VCVT,

    VCMP,
    VMRS, /* vmrs APSR_nzcv, FPSCR */

};

enum class SourceOperandType {
    r,
    cp,
    i,
    i12,
    i16,
    i32,
    a,
    // cp

    rr,
    rrr,
    ri,
    rsi /* 或者rrsi更加贴切, si == shiftimme */,
    ra /* a means address*/,
};

enum class CondCodeFlag {
    AL,
    eq,
    ne,
    mi, // minus
    pl, // plus
    lt,
    gt,
    le,
    ge,
}; // 一般只用于处理分支问题

class Instruction {
private:
    std::shared_ptr<BindOnVirOP> TargetOperand = nullptr;

    CondCodeFlag condition = CondCodeFlag::AL;

    /// @warning 并不是所有指令都可以刷新符号位
    bool flashFlag = false;

protected:
    SourceOperandType tptrait;
    std::variant<OpCode, NeonOpCode> opcode;

public:
    Instruction() = delete;
    Instruction(OpCode _opcode, SourceOperandType _tptrait);
    Instruction(NeonOpCode _opcode, SourceOperandType _tptrait);

    std::variant<OpCode, NeonOpCode> getOpCode() const;

    void addTargetOP(std::shared_ptr<BindOnVirOP> TargetOperand_);
    const std::shared_ptr<BindOnVirOP> &getTargetOP() const;

    /// @note from 1
    virtual std::shared_ptr<Operand> getSourceOP(unsigned int seq) = 0;
    virtual void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) = 0;

    CondCodeFlag getCondCodeFlag() const;
    void setCondCodeFlag(CondCodeFlag newFlag);

    void setFlash();
    bool isSetFlash() const;

    virtual std::string toString();
    virtual ~Instruction() = default;
};

enum class bitType {
    /* s8, s16 */
    s32,
    f32,
    /*f16, f64, f128*/
    DEFAULT32,
};

class NeonInstruction : public Instruction {
protected:
    // 对于有目的操作数的指令, 代表目标操作数和源操作数
    // 对于无目标操作数如(vcmp, vstr), 代表两个操作数
    std::pair<bitType, bitType> dataTypes;

private:
public:
    NeonInstruction() = delete;
    NeonInstruction(NeonOpCode _opcode, SourceOperandType _type, const std::pair<bitType, bitType> &_dataTypes);

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override = 0;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override = 0;

    std::pair<bitType, bitType> getDataTypes() const;

    std::string toString() override;
    ~NeonInstruction() override = default;
};
} // namespace MIR
#endif