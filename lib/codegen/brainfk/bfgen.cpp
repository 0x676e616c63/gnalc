#include "../../../include/codegen/brainfk/bfmodule.hpp"
#include "../../../include/codegen/brainfk/bfgen.hpp"
#include "../../../include/codegen/brainfk/bfbuiltins.hpp"
#include "../../../include/utils/logger.hpp"

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

        if (inst->getName()[0] == '%' || inst->getName()[0] == '@')
        {
            auto name = inst->getName();
            Err::gassert(!name.empty() && (name[0] == '%' || name[0] == '@'),
                "Invalid ir value name");
            reg_index[std::stoi(name.substr(1)) + 32] = tape1_pos;
        }
    }
}

void BF3t32bGen::visit(IR::BinaryInst& node) {
    curr_insts.addInst(BF3tInst::PTRINC1);
    ++tape1_pos;
    ++tape1_avail_pos;
    Logger::logDebug("Tape1 Forward, now at ", tape1_pos);

    // node.getRHS()->accept(*this);
    switch (node.getOpcode())
    {
    case IR::OP::ADD:
    case IR::OP::SUB:{
        Logger::logDebug("Add/Sub Start.");
        auto tape1_temp1_pos = tape1_pos;
        auto tape1_temp2_pos = tape1_avail_pos + 1;

        size_t lhs_pos, rhs_pos;

        if (auto lv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getLHS()))
        {
            lhs_pos = tape1_avail_pos + 2;
            tape1_set(lhs_pos, lv->getVal());
        }
        else
            lhs_pos = get_reg_pos(node.getLHS()->getName());

        if (auto rv = std::dynamic_pointer_cast<IR::ConstantInt>(node.getRHS()))
        {
            rhs_pos = tape1_avail_pos + 3;
            tape1_set(rhs_pos, rv->getVal());
        }
        else
            rhs_pos = get_reg_pos(node.getRHS()->getName());

        tape1_copy(lhs_pos, tape1_temp1_pos);
        tape1_copy(rhs_pos, tape1_temp2_pos);

        // Move temp2 to rhs
        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(tape1_temp1_pos);
        curr_insts.addInst(node.getOpcode() == IR::OP::ADD ? BF3tInst::INC1 : BF3tInst::DEC1);
        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::BNEZ1);

        if (node.getLHS()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            tape1_set(lhs_pos, 0);

        if (node.getRHS()->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            tape1_set(rhs_pos, 0);

        tape1_to(tape1_temp1_pos);

        Logger::logDebug("Add/Sub Finished.");
    }
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
        if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(node.getArgs()[0]))
        {
            tape3_set(tape3_avail_pos++, ci->getVal());
            Logger::logDebug("Put Ch, imm: ", ci->getVal());
            curr_insts.addInst(BF3tInst::OUTPUT3);
        }
        else
            curr_insts.addInst(BF3tInst::OUTPUT1);
    }
    else if (node.getFuncName() == "@getch")
    {
        curr_insts.addInst(BF3tInst::PTRINC1);
        ++tape1_pos;
        ++tape1_avail_pos;
        Logger::logDebug("Tape1 Forward, now at ", tape1_pos);
        Logger::logDebug("Get Ch");
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
    auto nbytes = node.getBaseType()->getBytes() / IR::getBytes(IR::IRBTYPE::I32);
    curr_insts.addInst(BF3tInst::PTRINC1);
    ++tape1_pos;
    ++tape1_avail_pos;
    Logger::logDebug("Tape1 Forward, now at ", tape1_pos);

    auto tape2_data_pos = tape2_avail_pos;
    tape2_avail_pos += nbytes;

    // Save address
    tape1_set(tape1_pos, static_cast<int32_t>(tape2_data_pos));
}

void BF3t32bGen::visit(IR::LOADInst& node) {
    curr_insts.addInst(BF3tInst::PTRINC1);
    ++tape1_pos;
    ++tape1_avail_pos;
    Logger::logDebug("Tape1 Forward, now at ", tape1_pos);

    tape2_to_tape1ptr(get_reg_pos(node.getPtr()->getName()));
    tape3_to(tape3_avail_pos++);

    Logger::logDebug("Tape2 curr move to Tape1 and Tape3 curr");
    curr_insts.addInst(BF3tInst::BEQZ2, BF3tInst::DEC2,
        BF3tInst::INC1, BF3tInst::INC3, BF3tInst::BNEZ2);

    Logger::logDebug("Tape3 curr move to Tape2 curr");
    curr_insts.addInst(BF3tInst::BEQZ3, BF3tInst::DEC3, BF3tInst::INC2, BF3tInst::BNEZ3);
}

void BF3t32bGen::visit(IR::STOREInst& node) {
    tape2_to_tape1ptr(get_reg_pos(node.getPtr()->getName()));

    Logger::logDebug("Tape2 curr clear");
    curr_insts.addInst(BF3tInst::BEQZ2, BF3tInst::DEC2, BF3tInst::BNEZ2);
    if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(node.getValue()))
    {
        Logger::logDebug("Tape2 curr set ", ci->getVal());
        for (int i = 0; i < static_cast<uint32_t>(ci->getVal()); ++i)
            curr_insts.addInst(BF3tInst::INC2);
    }
    else
    {
        auto tape1posbak = tape1_pos;
        auto tape1_val_pos = get_reg_pos(node.getValue()->getName());
        auto tape1_temp_pos = tape1_avail_pos;
        tape1_copy(tape1_val_pos, tape1_temp_pos);
        tape1_to(tape1_temp_pos);
        Logger::logDebug("Tape1 curr move to Tape2 curr", ci->getVal());
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::INC2, BF3tInst::BNEZ1);
        tape1_to(tape1posbak);
    }
}

void BF3t32bGen::visit(IR::GEPInst& node) {
    curr_insts.addInst(BF3tInst::PTRINC1);
    ++tape1_pos;
    ++tape1_avail_pos;
    Logger::logDebug("Tape1 Forward, now at ", tape1_pos);

    Logger::logDebug("GEP Start.");

    auto resptr_pos = tape1_pos;
    auto tape1_temp1_pos = tape1_avail_pos; // For idx

    const auto& indices = node.getIdxs();

    tape1_copy(get_reg_pos(node.getPtr()->getName()), resptr_pos);

    auto curr_elmtype = node.getBaseType();
    for (const auto & curr_idx : indices)
    {
        size_t curr_idx_pos;

        if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_idx))
        {
            curr_idx_pos = tape1_avail_pos + 3;
            tape1_set(curr_idx_pos, ci->getVal());
        }
        else
            curr_idx_pos = get_reg_pos(curr_idx->getName());

        for (size_t j = 0; j < curr_elmtype->getBytes() / IR::getBytes(IR::IRBTYPE::I32); ++j)
        {
            tape1_copy(curr_idx_pos, tape1_temp1_pos);
            tape1_to(tape1_temp1_pos);
            curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
            tape1_to(resptr_pos);
            curr_insts.addInst(BF3tInst::INC1);
            tape1_to(tape1_temp1_pos);
            curr_insts.addInst(BF3tInst::BNEZ1);
        }

        if (curr_idx->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL)
            tape1_set(curr_idx_pos, 0);

        curr_elmtype = IR::getElm(curr_elmtype);
        tape1_to(resptr_pos);
    }

    Logger::logDebug("GEP Finished.");
}

void BF3t32bGen::visit(IR::PHIInst& node) {
    Err::todo();
}

void BF3t32bGen::tape1_to(size_t pos) {
    Logger::logDebug("Tape1 To pos: ", pos);

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

void BF3t32bGen::tape3_to(size_t pos) {
    Logger::logDebug("Tape3 To pos: ", pos);

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
    Logger::logDebug("Tape1 Set pos: ", pos, " val: ", value);

    auto original_pos = tape1_pos;
    tape1_to(pos);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::BNEZ1);
    for (int i = 0; i < static_cast<uint32_t>(value); ++i)
        curr_insts.addInst(BF3tInst::INC1);
    tape1_to(original_pos);
}

void BF3t32bGen::tape3_set(size_t pos, int32_t value) {
    Logger::logDebug("Tape3 Set pos: ", pos, " val: ", value);

    auto original_pos = tape3_pos;
    tape3_to(pos);
    curr_insts.addInst(BF3tInst::BEQZ3, BF3tInst::DEC3, BF3tInst::BNEZ3);
    for (int i = 0; i < static_cast<uint32_t>(value); ++i)
        curr_insts.addInst(BF3tInst::INC3);
    tape3_to(original_pos);
}

size_t BF3t32bGen::get_reg_pos(const std::string& target) {
    return reg_index[std::stoi(target.substr(1)) + 32];
}

void BF3t32bGen::tape1_copy(size_t src, size_t dest) {
    Logger::logDebug("Tape1 Copy src: ", src, " dest: ", dest);
    auto tape1posbak = tape1_pos;
    tape3_to(tape3_avail_pos++);

    // Move src(1) to dest(1) and temp(3)
    tape1_to(src);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
    tape1_to(dest);
    // Note that tape3 hasn't moved.
    curr_insts.addInst(BF3tInst::INC1, BF3tInst::INC3);
    tape1_to(src);
    curr_insts.addInst(BF3tInst::BNEZ1);
    // Now tape1 is at src

    // Move temp(3) to src(1)
    curr_insts.addInst(BF3tInst::BEQZ3, BF3tInst::DEC3, BF3tInst::INC1, BF3tInst::BNEZ3);
    tape1_to(tape1posbak);
}

void BF3t32bGen::tape2_to_tape1ptr(size_t ptr_pos) {
    Logger::logDebug("Tape2 To Tape1Ptr: ", ptr_pos);

    auto tape1posbak = tape1_pos;

    auto tape1_temp_pos = tape1_avail_pos;
    tape1_copy(ptr_pos, tape1_temp_pos);

    // Move tape2 to 0
    tape1_to(0);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::PTRDEC2, BF3tInst::BNEZ1);

    // Move tape2 to target
    tape1_to(tape1_temp_pos);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::PTRINC2, BF3tInst::BNEZ1);

    // Save tape2 pos
    tape1_copy(ptr_pos, 0);

    tape1_to(tape1posbak);
}
}
