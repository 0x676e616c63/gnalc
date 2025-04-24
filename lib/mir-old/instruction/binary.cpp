#include "mir-old/instructions/binary.hpp"
#include "mirtools-old/enum_name.hpp"

using namespace MIR;

unaryInst::unaryInst(OpCode _unaryOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOperand_,
                     std::shared_ptr<BindOnVirOP> SourceOperand_1_)
    : Instruction(_unaryOpCode, _tptrait), SourceOperand_1(std::move(SourceOperand_1_)) {
    addTargetOP(std::move(TargetOperand_));
}

std::shared_ptr<Operand> unaryInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else
        return nullptr;
}

void unaryInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {

    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        // Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

binaryInst::binaryInst(OpCode _binaryOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOperand_,
                       std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BindOnVirOP> SourceOperand_2_)
    : Instruction(_binaryOpCode, _tptrait), SourceOperand_1(std::move(SourceOperand_1_)),
      SourceOperand_2(std::move(SourceOperand_2_)) {
    addTargetOP(std::move(TargetOperand_));
}

std::shared_ptr<Operand> binaryInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    return nullptr;
}

void binaryInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        SourceOperand_1 = ptr_new_reg;
    } else if (seq == 2) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        SourceOperand_2 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

ternaryInst::ternaryInst(OpCode _ternaryOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> TargetOperand_,
                         std::shared_ptr<BindOnVirOP> SourceOperand_1_, std::shared_ptr<BindOnVirOP> SourceOperand_2_,
                         std::shared_ptr<BindOnVirOP> SourceOperand_3_)
    : Instruction(_ternaryOpCode, _tptrait), SourceOperand_1(std::move(SourceOperand_1_)),
      SourceOperand_2(std::move(SourceOperand_2_)), SourceOperand_3(std::move(SourceOperand_3_)) {
    addTargetOP(std::move(TargetOperand_));
}

std::shared_ptr<Operand> ternaryInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    else if (seq == 3)
        return SourceOperand_3;
    else
        return nullptr;
}

void ternaryInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        SourceOperand_1 = ptr_new_reg;
    } else if (seq == 2) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        SourceOperand_2 = ptr_new_reg;
    } else if (seq == 3) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        SourceOperand_3 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

binaryImmInst::binaryImmInst(OpCode _binaryOpCode, SourceOperandType _tptrait,
                             std::shared_ptr<BindOnVirOP> TargetOperand_, std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                             std::shared_ptr<Operand> SourceOperand_2_, std::shared_ptr<ShiftOP> SourceOperand_3_)
    : Instruction(_binaryOpCode, _tptrait), SourceOperand_1(std::move(SourceOperand_1_)),
      SourceOperand_2(std::move(SourceOperand_2_)), SourceOperand_3(std::move(SourceOperand_3_)) {
    addTargetOP(std::move(TargetOperand_));
}

std::shared_ptr<Operand> binaryImmInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    else if (seq == 3)
        return SourceOperand_3;
    else
        return nullptr;
}

void binaryImmInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        // Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else if (seq == 2) {
        SourceOperand_2 = ptr_new;
    } else if (seq == 3) {
        auto ptr_new_shift = std::dynamic_pointer_cast<ShiftOP>(ptr_new);
        // Err::gassert(ptr_new_shift != nullptr, "set a new operand failed");
        SourceOperand_3 = ptr_new_shift;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

compareInst::compareInst(OpCode _cmpOpCode, SourceOperandType _tptrait, std::shared_ptr<BindOnVirOP> SourceOperand_1_,
                         std::shared_ptr<Operand> SourceOperand_2_)
    : Instruction(_cmpOpCode, _tptrait), SourceOperand_1(std::move(SourceOperand_1_)),
      SourceOperand_2(std::move(SourceOperand_2_)) {
    addTargetOP(nullptr);
    setFlash();
};

std::shared_ptr<Operand> compareInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    return nullptr;
}

void compareInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        // Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else if (seq == 2) {
        SourceOperand_2 = ptr_new;
    } else {
        Err::unreachable("set operand index out of ");
    }
}