#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/instructions/copy.hpp"
#include "legacy_mir/enum_name.hpp"

using namespace LegacyMIR;

COPY::COPY(std::shared_ptr<BindOnVirOP> TargetOP_, std::shared_ptr<Operand> SourceOperand_)
    : Instruction(OpCode::COPY, SourceOperandType::r), SourceOperand(std::move(SourceOperand_)) {
    addTargetOP(std::move(TargetOP_));
}

std::shared_ptr<Operand> COPY::getSourceOP(unsigned int seq) {
    if (seq == 1)
        return SourceOperand;
    else
        return nullptr;
}

void COPY::setSourceOP(unsigned int seq, std::shared_ptr<Operand> ptr_new) {
    if (seq == 1) {
        SourceOperand = ptr_new;
    } else {
        Err::unreachable("set operand index out of ");
    }
}

PhiOper::PhiOper(IR::pVal _val, std::string _pre) : val(std::move(_val)), pre(std::move(_pre)) {}

PHI::PHI(std::shared_ptr<BindOnVirOP> TargetOP_, std::vector<PhiOper> _list)
    : SourceOperands(std::move(_list)), Instruction(OpCode::PHI, SourceOperandType::rr) {
    addTargetOP(std::move(TargetOP_));
}

std::shared_ptr<Operand> PHI::getSourceOP(unsigned int seq) {
    // if (seq > SourceOperands.size()) {
    //     return nullptr;
    // } else {
    //     return SourceOperands[seq - 1].val;
    // }
    return nullptr;
}

void PHI::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {}; // no in use

std::vector<PhiOper> PHI::getPhiOper() const { return SourceOperands; }

std::string PHI::toString() { // maybe not really in use
    std::string str;

    str += getTargetOP()->toString();
    str += "= PHI ";

    for (const auto &PhiOper : SourceOperands) {
        str += "[ ";
        str += PhiOper.val->getName() + ", ";
        str += '%' + PhiOper.pre + " ], ";
    }
    str += '\n';

    return str;
}

calleesaveInst::calleesaveInst(OpCode _opcode, std::set<unsigned> _set, bool _isCoreReg)
    : Instruction(_opcode, SourceOperandType::r), reg_list(std::move(_set)), isCoreReg(_isCoreReg) {}

const std::set<unsigned> &calleesaveInst::getRegList() const { return reg_list; }

std::set<unsigned> &calleesaveInst::getRegList() { return reg_list; }

bool calleesaveInst::isCore() const { return isCoreReg; }

std::string calleesaveInst::toString() {
    std::string str;

    str += enum_name(std::get<OpCode>(opcode)) + ' ';

    if (reg_list.empty())
        str += "none";

    if (isCoreReg)
        for (const auto &reg : reg_list) {
            str += "$" + enum_name(static_cast<CoreRegister>(reg)) + ", ";
        }
    else
        for (const auto &reg : reg_list) {
            str += "$" + enum_name(static_cast<FPURegister>(reg)) + ", ";
        }
    str += '\n';

    return str;
}

PUSH::PUSH(std::set<unsigned> set) : calleesaveInst(OpCode::PUSH, std::move(set), true){};

std::shared_ptr<Operand> PUSH::getSourceOP(unsigned int seq) { return nullptr; };

void PUSH::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {};

POP::POP(std::set<unsigned> set) : calleesaveInst(OpCode::POP, std::move(set), true){};

std::shared_ptr<Operand> POP::getSourceOP(unsigned int seq) { return nullptr; }

void POP::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {};

VPUSH::VPUSH(std::set<unsigned> set) : calleesaveInst(OpCode::VPUSH, std::move(set), false){};

std::shared_ptr<Operand> VPUSH::getSourceOP(unsigned int seq) { return nullptr; }

void VPUSH::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {};

VPOP::VPOP(std::set<unsigned> set) : calleesaveInst(OpCode::VPOP, std::move(set), false){};

std::shared_ptr<Operand> VPOP::getSourceOP(unsigned int seq) { return nullptr; }

void VPOP::setSourceOP(unsigned int seq, std::shared_ptr<Operand>) {};

#endif