#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/bfgen.hpp"
#include "../../../include/codegen/brainfk/bfbuiltins.hpp"

namespace BrainFk
{
void BF3t32bGen::visit(IR::Module& node) {
    for (auto& func : node.getFunctions())
        func->accept(*this);
}

void BF3t32bGen::visit(IR::GlobalVariable& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::Function& node) {
    for (auto& bb : node.getBlocks())
        bb->accept(*this);
    if (node.getName() == "@main")
        module.setInst(std::move(curr_insts.insts));
    else
        trivial_funcs.emplace(node.getName(), std::move(curr_insts.insts));
    curr_insts.insts.clear();
}

void BF3t32bGen::visit(IR::FunctionDecl& node) {
    // Simply pass
}

void BF3t32bGen::visit(IR::BasicBlock& node) {
    for (auto it = node.getInsts().begin(); it != node.getInsts().end(); it++)
    {
        const auto& inst = *it;
        inst->accept(*this);

        if (inst->getVTrait() != IR::ValueTrait::VOID_INSTRUCTION)
        {
            auto name = inst->getName();
            Err::gassert(!name.empty() && (name[0] == '%' || name[0] == '@'),
                "Invalid ir value name");
            reg_index[std::stoi(name.substr(1))] = tape1_pos;
        }
        if (std::next(it) != node.getInsts().end()
            && (*std::next(it))->getVTrait() != IR::ValueTrait::VOID_INSTRUCTION)
        {
            curr_insts.addInst(BF3tInst::PTRINC1);
            ++tape1_pos;
            ++tape1_avail_pos;
        }
    }
}

void BF3t32bGen::visit(IR::BinaryInst& node) {
    // node.getRHS()->accept(*this);
    switch (node.getOpcode())
    {
    case IR::OP::ADD: {
        auto temp1_pos = tape1_avail_pos;
        auto temp2_pos = tape1_avail_pos + 1;

        size_t lhs_pos,rhs_pos;

        if (node.getLHS()->getVTrait() != IR::ValueTrait::CONSTANT_LITERAL)
            lhs_pos = get_reg_pos(node.getLHS()->getName());
        else
        {
            auto lv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getLHS())->getVal();
            lhs_pos = tape1_avail_pos + 2;
            tape1_set(lhs_pos, lv);
        }

        if (node.getRHS()->getVTrait() != IR::ValueTrait::CONSTANT_LITERAL)
            rhs_pos = get_reg_pos(node.getRHS()->getName());
        else
        {
            auto rv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getRHS())->getVal();
            rhs_pos = tape1_avail_pos + 3;
            tape1_set(rhs_pos, rv);
        }

        // Copy lhs to temp1 and temp2
        tape1_to(lhs_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(temp1_pos);
        curr_insts.addInst(BF3tInst::INC1);
        tape1_to(temp2_pos);
        curr_insts.addInst(BF3tInst::INC1);
        tape1_to(lhs_pos);
        curr_insts.addInst(BF3tInst::BNEZ1);

        // Move temp2 to lhs
        tape1_to(temp2_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(lhs_pos);
        curr_insts.addInst(BF3tInst::INC1);
        tape1_to(temp2_pos);
        curr_insts.addInst(BF3tInst::BNEZ1);

        // Add rhs to temp1, and copy it to temp2
        tape1_to(rhs_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(temp1_pos);
        curr_insts.addInst(BF3tInst::INC1);
        tape1_to(temp2_pos);
        curr_insts.addInst(BF3tInst::INC1);
        tape1_to(rhs_pos);
        curr_insts.addInst(BF3tInst::BNEZ1);

        // Move temp2 to rhs
        tape1_to(temp2_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(rhs_pos);
        curr_insts.addInst(BF3tInst::INC1);
        tape1_to(temp2_pos);
        curr_insts.addInst(BF3tInst::BNEZ1);

        if (node.getLHS()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            tape1_set(lhs_pos, 0);

        if (node.getRHS()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            tape1_set(rhs_pos, 0);

        tape1_to(temp1_pos);
    }
        break;
    case IR::OP::SUB:
        Err::todo("Sub");
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
        break;
    }
}


void BF3t32bGen::visit(IR::FNEGInst& node) {
    Err::todo("float neg");
}

void BF3t32bGen::visit(IR::ICMPInst& node) {
    Err::todo("icmp");
}

void BF3t32bGen::visit(IR::FCMPInst& node) {
    Err::todo("fcmp");
}

void BF3t32bGen::visit(IR::RETInst& node) {
    // Simply pass
}

void BF3t32bGen::visit(IR::BRInst& node) {
    Err::todo("br");
}

void BF3t32bGen::visit(IR::CALLInst& node) {
    if (node.getFuncName() == "@putch")
    {
        if (node.getArgs()[0]->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
        {
            auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(node.getArgs()[0]);
            tape1_set(tape1_avail_pos, ci->getVal());
        }
        curr_insts.addInst(BF3tInst::OUTPUT1);
        if (node.getArgs()[0]->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            tape1_set(tape1_avail_pos, 0);
    }
    else if (node.getFuncName() == "@getch")
    {
        curr_insts.addInst(BF3tInst::INPUT1);
    }
    else
        Err::todo("More func");
}

void BF3t32bGen::visit(IR::FPTOSIInst& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::SITOFPInst& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::ZEXTInst& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::ALLOCAInst& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::LOADInst& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::STOREInst& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::GEPInst& node) {
    Err::todo();
}

void BF3t32bGen::visit(IR::PHIInst& node) {
    Err::todo();
}

void BF3t32bGen::tape1_to(size_t pos) {
    while (tape1_pos < pos)
    {
        ++tape1_pos;
        curr_insts.addInst(BF3tInst::PTRINC1);
    }
    while (tape1_pos > pos)
    {
        --tape1_pos;
        curr_insts.addInst(BF3tInst::PTRDEC1);
    }
}

void BF3t32bGen::tape2_to(size_t pos) {
    while (tape2_pos < pos)
    {
        ++tape2_pos;
        curr_insts.addInst(BF3tInst::PTRINC2);
    }
    while (tape2_pos > pos)
    {
        --tape2_pos;
        curr_insts.addInst(BF3tInst::PTRDEC2);
    }
}

void BF3t32bGen::tape3_to(size_t pos) {
    while (tape3_pos < pos)
    {
        ++tape3_pos;
        curr_insts.addInst(BF3tInst::PTRINC3);
    }
    while (tape3_pos > pos)
    {
        --tape3_pos;
        curr_insts.addInst(BF3tInst::PTRDEC3);
    }
}

void BF3t32bGen::tape1_set(size_t pos, int32_t value) {
    auto original_pos = tape1_pos;
    tape1_to(pos);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::BNEZ1);
    for (int i = 0; i < std::abs(value); ++i)
        curr_insts.addInst(value > 0 ? BF3tInst::INC1 : BF3tInst::DEC1);
    tape1_to(original_pos);
}

void BF3t32bGen::tape2_set(size_t pos, int32_t value) {
    auto original_pos = tape2_pos;
    tape2_to(pos);
    curr_insts.addInst(BF3tInst::BEQZ2, BF3tInst::DEC2, BF3tInst::BNEZ2);
    for (int i = 0; i < std::abs(value); ++i)
        curr_insts.addInst(value > 0 ? BF3tInst::INC2 : BF3tInst::DEC2);
    tape2_to(original_pos);
}

void BF3t32bGen::tape3_set(size_t pos, int32_t value) {
    auto original_pos = tape3_pos;
    tape3_to(pos);
    curr_insts.addInst(BF3tInst::BEQZ3, BF3tInst::DEC3, BF3tInst::BNEZ3);
    for (int i = 0; i < std::abs(value); ++i)
        curr_insts.addInst(value > 0 ? BF3tInst::INC3 : BF3tInst::DEC3);
    tape3_to(original_pos);
}

size_t BF3t32bGen::get_reg_pos(const std::string& target) {
    return reg_index[std::stoi(target.substr(1))];
}
}
