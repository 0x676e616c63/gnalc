#include "../../include/ir/instructions/binary.hpp"
#include "../../include/ir/instructions/compare.hpp"
#include "../../include/ir/instructions/control.hpp"
#include "../../include/ir/instructions/converse.hpp"
#include "../../include/ir/instructions/memory.hpp"
#include "../../include/ir/instructions/phi.hpp"
#include "../../include/mirpasses/lowering.hpp"
#include <cassert>

using namespace MIR;

std::shared_ptr<Instruction>
InstLowering::operator()(const std::shared_ptr<IR::Instruction> &midEnd_inst) {
    std::shared_ptr<Instruction> inst;

    if (auto binary = std::dynamic_pointer_cast<IR::BinaryInst>(midEnd_inst)) {

    } else if (auto icmp =
                   std::dynamic_pointer_cast<IR::ICMPInst>(midEnd_inst)) {

    } else if (auto fcmp =
                   std::dynamic_pointer_cast<IR::FCMPInst>(midEnd_inst)) {

    } else if (auto ret = std::dynamic_pointer_cast<IR::RETInst>(midEnd_inst)) {

    } else if (auto br = std::dynamic_pointer_cast<IR::BRInst>(midEnd_inst)) {

    } else if (auto call =
                   std::dynamic_pointer_cast<IR::CALLInst>(midEnd_inst)) {

    } else if (auto zext =
                   std::dynamic_pointer_cast<IR::ZEXTInst>(midEnd_inst)) {

    } else if (auto bitcast =
                   std::dynamic_pointer_cast<IR::BITCASTInst>(midEnd_inst)) {
        ///
    } else if (auto alloca =
                   std::dynamic_pointer_cast<IR::ALLOCAInst>(midEnd_inst)) {

    } else if (auto load =
                   std::dynamic_pointer_cast<IR::LOADInst>(midEnd_inst)) {
    } else if (auto store =
                   std::dynamic_pointer_cast<IR::STOREInst>(midEnd_inst)) {

    } else if (auto gep = std::dynamic_pointer_cast<IR::GEPInst>(midEnd_inst)) {

    } else if (auto phi = std::dynamic_pointer_cast<IR::PHIInst>(midEnd_inst)) {
        ///
    } else {
        assert(false && "instruction casting failed!\n");
    }

    return inst;
}