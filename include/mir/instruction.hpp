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
    DIV /* SDIV */,

    SMULL /* SMULL RdLo, RdHi, Rn, Rm */,

    MLA /* %1 = %4 + %2 * %3 */,

    SWI /* =SYSCALL */,

    B,
    BEQ,
    BNQ,
    BGT,
    BLT,
    BGE,
    BLE,
    BX_RET,
    BX_SET_SWI,
    BL,
    BLX,

    CMP,
    CMN,

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
    i32,
    a,
    // cp

    rr,
    ri,
    rsi /* 或者rrsi更加贴切 */,
    ra /* a means address*/,
};

class Instruction {
private:
    std::variant<OpCode, NeonOpCode> opcode;

    std::shared_ptr<BindOnVirOP> TargetOperand = nullptr;

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

    virtual bool Check() = 0; // tptriat, sourceoperand
    virtual std::string toString() final;
    virtual ~Instruction() = default;
};
} // namespace MIR

#endif