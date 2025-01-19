#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/bfgen.hpp"
#include "../../../include/codegen/brainfk/bfbuiltins.hpp"

namespace BrainFk
{
void BF32Generator::visit(IR::Module& node) {
    for (auto& func : node.getFunctions())
        func->accept(*this);
}

void BF32Generator::visit(IR::GlobalVariable& node) {
    Err::todo();
}

void BF32Generator::visit(IR::Function& node) {
    for (auto& bb : node.getBlocks())
        bb->accept(*this);
    if (node.getName() == "@main")
        module.setInst(std::move(curr_insts.insts));
    else
        trivial_funcs.emplace(node.getName(), std::move(curr_insts.insts));
    curr_insts.insts.clear();
}

void BF32Generator::visit(IR::FunctionDecl& node) {
    // Simply pass
}

void BF32Generator::visit(IR::BasicBlock& node) {
    for (auto it = node.getInsts().begin(); it != node.getInsts().end(); it++)
    {
        const auto& inst = *it;
        inst->accept(*this);

        if (inst->getVTrait() != IR::ValueTrait::VOID_INSTRUCTION)
        {
            auto name = inst->getName();
            Err::gassert(!name.empty() && (name[0] == '%' || name[0] == '@'),
                "Invalid ir value name");
            cell_index[std::stoi(name.substr(1))] = curr_cell_pos;
        }
        if (std::next(it) != node.getInsts().end()
            && (*std::next(it))->getVTrait() != IR::ValueTrait::VOID_INSTRUCTION)
        {
            curr_insts.addInst(BFInstruction::PTRINC);
            ++curr_cell_pos;
            ++avail_cell_pos;
        }
    }
}

void BF32Generator::visit(IR::ConstantInt& node) {
    for (int i = 0; i < std::abs(node.getVal()); ++i)
        curr_insts.addInst(node.getVal() > 0 ? BFInstruction::INC : BFInstruction::DEC);
}

void BF32Generator::visit(IR::ConstantFloat& node) {
    Err::todo("Float");
}

void BF32Generator::visit(IR::ConstantI1& node) {
    if (node.getVal())
        curr_insts.addInst(BFInstruction::INC);
}

void BF32Generator::visit(IR::ConstantI8& node) {
    for (int i = 0; i < std::abs(node.getVal()); ++i)
        curr_insts.addInst(node.getVal() > 0 ? BFInstruction::INC : BFInstruction::DEC);
}

void BF32Generator::visit(IR::BinaryInst& node) {
    // node.getRHS()->accept(*this);
    switch (node.getOpcode())
    {
    case IR::OP::ADD: {
        auto temp1_pos = avail_cell_pos;
        auto temp2_pos = avail_cell_pos + 1;

        size_t lhs_pos,rhs_pos;

        if (node.getLHS()->getVTrait() != IR::ValueTrait::CONSTANT_LITERAL)
            lhs_pos = get_cell_pos(node.getLHS()->getName());
        else
        {
            auto lv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getLHS())->getVal();
            lhs_pos = avail_cell_pos + 2;
            set_cell(lhs_pos, lv);
        }

        if (node.getRHS()->getVTrait() != IR::ValueTrait::CONSTANT_LITERAL)
            rhs_pos = get_cell_pos(node.getRHS()->getName());
        else
        {
            auto rv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getRHS())->getVal();
            rhs_pos = avail_cell_pos + 3;
            set_cell(rhs_pos, rv);
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
            set_cell(lhs_pos, 0);

        if (node.getRHS()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            set_cell(rhs_pos, 0);

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


void BF32Generator::visit(IR::FNEGInst& node) {
    Err::todo("float neg");
}

void BF32Generator::visit(IR::ICMPInst& node) {
    Err::todo("icmp");
}

void BF32Generator::visit(IR::FCMPInst& node) {
    Err::todo("fcmp");
}

void BF32Generator::visit(IR::RETInst& node) {
    // Simply pass
}

void BF32Generator::visit(IR::BRInst& node) {
    Err::todo("br");
}

void BF32Generator::visit(IR::CALLInst& node) {
    if (node.getFuncName() == "@putch")
    {
        if (node.getArgs()[0]->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
        {
            auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(node.getArgs()[0]);
            set_cell(avail_cell_pos, ci->getVal());
        }
        curr_insts.addInst(BFInstruction::OUTPUT);
        if (node.getArgs()[0]->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            set_cell(avail_cell_pos, 0);
    }
    else if (node.getFuncName() == "@getch")
    {
        curr_insts.addInst(BFInstruction::INPUT);
    }
    else
        Err::todo("More func");
}

void BF32Generator::visit(IR::FPTOSIInst& node) {
    Err::todo();
}

void BF32Generator::visit(IR::SITOFPInst& node) {
    Err::todo();
}

void BF32Generator::visit(IR::ZEXTInst& node) {
    Err::todo();
}

void BF32Generator::visit(IR::ALLOCAInst& node) {
    Err::todo();
}

void BF32Generator::visit(IR::LOADInst& node) {
    Err::todo();
}

void BF32Generator::visit(IR::STOREInst& node) {
    Err::todo();
    auto posbak = curr_cell_pos;
    auto ptrpos = get_cell_pos(node.getPtr()->getName());
    to_cell(ptrpos);
    curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC);
    to_cell(posbak);
}

void BF32Generator::visit(IR::GEPInst& node) {
    Err::todo();
}

void BF32Generator::visit(IR::PHIInst& node) {
    Err::todo();
}

void BF32Generator::to_cell(size_t pos) {
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

void BF32Generator::set_cell(size_t pos, int32_t value) {
    to_cell(pos);
    curr_insts.addInst(BFInstruction::BEQZ, BFInstruction::DEC, BFInstruction::BNEZ);
    for (int i = 0; i < std::abs(value); ++i)
        curr_insts.addInst(value > 0 ? BFInstruction::INC : BFInstruction::DEC);
}

int BF32Generator::get_cell_pos(const std::string& target) {
    return cell_index[std::stoi(target.substr(1))];
}
}
