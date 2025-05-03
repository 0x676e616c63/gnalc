#ifdef GNALC_EXTENSION_BRAINFK
#include "config/config.hpp"
#include "codegen/brainfk/bfgen.hpp"
#include "codegen/brainfk/bfmodule.hpp"
#include "utils/logger.hpp"

namespace BrainFk {
void BF3t32bGen::visit(IR::Module &node) {
    for (auto &func : node.getFunctions())
        func->accept(*this);
}

void BF3t32bGen::visit(IR::GlobalVariable &node) { Err::todo(); }
void BF3t32bGen::visit(IR::Function &node) {
    curr_is_main = node.getName() == "@main";
    size_t i = 0;
    for (const auto &bb : node) {
        auto curr_block_index = i + 1;
        block_index[bb->getName()] = curr_block_index;
        ++i;
    }

    tape1_to(T1P_BR_TARGET);
    tape1_set(T1P_BR_TARGET, 1);
    curr_insts.addInst(BF3tInst::BEQZ1);

    i = 0;
    for (const auto &bb : node) {
        auto curr_block_index = i + 1;

        tape1_set(T1P_BR_TMP1, static_cast<uint32_t>(curr_block_index));
        tape1_copy(T1P_BR_TARGET, T1P_BR_TMP2);

        // Init: tmp1: curr_bb_idx, tmp2: target_idx

        // Set tmp1 = 0, tmp2 = tmp2 - tmp1
        tape1_to(T1P_BR_TMP1);

        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(T1P_BR_TMP2);
        curr_insts.addInst(BF3tInst::DEC1);
        tape1_to(T1P_BR_TMP1);
        curr_insts.addInst(BF3tInst::BNEZ1);

        // Set tmp1 = 1
        curr_insts.addInst(BF3tInst::INC1);

        // If tmp2 != 0, which means `curr_bb_idx != target_idx`, set tmp1 to 0
        tape1_to(T1P_BR_TMP2);
        curr_insts.addInst(BF3tInst::BEQZ1);
        tape1_to(T1P_BR_TMP1);
        curr_insts.addInst(BF3tInst::DEC1);
        tape1_to(T1P_BR_TMP2);
        tape1_set(T1P_BR_TMP2, 0);
        curr_insts.addInst(BF3tInst::BNEZ1);
        // Now tmp1 is the cond (curr == target)

        tape1_to(T1P_BR_TMP1);
        curr_insts.addInst(BF3tInst::BEQZ1);
        bb->accept(*this);
        tape1_to(T1P_BR_TMP1);
        tape1_set(T1P_BR_TMP1, 0);
        curr_insts.addInst(BF3tInst::BNEZ1);
        ++i;
    }

    tape1_to(T1P_BR_TARGET);
    curr_insts.addInst(BF3tInst::BNEZ1);

    if (curr_is_main)
        module.setInst(std::move(curr_insts.insts));
    else
        trivial_funcs.emplace(node.getName(), std::move(curr_insts.insts));
    curr_insts.insts.clear();
}

void BF3t32bGen::visit(IR::FunctionDecl &node) {
    // Simply pass
}

void BF3t32bGen::visit(IR::BasicBlock &node) {
    for (auto &inst : node.getInsts()) {
        inst->accept(*this);

        if (inst->getName()[0] == '%' || inst->getName()[0] == '@') {
            auto name = inst->getName();
            Err::gassert(!name.empty() && (name[0] == '%' || name[0] == '@'), "Invalid ir value name");
            reg_index[name] = tape1_pos;
        }
    }
}

void BF3t32bGen::visit(IR::BinaryInst &node) {
    tape1_alloca();

    // node.getRHS()->accept(*this);
    switch (node.getOpcode()) {
    case IR::OP::ADD:
    case IR::OP::SUB: {
        Logger::logDebug("Add/Sub Start.");
        auto guard = Logger::scopeDisable();
        auto tape1_temp1_pos = tape1_pos;
        auto tape1_temp2_pos = tape1_avail_pos;

        if (auto lv = node.getLHS()->as<IR::ConstantInt>())
            tape1_set(tape1_temp1_pos, lv->getVal());
        else
            tape1_copy(get_reg_pos(node.getLHS()->getName()), tape1_temp1_pos);

        if (auto rv = node.getRHS()->as<IR::ConstantInt>())
            tape1_set(tape1_temp2_pos, rv->getVal());
        else
            tape1_copy(get_reg_pos(node.getRHS()->getName()), tape1_temp2_pos);

        // Move temp2 to rhs
        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(tape1_temp1_pos);
        curr_insts.addInst(node.getOpcode() == IR::OP::ADD ? BF3tInst::INC1 : BF3tInst::DEC1);
        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::BNEZ1);

        tape1_to(tape1_temp1_pos);
    } break;
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

void BF3t32bGen::visit(IR::FNEGInst &node) { Err::todo("float neg"); }

void BF3t32bGen::visit(IR::ICMPInst &node) {
    Logger::logDebug("ICMP start.");
    auto guard = Logger::scopeDisable();

    tape1_alloca();

    if (node.getCond() == IR::ICMPOP::eq || node.getCond() == IR::ICMPOP::ne) {
        auto tape1_temp1_pos = tape1_pos;
        auto tape1_temp2_pos = tape1_avail_pos;

        if (auto ci = node.getLHS()->as<IR::ConstantInt>())
            tape1_set(tape1_temp1_pos, ci->getVal());
        else
            tape1_copy(get_reg_pos(node.getLHS()->getName()), tape1_temp1_pos);

        if (auto ci = node.getRHS()->as<IR::ConstantInt>())
            tape1_set(tape1_temp2_pos, ci->getVal());
        else
            tape1_copy(get_reg_pos(node.getRHS()->getName()), tape1_temp2_pos);

        // Set tmp1 = 0, tmp2 = tmp2 - tmp1
        tape1_to(tape1_temp1_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1);
        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::DEC1);
        tape1_to(tape1_temp1_pos);
        curr_insts.addInst(BF3tInst::BNEZ1);

        // Set tmp1 = 1 / 0
        if (node.getCond() == IR::ICMPOP::eq)
            curr_insts.addInst(BF3tInst::INC1);

        // If tmp2 != 0, which means not equal
        // Set tmp1 to 0 / 1
        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::BEQZ1);
        tape1_to(tape1_temp1_pos);

        if (node.getCond() == IR::ICMPOP::eq)
            curr_insts.addInst(BF3tInst::DEC1);
        else
            curr_insts.addInst(BF3tInst::INC1);

        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::BNEZ1, BF3tInst::BNEZ1);
        // Now tmp1 is the cond (curr ==/!= target)
        tape1_to(tape1_temp1_pos);
    } else {
        Err::todo("icmp: more op");
    }
}

void BF3t32bGen::visit(IR::FCMPInst &node) { Err::todo("fcmp"); }

void BF3t32bGen::visit(IR::RETInst &node) {
    // TODO: Fix ret
    if (curr_is_main)
        tape1_set(T1P_BR_TARGET, 0);
}

void BF3t32bGen::visit(IR::BRInst &node) {
    if (node.isConditional() && !node.getCond()->is<IR::ConstantI1>()) {
        auto tape1posbak = tape1_pos;

        auto tape1_temp1_pos = tape1_avail_pos;
        auto tape1_temp2_pos = tape1_avail_pos + 1;

        // Set tmp1 = x, tmp2 = 1
        tape1_copy(get_reg_pos(node.getCond()->getName()), tape1_temp1_pos);
        tape1_set(tape1_temp2_pos, 1);

        // If tmp1, to true dest and set tmp2 = 0.
        tape1_to(tape1_temp1_pos);
        curr_insts.addInst(BF3tInst::BEQZ1);
        tape1_set(T1P_BR_TARGET, get_blk_pos(node.getTrueDest()->getName()));
        tape1_set(tape1_temp1_pos, 0);
        tape1_set(tape1_temp2_pos, 0);
        curr_insts.addInst(BF3tInst::BNEZ1);

        // If tmp2, to false dest.
        // Note that if tmp1 is not 0, we will set tmp2 to 0, so it won't exec,
        // otherwise tmp2 is 1.
        tape1_to(tape1_temp2_pos);
        curr_insts.addInst(BF3tInst::BEQZ1);
        tape1_set(T1P_BR_TARGET, get_blk_pos(node.getFalseDest()->getName()));
        tape1_set(tape1_temp2_pos, 0);
        curr_insts.addInst(BF3tInst::BNEZ1);

        tape1_to(tape1posbak);
    } else {
        if (node.isConditional()) {
            if (node.getCond()->as<IR::ConstantI1>()->getVal())
                tape1_set(T1P_BR_TARGET, get_blk_pos(node.getTrueDest()->getName()));
            else
                tape1_set(T1P_BR_TARGET, get_blk_pos(node.getFalseDest()->getName()));
        } else
            tape1_set(T1P_BR_TARGET, get_blk_pos(node.getDest()->getName()));
    }
}

void BF3t32bGen::visit(IR::CALLInst &node) {
    if (node.getFuncName() == "@putch") {
        if (auto ci = node.getArgs()[0]->as<IR::ConstantInt>()) {
            tape3_alloca();
            tape3_set(tape3_pos, ci->getVal());
            Logger::logDebug("Put Ch, imm: ", ci->getVal());
            curr_insts.addInst(BF3tInst::OUTPUT3);
        } else
            curr_insts.addInst(BF3tInst::OUTPUT1);
    } else if (node.getFuncName() == "@getch") {
        tape1_alloca();

        Logger::logDebug("Tape1 Forward, now at ", tape1_pos);
        Logger::logDebug("Get Ch");
        curr_insts.addInst(BF3tInst::INPUT1);
    } else if (node.getFuncName() == Config::IR::MEMSET_INTRINSIC_NAME) {
        // just pass
    } else
        Err::todo("More func");
}

void BF3t32bGen::visit(IR::FPTOSIInst &node) { Err::todo("float converse"); }

void BF3t32bGen::visit(IR::SITOFPInst &node) { Err::todo("float converse"); }

void BF3t32bGen::visit(IR::ZEXTInst &node) {
    // Pass
}

void BF3t32bGen::visit(IR::BITCASTInst &node) {
    // Pass
}

void BF3t32bGen::visit(IR::ALLOCAInst &node) {
    auto nbytes = node.getBaseType()->getBytes() / IR::getBytes(IR::IRBTYPE::I32);
    tape1_alloca();

    auto tape2_data_pos = tape2_avail_pos;
    tape2_avail_pos += nbytes;

    // Save address
    tape1_set(tape1_pos, static_cast<uint32_t>(tape2_data_pos));
}

void BF3t32bGen::visit(IR::LOADInst &node) {
    tape1_alloca();

    Logger::logDebug("Loading from ", get_reg_pos(node.getPtr()->getName()), "(", node.getName(), ") to ", tape1_pos);
    auto guard = Logger::scopeDisable();

    tape2_to_tape1ptr(get_reg_pos(node.getPtr()->getName()));
    tape3_alloca();

    curr_insts.addInst(BF3tInst::BEQZ2, BF3tInst::DEC2, BF3tInst::INC1, BF3tInst::INC3, BF3tInst::BNEZ2);

    curr_insts.addInst(BF3tInst::BEQZ3, BF3tInst::DEC3, BF3tInst::INC2, BF3tInst::BNEZ3);
}

void BF3t32bGen::visit(IR::STOREInst &node) {
    tape2_to_tape1ptr(get_reg_pos(node.getPtr()->getName()));

    Logger::logDebug("Tape2 curr clear");
    curr_insts.addInst(BF3tInst::BEQZ2, BF3tInst::DEC2, BF3tInst::BNEZ2);
    if (auto ci = node.getValue()->as<IR::ConstantInt>()) {
        Logger::logDebug("Tape2 curr set ", ci->getVal());
        for (int i = 0; i < static_cast<uint32_t>(ci->getVal()); ++i)
            curr_insts.addInst(BF3tInst::INC2);
    } else {
        auto tape1posbak = tape1_pos;
        auto tape1_val_pos = get_reg_pos(node.getValue()->getName());
        auto tape1_temp_pos = tape1_avail_pos;
        tape1_copy(tape1_val_pos, tape1_temp_pos);
        tape1_to(tape1_temp_pos);
        Logger::logDebug("Tape1 curr move to Tape2 curr");
        curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::INC2, BF3tInst::BNEZ1);
        tape1_to(tape1posbak);
    }
}

void BF3t32bGen::visit(IR::GEPInst &node) {
    tape1_alloca();

    Logger::logDebug("GEP Start.");

    auto resptr_pos = tape1_pos;
    auto tape1_temp1_pos = tape1_avail_pos; // For idx

    const auto &indices = node.getIdxs();

    tape1_copy(get_reg_pos(node.getPtr()->getName()), resptr_pos);

    auto curr_elmtype = node.getBaseType();
    for (const auto &curr_idx : indices) {
        size_t curr_idx_pos;

        if (auto ci = curr_idx->as<IR::ConstantInt>()) {
            curr_idx_pos = tape1_avail_pos + 1;
            tape1_set(curr_idx_pos, ci->getVal());
        } else
            curr_idx_pos = get_reg_pos(curr_idx->getName());

        for (size_t j = 0; j < curr_elmtype->getBytes() / IR::getBytes(IR::IRBTYPE::I32); ++j) {
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

void BF3t32bGen::tape1_alloca() {
    tape1_to(tape1_avail_pos++);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::BNEZ1);
}

void BF3t32bGen::tape3_alloca() {
    tape3_to(tape3_avail_pos++);
    curr_insts.addInst(BF3tInst::BEQZ3, BF3tInst::DEC3, BF3tInst::BNEZ3);
}

void BF3t32bGen::tape1_to(size_t pos) {
    if (pos == tape1_pos)
        return;
    Logger::logDebug("Tape1 To pos: ", pos);

    while (tape1_pos < pos) {
        ++tape1_pos;
        curr_insts.addInst(BF3tInst::PTRINC1);
    }
    while (tape1_pos > pos) {
        --tape1_pos;
        curr_insts.addInst(BF3tInst::PTRDEC1);
    }
}

void BF3t32bGen::tape3_to(size_t pos) {
    Logger::logDebug("Tape3 To pos: ", pos);

    while (tape3_pos < pos) {
        ++tape3_pos;
        curr_insts.addInst(BF3tInst::PTRINC3);
    }
    while (tape3_pos > pos) {
        --tape3_pos;
        curr_insts.addInst(BF3tInst::PTRDEC3);
    }
}

void BF3t32bGen::tape1_set(size_t pos, uint32_t value) {
    Logger::logDebug("Tape1 Set pos: ", pos, " val: ", value);
    auto guard = Logger::scopeDisable();

    auto original_pos = tape1_pos;
    tape1_to(pos);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::BNEZ1);
    for (int i = 0; i < value; ++i)
        curr_insts.addInst(BF3tInst::INC1);
    tape1_to(original_pos);
}

void BF3t32bGen::tape3_set(size_t pos, uint32_t value) {
    Logger::logDebug("Tape3 Set pos: ", pos, " val: ", value);
    auto guard = Logger::scopeDisable();

    auto original_pos = tape3_pos;
    tape3_to(pos);
    curr_insts.addInst(BF3tInst::BEQZ3, BF3tInst::DEC3, BF3tInst::BNEZ3);
    for (int i = 0; i < value; ++i)
        curr_insts.addInst(BF3tInst::INC3);
    tape3_to(original_pos);
}

size_t BF3t32bGen::get_reg_pos(const std::string &target) {
    Err::gassert(reg_index.find(target) != reg_index.end());
    return reg_index[target];
}

size_t BF3t32bGen::get_blk_pos(const std::string &target) {
    Err::gassert(block_index.find(target) != block_index.end());
    return block_index[target];
}

void BF3t32bGen::tape1_copy(size_t src, size_t dest) {
    Logger::logDebug("Tape1 Copy src: ", src, " dest: ", dest);
    auto guard = Logger::scopeDisable();

    auto tape1posbak = tape1_pos;
    tape3_alloca();
    tape1_set(dest, 0);

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

void BF3t32bGen::debug_output(int32_t val) {
    auto tape1posbak = tape1_pos;
    tape1_to(T1P_DEBUG_TMP);
    tape1_set(T1P_DEBUG_TMP, val);
    curr_insts.addInst(BF3tInst::OUTPUT1);
    tape1_to(tape1posbak);
}

void BF3t32bGen::debug_tape1_show(size_t pos) {
    auto tape1posbak = tape1_pos;
    tape1_to(pos);
    curr_insts.addInst(BF3tInst::OUTPUT1);
    tape1_to(tape1posbak);
}

void BF3t32bGen::tape2_to_tape1ptr(size_t ptr_pos) {
    Logger::logDebug("Tape2 To Tape1Ptr: ", ptr_pos);
    auto guard = Logger::scopeDisable();

    auto tape1posbak = tape1_pos;

    auto tape1_temp_pos = tape1_avail_pos;
    tape1_copy(ptr_pos, tape1_temp_pos);

    // Move tape2 to 0
    tape1_to(T1P_MEM);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::PTRDEC2, BF3tInst::BNEZ1);

    // Move tape2 to target
    tape1_to(tape1_temp_pos);
    curr_insts.addInst(BF3tInst::BEQZ1, BF3tInst::DEC1, BF3tInst::PTRINC2, BF3tInst::BNEZ1);

    // Save tape2 pos
    tape1_copy(ptr_pos, T1P_MEM);

    tape1_to(tape1posbak);
}
} // namespace BrainFk
#endif