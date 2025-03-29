#pragma once
#ifndef GNALC_MIR_COPY_HPP
#define GNALC_MIR_COPY_HPP

#include "../../ir/instructions/phi.hpp"
#include "../instruction.hpp"
#include <utility>

namespace MIR {
/// @brief 用于将后端中一些隐式的值传递显示表达出来, 比如参数传递, 函数返回值
/// @brief 以及在寄存器分配中, 表示出寄存器占用
class COPY : public Instruction {
private:
    std::shared_ptr<Operand> SourceOperand;

public:
    COPY() = delete;
    COPY(std::shared_ptr<BindOnVirOP> TargetOP_, std::shared_ptr<Operand> SourceOperand_)
        : Instruction(OpCode::COPY, SourceOperandType::r), SourceOperand(std::move(SourceOperand_)) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override;

    ~COPY() override = default;
};

class PhiOper {
public:
    const std::shared_ptr<Operand> val;
    const std::string pre; // isel中简单处理
    PhiOper() = delete;
    PhiOper(std::shared_ptr<Operand> _val, std::string _pre) : val(std::move(_val)), pre(std::move(_pre)) {}

    ~PhiOper() = default;
};

class PHI : public Instruction {
private:
    std::vector<PhiOper> SourceOperands;

public:
    PHI() = delete;
    PHI(std::shared_ptr<BindOnVirOP> TargetOP_, std::vector<PhiOper> _list)
        : SourceOperands(std::move(_list)), Instruction(OpCode::PHI, SourceOperandType::rr) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override {};

    std::vector<PhiOper> getPhiOper() const { return SourceOperands; }
    std::string toString() override;
    ~PHI() override = default;
};

class calleesaveInst : public Instruction {
private:
    std::set<unsigned> reg_list;
    bool isCoreReg;

public:
    calleesaveInst() = delete;

    calleesaveInst(OpCode _opcode, std::set<unsigned> _set, bool _isCoreReg)
        : Instruction(_opcode, SourceOperandType::r), reg_list(std::move(_set)), isCoreReg(_isCoreReg) {}

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override = 0;
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override = 0;

    const std::set<unsigned> &getRegList() const { return reg_list; }

    bool isCore() const { return isCoreReg; }

    std::string toString() override;
};

class PUSH : public calleesaveInst {
private:
public:
    PUSH() = delete;

    explicit PUSH(std::set<unsigned> set) : calleesaveInst(OpCode::PUSH, std::move(set), true){};

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override { return nullptr; };
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override {};

    ~PUSH() override = default;
};

class POP : public calleesaveInst {
private:
public:
    POP() = delete;

    explicit POP(std::set<unsigned> set) : calleesaveInst(OpCode::POP, std::move(set), true){};

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override { return nullptr; }
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override {};

    ~POP() override = default;
};

class VPUSH : public calleesaveInst {
private:
public:
    VPUSH() = delete;

    explicit VPUSH(std::set<unsigned> set) : calleesaveInst(OpCode::VPUSH, std::move(set), false){};

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override { return nullptr; }
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override {};

    ~VPUSH() override = default;
};

class VPOP : public calleesaveInst {
private:
public:
    VPOP() = delete;

    explicit VPOP(std::set<unsigned> set) : calleesaveInst(OpCode::VPOP, std::move(set), false){};

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override { return nullptr; }
    void setSourceOP(unsigned int seq, std::shared_ptr<Operand>) override {};

    ~VPOP() override = default;
};

} // namespace MIR

#endif