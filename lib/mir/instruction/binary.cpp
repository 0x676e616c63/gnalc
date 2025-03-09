#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mirtools/enum_name.hpp"

using namespace MIR;

std::shared_ptr<Operand> unaryInst::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand_1;
    else
        return nullptr;
}

void unaryInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {

    if (seq == 1) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

std::shared_ptr<Operand> binaryInst::getSourceOP(unsigned int seq) {

    if (seq == 1)
        return SourceOperand_1;
    else if (seq == 2)
        return SourceOperand_2;
    return nullptr;
}

void binaryInst::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1 || seq == 2) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
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
    if (seq == 1 || seq == 2 || seq == 3) {
        auto ptr_new_reg = std::dynamic_pointer_cast<BindOnVirOP>(ptr_new);
        Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else {
        Err::unreachable("set operand index out of ");
    }
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
        Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else if (seq == 2) {
        SourceOperand_2 = ptr_new;
    } else if (seq == 3) {
        auto ptr_new_shift = std::dynamic_pointer_cast<ShiftOP>(ptr_new);
        Err::gassert(ptr_new_shift != nullptr, "set a new operand failed");
        SourceOperand_3 = ptr_new_shift;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

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
        Err::gassert(ptr_new_reg != nullptr, "set a new operand failed");
        SourceOperand_1 = ptr_new_reg;
    } else if (seq == 2) {
        SourceOperand_2 = ptr_new;
    } else {
        Err::unreachable("set operand index out of ");
    }
}