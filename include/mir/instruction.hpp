#pragma once
#ifndef GNALC_MIR_INSTRUCTION_HPP
#define GNALC_MIR_INSTRUCTION_HPP
#include "base.hpp"
#include "operand.hpp"
#include <memory>

namespace MIR {

enum class OpCode {
    MOV,
    MVN, // 最后codgen的时候再替换movw/movt

    STR,
    LDR,

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

    VSITOS,
    VSTOSI,
};

enum class SourceOperandType {
    r,
    cp,
    i,
    i12,
    i32,
    cp,

    rr,
    ri,
    rsi /* 或者rrsi更加贴切 */,
};

class Instruction {
private:
    std::variant<OpCode, NeonOpCode> opcode;
    std::vector<std::shared_ptr<Operand>> SourceOperandList; /* 1 based */

    std::shared_ptr<Operand> TargetOperand = nullptr;

    SourceOperandType tptrait;

public:
    Instruction() = delete;
    Instruction(OpCode _opcode, SourceOperandType _tptrait)
        : opcode(_opcode), tptrait(_tptrait){};
    Instruction(NeonOpCode _opcode, SourceOperandType _tptrait)
        : opcode(_opcode), tptrait(_tptrait){};

    virtual void addTargetOP(std::shared_ptr<Operand>) = 0;
    unsigned int addSourceOP(std::shared_ptr<Operand> _SourceOP) {
        SourceOperandList.push_back(_SourceOP);
        return SourceOperandList.size();
    };

    SourceOperandType getTptrait() { return tptrait; };

    virtual std::shared_ptr<Operand> getTargetOP() = 0;
    virtual std::shared_ptr<Operand> getSourceOP(unsigned int seq) = 0;

    virtual bool OperandTypeCheck();
    virtual std::string toString() = 0;
    ~Instruction() = default;
};
} // namespace MIR

#endif