#include "../../../include/codegen/armv7/armprinter.hpp"
#include "../../../include/mir/SIMDinstruction/memory.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"

#include <algorithm>

using namespace MIR;

void ARMPrinter::printout(const Module &module) {
    ///@brief compile info

    const std::string compile_template = ".arch armv7ve\n.fpu vfpv3 -d16\n\n";
    outStream << compile_template;

    ///@brief bss section(actually no bss variable along in sysy)

    const std::string bss_template = ".bss\n";
    outStream << bss_template;

    ///@brief data section(mainly global variables)
    const std::string data_template = ".data\n";
    outStream << data_template;

    for (auto &globalVal : module.getGlobalVals())
        printout(*globalVal);

    ///@brief text section(functions)
    const std::string text_template = ".text\n.arm\n"; // currently only support arm
    outStream << text_template;

    for (auto &function : module.getFunctions()) {
        printout(*function);
    }
}

void ARMPrinter::printout(const GlobalObj &global) {
    ///@brief announce to assembler and linker: name and alignment
    auto name = global.getName().substr(1);
    const std::string global_template =
        ".global " + name + '\n' + name + ":\n" + "    .align " + std::to_string(global.getAlignment()) + '\n';

    outStream << global_template;

    ///@brief initialize data

    for (const auto &initpair : global.getInitializer()) {
        if (initpair.first)
            outStream << "    .word ";
        else
            outStream << "    .zero ";

        outStream << std::visit(visitor_c, initpair.second) + '\n';
    }
    outStream << '\n';
}

void ARMPrinter::printout(const Function &function) {
    ///@note cut out '@'
    cur_func = &function;

    const std::string func_template =
        ".globl " + function.getName().substr(1) + '\n' + function.getName().substr(1) + ":\n";

    outStream << func_template;

    for (const auto &blk : function.getBlocks()) {
        printout(*blk);
    }

    outStream << '\n';
}

void ARMPrinter::printout(const BasicBlock &basicblock) {
    ///@note cut out '@'
    const std::string blk_template = cur_func->getName().substr(1) + "_blk_" + basicblock.getName().substr(1) + ":\n";

    outStream << blk_template;

    for (const auto &inst : basicblock.getInsts()) {
        printout(inst);
    }

    // outStream << '\n'; // if a blk end with a branch, then there will be doubel empty line
}

std::string lowercase(const std::string &s) {
    std::string result = s;
    std::transform(result.begin(), result.end(), result.begin(), [](unsigned char c) { return std::tolower(c); });
    return result;
}

void ARMPrinter::printout(const std::shared_ptr<Instruction> &inst) {
    ///@note need help
    if (instTryHelp(inst))
        return;

    const std::string inst_template = "    "; // head indent
    outStream << inst_template;

    ///@note operator code
    auto opcode = inst->getOpCode();
    outStream << lowercase(std::visit(visitor_op, opcode) + enum_name(inst->getCondCodeFlag()))
              << (inst->isSetFlash() && opcode.index() == 0 && std::get<OpCode>(opcode) != OpCode::CMP &&
                          std::get<OpCode>(opcode) != OpCode::CMN && std::get<OpCode>(opcode) != OpCode::TST &&
                          std::get<OpCode>(opcode) != OpCode::TEQ
                      ? "s"
                      : std::string{} /* empty */);

    ///@note data type pair for Neon
    if (const auto &neon = std::dynamic_pointer_cast<NeonInstruction>(inst)) {
        outStream << enum_name(neon->getDataTypes());
    }
    // outStream << "    ";
    outStream << "\t";

    ///@note target op
    std::string operands; // str
    if (const auto &targetOp = inst->getTargetOP())
        operands += std::visit(visitor_reg, targetOp->getColor()) + ", ";

    for (int i = 1; i < 5; ++i) {
        auto sourceOp = inst->getSourceOP(i);

        if (sourceOp == nullptr)
            continue;

        switch (sourceOp->getOperandTrait()) {
        case OperandTrait::PreColored:
        case OperandTrait::BindOnVirRegister:
            operands += std::visit(visitor_reg, std::dynamic_pointer_cast<BindOnVirOP>(sourceOp)->getColor()) + ", ";
            break;
        case OperandTrait::BaseAddress: // {v}ldr, {v}str
            // 计算偏移
            operands +=
                std::visit(visitor_reg, std::dynamic_pointer_cast<BaseADROP>(sourceOp)->getBase()->getColor()) + ", ";
            break;
        case OperandTrait::ConstantPoolValue: {
            auto constval = std::dynamic_pointer_cast<ConstantIDX>(sourceOp);
            auto constant = constval->getConst();
            Err::gassert(!constant->isEncoded() && !constant->isGlo(),
                         "Encoded or Global addressing const should be handled by movInsthelper");
            // int float(vmov) only
            if (constant->isFloat()) {
                std::ostringstream oss;
                oss << std::scientific << std::get<float>(constant->getLiteral());
                std::string scientific = oss.str();
                operands += '#' + scientific + ", ";
            } else
                operands += '#' + std::to_string(std::get<int>(constant->getLiteral())) + ", ";

        } break;
        case OperandTrait::ShiftImme: {
            auto shift = std::dynamic_pointer_cast<ShiftOP>(sourceOp);
            operands += enum_name(shift->shiftCode) + '#' + std::to_string(shift->getShiftImme()) + ", ";
        } break;
        default:
            Err::unreachable("unknown operand trait");
        }
    }

    outStream << operands.substr(0, operands.size() - 2); // cut tailing ", "

    outStream << '\n';
}

bool ARMPrinter::instTryHelp(const std::shared_ptr<Instruction> &inst) {
    if (auto mov = std::dynamic_pointer_cast<movInst>(inst)) {
        return movInstHelper(mov); // maybe false;

    } else if (inst->getOpCode().index() == 0) {
        auto opcode = std::get<OpCode>(inst->getOpCode());
        if (opcode >= OpCode::PUSH && opcode <= OpCode::VPOP) {
            calleesaveHelper(inst);
            return true;

        } else if (opcode == OpCode::LDR || opcode == OpCode::STR) {
            memoryHelper(inst);
            return true;

        } else if (opcode >= OpCode::B && opcode <= OpCode::BLX) {
            branchHelper(inst);
            return true;
        } else if (opcode == OpCode::RET) {
            retHelper();
            return true;
        }

        ///@brief dont need help

    } else { // neon
        auto opcode = std::get<NeonOpCode>(inst->getOpCode());
        if (opcode == NeonOpCode::VLDR || opcode == NeonOpCode::VSTR) {
            memoryHelper(inst);
            return true;
        } else if (opcode == NeonOpCode::VMRS) {
            vmrsHelper();
            return true;
        }
        ///@brief dont need help
    }

    return false;
}

bool ARMPrinter::movInstHelper(const std::shared_ptr<movInst> &mov) {
    ///@todo 1  sourceOP is constant ?
    ///@todo 2.1 判断类型: 地址, float, int
    ///@todo 2.2 地址, float--> movw/movt
    ///@todo 2.3 int--> mov
    ///@todo      |---> movw/movt
    ///@todo      |---> mvn -1 ~ -257

    outStream << "    "; // head indent

    auto target = mov->getTargetOP();
    auto source = mov->getSourceOP(1);

    if (std::dynamic_pointer_cast<BindOnVirOP>(source)) // reg
        return false;

    auto constant = std::dynamic_pointer_cast<ConstantIDX>(source)->getConst();

    auto reg_str = enum_name(std::get<CoreRegister>(target->getColor()));

    if (constant->isGlo()) {
        // movw    r3, #:lower16:arr2
        // movt    r3, #:upper16:arr2
        auto val_str = std::get<std::string>(constant->getLiteral()).substr(1); // no '@'

        // outStream << "movw    " + reg_str + ", #:lower16:" + val_str + '\n';
        // outStream << "    movt    " + reg_str + ", #:upper16:" + val_str + '\n';
        outStream << "movw\t" + reg_str + ", #:lower16:" + val_str + '\n';
        outStream << "    movt\t" + reg_str + ", #:upper16:" + val_str + '\n';
    } else if (constant->isEncoded()) { // float
        // movw/movt
        auto lower = std::to_string(std::get<Encoding>(constant->getLiteral()).first);
        auto upper = std::to_string(std::get<Encoding>(constant->getLiteral()).second);

        // outStream << "movw    " + reg_str + ", #" + lower + '\n';
        // outStream << "    movt    " + reg_str + ", #" + upper + '\n';
        outStream << "movw\t" + reg_str + ", #" + lower + '\n';
        outStream << "    movt\t" + reg_str + ", #" + upper + '\n';
    } else { // legal int
        auto int32 = std::get<int>(constant->getLiteral());

        // if (int32 < 0) {
        //     outStream << "mvn    " + reg_str + ", #" + std::to_string(std::abs(int32) - 1);
        //     outStream << "    ; move " + std::to_string(int32); // comment
        //     outStream << '\n';
        // } else
        //     outStream << "mov" enum_name(mov->getCondCodeFlag()) + '    ' + reg_str + ", #" + std::to_string(int32) + '\n';

        if (int32 < 0) {
            outStream << "mvn\t" + reg_str + ", #" + std::to_string(std::abs(int32) - 1);

            outStream << "\t; move " + std::to_string(int32); // comment
            outStream << '\n';
        } else
            outStream << "mov" + lowercase(enum_name(mov->getCondCodeFlag())) + '\t' + reg_str + ", #" +
                             std::to_string(int32) + '\n';
    }

    return true;
}

void ARMPrinter::calleesaveHelper(const std::shared_ptr<Instruction> &inst) {
    auto calleesave = std::dynamic_pointer_cast<calleesaveInst>(inst);
    const auto &reg_list = calleesave->getRegList();

    if (reg_list.empty())
        return;

    outStream << "    "; // head indent

    // outStream << lowercase(enum_name(std::get<OpCode>(inst->getOpCode()))) << "    ";
    outStream << lowercase(enum_name(std::get<OpCode>(inst->getOpCode()))) << '\t';

    outStream << "{ ";

    std::string push_pop_list;
    for (const auto &reg : reg_list) {
        if (calleesave->isCore())
            push_pop_list += enum_name(static_cast<CoreRegister>(reg)) + ", ";
        else
            push_pop_list += enum_name(static_cast<FPURegister>(reg)) + ", ";
    }
    outStream << push_pop_list.substr(0, push_pop_list.size() - 2) << "}\n";
}

void ARMPrinter::vmrsHelper() {
    // outStream << "    vmrs    APSR_nzcv, FPSCR\n";
    outStream << "    vmrs\tAPSR_nzcv, FPSCR\n";
}

std::string addressingTemplate(const std::shared_ptr<Operand> &_baseReg, const std::shared_ptr<Operand> &_idxReg,
                               const std::shared_ptr<Operand> &_shift) {
    auto baseReg = std::dynamic_pointer_cast<BaseADROP>(_baseReg);
    auto idxReg = std::dynamic_pointer_cast<BindOnVirOP>(_idxReg);
    auto shift = std::dynamic_pointer_cast<ShiftOP>(_shift);

    std::string str;
    str += enum_name(std::get<CoreRegister>(baseReg->getBase()->getColor())) + ", ";

    if (idxReg)
        str += enum_name(std::get<CoreRegister>(idxReg->getColor())) + ", ";

    if (shift)
        str += lowercase(enum_name(shift->shiftCode)) + '#' + std::to_string(shift->getShiftImme()) + ", ";

    if (auto constoffset = baseReg->getConstOffset())
        str += '#' + std::to_string(constoffset) + ", ";

    return str.substr(0, str.size() - 2);
}

void ARMPrinter::memoryHelper(const std::shared_ptr<Instruction> &inst) {

    // 可能的完全体展示: ldr Rd, [Rn, Rm, LSL #n, #imm] ; Rd = *(Rn + Rm << n + imm)
    outStream << "    "; // head indent

    if (auto ldr = std::dynamic_pointer_cast<ldrInst>(inst)) {
        auto target = ldr->getTargetOP();

        // outStream << "ldr    " << enum_name(std::get<CoreRegister>(target->getColor())) << ", "; // default .word
        outStream << "ldr\t" << enum_name(std::get<CoreRegister>(target->getColor())) << ", "; // default .word

        outStream << '[' << addressingTemplate(ldr->getSourceOP(1), ldr->getSourceOP(2), nullptr) << "]\n";

    } else if (auto str = std::dynamic_pointer_cast<strInst>(inst)) {
        auto source = std::dynamic_pointer_cast<BindOnVirOP>(str->getSourceOP(1));

        // outStream << "str    " << enum_name(std::get<CoreRegister>(source->getColor())) << ", ";
        outStream << "str\t" << enum_name(std::get<CoreRegister>(source->getColor())) << ", ";

        outStream << '[' << addressingTemplate(str->getSourceOP(2), str->getSourceOP(3), nullptr) << "]\n";

    } else if (auto vldr = std::dynamic_pointer_cast<Vldr>(inst)) {
        auto target = vldr->getTargetOP();

        // outStream << "vldr.32    " << enum_name(std::get<FPURegister>(target->getColor())) << ", "; // default .word
        outStream << "vldr.32\t" << enum_name(std::get<FPURegister>(target->getColor())) << ", "; // default .word

        outStream << '[' << addressingTemplate(vldr->getSourceOP(1), vldr->getSourceOP(2), nullptr) << "]\n";

    } else if (auto vstr = std::dynamic_pointer_cast<Vstr>(inst)) {
        auto source = std::dynamic_pointer_cast<BindOnVirOP>(str->getSourceOP(1));

        // outStream << "vstr.32    " << enum_name(std::get<FPURegister>(source->getColor())) << ", ";
        outStream << "vstr.32\t" << enum_name(std::get<FPURegister>(source->getColor())) << ", ";

        outStream << '[' << addressingTemplate(str->getSourceOP(2), str->getSourceOP(3), nullptr) << "]\n";
    }
}

void ARMPrinter::branchHelper(const std::shared_ptr<Instruction> &inst) {
    outStream << "    "; // head indent

    auto opcode = std::get<OpCode>(inst->getOpCode());
    auto branch = std::dynamic_pointer_cast<branchInst>(inst);

    // outStream << lowercase(enum_name(opcode)) << lowercase(enum_name(branch->getCondCodeFlag())) << "    "; // no {s}
    outStream << lowercase(enum_name(opcode)) << lowercase(enum_name(branch->getCondCodeFlag())) << '\t'; // no {s}

    auto jmpto = branch->isJmpToFunc() ? branch->getJmpTo().substr(1)
                                       : cur_func->getName().substr(1) + "_blk_" + branch->getJmpTo().substr(1);
    outStream << jmpto << "\n\n";
}

void ARMPrinter::retHelper() {
    // outStream << "    bx    lr\n\n";
    outStream << "    bx\tlr\n\n";
}