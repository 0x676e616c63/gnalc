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
        addTargetOP(TargetOP_);
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    bool Check() override;
    std::string toString() override;

    ~movInst() override = default;
};

class strInst : public Instruction {
private:
    std::shared_ptr<BindOnVirOP> SourceOperand;
    std::shared_ptr<BaseADROP> MemoryAdd;
    unsigned int size; // 8, 4, 2, 1

public:
    strInst() = delete;
    strInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> SourceOperand_,
            std::shared_ptr<BaseADROP> _MemoryAdd)
        : Instruction(OpCode::STR, _tptrait),
          SourceOperand(std::move(SourceOperand_)),
          MemoryAdd(std::move(MemoryAdd)) {
        addTargetOP(nullptr);
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    bool Check() override;
    std::string toString() override;

    ~strInst() override = default;
};

class ldrInst : public Instruction {
private:
    std::shared_ptr<BaseADROP> MemoryAdd;
    unsigned int size; // 8, 4, 2, 1

public:
    ldrInst() = delete;
    ldrInst(SourceOperandType _tptrait, unsigned int _size,
            std::shared_ptr<BindOnVirOP> TargetOP_,
            std::shared_ptr<BaseADROP> _MemoryAdd)
        : Instruction(OpCode::LDR, _tptrait), MemoryAdd(std::move(MemoryAdd)) {
        addTargetOP(TargetOP_);
    }

    std::shared_ptr<Operand> getSourceOP(unsigned int seq) override;

    bool Check() override;
    std::string toString() override;

    ~ldrInst() override = default;
};

} // namespace MIR