#include <utility>

#include "../instruction.hpp"

namespace MIR {

class movInst : public Instruction {
private:
    std::shared_ptr<Operand> SourceOperand; // ConstPoolValue, BindOnVirRegister
public:
    movInst() = delete;
    movInst(SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOP_,
            std::shared_ptr<Operand> SourceOperand_)
        : Instruction(OpCode::MOV, _tptrait),
          SourceOperand(std::move(SourceOperand_)) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    // std::string toString() override;

    ~movInst() override = default;
};

class strInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand;
    std::shared_ptr<BaseADROP> MemoryAddr;
    unsigned int size; // 8, 4, 2, 1

public:
    strInst() = delete;
    strInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> SourceOperand_,
            std::shared_ptr<BaseADROP> MemoryAddr_)
        : Instruction(OpCode::STR, _tptrait),
          SourceOperand(std::move(SourceOperand_)),
          MemoryAddr(std::move(MemoryAddr_)), size(_size) {
        addTargetOP(nullptr);
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    // std::string toString() override;

    ~strInst() override = default;
};

class ldrInst : public Instruction {
private:
    std::shared_ptr<BaseADROP> MemoryAddr;
    unsigned int size; // 8, 4, 2, 1

public:
    ldrInst() = delete;
    ldrInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> TargetOP_,
            std::shared_ptr<BaseADROP> MemoryAddr_)
        : Instruction(OpCode::LDR, _tptrait),
          MemoryAddr(std::move(MemoryAddr_)), size(_size) {
        addTargetOP(std::move(TargetOP_));
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    // std::string toString() override;

    ~ldrInst() override = default;
};

} // namespace MIR