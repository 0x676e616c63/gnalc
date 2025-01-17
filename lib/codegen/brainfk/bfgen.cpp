#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/bfgen.hpp"

#include <limits>

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
    if (node.getName() == "@main")
        module.setInst(std::move(curr_insts.insts));
    else
        trivial_funcs.emplace(node.getName(), std::move(curr_insts.insts));
    curr_insts.insts.clear();
}

void BFGenerator::visit(IR::FunctionDecl& node) {
    // Simply pass
}

void BFGenerator::visit(IR::BasicBlock& node) {
    for (auto it = node.getInsts().begin(); it != node.getInsts().end(); it++)
    {
        const auto& inst = *it;
        inst->accept(*this);

        if (inst->getVTrait() != IR::ValueTrait::VOID_INSTRUCTION)
        {
            auto name = inst->getName();
            Err::gassert(!name.empty() && (name[0] == '%' || name[0] == '@'),
                "Invalid ir value name");
            reg_cell_index[std::stoi(name.substr(1))] = curr_cell_pos;
        }
        if (std::next(it) != node.getInsts().end()
            && (*std::next(it))->getVTrait() != IR::ValueTrait::VOID_INSTRUCTION)
        {
            curr_insts.addInst(BFInstruction::PTRINC);
            ++curr_cell_pos;
            ++avail_reg_cell_pos;
        }
    }
}

template <typename T>
void make_constant(T val, BFGenerator::Insts& insts) {
    auto data = reinterpret_cast<unsigned char*>(&val);
    for (int i = 0; i < sizeof(T); ++i)
    {
        for (int j = 0; j < data[i]; ++j)
            insts.addInst(BFInstruction::INC);
    }
}

void BFGenerator::visit(IR::ConstantInt& node) {
    // Warning:
    // Temporary treat it as an i8, just for test.
    if (node.getVal() >= std::numeric_limits<char>::max())
        Err::todo("Unsupported wide integer.");

    make_constant(static_cast<char>(node.getVal()), curr_insts);

    // make_constant(node.getVal(), module);
}

void BFGenerator::visit(IR::ConstantFloat& node) {
    Err::todo("Float");
    make_constant(node.getVal(), curr_insts);
}

void BFGenerator::visit(IR::ConstantI1& node) {
    if (node.getVal())
        curr_insts.addInst(BFInstruction::INC);
}

void BFGenerator::visit(IR::ConstantI8& node) {
    make_constant(node.getVal(), curr_insts);
}

void BFGenerator::visit(IR::BinaryInst& node) {
    // node.getRHS()->accept(*this);
    switch (node.getOpcode())
    {
    case IR::OP::ADD: {
        auto temp1_pos = avail_reg_cell_pos;
        auto temp2_pos = avail_reg_cell_pos + 1;

        int lhs_pos,rhs_pos;

        if (node.getLHS()->getVTrait() != IR::ValueTrait::CONSTANT_LITERAL)
            lhs_pos = get_reg_cell_pos(node.getLHS()->getName());
        else
        {
            lhs_pos = avail_reg_cell_pos + 2;
            to_cell(lhs_pos);
            auto lv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getLHS())->getVal();
            for (int i = 0; i < std::abs(lv); ++i)
                curr_insts.addInst(lv > 0 ? BFInstruction::INC : BFInstruction::DEC);
        }

        if (node.getRHS()->getVTrait() != IR::ValueTrait::CONSTANT_LITERAL)
            rhs_pos = get_reg_cell_pos(node.getRHS()->getName());
        else
        {
            rhs_pos = avail_reg_cell_pos + 3;
            to_cell(rhs_pos);
            auto rv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getRHS())->getVal();
            for (int i = 0; i < std::abs(rv); ++i)
                curr_insts.addInst(rv > 0 ? BFInstruction::INC : BFInstruction::DEC);
        }

        // Copy lhs to temp1 and temp2
        to_cell(lhs_pos);
        curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC);
        to_cell(temp1_pos);
        curr_insts.addInst(BFInstruction::INC);
        to_cell(temp2_pos);
        curr_insts.addInst(BFInstruction::INC);
        to_cell(lhs_pos);
        curr_insts.addInst(BFInstruction::BNEZ);

        // Move temp2 to lhs
        to_cell(temp2_pos);
        curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC);
        to_cell(lhs_pos);
        curr_insts.addInst(BFInstruction::INC);
        to_cell(temp2_pos);
        curr_insts.addInst(BFInstruction::BNEZ);

        // Add rhs to temp1, and copy it to temp2
        to_cell(rhs_pos);
        curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC);
        to_cell(temp1_pos);
        curr_insts.addInst(BFInstruction::INC);
        to_cell(temp2_pos);
        curr_insts.addInst(BFInstruction::INC);
        to_cell(rhs_pos);
        curr_insts.addInst(BFInstruction::BNEZ);

        // Move temp2 to rhs
        to_cell(temp2_pos);
        curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC);
        to_cell(rhs_pos);
        curr_insts.addInst(BFInstruction::INC);
        to_cell(temp2_pos);
        curr_insts.addInst(BFInstruction::BNEZ);

        if (node.getLHS()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
        {
            to_cell(lhs_pos);
            curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::BNEZ);
        }

        if (node.getRHS()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
        {
            to_cell(rhs_pos);
            curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::BNEZ);
        }

        to_cell(temp1_pos);
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


void BFGenerator::visit(IR::FNEGInst& node) {
    Err::todo("float neg");
}

void BFGenerator::visit(IR::ICMPInst& node) {
    Err::todo("icmp");
}

void BFGenerator::visit(IR::FCMPInst& node) {
    Err::todo("fcmp");
}

void BFGenerator::visit(IR::RETInst& node) {
    // Simply pass
}

void BFGenerator::visit(IR::BRInst& node) {
    Err::todo("br");
}

void BFGenerator::visit(IR::CALLInst& node) {
    if (node.getFuncName() == "@putch")
    {
        curr_insts.addInst(BFInstruction::OUTPUT);
    }
    else if (node.getFuncName() == "@getch")
    {
        curr_insts.addInst(BFInstruction::INPUT);
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
    auto posbak = curr_cell_pos;
    auto ptrpos = get_reg_cell_pos(node.getPtr()->getName());
    to_cell(ptrpos);
    curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC);
    to_cell(posbak);
}

void BFGenerator::visit(IR::GEPInst& node) {
    Err::todo();
}

void BFGenerator::visit(IR::PHIInst& node) {
    Err::todo();
}

void BFGenerator::to_cell(int pos) {
    while (curr_cell_pos < pos)
    {
        ++curr_cell_pos;
        curr_insts.addInst(BFInstruction::PTRINC);
    }
    while (curr_cell_pos > pos)
    {
        --curr_cell_pos;
        curr_insts.addInst(BFInstruction::PTRDEC);
    }
}

int BFGenerator::get_reg_cell_pos(const std::string& target) {
    return reg_cell_index[std::stoi(target.substr(1))];
}
}
