#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"
#include <cassert>

using namespace MIR;

std::list<std::shared_ptr<Instruction>>
InstLowering::brLower(const std::shared_ptr<IR::BRInst> &br) {
    std::list<std::shared_ptr<Instruction>> insts{};

    if (!br->isConditional()) {
        // b label
        auto Dest = br->getDest();
        auto b_true =
            std::make_shared<branchInst>(OpCode::B, Dest, Dest->getName());
        insts.emplace_back(b_true);
    } else {
        auto cond = br->getCond();
        auto trueDest = br->getTrueDest();
        auto falseDest = br->getFalseDest();

        // teq (BindOnVirOP)cond, (BindOnVirOP)cond
        // b<cond> label_true
        // b<inverse_cond> label_false
        auto boolVal =
            std::dynamic_pointer_cast<BindOnVirOP>(operlower.fastFind(cond));
        auto teq = std::make_shared<compareInst>(
            OpCode::TEQ, SourceOperandType::rr, boolVal, boolVal);
        auto b_true = std::make_shared<branchInst>(OpCode::B, trueDest,
                                                   trueDest->getName());
        b_true->setCondCodeFlag(CondCodeFlag::eq);
        auto b_false = std::make_shared<branchInst>(OpCode::B, falseDest,
                                                    falseDest->getName());
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::retLower(const std::shared_ptr<IR::RETInst> &ret) {
    std::list<std::shared_ptr<Instruction>> insts{};

    auto retType = ret->getRetBType();
    auto retVal = operlower.fastFind(ret->getRetVal());

    if (retType != IR::IRBTYPE::FLOAT) {
        // mov $r0, %retVal
        auto mov = std::make_shared<movInst>(
            SourceOperandType::i, operlower.getPreColored(CoreRegister::r0),
            retVal);
        insts.emplace_back(mov);
    } else {
        // SIMD
    }

    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::callLower(const std::shared_ptr<IR::CALLInst> &call) {
    std::list<std::shared_ptr<Instruction>> insts{};

    auto functype =
        std::dynamic_pointer_cast<IR::FunctionType>(call->getFunc()->getType());

    /// to be continued

    return insts;
}