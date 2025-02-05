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
    VNEG,

    VADDV,
    VMAXV,
    VMINV, /* reductions */

    VCMP,

    VSITOF,
    VFTOSI,
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

    virtual void addTargetOP(std::shared_ptr<BindOnVirOP> TargetOperand_) {
        TargetOperand = std::move(TargetOperand_);
    }

    const std::shared_ptr<BindOnVirOP> &getTargetOP() { return TargetOperand; };
    virtual std::shared_ptr<Operand> getSourceOP(unsigned int seq) = 0;

    CondCodeFlag getCondCodeFlag() { return condition; }
    void setCondCodeFlag(CondCodeFlag newFlag) { condition = newFlag; }

    void setFlash() { flashFlag = true; }

    virtual bool Check() = 0; // tptriat, sourceoperand
    virtual std::string toString() final;
    virtual ~Instruction() = default;
}; // namespace MIR
} // namespace MIR

#endif