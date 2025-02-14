#pragma once
#ifndef GNALC_MIR_INSTRUCTION_HPP
#define GNALC_MIR_INSTRUCTION_HPP
#include "base.hpp"
#include "operand.hpp"
#include <memory>

namespace MIR {

enum class OpCode {
    MOV, // 最后codgen的时候再替换movw/movt
    // MVN,

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
    BIC,
    ASR,
    LSL,
    LSR,
    ROR /*向右循环移*/,
    RRX /*带拓展的向右循环移*/,

    MUL,
    MULS,
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
    BL,
    BLX,

    CMP,
    CMN,
    TST,
    TEQ,

    COPY /* 伪指令 */
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
    rsi /* 或者rrsi更加贴切 */,
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
    std::variant<OpCode, NeonOpCode> opcode;

    std::shared_ptr<BindOnVirOP> TargetOperand = nullptr;

    CondCodeFlag condition = CondCodeFlag::AL;

    /// @warning 并不是所有指令都可以刷新符号位
    bool flashFlag = false;

protected:
    SourceOperandType tptrait;

public:
    Instruction() = delete;
    Instruction(OpCode _opcode, SourceOperandType _tptrait)
        : opcode(_opcode), tptrait(_tptrait) {}
    Instruction(NeonOpCode _opcode, SourceOperandType _tptrait)
        : opcode(_opcode), tptrait(_tptrait) {}

    std::variant<OpCode, NeonOpCode> getOpCode() { return opcode; }

    virtual void addTargetOP(std::shared_ptr<BindOnVirOP> TargetOperand_) {
        TargetOperand = std::move(TargetOperand_);
    }

    const std::shared_ptr<BindOnVirOP> &getTargetOP() { return TargetOperand; };
    virtual std::shared_ptr<Operand> getSourceOP(unsigned int seq) = 0;

    CondCodeFlag getCondCodeFlag() { return condition; }
    void setCondCodeFlag(CondCodeFlag newFlag) { condition = newFlag; }

    void setFlash() { flashFlag = true; }

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
    NeonInstruction(NeonOpCode _opcode, SourceOperandType _type,
                    const std::pair<bitType, bitType> &_dataTypes)
        : Instruction(_opcode, _type), dataTypes(_dataTypes) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override = 0;

    std::string toString() override;
    ~NeonInstruction() override = default;
};
} // namespace MIR
#endif