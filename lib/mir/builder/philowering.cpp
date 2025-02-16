#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/copy.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>> InstLowering::phiLower(const std::shared_ptr<IR::PHIInst> &phi) {
    /// @note 指令选择阶段会保留Phi的形式
    std::list<std::shared_ptr<Instruction>> insts;

    std::shared_ptr<BindOnVirOP> target;

    /// @brief 选寄存器组
    if (auto btype = std::dynamic_pointer_cast<IR::BType>(phi->getType())) {
        if (btype->getInner() == IR::IRBTYPE::I32) {
            target = operlower.mkOP(*phi, RegisterBank::gpr);
        } else if (btype->getInner() == IR::IRBTYPE::FLOAT) {
            target = operlower.mkOP(*phi, RegisterBank::spr);
        } else {
            Err::unreachable("phiLower: target value with unknown btype");
        }
    } else if (auto ptrtype = std::dynamic_pointer_cast<IR::PtrType>(phi->getType())) {
        /// @note 尾递归处理成循环之后可能会有指针的 phi，因为函数参数可能会有指针
        target = operlower.mkBaseOP(*phi);
    } else {
        Err::unreachable("phiLower: unknown type");
    }

    auto PhiOpers = phi->getPhiOpers();
    std::vector<PhiOper> phioperList;
    for (const auto &midEnd_oper : PhiOpers) {
        auto value = operlower.fastFind(midEnd_oper.value); // 可能是一个常数
        auto oper = PhiOper(value, midEnd_oper.block->getName());

        phioperList.push_back(oper);
    }

    auto phiInst = std::make_shared<PHI>(target, phioperList);
    insts.emplace_back(phiInst);
    return insts;
}