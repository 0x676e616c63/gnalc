#include "mir/builder/lowering.hpp"
#include "mir/instructions/copy.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>> InstLowering::phiLower(const std::shared_ptr<IR::PHIInst> &phi,
                                                               const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;

    std::shared_ptr<BindOnVirOP> target;

    // target = std::dynamic_pointer_cast<BindOnVirOP>(operlower.search_phi(*phi));
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
        /// @note 尾递归处理成循环之后可能会有指针的 phi，因为函数参数可能会有指针(#Rt)
        target = operlower.mkBaseOP(*phi);
    } else {
        Err::unreachable("phiLower: unknown type");
    }

    auto PhiOpers = phi->getPhiOpers();
    std::vector<PhiOper> phioperList;
    for (const auto &midEnd_oper : PhiOpers) {
        // 可能是一个常数, 一个虚拟寄存器, 或者找不到(存在循环的CFG中极有可能)
        // 所以这里暂时存中断IR, 在phi消除中转为MIR
        auto oper = PhiOper(midEnd_oper.value, midEnd_oper.block->getName());

        phioperList.push_back(oper);
    }

    auto phiInst = std::make_shared<PHI>(target, phioperList);
    insts.emplace_back(phiInst);
    return insts;
}