#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/bfgen.hpp"
#include "../../../include/codegen/brainfk/bfbuiltins.hpp"

namespace BrainFk
{
void BFGenerator::visit(IR::Module& node) {
    for (auto& func : node.getFunctions())
        func->accept(*this);
}

void BFGenerator::visit(IR::GlobalVariable& node) {
    Err::todo();
}

void BFGenerator::visit(IR::Function& node) {
    for (auto& bb : node.getBlocks())
        bb->accept(*this);
}

void BFGenerator::visit(IR::FunctionDecl& node) {
    if (node.getName() != "@putint" && node.getName() != "@getint")
        Err::todo("Support '" + node.getName() + "'.");
}

void BFGenerator::visit(IR::BasicBlock& node) {
    for (auto& inst : node.getInsts())
        inst->accept(*this);
}

template <typename T>
void make_constant(T val, BFModule& module) {
    auto data = reinterpret_cast<unsigned char*>(&val);
    for (int i = 0; i < sizeof(T); ++i)
    {
        for (int j = 0; j < data[i]; ++j)
            module.addInst(BFInstruction::INC);
    }
}

void BFGenerator::visit(IR::ConstantInt& node) {
    // Warning:
    // Temporary treat it as an i8, just for test.
    make_constant(static_cast<char>(node.getVal()), module);

    // make_constant(node.getVal(), module);
}

void BFGenerator::visit(IR::ConstantFloat& node) {
    make_constant(node.getVal(), module);
}

void BFGenerator::visit(IR::ConstantI1& node) {
    if (node.getVal())
        module.addInst(BFInstruction::INC);
}

void BFGenerator::visit(IR::ConstantI8& node) {
    make_constant(node.getVal(), module);
}

void BFGenerator::visit(IR::BinaryInst& node) {
    module.addInst(BFInstruction::PTRINC);
    node.getLHS()->accept(*this);
    module.addInst(BFInstruction::PTRINC);
    node.getRHS()->accept(*this);
    switch (node.getOpcode())
    {
    case IR::OP::ADD:
        module.addInsts(builtin::bf_add);
        break;
    case IR::OP::SUB:
        module.addInsts(builtin::bf_sub);
        break;
    case IR::OP::FADD:
    case IR::OP::FSUB:
    case IR::OP::MUL:
    case IR::OP::FMUL:
    case IR::OP::DIV:
    case IR::OP::FDIV:
    case IR::OP::REM:
    case IR::OP::FREM:
        Err::todo("More op");
        break;
    default:
        Err::unreachable();
    }
}


void BFGenerator::visit(IR::FNEGInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::ICMPInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::FCMPInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::RETInst& node) {
    // Simply pass
}

void BFGenerator::visit(IR::BRInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::CALLInst& node) {
    if (node.getFuncName() == "@putint")
    {
        module.addInst(BFInstruction::OUTPUT);
    }
    else if (node.getFuncName() == "@getint")
    {
        module.addInst(BFInstruction::INPUT);
    }
    else
        Err::todo("More func");
}

void BFGenerator::visit(IR::FPTOSIInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::SITOFPInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::ZEXTInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::ALLOCAInst& node) {
    // Simply pass
}

void BFGenerator::visit(IR::LOADInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::STOREInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::GEPInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::PHIInst& node) {
    Err::todo();
}
}
