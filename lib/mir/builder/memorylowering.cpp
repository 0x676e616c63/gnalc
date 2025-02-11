#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/binary.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include "../../../include/mirtools/tool.hpp"

using namespace MIR;

std::list<std::shared_ptr<Instruction>>
InstLowering::allocaLower(const std::shared_ptr<IR::ALLOCAInst> &alloca) {
    std::list<std::shared_ptr<Instruction>> insts;
    unsigned long long size;
    size = alloca->getBaseType()->getBytes();

    auto target = operlower.mkStackOP(*alloca, size);

    return insts; // empty
}

std::list<std::shared_ptr<Instruction>>
InstLowering::loadLower(const std::shared_ptr<IR::LOADInst> &load) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = load->getPtr();
    auto target = operlower.mkOP(*load, RegisterBank::gpr);

    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        // mov %relay, #upper:global #lower:global
        // ldr %target, [%relay]
        auto relay = operlower.mkBaseOP(global_ptr->getName(), nullptr);

        auto global_addr = operlower.fastFind(global_ptr->getName());

        auto mov =
            std::make_shared<movInst>(SourceOperandType::a, relay, global_addr);

        auto ldr =
            std::make_shared<ldrInst>(SourceOperandType::a, 4, target, relay);
        insts.emplace_back(mov);
        insts.emplace_back(ldr);
    } else {
        // ldr %target, [%...]
        auto addr =
            std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(ptr));
        auto ldr =
            std::make_shared<ldrInst>(SourceOperandType::a, 4, target, addr);
        insts.emplace_back(ldr);
    }
    return insts;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::storeLower(const std::shared_ptr<IR::STOREInst> &store) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = store->getPtr();
    auto target = operlower.mkOP(*store, RegisterBank::gpr);

    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        auto relay = operlower.mkBaseOP(global_ptr->getName(), nullptr);

        auto global_addr = operlower.fastFind(global_ptr->getName());

        auto mov =
            std::make_shared<movInst>(SourceOperandType::a, relay, global_addr);

        auto str =
            std::make_shared<strInst>(SourceOperandType::a, 4, target, relay);
        insts.emplace_back(mov);
        insts.emplace_back(str);
    } else {
        auto addr =
            std::dynamic_pointer_cast<BaseADROP>(operlower.fastFind(ptr));
        auto str =
            std::make_shared<ldrInst>(SourceOperandType::a, 4, target, addr);
        insts.emplace_back(str);
    }
}

std::list<std::shared_ptr<Instruction>>
InstLowering::gepLower(const std::shared_ptr<IR::GEPInst> &gep) {
    std::list<std::shared_ptr<Instruction>> insts;
    auto ptr = gep->getPtr();
    auto idx = gep->getIdxs()[1];
    int perElemSize =
        std::dynamic_pointer_cast<IR::ArrayType>(gep->getBaseType())
            ->getElmType()
            ->getBytes();

    /// 一共四种情况, ptr是否是全局变量, idx是否是常量

    std::shared_ptr<BaseADROP> baseOP;
    if (auto global_ptr = std::dynamic_pointer_cast<IR::GlobalVariable>(ptr)) {
        auto pair = operlower.LoadedFind(global_ptr->getName());
        if (pair.first)
            baseOP = std::dynamic_pointer_cast<BaseADROP>(pair.second);
        else {
            /// 加mov
            auto relay = std::dynamic_pointer_cast<BaseADROP>(pair.second);

            auto global_addr = operlower.fastFind(global_ptr->getName());

            auto mov = std::make_shared<movInst>(SourceOperandType::a, relay,
                                                 global_addr);
            insts.emplace_back(mov);
            baseOP = relay;
        }

        if (auto const_idx = std::dynamic_pointer_cast<IR::ConstantInt>(idx)) {
            auto add_offset = const_idx->getVal() * perElemSize;
            operlower.mkBaseOP(*gep, baseOP, add_offset);
        } else {
            // mul %temp1, %var_idx, #imme (带优化)
            // add (%BindOnVirOP)temp2, %(BindOnVirOP)baseOP, %temp1
            auto relay2 = operlower.mkBaseOP(*gep, baseOP, 0);
            auto var_idx = operlower.fastFind(idx);

            auto relay = operlower.mkOP(IR::makeBType(IR::IRBTYPE::I32),
                                        RegisterBank::gpr);
            auto mul_midEnd = std::make_shared<IR::BinaryInst>(
                relay->getName(), IR::OP::MUL, idx,
                std::make_shared<IR::ConstantInt>(perElemSize));

            insts.splice(insts.end(), binaryLower(mul_midEnd)); // 复用
        }
    }

    return insts;
}